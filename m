Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381B2C624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE3610EA7D;
	Mon, 31 Aug 2026 18:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T5fBUghN";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BACC10EA6B
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeyUwjm/jdTy21fmw4GRTD/0UjVtjnkWtf1D42kkRAWX05Xf5ljtRrEsMopBWn+YlY404dM050hknkZVZHUOiTBMPifyYkdCFfePuw2exF0xf3riznC/x9ZSzrIoo5YkXxapnVCgiGdpOL6j1u6/495j14MOaRWecG6uhqCRyuP8zC0/duqsa8VmkWzHjWw0X0FqAjI5ec1SRb5nudPVL44cbDOHW5ceH8VJfj8upl8IqCxkIKxIvEGdPNi8IkKvI6OfGMu+TYFH1V/LX1BrSA2dPvq0q3jtMp+QFXE07YiKYJUgFUCDg6Btf5n2kBFacE6ERolJcpe5PJ3FaYspSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGkdEd1Cw5adPSkXqIhaVrFBCJ4CuAhoV34P/oTZs1A=;
 b=bBK2e18IqHYYeKFnBRrpk3d8YmQA5VqhBGkd7ZoBDcNM117yJzP2OipjlSl75vw2xnYuzED9Uulped6JRxUkrP3pjl818j6WJCL5aHdxis4VZTW8KPzXczHokg2hjopnv3Dt64kPZonbDNK+WeQVc73zdtEnFHWN/nJAq1f9YDWTIOpgY111eQQfPH6TGg3b2jWhqpnbsnIySdLhUmkGi7Upt/SfRClNSjL+zCpdp2KS4GPkeyA4HZ2kRiILASSoA19lySAqLEZ7QlZb6H0zjgssaQs8LR9fLy108SJ0Je/TR9NK6zE1mebQ/RuLxDsTMufufTYDK/MsrqigF7o5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGkdEd1Cw5adPSkXqIhaVrFBCJ4CuAhoV34P/oTZs1A=;
 b=T5fBUghNItAoPZPckvzPPWvaL6p2SvLOBCVxAZ2Mxkghx8MrgZK4ZOhmwMfd0YK29voM/CL+ladiC9pZ8UXYpxtnKbeawdUrXVMMxOWBAjOCDJ2MDdJ5dGpA7k7hPx64I+xnxGoEbwbPcYFIIsfwAyL+CccEFBKl6pwfkRfpwQE=
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by DS2PR12MB9822.namprd12.prod.outlook.com (2603:10b6:8:2ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:09 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::7) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:52 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 72/95] drm/amdgpu: Initialize NPA PT/PDs to noretry
Date: Mon, 31 Aug 2026 14:27:31 -0400
Message-ID: <20260831182754.1089811-73-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DS2PR12MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: e777c065-ffbd-42b5-45f6-08df078dbf94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: Y4k6cZI7MtYxyo9YdliIFAahR+qIuZIM9k+0xq0I17lldRLQDXmr2I6+Hus9rJN/KPPbkIMFEqAfkDzP5WuZYkbONDDFvRxw4iiYIpX2iVNEjj2TST2sUzgznagim7E2q0qAN6oaio6h6lnMMup33xzOJJ8mc1jSpzvWYLGbqrdIANRnrLxIPJ3U4LIrWAqqoaNPtml9nHQWWbtpctoYtMeRnTy0KBx5XB5wh+Iu6AoirWmSBMQ05R4/1f8/KZ2ugjlZ2kpbGaWMspI3SavsOuB09vdEptxXL5PNbVm1iHj5NQK/GTNmQ4aZGXEv7zXXfH3R4BUuMyRI+uQGhmthf0lwV+Bdd+Lazsb2jHUxRB/GvUImJ59d1XexD2SEeSDqrjl0NEcACi/EdkQK5e2FbS1X1GZKVbr6I4HceH/qHoNY0n5IOFuznw0cJIe6yli8G34vAGHVwggityt0rIadtjO0KQUARphx0oyoVjHZhk092iAZoN44Q9Gx+MNnaXr3v+iwjB3DEYetFqK5Dq3v4eWSQH3wpJiqZ0Je0C1k7LZXpPAfZt9atZ3hWczPmHytRQeSbG/FWuYgP/KWexks+CGYwSFDAA7StbRNDzJLD6cfinT2FBG1pLvqfiVRLcMRjGVUUREzZzoF18O/6Rd6Eaf8KEkdKt8EOuOWACg6Ju3uhDj/kutYEx1PMlpy1cGElYoCPh3DvdkLSF8NdtaJAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T2lermbWYfIeGyfnul+wCIso8/FbjZbLeNLamBtwST6/njzgAjimGcxX/jzFzg7UkliW0DWuBUJFiywH2njtWn1aaprGTpuApvY5tXCNkq14FFB3340fkdj+TNFy8Tk1y9Loio8dSTAF9/5Heq6Ab/U/fJvXDrMxrZEBE4rHJfbY2XzumUMnjhj9QPifkP7Hq57eFd1BIvKN8zbQBG/O5a+LEKK2oibyEoxUCstIGJQDeMulQs2B7NE+/6rmeL3yBjh0RFst9ZGINDCFOWfPFhasSNOKCqoMXPVl0npH2nzwTtqm+JXNLUbD8mAO99OvK894v52uAHfpWnK32SIDwEORtZ5oUKWZuy9GtDKxQwDNDnDI1vSGcOF9i+6ykPFrgOXTcGoKriGUU30H3xkx819c7xH8lp9PASbIEiNTGGeWt/M7Eu3hu/uWME7l+IIz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:09.5409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e777c065-ffbd-42b5-45f6-08df078dbf94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9822
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

From: Felix Kuehling <felix.kuehling@amd.com>

Unmapped NPA addresses should result in no-retry faults on the importer
side.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index b9831a5f85d8b..1cdf2b854f261 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -408,10 +408,14 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	if (adev->asic_type >= CHIP_VEGA10) {
 		if (level != AMDGPU_VM_PTB) {
+			if (vm->is_npa)
+				flags = adev->gmc.noretry_flags;
 			/* Handle leaf PDEs as PTEs */
 			flags |= AMDGPU_PDE_PTE_FLAG(adev);
 			amdgpu_gmc_get_vm_pde(adev, level,
 					      &value, &flags);
+		} else if (vm->is_npa) {
+			flags = adev->gmc.noretry_flags;
 		} else {
 			/* Workaround for fault priority problem on GMC9 */
 			flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
-- 
2.55.0

