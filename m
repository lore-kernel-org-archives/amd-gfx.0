Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914BCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 17:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5837861100
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 17:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5837861100
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C81898BE;
	Tue,  7 Sep 2021 17:51:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D1C898BE
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 17:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIDslbOJgU1DpU21oJrQObTsADznO1GWRGB79JOEN8Gejh4PKi8QXuIrv/HTxi7+cXnkgmY7waFQ0RVmPJ6dqyMHmWGhy21RG4I0k2FsbdyPKvNfcxL56viE6iFEtPXiBkjcs4i+n/FkX/9N00EpV+ek5ol0oxpyFefWGtZHvtIZGBWOBgkm4amG9cYd9SoLG9z1e8zlu8eAsUbgGHjP7/8l/ONpeGR6zfW9VuefYX45fBrXnRpyd3FFbSVDEz5qf9jrB+DQBAyX/djH4+c4Vwt/2T95aXoNpT2EiJux7TUZW1kb2qrXbIf6+jgS78gP33kNPZkBdAumraBUEIABVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=y4UA3MVZtyy8uEDW+nc9bqlybCbGZR0mZLBYC1v9Q6E=;
 b=oOL2XZKICZn7x+5fFziwIpY4g4AjvJ1fXmEbrove2BqfzXXMb582FdRzmQZs5o1wlYdmC9c1kI+Pope1QiZClVAv9L8jhOUo6JE4djj27kE7Pug9UFWlRcUqfG+sNTWxswH0xRsy7jgFskdc7YcnJng1unhTbMyRUcVAn1dLKIvuuvbyniK5ac4vEzaT0mZ3bjklBdPxHE7ckPXSAFAh5oQnYgwkf24FT6LDKwCpxefNotYginmZLZO+4uwSs0Idor4GjrQ88+qOaTBZwkIjeyPAgQd1UZgFlFqrBzMeHBblbJQpV+Mn6ipO/gdeP2EzfmxHPUCU0y04F8kQBY9VWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4UA3MVZtyy8uEDW+nc9bqlybCbGZR0mZLBYC1v9Q6E=;
 b=Wq7zkgO1XHyvwOG3+Ln1Mucievx1DuXqapSMcY4Nj/2gPoihitn5ykpHy7tyaFzaBkYSUEdoY+keRBRdSdy/AoLKoZ6crdxUWjE2IVhRD+z4Poyq8549Hldl5PK9CKDptD5mGZvdCcUlS1TUPNE3eN2GP8lDnR4qNe5UcgJka80=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5033.namprd12.prod.outlook.com (2603:10b6:408:132::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 17:51:12 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 17:51:12 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: move iommu_resume before ip init/resume
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kolAflash@kolahilft.de, me@jeromec.com, alexdeucher@gmail.com,
 ted437@gmail.com
References: <1631030843-18270-1-git-send-email-James.Zhu@amd.com>
 <1631030843-18270-3-git-send-email-James.Zhu@amd.com>
 <03c5e276-c478-c33c-9f75-e03a56ef16a6@amd.com>
 <adfed1a3-4e1d-8ead-bbf4-4c4448c0f7fe@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <3c196bbc-3799-44ff-d5f8-ade4ada89d93@amd.com>
Date: Tue, 7 Sep 2021 13:51:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <adfed1a3-4e1d-8ead-bbf4-4c4448c0f7fe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::18) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.186.47.3) by
 YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 17:51:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7550b4de-06ea-4f0d-2e4b-08d97228147e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5033:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5033D356AC5283B26C84256292D39@BN9PR12MB5033.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQPWYdDPDGM/tADhXQdGzNzQb8dEGAs3UzMt6BMv6Oc6OI/yToCTdus/uFW5UgmRWhGmVvPyYRXIVLUZZbiUSI8/b+yetwDgzei92NioJgWnaqNGCi6xzGYiNPvNo4jVjbnvYxqaEQN6bkjGJhIhRMfp9se7ePhRxTlRl9chEwuKwQvgcTZtrgMJH9DvWw1EhATK4mKIpoteAWskjCeg8l0NwQSw6w1iNR6iEwLna6UzGY8osAuDLx2cCx+Mk+Zp2sbDckZrKn0g3J5NOwl1iiVGns/ZobrBgksUZMi9aqXdD+e4Dl0PMR1qfAlL01bb7MEa10Z23UuFoFy91B82Puemt0bSDOJ2nPYLjIUQGwX+GG8/Ywz9jqjzpNkNZ9gLplL/EHHs3/Dk4E6V4k8Mnm4sNVE8Zg2i1LBCl9HuhDpwTGGPGIBRKFvutp0f6+tWjENaqVXlacZHoP2jQY+nd2dFX2nEbi4k/G+0OFLqj5HGF/2EXfJiAnf9btTsfgy8Lv+xZVw/BANySZO3m4uujIuuJAGcC7Tmhr8pBIQTYJmuv3JktNpVrWRxOJuGGWtYPpCn6x9yl5c8jGDiDPJd+YBjDhoc9qBjc/o5+fc3mp10ZViUR8GNHLfEd7/HUby7KQCIkOUCpz8NQS9VJcBIvYz9GAkLKe1YSPol6ez/bU+pICDkG1BPN6wekARO/rMAKg/OX5zDVCtXjAGCCqMUlLiI6FlhJYBsXt+XgeStqt6/BTHTprc2+P1adihZ1/omcRMdbrRaZUWZ8UKi2sdm8ryCXsg77O6ZbpWLgbt7AuugxWI+iW/yPhs0mb9UNEcJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(31696002)(186003)(26005)(53546011)(66476007)(66556008)(8936002)(5660300002)(86362001)(38100700002)(316002)(83380400001)(966005)(8676002)(478600001)(31686004)(110136005)(16576012)(4326008)(956004)(44832011)(36756003)(2906002)(2616005)(66946007)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjhzbFFNMUIxaDRHdDd6UVEyeVVMeXZFMkhzSVgraWZFbEdNdk52aThETVdN?=
 =?utf-8?B?dFlTbXBYd1dJaGx1RkNaZUoyZ1NGSEZrOEhyaFlpUFZ0WCs3eEk0eFMyaEpI?=
 =?utf-8?B?aTVQZkhERVhxemduVVVraktuK2R0NzBrNkJlc0l1eFdHYVZiQWV3MEtnQkNR?=
 =?utf-8?B?Ny8xcFByOXR6dkh6bVhtMHVTRldHby9WYVU4UzJLTkw4azVKeG9Jejg1ZEE1?=
 =?utf-8?B?UUZobGRTdHo2cVh0NUN6dDNwWVBReXFuT0V4SDN3dlJYK3lnMldYb20ydjJH?=
 =?utf-8?B?M1d3SHhLVHI5aDk4WFpIdVJmR2hLeWhMd21PY3B2VjRDMWcxd3F0R2t3WnVC?=
 =?utf-8?B?bnFXSVZVcUxHTFR2YVhYYzlJVGRhNC9Od0Vqc2MvZ3ZIMmcrMzdhempkK3ZN?=
 =?utf-8?B?clh6eDlZVWNVb1FkSVNtb29zRUpUSjVVOFlRTnV1YVZXMFF2OTVEaFVuWVNI?=
 =?utf-8?B?bUhtT2JpL0ZIZC82dDF2MzJSVkNkZjFpdnpyU0JZZS9qdzJueVRSL3lHUDJt?=
 =?utf-8?B?QmRxMEZqeFl2N2xZR1BkS3NCRFgxMmxadUFGK0NMMnRjbEVhK25vdTJ3aEov?=
 =?utf-8?B?K2IzNFdRa0ZnY2N3eS92aVhHb0lTNVJYTVhwbUdCK2FRaFVXN3lGQytISEJT?=
 =?utf-8?B?N1dFMTBUa3AvQzk3aE5ibVh3MUNmZkZoNGZhZGxrWVByT1NyQ2oxcWhDdlJt?=
 =?utf-8?B?d2svNkx4RlEvRkpDeW4zT2dTWkRGRXllUnh5eFJ4TDdMbEg3cGtsbUo4Tmp1?=
 =?utf-8?B?emFCUmRRSkxReVRqM1dMK1YreVVWbWpBaXU5bDNxUk0wcUZGQ2l3QlNNWjIy?=
 =?utf-8?B?ZWpaZHMwOElvSnpxNkI0aUFsZE5YL1U5WkNlcCs5eTlnMWtuOHZXR09Wcnl6?=
 =?utf-8?B?NDY5czRoSUp0QWFOd2orSnlnbjV6bHlkSXh2aHZjVEdrOW5mTWtUODg5OGxu?=
 =?utf-8?B?RElLaTlUcDl3cXlYRGRuQXdVR2hrTC9WUnFMYXR0ZkQyREdwdkVKL0twUmVh?=
 =?utf-8?B?WGpvaHNrRUFUOE5ub3RpMXpBa1d1TWxKUVNBTzEwR2JUTGhLd1luQ2lXL1ZQ?=
 =?utf-8?B?dEJiUk9FKzRURXplWUpnRVdNYS9zQ1hLTUd3dndHU1doU2FFd2NIV0RRTWRn?=
 =?utf-8?B?dGZUdFRqcnIyRkNZV1BQU1VxK0JKYUNNY0pIMFd6TnozSUVtL0diZE4yNERa?=
 =?utf-8?B?NXRJdE05bmVxY3o1S3hzcnNCM0VSRjB5NEpuZ3hJbGNiWGVURURSK3Fid2VS?=
 =?utf-8?B?V1FsK2xDT1Y1SWhUczBUNFVRNXJFYktXMmM0ZE9wT1d1U0pDREZqSVQzZVp4?=
 =?utf-8?B?OUNodEx2OEllN2tuTUZ2K2dKZGhibld3dWVWZ1BkOE1PLzIxQUxNYWVRNm96?=
 =?utf-8?B?bnoybzJidDF3bjU5emFwei9GNmo3S3dwSFRCMUllcjNxVDBBcGlvZXhMWTU3?=
 =?utf-8?B?L3J6SHBYa0NTZnVJWG5FVUZTSm0zYnhyaFlERTdxaWcwTTdFNFhPTy85ckVx?=
 =?utf-8?B?ajVyWGZ0RHU0L1hzQ3pSOU1vYVJVeFJ0QW1oVFQwNWwvSkRraDM5cjgxRGZv?=
 =?utf-8?B?dG9FQUZFYmkxc1ExKy9lUFR1NUhTRFBvZEI0WjRBSTRHSWdRLzdVc3ZpdW91?=
 =?utf-8?B?L2JBT3BQajJoaWR4UFRZdW1MMjlLa3E5NmJMbEIrTXFYVG9vdlBuNk56MUlV?=
 =?utf-8?B?NldWNXhOWk5RcHg5bk5IM1dCdTFhVDJSNEdHSEx3VzhQV0QvTXdDazNrM2tX?=
 =?utf-8?Q?iyjMhlxeoYNvHEJhsxUanAUCX3ueSZl1/Dnfltn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7550b4de-06ea-4f0d-2e4b-08d97228147e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 17:51:11.9430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzWQqb8+TMWURPBrmfMhzD1g4G0DOdpykBGWIsfhm0fl9J4KA48MruvzIhDXoIDNBR1ikgAAFCPBhPjidVhRrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5033
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2021-09-07 um 1:22 p.m. schrieb James Zhu:
>
>
> On 2021-09-07 12:48 p.m., Felix Kuehling wrote:
>> Am 2021-09-07 um 12:07 p.m. schrieb James Zhu:
>>> Separate iommu_resume from kfd_resume, and move it before
>>> other amdgpu ip init/resume.
>>>
>>> Fixed Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211277
>> I think the change is OK. But I don't understand how the IOMMUv2
>> initialization sequence could affect a crash in DM. The display should
>> not depend on IOMMUv2 at all. What am I missing?
>
> [JZ] It is a weird issue. disable VCN IP block or disable gpu_off
> feature, or set pci=noats, all
>
> can fix DM crash. Also the issue occurred quite random, some time
> after few suspend/resume cycle,
>
> some times after few hundreds S/R cycles. the maximum that I saw is
> 2422 S/R cycles.
>
> But every time DM crash, I can see one or two iommu errors ahead:
>
> *AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=****
> flags=0x0070]*

This error is not from IOMMUv2 doing GVA to GPA translations. It's from
IOMMUv1 doing GPA to SPA translation. This error points to an invalid
physical (GVA) address being used by the GPU to access random system
memory it shouldn't be accessing (because there is no valid DMA mapping).

On AMD systems, IOMMUv1 tends to be in pass-through mode when IOMMUv2 is
enabled. It's possible that the earlier initialization of IOMMUv2 hides
the problem by putting the IOMMU into passthrough mode. I don't think
this patch series is a valid solution.

You can probably fix the problem with this kernel boot parameter: iommu=pt

And you can probably reproduce it even with this patch series if instead
you add: iommu=nopt amd_iommu=force_isolation

Regards,
  Felix


> Since we can't stop HW/FW/SW right the way after IO page fault
> detected, so I can't tell which part try to access
> system memory through IOMMU.
>
> But after moving IOMMU device init before other amdgpu IP init/resume,
> the DM crash /IOMMU page fault issues are gone.
>
> Those patches can't directly explain why the issue fixed, but this new
> sequence makes more sense to me.
>
> Can I have you RB on those patches?
>
> Thanks!
> James
>
>> Regards,
>>   Felix
>>
>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 653bd8f..e3f0308 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -2393,6 +2393,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>  	if (r)
>>>  		goto init_failed;
>>>  
>>> +	r = amdgpu_amdkfd_resume_iommu(adev);
>>> +	if (r)
>>> +		goto init_failed;
>>> +
>>>  	r = amdgpu_device_ip_hw_init_phase1(adev);
>>>  	if (r)
>>>  		goto init_failed;
>>> @@ -3147,6 +3151,10 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>>>  {
>>>  	int r;
>>>  
>>> +	r = amdgpu_amdkfd_resume_iommu(adev);
>>> +	if (r)
>>> +		return r;
>>> +
>>>  	r = amdgpu_device_ip_resume_phase1(adev);
>>>  	if (r)
>>>  		return r;
>>> @@ -4602,6 +4610,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>  				dev_warn(tmp_adev->dev, "asic atom init failed!");
>>>  			} else {
>>>  				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>>> +				r = amdgpu_amdkfd_resume_iommu(tmp_adev);
>>> +				if (r)
>>> +					goto out;
>>> +
>>>  				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>>>  				if (r)
>>>  					goto out;
