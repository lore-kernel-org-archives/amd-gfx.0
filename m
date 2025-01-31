Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D81C0219A
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0412810E419;
	Fri, 31 Jan 2025 16:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FJIHPdlW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA3610E3C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yC6zz/2nLsTzinFj57hfyRkxAlt2HzxB/LtDXXUQP2eU0sVXDumCWcXp+p19JEag8q55favQIM3g6vv632AYmj0iwPITti9NkzS6QuSJuTTOmTUeBNxWO1lungxlIPboQRreYaVxPTHIfebppxFIOS6idUnbqzWd8OLr2fB7R15/kdVKSlm/bD1LfxTXuc9/B//Ni5mMPx3Ulb9OidhhBEeKV+NFA25iPcX0XmbG9pODXrTRaTJyzYFyXPGkIs50n9gd3SFH3LdHrD8WHomyxF2YZ0lIvOJPsBDK7IhXhiFf+1Jh5di9DM+ldPXYhQpfZNN5aj1OKGyJSmrH8dUbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jD9Uq5Vj0Eg8WrxSU9FDUCnyctZ0iKz2uFK5mTjFScg=;
 b=TIDD0ElNxH4upkAH4BK2/CI8sdBmY49AN34GWupwsmMAgBLwGwUg6YzJAV7i62E9fH56hVcuTYrX8F1zvyXH43fyjZmdLQvCvbWraaQMDmWA9j1Sg1xIuneG6Axpyos8uwsp+AxIuoQF4pAUvGFw36SVJvVjUk17K8+XdZf3gk9EQUfg2FbKSHqmKv5xm2IC9Rjt8tTP1fHRxyjLiDliJ7h63Bfhk/xG6KbVualHbiU9xDbJaJpdE5eDDS51qMpZtT/l+ZsLHj7a+f6I5/LwgPvKgEvc6FiBTz73O5hA1OsQnuoHhLTyQo4yyTMzA2LRgpeGlBUhxsGjZtydn3Pwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jD9Uq5Vj0Eg8WrxSU9FDUCnyctZ0iKz2uFK5mTjFScg=;
 b=FJIHPdlWMot82re6H3KrEDL/xp8h8oFtDvdZhpEFoM/KZzRdc9Py+7pJhLs/tAFKsjyGOqk7UgLM5C845iLn5rrPp+C6VtR1CCfAd6MMAT6f83BzBMRi/NkxkJfOQiIdQMoiXy/HBGb5rfuQ0tnRoBLQkAt5Egjj99ckOxUjwBQ=
Received: from CH5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::12)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 16:58:30 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::f8) by CH5P220CA0008.outlook.office365.com
 (2603:10b6:610:1ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 43/44] drm/amdgpu/vcn: optimize firmware storage
Date: Fri, 31 Jan 2025 11:57:39 -0500
Message-ID: <20250131165741.1798488-44-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c12debb-2b86-4899-e5dc-08dd42187d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uzRQ3C17e1Dvku8ouXgHJv9Y+vM1eIuHfHNDPIGduVuXi6pu9oCZ47d3Y900?=
 =?us-ascii?Q?UmF+QmEY8mk4khuejA4KNFQapLpJOtkK1wvur2o9B0WF59jeqxFTnVPXKR7+?=
 =?us-ascii?Q?hyYa2PnzYN1UH7+oMmLrn+5Z0nfxQ1Uo8zZSHLYDBNWKKujQbA8HkUT0VxNw?=
 =?us-ascii?Q?gQ2bvwrE8UtfaElHaw9Z1AEEfxMORv4hxEhbI1kWoAPCYAA3jLHTMZ7h3N8O?=
 =?us-ascii?Q?N8+M6fRXffLOIgiE/g+3cyy6AEegC8qjtz49hXRa704lU5mr3W+KX/khZSMV?=
 =?us-ascii?Q?EGVpOQN2FUfKhIuatGXzyPdl/L+z4PWL4TXsJ9I3AclXTZPkK1i1GHJ1+p3l?=
 =?us-ascii?Q?a8eQuFzTxCpc8O9mPNT8lMyeX83A7NCOMnjsC/shDQONw4wEoZQl3eErQXYi?=
 =?us-ascii?Q?VOeHNPmoxhJPJn/iiEgHSRac9//G4/30lXhrr/tq8jxbz6qMeghdjb8mT7ux?=
 =?us-ascii?Q?dFv0HksO+5b+ai+xkPZBCLNgo9E7DKt9F0mXPNxCrp3LVJw5ywnXbu2vNb3Z?=
 =?us-ascii?Q?yayiPbecUkvutfc8jAzbwUQ39xJUzU4k3zeAyp9uoxMcyIm05aNqVwMU3z9b?=
 =?us-ascii?Q?qFWzlJRON3R5J2Zz6nzoaazmKWwWLDwQ9kOk0ZNjvcCm77cLKDQ4UOEVLQpv?=
 =?us-ascii?Q?RWgx4lYFlO9rTE7se+Cw5XyW7SMST/OO468pXvBTpQOEUh1LMPhJ8vK6aSCK?=
 =?us-ascii?Q?cxaR32+izFPP5/jDK+gHlFFpY5HSM41k5PSDRl2V/SqrQjSENyTWd7HZROBp?=
 =?us-ascii?Q?fSMcdgsUfSup1sumE9WAGQ3ncZs5xRhSoNIuPR71xkPKIDdGaUopGb4yFk4O?=
 =?us-ascii?Q?cXZfD7mNtrf/rrbU2sq4tvWOQMbfpRIIcPjOA3WCGksuToVAqOnatd4UA6T9?=
 =?us-ascii?Q?LRuX8rB/WFb5bDGv0ubc91d0CpxCoIU2ZuFBrxv77P6eNbmqzfVDG27M4h5q?=
 =?us-ascii?Q?0oATYr+jgcXw7bHMB1zE7uk4ox4H7fRFZcxuCMrHUZSID1grUZFVRNvFN8KX?=
 =?us-ascii?Q?7Fq4Dz8OLWWml1JEVYol7CLTkFE9RoyKwh2MXxoQbHt3rPz/Kch2RVDOAB3I?=
 =?us-ascii?Q?uZVFNwaKam/xY6HG4V+99BLtRC5q3mIUQ6PR9HSKXogG5kDnFGfumiOQbgzm?=
 =?us-ascii?Q?NBEK0C0lApSIXoVrQj9GBoKz6OyUZrzDsZB2YrUv19MLbHBxVOXMcmxRE8Wl?=
 =?us-ascii?Q?zJ5AG8LC5IGc9/TDV0j7pFfpcIWPqYkwYn9i++C2kryJtu0RB87UOcG79+M0?=
 =?us-ascii?Q?y3BvZlmWcCi4Vq1prQwjzLhEpNPI6THpWD+B+yJ9PycnunoluJYyGOnT0Djz?=
 =?us-ascii?Q?yB75Hs8hpOcC8YfdME3i9Jmz1ZS6E93BCdDYxBaqx84MiwheQdbhX6NfotDz?=
 =?us-ascii?Q?bQE7yTtYGGEcPDbW20ighUzMjS1NFrV6ooFgOVnUWI0/425sAXtdFPMNSEl4?=
 =?us-ascii?Q?p+b4dJB8Erq7YoZza7ovG2bgpwfFIVAZKXupISHHfccLaV4BEKKAEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:29.9243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c12debb-2b86-4899-e5dc-08dd42187d00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868
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

If each instance uses the same fw image, only store one
copy in the driver.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 30 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  3 +++
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e4ef0fb970b29..edbcb11c382a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -102,18 +102,25 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i)
 	adev->vcn.inst[i].inst = i;
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
+	if (i != 0 && adev->vcn.per_inst_fw) {
 		r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
 					 AMDGPU_UCODE_REQUIRED,
 					 "amdgpu/%s_%d.bin", ucode_prefix, i);
-	else
-		r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
-					 AMDGPU_UCODE_REQUIRED,
-					 "amdgpu/%s.bin", ucode_prefix);
-	if (r) {
-		amdgpu_ucode_release(&adev->vcn.inst[i].fw);
-		return r;
+		if (r)
+			amdgpu_ucode_release(&adev->vcn.inst[i].fw);
+	} else {
+		if (!adev->vcn.inst[0].fw) {
+			r = amdgpu_ucode_request(adev, &adev->vcn.inst[0].fw,
+						 AMDGPU_UCODE_REQUIRED,
+						 "amdgpu/%s.bin", ucode_prefix);
+			if (r)
+				amdgpu_ucode_release(&adev->vcn.inst[0].fw);
+		} else {
+			r = 0;
+		}
+		adev->vcn.inst[i].fw = adev->vcn.inst[0].fw;
 	}
+
 	return r;
 }
 
@@ -270,7 +277,12 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
 	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
 		amdgpu_ring_fini(&adev->vcn.inst[i].ring_enc[j]);
 
-	amdgpu_ucode_release(&adev->vcn.inst[i].fw);
+	if (adev->vcn.per_inst_fw) {
+		amdgpu_ucode_release(&adev->vcn.inst[i].fw);
+	} else {
+		amdgpu_ucode_release(&adev->vcn.inst[0].fw);
+		adev->vcn.inst[i].fw = NULL;
+	}
 	mutex_destroy(&adev->vcn.inst[i].vcn_pg_lock);
 	mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index a023f46ec904a..26c9c2d90f455 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -339,7 +339,6 @@ struct amdgpu_vcn_ras {
 };
 
 struct amdgpu_vcn {
-	unsigned		fw_version;
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
 
@@ -356,6 +355,9 @@ struct amdgpu_vcn {
 
 	uint32_t		supported_reset;
 	uint32_t		caps;
+
+	bool			per_inst_fw;
+	unsigned		fw_version;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 0d6a97c4bf8f6..347a2c40c32d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -114,6 +114,9 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r;
 
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(4, 0, 6))
+		adev->vcn.per_inst_fw = true;
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
 		/* re-use enc ring as unified ring */
 		adev->vcn.inst[i].num_enc_rings = 1;
-- 
2.48.1

