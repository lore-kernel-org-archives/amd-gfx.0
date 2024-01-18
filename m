Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2F6C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 06:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F67910E08B;
	Thu, 18 Jan 2024 06:43:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4A210E08B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 06:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=do4ZgKlwQkk44A9Lf8O9YBkfL6AVUcTddus1lLw5HMcaMn/A13kfKiXjFYbBExCLGzxK0Kv4liFWEhBnoGJBp3Pox8C4JLI7f8yc9+o6C4UvUZ6/NDscyk3IG97Lu29bL+YHrSk1JqKkiY7Io5GwUjD6WPwnQw1ixxnXSuRej1x0bkmN+iaZ3bgJ/6VsmI7Y4mHqBhZGf2r55tBxpvtrLCGtcV1c7hsXDTKcv+qTvybXG5cP/IlbChOlsyIzzH5hXpG+DvQ+xLLbrvTdLbnnzHw9lmHyw0M2XXxDzOFBmvBMAekkFWB7haO+rpwxCcBJkc/mToPKC22pw88pl5zUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA1U7Y0y3Wx7C6r90tHDHlFUMDeGBzzvoNS8Bq26gD0=;
 b=HimidcfgxJUyn9vMU7Xo6Q0550B7z1gwYwQZzKA+obsF2SLZ6BfjMrBn+R1e3FjXHR1kWbY0+oTboWeK+9xWG0jMlfDiWGRu4Xz+Yarq5P1Xp5sGuAAHqdBjEdD4fcZTK8JhrufyhCqUUXnekcfKUM1ZiAc+21Vd82wHmrITR+SDJyvraFV8AQslVdboT1TQxqlDMEouuJOshBz1LaQy0ogZC75YlO7PIQcNGhABa1l1yiKQP/SV6+3HdMXvDDxcVVkg8OgDPujiHfjIFsoOKau22s4iyII325divN24vRfkyIkvRozKwypzm1Z7x+6vIOG9XXEfJbuIeN/HGYxjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA1U7Y0y3Wx7C6r90tHDHlFUMDeGBzzvoNS8Bq26gD0=;
 b=Xtae606C4h0Z+25JneNZ5Jl7t9GN8uDry2lylzoqPRnm0zIAb5YYC8dYLb91K7aBAODWZUdg1d68cjqXj1Of7IhTm9XHe+3c5rSX44KSNQFv7P2zrPrPGFm0M7kzYtjMHavC7Un8g4dMNDrxJQznbxkcUQHfIPh9bCNagOb70iY=
Received: from PA7P264CA0423.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37d::6)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 06:43:36 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10a6:102:37d:cafe::7d) by PA7P264CA0423.outlook.office365.com
 (2603:10a6:102:37d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 06:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 06:43:35 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 00:43:31 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_0_6
Date: Thu, 18 Jan 2024 14:42:53 +0800
Message-ID: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf69329-c806-4bcd-9075-08dc17f0cbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +PaA9mXz5TiMtTa7DcSSuPelWuRgbWejsOEQaZhSb2XO02S/0Ka4ZsixTFogXEaZF9H/8Sluy+JqJLpJErK4l8dnb4pt26XcHiooMLVHHIzgUMPUwC2qXLv3RQqT+CRVEGSrwMN0tkwSfIznA+elS3wAz9sWvVLZiMy5G4VE9ss1RSDPMWO0ojX8igMqVRIpZxpAY2dA9kApHCtHMfrGmhs2rpkKlYsrdn5wuMFkg+TN+VR1csUzTar07613rMNFBWQCw6fajFU9sDj/qZ4MlAsv0Vf8FvNPqphXhUURevouQlphv8Mb7NmUExTcHUdXG4JwJwW1eDW76fzPqQRoIZsPUU0Odyz+5p7WtwxyC5WEAFSG697Kojw2cXzYXtd4vGqREB4yNo0wwg0Ry/DX5C3UEdM/XUIl9IGz1MVBjWGDqFPhkWDANRMrY3gUV/0v6HwDcBK7BKeBiDlGKHe89YUi16CuNOhEuJIe3H8WT4ZwSDY1qhxSbDdkJMomnlnTyRPnhMBWiGSgCOsbr7xexnvgRaExHiySN3IKZrIGGZl2a1p1pRN7Hty38+oqQlbEKMLKNt0VJGtC4J/Brmx7+t9cGkkXRJGzmL8Tl8Q+HgMMr8Ek+6dq+MqNKbfpxYf+tEEfmvf3pFB/e3mvVNVljPm6YDqlUt+DwLcbzaKHThgsyJ/eGviGPgoDIzp1fdyZmzu5sUzQePqaPFny2Ok/02y32KyDog/FS1J/KUvM9OCsjN1n1W4aDAmE8CawHsceJXzD0e6COTGUZcYi5rwZwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(36860700001)(81166007)(356005)(41300700001)(47076005)(40460700003)(40480700001)(36756003)(6916009)(86362001)(8676002)(70206006)(8936002)(316002)(54906003)(70586007)(26005)(16526019)(4326008)(82740400003)(5660300002)(478600001)(336012)(2616005)(7696005)(426003)(83380400001)(1076003)(6666004)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 06:43:35.7733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf69329-c806-4bcd-9075-08dc17f0cbce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273
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
Cc: KevinYang.Wang@amd.com, Tao.Zhou1@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com, yipechai@amd.com,
 Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add log info for umc_v12_0 and smu_v13_0_6.

v2:
 Delete redundant logs.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 11 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c |  6 +++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 6423dca5b777..fa2168f1d3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -91,6 +91,17 @@ static void umc_v12_0_reset_error_count(struct amdgpu_device *adev)
 
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
 {
+	dev_info(adev->dev,
+		"MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%llu, PCC:%llu, UC:%llu, TCC:%llu\n",
+		mc_umc_status,
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val),
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Poison),
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred),
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC),
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC),
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC)
+	);
+
 	return (amdgpu_ras_is_poison_mode_supported(adev) &&
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 11923964ce9a..51bb98db5d7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1297,8 +1297,10 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 	uint32_t id = KFD_FIRST_NONSIGNAL_EVENT_ID;
 	int user_gpu_id;
 
-	if (!p)
+	if (!p) {
+		dev_warn(dev->adev->dev, "Not find process with pasid:%d\n", pasid);
 		return; /* Presumably process exited. */
+	}
 
 	user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
 	if (unlikely(user_gpu_id == -EINVAL)) {
@@ -1334,6 +1336,8 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 		}
 	}
 
+	dev_warn(dev->adev->dev, "Send SIGBUS to process %s(pasid:%d)\n",
+		p->lead_thread->comm, pasid);
 	rcu_read_unlock();
 
 	/* user application will handle SIGBUS signal */
-- 
2.34.1

