Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948CFC55179
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113E32224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TfhWJoPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113E32224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E0E76EDBE;
	Wed, 21 Oct 2020 14:23:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136036EDBD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvWxzGyWpsJNRrAHvpickKAidNMx+8pBx7oH/h/Whi45UlSc64hU2YJu93xiDzHM31DY7SXid5jPtz6VcHp1GXW1ufUVYU9wgT7dnTV3/o9g1IsNaMGr326zacvao7tQRRmWYG+Vk6zkG/bzvlBdD0Xv74EeMn0irYVB7NFHH5AhRc44uMlt6dNsoZLGYf5Qwu86MuYncp2fnNgIeKdYXflmXIY8/y70KD77ha+QB/ealS2+tsXv7OtpbShvQHy/U3R3nl6w68vfi0gQpfGK+0FzkponSG3XWYFeK5y16q+O/UVOhTDcwiOK+xlXymXhh4IYV0a9Crl6sAyWc/B+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZOg9US0FxZRbfPmTuekx6oj/wStwbOFh/CvDWsxrpg=;
 b=m+8yI2fjhMWRPPPnjJlUpngtWRfOWit61jJbYtZtLxAa+Uc1P++jXnH6B2+FCXNYV5xDOqG0I+5gx2RGhlRR76YELlkBVV02QdR11YbNJQmHo8anDe2IjsI7FSOyN+ST+gXL/KPmsVF1E/pTImQyQPMEzfT2sIDp9pu58hOQPe9nuJL1HVtiBa+edTpPPHshEZzNJQhD/I+9Il1AzR3St/BaMhvnxSz7Obr0NrdLvGpER7y66LhXLMogDmOw+uP7D7sbPdRLE0/H2Ubav3a4g+fxg+asbXaosO3YzvdRhyMSMgm52T6xV5t0G+C8W2BLyXTFXmgVRP3keAdgpNey0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZOg9US0FxZRbfPmTuekx6oj/wStwbOFh/CvDWsxrpg=;
 b=TfhWJoPIy/cBoIYgRdMO2GDnIlk32Hl/2pt8zWfBF1zkQduMupQkdynQ0D3yH/Qlvupfrz2ja37BK1UgpeDv1uwgvgqBppI5lViMR+sLZKwizxR90pRU1aZuk2JjSzOMgho1KJmvGJHxaxB3nDzARPu80Uex6s/1RXHW9dsQ8vI=
Received: from BN1PR13CA0022.namprd13.prod.outlook.com (2603:10b6:408:e2::27)
 by BN8PR12MB3506.namprd12.prod.outlook.com (2603:10b6:408:9e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 14:23:11 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::e9) by BN1PR13CA0022.outlook.office365.com
 (2603:10b6:408:e2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.9 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:11 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:11 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:10 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/33] drm/amd/display: [FW Promotion] Release 0.0.37
Date: Wed, 21 Oct 2020 10:22:33 -0400
Message-ID: <20201021142257.190969-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6a0c7ac-671f-49c0-3ff0-08d875ccd721
X-MS-TrafficTypeDiagnostic: BN8PR12MB3506:
X-Microsoft-Antispam-PRVS: <BN8PR12MB35062F84CB705FED4E53B93D8B1C0@BN8PR12MB3506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndqkbMKohWaWtN6Y4w4TaEx5nV/8AJrz71omHDWm5eu65lBNyBM/I2Y7WlE4aEI7cZU+3SFSbEFQKHpwU7D5DdQJbAQIjOrnEAbl7Igc8MkmXsCB9T3MPRd8lLcid3834ZbJrnTEtrcfnygqDYKDxSerYAkzmTEPEk2d7cuLxciE5J+dnQ/KLGCHuLDWm10e2Pd2pZUU/H0zxXURw02QiDizPR/qvi7zmRMZvbkbO034kOgzhY2QuoxoEsLytVA5R13QKroOqd8QEdhrVXX2OlZFmpqq9lEpVH3Y65Vp9/pVnetwNtEJ1TwunI4PIWhR4OzrJQZ2sHm3T9taPgXK6MgTQyRmhHLYIpQcvu+UzG5eRuA+SMagN+JYIV6+9Va+Tzke6mGLsRf8aI1E6Q4brg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966005)(6916009)(81166007)(47076004)(86362001)(356005)(7696005)(316002)(1076003)(478600001)(82740400003)(8936002)(54906003)(5660300002)(4326008)(336012)(426003)(6666004)(26005)(70586007)(186003)(2906002)(2616005)(83380400001)(4744005)(70206006)(36756003)(44832011)(82310400003)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:11.5564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a0c7ac-671f-49c0-3ff0-08d875ccd721
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3506
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

| [Header Changes]
|    - Add GPINT to change timestamping mode for traces

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 26a4c6caf606..e6166a4ba71b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x959f9d769
+#define DMUB_FW_VERSION_GIT_HASH 0x1893cb959
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 36
+#define DMUB_FW_VERSION_REVISION 37
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
