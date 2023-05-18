Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFE4C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 15:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC6D10E13E;
	Thu, 18 May 2023 15:07:39 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A9610E0E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 15:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUGfWmqgMoAxGoJ2I+pxeWOVGyWHoyhWMURXP8XngHXnCdEgsKJ+Sb/UxXbYuVGiXRikerKTScKLOgkR0caFsIb59vmw1WgJdBAOLc4yBxHdJEZpoJSflN5Eoq0LR6Qyv9bUVrKgjj9oN9XN3uut1ePcecY87UvYA+dxFcAibcyfeLFarv8UakADaIiogSIvSZNiiYxWEZG2LPVg1qvh4JLRDcEF6mfKzhmWs6EvubnUVF+6C8IT8Ipct30ac2MAoQu6DdluDEGL9kruvDcZVqR9nhLPKXGb2HS9s9reWRk2GbfjCkNt/JfX43cy5ggMY1xHWHeq8b8en1tFAWzd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bukXplJhFyfve0HBrFVdEQzHolGQJQv5+yvs8DrLNI=;
 b=E/T5svl1Txa4pOwEIEu4wi8Ld+i7SB+/cpEJB2inWUUL+tB/Ykmfr9qJkFtpMzbtK95rRc5QVIUNtmCxU3ayGJmZyJeJjtc0D1XIJ/URUm3ORBi5DE59oV7qFSr84gs38A7wR6XuzHbr3LkZY23NNGPpCP4KN1mxXbxzYajSoS60rdTFm4qll5VDklqXbfaKIrdTrICHUbAEARtPPEYcEP0+uTzBleZLYQLG5ZQAsErA78meqj6B/jNiUijQoyp5vnV+ouGdlilFuvGLNlmc7ZcWzIElYF0PP/STbFOmI0vfpK/E8q/0HhpRt9VKP/V2G5WN9wvPpm7Agy7FAMA1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bukXplJhFyfve0HBrFVdEQzHolGQJQv5+yvs8DrLNI=;
 b=ZaeeAqG8aG4UTs6DAeYPtlISFRgQwaQulyelNymKIp8DliHyY9Cpi8wBKqcAiU3dOaMU8b6rSooo40ypv78d/37bJH1ABiUe8ZfpNs8sVtVBj5sAnn0R6Pf2ExKPDcx8WnbuAKye5DWjXwyskx1zVq9EFwqf7whWXEtZlZXh2YI=
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 15:07:35 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::38) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 15:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 15:07:35 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 10:07:34 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd: Update driver-misc.html for Rembrandt-R
Date: Thu, 18 May 2023 10:07:08 -0500
Message-ID: <20230518150708.92286-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518150708.92286-1-mario.limonciello@amd.com>
References: <20230518150708.92286-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c6e9d3-4681-4fe2-51f0-08db57b19cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDPEuJBj4JvbQzQVDAr1LdZfdOzX9CNkL/xAneK/NlioOoeqT3SmRvVk2XlxAMMYRDg3b27KykOT9kVl5MA4PCcIwCWtKE3pcsitvooDFM3H060FVDyqOPpB+9Sr8U5A09P3AXLXRfWIcpq3ODdbs/FqfKcF06HwVSe7u6JzqXEDkP6Egqpd0T8Ee8usTNBqKHFj1cdAa8GmkwqfMSZuClgorQR6mvJWR47kPn5h7TXjOJLt3x6k2Txrp2ZUtaHAYkFZB9dSybDsc0WBFa8Fkz3b7Bs+YduMZB0M9co8+4mss/b3ErSfFKXkfCVgPX79EUYxpForw3WoE5XXk1PWA7ANRS7NHznAE68y5WTdsHTTxaLAhtSfa8Sa3V/vzQY8I06g9G3a6CvzwyjTDyUPqvVmv1Mo/zQEIPXVX22EKN82yLDSLGCHGeZDGjXOZntavR5QNkcMgx+uAp8zAeUZ6zLFw1Iq3n3ZQ7bWuFtp59viLbZPDn842MD3P/dWd9K+7OMiqghvrU7Fffawl8T8sIrVPYSO6cMk7MyEjg9ydFLSnPP0n+iTOCMSqrzXDtS3DbMLS4wbMvVD4btYfjV9fK5UdzVW6phqCBkTWEarwG8AvzpbfZdnziT9PbuS8VmH0dKpMzp5f583gy/dpkC6/94NZa2GEDzN6ilxqms5Gd8B5Tx4gAUIpaZ9IvsHiRk0fu63SYcaC9ltOmWJsYNWyPovU35Q97W0BxVbOv22riKyUMdoU2IcKlHOUZDHPAyyybDOPSzdiB3t3Wd3/aRa/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(316002)(2906002)(478600001)(15650500001)(41300700001)(4326008)(6916009)(8936002)(8676002)(44832011)(6666004)(70586007)(70206006)(5660300002)(7696005)(966005)(26005)(1076003)(40460700003)(82740400003)(356005)(81166007)(186003)(16526019)(2616005)(83380400001)(40480700001)(47076005)(36756003)(36860700001)(82310400005)(336012)(426003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:07:35.6804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c6e9d3-4681-4fe2-51f0-08db57b19cf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
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

AMD has added marketing information publicly for Rembrandt-R, so
update the APU table with matching versions.

Link: https://www.amd.com/en/product/13086
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index b5c67059e9be..2e76b427ba1e 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -5,7 +5,7 @@ Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2, 11.0.3
 Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1, 10.0.1
 SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0
 Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
-Ryzen 6000 series / Ryzen 7x35 series, YELLOW CARP / Rembrandt / Rembrandt+, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
+Ryzen 6000 series / Ryzen 7x35 series / Ryzen 7x36 series, YELLOW CARP / Rembrandt / Rembrandt-R, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
 Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
 Ryzen 7x45 series (FL1), / Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
 Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
-- 
2.34.1

