Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDD1C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5567110E705;
	Wed, 13 Dec 2023 06:15:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C6710E705
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5/n6F2Ed8QP655LA8cFkvaB3mKBYdvuEDmQ/OUpHvYhTE14duJ08TueBZ8g0EU3BppVbKg3ZUCxvXoKDxNaiD3FBmUVFr8PmiJmwWPfCd97eT2Eo+seZ1I5u7TQAAsM9osi7N7mGWk7gGKZ0paXYEyLt04BbgzpLT8unxA8k7Y0zd1FiDFA1leByBJ/c+rNWjENHVsJoJp9hYzHj3uK0JrzkmtVjhJHb//E6uA7aD8Anumv5rCLxrnMZqflqjub7fiEoSQA9wZmqDIlxZcEzqbmlWJabltKmy9d22wmRF70xVd4yYSFFXUkBGhw+UrAEU9GQZ9zlmbMpvvOJklpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVce+qnf5txyBtoVAMgEuuBX5jrbUgu/RFwz8+4xOto=;
 b=HXmWe4Ugx13WHkLdx1i+FcuYCdhZ9p4xp1ohUtRxx6talj2oOxsDmhy345VYjw+lJLkY+iZ0Uqqa/V7rTIiytRVL9ui5Dspt38hoPShlZ62P4lhv8pOiTwxJYmx6Y4R51Wp27Fpf9snR1Ekxr52/Fro+pc/tggM9GKUBwCvRbDoZMlV/cMUvrR+DEjhbTVXqnP1YptR0wISZmIUuajMCBabdg4sXH/h6lJop44yI6tEygDuXwUzQXUD1pLSLsOsNYQ0lf0Mp/Vv4Eq54ZOzj8ct5Jy95cOivlTC4oPl1Ujw4LoHSKl2sa8GkztofEqNsYfjwbHa1c3nveDA8Fv6Tbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVce+qnf5txyBtoVAMgEuuBX5jrbUgu/RFwz8+4xOto=;
 b=xaP86FN8P3hOlpQSa2+n2PTqQRv22bYt+mrTMZTH/6XeQzwM4dgORUlSiG2YJu97tYIt4yXh1HlFhq4dYq4TY0HjQjpV6WOLJTA3VX0rjUV7KPOjJop6dp0XsW1YTmdE+OdQ+46Zs/XAGABl+LRe7IgltKyAiu4S1BujZVf/GkI=
Received: from MW4PR04CA0251.namprd04.prod.outlook.com (2603:10b6:303:88::16)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:15:29 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::f5) by MW4PR04CA0251.outlook.office365.com
 (2603:10b6:303:88::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 06:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.8 via Frontend Transport; Wed, 13 Dec 2023 06:15:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:15:28 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 12 Dec
 2023 22:15:27 -0800
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:15:23 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/25] drm/amd/display: 3.2.265
Date: Wed, 13 Dec 2023 14:12:27 +0800
Message-ID: <20231213061227.1750663-26-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b43ec3-08dc-4f1b-c1a1-08dbfba2e76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: punmUeqQs7uCDcbJ3jMdOWTBIk4yuSBKuqDREQR7v94cbfHX+CWTWBbDDlc5K6zjuX+kGt5t86fZwlGdhj1Mb83gulbkynugQs80t5QcKxefHZS+wqD1M119l4oLG4Gc+CXnPSk3RtM7GD1Zmk7Ck6Wx6BCd0SjHM7JhufsiYxBxPgDaJN30GFMFsZMHCi3yil1bKCnTKuEK0BZEjzZo8+1GAvNWSto1Z75pSqUeXmWS3+esQHU/7rtvLGnYRqzNnNKZs+rc76YxlFlOjXNdDHeDK/L3tCpAsS7Ls5P2M8GqpKNYnzsdOJS1UOaaSLcIRPnPoPC6p0NW0IbhytPSP4bHB4Fnbl5Lrtm/F05z2/x6IgomWgdPWNJ11A25XDOFmAkr0okg0VyFKsmN+5QB6+bUNTAtczVvJwk+ZEeaVyndCRNtb0Qnk+Cf/GcXSYfSrBiKrq3nmkeDULDeK5Xl5hiXF/IY693I++3v9I3gT1tAZ/zMK+fEV6c6RQh+tJlNHau7r5rVOfzlkBy+WQF6x8Bjzwx7+QZJQ8lbEjj3JOPugXAS+iR/MBnRcyh+GrL4LRaVb29iMZTrXv5sLzOMXjYy90NqPngdfogEi9ox6JimlViev/2Yvcp4JufUMJ0STXZLXadv3hdQFWhNauzIfYfGlLYS2uKJsG4Dq/04OZoZRplOpYAVCsja+emSP964cVmIb8qA3ZJVm47EIKYPkt+A0kk0cUUkM+Sd7sm7lOQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(36860700001)(356005)(82740400003)(7696005)(40480700001)(1076003)(47076005)(54906003)(86362001)(316002)(70586007)(6916009)(70206006)(81166007)(426003)(336012)(2616005)(40460700003)(478600001)(83380400001)(4326008)(8676002)(8936002)(26005)(2906002)(36756003)(41300700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:15:28.7095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b43ec3-08dc-4f1b-c1a1-08dbfba2e76e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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
Cc: stylon.wang@amd.com, Aric
 Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- change static screen wait frame_count for ips
- Fix hang/underflow when transitioning to ODM4:1
- Only clear symclk otg flag for HDMI
- Fix lightup regression with DP2 single display configs
- Refactor phantom resource allocation
- Refactor dc_state interface
- Wake DMCUB before executing GPINT commands
- Wake DMCUB before sending a command
- Refactor DMCUB enter/exit idle interface
- enable dcn35 idle power optimization
- fix usb-c connector_type
- add debug option for ExtendedVBlank DLG adjust
- Set test_pattern_changed update flag on pipe enable
- dereference variable before checking for zero
- get dprefclk ss info from integration info table
- skip error logging when DMUB is inactive from S3
- make flip_timestamp_in_us a 64-bit variable
- Add case for dcn35 to support usb4 dmub hpd event
- Add function for dumping clk registers
- Unify optimize_required flags and VRR adjustments
- Revert using channel_width as 2 for vram table 3.0
- remove HPO PG in driver side
- do not send commands to DMUB if DMUB is inactive from S3

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f622f4f0e1a0..3ca72c097aa1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.264"
+#define DC_VER "3.2.265"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.3

