Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D266BC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 18:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89ECF608FE
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 18:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89ECF608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5660D89872;
	Tue, 13 Jul 2021 18:48:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994D789872
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 18:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfZZGKFuzYQmEWxM1eixuDpKOWYPfNC98HsqAOnHX5AX6gfjdXQbVk+4tBH9h5XMCPglAS/mF7QPr4/G4RsuZKFARuRbaZUUhUw50Z0b5OoaMJv20W4cFkAyiLHxHyvlBi8S7aKgcGlSlDobudmOHoM9nm3buv+y7mRC5fupgYnbgqV88uKbP2SxB/JjT+4RBZkS/5VZgwaYoaM0f33UxWKTxhsJQCXtckDu3qAJJ5Eva5xaYh76QSAEcsYR5Ui0EFO8wgNcS40fDSUwMcBW9C/dwSdR/fG8FNjtWLw9/NMHlAzxMrhdS0JN7vmh8bJb7tgPj2U8yPn2xJAzirjbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BCsGKkQ/my+6QRFveid7hsuqmzVsclOj61EKJQ3Vjo=;
 b=I2wo7xpJ015gPeRnuz8xSjF6oDA3/w5zQVmhXhvL5td1E5KYSTVHCI1bGKboSY7EJmc6Cqqb4yftbLj6a/4V0N9+Y5oJvoEjIcFwtDGYoCadPrWQSqI6quSa6WXxphOzY2KLGuRysxAa8vfLVxeVwwYuXJmQUgMYR2b/gqCGJqygc2MkVYGCSM8FSMq8xtrhr8n5ronD/Hjl8xq2wNtVb6o8A87SeG4Gyuh9/6AUIgTMYNZJ67v2DErVSwfnEUgLH0i/w3+CoKnkWSkqv2XIUgG2sVMPzL9slGO7fzCAEjl7hA02gm2WBe0ZNBtaHncPtRwkjfBDHIO7GNnbalc+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BCsGKkQ/my+6QRFveid7hsuqmzVsclOj61EKJQ3Vjo=;
 b=BMOsaxy57K9dShrNovfmm5qavnaHi144QTIeKPpatWKQULbyyiiRO+jBT+SmlcxCUOIwYAq3xwikgKA2xNcTel5f0cQL/C66NYQN2xmY/ekJIVbOzd07PeesfdwLKlTEl7+aCzCWzGJUe4u3oM+9Mx2cHuTd1aPuetwgUduSzl4=
Received: from MWHPR12CA0037.namprd12.prod.outlook.com (2603:10b6:301:2::23)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 18:48:39 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::f0) by MWHPR12CA0037.outlook.office365.com
 (2603:10b6:301:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 13 Jul 2021 18:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 18:48:38 +0000
Received: from X570-RTG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 13 Jul
 2021 13:48:35 -0500
From: <veerabadhran.gopalakrishnan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] amdgpu/nv.c - Added video codec support for Yellow Carp
Date: Wed, 14 Jul 2021 00:18:07 +0530
Message-ID: <20210713184808.1268570-2-veerabadhran.gopalakrishnan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713184808.1268570-1-veerabadhran.gopalakrishnan@amd.com>
References: <20210713184808.1268570-1-veerabadhran.gopalakrishnan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24531be6-5bcb-44a9-d32d-08d9462ed3d4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5088:
X-Microsoft-Antispam-PRVS: <DM4PR12MB508836644164B4DFED793AF7FA149@DM4PR12MB5088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcwtsjbxePCZUrY9omNoFqsfNYtfXNThQEVP3+1MRkB1E835zDjwR850nZ14yaE0WvTDy3c/ITZCyNf1pbXmL0Vm0sXe+pJlEd5CKn4tXkOhkh62G8sPrWqOJ3g+hdsvjRK/pxpWKtiStvSRuFgLYUFQP8ExypOgmNlJey5n5F1w/QxIx0xKaDDVbou0i8oNix+HTy/JQkqRb51qIEotCsIdtF875m3M54FGgw6/e2xRfavRXcsucdLHV9afKVHGOowYY7wX7ZFwDBS4aUtZgNbIlc75Eo6zHmMXDgYz5UESUhW7L4KliK6vHpZJGh5djb265c6RKlnhrNGqo3bazFyBduUg50B3V9mmS/15/9w2AC8qEISHProwqDletqXccuxPyFWDWkSSM1y2v4AxiJyz/6asAVz2+1uwvdDMY8kfprNWs0wIorQ/PSPn10vtojmxIccqOj9tBWAsPNuMYsuo9tj7BltO+qbqcZ7/XNXGXwXuKC+0StsUbjY836yGOIlr2smBOF/GDo+J5UFYHAkCHEomhKHDQR2fc4K4kYTorRH0zY8XGihHCYi65GZDqC0tf99b3kHUMI/P4YdEKi/tBmfWjWXwDHDlwYhf0c9+uPztzaXts4Unw35gob16vxIF7D3Rz5lox6SmpndquA866C3aZYnmNs85sZdIvtVunQC9M/X5Cgm+yMWvuGtJ6cty6+OMgmQlVt7BtlGl8gOL4wo5CalaB585nrwaeSw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966006)(36840700001)(5660300002)(16526019)(82740400003)(4326008)(6666004)(54906003)(81166007)(36756003)(6916009)(316002)(8676002)(186003)(7696005)(26005)(8936002)(70586007)(36860700001)(478600001)(47076005)(2906002)(82310400003)(86362001)(336012)(2616005)(70206006)(2876002)(426003)(356005)(83380400001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 18:48:38.4396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24531be6-5bcb-44a9-d32d-08d9462ed3d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
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
Cc: Boyuan.Zhang@amd.com,
 Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 james.zhu@amd.com, leo.liu@amd.com, srinath.rao@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Added the supported codecs in the video capabilities query.

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 94a2c0742..04f6cf38c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -333,6 +333,19 @@ static const struct amdgpu_video_codecs bg_video_codecs_encode = {
 	.codec_array = NULL,
 };
 
+/* Yellow Carp*/
+static const struct amdgpu_video_codec_info yc_video_codecs_decode_array[] = {
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+};
+
+static const struct amdgpu_video_codecs yc_video_codecs_decode = {
+	.codec_count = ARRAY_SIZE(bg_video_codecs_decode_array),
+	.codec_array = bg_video_codecs_decode_array,
+};
+
 static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
@@ -353,12 +366,17 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
 		if (encode)
 			*codecs = &nv_video_codecs_encode;
 		else
 			*codecs = &sc_video_codecs_decode;
 		return 0;
+	case CHIP_YELLOW_CARP:
+		if (encode)
+			*codecs = &nv_video_codecs_encode;
+		else
+			*codecs = &yc_video_codecs_decode;
+		return 0;
 	case CHIP_BEIGE_GOBY:
 		if (encode)
 			*codecs = &bg_video_codecs_encode;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
