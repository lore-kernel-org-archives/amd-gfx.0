Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB43ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C980310E80A;
	Wed, 14 Sep 2022 03:52:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26B6C10E808
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHHqc1rwaH0qFcpEEM5OJvWkLCmaP+4sw4BG8kl6bjDMzLihDS2KrD9GsaVynGIpZSZXPrcbb3uCvEQYUQ5jKzO0UdYywaAE/j6Jt9ZcmbGuiCJxZSySbCTiIGgN0/moiSokkNQWq8zz9cpqNue0kAkyypu/2aMvf8ZDJaNHVMgf7fu4tGaNDhnbBFtcaDAlu4fSbmwy9Oppxrn9Vi1IB07YgFP4TKU4LGS0Hi2NIjevBmQUrEK/fbu/Qlak9zGN0RRH3IBsQe0dPzh0Qbbl0C7AiG5ICrHhgs4lHvhe+Wox35OCN9WqyklCocju3H9gMpdHm5Hd4aaaJAyzVRS6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhGaA47242r+vkyMiiDfyo6d/C+r4oCiOUoepY+SWiI=;
 b=lZ6fw01T7FSj8JiSfN/kfMOzJGLNNDWqX2WdzuUGxI/x0GyTKQQ7wvY7yE4ymURST1ZRlbPSetxWx5M+uJR+7orK4LioKv73GK6hO5fhUe3p6xQNnifyujlRM2LoMXgQL8/IuqeYUuY5HFF3pyEblz9x0YlsfJS5SxXahzV92AVmtu5Sl4yfUXJW52ewsDmK2j2MR2AN2IIZug6+mIUPeTVdhFevw1UXkkadwdVRstbEsl5/EV9yuUPvRamSklvOmbJj3MIYJewy6KnZytq87AS5HNdTyDm9CtQly+tlBtPR6SAJWtS3/7V+q6qFWhQxFsdOvbVvxk8deL32jqLSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhGaA47242r+vkyMiiDfyo6d/C+r4oCiOUoepY+SWiI=;
 b=PkxGzOAcFj0Akagf5uypMhqz2X1gaNwhdkrQmFxN1pynqZIAZMmvkfcJ5vLamod4VQcl15Lrc8XMaXYrSh04XJLfIZpSHtSSY240OPaLi0AZwIB0VAi9MzLJMYS6x5XPE2mlBAatNEsWN+sMHOuvo777yTB2holzYTueS1hjfbI=
Received: from MW4PR03CA0353.namprd03.prod.outlook.com (2603:10b6:303:dc::28)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:51:51 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::8b) by MW4PR03CA0353.outlook.office365.com
 (2603:10b6:303:dc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 03:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:51:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:51:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:51:49 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:51:45 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 18/47] drm/amd/display: 3.2.203
Date: Wed, 14 Sep 2022 11:47:39 +0800
Message-ID: <20220914034808.1093521-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fcd1e0-ce6b-4c3a-4353-08da960474e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdPHFv3IxQGkxu+wi5hD/COK9stekEUGG5Iqp31+wRkmVFGvEmtmm41iD4aGCD63SzOVNUxS1hkWrEZdriomJvciwe+7/cNZPNyKEW/z4lczn02LqFchVA5mZ3Fze2LsT8G+5ne9cZ/uvkGv4fMEJGNxYNHxrou5B9AOnY4WA/+ERkXlwzugPOyed3xXVaREckXDG/RUk5ltlS4xTsOmD+/spFGROigebZKiyFqPg/9g4icuWPY4TOKhpM2L3JRYTjW8NKuo6d4HryhEzBPywBvo6GWPNE3FfwI0fYe7Iy7O7ZUg2LrCtIiksIHTyDZob/6iXr3olgMEY5sF3kXSVPnpsR+h529LE+mksteSkH2GMkwEMJ46vHCUnSE8IL9y/Cau7MA+Ni+uLZKjoIM+jHVcgkYm4qhRzNLLDQK6erB6Tbrrz1DrPMnf0DB5Je7cQw1Dcqw3jkx89JiSE0WId7XVyLxsNFsLJ98bS3aIupOoGAkmAgh4qOO8f0jo9w7MZ42CAgla5mfcICDO841vSg9LZh+2h2UelvaWq0A7mInjZHwkYeagJKcLlFM0SFBXA3LNr3Tx8Yv2XaCXdU+ekOIeH5ZGyuvOPJmewiJIOK1z13OhQr77V5gemD+x5RNYbkySymnke00F+9Wf683/p1Zowdia97CQd3F7wK2yJ+qsHX1IoJxVFTC6Ti0oyiMUg4sXM1/p1mcA9q5Kfplq1Pa8jo9J8xikySzpVBHHEf4WsY9BQXQKrT53r7uic+P0gRwwLn37qegiKTzMTsXVM1HYKv2h0BJfgoN6/KT636sN7NvgAhEVLmYbeq25VBajqQIsuFOrgXNzN0JaMLJAFWvf1gB+s+WHLTyKHyVvq/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(6916009)(26005)(6666004)(36860700001)(186003)(70586007)(47076005)(70206006)(5660300002)(81166007)(426003)(82740400003)(40480700001)(356005)(82310400005)(478600001)(316002)(36756003)(4326008)(7696005)(54906003)(86362001)(40460700003)(2906002)(41300700001)(8676002)(2616005)(336012)(83380400001)(1076003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:51:50.9623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fcd1e0-ce6b-4c3a-4353-08da960474e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522
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
- Port DCN30 420 logic to DCN32
- Remove some unused definitions from DCN32/321
- Remove dp dig pixle rate div policy from dcn314
- Fix dcn315 reading of memory channel count and width

- Fix SubVP and ODM relevant issues
- Fix pipe split, MPO and ODM relevant issues
- Support proper mst payload removal when link is not in mst mode in dc
- Assume an LTTPR is always present on fixed_vs links
- Rework recent update PHY state commit
- Add debug option and logs

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index af726ffeb0d5..7adb27b2a6b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.202"
+#define DC_VER "3.2.203"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.3

