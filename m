Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9999CCA47B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DAD12A8DF;
	Thu, 30 Jun 2022 19:14:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7694912A698
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnRMrTf6TorV3uwaX1R9dr/lTP1TRSOfFA8prFeRsB4AgRn0krOoo1KqjtDNAJ2qQUx8hHuel/MbOdxlYAuEFNxyBOtNPKe/KUgeIE3Smrywy+3WQ6Q98eMSvb7D7jfuB5yF6gp2BkN+yaNMpsoWapNfk9QPozjuxWoNRXUXOtRT/IeJgh/OXe3q2Ja7sXct1NiAToedTThtdmPAtgvk4K7vVtcBCGCHC2i68WvabN6LbymL0eBYoceNZTyyWAmo2HaYYm2QgZrXohp6vFAKSxBK1TTLdIqJq6jhPU5wzYdWFBzev1ZQx2RteGaXLa7mmHNw29cG3l/bYkbfTmOC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx4dbDwVB3pBu82BE6tBtNUHwsMI6KTUgxMFErEMRWk=;
 b=gyZX13vjUON+bXUo3S+ZRWYybfx/L5x6EEwhU/SsRYpSvyfCFauH1eUvfgG2VWz1ou1csxnR7YYZ/jOr1lwuHp/5IInq0xFgOB2SqQdKLGH0fbp19PJI67Iubgp0G5qCm3NJEHZVjJ5eCeSUBIYEm9ql6rE5yMQzYB2kf8iTVFsol5Ua/teJ9IGAvZKCb12lIw5v269kK9hSbNhpnQzrJ+Ia4ojYgRDqYXM0rLsG89sfSpUBskuGxmox2eyAo92K+7UALjaT3+yvKeC2Em9/xJwHqcUsL3muJNH2cYXTFbzJ+RUIzggv15i87KiJRwfqKr+kw7UgKo5dOBj8MMPbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx4dbDwVB3pBu82BE6tBtNUHwsMI6KTUgxMFErEMRWk=;
 b=gA2FgzQz1GBq6Hjh/7G6U7QGRpQgLFucS5G/avaQfrLJEB7d0zYd0csALrUotFRjCWRD5CCx6NoFAEmw+JgkTyuZExhOWgZyTBmZrOU5oEOMl8XR2o3Qbi1blhlTXUcYK3MU62Hy6vj/dB6cGxR9XmgYDwFHAAU6rdbpL+6rlzg=
Received: from BN9PR03CA0441.namprd03.prod.outlook.com (2603:10b6:408:113::26)
 by BL0PR12MB5691.namprd12.prod.outlook.com (2603:10b6:208:8f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 19:14:21 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::4c) by BN9PR03CA0441.outlook.office365.com
 (2603:10b6:408:113::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.17 via Frontend Transport; Thu, 30 Jun 2022 19:14:21 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:20 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/40] drm/amd/display: Fix null timing generator resource
Date: Thu, 30 Jun 2022 15:13:14 -0400
Message-ID: <20220630191322.909650-33-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6341109-a333-4a37-a4d7-08da5accbd0b
X-MS-TrafficTypeDiagnostic: BL0PR12MB5691:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQPAgns3/u0q4KJG2rfkMF58Z2xDSL0LwgmN82JkggOhyOqM5rd6rQwfHxAXvYSfioL72v08r8nW0kT8mEbmXHPBnBENxnFKFkTnVgzk45nl6VY4ItU4k99JMsY2RPQFvLHwhyuOaMgAjkpn9/O3RhzklYfTNK4wW5O9LD94J1aTzsmcIYpMY9QOQZE/Q5LKx5cRRrmQJnFvfjInIToMOmsJ7umZEVo9DvWIXXn3LSfatL7DtDxpdC/ZNF9NwC+vd44Dxyh8ssmlsNtG/iKpeW7hyYROJGnYMkqcAO8vprHKNmqF/pqI//HwetEI1if/kuZL02a8Kx4FZtVGrrn6IPssQ8Gusrs8W/u4pllhYhFnaB4cZQTF2lIeRtXcY9gKJQPOYe+YL+GdQtT5arXtSeNKaFqjDE0KNElZyeaMLnWSgV6mHv2mg+V2JVZW/kzLJvFk7gTXjOHqMCcJEitBpuxLgm9smfhafmfk3FL23X/RMn8AeQYaelwz4mkTW/yvC9SnPlLdYYUBe1mbtbvO72RnFo8fhbEYwSXY14HyxQX8NUNkaBgwXDUdVJiCBCHmaIMmLGs5eEJLW3vW/PlA3cE+81uZ8rRBBlXHv31dYOudSRG2jO47LeRKDRl6b7Aks7TasdZ2MrD7OH0XqLdh+aIN6wPw4Sesw1cdCEzjFhz2dPP2GPyEgBY/YO2AczMHSjA95g+xNLd1En5XqTbfQHxt/GovVOhGpaeZN+vR/Ahvmmm03OvgDCdu+wJqpPIFLppwdaTTriq8TXYgxyGBRErET8k7hmRmo2f1XRazU+K5MhKbNbGlDmjC39pDDX/gbh/XivVUgtPpGdpqKaybg5xIoXOapK/ByUDKZt838BY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(36840700001)(40470700004)(4326008)(40460700003)(81166007)(70206006)(2616005)(86362001)(7696005)(40480700001)(8676002)(70586007)(426003)(8936002)(26005)(82740400003)(356005)(336012)(186003)(16526019)(478600001)(47076005)(1076003)(316002)(2906002)(36860700001)(82310400005)(6916009)(54906003)(5660300002)(6666004)(41300700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:21.7206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6341109-a333-4a37-a4d7-08da5accbd0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5691
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, Eric Bernstein <eric.bernstein@amd.com>,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
For some customer blending transition cases, the
available pipe for second stream is a pipe index that is
greater than the number of timing generators, which
can cause a problem in acquire_first_free_pipe since it
assumes same index for pipe and timing generator

[How]
Added logic to use last timing generator index
if the pipe index is greater than number of timing generators.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 3d45f6cae1f7..f7b47bf3ee59 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1885,6 +1885,12 @@ static int acquire_first_free_pipe(
 				pipe_ctx->plane_res.mpcc_inst = pool->dpps[i]->inst;
 			pipe_ctx->pipe_idx = i;
 
+			if (i >= pool->timing_generator_count) {
+				int tg_inst = pool->timing_generator_count - 1;
+
+				pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
+				pipe_ctx->stream_res.opp = pool->opps[tg_inst];
+			}
 
 			pipe_ctx->stream = stream;
 			return i;
-- 
2.25.1

