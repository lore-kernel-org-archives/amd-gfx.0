Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC19C3DA6E
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 03:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A403D10E2EC;
	Tue,  9 Jan 2024 03:01:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E9D10E2EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 03:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Esk+TdBXAHp5P3N/mQgXjw+Qav4nF7GM01+xmPXBxUK26UMHnX9FlusIRLqbV/B3WnbUSevyVWJmftRBkpVRGAyAOgcZ9ErOwve3NkbdpuS8+p7LPIrvKVwGk5pcqcN4iAIwb89dWPhMO4ayXOpFsec8Ew7Uxw1igJy4Bk0e0z07OocYzdaOD6EDgeCniQ0Punsx0bvG60ICoQTtrc11ULkMIAUqSHo4JwBW/vXW9/CsPIzuDH5HGNNUPu7HyVBVUzZLP241rZ+oFrPySvpRSC8HgdjUeMqiEIZzRdMPkqS2QKrhTfhZCDE6eIwxfhAPQyCG9q7hRBz7DZ6Sgf3kAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9Hp3mkAABlNLGS0X4s6Mk6UtUuiHFBzJW3SrFzP/7w=;
 b=AgTh6LmUSjtmiZP++lkVdPtrl1EtfYhcFaqo+7dyYbpeV4ieBPt2IWlXz+LQT+S2pvznyZrs75oVBcRbzLDQJesQN8S5XYktBL+WfxBKl9a1gwf9igrofWQC6TFvMRHV9LjCotBDV8liKD6XLBP9vbQLnLGL5lWbh/r/fIb4GEOt+YVCG+ReYifoXVt3Vmgix7YDg313Eoe27DlKBQeuU4wWZ9ZO6SUH2thu+d0KABI+GG53YmcxcEls4vWbw1ODwphUGro/P/hjPhYLpfTeIN41t5SGL1DGT+h4UqkRfLiTWQO4lwr+DIm+WrLegtsSZHo4JWqindkZ0c5U097sUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9Hp3mkAABlNLGS0X4s6Mk6UtUuiHFBzJW3SrFzP/7w=;
 b=me2kXE1I/empowTXXANGIYbVK/J06QIdTMSz8U3dmmArSPF9ad+LOqtsWIuuxENg8bE08liCFT2WJP4L6LghGr+rrK7XfHgPjYuukhOKB3iQyyykrN3WqfBNJvqMBvIXVi3YjLwhc/DE0FHkQsQeniQyWYPlAvqb3G7at1F4C8o=
Received: from DM6PR12CA0020.namprd12.prod.outlook.com (2603:10b6:5:1c0::33)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 03:01:28 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::c3) by DM6PR12CA0020.outlook.office365.com
 (2603:10b6:5:1c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 03:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 03:01:27 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 21:01:25 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdgpu: update headers for nbio v7.11
Date: Tue, 9 Jan 2024 11:00:29 +0800
Message-ID: <20240109030030.1138707-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 404f6081-a99c-4958-e8ed-08dc10bf460d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1b33zU1iBeq/kk5AxCeVO+ZVezsiscu8202X42CvoS6obbSYqKmyftn1dY1KQ5W+wyrYd4uW5oFapBugX7DnJmZy7OgG66Nzdg3mka4WJ+woCs9NDhsfaoUoZ/fZ1awNR437snQGUI9ms6Gm2T5bTlapA6TMBMgS6NdThcvKoUycVvQAJqUs9xyYklBzGa6YLW8/loMY9awG5joWvpSXzn2vC60FEiZRbtSdT3E6TedNTp3WDA01P5ywl38RaCjUeURQutaa4GxjPcEWWS80nT1MM+VgFcqOpaWCf+SM+7JshC+F81LaSBzjZLEfxKHE7eHVOkyuC6zyAHdEvYT6HO4ny92SILDdyaAMfUii4gBW2KX/uaspGCbOVydbRC8knjiwj9mp7ude1llJ/X4iO+8x5ldSEgyizlVVfK6qTo975iHTzEW2m8TolyBZKCJEzBsHOiUh28QbLP2plHcgF1uAi1ice/R5bF8tDWsryDLU1cUGo9+D10OWaKrHxuv2fihSNCx9bemJX6wzjgLk0BBUipJFMSDlgBzwaF6mhhM2u52VHqq+A3uJUS8wR2Z64sqdEGylcmxb0f01LcDynNwEJTz1pBogkRurlVsRDvmQ/oLFtGgo0jjWw2HylH8K4J63qpQlkSaXALJ1itTNQLQlkXssBj4oESUZvSD9kzE5d5vm6Qcrnes3FUbpBRXcwWPImmqeTTjSQUYrSBJ9DcR7WhT1cVURQpzH8RYU2D+HQsId8RqowMWir2/7JvByT4/tTJyd7MWhry5g3BYtFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(40470700004)(36840700001)(46966006)(47076005)(356005)(15650500001)(5660300002)(2906002)(36756003)(41300700001)(86362001)(81166007)(36860700001)(82740400003)(8936002)(8676002)(40480700001)(70586007)(70206006)(6916009)(316002)(40460700003)(4326008)(7696005)(54906003)(478600001)(426003)(336012)(16526019)(2616005)(1076003)(83380400001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 03:01:27.8944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 404f6081-a99c-4958-e8ed-08dc10bf460d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Lang.Yu@amd.com,
 Li.Ma@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to update headers for nbio v7.11.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
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

