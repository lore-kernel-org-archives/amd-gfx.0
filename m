Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDD9E8FDD1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 07:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE8F10E340;
	Wed,  4 Oct 2023 07:40:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B085E10E340
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 07:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVfvGcMuGOP3a316rmyecrMROd4HIAu16RxOcqoyUfsYyeh7cWyc6fBiqH2MmKrrss3TqJvwj+YrHmPfLk3xUHKiwsUsJ03yDbRRxVA4hildzSwH+bxAxvzixDvKMm0kKJmUCYeMmYYEmBgbbQVIMh3CeoLjKFrOr1BlFm2aU2BHaI8/iF6Sx3eCKvRi6CtEJLBv5BgDWeDADqQYWl/yokFkJ5W4QtcWOF2fJPzQzonfkpDkJc5kam6rqhSzoTw7Ow/eJ2lS3MeNHfQsPcy9EBTZJEvl5EA/bXfNn8bpDXqbpBFGuFD5LHhhNl+UGcj0l9si3UoY66eNtq0Izw3HwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJmwWGRCsY7cVCuBK4iTYvTNwsUUTbS6IyPAmX0VgJ0=;
 b=fx8e16p3OmBdAVcGoRh56Fk+HXE5ctvC3harTUci7EDlxLHog3Kmq0HIFn/tsg8i/0/cpxnapPfny9+lrZ73drvQLUegKzHzTCvAPzvuaPfMSTYyw+kY6WBxFVoCTdr2mCSDoPt5uyP+2HTx5st+veDWZoBNANdYQ+w0D8d7SH4h+vLyVz5LGNSXyurYrfG7XJVqRTrRzIdyaw5Uq0Rdqz/ulB45luitv2gXRpbo8oQ4oc/nmjbmLV5T0RCdeuRjGXNrGXLJsySiLLsYz/YJsMLe1XCTtJ9Hm/15yWVgkEiypgX/45jLNmmnzdxkwBEm4AXatNqMkvSmW8aLEn9YMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJmwWGRCsY7cVCuBK4iTYvTNwsUUTbS6IyPAmX0VgJ0=;
 b=trBuekf2RpkJ2C7hiKqJ9tvv5/u+RYKydSFnlABqDBCT5i8ooxuqOirZ96dZqXvV8+qB9377w/h4Xd8kdY00wI+BJqNhdqPRu+qBS/BJiI+KqxmmnYgW9Pe+h3w2A0bAhE1uhsbkm33LEX/N7u6d6DAS+X2ozhOv+UTXF5LYXOY=
Received: from DM6PR11CA0010.namprd11.prod.outlook.com (2603:10b6:5:190::23)
 by BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 07:40:07 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::ea) by DM6PR11CA0010.outlook.office365.com
 (2603:10b6:5:190::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 07:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 07:40:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:40:05 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/5] Documentation/amdgpu: Add board info details
Date: Wed, 4 Oct 2023 13:09:41 +0530
Message-ID: <20231004073941.1489693-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004073941.1489693-1-lijo.lazar@amd.com>
References: <20231004073941.1489693-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|BL1PR12MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 322f1aaf-5c32-44b7-00f2-08dbc4ad2174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypLws/gyGIsYAiYGuBqYWCIMIkSX7IKGhLwPkweehdiuwdW+IlQegSVA5PsDNawsJibDOYCYyoTdea1VPQeu6MYgyLM/Bz0wpaHLwG/9Si6yXCW3z35aW8OGxbfhnMVOl9W6T4TUBACpD/Rv6mx2COO8fU6UEjOguAOg+DZB2bAYQdzp4ZYQrEIUHYurWZTHHMEk9rZ3vRpX60DNznYcxJHmNFFOUWCUlmMI2+2L+0JTdEclM4IBvoBaiPNHE+iLiukQxUf12hB9uLMTN/dnZGlw+qfX0vx/pbC+RivsyADiD/WvEcxcEFGh45r4f04v06UA2LKw8RxjKEYYp8v36xK+D//tyZ7xjwyeQmjMugTnBEUPdaFPzXr/j27u4Zu2dEGSLu0WxAS0N9mGGfvfMG3cKDvj2Pi705k3YjTHjKupAWdOPbRuwP+TOFR+fp3wucmIMYKergePcoPeAqSn6hAuVfRr0jwX973GzyidfsBe5h5tXJUFc0j97lQjQPH9EBJ2R8bGoPh2NSDjOUba0ToW1mikvzpKXrKurN3P+S7oN11ks5iuhDrOGPHfHnCkCysmvZUiwT0dmSZ4zhUCucITfPkgzYFhggOqRY5RLg31dbxgrhXu9CXFXNZrW06okJxKJuP06UXWM5BcEfTo5S+y14leIW3RXqn8EYbVaFpSxkKWPzE6u/+cW/JVlNoxr6/p6slepZ6TOvQg97a/s0QGrDnb1X6QTnbsncjM41KnXvg2GyOFnERHiH8D9F80h9jdePkyT7ltBSuVulM1uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(7696005)(2616005)(6666004)(478600001)(2906002)(336012)(426003)(16526019)(26005)(1076003)(70206006)(41300700001)(316002)(70586007)(6916009)(44832011)(5660300002)(8936002)(4326008)(8676002)(36756003)(54906003)(36860700001)(86362001)(47076005)(81166007)(82740400003)(356005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:40:07.1911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 322f1aaf-5c32-44b7-00f2-08dbc4ad2174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add documentation for board info sysfs attribute.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/driver-misc.rst   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/amdgpu/driver-misc.rst
index 4321c38fef21..82b47f1818ac 100644
--- a/Documentation/gpu/amdgpu/driver-misc.rst
+++ b/Documentation/gpu/amdgpu/driver-misc.rst
@@ -32,6 +32,12 @@ unique_id
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: unique_id
 
+board_info
+----------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+   :doc: board_info
+
 Accelerated Processing Units (APU) Info
 ---------------------------------------
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 10f1641aede9..27c95bb02411 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -162,6 +162,22 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
 static DEVICE_ATTR(pcie_replay_count, 0444,
 		amdgpu_device_get_pcie_replay_count, NULL);
 
+/**
+ * DOC: board_info
+ *
+ * The amdgpu driver provides a sysfs API for giving board related information.
+ * It provides the form factor information in the format
+ *
+ *   type : form factor
+ *
+ * Possible form factor values
+ *
+ * - "cem"		- PCIE CEM card
+ * - "oam"		- Open Compute Accelerator Module
+ * - "unknown"	- Not known
+ *
+ */
+
 static ssize_t amdgpu_device_get_board_info(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
-- 
2.25.1

