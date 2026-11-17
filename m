Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42DE606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BOPkkl8o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23EAC10E549;
	Tue, 17 Nov 2026 07:24:24 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC17E10E549
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vpnhhvr3GAWEnfat7lGk0ggYVcDOE0bvsHw6sY7fry5Nn+CSywXT6JGLLGGbif4Cso5wDQo9VSz0tmr4q+hcjOLzZavhPtnfFpRHz05SYw89AEwuZviLkvPHz4ABVeERQnEs67Wl90J6PDPvDymFuxxLPKFTgCB2nglojPsClU1uwZeFSHDJxPr9WFPM5tOlSN9Fo6GtVCjHUMXdvEYHThAbMPjid4DXWrY/KrsJGua6SHC7rLTWQ1wG4D9y8ojL3D5RDCJBjJOcNlw5+ds5wrQ7BUHsVqzbM/Ro1DRnPgwCYuhGRSr2B+yz54LLgR5pjn3UdTCbp83yKWW+2aCsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kIGSoly+Zly+FANtHFZ6ZVFFWQSlRmwm3jPldEaMy4=;
 b=q0SxCMUoEuqNeHkQegg73GRxi2WW4SBoJ6Nv1k2YNrpIN8fxACIFT6e6SBpp7WdIH1Pg/fTxLJ7RXIVm0WueQqxMgKUKsMMP+Vlyfbts2E9E5NuXktaEDHE8rFeUP8p0a9bAZ0amtwoy4risqfbjhgTs9WbkFMRey5iDBhIpbm3pj9Dvk8bjIqhd1ZjRKNFW6PB/0U0nYiy7DJdBKhyhvRHKdl1Kckuc89KELdcNTLcRbfk7ICN0Tk0jw+Xcp5rBOREMzkAFsx2lHe01KTfgX5JpkVqgfKb7Npi48nrhSScBwB21SdkJIeNPGZmjEZxVuK2op0+j2ttn4Ggxv/xD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kIGSoly+Zly+FANtHFZ6ZVFFWQSlRmwm3jPldEaMy4=;
 b=BOPkkl8oukzzJQLhGitZsxR5PBO8MWFz3xPa/5/eXtZI9UFmJMr7LpRh6KBgUgPalV2V2upp4mQWuoUTWKHRAaQKSuvgRoZ/ebGei+poxC8SyP623qb3DEkuXbIuLORxLhfh0f8+PfxiyZB3/IZ3xkyrGS+8z4Qyr5xsskj2d5U=
Received: from CY5PR15CA0107.namprd15.prod.outlook.com (2603:10b6:930:7::16)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 07:24:11 +0000
Received: from PH2PEPF00048917.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::4b) by CY5PR15CA0107.outlook.office365.com
 (2603:10b6:930:7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 17
 Nov 2026 07:24:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH2PEPF00048917.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 07:24:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:24:08 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH RESEND 4/4] drm/amdgpu/userq: report GPU reset in progress
Date: Tue, 17 Nov 2026 15:23:53 +0800
Message-ID: <20261117072353.537506-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117072353.537506-1-Prike.Liang@amd.com>
References: <20261117072353.537506-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048917:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e9c323-45f6-4a37-ff27-08df447bc69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|261021123027099003|56012099006|11063799006|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: xWRgQM6zxOT+L7HphEJrywxrF4S1Np+0luRA0rwkLZqbgYWGA6ZStrvpCYOaObrh+4T+Zz2i5W6WvDGK/PziULNbQRibCgrTp/qxfg3yJ6MtI56TCGAEkpplTb6p667bTl7qZqGV6UYV2DXMCnYwlXABu4Uwi/fUJtvPC6epSC/kwyaZU217D+Ng19o0C1gDSg1kmy+g9Us9t9oRyqm7uKtmCVqhXuEapHEMAhvENUQAjhQosO+iuzVCA0P6C/6WwJyrDh7xf9IEXEPwpsoiXcn57oOykkvTV9sUnW6lMy8seTofgI5CxSR6/eGJrYzVYIiKuBPTxlmhD4/evyQg9q0A79EpL4yYiRgYlU6Qo7bKuHaHxVsyd8Z6zjaiUwPQhkwITvT9Bk+n/yBjk/iSTHi1si2qhqgQaQlm13U7p6CygKPlKHv9NHiPnzp+vuFqt/MVKLB+kX9gBZctjE41C991cvKv3juTV9SkJbaHOWkIR5WXhBGAkmvItnWmn3VcB5Njr7O+B4YNv57KtNlLITv28r4lc8GeewR2wW8yIeygh+X9DDlg9G9MDTvzRYy+a2Z+H6VNbZOQg7irHfbeWOBK+tBiGzoAe0ZaXh6ecHN5jy535RuvicioTNdymjxv1wWYyMZnPiH6n5R2x6EIdw7gz2TwocPq/Sj7iXoptHqk7C+tlay1rBAeNjudo19Hsar0lZteu5ePLTNoBnufhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(261021123027099003)(56012099006)(11063799006)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X6YlQsno2xaGZgCYUtbwW2TH3atXPwpVcHAQc4hrA8SU5tcFAu3cvRQYta2jzZNYk6aoViG37KW16CKERRFvU13GzeFlWboLurRvNhggXRTpMXMdVWIwcPQdv1tnzVkmtrs6qyrLw1mzaPqBslPDOo6cBljZmC1SuFS2h2CKMsPEUcYMiS1wgjD4nY72/P0L2xU9mu8Ii80fv9m8mYU/zu9U4GrDCfDanBNQQxrVzkwYsnZs6VPtkKVtXW530V/mAG35AHGRmJtTEDr+GG41ODh16kM7MQZwyj2f/ieILW0SKyfo1cIvbS22zYSpu5kjRPGErIHj7eTK6ggM7ySYi9OAzOvs3oY4luHmlz2u5WHFnO90mcUYZ2mc6Pb/hsGwvfwh9YvDQiBNr/LPm4bmoeAUbyhrLMusWBmVO+/ij7beIFxlOfysT+blpByQUDsT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:24:11.3290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e9c323-45f6-4a37-ff27-08df447bc69f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048917.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
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

Report an ongoing GPU reset through RESET_IN_PROGRESS at bit 1, alongside
BROKEN at bit 0, so userspace can query whether GPU recovery is ongoing.

Validate query inputs using the same rules as queue deletion and document
the required fields. Drop the queue reference after releasing userq_mutex
because the final put may destroy the queue and acquire that mutex.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 +++++-
 include/uapi/drm/amdgpu_drm.h             | 8 +++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b48cf2a2118c..f5e152bf5529 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -840,8 +840,11 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 	    queue->state == AMDGPU_USERQ_STATE_INVALID_VA ||
 	    queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;
-	amdgpu_userq_put(queue);
+	if (amdgpu_in_reset(adev))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS;
 	mutex_unlock(&uq_mgr->userq_mutex);
+	/* The final put may destroy the queue and take userq_mutex. */
+	amdgpu_userq_put(queue);
 
 	return 0;
 }
@@ -903,6 +906,7 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 		}
 		break;
 	case AMDGPU_USERQ_OP_FREE:
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
 		if (args->in.ip_type ||
 		    args->in.doorbell_handle ||
 		    args->in.doorbell_offset ||
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 6c0992d06fcf..cde359344929 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -355,19 +355,21 @@ union drm_amdgpu_ctx {
 
 /* the queue is broken because it is hung, has an invalid VA, or VRAM was lost */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN  (1 << 0)
+/* indicate that a GPU reset has not completed yet */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS (1 << 1)
 
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
  * For operation AMDGPU_USERQ_OP_CREATE: user is expected
  *  to set all fields, excep the parameter 'queue_id'.
- * For operation AMDGPU_USERQ_OP_FREE: the only input parameter expected
- *  to be set is 'queue_id', eveything else is ignored.
+ * For operations AMDGPU_USERQ_OP_FREE and AMDGPU_USERQ_OP_QUERY_STATUS:
+ *  only 'op' and 'queue_id' should be set; all other fields must be zero.
  */
 struct drm_amdgpu_userq_in {
 	/** AMDGPU_USERQ_OP_* */
 	__u32	op;
-	/** Queue id passed for operation USERQ_OP_FREE */
+	/** Queue id passed for operations USERQ_OP_FREE and USERQ_OP_QUERY_STATUS */
 	__u32	queue_id;
 	/** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
 	__u32   ip_type;
-- 
2.34.1

