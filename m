Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F253C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 16:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E1B010E4E2;
	Wed, 16 Nov 2022 16:58:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE1B10E4E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 16:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAlL1Zmoudi7sufqbcxLGBWxeL2h7jkepjNC3J+kAYTQUOK4qi6ixf45CZgn3pkMBeesqEr1UKSrpMzcXdCLEZca1oohCwj7ofE6t6+7x2yn99xfQDiq2tFlihYUlK9QRUfXBQDWhyhHqELC/YnGEYX53joDDTHmnPAjNREO+pgVQGGKhtlUIb2rUpmCwMXrr957wxyz/qj3v8ebaAVlH/UfJboXvQ3hHcGe5aDXxGVzdAmdO1d/ZLqIs61CemlxLXF0Kqn7i1NadwSoQnEpUTuK5VcljlpE6W3Rg6vfugTWTOhoTR+/zJXVhbhZdxNHjBIV7avRywXfKr0C05x89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxHiFkJqN6uOkl7AVKqqcjnMSfLBovgl7t+DhSV8CWg=;
 b=XSNMEON9KG7NCfoTl3tFJXr8DKxIfoVs85Kl67BR/dhaQNgaWWRR7kLf+8vCCq2FZb5I4Z0nYN2mXMGMq5wqB4+H5S03qDCXdTCNlKmpXSG5Pd2Dh4+eeK/yN3Rr79V/UTaVKzRxdnzjWdEn9/FNySg9CDS+scOa6/wL+P+JVDT3lfXDaqTAAmTu/hQzyj5bHNxkYFn5sjctwjUl7K+jznbDeg57FOVpGdILwv1E0HOFcAMIjspNqB7OiSZ8068dKvSprurS8WcSxwtZ2a1zVPYsaueXG7NlH/Bd4LnXgu/XNExRqa9MyEWk4pTCc95Y8fPAJHTtxIm+9xitsgLXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxHiFkJqN6uOkl7AVKqqcjnMSfLBovgl7t+DhSV8CWg=;
 b=PzxdRuR+8zRwgPpYjP+YP82sj3CQ0AoVxADK2Bj15QWvNeT584PgZE6OYZrTnutXaIy5zo+jDd1vTDnuO4BN5mdg/SjwGkxfoT7/2bvrsBgphx9LlJFEy3W9J9kL3lDnciu6wM2D9Jw10Y6OiRItxk3ovpNzq7R+U0o00ZDvjyI=
Received: from DM6PR07CA0042.namprd07.prod.outlook.com (2603:10b6:5:74::19) by
 CH2PR12MB4857.namprd12.prod.outlook.com (2603:10b6:610:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.19; Wed, 16 Nov 2022 16:58:24 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::4a) by DM6PR07CA0042.outlook.office365.com
 (2603:10b6:5:74::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Wed, 16 Nov 2022 16:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 16:58:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 10:58:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix the build when DRM_AMD_DC_DCN is not set
Date: Wed, 16 Nov 2022 11:58:10 -0500
Message-ID: <20221116165810.2876610-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|CH2PR12MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: a0419896-f8a9-4384-cea9-08dac7f3c621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zu9FJrMhGXqgpEbc4Q8X2FjLWPMQJ8cOcUPsuOgAl7q7YpPV8p7b/l5/49E8cS4D+gReQ2kMEN0nr6km6sPARhnFrN7bCXbItZVALaFg4nXYimfp23/1CqWx34+xAh2PJkrjMBmF+DbC1D8nNkV0j7y4m+bICwpCQ3x4XKyS4u3DB/xPwgDac4YZfud2pbZ8CAmnIviSYwk94E9H+g+xxHnTMIl6mJ+gSAIlZ7JNtpZ0HPxBFkpyKd37sj0MFj9j+UdoBgCsdqkihlIYznLaV6HPUi7Fm6aCTiaKKQJV82DNQM5ocOKq89h2mdOYczRZECWuVn5J5OXUbkWglvr4+lR9sS2n4CpvDcEy9+p2oM3k/H5nMAo2BD7q3dFefXRGYttz5H/8N5S4ZZNIMHfdUh3g42qwFD/e+diWgtFzsXnDI6wrsMyRKQ7D/p13KqLnoBL8oq6Bjd03p5ei2qcGlXbHar58Vq7Z0pMGrZciBwG/tINXi2YYOr801cW+xnIOD6d4hYKbvTh/7yF3a0krt6FWRXYFQzcrzvJfTyBT7vzbigcH+krD4KjjdBVVc5ftUnzvD/9b5u8KZj0E+N/n2jNJwx34CKQ5rbeYu+tHaEAP+96kqW53OvzCaQ+NX7nIrHwcjcVNiQ9+j3lj2JbTqbGB82cJo8nrmO3CnKqDmt07K/yUU8gS1e4+6itvTWlz4zB1qtSEe8evZL9VKP47IK9UcfGwE+3Fkp8p4uikWqdqTsKrmJLhZjRCDlKndZfVLcJ+tUy/VKngpphlSKrkzEQ/TE0YwgQ/VlM1EPTF1dY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(8936002)(5660300002)(2906002)(41300700001)(70206006)(70586007)(316002)(36756003)(6666004)(6916009)(54906003)(356005)(478600001)(8676002)(4326008)(7696005)(86362001)(1076003)(47076005)(426003)(82310400005)(336012)(26005)(83380400001)(81166007)(40480700001)(36860700001)(40460700003)(186003)(16526019)(2616005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 16:58:24.0650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0419896-f8a9-4384-cea9-08dac7f3c621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4857
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Alan Liu <HaoPing.Liu@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move the new callback outside of the guard.

Fixes: dc55b106ad47 ("drm/amd/display: Disable phantom OTG after enable for plane disable")
CC: Alvin Lee <Alvin.Lee2@amd.com>
CC: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 43eb61961e0f..0e42e721dd15 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -184,8 +184,8 @@ struct timing_generator_funcs {
 	bool (*disable_crtc)(struct timing_generator *tg);
 #ifdef CONFIG_DRM_AMD_DC_DCN
 	void (*phantom_crtc_post_enable)(struct timing_generator *tg);
-	void (*disable_phantom_crtc)(struct timing_generator *tg);
 #endif
+	void (*disable_phantom_crtc)(struct timing_generator *tg);
 	bool (*immediate_disable_crtc)(struct timing_generator *tg);
 	bool (*is_counter_moving)(struct timing_generator *tg);
 	void (*get_position)(struct timing_generator *tg,
-- 
2.38.1

