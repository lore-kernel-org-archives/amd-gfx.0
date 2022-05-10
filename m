Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C6CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 04:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3427D10EB6E;
	Tue, 10 May 2022 04:11:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A0010EB6E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 04:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMkRtkHgiOMNT+3YwcWkwE1K7O1U1+fVXoEkjTUXaU+NQYqMdnE2y2YkBbz/WhB39lpTLQNNYGGc0BRZl1P8dj4Zjq/0mMs2UKxfPuMlBWs4Gc7oPM9DNHS712sw9AZE9LmudE7sBv86UH+BpiJ0YZ+1mcd6j3HoDSxQxmf74BtUmQUxht2g73iG+byQ2h+AOz613OeeCqCB/WNUvxzCkPA9FiyTAMeDG9fVhd+VZBwifwKbi/+h7oh/dyjRmnd3IO3wqk82uwdubpCG2ozylMguVMvm2yhQfcMyCstCzCtuI2Xf8majYNMeJEt5m/ie1L7mKWKq0WaWYG9HTIEbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1HJHAA39EGsB/pGxGyyKyBV2XPJHofVL4v2/FTb7uk=;
 b=gXOqcFs2mbGdzZikQP8wlOvPgbPT5ytrx2jP8D2uCiPtvnYGo67GBERT6ZJfrqVsQupUH0hraxjfwfXBURpDYfUbGxv3rDz+nbLCXdIG0TmYJ/M+UB7wJHW9Zx28wyPlWrbCXjDrjWCZQCST5cZ3fb4DIRSE4z3jmXdJTFAgKUEQSySujpdDqq+3pnKEMbhGaDszweZlBXQy5o1tZ+T2gHnRXtZbR885iyWSC6Q/Fnh5CKqNIjeAUn17mzkAAS+C3NHK+qxpAWK0v6+gDeZoy7mhXLI1wCBLD6agAiS5zTJeGE9RGjrgAiCsQQf+tlzLiCF/HQzxZ5hNx/tAU86ixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1HJHAA39EGsB/pGxGyyKyBV2XPJHofVL4v2/FTb7uk=;
 b=hPiVzVU76dD5aVo9A0Vu1n33EKhNXz2YHLmrbyqNSN2uHVme/xq5PEMQRLfmNgb+A3a7nmuGcJUbX1yScW+ZoVCw6APzW7z9tlQHhGwW4rq4arVduVcFYOPN2Z+Ld6w12IpjXpnuCgNyogBUGdaQ6Fejqj+J55D5rPuQVoU+bMc=
Received: from DS7PR05CA0052.namprd05.prod.outlook.com (2603:10b6:8:2f::30) by
 DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Tue, 10 May 2022 04:11:09 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::56) by DS7PR05CA0052.outlook.office365.com
 (2603:10b6:8:2f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Tue, 10 May 2022 04:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 04:11:08 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 23:11:06 -0500
From: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
To: <Hawking.Zhang@amd.com>, <lijo.lazar@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu/vcn: Add vcn ras poison consumption event
 handling
Date: Tue, 10 May 2022 12:10:44 +0800
Message-ID: <20220510041044.323154-3-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510041044.323154-1-Mohammadzafar.ziya@amd.com>
References: <20220510041044.323154-1-Mohammadzafar.ziya@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3882825-421c-40f9-c818-08da323b1c9a
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6351CA5526BED64017F4C66598C99@DM4PR12MB6351.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrrZ+0c9LEm9J/gFwOGhK0LuWmjYF2UQ8btR/U72ZgGOBBDG20hxbzLlc5k6GJe7v2tivINyuk7gGrafF2O0YGEhmM017CYoUTaPbrZY+r9EK/dd19VMASuFg5QXLGokOcwdqFbM/RHky6lNmyadKL3r29J8FdBC4sDHNSf1DF9k/qPnxQP9ksTNs1CRJlqjMCSoTipExDyt3nDgeakGap/pX4HXsmgXLwMylJj5Zuq5EZ72mrMAOkA2xWrt6dAAijK5LEgCx55rjE3hVtLKra8OqFGF+xW9mLBHujrraSKmmOKEyOd86kQSfvTwtZDj2BQ5lJebDrUKCR7SrdOh6U0z+Pp+EqhZ4S/SFfCXE5QwQMulx6lhqBbkccBYq6ZtjAin02QlbZzMXur6tkYxSocBLLWkqIkYSZJzhQ21TYwZFC49mcGH5c0V4SJEi4MhfB1LMl98KcdF+jnTsEm37QfdsTQKDankUZM9RZ6xtnrxR9+/y7571dgEObR3SvZ8TeIN273VxV4ljKECzBr19ywufks/pTAk0UCtAyZE+vgMxAYVbYs3fukZDsi5RDa7isojH6NY+tzXHGYoeaUK/idVHQFRLb/jCmKEZDbmTfoRgB7WZqI+hiw4ydgFH+PRMj7rQp9vflE6FuoHAsULUh7jD9t7PuGpBgmJSY14i+SzVPzfZGl1BybtBZWUuDj/itjBtkfj7VimLsaalwWl7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(1076003)(81166007)(26005)(508600001)(4326008)(8676002)(54906003)(36756003)(70206006)(47076005)(426003)(336012)(2906002)(70586007)(6636002)(5660300002)(186003)(316002)(16526019)(110136005)(40460700003)(6666004)(356005)(86362001)(8936002)(82310400005)(2616005)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 04:11:08.9774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3882825-421c-40f9-c818-08da323b1c9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351
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
Cc: Tao Zhou <tao.zhou1@amd.com>,
 Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add vcn ras poison consumption event handling

V2: Removed default poison consumption handling function cb

Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c        | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h        |  5 +++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c          |  9 +++++++++
 .../amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h  |  1 +
 4 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 0974ebf9a9a4..aa7acfabf360 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1126,3 +1126,21 @@ void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn)
 	log_buf->wrapped = 0;
 #endif
 }
+
+int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				struct amdgpu_iv_entry *entry)
+{
+	struct ras_common_if *ras_if = adev->vcn.ras_if;
+	struct ras_dispatch_if ih_data = {
+		.entry = entry,
+	};
+
+	if (!ras_if)
+		return 0;
+
+	ih_data.head = *ras_if;
+	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 8e7aec822a1a..6f90fcee0f9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -375,4 +375,9 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
 void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn);
 void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
                                    uint8_t i, struct amdgpu_vcn_inst *vcn);
+
+int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
+			struct amdgpu_irq_src *source,
+			struct amdgpu_iv_entry *entry);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index abf5ea238962..8a7006d62a87 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -139,6 +139,12 @@ static int vcn_v2_5_sw_init(void *handle)
 			if (r)
 				return r;
 		}
+
+		/* VCN POISON TRAP */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
+			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].irq);
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_vcn_sw_init(adev);
@@ -1855,6 +1861,9 @@ static int vcn_v2_5_process_interrupt(struct amdgpu_device *adev,
 	case VCN_2_0__SRCID__UVD_ENC_LOW_LATENCY:
 		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[1]);
 		break;
+	case VCN_2_6__SRCID_UVD_POISON:
+		amdgpu_vcn_process_poison_irq(adev, source, entry);
+		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h
index f842eb0d65bb..c817061a000a 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h
@@ -29,6 +29,7 @@
 #define VCN_2_0__SRCID__JPEG_ENCODE					151		// 0x97 JRBC Encode interrupt
 #define VCN_2_0__SRCID__JPEG_DECODE					153		// 0x99 JRBC Decode interrupt
 
+#define VCN_2_6__SRCID_UVD_POISON					160
 #define VCN_2_6__SRCID_DJPEG0_POISON					161
 #define VCN_2_6__SRCID_EJPEG0_POISON					162
 
-- 
2.25.1

