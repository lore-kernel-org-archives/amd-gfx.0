Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2203BC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06E661165
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E06E661165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B2A6E123;
	Fri, 29 Oct 2021 15:15:17 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE8B6E134
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTRAY4fEX9vYnw+OosdRE7LwvgwQpzCPBCPm0Lklx9vUDFp4JnGI99BvrakQNeKHCD7sXhEzZSLEGM1gcvhZbih1EaZICnIhI8DiEDPbqvS0N/KtiRWMlhviI2nidhNco7WAgIEktB3xKZNBYrA6HmmYL8TEYMNqJum4Cdey9/UEKFyECx6NzHhRlI6LWnBC+Bg7l11eGzD2K1YHcot1sBYrsSf/2z4dIIP+gDOYFuyr1hh8DUcLuoK14OziD8dW+6BurBXjpKg9kKoOO3R2YNUfyTGRkymRINiK/csRktFxeNNImK2KUlQtbKU6y+pm6yJZ7VcPt2tpq4qP9xjzPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Snad3lJ6P87ZRdklvzPylTu6YI9K7u9IzRdns62yVlk=;
 b=lgsnNGQbDxLXE4gf3AopAHnMKfN0XXSFXvKoLx83JoulxHx0cuyK13S+XikKtzHX9Y9qobHiYInstOj1A98Whme9T3WEWEKFJdGxnyY2776XcMJcX63yOfyThIVMWhOEaODag3oJ3Y1pMIZx99N2XhG0lwIyuQ7FU8Ajj6703cVDpkIFlKDZQ1CCBH1Awjvy5wECttxXeRC/IJ266f11iONkt/qlMmF7xw0Pj2zT+dxA0V3WkM5Z76Y+VQthN2Bvp8fGig7Mf9xnEUoG+W5A0wJNGrOY32qKZKFQgs+dyb+JkhQs41EES/Gm07EgnUurvi24oOHz09zWtXL3AgGWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Snad3lJ6P87ZRdklvzPylTu6YI9K7u9IzRdns62yVlk=;
 b=RNTx9U02P95+L8bEdWgVNyMNVn5xP0xm6BrnSCLEc36V5uULBynENFK8OQFwG+CdBBMWd5Qi76xi3c8vjRJ9G3AFpHCcUIZtVOBNjnqTKOVLKKFaVouviqMCcKWc0n+dXDFi/HeyCStp0cNylHz3YmqOBP+U9f6qSWqHQAewVXM=
Received: from BN6PR22CA0031.namprd22.prod.outlook.com (2603:10b6:404:37::17)
 by BL0PR12MB2548.namprd12.prod.outlook.com (2603:10b6:207:41::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:15:10 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::34) by BN6PR22CA0031.outlook.office365.com
 (2603:10b6:404:37::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:08 -0500
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:07 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Bing Guo <Bing.Guo@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 05/14] drm/amd/display: Fix bpc calculation for specific
 encodings
Date: Fri, 29 Oct 2021 11:14:47 -0400
Message-ID: <20211029151456.955294-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f0942b3-f9c1-4976-85e8-08d99aeee656
X-MS-TrafficTypeDiagnostic: BL0PR12MB2548:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2548A5F6901AC5A3669D606C8B879@BL0PR12MB2548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99VUF8afYTCAmR+2Z5srqQQpdSYUxTBlIfyu3sjJZFaJlJDozWInvUSVzHy0U58h9OuuD+5yKX/5Msi6mJX1twWusKJXhpblzqJo6Mcg2fZAnh+PgP6hAY10FiBkiVs+IGHIFd1RBVmIneRMvOT4vvUfQyN3PEf9fIhrzpQ7qKQrxvtxBKBe1KkayjdOxpt5L4f0A7NJSfms/EbPw/QlCLpV+RvAKNZImRizi4KHllvjbGVI2kfgL7tZ3abdHBI9DHRVvnSl0mSUjiZvnSmINTr6mvT2EtOF5D7aBZJxep0VXf+HqsGoP+DY1sMyIP1ju9M5Yla5yYyITq35qHmEvdHGLd5LmKYp3VSVJExNTCgcJUiHg+kad31xNHAihDQzF78FrLk+UCG70ckqNnBpP7vkG2WYbNLTI219Xj4NkKrTQSDbSeUJPj5q8UUDzcj1hO755Kejh44qnzh1QFnF7z7YHVmEyYzdGoPn8ZF7Lk+IqvV5d43d1U6rVjOEFsQI4dL42xcs+PGcomCsVvWv597BKy2O5JhlK9sE7f+F+whISHmrIqqGwZtNSakvMAYvgNgIbYsInfNhpZu604Ttz+xZquuQ3nfYXGTXFjl2wNc8j51WPaWOlQNCNrUfPEx9N7GS9KEGbHSQeSrKhrJvJYY0VQyyVa4c2l/p0H+FfXyySnQ2z18664GpIK9UgVt+j0FRgGd//6dYk7T/p4iXbLDrv/9txvI37aEidBcQOn4QFG+jX1CTkdKtz1wRhUPpSelp6hYfwSl1N2I/HjL7xA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(26005)(81166007)(2906002)(82310400003)(2616005)(426003)(1076003)(356005)(36860700001)(336012)(508600001)(36756003)(316002)(5660300002)(44832011)(6916009)(8936002)(47076005)(186003)(4326008)(54906003)(70206006)(70586007)(6666004)(83380400001)(8676002)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:10.6510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0942b3-f9c1-4976-85e8-08d99aeee656
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2548
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

From: Bing Guo <Bing.Guo@amd.com>

[Why]
1. YCbCr 4:2:2 8bpc/10bpc modes are blocked for HDMI by policy
2. A YCbCr 4:2:0 calculation error blocked some 4:2:0 timing modes

[How]
YCbCr 4:2:2 8bpc/10bpc modes are allowed for HDMI
Fix YCbCr 4:2:0 calculation error

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Bing Guo <Bing.Guo@amd.com>
Reviewed-by: Chris Park <chris.park@amd.com>
---
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c | 13 +++----------
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c | 14 +++++---------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index e3d9f1decdfc..f47d82da115c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3576,16 +3576,9 @@ static double TruncToValidBPP(
 		MinDSCBPP = 8;
 		MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16;
 	} else {
-		if (Output == dm_hdmi) {
-			NonDSCBPP0 = 24;
-			NonDSCBPP1 = 24;
-			NonDSCBPP2 = 24;
-		}
-		else {
-			NonDSCBPP0 = 16;
-			NonDSCBPP1 = 20;
-			NonDSCBPP2 = 24;
-		}
+		NonDSCBPP0 = 16;
+		NonDSCBPP1 = 20;
+		NonDSCBPP2 = 24;
 
 		if (Format == dm_n422) {
 			MinDSCBPP = 7;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index d58925cff420..7e937bdcea00 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -3892,15 +3892,11 @@ static double TruncToValidBPP(
 		MinDSCBPP = 8;
 		MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16;
 	} else {
-		if (Output == dm_hdmi) {
-			NonDSCBPP0 = 24;
-			NonDSCBPP1 = 24;
-			NonDSCBPP2 = 24;
-		} else {
-			NonDSCBPP0 = 16;
-			NonDSCBPP1 = 20;
-			NonDSCBPP2 = 24;
-		}
+
+		NonDSCBPP0 = 16;
+		NonDSCBPP1 = 20;
+		NonDSCBPP2 = 24;
+
 		if (Format == dm_n422) {
 			MinDSCBPP = 7;
 			MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
-- 
2.30.2

