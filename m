Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA825EE0212
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BEF810E248;
	Thu, 14 Sep 2023 02:02:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFE110E245
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw/snitiDTj2pUpWqdZuadmQxe/nxe+IjuPl3/P0/+4cM1wDZib33rHktGQhYHNMzyMwn5Huwr9q5BymQ+dRvdsLEHaKyJO6Ij4IF/NvADbJSnpwMzMvThJ9oB6R3hi+lG9k9b3dnBXt/0zTOp0qjdYiBY5uJ/jHByYytbSiLOAVF4OwP/RyD2SXPE7Y3RS+3I1QkUN6KNqK9I96WbzhDvgb6h0OsyfPYJadghszrpseSbx7vzsstn9Slwjv2PQrKw/GkRT01sBUHZU5dMoJbhSRdsPoy2Szj+FGjeI8aTrXCVyT+SQWFLazSIQx6w9m8xvfK0jeQp0j4G07ec+2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvc+DrjaIrHAw31RTNeBVGBy8ZcED9DKi2k6BcF2RGo=;
 b=d7KuNSmoCstfJ3Ks4VJJIwMTl1B6nTn6Lhot5N4zfj3rUBBLICPYkBmDdAjA3Xzuykw5aNnWVRWJ9SxMUgKwbBBosbO6y29DA4gV+bBYxGCygk5VT1ttNT4DzWUAvhrCYFGvBCAsEgFhyTRWnlrGNh25VxXS8CvtSRY4GaCm/u8GT3OVWtJ2xqZtPsM8IN0XWivZO2ziaLXQ1Ojkra0KWVnI7sxdHnDpcdNLb5gVqFIDH7yKaXddEY0aHsyaSNSygii80MsYBlkcSBCkIBVkZvs5XELGJM+8WVZ6eFFbh91GfqQJsisf3lIuMGuCNUf0DTB/bx/lVg7LCfTBwiDmHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvc+DrjaIrHAw31RTNeBVGBy8ZcED9DKi2k6BcF2RGo=;
 b=bIeD2LS+iLQNVZgdMPmluZ5ziqyuLBtqKM1SynpXKoXwsumbPTvTxJ2q52SOO4+PBSduphw9RPjWE+9TyB+fIFD4/tuzPTyNQHJVywEZC6aV3eIKIlqym77cOqr+qSkYvecErwS3P+Oi50rsGD0WQKij8AkFmWIsAti3zLZGQbc=
Received: from SN6PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:805:106::40) by PH7PR12MB7796.namprd12.prod.outlook.com
 (2603:10b6:510:275::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 02:01:54 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::33) by SN6PR2101CA0030.outlook.office365.com
 (2603:10b6:805:106::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.6 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:54 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/28] drm/amd/display: Enable replay for dcn35
Date: Wed, 13 Sep 2023 20:00:11 -0600
Message-ID: <20230914020021.2890026-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e547352-b3d4-4cb6-29a5-08dbb4c691ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6U+UpQT1/lIzShMi0554RSztnNk00ve4PmrargunD6O7HZ4csy4JYYoOb4ZMyDcFMAhO1fSdf+3JHqSRy9yiSevk2hMLHht6wx4xpbv9+qS+f62jC8KkS4kgyzYsbEgxPhMyN5pYQUNyNmllGg0h//QdwoEGquVSGtTBAydnw0aQkDKfZvDfVSYzv1J1iqSLMsARvHFMvutzj/LhBDGgZLa5EgC32LSSFjPB6qfkbiHkiLWwO6l1lWWzfESQ26PTo9ZIKwC8F8nJxM46DYsmkuwv08nYkduKKG+pSZJB3xqBys7ss0v5I07rnuKOK1VGKWZGbDzG9lg5ogOGQNlTjpeONhKqtXiIpRdAsiAvBda0DshTf+00JnQSG5Ln6uwKMWFi3p9MmevvlFHjJ4rNMRGO6XGUxqJW6TrdbYOPSIZpEXLNJPMmXXga0tDZirzkNsGKtXKMX9QQFpBHCD6QE6pseEHYDxGaES+y8mrP7Wa1vFmV1Nw+oNWvMVh3AUt+3umsd4dfo6NozIqLxMr1rdsnfbX0CYPZQRTYREqepIMLoEyDSkGzURBNSNGOdW2w2bREYi3IIEK6JyWoU1xlK5NX8Y3jX5LNUF15CtjPTxgIN2D4bvtoeF51jINLODlRGm2kS/3p4qpTWp+mGhLIQJv+fz3BLfd6VZkFrAjXrikVQt8IrIvA4/BKtIAx9Imh8rarRGedEBBMpOCv3ZXJ2BqIk4+JRXs1aCWd4djyhr2O6dm0AqBJ3/VkAXWNIpcbJR0H+uLwlJOBbHeV4Fxlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(186009)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(2906002)(70586007)(40480700001)(6916009)(47076005)(40460700003)(26005)(356005)(4744005)(36860700001)(81166007)(82740400003)(426003)(16526019)(316002)(54906003)(478600001)(5660300002)(4326008)(336012)(8676002)(1076003)(8936002)(6666004)(41300700001)(2616005)(70206006)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:54.1932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e547352-b3d4-4cb6-29a5-08dbb4c691ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
DCN35 supports replay.

[How]
Setup replay config for dcn35 on device init.

Reviewed-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5efebc06296b..f146609cf0a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4476,6 +4476,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
+		case IP_VERSION(3, 5, 0):
 			replay_feature_enabled = true;
 			break;
 		default:
-- 
2.40.1

