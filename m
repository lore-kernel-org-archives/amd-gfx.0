Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4550C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 20:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E71210E4CC;
	Mon, 10 Jan 2022 20:19:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7466110E3B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 20:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXfernTtwNedM5Tyr1GOefWFTmQ+fQ7lwjqEuvjP03pApRWY1WlcnRr5NrplupmJ9Od7s573r2FMOYHMJxVhNTcEmV0CNyPtUToYTuD0rR4rUo4+I52/KbZviFKTBxigGuY2dTmt7NQznd6TydyDtGZlaNzwqw5n5xOqJZwNqu4OGxuRsHSFfiDqaCzhkI0iMGNPHSxzgHFjCYqYl58iIjzHu4Z7+65e64S4TcmTinqt+J8UATk5MrymNbAt2uyrELrtOQTGa8c4GfnyhGmn6rptl9VzgfX9CUpXUVp7rFcxTwDwbIyYovbNFp1HCXaTkECiqf5gPzld0wFVcAAK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ2pgSSYcDHu3lyRWuMdYXVE3D9U0JRj5nXsImTIu4g=;
 b=UGMLo6UWJ/fhn8rgGCXG0p/62XVdneq6SKUIYj19f/fuZKxuSijw3/BJ/roAAzJCCQtQYLL2cvkWDSyQOcI+c0wKMc8uAnt9ORzTEGjN+q9bO7lnfPKhjf/A+38R9lJzRnNA4bzVTr5FIPputxw9UW3lqozV0On2mT4h5JSZnMo+6y271boo3bYke3IQ961AO1ccQPrJNe7uYKDkMsymoTelHG7iPIeZx3SzXQgWqqcbpM9c75YE6aKILPOOHUurSg0LsCmTbgWENesTeU6hj5E+64JsaJN46uOUHBQL92/MaefwcKv+/KSv9Ge4eBth+vno2gvx8pW2wmiGtHMTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ2pgSSYcDHu3lyRWuMdYXVE3D9U0JRj5nXsImTIu4g=;
 b=pYr2z1qR7AYu7rqU2t6PhKjKfId16BhQnxS+/sXeEyfhxX8W2iLeSNgP4+5UVo3ZBxYYV/bSmfY2Aj990JLDoNA+U8ZGL/f5EFtfbh0RJ5qgJgf2t6oZAdSU8v5q09qmaaOUvGT652TFybUN/rXd6APrPd8pYJrv4kNJJKoKWAQ=
Received: from MW2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:907::27) by
 MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Mon, 10 Jan 2022 20:19:43 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::83) by MW2PR16CA0014.outlook.office365.com
 (2603:10b6:907::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Mon, 10 Jan 2022 20:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 20:19:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 14:19:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: remove unused variable
Date: Mon, 10 Jan 2022 15:19:29 -0500
Message-ID: <20220110201929.1949571-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220110201929.1949571-1-alexander.deucher@amd.com>
References: <20220110201929.1949571-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4512be10-e6f2-49d1-c5c0-08d9d47689ee
X-MS-TrafficTypeDiagnostic: MW3PR12MB4490:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB44906DCDE1C406BDFBCF976DF7509@MW3PR12MB4490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OReQ4ww32JpcU1BV9wOnKPE2/V/upU4Ri26Y0KkRQnwr6/LaP13OCypix4ytdmQYXJ0a3NVbnZMlwDhzqoNupVucuS99WFJr7zqavDslCJrFw6dvClWrs1Sfq21ojDKsvSOO16g1VmNnvSX1AAD+oYqEVhVIL3PtSZ4UASwvga7qaDuTk5FbvRnswVdeg5NxxLf0k3KnbaP58aQAXb6fGl7ajw+ptjwozx3IblpTTomecB0PXwZryyHjt8psS1sAYCEEOQ8G5avN3kO8HTUzpso08O3Op4yh8KToXt3QKPfUzTVZ/xGHdEfqSkje7uPsAYURI7u4hu/xF8rq3/NK4c5V0POYFDIFNV01o5w4ak9CG8mI/m6aOT0dXjH4M0qPi7mdIiocRmzWHb63h2j2xrm3bhm7sMCNWqWUZCCHWbeFe30p7huw+xKEHZI3drHp9VRGZNp2JiWaRCZPZ8izuNzOD9Chw0q6Oct6k2XxcC2Rai9mLg7opoFQmIEd8KP6YPDbdPxRoranJgbgvTLHe9Rgh+WlD0517zWrPwC8/PV1aul6+rs6dFDuESAxpMgk5UbC3vedTW5HG82YcJDEydMx1Fz/B00AGiODM9OozzX4DmFDFwleI15PpzSIBAPZk4xs2FCrxZ19urxsmkR8+CNG4L3CbJh3nFliqleXfYJ1+6HHSVArc3Wr33tAqF1fvtbTfDgPusTuguyU7Ct5H165ufAhSrp6dDp9IDkp0KUBmLaoeX7Kni4+tiLCXFjQfaxaTMIoaa/S94LXAQ5ZCYJgi8BzlkIuTvqvBMXluF0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(82310400004)(16526019)(316002)(356005)(40460700001)(26005)(426003)(508600001)(336012)(47076005)(186003)(2616005)(36860700001)(1076003)(36756003)(7696005)(5660300002)(6916009)(2906002)(4744005)(86362001)(54906003)(8676002)(4326008)(81166007)(6666004)(83380400001)(70206006)(8936002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 20:19:43.3429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4512be10-e6f2-49d1-c5c0-08d9d47689ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490
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
Cc: Alex Deucher <alexander.deucher@amd.com>, yipechai <YiPeng.Chai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No longer used.  remove it.

Fixes: 36324c09d848 ("drm/amdgpu: Modify sdma block to fit for the unified ras block data and ops")
Cc: yipechai <YiPeng.Chai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b1bedfd4febc..517650d286a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -942,7 +942,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	struct amdgpu_ras_block_object* block_obj = NULL;
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ras_err_data err_data = {0, 0, 0, NULL};
-	int i;
 
 	if (!obj)
 		return -EINVAL;
-- 
2.33.1

