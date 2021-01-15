Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C05C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951E5206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951E5206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379C66E42C;
	Fri, 15 Jan 2021 17:31:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4A16E46B
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:31:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=objL7PexQtmOMCNphRE/WvXng83vPKGL6aM4+GkWMPeVyRnNG4il3gBLa6Ft2hW8eFO7+IKCxqGJEC/ygzOPTQ4QCTM4GXGorPwKqEztmMyp8+MdXXfD0v/M9gZPjfDFLvhsyxch1ilxbV3+b6h0mowm2dM1we38+Fa9HMsQtgch44Vj7CXJYVjsbETIS1+8JP5uDRTzXg3CsMNORIsRJj45G18pLKu47JTjkO1rGjjLKlIWhYQUOBb9EpyeWXVY+k31YmWvJbsv92yKlU9/5MeI2OfDq5a7CRoFBa5hCR3RPFZ0ZQFmvvT5BqThcjSCw7zJm8GOltZ7HT65TqtFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fd/lze609BuZZPJ4/ipKtXd6BPcoRgays/9JVNQ4iY=;
 b=UXFIWVaJYeyj/lbsSztsHMGIPO/0b1T6dlu3flWArKq1URSX22b+O1OyoePpJqIDSBCdHZHz0ZCLCYCfMsAy5YEdavKWmOUKwb/BBOQ/L0/Fax3qljMYOZL0ICXsoAGNsBu0krjfK+dY+9JZUNBUEWfqMTRgLJm4YupUDQC2zlWGkbUMRxgnZh35drLJ+xbYS4Va/arpGSI9eeak7wvnZi3QdiyvjaqY98+klJVENOK7KagAVL1JYy7fWSf81LFdaRTop6/11PslKTQRvwLvN3Q2e+uJW7RuQkyIJNHz8ROq4HILwd97S0twSV0Rm+Kjld8J3rgiIli94PzoXMrqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fd/lze609BuZZPJ4/ipKtXd6BPcoRgays/9JVNQ4iY=;
 b=mo33qS2/8hAAWaHbsuRjifLkf5P5+l09ylfZdLoMNRVu7oTgJSKrw2SiR8MAa7EE0dE7XSJlNIwUUDm2cFstrEXXJ4uU4RwkGCoVOA2HOCa6LcMG2W6V+xHRvK23ze3WPXhMcv87wya7d+U063xfRP1lOqc1LhCiPZ87MPfl3D8=
Received: from BN0PR04CA0005.namprd04.prod.outlook.com (2603:10b6:408:ee::10)
 by BN6PR12MB1827.namprd12.prod.outlook.com (2603:10b6:404:fd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 17:31:22 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::a9) by BN0PR04CA0005.outlook.office365.com
 (2603:10b6:408:ee::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 17:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:31:21 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:20 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:31:14 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: Allow dmu_stg to support cached inbox
 for dmub
Date: Fri, 15 Jan 2021 12:27:12 -0500
Message-ID: <20210115172714.126866-11-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb0992ad-1efb-412d-4b20-08d8b97b5fe3
X-MS-TrafficTypeDiagnostic: BN6PR12MB1827:
X-Microsoft-Antispam-PRVS: <BN6PR12MB18278871F04BF3C6C042853EEBA70@BN6PR12MB1827.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: waWAVZzdJI4iSbF3MTNU74/IPOw45e0q5PFbA8UrjVhXjajiXdLIgq9ZHK5UNELongIKQlEg/cTO0Qs1YykVJa6vT2e1hGlkqp2ytH/M+Xd1kjh1ElBdWsv7gflR5vVVMUDL9XYTncZHYVdJfrjBKF7ASZ0dK3wjIMm9bKxzEXZYeYPo7IpUfQrVc+LDiNcwjbI3KBmcQ/87sm92/Ngcq/3ZwENFq9hXwd404ZGWO/UijOyupRoahAATgXbY86j1US9Q7rRXNb/T/ZRpG+lrp7qeIAXpyI2GKNOkUzwwv2udTYlGjfzsKm7SxJhsmdhZ5xTSQQODCJZJjRE5k/5PQYN/VF5wmER7SEAOV0yVUY2QMjyEB+ljGfqpG3KFtEZkz05LNJvc4kWjFr5FsgziQN/1xgSgxDEeW7NyN1aWBZYy1MROGZ3wOtoz/D5IEIDjzxH/jGUpL80gdFLKQoe9b0aOIVeEUhgK7QPgxJ2NScYGn8tRvMHUB7ysZH6kfLic
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(70206006)(7696005)(70586007)(47076005)(82740400003)(2616005)(86362001)(36756003)(1076003)(6916009)(8936002)(34020700004)(82310400003)(2906002)(356005)(186003)(316002)(5660300002)(478600001)(4326008)(54906003)(8676002)(26005)(336012)(81166007)(83380400001)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:31:21.3342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0992ad-1efb-412d-4b20-08d8b97b5fe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1827
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
FW version check doesn't allow dmu_stg to support cached inbox,
which yields much better performance than region 4.

[How]
Check a range of fw versions, rather than a simple greater than check.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index cafba1d23c6a..26716c41786a 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -81,6 +81,13 @@ static inline void dmub_dcn20_translate_addr(const union dmub_addr *addr_in,
 	addr_out->quad_part = addr_in->quad_part - fb_base + fb_offset;
 }
 
+static inline bool dmub_dcn20_use_cached_inbox(struct dmub_srv *dmub)
+{
+	/* Cached inbox is not supported in this fw version range */
+	return !(dmub->fw_version >= DMUB_FW_VERSION(1, 0, 0) &&
+		 dmub->fw_version <= DMUB_FW_VERSION(1, 10, 0));
+}
+
 void dmub_dcn20_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
@@ -216,7 +223,7 @@ void dmub_dcn20_setup_windows(struct dmub_srv *dmub,
 	dmub_dcn20_translate_addr(&cw4->offset, fb_base, fb_offset, &offset);
 
 	/* New firmware can support CW4. */
-	if (dmub->fw_version > DMUB_FW_VERSION(1, 0, 10)) {
+	if (dmub_dcn20_use_cached_inbox(dmub)) {
 		REG_WRITE(DMCUB_REGION3_CW4_OFFSET, offset.u.low_part);
 		REG_WRITE(DMCUB_REGION3_CW4_OFFSET_HIGH, offset.u.high_part);
 		REG_WRITE(DMCUB_REGION3_CW4_BASE_ADDRESS, cw4->region.base);
@@ -255,7 +262,7 @@ void dmub_dcn20_setup_mailbox(struct dmub_srv *dmub,
 			      const struct dmub_region *inbox1)
 {
 	/* New firmware can support CW4 for the inbox. */
-	if (dmub->fw_version > DMUB_FW_VERSION(1, 0, 10))
+	if (dmub_dcn20_use_cached_inbox(dmub))
 		REG_WRITE(DMCUB_INBOX1_BASE_ADDRESS, inbox1->base);
 	else
 		REG_WRITE(DMCUB_INBOX1_BASE_ADDRESS, 0x80000000);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
