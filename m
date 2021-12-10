Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46987C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 03:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43BDD10E2DB;
	Fri, 10 Dec 2021 03:20:44 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9099E10E2DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 03:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7xmF2kA4u5z8uAbyd5JvXXj96RzyokHUoEM4BDqB3Xy/DUSbgvvHEIXUa6PSOBk8N4PnFCYaO6bmKyrUVbrGcdV0ZAs+Xz3nP1igcFF150M7PaaVqBEeKoGeIv7s59Cuk5fulZw+Q0VQVLgFOBbMMMxPnO6moFK7nRjvGCXa5JiKTjGeIOdXIfLiMWIVMAxlFf1tQrVWoomtpJwYexLz8vwsdemMs67ehoDQxiBrQt49fcM3gLVSa0XQbuehLq418m9w1gJ6AIqeGVOZ/Uo7PLVlAqWbff+pIKU2+3H7EOQEvVqWSafiufMYlscIGtTjvO8SSLlXSI4k21raIIbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGJd/0kYR7pZqhAnWLL+dN7pCniEmA6zMAPwdV61yUo=;
 b=meg3nnwf8BNsd44/pU/ShvvGI7p2otPsIVHtjandoGq1++mIzh5YGMUwN7fhW/i079Unqz5YYBpbKRKXnzCy3S+R345B5xPm9Ot4D6q4eNlDWjCPz1LcPr4Kq5OfBp+7ArDyLDI7AKhZ4BfioWbNKScVNUidjfayqEUGD4h6VkXU3O0LYk0ff0wVeMj5e57LVdhVBRrIQ2iGw2ORKmNrcwhv6aWkT8RWutxNuVX45n1sTDLhoWARyA0k+jw6SFdrmeHQzQ/w/LPnfsUhF2RkzIaxLcx8pIaMz6X1KoMESdDQGZLtT2/d8GRw5L8K6meRJiFpzM7c//rtKuhbiYXljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGJd/0kYR7pZqhAnWLL+dN7pCniEmA6zMAPwdV61yUo=;
 b=BieSWmBk6rXGQa7vlgtIwS01Y3v/BbppMrZi/kxTg84jINwCGs5rneYBMsnbMObSDTLlfGc7ux7P81UgbERjK+dIoh42o+E4PSVCyBZW/1nymNz7gmwQwk/Yw77bXZWPPn9ulSvQTHcVfMWQ96pm2WzeFCYG+vW/ZfCSORc5nvI=
Received: from CO2PR07CA0065.namprd07.prod.outlook.com (2603:10b6:100::33) by
 MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12; Fri, 10 Dec 2021 03:20:40 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::28) by CO2PR07CA0065.outlook.office365.com
 (2603:10b6:100::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 03:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 10 Dec 2021 03:20:38 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 21:20:37 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable default navi2x co-op kernel support
Date: Thu, 9 Dec 2021 22:20:26 -0500
Message-ID: <20211210032026.1275383-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 106fb417-ac41-4214-4917-08d9bb8c0a3f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3008C54C6C89111AF1CC61F285719@MN2PR12MB3008.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9w/FHjnkXYwVq5KMR19nJvFajXIFV6YO7NwQ0tP6uF6ueKFYWzV56+X5QJonBAA3Lq8mml5XXs2QXjjaN2InFFPf5dragin+Q8NC1dx7XVqZAH2IXOxjyNlLGdlkywbYvKCm8ixYbBMMmDFjqDEinkBHHUpOasSiLcsL5nLwChqZGE4KQ+XLKUUrVqxqwVIbMRE3sZTg/1Q3O911owmzIfuqzQ37jmVa/jlbGHo4CcTVCO+Gy+lUA3XzmBH2uOJM9w5M8JyA41F2euD+4bJ1CAm8eAN27aM3+HCgpL4G9JZcMtLiNSFp0wCm5iYxIW80A9LRQ6qTXXS4vC+vkrM6dG5RXwlBwPFBIx/c8Hm1Vi9U83nLadrvI6k4UGFk8gM8U8zJgjGGhwBEtZVIW64jsv7yCc9KxjLMjNd2/ki2Z9ynPDPyf96xoeaXqejx/84YhuK/VxfSafhZ68gxxbiewC4G+ffC1s/u64QZ4ZgtGgNqjIs4+XKQOvITiWr0Iis6s8ILCG/3GugYvd344tTPzO+URROqA1xkZaM+Z4xA6LgR5ZkUjl9asRh0DJrWVz4I/lB761EqXFg0rKAf1LYq3uydoxEh0ShyPIhBisr+BM5y4By63KPGDY1ahhporWOXlZ1vKyS89De5qnAFU5YaS2lZVbei2dNOaKxvledTye3yeZOOAiNypQ2dO5VH0JTFRFIGe6n3DE93u65mO4xXYmaq3u/22BPEOXmrasN3kYFnkkgT1VUhKpFuJvPpuPBsoLCmlnuygVKM9J44aoj5/Vzte7sKWwja7B/60uJXi8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(336012)(426003)(70586007)(8936002)(26005)(7696005)(5660300002)(16526019)(40460700001)(508600001)(36756003)(316002)(82310400004)(83380400001)(44832011)(186003)(4326008)(2616005)(6916009)(36860700001)(70206006)(6666004)(8676002)(47076005)(1076003)(86362001)(81166007)(356005)(2906002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 03:20:38.9808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 106fb417-ac41-4214-4917-08d9bb8c0a3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3008
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Graham.Sider@amd.com, Joseph.Greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch reverts the following:
'commit fc547b2b1816 ("drm/amdkfd: add Navi2x to GWS init conditions")'

Disable GWS usage in default settings for now due to FW bugs.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 67dd94b0b9a7..facc28f58c1f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -368,10 +368,7 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)
 			&& kfd->mec2_fw_version >= 0x30)   ||
 		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)
-			&& kfd->mec2_fw_version >= 0x28)   ||
-		(KFD_GC_VERSION(kfd) >= IP_VERSION(10, 3, 0)
-			&& KFD_GC_VERSION(kfd) <= IP_VERSION(10, 3, 5)
-			&& kfd->mec2_fw_version >= 0x42))))
+			&& kfd->mec2_fw_version >= 0x28))))
 		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
 				kfd->adev->gds.gws_size, &kfd->gws);
 
-- 
2.25.1

