Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7985DCDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F70310E4E6;
	Thu, 19 Oct 2023 13:33:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0120510E4E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:33:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbW01EbOm+UqzOlnv8hkGMDzpZjn6/uOWxQHo1UyScEHhs2yKadDzHF0OuPFLRERYJi/He0DVRNb8KxxnTht31xtt3tM7xNefbEfs7weS6y67APW5XV0iEvy7iuXZ8sDPesgs1yarRyxAtXYa9EzZ8cSNCGwEc9qGqePbMe5DiIkNpACtZVivNeOxZBXWzxqChvd/e4Lt4dTdBdruzzulHcNJrwitV0Zh+ZB5MDs2QwlFjV3ruVk7MISE+KCd5DV3qsEgSCXeBfvdYTMtyNiRV8SbQm39hbdiuAVOFhkMeJLBlO/8nHCaS5IQh38N9WPHtW7/iJL+HpDP24jtnrO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOR/Y5M4SsPq/uPyRAgLTgR3BSC6zYMhW+LdFYiKjhE=;
 b=l6vHbS2fpyxFoKz41vuS1t+BsV0m7rjr2DeqQxUJ+EALuKV/bXojFz2rK09/bht/RYI4jU6H/XZf1DZjZsVbH9tPCjOA990a3wqzGbwau3VcLSyoSAjIRawEMU8J9eAbWPOw6UD1jUtUyjlP44THucJeN89ywF5G0uMQseqi+QkVlkbvIBHdARz4i5MrLhmnWL+AC12bdz6gC82Rz7WSHAusAy7Ix9rCe7uykZkR11gyVlbsvjVfQdoHjIanpZ/sBV2KEF0o1nlYo61YAEhsVgMjzoAX28bVy4ORdauWEYSB32f3E1FS6qgnJ7UhO0FZTI3tSwpUtz+OABM9w+gbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOR/Y5M4SsPq/uPyRAgLTgR3BSC6zYMhW+LdFYiKjhE=;
 b=R7O+HF1KbAV9Uct+njoLbOoNojqm/3Nwk/492g08VSOnizU6ZBSLB41ZXkGTKpoOTYlR5fkJSlfiFiuipU6r48h7A6DT53U91OZjkMFL0ra15gpZz43X8oC5r4HZVYE0Ol0luxhdYlybJFPHPHA5eygWfuaz3261ZM53hp0WOTQ=
Received: from BL0PR02CA0109.namprd02.prod.outlook.com (2603:10b6:208:35::14)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 19 Oct
 2023 13:33:10 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::d1) by BL0PR02CA0109.outlook.office365.com
 (2603:10b6:208:35::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 13:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:33:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:33:10 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:33:09 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 12/24] drm/amd/display: Revert "drm/amd/display: allow edp
 updates for virtual signal"
Date: Thu, 19 Oct 2023 09:32:10 -0400
Message-ID: <20231019133222.1633077-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 7514f919-fce7-4eb8-b2c5-08dbd0a7efda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VS6Me/uMMHnNhn9MB68XFPm9p6bDOz8FufGWSjDDvMf3rl8tKmklKhMBuoSAOyx0cneTSzh+LBYxosF8fcmbKe+1gH1Go33E9HlxOgAdIpv2j3yP4/ZWUAK0tH6wrDKf9TH4fkgDvjwu+/gJcZ3u5ZdOL3AY4Z5qseYS1RVWjI4TvyFqawUl2NWfwN4y2/5vqHuLpAGmqOGGMdtpjF18az3jrXl1aj6Ks9MJAajAC+pmLCC+ACRuni7U615sS/ks+rCAPwmBIld6rBCDpG4ZuhKpZz08Cnfr6bO5SWVbG/KHcemCPqgWw1i1vAFb1vs0mb0WU5hqrUifC94pSH7R6ZogRKM2L8aBbiSTWL9S3l00LzQUiYulG58lkhSz4vHbqcNTBcBSvZeNe6SLAPVRpWl503fTqX6oki7buF6A4PpObxRKjumY8j9XcXDEGDz5a7hyOl/jtA5fBdjDQmk+ApDIx/JFvq+me1QTjAwhOcpjEdCt/vjsF5FpT+VBwgCFpomroHK9sA1wJr4FhIiOlzcigXHoLMVAZXYahPtkujdLv4Y1mQ4uN/2zUoEMy/fMNBPVbyUoRlaJkYcur/mo1I1d4dkrOgsmSgGRqXr+rd+EtxuUCD+C6RuM/dFLpDSnJ3mrG55qHA0OwIqd0VrR+dIERw9Lp+SNMLOX/8ukUnCY237z3VcEcYv1hvc1yIq3NqJSLHx3E4Ywq4BaafiyNQGc3T1DMhbi+d3yAUVHRNaRVZjXIBonU3/6qoHRKOp8PSYjOoVg5HBbMcnv/zKLpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(1076003)(81166007)(26005)(2616005)(356005)(82740400003)(336012)(426003)(316002)(6916009)(70206006)(70586007)(54906003)(7696005)(6666004)(478600001)(47076005)(36860700001)(83380400001)(36756003)(5660300002)(4326008)(8936002)(8676002)(41300700001)(2876002)(2906002)(86362001)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:33:10.4791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7514f919-fce7-4eb8-b2c5-08dbd0a7efda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alex Hung <alex.hung@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

This reverts commit 4ad3ee5ccc77aa3f9d702f7b9ad4d9cfeca6c443.

[WHY & HOW]
Virtual signal is not supported as audio capable by DC.

Reviewed-by: Chao-kai Wang <stylon.wang@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/include/signal_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h b/drivers/gpu/drm/amd/display/include/signal_types.h
index 325c5ba4c82a..1b14b17a79c7 100644
--- a/drivers/gpu/drm/amd/display/include/signal_types.h
+++ b/drivers/gpu/drm/amd/display/include/signal_types.h
@@ -132,7 +132,6 @@ static inline bool dc_is_audio_capable_signal(enum signal_type signal)
 {
 	return (signal == SIGNAL_TYPE_DISPLAY_PORT ||
 		signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
-		signal == SIGNAL_TYPE_VIRTUAL ||
 		dc_is_hdmi_signal(signal));
 }
 
-- 
2.34.1

