Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD87AC43461
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 21:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D58F2078E
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 21:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Dx7tg3Js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D58F2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E9D6E1E0;
	Tue, 15 Sep 2020 21:38:58 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750047.outbound.protection.outlook.com [40.107.75.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4416E1E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 21:38:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCMPZiLiWIEZThwPKAM0z7bxFGkV7HUGcRHzt15YvhdaH3SZi1ZoJCokwosJP0lHsfiuUBex4xkxpZRIiOBe2XDtckSBFW8mDpJxga1GmpI1nCu07Uoc7qj7/HGZS4VRzuo3vGuV7RLP+zcoOjvVjKHe5uTuVjVrcV8B56FmQ+DkBMnQHb0aHjaKkiEy0ctM1Z8r+XQUnogznFHSzE2PcbEH52SOWJNKyE744Qy48fwdPjhMj0ujRWHJxwlFfBnMwD/evUiMRsVCs3WiWL7RWvFu15mIMpCSQtdvJteh2r6Av0MiPcsuArBZvoWaD9CnKs57OLlHUybv8q/adGgI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaW1Zgr606zXlSmjbaupZxkb5+3CIjBrhtItABshm8M=;
 b=GHHC+lhCrRLiRDni6nWWRzFY9W9ekQaZrC4x0Y33FubAtkt1RCAlxYLcC48zbH5XGmj1+nhab73V9tKSHOcZn48sCnJFIhNkRIrJ0TKwslmihXvf4pNz+Q5PEAog8ccaLrv+083in+02OuorOtCDdSUv5dozvuBcOBFHInziszo2RPqz2cOnx4rcg4gRDnUyn7Mvr7KdcAYrYSWkYCPYEaRdTCyDFNVLxP70K/hJhf8RWoTjhIkkklBSsrKaMsjRJQbkcMuEoPtBpPZURcd1w8tsrlSG40lBX82p91rvvy7Fef6wr2Nz+xqA5B1nxKfOOS78F0OoFpTQoeg7PrC/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaW1Zgr606zXlSmjbaupZxkb5+3CIjBrhtItABshm8M=;
 b=Dx7tg3Js3TFffePenyYSzNTBiy7TjoU3Jl43mNHIwe/wF+VOw4ryBriAVlkmI5xjXVpliUnrvqJiWA2B1HAn6k8YJUrdpNQ1WQj9uJyB803aWAKpDYfDVC17cRMLA0ZUYuwT3GZ4pg6kDl+MVpPSsaQH7Y+t1pWqso3Q6K+snAI=
Received: from CO2PR04CA0136.namprd04.prod.outlook.com (2603:10b6:104::14) by
 SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Tue, 15 Sep 2020 21:38:56 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::a6) by CO2PR04CA0136.outlook.office365.com
 (2603:10b6:104::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Tue, 15 Sep 2020 21:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 21:38:55 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 15 Sep
 2020 16:38:54 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 15 Sep 2020 16:38:54 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Don't log hdcp module warnings in dmesg
Date: Tue, 15 Sep 2020 17:38:52 -0400
Message-ID: <20200915213852.3383231-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd460403-296c-4884-b4ce-08d859bfbf50
X-MS-TrafficTypeDiagnostic: SA0PR12MB4574:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4574F01D33F2E8F1725D8BF4F9200@SA0PR12MB4574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6fibFFldl2ZMijOdV918D2Ee1MOXcSnUmE9+niSRGtkXk8i8xBxJokzJlawCeEBC2Rd6sNrvyc2ueUsEbgd1bqqBE/fourPVjYOi91/ec+WOZAWiM8m+yd/ULR/fCV7zaVq4QXa3wK7IAu1GClIhA6Z4mdtT6WiMCqNSqZQfocQ02KOouuYMxIunNxgTW/95/+dv4pRZqp2xnYIxNSzOfTlwm7M45aCujKbixwKmlD5bBhsMk1xNRnjuk+POK+3q5j+Amqfa8wx98YEHTpzeOPfBSlXMXV/BY/3hD/BIgCAp2H1ENKCRD/R7tlsAGiwnN1bUAI2VSLWSk5wM8UbJPmYCD5meQk4S17M7WevhD36hcOM10nX1m3zSS1VtBnQx+AKqSUc2o19XdNouKEpAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966005)(4326008)(8936002)(82310400003)(6636002)(47076004)(186003)(8676002)(316002)(82740400003)(336012)(36756003)(2906002)(6862004)(86362001)(26005)(7696005)(70586007)(70206006)(478600001)(1076003)(5660300002)(54906003)(2616005)(356005)(81166007)(426003)(37006003)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 21:38:55.4689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd460403-296c-4884-b4ce-08d859bfbf50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, rodrigo.siqueira@amd.com,
 nicholas.kazlauskas@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
DTM topology updates happens by default now. This results in DTM
warnings when hdcp is not even being enabled. This spams the dmesg
and doesn't effect normal display functionality so it is better to log it
using DRM_DEBUG_KMS()

[How]
Change the DRM_WARN() to DRM_DEBUG_KMS()

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
index d3192b9d0c3d..47f8ee2832ff 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
@@ -27,7 +27,7 @@
 #define MOD_HDCP_LOG_H_
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-#define HDCP_LOG_ERR(hdcp, ...) DRM_WARN(__VA_ARGS__)
+#define HDCP_LOG_ERR(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define HDCP_LOG_VER(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define HDCP_LOG_FSM(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define HDCP_LOG_TOP(hdcp, ...) pr_debug("[HDCP_TOP]:"__VA_ARGS__)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
