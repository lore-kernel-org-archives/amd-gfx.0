Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AABEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jul 2023 08:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 605CB10E1E0;
	Mon,  3 Jul 2023 08:56:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A10710E1DF
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jul 2023 08:56:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyywDEi0BE5pZXyKdmz1REDVVPyER8mSxz977PUpt1rbw9qYkHvBfGFwj3HfOCK4hQxQ8kk/BOQxdRjAj6RdnlWmJxDig1m7pL7SeSU7T1a7btMgWY1l8DEmegqwhaJye9NWmyiD2pA7WIRbOi07Td64oYAXyv31ztKKuAVSYEnvdBg2MKwgA4XDUD19FADofBz/3WgAsLMA/y/UsFq2Wqv6wbxobTYFZ9j/9iJOzvs51OF1S5jJ1c1tkeZwZhF+coEDHvOoByJsniztZaFjQCIQH3VT0g0ea2b0P8mvZUhOls8HJIN3MyVJFWvqOb9E+nrdi91XsazBFaeD3W6xJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSEie9Nx4x88/8BtVRnwcVC+GXeTLm2Mu7D2HtVdeRk=;
 b=hnyIBEjayeDjIYvox1HFeCJcK/qbjI/X2njO2hrTy+eUptimwx3pXy2sZQg17LKAVkPmZTxVxYV7HZoiM3aIpavbCEaWGx5ULFLRD0D3MMYivB0SHIvgQV6vH+SSAXNYx/Oc25KhUr/ZZJ9lzFdWMpEMNfFSKSNnw+kHFAoz3pzTamgedyykg3n22fYocGMj4EIA6L/2O5IKP/o5plk4y1RBwBjMk4++yXyZTHN9jZA7DQe8Z4ssPArYSTszp7cjrpU6YtaHB+vYmEfyI6e/sWKlkWaO+T/vZkDmra7PNfbTb7NruVtoM1FmZQTN4/FQj/+paqRnTC4JUjssk4muGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSEie9Nx4x88/8BtVRnwcVC+GXeTLm2Mu7D2HtVdeRk=;
 b=XGV26jNoDAOsp8Xz1urr1r1bKomi0iioQZsREGtRxg9okkJkp2/i2VmTU7P5IGi9OTRHIn0m2pxIBgIKummp65ss8RS2eQ+5e1vVt0ur9fkt5NnHAZ/6YPBqOskQck5fdrKTCXKcqb117qLxJjLgjo4Ajnb6060rmTgnjB/aDZM=
Received: from DM6PR13CA0036.namprd13.prod.outlook.com (2603:10b6:5:bc::49) by
 MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Mon, 3 Jul 2023 08:55:58 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::f7) by DM6PR13CA0036.outlook.office365.com
 (2603:10b6:5:bc::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17 via Frontend
 Transport; Mon, 3 Jul 2023 08:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Mon, 3 Jul 2023 08:55:57 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 3 Jul 2023 03:55:55 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Thomas Chai <YiPeng.Chai@amd.com>, Candice Li
 <Candice.Li@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Apply poison mode check to GFX IP only
Date: Mon, 3 Jul 2023 16:55:29 +0800
Message-ID: <20230703085531.11563-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4011cc72-3814-45a3-1a04-08db7ba35170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4YLbBnMYVZke2OFIDDBitGL1y4S/c2i8lt5IApeIbdOMiZ2weDtFA5glrLQVUnfv1RPAkVUOiTRKoIiBnlGrCyskWKCYGEYjILhzZCIV2FksO473Ug9uuFeHVgQH4jXS1YcQOEdHAKygwp/A/eCCWjuXkY6EoeLg6IKJZGCb1oVAZmh8xrQ5UK7EZIRvQHe8phV1dJ5WOLum1ZEDb3N1zf3Z27doHJEEe/SDsvg+hPmRLpvzDYlUg7QDNXH5Mw0S9lRhaJhl3r1FRMZhlVU5gX1IIZhBa/xsUmAbIDXCVR+OyiP/jzouQ8iI7l0uhLvK4fMTARfDNWZC0dLZlKBiojbgAHcQSDPSieGQA8OvhAEWCpHEJFqiWEjb3ONHSxYYusKMoiRTzjJHHTyWRezGhF13rwgRigTkPIuUY4YKdy5sPWArSWJVNn7HqgKS2E0lYcp1Hy9okloTTjGCGMrv+bhyFC20xj+vkyasxf67Ol4VPeL320DXyD4KirkbOeMCQ97zfGfJpHI8U2ehzrhFc+UBQhlTzQdu2kIZ7QTJPSN0O0wIRp9OLThqBjqQGlgnthYVH6gHjZzqwcZ+uA9DTFmvL1JvXhcR9Yq/u/ln4NG8CQmKhuwxg8GpbmckhdO5swwgmJ8s6RjW3WVPfNzIAvT60sjgA6QX/1ZhpSECvnw64kYZ5UFA5pEEpnBeYdRbtlqw6/x3tQYWi50A/Tmx4dlU1LCpV12guyaXUe1WccSLMWgP+g99TviG37SVdd9foj9uLRAOIUDdnAr/Sj1e/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(316002)(40460700003)(70206006)(70586007)(81166007)(4326008)(82740400003)(356005)(6636002)(40480700001)(26005)(16526019)(186003)(1076003)(6666004)(7696005)(478600001)(36860700001)(110136005)(47076005)(82310400005)(336012)(2616005)(83380400001)(426003)(8936002)(2906002)(5660300002)(4744005)(86362001)(36756003)(8676002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 08:55:57.8462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4011cc72-3814-45a3-1a04-08db7ba35170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
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

For GFX IP that only supports poison consumption, GFX
RAS won't be marked as enabled. i.e., hardware doesn't
support gfx sram ecc. But driver still needs to issue
firmware to enable poison consumption mode for GFX IP.
In such case, check poison mode and treat GFX IP as
RAS capable IP block.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 041112c7fbbd..8524365761b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3150,6 +3150,7 @@ int amdgpu_ras_is_supported(struct amdgpu_device *adev,
 	 * that the ras block supports ras function.
 	 */
 	if (!ret &&
+	    block == AMDGPU_RAS_BLOCK__GFX &&
 	    amdgpu_ras_is_poison_mode_supported(adev) &&
 	    amdgpu_ras_get_ras_block(adev, block, 0))
 		ret = 1;
-- 
2.17.1

