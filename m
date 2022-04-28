Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A931DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 22:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F7FB10E0AB;
	Thu, 28 Apr 2022 22:12:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2190310E0AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 22:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuRzc/mqMjvJxDkCHWM13OAOTY7TOQSNGdD3iI1JT1bIcmwBGyajKiq+Cc7FC5XPL/lv1RxCWzCdSjcwfE9Wwwk4WC1miOStrEovbb/kYc06DMd6/HWwoLkngVZ2aUUPVA3iU3trtKSR/s5jSwM6LmLWJ6S63Wt2YUnEGC2H3fPAGsHp7PYGny9AVoAbUW5aQqyIH/Pe2zNjyXNK/BYvIRT5Crrc9WTmhwl2fchb3Ir46yoLSVQnjRFf2zqzWlabZt9HZvC0IIbEXt/L26z2KrG1dbhd4o2dHivyyraK5fjqsW8wqpIknoClccgn9Qt80gwdAgamoKO0WVKKdagiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb1+ImBHqYnOCrtShfHzJN8TgnLKhY2fwPW7FLNojvQ=;
 b=Bkzo5xJLXqZo87z73Kbn50I1lkJ+bR7BD4QHxMImlUM3H7LWWkc3ZOXrIdFb0CzkSf6O29GQbZpzBlR3Wn7u8gfBPJ21gQc2UYBIDTrVuBFjVbJg03/xlkmsAg8M+9rYiEcuIvnPmKJV2ij9OGtNj8cfKiWQZb01W0z0vYN/xzrW+khOtfvUaq7DsaoaH871lwAO3Cg+kR2fLKPrBPK+hF2ce0EO9f5rMW7u/8clPoV+FD9vTwjiUjkY3THXPsenBH6nMxjfxeTZeqo+VMKTiJRmazyBbGUxl+Qpl0xx1TVbmQXUIROWQu6Gi6kOlOf0zhocDIysYf8d/sbTR+UaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb1+ImBHqYnOCrtShfHzJN8TgnLKhY2fwPW7FLNojvQ=;
 b=NLmC4s8lglIvUhWxrmb7G+FlTA59nqRxsdBsCIalX/XzjNbVbaMPYS7ZANalu30HWBhEZziZRRrm14muMHwmKrcXIySIChyArUo4N/5iwIEgQdKQAz0svpVaRRMJ0lzRpXPMutrndL/xB5RsyNW0MVSyrCNGGK9X2Dx+j63Rs5Q=
Received: from DS7PR03CA0260.namprd03.prod.outlook.com (2603:10b6:5:3b3::25)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 22:12:45 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::19) by DS7PR03CA0260.outlook.office365.com
 (2603:10b6:5:3b3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 28 Apr 2022 22:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 22:12:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 17:12:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu/psp: deallocate memory when psp_load_fw failed
Date: Thu, 28 Apr 2022 18:12:31 -0400
Message-ID: <20220428221231.1030104-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428221231.1030104-1-alexander.deucher@amd.com>
References: <20220428221231.1030104-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1090eb2d-2f31-4afe-9f1d-08da2964390e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2542537044C25E4DC6D2F278F7FD9@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InMcrRIp4egCGrzVZOtLFfocEZSMMFQZmk6QRu4peDrxhSo7YbQZuR+XTRI1PbzFNdd89eNp1jzcLkqq2yJdN3+r/srDi/nSdDSihGl31Xtcq4uJwR8Db0NB7fjWTafCwpZMfI1vssQBitXubiOZqEzAmChmfgHFoQqM+bojIARvx5BEv+mAWcK8GC3AjKNZlMhXsfi08RAiHhxJ0ymkZaG8muCpo65TK9F4nVqOSl4p1mDc5Lt+GNGF5trPQ74cCGuUBC9sWWbhZewqbC28fr7S52ZxkZ94/yBnH2HViFilFt/Sn1Dm7ON0VLpp7XpU1q6rA6BNuWo3xkQ8L77Xm/E/6+rbxwaaoowjnsWqZjQ7xq46vqPRPKSqsU+MlvA6j1Idh7BtUf0LbwcpQ1k+JA7C8tbf4yjYXqFXZ4WmRaaFes3SJSI6lb3DrS0bsprpOx3iebkJ3YcGnUZ32l0T01kuwCJ6vnX+ppuGcm+68+sJ0gzxwlP26YjKMUy8w2C8zCl6b72zekYhHcgNstVLm4uQ2fh2HZZRoJMsIjCAo5zdHuTe6cSJJ4jmN8H7DDnmVdQBCNdBmIBQ6uFRaUvk9i6SLtbng2q5ZE3RRbe2UDYMLbtl60y4dFTPkvM8rLNEnVKkF+70AhMMr/VSxkYk6uFGJ6v7HXjbOEaM3c7tePl7WEgzRYwZaGHRXXZi66mQSaNp8YsTBFxjKnROb4fvKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(356005)(81166007)(40460700003)(83380400001)(8676002)(4326008)(5660300002)(6916009)(316002)(70206006)(70586007)(82310400005)(2906002)(8936002)(7696005)(6666004)(1076003)(2616005)(426003)(16526019)(47076005)(186003)(336012)(54906003)(26005)(508600001)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 22:12:45.6137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1090eb2d-2f31-4afe-9f1d-08da2964390e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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
Cc: Alice Wong <shiwei.wong@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alice Wong <shiwei.wong@amd.com>

psp_load_fw failure would cause memory leak for psp tmr and psp ring
because psp_hw_init is not called as psp block is not fully initialized.
Clean up psp tmr and psp ring when psp_load_fw fail by calling
psp_free_shared_bufs and psp_ring_destroy.

Signed-off-by: Alice Wong <shiwei.wong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b1b6f5dd35dd..ccb7106b2f27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -153,6 +153,12 @@ static int psp_early_init(void *handle)
 	return 0;
 }
 
+void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
+{
+	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx->shared_mc_addr,
+			      &mem_ctx->shared_buf);
+}
+
 static void psp_free_shared_bufs(struct psp_context *psp)
 {
 	void *tmr_buf;
@@ -1003,12 +1009,6 @@ int psp_ta_init_shared_buf(struct psp_context *psp,
 				      &mem_ctx->shared_buf);
 }
 
-void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
-{
-	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx->shared_mc_addr,
-			      &mem_ctx->shared_buf);
-}
-
 static void psp_prep_ta_invoke_indirect_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				       uint32_t ta_cmd_id,
 				       struct ta_context *context)
@@ -2409,18 +2409,18 @@ static int psp_load_fw(struct amdgpu_device *adev)
 
 	ret = psp_load_non_psp_fw(psp);
 	if (ret)
-		goto failed;
+		goto failed1;
 
 	ret = psp_asd_initialize(psp);
 	if (ret) {
 		DRM_ERROR("PSP load asd failed!\n");
-		return ret;
+		goto failed1;
 	}
 
 	ret = psp_rl_load(adev);
 	if (ret) {
 		DRM_ERROR("PSP load RL failed!\n");
-		return ret;
+		goto failed1;
 	}
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev)) {
@@ -2464,12 +2464,15 @@ static int psp_load_fw(struct amdgpu_device *adev)
 
 	return 0;
 
+failed1:
+	psp_free_shared_bufs(psp);
 failed:
 	/*
 	 * all cleanup jobs (xgmi terminate, ras terminate,
 	 * ring destroy, cmd/fence/fw buffers destory,
 	 * psp->cmd destory) are delayed to psp_hw_fini
 	 */
+	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
 	return ret;
 }
 
-- 
2.35.1

