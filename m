Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC31EC624D5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCC610EA8C;
	Mon, 31 Aug 2026 18:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v7lEO+K5";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D2FC10EA45
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X90cxZjGt197eXXJOiGNV4XU+GTumHQkFlot1k9ysfXd2rdRngrlWu79BDnLA2pFTvobnoQeaxnMpTqw5rR2d/iQaVwmuzRRgT65Kvss4c0UDm78gpdvJ8U+QxNMMOMvSN/JhU/pjgsgXuHZfykprmmgUE++IuUGiny9s7WEEPL+UVE+av0OYP9b5CHySgkl1fg2ATmUkfOSVvRQ7MggBUzQ6VfZtJsf97rDxJB4NdUmv24ugGCZpjQQHNGPwJdRfvs/EVZiBbTZx/ii/wIIoAE3NE0CMqTC8hUFjUtmBml05LQwFFhoTk0qt21bItPyKj/L00lJQ7kmQUG2PKl6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkawUl1wUsD520bDKoHRRY9usEeGFempzZ48T+qjkx4=;
 b=UdBGxU6FRzlbZ59olTzO1HgtAs9Fo9aVT01jVJnexsxRKMYxbsmgZVkuxnNjqGnyelh3SwDigSOg5ehWJL5rtjkU80FJjyZ8tgXZFcxLE5Eow004I+mhXHxEVyAvZPZK/Xl54Evj84VALxUzCPZWL0Zz4oO8nCFCPawcfFeUa1tdh92GtdPdP9MNDPJqqTaF+GLB8mBVnX09Q+5+u+1G4Gi18BN4DeGy9nQl1tydR08N0E2KFhwnD/yAloOr8Y9imDBbB4U52QeJImqhdW+LDny4k1pqwOvFHYtNLmTulpU35ZjfDrKu0tUiI8wnN5BU1/Z2DJR9USqjWLVj6+zShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkawUl1wUsD520bDKoHRRY9usEeGFempzZ48T+qjkx4=;
 b=v7lEO+K5Eio6nXovA5sxKeGEmZ0jXL8IgKVDeVbIK3IimggX60aKqOJZQhx3Xbqx1BELVbdcFDuXm19GilVyML9W5MsfH/iLsQk87bxtAy27yed2L+Xe+DcUm4d/6AAGBVaySF9BO6sc9OxeMa8f46Sca62GH64HpP/mczXPzVo=
Received: from CH5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::12)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Mon, 31 Aug
 2026 18:28:46 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::94) by CH5P220CA0008.outlook.office365.com
 (2603:10b6:610:1ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:33 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 43/95] drm/amdgpu: UALink use LSDMA to send remote interrupt
 command
Date: Mon, 31 Aug 2026 14:27:02 -0400
Message-ID: <20260831182754.1089811-44-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5ea9cf-5d22-415d-e1f9-08df078db17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|3023799007|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: prBWJm0zhqmMPeLqAo/U6eOnl7PM85KPZHGkC3Rk+wtouzNhGDN2YzoVgL/iyAjmCbAdgHIJfjiagYQvPJSVZVuITPJOfi9Gs8CGASAaBg9Z/XJ5d8DYCltABuLbxpcOL8/nPWHINm5osGZsS75fzthUWqcly/EoxtHJax2FzJ4devaS3zM9/1JtW1ZxS9fwZFb+blJxbDgYiwUaNwNzSJ3d0jGSa3Asu9YEiZquFmm7WaTo4obHk6+JkDcl7VkYBxfNsBXuEoe52glFt3NHjg5MzNo771/f3LaapBzrNXqKMSDUrJHQF39FiNhwkAwvRZwj7q/nvEMNAIbyHdgvrvpdwT3iYC4GRgpGPmtznOrkTeDnwNYTAZEQs5dU2Q8rQ6Wl/1p7Ekoj6kI8nzjVBHzydNWzLNwtmoZK3wQyQ6b8qRG+gysnhF/NjZEbzaJcXgoK2xrzR0fdG8kXR98SFY+ruxqksHrHH6Ueug66NzaNGHoArUUhuQbtMVIcHzVWhaO40bh3mdaWd707OQjN9eP1+38f892YK3BsHnxh7as5UUGegqSYLfe2lkebOB01D71MKtbr79X8EN0nCcfr4TqzNuHU3RkIBxfSKqb8ezoiUVCO29W85cd6M/IMXZ/xxnfdG6krp5/+Oef+n8RY4ucF11PKgHbo3lOgoFsQoFz8clyQUXY8EH7F1Xhu5FOcTueYGfKliElThg8Ap/uBdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(3023799007)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0SZ+0vKGfsn93USqePTo4H4z+lf53EovVeCL+CSUchRnL6suUvxpKd2b8/sHTr5j4NB3M3Co8KI83YLkmmbQJdw6r596KSqmcMb3cHeo94UbM08iX5gjfl/xImXzJuwkW0liyjoHcHBku2g2yU92kro1eNMi7mZoWDZGlwhM5ZPAZUbAW7PjqEDaO3nabW0/C4F85vi+uZJb2P5Q6N3DQNU/+fKBZpY/eGeCbTvY5alf1jzX936lrWdqm6drAoel0Hf+INCb+eavgnNDj7mojZjWaAkDUBnsUXPTyG9L5Kz+X6sO66hkdSJhL7194PO38b9siG5aoXfY2IkC59snfGD8Y/qikLQ8ASlUHaVesmq2fw4Apg4/7o6vQl5OLGlCWVz2ES9qoC9W97GlqV7KO95cQX3+Cht5NywE+ib2SVosNioMXlw1ClVWVacx0D6M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:45.8862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5ea9cf-5d22-415d-e1f9-08df078db17a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
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

From: Philip Yang <Philip.Yang@amd.com>

Add a use_lsdma flag to amdgpu_ualink_remote and set it during SDMA
entity initialization. When use_lsdma is set, use amdgpu_lsdma_copy_mem()
instead of SDMA IBs to write the remote command ring data, wptr and
doorbell to their respective NPA GART addresses.

This provides an alternative low-latency path for sending UALink remote
interrupt commands via LSDMA, avoiding SDMA ring/IB overhead for these
small NPA writes.

v2: fix 32 bit build (Alex)

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 2d2b1b1145cd4..d424c71905ff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1400,6 +1400,9 @@ struct amdgpu_ualink_remote {
 
 	/* remote GPUs ring buffer, read, write pointer local copy and gart mapping */
 	struct amdgpu_ualink_peer	peer[AMDGPU_UALINK_ACCEL_MAX];
+
+	/* use lsdma write to NPA address for remote interrupt */
+	bool			       use_lsdma;
 };
 
 static inline struct amdgpu_ualink_remote *to_remote(struct amdgpu_device *adev)
@@ -2073,6 +2076,8 @@ static int amdgpu_ualink_sdma_entities_init(struct amdgpu_device *adev)
 		i++;
 	}
 
+	remote->use_lsdma = true;
+
 	dev_dbg(adev->dev, "exit\n");
 	return 0;
 
@@ -2656,6 +2661,20 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 	dev_dbg(adev->dev, "dxs_port 0x%x, doorbell_npa_gart 0x%llx -> 0x%llx\n",
 		peer->dxs_port, ring->doorbell_npa_gart, doorbell_npa_gart);
 
+	dev_dbg(adev->dev, "use %s\n", remote->use_lsdma ? "lsdma" : "sdma");
+
+	if (remote->use_lsdma) {
+		div_u64_rem(ring->wptr, ring->rb_size, &rem);
+		r = amdgpu_lsdma_copy_mem(adev, src,
+					  ring->rb_npa_gart + rem * 64,
+					  64);
+		r = amdgpu_lsdma_copy_mem(adev, src + 64, ring->wptr_npa_gart, 8);
+
+		r = amdgpu_lsdma_copy_mem(adev, src + 72, doorbell_npa_gart, 4);
+		amdgpu_job_free(job);
+		goto out_wait_complete;
+        }
+
 	sdma_ring = &adev->sdma.instance[0].ring;
 
 	/*
@@ -2693,6 +2712,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 		return r;
 	}
 
+out_wait_complete:
 	/*
 	 * poll remote completion writeback data
 	 */
-- 
2.55.0

