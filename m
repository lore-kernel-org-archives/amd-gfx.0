Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775CBC3DA6D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 03:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC90710E11C;
	Fri, 23 May 2025 03:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pQiccLCo";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D851D10E1B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 03:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIRvZpLPxHBQMM6e6dMAphQQRoodjM4Msc4LDIBMBhZqJN3Vbjtfy1dp480pGwDy/zWtiNhxfEoveKvH8EeaNmu8EOlUD9+RyTT8M+DFnlGzRst7OxGHPWavYZdMl1ogAZE8eULxAgGqat5E5kyvYTEEn5FoNkdfc7b2iQCNsqOXbNOz3xQGI614yCGjeLnBxT6e++Lql4TPI24f4D9CnH4FQTGBHstI+uemm+NStwckKTD0C/rKjyYBgK5KmNyNL12X+bhvHVWj2+hIzHESEXmhi2/XiqR+wS2NbXibq/K9MnQPLIcACCZFnp4GGV+v0oXbEYGDZBF4sP37mlClCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFCzp9XrT2SSVmZH2/dH0DKlxdZInVNGBLO69FqNl/M=;
 b=Za+llgWkEKCAtUpcQaattfVQyKRWB+j7qDPmhBYKuQVpR0AUCzc/g9UtBgseX1zKLU//On4U93pBl/RR23WInJQeI/fBs9Cm8r4buTA+RSMZyddgmrsrumJY835vQ9bIXeoJX/t1S7JxEv5jFimaq7/Vv+yIrq5vmhGjehS4QTDLMw/3tHZQq3qtfj9n4HQoZJM/iVERbhFkpXdX6V426l7gQWdyI2CK+PtE2pVBHQkttuXa0bRA/EaxNEullwK1cxMEgrgknfU5Aw4F5lge4LNCshoUc396T4gDR6XYQO4wJI5PTlTRjmY3sifznCRxPXQtE+GP764T2zpbOGBCaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFCzp9XrT2SSVmZH2/dH0DKlxdZInVNGBLO69FqNl/M=;
 b=pQiccLColE6JiSubp1EBmREnyOsOJod/ZPkm+JMsdv9jw7SFPkwIBGw+3j5wPVOjnkcOnl6j3MtkcQfmDNVYY/a9KGjMTYJaLK7YIoWDK6lh5+fCX8ehxK6Ir2yxINnKKDalpZ2sqKLYZU2sjkDKRahg09t65MUA3pjDDWp7wag=
Received: from SA9PR13CA0036.namprd13.prod.outlook.com (2603:10b6:806:22::11)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 03:53:10 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::4f) by SA9PR13CA0036.outlook.office365.com
 (2603:10b6:806:22::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 23 May 2025 03:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 23 May 2025 03:53:08 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 May 2025 22:53:07 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Get mca for old eeprom records
Date: Fri, 23 May 2025 11:51:55 +0800
Message-ID: <20250523035155.63467-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523035155.63467-1-ganglxie@amd.com>
References: <20250523035155.63467-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 2572d276-4ef2-4ab5-8d56-08dd99ad54ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xMjC+b9/32D8JNta+d04njspBLZLEsawLN1LKwJVjZHhKaxyKF9hQbRinETz?=
 =?us-ascii?Q?+jEqgXGcdNQpDhJs9jrZbDlUCdPQ8pEZBCjKX6fIqDETyd1doI+8cVEb5tQP?=
 =?us-ascii?Q?kFbTEJuSn0kww5l/iS547lhNRThIv+B/OWM05YNFf82QO8NE+EsXfZ3kr5H1?=
 =?us-ascii?Q?tfOuPmwPe5z2IfVpo9+OX9hkAxfS/dYTGvqM6bsoNxI0gZqx+QazPuFIMnEv?=
 =?us-ascii?Q?Sz9D9vWI8+Q4ywg0glxdLZGm21ia1IMIP1uIVrEkoZkxoYQ+99YqjI8WdJA7?=
 =?us-ascii?Q?eulT8aVt3WZeP0KTgqxWLit8d0yiUrYFZQPHQSD2pPpa5zVA//lmwbNR2wuj?=
 =?us-ascii?Q?FBHo+ZmJoh6NQuqaf9lg2UsAKWzhnmE4VKyhbE1HH5TDmWMbMDYtB5LnzVlw?=
 =?us-ascii?Q?Md0hpGkVBBh5w2iHqF4CeU69t4pgBDdVKQ+Pxxfuk9kvE++L1aMBPU0S8j76?=
 =?us-ascii?Q?c+ruH2VWQNpcLtAOKGWAgsuugzapjA54DZpgvEoqyR3hJCmNPD8FDZd9W5jj?=
 =?us-ascii?Q?dK1wKdG2UQiZ8izD/m2kDlbHsXTIE8f5nbwFZ3kipIyKrnospxN6EtpPz6Ng?=
 =?us-ascii?Q?vTDiscKOD9fl6qCBvb4u4Bq4/P5ZGYt6lzTX2W0GrT28xiCDgv0C8sFK5QlB?=
 =?us-ascii?Q?dGb8rDfgZNoMquuPla6zbAMmVqeuwgdfjPW9Zj0fHEoTlsSs7ipbKyfRNmiP?=
 =?us-ascii?Q?FpdBS87e7m+x0rEP3LV++299BYdM5JWczlKUJ50C7ubU46W6bRLRD29HlR5d?=
 =?us-ascii?Q?c44oJRHrxUuQgNmDEl/rYZQjK1LQfXwqK4oZTEAf4W/xka4I/MwwnDGAzjkN?=
 =?us-ascii?Q?tRtU96zCJNnlm4SLaHf/kp0XfgW5NYx1qFD6RI/LSBoHgi0QzJupyRhrLetX?=
 =?us-ascii?Q?ufRJXZvddAoHEurZ0XGooPok7CsPEIU2Q8PztZ5SbIo2qxuqdGmgjQI2apaF?=
 =?us-ascii?Q?K5OVIT10ZSJSt/foQHCvSfrv7IfkorIqj/0zxYkh7R7CjwYZlRMfrxs7cOXr?=
 =?us-ascii?Q?KHUk+iqiKbGYZZplxp4cBSvXLCwcfDxqusCEkR2TCrUyiXiSOcS3HWesHRLG?=
 =?us-ascii?Q?gwzwA1+LMC913Xwz+WOo0wV9yLdy33/qk/mu/i9e3/TpogLVN7dFKv2TY0m1?=
 =?us-ascii?Q?QaU51TGfgryAl3D6Cv6tgnZX1VXQezbtV+g+fYpPH/Nqbf8twD57Vrvm4jjq?=
 =?us-ascii?Q?Xp3rDQ1f65lnSBwOhgOw6ykux3jal/XOHnySV40+MwVCf3/IqqW8Blvxnonn?=
 =?us-ascii?Q?KgYdBWCk5LSUsY080F2VHa0CSeaHCHj4pczVkpgiMw+HJtPDOa/OwkUZn0Gr?=
 =?us-ascii?Q?Dydl9/7vjXbHlbGEbklIRMHClyXoVD2Z7r+uZJD7P44/POIcE+lr74wAmVsl?=
 =?us-ascii?Q?1VyQK9rx9FOeYn2q/+3QwIk0AyQXzFCudt6XmBJRf28gnPRTXQ9gddFaqce5?=
 =?us-ascii?Q?lpYpmaVldAgBJpsipZkglUUYf/l2bTNZctRZWiZxUq//koQwkfyVgcuKXt7k?=
 =?us-ascii?Q?PBkiOd9CoSQQ0X58bRcTwxmBaDkjAAOj+NOp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 03:53:08.9114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2572d276-4ef2-4ab5-8d56-08dd99ad54ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266
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

after getting mca for old eeprom records with 'address==0', it can be
correctly parsed under none-nps1, or it will be dropped.

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7d4d31c6ab48..f943b9107067 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2860,6 +2860,12 @@ static int __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
 				return -EINVAL;
 		}
 	} else {
+		if (bps[0].address == 0) {
+			if (amdgpu_umc_pa2mca(adev, bps[0].retired_page << AMDGPU_GPU_PAGE_SHIFT,
+				&(bps[0].address), AMDGPU_NPS1_PARTITION_MODE))
+				return -EINVAL;
+		}
+
 		if (amdgpu_ras_mca2pa(adev, &bps[0], err_data)) {
 			if (nps == AMDGPU_NPS1_PARTITION_MODE)
 				memcpy(err_data->err_addr, bps,
-- 
2.34.1

