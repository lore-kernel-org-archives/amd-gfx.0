Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C14CC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 06:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F6B11242A;
	Tue,  7 May 2024 06:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vO2zgRTr";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB58C11242A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 06:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuSFFc5TVgwO5Rx81U4pRGfa52TLq0pMQaAeROdpG70GMkKa/pew3z1WDTFy1mte/O6EMhjw0hnBcN8J99I5CVhj0MT5zLr0vRf51URazJYS/IOWH92l1patPhDTGwuPbzF8qgZD9M+ZkMpyf235SX+eutY9UOg4IVERYid6Xh975Un0b9H/mFJ7qR9YNznTjyGWQzlz+a2LMlqp7zox8sL04AK3oMmjNC8TFPYMXaMEyVjRXa+70Fvd+HQz3c4hQ0cD1kKux+oxMfNYENMwUbK4Y7aSaEg0nacI2Eyci2PT5y0A8Updh+L1TkHoZP3z+N1rSd83yWl1OJcB+y6OcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nwm7a2Rtv76GvKdOhG7X2ez3/bJK6rBEbDBivsO4cs=;
 b=cACjY3rrLjSA3m6tD3rhqDtGAY99ek7cCbxZlI0OO5chzq4pCaKrx6tsgUUxTWtAAoM3Gk8icojsKroQcJIVJy6XXbsE4K+tyc/wIJ0l91Kij08k0UTT3Np7zAxrxjtpPrE9Xvi+Ldx2SPUYDxMR0V9TpbLJEnvc+snnYtYX/wwfkmxIIg40nl92RsgKDrS8mo+xrFOP7dFDha7nQF1xocfCoAj6Ke/L+kZjYH0Rjn/yJ7JnjEO0M40yuQGd07pzbJrARVpvV/Kr/EKIiDy5eHQAesDcv6eYwWenX50hLnTEDkILl0dhrp1OJGKh5G69hOW7Gl5TlFrmz9NMt+mNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nwm7a2Rtv76GvKdOhG7X2ez3/bJK6rBEbDBivsO4cs=;
 b=vO2zgRTrfoxsTMmCJDgWh9zRhH0G6Ggaz15I/zCxwj1pp9wbZBNsJc4TsmzWPxtzKdq/dhLTIB0/SzZMgr/NopPcSkLBFKXUeC232C6mHApWcks6nvP80pDMEZPwoP5MdfVjmQBVyAzQ+nZ96gnOAE92Onx/rQdiRTCmYPLihcQ=
Received: from BL0PR0102CA0062.prod.exchangelabs.com (2603:10b6:208:25::39) by
 DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Tue, 7 May 2024 06:27:11 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::e5) by BL0PR0102CA0062.outlook.office365.com
 (2603:10b6:208:25::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39 via Frontend
 Transport; Tue, 7 May 2024 06:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 06:27:11 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 01:27:08 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: change log level
Date: Tue, 7 May 2024 14:26:48 +0800
Message-ID: <20240507062648.790125-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: da11837f-2980-42d9-2f62-08dc6e5eba45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z8YObj5jSIUgA+iJXOlu+E0pFqGicJx0YLn/1z4ZlVjRIuzTUPVoJ9bO1abO?=
 =?us-ascii?Q?dFnD1egFpTxU4Ad9YVWCpT+lBR1cxSET4fy/nalApNOnwxOwkxdKV1vANwDu?=
 =?us-ascii?Q?GNxs/R7M9hzh42+gjRUL6oX13wN+COzfgMm8QyKKn1ueA2f2jyrdEEgU1m1b?=
 =?us-ascii?Q?ucjkf0bbXUrcKTdITNvSrvCzOJ+rwnQpAgv1uatzSTpLr191D2sT4BbXtjfs?=
 =?us-ascii?Q?OX4rWa5ZqhIr69LJiQbbw6PUprsIHElw9hoh9YA6udrGBq0YTG8SKH6Q0QLW?=
 =?us-ascii?Q?VbkFqDI+PwzDyd+0R2HSh7L9AL46hoHmt82XT8GgfOf2cO/lOcTcau2e8Bk/?=
 =?us-ascii?Q?1vP0UG4FLFboVsSb0msTSVQudRz7f7u4YWlubrXNsTYAPkPfuo91U3DOODLu?=
 =?us-ascii?Q?DbRepdEV/8F+KbJiwoVjkcvO6EPzdUtRYaAaIutmMflKLtvdMVXzW9pDtv31?=
 =?us-ascii?Q?mPRDbXEO6YGOdGdhDovOxmCFTiZbgKnotuHBAmdR/+YpYCyvREGSqcZXjvfE?=
 =?us-ascii?Q?SsBlxlI3f5p99G+8uie3PFJxpQCtnDlNncdQtxpCl0l/p0sRad/WrGerKapb?=
 =?us-ascii?Q?DAERmFV/5rMCKiQ49pxKhfg7zt7H3HeCtGfSlbBqtl5nEy2XDl4Vtgznuu25?=
 =?us-ascii?Q?3YkaF9g19cAEreculzVNcqQjCLw4QNscJCpzdv+i0tpR49RG8wp3AKPl2YMQ?=
 =?us-ascii?Q?Bp40I9PXel9YeBfRCgE5bwq9NjNLZIafc5kYjuhNKCjDkfPciPdLZSFR74GY?=
 =?us-ascii?Q?wfRxqdyjl9t7AX3BeGAMkTAVsDzBPTDoiXwO6tyP73hhcMO3t413z/HOMnF6?=
 =?us-ascii?Q?up5gdgGS4kCf1MQ8uCI2QOp2HlTehU5BoMZK8uhOw4K6wDMPVeWFcdCT9JMj?=
 =?us-ascii?Q?xvDaavRBRjiI701N6I9fdRquvxStiYko8QakJjWdL6mYCrr/1y1UOBwv8Q7c?=
 =?us-ascii?Q?VveyP76iwgwj6SLsu1vCr7U50mraJ4krjo6PhoXABS1J+qs5kGa/cTmBlQrs?=
 =?us-ascii?Q?Ao0g/vtwjFK2lytR2y+WhmyibxAR8zHeRUbc8V5BK5+2pEXPB/J+zBM0giin?=
 =?us-ascii?Q?WELsQYt0dp2QHIr0xIPydx+Y7QupjZS5MshJuxrPM3trhkpHaZqoSQ1JLDOK?=
 =?us-ascii?Q?TWF17TflMUhj8z+LIwRGoPna8e6eTXO0lwi70JsAjzmVEfstJbHIti/C9znr?=
 =?us-ascii?Q?JIu5oZaQdWc7IlV09kjMaALp9sQvSGelixZaN5dRnZ1YfqYjadhiligoYep+?=
 =?us-ascii?Q?xrojC8qKBYqeh+hm8JDzo4LUfddoKOdkDSLZAH0/lRuPQXDYmz/fUp+GmDR/?=
 =?us-ascii?Q?nP5J0gFwfSJyagcPtlN9d5g7HOJDUmWTLtfllSP1tyidDsbUoffWn9UbgSnk?=
 =?us-ascii?Q?STJizsc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 06:27:11.0220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da11837f-2980-42d9-2f62-08dc6e5eba45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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

Change log level.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index fbc0d9854873..7acf43582ca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2907,7 +2907,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 
 		ras_block = poison_msg.block;
 
-		dev_info(adev->dev, "Start processing ras block %s(%d)\n",
+		dev_dbg(adev->dev, "Start processing ras block %s(%d)\n",
 				ras_block_str(ras_block), ras_block);
 
 		if (ras_block == AMDGPU_RAS_BLOCK__UMC) {
@@ -2929,7 +2929,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 			poison_creation_is_handled = false;
 		}
 #else
-        dev_info(adev->dev, "Start processing page retirement. request:%d\n",
+		dev_dbg(adev->dev, "Start processing page retirement. request:%d\n",
                     atomic_read(&con->page_retirement_req_cnt));
 
         amdgpu_umc_bad_page_polling_timeout(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index bfe61d86ee6c..94fa6c37b7eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -71,7 +71,7 @@ static void umc_v12_0_reset_error_count(struct amdgpu_device *adev)
 
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
 {
-	dev_info(adev->dev,
+	dev_dbg(adev->dev,
 		"MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%llu, PCC:%llu, UC:%llu, TCC:%llu\n",
 		mc_umc_status,
 		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val),
@@ -575,7 +575,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	err_addr = REG_GET_FIELD(addr,
 				MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 
-	dev_info(adev->dev,
+	dev_dbg(adev->dev,
 		"UMC:IPID:0x%llx, socket:%llu, aid:%llu, inst:%llu, ch:%llu, err_addr:0x%llx\n",
 		ipid,
 		MCA_IPID_2_SOCKET_ID(ipid),
-- 
2.34.1

