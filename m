Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14063C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 18:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C662160ED7
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 18:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C662160ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0866B6EE4A;
	Fri, 17 Sep 2021 18:04:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6B86EE4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 18:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNWcPloB40ivRgf6WSXj58q34QDIRUzoOy/WO4fQDzEFRHNDxwlgE/wsf7Bnix6Po6eZ+2TauXM7SlkhAVPhUBKxcE7/2hYndhQCY3mJugjueNSuDvBHUk3yrrGlzi67p+Fb3tckMf/bypeWATgptrNwFTicr1vxQPgf1ui46Y84GJq2OdMA5OtWsknWLcfgS4hWich0xZmK1OKwGezAUdZq/opWotiJqT+Xu6j2AvtZMmrSn2NudMFd4OzlvqTWbtAJLuksRuLfIT2te1Rwfk+B1bx6sZ5El4eSSTkn7VghShwaGW1zqO9IrX1hzEpXZuvo74qi7Le/oltZKjqESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=1XVW5eYIyAltzsayTmb1s3+SYY47bh+DWdlR2AcvC1k=;
 b=ij+1xJ+gSUtPMXdTLsmF+OgYbdiArganhZaLBAHdoRHbhqiqKN3qL4W3BN3DAk1sfmS/3unSrUxZIeBJuUr0YGUwYHIMHYd8dVTyuepBQ7cTZEohORxOwzSBuXNBoJCpFdUZ51KK/zfzRqVGRI8MbFGF8kSkbZNOTEUnIZcUNFJDPF2GLuEiF7212DZarOLG3Pl1qeUfXb2EdgRIa4sfuFE7fYAKjp5HXhKThyseJPM3GhXQOhl50lsDe58rNwtlY/J4SD5t9c9JVphr0f4xc4FV2LmhiaXi6H9D+kC/ZbS2lAX6by3EL8ZcT1+KU5mRfX9uKNmli1+/0VnwLlS3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XVW5eYIyAltzsayTmb1s3+SYY47bh+DWdlR2AcvC1k=;
 b=Zw6vN/qe/t8VklHOadmSN93dtIa5vn9KxOSj/FBBkuJ0olGI3+NU704yTeUo3v1TM+EcrsjPJhaFJEAfbGL46XQd/mDFM9w5PWwTSSIxSya4iGC+KVODl4XH7cE7pSDebDx77PTxaw7HfeOmgN0b6pIKZGyCQbRH67a44GTOw68=
Received: from BN6PR17CA0029.namprd17.prod.outlook.com (2603:10b6:405:75::18)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Fri, 17 Sep
 2021 18:04:50 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::32) by BN6PR17CA0029.outlook.office365.com
 (2603:10b6:405:75::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 18:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 18:04:50 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 13:04:49 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3] drm/amdkfd: fix dma mapping leaking warning
Date: Fri, 17 Sep 2021 14:04:36 -0400
Message-ID: <20210917180436.13923-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efa1cfe2-b9c3-43ca-85f7-08d97a05a490
X-MS-TrafficTypeDiagnostic: MN2PR12MB4392:
X-Microsoft-Antispam-PRVS: <MN2PR12MB439269519F5901D1805291C2E6DD9@MN2PR12MB4392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBrIc61FxBFb8OSKt5JjgIHAQ+MXRSwEURH4jHY26iPIKM0F5jhThhd5z8yzXt/2vN3kN9ALyMHrLiazs8e6tWk8nu9pJj9MJvtMm/DSfR9O3Hs7FOe2muJFu7yqNS0RhJA5BQMelQnWHml4aDbsbB9Z9RlEtttKHG3BR8PICF78Po1rETP9I0F9et7IuelPaIXE3A556gYRBWrheNNxW+Xn88Elfgg3ktkN9vA8COTtUOc+0AWxc5GLfyX/B+/aC5E9FJJUxsaK90th3g4gn7Je4safMMWi7vjQoEHly9mvSeWf8tbzEQc2CjNGnKz1gkpNVhjx0Slmu0WEeRnJSWJo+nAB361ZDVlRglYVn/PdS4zhGYSjALLEs49Sg41rNZ5Mlmi5sq6EnfJzy84CLD3svVuS0BOnlkEQXvUR/s3xBPB4IFY26JQxERDwrxfsTn5nNhbLHHzCunFDpAxK03o6D/zlW6uEcN8Hwx8Vaw6NGZvRFqEOEA5i5y47sOltaz8cvsGVJLHgTlGsKV6cwOAPRiWMDS36BjEuq7SoO7+Ga/uo0L6twVVLqJI7KZM4Bl0NQ2QTDqE0yY3JBC+A4ChnPfdI0rQAmpfuuE1LndA5Txwc9OneYEnMan424v60zOtQfz+cnpO0VB5Mtv+OnHEctmWguuO7tiqjM9EyZMblDVAVEX11B/nsuXNCi9R4P+5yyJwwLM/HKHZdiRYuynW9GGlhOdIuByrmfZdmZL4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966006)(36840700001)(6916009)(426003)(86362001)(316002)(70586007)(6666004)(336012)(8676002)(82310400003)(7696005)(4326008)(5660300002)(186003)(16526019)(478600001)(1076003)(36860700001)(83380400001)(2906002)(8936002)(356005)(70206006)(82740400003)(47076005)(26005)(2616005)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 18:04:50.3566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa1cfe2-b9c3-43ca-85f7-08d97a05a490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
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

For xnack off, restore work dma unmap previous system memory page, and
dma map the updated system memory page to update GPU mapping, this is
not dma mapping leaking, remove the WARN_ONCE for dma mapping leaking.

prange->dma_addr store the VRAM page pfn after the range migrated to
VRAM, should not dma unmap VRAM page when updating GPU mapping or
remove prange. Add helper svm_is_valid_dma_mapping_addr to check VRAM
page and error cases.

Mask out SVM_RANGE_VRAM_DOMAIN flag in dma_addr before calling amdgpu vm
update to avoid BUG_ON(*addr & 0xFFFF00000000003FULL), and set it again
immediately after. This flag is used to know the type of page later to
dma unmapping system memory page.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 57318edc4020..e47f1219ad84 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -118,6 +118,13 @@ static void svm_range_remove_notifier(struct svm_range *prange)
 		mmu_interval_notifier_remove(&prange->notifier);
 }
 
+static bool
+svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr && !dma_mapping_error(dev, dma_addr) &&
+	       !(dma_addr & SVM_RANGE_VRAM_DOMAIN);
+}
+
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
@@ -139,8 +146,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 
 	addr += offset;
 	for (i = 0; i < npages; i++) {
-		if (WARN_ONCE(addr[i] && !dma_mapping_error(dev, addr[i]),
-			      "leaking dma mapping\n"))
+		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
@@ -209,7 +215,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 		return;
 
 	for (i = offset; i < offset + npages; i++) {
-		if (!dma_addr[i] || dma_mapping_error(dev, dma_addr[i]))
+		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
 			continue;
 		pr_debug("dma unmapping 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
 		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
@@ -1165,7 +1171,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	unsigned long last_start;
 	int last_domain;
 	int r = 0;
-	int64_t i;
+	int64_t i, j;
 
 	last_start = prange->start + offset;
 
@@ -1205,6 +1211,10 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 						NULL, dma_addr,
 						&vm->last_update,
 						&table_freed);
+
+		for (j = last_start; j <= prange->start + i; j++)
+			dma_addr[j - prange->start] |= last_domain;
+
 		if (r) {
 			pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
 			goto out;
-- 
2.17.1

