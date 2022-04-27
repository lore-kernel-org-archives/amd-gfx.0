Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596A4C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 03:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05AF10F3BD;
	Wed, 27 Apr 2022 03:01:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0036F10F3BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 03:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QabL/6ORGer+TPmIiW3EGgOVD4KTpRlwP3xP0m17Zju03RjVSrczLzpb8ZEeRspRE9rJuIcFZfRZz3jdpqxUOPGJVSp5DoKExEmTE2Zeyt6fkM+oyKRGEPUvXB3H4C7M39GXC/A/qbOLYTzJUj1rrHDDM7Boaj/O4RuoYmSM5p/Hyuy7Iq7gzOC08IaSJDBhYnK/XH/bT/gfJm4zDnAesb+Vr0nXgdYeC8JRD5CzFn/zlaRhHi1ml6b8ZXMXTQ/ewxJYIfwTCnQcj/knUgWBLcfvcP/klt4nkNCFcP/nlBhZqh6ZAPnRVqS56j5ycY3IZO/BvvK9e7izIxNd72+rWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44nmuSzk/M29kaGM7djTY+/Qk9Q/vhfPMFD9S4q8lQM=;
 b=NKa+liBwXP/U5NpqGdSrbNJ3ulAEdScNF9dZ/xPDCvPG0Jj/NQ4bbUia26X+rLG+KEzeEcd0hj55IXrNhpIiAIGP+nRkbqgWG6DNyeLPIO1t1SiS1p1v+eqaNhjdDiG69k9H2nPcpXGccOVsBqA5nwVl54asoM+K+OKTshodYm6DjEEDL39PeXvvwnNR7wsTLvLq+a7rbV911d2LoknXaxXRNevHuzMyBgGkUaCs99m+p+Mv46UHXX/6QwN049bxzeRN9u6+pNkzoqV//LDGB6AKMJEAfNMxOWDQlnIRXqrabQ54mnH5Z5aLjbNLOWHei5A9REnSDdx7p3TVwVg87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44nmuSzk/M29kaGM7djTY+/Qk9Q/vhfPMFD9S4q8lQM=;
 b=Xcd8t7aaGg9G2lBU2zfnMEhi3nctlLZ5DofZeVUbRMET+h6HRe9XwGVf2SR95n6nOIX9aNWtulKKNFHxPcXCoHpz1d3XIOb9hM8T5LNsg8L0YKiJV7lP8316VV3YWvbi6nA17c2nzFEYlJq5s7zbAlTxLICE26Ix8Y1vdu08aUc=
Received: from BN7PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:20::45)
 by MN2PR12MB4781.namprd12.prod.outlook.com (2603:10b6:208:38::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Wed, 27 Apr
 2022 03:01:37 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::5e) by BN7PR02CA0032.outlook.office365.com
 (2603:10b6:408:20::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 27 Apr 2022 03:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 03:01:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 22:01:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 22:01:35 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 22:01:31 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] Revert "drm/amd/display: Reset cached PSR parameters
 after hibernate"
Date: Wed, 27 Apr 2022 11:00:54 +0800
Message-ID: <20220427030059.1242868-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427030059.1242868-1-Wayne.Lin@amd.com>
References: <20220427030059.1242868-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5a8f4d7-c7e1-4ef2-4448-08da27fa3e78
X-MS-TrafficTypeDiagnostic: MN2PR12MB4781:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB47819C965223715E17DC35ACFCFA9@MN2PR12MB4781.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvEYLCOzO8EFIg1Mg3cTXyslTXWkjvHyq2Y/Pf9YHsEexNdNR4x77fN5P5UudQPE7M747twNxVWwGNyZpOactuTJzOZT8WvVhvqnwPub5rpkaLaGQJkRS/eTyJZY8bmHC7og8GW4tnzfjqqPckiB5cdqxO4uNHFUF4cVfPDHxUMm4smIbYsC8O1NzoV7IdoEK8X8Rp8ZHOuGzw+CTyrhd4xYcifowTCd0NTkQIXdU9tOA/3XqcWn5hkHl0a6B9okQ3q+3gz+IO/AN3XfyclfwVBk8hxxSAP9EHFY8UOhh6aXVBOz75dNPjltS1Rmfmco5FKxF/6PxMz/5dO+PEqM5ZGj2p3tsoHtX/UkkJyi2g/Jz0UGGLg2MZ5DrAlV2Pf6l7+FaLD2cx+l77xfAk4ZJfTAlB/H3Y/gC12M5i5POs+ELWo1+JALExEI5uSrIyGPFTr0g6zXvf+explvOPLtY22CpPGOlXmIK49fiDpYPmTZHj8p7yurhYErYAGJEj7wtfbI7gaYp4kErIlouRaR7HLhRnljxANFi1ye7CS4O6taCLcWWLY74B78xdCkoJG0k9Xvjb/NWtplr7AvspWByFZBBjanijTHyWtYpaUaYD35mxbH88Y2wgosl4cfIseClgH0TUP6QSDAzArjfBJYbuJRgOiqBUtmJopfDBVcZdn60yjbP4QXNIuPHaECG4brfCTrKIRJ4NBlZJnKywUc1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(7696005)(26005)(6916009)(70586007)(70206006)(83380400001)(8676002)(508600001)(4326008)(82310400005)(36860700001)(316002)(81166007)(356005)(40460700003)(54906003)(6666004)(36756003)(426003)(2906002)(47076005)(336012)(1076003)(186003)(8936002)(5660300002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 03:01:36.9098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a8f4d7-c7e1-4ef2-4448-08da27fa3e78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4781
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
Cc: stylon.wang@amd.com, Jayendran Ramani <Jayendran.Ramani@amd.com>,
 Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Harry Vanzylldejong <Harry.Vanzylldejong@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>

This reverts commit cee342f2d6a8b57ef8209720d5892d0ee22fd3c8.

Commit cee342f2d6a8 ("drm/amd/display: Reset cached PSR parameters
after hibernate") causes a system hang when game resolution is
changed. Revert it.

Reviewed-by: Jayendran Ramani <Jayendran.Ramani@amd.com>
Reviewed-by: Harry Vanzylldejong <Harry.Vanzylldejong@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 1eddf2785153..3d13ee32a3db 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3317,14 +3317,9 @@ bool dc_link_setup_psr(struct dc_link *link,
 	 */
 	psr_context->frame_delay = 0;
 
-	if (psr) {
+	if (psr)
 		link->psr_settings.psr_feature_enabled = psr->funcs->psr_copy_settings(psr,
 			link, psr_context, panel_inst);
-		if (link->psr_settings.psr_feature_enabled) {
-			link->psr_settings.psr_power_opt = 0;
-			link->psr_settings.psr_allow_active = 0;
-		}
-	}
 	else
 		link->psr_settings.psr_feature_enabled = dmcu->funcs->setup_psr(dmcu, link, psr_context);
 
-- 
2.36.0

