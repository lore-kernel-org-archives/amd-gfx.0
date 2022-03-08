Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B100C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 06:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223A110E8B3;
	Tue,  8 Mar 2022 06:21:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173B910E8B3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 06:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCcxCJ60jEwyKa9DLkaur8Fo9N1EPET631F1QplmuxgoDnpOwetZ0cC5NROWKfSjsyMtwP0kkjg6tAZKSUAYmjlOOkLW9v5US3Vdjq6wEP4ot6PlNoh9E23v+sdppSKeHVAXflzLaK8PstwtsuFJOeV1EJpyXETTB92pBlUNHbzX5YK750qOpXCy2dhs2EC7krrTJJOADCCoJO4Awuc7Ne8dMH0luaiNk/pLSBPUT3GcoFhiey1h6WymG1ETdL/yR83ELWa/P+SEslpBfsLHsuVeuiPMPBn6pN3d9XsUOfVhMZdGUDEcvXJTdR8vRByJkvdNnBZJan3yKER+675L8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYTc4/YMftKyohqqKFVIoKioM7km0GeP7aPVVUMsCL8=;
 b=RkpAfrT4vE6nbTHK7X+qpcD68mMxsCuzGydwIjgLb2svAaGqVXrclpTdjrM3RCWUr47+3RVIWsz0vjHWkBTd07CTNo9K8PPPHMkcZYkUT/yE1d9L0f+FQBuilGAkujs4O1kfIht17XhSuJBBwUtx2ywMKNnB8iZh7So9es9Y6j9GHN7Ofs9IIWMOlcVisPll9LyhbTmxMEXvnHwZ+9Adh4M9oZ52jrFrT8LR3yI/NocaTGxbepbXNtxZXYBDYSug1u7sXSNorN5I6VLd0HmNkrfydTpoARZ/s8elE5rlB9JR3taIBjMSs/9dcef7xrR2kmjXPrRfA+G7K0HwEWZEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYTc4/YMftKyohqqKFVIoKioM7km0GeP7aPVVUMsCL8=;
 b=Uy777eWhJjMOIWDZA0lfY9uqwa4hXlxrcMDVm8CsUU4fkZgps0jXR3bykUpvpOAopaHim5OA1D/DRT0t6g74Og/Ir4Ry2so0JP8c4bo59ijGlj2tkHbVoa/OHGBXeKdPuuzeJTTDnEJp1TxQ5Yzs1dj5Zxii4Gy7h4X0yZIOGY4=
Received: from DM6PR08CA0043.namprd08.prod.outlook.com (2603:10b6:5:1e0::17)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Tue, 8 Mar
 2022 06:21:31 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::70) by DM6PR08CA0043.outlook.office365.com
 (2603:10b6:5:1e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Tue, 8 Mar 2022 06:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 06:21:30 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 00:21:28 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: align ip discovery naming with legacy ASICs
Date: Tue, 8 Mar 2022 14:20:43 +0800
Message-ID: <20220308062043.2128688-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d663252a-1b79-400d-7651-08da00cbe2bf
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5633:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5633109BEB6A6B7E5A462B9AC1099@SJ0PR12MB5633.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCQQJQcXFrFOQBkF8LQNjFctAE06mkr3P3oX3uDVXaGC8KpVoZi6KS0CaeaZniXPlW7+8HYU92R83L55A6xbTTjNdCl2VSLhX7N8IpZNw6dxPB59yqLtJdMFkXxKu8nsJ1NmKcaXZl1APpHnje35U5dVPon9PJ0csK/gXxDBXotP1/wxx2OBMfEypWNUu//PtTMQRhbLnjMVc+gGJMrbjJGb+r8rwQxZ4tal1DggWTLfmH8RuJL61kRkeHKin9HME6ZHfXCsq8cLTqMd293JcRK8HBenrdFs7QLfn9n4sW+JlnHZuUbq1lFepGZ+JoHL+l3F94xzm72a9saTeeW1CwIbeFOpQJS+u8Yu6MxJ/TxChxM4aWPCEWUIsiQ0Lopu1ElzeYn49MCoVnbeetXY6Yv/CnS2fJZDnLtcDFNzlhHp3+3OI0R93VA+aJyIfESvTAup4qXGN63c7/268/U/l9HC7ohr2Upu8jeZFLhzrQtmFT4NyStvH7H7IrOzLqcZ2P7SZlAbKPW1N4TF8Ra/HLRv2nX+4duoD3vD5aGLIeVDEkZZHIHzfRR81TiKR1A32qUzjHCzAua6nSsompPtSaJYZWNZ8orwImhWkqF5SFQN2+20kYBlZ8zUeLdVwd4SLCIbSeOq3X81P+uBUe/9Mispb/zyJUKTLqF2fSxkz3hUF7eJ9DH3V3vne76m6GzdgXNc5lrJ9PruvVgLSykdEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(6916009)(70586007)(4326008)(70206006)(82310400004)(54906003)(86362001)(316002)(6666004)(7696005)(508600001)(83380400001)(36860700001)(356005)(47076005)(81166007)(40460700003)(5660300002)(8936002)(36756003)(2906002)(1076003)(336012)(16526019)(186003)(426003)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 06:21:30.7812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d663252a-1b79-400d-7651-08da00cbe2bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There some code assuming ASIC names are non-space character.
e.g.

runKfdTest() {
    if [ "$RUN_IN_DOCKER" == "true" ]; then

    for hsaNode in $hsaNodes; do
        nodeName=$(getNodeName $hsaNode)
        if [ "$PLATFORM" != "" ] && [ "$PLATFORM" != "$nodeName" ]; then
            echo "WARNING: Actual ASIC $nodeName treated as $PLATFORM"
            nodeName="$PLATFORM"
        fi

        getFilter $nodeName
}

 getFilter() {
    local platform=$1;
}

if launch run_kfdtest.sh on a ip discovery ASIC, platform in getFilter will be "ip"
instead of "ip discovery"

$ ./run_kfdtest.sh
Unsupported platform ip. Exiting

Replace whitespace with underscore to align the naming.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7abdf5e3dc05..0a66f724a4eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -123,7 +123,7 @@ const char *amdgpu_asic_name[] = {
 	"DIMGREY_CAVEFISH",
 	"BEIGE_GOBY",
 	"YELLOW_CARP",
-	"IP DISCOVERY",
+	"IP_DISCOVERY",
 	"LAST",
 };
 
-- 
2.25.1

