Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC4FCDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 14:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E65210E73D;
	Mon, 22 Jun 2026 14:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d4E0QWLE";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF90D10E73D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 14:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=borgK6qFo7CaUKzQEcn/8GFd90fLK1ktd3RT7K1jCCBQ7zm/RzX3yLyNDwz9NlQLfNeQ819JHepoR69lhuOrafG4yXokGEPBk+JUhqdcJ8YH4uP9XaJKzEO/zyH9dQmWuha1eDtM0bNOUtms2Zr+5rPumvB5vzY0gYW0j423/7lqs5t+KzTln4tUYpiSUUVomDMVErl7xI2cnntUxeThk6zRdsEMJsMrTcG35garwu9d9f2T2ToJYrpNv8FccnLcviBNklYDvbLnV2sJDwFRSWOMZoWm2Ff86212PAPL/Wz/mymSnpjRlcxiunw3/gDtHOv/NZy41hBtVd0kxBvM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViOZfxKi26PT0z/LxUr3dXL4MvQZZNhvXOnvxRl1QFI=;
 b=fdO7nnmhI9MMhRgIf8qr9kMF/8AKX3922Q5pWu2/BwkM6UHtdYycufzGN832awNWopW4x8xgzqbBX5TzT5xQPQe6ToDozuOhxGJ0e3A62yXp3ZVY/JB6qFdTtPg01xBK2C1H4xJeMiZ1pZruq3Nbgr7gd0mTInmXvQ3SpbtuB1Rb5DbY3T7NIfMSTrHWURWsNYf6+ZBSodyPA1n6d/Cs9moR+vZdW4esPO/AlUU1c0c7KSyhH8eDbYw995nFHWmwseXPMWg76s4X7jeZlNADDAz26UvHUFVhX/4DCMZXjBXvrEIUGo6G6oC5civ/TRbTVscEMQRrpsdNra1jFfXztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViOZfxKi26PT0z/LxUr3dXL4MvQZZNhvXOnvxRl1QFI=;
 b=d4E0QWLE0bnQWBsVkVAwiY9Dx+efJ0vjcHsrySmWn9zAMf6pf/yJyaKSHL/Z6uEDYa585uokYrtVJ9tOVAoJFkulJcoc19Ph9yPoiXeFMT1Bwe7DTYx2oIzqLnRziFzKFW+Jk52yAI0caqgZ9V6rUkKPx9w4bC8O62wt4V3t1gU=
Received: from PH7P220CA0076.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::16)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 14:57:34 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::33) by PH7P220CA0076.outlook.office365.com
 (2603:10b6:510:32c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Mon,
 22 Jun 2026 14:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 14:57:33 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 09:57:26 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: bounds check VBIOS version extraction
Date: Mon, 22 Jun 2026 20:27:05 +0530
Message-ID: <20260622145706.1382846-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260622145706.1382846-1-lijo.lazar@amd.com>
References: <20260622145706.1382846-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ee26d0-2046-4571-4cc9-08ded06e9786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1Y2W4/qvJCGWmGJQnlmEYMIcKFq0HuRW6KmAPpIif7a/a/DUjXkbuNazaui1i2ZYFc/acKH74SIFQBVD8DdVa/W9cXnxBH0asFXAM1DuV8WVRG81RWiun6gkWR6ausjtXcDUn9dGsMqpUY4f6yCxlxec42xGDgN62HEBXlsqXVlmLksHokCCAvNjYrZMChTqtntbd52Aa9qNJfH+ms4XNNJcPvdIhh8UFS3hASFsehtPE7s4KISpEBDVHgDJNBTJ6dVeWbsMzsbSXccF5IHCFDUvpBaWF6GqiRzA0PwGp4Nb4J1PVtleYfrT2fpyYevz/5kWIsOdCKQ6P7aQP0Exvh6ZjlOIsto+gmgXVycd677vY67aF2J280NxU5jseT6//QHJgOC+AjjoMFtkCGJA+f5ZbJAvLNg3Hubzs7At+wsV0lB09JkmUFt5IhF6t7Xg0mvgKp5rtk8NkOtpfWAoyMnX0EdU1A7zp668tUPmQSR6PGkWi4j683ZDB3s7N5XyPrDQB53xXOyn/n9+wKSiuDKSdqnrgjkkAWpOFavQOmbYYEBdH3My8JG5q3oS8P3r0zgNN2n/vwk697Ane690cZzwJdfJW8QwYO1CQAwpBgZtOLCCOXsQtfDeSKhqskBltMkycPY91xDjADyEkBlTLJNcFy91fp8rvz9ioOIDE18zjAVu0Z4PUmYFJwq1Qh+yD8i1TeEWccY1bQScAAyx8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lnLk9v1MVWWEKSMy2AGBJYcAVo6EU8i0pQ66nz+lJr+JzxIA/+Q9aS0WpnD3kdypxCpPto8neJmO3xibk+gJdQ2jsPtrdLNLPqTStoD8b9MZNfI3qlBV02TjcXVtEop1AnVBIHzqQ649vU//VhL0XWgx0tQ353m8UvO/+dPJ+Snm9i4D8z0Hk9dujI9NdQbovImGONUd8snrsbbgS9/4sHGyGnBpwjGy26Knf97+NutXQZNW/HcfOpEK1n+SbJh3NrvVXYbsRdTRzKPiveZVdHFJiU65vSYQs17zcyispr+8zCoXCo7K3vobww/WJLIg+QoKS7JiS+HCFxqBb3jfHXzmG/GS4W6P0WKnC/vGi7Wz6n/KlUuJrQy85PAGii8PjCS5uKFs5udqvToLzp+IgGsBwQwDCe21OSjI9PuSJzkGn44+4P9T4q4iGxBanz8f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 14:57:33.9460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ee26d0-2046-4571-4cc9-08ded06e9786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
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

Bound atom_get_vbios_version() by the BIOS size to avoid out-of-bounds reads.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 07a33f94ed6a..0f6def9c3318 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1528,8 +1528,10 @@ static void atom_get_vbios_version(struct atom_context *ctx)
 	unsigned short start = 3, end;
 	unsigned char *vbios_ver;
 	unsigned char *p_rom;
+	unsigned char *p_end;
 
 	p_rom = ctx->bios;
+	p_end = p_rom + ctx->bios_size;
 	/* Search from strings offset if it's present */
 	start = *(unsigned short *)(p_rom +
 				    OFFSET_TO_GET_ATOMBIOS_STRING_START);
@@ -1546,10 +1548,14 @@ static void atom_get_vbios_version(struct atom_context *ctx)
 	/* find anchor ATOMBIOSBK-AMD */
 	vbios_ver =
 		atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, start, end, 64);
-	if (vbios_ver != NULL) {
+
+	if (vbios_ver != NULL && vbios_ver + 18 < p_end) {
 		/* skip ATOMBIOSBK-AMD VER */
 		vbios_ver += 18;
-		memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
+		/* copy the version, truncating to whatever fits in the image */
+		strscpy(ctx->vbios_ver_str, vbios_ver,
+			min(sizeof(ctx->vbios_ver_str),
+			    (size_t)(p_end - vbios_ver)));
 	} else {
 		ctx->vbios_ver_str[0] = '\0';
 	}
-- 
2.49.0

