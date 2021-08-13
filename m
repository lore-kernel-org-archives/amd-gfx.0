Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978BCC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D5F60240
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66D5F60240
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128A06E519;
	Fri, 13 Aug 2021 06:35:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8796E519
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iS7vW2x994bZHb90oZdmp5FRqKu2uI2H/w3ZhEjo0c/xQpiLpuOu2EjyjF9AlpBldqeUjLBTogemAJebW5XhMRyGIiiq84yjFgiZvtDCVJfa1mZP6XCmzahn0WJiyIfWML09gHkCokKJB9zKga1KoJWlHPmncO0z34tGBARPQzNgahhpbqSbXpB3gVEuK6W6mD+htegpQgghKxD+4CgWiHTyNR955Mt+YqosvzQ3XxLa+mmsxjg9jYtKNTtg7eW4SXAfyCyIXl9jVcp1EbFOK97a2BuqXMf3I4cFycWFM/QY/YDFgi0KvJwvYvW5imhxvF4AOCOR9PZuhHI5pYHMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eMWd9ztcQmvp0weR9p/lJg2VVbfhmgYG1rp+cvsB7I=;
 b=R8Nx6MPBSkuKFjcdgDPHPKaf5RxJy2rV5OjPcZoCf46XNiEeXfprFBt0a00fVH5IuFG6oFEg4dQdO8pTMFANFGrFbfKbKq2K1Os8so0zJ1hCcmt7yB+moM5k5sQ2FhdBQ8xjzDz9vibyKMCfGGjXP5igiHh7Ny3ux8McQd8vFkcCS2He2BNQCopotWLiz5gKxDk3edQdlMmkXWvstRw7/8bDHGtLaElhtwCunvd901mILqWXlKYPrGlNl2O4l6THB1+nsxfPGFs81So9gAJmQsd8ugKKQOeVNQ8RkZFltU/4lMRLbXEQis1o98qTgrYB2PH5yqoehtqWZ6CRoKAEKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eMWd9ztcQmvp0weR9p/lJg2VVbfhmgYG1rp+cvsB7I=;
 b=L318EwEA71HByaOiWW/TEXTFzM4PiBw37jXl2iLeGfjOXPT91sotTQQRESq4jPKCY60HCP2CjxxETnBE9/98vagSlSva7gBN+1+GKC6saGsynBDneMi+GzjTkqoY9TsdZQ3ZOk1hPtpY/I3OEfXXgKj6IJaQvXMYkvIvUNfKeHg=
Received: from DM5PR11CA0001.namprd11.prod.outlook.com (2603:10b6:3:115::11)
 by PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 06:35:51 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::64) by DM5PR11CA0001.outlook.office365.com
 (2603:10b6:3:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Fri, 13 Aug 2021 06:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Fri, 13 Aug 2021 06:35:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:35:49 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 01:35:47 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <bindu.r@amd.com>,
 <Anson.Jacob@amd.com>, Anthony Koo <Anthony.Koo@amd.com>, Wayne Lin
 <wayne.lin@amd.com>
Subject: [PATCH 6/7] drm/amd/display: [FW Promotion] Release 0.0.79
Date: Fri, 13 Aug 2021 14:35:01 +0800
Message-ID: <20210813063502.3106309-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813063502.3106309-1-Wayne.Lin@amd.com>
References: <20210813063502.3106309-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5adf5af2-b307-4d05-5d3d-08d95e2497e6
X-MS-TrafficTypeDiagnostic: PH0PR12MB5401:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5401225E4CD5E565461F22DAFCFA9@PH0PR12MB5401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvA9qnu/L0l8maqnte8kQm8h+GI7J1H9seK3qnuNqDZG6ZbehZOAUwcRun+Ge0ucuFmyZmQHfJ7vXDUNN4dUyop0rHOVxiTMTXr+vGdBi0AOlHf3AkHwsaFQdgj31oXkfMyp9ks55gyKlCGNUrTgLSJmGiE8dz8PL7W14sNNlGBMvQuAWa5KtBlGoVIpDaLTwjy/n0u3nS0j36KABSsBUwLnd4gWRpnbFsZSYC8W2c/xtT4GFg8vYeSFJC34s8Qz2oPuQGelIRGkUasInRqLuGDctQCVs7F3L3r8uXMHNlZttH733bCuRfQ26kmU2xrW+jvIu+2cz7S1WrikVgnxLciqo+FF+inlLEqtvtjmvc10SnqScWEojDbmDFzKtoyuQRSqdvNMrxzhEpZm8fFZvHRE7JWzSpMajsBpdlxMlaf0iDZ4eb/ypOcNdlJvu4k5stMTqgnoVgOCA9XfAnrwCwc5tYuC75O13+vh8KdBx7mbPVjomQbHxCzojxLnHiUZgn91fVzMsJLv9BEVRV+bZW9BWAcFo6CnK9bsY8gmQVtDyRM57yw4p3SomVuOauerCEnh9+TWSIeiQOJDBbwXribmiLoYBK4daFoHW4vjsvQf+XSnmMZzy7ZKNNsVDw29nlLFkdbvdjRZP6Tq2/TcQuL00kAtH2ifrlyyI1Y4IQozvIp/e1Tuu7A0rGxs6hwOCiSfjD+pnIZ7HVMMMPC8SswDEPWNPlN+cYhCrPqGMxGOC8iuoVuOMb9NUXL8zV2sGVsBLd8Pkr+xGWrs/nZ4ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(36860700001)(336012)(8676002)(7696005)(356005)(2616005)(86362001)(426003)(316002)(83380400001)(82740400003)(186003)(4326008)(36756003)(82310400003)(34020700004)(1076003)(81166007)(8936002)(70586007)(54906003)(2906002)(26005)(478600001)(6666004)(70206006)(5660300002)(47076005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 06:35:50.8876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adf5af2-b307-4d05-5d3d-08d95e2497e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5401
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

From: Anthony Koo <Anthony.Koo@amd.com>

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a6f3d58f82c6..7b684e7f60df 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x9b7fa7783
+#define DMUB_FW_VERSION_GIT_HASH 0x7383caadc
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 78
+#define DMUB_FW_VERSION_REVISION 79
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -322,6 +322,10 @@ union dmub_fw_boot_status {
 		uint32_t mailbox_rdy : 1; /**< 1 if mailbox ready */
 		uint32_t optimized_init_done : 1; /**< 1 if optimized init done */
 		uint32_t restore_required : 1; /**< 1 if driver should call restore */
+		uint32_t defer_load : 1; /**< 1 if VBIOS data is deferred programmed */
+		uint32_t reserved : 1;
+		uint32_t detection_required: 1; /**<  if detection need to be triggered by driver */
+
 	} bits; /**< status bits */
 	uint32_t all; /**< 32-bit access to status bits */
 };
@@ -335,6 +339,7 @@ enum dmub_fw_boot_status_bit {
 	DMUB_FW_BOOT_STATUS_BIT_OPTIMIZED_INIT_DONE = (1 << 2), /**< 1 if init done */
 	DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED = (1 << 3), /**< 1 if driver should call restore */
 	DMUB_FW_BOOT_STATUS_BIT_DEFERRED_LOADED = (1 << 4), /**< 1 if VBIOS data is deferred programmed */
+	DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED = (1 << 6), /**< 1 if detection need to be triggered by driver*/
 };
 
 /* Register bit definition for SCRATCH5 */
@@ -489,6 +494,11 @@ enum dmub_gpint_command {
 	 * RETURN: PSR residency in milli-percent.
 	 */
 	DMUB_GPINT__PSR_RESIDENCY = 9,
+
+	/**
+	 * DESC: Notifies DMCUB detection is done so detection required can be cleared.
+	 */
+	DMUB_GPINT__NOTIFY_DETECTION_DONE = 12,
 };
 
 /**
-- 
2.25.1

