Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BBAC369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 10:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494F210E56C;
	Mon, 14 Apr 2025 10:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5AqMP5E/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2FF010E56C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 10:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQjMWhG3sJ0xT0hIOqRM5G9hRXrdHV6VsT6OZuWlat7azHePS4u/Qbv6ewrrf/pzPOTJNjWcuq52ho8jKjRoS6aeMbXH9wgX6mt+UZWZtjcXFgj2mnd4Xs13YR4whqE1hondeUiUytjJ6lCJnXrtPiVUK+0fEs6RBZxX5GRf4dU7orSWMsxqyn3yfZVTI7LxFDspwp3VY+W5sTP/fVEvrRfUEjZ2g9Z8fJayieLc3JApotuBEEN1TxalioqfJ+4iFvGCziMScvDqs5LTlu8BfuhnGraycIh6iok8IlwJ5ofMyOOH3jQcyCJJp6rFz/6w4W1lZLPSKWZciDxpStbSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cbyk31xXRPya3Dr0BtgZ+4eEHetaIZ6UcHERuYNNcE4=;
 b=som7/Z6iKlhtmqav+AQ1HiQ3M794+Yfm5Fe+QOtQF6u87C6xUBgdh8HXEDX4aRcBKw7SM4TYV+0Mm3yo/Lw2SUOyIqUtXwRA992Aw6VWHvvoUBainkH+ENwPt9csT3UeqLlHk2yQ5y1ylIRgJcYzFBX4C9cIbhE7GbD8AD/ufGITj7CbtTC7q+8S6nm8nUNLe9TmQrPa9q9KuEvd45BHiYC9W31wHk69WC3k89swwTl/RjGPtQN1CZI7L3iWJmxx5lsWxbEdlUc9ErGTupTKmHaoeCUaHqDZJiSflj55FL/YiEca6J3FC7PfvJ+o2BWx1NyOyeNwlxJpJx6Ydvkxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cbyk31xXRPya3Dr0BtgZ+4eEHetaIZ6UcHERuYNNcE4=;
 b=5AqMP5E/w6SUWUpmmRZ/msaNEBt920SJo2cokvWAQyitk7qpPoYFrvasctKjGHi+RVqBvD+GrKXhQGovFCk538GTY/BBVpW2a+7/DV59bWHE8skhfXzZrXMcY5RBG9XbYaDJYYDI6Y5kj+RsQWlViYqP+5/Rd1PGwRG/+ZDF2e4=
Received: from DS7PR06CA0036.namprd06.prod.outlook.com (2603:10b6:8:54::14) by
 CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 10:48:45 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::5b) by DS7PR06CA0036.outlook.office365.com
 (2603:10b6:8:54::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Mon,
 14 Apr 2025 10:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 10:48:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 05:48:44 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 14 Apr 2025 05:48:42 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <emily.deng@amd.com>,
 <guoqing.zhang@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
Date: Mon, 14 Apr 2025 18:46:55 +0800
Message-ID: <20250414104655.336497-7-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414104655.336497-1-guoqing.zhang@amd.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: 9542c1ce-588c-47ef-9f40-08dd7b41ee11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3bDSDfUTn2JyjYi1maLlPXpu4UTb2V7K/1uwdk0MPQqLURPE7G5CCpavIQWS?=
 =?us-ascii?Q?z1hcF0Et4uISKV6utaeKoHc6KjPDUXvymwKZkKvAM60tMKSm10rUnHen1yRJ?=
 =?us-ascii?Q?6/WaBAnB0Rl5auXA++68gbTXU1i5jhbyAHMWexEgNM49DTkWhINjN5ifre3o?=
 =?us-ascii?Q?zh23WoxfK5RvLlcUHORytATEcm7R7C/0KljdD7gO11V2vrfRMwYMFCG9IHku?=
 =?us-ascii?Q?Uuhqg60AVUqUlGfIm5znJ0WCb1pjxB1c4VSna9e/sd/NT39x7r56vEvtOv+3?=
 =?us-ascii?Q?680xnATQfDPVlUWsCZ8zVgpS5h97uDB0RDXXvhNfv3cq74aq+80a10nFIzPg?=
 =?us-ascii?Q?aM6OAae0ZBv9q0trCEylYBr4sSM8zQ0r6DYQFd0dWoCyeNV8sJh6gMeJm9nU?=
 =?us-ascii?Q?aYpiZCgDgiyy8FbfQaWGUg2MrzHjIc0aJf9OfPenCrlTuMtpEKkMozMZguzk?=
 =?us-ascii?Q?V4x4c0WJcpzh9N6CZgYt3bqIpAMtZNxQIAEX7a0t8PC94wixy3MXI87+Gu4i?=
 =?us-ascii?Q?Rq1ZTSNbJOkL6DZ/E/y63DXjTutCAFMHGyjOWAODsU/yg2YyBfGqRYIpVevL?=
 =?us-ascii?Q?0dgtP0sGsz/5PPe+R8E5cMJxgEeGaQHQPuO8Ibd7AmYRPhR2ATQTWQ6k7wpP?=
 =?us-ascii?Q?oWbkLRQxBbGRx6n+ismW9F7CDdL3pLEX9qK7+Pgi72nGEBtyYcu1PTnF6JEe?=
 =?us-ascii?Q?FXuHKuU4e8s8BadoR0cOUfpYuinny7xVAqu59oBWaCm5K0dWUztxB+qoYNRB?=
 =?us-ascii?Q?KBfMm5g1KJNnqZrObmO9QX60m+9KVBmBE2V/hORGIA3YEtrC9Tb53iKLIccR?=
 =?us-ascii?Q?q0ett2HwQlLCoASScC7EgRic8YxXrEdv1nF3jsaF/Hw7j7MMmjNIs0fR1KRF?=
 =?us-ascii?Q?JZD5bWtpx0m/pWzLPsJeM5V+Px5SqkSiJj54n2XooqhOt/zi/ZMWbhq3LWzM?=
 =?us-ascii?Q?p8DoDnTlaBM85+HqbQrIODmPB5ACgp+IjhWHwSRhsz5kZb4H2HgLCJDFawwq?=
 =?us-ascii?Q?qJXhk8njEQItRYjiSre6b7SOH7xgFpGBguCf9h7iapwCCB02vrnODc3QCsGq?=
 =?us-ascii?Q?D/9CV6+thElnazh+Eq4uJJZ339qxUl2rK+L/hcNENaKGRK1lICvn6ntLPnEK?=
 =?us-ascii?Q?Evjn1bCnhGqjP10IvvULX0MzzEK0zrYoH3p+0Al0c6JRS/k8GkZCG7YRCGgN?=
 =?us-ascii?Q?H0yrbqG/8jUDsRYfFmwhIXxmwjdBPqn5AFFGRVgRD/ft15RbtUwZ73loKiF6?=
 =?us-ascii?Q?nzGNdfuy86YjfTXzrYudu5HwPe+GNmEEnsxC9bOLH3UpIWUOluem52smoT8o?=
 =?us-ascii?Q?YGKf2Kf9OGIJ+zRiidlLrPwwtNoMhvxnu1yZS4friucSmA0IXe0SvPZE4WwI?=
 =?us-ascii?Q?VPRa9pMID+gcgfrzjo/P5mN+i0MwclGKRHB4Rad7VtdkaU2Ad5+rBbiRiOPO?=
 =?us-ascii?Q?3SlhoWgl+ask9GQPmNOD6V8I3RJXQcXyVZLJj+H6TPkVLMz6v9squyvjKIN3?=
 =?us-ascii?Q?+6yyFp0b4df22BQescqknTZ28tHVTuDaYfZ8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 10:48:45.2763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9542c1ce-588c-47ef-9f40-08dd7b41ee11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
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

IH is not working after switching a new gpu index for the first time.
IH handler function need to be re-registered with kernel after switching
to new gpu index.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Change-Id: Idece1c8fce24032fd08f5a8b6ac23793c51e56dd
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h |  1 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 18 ++++++++++++++++--
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 19ce4da285e8..2292245a0c5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -326,7 +326,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	return r;
 }
 
-void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
+void amdgpu_irq_uninstall(struct amdgpu_device *adev)
 {
 	if (adev->irq.installed) {
 		free_irq(adev->irq.irq, adev_to_drm(adev));
@@ -334,7 +334,10 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
 		if (adev->irq.msi_enabled)
 			pci_free_irq_vectors(adev->pdev);
 	}
-
+}
+void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
+{
+	amdgpu_irq_uninstall(adev);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index 04c0b4fa17a4..c6e6681b4f71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -123,6 +123,7 @@ extern const int node_id_to_phys_map[NODEID_MAX];
 void amdgpu_irq_disable_all(struct amdgpu_device *adev);
 
 int amdgpu_irq_init(struct amdgpu_device *adev);
+void amdgpu_irq_uninstall(struct amdgpu_device *adev);
 void amdgpu_irq_fini_sw(struct amdgpu_device *adev);
 void amdgpu_irq_fini_hw(struct amdgpu_device *adev);
 int amdgpu_irq_add_id(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index faa0dd75dd6d..ef996505e4dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -643,12 +643,26 @@ static int vega20_ih_hw_fini(struct amdgpu_ip_block *ip_block)
 
 static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)
 {
-	return vega20_ih_hw_fini(ip_block);
+	struct amdgpu_device *adev = ip_block->adev;
+	int r = 0;
+
+	r = vega20_ih_hw_fini(ip_block);
+	amdgpu_irq_uninstall(adev);
+	return r;
 }
 
 static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)
 {
-	return vega20_ih_hw_init(ip_block);
+	struct amdgpu_device *adev = ip_block->adev;
+	int r = 0;
+
+	r = amdgpu_irq_init(adev);
+	if (r) {
+		dev_err(adev->dev, "amdgpu_irq_init failed in %s, %d\n", __func__, r);
+		return r;
+	}
+	r = vega20_ih_hw_init(ip_block);
+	return r;
 }
 
 static bool vega20_ih_is_idle(struct amdgpu_ip_block *ip_block)
-- 
2.43.5

