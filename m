Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF504606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UcfLypxI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61EAE10F47D;
	Tue, 27 Oct 2026 12:57:32 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D91610F47D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 12:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ6bdj0oi7BazMrrGVIJDTMJYTuca5f/0uAlZi5f6qLLkFs9+VGSyUXJOhGNakEauft71Pcmn1mShLmjeATqfrm9b1xQY1FnvMcIVKcnD6/lOznFDxhVVGr7+bsEFucQcvSfCkWxhzJNJbCjbO7SkJ7p56rrJAvu01cUjY5o/XOSMtdCtZAdJXn1T+AMe9EtWhNmm9ao7c3fNHhFytjfb//b3tdzoxSQS1efMYdLcPvZMXSTnkYXoabkBQskpixrxqL5ZySZK+OxV7HojYGqzqmoq95IhcQtktfeGy1nFtdGuA05l6ZTcNEVNJ/l6NMLOqDn20d8AXtPvEJC45jqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDJefnIG467lXPrzISL7o+AxP4/vg2N2wQ8cul749yY=;
 b=CG+5FJwoa0fa3bpo3aRui5jj2ZbrxovUiRUox+3XVxdA+m3ljxObffvXRwud+dtxYDUQfWdq9Eu6XKQJho64ipQNYNYHuHyS11ECy6fjr7pQG7QndgPqJ/M/L0G33xlELUidQOQ1+YcNY+vdZ7zkyFSw/ifEmw6kRRZy9dUgitndEgmifcmMvumhBLi0/UAaEuqWSUw2MS4R03s5xP2mgPuvFfZIV2OPfF3X7rBJu08GXZn7g0IDzyf7WE7Op38SbIV+wqbzELHpEbIkRBzDcnfzeXzGMbRa8JCfBTbQTngXaoa7KAWexTlX1aooy4/pc174/FHaEr7NET+tMlLXhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDJefnIG467lXPrzISL7o+AxP4/vg2N2wQ8cul749yY=;
 b=UcfLypxIMla6/OkrJqLwAUYS9hT5e4GWoQtIsVWCUr6ef2YVjIID9ILNOaAXWq+/X2bzpgaktEHqPSntIEl8ocx7L9N6Ftguzfag+tzjaDwIb8+F7QOwN5NE54qul7T+pjwfRt1qvW/JNtOli/ofxbPNd78lKfdYvtMPbgaGp7k=
Received: from PH8P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::12)
 by LV9PR12MB9759.namprd12.prod.outlook.com (2603:10b6:408:2ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:56:50 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::12) by PH8P220CA0026.outlook.office365.com
 (2603:10b6:510:348::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 12:56:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DD.mail.protection.outlook.com (10.167.247.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 12:56:49 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 07:56:41 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Zhigang.Luo@amd.com>, <Gavin.Wan@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: Implement virt CRIT_REGION_V3 init logic
Date: Tue, 27 Oct 2026 08:56:12 -0400
Message-ID: <20261027125613.6549-7-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027125613.6549-1-victor.skvortsov@amd.com>
References: <20261027125613.6549-1-victor.skvortsov@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|LV9PR12MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: ec613ed4-fe7f-4361-d5de-08df3429c445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|261026135527099003|261026140227099003|261026130827099003|11063799006|56012099006|261026121527099003|261021130227099003|261021123027099003|261021135927099003|261021121427099003|261022075727099003|261022113327099003|261022105027099003|261022115727099003|261009223027099003|261021133027099003|10067099003|22082099003|18002099003|6133799003|10063799003;
X-Microsoft-Antispam-Message-Info: OzekDvzR0xpHjArlEdshUe86oa2idptwWOLrccOKos4fO/JTrQu/cZrTPgc1rcO4A5GjUwm4BLgzNbrClZEokPTYce3uzvPojqjG8PemPJd6BCQI2EmgGf1zRYlgxrV/XfxS1fHYSjkTxyWsM0ZftHSBMI+X9I21nN6NU/uDYSXlkXyGWJgm+mbn/0jrhT2/4lHU6/qaTNlwgq7M40Gmgowcpyy5SAIknjprqyKhqdGR2cQcs01t78d6vndAb2VfrI1Utc+a6GqCJN2tn5cpqOY6tfJ7YFJyv8jc7UtQxWXjB0JUZkbuDLzhFSxYdoR3Rbmdn3dxashlx1G8Yooh2hXwd9JT1kQ8af0aBwxY3OmiF0hcJRDu4pnHdFpMVfUM9WV7fY+6UUqX6BTvli8Siwo/GXgXEsWyT3R7vdwsNzkKntbJQ+DxqHboUO20jlM6ccd6NJDg5/RXYYIt3fdLmFsW4q+d9X7LMXeOFAyaEKO8CcqlS5oM5xnXj/Ervq9ByjMF5clBo17J4JTw3bt+3FI5bV68ZJUZOauK0IOPdcVDes3izInpN9nua4gVSK3a7/88Qzhbo0L9aXJMnlpNbpigR3DQel09wK6Q5Elbw4Rz7+bOZ3G6kKLhuYsmcLHi29i4y1yvCft0AFo1pjtBUky5si4vb3/0vZ7A7DukPtCTBb3PX+Gtstmb3sW3vB2wfVc5ZXdh96uJ1LkCREpmeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(261026135527099003)(261026140227099003)(261026130827099003)(11063799006)(56012099006)(261026121527099003)(261021130227099003)(261021123027099003)(261021135927099003)(261021121427099003)(261022075727099003)(261022113327099003)(261022105027099003)(261022115727099003)(261009223027099003)(261021133027099003)(10067099003)(22082099003)(18002099003)(6133799003)(10063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AI1QwauJh/fnTyLpOvclBTBNU6Zppz/0Fbl9v4Y76HzXdoaUdp73Q5yViIz/8k7Y8dppUsXSWfNmkYNClpVa0Sz9WiDNPAl4l6wcLoi34qBGgzYL6vhlpYO2aIT24ZlI4+KGuCBcojzGhKWorw8qO1P4l7v9+tG+UdAgjW8NmRKQLgJ/wvyId4mR9N+2kAkG7WCq1U2yVQUaeodHBGEWd7RvKAcpFi3djvt0Y1SLMGoNM3RLtCWkv4W/jUdFZcGQpD8/+GGTLIPe5vvCPdLRiSl6rOCoHEklPZFvFl4DNgTTbq83jODA/ePCkd+z8KdKE4J1yHWZ7huRaDl55jziEVwsg3vso/MReNId3VJQAJLovMJg/hp7vjhqYRHjcpo+PTlb7XzQXbCjFvN7XiEJfzCKXGp5RaQIhFCTUcrWcLUXvB+H8CerZY+XcLVsCh+G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 12:56:49.9719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec613ed4-fe7f-4361-d5de-08df3429c445
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9759
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In V3, the guest chooses the exchange region location.
In current design, choose offset 0x0. When TTM is not yet
initialized, memremap must be used to access the xchg region.
This is required to fetch IP Discovery and vf register
access flags during early init.

The general VF init sequence is as follows:

1) VF sends REQ_GPU_INIT_DATA message:
- CRIT_V2: Host ungates VF FB access dumps init tables to guest VRAM.
- CRIT_V3: Host ungates VF FB access.

2) VF sends REQ_GPU_INIT_XCHG_REGION:
- CRIT_V2: NOP
- CRIT_V3: Host setups up GPA -> SPA translations and dumps init tables into SPM.

3) VF Enters full access:
- CRIT_V2: Host ungates VF MMIO, guest reads init tables from VRAM
  using mmINDEX/mmDATA pair registers.
- CRIT_V3: Host ungates VF MMIO, guest reads init tables from SPM
  using memremap().

Step #2 should be done outside of full access as PF may need additional time
for GPA->SPA translation and bad page lookups. This will be noticable
on multiVF + temporal world switch configs.

Step #3 must be done inside full access. VF MMIO read/writes are not
guaranteed outside of full access (runtime register reads go through KIQ).

Move VRAM check to CRIT_V2 specific init as V3 might not have any VRAM.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  19 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  14 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c | 118 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  29 +++++
 5 files changed, 151 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9fb4bea31a2e..6731059d6c32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -416,16 +416,17 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 {
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_xchg_access(adev, adev->discovery.offset,
+					binary, adev->discovery.size, false);
+		return ret;
+	}
+
 	if (!is_tmr_in_sysmem) {
-		if (amdgpu_sriov_vf(adev) &&
-		    amdgpu_sriov_xgmi_connected_to_cpu(adev)) {
-			ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
-		} else {
-			amdgpu_device_vram_access(adev, adev->discovery.offset,
-						  (uint32_t *)binary,
-						  adev->discovery.size, false);
-			adev->discovery.reserve_tmr = true;
-		}
+		amdgpu_device_vram_access(adev, adev->discovery.offset,
+					  (uint32_t *)binary,
+					  adev->discovery.size, false);
+		adev->discovery.reserve_tmr = true;
 	} else {
 		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 301b41f5787e..bd912685473f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -147,6 +147,16 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
 		virt->ops->req_init_data(adev);
 }
 
+int amdgpu_virt_xchg_request_init_region(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+
+	if (virt->ops && virt->ops->req_init_xchg_region)
+		return virt->ops->req_init_xchg_region(adev);
+
+	return -EOPNOTSUPP;
+}
+
 /**
  * amdgpu_virt_ready_to_reset() - send ready to reset to host
  * @adev:	amdgpu device.
@@ -587,8 +597,10 @@ void amdgpu_virt_init(struct amdgpu_device *adev)
 
 	is_sriov = amdgpu_virt_init_req_data(adev, reg);
 
-	if (is_sriov)
+	if (is_sriov) {
+		amdgpu_virt_xchg_notify_region(adev);
 		amdgpu_virt_init_ras(adev);
+	}
 }
 
 static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index f664186c6a48..1836fd95763d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -117,6 +117,7 @@ struct amdgpu_virt_ops {
 	int (*req_ras_chk_criti)(struct amdgpu_device *adev, u64 addr);
 	int (*req_remote_ras_cmd)(struct amdgpu_device *adev,
 			u32 param1, u32 param2, u32 param3);
+	int (*req_init_xchg_region)(struct amdgpu_device *adev);
 	int (*req_ptl_update)(struct amdgpu_device *adev,
 			u32 req_code, u32 ptl_state, u32 fmt1, u32 fmt2);
 };
@@ -297,6 +298,7 @@ struct amdgpu_virt_xchg {
 	struct amdgpu_virt_xchg_region header;
 	struct amdgpu_virt_xchg_region tbl[AMD_SRIOV_MSG_MAX_TABLE_ID];
 	bool dynamic;
+	bool sysmem;
 
 
 	struct amd_sriov_msg_pf2vf_info_header *p_pf2vf;
@@ -521,6 +523,7 @@ void amdgpu_virt_request_bad_pages(struct amdgpu_device *adev);
 int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev, u64 addr, bool *hit);
 int amdgpu_virt_send_remote_ras_cmd(struct amdgpu_device *adev,
 		uint64_t buf, uint32_t buf_len);
+int amdgpu_virt_xchg_request_init_region(struct amdgpu_device *adev);
 bool amdgpu_virt_ras_check_bad_page(struct amdgpu_device *adev, uint64_t retired_page);
 void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev);
 bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev, const struct eeprom_table_record *bps, int pages);
@@ -530,8 +533,11 @@ int amdgpu_virt_xchg_tbl_info(struct amdgpu_device *adev,
 			       uint64_t *offset, uint32_t *size);
 int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev, int data_id,
 				      uint8_t *binary, u32 *size);
+void amdgpu_virt_xchg_access(struct amdgpu_device *adev, uint64_t offset,
+			      void *buf, size_t size, bool write);
 void amdgpu_virt_read_pf2vf_data_early(struct amdgpu_device *adev);
 int amdgpu_virt_exchange_data(struct amdgpu_device *adev);
+int amdgpu_virt_xchg_notify_region(struct amdgpu_device *adev);
 int amdgpu_virt_xchg_init(struct amdgpu_device *adev);
 int amdgpu_virt_xchg_start_work(struct amdgpu_device *adev);
 void amdgpu_virt_xchg_stop_work(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
index 9f34bc1b468d..3c89f1f70177 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
@@ -44,6 +44,27 @@ const char *amdgpu_virt_table_name[] = {
 	"LAST",
 };
 
+void amdgpu_virt_xchg_access(struct amdgpu_device *adev,
+				     uint64_t offset, void *buf,
+				     size_t size, bool write)
+{
+	if (adev->virt.xchg.sysmem) {
+		void *vaddr = memremap(adev->virt.xchg.pa + offset, size, MEMREMAP_WC);
+
+		if (!vaddr) {
+			dev_err(adev->dev, "memremap failed for xchg offset 0x%llx\n", offset);
+			return;
+		}
+		if (write)
+			memcpy(vaddr, buf, size);
+		else
+			memcpy(buf, vaddr, size);
+		memunmap(vaddr);
+	} else {
+		amdgpu_device_vram_access(adev, offset, buf, size, write);
+	}
+}
+
 static uint8_t amdgpu_virt_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
 {
 	uint32_t sum = 0;
@@ -94,6 +115,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		adev->virt.gim_feature = pf2vf_v1->feature_flags;
 		break;
 	case 2:
+	case 3:
 		/* TODO: missing key, need to add it later */
 		pf2vf = (struct amd_sriov_msg_pf2vf_info *)pf2vf_info;
 		checksum = pf2vf->checksum;
@@ -323,6 +345,7 @@ void amdgpu_virt_read_pf2vf_data_early(struct amdgpu_device *adev)
 
 	switch (adev->virt.xchg.req_init_data_ver) {
 	case GPU_CRIT_REGION_V2:
+	case GPU_CRIT_REGION_V3:
 		/*
 		 * This one time pass is expected only one time, before TTM has made
 		 * xchg reservations. Use a temporary buffer to get pf2vf data needed for init.
@@ -391,6 +414,7 @@ static int amdgpu_virt_xchg_set_data_table_va(struct amdgpu_device *adev)
 
 	switch (adev->virt.xchg.req_init_data_ver) {
 	case GPU_CRIT_REGION_V2:
+	case GPU_CRIT_REGION_V3:
 		adev->virt.xchg.p_pf2vf =
 			(struct amd_sriov_msg_pf2vf_info_header *)
 			(adev->virt.xchg.va +
@@ -455,39 +479,55 @@ int amdgpu_virt_xchg_start_work(struct amdgpu_device *adev)
 	return r;
 }
 
+static int amdgpu_virt_xchg_notify_region_v3(struct amdgpu_device *adev)
+{
+	uint64_t size;
+	int r;
+
+	r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &adev->virt.xchg.pa, &size);
+	if (r)
+		return r;
+
+	if (adev->virt.xchg.size > size) {
+		dev_err(adev->dev, "Host requests invalid CRIT_REGION_V3 size");
+		return -EINVAL;
+	}
+
+	adev->virt.xchg.offset = 0;
+
+	r = amdgpu_virt_xchg_request_init_region(adev);
+	if (r)
+		return r;
+
+	return r;
+}
+
+int amdgpu_virt_xchg_notify_region(struct amdgpu_device *adev)
+{
+	switch (adev->virt.xchg.req_init_data_ver) {
+	/* Guest must pass the exchange region location. */
+	case GPU_CRIT_REGION_V3:
+		return amdgpu_virt_xchg_notify_region_v3(adev);
+	default:
+		return 0;
+	}
+}
+
 static int amdgpu_virt_xchg_init_tables(struct amdgpu_device *adev)
 {
 	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
 	u64 init_hdr_offset = adev->virt.xchg.header.offset;
 	u64 init_hdr_size = sizeof(struct amd_sriov_msg_init_data_header);
-	u64 vram_size;
-	u64 end;
 	int r = 0;
 	uint8_t checksum = 0;
 
-	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
-	/* Fall back to RCC_HW_DEBUG when RCC_CONFIG_MEMSIZE reads 0 on a VF. */
-	if (!vram_size)
-		vram_size = RREG32(mmRCC_HW_DEBUG);
-	if (!vram_size || vram_size == U32_MAX)
-		return -EINVAL;
-	vram_size <<= 20;
-
-	if (check_add_overflow(init_hdr_offset, init_hdr_size, &end) || end > vram_size) {
-		dev_err(adev->dev, "init_data_header exceeds VRAM size, exiting\n");
-		return -EINVAL;
-	}
-
 	/* Allocate for init_data_hdr */
 	init_data_hdr = kzalloc(init_hdr_size, GFP_KERNEL);
 	if (!init_data_hdr)
 		return -ENOMEM;
 
-	amdgpu_device_vram_access(adev,
-				  (uint64_t)init_hdr_offset,
-				  (uint32_t *)init_data_hdr,
-				  init_hdr_size,
-				  false);
+	amdgpu_virt_xchg_access(adev, init_hdr_offset, init_data_hdr,
+				init_hdr_size, false);
 
 	/* Table validation */
 	if (strncmp(init_data_hdr->signature,
@@ -613,9 +653,35 @@ static int amdgpu_virt_xchg_init_tables(struct amdgpu_device *adev)
 }
 
 static int amdgpu_virt_xchg_init_crit_region_v2(struct amdgpu_device *adev)
+{
+	int r;
+	u64 vram_size, end;
+
+	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
+	/* Fall back to RCC_HW_DEBUG when RCC_CONFIG_MEMSIZE reads 0 on a VF. */
+	if (!vram_size)
+		vram_size = RREG32(mmRCC_HW_DEBUG);
+	if (!vram_size || vram_size == U32_MAX)
+		return -EINVAL;
+	vram_size <<= 20;
+
+	if (check_add_overflow(adev->virt.xchg.header.offset,
+			       sizeof(struct amd_sriov_msg_init_data_header), &end)
+			       || end > vram_size) {
+		dev_err(adev->dev, "init_data_header exceeds VRAM size, exiting\n");
+		return -EINVAL;
+	}
+
+	r = amdgpu_virt_xchg_init_tables(adev);
+
+	return r;
+}
+
+static int amdgpu_virt_xchg_init_crit_region_v3(struct amdgpu_device *adev)
 {
 	int r;
 
+	adev->virt.xchg.sysmem = true;
 	r = amdgpu_virt_xchg_init_tables(adev);
 
 	return r;
@@ -630,6 +696,12 @@ int amdgpu_virt_xchg_init(struct amdgpu_device *adev)
 	 */
 	case GPU_CRIT_REGION_V2:
 		return amdgpu_virt_xchg_init_crit_region_v2(adev);
+	/*
+	 * Guest assigned static exchange region location by mailbox.
+	 * Host assigned dynamic table locations.
+	 */
+	case GPU_CRIT_REGION_V3:
+		return amdgpu_virt_xchg_init_crit_region_v3(adev);
 	/*
 	 * Host assigned static exchange region location by mailbox.
 	 * Host assigned static table locations.
@@ -657,11 +729,7 @@ int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 	if (!binary || !size || *size < (uint64_t)data_size)
 		return -EINVAL;
 
-	amdgpu_device_vram_access(adev,
-				  (uint64_t)data_offset,
-				  (uint32_t *)binary,
-				  data_size,
-				  false);
+	amdgpu_virt_xchg_access(adev, data_offset, binary, data_size, false);
 
 	*size = (uint64_t)data_size;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index e7d664b2c99e..5ae18c2d71d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -198,6 +198,9 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 	case IDH_REQ_GPU_INIT_DATA:
 		event = IDH_REQ_GPU_INIT_DATA_READY;
 		break;
+	case IDH_REQ_GPU_INIT_XCHG_REGION:
+		event = IDH_REQ_GPU_INIT_XCHG_REGION_READY;
+		break;
 	case IDH_RAS_POISON:
 		if (data1 != 0)
 			event = IDH_RAS_POISON_READY;
@@ -240,6 +243,10 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 					adev->virt.xchg.header.offset = RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
 					adev->virt.xchg.header.size_kb = RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW3);
 					break;
+				case GPU_CRIT_REGION_V3:
+					adev->virt.xchg.req_init_data_ver = GPU_CRIT_REGION_V3;
+					adev->virt.xchg.size = RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
+					break;
 				default:
 					adev->virt.xchg.req_init_data_ver = GPU_CRIT_REGION_V1;
 					adev->virt.xchg.header.offset = -1;
@@ -247,6 +254,18 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 					break;
 				}
 			}
+			if (req == IDH_REQ_GPU_INIT_XCHG_REGION) {
+				switch (RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1)) {
+				case GPU_CRIT_REGION_V3:
+					adev->virt.xchg.header.offset =
+						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
+					adev->virt.xchg.header.size_kb =
+						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW3);
+					break;
+				default:
+					break;
+				}
+			}
 		}
 
 		/* Retrieve checksum from mailbox2 */
@@ -327,6 +346,15 @@ static int xgpu_nv_request_init_data(struct amdgpu_device *adev)
 			0, GPU_CRIT_REGION_V2, 0);
 }
 
+static int xgpu_nv_request_init_xchg_region(struct amdgpu_device *adev)
+{
+	return xgpu_nv_send_access_requests_with_param(adev,
+						       IDH_REQ_GPU_INIT_XCHG_REGION,
+						       upper_32_bits(adev->virt.xchg.pa),
+						       lower_32_bits(adev->virt.xchg.pa),
+						       adev->virt.xchg.size);
+}
+
 static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					struct amdgpu_iv_entry *entry)
@@ -626,6 +654,7 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
 	.req_init_data  = xgpu_nv_request_init_data,
+	.req_init_xchg_region = xgpu_nv_request_init_xchg_region,
 	.reset_gpu = xgpu_nv_request_reset,
 	.ready_to_reset = xgpu_nv_ready_to_reset,
 	.wait_reset = xgpu_nv_wait_reset,
-- 
2.34.1

