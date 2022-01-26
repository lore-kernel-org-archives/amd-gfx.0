Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621C4C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 22:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30FAE10EAF8;
	Wed, 26 Jan 2022 22:58:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D245E10EAEE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 22:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7MGBbQQOsxZUmn/a1jpEAacpZzo0ggGYkae0qJJoiKgh+Pc1aFek6e9cDel53O0H7kYm9OW6k3TtMIJCH49NI93XJG8PFl2FGCj561aGcHH75IV9WzwYI023zJSKUowahVnfaRRLOvdzZCVQbR8DqOoDlsihgMNn54eYzQkWm5f1fzLZDiVhIUKEM1Qjw2LPXUUvGnR8uPe4tN1KeL/sQyGntyLFI0Spba/lVJyt8eHTopiqs1P57ybNR1vQW5IIb3IK9DTiLyS+O4SA4TPd2gRcG4nw/FueQZqF3gd8mD2gEE7b9yoy6kKrA+yiiAJKPv+tlWfLcO1oqUD3cztSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BicQRnMTdXKJtKY6P1iDLlzqnRk+/t/YTZPqZ8Wts8k=;
 b=Ls3hx2B8aFXS8l10RSoMncOVM1GGfHBcZ5QQR3Bp+vhSg6OPBEBe4YKgMjUVqR8mQUlGkuqP2xsZxC2ZJFQGET3MFcudyDaHCzFtDIz2Da9cloxw3+F5ZaxcOt7pWPDBE4C1PR6IlNwsHbi1P/QkyclmI2S7h12XUgyZX67UKnE3IlPODQJm8Sy3v6O7CVIrBRwlNiMOJ/RR/npx19DF7m4rYJ2fr6vXJbOmOPfwKtnyxhcT3gblxREkknw4ZLTwrl7TQtUhBSMj04vgHZYPC0++sk5Z7w34F/1Ha61MHuo+hx6lR6I6R5j2WzqsIb/z+RYBQj1cuK5iL14w24QD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BicQRnMTdXKJtKY6P1iDLlzqnRk+/t/YTZPqZ8Wts8k=;
 b=TwjEDsRHoRTxXSLZU+pwbyYVbu8pIq6PBz9HCKomfHUGT1L0BervkjCZPrKZyYdqc+Eb+rII9roYPwqDCWfxoeZv64Qru6IQkrBf44nQq9hKa+ANlUd7VzJDWtqLehtq/11/I1k4QOo37S74y9wGb+RYkzWKO+vaVaE3ETFyyDI=
Received: from DM5PR19CA0013.namprd19.prod.outlook.com (2603:10b6:3:151::23)
 by CY4PR12MB1445.namprd12.prod.outlook.com (2603:10b6:910:11::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 22:58:23 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::13) by DM5PR19CA0013.outlook.office365.com
 (2603:10b6:3:151::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Wed, 26 Jan 2022 22:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 22:58:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 26 Jan
 2022 16:58:21 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 3/4] drm/amd: add support to check whether the system is
 set to s3
Date: Wed, 26 Jan 2022 16:58:30 -0600
Message-ID: <20220126225831.16732-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126225831.16732-1-mario.limonciello@amd.com>
References: <20220126225831.16732-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3be2b27-80ff-4744-8cf2-08d9e11f5ac1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1445:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB14452B8C8BF59326445F64EFE2209@CY4PR12MB1445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olC3Sc+43L840XKw7E2NsbtCbct5E/LgqQwmjB4eAlWk4MU3Ijpin1ORD2pJAEZzA7wUU9lPpgKhsXIX50nDJNMsumgU2kmIdkZP6Y4XRNyW+/V7gaFikTTAnD1fLRfPs8/JBk4AXpjZnKscY09/uJidnODqWwya9HlAV94guCILUE+SLNuZcLEwD+GOgf4eQuREB3Ov2kdkmQ4beshxdAHSwkHmHXn15wBkFEBVlQ48quRmIgvZkvqgIlSwBWiHPNAMDiy1Q6NrWnjrAK1BIboFsxS5ONl7yPG2pf1bf9Du/kYQO8qoxDvj4ZEdZ1kQEJlEQa3BGobAFZqB8NhQRFyWUn+PxBDav1tyFBHrvGAgmNSos8w8T7PXchcEh4oO3sy1olDQjrk3iJovO5gWJtYTPJNqianUjueMilGP31MKMfVysNbXTxKHKJcSWVkDpJ5EBeITGYt7GNYxdlKCC7xAXgCyTHaSPp3CnV3yEAcaZiAliUwfBTI24J4cPeUpxGkZp8BNHQqgZ94gcR/XpzbfsuugjdwOzqwWkOCnQD9+4aLeXFieGlcHv4WvfgR/mnUIkWU+cYGidVfsNk71af7qqPmtLDji5+etcQwcPrBE29EH6x7/a2Kj3NGyuU2fA4xhIM19uFnAe+9/O4iVEIXKR/KJVMLd+wOUcEzCWpQa96GU8iiyFoylfkZsxga7uGFg6Istz7fBLrh2X8GURrUsVPvNOkITwNHCbQBWO1hjor9VrLtJU6XCTX+noBt1UdV4k/rEIyXhYjnu5UPdutz9GG3vLzfovBSajMGtAAE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(8676002)(70206006)(426003)(47076005)(5660300002)(6666004)(86362001)(4326008)(70586007)(44832011)(2616005)(2906002)(82310400004)(40460700003)(36756003)(83380400001)(508600001)(316002)(356005)(7696005)(16526019)(186003)(54906003)(336012)(36860700001)(26005)(81166007)(6916009)(1076003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 22:58:23.1411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3be2b27-80ff-4744-8cf2-08d9e11f5ac1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1445
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
Cc: Prike.Liang@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will be used to help make decisions on what to do in
misconfigured systems.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * Move in CONFIG_SUSPEND block
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b1db703753f2..30dc18c2d1fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1422,9 +1422,11 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
 #endif
 
 int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b19d40751802..0e12315fa0cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1032,6 +1032,19 @@ void amdgpu_acpi_detect(void)
 }
 
 #if IS_ENABLED(CONFIG_SUSPEND)
+/**
+ * amdgpu_acpi_is_s3_active
+ *
+ * @adev: amdgpu_device_pointer
+ *
+ * returns true if supported, false if not.
+ */
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
+{
+	return !(adev->flags & AMD_IS_APU) ||
+		(pm_suspend_target_state == PM_SUSPEND_MEM);
+}
+
 /**
  * amdgpu_acpi_is_s0ix_active
  *
-- 
2.25.1

