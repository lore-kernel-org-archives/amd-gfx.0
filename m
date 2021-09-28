Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6707DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B89761262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B89761262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE026E8E9;
	Tue, 28 Sep 2021 16:46:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B14C6E8EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFXbPlEdTRtyQ0cb4IR2vp9O9BSxZOqxODpp6R4QWi5sZzgAFQx3+oroUW1qQdZRmR/v4X8UcTl8HuS0jYZeFLL/KteE5qdKrNeZwikpf2D5AxA9cTFGoAda7dF1MijGFDinv+RsX2SS6C4M3w6ZSiX8MzV/y2LZTTEheea0Np0YQ6ZLYUf0JKoUbs/mTGb+MwP+tCEzVyoaoeRApLQG7cyT8kmfK7lmWxgGiSzFoboldI/MwFo2Lcoyt5EiIy8HChDxdkxc/kqRJ3MszVn+MbwK0OIhW+fn3KB02u1MTR5DASFsBc2yYeaA4IKHJukqahNmw2d1ur0kpnegtAfKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NoVX5x09FMScLHknCbbLNtVCjsEnCu1PT2C91RDWA44=;
 b=lgHmtfQndzun4saotfOYHS0+CNS+uogm19svn/iToSZsSCszLWXv/cTqNKkyRgh5X4XcqB7uvzkFlMT0k84WVg7+LnhMsb2ZDL93ccIlvoftZVZjfER3u+p7mMeSNL0iwpyp7uRsEUpwRbm3Fg97IuyDXtvWYJ4qC9tzo5cLGThdexIWeE7rWu/OrrvKBmDbuWxKv8VxsqVTgGCU1M70uhQPcfmCOJqxFv9yTCMuE3koGtBHkinUOcQIOe6+plP38j2ly5eqodoi/c9S+u+1pJIxqM2RArwEATWDDxmnaE4aJjoJlIoFuElWxTjoYSD44buAbDOQvztiFpiDRrvgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoVX5x09FMScLHknCbbLNtVCjsEnCu1PT2C91RDWA44=;
 b=SSa0HUseMnuCzHv2TMAUTvuSwD5GEoKw5JSqHOxQCTNk9ZxeVTffINwfOBa0nJn2TS7pYUzA0UcKreYpkanUBFwj4JBGOAViRj1/MRZ096ZTHwOcx9vGdtTI8dPZHODT61gwY7xULDdrkYcjtu51kp/YxX62QZ9kSkJ8ITNeL04=
Received: from DS7PR07CA0001.namprd07.prod.outlook.com (2603:10b6:5:3af::10)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Tue, 28 Sep
 2021 16:46:18 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::1f) by DS7PR07CA0001.outlook.office365.com
 (2603:10b6:5:3af::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:46:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 55/64] drm/amdgpu: get VCN harvest information from IP
 discovery table
Date: Tue, 28 Sep 2021 12:42:28 -0400
Message-ID: <20210928164237.833132-56-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29b4f08e-13e9-40f3-93a6-08d9829f7e0d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40555CA7FA90043BBC54B27FF7A89@CH2PR12MB4055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjQ40E6PzWLLtlZZUb4TOYbrhLKQudKDJaZ2lVReJ7TRFfr/0HwJ6mk3+DdNsg60TWlPEOtG9dDLTyyV4fVnI9n05pYc9x3ffQixrBgjNL5DgqBgvhMarpEPq3WesbzTQDeV1HFGJDMRFi92hGO+zL8hLyyP8mbo+FF3JyytEyFsyqExpzKrDyanrVqV0sGGe+mhuPcDz2pVd6SXW8wGuPf22To2tT+tUhsQicc/rLfhotYpnWxoHWsWw33rBqcVvVdOTWlB322CfIn91x89F7MPG8152umJZ58xBu5Dc0bGdDfTHGxAOF0uD75T+CDSGwLMHQc3GFKlnPgclSfKng0E2P3Bn5/ejKD/xA1SgvZOfIy+8ZY63rYidU0ZOmQeTVgZjt19NcTt3hv+eqqqvhdd9fl5puo7jO+CNWp3OsJDwcQ87zwmJVO0Wxd6bnb85eW9KwbLPpV9vkRXNIebiajO6wJxHaMwNbuZwHUgef0abrFQsdTd72rTQ9owxyBbhH/vD5n9Q4UpKP78GDAKOHKZqieBckoTCnaccrLWke8bu1QfM78qgbySrOZVkdVCVL66qh0QcmbREjY84kHGlASq1BPva8qhAa2wk1/HulXrjYsTGWFRMvAS0L55CQy00zmrDiOpR4xdAr2kbUjq2ebCQg7ckGUC55F662sw/gd/+xKUUpeN3zslLmxmTKaXMQmrmWjZwdbv6nxnzKCfB2a5DRmZuGD5lXkEXAVboLY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(426003)(336012)(16526019)(70586007)(2906002)(7696005)(36756003)(70206006)(86362001)(2616005)(6916009)(508600001)(4326008)(83380400001)(36860700001)(82310400003)(5660300002)(1076003)(8676002)(316002)(8936002)(6666004)(81166007)(356005)(47076005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:17.5066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b4f08e-13e9-40f3-93a6-08d9829f7e0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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

Use the table rather than asic specific harvest registers.

v2: remove harvesting register checking

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 19 ++++---------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 13cd814f2626..dbaa238a4620 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -470,6 +470,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 		switch (le32_to_cpu(harvest_info->list[i].hw_id)) {
 		case VCN_HWID:
 			vcn_harvest_count++;
+			if (harvest_info->list[i].number_instance == 0)
+				adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN0;
+			else
+				adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
 			break;
 		case DMU_HWID:
 			adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index a81d834ea0d3..316cbef70276 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -87,7 +87,6 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v3_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int i;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
@@ -95,20 +94,10 @@ static int vcn_v3_0_early_init(void *handle)
 		adev->vcn.num_enc_rings = 1;
 
 	} else {
-		if (adev->ip_versions[UVD_HWIP] == IP_VERSION(3, 0, 0)) {
-			u32 harvest;
-
-			for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-				harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
-				if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
-					adev->vcn.harvest_config |= 1 << i;
-			}
-
-			if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
-						AMDGPU_VCN_HARVEST_VCN1))
-				/* both instances are harvested, disable the block */
-				return -ENOENT;
-		}
+		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
+						 AMDGPU_VCN_HARVEST_VCN1))
+			/* both instances are harvested, disable the block */
+			return -ENOENT;
 
 		if (adev->ip_versions[UVD_HWIP] == IP_VERSION(3, 0, 33))
 			adev->vcn.num_enc_rings = 0;
-- 
2.31.1

