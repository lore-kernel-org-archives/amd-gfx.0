Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD84C001B3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 06:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB4710E328;
	Wed,  5 Jul 2023 06:05:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C10210E323
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 06:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdVecd8Idx00ybAGCOy74nMkRW/+Xk2vw0bZyuZR9xLTdOd68M4IziHm49USFicGbF65FPRIDu34BEFTO7IgQsLQMq0SjLbTXb0PSlY1Zlfk6dsk97z/5ZjcNb11PH/RXMnMrfVFl2NLKi7cfH5P2CFcv00akGn62W2D9+8g3KkyZxMMJG84B0wASZweuRlXMPsGOBn3sChqH/df2pr5Fw2lNpvcrC0jgyxsPMcZm/DXbzK3w7DRrt8xQpywbjncw6lZ/ErxD8c9igkv+pEhhzQFYD2S/2QvaSYNHzfYh8ONad1w0gCVWquGet00G3SqcXsUhopuHqSMbhKj0YXI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWw5cpEAuga5IAV0lGnhWz1xKuN6EhfAuTs4z9YrDaY=;
 b=avGxD8hVMbUVkrJaktT0JHfnoubZ8GoOcICXz7BHqa5YNk3IQ3OmZvhebMNDFpJzXSbzHkXDujd2izSs08zUVnbHdu3+PrWvDgy0KxIHlbZm7xzU1jwdJiIR9vrtx8rP9FIvqm6smJv26hwXsLl9OkV7rTmxPl58HJPdCM3gR/zDnQ+dJGCxAj72urWhvTE6e+upYS77F6br91cTdBDqiVWV53OCP/111OnlATZ3j+9CjMGUVWVgQHcqfawCYT2IrDf/oFL2gkDpgPYyBuDPYf/T+bx7N+O7DrzbXeALhrBHJuoBBZBEFSf3wKs9MAa7kKiWaHaazLMRbe41uklKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWw5cpEAuga5IAV0lGnhWz1xKuN6EhfAuTs4z9YrDaY=;
 b=SsMfsuB17OTSAbGbgPcNlkAkUSXtcIzsWquWD0KVxU80lZN60LiZVqxZO8x2gyVjhkG9raIkwtKQoGqxUEh6gCHuC/pLgSLmV+4dmB+xfGS0wishwPsFK75vQ8gKQruXlNXSHgJYOxpe0ucCX2kVogJGnAnsdKh0NEWeVEpzzKg=
Received: from MW4PR04CA0104.namprd04.prod.outlook.com (2603:10b6:303:83::19)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:05:14 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ac) by MW4PR04CA0104.outlook.office365.com
 (2603:10b6:303:83::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 06:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 5 Jul 2023 06:05:13 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 01:04:38 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4.3
 chip
Date: Wed, 5 Jul 2023 14:04:27 +0800
Message-ID: <20230705060427.3698857-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2b6ef3-0ec7-4d5c-2d90-08db7d1dcc66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8y0Uk3S1LNnn6Bow8GD+DruzkKtEVzOg/lIC35GxXQqDK2ukUT0J9kxlV1L6Rwfo60jTGiqz0zowK5F6BiuG82fFZmt8BqO+3EhaVszYNUALZk7PJ67p82GwegkRe+CeDvWa6X7pcetdhzWEJG8MVcILiMJD4hFY0Gmh8AP9RgQAs0nKAUh41c3e21fHukJDaES8cgJdkhFV48uZdtcjvlrBi5YSeCMiip2ycZiy/GmPQDTicyK0TF4IT/XA6XDmSRNT43aw8d+/Ysb9NyQSt+TrnbfjafbsjtqT9RPQa6hZhPw/FKOUi1pDX3+We9s0+xY4poMD6o3kA8xsSPz20TuHbSSp4DEwhwoEr59QfZN6DoQAk9rYHwvjL5fGd3WIX8xTqIT7O2isQ2+uDeuuyUjcaHaOjb9i92HKaPclF1EHCnFz5OZflXmW13iABu8V/oP/4hcSfd/YOqC4opRIO0MJDYXkKcRmKkbnIwndpRevqVofMawgjJ/QPZbItnTXWp8CRsqE2MTuJKxniIjZouuo+0ZJVxlxejlRGbjjUrscmk2OjURVgXB3Zf8pa8qohCFWezadftYga2qExZH9OXaGUxpj1Z4ZiKU46zVPIuI/GEKXpfdF3NGGUwq+wFxXnoDh4p6rejZCanJeyKeKt1Ld5AwwakgkmmQFhYTCt02GcFih6TjjRvpSibucqHXxerLeKzooHjwu6JhM/pKfnJ/GDckfHmkH8jB++2MSelgA4GVWblSNgJHwQGEM2RS5DZ//ArCbxWINGF1UoPa1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(6666004)(4744005)(2906002)(7696005)(8936002)(40480700001)(54906003)(36756003)(8676002)(426003)(40460700003)(336012)(36860700001)(5660300002)(82310400005)(478600001)(70586007)(6916009)(70206006)(1076003)(26005)(186003)(86362001)(316002)(4326008)(47076005)(16526019)(81166007)(356005)(2616005)(83380400001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:05:13.8266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2b6ef3-0ec7-4d5c-2d90-08db7d1dcc66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
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
Cc: lijo.lazar@amd.com, Kenneth Feng <kenneth.feng@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1:
the dceflck sysnode is not aviable on GFX v9.4.3 chip.

v2:
simplify code logic using helper function: amdgpu_device_has_display_hardware().

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9ef88a0b1b57..3922dd274f30 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2049,8 +2049,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
 		if (gc_ver < IP_VERSION(9, 0, 0) ||
-		    gc_ver == IP_VERSION(9, 4, 1) ||
-		    gc_ver == IP_VERSION(9, 4, 2))
+		    !amdgpu_device_has_display_hardware(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
 		if (mp1_ver < IP_VERSION(10, 0, 0))
-- 
2.34.1

