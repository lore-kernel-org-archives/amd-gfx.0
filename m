Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3557FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDDBC10EFEB;
	Thu, 30 Mar 2023 19:42:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4A210E2D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7yNVxMjqo8mrwEXnKKcKgFKahb6H9xsABAH3FH7e1JDXO2S/3SBJ045bCwI4P9M2DQNHMpOxEl+VWGDFO1EH+xbNHjdkD2d9h/MlbodEaKab8YTFVIG/SSdW/AxaX55f/ixyB9yv4ZxepesubRcZ38EHqXJYdgj0X3/ulvhhSZerDOczifJDnzkAI5XASodlUnZIYQJrtsgNi2QhWSzSGo3kZ1gjnpV4zITWacw+Fv+GTpxKI9MXZMfHrkBj+9hvxSJXA7PQ1K3SOCX+qnu1sMwJ2JDb27p4oFMkK2QB5i/FM+DrsUJcx96o3akDNJjTphK4suD/X+ZDF+AetneBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2Pn3z3lOT5vKm0p3IIHGU/gIRxN8JJ1Duq11i1qDp0=;
 b=JsMm0QvXC7KaHBasafUUfwxcQO+v6a6cr6El+pP5XQ5v2jEtq6rNPFsN4W2aVtHGBvhM1bCLkYb8Ar+M/vgn41KREDGkmYwJSmXkcfCGEMzbKG6NHAY61NJrKP7UVsqUm2tbnAIbMeEg5w2KOi8mauu19HUm6NTbJturnEZMYq6UzVu6jMA2RxJLHYzE1hWgvTiCtE+rNkNdxKJEfzn05n2u8bP2yyGrqOkoWNyblM+aTI2TWdSOier4PLtBHa30XHVVERAfNS5mTZm5TFq3Vqxu2ghAct9oe+D+2hezjunAB6pMMv0NjoTMgqt0scvFKDIMZ4LJIUaPjECfzZ+Ndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2Pn3z3lOT5vKm0p3IIHGU/gIRxN8JJ1Duq11i1qDp0=;
 b=WNfJg5Au7xxxpX8jZGFc7dtP5H8viR3OqIA4rZrSl+AgK11D3BOqVKP65UWHUnmbxMflhpYg/diLkcF9ZO+B3sO77AcDW95c1ACAXGC8332HKYDdciBG7kpJTANRNhQAEG2aJ8s/0VStJx/HbgDIHW7lKxjlHM7LuiIFHYd955U=
Received: from DM6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:333::25)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:42:50 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::5f) by DM6PR03CA0092.outlook.office365.com
 (2603:10b6:5:333::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/23] drm/amdkfd: Workaround MEC mmhub flush issue
Date: Thu, 30 Mar 2023 15:42:14 -0400
Message-ID: <20230330194234.1135527-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 6affe710-cf07-4282-385d-08db3156f128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6voeqS9gukljQbc/lf2GNuJMrFnJr00KlCCPZakHvsL3gOOw/3PtNflo1GeIw7BXcoSh46SipiGI1ix5WtpR+MQ7MF5A53MWnZEvC42A9i5xcjWWVN8Zj3tPzZ+ghcXfohvCNvOk5rJJ0cEsYN3memuClVjy4Oh3+vrWZw6+jviQvns0dXbiKvtWtGbn+gX/TEFiWyk1Qul9NcDeyleaQFaAFZlbl/swkEXTaOzexXjug1DwhKOmIEk99KKr4oCXuw+llCcQB3G2QLjd35L95vD+1liyRw4OSQQQygNnqIofaSoQJVrbH8OpR/JAmYnskON7DXQ8V4ieR5QKKq2nJHmhbhaoiCou7DUH7oQAK5FADUMR5+yZnJPK/8SQHwFYl82nZiAIWAKpms53z26HWiRCizqztI1sWVZFZMrlJAMpLXBuJ8xNDUA2mzkucHnKYzNltnSOdoU9ktccY4lcyVFqiIhm0ILbuMtNpmagSidQGH213QfjuW2iglwjBRHOG/LEXYHFxxLfkCLYH2+SsGO/bpwf4e5A6ZVfi0d60vba2o7tZufjLNoGbFhFKBDZxC3REHluPIYKfVt1M+vuVMzf04loK0RdMyQRt/Gyg5DAu/SvjAKRGBWKajxUZmwV/Kz7W/B56Wr1MdIfEPScXXEKxBIYDjbtFeJyrybAyY6Qdiep6rzKnZx2LKV0/xZb1bwztphoY0FQocKtm1VwKZwm3RNL7wvgwB0PcPvQuE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(81166007)(82740400003)(356005)(2906002)(426003)(478600001)(36860700001)(4326008)(36756003)(41300700001)(5660300002)(8676002)(8936002)(16526019)(6916009)(86362001)(26005)(186003)(316002)(83380400001)(2616005)(40460700003)(70206006)(6666004)(70586007)(82310400005)(40480700001)(47076005)(1076003)(7696005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:48.5169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6affe710-cf07-4282-385d-08db3156f128
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 David Francis <David.Francis@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

MEC FW should flush TLB and cache when unmapping user queues, this
is not working correctly in master FW via HIQ, it affects SDMA queues
which use mmhub on AID, cause several KFDTest failure.

Workaround this in KFD for now. Will revert this patch to verify FW fix
later.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Tested-by: David Francis <David.Francis@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ab91a0e211c8..1d53cbc55253 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1038,6 +1038,15 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 					      KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :
 					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 
+	/* Workaround MEC mmhub flush issue
+	 * explicit heavyweight TLB flush after all unmap_queues calls
+	 *
+	 * It would not help if the firmware is unmapping queues itself when the
+	 * runlist is oversubscribed.
+	 */
+	atomic64_set(&pdd->tlb_seq, 0);
+	kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
+
 out:
 	dqm_unlock(dqm);
 	return retval;
-- 
2.39.2

