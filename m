Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896E5CA5FCB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 14:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 302C010F6C9;
	Thu,  1 Oct 2026 14:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xk/mwNLy";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8690710F6C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 14:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNuly2gx7jgpf9T++UlH82uvf48SRLq5ig4/cK2y64QwLWjLbZEQph4/di0rAY+LrcHGpqxPqklkBdvkYqjgvwAeXepetZEpwuCqTbidgh6bzoRgOkomIxCMomNndXYwN+OTghwbwQV91GaCW0mU5QzuGYODa7MB1DiNcJpH2thYrfxfoP9GeXG3ONI9hkA04rE0kolqYuf3o3mJLgXXYe/etwokCYZZS7p+joQQQI5YKorgRmboce+EiPUzXT42+Uh8R54MZF1KWTqySBvBYcXpSD2EYlh+LN0lcwgs/7ynBRJ7vY/6ci6CAHpwp18gPczcph+ftqW+PZinFf7aKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlY+uhGbUVHPlM6ftUDqjYHj0RnR5SfzkHyduJrEMm0=;
 b=JTWBV7eVuQMqKlXO+f7MjEwQSBrYkuIxZ3fdmfE92Fbn57jGHp1Yi2ygS/OakmropV/aejCgsRSnXI9q1TOjilox/O2egsw8sap6WIDAr4rb+PYLZpKkSdQZSMT/dWChMpUT1jjHE0JxgPNY+aOMti7synECLzh/UstHjrLtr9xQac37kJ6cakPt0f34RKPVJbsfmUSfzobO3syBFGCsZN8JgtAyo8wHBX+0X2/r/HbIpYGMmnNii9+shamcZ7J4cNBxjanQxB7IodR2Ub3jNJGcWnEOPT8sOQg+1cfLtfIKu6Xd1FylLYKFhidHtwwVodd9eUEc7t7+U7Rc8ekksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlY+uhGbUVHPlM6ftUDqjYHj0RnR5SfzkHyduJrEMm0=;
 b=Xk/mwNLy+rfMDlE6fbK7GfZEfNcsZdJzFOlYlnrKwzYvKJfuXNK4c/0gcbifjEPflnz+z9hEeejH26n6vsE6QlQM2WkkOXda7POKbpzKWSc9ccPGaklnvGRYK8/fmLimadlUUEQYOAY35zmEYoiLxrjFo5qZkW6fcLoohM4518g=
Received: from PH8PR05CA0014.namprd05.prod.outlook.com (2603:10b6:510:2cc::7)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 14:03:19 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:510:2cc:cafe::aa) by PH8PR05CA0014.outlook.office365.com
 (2603:10b6:510:2cc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 14:03:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 14:03:19 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 09:03:18 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 3/3] wip: debug remote shootdown
Date: Thu, 1 Oct 2026 09:54:06 -0400
Message-ID: <20261001135406.4049406-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261001135406.4049406-1-Philip.Yang@amd.com>
References: <20261001135406.4049406-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: a2432f0f-4267-42ee-e95f-08df1fc4bf50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3g5SdCJ4EM+A04fOiaGLkJHsYT3xpJYRNsOudCmxdxVPp4j4f0sP7U+4W/d7gC+AFcO1PlDPpRR7ijtqim9aT162kLmlKgsDvpog9fTavR+Jihdg/89F+sVhNb7+gk2VBN0XCTUMWrrzOBHIOEWnKeyqUb1AANml5BDFxpfbTIusPYRC4svdami3FrpeStt8K3leEru/IRtOkf0x4vA/xS+tuVl99PUaJTvu/53bsRjAiWFGx71FYQ37JlV+eoCrB9EMBDN9ajXmhmxx/ZqVeGALjWbJPwNN62QGHoi17AMzb1u5is54lZVP+RB0iV8FQBu9Ci/NVmq9Iai22xxzVp/ji3h/jNbHXzEX4SOlubVzZQ3VPQ4MvIPOBtaRX+grwifMD5YPuWpNK1jLEg6tF6UMcJIB1dUknuY+RVT1vhXVni+TLxLjibG8L2MZz8zWXXBZGdNOOLL7RrlB3eJqTdEDGsHlDiUwU9V0+YADzEDOxOgX6CaVe2sDJVbgLwr1GDEPkQSGotUbWTUNVloX234XCa/RrvXA6tRt5Vp4CCxM8CnwDs5ld5X5G1hQUT61/sODQrNZAn02HcdsttU08JwbhKe7bZT8DDLrc+9dxvj5uHZtl8LXxYddarYLLr8CYrdy7CUt1u8hRZzKbVDDHZBH2RWaReUqNmOtZpz/mJo0JAf6gSsG/L2GfgHAdS1g
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9HvDTaDiM43BqxZN/KUFnCPXqUCuUksttR7+xbcrR1LXyd+/AWIcZXCjkKnaaa8Vq06FSVHRRprSGOBsw6Kk9yolrXGH4KMFm37pDwuHFBMae2GLOXWBxVq8OOwUHMbPG54k506KUoEVPhG/9oev1PFjf1U6Qle6/ZdXOg4WVTzU7LQjIGBmTHHmKeKLw3eUe47NJdMGUNkRP8iFhY3fRhiJU36iG+cv1+qcF79RC3ape0rYXo5gfIu1tYLCxFbEenKmZQQjS17JNKMRnOsUSrxTiNDK3sGYYx8pprUJMuVsBj0bvMHjMLuSpHFq0ObNdLoNMB9TO0X53Ym33/vdbyxiv10NVoPBc/2/MDTbR6CqwdBYtteNJLc5f2GyOcGKA5OQP4b+xIvKDrlZ7++GEMYfzJYovBzPz6vGLfCsHaupemzt22Tg6+wUYZlHA/H7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:03:19.2707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2432f0f-4267-42ee-e95f-08df1fc4bf50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177
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

For KFDTest testing, don't merge.

To verify if remote shootdown flushes the TLB on the importer.

exporter, amdgpu_ualink_revoke_exported_memory doesn't send NPA-REVOKE, so the
importer keeps the NPA address mapping. Still send remote shootdown to importer,
to flush importer TLB, and then unmap from NPA vm, free BO and NPA address.

The -EFAULT return makes the caller clear npa_release_bitmap, so the exporter
doesn't wait for an NPA-RELEASE that will never come. The resulting
"NPA-REVOKE send failed" errors are expected.

KFDTest UALink remote_shootdown_test steps:

    exporter                     importer

1. export BO

2.                               import BO, map NPA address to GPU
                                 access remote BO with SDMA

3. free BO, send remote shootdown
   unmap from NPA vm

4.                               access remote BO with SDMA

Test result:

If GPU page fault on importer, test passed, remote shootdown works as expected

If GPU page fault on exporter NPA vmid 15, test failed, remote shootdown didn't
flush importer TLB or RPC not working.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 3b3339c5be08..b60390ebadca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1943,6 +1943,10 @@ static int amdgpu_ualink_send_npa_revoke_msg(struct amdgpu_device *adev,
 {
 	u32 dw0, dw1, dw2, dw3;
 
+	dev_dbg(adev->dev, "dont send NPA revoke to accel_id %u for KFDTest\n",
+		remote_acc_id);
+	return -EFAULT;
+
 	dw0 = lower_32_bits(handle.handle_lo);
 	dw0 &= ~AMDGPU_UALINK_MESSAGE_HEADER_MASK;
 	dw0 |= AMDGPU_UALINK_NPA_REVOKE_MSG;
-- 
2.50.1

