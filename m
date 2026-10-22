Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C450606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 01:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VET1ZJVn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58B071122C7;
	Thu, 22 Oct 2026 01:48:02 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9474C1122C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 01:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/VaxBRyvX3sye3jRPcIKuFYhkPOzeVik/Dm/Qg78i1DXZBlki+2b5/FWKrn8QTTivtpqV3Dhtp6NYzqUpdoAFSsqbP88JEX6EBA6ceLmvhp2qml6FnMdXEEtHv/aMK2DICqq3lyAUarBQMoX4QCPbtf6VrYGVsg0eJG9oVbKxAENJJfQLBIxUGIS4V/t3D2xHZNReD7OBWA/oFVwq6jnvgHur1FZAPFZwcsRF2HL7p/qJieexrNoHPEXjSrS01CDupKhnQTM1p3u13/aRX9vkJr6O8DwxdN8YxIEYLepRphhOylnobFx6FuntOKQNTPzQ5oIhiMBOqqumNLUPpDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7X3C0S2imogpAy52VO/5uOek+aQislNsdT2SpLEygOA=;
 b=HQlL/IKIDoh/YzcwmkKKYjiW4MOUV5pc9HQyY588wy6Sh30ebWAQJImvPLzvErWTT55Tu1dghBKIkGPhbmmR16xCKbIDq+a7N8hL3RfM4gBlGOtOwrN4fMsFPnTylYFnI4PpfVTe7KqBXF3orCmmfAq6yKuFRcskR5XG+SCp6l6AuT9kcti/ABx/hRKKFvMs0Sn2hdC/UZCKu0Gt9a8zqi7Fsm9SkEdAugVfJZlEHjRvv2b5jMFYSoFmL3aQU1NzGm3A/+Z8iW4NsQqkiBO/r/afVR9dHIkGTEcQJQxtb6FVLHN6O7/EM2zD8eY+tc6PpHTUgiRusiG4fNzI3zRU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7X3C0S2imogpAy52VO/5uOek+aQislNsdT2SpLEygOA=;
 b=VET1ZJVnRCDw4SoxoXWMy/7g0CWikrhdbHLWVHzQwgqvvoVDND2CBVcV9iBUGdkXXsVkDXVOJ5ByF43utdGlPhl4ZDYcAKFEDbLRRDdel+wQwcvujAJ7ND9QMsxcNs/KEMcizIGFXfxK2dbB90ykuMT+Jhv86nMwJ2DSqTJsKrc=
Received: from DS0PR17CA0019.namprd17.prod.outlook.com (2603:10b6:8:191::8) by
 PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Thu, 22 Oct 2026 01:47:52 +0000
Received: from DM3PEPF000265BF.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::42) by DS0PR17CA0019.outlook.office365.com
 (2603:10b6:8:191::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 22 Oct 2026 01:47:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BF.mail.protection.outlook.com (10.167.23.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 01:47:51 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 20:47:49 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, <alexander.deucher@amd.com>, Amber Lin
 <amber.lin@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Correct hung queue number for reset
Date: Wed, 21 Oct 2026 21:47:23 -0400
Message-ID: <20261022014728.84081-4-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022014728.84081-1-amber.lin@amd.com>
References: <20261022014728.84081-1-amber.lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BF:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a775441-65f0-4275-85e0-08df2fde7b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|261021123027099003|56012099006|11063799006|261009223027099003|22082099003|10067099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: z5CcmM0h1K0D/21d5PkInij+FuDY5RPd3pX7BClwAXlREVULDq2z8DMombuBocN3ReklNk1zJIZo9g544pmXZKmt8twZVIZYIFgr9zZp45gBQNZ/QtuEDrntm9CF+9U3kAgmU2jjBKduQigwt7HPyXZYYeHXEQWKfP8ZDtKQMd5s/soLglJRwECulVTrpxKs8MRes7cdQB2qGJW1Nh7HamOz6Y2TDbSQjKoqyUXa2NsP12I6RaYToVKSzIW6td8pV6ESEpLrAHcxfmmQGugH6X4BYF3IhwoHtYtHm5HDieMGF5zVazk8r+KmCeqDCca+0z5mO9Cy0lqbR5me1ByhXK0Q3OiiBkc0IFt2trd/roET7voPgIr6j+GQvT3Csn+u/ZKXiFHUWAGMld6dEbsuw1WzXE5zx/gwr0y2cPzMw1fuUt2+bBkK6xNSwwZrxVFwri8fLSnU7Fh5G1o7fKmyy2ug6jsQBk1uqbQOYqw5HkBxksLE1cPhbOFOXNil+3cud4fOEWjVvR9cOyyCw3Fje5iYCwN6K9OVv5aK6fseE4vTYrtrVYtTw0NRF5Ua/NJOlfRSlDxAjoteZfn2k4y2Aprws6CR859BtTEMVWoHHEKlmXDBIxw7d2kfjKCu9qwDjcbOYAykUdpOgfsrk5Q3Af389Cp8bPkdXo9lyXnC2VmTWOyggKjBFnxwGyAPbV4MncozYZosnTaXyFSTP3MY5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(261021123027099003)(56012099006)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5s0XzU+EVTW1oqh9nFhFxxMiz86guPN2SLc1sQjqUbSAdADypl9mC3dJhB6o8JsazHgxvRZlFaGCg4mTQxGXm0uC9dmp/9Kk9dGC6oN5qgGUQsWUZd4UFsd+Kp6NX5+aJ9/7hpEbil7VBTgyZDxK85lVyB2tyBGWxiZafP0TZsXuQozo1rN2ILziS6upEKgtBwY0B1QTzZO27wJAmVM+8pTxkzYD4g2ENxPiwL9lvVFoxneuwNIM98lE6piINVk1OQ55oDJJQX77mO0mYifmp+hkcDcHjQHHWbuXEQslgdnx+W/nKi+CMOfeNOyP0k+76B/1qOCtTBeY2EOGjzkAOXu0HgNJjWGoLxPunTENCMnYa86MFd7wd342SJqtSWnd7gLBusdhS+0M9PVoVWEDpeBG4PAiqpfC7v9RCiTygihjVZdBA6joWdFJlMDDi4vF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 01:47:51.2370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a775441-65f0-4275-85e0-08df2fde7b9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In an ASIC supporting multi-compute partition, the number of queues
varies with the compute partition mode. We need to adjust the hqd_info
offset to get the correct hung queues doorbell offset and hqd_info.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 54 +++++++++++++++++--------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 58766b27e150..5bcab09b15c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -108,6 +108,24 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe,
 
 static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work);
 
+static int get_num_queues_per_xcp(struct amdgpu_device *adev, int num_xcps)
+{
+	int i, num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+	u32 num_queues = 0;
+
+	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
+		num_queues += hweight32(adev->mes.gfx_hqd_mask[i]);
+
+	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
+		num_queues += hweight32(adev->mes.compute_hqd_mask[i]);
+
+	num_xcc /= num_xcps;
+	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
+		num_queues += hweight32(adev->mes.sdma_hqd_mask[i]) * num_xcc;
+
+	return num_queues;
+}
+
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
 	int i, r, num_pipes, num_queues = 0;
@@ -222,21 +240,18 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		goto error_doorbell;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
-		/* When queue/pipe reset is done in MES instead of in the
-		 * driver, MES passes hung queues information to the driver in
-		 * hung_queue_hqd_info. Calculate required space to store this
-		 * information.
+		/* When queue/pipe reset is handled by MES instead of by the
+		 * driver, driver provides the buffer for MES to store the hung
+		 * queues information. Calculate required buffer size, which is
+		 * the number of maximum queues. This number varies with compute
+		 * partition mode. We allocate the biggest size, which is SPX,
+		 * num_xcps = 1.
 		 */
-		for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
-			num_queues += hweight32(adev->mes.gfx_hqd_mask[i]);
-
-		for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
-			num_queues += hweight32(adev->mes.compute_hqd_mask[i]);
-
-		for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
-			num_queues += hweight32(adev->mes.sdma_hqd_mask[i]) * num_xcc;
-
+		num_queues = get_num_queues_per_xcp(adev, 1);
 		adev->mes.hung_queue_hqd_info_offset = num_queues;
+		/* Double num_queues. The first half is to store doorbell offset
+		 * and the second half is to store hqd_info.
+		 */
 		adev->mes.hung_queue_db_array_size = num_queues * 2;
 	}
 
@@ -526,8 +541,9 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 					    uint32_t xcc_id)
 {
 	struct mes_detect_and_reset_queue_input input;
-	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
-	int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
+	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[0];
+	int hqd_info_offset, r, i;
+	int num_xcps = 1;
 
 	if (!hung_db_num || !hung_db_array)
 		return -EINVAL;
@@ -537,8 +553,12 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 	    (queue_type != AMDGPU_RING_TYPE_SDMA))
 		return -EINVAL;
 
+	if (adev->xcp_mgr)
+		num_xcps = adev->xcp_mgr->num_xcps;
+	hqd_info_offset = get_num_queues_per_xcp(adev, num_xcps);
+
 	/* Clear the doorbell array before detection */
-	memset(adev->mes.hung_queue_db_array_cpu_addr[xcc_id], AMDGPU_MES_INVALID_DB_OFFSET,
+	memset(adev->mes.hung_queue_db_array_cpu_addr[0], AMDGPU_MES_INVALID_DB_OFFSET,
 		adev->mes.hung_queue_db_array_size * sizeof(u32));
 	input.queue_type = queue_type;
 	input.detect_only = detect_only;
@@ -554,7 +574,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 
 	*hung_db_num = 0;
 	/* MES passes hung queues' doorbell to driver */
-	for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
+	for (i = 0; i < hqd_info_offset; i++) {
 		/* Finding hung queues where db_array[i] is a valid doorbell */
 		if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
 			dev_dbg(adev->dev, "MES: hung queue doorbell 0x%x\n", db_array[i]);
-- 
2.43.0

