Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BBDCD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 10:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 673B910EF9B;
	Wed, 17 Jun 2026 10:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RBLQj1M2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7681D10EF9B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 10:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ve1VJPB58ZvlvakzW1J7/pD+iMEWkkGhdUIgYl3gS98NbNWcYZNOunbm/6/FSTuGeGK6w6koB4Rgj6Lz3b6FobwnE4aklIah0uoQfWwzOeN0MWiTojllj6iGmpRtu3J3BRrvClKV4r+3d3ayGZIqAdtSdeKdWCpPe8bEv8Yu6rkLSqglwnok0PDyZ97oDrs/zcDSFtNX5nqELrY6S+qNi8GUBpWCVs6/ufl7qDUZE+F26NDWIdZXq1HA9IvJ0eFqm/tMrq6ls+0VzuTRaOvErqKH3XQe64VCwy6YP1LQBZWIySsUoH+FMZs+rk/UVSozu2i+Djcbh3C8Y6hWISEr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=umdavFLIRZPsRpGDsaW7197qlVx7L0lh8yQItw0uAk+AuaRm8I5EWaOrMOY597uq+pqRPGt8qbArRQWe4GxrchxYeBOFPFHuIOaCCRLncjuev/6sIfkhlgQFui79cWSWB7sIAi8X2P80EEd7/si0eJVyn0A9Nh0CbDCpB6CSEqfbV0d24zacoqFeNu0xht9GNZZVdVqxLPY44WVIM8iMAKAFwr5Xq5vyhyo2YIGM/sstruCDtDwVbb5uwTBTFOZgi3neJZIv26gTj7UrWu2c2wIEdNL5ZA/uRVR5VDh3bkUlpnnZbU8LxS3OpDTJJxlhKcuMsMQOwP9r7EhlcxFFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=RBLQj1M2YJncNERw8IddZXErTVBMDUnZtlU8w+6w3DBTME/D4wY+IbW+PrbNPptmzFcTnVDLgl+ME2j7fBiGpdiiM87ee27fuB9OARdOwbVaK4u0aV4QYs4y7CTDcPfLCGIW76wTGNcyV37+YirGoyxjSaNT/ReHvAKsBcQp8zg=
Received: from SJ0PR05CA0099.namprd05.prod.outlook.com (2603:10b6:a03:334::14)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 10:43:57 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::e) by SJ0PR05CA0099.outlook.office365.com
 (2603:10b6:a03:334::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 10:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 10:43:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 05:43:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 05:42:39 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 05:42:37 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v5 2/4] drm/amd/pm: add IP_VERSION(11, 5,
 1) to vclk/dclk DPM sysfs whitelists
Date: Wed, 17 Jun 2026 16:12:36 +0530
Message-ID: <20260617104236.13331-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e42eeb-fbe5-4c85-514f-08decc5d55c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: XQcBvBC9hjmTK3ZvZxKITOYvohCmUE9sxPF2/1+AoGtb/wN3KnvwPQXMhPhvGHZeTCrTBQQqlidq7Ih5ksexFfUtIwIwiEZo0pc2wEniq/WI1/WiCFJJMTbESOQaqd/n4Puhzw+vvc3dTNSgeh5u0eMSfn6iyFOc3smt95SX0A52nKKcnuyHCj9D4wXemLmzxqHIYmn+lD1do14DaE6+oeV3k0kLL6DaYmMGOeIbyZ+6rG8GUW73J4DcwJocy7guZL3RIg2PDIm4fIWwY/mBRQqP12ZRiOmQTIWgNWAqrnwqIQ8/ltISK0zCrNCv8WGE3PFVv6LTn5SJhrsOaZxCy4Kk/xcm/HnmbBTcxv4drwezJ6KLVsxZVQs4Av9a7ONYu5pKUkQv1d1IGJt28xFasFKkWyHBU9Wij1LaKInXa9iWfCWOpdBfG2I4hLKXg1/Vb9fa60LaKAWMGAIEAFwGMwLYi6ckna7QaYdtTmACPKB95MVdD2T3E+HGk8xU+N1FframpmaMTzhXHocaGc3QstBJmAp3Kg14pG+Wb3mOaW/jVcak3bNFQgMOx2i3fq8F4gXByzDJaQUh0QPpqqOXOagtu8xwzXOjjZdHKbPmOQ9IOY9oDycwW5Cf+XbtJ9jDGAEkM+KBajdjBxpPYFPFi3J+YdrihJbEovAejsQ36SF/f21uC+4TkNG+x7MW0gAB9rT8pKMYbFGJK3tynoCSt8dIJ/oqV+Je+o5cv/6QYnM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PiA57cs16oJmU8bOkAqzZTvmXncsUUZolR/a8iYxqJLTEOcwiFrnku4XdCr7tEEChtQ54DhW9H8xOGO39xQDojBtrS9OMqaPzprYEt0k40eibjvkfqNwp/OMbkaRgUQglLV4MHMMnMR5jaMCTwX1pX1reUMtiV9Pil/gkyMEvFg18gTxAk0Bi1jihSPZq5mNMvySLxytUGvl87vnDeohnRexMMKvmvNq1zbD/sTVZBFDFn7aptIXSx5N2OxDbqfWOfXcmwPviaYST+2QFxyZitb/TMxhEAZfSh5djkWm/ddt140orcDdgUgIIvDGNvMmj2Q/gzpuFoPhhwCK0qVv2p5oY+Q6luyBrGz3YuIDOv0jlnbR2kujLkB3On0o3bRbvaEA+lBLRXzhvraXuP7ItLG4GnYUUcoaYaVveM/RypN5+j+weYKGguVo9MpNCLp/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:43:57.4805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e42eeb-fbe5-4c85-514f-08decc5d55c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
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

Add IP_VERSION(11,5,1) to pp_dpm_vclk and pp_dpm_dclk visibility
whitelists so these sysfs entries are exposed on Strix Halo (GC
11.5.1). Add IP_VERSION(11,5,1) to pp_dpm_vclk1 and pp_dpm_dclk1
whitelists with the existing num_vcn_inst >= 2 guard since Strix
Halo has two VCN instances.

Without this, amd-smi reports N/A for VCLK0, VCLK1, DCLK0 and
DCLK1 clocks.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index dfebe67c164d..305852f5b153 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2027,6 +2027,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 0, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 4) ||
 		      gc_ver == IP_VERSION(11, 5, 0) ||
+		      gc_ver == IP_VERSION(11, 5, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
 		      amdgpu_is_multi_aid(adev)))
@@ -2035,7 +2036,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
 		       gc_ver == IP_VERSION(10, 3, 0) ||
 		       gc_ver == IP_VERSION(11, 0, 2) ||
-		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+		       gc_ver == IP_VERSION(11, 0, 3) ||
+		       gc_ver == IP_VERSION(11, 5, 1)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2048,6 +2050,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 0, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 4) ||
 		      gc_ver == IP_VERSION(11, 5, 0) ||
+		      gc_ver == IP_VERSION(11, 5, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
 		      amdgpu_is_multi_aid(adev)))
@@ -2056,7 +2059,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
 		       gc_ver == IP_VERSION(10, 3, 0) ||
 		       gc_ver == IP_VERSION(11, 0, 2) ||
-		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+		       gc_ver == IP_VERSION(11, 0, 3) ||
+		       gc_ver == IP_VERSION(11, 5, 1)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
 		if (amdgpu_is_multi_aid(adev))
-- 
2.43.0

