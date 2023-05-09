Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9A6C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B513A10E3E9;
	Tue,  9 May 2023 22:10:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4156410E407
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LozK0Uwdr/k26vLMShkHcyWxoYVBlo2DfU8OZNYSkF3/CSXfjd6pmiSHvE7Unt8FxaVrTIT/LTwwpt6zp1hovpFHLWIQF7lYCg05nyggUBw1yXELyqNkVyQOIC4/2SWaTfu/EknLQY1zvMkWQi/6AMNRmn1xuHwOnw0lY/tswS0rXEWBnsXPexpHcuDXZDIf5eT5TAjKA0+jWJdsE13n6JjNPaS6SoxYO1rlEbAl3oQ6nIlE0G/CqP8JdYc8kSRqPnRxqxBd/TWzehFB9oNLMI3uJtpXZ1lVki/Ns871sujXu4pwqcT3lMgUCC7BS+ZivmUMPWJMnfLZ7ChMIL1Z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTWLuCK9d3Xy1+mQlJrFY+5jVlzLSy9N89baQ8RdY78=;
 b=h31Xs4lykFMYSNs6NK6qliPkUZsfsweTMTPcJIzututmEmMkP+syv6uVOyylKFPBTbZyD8G3QDKwLxAscWGMnmYFYJ35K9yPpP082Rw8gH5H6TmJrpDTN+pYn/XMM3Qv/u4SMSeTShy9yISLMsTCJLlUdsQYvYR7sr5DsMUGfqw/Sl1Ci6m1P7jpyYZdIoRufUFQabeLf3xh+jj9UU4XEmPGd2ypGZhvpL+IeMIlWvNzHctNNZW0Bv/i7bgQal9BGfJIbUSHxTQI6t3945jZT6WyOnuTQT/UIjKwJNAllRlfLuv4/e4m/ncBwAJUppSLpXm2ba+lOoFLO313rmmYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTWLuCK9d3Xy1+mQlJrFY+5jVlzLSy9N89baQ8RdY78=;
 b=FntKyty/cVk7CuzTJGJ1kr6C4WnpesCPRD2JijYBlt97qZd/n+twqOCLIX8fK8kAAAtK0uNz3J9fgLGrcoo40kALrKtlAxWWekI5pmwjhXdGn+ylNEWLeInZHq7gNm21HFyuv5mu41beWkvqtveHzTR239gQx9z889qUJOYqpis=
Received: from BN1PR10CA0003.namprd10.prod.outlook.com (2603:10b6:408:e0::8)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:10:21 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::56) by BN1PR10CA0003.outlook.office365.com
 (2603:10b6:408:e0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:10:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:10:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu: preserve the num_links in case of reflection
Date: Tue, 9 May 2023 18:10:03 -0400
Message-ID: <20230509221003.475858-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221003.475858-1-alexander.deucher@amd.com>
References: <20230509221003.475858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: c1411deb-f17f-4e60-228b-08db50da2e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ryio0n7ckm2mcHB7vNOd/cOMzv3ej2VxvlexcJacUfX+JO19k/FPfhOwq1DFlFV/zltfruGnQdoQKSB6Va2c0sNdT6OazQb3b7Z53dmFHGEJNOrx9GffLQHfOD3tdTi0tq/OXxR/WrPW7owDN6pZSDnhay246c1qW93AKFsczcjLN4Phjvu7MVRvTBBOBNJrOWtLg9onQBBf8Bv96hmJ2fLs2xlDWo8dC6dvdr82s7HFEiRl2AOnfC4JS7BkggSn4Pog0FfhaJYz8UhpSSpFQnETMLfJ4JCyjrFRjOWmKGaYEKD4Z3X+04XUc7ETnAVPn5CQlqggBmnNMvB/vNv4ypOvvShz6nSE9Qvf7b2L1qL0UEt4sOjlm8p6OXfZmovwq8FjoLBJkivZZNG2Jht/ucjGrSxYdZNOo8l40Jw7hgp8fJhWdA6Z4ky9PHZBVqVNw/SXwnEumq3Ju+XcxhR8PquEjpftcivEhxN4/Kqf6wJlPybvKF4kW2mOHrUSVwraVV174bvaBYngLu5gFwDJlZIltYxby8hJH9HtTX2kY8SYuzmWbOfa/LPlt01dNrWTIfjty17dBkDpc5wq411NY9dq0Gr9+FHUTEMp7ou3eLWf/kRKsxzm3BWqVD4P3De8QXv8UvnjXy3CX93yCfQkIFhEAzFRxnKGOI6aS2OEAbffwL2WrBvazCKrLdwSO5GdxQz2QLEeVg225ji+kIa7eNEMmaxHMqmBmvjK4JwS2s0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(7696005)(426003)(336012)(54906003)(4326008)(6916009)(82310400005)(83380400001)(70206006)(70586007)(2616005)(47076005)(316002)(40480700001)(41300700001)(86362001)(81166007)(356005)(8676002)(36860700001)(186003)(8936002)(82740400003)(478600001)(1076003)(5660300002)(16526019)(26005)(2906002)(40460700003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:10:21.1308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1411deb-f17f-4e60-228b-08db50da2e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shiwu Zhang <shiwu.zhang@amd.com>

For topology reflection, each socket to every other socket has the
exactly same topology info as the other way around. So it is safe
to keep the reflected num_links value otherwise it will be overriden
by the link info output of GET_PEER_LINKS command.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4395c53d09d8..ea47012795e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1402,7 +1402,8 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 			topology->nodes[i].num_links = get_extended_data ?
 					topology->nodes[i].num_links +
 							link_info_output->nodes[i].num_links :
-					link_info_output->nodes[i].num_links;
+					((requires_reflection && topology->nodes[i].num_links) ? topology->nodes[i].num_links :
+					 link_info_output->nodes[i].num_links);
 
 			/* reflect the topology information for bi-directionality */
 			if (requires_reflection && topology->nodes[i].num_hops)
-- 
2.40.1

