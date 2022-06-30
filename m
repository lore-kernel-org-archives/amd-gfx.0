Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9524AC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0266910F9CD;
	Thu, 30 Jun 2022 19:13:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC06111A1ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRi6zaRT6pG6W84jzrVsZUyNp/FN/eFC0rkHN1Ok8VbIYLg5wQR2+WbHnmzE4//q/5emq85LdMssbUBi5ACXHgpH/B4q+vCMhvplTQ8trdo7CvkPZXjtfUIYAk4Z1TWma3nk1n/Cn9YRQn2J5yETlRdBzs9h0mXSlm5gODm3zAwtFcbBymEA57G7fcaNpDnfNAYtuf3M6Htk445QPH0mBEeMVjSzsJQ2iZh6Pl80drCh5SQuFkU4WKO+XKh2Bt0lG+gaIZQiJRmvkNdvZ1naAiSq2+PhWMpPgYNRPnVcl+2Wd0kwpAsRqz3Hc5rXhssaWX/9723QldRnMNzrzF5mjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WC6rX3ee/EtlF9mT9ZxSQlThQbwDurTp4NsTkskr6fo=;
 b=VTsb/EYrGIv+COcrB57XcK3GW4klyFGh1CANuxVco/7y78iUYssrJ5YXM/MbnEYO3srHw7hKfen5YEZlNUBe6Kh4A+OVMJQEZEjMGsRVT1/tpYTLVD8cA/TRPeJO1oI9tRCfTZfFtp5hNpDSzCTXrMVHefGIqY+VyxX5yt/UtKZJnWuBRHcz10ew9Ox735m1APTQ6HYZ3UKzHcYKI5aDBTG8+uVXYW4J8brq0LgSL7ADQMPj6WhsYHonwgnWZ1Yb1mRydImzfyeJ1kIEFXWqifSvCD4Gp9frg1Xhr5HgV2J1DYg3h6VwNNHerAm1Qi/DN0QCoOKs4btTGiy8Z20qag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC6rX3ee/EtlF9mT9ZxSQlThQbwDurTp4NsTkskr6fo=;
 b=slLQPWoThmYCxyqjFSZMqDTKKwYRoml4FjK3/FwxXr/FC2TcD5euA/2ww+tL434AYI4fbUGWnCSSVz73MCkKAsB+DfGMrDLtvTAEd7NeWB4fyNZVvnz+TR7XgSQSg1EzTfrwy+jxnWnzs1Wt9Qt+ryIn62gWgtr+e15KcjpHbPo=
Received: from BN0PR02CA0051.namprd02.prod.outlook.com (2603:10b6:408:e5::26)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:13:50 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::af) by BN0PR02CA0051.outlook.office365.com
 (2603:10b6:408:e5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 19:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:13:50 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:13:48 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/40] drm/amd/display: Add missing registers for ACP
Date: Thu, 30 Jun 2022 15:12:43 -0400
Message-ID: <20220630191322.909650-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b24858d-a0b0-4341-a2ae-08da5accaa24
X-MS-TrafficTypeDiagnostic: MN2PR12MB4567:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aggs2mvW2PNiEqOvtgKMGXH0NQHSDh5BT4Q09cDKq9OW2AIbVFE/stjWNDvcw5UgAEjjEE92wLAYa6e7RxYQkyMckhtzQqa1X+cxk/+Q8iENeS/RzIrwCg0K/YCdFyh/pwhkabiR9zzvfFB7PtyTRw0ZLNryg3EO6w0DHCJ/pE+80492u0XzxECqKUfz18ed5ZNAhg5TSoyc6v8oun9Mi7v3IbdQYSMjXBhtv83u4Oo2ol3Qte9wfIrt/fi+8/Hl2pgIfLUuKg4dlJakFKQ1woxtHE5GFTZSVTjmDrjpAaSbffzXgKLXiiyffg0PUSOBpUMTSK+dCElVaq1zIxDePRuGG+v4OicroONrHTheF20D88YdcvyzHkufyuvKJw/oLhgbthMU5QJTZk/AuQgxwHBJC1lB50bcv8JRcAoTnaagoOgSlKT0ocviGcCv2DY3tptg8ZcVWHabOOiFBfHRHGf598PgYloJ7hS0eG+4kpzkFInbon9H4jpko1wVTj/mKiLf/Fdadn12vOykOUZKsB3iBFUQ5bW6JeLFAq3IZld/eQ95owcnC5/hfBxqcGLygmIVHscDsfwqiUr/dIWVcfZkbzhNLp8Q0+m2m26rq/IG8sret1NycNUROFs1qdAr172QZIFf7Pv3NWHuIRWDcGq3wJyw7pVyZAGTYtLEipm3/R2Ujuk5cCmjePzjv4vxFvkDAAITs8m9QESs+ykvNnPaV19FhkEXIVCTMdIAcKWolUIlz0/GIaGxabcfU+Xi+FjmaWp5zw3K3gdsnNZtHIq2PqyNayS2sjZixwW8d8mesDLziXhyJuMpUVc8bjrNTXY26CwZ/x4+ZaAqRDW7itVU4rn6uOqSsjMx4kOGsDg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(40470700004)(36840700001)(46966006)(5660300002)(478600001)(8676002)(4326008)(70206006)(70586007)(2906002)(8936002)(40460700003)(26005)(86362001)(7696005)(6666004)(41300700001)(356005)(6916009)(54906003)(82740400003)(40480700001)(316002)(36860700001)(82310400005)(1076003)(36756003)(47076005)(426003)(336012)(186003)(16526019)(81166007)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:13:50.0077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b24858d-a0b0-4341-a2ae-08da5accaa24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We are missing some ACP registers/mask value for some specific ASICs.
This commit includes it to those ASICs that support it.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_sh_mask.h | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
index ea683f452bb3..b79be3a25a80 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
@@ -38746,12 +38746,14 @@
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
 //DIG0_HDMI_INFOFRAME_CONTROL0
 #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AUDIO_INFO_SEND__SHIFT                                             0x4
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_sh_mask.h
index 59155007c186..e454d4469f17 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_sh_mask.h
@@ -29361,12 +29361,14 @@
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
 //DIG0_HDMI_INFOFRAME_CONTROL0
 #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AUDIO_INFO_SEND__SHIFT                                             0x4
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
index 396c33fafc91..b9de0ebc8b03 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
@@ -33955,12 +33955,14 @@
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
 //DIG0_HDMI_INFOFRAME_CONTROL0
 #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AUDIO_INFO_SEND__SHIFT                                             0x4
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
index e8f4ad05932b..5c469cf635e5 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
@@ -18093,12 +18093,14 @@
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
 //DIG0_HDMI_INFOFRAME_CONTROL0
 #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AUDIO_INFO_SEND__SHIFT                                             0x4
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
index 1f21f313bd1d..cf3398f15666 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
@@ -33961,12 +33961,14 @@
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
 //DIG0_HDMI_INFOFRAME_CONTROL0
 #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AUDIO_INFO_SEND__SHIFT                                             0x4
-- 
2.25.1

