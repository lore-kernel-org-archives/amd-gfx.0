Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94609C021A0
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 00:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D5A10EBAA;
	Fri, 14 Feb 2025 00:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cy0nYC36";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD37010EBAB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 00:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaEao5HpmJSSHCaXngqEp12RrM8q2PRqB2TofA5trsJgBubrqQH/Cq93T9pCrPblq9EF5kRo42pw2cOGiQO3eVis47y0mNFWNS+STFwpDYaxPPPHJqcRlo26Ri6xlbWbzJo4CDppVqnD8/CXep3BoEo8VNbj0yfNMS6CuLfAP/EAfHJHIfhklpGCtcEqi/jAkfEjMh97tOpJo9qUVhvAFSE7gjprYWudNfwVMcUDMgRmAuamvV6M3UUtOdqQCoV0N6i1MgwHR76e7akn0bT+Zmeri6cukZNdqDgi4NBT0s4BiGZ5ZQNKmSdGhmnfM/Jil5gwtQztHCPqJhbqHyPcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d89CAYtbO7rJLiY+zYj9Mxwm/b8WIix90u6kDTIy1mo=;
 b=qE3rY5DYHEfeFKby7dV04UirzjPBGtaRQCVzocuJwATRCw73bvNT/mgeOXkqiHPxLP4n/94X24FyGY5BXe4e9HdUtFG9sw4lxsGFYada//UuRVShJeLB8MtVFapxQqMDSO9uUY19rH0hUH82apNyzy6xJMN8zwlETUYA/cvzBZQj0Y1umG/dghu+0IfqcLn1C5XWEqzYKmP/5uCfVQoKJlXGcZyBZ62k/xzJULYkuxYXq67JLS/kiXVfeT3/8tzzWTPvn0coFfsLb5JYaJE1VH0mz2mqYwtOMz9SHEay+pqc6zcRk/NlIi5S6qiz0H9Sohr0gRyLYS5eQ4AkAw1aUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d89CAYtbO7rJLiY+zYj9Mxwm/b8WIix90u6kDTIy1mo=;
 b=cy0nYC362kMoHMN+OnccygEnZ/ujGobFfIn+jrrW9POQbyZl57McVBQ8j6LbuM3YElMhyjt+Onnuijgm9Bj9W8FWwf9qM+n3PIEVisvM6FbytH7gx0bXtEa4AaazHjt0wHnhNyEVGzfHn7Js5vQ2IDRJR1bxfQksSisTwcNjNkk=
Received: from BL0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:91::16)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 00:14:09 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::e8) by BL0PR05CA0006.outlook.office365.com
 (2603:10b6:208:91::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Fri,
 14 Feb 2025 00:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 00:14:09 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 18:14:06 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victorchengchi.lu@amd.com>, <hoarce.chen@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Do not set power brake sequence for Aldebaran
 SRIOV
Date: Thu, 13 Feb 2025 19:13:48 -0500
Message-ID: <20250214001348.4767-3-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214001348.4767-1-victorchengchi.lu@amd.com>
References: <20250214001348.4767-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: eb29e6cc-2fef-46d5-7e04-08dd4c8c807c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3rg7ZkrnhRGaMXzoKVUryv+yz7C15gHdyjWo8UvBZclFd45CmullSIpHd6z9?=
 =?us-ascii?Q?aAmBZ1j5jYogXPr8qjlEAp9p5WhMCR5I59pPkRrducYcrXIJhBLQcZSKqYSW?=
 =?us-ascii?Q?nn5xdOTlWF2FYJ4qJ0nAf1Shjt5bT12SOtuMmGe05XCbPhNcFNMCgY3jWOYy?=
 =?us-ascii?Q?32VM5AAQLYa3291dw2wlgxZ92iztCrBz30bXQ9doDgyadchsvu1mXrHm8ePt?=
 =?us-ascii?Q?5sT0LMLDUYJeOqkGphXZJQInSbQKVGDKRpnNoKSI9Pdo9Z8R6byTd9QZhZQ0?=
 =?us-ascii?Q?bJNPXVgjgAflJ2suc7+DWW+AOp74SoYC6htJU7ilNf2NBUQejirys/z3xztc?=
 =?us-ascii?Q?oVOSam5PfMZkgf79WTYhk3FaA19X+VACbdx40wQPAwEqCxBiIlzYmF7WeUTr?=
 =?us-ascii?Q?k4WJPRWiSpe9+GidKWhX3paW26BT6lKMVHhFzip+oWBF7sWvT1wt6hv7NcU8?=
 =?us-ascii?Q?9k1hUx/c032LJsaJe6wy2jRojy0gRWRrol9gf+zuYPXaeKmOGnCO+MLaJGW1?=
 =?us-ascii?Q?I1aZJ0lHWwTO1eqSO1qtGHl+e0MgSA8t59jZXSVCuFw/wVYxpvKbMfdCmHy9?=
 =?us-ascii?Q?hmpCxLRZ2ZM0dWXVwXNRUrs3AvPVM0DTAdr/0l602ymivVIKddSrG62e6NuO?=
 =?us-ascii?Q?3/jONMqCGeKsg9DUAi8GO9kh0VlPcIfIvqVXyMSGG3Qxo4Wb7SYWqKPvsQ0K?=
 =?us-ascii?Q?8LA7DmpsLGhpibLzbP2/rnBGYWHbtEyWy3Z235QMCpZTz9Axl+g/p01mKid3?=
 =?us-ascii?Q?WrlGY2WJ36NmpVI8UOMgA3/TteM4/NOlMqpabT3V7bZiKIm1asyAisePFzGA?=
 =?us-ascii?Q?1K8W2MIc9ziH9XeP88TmL2627xyUDdBMqcTcFKAr5m+XcdtOVcHlDSUSuNFS?=
 =?us-ascii?Q?nwRF9jixDZ+tt2/ut+H5LTlhq1/Vgn9kcoHvAzftiQFVm18XtFFEXTTeN0hP?=
 =?us-ascii?Q?vR7SgloNo/jJDZot3WgcpLJdb8phhwPTsDeobN4OxguVv05O7CbeW6xA0Mtx?=
 =?us-ascii?Q?BPPEyJ1MqKtP0oFhKLM9B0c26jBpcUJ5AI4viP9X0LygOWXzWbHct/q/QVff?=
 =?us-ascii?Q?cjruYIImpWBppnkImTkPunDBNOA2SKtko0E81hnFm23kEf6akgWS+ZNiYoUe?=
 =?us-ascii?Q?dM0Qv8ijWTC2y1EhIz9Kv35yV6aiKrB1aIusjp1hzkultWIN6nhtYMzz7RYG?=
 =?us-ascii?Q?TPfKtZ5F96uQpSTcRG7LN1cTrWM0lNy7hc2yj3yp0cAnCRqAqjqyoRyqxaws?=
 =?us-ascii?Q?eIXuFvkz4Siuz81D507USaswMBA4Lr7/QQF9006ILQwSugRKgG32x1m36K2u?=
 =?us-ascii?Q?WJGuSO90wkjfZvNJ3nKkslv/sOJ/Ea3fUSvuzRoKRALOA18/L31DUkSv699w?=
 =?us-ascii?Q?4Iyz5NuTOhF2kJHWVV2PSam3USX0ZMUIBznA9b2bCwaTbN+MBn+15KF6oPsY?=
 =?us-ascii?Q?7fS/yuh0IMLIHK3r5zFb5bx5RrCbZnA+4HpWW1Wdp7XbXo6oZx1oDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:14:09.0628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb29e6cc-2fef-46d5-7e04-08dd4c8c807c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
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

Aldebaran SRIOV VF cannot access the power brake feature regs.
The accesses can be skipped to avoid a dmesg warning.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 569a76835918..31b378eb5318 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4044,7 +4044,8 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) &&
+	    !(amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN)))
 		gfx_v9_4_2_set_power_brake_sequence(adev);
 
 	return r;
-- 
2.34.1

