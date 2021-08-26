Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485BEC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 20:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E8D6101A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 20:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1E8D6101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD376E8B7;
	Thu, 26 Aug 2021 20:32:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3596E8B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 20:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYjeZ1ZFCuJxiK2e59i4wqt2EwsjrRzS/QJCZkhFHABIV3pxme6hCB4w4kYkt0PAFKqJeTl2a4TMW/yJR19kbbfH1VdCvn1N0iDTxCHut+2bYeeIl6PEOA62yts99KlKj74JlofCbplKsrGW+NgLDRK77n8IKQGKQDiYTrTvD7GwbXoxQ+4fuMFbC1e+cZcH+LYUmoZSffWtStrfaUt9kawilGc41f//NYiSZaSnkewd+zX2PIwLQQFN7ylhX5/5oRcADuuhm4nzZQSykCJ9nXKmOTpVClLdNz1XDLToxhUNAxXrqn7VfXrhKZKZAuD0aTPiH38BhT6h56WGwMciDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9NzNcZPmCLO7F/L9pgc7lnGnU6XLZ5+EgzYeAYCt2Y=;
 b=ZOoehkF6SOc6X+Caxx0Tfjro010n8qAVNgrj71OU886jvaiVIkaJGt2XpcKm334OZWmHvMW3b3YJdhIuoK/DigHxO8bklxDuOBJpJIEUyYiOLR2Y22mqHAmyoU3GMS4PkM7fgqvbuAH8909EAVK8b17jWj4RnvpL8BaOY3e1Q+utlZuOTyUVu4u2vhqPEn0BSChp5FRMnoSGpuzJQEb8Zz7tnMkexvqeD+VlI06zQ0dxhiKAs/1r6iRRc3iTR2DA1nShMpc3SHZJ6m+e32rYh80WLsEdPP/WVeSbb0FYTY1zHw6MVvt5FFGSYa9420VLSbRt0ebODDw6dM+DvjBbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9NzNcZPmCLO7F/L9pgc7lnGnU6XLZ5+EgzYeAYCt2Y=;
 b=cdCMBBevd8PbgUC2Y2HZPY5N1Q4WYZNgQ3OAcbDd3oUKcWOcHDumX5GXJSM7TKJ3vxNqPzsSJRMIbvbm+AFfDjUywjuTSGrL3xwQHrpMziVdFGjh0K8DmAXrbzbPqkJB4duj7tWds3R2yODllvS99/zDc3kKG44IFXmxeknM6xQ=
Received: from MWHPR17CA0063.namprd17.prod.outlook.com (2603:10b6:300:93::25)
 by MN2PR12MB3757.namprd12.prod.outlook.com (2603:10b6:208:15a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 20:32:37 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::8c) by MWHPR17CA0063.outlook.office365.com
 (2603:10b6:300:93::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Thu, 26 Aug 2021 20:32:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 20:32:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 15:32:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add some additional RDNA2 PCI IDs
Date: Thu, 26 Aug 2021 16:32:21 -0400
Message-ID: <20210826203221.710350-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1595a4b6-65e2-4afd-9281-08d968d0a479
X-MS-TrafficTypeDiagnostic: MN2PR12MB3757:
X-Microsoft-Antispam-PRVS: <MN2PR12MB37576C376AE54CEE24E57B7FF7C79@MN2PR12MB3757.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGyAa5DHVE/SniDamOsH0x3LLQuqPOzTdOR8uQFhwXWuFeMQRruHK1p2to1FuJd3kQSFPUVsnq4UQ5iSupdqnkB/BWKjD2m56ar0dKD37hCMJw/0KiBA44yUqyOsf7pip2BaYeu8varZ7KyJsp+7UHdnqUjbHR2BEQmxuRi/Bg0eKKMKm7H3wnDeW6Af2p9YYdW/2NpIEo8dZ/3ra5RuS6mBlmb29e3WimwywVn+J5QPPCcaF0SPsX09tItuW0XN+Qih9G3E5A8xVzqyDo3OG9Bl5IRcMibyGIYBLb3UVfdR+qUOnn/sDVuWPG+k9t83MRcJxyRffKLVCduCRQ95uO8tUbbrqH8tvcEgWtoKcooD21Rg/Y8c8qyMD6vs6Gk2pHULaMBdbg0JcQkIj60oBEHsEf1vOH1FpWepL3GMqnEw8faL9x6yaBeY8JzvFBAIcSQgyxcP5BkBJWEf7d6Mq0sIkZke+RzBS0MrASP6TVqCSW/vnp8vg+ZKpBgOM2Z0o5iSOSQVxg9DAxKJpOt8q93PwvW0eQ5pQX97PQESyjShrrOmSNdUzSyufuQ3hWs7vZof+4H78aijnD6+iPaF70rrXD9WBOn4r3iQjOCuhqXoHmhkp+wT53micEjJcc2Q+Y39SA/xK/s637A43LyvMwSWPPbqqwrYopU9GMze9GmdY9u6kqZ6jPLggM1DdwMbTVHddqgjhK/IDgrXg1zGb2E+UtiQjxCQ78/RQ9pFAL8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(36840700001)(46966006)(356005)(70206006)(5660300002)(82740400003)(47076005)(36756003)(2616005)(81166007)(36860700001)(8936002)(4326008)(26005)(8676002)(6666004)(70586007)(478600001)(82310400003)(426003)(7696005)(16526019)(336012)(316002)(2906002)(1076003)(186003)(6916009)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 20:32:36.9933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1595a4b6-65e2-4afd-9281-08d968d0a479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3757
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

New PCI IDs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6400259a7c4b..0bdfdfc29299 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1181,7 +1181,12 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73A1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73A2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73A3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73A5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73A8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73A9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73AB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73AC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73AD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73AE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73AF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
@@ -1197,6 +1202,11 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73C0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
 	{0x1002, 0x73C1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
 	{0x1002, 0x73C3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+	{0x1002, 0x73DA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+	{0x1002, 0x73DB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+	{0x1002, 0x73DC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+	{0x1002, 0x73DD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+	{0x1002, 0x73DE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
 	{0x1002, 0x73DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
 
 	/* DIMGREY_CAVEFISH */
@@ -1204,6 +1214,13 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73E1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 	{0x1002, 0x73E2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 	{0x1002, 0x73E3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+	{0x1002, 0x73E8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+	{0x1002, 0x73E9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+	{0x1002, 0x73EA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+	{0x1002, 0x73EB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+	{0x1002, 0x73EC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+	{0x1002, 0x73ED, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+	{0x1002, 0x73EF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 	{0x1002, 0x73FF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 
 	/* Aldebaran */
-- 
2.31.1

