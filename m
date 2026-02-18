Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7879E9A02C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 16:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7057410E604;
	Wed, 18 Feb 2026 16:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c60Z8hB+";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9891410E604
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooxM16POUDrMZVrDSat7l4yuKKnDFMlGp/BPGv+8mT7t//qzauIPNA+np+ZC8JYTiugoGO3b3fNAXduRmVA2Hw1GSFh9d1RES6XsZGOkVXkNZ0UtmNz3XDgUqIU5rWy+NABg3ow0/+Mx7kfqjwqVVHwGa+wH9KmKd8ATCTBJr7vjtF21e7xkTgysoMyTenCqtxJqTIAtWy2wlZuvmIMCLNXpFZvSwIVvxdHbcrdE+vjvDbjjEPvO3uKXpx/PkEG2S4vtyJhEVtMjudCXamkrfBOv4KFJbV7Mq64IAoi7lTCw609YJDedRt2F9e9PwsyWXJLp/AB2G+Q7AxFh4uHBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmoaRblv5EXdAsy7cl2hiGR+g+mFnIZVWk+C0iOiFag=;
 b=nz2zvYDvDl8SWXd5lfQnOgqYpIiadIy32q+DE56SUI9r67hIagx5d/4ZoobFgDg8YHVEnvcATkvGb6f8S7ebgoaJD4bsZ1hDdieaDeT3Br++ZdfHuWsSY0LQmqrPOMBGzZjYKLD59dSleR1di+1gUE3RGOEIEpEYZ13qvGPpeIuk2H51jwcBwQnoA4LvUuk2zeoj4vtNG9Y42RxJhwe6HTOozU77nqBbVl5jnVa5TZeZDXL7j7SQ9fAZouHZHpvn7xUY6M9Y+pPrnXqYP+mJ2TuFr94XBGtxezjd8KTJNobvULTe+dmjU4D0z/Wv5xC+9Qz09c2IUCxwbefjwdRdgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmoaRblv5EXdAsy7cl2hiGR+g+mFnIZVWk+C0iOiFag=;
 b=c60Z8hB+H+SbZ2/PHFkWqn+zHw6A2wD+H8KH4wj9Wo5lVGrdbFMTBhYYgjSL3pXWH61JjFSRuCWPbPWNCWhmR5YrBEiP5G6ey5HW6y0hIN2n5cUJeA6rSdSGkTGqrLvPc1rJEtSOuCMKLu0J2/Gyxo5M2BPJHW+tc3v4vq3holg=
Received: from SJ0PR05CA0200.namprd05.prod.outlook.com (2603:10b6:a03:330::25)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:51:40 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::88) by SJ0PR05CA0200.outlook.office365.com
 (2603:10b6:a03:330::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 16:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 16:51:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Feb
 2026 10:51:26 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Feb
 2026 10:51:26 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 10:51:25 -0600
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 8/9] drm/amd/display: [FW Promotion] Release 0.1.48.0
Date: Wed, 18 Feb 2026 11:48:09 -0500
Message-ID: <20260218165116.155001-9-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
References: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3e8b8f-7c40-40f6-30e5-08de6f0dfd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TV5n8WMzX2WlB3jUrhw+3OwYZmxDdIPMEJYc+Suy/svQ+JQNuLnZLQYPI0NU?=
 =?us-ascii?Q?bZnrICQ8cqQ5Dx49wlO/X4HASm9z/9xaOIJU8tOP0gGiWP9PcPT6W7KA50yY?=
 =?us-ascii?Q?AXtkHohirgQBAJhXvbsJW3kWQgaIe75i4NMPQXLHsTWCTI7QLloG7B4E1j60?=
 =?us-ascii?Q?UZQ8tDOScmsjgnQOhGEGjy+6v6xGumPLG/RLJV6lkHuaTx5ZMCp+sxZMctfT?=
 =?us-ascii?Q?dja9VmGZV0e920NJUxaXmAaku8J3ygRQFjMrRKOcNXStMqe+aqttsdyWg5bJ?=
 =?us-ascii?Q?hmInDWyBcF7vnhFUyqIEpIORFm3Ae4mT8YzmvkvUYQU9zurBcfpVsC21H4F6?=
 =?us-ascii?Q?GMV7m6pFRyFNBhR3xZtFUcFCpTKt6jas0huK+TofqGJEjobbXBo5o3LzAczV?=
 =?us-ascii?Q?yNZ6gf3eQNh/oJ4PL53zQBEUErYKWtE9zKb3/wmiqE8hKFqMK3o067Kn7z2m?=
 =?us-ascii?Q?rm0SGdYNcKvLl9n6oC496g3Elcduu8sKyHWUsj0ypec9Kn0+QAUqcuOdp4Nn?=
 =?us-ascii?Q?hUjRm0ONx1f7J3TwqD8uGwhhrpj1v/MNHuwiBd/bX+9xVvXA9wm/PzokR323?=
 =?us-ascii?Q?bVbzYTRl112Ue5HQmFqfD0LDC0sIXxbFcYZjU9aWeesrNjujkAG5D1sz/Cve?=
 =?us-ascii?Q?9jg0opGiZag2lD24pELvbcw+OZdlwzX2bZKAN9HCcpVxeXq+zOtcOX3P64Ol?=
 =?us-ascii?Q?mG2/V0HFFFbUVY1aAUVAIlN0YuJ5DL1yflTebRR1NVnv0z+/e+CjMPPlpd2Z?=
 =?us-ascii?Q?CUy+GtwAIsMF8AUPkeenbNNoKHRLcdsownoLVUXYQMBIUkobf/MCxyxJCf+N?=
 =?us-ascii?Q?KKnmxJ56ay703kK2R+OQUmihyzV/bTu/btAad+WZFRuK3X9JrTG+8KBq2O9m?=
 =?us-ascii?Q?kDMIcEKQNnUZdzUi4KzfUPawQ4Z7xf9wID+MSMvNSOrRsxzjh8wYjAExAl8r?=
 =?us-ascii?Q?ESt/f0mEBeerfvZBezozmlY+kckv2lUD5SIzecuDGoejv3NfuHXqllZxk60d?=
 =?us-ascii?Q?JPN6fgTg7E8V5lKLG6hFeKp0VwmtPGgRqPiTFdA/AZY6EqCdes7cfwFOmeIn?=
 =?us-ascii?Q?daoawY6GEa7p9HnFQc78I1uTwkwfmT2vWD/zEvBoqNIrl5sz2tzQby5dXDPy?=
 =?us-ascii?Q?UWlmKn2ORlYEkZtITsacclHU8k9dUiB1XgkcNgCdKWfrw/KWZ+8aQXsjmcZW?=
 =?us-ascii?Q?SNFevRMTUQeI1c+naNW/8Ekx77Vh7sfl+sQfeYRv4HkbmP9JJTX/t4adRW6O?=
 =?us-ascii?Q?K+cOWKufclejpMX6BNBDQyRA1UyDpjLhUa150njVCX9UXyJEQDMFrUcntTec?=
 =?us-ascii?Q?tuQeiYgyKWR/s4W7DGlj11GIti4Ybvx9oclDLFgXAhMgMjK/++1JbeQyHvKp?=
 =?us-ascii?Q?LPkU9Fh2arj71lR/Jf0XncwB2tXcbIZTFJD6XLpKgFdcAPZiGsDvDXhaRseK?=
 =?us-ascii?Q?7BZuTo4++/5oGNxTW8q3Sxabfb9cSGte/VQVBAFge2noFmneilbkK/tbiRZz?=
 =?us-ascii?Q?yr57RXWZSZ3b90itAqh6EtwxX/GmJzo6bTxEmaeGhH1U4V5RoZK8KzIcXOg8?=
 =?us-ascii?Q?eglw1kgtzkwjJI8KEEfZTh0A5nVWiBCcAfveOXavnja0MCQAnZJ8mAbtL/ga?=
 =?us-ascii?Q?Vac8bnI3qiLcLr2HY4RM41+SlSLXC4Zuvvn7k96LtNSg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f9eHbuOJ0gRdUg/bbc/Pw+I3hI7e0FuBLTwzac3Xxa1c3gnWAtFoQPT8B4Rex34Iq4Xn08uLssvTnUvs1l90rTA5fB8djVoEikpMqUMbqiuTs1kaK8i5wxDITnQy4ewKzRcVmlZ3kr7EFQXLKM2FkomcsQtEiVGXVMPGHvNZhrWmaw1pae379huo1YEiEgEzUylockvbBsKibmZYrCUcusp6qzcNialQaoLrPp0J/nF4Gn8kmebp6EnAI/CTlgl8XSL5fnsMT2sx+ljp6LFGer5z9i1d8X+Uou7lIUW17L5ujS75nrSRJQOoqfJTQU5j9zc2lKSi/PTguhIjSFYsSXYMwZY5IqPP+8kn+itTPj7/iScA1QcZZngnhbw7yZtna33ZQjF7YO6Az8gdVzf1aFxwftC+jJmHeAygUh4a5WaImaSVd0thsfFO1Qhf7V5j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:51:40.3227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3e8b8f-7c40-40f6-30e5-08de6f0dfd0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
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

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why&How]
Introduce DMUB IHC command.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6f388c910e18..2abbc6c97850 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1897,6 +1897,10 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__PR = 94,
 
+	/**
+	 * Command type used for all IHC commands.
+	 */
+	DMUB_CMD__IHC = 95,
 
 	/**
 	 * Command type use for VBIOS shared commands.
@@ -4959,6 +4963,52 @@ union dmub_replay_cmd_set {
 	struct dmub_cmd_replay_set_general_cmd_data set_general_cmd_data;
 };
 
+/**
+ * IHC command sub-types.
+ */
+enum dmub_cmd_ihc_type {
+	/**
+	 * Set DIG HDCP interrupt destination.
+	 */
+	DMUB_CMD__IHC_SET_DIG_HDCP_INTERRUPT_DEST = 0,
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__IHC command.
+ */
+struct dmub_cmd_ihc_data {
+	/**
+	 * DIG engine ID (0-3).
+	 */
+	uint8_t dig_id;
+	/**
+	 * 1 = route to DMU, 0 = route to CPU.
+	 */
+	uint8_t to_dmu : 1;
+	/**
+	 * Reserved bits.
+	 */
+	uint8_t reserved : 7;
+	/**
+	 * Padding.
+	 */
+	uint8_t pad[2];
+};
+
+/**
+ * Definition of a DMUB_CMD__IHC command.
+ */
+struct dmub_rb_cmd_ihc {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * IHC command data.
+	 */
+	struct dmub_cmd_ihc_data data;
+};
+
 /**
  * SMART POWER OLED command sub-types.
  */
@@ -7142,6 +7192,10 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_pr_update_state pr_update_state;
 
 	struct dmub_rb_cmd_pr_general_cmd pr_general_cmd;
+	/**
+	 * Definition of a DMUB_CMD__IHC command.
+	 */
+	struct dmub_rb_cmd_ihc ihc;
 };
 
 /**
-- 
2.43.0

