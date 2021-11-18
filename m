Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19977C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD38861406
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD38861406
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE6F6E929;
	Thu, 18 Nov 2021 14:28:41 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C906E91F
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 14:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo3ACXRSZhX5O2dQtrfB1NezaP6e2drfgzOE2v5JdcvPFUZT6AkmfP5e500IXuklEP/NcJuG8Y8dBW8JAlHrEFcWcdTcR/toleLc+Do3HgPLyidNl9FbIiLE1RxgI/00SEPbDtqrfqZuVDOdb/cjG3sCO7AX1gqRuhenlD3QUUKHpNvXoCYzUz/qf8k9mdh1iAK2Go0lqGjFCTH5VZ1JzT+plMLGydiH43F8oACJrUubGf+093J3Y2T40dHJ8fj1POYhAoe/zKxUC0WMr5zCXy33FqT7LXKmZ2heBT8gpIkhuOVhAzFHVQEPVpGGHozvh64jDUghVfir9YeCtpvp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ghn98VHzZ9TH/Coa2uiM7b70tKIVIWNXXuPU/EZ9LUs=;
 b=P5N24y1Sp3ttVhJcVWOkKlg9lQ1pOZpFjU7XP44zzA3qCC9cmgZYdtr/JsmKj+1iS/G6UFc8BqLMJi2lY7I8mJaUwusQYPVWt81CT9qESW8na2EqJg4ijTG7MiNYDydJnrOJUKeyW5ALM4uWfLrGzieFaeFIp4thV1a8KBT/bPOrBrLgseEUu1VKqiZZ0w28Ops8vN9tGNpK3V+rpFHgy38BZ8q7LNDMep/wc85OMVAunmyWTEHIdMA1zuT9NmM9Q0QUPXFTBC7m/loIYHWVqIZA11l3IYoFoN9ceMpOGvTPYPpIGIjtp4dxa/LVCzOQU5QUZgCKM8aMfbLL8rIq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ghn98VHzZ9TH/Coa2uiM7b70tKIVIWNXXuPU/EZ9LUs=;
 b=kb/Hi5n5dkFRs7E47dz34l9uxmwpXTK690/+YhE7znfL5Iy5pqG10G8O0wFOiuseUyblyhxmG45EJnjYKMvL3VdBuTm3KSVyN3tOg7oN+s6JaZPtRGKq3Gjn1HpNYhOfnGP1AWCWL5wGAuY4DOaZR2EV3HEdGu+/gWpj7rSQG18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4618.namprd12.prod.outlook.com (2603:10b6:5:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 14:28:37 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 14:28:37 +0000
Message-ID: <14cd6274-c967-ba7d-71d7-ccf332c30494@amd.com>
Date: Thu, 18 Nov 2021 19:58:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
 <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
 <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
 <CADnq5_M_FpTJ=PNdLy9k7EELK_Q+hbeuQdvZi0aURPiSD9Zn_g@mail.gmail.com>
 <97141867-cf4c-eebc-425e-ab2418c9e87d@amd.com>
 <ef7d1842-df51-88b2-75fe-146140681321@gmail.com>
 <b42e6ba2-a849-f8c3-d013-6c4d64ec3ac4@amd.com>
 <CADnq5_MGQ802Z-gdgfQXK_Eo2RXeE0qZ7AQUQLusez4Y3ysT5w@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MGQ802Z-gdgfQXK_Eo2RXeE0qZ7AQUQLusez4Y3ysT5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::18) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN1PR0101CA0032.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Thu, 18 Nov 2021 14:28:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a28ea14-ea23-4a0f-08a0-08d9aa9fb58d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4618:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4618D8F75A0AD3402CB9F257979B9@DM6PR12MB4618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ba16yhAPwxSh8ZeGY0Fpi1LVNLrtd60ct7z9+O9cy9NTuWaQ0D2KjMiJYHoLLoPBtxPEFwhZBN0pYnFlIx3q3e9yCu086bfCbyjO/1VsFDs/NfwJ/j+3i7syUOyzouqiHnn4eMMNMgwkbn+1QQ+okt5wHYnEdxfkdthvwUg2AxWywK9Mjer/ssBfyhQwHUVKDm0uT4XxnHhnFjzbZJ0ynTw0aj6ognN0+MDletUUY/1WtY/qF4M5bJCNIiIDTnzxjPF39d4YWCyJ33FPWnjKGXNagdtg+STVMlCvZWoTnuP9UJjTOS9EUTAXErQZr2OyRWhAEWgkGyd21a1jFZdlKLjByXNXdKDAfspyGA0R1Vz7o0TjuNPHQKE23OtGqH5vT7K0UAy9cqz2bOxZPviBaowfurN1Z51wQYsX6iqnUymGIRtyeUyNXYIhVYBXTrz+7evSTL+VlIUedJUt/QzOxW7dupX4iDfRocIiVJbJm7I5ziHvLp19SOE2lRcksg+fvzxYXvCcHQEgvEXa2WI8f0mgvZRQrJgdch0TnX+aCvryXwiJ5pXmEVzk+faCdQ3qgAhgTROxCNiJLFwtySq3mDL59/Cg/aTY8LuTMWQmj66fgRGwDyVq3289nzHgjPwZ4lNjEt2nXgH8fPKpyxNMWxR/uPDRS+W5teTxb7EDHjnzZEitHe70eFCTBJ6aczjcwvOgSKUiiLA+oV+jKaV7udvuAlHGW+3aNXxCguX8rcdZTyG+i7DPv9DR4NgLa6D7+rMiKz3rxo7vIAjZr23YGHBcvK8sBuFxyKsU0t7nRVhfaK0SZi6JcUCEMo6t6PcrpvglEnqd+In6iZNw+uVoM3+3vIdE5mu2TxmVpF4wQvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(38100700002)(5660300002)(186003)(15650500001)(45080400002)(26005)(8936002)(83380400001)(6486002)(66476007)(4326008)(966005)(66946007)(508600001)(66556008)(6916009)(36756003)(31696002)(316002)(8676002)(54906003)(2906002)(31686004)(16576012)(86362001)(2616005)(956004)(66574015)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkVHYVFURUQ2RWRIVG1uRUdvR3BZL2FPZ1ZUTHEzOU04VzNoem41K1E5UHFY?=
 =?utf-8?B?NnFPRk03Q0hXd0sxVU1pWlBSVHVKRUo1eC92M2pqcDFlL3VIc2trNGpKbWRn?=
 =?utf-8?B?QnFPNk5maG1BUFd4T2t6L3dlU2c1YWdvYTlPbVE0Yzl1ME8rTStBRkk4R3Rr?=
 =?utf-8?B?SjAyazgrRXVLQnMxdmxmZ2hxVU0zSndGbjFLdjlOZjlhdS9qc3FKYktnQ1BO?=
 =?utf-8?B?YnVtS0wyeWpudXIzTlllZnI1VjF3UWUyWEsycnRNdy9lQTBJRTMxdzBXbFg4?=
 =?utf-8?B?ZWwzbGtiYXp5c3B6Q0hPRkdNOGlNeExMQTJtMndmR1czbHFkQ1JjeEJDMGNo?=
 =?utf-8?B?Uks1Tks0VkdtQlNzczFLM1RzcUE1bnN6bkF3WHFtNDZpSzJjbDlSU0M4Z2Iz?=
 =?utf-8?B?bFV3QUJqMkRCdnQ1L0dRVkwrd0d1UC91MDgxN0QycDh6dkFLZkorblRoYmJD?=
 =?utf-8?B?YXg4QkV5M2VDK0p6YWdmYlB1L1U1U3g3SGx1REpZcjl0MGlKY3A2RWdTT0dK?=
 =?utf-8?B?eFFrcGdxQ3gzVjlvWnp6b1lydFBmTmFiWFJDY2dUaWRLZitzSDd6OVREYTZm?=
 =?utf-8?B?RDF5NmpvcUJyU1J4OUNiZ3ROTmppSlo4OHBTWGZZTVFMNHF4dnZrd1FGbFV5?=
 =?utf-8?B?UUE2bXNMY2txVllCSzltQlk1TVNZdVdDY1V3OGhpbE5ibENSOWx4YnpOS1Fv?=
 =?utf-8?B?eU8xdVBXa3Z6OWFXcG1jWDBERTd5Yzhwa0ZobUc0Rlp3Q09Md1ViMms5VzlL?=
 =?utf-8?B?NGN6WTdZWXVjV29JbW1pTkV0amFEYm9tRWZMK3FYMXVNYU95VzhEb2tTbW5p?=
 =?utf-8?B?RnNqc1hqMnVIajVlOWNiTWRhZVR1aXpLN284TklQYy9teWJwbHFPRHVScEpk?=
 =?utf-8?B?RHZCVlBSTXhlMU9MRzRjRlNseGljOXBEYm9wQkYybkEwTU1QM0kvY1pFeGgx?=
 =?utf-8?B?QmszRWE5QjZza2lJUlAwN1cwSFFLVUt6cjFjWGdWVTRscVpYSU5zWnFtMVhw?=
 =?utf-8?B?bVhLVVNWU3pmQ2hrSGZTOUhLZHQ2b0JLbjVLa1JCdHhYTkhYclBNblpsOE5L?=
 =?utf-8?B?TjJlUXI4WFhYbVZ1RmtOZklmMThTYWhoVWRyUWJGSlFpZ2dmMUo3VVhmRzBD?=
 =?utf-8?B?VXArazBPUVhoZE9iTDA0TnM1REpnclBSNmZDUVlEaCtjdFhRRVBvQk9TWUVN?=
 =?utf-8?B?QlhVd3duL255OWlaZEtzWGVORXIzTmYySkJuUGVSTnEyalMwSlptSGdqQ2ZH?=
 =?utf-8?B?UVVZRVRNVXFWOUtKRWs3alB1SmhRaG5oYXlkYkxFQjhiVkE5Vm91V0VyNVdl?=
 =?utf-8?B?R1NnTEZZYzloeDg3Y3ZXNE9EM2IrekJjbUpuMkk3K21lczFLZ1RBRW5rcHI1?=
 =?utf-8?B?TTVoZ24xMUM4bGlqQkRxQlE0dlFpeGMvMjJRV1AwRkF3U0dXVTQzRVFhZ3g0?=
 =?utf-8?B?SDNuZmVGVUk2anZrcTlPbXI0YVhjTG43ZUR0ekJwcjdzdzRZWFhUNlhvSnBD?=
 =?utf-8?B?V3VvYi9ZVk54bFR5NzhqRTVKa0VuSVlwMTFmekhSRU9uUGY4cXBiK2UvcXZV?=
 =?utf-8?B?OEhKOU1FWHVMaFE1MTk1NFF5RlRRc2l0MXE4ekV3NG1wU0J0VFl5d2VFRGRV?=
 =?utf-8?B?eFkwdFB6MTFwSWtRY1pZd0tUMzBldnkzck11cmxVWjFTL1cyZy9KdDJFVzM1?=
 =?utf-8?B?M1ZJR1A1NHRhaGhac0UramZGcDJDbGI0VHQxQXZHOFkwNmMzV0FQOTMwOE5n?=
 =?utf-8?B?T3gxM016R0dSZkFGbUN0b09DbzdjV2tmQzN1Qjcra0c2YlFXUXlCempadmNa?=
 =?utf-8?B?WFpUckc1ZUd5NUJzY0tHRmtUZ3ltZUtWdFdVdWgvb1NlclJkWFpYWFRydzgr?=
 =?utf-8?B?ZDZ4Snk3WXJGVVpCcHhlbWJYRXlJY1REYWVhRkhBeGg1L3NJSUplZFVhRFph?=
 =?utf-8?B?blZQSHp6QUZsNkpYSWsydE9ZUHU5SFN6YmJML25IS3RBY0cvcE9YNFUvdG80?=
 =?utf-8?B?Z0swVjZQb3RkdHdYbUJ4OWtOc1ozdzhMQnkyWC9RZE5mRXRSaDh4YTVGRDBq?=
 =?utf-8?B?WnQzZEhPdS9yak15T1BtU3RvNE9xSStaRTJOVzlndjRCTVNIR3FFclRZWHNj?=
 =?utf-8?Q?yQw4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a28ea14-ea23-4a0f-08a0-08d9aa9fb58d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 14:28:37.5844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdp/jrrlp7hOXJNHeycPYq0jgcG6pQKHUMR/fbsEHNGdiN/knu1SQ4wa6MUjCCFM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4618
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
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/18/2021 7:55 PM, Alex Deucher wrote:
> On Thu, Nov 18, 2021 at 9:15 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 11/18/2021 7:41 PM, Christian König wrote:
>>> Am 18.11.21 um 15:09 schrieb Lazar, Lijo:
>>>> On 11/18/2021 7:36 PM, Alex Deucher wrote:
>>>>> On Thu, Nov 18, 2021 at 8:11 AM Liang, Prike <Prike.Liang@amd.com>
>>>>> wrote:
>>>>>>
>>>>>> [Public]
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>> Sent: Thursday, November 18, 2021 4:01 PM
>>>>>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>>>> <Ray.Huang@amd.com>
>>>>>>> Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend
>>>>>>> aborted
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 11/18/2021 12:32 PM, Prike Liang wrote:
>>>>>>>> Do ASIC reset at the moment Sx suspend aborted behind of amdgpu
>>>>>>>> suspend to keep AMDGPU in a clean reset state and that can avoid
>>>>>>>> re-initialize device improperly error.
>>>>>>>>
>>>>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 19
>>>>>>> +++++++++++++++++++
>>>>>>>>     3 files changed, 24 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> index b85b67a..8bd9833 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> @@ -1053,6 +1053,7 @@ struct amdgpu_device {
>>>>>>>>       bool                            in_s3;
>>>>>>>>       bool                            in_s4;
>>>>>>>>       bool                            in_s0ix;
>>>>>>>> +   bool                            pm_completed;
>>>>>>>
>>>>>>> PM framework maintains separate flags, why not use the same?
>>>>>>>
>>>>>>>            dev->power.is_suspended = false;
>>>>>>>            dev->power.is_noirq_suspended = false;
>>>>>>>            dev->power.is_late_suspended = false;
>>>>>>>
>>>>>>
>>>>>> Thanks for pointing it out and I miss that flag. In this case we can
>>>>>> use the PM flag is_noirq_suspended for checking AMDGPU device
>>>>>> whether is finished suspend.
>>>>>>
>>>>>>> BTW, Alex posted a patch which does similar thing, though it tries
>>>>>>> reset if
>>>>>>> suspend fails.
>>>>>>>
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FDM6PR12MB26195F8E099407B4B6966FEBE4999%40&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C2ce211aeeeb448f6cb2c08d9aa9f4741%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637728423343483218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=nyzhGwTJV83YZkit34Bb%2B5tBxGEMvFzCyZPjz8eSDgc%3D&amp;reserved=0
>>>>>>>
>>>>>>> DM6PR12MB2619.namprd12.prod.outlook.com/
>>>>>>>
>>>>>>> If that reset also failed, then no point in another reset, or keep
>>>>>>> it as part of
>>>>>>> resume.
>>>>>>>
>>>>>>
>>>>>> Alex's patch seems always do the ASIC reset at the end of AMDGPU
>>>>>> device, but that may needn't on the normal AMDGPU device suspend.
>>>>>> However, this patch shows that can handle the system suspend aborted
>>>>>> after AMDGPU suspend case well, so now seems we only need take care
>>>>>> suspend abort case here.
>>>>>>
>>>>>
>>>>> Yeah, I was thinking we'd take this patch rather than mine to minimize
>>>>> the number of resets.
>>>>>
>>>>
>>>> Wondering if suspend fails whether there is a need to call resume. It
>>>> may not get to resume() to do a reset, that needs to be checked.
>>>
>>> I would rather do it so that we reset the ASIC during resume when we
>>> detect that the hardware is in a bad state.
>>>
>>> This way it should also work with things like kexec and virtualization.
>>
>> I was thinking from the power framework perspective. If the device's
>> suspend() callback returns failure, why would the framework needs to
>> call a resume() on that device.
> 
> The device's suspend callback succeeds, but some other device or event
> in the system causes the overall suspend to abort.  As such the GPU is
> never powered off by the platform so it's left in a partially
> initialized state.  The system then calls the resume() callbacks for
> all of the devices that were previously suspended to bring them back
> to a working system.  GPU reset is just a convenient way to get the
> device back into a known good state.  Unfortunately, I'm not sure if
> there is a good way to detect whether the GPU is in a known good state
> or not until we try and re-init the IPs and at that point the IPs are
> not fully initialized so it's complex to try and unwind that, reset,
> and try again.  It's probably easiest to just reset the GPU on resume
> all the time.  If the GPU was powered down, the reset should work fine
> since we are resetting a GPU that just came out of reset.  If the GPU
> was not powered down, the reset will put the GPU into a known good
> state.
> 

https://elixir.bootlin.com/linux/latest/source/drivers/base/power/main.c#L925

I don't have a machine to trace the path. The flag is set only if 
suspend is succesful.

Thanks,
Lijo

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>
>>>>> Alex
>>>>>
>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>>
>>>>>>>>       atomic_t                        in_gpu_reset;
>>>>>>>>       enum pp_mp1_state               mp1_state;
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index ec42a6f..a12ed54 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -3983,6 +3983,10 @@ int amdgpu_device_resume(struct drm_device
>>>>>>> *dev, bool fbcon)
>>>>>>>>       if (adev->in_s0ix)
>>>>>>>>               amdgpu_gfx_state_change_set(adev,
>>>>>>> sGpuChangeState_D0Entry);
>>>>>>>>
>>>>>>>> +   if (!adev->pm_completed) {
>>>>>>>> +           dev_warn(adev->dev, "suspend aborted will do asic
>>>>>>>> reset\n");
>>>>>>>> +           amdgpu_asic_reset(adev);
>>>>>>>> +   }
>>>>>>>>       /* post card */
>>>>>>>>       if (amdgpu_device_need_post(adev)) {
>>>>>>>>               r = amdgpu_device_asic_init(adev); diff --git
>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>>> index eee3cf8..9f90017 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>>> @@ -2168,6 +2168,23 @@ static int amdgpu_pmops_suspend(struct
>>>>>>> device *dev)
>>>>>>>>       return r;
>>>>>>>>     }
>>>>>>>>
>>>>>>>> +/*
>>>>>>>> + * Actually the PM suspend whether is completed should be confirmed
>>>>>>>> + * by checking the sysfs
>>>>>>>> +sys/power/suspend_stats/failed_suspend.However,
>>>>>>>> + * in this function only check the AMDGPU device whether is
>>>>>>>> suspended
>>>>>>>> + * completely in the system-wide suspend process.
>>>>>>>> + */
>>>>>>>> +static int amdgpu_pmops_noirq_suspend(struct device *dev) {
>>>>>>>> +   struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>>>>>> +   struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>>>>>> +
>>>>>>>> +   dev_dbg(dev, "amdgpu suspend completely.\n");
>>>>>>>> +   adev->pm_completed = true;
>>>>>>>> +
>>>>>>>> +   return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>     static int amdgpu_pmops_resume(struct device *dev)
>>>>>>>>     {
>>>>>>>>       struct drm_device *drm_dev = dev_get_drvdata(dev); @@ -2181,6
>>>>>>>> +2198,7 @@ static int amdgpu_pmops_resume(struct device *dev)
>>>>>>>>       r = amdgpu_device_resume(drm_dev, true);
>>>>>>>>       if (amdgpu_acpi_is_s0ix_active(adev))
>>>>>>>>               adev->in_s0ix = false;
>>>>>>>> +   adev->pm_completed = false;
>>>>>>>>       return r;
>>>>>>>>     }
>>>>>>>>
>>>>>>>> @@ -2397,6 +2415,7 @@ static const struct dev_pm_ops amdgpu_pm_ops
>>>>>>> = {
>>>>>>>>       .runtime_suspend = amdgpu_pmops_runtime_suspend,
>>>>>>>>       .runtime_resume = amdgpu_pmops_runtime_resume,
>>>>>>>>       .runtime_idle = amdgpu_pmops_runtime_idle,
>>>>>>>> +   .suspend_noirq = amdgpu_pmops_noirq_suspend,
>>>>>>>>     };
>>>>>>>>
>>>>>>>>     static int amdgpu_flush(struct file *f, fl_owner_t id)
>>>>>>>>
>>>
