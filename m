Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03B9C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5567D10E643;
	Mon, 13 Jul 2026 18:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q1n+enrw";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8822510E643
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpduoGz0ndJnLvy9+LuwzW4XwNSlCQ6QtnKWf9Avynx8+Cb1rqUWEr2EGoArR1a2wOpGpxd3fFwdheqpYOc/SJ/FxEooRLnL4FWBd4wSR47oIXzIF6RiCePAWJb2kvnn5x4u3Sq2Pe1jO1rcxeb5HtViKE3Icj8du1SWSzVo2RhnZPFsxifw3Hg8EvwDO3s51fy9g1qeC2eSbuki8xcLl3L9SjzOqdK2rNIxxZWPokleiwEZMGCOm6pCERbIqRanA3fgov6SCFtU+itOjzrZEbFMqb91z+I0a0VbXgus19DWPxxYb+7b9tNzdXQ1Gy5Pb2/+kc3mu6tezK6tPIfGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAlNZEEweTRZLaRYnZ6mCSafsOPelqnHOEfAaR/ZatE=;
 b=mcHsggF9JxAzVA31z1aka0zc4b3pWCB/H7jmw6jU/PGBTjX1PZzIYkJxNee9EnnMARgQKg/gMDEpKO0kwbI1bOBi0JfEZ7EKKZv3/FBoPZjaHIDjrIpCd7MkX5rr3l+SOfyv0DF8++pKf2EwatLJ7MEZQDe/jfoTdcc0onjZwAX9LEB28xjZdqpl+rgHWUKeUcjCmDpNQdDzPblIuuDYntArxI/8cw21SdbfAtwfv0K+utYUMhkcFNYWx2naCBEvz6B8BFIGKEaOzbAj3Z6xIMrjyISjgTeh/GeZhSz8upLXvKv1kZgOCmIRrV8KrJrtu5ratsyKQIDyldEezC9ibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAlNZEEweTRZLaRYnZ6mCSafsOPelqnHOEfAaR/ZatE=;
 b=q1n+enrwPDlA0+Q+dx9P6dlzu91+sRFBJj/mZ28itdUtyUy7BBUoa2gRy3LFrODUx3ba77cpJxEDY20r7imP67gQzRWRfO0Ub3j318ueIl5Hy7Au+xHKSVuZglBJ0PenOZdnesE848VVS+ahj/FP88PZQ9d50g2Bf65adxpUo4k=
Received: from SA9PR11CA0019.namprd11.prod.outlook.com (2603:10b6:806:6e::24)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:27:43 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::4f) by SA9PR11CA0019.outlook.office365.com
 (2603:10b6:806:6e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.14 via Frontend Transport; Mon,
 13 Jul 2026 18:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:27:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 11:27:41 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:27:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/14] drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
Date: Mon, 13 Jul 2026 14:27:19 -0400
Message-ID: <20260713182732.630947-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e148e54-5ef1-477c-b1cb-08dee10c6d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: XpJgLV8y5fHJoPSapMwHSK/MDlRptF7KAH6OFYSUZpujwBlZO6i+MzUnfiAbGAn21edMph/aI36GN53v3TXb/YsY/UdeUrU1xwg3t16djgCXvZTEkTCPziRZ9hhu7NJUTtAIgE3LDdHMWSoGgkJ38AFv3HQUxpxnsO+EoO+nwfFfZ2Pv836oo/vKxvYDMc77LxVPdBYABiRBuGogMW0qcDnlhufanOvd78sNk1zcpbZpMrxsddA+rO/ZWccd4Jcur65fDvDY0tCNmUtkOLFRqQvHl/sqiLhfAtrXM9eyKWJHkph9ka5PEv7mJVK8DLgrITwieykNZ6Z50kjPuoMBHurahYFWR+Zso3S1RI4rFf3JucNjAXJ66iDGeCLZBVjH3asw7QgviLBJIiY/vQX51mrppB/ipfrEaAoLS268wFJYCKBp/sjAF6dB3bDNoCZebvoUMzCdxjG5G4QRoriPe3ccrrW0J8/4lX7IPFNTXVCRGLWJpgL2clNAFldr70ZvIK5QKRI2UP5sWNm4y4tIyOACha8UBu5BSufERT3MwpdxqkPH1kCGsDmSBLcw73ITGWhGVMg4uDEa+orUmlZXbbP6okFTYp9C8dfeW2GHRum7++V+rsXfyPh3barCuKbw3K+0vJhpNC4dRt2F58bTEulzQoRie44KAsOX+1nyPM6/GSrIxKkhraOOtFKwpbi8Okku0XySSuPbStj7e2l0cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3GS5QLW60gKNtMRL2o/Fv72dUhiqkApXZZhFhAEwPMrNyoNCWikc/+0/jLa3OBhAXLytspHFsj6JdBQd+vLKT3Q1IVEVdBHSodkBIjPsn7atd3HejYVi0YtggRcqhxG0qBqCZL6nPFNqCVZNWRXMMm3P7PfXhyktaN6n8SVsYuF/pkiV18oMYg3dP/NqdsLYD/UPkHpiM4kBd4712+v48iXUwYHbyG4eQZsmM1k4e7GfD0/sJWT66wxHL3B5DrnEI+9N/q9E3Po3jnBvkyayiN24KibePZTltDnCxVUONMFHydkfGkmIjct+AlVbt1/1XFRp9DlODiRAtxD87Z1SRq1CaYfAk0a/S1e2BwardJM1q/tmg3csygo2mU9x5m6AxergH5KuUTydQSTwOsaPtIOuCkpHjaXm4psx+eZ3wpU39zUIYwKQEjFeSx4yafBf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:42.4233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e148e54-5ef1-477c-b1cb-08dee10c6d6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use KIQ or MES for TLB flushes so
no intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1fcc0594fd0a9..83b91c94a6623 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -808,6 +808,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
+	/* disabllow gfxoff when we invalidate */
+	if (vmhub < AMDGPU_MMHUB0(0))
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	spin_lock(&adev->gmc.invalidate_lock);
 
@@ -873,6 +877,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
+	if (vmhub < AMDGPU_MMHUB0(0))
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	if (j < adev->usec_timeout)
 		return;
 
-- 
2.55.0

