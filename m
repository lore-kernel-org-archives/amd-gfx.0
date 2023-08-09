Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19481EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 05:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC14210E237;
	Wed,  9 Aug 2023 05:35:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA4F010E237
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 05:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX2xfZjS06u5VGTpd2Z3xvmLvo0Q8Y5IIkigBqk0kTYWF7QIkCVtmyd7y9LO/8L1OsM+P9Y5NXBGdBkgJZAPLZHI1hIk/pcjEER7u9u2c4jEfubQAgcXFlhXMLLoLRJ7x0IlTWA7x3Zw9nDBOnZoQhqyNcnXGM5mOePaSw/m7xi/ZAN9dG8mEsLPhlFwJWhoX533CRQ2X/e1+9cF65lgQqxivhZgUTAd+cBWjv7jfTlQQ7lkXGMDURrUFDWf2O7L0UWSmoc4adApQIfzAGjb2P59lWvz9PZoNzuM+VWsBamGkDQTWosqXh9zBHGNWMIN4gNVm8yyDnhWcxDHZmXbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQClS1vXxJH0rMYV02pvBW5d8JEZwQ/Ew3GvIlLl6Og=;
 b=CqYMOSdQeZ2IAcJa3RZDVlzb9Y6bgcf5LNK1D/xow0FrWooWOVIPuk4WfYtGgTIJUaDqrnpFr3apMFWvZOPSldnyMqwsoqZ1a8EE0GikmKXeLdwkSNj/ytVPPYkvbY194MgoAf5AdMr1PBklKxeeWYYDHeobKwzf2kUetYRTAEqN7iq+TgVhIjl27MH473btgEJbvXpxCRuoxfTx3dYBnqbokFB1mn02rZM3Zgk+aHGPDoTOCEke2RXv8vKdHetZ7sbCzVN2M4Og1BMzswRtZ0UEuGfKIYB2fZUJRrMbYYLv55J3V60b4xMtKaT5x5vErNEF6yxox356H5GFWiElOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQClS1vXxJH0rMYV02pvBW5d8JEZwQ/Ew3GvIlLl6Og=;
 b=z2LK43/thkrfAL6Tc2BBVJsVakARPi7kghCddYNT4INSt1lYbc8nyGss7H0aQPOhXxVPrTqqXMPzuNUXSq8njAtm2yggO+pFzlIDkzR15iRFaqkFCHELxr/2pOOpGbnq40TEpHIDTd0O6VyLZ4xGRYc96tFBVPM57N1nla6+YHo=
Received: from PH8PR07CA0048.namprd07.prod.outlook.com (2603:10b6:510:2cf::19)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 05:35:46 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::5b) by PH8PR07CA0048.outlook.office365.com
 (2603:10b6:510:2cf::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 05:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Wed, 9 Aug 2023 05:35:45 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 00:35:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix missing comment for wmb() in
 'amdgpu_device_aper_access'
Date: Wed, 9 Aug 2023 11:05:16 +0530
Message-ID: <20230809053516.200154-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 34037e7f-022d-4b7f-0088-08db989a7b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tp6sEFqsf2jRcAnbimHJH7RLKIguhLxJJdt/Kl0b7NlalGYZOtlG+XzsP6pvds1FRgUWd+oh1kZxy1Sl7SIDMHDjXIVjSyIPiat6Vy1TotZppKghymmEBt/VloM3pd+WxJNtQQmTtISaA6I7udf7/oIJVg5/b9iAKPbTPU/2Z/+z2dNKMwzYPRnL6jgswiOn27J1x/TF32mh+EDcvXrQgJEAoYMpmCtjjKWpNLHr91hnzkVVarwhtVCyU87WGychnpKpU9+8fo+4rEgpJIVV8GU4mOzl6RlILqoGDy1hGm4iSfn37GSjOhGYR30r1A+rwpDNArpnH7Gn+w18oJ65zxtjS2eXcRORNSPNSznCreq9r8qH9c5XOdVuiU8Dh1Gr7BnHBQBgdA6TVnfc/q8VLLR/kyVxHvXmxr3iK+nuVNJQWgH1yrsfzzXffpGvd20Wv6S0aJdBdYmRuEcsAMJGgLhDeFHDNRd7n+ebnexDSBQi5D9wRFx6UV1wMUtliONjurGqkcj5WCSb3uyOOh1O09gH+ynaX/EzmQ/PIT/FaHKWa5DIvCmiDWzglqzOiw2y8H7n+gXIeB/xAeJs49++R9zysD2ZoN8H2aUY5sT1fkF9lbeYQGAO13lv4iMzaZ3BGRHdIRIZIP4JupzBVv6Dn8y4n06SQO1Qo/QubqgzHssBrT1u8Zsegfgzn/y4Y79FAcudRGucNP+Jt49Yl9MqqWskkmxmaaQnPJFFoboEKoDGx7t42Vrz7XxBcxG2sNN2huSUXW8sXyO3wxSpZGzFwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(82310400008)(1800799006)(186006)(40470700004)(36840700001)(46966006)(1076003)(26005)(81166007)(82740400003)(356005)(16526019)(336012)(426003)(66574015)(2616005)(83380400001)(47076005)(36860700001)(2906002)(36756003)(5660300002)(44832011)(40460700003)(478600001)(54906003)(110136005)(86362001)(6666004)(7696005)(40480700001)(41300700001)(316002)(8936002)(8676002)(70586007)(4326008)(6636002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 05:35:45.8939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34037e7f-022d-4b7f-0088-08db989a7b08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds the missing code comment for memory barrier

WARNING: memory barrier without comment
+                       mb();

WARNING: memory barrier without comment
+                       mb();

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4f818f13dc9d..a1c214f86e4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -305,10 +305,17 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
 
 		if (write) {
 			memcpy_toio(addr, buf, count);
+		       /* Make sure contents of system memory are copied/flushed
+			* without messing up order of writes to PCI device I/O memory
+			*/
 			mb();
 			amdgpu_device_flush_hdp(adev, NULL);
 		} else {
 			amdgpu_device_invalidate_hdp(adev, NULL);
+		       /* Make sure contents of system memory drained/invalidated
+			* before copying contents from PCI device I/O memory
+			* to system memory
+			*/
 			mb();
 			memcpy_fromio(buf, addr, count);
 		}
-- 
2.25.1

