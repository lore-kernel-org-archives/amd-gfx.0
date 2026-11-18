Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B47606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jv0Ctutu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F4710E449;
	Wed, 18 Nov 2026 09:37:23 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C525410E449
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 09:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TITEfQsLOE1Z3+VesHzAS+ySXwmAVTQZdDJvzknppc0gEl55SS9GFFI/O/KdbIq7rzW0ykoMTLEm340U4E2TTIXSJc9juQ7xYsf2NS4RS7WXoahc3+Tg6K3fPr0QDW58nkQi8RJNOEagm6XLxs0KBg6+gx5VSV3dsxPVAkwjV4X3gcWcjlcnDXJzvyzk7dprbRn5iN5i5Ur8Z3au1E1zczFPjg9YLdyiDrPn6RnHzl/BEMjrnirodiTgzeplLatdnx7YMAePPbNMS1uwkbDX8SwJOk9zTOV2GgnJuqsUbSO2NFpgCo4DygMLzbEeRTIGGye73mpuEJEz5zg2cCB3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afcNCNKSEfh87+SLSQXRTjyIi4J8ThFgJOa/VwRBFlY=;
 b=qKpVv7CedgmH9+UFRoasWWro6vxLIS1gBu/+TGVO5kJ/AqI2NYNvhVBN+NnhFFGcKD37j+dNKrqjedqVdHz3I8huMRdwx4gyMH5VxfWooqFkaWK65Iwgg5zbBY/TGxNsGLYtEqJ/m4Ztzfk9WL2D5SW1eFXnqHzaK/EwS5aitKRErpy1KhWMHhkWsz8OUCwPSHtVT9C5wexWRwer6neuf5tlffsX10Ov91bcWtN0XrOGEajXDjumoKb8tJyunwqVReJDHpHrDUDwStnE++WbUDey0KfHw7D0vQ3ngxOu4mP4wtwlAOPTePf35Uy4js3bTqjqa4PyyGK69dQc2ASMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afcNCNKSEfh87+SLSQXRTjyIi4J8ThFgJOa/VwRBFlY=;
 b=jv0Ctutu6qfftQtS1uIvM26kVE6EU5uR1JE1W+S8xbwwv8awSXAijoeCB8wpMXgkW4zTPtXVqhzP8mRPFintaippk26YLFC3B+6wSfy+F7Q8QM3J4dzyDkL9MZCy0GUkNFd64dItPv+OWLVvrX9coNO91mXYv5h6snJl9go5VGg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 09:36:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 09:36:50 +0000
Message-ID: <2d15ca30-7a5a-4894-9896-176dc4ecaab7@amd.com>
Date: Wed, 18 Nov 2026 10:36:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] drm/amdgpu: expose the XCC-masked
 setup_vm_pt_regs as a gfxhub callback
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
 <20261117165952.3558762-2-James.Zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261117165952.3558762-2-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: cb37a8d7-5471-4a2a-83f4-08df455778d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|6133799003|22082099003|261009223027099003|11063799006|4143699003|56012099006|261102123227099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: AC1eZ3YcDYsqn7F3zv1mHtUwGYv4FkgQK8LNBDSYwSpWX9kpPSbyb0xUFe+KZW4+y4OLaYql1aF5Pn/BxOkrkkXwpntN7qzr0K5nAr03sYsD+MJObDkysjHKEG2l+j8MXoOMQc2QfdwMJBLippppaMvEgCRFxTh5jqieXb5egWF0iBXbg+NCQvoMFz6z+vyib6crwmZhzWb+0PukyB8BI5yseBgeajTtz0nQyfDiZB4zuXzHuKFOrXCyRfLzfUZlC2BNt5Pcs0NeDB9LqfK+WKREQzYqwt4LszVOGR4z0tFfIPiEreWizBBrLzlDZqcCzmhs/Od4yawDJmBljoVQ9A0Vpa1N94zFFtT4K8ALIulegAlhgPM8/pSrqYLhp+D5+ifH7YtFeBnZwhGfLOoR+BDYc0Z5ktMBvmXdQIB9gTxjbNjG1CG/Aex7FXUoBEeTn5jjBL2t1UG1Y8/yI49AMKsNn9FWd6JWw35Vj/8ehNUSRigCIySMoo3Bf4VkWflZimxPJlGu2rlvSQG4w/hpvw3cZZ+6HJcQI/uyyyEBUCxfRbQ0LgEOX0TLqg25SX1818wHNeT94QKfBeIXCrF4UzmVp9TvhQEaLS2ZwRCuORqwImzEs7uemZHh/2udoiQRylz6Vekc1KocaAviO57l4GGj05tEqvww/SY5UpQiTh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzR5cG1DVmN4SUlHMEwwSjZ2Yk11dDhqT0hCSGFyTDZ0L0Q4NkhUWU8ramVr?=
 =?utf-8?B?bUFTZVUwNWNpYlhNRWt6UElDZlNCckhXOVJLKzIzdkMydDZ0NlJNM2FUN3BM?=
 =?utf-8?B?enB0cFQzeC9HZE5XblNHZnJaSWw4ZHY2QVdpWmRYamlBRGhESkxHZE5Bc2s1?=
 =?utf-8?B?Ujk1K0thV3ZCNGo2YWpkby9RdGhLeVdOdXRNZmpvMnMrb0Flcms5VHd0Rm8r?=
 =?utf-8?B?ZDNsQWF6MHUvUElxdUJ1amlFNjZDeCtTM0twZWJtM1hDNi9HZXNNUDU3Y3BL?=
 =?utf-8?B?Q3poeC9kbkZUNUNoMUpkQ3lBOU5oSTd2M0RuS2VMV0laQ0ZCK0h2MGNVREcz?=
 =?utf-8?B?b2hwV2JHUEpRTkhialc4eU84aUFtdGZXb1BWUk5KRHdlM3BYelYwb3VCdVYr?=
 =?utf-8?B?TGtvRCsrUWU0TnF0anh5OUZ0MFlyM2pGVWxFOTI5a1Ewd3hCWFFIMEllVnY2?=
 =?utf-8?B?YTVuWldPMWJ5R3BpTE05di9UQVc3UnpBWElEcTNoK0NrTkNweDZpWTBJS1dt?=
 =?utf-8?B?S0pNenR1NWFHSDdCdDdVL1pIS1F6WUdLOTBZbDJiYTA4OXhaeWpubktMOHVN?=
 =?utf-8?B?SFdEWUIyOHgxcjE2V1V4ZUt2RDVGVm1NdzhLSG9UV1lNMi9JRHVVZVgrTytu?=
 =?utf-8?B?Mkdrc2RPMGtNV3c4Q1NhVUcrQVpQVHQ1R3hnV0NDeHlzSEpuNHJHcWNESy9i?=
 =?utf-8?B?MlFNSUp4cHk3SVVYcG1hN2JhVks5N1pTTDBIM0VaMnR2TVVlWlJnK0JQcHlp?=
 =?utf-8?B?Q1FhYjQwekt3TTcxeU1oZnpRRHFteldsbHkwazVGVTJNcGtnL2NmanEvdFNz?=
 =?utf-8?B?OTZOQm1jaFkwNytHdTFvLzZXMkpYOCt0SXRjZHVEUTNTUktzTjlSTkpGamVT?=
 =?utf-8?B?d0RkRVFJREdnbXdpMDNGUW53TEJteXhTOFJCQUVGTnZvV1RyZTdsb3FDSzNW?=
 =?utf-8?B?WFhOTmFJME5BMlRIS0N4Ky9NdzZEYy9WTnA5S3dMemRva1pFQlVJREJWWUli?=
 =?utf-8?B?UXBJQk5MYmhSc1NjR1MvcFcxeitGaTRPaWtPcXpDOUhZeTNIbFppS2RKNjhi?=
 =?utf-8?B?cE5qSGFSZUhCMWo4dGkyaGlLSmxKL3IvOEQ1ME82cVRnUjMyZlJPb3FOcFN5?=
 =?utf-8?B?R1gwZE56V3Ezb0NXOEZHTlJDSE1VdmpLa0prWHc4dVFPeSttR1Q2cFgydnZi?=
 =?utf-8?B?cmhmMVh1L2xMWGQwaXdsbkgyenh0WWV5U0NYUlFaU3cvcUlISkpMQ0pISnRn?=
 =?utf-8?B?cStDZkxieFZ1MythK3lwNGVWR0hGMVJoSTZhdzM0YzZnWDczS3ZheTFFZlBT?=
 =?utf-8?B?STJNcTR1c3UzNjVDYjNCb3VPQ1V1bkpKLzltcXVMcFRBREk1cjlWK0FKNlY4?=
 =?utf-8?B?Ui83QlBVVHN5QXpEb3VuUlBFL2NWeWZuYndCdElPOUpuaHp6djQwMWpqN01N?=
 =?utf-8?B?Sys2aU10Y3Rrc3V1SFJFWHM5bTRPUXUxb2x6L25uNmVlOEE0cWN3TjluWFhq?=
 =?utf-8?B?bElnWmhjbWREV2dqdWsxMmMyTHRHMGxsYkZVU1hzbFlsK3dFWDhyanpWeVBU?=
 =?utf-8?B?eEpmNzhlMHE5dzMrOWYwMnBza3R0Zk11Q3F6TVc1a3V0NEExdTlsYTk3eU1Z?=
 =?utf-8?B?U0pkYWxWMXQ0TFF4Qkt2RzY2QVBkdlZXS2UvWXVKeEQyNHh4YWFiNk5nZUpo?=
 =?utf-8?B?MHdrVUI5WHU3ZFpRcHdnT0pRV1luU0JHUmZCYktlbk05ZnFHcFVoVThwRHM1?=
 =?utf-8?B?VWpNYWViKzRXSS9Dd2dzOHB2VnVoVk1hK1Jpd3JxeFlmNVJ1UFprZitVOTBN?=
 =?utf-8?B?bjM3WTFZY3dXbnJYdEdUMEJXTnY3bWViWklIaW1seU44Q3FrT3BoVGZYQnoz?=
 =?utf-8?B?bzA1NUsrUlZGSXdQdjFWOStnbHBaOGJ0ajVOeitSQXhPRk9RN1ZYSHY1ZWxS?=
 =?utf-8?B?dDcyWCt2NktGcnFObXdGWVc0enhEaGhxZnVFSS83TFdmM1REaEE3VFZzNzQ5?=
 =?utf-8?B?R1lDNnN4SmZsWGpwUS9uWjRGeFVnT1EwMUMyTUxmSVphY1NucW00clhlNUk0?=
 =?utf-8?B?bTdNSlloV2Y1clpEY1lIMytPYzdGN0x6enhPVTJseFFKbzhobllsS3cwdHIx?=
 =?utf-8?B?MGJtdGtHYXRMZFNyWFNJYkFWaU1ZOW56cmxkcmlYRWJyWUtUWU5oQ3NVNjk2?=
 =?utf-8?B?U01LRHNuazk2SXpYRHVIU251MzRDR2Q0eXo0eENtU3Fadm9LaHI1WXpFUmlS?=
 =?utf-8?B?YlVsMzhWbHk2VmNiQXdvNEtXT25HaVdCSUF5b2N1S21aRVp2cHZZMHFPQ2Nv?=
 =?utf-8?Q?ec3co0EQgFETFLNHuD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb37a8d7-5471-4a2a-83f4-08df455778d5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 09:36:50.2835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPY0fr8g4f34U4fVt6El7HFcz2GjsWHPr7tWI+JqCD+lftlKA3JcBadQ3nfESTQ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
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

On 11/17/26 17:59, James Zhu wrote:
> On GFX IPs with multiple XCCs each XCC has an own GFXHUB, but the
> setup_vm_pt_regs gfxhub callback programs a VMID's page table base on
> every XCC. Callers which bind a VMID on a single VMHUB, like the SPM
> VMID binding, have no way to reach one GFXHUB through the callback
> interface.
> 
> gfxhub v1.2 and v12.1 already implement an XCC-masked variant
> internally. Expose it as a new setup_vm_pt_regs_xcc callback. GFXHUBs
> of IPs with a single XCC don't implement it, for them the existing
> callback already is per-hub.
> 
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Assisted-by: Claude:claude-fable-5
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> index c7b44aeb671b..19b961cb12f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> @@ -28,6 +28,8 @@ struct amdgpu_gfxhub_funcs {
>  	u64 (*get_mc_fb_offset)(struct amdgpu_device *adev);
>  	void (*setup_vm_pt_regs)(struct amdgpu_device *adev, uint32_t vmid,
>  			uint64_t page_table_base);
> +	void (*setup_vm_pt_regs_xcc)(struct amdgpu_device *adev, uint32_t vmid,
> +			uint64_t page_table_base, uint32_t xcc_mask);

Don't add a new callback, extend the setup_vm_pt_regs with the xcc_mask instead.

Regards,
Christian.

>  	int (*gart_enable)(struct amdgpu_device *adev);
>  
>  	void (*gart_disable)(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index b13967a1c8fb..7bc17721f463 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -809,6 +809,7 @@ const struct amdgpu_gfxhub_funcs gfxhub_v12_1_funcs = {
>  	.get_fb_location = gfxhub_v12_1_get_fb_location,
>  	.get_mc_fb_offset = gfxhub_v12_1_get_mc_fb_offset,
>  	.setup_vm_pt_regs = gfxhub_v12_1_setup_vm_pt_regs,
> +	.setup_vm_pt_regs_xcc = gfxhub_v12_1_xcc_setup_vm_pt_regs,
>  	.gart_enable = gfxhub_v12_1_gart_enable,
>  	.gart_disable = gfxhub_v12_1_gart_disable,
>  	.set_fault_enable_default = gfxhub_v12_1_set_fault_enable_default,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index e89813590539..a56c072daf15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -634,6 +634,7 @@ static int gfxhub_v1_2_get_xgmi_info(struct amdgpu_device *adev)
>  const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
>  	.get_mc_fb_offset = gfxhub_v1_2_get_mc_fb_offset,
>  	.setup_vm_pt_regs = gfxhub_v1_2_setup_vm_pt_regs,
> +	.setup_vm_pt_regs_xcc = gfxhub_v1_2_xcc_setup_vm_pt_regs,
>  	.gart_enable = gfxhub_v1_2_gart_enable,
>  	.gart_disable = gfxhub_v1_2_gart_disable,
>  	.set_fault_enable_default = gfxhub_v1_2_set_fault_enable_default,

