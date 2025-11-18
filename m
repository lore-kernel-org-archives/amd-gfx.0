Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35EACF2561
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 22:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5417310E162;
	Tue, 18 Nov 2025 22:06:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hBtEyDPj";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010021.outbound.protection.outlook.com
 [52.101.193.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA51210E162
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 22:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZ4UgsYpf8iB9VwzcweumKi5krAnVN9X1l1OrtHUVX57lrJBqgGupDf98/ti9uFqwZAjgATyzvX6UgeClqZ5KqMpWn1mny6+uyubmXGPvg50wNZ5cNKljuxkx5c+inoFy6NdihN5/5cVhTeUopaKzwnYJ1g3pBZ26jsfLCUkjFha6cxBlKaS/Yz8CiqufioYlTUdxzdGFgr40dBK0db+fS9dWDS6n2SiHXeWac8GVu/TAVdWzs4duDzYC3HL6B/XRbwcjfv2qsrTsUNDhQh4oQ+br5M18iaVH/2+UQQ3h3LeXVtaMQKXLOvgqf/7ooMYqu7rhpa48FdESx6oIQOhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt8zcFO4RvrYaP7cjaZKPWhJ0DAMIo9rc4bocyyDXFs=;
 b=s+ZpX1fRj8Ve04ABeOzjr0RlddZDiddcHmpDp3ccUjF84Hv7tsFiKFlI31Cwf9QQ8dM5VA4ag0A+c6YbXpTnwR++NAt5Ar7sz83Da5GW8672b07TvhvCcQCO/a6LshxkTbeov8I0oM+SvXY+lGrgqjdoJNOvCeDg/TaccBd8USGycSKtkUUO7P3QLNeDeTiNy+wtR/PKltCyc6loSF4Wj/wiVUjkn1L0Ws3baXXq1H8l9P5tlqFqbaHB6m1yo+LjQss9Cu9O3E0CsvAFsdt2Xmz1D2dDF4+58ZmvciY3DSjufi8RAqivzV9u2FPg3j3h73ayLll4+7UPk2HSG3sWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt8zcFO4RvrYaP7cjaZKPWhJ0DAMIo9rc4bocyyDXFs=;
 b=hBtEyDPjouWa2rq0lMiPxty9bfrY3nrbJ36k2rNJp8xG4ExAD3D/iIo678D5NfA8i6PMMK16kyX8Ghcd8z2dn+mQ21elTMC8aKQ6Q4F062D/6lljq2CyyOn3M3/iVtbiUHLdxmADzQFQicmSR5p29Qe81d4DZ9N1yCvCmsYdft8=
Received: from BN0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:408:ec::26)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 22:06:51 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::64) by BN0PR04CA0111.outlook.office365.com
 (2603:10b6:408:ec::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 22:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 22:06:51 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 14:06:50 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/gmc11: add amdgpu_vm_handle_fault() handling
Date: Tue, 18 Nov 2025 17:06:35 -0500
Message-ID: <20251118220637.3594610-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: e9312efb-e35f-48a0-3280-08de26eec6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V5mIUrtLzGENJZnswegPihbEp9tBWMZHqbs2aT5d5H9xo9YsoMOA20Q8qaYS?=
 =?us-ascii?Q?vteFAI0sit1M2myfT6JaS0nISx4QzI15Ge88RD6o7t6ceEgzpGv2Mx8crYCt?=
 =?us-ascii?Q?+tk1v+sHbgGmH1/cSMzbu1eRePmsR1H7Cjr5NHJetPlgA6zWI4hwwHeXqsIm?=
 =?us-ascii?Q?JTSRhLlcZKsAtI+VTpoDifxKRzZW1uQQKQAU0IllQ7Lak+VBhQ/KCQ9X60Kh?=
 =?us-ascii?Q?6SCSu4wVjYC1/+lOG5BYHNEUGG2+85+By6AfF2FXnlPKrVkLL1WjXtC/s9B3?=
 =?us-ascii?Q?yz2cgJRbctGMjHxEqrTV9VtGuuPXcsCNJtm+NrArSEagiMOFPKbMpHzDFJXA?=
 =?us-ascii?Q?mWo9BQXUM6g/E1GnzHra47v4hLtaUz2mgp8roD5sow08SkAwK/a0j+cgZjH4?=
 =?us-ascii?Q?NFd6pHWQzKCZKbw48LUL/UNRO7xq++50t0tS30axCFLLngaEp2LJKCxiOnoJ?=
 =?us-ascii?Q?u9nbslHQp9evgEZruhVqfvHVil1pGx9ObCxNcIC81V/vZl+RrOQTByga0fxA?=
 =?us-ascii?Q?PmbhJfxsv5Hk97zFGt3IpkdqxHrFflp1aoiyXg37vwqQ0nElUiWqw2oMeLLL?=
 =?us-ascii?Q?5t0pl7gNNTAWpcoY7SovLlPUzq7ccpjOUB5z0Nny7XHKJ/7l6Yhhj2J3NVku?=
 =?us-ascii?Q?Q8pd3Ka5ig1B/RfVJFrjRLLRSaALZYk3g09r/C7qyCS4SNJ+pNyP4kG1tKpA?=
 =?us-ascii?Q?fzcgtNfSiDzMFfgffH8Q8z6bWHLcG2FE8pdajoVNc341eC7C5klHMDztuxyn?=
 =?us-ascii?Q?5WVzLBgsKyzw5QG4DVAIk9vTbJ8tZD2ifMv2T/B+fY52FBvn7SD1EP3Qtagp?=
 =?us-ascii?Q?mdDRbhbp8V1E3d48EduN6qkmlQ44DwGj/MU1YruzBx983Zo/xGSViXSRu1jn?=
 =?us-ascii?Q?KTXKxEwgX4Yhz/SXLoNErucMTnE472lakrE2HQiqa48H0QbHBdo4NgYrHXpZ?=
 =?us-ascii?Q?/O8ds9pEYVVosLOGcq1eNfW+HVNLbaqQ3UhxIhgHKrfj4g9do1YCVOmeU2bu?=
 =?us-ascii?Q?QnskswREZL0+USMIMNP2NpZwN4fDOTM6N2phoeTr1tvaA56lpbDnXvrGLsMZ?=
 =?us-ascii?Q?kpQLOpDoQoviw5aVIFuWCk3Hr7t7nzSPco62xPDiJjRSHs07o2CWIf1ZWY1y?=
 =?us-ascii?Q?80sCZYvDnFQSrKAAP35GMhorg8NB67phaNxVDDovLbiqYl+uQ29fPvVWG55e?=
 =?us-ascii?Q?J1e2pXCN1ouCzKHSv7VzaE6uwkQAbRQTAflPs7GplBEYPVTteKkkIMIyEIl7?=
 =?us-ascii?Q?Vnuh9Lj+IKle1LQLbN56kNOEF/tBQLs4Lv/t3o9GAXpKUNVq08CyT1YYe2Gs?=
 =?us-ascii?Q?tfdLJ/0ET6hacD5SoiKXLI38PQyVp40/fF6JU9/ZuZth37CSIMr8rm9UMYpW?=
 =?us-ascii?Q?hyseTa2o1+nWkmbRluv3oZQuFgws39WHK5/p6815BJzUKKAy483HK/C3KYgc?=
 =?us-ascii?Q?Gtk+sN+uVv3uzQX3wfcxUGtdGHppUepS76/jrxtt+i9pNjcqpMlykHk5WfsH?=
 =?us-ascii?Q?Kc/liaq4305tLSOmd8qCr7URNOzkmbv8cTCH84L2AVj/jLnRq2rLOekfONmY?=
 =?us-ascii?Q?4tgtKd2FRUuz2Waejgc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:06:51.0169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9312efb-e35f-48a0-3280-08de26eec6ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
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

We need to call amdgpu_vm_handle_fault() on page fault
on all gfx9 and newer parts to properly update the
page tables, not just for recoverable page faults.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 7bc389d9f5c48..25cdcb850416c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -103,12 +103,39 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	uint32_t vmhub_index = entry->client_id == SOC21_IH_CLIENTID_VMC ?
 			       AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
+	bool retry_fault = !!(entry->src_data[1] & 0x80);
+	bool write_fault = !!(entry->src_data[1] & 0x20);
 	uint32_t status = 0;
 	u64 addr;
 
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
+	if (retry_fault) {
+		/* Returning 1 here also prevents sending the IV to the KFD */
+
+		/* Process it onyl if it's the first fault for this address */
+		if (entry->ih != &adev->irq.ih_soft &&
+		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
+					     entry->timestamp))
+			return 1;
+
+		/* Delegate it to a different ring if the hardware hasn't
+		 * already done it.
+		 */
+		if (entry->ih == &adev->irq.ih) {
+			amdgpu_irq_delegate(adev, entry, 8);
+			return 1;
+		}
+
+		/* Try to handle the recoverable page faults by filling page
+		 * tables
+		 */
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
+					   entry->timestamp, write_fault))
+			return 1;
+	}
+
 	if (!amdgpu_sriov_vf(adev)) {
 		/*
 		 * Issue a dummy read to wait for the status register to
-- 
2.51.1

