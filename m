Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B2CC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964A6206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zBdLQ52w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964A6206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1806E95B;
	Thu, 30 Jul 2020 19:12:37 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680050.outbound.protection.outlook.com [40.107.68.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29626E95B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNKQsKo8EbbGcAbbzRmDHI4I2BWj2CdE4w2trsneIfd8hxmVeqjLGHroHtLc4dyQF/ZCk0ln3ECfqvskMa1cnUwkBSHGf+U1tVh+nsIDWLncbXJqZ6K1PrILIrSpdagsDUdbjLwLq9deaf8XzFoqVEiDeXYvdGBOM4knYe9ln4cmy67oFDb+C5rgkH2f/DgHavC4KY/PP6zfrY6aCBpORIwoaZcoj1J1BXAXM0/CwFhRU4G1J0wxqJpG7vuA4H3AftWwER13FVEXvY2tU8/11mJk7opYeIiMhCiLqvD8TrjJuo4WI0Wbk4/kdO4Qb25envBEzm/Wj5QNN5M+8cuK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm9bry3yCww284Hjz048NyEtrnhtdZkjuqoz3jt+N9Q=;
 b=PpCkGf78N6r5cUUpIWp4hipUk88eoxxozZk/VYaWwQbDOZewYTv72r1Y8J/Y9i9AUWMw6EBqUnlTAtrvKZWC+NGY5ziuPGF67cvuBfEBoM10qBRww0Toq5ijD/0MHrk62ZpGeYReSz3jLWy8elk7BsC/GwbBLr4Y/dT7X4mTQk8qNUfG8MAqIQgLMKG6kkz0lEprfyuZsA/FzEwUxn41mh94x2+1w5zCXUCwtWOaSjGmeDHNw9WnEaobXWWJVhGGmfep7sUfAoWM3FhhH/HdnIlT1FRz+V8q44O5zbnlRuYR3tTMQ5keEMca01YsGqMTv4B8UQHjnCqimnGmCOLEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm9bry3yCww284Hjz048NyEtrnhtdZkjuqoz3jt+N9Q=;
 b=zBdLQ52wBiEGRT97/ZuJRsot8IdIFL2cMh2yno+ZqBhLAjM3STKo6aCFeUk1WhQXnwlL8UbmrQ7xuP6gY9zV3n26sMi6slKWFgtpaKHwAVqOdzNi9n31H4K3VLf5qbE9E3bGPpqcYDJuCHLDDHFp4HkW0aKeCd3rcrUcFr90u0Q=
Received: from BN0PR02CA0050.namprd02.prod.outlook.com (2603:10b6:408:e5::25)
 by DM6PR12MB3995.namprd12.prod.outlook.com (2603:10b6:5:1c6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 30 Jul
 2020 19:12:31 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::d) by BN0PR02CA0050.outlook.office365.com
 (2603:10b6:408:e5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 19:12:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:30 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:30 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:19 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Comments on how to use DSC debugfs
 some entries
Date: Thu, 30 Jul 2020 15:11:38 -0400
Message-ID: <20200730191146.33112-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c62b0858-58e1-4e3f-2008-08d834bc81cd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3995:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3995EAF271E2CCFDBD3E357A8B710@DM6PR12MB3995.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4ngM6g9xW7+L8FddWqeonNl2lD7HKtYpuXHV22NkrUDFK2MhjL4vNqeu0Mh/I+ARbHpdN1Pd3OF3cOa/OLS7dzpwY+/Tn1aVLTA0ilzHbxKwa5SevxAYt9r4/LF41ot6McLMIwWB3TfYl2ryl/mdNZC5miwjnfbR2CUR4vN2fXNY6j//u3I15FFOxR7aI5LxgosPrm943hs3QeTi8ks4GKwlxh4GrXhbaD06HNxqxYkng1SFBhElgxJ41dWTfiaO/YJwe9bri8qeT9daPV5TSmirFb4drBhQgEq37nh5LBRfI7kxtyobsKuMfGn+Q2/tiV6jhNJFcgJKkHo2OtVp+Fq2gvFAxLUSCw90atsJAcz5m7XgTcsOB/VjZWbum2rjZjmYKI6ZhNCVr8+YkAruA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966005)(478600001)(356005)(82310400002)(54906003)(86362001)(316002)(7696005)(186003)(26005)(44832011)(81166007)(2616005)(5660300002)(8936002)(47076004)(36756003)(8676002)(6916009)(70586007)(70206006)(4326008)(6666004)(2906002)(83380400001)(1076003)(336012)(426003)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:30.8685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c62b0858-58e1-4e3f-2008-08d834bc81cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3995
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <Mikita.Lipski@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[why]
Some of the DSC debugfs read enteries are missing comments
explaining how to use and how to comprehend the results.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 33e87f508991..4f6393332c7a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1583,6 +1583,21 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 	return size;
 }
 
+/* function: read DSC picture width parameter on the connector
+ *
+ * The read function: dp_dsc_pic_width_read
+ * returns dsc picture width used in the current configuration
+ * It is the same as h_addressable of the current
+ * display's timing
+ * The return is an integer: 0 or other positive integer
+ * If 0 then DSC is disabled.
+ *
+ * Access it with the following command:
+ *
+ *	cat /sys/kernel/debug/dri/0/DP-X/dsc_pic_width
+ *
+ * 0 - means that DSC is disabled
+ */
 static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
@@ -1697,6 +1712,21 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 	return result;
 }
 
+/* function: read DSC chunk size parameter on the connector
+ *
+ * The read function: dp_dsc_chunk_size_read
+ * returns dsc chunk size set in the current configuration
+ * The value is calculated automatically by DSC code
+ * and depends on slice parameters and bpp target rate
+ * The return is an integer: 0 or other positive integer
+ * If 0 then DSC is disabled.
+ *
+ * Access it with the following command:
+ *
+ *	cat /sys/kernel/debug/dri/0/DP-X/dsc_chunk_size
+ *
+ * 0 - means that DSC is disabled
+ */
 static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
@@ -1754,6 +1784,21 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 	return result;
 }
 
+/* function: read DSC slice bpg offset on the connector
+ *
+ * The read function: dp_dsc_slice_bpg_offset_read
+ * returns dsc bpg slice offset set in the current configuration
+ * The value is calculated automatically by DSC code
+ * and depends on slice parameters and bpp target rate
+ * The return is an integer: 0 or other positive integer
+ * If 0 then DSC is disabled.
+ *
+ * Access it with the following command:
+ *
+ *	cat /sys/kernel/debug/dri/0/DP-X/dsc_slice_bpg_offset
+ *
+ * 0 - means that DSC is disabled
+ */
 static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
