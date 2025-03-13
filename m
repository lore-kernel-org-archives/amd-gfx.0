Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A42C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 07:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0442910E1D1;
	Thu, 13 Mar 2025 07:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSiv00G9";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 021F710E1D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 07:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iC+Jzzldu7xN/oTZQXWPqXavcglaOjvviGH6HEg9DZaRRwGvXz0yDII58t5FfXwDp1uE/LrKxB4rbn57Ysrx82FO2gB3Hl7jbjc/nbwc9GA46jpipDeKvjZlc2KQJgMG1eBAgKp0CUHy6maIgn9RFgUmag3VYr4fPxGVADOlsqI15CmFup1DBxcsOUxMRUJIxlcHekJEOGwbtD1LmTFYZjcron5CHOPwRY0Rg0W6pVhk/z8tg21H9AByEQJlbQN7ScfIYlNPr70NqglNEqyc/7S2fqKXCavCopOiVaOv6J1qWEMbBJo80QPMxuCeKIGawhTFEgY8lgK3FTtv1saEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQDeiNKYHIIdvV18mb+LsHPLE0YiO3906Fv+bcnhETU=;
 b=Y13SUjO0/GhHApIU0ziLQo9yXJtMDmH2EWKBy4FSVb9UU59wEkQrE4cDmOILTzQ33xjqrb2f5l5TgClBFrU73eQ2tDKvm5inEu5TNXWfmJ1u+m9P5L5FeYc5pC8yGsW5phPlJqmuaxbqcjLMOo1vRvN73S8e496hAJ1KDG0NHcl8HOyUc0CJ95WyiagSLaBrQYBR3M2rfEouzFIYP1Cbi5xQQsw0rEQROpDWejqbDqubzLVp3PK6sm9NiRXk5J95xKf1WtE1X5BNWGENjUbYNuTLffnt1ymPCUm+IlFOFU0jAQx2P6LzBq9uVuTz2YgZ1Lmexx1rWVAWFxPv6qOmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQDeiNKYHIIdvV18mb+LsHPLE0YiO3906Fv+bcnhETU=;
 b=LSiv00G9UIsU7ZPHZobQ/LOYSmZG/S2OKpN7KjTe5zEKZP7FN/Mrjpsu9+ICDu8D5XjF1UxPprNZS1nq8dMpMSOFmCBX6pG6ssBe/g5Nx6bU9FfKpWySRM+PDnta2flC4exor5tQotrWmM4MY2ixu1NKLW53RLpKHWur1+hsv7c=
Received: from SA0PR11CA0040.namprd11.prod.outlook.com (2603:10b6:806:d0::15)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 07:17:17 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::48) by SA0PR11CA0040.outlook.office365.com
 (2603:10b6:806:d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 07:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 07:17:16 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 02:17:10 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Enable ACA by default for psp v13_0_6/v13_0_14
Date: Thu, 13 Mar 2025 15:16:52 +0800
Message-ID: <20250313071652.466718-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: e5355ae7-76ef-4e69-d669-08dd61ff15e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xBSQ2bLTkQvQZWqCQG2BlgrV8gxI82vtgoAX/jR5zQ8oLs9kSfl84fk7al+7?=
 =?us-ascii?Q?E/MLYxKC0dtLNsc+MV5ntQqYpzuIBUhEg5VbrNFmD1DOx8HaMYckDVmCxo0n?=
 =?us-ascii?Q?tb7VVUKO69RoQd5iwPTdaDz6hhhMJHeOMS9XY8twVMINK/B/whnp/AKtHlRr?=
 =?us-ascii?Q?+z8gpg2gDSad4J1+k+WNdxLWPRSrZzCs7oY13GjiB3oMY5k8MTvEzux1yhUM?=
 =?us-ascii?Q?isQ75TJKhyM3gxq01n4uf7G/ZkD20mneY+Kyaoo/pB0JiQZ6Xj8G+IJbQYG4?=
 =?us-ascii?Q?d+gyG9rdsVlVEKyD/JX3t/dDLKrkaBynrixoCrzQPI3A5BhmpexHEcR8FaFj?=
 =?us-ascii?Q?3hXD9viFlxS/lF3hlVo9OFkqg0kZ+UgHFcpUG2eIZYAt8ydOKG/osNS5p99d?=
 =?us-ascii?Q?llqkSTXu8ijjZzQOPBvHn4RUIEWy+W3jSbJwBwlqQCUV8p9siHye22W02DOI?=
 =?us-ascii?Q?+0Gwnla+YAdhprsZG1Izb8EySw7T1mGCVUtLGweXi/4kdqpuQ11Oml3rtlLi?=
 =?us-ascii?Q?i2PipiqE354sdo9P7viKK43/nWcc1l2TNFiTAl57M5hwyrWq8JWyIb9Bf6if?=
 =?us-ascii?Q?Wb2yzOPuw8m7OItE2jux9QPpwJM87CncTjbznSSP7gwXmTk4BKO/pFyD8JUf?=
 =?us-ascii?Q?KalXwYyewqtlpIWqBS7Li1mkdXURI1fKty2uem6G4uqisp8u5hILx5PNbqKJ?=
 =?us-ascii?Q?uQ+6RLuQ3c5fp9HqmnlGXuZxVq6dKucXKBZ5FsRZzEjtXVav0cakC0vSGOhO?=
 =?us-ascii?Q?NsAuhwFPc01NLvDvySNObfTVok3Eb+uIqy9NILFKZxmWTYAKDDXLzvcSHiQC?=
 =?us-ascii?Q?rBg1rNSHnqPy4K0zSVEP+TZtLb17DBWXq74c0Qq/zWb/c+ofobOAv0zkeuuW?=
 =?us-ascii?Q?qBWXWr3eRM+CeW8JGq5sqxgi1ZLN0968lgntbl9CwxCzqSyUhiC+lSioBAgI?=
 =?us-ascii?Q?goi9OOIbVCb6cHvkCIHen37Vwkc4WYimipGuGRbc9yBHFhBD5qB7BJJTaSqE?=
 =?us-ascii?Q?aLpevP6MvBOXaFJ7+OliBAJAANWAWQbYBwm6D2YivE7McTBjc7qXgBTwpci5?=
 =?us-ascii?Q?UDVKwuI+jTAFcOKMAIep0u+yrsNTsw4/438GLtabbA8mzxPxoZ1AQv0rRFpf?=
 =?us-ascii?Q?Z8Is5SF8bwzr4Kc/EGCCUbwCdROlFhRNLIDcgrBcdZluwPVPg0m0suGZf1nv?=
 =?us-ascii?Q?DhiNvY7vFY8qKIUlJHwLQ27T2YSk9LZlGxgjq/STL8oWYi35l2A0Ww/+zdso?=
 =?us-ascii?Q?NMLFjPEH9HVxbpIlDfUPxPSyd1WlMyC0xw9DdzmkX+h5vZND/0itHgkBXIDg?=
 =?us-ascii?Q?ewbfRWxWzssYqd/xtHUVI/hxR80VabNvQFWW1olGUFEN3vt2oa2+aO086G6Q?=
 =?us-ascii?Q?kp9jEGdniWzRVR9WtK9wRy1gLb2jsfDCv9ErGuEcD0BXadZ7Rb1K6RuWkFoK?=
 =?us-ascii?Q?YiTub4Wfj8kJED0f0qlpy21uTK3U5qa+6blKpHh9dHSuap0GkWyd6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 07:17:16.7923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5355ae7-76ef-4e69-d669-08dd61ff15e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
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

Enable ACA by default for psp v13_0_6/v13_0_14.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7cf8a3036828..cfec29835634 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3785,9 +3785,11 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	adev->ras_enabled = amdgpu_ras_enable == 0 ? 0 :
 		adev->ras_hw_enabled & amdgpu_ras_mask;
 
-	/* aca is disabled by default except for psp v13_0_12 */
+	/* aca is disabled by default except for psp v13_0_6/v13_0_12/v13_0_14 */
 	adev->aca.is_enabled =
-		(amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12));
+		(amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+		 amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
+		 amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14));
 
 	/* bad page feature is not applicable to specific app platform */
 	if (adev->gmc.is_app_apu &&
-- 
2.34.1

