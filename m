Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB7CE8383B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 21:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C2E10E3EC;
	Mon, 16 Feb 2026 21:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AlJKMziZ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F8F10E3EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 21:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFalBMwSD8WYjyRs9HQygKg18n9dssvAx6NfgHLs+2wXgjG7XxwOTz2kMb1A/BtTvtX/t54P0IwTE9/Qo8e+oEY9R33hiE1JGsbVtYFl+W/H9Q7XlXAc3wKG0fQj3LDdg5gWvzpQe+x3yLJBGqQkcfqGzrLFrItPfTyK5/C5e2ht0bvRMh2xXpQ1/iiRUh0eFwsFYnTqPL31b9wciWVk5nYLHwobeC32cJGZPzzJblcL1KYnNtuqXIe+A5nxgnG6pRx2LLgcoW9pEL+Zf3cHP9q6PMtOqOJEUvYxFOb8qAeAKRl+ch7AUGn7v6nOj/JX7O71U55J4KRLcJC+ilJSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySpmpPP1mnL5000YzPjUKFp3X6sv96X50P4/heEdekY=;
 b=ZrSiEII7BLbyJ9B3hykVym9q9Yla2HBgPPQXe/IOrDr8j65lTxksFrETM9J2ZBwOvQkyT6rfIaUf97C1KXljRqqlJEWb/zR1RCNCYPjpf0D7naX6dOPuQqnq1Ho9r3Z+JUfn2/I+Nrn5f6JadwG2RnXb84VNOxdDhDWLwODCTb9fKcq+OJACDiZwnCHQziQ65h/iDXrE2H8+zCImjbSlB8kap8cAgnZRhCJIZpLMw9Iae/DJGYWWFw/gS5ziHL0bAuiRaylQFDh0CTxe11xCW8XBdSpbC/25QGSYdqnJchxtg8ugiYNWVialDUH1xL3Pg4EV1R59C+sMYm27mDZxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySpmpPP1mnL5000YzPjUKFp3X6sv96X50P4/heEdekY=;
 b=AlJKMziZbvn4pZO9GBIcD1mYJx44Rp+7AMT7ejKj2gbkH+kPZiPlLlYCuMWf/zBqO55Qg9yOBMVRbhxd7Zc+RU43gHizT+PkkjLLTXexF7SmqEXm5NZpBeabHIMBByhN/6b7bUAAt8CAoILjdNAthvtrcvbMTwv4f52OO+dWsaQ=
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.15; Mon, 16 Feb 2026 21:13:55 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::ca) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 21:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 21:13:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 16 Feb
 2026 15:13:53 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Feb
 2026 15:13:52 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 15:13:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 7/8] drm/amdgpu/cs: return -ETIME for guilty contexts
Date: Mon, 16 Feb 2026 16:13:39 -0500
Message-ID: <20260216211340.16364-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216211340.16364-1-alexander.deucher@amd.com>
References: <20260216211340.16364-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b7fa03-215b-43f2-c000-08de6da04ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vVHlLvGBt5Sep1hDMh1Hi27ctyE2YKxd/GU8Ihsk1/Gt5wQkFnaWCmKwG/Du?=
 =?us-ascii?Q?sCD+eqWlbFwLR1T92ZrUEdP1YKdUfa6RMgHgMyyy07ljBuRWXR6T39Bce3SY?=
 =?us-ascii?Q?KI41TPAju010eFdb5T0BoNqmZwoLAHOnADQSqOZ3eT+1+VgOutsjrn3dujiJ?=
 =?us-ascii?Q?nrnoomXCHaalGT5ZU5vBrUtqhg8WEoN7aGylJ8vPlHBLm5SW7kj1uiSbCg6D?=
 =?us-ascii?Q?0P2PluGey7HXfKrsoUksx+jCGLYoGFJrb37GKzea7eaod9Jn+Hnh0n8UQE1F?=
 =?us-ascii?Q?IE6gE6NFxY5wG0HvGZetuUPG7zlRWbDQn3Zlo7OKneOnNHblXVPyEY/SMCaG?=
 =?us-ascii?Q?KRxlVnGxIirRz4/cvoqkCwTx2Vo1si16GbbeNs6O3k9nIIXiZ6oAkCB5Nl30?=
 =?us-ascii?Q?BGlPudqG/EQCxSzNjVuFH4Wm23pa3tCVBOTBGo7q58+p151nvG/lReDFlUHz?=
 =?us-ascii?Q?BSnQBZ7zrCtINKB5SAk+GkInbvanGMnxAPaKCxwgZz73g9yjftwjUwsPC9/d?=
 =?us-ascii?Q?WI69knZP3CbNHMZqzz9EajRjwzolX8dXNgGNAycL69xVd6Ld2WsP3ggW9G/z?=
 =?us-ascii?Q?wzCK2ndrMpHZhNCjtoY6S5xRc/g6d6avxs719IEfeVhCWqtTr7GOXMAeeuxS?=
 =?us-ascii?Q?MWxvzGcmNNhOMV78h/JhA1U0u7s+h/oYR7O59LvBHGIV+eFTCXYes8QDdwb3?=
 =?us-ascii?Q?ES1Cty9ynmSoBJbSFxzzBiUsl2mdeL/flM2g+eRRqxlhzHq74KC9tWC405Ii?=
 =?us-ascii?Q?/HqrW8d1EzQMuQFvM1TwMEYwJwR4Qblm9MwvkyJHlDvktNCwGowdDKLd4ZcF?=
 =?us-ascii?Q?4+NKv9Tz8en6SYJ6b0Wzb7nQYgO0NOqqq8FevetZMjgr1WGTU0Ht1Alfntlm?=
 =?us-ascii?Q?hLveB41K/gUIv5/ReSiK8+45WyM1VfyT4azmb8jYYkT6FORqHawIGTCt/epi?=
 =?us-ascii?Q?355OIpVTchCWzEu+UTkOggpR9H0apviFX9G85yNHYPQkE7Ji+fnrQ/+a6qb3?=
 =?us-ascii?Q?pxDo+L17pFFb9eS6SVwj8k2dPFKQxcgl99duk3j1Rsvh26KTo5OfkpJ78kWE?=
 =?us-ascii?Q?Oa037VNM00bNqrKmPcp/tLZelwcO9FsbmpdHVr1SEsDt7GX4AoNLCUa4fuoK?=
 =?us-ascii?Q?HrKtBx+I/xo+MG0YaxcWGTId+KC4xUkca14vNbdoSRR5zTxr7W0M5WYvQ53Y?=
 =?us-ascii?Q?EAKwDuHwrZRVUvSWQybTAECDtgyrka6uJFK6AdGv6JTa8lwcqCMgvD6SOwVs?=
 =?us-ascii?Q?+Z7pP1q8ceaj/hRBDnFFR+LA7Uj4oVo2wE8/BVre0YiW4E2NEgRAxsBU0749?=
 =?us-ascii?Q?huSa3o0fy02xFfgudxQEIFRGWbeDJZ/EK+3nuSfX4WgWi1DvJsv8qno6zqf2?=
 =?us-ascii?Q?kY1qk7DxINJr0KVygjSyuaVRF6VdyoCWoad4lyB8ck+Cudvpq4Szy8/VB97C?=
 =?us-ascii?Q?ocrXG630bNQvwseF23Fo0Jka5EaJsJNIHZtJJSpelZPidyG1OAwmz9cwfUWB?=
 =?us-ascii?Q?58C5LNLYNtjYRkNceh7ylmBlClUhEKWL1ul7dJDbHKJERhtux1+8awipVOED?=
 =?us-ascii?Q?1Ikvp+2cPRHBO3hMMxZI2y6XyKG7uWdEfUwxmtIZrVMqHQCdrPeZ5FW7V7kp?=
 =?us-ascii?Q?3rO3bxMiSeOsjIHjuqZsL1uP11RsfVqHDo5k2TGewMzRhg21iWQ9s3myst76?=
 =?us-ascii?Q?Pk5wsw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qQJb0ad6BtzxbAMgwTcGDQkYQuE/DqFEL2SkoVTeJ3T8gT+4uM00DGKMPC1yI2A4v50L3gG3aChN6M84Zj4QqU/l+Zm6I3c+H9BS9AboHdFMSfWFT9NRrEUp+fI/3GmbpL3Uqf1/Yx6yMDaTw94elHQGfTWDNj84H2v3oRZWrVXh0/Z8TI4U9Cq+ViR+0T29ieDYDa/Qu1T5I45SctajJpRCAkNGt8hEBYEBZKJwUsQqurbzt8J6drBqrQJq47j3WsfM3QNOeDo43LAVeHbM84a0lTbzeg4xkJi0qEqe1LoUlNRBi29HoRko320Hde9R+3XRoLqh2ouRB0vxjj1hZVAOO8Vnv4OAtFWfj51Hmf5yqKUkqRE6lxIY1Ns9o3olOviArHSRkRuV7RLA+MhxZ4koG7V3yh10eSR2E/BianK3b5T34REV9nWfYYhKwxD9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 21:13:55.0331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b7fa03-215b-43f2-c000-08de6da04ad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
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

Return -ETIME rather than -ECANCELED for guilty contexts.
Userspace only considers contexts to be guilty if they
return -ETIME.  Returning -ECANCELED means the context was
innocent.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 6b494e4e8c0e9..564beb888abe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -62,7 +62,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 
 	if (atomic_read(&p->ctx->guilty)) {
 		amdgpu_ctx_put(p->ctx);
-		return -ECANCELED;
+		return -ETIME;
 	}
 
 	amdgpu_sync_create(&p->sync);
-- 
2.53.0

