Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA548CCFA08
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 01:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6BE010E10E;
	Wed,  6 Sep 2023 01:55:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B9610E10E
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 01:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9xn+6PAke/KxO2LS5gBf7UyDD3towf2RMeWO3gqgF97nn4uO95WTZzm4Wm20yg7kNHFtIQxFbE3RMsCDCALUOGD1QYFBkwC/HyBKkEnVTJTQA8kTY068q0bcrQuhi/LFptsZYt9kO/hx9MVinFTL9T2RCfDOFK1ckzye6uqRBbwVqQayl8GsqCf0ic2HK2wj92QIsH6hcv/GvWewoNrE7PoGiEyKEmh1K2Ys5GmfVLFEkzWCVw2UWWN3liHwz4T9dFeg1ZMuiYtRsSHseBipadpXvyDLhB4XjtaE+sxCr6es+mJziJOa8PEYBSE55OtCFxUnEt2MZHibbPdbMfKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sy+nhmLEkFdULf0/Pok7bg9o4HORiFhbKkVQQcXrQG4=;
 b=eyrFAdNWic9C7/Q1ZLJBCStXuxwniN9O29Gxy+AoB2CSpbr20WGkAU1lHDfYeTiAz1vLBp8cduXaWhEXKHlP9v1B0TUh/hqSvi32R1w87sXbbW84AnVFSSR1q4HC2mb2K+s7IsCm6a0ACBXUHSkHF3fQWSTl2AHGKz0yBNlo+BUg6LTD9HiMCjr5ocALK9jtnyAs213hr+whzjeuxR/Qrvruvg1E6nevBIlGqX9Dag8VZN3S0SgU4xvVMZH59myGBjevK2FauyzF436XO01Hi6xGKrhDbK0hg+6KFXst5rzuIEHI7evOFwNI0Pdtl5qrpGaFGBY8xPBFdwXbZY5TuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy+nhmLEkFdULf0/Pok7bg9o4HORiFhbKkVQQcXrQG4=;
 b=CxuSOL5139GefJdYus0o4/EGN7ZnzLq0XtXzli8UHPpDsCDuN3Hq5bFl1N6tPnal35VejR1pdRXrwIymBWCk5nhQckRqdgWITUV5PxDL5rUNMVeseCwUxz+Vbcgw/CEOX2EzZbrdCFDU7VUWeTW3FGVctwPS6/UNYGpul+n/JhU=
Received: from CY5P221CA0080.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::28) by
 IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Wed, 6 Sep
 2023 01:55:41 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::72) by CY5P221CA0080.outlook.office365.com
 (2603:10b6:930:9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 01:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 01:55:40 +0000
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Sep
 2023 20:54:58 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] SWDEV-420310 - struct pm4_mes_runlist in amdgpu is conflict
 with spec struct pm4_mes_runlist is different with mes pm4 packet nv10 spec
 Modification: add last dword of the design of spec into struct
 pm4_mes_runlist
Date: Wed, 6 Sep 2023 09:54:15 +0800
Message-ID: <20230906015415.227847-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: e1986d67-33ff-4c81-609d-08dbae7c5f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/vdIIVsxB0vR0Js4hHmqt0e1ox04ULlYp0V10hE7GRfxt02hbK2sdwjSpoI5+ORf4cRcmZuMG+mxwe6kh4ZAUoovZZ8+gOvqt2YxpoXLzUWs4eYWMA0Q6jsQmX4c4Eo2Gv7RovGiYyS1wr1Gl862QhH1tO472HUtPhcG2VRhvCdnl6vKqF85iw6uV+U8kShHKFbZ9+zr8pNdYIYI9SeHu8Obeq1XKkjDwTHZrR6olMMkpmjz6BQkk2ehnvuE2ldTM0sFna/RdeSji/Eqnbq7EZ8L+HxYHoL0ivUSbCtq9z539ineTS+94BlNGd5mztcKlmXU2w2/uHvA6x2UQEmdICZH7+9MNUvmVsrGbuQgYixPa2tUMDp2MD+fbKFZDf+HH3AEkogTlG1SbxjKxALQT6xuBIo6y0AwKes2x2THLJI2MZDCxW33JCcnR+e19WUHmQhLw2uP64oxMpWg79PsEykiT6+wwrgA/MrfHTVL6gFlpKtN9Di8Ib8NCEQLrLzk3lFTdq6fbP+rgqvelw7LzwPf8Ut3lFdfXLXYdrO7Nrg3FhvGkcWN7b+/g53bUmHeaUxQK/RmX4Uj1raRKDA4kL0gQnrWeiBbQ3HikZhfeU4TlXZD4XZ+WUeCN06LqbrdE4wiaUKZ8yW/wJthqvBfRqkRWG3mzYRmW4KBATI2tPLdyf4ZaQ3aAgpMXz+CTMnanJhQNkS8SLE/HRlrhcpaz8Pe8f2yKBimehJfIA0r/7gB5+D5rSqWbmvJC1oqhbVQ4Fb8WWeqWILfMnFMLwLkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(36860700001)(40480700001)(82740400003)(81166007)(356005)(36756003)(5660300002)(40460700003)(41300700001)(47076005)(70586007)(426003)(336012)(2616005)(478600001)(26005)(70206006)(1076003)(6666004)(16526019)(8936002)(8676002)(6916009)(4326008)(7696005)(54906003)(2906002)(316002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 01:55:40.3389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1986d67-33ff-4c81-609d-08dbae7c5f80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
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
Cc: JingWen.Chen2@amd.com, Felix Kuehling <Felix.Kuehling@amd.com>,
 lincao12@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Lin.Cao <lincao12@amd.com>
Change-Id: I1322c010d1428b2c1df5080b72da94e90cf17fec
---
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
index 8b6b2bd5c148..d50feaf59b8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
@@ -129,6 +129,18 @@ struct pm4_mes_runlist {
 		uint32_t ordinal4;
 	};
 
+	union
+	{
+		struct
+		{
+			uint32_t level_1_static_queue_cnt:4;
+			uint32_t level_2_static_queue_cnt:4;
+			uint32_t level_3_static_queue_cnt:4;
+			uint32_t reserved4:20;
+		} bitfields5;
+		uint32_t ordinal5;
+	};
+
 };
 #endif
 
-- 
2.25.1

