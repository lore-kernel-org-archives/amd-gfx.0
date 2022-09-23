Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77797ECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 14:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB68210EAF1;
	Fri, 23 Sep 2022 14:27:01 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C9610EAF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 14:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyCj0rs5BrZiA9cr83GZK7VmU5QELHYQHwJ4JS+R14XyjMLUdPo5Lrn6g7Kx4ju1xA1P1IwNvANFfzDYSdzAJm1OlL/xv0bPh7FAJ6iI3VfXf2Hj49bKPMX+Yb5QRoElj9j5/Wi2qHNq6LTgnVhhunZPq0oUOurChssx/NFG1LTzvJdDBR/MOFQWWLTkYXZsJtXx1/tiz7Ws5TE9Hzr6sar9XXRdVfsFRp9HWD7V4/+XnMzYB0iJ5v31LRUD+PnbutUXUw6WCmGZXUrMsIg0+y5en1y3S48MAoWsFuSEExrx6ambN3I6G6Yd55A2QZbCu1P4VxaYkSnDijhA2bzBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgwToDCMhl14Gtt+1DkE+r56C6j25c9vKTJx5M45na0=;
 b=CbrM0PqZ7ZDSkAn4246SNRB9KfgPlDFNW4Ye8qGQ+AUqqiHM6wE8twCzeZw2DwMgKBJ5JkyG//mEPb2avOedlC4yX1Ym7sCVpW9yDfEVJZzludCA/JX1hc7iNackRV3CYwBQsZb2RhhD2IYoo8QZL9+Zkk5bBwsWHcL/OcBkF55bsTNkd5XnFQ5guIHAutNdAT4k3YRu9BJkSME5cjWRTfRAqwYLltPm4z2gKk0Hdtf4ParAWs3JNLjWK4ZOZ0BO3OPNqR04Yn+/+E5NY1sx77/bOtKW/HSU6P2YjtOsgrHeZRaed83HfaGCzkwraSP4kwKCkAkWWCWj+dXqUTUjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgwToDCMhl14Gtt+1DkE+r56C6j25c9vKTJx5M45na0=;
 b=sFtpx+xj3njJAvDbGIYom4m/clgcGdnVr+xPIw3ZZIRBecFwxS4kU4ktLghX2EAm1TyU2MAKp3w0MhpM/v7B625vw8Ptxx/yMB0Q+xhRwnszdo+lsQsK8Uj+JwAH3ADDxdPjhhDOAU2kosK056ND5k9r8PPIJ6uJuXZYLQzxXxk=
Received: from MW4PR03CA0033.namprd03.prod.outlook.com (2603:10b6:303:8e::8)
 by DM4PR12MB5037.namprd12.prod.outlook.com (2603:10b6:5:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 14:26:54 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::ac) by MW4PR03CA0033.outlook.office365.com
 (2603:10b6:303:8e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 14:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 14:26:54 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 23 Sep
 2022 09:26:53 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix dropped interrupt in kfd_int_process_v11
Date: Fri, 23 Sep 2022 10:26:36 -0400
Message-ID: <20220923142636.1007838-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|DM4PR12MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 4875c085-d881-4b3b-075e-08da9d6faa14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fLDExPlUQ70MQA9mo4gmcjZ4TBcmRuQA7fzpg/je5qIs+HPV4NwVbaJ/cot6NZRT70tqz6gRHKhcaEjuIW14WFFKobWFutaTZuo/wspPdrzxbIjNYNBaFEo8I44u3E0dUZ7iPD7mF7+HNwY5N8wTG5K2e0qS+IOzazuQ51uEvNnDGqb6abSpsU704V/HZQRGqrSlNdn7q73aa13teguDGDVy7q97zK8zKlyFzeeNG5+c6+rFR1yNtu+0j3xHaEPftLuL/6bgIO23lMpsQbPAQD1S9OsZ2k+zt0D/oiIa7ble3+WHm2A7VS+Ls8lIkYFP3+Brd1tfl+ohmr9oSy/U+ZVo0OOEevncMbE34iE5R0ERIU1x5L3oDYncqJ1v3/D+TekhdLHIXoUQzirEpaNftVC05o3pRzjMfp453QSm+VLugp0wxuuXOcW7YZJxZm0c+PdqKN9JtP4nDxhUEUBTbhjVm27BWPq2btrnU5VeRFCHdS+oROq6YiDkLZyHMJdxmVgEmUZWiXN7KQ+GsSDAwnRfxDQ8aubBTkPfAHwbF49AXN8h/6ttKrf6elr7lmCJ3Ue/c5tG6m3Bvi/xAfOxEhY/EG/EL4/mnbcs7ic00+2OiZzy5l3liCV8UXyKoewvuQL4Wh9VHiMwmMO+AQyfmpbUHesmlXAdKUxJF/3TaLivs8iU+QMH2/3qpHtmvZbcauMZFFn+6sZtt3YTwW+9pcyNUksgWoRVxFdvWwhZM6N4iyJNMKTvuHoBk+Q2QNHiCN7U/Oj8pxfn592Axf/O+NQafq71eQZWGwjnwJGo8s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(8676002)(86362001)(336012)(81166007)(26005)(83380400001)(1076003)(356005)(16526019)(186003)(426003)(316002)(8936002)(54906003)(40480700001)(6916009)(70586007)(70206006)(82310400005)(7696005)(6666004)(41300700001)(4326008)(36756003)(478600001)(5660300002)(2616005)(2906002)(40460700003)(36860700001)(82740400003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:26:54.4841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4875c085-d881-4b3b-075e-08da9d6faa14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5037
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
Cc: Felix.Kuehling@amd.com, Jonathan.Kim@amd.com,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Shader wave interrupts were getting dropped in event_interrupt_wq_v11
if the PRIV bit was set to 1. This would often lead to a hang. Until
debugger logic is upstreamed, expand comment to stop early return.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index a6fcbeeb7428..0d53f6067422 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -350,11 +350,11 @@ static void event_interrupt_wq_v11(struct kfd_dev *dev,
 				print_sq_intr_info_inst(context_id0, context_id1);
 				sq_int_priv = REG_GET_FIELD(context_id0,
 						SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
-				if (sq_int_priv /*&& (kfd_set_dbg_ev_from_interrupt(dev, pasid,
+				/*if (sq_int_priv && (kfd_set_dbg_ev_from_interrupt(dev, pasid,
 						KFD_CTXID0_DOORBELL_ID(context_id0),
 						KFD_CTXID0_TRAP_CODE(context_id0),
-						NULL, 0))*/)
-					return;
+						NULL, 0)))
+					return;*/
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
 				print_sq_intr_info_error(context_id0, context_id1);
-- 
2.25.1

