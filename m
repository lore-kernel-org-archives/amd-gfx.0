Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0249AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 769BB10E457;
	Fri, 10 Dec 2021 23:05:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D12A10E446
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exm61g40cqZFyWevljXUyfBI1Dj3fZ8oUqW8782WvWLUVXx/RH4dFd52MR7u5o6qwgpwM8teC2dHLNOhnR8rpV6y1Jvyx0IEy9Dd6DuLrWvcTX1yjofBdwyeTErgXa9ACIMuDqR+Lztd3HfiEwm/OJWummHPGjHIldcIam16KnfUvsmdaLzbwoXX/iVIPWXPiTouSgWxmZuY3a/iLCmjlL1YePlbecX40qoT7CDQM3BSAglWN+eOqVpBD7JM64ACcP/qfJdoJO0tUzm5Z8yGugcI9v6p3AReSAVo02qflA5tJyyAhQ5y0ZEzgVIq1QfsCF+bzC9cRGlptxj+P2Exww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSvj+ZltvaxDBMWE4LhsTihU3faSFqlNOc0C0lOvQgE=;
 b=BIolg6nZ7KoWoEqGeMm/otvdQZmcuWPPS6biyn+jPX5O4btSlqttriX57ssp+yByGzKKuNrrGBkGFmDSpQPOzEqqoj3fCV+M2t6f56B4G8jkHsGun/2RU7bdr35lDBht4Kc7khAo4xCz3agP4Q32kMNLc16H6QtaJZm9U+7h3PxwuewJEZhov/Pf3ukBDbHOOE+9KOSZoEJ3jLFwSNpDgvZkxrXzDDko9qNvswpQGmXpgJhjEhqH1VMEhs1VxKFdYLXEDgSgXROspU8SkuBfjce3Ys/A/ZG5A80MNRZZWzpa0g853c2N1lsRxpHeWX+/Lq3L1sxFxsz9fo8BPMGjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSvj+ZltvaxDBMWE4LhsTihU3faSFqlNOc0C0lOvQgE=;
 b=Bw+50rG1Kq6cAlDxXI6MJe8tRhGzHErwxCqkJRfsHDyl0Q8TatZ2EH6HhhcJwP4X2Z0vgGXvYWf+KDfBbWsXRl6Vle87K42dacQVWt4Pci7deZy3pYY6kw99zeJuWk4cwGMR6WWbQ5FcNNOejS4jrTVxVCXUhuFDBwOIcMyrxx0=
Received: from DM3PR12CA0044.namprd12.prod.outlook.com (2603:10b6:0:56::12) by
 BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Fri, 10 Dec 2021 23:05:15 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::d2) by DM3PR12CA0044.outlook.office365.com
 (2603:10b6:0:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 23:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 23:05:14 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 17:05:12 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/10] drm/amd/display: Add src/ext ID info for dummy service
Date: Fri, 10 Dec 2021 15:04:01 -0800
Message-ID: <20211210230408.619373-4-Pavle.Kotarac@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a80a7550-4a8b-4608-8d96-08d9bc3186ae
X-MS-TrafficTypeDiagnostic: BL1PR12MB5175:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5175DDD90D4F52C171FFCEEFFC719@BL1PR12MB5175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XyMxU4iRIFLtIkOgXsqgLPsqW6o2R7PtyVGrQrSKHvXrnvnLDiOqXZBmnbL4zw7dBdF1RWsnIrzTo5B73itBbJ+HTwUuXXqDMGO7K+3oFfbJlwRC2jtKMS/xNGtl3WaCctiQFxySPFyzUKOiP0NJSKbJNKaZgnzyRT3rPQu/7NUB8RXoYjR2V3p8rxkq+3DpvvPjmunhMAySXU4sp1KPSANsWvZ8TWDVpRr2cp3gNmeeUaY67NB/kfrDWnHK9kt4ksTTuuCDOG28KMTxB6uDM/k4mvjU8IlxuZIXlEjv1UoMLOEnyjvX5JA8A4kiCWUti+IK3y6cxjlUiyqfPJrljQixJeg0TZ3fBxG6bB1ljEkqrCtYktbO4q2WMtN02z+4WQMYb9ejUdEHCWYb96KP+yg6BnX222ZaTyBWrQiE1L3zusac/EuFycFtslvZmDP3tfnKx0MfSR5uJqNtTZa2BNQVPXHbhrzxkMuEKoOmwUq2XOH/qpclfiF2RXOnNSzRG7anPHAwhwQMKsWWmyCt8+39ZpY1ShOvMNrJd7f/8rPGhadECxhWGOdqXZ8cEm6Zftm3gZZgeelzD9SosRE+G2qWYkCPBkZcV/n/WOPN/jI30ArhfH6gd4IooYGiVC2sMbRrAgiFnSWB+lD3GI6dl3GNFiQMOGwCZtjEVtirNNi+ugWy4l9W92RUbALtgTqX5gv8pdGnpJa1zTe8IA0Ck52tqzlEM0GX/3qqa5TmfHbGjnFIvsM2C91aVvxoynwqK3IGiDrrEebFEwlHv4WMD6IA659ZSsnD9nckhzz51hI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(8936002)(86362001)(16526019)(336012)(26005)(8676002)(6666004)(83380400001)(356005)(70206006)(186003)(5660300002)(508600001)(54906003)(2906002)(36756003)(7696005)(36860700001)(6916009)(82310400004)(2616005)(70586007)(4326008)(81166007)(40460700001)(426003)(316002)(1076003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 23:05:14.7704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a80a7550-4a8b-4608-8d96-08d9bc3186ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Solomon Chiu <solomon.chiu@amd.com>

[Why]
Current error log of dummy irq service doesn't have
src/ext ID info in the log.

[How]
Add src/ext ID in ack/set of dummy irq service.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../drm/amd/display/dc/irq/dce110/irq_service_dce110.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
index 378cc11aa047..6b5fedd9ace0 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
@@ -185,16 +185,18 @@ bool dal_irq_service_dummy_set(struct irq_service *irq_service,
 			       const struct irq_source_info *info,
 			       bool enable)
 {
-	DC_LOG_ERROR("%s: called for non-implemented irq source\n",
-		     __func__);
+	DC_LOG_ERROR("%s: called for non-implemented irq source, src_id=%u, ext_id=%u\n",
+		     __func__, info->src_id, info->ext_id);
+
 	return false;
 }
 
 bool dal_irq_service_dummy_ack(struct irq_service *irq_service,
 			       const struct irq_source_info *info)
 {
-	DC_LOG_ERROR("%s: called for non-implemented irq source\n",
-		     __func__);
+	DC_LOG_ERROR("%s: called for non-implemented irq source, src_id=%u, ext_id=%u\n",
+		     __func__, info->src_id, info->ext_id);
+
 	return false;
 }
 
-- 
2.32.0

