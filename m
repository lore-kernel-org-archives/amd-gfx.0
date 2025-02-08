Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A124C02198
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2025 03:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0119410EBCB;
	Sat,  8 Feb 2025 03:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="grGHXcx9";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7844010EBCB
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Feb 2025 03:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbOft5qA73373+nTeRgJ2IL6uX+mYrdq5G+bSfgQmQFShhov7iiswWp1YxhDw0aCrGxmHQJbtWiFXFqVQXaP2wj1EPLbxJ3aZn+B60du1LGiWl600qFL/Wg5RzkVAmd7/BgmrLJTd9xSH/d6NjI6s2EiYndzXYdPmLWoqDdviIHobRCjlxB74zDxWeMzMWJ2i7UuEA9B9bhTxlghm4GFER7vT11HPtp1dm/X8gNm7iynOXI2PbBTCnU/UoLsxsqSzKOGaOFT9etcdYef5/gg1hkLtDq67JRrEtZLXdfzFYq5RPgA2eLhtpw1iFQXsxuc28z6l4TipZS0A2Dsmyesxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzSt2Q5oGkZ3fe0TRt6w0z3zZKy/+MNld0pAWM4jVrw=;
 b=TCjJwj+UoiU5lk3Qfo8c2uTa++YgoPs2xjNMVqAJyWU9ijo/pMP4ZoygVNagYk7roNIdl1yfT3PgWG4WUG67It2c79rca1lq7qvwmbXkevGOLlDRNCE4ZB8Wv6i5+HSgPfNnRJMt78/6rsQ8FhqyZ9yAHE2qE/z2hr9u7PJcBULZuQhbvJrhGiNLL6PpFnYtykvl61YCA6Eqqd9ZpvTuzBMiiP4yanYGvUk/6oujxZNj27ZhWxDyzpSqtoDXq5KymxTVDULM6xiFmsRz29ZenOU4k6nGrZ4WLVFres2G+qYao76KTHdL+zu+Iut8Et+HMfSdA15YRUe970MPrSl2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzSt2Q5oGkZ3fe0TRt6w0z3zZKy/+MNld0pAWM4jVrw=;
 b=grGHXcx9Ad6If5Yb5hJ/5sh7WBtgHAQL05NQAjJ1Zgn4Rn6EJGsGn1mEuAb5hdzU4lxHQPCcWwDtyy4krMG4KNYcCpJJ/74v5VPfrlVJdUxE04XqSddG1vulgO+IPuGI/FTFUDAXejfDRGwd4QJYSWfamcmVjTgT0aNwodffMIE=
Received: from BL0PR0102CA0037.prod.exchangelabs.com (2603:10b6:208:25::14) by
 CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Sat, 8 Feb 2025 03:48:04 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::8) by BL0PR0102CA0037.outlook.office365.com
 (2603:10b6:208:25::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sat,
 8 Feb 2025 03:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 03:48:04 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 21:48:02 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <tim.huang@amd.com>
Subject: [PATCH] drm/amdgpu: add discovery support for DCN IP version 3.6.0
Date: Sat, 8 Feb 2025 11:45:53 +0800
Message-ID: <20250208034553.684282-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: f86b07e3-b17b-4b14-e74c-08dd47f36474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dq1hQi4qkB9q6QOBMRCrO7crdtitlCYl1mOL1U2DL/secXD4Vu413nkuIl6C?=
 =?us-ascii?Q?sP+/YeaT+tvuWun1yZcDrlOTOyCwtTuySty2fLewhJUeNT/VzYf34bTVutxy?=
 =?us-ascii?Q?mUS5ZRzaD5/8WNVkw+oiTn6ZMKgKDnScLKjcYqvLdvPJJxAUXQk+u5bO44Kv?=
 =?us-ascii?Q?vVQKenRH6RrnyP2ZTP/DwmQN6MtVPSueS8Q/8OEoIHZbV7JTRiIXbyIs+Bp+?=
 =?us-ascii?Q?/YPlytCyvgCmI3x0gJrM85qzKEneA4dWbwnRLDVi+BObpfNVaIy5YmTzcJHM?=
 =?us-ascii?Q?PDSmAp7RtFVcRHbRC6snaWomxLNma1Ekv8fYKF6V+SG0yXCFUJV5FXVpchIb?=
 =?us-ascii?Q?c1hwIkA76FMPw9FMJdt6uNnFztJl4lCJEuyphdfSC+y/38QiSH0B/tTgSbpN?=
 =?us-ascii?Q?24G/FxwBGvY6BPMaakyTsQtJNnVD8j88s0h2iJV3DCiWryi0uDmvywrFf9rv?=
 =?us-ascii?Q?h1t2LmaRQtuzh+3kYiXqSc3NBRfi1APCJAobIMj5WlrFOe1dLnkEPvV9kzTx?=
 =?us-ascii?Q?ltfPb1CStfr7yIbxkk1TNDbM0m0NG6zJZAMxDYzxUkUIcXLS2pMX8WVcE28X?=
 =?us-ascii?Q?nzxZ84NrROY9axSb0d5Gkd4b3tPT6ZoHsk9bgsEFd0bW9nKWmCimJa+AZD/M?=
 =?us-ascii?Q?R6BDkjXMQBePjnWsMaaORJGRDHHiJP2dRe1GtUpX8ZQZs7m4v++LJhtYzrRX?=
 =?us-ascii?Q?BULTZUzLZvr0heviuP7MDOuHBgFKPvVSUlbyNSKiI6QUmuVjN1cuKTcg6wfE?=
 =?us-ascii?Q?vNb3aTv8XI3sk1XAUpGhJ7S1Y6kSZhFe/5nGz4L/JM6+QBxrC9EZd4Y9Wedl?=
 =?us-ascii?Q?85RbVYuqzI1lZB88bOC9grgRevM8YRmh7RsuS27ag8IWhdtp4rPr8kBht7eh?=
 =?us-ascii?Q?BiHz7SO7o3HtUodYk0M2sg4frAtZtYKYUYlWpeDtT4qQow9kxQrzItsbRRIN?=
 =?us-ascii?Q?i/3F87RYnWlWpxUlKRbwI8BCFkwl1T09FtVPJCdw9Ay5Z2jc9jBfeoQ9sa3n?=
 =?us-ascii?Q?sH8Dh+PqaJx1fvARpAre/f7D7HLJd0cKyw1vr/Olc1aOrWzFNL9iHMPVTfrR?=
 =?us-ascii?Q?6s5BEws3S/poJnJjHV+RyTyL/DHEyyHaQ64WHcBZ5fyLbS4pslezs3s4iaYT?=
 =?us-ascii?Q?T35fcVLBnGMDrcVz1IOwSbH0tcVCIcfTv/gVlxVNhY4rJGl92OuFY/CTAzp3?=
 =?us-ascii?Q?oe8D2/XfFQzbL6CmR4PTRX2FWePCEta+iGB5Y1xmTOEXjKsPdCf4ohRczuW1?=
 =?us-ascii?Q?P79jOngIa6UoHlJMZLfQHWlpC3/vIvD4/cOG0beyqD/SfJgxzPwOeQQfsPOn?=
 =?us-ascii?Q?XEi+Xrbd4yNUiobeI8PWCsMFnQ4hSrpMnnW5hRDZFxt2mrKanaTG/4m9jDDF?=
 =?us-ascii?Q?/kiWbCh47KzkB6zMzPU8oBEqiXZzJD8p+uMwfZMPsh5UqOVM328v/1es6cBy?=
 =?us-ascii?Q?K3Jygj/c6s4lQsLAIVwRltMR6jZqajNunDG6K1ekHuHsz/WuivYGQLJ+8h4d?=
 =?us-ascii?Q?FGBpiOoejbCiT6U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 03:48:04.3861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f86b07e3-b17b-4b14-e74c-08dd47f36474
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
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

Add discovery entry for DCN IP version 3.6.0.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index eca431e52038..998a5e48ba0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2162,6 +2162,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
 		case IP_VERSION(3, 5, 1):
+		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 1, 0):
 			/* TODO: Fix IP version. DC code expects version 4.0.1 */
 			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
-- 
2.43.0

