Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAACBC4829B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A8510F7F8;
	Tue,  6 Feb 2024 15:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gs7DiRAY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538AB112CB1
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsO/4wLz5/F9qW0KzrNAixp7CZ9rm9akZ0kHgUJUCLyPEQC5mNQadgwqzafK8hJsgBsNJl4PB+UzMFN8rO+CuP0ql1LnGu7CVLZHzWzZ+K5y9E1fiAOaTJGQCHWvc+4ZAOFObGh3UQH81W51mxmjiAgTUViz2bk3sMo98Pz1txDREuS7jLHt06KdVbcyRTCxaj5Kfq7SU6czo4/NlAwhpU5WO0XWIAmjjuxhQ9GI475TQl8EvS3uH9j6ye3obgyJOoxm9ejzbsKm5d2gOK8F8vQVakmtSJpg7rgtbZMrsDGEEIkCAVHhyutU07aIFk5+tOl5vnV9C2Q5yG3Hg9+gKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jfl2vUeibhniwLpEBhMIiwVJVQXO8mC4XBNCadZ8Ww=;
 b=TqtopmRrXaUyciS5fYgdfMfMJLy8j+hwnCiamrCxj3yKM2HYLxvFrS99Zufj911r5P5zWE0/C6j7tLroUlOGtI1wSF0ptSx4sM3t+lYxP72bW4vnFu/Sio1Y8uy/OCQHo00z3Kaxi+7T03RL2CO5hf+x1pcQSumLkEzn7CoqyGmsEU6pK8wxKx57U4irwciFZSr/O9p5SWgZzIa8TVqqueXb2koP5nEyjn6plYsufFVqb6vdSrNBgKasRfL2eoi3XR7Vu+DTcyXzIHeYaooq7xE0S6FiA+GQKa8iUYzEm1tImWtseOqV9s101hXzwZu1CVKycE4gvR3qVmycKN2W4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jfl2vUeibhniwLpEBhMIiwVJVQXO8mC4XBNCadZ8Ww=;
 b=Gs7DiRAY1ZBNLBfHGEZi+EwPJDTTSHUffQYJ+EMjdfqE41Zp18WHZuB/YrsCFrDp6JOiTHMnqY18p2UEnu9osYpH205bRYnMtZ9Cfe5Yqk3xtKT3KJ6G6X4kTj6znHOXA9oaIgVSsfYcVBCWL3RycXxemOW0PHLWDFJhlIPpUuE=
Received: from SJ0PR03CA0216.namprd03.prod.outlook.com (2603:10b6:a03:39f::11)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 15:59:46 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::2c) by SJ0PR03CA0216.outlook.office365.com
 (2603:10b6:a03:39f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:45 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:42 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 24/24] drm/amdkfd: bump kfd ioctl minor version for pc
 sampling availability
Date: Tue, 6 Feb 2024 10:59:20 -0500
Message-ID: <20240206155920.3171418-25-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe9aa9d-f826-48ec-6e74-08dc272ca3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9cl2Eudb/iui+6ba8tCRORGonsANZgXJTMQAeU8xgIgAsvxKEapuYu4D/AroKfIRAsHNV9ljKPeFM8BvolKIrxiAnnsGxH7qe+hBKO06Cmt2hjKZovvBxFC6c9kWUV9utWx5jWNt4WJFDGWXHw9nUrugWj9/RBeasPT/7gEOwdu+RHbb7zpEmb9fl/eGxCeKvPnvWA8ii4D4n13Jaqg4C8dmqmLHgYgiM+tZER511Q/cRBdmsCXX8Q2MKm8vhVShwDBaLt25nwwWqCiMcB30lxjVyu+qixJAZS+VJJij+pO+60L1go31noeIQ5Z0uufIudnjMJm/Te94R6/QkChq2wkg1yK9zdovWltxIi/8baAP3T30fM+oGEX53X8ZLClZaskBzdXTt+FiFkpWlGyGFnnH7DUIVY78kAzc8ha8vyO5SH537DvPfE03GajAW7Xg16AP+6eKvKuT4FSY1OGaCJjCznDSkPaO1DRI35ib2UKb9Qnuhadmsrdw24hJcZTMXZuySHkheLJFbC5Rlfumdz+JN4oVUO9F7fiR2W3x5I9LpBKGowvlptkA15ymwUjtw/gRbWqF5DUJVvVElE+Zload4+Ed4CTx0IDbX/oFrKwp/WH1Q6kjzUmgd3LVRmmtUwRSKdM5ONKo/vehPMGCWqpGSlKRQWh09RPVvbyQluPSA95fV2muVBLEU2LS9v6REI5TzQa00WXdsb6xbQxtXa0bcmTIsQLOajQGdldSg+i8K/SyQObGZHN1h1w9EabMFAqzh+9BC/YKF9TDOOAlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(86362001)(26005)(478600001)(336012)(426003)(16526019)(7696005)(36860700001)(356005)(47076005)(1076003)(2616005)(40480700001)(83380400001)(81166007)(6666004)(82740400003)(40460700003)(316002)(54906003)(70586007)(4326008)(41300700001)(5660300002)(4744005)(2906002)(8676002)(70206006)(36756003)(6916009)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:45.9104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe9aa9d-f826-48ec-6e74-08dc272ca3d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Bump the minor version to declare pc sampling feature is now
available.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index ec1b6404b185..7c2c867b57e8 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -41,9 +41,10 @@
  * - 1.13 - Add debugger API
  * - 1.14 - Update kfd_event_data
  * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
+ * - 1.16 - Add PC Sampling ioctl
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 15
+#define KFD_IOCTL_MINOR_VERSION 16
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.25.1

