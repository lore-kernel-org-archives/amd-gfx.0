Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86519C624D2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 404D910EA61;
	Mon, 31 Aug 2026 18:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1RGIZ9jx";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012007.outbound.protection.outlook.com
 [40.107.200.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627CA10E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPoWuil3nAZRCDa7UNH0D3ZIcqflljuEymBaSyUErhSR58K7bXkcI3C3aBK9zgQNyCSCpkm26NI6gawY2/NdxxhWdRIKkTDkxeMnV5MFXpd5WRcROdN45QBRJZtVadjBGX0/nTYob+JnFiKFpQtcf2WYv84TeAs0Y/zbH4PyYgvNQGNRAaNtQay2ZaoG7dJE/aAI25pWKZsbrE6nkBPSXEaGDQy4v3RguoIXputloAk0FyZYw+slzcOioEKd0LsoPlePVdcheBoPmMlonfIhLPljDeLnmPuHRnzF48F5QfeOltjl/AIJvnhKt9Lc5oSac72d2UFtn+PyBIMvpNbXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExNU5wUF4hAQKGcSFMu30KWIGdH2LWeL27keK87dK10=;
 b=KQLOc8WW55S7j7M7XqbkQmUY54zyGr8xl2ni6n7od98iaLxKvpNnq37X4Wyz+wNS0JYn1TYWugLIQRqzADF0SKz0W6MaYhePqtHoVnlzYMZS+F3Hjfdi5orOd4lbfhu1n6mxIiVRJDioKqk3LGW66FU1FoaU/wGQAxobn3TIKjhCOOFhmTehThJQ2JcGjqCw38NSuJo1ib3uwB+ckgH3FoqwJ33SKbC4lnJAIPAPgAtfs5GejwYLEC0HqOQKpKh6GNKlj8n/mwQPDze5HgG+Xt5jJBd0+F/lRr5vQx5gmqkW4JteRoegH9gPTyG25xGUIqku4f6aE2RHlxvCMUwHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExNU5wUF4hAQKGcSFMu30KWIGdH2LWeL27keK87dK10=;
 b=1RGIZ9jxBni1NClDA3mU/PPRjXOr++SFq/+H79KHARGdzCQo2jenY6QfOjb9NudncYbNbzNKXlxKEMSZRNBnxcio6uams+/CpWPoUiCj74mJYcOKr8CTFVVriMUz+bfzQwZ+MN8qKsrIqlXeW+NVFAvgXlCzIMSpT4pw/sSD46A=
Received: from BN9PR03CA0131.namprd03.prod.outlook.com (2603:10b6:408:fe::16)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:51 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::4c) by BN9PR03CA0131.outlook.office365.com
 (2603:10b6:408:fe::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:33 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 42/95] drm/amdgpu: Add UALink IH ring and enable interrupt
Date: Mon, 31 Aug 2026 14:27:01 -0400
Message-ID: <20260831182754.1089811-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: d3342d2e-d7f6-447d-2225-08df078db4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2AiJeGBgTMV2vSuw6CYn9zliRNrWdnt4MN8uizg3aLIxDW8ombMZziDmul8ALNC1O9rlfte9D1+UMXaNsHMlK29hAPmPQHpRmLfRF9HOtN6OA54WjZXFjeJA4+SKfuLvukSpuwzdClFdsa62Jv2/ttlMKQiP3AWREjfqdH7PixDflGGpjb8r0kvFtFB+P3Iqe+afhFSKMUgxLEgi0ao0N5/cXQz/aQwvVPJetMSisgW2xXvUPWgnHHO4eCMYzHgjFygGBoxhiwcJMNEYOBzGZETDFUVfJIjga+GsoDCSVKEZBLWy/ZkYqlKgJFuQ2Jjd799X5M0el7mrlPfxr2CllbqwTFgGQiu0moMaO2JUK2VFx8nFkRKuNpWKYd9dTDYgH9Cnz27O/RiNcuq21NBEMzPhbRPy/ISOmIvI5esIwMNHlgz9VxknmJe5e5pFMWioxGVAEHsNIk0WXgw5GMS6c2e2bXu/scAraUnS1mmIQw0RjOv8NowQ2GtWPF5zLNOqhppphduTtotMlMMPtRZicUBqBCCk3rRyJdkK1E+lxmb1VUl7IgN8ezfsiSeY3pjHkae5I6NeT1e+Q1BU82Lc0fsSSwBI9yEAXXt86iviEfuXvgk6eiVXj4styoZp/TQ4uCMt4T9o6P8yayos3FJ74bFpgfOoWk27Ha5347PrfAaABIhGTTfKgBHQuG/oe9TFkhDOrZfCS+5abjx9JB0hRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eZQcNB6cCDBc1dZQCKPu5PRNqRVfh5y2j7J2+7d4OIBjREjEL29nRKixp7nA2I6opkfT2JVIxEYblMb4f+CTOpeuaZ/AAa+FFEiXfmgnB9/Rn3ne9CofxlWyEKBsTTh8FaZXXV588nWSGJKdfWoKjyXh/XQTkb1aokMdW2Asx+Lkh9M+jafuEOWbk6IlEScypu+IsoXtojr2N3oeh3w80Llf4wWJ7OvEHPcw2bpG30y+KGoo1BvhDqlhYPqytmeIjltMnTA6Yfzo/XogO4mEKOVfyFoRZasTvPxAEG+0gi4bTktxQQ9GKeIaxFRZgkk2YK145nBF0z1fxHhgIoB/QgBu2fQ7HEWaDnQZEmfMn8arCU4YfVcm66i0DsS5Wghrd60pp+JGH1HV2TPJ6aX6dBcdRCq6Noz6WqMYLVWq22SQo0VENPpN9k+uisRV2Fx2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:51.2150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3342d2e-d7f6-447d-2225-08df078db4a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
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

Register the UALink IRQ source with the IH subsystem. Hardware IH
entries are re-queued onto a dedicated soft ring and drained by a work
queue handler. Add the soft ring, worker, and delegate helper to the
IRQ layer.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 17 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c       |  8 +++
 4 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 91f1ca95ea543..dcf90a974326d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -264,6 +264,14 @@ static void amdgpu_irq_handle_ih_psp(struct work_struct *work)
 
 	amdgpu_ih_process(adev, &adev->irq.ih_psp);
 }
+	
+static void amdgpu_irq_handle_ih_ualink(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+						  irq.ih_ualink_work);
+
+	amdgpu_ih_process(adev, &adev->irq.ih_ualink);
+}
 
 /**
  * amdgpu_msi_ok - check whether MSI functionality is enabled
@@ -341,6 +349,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	INIT_WORK(&adev->irq.ih2_work, amdgpu_irq_handle_ih2);
 	INIT_WORK(&adev->irq.ih_soft_work, amdgpu_irq_handle_ih_soft);
 	INIT_WORK(&adev->irq.ih_psp_work, amdgpu_irq_handle_ih_psp);
+	INIT_WORK(&adev->irq.ih_ualink_work, amdgpu_irq_handle_ih_ualink);
 
 	/* Use vector 0 for MSI-X. */
 	r = pci_irq_vector(adev->pdev, 0);
@@ -566,6 +575,14 @@ void amdgpu_irq_psp_delegate(struct amdgpu_device *adev,
 	schedule_work(&adev->irq.ih_psp_work);
 }
 
+void amdgpu_irq_ualink_delegate(struct amdgpu_device *adev,
+				struct amdgpu_iv_entry *entry,
+				unsigned int num_dw)
+{
+	amdgpu_ih_ring_write(adev, &adev->irq.ih_ualink, entry->iv_entry, num_dw);
+	schedule_work(&adev->irq.ih_ualink_work);
+}
+
 /**
  * amdgpu_irq_update - update hardware interrupt state
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index deee64b69885d..c88431471c303 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -90,10 +90,10 @@ struct amdgpu_irq {
 	bool				msi_enabled; /* msi enabled */
 
 	/* interrupt rings */
-	struct amdgpu_ih_ring		ih, ih1, ih2, ih_soft, ih_psp;
+	struct amdgpu_ih_ring		ih, ih1, ih2, ih_soft, ih_psp, ih_ualink;
 	const struct amdgpu_ih_funcs    *ih_funcs;
 	struct work_struct		ih1_work, ih2_work, ih_soft_work,
-					ih_psp_work;
+					ih_psp_work, ih_ualink_work;
 	struct amdgpu_irq_src		self_irq;
 
 	/* gen irq stuff */
@@ -138,6 +138,9 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
 void amdgpu_irq_psp_delegate(struct amdgpu_device *adev,
 			     struct amdgpu_iv_entry *entry,
 			     unsigned int num_dw);
+void amdgpu_irq_ualink_delegate(struct amdgpu_device *adev,
+				 struct amdgpu_iv_entry *entry,
+				 unsigned int num_dw);
 int amdgpu_irq_update(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
 		      unsigned type);
 int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index d1e8f51a88b2d..2d2b1b1145cd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -62,6 +62,13 @@ int amdgpu_ualink_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	r = amdgpu_ualink_init_interrupt(adev);
+	if (r) {
+		dev_err(adev->dev,
+			"Failed to enable UALink irq: %d\n", r);
+		return r;
+	}
+
 	return 0;
 }
 
@@ -3109,3 +3116,78 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 	adev->ualink.remote = NULL;
 }
 
+static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
+				     struct amdgpu_irq_src *source,
+				     struct amdgpu_iv_entry *entry)
+{
+	int handled = 1;
+
+	dev_dbg(adev->dev, "%s client_id 0x%x src_id 0x%x ih\n",
+		entry->ih == &adev->irq.ih ? "ring" : "ualink soft ring",
+		entry->client_id, entry->src_id);
+
+	/* Copy IH entry into ualink soft ring. */
+	if (entry->ih == &adev->irq.ih) {
+		dev_dbg(adev->dev, "delegate to ualink irq soft ring\n");
+		amdgpu_irq_ualink_delegate(adev, entry, 8);
+		return handled;
+	}
+
+	/*
+	 * Call amdgpu_ualink_interrupt handler
+	 * amdgpu_ualink_interrupt(adev, entry);
+	 */
+
+	return handled;
+}
+
+static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					u32 type,
+					enum amdgpu_interrupt_state state)
+{
+	/*
+	 * Don't set register to enable/disable nHT controller interrupt.
+	 *
+	 * F/W running on MP2, which can always send cookie to IH block to
+	 * interrupt driver.
+	 */
+	dev_dbg(adev->dev, "ualink interrupt %s\n",
+		state == AMDGPU_IRQ_STATE_ENABLE ? "enable" : "disable");
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs ualink_irq_funcs = {
+	.set = amdgpu_ualink_set_irq_state,
+	.process = amdgpu_ualink_process_irq,
+};
+
+/* TODO: if move to header file soc21_enum.h */
+#define UALINK_IH_CLIENT_ID 0x1C
+#define UALINK_IH_SOURCE_ID 0x0
+
+/**
+ * amdgpu_ualink_init_interrupt - initialization of UALink IRQ
+ * @adev: amdgpu device pointer
+ *
+ * Registers the UALink interrupt source with the IH (Interrupt Handler)
+ * subsystem during early device initialization. This sets up the IRQ
+ * callback functions for handling remote interrupts from peer GPUs.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev)
+{
+	int r;
+
+	dev_dbg(adev->dev, "init ualink irq client_id 0x%x src_id 0x%x\n",
+		UALINK_IH_CLIENT_ID, UALINK_IH_SOURCE_ID);
+
+	adev->ualink.irq.num_types = 1;
+	adev->ualink.irq.funcs = &ualink_irq_funcs;
+
+	r = amdgpu_irq_add_id(adev, UALINK_IH_CLIENT_ID,
+			      UALINK_IH_SOURCE_ID, &adev->ualink.irq);
+	return r;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 58d5156a44dbc..c93ef937c4309 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -424,6 +424,9 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 	if (adev->irq.ih_psp.ring_size)
 		adev->irq.ih_psp.enabled = true;
 
+	if (adev->irq.ih_ualink.ring_size)
+		adev->irq.ih_ualink.enabled = true;
+
 	return 0;
 }
 
@@ -639,6 +642,11 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	dev_dbg(adev->dev, "ualink init ih_ualink\n");
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_ualink, sw_ring_size, true);
+	if (r)
+		return r;
+
 	r = amdgpu_irq_init(adev);
 
 	return r;
-- 
2.55.0

