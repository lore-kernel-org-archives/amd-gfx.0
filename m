Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E838CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 09:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F1C611C9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 09:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1F1C611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F8D6E466;
	Wed, 10 Nov 2021 09:39:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 318BC6E466
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 09:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIVzF+tK1m/8QmnucF541xMjGOFGxPnJXW07qqeZXKybLyR44cAOP2JIUDsI1ft1gc6Bt2CstNis6j09O5wctHAc7CQRwdrax9MA73vUBG47bqcqi8O6PizlDQhaQtHyMJ4kipXQc5zstZlX1y7WQRFKM7v7y80H25f7KVDQ9oMGrZN8fIvhPCTc+uwTazF9R6xUzN3vdfFOgNxyM2y4/BmdFF/0t4VdJ2OvNFwHVxZWmY8IZvnKknR6gQo+wqQkjdD/boav8yAEKxq4+MROPjY1NdoBL2iyEp0hfQMwNh5krgPAYkR5ldRiwofnxLfRCy+HNUSCCdLg+DX/COkBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=752QA41StEbave5HeUOByfzCJanbYCfIpRUTIz8zfdk=;
 b=LdJRg5LCwM7o9QcjRYR9jIxutM2/m2NB1UdEkhsgt26u0eZSU8Y9nDBROJ6gvZLLBS9qvord8R1WV2BTLCu3ahy27BxgnEmkI4rki6X9j/5ZOALdrgYH34fm7FTnxCG8WVLtEPAahRiyPfMRLOgTI9EP5AA1jbiqAROJsanYEsELzBoQaIzq2qpBlKrwAGYhsQuuQWS57MBsBdglD3G11ioGIUA/21ppmfvB2uqG/AyDhvG4w9cYZrFGO3YG/Zneffw6R4g8wXx/z8edHMUg+cyaJ7oUtPzrLhG4YZPD/JvEfZ6xv0DhbNJpiukq9v34djyAFBW8RYlCwb1E0sozWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=752QA41StEbave5HeUOByfzCJanbYCfIpRUTIz8zfdk=;
 b=yGrkskXNllxJZayFOIGrDopiC27y6i29E4o+79np7TSUm1ipNyvTvpu8kdWpryXtuYzEkD7EA0PK/5aHqJpgFRdzmFEmQ9gDQM1QokcSEf3WfHvWi+dHVOEjPlyjwaex8AxL5bbSH+1s8nh4zeCdukfzhPjzb7aYXzgqB3NZVOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 10 Nov
 2021 09:39:41 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 09:39:41 +0000
Message-ID: <9f9f5f93-902a-8c66-adba-f1ed9e2659e4@amd.com>
Date: Wed, 10 Nov 2021 15:09:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211108044723.54716-1-evan.quan@amd.com>
 <80a7b1d5-f57c-ef32-bd90-9e31554127e2@amd.com>
 <DM6PR12MB26198F33A0A6BC4C760ACD7AE4929@DM6PR12MB2619.namprd12.prod.outlook.com>
 <87848118-a230-1941-f97d-384158dc95d6@amd.com>
 <DM6PR12MB261902AEC570A67EE98FE516E4929@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB261902AEC570A67EE98FE516E4929@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0115.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::31)
 To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN1PR01CA0115.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16 via Frontend Transport; Wed, 10 Nov 2021 09:39:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 961a5cc8-e4ff-4f38-e99c-08d9a42e04fc
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2602AF7558B13C019E7D8AD497939@DM6PR12MB2602.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWJ2xwGBmP1+tqQTjXXA3YiGdAPir4gLjeGapnCZFP/mBY737bBjzfvOq+vutpE8/Mlne3TthXqIJpVhxCbTrwCGXz5KGXkND5jB4QN36LcOrvaEbX3k8v5blxATc/vaJ+uiS0jKAlbOwm2aaGMpmVm2GpwF7oq3mRDbV48sTjEPdBXjwuf8aXFhFaH+uO15UjDiObPkYrip2aXQb5IOedg8i+HmTjt+qCopF1EAUEDPdt86tnzkpEbWcM71XvLDcGRhHDuHlaFwopW2s7WfoBmaQGzO0V+z5J3z7m68gt5HIvD1dpG+PTeB3tWZu1hEXBUkLelOE5WC9Att9QVE1JKxPwjKpctafJPNfHXH/ZrcKsqNOVlt7d9VJaSKrh2vbZXsRYLewlFszgyKmldkoqnQAbMI0jHI154pk6hMWwJrO1xXxMKF8lBhMSTSmJyvYisgNK2vox2J2e+7XxP5oTyo59+ZlB2K6lIyBxE8rbhVCCw6/SkRhn4exph7Nb7O3pqjLi7XmcY5a+Pxl4mvBsoJ9+cyIsHg6ENBlIfRgpcpEhVRHstkLyh94lT6xRwMKn0acI+a67hy7GQqRX5IG1MVpzH80NPND0eVZ3whqBlQeHn31vGM40Tq0bFvrH7WtPl5J+JdsoWQZfZX/AqczYuU/OwIVydWXHhhMXH6hfreVk/pYWXhPF/bnRpC5V6RVHRxQof9RFdVj3SGjhWG6PUyckqK6VJspdM2qNPW+cQGxAvqW/Q99TbVnKeAnN4LF7l+Z/Z237kuRRxpbexI4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(16576012)(83380400001)(66556008)(38100700002)(2906002)(66476007)(316002)(956004)(86362001)(2616005)(66946007)(5660300002)(31696002)(186003)(8676002)(26005)(53546011)(508600001)(36756003)(54906003)(8936002)(31686004)(6486002)(4326008)(110136005)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a016N2RUMlhTYTVlK1NrYWxrQ1I1VUk2NkZXV0FoY00xM2dORHNwOWgvQ3Yr?=
 =?utf-8?B?RGRpajJSYjNxVkxXR2g4TDZ5VlVWclVZSWUvc2taajByQk1mcE9ZejdtOWlV?=
 =?utf-8?B?aytoNjZqWnNJK1dQSkZSS2V2a1F5M2Jpd0Eyb1BIamhBeEgyL1cyaTlmWklQ?=
 =?utf-8?B?cU9heFNmYlVCcEtQcUtZQ010a3NvWHNIeXJmUUxjMFcwLzhhZE9kd3JibTh4?=
 =?utf-8?B?T2pMMy8ybGE0ZnltdWJaQm1NRk1JY2VrRGRvWWI1Y1BDZmpKZlZHT3gzVnI4?=
 =?utf-8?B?MFJaNEltZlJkL1c2cEZqWVhHVDRYMkp4MzU5SUtUT1p6dGo3Q2p6MmllS1kw?=
 =?utf-8?B?TjJ4RDFkM0I3RDJIRUxockRpd3M2OXlhS0dCcnRtN3Vqdk5Qc2NJckZiQ2g3?=
 =?utf-8?B?d1QwWm12NkxMeWdMbW4rUFc1UzJCcWdlRzNaY0ZtRHo4WG1JalZSRjVpVzVw?=
 =?utf-8?B?ZVJXSThUWm5FNllGMHVaVjg1L1h1QTJZME9pQnNFakxMTWlRQ3c4SVZtUXpQ?=
 =?utf-8?B?T0NSaVdqYzRyZGdpNkdxSFZUZlY0NW9aUU10Qk84bTdsN2F3TVFDN0wrZGpC?=
 =?utf-8?B?a0tmTnlveHBKajVETlMxaFloMm9Kb1VWWTFQVFpKMHpPdElJenpJQ0ZCcHFT?=
 =?utf-8?B?NlRDV2tRb0llaWxaWXBsNTFURjdQY3NISmtIcXIvSWZiV2g3bXNuZG5KWkRN?=
 =?utf-8?B?SEl3d3ZDTnFKR3J4Uy9Da0VERVhoUHIzaHZNVmo0RHZPV2RrVXY2ZkozY0x5?=
 =?utf-8?B?R1JheG9ubGVrVWxrZXN1dVZJaWpPUjZPRk9ROS90alVKR0gxdGNiNVVVTjBM?=
 =?utf-8?B?cENGdjVvNlI2N3FpTlRReVhybFl2YzliN1JiYjRvMDNjYUlwK0ZsVTJSRnZp?=
 =?utf-8?B?L0pndDVKdEpEb1FiWW5NaVVRT0I3bkxBdW94cXFZc2w4OVRzRGs5MklxZ0x6?=
 =?utf-8?B?QVQrYk0xWkV6N0dRYXVhb09rbi9PcktDZU4zSm9DMkpYVHYwYVgwM3Btd1po?=
 =?utf-8?B?dEM5T2E4RUd3M1QzZDhOMktiaHhiTCtlT3JOSDkvcTljTlNQcURBMnozR0N6?=
 =?utf-8?B?dTMwd2xXbFQ5eHVQMCtDc09PalNrZzdzbWh0SS9xb0NOc0VkRDB5eWlZMnpJ?=
 =?utf-8?B?cUN6dzhCcXRvQjlzUmJ3dDBrSmFvd0Rwb2xhUVFEcVZYcFNsYjlIaFUwTjZw?=
 =?utf-8?B?QmpWN0VtM25UVC93MXhIVkdyVURrMlRDTFRYMTFPeHNCRzVUOXdkVklFcGtH?=
 =?utf-8?B?OWxzRHREdmRpbk1BYXJ1RGZ3SVRkL1BpK2orejJrM0lIejFEMEpRQTV2T044?=
 =?utf-8?B?YlBiK0JBeGJlekVnWHRYSS80ZDNxdU5uZnlsN3ZGMzVjUU5Kek5ESmpVeFIy?=
 =?utf-8?B?dnA3by84Q2lXUHc0ekpFbndHMEc5a05WbmphWlJad0lZL3dvOHp3TVY1dGJJ?=
 =?utf-8?B?d1FTUUZGOXhkZkp6Z1NXcE5xMUlIcEN1T0lZTStOZlZuTmFvTmpIZ2R3ejZ6?=
 =?utf-8?B?dXFtMzJ2c29GRm1XL1hIK2hRRnU2bXhtdk91TnhxVVJuazZ5UG9CejRWRHgz?=
 =?utf-8?B?SW5QbGVzRW9pUHM1TDUvYkpMTlFONzFmWE1ySnp3RktlRmZabE1tMkRJYzFL?=
 =?utf-8?B?TjRZN0tXTU4yQlZ0d3FENkR4UldRT2NxdzhnMGFKWHprbnh6ZHJ4OUlsTzc5?=
 =?utf-8?B?ZXNkQWtLK2xER2dwWitseXJwQzN0MDhsRjNHeTYraHNnK0dxazVBSlJLSXBN?=
 =?utf-8?B?ZERod1lqazFYajVUWGlyTTB1ZFNGMHdOOWhPeWh4WlhrN1FyMWlCMUM2MWNU?=
 =?utf-8?B?dnlhY1NIVDlvZFpZanJ6TitDc3hWOFk4VWZ1NWlrTnlWcG1NZFBDN3V0MFdx?=
 =?utf-8?B?WkZqTVdDNW4rWFFMRi9XdThlLzhoTm5odkRnMTc1V0NVOExsS29mZW5seExw?=
 =?utf-8?B?aTFuTjlWU05kSksyUG1Ucjg0UW9jdFd1aElwcHZkRCtjeWN3UGgzUGN6cHV3?=
 =?utf-8?B?WjQzV2lpTGxLQVpFQ1FrZFlVejhpQTdXNlJuVVNURS9iUFR4SEVrblFucHNr?=
 =?utf-8?B?V0xpUmQ0Wkc5SjlKSHg1endZZ1ZIeG1RQkMvblpONU5BM3hLbEh0OEgvY2NR?=
 =?utf-8?Q?rPa0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961a5cc8-e4ff-4f38-e99c-08d9a42e04fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 09:39:41.2298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLhD3TnCiszOzRtkz/G0u+5DcHqCQ/Ox1aDi2zg1D9eWDva+5bllqA5kOdo2+44e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2602
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Borislav Petkov <bp@suse.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/9/2021 2:15 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, November 9, 2021 12:15 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Borislav Petkov
>> <bp@suse.de>
>> Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate
>> setting
>>
>>
>>
>> On 11/9/2021 9:10 AM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Monday, November 8, 2021 7:16 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Borislav Petkov
>>>> <bp@suse.de>
>>>> Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate
>>>> setting
>>>>
>>>>
>>>>
>>>> On 11/8/2021 10:17 AM, Evan Quan wrote:
>>>>> Just bail out if the target IP block is already in the desired
>>>>> powergate/ungate state. This can avoid some duplicate settings which
>>>>> sometime may cause unexpected issues.
>>>>>
>>>>> Change-Id: I66346c69f121df0f5ee20182451313ae4fda2d04
>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>> Tested-by: Borislav Petkov <bp@suse.de>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  7 +++++++
>>>>>     drivers/gpu/drm/amd/include/amd_shared.h         |  3 ++-
>>>>>     drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 13 ++++++++++++-
>>>>>     drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  3 +++
>>>>>     drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c        |  3 +++
>>>>>     drivers/gpu/drm/amd/pm/powerplay/si_dpm.c        |  3 +++
>>>>>     drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        |  3 +++
>>>>>     7 files changed, 33 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index b85b67a88a3d..19fa21ad8a44 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -767,9 +767,16 @@ enum amd_hw_ip_block_type {
>>>>>     #define HW_ID_MAX		300
>>>>>     #define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) |
>>>>> (rv))
>>>>>
>>>>> +enum amd_ip_powergate_state {
>>>>> +	POWERGATE_STATE_INITIAL,
>>>>> +	POWERGATE_STATE_GATE,
>>>>> +	POWERGATE_STATE_UNGATE,
>>>>> +};
>>>>> +
>>>>
>>>> To reflect the current state, they could be named like
>>>> POWERGATE_STATE_UNKNOWN/ON/OFF.
>>> [Quan, Evan] This may be more confusing. POWERGATE_STATE_ON means
>> "gfx on" or "gate on which means gfx off"?
>>
>> What I meant is -
>> 	PG_STATE_ON - Power gated
>> 	PG_STATE_OFF - Not power gated
> [Quan, Evan] Yeah, but I mean other user may be confusing about these. Since when we take about the PG state, we usually use "Gate" or "Ungate". How about POWER_STATE_ON - Power on/ungate
> POWER_STATE_OFF - Power off/gate ?
> 
Yes, that looks fine.

Thanks,
Lijo

> BR
> Evan
>> Thanks,
>> Lijo
>>
>>>>
>>>>
>>>>>     struct amd_powerplay {
>>>>>     	void *pp_handle;
>>>>>     	const struct amd_pm_funcs *pp_funcs;
>>>>> +	atomic_t pg_state[AMD_IP_BLOCK_TYPE_NUM];
>>>>
>>>> Maybe add another field in amdgpu_ip_block_status? Downside is it
>>>> won't reflect the PG state achieved through paths other than PMFW
>>>> control and ipblock needs to be queried through
>>>> amdgpu_device_ip_get_ip_block()
>>> [Quan, Evan] Yes, we will need to track pg state other than PMFW control
>> then.
>>> That will need extra effort and seems unnecessary considering there is no
>> such use case(need to know the PG state out of PMFW control).
>>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>     };
>>>>>
>>>>>     /* polaris10 kickers */
>>>>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
>>>> b/drivers/gpu/drm/amd/include/amd_shared.h
>>>>> index f1a46d16f7ea..4b9e68a79f06 100644
>>>>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>>>>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>>>>> @@ -98,7 +98,8 @@ enum amd_ip_block_type {
>>>>>     	AMD_IP_BLOCK_TYPE_ACP,
>>>>>     	AMD_IP_BLOCK_TYPE_VCN,
>>>>>     	AMD_IP_BLOCK_TYPE_MES,
>>>>> -	AMD_IP_BLOCK_TYPE_JPEG
>>>>> +	AMD_IP_BLOCK_TYPE_JPEG,
>>>>> +	AMD_IP_BLOCK_TYPE_NUM,
>>>>>     };
>>>>>
>>>>>     enum amd_clockgating_state {
>>>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> index 03581d5b1836..a6b337b6f4a9 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> @@ -927,6 +927,14 @@ int
>>>> amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>>>> uint32_t block
>>>>>     {
>>>>>     	int ret = 0;
>>>>>     	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>>> +	enum amd_ip_powergate_state pg_state =
>>>>> +		gate ? POWERGATE_STATE_GATE :
>>>> POWERGATE_STATE_UNGATE;
>>>>> +
>>>>> +	if (atomic_read(&adev->powerplay.pg_state[block_type]) ==
>>>> pg_state) {
>>>>> +		dev_dbg(adev->dev, "IP block%d already in the target %s
>>>> state!",
>>>>> +				block_type, gate ? "gate" : "ungate");
>>>>> +		return 0;
>>>>> +	}
>>>>>
>>>>>     	switch (block_type) {
>>>>>     	case AMD_IP_BLOCK_TYPE_UVD:
>>>>> @@ -976,9 +984,12 @@ int
>>>> amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>>>> uint32_t block
>>>>>     		}
>>>>>     		break;
>>>>>     	default:
>>>>> -		break;
>>>>> +		return -EINVAL;
>>>>>     	}
>>>>>
>>>>> +	if (!ret)
>>>>> +		atomic_set(&adev->powerplay.pg_state[block_type],
>>>> pg_state);
>>>>> +
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>>>> index bba7479f6265..8d8a7cf615eb 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>>>> @@ -38,6 +38,7 @@ static const struct amd_pm_funcs pp_dpm_funcs;
>>>>>     static int amd_powerplay_create(struct amdgpu_device *adev)
>>>>>     {
>>>>>     	struct pp_hwmgr *hwmgr;
>>>>> +	int i;
>>>>>
>>>>>     	if (adev == NULL)
>>>>>     		return -EINVAL;
>>>>> @@ -57,6 +58,8 @@ static int amd_powerplay_create(struct
>>>> amdgpu_device *adev)
>>>>>     	hwmgr->display_config = &adev->pm.pm_display_cfg;
>>>>>     	adev->powerplay.pp_handle = hwmgr;
>>>>>     	adev->powerplay.pp_funcs = &pp_dpm_funcs;
>>>>> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
>>>>> +		atomic_set(&adev->powerplay.pg_state[i],
>>>> POWERGATE_STATE_INITIAL);
>>>>>     	return 0;
>>>>>     }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>>> b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>>>> index bcae42cef374..f84f56552fd0 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>>>> @@ -2965,9 +2965,12 @@ static int kv_dpm_get_temp(void *handle)
>>>>>     static int kv_dpm_early_init(void *handle)
>>>>>     {
>>>>>     	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>> +	int i;
>>>>>
>>>>>     	adev->powerplay.pp_funcs = &kv_dpm_funcs;
>>>>>     	adev->powerplay.pp_handle = adev;
>>>>> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
>>>>> +		atomic_set(&adev->powerplay.pg_state[i],
>>>> POWERGATE_STATE_INITIAL);
>>>>>     	kv_dpm_set_irq_funcs(adev);
>>>>>
>>>>>     	return 0;
>>>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
>>>> b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
>>>>> index 81f82aa05ec2..f1eb22c9bb59 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
>>>>> @@ -7916,9 +7916,12 @@ static int si_dpm_early_init(void *handle)
>>>>>     {
>>>>>
>>>>>     	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>> +	int i;
>>>>>
>>>>>     	adev->powerplay.pp_funcs = &si_dpm_funcs;
>>>>>     	adev->powerplay.pp_handle = adev;
>>>>> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
>>>>> +		atomic_set(&adev->powerplay.pg_state[i],
>>>> POWERGATE_STATE_INITIAL);
>>>>>     	si_dpm_set_irq_funcs(adev);
>>>>>     	return 0;
>>>>>     }
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> index 01168b8955bf..fdc25bae8237 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> @@ -627,6 +627,7 @@ static int smu_early_init(void *handle)
>>>>>     {
>>>>>     	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>     	struct smu_context *smu = &adev->smu;
>>>>> +	int i;
>>>>>
>>>>>     	smu->adev = adev;
>>>>>     	smu->pm_enabled = !!amdgpu_dpm;
>>>>> @@ -639,6 +640,8 @@ static int smu_early_init(void *handle)
>>>>>
>>>>>     	adev->powerplay.pp_handle = smu;
>>>>>     	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
>>>>> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
>>>>> +		atomic_set(&adev->powerplay.pg_state[i],
>>>> POWERGATE_STATE_INITIAL);
>>>>>
>>>>>     	return smu_set_funcs(adev);
>>>>>     }
>>>>>
