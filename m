Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65EDE77180
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6E410F070;
	Fri, 13 Dec 2024 15:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hh0H7UTo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD4E10F070
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1SOb8xDTg21QmOBACWsKgLMnvTh+4C9FV3jINwmH20FEYCCGndFfnpLLAXb03mFww7hOA35UrCshNOqH1meAmBwTYTzH6Ym5oh0+MsePVVDvPvIyKTogOOObRiyBQcDTK0ASv3ld7Ei8f7Jpj0kp4iN6kECfWKrsEBFa1ElH+HXGl6oLAnlq7rabfyeP13Cyed0kRCvVOghMIKHau+hlqMbjrZ78DBoMzgi0KoOrIcHqQqum6QthZ9Xr7kMe9TJCkTkn4UFaR0+zWcw6iuECZTeS2snAAnXMR/E6NeRi0BCVduEynaSgR/NAb/Rk9s2NYlJ4P8Rnrd0O4pEP1WN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvi/hphEA7tY2YC54QzE/nlrKxUyyl5KNgoUxvuhowQ=;
 b=mZyHMGAM4tgxNXenb+oWSTFjc+cOXf2vMU/luDaVp4CxOwDt8jJDCk05u5aLrOGWf/DgnqA9J+NdQjRVLUJG0HQ9tPhYyNKvS58K7C9uhk2S7BlqIJMDeno0HpQnadAEb9jYma5jSoks4xqE50MkyIx9/vfavAL2/q4vkvHOvJJdm6oc9ReJtM7qa4sZxsKOk2XSSBxRYfEYXzjs49FBoyz9BznRk7TpD6yQlSpaDrShvKPj/Qjb2hyhgzUXch7CvYgwU9IcoXxUyu8y9Hu6BefIgcfdxPIW14PdGSvFAG66zMWgM2d2dr/xvfViASgvBd3Xy+5WZhwqIlX0NIv12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvi/hphEA7tY2YC54QzE/nlrKxUyyl5KNgoUxvuhowQ=;
 b=hh0H7UToDUaNtqeB46v5SSzxPQCQjpzGnMNH9ta5/UTu6vhy80v4OO0cnEktutgpuN5LAXZCpfJWtYeDNsQH1LHLgpc/DLps5P+eb6PMFN+fZeZMUks+RmkJvW/L5O7VRf9T1OO4rPVNqexYhkhb9Yi4YcKk838DJd4MQYwM54M=
Received: from DS7PR03CA0067.namprd03.prod.outlook.com (2603:10b6:5:3bb::12)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:54:49 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::a7) by DS7PR03CA0067.outlook.office365.com
 (2603:10b6:5:3bb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 15:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:54:48 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:54:44 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>
Subject: [PATCH 05/17] drm/amd/display: Fix Mode Cutoff in DSC Passthrough to
 DP2.1 Monitor
Date: Fri, 13 Dec 2024 08:52:37 -0700
Message-ID: <20241213155405.393252-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de54e53-6295-4931-8070-08dd1b8e78c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DBc25OkooEFd5kysHD28yCZQXH3zOYbnw3Fh7a3MfQd2REWprXY0w+SRo/2S?=
 =?us-ascii?Q?wPBDVs1KIQuJIut9sXCbbdXYdblJaslNiRGEt5BfBvtX+881baHRdFzY8IhG?=
 =?us-ascii?Q?6bCkZCWGFHB5KZA1bw0yYv+JTq6L2vIhcCuicm81B1Fzn7Z5giYv5F8T5r8V?=
 =?us-ascii?Q?7BiBVZSkLvtMxA2Qrwl6gu1C+GemszIukeFAs0Um579VlrVukrJvObzcbM4f?=
 =?us-ascii?Q?Xdc1+qEr60qmiqJezlIyP1BOwROylehnpRcS89njz+hVZrzlbK/huedft6iu?=
 =?us-ascii?Q?ur4Ez3sE31Ov53xpHcCZuRmwh6SpeP6H9bUqKVc3z+rkEhfz7WX9fDNRFqtd?=
 =?us-ascii?Q?zvGklE4fmZwk5n0N9pnvqn49tq71CFap4eXK128eqfnb5JLC4vKOPoeCcKiG?=
 =?us-ascii?Q?kxHMot/u5m5FAUG9vbDQj5veHrtzXKr4Ey149luVz2qNl5paFiEpdmNEe7JS?=
 =?us-ascii?Q?pciI9e512cxaD05dhomBqAsHBQQy/P7oEKVMpEeEe1NWaF/Q8MXyXVhOX0Ri?=
 =?us-ascii?Q?GAosyGhCqPHpbQfwNzrtSSmZLUwWd1q1grz0dvFe62xX5Gg/L4FCjZEXUXlm?=
 =?us-ascii?Q?goJ3HfPC2O152dLd1Ds77ZxvLli6vHtIH12aRtUWgT44+87/xZhu9xLcFoGh?=
 =?us-ascii?Q?ziD7udtSwmKpypE0IPVFf1AElMXkVaeh1yfDuqNO/tJO2976HBNwBWEa1VRl?=
 =?us-ascii?Q?3Gpwzy9BTCbqj6LQHBFoi+8aO25s+ekxtBjgSxY8KVBE4l+IZD6QaJWHC9U6?=
 =?us-ascii?Q?nOhBwXC69Bt+hhcnq8ZlcRC+PykDpPz5wr0rQxROFa9UNQ1bBq4WiS3Yx5mA?=
 =?us-ascii?Q?zlfc4BM7i+zd8D5SP6nXHCTdHRbI4bsN41isJ+YlEKRs6Ss2eOjPsL3joCBE?=
 =?us-ascii?Q?ORdYnL4cBHbFNK1l+8ILW7PQMn63tbgv3XVHcCEj17VuIpYPTQO3Scl1P387?=
 =?us-ascii?Q?Y2RZvtp0pCynNR/Jg7omuOOy8EUoUua51KE/mplaY9oMcfIoAGS+QCR7N+N3?=
 =?us-ascii?Q?FuN6imAjk1KwDsfKotXbJAvanYGNpd8Il9UMgpM+NPcnaZTIhnSAaMs3q8XA?=
 =?us-ascii?Q?Q6SWKI28TO7ftWGunHGl2FHmjslHrsjRGhXkdmICU8cRxDdjL2tRpl0yrcn2?=
 =?us-ascii?Q?k1y3uCO6ImbGehY6gO0qCmh0hjltAtGVQl3K20ba6AEVg3O9otLhIFvT5XfT?=
 =?us-ascii?Q?gbGbAc/RxKCEGBevz23zvWMKeqdCAPzJMJso2QDV6ob2M+YPJdkx/AXy+SQU?=
 =?us-ascii?Q?aa75ptWddp1PAaZl7PjM2kXttK40WdOd5h0gC2jrbYNqurrJakbP0J38vXNY?=
 =?us-ascii?Q?KjHq5zCOhRR2hHFgT5WBkarDSHdsI3LmeD4r9E7yfrUwKw+8Jri3pVDz3BQN?=
 =?us-ascii?Q?gyamRlRywkLn97hccoU8P1WouxReweMy0yNcLQbV8LsU3E+UEdDHIgwHimqu?=
 =?us-ascii?Q?rYkN3IfAnBOjrJsh6KrKhZVqhZbcLIQZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:54:48.0965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de54e53-6295-4931-8070-08dd1b8e78c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Source --> DP2.1 MST hub --> DP1.4/2.1 monitor

When change from DP1.4 to DP2.1 from monitor manual, modes higher than
4k120 are all cutoff by mode validation. Switch back to DP1.4 gets all
the modes up to 4k240 available to be enabled by dsc passthrough.

[why]
Compared to DP1.4 link from hub to monitor, DP2.1 link has larger
full_pbn value that causes overflow in the process of doing conversion
from pbn to kbps.

[how]
Change the data type accordingly to fit into the data limit during
conversion calculation.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 6e4359490613..ca864f71ae66 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1688,16 +1688,16 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 	return ret;
 }
 
-static unsigned int kbps_from_pbn(unsigned int pbn)
+static uint32_t kbps_from_pbn(unsigned int pbn)
 {
-	unsigned int kbps = pbn;
+	uint64_t kbps = (uint64_t)pbn;
 
 	kbps *= (1000000 / PEAK_FACTOR_X1000);
 	kbps *= 8;
 	kbps *= 54;
 	kbps /= 64;
 
-	return kbps;
+	return (uint32_t)kbps;
 }
 
 static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
-- 
2.45.2

