Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7C5C28B2F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 03:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BA410E196;
	Tue, 18 Mar 2025 03:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="32UqiNHQ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263C110E196
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 03:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhgeE0aTXWK0NmxQtqIgW/4PBZ/1sqEjL6SUvsiNVyxdDR21fPpW1IIxbTH+d7TogbaubIHj1N2XocMSL2TTvue9i5A1yU7RLG/4NYOJdGrjC+HGXrH566Nt/IY7i+m75yKZNml4zKZ+SIgkrh/jtSGBHW7tuthhfcCby1MJ/13eA0qYgSpdk0Zt0vNBIrrw6qqlcNKAWhg/cVETt2rWZ0qNRb+fhJ1X4XInEoQR2HbwRViIElxz3eiceSNZNmQ7a53XwH39Qfm4vaGt05HdPRMFAYpYmUX5gqepsm4bMIWGYrMIoa7uAr4ITTxtraIdfKudr9Nq0xsD3GhpSVtWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEhxMjdmttIXsg5XTJqZzXoDS0UdIEPmNoDltJoc3Gs=;
 b=vr18NkdYEGnnDs93QsmUNHyQPUjypBMT9PCoIeT/WqF6To4ug+RZb8YBmlSeaL+8OUKQi9y9JeD4p9eCARXYJ+qhmUjP9yG+hYGI3y+k5Zy4mew41F5uNPykFAmEKR1sT/GAp/BV+4wblhRT5uGF1fqy8hAJQJXzq1ABN8FFUPdAHRcExjKRp3D57mHfr7Q115HI+4DGl29tLL3RxCChy+nwxwZH/ErOxfXixgkVbB2ngFM/ydk5CnnHDxAE/gR6gl4VImiKJFYsHEdGqhlkem5iLNicEgwZq31EzWKPURGgYJAxCG+JhmIt95OJFNYl81vHEUu83UU+iZ3ZHOqeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEhxMjdmttIXsg5XTJqZzXoDS0UdIEPmNoDltJoc3Gs=;
 b=32UqiNHQD73p7Xrmf2BGyMnL9iu/8bQOw20m2zS3rdhIOMPsrAz25LxF+FZhupiE9UC5JAFHhE9+KCgzJi7zINMGaXR1LWTdZ12cdcH75QRcCLnv/G30HyrE2nOZ6MeJnSSD70fOCPx0hd0ok4nAdrKNJvAVyIzauIkeLagMey8=
Received: from SN7PR04CA0064.namprd04.prod.outlook.com (2603:10b6:806:121::9)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:49:50 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::19) by SN7PR04CA0064.outlook.office365.com
 (2603:10b6:806:121::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 03:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 03:49:50 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Mar 2025 22:49:44 -0500
From: Ahmad Rehman <Ahmad.Rehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Vignesh.Chander@amd.com>, Ahmad Rehman <Ahmad.Rehman@amd.com>
Subject: [PATCH] drm/amdgpu/sdam: Skip SDMA queue reset for SRIOV
Date: Mon, 17 Mar 2025 23:49:33 -0400
Message-ID: <20250318034933.115123-1-Ahmad.Rehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: f9728eaf-1f41-4b59-261b-08dd65cfef1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iLnw2v7VrurTqdn+dFnvtPqw6SplhbcsBhoNV6JSONOD7LPVfIH1HDu9C615?=
 =?us-ascii?Q?YzK3u1C4hnw6kA7QNz+LGNKdXA4+dLNPoduYeiukRZbPqe0ZtbuU5G0s4dQt?=
 =?us-ascii?Q?GLOoZMHloOdEXbNyjd/DJPPpt9mlzk4E/F6fOTArWomPvBqByI4NC4EooJva?=
 =?us-ascii?Q?OhHriWQ/KQuz991s+HxDCKNT6g76lewS7WhC39p2PzRLYUyWHtq2piJiMQui?=
 =?us-ascii?Q?/eUKX1da6iwlfB//SqXi3heqsF6R+lkVpwkfT8HTK0zPJgZQ9Uwvau1IFm/u?=
 =?us-ascii?Q?C00+Pm9C+nCvasF51+XZyltLNCrjyaUpyQ9xgdIObMGgoeymsQE2lLOijXpU?=
 =?us-ascii?Q?gLrPfXeEpJwVpMXl2l3KuEZR1bfstvZL6Nk6rFvpCta7/QH4sDUrkTDMqIjk?=
 =?us-ascii?Q?ef51C9rpOk/pCnnQ0Uo6lubOnQfKBXq00/sgRS+MlthWCP81tlL/rqKRRbr+?=
 =?us-ascii?Q?wTP6SBXLCBPAwPhD0daUJv+RkzQX5Ljr1KYNpOcdHN90IhRdgrn5dikmebN+?=
 =?us-ascii?Q?8WmYRDgZzmqgA25O1+889GuFjVmGdkSnhzgVOGuX97sqvVg7HmFrarHqGIV1?=
 =?us-ascii?Q?XtvL3LVPOKMyMuTaocQt1kdru5eslERU5FBoyK4Ntvu7ZdYpAU/kGz3vdogg?=
 =?us-ascii?Q?lVvwXwc/0TgdLP++oaFSiZbTwcJGU3ZD/zHIHAsFtgKRW5ekXNPReEA8Gz1e?=
 =?us-ascii?Q?nxmJphzopNAtAwcnOUpuVKRL3iTHgKRDSibTITl6lBL6Uo1JntsC+iSBvMdD?=
 =?us-ascii?Q?eYQMFBm18rgQkGmBmyxB1CesyVajbG0WJwmAc5GaBqsd3expY394KINwX49Z?=
 =?us-ascii?Q?IHWWRLjZPzxOtwcx/TpE3QUCtNy6PKWjeIcd9LOe8ZY4Q7MSWEtZ4fUQFbRq?=
 =?us-ascii?Q?CiqMWIw52qa+UeE8JsICex0UAeBBxWV/JELjg+qhOfnEE7rJioD+Lj7V6a3G?=
 =?us-ascii?Q?V+t9pdqmJkyvc3ITF0QexU9GK5YvaMVJ759s6ZgurfAQnJ7FcZv0+njw0AsZ?=
 =?us-ascii?Q?LUXW913kjyMGA3liBlxZoTYa0S7X8GwZHFu1bUMBMoE+bd5VSSRa2LldO7s+?=
 =?us-ascii?Q?WWOr/1kHR12xTa9T/PfDmba79zOTtK6Zyx4AgHvKBWJWZSQhklvn97O4Xfb8?=
 =?us-ascii?Q?tTErISonF2aCpWurreKHb4xeUVBjckShnwmbXX2ii3REE7QDLMcEjl1HLNRh?=
 =?us-ascii?Q?4GIXLIxYbMJNOmD1U+DvJBU//yLdf/446Inb8A6QqrMZ5SqJQ4oDtYjMDld8?=
 =?us-ascii?Q?VhFdyAVEDdA2kEwBuVwnlwL/TyBvPJsUEgC0Ml8bnqj9VTD7M67xK+OGE0LH?=
 =?us-ascii?Q?cTf8fTXlNUC2MpaoPlT60RB+F/Nhjw6sDwQSL68pYEga+TJwGodv1nqiXVlF?=
 =?us-ascii?Q?TTajqSlne73krqhcMDECJKdCdp/zbbciXoghzj98emCtJSCMPxa711zwqwCZ?=
 =?us-ascii?Q?6AYjKrzYtVZV+5Rw58sBpmlZCt8/W1rClgE7YT83CdplZgMloMT0MSWz//T0?=
 =?us-ascii?Q?l21E0DptPka/UJM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 03:49:50.0285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9728eaf-1f41-4b59-261b-08dd65cfef1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03
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

For SRIOV, skip the SDMA queue reset and return
error. The engine/queue reset failure will trigger
FLR in the sequence.

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fd34dc138081..5b2d4ca92c17 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1666,6 +1666,11 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = GET_INST(SDMA0, ring->me);
+
+	/* Return error for SRIOV will result in FLR */
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	return amdgpu_sdma_reset_engine(adev, id, true);
 }
 
-- 
2.34.1

