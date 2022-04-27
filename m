Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67C0C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 276CF10F57D;
	Wed, 27 Apr 2022 15:20:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E167810F57D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4EOgtybY4WbYdIGI9e7OmIQ2BfCTIe2XiOtg5J1r9MGZDBtnVGxvuB7DL9I/9CE8gFfdfq1HmYkbg/NCa9FZ3xupvimylmi9McEPCS5KFNV9uQlZeW0/sr3a0GN+BKlP8iZ9LJl9HZjf9o9NSkED+IwRm3VyLAnn+EVSj5TbGvEU65NfJMK2kqL8hm/DOlAzIbxAuO3p22K0UzQ2V9yQ7Bu3oSHApne77XtuGcx3uHWNbgGAAHuo25QkErM+20tdUh8h9IEzXNB0tF0/YI3e3J/2h0JClhxELsmCf3cJWwOvSK2W9dv52lQFxBsthPnAofJgiRtEebXBl+oIME+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAHs4bxTuY4Hx/YLbiUAr8LDiUcDazi0d4jF0P0b8JY=;
 b=CHb0We1aaYRpLGPeWJrA+jL3ILI4zW7MaRCZmL/I1iLmMBuYs2KcUFO7MymP6s/ToMHUFwd68tmTJYeAemIc4zeCCj6n6noPFAhneUv5Zdi86YMNrrjAjaqCpO3h1R39PwMV5YQw4yD4DraykcBZOi2KuJaxltZwyahnXH3YI93KQU4OJpJrecSFbommVklP2ijrwkqunMkOR4bgqFZrHdy/a3/2rwTkP4JEeNbNOFpjBGBWju0+58YPzJ2O/KI0zGRtYVX6YkNjQFH7LKATaRIp0gcRvZwrsTfWRFFdDDuwiX0ZT2aAswoiEaatluBxHiU62WrNMQYjvzSSZ4bCvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAHs4bxTuY4Hx/YLbiUAr8LDiUcDazi0d4jF0P0b8JY=;
 b=iudVlPPgulIBQCh/mLRuVD4scR/+RzXnI4UL49MXBJ/WyzIdp4IPzDsNBKR35OjY8/FbYo14RglERz9NsN6AkyhK8eiARIIse6YuX0jO7dPhJL/LkpHthlfJNoUrYvlYAltNGxrezcnR9guaxwFgN899qkvofvOv9f/+gwjMcZo=
Received: from BN9PR03CA0603.namprd03.prod.outlook.com (2603:10b6:408:106::8)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 15:20:44 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::2d) by BN9PR03CA0603.outlook.office365.com
 (2603:10b6:408:106::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Wed, 27 Apr 2022 15:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:20:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:20:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Add support for IH V6.0
Date: Wed, 27 Apr 2022 11:20:26 -0400
Message-ID: <20220427152029.3105101-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9be3ae67-dc96-4091-6f2a-08da28617fa4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4263:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4263A27A78163866D3021221F7FA9@CH2PR12MB4263.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJh5eLiR+6mqNKEIWpbjqGd42bGYXlCyDnxZdpmglBnAo7/ojvLfREYcKPYD3eZZ/98i+ZObU/FgHwgHMyKNzEuVRbsWCwpiFJaEmv5DKdYI6g9/JOvjNR0ZcGt2Ms6Jfzb1VcLeSHA4KtKbdACIFQzwJTrhhZzLl5cFekMTOOOJjELV398KnQ61FRYyMDIxRD73ZnGWnRT/fNu5Pz4RLqQj7nPYOs39FHc1dwG8pno31SstKnUQFpIeaF4ql8QSkcge7V8YLX0UoFQhWJiKTmUaffvex13tAU3RfQtVx/PqusmqoDu6aaO7s82BUhtQy/XXPLALdtuhEkwjtSlGmXaC8b+TvWjXKZ1q9l9sfVrD3KhmhSqUM8rOUbsb3834HHioFZbDfWW4vB2u6yuMVgc7OjQUcNOlMR/HI3XFyQ18VdtS5SfK7iyE2TdPOckuC7dNRiW+QZb79zxyCs4lNNQRJze62dMmhfI+hvNfBZSft6mQCv7pfGiWjJdzel9PXmI94a0Y7QKvLpBZPhCIaR1yq2F9PUhbv98OJEaZFIkmqtufHDl5/9KmhcHvcuHVRCNDHctq+E+sRVI5Sd4Pz8agUaWymmCfE8n6Hktjd4LfIaeZXG6ihR1IH5EDJkE1zfXLkZU6NCEP+G4Mxtfzjw/OI1KpzU7PlloPJcJAK/RTG2fZgAv0aZGjdKDh8RaaUXqFz1vQHB8G1tSIvKehxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(83380400001)(26005)(81166007)(8936002)(6916009)(5660300002)(36860700001)(426003)(6666004)(47076005)(186003)(36756003)(2616005)(16526019)(7696005)(1076003)(86362001)(336012)(2906002)(508600001)(82310400005)(356005)(40460700003)(4326008)(8676002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:20:44.3830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be3ae67-dc96-4091-6f2a-08da28617fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
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

This patch set adds support for Interrrupt Hander version 6.0.
This block handles interrupts on the GPU.  The first patch is
registers headers so is too large for the mailing list.

Hawking Zhang (2):
  drm/amdgpu: add osssys v6_0_0 ip headers v4
  drm/amdgpu: add ih v6_0 ip block v2

Likun Gao (1):
  drm/amdgpu/discovery: add IH v6

Stanley Yang (1):
  drm/amdgpu: add soc21 ih clientid definition

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          | 745 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.h          |  28 +
 drivers/gpu/drm/amd/include/amd_shared.h      |   1 +
 .../asic_reg/oss/osssys_6_0_0_offset.h        | 263 +++++
 .../asic_reg/oss/osssys_6_0_0_sh_mask.h       | 969 ++++++++++++++++++
 .../gpu/drm/amd/include/soc15_ih_clientid.h   |  27 +
 8 files changed, 2039 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v6_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_6_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_6_0_0_sh_mask.h

-- 
2.35.1

