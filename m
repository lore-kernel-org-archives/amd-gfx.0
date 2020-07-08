Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF20C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 18:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B546E206A1
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 18:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bsK1GTtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B546E206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600666E90E;
	Wed,  8 Jul 2020 18:59:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205196E90E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 18:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LudI/TqHfcIa7Y/xsUupIWKXc1ImZ3RB69X21eI1vXgTmCB0w4SlHgOhEfdcPt09fFjrbHPHyK83/hNM/NKGOUIZMEAbXgqVUpA6/t3v47vvpre5ZlT5TeMH6N1gmp30PKcwFxgrAA6hGd9sbjBbSJlwmsxR/y1G2pjA6d6rEzW6XM98aczQ8SeIXDWG2XTRBrCI5otQ8MMhag76dBznRsyQjTitqthSdyUqKkEDkKZztUtU021PLrFIdaFmAepKiAEzdpWkjkCHUPCi9+yQeg80UbNdcjW5XmyNq28BIMy2LXCR8kKq7QyBb3k1LnWhFPIZhj+5Qp9USfz1iZ50dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM6KBKyISBUlmndthQx9c53+ME3vodF704zfWNvE8p8=;
 b=AiXbdW9JTqCQ3k/O5bvr+yzam9RST/K4i4gGgUmzzzV39XDuogiWU3ljZDN2ybqKHO2U0r3Wc2EgGxD7LIMwZ064ei4DYaUqTdXeWIE+vtLFlY21zXkbUdeX340KdLJbA6gXDYFNA3f5IL6Vxp1OvWAmfL/ft/y6PT1Bdhyjvooqm7zMvFt2NAFCr3e+y9ETgJt3rHBA9d/trNTVf7fWauI/0N5D5bfjkgrP0hhV0nYymlTiK275c2hx+ajuXUs02D1S2lmU9HTy75cKFnpYWpEh6vBHS6+IM7/7KxDDFxLyzaL/a3s663EKSBnn+Ug8IgCfoukj14tgUPIrdEzz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM6KBKyISBUlmndthQx9c53+ME3vodF704zfWNvE8p8=;
 b=bsK1GTtjwa7ld3viC3IvM7GNeipsa9DgyNxssQXjF+sstR7j4E+hixCRIoP8wkNDBn4Qc206qDDcAnKlAFVcodZXVwFU6Rw6/kGYB7Knl9J56NDj0s71mdZjgC68kZpuEejGliTUzhH6eSSyb0FUjZWOg97jf7XD3pVLURigSrM=
Received: from BN6PR12CA0035.namprd12.prod.outlook.com (2603:10b6:405:70::21)
 by BN6PR12MB1491.namprd12.prod.outlook.com (2603:10b6:405:5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 18:59:17 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::33) by BN6PR12CA0035.outlook.office365.com
 (2603:10b6:405:70::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Wed, 8 Jul 2020 18:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 18:59:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jul 2020
 13:59:17 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jul 2020
 13:59:17 -0500
Received: from DESKTOP-3JO4JG6.localdomain (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 8 Jul 2020 13:59:16 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Use VUPDATE_NO_LOCK instead of VUPDATE for
 dcn30
Date: Wed, 8 Jul 2020 14:59:12 -0400
Message-ID: <20200708185912.28731-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966005)(2906002)(36756003)(70206006)(356005)(82310400002)(1076003)(186003)(70586007)(6916009)(54906003)(8676002)(478600001)(8936002)(86362001)(81166007)(83380400001)(82740400003)(47076004)(316002)(426003)(336012)(2616005)(44832011)(6666004)(4326008)(26005)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b306e84a-862b-4199-f57c-08d8237103f0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1491:
X-Microsoft-Antispam-PRVS: <BN6PR12MB14914F316E5F575257D846F4EC670@BN6PR12MB1491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHmcn+v89Y+S6F4Rceir4evSrlj6zdxAgUqGJpFqGFy+NsxR3/i2wUw0krpBoFIKKHLP5e5NuJF/f5qqm+6CjVCWP30xQFoVvnpY9qevvLGX60jAsg3b1cNRd+UlW8U/C/cqKExf7NT/BAK38AuYdyXnPB+bVdzWFTorRSkxKkCYbCPvcJI5abT/IW5dGn9r2EGIGg0xJxky0fmU2H7UZXyRZbhs9FlPoJ/oceOwsPFmqZFuQFd98luwQtT1u0lyZUKk1WM4HhIxw9Cn4piGUkkBcM2+4smPa0HGj1AB9S2MsPzqMkXov3G6jEHyxzHDhegvQ7aLQ17qZteQz6UiWgP3uBIixLPj8DdZs23CY1022UuRnk4ZG4n/91ghP3dnYg5aKdyYji0Jva1QTBuqOA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 18:59:17.6895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b306e84a-862b-4199-f57c-08d8237103f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1491
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Soft hangs occur when FreeSync is engaged since we utilize VUPDATE
(which doesn't fire when holding the pipe lock) to send back vblank
events when FreeSync is active.

[How]
The alternative (working) interrupt source for this mechanism is
VUPDATE_NO_LOCK. We already use this all other DCN revisions so align
dcn30 with those as well.

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/irq/dcn30/irq_service_dcn30.c  | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index dd4d7a1dc3b6..49689f71f4f1 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -169,6 +169,11 @@ static const struct irq_source_info_funcs pflip_irq_info_funcs = {
 	.ack = NULL
 };
 
+static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
@@ -228,12 +233,15 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 		.funcs = &pflip_irq_info_funcs\
 	}
 
-#define vupdate_int_entry(reg_num)\
+/* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match semantic
+ * of DCE's DC_IRQ_SOURCE_VUPDATEx.
+ */
+#define vupdate_no_lock_int_entry(reg_num)\
 	[DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
 		IRQ_REG_ENTRY(OTG, reg_num,\
-			OTG_GLOBAL_SYNC_STATUS, VUPDATE_INT_EN,\
-			OTG_GLOBAL_SYNC_STATUS, VUPDATE_EVENT_CLEAR),\
-		.funcs = &vblank_irq_info_funcs\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_EVENT_CLEAR),\
+		.funcs = &vupdate_no_lock_irq_info_funcs\
 	}
 
 #define vblank_int_entry(reg_num)\
@@ -340,12 +348,12 @@ irq_source_info_dcn30[DAL_IRQ_SOURCES_NUMBER] = {
 	dc_underflow_int_entry(6),
 	[DC_IRQ_SOURCE_DMCU_SCP] = dummy_irq_entry(),
 	[DC_IRQ_SOURCE_VBIOS_SW] = dummy_irq_entry(),
-	vupdate_int_entry(0),
-	vupdate_int_entry(1),
-	vupdate_int_entry(2),
-	vupdate_int_entry(3),
-	vupdate_int_entry(4),
-	vupdate_int_entry(5),
+	vupdate_no_lock_int_entry(0),
+	vupdate_no_lock_int_entry(1),
+	vupdate_no_lock_int_entry(2),
+	vupdate_no_lock_int_entry(3),
+	vupdate_no_lock_int_entry(4),
+	vupdate_no_lock_int_entry(5),
 	vblank_int_entry(0),
 	vblank_int_entry(1),
 	vblank_int_entry(2),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
