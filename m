Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B030CEE57EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 10:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E540D10E898;
	Fri,  8 Sep 2023 10:40:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D3010E897
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 10:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTfW57AIJRLApvEGUcW1gDAl9poseblDUOpbYRh19Ktx22wES+TfOvX6/jT/RKvBWWqGrhBGCqLRDjl8gSWIOeXuqiwR0S/YEQmA1Bqngerkc4/o08H94KVFHQss9P7fSVevLRgLboUb+NI7dBKM5CsLKx/CdhXxfalyHA2YtN/jv5xfCUgPSpior0keEA3g+zxYhMJf1Um3wvGpMsH9Tx8qgpsHAWWG1lqJ6cEJH/KMn8pcabK0IPNnnhPOd3IYkm7ybVh2epk4hOmSg821CGYZqGd2TvG4qTS6QKcAj1zIhqdfkrfZjE8SIIsZy0am16t8+FwI+WekYxYHwpZoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFpidiIr/ceNYxmMLLll2wQ97D7IGnOEseszcQngAL0=;
 b=eAzR1ry5ggKcC6OvGK6RWgxWim1gcdfHMiYsVwkycAQVZ3GrW1zh2gK7WM/EMLHiihhW6MAz1Fp3heewjqd7m7nYiHJE+ooAV5+DNMl2CtQNQ04gB3qR2nAccJsPk+Z5B4sW/ZiObSpX4e/b9jNk8EzvGDpDjrfc9qsgfQgVf49GU3lSxzpO3x+SGubID+rS84hFk4y5ECZsmFpRJf5O2P2jIgw34eN5FxQRCY8/AjL3E6VwJ2Khh2yMbdFhSzl7VUjingwsO5TheMAAaOs1xXvFFUiROzvvCZ2YsRdUAo7L9QhD9TQLP1cs94UQkSvVDe+9Rmedshj0ureZJa5HjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFpidiIr/ceNYxmMLLll2wQ97D7IGnOEseszcQngAL0=;
 b=U4kFVW4k/XSqAPWJIn/ahyVQ6AcET7PV3PkzG2rUhYNzUjS6xDcB3tn2orc5VnjL1XLM7jYN+OG/ZL37+D6OmujR6papbU2m3+iTYc/KpkIbbVp72fshj+H/Q778V+lRzQ0aEnVmB1bxIZpFazDuQYiZt8j/HfdmvajphNbqK9I=
Received: from DM6PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:100::22)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 10:40:07 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::c7) by DM6PR03CA0045.outlook.office365.com
 (2603:10b6:5:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Fri, 8 Sep 2023 10:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 10:40:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 05:40:00 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Restore partition mode after reset
Date: Fri, 8 Sep 2023 16:09:42 +0530
Message-ID: <20230908103942.995604-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM8PR12MB5414:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b40fe4-2c11-4789-daa8-08dbb057f832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lL2pHf2+4ozXZrEx0AcJU3nLYMrNXNg7BXlQs/QMh8r4ps7I3I5W5IDooM98AN4hbubNXaT2HvpJHfnl9P1gWvxPHU3/10vZnrQEpr/9EEIswIuNQVnoVFp1KN5N0nAOmRh93A0XWkT8+xvL9afpFiJHK8tm80gEyooOJw8PI4QiCZfnILldu4hJtT3Bqwy84zvtsiqdBJ+YNigtGYbSgt+oE3eGTXzLH1BiqSRGJPttuasz3tvzFLbQMOWB7O1G6U22GTsbhjtkSw/NIg9/eSGSrUdECAxxWBFiAbsKzVH0hOciBSVgdsDu802XkVRkVZ5WUt8Mr5AJjoM+kR9W3TccC0KRYuHQ27VMcKLfmEXsI6I4SazT3hKdroQDON1iz6EP84bmUku9Im5f/3uzAPYFbvPd27sOyurttG/X7gSgXO6U1VMDZuPLZ7xLzx8BPIti7/94TGlT1O7P0hoMCtTpbL9dPMDrm1l59+o4RM+U1SA/NGxWffv4Dvp8qmar2v0km+y/mnbaBoNTU0PFGtS22FX+dA6sY+nmyGNfnOO1fl8udtwJ6MkNDnqbmLGCBzwH6lGnYc0aDoowey+o1E8UUbyzi1AsF5g8RCnVWnrIu/4iRiA81pL094zfucmMi5vXDKJRhAJFQXSw6sUjZ50NRB/1BdeFcIPMZLcR7wGpjCi6r253bc1UyK7KB63uOh9xVMhaOiqNM/VwQ/LZXVynhFGgs/kV3LYyPYYgHf2w5J9Yq49XxpFCpF6EYBqXBkLjyhlRSb9kIFVFw+ApIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(6666004)(7696005)(478600001)(1076003)(83380400001)(26005)(2616005)(16526019)(336012)(426003)(2906002)(54906003)(44832011)(41300700001)(6916009)(316002)(70586007)(70206006)(8676002)(5660300002)(8936002)(4326008)(40460700003)(86362001)(40480700001)(82740400003)(47076005)(36860700001)(36756003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:40:07.4689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b40fe4-2c11-4789-daa8-08dbb057f832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On a full device reset, PSP FW gets unloaded. Hence restore the
partition mode by placing a new request.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 28 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  2 +-
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5f32e8d4f3d3..5d2b6a7c5f6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5115,6 +5115,11 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				if (r)
 					return r;
 
+				r = amdgpu_xcp_restore_partition_mode(
+					tmp_adev->xcp_mgr);
+				if (r)
+					goto out;
+
 				r = amdgpu_device_ip_resume_phase2(tmp_adev);
 				if (r)
 					goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 565a1fa436d4..2b99eed5ba19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -163,16 +163,11 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 	return 0;
 }
 
-int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
+static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
+					      int mode)
 {
 	int ret, curr_mode, num_xcps = 0;
 
-	if (!xcp_mgr || mode == AMDGPU_XCP_MODE_NONE)
-		return -EINVAL;
-
-	if (xcp_mgr->mode == mode)
-		return 0;
-
 	if (!xcp_mgr->funcs || !xcp_mgr->funcs->switch_partition_mode)
 		return 0;
 
@@ -201,6 +196,25 @@ int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
 	return ret;
 }
 
+int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
+{
+	if (!xcp_mgr || mode == AMDGPU_XCP_MODE_NONE)
+		return -EINVAL;
+
+	if (xcp_mgr->mode == mode)
+		return 0;
+
+	return __amdgpu_xcp_switch_partition_mode(xcp_mgr, mode);
+}
+
+int amdgpu_xcp_restore_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	if (!xcp_mgr || xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
+		return 0;
+
+	return __amdgpu_xcp_switch_partition_mode(xcp_mgr, xcp_mgr->mode);
+}
+
 int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 {
 	int mode;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 9a1036aeec2a..90138bc5f03d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -129,6 +129,7 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
 int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode);
 int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags);
 int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode);
+int amdgpu_xcp_restore_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr);
 int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
 			     enum AMDGPU_XCP_IP_BLOCK ip, int instance);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index d0fc62784e82..3f715e7fe1a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -500,7 +500,7 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		return -EINVAL;
 	}
 
-	if (adev->kfd.init_complete)
+	if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
 		flags |= AMDGPU_XCP_OPS_KFD;
 
 	if (flags & AMDGPU_XCP_OPS_KFD) {
-- 
2.25.1

