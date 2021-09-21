Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83B1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E7B61168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 73E7B61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D186EA37;
	Tue, 21 Sep 2021 18:07:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD086EA33
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPfBRTltDE3VpgTY8Arv2qCGGpA55kCzijTEu5WO6J4H+FOLLz5BDqau72IxmKxYlS2H3qAZJsW7s0yY1jzM2tVI5F9E9Ac2AI6uWXWjTFSlQ7IokvTRNDKozjZXXoji1tiBVyN0ABMIG59Ij/RCAcTKTesujgUoLR0vc+QaqxGzKtpCnRoIDkL1SMb592jTg+Gs6zL3rB3t5YqIxSWIUyQRrB8RMAeKIuCehTF4Bsb6PcTqSZZ5xP9TYdBNDRCMagjsf2Or/wb3rYBKd1+WmoGxLLUu9gL1kT4hRw7dqCSoXsT8CRXJSgiPbUo1tmH17mb4CkJgr8mYMgvSXtSCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=AZeSEI40Zq59CMM4DNJB1/j9lqhozOnZHtTU1T5I/tI=;
 b=WNphSbcW2GBHydaxTZj5WkU1KRoubgAJm/z4CAXCU4JMtk860iKYwLOCpeZ+kfXgLqFtlVeOnAekM4uOlaGwHiVcOCLN+PjLcbqEUGNl9fyEYA43a5RWf25k3jrNZwctRIC4EHEovG/Mo9A7EP02THNMIZ2Di7ZyL4K5D43lOqDXPysJiygt6fO3sigH4Yor3hxZyEoiT3QoZnXZeqZ85/0NpzOBNpunEauyOoAgT/VzbATfinM6bkUA1RCp2JL24sH0j3VHwg+J+//+nyXa1sY+a9/LGQjYrwgvP3I3gLH4ULkXYnk+u6hMN48vfN1/QZaNeFDFlrtWSNMrijXWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZeSEI40Zq59CMM4DNJB1/j9lqhozOnZHtTU1T5I/tI=;
 b=At7zM8oyj9+jgfaTi6d2snKpr8znML8N5pcjVJ95zsvFQLcBOKJwmbb7yBlruXmadKenIubdw31vpciJ9EdlJYtYN0vzRDGsVzuhRslfnOj83z7LW+ZZh40kd9+mcZBvlzlgxV/+wnsFk6/tpGrPKceOg98KM2iqDhPExmzplGo=
Received: from DM5PR11CA0010.namprd11.prod.outlook.com (2603:10b6:3:115::20)
 by CH2PR12MB3735.namprd12.prod.outlook.com (2603:10b6:610:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Tue, 21 Sep
 2021 18:07:48 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::38) by DM5PR11CA0010.outlook.office365.com
 (2603:10b6:3:115::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/66] drm/amdgpu: Use IP discovery to drive setting IP blocks
 by default
Date: Tue, 21 Sep 2021 14:06:33 -0400
Message-ID: <20210921180725.1985552-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 216528a9-ff07-43bd-1298-08d97d2ab873
X-MS-TrafficTypeDiagnostic: CH2PR12MB3735:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3735571C47E7BDDEB21099E2F7A19@CH2PR12MB3735.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BB5PLHYHE2pZ8kwZ9OmWKvkWQp22TYxD0X+hnl7bs3iDGLmcv/Uvmpsp2m9Hu0fSrrEbK/HXC7EcWRY8xw2iqEHk9L2Eso+3i8Ep61zg+jHXwOFOSd9adCFYh6bxxqwQFCiswuacZs/baahGuL4ZaFT2xC47txAO564Wby+A2fiClLIu2DZKYi0gQQGnkwDiUnG3iGRi9tET+lcP1C9hzUQdOWWfZDHbav/R9oPDOtcIie9De+8Z9A3F+Tr4frI+ecwaoGeoRwgbsZgbYOv2hKK62wdRcqypow804IgWz8nIyPQzADgHyICuNXSpx8DQRFxB7ATTZzd36t9tRI3LdEb7NJDOst47/QWG5QIm4NIkrQ5QcLOnQJ8TwXft0r5zZSykr1U/kG9HJ7rg77s5UhxyJvEOClu44RSAS0bIH3zsWMr3e5kb9Yj2rSNrUx3U8ruJutr6Vm9u5B7r/NnrfhWC1tuLyz+DRSeDi/1ngroxt5RXdPOCn5vnU5/WOvVeDoT2OeUkKWlRnp0XGWxdT+LR2xK8KKkYEtLjdp9l30hKKqc5hQK36WWsDGUY12K1N936E3+T8WAgRRNz6CeWucASZAyDi0OPpmbx4AVO3oQKQmobWcltqYsOjWkwp3RF4iFp7NLj/i6F6CrfDPvIfbR61ReNV1fuPlQWtHAMkymeMMtAAjwwvqDQCdFG9hYNyrR3OtL7Z/ZONIM2PQwhZXEDrJRNBiDzgrGNboaua1k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4744005)(16526019)(508600001)(426003)(2906002)(336012)(2616005)(86362001)(4326008)(6666004)(47076005)(82310400003)(26005)(186003)(7696005)(70206006)(70586007)(6916009)(36860700001)(316002)(1076003)(8676002)(8936002)(83380400001)(5660300002)(356005)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:48.5483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 216528a9-ff07-43bd-1298-08d97d2ab873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3735
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drive the asic setup from the IP discovery table rather than
hardcoded settings based on asic type.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 38d3a7e6474a..782ebd5d2239 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2164,8 +2164,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			return r;
 		break;
 	default:
-		/* FIXME: not supported yet */
-		return -EINVAL;
+		r = amdgpu_discovery_set_ip_blocks(adev);
+		if (r)
+			return r;
+		break;
 	}
 
 	amdgpu_amdkfd_device_probe(adev);
-- 
2.31.1

