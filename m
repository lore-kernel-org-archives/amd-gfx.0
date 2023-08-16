Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2E8C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E3C10E3D3;
	Wed, 16 Aug 2023 21:48:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EED510E3D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdFjS/dL0/CmsHftSHzxaQbgTiF8KiuiALhqpNZdln9cN1K+IrRiLO3sXj7iSRqQN9YA+PxFqeKIu3Cjyk8OnjgXfrTIRMlOl7oPSSSvD+SMU5IPXoAxaMia6eIgZ+RSHijIrEZkdHR/RsaHGf7QJXCCKVQAQlcbSziq71jsw+xvdhfn+x9VQqo7ZpLnEvjEtmAyWfsa7mEwRovOpM3O/uBk8GWL3GqQwhbmk1jxyxAUhQQ+FGL/o8qN1zWE14z9cUd0+f3xmp9eSSQHYFGYEGpWL8Z8ZXGFZCMkZISTqhKLfzA03DEkllWdU4/6HkJRqX5CgndM4fTqVtr2EGHdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZ8HEN1yx46do5AYRE9J27DkdKw3ccA6R/SEym5XvYM=;
 b=bqSeI2vi+s6rEVPoXkj3RqMXuX1z9w9leU7Y6/ZACH3iIOE8xa8AAuGoSRhJMQ6ckoBM6WVjUhQfeFELY3waIAkDAR5gCPpz8Fv3AGpTcTZkOcikFKa9uDQWLrnIlzeq/Z608r3grpOepgXYlqJvXxOsJ9QeJHdZQGXpdkwnbGIHhsd7LLAXu9LuaiiXrePoTfvKrG1pQrCBeqnx+/dOPvyzi4pjz20mmnK8fkZ3sXrGe7tp9juG+Zs0CxR7NK9785J4pJoDTVtsPKlnAsQK/diuE7yrqApf0uTzMpKszybarT9g8lf215zHMRyJE9OLV1qwsZjlCRFXiKFux39Ibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ8HEN1yx46do5AYRE9J27DkdKw3ccA6R/SEym5XvYM=;
 b=wcJyw2DUsFrhFjPl+nR9ml63X+u9C1h23Q1nRdsuttbsbKlJFwQQnaEec1+1pE+zKYf7yk6rVAE/jrz/Es2UVKr+5IiqX0t//IS/M6QLPE2gDshqyNaRnJW16YWtqKPvr24j5OtqhsqzqYIzMibfEB8MRkIQt7YEdtS8M+zgLAM=
Received: from MW4PR04CA0070.namprd04.prod.outlook.com (2603:10b6:303:6b::15)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:48:10 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::ca) by MW4PR04CA0070.outlook.office365.com
 (2603:10b6:303:6b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 21:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:48:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:48:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add new AMDGPU_FAMILY definition
Date: Wed, 16 Aug 2023 17:47:52 -0400
Message-ID: <20230816214754.826506-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1f4d45-e748-4d26-1e78-08db9ea27bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/mX7FQo75XTbT2EjBiaGhaYsstr2I0o39ALRa1w/VV0k1D/OTz+ANUaGOY6hDa+JsnWZ1+bQCAQP2vY3fqD9rMKr4VWLq2GSkvAhvGG5UxepuGNH0Tcy7tqBK5/NZ3rjy+td6AcUuHssXjpQv1eT08Q5kk2T5JN2VpC1W/Xzyrx56wYWwVmZY9/FoohpAkFtHCTN7iwRJ8WCZ8mlfo5tft9rR/u5Ui4dWM6mjZuv5EXwCDmQAAqd3LIxDWxR2g5GmDVWj8JJzYgP9ah2qvbtMbhhy7np6/+O+TMPcL53IdGQW0w8j4jLfVoclGwUmnavmRAFeU7JoPzEWuQ4CcKGYpSdArfvEK003La6lEBU9X7tEa55RQ56GpxQbhUJ7rWhTXRvF5vDjWJxXq39k7EUSAP6IDcO3ukW2NCUT2BWke0DwiwWQW2fS765wV5j3O2XGrYMNtF0qCmWLnOvBYMW4+Fx5FCz1fQ3cMoJbYCVMX+7FLvVMG1Pd3r7n2tlzZf7i7fIIKE459ZqNytOGgJ8fgNPDLWcL+dzznjYNTs7graPFegaZKdRxkE+MUKwjQbijrETjb7NGer8FuOIHR8iY2dOiNil3pyVv7/vj2d1KnbYM15B3e3LJXKgfSdqH6TajpqZd8P2JGVAkOXJhknujaFc2vZTFJzPdcp9j2sH+hWqekzZSIqKvc/y/NC6MwEUaMTMiAACPZW1ne8Of/oyLWA8gh4Nw/lzmn4O2nMwan65NNdVwilZKDDhHCgyniYRPhqXy66UDKXYXPxb6GsKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:48:10.3243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1f4d45-e748-4d26-1e78-08db9ea27bf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

add GC 11.5.0 family

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 include/uapi/drm/amdgpu_drm.h                 | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9d8d08daca57..ed92f28a9171 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2342,6 +2342,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 4):
 		adev->family = AMDGPU_FAMILY_GC_11_0_1;
 		break;
+	case IP_VERSION(11, 5, 0):
+		adev->family = AMDGPU_FAMILY_GC_11_5_0;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -2358,6 +2361,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 7):
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
 		adev->flags |= AMD_IS_APU;
 		break;
 	default:
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index f477eda6a2b8..5f5ffdac1556 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1238,6 +1238,7 @@ struct drm_amdgpu_info_video_caps {
 #define AMDGPU_FAMILY_GC_11_0_1			148 /* GC 11.0.1 */
 #define AMDGPU_FAMILY_GC_10_3_6			149 /* GC 10.3.6 */
 #define AMDGPU_FAMILY_GC_10_3_7			151 /* GC 10.3.7 */
+#define AMDGPU_FAMILY_GC_11_5_0			150 /* GC 11.5.0 */
 
 #if defined(__cplusplus)
 }
-- 
2.41.0

