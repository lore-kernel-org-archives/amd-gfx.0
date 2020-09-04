Return-Path: <SRS0=eFkV=CN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F66DC433E2
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 08:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E650D206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 08:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rLYOj9dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E650D206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 946306EB24;
	Fri,  4 Sep 2020 08:13:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E51F6EB21
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2020 08:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ1tQf/XXpxxIFG+yGhwVmfXIAxMKnL8kBmquCN3+gj26b9n3Sv0zUCPnEVh1gHRo4BkaSLcZSQVtQzqdEUgzDd9rAESg2+n5gJsfBx6LhGhuaeIo1bnvxY+asYkLYOmAc5dqsMA+qGnqhOmyPB/M1FYQy8ByryZYp1WiLGxtCu1j9D1DsW18Qebri5i6pzZCRq61S6L0/ayCiUAhjVLrZCSzFJyYsGFFNuESZBUJHef27poE/nvhT/q4Kri66qo5jO2DCHGnNihohoT86ziiY6Ntw1ujGlXptuFgV0SWvJgQkhKnhS/GioPhSDE50fzrSZ97s6gkJOU8ob2QiFklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj7x4dg+w0QRgtZqJHycPs7B3Fgq3JYMv42kiMqQ6X0=;
 b=Wey0Go0jy6MxbKAFv3u1O/VaAf3iBU/lSHsUYjkBydLLb+mIBywLHdVUjP2AYma41iQ2co7QssBUPiun3cpNPBSJzAc/J/3j4WbqL8aqF+v8E1Pc/Mv4dfsEv0otPUfYkZAlCEy5hBGXxVqqv5daLAHpGftxFg1CwfsWuO0E8hpmUoffdlf9EXC3af0Fm8oyAdaukBFH0TgUJjfl7TcVD0QJ/rECNKolQz8sNh0WyhxxsgwgyvEkBie6dmvnldaki5VCBd/OWlEBCIdkLnCOAx1pO7Peqpdwow8xToYtk4pA0YnRfvZJ3Hqe8Wolwjs286sHj81C7hiL3sgx86jwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj7x4dg+w0QRgtZqJHycPs7B3Fgq3JYMv42kiMqQ6X0=;
 b=rLYOj9dc9XBLpH95YKa5vzQDzAhVbblLbrCY24aHWn0uPS3egmChpARj+vIP5uTpyTqVvOl7bZfkVd/8BxMxgeQzxiVqRt5iIS3vYGSx1g+jPrQPHa9MCzcN4TP90UJGQiG/rgQHZRAKJVK3F1q5oK2uGujxNnhtlwkYFaUmgvk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1817.namprd12.prod.outlook.com (2603:10b6:3:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 4 Sep
 2020 08:13:15 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3348.015; Fri, 4 Sep 2020
 08:13:15 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix L1 policy violations (PSP) on Navi21 SRIOV
To: amd-gfx@lists.freedesktop.org
References: <20200903211146.6692-1-rohit.khaire@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <43428d71-3136-5dd8-c0f4-530a8649d845@amd.com>
Date: Fri, 4 Sep 2020 10:17:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200903211146.6692-1-rohit.khaire@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR11CA0047.namprd11.prod.outlook.com
 (2603:10b6:404:4b::33) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.0.238] (165.204.84.11) by
 BN6PR11CA0047.namprd11.prod.outlook.com (2603:10b6:404:4b::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 08:13:14 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3391a0be-55fc-4344-8b36-08d850aa5fa5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1817:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1817022A53F4D903930506308B2D0@DM5PR12MB1817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQW3n2m5S9vxw+19OdTntwFHWBtaPxh90x/D05MejredCq8QSdSW6IuHecp7ecJk/FKAbKSfE3tq3gqUW6V/AcUwisj5OQogH8wqXfLHPA+5MX9qHhdURCAYjT44R+bdgFDDBMmz7wwSEc+SpdVQABy4GNdequK4FfJ2Ua59Y2kkW4aywT6myhm59oTTM0n8oN93BBxIEx5GWEmxYJeIJ6NiZa0s2xuH+fO6hsfviK4CsnARKhGkiNYqL1qE5/QCHPup1Q7urjjsHLjiP2S0PyeMTBOTJvKAnD5LLdhE8XlfcKQegnDPOfwhhwrh9DcdYAg/KUZRSdQdvyZRZwmjGFP17pUfEF3IIEqH4Ko9apq5f2sJ/EoAUTNcgymoDmmp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(8936002)(52116002)(2906002)(16576012)(5660300002)(31686004)(8676002)(6916009)(316002)(16526019)(66476007)(36756003)(186003)(66556008)(53546011)(478600001)(83380400001)(31696002)(2616005)(66946007)(6666004)(30864003)(26005)(956004)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cSjym11cmh9+Hg0kXGb/lM9KtxhVz3J1XbPzIa68bAyglk8SwoRYD/Vx9PIbt4ihmnPD2mM0tPlzDxlz1iucjAO6EJRAvAH3FBYjcnhFxhzixvvgxX47KDFkOz8qKKPbJRLMISuMgzfzqa+HEavr4YoimiKdaK9Rlvo/FNf8RxLoOx0lZCQfus5Jvfp8PAj7QRjQVvbZnOBiP3MQydefyIo4eSw5TLpo2+LE/2LuMjUI/TzteiFvU2AdPT822iQOcBmHSwRgzMzdMtYDtRm/g/hmDzdYkzr5BTxtCIlE+ZPmZQa/BdMdJWk/kzFxlfT/kAG6KrpVMscs4ZQxtQpMzhmA7FvjjYQ30Z3QhoUx3NpqEBz191triwQchNuWF1q/yzt2qR3YLSFX9W/lRfM3sDRe1xuQgGBrL6czwC9ZE7vl9QJH193nTuXPtr5BFl3evaqTVmm8kaEYWGCR6Ow5SStRDz5p3hSteQOA36t+126qAzvu3ZlAcNMw71fody8qFNEl8wX3wfUvwE3CEJRbJkZxQNxaHs/xwpqZ6o6h8d3jop1okNCJqvcbxzoYPg7z1k2NVvk+JsFfbPahLZZnk4qR/VvGurLQjUbWLGgla+3KHu6JPNu4oka1lSz+pwgD5vS0AKPwRTynbv9NlOUdGw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3391a0be-55fc-4344-8b36-08d850aa5fa5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 08:13:15.4850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HORkTsoMISxV1qz2zYhfiRUGmNtyDw6pfhUyeQpNFD9I91BhRuGOIOCx9SIVgE/YSyGbeVl/9cQPLg0Y35yxvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1817
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 9/3/20 11:11 PM, Rohit Khaire wrote:

Please add commit message here.

> Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 49 ++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 64 +++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 42 ++++++++--------
>   3 files changed, 95 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index d502e30f67d9..4bafbd453e53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4808,14 +4808,23 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
>   
>   void gfx_v10_0_rlc_stop(struct amdgpu_device *adev)
>   {
> -	u32 tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
> +	u32 tmp;
>   
> +	/* For SRIOV, don't touch RLC_G */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
> +	tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
>   	tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
>   	WREG32_SOC15(GC, 0, mmRLC_CNTL, tmp);
>   }
>   
>   static void gfx_v10_0_rlc_reset(struct amdgpu_device *adev)
>   {
> +	/* For SRIOV, don't touch RLC_G */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	WREG32_FIELD15(GC, 0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
>   	udelay(50);
>   	WREG32_FIELD15(GC, 0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 0);
> @@ -4846,6 +4855,10 @@ static void gfx_v10_0_rlc_smu_handshake_cntl(struct amdgpu_device *adev,
>   
>   static void gfx_v10_0_rlc_start(struct amdgpu_device *adev)
>   {
> +	/* For SRIOV, don't touch RLC_G */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	/* TODO: enable rlc & smu handshake until smu
>   	 * and gfxoff feature works as expected */
>   	if (!(amdgpu_pp_feature_mask & PP_GFXOFF_MASK))
> @@ -4859,6 +4872,10 @@ static void gfx_v10_0_rlc_enable_srm(struct amdgpu_device *adev)
>   {
>   	uint32_t tmp;
>   
> +	/* For SRIOV, don't touch RLC_G */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	/* enable Save Restore Machine */
>   	tmp = RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_CNTL));
>   	tmp |= RLC_SRM_CNTL__AUTO_INCR_ADDR_MASK;
> @@ -4872,6 +4889,10 @@ static int gfx_v10_0_rlc_load_microcode(struct amdgpu_device *adev)
>   	const __le32 *fw_data;
>   	unsigned i, fw_size;
>   
> +	/* For SRIOV, don't touch RLC_G */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	if (!adev->gfx.rlc_fw)
>   		return -EINVAL;
>   
> @@ -4906,8 +4927,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>   
>   		gfx_v10_0_init_csb(adev);
>   
> -		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
> -			gfx_v10_0_rlc_enable_srm(adev);
> +		gfx_v10_0_rlc_enable_srm(adev);
>   	} else {
>   		if (amdgpu_sriov_vf(adev)) {
>   			gfx_v10_0_init_csb(adev);
> @@ -6990,7 +7010,6 @@ static int gfx_v10_0_hw_fini(void *handle)
>   	if (amdgpu_gfx_disable_kcq(adev))
>   		DRM_ERROR("KCQ disable failed\n");
>   	if (amdgpu_sriov_vf(adev)) {
> -		gfx_v10_0_cp_gfx_enable(adev, false);
>   		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
>   		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
>   		tmp &= 0xffffff00;
> @@ -7272,6 +7291,10 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
>   {
>   	uint32_t data, def;
>   
> +	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	/* It is disabled by HW by default */
>   	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
>   		/* 0 - Disable some blocks' MGCG */
> @@ -7339,6 +7362,10 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,
>   {
>   	uint32_t data, def;
>   
> +	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	/* Enable 3D CGCG/CGLS */
>   	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
>   		/* write cmd to clear cgcg/cgls ov */
> @@ -7381,6 +7408,10 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
>   {
>   	uint32_t def, data;
>   
> +	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
>   		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
>   		/* unset CGCG override */
> @@ -7422,6 +7453,10 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
>   static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>   					    bool enable)
>   {
> +	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	amdgpu_gfx_rlc_enter_safe_mode(adev);
>   
>   	if (enable) {
> @@ -7584,6 +7619,12 @@ static void gfx_v10_0_get_clockgating_state(void *handle, u32 *flags)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int data;
>   
> +	/* bypass PG and CG on SRIOV VF */
> +	if (amdgpu_sriov_vf(adev)) {
> +		*flags = 0;
> +		return;
> +	}
> +
>   	/* AMD_CG_SUPPORT_GFX_MGCG */
>   	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
>   	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 237a9ff5afa0..44ebb2722c4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -152,33 +152,35 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
>   {
>   	uint64_t value;
>   
> -	/* Disable AGP. */
> -	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
> -	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
> -	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
> -
> -	/* Program the system aperture low logical page number. */
> -	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
> -		     adev->gmc.vram_start >> 18);
> -	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
> -		     adev->gmc.vram_end >> 18);
> -
> -	/* Set default page address. */
> -	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
> -		+ adev->vm_manager.vram_base_offset;
> -	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
> -		     (u32)(value >> 12));
> -	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
> -		     (u32)(value >> 44));
> +	if (!amdgpu_sriov_vf(adev)) {
> +		/* Disable AGP. */
> +		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
> +		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
> +		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
> +
> +		/* Program the system aperture low logical page number. */
> +		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
> +				adev->gmc.vram_start >> 18);
> +		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
> +				adev->gmc.vram_end >> 18);
> +
> +		/* Set default page address. */
> +		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
> +			+ adev->vm_manager.vram_base_offset;
> +		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
> +				(u32)(value >> 12));
> +		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
> +				(u32)(value >> 44));
> +	}
>   
>   	/* Program "protection fault". */
>   	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
> -		     (u32)(adev->dummy_page_addr >> 12));
> +				 (u32)(adev->dummy_page_addr >> 12));
>   	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> -		     (u32)((u64)adev->dummy_page_addr >> 44));
> +				 (u32)((u64)adev->dummy_page_addr >> 44));
>   
>   	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +				   ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
>   }
>   


Indentation looks off here and in 
gfxhub_v2_1_init_system_aperture_regs() as well.


Nirmoy


>   
> @@ -350,18 +352,6 @@ static void gfxhub_v2_1_program_invalidation(struct amdgpu_device *adev)
>   
>   int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)
>   {
> -	if (amdgpu_sriov_vf(adev)) {
> -		/*
> -		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
> -		 * VF copy registers so vbios post doesn't program them, for
> -		 * SRIOV driver need to program them
> -		 */
> -		WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE,
> -			     adev->gmc.vram_start >> 24);
> -		WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_TOP,
> -			     adev->gmc.vram_end >> 24);
> -	}
> -
>   	/* GART Enable. */
>   	gfxhub_v2_1_init_gart_aperture_regs(adev);
>   	gfxhub_v2_1_init_system_aperture_regs(adev);
> @@ -394,9 +384,11 @@ void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)
>   			    ENABLE_ADVANCED_DRIVER_MODEL, 0);
>   	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
>   
> -	/* Setup L2 cache */
> -	WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
> -	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
> +	if (!amdgpu_sriov_vf(adev)) {
> +		/* Setup L2 cache */
> +		WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
> +		WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
> +	}
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index 2d88278c50bf..99f697e63e3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -211,26 +211,26 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   			     adev->gmc.vram_start >> 18);
>   		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
>   			     adev->gmc.vram_end >> 18);
> -	}
>   
> -	/* Set default page address. */
> -	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
> -		adev->vm_manager.vram_base_offset;
> -	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
> -		     (u32)(value >> 12));
> -	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
> -		     (u32)(value >> 44));
> -
> -	/* Program "protection fault". */
> -	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
> -		     (u32)(adev->dummy_page_addr >> 12));
> -	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> -		     (u32)((u64)adev->dummy_page_addr >> 44));
> -
> -	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2);
> -	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
> -			    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> -	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
> +		/* Set default page address. */
> +		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
> +			adev->vm_manager.vram_base_offset;
> +		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
> +				(u32)(value >> 12));
> +		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
> +				(u32)(value >> 44));
> +
> +		/* Program "protection fault". */
> +		WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
> +				(u32)(adev->dummy_page_addr >> 12));
> +		WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> +				(u32)((u64)adev->dummy_page_addr >> 44));
> +
> +		tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2);
> +		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
> +					ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +		WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
> +	}
>   }
>   
>   static void mmhub_v2_0_init_tlb_regs(struct amdgpu_device *adev)
> @@ -656,8 +656,10 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>   {
>   	int data, data1;
>   
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev)) {
>   		*flags = 0;
> +		return;
> +	}
>   
>   	switch (adev->asic_type) {
>   	case CHIP_SIENNA_CICHLID:
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
