Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F8FC83F25
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 16:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B446B10E295;
	Mon, 21 Jul 2025 16:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ja0U0Fkh";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE00110E295
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 16:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRLqLMAdnP08MYy3uJJzgYWcpJU30PNTC0MpiFlVkUb4xn9UsAwPjXPR/CSFhYcuwM6PIs04nGtccbBFQhbZ0eJoPfeIEh9oGKrCeTu1WQt2MATbKZ2xOQV4KlBdYZTKeTTcwXcdNKXW2yo3kv0mwT5j2/Xe2j2uUXVSQiRfiogI6lm9B37MxUIkplLAz/NZIC8ZrOGSiEycarxNzl8a/fEL8GL8sy3RjFenlmjch2aN3z9yJbw4qwDrUD4kLjYvltElttr/qRKyOfSULmdR+DNwRcTUE4hsAwI6nY9BIku63ggjSQfNiCX02alpfDbKPaWd51LWlmaPktaJyR9FtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEOfSKJbWmDmZC9oPrn9WVqtHUJ1SrDr/nXohy3Xfhk=;
 b=BKx8tQkqb4X7kFgrhXgVQcxz36Xa/w32AOMmAx5z+ldDTer4mjYtzCjQ/Gfn5J428PeYdTFij0P85YXTjr+57oYkZMMc1MIjDNXvAcJ1huxBSNb36gEDzz0x73fnXLWCr3ZaV0fu97uCMrvFBmBvOf0vKSDzI2FfXFEclu+thJoyxR6C/4i9iGn2SOK3jyfgi3xQgSe4hlQK0WCsFb3DDWXQTWUEV5FrdoiBCuHQMGUHnbWN0qi8CZps/A14vBqeVA31tBeRvRda0OF+gVdL8zyaXkd+2BpOZcfefnzxcG70qAEuyEie0v142Xt8bSfrg+1zmcZDIhUS07KTKJp3lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEOfSKJbWmDmZC9oPrn9WVqtHUJ1SrDr/nXohy3Xfhk=;
 b=ja0U0Fkhs0L1zkG9pnvwoSNYfgwFx+i9NquYPLv4Ce8PDmTUiZgYsBOXOSbRHoDzEHmdj1dg88MJxDNnJVN/Q7ve91LbOUIYvoKTPbQrqqiuvxmjCtb3GdRZ6d9stxPCDsDqoeWYgmdzqj4uh7mxCwIBB62CIMejz7DS8vPlI8E=
Received: from BLAPR03CA0082.namprd03.prod.outlook.com (2603:10b6:208:329::27)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 16:37:49 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::8) by BLAPR03CA0082.outlook.office365.com
 (2603:10b6:208:329::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Mon,
 21 Jul 2025 16:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 16:37:48 +0000
Received: from Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 11:37:47 -0500
From: Ellen Pan <yunpa@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jeffrey.Chan@amd.com>, <Ahmad.Rehman@amd.com>,
 <Shravankumar.Gande@amd.com>, Ellen Pan <yunpa@amd.com>
Subject: [PATCH] drm/amdgpu: add delay before poison_handler
Date: Mon, 21 Jul 2025 12:37:30 -0400
Message-ID: <20250721163730.7373-1-yunpa@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b59c6c7-3457-4e21-4aaa-08ddc874ed90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xuTmj9gHvY1Gpkmdv1EJCvKQlnkECJfhrCt7W3bdp9eyMUzrVPx84Vm2QHLv?=
 =?us-ascii?Q?iaUJHYVD4cQZe8oyn/pll0VclZ7ZP2r9eK8MuzSBWlCTLjBVTakqiM7Vg3it?=
 =?us-ascii?Q?GncRak/crfLYHr3ycMCvlnRarhaXIX6EbU779EqkSaO9tTYirsDfoGc6Y3dv?=
 =?us-ascii?Q?byA9G7TDMd/VRQ+VRazGB76IA0yod+wTYaFsYir6RUKGxf3/NOYNxkESoJhN?=
 =?us-ascii?Q?SkUrDtp9pRB4PAJI6NGCVgxqb8I5EQG46W3Ipm5Gs7M1I+w2andHhWEa4urK?=
 =?us-ascii?Q?7ubnA5ZlWom4mOVaU5/tWDowC5OQ7BSGP26wHXwMye+CLA9F3nu+8pt1H18G?=
 =?us-ascii?Q?2HoOBVBf8oBktrh7E1gh2/YJ9Ig+9/rw4bC8mlKX/8Ci/Aa4/u7/7vLzccr4?=
 =?us-ascii?Q?usp4td/LglIjk65dtxcgEGxATaWiuarqq/rLVCUmR85jj8ZskvwSwvrg9eDN?=
 =?us-ascii?Q?zf36BUEFVc52cyAnuEkyqCRcDG3VBo6pxD1FWf3+E7rc3dDiv36DVDXQHFgQ?=
 =?us-ascii?Q?aPLZ50exZv8e6NVFY446a1zYtfGzmB4IJ4W0DEjk/5Zw89JO2jEF1uI/5RhG?=
 =?us-ascii?Q?IH+/QipBzhjX09IuxPeiBkhler1BYvh7i/bkQLVxXGBiapIRrjqz3qE5VsjC?=
 =?us-ascii?Q?vInBHhSwr2hU1yxLf7nlx6ICQAhXnobjducWYuFjgYkTeqtG/fJ6bk02R9Y4?=
 =?us-ascii?Q?adiS4w1DSpGIyoC12Q4xcQ/Pd5bbbrlAxdgfrVZ/OWPgADC05950wr5wHd41?=
 =?us-ascii?Q?/xA6ooMONeevJU/FJ7Dhmj5+5n68h5F6rDbS8aKnRtz+GUNJhyRiWbhZsP5R?=
 =?us-ascii?Q?ocQ7Gb8DY2JBUgOfRZ3wLI4/3Cp+c2COhmEdczilNBsEmSzYTFqHd4uxDDAJ?=
 =?us-ascii?Q?j9gd3YTN6nnLwxC7570S0+3HDp7KPu+lr1RhKxcvW9aJWzaHpqhuO2aHRbve?=
 =?us-ascii?Q?GvdPawkvVBYmQmPK/T2k8rvIJ+pXZf85db2ean8yj63KHBEEDcPJkidwkbpV?=
 =?us-ascii?Q?2ViejePYv53OU/7MqzAOUBXiXQK/JAMbF7UlLjOioc/98HYYoiqHhvQrHf2i?=
 =?us-ascii?Q?Na403KwjoBPcmfmubCTOJavIdJbU71gPWDyRWbi3Nyj7z3jS/tHpkY666nuE?=
 =?us-ascii?Q?XUGHyxWlljrhxrt7Mk7WZPVFg0l4EA/w6TNT0KY+z0NQ9cgZz5b67O3D3K4T?=
 =?us-ascii?Q?MGKnAxBHPsUYOpQgwTNka1t/hu/9KjRJT9SK2a6mai3C0+zKWwCb43RcDllp?=
 =?us-ascii?Q?Uw6xO2Lqs1SkWyQ29XC9k3aPVFyt5HDQ2bh1k9AzShTu6d3X93S+HIP+XrMP?=
 =?us-ascii?Q?Rcc42Kv4UQgq5yvplnT/hkPnZ7ufHLaypiSClcmxWlIsEzYL1D2BzVAxtn8H?=
 =?us-ascii?Q?Cg247eZ6xv9bv/Z3zfkRN5CAxuEM3KOtz2fn+0Xkiy4kIYK+o6zk4sEHlI61?=
 =?us-ascii?Q?C42+DfhLLiyAFTVJCHRrdVaKdaHzFVEwDSYoaJVIS+NGwsJBKOldzXazbRPs?=
 =?us-ascii?Q?YTAmcII34wOCry7WzG42/9ubGtreh4FuoNyD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 16:37:48.3453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b59c6c7-3457-4e21-4aaa-08ddc874ed90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090
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

When a poison is consumed on the guest before
the guest receives the host's poison creation msg,
a corner case may occur to have poison_handler complete
processing earlier than it should to cause the guest to
hang waiting for the req_bad_pages reply during
a VF FLR, resulting in the VM becoming inaccessible
in stress tests.

To work around this issue, this patch introduce
a delay of 3s before poison_handler msg gets sent out.
This way we make sure the correct processing
order for both poison_handler and req_bad_pages event.

Signed-off-by: Ellen Pan <yunpa@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index f6d8597452ed..64e631c996e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -499,6 +499,9 @@ void xgpu_nv_mailbox_put_irq(struct amdgpu_device *adev)
 static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
+	// delay 3s to make sure any other intr is properly handled first
+	msleep(3000);
+
 	if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0)) {
 		xgpu_nv_send_access_requests(adev, IDH_RAS_POISON);
 	} else {
-- 
2.25.1

