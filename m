Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5173EC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A9010E6EE;
	Wed, 13 Dec 2023 06:13:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69EF610E6EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mj7Sgv395IOTNy6pncHPHGQ2YJQn9CjNegGx2w7OYGh3mBjAQY7JX8QX4WKoKt7EW++ZaukkXSO5ZgIn788xvjfEDJtcjbwhgsb2raOet+hArSF/H4MioK+PDKGaRP0jhhL0WDtaCIFr8kRFHf00k2Ku6GOe/wTRM+Ejl9fsRe4sFctdjuAC12Lpfj79ByJFBduEq3riyoA0hlRZguhV2oItSe7aMJBLuh5+w8q+UPWjtWhr/tlhWEU/p79q0DtIT1MNdjBEHWCrgtqhLz+Va/kkOKnUn5yNrqshH6IvCOCcQDtNZucjXpaFw8kJ49LnL67SHhMAWufJR/eXY6nx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX03RBH6HTvUrImHb+PuAtV50PEoaK64ifXYLnOn66M=;
 b=caLoTKaCyXKIB66NQfj7o9KN3EAy/2omUcb1XL5Y/CONpyD6lXXdeY34+oQ1o/E3Fn+aXIImkfvwPKFjBovUYQnoc94Jenonkq/SWtUrrnNnncl5gdUXNSGyLkstg/iaVXWKH3f3EWvNZPRuwcnn1/470E81s9DZiFbZJl0gwSXhNQ7HipDq3PsjXJZzufxdzUXjmwOH/uS/FUnpDAkO+ASdlI/3UF/nZ6z3A29kN3oIW3XXF+zahx+ibb1kKtej6vLVFiYNUXaGdlR5h1+wDCBJWLZSyLjxCfDh2YATZjDg/SZeI1exZTSxjkACM8krpa+2bNrFKfNdRgz0ct2uKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX03RBH6HTvUrImHb+PuAtV50PEoaK64ifXYLnOn66M=;
 b=oQwh4T5vJYJMtil2NI509CvPq00PsoTij44xOAXXqMisvbEixHzLI8lcmr/G0JTRcI73/9LuUp39fcwfedRCbLfpctppG9XZsmG2f1ahGXXTrNLEYZlPqPqEn0wHUa69vxR351BWZe+euJUVAJms6+GIfgqjFhSofh6jxeuB834=
Received: from MW4PR03CA0018.namprd03.prod.outlook.com (2603:10b6:303:8f::23)
 by CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:13:35 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::f3) by MW4PR03CA0018.outlook.office365.com
 (2603:10b6:303:8f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 06:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.7 via Frontend Transport; Wed, 13 Dec 2023 06:13:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:33 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:13:28 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/25] drm/amd/display: make flip_timestamp_in_us a 64-bit
 variable
Date: Wed, 13 Dec 2023 14:12:09 +0800
Message-ID: <20231213061227.1750663-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CH0PR12MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 309dcdbd-bae7-4849-deb9-08dbfba2a32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44GEChXGwPkP/vQ3Qx/cG+eqbjnQoiZ0lp6cmezY2D6OxUdY8kam/omc/Usl5izTaU+wQ9zwUiBrNLLa1h9WWfSXSPD0VJMKmgCJGVyE/4qqmDzTEnZCQmXJNl6+4iXcNch49HRmXJZguVWQ9IIJ7BWAjdrGWWwpDNC9A8emAAykEbBvXEL046bfPCMU/iAIrtHPcJgRQfCDWJ7JDWdL6XOo0vR3SVJegX1kV99xrhn82WqWNXctDqKhqmeGEl/WtPbPeQsgKUqhFdbuCuMOgsj9XdmOhDsJjeF7ueKjaz59AS2weEdQa0s4wbkdD4eqMWjex+eEtJ32CJplQWXYsmMvvnPq9WSFQOt0cCLDk3Vg9X38bgrj7UvwF4qPrVUuaky+TSkUbhuAHsxFoWLQHb1FFiGCsTHNWGXsW/6F1bcQEmSZUGt9Lozhq+ybqEAEGWvqSWZAOvunw2ZjIn0ZbznUIn6mqxJNdHz1+HsFUjjBv1O6zkNeuOpdYLarmjmiCKBJID+w1NNyhVh9A9tPsDWbjl9ARNiR3JSNxF+p4naQAzEsF8C+gJnwZfQEuzlGJtb4cvSAYXmi9+S6K5x+OcH0ciXuWADxkWNMfyEUXV56kmyewjcYoBqJqluQupXkO8ZtMBikYqrvonxnv0cg6D0FLXY0gEbfRDl7pqKbkPTfb4+VSMJD8oct355GIkStIdXjnAYpPcM0f1GX00t1yfTsnfXRatFKgF/IOr8RaQOlHP6aZhYLRLhAe/SliGfoeuSsO3BkaQ2MGDxE1ijgQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(47076005)(36860700001)(336012)(426003)(83380400001)(81166007)(356005)(86362001)(82740400003)(41300700001)(5660300002)(8676002)(4326008)(8936002)(70206006)(70586007)(316002)(6916009)(54906003)(26005)(1076003)(2616005)(478600001)(7696005)(6666004)(2906002)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:13:34.2682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 309dcdbd-bae7-4849-deb9-08dbfba2a32e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5106
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Josip
 Pavic <josip.pavic@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <josip.pavic@amd.com>

[Why]
This variable currently overflows after about 71 minutes. This doesn't
cause any known functional issues but it does make debugging more
difficult.

[How]
Make it a 64-bit variable.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index e2a3aa8812df..811474f4419b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -244,7 +244,7 @@ enum pixel_format {
 #define DC_MAX_DIRTY_RECTS 3
 struct dc_flip_addrs {
 	struct dc_plane_address address;
-	unsigned int flip_timestamp_in_us;
+	unsigned long long flip_timestamp_in_us;
 	bool flip_immediate;
 	/* TODO: add flip duration for FreeSync */
 	bool triplebuffer_flips;
-- 
2.37.3

