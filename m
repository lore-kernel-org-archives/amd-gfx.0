Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DE1C71153
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 15:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A56210E3BA;
	Tue, 29 Aug 2023 15:32:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C207710E3BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 15:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuDhA022gPTucOZcKAhnbOho7OlNGoSgo08caNd/WR8EYoKSuNDWm2GpGcCXJInJ/WM5j88EfAveZpb3HsSSPXhs8K1YaN/Z6JBSVezLZExgaxcuJLwLYP2ZThtbEZXSj301bUh2+Gzw18qTmhmeS6vTzVkbLtWx90oJ+np9/zeexmjoOhPVBF/Ao05UvIh+IlmbrKCZFREvKEDWQtXxJNRhCR1wCR2w6DCIXz+ImuKfQ0BhovN3JqlK5l3JAQihiy97QqYzRDWyopyltLwBJyVmUBF2xh6MMMSDMNS6CYJHTPvcyTuYgmG/M73QIhY3Y9g7QC6oRrjKC9bLkGLQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iC3KttEW5Wu8kvAoHAbr2jLObaf4tEzkVqkrHmu1RY=;
 b=XCi9bCpmIHcr+4LSPcRnMztfqbx7Rnyd2jTztnPY/uXJqjyVENXrl/J0oUxBnEKmhoRYFENgtmHqJzeTv5OzRn1pCNvp9lMXYrRw70KkRffssQtAxtSSYewtwtfdi0MCOCd0pwmTn8c0fkdOfvEzvwsLBm31qSQbU00e4wvJ7qTHDX7SRjVjLYGm1fg5TDzLnNuh4smz8cp+O5AFUeonTQq48oHWOX2RakO6hU2e1gkQgunvJHpoRO1Ke+joAv5wm9CgapZPecj45L7Mtu+XRU28n1RWDLKnrb44mgquk+JJnmOlceEBY2M6f9xl26GAlGBqZpTW8zFIFGjhEJxkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iC3KttEW5Wu8kvAoHAbr2jLObaf4tEzkVqkrHmu1RY=;
 b=CrWYsqlhcuEGDzM16wu0qt64Frh6kxCwqJJdj71dCsXWn8T6hIYcXQ1RdNNiCtJaHFC0QMI6PfI6UtL0q1P2kwsHqJnrg2hTczWvMVtoNkJIMLuQr0UAIysPNk+ZYKGHnwmBqYHC2sJ2/XDZRIv+Z7zAVrXlUGnHgOOORUyx2xE=
Received: from DM6PR10CA0025.namprd10.prod.outlook.com (2603:10b6:5:60::38) by
 SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 15:31:57 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:5:60:cafe::b4) by DM6PR10CA0025.outlook.office365.com
 (2603:10b6:5:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 15:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 15:31:57 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 10:31:52 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Free ras cmd input buffer properly
Date: Tue, 29 Aug 2023 23:31:19 +0800
Message-ID: <20230829153119.30608-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 13de7ae0-1cab-4a3f-7dfa-08dba8a514aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRSD9V8sRehlfaNtWIywNHc33tORZPUBlPftiw4BheIGPrDjhNY4TCnKs21f1uG9qkMEmytjUofP/DCxHv2K3aD1pZ1K/lJtdcNvR9W1UOah+sBwBSQkKWeXXC+aIK2OLpskYp5VV5YjxRejUJQb2BbS8m/r1euYuBVrHQQsR864LpcKcq6tYQYR0Q8bp5suDNm4xsFHd6QljfRHi4pPMZrhyKNpegXTgpaj6CFlIiFRfcgl17Dvgsz1zGGM/CIKBUhsS3pp2vEFvzXMIUH12BbpW/3wqROtagpJINIZxhqtGql45RVItI4AJnRw6LqjQKmR/wFNaZrDX2B2smnivFBHiXg+Em9KFFGJHDCbyR54bjTigKX31E1lqB9OFYYjltA5+LnDezU9jLbTzHOX3HzXQSp+BbdWnI5TyI/joJonmO+eNIE+ys+UUEjjq1bSCmpG0iSG4qiiJJiznUdgJ+wlrIKwID5qqabYr/EYR6pCR8Z1W/WbgTWWS1zPYMOJpB43ZyMSLHrgQ1CZTUayF8Q4f6Cabj0Uje/5bZnzxxxrxLzqEG+IEaJyvc9re1JNQ9BB/AhA3E1NXrOr6dbkAsEZkUp6nJZoEwcXaLApIfvEOMWd0+EaLa2Gpxion8HYdU+/n6n3H/RA8mDRYPUP5MgYTcFP1akxfn52bUOr7FsHu6g40Q9m7mOkiZrIDHr7cf2LiDPLW8HgophEjCPBFym9SCQTM2LtQ0R51Gn2ohkWzFe35hGI5NMa64OT1Tvvql8xGIFSjF9KdarOJmh1hQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(82740400003)(6666004)(7696005)(86362001)(40480700001)(36756003)(40460700003)(356005)(81166007)(36860700001)(47076005)(2906002)(1076003)(478600001)(426003)(336012)(16526019)(26005)(83380400001)(70206006)(8676002)(41300700001)(4326008)(8936002)(110136005)(70586007)(5660300002)(2616005)(6636002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 15:31:57.2220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13de7ae0-1cab-4a3f-7dfa-08dba8a514aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do not access the pointer for ras input cmd buffer
if it is even not allocated.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Stanley Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e47600a8e88e..8eb6f6943778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -764,7 +764,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	union ta_ras_cmd_input *info;
-	int ret = 0;
+	int ret;
 
 	if (!con)
 		return -EINVAL;
@@ -774,7 +774,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	/* Force issue enable or disable ras feature commands */
 	if (head->block != AMDGPU_RAS_BLOCK__GFX &&
 	    !amdgpu_ras_is_feature_allowed(adev, head))
-		goto out;
+		return 0;
 
 	/* Only enable gfx ras feature from host side */
 	if (head->block == AMDGPU_RAS_BLOCK__GFX &&
@@ -802,16 +802,16 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 				enable ? "enable":"disable",
 				get_ras_block_str(head),
 				amdgpu_ras_is_poison_mode_supported(adev), ret);
-			goto out;
+			return ret;
 		}
+
+		kfree(info);
 	}
 
 	/* setup the obj */
 	__amdgpu_ras_feature_enable(adev, head, enable);
-out:
-	if (head->block == AMDGPU_RAS_BLOCK__GFX)
-		kfree(info);
-	return ret;
+
+	return 0;
 }
 
 /* Only used in device probe stage and called only once. */
-- 
2.17.1

