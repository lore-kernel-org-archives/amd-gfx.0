Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E66C4707B
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 03:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87BFD10E2ED;
	Tue,  9 Jan 2024 03:01:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6734710E2ED
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 03:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaKoCdkuMo95cmsezLHqHmzS7LCn9n2KvxE1taxsOhk+T0MCSgD0bMIt8+307OWCjpdbAQqJokplgp/GEUTYu2MMiIH9RueI0F4naYjM68/YqxJIR2uMvHoNCTkUhFoIIfbzw1dM0dLwUb8TsO3AfLIbto1SwTSESyVCnQn9sAd4VjVB8+7slhoKsfT5QbAifO232itNQF2gwaa0lcfhKJb2HubCKS5ZSos5v629J3aGzGeICXgTT1OwY1SQdzQWcsyIpWD/NHVf1eJ8hE4LKCvRjN7cjKa76aWzSIJNNE4artbNquzZuLwaBKQ1St8q72C+MwnZLIgw7zgq4CLqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRvoxDmLUDOT67HFMYQzGeUo+nofehzu8NI2ytVIR7w=;
 b=C5Oj+FXAAglKwMDVzoG4gP5ZKXnCjQi2mcu2ddaN2+eiGQAxy+ydCPDAFSzfpTdKmnwU6IoA45UKodXGDspyRl8CpfeMLN3W1vGgwUC5qbhO1dI07CvUj0lmLgqOwoW8W2N1uh1FYSKsfcbnRG1NWollkhIZnIAnFmTAYUm9pfhGWQTqj3guQmMuOh8HNS0aEFaZPd6jpm7NZUQaNJvvAeg+o3hJVcITLJmqNO65TqXRIAjRFe5GQCSONez+WBfSG1S4x6SzKN+IzEW/YmrG5NQaUgr6MfTQTqKSkXXuXzKijzYRanx5ps74kASW15QVI/Z8V2G+I8MU40KlJ2eMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRvoxDmLUDOT67HFMYQzGeUo+nofehzu8NI2ytVIR7w=;
 b=MdqTOnuV+hT6z/UObTgxGiY9mYb0IS5e6N4aP3VWKZg0VLM9IOXpdWc4zSSa442RVpUSSmdr/U5djjA7H1urz0RRmNloD/PGYrfY9HNww3wDW+dbglLPW2y6jm5WtJjVspAzMUiCARRT3wnHB/LgkZO2Od/X+MA+m2Nargl8khg=
Received: from DM6PR02CA0160.namprd02.prod.outlook.com (2603:10b6:5:332::27)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 03:01:31 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::84) by DM6PR02CA0160.outlook.office365.com
 (2603:10b6:5:332::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 03:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 03:01:31 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 21:01:29 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdgpu: update ATHUB_MISC_CNTL offset for nbio v3.3
Date: Tue, 9 Jan 2024 11:00:30 +0800
Message-ID: <20240109030030.1138707-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240109030030.1138707-1-yifan1.zhang@amd.com>
References: <20240109030030.1138707-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 1647c42a-67b3-4095-3ced-08dc10bf4831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OeD7XZkhfS8JxsO5443JhsohniDtxA+5mHgiqM8eZSxRGFENLYyRbm9pntt3ly+4C/K7BQjo/8O5akgBJrV+5mIapnA5/IWxADvBqvFOSS0lkISI/bSI96JE1MuZqD4TtVjk5NmGN/Ckjv9/OOsFFZvPqHM26FLTLn9i7BLO1SP+5Ks0LxYYGflmODu5YcYj/LLZlD04CipCdtYOqtLYNOZtel1tY/jvMjzDzYkoFy+qpVRVp0Fi3xs8ZwcBjKALmLWvfLYHeGSEAxNfK27lfNqbI6jxRxqK+/3jEjiY3IiCo4LzCL6ZOFy2/cEHH7k1DW2lQSqmZjQvmPi9cPLU995Mu9rupnu6UhlPZ1m6FmVbjiPHw154F3I+ClQmNifmw4NvTlVcXp6AFdwPLA/ij2S7Po+Zw3WHPRpAueeep9dc0WmJGKLDdd+4B1T9RKWFahnHO9u8P5HmHOS9IuB44nog39ipGbZMT5DhNJCCREFNeWKPppdXCPZMoPT5K5QjwNourYfKzYJscMP8XcLOLkX2hcl6/36MPevXdvaR9uvXweAndos+AjEv7I1LB6p6qwe9FLORw1mLJ/Y1vPx6Xc3l1dsdJsoHhSif1Kj9RbObblNzVryMOm4SCDmNDZqdwSy/w4srYO1hXWhU0UvHCkE1cAQyEYSMhvV496ZU08CUAIOoDLalIt01Mld+26L4FYFpEhtQDx4aWoWFCZG0KnTPxfXOnDUdCC0ysITF9oXcjrLdinMMgCTQq8aC5SGz2HFHCz0HZjs0mvue6KW3eA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(356005)(82740400003)(81166007)(36756003)(8676002)(8936002)(426003)(316002)(83380400001)(54906003)(5660300002)(336012)(16526019)(15650500001)(478600001)(6916009)(7696005)(4326008)(6666004)(1076003)(26005)(70206006)(70586007)(2616005)(41300700001)(2906002)(47076005)(36860700001)(40460700003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 03:01:31.4658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1647c42a-67b3-4095-3ced-08dc10bf4831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Lang.Yu@amd.com,
 Li.Ma@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch to update ATHUB_MISC_CNTL offset for nbio v3.3

v2: correct a type (Tim)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
index f0737fb3a999..d1bba9c64e16 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
@@ -30,6 +30,8 @@
 
 #define regATHUB_MISC_CNTL_V3_0_1			0x00d7
 #define regATHUB_MISC_CNTL_V3_0_1_BASE_IDX		0
+#define regATHUB_MISC_CNTL_V3_3_0			0x00d8
+#define regATHUB_MISC_CNTL_V3_3_0_BASE_IDX		0
 
 
 static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_device *adev)
@@ -40,6 +42,9 @@ static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_device *adev)
 	case IP_VERSION(3, 0, 1):
 		data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1);
 		break;
+	case IP_VERSION(3, 3, 0):
+		data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_3_0);
+		break;
 	default:
 		data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
 		break;
@@ -53,6 +58,9 @@ static void athub_v3_0_set_cg_cntl(struct amdgpu_device *adev, uint32_t data)
 	case IP_VERSION(3, 0, 1):
 		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1, data);
 		break;
+	case IP_VERSION(3, 3, 0):
+		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_3_0, data);
+		break;
 	default:
 		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL, data);
 		break;
-- 
2.37.3

