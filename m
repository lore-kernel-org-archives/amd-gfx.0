Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F94C4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C1560E52
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A6C1560E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72AD76FE64;
	Sat, 24 Jul 2021 04:12:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B76576FE66
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRRimaGx+bN4yNLZjLO2qehBtQYvZUpTALJ/xJSzZFcoWAA01Ty56KU5yOozjsXLtNJIrxAUAUrYwZ60GZateo0JmmLON4XT9A1Vlu1yOYcy4v2pwlJL9oAXrChJ8u/28EyIDt1KOwxrwQBwdn+klSU5xHvhPJMa43jqvCHVqDXNQG4DW7wua7oiuEEdUTjK7P6K7ghEDy7k4V6EUL6NJXdG2/ojECjcPwYlmq57a2cLuf8+uAws4mvq8myHm/2XRROBXC4xkrV31Vc8/WJ7ly1C38B/x2IZyS4pGFi2PKXFHTSqCItnBnnowNSYU2fbHT0Ar/4KiBUgmazX4jqfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBKtYEX7mOQsFA6GohMiMOTmTX+XiCkcbm5fmAfKDL0=;
 b=eiJHhiAjASUE0MnNWdeCQXpbgj+hpLHs80APiZDl6BQvJrU+bWnmbYOHpqzhjxaW9BOJaxMhrwDlOmBkjmqvfH4fxyrP1yQNiYveAeSA0ASK2oUUa8UqHGJ5DS+c6oNWIsZV21XMHv/hL4SI77qKc6Gp1iThffg1DWHIIYCO1AdwdZwl+FMwKyE4AvV1EWTGYZiXpqMlmTXpIv1qkD5lymPancveWU2IcA30ZkepLnaSH55CLl12eOH4ACnTXLMC49P7toYj++3D3Eb8foIGpS/oeqECL1iBACV+1RL4bA+MqbPgvx6qTundG6g+hnQ3QTypaRgneKrgoLEGpAnSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBKtYEX7mOQsFA6GohMiMOTmTX+XiCkcbm5fmAfKDL0=;
 b=uCr9/5ZMbbagiXJos7Durl3KuTV5QUezaj21/LhlHFDqsgRZf9gvXkmmUpdqPmsK7OP9PG1AA9y8KHDRkHmfe+XRf+CO9iKZ3nbHd0n+Fb9n3KP7Eby8B2eqYGagK7nUub5yX+uHmVA7li3RDPZx5urhDX5wWITInchmOKIKDaU=
Received: from BN9PR03CA0099.namprd03.prod.outlook.com (2603:10b6:408:fd::14)
 by DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Sat, 24 Jul
 2021 04:11:55 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::df) by BN9PR03CA0099.outlook.office365.com
 (2603:10b6:408:fd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Sat, 24 Jul 2021 04:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:11:55 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:11:52 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: 3.2.146
Date: Sat, 24 Jul 2021 12:10:01 +0800
Message-ID: <20210724041001.3875757-15-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724041001.3875757-4-solomon.chiu@amd.com>
References: <20210724041001.3875757-4-solomon.chiu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38214a0e-cb50-470d-4f92-08d94e592c8c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4153:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41534C6575B336ABA25FE11997E69@DM6PR12MB4153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkgUqhfJE7YzbG8uTQOCMMHU51hUpP0ZcM6KqZW3q1WkrpSFhSZWcySf4nxF7Gju8zqOlFSrgjpHNwuCg1zJJ5yD5NSkbCBctrm72TgiXHsl6N5EyoY2NEOMjiVJWU8ndAiufP5UFo2vPqrNdB4vPo3lAbXOuGm2qUBzY28atoxPZiUgZmpue1C3VD73dKJCLwAD/zlZumS2JfM6ZenAJwiWcdALe7vpynsqFtmpiNOSa5Bi5XBSzcE7+RnTjHwdXU4WQXjyN99/Y+5fhltel8sfAtQLaK9lCt5NsIPEQSpKMMjzugD+F7Ww6kBaMh+WSk1VMIp7qLYnjrmJN8+dZMjMIe9wsGkaHkhQhPqV1FzsIq9hVtx+6EgHOHvoAg6NaXvJc6i4oScAvDLRa4mI6CvPELa6So0QY3k3FAUP0NdTz5VQxTX70KhFh6N9PUMtDRz59KZ2JEEaNfTz0Svzs6XZ02Nic4DkCbCwvMMfX64dHWxd2SbfXwv2Hipoj/eUWvEv2oIRCTrbG+V4YmV1MZilYP3ngjIISDwpaWNpF8yVeNn3aZhSJ5/TrRFB0e2iUHtQT/Uxq9gDJwviL076XLPgHQh5Br/E/SMLos/7OntA8rtuuDR8XVY4EK6fC8vMQzoqqvdLnXXJf5zqRE4EYpixzNyb21OjPImcnMxGN7N+25I1eGI2DQPbbkxzUm89vsM0ESpdglVjt/mJvsOkZdsQ2PH/TKVO43/lGtLjVHo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(36840700001)(46966006)(1076003)(82740400003)(7696005)(426003)(186003)(70586007)(2616005)(36756003)(36860700001)(86362001)(478600001)(16526019)(70206006)(54906003)(4326008)(6666004)(44832011)(316002)(8936002)(26005)(5660300002)(356005)(8676002)(47076005)(81166007)(6916009)(2906002)(82310400003)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:11:55.5544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38214a0e-cb50-470d-4f92-08d94e592c8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
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
Cc: Aric Cyr <aric.cyr@amd.com>, Solomon Chiu <solomon.chiu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Hsieh Mike <Mike.Hsieh@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixed:
  - Guard DST_Y_PREFETCH register overflow in DCN21
  - Add missing DCN21 IP parameter
  - Fix PSR command version
  - Add ETW logging for AUX failures
  - Add ETW log to dmub_psr_get_state
  - Fixed EdidUtility build errors
  - Fix missing reg offset for the dmcub test debug registers
  - Adding update authentication interface
  - Remove unused functions of opm state query support
  - Always wait for update lock status
  - Refactor riommu invalidation wa
  - Ensure dentist display clock update finished in DCN20

Reviewed-by: Hsieh Mike <Mike.Hsieh@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2f3810f0510c..a948f4f48935 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.145"
+#define DC_VER "3.2.146"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
