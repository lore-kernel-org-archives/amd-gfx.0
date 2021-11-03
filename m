Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B527DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 16:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC6460295
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 16:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BC6460295
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA03073982;
	Wed,  3 Nov 2021 16:27:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515DE73981
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 16:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSYYNL7xdBg6VeDwsEY/sE70FAmYNByNHZotvETyl6d/gI4GzP07tUiCgQoeTkpkB7Y3amYtnIGZTmDzIsq3mnAvnAw5I2hmioYT9EjYZWJZh+3e3vqqc4w0qH8BGayVZOXvMgY8+S3wuTbiByyFCfD8gLsAK3Ljf27zoHbfGSsGlhpTcD4agUuNSW0mgzm5O/Fq5avly1WYOzH0bMQm3lcGVHGcmHWBNdbU1dCshTTf+cmzHgU7Jse6uu1q+Yo7anjAAcQ20kQbliGAr9T0jKkr6D/pozHMFc5mHcuZ+yLUU4/aJSZn9ISYIMCIj152lGXQct/3P/2tUbQDPvPZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iOi+FV9pbybDed3DGrcbPWyGdlzR0DVlWwv332mxYY=;
 b=Za09Mok08Ej/ol31NhCZKluRvleoGQe96jJSRhC1HJd86UIW4Pt7huP1pD2VGgAHtDud3KqdskionxAcW3y3iFrpVLhr7PsNIbOWX/vSaKcdQthw7T6MPH9o9GD4iLjBj3TZrFxmOXv71brMV+Px1/Yhub4d+UzABDhUh48IKFqWbPkxONx+LCquzERaj2NvVkHJ9W4xjCLMKLj18k0tS4tfcvPOxDzVldmcCN7YGTEzJCZuVU4o9+ZZmASBOdP036Zrcb4fkb9S2Gv3ZNvis1Mq1PJXjlcfEArjQDGNi5dJH6vbSGlZvyAsd22RYU7tHHM2B4DanzlZtpB7HJ5ORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iOi+FV9pbybDed3DGrcbPWyGdlzR0DVlWwv332mxYY=;
 b=EToZ2EuAVvh9L1E+0uKj6U4KO0CFvjCY2DwmvOZtZQdIoAvC1GuAPKV0+9kGgbBWSMHiMmOChBROyRonszhcPJ+rKh6VilSHGMqk4+wIcEbzUTGN7tZtat725WofuZ1vwJ5+zaLi9AlMxVUy9KjiI3/eWbdLlHORuyrSVuxk/HQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 3 Nov
 2021 16:27:27 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b%7]) with mapi id 15.20.4669.011; Wed, 3 Nov 2021
 16:27:27 +0000
Message-ID: <4136ce63-2865-c4fe-90d5-9cc3f869d59f@amd.com>
Date: Wed, 3 Nov 2021 12:27:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 2/2] drm/amdkfd: fix boot failure when iommu is disabled
 in Picasso.
Content-Language: en-CA
To: "Lazar, Lijo" <lijo.lazar@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211102192324.3402-1-James.Zhu@amd.com>
 <20211102192324.3402-2-James.Zhu@amd.com>
 <e390c469-5584-4157-ccaa-3be588b4143a@amd.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <e390c469-5584-4157-ccaa-3be588b4143a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0086.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa::16) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 PAZP264CA0086.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 16:27:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c9dfd73-2603-43e8-6551-08d99ee6d2fe
X-MS-TrafficTypeDiagnostic: DM6PR12MB4546:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4546BE72C7145214743AF3C2E48C9@DM6PR12MB4546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUuim1uNRkeTGTasnzVZ/zDHuIbDOEXxXIa0UKPq+IOrJUoF/o+UC7JZC0wCNgY724t4H17dHf2aD2Vrf5XiuNTnoP8k8k3lcOSw/UHqMyQgwlj7yDPD1WyhSBYLDVuMkHZqqvfBKRUbgQEIqHvZihPNEpbnsrX+xUNWDWNDQ/WhrrCeNEBtnGQp2Auge20XywuOecsRqqN7RXylRFOTzaw5u5oVYVm3qc4DHGtc3h/sTSPP/gsgM6BEnH/+tcpdBuxgcgIDrdLnsaYV9V4H721ULgwQDBz5oBXmW6euL5sQ/d1NNjc6+KXDL8+ZylW1teAO0VOMt50mbzLJ1q014VkBj+6TcgX4KINf8twYdlk8yH2YvDaiSjk0MqCh88nqNfz9QckCtgIS1x8vjQhGTntD0jnWBQFnw6QE2XGj7t5RwiCx3b8ydYEez6+M/R664yFQRWT6Qd1A6/m1aSS1FOR//mr/AtXzZjc/5ezx/IdHFOHk11EXlYS353YrfxS0IhV28q+RF+kdcF325wbv8ff0D6eYlTrZuowSLXtqHsAWrpohVD2d8Ot7FLpRsjfyrEjgf0FZ2Kvw1Ak2UMPqh4sICjFoINCkiiyMbBj/kwx6C2Q8tipJrKpqlpIGTYZwWYTnBgC1fNI0NnQlCK29R15DycWMZnItnpyn1a11DROmdbfWVFeQKWFOKjTjVJ1w81yBYThVc9+tc52DlHkhJIGiSJV0yUzesArh8LDy/N2BRToHHWTO6XN6w6RmeHMfpYjDfQSOr4e04co8OoObL4GHX7nE5fDvRP9bPsFe91lLMN0FgXTgnbNjI+9VVhz29t16EgiafmaXBqzEatjHQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(66556008)(26005)(66476007)(31686004)(83380400001)(36756003)(8936002)(966005)(956004)(4326008)(8676002)(5660300002)(6486002)(66946007)(38100700002)(6666004)(508600001)(2906002)(2616005)(16576012)(53546011)(316002)(110136005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUU5dWNOQVhhT0VGckZPMG5ybGd3czlUOWhEaGkzWjJaZnBUaXRrZ2xMRCtX?=
 =?utf-8?B?aW5ienl0YzYxMVVqNys4YlJwK21COUlIZzVRYStEb1ZFS1dUTzhLOVVOWlNy?=
 =?utf-8?B?LzlTekF5R3pQWTkyRlc2Qi84VHR2VXRkWVZPdFVkSG1FZ0o1ZTRCSVZEN2Rq?=
 =?utf-8?B?dmpjcXVDSERzd0RVcmpPbmN3ZFh6Qks4aGNVbHhJR3o0QjF5Zk4rcXBOMUhE?=
 =?utf-8?B?Z1kzQXB0ckR4UDRKajRCMCt5Q2Y4SittNnBwNEJ2V1g3WXNhVDFqUHJTODR3?=
 =?utf-8?B?VlZhM2s2ZHBRMWVyTU5qdHNkbytwODM3eGdTL1lXTEhnTUpmOGhJVjM3eFVu?=
 =?utf-8?B?M0srcjl1d25LSi9jMzFDclRLTms4MmhHSWJ0MTcveW82eU9acUJPTDhpWU1M?=
 =?utf-8?B?STNkbGcrVmViVUpCaDBpVWg1dXN0WDdvM1ZBR3hMMDFKeXpMTm5EaVlqSEhW?=
 =?utf-8?B?THlkdkNaRHFTK0ExNXdyanppaTlqREc5T0pNVUcvZHc2djlqQmZaanlBUnkv?=
 =?utf-8?B?YkFxSElucnU2UXlPZzBlTldXNDQ5WCtyaEdIVEEvNHQwWHFlTE1Fb21DdnpW?=
 =?utf-8?B?NUF6NUdzUDhCWlVFUXEwSjFpVTFJR0g2QUR4U3pZVmlOcG5rOCswS0VOTlk0?=
 =?utf-8?B?QTRiZU9ab2c3MnowaGNua2FqaHk3M05iTnBza3RLdGpSQXE4Z1R5em9aRzNj?=
 =?utf-8?B?RHk0ckNGUkpYeUdmQ3I2ZjdLcUR6RHczQjZtd3NlWnFKanBHdis5UEQ1T05K?=
 =?utf-8?B?aTlaS0ViZnZnN2NaaWRqM0VUamo5dmxwYTZvQ0JNelhXSjVwS3dBcHhGamN1?=
 =?utf-8?B?dXEzTklPNlRNM3RuV2o1dloyb2lFS2E5eFBLek8zVVRMK2xkS2NwQWIrVW9x?=
 =?utf-8?B?QkRqbXVNQk10ODY1L1I4R1pzMWpGcEIrWWxnclJOT2tMSFl1anRJWGQ2ZFVN?=
 =?utf-8?B?bVFscWtVOFZsbnJ4STh0ZndVcXpWeDR4dzZkZXVJSkZsUEJFdWpkSUwvYjhW?=
 =?utf-8?B?MHFzV0ZrVXE2NjVqRnI2RGk1bTZGUk1PcVJmRTdreVIvTm1XbGwwT24zV2kz?=
 =?utf-8?B?RGd6NTI0ZlRmcnJoQnNHeFZZNG8rRHNtMC9ZWFgzWjlFcE1iMG1sSzJIUEpw?=
 =?utf-8?B?UzN1Q3ZqN3lYM1hWSWtqVmtiZXp4b0M5M1V4N0dLOVBhNUlxRVdDazFPVzFM?=
 =?utf-8?B?dFJEbWVOZGlWTnkvNmxRMFdFc2wvMmx2OEZJeFNJa0ZtYWIvRmRhTVFhVURN?=
 =?utf-8?B?SXYzZzdTY1ljOVM3WlRudTNwR2ZJY25uN1o5NmlFeTN2eVR1UjNob2x1N0RE?=
 =?utf-8?B?RzJkSDVwQyswRUF2THNJbUtoT251cG5pS2lvSUpBSjc1RkxZNjZnNi91Umx0?=
 =?utf-8?B?T253MTkxKzBPMnJPVnk3UW45OHFmaHZ6SWd5Myt4b3BCSjFiT1V4SFk4cVNP?=
 =?utf-8?B?TlkrOUVBS3U0U0NOQ3ZBL0owYjVDSHFIYmFLMlphMDc4Zm5hQjMyTm5za2tk?=
 =?utf-8?B?K2lLbHh1eGNwNVoyOCtlVXl0eERwNnJscTJxQktDdTJiSG40akxudDFsd3dv?=
 =?utf-8?B?b1lRaGlXVHBvVTdrNkVqL2VObGUwOEtIME5RbkhqaWF3ZkhsVkZCckxpS2ps?=
 =?utf-8?B?QVFaZTljMEM1RFA1eVQ2M0hvSS8zZWhER1htWHZFYnE5NnFFYkZrTXA1ZnRV?=
 =?utf-8?B?S2tLMHVQVDRqMlJXb3NlbXJBQ212TDZ2Y21LYlRnc3FKY2VBaU15b3d5UlJK?=
 =?utf-8?B?RXlPMkNBTWtBdVlWaE9IMm1PTW4wQTdYdThsYndMR3Z4K2VtTEVLZEtQWXlh?=
 =?utf-8?B?YTlxRW02RWVPQ0lPTWhMQmxZL3NoSDg0TGsrUDZZY3hWc3o1V0lYVFNDd1pZ?=
 =?utf-8?B?WGxOOHExMUpDQU5CdUVCRmJmTjVlM3dmN2RETUd2aDQwWFNOZE5GSjdXZ1RE?=
 =?utf-8?B?T21UUDdWZnU4Sk9BSEhYb2JETE5Sci9pbkU0YXBZelR5NGowcmpncXEyc1JF?=
 =?utf-8?B?d1A2TEZjZHV4MFVDNFlCRTBvT1Nua2xjV2F0aFpnOUNNcjZhVVZSSVNPMWhy?=
 =?utf-8?B?OFRxS2d1TENHNnh0ejBpNGdpM2dLUjV0dU5TbWxvN20rZnBINWcrajdWcjkr?=
 =?utf-8?Q?n2Lo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9dfd73-2603-43e8-6551-08d99ee6d2fe
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 16:27:27.2528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLrfChqbKzvhPwTbEWivW/yx7JWwy+PZY2hfHMwl/6B8jKCllTRB/R5DqH7/xBKk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com,
 youling <youling257@gmail.com>, zarniwhoop@ntlworld.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021-11-02 11:53 p.m., Lazar, Lijo wrote:
>
>
> On 11/3/2021 12:53 AM, James Zhu wrote:
>> From: Yifan Zhang <yifan1.zhang@amd.com>
>>
>> When IOMMU disabled in sbios and kfd in iommuv2 path, iommuv2
>> init will fail. But this failure should not block amdgpu driver init.
>>
>> Reported-by: youling <youling257@gmail.com>
>> Tested-by: youling <youling257@gmail.com>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> Reviewed-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 3 +++
>>   2 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e56bc925afcf..f77823ce7ae8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2398,10 +2398,6 @@ static int amdgpu_device_ip_init(struct 
>> amdgpu_device *adev)
>>       if (!adev->gmc.xgmi.pending_reset)
>>           amdgpu_amdkfd_device_init(adev);
>>   -    r = amdgpu_amdkfd_resume_iommu(adev);
>> -    if (r)
>> -        goto init_failed;
>> -
>>       amdgpu_fru_get_product_info(adev);
>>     init_failed:
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index be26c4016ade..7677ced16a27 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -1031,6 +1031,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>         svm_migrate_init(kfd->adev);
>>   +    if(kgd2kfd_resume_iommu(kfd))
>> +        goto device_iommu_error;
>> +
>
> This also brings a duplicate iommu resume in the reset path -
> https://elixir.bootlin.com/linux/v5.15/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L4612 
>

[JZ] Hi Lijo, please help clarify this duplicate case.

Thanks!

James

>
> Thanks,
> Lijo
>>       if (kfd_resume(kfd))
>>           goto kfd_resume_error;
>>
