Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909E0C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 22:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CEF210E05E;
	Thu, 30 Nov 2023 22:44:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2AD10E05E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 22:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe4Iu5TQ6eu36Thmu23BT+38Aa1hopn3pxhZA+sVdPu6c7aZ9v3JmK4Di7GaA/HG3nTZ7JcFxsToC+3hIIS7frd0n4Z7AwHEnf1JCnv6KMlsgsH7YZ6/LcNCp1NPWeUgIi/E7wgvQe8ikrlQ+my5nEPcT4My/ZYUwS0yeV+oUUMmzNozPDMffiPbpRlmewS28SeRCD5fOIJrfNEYYahKqBYLutQTOAFApzWaDjViTzw/ltwrk/sXkr/UdwkZtdVQLQwEnVw/OLW88WRYJ4HZYisL3v20IfzgJlcMnSdmCAv7E9hb0+nKtX/nr4YrBRecAFeO8DYtCi3QmOlFBNCB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9KFTWHO65isYzK+JFov7BnHH0KpEviVTiEFbWsxpPk=;
 b=eDeRsfTeGvBAxG6BQ9usmBb4Y0DRPCgS5iyh6xYfcVR/cKmNPG+s7QW41y3JLBz5XMsU86UARZdT7l0CRiyiZpENUyQLUR08lOJeYOaAdwnc2aQoPgbc2lLFF4Wb7YYxImYfKWyQ4cxNEb9BNbUCFfyVjudkKsmS9spIvmgNUpqtxRrfDYsOmLbA8A4j9awG2FZF8ytBpT3DFZs/CprBKGoYFC00EpQzA/MfCeNVTJ6JrDZrrpeNtCvBy/54WECc/yxoLDGFA4mRa98jHMN3SeRhBsBVlnWyB2AW7pPQ/oyojQcSuyIyk/e3TRbhteCtXJBrm4+PKIiRrzo8DoC/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9KFTWHO65isYzK+JFov7BnHH0KpEviVTiEFbWsxpPk=;
 b=QM1Qd6S7KZV68TQnqhEjx96G8aKe8Fas/DQg2NMX5bKelU+cqUDTc4prPskR2iQtWmAbslwkUMqDmKFBqwfLpGi7o5lZZJD2ZO3n2S4iztoPBxeaa5ukHgqq6QQY6liObLRmpPAvWjGdbtYUSl1i8XuWWr4Hhwd/7h5eDTWOkX0=
Received: from DS7PR03CA0129.namprd03.prod.outlook.com (2603:10b6:5:3b4::14)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 22:43:59 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::44) by DS7PR03CA0129.outlook.office365.com
 (2603:10b6:5:3b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 22:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 22:43:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 16:43:57 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Increase frame warning limit with KASAN or
 KCSAN in dml
Date: Thu, 30 Nov 2023 17:43:44 -0500
Message-ID: <20231130224344.495215-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bad1627-a640-4837-1fb7-08dbf1f5d781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vs579fZNosZ0NeZ+cXVWylZ4zyexJxUbVgqnPdAro87W0QoS1FMHJOKnOekvnBeKExgANEYRjOBJuVWiNiNpfw2msywVDgO5kRoEzvQvWVCVTiQJvPJrrwVMcttwH12s5iVpM3ntv+SVvtvJE7h8iaT0tbjWACzWP9vbislB+2vrcicR94/G91EvDwa8fNQzi5lA5w5XinHV4ueBAjDFWYi2m0Z5WHtsI1C56pj1+b2jovRhKcT2gBEAueRZb+AUKl2uuVxCN3tM9is7ImMskzd66svp2cLVnHK4x0xrEnSKtQVdYXtisEbtg6heQwj2jUjtcpA0FAXPFmt8Ymf+6aEpZU6P6QKANaGl5ObUM3fzNDP+al5ReXyNha3hhnH03wOHqAVhOiDNrq1bR3tW0s/V3NkRDRjma6QGLYzWu2tKambZ3ciXFpgSgCGjr6g+qM0y32gWTGD6sXRbU44hKwlJnamU1QH6iz83He7ML0SsJ7HS9RgPVTO1vpUw081tsEWgN0AtmZMWl3c79JTxHe3UpBlRecW9s+CE+x7RS0+MgyJ2ptPiBs46YwZUNpMHgGLW/wc5bMXvfdhQ0OacGMpJILFiKpL5JlL0HXCN37gZwv6Ji5DWP7c5HUvEmfU+rc2LUvoqL0uMli2YjmZwXYfh1wiRlFHMgHiai/RBmOaCllXfSWAHGP9IIg+GLTr4glgYYNS42JEpENWvRob8F/fcEfvplJ9BUBNbAt21TIgck+luardkXIxsoD2R/OnRSnQ6WUOa8TsFmikwcXzwQm5W9pzTqU9Yx6V8JUoI8WUhEjdi3/qI6rtg77j3WpB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(86362001)(40460700003)(70206006)(70586007)(6916009)(81166007)(356005)(82740400003)(36756003)(54906003)(47076005)(426003)(36860700001)(1076003)(83380400001)(26005)(2616005)(6666004)(7696005)(966005)(2906002)(316002)(16526019)(4326008)(8936002)(8676002)(5660300002)(478600001)(336012)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:43:58.7121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bad1627-a640-4837-1fb7-08dbf1f5d781
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
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
Cc: kernel test robot <lkp@intel.com>, Samson Tam <samson.tam@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Does the same thing as:
commit 6740ec97bcdb ("drm/amd/display: Increase frame warning limit with KASAN or KCSAN in dml2")

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311302107.hUDXVyWT-lkp@intel.com/
Fixes: 67e38874b85b ("drm/amd/display: Increase num voltage states to 40")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Samson Tam <samson.tam@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index ea7d60f9a9b4..6042a5a6a44f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -61,8 +61,12 @@ endif
 endif
 
 ifneq ($(CONFIG_FRAME_WARN),0)
+ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
+frame_warn_flag := -Wframe-larger-than=3072
+else
 frame_warn_flag := -Wframe-larger-than=2048
 endif
+endif
 
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
-- 
2.42.0

