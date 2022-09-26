Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DF5C32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 21:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E218E10E7B6;
	Mon, 26 Sep 2022 21:41:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B84F10E7BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 21:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTSjy1JrdWDnHIny043RLVPMABhAgIgCoc8XAF2kVynD2FJbSiD/dygEYiade+XnbO4YBv8SJgeRErBaz8mwQ8WSkwTAsdkyzrMmdA3KHzL1QBW28kWH397vd5pZhmjiPeJd4Z74rqwH9Uw5Mgle9zqWfcKxdogPzIg+QP23phPfVIM7UQj0nwZYD1gm8d8CDw4ebghFdU+jmu6gIbTVrimuZEzZje+CgHRSwUBwOaA9sSY658u8DJGL8160w+hCx9c0oFrIhS9aA36R5KIpfTE2X2P3Nypxcte5b8XJb+KTFaFmXeWkvsByk31e9/HmNiMF2tQELW4enTm4ETF11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWn7pQqk21HlZsZMALAi1qB/MKBA3f8Y9UtNIrtxF4A=;
 b=YEurpOcOvSPkEW6t3OK+nmA471xpCVGHNU14MlZjUVGeKtDg93cvcHpH9R8B6QXLrSM0dS2P0LepYz60XTDHbd6zI52jCdtbFzNXBB8M0fgsnTXOp4ZpTSB5M3yjGmfFCXegLk2oqWSemVgYM5hCkYuyxjROaCrtd6KdFF5nRkobJwe7BX8tpIvbtSKAbubepWBAN8CQLOxXlpGEHoMus9KtO0OqtLGMFIG3ZSFhzavAb+8p4uGlbodOruXc1qIYDor8fEHE8APSaki+fSJ1lLpBa04HZNOsByHhtoOcQjPUQUsah0UC6cOsMq6/VJUZGi1H8+vXvzm3p+Rncf/eyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWn7pQqk21HlZsZMALAi1qB/MKBA3f8Y9UtNIrtxF4A=;
 b=SP93PRYzVcf0QBFo5mO63CLCPqKP1906szuAG49F3zbElSznq1B5LciVdR8p48zCit/nZ//KIEygZwhxlx2QANYg9spgMp2mzTEF1RgnNsoqRMV2uO2o8KdZuFr7robqcs0L5eYgAqA40EXwdgjwg+/W6UkCwlKp2jHSBiovPOw=
Received: from DM6PR21CA0026.namprd21.prod.outlook.com (2603:10b6:5:174::36)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 21:40:43 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::74) by DM6PR21CA0026.outlook.office365.com
 (2603:10b6:5:174::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.0 via Frontend
 Transport; Mon, 26 Sep 2022 21:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 21:40:43 +0000
Received: from shashanks-target.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 16:40:38 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to ctx ioctl
Date: Mon, 26 Sep 2022 23:40:10 +0200
Message-ID: <20220926214014.5450-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926214014.5450-1-shashank.sharma@amd.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|BL1PR12MB5351:EE_
X-MS-Office365-Filtering-Correlation-Id: 13167ca4-d809-426d-3b1a-08daa007c3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B73UOPC4gelDb6QBnAaybyFDrRQuZD5vV0bWeOJoc8nhTXSX8zylriflc19Ouaa7NRPreocDPBx3+8WUhNrv9LGm5fKTB/5taz21RwPRGYGcDaXETekdDjLe7byBQJ8EstASXHuJWyehrlBUNFAndHY4P35ebKYKiSEXqSUg1jJYo84Q2WS5Ti2GQuGLjhJHmnpyW7Hp63Tam9+dfvkQmbT5NEbP3h483VdxCVADVcWlljGvEEispmV04PIG+lgLMejv09dDi8/3Ba974Z3Gn3pkUk6hJKi8MwSzy4QmMSLJ4NPrwU3YQZk3adppdQE0p/qj87fGJgXrLjfBybuzxPKb+QCb0posWZZSBmJh1qrRqIgpnWE4h5LRk0qmUzXj6ZvSVlL8AqxqhbfB4LOkckBfZ6i+eA2MkQxsekGgA82vG2YjdE6mVd8Mmt0mrBUJ99CFK7DJHkxzQZen2CsZIGNghNEm/djMmtdm1dWnhZV7F0NQh3JdE0jTiRuqV/KcbjUH7EB8ITBcfss1rcHifr4eWBFYibaFvcYsK3Pe+Se5OlEj9HXm3miAoQ1r8OYn0bAE3cOPZ28+kBlX/rm3AW3YnsdTP8AuF/ZtDpUVJrN2fsjswyPjI1VEqp5L9L7tIjJLTQSruxFbucqgwTeCWxq1YhdKG1eNt4zu4M2GFvUSdf0y2Pynj2xq/2Ck/lyUc+cgbxXmZdaqTHPcWWucSWCfD7PFMmZzxbvUHjrrMF9QbAcmr+kzj5FLmVIOUl5PFumgbzgUIKafnJa4kQhZol9vPSsxrXA+Jyu5vDzrfwD2PRYSbPxz/utlyBigYHXQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(8936002)(41300700001)(26005)(7696005)(478600001)(6666004)(54906003)(5660300002)(44832011)(2906002)(40460700003)(82310400005)(36756003)(86362001)(40480700001)(6916009)(316002)(4326008)(8676002)(70586007)(70206006)(47076005)(81166007)(356005)(2616005)(1076003)(82740400003)(36860700001)(426003)(336012)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 21:40:43.4582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13167ca4-d809-426d-3b1a-08daa007c3bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allow the user to specify a workload hint to the kernel.
We can use these to tweak the dpm heuristics to better match
the workload for improved performance.

V3: Create only set() workload UAPI (Christian)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index c2c9c674a223..23d354242699 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {
 #define AMDGPU_CTX_OP_QUERY_STATE2	4
 #define AMDGPU_CTX_OP_GET_STABLE_PSTATE	5
 #define AMDGPU_CTX_OP_SET_STABLE_PSTATE	6
+#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE	7
 
 /* GPU reset status */
 #define AMDGPU_CTX_NO_RESET		0
@@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {
 #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
 #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
 
+/* GPU workload hints, flag bits 8-15 */
+#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
+#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+#define AMDGPU_CTX_WORKLOAD_HINT_MAX	   AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
+#define AMDGPU_CTX_WORKLOAD_INDEX(n)	   (n >> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+
 struct drm_amdgpu_ctx_in {
 	/** AMDGPU_CTX_OP_* */
 	__u32	op;
@@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {
 			__u32	flags;
 			__u32	_pad;
 		} pstate;
+
+		struct {
+			__u32	flags;
+			__u32	_pad;
+		} workload;
 };
 
 union drm_amdgpu_ctx {
-- 
2.34.1

