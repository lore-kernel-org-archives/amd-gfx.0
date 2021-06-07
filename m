Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BCC47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC54B60FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC54B60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A33A86E940;
	Mon,  7 Jun 2021 16:49:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF916E940
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/mb98/gULKmH4m3FucAcjU5OYWiVGeB73LREtrjAQh2ljxVAQVswd/KkloLvlgrxhJ1kUc2z9RqliuBEMHfI6/u8FylrXKhRNOHe9lJuIFjI4AsMBCAYeqTPzTsyKOaoEBFGSY6zgnbksAByxPK0mAluuwQYjrEzXgc+GC82dS3Dw5ni/eLAs9Uyyb8AQppBWWX0RiBIo/sk/29rdPCy298R5OTkbuLSdVnBeNpy8ApgiBpauVjK2DCy5SuJl1j3CogGR072LjZiYfrmZ5H5Jo1qx70YcyBhPUz7GZa+4gy6yGdBtHT4ANwHe2qAY95LZDggFVOBPY+z+tB9/WiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih0I8/S3DIDmmWu+Cmq/PJh7CZeihFEMKPUD87ycZOA=;
 b=Ar0cPLXvU/69VXWYQ3c7IgUcS5qOWnrC5FK4G4ObEw5Ji6ocjgg7GFu3cKKQ2684yqeQORwUU1WaSypHgFyJAf7OUitBPae+cZLsgT24U+BbNNC1J9/a9dRDaX+wdvC0SaJGSz6DNbIoOerhgxuUjZorPaXWzlQf2RTZcoXQJhK3WgtEzcyWKeCUseSCfZbKcMZvlyTwM2Ly97S/ZY3RZUq56nXiB6HW2Fj1eNno92UhcuH75mE/naphIVO32EC9xLeit8zWA9eRvNrRp/iglvnGxNurIxWivdZUB4Z8ZORfkDGd3P9iRpHTXTo+OYtuZekLotgF3Rml9PSsDVLflA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih0I8/S3DIDmmWu+Cmq/PJh7CZeihFEMKPUD87ycZOA=;
 b=bKmCFx+qtEpdAvi6Gfg0lqKDhTEgycN26q3tsXLh7opnKsRSMSFkHVMMJNUDd1pQLcyxK2p0wvIUKWMprNvj0medSZf0x2hG6L+lxwDOpALxswioF1ILFOy1KgN9rW8IDRFll5Nrd6j3KJqSk5tJ+Ov/eNJ5F0cCkEE/MJwWca0=
Received: from BN8PR04CA0015.namprd04.prod.outlook.com (2603:10b6:408:70::28)
 by CH2PR12MB3687.namprd12.prod.outlook.com (2603:10b6:610:2b::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 16:49:28 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::a4) by BN8PR04CA0015.outlook.office365.com
 (2603:10b6:408:70::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Mon, 7 Jun 2021 16:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:49:26 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:49:23 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/30] drm/amd/display: 3.2.139
Date: Tue, 8 Jun 2021 00:47:14 +0800
Message-ID: <20210607164714.311325-31-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 615fbd22-374c-48bc-1537-08d929d43616
X-MS-TrafficTypeDiagnostic: CH2PR12MB3687:
X-Microsoft-Antispam-PRVS: <CH2PR12MB368731C451BEF08385112845FF389@CH2PR12MB3687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcwKcjxszAiKytnYgSndeJ62PXkZRf/BkDgm5Tdi9z29tLZYwkhdrMfvSbb4mAoLO/FrUJL5giceUbvqJ7tN4FYQcK92IC3+aF7vQvU3NA6xq9qPXUj6sfUjCIGxmS2PMTvhdoprhr6g7HP/1D0rKtOPAhKMZal9Dgp6zQOCvyq5LLEoCv9IXmbIeuxjJMc4k7PrblsU0FM+Aa8Xm5rEl2O2Z2DHRrlD7pFmnkEQzz60kFPFYxcKN72G5fqBTXDYxPvWhRLAt2u9k442Qst95OGIAY40h7XpcD2HvMuK8oV5uCDp5LLjrvnI5rWtyYIJIYdKbEZMxpyXAUazHx2DJD3rnfZ2irHpN4mJKKUJUVgYlpCwvSnSUJj3KX7WFLUphBWoMjAk8lFkQEAlEBMim0fZMJTxdtsUl+KOH0T5SN6wWeB95wYWCJT5pdAsaDCtCjOej52/JHDNz5+0GpySX70V8rG99fK31BTTnoxgvnGCTesQUYpGsnlRqpCzqgkT3rDZCE/LP1nXrRqon7z298vPCfSAJqfQmso/KLELbwJ1e69jeEHxjnyMGMe9n2hOxvnYtMFLPZMX1Bv9/lUjjs/4Z5j7Wp9/sVpGLE5f3GOoVy7XSAkaNI3FEOb/J9amdfvByG/k8+bZoE9tjS2Q3HU5nHnvgXFCDdD1pfdoq9jPgzaBppdoDtffvHHzHIB0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(6666004)(83380400001)(316002)(70586007)(36860700001)(1076003)(81166007)(16526019)(4326008)(186003)(70206006)(336012)(5660300002)(86362001)(2616005)(36756003)(54906003)(426003)(47076005)(8936002)(6916009)(44832011)(356005)(8676002)(82310400003)(7696005)(82740400003)(2906002)(26005)(478600001)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:49:26.6424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615fbd22-374c-48bc-1537-08d929d43616
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3687
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric
 Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b4104b7422d8..1d45f8f45d61 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.138"
+#define DC_VER "3.2.139"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
