Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78A3C47DAF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 09:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A58D10E74B;
	Thu, 18 Jan 2024 09:04:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA95410E77F
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 09:04:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdY4lCX/PYqg0VmBHpD5+ZbkMf9kyqzI4JhWXNgyoaQaK5yOiiDSHg1M2sMxmMVJemqmtAScQ/q7oRiTUCI6kHIbh/i0zte0UwHGqdHz+KUGOhWTQ4ly0pTiJ0hcWTqKFm4PamLtkT3BcQvv3UkNmUfYl2489eQGXxzWKeueNuXFiHtINnRwDNst3HiGHaZJ5H4cVpoM8Dg9e43H/oYtnzGwBEbY9EUsDpLagVm0h7pjb5dVG3CSYp4UJRQaESlXHsjcnWnV0VMynhNBKSfI9br9vU1GkMePA9CHtaoKC1+Gst2c9vXpgPIKDDqqn1/t4mVTzDY7Nj0WDaB3BrLkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb0py6zMYoFhC13CSO84m0vEyvQ5hv84JFd1wIj/+iA=;
 b=A5zDMjdQ6iBM38EztThJ0daB95CSeHlcxZV/OvtLb04XUaqjEFYPxXRFUxz8UmKRJayY6WmHmxs9PxUY8TgiRNBmGT8Og2FrktglCjuY8hWHCrnivG6ZYMrYMmlCNY4bWiluVKA0LNui7Y/4MtH78QQ4OjIOZZFcDYb/llOMxCeHi5fSUFfRXaLUObDnJJrJDLrZKxyrkESJMbJe666BmpZ+Vq8SaXpCAZI8QgBA4Ni/8UN03Y0Qoqn1ojyC7XcpJO1G3h85w24zh04sKo4iHAAgqow6DjSX5U+bAWV/iChxN9Ccrl2hZEt9aJCBRcDIQVfuKuqVxZey7wjv69myKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb0py6zMYoFhC13CSO84m0vEyvQ5hv84JFd1wIj/+iA=;
 b=2Pxkog2NIK2LTP8kMEu3ZSQoA4cSufDm/gUEWDm918YTGLDbQaD4H12gZ3WPg1VIZmcxdvxXjh3JwUr3ZRATti8VN/fQBo55KD8Ys+kfv9/VJNVGB4rHfdxnU29AJ72OHVOlBIb+w593N0AeeGrSHEqXQJUzP1FxYaY8OyUvmsQ=
Received: from DS7PR07CA0013.namprd07.prod.outlook.com (2603:10b6:5:3af::19)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Thu, 18 Jan
 2024 09:03:58 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::52) by DS7PR07CA0013.outlook.office365.com
 (2603:10b6:5:3af::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 09:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 09:03:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 03:03:34 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fetch current power limit from FW
Date: Thu, 18 Jan 2024 14:33:14 +0530
Message-ID: <20240118090314.155112-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: c5bfc193-0135-4519-0a84-08dc180467a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9aeo4ZGOjTxERaLD4gKNVXo5ySxW7JxbhYWLFuF546hdg3dmU1OU0jqGQuybbSuJZJyIj07+R2ZHBZKyt+rAp0Mxm/ms5X6nxPR7APQUwetU/cJcGY4lvBJzzWYE9N1H82w/58Gcz5N6xAo33WHprg0aeZEJToTMBbOaTEQlhadcgwYaxT3D/PcrWPuEYPDdsnwXVpCuMrvtRW9kcEfgcNP9TAZto64U8SAqPQ04hTrndD8hFib9r00quYWKFxn2EcltI8s/kFZZKnWdsGTKOorlmFhysLs5kh0gdez5THQF5/YoQeYW4Xo9Mc6a4/i+osMkIoIgEui/0tAXHuKnaIwasaaTTfBAN2tgUkM0zYExO8WRx1SWngx9hRdN5BTjENz3KIYPl8LNCGP/hTFXduGSleenrmAKaQaDEN4wXG/2pEe1K8ZbNYgWtrkITYFRxTsdfDjFqVv/4lXcPheWYbc/nv747/uRuEyF1n+XWeXnCJ3P1z5m5K4pAdG1GWegKs0hhrHmfTvoTtDHv/VgupS6o2TX548EoFIFB7TxLWhPE0R+FSB7P0cNakhz8vf7BgqUmI909mFzxZBD98OBhsnQpnS2hSn85C/DHT9YBjgjeNevtgCVZKb5ZHfT0p3qwFvw/SMd817GgtnHU1/RVpIjFcD00GGv/qpXcqNcWsT+SUmU4sOu2AWZ/4nzkShZOfPruKTXDziS52l7LYlRN44+miebampjbZLCe/D1oBSE39hyJa+fpbe2AuviooA1YIck/W1vuK7yuUgJhnmVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(7696005)(82740400003)(26005)(478600001)(36860700001)(426003)(336012)(16526019)(6666004)(41300700001)(356005)(1076003)(70206006)(70586007)(2616005)(83380400001)(81166007)(47076005)(8936002)(86362001)(8676002)(44832011)(6916009)(54906003)(316002)(4326008)(2906002)(5660300002)(4744005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:03:57.6857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bfc193-0135-4519-0a84-08dc180467a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Power limit of SMUv13.0.6 SOCs can be updated by out-of-band ways. Fetch
the limit from firmware instead of using cached values.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c16703868e5c..88cacb4770e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2710,6 +2710,7 @@ int smu_get_power_limit(void *handle,
 		case SMU_PPT_LIMIT_CURRENT:
 			switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 			case IP_VERSION(13, 0, 2):
+			case IP_VERSION(13, 0, 6):
 			case IP_VERSION(11, 0, 7):
 			case IP_VERSION(11, 0, 11):
 			case IP_VERSION(11, 0, 12):
-- 
2.25.1

