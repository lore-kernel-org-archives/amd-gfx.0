Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249DAC54EBE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD03B10E624;
	Tue, 10 Jan 2023 16:59:07 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0971C10E628
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5fUl84fx7y/fOkjkPQ2SDNpcTSEYsI+d+lNWuJRVU6sctdOFfGtR7WFn3AgARI6O4NMiRqWYgoujsWMHJvhYzs8GmfNTRZ132C7zfSd8wjCRysG2g6lXO3be2ficIWP+l0YMqwTrjpWZgSq+Jq6jWvuebZt6pqlzP9wFdXWTWQtiOiN2l1eZu8vSQSoFLAFt3km8Kv7dV7dpRmyshvInxqtmsMKRy9ZyAk32XGKdbtp0eVTqmc5AbawcrgKivuNxAQA9Mj5VD5mYSJ1vYW9+FRv16jABRb7IjPrIL6EfSUP97jkK9r51arWFNDziTXdtVeQXQUDMDDNpI3ycHgwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kmF/B8cPjqGw/7NhaApfHWDYwnU63OPVsGo73JYWTE=;
 b=mfkIHYKjXKRNgwdSBEaMqqP+K5H3PM5MSxVofqJCTHvMT1L4EY1W72u/PuHZlEOtMvk+Q7SethFk9DMD6YmgK5TsxtQIonfDCJ3PjrqdFKTPHdTN6oki/RA2PJNrX6qcanDvggabp8khi8TZ9Nrqa+g8t+LKGB6789syRiOyXw1zm7WvYI1GAeWejB4ulm6KhFwVVR4gCJDYatERzsonV1OmR8w/4JJcLD1wm/zmDSE0r5Fv+y0sbX7QhD5W/u+wYUBD3eVIShXmPdUWykMvyeHLnCFKNNek7gj9VWpkCnOoynKZzd9zsbxQp/xxBMEjx1MqznQfnSuHrc2z/tOKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kmF/B8cPjqGw/7NhaApfHWDYwnU63OPVsGo73JYWTE=;
 b=SB/d95vYjQU5OQFI1tIlRxizN8KBl9ODa/OGZOhzyOwHx2VXadxlLj7VSlWlULHV+64QUudFejZgiwqE5uay5GHZvASseyIuAcTGrdUjH+oMAXYViGuQKKj1mCs1Esg8TOGOoShA/P4uDiNHOa+ghODgS2BOb2V3k0znRfaT7HQ=
Received: from MW4PR04CA0192.namprd04.prod.outlook.com (2603:10b6:303:86::17)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:59:03 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::17) by MW4PR04CA0192.outlook.office365.com
 (2603:10b6:303:86::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Tue, 10 Jan 2023 16:59:03 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:59:01 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 37/37] drm/amd/display: 3.2.218
Date: Tue, 10 Jan 2023 11:55:35 -0500
Message-ID: <20230110165535.3358492-38-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|DM8PR12MB5416:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d383dd-8365-4e17-25f8-08daf32bfa82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZZ8/0H1Zz+jmOZY8blzABf3kDEPq2Jabvmb2GciRYrLJDk6RX7x1evXyesPndHM1WEMhx1kiNXSf62J6pT+5Hs3NXRMatYF/EhihoUfxMpBbOe02t+O1PSTl7yLpwOQiFHt/qS6+GsTnppM9pgpFiGAefV6Cfe+2Phj6y3bw7iX/UBC5pSRrrxcQ8SThXtoPHHCgffSpDd9bAwMYM6sU/ft+OQXH4vWTElk6VOC3Isar2DQ/S01JcEaeOotrAPqBMziqndkmHBQo2Jhc3am16e3uDXsDOyvYqh0fMvrJPovsHnB4C+HOj25NRKeu2RbPQsX80mWCuyrcW0/QF8HUq6LPSBYAdBCEkDVWnKanP/mzkhmS9fHTJRt0PBINrtxvPERgi1vflZcmskhEnIwJ4QCFPqRVu0Y8MAVU9H9YmkRss2Gy5IdQh+bVL1xEmSJcXnxKRS69YpbTVdLogfPMNwwMoovvqIEI6LX+859xPy8GkBSpAsndY05LlioQALnImh+k0UBKk8BjM7AGPuPh5qLEvJYYFxbXNKEIq3EdybwxDcfpgA5KwIqoPApR0Nd6QqBZGvk2fwLs8HF1tSVecdyOt9ojJc92Nj95tqN87hEQCUeSDSEX6kpmnzeOWLTWnAFs+uTZ3PE9F2+TEgqu3RIEA3H+EvhkTtesIeby/W3x/YiAsnFm4C220DtKhO0Wu4lIbOc+xLg8pWfG8fZGfXt5LHXowSuesLWEt12EMA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(8676002)(70586007)(7696005)(316002)(70206006)(4326008)(54906003)(356005)(4744005)(5660300002)(2906002)(40460700003)(8936002)(47076005)(81166007)(426003)(41300700001)(36756003)(36860700001)(83380400001)(6666004)(478600001)(40480700001)(2616005)(1076003)(336012)(82740400003)(26005)(16526019)(86362001)(186003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:59:03.6760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d383dd-8365-4e17-25f8-08daf32bfa82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

- Revert patches that caused regressions associated with audio and an
  old change that checks the DCN version.
- Refactor DDC and HDP.
- Move DPIA and DPCD logic to new files.
- Updates to DMUB.
- Optimization and bug fixes for SUBVP/DRR.
- Drop legacy code.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 53f449fa2b71..22e754ad22c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.217"
+#define DC_VER "3.2.218"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.39.0

