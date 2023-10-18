Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D8CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8970C10E443;
	Wed, 18 Oct 2023 17:43:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE30910E43B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlq6MDCA085wSSW5t1oGarB2kcUjFnVhGwuiEUlUY0vg4D1970BTApnVXQ4WpuzCmt2pmr4iSyIfcSVVrXNPMfxa5jhWxlNe3FdB9VEwWZ7brWCzEkBxcvW0Ml+mYpnSPf2dgqyPIokxWfNSH9n1lotIz36w5qIXZPSU1syRQ4J4LBYJ9MQPl1vdwVoklY+ooiEHefVN7WwYvYFAbP99BvJkTupdr48CfkESsMwLKs/3cGi8Jbua3VftMMuf16EbYyaAO4pdq0/zeYz8x2ng+Y2qk1LAe7Nw5hB0TsRNg3y6mFCMHg0AWoygtAaIObZQr1nww2yF37vUDNtbGVBS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzzUv63CTHMW0FJM0QJY3yNTsk6CfAk0mqdGnsYIfQw=;
 b=hJjXX7NQ4bQqxj8pq12TBdvysb6CiKQT8BpGiRJxcimOQPOs3H6M6EhCOyYAn+JF8zOwWzcSJkvEusNXlQiNZqxiTfKm81j3bZyZraPEuXkT6i6LErxv5kX8CxbJrST4yK/PNOG0zp7G13ygJsi+03ayeyNdxIRyD19LHZHh8C2jCQwi0b0+6Tdp1BDNp37wUYvGLfpWeTAU1kKJldvZ+799f3rkeo99z5VJ9w4i+SwWHVChKicYBIjUw1vckl/5fzGW0uUnkzJZGoDXOKuu9ixMpxDVHUI0ML84UbhFB/Bz0liQqIPHbmNMhrgY5fP7TY6nBwenOlxGEd4X8E+HlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzzUv63CTHMW0FJM0QJY3yNTsk6CfAk0mqdGnsYIfQw=;
 b=fynk6ifFeWERgjXF832INf7MWXo9hoXzpbgpXD0y2DcUMI+l0Wc93w+2HZhFglf7sDTHcqSyZmBojsSesjiml3xBg5UUY93swPNWuCn1AfpxZ/NQa5xjLeoS8PbeI3VbjiuU1JH4YdT3JbJuZhDxqsjYAezCBSzzszASB0CINfI=
Received: from DM6PR21CA0020.namprd21.prod.outlook.com (2603:10b6:5:174::30)
 by PH0PR12MB5468.namprd12.prod.outlook.com (2603:10b6:510:ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 17:43:37 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::f4) by DM6PR21CA0020.outlook.office365.com
 (2603:10b6:5:174::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.3 via Frontend
 Transport; Wed, 18 Oct 2023 17:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:43:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:10 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:43:09 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/26] drm/amd/display: Fix shaper using bad LUT params
Date: Wed, 18 Oct 2023 13:41:28 -0400
Message-ID: <20231018174133.1613439-22-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH0PR12MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: abcfee0c-e57e-4479-2fdb-08dbd001c208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQ+5z+sUPpEmGhsLsllHWDrwbXaoWl8HHRV/gW7+D2vCkhUEkrX2dQClikpkRkGkymeGAf9gHXX5raN//h1pWYPH9xlZn9b/5pqO/6bnJkLLs/VGJTmSqsUHc6XU9ayW+CaBSWWc4Dg1dFZ9ooQ9Y9LlIrYhiHW/179SbrrvhW5dPqUQJ/DVnZfRslq9d6pybs2TTnuk5hPzVf8g4RRXq8MNVXNylKoBJy6bi6nF3qy+zz9jIjHBVFw8TsxgQw95JJCm+eeIE0k6RNmjCbYuu1FKoysQo4Jy1wiFzUoy2Vx+8gQpOVzrJfiQsjmGnICgz85jcv4gu/ngAYk0kNLDkbiuSRQab7tVRqYf040TwtXgQA5XK/jXop897yzItHEhZdl4P016/ocnRSkQeyvSuw5luOR/FhvWuet8JyOrQ/RZjgdD3e+hJUUWm1nciXFdpsmt+5PxD53pgcGMZx4Tu12vFWno9y7qwfowSGqR4OnwBNGDpgdUglfMkUDcMAT93qTLgRxIl7tAP3oKPpx9dZiG6eeU1aiNHr+TBry4NybnrpmKQmbs907pvRI6FXM+ziok8TzdoG3zJsGhPceAPBHryFOgIhlCWxY3RVv/ufYTx5HNXWqXJsWb0L7DDjc0BlDpy4lc4eoOf3tO8+a3XPiZrk5LgRrisb8KFKHxGXD/UqE5ZmhjGiJ+orzFVPvK5PczaYEYWLGiYFGDlaS8wW1dZ3weHOp2n7gkOCFaiYk5eH/SEefgs6lsR5ioLuaKJ+oWdVvaTjp6zZ1B4PQd6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(36860700001)(336012)(426003)(26005)(82740400003)(356005)(47076005)(40460700003)(41300700001)(70586007)(316002)(8676002)(4326008)(8936002)(5660300002)(70206006)(54906003)(1076003)(86362001)(6916009)(4744005)(2906002)(2876002)(7696005)(478600001)(6666004)(40480700001)(81166007)(2616005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:43:37.1137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abcfee0c-e57e-4479-2fdb-08dbd001c208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5468
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <ilya.bakoulin@amd.com>,
 Krunoslav Kovac <krunoslav.kovac@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why]
LUT params are not cleared after setting blend TF, which can lead to
same params being used for the shaper, if the shaper func is bypassed.

[How]
Set lut_params to NULL after program_1dlut.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index e837554b8a28..1b9f21fd4f17 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -494,6 +494,7 @@ bool dcn32_set_mcm_luts(
 		}
 	}
 	result = mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
+	lut_params = NULL;
 
 	// Shaper
 	if (plane_state->in_shaper_func) {
-- 
2.34.1

