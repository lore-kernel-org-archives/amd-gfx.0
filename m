Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C427EB64D8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A24DF10E0A4;
	Tue, 20 Jun 2023 17:16:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 495EE10E165
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iwg0UcOo7+5u0CU/TSYe22ORb8Dmpz3wbMjpDhrODBCDvPtNclqQaYMgJMlGrOsTNaACzszce6EpTYlCuWZQi/bl6SNFqDhb5kdwvHVebghPaXo58qcNDxqS771dWcqXdTLmz0ke4MTRWjur9Ekl4sYpQnZtXQig+0kWqu8u7lskfVCX/DPiruoX88oHvvb2zFAuhNP9XQjmjg7uWQ5Zt1lG1LICp8Bw8vOr2kizvhSa96rDwGaeL3C6T/Wv3xUdm4ALInr/fqfxNOi7TjXt9l1T6N6bBtLO/c8I4FHxkCeCOiDqCbncNl/QLzex9uXCDv7bqNap7sQFRw5vt536WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocsG3up57ppT9RhW5U22WbgCqAgmhqMD4seYpPBqqOo=;
 b=E+JPknoudNZRPyfwLkjCvWqHcYaBYXIn106my9BBJCfk1+BKcE8x1HXATIhN/WEuE/SMm4+3i+VJ6wf++hVTDRRocDnekKU+njxXvqoJsx2mbu207vlCxMwZBjPh1kI5CoNlOsIIFlkDNmy1WxSVbvjFj6OO8ubYuJeyebEQRFMgJkgFLzimPG4wwaDLFYjCDg9RYr1ZaCxMETq5FGtXwdbbsWBqpHOXzxq881MdCoLUMzQO/khmaw0/d3xK8NdJTXF3l+i3D8BR3/BmzPH8KQe80+SgJb7hKA826ysOprdK0s+DHQl2JySo811zYAuD+QotcbmGJJxTjejS34fWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocsG3up57ppT9RhW5U22WbgCqAgmhqMD4seYpPBqqOo=;
 b=Nj9Ig6SmLIliHU9mv7dRGxM+GP35ySCIjUE6UxW3/cCSezaaa7Kgfx5J3kCHlBNcdxy31FXNk6SW9Eet1S0P1+skyPYdOgGbxOluMId3D8pkbUgFqa5FNn0gdH+A0UV3sPiU3erj7hxwXYBt//J/e1ujCtwnRyfscKwg5JBczKA=
Received: from BYAPR07CA0066.namprd07.prod.outlook.com (2603:10b6:a03:60::43)
 by SJ0PR12MB5503.namprd12.prod.outlook.com (2603:10b6:a03:37f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:16:30 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::29) by BYAPR07CA0066.outlook.office365.com
 (2603:10b6:a03:60::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:29 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:26 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 03/12] drm/amdgpu: add UAPI for allocating doorbell memory
Date: Tue, 20 Jun 2023 19:15:59 +0200
Message-ID: <20230620171608.2131-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-1-shashank.sharma@amd.com>
References: <20230620171608.2131-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|SJ0PR12MB5503:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ffd7466-443f-4c66-83ab-08db71b2163d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4A6Ue41geI13zzP7MWu7dgkEmivbat401JUUgBGlR8V8/Sw9xmjTlc4HfFRaiEgN4yTfcsJAnUYkvMo6nCX9o7wdliTMQ0RnTec9fNbCPvGyz3TE6wtb+Dqgps1tQ3DAGr0YAp93UFOxDAZiv8mWIyH995TjP4M4/qIlLCEnvIudRVBLhcWMACp2BzH0AivhvpciHPHRtqTNW0m/XAU/6TcblxFwsRbhVbH5b3rbmpojDwPCQtHJ68ZKXLH0OMQijxFUwlVSU9xREcjluIXPfoODSyiX8dfzEKjpvEIVheq1BQYPwZl3IEx3d+SgkNk8po8DwTE/2xqwytI/GBS3oBi8O30CN58PySoSvr0rYhuIIbEBdY1BdDS7mUm0r87grz1fLtXSXRJRXloYNAfb7PDUsSGY+cW3rZiVBzVkX/MbgR7XVW6LJIcH7hdxFqZliJNvrOj/wh2Dl/KhUBqd1viwfxjZDnhmQe8+0bAkIfxrwWDHpHU6ScPiMOUisySopsBzBolTihwNHYbophqVH7MdHv6MMPE0ULCvkgBCnbo+jxuZATc8/37XnJ1fQ0PWxYsfGwKZBhJc9Y+TOvnODULxzwllsHn8TujiReNyuH3C240rTVYJbfm1224jNASYXEGq+crXBYxAlnC7UudGLjfnmSILcHMNbAS1d6smsMDmyTQyIpnLPhYSwm3Xgulb9myFWqj81StPkGra3qnSKhsCjaBfgzI6O8gkBY2nvCMdm6kjuQVmRwKbYCZxJLIQjtvZ4SlBAJagELVhk4y2lQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(6666004)(36756003)(8676002)(70206006)(70586007)(4326008)(6916009)(41300700001)(81166007)(356005)(2616005)(47076005)(40480700001)(426003)(336012)(83380400001)(82310400005)(44832011)(86362001)(7696005)(2906002)(5660300002)(54906003)(8936002)(316002)(40460700003)(1076003)(26005)(186003)(16526019)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:29.3523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffd7466-443f-4c66-83ab-08db71b2163d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5503
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch adds flags for a new gem domain AMDGPU_GEM_DOMAIN_DOORBELL
in the UAPI layer.

V2: Drop 'memory' from description (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b6eb90df5d05..36f41bfa987f 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -94,6 +94,9 @@ extern "C" {
  *
  * %AMDGPU_GEM_DOMAIN_OA	Ordered append, used by 3D or Compute engines
  * for appending data.
+ *
+ * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell. It is an MMIO region for
+ * signalling user mode queues.
  */
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -101,12 +104,14 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GDS		0x8
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
+#define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
 					 AMDGPU_GEM_DOMAIN_GDS | \
 					 AMDGPU_GEM_DOMAIN_GWS | \
-					 AMDGPU_GEM_DOMAIN_OA)
+					 AMDGPU_GEM_DOMAIN_OA | \
+					 AMDGPU_GEM_DOMAIN_DOORBELL)
 
 /* Flag that CPU access will be required for the case of VRAM domain */
 #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)
-- 
2.40.1

