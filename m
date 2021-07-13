Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC49DC07E9A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 02:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75041611CB
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 02:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75041611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354FE89E52;
	Tue, 13 Jul 2021 02:04:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0425289E52
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 02:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6tyBDdRUbaIsglNrbHhC8g1mAbdm+gx6o02JqeYJVNfDwNW9syb8gUlm8rmIGokJ/L49V7G9M88YBtkHh6yy5E3G/IDm9vmObU9ko8p2QGzSNtkbIsVWLxSq7v1iR6ojxKyUd7Ly70KyepD77WPQ8QVBPLlgGEY1ca0UIR1USzLh7Q8i3E0yHMxgPT6R3nu7+7N6M64KOUjoAetV/J6m4rWmADnZ8AAI7rKt8vIiO0mBhdynQkunZKhIf6t5RMKxX8WV6GFP3tE0QOL8wFk/iGF+Ai52KFBqF/uasKGf13E0PHMCD3aqrQxaieA3GfIdtIcgrK4rqmINYQrxNuhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5Ry2vjoCJoVb+FT14ujaGpguIXk/T7HNrdZ8zNyO14=;
 b=eZ/HXOagBIWv8ZosSUbp4c/j3QCgM1hDocRxtdpi4Zvg8UnX0YpmtkW/4KP1zxlf/+WMdZU90OkhmaEBfReT08BCjKcI4mZUrcQzvw9p1WaDLdwIzKB258v67bMu7czUtJiGEnQDcqF+iYtc0HiQO+VY9BOIOcPDpLU0+QA9n8LShYmAuZp8D6y7hf9YUs5hYpcOgwjtra9lbVYtMP90tRINTxK50rg4l4P1MUFZPjwGytNInTrCdH4M9m0FaDY/YVBLKscwIMtRUVMBUDJKUassRd/HjUk27tCw7cjxyZ5wQKw8IJnZwZs8K3xScQbOT3osid9SX6mwn3MVp6GV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5Ry2vjoCJoVb+FT14ujaGpguIXk/T7HNrdZ8zNyO14=;
 b=uzsKdc7JqSrU9WuuI9MsqGvKdLYXDXZQhtMT+XbF1ve6+jn8iojJr0MdC14tiYyYg7u+Sr8Up9GDSJFUj2hGiSXxBf5JKPeRw4lFHiYnvWPFiz+xhPgt0LA3UanD2ijR8UJGUzCD7vgOCwPDG43svzHk+h4+VD+g12qFAcHt3b4=
Received: from MWHPR03CA0003.namprd03.prod.outlook.com (2603:10b6:300:117::13)
 by BYAPR12MB3639.namprd12.prod.outlook.com (2603:10b6:a03:db::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 02:04:16 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::ab) by MWHPR03CA0003.outlook.office365.com
 (2603:10b6:300:117::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend
 Transport; Tue, 13 Jul 2021 02:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 02:04:15 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 12 Jul 2021 21:04:11 -0500
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add another Renior DID
Date: Tue, 13 Jul 2021 10:03:57 +0800
Message-ID: <20210713020357.3075993-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e61eef2d-19fa-4e52-3dd3-08d945a28466
X-MS-TrafficTypeDiagnostic: BYAPR12MB3639:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3639803D287A2B71BD84AC8890149@BYAPR12MB3639.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZQwW3DCJY0jDlnbQTsKTVK5N8NNWaVZTeOs0SM+LqPNrVK7EnX5Tkp7vnuXxMJ25fL/sqSQgOHlF4wmMCJ9gV1DRzd3y5sjH+OupaGtx53DQxIo2TXe3BnQALq+wxQK4K0g2QOel5pGbL8aTWGWXcsFXavN68B2BUYAG2LknoQjytDW9jFMq5x8FRrqf+vQjrxYcKAYLfk3Ka+ryvihqxvbmdH3T/2NUiNUxQS33FSDMHy0Iy40XgckQ41p/ws7bifHC5MwyZA58aJpgNirejPZhaJRx0/uUnmP4u4eTKM/4gqiH5MTNeycqtUuDHttnsf65b0ReyqrLZTv+yM+6ge9uv2vcRPIm35MPQuiGyw2GPAbf5Cm5KVAWbtM29322fmdnJeEI2NcRHzopLkbtS0v5I1peTiEJaNQ4VEPE1G/JGR8Ld2sUidzj/l512+K6IaQzWj6LHo8/uJjykwYYB3zx5N+ii+SZzY3FoMcxvsqAj+wZEYuDKbXCPSYqAZkKvo2JrAI4UFNohr5pOVebilJH2Q4Pf3cpoRWdXYhwcllIsxC+tiSvjGNgWfxeZZD+CMzf3LZetcCwG4ViMQaSivdwhI8KqWHDDX3xfBEluZ+w9RGlUF3Rzc6kMy5qo6TqN2mj+oUd0IZydwGj31WKpRxs8qDQeJ8XRIFChBP6u8V/ui8k1H2RJRPvTIdnlTDLRJbReBPloS5NLWIZW6DcFLOpjyMadxvJv85MEc+iKA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(36840700001)(46966006)(82310400003)(82740400003)(316002)(81166007)(36860700001)(70586007)(47076005)(356005)(36756003)(5660300002)(70206006)(86362001)(478600001)(4326008)(1076003)(16526019)(6916009)(7696005)(8676002)(186003)(54906003)(6666004)(8936002)(4744005)(426003)(26005)(336012)(2616005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 02:04:15.6208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e61eef2d-19fa-4e52-3dd3-08d945a28466
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3639
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add new PCI device id.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 179f2d01a082..1db106b135f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1166,6 +1166,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x734F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI14},
 
 	/* Renoir */
+	{0x1002, 0x15E7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
 	{0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
 	{0x1002, 0x1638, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
 	{0x1002, 0x164C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
