Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295C3C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 16:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F7710E6E0;
	Mon, 28 Mar 2022 16:53:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9C110E6E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 16:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRUkV4wgOK6IYVYDjKEFBoKSa/7SMRXfeGg2xI2N7VC+hq+3Wmm1NL6zMLkoAc7ajkXX81rqi1ce1YCH0GAljcLefQzGw5oUfQBK0dhbzaLFFIrhvG4xqjB5Pznh0W2EplNQrlIUCeBfxhWRfMqksCs40GhV35YMGiFcx4v2Y7hA55tk3ZWHwx81rszQYKvInrtjxmiHu2rAvv1ANJsOCnrgJ2As0G2GRQPjcWYXeCx/o5wZGPpOf4E7do7C2V0tw9Gw9cB9cDu5WU30OmwkYOp6zp7r1/s6ricEnFgkaDhzH9b8GOpqwVKfwjIspxVK6pfHplWoB0oi1lLO6eWkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbewE8KgZRyVGRtsXWIjAe0Hj4O3GbR/R5Plp7y/EhA=;
 b=jW1q8wrYIgAwJeMpu1qqh89JOLqdQhf4bhmHGskmavO4qKaZqTQdt6jThu2pL8H9h2Mz+oecnjEwcdkQXYY+hmkAH9q8SS/IsymC2+rhZTSJy5Z93oeikXziKDM/Rn3xdQIezMrKij0uSxIMap3lfBl1ZNqGujV12behAdbw9+NH2/PGl6686uddQSp7Stc/lDjOgEzFIRMBn9qVQtrAmw0urIsU1UDyR++Dj2/IyFTl9w6dNNcKWVxkFPzMaH+VPgMhIcQD3DQDDkjl8qDeR8K3+udRNuumxEN5SCUbqLT60DZKDW6ZB2y2T6OwRg90cV4rLTEDNa3t7t5fQIDJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbewE8KgZRyVGRtsXWIjAe0Hj4O3GbR/R5Plp7y/EhA=;
 b=QKrx/hlIROy0ljYHmWdG/Nkt52l9HADpjk9/kp6Ed8q933lhPNKcdcGKxN0XqjLeDbiFmSoVAvIWEQ80Mrtrl6Jq1s6rTw8sWbBJXXNwr9MtGfWJHshO9KVFBE0Eypj7fDL+M2Q7TKPLUQkcg1o5GW+W/P6l/5nsYdBA/oCM8hg=
Received: from DM5PR19CA0038.namprd19.prod.outlook.com (2603:10b6:3:9a::24) by
 SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Mon, 28 Mar 2022 16:53:50 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::b2) by DM5PR19CA0038.outlook.office365.com
 (2603:10b6:3:9a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22 via Frontend
 Transport; Mon, 28 Mar 2022 16:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 16:53:49 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 11:53:49 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Use switch case for unique_id
Date: Mon, 28 Mar 2022 12:53:39 -0400
Message-ID: <20220328165340.1262277-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88c16fc5-07b9-4ad2-8e5f-08da10db8868
X-MS-TrafficTypeDiagnostic: SA1PR12MB5672:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB5672A1A4EA97D0B9A0533E2F851D9@SA1PR12MB5672.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xdVk0LagLCteKz+NvKxf2F8YhEek80wVkCL/C4rXA8p55gBuk+Z5evXBdGfBSvZnbVwLDQ5x3AfVz4GoXl+eQzK42Ot5T2Sfiw143sg0H82ofk9S+2R+Hfa9Ymk2VU8ND4M/8HGphXvfU+pfVTsWeTUjjV4DOMv9RTupZ8cavHNtB3BOGOyFd1pMk3V4Rd2vpallsEOSrEqZFRADYtYVtQxUe9ZXowD7QOQUGKgVo+xfT/YCSlcLderDhy9+FUiCgiKdDC3Qlil/P7c6A2/Y2UNW6V1FS2hAu8JjJc7u++jZJSdLy65nc5FNl3htaoHmEyt3bvL8s9IdecqF6psPBCExxBuA+yCOrLxoLmC9tnK64lO3ha2CttT5fI/57PhG6vih+/RU6Wr9aOuovULWxhu6O5D9cV/3VhW3DN29Vb7JofxTHGBgjJ7lwIUgYJ337Aj5zrPaBrYf2wN/9CWSLRCWfLLQPMUWRv96NnOiihtifxaLMqdHnyNqSTDzXCu9Bv1c507k6QnnHMRL3Pa6CkjpQ3seIxttlf6f0BmSeDBFK6lEU9Q08e3tZLFDYF2EruAzrHjD7YDXufy5zd/8uTtc6tKvQghSgOr9jToNU0pc7CBVfvnMoBRocfV5DQs/9LuVe9mRFtNyqmC71Dl8ijkQwgtF5l6Whzv7hksqQtp8QjKC+YOc4SwUFPwou9bpWi8JH+3u2eur/xmAn9bLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(54906003)(40460700003)(356005)(186003)(16526019)(6916009)(81166007)(8676002)(36756003)(47076005)(316002)(508600001)(4326008)(70206006)(5660300002)(6666004)(8936002)(70586007)(2616005)(82310400004)(2906002)(336012)(426003)(7696005)(44832011)(1076003)(26005)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 16:53:49.6907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c16fc5-07b9-4ad2-8e5f-08da10db8868
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To ease readability, use switch to set unique_id as supported for the
supported IP_VERSIONs, and set it to unsupported by default for all
other ASICs.
This makes it easier to add IP_VERSIONs later on, and makes it obvious
that it is not supported by default, instead of the current logic that
assumes that it is supported unless it is not one of the specified
IP_VERSIONs.

v2: Rebase onto previous IP_VERSION change

Signed-off-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9ce597ded31d..4151db2678fb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1988,11 +1988,16 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (adev->flags & AMD_IS_APU)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(unique_id)) {
-		if (gc_ver != IP_VERSION(9, 0, 1) &&
-		    gc_ver != IP_VERSION(9, 4, 0) &&
-		    gc_ver != IP_VERSION(9, 4, 1) &&
-		    gc_ver != IP_VERSION(9, 4, 2))
+		switch (gc_ver) {
+		case IP_VERSION(9, 0, 1):
+		case IP_VERSION(9, 4, 0):
+		case IP_VERSION(9, 4, 1):
+		case IP_VERSION(9, 4, 2):
+			*states = ATTR_STATE_SUPPORTED;
+			break;
+		default:
 			*states = ATTR_STATE_UNSUPPORTED;
+		}
 	} else if (DEVICE_ATTR_IS(pp_features)) {
 		if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
-- 
2.25.1

