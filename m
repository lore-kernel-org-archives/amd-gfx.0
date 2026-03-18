Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887A0FED9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A34410E5EF;
	Wed, 18 Mar 2026 01:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MHbYa7sr";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 233C010E5EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVrd8iY9voLAlvvEwWdCBbnG/6iYgDMr2X2kBSVDtN+algzSicy6NRbVrj0gXBSCLvDs/+A7vJr5UDtVYVhyO634VwDj5LgLn3lu8Tbz1KMSsX7ry8qfuYHHgU7/oOHyi+0Ak4NRuCUB2BH8A3V8dQ9KvK1wXAvXqryZSMp2CYUNOAv/aafrg0Z3TZUtlwo357Z1Bqkn/M1elxlST7Nu2fH3dDGnOA0qGI7whI1SdQl71iZ4NqL2+WSwJKWPDbQzmHsv0TJ2fvA3NwSsG4wuiEhmrg1379pvNUbT99unu9OhsBn8Wv//XrIoQFohZVsm91TpQ6DQm3yNEFNMo3RP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xK5JNnY/5A7JkRImeWfF+es09Rgs6MyR/qhAnVfeuLY=;
 b=baiaoO82HixASeHN3t6UhZHWyoHAav82rsKMGmgo+P8w3btHQPydMBNb/qjLXRbpzM4hHLp+cfZITA2mkosyhhavsOcc9nzCrL7jPo1pAjNt1UAlTuzuSyDe3HAjNvffah/1gyUEagiwDcGhds2U4qfTkfRsk5WeKZADilo3p+FTG0UWKo6GznFb2TQtRhNhfp3f5RY+8PWrH1SPpEZaaSYT1TaAr2Cw5xAd/2NwCPuYdK+r20dGklFfKCmkQkCyT9nbwtZ2m3pRxKdGqnIwBBLGqx7vd7NkcKA6Exw+9NVdrkJda5CZ3vKnrHdEsgDQSf0rFAaVoAx1FdPtTAhbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xK5JNnY/5A7JkRImeWfF+es09Rgs6MyR/qhAnVfeuLY=;
 b=MHbYa7srFX4GphrXIU/lQF66uFkiaLF+Iwd5wgKt2N0FEyGK5in4bxevjD272xf2PNORvcN+h1/r2OJPltJNGZDD0W82n/G86ckKTXRfAlHwgCABUwK/pcHspdVZxaIiQYl/9NdIzMQH5N/bJKz2hbeulSHoP6j//dkB5sTyRHQ=
Received: from SN6PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:805:106::31) by DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:01:19 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::a6) by SN6PR2101CA0021.outlook.office365.com
 (2603:10b6:805:106::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.6 via Frontend Transport; Wed,
 18 Mar 2026 01:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:19 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:15 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Chen
 <leo.chen@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>
Subject: [PATCH 05/31] drm/amd/display: System Hang When System enters to S0i3
 w/ iGPU
Date: Wed, 18 Mar 2026 08:59:14 +0800
Message-ID: <20260318010224.513094-6-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 3705bfd8-d063-42df-382c-08de8489dd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9mxAvyl/b4pSFwxDyN3PHpQ3m6+1+AazsFWvCBeS5DsJfYU2GmMjI7pmcisF7iZkDpo00hQrwVQdSdTbfCOrtD59FRwu7m1Kzaqg01j8pWurBhmA9efGO2woT61Q//voSy8Cos2LcEmq7KtfnxRpkod04J9UoFHj/wEinrV0PLtxuxdNAkJtznEFyhyDdHyWH026eNan9JSHDD+yZ0d5Oz4orwIQzRQuGgHJ0dhZleU64i207yzPrJC3LkKyw5ITRdeNNs+glmENN3xPH+SQS4kXI+5DrahLRsW1fa11/eS7tpz3bAJBg9pBeAmdtUKWydfPbVCnN58VOJnJ4lQiUvyRRTPjdHdkrKYPdsPzHLD5jqLMDBGXwKwNYkPD8ywVefu/51izAdasF//SbAUXXkw9VkO/7MPz2tj65ta/XV+Ea0UF/t3Vbwac6wQZxIHSJWgJ3y3/L4/56Vnpwwd9riVoCiresy3lGAyBGWffP75/aW+hucY741syJlnOJEZhlNnXQz9oRi89NGW/kPGCvXOKyaikm5y6LrAJOUkfafcfxmUGYH/v86Jc4sQ5hD19H/jg+t/1bq7do0380Pi4pisGvEZg7Fc6RRL0EWK8Uq3zyNR5QV3XKGEkAkqW/Ejsd6vZts5QEqxqEK8/rndkLaKXr6whQ3gUxKMaqNIGxG9djQMg5Tj5SsBH52CyX8Z3jivt6If/NOdBPycNibllN73qxmwlrT5y/IPMB3e/OSn/SV9ue2+ITf7/qJU3wap/+nrBqdEaGPb+aNKhc250sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4O4yhOI1KWE3LYm/+eNRFwvcZ5OAkuY12BWQVr6lTViZ4bj9geW600sR6PsmV3HDshsSytxPpSNgaUMOn5BAWUkGOVO0PSVMb/XfwIw9MGOuQSIwpPA22OWrgn74PYh5CCpzPsmPzsdGXGYp0yOeTOSVggb0ZBJYPu4j7pqgf1AbWhhg76euNINeowcnHKBBKwUODJku/jt653QWlp6eW6SEZRiBBs1AlA9jvUOyiF19b0pLwkgcbcawIiVItMaZdGCnSSF3qOb9N9Fi+q3HRyyAIRiHZcM5QevYZxDZrK8aPsX7HTPfL3BHdJx2Pe8GseJ9g25QWxHRbUG1i1XXTzmvWLPIZ7HfbZiZjVJKhLtjmb62cc4CQVWoguho2lhn2ggufXnC3rR9SAFgAadqLw6l69pjoHEsC34F67TqnJr4Ok9uq7+1KW43WsmQcOJ7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:19.0691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3705bfd8-d063-42df-382c-08de8489dd47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
System Hang when system enters to S0i3 w/ iGPU
some link_enc are NULL due to BIOS integration info table not correct,
but driver should have enough null pointer protection.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index 8e12dc1297c4..7bf94eae30a6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -203,7 +203,8 @@ void dcn42_init_hw(struct dc *dc)
 			for (i = 0; i < dc->link_count; i++) {
 				struct dc_link *link = dc->links[i];
 
-				if (link->link_enc->funcs->is_dig_enabled &&
+				if (link && link->link_enc &&
+					link->link_enc->funcs->is_dig_enabled &&
 						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
 						hws->funcs.power_down) {
 					hws->funcs.power_down(dc);
-- 
2.43.0

