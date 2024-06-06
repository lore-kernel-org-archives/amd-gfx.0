Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E74C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C1B10EAE8;
	Thu,  6 Jun 2024 21:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M18ytKoA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E733E10EAE8
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfKFnPd+VWabVvF9oXD0J5l3J7X3tvMj38Nt/ISoJ+FSeTMJdq9sONEIgvKexiBvKPmpB5B0KQS+5gp/cKbfVdEOjsxaf2/F4wVjcQt5i5ZartmwpOKZ30Cu4MfbEB9FaqOKKDowGE9a2fHbh72nZvCk7KZGnJvxQzpd8UuJ3Eqh/oilefwNOXmBAapx85fXO3Mjxf3G4rv++64qgzfdPmVnz2ulMHJaFo96hsKLjKMxHQlpgVoPnqbJa1Z/E7M6aCoXjGswpgfehn3Z7kFxGxerLJuNy3bh/fzXvXB/xyZW4C7XAnm+R1QIRF/E6vXCEHJEH3jEIFA2feHk7ZvGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qmRdHT/s9GXc+CrHfZDItD065yIlTlEEbNkp5yQphs=;
 b=bT91gPi7TFjKKAnGxNt6uiNfUTmktf5SHaiMejFoV0eZ+4hQsBsRiMmuCrj7Z15DhnHK5M8AyuWTcDcJk5AIzlo6vOjDjw8zSMShvyl6b4eHj8QM4n6RqrZNGrsKCf1ROl6PY4yx/3hDaN9bt+5hH9XqE973Nb2WQh1u9vZS2wQi+jr2DOWWOTVsc/8rIHNNA7IV5OEkwzkyiELVMFPhlw/2x+dLdrqVuZOKRUnMorvJ+6D1MlTXweMz40TrJC1Tg/pQR26rmvkAWfGhri6+jDeMk9QST6YDbhHUksuTALHThWfw06UzffUrUSbJZfAPQYZN/SOW2rpIIQ5A1oymwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qmRdHT/s9GXc+CrHfZDItD065yIlTlEEbNkp5yQphs=;
 b=M18ytKoAUA8vqQwFArm0XHnfVrr6Dj+3ydByzAudV1+/MUs1+gnI9tOEROznNpwd/5CaWt08TdkpHd4533gPgcdkTYK+Eq/T6kG6WyJYVzix44YzpA5U302URnWhJyZdNyix0uTiRvInx+1BvWiN79DXUXiRDovkYxWpHvfIMTI=
Received: from MN2PR15CA0055.namprd15.prod.outlook.com (2603:10b6:208:237::24)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:57:49 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::16) by MN2PR15CA0055.outlook.office365.com
 (2603:10b6:208:237::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:48 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:45 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 33/67] drm/amd/display: Defer the setting of link hpd status
 for usb4/tbt
Date: Thu, 6 Jun 2024 17:55:58 -0400
Message-ID: <20240606215632.4061204-34-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a2bf59-0e23-4fd8-ca6b-08dc8673b4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s5jK0HpRW5EY3QJn78aevuBTzjaqJX0O17CvHWeLGE2kTZYr1eP6dO6AHn1F?=
 =?us-ascii?Q?+nH3VFTjIIa+m2rpr6jym7m8AiZlBkkaw481ofS+ZI5eth1IHc24PgTaGeml?=
 =?us-ascii?Q?EGphE9GPqSfKLK07HMLOrZ6BVufUuhsVEM9xmV4HH1noJYH0HwE33lfdgAWZ?=
 =?us-ascii?Q?HIGAvTlCI/L2byqak7/Xhb6Hp4UT56Q6+VFJMgX1dtL1DCqINqziE6amDUUX?=
 =?us-ascii?Q?27m19nU42RdRHUx44lyS0Acd9Nz0KPHkiWtPZjfTLf+tnAVfI/6rrsft28GH?=
 =?us-ascii?Q?B4R+JTh3JpfAOT0fqnvPHC3FtMJxSlPcmtltd1q8Jm6P99GfSbccrbUm8BzJ?=
 =?us-ascii?Q?So6I3cn5ki/Q6qu5YbCbQM5hB07bKNmnJ0rR9wLdaXzDdS4P1vxbSL9YceqU?=
 =?us-ascii?Q?5u0GqTm03MRWAftqLiFulx8YiHf1ht3T3Nk3Di5Z8peiIi08g9EfU364xPC/?=
 =?us-ascii?Q?9V6FseA0KjpT6gYkfEOkNI0leCkxU4pOs1yEt2efKx6Af+6opfdAdgFABPhv?=
 =?us-ascii?Q?PQxvxWCvY30AVY1WTi8WUUgwjGI2uB8PkHJqi0X502jaWKAluz/x9Zd+FkEz?=
 =?us-ascii?Q?XID5FJrJqJV0Ad5MMm9dUL7s105LsAq0sVpgrYFAXP31Hvz7XZ9+f9oj4HiT?=
 =?us-ascii?Q?GlezhH4fum003dY4R6bBf8an15Y6z2ah+ODbjZsxR5G6C7pWpOvico1iy53H?=
 =?us-ascii?Q?iV4w+0r7Jm8LycFO4n0MffzETKNndG/J8hL2FkNvEhD7klIFpPSXkb+pcO6X?=
 =?us-ascii?Q?rVhb+m90u9V2VX2IeW+Kkf8XkrfGaiCmUMpgTqx44JSsWQqyTtj9KmL6gWQ1?=
 =?us-ascii?Q?feK7VDSk9OPig2k2PcvOlEAjsmszIZArKW7RolqxOAGvxI/a10E5flq2+mI6?=
 =?us-ascii?Q?njV/vrLuHO4ncE6QQnuKmd/hlI9uBEU22qeEQts7RakQVkjToYAAzdRMx5CM?=
 =?us-ascii?Q?yJA2zK69Um444U4sJNgKYUa3Naw8FByJAop2d8EEz1SafvmbGpZd5fEEyd/k?=
 =?us-ascii?Q?gD/IN6E6/DBMHjvoE+0QgNaCcUGfDOVct7DF4JgqUKDylE7XCraO0Zfi2e1R?=
 =?us-ascii?Q?tXs8QQJILoniSWb/dIV7Jce8n+yRXvf9fg1dgvt7rCbO7j1mY8fOh2kbkf+q?=
 =?us-ascii?Q?wTM6whPhs6PCCI7h7EeSEhwAZ1do8YG9VDe8tFjijyrbC5JPBLoUQFMiGHxv?=
 =?us-ascii?Q?RYw5PMC3ufSCcjlw0DdOEigBkUaoVY1wY0cCierIahAdDsgy6jWlDkjob9YA?=
 =?us-ascii?Q?3SCCoLhXyR7qOhf+JF3YiVK7ghpoUKp4fiwceYg27PiQRGqXGwobBXiHBB7y?=
 =?us-ascii?Q?30+gX+H6kiDqGa99/HCx8upNAZSpMLn4HOe96AnEeoYvZ96a3rgcdBkXQiel?=
 =?us-ascii?Q?dgMCcVtzbrh1EEuHAz5ZcSOKLPilhXAijWJueHKTDfe+wkYBPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:48.9595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a2bf59-0e23-4fd8-ca6b-08dc8673b4aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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

From: Wayne Lin <wayne.lin@amd.com>

[Why & How]
Link hpd status is set during link detection process via dpia_query_hpd_status(),
doesn't need to explicitly set it during outbox irq. Remove it.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 52fbd5ec7f8d..9e9ec74b27b0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -862,7 +862,6 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	struct dmcub_trace_buf_entry entry = { 0 };
 	u32 count = 0;
 	struct dmub_hpd_work *dmub_hpd_wrk;
-	struct dc_link *plink = NULL;
 	static const char *const event_type[] = {
 		"NO_DATA",
 		"AUX_REPLY",
@@ -918,13 +917,6 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 				}
 				INIT_WORK(&dmub_hpd_wrk->handle_hpd_work, dm_handle_hpd_work);
 				dmub_hpd_wrk->adev = adev;
-				if (notify.type == DMUB_NOTIFICATION_HPD) {
-					plink = adev->dm.dc->links[notify.link_index];
-					if (plink) {
-						plink->hpd_status =
-							notify.hpd_status == DP_HPD_PLUG;
-					}
-				}
 				queue_work(adev->dm.delayed_hpd_wq, &dmub_hpd_wrk->handle_hpd_work);
 			} else {
 				dm->dmub_callback[notify.type](adev, &notify);
-- 
2.34.1

