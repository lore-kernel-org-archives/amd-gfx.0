Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68DFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 20:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082CF10E28D;
	Tue, 11 Jan 2022 20:00:35 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9CE10E28D
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 20:00:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ8CJLt/ZNR9XkgUta393+HguHaDDeip4IR0uRCNijwMGpYLMm0Eibx4SDjKdBg+417SP/jefCCUwqzG0maPHsjT+b0cHDNHIaDECMbr85c/NTpQM4EQNBfvzXnK2rbniqi2pIcianWPkWst2hw6F8jwzxU4f1nBOR9Vk4JtAKptYGK3Qhy5Oe6h/H3Pqh4PAeYEsc/dnDJe2LlQUbcCbrOCeBdAkSHJCUq/6eMahpt0BnCEOJ65D9FnXI/E64/jLP2Rs7gLrU8YjMxRp7lrybbB/qA/sjXL6BYbxTCGgKM6Lty0OAE5xUIA+E6kRnrebWOFDdUK7AUE4U45hAI6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSWRhd7xZS5GWgecgk1WZC6JYp6CC3UYgJ09S/8qo9w=;
 b=grbLp3MUcUH4yktfD7OX2DZyq48pcEUEIN20wld6KqXP6hpcXinbpPhr6zc98J535Zxq6rOUE6SbexVa5qwnxDrhNv0Pg+Yiph4UDnahbDTxDPJiigiqH3orvo1UE8aecLF36GPE+lB110E/r4qQaOtuwi+EKI1FyXDyAI8RC9vNZouJfHtR3NKPPGcMB2QqoeOebfNAHXxuDP2D0oDJvqjnLDG4RAkMu7uPa29Z4DBbB32JV93ME7Su/UYktqt1eb6oA0mJBN0aGrLdN3iik6SDATbeHfthyIyf/smHsV/jDvCUL16j3u7N9++I/oL/r4qJWu1ZcPqebNrPhSeSuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSWRhd7xZS5GWgecgk1WZC6JYp6CC3UYgJ09S/8qo9w=;
 b=Rvy9RMw1xI3fF9cI4GWex1NyLNhNT2QzLtEcc9Y4J+i7HOWF8sW9y2CcBnwDLRPj8wEXEtypf2AyP07yJNCbcrS6URgV8j6z0qY2PGZFWWbWcttWDxVTTU+2bAsFXVsQaQHLV92QhNigT/QVrnYIdyRuMbD+X+DcR8ez78Ig1pU=
Received: from DS7PR03CA0342.namprd03.prod.outlook.com (2603:10b6:8:55::14) by
 BN6PR1201MB0099.namprd12.prod.outlook.com (2603:10b6:405:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 20:00:30 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::e1) by DS7PR03CA0342.outlook.office365.com
 (2603:10b6:8:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Tue, 11 Jan 2022 20:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 20:00:30 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 11 Jan
 2022 14:00:28 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd: Warn users about potential s0ix problems
Date: Tue, 11 Jan 2022 14:00:26 -0600
Message-ID: <20220111200026.15855-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a3b9f39-c290-4c4b-985d-08d9d53d04f2
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0099:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00997D4FDE5F0961F471ACFCE2519@BN6PR1201MB0099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdVnZk3TuTDNC8mKf/reja5xXAef+cdsVRAfj0Jmf+VDuEOtsycMipDV+MU7VGjmsKsDXjC4ISYIDz8EyCK+bcZo814PfGclyWj5TzDW6mIxKy5Kdymq4zHsF38vqiK6EbuN/70I5RQrX+ds/IzAfGuBMJv5GsCy8SW9pk2j4CtTkl2rU2c/n3o7lLDKnu3VrVt86heQNGUBOUOAxXWLJzJJ7WyIF9tzxLdthQVvt0elKGvEdPP6PvvS4hsi+TETbxkahvn/lsHEcUsKHmHipNDeajVmEmpwjjjC5QBeceat7m9KKFuNPNxg4GDgGDYD8oHpUoPBKYtnTplIoNIzOYew1+KWwBeNtcOooIwY/uaP36I4yuzCEoRc9kB8/cD042ovc8lbB0uqV/fQ5bMeZ3hsBvpNuGfC2VrcMMY2OdvH79kielxx4GmUwI6FHnvq0fgNmlANIK1hzqV31Js+qHvk2hIT+7A/4idQ/1A6Yb+Ju+ZQLGh1Idle48MrCZx8kKuPxfPrSKy+yXEWZ6IH/xiP/NhgNjFmhtIJcldhI+4IPaewnXxsb3HVhsuQEenLe3pqKdGBpXMBA7+dMgm8E/r28qVSiI2qnlA3L6GuNFP+0btfEHwnhTfDhHdyEGjW37f7+aIEoXzgsyhS086LAXDX8kN/vw8JOb+uHfSJ1zE/LZSElv6lmteKYYaU6jZtPSTxN+56dNrQxP4F2KeQfqiqvBvY4ZYIHoEhIb9DrNvCojONwZDf7XxISxWi+Tqsy6AEAjjdyCbk3i2OcSe8U1tbnbSYojZQNAcutXNTdB9+B86hdnxu5UXBkLwJE0QEyJU6PH+F5Fiqvg92c9Of0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(44832011)(82310400004)(54906003)(2616005)(316002)(1076003)(86362001)(70206006)(70586007)(426003)(356005)(83380400001)(81166007)(26005)(186003)(7696005)(508600001)(4326008)(336012)(5660300002)(8936002)(16526019)(8676002)(2906002)(6916009)(47076005)(36756003)(36860700001)(966005)(40460700001)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 20:00:30.1427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3b9f39-c290-4c4b-985d-08d9d53d04f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0099
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On some OEM setups users can configure the BIOS for S3 or S2idle.
When configured to S3 users can still choose 's2idle' in the kernel by
using `/sys/power/mem_sleep`.  Before commit 6dc8265f9803 ("drm/amdgpu:
always reset the asic in suspend (v2)"), the GPU would crash.  Now when
configured this way, the system should resume but will use more power.

As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about
potential power consumption issues during their first attempt at
suspending.

Reported-by: Bjoren Dasse <bjoern.daase@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Only show messages in s2idle cases
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 4811b0faafd9..1295de6d6c30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1040,11 +1040,15 @@ void amdgpu_acpi_detect(void)
  */
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 {
-#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
-	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
-		if (adev->flags & AMD_IS_APU)
-			return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
-	}
+	if (!(adev->flags & AMD_IS_APU) ||
+	    pm_suspend_target_state != PM_SUSPEND_TO_IDLE)
+		return false;
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+		dev_warn_once(adev->dev,
+			      "BIOS is not configured for suspend-to-idle, power consumption will be higher\n");
+#if !IS_ENABLED(CONFIG_AMD_PMC)
+	dev_warn_once(adev->dev,
+		      "amd-pmc is not enabled in the kernel, power consumption will be higher\n");
 #endif
-	return false;
+	return true;
 }
-- 
2.25.1

