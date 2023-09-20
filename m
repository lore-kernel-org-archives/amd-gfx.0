Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFD8C04ABF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 17:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A71E10E534;
	Wed, 20 Sep 2023 17:59:03 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E67310E533
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 17:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbEWie1aX8CITfxlboEMa+C2EhQ8To0YYozaueAwQVszPppWEVM9+N8KUTMpdZWt9jRBLytz4AyCca/pfray+1wBj81Xw5/Jr4w69mpRctXckzg+/cQmAci+x7StD1U8ORcyIH9k34r7j/XOZewuYKn0iOOq63oMDPcM8t2mZmC+AMUIc7LmMXImDv3FaJ6lQtownvrV9frYPZ9OAXXl3Pl8uHVOZyq/MSQrqY7Ls2LGUa1oXnbKYBydqKjP/n2kXzvOrU9RgLpdLWpzPM80cjgNtXrrr1ZSiJ4Hl8cdpWc8uGmzgkoNgbapDQtWRJmWNQcXMktNEICHI58EpQiBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1NZozmG01Y6n572d1yXYvGODhzg8DAL1+ijg7UN/c8=;
 b=h4XJvIDwZ2A/K9vbGQpnimhzIwLWuDwElRxIloCmRuE+PRdQGp038thaOZ273EKqABJ0s73aB5EusRl7iQyXxu1Zv3szzzQvmh/feujQBGR4mEvw2UYxkNwTGOEmtQnYLAxDiPtYMe89nLSup/xTJDXeI5MH7ecxeBG3+BjZQ4PYJltQ0+7xURkM/Y1n/uHLkQUQKYNNEvNuRw48cQuHJBHUF3JfhqfjBevNah1W/60FvEu0sQWzXD0V2+FpiSRpX+9kkIEK5in/oXjG9gxiQwpcn3FXaXmMU3BgxKU+XiXa4xuAAQEMN2yZu1N9J64AgpfwRJOAQ2M+/NPR7khi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1NZozmG01Y6n572d1yXYvGODhzg8DAL1+ijg7UN/c8=;
 b=NIP/72/E4P/f1BqDOjUiAVu4v4wmGwas+8IlswlPKWLT/FpSsf9YcyLSdv9tau6IcjEsKegipvjZYEvRZRpb4/zubPFJyjh+VlAqJe7PVp4PL7cp2EcqP3JmrXslX0Es2NyTrIMJbpUY6+7hxG3ADGASwND1oRFjA0+ZEzJtnwQ=
Received: from BL0PR1501CA0001.namprd15.prod.outlook.com
 (2603:10b6:207:17::14) by DS0PR12MB6535.namprd12.prod.outlook.com
 (2603:10b6:8:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 17:58:56 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::99) by BL0PR1501CA0001.outlook.office365.com
 (2603:10b6:207:17::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Wed, 20 Sep 2023 17:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 17:58:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 12:58:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/gmc11: disable AGP on GC 11.5
Date: Wed, 20 Sep 2023 13:58:23 -0400
Message-ID: <20230920175823.3099627-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920175823.3099627-1-alexander.deucher@amd.com>
References: <20230920175823.3099627-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f91595-8997-433b-740f-08dbba0341fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZK50pDlDwaNz4JxoviDWT6oJcUb0xCmJ6n7qpxlSHCCZWp7Ibz9iZEkbUrri8kyI9gePJtwdNtzrZqcxKNFENCghU/1UQZeDBUtZ1xb4AlE/axQSspWBPE3GSdPi7qhn/ZuCAcMJWTvTLSf9vjWxLGu5iB+5V9yxg3XjSra692CUrLtQn0+buZRm0U/yt9ZzYB2hIW0AGOxsPEqApAZEsvkG9S8T5xGx/WGeUbxUF73fDkQ9hh3pjOObae1lozO2EEomI678UkgOjdYo2V3gJub3s1ZUgwDVRfNInVEcQckDGCXOmi4yIPPuyzq2ngR4FAnCkoRQWoGHN3F/RprwRUvPMljMtxIx+riweheO4PrERrLkB8w58KPcEYyF/dkqsFJGfezsI7utkiWs0/lI3zOzFeQpxoCDYuSr7dgGGbZ+/9eOkpH3LC4hy4AemTodLPbdDqSPCMncs4P2Pi/YgtSorQtuWKX2yhTc6VNQxw0oBCNTg5S6czP5KyaYGrW5c53GmLRmgEczZaYSELGKqv3FuHiuTPa3Caka//7ZWY+j2JVrhdc1E9nxAcamapv+0dd9GznvC3Sxfby1pHn+aPgaglPfWdsrH4O6wzEDbBfXeV4624nMx1FBeEpCItUxXoLMOlJ3MCPIbkHRgSosSVCCPHu0f6HW/46/Fkyk/pyzwcngkRjXBFCqmHbWN9Fy4D526U4CXlucMkExz70bMogVwfzARKE2Vb0pZZHxwHwnxPqQIqfodPLm8G2bEEbRRHhBYwltRp9ShGl9PUFgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(6916009)(70586007)(316002)(86362001)(4744005)(81166007)(82740400003)(2906002)(36860700001)(356005)(36756003)(41300700001)(5660300002)(47076005)(478600001)(6666004)(70206006)(7696005)(4326008)(40460700003)(8936002)(8676002)(83380400001)(1076003)(2616005)(426003)(16526019)(26005)(40480700001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:58:55.7320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f91595-8997-433b-740f-08dbba0341fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
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

AGP aperture is deprecated and no longer functional.

v2: fix typo (Alex)
v3: just skip the agp setup call
v4: revert back to the original model

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 28dc08fe542b..9de5659ecfba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -741,7 +741,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 	else
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) ||
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 5, 0)))
 		adev->gmc.disable_agp = true;
 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
 
-- 
2.41.0

