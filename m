Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA9DC47073
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E80C10E68C;
	Wed, 10 Jan 2024 21:54:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E26910E68C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS4kRbpwU4ShludUAOrWH6y4qGef0xRwolWYrkwgnHr0RYbl87YkT0YxoTZjcTJw1uS9BPuNLVazeV4hKLM/iZkUKw2WeZeEb6Ru7gIYuKjdXpeULW2xcyeSh6zm4F2mIKtJNF2aNLxAV6YhGEuZV3sYcFWi87+EdT/jf0oFJYKcBD+kbb2l8qrt/R73/OSUwvfj6uinbCN4XlZK3B3cWwpW6by0Le+AHr/ypfrl9mDyBmyI/qxWoTd3+ujpfD8Dg0nnX0qpJGNT2B83O4Bzpj1s1fE+eMSAGEiOztwk4wb1JTXs3sQ+N3hqvl7i2xHEiVKtuYYBvve0cQJYu+BpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IeL6FgD8KoVacXKST66ho6BcHD9c1FgKRLTYk5XmWY=;
 b=PukTnENYkzUXinX50PhG2Jo8y0eBAigyfVBN3dOvQdZMDCWY3rN5u2NRhIZ5TBjR4UBH93ubjQuaiTecctl5f2QyONDkhOYA+mqtr5ptxHsbecshTC1nRAqhNeqfcqeSzcYbJBzUoDtnJqt5NIaTCK0YbYSS4jZPzINRRgaFUlep5byYqi+R3Kk8h4DldOnoMwY2mHwhGdUFcnjZIDeMuDI2q/zqZLgW88qiNMrGUy1f2LbCAVPXSx8qZaxWkYLgO/RdeAs8rm0leU2hzTUsujj5pVn+eW33W3SirRSOxhocokGxQCfbWnfCTKly5QbeCK7WWCeHa8niFwEO3cLhQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IeL6FgD8KoVacXKST66ho6BcHD9c1FgKRLTYk5XmWY=;
 b=RuVaF4qBpS53iE69tAeSOyJGFsiA0yjpeK0ZTY4+tbsY+CiKlZGzU5LcQL77d/W83ox0iLOUGEBnX0K4BDfkhP1XPU80IduDS9cXs+RewSKMROjcCt8YODfDzJsoH8ITpnUkNXYfc8nxPbZDmfOE9SmUcmFwDbj+Dy5LQgTIOy8=
Received: from SJ0PR03CA0298.namprd03.prod.outlook.com (2603:10b6:a03:39e::33)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 21:54:25 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::45) by SJ0PR03CA0298.outlook.office365.com
 (2603:10b6:a03:39e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 21:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 21:54:24 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:54:22 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/19] drm/amd/display: Add Replay IPS register for DMUB
 command table
Date: Wed, 10 Jan 2024 14:52:46 -0700
Message-ID: <20240110215302.2116049-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|MN2PR12MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 4264c81c-9c5b-4758-7362-08dc1226b5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMDeOonwwposbiUoVjCiqq/zbin06MkfSbrtzIvjtuJLtTHWxbbHQmWPZ1zGWa3BiSRDFeA77jQq5JF5rptRw4/hbvXVogfS7daKaHlSgOIkntbSiMnwMN/qguGjtrxDJ2HgDB6qpVw/KP+BURo64A7kGo6L3faOpZZIt1T3dEhsJK/4muxotgNcB2Kma6YTKe2gdwjDijhRvRr4c/A5tfL9dXs63hn+ILsi9mhTxlsARys+h9o0JaM80sTI1N2ObJgo8tTxgtZFtc41AxNnL2TbU3l+BAx+ZvSn1PfG96cevTI6wg4hF4y3cGbxlYjFr3Z8gbzMgOIpy6xiMZ1OiniUsLsclTP5EVEklROJihWCH6Zg4KSBEQb6Oiovl2ZLKTPtAz+TAqODRWFFyktpDhQMMY1mTFyV3ZGAPk9IW3hQOZkVB5ol2XiOYbsU+t0ApILfdSyO59uM3aqDQsRYpHFfPRRjtsvcn21W0O9Cvur3lWOfQYyEfGxchVWU2PW3tc1s0/EAC6nOwBQ46cw9iGxBVuC2OEmbNf1o6odqChMn5fYMDkAyL742eBqFGBBdMX4PFN3Lz+YNR/1AxsAhZujh7tggXjKU1H5h8LO4L3CQULEX+wTpvv9dcO54QTxQURgvfAgdtkVh2JH3o1F8JcvS3Qwkoa2KT6buReBLyxsOo4lL+yy+A7fXJYcPYzZt9CMLUp4kPELwJ8P0z6EEzHrkz6GLuoh0J59vtE6Oazu5VFAcxLa/P3fHoatrCoR7MGYkzt+RdhSjy3r2nZk8Cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(2906002)(5660300002)(6916009)(8936002)(36756003)(4326008)(316002)(70586007)(41300700001)(54906003)(70206006)(7696005)(86362001)(2616005)(6666004)(8676002)(478600001)(1076003)(26005)(426003)(336012)(356005)(47076005)(16526019)(44832011)(36860700001)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:54:24.8106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4264c81c-9c5b-4758-7362-08dc1226b5e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
 Martin Leung <martin.leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin
 Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

- Introduce a new Replay mode for DMUB version 0.0.199.0

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index c64b6c848ef7..bcd3c361cca5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2832,6 +2832,7 @@ struct dmub_rb_cmd_psr_set_power_opt {
 #define REPLAY_RESIDENCY_MODE_MASK             (0x1 << REPLAY_RESIDENCY_MODE_SHIFT)
 # define REPLAY_RESIDENCY_MODE_PHY             (0x0 << REPLAY_RESIDENCY_MODE_SHIFT)
 # define REPLAY_RESIDENCY_MODE_ALPM            (0x1 << REPLAY_RESIDENCY_MODE_SHIFT)
+# define REPLAY_RESIDENCY_MODE_IPS             0x10
 
 #define REPLAY_RESIDENCY_ENABLE_MASK           (0x1 << REPLAY_RESIDENCY_ENABLE_SHIFT)
 # define REPLAY_RESIDENCY_DISABLE              (0x0 << REPLAY_RESIDENCY_ENABLE_SHIFT)
-- 
2.34.1

