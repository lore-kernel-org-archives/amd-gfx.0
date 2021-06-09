Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75930C48BCD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 03:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1609B6128A
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 03:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1609B6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D13F6E147;
	Wed,  9 Jun 2021 03:02:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C6B96E147
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 03:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqNNqZ/N+CJPYHD+QNfdqM+gnIQRKI97kcTzIA6Fout7bThxabKJCWBPQtb7/Z5sWZI4/VKBm/Yxug6upzKM9Ie4yi5PzVaHstdPHKpXhZ8rbdnscg2gkh2mh2iCMYjHo1d/nP63kj4rHWs1wSeB0hll0B6Xtz/b5NZ5N5Q9Jc3yM8oC36E2XLvocSHkLD7PKhMBBup1cM8I5cn9XBx/Wc7RgiwmA7Bgbt10fw0NHw4WPDUz+LILLX9aaNX+h4pQ0ZxhmbXk6UjXwHymIHzVE+ujYxlz2+veUXNoqb7z5hm9e3gd58R/zBIEen+e4R/uFjTFLtq3gFXwsGeAleeQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2I+DGu+AqZmhFN/6Lpa3PJhdRPQ22qom0WYind0Pjo=;
 b=H3kv2ynCxLXBTD2w7Di51KY+o+EsGHVwVemtdoSEFfZawlyr1zqYTUu/fog+L9y6PpEjzctdGlLJPf6xKzZMi+ReKYrABo9em36QcgVPxYjTqjK1Woy0CSYFdCyuoHvGuoeSZxfDtkyErTWgDfUZ8DlrFiTgdg4wNSlXt6V4gajgFyiRh/CG0BNTd4VLvRrutovYDaAi/c6QhP+FXaNEkaRdSKcG7OWy43XFcQd69mRDg6GCxDyj/Wz2lcpWiQagcFh6tzm5rD59kKTBKxssct410rrQFyKoJrv3bJDfx4afrc+eQ7sHOp1NZQYXF6dx4J+31FIJ6x4/kQvFX9YOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2I+DGu+AqZmhFN/6Lpa3PJhdRPQ22qom0WYind0Pjo=;
 b=wL+oY1NxZnZrOWs7KIP8S5smTzXQy6TjCflBDhe+uMGCtuiRUoWdcrDkc0AMWHZkwgKGLX8qxurmNUSOfJRTkfjAZVO11EFyrYYq4/+J/453RkfsRW8nxoHMDKxOOBNPdTZVZFfKk+sBV+eEJw4pNvOO4/Z3C9jxEiU4wrrpjbY=
Received: from BN8PR16CA0014.namprd16.prod.outlook.com (2603:10b6:408:4c::27)
 by CY4PR12MB1607.namprd12.prod.outlook.com (2603:10b6:910:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 03:02:21 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::f7) by BN8PR16CA0014.outlook.office365.com
 (2603:10b6:408:4c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 9 Jun 2021 03:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Wed, 9 Jun 2021 03:02:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 8 Jun 2021
 22:02:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 8 Jun 2021
 20:02:19 -0700
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Tue, 8 Jun 2021 22:02:16 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: reset psp ring wptr during ring_create
Date: Wed, 9 Jun 2021 11:01:45 +0800
Message-ID: <20210609030145.1215878-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aaf21fb-67aa-46ea-01de-08d92af2ff6d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1607:
X-Microsoft-Antispam-PRVS: <CY4PR12MB16070CED890A123BEAA315D6E5369@CY4PR12MB1607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UW14i4EDm77PDIMPQEA9wmL0eXVSz7H1wVYAqx+OMoiKxBrypSq76TM9dPXDt9ceuYmW41O79Pt2jIR1xs7NbGiYaGBLVcgvyZNSm5R3zi7UAsWIjk5hBs1b1+KIyleLnabP1DisHULJT/2Z3MQKjz1TXuP/sgz2UHDv90NjUnpT7Zi7nAdJchENcy7Ze1SEL0wzJqaHS5A8nZ/LPhUTRSrvP6Sq/gUC6wlEzQJvZFcLaZYyE9oLVpbHN2jieP0ABSCJ3Mu3X7C/02PkIyaoZlSxn9iZx8DhqXcM9R1PPnpcA9bt8L0UmIu56DuPi3aTujPVXBGmdsSNGQj1Wu4rDxIk9wWMWez0Ph8+Q+Csms1wvC+1MKbBwLYzENDPDEU5E/deVUTiudLB78EdT5fdX4BvPdzJXgY5xlM5QfSO6EP5FLBvEW2JnXUkKCtZ1kW0BUVrG2pYSqyKgtktR8byYevjpmJcOU5vTGAPE5bWK7lkAcOAVujJfHq17u/wGV115T/iWgGIDn8sbqNyz3x9wDdqaSb3PfYHjNghg5TOKHBnljK2wLn14eVZFJG3CJbMDD0ypHc8N62ibrk4JunDW4J1Ch4FsdSg4r2H03tsrdgpOQKkWDNxg7kc7g0Oll+2ySz1YFg3SfSjst6x+3y3Ox8rEwaLLgqI+ukc5ilFa7s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966006)(36840700001)(26005)(54906003)(316002)(4326008)(70586007)(336012)(70206006)(6916009)(2616005)(478600001)(36860700001)(2906002)(8676002)(1076003)(86362001)(82740400003)(7696005)(36756003)(426003)(356005)(5660300002)(81166007)(83380400001)(186003)(47076005)(6666004)(82310400003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 03:02:20.4972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaf21fb-67aa-46ea-01de-08d92af2ff6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1607
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
psp ring wptr is not initialized properly in ring_create,
which would lead to psp failure after several gpu reset.

[How]
Set ring_wptr to zero in psp_ring_create.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 0fd1ed918627..3e6218799a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -468,6 +468,7 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
+		ring->ring_wptr = 0;
 		ret = psp_v11_0_ring_stop(psp, ring_type);
 		if (ret) {
 			DRM_ERROR("psp_v11_0_ring_stop_sriov failed!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index 908664a5774b..be05d9cbd41e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -231,6 +231,7 @@ static int psp_v3_1_ring_create(struct psp_context *psp,
 	psp_v3_1_reroute_ih(psp);
 
 	if (amdgpu_sriov_vf(adev)) {
+		ring->ring_wptr = 0;
 		ret = psp_v3_1_ring_stop(psp, ring_type);
 		if (ret) {
 			DRM_ERROR("psp_v3_1_ring_stop_sriov failed!\n");
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
