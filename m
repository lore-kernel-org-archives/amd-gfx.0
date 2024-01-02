Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4996C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 03:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D6C910E114;
	Tue,  2 Jan 2024 03:45:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8ED610E114
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 03:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeJecnI1WRU/oPBdqq/uxpq/VHgaxBeJ/Kl8oZlYSTrA9xq766gBhj4IgmrkPZX/uwYf4LUcnhGS55c1WcTXfMrR5bjWs8VfKzOnh/kc7SvXzk84DYk6udxWpk1hN5jmNBHGO6FGzJSmCHhWPrkJo9GuBby7DWmBxE0jY1v//I+lhLN87xcZTD1UJP19FisVZQpM4e61s1eO8dtvRXx+UvX++Prt3r7in4t45fPs+cS29sKQ9iT1WNzDqkBscdQ/ldjrBT1s094nT/oCmLziO+nmv35rEIa2LPnlcw4P50lldaVMYOWk8RUOejewWOVjCNAoKpnkeHG3tnGL7HYFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLZmIY4yjcz2uwI9VJPtnZw4ze/C2zLcPv6YovNsju4=;
 b=UN+6So7fWj/O0ADlL9e/7SsM8cQNXETq+E+EXqpC5scA84mx7pIelxuSPTTZNBELeumxJGpTVMI2QFKze2oldhzRg1/fRA/aNn5j8rx7L2Ls1W0cmNp+alNwCf7IZ0/VCEz84/22o1WgV802Y7TZTzXxeJSPvvN4yajBGHnhgDMFWqZf+OX3vkaU1bohABOwEhuoy7rpdpdODG7M3zfrqKZ7t9Efk2DyW37xJNvH3VjfUgUrYHK9voMYuKy51kDqhS0tlzsPQD6Y6eMbuz3sEt0rUpcKAmkx1m15ZugMrfGXM1Xkqra4p5GDwdWNShmqC+HDk9Qa/iab8IcaMI8Wnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLZmIY4yjcz2uwI9VJPtnZw4ze/C2zLcPv6YovNsju4=;
 b=iXfFeA3VcKOamHCRHmdnjgqUt/N3nmi89qZEPbUGOIISeyN5k5PnpW6+91D8ineliO94WwarvoL7x1Wi07tr9c1MtkNCZ0w2/PqL3ae1jHPVmTlBZbP29wpPFJI8qExBRYz1NFAuKTSp474oYTpdpq9pe4ZJX8XBv5INDcwmxRg=
Received: from SJ0PR03CA0173.namprd03.prod.outlook.com (2603:10b6:a03:338::28)
 by CH2PR12MB5514.namprd12.prod.outlook.com (2603:10b6:610:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 03:45:44 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::f6) by SJ0PR03CA0173.outlook.office365.com
 (2603:10b6:a03:338::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 03:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 03:45:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:45:42 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:45:17 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Mon, 1 Jan 2024 21:45:14 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 2/3] Revert "drm/amdgpu: enable mca debug mode on APU by
 default"
Date: Tue, 2 Jan 2024 11:45:07 +0800
Message-ID: <20240102034508.16426-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102034508.16426-1-Hawking.Zhang@amd.com>
References: <20240102034508.16426-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CH2PR12MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f62b361-5ec7-459d-749f-08dc0b454c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mY03WbrsuVR7bBdxicyNjATqdI+vW/063JdAGnUcYo0u8cejiWgVakPvTGG+XWY0qmzx2+A/yifnkovi176qFpn7Ja9OELv4h5BTXUVcjx4S8itS4viQI+AnmBvCJEQeMIcZZ60zUnlhQ8bTSkP/tJrogVi7tM5a4f1QY8R2HlB6jzKvis4zKTYluIuRyI93WduoePOddLrE5aP/iFFtGpA6qjvqRE5CExGDsaVVMRnInS95kqF/HSfZB78KK6G5QaNmQJZlkQtdPRdd4EZWB0Vumt+ohWh3IZ7j+A0rQTCOidlJJpdlCOpWHPsCrdDsd9OIhKZxX/VcDSigpqCdNeVAHnZeZEfxrKa60scxDbKRC4qaW0HqfKfHqQsNwHYwLTF8/rehSY7h7XgGtHQU1lXU1608uO0kNbwOa2n6ym12Rc9dQ5/WWhGHO8/zDiLLGjh/8UfjOklJrF/Xp+M21POjuNpTSpkCVrCa1atcvIag6LL6/MuSahAK/69pLK2aVlLIqxYBtt/gKx+obCZYEKMkTfRtod5bZ2oqA1zjomyP0ssn0VKmWHhUnkVyOrtanuys5KFqis7YEpQg1ZW5nSfsluXIdcYIg0qeLss8zGRyF3txa2moRJcCTLCpbPuXxaADzauYVlbc+zvlZTZMInQRsnsxKlj+NZjU9H9b5Rq4fkdtzaKdooZL0eXb6Bsan6+SJ9EI6XTo1wZp9hSGEdsnffaZRebyb9eFU5eZ8+kQhOCgRbSkzRnxitdZ9HSDgBZLHBxXlW93A86HL56dA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(426003)(40480700001)(336012)(83380400001)(2616005)(47076005)(40460700003)(1076003)(26005)(7696005)(478600001)(6666004)(41300700001)(316002)(54906003)(110136005)(6636002)(86362001)(70206006)(70586007)(36756003)(8936002)(4326008)(8676002)(36860700001)(81166007)(356005)(82740400003)(2906002)(4744005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 03:45:43.4461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f62b361-5ec7-459d-749f-08dc0b454c03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not needed any more with firmware fixes

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 842405bb8995..d6e74b4dc6d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3159,8 +3159,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	/* enable MCA debug on APU device */
-	amdgpu_ras_set_mca_debug_mode(adev, !!(adev->flags & AMD_IS_APU));
+	amdgpu_ras_set_mca_debug_mode(adev, false);
 
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		if (!node->ras_obj) {
-- 
2.17.1

