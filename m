Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C3606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bn1O1hjy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8851A10FF72;
	Wed, 18 Nov 2026 18:55:43 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC3110FF72
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 18:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fL7P7A4vuZAbNMUP0j7sHtL2W7MFP+vCLbWpC/c4WCMHVfyJlO0nGcTqAWcpZwJEnIXZKIuaEflwdSKuv8sHRwCaXQmQs7uDy0oL3u9nnZCnKVqKWgaLlOQl4zbuxxtnODnr+p9oxzioWZ+rIZfgOpR4+cVd6s0weowhpYoKGx4lpVqRmoKLY9r1AVWzAXRfIKiH3ITE/zHdQZY+y3CtCi6XK8mAGZOF9LZD3B4sfLqBYjZuQgMnnvIX9F3kSWUP/suGYN4MCCQuPxhu9fgQnBAWlvaKtu61zivCw4l6U4ythUNmbbXz8+ocS4FjDpvVPNQnlK0Q1R4gb2GsJHzaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RLWRqtgPNev0YRZfXYfemL03FSsk5SK0lCuIdS+K9w=;
 b=yxtKKvo+gbjq2h7ES9FLo/1Kmfwz6xUKUuVqweuPx9H3gJcWMOu3cUysPEvYSQ8TSKs5FyFNGJid7cDPaCmZIRcPJgIg/Iz05r+h0qoAyttnDbwpB0DPqoeIqNRezJESb0L9MZzT7+AwBwoI+ftwu03w7zGCVifdGdFfxIowHFceqKh/5oy3EPrFLcCzgjKb96rlYT0zkbrTKwGNvOtbKDI7eM+uVpxOy/QjL8bd+Ld0Wet9CiN8vFMj4dGNf1Cn5+V1FZKqfArzTp5MuFVwu7siXPsQSpuD/BgbVUlxtB733QcZKfZig5ith7PoWCibdJGMVNbM214B7bOlXUpzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RLWRqtgPNev0YRZfXYfemL03FSsk5SK0lCuIdS+K9w=;
 b=bn1O1hjyDAHOPFbQ6Ide4fh8LlbbByd5jYkUOvNUI9oCr9YMsQYMkE8jJM5sz1GbXmMAQt8pBZSHMJdrhk4ce+Uw9fFJkcIJoYPMUGjFupmU7SsIFMs3FR3STzYXEef3NOxnp8bclL4p+PlBgqQ6H89wxO+pHIGqTcXB7lOABCo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by LV1PR12MB173649.namprd12.prod.outlook.com
 (2603:10b6:408:516::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:55:36 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:55:36 +0000
Message-ID: <b9598ead-7450-40d0-9926-531414e6b8fe@amd.com>
Date: Wed, 18 Nov 2026 13:55:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Disable XNACK retry on GFX12.1
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20261118174238.159765-1-kent.russell@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20261118174238.159765-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::24) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|LV1PR12MB173649:EE_
X-MS-Office365-Filtering-Correlation-Id: e648248e-3675-4172-53b8-08df45a587c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|261009223027099003|18002099003|11063799006|56012099006|261102123227099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 05LsEd/SN4YdfDVpAfs8FHyonRgMPiC/fTkwsTUMq776N26PcIFQWt7Y8STvdcNQ34iQoKnh5Dyi7Jvkn8+Yq76y1YPYhwmMxpEQQNoWWtdHQ1PJ1eONXRhSKRujvraDgZ9hzkOcO1I9SIBZeJMgAbWoDXkuC6qbaJTcc6aairQ011RyyQMHKpK2165Fw7qDUogra3myVljZIGvTZpCI8TncK438oEnQ+MN8HNdwOD1sw4zn0oTXLQJpX8qjKce4+h2+xpbdVz6id0+zfbfE5aTBgEuQJeqWwZQhaqEd8bhimIESiRtZofLirR5znlcpgcqqLTzvDED5g8q46XIx9ErSOZ1yL3IgKWAuhUkGmQX10Tg+E/KTfL77sBayIMZxbeM1QPgDU5ICn+kfje2J9Y0THjgC4PC9BFXXEkXwXdJLZjKcnZK1RbZOeSPiTPC2HcxwN888bH3kY8NKLDFX5j7m/2KJP1H1ys7MNDxyJFRDsl4XjRsKY2AwidXPLjtZfShqBu0QFc4NQstTx3G8rP5RSJRPaJ0UtZxMOhyUO36wAiYXwX7+K9tAMSVne8fv02yDreOdRjugYYPsnNSZFV1mBokzDO/gSES4JNiIAGDJEOgM2rk0fRZxUC8OlaYjFjvZU82Os9gt15wwkJbs3m1KkHuUWHXNHc9IR+PKIoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(261009223027099003)(18002099003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGdFdDVXVkZDOGJ4UDJKTjl3KzZqdjBWblNkQkwxV2phaldNYUNhNmVUdjV6?=
 =?utf-8?B?Tzg4Ly9xeU44eDhJNmFqZTZEYmJzT0orSjNWQ2xlWXBPRkFOR3gvT2Z5OThl?=
 =?utf-8?B?SkJ3bU1IN1pLN2pVNUtQRERPRTZDMjZIaHNUMWw4UDhMZmc2eWdTdDJRTGpu?=
 =?utf-8?B?M2FvRlRNYURhbnJLaXpvbEFUODBiRUR1a0ZpZkdBWXduQmd2Y1hrWUZwMzR3?=
 =?utf-8?B?d0lvcWdZczVGWXBXeVNOY1BHQ05qaU1OY0YzTCtFV1loWnU3WERKYmpIcVV3?=
 =?utf-8?B?WGRzV2NtSm1PcTk3ZlVLeUhDUHhxV1pHUjkvRU9ELzZaKzhVdlVhVjlzYkxs?=
 =?utf-8?B?aEY0V2hiZk0xelNLRFpoZmRQM3Q4cEhxOFAwSG94KzhndDkyU2JqaVhEMDhu?=
 =?utf-8?B?cXB4VDEvZU03cnJ5QldEOUhjblltUVRNbEhkYWtuR3FsckRyRzI5QW9aT2dQ?=
 =?utf-8?B?amZuVmEwZzYxK3hrN2QwWmJnV3p0eG9qM3Z6THBwUEVDS3NaWFFWaXE3TGUx?=
 =?utf-8?B?cnFwckRIc1pDcDV3VklIWGpQZVJkM3RYOGd4ckk0Nm1PamFNY3F0NXhXcU1n?=
 =?utf-8?B?Y2xrYmlwclVCd0l2Qy9ZZ2o3enhEdUNxdzlKZFJBVU1POHZPdllrN1pOdkNU?=
 =?utf-8?B?ZnZsY25DWGJzdFQ0ODVEcGxEeVNlczJrbEdLbWlFOE5jaUhaZkdORFVTZGpy?=
 =?utf-8?B?VGhIWUtDdC9KR2N5emJxMFVKenI1TTl2ajdWRmIxQW1ZbDQ2eTk4Zk45dzhK?=
 =?utf-8?B?YUlWRXNrKzJmWGNqcXZpYnI3VTA0dGs3aWp0MXlaVEEzalJmTi9xR29kckRo?=
 =?utf-8?B?UkNwbGJ5bDJEQm9lV2FMOHZtUG1MYkZzeE54cmw2N3ZPeFE3OW9PMFl6VkUw?=
 =?utf-8?B?NlFFb3IyYjhTQUhWQVdDVTEyNEtBNVBEQndHbDZSbVRoNFYydytjb01VWGdt?=
 =?utf-8?B?WC9Xd3JNd1dZamVBWUlzWGhNVnJPMlhzdXJkS1NLZnNpdmVaYjlxQUJiNFZU?=
 =?utf-8?B?M3lITS9lUzB5TDU2R21WdTU0WEF1VGFZdTBKRTJHMW1BajJjV2hVeE5hdlR3?=
 =?utf-8?B?L2NOTTJoaFFXQWhlSnJIS0xkOG1wL1pRV2o0N2tnNTFHd2ppUzIwaFFFTkpr?=
 =?utf-8?B?U1A2RDFQbnBPcDdiWlRCaERxSVFhNWJIaHpoMjNlRElsbUNoWlg1a1M1c1hy?=
 =?utf-8?B?T0VCWXBKVUYzZEVTY1IyeFV2c2ZmSHVQUXZ6NSs1eEtxR3ptMTY3d1o0ZU5G?=
 =?utf-8?B?N2V5SVRWMi8va2NLcTR3SHVVWitQbWRuWEhTT0JxamNzamdhNDgrbldRdUov?=
 =?utf-8?B?bkFCQ2wyeVVxaVdsWFlMaXl5Y3k3cjdYb3FJTHhoMFIzOXU2R3poTW40bEY1?=
 =?utf-8?B?b3NjeHJqMEI2eVlBWVdaOFdGWlVPYjhoSkNEYXBIbEVpcjhadEpmb0RWMllv?=
 =?utf-8?B?ZHVaTW1wcFZ0bk81TFYvTm5ydXRJR0dnakkvL3RnS1Q4ME5aYll1OS83blVB?=
 =?utf-8?B?WTB4K3l2SHVZVWtzM1pDZlVqdlZTdkdqZXpQSG1MT2xkTmFnVTZnbnViU2x3?=
 =?utf-8?B?SU1VS0NweElFTmVzc2YwOW5ZakxXMXJmSlVjU2dkSitBYlp0YlVXRElyeVV1?=
 =?utf-8?B?SCs5U2U5NmJLblFGYmI0Tjk1S295Lyt2TU9DeDZlK01MZitFb01DZTlNdGRi?=
 =?utf-8?B?dHNTZjVXdEtTZUlFV2NQdHcybis5bHBsZFVsNmFDd3JzRzh0d0gvczR3VWMy?=
 =?utf-8?B?b21ha0tIUkNTNmt1ZnpGQVFZUEN2VENUand5dGx4YU1MMnBWVDU1WEI4OXJh?=
 =?utf-8?B?VkxOY1VtTW9SbmJkUHpObDR6TGkyNlREQ0NVNVhuTHVMaGFmWk1WRm5pTGtv?=
 =?utf-8?B?MDRNRzRQT3VMUFM2NnZtZXZyN2JMeGdnTzJGZ0cvNUhoeXZXYTMrUkJrMUU4?=
 =?utf-8?B?ajFPbTArL1ROWlRodUVsb0d0TDVpc1lRbFcvWlRKbFlXTmxRdWFXaVJnVmM1?=
 =?utf-8?B?d0xYY0MrUjc4UXZIL2ZoM1VsbzlFVDF3MEV2Y09jSE5HVkE0LytIdWtSdFQz?=
 =?utf-8?B?elBkZitTd21uZEdFTjlkeFh0TG5TZWcvdTBPZ3U2NjFieDhWaFRxeXZGbGI0?=
 =?utf-8?B?UWhNcVE3cWQwTEc1R052U1Q3OGYxR0pDQTlKU2ZBQjJYdER6ME1PMXpKeWZU?=
 =?utf-8?B?cmgrK2tDV05QSGlvVzJuVWdGa1A3ZnZ6anFjcmhnOS9iUlphWk0vY0hSL0tq?=
 =?utf-8?B?UWFDZXhNaWI1MkQyNUZmaENKQmpRRjlrQjZFeDdob2crdElBK3FTSVVmQ3lI?=
 =?utf-8?B?anROelRLSXNyT0ZXdjg2M0M5cDI0VTY3QzBWYnFBcGxhT1RCNkxmUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e648248e-3675-4172-53b8-08df45a587c8
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:55:36.0625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2ec4GVT+PJAZBoKDnGiqRZubndcKHYJxgjODpVQtEVShhm0bxckgvQZpk7RvgTfWyNLDAgrJqff//Gw7Ie9oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB173649
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Looks good.
Probably needs a similar cleanup in gfx_v12_1_xcc_xnack_set_chicken_bits().

Regards,

Mukul

On 11/18/2026 12:42 PM, Kent Russell wrote:
> This feature cannot be properly supported, so disable it both on the
> amdgpu side and the amdkfd side.
>
> v2: Remove unreachable loop (thanks Sashiko-bot)
> v3: Remove unneeded extra check (thanks Mukul/Philip)
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        |  7 +++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c         |  5 ++---
>  .../amdkfd/kfd_device_queue_manager_v12_1.c    | 18 ++++--------------
>  3 files changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 08d3ff61edcc..d0ede277aa85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1151,6 +1151,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>  		gmc->noretry = 1;
>  	else
>  		gmc->noretry = (amdgpu_noretry == -1) ? noretry_default : amdgpu_noretry;
> +
> +	/* XNACK cannot be enabled on GFX12.1, so keep noretry=1 */
> +	if (gc_ver == IP_VERSION(12, 1, 0)) {
> +		if (amdgpu_noretry == 0)
> +			dev_warn(adev->dev, "Unable to set noretry = 0 on GFX12.1. Keeping noretry = 1");
> +		gmc->noretry = 1;
> +	}
>  }
>  
>  void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 56439c9f8e17..b2fce8c133d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1518,9 +1518,8 @@ static u32 gfx_v12_1_get_sh_mem_config(struct amdgpu_device *adev)
>  {
>  	u32 sh_mem_config = DEFAULT_SH_MEM_CONFIG;
>  
> -	/* GC 12.1.0 A0 requires RETRY_DISABLE in SH_MEM_CONFIG. */
> -	if (SOC_V1_0_DIE_REV_XCD(adev->rev_id) == 0)
> -		sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> +	/* XNACK cannot be enabled for GFX12.1 */
> +	sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
>  
>  	return sh_mem_config;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
> index 525989371378..63ba13a60b98 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
> @@ -54,7 +54,6 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
>  	struct kfd_process_device *pdd;
>  	struct amdgpu_device *adev = dqm->dev->adev;
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> -	bool xnack_enabled;
>  
>  	pdd = qpd_to_pdd(qpd);
>  	qpd->vm_cntx_cntl = hub->vm_cntx_cntl;
> @@ -72,19 +71,10 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
>  		qpd->sh_mem_ape1_base = 0;
>  	}
>  
> -	xnack_enabled = KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev) ?
> -			pdd->process->xnack_enabled :
> -			!pdd->dev->kfd->noretry;
> -
> -	if (!xnack_enabled) {
> -		qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> -		qpd->vm_cntx_cntl &=
> -			~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
> -	} else {
> -		qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
> -		qpd->vm_cntx_cntl |=
> -			(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
> -	}
> +	/* XNACK cannot be enabled for gfx12.1 */
> +	qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> +	qpd->vm_cntx_cntl &=
> +		~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
>  
>  	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
>  
