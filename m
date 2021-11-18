Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE53C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 00:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D3C6152B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 00:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22D3C6152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 839C86E12B;
	Thu, 18 Nov 2021 00:22:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829086E12B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 00:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJYOGmC/109aSvjSAG2SSy7hZZPn66QKjVIr8OLEy3GaU2Vi71zMNukZk64wZ5we7Eh4ZsSu2OL3HyhBHMQ0y6QKXRPqyCDABxrC4DTdOj4Ge7Ebg/vuFSA2vQ9ju8Vy38lC4k2jV4LyJYRVDMt+CHm7T1yJkPquTYdvlgxafUhdVendVnuKZfrHj6DfktDHRFLbb0lYt4gnpLA8v0ssVD29yssRqjuQiauLFbkX4bWAtyljbJrhfaRQDj/HHFDPaKlJOeCMj1k9Dob9/n6UxzmyZL7jDQwRrsy5TafohBUAT/XXBGSn5Gg/jHLMmTErETRo969HzNCG3gVFosqPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRNtKgQqBAe8pRCiRHJ8wIon3Ivl4wXxwhj8i8i/9z8=;
 b=PvD3uY5bitqiLcthCaXtkhio0xVHUDI+l5+VzWE9i0YrE13dPOSCHJyI0GFWmpCuHCsoD7agsCjQN88/1zpUz+/sAx4CxyX31JEwQOgFNULTACMwYI10UXADAJlLp1iGyG5o89nS9psPqYmsn+r37IVd10GliEZaIgIes6qYA5ZWTbJ8dqFeoi/TZ5TBUHOnoEWCv5XjPLWpFnVfET5hLAHjXV2g8fq75bRyXDo9hHBFM5fHDyNpXTQ6AOk7pmihBeLwR4E/ioGWjRDG34cXOxbCZBBv+UWtG4W2GdXhyekRXO9sZD8u7eGQzITnWH27OWI0dntr6zVC1ItwO29QEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRNtKgQqBAe8pRCiRHJ8wIon3Ivl4wXxwhj8i8i/9z8=;
 b=SfRp9S/Y/NuNC9DkK9jVxQ2tc6/oACDhaN57Obatj1TS/7F459ZV+GE4tYE/h6FujqJ6wVLoqyoi4am8je3b8aSrvKkLEm2/AP3X/AaXtCeMmF7kkzo/TPAQwcZ/+Iec47sSWtUeh3jb+Mz9RH3+w3V5AI7GwWcfOZaGZOm2YtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Thu, 18 Nov
 2021 00:22:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.021; Thu, 18 Nov 2021
 00:22:07 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV
From: Felix Kuehling <felix.kuehling@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211110023052.1872623-1-Felix.Kuehling@amd.com>
 <48473282-292c-508a-1a4e-42359c421f01@amd.com>
 <dd7f5e89-338b-c331-829e-5fba0594a0cb@amd.com>
 <DM6PR12MB39307C2E18445AA344F9930F97939@DM6PR12MB3930.namprd12.prod.outlook.com>
 <2d6f7194-bf4a-4bb9-b751-fe80ecc4e55b@amd.com>
Organization: AMD Inc.
Message-ID: <5d1f3790-00b1-c310-7257-1f24f7ad58a1@amd.com>
Date: Wed, 17 Nov 2021 19:22:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <2d6f7194-bf4a-4bb9-b751-fe80ecc4e55b@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BL1P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 BL1P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21 via Frontend Transport; Thu, 18 Nov 2021 00:22:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45450c25-875e-49a1-1613-08d9aa297400
X-MS-TrafficTypeDiagnostic: BN9PR12MB5130:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5130F607D5E947A060871427929B9@BN9PR12MB5130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ycdgLPWW8xD5/yoPSFqxIIyVFY44VYgZ+yNNTcxiO9YtEbPu48j1Tkb+mm6rlI9kfdvAtjxm4rgYImqI62eqBGG+/J01wBS/l6QJV32vxqeXd+7VV4aMm79PwIVZFB9LEUPo779uSK5ZMA3E/9NFbZm63gTeKcqexgxBm0uGd9UlN+LAKW2uwK5jqvdesKIWQAnW10RGXL6UZkT9o414diqFVG3l0FYwzJQf4Fy609GUZsxbvxh/xLnM5V0tGCJJvEkTp5pixCNuBDheB53EgEWOqzC8Woa7OTcuYKcO/En+O27+l31KEtYkw0THmzTYs4ePU0DQquDl4s4Cy2YnGu8sPSsbuEnh18nSe77Cl7LXnLXc3DQ0uFRfh0Ivjs8BcJCwWS6tPusJjT+gLITFdzO8NLu6LkomaO2hoFnKCdMiJ5p/xhyrdCtE9hV2+JHN3XcQt7ql1ZfWnh2bu9Oy5bxTIUHfV9qs0Wd0mkHEhjyzKhll1Qu/HmHSlNqzuvEwDbFBUmZIJtoAAqh86mibUowHIcVyOerVCj3qtVPSVQ3oTM51tLvhwJZpmZm7mor79OSOw5WxMc9N4elUlG+DitUWwk6AnWN6rdp1e3Bz3hTEkIUEp7+XjGM9pbnvKDxLu5vqsgHG1kKaZUoN1ctJu/QoPzPm0G+0aMW92sd8JuQhsHu7EFt017pZ3jBAHEWmPEFSN/xHjhhWrQplOFb4/f+QA7OOSibFkCoelDV6UKcO5psKQd+U4V9NhCKYpJI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(66946007)(66476007)(66556008)(26005)(110136005)(44832011)(31696002)(508600001)(4326008)(36756003)(2906002)(36916002)(8676002)(6486002)(316002)(5660300002)(16576012)(38100700002)(8936002)(186003)(86362001)(83380400001)(2616005)(31686004)(4001150100001)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnYrSlVNRWp2NVFYcStjdEdUa2pXRUo2cVh0MllWU243cUdiZGNrUDNsdmJt?=
 =?utf-8?B?Z0lXaGJYSUVUNmpyL3pjb1hiUTFUQ1A0OWcxMFJRTHFqSWRpYlZ4ZjFycEtP?=
 =?utf-8?B?QnF3UElqSUtJc0M0K3NwenFQSlpDWXBVcVdzRWVRWDhvdnk2VVRyMlNBOFQ2?=
 =?utf-8?B?UGRDZWozeUhTekp5TnJqa2s3dXNQYlBQRVBFOFNkWmNUYVRZMlFyWEJFV2k0?=
 =?utf-8?B?Ymc5elpRN1NnODNubWlqOHZMSGRHL2FxRUxjUjlpWFZXTk84NGFYNkhkSUY4?=
 =?utf-8?B?bjBlVXpNYlVaeitGeWNFN1Q0WW9oM2xXd3d2ckV2OFRPejNoam5STGF1Y3Jr?=
 =?utf-8?B?UlA5YmJYNndBK2kxSzNSVHZkdWxzM2hObVQvcE5CdlBtU0V1eDd0V2NTUnBl?=
 =?utf-8?B?eS9JclIzTkdSZnBva1lSaXJFK0lDWjN5S1BvRlcwTFREbnBLajRmYkVTN3V4?=
 =?utf-8?B?YzRLQW91bzJreWVKdUwvRkd1VHFlY2xwSUlJc0hKcG11MFc5MEg0WEpEN2tV?=
 =?utf-8?B?UGRSNjJ0ZG1TOXF3Q1hYNWVkR2hjcHR0dU1ZTTdmR2M2Wm9PRzBhMzJESlFR?=
 =?utf-8?B?R0hXQ24yZm9UanQzYXh1SFhjQzBHRFE5dlo5L0gwTHllTHBkSGVyUnlaL0dU?=
 =?utf-8?B?UFNrd0t3eXhvbXZhMGtRMFV3c09Bemg3K0xyZXpzV0ZoYnIrY0pBZjZrQkUv?=
 =?utf-8?B?V2RUUXlLQU5WVDFDTENZYlp3MTE0azcvZlFOQlBNOHB3YStvWE9CYUVUTm03?=
 =?utf-8?B?T0Y5ZWkrNVNMZ1dIU2ZEc3JFZ1B4YWFoQVN2b0tmclpOMzZlUnN4YzNsK1Bl?=
 =?utf-8?B?eFJqejk3aEN6L2d3Y3Fzd0UxQVcyS09QaVkrM2hGV1dOUG8wNHNPc0c5MlRm?=
 =?utf-8?B?OXQ4MmN1N2ZOaW5nNjF1V0IyeFc5dnUzNTQreHBKMEF2UnMvY2VkbC9YcCtq?=
 =?utf-8?B?LzZFRkVXZFN6K0dHNE5ocEIrZWhQbnlvb3NTdm5iNjlUMlE4Sm80c1I1bWRZ?=
 =?utf-8?B?b0dLSjRBWXN2SWhwTkhYSjZKanNDc3ZUcEZaL0dVVHFuWmt1L3ZpekoyblBH?=
 =?utf-8?B?VlRmMC95Y2ZEUjhzcFVGU0FneXZ6MVFTUURpV2xMM0xRUnBlOE1ON0JqdDR6?=
 =?utf-8?B?MzB4eGFYMVlUeVF1WXRFZXVwYkdtQ05oMTMrRW4wQXk5Vzlqc1NydWRvckdI?=
 =?utf-8?B?QURLVFBXb1BWSGIxNFpUcHZ6ZW1LSlVPbUhzOHMvM3JqYTh0OHViK0FyMFds?=
 =?utf-8?B?dE03ZWc4TFFDQk4zS1VBUjdWTWFxR1ExV0wvd0FBWkFScXpZSGdxN0tRYnJo?=
 =?utf-8?B?TCs5VlZ5a3ZsdjNVUXQxN0FCMlgvb0J0SndJbzVRMmJrWVlOOUtKaE1CU2ox?=
 =?utf-8?B?K3Y3MElJZzBEbjZTMGV2M3J6dERvaGd3SjdLV0Z0QVRTSHpMTGQzRUppU1By?=
 =?utf-8?B?bDAyZTI4S05mOFpwU0xhZ25NR3VaWHpmemZmd1phUnRhN3JERnNIMGUvVWpE?=
 =?utf-8?B?QUVyaCtaSGtyNFVkRmVraHppMk1HRUUyazlmNWI0UG1ZdU4zcTlsUGpNOVhG?=
 =?utf-8?B?VHpGS2t0U0RNTjlnbTJmTENVM0p2WTg4bkhPNWFZNlBmcDFiTVRIMytxcXVv?=
 =?utf-8?B?REszNXVuY1U3VmVnNkRzS1oyeWF5ZXZ0WkdlMTdJS1ExZXM2RTlxcUhWWW1U?=
 =?utf-8?B?cWFPbzBROVV4UnMxODZhV0c0THhQTXpXbWFXZER5Qzg3cFhRcERzanJic1E3?=
 =?utf-8?B?SHdEd3dBd2lVUklXdGdheVd0ckxTa0tERXZyVDBTOEl1YmNmbkZ5cHkydDR2?=
 =?utf-8?B?REJDZzBXdU9LVnFxc0greWo3OXRPblc3RmlxL1Y2cTBBc3BUWkVIbFJONFAv?=
 =?utf-8?B?RzNXZkl3YUUxTUExRWNKN0pwTVFCaGJTR1N2WFRDWUw1MU9UMW84UkN6ektj?=
 =?utf-8?B?R1I3OXJuRG8rVjd2bFk3a1BrVUxYZ1BsYVJkTjNlZDRvN3dZTUhuS2c2Q3A1?=
 =?utf-8?B?R2ZaL0F3aDlqenBVY2Y3U1V0SGI5VTJRZ0RJRUlCWnF0VWRtb2JqQ1JZMGF0?=
 =?utf-8?B?R0tGMlhXKzg5d1owaEpoMFhrbDAwdEw2SEwxUUFUYXRidUorLzRrY251UWQ1?=
 =?utf-8?B?UGV3ZmR3Y3IzdVp3MmJVTlZxOS8vNmVtTi9LTXZySW5hdVhjTi9mMXFoQkZr?=
 =?utf-8?Q?2ar2w35FwWKFRRgO6p8TZ8o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45450c25-875e-49a1-1613-08d9aa297400
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 00:22:06.9639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3N06mrdRXY6Ywjky95wUqVa/GDauJV18vxJ9dpS5DWsxUSy11UY9ah3myTu0G1npVzK+fWOkzREf34pUHwLjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-10 11:34 a.m., Felix Kuehling wrote:
> Am 2021-11-10 um 11:11 a.m. schrieb Lazar, Lijo:
>> [Public]
>>
>>
>>> (... && !amdgpu_sriov_vf(adev))
>> This kind of closes the door for all versions. My thought was - having
>> it in the same function provides a logical grouping for how it's
>> handled for different cases - VF vs non-VF - for a particular IP version.
> Except that's not really true. There is still common code (setting
> adev->rmmio_remap.bus_addr) for handling MMIO remapping on VFs in
> soc15.c and nv.c. I'm not comfortable with duplicating all of that
> across all the IP version-specific files.
>
> I also think it's very unlikely that a small IP version bump is going to
> change this logic. So I'd rather prefer to keep the code more general
> and conservatively correct.

Hi Lijo,

The virtualization team has finished testing this patch and wants me to 
submit it. Do you insist I rework the patch to move all the 
adev->rmmio_remap fixups for virtualization into the nbio 
version-specific remap_hdp_registers functions?

Regards,
   Felix


>
> Regards,
>    Felix
>
>
>> Thanks,
>> Lijo
>> ------------------------------------------------------------------------
>> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
>> *Sent:* Wednesday, November 10, 2021 9:27:22 PM
>> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> <amd-gfx@lists.freedesktop.org>
>> *Cc:* Zhang, Bokun <Bokun.Zhang@amd.com>
>> *Subject:* Re: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV
>>   
>> Am 2021-11-10 um 4:14 a.m. schrieb Lazar, Lijo:
>>> On 11/10/2021 8:00 AM, Felix Kuehling wrote:
>>>> Disable HDP register remapping on SRIOV and set rmmio_remap.reg_offset
>>>> to the fixed address of the VF register for hdp_v*_flush_hdp.
>>>>
>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 4 ++++
>>>>    drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 4 ++++
>>>>    drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 4 +++-
>>>>    drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 4 ++++
>>>>    drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 4 +++-
>>>>    drivers/gpu/drm/amd/amdgpu/nv.c        | 8 +++++---
>>>>    drivers/gpu/drm/amd/amdgpu/soc15.c     | 8 +++++---
>>>>    7 files changed, 28 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>>>> b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>>>> index 4ecd2b5808ce..ee7cab37dfd5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>>>> @@ -359,6 +359,10 @@ static void nbio_v2_3_init_registers(struct
>>>> amdgpu_device *adev)
>>>>          if (def != data)
>>>>            WREG32_PCIE(smnPCIE_CONFIG_CNTL, data);
>>>> +
>>>> +    if (amdgpu_sriov_vf(adev))
>>>> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>>>> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>> Wouldn't it be better to do this assignment inside
>>> remap_hdp_registers()? Return with a comment saying no remap is done
>>> for VFs. That looks easier to manage per IP version.
>> I was considering that. I felt it was clearer not to have that hidden
>> side effect in remap_hdp_registers and to have the explicit condition
>> (... &&  !amdgpu_sriov_vf(adev)) around the remap_hdp_registers call in
>> soc15/nv_common_hw_init.
>>
>> Regards,
>>    Felix
>>
>>
>>> Thanks,
>>> Lijo
>>>
>>>>    }
>>>>      #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT        0x00000000
>>>> // off by default, no gains over L1
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>>>> b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>>>> index 0d2d629e2d6a..4bbacf1be25a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>>>> @@ -276,6 +276,10 @@ static void nbio_v6_1_init_registers(struct
>>>> amdgpu_device *adev)
>>>>          if (def != data)
>>>>            WREG32_PCIE(smnPCIE_CI_CNTL, data);
>>>> +
>>>> +    if (amdgpu_sriov_vf(adev))
>>>> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>>>> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>>>    }
>>>>      static void nbio_v6_1_program_ltr(struct amdgpu_device *adev)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>>>> index 3c00666a13e1..37a4039fdfc5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>>>> @@ -273,7 +273,9 @@ const struct nbio_hdp_flush_reg
>>>> nbio_v7_0_hdp_flush_reg = {
>>>>      static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
>>>>    {
>>>> -
>>>> +    if (amdgpu_sriov_vf(adev))
>>>> +        adev->rmmio_remap.reg_offset =
>>>> +            SOC15_REG_OFFSET(NBIO, 0,
>>>> mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>>>    }
>>>>      const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>>>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>>>> index 8f2a315e7c73..3444332ea110 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>>>> @@ -371,6 +371,10 @@ static void nbio_v7_2_init_registers(struct
>>>> amdgpu_device *adev)
>>>>            if (def != data)
>>>>                WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0,
>>>> regPCIE_CONFIG_CNTL), data);
>>>>        }
>>>> +
>>>> +    if (amdgpu_sriov_vf(adev))
>>>> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>>>> +            regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>>>    }
>>>>      const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>>>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>>>> index b8bd03d16dba..e96516d3fd45 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>>>> @@ -362,7 +362,9 @@ const struct nbio_hdp_flush_reg
>>>> nbio_v7_4_hdp_flush_reg_ald = {
>>>>      static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
>>>>    {
>>>> -
>>>> +    if (amdgpu_sriov_vf(adev))
>>>> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>>>> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>>>    }
>>>>      static void
>>>> nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
>>>> *adev)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> index febc903adf58..7088528079c6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> @@ -730,8 +730,10 @@ static int nv_common_early_init(void *handle)
>>>>    #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>>>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>    -    adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
>>>> -    adev->rmmio_remap.bus_addr = adev->rmmio_base +
>>>> MMIO_REG_HOLE_OFFSET;
>>>> +    if (!amdgpu_sriov_vf(adev)) {
>>>> +        adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
>>>> +        adev->rmmio_remap.bus_addr = adev->rmmio_base +
>>>> MMIO_REG_HOLE_OFFSET;
>>>> +    }
>>>>        adev->smc_rreg = NULL;
>>>>        adev->smc_wreg = NULL;
>>>>        adev->pcie_rreg = &nv_pcie_rreg;
>>>> @@ -1031,7 +1033,7 @@ static int nv_common_hw_init(void *handle)
>>>>         * for the purpose of expose those registers
>>>>         * to process space
>>>>         */
>>>> -    if (adev->nbio.funcs->remap_hdp_registers)
>>>> +    if (adev->nbio.funcs->remap_hdp_registers &&
>>>> !amdgpu_sriov_vf(adev))
>>>>            adev->nbio.funcs->remap_hdp_registers(adev);
>>>>        /* enable the doorbell aperture */
>>>>        nv_enable_doorbell_aperture(adev, true);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> index 0c316a2d42ed..de9b55383e9f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> @@ -971,8 +971,10 @@ static int soc15_common_early_init(void *handle)
>>>>    #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>>>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>    -    adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
>>>> -    adev->rmmio_remap.bus_addr = adev->rmmio_base +
>>>> MMIO_REG_HOLE_OFFSET;
>>>> +    if (!amdgpu_sriov_vf(adev)) {
>>>> +        adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
>>>> +        adev->rmmio_remap.bus_addr = adev->rmmio_base +
>>>> MMIO_REG_HOLE_OFFSET;
>>>> +    }
>>>>        adev->smc_rreg = NULL;
>>>>        adev->smc_wreg = NULL;
>>>>        adev->pcie_rreg = &soc15_pcie_rreg;
>>>> @@ -1285,7 +1287,7 @@ static int soc15_common_hw_init(void *handle)
>>>>         * for the purpose of expose those registers
>>>>         * to process space
>>>>         */
>>>> -    if (adev->nbio.funcs->remap_hdp_registers)
>>>> +    if (adev->nbio.funcs->remap_hdp_registers &&
>>>> !amdgpu_sriov_vf(adev))
>>>>            adev->nbio.funcs->remap_hdp_registers(adev);
>>>>          /* enable the doorbell aperture */
>>>>
