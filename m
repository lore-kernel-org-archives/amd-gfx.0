Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41291C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 11:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0343910E941;
	Wed, 19 Apr 2023 11:45:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A04C10E958
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 11:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZCXhbZwCdju9TaFOriHsUq4SPRuK39EKmM5IVj0ahQWery2r7FaQSTY/pV9DvRsjEpGxHV8guVSHR1sCA/PNjh5Lcsgaml3FRxz3YEMAKLCcU7L/bRDACZBn8Zt8JuN1xeTcrCNwvRqGpK67eZhzFkgDCiE3Atxmd++9fZteECJS/O3vXHWzv1kNFjXMBwXUKufctiEP00E3WDruM+Qg2QO7TZlb34CEIqsXv0xSSPDSp4mAvHzbOsCQXD0sRrvegtrQwTEMMrCU6YUFXJ8RxnJKoOzLTJoRY/xgqmolt2c82QVevXDzV5cQpV+SRKjC0WVvtIKl0bzdFzWdpuaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KBHenuWKKzlDkg7p3yAVW2aJBP1L+6mOaT0Jw+plv0=;
 b=YaJzK/zsg/mQ/KgzJ3jF5vNZk8olLgzcC7gLJh2m6q+S4XPlYh3koJNahtheEuzy1JMcyRUZQO4e/aFB71LT/Wl8nowfVIyfuBKk4hWQMh1gEJYa6YGVmAqpA6vbNI/pRywlyMn+8XKkaC7szWaj9lHhbbgruYXp8DR5H4+1ovcbRUNZagdii3sPP8Ie/ejdNs9RVq2Whjx6uDVByH+CJ7ViOLfd85Fcfds7I8HRHk1NaeB08w1bb36IS8wuCJ5qnkGQ/pEVHyNhAkoavQCOtp9x/ji6pdwtBgnAnsBYndn6eTv2VrDdv7DU+e66UxhwRoHv9OyjpdRNnNBE7A4G1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KBHenuWKKzlDkg7p3yAVW2aJBP1L+6mOaT0Jw+plv0=;
 b=utN7SPYuFPBoGPxqIt/7FAS8VdA9yrdBdzxDgvdoQKu2tog1MN5OFnh0o2wHXOV4akDG63suUITUjbyHevPgb76qo1F9/8cuiD6GQbAcJsdTiIRNdG6JL13JpsBqPMhHfYRYJfVRwNJStaljXSrxtM8Lxu8j/qXtuFYaAfaMXx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 11:45:27 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 11:45:26 +0000
Message-ID: <e3fb4f8d-43ab-2110-42e6-2097cc9907c3@amd.com>
Date: Wed, 19 Apr 2023 13:45:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix style errors in amdgpu_drv.c &
 amdgpu_device.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20230419114249.123333-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230419114249.123333-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: d24c444e-d2b8-4293-6511-08db40cb9171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sg7x9SKUfPllI1eTW8z2oM392JPtXCqR+KlF98nmM8QpnXXefUMYzDjk+xOnHquP6v2WRgPoZ0eiQ/X2H53ZVh6OHOgleKhARPWKIwnGfz8f7yYrfcf7OLpn2k0EWq9jRE6z3OTjF795TdcbJpHM1h8692dNqn2noTK6FBrn9nuytCyfatrWtAcav0T9QUVzv3kIgqeIRbTfJlqRk+moanWe8wx1XgmJWhuEnpbhVEGuQ4j+UEGYUtZvZqT7BwkUZDXOmi7C2YqGtkUn3oGaR+4HG5+jX4/lMGIA87VMTSR6v4yX53G/98kStJ3QGe8vB6E7KaN1+xytwieR273oDESQI/dbUspz9qnHapnPY7I+S8KuG+Jv/vCvyvm/fP0ylvgzlYD8TXN/jp14b/V8Y7l2MqaI4ijUVIng547/098ed1N05JYy/bqx6lvO78ABk/FNzYNG5Tp9KHqB4i/VnFQ5m2ShBY+mAXN9RyLp8heVRGcm/P+ax6DIJkHNfs4v1PHm2xtVrzK7GUkxxDr5pIT/PukBZEG3sKR4olvaCUzYXUZNP8Cinc1vXuPNj0CQiJN2Y5cmpCLOGzd+yD622kpg+EA0vZuadP0TwRhXiqegSqqKV9q613byNe/EKfeRj7xaQDMGWjr0x8RYMheU3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(2906002)(8936002)(38100700002)(8676002)(5660300002)(36756003)(86362001)(31696002)(6486002)(6666004)(6512007)(6506007)(110136005)(6636002)(478600001)(2616005)(31686004)(83380400001)(66574015)(186003)(316002)(4326008)(66556008)(66476007)(66946007)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlBrbHZzWW5BOVhQRkxnZ1pBVWw2V0I1NExpbTRlbnhkMFBXZzEvU3hmTzYw?=
 =?utf-8?B?MXNYV1F6QXdsWWZWQXdGVXMrOHpsK2lZVXNJOTU5aUNGNzlHS3Y5NFd5YlVK?=
 =?utf-8?B?VytnSDFVN25YT0orbzVtaERBYjFZYUFkdzRnTDJqTmJpLytMVC9MbTY0bkdP?=
 =?utf-8?B?aGQ5MmtET2JFYzNva1duK1Z0K2hmdnRtTkhZYzN4cEozNGJNajVFQ0VnREdG?=
 =?utf-8?B?dW5BK29ZZDZ3L1pCdFBRRDdCaWFSZ2pDb1lmODZIeVJGTEprTGlIeGR0Zy9j?=
 =?utf-8?B?bzc0SUlJOGNma2RhelVja2NhYXMyVGpMWWV6UUNGK09PZGxHVWFJMDlOREZB?=
 =?utf-8?B?SC8vMTlhZDRQZmYxTGQrMVJtUkpobGwvT3RQTko5OGZQVkl5eS9leEJ4Rkha?=
 =?utf-8?B?aVU1NEVsS1BFcFMzTUNsVTVtQTdQTXJZOEJzRnFmUktwdTJBY3NSTk5yWnNj?=
 =?utf-8?B?MFJNZDhkOU9JTmJNZ2pEVjNXb0huTDU2V0ZFV1AvWXhwRDlENktiU0R0UVky?=
 =?utf-8?B?MFdMd080MVowRWUxQnloVnNDU2hsajlDOGJkZWVUd3FoVnAvN1JJY0JNZXVN?=
 =?utf-8?B?a29oTmhlc2xGQjhIQWRvR1pQODJaQmtNWG4xaHVNdEJHTlVkSGk1Nk1pejZM?=
 =?utf-8?B?Z250aUpyN1ZiSDNCTTFCMzZBNE41V280R1h4OFQ4SkZlbDJDakhkUmFRY3k3?=
 =?utf-8?B?ZjRjYnBINkFMd1B4a0FvbGU5clZOeHptVEg3b1o0WFBvOUJkMm0xT2h6aG5n?=
 =?utf-8?B?RkdVejZSd3d4T2tWQlU5ejFGMktIbnQvL1gzRUd4VEdHbzFzNzFpWHNKbEZY?=
 =?utf-8?B?aXhFTUgweGN6SUt2dThtOW1FTCtRMDJPci9iRUIramF4eW16OVVEOWl2V0tz?=
 =?utf-8?B?ZXJHZjZ6TUxOSFEvcmZWb0dWRnF4V0tBNXV0cXFubTN1SlBmcmY2OVNmVWY4?=
 =?utf-8?B?SzhESEUvTWQyZ2NqbGdnWnY0Ykpnc2tPdng5VlE0TzRjOHBWbmJxdzFzdWlN?=
 =?utf-8?B?VUhjSlgwUFZDbWFmazRtYjdrUUZwS3g4ekpvRWhYajVGNUdFUStVYzQ5MWxU?=
 =?utf-8?B?K2lOVjF5NyszUk1tbjBEdHNLNFNnSEs2L3gzM0FUM0lveXBzUTBhOUl0cmFZ?=
 =?utf-8?B?NE94Vi9WMzBMcWUwNW5yYlFGUVYzSXlsaUJxOUhQajBRVHBMYklNMHZDcmVQ?=
 =?utf-8?B?QU1zc2hrblhwZDNoSWI5NDdPUzR0VE1DSDA4N1JRMmVjbmtiVjVaaVhLLzZB?=
 =?utf-8?B?SW5OUUp0Yys4WTFQd0xYTENHKzB3aklMNWk1NlQrMXZUOHp1czk5NnhPNWFt?=
 =?utf-8?B?WUFnbW9CRzFwSm5xMTNOb0UwWjdvSWpFbzJDeDlXdVZmWHpuVWgyR0twWDd5?=
 =?utf-8?B?VlBJQ1gyU08zVVplRkxXT081RGx4Tk1weWRIRVhQNkhBVUc4M1c1aVBmeEQy?=
 =?utf-8?B?S1Y5aUVSSUFDcmo4Y1I4L0pxVlo5YXhtK0pFQVBMYzJFVFhPNVNHcUVNc2tW?=
 =?utf-8?B?YnhNK1NrWVNqaHgwL0REbElUaVViczdycFJCdzhSM0dtWEplZVVxaG9Pcy9z?=
 =?utf-8?B?aDk5THh1VXBkZFovWUpuTmpTZ3h2TWpiQW5sM3AwZ3psK3FDRUEvRTVMM0Vt?=
 =?utf-8?B?WHNTRXRnbDRJV0RFV2ZGTVBwbkkvTllyVUFjbjNuV0VPRDhxUEplc1RhWjZp?=
 =?utf-8?B?NFFBd3JTZ3V3aTVHTEJOYmxZSjczMktuN3R3TVFBb050VDNJRHJwb1EwTS9v?=
 =?utf-8?B?S2dCbDN4eTVWSk1xMXZPWWVJNEtXUGR4T0hxcGJmSGRTL1NHYmJ2YVVYMVdJ?=
 =?utf-8?B?V3g3bXhWMDlMUzIyQ2RQTzhaMDBlUnNoMUoxSzJBRlJIS2xDU1lJcnFjRTFX?=
 =?utf-8?B?QXU4OThuT3lvcW8rUDdjc1dxZWtkZy92eDBZWGhGdkh4ckQrWlV5d1JWYWUx?=
 =?utf-8?B?S2dUOU9pVi9pWmQxUXR2dGxWS0FJOVAwd05oQ0JjRE1Jcm1uREJlYkhGTEx2?=
 =?utf-8?B?aG5WQ3JSMHZ6REFBbnpqVkxvY1FoYmphUFdGNzBDbk82ZTNKMS9zUHRYdHow?=
 =?utf-8?B?TTVUTVo1Y245WGhndm1ZTkdsM2t1a3pXeXk1dHJJano2L3pQd1NucENlM1d0?=
 =?utf-8?B?U3NnYzBHekE5V2FWYmhiMXNLc1JrRWNLczJtbkV5SjJJbTRDdmtkRmVaYUs4?=
 =?utf-8?Q?4Bs1fxHZGn4KuC2GsU2H3guf5uswh3inb3qY11kfBUtQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24c444e-d2b8-4293-6511-08db40cb9171
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 11:45:26.8642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWcGPQwvMQxne2awPkDINoXp3SGmMkgMa9KDT36y1bbwkKUnzkX+SJZyPtxTZPQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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

Am 19.04.23 um 13:42 schrieb Srinivasan Shanmugam:
> Fix following checkpatch style errors in amdgpu_drv.c &
> amdgpu_device.c
>
> ERROR: exactly one space required after that #ifdef
> ERROR: spaces required around that '+=' (ctx:WxV)
> ERROR: space required before the open brace '{'
> ERROR: spaces required around that '||' (ctx:VxE)
> ERROR: space prohibited before that close parenthesis ')'
> ERROR: space required before the open parenthesis '('
> ERROR: space required before the open brace '{'
> ERROR: code indent should use tabs where possible
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 65 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
>   2 files changed, 34 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3e854cd8d22e..e536886f6d42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -997,7 +997,7 @@ void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
>   	if (array_size % 3)
>   		return;
>   
> -	for (i = 0; i < array_size; i +=3) {
> +	for (i = 0; i < array_size; i += 3) {
>   		reg = registers[i + 0];
>   		and_mask = registers[i + 1];
>   		or_mask = registers[i + 2];
> @@ -1546,7 +1546,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>   		dev_warn(adev->dev, "sched jobs (%d) must be at least 4\n",
>   			 amdgpu_sched_jobs);
>   		amdgpu_sched_jobs = 4;
> -	} else if (!is_power_of_2(amdgpu_sched_jobs)){
> +	} else if (!is_power_of_2(amdgpu_sched_jobs)) {
>   		dev_warn(adev->dev, "sched jobs (%d) must be a power of 2\n",
>   			 amdgpu_sched_jobs);
>   		amdgpu_sched_jobs = roundup_pow_of_two(amdgpu_sched_jobs);
> @@ -2758,8 +2758,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
>   		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
>   
>   	/* For passthrough configuration on arcturus and aldebaran, enable special handling SBR */
> -	if (amdgpu_passthrough(adev) && ((adev->asic_type == CHIP_ARCTURUS && adev->gmc.xgmi.num_physical_nodes > 1)||
> -			       adev->asic_type == CHIP_ALDEBARAN ))
> +	if (amdgpu_passthrough(adev) &&
> +	    ((adev->asic_type == CHIP_ARCTURUS && adev->gmc.xgmi.num_physical_nodes > 1) ||
> +	     adev->asic_type == CHIP_ALDEBARAN))
>   		amdgpu_dpm_handle_passthrough_sbr(adev, true);
>   
>   	if (adev->gmc.xgmi.num_physical_nodes > 1) {
> @@ -3088,7 +3089,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>   		}
>   		adev->ip_blocks[i].status.hw = false;
>   		/* handle putting the SMC in the appropriate state */
> -		if(!amdgpu_sriov_vf(adev)){
> +		if (!amdgpu_sriov_vf(adev)) {
>   			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
>   				r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
>   				if (r) {
> @@ -4035,7 +4036,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   
>   	/* disable all interrupts */
>   	amdgpu_irq_disable_all(adev);
> -	if (adev->mode_info.mode_config_initialized){
> +	if (adev->mode_info.mode_config_initialized) {
>   		if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))
>   			drm_helper_force_disable_all(adev_to_drm(adev));
>   		else
> @@ -4698,42 +4699,42 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>   
>   int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>   {
> -        u32 i;
> -        int ret = 0;
> +	u32 i;
> +	int ret = 0;
>   
> -        amdgpu_atombios_scratch_regs_engine_hung(adev, true);
> +	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
>   
> -        dev_info(adev->dev, "GPU mode1 reset\n");
> +	dev_info(adev->dev, "GPU mode1 reset\n");
>   
> -        /* disable BM */
> -        pci_clear_master(adev->pdev);
> +	/* disable BM */
> +	pci_clear_master(adev->pdev);
>   
> -        amdgpu_device_cache_pci_state(adev->pdev);
> +	amdgpu_device_cache_pci_state(adev->pdev);
>   
> -        if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
> -                dev_info(adev->dev, "GPU smu mode1 reset\n");
> -                ret = amdgpu_dpm_mode1_reset(adev);
> -        } else {
> -                dev_info(adev->dev, "GPU psp mode1 reset\n");
> -                ret = psp_gpu_reset(adev);
> -        }
> +	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
> +		dev_info(adev->dev, "GPU smu mode1 reset\n");
> +		ret = amdgpu_dpm_mode1_reset(adev);
> +	} else {
> +		dev_info(adev->dev, "GPU psp mode1 reset\n");
> +		ret = psp_gpu_reset(adev);
> +	}
>   
> -        if (ret)
> -                dev_err(adev->dev, "GPU mode1 reset failed\n");
> +	if (ret)
> +		dev_err(adev->dev, "GPU mode1 reset failed\n");
>   
> -        amdgpu_device_load_pci_state(adev->pdev);
> +	amdgpu_device_load_pci_state(adev->pdev);
>   
> -        /* wait for asic to come out of reset */
> -        for (i = 0; i < adev->usec_timeout; i++) {
> -                u32 memsize = adev->nbio.funcs->get_memsize(adev);
> +	/* wait for asic to come out of reset */
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		u32 memsize = adev->nbio.funcs->get_memsize(adev);
>   
> -                if (memsize != 0xffffffff)
> -                        break;
> -                udelay(1);
> -        }
> +		if (memsize != 0xffffffff)
> +			break;
> +		udelay(1);
> +	}
>   
> -        amdgpu_atombios_scratch_regs_engine_hung(adev, false);
> -        return ret;
> +	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
> +	return ret;
>   }
>   
>   int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 03e928123d71..ee3d241195a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1661,7 +1661,7 @@ static const u16 amdgpu_unsupported_pciidlist[] = {
>   };
>   
>   static const struct pci_device_id pciidlist[] = {
> -#ifdef  CONFIG_DRM_AMDGPU_SI
> +#ifdef CONFIG_DRM_AMDGPU_SI
>   	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
>   	{0x1002, 0x6784, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
>   	{0x1002, 0x6788, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},

