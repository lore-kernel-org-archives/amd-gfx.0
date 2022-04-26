Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AC0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB4210F07F;
	Tue, 26 Apr 2022 18:27:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1309410EF97
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/kRv2jmlWFzhduu2y2IIkyELDObVoPM7ZXN+ue2q6vkZAuw8Q+qOpoHOVjkgMjPmy646HcoFcCpO3F/yfDo1vhD3LECriiuWh46k+5LrMpPZmo2MhhgazQCa4OZTgBDZKID4tTlXpwcZZWmag89DaieGzAO10LRxKuiG+uSOhPO2DLCxk1qF1Nhp09nZgLZGJiEQEj6+kBM48a8t/T6sOVfw8uycs/fQT8TNMAoUdQ0OqXkhKr+B1fpp/Eei3iY1zhD65T4ev8RxqVuhGrEpcVZ+7nBrdKaCN9s0chTGcCc+uCqubC9iCHlNvbKlWmsNuQxQmHRcFU1Bp3TNPwMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LupnId/4eCxkreTfoxAJt4pCEK2mCLd2yo5nQ0ewC6Q=;
 b=HIqxHklgMexWz2b0G/QVPaYMU/I4KhXxUfUO/WFn1p98aSr1uWZuopVthueXeSzZgHVdKb2aR27xPzXN8P0TeQjcDRte59HwTT2h94DZEAdapLyuLR6M7hUHlkt/kwWm8pvtFaVTAav+TroHFYgONXpbG7bYhE17hU6Q3esZK6VlWMBdZwSgn4T1C1DjrfHSAEfkAsa+szWs7Ve2fcNPZIw1B9lW84JziU5aZXVVnzNuHPNGLLf8/SzD6q6T/cGJtjDh6zb2t92i9s0roAsQeu1KZDgTooEY1KHc4rFWvOwhUQSxa5/ORlcx4UdT4/Aq2r/+vDgDE+4IhSZ1bTRJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LupnId/4eCxkreTfoxAJt4pCEK2mCLd2yo5nQ0ewC6Q=;
 b=yuthEt76bGHLxO4sdJQRdPAutjWpCg26zDIB2ZLPRek3VFrtw5ln2O6EArjX4t8mtd7fSoz6L888Skeu2YIz48zE6ztbKgvrRGOsw7XRb8vf1t82ufajCa35X80zajcGSznyY4d9juFSs7HKDLqWwO7O+rKuT4itoQMENlHqu6U=
Received: from BN9PR03CA0745.namprd03.prod.outlook.com (2603:10b6:408:110::30)
 by BN6PR1201MB2496.namprd12.prod.outlook.com (2603:10b6:404:a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 18:27:42 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::5c) by BN9PR03CA0745.outlook.office365.com
 (2603:10b6:408:110::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 26 Apr 2022 18:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:27:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:27:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amdgpu/discovery: fix byteswapping in gc info
 parsing
Date: Tue, 26 Apr 2022 14:27:20 -0400
Message-ID: <20220426182728.3006737-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182728.3006737-1-alexander.deucher@amd.com>
References: <20220426182728.3006737-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eaad43d-6d18-48ec-a906-08da27b273a8
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2496:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB24962C8FDF60DAADA1FBBDD6F7FB9@BN6PR1201MB2496.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5meTfIpL+tbI5m00FkVEVrUt+jhkUyTtCr+Y522CWqMF9JdhiW+fEGC+Z8uTzcqQtGWESvTfZgWM7Py2eV7Qho8lKaymdzizxsJ/fsQAx2RadjPdMkaSyuEAOA1ywhT6SchKDa4gvUYqprY7pOiFypBwtJBSNJtjXrwwRPEzNZwD/fzbkQet6Es0HizSOR7DtlPLhbF75e+nLto+wmrH+aeJC2aNMPiw65tT/zpJA/vXDKBuHFfXkCmcxivmqHOCTvmxSV9TH18SDoVDJjv6Gc45hVl7xh40QWdRn5Tr1FyQjZmnYlTBKYECX0yQlsmz3nS6UnzuHnviISzUnNr34op36jmHw2O0mq7+6QUOLWAlb4I1i6WyBmt4Vnw7EQUD98izQCwxHOk+J8rR5t62JYYBK3Eq+D2i6ipzo+r+SdoMnJqI6iakyWIOQD3tp2RGEOJkL91JS3iReL5sAIiZ8blXe36/GP37TevKEOFLvj2vIW3Ab6IYlqip98tDQ82cDmK5pa1v0AOK/jvn2dCvMIxGIJWbT/PApjx3BQ9nUIqcjk722aFcsavfyW1d9dzMmuKd0kNohMxH4SughRkQekzjqbu/xj0tQEKZb3mHaWcL5shnhQZxIoLTHJyoztKkgKWyWatFkXnUJQHWJlI8PjENWhZvcTGOaDNSpkT9BCdyQb9OuJ3HDh0yu1YW5UhplcL1gLrDnf1M6Kkyi141CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(16526019)(47076005)(86362001)(2906002)(336012)(36860700001)(2616005)(6916009)(70206006)(316002)(8676002)(5660300002)(4326008)(8936002)(36756003)(7696005)(426003)(6666004)(1076003)(82310400005)(26005)(356005)(40460700003)(81166007)(83380400001)(508600001)(186003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:27:42.3816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eaad43d-6d18-48ec-a906-08da27b273a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The table is in little endian format.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4871bd84438e..4a793309c019 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1172,7 +1172,7 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
 	gc_info = (union gc_info *)(adev->mman.discovery_bin +
 			le16_to_cpu(bhdr->table_list[GC].offset));
-	switch (gc_info->v1.header.version_major) {
+	switch (le16_to_cpu(gc_info->v1.header.version_major)) {
 	case 1:
 		adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->v1.gc_num_se);
 		adev->gfx.config.max_cu_per_sh = 2 * (le32_to_cpu(gc_info->v1.gc_num_wgp0_per_sa) +
@@ -1230,8 +1230,8 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	default:
 		dev_err(adev->dev,
 			"Unhandled GC info table %d.%d\n",
-			gc_info->v1.header.version_major,
-			gc_info->v1.header.version_minor);
+			le16_to_cpu(gc_info->v1.header.version_major),
+			le16_to_cpu(gc_info->v1.header.version_minor));
 		return -EINVAL;
 	}
 	return 0;
-- 
2.35.1

