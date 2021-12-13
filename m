Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90872C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 15:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 371B010E71A;
	Mon, 13 Dec 2021 15:08:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C13C10E719
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 15:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToitHIfX6IU1DHbmdmgMaglPOIO6p1TgP/SH5CcarLSVDzZy0L2UF1hJieA2iiRMp+e5Hy/e0dJ9ceR6F4E+gNoL6z/QmvDUb/NdX1FkIxuMF15QVGzLVQYBUL3DO1iHHwwZDiD9vGHt7OX51Q0AQ78D9TOS9E7RihxQgvtncTfsmETdn5HIkRm/+Z8cDdpzBg1vJmjwcE/etZSwWb/qRUB3EQND6e6LL+kwBj8lcNDZ1cwZl1Yf4agZQzuhMwSKD58ylTDiP6pX6vSc+UinZl5SMc3NSCa3mHe3QpHZSZOK195JLkDIWQdC8Al8SdtnsQxgyxfL/VtmBDPjTAtxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVhFzHNb32S6ayEV2v/zAqU46zZujv1n1WjZ+JGPwX0=;
 b=XXTSNaQYmzsoELtdO3btjMETeifq7ICrbjwjP4GxuCr+JByqbyCCy1XzZ2F+b57P+r/UwC4lsdQAk0OalsxmSNYXPHg6aiHqpPw/WZ/H19M3NYEV4Ni0VE93owJwnEeUrc3+Yec3IWXTWz/pCkbXT4Aohu+MOasfcwOO/yYB/fLouMfnlqOrDStMZ8AG/8SF658y/iZ58D4BOOGx9EGiFc6QxWZvrU5i6TNGd89BbYew0N/t0xEkU02nf7opORxu68/166xsyR7n1cf4xHqoGLDJd8hc3iapvh+GA7fMt3vbn0wnJiBsEAC5bYjMo3nMTKnQj+M9bzkKgZz/JHfEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVhFzHNb32S6ayEV2v/zAqU46zZujv1n1WjZ+JGPwX0=;
 b=5WvdeH3ekrWg+Va4caaiXgs635/1V9Us7Ji3+B/B0E1HdzqomUwao3QwCeYLDAsJRws1oIPnreTfRAWH+rkCPaHL8lPPShoboTXrw0DfPCBTZAYJSYMmT6zhCddxqBPPYZyWdU+/TNDfz0ho0i60j7P8RVNFLkCcX+8dYOmm9oI=
Received: from MW2PR2101CA0033.namprd21.prod.outlook.com (2603:10b6:302:1::46)
 by BN6PR1201MB2496.namprd12.prod.outlook.com (2603:10b6:404:a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 15:08:51 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::28) by MW2PR2101CA0033.outlook.office365.com
 (2603:10b6:302:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.10 via Frontend
 Transport; Mon, 13 Dec 2021 15:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 15:08:51 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 09:08:48 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drivers/amd/pm: drop statement to print FW version for
 smu_v13
Date: Mon, 13 Dec 2021 09:08:42 -0600
Message-ID: <20211213150842.21141-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213150842.21141-1-mario.limonciello@amd.com>
References: <20211213150842.21141-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45a5dea6-a633-430f-1ff1-08d9be4a78bf
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2496:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2496826685B60AE8CF0AD562E2749@BN6PR1201MB2496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TvgnRtYCsLofSufPi20vz98wWYrkonpDU2QIPCul/bX3lbl4995bZTBs0Sryg5S8Cd+kO5XBWVBJWyBCS6nxRcQRLHjaM1w8zYIjMwt20kRG4nMvxrFHTMaCBQOpMt3Mkmt5+2TdtekI69hKSy8iqr/DQXwdRKoZg1TJiKjbfUukBoEEeKelbQ811OxbZBIghIjk4ZNGeDLeN0LRfYIGOOMjkCqU8P+KMGagFHqElGhozyB6bHWSmLfr9cqUocxOGliJj6UIRs8mbdptMOXHnuXZEz23tWfqpM7hC+KTGBcjYophGF4k16WVuh52ibLM5ebyix7HVhTajpCzdFUiRaqkt/2W+BKyKHUqbUwSYQ1FpYKY/CU+cn36Zx40MxOKFHRKK3zDP1eXKmvg3wvEap5lK3nA0nJxU1jsNan4ZRKZ5fiQlOEibUHix01O+NAYsFcwy0wGWQ2e0hxcQ0eXDSbBadpeqYMUpgCgqc8wCrWtedoMCEFgObxRppOxkTqVuoIrjoNtQSzaSnkCXD1cQlsaJvBPeJvKf/qgVxkVDQs1dWHa90jTgFx4XFcBLtDC6na+C89HZQSXcLsMOFtkgEMjPz177KQ7mnals0ie3ZIwRCgwct1h8b33o2ew8y9Akkpn7pafDnnx/LzC8WqsUG/hgBiAuksH64Fv6gYGf6Igo0TZsAytbXSkfSKt6XfvY9197L83hf1AWRFfehE0vOX9/NDSDWnxEAr4JsGtAckADNPHoX9F6Cl5nbEZZSMMDxhTcCoacnCQnlJTt8JDd0CTakoFMaM/gTjKmZYDmrU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(40460700001)(356005)(426003)(6916009)(2616005)(82310400004)(1076003)(70586007)(70206006)(44832011)(83380400001)(47076005)(6666004)(4326008)(81166007)(508600001)(8936002)(4744005)(316002)(5660300002)(8676002)(2906002)(7696005)(36860700001)(26005)(16526019)(186003)(36756003)(336012)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 15:08:51.0722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a5dea6-a633-430f-1ff1-08d9be4a78bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2496
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

Update smu_v13 to match smu_v12 and smu_v11 behavior where this is
fetched from debugfs rather than in kernel logs on every boot.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 7fdb63da1316..677a246212f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -227,9 +227,6 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 		break;
 	}
 
-	dev_info(smu->adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
-			 smu_version, smu_major, smu_minor, smu_debug);
-
 	/*
 	 * 1. if_version mismatch is not critical as our fw is designed
 	 * to be backward compatible.
-- 
2.25.1

