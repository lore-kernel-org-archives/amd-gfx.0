Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FD0CDD1CD
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE3010ECEF;
	Fri, 27 Sep 2024 17:01:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mBSZ1cHl";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D6610ECEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZ5rJNa5Txb2CB8AZhCRTDcqyp2o25Dixob5GnyKLDBobv2+Myng2SM+9DpLLZDpH2unmYYQOxWtttLsvaiA3NTG13sAzpg/tke/A72WnPndXPkKKWVkBfMBIPG7OpCemsEJjByPm4stCwJKSgOlXs1rlGs9Vt3rlefZYSk+nTYQF3EDtg385N7V8mXrNqvvJCyIawHrh90HJPkTyQpXF3qrHxQl2xJ+sCKz4dqcMrEbmXguFSgRMfnbPP3E+3QHdH3inY9XxpzpQWwhXpgsTz528GDd8YBij60nNWM+9aGSgGDYH2xScNreV9/CFGDW3KLbs3y0JcONTi68beQThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Su3SLIsus7CmXiU1MEWBcyF1KnCXr8jWdQUjmcMKow=;
 b=QIFsSk4hT5xJGvCBHeG58i0marCT3HP/Wc8siu5KpcMd4KTD/UYemKY5juXf3Ple9QVgS665+U2GdUZNNKtC8S6I0tJDTc/vPbiY9ft4bFnSuCXiLxm6Fb+npUfUzp94Ky9fe9HGZc1vUtmbMBpMgkx6jZS74q0902SDiNSh7Al0TDo2i51yslkJtD52503Jy/y9g/n0BdEm2qhjI2NukYwd+GM7hruqgXlhcpfvf3EX8cpso46lVF4rFjJQ1o8NOXza2fFNRb7mN/GWRIFkH7dAoJAbLBITOqjr0l1d4FUq+ZH0OVjb71xiRhvwq8Dpz175KUG7ZhDDfONIV5FYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Su3SLIsus7CmXiU1MEWBcyF1KnCXr8jWdQUjmcMKow=;
 b=mBSZ1cHlhGRPlNmjwn7qcqYDMtCwvZqjyVPXdsWn0W2IMoVaIKhv0ZgfWQsTVoIEUySD2ccB38T5temLExnG41DLQXRmlBCQPyKP5/MKklGEXIwrAvlvPRLP9ywWxzH3tc6W8QK5n4r39IEqel1+nCfuVKcI+IyI9SZ/QUDvKHg=
Received: from PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::29)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23; Fri, 27 Sep
 2024 17:01:44 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::64) by PH0P220CA0024.outlook.office365.com
 (2603:10b6:510:d3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:40 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:40 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 02/13] drm/amd/display: Fix system hang while resume with TBT
 monitor
Date: Fri, 27 Sep 2024 13:00:52 -0400
Message-ID: <20240927170103.102180-3-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 12896b25-8d47-4fb6-8844-08dcdf1610dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DE2xoJm0x+RdZjf4xWrgJwBJgiwZNTCL/QfJmLQKMDcxzdnHtDtbTUKItBGI?=
 =?us-ascii?Q?RIazRzpG5D1/K7SUcbrimyaABdrxO4Fy0JnqHFmNFa8irUvdAEWp+3MD+dTu?=
 =?us-ascii?Q?8EBHAtmArGWIr8U8eBalgAcykBwKP7E4CmA4PUct6Wy5Ipj/lnvbg6v4/TOo?=
 =?us-ascii?Q?OqFrCZ72tnca0x0v1DF+eQ7OiUeQighfo1euRzeC54TPM74Fljdj2W2nsK8F?=
 =?us-ascii?Q?gXAnElGDgBfqVkIxzm4ahzXPSsBCxnljFrBdaRuLGtXSSUUDW62zYpzvrmwH?=
 =?us-ascii?Q?C1mUJYEBJAUtA7Xm556z4y67pLivdLiAB0goAcJ8lPV//4uRUmQIAxFfdOzZ?=
 =?us-ascii?Q?GwuyCVjMo5iBNkgRh37gloWZ1c4f3VIbB59MwdRys3Wg4q9mbwWbwFXGtdxE?=
 =?us-ascii?Q?TsFlHC9ypengVZ6twI92Xbs/3HFzzuFiovlYWh9Q+9MUgQl7j5sHQmAVSNG0?=
 =?us-ascii?Q?d349qJeuaIF16nrQDdm1xfQ0Wh/+eqXOf89th71ZAxlmkuCZKDF9LBdkW4Wa?=
 =?us-ascii?Q?+BzJKfsTQ72GW2rXvHfQRe0j0GCr7qRbRk/7DQWWVle0YvZff9X2HKwzAAy7?=
 =?us-ascii?Q?czWhtR6gMzFWENkfDnHqFWoBfAdXpoPYdk6h5n2NFMhZ319XFS7HSzVMDZPT?=
 =?us-ascii?Q?ZgGxTP5gtpUaMDbsTpTIk2M70/uWIRFPC076N331YNK17Wvc3KtfX5vRlMlg?=
 =?us-ascii?Q?TkKFX8svepSISu8RuzZUj1IkLSLe3YkktrkwGJTnI9blfaYrECyGId443D7E?=
 =?us-ascii?Q?G+gXE6r+J2e3Z3FXAej/iTiRNMIXMMDNC/lGUNoJYFTKOwsQedoAJtRYEeH/?=
 =?us-ascii?Q?O4e4N0Nd+1g1ow78wGdQK5tsTwFNKHhc0AZ4hofT7Q1qLxxXx1RM1imy7+14?=
 =?us-ascii?Q?6kEYNjQQUd+Zedb3ss5qA7nJMvvQDW/tmbwddfLiNSyLoumwTW2kRDcBjsd+?=
 =?us-ascii?Q?SPB0MQNFuPMbwcvPU4LcU9/wu9TL7ani8xUZ7hXI9XpT5mVbdByTKynsNSEo?=
 =?us-ascii?Q?FM0crH76SgPg6zqWXsvDHBmVV3zjW5I+gbbRzPBPCmQb9ZFPSjyG0vOAKHbz?=
 =?us-ascii?Q?yuV4VoPwDbdLnLwct2eiN8VmgZyZSU6NdO72b9wt7RxWU6nDrgqLu0nEnthA?=
 =?us-ascii?Q?SR3Edz0M3mAqOdGLMOqcahCAJ8JgQgjjgeZMAelJhiOEpyoTZXebxDNBMYhR?=
 =?us-ascii?Q?9+o2yLgcOt3Za5jxJQMGuIQyFD3z4ALmt/ATgW1Woal2zIbspfXtRQ5mIk10?=
 =?us-ascii?Q?hgc04ViqdvPOj57i95TtbU5wg5krg6hpamMOtIN+cARx8/t+FpJAX5MnP3VG?=
 =?us-ascii?Q?chvI+8pQyvyJJmSqMbkoOsmQRz/bp4kR5+/P3qI3lbKFtjKbTURYRR70kc6q?=
 =?us-ascii?Q?wof8mDC20RPlpH6Sydt89uE9zM1FqrnT/RCbHKjQjFZB6uYdXDe0MsCJOmre?=
 =?us-ascii?Q?fs1rBIVx6cKfkdmtv0spfSp4F6k9C1tO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:44.3055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12896b25-8d47-4fb6-8844-08dcdf1610dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
Connected with a Thunderbolt monitor and do the suspend and the system
may hang while resume.

The TBT monitor HPD will be triggered during the resume procedure
and call the drm_client_modeset_probe() while
struct drm_connector connector->dev->master is NULL.

It will mess up the pipe topology after resume.

[How]
Skip the TBT monitor HPD during the resume procedure because we
currently will probe the connectors after resume by default.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0d32f9cbf8aa..054608d4a0db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -770,6 +770,12 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 		return;
 	}
 
+	/* Skip DMUB HPD IRQ in suspend/resume. We will probe them later. */
+	if (notify->type == DMUB_NOTIFICATION_HPD && adev->in_suspend) {
+		DRM_INFO("Skip DMUB HPD IRQ callback in suspend/resume\n");
+		return;
+	}
+
 	link_index = notify->link_index;
 	link = adev->dm.dc->links[link_index];
 	dev = adev->dm.ddev;
-- 
2.34.1

