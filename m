Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7131C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 10:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B5061401
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 10:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92B5061401
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCD96ECDE;
	Fri, 19 Nov 2021 10:17:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C03D66ECDE
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 10:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edNg6OadqCYfXKndtuiDITc8JyhXmneWmqX0GOUopTHomvUefOqowCGr0ana6zdWc+J1m4AtksfdEfndxJXhUGxMoZqDBpGkpfUglizIyHEqJFrsAuYhji7jKNX+JLPl/4HtcMFOw3WELEFtnN/BE/+sTJp8PFynTd2MX/KHLBgwVCCgHeIKXvzt0BPBV413aGxr6hsX7wXpn162BlDgRtIZp7Ke0c8MfbJczGuUZN+ZJTD0VjGE60SKPVNAcOTOQrdu5CmnjlNQ2UjWTJBVfM34tC/xfxX5B82GENRiGYbNn3RwE10KNew7P7zr/bKbLCj8x1LzNgo30eJFo1ZmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkkkEAaXFYux37XVBhCiqjBoSa637Obp4KThueKaSRM=;
 b=PmWpkRwYvivdJJ1WVtwlKiHT0XGS3eyGLFW3kJamCc1dxXtOTvSzx+QGWE7w2u4Ltj3w9JRusMKVTn1Gjhv1SwVtdPT/fhXqGWd7qF8CU2vv+v9UawUnSy6LzhOyty+ciE8JJlG7m9c7Hz5RBKiY21C44MrOCPOZXPxnmDzVCfJYQCt8q3WrbtlIJkZ4/QLJByoC/3W5W8wR0yN8mjlgsqDEeQitme8HqXXP3KMaNLZAtclUqVBxLMRO5KHxSt7tvh6MPReQggR+/dRwRC1JFzBExJ9wnCVJIf62YN9lZ+bT/VKtSqU8Ll3YRUGE2N1TZax2KM5dS3nI8R0ia8p9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkkkEAaXFYux37XVBhCiqjBoSa637Obp4KThueKaSRM=;
 b=eI90Fyy/6v/KtbSLzNv8XB2EAM2tiBSLw0cl0z8SHaMEPuFwMLBbtajAm3nGw9PORsfXZuovONSJsz1fiwp3YadSdzyG8O4/qfEn0kuU5dNuxUxSj8fAf/YXzF/NXWz+pWrZkYG3ZIXGSDX0AUhqkQrYFfLi3OS/Ct1iU254+BI=
Received: from DM3PR08CA0003.namprd08.prod.outlook.com (2603:10b6:0:52::13) by
 CY4PR12MB1813.namprd12.prod.outlook.com (2603:10b6:903:124::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Fri, 19 Nov
 2021 10:17:43 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::2) by DM3PR08CA0003.outlook.office365.com
 (2603:10b6:0:52::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 10:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:17:42 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:17:40 -0600
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix double free of dmabuf
Date: Fri, 19 Nov 2021 18:17:25 +0800
Message-ID: <20211119101725.66619-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc8ada75-fff9-40fd-2322-08d9ab45d2ca
X-MS-TrafficTypeDiagnostic: CY4PR12MB1813:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18138388064EF77594D76CBD879C9@CY4PR12MB1813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YyTUiaQOy6dw1SneUPhjD9BRm5CwlCQBH6o6UQSasC7K3npflxV7D5kAMoNDUtlIQiPtxnHd2M/hQxtMpgyRYBH90eoBZAspUxG707HM70oH98m7QVbErFWuydlBSByqLs1P+zIML4eRKWP8qIslrOsKDVOVurjsJHYSRZqLFdbnFzaSJs+099Hw8GMbqjDtSPcJhG77qEAMdm5fb+wJo2uf+5jFg5xvZ/TBTNp8wCqqu5/zgiRxIMPbvA6u6vJL3VgVtXy6FN+OqNdHboAe7NgWnxAq7O9ROJk1LwNxstoX7nXOebUWtPyQKyGVa5Q7WoJfkTxS2bviMzXtgUPvz/BcL5poQFCAjSCZW3mx/wpiHpD++hfMfK45TCEIXtxafDYnc0GwpvzLnN8pU/EmahxqiwpuYtVcfiStRCwF9W3rmbul6zgX6dusbUQ0ypb6qo6el6VJvjP65mbamSQvCTIYZZ9VMi8M/QOMTVgFenB2XlJBav+aX3g93HItdyWABHOZPC5N00wygULBEaicgS6AckGuh/LpaWtSjlTTGmXMmSmSX+70nlIcDvh/fxPd6NAHyQkLVSrIn4en2GR4S+mwmWdqfmGLgv3NI9VUzPi3RLFaq/xs9VaX08NP775kpCO+lpJCSfddVSjtt770P47pRa1PUcaNLfprpd/fzcKl3yYVogPoCGkB6wXRzXrekhNduNKQSFD4I7NI8BR9HlCq6DnzcHbnSDZq6w8vz/M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(2616005)(5660300002)(356005)(6666004)(81166007)(336012)(54906003)(70206006)(83380400001)(7696005)(82310400003)(86362001)(316002)(8676002)(6916009)(16526019)(1076003)(26005)(508600001)(8936002)(186003)(2906002)(70586007)(4326008)(36860700001)(47076005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:17:42.6312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8ada75-fff9-40fd-2322-08d9ab45d2ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1813
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_amdkfd_gpuvm_free_memory_of_gpu drop dmabuf reference increased in
amdgpu_gem_prime_export.
amdgpu_bo_destroy drop dmabuf reference increased in
amdgpu_gem_prime_import.

So remove this extra dma_buf_put to avoid double free.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 6c6d5d994b5d..0f68d28e002e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -665,12 +665,6 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
 	if (IS_ERR(gobj))
 		return PTR_ERR(gobj);
 
-	/* Import takes an extra reference on the dmabuf. Drop it now to
-	 * avoid leaking it. We only need the one reference in
-	 * kgd_mem->dmabuf.
-	 */
-	dma_buf_put(mem->dmabuf);
-
 	*bo = gem_to_amdgpu_bo(gobj);
 	(*bo)->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
 	(*bo)->parent = amdgpu_bo_ref(mem->bo);
-- 
2.25.1

