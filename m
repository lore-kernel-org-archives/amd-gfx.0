Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD996C5DF9F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 07:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A8F22249
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 07:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W8ntfNnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A8F22249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9ED26E9BB;
	Wed, 21 Oct 2020 07:56:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66496E96E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 07:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0CsyyrCCTd65F+LNuDUzEpVhNVpxMvB/rDWaLvQ4U4mt/71kOBaE6X9hxTDEMNihiV3nbpirdZLGHgPpIFpekw346fx9AP9TVcecmyfVcv8zdJg6gdsBMRGHcNGxb9UaL/xreybgoqpmnxDMVGxKfmcTFYUT1fs3D0eYK0aTnJfmdYPo1z5oLYrkbDGXZiJQRCe2Cq3gEZPkx3Q9daPqT+XTvZf2Z1T4k5okpFiao3VxjaxiM+a0B+c+2yGCT5wvgjOxkpCwyfSMyFOQQa30RYcUlRnUbidmc6X59suOWBsBKN57uP24CYy6PFMVGZYdk4o7R28BWDW+kvtL6ZJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeaNXMK9EOAou2c+bPnsUTsh06gCIsueQx+017XTu1Q=;
 b=Fc1yKbpC+V67zHNHV9UaYON76kB+r3dC/0xK1r+Fg9GzfkB962QeW12aqG/AyjlznD619S1L+3O4yE+Qr+cfHouNOy60hSBX2tBUMRKocoO82hSz/DYcexhveVMyqoCe+MxcupDN2U4Xai4DukPfX2JuZbj0UkNu3FXOYvsW6i/vMrugNGDgkkwOQMGRp8aHu1bX3jE1o+VClHIDNBo5iIBm2j8BaaAnYGNxZjDxIwf7wOfxOcA8wOLZzW8hB0qX4I2LvxZPiptkrPDGO2bw5HDUrGdzwFvcGpN3HcuV3Ssi0yuFZTJiItyEU0TQnJwEzwMAVxQFzxlOxVpuwlVLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeaNXMK9EOAou2c+bPnsUTsh06gCIsueQx+017XTu1Q=;
 b=W8ntfNnHD/0k9ZgWOMAd3SdufekP0jtaiNKoqSNsWzWE9hq945gUu1MIXog19LizOerjrfXRZ1EN95wiNSstVyWOs47aYrNpikThi7waChUUGZWWF9v4bsxAXjhB6Y5ezUvwU0wdK9qhsCpD6y801ba6QUVa0fNsJ/oncB76W30=
Received: from DM5PR06CA0034.namprd06.prod.outlook.com (2603:10b6:3:5d::20) by
 CH2PR12MB4924.namprd12.prod.outlook.com (2603:10b6:610:6b::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.25; Wed, 21 Oct 2020 07:56:20 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::d2) by DM5PR06CA0034.outlook.office365.com
 (2603:10b6:3:5d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 07:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 07:56:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 02:56:19 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 02:56:18 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 02:56:16 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: disable VCN for navi10 blockchain SKU
Date: Wed, 21 Oct 2020 15:56:08 +0800
Message-ID: <20201021075608.16785-3-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201021075608.16785-1-tianci.yin@amd.com>
References: <20201021075608.16785-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d3fc0bc-a0e0-4e48-5cb1-08d87596cbde
X-MS-TrafficTypeDiagnostic: CH2PR12MB4924:
X-Microsoft-Antispam-PRVS: <CH2PR12MB492454D3BDE62DD6CD56555D951C0@CH2PR12MB4924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+R0NKryAkWA7xwYW4TFEg1eHLFnT/a97dBhUkDNlAdpuxJFY4RASRdhubyTm9DIemq+cXtBeO7Pbdsh3YmwPdbS5CczlRAXVg+tuHZzGXJ/TIbsPAlhHr60DZx/lkWZkBeCQ+elvHtZQm3Zav3keEmb1UEdkxTO+s7rIQLiLNNbAbNyKArnfn5Fj4160NvvjzdvtvVYsgu2K7JOIE3VokSO3o6KaXFD1r6JTqmgrk2Q8oPRjnC50nBXjTwBdhOopXRorCndtmnkAay+ra8PED+azK88ALO5JjP3MoLtsRAaA+9wIuC3Os39+2/K0+YQRnQWkeI0vPAy03BlLLj0gIzrEQFLFUL+/S8bZ+ZvholuHmE1JNQ7/Lf5yKuQppi2o1gkv0DbTK4h7dVp8MlmQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966005)(316002)(36756003)(426003)(8676002)(2906002)(82310400003)(83380400001)(356005)(336012)(54906003)(81166007)(82740400003)(6666004)(2616005)(4326008)(8936002)(186003)(47076004)(70206006)(26005)(70586007)(1076003)(86362001)(5660300002)(6916009)(7696005)(44832011)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 07:56:19.7847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3fc0bc-a0e0-4e48-5cb1-08d87596cbde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4924
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun
 Chen <guchun.chen@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

The blockchain SKU has no VCN support, remove it.

Change-Id: I26fbdabdf67aada24c5aebef999ee8b5f9c0bfe2
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index ce787489aaeb..ffe4c2b3ea5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -538,7 +538,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
 		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
+		if (adev->pdev->device != 0x731E ||
+		    (adev->pdev->revision != 0xC6 &&
+		     adev->pdev->revision != 0xC7))
+			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
 		if (adev->enable_mes)
 			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
