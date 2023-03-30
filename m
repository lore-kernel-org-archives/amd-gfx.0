Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC50FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5AA710EFC6;
	Thu, 30 Mar 2023 19:27:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE7FA10E33A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crNTfjOP+ZCIPj137lgP7yvx81d6sR7l11oONwORoJXRVMDcczjpabWh25yMubCOtYvVSdT9vaWCV6KmAYphpnAW47w+n0pqV8ZbwqDO9y2LCfgJH6WqT0grE3p/orefDsOU0WK5lMapmqYWhkPoBEWo2mzbc5sHY6uZFmxkE+6T5VcTsyvI8aEv4IIGFYAAwpbaIgWBoF4XA3l9rzBqlKmpHPYGB9QXir+GjgxsWaPJwN98cJas3VeYqn+1NnYLp+wcAz/UAmrR9qd9bmdi7IDZbB7U5WKzq6Q2VjZmJnJNLC0msZmSgrRq1xkw+kE5fz59LDFZ513IN2BYdfHyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/ivnbd0ZRu7Ysudrxsq9VHMl1aRgsy8Y4+F+lM43QM=;
 b=et4Ai6/eDDzF7fZJypSuWz0Zbh4LVz9JpYSeKTrdSqKkhw9A9sde7fQqFrNh4Nw1gDLelMZL/GEvUNy6R53xlHVdF/qitI/3XGqRSZ6LBfsKl4D/AC2Oj1ZOh2fGxiT0qtHz8xa5LOeprtfaZJafYsewNVXJwDwgz2Kq5f8M3MH3wvwhU6TFXPye/ZChlhFyaRkEGmqotzRFADfwaO5NHlxjoDGsXRSah2km/9hBDlcw1wMjipWpL+tEv3tY8jTHBo+C0oJT1sJE7Lhbjvd8Ef4XnkjqAuTladsXyF5LIvG/Tb/G9IZGWT4wXv3YQAvR+pU7ryypFBrcEyZAv696fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/ivnbd0ZRu7Ysudrxsq9VHMl1aRgsy8Y4+F+lM43QM=;
 b=ZBFCGG5Kt5guuSgGQRitJYg0B9ZVQXs/kjvogZI1dAnFhWd/WU62gVCCvYR/Fpr3M0E0IhuZ4CxtyZ7GioUXPvja8jLT99nKxZYLvSVfXpJjuGxQx7+jE3MB0DTVAwGEXkNUrpajMYxBjJxyErbaX8kkMIZ6a9mo6BCzO/yY1NE=
Received: from BN8PR12CA0006.namprd12.prod.outlook.com (2603:10b6:408:60::19)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:27:13 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::9a) by BN8PR12CA0006.outlook.office365.com
 (2603:10b6:408:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 19:27:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:27:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/9] drm/amdgpu: Skip runtime db read for PSP 13.0.6
Date: Thu, 30 Mar 2023 15:26:52 -0400
Message-ID: <20230330192657.1134433-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330192657.1134433-1-alexander.deucher@amd.com>
References: <20230330192657.1134433-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e925ccc-e904-4f65-3d4b-08db3154c38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOwiWfIHb2L5oGPI8lSTRtClWy+hczfjSSxwLZXWfQjdwwRapL0d83cDUXcFbKygelyKTC+Av6cEDy3qfQ9nX2cpsONn44cgiMY5loxiMzjEFj80+0eCRt6UTYe8h3iFC9zEDMUTHGnUMCmMUbGMnoE1ExjNU9na5L9fqhxH39aFxEAkcgWkh3jiw6SWuG3R39KpQLk+TD7XgOa5xjhDX3uJOqIDOgaubg5yckoKtR6Sxi8AgU3K31E31QLd7E4WTxEwqo1qCDgTYmFFDhSNB9j0V0lGjTSVXBAxn8CFr3vmqGXmCjg/6R0xrZLveTWDixBZ9sFYbnS6br1DE5uIpmDc8hGlpm16n+EhypNpDWoRMzJb4XjFXS1uZFullCAK8ukZr5fRJqHsp52rkAGY4FbXuw2Xnl3Fu2GbMUaGf8eItv8pSmKzOtt6JhRwm/Y0f01uVcSmWgzaNupZVMA4oFaZgTaBxPqn4voo255qmZeWXv49lDdbsMhw3iMjgw89QHKC3nJn9dPnZCm/7IJ80UdCHIEelpFon3wtlvs/wIHiVDIH4hWLS9p85l3VM+45iDTlFCD96Li6txBIcXLpAKraVbdF/Bxe321+DRW7KonVlM68uy1gamkQ6y6sETREjhwn+qHVhHF2BZYQEc5dEXGdgWbmYhK3LMcN/VuAbKtpD37+B/jX9rXcotLVmQJ5gk5L/fbWCUexzFRFs908k1dSNMcsebvhAbEEyOgEpW0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(7696005)(54906003)(336012)(478600001)(316002)(41300700001)(36860700001)(8936002)(4326008)(356005)(4744005)(70586007)(5660300002)(81166007)(6666004)(2906002)(2616005)(426003)(82740400003)(86362001)(47076005)(6916009)(8676002)(36756003)(70206006)(82310400005)(40480700001)(1076003)(26005)(40460700003)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:27:13.0284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e925ccc-e904-4f65-3d4b-08db3154c38b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Skip reading runtime db information for PSP 13.0.6.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 130a66f5ea8b..da89fc460309 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -329,6 +329,9 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 	bool ret = false;
 	int i;
 
+	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 6))
+		return false;
+
 	db_header_pos = adev->gmc.mc_vram_size - PSP_RUNTIME_DB_OFFSET;
 	db_dir_pos = db_header_pos + sizeof(struct psp_runtime_data_header);
 
-- 
2.39.2

