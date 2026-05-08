Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103A8CD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 10:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A072A10E5DD;
	Fri,  8 May 2026 10:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TznJziJI";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1293E10E5DD
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 10:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf16eYIzZW4XpiW5utein0XUjZGov3wcPspTBCBwFav0FPyZzRFRTOPljZv4HG4Y8cu4kH88L2Nj/aP0zSvnj6w5yyllVgDP27YJfsUc7SIwX4byN5K/YyYvn4Q+WTVhzp3dwedSjj0DzHlrkWnjZ6kQYySfJb+bfhzWERg5RINdZnDpi73RN9up0x6bxDoWCjofchTUVsR6PhV4qslRIYTOfa0kdh0nc2bL821fynlRG2M2g4BnHDEmXYV/Cz1SSWwJxVSzaYzygPHyH+yfBl27aoIN0p0RTk/zsv5OLjKBCP7+pd6q4qkzTKlsg70K7x4BxRA6I1rD7U0Rn5kaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SruzKeOGpqcb1VtTKey6ihTHq5Lf+7DV2H3W1/m7gx8=;
 b=pW+/qp4abKpnmwslGLil+6X8DLcw8D6eUYfQSbFSPSuAecVV23HvJY4rrfxuuqIwt4KF7HUqb9ZOwswuC5IyM57iEA0bxy4Ad0E83tfjPysCM5i3WdO0+yr9E4qFSk0y92BF3rdReJFwwzfbPl277yItcDvN9l8wphFDLD6FkCwqMtdTHwLc2n+2wH7wA7Ksy7Hqw0SX7UHyZosddTDTynq1hGef4OFLaFpZLiGp65rhO73ma1kvlm/xTWPsl+7KSyTdu/fErPab6xMM84TPTFwgaoEdc5m8mlSo6yURAcuavevj41FXtuzp2+acnnJ/jPhXiHmsdaAU8Sp91jH7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SruzKeOGpqcb1VtTKey6ihTHq5Lf+7DV2H3W1/m7gx8=;
 b=TznJziJIqYgITqll9IKIRKwWImrkrs+uZX9UZkTXFqsAU4ZVX3i+B7KnzdVr4QK5v5AguxxU+NXvhhHI4phlAyTzK+67v0XOyzXkLUrdGS7o/062bne9TwXW6lKaxIDqmKZ5eWfN9uHuqA9RQ5RhnfkJ6ZFdPAUrnE1CB59LqRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB999082.namprd12.prod.outlook.com (2603:10b6:8:302::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 10:13:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Fri, 8 May 2026
 10:13:39 +0000
Message-ID: <b4da0b5c-73f9-4063-89e4-dbbd08e283ab@amd.com>
Date: Fri, 8 May 2026 12:13:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add guest driver CUID support
To: chong li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: HaiJun.Chang@amd.com
References: <20260508075335.574374-1-chongli2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260508075335.574374-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0390.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB999082:EE_
X-MS-Office365-Filtering-Correlation-Id: adcef72e-b5a4-43e7-4302-08deacea796a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: sKDnCg0gi6PvdyWmwv2LsgBIcEdSQqY0kTOJKeN0TMfX/twX+SERkmtfqwQjU1i8TJYeuobyvEEFDSEY51oEOB0MhFnUrABU8mEK4pkzo9DdLBkkrWdesWDAj41p9cNEemxLiinN1R+jIN2oqfiJBezZO3uL7742SBxW6GGyG04zZhOxFdPA8MTV+y5ICoj+L70RLlraw0TF5axCuYLLjTMR6srpVTr3CkvuujD5CO3idNFg7R92etDp+CRw9hwn26gQ6iwXXpoNYHfIbzRTfO8QVGlYumpRQRKnS54d7idD2/40PT0pFw/AoIwEbOTSM2ZrCGJ7uS6MFswrtW7ozCql+oAnUXpMPWT6OpJVKJoqLWmYBUA20NJBjxo0im2U8LT/e941Bh4bI8t5svLqtD5DkEc7qsGXHLGNzz9jNDZ625FBncYXSIrsA2Dcqo7MTzdibJntO/ZNLdOrNKYGLG0m65GREt45Kk3rRMj2h6JWxlwZx1HBK9YTDE0DEG7eTJqiPZ9V6+WqgM+A4YYnz64+CkAYNw+/8w6oQvk91LPUXfJbC+IzLx1aRQq5r42M1rlwYMZ6CItXHX7KzW1th1uf/1598G34G6/VBuyop0FYhwTdxzRYRFGzoOcbZ1RsN0aJSIMwuIAWegTX/UpdhNDkZfFHL4wtUt+Dzs/x9cJppfkOK731iz4u9N5LPo5R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3lTNmZ5dmZacW5BbTcrVXR3TTJGWkRpMXArTkpLcXd4MUloVmxCSlNnVlVD?=
 =?utf-8?B?Sjg0cVo4dmJrbWFqdzdYeUhiVUw3WFEzQ2RqbFBVb1FnRzJncnBwVnZ4UzE2?=
 =?utf-8?B?djRidWFXWCtXQTN2UFIvN0hSL3QwSTVoVWVDWXliWmZZSERwYzJVTUMzSXFn?=
 =?utf-8?B?bktrMGdkaHo0SURWTFU5bVd1bmF5VDE2bmczblg4NlV4elpDQW1PZzRCT2Uy?=
 =?utf-8?B?NlZqTkpCaURZS2hFYWVLM24raW9NaVYzeXg5NHlabm5SdHNSOFM0OEEyL0c5?=
 =?utf-8?B?empHTlZGaVIzZ2dpMnRrd09UQnRKTEIvblRSSkRrcDBHTVBTUGMzM0lRMWRs?=
 =?utf-8?B?aUNOTitndm5laVBkRG9BTTdLRTJLVWRJaldHRXNhNDBxK0pyY2ROdkRSUWxM?=
 =?utf-8?B?RFhsblB1YTdQZ09TblZLanFhT3dBV1dyTzdoZ2Y0blZtU2MwRHdoaG9VQlQ5?=
 =?utf-8?B?Wm9PU0wzWkFSalVRd0k3OUhTZkFHb0E5TURTQXVhWndiYnNlcDVldEU1TjJh?=
 =?utf-8?B?SkVXdmxGT2llY3FhVncyeXVxNU1QcXg4THk2eC9HZ0dvZUYvaXNqSTltK1JX?=
 =?utf-8?B?dkU1NDVsTkgwY0huT2dkMnkya1dVYUw3dEMvYjkxaldlb0thdGFaYlZzSUp4?=
 =?utf-8?B?c0VUcmpNalcxVUhkbVBTQkZvMlRjek5mVXVBZzhNa1VjdTNNYnVPM2lLYXA1?=
 =?utf-8?B?MUlzaTQ2QkpTUm1QUkZHWWN5ZU80Q3BUa25JQjFNQUIrblQ5T1pmaFZrenhm?=
 =?utf-8?B?eVBNcm5kbGtmUmJ2NXNtVkZTSWpjTk9OR0FZdVR3d0ZZSVd0anpLRk9zYWhU?=
 =?utf-8?B?d1llcTlQTXV0a0JrcEVVa0h6ZUJrT1dmNnFXYkJLRlZ0VDNmWlVyQjUyV3I3?=
 =?utf-8?B?QVNYR1RWZGp3QVlqTmYyU2wwVm9GNDdMSm85R1JPL21yOU5pR0ZZMnpIdWRz?=
 =?utf-8?B?MkhrQlpybGMvRkgvZHJkOUJsc21LY3k2NEl2a09pQWQ0bHo5M241OGE0RWNm?=
 =?utf-8?B?NXhQZE0ySit6bUYySUM2MmZDdE1ESDZMK1lndnozUTZGNUdIVE9KSTVHbi83?=
 =?utf-8?B?NnFHZXhyUG1ETVpRcWQrTnNpN0pwK2pmUHlYcDNDRDVqQ2EvQWJDS3RldFNY?=
 =?utf-8?B?QkdubWc5ZmNKdXA5bG9WcGF5VVIvdjZjZmZ2TTlucjRna3p5K05VSGdRUTBZ?=
 =?utf-8?B?K3dkUVk4ZlVDSFNwY0hRRmp0VlNmcFcyTjFHNlErZFpPeDBweDZoYnU4MDdJ?=
 =?utf-8?B?OVozdVRQNlVQUjhVMXBmZjFXOTNlZmxFM0dQeGtnWHNYY0tOT0dNb1ZwbTB4?=
 =?utf-8?B?Nk9rMjN3SXZpVFB3S2tYWURoaGEwdWtuRU0rQjljSFdQM0xUMndrWXNsdnZV?=
 =?utf-8?B?OXZzWUVwV09vYmNUWFVxVnRCRzNwTDB3cG9vTjRLbzlwL2IxZ0t1VkMwWi9u?=
 =?utf-8?B?ZzBXLzMvK2hPWUw2MDU1TjVGc1J1Y0c3SlhIeEpGa2pUUVZGUmtialRjNmkv?=
 =?utf-8?B?US9PTEwySlFYb292N21IN29KVjdiK3JSZ0lxMzQ0cmF4VEcwVXh3UHp2Njk5?=
 =?utf-8?B?QzVrRllGQ3F2QzJIeHRMUnZaaDZPWW1LNVFwZ1QxYzNWb1VqNFVQMlpLUmp3?=
 =?utf-8?B?bHpZUzFDZFZxN3ZXZWZlaG16Mmd6Nllpc3pvMWFsd0RLeHJwWTQvL1o4RlpZ?=
 =?utf-8?B?SnJzWlBqbytrUEl5SGxhNGNYdDVOZ0hiMysyaXlUYXB3N1Irc0JFSWUzRm9K?=
 =?utf-8?B?UnY3bndyYlJpZ29TNzBPNStLQUYyQmpVVDIrYjh2Z0RrRU5QUDA0WEJJVTRs?=
 =?utf-8?B?QTdwWHVFN3Y1dStsYlhqQmpOWTRBYXhjN2NzY3NlK3RmS0tCNHBEYmNjcEFx?=
 =?utf-8?B?azh3Nm1lZW1RcG5ETEVnOUJobTNEN1FTbE03T0Q2WU9XUXhGZkxNSWpyVkxt?=
 =?utf-8?B?TktzUnNzNlJKMUl6dHE5VGpHSU1VWW1jVWl1d0U1Y3BxeURITi9DTHdXTVhv?=
 =?utf-8?B?b01FL29HQjNLcFdHcVFEb2lSd0ZiOXVGM3Y3dnBQRXhYaDRTeUJiS3QwNjhK?=
 =?utf-8?B?TkNYMVJKRGpSS2lyUkE3blBwWlJWcndkS2FIQm1iQmxhMkl4VlV5ck83VXll?=
 =?utf-8?B?RXRHRmNmNmNLaVBEZDFSNHVXbzlic3d2UVZXNndRUXpCaWppRU43K3VBUGtH?=
 =?utf-8?B?Yi83aWk3cHZXN29Oem4xNEZsSGRTMGp0a1Nxb3I1UEVnVzd2MVZacDRHUWJS?=
 =?utf-8?B?SnBpenJodmNKclE2TlROek5hTWNMZmpuVmxoT29GMWJ1eXRXdzgyVzFRSklV?=
 =?utf-8?Q?fYTMN1IuHxzcDiOU/l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcef72e-b5a4-43e7-4302-08deacea796a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 10:13:39.4702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14dE3/y5SK2G2UsCIV7R9Kv9VvkODe9ADb7TWxVB4AK3OATLmHN2YOdQ8x/8aijN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999082
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

On 5/8/26 09:53, chong li wrote:
> 1. Add guest driver CUID support
> 2. Do not expose vf index(variable "fcn_idx") to customers,
>    replace the fcn_idx with pad.
>    Only expose the unitid to customers.
> 
> Signed-off-by: chong li <chongli2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 55 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  8 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  2 +-
>  4 files changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 80b18bbd7f3a..98549a148695 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1074,6 +1074,7 @@ struct amdgpu_device {
>  	long				psp_timeout;
>  
>  	uint64_t			unique_id;
> +	uint8_t				unitid;
>  	uint64_t	df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
>  
>  	/* enable runtime pm on the device */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 979032ecaf79..366e37db69d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2114,6 +2114,45 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>  			amdgpu_debugfs_sclk_set, "%llu\n");
>  

> +
> +static ssize_t amdgpu_debugfs_unique_id_read(struct file *f, char __user *buf,
> +					 size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = file_inode(f)->i_private;
> +	char tmp[34];
> +	int len;
> +
> +	len = scnprintf(tmp, sizeof(tmp), "0x%016llx\n",
> +			adev->unique_id);
> +
> +	return simple_read_from_buffer(buf, size, pos, tmp, len);
> +}
> +
> +static ssize_t amdgpu_debugfs_unitid_read(struct file *f, char __user *buf,
> +					 size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = file_inode(f)->i_private;
> +	char tmp[34];
> +	int len;
> +
> +	len = scnprintf(tmp, sizeof(tmp), "0x%02x\n",
> +			adev->unitid);
> +
> +	return simple_read_from_buffer(buf, size, pos, tmp, len);
> +}
> +
> +static const struct file_operations amdgpu_debugfs_unique_id_fops = {
> +	.owner = THIS_MODULE,
> +	.read = amdgpu_debugfs_unique_id_read,
> +	.llseek = default_llseek,
> +};
> +
> +static const struct file_operations amdgpu_debugfs_unitid_fops = {
> +	.owner = THIS_MODULE,
> +	.read = amdgpu_debugfs_unitid_read,
> +	.llseek = default_llseek,
> +};
> +

As far as I can see that is overkill, please use debugfs_create_x64() and debugfs_create_x8() instead.


>  int amdgpu_debugfs_init(struct amdgpu_device *adev)
>  {
>  	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> @@ -2126,6 +2165,22 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>  	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
>  			   &adev->pm.smu_debug_mask);
>  
> +	ent = debugfs_create_file("unique_id", 0444, root, adev,
> +			    &amdgpu_debugfs_unique_id_fops);

> +	if (IS_ERR(ent)) {
> +		drm_err(adev_to_drm(adev),
> +			"unable to create unique_id debugfs file\n");
> +		return PTR_ERR(ent);
> +	}

Debugfs should never have error handling. Please drop that.

> +
> +	ent = debugfs_create_file("unitid", 0444, root, adev,
> +			    &amdgpu_debugfs_unitid_fops);
> +	if (IS_ERR(ent)) {
> +		drm_err(adev_to_drm(adev),
> +			"unable to create unitid debugfs file\n");
> +		return PTR_ERR(ent);
> +	}
> +
>  	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>  				  &fops_ib_preempt);
>  	if (IS_ERR(ent)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 6974b1c5b56c..45e89e104b5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -534,8 +534,12 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>  		if ((adev->virt.decode_max_dimension_pixels > 0) || (adev->virt.encode_max_dimension_pixels > 0))
>  			adev->virt.is_mm_bw_enabled = true;
>  
> -		adev->unique_id =
> -			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
> +		adev->unique_id = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;

Please make sure that this passes checkpatch.pl. Of hand it looks like the line is to long.

Regards,
Christian.

> +
> +		adev->unitid = 0;
> +		if (amdgpu_sriov_is_unitid_support(adev))
> +			adev->unitid = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->unitid;
> +
>  		adev->virt.ras_en_caps.all = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_en_caps.all;
>  		adev->virt.ras_telemetry_en_caps.all =
>  			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_telemetry_en_caps.all;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 9dcf0b07d513..d80f01c0e754 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -295,7 +295,7 @@ struct amd_sriov_msg_pf2vf_info {
>  	uint32_t vf2pf_update_interval_ms;
>  	/* identification in ROCm SMI */
>  	uint64_t uuid;
> -	uint32_t fcn_idx;
> +	uint32_t pad;
>  	/* flags to indicate which register access method VF should use */
>  	union amd_sriov_reg_access_flags reg_access_flags;
>  	/* MM BW management */

