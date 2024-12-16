Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E379E7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 09:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7E7210E555;
	Mon, 16 Dec 2024 09:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zBRa5DUq";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394E510E555
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 09:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RELfaYxei1GZADjnkTDiFfSeModM59VlHyQ6Wk6z5mrPK2UIY7M6EqkRXKDdEgKysbP+uaDKpbK3BrQIZ+TOVOFTSKj8o5eBL0/ZX2b2L/pUjDwP09qaH9MkQUCNsGv2uZB4W5nYGJWL96BqKpP8HDPE3kc0BMGiHQgUUvyjLqoeUmKfmGXneIE96gNqY0cMDFA91Nzu0pF52ccCanidR9tC0thv8obiGHRc7+Z3ysCff4b1Fhv6eBybRMcwBSHfoAN2TQnwieoq6n44IMkso1+9/DW2lP+0y1k2T3oXSfovG4ATFDcNYwY+0VYDww0xK/wLltUK5NCqQ7r1OJjwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6f6+Tg5LU/e9+u/jtxTlKM47La0VLJVqoX6fILLQQ0=;
 b=jznSVBaqq6n361hP/bft0M/iC84r/SVASIy8jK7S0JJB1njq//VwcNv+y9K4f+wNUAmcfSE1Ts2AdDvktFmEzv6/UeuDr9zVE9umvlNAj687XjlW4vFFgBdhMmMs/ZjW2bbl7zW/jXOXX4Zo0lMxeu4UIi5MCH6cQid1ZOEN1ZkwJad/WOrHQwsSipANuw65uhM6R7i0nEHrb8E1uEiwQhAxQYisnGVn8Y3NPoVe8fgrzGqCGA+gGCXZKrPolHIjJgwbVxLRAspsC8tZx9cR+ZJGLAHm/yBWHjtbygUeD0Q/ZMc0QVRqEJBqFdr30Va7E22e4D/QTlSediSLx2RR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6f6+Tg5LU/e9+u/jtxTlKM47La0VLJVqoX6fILLQQ0=;
 b=zBRa5DUqedhn7Z+UFIVge/46mL8Z4hzmVGGvqQtdpZCWPs6yHUwOitOhfWKwU6mhWsfL2uCE3Eh2mwsqSp/WC4uUWE2yLMRxiOcNjPfCYvkPJgKROpNAxEc5SAgNaABu4jlC2JUglg7uTT4+rzUUqs1KokMYCGH02Q1XLqIxlho=
Received: from CH0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:610:cc::11)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:23:49 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::28) by CH0PR03CA0066.outlook.office365.com
 (2603:10b6:610:cc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.19 via Frontend Transport; Mon,
 16 Dec 2024 09:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:23:48 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 03:23:47 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Enable psp v14_0_3 RAS support for non-SRIOV
 configurations.
Date: Mon, 16 Dec 2024 17:23:34 +0800
Message-ID: <20241216092334.286870-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 26124ccf-1d92-457f-694a-08dd1db358ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?syeJsocypL8063PoChgD8yxUdjbGdVZBLA88DB6qOztIh/Nij8KlP756j1xk?=
 =?us-ascii?Q?WC0cjSnXmPlw1cZnuM2St6HSDA5J+FiiU2gzvkjw3M5LtF6ULmpArmSpHNAc?=
 =?us-ascii?Q?6xXk9CfdDLXa7ulSVRIJaDVchiOZfsq7k7dVKqMM5BD0IpDtjaWQF+SSkLmM?=
 =?us-ascii?Q?pR+dcp4N31ASw6Nhp/MlH0QJio1fRuYfK1C2O0gTxfAcZ+JpzYO+LuE84YO0?=
 =?us-ascii?Q?ecN6yHshMppa4f3H6bFUmF+IhaHEjHSNCP8GwIvY+EXaTJgRrR3zb1Yygz88?=
 =?us-ascii?Q?08vq0BhDFiPFGTByTg3f+OqQtX7bMBL3VkShZoOJbWFhp+j/juImsRe97hFP?=
 =?us-ascii?Q?sbvINLyXrihAqyy95zMwNsgNCWydCH1EQILy4vvCGoguK95kbl8R2NvXXDh/?=
 =?us-ascii?Q?12S4ppDkhx+6sRxnGNmmUVxSXd8NxVCyuwdCYwwfnxmUd4pfoRXs7cgJ6xCg?=
 =?us-ascii?Q?n9Xx4yzyZ1SDcmfkRkJ0arzAwtFuyGPQBpLiK1pGtMN4YeXEhKkEd1heAPrf?=
 =?us-ascii?Q?00Wahm03wTETDR2neNVZxjTJLhknYKwQzognYLsWQPmm2KdtqwofSmxI9ckD?=
 =?us-ascii?Q?UU8Mm2Xts98croi9agVfkh174Ln0Yq9yadoHobLPWAv9eDnwksB1SquQIKcr?=
 =?us-ascii?Q?tKr4H3Hyc4JFYbacdenkg3ekUVxrO3CRwNZH3HRpYgd0CacYFVE+smqiQ26F?=
 =?us-ascii?Q?haLaWL01hpjzb80i5+kvCIah+zP9V32jXfnyQhPUSq3JPiN6gdnrjqlitQ1f?=
 =?us-ascii?Q?lC7vMUrgMs9SM46vKky9Dw+UVFp23mvN9tQb3kLu44swYpPx6lm1FIbM9xAk?=
 =?us-ascii?Q?ONIlTSgkvUfOs5ABW7Juvp0bVQ6aczc8qu8Q1PqHvYdh9a9kx4/4CeARHVEt?=
 =?us-ascii?Q?Ep/PbsedWq0SByEn5FX6Aht5JE76U54SiUIYFJnHkN8l0hA1IwLkP9DBMXqe?=
 =?us-ascii?Q?/bbvpV0CJsD/hSEtrYH6UX0KILen2ye3xjWCg93Lip7WxflaRs7LgvS4/8UN?=
 =?us-ascii?Q?9yhyuW87EHRg6R4INF/c/Zp0pkLAHXSZ9HyAberw57w3+hqYxQtqlWNFYm6W?=
 =?us-ascii?Q?oSo77LEKa4pQMPidW3i2tICvduh0p93lgxv7vteHLw/GPtKQgJMvgb6OMBT/?=
 =?us-ascii?Q?WXX6nk/hE6cC6P6nj79D8t+0P3Dv9Drjh6OWWbqJuXH+4Bl+p2aOfrGrnAdw?=
 =?us-ascii?Q?YNWNt70jgKLYaDdeuDB6vhAV8+7XTofAZQIgdWkn1Pqgy7WfkWAJBxsjZEp9?=
 =?us-ascii?Q?GWVv2z2T+6D2dXR4eI9rPoRECB6U1PeXHuJMn3EaxWrKhXb2TNQU6FiE7sPL?=
 =?us-ascii?Q?VVONu40kbof9xspuuyWiDyXZaZ3wzoD6KVfcUXSIlcY9Ls4jKb5FwhYjrx/z?=
 =?us-ascii?Q?oRkWm6YrRUu8WZdxm55fGkra0St3OuOFTiS7hU8bxtroqHhtOab4H4IaBXNo?=
 =?us-ascii?Q?AZpcH0UD1sxYyeJgoNBB5ruCQCnQVr+3xQPQmzCpiSn79xxENMu4qg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:23:48.4133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26124ccf-1d92-457f-694a-08dd1db358ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
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

Enable psp v14_0_3 RAS support for non-SRIOV configurations.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index db081618e85c3b..01c947066a2eb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3572,7 +3572,6 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		case IP_VERSION(13, 0, 6):
 		case IP_VERSION(13, 0, 12):
 		case IP_VERSION(13, 0, 14):
-		case IP_VERSION(14, 0, 3):
 			return true;
 		default:
 			return false;
@@ -3586,6 +3585,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		case IP_VERSION(13, 0, 10):
 		case IP_VERSION(13, 0, 12):
 		case IP_VERSION(13, 0, 14):
+		case IP_VERSION(14, 0, 3):
 			return true;
 		default:
 			return false;
-- 
2.25.1

