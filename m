Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB45C0219B
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5035010E3E6;
	Fri, 31 Jan 2025 16:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kWuvOqcY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0364710E3C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voWPr30awXyn5xf7pYflTCpL93RbuhhckuZmj6Pa+1XRHUF/by+2yckTCKnMwWBnrpLFUJpUCTGxwnIiQTdXRVTmHnqZ3v6SMRTW5zVOiiCjSx8WClHPZIdTWLkQs2Xnfb31QQnmrW3dCJAiYg2/5EsQWmkuAP1NhthzRiMbYQnv8C+XsNtBvaBZuIbKI0cTt/ECAW/HgHvvaGNWAs3uFB8u3vw6D/ckr+BEu0NRGr/GF0R0PwZo7iF3oNqcbuQI84EcrmsrtS3utNwwL8cYiXARUyo7W8Z/GfqHmYijC3riHO/zbXYtikDcFiPje90ZVY0VyqZ1AtVTHf9wxTAmqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKvwqnaCUkMH5Uo3NdapXPnlv8yxNtuVXPyvwwwLLOo=;
 b=RClRRLkgG+99Rtev/FO+MJneUS9Gnv8h4N4lQBNsdRQy2dxaQPBK3Cn7xnoFyzWMC86CRPsBEFxtMUmVQWx2XUOj+Sq99V+PyHbqTA+8pyQWKWyt9jBgskJ3O2T83H+n8xwCj9QXHjU9b6a0k0aaJnfZnAlrwenu9gT7yG0xoKR9i5D6G84qaQuqyIWLpglV9GVK9Q7vTnP5FL/YeaoUtmC8suprJwk+qZzTvphBztaRObdoBdNzZcBSWRaVyXL9l3GujM3GfgCMKq2Z9xIhJhGZHminJwmy/vegLc1gksMzQzuf2exSV83GTzK58cssNTs5/Mxkcq0kOqNlefCVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKvwqnaCUkMH5Uo3NdapXPnlv8yxNtuVXPyvwwwLLOo=;
 b=kWuvOqcYemgvvJl6GvdhIag+2Fbsz1A8QqXt2EYFUUbA/4cE3wAIdAhRZhF+cBNpNIK/jzK+jTb5Hoys8pQjGEbY912yYMOF/A2BxeczZZYs2tKYEtwOaZtXycxRQbXUzNkcQlkC3+jAwTPeke4mQJmeml+hCzLVDHxlxdsaUrI=
Received: from DM6PR05CA0052.namprd05.prod.outlook.com (2603:10b6:5:335::21)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 16:58:31 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:335:cafe::a5) by DM6PR05CA0052.outlook.office365.com
 (2603:10b6:5:335::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.13 via Frontend Transport; Fri,
 31 Jan 2025 16:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 44/44] drm/amdgpu/vcn: use dev_info() for firmware information
Date: Fri, 31 Jan 2025 11:57:40 -0500
Message-ID: <20250131165741.1798488-45-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7240d5-0052-4dcb-b360-08dd42187d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wv9mp5U+rde7AeNp+907fdVWFsQ1FyC2q3S+HW11bv5xgYDISX0lrt13GMmA?=
 =?us-ascii?Q?Ao1bI9BXg635SfGHJ4InsLkolVDBcHBVVrLKVzFKIy18EDg6Nh6FPKaH3zD5?=
 =?us-ascii?Q?l9kUdZQYeptFwVLMGJgk52c66TyHtvjVyQzu/Kz+maFe+4yED3zQk+V8sK76?=
 =?us-ascii?Q?7jxv+bOXdZgDH8H4wqJenP5BVYGs7iVhka1Hh0nEs/WhBnUMJEemQGkq8ms1?=
 =?us-ascii?Q?wo9xFJQk5Em4hPCzmx8GwCVTyjXAORuMEPzNPt+Xl9a+ljIyJimfZLW4W+1G?=
 =?us-ascii?Q?ARkttNVqZsW/L13Qux0mp1jqoqwFg+AQrhqxVfUJeN/WBIzBFbysfyS2EirS?=
 =?us-ascii?Q?KuqCAl5TbwgNCcfqBI+9TIRhFsDmYMiWNC0sZFFMDtAOpf+o31rznx0dJ1Dc?=
 =?us-ascii?Q?WIhimqK8U/euBSbuV6XbAyr8AO93Dexr48wy0x4TVIh4KkO95q+DtH309H6a?=
 =?us-ascii?Q?JqUPL0USELs7rV/prvckAtcPZ008C4Xul3no8jyxrAcyqsUMswUaJssCZxeJ?=
 =?us-ascii?Q?FF+Ay8PPMs/hyuCiEOUP6H44nStGeBNhiaP/hOu9+25ksEUm5yPxExfW5fY1?=
 =?us-ascii?Q?XSsdgHWNxGs67M+7RjdD8kpKQL36HZlyYDvJtroayVVkPI0HuKEAeoWjVwox?=
 =?us-ascii?Q?4C6rXzTUvxZrpk2q68Ti5tFToq3Rm0tMxF8W2FWBq0hPOsuC0WNoQM+Jj4aK?=
 =?us-ascii?Q?hpqtL3UlkMpMlG29dN/zFY7OoAwuhzcZQqToc/SzY8k4KGKPgQM8E918H6ly?=
 =?us-ascii?Q?xRACICAQGLJscf4f6EEh8uJI9geAwTHg6wwBrODfRmsf9Z+y5g03A1q4m9gP?=
 =?us-ascii?Q?dBEyr753rgj/iqZxHNnGZP+in1KfYdEhtTHdr36J5hKJqqYPC7LVXI5FAFsM?=
 =?us-ascii?Q?KhMqeGPjOQyS1V7CJeU6IYejOYhP3pFzFkoAG9843+dgYLkZDKDlKMARV4Jo?=
 =?us-ascii?Q?x/xf0bZrAp+swYrohs7TbRzlBQi2yOpI5G2YHns/2WcvsQZ1kmkJ4HGRr9dy?=
 =?us-ascii?Q?vs7QlXfpNlE3+pEIxhVqyfprqO+TZluWg+8aBmXYD8IC2GtJPUcuN3IiAKnt?=
 =?us-ascii?Q?EyBZxTLS5UYHvdv6g2wlU+fzQCPB9D2s1/o+/hzviijIgxeUdAdqjxTZ3q2i?=
 =?us-ascii?Q?fbrAQzjg2HqHrDyhVvcrm7cEuPZ6lz+2WZoZbqUdmB0JkkG90BsmeOnFqTWA?=
 =?us-ascii?Q?Z7zKhiCZs7UVDeH18JBUQ5CCqweIlWRM62p/lGRht47/KD0dHvRV7G1/ipEd?=
 =?us-ascii?Q?UOy453KGaqhEzTCfTh9w6nxdJ9ky6SL5uean9F1XVQ0goRB0FI5VHEsEKL5s?=
 =?us-ascii?Q?I8Qh/ehMfJUrLPgeJUnqJsP2ntZqCX9StJsYbi9wmohpBfGrG4FIWyu29sT3?=
 =?us-ascii?Q?LewtlO5kekgPo4i8cLnwWCqIrSYp5K4j+PfUsNkxOSGTXu+NSbXm52UWme1u?=
 =?us-ascii?Q?1oKs+GnBl9r55r3kv/SZQBHgQpAPF0JR7BU1QczHWa5v5ukz8fjU4FCP8+aC?=
 =?us-ascii?Q?Q9MEDG49vnid9nY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:30.0869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7240d5-0052-4dcb-b360-08dd42187d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
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

To properly handle multiple GPUs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index edbcb11c382a2..8d8b39e6d197a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -182,7 +182,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 		enc_major = fw_check;
 		dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
 		vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
-		DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
+		dev_info(adev->dev,
+			 "Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
 			 enc_major, enc_minor, dec_ver, vep, fw_rev);
 	} else {
 		unsigned int version_major, version_minor, family_id;
@@ -190,7 +191,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 		family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
 		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
 		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
-		DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n",
+		dev_info(adev->dev, "Found VCN firmware Version: %u.%u Family ID: %u\n",
 			 version_major, version_minor, family_id);
 	}
 
-- 
2.48.1

