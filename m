Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F43C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 16:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5004E6E44A;
	Tue, 23 Nov 2021 16:04:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 060C3896FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 16:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV79jNacf0kzwx9ha9a7OzltRS1Bp9VnBLfMYZPcSqIyh7c9yAEvDxEzA7zMaEWO+/QmIaBlJZqzuAjHWm+K063MpLGwOYtkNavMSIE8cviJPA+q+aa88NqyFs0u87Pz/9pwLkdXHhcSGGI3/hrcQcxZsSFKthdYRH6s20S4MPHas3l6OTFdmR5Oii6a7Sq+n55X8MZ3FMbxuBOP3yMF7x5Q2C8qWIGRjZL4BnWkk8uHBxy0CwyUONJsmzD34DN2vJJPafV/WTYCVcWK1uWb4dO4OgpdlVBMHm/qCM8KwpSBLiph5dz4FIzV1kZ09BHhCb6AIvrNzZRddcdp7CnVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USyP+JEtAQldzuOq5i56eMvl04moyVJe1oknlPscySU=;
 b=lNTEjoxKwWbYgpRRFeGW4z94irhvSGMZFB5LuLtT535I7s5bouk265nYjCnf/xAbJVMUtGIZBEPIv/zSqW0VfMzJo6hMrHcaE/HoZmXYwF8BQEim6fYE1rlWD2zgH5qUYYfBfdpt9La4OoKhrUMgQRSrjVQk2aebkpulWTPXKiowPDod+EUQsdpL+1sPK/nuWcsIVsqbHYuIYuuEC1ELM8lfMjYNBI9SHMe9P0OsOubhqM8EnOeHMhZn762gFVld69GymzyCyOJsiDpHgw5VgVV46rDERg1v//dohihyzRuOjiMKZX8L6e+Zu+EAnKQpcrQPC7Oe99oU2D3aUQE6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USyP+JEtAQldzuOq5i56eMvl04moyVJe1oknlPscySU=;
 b=hriK1T/9lnhB3U7NFHdlBf9r80RBk1Bv1kSQTrqNQouJrQOsctzfyxaYzfF5dWRp8uMAamFGCi6HRBzP6PSERZJZSdsc7hLS1FH0ygD5K/N1GiMIKjpuj6J3mrKC6zBuROF25viBBaRj5ZMIjiygDDU0uRQbV5scq9EU8emf91Q=
Received: from DM3PR14CA0148.namprd14.prod.outlook.com (2603:10b6:0:53::32) by
 CH2PR12MB3862.namprd12.prod.outlook.com (2603:10b6:610:21::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Tue, 23 Nov 2021 16:04:10 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::e4) by DM3PR14CA0148.outlook.office365.com
 (2603:10b6:0:53::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 23 Nov 2021 16:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 16:04:10 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 10:04:09 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: enable Navi retry fault wptr overflow
Date: Tue, 23 Nov 2021 11:03:52 -0500
Message-ID: <20211123160352.21228-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123160352.21228-1-Philip.Yang@amd.com>
References: <20211123160352.21228-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8b41a3e-71f3-490d-0c4e-08d9ae9ae2eb
X-MS-TrafficTypeDiagnostic: CH2PR12MB3862:
X-Microsoft-Antispam-PRVS: <CH2PR12MB38622B02A1FF6418131D9BD1E6609@CH2PR12MB3862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y98P+fWCShHplsfWrGep9zPs9Be3yGg9RT1LQ6mUvh6N3W5Y4ZCF21qjyiKgGPFf7YaKce8G5yewBOxkkPrDb2bFWcmHBSe288pVVrd4ivpIlfSFwppeWHQCYuCn1p8V2NaMMqeIcFEUskuKI/z/Us8T4IQUwNjRrQajBR1rHdGi0uaar1Mo/dCGtUzNz0L5xmvyoWCy7iyvS8XfyLwax1LdcCCubj0mcJj1dnzDFMMU2i+naQ5xr5nixprnMGl0khbKFrJFUhLRIml1WmGuYn2KmFIvCPFBOux1WtIcr35hh5hRSf95KUYqA9mU3Hk+dtgcZvIaKx5uVjQEXFOZYmluenonvZKE0xHkSATjbK6PompolLR3hgFGzZTJ4jHkzajpnSPr48SKntBJwf7PERShSQoUlaR3gUQnTzSeldy5IU9TR8jSevY/dOAlGPq0ox6WcMSpL4y/1RL4z5LnR6pxrrpIRZDBQTjKJWnU+mNdvoUzTQd8YCnvhivyKNQXMzjxsDXPPWXTD/31Z2wrm4iqLSL7jjJlxr3HSlDMeaCzkW+MPPV7ZMhxuLt7qKYB/fRfghg7AV2uf85kMJvxieaJu1pHxd6eoIAn6M7FtFJTzc1SfBFDbkycS832t/rz0woIMZI5drJQjnVT86vK8+PbTf8luV8A6tznkTGk+GKKQ9yJuS4Mcy858JlvJ9THZpoC2+7OYTUs6RasDtQ5PubEv4og+IojVapUUkIRi/ibRF5Mt2R5rTw7sWRe6ioh0mjUd0Qbe8RfkFsGUsVYMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(70206006)(47076005)(356005)(4326008)(6916009)(26005)(6666004)(508600001)(86362001)(2616005)(81166007)(1076003)(7696005)(336012)(8936002)(5660300002)(36860700001)(54906003)(83380400001)(2906002)(36756003)(8676002)(426003)(316002)(82310400004)(186003)(16526019)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 16:04:10.4037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b41a3e-71f3-490d-0c4e-08d9ae9ae2eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3862
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
Cc: alex.sierra@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If xnack is on, VM retry fault interrupt send to IH ring1, and ring1
will be full quickly. IH cannot receive other interrupts, this causes
deadlock if migrating buffer using sdma and waiting for sdma done
while handling retry fault.

Remove VMC from IH storm client, enable ring1 write pointer
overflow, then IH will drop retry fault interrupts and be able to receive
other interrupts while driver is handling retry fault.

IH ring1 write pointer doesn't writeback to memory by IH, and ring1
write pointer recorded by self-irq is not updated, so always read
the latest ring1 write pointer from register.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 33 ++++++++++----------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index dafad6030947..38241cf0e1f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -276,10 +276,8 @@ static int navi10_ih_enable_ring(struct amdgpu_device *adev,
 	tmp = navi10_ih_rb_cntl(ih, tmp);
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RPTR_REARM, !!adev->irq.msi_enabled);
-	if (ih == &adev->irq.ih1) {
-		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
+	if (ih == &adev->irq.ih1)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
-	}
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
@@ -320,7 +318,6 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ih_ring *ih[] = {&adev->irq.ih, &adev->irq.ih1, &adev->irq.ih2};
 	u32 ih_chicken;
-	u32 tmp;
 	int ret;
 	int i;
 
@@ -364,15 +361,6 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 	adev->nbio.funcs->ih_doorbell_range(adev, ih[0]->use_doorbell,
 					    ih[0]->doorbell_index);
 
-	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL);
-	tmp = REG_SET_FIELD(tmp, IH_STORM_CLIENT_LIST_CNTL,
-			    CLIENT18_IS_STORM_CLIENT, 1);
-	WREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL, tmp);
-
-	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL);
-	tmp = REG_SET_FIELD(tmp, IH_INT_FLOOD_CNTL, FLOOD_CNTL_ENABLE, 1);
-	WREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL, tmp);
-
 	pci_set_master(adev->pdev);
 
 	/* enable interrupts */
@@ -421,12 +409,19 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
 	u32 wptr, tmp;
 	struct amdgpu_ih_regs *ih_regs;
 
-	wptr = le32_to_cpu(*ih->wptr_cpu);
-	ih_regs = &ih->ih_regs;
+	if (ih == &adev->irq.ih) {
+		/* Only ring0 supports writeback. On other rings fall back
+		 * to register-based code with overflow checking below.
+		 */
+		wptr = le32_to_cpu(*ih->wptr_cpu);
 
-	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
-		goto out;
+		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+			goto out;
+	}
 
+	ih_regs = &ih->ih_regs;
+
+	/* Double check that the overflow wasn't already cleared. */
 	wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
@@ -514,15 +509,11 @@ static int navi10_ih_self_irq(struct amdgpu_device *adev,
 			      struct amdgpu_irq_src *source,
 			      struct amdgpu_iv_entry *entry)
 {
-	uint32_t wptr = cpu_to_le32(entry->src_data[0]);
-
 	switch (entry->ring_id) {
 	case 1:
-		*adev->irq.ih1.wptr_cpu = wptr;
 		schedule_work(&adev->irq.ih1_work);
 		break;
 	case 2:
-		*adev->irq.ih2.wptr_cpu = wptr;
 		schedule_work(&adev->irq.ih2_work);
 		break;
 	default: break;
-- 
2.17.1

