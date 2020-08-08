Return-Path: <SRS0=cqfu=BS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9422AC433DF
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Aug 2020 01:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3912B221E5
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Aug 2020 01:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HyafE4/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3912B221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A606EA92;
	Sat,  8 Aug 2020 01:29:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC1E6EA92
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2020 01:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPeEiuDndJFfX7eKAuZuvLVz8v72WKXZVHVkW/MvALKgRZlfoi4ShiTGheV3Aa7xNGWQjGwkx2PMRbZ09MhqTJKUAN7sG4VpdU7b42DBjd99vcWHJ0280clY9wGfZ5pGF+PvdMQcI8YVfeZrB/cBZX1tGZI4722SxgBDEDrmRjREEptNwsp6JAKoRqvtcMnvG1gIvrBTE2ydVExhYrYCkInOhMXWfXN36E6QSbwVsT5ZI5KcdQ3ez6FFJJQrF08KxWvhNF0I8NIYiVF20orugR1XqpZC8o1246pCAGbvz1wSLAz4e0P/YC0X9hln/ZVl5zzP+HakPNcyXL2rUUo8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAMb4s2Ok3U8v1+DsmKRlPgjRyTUlBt2RundLCyXO4k=;
 b=nKSp9pVFu78NpiZvOWPtlhollSJHWB79ajmViU7YpaFMkvh+ilJOtydwsU4Yw5wLSU3hcpFwtKLgStgqLOUtWwfdSZ58SGA9JUNxJhl/FzIDk8BD3phrgPZ4HCIACCgwhpammv8Yb6We0VffvJTLAxmScI4qie1uZMbqu52Hso/GKBYCvhAhZS/R47UnOFYlICrXKGmxcSj8vfl2+1/blUSuPNmE8JIr1hy6nqLeQqk/JW3zV9ePQFB85O6X2VCCjJNggQR4dFFHy6wR7jHW16odW3FhBQVdo8tx0VpwA8+uBNwpowJFrRkm5t64k3ZFDK/icBbPCzE/aY+D1JJtRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAMb4s2Ok3U8v1+DsmKRlPgjRyTUlBt2RundLCyXO4k=;
 b=HyafE4/vlgYWO0VPpnth2oxuRnIqZ4Fy696Lgtv0wXoHM/kSquASVlaM5udlez4a3FYUZHZoiMSFElO5UC5u2Hn3tLc4WP3svvgmuWBGB10XH9mL8QabaH1SpbCHmHo4ALKjFRFlj4dWNr6SMvSMnX0hMye0T+H7qi8/NVDRpQk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3866.namprd12.prod.outlook.com (2603:10b6:5:1c6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Sat, 8 Aug
 2020 01:29:32 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3239.024; Sat, 8 Aug 2020
 01:29:32 +0000
Subject: Re: [PATCH] drm/amdgpu: Skip some registers config for SRIOV
To: Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200807084839.730118-1-ChengZhe.Liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <7c1eaca0-8bbf-8d9f-1c2e-36a0d6047c42@amd.com>
Date: Fri, 7 Aug 2020 21:29:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200807084839.730118-1-ChengZhe.Liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (108.162.131.176) by
 YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19 via Frontend Transport; Sat, 8 Aug 2020 01:29:31 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9b31bc3-1bbc-456d-465e-08d83b3a8044
X-MS-TrafficTypeDiagnostic: DM6PR12MB3866:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3866907D1149626467D9A45799460@DM6PR12MB3866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h70yIJiBwCWQvGwQAq6wL97kTsFQNiZEJn6c1fa+avWyiyXIIbroquS6bOEZtSCir79VBiunY7j8E5IgxaXiNAkHXNcpHyH2QAUnKQ0hebHdYHGeliyiGFBh0ZqKLMuPALag3ehuYDaLaonVhhd9GuGkn4b1j4RtHNr13vZGkGLXQuFQ+etbJTYEBosYmd+EZ9B8WWOPUzBbw/iBO98/u9u91xcniRtzWGL3n/vdWJQenDvpsSveVi18rOLx+D70BC37c4XII7NV2Qx/QtG9ys7l9FJubRwcVH0wY5YVr7SVMPRo2ZAut3E7UaiAJj+NDZcUKsmQUs4rApgl70PSXGFRnIIBoXpRcdBgbyAWJRZUY8z0i64Ol/4cawrdR0b2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(478600001)(5660300002)(53546011)(86362001)(6486002)(66946007)(316002)(66556008)(16576012)(52116002)(66476007)(26005)(186003)(16526019)(6666004)(2616005)(31686004)(83380400001)(4326008)(44832011)(956004)(8676002)(54906003)(36756003)(8936002)(2906002)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zrdRXrTN9Arn1bd0QfA8DzeansvoS9d6G8MK5N5T34MOgfRrlTiBUiwzRmhPWhduYT53OFslUyZfuGYUdZsXehkX3iqrg9jJ0ob1gDgJm20Qs6DOgLruUyoAHUfVABJCJZEuhy06wxzfrHcq2F3DxGv93WquMqyVtVbW/JV2gN0TwBhlQpiG5AEtxNRSJum/U/T2/7lBblASyxW2FK/1rMc9g8VXNF5KFX6Fowb6d2MHMQ7u+bgaIanlJ06gWcLtGsh/v1APyL7t8egEzb4TxkP9IizlIpaAbJPuAeQXBDuPGB8Oggq3oydUV19RRd7IcmcT/eRmBDBZzQuB/ta+fJZBaHcEaTHjvzl72dV42rXy4rdj2txA9kEkuLCiVnE/vIDphpOyxbqxHxdKaNn/Z4wj/JdQY4kSCnl3rlZaLYhfmRcPc6l9adk4gkq6kn/bWaLm6n+p8CnVwaNQNsUT76Zr8u/QWoOrxYRlAZshWivoxqvWrKL4F0ub6O9810CsL8vWPuGNSKqtn6XC3Aqf7zO1R8VI+OZnJZrn4cNVxVE3Mh96SNKkD2QHbmM1m2ot1fsrSIGyui4GnsUyGeJkDewo5nCO7GmxyQbYA8zcznW+dZqTcEv2YQR2OyiAXzaejNrRLmGO7tIBFULTi8Q41Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b31bc3-1bbc-456d-465e-08d83b3a8044
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 01:29:32.1004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhEh7dUE4OJ1UJKgOcIMOjTaCptinXmP02Gf3jex1GLzw3mzEEsqpeZL9pOzf7pj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3866
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

On 2020-08-07 04:48, Liu ChengZhe wrote:
> Some registers are not accessible to virtual function setup, so
> skip their initialization when in VF-SRIOV mode.
> 
> v2: move SRIOV VF check into specify functions;
> modify commit description and comment.
> 
> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 19 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 19 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 1f6112b7fa49..80c906a0383f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -182,6 +182,12 @@ static void gfxhub_v2_1_init_cache_regs(struct amdgpu_device *adev)
>  {
>  	uint32_t tmp;
>  
> +	/* These registers are not accessible to VF-SRIOV.
> +	 * The PF will program them instead.
> +	 */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>  	/* Setup L2 cache */
>  	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL);
>  	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, ENABLE_L2_CACHE, 1);
> @@ -237,6 +243,12 @@ static void gfxhub_v2_1_enable_system_domain(struct amdgpu_device *adev)
>  
>  static void gfxhub_v2_1_disable_identity_aperture(struct amdgpu_device *adev)
>  {
> +	/* These registers are not accessible to VF-SRIOV.
> +	 * The PF will program them instead.
> +	 */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>  	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
>  		     0xFFFFFFFF);
>  	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
> @@ -373,6 +385,13 @@ void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
>  					  bool value)
>  {
>  	u32 tmp;
> +
> +	/* These registers are not accessible to VF-SRIOV.
> +	 * The PF will program them instead.
> +	 */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>  	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
>  	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>  			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index d83912901f73..8acb3b625afe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -181,6 +181,12 @@ static void mmhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
>  {
>  	uint32_t tmp;
>  
> +	/* These registers are not accessible to VF-SRIOV.
> +	 * The PF will program them instead.
> +	 */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>  	/* Setup L2 cache */
>  	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_CNTL);
>  	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_CACHE, 1);
> @@ -236,6 +242,12 @@ static void mmhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
>  
>  static void mmhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
>  {
> +	/* These registers are not accessible to VF-SRIOV.
> +	 * The PF will program them instead.
> +	 */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>  	WREG32_SOC15(MMHUB, 0,
>  		     mmMMVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
>  		     0xFFFFFFFF);
> @@ -365,6 +377,13 @@ void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
>  void mmhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev, bool value)
>  {
>  	u32 tmp;
> +
> +	/* These registers are not accessible to VF-SRIOV.
> +	 * The PF will program them instead.
> +	 */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>  	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL);
>  	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
>  			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
