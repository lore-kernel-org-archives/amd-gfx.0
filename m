Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11848C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29D561507
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D29D561507
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875C96ED80;
	Fri,  1 Oct 2021 14:41:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C400F6ED80
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ekin0C3lhTVpHZLXepXuCIJKnwYEkwYv7vfGir7hnzzTnIrD1zusWmnehN66KTUI5MTuCDLSC7akToRpcoU7uz/QCRbno6MM7NJ7VxWxRjDodFNeodFiV4zici9bP3/wifIau3/buGL+i2gX3+x6LD93fBh0NCFZysyEeBkjS91BU2spi+kVluSyAqV+5nqa854L3UjJy/ox5JNqYYgz9CKB5um4/NKCMOhO49SmpzfiiduqIXPNHP+8VRoUYddTSGKcEOg/ZJq+1qLkTIeUwSpPDICsiD/ITlooRl0VdQ3c++NuqhdEOd3UDQWtIJoZWfq1iYBnny/FoCpFor0QkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR2yVM5JXbwUHqjwDfdB0P8iqCdV1t37QqsCQY/zl6M=;
 b=NOCOHntocI/00J3FZkGd0IYkKKzjovx7FeNM5pO8JyZc6MM4eJvttE9RIe3IrlVpWP0DlCZqMhOLdiMTw5jI6oq6NNEkZp6R5NItXPFKEvalmvwTiHgMxKVKBHfJohvBeXo0O/RjkEhxGhpr8JIEyhZTftlho77fjSf/5X9lICHvD9BomUYZkfOaOS7APDBzbipT7ns9h7Tfi90sUt2fvkQs+ToYxCKIIJ50ySOEdAsatPePixSHv0LWuGMscwPr67Nwu6kBYKybCnPYsLzHGDijRcQy/4fMPWHkBZpYMZCUZ99q7IOuvoXLc6yQiKaXGVyCKj2AGOc+T9s9444KWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR2yVM5JXbwUHqjwDfdB0P8iqCdV1t37QqsCQY/zl6M=;
 b=msVkLCsRFxyxifW0znI/OzyUKWxMx8SVsjFMIpoGa3xY5SAfmhoxWmxbjv4NopqDeo193LLc65iQDJLqGvER0VZkpbRodhw3Uj/tFVIlcAd6nvSkZ4vWuqgjDxz8o86STf98lneaPk7u+oTHkK/1drIjxjpTlBjCwChmn8BjMXc=
Received: from MWHPR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:301:15::28) by BYAPR12MB3510.namprd12.prod.outlook.com
 (2603:10b6:a03:13a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Fri, 1 Oct
 2021 14:41:28 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::1d) by MWHPR2001CA0018.outlook.office365.com
 (2603:10b6:301:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Fri, 1 Oct 2021 14:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:41:28 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:41:23 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Aric Cyr <Aric.Cyr@amd.com>
Subject: [PATCH 06/14] drm/amd/display: dcn3 failed due to dmcbu_abm not
 created
Date: Fri, 1 Oct 2021 22:36:12 +0800
Message-ID: <20211001143620.192679-7-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57599aaf-1938-4a6a-9694-08d984e98d78
X-MS-TrafficTypeDiagnostic: BYAPR12MB3510:
X-Microsoft-Antispam-PRVS: <BYAPR12MB351046505B9CAFC19405AF9C97AB9@BYAPR12MB3510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3IOTv+lzlArLcjwJDkuRZx0hu5BvjOS5Jh1qaKlpV79+czXb2uhGdIbD2EBSzaYyQEx8NKlmzoojNedD5fK46J/CSjtShe45pWqdUY9B3Vn1HEwoUIoZhoLRoO2pQ43c5o2bg7tHe2uL2IOLnLkcNRuG3CiE+u8c/eHLoZKH3cP9xCukL14sjTNWnlWOcO9qDTrW9Buj2XT7sckJIan+kWCsQs9ySWUX7JtSVCummJ9Y3AhHwc58XKBgSAMTbcjPMB75QReLsOkmUDUukYnRnpKE2ZodH6drBFHzrUC3KK7cQlSqAmcJySYDzOA5z0d18ibpp3/wCIT1H4v5GOo9Bu9hfXHmW6vhDgU2EC87BBXZdsQaJXjM2BdC0vFSpRV3ORfSJa9DSj/XkdibnVRkQxejiknzCX1+nt4QcnxkVWqrfd8fs/YxYWEDD7HznQGiFydCSPOu1eL4bl/25b0idlXS87wIb2EhBebF/WbFtrffgwXnBJ+5EPVNJhxnbQA8o0wLgunAwccL20JdBfcXPfERhS1VdGON8lZs1NsId59t4VW9JplFRnS4On8vmWVXXO7hbhsLz/R0wD7HnTtVslptLMvt+eo/0wMPamhBeVpCEMTvgMc5BpPDvON2GksXkWYf7pR/g9jkRqVd8+d3WrPOpWf797gKcRfYSsbU0X0f2XgrelplbFRFL5WDvgF7dLTwiE7sFTyhST0x1cGcP7tJBV1OUCTIHgPkFTpKLzU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(81166007)(5660300002)(26005)(2616005)(6916009)(4326008)(4744005)(82310400003)(356005)(7696005)(83380400001)(316002)(47076005)(86362001)(186003)(2906002)(36860700001)(16526019)(336012)(426003)(44832011)(1076003)(6666004)(8676002)(8936002)(54906003)(70586007)(70206006)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:41:28.3753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57599aaf-1938-4a6a-9694-08d984e98d78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3510
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
dc->config.disable_dmcu set to true, but it still need create
dmcub based abm.

[how]
check to dc->caps.dmcub_support check.


Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 0f273ac0c83f..6ab81d609c97 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -256,7 +256,7 @@ struct abm *dmub_abm_create(
 	const struct dce_abm_shift *abm_shift,
 	const struct dce_abm_mask *abm_mask)
 {
-	if (!ctx->dc->config.disable_dmcu) {
+	if (ctx->dc->caps.dmcub_support) {
 		struct dce_abm *abm_dce = kzalloc(sizeof(*abm_dce), GFP_KERNEL);
 
 		if (abm_dce == NULL) {
-- 
2.25.1

