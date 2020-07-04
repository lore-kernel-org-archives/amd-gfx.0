Return-Path: <SRS0=iabP=AP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB69C433DF
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8271B2075D
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HWJWT7tZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8271B2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 636096EBE1;
	Sat,  4 Jul 2020 01:15:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02796E3D6
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jul 2020 01:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/5VNfQ8LxoEb4v75G9mJdZRfk30zH8G891+Xhm5Pgx/KILtQHVSoN9KBZbRDG54ZrqkonmNOVqABw/0VcHO7XEIJo75iC/Bl3pOLqbUVezc8NG8TEUi6Lj+krGPyWN6H+zmGnkIXxQfDL/3oTuHsoAplEB+Z8AQm8mOev+T1k5Znb22QL4VJuEIhPnETQWCJWZSJTv+cWNoP+cZfFNYRxEfXdqCZJjJCk2+QZ3IXGdUf3FDI5PA8EMgPN7w7fTdu+elL0wIcQ06sTAHh47w89lGtkwaB1DlSoLvcaXg6MbVe+bJ3DhMDLC3xeTEnVto+PajLvZQP4wEfF38S6wTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM/YD+mVUuQd4scxSmy0LO5DjR3fqSiR9XhnIxlEo0Y=;
 b=AKX+FIXTbIWULf78O+S4qBvAUmPVRdlzNnH1pTjBkJ6IrYR+lMDhrkIcp2NHoP+CY2pxcTHBJi5dq09L69nzk6jjAfOkWKT8Yx+/Dw5O0OjtQI8Bwi2zSmtwT4XeuW1pmzENq64EkwQ8vw5FxHHpVTEocaA5h6OuCTiQ5sWMtKDIEk+psRoL2wnMyTIHT+k6etwrEHuDFbFnKt50n/bjJc9BeD9q46nK2yKA6smhG2mMudi1XgYk4dDtHzedQhJOdm8QlpIKoTP5GohWD8YuFMX2Rv+A2rUNNiG6vR+0wf+GjD9aefOUMSKjgXrSOj/UzVjIGLlYru6iQJPBxKlSKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM/YD+mVUuQd4scxSmy0LO5DjR3fqSiR9XhnIxlEo0Y=;
 b=HWJWT7tZEGA05VXm/de9VHUIFvKaSoQFKB/S/lpKChlwI/XPLEjijWmNPr4otaOwI5N9Ozk9tOu85cNQAcckoHqXeWNEDbia5Ijz3uINOh9mFPTpIF5tm0H74Z0E7e+JhddPFiQpKnQIYeSB0cSFxiVZXsPawvFHBWbfDjbTkMw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3768.namprd12.prod.outlook.com (2603:10b6:610:22::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Sat, 4 Jul
 2020 01:15:27 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%8]) with mapi id 15.20.3153.028; Sat, 4 Jul 2020
 01:15:27 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amd/display: [FW Promotion] Release 0.0.23
Date: Fri,  3 Jul 2020 21:14:54 -0400
Message-Id: <20200704011457.2368241-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
References: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Sat, 4 Jul 2020 01:15:26 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b52805dd-e163-4b68-3606-08d81fb7bc19
X-MS-TrafficTypeDiagnostic: CH2PR12MB3768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB376834FF81CBCE1F3054E626986B0@CH2PR12MB3768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0454444834
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0awPaKuPUtJtyudX1jz3zhgV91wg/niDfceXDnqfsjF4vu+e7OXmasKSBqTpPM1ZG/jlPtGRbNUbYKdVx6DE8wQxquLz2sUvpTZDaHYD+AW2sdYjvVKYggKgpjqnZ7B2DUbnazOQQoVFP0+nHxuY/crgHcIUlqHk/S7ZJdAEZmdyxNeFnjgNh0Xfxnf9ZtaD4z6eVXu/bC1mD43eQzZqHC65paPr7SGYM1qWKi/yrtOpTSGm7aOlUBD5i2ElUi6tdnmFpIPOwD3ilNzHVMOlc8fwl0s8lm1Gybc5ZiSeqGbIt6SuoffBlTYCpTyT9ijQ1WLG5csKCFbxzJfYS/b2kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(478600001)(8936002)(8676002)(6916009)(52116002)(6506007)(6486002)(316002)(66946007)(66476007)(66556008)(6512007)(2906002)(1076003)(36756003)(4326008)(86362001)(16526019)(5660300002)(83380400001)(186003)(2616005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: piiGekdfAb2ctFCB21EmQ1279jjfjmZuXusvxlQy+oZrXWsMOxh/RVOs/r3SCeIv5M0RQjI6rPIMiPdPoC1gHfdbP6K6TwSisewBvK7Ad8E7/etkexLy+yaosVWZfABLYbCLlMYdXNCSHs/lXgkFhr+1GUxHDmh2UYP4fTjwzeyigjjlxDUWU+PbA4uP26XdORf3i4M9cok/1NyxgbteIy01zze/uhID2ea6b7VVyYAGu+TgMQaQGBYEBg7fqoGPHoNBBOcWJA9aqoRrwnkqP7/7Gz4pqoifq2zaVMs3oEitTqvw+//g2A4JwmzuBTZSO08CCkHkQA+LBf4vt/f496pO7X4how7ZW0zNQt85uSNr6GRQCfu8ispgyED5r28gE0dZyLfB7OkcPoVWodM5E4LoZTO04Lh0G7ymp7mwEMG95UW+EWfTPVCSABCyYv/GTSniUPbOX75axXRntGemTD7km17lHBrhybFU+Y7JU3xhaeNAn8MpARoXOCFmJMj8Wmpi5bzg+PFTvLsiTfge2Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52805dd-e163-4b68-3606-08d81fb7bc19
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2020 01:15:26.9574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKt1fJlpC2XBrcJfbVEGxf5/BklZO3Bx2pGH3dmbcf/qGpLk4UKUFpYdC4aqC1DqducrfNU3ZESuiFn2NADDuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3768
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
Cc: eryk.brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, aurabindo.pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Header Changes]
- Drop unused firmware SCRATCH bits from interface

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h    | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d6c7a20c23b2..ce96143c402a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x5b1691c92
-#define DMUB_FW_VERSION_MAJOR 1
+#define DMUB_FW_VERSION_GIT_HASH 0x5ad38d883
+#define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 22
+#define DMUB_FW_VERSION_REVISION 23
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
@@ -123,12 +123,15 @@ union dmub_psr_debug_flags {
  * @fw_region_size: size of the firmware state region
  * @trace_buffer_size: size of the tracebuffer region
  * @fw_version: the firmware version information
+ * @dal_fw: 1 if the firmware is DAL
  */
 struct dmub_fw_meta_info {
 	uint32_t magic_value;
 	uint32_t fw_region_size;
 	uint32_t trace_buffer_size;
 	uint32_t fw_version;
+	uint8_t dal_fw;
+	uint8_t reserved[3];
 };
 
 /* Ensure that the structure remains 64 bytes. */
@@ -151,15 +154,6 @@ union dmub_fw_meta {
  * SCRATCH15: FW Boot Options register
  */
 
-/**
- * DMCUB firmware status bits for SCRATCH2.
- */
-enum dmub_fw_status_bit {
-	DMUB_FW_STATUS_BIT_DAL_FIRMWARE = (1 << 0),
-	DMUB_FW_STATUS_BIT_COMMAND_TABLE_READY = (1 << 1),
-};
-
-
 /* Register bit definition for SCRATCH0 */
 union dmub_fw_boot_status {
 	struct {
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
