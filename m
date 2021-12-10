Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C3DC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2302F10E4B4;
	Fri, 10 Dec 2021 23:05:32 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF6610E4B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILGfnyeG/D3vuPmGWJ/2RpHv8zxS6pjZKPs6+bbeqA1SAvOOK620BoZV9x4g7RAbDEJs1LLQgE6VxKzyReJ49fPE2TrpM4ub/DjTjzl9F0QtJY1ShwcEdEVBKUyCqNUFrX2BFe32C8UVbXfsmGRoulxx3/o3y/4T++epzIT+ftMgblgaCRf6xYMw35k5bbwW2v79my/rP4T2nIeT2MFAg3pnMA0i63JoXy2IfT8S43rN61WxS9f+vQ+Tt+quZT2UHv0kcFyXiY3Lkb1apv1PJMmmT2tloSg+r5HHgbuWBHagkavbIMj35/v62rXgf8aBPyz5ySjh8fJEJpDWeuYdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+waM63LSFfMZjCVTrvM1sSywNTL3UJhk1+eToFoyPg=;
 b=TLC4LTUhQ/236hdDcE0tMCJx/6LXuzoutIVEVsXdqO7Unus2Eii8Yu5JF6jpn87dKcFGXfO//RgNL+7+YkZPBGMyLDhWMWSI7P0XLqGCoyC+337a+PPiMdjM9EMocZV/79lAl5qy7Mz9Zrxax1yTBsZiWM7FqYM7tjE7LDBCPmhrzGgFHVy/ZdN1meQ4RaNPzFKPT0K1z6XisIpI5O2vuUsMYJ67tY+UMs97ued6kYYErUy8SjlCGqZy9LVQwNtmt/1CbgTzun5gIZUxHKO5UaFByY6Zl6dVLUfmFfEjEEO8AvVp2kJ+7EjfTLYbMGAQaSfkKVR8WLqdmWMrdbH5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+waM63LSFfMZjCVTrvM1sSywNTL3UJhk1+eToFoyPg=;
 b=MXiK8FxdAOWlF5SJtLkc2jt6vS28k30YdD7DEilCql9AbRpjWrNg/cTMWw9bHRbrclhtTfZatY2CKt4Eqh/siE1hUGpatFzmUQDtKd5BxUwaQr/0eLXhMKn7H/bPBTjs85xgoB2+eebiPzKBXrXMWHLa1iW71dXjW5k2vgi7KUo=
Received: from DM5PR2001CA0021.namprd20.prod.outlook.com (2603:10b6:4:16::31)
 by CY4PR12MB1781.namprd12.prod.outlook.com (2603:10b6:903:122::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 10 Dec
 2021 23:05:28 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::9e) by DM5PR2001CA0021.outlook.office365.com
 (2603:10b6:4:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Fri, 10 Dec 2021 23:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 23:05:28 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 17:05:25 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/10] drm/amd/display: 3.2.166
Date: Fri, 10 Dec 2021 15:04:08 -0800
Message-ID: <20211210230408.619373-11-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
References: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ada9221c-f3b7-4364-ebd9-08d9bc318e9e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1781:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB178135F1136782423985941FFC719@CY4PR12MB1781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1CsyULxq4MPmTzTBZ8s4FfBESaIEbBvArWjhw6uqTgVYSDWINNuBUlAKZyYvlpsGMXUz0REklplx6o/0u4CUJ+VJvYGXe6wcWccPjkchFhO81H+pq0Wh4afk9Q8WmIgS5yu1SHTvPoK6+wPlzZKbcNP+5YX+DZJ0gUfaKIMGE8FT/lP/j0G0EJpZG4k8YYzDDGfUAivZTdcnEiF1PRNLbqLQ8peBV6RMtp0ffpjG8VDozG4WHfoRlgSx6WsXRTYUf22QLvHLYq4zGiFkLcra4q8XrHfI3wmfZBLJPRb8Y+2+9gbhFMJUw1PS4BDqIRyzx+e7CJ3hs/W9ZEZrNuggwE43kzUcwPivoyyaBfrzabUqZYqzIg3dAkh0qMkhgeybWZ8e+PUQ33OIlBVV6ez3r+xV8rr6zyxhq9r3e74dMqPvH2dQyYN9Jj3bjwaUX+6Ji/WhcdidOy+pMKU1eAtSn+GzhF1LTQzpkLp92un80qYb/PF7aNmOdyKLZIm+UPi2nzzVSSroVi3SjdYETd4i8sfWJAGsNyiQkKpfATZcSUeYTrMlh2ZIh4fv73KDfFhGlP80ChKcrXOg/cW9q0aZj13nJzANjUQiiwr1fTvLAw4J1P1lCl47IBBoUYF/vjLJwByu6jARhRGoynCIeDC2UheNA8XzjegOvtpr1M1fQdKip8RW3p2du4olUegpjVQqVAxEmBnKh0t0nZI5cjEXtcuOJuefbL/sz3CVm/XTwyTGkilGFI0P+xPxqmL6fgYkJphvPsqaYCUaQGgPJqNBm621pPS6yzTTGMNp94ajdc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(36860700001)(36756003)(83380400001)(70206006)(7696005)(26005)(2906002)(186003)(6666004)(40460700001)(6916009)(316002)(54906003)(356005)(2616005)(16526019)(426003)(86362001)(8676002)(82310400004)(1076003)(8936002)(5660300002)(47076005)(508600001)(4326008)(4744005)(336012)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 23:05:28.0741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada9221c-f3b7-4364-ebd9-08d9bc318e9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1781
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 963b58803ae5..18e59d635ca2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.164"
+#define DC_VER "3.2.166"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.32.0

