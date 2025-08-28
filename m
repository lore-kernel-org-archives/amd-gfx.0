Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824C3C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 12:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C9E10E1C9;
	Thu, 28 Aug 2025 12:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0FWJ0pTF";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0149610E1C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 12:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2Y6zv4x4Bshl4/hUsSuFgma8SuRJmCvUQUcxcxBxfaIz4DU74QtePNSkKxnCvrwhQvIKRQmkq8J2c8CE+AwVFsABARLTsMkDdh2HYyQdba6HTa7aQ17tOhCJbsvVh1bYrSCOBRNl6SUtH3FNiJoWckK5J8F9TelQjrYr1/jgZXBwfGiItUkK6omhi0UMNvGzeDyXTt7dc+Trnj5plBW4oTqd1nj4LU4vtO9L2CG/EapDZ/JD6Q1e/2+SzfyP8+ZVdqQutRfg6FoWGNiiEzisKIVc5jOsbtTrCMLaCDQBPr3An8huksrvztsO3Jy9CS2/73H1WI4xSV476EBqJ1w5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5miM209NgE+DuTMIAqcghh9fy7PGW44FZqpm5bEvFT8=;
 b=XjF1pyPD5EcncAhcghtlKcELb/XnphNWGX1od8AfqkxWnij0mYB37JtLs6sfpLz1yjIrUTS+LLBx033AX0ccdM48H1HoYzapTvSNuVzWsWDckxaObCYt5E7h7EgPR15uy1bMva7mvawgqbTW2vcg/9v3NgYjN4rJWz9eqD3VAMqjM2BOZJ/6zi5zpt50UWTebefJF4Qmy7lce0UvRZ26LswZ7KAAMCyMHjpdx7GFpwjoOQ99MMG7B8Vv/ch2h+59Ia7ST6gjp6SBgET5A4jvXSAljrG5gpAFnRlCvqQ6m3xaVGnLzDloILx0FCKRVwFqj/CTjOVUaFlU4xRGLRomvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5miM209NgE+DuTMIAqcghh9fy7PGW44FZqpm5bEvFT8=;
 b=0FWJ0pTFEfInmxuGk775r9b6dqXQDwCwVvXK5zXpFQKFUEBB7z76iDimH0JsLWnYkRhMm7KSqv5YIwF4cJwI0mkIXNkIblTiAtfuz5eOHpwrSj2AfiyydQpfjmhADrGXJdnYN614aogagjJRASI016adPciAF2Q6yQT8a346E2g=
Received: from BN0PR04CA0189.namprd04.prod.outlook.com (2603:10b6:408:e9::14)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 12:52:35 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::16) by BN0PR04CA0189.outlook.office365.com
 (2603:10b6:408:e9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 12:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 12:52:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 07:52:34 -0500
Received: from amd.com (10.180.168.240) by satlexmb09.amd.com (10.181.42.218)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 05:52:32 -0700
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <harry.wentland@amd.com>
CC: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH 1/1] drm/amd/display: remove oem i2c adapter on finish
Date: Thu, 28 Aug 2025 22:52:22 +1000
Message-ID: <20250828125222.382529-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 132c6680-766f-4864-14b8-08dde631c2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PF/vl7BW1sKAUNO76tKpsotVVWDxGD6BZW0kRNSxOVVcQw0v4+Z6g6jgpSzD?=
 =?us-ascii?Q?UD1es4FMUASqD9ZvAYeHywn9ryEQqzQhWsBXT4Sv5il72m7u/UY3GOKLR9BR?=
 =?us-ascii?Q?hMTjNehVcKA4cPwEbD3kgy8/rfhoRJ3xBn/hJihkGCLR+kQUXldDjgOLCimW?=
 =?us-ascii?Q?nlTK1Hok8DVwyCzR7gm/ZLk39UDHA/LS0yqDuV2NpFNyb0mdMDHVKDjyFtE6?=
 =?us-ascii?Q?+n79VB9DioA4FCECrwaN3Horxzcqjn+7qBST8mVwLaOq72oYAYf2yBGVcIEG?=
 =?us-ascii?Q?lZdkcIb5DtZjbqsSaXt8kIz3RVfaIn3zAPVNg75EAPpDumnAZ4LTWWRH8MIH?=
 =?us-ascii?Q?eJv6yUXzTgEWJg/NGrJPKI50Mhu6/iVrnRpoLEPWCDIClRmFaFdAeJfoOEuF?=
 =?us-ascii?Q?6mMD2XzsqdDWiftNBUemiwf03xRmtOxyDsXiyKlzbzgrMnRJUyDojdPKVpMh?=
 =?us-ascii?Q?oESfv+w1as/l4KLayrVe5s/VuelXkrLwOZZ9Vo8HBFxFz4Ss6yDHfVVdMlnx?=
 =?us-ascii?Q?iF+dVllOS5dUo0lLrkdC9jettLtd/tgPUtHoVpR11bmLx18Tw65RgMEoswjx?=
 =?us-ascii?Q?urDDieGuFH59wPJ/p6evrvNca+UROahc+42GrHGquQCF+IzUbBZflsssVG0H?=
 =?us-ascii?Q?NlPtbYt1wnD0jLRPn+ZjJ94jN1BBcwiRL/5M70JWLK73oJFP5EtUto7e6ndp?=
 =?us-ascii?Q?E9QjEy5snl2p2vCKH8sH4rVee1l0HYClmUP0s63U5se+7DYB1aAPH/qVC/Q+?=
 =?us-ascii?Q?IKzMCtR+HgNE0Wxn8cyJVVua6bq1a/LolrGbO7MAXxgWA/Z+fYSsP1+KfHEx?=
 =?us-ascii?Q?9l9/zwTNgVUP0UnjFal7SxueNQwGce9lOOdZCxLvJ7rboChcSRaioE5nT8rr?=
 =?us-ascii?Q?G9dx7fneXZq5RY7suVlw/GuUW6hh3jjKCH7BbOOUj8rLr/gKNz6vBtHR59Ar?=
 =?us-ascii?Q?gEnN3er3wxVDnKrYEFgmaynpXZ+VBrMcJ1dZxsaPOovYssjaV284t6vs/BhI?=
 =?us-ascii?Q?6i0Q269Kp1FziOKF/q6SSc+i9Hxg19ToPJ/uEeVIPuZwbvotiQgPyDaDupaM?=
 =?us-ascii?Q?jGsb3+sFXh1U6uD3ux70qQDeUaI7mB+khc7Mk6CQvfporBcxBNgPPynTr00e?=
 =?us-ascii?Q?YlZLFVOV/9m9E1EW4WbO8DuNYUZUIrUioSRdcuqKZVIDQm+gq9UNKB/nxPPF?=
 =?us-ascii?Q?iriFDv4zzJZE8hrgnUeOk0ez20IzOPQMWXYKDsadiRi/nON4S9xskyXx/aDw?=
 =?us-ascii?Q?E2d8Ik4YSdDiWJeH3ucgIPiMuEACIQmCdQ+LgWOHWG6lkhCg46MsZ6UokwnK?=
 =?us-ascii?Q?H6zn+274iwwm8f6PZN8uH3MokMpGj2LWi5kMlNIcmS+0plXzQTg7BBlcpzoi?=
 =?us-ascii?Q?w35nGr060/7OcNKe3V348Umx9IX9cJ1zf2luHVn+6NOUddWxVM7uexXZZ7CI?=
 =?us-ascii?Q?lXoD3Tk6bzFagdpCw9BHc5aZJRSbMkv2YzHnzZsq/jtdb/3OkuNv0hckVJhG?=
 =?us-ascii?Q?0swPLavmMqyGO2/T+Q9mKQyM/0jaHG8RGs/S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:52:34.9179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132c6680-766f-4864-14b8-08dde631c2a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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

Fixes a bug where unbinding of the GPU would leave the oem i2c adapter
registered resuling in a null pointer dereference when applications try
to access the invalid device.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
Change-Id: I9466b489859c3963653976e54818254596b5a13b
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b944abea306d..ef7b59fe6f4d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2957,6 +2957,16 @@ static int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
 	return 0;
 }

+static void dm_oem_i2c_hw_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_display_manager *dm = &adev->dm;
+	if (dm->oem_i2c) {
+		i2c_del_adapter(&dm->oem_i2c->base);
+		kfree(dm->oem_i2c);
+		dm->oem_i2c = NULL;
+	}
+}
+
 /**
  * dm_hw_init() - Initialize DC device
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
@@ -3007,7 +3017,7 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;

-	kfree(adev->dm.oem_i2c);
+	dm_oem_i2c_hw_fini(adev);

 	amdgpu_dm_hpd_fini(adev);

--
2.43.0

