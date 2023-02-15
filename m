Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663F7C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 05:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC08110E114;
	Wed, 15 Feb 2023 05:26:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E1910E114
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 05:26:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1BTGXJ22/Q2Khu0Zc5JhMwPD3pvw9XzDyRsfUrGzntEMMEU4SArdtDPtcRAbt4vjH8UUoXVYsif4RBrSQ8lOo/G0tZYDJiyLXOUaFIfgYQl5L/X1lPUYzcjhYspHVd+El7q/6VH86B3Mt5XBMYgX5kVJ4+6kEKanfGr6Zv567xu8uN8uxiKspgDxyww3thy0N9zp4AMVKAeVsI/oRxbYRcS5NS250zlrJbzK7diA9nqPvxrObmEkEtBHVGewY6IkelLfLPV2F/87StFYv2L60YwX3XKOjNvVhqzQhbKTW5MdyVYVyYAjUmSi1Y19y82vB6v3x8UDHPhaISDvyZkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkzBlbCOcqQfQFhq/4L+TdG2vuN43Gkm26VYWLiMqSQ=;
 b=B9jU7pSe/QhQRGT/pThEAXZcbUHaK3kgyhKB2kue6zAoBBQ9A0JBznaWMqOHyO7TaHSgTfHaUdU+3shacU37Ef90gjOxN4npmouRQPSZMTLlpHQ704QxHj1dmyAyC2IqseCyvkrejuyhWJyTkEn7wHuZK1ktX0yfdf7CNCQWZE1FcKYo/i0eVCYUNo6l8Uafm3TlXxhX/L4NGujamHuZTJm/NBV9/hMzqprSRRv0Vixjgg6MvTmxb+56K3vzVX7RjS7oo9dkSMCDj7s6PmgaaDOzJV8lPuy6IwGB144vjN5h/L65dYi2ooqH9toEO69IbSi2kf9oWJoVsqHQwJdzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkzBlbCOcqQfQFhq/4L+TdG2vuN43Gkm26VYWLiMqSQ=;
 b=pgENugtEXCx7npmtyRqRi05ehToPjkvG7k91ItJZtz/7eDdxNnQRFA0WWS/m31KvozIM2/BbGGAj3yEoSwIToCJgMJkYKYUdBX8ybBjDBH+mIuicDEBrhTGhJB1byobPuVWkN9bJ20dV4dMm0uXrYXzJEoV+XFwp3K9KwyQbvF0=
Received: from DS7PR05CA0037.namprd05.prod.outlook.com (2603:10b6:8:2f::24) by
 PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 05:26:50 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::c2) by DS7PR05CA0037.outlook.office365.com
 (2603:10b6:8:2f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10 via Frontend
 Transport; Wed, 15 Feb 2023 05:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 05:26:49 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 23:26:45 -0600
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove TOPDOWN flags when allocating VRAM in
 large bar system
Date: Wed, 15 Feb 2023 13:25:48 +0800
Message-ID: <20230215052548.2995968-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c6b689-953e-40b8-4eec-08db0f153d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uB+1bmEApCUXw7m190ejzZ6zjF/1xRuKy7gpInbPlA7QvrGbD28fEF9cW1ZgREFFVorPdNc14p2rlArQrJJBbhzSIV0XAx58ekpi10MT9xWZ3JnvX+rnCXxE31sit9Ra8Es66ix7SiGjsNuhtDI2aVQMQoaqN9Mq6rM4MJ+PMpMpMCLhGKIxTNFATSRHAEgC3wH4KanDI/0rZ4x94ugZlsoTEzHJHz5fqSUwm43elGNXXHK9fAF6hqyA6XJHE0iIabi9MwKYfKvSOnOnLy1VVvdCf0jEgNekliuXoJoZ66pZ0Dljb2edXcxmBCM0fmMrZA+dyoBaw4C5SN/0OuEylWJOur9+QznB1E3nZZFWu9l3NURq78HgGzGo0xplA2cNrEFZVpNatZkOU39pSssxKM+R1yrMWHVTm7Cz52a1Mye8g0+cgsy8hckC5UiRTbEAdiYcw8IyNTkv3DKUq13RJBJaRRDPYKL8KBNf+PrNiNOBn5N6Yb2Yvx2+S9vJpjPNoU8u8oHHcAoIuUib1ERrxynHmNQEW/LBCcOKfSI3S4SPDB6SBK0OjSwWAJ5JZv/J4m9lnFyJUO6/la+0SYnDCdXh9x/2svlNpSA6LVcxGC3IFeMV5KwaghlJySFQ7Wl2yQ3A3Gbav9kpFyiQIyAznaecOhaJ3EkpBb+qRql4Qhwr17KFjG94whujVN/4LtMQ8Iw5gVqheTU5mKGbGf7vnNW8B6A2IwEqRCg+zuPRZ6Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(44832011)(4744005)(2906002)(5660300002)(86362001)(41300700001)(82740400003)(316002)(70206006)(8676002)(6916009)(70586007)(8936002)(36860700001)(83380400001)(36756003)(54906003)(82310400005)(81166007)(478600001)(356005)(7696005)(47076005)(426003)(336012)(26005)(186003)(1076003)(40480700001)(2616005)(4326008)(40460700003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 05:26:49.8045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c6b689-953e-40b8-4eec-08db0f153d43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
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
Cc: aaron.liu@amd.com, Shane Xiao <shane.xiao@amd.com>,
 christian.koenig@amd.com, arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since VRAM manager is changed from drm mm to drm buddy, the
TOP_DOWN flag should not be set by default in the large bar system.
Removing this flag helps improve drm buddy allactor efficiency and
reduce the risk of splitting higher order block into lower order.

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2d237f3d3a2e..1c3e647400bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -139,7 +139,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 
 		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
 			places[c].lpfn = visible_pfn;
-		else
+		else if (adev->gmc.real_vram_size != adev->gmc.visible_vram_size)
 			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
 
 		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
-- 
2.25.1

