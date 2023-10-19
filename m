Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5821FCDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 03:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE68A10E09E;
	Thu, 19 Oct 2023 03:40:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56A410E09E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 03:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGFs1bMLYdg1oq2s67WX1j51KogaOGgpA8kzNa57c71l8bC2QVzkZSYVovCFkdlJcq6Om64ganoAHkz4vkB4aMP55Vu/MUkgiLMGc0VK1qeYVZgITHeUNnHXfXjsmwoPDPRiu1f3EpaYT3P9kHjce6GZmtFu7qh2sVsyGSDQiePKX3F+ljU4u3wDqW8TC7IGsHPRXq0Q7S8/q21OYu9iy0lnB5qzTgmGtouPw6F4os2JxPZ0RrorUWnwijUMH09660HpS7J3266cRok+xmeOOccyrb8f00+nBS6Xkmu1J+yq1k2xFigeZ4BxJ5JtCU/1V2yE292hsZ3NUivgywU7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X790nFg+TlRndkFeCR/NH4geUhRk5tw2cInwdZFA+PY=;
 b=YBmmnO8P9r1cZ01yQ1/vmj0wSxZoBAQiRfuu5t/ku4VzUECi+yE7ibWDM2QDLvjzo5jQIGElIeST132ipmpeU4TiW8bW+qz72h8bDiDxgIyVlg8cZoOGZTyV/lucHhnwK8W4Cx0BBnzneq7mqCBUCv7zbajYxDUM8o3NpBBeh+ABmvE7ukApzRE6e7XnhLqhGI7LBLbyNrj1wXp/xo6XuphDRKrZwIPciusb/1bHmSvRx9Tu1GD5K1NSnbpLGZhFHgtZEnwT2Zq98IFMJicl75izwX4O4vzOMGJ+ISqNOWX4E/yZwLl+R4caIecVCq9RvAzBfD5wQaogObk93d21VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X790nFg+TlRndkFeCR/NH4geUhRk5tw2cInwdZFA+PY=;
 b=y52O4ncat4mgZPzQHTwrPsTysz6w7E+9B1gVgE4MSB6S6kZfZZnLfd/oDWDqAFcqBET1/6n6bpywE/hzZYP7TwujjYiEtge65T63OQzkI/krjp8W1H3a5fwZeNBsc+2d7VXeCb8pf30CoDMaTHlvzWWj+jjKnjeQgE6Y7AxKNjY=
Received: from CH0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::7)
 by SJ0PR12MB5502.namprd12.prod.outlook.com (2603:10b6:a03:300::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 03:40:42 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::e2) by CH0P223CA0019.outlook.office365.com
 (2603:10b6:610:116::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 03:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 03:40:42 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 18 Oct 2023 22:40:40 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add tmz support for GC IP v11.5.0
Date: Thu, 19 Oct 2023 11:40:25 +0800
Message-ID: <20231019034025.3184944-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SJ0PR12MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea906b9-33d5-4e1d-b321-08dbd0552b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gE3VcII6rpBUFIWmv9fTzL4pI9YmN75zuakGB8Wr31BFDnUi9pZ+VhS54kxaLWr0OnXgWA8R2nXtJOi4Q5LbNpGA4mndwi5MmGoo112s9/I8+tv7z46YHyHe9F0doUEy3sZxG4GdLy2fSvLMp0lBymh5H8dQ57XXmW+fZgwXrvf+D4E62E5KDKPsegtgPirTKOMOgDyMz55+Oe3XJwbu7TnZ2gwec5YTQFNeqJcQHrBWNVlXZJrCzbFY4GRUKidG/Eh8w2ELT3iyHS2c/styGBerLiLj7jEKrPzdd+BzrlCzDucIPBr/qlycqwf+naCkwXH+Efi5Wnww/0LcphuQ8hogYGf0KxU5HoAeNJLQLCch5vT+eqQFPB400cmTT92+7M2V9E9MUEl8NNDq9NQrebGplj295Q+uS50RK7bywiIOwnZqeS5ywsIcuVwppU7H+KbvxPhKpyCEH/BFkURvD3uDo8DvDInQuxHJ7FC7MADHJbixFRhHQzi/c9RNIt0hdQmUKhkzD880WC1+ZjC6q8PJwC38xbrOGalRE3mMMY2e8wGce3UO5aBlS5tfKmitOSRmFl1utDQOGSnGpdsC0l0IINUDrml2KQfzLyw0HERTaQTiQCWDOXAQP5ZY4gj6yznoZDjY6TplCexNm958FfUy1ZN/zMMuf+sh5lqU4wC6CDKTxa95bxIHf9xwdSr4A1hl8KWGy3mMKitQmuW5GNqblWUqLRK7P7m8pQb4xwzhsvr5CH3aF2++gpJSj57FP+bjbwJ11owHZw82bYKaeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(26005)(1076003)(16526019)(5660300002)(2616005)(426003)(336012)(36860700001)(6916009)(47076005)(4744005)(8936002)(2876002)(2906002)(6666004)(4326008)(41300700001)(7696005)(8676002)(70586007)(478600001)(316002)(70206006)(356005)(81166007)(40480700001)(82740400003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 03:40:42.0150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea906b9-33d5-4e1d-b321-08dbd0552b58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5502
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Add tmz support for GC 11.5.0.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a02992bff6af..2dce338b0f1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -786,6 +786,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	/* YELLOW_CARP*/
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.25.1

