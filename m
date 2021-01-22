Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD309C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788F523AFC
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788F523AFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1640C6EA4E;
	Fri, 22 Jan 2021 20:07:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770050.outbound.protection.outlook.com [40.107.77.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B59D6EA4E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erLTeVeGyQw1gQyXlg3fwcqLLFvoS4nkldBgNjAX/kykcMOkq7tBXG0nGQ6vZGJ1FpfuQ5aaEZ3BFAF3AkuW7S98f8Ys0OJ+t0Emi3ib8ycztWHmJCvwObb2liqkKBbxmyIhx/tGa/nI0F0Vz1rrVRQmVDLRR2rzU6Z1MdAj4jlmobUgOc65wvj1aZfVcpZsCMHt+sgbDM2S2orqHYlRPxKHbSH84UKh1MoVfhZ71dh2/795TjmJQGp4CzUHirWq+MWw9s3P2kgmWZPpWSqtvusujSFc8i6bHw0JFtl3nlUHnB6KGY48iFlzkjoUj8DZg5t9SMCIoDi39QcZuUynZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhQsR+/HbzyAMug/S6o3kGBwqI3oCO0ma3lJSrkjqBk=;
 b=lpOmc9Jjlr5YSHE/GwS+op6nOZxVMdPI18Q1RmzrsD+r3ST8nA/SbZJ5vxjEH9HIbCBxrH/U6BS1mHuBx8YXVmAmAzzKlibxMHqNUFJyr/EwcGcp4JQ3/GbrO4RzvLBi4AT9nnBVx1F8lZxUnaTCnsp5ph2Sbu7kt3me5uTraSXXQiWiIBDpeIVf069ClaldCL053QWSJ+PcAm89SDrRpzSA87kbEJdMdo1Ku8NFOB7XvhLwG/WfLYx9dq/Ftfnlkz1CPeewse8CD5aM7xFVQ3a+60B/kvpasseMcDTfciaybqqVstLzXoqr8NB1s4RuZauBEXCNBJbcivwDJCOy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhQsR+/HbzyAMug/S6o3kGBwqI3oCO0ma3lJSrkjqBk=;
 b=Wc5jLzNLHQMILMQ6CBmkLpGG2cn9xiGZyI8+6/a4xOnohCAjcGQyJGxK9D3nHwa1DVwv61vCF4/Sf+UAJ6cV3pNzzMdS0BmZFLBu2tT/kgez6Cg1tSBmqSkX+KGgjZgWpPBFf+Zi/+Gu4RJfcEPeGu0oQaA04dZfkE5WuKBBQY0=
Received: from BN6PR10CA0047.namprd10.prod.outlook.com (2603:10b6:404:109::33)
 by BYAPR12MB2678.namprd12.prod.outlook.com (2603:10b6:a03:71::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Fri, 22 Jan
 2021 20:07:11 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::eb) by BN6PR10CA0047.outlook.office365.com
 (2603:10b6:404:109::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Fri, 22 Jan 2021 20:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 20:07:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:07 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:07 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 14:07:06 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/display: [FW Promotion] Release 0.0.49
Date: Fri, 22 Jan 2021 15:06:49 -0500
Message-ID: <20210122200652.197934-10-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122200652.197934-1-Anson.Jacob@amd.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a49916ac-5336-4b4f-e893-08d8bf114d0a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2678:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26783A4A70AFD04FFAACBBA4EBA00@BYAPR12MB2678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e7JYmnFRZkRv/0D1s+WGrf190WVVREcGTiWY5ThNHWI4s9UN0MSzFTKus/YpN4Vgzax9nt+AW3wTbP52+IVqnKntj07vq689vYh8r1dzxwVAzKf0o7ZaZFVnqvjn4oVVQbVJjLqWkj9m6Y5DFfvMVi/wRvU2KC9U4sPHFMI3b9likp5wtrRSI12vVAgUVT2Nn5PcNVpb6vyMjW0FhgCrKcblDrhTb5Yj4P7Ye3uNme1MpQvU1EPy+vDPGicRzXgabv5Ucids2LAjDhV9oFb0eRTBDr1EWtHP3Gu+tM1C1VCBBcgYMkvWZ4biF9OWEcqNLY8/tPt4dWdBhYSjDg7trmBVYwkRBaUePXinAu+QmugEAKuObjlWQrH3F8zFTEmEJgnVaomBD34Q5I9Em0TXXZS7OtZYRPpX09B8j+JJKu038l771vGkY/flTt27D7XVzVhOrkRJjx4Ag0h4rBdDLpOe1SwUsiPneqlSGYabCt1o05n7mx7n6mC/d1FZi4V1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(186003)(26005)(2616005)(8676002)(316002)(426003)(336012)(478600001)(36756003)(5660300002)(86362001)(8936002)(4326008)(356005)(82740400003)(47076005)(6666004)(7696005)(2906002)(70206006)(54906003)(1076003)(82310400003)(70586007)(83380400001)(81166007)(6916009)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 20:07:09.9725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a49916ac-5336-4b4f-e893-08d8bf114d0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2678
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Add field for passing line time for a frame

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a50bdd6c7131..78841fe7e30d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xf09c02ae3
+#define DMUB_FW_VERSION_GIT_HASH 0xf2f2f3a96
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 48
+#define DMUB_FW_VERSION_REVISION 49
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -648,6 +648,7 @@ struct dmub_cmd_psr_copy_settings_data {
 	uint8_t multi_disp_optimizations_en;
 	uint16_t init_sdp_deadline;
 	uint16_t pad2;
+	uint32_t line_time_in_us;
 };
 
 struct dmub_rb_cmd_psr_copy_settings {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
