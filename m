Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9415FC41513
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 19:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0289A10F206;
	Thu,  9 May 2024 19:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UjoeLRVH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690BC10F20A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 19:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNlud1MariIo2QmTPXUvEYU5h02sBkCDL4KUEP7/1BxtM5t9CmaP3JNh6Tf4i3OyiHz2QtUzfojDdoJrvd7W0HozBeiuxXY2LMUzTHVz3xdiJA9jiVAcTvUUwunIH2dF33WIpECeDhWFlHp14O7UFDliE3xGmUHQdiRkWDPsPqbUHwN1hI0Ez8+QcgXaSxuqBaxynsRxc1l5FtHczem75eFRttuo4dhRTY3SJd8dNCoCN594AG/7oLBvIpu6AUTRwDxyN84M4rBnl2Am0jxWoGjfW4eN1GuBUrptgIsDlgEmIuDxyUh3vQLl/W50AMsJAVqLLvYdT8f/nkTYzyJK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH9J5kaqpG5X1ISc1dBYtKV6GeFy3HA14UfLwHAgE9o=;
 b=Oogs6wdkAAm+dYVugNBrrkq9fekLDarUnzfeB6ROLkAgcKs+9tnNXiJiiAFad1Q8XxT7trPqAeWTMQPPzdXONaeKeL8y4isJuDE6vEgrEF20560hF54MRj/b6P5iWX6xkxN8blQWyL0GAAuTpt479oezk1XgI8XzGXCnDzSEKCp9zSxIAs2P0U7apQ4e8r0pt8n7z2uCGwaPWjTNEZVAEEaFUz3nupCV7x6zuxMSi+tEO4nhLXx8uEHsPKTIHTxl/1w+P7RunnzdB8OoKJmUKWyfd68RI7e8LcZi5KCEDohnzpdDgJtSqZHLbBYaJONcGDbsa1vL9orLnd2bGupYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH9J5kaqpG5X1ISc1dBYtKV6GeFy3HA14UfLwHAgE9o=;
 b=UjoeLRVHGtNiET6Ryhli+c4+2XIXFHRI1jgZEj6XAW+76XhJfTyov1VfVqz6k9ITGTKpzWhMtZmnZGBHMpbdT79cEoisnBuXL64XBNJJF+d71uaJQ1H0exP/pkP3Yl2t/j8B3ZmRemkpbKHKLD9RMfJ/s1uiN+w2DnAD55VgDXA=
Received: from PH0PR07CA0099.namprd07.prod.outlook.com (2603:10b6:510:4::14)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 19:59:09 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::d1) by PH0PR07CA0099.outlook.office365.com
 (2603:10b6:510:4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Thu, 9 May 2024 19:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 19:59:08 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 14:59:06 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: set VCN5 power gating state to GATE on suspend
Date: Thu, 9 May 2024 15:58:51 -0400
Message-ID: <20240509195851.1481475-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d9c759-b3f7-4869-f7cb-08dc70627cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yIRG7ilnyRMFNDGFdLgBVH6zbVr2oBIzEmHq7zsv6uGgZeThYyfao3DmiTcf?=
 =?us-ascii?Q?Z+eFzeWTDGQCraWUjEN2uNsv2pBlEv+6Y35ZuN1fhN8VpLkSsGtJc9kOaH2S?=
 =?us-ascii?Q?H9OkQrryPJ/EPSK8Sso8eVsZJ/kUrEYy8BDcGgSnQkodZ7fNsmZpwv0eNoSp?=
 =?us-ascii?Q?R43bha3eU9oHuCYKF9s29ddDx1ApvHME998IhHzbVOXs9wiiLuvxlPOHt0nq?=
 =?us-ascii?Q?Pp3iSaO7WQ5Cu4NolnZ7G3dZeDJ9EZC1lhWebE/GpNVmkC9Zj04a6oMkQpQU?=
 =?us-ascii?Q?me5GppZUa9qd6luGCZHkwX/7bUVbcD+KZqWX4zODy0jxWohk3CD/zshM155T?=
 =?us-ascii?Q?bhohB/xEJpv6kI5iLEnuLBdgPK6W1SomY7NsjZxu5i0fiZV489PGeWknpkDb?=
 =?us-ascii?Q?RH9R5BLPPdNksuCZIO/MvX4iedIQZS++0hJBuGZ39t3fVXfMlhwdpLZpO33P?=
 =?us-ascii?Q?BD7SSzSmVuXpnkBe8OIiC1qeZ9o9JjGPpVtyxIQCf9EV5pkg6tL4/VEO8cOU?=
 =?us-ascii?Q?9BBHDFvkVH6NS5Vv1YoWbr5FHzM3BUAoPYySAqUwF96SSRTTRZP4cLANxvLk?=
 =?us-ascii?Q?BnQO4ibGe7cREglFrBi1mZ2p84v0Csx9pJ9cMR1vsPWbWyfUsDaWp73lxuA+?=
 =?us-ascii?Q?wEFpYTNJWrkmWIAFVFu+QOiI7mdQRQTb8zWwbEjk7/PD3Esfo6HAs1HfdVHD?=
 =?us-ascii?Q?N2bhGteOs7uL0RdJMX9eaFTfoIBpC8uwENaZVQruQ98210YC1brfvwdIVfx8?=
 =?us-ascii?Q?1wed2C0MkBqgPjmo1WuPNOumYd4V05G6HBbz1KVlKhnTv7sVX9lpmQ6L8OO0?=
 =?us-ascii?Q?FGCWl6KKME23JtjSf7A3td/peQkO4rBORaa5v/PEzOXHXx6n4kJVAHfvmGul?=
 =?us-ascii?Q?O8haojLQd4BAI7iXgiaGFz7p71tpqd3VBSHRNAHE3EJhDPjtkVR1mhXoxqBi?=
 =?us-ascii?Q?FViOMMuICjpSdJsjVnQJu/IkNYQv0jL42cxqZ/3AHE0ZGBXXw0hu2PZSwnrZ?=
 =?us-ascii?Q?tum+YXebxP9o4m93R8mzP1jDc7TAB1HmmB1Dw5Kl0GAwbf3wdeygYEEsNRp2?=
 =?us-ascii?Q?VpWzHNJa+Flz2MGkGimq9B5dXwBGdeIGcIk3VQu59sJ/q4iZHmMmp0GQfJi6?=
 =?us-ascii?Q?oJWJzBSWEHnX/Qto6kQjljCN8LtiRvfhIGc4j53BJMKQUS6eU6qFixzicdgs?=
 =?us-ascii?Q?i/G+xUFJbRccoqvoatw4w8kVZH4Jo232uezsohNgcljVO+uVPpmQ37qcImrl?=
 =?us-ascii?Q?J2hKT868/95efMKstCB3o0ML+VyBiHQpGzb8pxPW0qMLrfSC+ERmiGvObjF9?=
 =?us-ascii?Q?/bSA8SUOUhrQPuTC18bmxOUt/RAC7vXBXqdSWBU6w9XhM6H0f153PP3ea5kj?=
 =?us-ascii?Q?myOPUE4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:59:08.4208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d9c759-b3f7-4869-f7cb-08dc70627cf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
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

On suspend, we need to set power gating state to GATE when
VCN5 is busy, otherwise we will get following error on resume:

[drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring vcn_unified_0 test failed (-110)
[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <vcn_v5_0_0> failed -110
amdgpu: amdgpu_device_ip_resume failed (-110).
PM: dpm_run_callback(): pci_pm_resume+0x0/0x100 returns -110
PM: failed to resume async: error -110

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 9b87d6a49b39..36d4ca645c56 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -229,6 +229,13 @@ static int vcn_v5_0_0_hw_fini(void *handle)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+		if (!amdgpu_sriov_vf(adev)) {
+			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				vcn_v5_0_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+			}
+		}
 	}
 
 	return 0;
-- 
2.34.1

