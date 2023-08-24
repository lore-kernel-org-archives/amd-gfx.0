Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC7BEE49B2
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A9410E5DD;
	Thu, 24 Aug 2023 21:32:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2F010E153
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eto8rgRpp25jeMyWXxh79GtE8oHhjJv2XKRReB5uxb4+/SFQ7OFlOctPG+M0ze2vIbrGLfqqdGbV5rUIwjXgCUC01HeXez24RJZjzP/8OCO69fVh6yO8wMYAsZQYiVwGmhLpzraqHKtqvdbO8c8noWLKP3Khm2+oLQZNlaNxZI4dK0ZXUivw+cbtSxr65i3A/TW84zgEv/0cGHNLsgr8uXhcd2kka6vX+0drnl6Nlt5dW5TFu3YCCAsztzBYnXRA4aDw8vr6u7rlUq82bjVj2o1LriJKEqxi6xZ7emQUb51zihMnobsmBSEh20S0Aq/g+uCMrH/sSAkrJFgthb2Mjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdW9IY0Y2Lt8FXgfMxarMngafXGRp0aSiJ91oFGV6w8=;
 b=DUuCNnJW7UVd07etjDInBis0GD6MTQzTdSZKaKpy1xQPiru3Qu0Lgzrww+TB/avjLjLzOHKmlhP+8DyE654Zjs3PylDMnuSBt8rRqcg3MQbR5dIe7C+N77DabD6KQ9iswfs1UKiRIS23Xq9gNg2q0zthef7iltGXQ4IcxU3SJXgfP4AoHglEMzUv9+0FSW5Ki2/CyNSMX/KwZwA48meEpWub+b9L9lfeYus9TJuaSOEsSbqnQFAslXs+XIT7tmqSoRl2y8xP3gHlHckWSjZfAW9ohfMcHO00rfVKtdUc9e9fzTH5oA33EyebHBDe+74ZigmXJNn3lwEvm7ZGQS/1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdW9IY0Y2Lt8FXgfMxarMngafXGRp0aSiJ91oFGV6w8=;
 b=ViiL3ngic8dhwT+MvUn6cAt+gBr15PCLmoUwHanxLrRQiQgTAVjkU2j1RJX/eXgJz1ryOpNqR8qP3QXng/vgHdks9hn0kesxZlWprUYD0X1Hm3L9GusMdmByMiAxOPLqOhdBOpx5TpgXN0usOw879pGa41cNYMmQYuQ0sSbbTSY=
Received: from SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::16)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:50 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::d4) by SJ0P220CA0025.outlook.office365.com
 (2603:10b6:a03:41b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/21] drm/amdgpu: add IH CLIENT ID for VPE
Date: Thu, 24 Aug 2023 17:31:15 -0400
Message-ID: <20230824213127.2725850-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca729d6-01d8-41a7-0aad-08dba4e986dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypED8rOytERqcDcu47EWP3lUTAIkNzgaz8GrFP4p87czaOAdJdmqK10xbfpCXicEmxCwNiK+MWyjv8r9kF430tqwH83swMGCH+QuBPEzFnkLtu+K8FqmuTRcGfyS3rgDOXUvZ+IjYp7DzJeXMKYpWLpTDk1ZLvFL25z9sPrLErNi2AVDBqmcsvlFq3uHB1OfF7VFqgNAs2cKwnvroZsZTK/pIQ6bHy5ikb62ubxGwY2x+Oj5wBvUPyTx1EkrLeXMZK5WinQy+wXpXZG+XVANm/lpVMu8L38HHUmDgZI/pa8YapcAPa8tPyD/F/D4AK3IZ0H1IejSZWMAUnx9SxilRB9ZDDCEOp7Y6N3sYTKsv/OFtbWkBirRSVunbk7oMAJGwtdnHw2qFJTbpErdH5xCIEBbDKZfdr9bbxwV5SNHBBbof0t+KhxROSIoRTUEa3tgMrLu8qLm9tJVrvT/BS/DePEWXAxOGH7mcOnHZX5uSuUceif6aqHOK5DJjBywIfMzveZJZ1sK/obzjTBVUuE96aSORtDZeLPEUbSGsy0oG7SEeg5loXgdBIMxEXzq91K9WJj9Sa/wOKfGwbIsSjkir8MW4t7s3MaYZxhqJs2W0eZ7hhmNYWrOS2Atmjr1a29N0o9gVekwsSzkO8z4VhIhBXDj0IfCcIxQ826GBTew7tkrN5hVkGBoL5Khk/21y7w4Fn6cPvFLDgvpYluulhNbKsME00qnfCcpNi9pheGmh4+lGdOJ/OTF25Qs91NEeycf/Jz8mgwhR6LhoCYOXj2tpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(336012)(426003)(26005)(16526019)(1076003)(2616005)(41300700001)(47076005)(36860700001)(4744005)(70586007)(54906003)(2906002)(316002)(6916009)(70206006)(5660300002)(8936002)(4326008)(8676002)(478600001)(7696005)(6666004)(40480700001)(86362001)(356005)(82740400003)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:49.8619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca729d6-01d8-41a7-0aad-08dba4e986dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add Interrupt Handler Client ID for
Video Processing Engine.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/soc15_ih_clientid.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
index 21af181a802c..e1948613cc1b 100644
--- a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
+++ b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
@@ -95,10 +95,12 @@ enum soc21_ih_clientid {
 	SOC21_IH_CLIENTID_VCN1		= 0x0e,
 	SOC21_IH_CLIENTID_THM		= 0x0f,
 	SOC21_IH_CLIENTID_VCN		= 0x10,
+	SOC21_IH_CLIENTID_VPE1		= 0x11,
 	SOC21_IH_CLIENTID_VMC		= 0x12,
 	SOC21_IH_CLIENTID_GRBM_CP	= 0x14,
 	SOC21_IH_CLIENTID_ROM_SMUIO	= 0x16,
 	SOC21_IH_CLIENTID_DF		= 0x17,
+	SOC21_IH_CLIENTID_VPE		= 0x18,
 	SOC21_IH_CLIENTID_PWR		= 0x19,
 	SOC21_IH_CLIENTID_LSDMA		= 0x1a,
 	SOC21_IH_CLIENTID_MP0		= 0x1e,
-- 
2.41.0

