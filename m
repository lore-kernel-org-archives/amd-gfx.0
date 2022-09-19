Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2A8ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 16:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B3F10E6A6;
	Mon, 19 Sep 2022 16:44:03 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3893E10E03F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 16:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qac3Df1+E+rWY5GTy97uHDag1M3G99Lph53guEJi/JGiGzgx0t7FGFrhl8soM72xb6GZTrs1NBEapQK1ACOxY5Y7PlcEt1AHZV7Ev5TXtc9zoCSbx+mmHfQkP2OgELknsyPAmWUIeeVsoiB/QpsSPEi2M/IKOoTlfdR+OPRjSvYM3awhhOrA2+JWtwfZu9KUzVKnWZEZzPM2f9xoQdNFj44x28tn2Z3jr6KkGj1kv9z5bmU/bqb6nTVJ3eUXbJ/IWfpagki7FnFF6f+zCU2u2P7yXHnTxudh42oD0LK7Z4u1KtCkHAvhojyPjEV2rJzFAjlF9NzMyRdMhDQxGFTJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPAY6zmfwqplu3sLMz8EQJrgbmlhncRoNdxQ3cbVl6w=;
 b=WeZ4JvKvyK2QeJQ0mXSuCVClJ8dNOxAdzJjv8GkUh7S4ffmaMyaIXrvEab1CbqPtuSZcOkcygJFA0uak6IrXjYzO22YaPRmBVIVBGtweJe+owIFkmd2gsoiGBxNlEOdbwh98UtiU9z1jRXV3eUEZRI256tCwEC4epzPWikK78OtzJ4u1D8VNd4stDa4rLqmV1lR0UyZsRI2RGcYVhb1DjraG2c1/dWb0RQ0jYFl5DX3Brb3L/1MXMeutYTfjyieOU+76CSIgmcN9O+wQpCo2Bs86PEwsh9Nh+aYzeeyEG9cxCfvQmviBsqMn3Z39Uw7ZMidKNqvpfJUbxeNaxD4Qrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPAY6zmfwqplu3sLMz8EQJrgbmlhncRoNdxQ3cbVl6w=;
 b=Qt5ug7f3Mdw2d97aaoJvOCKh/P+P7k2LH29uhErLzICP3VOtjhtsqsdCmRK9CfdcTGxWKIOQZ4KIz3OucbBCihE9AzUe0ofj1d2qa65X9xnosvw1o6NdYyWBsuniz5KVwjfVNdZ3bxeUdx4Qg+6+2sbcUekkmojS4QY8N+yLsCI=
Received: from MW4PR04CA0316.namprd04.prod.outlook.com (2603:10b6:303:82::21)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 19 Sep
 2022 16:43:56 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::35) by MW4PR04CA0316.outlook.office365.com
 (2603:10b6:303:82::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 16:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 16:43:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 11:43:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix transfer function passed to
 build_coefficients()
Date: Mon, 19 Sep 2022 12:43:34 -0400
Message-ID: <20220919164334.1579973-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 4178a8d6-0892-4f46-948a-08da9a5e2507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WOSBW9kr3m5JvEkiptEBSerLhCow0XKIK/yqcHlc24h+wRrHVKp6om5wyvq2YmOcQFGVO4OORlCLnIz8HBBNVTd3MVybs95InAtOidUrSDirGvLGjAJ3ObrTLwgn4U/ewR75CKoT6ZutYBiPxbvXouqzmsW935lgMqv+muG9njHy3UYtxEfs7rzJYQapKWTW87TZtYhm8ehRgAyw7rdkrV5PAPCYaXT6BlJfZYQBGjPBzNQi52uAg1XC2J472UqqabXGem4JsFazugLvaGAVfKsRcD6CvqeFEnZ7nqZ53v0PFSoYQkLwhG/QK+QrYJ51ICRamPlVbfMqjY2ebPAsiMAL9u/L/nNkdMUJTFd2IQnkjX1KzjHubiSq5z9/PU44N5WmSSlp07rsI5MvbdJhrlfL/LlZzVlSBRVLi4yv0Z7DtXU6cjc+2B1Ni90ZIWWPUI79FqmB5OwzpVLnuZxoOFmti62UurM89CfXnc4QcxAEb0nibzEnEIQS9BPferu8s60ijQe0ktUTNvI5IkzM5cc7XcHW9MKimi6PWXNxaH/IzYVgbjgEho+oInHS8zsf+J7vngnY1QQJdCpM2JoOCj9tycURTAODOGUD1nP8TEfYarzNPFxadtj5JYf48qxHQdz+REtZDWcox+QOVdsoWSMBPSaDTL1y1AnK4mjava7kDBgz2wsO9Wp7mdUhx2DvaA9W0mhVtuVrT4FLtv3iuE5tBVCwil34v7HjiIuD/tbl4+BIcTvcq7SD9y1m9QjiCqb3XZdSsziCV0LrMiGwixBcaICf0MsHNxAf/vb3WI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(2616005)(7696005)(336012)(82740400003)(70586007)(2906002)(26005)(6666004)(86362001)(8676002)(81166007)(5660300002)(41300700001)(186003)(426003)(70206006)(16526019)(40460700003)(47076005)(40480700001)(8936002)(356005)(83380400001)(36756003)(36860700001)(1076003)(478600001)(6916009)(82310400005)(316002)(54906003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 16:43:56.3328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4178a8d6-0892-4f46-948a-08da9a5e2507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
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
 Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Zeng Heng <zengheng4@huawei.com>,
 Jaehyun Chung <jaehyun.chung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The default argument should be enum TRANSFER_FUNCTION_SRGB rather than
the current boolean value which improperly maps to
TRANSFER_FUNCTION_BT709.

Commit 9b3d76527f6e ("drm/amd/display: Revert adding degamma coefficients")
looks to have improperly reverted
commit d02097095916 ("drm/amd/display: Add regamma/degamma coefficients and set sRGB when TF is BT709")
replacing the enum value with a boolean value.

Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Cc: Jaehyun Chung <jaehyun.chung@amd.com>
Cc: Zeng Heng <zengheng4@huawei.com>
Fixes: 9b3d76527f6e ("drm/amd/display: Revert adding degamma coefficients")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 04f7656906ca..447a0ec9cbe2 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1692,7 +1692,7 @@ static void apply_degamma_for_user_regamma(struct pwl_float_data_ex *rgb_regamma
 	struct pwl_float_data_ex *rgb = rgb_regamma;
 	const struct hw_x_point *coord_x = coordinates_x;
 
-	build_coefficients(&coeff, true);
+	build_coefficients(&coeff, TRANSFER_FUNCTION_SRGB);
 
 	i = 0;
 	while (i != hw_points_num + 1) {
-- 
2.37.3

