Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33D6CE79AD
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5626F10E433;
	Wed, 20 Sep 2023 03:21:21 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABD610E432
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWo/l8KYMeQpq3aq3eyRj90eCzwDqOVN/ge00CP9EClcWEEtxmBCWfb6zOBl6kS4gkm8VKdjcs9//Ty/dmYQ7y8rvyNLSrmBtQ1d0nFW/RC7f+1pR7vESbe5r5IxCYbVckoZWRgJEwDvV7L9Wjb6sru/S24j3dzTvJ4X6DV7oYVxkWHiPl8hVak4V/ba7uTozl92UytepDQcS0b6BKwKGLO+3jpJYpiqSMO7hRESew8SA7jIuaVsfp9NdUWK5znLqhM3iD1k3Ysh9UiHw1GKRpJ7n40X3TcWbqWRpTOeSQ0QrGlhv0LM8K1iqH8yrMcLdJHUAbk9y/48wW4W2kkvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBR79uuhoeWcGiQHoVKEiB0H/f5CHiuv909F2bMWWE8=;
 b=VSFzJdJPQjXnSsHnTlJSJgjcigSOf/3Ps65XQrQD6cCMBjMMeS43VT4t9Pc5yNmH70GYB6C0UtLfP0BKfM5cZXrhB6+sXeSAeGSis4HRnEL2L2zX5gP7eNyhiPYp8f/E4xaHi/qWwD6CnBMdL0x30kUKdlVzS1tq20vFrhgqV2NhTcXAFpnQ9YYvSFeJVjiwnlteebvt5iJavNVKwETAEFlfnirXgm5iiPv4azmeK0XQ/jvpEa5FgmkmLmnmR70RpTYuCFTutyhwalPMtZKHr5bP9oV92XKdU1vAVPdIQvhGnuhy+WMke21tbe+N88XprLIEIMWHsIJUXyrwsAOxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBR79uuhoeWcGiQHoVKEiB0H/f5CHiuv909F2bMWWE8=;
 b=SpyJ7t9bakautBAm42hfYEMsCb/hIO1xWb9uUmEZNvddMHrgrclZaABSGPypwDMy+a6oiuvpwyl6ihQdp9UqO3ELqzh57hjKWkyyuBLZXPMvv4SxVZTSPZrazykmBPWgHQ/lXmw5qsdd7n8RXsh2bC2nWlu1+C5a/jqTKReXufA=
Received: from MN2PR08CA0002.namprd08.prod.outlook.com (2603:10b6:208:239::7)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 20 Sep
 2023 03:21:16 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::c7) by MN2PR08CA0002.outlook.office365.com
 (2603:10b6:208:239::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:21:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:20:49 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:20:44 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/19] drm/amd/display: Break after finding supported vlevel
 for repopulate
Date: Wed, 20 Sep 2023 11:16:18 +0800
Message-ID: <20230920031624.3129206-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: c8aa1eb4-ee42-473f-474d-08dbb988a65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UxHJiuVU2w/tbg87XHSJjhgDggUk5VpM8MpTWx+AhVEHL8Qqb8oAC+W3/lRL2bnaYyMQYpf+Tv76iOWNEZ+5/zp6pbCXntGQ2oLxAWbh8oCO3cEi8xR2AcqbvdiJOYjB+yW228iq9lmtDnN0GFws7rTU0pWl57/B58fHyoHiFe/W7lCH+rgifBxL6u0EhTxgYBtM31geKhpgeOX7kmzxWB9UbKIWIqInUWLjkMsJmlA+cpZEBhLkpJ8QiLW/2tXu+Be//jG7re9RSEGDjKTWoKQsGTXfp6mCufq58HECYeQZPtYikzQaMdjWxUfPuoYatdUViV+dBTVrsT5untec+HZg4crqvV7w9UG8bDC5aMZGx7GC96wm7/jJg0EaV3FC92EF/IavLzoQQhblIopp0X9+kF+Ds4UTyQxsB06Vb+P8h3T2jsyyVpD09uE6s7gPe9fnae1lB42rwn5yz+DbUJLa18ZGLeV1jxuQpJmzsxK2PUnlrp+LIzogJatO0fApMkiydVLF926421RxFtiY8Xj5AlDvoQSzj4XrCaBrLo02MDSW8u/6TRtOepBQiRWNErBL+e+qZK9i/YeBbQLJdw6E84Qswo6al3Rg12J87AHN4sUHVOGAniKNkfwnUZdP7fD9IB+ZlGY2lFmSPeKmWhdjYF7yJQzJwncNBA7kpJSwphDFIqHCmBHBab3ODVFRft/GbCwhRcjufknyKQOowa9vvq9dXyJDWuk+fzqsHigEfQMCtK3+Op/vPSCzzwAeH9ep52XbzQoyH+J7EL/sQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(70206006)(36860700001)(316002)(41300700001)(54906003)(47076005)(6916009)(4326008)(8936002)(8676002)(82740400003)(81166007)(356005)(70586007)(7696005)(83380400001)(6666004)(478600001)(26005)(2616005)(336012)(426003)(1076003)(86362001)(4744005)(2906002)(5660300002)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:21:16.0410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aa1eb4-ee42-473f-474d-08dbb988a65d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <nevenko.stupar@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
After repopulating pipes for a split / merge, we want to find the
lowest vlevel that supports the desired mpc combine level.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index dcbd38bb3ed1..062633af77a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2183,6 +2183,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 					vba->VoltageLevel = i;
 					vlevel = i;
 					flags_valid = true;
+					break;
 				}
 			}
 
-- 
2.37.3

