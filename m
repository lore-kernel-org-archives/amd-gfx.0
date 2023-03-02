Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5B2C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 18:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B39A10E133;
	Thu,  2 Mar 2023 18:16:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0EE010E133
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 18:16:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJi5qyKbX4b7ls43VCKsP6Sy2Cia/rA5CqpSADVuje7Pg+Bu1BF5a1pDY83POBRcveMPi7RUFz1bRzoB/PYD91FdywNPRpLZV0kOE2ukomITuahbUaPRkrGK7AJp8bdQ1wyzMirXWYX4t87XbWo3GoSGg0bTHXNi3CXbtVhjFW1bdv+Y7houRXziIBaTUeGhmHyrQkFDbTw6KP/tMJCbVY/gT6hA9OiWKKEzr7mAG/WaqCQxTcPmBOomtunwicuxtQVjP7nS9UjQBM7dAUvyldU3SI1XDZ6lZfus1J/mCk3pUtMHlbmOOZqzI8TpVDphZpd0ctj0cQ4hY8hiqMvDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eapQV0LFBc5iid6fqVHrLK0RC37CitC4TewDwlamSDc=;
 b=M0+W28vY1S1cUNhahinlhj7HJ4gNCIwy0xmTOvkhFDq/zI7tBE8FF31yAtBxJsp5RfpdXxBBRGgnEdeqIpLHdvDX8CLVzZFq9O9h+xFbafGiOAHO9iMUIsPNF7BfyG+zpqa/MGT+KWn5cdRG0C1xzbWRwb+c0ZnB9jg90gbJ//wEEF0o/esIapsREdpLjodzsLhDSM3d95E5+5JugkpPx/jT2cy2i9RWWlpK6X58fXUqXKzC6G5gryklG6zfnQZsinOGBxg/0mkSCt2sqC1P9z7MxrIfWjQaWAaH0HtR36pgKGBctGHCztG0Whd0TzbOHwCBR7NgE/8VdD02wlRLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eapQV0LFBc5iid6fqVHrLK0RC37CitC4TewDwlamSDc=;
 b=RUdEp96PpDkRZMs/Oej/4GwPBwdKE6odBtqbsi1XXgwaLa40PSttBk30gmNQCe2AIAZe2t8L0ewlqG0Bj3SuVGyzkhr8LUY8e+Cb9SPY7xhd5grcfa3bU3GDt2b/ieQ0eJcnsk61Ouv3hr0qW3z4fWGBdQENEms3se2HO7TSd9w=
Received: from DM6PR06CA0010.namprd06.prod.outlook.com (2603:10b6:5:120::23)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 18:16:10 +0000
Received: from DS1PEPF0000E64A.namprd02.prod.outlook.com
 (2603:10b6:5:120:cafe::e6) by DM6PR06CA0010.outlook.office365.com
 (2603:10b6:5:120::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Thu, 2 Mar 2023 18:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E64A.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 18:16:10 +0000
Received: from Devmachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 12:16:09 -0600
From: Gang Ba <gaba@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: avoid restore process run into dead loop.
Date: Thu, 2 Mar 2023 13:15:55 -0500
Message-ID: <20230302181555.10796-1-gaba@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64A:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 2359739c-eb8e-4018-5865-08db1b4a3319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRYUF2Zm5yRU6eM1nyeEDra+U3OPvOU2DrtydiMmRwhaYxPyE2UKtUlGGU+5Ehc6JjHdwRYm2oy+ohCLC1pN6RLiCH1zI5wHmMnPckn3IRgy2CLIK4RJHLbTvObzBzRHWrvxQhr4fhvk5xdqBXOfNO9MCI/95gEui3d6wDgfQlULjDCvxDxe6B/6muiMcpz5mJpxlUWxPzL2WglV7XcJTH3GXqxOoMIWP8R9G2HgkODu+cLXXIczUqsGmKUm8I389GZiupXivlXrf6giWz0OrMTYD2OLYSSeOjYgxjWj8RzCr4HjXqMCfkCOw+U7HD/l3GEkCyi1++iufKjhrLN3mfi0Ic3ddjC9Ac5WO582lJTvikCuAcEF18rC+zsOpPmOPeSbnpSGMJt+v5AZg/H66pkfIlrLtlerWCvMVkxZpVHOQJTmh/zaTMx2w9gDZkZPrP44e8N5j1Gz3eGYG51oYj/00AdvyEoS0o2RBI/Jaimc+OKUGTf1QYE77jSSCIz2DWDPIWCGbcymHv+JSoLUvSGBsTksZau5AsjR56jO30Ff1Tklc9+wcRofEeZSZB3u17wspvc459eVEjaqkxi03jw6/4CtMa8X5QHQWPp3wK2etTMAIb3pxpozAPG3qohpXOjlrGlw0QG5QiCJ6O30WnalEWN8dhrb4Hrty7T7AQ9O+XtCGXKO22zBbgOXETVsZZF08/nVBf7jq7ByQCHBtraPlUN3EzFd3oq7U8htTGw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(356005)(70586007)(70206006)(82740400003)(36756003)(47076005)(478600001)(40480700001)(40460700003)(7696005)(316002)(6666004)(186003)(26005)(1076003)(2906002)(2616005)(336012)(16526019)(426003)(82310400005)(41300700001)(36860700001)(8936002)(5660300002)(81166007)(8676002)(4326008)(6916009)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 18:16:10.1104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2359739c-eb8e-4018-5865-08db1b4a3319
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In restore process worker, pinned BO cause update PTE fail, then
the function re-schedule the restore_work. This will generate dead loop.

Signed-off-by: Gang Ba <gaba@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 4b46b936a804..a38be83e486e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2586,7 +2586,7 @@ int amdgpu_amdkfd_gpuvm_export_ipc_obj(struct amdgpu_device *adev, void *vm,
 	struct dma_buf *dmabuf;
 	int r;
 
-	if (!adev|| !vm || !mem)
+	if (!adev || !vm || !mem)
 		return -EINVAL;
 
 	mutex_lock(&mem->lock);
@@ -3170,6 +3170,9 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 			if (!attachment->is_mapped)
 				continue;
 
+			if (attachment->bo_va->base.bo->tbo.pin_count)
+				continue;
+
 			kfd_mem_dmaunmap_attachment(mem, attachment);
 			ret = update_gpuvm_pte(mem, attachment, &sync_obj);
 			if (ret) {
-- 
2.34.1

