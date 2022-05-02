Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4467BC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 19:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA0410F284;
	Mon,  2 May 2022 19:08:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C9910EA99
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 19:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYzWCjAP9BNenzJkFtQz3QQhE33vGwidbzHhgkCqubjYcbtO+88LehQQ/ZyBsehvSK84LZe+3tKb+dqdHey+jFCkrSXnwlpnlRcY4ujhJEtY6up40uQZE894AVuB3E3+ty9ViaQLI0bQhQiNjZcY7sYZlou9tAw8SEJqX9XFXhRqW1kFMI6hvOMpyMuj9q9bzUQ3FrzVILb6m4He2hTwrajtYmOEKva/jX4cuclAH3NSQy1x3cUMzXxqbbpEgqioF9P7iFkoBo8vZXUbSu0Bc8Kap2AWESs+x2+ehjVNCiyWN/nmqqyGxHRP5g14yAwy9oUa3EF2t+B6TXjD3ol+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYH55JJwuICJsLD+KnBATqbSDRIwRzB2O+3S5BH0JOo=;
 b=MUzx/tm3rmod7G3qtFwXChDPrMQtFnGt4uvcfaR0Ey5U3tU19F5wHFPzj0Jr50Aai66pcSBd5dpr6dJVBwaamDmCGZQgYQYyavIXI5yRU7boz9yfIzKWIeEySXoaCWsiv+liNF/wppoPpgRzyQ4PGW6vwGHEnhmIBhh1Tj4a/Tx6tasAy8o/+sGbcbIXQRIza2tInRGkWdXx3PQv5yUr5PBTpriRQCB6VHLP/yuvnETUOQpuILJkJGhhDL2rfREN11NqDPDOPYeny51JdR52LoLKESzq0Sv8DGsCLVeQik9IapNc+dJtAqTRx7fqbfvWNOLkR5JeKRS9CIILdzJA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYH55JJwuICJsLD+KnBATqbSDRIwRzB2O+3S5BH0JOo=;
 b=JsJm7UwRtkS+sdGtefktupzve8BrTgAorSYvFK4fUEDLX8WzSCNIonGW9E7wvvN13vuVRPoN/KSt6qbRJnSztxu+F+IdXkpYtO+b1Yew+W2r2fEgRhVwJb4MSyqgSKbfZn6w3K744c8lZfycHMcGvAgqlSHntIl7evTsmWSUaPI=
Received: from MW4PR03CA0034.namprd03.prod.outlook.com (2603:10b6:303:8e::9)
 by SN6PR12MB2736.namprd12.prod.outlook.com (2603:10b6:805:75::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 2 May
 2022 19:08:20 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::38) by MW4PR03CA0034.outlook.office365.com
 (2603:10b6:303:8e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 2 May 2022 19:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 19:08:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 14:08:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/11] drm/amdgpu: add irq sources for vcn v4_0
Date: Mon, 2 May 2022 15:07:57 -0400
Message-ID: <20220502190804.784271-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502190804.784271-1-alexander.deucher@amd.com>
References: <20220502190804.784271-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9604f43b-b987-4b89-3825-08da2c6f1f15
X-MS-TrafficTypeDiagnostic: SN6PR12MB2736:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB27363D022398342C03E47137F7C19@SN6PR12MB2736.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1pZ9SFxovv7lPZsWETRNHwghqarB16Y0R7U3PQEss+YAqVUDoqYuZayJ84WhxvEPojVPOyZG9f6++HsVEbm0JlHguv6azAKG00/lyefjlxSR1gkuTaFQzSc+RqVhFKNllm9fAlk9b+tjY5YnUFl8LGFSu7T+UaMF7vYSul1jRLDFcm7gwbNzfx73wV6+nMB6rC+yjimC3KY5fmLUNPkI9D9DiJ9OPlJmtI+RgXusexdR7DOBt4Aydb87iM25cLsLuRN5oE/E94LWrRF0UBp0fr44GAvOpywauWr+zUUmQWtH8MQlqIldsOW3CYn0LgB8F2bUB76d9l5cY0DjjIcEvSX2y97dzukCs1f/1SQcHd11+1Ie1IS3tniWXMqlNVI0rP/QX1WGDHQPDbXBdpZtDicO1nfhR0I971AH8dKq90MPp4uoVc1qXp5Cj+pWGz0iFo1r+QklFyUFgMBUPhXv7pznK++STHSFasu0c3VSPA1a1nJVhi/4y/l0EtorcWMLOTjg5B3CLW/w8jfIcEaiW1axnxJhhOpOUfAvRTAcQ0j9XIb/rSVkl/QFVDk9cdDvTOLifTWBDXMz+T7DWsucl+cuTtJ3Q0xL21PfB2fr8QjPU+m0zSpNlc0RGktQVifuC3COlSWGFNgltiehrNPgbFSIEXfHXpfqCJWmpeAIFKBnhmwWjOq5gVHuiO5JtzxctTOjp3ZSE0oir2yDgsKkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(36860700001)(2906002)(508600001)(40460700003)(83380400001)(6666004)(7696005)(8936002)(26005)(54906003)(36756003)(1076003)(426003)(336012)(2616005)(6916009)(16526019)(316002)(186003)(5660300002)(4326008)(8676002)(47076005)(81166007)(86362001)(356005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 19:08:19.9104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9604f43b-b987-4b89-3825-08da2c6f1f15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2736
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add the interrupt source packet definitions for VCN4.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h

diff --git a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h
new file mode 100644
index 000000000000..a81138c9e491
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __IRQSRCS_VCN_4_0_H__
+#define __IRQSRCS_VCN_4_0_H__
+
+#define VCN_4_0__SRCID__UVD_TRAP					114		// 0x72 UVD_TRAP
+#define VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE				119		// 0x77 Encoder General Purpose
+#define VCN_4_0__SRCID__UVD_ENC_LOW_LATENCY				120		// 0x78 Encoder Low Latency
+#define VCN_4_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT			124		// 0x7c UVD system message interrupt
+#define VCN_4_0__SRCID__JPEG_ENCODE					151		// 0x97 JRBC Encode interrupt
+#define VCN_4_0__SRCID__JPEG_DECODE					153		// 0x99 JRBC Decode interrupt
+
+#define VCN_4_0__SRCID__JPEG1_DECODE					149		// 0x95 JRBC1 Decode interrupt
+#define VCN_4_0__SRCID__JPEG2_DECODE					VCN_4_0__SRCID__JPEG_ENCODE//0x97 JRBC2 Decode interrupt
+#define VCN_4_0__SRCID__JPEG3_DECODE					171		// 0xab JRBC3 Decode interrupt
+#define VCN_4_0__SRCID__JPEG4_DECODE					172		// 0xac JRBC4 Decode interrupt
+#define VCN_4_0__SRCID__JPEG5_DECODE					173		// 0xad JRBC5 Decode interrupt
+#define VCN_4_0__SRCID__JPEG6_DECODE					174		// 0xae JRBC6 Decode interrupt
+#define VCN_4_0__SRCID__JPEG7_DECODE					175		// 0xaf JRBC7 Decode interrupt
+
+#endif
-- 
2.35.1

