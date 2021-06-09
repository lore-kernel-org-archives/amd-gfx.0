Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C50C48BCD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 17:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497A7613CB
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 17:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497A7613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D88BB6E07F;
	Wed,  9 Jun 2021 17:05:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586446E07F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 17:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE0TLAXk0DvLcN/oivBHZ3I8qYF5W/Klf4h3lsCju4H6DYfXZvGSx8NMUkQDY+swnI+ihSP69AGZ6pH3NlH5u/9yMgOJMzVaDBYUCM2Wb/dmT+lu3JTYnVkK/eYU+ZJROx70gIlYMMVIRHKxYsnJfBjUTLNeuGfa+Z9T1F1bAfMAw8PPRdx/QYfTSdCaPr5xn/ct7vOXK5qp2lRo7tebn9OrHuSY+Xa2TsM/0LtdCNUq13XskQMaJOx8xHSYseVsK3gHj4jPWZHg3ATekmfmXnzcKAy2pHEcRtQ9AHxiet0Fe3XJU+kykXfUP0ziY7at9hJnI4NnFoCNhGzEfXWCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCFiU0kR7Wco2vkj4YD9mwUuuHC2Vt+tDFqgkAyR5r4=;
 b=N8ViAVjBq3AMyOJNjAdsuFrokKR4WM45Up9B2j/q30pDl2fNAARO19QfT2iyCjK4OiNLHfmgtsYOiU92dBdMsBrO+UxIZjYZCWxo5qMCeFWE/ObMiAK7AkIZZ4uRdmEl6jds23oJhmWtM7FBadH1IsvlbYjLMXL5fK/VFnPOTpvETkQdHhu68Z/wJER1AjiFEXNyPWgG9qQ1K7KQUdIC1fEscVEkYbnSHgknXJx0jr162fu3w96AZdxivK0RxDxfmxxU/79g8aDJyiBxqxhhegl/QUsxjvIN8BpZqOVYNAmUFeMvkuyWqn26e2r4cYOggZHIhezHlRGn5pQXWmqGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCFiU0kR7Wco2vkj4YD9mwUuuHC2Vt+tDFqgkAyR5r4=;
 b=KniJYTI/ywjxNe/p5mJqaHsraQ0GvVL76ca3wDV2v6917pySQmPU7oiZNO0eaWxno9oAJRMeRY3uNvh0yyf4tKlJHp5ShrrD88rN6hutrHtOPi4wJLHJyi7ZkO39DJn3tUuzhW67fjSh7Cp7Emx3Fn8DClqbtMpBSNXiQZ0AARg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Wed, 9 Jun
 2021 17:05:52 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.022; Wed, 9 Jun 2021
 17:05:52 +0000
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device
To: Alex Deucher <alexdeucher@gmail.com>, Guchun Chen <guchun.chen@amd.com>
References: <20210609092323.32650-1-guchun.chen@amd.com>
 <CADnq5_NAfrOiHwx5D3SHsvvrzCbh_Rwju=AV8DT434oJm5vjUw@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <1a2a6f03-aa3f-a4b2-d49e-39e054337d50@amd.com>
Date: Wed, 9 Jun 2021 13:05:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CADnq5_NAfrOiHwx5D3SHsvvrzCbh_Rwju=AV8DT434oJm5vjUw@mail.gmail.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::28) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 9 Jun 2021 17:05:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bf0ed62-967b-4fea-744a-08d92b68d609
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2795D1FD47E9D29E8A21BF3199369@DM6PR12MB2795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WnQ6MD3ynDJim4GaibCRLNBV/rG2z5LNbSw0OAWYn/EMPHH+MDugowq0jpa884B4LWYfnZAN/xVZGiZ5hL4CzJhsp0iPdwIaVkyyx4SoO/aw7lNaWJEr3T5PihnIy2+eAm+Dj8otllcJdKYlMwO+aZdI9eppfLGtHZZqrTj5ZAQcMQKHndVK7t+1AI0hEmk+hjCWnM5DRs93JoIXndOxjE8O2ULi7+jzTjMxfClte0S04mdOepcOtqSL1/UFobEQ/FkxqALbnlwu7uNXwKH5J8jYYuycQxzzuwG3g+ZcZsbLTiAFVW11IKE2EoCQMuTSqc2Y1b2tESXyl0ul6KSAdA2BifW1nk06r9TvteeEPyDusrrxBFx4B2z73cMomx31sHX1P4mSIgsI/t3TDkMVueLCkMsWYREDWH7j60BHy898wwEzpCa7pkww6VgfRj3D5AEM/2fOXzeMuZ/HNEquCjK3S25uFsov1GC+VaHL5/TMlqTB3V8YOKQMnArZ7ZUHKKjEYH+SEM/y8oUnZVOSfWaOx1KIiXImR7TXT585nFnrtw6NaRqFVGfr2y/wWvcyyi7+7kSqkxkHDxEVjV50fA+2uQc0XKKo4npQyczizkLxAyt/kSwCzb2GxOo2YguFO1EdpkR0w9BNrXUddtz85QXu2Rl96O1yezm8dzIcJnOc1jjk0TiqXH2HsefBXyrIibDq6VzSJOZGEwKru+TlSdv1Jq3SjYqvr/ujS9fY+v4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39850400004)(4326008)(6512007)(31686004)(2616005)(110136005)(45080400002)(6486002)(2906002)(956004)(316002)(54906003)(83380400001)(36756003)(8676002)(38100700002)(16526019)(478600001)(86362001)(26005)(186003)(55236004)(6506007)(44832011)(53546011)(6636002)(5660300002)(66946007)(66556008)(31696002)(966005)(8936002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9ncTY0ekptWVhlZ3FObWZlRnZsK0U4MDZ2d1VGQTg2dkhrR2lnZk1DaFZi?=
 =?utf-8?B?N3I1WjZRTzdZUkN1L1J6L1Q0TSt0QmpDZWF6eUZvMDlFNWJDdzA4R2pjaWNC?=
 =?utf-8?B?ZmkrOUIzeGI3djZvbHRZSldIaEQvdFE3T0JQbm55anZEVitmUkEyNEZQWk1m?=
 =?utf-8?B?cXExQjZ1R1dmUGRtcXdsZDcwdm05MVlBaXc3WkdkU00vZmdHY0VuUHJFVllF?=
 =?utf-8?B?QTdBVDZYb0Iwd25nQUVHUjcwT09MYVNtcERIdVpnbUNqQzZndlYyUFlkRmhy?=
 =?utf-8?B?bHRraHJaY3o5TTFiUGM5Y3UvS1Babk5CRW1MbTQ4UFp6M0VqeUNxSVRQZEtL?=
 =?utf-8?B?bkRuZkxmaXlOc2ZSNEZBcEsybkNxckhZSHBpK3lRY3NsSUdUeUFYaCszNkJ3?=
 =?utf-8?B?OExvUC84YjYxNHB5WUJ4TSs4YkVVbmhDcytkMzBBOGhyQmhITllmUkpUNlE4?=
 =?utf-8?B?QjhqeURUbWpUSHBNb2M5aXdHSER3NEVDRmpuT2NYRE40dDZQYnBMTWdjckdS?=
 =?utf-8?B?b0xMZ1czTElYeDU2M2JMMWpoN080ajVKNzZjaXlhS2N3bE5NYVN6cFJlcGpN?=
 =?utf-8?B?R2hpU2F6bTNuVmNDYlcxQUFTVSt6L3UvaUZGYWU5STRlQUNEb1hrK0Y5ZTFa?=
 =?utf-8?B?cWMyQnZHL0VUeTB4T3VKMlZRWVM3alU4OGIrWHl5MHpvTk1kcnFpL2lTMzBZ?=
 =?utf-8?B?RExlQXF5WlFXQTlhcm52UzFEVjdxWXIwL2xBUFFmMTRzOEZ1ZS9obHd1WGdo?=
 =?utf-8?B?R2swd2RWcXZxSmQ4MGg2N2J1L1FQZEtZTEZrYk8zWjdBcnMzV29LOXJHRlRX?=
 =?utf-8?B?R1RvV1I1UHdMWnZiQm1UYnp5eURyclVhZzZVQStaY0M4V1dMOVV1Q3VaeE80?=
 =?utf-8?B?dlBndUNhQjBiMkhmRS9zMjFCVGRxMjNGNUhVRkM4REFFUkFNVkMrbVJ4QUMy?=
 =?utf-8?B?RWdvbmNBbmYrd1AvUXNSMGF4UkNHS3VsTHRZUTFBb3FrVmUxcEkxZU00a1Vr?=
 =?utf-8?B?eXE0ekpBejE2MXpBbDBKdGRwbDZaeWlaQUJtVTVLYUlXdVpjVkNySU9OT1lI?=
 =?utf-8?B?U3lTOEdVTjBnT0Izd0c2U0oreS9OOFp5TXVneEFRQUZILzBVT2NQQ0hld3Zj?=
 =?utf-8?B?eXZVTTN6bE1wOGt4N1VMUS9OaE9BcW93dmNoMFdZS0l0YjYxTEZHL2NZajBu?=
 =?utf-8?B?NVNYeFZHb3FWdjlkcnpkV2lvK05XWTFzK1dCZzlENDNpZ05wUHREK1dTOE9C?=
 =?utf-8?B?SUg2dFRIVU5NYU1aMDhCcUw3Ujg4TGk3eG5JVkVNQ1BFd2drTVF4d0ErSnhy?=
 =?utf-8?B?TmswbmVrK21sYzV1d1hnZ0pVT3NLOG4yd1FJR1ZXLzVIMVZoUC93SUlCcjh6?=
 =?utf-8?B?MG13WWR2Z3dmM0ZGamM2dVJBSFhlM3pZM3EzeWcvdHQxYlczNS83UHgzb2Jx?=
 =?utf-8?B?Z21GYTFqVjNwU0xVYlBYZy9ISmZITFpUaCtKOVBSK2RwQktLU3NydkY5Qi9K?=
 =?utf-8?B?THRSUm5VQ0RJR21TNEQxeGREaitURzNXeEU3VjQ3NjRhSzUveTFjc21BSlFm?=
 =?utf-8?B?bTZ1aXM2Zmdidlk0MHdnNEQyZytuREhCdjA0UXFVMTVXRUdaRXlSTzVEa1Rp?=
 =?utf-8?B?U0lQUld2Nm1Fc0JPbzYxSUhidlZuRXk0MlFEbFFuSTAyaEJ1eUVsSEduWm0y?=
 =?utf-8?B?TldqSWRTdTRLRkE3YS85dkZxaG5NaXE4YXMyMStiMWwwejFBMFdvRTQ5UlFw?=
 =?utf-8?Q?CuFP+PglL0Iyd3tEfgKlWUPpDA/t/mEmoPyMKXA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf0ed62-967b-4fea-744a-08d92b68d609
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 17:05:51.8951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNctRoBn+MUuuGc4p0aiWoEo95y268GKwKlfH9sdjq2Ak6M7LFP7cjrHPEdYiGmF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
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
Cc: "Kuehling, Felix" <felix.kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That's exactly what I said, but can see that 1/2 of the responses went to amd-gfx,
and the other half to brahma ML.

Regards,
Luben

On 2021-06-09 11:38 a.m., Alex Deucher wrote:
> On Wed, Jun 9, 2021 at 5:23 AM Guchun Chen <guchun.chen@amd.com> wrote:
>> Fixes:
>> 9faf262c32d3 drm/amdgpu: Add DMA mapping of GTT BOs
>> 090f3a60d7e8 drm/amdgpu: Use delayed work to collect RAS error counters
>>
> drop the fixes lines and say something like use the adev_to_drm()
> macro for consistency.  With that,
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 016815b7a773..fb6bcc386de1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -639,7 +639,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>>                 }
>>         }
>>
>> -       gobj = amdgpu_gem_prime_import(&adev->ddev, mem->dmabuf);
>> +       gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
>>         if (IS_ERR(gobj))
>>                 return PTR_ERR(gobj);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index ec936cde2726..bfbcb9ff2453 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -2122,7 +2122,7 @@ static void amdgpu_ras_counte_dw(struct work_struct *work)
>>         struct amdgpu_ras *con = container_of(work, struct amdgpu_ras,
>>                                               ras_counte_delay_work.work);
>>         struct amdgpu_device *adev = con->adev;
>> -       struct drm_device *dev = &adev->ddev;
>> +       struct drm_device *dev = adev_to_drm(adev->ddev);
>>         unsigned long ce_count, ue_count;
>>         int res;
>>
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7C04e4afbe1642484eb15008d92b5ca67d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637588499214061155%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=DvbjnGu0Lafx%2FgCIejsFJgMyngl9bKIvIdLjTngQrCM%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
