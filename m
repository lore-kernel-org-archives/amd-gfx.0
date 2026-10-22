Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FB606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FyK/AMMl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9523A10E44A;
	Thu, 22 Oct 2026 15:32:16 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E76710E44A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 15:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWWBX4DQi6bpJUKBSbvbsBSWZ+4LpxuhCCxktVxwRB6UDWqdZk3ik5z02ZlVu+GE/9Ce6LxVUSOvS+iVJEQWs1iSz/Vx2DAp991Fk81MPM/LlinPJjIiFGC2ELPs2V0v2L65P7XvpqjBo+brspks+S51d90XxpaUsxnp+3sfmRs1wiNpRnWeKvk9g4NsoD8qh0GrWrXLWIdB/xdbhjb8JVNXRzihRiNq9PrkhZWM4yJbFiaA/fqKxNNH1fg4qFWS2R0yQShAixZHncElrig8n/HxcwJ2QRuLjSYwVH6/iCbOW26wp/c0B9BN1+BEBvqM/Im5sUiRDTF6VXhy0ZkEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/IgJqlLeno1EpkNnCutN0jydyYF3T35CM4CXfdeoRs=;
 b=XC2LXQMZW9KJw1wNqYytWVhhabWvw1gQWfwUi7F5LL8Htrq4aaippOuzU52909cgLCw/uXlJF+JX/ucKos0VfOifhUXg91+b/d5XZ971nht+g6AnXjBtXg/z9NddTlrLLdj8GcfiHnz1RquNquECP5Omr3ezQY4z5GJNPxfHJSsvOgbJehUQcwlxtTW04rjrT4slW908Z20369yad28w0U41lrNYk6EdPSpAEi5pEBm4hUjX8rGV20jTOhXvihzm9HpPRx3QxCJ3iEMrJElPbTBv7bZPKr4+5d/A2Cl+km2OY6nhq3Hf2lDQ9S2tmFgLAIrgph74YsziKnRlr4iExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/IgJqlLeno1EpkNnCutN0jydyYF3T35CM4CXfdeoRs=;
 b=FyK/AMMlBvBEeQSzklqAfKcPPw+PZM0AtOBq5kA/IgKVrcNlfQq2qeEoW53f32tkZCJHhztWkXnWo0ArHIZHwSRpFS+CTZ1/zXw4r6qo4+wVDdpJSnCAqlA1AM1ooNcej2T6flm4ETfT4qHVytM+F8N3L5qReRPTpfZsVUmXi2k=
Received: from SJ0PR13CA0170.namprd13.prod.outlook.com (2603:10b6:a03:2c7::25)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Thu, 22 Oct
 2026 15:32:01 +0000
Received: from MW2PEPF00014674.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::39) by SJ0PR13CA0170.outlook.office365.com
 (2603:10b6:a03:2c7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 15:32:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW2PEPF00014674.mail.protection.outlook.com (10.167.249.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 15:32:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 10:31:48 -0500
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 10:31:37 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Chenglei.Xie@amd.com>, <Zhigang.Luo@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: initialize VF2PF work before it can be
 cancelled
Date: Thu, 22 Oct 2026 11:31:31 -0400
Message-ID: <20261022153132.211631-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014674:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de403b3-f1db-488a-5de1-08df30519e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|10067099003|261021121427099003|261021123027099003|261009221727099003|11063799006|261009223027099003|261009223327099003|261009220027099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info: IupKod88jfE7M9JNTEqeZ9x/ooXSD7ke5feuI5i5mzQZhgqTGGCzRVXAi6FFra6WzzJScANBjSInZNTEwHhaoWZVS4rnRj9cf4X9zxVi+lfOSCjLPOIn4GEEDDJdJTT0sixlFQTpJTTCYmosnxrSDql7t7i11NYFHHx3Etc26roe61QPakV18nSIgSQeZnWVsOCxtjpQ9EpaI19j/iHGMXRH3f7Vfd4xdwijb82JcfgSsBQZraBdfzNADLEYCH6w+Ks8KkF72x2/2zrKvl8MSJETnuUm++uOSfZu+MxWTQmuNQrYh7AewwsZSSYVZJodvKmeIpcgW0Suy7j8T8UDKDIigrVHAXIEMbU0ZldIumQg+ufMXg1X+v3PTcuPJYnBMgv3m5GBRFw7FzUSu2YJK0c7JBbqvKBbo8Aq+Hms2PN/7wKhNm1X3LfY0hQgYq85cUA46GZ2MrnE1KPbFrlB3aokx4Lxaa77uFlgdUMEaxmqK0EsXX2NtUyRB2erO39sO33Hb9u9m1WrKK6CmsMA22M564LQHxQdhrJwQBq1Dn1MNUz20U5QCKa6tuaxjIEPjQeBCUKWMTxuVblVNs5a2gdzWzA+9rqmd0ZuFyJ2r6MpzIfw2GNVxUmi9YMX69OkF2UPYwDeS6ACCLFzHV6yvP1gWkC4ZGAsYnhBocc83lCumZ3/EySmjFVs9p2d84kRc19XSqmYVQ0v8yb5ul1qew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(10067099003)(261021121427099003)(261021123027099003)(261009221727099003)(11063799006)(261009223027099003)(261009223327099003)(261009220027099003)(261009221227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OonBQWIo6jxAuqJf626XL4SeyXF4lt32Y5qKes8d24WRL5rnmfI/k3ZXAtQz1C0Pywrc11ojlaLbf1Q4dQAg3Zt+77uNxLwlPMNywihErWrZo5mnIARgnnIxSuvBra5wg+VkGh4Qt5acvCklZv7Hcmwi28QO6H8HEJQVtIwArB5mhk6soWBD28SJXW6zx9HUiGjkiQxYrChaY4yma+qlTxM+PCfF6u587GT/U8FCYvsg7j/XdgvonK+auMcoeQvWPhlBjpCGgktbY6hERZkhbvOo8dy42mvLCSJDo56ciCVpS1LLCizuc7U/KadiMXB68xqg8aSO3nZiTmePY1qp8PodeJprX5PWY3eKZOW01h+aAWXO0uu47DrBUT8ckHAlxmbOp+ey9ROQnDLAejV7tgTE4OU7yTyam6GRpCAzNH1nS1+CV8risN46tnDGxhx0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:32:01.3272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de403b3-f1db-488a-5de1-08df30519e34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014674.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
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

The vf2pf delayed work is only set up on the ip_init path of
amdgpu_virt_init_data_exchange(), which also schedules it. But
amdgpu_virt_fini_data_exchange() decides whether to cancel the work from
vf2pf_update_interval_ms, and the early init path fills that in much
earlier through amdgpu_virt_read_pf2vf_data(). When init fails in that
window, teardown calls cancel_delayed_work_sync() on a work that was never
initialized and trips the WARN in __flush_work().

Initialize the work in the early init branch of
amdgpu_virt_init_data_exchange(), before the interval is ever written. The
cancel is then safe on every failure path.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 4b1b42fee6b4..c1843c3d2692 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -842,6 +842,15 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
 	} else if (adev->bios != NULL) {
 		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
+
+		/*
+		 * Initialize the work before amdgpu_virt_read_pf2vf_data() sets
+		 * vf2pf_update_interval_ms below, so a teardown after a failed
+		 * init can cancel the work safely.
+		 */
+		INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
+				  amdgpu_virt_update_vf2pf_work_item);
+
 		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
 			pfvf_data =
 				kzalloc(adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
-- 
2.34.1

