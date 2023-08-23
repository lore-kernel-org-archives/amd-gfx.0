Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFD3EE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8861410E477;
	Wed, 23 Aug 2023 16:05:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D3D10E475
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhxN+LDiz5q2fzufpfK0jXZhm/bbk3n6IMjs4bib7BUJFy73Iy+LMOON7E2P57hnY0xvq3GUuY+O8Dy0TCkZ6/SPjCeIxbbVTHcSx4TvHb5mcjNWjDoOGQwNN65bGJdvXI776VR9Ckftxkkfwt/Z7kjnf3Ew6pv1IbVDuwWWI8U6mSfTd6MfhCgBVDw9dYGsx/69asaRHZDOYpBNT+ULZqVSvf8Y5UfZJ4Kt9lZp7CkjJZpAcVNMbSQj8avbptq+5zb/dpdFKuh18BqdO5Klqh2VAvsTzz7WPeK0p0qUmB8zjQMG/NsEWvBtfQbVhrFidJL8/bCAiMNc3XKeazyfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G1I3KnI10nzqjVKSQ53kltpThcbd9hj2QEqZOgMWOY=;
 b=fSE7nUhJNJMbK0WnKFKpd9/noDDD10eQ+pdd22w/dPO23+Fw+IPuW1jjrCp9EpBYWvxNII68vwLUdt4Q1e8uvMx4cglS4jHjKECqiuYyHaW5Kv7i3L+QYLCV+b5SSfX8H5di40+J8VQKFeCv56KY362SP5Dy7z8btN5VhJIR+s07mjSMzVdvQolsVcfGGEFrnDGv0QEa31orWq4+tU9J3A4cKLejoqbwWR7/rnURPdoWRKBKCyh1JH+zNrCt/rFD+APFvavFwYNLV+9xqgx0I8G4BIuXN1dBFUvWWHBFdq0cBHooPDBfZkQwr+OYon7gF44a6niPFEAK7Ah4Zt/KJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G1I3KnI10nzqjVKSQ53kltpThcbd9hj2QEqZOgMWOY=;
 b=r4+p3xC1ZRo8b9Y9Ds/IcKSzTV8m3ncv0yUhtFAT2Cqq047kdetKY5WmjdcZ2Nani710+S+zDoKNq9fsCure8uCK/0nhotORlnl8L4wiI6wCl71StynrEdi33t929csxOR4vko9LHR4kKu49Zqh5+P+++xOYdgeHoBLgp2B6vKw=
Received: from PA7P264CA0112.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::15)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 16:04:57 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::91) by PA7P264CA0112.outlook.office365.com
 (2603:10a6:102:34c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:55 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:45 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/21] drm/amd/display: 3.2.249
Date: Wed, 23 Aug 2023 11:58:23 -0400
Message-ID: <20230823160347.176991-22-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f67e9fc-14f8-4d4b-d5a2-08dba3f2b185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjTvJNfjfFmlSxkvRGxrXj/j67ATVIavuZD14wuaTZIqrsYROzXFKm+jo2Z/D9iMKOchF5QDDVPqZ9Z5k/j32G49l9E0fo/NAvv6aS3o5AWidSHxLSUYGaa2LIit0quKs3TZG17iTESyjhlPW9fi3EoAo9phIP3NoaCGq47hdK2XS74Qg9Cc+zFk28ipP1S6k1ojczND718ueMBPiAeiy63S/k1fPD+pI+l+7TfyuBTTtqR1OZpX8wtrP9XgmSFBLc5tWzZV+NAN0oxo87mWPIJXlwqZ3ZANgdpR9tIy3wDbI/sXLCDnN/ge1w8hBj8N7mihPziTO67n0r3zCj6fSWI+AzvdVymj7buICdUbyjcH0GgOwwL+1E6dRwDvIvhtk7TLNwShYz4myqd/ucwHX1ZC6wjT69Sztqx/LZLbKxS62nB7bsBocKpmMi7nga0gDkDUgSBAm+UWYhKS4EwwLYWIFvmC8HfFmw8Xuej83yfdctMORlNhONQDkuhCkeL+rTfJC3K+ZHQRxOltQcM+kZxRihE2xkqXNIpV8y/6uNgQXYHmS/czXYyKByBDZj6ZtiSNnDq5gOHgvT3MOsvgS/67pxpCNFTqznhX0nq6tgL8EJD5lziKVLC6xtID79GWuaednHrmdEYUcmAMJhHdLNw6BVjpyDgJw4tboqgqJ4Uk3VCriJEHY/AQsHrOp0ztpBf8Kr6mBVgRGFztI3tsxETGr6fnMcttyZyz52pYa0ycZvCqlH6OiXLFNTScRCjqj7BUfFG7dFGnRN3kjzi6114k6agWPiC53cg1zjDfOg3OlsOKTj1ohgxly/ASLDPS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(2906002)(4744005)(40480700001)(83380400001)(44832011)(426003)(5660300002)(336012)(16526019)(86362001)(36860700001)(26005)(47076005)(2616005)(8936002)(4326008)(70586007)(316002)(54906003)(6916009)(70206006)(82740400003)(478600001)(8676002)(356005)(81166007)(40460700003)(41300700001)(36756003)(6666004)(1076003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:55.8183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f67e9fc-14f8-4d4b-d5a2-08dba3f2b185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
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
 qingqing.zhuo@amd.com, Martin
 Leung <martin.leung@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

This version brings along the following:
- DCN315 fixes
- DCN31 fixes
- DPIA fixes
- Dump the pipe topology when it updates
- Misc code cleanups
- New debugfs interface to query the current ODM combine configuration
- ODM fixes
- Potential deadlock while waiting for MPC idle fix
- Support for windowed MPO ODM

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Martin Leung <martin.leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5d41a14844da..e663260f0619 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.248"
+#define DC_VER "3.2.249"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.41.0

