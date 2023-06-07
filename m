Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55299C7EE29
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 07:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F3B10E42E;
	Wed,  7 Jun 2023 07:25:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47B510E42E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 07:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzIptJbh+QKivdT9OfItQ1sUkVOfwTpsg45TfFeC8InYDT8gyoY4CAsEklHOTibFZqg/3aj/s4XzorD7o5DouESsGoEHyTNFmh6YkmkKovTA1fo0bcoY9agUODzEAcnYWCrPJvHTxQ1r+m2m7iHuphBI+Z1/ctKgOqcXQL882rfoMeES68xMbVY+H6j2/ErIh6sV5xPXaRxptriMnjUENRwQPfTOPYv7QMJjIjnH9y2TPO+bfP6E8gCdyGlsFBtDaWbmBkswAx/LSwYX54qLhMvO1AmENW4O06WQZTERCR+vdPP6N8q1aFEvEVY+CrSutVwW+lZqS14+/uIRFj2Fcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gICT0YGxwleEQJxghTFDY/Eb/6rCTfi8UL3hEah9M3Y=;
 b=Yj4tGt3/oo4lHROI3BJWQ0SSnoCQoPriVKUhsZVDZ+NrIz4V00P28o1klwz+fXJGZzDcdmvhWvAqdeEdp6VXciudTLUJ+bEirQCvwrE+SSd/wVUsCIIYnPD6bEd2Ys/dx2ggyduHEZIIiif+eOQaHSkgkT+gZOt5tPMvA7QseZCmgTuHbiGhwhqPMukorQRFTojIwJ7M59x+yFo0IaUfMfZ8vfl6aQYP+TLwym6S7ub+NS7Y5KJvwe4sqkcmseT94dZ4hFksmnkHHyY5Nt3oiuIs6UukTasMo4X9E9Rnyixh0oW5ZnhR7lvxMbysLJB6ZZhysJIg6sJTKkzmY3ZczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gICT0YGxwleEQJxghTFDY/Eb/6rCTfi8UL3hEah9M3Y=;
 b=MYzMk36oaWLE6Xk7HHxiWcBErupdlmd16ayKFMmqX/fjjv4DRYG39BYyT5S/yADtc12tsv2vN3UmnJbip9Bw8M1hk55Wd75dnNRObxcvyN0QJOAGjs5RBFfVKnPAbZ96efQD8yUYuWUBnpZbZ6oO4LCPky0gEoQfzpUI2XydCR0=
Received: from DS7PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:3b5::28)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 07:25:10 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::f4) by DS7PR03CA0053.outlook.office365.com
 (2603:10b6:5:3b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.34 via Frontend
 Transport; Wed, 7 Jun 2023 07:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 07:25:09 +0000
Received: from ruiliji2-lsy-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 02:25:06 -0500
From: "Ji, Ruili" <ruili.ji@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: to fix cwsr hang issue
Date: Wed, 7 Jun 2023 15:24:51 +0800
Message-ID: <20230607072451.3754319-1-ruili.ji@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c83b70-ef7c-48d3-0ecb-08db67285315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ex9K5pNqIxZxAaHGscRl76Qax5CKlR/VQpzkOXhzs7qtBGxKFA86pbq5g96RK3puAd1GhNmK0JZ559MwcNmfTJE4b1ExQo6ccMJJxchrm4JvpooOzEJYAnpAVnmdK9LD/Qlms4XhEnYqCoS73KzJ7omV6WrDFyLTD9qckuqQTuOUOcDbzrWO4+xginrA6gnh3UUJYEUzgbVSVTUqJt06LDzTMMD3/PrnNUhF3aE+PAgO0YZx3qZhTBix+2a20CMXUmAytUE7btc5NIL1rtwDQO9lR8kfhoAUPJ3djlmsG5M5lfAe/vvwqMv1fzgu4UVDvg5vsVpfYprjK3/jgLoJjHHWNQAtJ+Q0dD/sP7doUjyKh+F6PNBYo+LpBejTsHu2L7Oz8d4DjsJGvPxdygPdML5B+3/SJxVWE+JurVRGVU2SBABuQZKjOtSbs9wn1/bZ88VWXrZYW4Gvy3+OrjT4INKfL9TotI0Oj2mdmRq1QJtsMIAWX9YP/d9U2kvUVD4lbjuoYT05EuyeL6MROQy5PxR8Nd2GNKvfrGu1wl2WmzmF6+itfk5GrdGWKdtkTTvLwqdU8cGrhPePxSYI03DnDgSeTPCVIud8CuK/5AeFZr8QHDDHh9/Ra5rRKrvPGInUqJr/gFekzoPvi2lktjqTjxY0gWaAjd0dS8VtSqrgK8LiSgTTzYlSA4PgaGckJf2E6a1pP2SYgaUjMWyWc/GbXgAB5a0QTr2VtiFp0m54gIOG16co6Fa6Kqm038Hx+ARXeuIl7HXd/aDSIg6rCcGyhATWX2FT1DBTv8hsLmF2Hk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(40460700003)(2906002)(54906003)(41300700001)(8936002)(82310400005)(8676002)(5660300002)(82740400003)(356005)(36756003)(316002)(4326008)(81166007)(70206006)(6916009)(70586007)(40480700001)(7696005)(6666004)(478600001)(36860700001)(16526019)(186003)(83380400001)(47076005)(336012)(2616005)(426003)(26005)(1076003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 07:25:09.2517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c83b70-ef7c-48d3-0ecb-08db67285315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Ruili Ji <ruiliji2@amd.com>,
 felix.kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ruili Ji <ruiliji2@amd.com>

Starting from GC_11_0_4, flag trap_en should be enabled for trap handler.

Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0c1be91a87c6..b695d7a3058c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -227,7 +227,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.tba_addr = qpd->tba_addr;
 	queue_input.tma_addr = qpd->tma_addr;
 	queue_input.trap_en = KFD_GC_VERSION(q->device) < IP_VERSION(11, 0, 0) ||
-			      KFD_GC_VERSION(q->device) >= IP_VERSION(12, 0, 0) ||
+			      KFD_GC_VERSION(q->device) > IP_VERSION(11, 0, 3) ||
 			      q->properties.is_dbg_wa;
 	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled;
 
@@ -1808,7 +1808,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	q->properties.is_evicted = !!qpd->evicted;
 	q->properties.is_dbg_wa = qpd->pqm->process->debug_trap_enabled &&
 			KFD_GC_VERSION(q->device) >= IP_VERSION(11, 0, 0) &&
-			KFD_GC_VERSION(q->device) < IP_VERSION(12, 0, 0);
+			KFD_GC_VERSION(q->device) <= IP_VERSION(11, 0, 3);
 
 	if (qd)
 		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd_addr,
-- 
2.40.1

