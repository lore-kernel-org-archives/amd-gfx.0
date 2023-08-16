Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60055C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070FC10E2DC;
	Wed, 16 Aug 2023 06:09:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B9EB10E2DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOXnw9VagOrk0YGtvH/Vf/KOkXLvViLeCNDyQwmKbAv/ODZ0uEH2McB3JFsQA4rMmwRDuT5kkT6lzfKC70nMWGtMmFYr8rrJTYftq6ThRwI96Y/fUuMUdoHHp/85ppYPCwiB+KBbgDxr2HqZiNqFrgP7IQo+9QSWmYf8Z6wGnqxJ1pQpPNMwSkN6srKAnf2bN6RZD6zUj6Qe3AAvvV/gzelm9Yd7SBVyM2ReYe99uFfW4fLR/e06CLvSiaYfgbtVQsrMuUDtTV6O4ygug4YthbkaY0NkvrYO/yiD8XY5uV7p5RNA6tD1f0IlX2CfvLOCb8ZFO2lNPfLlze72ku/QYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA2KUwUvvRjC68zv5BaIRNnQwFJ6AWpovhJxMRG+LHo=;
 b=MDfdf0EMSfDSdoPVHhm7iw5uXvxU6M2vqTYeAhuO6yASyN4KJaha0FZoSCO1fS6joqeUc55JjfgfIF9PUjFiEei01a3Vqedvk5/WMOWeEb6FTbw6o/XO+Q8p2f3cxlcZsEXN74SXaCPf6V70dTiLo1NYsqLZ7TLV/ZVQtAnIdx+dWe8Lxs9akJV2MUS3KXOSjavsJ9fpfcfHeQDzLI83P4OoEduAz+zlYwxFNu7qsnKX9nCR4FCnsSA3CgQ7u/uSbYrtpNyCV+a7O0rxombzCQKloKMqFR9TuHg1OAKCx44Qd6FUJLckPnIe4XKUbga1qrC31Ga133OI2FcptUeG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA2KUwUvvRjC68zv5BaIRNnQwFJ6AWpovhJxMRG+LHo=;
 b=n9Mf2nVsr1rlzB44HF0+GGYlYd6B89xTs3pOlfgzD1sHFIHrGRofxt6hdQ3fqrIDEYmtl0LbA26XfI+mZhL0Dw5x59FRp1hCNjxYth7gmpNcoOeXLmuIEqvfbsQahNI10DqMo8Fb2NK6xMW7SIpxdRg7LrfdbqurwN9iUV5uJdo=
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 06:09:17 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::33) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 06:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 06:09:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:09:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:09:15 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:09:10 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: 3.2.248
Date: Wed, 16 Aug 2023 14:06:58 +0800
Message-ID: <20230816060658.2141009-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|BL1PR12MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf865cf-713d-4bc4-c83c-08db9e1f527e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARQ14eMi9C/duKBhRoBoaiMEDRPjdGJmLI4DQqDVYF4PvEYNMbj1muEpgJaVNlGEc6ekgrj2MFlF481CgKbkEbfAYQnOpXX4I7WBs5MDnH8MILb4D39Rd8ubt42xlaXTCCrnHEmJ2JA51N5pXALzSvk5uNJcDlH8V33O2OMsqHsYtYYlOKlk3Xhbd8YDoKeS/AxTGGZoUv7A8li/wMdYSbmzgeQMx55UgvYzqhfK6pIbAOeaoP7fB61LFs52jsYB+g99fKEN3vPukwcmt7laEkG/ERJ//g5fYGZCq/38OFmSVA+yes61V7Pj2hFAttV8jHEfEjR9OHDyjKxR//uR+HNVGQbPn0+iObymZ6ve/yI2KCBQ053TuWF3wmaLTNZLde7Tr1rqtvL1wRxqnp09rj9aiMsSGziVVGMSII5eTnPPSKdwuzTE8tSmtW9kh/Uwi8E/luUtIE1IuxolrsFvIspYC7AqrsSF4wThEQ9IL5OHY0RGTbp1+pPAqq8ZPErHHQLtH0r5A/Npan4FpqG2NRoBlojVx2TCEaRQEwFHB4X1AFxzEpkavgoGl53rUU9ka1Z918Oxu9yU0nlnYFBZgjoARnayEEZrG0W2VrDtiCqJGyEzuaiHfsenCArwV0Spbx3NQTmF4YrAaDLx2uMbXz3HWk6hKAFLSJjojYt5c5X/zcqjF2iCKyN5lwK/+yQ7Q/dOny3yU9+cBzECJCcancavtzWC3Ce0LIUC2IzB8jOg3cVrDkGng1X3YROdvHGDY5nsY7e9eESmby0QwY2vEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:09:16.6553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf865cf-713d-4bc4-c83c-08db9e1f527e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Ensure FS is enabled before sending request to DMUB for FS changes
- Add check for PMFW hard min request complete
- Save addr update in scratch before flip
- Fix static screen detection setting
- Write flip addr to scratch reg for subvp
- set minimum of VBlank_nom
- Correct unit conversion for vstartup
- Roll back unit correction
- Enable runtime register offset init for DCN32 DMUB
- Refactor edp power control
- PQ regamma end point
- PQ tail accuracy
- Blank phantom OTG before enabling
- Expose mall capability

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7cfb3ccef075..284fe32a13f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.247"
+#define DC_VER "3.2.248"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.3

