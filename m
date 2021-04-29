Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89260C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFE5613F7
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFE5613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83996ED84;
	Thu, 29 Apr 2021 07:55:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F422F6ED8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWoImwHUGdHsFSHNqDcs7rueG/cQ+Wk2cQileYwfcBKnHzGmO3um+SEE8y38zQm+bC2ZMv1Wk++YbWQF6o9KgP1z2owYcQWPnj0HFmv7PDimvJjhJk8dKUxYOayEg/0yt+KCtUU2eHKfAFkF/ilpT0OQ9DtxruapUGqPRU9EuxFZVoCG0ohcLtxZLgcR09CHlCf7LM68v7SfEEhrt0KEYzrhmpI/okBxCIj0ePRuFOXRlyCUW8T0GeUIpTIr0NQ9ZomKAvNQ7DFxe13YdXOCMQwe+P0C6SdMgePR5b9wt8DuLjm2m0Gby5S39Z6s7EJtwqYXfC32I8eULoYyiuVPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnKDMIzxQWd/PuLLr2J/i6wS4ZEBwqfJgG0PmwVVj2o=;
 b=XSdI3AjNvmRH2qX8oITnbyB1S1mQ6vFUT2yZpMsAXMx+rBFubFJyVzIqqqMY0HDT2Az4Uxmi238NdjPVvy7nghjuw4mJOVns5QCZCV9jBJVngKsYFHFcAEDzGFuwuKwcfwaQ5pISWFXy9XaLfy68xeDTMPYV3RKXC0Fq20XIVTeVDOq/PRYotP857jRjsHi+UoCTHMe/9lR/P+SwZbScC3AGKPZsrMLdTMTBCVYpHZt9uNIVY6IlajFLmVGbVVByCJjgWebfzVrE4M4Jde6N2+W2ry3FMjxFcxfxYyCs+HcW6AB/GW/U7BAq5yXXOGMJxjCPyJ+4k/Sr8pldnL1yUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnKDMIzxQWd/PuLLr2J/i6wS4ZEBwqfJgG0PmwVVj2o=;
 b=CgJArajBUa118un1DG8vAIvYwyxJ7nL6hiE0TURWaxZLsMOIoRYxYKOh+s5CsfPxumryjjLVDTognwmLsDjfavOp0YED+gDf21ZCOGxNW4GUVnhIevgpBr9OnLmwkt5tmzTuGBFcM2Melwn+7648xnCIVbFtPYHFR5dHg5gm/8E=
Received: from DM6PR17CA0004.namprd17.prod.outlook.com (2603:10b6:5:1b3::17)
 by CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 07:54:58 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::b5) by DM6PR17CA0004.outlook.office365.com
 (2603:10b6:5:1b3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:54:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:57 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:55 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: 3.2.134
Date: Thu, 29 Apr 2021 15:52:06 +0800
Message-ID: <20210429075206.15974-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81d9ac30-086c-4b2b-f3c9-08d90ae415f5
X-MS-TrafficTypeDiagnostic: CH2PR12MB4875:
X-Microsoft-Antispam-PRVS: <CH2PR12MB48758EF25AF413630C0C2EEDFC5F9@CH2PR12MB4875.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIyUZ5ZeYaz2u/Jfu1KrndFe6YcMP6ceSSLSIgjKj4P1tU+EjDOfEOW9ggNC969tLbgAddULTJ8ZQNqgIBtI8HHkgJV7Jg8m8VUz/YHfEH1SncFVhRFseiWYr0NckiA5RV4ANS+F2ez04rn28XbtblDd8WT0qXH//uAq+1zyizBu+FwsdUAq1DDlIFeilBDIXOou+V1xgdLZIRImqUrpV0bky6yVyS9qDzxn0RU4mReXyolxrvuJw0vEDJB+SoMdHgrp+BqAJtoeCoF2grIcDkOb0NhoCsR9G/P5BlLFpCC4x8a3bkHPlDcZVvOcg2WGip8CCpSOxOlA2lsZYYXgTcaP0+dHPQ9xtpnhXY5g2IMS9+4xEvs0/ablfWtNAA57CCKVW5Zq/PBzhWD+8Njum8x6SVAmXFWHQyB2rBJsFX0Z7cbzKONTLyf1wAEy+UA5T0RAgfncP4D7+cXL6Lvb+bcS0EIY0gOr61bO67inCyMnFbYTN8Pg8UqVAiy6Qy6nz1F0D9SbgOEQqvqGBAfrRNpQchyZTty+nQYs3LoK9WJJT5IwrU7YsqVz7ZxvPIL5j8ysarDYverHHrCqhTcPba3ql1Q86a20eHi0H40cH9elxDzEO4FhQfp7BGx8aInp4Yc0w4rdbERLuaMjWYIYMeF1aOhAucWrPPwWBHjNUc7UM6jpxGm0SYMZft5hj5p5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(46966006)(26005)(2616005)(186003)(83380400001)(356005)(1076003)(5660300002)(478600001)(81166007)(336012)(426003)(7696005)(70206006)(70586007)(86362001)(8676002)(8936002)(82740400003)(36756003)(6666004)(36860700001)(82310400003)(4326008)(6916009)(47076005)(316002)(2906002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:58.5837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d9ac30-086c-4b2b-f3c9-08d90ae415f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.64

Aric Cyr (2):
  dc: Revert commit "treat memory as a single-channel"
  drm/amd/display: 3.2.134

Calvin Hou (1):
  drm/amd/display: remove checking sink in is_timing_changed

Dale Zhao (1):
  drm/amd/display: Add audio support for DFP type of active branch is DP
    case

Eric Yang (1):
  drm/amd/display: Extend DMUB HW params to allow DM to specify boot
    options

George Shen (1):
  drm/amd/display: Filter out YCbCr420 timing if VSC SDP not supported

Jude Shih (1):
  drm/amd/display: Support for DMUB AUX

Mikita Lipski (1):
  drm/amd/display: multi-eDP backlight support

Paul Hsieh (1):
  drm/amd/display: update DCN to use new surface programming

Paul Wu (1):
  drm/amd/display: Set stream_count to 0 when
    dc_resource_state_destruct.

Roman Li (1):
  drm/amd/display: fix potential gpu reset deadlock

Wenjing Liu (1):
  drm/amd/display: add dsc stream overhead for dp only

Zhan Liu (1):
  drm/amd/display: Avoid gpio conflict on MST branch

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6ef1dcadd454..9ba4cdd8c06b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.133"
+#define DC_VER "3.2.134"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
