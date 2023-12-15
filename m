Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9504C35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 22:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7185E10E036;
	Fri, 15 Dec 2023 22:01:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F38B10E036
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 22:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kItw1m2e5XVdtHMX5b2OCASAamzKyzJsnxca0YHxac/Op0u13fadIYPbM8qv8qeiQZiv3WjhqKosCCSn2JtLAfskQBnxw/F+8c6H09nJyB7BGDAB0zydKpz25aPvwz7k4nHTjPvwpq/lqgN7gTcRWE6QRXrzcKi1XKBH9c3Gji7H1DbtXv2H+b3j3KRCC/DdIrie5dPzevaZbKX6em+Gdg/qCDFLSnESXRe2TkLOuWFaEhjMYMiQCk2ovfakOZypxeY2txIl7okFRJi288LCxxETPFyZC72yk/BGovetbMCdvINnOPtBgOpmZ6uLvuBAeu598EoXuxcCJ0Ik9xe0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYVp0sCjiPgozv2La7zNQllNMJ4lSuQeKglwh2xOn/w=;
 b=k6PjD4TKS1eooF5qrmnp1X1txWQh2H4KIIStQg2MaY1uE3nASQp0g4BPaZJs3YqlqfMrR/GvIcEa6G5xnz2cTnhjWeAsgxTRPAVhAonzW3YuI0QcUGd+tXReNz/LimKf1uSfRd8NRYWbqx1Wo9j/Nxf5W3DVm/PXO+lrEUixNqwAlsXxlxqtoQiFaEbjZdsdQKP+cX/R/2fuSpCzociOeWU89bzz+Cqk6r7GoviiZPok1RJt2Ab3rv/rd+FgWFJfTd7qx9SBok1d9KPYPh3HSERnncx7RpbYUIpnAM3WdPZhU6AW/uKGgD1sWyw7NUuW0Q9/M3JA76iLcLrzHruN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYVp0sCjiPgozv2La7zNQllNMJ4lSuQeKglwh2xOn/w=;
 b=z4x4iekvCrApd5jqII78R3odp7YR+AM5d48sJVjhJ80n/UFOlL7KKZf2VGHYdgIGEr9ip7Y1FxsNlqeDndgPYYNVFvqwdYY8qDEXpU6JWVIccB7zAdq2JshfQ8Nd2jpClaKZ94l/iO4HMevQPWCN5TfJLAdVzn+ABBBKf5dkXYU=
Received: from DM6PR14CA0051.namprd14.prod.outlook.com (2603:10b6:5:18f::28)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 22:01:28 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::9) by DM6PR14CA0051.outlook.office365.com
 (2603:10b6:5:18f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 22:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 22:01:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 16:01:26 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] Documentation/amdgpu: Add Hawk Point processors
Date: Fri, 15 Dec 2023 15:45:59 -0600
Message-ID: <20231215214600.22479-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca52f6a-ef66-41ec-b8a7-08dbfdb96331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWYUUrQDf673wpKY7LqPF+ib1vXKd4Xm09JjcuoDHbFHIYjR7Cny5ttRITUuvg8Qq8/YcZSNppXPHHQEfY/+5eYzyfNfWtd6bj8tYisfUtE1f07EXN05Hn0KOIgMlKwlDvyCTJZXtHYpAjwGnUyTxonnHeCIw0mnDM3XnYE4m21MI0HU5CwC5YifLoJyFW4Mv3cNhHvNXzDlt6qhFLzABbSHUPnMzgh7gqhDH0cOOWJfK1AqX7jgX7R+ymCB9JJzpCgeuA4iCxgBYF/CNwsc4ERv5WUH067hJqAvYhMCvbBympbXutkFyv0OiylVNYuQ44PntKn6i5HnsbpCrNF3lCU4UzFrCyThJTVNvSEXO71oyFHpjP7qtldVQ3K9lJqA4diCkZlWb88nBpTB9PMr7BnSq/pPO95zkrr7veXqoxlRimmPtAi8dXRQY9UZ6IA7iKqm6VHZPRlBNhPSxJDaqxxarJdh8UrI8vUysdTzN3+UnECha13jTOVPMXbFkpnTylFiL97KbKxOLfSAPk1+tHssw1n8LDvglQBL3bfdZz4c1Uh9Cm/a12+fotY93xh4dHK1MkKOv4TKu9XZFStboWMFG8znWCisalW1q9yBYVT6W6YkANqYJpOwJSHF52JfeugA8yFQbJ7GF5PuHWl2N4zW5IhmcjVu6YMycsXvqdt5MMcmcxPiDjNa8yphpk4Gua8UFBEUUDMiCUxnWXP6QK3YlRnX6RRqY/sXYMUo1y9A9SSfdGVw0Prxejy2h7Bv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(16526019)(26005)(426003)(336012)(7696005)(2616005)(1076003)(356005)(82740400003)(86362001)(36756003)(81166007)(47076005)(83380400001)(5660300002)(4326008)(44832011)(36860700001)(6666004)(70586007)(6916009)(316002)(70206006)(8676002)(8936002)(2906002)(41300700001)(478600001)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 22:01:27.7255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca52f6a-ef66-41ec-b8a7-08dbfdb96331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These have been announced so add them to the table.

Link: https://www.amd.com/en/product/13971
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index 2e76b427ba1e..b8ada69919f3 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -9,4 +9,5 @@ Ryzen 6000 series / Ryzen 7x35 series / Ryzen 7x36 series, YELLOW CARP / Rembran
 Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
 Ryzen 7x45 series (FL1), / Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
 Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
-Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
\ No newline at end of file
+Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
+Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
-- 
2.34.1

