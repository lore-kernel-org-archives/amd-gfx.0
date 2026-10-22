Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFE5606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ARsoCClr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09CC110E332;
	Thu, 22 Oct 2026 09:35:33 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1B110E332
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 09:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMNFFt30u9g0UmJP/Sn4aDvqIP5gzL8wql8DvFZuE1uO3x65lYwuQmmJF3I9j2S7oEGwbKXZ3mqKLj8rKcNKqdlOwHqPU5FsjoHk+iU3JMrIGwwa5CeKNeYzg8WI878z9Zq3SuSMxMPno/+PFnx0bOCEZJaqfPs6gZ3AWTbVcZHfNIe4nP3prxySNEkK1v8+Vh8d+2mejaPVtKm5QYJepunp0FerD4LXxpKvYyzhCC/dww1PvXc6pdr7OlEIdI6Qsqml0B5CeIyBGHiNSwpZesB7odxbCXm3ln5yRc9WY9cHDOcCTjQ4N8TOfUbthXrwSF5vEGu1Oq4wFnCl5N4udg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTtKgCO0Cgz6QDzJuO/appwWwtdgy62+bXVij8BD1DI=;
 b=aXky2JSbozstfPWCxAbSWcVtJGkPv9whPqkGqJA2tNLgaWWBdPbnfI6/ZXaxJSPREHAk+KsgoYZYGcOkyDe6ip4V04fIKxR39GhsBMXTCFuzDdd7D6E7yxa6KMRmTsW74e21gx3c5fbQCHvXj/xpYgCh9r6sCHMSUxRI9G3KeXyNxTqPnjK0S7UuC0Zohvn5RlbhhS7tbwyQHser28WtR1KSDCSLN4IFJGfXSG8yAO4lW3NLfAjSuBAI0ywI1y/OW7C1sFV9sTg9gWBCcDfBwEYOdw4ZyCb77gjW4pOJLgEpsWIDoXdvS6gSloCtoSNRWCzKlrsFusCPoLXazvpAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTtKgCO0Cgz6QDzJuO/appwWwtdgy62+bXVij8BD1DI=;
 b=ARsoCClrl1NHgmXBZcLfVg98ShWZ9b3kchvg93KYGCcefN8zMl8EZzkaBuJt5SEJyJcGSZSdcsy2tUYd/AZ1+E5N6rmmMgIY1xllAYjeg8MfUrkx6dgpzwfKpamfHC4asXG0YwqAtR+lrhmBn4dJr1/2bfRN3UiUmyz3/qPA1qM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 09:35:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 09:35:20 +0000
Message-ID: <d20078a6-1836-4a76-bb05-09aec61e9aed@amd.com>
Date: Thu, 22 Oct 2026 11:35:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drm/amdgpu: Integrate CWSR with user queues
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>,
 James Zhu <James.Zhu@amd.com>
References: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
 <20261021065603.1329111-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021065603.1329111-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: fd081fc2-5a53-49bb-9bdf-08df301fca33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|18002099003|10067099003|22082099003|261021121427099003|3023799007|261021123027099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9feiUBSA8jHKllS30Qx6IeHvY+WF3ymoflj8newtzVLYPHlt1R7THTEU59Q6+XEIAB0J96uNC+7HaDyrJSAYHiY+C72q3FD2uyVhM/oqwFM+U6zyIz3YHIi9d/EGykRfVSxQH1OSKYgAjbnWhzYmFxAYX5j1wMkmxqi1FbnvwPe+Ru/ngByobg0oe3BFF/Pf7YpmjkhsayNF1H5KDj0d/D8+TWAvKeRCMZIKBzHS7QTvyTk0I41GXrnLbMKROaJNqPPn041hMtjNWuRvlRp5d/K2+sQUZhqiji//ZXci5KkeTb2diLdQ88RH1AVZJlZtrAm/AwxNO265EeGgydsnKnJgpNBhYLip1mvJP//oZqfEeyaMo9/idkIjhBlzGetiX1+weCuFtJbwbfMhx5fQKvgly/4vpnfT2VhHefdIKU1uRqbfq0+AYlynwftSgTIRra02mQ6LUd42n49XTl5B4yoqAI4kmuFom3ykLdYW9BFRCYtw1iwiA3OLfJOpHJbp9xXF6dz6SjvnCg2raU9tNcfQ4WObLAFsMFfGXo26KJ6er1M5OBCs3Qxlt2rV7csaeCAZSy7hD+EDQRX/lr79IxSdAlySEQX9QO4JiCVyPlqA244J36AC2JkBFd0eA3Bn5T6/uok6KFbgM+fv3PiDPmgyRKJ2uKvweHZBRdpWNMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(261021121427099003)(3023799007)(261021123027099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHE3YmY0aCtxWDFpU2RKSWw5WG9tT2FIdFBjbGpsSW5HSHc3QTcvRG5nN1lT?=
 =?utf-8?B?UE9YSldpSWhnc2pSM3JLQnBaV1cwTnVwUXQ4OE1KaSs0dnpocDJhZGhSQ1pH?=
 =?utf-8?B?KzBPdk0rMGVmNjhsTVViaklSQjEwSU9UUXkzMGZCTUt4Qjk4SG9hRGlIWTF1?=
 =?utf-8?B?MjEwbWFLalN2NFYweUlOK094ZXBtV3JtNHNtODhkL3RiaHQrYnhqL2Z1dTBZ?=
 =?utf-8?B?VS9oVDJpRWZEZjU4TnROMUJCWUlOWUcvbjNDOUJ0bnNiRE93OXZzVW5GTnRZ?=
 =?utf-8?B?a05TTE9uNWN6dURRejUrekhvcXAxYW5ZcG04WTYyVHozUXFqS0RibDdRaC83?=
 =?utf-8?B?R29zYjk2QjlQbWF2QnVWRDVrcDZCWWRKSy8yK1FFbEVNQUZWY0ZYcVcvaTRX?=
 =?utf-8?B?N0NpZmJvZysxWmthV29MTGxsRjJZNE0wdm9ua1hzZW9ET0ZkZW9vcUZBMk5R?=
 =?utf-8?B?SW52ZkNkZWpmL0NGb3dLdDhXL3FuMVNBbUdmVkFPRU5KWmJRTXBDVitUU3Fp?=
 =?utf-8?B?OVNyWlZodGhYMnNPYUFNYW9KVTJOUWlSaVA1a29BenNFL0VGeWpzV2ZrbDYx?=
 =?utf-8?B?OXZGS2d0am9vbmwwTDlRN3EyZ25iTnJvd2JRbFI0YXNQZEVrdXN4Rm4yYXE5?=
 =?utf-8?B?eDFUN3JJaGwxY2psdFJlZ0hZaVBENWNSNFQzSG1tKy93NG9YaEVISm1DMERo?=
 =?utf-8?B?MUhmamE0azZYTjB4aFZPZWw0ODE0OXYwanZ3VTBNL2dDUFlLTTlib3ZYdWNB?=
 =?utf-8?B?M1FteWM3d0RVMVdveTd5SGV6RERnSEM0aUZxRy9wRjYwN1VmTXZYU05zS0ZK?=
 =?utf-8?B?Yk5kZEpYTEpmcVg3Mi9VdWFGbWQyeXRRTk5jZDd2QlB0UUhUckxNSzc4MnNK?=
 =?utf-8?B?bjkwdnE2d2c5RDhUclREaS9DdHhaRTJWc2NsYWVZNk9PQzV0UEVnUHN2MjlW?=
 =?utf-8?B?TjRWY3ZFRlBnNFI1REZnL1VzT0ZuMVNlYTFNK1c5QXZ1YkZNZks4VG13VVFu?=
 =?utf-8?B?WlkrRnJxRVd4ZHlrTFRMWDdSbTFhNU85QXlLOUltR3pLVmswK3lQM1RGQkhn?=
 =?utf-8?B?T3R2WlBkZ1dtbzdRRk83UzFpczJnKzFyUmdUbG84MS91ditZSk81MDlkNnVI?=
 =?utf-8?B?RHY3cUszNUNMZnVQb0toZjgzS0prcEFjUUpPVEdKWjZoQ29mOEZacXdSeDlL?=
 =?utf-8?B?SVhKZTFOS2IrRUtlTFpCQkEvS2Jvb2syU0RMS1FMMFlLUThJTFdxaUFzKzRM?=
 =?utf-8?B?WkJBNXp2WHlkb0NMTWd2S1FkMUZ4akxrV3pSMFp1eURHM3dCY3FyM0p5QWUz?=
 =?utf-8?B?Z25HbkF0eTdDK2hpQTNrV213R0labTJpcy9waTBxYzBhdFlLMkdIY0RTNUpO?=
 =?utf-8?B?Y2Q1bkZsY25MbFN4cFBlM0FqakFicUkwdlFpMEF4RFJLOGdFUGIrdUh3VjVB?=
 =?utf-8?B?cHJLeHd2YUhGREkrUDFaTTNPb01VL0VDc0p3NjNHSDFRVVlOZ240b3pWYWlN?=
 =?utf-8?B?cGE3QVlmdUFhWm82MG9obHpicjVyWEhianNNNXpPSCtlMng4ZER4a3ZDejVW?=
 =?utf-8?B?cXB6WmNjTnI2YnIyQU5xQmxqdzhPV00yLzRSWCtJWTR4MG9SU0lMQmF0Vnov?=
 =?utf-8?B?SkJ3WGtBR3VMTTVza2dTNFpPQXphYkZ5bUdibm9hR0h2dk1TaUJmNTlaOGhl?=
 =?utf-8?B?NVlZQ1BKY1BScU5ZcDJTdDF6eFI1MHlGYTFjOEx4QytRQ01RaGtodjU2TnF0?=
 =?utf-8?B?NVZCdW91b2JpL0plcThpMFkyY0FOUU5kTytKVUo0NDcya2tMaXFrVDBmWnl5?=
 =?utf-8?B?OWJ3SVprc25PT3JMWmRjd3BwM280QTlDNkp3QWFBMlloLzJrNHdEb0NFL2No?=
 =?utf-8?B?Q1hhU2ErK2cramc4Nnh4a2J6bkFxSDBIbk9ZZ21QVDJoeWxJSFVIOElyVUpU?=
 =?utf-8?B?U2VmbGZFTHRHYzdIZWJML2lNZWh1R2M0Y0hlVEdBU3UwTGZUMFBDM1FENVZ1?=
 =?utf-8?B?SG5BWEJlZ0JpNjVGa01uakFFd3hCRTdwS3dZdzdvbVhJemhoSGRZYkRYbHpF?=
 =?utf-8?B?dXZWd1VxUk1EWXhwZzBDdzNrMHhIekRSYmJJdGpudUZBb1kyU0dGYkxOUHcx?=
 =?utf-8?B?Rjc0M2RrUEtreFdabkg1blBFdE83MnFFY1MwSkJzNnQzd3ZKazJUM0NPWU10?=
 =?utf-8?B?SHhBdzJRY0JobnkrTzRJNjZGa0ZlREE1ZHJ4ckRaV1VpN1V5ZHBXdW94NGtP?=
 =?utf-8?B?a2Z6anRWWkhjUXhTbE8rd0tGckU0cjR4aGRhaXh2a2FEenhWWmJ4SWpHSGlz?=
 =?utf-8?Q?5sYcVhfyXgHr4HTCZk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd081fc2-5a53-49bb-9bdf-08df301fca33
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 09:35:20.6324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8OFjSFwOF4v4VYCr85iiyCHsOpfxMyEuVSx5UZ4bzvvY5pAEE/QZj8W8NaosyTF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414
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

On 10/21/26 08:55, Srinivasan Shanmugam wrote:
> From: Lijo Lazar <lijo.lazar@amd.com>
> 
> Initialize the CWSR handler during device initialization and release
> the associated resources during device teardown.
> 
> Add a per-file CWSR trap object for render-node user queues and map the
> first-level CWSR trap handler into the GPUVM associated with the file.
> Use the mapped TBA and TMA addresses when programming user queues.
> 
> Add user save area parameters to the MQD properties for compute queue
> creation and validate the parameters before using them for MQD
> initialization.
> 
> The CWSR parameter validation walks the VM mapping tree and updates the
> user queue VA mapping state. Reserve the VM root BO around the
> validation so the required VM reservation is held while accessing the
> mapping tree.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Co-developed-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Change-Id: I2bc2159e6ff36b2aaa08d112ed8e7a17b5dadc5e

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c   |   8 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h   |   6 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  10 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   9 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |   8 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  25 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   8 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  14 +++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 102 +++++++++++++++++----
>  10 files changed, 172 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 53aeaca52a6e..6ed1cb942802 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -333,6 +333,7 @@ struct amdgpu_reset_control;
>  struct amdgpu_coredump_info;
>  struct amdgpu_video_codecs;
>  struct amdgpu_cwsr_isa;
> +struct amdgpu_cwsr_trap_obj;
>  
>  enum amdgpu_cp_irq {
>  	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
> @@ -421,6 +422,7 @@ struct amdgpu_fpriv {
>  	struct xarray		bo_list_handles;
>  	struct amdgpu_ctx_mgr	ctx_mgr;
>  	struct amdgpu_userq_mgr	userq_mgr;
> +	struct amdgpu_cwsr_trap_obj *cwsr_trap;
>  
>  	/* Eviction fence infra */
>  	struct amdgpu_eviction_fence_mgr evf_mgr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> index e9cd04364367..e854614483c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -387,6 +387,7 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	if (!amdgpu_cwsr_is_enabled(adev))
>  		return -EOPNOTSUPP;
> +
>  	if (!vm || !trap_obj)
>  		return -EINVAL;
>  
> @@ -395,12 +396,15 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		return -ENOMEM;
>  
>  	bo = adev->cwsr_info->isa_bo;
> +
>  	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>  	drm_exec_until_all_locked(&exec) {
>  		r = amdgpu_vm_lock_pd(vm, &exec, 0);
>  		if (likely(!r))
>  			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
> +
>  		drm_exec_retry_on_contention(&exec);
> +
>  		if (unlikely(r)) {
>  			dev_err(adev->dev,
>  				"failed to reserve for CWSR allocs: err=%d\n",
> @@ -447,17 +451,21 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	}
>  
>  	drm_exec_fini(&exec);
> +
>  	*trap_obj = cwsr;
>  	return 0;
>  
>  err_kmap:
>  	amdgpu_bo_kunmap(cwsr->tma_bo);
> +
>  err_tma:
>  	amdgpu_bo_unref(&cwsr->tma_bo);
> +
>  err_exec:
>  	drm_exec_fini(&exec);
>  	kfree(cwsr);
>  	*trap_obj = NULL;
> +
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> index 297a4ff04730..65a0d2852fb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -79,4 +79,10 @@ uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
>  int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
>  				struct amdgpu_cwsr_params *cwsr_params,
>  				int num_xcc);
> +static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
> +{
> +	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
> +}
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7cb1427761ef..ccabaf99eca6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -81,6 +81,7 @@
>  #include "amdgpu_reset.h"
>  #include "amdgpu_virt.h"
>  #include "amdgpu_dev_coredump.h"
> +#include "amdgpu_cwsr.h"
>  
>  #include <linux/suspend.h>
>  #include <drm/task_barrier.h>
> @@ -2546,6 +2547,14 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  	amdgpu_fru_get_product_info(adev);
>  
>  	r = amdgpu_cper_init(adev);
> +	if (r)
> +		goto init_failed;
> +
> +	r = amdgpu_cwsr_init(adev);
> +	if (r == -EOPNOTSUPP)
> +		r = 0;
> +	else if (r)
> +		goto init_failed;
>  
>  init_failed:
>  
> @@ -2950,6 +2959,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>  {
>  	int i, r;
>  
> +	amdgpu_cwsr_fini(adev);
>  	amdgpu_cper_fini(adev);
>  
>  	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 14a72a406d37..fe5e505c6f2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -49,6 +49,8 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_video_codecs.h"
>  #include "amdgpu_ras_mgr.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_cwsr.h"
>  
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> @@ -1580,6 +1582,12 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  			 r);
>  
>  	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
> +
> +	r = amdgpu_cwsr_alloc(adev, &fpriv->vm,
> +			      &fpriv->cwsr_trap);
> +	if (r == -EOPNOTSUPP)
> +		r = 0;
> +
>  	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>  
>  	file_priv->driver_priv = fpriv;
> @@ -1649,6 +1657,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	}
>  
>  	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
> +	amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
>  
>  	if (pasid)
>  		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 0f368fbd2c80..298ac47f83bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -533,6 +533,14 @@ struct amdgpu_mqd_prop {
>  	uint32_t cu_mask_count;
>  	uint32_t cu_flags;
>  	bool is_user_cu_masked;
> +	bool aql_queue;
> +	uint32_t queue_percentage;
> +	/* used in gfx9 and gfx12.1 */
> +	uint32_t pm4_target_xcc;
> +	/* cwsr params */
> +	uint64_t ctx_save_area_addr;
> +	uint32_t ctx_save_area_size;
> +	uint32_t ctl_stack_size;
>  };
>  
>  struct amdgpu_mqd {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 1a2aa85c504e..d1811a29892a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -35,6 +35,7 @@
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>  #include "amdgpu_trace.h"
> +#include "amdgpu_cwsr.h"
>  
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
> @@ -266,6 +267,30 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  	return -EINVAL;
>  }
>  
> +int amdgpu_userq_input_cwsr_params_validate(
> +	struct amdgpu_usermode_queue *queue,
> +	struct amdgpu_cwsr_params *cwsr_params)
> +{
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
> +	struct amdgpu_device *adev = queue->userq_mgr->adev;
> +	uint32_t cwsr_size;
> +	int num_xcc;
> +	int r;
> +
> +	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
> +	r = amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_params,
> +					num_xcc);
> +	if (r)
> +		return r;
> +	cwsr_size = amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num_xcc);
> +	if (!cwsr_size)
> +		return -EOPNOTSUPP;
> +
> +	return amdgpu_userq_input_va_validate(
> +		adev, queue, cwsr_params->ctx_save_area_address, cwsr_size,
> +		&queue->userq_vas.va.cwsr);
> +}
> +
>  static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>  {
>  	struct amdgpu_bo_va_mapping *mapping;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 488dc21d7c81..727f60c40bbf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -41,6 +41,7 @@ enum amdgpu_userq_state {
>  };
>  
>  struct amdgpu_mqd_prop;
> +struct amdgpu_cwsr_params;
>  
>  struct amdgpu_userq_obj {
>  	void		 *cpu_ptr;
> @@ -97,8 +98,9 @@ struct amdgpu_usermode_queue {
>  			u64 eop;
>  			u64 shadow;
>  			u64 csa;
> +			u64 cwsr;
>  		} va;
> -		u64 va_array[6];
> +		u64 va_array[7];
>  	} userq_vas;
>  
>  	uint32_t	gang_ctx_array_index;
> @@ -200,4 +202,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  
>  void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  					struct amdgpu_bo_va_mapping *mapping);
> +int amdgpu_userq_input_cwsr_params_validate(
> +	struct amdgpu_usermode_queue *queue,
> +	struct amdgpu_cwsr_params *cwsr_params);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index d334fb805020..2adc2bcc3dce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3224,6 +3224,20 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>  	/* set CU mask */
>  	gfx_v12_0_compute_mqd_set_cu_mask(adev, mqd, prop);
>  
> +	/* If non-zero, assume cwsr is enabled */
> +	if (prop->ctx_save_area_addr) {
> +		mqd->cp_hqd_persistent_state |=
> +			(1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIFT);
> +		mqd->cp_hqd_ctx_save_base_addr_lo =
> +			lower_32_bits(prop->ctx_save_area_addr);
> +		mqd->cp_hqd_ctx_save_base_addr_hi =
> +			upper_32_bits(prop->ctx_save_area_addr);
> +		mqd->cp_hqd_ctx_save_size = prop->ctx_save_area_size;
> +		mqd->cp_hqd_cntl_stack_size = prop->ctl_stack_size;
> +		mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
> +		mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 7abb9d95ef59..108dced28f97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -27,6 +27,7 @@
>  #include "mes_userqueue.h"
>  #include "amdgpu_userq_fence.h"
>  #include "amdgpu_trace.h"
> +#include "amdgpu_cwsr.h"
>  
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> @@ -120,6 +121,7 @@ static int convert_to_mes_priority(int priority)
>  static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>  	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
> @@ -151,24 +153,37 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>  	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
>  
> +	if (fpriv->cwsr_trap) {
> +		queue_input.tba_addr = fpriv->cwsr_trap->tba_gpu_va_addr;
> +		queue_input.tma_addr = fpriv->cwsr_trap->tma_gpu_va_addr;
> +		queue_input.trap_en = !amdgpu_cwsr_has_dbg_wa(adev);
> +	}
> +
>  	if (mes->use_rs64mem) {
>  		if (!uq_mgr->proc_ctx_allocated) {
> -			r = amdgpu_mes_alloc_proc_ctx_index(mes, &uq_mgr->proc_ctx_array_index);
> +			r = amdgpu_mes_alloc_proc_ctx_index(mes,
> +							    &uq_mgr->proc_ctx_array_index);
>  			if (r) {
> -				DRM_ERROR("Failed to allocate userq process index err:%d\n", r);
> +				DRM_ERROR("Failed to allocate userq process index err:%d\n",
> +					  r);
>  				return r;
>  			}
>  			uq_mgr->proc_ctx_allocated = true;
>  		}
>  
> -		r = amdgpu_mes_alloc_gang_ctx_index(mes, &queue->gang_ctx_array_index);
> +		r = amdgpu_mes_alloc_gang_ctx_index(mes,
> +						    &queue->gang_ctx_array_index);
>  		if (r) {
>  			DRM_ERROR("Failed to allocate userq gang index err:%d\n", r);
>  			return r;
>  		}
> -		queue_input.process_context_array_index = uq_mgr->proc_ctx_array_index;
> -		queue_input.gang_context_array_index = queue->gang_ctx_array_index;
> +
> +		queue_input.process_context_array_index =
> +			uq_mgr->proc_ctx_array_index;
> +		queue_input.gang_context_array_index =
> +			queue->gang_ctx_array_index;
>  	}
> +
>  	amdgpu_mes_lock(&adev->mes);
>  	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>  	amdgpu_mes_unlock(&adev->mes);
> @@ -179,7 +194,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  
>  	amdgpu_mes_userq_queue_mapped(adev);
>  
> -	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
> +	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n",
> +			 userq_props->doorbell_index);
> +
>  	return 0;
>  }
>  
> @@ -403,6 +420,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
>  		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> +		struct amdgpu_cwsr_params cwsr_params;
>  
>  		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
>  			DRM_ERROR("Invalid compute IP MQD size\n");
> @@ -410,7 +428,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			goto free_mqd;
>  		}
>  
> -		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
> +		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd),
> +					  mqd_user->mqd_size);
>  		if (IS_ERR(compute_mqd)) {
>  			r = PTR_ERR(compute_mqd);
>  			goto free_mqd;
> @@ -421,6 +440,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			kfree(compute_mqd);
>  			goto free_mqd;
>  		}
> +
>  		r = amdgpu_userq_input_va_validate(adev, queue,
>  						   compute_mqd->eop_va, 2048,
>  						   &queue->userq_vas.va.eop);
> @@ -432,29 +452,63 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  		userq_props->eop_gpu_addr = compute_mqd->eop_va;
>  		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
> -		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
> +		userq_props->hqd_queue_priority =
> +			AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
>  		userq_props->hqd_active = false;
>  		userq_props->tmz_queue =
>  			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> +
> +		if (amdgpu_cwsr_is_enabled(adev)) {
> +			struct amdgpu_fpriv *fpriv =
> +				uq_mgr_to_fpriv(queue->userq_mgr);
> +			int num_xcc;
> +
> +			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
> +							 fpriv->xcp_id);
> +			cwsr_params.ctx_save_area_address =
> +				userq_props->ctx_save_area_addr;
> +			cwsr_params.cwsr_sz =
> +				userq_props->ctx_save_area_size;
> +			userq_props->ctl_stack_size =
> +				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> +
> +			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> +			if (r) {
> +				kfree(compute_mqd);
> +				goto free_mqd;
> +			}
> +
> +			r = amdgpu_userq_input_cwsr_params_validate(
> +				queue, &cwsr_params);
> +			amdgpu_bo_unreserve(queue->vm->root.bo);
> +			if (r) {
> +				kfree(compute_mqd);
> +				goto free_mqd;
> +			}
> +		}
> +
>  		kfree(compute_mqd);
>  	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
>  		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
>  		struct amdgpu_gfx_shadow_info shadow_info;
>  
>  		if (adev->gfx.funcs->get_gfx_shadow_info) {
> -			adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
> +			adev->gfx.funcs->get_gfx_shadow_info(adev,
> +							     &shadow_info, true);
>  		} else {
>  			r = -EINVAL;
>  			goto free_mqd;
>  		}
>  
> -		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
> +		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) ||
> +		    !mqd_user->mqd) {
>  			DRM_ERROR("Invalid GFX MQD\n");
>  			r = -EINVAL;
>  			goto free_mqd;
>  		}
>  
> -		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
> +		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd),
> +					   mqd_user->mqd_size);
>  		if (IS_ERR(mqd_gfx_v11)) {
>  			r = PTR_ERR(mqd_gfx_v11);
>  			goto free_mqd;
> @@ -470,7 +524,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			kfree(mqd_gfx_v11);
>  			goto free_mqd;
>  		}
> -		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
> +
> +		r = amdgpu_userq_input_va_validate(adev, queue,
> +						   mqd_gfx_v11->shadow_va,
>  						   shadow_info.shadow_size,
>  						   &queue->userq_vas.va.shadow);
>  		if (r) {
> @@ -479,7 +535,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			goto free_mqd;
>  		}
>  
> -		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
> +		r = amdgpu_userq_input_va_validate(adev, queue,
> +						   mqd_gfx_v11->csa_va,
>  						   shadow_info.csa_size,
>  						   &queue->userq_vas.va.csa);
>  		amdgpu_bo_unreserve(queue->vm->root.bo);
> @@ -492,13 +549,15 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
>  		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
>  
> -		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
> +		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) ||
> +		    !mqd_user->mqd) {
>  			DRM_ERROR("Invalid SDMA MQD\n");
>  			r = -EINVAL;
>  			goto free_mqd;
>  		}
>  
> -		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
> +		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd),
> +					    mqd_user->mqd_size);
>  		if (IS_ERR(mqd_sdma_v11)) {
>  			r = PTR_ERR(mqd_sdma_v11);
>  			goto free_mqd;
> @@ -509,7 +568,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			kfree(mqd_sdma_v11);
>  			goto free_mqd;
>  		}
> -		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
> +
> +		r = amdgpu_userq_input_va_validate(adev, queue,
> +						   mqd_sdma_v11->csa_va,
>  						   32,
>  						   &queue->userq_vas.va.csa);
>  		amdgpu_bo_unreserve(queue->vm->root.bo);
> @@ -524,7 +585,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  	queue->userq_prop = userq_props;
>  
> -	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
> +	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
> +				     userq_props);
>  	if (r) {
>  		DRM_ERROR("Failed to initialize MQD for userqueue\n");
>  		goto free_mqd;
> @@ -533,7 +595,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  	/* Create per-process MES process context BO */
>  	r = mes_userq_create_proc_ctx_space(uq_mgr);
>  	if (r) {
> -		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n", r);
> +		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n",
> +			  r);
>  		goto free_mqd;
>  	}
>  
> @@ -545,7 +608,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  	}
>  
>  	/* FW expects WPTR BOs to be mapped into GART */
> -	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue, userq_props->wptr_gpu_addr);
> +	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue,
> +					  userq_props->wptr_gpu_addr);
>  	if (r) {
>  		DRM_ERROR("Failed to create WPTR mapping\n");
>  		goto free_ctx;

