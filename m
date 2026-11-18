Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB5606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oq3Qyq81
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE81D10FF69;
	Wed, 18 Nov 2026 18:54:15 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2D610FF69
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 18:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwUxX9yZEohXIOzTo0qsDU6X7Q/4Ki1Dujyhvv4NGhDY0npZu+dDDkj0hUflwhw7dvhPMaimGxkNB2CupwYkS/99mwEbRse0wpEwjkZTVpotkkOFxDINBZY8u6oHCOm8LuCq8CYcjImXZiwG/2t0oDkh+SikLlcwMZ5n8kmiSQ4Ew8m+bZArFGdwUJMeHEXZUteAWfUDd95c+DhBzgBjxRw0EftVeciHttQKVhwBks5nlDpkCZvBZsUE+dvLuuu1P/PaRIMj5kTIwx1ndsUp0K7Se/IxGUdiLnBkGDOzxwKs70Xjmon16nLOWgSGiIni5b/LzHy3c2rBidy3a60A7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1lO4xzuDIt+fvBZgj62BVT956DUs3GnjVLipLuIvmk=;
 b=MyC4AzemV3toBo1/dkmYSJjvQgZP4Z3WnkA3/QypocfOo/3D7Z4cOOYtVOhMgcZJWBWNLsHsKREFNMumi0Hgxd1tkQjaoRNEqvXp1vNXv6KcnDeKHf+igTZOvysXsk4Sh/jsKPE9jFq9CZh6FCfj6Ops6ZWYEOwU5XiI18dnfTf+8viMM9shX6m9WOe1zeMD6CuDAQ1SGiDm3rXrhymc9Cbv4alReufGfh1uw3ii0Tzs+49vqcfGvHPiIeIvjf8FqpOuLKsAxjlLBkXk5M5EueKyZ7eUSsFWbv04uSqj3sQLVcSq5SzPW7X0te88QwIN+iyj2m7Gq6S/7txC+nl/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1lO4xzuDIt+fvBZgj62BVT956DUs3GnjVLipLuIvmk=;
 b=oq3Qyq81yyrIqsLssnhx5MfZ4Pj9mcI5U6Rqmdwos2R39TywgKvxO3B8RUUOmy7tjsULkmDGLTpCO5zZ5O98MLmExz5Ip8XFKhs3/fXolnd35GNkTUXatkh2EBUSJTwNDa8xcbitQPld88CtFXew9HE0Pm/DW6p2l2mA6XfCRgs=
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:52:45 +0000
Received: from DS2PEPF00006E24.namprd05.prod.outlook.com
 (2603:10b6:610:50:cafe::33) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 18
 Nov 2026 18:52:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00006E24.mail.protection.outlook.com (10.167.23.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:52:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:52:43 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 12:52:42 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 7/8] drm/amdgpu/uvd: stop using amdgpu_bo_fence
Date: Wed, 18 Nov 2026 13:52:24 -0500
Message-ID: <20261118185225.1857845-8-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118185225.1857845-1-benjamin.cheng@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E24:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fb8d73-414f-4ca5-a94f-08df45a521ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|261102123227099003|261026140227099003|261028144727099003|11063799006|261021123027099003|261021121427099003|261022105027099003|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: zp0nlZn2v+DZqfCNrIhKRNwBv57A1Sqldcqw0cdoQKTSzDKmTZDjigLCI3Ez7ocZzsf/NfcaW0bPRKtDoWAIVqiDt6QUO6+6f4UhRaAKVspUvKtBmAUkkDZbdPEI9RpsWMaeXI0kwpfnD7pqjt2oSF+f0TVjvHzwiZ2JAoL6mL3MJu0Gkap8By0X7RHZsAR1D8vECVKYAnv9QFToAs7T6K2BJjKaIre0YbTZcik9vbuvvKue7IBz6ej2W42x2sgDWoe5FeWBV/hSUSKsgnwVpnNmyRXP1IUhP3yE1l32npY1G3E3hE3zNgDCQLJVR7kUioJs4MBbmmUnLj//bgDBuecBK7GmN5A9ZLEap1lmXr+r7cDWCK5jwz1LGx3gsNWKApaNMi5lR2VrpkHKk9ZlrvtGj87tO75fKznqBiYkOCxVvoscnnvRQj/8Tksh49mOjhSWypB8knOWtyLR82gwldQ64c+blpxtEeD6gYCpXARAPC07vWtw1NCfv1LPnE3+wQKSDTPSXDl4gh3Q5CGbHwQUqMiKTiCkQMGsuP9gA0K4xerpIq0kK2b/6DGJ3rcAtFNb9HTlYp9DwvPyckbdE1/L7TBLYlLy34XUm7Pf8RMRQQRL21WIh1PvQ+Qiu/iEaGkcUmQl/c6Ssi6TZzoOlg+Hmc31BJiGRDyjPbnQV+GKzX+TI/8+l55mzflNfZmLrlDFQD3dlY/Rjql5fzokJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(261102123227099003)(261026140227099003)(261028144727099003)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RVuCR7mBpRFNEwPD2Fv7Ddd8yR1XHGIp0Gxo/bDFGo1Xt8715ux0DEtYMDRfwAboyTFbBFEcxx8AhdZ6rRnGgU6J029UuqjHu8XszSnhLGP50qVDVnYcX2/FfXd+6aLAoP4vvNeQCsLboKxKnLZw8PJUcTiTigP6iUJPhRt1ZLZVhSMV1MfWdvwa2BC2pZTC6C1so1PPwvnXmhRdxugydrZQAFhGyqLEEWfcEplyCiz68mN08g7mL3/9ts00OMHNpTttqaDzpbbr6qWIe1ZTpCPDfTeLaxG5I1KUgvfa1wLt1vHPAkrVS9SrZ0Q6NaOcJ99tHq28wvIfD54Hq2q/sTaycbXUWVPuHYb1ey0cKmhlT9FeOwIiQ68OR+odf+5e15ckkXUkrEoLInZZlawkJ+bLDwVjbrqFGg2A+/MMUQZexUzTov0v5F9OJ3crx+rX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:52:44.7883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fb8d73-414f-4ca5-a94f-08df45a521ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E24.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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

This helper is deprecated since it is incorrect in most circumstances.
This was a circumstance where it was mostly correct but it is the only
remaining usage, so get rid of it here.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index d88dde859615..9570db033b18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1154,16 +1154,24 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 		if (r)
 			goto err_free;
 	} else {
+		r = amdgpu_bo_reserve(bo, true);
+		if (r)
+			goto err_free;
+
 		r = drm_sched_job_add_resv_dependencies(&job->base,
 							bo->tbo.base.resv,
 							DMA_RESV_USAGE_KERNEL);
 		if (r)
-			goto err_free;
+			goto err_unreserve;
 
 		f = amdgpu_job_submit(job);
 
-		amdgpu_bo_reserve(bo, true);
-		amdgpu_bo_fence(bo, f, false);
+		r = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
+		if (r) {
+			dma_fence_wait(f, false);
+			r = 0;
+		} else
+			dma_resv_add_fence(bo->tbo.base.resv, f, DMA_RESV_USAGE_BOOKKEEP);
 		amdgpu_bo_unreserve(bo);
 	}
 
@@ -1173,6 +1181,9 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 
 	return 0;
 
+err_unreserve:
+	amdgpu_bo_unreserve(bo);
+
 err_free:
 	amdgpu_job_free(job);
 	return r;
-- 
2.56.1

