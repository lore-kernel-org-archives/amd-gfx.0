Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B4EC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB32C10ED52;
	Tue,  3 May 2022 20:29:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1F810F0B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xjs+EnzcVeEGAlfO0X9Ev9o+F2ayEb4dHRsVQ4ovpn//f81iZbzcZ89A/as52ImolnjVU8ubQsyLlPC6i7xf8WlP+VGAHv6hPS7SAcgWI3tuvDPjy9mjpgFbbLgwJM6ZUETy/YwHoN/3ibMOkFNH8VLk37Rc7jRaqXSd27fOnclHRh0HQyILYBWyJiPmIlEeJDZKL8hqzTR3wjdpafFmAG6ISw6CCRb1lT4L3iH3gCg4DznzPsrxp26/juerh7ATRRR5qLEnyQAHSA0Bh628clKe+Z9qbGAKgsfbvvaRBtlRCCiImWCu9oXC4KPj4A4onTG6z5CJORnIg7OV/M8+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnfgwDFvaMEPUEQmTs9bZ3sJeAJlKAk4OazarzrC0JA=;
 b=ZvXFI6z1fOOl5vRX8lFwLPCQeUVv1xQuAm2rTtrEdqEV9coWzLxKvjTrViEjg9uq7eOZEdlRhekJk2pnCBsl8tL+2P+ZoCG4DlQGrSnQZjkX/XL0iUCWVUN1QVOdZ8NA+KiP0w4Q1cv3MBCEfkCg5Dv6PAH4DNoUTofNl0bg6I9gFNo/cQP0PXoxx8rL9tnywvQVjLbiiTPe7GfX5N8QKDaNNyFkEWxO8KYidTE/VugF55gHHDVAo5EoZ1qTIvBX2XlmiJS6zRpsd7TbQhQYIoHc281Z6dQFSXcUQPoVl6FrPez4iMRIZOzlAFSoMTw0JZZ7EqsaT2CbdbTnhxYZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnfgwDFvaMEPUEQmTs9bZ3sJeAJlKAk4OazarzrC0JA=;
 b=idodiPYoLxwfb9P3S4HPVfkjBqNsdWq9JMSSw5RkHm9mqKA7lVAl6jnlAZv7zIpV+JuD86TpLDvwImVweLWmRdYs0DiJnhStNKkwC0eucth1CcZYF6vKgBKnHTQToyplODO3AZlHeMYKnAHlXS3r8XkeJflIJJDE1Z5Po4BSkco=
Received: from DM6PR13CA0018.namprd13.prod.outlook.com (2603:10b6:5:bc::31) by
 MWHPR12MB1136.namprd12.prod.outlook.com (2603:10b6:300:f::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.20; Tue, 3 May 2022 20:29:30 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::f) by DM6PR13CA0018.outlook.office365.com
 (2603:10b6:5:bc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.6 via Frontend
 Transport; Tue, 3 May 2022 20:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: enable VCN CG for VCN4_0_4
Date: Tue, 3 May 2022 16:28:56 -0400
Message-ID: <20220503202912.1211009-9-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 386e1568-c18e-4967-5ca9-08da2d43a070
X-MS-TrafficTypeDiagnostic: MWHPR12MB1136:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB11361D97904E6602739796ABF7C09@MWHPR12MB1136.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PWvTuvWZx0FSK6NC7dxpMKwGWRT3jq+s+xZaowP9HlASrNEpme86ordmDJ3S/m3xuLnbDYHC/jMLg0HDSt2axPerLtoj7Bx6fw3s7cFQXTKYVf2IHN79ru6A9WaQHQ3y/yXgUhizfdRG76+0bK8QJkin7Aig07rR+uDB8GmWM76DHIgimagDRL3cSCSRUfEIvu3iv+oMwQH2VXeIrOq1D++oBoa30uDbRQ+aYRN5MFdfaMcsPoPhCcaW29SM5NMPdg3k1/fQM1TZQgk0Kc+0KMnB87k3v7b9/4ytCNZ94bdbl49207DkwEsD8xipldO6EQiTkkStDtXCTC+LJWI612CizhXeuxOg/UNHMvBtBueOlciUkfAIhGoEn8LSjICKXvwoxW2kE14U9UZpw6x24oRwNaZNDt4a3ih/bSU9AAj5iH1c3qpz9INutgBg7oVoO62oc6BA/hpPpfIHY5PLKNjhv7LrCm8OzvvsNktrFmrM8ihU1CyEpaWaa5LN3he3QW7+9eTfHxfBn5cwRCMQFgwyVGRholeZRrKkp1CyZq0Pw/3ZM105N6wKfa5vnoaRBfwP6etRcAfH9QtSiNb2GgCCqaJI8oscmfS/ksbc+wYRxiYce5ME2T1IA1nCPf3wylmCY9mlylaqLSeVzr1VM9DszualkYnwOtHCkcozFCo7KaugGBoQFq+ol/M6hLUL9pGUfQJP+BmvSMUhigPtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6916009)(2616005)(86362001)(316002)(1076003)(47076005)(426003)(54906003)(336012)(186003)(36860700001)(16526019)(508600001)(7696005)(26005)(8936002)(82310400005)(6666004)(4326008)(8676002)(36756003)(40460700003)(2906002)(4744005)(81166007)(5660300002)(356005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:30.3186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 386e1568-c18e-4967-5ca9-08da2d43a070
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1136
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable VCN CG for VCN4_0_4.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index a75860e6c3b4..d2ea7db18141 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -549,6 +549,7 @@ static int soc21_common_early_init(void *handle)
 		break;
 	case IP_VERSION(11, 0, 2):
 		adev->cg_flags =
+			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
 			AMD_PG_SUPPORT_JPEG;
-- 
2.35.1

