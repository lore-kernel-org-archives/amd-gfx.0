Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EA2C46467
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 01:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F97010E488;
	Thu,  5 Jan 2023 01:04:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2592410E488
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 01:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC1Jlm00f4z2X0IwfKht3e6aFVpsm+8batB6Xw/c2pJMBR/nHq325DS/Hy/PwBiQj2csipDwvleRQgkxmkwvC25Wx04XeGNVTS6SMUE9dz5EC1pgSQxSmCBiiLv0lnW8UkxQflMY4NvIjz2q3ZptTZR4yOaFsahVWkucPyfhrvwqvGGYoZe2boWhLxpR38U9GiG5zQ4atnq55ZOAIadMuL5OCTgwjiybUUKWBp4S5ieiE/8N+5x0kp2+3nbscrp9nytqeJ20nISrGk7RA5db2jXUetnyKllfh44LjdJi21LD6St0ZW6c+S1wVcv9K8oyef6S3kSDLgKqy0tdXD+VmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9rmzy7FGgz//Ddb4BqJKP70q0XQ1/9swzRcr5vsAx0=;
 b=LcLFmQTfA7a+MbtHu8SfU0vfXIOARJ8ejqI06lHhX3tKH74bZCzzgBNrFtAgShrn3nF2VVY3WHapQWOB9HCb6PZW8dxQewFKmoZSqBI2nimFcKlppwl3jnJJLri1h5oObtCVlOokFCVdv2tyUNDBzkciYIntEZ5sVPyk0spKr9eswpwQwTFv/swm0T2bpMNHWXb7hHIyaRvwNr4e5DW2UX8gN9Q2rLmODXFFiY6T4elTmM5hYo1dDKoHndOZc+cHzd1eoaFGYneZx7YeVAPz71SSjM11BM6TCqcLBbejkc30aoY6rlSmt1/TnLn2naFneZSy+OT8n4/6UR2MRXelvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9rmzy7FGgz//Ddb4BqJKP70q0XQ1/9swzRcr5vsAx0=;
 b=JBO+UtL1fHM9OaHFMw1otlbc1Us/PyLuOBwyUy5larQmoi/Zy/Nt+9TdcqDuUeL5qYty2XuOWGjBpkJqTxZ4UTW0EKJ4LRCqMJ7jxNWFtjBQsbWFHTt3H9K+tj1KB3XRoUPF0cTUxkoCsDPT3nKX2IwMRk6kryEiMFSQY8FeUhY=
Received: from MW4PR04CA0275.namprd04.prod.outlook.com (2603:10b6:303:89::10)
 by IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 01:04:30 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::57) by MW4PR04CA0275.outlook.office365.com
 (2603:10b6:303:89::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 01:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Thu, 5 Jan 2023 01:04:29 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 19:04:27 -0600
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: update ta_secureDisplay_if.h to v27.00.00.08
Date: Thu, 5 Jan 2023 09:04:00 +0800
Message-ID: <20230105010401.2216819-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe662b4-98f1-4367-2564-08daeeb8cca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z53k2lJeqS6pKgGV1aIFpW8SD6qFUJGkH3lD0NYi3kFtvurOQIf7nojGZMsxdpQXokoMXkTr+cDJSz7H0vRphrnpL31xZVRW+3BSX9zmRgAGXcWAp7BvWLNMskcAkK3m0W8Epf5SqLa1pCnUO9HYdpg7k/oyyNV25MoUjN8F7nRR3Q3lJ7oGvNZnLeURCPgtZIc4AHgcGUJW0Kx0SZhEDUQQNLLQy4at5oBgnGACQws9lI7B5BLG01Jtn59YqKXtyhkWasqbRpf/ESWEx1K4bzH4u4IOC7JDK9p9jh3auc917q3IAjsT0b9SaRxzD3kXnONCO1RcP68G90rG1/2N9DyQmKJ0MV75RdLII57ypkzKfb1NSA1MoRm8LMZbYg4XWCOHXFA0BJiekQaDGxk4yKFayTwzcKR671qT56DVJMERHbho6qd3XtlRPICNdX/2hl4jDXPaCenDOqBIs1OwhR+WuiW8PqGAbA9AUs3hKlt93UfET5wu6SGghTev+KxgAUgFuaDA1OigDZIpW9pcGTPfO6HZ87Wd+G0A3dl7PgsS1NKKpu2FozqHEO1WV+YpjTUrZARHOJdfooL0Xk+fsltTQNmV/2LInNzF+HPjy1koEvDtEjLEkc92ufYxuBJMayGsgv7k/hlHLgnnFsSDmfkp6HAiM6ud24bMFZ/fbmpyh0/d3Km2Qijd2FamopVymbl94ypcYcGnA2Nc0vvow2yKCaO4CGi0QM6LpUoT29Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(16526019)(44832011)(478600001)(82740400003)(40480700001)(5660300002)(36756003)(40460700003)(2616005)(1076003)(8936002)(47076005)(70206006)(41300700001)(70586007)(4326008)(426003)(356005)(8676002)(336012)(6666004)(83380400001)(82310400005)(7696005)(81166007)(6916009)(316002)(26005)(54906003)(186003)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 01:04:29.9068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe662b4-98f1-4367-2564-08daeeb8cca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080
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
Cc: haoping.liu@amd.com, Alexander.Deucher@amd.com, shane.xiao@amd.com,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Rename securedisplay_cmd to ta_securedisplay_cmd.
2. Rename ta_securedisplay_max_phy to ta_securedisplay_phy_ID.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 .../gpu/drm/amd/amdgpu/ta_secureDisplay_if.h  | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
index cf8ff064dc72..00d8bdb8254f 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
@@ -55,10 +55,10 @@ enum ta_securedisplay_status {
 	TA_SECUREDISPLAY_STATUS__MAX                     = 0x7FFFFFFF,/* Maximum Value for status*/
 };
 
-/** @enum ta_securedisplay_max_phy
+/** @enum ta_securedisplay_phy_ID
  *    Physical ID number to use for reading corresponding DIO Scratch register for ROI
  */
-enum  ta_securedisplay_max_phy {
+enum  ta_securedisplay_phy_ID {
 	TA_SECUREDISPLAY_PHY0                           = 0,
 	TA_SECUREDISPLAY_PHY1                           = 1,
 	TA_SECUREDISPLAY_PHY2                           = 2,
@@ -139,16 +139,16 @@ union ta_securedisplay_cmd_output {
 	uint32_t                                           reserved[4];
 };
 
-/** @struct securedisplay_cmd
- *    Secure Display Command which is shared buffer memory
- */
-struct securedisplay_cmd {
-	uint32_t                             cmd_id;                    /* +0  Bytes Command ID */
-	enum ta_securedisplay_status         status;     /* +4  Bytes Status of Secure Display TA */
-	uint32_t                             reserved[2];               /* +8  Bytes Reserved */
-	union ta_securedisplay_cmd_input     securedisplay_in_message;  /* +16 Bytes Input Buffer */
-	union ta_securedisplay_cmd_output    securedisplay_out_message;/* +32 Bytes Output Buffer */
-	/**@note Total 48 Bytes */
+/** @struct ta_securedisplay_cmd
+*    Secure display command which is shared buffer memory
+*/
+struct ta_securedisplay_cmd {
+    uint32_t                                           cmd_id;                         /**< +0  Bytes Command ID */
+    enum ta_securedisplay_status                       status;                         /**< +4  Bytes Status code returned by the secure display TA */
+    uint32_t                                           reserved[2];                    /**< +8  Bytes Reserved */
+    union ta_securedisplay_cmd_input                   securedisplay_in_message;       /**< +16 Bytes Command input buffer */
+    union ta_securedisplay_cmd_output                  securedisplay_out_message;      /**< +32 Bytes Command output buffer */
+    /**@note Total 48 Bytes */
 };
 
 #endif   //_TA_SECUREDISPLAY_IF_H
-- 
2.39.0

