Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7507C19F2D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 04:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B044EA1129;
	Thu, 11 Aug 2022 04:59:20 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2082.outbound.protection.outlook.com [40.107.96.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46954A10F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 04:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHfK62sXSAcE6pySyd+VRSeT70r0nZU94AYKeSY2NOizkaAtXcC4hQpnpQCW/BfwV91pEUHgv6+O0GAbDdZlCNn6ULJD0N7NirMPGcLqa9TI1/DC90Raloja7Xa2+ENiTr/q8QU1fBXYnX/ePogWdDTUPnLDeL7ZTZP9aIy6bzQC4CwuFpL7+wBCBvsbWPToDm3KD0JEHPdAnrhwAHVDPX0CtTKEDjten0O+GO5KYWS26/ApegbJ9Xui0255RGnpmxtlICySEb6YWl0dEFM09K4VzULUWLbjqpRBCs4dO1cvHCmQcfQFi91Rlz0J2kVt/tSmkxvEKQIzG97F2DBkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuIXy/UzN5NxkOt6m45Mqk6CwMD+trXSD0kRcJyfeBk=;
 b=odQcKsHtomaCaACoLnyVQVvXqGQO61P4oOwUOvHhSFCEzwHh3E0+5rSOxF94PZENB+DjNL8hYdMDiJD3Hm0+bvWlju6S9xwx4QGq0TyNPkHLRvtl9vcBeXN1NNX+toriA7hLaSjc4gdCKm6pyP2MBZohvek8WnoBGfM7KCSpQ7J1V30LxaV0tVYat78+1ZKFFP+34x5xjopAsG3VgvP+nJVvCL/ORERMGkGEOe3FDCDYZYRxMBRrafg1v82ZzzlgIz/PsjYcfzuEH6TXIQCFmggkRgH3XQmXj5rVuqt/JKl8gz7V1kCY1HJTi287FSPScmUa7oFw8PTTF3O/cDSdjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuIXy/UzN5NxkOt6m45Mqk6CwMD+trXSD0kRcJyfeBk=;
 b=sKq/0HCXK/O5Hg6+8AoiBebbGnxrTZx6ymVtNCR9MO27UtgwwRGmnoRhfaFKL8Jc8QUAm5ENacWRkLWT+ShA8fK9Xh3zMGLVD4f1WVVZyquOYL4J8aBk/sLZG4qzQZUfBVF0CTcKvh8Q0gh8Puu27qDEq9aC3h2Jpe+WADW6qV8=
Received: from MW4PR04CA0126.namprd04.prod.outlook.com (2603:10b6:303:84::11)
 by DM6PR12MB4985.namprd12.prod.outlook.com (2603:10b6:5:16d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 11 Aug
 2022 04:58:41 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::3b) by MW4PR04CA0126.outlook.office365.com
 (2603:10b6:303:84::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 04:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 04:58:40 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 23:58:38 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amd/pm: update the smu driver interface version for
 SMU IP v13.0.4
Date: Thu, 11 Aug 2022 12:57:58 +0800
Message-ID: <20220811045804.3750344-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe30febc-7267-481c-45fb-08da7b5628ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4985:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbR3scOqRHI6J+QjYXh/PjFlLPgJ4tilThOjFOeBKWlFowsePzRo+Q6v0JbajzFoPtP3dZ+NEyJoix6nK/2LHXc1D24OtxqjnkPEEzPhkmrBQYqL24RaIpYCvPatmPvuxJb7f1srU+hC4YD6wWHHfVkaol85PcVI3XyPajSS1dr68yscQ3DJLWQ6aYMbHg5RqvxXaHGJ/5SejHcjrm9IVJg16As+Oj8Bmguib2ATMqIgNSTtlM89jhSWyyXF14Hl22AT19Sb8EMCL4jMSWyOpv+MV1jdTB3RP0529QCz+agEAraoW+fO/deLQ3gAoC/5KCK6sMVy3bdpDkF4ls1ZFzfcdtlKkfrDzxyteX0DgG9F9eZplLgCqZ+Ey/fT9lZu6q9txkRyaYuFfz9EcZ+6VyWSsUeSlHlMWVwc0Au+gzlyK/OgSIP4180TqdzuooQpely+ASMYN877ot5NC2XSLccH/nXcEeJYL5UNSq771/woaV3aWOCjH8tpsdavq1jVGUArkPHItGWRzWeUeVIdXDAqAlio1xxZLLaud5GHOPBEJ+FRoQdzO09X6H6C/vPn6/Zat7EHqkBoW+PKqflJ4nxyEOBLfV1z2TAdAuswg0n7xMg6PKh46OezlyNlaTZodfAFXO8Mk6bztbeoS0x2KG9VPSsimgCAsMGKnOgHN0mxyX3Zyn07Ihr4cv3axI+pElo8kMImITQuAkk6wrpO0uxINDboe1zeagI3UnhKa+O+E2at2/ZcxQRRI8fdj87B4DmQNJCSZdckLg5BmkPppUn0ehqrH2KO1xG0dq3ZIFSPAwMKvuIYAxg3LLXCKs1LlKgdJWfecTBLQwEgipXMjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(426003)(47076005)(16526019)(478600001)(5660300002)(186003)(2616005)(7696005)(40480700001)(26005)(1076003)(4744005)(44832011)(6666004)(336012)(70206006)(86362001)(41300700001)(36756003)(82310400005)(70586007)(2906002)(36860700001)(81166007)(83380400001)(8936002)(40460700003)(8676002)(4326008)(6916009)(316002)(54906003)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 04:58:40.6326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe30febc-7267-481c-45fb-08da7b5628ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4985
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The pmfw has changed the driver interface version, so keep same with the
fw.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index c02e5e576728..6fe2fe92ebd7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -28,7 +28,7 @@
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x04
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x05
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2C
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2C
-- 
2.25.1

