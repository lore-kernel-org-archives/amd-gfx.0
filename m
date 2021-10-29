Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D6EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B4AF61175
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B4AF61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B20946E150;
	Fri, 29 Oct 2021 15:15:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432396E139
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqtQdfkq6VeWiSC0LUfpdbtaINv1X23tuMGWt1KTA4Kb0+FdciCCPbdVm68ei96EAGz3UIyc4eL4D+yyWufpQ0Y9/a6oLhBIFHoIvCHG0MZROQtgevh8H6RiI/Gqub3Dlh4jqr3nxB/ar6If7FhaYO/AJVn5KMMprS1OE3+5oVl4MNYJvcazy/yxav9FKxbXFfiA0lwcEPbP79aPOKlE3AqCzjQhYhirxkq8c3EKaFksBWMPhYKm8I+YgM93bJbOpbkdp/7nfsnT023H0410kowTVpx1yZ7C6LvzKBzfi/HdaxVW7+z5mTlvg6yRyp0GNHmn7HUKZfqv1rDMGod5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12w9OxXdbr58irTKjmfvY0W2njcHv5pbkLWx5TpWvQY=;
 b=Su+1JhqBZpTUqpZ2aR2vuS2EhgbP/oMAOR2nM6HDH0sqyJg9Q4KbZX4CvJSHav1V8bZ4CSG1FxWX2sdlrNZjy1wHZz4CmxVeTeepoUbgBpWEzk8u313RfEpYXGPmsgV39ZmP3fw7FpSIwp/NWT88JyPITS/ioIDFLtBczqrnKi4jdgLK19sVz8UwTNx2M/VV0vweV+VXcQjsbVoKTXrklSKfEZb46ApQSuoTuEGXP8ADlHAtiUxtiXBMU2fAzQcofcDLxgfdGsFZsK0hGrMzDC4t/23ZI/6TZceGVfzvg6Sa+pbwFixIeR4OhgOOdJYIHQ4K6h7XhHz0d9t6S2HNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12w9OxXdbr58irTKjmfvY0W2njcHv5pbkLWx5TpWvQY=;
 b=xdX5oedN9QYM+c57zfwNnV9V5qNQcEpNaToiVJSh0ksrBE54LUcW1dfpAG7kkZUJ6bLbeEVYT5rP2lcDR1ti2+6rw/iSYEDoQ0H6mxfWh0WcQrO3s0SKeFBfad0MAhKrLAr3t20vnohcJ22XFU7+SGPjPKl1M0R/m6lH7VOCkWA=
Received: from BN9PR03CA0761.namprd03.prod.outlook.com (2603:10b6:408:13a::16)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 15:15:40 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::73) by BN9PR03CA0761.outlook.office365.com
 (2603:10b6:408:13a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:15:29 -0700
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 14/14] drm/amd/display: 3.2.160
Date: Fri, 29 Oct 2021 11:14:56 -0400
Message-ID: <20211029151456.955294-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 516c3d8a-65f1-40df-f252-08d99aeef816
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4110527FB06DEFC8278543D58B879@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFYWxttX5u2jOsss9Ko7rT2y36whfxZOYG/gDCgA5NOIuFvg1RI/eVS6Ok6qwU8EEtn/YP6VxwjM5ksx+I1rt339zyGKgl+AdEHTfTeDjni6FFP46E6T0Z7fQGx4Tux24Tghob9UOVqGX47355mDNR2U7zC3LLMTwblYGQ1L1tFymvvyu1RDfgl/TTCVrbKmZWtOKQwCDW43+LllNscjKaqmWBSW0IeHI+FnpAf11X+rG4HGe1D/06E4HFk21372wzJ3KhB0xOmUUkaeSa020l+0MQzxMZm85Xk+dVEBBkIQEUF4ATI9sRoFlrvOQG+JJnTTvcQQWXRWS0rddR1ofLSrfnv7VvXrlee6yMqb+7sapsZwjZr5pz0oLusduqoLLgG2Dysd7uLn1dfxQsNV4oqnnI3sHLobMLn7BzQ2gViuhHbgRb/nUxfVeWLnqedY40CsuhS5SWV26AiIuVTa7pZmeV+nLKzB9/ONXRJyGAxGf7c0CSCeQxV49a7kuX3zk7QdSSpvc5px73Upohw4E+R7l24Z4uTQsL5KIJaAQOL3LhDmLirTrZNQohDy2P973rG9IueCHcpu03Ha3Qq6yaJ/a8heT3hJ4segMBP2s127AUOg0XoSbpLHAA+g7DYQEDiTmVH7M2azdurQx3j+fYfFjsHwhqZD3PZ548wgQ3o/MDyWv28IEQek5xzSlRn+payrZVHAYUVsqkwS7Uyelincb8prXF3ZQb3TMItGAmRdcv18j0W/uZm3W4CQzMr896dNBCVOcjqe+8QxMk5sPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(8676002)(1076003)(426003)(2616005)(316002)(36756003)(8936002)(70206006)(356005)(336012)(26005)(86362001)(6916009)(70586007)(83380400001)(81166007)(44832011)(186003)(5660300002)(82310400003)(508600001)(2906002)(4326008)(47076005)(4744005)(54906003)(36860700001)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:40.4353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 516c3d8a-65f1-40df-f252-08d99aeef816
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e9bac161fd25..3aac3f4a2852 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.159"
+#define DC_VER "3.2.160"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.30.2

