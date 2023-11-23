Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA065C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 21:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 517B710E190;
	Thu, 23 Nov 2023 21:29:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A00D10E190
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 21:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c14xS7U2j2JfZHnU5rZtSWbyrPa8Of04Iogq8a/7DBkYW9QF4Va0T/2kCZw2Jnog0qX5jfzQ7hub3Nt5UuSEDErEVSERVBXbRV5gyRBGoURZaEE8NYI2UJVxD/4x3qkXASjaUscZSkTu3Bjf0N5UEeqT4m0ZdAGVYrJGB5LHV6AnWThYAHuj3WfHhAu61JVMGa2QSjnYPwqQO512BsH1EcaNTqNfFoLyJScsCdK2N4BNiiZObkMKrzkY+WwVg3rsZTPgfz4FxP5gSkqYwC/VviEYCp5+hxD5wxPgb07rAaSzTQK6tLH58YKIU3WrlsVF4mu2sKjvf4R6VyFrFrNmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/u7hhds+MifEGrgu+F1tNPC3mT7Q5YyhYQpVj7Oksk=;
 b=Ca8yg3ly1rbiC9MabIeltrsdfOpENYSsGRcvAsNOQLltfoEUM/EaD7seRo1EN2dIsj/mYHqdTgouni07+xGF7AzGUZutgZH0tRE7TgbutzgM9ZcGlJqSu3iABLYRv7JaP62gTHES2FbEO+VDmxNvb+Z5ZppnmfXhJi0MVhYPeOllfmtNO9jSU3UvWO7FMCntAylduFQpGdmne+d4J8v4ZMtajJbN+tXNGqtASmZ6pw4R4ikOeC5kSEplSFyQhjJzjIpc1zCwO12MhB4F/XqKVgQRnTRFdgWC24JalFFMIrEMnc5420vmx9GRhKXCC4nQ56WsCvtHFULlruOrWq5ZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/u7hhds+MifEGrgu+F1tNPC3mT7Q5YyhYQpVj7Oksk=;
 b=j7u254KUVeL6nCTP9vg/gfyPgkaOJ+7n3xmgdZYRwRnabvnopxb6Kgxd/F6qDdrUuwsBkiQhw3oSRbDXvQiP2WcDULLHVq14NXkRc7DblsM76fiUwfrY7dFpm5pvP1OZVpz76ssERWhHlTc0MXGtKZScvKD7nAdb0d/UHV+JbZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 21:29:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 21:29:39 +0000
Message-ID: <8ab4ed57-ef19-4dbb-9acb-af655bdfa448@amd.com>
Date: Thu, 23 Nov 2023 16:29:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: SW part of MES event log enablement
Content-Language: en-US
To: shaoyunl <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231123194819.1041850-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231123194819.1041850-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b00cd6-cedf-4908-26aa-08dbec6b4cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPxAIudm4elq5HBoGu7sxc3nWZ0s1CKzkj0bIawyOC0BJ5I6UZwIbgvDXpyrLu8BeWSDSUYJN2qh+bjGnPChW94plIT35001Er6ea1pX41TFmdH6DtzPIiu0YR2pR+kjK3cRmsvVDSPhp6wFe5oTtM+55Zt+o7eTJ2Gm0RA/G3Q/LCPR2VMkv/og3wqKc4GZlJe1oXDOaufqH2YJvUbB41Rh2/mChZBv7kfe3PDQAWkJwUTpY9IlXDgtwkZPjrl8nafQgJtjYYdlj3tSM4k96ND/VhLm0pcIYjcUbJZe9W+XY319mozfzzDw8MRFwM2efAUZjHxLfpP931QDsT9/w7PqlzfQMO73Z5QkJ4cRCOJpfFWfrfM+jurhOeZPEE3W2ctV6DR1zhNEpaAHkJHGEi5Ye0Emf0UwMR/kfsCuFDUcComKO7Arnvv8Qdf3XGFtl14qVOGHlwB1XZvlVkwYwq/p0a7lDqmRV9bxGKkv/Ak9aeTVIklnee19qQUvETrGR861u3//ByYwfVJJ7Mth+SZ5jrHcIb6CDuqlHLSXAykABLsLu71R13q7L/5M/m5cSa86DHIl04l2LB0G1uC5twRgXwUhEbBUg9Jwl74xbXh5Icd9DI5SH9l91GzmaxDqx5SUA6FimTgbVgfFYsWrWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(36916002)(53546011)(6512007)(2616005)(6506007)(44832011)(5660300002)(8676002)(8936002)(41300700001)(478600001)(4001150100001)(2906002)(6486002)(316002)(66556008)(66946007)(66476007)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkR1WnZGeUpzaEtVNVJuNTZRcjBYSFptMnB4eTFrb2k2aDZjelBvSXlTWTY4?=
 =?utf-8?B?bzFhRFhFVEE0MEFZVE5ORHRMWmh3eGg0UENQUEdYa2ZZK2JrT29neExxdGE1?=
 =?utf-8?B?ellVRFYrc3NYbzlZM2Y3UnBQSFF2T2xyenFvWWFVTTRNanlOdHNLOTJMOW9i?=
 =?utf-8?B?bTR6REIrUXVoUHk0S3RVYVVtOWdSRWVvWWIxRmExOWZMZjNwZm1EY21oQ1lZ?=
 =?utf-8?B?bG5lNmNZSFRaQXNZcFl4djZmckhEQkNPL3JsdzBMYzFML1JpbmJjV0ltdTFF?=
 =?utf-8?B?OTJCQzZwM1JNb2VtK1BDR0s0bWVGZm9HRUJ5K3hDRWx4OUZCZDdnUi9qVnJy?=
 =?utf-8?B?aUtuK2FRQUhNeVBBeWhzUTY4azdkZXJhZDVpUWZsT3RsUER1QUhVdngwRnRQ?=
 =?utf-8?B?OVhGYmNJM3VDWFlEVkdMQ0kyU01qZ0loUmhyeVNtamxsRklhcW1HdjZJYnZF?=
 =?utf-8?B?SklkQlk1Y0lBaXFZZHRvTFZhakoyS2tJVms2WDFIZXZCNDdxSGFRUVZzN0JS?=
 =?utf-8?B?VVV2b1VNWGYzcE4weFh6bjNqQ2lWUzdVbFRRYlQ4TzErMVZDL0hJYk1HZkxa?=
 =?utf-8?B?T1QvaE45djR4b0hIMVRTM0lFZnNRNUREWVE3TXAybEFQUFpoQng5NXdMaUh3?=
 =?utf-8?B?NzJ6bG12NHFSQ1FIa3YwRnU3czNTZEduTFkvNGltR3VsaXlkMWFBV0g0Vjh3?=
 =?utf-8?B?VVdibzR2Y1AyS2o5RnRNWjV4RW5yN1F6OWZvQ3hXTC82V2FsYXZjSUhrSlIx?=
 =?utf-8?B?WlhRUHBRM2hoa3I3d1NLbzVrWGhKWWRXRlNJM0Q1cWozSUJaVlVza290c0xT?=
 =?utf-8?B?R1QwYm1XWGVFM1J1eVNaa0Z5VmJLS0g1eHJWMEY2ajRnTm0xY2FNb2p5SXU1?=
 =?utf-8?B?andmUkhDRHpJMkxHbWNUWVg3aVFCaFE3MW1XZXk2ZmFRL0RnbWFCakhiSXM4?=
 =?utf-8?B?Rmpoc0VCS2IyVnRSa1dFWThVb0ozMERQM2pIVTJXQ3RTeXhJczZockNTajNC?=
 =?utf-8?B?WURaajlHSFFHQW90Y25HMzJ3c2tZSktQRVFueGxNcTd0WHJoMnBrVjduMW9s?=
 =?utf-8?B?cmJZdGhqaTF6T3RhVlFLTnEwMm5KZ2VMTkJSdlVxMm9RejBjV2JuejVpSkJS?=
 =?utf-8?B?U2dWUzlqMzhkVUdkc3FxUHZOZG9EQ1hHQ0ZwNVpwYy9YQ0liSFh1cHdqckFH?=
 =?utf-8?B?K1VvVHkvWlE2SFRDZUVWdWlIb2tuZXUyZ3FIRkRWd1ZzRXM2NEptNXVIdTZU?=
 =?utf-8?B?T1pNSk5qRFhXTklrUnJtOSthT2FPV2tKUDNrSmJJdHRYMzJkWVl5aWJsZGVj?=
 =?utf-8?B?bm1qdUl6MFJpVTczaGFiS2M3UFdlUmphUUkrTzFENXI3ZjhEaHRUSGxuRUtN?=
 =?utf-8?B?SHpGT2dqakVOeWxhTTI3MmdVVllCZE5JeFU2Z1hoVFh3alRkZjczSnhDQWJz?=
 =?utf-8?B?V0c1cmpPdUZZZkRDby9pQUNWbEJ6b0FKTHBpcEFKK1lHWXZmSzgrNXkxcit1?=
 =?utf-8?B?eFNCS0JBK1JBeWEyVnVoN21RZi9obURpWnpGckcyUmQrZjRkV2tnS20vbnRP?=
 =?utf-8?B?SHBHV2VLUm9nTTNuU1lvWG5QVWcrNEkzM0pYVlk0ZWNDTFpxTVpkc0lkZ0NU?=
 =?utf-8?B?QzcrL3pmR2lFMG05V2xqUVVuT1lYRXpnRmRNdzRVTENvSU53aExmUjhZdmRs?=
 =?utf-8?B?OFZMQTdJeVJKWGdORlYzTzRCMVJ2MVQxVC93aDkraFJxeGtGUjJTcHhKYm14?=
 =?utf-8?B?L3pwL2FVaU1OT1dhZUhPdzBXdEQ4UzBlUWxhTnNteURXSDBWYVBJYmFGVzhO?=
 =?utf-8?B?Tkk3dk5DT3dnQld0V1JKOUh3aldtWHdqelh0V1RBWlcrbXd6UWdPeTlsRHov?=
 =?utf-8?B?L2Vzd1dvV2F4RWJlTWY0dEJyOFo4MDBOalZCemhUbWhwWUJoMFN0MWQveElU?=
 =?utf-8?B?aStvNk5ic0NERUh1ZDFIRVcxNDNZcmRvY3RiYmpUSENMYjB3dWhGaW82UWRW?=
 =?utf-8?B?RlhDWjZITXNndXd6OTdsMkZMenNNakRkTTBoSFF6cUkrSDNjMHp5aDFSR3RM?=
 =?utf-8?B?WnJwU0krdi8xK2dEejR1WnYxYmxRcnFoWXd3bk1OV2ttOWRsZlRiekFBNGNp?=
 =?utf-8?Q?pil5TmIUU6zFuEeSB8qjs4SaE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b00cd6-cedf-4908-26aa-08dbec6b4cd1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 21:29:39.9131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEAYi1tigwmVC8hgvtUN1xKI+h2iVyhXjljwjZrWscll97iCNhM+ERdLjgoYB1nF+ouvDt1po+PYn9wXaDaNBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
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

On 2023-11-23 14:48, shaoyunl wrote:
> This is the generic SW part, prepare the event log buffer and dump it through debugfs
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c     | 61 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |  5 ++
>   4 files changed, 70 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index a53f436fa9f1..8b2cbeae99ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2140,6 +2140,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	amdgpu_debugfs_firmware_init(adev);
>   	amdgpu_ta_if_debugfs_init(adev);
>   
> +	amdgpu_debugfs_mes_event_log_init(adev);
> +
>   #if defined(CONFIG_DRM_AMD_DC)
>   	if (adev->dc_enabled)
>   		dtn_debugfs_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index 371a6f0deb29..0425432d8659 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -32,3 +32,5 @@ void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev);
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 45280fb0e00c..b4ba556dc733 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -97,6 +97,26 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static int amdgpu_mes_event_log_init(struct amdgpu_device *adev)
> +{
> +	int r;
> +
> +	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT,
> +				    &adev->mes.event_log_gpu_obj,
> +				    &adev->mes.event_log_gpu_addr,
> +				    &adev->mes.event_log_cpu_addr);
> +	if (r) {
> +		dev_warn(adev->dev, "failed to create MES event log buffer (%d)", r);
> +		return r;
> +	}
> +
> +	memset(adev->mes.event_log_cpu_addr, 0, PAGE_SIZE);
> +
> +	return  0;
> +
> +}
> +
>   static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
>   {
>   	bitmap_free(adev->mes.doorbell_bitmap);
> @@ -181,8 +201,14 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   	if (r)
>   		goto error;
>   
> +	r = amdgpu_mes_event_log_init(adev);
> +	if (r)
> +		goto error_doorbell;
> +
>   	return 0;
>   
> +error_doorbell:
> +	amdgpu_mes_doorbell_free(adev);
>   error:
>   	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
>   	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
> @@ -198,6 +224,10 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   
>   void amdgpu_mes_fini(struct amdgpu_device *adev)
>   {
> +	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
> +			      &adev->mes.event_log_gpu_addr,
> +			      &adev->mes.event_log_cpu_addr);
> +
>   	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
>   	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
>   	amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
> @@ -1483,3 +1513,34 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
>   	amdgpu_ucode_release(&adev->mes.fw[pipe]);
>   	return r;
>   }
> +
> +#if defined(CONFIG_DEBUG_FS)
> +
> +static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
> +{
> +	struct amdgpu_device *adev = m->private;
> +	uint32_t *mem = (uint32_t *)(adev->mes.event_log_cpu_addr);
> +
> +	seq_hex_dump(m, "", DUMP_PREFIX_OFFSET, 32, 4,
> +		     mem, PAGE_SIZE, false);
> +
> +	return 0;
> +}
> +
> +
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_mes_event_log);
> +
> +#endif
> +
> +void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev)
> +{
> +
> +#if defined(CONFIG_DEBUG_FS)
> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
> +	struct dentry *root = minor->debugfs_root;
> +
> +	debugfs_create_file("amdgpu_mes_event_log", 0444, root,
> +			    adev, &amdgpu_debugfs_mes_event_log_fops);
> +
> +#endif
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index a27b424ffe00..894b9b133000 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -133,6 +133,11 @@ struct amdgpu_mes {
>   	uint32_t			num_mes_dbs;
>   	unsigned long			*doorbell_bitmap;
>   
> +	/* MES event log buffer */
> +	struct amdgpu_bo		*event_log_gpu_obj;
> +	uint64_t                        event_log_gpu_addr;
> +	void				*event_log_cpu_addr;
> +
>   	/* ip specific functions */
>   	const struct amdgpu_mes_funcs   *funcs;
>   };
