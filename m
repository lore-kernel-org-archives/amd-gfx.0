Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9699FCD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 16:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B48910E44C;
	Thu, 30 Apr 2026 16:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ceGPzQuO";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6DF910E44C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 16:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4KqhCK5Bipda606VeGjhjDYpTw2Bqk/woCkGbB0jR02AsiQ83rTZ/BqoLnJ5y4Tj75PhbiTihTHR4lh9OqysRWAIlZs5B0TSINhz0m+kOgalkf/MwZuRYRpi6Z9rApLW/DXbbVC3a+XTVIf4BdjYe1uo8HWHy2rbdWVb5QKcfgI4xGtkyfDscWr14N2WcPFsRMiXQZY7vc5V+NNkN4kcwqelrphti0hTQa0bPKCmuSaWWYN8c7vPLPVyUKI+akcKpI8pRyhGtzvvrwX7/GYA5IXXyguMLlSwcpHwpQqioRI6KLYHjc3I0xqf60g1a1W2xDtXMLTwPuKsR8FqYJ3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3+i3KHnWMrmCSY9S0iysGvnpNAYoto8+YOJlmzCD6s=;
 b=sSXat/ZTfxgEIJPDGJmypUbc1RrkMOVTProbaPJHoVukL/ez82dJb70YVSu06hJZyYpgAuSBM6L3zot6o2Cg2GmsMn7OaXs4jCd2muSSi6uOihJtg6wpEW0Ku/NIJHj54k3Iu74xNezXXL2f0SfL6GoqdmUAKVs2EGYvnausjPh9OoatgPtiIzKDkjyn3DijYjhBHjFryNbdMXtqha1adyymJ6f3UtKT+aVlLf3yk8/RzVcx6HFjB31eTBeOG9hF0pr7kelFihspogVxPemdppqaI9P+1kKVIeJHIwn3EOlbg3ENkYWyyBzVh7dGYu2nWQJhv7tkhaDX7QjET8LBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3+i3KHnWMrmCSY9S0iysGvnpNAYoto8+YOJlmzCD6s=;
 b=ceGPzQuO4Ke4I9Ch4Ex4JMc741a49zFZebWHI0Z8gYjariGGp0uP5NxNVxTf3NCQE0O8No5es8yRNOaaeeDxiMG0POlaW/QJdvhJ7hXU7NAynMEz2Mr5Pg2XHqpZPl+NWNmifMCtqSKPP/8jDp5IlW8NxT2pIn8iCgFWngKqWg4=
Received: from MN2PR20CA0055.namprd20.prod.outlook.com (2603:10b6:208:235::24)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 16:12:06 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::e2) by MN2PR20CA0055.outlook.office365.com
 (2603:10b6:208:235::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 16:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 16:12:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 11:12:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 11:12:05 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 11:11:58 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 02/10] drm/amdgpu/mes11: plumb unmap_flag_addr +
 NOTIFY_WORK_ON_UNMAPPED_QUEUE
Date: Fri, 1 May 2026 00:03:30 +0800
Message-ID: <20260430161146.2851078-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa7a207-5c98-4c87-e3d1-08dea6d33905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: wX2QSQE5GAO8NOpmcTHpMhI+ZwVg9swytqEtHA8d2tNvKu7fowsKxI3cUmAVFEWN9UcJbpgWgwBzSn8KkkSxaEF2LT6NunZMbrauOzDXR8OMI/yrgonIuMMI8C9lxX8ma4soeNLSQ0MtApV4DaFXD4tpvCengL+hWlNzea/X2pGeyuxZSFDUOM6lim7tYOULEMsISfw/qD0pRc5uQhCh1YTuuVHiO3OzSRp+6K4C6evnzcMVu/0vou5dRPBPg4mV34DKls/SctqQdPju4B8x58+KghiC5DfmxXlWnQCbgyOs8j0MmTFxPFhcbdTDRIbIgLMPPsnIHu5iLQTtPP7JkZ9cphRtYoV+aMBpKGOdGx7WN+sNkhO+cSD+Jw382uqU6wEF2p8SK8cJzDmQyO6CbmWLkmsB2Bt00C5O39lR8Lo3UKT0PAlSElYcHkNGMgtrJ29/LwHi50Z1SHs4Op7s3L8GvhfQB3VoWt6eYMiZKA7vZ2NkDg/Af+2Oi0xrVerccMgcpQTZXcF4SMSAaet58r7M8IKOPvDmZKw1xoeF4fBfiAIRWsR8rmIGbdNPREOiJoHh+RtgIHIk8z/dfAbS61ya1yfQZ443J2kSOUbjOOzEHRq1E43iB+Ylo3yy9G4lPmNaI0uO+25yOkWMZqYpbz8PnmVWiyW6+UmHkiV5QaSXNA66fe4tK6dSiOqjFpZLxrP5fCN+oQ17z1skp4je88w7V6ybPDjlDxh+6GDfEIig+RacazpWPwQNFmzckMeeo7hacsjPaUGZHy3Ofcki7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ur46tBU6pgj2ia83PXSLMnejOVlBoYDnI9N+q+PQZ5DOmcwYmO6y8f5O92DVJxeBY8r6bLkuTcfimiMYBgWpvWm7sanczwsg1jd3bS6WGLneZNpjw68o90X+EhMp7GzEO/OZmmG5ealwyo5+8c195ha7TJzShvs25/Wy5nIRn35COJKn14KXAHYGu1hfC6ReCz80JVaQfcRYvB4lw1hu2bE9/7e5IuseyAMnVsxOlyYy6rDw0ZVW/cNGH8UNKKvQwaEhnSv87bgJKu33rVbWMGYHMT7KfbNVQ1QjgZVS2H++IV04V8vIvRiVnhAk8wQKfGClWkS8//rLU2ffEZS5Q1c4ef4e8fdke8r+P689z7n6t8F72bg7w8zFGxqqOKc/Y8MnSckF3HljKq4CSpXA0Pxmx235Yb+Fb3xClCmC5DpCPyBGkH9dn0xfx4F4+vlz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:12:05.7752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa7a207-5c98-4c87-e3d1-08dea6d33905
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

Pass the new mes_add_queue_input.unmap_flag_addr through to the
MESAPI__ADD_QUEUE packet, and route MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE
to the matching MESAPI_MISC opcode.

Note: the MES v11 firmware spec does not (yet) carry a per-queue
is_user_mode_submission bit, so SDMA UMQs on chips with MES v11 may
still see PROTECTED_FENCE-as-queue-done behaviour after the first IB
until firmware adds the bit.  The wakeup mechanism (NOTIFY) is wired
up so that path is ready when firmware lands.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a926a330700e..575cc4a684b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -362,6 +362,16 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 
 	mes_add_queue_pkt.exclusively_scheduled = input->exclusively_scheduled;
 
+	/*
+	 * unmap_flag_addr is plumbed through but only honoured by MES when
+	 * the global use_add_queue_unmap_flag_addr flag is set in
+	 * SET_HW_RESOURCES.  MES v11 firmware spec does not carry a
+	 * per-queue is_user_mode_submission bit, so SDMA UMQs on chips with
+	 * MES v11 may still see PROTECTED_FENCE-as-queue-done behaviour
+	 * until firmware adds the bit.
+	 */
+	mes_add_queue_pkt.unmap_flag_addr = input->unmap_flag_addr;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
 			offsetof(union MESAPI__ADD_QUEUE, api_status));
@@ -660,6 +670,10 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.change_config.option.bits.limit_single_process =
 				input->change_config.option.limit_single_process;
 		break;
+	case MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE:
+		misc_pkt.opcode = MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+		misc_pkt.queue_sch_level = input->notify_work.priority_level;
+		break;
 
 	default:
 		drm_err(adev_to_drm(mes->adev), "unsupported misc op (%d)\n", input->op);
-- 
2.49.0

