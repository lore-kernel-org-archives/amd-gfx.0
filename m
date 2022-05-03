Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C381CC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4082110F39D;
	Tue,  3 May 2022 20:29:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0619E10F3B2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvdRWDBh/tQP8j4wDSFVPg4tqIjg6BdLvB2vK2hATRX/fcUIpHDe56GQ4b2sRKI+2M6gYZwxiu1EudN9oQep/AlZbLMGeBBQ+FmOscoVNyUYn9/eaSCktICeWJWtB/fgVsnM5P2y4NFnVMqwz4IzF1GOgA1cfavo3kh854pV6LZBLyhYGCFZGHqTPDM6VjR8RzSGsIpx423Qx9M1GRPfr1hOAUFxvcptuLEm08DpMn3Pjf2UGZ/KnPmx+MJSX0OC0i0dwSnDb350dZEXX2F+pbbPOTcllt/B+HoEP/AGtPgLjrC71n1VuQfN/HSDp822fHwVWGvmifupTtNVjGthOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rTcDfvOGcaJwp8nJOkvykBa4hUxwWqUmgynAq38dVI=;
 b=mi2OdaPFiVcA3ITwMj6HCShBMA1Qpf2FsdQcZdJ1Yqp5FDsWa46u9Z8DG2PWLeexE/2gN1WNYFBKiwnlWCqCYDPaNrfiWG5pzEFJsIFMmqg8d322ojM+UsYO7zTE9d+vIJNtJe94VqfqTRIiCimUyMbMhCcEOb/0hVrmaf2aTBznuIb6MOHCD1u3gO+ROH1d56bhS7a6BcuM2YQv1wRryrM7OWDrT+IDilES2wiBgh3I1YU2PhkzFgApJG8uLlqgwSKufwc2KnbCrIVqsrZ3CtChGnLxpTKsh83S3o5HIaApXb1FQSracUWyqlZ6YBUmqCdQ6O58nU4pJJ9s7ae1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rTcDfvOGcaJwp8nJOkvykBa4hUxwWqUmgynAq38dVI=;
 b=083nsF2dUXOjN/AB0F182WG/nHK8/WULiSM5fy8vqNbJoYVFmnUyM47YBmt1xDO4ymufiZe5u5o4CTBCNyGuSCMo3v9ufkkJQpEvHa2i87bILiUu1zE3CaazYyd14ZX4owl9oqzTjGd296DaJ+VxbhRykBiN7IC8TYWMJvpnm04=
Received: from DM6PR13CA0013.namprd13.prod.outlook.com (2603:10b6:5:bc::26) by
 BN8PR12MB3137.namprd12.prod.outlook.com (2603:10b6:408:48::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Tue, 3 May 2022 20:29:37 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::4b) by DM6PR13CA0013.outlook.office365.com
 (2603:10b6:5:bc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.8 via Frontend
 Transport; Tue, 3 May 2022 20:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add gfx11 support for GC 11.0.2
Date: Tue, 3 May 2022 16:29:10 -0400
Message-ID: <20220503202912.1211009-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3083a5aa-fdee-44d1-0fd9-08da2d43a47b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3137:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3137703A318E2D7C20587AFCF7C09@BN8PR12MB3137.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hwNOuF09IJU1Te9I0S+2jYSrx4h2hU6Sy//oIQebvg+pT+yj6A1QEdpxCGpZINS9svmQaKXq4FP9nijYD+BI/Xwux4H2fhoWWvnEg1erDzszoPfcb6HmpvXf35wS/Yxfd601tSlaIKnvLGvluBSuBfsuJF2LHz9DKdYuaJvpdTDzw3rydScUCkake/Ht+ZTPd+cmospjjoSExuwVPjYjrEK6XZtdNwpjAgL1p1uYVFP/oORsslNGIMpJ1OGNvTSEnMLhSroxynWhgLAVKOQtr8hnifZ81s9/KxGS3B7kP4W0hLJvhaeviq0UKkoMtIlK/SL4MRb85Qdd0c9R+lXtKQsgckPFgobpOCz23mE3+iwylP2yp59t9vrS+3VEGugFrHhANghF6aiUdKcY9PYatD2T4ZXNNCg0ARJYLd48bBsFY6xffvJu41gTrB7FZKhuAhmJ3HvMQ3ROMLrpYntX6+IiDmfxloymyCINc1re+SJMXafyWrCwC0SvvauIGHuCqyQkSGhSuw141DL7J7JK0gzyH41tS3J3svpHuEFB4hUOgIAMVYc33G/9hYgMGBIS3FeBkjELe20aBulO8j4NNgn0peoFwFUcVevuNmZKhgAYAzt8/QYxguIT6HRP6tDIGx2e9bqPbm9hhHuHESjzn3fQr29+PLO7xJe29K3dEL8t4TyLfjqmwO7ueqULWQI9vJdG18uyq8wr5Hc4z6Aiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(5660300002)(4326008)(81166007)(83380400001)(40460700003)(2906002)(508600001)(70586007)(70206006)(6916009)(54906003)(8936002)(8676002)(6666004)(86362001)(47076005)(36860700001)(426003)(336012)(316002)(82310400005)(356005)(7696005)(4744005)(1076003)(26005)(36756003)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:37.0996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3083a5aa-fdee-44d1-0fd9-08da2d43a47b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3137
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Enable gfx11 support.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8d7b087b56fb..b9e04bdafcdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1743,6 +1743,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
 	default:
-- 
2.35.1

