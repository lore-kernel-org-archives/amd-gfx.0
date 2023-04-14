Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1569C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8950D10EDE0;
	Fri, 14 Apr 2023 15:55:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C2110EDE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW9UOLATR0aM3Tb/ECt/NL2lNH3MBrf3akUy8hwJRuZbccrZDb6hPTqJQNaNZwW1R7W5FEtYkPnkCHMoGN3sR3F9eAFfhDijwVR2ZM+nGJYoj117JT0ue5ztL92Nam9UGbCh96htLtpO3kIkR27DBQOCCWoh/ar0BQyzSzm2xazKBjex2bKhQbdCKW6/QVJ+aGXS7MS9wd+F1tHRZxGPYopNJ4qrdmre7l1316uAS5PPbIl5Y1kcnppIWmdf0hJLHrCoU/ckaCaFq/mIZid6Jq9B8irdWtyNosucXfWJn8geL3Rrgz2IRLDGdYoE+RKMOy4Be40IyudUcGiCfgaxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms78Cr21ELiOgKsBLRxaOcWUwV/x7IcTK3cQt/bK5vo=;
 b=Uro5tDuOWCPBoCBibQEv5pP8E9ta1wlzgoVT0WtbxqjY4WAnsbcQKYGcxpnO94TrwQSTQYzuuRe5UsEKPS59KTH0lVtKxYZ5ztoQr/CnAaVUod1YooIxqnPgPKXTDGjd80EQGf9faXaagk71tPzNWJ1pYFJyX7UzRlKDXy/pEN2AujHycJuALp01kGFO6c26lxIRfAOUk2X+5+a8dviwDZ+wTyT5UyONpSEQiIOb0VTMmGOXwyLWEjTnk0LMScnVJmH1KKztdpuH76T9Ur1spucLIMekdjTMPz6nqc1WES8TXdnps7dGFhRk3ecadynFWLnvuHoWGdtUnNosZwv7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms78Cr21ELiOgKsBLRxaOcWUwV/x7IcTK3cQt/bK5vo=;
 b=CVoegE672+e07b+91ImYJQvR1D/azaZ1RgdN2tGEMvszPRXXOq0vwedbISW+HJzLUlB30qw9Pf3a4epUTn1+5BkMYy+CJc2fVdgakvUqKMtpXM0EJmUx0c03pJOGtUCYygpeS0qGbu12BOdD9c9t7gfS0gdS0kcfLPZrPb8UiIA=
Received: from BN9PR03CA0431.namprd03.prod.outlook.com (2603:10b6:408:113::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Fri, 14 Apr
 2023 15:55:02 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::f4) by BN9PR03CA0431.outlook.office365.com
 (2603:10b6:408:113::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:55:02 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:00 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 49/66] drm/amd/display: add support for low bpc
Date: Fri, 14 Apr 2023 11:53:13 -0400
Message-ID: <20230414155330.5215-50-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: dc174676-3b3b-4605-ed02-08db3d009bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yu3qhOLWsciLyjn8S+sw1HwqZShbe7AUd1hT05UderZk29cZEfnzIZBmJxBN0BXYowJBUYuXQ9T7gb4QLOnlx5zBvuWIHOd5LCI0QVnVWHwz+VZ3Rt2mYDgUzDT7wxDlmPaQRz4OH8Jrj53gyADsjXoxZ6jLkKZZOe3CibF61pZ7iT287XgSdHW2pF03YCGo9A6ps/0OWQMC6TkokGD/aS5Gs83wQMwT/daQi9rY/3LT5QbzDDEQxNY7T75M2OZ6sEabUKC1g4T859q6GEIloEa9pq2TvQDYZLH0jQBnNhwv5JuGSxjPNemK2hoEwcuEduXyXYx6bZmYygkZfcqvmboOi0JdjF6XreAbJlDqxIbedVGmGN8uR2pR8mASjqppagMvHTAposz4hB/JtGqQEO+md62938/folk6uPpOU/qlJL4bPLUn6jBtuQzI8pZ+k/50EnEToHX3Brx/xpSwqT3tKbY5wJQHm1OfYDQ5xGNSlvndvx484gk6Zg4X6IH0o1w8YuUtuLQdfInsbWa0+0tk35ZHG6J8bsxK2M8jVtXfwq/UIBri1mIZKpjsRyPZWWQQXJOcu3aYGkvYfzO6IxJMRuQ+TcKxFK2lL4nNWSTsdestoPAosMZqsDFai0wZvzbe9z2vM1aR4GapqifHfBolguIrvNo9v0k/k+AYRC6MeDuZC7hbvIGxNWD9MISacvefeyhGWWbelM/JEU6Ca5oe77ydPT3I0knvSUopvjc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(70206006)(6916009)(40460700003)(36860700001)(82740400003)(478600001)(41300700001)(8676002)(70586007)(356005)(316002)(8936002)(26005)(54906003)(4326008)(81166007)(5660300002)(426003)(2616005)(47076005)(16526019)(336012)(83380400001)(186003)(1076003)(6666004)(82310400005)(36756003)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:02.3774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc174676-3b3b-4605-ed02-08db3d009bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[WHY&HOW]
Low bpc timings are failing validation, port a patch to allow them to pass.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_util_32.c        | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 61cc4904ade4..cad2bc3aea67 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1595,7 +1595,6 @@ double dml32_TruncToValidBPP(
 	unsigned int   NonDSCBPP0;
 	unsigned int   NonDSCBPP1;
 	unsigned int   NonDSCBPP2;
-	unsigned int   NonDSCBPP3;
 
 	if (Format == dm_420) {
 		NonDSCBPP0 = 12;
@@ -1604,10 +1603,9 @@ double dml32_TruncToValidBPP(
 		MinDSCBPP = 6;
 		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1 / 16;
 	} else if (Format == dm_444) {
-		NonDSCBPP0 = 18;
-		NonDSCBPP1 = 24;
-		NonDSCBPP2 = 30;
-		NonDSCBPP3 = 36;
+		NonDSCBPP0 = 24;
+		NonDSCBPP1 = 30;
+		NonDSCBPP2 = 36;
 		MinDSCBPP = 8;
 		MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16;
 	} else {
@@ -1661,9 +1659,7 @@ double dml32_TruncToValidBPP(
 			else
 				return dml_floor(16.0 * MaxLinkBPP, 1.0) / 16.0;
 		} else {
-			if (MaxLinkBPP >= NonDSCBPP3)
-				return NonDSCBPP3;
-			else if (MaxLinkBPP >= NonDSCBPP2)
+			if (MaxLinkBPP >= NonDSCBPP2)
 				return NonDSCBPP2;
 			else if (MaxLinkBPP >= NonDSCBPP1)
 				return NonDSCBPP1;
@@ -1674,7 +1670,7 @@ double dml32_TruncToValidBPP(
 		}
 	} else {
 		if (!((DSCEnable == false && (DesiredBPP == NonDSCBPP2 || DesiredBPP == NonDSCBPP1 ||
-				DesiredBPP == NonDSCBPP0 || DesiredBPP == NonDSCBPP3)) ||
+				DesiredBPP <= NonDSCBPP0)) ||
 				(DSCEnable && DesiredBPP >= MinDSCBPP && DesiredBPP <= MaxDSCBPP)))
 			return BPP_INVALID;
 		else
-- 
2.34.1

