Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFBCC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 06:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0364C8905A;
	Wed,  8 Dec 2021 06:21:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3368C6E923
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 06:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htlTlu9q/49OmUXdjcmmGJtU5yCOz25Y8ZcBy2D80ETByT1vDomVjg/GCBeBcyTmHsMy2oypz1XWH4IfXmaxBVWT3ocaeINIjxzBnE4+C8M9us97adFsjjQ3kThqRC9LIvcFZbfShvvN7XNW8M4j40xCPH1BxZp4IKF9W5hPUtPCXM6O4lSpzni8bzUg40NoUqEay5UdHWp0Ub5zSgLAy6z2fO2bxEwyViVwa696H5vWK2Zbw4pXEaulDyAz4nnPDmOdAyWBlkiHQbA9R4s9Q4co3RXjzd6Y25Oebtp87hX0QI0k5QHRLRDbgTYYLtk3fjptxHqazGEFKBaRSEGCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9NbB7sJqfZxMs58PN9mNarYkzJTRu8zyB/FvZeNdFs=;
 b=bJilKydbpi/b23Woz69ee0IHOt4/P7xo364+ATY0xAUlRNAd09spz1lpYOY6p3ESlK4nd1PhjHPxEDWpsLIkayq+z81WqyjqYbghPzUmXFt8fIyx/PesWJZrCHzuPUsiByGVo22kJdXpycAaMMRy8DEKgESNkhhjC1qDZjUMSkF5mBiHRY2zMgMlrkqp7PFstXxUSP08Frv9z5Ubeb++t5D5/40pRmD2awNMity2lTk0VAaIPKGIl+enANsqM4ePvzGMeekIIkYKVQ56potQpAB4EUMwtnSZVGhJn6fVBdC7vcTuS8EKUwsjnI98dNQddMJVMsvQsg/d6tCV+Vr82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9NbB7sJqfZxMs58PN9mNarYkzJTRu8zyB/FvZeNdFs=;
 b=FrcIfzsKKPUdj+SJ2LXnnugD9YcZ13+kIu+bvWsX/6ZUFbaUiienEF11iHlngImQkzh+pxcdgiGyCZ/oLD6XDf4kVPmabf/MosTKyylbYJK/wX1ZEsT9E1o0Vx+JiwISmW6OMf1TfvfrLpbhKdicw456JjImEmqMqJppU/7kk9I=
Received: from BN0PR04CA0186.namprd04.prod.outlook.com (2603:10b6:408:e9::11)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 06:20:57 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::85) by BN0PR04CA0186.outlook.office365.com
 (2603:10b6:408:e9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Wed, 8 Dec 2021 06:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 06:20:56 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 00:20:29 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Mohammadzafar.Ziya@amd.com>
Subject: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is connected to
 CPU
Date: Wed, 8 Dec 2021 14:20:20 +0800
Message-ID: <20211208062020.6445-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d96a2bb-a909-4da4-1983-08d9ba12e56f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3515:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB35151DB2DE7AA34FF4A77701B06F9@DM6PR12MB3515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsTsurRuocg8pt03LNGHOpki3++XN/So/et2LgnN+0FFKfgpE9WubzEibIV278RQmwIYQwZYhk5nsgAahhxrnGVCNaRRgv+GxyVLTum7ylSmHQL7IoSQqEG9FRjQt+38CdcIMi/e2dGiEIj+ByKylEHK2N7gen6n8jEhaWIqt4Ogq63w8O26mw0YDyTzyykekn8jSRfGV1mkDDjx8t+uv9r2w07YocIBmLmUI1u968KNaS/rtO0yFC70zk13xOnO7MOv3uSM4e8w/6cUdlyaucRdqMA7XxfRjQYxsSBDBms9Ygbk0LznCUJB9OywplpN6vMv3JikR1L7EMncetrn/Pt5FdoAipYzZbeydHkY+KmWAjvCFTN3Au90CplgZGe9b6fxB4kpagdzno2bUP56XKTdUjTNiZTHht6SwrBoMS+UJdb+zBdHeSXswjR+ZU6J1vsqQiOrIMHXwr792ar2eBJrBzJjwkzebVTthq84wn4Fs9xLC2X19FThQ57gfXFahhpmFIevPAcKBQWdjSvQv/hUYmEln+TmTVYgi1Gn+VAATF481k+aKZamV+pEgiVBquYuc1NaigRAu0Vsat1mYZRU1kUgsfvDDlrs2cNRJggIIaIaiNPCpzeRnEKJDGgNV0C3CjJZ9NU1fEzc7BRJpOe710TEkugzdRLDoghUV/UoKppstcVDsuD/jz6nFkc0FrnwfxHb483AU1JKBHmaIvD52GcruJ//RsYEEXVw0h8S4N6YeI8ySQj+Dm78Z7Wk5OauAzoUjCD/pyiIrnYJVtDulYohIinhuQp9h61aCPU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(6636002)(36860700001)(36756003)(7696005)(316002)(83380400001)(86362001)(110136005)(40460700001)(70206006)(336012)(6666004)(4326008)(2616005)(426003)(70586007)(16526019)(4744005)(26005)(186003)(82310400004)(81166007)(2906002)(1076003)(8936002)(8676002)(5660300002)(508600001)(356005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 06:20:56.9983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d96a2bb-a909-4da4-1983-08d9ba12e56f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The RAS poison mode is enabled by default on the platform.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a95d200adff9..0003f2c64da8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2372,7 +2372,11 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	}
 
 	/* Init poison supported flag, the default value is false */
-	if (adev->df.funcs &&
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		/* enabled by default when GPU is connected to CPU */
+		con->poison_supported = true;
+	}
+	else if (adev->df.funcs &&
 	    adev->df.funcs->query_ras_poison_mode &&
 	    adev->umc.ras_funcs &&
 	    adev->umc.ras_funcs->query_ras_poison_mode) {
-- 
2.17.1

