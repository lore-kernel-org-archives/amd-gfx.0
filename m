Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47633C32793
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 06:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A826B10E64E;
	Wed, 24 Aug 2022 06:41:21 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5846610F291
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Aug 2022 06:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pm7nxkRiZTCuuuid2X/IQ8P8i0U7d7xTZeer82o8M8jY1B2llMZWxcPNO4lotjMRZohXgL2Rm7dFIqlwhQ5xXD17uMsylnidIscMGG17a5Tls6LnfOXl3/zaiNDg14OpTFEGZadPGRfFNMzhKIY4DdvyqJ+1q3ypp12+JjsjijoJWcAQS1VpEtuIMC9mGE3/PcVXM1TGG37qUZHSdehCFjWNHSkFxhmwUJqKremsSpsfik3fIKIvUw+3GePrd9ki9h9i33+mJrGDZ2Xl/lrZYTpx3rQ0r9KOqk/4ZhfyOqaaH3pYWLivexrxMMMjMz6DW+OUuWeGxERpCYpCUuynRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=almNryvPtsmieT6A6nf+4pFxjIp/dfPN+zz6hDdQ3o8=;
 b=QYvsAIHkFwXZpO2VVp1Gg8pmhSw9F0OXTjbLTauRYcy6u0K/I1GGxrolQY5tJIHHQvuySKwkGs8kplxrrIL68msxJipupLutnulVMsGxhYDhgtVmdEiMUrTkGv9oXAmyA+moCYSG3XkV/oDKZMd8h2bbgciV/1m+wYHfxuj9pnvlEJKnNIKPRpo8B61eIDT+J4INR3eeC/XMzzZ5oMpdPK5QBnhlb7qCG+k0JRlaUCRxCp1UmAtNFheT8Cb3dqVq6uzIXaUSxA5908fEbIBbU3/wa/WvBxSPje0LzcyHHCLPdJgakV7tUAwV+CG4VD4dl9Bh2TtTbdCNP5A94TK3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=almNryvPtsmieT6A6nf+4pFxjIp/dfPN+zz6hDdQ3o8=;
 b=KZQ5/PEAQx+u8fGmAnBGikfVsvZaIAoMuhiLV3e024l4uun3o9+cZ0q9+os9BbVDQD0NRS/j55sBfNWk0P/7IaaVn4Agpe1frU6jEMWFuneT7TOKND7nLKHQtfAas4EWC/Cwh4qIVLOvT+FmLL+rmU2AE/lddYs7h5DMCdX7Xh4=
Received: from SJ0PR13CA0147.namprd13.prod.outlook.com (2603:10b6:a03:2c6::32)
 by BYAPR12MB3320.namprd12.prod.outlook.com (2603:10b6:a03:d7::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 06:40:54 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::68) by SJ0PR13CA0147.outlook.office365.com
 (2603:10b6:a03:2c6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Wed, 24 Aug 2022 06:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.13 via Frontend Transport; Wed, 24 Aug 2022 06:40:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 24 Aug
 2022 01:40:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 24 Aug
 2022 01:40:51 -0500
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 24 Aug 2022 01:40:50 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
Date: Wed, 24 Aug 2022 14:40:48 +0800
Message-ID: <20220824064048.2581639-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ba31675-7d43-4210-1ace-08da859b977d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3320:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8ht7WOI2dIe+ys1cuVsIF1tojQLCxGF+gm8gykrbC1L8c3b9UF2zW47ila8hkhvtbcf888jpjbxA+TghX1+ZZ8KOrZNR6VVX2yNU8S2JQqfvFFrjBbZQuUDT28VM4CUSbxRqyhq24xgFpMD3Yy1lDBUa0pT5c34DlzeYtn+Nv8ApM3FJrMcW9/1VSNZGqfFlPbHBufr2KSm4J5a/ZojcCwK2YokVn4fMp9lXvhsOohiTGNB8d31q+/5L/mKbQDhZ2AoVcWIkctNSpzBZ1Znw5SxoRiiHVBTST2Uqz02UvpD8YCw7bwaG4Vby9Fm+K/UTMX8BaJ7L8HuQMyAufYX9dYlxeVyJktbZmxTFUIOKs0YcFr33RRTdZUJ5J9dg8kzrgkxJIwz6zFUTHG2Rh7hb9nMVEmefA6pIFbkS+dFCz17bGMd7vet19qZhyeOQ1HNZtjs9Ik4S+FTRkepQY9KoDjPhgm2rY4wlbSZZITKn6OIzmwR45LE5W8gcAxr2czZLvo6kfTd5R8qg51zIxIlmCutrOr0MgjXRGKVxHiPo1ry6sF5Kit8bW+sLN3imHfWwS5Czg6dxpRUx09RQNKsy82um9rcHzEp1HA5Vk+9L1P3MbYaRnXrtmCSpX1Sz1+CNt+Za33aeM2KBzYCgM2ssSxSlqGzZ6YMldn2+dNV4yUciY1Z6IuTQw2dcCIoY1Df0g3GVnb3QmHDTCgf1VtxqCrfi0c5mJpUzyd845J+JEmyfYWVWys7VyiFc3t2xNqZhG4QJyT61PMd9IspT7msGxMb9yISvvrNvnz1EM1OpayGX/igYRyUptT4dJoFMLQq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(40470700004)(46966006)(36840700001)(41300700001)(54906003)(6916009)(81166007)(336012)(40460700003)(186003)(82740400003)(83380400001)(26005)(316002)(36756003)(7696005)(478600001)(86362001)(40480700001)(82310400005)(8676002)(5660300002)(4326008)(70206006)(70586007)(2616005)(1076003)(356005)(2906002)(36860700001)(426003)(47076005)(4744005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 06:40:53.1361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba31675-7d43-4210-1ace-08da859b977d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3320
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
Cc: Alexander.Deucher@amd.com, Yifan1.Zhang@amd.com,
 Prike Liang <Prike.Liang@amd.com>, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the isa version for handling KFD test.

Fixes: 7c4f4f197e0c ("drm/amdkfd: Add GC 10.3.6 and 10.3.7 KFD definitions")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index fdad1415f8bd..5ebbeac61379 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -388,7 +388,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 				f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 7):
-			gfx_target_version = 100307;
+			gfx_target_version = 100306;
 			if (!vf)
 				f2g = &gfx_v10_3_kfd2kgd;
 			break;
-- 
2.25.1

