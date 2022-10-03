Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89105C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Oct 2022 17:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836C410E310;
	Mon,  3 Oct 2022 17:21:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 549B710E310
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Oct 2022 17:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmvNMhNYh+R9ni79Rzjjr2F7bM3h7mHCl6JEkY53wmVBu9PO1xMixJiBRuiJqUCbVff1gg9iFGWMaZ8F4Aw8Xb4eK1U5Hd/S05uwYPA4xeasB4iURQmcHmKuUikWZNySvhMjQ4dH1E94yROzHtWOTpcsfAgYUzHyfsKbnwl1Cp9q14Mkt0kPDHoq8FQpT09AZ5EBiUv8oX4DxrOCWILV6R7IA7QWKf6g7gD18a0FnzRKtK9xKNnWwMXQePkt0TgoeKrWsJNGCk0N4SHyrRK7jmFuOzsw3qq1iJaeP0zVo7pVJx4PuLSfktgv7h5onkXlaRxw8WZJuuqcSZwIMV456Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjWHRW27dWTfhyq9dVT5fakYutRFyOMMyvDvninzhK4=;
 b=arGDjXHsqpUeJFpC7zN/yon51MiNQoACsY0VcJEnmNdBZSdsxp94kYTG98BVfwXLtuMCikZvmmMEj0v/A95Xdp+ImvVYP79HAQTgbfBtFd7ClKBAMNssdbilqo2a8FzNZHBPRfFwF+HHoXRRqRV8XP2M3GK/3GzM5QIqa9IdRlZh5Hal8DkjfhXZjHu+mYJPFTGpXL4Z+o3m1oOKwPOLty4x4zvw1bwW3vULkfSFhcsuH0H8P1FdpEiOLEaQPBcOXHYeeZyRnuQHFJgULIDD+rxO+mvkMf+RIIYFbv+EzAwSt3XuCP0Zk0OzjsJKh2hunjgPlWzhVL9AGzID93+Z+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjWHRW27dWTfhyq9dVT5fakYutRFyOMMyvDvninzhK4=;
 b=2UHI/cqUjZQC/P21PMURgQcIN279+W/Gcqoz0GS+wO/WJR7KCXL+DwuZrdvybskO3f02OwhX84DDZQzSs/8WblTCiqQF5noG0GdvLPSAErId53+ZoBoYt1VE2wXbVwVNQZmkofATZBOylXKBAJ3CmANzlsGmGQCyHAXgk9JcuXg=
Received: from MN2PR17CA0018.namprd17.prod.outlook.com (2603:10b6:208:15e::31)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 3 Oct
 2022 17:21:10 +0000
Received: from BL02EPF0000C403.namprd05.prod.outlook.com
 (2603:10b6:208:15e:cafe::50) by MN2PR17CA0018.outlook.office365.com
 (2603:10b6:208:15e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Mon, 3 Oct 2022 17:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C403.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.13 via Frontend Transport; Mon, 3 Oct 2022 17:21:10 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 3 Oct
 2022 12:21:04 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Set vmbo destroy after pt bo is created
Date: Mon, 3 Oct 2022 13:20:30 -0400
Message-ID: <20221003172030.1389-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C403:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aeaf439-6e4c-4abc-2647-08daa563aa33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRly6PG+EUCFaxvsP0XKnX3Hv9CSxcn37fI3AQzkxUCVx0EQL/C7tQrPdHgHvZOM27blnT6P+17774w33hUbjP4m++UMD+AdaaPZOj1tP93rHBpdSzVJ9RADDHEygLxW+DDOojR0G6DuOfIJ44Aa9Dyptzq3PcIPcQJ8OtgcwQp5+cohBSAyufuKG4biEyqzucDpAjWG5E8xTs+y7DWv8u+8uty+a8WV9hiMTD1GMS3H05Ru3f+Ggp0iMHqQHi8K0Q+po1QxZCmU4LolOuZ5Lk5w/HlEQ6i39h8y6dy9bWpcX7P4PgRz7VlIcbX2e93ffPeCjpc98nGNipIjMr5ksOOu3qt12uIqRCuErGRle9S+QTW1w3oWsmliKgpX6Xt8pAFhIm0rbuZcEiZ0S3r/H6dC72x139tMpA+B40fWjAFOOT35bh0Y08jik17CIryr7NsJVp0MAQLbpgI+B9F1bwYLHprYCcWxwcNqPsZYbPyuFK0JKqT7pgKkIfPTxUeHkpkWhDER+4/4D2+X7pKfnMjQ+sRluxZlWwamjiEVtiDFsuUB/0mkt6iXOR5i2IqlbIC/rdjPOKDNjzro91X6sCcWVWtsKtvr/ZC/b90Cz8Gy/IdtdUv/z+MVSXUmcCKDfRiTbwvOo5rEg2A8cZFobTg6n7ZZMIJGNtDa3rEPyznqpKwzRPddoUXlHHxPhhxV0/LK7naBqGHXbtsQMl5/gAmACjyvxYXts6R42diWohbMY0pypokBesSgbqJFLNWKVWQ7SFqxqIGkTpK5JVhmShln5Ypaj9yKdJenHTuYl4USxhsPtojDpf37FF5F6QSU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(40460700003)(70206006)(6916009)(70586007)(4326008)(8676002)(40480700001)(82740400003)(54906003)(1076003)(356005)(316002)(426003)(47076005)(82310400005)(336012)(16526019)(186003)(81166007)(7696005)(26005)(2616005)(6666004)(36756003)(36860700001)(478600001)(83380400001)(86362001)(5660300002)(8936002)(41300700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 17:21:10.0451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aeaf439-6e4c-4abc-2647-08daa563aa33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C403.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Under VRAM usage pression, map to GPU may fail to create pt bo and
vmbo->shadow_list is not initialized, then ttm_bo_release calling
amdgpu_bo_vm_destroy to access vmbo->shadow_list generates below
dmesg and NULL pointer access backtrace:

Set vmbo destroy callback to amdgpu_bo_vm_destroy only after creating pt
bo successfully, otherwise use default callback amdgpu_bo_destroy.

amdgpu: amdgpu_vm_bo_update failed
amdgpu: update_gpuvm_pte() failed
amdgpu: Failed to map bo to gpuvm
amdgpu 0000:43:00.0: amdgpu: Failed to map peer:0000:43:00.0 mem_domain:2
BUG: kernel NULL pointer dereference, address:
 RIP: 0010:amdgpu_bo_vm_destroy+0x4d/0x80 [amdgpu]
 Call Trace:
  <TASK>
  ttm_bo_release+0x207/0x320 [amdttm]
  amdttm_bo_init_reserved+0x1d6/0x210 [amdttm]
  amdgpu_bo_create+0x1ba/0x520 [amdgpu]
  amdgpu_bo_create_vm+0x3a/0x80 [amdgpu]
  amdgpu_vm_pt_create+0xde/0x270 [amdgpu]
  amdgpu_vm_ptes_update+0x63b/0x710 [amdgpu]
  amdgpu_vm_update_range+0x2e7/0x6e0 [amdgpu]
  amdgpu_vm_bo_update+0x2bd/0x600 [amdgpu]
  update_gpuvm_pte+0x160/0x420 [amdgpu]
  amdgpu_amdkfd_gpuvm_map_memory_to_gpu+0x313/0x1130 [amdgpu]
  kfd_ioctl_map_memory_to_gpu+0x115/0x390 [amdgpu]
  kfd_ioctl+0x24a/0x5b0 [amdgpu]

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4570ad449390..ae924db72b62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -688,11 +688,11 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 	 * num of amdgpu_vm_pt entries.
 	 */
 	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
-	bp->destroy = &amdgpu_bo_vm_destroy;
 	r = amdgpu_bo_create(adev, bp, &bo_ptr);
 	if (r)
 		return r;
 
+	bo_ptr->tbo.destroy = &amdgpu_bo_vm_destroy;
 	*vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
 	INIT_LIST_HEAD(&(*vmbo_ptr)->shadow_list);
 	return r;
-- 
2.35.1

