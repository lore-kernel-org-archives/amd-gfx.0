Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8B4EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 05:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3BAE10E11D;
	Fri, 14 Jul 2023 05:41:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FE5810E11D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 05:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa4J5gFeg+WDfF6NYLlOynMT4MPQLhEmecUJk/hz0xFLQ1KgSEsSq+UBbggwa8KTjYI+jQD9AqfvXX2c5S9ksxbPDWfjjGzjoQp0voR5e9jVqZgUpU6aJnEwEXakdMPhuk5H3HBmCUTSPdlTKAaFDgYJntJbJc4q36oOK7BPqMluAQDR5enWtVBsWBNIAo3XXaGUEinoNbPqrs1gciVcKW2xuqfLw+sewogmlk+RKepgAuJQrLMVJG9SmeMK8HQHyzcYhiS1FnlHA609KVjsK+X48Q1gudxPlLOse9TbQ4OvaM6k2UYOThYgkQaz0JxtYMXp4GxUbA9Ew0vVKJCGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq1IIDSAVB+oVaE3nkrMh/D4TEdoMP7lCXvGlnrUOV4=;
 b=Ckux0JhTbaZaWrzjPUDc5L/ZnILpUxlIc6fnDnySN9SRs64Eh1RG69Q3f5XKi60CjBvnskPNcR8ptkjdhk3xPUa9jubhxgCfsJqPpbMNMAvDpHf5CfB9EcrHB2UHU1Rigqy80/ed88+PQot+hMYAY/U3cpEoTi9a98gzRILaeZkdm6+esA52r1dutnPh6vwyHLhzwFpNXdgNEhQ8GEijsZXsp0FGadYynGGJw0YRj8cqDDiMIXxCFBXHVsJnXUuUknUqWkvMCbR1ZB6l9UooqgUiVM827ory8/RB8jwZ1MZPNikMQaMhBEspjApKrCd0qz+1lSgMXWC2hMNuh4p7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq1IIDSAVB+oVaE3nkrMh/D4TEdoMP7lCXvGlnrUOV4=;
 b=nub+uc8gwh8FIp7PC7ImWQwmYSkxQ3arWgill14VQ3BkyL2W4tJN1P3HF52+d8xeGp+4EaekJ4U3KUcIFeKXVQCY6mEDL+D3pNzYEA4kNHMZmxz1FJDwGxke1pcbxwXMMgyeEwubg/WKW8SOHqoHSneczUULpw1fF/bpJrSajrU=
Received: from SJ0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:a03:3a1::26)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 05:41:24 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:3a1:cafe::18) by SJ0PR03CA0381.outlook.office365.com
 (2603:10b6:a03:3a1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Fri, 14 Jul 2023 05:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Fri, 14 Jul 2023 05:41:22 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 14 Jul
 2023 00:41:19 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Allow the initramfs generator to include
 psp_13_0_6_ta
Date: Fri, 14 Jul 2023 13:41:01 +0800
Message-ID: <20230714054101.85866-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc83a4c-a593-40bc-d167-08db842cf52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9XTBG3HJ+OacVsh+UC8es4oNTxco7W6Y9B1CqeTwE/tbWkiJY1dIo4NT2R61yPJYJNC9Lx8WzdsBx12Z2VUMfglkW2EgcGWZFVpSDlNqbWzo4RNjpEi57wksac9pV4/eOyFm++iEBRcKOlUwd00ISbZUnv9eHPghl1XnXoYvVDFg7u6YvKh7Jdg2V7E2xXiNbYtDaDAq7UyIsaw/L+tbhzsujSfqxp3J1yINjyyKlgHaJQiNJ12fsOi0q3GdsAv0Vqf/SHPsNF0/YfSe6AezK7XMUrynh4OYe5L0nKEIUJ1tYTzEv0G4X22d1XaA2EEOQgnWzYC4xJqFeNqdzmY+Qu5YMQ7oXhq9KO2quiRuKtuLbcZhtx2G2aqmY0EIv5w0yEo89YJAvk8eOfXvSl4qigA4hTeGsclk5az6xw+wVND8NNXhjT7+GjHOdzxRlfgaQo0EbhEVwDveEuQKsF0tz1DMT+UxkNqp5B3TZ603VE7LE6acBTalPj5X2WU97+Le1YEYY3N2pHqnQj2TL4LY+iLxM7pbpsmmlg3o/hRINe3e+8VOmbrT/jkyACn5ooOwcvd879Q963Fbhnn+StgcZxLE+rp+CWCeDm4bvCj3r/RlwwuDQQ2ahiRee043thwcBqwfknaZNeWA2GYb3gBxI3hfAXk603+q0uwbwGhsAm5FRWkWFdbikBsmYLI6oHW+73dbobtUU6ZKb8eTKVr5YNT6vWiKoaOXsuBkEbs25AQtQ9KOksEgexl2PUoJqr3f3o93ul68M1xwkV/SSxLBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(54906003)(40480700001)(44832011)(70586007)(4326008)(70206006)(6916009)(478600001)(4744005)(5660300002)(2906002)(8936002)(316002)(8676002)(6666004)(7696005)(40460700003)(356005)(86362001)(82740400003)(26005)(1076003)(16526019)(186003)(336012)(83380400001)(47076005)(36860700001)(82310400005)(426003)(36756003)(81166007)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 05:41:22.8836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc83a4c-a593-40bc-d167-08db842cf52b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
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
Cc: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allow the initramfs generator to automatically include psp_13_0_6_ta
firmware to initramfs.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index f9cb0d2c89d15b..e1a392bcea70d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -49,6 +49,7 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_10_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_6_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
-- 
2.25.1

