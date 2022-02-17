Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCB2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 03:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4414210E21B;
	Thu, 17 Feb 2022 03:46:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0242F10E21B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 03:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5HuDKleS02c2wQtLRmz19+z/CqQEYbl93Tq74y44KIIXgWp+FJocMeTk3vVOdSDBTeumRSFlgkbf+sfVu0Kh0bKr8Ag4lmw8f6w30lis06wLCs9Uh1CfF7Dz2EdxAe5THu091M4kWa7A5o/84mmIwV0MtounYKdT9bbY5utfmQ62rYEGuyOHNrTGP1PwmUdG8RZfE1MYLDHLhYrCR2J5sezewey8uXvAcvPnw4f+m8lKUbYm7QR/DaXLLXIpLuyit5zNUuEOkhoIvojX8997xDvjvdbmAGRpOodqQoi32uZqr37UDzqZG9gIazmOnTxZ76WcnCyFQKl7lwYnNCz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWHrR71RunsqnEWOhRxEgPUP0Tb7zJgEISTyta5+2CY=;
 b=a8U5yztAAIJ0qlyHObvYGK0zGhYCNCd5UdjQ8gpEarJOOqt0cuQbD83j5RTpDowClLt6sKWGENVGvflcHYwZT0+W7cOw0Bl8DDhiy9/T5knX4seY0/nn5TEQs546g4t2uR7urhod+AKG6IhkX0BM93NRUAyj0TLEAuMQx2yYftgWcASRQlzRNb2wZESp4tueLXdkwX34xvHhsvfJ/zgelK3/0ZB847OmJVydHvkaKWC6rEz8E9XqS6BTy6QoaOdmjX7qYacD9Q4+qhuw6j+UTat2h9lrC00bkePdcaM34dLSyUhgz7i5/wcw6LR5YvB9qFT/mb6OABI2OUgxo7KWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWHrR71RunsqnEWOhRxEgPUP0Tb7zJgEISTyta5+2CY=;
 b=LCeGoYcSdd6IF1GMTtvD0KLvCJ6k7AeMs2dPGkRQc0+7A7chWyex/cIVAe6Npq6EGdGipm2F69nzr+J2Kh9aS8BQ9DjgbMNNfzQi2vScDkczMgHKcqTpypJ6v5Q3SSECBRygvFUixlCyj4PQcEiebyAf8Y5kbpcLFv/kAMZxfgU=
Received: from DS7PR06CA0010.namprd06.prod.outlook.com (2603:10b6:8:2a::17) by
 DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Thu, 17 Feb 2022 03:45:56 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::6d) by DS7PR06CA0010.outlook.office365.com
 (2603:10b6:8:2a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Thu, 17 Feb 2022 03:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 03:45:56 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 21:45:55 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Check if ASPM is enabled from PCIe subsystem
Date: Wed, 16 Feb 2022 21:46:08 -0600
Message-ID: <20220217034608.14733-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43726c72-edd6-454c-1220-08d9f1c80148
X-MS-TrafficTypeDiagnostic: DM6PR12MB4420:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB442056FDD305C6AB8A38D2ADE2369@DM6PR12MB4420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zn/3VszuU48pkZOOsfd5HWO3t55jney3OtmzOSBn11ugR0OAyZYYv/n8FBUnOBjyMIv1UG+tYZQXbw2setQHtBNCz2lIm6vd592QEGsqny2iqw2+6fV5sLmSOQhiWXSCS0Z0mxWi5TZ+5oIZPl9aICHEQiOxZ2rRjONSUu/TEgNXorNQXyGv1mCTvx/O2ldSpw1WfNx8vbGMt9cL1M1yZ8joBC48KR53wUJy4QUjPcRp1PYNNxzrhu/WIm91q90da8H9cKTRhg57c2shWgCPW+wk/p9TIRu8a7Y0gc1EJ/xyeVS/1o1HDQc4LhYkhOIC5wJhTWxNhNWvXXeoYnK3db0AsTJCrUr3z2lODZiMk/87WnKv6EroxUpUaqd3JY+1TB4i8aZCfxJTqhU87bV9+SnRRDuSgWzbjOIVcXdkkr5DrUMEl9/LEsSkLUQB/FJYwPfjOHGNgxRy2UHiuvRopXLfkngXN8BnolfNwLSCfsdISfG8eNWuMo/5K1iXaQnIbBQ0BUDZc/EXUsZm+wInmvgY/KVhKAnWgrqLR6oTbM+7Lk7szGefEfo0BfWTaeF/x7bsxJYnq+i3tGh8vfaGX/KCEwt+jil77QAjlT053vzr+k5ireaZGdFJUHL9bok3r2E8Sxz5SNN3JaH3pw7f/KLYtHnTQdNftWpPkHFg+9F1Pi6zzwaF7FGoDKNfgeRGH7+WgTGmfCPDVQ4/13STOOmtx0rllfxYft1JNoKP5MgyKTha4z54sutR1gLXdipZBYlgYd4aZPDinkU/GkT8XZ4Pp9ZZgzUJO2pljrsJxto=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(47076005)(36860700001)(36756003)(86362001)(70586007)(356005)(82310400004)(81166007)(316002)(70206006)(40460700003)(966005)(2906002)(54906003)(6916009)(8936002)(5660300002)(44832011)(8676002)(4326008)(426003)(7696005)(2616005)(6666004)(336012)(16526019)(26005)(186003)(508600001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 03:45:56.5639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43726c72-edd6-454c-1220-08d9f1c80148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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
Cc: koba.ko@canonical.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

commit 0064b0ce85bb ("drm/amd/pm: enable ASPM by default") enabled ASPM
by default but a variety of hardware configurations it turns out that this
caused a regression.

* PPC64LE hardware does not support ASPM at a hardware level.
  CONFIG_PCIEASPM is often disabled on these architectures.
* Some dGPUs on ALD platforms don't work with ASPM enabled and PCIe
  subsystem disables it

Check with the PCIe subsystem to see that ASPM has been enabled
or not.

Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
Link: https://wiki.raptorcs.com/w/images/a/ad/P9_PHB_version1.0_27July2018_pub.pdf
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1723
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1739
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1907
Tested-by: koba.ko@canonical.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5acd0473ed01..d2548fab51c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2008,6 +2008,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -ENODEV;
 	}
 
+	if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
+		amdgpu_aspm = 0;
+
 	if (amdgpu_virtual_display ||
 	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
 		supports_atomic = true;
-- 
2.25.1

