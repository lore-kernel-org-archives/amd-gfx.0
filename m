Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9D4C3DA6E
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 02:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2DF10E156;
	Tue,  9 Jan 2024 02:06:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF65010E156
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 02:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L03kW9S2mP1yfbuYHLAtq9ZArqe2ftwTXLuD1+PXh15QZibLY610TGz+FHtU3uZqZ31ILkVzBZfMlL942V7ZDZxrJdtkGCuGoy+2Sk843nHoUsmw8DRF9WyjLGQ1QRBcvfqg1KEdfiylCSADMgs7sG5szj/kPsRPM828YtUlMIhJFRlVRLDw/TLj+WheduVTAetNkoReegylVIynB1X8rWAiGSS0FK6LId4O+T77FwGnBAoZiZWSsFF0R9WrvNZhpS/E9YprYY2n6j8BRgVfviUjjGu2obA2dkQhi16TJRd1tnPTTvyjmRFJpPnoIZckbftop+hyT7hEmW0MYBqpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmNsd3eeS1GEwae+u4lmj7GkdsjrmlScOcPma3CUhXs=;
 b=Xv0lbrD6vDNhi603W27pQ90tNWxD6d8RFE1yd2g7qrkt9owNmR3UxCAf6rV0X+VvpNPklRMVz06o5iCaixhDec8YQ+k1NfE2cbR7EsRhN8rdhcMRLg4qU6yKlZG+y3t6YNX8jMMR1qj8V3IN7RzAy8q3BCq6OSvYUIx+5jQdPo2n4z84z/qgNJvsCwbD0TvYei/Gl4AgTV26ywF5T2P1lih0qaaNYUZq96cqwcgmi79a2Tts6syb/V1sxzCvqW83Z7sz5m3YBINYNSDzmW3OSFKzU/j8ji8/bkznSrayCt0vfSNJCLenXncebIhu8hcVYTv6oob9L6PwippiwVbXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmNsd3eeS1GEwae+u4lmj7GkdsjrmlScOcPma3CUhXs=;
 b=uwBmOHYwBlYe1XvAPy/+FAItmVlvfXcvyVstfDlBUvj/Bo3ESyc5mgaHDxvWPOY8AVy0gzZIfH1crN8Kt8zqHPEdy58IUP6SIclYVRo/CVCXxKzEMSMShxGtTDhr/RPJZeqi2VS/jDY1sD1UJd73IS2yweori8itI2PHJoi3q3c=
Received: from CH0PR04CA0114.namprd04.prod.outlook.com (2603:10b6:610:75::29)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Tue, 9 Jan
 2024 02:06:49 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::ee) by CH0PR04CA0114.outlook.office365.com
 (2603:10b6:610:75::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 02:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 02:06:49 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 20:06:47 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: update headers for nbio v7.11
Date: Tue, 9 Jan 2024 10:06:09 +0800
Message-ID: <20240109020610.1132395-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 988f5765-2ad5-4499-a7d5-08dc10b7a3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEe/8V0ngUysrpCl8bpKKFRmzySV3plLu+g30T+kawHHqPggY/urjpmN2PncP/w86zlc6GsQ7RMdj90PTZ+IDvXXGyn24N5cYUA87damYtE2yvcjLzFPbwMP9mNkouFUEVZdw2VO8tQcgwel297WK/XLPLcyk5BLxKm9WtzSfnEVCnLc6TbtQSAaDPzF7i3MsCncuIR39uhsnTkotEw7FbTO/XfvaYWQd7lwoHb7E/h6w5BxCPkDk/zXNzlL2IUmDHQgSdQscZ7T7PfKXZo8B5Kr/W7agE0Dxb/bObjJQdzyMwaktuvGUbXNLNw2//tLj86D0nsgflgztPTpDk/cCJvWbRHpUuQERdxyO5ST9bTPQ9JhziEdTeNkTzPx6aK0f15F+Dxh/3NqkIP+wYuW08PT79CxI61w1n2O6aG3J82Nh6c08mXpxGYzbs5SModho8XcIAvwrChQcVwtf4NP/mhq+2cnlq9I3qNtHf3QUeTXGlcwXeAe4L4xE4mJ7wcvxxPRfZMUU7ym91cOOPch5PTkqoQjI0bjBoG0vpfmqi05YOaLCxg9Dnt6xed+ACTe9K+dWGu4joAlFlAvpJTexI31yMdQWln2Ha9CJ8s881PCq20VrI4JQQMGruQgr/c58Sue0+nbvy7BBm6+5V2jCvNhmjXAbudFYczLGgDR4rS84FXC1shh61Q0o+CtRFMjISruDvyk/j2ZxdhRRfjswbeT/jnZYYRE8RmO69D/WmN1vADc3vdDK4DMLUzjhqRl38FV+UyKbyiAc6F4hM6OvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(426003)(1076003)(26005)(6666004)(2616005)(336012)(478600001)(7696005)(83380400001)(47076005)(41300700001)(5660300002)(15650500001)(70206006)(316002)(8676002)(8936002)(2906002)(54906003)(36860700001)(82740400003)(70586007)(4326008)(6916009)(36756003)(81166007)(86362001)(356005)(16526019)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 02:06:49.2144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 988f5765-2ad5-4499-a7d5-08dc10b7a3cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yifan
 Zhang <yifan1.zhang@amd.com>, Lang.Yu@amd.com, Li.Ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to update headers for nbio v7.11.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
index 7ee3d291120d..6f80bfa7e41a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
@@ -8707,10 +8707,10 @@
 #define regBIF_BX1_MM_CFGREGS_CNTL_BASE_IDX                                                             2
 #define regBIF_BX1_BX_RESET_CNTL                                                                        0x00f0
 #define regBIF_BX1_BX_RESET_CNTL_BASE_IDX                                                               2
-#define regBIF_BX1_INTERRUPT_CNTL                                                                       0x8e11
-#define regBIF_BX1_INTERRUPT_CNTL_BASE_IDX                                                              5
-#define regBIF_BX1_INTERRUPT_CNTL2                                                                      0x8e12
-#define regBIF_BX1_INTERRUPT_CNTL2_BASE_IDX                                                             5
+#define regBIF_BX1_INTERRUPT_CNTL                                                                       0x00f1
+#define regBIF_BX1_INTERRUPT_CNTL_BASE_IDX                                                              2
+#define regBIF_BX1_INTERRUPT_CNTL2                                                                      0x00f2
+#define regBIF_BX1_INTERRUPT_CNTL2_BASE_IDX                                                             2
 #define regBIF_BX1_CLKREQB_PAD_CNTL                                                                     0x00f8
 #define regBIF_BX1_CLKREQB_PAD_CNTL_BASE_IDX                                                            2
 #define regBIF_BX1_BIF_FEATURES_CONTROL_MISC                                                            0x00fb
-- 
2.37.3

