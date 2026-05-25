Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93804CD5BBF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 07:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1535410E5A4;
	Mon, 25 May 2026 07:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XDOM+NrN";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C71210E5A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 07:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+ZPC23vH0IlBT6R0gyfgM7EwWQKT4K8Bzmb9WtlH5htbw7OzMuN4JFxIo5oE7pu6C0VGe93cd6q0e74jBMy2rjHXh7x+XdmZmO7KUsvI2Dpd9uM0WWtC6BQzOBWXwpuf+UyMnU3FT02EvhnbzeaCWIQRbtRHpICmaB+tUVGP4iwxwZhZ/on+v45lfe/q508+NI2x7ysnWP793GKXK8oMaK6ztH3sBDYOQW+KDjHKxTbqXgTDioLW3BuDXJUFOoRcVtt3I3bf7+72WzynKaU1BAfLf1evZb5usHcraUWMyW2OLSYAypDFDk7VXa6qCsPpjPTe9NWYgYHkRWUdLKn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOuHYGxB+vRBeKoCDoyWRcYQa9MLnAmydrFNAyL+4/w=;
 b=FcQybnUHQ/kGZjhTOrUidj56HhMV8Ri/giTTsNGJj4mxKtUCsiTEEIaKlzfRh3weMgpf3mGVeIfkJiLacf8jnbwdC9ZcAx6FHMSSouQPq/26x6F6Uvtbr2brQ/9EWaYrbZQ5tvysy5LhqSbKWwA9BFYc8fCuXFcyf66Sa6ULETA2efweBmcXWpeG616GtNRqqo/3b8keFaPNxTJOTQtFNyDaEwtXCLFc/W2OSfwsE7DYORwy9U2j/iEwGauBrvRkPX2x0e2O5Xs2jONqhMYnhxKZKoLnMZ2BDIx2qy3HGWh7RnkATpzaEXcspq4r1eBy6hJKg8BctqvKbtk4C2nrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOuHYGxB+vRBeKoCDoyWRcYQa9MLnAmydrFNAyL+4/w=;
 b=XDOM+NrNPIxplvyEU7lbqJO2Uj8LDXDNSjBYz1IH2Q93+5VOp+KM+WaAltXCc44IZmt389R2xKrjff1xwxP4ZIJXDe5/FeNU2rYKCgVj898gj0fNopfdur9BjtLEdvVho6WB30zxoJmNUqv90OlBUea4dE/nNihuq1GXQWacF/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 07:51:34 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 07:51:34 +0000
Content-Type: multipart/alternative;
 boundary="------------hWUMmHDLwdtItH102BdORur3"
Message-ID: <8bc5d390-8ca8-45d5-a80f-245d3ad3e6ea@amd.com>
Date: Mon, 25 May 2026 13:21:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_vm_bo_reset_state_machine
To: christian.koenig@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20260522093147.11192-1-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260522093147.11192-1-christian.koenig@amd.com>
X-ClientProxiedBy: PN3PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::19) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: d12aaf1a-d937-41d6-7245-08deba3270f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|18002099003|22082099003|56012099003|8096899003;
X-Microsoft-Antispam-Message-Info: 27vN8TsRYMtW6J5aclzaRfD5Gs5IOpCD34KTPsj3jNxOjGT4Kh+7PBzot0g0XA2C+YBRNvUiM52QSJ7aD3xHZCntZwP9oUlpeIhBkDKP3dQA5KmAVbTBBjuml/D3/UwGmoCxRZY3xya7qYkSgPj1Uwj5hvThGwt8bZz5mzN5T9mkTEuIFxZqCLFCP0dKGn8qfyb8Vxq7h1Xw8kvOTexfTHHY5pxS/R7whz5vgmZQTjDQBB5AX9L3NvLvd45e2Nf6uP9J+nGwMqe3eCyQeeQ7UlDkwE1AEAsqUoKeGzxuerLKrhsW2d3+94QHNoQAyDHK4DJ1QteCc/bN7IsmPDtKMnJQqbRqgrZAzsKS9lJnpqOnJu88cztQEh5PX4kn2QYdCgzKiE7yJlomgXjDZR4qHKwYf8y8zhRqMwTHQQGhsAoX4SaL1j/KxH997uCMpgrsJnlqlvFmzTt4nywcGxRaGYfiZvuTtxv3KLl3bqMuCY/6RcwTJDwQ+NLGdbGuMMPX345lhV/hfd37mLOylU9OSYkyMs4ycYsRgPzRQB9BwrVhBiP3Sfu32iPqDIo5UFqxNLRKfHqmaT5C/R8/Mv7q/cSMQ1fBfbpaR2++8cwoU0Rf/97fnHr5Uq8EniY0VR7vXfsdsE1XPle4zsdjwpyVJay6pJ4fbHW/XeJJQXinEknUBXU+yXiy5df3kL7jGl1g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(18002099003)(22082099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTduUHBEditUYlBpblZlNlJSL3JZTktUSlJ3TFh1QnZhVzNmdDdCK3RhSzM1?=
 =?utf-8?B?T3ZnTFYvUTdSd1lCcmVmTFRHUW96NmRHandZZ083UFRXREtOakVzSnFJZFlL?=
 =?utf-8?B?RFJwQXpUWVJxem5IZmRHL1ZEM1ZPc0ZTNEsydmR2dHNFQ0NXWFNWTW1XdXdW?=
 =?utf-8?B?YUtFOGhSbzE5Ni9XNTNEMy9MQ0c4MG0rRlF6L2NzOFdVWlNDcXhDTTBFODAr?=
 =?utf-8?B?TDBSQnA3VmtFMURia1psTXlsU2h4UFNLUTB5MVJ2dm15OGxkd0pCNzU0OTBD?=
 =?utf-8?B?MytXdkVlSHVBT1ZHRXo3Zy8rYkhleHVNcXVKSTFTWTJYcW0xejJyd2RMdVRC?=
 =?utf-8?B?SS9vSnlYTkNYWDhUMzZEK0FnUGVqMEZ6c3BObW80ak5kcnZ4aGRxSFc1Rklz?=
 =?utf-8?B?QmMvQXJScFdEelAxdnpHNHVBUlV2UkdFVVh5L21tR3BsTTA5QnRQT2RRYXJL?=
 =?utf-8?B?OHBlWWVmditIM0VFQ1BVRzRNKzl0R0c1R2sxUVpNVjA2RENWTGRMUjRWVExT?=
 =?utf-8?B?YlhqblNwdXlOdk4wcmhObkpoYXZkN2FLclduUFJBZ05EVHB4Qm1XL082bGFl?=
 =?utf-8?B?dkF2a2s3azFrNWRIWERrdzVUejEzWVRyZUpyc0NRZVR0ZllodjZJaC9sM3VF?=
 =?utf-8?B?akVTNnhIM3Q0bzFSaEtlbS9XQlRpV204alVwQXFMNW1QK1dZR2VYRmJjTnN2?=
 =?utf-8?B?b1FTbHgyS3VaaktvbHFROUs1R3dZTVBDTVRTVXFLNGtlN0pJMTdyS0NYUEJ6?=
 =?utf-8?B?MUNnVlkxbDJJWG5RQThCdFRsNDZpcmJBREZ1aWZhV1VVK2tBUlp1TmJGM3hX?=
 =?utf-8?B?QzVzOUtvSkxWNWwvZ3I1dHRMcEpaM3hSK2tsY1NkMEMvZ0xtdVNoRXQxTkE2?=
 =?utf-8?B?aFErWTVVc25ia0FxYUNmWnlFRm5tZHd6ZWE5dGV2aGR5NVJvR2NrR3ZQdmN6?=
 =?utf-8?B?WUJBMTVla0ZNLzNmV0IrK2RHcXUyRmpQUFNOZHd3UFZRbVQ4QjhGUWQ2WFVy?=
 =?utf-8?B?dGg3NW1MY0hVcnVRcnBHbUxmMkVxN3MvWjlwOVVpK3hnVGpVZFZmQlhma3BJ?=
 =?utf-8?B?R0MvK2FxclJUZnJaSS9YbGx5ZHRrcDNraHZzNEgwYWhQRlZKUDRlTnQzd3kr?=
 =?utf-8?B?WkU1Uk1JRlF4Z1dsY2dWOTV1Mm5jUlFlSUJrdC9rcG5aa1k0SUVXNzluaDA1?=
 =?utf-8?B?cHF6ZHBUMnRReTBXTHlvQncrQ09raURRMUZINjRpYnpnbGVXQjIvVHFhd2RH?=
 =?utf-8?B?dll2TzZwem9FQXVsNU1PQ1NtTXNIelgwWnRIWXlsZFlpTjNTdm90Z2Y3ZDhn?=
 =?utf-8?B?aks1MGxWQUs3cGZnZ3hUQk5YeVViY2them9KSURZbUhLd3d0ZEUvUzkxR0Ur?=
 =?utf-8?B?ZE5rbklOcmFScklkK1BGMGY5YUdaRmRqSnNOMVJMaVZKQ0dEdDBtK2JRUTUy?=
 =?utf-8?B?R2U0bGo2YUdGb0E1QVVaQzJmREFzMWpyaFZUVXZ1QjU0Q0hYbWxBUW9GbEgv?=
 =?utf-8?B?UElsYzA1YWhjMGZSbHpoT0VSS0FWYjFkRkY3R3FGYmRub1lsZGJUUzlueWhS?=
 =?utf-8?B?WFFkMDVIay8yUlRBNzhnRFdWbWtFZTlpY0g5bmFpdkhWbnhaRFltZFRZRENm?=
 =?utf-8?B?NmxhQWNrbTdlOERsdU1kbEtxRUJmczh3aEpjaS9DWTIvemJDaDZoV21QUFdn?=
 =?utf-8?B?RkQ3WEo2OUM1ZURKc0pvM2FKUmllKytuc0ttQ2lnWi9KYU5TV2pzTUpsN1Yv?=
 =?utf-8?B?ZXVueExKbDQxbVNaZWZBeFhseHlNRXVnd2NaRXBkWWgxV21LV0djY09FVElH?=
 =?utf-8?B?MUZEOWEzV3VseDNwMWExanZzNnhkamFXUjlvMFMrWEdrU1JWM2FDcHBSZjFJ?=
 =?utf-8?B?S0NJb3NXMHdoQXBHRFc3R1Q2ZDNZL041ZWJnVmhveUErZ2x6V212MmdNUDVk?=
 =?utf-8?B?VU96SFlFUVJNSU1keVJ0RnFPc3lTNnVpcjUwNXUrZzh1S1NlSCtZRGVhb20v?=
 =?utf-8?B?UXRnZXpZektPWGZFczZOWXBpdVFwbDVCQ3FnSFBoQ3RxWUhSZ0hnYURSK3d4?=
 =?utf-8?B?bDBaM0F3MXFRaTlJMjZuUVlDQnBjQjg4ZWpiM1JZQTFSaTgzQjhzekdrU1o1?=
 =?utf-8?B?WG1SVVA1Nm9RVGxrRnBxeG1jTUNYVjd0bzRrSHpNVERGdVZlLzVwU0Z1ZktX?=
 =?utf-8?B?YjhicDNGOW5oaFgxTDUyak95MmdWRVMrbkcxMnl6d1kzZXJWWDJveEFCMUJ2?=
 =?utf-8?B?WVJ2bEJjQ2RYZ1QvUUZ0ZVVKRUFLNXFjbFpZSkUrMWNHQ0N5eXVoMWtxTm5t?=
 =?utf-8?B?R2p4cmp5RXNwVkM1VGlmMzluaGx4bDdBemVKenl6bjdlNy9BdTIwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12aaf1a-d937-41d6-7245-08deba3270f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 07:51:34.3648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFzsi5BcF7UdZs9JvMah5560m7bXfVVeJQAS5WABqj/Tvzv8tRxTkql8RZt541M+p5SqZJq3TbuQLd67tT6Ysw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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

--------------hWUMmHDLwdtItH102BdORur3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I have also observed the same issue during reset and the patch is fixing it.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Regards
Sunil Khatri


On 22-05-2026 03:01 pm, Christian König wrote:
> Can't splice the list but need to handle each entry individually.
>
> Otherwise we run into issues after a GPU reset.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b523a7b97d6f..e91504f04d97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -266,12 +266,23 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>    */
>   static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   {
> +	struct amdgpu_vm_bo_base *vm_bo, *tmp;
> +
> +	/*
> +	 * Don't use list splice here, we need the special handling for the root
> +	 * PD and set the moved flag appropriately.
> +	 */
>   	amdgpu_vm_assert_locked(vm);
> -	list_splice_init(&vm->kernel.idle, &vm->kernel.moved);
> -	list_splice_init(&vm->always_valid.idle, &vm->always_valid.moved);
> +	list_for_each_entry_safe(vm_bo, tmp, &vm->kernel.idle, vm_status)
> +		amdgpu_vm_bo_moved(vm_bo);
> +	list_for_each_entry_safe(vm_bo, tmp, &vm->always_valid.idle, vm_status)
> +		amdgpu_vm_bo_moved(vm_bo);
>   
>   	spin_lock(&vm->individual_lock);
> -	list_splice_init(&vm->individual.idle, &vm->individual.moved);
> +	list_for_each_entry_safe(vm_bo, tmp, &vm->individual.idle, vm_status) {
> +		vm_bo->moved = true;
> +		list_move(&vm_bo->vm_status, &vm->individual.moved);
> +	}
>   	spin_unlock(&vm->individual_lock);
>   }
>   
--------------hWUMmHDLwdtItH102BdORur3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>I have also observed the same issue during reset and the patch is
      fixing it.<br>
    </p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt">Reviewed-by:
      Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a><br>
      <br>
      Regards<br>
      Sunil Khatri</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 22-05-2026 03:01 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260522093147.11192-1-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">Can't splice the list but need to handle each entry individually.

Otherwise we run into issues after a GPU reset.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b523a7b97d6f..e91504f04d97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -266,12 +266,23 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 {
+	struct amdgpu_vm_bo_base *vm_bo, *tmp;
+
+	/*
+	 * Don't use list splice here, we need the special handling for the root
+	 * PD and set the moved flag appropriately.
+	 */
 	amdgpu_vm_assert_locked(vm);
-	list_splice_init(&amp;vm-&gt;kernel.idle, &amp;vm-&gt;kernel.moved);
-	list_splice_init(&amp;vm-&gt;always_valid.idle, &amp;vm-&gt;always_valid.moved);
+	list_for_each_entry_safe(vm_bo, tmp, &amp;vm-&gt;kernel.idle, vm_status)
+		amdgpu_vm_bo_moved(vm_bo);
+	list_for_each_entry_safe(vm_bo, tmp, &amp;vm-&gt;always_valid.idle, vm_status)
+		amdgpu_vm_bo_moved(vm_bo);
 
 	spin_lock(&amp;vm-&gt;individual_lock);
-	list_splice_init(&amp;vm-&gt;individual.idle, &amp;vm-&gt;individual.moved);
+	list_for_each_entry_safe(vm_bo, tmp, &amp;vm-&gt;individual.idle, vm_status) {
+		vm_bo-&gt;moved = true;
+		list_move(&amp;vm_bo-&gt;vm_status, &amp;vm-&gt;individual.moved);
+	}
 	spin_unlock(&amp;vm-&gt;individual_lock);
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------hWUMmHDLwdtItH102BdORur3--
