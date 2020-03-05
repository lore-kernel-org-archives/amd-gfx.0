Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9125C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3C82073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t4GtQhIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3C82073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367CE89090;
	Thu,  5 Mar 2020 16:11:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E9CB89090
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 16:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU6Q0iXdFy1z1ep0A4sYLDXb4ARCyAq82NN0CjABeEGmHqUZmPASavs2syGM+UggeiH+SQrblrM85kp6wO3BI0bolWO6cpWEAs9RR8KAF8wrzM6aw2JDUS7JcnT8bYI/qUUDtPe+BGFZ1WNt9HoVGhEnkq5ejBI/U19hARoMdhQOYXtKGW8Aozz/+7tgZ0UWKQqmcze9msQBdVqV/3MA+gAxhhBJfUBzGMMnIhfV8nzFhstd7Ae1bOm80f2SVYLBjnnhEOd2zpPS5utdiLH7XCTXUmzZlA7/g9O2lPT5nxVPW7VpEDid+Uo+KMQ+um3I4+VLoNEu2m0VrPpIHpz6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GImqGKQg+jMcnQ+FJvSF/mJMjoVOstxD9t9Hg5W9gFo=;
 b=Epqvmc9HzStL+yTxUa0skmGwQr6UuH5zkzsRLRHo8CbX8iHu+K+NNjhYU07i83NQ+lrpIu+fGFk9WEs040h3uQU/1teG821qUBvPxfIsJ4CqSflG1nkiXpr8vV8e3VYHkDL5F9dW9cjGqX2Kyk+S46Zj5Mr/ytbpeKamIdrTjOvXeo2vjKdyd45cGfXBs6iPyLEkVDghv5eLNex6y3jui/Fjv15RbA6YX85ziucAXuW6aoOstOQzsSrPozOMQrGf5n7et7VSSZ5jvYximlvnHx7NloSZE8oCG8492XMVoQU+OZ+OxnqIXTBTSnqH/7Z7uObs96Y8VUk27spiF5f8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GImqGKQg+jMcnQ+FJvSF/mJMjoVOstxD9t9Hg5W9gFo=;
 b=t4GtQhIxedo7hNUZk/PFpTSmEdNguqeB5QUw2gHEmrVzxFym9ennY3gX6K+oU4z+4B33Rao02Qmz9XldHp3ubFdlWYPg80sqT+dr3mtZZ8Two7aHqwRLf9HiPvWWrfe0b1ibM951CPkd1x7HAyXS2VByIRjkukRbWNTkQEAEeQE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Thu, 5 Mar
 2020 16:11:54 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 16:11:54 +0000
Subject: Re: [enable VCN2.0 for NV12 SRIOV 5/6] drm/amdgpu: disable
 clock/power gating for SRIOV
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
 <1583415187-16594-5-git-send-email-Monk.Liu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <37e35cc4-431f-8ec0-4c98-9770dc329259@amd.com>
Date: Thu, 5 Mar 2020 11:11:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1583415187-16594-5-git-send-email-Monk.Liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::24) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a200:445:917c:58ca:660b:c965]
 (2607:fea8:a200:445:917c:58ca:660b:c965) by
 YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Thu, 5 Mar 2020 16:11:54 +0000
X-Originating-IP: [2607:fea8:a200:445:917c:58ca:660b:c965]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb4160a3-1052-41f6-f01e-08d7c11fec15
X-MS-TrafficTypeDiagnostic: DM6PR12MB4155:|DM6PR12MB4155:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4155FF59956738787B6776D7E5E20@DM6PR12MB4155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(66476007)(66946007)(66556008)(44832011)(316002)(8936002)(2616005)(478600001)(31696002)(8676002)(81156014)(52116002)(81166006)(31686004)(186003)(6486002)(36756003)(53546011)(86362001)(5660300002)(2906002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4155;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j32sXWb4IrjknMmY3meh+uoI4X12XkMKeLx1gadHs1v2+pE4lxtq66tVjxAhsmnjrIYhlbawY7Y/Z3hYVe+zVieQp6HxS/yEXghXAMAjK8Iuee/CRFwBWYn2KIbKTmgRd0WkDrPFFZ1ptFMnibz5k9kbMuUnUPOjw8k1bstgooGoViutKZQf0TmM/Ulby+gNULDESZKydImJFpopdPNGMkV4L4gc4JbN/+PXA4hWxIpI8a8i1vSPf3eY4Ett1A3bdGDf9TPp1nc22NAbRrlFsA7EOf7lH10aDHkFeHjBL9idadpBHm5d3T2CgiQtDobG6jnwJSZtjXsrs2st4otz8kYLqAGP44kn7IvCCOyKC7G5W2x87SREBLkgNxtNuoatPMlvUVNfnE9JvrHpI6gd+6seCmyi/thdTk1WUPUtGj7DqQ//ApQ/lG2SYGkGpiII
X-MS-Exchange-AntiSpam-MessageData: rnblW/RQ9OOVV6ndyKct1tWlNaOTxkOYaSW5TALmvrJnrEfhhtl/JHPPn25nXaevlyETlhvfaBaWuHAsr8PR9KL9ptO+Wn4v8mpOqJwjdNBQfwClOotNefGEQBWUPB74bor792BbD0JQp7g81o6wcqhPSP8o/Hk7fiUwaOYrvQ5VuDEXuPQlCqyxKUu/2YUwESfBpcUzJDQYktqZb0UmXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4160a3-1052-41f6-f01e-08d7c11fec15
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 16:11:54.7081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvER/WcgKkUlRsduECSQ+ydec9XS37sydqzoVwi2dwv7cSSOLRObfMXRUztkX+W2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

This patch is:

Acked-by: Leo Liu <leo.liu@amd.com>

On 2020-03-05 8:33 a.m., Monk Liu wrote:
> and disable MC resum in VCN2.0 as well
>
> those are not concerned by VF driver
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index dd500d1..f2745fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -320,6 +320,9 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
>   	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
>   	uint32_t offset;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	/* cache window 0: fw */
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   		WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> @@ -464,6 +467,9 @@ static void vcn_v2_0_disable_clock_gating(struct amdgpu_device *adev)
>   {
>   	uint32_t data;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	/* UVD disable CGC */
>   	data = RREG32_SOC15(VCN, 0, mmUVD_CGC_CTRL);
>   	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> @@ -622,6 +628,9 @@ static void vcn_v2_0_enable_clock_gating(struct amdgpu_device *adev)
>   {
>   	uint32_t data = 0;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	/* enable UVD CGC */
>   	data = RREG32_SOC15(VCN, 0, mmUVD_CGC_CTRL);
>   	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> @@ -674,6 +683,9 @@ static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
>   	uint32_t data = 0;
>   	int ret;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
>   		data = (1 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
>   			| 1 << UVD_PGFSM_CONFIG__UVDU_PWR_CONFIG__SHIFT
> @@ -721,6 +733,9 @@ static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
>   	uint32_t data = 0;
>   	int ret;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
>   		/* Before power off, this indicator has to be turned on */
>   		data = RREG32_SOC15(VCN, 0, mmUVD_POWER_STATUS);
> @@ -1231,6 +1246,9 @@ static int vcn_v2_0_set_clockgating_state(void *handle,
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	bool enable = (state == AMD_CG_STATE_GATE);
>   
> +	if (amdgpu_sriov_vf(adev))
> +		return 0;
> +
>   	if (enable) {
>   		/* wait for STATUS to clear */
>   		if (vcn_v2_0_is_idle(handle))
> @@ -1686,6 +1704,11 @@ static int vcn_v2_0_set_powergating_state(void *handle,
>   	int ret;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	if (amdgpu_sriov_vf(adev)) {
> +		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		return 0;
> +	}
> +
>   	if (state == adev->vcn.cur_state)
>   		return 0;
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
