Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482F9C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 16:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDDBD10E635;
	Tue,  4 Mar 2025 16:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kQHhN2Mh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B7DE10E646
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 16:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7dB5TcCYmmD/zlncLk8K/3UIWNRbIKHj7oGYz9T8QsCh6PDPjTAnzz7YQm/c1KS6tSmF7lY46RoLL7IFj57ZyZvVSgy0I1NmuaTkD2ryIPxNnSwAsOy7VvzX4Z2YvZv7eQEXZEo7kQF8gMrOtu+OQMYzkoVxad59fokwdJL3ShJVaSed3EGYEmCY/2AuF9FOtG/nPvHJRb4WEgTOATpyyGj1KDtQrg3zogw1PCA+lSHEOWUUpwVBqyjb2feHKbYnPMkDKwd/Imf0aKWiSh7he/EJDNbGmmO36akm/hXEZDzbGUChXbbRx5oXVKv/sd785UAB1ytVe+ZXPH+I0a57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib8HN2/UqErmQ45aSKM3RV78VdR2ypm2SFEYJxcEG/M=;
 b=ne6bftx8JRUhYmq5UUhLA+SQskEJy2WgfwJsm+bEiWdwbDfKSKOvR6rHWzlf7Y1LVoNuNrQTLhBwTsiPe0w0GcIFzgLrE1lkp3BiMK+fE8tZnbDoT4KtZflStfr0FjwrdNG3/iqoBgf2WjNTF2s6pHXZ/Xf5mKkxVhcdRWYmWYyx6/kUJ2uQyB4g9cnsSdGFYZVMuWenkd9fP06/br2a1CnZ2yXlYLwl449p85PkHIbhSUnSxaPBjPYQYdQz1DyrjB48H0RUltLOZjRm0YBWJi6TZ34mbypuObXCyzKW5scBKSTfk5FoOzTVc108Obk4hiflXmtDhnmzVWhsNDQdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib8HN2/UqErmQ45aSKM3RV78VdR2ypm2SFEYJxcEG/M=;
 b=kQHhN2MhrAtkb8XUh3LN9/kKEFyTmd3QtyBfJJz8S2FKk5aEN6GmPmByV+FUFFEmb+fvhGk9r8KWif5Gj7QrouZfhaGYixsa+YnhGNF+lZye2EFG/gX5DiDX9/so3TtzLsvzeYjrg2kjl4V6HXw6pPnBHEKFaXL7QqbNxBTp5E4=
Received: from SJ0PR05CA0161.namprd05.prod.outlook.com (2603:10b6:a03:339::16)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 16:22:57 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::ee) by SJ0PR05CA0161.outlook.office365.com
 (2603:10b6:a03:339::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Tue,
 4 Mar 2025 16:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 16:22:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 10:22:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: fix idle work handler for VCN 2.5
Date: Tue, 4 Mar 2025 11:22:42 -0500
Message-ID: <20250304162242.4029795-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f35da5e-0821-4b72-3049-08dd5b38d257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D01Gc8ScPWGPVu4h/mip0++6M2XiMHd2+nfXuXn4qp5h5YnImVnZsMYNO7hY?=
 =?us-ascii?Q?SJ2VSUUz3sfge8IJ+heXdpk6ciQGPRbEE00EgmDEsg15iBDli2p9tEdwd28z?=
 =?us-ascii?Q?PWVXWtC5GkEMEKVyfuKs/3tVqfjlkZoFVI/cMd+svmS+Gzrg+NYotUfzRhhF?=
 =?us-ascii?Q?EsJCMuS88H96V83ci56Ex8Z8HDQEs+ml2WEqyT8E8+Vl0oLS26kM0HXAO+Li?=
 =?us-ascii?Q?Vjk7jxxKlRP89E7mhcHKStduPNYdwn3jcLsqPGKgCVvoRkKxdJd13Qv8iQ56?=
 =?us-ascii?Q?iTjoMtDlSl3jLaczAIpkSKrM9scso5mzJ8WNmsM4J87m3jk4Hdm592Ed65UT?=
 =?us-ascii?Q?o6hZo6GgjW3BJMVAux6CakaZqnGllf4+Dr5+HcyPTdEoiLicgc5lbCkGZyuW?=
 =?us-ascii?Q?n+B7VPGMN0/zAfeG26h6lHJjduBIPMss8ApMi18+sR7YKdCvQoCk8GuwQr62?=
 =?us-ascii?Q?c0hBlrHtR+irSr41+V3p+cC14zoyT8612RhRdzSH1IpAj5g7ifzW795LNaCp?=
 =?us-ascii?Q?2Z24hwTqH6n8qxHAl1rSrn6y8ERoqMdkU9uywCU5ldaNEBzgyyrYI3LIBP+7?=
 =?us-ascii?Q?Cfe7wMXEg87PsbFAIp0j092d+up/OTqldY85n1Tfb1DLiqNKKVN1fk3S96b5?=
 =?us-ascii?Q?aGYTLH2SDBb07Y5VkWhxSW99/sc/1Ycw/GqRx9ymrUtOQPEOQug136W/eZd1?=
 =?us-ascii?Q?V4hB5EA6PXztkPXBkXT27THvt+8JY3Ehx4knGUacN+/Mw2J1m818Nv/FiZ2t?=
 =?us-ascii?Q?/vPpGBhffy7ovwBvk7eufTC/YrXl+GHExOq9zqH9jHVwzmEPi4x0Msro1PYp?=
 =?us-ascii?Q?8fgyyJmT3PMZ76nBvbb5eoqmqSm7Ot6wxfFm/IG2WvVc7sODJ5flzYMR7/x/?=
 =?us-ascii?Q?/vbmMvf4m2qGluj5fITh7/3pGsRViyFyOMl4SBlw3dMK2U79by9uVEqPdMqu?=
 =?us-ascii?Q?HxtU4gK1iXHVgnFDsriRnMWZIUnJJ4AMFHUWCa46jSVZivfm7KXF9X2LI/Yh?=
 =?us-ascii?Q?rbf4SpSbzPyFEg+HjsEEuCiAS89UM23EmCye+skjpXBvj4wd/gOHftyf2XnF?=
 =?us-ascii?Q?+v/RhEI4Mg/ljThxCdesWHKkAVBDC6342HR5EuySEu0om2UGxg2GhaCKY2na?=
 =?us-ascii?Q?5pL1M+LRRjb0MKkKOFgeDmzYK4v6/c0QVbvco8SDppmyK3A7WbGM0orTKbUl?=
 =?us-ascii?Q?HbmbpCIDB8zmN0exd5KDJuiHERzoknM6t1lX83x1VTiqeegmGnql4xDgMLjZ?=
 =?us-ascii?Q?VqGqArjFRhcNLjT/86WS3wn4dO1SxsKhfc6XzWZ7a7SNSDPY6tpENUqK+9h3?=
 =?us-ascii?Q?g0CHO38PuK+KiRsCzsjhw78SIhRQxlmDd7t+iKM6KIe3ufi/nd1wNopWFcAF?=
 =?us-ascii?Q?5n4TG5ZbeQnIrzPjJlyjRFLRfyTrcqVikgrXp2d51gwcm68lqwj32D/Dhy0c?=
 =?us-ascii?Q?kmMqP1gfp7N8cVRonhum/eXCDtNgVL5FCWSFBNFo/coKAVDPiq5F6Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:22:56.0141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f35da5e-0821-4b72-3049-08dd5b38d257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726
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

VCN 2.5 uses the PG callback to enable VCN DPM which is
a global state.  As such, we need to make sure all instances
are in the same state.

v2: switch to a ref count (Lijo)

Fixes: 4ce4fe27205c ("drm/amdgpu/vcn: use per instance callbacks for idle work handler")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 41 +++++++++++++++++++------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 26c9c2d90f455..3bc4fe4aeb481 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -358,6 +358,10 @@ struct amdgpu_vcn {
 
 	bool			per_inst_fw;
 	unsigned		fw_version;
+	/* VCN 2.5 global PG handling */
+	struct mutex		global_pg_lock;
+	unsigned int		global_pg_count;
+	enum amd_powergating_state global_pg_state;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index dff1a88590363..972f0842ea47b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -172,6 +172,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	uint32_t *ptr;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	mutex_init(&adev->vcn.global_pg_lock);
+
 	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
 		volatile struct amdgpu_fw_shared *fw_shared;
 
@@ -1853,21 +1855,42 @@ static int vcn_v2_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = vinst->adev;
-	int ret;
+	struct amdgpu_vcn_inst *v;
+	int ret = 0, i;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (state == vinst->cur_state)
-		return 0;
+	mutex_lock(&adev->vcn.global_pg_lock);
+	if (state == AMD_PG_STATE_GATE) {
+		if (adev->vcn.global_pg_count == 0)
+			goto unlock;
+		adev->vcn.global_pg_count--;
+		if (adev->vcn.global_pg_count == 0 &&
+		    adev->vcn.global_pg_state == AMD_PG_STATE_UNGATE) {
+			for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+				v = &adev->vcn.inst[i];
+
+				ret = vcn_v2_5_stop(v);
+			}
+			adev->vcn.global_pg_state = AMD_PG_STATE_GATE;
+		}
+	} else {
+		if (adev->vcn.global_pg_count == 0 &&
+		    adev->vcn.global_pg_state == AMD_PG_STATE_GATE) {
+			for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+				v = &adev->vcn.inst[i];
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_5_stop(vinst);
-	else
-		ret = vcn_v2_5_start(vinst);
+				ret = vcn_v2_5_start(v);
+			}
+			adev->vcn.global_pg_state = AMD_PG_STATE_UNGATE;
+		}
+		adev->vcn.global_pg_count++;
+	}
 
-	if (!ret)
-		vinst->cur_state = state;
+unlock:
+	vinst->cur_state = state;
+	mutex_unlock(&adev->vcn.global_pg_lock);
 
 	return ret;
 }
-- 
2.48.1

