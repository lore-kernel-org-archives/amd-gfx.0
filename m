Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF97C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0018B64E0A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0018B64E0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B286EC2F;
	Fri, 29 Jan 2021 21:28:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2C86EC2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEuMX7o52WauEO5hgOSTWqlFRtaECsupUJmO7D2lacyxnUrAPCQ3hGsLwJhv824E8FRGSpCMgXIczI23uGfK8UTT/boIjqr7xAGKdufykjIgb2LskXkVfxyPMxveCbWh6am4at+8DuywtbEuPoTsB1JNwYEyAOCM/qVX+EDQ+biw+I3XEF6YcJFs1s1hW6Dc8SCbhJnPXcSqiPs5Uq1icvQTY9bMfEvusKM/Qf09Fpu7JuJ7t8+adiDJJCMY3VR7EbyF2Vsrlf3SunNYlRmyisehP1RW8+dI4283216XGWVmaIUsVn49LQIBiP1WfNPawIvtCF++hRNWziihzSb1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbdbbZ7DYH79SchU4AdZqecTbu9Y41+f5ghfiVZrErI=;
 b=SFbUFrqQH8/bP5DWFt5jRjFfeJBGZrxKel4nMR/Reg0tdKjYm1XfbQvcqlf6+UP97Qq1m4+wpchCCyK/ANV9vn/N2iiQNWUrX/2HCxtAtqjj0Ar3pmDOUtq38FjsPbG4hulWWAsULj9fTWOlF5JC/2V0zc5Iyv2e8B8YzaS6XJjnETEAhuaTPKntD6vM489e8TMYJfpwuiW0fgeMqyOSbnAI6fVvSYmBlqJ6GK2MBt/Zk1VxkAh3J+LU696GmpqqYgp4jw3frbZeAWeIOtHHo7Glnx34EBf/m0hbCKNygRiY3EKGxLRavteXknAo7UVXVralbHGMMB1t18L1lztZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbdbbZ7DYH79SchU4AdZqecTbu9Y41+f5ghfiVZrErI=;
 b=rvpQ6vATcDXFgy1v58BHyh8wOCrI/IRuJ2P05UsNOG4czoSwWCReM1tTs4RTT2TK3U7Que6RFMq1feVYrIY69iudXPZM90Re5Mygj6KpYx8bbbqiFvbhlNIugD50dSMdPBtkcSXK7FqIPXSVuAe+8m4FD0hJMqmZWT0aR8QXv64=
Received: from BN9PR03CA0467.namprd03.prod.outlook.com (2603:10b6:408:139::22)
 by CH2PR12MB4874.namprd12.prod.outlook.com (2603:10b6:610:64::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 29 Jan
 2021 21:28:33 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::e4) by BN9PR03CA0467.outlook.office365.com
 (2603:10b6:408:139::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:32 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:20 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:19 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/27] drm/amd/display: Fix CW4 programming for dmub30 cached
 inbox
Date: Fri, 29 Jan 2021 16:27:42 -0500
Message-ID: <20210129212752.38865-18-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d55385a-3b2d-40ee-5dee-08d8c49cd3e9
X-MS-TrafficTypeDiagnostic: CH2PR12MB4874:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4874E27D28906993E218AF12EBB99@CH2PR12MB4874.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50BqZk7gR4KgvFI/XbiwYhokXZswn/nL/wHSg/niiFGDA8vndgX3lDvxr896c2g2C1Wm3oam4s8ufvg4fhdg7uKO00qNR1qOxCFO03+767g0xForcFf+u+xT4vyIDYtOgWrM5nQ6tpcd1BW4thGZIDeAJxnzWhMbtzPZ2ltWGwLFQq25Pudzx6CGUA+vg+uw2K5GMABbG0+nDq+uBbrQzOiXUbxnfaASp1TZvS3ASjW1vjjNNLJLUW+FAD1Ji6GUvTtphpt7lITYmho9HLZBx+APChes8vMLJlED44fpAKfs4ioX9NY1hOARHb8epHKWXqDfSJgZm1NhrdTt3iMnNiKxnzCIXpTycuUAXV976k9sGFcE6a4bboH6Sih+1j0F4fJHmNbMY2EEVHnJlyEAI6ZGljzrbU4YQM3ayC+Ocxy6YfCV9mTGC1y4kOV7edIV2ZUF3K7ip7kViczKfFWvuM8F3sUpCqooK8I7TTKA/2nRsz8GSbke67RsXZkk6VD+pdKFphChDfyVpbgnn4mohr+2C3UjPf/DZ1IkrEN4mKyEUoJAeSTKawFtVOo8V6i6ets6vjMLrZxB2QmlMwcZyvBLg51VgVKF5js2P6XMGoc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966006)(186003)(316002)(8676002)(336012)(36756003)(4326008)(6666004)(70586007)(5660300002)(82740400003)(70206006)(82310400003)(7696005)(478600001)(54906003)(1076003)(356005)(2906002)(6916009)(426003)(47076005)(83380400001)(2616005)(8936002)(81166007)(26005)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:32.1714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d55385a-3b2d-40ee-5dee-08d8c49cd3e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4874
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The conditions for whether we used cached vs non-cached inbox1 depend
on a version check that mismatches what the shared helpers in dmub20
implement.

[How]
Use the dmub_dcn20_use_cached_inbox check for dmub_dcn30 as well.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 26716c41786a..8e8e65fa83c0 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -81,7 +81,7 @@ static inline void dmub_dcn20_translate_addr(const union dmub_addr *addr_in,
 	addr_out->quad_part = addr_in->quad_part - fb_base + fb_offset;
 }
 
-static inline bool dmub_dcn20_use_cached_inbox(struct dmub_srv *dmub)
+bool dmub_dcn20_use_cached_inbox(struct dmub_srv *dmub)
 {
 	/* Cached inbox is not supported in this fw version range */
 	return !(dmub->fw_version >= DMUB_FW_VERSION(1, 0, 0) &&
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index d438f365cbb0..a62be9c0652e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -198,4 +198,6 @@ void dmub_dcn20_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip)
 
 union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub);
 
+bool dmub_dcn20_use_cached_inbox(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN20_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
index 7e6f4dbabe45..b4bc0df2f14a 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
@@ -155,7 +155,7 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
 	offset = cw4->offset;
 
 	/* New firmware can support CW4. */
-	if (dmub->fw_version > DMUB_FW_VERSION(1, 0, 10)) {
+	if (dmub_dcn20_use_cached_inbox(dmub)) {
 		REG_WRITE(DMCUB_REGION3_CW4_OFFSET, offset.u.low_part);
 		REG_WRITE(DMCUB_REGION3_CW4_OFFSET_HIGH, offset.u.high_part);
 		REG_WRITE(DMCUB_REGION3_CW4_BASE_ADDRESS, cw4->region.base);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
