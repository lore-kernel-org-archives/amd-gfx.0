Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DF8C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 07:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5FD2054F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 07:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bRgipagN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5FD2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53BDE6E9EE;
	Wed, 11 Dec 2019 07:36:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2906E9EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 07:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1AQJCbciD3ZM3b3UZqjLLr9FeJWPUrArhbNwKKpdaVmO2gJIr52dCjV4IpZflG6O6CALA3UM+QuagzBQO1fFN1Mwx3cw+DpDYRTEBDVv2i+i4t2b6tTTuN3Ej+S6wtNa5ene/qPoluwjvrQRH1OEgi9r0SUNp0WGvI9iHLZFJNvuA/7gv2Kx3MBuNuVqZbbwjjLsQoC141uryJqCYjwE4fEHUzHUtecDydNENw08S+w1+t0UGD94DChIcrAPappZpdZQCdsexa/pLhYzg4A+LheIzNLde9rhRMr1X90DJgfWnlzZV4f57ZltQ+a6I/79Iig/s2YI+5W1K7LI4hWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy2r5L2Qb9ry0mM68D5iXj2GkwgwXRBKwakEDQnZ4cE=;
 b=cbaKt7goKuPTysuUxNT+YlSyRgdmqb3vL4QdVmFbSPNwnqfXqq+r8MKqNohrRNVs0Fpk0zO2EN7y9BOE+E2BNHIL7FpEr8IViwErQjbDBtWFdBAREfw2X6SEbHUUPprCOhO7IisIOOJwPrCvLG7taeCwoo/6NUdXJ0LzgtyOz7NCJJYno2Yidz2QoTllfoLTL9T2EE64NGSZYzZJ3Sl8o+9yK8jDkLvQ1I63jF1ycf1B05mpGVaLkrKXm01iVou6tqRBM6nZnX+jSWCvOvmcV2qFttZIjhxAXJ0TY2zcKI7R5TqGD/M5yeCBejlciCMJ6TZJnd7F4xBcV2zNDM7yCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy2r5L2Qb9ry0mM68D5iXj2GkwgwXRBKwakEDQnZ4cE=;
 b=bRgipagNk+kD+AL3rHR5EEq7lWoUU4DO5k3AyhfOT6s1kNFNsYv/7cIsVJIn2rk6mlbW8Hu8R7Ll5iBtuSPovkDn4+S8HvD1hwIlkGPdBrNVLd2mb/ziWdMQeS4E91+UcNIusWQoUqvrJLupM5puIm0U1ef4qkMcrPA6+9fIRbQ=
Received: from SN1PR12CA0079.namprd12.prod.outlook.com (2603:10b6:802:21::14)
 by SN1PR12MB2590.namprd12.prod.outlook.com (2603:10b6:802:2e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Wed, 11 Dec
 2019 07:36:07 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::204) by SN1PR12CA0079.outlook.office365.com
 (2603:10b6:802:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 07:36:07 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 11 Dec 2019 07:36:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 01:36:06 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 01:36:06 -0600
Received: from swae-HP-ProBook-455R-G6.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 01:36:04 -0600
From: Louis Li <Ching-shih.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/display: Fix AppleDongle can't be detected
Date: Wed, 11 Dec 2019 15:33:38 +0800
Message-ID: <20191211073338.25373-1-Ching-shih.Li@amd.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(189003)(199004)(70206006)(70586007)(36756003)(86362001)(4326008)(7696005)(5660300002)(478600001)(26005)(336012)(6666004)(426003)(8676002)(6916009)(2616005)(1076003)(316002)(186003)(81166006)(81156014)(356004)(8936002)(2906002)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2590; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 108f0a90-3cff-4c73-9d45-08d77e0cc8bf
X-MS-TrafficTypeDiagnostic: SN1PR12MB2590:
X-Microsoft-Antispam-PRVS: <SN1PR12MB259062CBFD283B2FA12CC68CAA5A0@SN1PR12MB2590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7dhg7s7PDG8PfIfkU7jiiA64lqP3bsFsqRXSNXEsHodd/n91iGH6qP6Kxsuc/vWFNDI+O1iJ0U8NNLPM3rXLuzpjru4dwduWnpRlhSt4fNrqiN9DIzAeJJxz861L+68Ttf973Ux7TF3GNrzOyonM2BPMTUtQs9Hbqw1esPGu88LXpxPgcfQdIK8gZyNPIkamI24+g6OQbuc1zPBn2UaxAHO6RXrne3eW5yK+Y9kXzwZhuMyc3qThtMCHNArLQXOzBXyIDAok6f9QLRLMv9tPzWgWgYwtfO7Ia6EQTG8HoLkooKvz6AqbzmgsaQuE9ypSaU7ZYuoFceS6lEDTziZ3XRCxju+jjadJzQMWk6bgVvMHXpnitwt4c/bU+sc+Qyzc0ImojbHrjAAIE1oUO5kU2gIA+Fk/6h2icAcVFWF3H5Yz8ibRA+AZM/xafV7nKCn1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 07:36:06.8492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 108f0a90-3cff-4c73-9d45-08d77e0cc8bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2590
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
Cc: harry.wentland@amd.com, nicholas.kazlauskas@amd.com, ching-li@amd.com,
 Louis Li <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
External monitor cannot be displayed consistently, if connecting
via this Apple dongle (A1621, USB Type-C to HDMI).
Experiments prove that the dongle needs 200ms at least to be ready
for communication, after it drives HPDsignal high, and DPCD cannot
be read correctly during the period, even reading it repeatedly.
In such a case, driver does not perform link training bcz of no DPCD.

[How]
When driver is run to the modified point, EDID is read correctly
and dpcd_sink_count of link is not zero. Therefore, link training
should be successfully performed. Which implies parameters should
be updated, e.g. lane count, link rate, etc. Checking parameters,
if values of those parameters are zero, link training is not
performed. So, do link-training to have detection completed.

With this patch applied, the problem cannot be reproduced.
Testing other dongles, results are PASS.
Patch(v3) is verified PASS by both AMD internal lab and customer.


Signed-off-by: Louis Li <Ching-shih.Li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 7372dedd2f48..6188edc92d0f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -725,7 +725,9 @@ bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
 
 		if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
 			sink_caps.transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX &&
-			reason != DETECT_REASON_HPDRX) {
+			link->verified_link_cap.lane_count == 0 &&
+			link->verified_link_cap.link_rate == 0 &&
+			link->verified_link_cap.link_spread == 0) {
 			/*
 			 * TODO debug why Dell 2413 doesn't like
 			 *  two link trainings
-- 
2.21.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
