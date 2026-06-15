Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C0ECD98E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE1510E782;
	Mon, 15 Jun 2026 23:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D3r00tp5";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012001.outbound.protection.outlook.com
 [40.93.195.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E86110E77F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACo07Qj4owhEW8LAO7K1Ma70HM3QQI9GHjfEu05/QRDKWjprrTsUpFw43mis0Oi6K81Knw5J4OpNzE6bGmkfCMv3P66BEdSmO4SeLxGwPdBQDljQJnLsx8ZKHyLPUUiWtOjXaOdXOxbKV5VjV8hFzXBB6YnQkHRLsscMdH7F4yUeEXrXuN6SDAKFIKW/X9fW0bPnjTXWqHmY5gG8S/gUTr3FpNgoW/+x6/n+w5l96TNavc6W29E51Fwl1TDqz355C4+nOLahRFluDyiOrwUTfjekx4SLkfzSW31smym5aWRj02HkYtHNr3H3Mz14NSZ4wQQbeGAxKh7VJRgho4MxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pV7TE5oiFPSRf+HroEX6bqQ7430yb/sTT0/a+nMuL6U=;
 b=uOgj/ePOnTrlfSRdw2r3A7zOnWQbtHmq2Z8IT3OlHCiSiMPbfcNtlTqmJKiOdXdmrofw0ghXwMPAv98Hx4vvpMaOEAT57uBjftg4av79z9LkO0UEbWXVkSq41oBiSV0hZj2ygGIldwDnfFFQcO8IOgTLjOaLTxqxWH/lBUpZPniOnVzs9kbMeNkQeQsCwi1Oh/tdX96ZGRZ9CUbtorxrMzks+HZI65qOKOswDI+uv1USZ7z/x+tK9GW9LKxdg7/R9eypIkRjOEG1FAlwp51eeNPaenuXx0bHbMjfrJ0q5L6f0uFBE83bQMQ9U8rMPbZITvtv81oCtdIlvcPY31c6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV7TE5oiFPSRf+HroEX6bqQ7430yb/sTT0/a+nMuL6U=;
 b=D3r00tp5sFt+WQ6FcjB9noOPsD7apYka+6N413HAVH3n9VagkklonyuskjW+Bj7QKFlXxkNJCtQDlBzWYNYEi5f5RhIqBgtC6zZnryC82TmR6Po4kGamdpbkeWuQXVvYjcCkYcyZ+WeMR2MP2V8YUlZClPObJu+8ng3g7Ot3xqI=
Received: from SN7P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::33)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:15 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::30) by SN7P220CA0028.outlook.office365.com
 (2603:10b6:806:123::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:57:11 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 36/43] drm/amdgpu/gfx7: drop all BUG()s
Date: Mon, 15 Jun 2026 19:56:38 -0400
Message-ID: <20260615235645.737189-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: a741d000-e605-41cd-a9d9-08decb39d346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 8lSQ6vXJ478Eb18EsO3g3GxoCLauMnORx6SP4UO4fN+PfbHU1xuAGu7NMkYKJ3Qw7KpYdnURqQzkn0wFW27Wx0XoOCQgAvM15VJe9mKpdCQKBgsWxUKqc7FPSaF7sO2XES/5/kEPHQfSBJMo0cANSUH0wId8xtvKI95QF5INLQUrNeVGd2bHFfGoXlD5c3qTOmJOlTfIZZSIrAA5ic9iCrgHQdc9r6FyljN1ipCZgVogZW7h+NO8lC0Ib2dlod/qWn3AeUApT85Dz4MNA5YasAdc1BnJ+m0rbmBfhs+KFG77gW7XH1OJho6tLYa65OBdmqbK8hwEpL4KPOSD4SJvkZd3A9GLcRfZuMq9dXnU90guFhvVZ0yh391hT8e0uNtZLHi0qn5n0doIl7CqFZAdPKeD/UrJ8kp8ItpL0LxHduhd02ch2Lu5cim2VfpoSsF9feUwrurWJQKk9+p51GnHo5K2KgezOPHhOJbr13vNRgcrUWouSWFPDcheI+pIzvfPss5QxZ4G/wWIwgRw1NZfBkkr47rDCqMM7VNdTAJ4VxIsMTLePYeqGSWzruvdhagxQoZDC4uQDsVJ5UzJXipRbRfbNXkUeJY3qm9vshKWsy2N4jjQ34/tgqufRK4WGs35wBhZKq62Yb6IpdFIkhBeQkibLJBb6Wk73vEqxRnfqzPhZQTfN8GcG0ioj+1nuGvvlLmAd1L7so6M9GVpj5afwpQ5jmSPdhJefG1WtZehklI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GmSl7Ets9Qd2QcdB15oEgIYAUoORgw4XJeI46kM7V+v97fflPkaptp2A2hVBOpBqKEz4UNSuBGyEGBLlvpOmbmV13So6OoWY5ffsguufvbmpoMymfdgoXvTlHdQV22LBhiHCTBqltS0hyoCSSiKDya5vDjVNj6s9d04eJSgwCBF2CZi/sX5F2XVDAhpeytv0qhg3yG5ko9GRvWREVK2veaB1fD8lHwgXUH26Mg9FMfqjJB0QBb/FVtUo9OlcB+Hyok04Ty42jltA8Lu1kCDXM2BE4POY4FZgWU9VZavGrnk0VLGOQ0cjC/te3eg7bujVMAGKBosp0JLB9LflQmDLr/niqVEY3hLT6wIXDVgouOMXAiP+BXWJgQ/NHYcblMpn6+IvwyvkGDcqzuZyK5s9av5zwGDZKuv/XtLx5L8PPyq6IgHBr9Rh2jrC86yKlnCj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:15.1029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a741d000-e605-41cd-a9d9-08decb39d346
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 65b8497ad5f02..4a020323469c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -933,7 +933,7 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "mullins";
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
-- 
2.54.0

