Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F7BC25B08
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 13:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 256AA9385C;
	Wed, 17 Aug 2022 13:45:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 577EF9383E
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 13:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sxi+vUnnELC7OymbC4BngkBxlluv+jz3xOwPI+IiDAb/7hUwjBogrwhpvwtutMZrMlrSfzfjnV0J/H5YtMw9okIjXxOnR3FYnx5uc0unS7L66jHMiDdJlK6fjIVC4m0sGTRSgn71kpNpqxzAcTuiCYCYJOw3ZI3Ols8WFB7aHElh6a1hnqmmTzisxeefGbVxiJoQRX+Cd/Gbw+YpnVGNcHbzqBfcTB8P7yHs/cefE+8oDYM6tau5HQqPCh5oYuC50s7E2w2/gKV/2GrqMXhtYDQ17zXTNwL8hfsa17xNIdXP3TUSHCLVZ8nG/bqWOFLjJs/IZFNxfqdCFXIdk7Bi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk+OX33LaAH58TWBloxGXwNJIeu9gU4c0ESVBk4nYZ4=;
 b=m2aTeaG/9vDe4WM5ZcZARgrESa8ynRxN5XIFqHRErlVlirhTE+eFFdLqnVM7wYrv4BJlW5fg6rP7sWj7f1cHj67u7msP/ZKryB+YQ1ZSB5H+Ml5Fo6albGrZv8f9Wvy/atCX5Gn4E/MAnJ9LD2+qMh6BoxWvqi78xiC7QR7jSLd1Gf783Wldnws/FG1P0vHmviTt7Cb76dKK2QCcOLGAWpkSTBmUv2BGAPZAJhIOebFrFVW8lGW5+Q++XdR40TWcSry+hmgi2dnJo5+M8obfXzW+NihWRccScA9YggxhFwk/XdFe/kND1uOhKY4MJ1ztbmAeXI42XvYjMcrYWrq/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk+OX33LaAH58TWBloxGXwNJIeu9gU4c0ESVBk4nYZ4=;
 b=Gki7iDiBb/XdTYwfHHv3UOkmiJMg5SyQu5GiMl+Qo8PZTI0/ufvPpKnTnuD8KmAIdNUcxdPJMW+L4NqFYO4OF8Tr0l6Oq52wGdfC3hD/FvygB7Jr6PEfqylB7gvOZ94GojG+wi5yQ7HzlsrkZ7Ejf+XwR0ZPY3rdRHevas1ISfM=
Received: from DS7PR05CA0025.namprd05.prod.outlook.com (2603:10b6:5:3b9::30)
 by BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 17 Aug
 2022 13:44:42 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::eb) by DS7PR05CA0025.outlook.office365.com
 (2603:10b6:5:3b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Wed, 17 Aug 2022 13:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Wed, 17 Aug 2022 13:44:42 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 17 Aug
 2022 08:44:41 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Update mes_v11_api_def.h
Date: Wed, 17 Aug 2022 09:44:28 -0400
Message-ID: <20220817134428.3674667-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51835cac-4ee1-4f1b-83a6-08da8056a37a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4934:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIZkHz7b0v5T3+B3gis0FFBekbEYnyztfSL3CFv86wUSslm5NkuAjNUzbuFJALeAs8Kz2PBrwl6d/JxFj1AkNLTseh87YEvuzfT3yLDIu7cY6mxs4B+ui0yIlbLF3uvoAfaljzxbeUsD/TwMONeAGO0vs7p1isDtXFJigwEU2vgqINTV9v1ZcgQ/NboX2GAwLdZ5sNNYVPcv6IzrRjrLqGL4o4wccmbGJKaxRFmqLBCM7caqQxtDo9aCt5ligoqk5M/Bt/ahRj+RU+oKdbi4ISfc54mIaKxRQwkjU6aa6ClPdH1XolHakfJuYWGicDGITLLTwxtWF7w8SNg0aPb5Ajo4Kj2jbcqJsDzk2q+E9FK/SF26TDVLgAfAHRs4sPDZvcokrmUqYRO5oqrkl9KjZ88FQ7Se2ypJpJ06w5lxTJr6akkx2bsc6EW8I+SaDcG0qPVkz7IXJjQ6fLCH70br0T++pq2mLfFAQ+d0sMUrhMkvmrb3R68ReT0UqwfK/YzRyvy6/4q5Fw4Gis0H4uhCPKTekwkiGV5nmbpe0rtgVZ7mFW0Cv6kL+tl4xmsDfmbkyxlWEh7abkGAqrARXuzAgE5R5sG/LsX9Znr7f9gE8z4MngVTL5USwITcLJSx3VP6s77PjG5ajxoEEjvWBDZJ8MRDmyd3iLnMEwvA13dmALZ+2RJpuJ8mbo0um2A4QmYORvCY1BuPm4uklsdMyje4o94ZAeCeNC0IMbW377aGqrdrhAPAW+ImVhYoHXRjSQEkQQ1z9U/icZGGaWao4prAdbSoqYkJk+TcK4qksBdEpnvA+IJ66zoeokem5MV7CZd4JMcg+5OryaI9/4nJQxtVzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(40470700004)(26005)(316002)(41300700001)(2616005)(356005)(70206006)(6666004)(70586007)(82310400005)(2906002)(82740400003)(7696005)(8676002)(4326008)(81166007)(186003)(1076003)(5660300002)(47076005)(16526019)(40460700003)(478600001)(336012)(426003)(54906003)(6916009)(83380400001)(8936002)(36860700001)(86362001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 13:44:42.3510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51835cac-4ee1-4f1b-83a6-08da8056a37a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
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
Cc: Jack.Xiao@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

New GFX11 MES FW adds the trap_en bit. For now hardcode to 1 (traps
enabled).

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 1 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 120ea294abef..cc3fdbbcd314 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -183,6 +183,7 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.trap_handler_addr = input->tba_addr;
 	mes_add_queue_pkt.tma_addr = input->tma_addr;
 	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
+	mes_add_queue_pkt.trap_en = 1;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 80dab1146439..50bfa513cb35 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -268,7 +268,8 @@ union MESAPI__ADD_QUEUE {
 			uint32_t is_tmz_queue		: 1;
 			uint32_t map_kiq_utility_queue  : 1;
 			uint32_t is_kfd_process		: 1;
-			uint32_t reserved		: 22;
+			uint32_t trap_en		: 1;
+			uint32_t reserved		: 21;
 		};
 		struct MES_API_STATUS		api_status;
 		uint64_t                        tma_addr;
-- 
2.25.1

