Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A8C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7103861178
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7103861178
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287B76EB35;
	Fri, 20 Aug 2021 23:30:50 +0000 (UTC)
X-Greylist: delayed 902 seconds by postgrey-1.36 at gabe;
 Fri, 20 Aug 2021 23:30:48 UTC
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (unknown
 [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62BD6EB35
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 23:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LounsWSiKmCop+WO9kP+YCpkShYU4u6o+mdN+0sOlZpe0ETih2FSMKY3+YJjomTUtRJAg0VwMPjpy7lDashaGjdrq4EsKNJ7WbiyAoLsIk/ffS6WpUn/Cw/57URSopnMutaOIaWwR/bpTDmmWLZ6GHOwcTa5qRQPUWiBQC+Ig2SXbwKR/2MJa2WIUFvs8vLoemnnRA2jYv05tzzIClvjPjouJX1vBUBKJCMuD1qBjxNwD2f7/A1rXjafVLueLqEO2v2J44iYL411ZiZFEY/XXmeN0v/zE3GlVD0KMgCjxQrOh0IOpLok3//8TNB/e0Gnw1V0hpeBKrXb5X+AfeRpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+dIaVNysnqoI5Fx/OCmQBUplj96F7pd1UzhYrqOceo=;
 b=IqjcJHdrAfuNBBfX7hqO45/rDLwBxLXOSqlBZzbcedz5oMD37feoQ3NGerC1UKjqBkS0KJvSyB10k4bZ7r6GWTQaQDXh/nqOmDz8pgsTxUktoUsaNHbiWzFnrzo8FXl5fmb2kE7reu60SUfNkSShFLQSdzRahVOAKj1Hx6LiKYIpuInf1O5puBT8BKPHdzoUYfLDtU2rLcusQmMdYPwUq1Rwt3cyYI1w9T4N5A9RDuyoeALXc4WeKH8ZF7bYZUsV9U/2ofisjujv4AdUzzASvsm1RE5XOvoktEGkZr4vE6qmGnXqTCIKDM1Vm5iqLX8hbLQUTI/DE6fMvybdsUMrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+dIaVNysnqoI5Fx/OCmQBUplj96F7pd1UzhYrqOceo=;
 b=xeuwCTKrWs1P7PXDUpvw9PP/gNRyna/3GRfxpzEH4OzdwcZl+a5XwqmoJAxE1mm6JHwd6uEqrdK/daKVxxDfOVW4SU7PzM+eNarkzkDLjXAM1r8JNpmLpoY7WlFdH7RotAFLjG+4Su69lQDoVXnVBd7XojCABaiK8OaBCuMyuwE=
Received: from BN9PR03CA0491.namprd03.prod.outlook.com (2603:10b6:408:130::16)
 by DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Fri, 20 Aug 2021 23:15:47 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::64) by BN9PR03CA0491.outlook.office365.com
 (2603:10b6:408:130::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 23:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 23:15:47 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 18:15:45 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 10/10] drm/amd/display: 3.2.150
Date: Fri, 20 Aug 2021 19:15:20 -0400
Message-ID: <20210820231520.1243509-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
References: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29d60c78-7d2f-495f-e2a5-08d96430715e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1578:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1578C9E717921FC90015211FFBC19@DM5PR12MB1578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbpV8Eh4zNAelaU38GHxsIOFUS4EU9kPqK2ruMSRO79wqpyBrE1Nwd5db9X8/KuxV8y15iVO7QBM8ymuRxtRvN8ChgRpzgX1kpeuTgrUOd49Dl2XB6evLUXkbRdF0/2otLgoJB4nVSDoU5yVdqxHcMSkV796tcuIUozgYaYJjxQHjRGnaqiNbrfsy2Lv0Nh8VECyprEDQuSNIhozpsIkNGFG6A0zNt8yXTL2TQ732hUKhOXid/NaX3liIxx6x5aQv9PhQoqdq6IaOTRV55w09pVOHLFU1Om1Nsd/83zoyytnPI1B3n+O5ChwMbdMicznFRS+BjXdmEDvI686Jy5VyEs6ah24RyElaA1V5PHpwmW8zAWcNgyhF5Xm4uHCcvPCta6lPgtVPl7vBGQON0nb/GSAim/OyhyGlSU1gyuU0qk1JoTJdIZClon0AnhccDwWclT9S/10kFlYtXYzgWPepVemm4u0f7lZhhpbyZekNLNePDiluPF4gS3/l+B7j4G26kEyENz5Nz9E7+VX8do8FO1a3Ce6PjEg7o9lc3FprQNJtFlcyP9v6EQN0+9HxyrHUXHxRgVJMMXMJvEhk2F1eIVWYxXhaDZAy9jZY680kJzjnS2i13UkREYyOBUOQtvx2HNo9BU90ABK0SH2IWxHyvKUw66F7msPj+Wy/4OYIYR9GlKgl5DAvYk292yqPq4U/Tsw9ClajGTlPwfVRcBTaT1Q9mBClMoWNRPXuoCERZojRXmotXHLK/5nIkwf8mABkyue2+pWt5sxAbH25xHjsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(36840700001)(46966006)(356005)(47076005)(478600001)(34020700004)(82310400003)(81166007)(86362001)(54906003)(4326008)(83380400001)(26005)(6916009)(1076003)(2616005)(6666004)(426003)(36860700001)(70586007)(5660300002)(336012)(44832011)(36756003)(70206006)(316002)(2906002)(8936002)(82740400003)(16526019)(186003)(4744005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 23:15:47.2467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d60c78-7d2f-495f-e2a5-08d96430715e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1578
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- FW promotion 0.0.80
- Add missing ABM register offsets
- Fix in swizzle mode mapping
- Emulated sink support for freesync
- Improvoments in max target bpp

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3ab52d9a82cf..28aac18ae1e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.149"
+#define DC_VER "3.2.150"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

