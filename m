Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D555FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 12:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA8A61166
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 12:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CA8A61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C376EB78;
	Tue,  5 Oct 2021 12:11:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457546EB75
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 12:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWL+vH/jrAicBlcpJ/IFQDUDmgEgzcuzUBo1gzGf2EkS4O98xdbaDJBYC6aSzlEZ7UyOvBiXv6UUk2CGocvlxCi0Sejwzp9ZPUf722dRy7iGRC8lfDMN53UsYn0qiLsWd3okFXJ7RoqD82mv6FDdr9OTjL7gborWH4ejcdrPO87XEqx1keWj7wMLZuVIOHhMCIsIons1eC+O+AC90GA5lbQPq8L5Vm+QMWuHfJrOnPkWnO57KUnrz+nTuWuJBUxUnB617q1KNpOvfkbeH9WxEU96QGVD8+WRr0C+hupLVXn5E9CeiQmVVbftCSvHOTiH/xyo9KvgJ9nk3DX5xPBTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRrGRtIEIsCpN6soZePvcdTicLGg9T6sM2U8ya5i9W8=;
 b=OVampxdC7sHtB/BPEbifb+k/XETDoBOW/XAOcft9cGSsrOIcsakNyRxigXrFeL+FDzr04V1q6wia47W9Wfm+OsMI9yMTCTtSDpwZkqssnNMgKTxM5hCD/yNUCyXoJtzP4sKGSawBDqgNKuD0J1rp1lpf45Ix7CL6xJpkl4tp0RcRdIvpKEFAozEmwJK6M5mh8kD/eO0JdFA6V5s6dRzxaPv9KeTGDhiWNIZf9Fhva2oQe71SIC7e4khG85oTYGR5xC/BAEaJ6t0gyx6S0NSXmnZG8Jc4t/s/1OH2mJw6wU/vvY674zGfH59kmRXSpcWeySIjJmL7Fny7MA1fp/Mqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRrGRtIEIsCpN6soZePvcdTicLGg9T6sM2U8ya5i9W8=;
 b=hTxqiN9P/bTY/pU6AIp600w51qJ7Acjqca38iQZv4c4W+xgEvShPgUKW+zHl2AQnWhw5vfBpYv2GaMwiXiP597zVyz76DAstBxRSEYNTOHPEBnS/Q08acUaymhnMsRl9C36gXSgH9mqWR8uUk1T4rv7nTAv5XBuoUMXrCkFLncE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 12:11:43 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 12:11:43 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: init debugfs drm driver callback
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, shashank.sharma@amd.com
References: <20211005115856.59649-1-nirmoy.das@amd.com>
 <015bf2cf-f085-0d55-17e2-f9583e0533ec@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <31dc36e6-122c-4f91-f885-20833b4318d2@amd.com>
Date: Tue, 5 Oct 2021 14:11:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <015bf2cf-f085-0d55-17e2-f9583e0533ec@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR0601CA0083.eurprd06.prod.outlook.com
 (2603:10a6:206::48) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f22:7600:b5bd:631d:2ddc:3835]
 (2003:c5:8f22:7600:b5bd:631d:2ddc:3835) by
 AM5PR0601CA0083.eurprd06.prod.outlook.com (2603:10a6:206::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 12:11:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a042cff-0696-4e00-4cd0-08d987f94b6e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB536031844C820D3E4CF1E9418BAF9@DM4PR12MB5360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUvX9f3pAkR9Zmq+dKfqDBKJH+TCXL0EQRBL72OHg7X/5nNi1FkwMthOTJPPYiFrvVZ9Xf4ilDdM7/E5iIOAugD3haaTR3txA7H6dGAmEWIacLJIU8qhRgcbt1IMDtM7igGcROm3fjDAUZHkY/W8SMRk61HRkjWkkOIrlvOPODqS+OrJgnr5GUtFe+bkI5drvENiB3ZWFcvcgNXZKa2ZjAQCkeroxfyqGpISPEjOgA4Nct9EgrQB+vIacZPrgaK+lUy9x07GFeYFsZREWJW32+KPrHGrrPlRWlkSJswfnKY52+/Q6XZ8VCSjL1/A3ZUi2rwOdV3rPJHFZg8WP27lfhMO0GGGsFRSEw5jUVKyvcJ1ygeMCEWxJR9dJy0ggCvNlYyVL4Z8Ln4w0dxg+qCD/5WojQMW43myM9CORqXhhLf3Luq9/bZY5ue369mwvW8qY+i3AbbQ2BZBVvmSQRvLC/bjUCF27FxfsapHW2QAzCwNiRZIu+ZL3OaCijxZqlotbm919JuQipfxDs16pAxeHXlg3lj6VcoQ13h1w+Bp7M8znRwj79xLU6exjWpz7o//MhE5BGS+VX+5V4H0VTMoa9nOfHH9DgcLtM/d4yJhe2rJXtuM/X/3ELEQ2vP10qzvFQ+Y+uNsO7+6Pnlv+JEJC+U7xwfYgV4tMtM0RyErZqnRTDvCec9M2eVzObSaNNCMT1K3PeWw82H6i0brLOVV43ErKIrA6jEScDpDxqw3AoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(186003)(31686004)(36756003)(508600001)(86362001)(53546011)(66476007)(6486002)(5660300002)(2616005)(6666004)(38100700002)(52116002)(8936002)(83380400001)(4326008)(66556008)(66946007)(31696002)(2906002)(66574015)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWFJQ0dBZ1VXSTF3cEE0U2xDZkNXVitORzlPY2lTVUY2M05FazdwUWpEN2lj?=
 =?utf-8?B?OW92MjN1S2RVQTFSeGxVVEpRU3VBUVIxS3hLd2k3bC9wVllGMmkxN2JaRlVp?=
 =?utf-8?B?MFVrdWYyYVpiT3hnQ2huSmNQS3d5MkdTYzB1dHdZamgwREdEZjdrbWNNaFB3?=
 =?utf-8?B?dllYZFlMT3BxMHUzcS96a2VBNHdVeEFPMXVjeExVZkhrNlVTVUJzTjFMbDAv?=
 =?utf-8?B?RElHRUFCQjZNam14UmRHRjdyWmdxVFY5NUtpWkJHYXI5TDNHTG51OExnR3Nw?=
 =?utf-8?B?bHVSS0hEK2RVT2p4U0l2K1FTK1kvZHpLNy92OW02M2Z2S1FMeUR2QTY1THR0?=
 =?utf-8?B?S3o4ZjM3V294NHUvT1hYWEhUckxUY1JWVzUzZXFUYWtYWEN3RFBPRStFUS92?=
 =?utf-8?B?WVVMeURBMjhwOXBPVkRIVTdaNUMvNHA1NGVzYjhzUGNUM2t1OXVqTXEyQldm?=
 =?utf-8?B?cXl3OVBidCtqNmRBNk9MdUV1dXR4WVo1RzFtN1NHdFBBZEx6czY5YUwyN1ha?=
 =?utf-8?B?c005eEVMaEJpYVVNazlhcC91UkdlbG95b2hQSlBYaVFSQ3RnSnpoZWhXYWdD?=
 =?utf-8?B?TncyMCtYZGlEU0dXTkoxZGI3Y1VYT29CajBsNmhPZTh6OUhoZDROMWkwOEhZ?=
 =?utf-8?B?elRmMUErQmNjbk9xeGVINmIwb1BWR0hleXNGTG0rUlpieDdWUmRLa2F2KzE5?=
 =?utf-8?B?MGpmRi9reXhBamp4OE91eXhvUm5HUFNGUVFDbWdYZUFVTGFWSVgxNzZlTnEv?=
 =?utf-8?B?R2x3ZFR1bndtTmFYcWtidkExQ1Nzek80WnVSQlBBaUhzK1NGQ28wQTdGaEd1?=
 =?utf-8?B?NEhLeS9vMzV5RVdFSGpyUUE4YXB3OWZENXFvbDNqRWpkNUNGcU82KzFXdmJl?=
 =?utf-8?B?dDBZR3lSbk91Mm15ZWh6NUw5RHB5NUJLbXJQNVBLdjVZTFdCZ2QxYlpFOTMz?=
 =?utf-8?B?RTZ6RmdQNTFPeVNWUGdycU0rT1c5OG5oT3lCMDBvNCs0eGpHSFFVUHdvaGVk?=
 =?utf-8?B?VVU5Zk5TWmNUMlkramhka0FoTEFDbUozWjd4eFFhSUhjV3RDcGg3dk9nU2NH?=
 =?utf-8?B?cGMwdWZsRjQ3b1NyZXhKWitIM2VXMithcSt3RFc3cWtZNUM3V0VaUStQcWUw?=
 =?utf-8?B?MzNtTnl5ZWtTVk5HVnNOUFUyWGkvajQ4aFRKTUJXOGdRVExXQk1BK2c2WmdM?=
 =?utf-8?B?ck9VTDVKQnhwb214UXpsWUNDbFB0OXU2VmJicjBEdngvTTE4M0RrRjBEWmdF?=
 =?utf-8?B?RUEwd3R1cWdEcTZhbE1mRW0zUm5lcXZNdEx4OERqTVRpOEVtMEFsVS92cnpp?=
 =?utf-8?B?bmZjTm1zenNuTU16dlpvd08rMGhhYmxtUENydUs1L0VQUFpmQnoxS0dzYnVM?=
 =?utf-8?B?OGRqK0dZWVNkRHE5SitEMGl1UURPVkFSRmh1WHdmbzg5MWsyUHBaTzF3emZS?=
 =?utf-8?B?YkFoaGNaMzFIMUF5aVU5Vm5rOW42S0E0V3RtUWtSdVVVcklUREVWdnRiL3l0?=
 =?utf-8?B?K0I5UXZqV0RTTGpXZElXbUR0QUdnSXNqUytjZ2kwMEpqV0h1ZHJuZE0zWk5m?=
 =?utf-8?B?b2dlN2xlRE16VDgwaFNsQWszdnVvalNTdzEya3ArK1g2S0dyWHBRUzVmeGRB?=
 =?utf-8?B?TFI3UnNsRXhnZU5NM3owYUIxbE9QSCtGNW9yRkcxdUl4Z1JkYnU4cmhQTWRi?=
 =?utf-8?B?NzJUUVBwMlVtSHBtWGN2TTFBNTM5YlE3Smt2NU1CSGNhejdwSmFTdUhQUVVs?=
 =?utf-8?B?SlNHeVNwdkF0SFlWQ0kxaHRWTG42R2FXVzM5RXpMNmEvdG5oTzVqNXZnMHh0?=
 =?utf-8?B?d2tEeHlCd05IMEZKdHg3WThFd05GK3hYZk9tWFdiQTRySVZMMXdjMXR4YXZG?=
 =?utf-8?Q?td8xq1Hqeo4fb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a042cff-0696-4e00-4cd0-08d987f94b6e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 12:11:43.2907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vxzwc7rMgXWasBjBxe0XXw4kC6sztsa7ZKYZClnqz5q4pnAIUZJNhrGpx7Kw+RhoS20sO7FHTJux6+fMSmlWPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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


On 10/5/2021 2:01 PM, Christian König wrote:
> Am 05.10.21 um 13:58 schrieb Nirmoy Das:
>> drm_dev_register() will try to init driver's debugfs using
>> drm_driver.debugfs_init call back function. Use that callback
>> also for amdgpu to intialize debugfs.
>
> Mhm, why is that useful? We rather wanted to get rid of all this DRM 
> midlayering.


I was thinking of not calling further debugfs  APIs if we are unable to 
create the root dentry itself by adding another

patch in drm_debugfs_init(). But I agree with removing DRM midlayering, 
I  will then add a  IS_ERR(root) check in amdgpu_debugfs_init()


Nirmoy

>
> Christian.
>
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  7 +++----
>>   3 files changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 6611b3c7c149..3076742f8f85 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1611,8 +1611,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>   -int amdgpu_debugfs_init(struct amdgpu_device *adev)
>> +void amdgpu_debugfs_init(struct drm_minor *minor)
>>   {
>> +    struct amdgpu_device *adev = drm_to_adev(minor->dev);
>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>       struct dentry *ent;
>>       int r, i;
>> @@ -1621,14 +1622,14 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>                     &fops_ib_preempt);
>>       if (IS_ERR(ent)) {
>>           DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs 
>> file\n");
>> -        return PTR_ERR(ent);
>> +        return;
>>       }
>>         ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
>>                     &fops_sclk_set);
>>       if (IS_ERR(ent)) {
>>           DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
>> -        return PTR_ERR(ent);
>> +        return;
>>       }
>>         /* Register debugfs entries for amdgpu_ttm */
>> @@ -1682,11 +1683,10 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>       debugfs_create_blob("amdgpu_discovery", 0444, root,
>>                   &adev->debugfs_discovery_blob);
>>   -    return 0;
>>   }
>>     #else
>> -int amdgpu_debugfs_init(struct amdgpu_device *adev)
>> +void amdgpu_debugfs_init(struct drm_minor *minor)
>>   {
>>       return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> index 371a6f0deb29..06b68e16e35d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> @@ -27,7 +27,7 @@
>>    */
>>     int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>> -int amdgpu_debugfs_init(struct amdgpu_device *adev);
>> +void amdgpu_debugfs_init(struct drm_minor *minor);
>>   void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index df83b1f438b6..ceda650895db 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2012,10 +2012,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>>               drm_fbdev_generic_setup(adev_to_drm(adev), 32);
>>       }
>>   -    ret = amdgpu_debugfs_init(adev);
>> -    if (ret)
>> -        DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
>> -
>>       return 0;
>>     err_pci:
>> @@ -2479,6 +2475,9 @@ static const struct drm_driver 
>> amdgpu_kms_driver = {
>>       .dumb_map_offset = amdgpu_mode_dumb_mmap,
>>       .fops = &amdgpu_driver_kms_fops,
>>       .release = &amdgpu_driver_release_kms,
>> +#if defined(CONFIG_DEBUG_FS)
>> +    .debugfs_init = amdgpu_debugfs_init,
>> +#endif
>>         .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>>       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>
