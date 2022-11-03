Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B21BC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 06:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F1AE10E23F;
	Thu,  3 Nov 2022 06:24:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 934AD10E237
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 06:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/orP397RlHGw8zRk9rWXjWm5hiu8NmpVfDdJjzI3qjnI6SPia9iIDLQ2dm0mbpYpJt6IVFowrYAUxKrxBko9fQy90NSMKu3HXNrk4qxyL3bEWsPl6Bs5hYrEjzVJEMVl7Rr08k5wcX4Wq4dpwGgc5jLKkaLntITlw4VimuhGxM9HqQ7xwTURtrB4bcjuRIG8KAz2OeQbiCwRMLVQnVXHBhxcuc7LcwfG9WK5ScdO+P/18re7Dy4iCAwTfGhJ3LReiU3Yh1ok6EzJO7Px0XPbq2V3+CAGfenGeFzJOFkG1Kba1ieYfKlpzsBielQgBl8vp49YMFYJCYmHMVcShL72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRJslP+0wnm6w5OExQK9PhOJ+A1OhMrvKWsRKcd9HzQ=;
 b=mdILk2tY45nz6sRY8ho9EYFd5WvhkxKBLfgMhlC82JjAMCWEXPxvcTrqPsPc20fEu9t9PBnVy4CZom6c+TntdjvRXksfRc9xjmoXHUEF3taYmwRLJxnpnapSaRjLRSGuynDRwulMVyb8Rou6Szq0JlMb4bdGz2MPW7FsCbDcGomBQjpebknzUim5eh3nvnZCAyhJvcyBQtOA75wZv8lg3g/vR84MjjRHl1+2jeu8eZi6mvaaK6y5GiDwtrWvt/F2F3lqmHwEZeY/y3fBVUFugTSkU1T20QXO1x0wn0hc0zpJViUItSd/dKC9CpRooXoNMsK3JbqCdtUsv1TRmV8wYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRJslP+0wnm6w5OExQK9PhOJ+A1OhMrvKWsRKcd9HzQ=;
 b=Vbbtnv+BHZuOMhxly2qNu1aVze/kLJqnnPC3RInNOZW8pjjsb9eWhzDxRyPJ4ewIiPO+Gb9gec8a6hQIMBmgdvN3soa2rJQmKi5r9SbPJbBWybQSw9+Y1UweqdmMHvUoK0FrJAnnpzRa7Gg6A2OiGSp0YuvKpqOJVOkRvPlDs4w=
Received: from BN9PR03CA0185.namprd03.prod.outlook.com (2603:10b6:408:f9::10)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 06:24:17 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::22) by BN9PR03CA0185.outlook.office365.com
 (2603:10b6:408:f9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 06:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 06:24:16 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 01:24:15 -0500
From: Perry Yuan <Perry.Yuan@amd.com>
To: <Alexander.Deucher@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: remove the DID of Vangogh from pciidlist
Date: Thu, 3 Nov 2022 14:20:56 +0800
Message-ID: <20221103062056.2162715-3-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103062056.2162715-1-Perry.Yuan@amd.com>
References: <20221103062056.2162715-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9fa18a-8e61-4ccb-5536-08dabd6408d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkRc0MjUOYs2IUOfMdZ3vL6vNAAO2CWp/mw6e9sjt7xPKKeMxw4xDi6qdUCc3zwHzbkTb+3+UjNOgUiYdh7eIMY7vKaQn5l23DaTqTTFmTZoAmJWbZLtMOsGoQLQsQUbEzL0cmqnTjQot2U5eLd8DbpUnLmENow/Od+nMA5mO3KoI5Vm176kxAlWmeiPqaJknqdbBZDjcsh53zyMa5LjPjuQ0YqUPMKhqMzcd9OR9FthpadVefM3YFdAu3bQMIfPEqEWq7Zk/I+X8H+M9ffO+JMYZcUvgk9FXbFgwKgEQRmEVz1fLJqrQ6H8nxt2Id4v2LISIR+Ej4kMoELlRZODTLU81uvhZTJLtoNwGePUqNXN6mprQPq3kmhFcKNvhy2jLNaYRR1DnkUaHP4ZzQGOfIrfLDutPnS7UK8j43j8/LMY+7XSenI8fK+hfLrqdSmOyBkWInyCyeRDA55CFJO6a0yp8Rwd6QjMYomoHHMOP2wFrPz7+AaS2suR5vLheWdAr4Mqe+Hm+Au2KdrLj7uJhNnTsXndwU4jwiGXcOL2+AFhcsw+ktLlCYYhRXmfqVULM0VyOwTT6o5s8piEmyIOsoLqG0Ft4ZbB5G5xiB9I1Jp1lGhpldcHOFvMu4c+hHARbLf29n6D3UEpU3+pVHpEbGLZB0pd2xkcg+z6752L5oGYc87h57nn6GK5Wflz/RST6rjwNK/JM/5WWpCvFalXvwVpdHEi/0P0LwHTRB5Sv7gN0r/tNOHhKN55mCSDSmJONlzKfWpnjEOlDAzG28GsN/Q4eKphgVVNHwgKRQ4jdIQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(47076005)(41300700001)(83380400001)(26005)(40460700003)(2906002)(16526019)(1076003)(2616005)(6862004)(5660300002)(8936002)(336012)(40480700001)(36860700001)(186003)(86362001)(426003)(81166007)(82310400005)(356005)(82740400003)(54906003)(6666004)(316002)(6636002)(37006003)(478600001)(70586007)(70206006)(7696005)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 06:24:16.8455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9fa18a-8e61-4ccb-5536-08dabd6408d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
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
Cc: richardqi.liang@amd.com, Shimmer.Huang@amd.com,
 amd-gfx@lists.freedesktop.org, kun.liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

change the vangogh family to use IP discovery path to initialize IP
list, this needs to remove the DID from the PCI ID list to allow the IP
discovery path to set all the IP versions correctly.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 429fcdf28836..9c323405e3bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1909,9 +1909,6 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73AF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 
-	/* Van Gogh */
-	{0x1002, 0x163F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VANGOGH|AMD_IS_APU},
-
 	/* Yellow Carp */
 	{0x1002, 0x164D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_YELLOW_CARP|AMD_IS_APU},
 	{0x1002, 0x1681, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_YELLOW_CARP|AMD_IS_APU},
-- 
2.34.1

