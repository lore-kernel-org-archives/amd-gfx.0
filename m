Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755BBC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 20:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F7710E2FB;
	Fri, 21 Jan 2022 20:22:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84F410E1CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 20:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Raz13cy4MdiKLVkMFEwXbtHiPrDXm7lt04zKk+0ulcO7fdpoL0oiSbchMv6LJ6QbqwfgS0SJWcqszxYTr5q/xqyc69Y1XafA+YljbNpJjLlF52HcTaQJ9t/xkSxtgVIKnjWpCpAiv+rt+IDCKpiOb+VffPnHtO2yajZC1/j8aZTxj2kL8YFJlrQqXXTaRJ/aOqU6SjaQ1N08A3+viXmLgEUx8ZIO0xNnq9C/+rb/JdtyniBzfnoCmHQ2anZlRgZgOYqefAgLYc4JJ9ODgyazTFJwsU6/jOndZNC+fU5IigVA1q1MbEnjfZuVvc5+K87HplK6gnY1SUyFgLiegwYsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/irQb1+hdsCJhH+YGZcJldNPuo1oIyN+lOPXQWeA874=;
 b=c5qJSiGkZsPXIxn7OsDJwdMbunlQsgsqzwsLDzj7ZCepMifgER20gd5bolXgXq+NLbgceNama5tQnOwTMBkpLAoicZEFws1uKcM9lMS3UXprJnGBqPvYLgMoCBWK0k/X+WZruHgDGs5fLcfe/J4GXDJbdxdPYvzHFOWpP8flf2nLNslhXVwB9V0QZLGQQWp3Gy4zhFS5tqh7L2YMDkE0mgzs/Y88EdFi9KaV9Y6hA1qza5TT5OBiRvp46mKpvnpb2Gkyzm+J0NYre47wXRlFFWAbtIkkYyenDeYCzXQ6GSuAY71k/dCivCU9E7VrdNbYxHx7zhY+Y5jBdTplZNwq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/irQb1+hdsCJhH+YGZcJldNPuo1oIyN+lOPXQWeA874=;
 b=qAe8e0p2YX9bNokAsYabxEONWSNwPjYHWrutFiKpp8Ot5T7+gXcP2N+AszTqodMPz4qKt6zFi8H9ps/vrpYvccev6Efp13rKxO5A7c8KcsgxWqkxWZnTuU8oHwyglQGXVL4F0NiVu1yjuxiH0e4fDQP5fcrTPm5+nV41v+3AZmg=
Received: from BN9PR03CA0555.namprd03.prod.outlook.com (2603:10b6:408:138::20)
 by MN2PR12MB3421.namprd12.prod.outlook.com (2603:10b6:208:cd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 21 Jan
 2022 20:22:38 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::cb) by BN9PR03CA0555.outlook.office365.com
 (2603:10b6:408:138::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Fri, 21 Jan 2022 20:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 20:22:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 14:22:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: handle BACO synchronization with secondary
 funcs
Date: Fri, 21 Jan 2022 15:22:19 -0500
Message-ID: <20220121202220.5557-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121202220.5557-1-alexander.deucher@amd.com>
References: <20220121202220.5557-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b20c987-cc19-4062-ccad-08d9dd1bc4ac
X-MS-TrafficTypeDiagnostic: MN2PR12MB3421:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB342198277502E7E71DA606FDF75B9@MN2PR12MB3421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/BE8l1viEFdd+VATxt2EJ1bgC0MvOWkD8xz4FdblZkZFOSpZdPe/iPz4fOb2unCvdup7/I34MsK6A1/r/GwNtxXWawHsdN408R+00/kuh43XSkXw+USwsVJJR2V2GkiBjQdWjDYTEYq2YDheFNIvfTZDllnu+MwxFVCH2ujOSmE1gdHYCLSBlQBXjHl+nokD5gbPgMV53BfBjfUEud7VNvyBhRcx8D7QqYUxSOhQsCD/m1AK82kVfmB4BLnA3eZjCkVvGgCwqM1w5SJgUJTCptQZPB1GuvjM+xY5jOBvHO24CJISeHeV3FFykXQTnKJfNlI/1r/3z219VHI2lN86y+Dltx89RFFVHSKXYroF8idEZX2U2nZAzJnwa6As5A7CJ3zaR+L1w5rrzyDk5mufdKQo8s7lVtucy9ce+DNgY8gMwHwHoQ11+cQRYfEROhvQqEGHyy0+ws5+oKgmrNbC0BWLlNyasUSXvqkZ5Ad3EjgjxYYlA1DUnEcX0bmBR3DGgcNZhLKW7wSTnF4w/U+X4n6Nqhpeqn50FD5n+Fox5Ds+PI4Ay6PV3mwPIePgBn8Rj7mbg0UVkSJglaKLNXAVHf1/MtKXph8I3ID+RuphTfqBn8LD1Z2F9ykS0XaWdPz/6h7LEoiRx3I17hF9fuLRjcFJclitg0ek2W+PdPxz3QYpePR4AtiPxL64hCy+ZepYDrus/hn+YJDbph1yOaMfUpVcwne8//St1Mz+nkeyzOCG3UObqpfuI5t/xHQpYzWVwdyjiIcvfk0wcM3HFr9nKjXnbgsbOsnqLYFdPoMVN4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(36860700001)(8676002)(316002)(508600001)(8936002)(1076003)(4326008)(16526019)(186003)(5660300002)(26005)(36756003)(7696005)(426003)(2616005)(336012)(2906002)(6916009)(356005)(86362001)(81166007)(40460700001)(70206006)(70586007)(47076005)(83380400001)(82310400004)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 20:22:38.2681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b20c987-cc19-4062-ccad-08d9dd1bc4ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3421
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extend secondary function handling for runtime pm beyond audio
to USB and UCSI.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 30 +++++++++++++++----------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 89c3578bc818..119a5798623e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1968,19 +1968,25 @@ static bool amdgpu_is_fw_framebuffer(resource_size_t base,
 	return found;
 }
 
-static void amdgpu_get_audio_func(struct amdgpu_device *adev)
+static void amdgpu_get_secondary_funcs(struct amdgpu_device *adev)
 {
 	struct pci_dev *p = NULL;
+	int i;
 
-	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
-			adev->pdev->bus->number, 1);
-	if (p) {
-		pm_runtime_get_sync(&p->dev);
-
-		pm_runtime_mark_last_busy(&p->dev);
-		pm_runtime_put_autosuspend(&p->dev);
-
-		pci_dev_put(p);
+	/* 0 - GPU
+	 * 1 - audio
+	 * 2 - USB
+	 * 3 - UCSI
+	 */
+	for (i = 1; i < 4; i++) {
+		p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
+						adev->pdev->bus->number, i);
+		if (p) {
+			pm_runtime_get_sync(&p->dev);
+			pm_runtime_mark_last_busy(&p->dev);
+			pm_runtime_put_autosuspend(&p->dev);
+			pci_dev_put(p);
+		}
 	}
 }
 
@@ -2148,14 +2154,14 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		 * be no PMFW-aware D-state transition(D0->D3) on runpm
 		 * suspend. Thus the BACO will be not correctly kicked in.
 		 *
-		 * Via amdgpu_get_audio_func(), the audio dev is put
+		 * Via amdgpu_get_secondary_funcs(), the audio dev is put
 		 * into D0 state. Then there will be a PMFW-aware D-state
 		 * transition(D0->D3) on runpm suspend.
 		 */
 		if (amdgpu_device_supports_baco(ddev) &&
 		    !(adev->flags & AMD_IS_APU) &&
 		    (adev->asic_type >= CHIP_NAVI10))
-			amdgpu_get_audio_func(adev);
+			amdgpu_get_secondary_funcs(adev);
 	}
 
 	return 0;
-- 
2.34.1

