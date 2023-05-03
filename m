Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CB6C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 13:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B544210E152;
	Wed,  3 May 2023 13:37:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C2A610E152
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 13:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrQK/b2V+jXEowIUnDYQ39UFb+Cm/KVGLo+7c+5CPP+QORogGIasoQX/tsHESCDoAmAqayDaFYimhA7pAjD8KI59W7opawNIvm2D4tnIILOxAQ9bEZPLDn6aV22niUhYMWoVzz+ClcYlXvq+3Z/Qj1cQhJSQ+cHQQ3fVMkuqbE8r9aa6B4TvQ4mVPiO9LQbhl3SOdyBngbdMsab7JCr3qUyYgRv5hw6DAanuJZmqzD2ZCesScwow6dZfp4QFlvc41rEBJm+suSup7utQ4HjPKORLw6Qse5AflFJvIEFuXYb0iqZmiXxwwe/QbgPQiON5uoCFU5BdFRDthZtbOpLvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5/nFFp0pPJCrUBOoJD7nxT1ONhIMTwZQpbye08o/EY=;
 b=CWcdIyVuHqiEEJDHNf3khtifPK0FHWDcyiT0nR/kJ+6drMPLWYWcRkBc8ya1PvfpPFiMpKcJciHvI91G1s6d8NBTMCRn0YZeaV3poIvs6boCa2PdjpF317lCi+0ggmqefBooCB7Vl/Z9po+nO9hanORYzjK2sFelOeJrj33742sFVGh4DRpNxdsv+dCkEi2wCRNt5ILoGf4F/kQjFiGYlFNnN+/DyWdisu+jXwFMwSOzqTObQQuWbDByTxJcoAiQ7IkL+MDVNdgt4bA0qy+2QNIB1n75ncIdBkFHWHcwxOmPrsIoNOBnI1Ig4+Xv97Oa1ciBnKhO4IibHgqhs4XU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5/nFFp0pPJCrUBOoJD7nxT1ONhIMTwZQpbye08o/EY=;
 b=B6llqce5MlN5Cyw8ndxmXUKTI4frWLTulvT8O/TXjtqJHVGJYPn01a/kCm/FQGStIuKqtllQZ+MrZRl2GTobuyqGAXxMmYP3XoSmWHSm6mPK8A17niNA0ztJP+7jbqaySz6KhK6xVAEB9uim8LbfvTvdVbPThW7t3K275lQ2TN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 13:37:35 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 13:37:35 +0000
Message-ID: <3ff39778-2dda-14ea-dc2c-065391406c36@amd.com>
Date: Wed, 3 May 2023 09:37:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] drm/amdgpu: put MQDs in VRAM
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230428155714.1141266-1-alexander.deucher@amd.com>
 <CADnq5_MP+DN0KKPVRik0iqx1c3j+utbGoUDCcppqqf=w6popsg@mail.gmail.com>
Content-Language: en-CA, en-US
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_MP+DN0KKPVRik0iqx1c3j+utbGoUDCcppqqf=w6popsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::38) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: bd038a51-256a-4ecd-7f3d-08db4bdb8dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oqr5MLPCqVqz/36KjJuR6w5ZpekafF87MbBtCBxdR9FvTFvWfICJJvEL9YrzUruFpVgXaEB6cIvlAXPmXdwAPoQiUpRb2a1D1VX2ntBbKf5n5o45zHbmeqly0jGh9xtcxSx8qDVRNdPipeLK+g4jdGIX8YoZuL3XGtnjvuCmhyri/iiTLx9x0PXyESeQcGwMDXM7G2gsnxDB028D+bfrEGa2YsbiSNJ4JeagnWLBcFy/2avllrBnLPIwTBxmw1FBvgyKTdc0s0JZplInGa42sjWlGE0Yjxm/A1k7e17A1yy+dlziieE0IKfq9ld7ks78gDU26+6mU3Gom7R80Xk7d03jdtp7gaEceU/7ORl1Spa3NrydmY/oKYs86Z2tEAmcMxc0pqZOalxzcbts9Ol+kd7DAN0b1CNIeS1f1YlBwjx9L/2ekjbANfriENiMX6bmI05b1a5PwC1D1YQ73i7qmc0vBQf3Zt4MftQ4IDC0vcfYlMmeJ5ice+6dO6rnnEdXWoqjuifNxGZcUNkNN5x4+JGVyAQJUcezDRSZfgr2QbXhkBSSB650QQyIs+pnEpcK9wIDnBa+caL7zNBQFm332nd3KL97zMXIqvmhBiEc5gS1kFjpw7sL39T7l3J0D7TgQpos3C+mS1VLYwaXK/w9DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(31686004)(6486002)(66476007)(6636002)(4326008)(66946007)(66556008)(6666004)(478600001)(316002)(110136005)(31696002)(36756003)(86362001)(83380400001)(53546011)(6506007)(26005)(6512007)(8676002)(8936002)(5660300002)(44832011)(41300700001)(2906002)(38100700002)(186003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW1qVHkvRHRQMGZiSU42dmhIcUs2dzNtRUU5K0d5d0ptaTZTejZQb2pJditj?=
 =?utf-8?B?bS81b08zdFZwSVYwZ0dGbWJoOWpDY0FNRjl3Y1Bad3Azc1lkUFVCb3Z5eXdv?=
 =?utf-8?B?SlZyVlJiSHdweERWbTR5eGtXVzNGRjRlUFJXYUt0dDEzTzErbUNIVlY0bUtH?=
 =?utf-8?B?Tm5zZzRyZVZ3SSs5R21CYjB3OWhWU1REdVQvUDVieW5sL0R1TFQvUmVSaTZz?=
 =?utf-8?B?R2VrKzZZQ3VvdjBsaURYZkhBTjNkeXRrYkZXTDZza1dPd1pDU0xOUC9wK0U0?=
 =?utf-8?B?Qk0yZUZOWkhWUytnN2t2WElsSmFxTHNjdFNIeDJVamtnNmFuUzhUTDFVajNP?=
 =?utf-8?B?dFpVdHhLZWE0TzBNMWhBMTc4MDNqdFBNRDA4Q3UvVlZBQlFRS3ZvVDlSSGp2?=
 =?utf-8?B?OUtqWWVTRkdXV0RQaHNKeGl1Y1lkamtGSDkrcTV3eWZFVXVCbGEyNlBWYmRD?=
 =?utf-8?B?RGJzeU84bSs0ZFQvbEIzZ0RCQ3N6dlk0RmhUN2hmNzJFZVFnOUxLUG5TUmNL?=
 =?utf-8?B?Q0NnYVNRTzBVTlJjWlVDYnZCVGtTN2VubGlSSHpRb3NYOGlkQ2huSkpJbVI2?=
 =?utf-8?B?SVRxemJMRFBLQ3VFKzRPSmoxMlkwLytyb2NRZWZ4TXFOcjdKVUlqckowbUM4?=
 =?utf-8?B?QUxIbVBGYUliQUpjeEkvZTJUMjZUbW1ZOUo3UDBTTlgrRndYV2hrZkxRaHB1?=
 =?utf-8?B?VzZ6S3V6MHY2UXN0d3lDM3pyZDByTk90NHd2bmpXSU5FeWJIYi93ZjAycmI2?=
 =?utf-8?B?OWYxTFg1Q2wwc3VnSGZkREZDT0xFZHVDVGdUQjNkaFlCZUgzcWhxWGxwQ3FC?=
 =?utf-8?B?OEhNOWt6QUNvZ2RvMEpNTDVMR3hoSXdYbkd0VmNoeUk2T3dlWWh5OVJaNWV6?=
 =?utf-8?B?bVhuS01OY1YyZHo5akovenBjS3ZJQWpjcy9uSWxwRm5EeHVnemtuVjFCWTZm?=
 =?utf-8?B?L2EzU0VyS0cvWloxVndFdGMzTlVHaUwyQk5TekhidE1LQ0V1TmxUSlRScEVN?=
 =?utf-8?B?TlBxVExzRlg2c3k5SlQ3YklReHVWYWpnYThUTit5ZUxxcGFiOXlUNHdDZWJr?=
 =?utf-8?B?QjRDRE0xOVhlWUY2c2xIdjhYSnoyMjFuNS9RRERkN3l3RE9MeU1QZFhpK0tB?=
 =?utf-8?B?b1F3SlZJc05nMDRDZ09yTFlKajFwRUxhZklLa2tRQmhrSnFHV1VRazU3a0l4?=
 =?utf-8?B?ZFFia3A2RFo3cWVUdDlPVithUWRRM3YwTzVwYVVuRzBjSnUybldhaDY0cGZl?=
 =?utf-8?B?YTZqZjZCR243S0UzSVNMeitUUWhVY3hzQzNoaWhiN1U0SXBvYVpyODRpMHhR?=
 =?utf-8?B?TXByejU5bFRlT2tSSzZSY2pPdjNqbzF4YmFPUEJUSHNuTDVTKzI3cEdvWkM1?=
 =?utf-8?B?M3JaWFE3ajlnTlI5WG5KY1BZb2MvdkZqbTBvR2FLVE5Ka01sRStVVExONXFi?=
 =?utf-8?B?OHlSYVlFWDlUeEN4OXdob3V0V2Fmb2F0eGxSN3dzOWF0L3BlMUdvVGR1TUVx?=
 =?utf-8?B?TW41S2l1Mk5DYnNGMkRHMEd6RmJsMnlJMjdPd2oxUFpJbFJwa3BjZy9SWG9E?=
 =?utf-8?B?T2lIN2dibHVZMEluR2lxRkpzTTl1OEJxOEdVNFd4SERQL29Jd2E2d2F3cDZT?=
 =?utf-8?B?aXFiWjFOWUJ5M3ZzRmpDRzhzbGJCZ0I3bzdMQ3AwK2M1cnU0eEVBMm4vWFFJ?=
 =?utf-8?B?dGVON096SFRaZG95dkIzWjZNaFhBOUhoN3lyMytZR1pVM2JtbktVdm5iNmFW?=
 =?utf-8?B?Y2RCbW52MTdUdk1LRjFHaTR1TTA1UXpSaDRRa2I2bk1HcFJ1SUU3RE1TeU52?=
 =?utf-8?B?bXJmMGpJQlhaU3REb3owOHFnd3FXZS9RbWVDNHl6bVdPY0x5SGJFRjdDMklw?=
 =?utf-8?B?ejJyb21YY0JNVGhBTjlRTXlFcG5jYmtVejNwL3R0c2lrOFRFRlIxRVlkSDdM?=
 =?utf-8?B?NWJhWGFZVG5WZHFnMmxFKy9lLzl0RE84RDFwK1RMbXlQSk5wc0w1MmltbTB0?=
 =?utf-8?B?NDNwNnptQTdzZWZadXh3bVVDcm5iNnExMmpRMERvbE1zcFFzNGJqejRZbCtp?=
 =?utf-8?B?eVljd3pob0xMQUpNcGpUc2hYZ3Q0TktaY2IxSjZuSHFENFJtR0dlNmw0Q2ZH?=
 =?utf-8?Q?jqDnPFfI9B0xr6GMIkP3Es4mF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd038a51-256a-4ecd-7f3d-08db4bdb8dee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 13:37:35.6015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hd9VsXfWPrwZDrC4xSdRm/BjeSW3CuV8sqsVN8oTpUm6ClvI33pqwmsmxPleQlUo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-05-01 10:55, Alex Deucher wrote:
> Ping?
> 
> Alex
> 
> On Fri, Apr 28, 2023 at 11:57 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Reduces preemption latency.
>> Only enable this for gfx10 and 11 for now
>> to avoid changing behavior on gfx 8 and 9.
>>
>> v2: move MES MQDs into VRAM as well (YuBiao)
>> v3: enable on gfx10, 11 only (Alex)
>> v4: minor style changes, document why gfx10/11 only (Alex)
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 9 +++++++--
>>  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 1 +
>>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 1 +
>>  3 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 90f5d302d5f3..b91be56ba773 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -382,6 +382,11 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>>         int r, i, j;
>>         struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>>         struct amdgpu_ring *ring = &kiq->ring;
>> +       u32 domain = AMDGPU_GEM_DOMAIN_GTT;
>> +
>> +       /* Only enable on gfx10 and 11 for now to avoid changing behavior on older chips */
>> +       if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0))
>> +               domain |= AMDGPU_GEM_DOMAIN_VRAM;
>>
>>         /* create MQD for KIQ */
>>         if (!adev->enable_mes_kiq && !ring->mqd_obj) {
>> @@ -413,7 +418,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>>                         ring = &adev->gfx.gfx_ring[i];
>>                         if (!ring->mqd_obj) {
>>                                 r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
>> -                                                           AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
>> +                                                           domain, &ring->mqd_obj,
>>                                                             &ring->mqd_gpu_addr, &ring->mqd_ptr);
>>                                 if (r) {
>>                                         dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
>> @@ -435,7 +440,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>>                 ring = &adev->gfx.compute_ring[j];
>>                 if (!ring->mqd_obj) {
>>                         r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
>> -                                                   AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
>> +                                                   domain, &ring->mqd_obj,
>>                                                     &ring->mqd_gpu_addr, &ring->mqd_ptr);
>>                         if (r) {
>>                                 dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>> index 0599f8a6813e..4560476c7c31 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>> @@ -901,6 +901,7 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
>>                 return 0;
>>
>>         r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
>> +                                   AMDGPU_GEM_DOMAIN_VRAM |
>>                                     AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
>>                                     &ring->mqd_gpu_addr, &ring->mqd_ptr);
>>         if (r) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> index e853bcb892fc..3adb450eec07 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -999,6 +999,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
>>                 return 0;
>>
>>         r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
>> +                                   AMDGPU_GEM_DOMAIN_VRAM |
>>                                     AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
>>                                     &ring->mqd_gpu_addr, &ring->mqd_ptr);
>>         if (r) {
>> --
>> 2.40.0
>>

