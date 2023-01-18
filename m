Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506C9C38159
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 17:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2050710E7B8;
	Wed, 18 Jan 2023 17:28:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F6410E7B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 17:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5fGmHR7fXpOSfeKK7qdsJF4MzmqnaFOGtS7ke9ueDfGJYjv+RMXEgZLUon98qa/b0qFz0NrDi00sZyESr42UEdxY51oT+gEhXrlOiMmUQ28uIypCO5bFXMjqGoe3dcuJfVEtV6Aqiz2izwmciN73wcTYPcnZzXMJjMXoj+gc1b77HGKfYgaKXNL/LUyAgvuEfSYlh6cwNdatJSmXu5+w/8CC0hRiu1re0LGWLG48EKScCj/oOysRE+UDftttyACQ/qPgPd6Ie+VwYY8q4rAzTaUFx2GEuo1g8G2H3K21jjFNydR1YMMZKK6H8rkrHBmTHLvdU+Mk92PjpsvjCBg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nVfsVNpuFeLaVg3aekbFc3ijKaldvqSIFYDSQrYMB8=;
 b=AUxxAMIrFVeNNniAz+sst41PGFMQiyNvgkIjlADAqxI5BW0PRblYlYYjeKJ/0THkYAoWMqrS/3MSjwzo0A9nzuBsmDt/umyVx7m/kb8bXdTmYHGDX26ixJcM3C2WtHDIOrX3DuZJU0zV+AXmO5uLxnMo/NIKz9euGwCgF3VYo7kox+AsWNQmJN3R/faX4Tlbf2iJiZ052C8EiKL5fPmbo8qKv7odDlQT7xS4gU1rli3I0g+XAgDx3CtwPvCAEvoeJihUMLaAi3OyCQV4uWGr/qjMgS/e2RnqRLaDdQ3WbsZ+eo2l5kZH4SeLeWLsDWZXm0PTwzjwkn+CVwLBrpAG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nVfsVNpuFeLaVg3aekbFc3ijKaldvqSIFYDSQrYMB8=;
 b=Wl4uZIkwUJgS9+0dcy2355gQUl6kQ+K2RXP/l9/vdVHKqIb/WwMJfCqoCyJA9DoFatHFyisRQZpWJ3/FY8BWMlyaDdvXvHSNoJXa7nQIaPdEtd3pzMGWU470Wgz1r5SW3jAOklcbBjjmjLT1DsKTtR6UFkeRwBeZVrzk2qokZ1s=
Received: from MN2PR13CA0020.namprd13.prod.outlook.com (2603:10b6:208:160::33)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 17:28:41 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:160:cafe::91) by MN2PR13CA0020.outlook.office365.com
 (2603:10b6:208:160::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.16 via Frontend
 Transport; Wed, 18 Jan 2023 17:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 17:28:41 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 11:28:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] Documentation/gpu: Update lines for GREEN_SARDINE and
 YELLOW_CARP
Date: Wed, 18 Jan 2023 11:28:39 -0600
Message-ID: <20230118172841.5690-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118172841.5690-1-mario.limonciello@amd.com>
References: <20230118172841.5690-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 0751b57a-c620-46d0-e733-08daf9797120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpQa9S23cIuBT0U6ym3/399FMWLRy2iIelRZtgRvH+h2f+wd8mrptfdqjd11F6noAkYFVm4wUWL6JsC4Te3s1hZ/BvNED6ePMVyTKiS4cbo3p4E7xuPBgJ3cj+QWHauq1aK/YKuxCfc7+cf5MRT17Z7fpMphMbXu21cLd3nVa+Hv0fH855PdHVZ2C68hc0RARvS214cLY7c0US/Y0Lh16/dzdWVeiKduAtY32C5HU1OttkyzeIFkYiDcXHFLDGTVOWxTD9f91rTBXariox+zsba+FY+9IL3QJKrM4ZYeDVNLRQiMQpHvwCZW2WnN3aPhPWOj5M0fjBd/mJze5L+cofodho9vIG1eehJsBa/kiEEAcEAqfPHNM0dPT/4gh1HPcB1YaLhyVbOwaT7rUObbpJO2l2gJZjOev2GnoeqVDLpIlxxVrZNRXP9iBgIoOAwMJl5LkVrzUn9dloKGItcbHn8t4GDB4V//FbMDYjkSlWbWzVGhc9eg9h5ibaDgTJwvlm2H3Un7QJh6lnVaSxovXe5M20oC048MSFT7tu9yLcEWSBbI1kAh4jSHHgaHVw61WyxgVNwxG/qVqI1aHkT0KQGRlbeZfXwrMBDDww4jCTLxlnHA8IHg4ByYQtmlSfKzb4SgvpE5UVfUQC+vz+3Hx/oXlsJI2/E7yA0nbTcriBcGXUhunRzi/ssm/wFPQdUFBRJg1HR41ILgE9lPa9SfxJsgG84+JJDGYCIV8xOVjrQmeLd4mfvfHqsJZBZvsJm5zWeBJUyn+TcN8eldJ7w/0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(6916009)(478600001)(966005)(8936002)(44832011)(82740400003)(5660300002)(4326008)(26005)(40460700003)(70206006)(70586007)(82310400005)(8676002)(36756003)(41300700001)(2906002)(7696005)(54906003)(40480700001)(316002)(81166007)(86362001)(356005)(426003)(1076003)(186003)(36860700001)(336012)(16526019)(47076005)(83380400001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 17:28:41.0218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0751b57a-c620-46d0-e733-08daf9797120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
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
Cc: "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These products have launched, so add matching codenames.

Also AMD has announced that both of these products have new refresh
variants that launch in 2023 using the new naming scheme, so add
that information.

Link: https://community.amd.com/t5/corporate/announcing-new-model-numbers-for-2023-mobile-processors/ba-p/543985
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index 6e14ae82e97ca..4ca544a377e16 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -4,5 +4,5 @@ Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN/PICAS
 Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2, 11.0.3
 Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1, 10.0.1
 SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0
-Ryzen 5000 series, GREEN SARDINE, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
-Ryzen 6000 Zen, YELLOW CARP, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
+Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
+Ryzen 6000 series / Ryzen 7x35 series, YELLOW CARP / Rembrandt / Rembrandt+, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
-- 
2.25.1

