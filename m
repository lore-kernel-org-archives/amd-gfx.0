Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED23606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LsLVI0zM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D524910FA94;
	Wed, 28 Oct 2026 08:58:10 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013046.outbound.protection.outlook.com
 [40.93.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C64D410FA8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWxrzmXFWzVHyZCfEq8p1mEdjNIi4fhjTCD3/CBWZpPo8G1pfzhV0/l4LRKWE9fBemKPl0HxviEJJwghnY89XCRFZwkO7bfcgfQbo8yceOBACMbsLMNHREQTmuUqdHkUUw9pnwCfJSyz35s5t0ddmD+vZJ5PLRqXSaUSvIn2CNoHS2X4QQ2ZVvYAifySBztoIBcE2gbMk8kdZeWdpz97a4OfH/5Z+ZBO4pViIO+MOOyfcUPutxRH3KSwC81CbdaUpX9+V/2yYR4c8ryPMbjDvDnOWiMd1yBEMMsoybbRZ+NAxWaKN5XTqrBkzEGhf8nozzWSWRlTAWRHE+LodNmp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nF3XChZNaglOK7r6VZWSuVwj153RF6Q85DQjQvSyiEQ=;
 b=IrMK7grHvoKHSOVMXlDq/ieFVWulMQVf8Inz1rWuCwxKxqCUwsXmjkwoTGOp9xFwxKXP7Esk4HuSTGHvQj/uVO5rSFF6WLRLuRUl3L4CxiAC4twGxjqJfQ3XwGQChwNi76ozVCn7oXbdC1kahnIDimFBHYPBXV3sGmPeyVr/DpMnHMVbEAjlAfd+jE2IZ612RHv2S5Q2SLJIzocldxqrrukTBTp52iW5ggy/tl6mkdqT4xHIilw6E77JxrEHS+wI6elv8p4mk5oWUKV5oCXVOdOKhjW2c02drGBXITbO0xdEKh6+E5XMl6iWfZQeF7IHXkrkiLfx60kKMXkaTMZV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF3XChZNaglOK7r6VZWSuVwj153RF6Q85DQjQvSyiEQ=;
 b=LsLVI0zMwDtC/5xjgR1BytdcOwu9gHdZja2qVJOuwHDNrqNoHQ5+R6WAUOdGr30hW5q5lRmNCxQ7REfazEGmrG8TVRv9G488uFMRmfV+cJdcbPa9ABT2T9MqfRJenphCOPHgpS/NSpSbRNIfGHcLuVkYXQBa0UDBiS67BzcxYVk=
Received: from MW3PR06CA0001.namprd06.prod.outlook.com (2603:10b6:303:2a::6)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 08:57:56 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::79) by MW3PR06CA0001.outlook.office365.com
 (2603:10b6:303:2a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:57:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:57:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:57:54 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:57:52 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 07/15] drm/amdgpu/gfx: add callbacks to read and restore
 the ring state of a gfx queue
Date: Wed, 28 Oct 2026 16:56:38 +0800
Message-ID: <20261028085736.3808569-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f0c1c0-34d0-4fb0-cbc6-08df34d18e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|22082099003|18002099003|56012099006|11063799006|261022105027099003|261026121527099003|261026140227099003|261021121427099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: scbofd7PuTsetRBh+DzxUSIAIF9CJesspnkTToA/Oa2y+3rA8o3wxWK65SWg8v03NwZxPof1oPjbMQVHJZcG5ukmEm63w9z8TnqWutGzI87DkfoesU+ET8/V0lHGazEPJwEnYd7QNJwr3mqlYDsbnUoo6ZxCogDGnIDGDp3LzS7XS3E6DPq0LBC2uWABORxMPaCTF0R4djNHE9s2/5QsIM+xa/AzD5GXaN76NEQgvJ2JV7k4b5X4Xe/k8woiWAv9vsURWBBixsWVxx1xF1mUcjOEjPKHXjyVm3Yk+39w5oEmHWWchMEEg0GpwXtmmmQrZurGR9BSRcY+3syA0gFNMMiFuby2jELbEJfLQoAM4Ubg+qEqcAyXgCVQ5HDIIagSFuB/V2OU9uUy7ioETNPhuh0J/9nPm0r5LInBC26Iyn8yo9a2MuhF3FjjaqAkY9JcV/vkkBPi97J3+LjfylBu062BIRAkoHZC7CFSB5QuC10LoipWuYW63n+09burRg/0JfHCi6F57LuHQZtThoAEGGW0j/FgW+yVKV4B0lAi/6fDQAgEx9NSm1pGfQTIGt6nbwqNOSnTtfqzHlxW+1gfCU0UWMlpx+QIU3uySlPx1QFpa9J/O4z3oaxAVM/5qdei0u1ayVYOlzTZF93u8TU1sI/GamgNRJt39fUKyK4sDgrpsZVbJkJManSkzp9k/to2XdUw0gLgrbrivq3ewRv65w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lJl3RxQxJijVd4vOrHUy5qRqnpThfF3ZwigD2ABWeBnp2O3cGKiWex62Ktc77fbmz38+v6fjD93+SucxS36nmI9IdIZIj92GaLZ5nHDhP7BC6JKJ8qlSQz8x6ZLfkI1VN0x0rBmtT2a7fPiQ4rZn+CKy7rPTsFcNGz604GxJ/MJSbVUJfX8iJ/qm883pMy0FjyJ9OEg+XbzGiNk4khqw1gSEEiWA16p3j+sv209RzRn3qVydiUcRYifSTm68pnGOkaAwh7QP63g9uBFDPtjqNmvOEOhTsbSmk+uyWhK5ks1eBK2rGYEWMYplKeOWWI0ajepqBomn0hYuBzrqBF9rzsaLVPS1UA8GNc5wPwo7Krmkmt2yFe1xKe51NYgoXUdS+ExTX9az22kNs3tebriQrZJh5pt8Aho0lwGAfTaq0vqFf5KEHiBCTaRIUX0kv0V1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:57:55.3689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f0c1c0-34d0-4fb0-cbc6-08df34d18e96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
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

A gfx engine reset clears the HQD registers of the gfx queues, including
the only copy of the ring position of the queues MES didn't preempt.
MES doesn't save them in the MQD either when the engine hangs.

Add struct amdgpu_gfx_hqd_ptrs for that ring state, and gfx callbacks
for the gfx IP, which knows its registers and the layout of its MQD:
- read_gfx_hqd_ptrs() reads the ring state of the gfx HQD of a doorbell;
- restore_gfx_mqd_ring() puts it in the MQD after the reset, for MES to
  map the queue again from it.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 8d7bd7057666..f750b11f4ad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -346,6 +346,17 @@ struct amdgpu_gfx_shadow_info {
 	u32 eop_alignment;
 };
 
+/* Ring state of a gfx HQD that a gfx engine reset clears. */
+struct amdgpu_gfx_hqd_ptrs {
+	u32	doorbell_index;
+	u64	mqd_addr;	/* the MQD loaded in the HQD */
+	bool	on_hqd;
+	u64	wptr;
+	u32	offset;
+	u32	csmd_rptr;
+	bool	connected;	/* the queue the pipe executes */
+};
+
 struct amdgpu_gfx_funcs {
 	/* get the gpu clock counter */
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
@@ -380,6 +391,16 @@ struct amdgpu_gfx_funcs {
 	/* reset the CP of one engine and map its kernel queues again */
 	int (*reset_engine)(struct amdgpu_device *adev,
 			    enum amd_ip_engine engine);
+	/* read the ring state of the gfx HQD of a doorbell, if it has one */
+	bool (*read_gfx_hqd_ptrs)(struct amdgpu_device *adev, u32 doorbell_index,
+				  struct amdgpu_gfx_hqd_ptrs *ptrs);
+	/*
+	 * write the ring state read by read_gfx_hqd_ptrs() into a gfx MQD;
+	 * true if the work up to ptrs->wptr was dropped
+	 */
+	bool (*restore_gfx_mqd_ring)(struct amdgpu_device *adev, void *mqd,
+				     u32 ring_size,
+				     struct amdgpu_gfx_hqd_ptrs *ptrs);
 };
 
 struct sq_work {
-- 
2.50.1

