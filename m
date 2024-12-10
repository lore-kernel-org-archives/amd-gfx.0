Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64677E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 20:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE87B10E3B9;
	Tue, 10 Dec 2024 20:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h2nD7vV/";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C140C10E3B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 20:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQUUV3FsRDsmISg6yjLLUWTzNFXKg9D0TU84jnh7gTjKW0PTCjHvI1LRZ7Ufd9s3ke7zEPwur1GmU1VzGYRkKio89K+jkUPe/Tjk5+uP7nFdhQnab/krkXq7kIBaX4Pa82uQeZkN3HM6xnUiyC2s6Raoe4dSfBMUc1+XL0kjlWFkp5wHRjNhKi5PT5iqt0zBJlDdJ1ChsDgPQpj23upz7zUHpIQOeoPgBPRMOdJhpdiTLlPskdmQs8oGM/tqRhBbJGNKAZh2Jm0El0gt50+b75YNaBPOasqRkXBAKLrSUeEUkqEb2Z1R5+Nk0ls+5nw8f6FcJjKbbvgxBy1jGhljSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MYBR4g0TgRhi9i2RY6X2izSbO0VUIWOWE8YjrxyT0Y=;
 b=l08L396HgX6Zk4WPiSudluHtP0cU2rdJIrTPJ2lIgYYxBWGCC+C2GDuASSfwx5mgPSrwQII/XPl0mOwqU7Bh36Onnn2v+J57Azelh2b2JvzrN7bOTAJ1ZMBmztXDwR/KGVqKQLcbBM96GLnCJUA9kcNrjjVM1z1gDSSphJW5/4FVrNW+mgn6FbN6p7YUUkBVDe/okTpOjU4uX9fYKKpevxbJLTwcaRN4zieTBrulbV7VVAfbow32XS0YzocGehOQE9lzIaEi6sz6PFQYr41QeaxwXWeKEgG1DNKA5jXCCERzIWE9rrfQpPzLVgcsAqrwhJ1Y7xIZhNhshzLgAyr3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MYBR4g0TgRhi9i2RY6X2izSbO0VUIWOWE8YjrxyT0Y=;
 b=h2nD7vV/jCNxUzkHil+kS9vPWE+YiXjA3oHMlk9/JpHoihZGfrV9wKmL3/HE4zfb84cuG6/wmezXA02LQPjrmgw12sPh51sU50+4sz4+bbuMua/ysdlDRnGmnXeaNtPiX+xmBFtmNpGFfxYoNIckjbiTkZa0Snci3tTLP8iC1EM=
Received: from CY8PR12CA0060.namprd12.prod.outlook.com (2603:10b6:930:4c::21)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 20:04:07 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:4c:cafe::f3) by CY8PR12CA0060.outlook.office365.com
 (2603:10b6:930:4c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 20:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 20:04:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 14:04:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add sysfs reset mask for vcn 5.0.1
Date: Tue, 10 Dec 2024 15:03:52 -0500
Message-ID: <20241210200352.3465587-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210200352.3465587-1-alexander.deucher@amd.com>
References: <20241210200352.3465587-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: aa97c4be-e3dc-49ac-bc6c-08dd1955ce1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F6TeMcNqVH+ofoLCXV0yOR7pQo2ZlnGbyhrAwVMfJ8M50SEOLGwZwIJIMFkr?=
 =?us-ascii?Q?JTFwE8U/HDvW0HyaeO7DxCpqTYmYvpEpTZYXWSl9al8HydOmkgIXxGwsJXCJ?=
 =?us-ascii?Q?aSlmlJKgaDoV/r0ImTciakj229a0kv1qZJJLnfufeiKMvTTJkz9h1yHszJ9k?=
 =?us-ascii?Q?y/5RFry6K/pHY4n02w+/AHEo+ICnZiKz/FwhhIEr+4OHx+yC6eVwJpb+upKz?=
 =?us-ascii?Q?IOEZ3Lc8pvvxK4AtkWDWysAaCJ6A/oNmR+aSqYhiLTRNX9liraa0Hy0BhBrc?=
 =?us-ascii?Q?QyZu2pzluQ+i/Cpy9zr4y5VrfybdVHwtgdorI0THqwEqFsrqbT0kWUkl1UUn?=
 =?us-ascii?Q?lKcwPXqEd76oUiaPd16YrUpsX05cIGNlkhwrxc1sT/+qJhfgN+qvFhhC4lc5?=
 =?us-ascii?Q?+6dLT+JmQYflFBK16Ezz/XyOrHv0D2/diCnGasUHmgNRFuxkQGubR51Em3c3?=
 =?us-ascii?Q?AHNWjmJvDuC4jHFMx/gIclcyia5nkw3RKDFQ+l20AWOfnHj+6ikzPmqEXUIJ?=
 =?us-ascii?Q?Z+Kor3JK7QSOOv9cPA9/OiFlNlKUc/4/sdi6ZXSZcwaBdAI2f7OnSkUBMYcB?=
 =?us-ascii?Q?Nh1mMGBHZmLVnvWvlv7uU+bA3rVh7uSEiL+QoiA+Szzyq+QJzCIUDjBMNxLf?=
 =?us-ascii?Q?xIliwpdkjfcQeyAvBqVvKCQLVh0/U+yECtDeNZH+9w0kQKfWTfwDIOkQV/ae?=
 =?us-ascii?Q?S1NUTLsBuBO+GU0xLs6Dq9xWquhc0NCC+LTvS/HaG5mnLL1ZTa/Cni6kjvjk?=
 =?us-ascii?Q?hzrklir6tp+Bk0u6/28C1S8GjKpphl6II8ew3CA3L356rTkBPO6VSzORDTRF?=
 =?us-ascii?Q?FfajRxYbaGNLDA70CYAr4NW4/eFmipc0YCbn8d8HY5JxDVZfNxtkgq5Hg56M?=
 =?us-ascii?Q?N8wSGFghSxvC3YofsxOm/+/rzcC57Dr5YUSRzwsamkXr3SdligyVCmLswu7F?=
 =?us-ascii?Q?WznNQhpFKhWAHa9Z5OnMqRbPRPzo4p6Vh9fT+2FLl6RpIf36BIX5EeI/nHcB?=
 =?us-ascii?Q?F7Z57XFe2OCEO90ZTmXvZwr/HGukr13OsChChW9vfZIBpk81NmQFfKbR1XDm?=
 =?us-ascii?Q?3gaa2x491HHl6MCs3H5zpE2Y553736bpL+wRCwrrwRyxA2UaBB3vjezjxdPW?=
 =?us-ascii?Q?dNUTpms8w0LaIaa1Xr5XAqZ4YNuZ3FSN1whAqk2teL1ufF4Jc961oP3TkJH1?=
 =?us-ascii?Q?jQKmOsyOEb5LJO/G0Y0f6CLNfwr5b5xvL6nucKI8vzeYBDgYfnN6aExI3CcY?=
 =?us-ascii?Q?x60QQDI4bIAdDUvjN+gs8sUSMsDwZOR4jHqaIpS39j623H9sGZftq81TwuBA?=
 =?us-ascii?Q?T2yobklPjWSdSulmfxiyARxAmIVB37djKPkJsuko6YDLeA7lanpFNjjE+pXO?=
 =?us-ascii?Q?TEzYRpFV5Z6c/+1Vuo5MQGttY7a3P56eOos5dqbNvgjtSV7neXpozqN5c+1N?=
 =?us-ascii?Q?vCe2/UVD6GDWVfHOmR3gnyiXmupdiL3V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 20:04:07.5729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa97c4be-e3dc-49ac-bc6c-08dd1955ce1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

Add the calls to the vcn 5.0.1 code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index a076ffb3867ac..8a50dcd64e6eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -119,8 +119,16 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
 	vcn_v5_0_0_alloc_ip_dump(adev);
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -154,6 +162,8 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_vcn_sw_fini(adev);
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+
 	kfree(adev->vcn.ip_dump);
 
 	return r;
-- 
2.47.1

