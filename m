Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2A5C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 20:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A2C310E1A7;
	Wed, 16 Feb 2022 20:03:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038A110E1A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 20:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+3ddqyeebX0IebwbzMJk0e2cqjwo+C3p0sSz0mF+g+dOFS/lW0T3IYGlC2hZahwTCAa1WCOTGRbeDlxeu4VUMCQS0yqoncl3RjH/39AuWusT+ddnB9LMvEnVHYKU738craQQr0mOWUv/hfOu7qPsDR4gt0O98uTJWDMS52zr+5v3QzKx5vxpS3u0DbJsOdxo7ziBQr61z9GC/ygLqwevLRc0w4ZUARwEQWxvuLGrazhLqCrVXPGW3BOOyQ+WICG3eZe0cLiBcE6ytFeckeJT0RY6t1jHeV59tjpyx0A9oOGF1QxIMBNBk69xmHl9os06MTuHxrOJJzGLHElg9QiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxI15ytRmM2ThRImHLdYDiBwt2XjQ83XarQnD1+p/Q8=;
 b=aosjpb/sEOcERA90SXW3vznBxWbg2gXszMIhVlWV5/ALz2aFbPY0fFx9Q/LqEbw5V7Hf8jx4UpLiU50rVl3hGijDrIjLG3Y/jXJCvVhpPFxbL0mUUf3+OFJzj5oJ9gY0fucMYqlFMQDSsC30+jDPvgNO4jkYZHYG5dXHMk4c0whjDoi+wl5cJIQca1XJTJrP9WhrTN8D6u4lZ6iNF1CeaGgctclhM2ysR5rRJdcGTUAF0SuuHFuEnlnPzjXHSpDESfCF0OE4MDH5B6eKaYZzcZ+WpuFkR9/zJ1HC5+Vazfcb59NJKpbDM7NP/5+OoaxTqwxOOhhz+uYiTAb1+OVVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxI15ytRmM2ThRImHLdYDiBwt2XjQ83XarQnD1+p/Q8=;
 b=fQc3dAxTqBE7+xs9Hmpk088c6u5FhmNOMNPy0CDFKrle1RpjsIJobKA614nlt9AHa3f02g1W1a0Tnyd8rkigNYKcZV266pkhWP8PFnCYxttUnwITGOiHguXZ1P6NmW0h2UlaLeOVOCwGYpJpa63rbbpl3/MJcVT8aoc1D+OiQMU=
Received: from MWHPR15CA0043.namprd15.prod.outlook.com (2603:10b6:300:ad::29)
 by MW2PR12MB2428.namprd12.prod.outlook.com (2603:10b6:907:6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Wed, 16 Feb
 2022 20:02:54 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::77) by MWHPR15CA0043.outlook.office365.com
 (2603:10b6:300:ad::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.20 via Frontend
 Transport; Wed, 16 Feb 2022 20:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Wed, 16 Feb 2022 20:02:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 14:02:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add nv common init for gc 10.3.6
Date: Wed, 16 Feb 2022 15:02:39 -0500
Message-ID: <20220216200239.2693193-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c46a68bf-5834-4523-1b2d-08d9f1875163
X-MS-TrafficTypeDiagnostic: MW2PR12MB2428:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2428CB1A6E79D00C0327581AF7359@MW2PR12MB2428.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFeKhpdRfhy8Jt8OpgoMTFcAAdn0D7FUDUsfmYKcZmfLjlENjHd8gtfgVonj6XZXs7u+d+Zikysk3W1JkOjWEZIyU3WF8IoXHrNHx8auZKpqP/e5I5397uT9Ve5NDgTHAM8qJ8MS2tZ+IfzwkwFVfHiRDnoE0QYPm9PNCWYZfnqO3Py4A7z0+uf67MWFYO9cRVLYwk9jII7KbGliGsrVqf7AsrfJQsagTNIuIY2zwLUIzwTCnwuMpMRu6ebaNyrosSkZCO4hPDTK2yE8eo/Q6LFs5tOcJUCd8y9UAwIOOyVh+hEKgft2q4nTopxvrnwvMZ/K4KqPwk9MIxXqD89MUh2BenZ3WvzFosgPJGCcqcmv0t14TDxj1cctm3OXM/EPMmWxn8fRy0dnKMF01yQ0N1guqwEG6QcGtfL/RfkjW2HoTZ1+kr0pLbBAMF7jCltpUpKcsw9grAedUSaG1DOIrHRmWzfMk1ksLl6nSdmWP0cxj74q8ObwCBkWF6NNBFYdl3zeWVe4piepMNeq/RrD3ko6AImFxSXf0D5d+0I+2zt1ylha9cXmZqfYE1Uw7lFssMgRuDHSQxbDlqvhYDck+xjqGHAN3tlrFOveIGdJl/JegdVwEqOQXvp9BUX0ML8VLvRHhcQwyMDtFiOrdszsAXwZmx0BrsegU7QWlcUCWFXVyRyi1FTnH+1i5vN+uRoMQO4Jr2Pqq+5saQAHPeiWSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(82310400004)(6666004)(8936002)(7696005)(8676002)(2616005)(40460700003)(36860700001)(5660300002)(83380400001)(47076005)(54906003)(508600001)(36756003)(86362001)(81166007)(4326008)(356005)(316002)(426003)(70206006)(70586007)(336012)(16526019)(186003)(1076003)(26005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 20:02:53.6089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c46a68bf-5834-4523-1b2d-08d9f1875163
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2428
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
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch adds add nv common init for gc 10.3.6.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2506bcf36c87..aa08431c1a99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1182,6 +1182,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 7):
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 8a5642f2daa6..ca8d808756b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -905,6 +905,11 @@ static int nv_common_early_init(void *handle)
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x82;
 		break;
+	case IP_VERSION(10, 3, 6):
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x01;
+		break;
 	case IP_VERSION(10, 3, 7):
 		adev->cg_flags = 0;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
-- 
2.35.1

