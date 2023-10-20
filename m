Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EF6C0032E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 22:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4052D10E5FA;
	Fri, 20 Oct 2023 22:06:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB9A10E5FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 22:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM5zLWTnyW1XIGFo0+Y3CEQXy07TC5IISbw7uDiaImONisv6CbJUHheGy6uXc6G7Ce99UFsXQYwcWDeBCwkeBt5q4mdoDUzOjraDS0HwENKlB8LjZwEVJFvxgEYrEg09q1Tkw0Gw+Hdtcgtj6QQxeKKxf3RggF8jUhVGaW74Pad4CqwS9crYJaF9O/oyewH//ryaJG3dN0LU7pyCjFkaCBLxns510gc1ZK6jQAErHXkayArMgU4F4Y7KaYCUauf3LcYhpgMarMH8Q3QNqMbyZ/JTYKKSMqg1cfa0gIy9oVBSmzYlo9ORM5nYGwC1wMv3naJqAxm/MODaJ5Hgt/JniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVxWJERjNFzz/5MIonSTHDUFLoQo85KxGkXJ7PTIdVs=;
 b=WhEhbUZuZQU549pn6vlXBa1KrUfz4vSLrRv6KgyDnu6d6hADvpBPcJNBooi1t/frr/BlWT+Fs3hZlDUx1wz+eBo3kWfl16cY8txHRDHGSEGSGxmnOZOwkza5llJBBa2p3rnkVeLet6rTSE3JmhKrY8PyzDbkvQ9fG12Gb/KRB63N8qWTllXkxGwvKGUnvxJFLjfAH7cEtSoKn4z4wUFdi4TgoSQmocEnWWdKuTbP25wozpiv5r7BlFniF2r6bgQPL9HNbFFj3IiLG4p81AyCpldJOQNOCEtH5yjFjRRr1JwYaPgHQMjIbZCRxPv22m+9U6rYuAO/AGJ3dg+dIKjaYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVxWJERjNFzz/5MIonSTHDUFLoQo85KxGkXJ7PTIdVs=;
 b=Vu2j7MylXUebErO2B1T8JyPRY8AdSw0+79wntGghVRER3PWhmuaeplGU4zcok85RfxVrx1x6/7nDz/vYTDlxO7I+MHaVirDJ1IrNSc7pv+82bO1vG8HB1ej71k7f6wuH/eF6N/KTVmgXwHiLPXjwuaqGfsylURoWk2NejrklUg4=
Received: from MN2PR17CA0011.namprd17.prod.outlook.com (2603:10b6:208:15e::24)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 22:06:29 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::bb) by MN2PR17CA0011.outlook.office365.com
 (2603:10b6:208:15e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 22:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 22:06:29 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 17:06:27 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 2/8] Documentation/gpu: Add simple doc page for DCHUBBUB
Date: Fri, 20 Oct 2023 16:05:15 -0600
Message-ID: <20231020220549.493808-3-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|SA0PR12MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a97d3fc-7c0b-4363-ce3a-08dbd1b8cfb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fV7Anv5jmjg+dLYT9NgoJlL+3DiZ2tkaWWL7hu8lL14o8ReIwdvIoBsYiQ4hJ4l2VLxUNoJ09fzzJoILjxjJaJRXMTHf+R+y8ZHefJwHhIA9YfF6sc+sigsyo+NQmnP5HM3yapyb4IXunmBbCTiWeuWiBbBM9WNQtBWPqZP0LIg7QuaDfyhN5k72I1CM2SIyNV0nEJ3yqw2yeBlGSzc0F7FTUFbSjU8DebtTqh/VFQqc5R4GUYYlwPPHZVilmUF/62rrqbYvxoQyNkVYXxXsaerEq43NcDLYyGVykm/A9xnSEfdi4R9a96f83xMSjXYowIi8wOCxZ8A9Pw2nxQsGpthmxgyA/Vvxr4GASUUK0Cs0Dbm2a1tvtyZ9dtNAMHfvt4EqjWnsOMap6Na6Bq7Wi3+fRPkDeZXzUFKBFZ5LDltul7r5mvjZnb84wIXxPiJoaY2zLkuW7o52Dhl/d3okiJ6OETGqA4IE44hh9D5RnjVddSkC9RUz3mmENBDzK3IMEO3CmTeMWV/2WbWJMB/GCLpOhzxrZkHK2Ej7twJMuAhu68sfF9X7EHGEiEhxLjTaIvm+5mdgjFZul4YYc87iSodKYZHS71CCNmEpq7AMA6+uXNdoWQYSO3J0QgmUDmk7/6o12tWP4FOXl1diS4BsJ30RQjpr6JQayL4XXn8jKSbd06tgj0kXUcSr62N8zLSwP/TkIJN9k3f0nfdBPlTtsLqeukF1AuH3ewbEmubIsTetaHu+SjlUkH1VrpE9mns2tC2s8SRY46yg2UGAdrQFXh8eLK+xwOE+LIas9SIE8/M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(83380400001)(6666004)(16526019)(26005)(70206006)(70586007)(54906003)(110136005)(47076005)(82740400003)(2616005)(1076003)(356005)(81166007)(336012)(426003)(478600001)(316002)(36860700001)(4326008)(8676002)(8936002)(5660300002)(40460700003)(2906002)(41300700001)(36756003)(40480700001)(86362001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:06:29.1377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a97d3fc-7c0b-4363-ce3a-08dbd1b8cfb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
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

Enable the documentation to extract code documentation from dchubbub.h
file.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 Documentation/gpu/amdgpu/display/dcn-blocks.rst  | 12 ++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
index 5da34d5b73d8..e4e0a4ddca4e 100644
--- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -5,6 +5,18 @@ DCN Blocks
 In this section, you will find some extra details about some of the DCN blocks
 and the code documentation when it is automatically generated.
 
+DCHUBBUB
+--------
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+   :doc: overview
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+   :export:
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+   :internal:
+
 HUBP
 ----
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index cea05843990c..580a9f3f07c0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -26,6 +26,12 @@
 #ifndef __DAL_DCHUBBUB_H__
 #define __DAL_DCHUBBUB_H__
 
+/**
+ * DOC: overview
+ *
+ * There is only one common DCHUBBUB. It contains the common request and return
+ * blocks for the Data Fabric Interface that are not clock/power gated.
+ */
 
 enum dcc_control {
 	dcc_control__256_256_xxx,
-- 
2.42.0

