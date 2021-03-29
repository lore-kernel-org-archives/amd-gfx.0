Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93442C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 07:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3063361936
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 07:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3063361936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 208296E2BC;
	Mon, 29 Mar 2021 07:49:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0146E2BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 07:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eY6MXq1FKfnwPQ2nUC50DG+GhXsCjvrkHXWdm0hL5UL1SEj9fxplYgkXdlO7XJ231+Htn5tZzuzz/TlZHykn++R/n1Nj5xiKP7n5OchFAlJaAYmuzKUK8xrTWN7W0aPMATQWGzJTu981MUHdH1sc9WZiGsxWLU95TYVvLf3uYfTKely1qHRagvDd5O5Fs2NF3hlkIrhphIK8UCCFF/mZ/aOHwp1DYBOdSomx84YQcIP7Fs3yjia6eqnGNk46cQuXT+QjbbfG4McYspKJKQbxiqzzyqoDNKJhDoGRRp2sxEMf8EWfBs6aQphPvR0Sd88LyubGJmwBtcO/Nmp4s50Azw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIrPQxisEG/mTef/XPT+JUD25tz5XNvt4yOKhn+sMsc=;
 b=goQyUMCgoQ/HcYM/PtlE3hNefV2P6+GEAbdl5AKxW33hr31YV/UY8RCGnLCcVlH622zB7erd0cik3DFXA7I+vn1+eXjcywogb1bnQ13GkoKGgB1A88EU6Fz/T3kof6xl8gb17wxTQF/nNiLmGjkfw6SMiv7+V+HeN0xlyLZO3/UkKdgNJ84FpEFz3mvH11MeVpwyMdJ5aOLys3JXjVOUEnp9ZwKGnnKpn81JtZDQlzovZWycU8jM13la9lyC35XLyBgAzB89qigAIsIh6jLsxJq5lcvhsDeZLZ7zhm/wFQLErV9QR4Ha9gV/NKeAdPYBYkoBl5qBLvqrtR/MO4VyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIrPQxisEG/mTef/XPT+JUD25tz5XNvt4yOKhn+sMsc=;
 b=ktmaRKnQ5a+Pv3Chbov+LjMxkdPBrs0bP1x4UMM/O1TQBwuxI2jIxnKFUmS8aSY94r0kFZi2D+ZJlx4MiD1gTKLzMWHFwD0lKoKSaJCNrt4Bh+fw/JwlCblt3WA2E0QGhdS6JNvEqpj4BOkblsHfX1FsgoGH4/qRMF088FfvMU0=
Received: from BN6PR1201CA0017.namprd12.prod.outlook.com
 (2603:10b6:405:4c::27) by SN6PR12MB4719.namprd12.prod.outlook.com
 (2603:10b6:805:e9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 07:49:52 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::61) by BN6PR1201CA0017.outlook.office365.com
 (2603:10b6:405:4c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend
 Transport; Mon, 29 Mar 2021 07:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 29 Mar 2021 07:49:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 02:49:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 02:49:51 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 02:49:50 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdgpu: Disable fetch discovery data from vram for
 navi12 sriov
Date: Mon, 29 Mar 2021 15:49:33 +0800
Message-ID: <20210329074935.10822-4-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329074935.10822-1-Emily.Deng@amd.com>
References: <20210329074935.10822-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e615623-2ded-40c9-8d81-08d8f2873ca2
X-MS-TrafficTypeDiagnostic: SN6PR12MB4719:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4719287204291566F413ED918F7E9@SN6PR12MB4719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdQJxbAu7x5BfmvbbwJhfgsceLpicxeX9l2NoSS9ZuElvjonYQzCIEMaRpeHsmkUiDxBAcnFt3wx5Hov86YCKw+ywpjcymLmytQ60kKjMFsgx7ik4gwQ1HjeBkrpk6kc5dB71M+a/P4wbKICJALC+F6j+RYZcJ1UfNwpQrcCq/55Nty+vSyCG3sMqUSnAIOovt3te3pvzHL+VLLGUiTw72cj3qT/TQB4RkKMyxxsy5oWq7Z8yKqIisS8lCnLHBR/z0SO9VsBgP/l18s8f6MC+yaVh8AMjDHe/xOwqD9yHTig806u/ZtLSYxVqq389EJ7VQlX2A9jk7uA36ym6jzbkcMnwUj72+VfipHFas88sr0LO5PZBXdcFsF/ojN/HTJrS1YNp+M2TKbJvf9Z3Weadtw4qAitaMBTZoPJtlluoauvLN9KYzWhHZZ3UimpYYOZV3tGJ8PMGMXF2/aLnD5hrcAVp40Ji22RuVKo28abF1xxRvREXHJ6p0Wog0fGgUkw60cwgXbm98NQdv57cFvj73rUsP8lC0pgK3hqbdIKOhD0TljCkHLLRfDB0sbdZzSKYWvdo52GIeBZuRo2EN34INkaFcdm5oYP9MMzi7aweJJBO3/ru1CoHssftCXMhcL0b/kUSBAlxo4R05nxCtl/c6KfguV743PWDXRpsHJOI8dtb24nyKWUXf5yiZz5Dw33
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(8936002)(478600001)(6916009)(70206006)(2906002)(82740400003)(6666004)(426003)(47076005)(26005)(316002)(8676002)(70586007)(36860700001)(4744005)(7696005)(1076003)(336012)(86362001)(5660300002)(83380400001)(36756003)(81166007)(4326008)(82310400003)(2616005)(356005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 07:49:52.4278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e615623-2ded-40c9-8d81-08d8f2873ca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4719
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fix the board disappear issue.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 46d4bbabce75..b9832d31f00d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -692,7 +692,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 	} else {
 		adev->nbio.funcs = &nbio_v2_3_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
-	}
+
+	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_NAVI12)
+		amdgpu_discovery = 0;
+
 	adev->hdp.funcs = &hdp_v5_0_funcs;
 
 	if (adev->asic_type >= CHIP_SIENNA_CICHLID)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
