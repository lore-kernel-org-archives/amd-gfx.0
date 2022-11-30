Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2546DC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 15:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D82910E492;
	Wed, 30 Nov 2022 15:46:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A442210E492
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 15:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXJNj3RJEs6+nchqxCuVrVnolgoAVGukWHdaUCXbGTqU8di96kLioQnq/nLu4OKpci+CeYyBoF9U7BmTXW/A6VAh5L41Hznrq2Mezo9ix3Wl6JSIDQRaPSWmn70xhvkzepKF9JmeU3MSm2737mJ4WL57d35rQK2IQOMmTuJnsHEuGSd9JBF8OjiDtZao8uhWUAasHcPLwtA4A+i8osgxeElEuGRJaXplU3RUMSeBnJTsTSIRdFbdS5iHrIHPsInM2ZqZ5KDCCThwjbPPhEeMEE12ZM6EG/sw8X3TLKUqRdyjRNPxLmpFso3PK+D9Bij89gZE2Q152RO20symjYH43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkOy99M5nMFSoJ/FC6IvjxEspX41Q4PXTMOSyTDo/3I=;
 b=LvcrgWz/Fq2lF0xQqM4PlYpAg4eWJgxW/pbNzX9YXsztgrOOCXdqMObV8DFtFnOe8jVmCyF3ufgVzQVyZeITDZQqikZmV4ZXFjABNbQhTPhSt0IfH2iFoMc4HSOqhCWtz8WeaDfApQ50hJ2mIgjjdGgCfan/lFWmfTHpkXKHGgpp5kCNAkp8N4UgDCXTWkNbrgNVcNeuJHCDuJO3qjVc2XyPWYti0yuBTeu/hi6+ovT1TPwu/InPIjQukrCFc7R9DybTaM+v6Y70MOAxQwE7sQ8LEls6qyLjPCccd26Mh9ld79YD4RoG1O0I/RBweIT9ZmBlp2tfKPjpFoy2s7JxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkOy99M5nMFSoJ/FC6IvjxEspX41Q4PXTMOSyTDo/3I=;
 b=egfIc4pn34rTc78HTr/n0pxEN87EC33hSxoIX4I06yxmP06mHdJp3KaZbMQ5LuTk6unQtfBPT7ScBfU126XtR3VZnMezF4OOzHjOFchTHrIPYlxshHpTOB1eyYEo0cG2ifMgS3/URHi47ntkvA8Y1RaYJHMNQuuu6LzZOmtzbUI=
Received: from DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17) by
 DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.6; Wed, 30 Nov 2022 15:46:46 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::2c) by DM6PR01CA0012.outlook.office365.com
 (2603:10b6:5:296::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Wed, 30 Nov 2022 15:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 30 Nov 2022 15:46:45 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 09:46:45 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: Tom StDenis <tom.stdenis@amd.com>
Subject: [PATCH] umr: Fix a couple of options in the help output
Date: Wed, 30 Nov 2022 10:46:20 -0500
Message-ID: <20221130154620.25281-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 756c0fb2-6ff3-48ef-9e13-08dad2ea160a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Pyynu0qmAXWEvpE2Y66AQqi3G2OcbJaVWiGLuoKB3I0zxIzZCG8wOC+G6AM/4t3XZuaPXh+fv6XfqVnyI6QpRDbaEFBwT7Zjn+hFkd6rfsxEvBPqA1SlCWOXZjDEkMggYnZgjUFUZSVUlrgw1d9Q6HjCmx2suia9+zOYafcN58JO8L/hvXA6o418aWxyog9pFfqk3LH7Q/ZtvoEwFUoo+tTtvQEN79ueoQXhCVNRjR2FZKPuxcMMOIgE1ivlXuR5IQTQPXwJPTbL9PCSlg1ZtDM81RbpAN0Rll3V3XBfZ6iUNjEFTDZ1Ggl+ZzWX1QqgV7Vtip8UfEEVsOEuvnif6MKM6AmtVSXxY3bQEA7XyzUrcygDDS5Fba7bNUGscRWCL4889Ob2wN9QKSOUYMIEctLMHPk0WU6DJ2A2oNxaR+xbLfzntaoexdUBKL8DVni9T8ZI1l5iLrtUeL1H6Ru8+25hKJihSMRH6xcuyXwC0opZGuHHCoTumiZ+Txym9qbtI7MyS2t3QfOdRIKcL4iNvOjR8cEwbg7L4fjdzU4dtuCUdmGJkDLv3iTNyXwpH2QRjfSwxSgmf4e1FkdVOsb3pqJJmPGN8V3PdM0m9/S8e3+4VahnRer3gsE2MiqhHvRKbdehPcPDS7tVjB20JKnOX9NLb4TcIfdoJtVztcVlZ34M7cIyBqgk+vS3er3fhnL6YDnYnP/rcZkfGKDvPUKw0UWnLC5w6hoI5HvMqTM9Kk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(426003)(47076005)(36860700001)(83380400001)(82740400003)(41300700001)(356005)(81166007)(44832011)(40460700003)(2906002)(336012)(6862004)(82310400005)(6666004)(5660300002)(7696005)(8936002)(1076003)(4326008)(26005)(40480700001)(16526019)(186003)(70206006)(6636002)(2616005)(37006003)(70586007)(316002)(478600001)(8676002)(54906003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 15:46:45.9540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 756c0fb2-6ff3-48ef-9e13-08dad2ea160a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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
Cc: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The man page was updated in the listed changes below, but the help output was
forgotten.

Cc: Tom StDenis <tom.stdenis@amd.com>
Fixes: 04393f2a68fd88 ("umr: Add support for "--ppt-read"")
Fixes: dc5efe99e19028 ("umr: Add command line support for "--gpu-metrics"")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 src/app/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/app/main.c b/src/app/main.c
index aa2152f977367e..adcbcb17fcd0ef 100644
--- a/src/app/main.c
+++ b/src/app/main.c
@@ -1065,9 +1065,9 @@ printf(
 "\n\t--clock-high, -ch\n\t\tSet power_dpm_force_performance_level to high.\n"
 "\n\t--clock-low, -cl\n\t\tSet power_dpm_force_performance_level to low.\n"
 "\n\t--clock-auto, -ca\n\t\tSet power_dpm_force_performance_level to auto.\n"
-"\n\t--ppt_read, -pptr [ppt_field_name]\n\t\tRead powerplay table value and print it to stdout."
+"\n\t--ppt-read, -pptr [ppt_field_name]\n\t\tRead powerplay table value and print it to stdout."
 	"\n\t\tThis command will print all the powerplay table information or the corresponding string in powerplay table.\n"
-"\n\t--gpu_metrics, -gm"
+"\n\t--gpu-metrics, -gm"
 	"\n\t\tPrint the GPU metrics table for the device."
 "\n\t--power, -p \n\t\tRead the conetent of clocks, temperature, gpu loading at runtime"
 	"\n\t\toptions 'use_colour' to colourize output \n"

base-commit: 0fd552b95b5ccca7f28b5e767d830b47037a5acd
-- 
2.39.0.rc0

