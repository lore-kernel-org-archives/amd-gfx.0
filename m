Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D1EC47DB3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C82A10FCD7;
	Wed, 31 Jan 2024 20:15:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FAF10FCD7
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:15:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UficlPtNxQ6ZxzSOWexYQZy+ZJNvybJesOlOsPlcs7/jrlsuc5DhCFEKF9kkqqGng8gwOp8VzQyptfMnQr98yAiEU4NLgDRHmV1U+EplE3ZR4g8KZZb8OUeqv91yMn8v+Pwvg25xRDKqqRj0aNlcgDjr7bitqbqyZ0wjCeJYYqCBzlto6TYnSz2otmb9kj7NZFI7+/fqh+oyxTTOu/lz8ohI//c2jGAUDNiO/X5Nn6Gp3cg9AkyPz3H1I10/q39WuWwmTv8SZRQKy2OCWpppJ/s5Hi24Kyo7NMKaSvSJT5FZJSVcK2HAN7E69JGzA9QbB1/vFC1fZUlBt4dFsebBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIywnsnsy0m0MS0b74ix1zvYjUEe0Sw+LF8PcvzWTnE=;
 b=h6zxvLgXzYLRY3QyoKjI7Fgvc/Irv33XrlnXQ08YBuvUh++c3/1w9clcgE6rb4HwimZkr76YJ1lOXwVAdswz8hBoz2KCkGUtbqxWv1Xswc+ZdvtICuhv/e4mmRoQw3IoaUwEWZwyJu6DyHEsy+qRtv9COtx228Ot04t/Je0T8Uw881221ezZ9ijgf+ZPlSl+Y1UzBtYy/KjF2/IB1TseDCPniIKEeIMvOBNdB22qmTAaSczNqJX1x44J1vp/Fzab8J1uLFVTc+YrTtwPoMyqVv2EuBPD8D22LSdUJbNbyV6NdNaxVveRxLll/lPyYJzxv9pLOGL5sVsQE69magMmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIywnsnsy0m0MS0b74ix1zvYjUEe0Sw+LF8PcvzWTnE=;
 b=qlHnvgK1xmYRuOnXChnpkeka/h3e2cYUbhMTd/9ozts3vjN3tpVpc8YHuMgWREXUvfsNg1Nnf5wnO5vwaFfy5tC/sL0DUxsEnn4FvfdnvJMbtbfB8A8TDO87TVHFKuv08e7rrMYq6B2pdiXjD1pVMGZki3hOSxfl/OseNZsNJM0=
Received: from SN6PR01CA0001.prod.exchangelabs.com (2603:10b6:805:b6::14) by
 DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Wed, 31 Jan 2024 20:15:48 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::b4) by SN6PR01CA0001.outlook.office365.com
 (2603:10b6:805:b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 20:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:15:47 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:15:20 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/21] drm/amd/display: Disable ODM by default for DCN35
Date: Wed, 31 Jan 2024 15:11:24 -0500
Message-ID: <20240131201220.19106-19-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: be831b7b-80b2-4557-2899-08dc2299698f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1yIckhkNI5f61Lobs+R2kN2aZel0b2JYHYJt9c3a4gT15lw9xq1T8+7w7G6hC9vsZfHTmTfmYGAZ5DiFn7JhVZvLfvlyQHVDerK2tjEOmcSOOh9kR17N3AgZ3xIjrC1Y3aA8olu4ls2jIT+wuwqrAvtr2zHOvgCEzDYQHh48zdba9oWmyI76EhfkEghhmpDwRwi11ICH8DGXVR8pqt4Unte+SQ4ITRziBTDq4s/jMXKmZtJjWXGfJHoxyYQNU0jK0ryOAApoqtxDcOrPIfX9vxrBjpUV0xq5K1nzLrV0Nl/UJeOLB6AjqRk3v8NMq5DtEkyUKR/fQ1LQqe/Sf1aOnooWaBA/uOZ47Ef0hvvQ7Stz69Eo781mLJTDCE1V3meo1azllnRIMqebo3bPdagv2J3mVsHbHL+dRJ5P2dIq1BkNFg5PbYN9Bd73R/H167qawmai+mY2hTF+HR8FAT8jmmCcDCr+9bfEXdVDdohBs94HTikRodN+FQhppmYtmfwHL1uGDzOzxVxMHGncZvnfc2BfSRGlZashLhmdqV8cdm/QDTAZANRcAgns0Wj3jpUhfDkDXeEWzDNodqvYhTktZKa+G5Fm0T4wUX0y85ejfjFv7hx1YBL4+q9ohVTC1UJG+JeOwoWXS8nPUB68kRYKrPrG5l2w0eAO4DGnR7I7IwyTxU+n5sb6pg0Nx6gcvJkXC9keg9akq3zZBYEWh8p1QnfjYL6uc4tGwdRAgRQzMkI3UD/vEzrL3HOPkQRzmJaEthFikrKjaJeNkxUdP3RCyiLS35HxCamj77hr2GwV8zsYlhZP4IH2Yajf2o59gWo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(41300700001)(83380400001)(426003)(36756003)(86362001)(356005)(36860700001)(2616005)(26005)(47076005)(336012)(16526019)(1076003)(4326008)(2906002)(70586007)(478600001)(82740400003)(316002)(6916009)(70206006)(54906003)(44832011)(5660300002)(8936002)(81166007)(8676002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:15:47.5316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be831b7b-80b2-4557-2899-08dc2299698f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Just ensure that ODM optimization is disabled by default.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 54249f356987..e534e87cc85b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -2132,6 +2132,7 @@ static bool dcn35_resource_construct(
 	dc->dml2_options.dcn_pipe_count = pool->base.pipe_count;
 	dc->dml2_options.use_native_pstate_optimization = true;
 	dc->dml2_options.use_native_soc_bb_construction = true;
+	dc->dml2_options.minimize_dispclk_using_odm = false;
 	if (dc->config.EnableMinDispClkODM)
 		dc->dml2_options.minimize_dispclk_using_odm = true;
 	dc->dml2_options.enable_windowed_mpo_odm = dc->config.enable_windowed_mpo_odm;
-- 
2.43.0

