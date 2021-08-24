Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE1FC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F8E61220
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1F8E61220
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3C589D6C;
	Tue, 24 Aug 2021 06:11:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF6089D6C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 06:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXJ/iKyeAMXvTS9we/T0GWY+M8ucLNtXuZTO+xNTTmyZaQLL+xdEtoil80TF+LkuL8wSc2VBGE80GpktKO0twlok+XXPFEpg5bbgbVP7VICGRv7HOzdv3U+HdG4YKwcT68bFm5hgB3zYoVEkUDkNlfD+t30k3Ib5oSSCoduF2N+nNXvqivCyRLcSqh0o3d7MqKjlVN4cvbkE+GsQRqRDepAsLmZAC2e1ubppH08651oloYmoVUj0L0bmA11jvjkthyUsJDucaWAwfn7axp2sVRLC7stb61SxD5th36873rkwmHZ6gFROBGEGoyhvu1m53zJ08+URTUqMtStqoVXEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqlfLaI7nF/QCNk6p+hRGwq1vgQLtWe/mAzATBnF1lA=;
 b=DKfSU2RcWVSKyAyuCiJjZcfzlfX5l4KzyhvZwufmMkhcW8vqhiI1E/pfBH6Xa/LWdMOpwP9XJwtm47cZ37qT9yArkwapWkrlrjRKxcmtA+W4GTdfVMrJKOrmKNsCSkt0E7FAeV9bKmYK94Yr8oIBKKyGYt6Y5/zbZM1q/MzJySlxZbJsPznU/GPprRFURuW3jgP1dg4rCZU5lpkFgl1tfbpp+x79mhZc4zlwiI/xQrC+4s80GGz5hNaB6SbeT7R7uyQkLjZs/U7pAX2DLnR8RtR/fElRyiTrHbdPnMzRka+28nyUULnOi8ur7FZp7UQsjCj/8LRI2eAzo/9jwrCOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqlfLaI7nF/QCNk6p+hRGwq1vgQLtWe/mAzATBnF1lA=;
 b=CrfRP9zS5TqppDB3AyiSW1RsjELQRw34cQp5WweF5xl0HFiP4xuLFNZCoaYlYQaINSvB+RnjCn3Z3fEgMYVnL3mYJ8y3Rta0Cwopk2ISJS/1QpYsTYZBl2Hr1ta0b5xHJXXg9rQBSFE0JJos6uzeuQoSpXFNrzZJ2B2Ft9+SLpg=
Received: from DM6PR03CA0048.namprd03.prod.outlook.com (2603:10b6:5:100::25)
 by CY4PR1201MB0214.namprd12.prod.outlook.com (2603:10b6:910:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 05:55:29 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::c9) by DM6PR03CA0048.outlook.office365.com
 (2603:10b6:5:100::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 05:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 05:55:29 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 00:55:25 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH 1/5] drm/sched:add new priority level
Date: Tue, 24 Aug 2021 11:25:06 +0530
Message-ID: <20210824055510.1189185-1-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ffe9329-ed28-4193-e543-08d966c3c6e8
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0214:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0214899BDD8614F546A96DB5F5C59@CY4PR1201MB0214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZqbReqgQ3Gt/jwwTdbYtXACrWhGhiPnRW+Rn4Tunl0R3Nv3xcaeULQhMXXG4/kZSoxkrZjCzLGhlfj/ecd+dUcj0wkpuGdM2xvur7+EfT8hpbeyFDw/uBMXGrMG1aqfvhOGAKaMEHTqqDD5ROMEVpYKDo4H8RnzYjAaVHlzHZaM9WCOEoFeI+J+GIQ50UWXaRch684tuqQuG83AC6VgJA9pAG2SLUmew67m2HLKl6b1pO9JTvg9Su3dj/gYaX+yiXxt+F6TI8UKVriRl8+ULtwzms0E9Vrog/czy0l7NGEJ2S4WDVxdoi4364g4tQw7h/4BHAO8dzRJkwgtDKHgXkMGzGX+7tEwmd84D5GsUaD+wr7aE6elMwf+Av/5OUthJ/E8VhPIpzKPd82uq8jGNDTI/cmiHwEvfA+O6JeQifQ4vS8814xuP6Ble2ivion3Zm09u7+zggQIXooOjVsFQz6xfeZzQY7DoOdrG8Yv5LDm6L2JX8NaaP42UbaLYvjd4os8hYrkpLOh+a2IRv0PsG/KLykbJ3aM79FnFDV0tb5Up6ijQRq5bQfzqC9OdPTsG81T7QFH/NL5gXKicZHQNk4sxUZcQcQOTRmAetMkewV0I4AKDS47SafvAYvxoKO1Xy6SlE0Xvjwg0DGmdsCtSDS4wNogwUa9UtypbfOu3vWVEdjRB36PWWSrTDfZxblNE1c+hi/MWwQn8WQUiCoJkv20WsnZNveY/nglzqqaVEuTow6suYQRGsI9y1qdaljd0JtrgWZ2TP88h+6kxz9Qrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(356005)(26005)(8676002)(82310400003)(47076005)(34020700004)(86362001)(478600001)(81166007)(5660300002)(36756003)(4326008)(6916009)(1076003)(6666004)(70586007)(336012)(36860700001)(70206006)(44832011)(7696005)(426003)(2616005)(2906002)(316002)(8936002)(82740400003)(186003)(16526019)(4744005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:55:29.0454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffe9329-ed28-4193-e543-08d966c3c6e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0214
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adding a new priority level DRM_SCHED_PRIORITY_VERY_HIGH

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 include/drm/gpu_scheduler.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index d18af49fd009..d0e5e234da5f 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -40,6 +40,7 @@ enum drm_sched_priority {
 	DRM_SCHED_PRIORITY_MIN,
 	DRM_SCHED_PRIORITY_NORMAL,
 	DRM_SCHED_PRIORITY_HIGH,
+	DRM_SCHED_PRIORITY_VERY_HIGH,
 	DRM_SCHED_PRIORITY_KERNEL,
 
 	DRM_SCHED_PRIORITY_COUNT,
-- 
2.25.1

