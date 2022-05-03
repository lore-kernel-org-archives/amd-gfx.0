Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D83C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A22510F382;
	Tue,  3 May 2022 20:29:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD99D10F37B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lp72HUpSNJKxPtk6qvvMd528ibV8FCpcxjscEZgDEVq5GcgVi7lMFnFzBSpvbYCo1RsEInqE3jNooqPrJy8iSrvAmJ3bWlUBpFua+da3cD0ENPDPHwyns3MBzk1Uugnnqz+PkZTBVQSH2xhcszd/U6wnLFKAFOcBdVtLaUrMyO8tnTLZ7fEaMxeHoDfAVP4QnafdC0Aw2oiYdTYwg1gXEJ5dyVgrstOSOutZWdNFhu/lBsIrOBksSgrEPioPYUV84TLRbQnf0hvmHDd1FSi04r9GoQaRhsPX0F/ZTSysVYPZz4h5qTaca6vQobS8XWrcfBTmyedND8+OxwpHAM3RRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cxe6scLixWQZXMw+7WedZ72JzohfgV3su6EhtBTU34c=;
 b=Il5xCw1VCPkpcZfq/MPBuJDdcifAP3AWXpEPeMNH9aVKTysSDyDiqXSpbBZ0GFzWZ99yQh01XeVV8DdhcAXuXE/JkXTr3n3m2ZUK4IhqH+5N0j/fBJOWtZkpVCuBeQ+35zscC3zl6jG6PV9OrIMFDlCQckx3mMceI5zRsD4DGJbP5QmGLS6TcYlBRMGnFLzTwRxDEe6hy4uuKbdX3Ic1W3Q3S4E7vpoKSyGSDCxF2YvNibPuFem80uzFSyx6YGaMPQulA3N76kwNNS0NArEPgu/U8cIFy6nVJRZDzSj+IEipk5QoFGEceB7O7qPlmlY+XSae0uwG5Utf5ymE4U9aFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cxe6scLixWQZXMw+7WedZ72JzohfgV3su6EhtBTU34c=;
 b=NpbLNC93l8KR0nRXelvvy60Jrq8fnO/uQSBoUdV80KO6hyaolzzNW9I8q6baAJ0shE88QfEYuiVlmaXzvp3ibxIIvHssGhQjm+OVhJoetT7y4sx4vkcmxnJPJQPdh3nT/0khNIpmVvJIsKZwpHd4JFshbfkQourAQ+GxDRvmgu4=
Received: from DM6PR13CA0009.namprd13.prod.outlook.com (2603:10b6:5:bc::22) by
 DM5PR1201MB2552.namprd12.prod.outlook.com (2603:10b6:3:e3::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Tue, 3 May 2022 20:29:34 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::93) by DM6PR13CA0009.outlook.office365.com
 (2603:10b6:5:bc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.7 via Frontend
 Transport; Tue, 3 May 2022 20:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add mes 11 firmware for mes 11.0.2
Date: Tue, 3 May 2022 16:29:04 -0400
Message-ID: <20220503202912.1211009-17-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: aa33e546-406d-4b5c-adbc-08da2d43a310
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2552:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2552D800E1ED9F19CE7C054EF7C09@DM5PR1201MB2552.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+dfksdAarsjXz7rQfS1far6gCdgrW0lL7UOwMt54CltKIkmZPws+EVTmjoXQb2me30OrU35AIFb5ADrNyfzMJB89GeZ2onqX0tkqwqXSTPi+m9NMk1ALstvzHa/m8Ln7KJhy+SSv09gnEJqgIKte0o7vibmbrNN3u8oz2FounVH/temWwrPXRwflqqMQTkA0cs5vO2VnilkjLL9k4GNyx4HLg7DFb2Vg3FM9xlpNy+rAWOiP+KsU5j/Vw8yy6r1iKoRVYOjl+kufzNKhAn7CUoINwj+MyjjfxJeXvfj188qTcg+uqNAVYM+e5l44C1W2IYYTCZrWBRBpONMtIueBYcF2/rV1OUtmDZr5RlufzM3anaiFiDQwTdalqPxLGLihUTCOWmdLjgIbBlj/TSSqGDLKm2qt4jCFyxW2lgPFHBoctR93C4NGZf/FuKgAoQx1llurUdADt3g0kXxN1l579GZAaEuSOq+ijnxcUC80QZIJOxam5t9SwJCDM/FB25IYx59qylZI8aKsXo0t2OYJL5o1/ie31pMzgGnKKSvsBK4raHCMhmZ8dkOKWl8JbMS/B/kvfm4ugeyMaLaQx6r2HcJHeydKLPQgALa74ltod95eqyDkX9OQ1cR61zoreIxwepHmCee0Lp3PydhmWC1PeK2xgpbIybFIfCn67lm1USWdndzfdpYfLbkbGNJAIXZ6UdGhFRqZtiqxqrC2VuYLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(70206006)(70586007)(4326008)(316002)(5660300002)(8936002)(54906003)(6916009)(508600001)(36756003)(82310400005)(2906002)(4744005)(86362001)(26005)(36860700001)(7696005)(6666004)(1076003)(47076005)(336012)(40460700003)(2616005)(16526019)(186003)(426003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:34.7247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa33e546-406d-4b5c-adbc-08da2d43a310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2552
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

Define firmware for MES 11.0.2.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 12e048c83b0c..8af935930f89 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -34,6 +34,8 @@
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
 
 static int mes_v11_0_hw_fini(void *handle);
 static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
-- 
2.35.1

