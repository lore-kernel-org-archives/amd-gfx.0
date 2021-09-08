Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C822CC43217
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959B760724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 959B760724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF0AE6E1F3;
	Wed,  8 Sep 2021 14:55:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448516E1EE
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlZLmrJ6xrI2BVAzYl88ijROqAMEVo7dwflYNw0sdepoODjsmjpO99gx/a/0FDNn82/y6/0AGaJC7o417D1Tb6lIYQHZKK0p6VhqCRFS06h5CKmlCwK+uW6bb4Qb9yQe/+/qYKQ/qPcQ9u+wL4lPKxP1IfG6l3Hbb0q622VWRPaR5Gv0xNNsCYX3LckkpQ6gA9EGV/UjMPVSoqr7+a9IaMTHuMlcPYvtrKg+wzb0TrmOWcq4OLAbWMCY0dJKxgLeJAvXBdHTQbYmF4I3cm+3XJVBgzE2to6V/lIg0AbX46OeLh/ZfAi+9WYXf3vHy9n/BDjMdk1XM5Bq6FF+EnbM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=FuPcbCH9RVD0Fu7u+ROr0UJ56gBRB+PK6KE0CePZkNI=;
 b=TdEoxZBx3OBwBVzRQHQ7a/r4Qj64LkgBT9QcUb39muSMKYrJiLorV/EOW9TOpOeNWC/5RmX9NFVE36bUgCVNIlX/6lZUe6Ob5uhZT150B2CsIzwBBzxYcX7ezapECTS00F6ILS3vkmRyquf2pAMnZuyeYueHJDPV73OM7IWhLlIJtlVC7mJHrpodSEDm+UyxbY2stxNVWlUkHBRt8y4uTX8TXWoDrDWsSnFAITMqxPwX8DRyZKyDiPz+98B56KpjgMdaklIOawtiCZ8nNQowAi3J0P3p3rfU51DBf271P/NlSrxpm95gx86K9LxzhjTGBadFAFctHfekObTaT1kxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuPcbCH9RVD0Fu7u+ROr0UJ56gBRB+PK6KE0CePZkNI=;
 b=w4QMy9enu9HbhNP4gPRMj5ZkR9nuafSyEyzWQ3HO0zBosQiV+PR/VEW1SCIhKygqy9hjyQly4jSkMVmybdObMYYDZBSCKoZD4l3e4eQbSEpUmAgMTIlCmjPLk6XoPjbgWTVzNHkGfVNvFKMBJR6Qd8V/s8d2wbnbcWQL+HoLLKA=
Received: from DM6PR02CA0133.namprd02.prod.outlook.com (2603:10b6:5:1b4::35)
 by CH2PR12MB3784.namprd12.prod.outlook.com (2603:10b6:610:21::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Wed, 8 Sep
 2021 14:55:08 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::1d) by DM6PR02CA0133.outlook.office365.com
 (2603:10b6:5:1b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:55:07 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:55:06 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Jaehyun Chung
 <jaehyun.chung@amd.com>, Michael Strauss <michael.strauss@amd.com>
Subject: [PATCH 26/33] drm/amd/display: Correct degamma coefficients
Date: Wed, 8 Sep 2021 10:54:17 -0400
Message-ID: <20210908145424.3311-27-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f84ab98-d1c8-4a98-aae6-08d972d8a671
X-MS-TrafficTypeDiagnostic: CH2PR12MB3784:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3784E534026620BC6396339BE4D49@CH2PR12MB3784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84G/s0NM7ZjAT+a0Ls1flEwYf43hvlTnlzdn/eDqJcgTPOJn9ySEO+mT++8fFmhn7Eg6X0z/+Txx+9bZ4JeI7tPvGMeC5nHw3PrlzLcpgpYdOdxhS0LA8+LirMMtAsRk7W4AtcUeOLURfPA/UAzIBGrOIrjSmknRurekB5UA5Zobk8kjUAuWLGE+2ciM29qGkNXvgSLhiYQvxoKE62a+rY6ltaRBwOa77HGNYs+IDtqNy7CI6cNAsLrDO0UvvqTvOjRFSGu52fxwPhBVIYHA3GWR/0bCgYigHPPN5tcVxoUP5r+ahxEMvK3nJfVtoTxr02FRcpgQbN4HTxbuW97fquQslB1LPlZ9zGLve7XD+9MUEvF5yfPCbHo8f4KRqVcOd+MSMTyCE762P6YUplJGgdds3PrXN2Tffzc588kfKmdf0llIYOBobcK0pFEoW3mEeQh/XoIWL9qIr+PdU9xqKZ1Kp9UpTKv2BxvMeUmV5ULtE/wrEJQH6uv4yRHw6uAnTE8aJtC6ZIjJfdo6VFUgC0zdaQP8yVo91BI0uPjrLz2gC1M1ZeV7yV8usU1z0FvzC6LboSb8PycrR77r0cVOP0ylO8ufWYxcgBjG7pOnjtAXaSAp74QaWCOl4TH+NsD+ku7ri7qohCzD4L53Mq6T1j86TkaCdjB7YGHZJdG0vu0lyWueNwTZRY0vwLrGZ9wrSeFSZhM8he313As+6aN9o3YgR3TKdJQ/wWhqpFf8+WU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(426003)(4326008)(6666004)(44832011)(47076005)(36860700001)(83380400001)(2616005)(2906002)(70206006)(316002)(8936002)(70586007)(26005)(6916009)(5660300002)(81166007)(1076003)(186003)(82740400003)(86362001)(356005)(16526019)(54906003)(336012)(36756003)(82310400003)(478600001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:55:07.9675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f84ab98-d1c8-4a98-aae6-08d972d8a671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3784
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

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
Some incorrect coefficients were being used

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 275f11f8bea3..2465c88e2879 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -61,7 +61,7 @@ static const int32_t regamma_numerator03[] = { 55,      99,     0,  0,  0};
 static const int32_t regamma_numerator04[] = { 55,      99,     0,  0,  0};
 static const int32_t regamma_numerator05[] = { 2400,    2200,   2200, 2400, 2600};
 
-static const int32_t degamma_numerator01[] = { 40450,   810000, 0,  0,  0};
+static const int32_t degamma_numerator01[] = { 404500,  180000, 0,  0,  0};
 static const int32_t degamma_numerator02[] = { 12920,   4500,   0,  0,  0};
 static const int32_t degamma_numerator03[] = { 55,      99,     0,  0,  0};
 static const int32_t degamma_numerator04[] = { 55,      99,     0,  0,  0};
-- 
2.25.1

