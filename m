Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E81C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69CE710EDBA;
	Sat,  5 Feb 2022 04:33:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7FA10EDBA
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l04Q2fBRyBKUKo1XHUn39yRFA+boJgsErGoiJl302t7Zj9Rb5fhM3sDaQHZ6jGSAcz8knC6v5vrHYNIPGfSObT04LgqlnLBFHsEyxXRlCEGnkMhnYY8ncqA3qjmeB2LBlx3ZEKmrQIMI7MxwSy/cYa+lRbhPFmKFn+iNCckIZ13YTnZjOFfeqE73WiYjPwcew0LCjVHYlCf84Yf0AdszZi+MQUd6yQulnsXQfN45iGgYMTAclvg26qLo7hz3vz3p3g6wSB4rjKePSUa69hrjlTUgrd2IM/Q4nSr/xAHRot7DdnK1cV6umT0bZhcUg2tqmTWyYdHp83FGgSZetZFfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg059U8lqVXHq37dVi0CnSr6LD82DIdc6U7hlU8zZRc=;
 b=Oa5kA5Ky80KVAjiYgv8L77YV6Lrxf8qRu66j/VdjIqOc5P9UmwQmB/cAdtN3OZ+XKxuFrxpiv5XT/UF1YOnzKdgCnwMEYaBS7uWjUYUl5XEuhhN3RAvkHXMc0mojk/tHQ4pFmSt207A0caHqeSQyuLbomRPwN+I9GCDxHh0SUB5Ucnlg6xVJ01ryU1uZvGBQwStfEVka8xN4Oox8937yP3Y5zQUMWVjCugW51ADiQdgx6xO5lrQAxxeYB3Fh+wupl2fFh8Lj282ICnFZgUD8+tsZo6yXZNFKCjjoIgo/lUTcmHBfZ/pqAEYzD3xLo6dcA+d2eO8rEP+6rXX4P3Q5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg059U8lqVXHq37dVi0CnSr6LD82DIdc6U7hlU8zZRc=;
 b=iA0vACrXZddlWcyakLkree2vuFz4oE3jLqpZc4bkZPxeYW9YVG1M3ng6oG7iezDj7CW99VRzvOJNMfpBRdjLmMGlEhtcWrItoqxzUzrTBiMiy1ba9vq3cDNqd728FtwgC9k0ZTgB+8uLpRT7J4F+liK/HBPZy/4M6n5HLiLaa+A=
Received: from MW2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:907::26) by
 DM6PR12MB3980.namprd12.prod.outlook.com (2603:10b6:5:1cc::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Sat, 5 Feb 2022 04:33:37 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::f2) by MW2PR16CA0013.outlook.office365.com
 (2603:10b6:907::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 04:33:37 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:34 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/13] drm/amd/display: 3.2.172
Date: Fri, 4 Feb 2022 23:33:08 -0500
Message-ID: <20220205043310.165991-12-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205043310.165991-1-jdhillon@amd.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 501899d4-a3ac-4d95-c68e-08d9e860ad70
X-MS-TrafficTypeDiagnostic: DM6PR12MB3980:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3980A20E038AE0E103422E31FB2A9@DM6PR12MB3980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVKtYmqNfd8wUzrhGZlVnF6p8cQqB0NeWmpwGkIOHhbumkKSoSZV0WE6GCzDMEUQN92mO7KK1l4uTCeXbC7rztIKz8H6nnbaQrPmCtSxMJUhC00qAFlk7OjgU8mFL46I6nLbEMsKPFlRLQpV/GLtlzLqSrfgEy2pJiiEk54MfSmCTC9b/2Mc/lcXAHi3A7JHAV1TQfNX7A8zMdurrkAu1t9egMxSDo49kB3zODbgKYgQaidbY2bLsCWtxfyYIs2/1ic4rD4jXAV+ow11jcEK3eXUKLswxeWj/e4XohYuHQRX4KdaCkF4/EoHtFTarP8z4Ln9AVPFe/3qbcgSYeKd20fBG01X7KobIqmFzD1/bzs4XhQP0chtw27ytTAR+FhxtFUHxZ9pyxfZGRVbiDHSe8QvcrhoWvlrLlmFtH2W7SF9tSY6OzrCX/Cm1Zv3ojZtOF5naVKm0mIVaT30XnE08OKds0BQDjBoLjfjWu6/Or/P4dy0hSvXqQEU3HaUcs+OP10jjjIKtAX457WoLvhTS+YCjgPFBxJkTtcyJJeirfz/dhGHmIwuXg8TdsqCSlT/HIB3hAameG2Ir2xwtVu+IIbG5MllXHFOD3M0Xe+SQlS6ffwsboCcLrxesU6rity+1Ox/xCp1v5pyICs6HZpTTZfwFfxgeR22REH99CsUQL75ZC7PZczlTbSrrOk14REL8uGP5jRlRQsY7CLY9i627w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(6916009)(186003)(36756003)(508600001)(4744005)(82310400004)(26005)(54906003)(81166007)(2616005)(426003)(336012)(316002)(2906002)(16526019)(36860700001)(4326008)(8676002)(5660300002)(1076003)(47076005)(6666004)(40460700003)(8936002)(356005)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:37.1958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 501899d4-a3ac-4d95-c68e-08d9e860ad70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3980
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following fixes:
-fix for build failure uninitalized error
-Bug fix for DP2 using uncertified cable
-limit unbounded request to 5k
-fix DP LT sequence on EQ fail
-Bug fixes for S3/S4

Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8248d4b75066..89ca672866f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.171"
+#define DC_VER "3.2.172"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

