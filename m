Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3D5C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 01:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26D7207DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 01:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1xARb9UZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26D7207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6176189C21;
	Fri, 28 Aug 2020 01:16:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2092089C21
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 01:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHrJx5y+kwoYB4i5FQ2EWzj8yqUDiEgHOEqKl072S4fRySO/QbCYA/Gcy+AymerNd5MDBBpE0qDRgpc/ekLFmO58JDlM9CNNSuIvb//K33G+sHlKAQ93WlCuRMfrNjXh2rh1X+Oc4wljcZcf2dvm9Z1qO9F6UnIwqsH9GiyiPozJrhdPAXwpztvoJGVuHXBA9fnViQc2TXGtxvryc3Rs4olYhpVa/Nm9Kzi2Q9rfqmiqVU4wSPSA35oUa8ad9Tx6kTbVRNAVxTItDzQ9eiX8XsFdOwF4YNYauCqj9YXqZejJNSg9UooB0/oJRJffOXCeTwXyC9IHmyyCVz09ydIRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rp7dSRIRbxSAPiOHD6OZYAwK0YGXygazoE/s1KEcvw=;
 b=PdXBvW2nbBTpTqOK6zzznZEl49Zs91lMEsoYj4U9D5HnsSx4aeMfrk1jAM6dWuO9lgmc0ZstSfXUJk/hNz23X4m78ZRvJ3agpXOcSatWgg/2vfxN6M6EqCDVfDQzP3Gk8BaGxT2kSRJ/+NnSkLhS9X0X8CaSiBO5/CP0gItAALGrGAniG1kbJZXgKGp3TMny/wwWJFYlOnNrtBl4qntVVyNznpU48th7xFIz0dMTrOKbsYyYfohgcfLVIH6f+IlNp91Ts56pnV4X1RC+74C+8mwoVXS4Ed4UT5ynx1T20V1In0HlmcbAJakW2gukRC4fllkjjQsof/VVJP03TkbHQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rp7dSRIRbxSAPiOHD6OZYAwK0YGXygazoE/s1KEcvw=;
 b=1xARb9UZFv7VQZz56ZH0QhrJnMzasjSi8HSxSWQzfOmJFe/L3dQcKR8RL3JGtdwaSacXWCYhVK4ulpQVyhVJcO2RdBjmabIG7EjuYshyOyeYwNWOs+2G3ib6A6J6EuF8P2rFgM7ogoC8B2Z4aX1+K1UwxBK68fdFhlsMe6zib98=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 01:16:08 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%7]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 01:16:07 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
Thread-Topic: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
Thread-Index: AQHWfITd24RUbNZaY0OJJZiV/rc7E6lMuDjQ
Date: Fri, 28 Aug 2020 01:16:07 +0000
Message-ID: <BY5PR12MB4115985F3DA93723F8D2B82B8F520@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200827151858.55326-1-nirmoy.das@amd.com>
In-Reply-To: <20200827151858.55326-1-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cd07b69c-e3f0-42ac-9962-800464982f6d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-28T01:14:52Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b146499-159f-42d5-7663-08d84aeff145
x-ms-traffictypediagnostic: BYAPR12MB3192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB319285C3E65B6CA8CF1FB8468F520@BYAPR12MB3192.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WNWMzDkeG4VuvRuEKZU3HqZdpPAZvSNhIE+4PBgdOHakhetK3M0u2qQmmDHxJeDKmFbbK31TSJG+djJGCzF/pC9gODAJITjdae6jfw1SUZo+VhOmjQ+WRqlg2sEBb1SquG0Ga82frUg/osjEBYfw0ZYFsQbjnXeh/Ls5M4VuQ5XTxmcMSDa0D1JEBRtEQj4T5hG884kpFETE4TIrKq/pL3XB3jD453MdufUef5Na9AyMXw/+MJe6voLYkORJpgUaCNALuXSFYGMLPTFHRz0tmUfuoPG+GD5tm/9JyhWFeCKvInzMv+MTLReU9RcuQ/4pQ6Y9zHJh3AeUeyX1Rudohg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(2906002)(7696005)(316002)(86362001)(8936002)(52536014)(110136005)(5660300002)(54906003)(8676002)(33656002)(26005)(186003)(4326008)(66556008)(64756008)(66446008)(76116006)(66946007)(66476007)(6506007)(478600001)(9686003)(55016002)(71200400001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: /bSO6lKHvFXvsGzktGxMOjf4PS/cWctJhtn3texM53JG+J6ayb3ByqnY4W8R3KaOhzByW7LRF7ZYLyLEDmS0s3pRLdke+wIcqYJ0UkURuVvDy5/TprlZeQXbSWwi9sxaxUimGPh2CkwQC9xEvQBGR+/+PUKNL2LJNk6d4bwkfmD4eV2FXt7V0ZGueWMPQKHbt3PqYBn0G64Q2aNeiKqxHzOJ9FK1mZeBB7flVfE+ndoAwWzdgXFMhd2S33BWnjvCMEaOp0Cq9j4nvetrtF8Je/bFtGzeS8fTzRKXQ9IVm3QZp1Oz7wPmESPfqKPPf7aAzXuNJRygcWOXLftReVkS7m5H/NA00WHMfkEcBfsukCSFp4GnAJU956pt2we86KCkfY17jB009yyfEOwITzyKlaP/Yv5CacSbeyyvZbcpAQU8zYtAHZsgmgB0o4ZGpyegqnQJNi0q0FjKufOlxmP9uqtjA91q7fLBS5ydiATSmdCI0gPQVKpkkQQdt1/y2ECPenZF85NAA8CaLVa49SPeb9Qt4WjyVjLb+0cjhM39QCS3hYmr8z7wOduptP8CBoa3wyzsh5j1CVwozKYJKUBgkwZ2+c0Kr9hnPGFwR48enxi0ze2+W9ZoFZISukqcosblPgQMC4CdfpsrZPpkTEVYPQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b146499-159f-42d5-7663-08d84aeff145
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 01:16:07.6041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WIsPWfDl23LvMdse/NodSLLJ5roMV/OrGAPjZ9EOXSbv43ueToiGh3fXDywHiBuU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3192
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gu,
 JiaWei \(Will\)" <JiaWei.Gu@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Nirmoy,
    Still think the original logical is more clear.

Best wishes
Emily Deng



>-----Original Message-----
>From: Das, Nirmoy <Nirmoy.Das@amd.com>
>Sent: Thursday, August 27, 2020 11:19 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk
><Monk.Liu@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; Deng, Emily
><Emily.Deng@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
>Subject: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
>
>This patch removes some unwanted code duplication and simplifies sriov's ip
>block reinit logic.
>
>Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 117 +++++++++++----------
> 1 file changed, 60 insertions(+), 57 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 696a61cc3ac6..0db6db03bcd3 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -2587,77 +2587,80 @@ int amdgpu_device_ip_suspend(struct
>amdgpu_device *adev)
> return r;
> }
>
>-static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>+/** amdgpu_device_is_early_ip_block_sriov - check for early ip_blocks
>+ *
>+ * @ip_block: ip block that need to be check
>+ *
>+ * Returns a tri-state value for a given ip block.
>+ * If an ip block requires early reinit sriov then return 1 or 0 otherwise.
>+ * Return -1 on invalid ip block.
>+ *
>+ */
>+
>+static int
>+amdgpu_device_is_early_ip_block_sriov(const enum amd_ip_block_type
>+ip_block)
> {
>-int i, r;
>+switch (ip_block) {
>+/* early ip blocks */
>+case AMD_IP_BLOCK_TYPE_GMC:
>+case AMD_IP_BLOCK_TYPE_COMMON:
>+case AMD_IP_BLOCK_TYPE_PSP:
>+case AMD_IP_BLOCK_TYPE_IH:
>+return 1;
>+/* late ip blocks */
>+case AMD_IP_BLOCK_TYPE_SMC:
>+case AMD_IP_BLOCK_TYPE_DCE:
>+case AMD_IP_BLOCK_TYPE_GFX:
>+case AMD_IP_BLOCK_TYPE_SDMA:
>+case AMD_IP_BLOCK_TYPE_UVD:
>+case AMD_IP_BLOCK_TYPE_VCE:
>+case AMD_IP_BLOCK_TYPE_VCN:
>+return 0;
>+/* invalid ip block */
>+default:
>+return -1;
>+}
>+}
>
>-static enum amd_ip_block_type ip_order[] = {
>-AMD_IP_BLOCK_TYPE_GMC,
>-AMD_IP_BLOCK_TYPE_COMMON,
>-AMD_IP_BLOCK_TYPE_PSP,
>-AMD_IP_BLOCK_TYPE_IH,
>-};
>+static int amdgpu_device_ip_reinit_sriov(struct amdgpu_device *adev,
>+ const int is_early)
>+{
>+int i;
>
> for (i = 0; i < adev->num_ip_blocks; i++) {
>-int j;
>+int r = 0;
>+bool init_ip;
> struct amdgpu_ip_block *block;
>+enum amd_ip_block_type ip_block;
>
> block = &adev->ip_blocks[i];
> block->status.hw = false;
>+ip_block = block->version->type;
>+init_ip = (is_early ==
>+   amdgpu_device_is_early_ip_block_sriov(ip_block));
>
>-for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
>-
>-if (block->version->type != ip_order[j] ||
>-!block->status.valid)
>-continue;
>+if (!init_ip ||
>+    (!is_early && block->status.hw) ||
>+    !block->status.valid)
>+continue;
>
>-r = block->version->funcs->hw_init(adev);
>-DRM_INFO("RE-INIT-early: %s %s\n", block->version-
>>funcs->name, r?"failed":"succeeded");
>-if (r)
>-return r;
>-block->status.hw = true;
>+if (init_ip && (ip_block == AMD_IP_BLOCK_TYPE_SMC)) {
>+r = block->version->funcs->resume(adev);
>+goto show_log;
> }
>-}
>-
>-return 0;
>-}
>
>-static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev) -{
>-int i, r;
>-
>-static enum amd_ip_block_type ip_order[] = {
>-AMD_IP_BLOCK_TYPE_SMC,
>-AMD_IP_BLOCK_TYPE_DCE,
>-AMD_IP_BLOCK_TYPE_GFX,
>-AMD_IP_BLOCK_TYPE_SDMA,
>-AMD_IP_BLOCK_TYPE_UVD,
>-AMD_IP_BLOCK_TYPE_VCE,
>-AMD_IP_BLOCK_TYPE_VCN
>-};
>-
>-for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
>-int j;
>-struct amdgpu_ip_block *block;
>+if (init_ip)
>+r = block->version->funcs->hw_init(adev);
>
>-for (j = 0; j < adev->num_ip_blocks; j++) {
>-block = &adev->ip_blocks[j];
>+show_log:
>+DRM_INFO("RE-INIT-%s: %s %s\n", is_early ? "early":"late",
>+ block->version->funcs->name, r ?
>"failed":"succeeded");
>
>-if (block->version->type != ip_order[i] ||
>-!block->status.valid ||
>-block->status.hw)
>-continue;
>+if (r)
>+return r;
>
>-if (block->version->type ==
>AMD_IP_BLOCK_TYPE_SMC)
>-r = block->version->funcs->resume(adev);
>-else
>-r = block->version->funcs->hw_init(adev);
>+block->status.hw = true;
>
>-DRM_INFO("RE-INIT-late: %s %s\n", block->version-
>>funcs->name, r?"failed":"succeeded");
>-if (r)
>-return r;
>-block->status.hw = true;
>-}
> }
>
> return 0;
>@@ -3901,7 +3904,7 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
> amdgpu_amdkfd_pre_reset(adev);
>
> /* Resume IP prior to SMC */
>-r = amdgpu_device_ip_reinit_early_sriov(adev);
>+r = amdgpu_device_ip_reinit_sriov(adev, 1);
> if (r)
> goto error;
>
>@@ -3914,7 +3917,7 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
> return r;
>
> /* now we are okay to resume SMC/CP/SDMA */
>-r = amdgpu_device_ip_reinit_late_sriov(adev);
>+r = amdgpu_device_ip_reinit_sriov(adev, 0);
> if (r)
> goto error;
>
>--
>2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
