Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEB0C77B76
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 20:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A43B10E340;
	Fri, 21 Apr 2023 20:39:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1A210E340
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 20:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCzDC01eddBCd8Jdb2oRleKYp3HugDgzyPHNFDErHFPIRZjqyXEQQiknPzNSWR92YGbbij32AeIbvfZvpf/e2IV6U9LHzWF9nNDLMwaRBtmAcg2OKWIEMvxa01yDnxq9xV4bz7kTciggsDtw/3V339xkPGV48JiQhuicEMHxIJ3W//U6u4/U/lMCow5FxkgIQMfHVSC+wu6wK/fvaYVdd/8DcB7u6bt7wXD3VBq+UxmLD7WEhJ521Wyd8uYFU82RTr67vte167CKGyqrjm+X76umVYeb/W1qeXZXLXRQqSxV1Qe2bCCYnHH4bLUDT/3NYX0a9J8i3pCjlhCCStMqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/3mwedUw83pF71ZwcrTaiLdHTSZSrN/MTVeHCHddmQ=;
 b=MBkfIcoFrgXvIneukwCKZONA0TSfGlZVIIAxPgiMVUvLPe60R996GsU+L6WbgrdXJbo2iydQI1UF6yOr0fNZUrN0EdFhDxiO3qd3DlL5ze2Ts6qAalzgqEfv59gvNYv+8lPiTRmR9bySwveQ6Yfbp3ihH84gF92vtaYtjeT9Qoakq0kOKzukHmacBz7z+5EIUbOIojcZ2jAOdCuS87F0/6Xakfr9VeSXl6E9xILRZFEb6ZWfuCH4zUgFlcRUfM+f+LY5IzIUFEwsooZ8DnZiePzgG/ZxTJqQxT85xI8TTTsDuvUzm7l948mQO25KlKga2MttoQOh5NBoXgfIAOO67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/3mwedUw83pF71ZwcrTaiLdHTSZSrN/MTVeHCHddmQ=;
 b=zdjnbGT0VHq0vz+Fl+RKSeK2oOnDgdAij9LwvfvDwp29562UvQGIgmiafYeCqwibOhTI+jgEf39qbEEdsHnCbbgzm538JPXHAENdQoI/CFnjwOU/MJ/TOpSCxeTIe44EEcOnv3Up//p1YxB/ozIYZZofuNJDHkvizyZzN/xm9Uk=
Received: from MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 20:39:41 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::bf) by MW4PR04CA0078.outlook.office365.com
 (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Fri, 21 Apr 2023 20:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.27 via Frontend Transport; Fri, 21 Apr 2023 20:39:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 15:39:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 15:39:39 -0500
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 21 Apr 2023 15:39:39 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Program OTG vtotal min/max selectors
 unconditionally
Date: Fri, 21 Apr 2023 16:39:33 -0400
Message-ID: <20230421203933.1085320-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421203933.1085320-1-aurabindo.pillai@amd.com>
References: <20230421203933.1085320-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|BL1PR12MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 93844e7e-22b0-42e1-71d1-08db42a8884e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hAIqtVXbwuDDLSzaJ3k2weW5d3RFqqvOiDqbj4FKvQResrz3dbfxqG1IIQotPIhLyzwbJEtC2/K1K7ZQmGZrdtAl/iIRS/5o4Tup+Y5YKWRDMhpbeCUazOSadVWpCC9D8CiEK5NHO1HR0pwCbmRFDM1Gw52HfksEQpXZICOfASoeDIeJOK2/5ov9obd/fDhHCXuS8LPVCO+Ob2+fZ6Ielrxh1DwYvh/ARk3R3IBgDAi5QZ6tYhOLafS8q72dsFZl+1wVcHKIfwAIKVcmlJEahfWoxxzSVuQKAMtneHpnQYHczml0eFAecr/2al817YEXco5LeMUzsGJeihpgDiF6AnwTL8lolrfwjCUWoKDw52UV7yJqV65IzsNy/xSDEjIBKoMloP/9srXRDV7hXM3ZJezqweuK28GzP21/PJKokVhIpQvmEs3V+jQCq08CaSNApB0XcP+JatS1tsSmCbhSQfJQciddMPTmA+H76gKu8cm4EFBUsympEMFwFtG9DmFuybuuRsdfFnLwzgY+y0hpDHF8iy0JJrCKpLAVamqaMFdC/tD1ogZ7KD5Lf0IQWnjiFFp4mJXHLcmWq2gxzfpmJcksl+GfjcdwOt/s06M/9SGXuPWuuLzC0vRNuEwDWwOwhRkWpmSz0drg2UyxjEfevUiPzQKrdLQhoiOpRARPq2cHhWCU5TTpJcE/V3QWrwAKb6aX1rX+WYUuKCCVzLcoZJOtcBKDL7+ZudkMWOtDaCk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(2616005)(70206006)(316002)(4326008)(6916009)(36860700001)(336012)(426003)(70586007)(47076005)(83380400001)(7696005)(478600001)(54906003)(8936002)(356005)(8676002)(6666004)(41300700001)(81166007)(2906002)(44832011)(5660300002)(1076003)(26005)(186003)(86362001)(36756003)(82310400005)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 20:39:41.0119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93844e7e-22b0-42e1-71d1-08db42a8884e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
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
Cc: harry.wentland@amd.com, rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]

OTG_V_TOTAL_MIN/MAX_SEL bits are required to be programmed to 1 if
writes to OTG timing registers need to be honoured. This is usually
needed only when freesync is active. However, SubVP + DRR requires that
we're able to change timing even without freesync being active (but
supported). By unconditionally writing this bit to 1, we remove an
unnecessary dependency so that DMCUB can change OTG timing whenever it wants.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 2ee798965bc2..6ef56fb32131 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -245,16 +245,9 @@ static void optc32_set_drr(
 		}
 
 		optc->funcs->set_vtotal_min_max(optc, params->vertical_total_min - 1, params->vertical_total_max - 1);
-		optc32_setup_manual_trigger(optc);
-	} else {
-		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
-				OTG_SET_V_TOTAL_MIN_MASK, 0,
-				OTG_V_TOTAL_MIN_SEL, 0,
-				OTG_V_TOTAL_MAX_SEL, 0,
-				OTG_FORCE_LOCK_ON_EVENT, 0);
-
-		optc->funcs->set_vtotal_min_max(optc, 0, 0);
 	}
+
+	optc32_setup_manual_trigger(optc);
 }
 
 static struct timing_generator_funcs dcn32_tg_funcs = {
-- 
2.39.2

