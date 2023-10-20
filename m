Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747E6C0032E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 22:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FF010E5FC;
	Fri, 20 Oct 2023 22:06:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CCC10E5FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 22:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDKGCekd8V3k/esk3/kCX4dPxcE6u7C4qOU0vZT2ZFdEkQsAaHmxu5ukeUJ2jOp+zaLvDzziyZgaGE78DOYwRoDfXdOvaVLG7m9IsQpEFLHw8cOrg7yjFMyzeiiMzV2RqM26v5fcNqVam27+/547D8PRGK28eQHQs73H53lXgeOWwu7JeSgQgDA45eY82o7SVWb7XNhI+pRK6NiLEZXfPNUucaQg5K5GQ8tvphRF2US8DcXQL9TvB9vsuBfoAcH2uoolOS2F3PrZX1hBAkKg8ygFn+LUKgmRgonrtYrsl5FT3IX9sKO2vcPtfDsGi9Hmdq1hcIWLQ22LXAP3oSCCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iryqjQdrxkbyC19m027vKXhpcuV/1Gc24F0SR2LRzW4=;
 b=Jr8qzYnbbx2HAtFfSOUGYFjtwB+LVgUvQ944CujceUcHGR37Vk+fu/uItZkprRXkEPVig8wKW3oBdSfXIrV8iQ5801T03R2RdjqY3/1XQt8R6xbrKgLKIZFzVGAcXKuVME0cdhslFRroxml8Lu4LTA85YB6C4y3hDKbLZyvTRTjxHgJ17Q5Ho2FF9oR2MpSGEA92mKUmTpX5jI9gUxpl5dOmBggmw+DaeupOwMpv6aPr58P4gMBXyw1+QrXZFW0YG6K4gYhCO0IaBpgCGbAplHvfICbea1MLphIjeRiNdOGhGC7k0AnS2fWpqtc4DXrwVm03VRSbhcmObm4Mhv0jcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iryqjQdrxkbyC19m027vKXhpcuV/1Gc24F0SR2LRzW4=;
 b=E/rkkEIUh9tL5J91K1ODfj1ofPQevhahEeaDLAZCc5ungKWv7BQmR/Bcf2pxFKwwLZ4DUmnTydCV8+9cjrs6Nofvv9kc/z0Cl7RWvFP78jiYRioSeec7btqgtON1GsTAbn+pPzYPYWChnAaT92U8J3ns4/5CNdM2DBddb18Mags=
Received: from BL0PR02CA0118.namprd02.prod.outlook.com (2603:10b6:208:35::23)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 20 Oct
 2023 22:06:33 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::65) by BL0PR02CA0118.outlook.office365.com
 (2603:10b6:208:35::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 22:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 22:06:33 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 17:06:32 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 6/8] Documentation/gpu: Add entry for the DIO component
Date: Fri, 20 Oct 2023 16:05:19 -0600
Message-ID: <20231020220549.493808-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020220549.493808-1-Rodrigo.Siqueira@amd.com>
References: <20231020220549.493808-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2629b8-f234-412a-5f7e-08dbd1b8d261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IbxJYdqzsbV+fAm8++rHngDcgc++ZwreTI3S3kwzthxI1isR53QyFfkT9z3e3IM/JuqFGimvKS3dy8XA3WFJRL+tW5KW30/vPTYMoB8jHys141zyVXKmO3Es3eOpnLtX9r7UjRPc6t7lzaOHZxewwr/9OUlACEldFa+QmWfXaxl7aeS93xyxIF4mbmUEyfogmXVtM0QXyIDBYuBRgKjtzGSuWG3QDA1RBRt/4MzNGqVzlPaOj45Z89zxMvHIAJRgiNcTt686ol4JTRZzRHo3THofVLe58V8lVGlulMzgRBm9lssj70TA0aR5V2UPdxmdCvcQAJl+hm6PdkTejA9F1V0pWUBe6qL83/Y4CXqnovjFOsCtsIiUR1CywjeHcY9x2N/8TLOeU0cu/QEV0pqMLl+ugr7cSOJRvcwKdUfVJWIIEDZfOAklcxuJO8vACso9Kd7S8i2hKX923/z15Teh1Zq+WTSOwG1yEaaeXlvphatDFjfh2YhnrmOPrJvUrVsC+pcXFZrYn6UtQ3Awd80jZp4GQImsFnS0ddsZSKOZC4TjnUf+OtUUkCD2/yH9aFDeFS06E3/KzFlbKZgs2Jmc7eZ/AQya31pqRm9As2aRlYbGI5NmtWiIEIJDiKOqKR7sY0vz/NKilM0X6QqdTNs3C66EmPzvzZ6XTsZtLV3RXW1KI5WbBt7VIRv5y+sSAVUjiZOr+KxDPLCifuk90je5UzMv1Vi1KyyHCBaG6P+GrA7ZlrukE3maUtRIWEHywM+Ed98pStGSrn8Q8KZSqC+om6VdNbTT5fxZLRwA4s75rYe0fL0niq4UGj5bGKyqrN+I
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(86362001)(356005)(82740400003)(2616005)(40480700001)(1076003)(47076005)(478600001)(6666004)(5660300002)(81166007)(16526019)(336012)(36756003)(4326008)(41300700001)(2906002)(110136005)(26005)(54906003)(8936002)(8676002)(70206006)(70586007)(83380400001)(36860700001)(316002)(426003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:06:33.6060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2629b8-f234-412a-5f7e-08dbd1b8d261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry
 Wentland <Harry.Wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 Documentation/gpu/amdgpu/display/dcn-blocks.rst      | 12 ++++++++++++
 .../gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
index 5ba3c04c1db0..a3fbd3ea028b 100644
--- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -64,3 +64,15 @@ OPP
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
    :internal:
+
+DIO
+---
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
+   :doc: overview
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
+   :export:
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
+   :internal:
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
index f4633d3cf9b9..a1f72fe378ee 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
@@ -22,6 +22,16 @@
  * Authors: AMD
  *
  */
+
+/**
+ * DOC: overview
+ *
+ * Display Input Output (DIO), is the display input and output unit in DCN. It
+ * includes output encoders to support different display output, like
+ * DisplayPort, HDMI, DVI interface, and others. It also includes the control
+ * and status channels for these interfaces.
+ */
+
 #ifndef __LINK_HWSS_DIO_H__
 #define __LINK_HWSS_DIO_H__
 
-- 
2.42.0

