Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9618C4332F
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Nov 2022 08:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B34310E086;
	Sat, 12 Nov 2022 08:53:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2702110E086
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Nov 2022 08:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcLXuFW/X9ETZEB8fNBQjVNmx6Y8wMno7UJWHrPfKpOf4zVZOM15ejaviYWi7gNsQ3ndGq60lZ9Y1HD2nds00UbZ/rDcTjBMcDNqdIU/FjNtWzjXgypvvUYFOH8P79wAdALSEeOIqqeJ0HzevDeLFUXqvxZ7nHGQ2okAVnmOcAU3QKZdwldOki84tjzZwFqDeyzKjR/00nP7nDd255JfWs4//SIjaMfVj9U2Jk7Zxrxh5KWUjo7fdgffXD+rVoI4PxrWTGbbXGouZphCJS1XRBqx0ClNuhlg0dLS0Te9zEEAdQb5xsuEOZ1Ca0G1t72ZSrtk7Bqu6F/R4g/Agz4AgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt5pYqOwcHs948gH38y3GMpb5chouq58cTIcr54phTU=;
 b=nB+BfTf66botLn3yIClo9P9N9/oiHJA9u7Q2K+WpbI7mVMYsqh/wfRUfAqkqCZ4/QNy5QFKlFq/qtTVd+od5KJTaiNGnuCx+ypWJBlsC9t7lehjTXlEtlXHCxwpK7etP89XfU2LmS8YX7CH+yBv2u4Z61JGaqImm/etBpnyYMALaYrTqWo1g46R+EbVfEteIcNCL4jx11hi4NgZ84moHlF6tiFNhM8xLLGvgWiSMkZMvCZCx+sziErnJ9+zD321bcY+anAXrU50xGlIipveCNO1R5fNwm2099ugMl2BdzVzFaiu13AivwjtX/dNoXhVT0v5aKTMP3FHFh/9PaoYvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt5pYqOwcHs948gH38y3GMpb5chouq58cTIcr54phTU=;
 b=azo5BoxkgyZm94az65BzDWNjHNUtyGrh2lrXcJ4msjwWwPYMr/5mU/omA38F2mQS+VP7jshSFmwvYTEoMlINEWbN4HRwKmMYubSy3SKxkSa2Gh57lwnIJR0vNOQ0fw88vtnUMW9FpCie/Ae8IFIjKayYHDL1ppvggwdkzAbhUFU=
Received: from DM6PR07CA0053.namprd07.prod.outlook.com (2603:10b6:5:74::30) by
 PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Sat, 12 Nov
 2022 08:53:46 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::b2) by DM6PR07CA0053.outlook.office365.com
 (2603:10b6:5:74::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15 via Frontend
 Transport; Sat, 12 Nov 2022 08:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Sat, 12 Nov 2022 08:53:45 +0000
Received: from candice-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 02:53:43 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add psp_13_0_10_ta firmware to modinfo
Date: Sat, 12 Nov 2022 16:53:30 +0800
Message-ID: <20221112085330.2097390-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: f4372bb7-8044-4bb4-1cbf-08dac48b6866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUDoLTj/WAT9x05LSmH1EMuWnZ+M/iAYfiihWyTTXhICkZDkMKAIyAw/lWnqbBcHQIro0/b3K2NhyB2i+EHQ7V/JGKCNRSRl2T9oBeQus/gWyG16+pFs71yeDXpAwUxIZ9p9BuUmO1B4GSH1jC+JnuZ/VwYCBROuCYy4epQrCFBN98Ww209exv+O+gfxc82KPnzCDV6W5flaHfbX8FgD6ItDJW3A1DMMFAGR1Bvr1N2vr4iuuPmSePFTrmZg4dVIIuzED/Y94qK1Vk3wADIwFRU/lTKeZhe6avlmUwqBBkYnPhY/YhJCOUL3voLqPYMs85bQzLorTzk3CaeEf2CVI3lPHgLwmP95bHQF4K7XBiXDErbmU7GTYcuei3MImg1KJerUngkBbxefcz1EsfdTigTh3vE3VdsKLev3lMl0RJhTkLkIkI1l0hq5FLzWGPFFRbrmAZW0WJ0SNdrakOTgz0NJDjdagdWvOPZJ9DcZAkeu0lYz+zyf/2dZJtQmo6R7TQ+IntnJIAWkDXQyvBTpap/4De4Ak4a0e90TQV8IuHkzeaojHkzP8ObIp4T5npo4dXW6mnX4SQrIm7ZGeq3lSxd2fiYfwEe2jBGPJR35YLAhwfJagTVa2lz4xjpZK3ntfVhPWk1KTWP25sMYJtLlbPE1nj/1094QoJcLS0R/q5EWyTGkymwEOd363aWnZ//5qhL7HyFMTeHdrmiHyI3DBe88qov+b+ksSBoDRUqLzzQdTpOCPzsJg71ZhkC2RmF5vGF6VJFcjqF2VsJ0fDnEtb1UrBQMf5COkuG50e9Y9MaYwp6ms/vzLaEPZaWlhMEz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(16526019)(186003)(426003)(336012)(83380400001)(7696005)(82740400003)(8676002)(8936002)(2616005)(26005)(44832011)(47076005)(36860700001)(5660300002)(4744005)(2906002)(1076003)(356005)(6916009)(82310400005)(40460700003)(54906003)(40480700001)(70586007)(478600001)(6666004)(316002)(70206006)(41300700001)(4326008)(36756003)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 08:53:45.6429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4372bb7-8044-4bb4-1cbf-08dac48b6866
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
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

TA firmware loaded on psp v13_0_10, but it is missing in modinfo.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index b21cb38ab4d750..86d7038f5dbde2 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -44,6 +44,7 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_0_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_10_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_10_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
-- 
2.25.1

