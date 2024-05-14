Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973DCC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 04:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24AE310E10A;
	Tue, 14 May 2024 04:13:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J8XujF7l";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC56310E10A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 04:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIuO8TCMCzqKlZVKO37jl5IW2V9dAnAEhUSMMRRipmcdTVkVJkXGwA4xHBcTHKKTa3vuR16BM6opjwBhf2+PfZPw+i19XSCmwVw96ZYFtqutoMG0X9gr7C9wW/8pqrFPdJAyJlNDBQAEFrTpAio16gKmU0FgTAYEf7fmNCL6gfxSW8SudfuOA08W0ZINktMIqAxVnLh3wg/N4q0CYxZF8ybzHTtP9sma4ObjpaBfdavM6WzYWlkTxXcumGtSVfky93BE6VMhsQfuKTXtbvjkHh3/JNCeewdHTXv9D3dQtchA5A+y7ixHB20gKmnHaCsfM+Fenml5SoX36jXt2u6eMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzocFVYgv+2stuY/ELDAo+Gt4qKKynYUyN70CLGKlc0=;
 b=Ge34ihAmzrKOOOgW6icpifQJP81FoN7Utd4Z5WaE9xMheekYjeydWCsN/CjCwhitIawB0jV07topihKNJrjUmkHwrNZCNpetS789NIGwYWSWRUMkLAx4aOwcln+RksQ9ad1AaUV/q9iVCQYZl/0PMoL/XyC0bCWVbN9ZO/p0g8O8uRMOfVkqenEAKrHShDhiNhc446p+75L9/810tZAONvcRA8iOILHiEMDcd3b64VgdPHbvB0fIJsINb5sgJIl+Z59z81RGz+P8FuhPTkuAtgk2FG7QcQJhrXe71shW45/CfZCY4g9sx34JEUybiclTrO/OK+HtRnhLezj81z0I7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzocFVYgv+2stuY/ELDAo+Gt4qKKynYUyN70CLGKlc0=;
 b=J8XujF7lJ7Xaj+roZUfPpnSnd1TObyga/5xhmedOOBV4L3/y/+k8pyGP7C+fnIa2jaC1Wxw+SnKe9SL2+zzOwBJm+fzs7V09bYXMTZScBaNjHXKv+1sBJ97X5nZ2QxJHCzJuVNKu7FzpW7Y4NktW0zfTyjHTgh2fOSFA6+OeqNY=
Received: from CH0P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::33)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 04:13:19 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::94) by CH0P223CA0015.outlook.office365.com
 (2603:10b6:610:116::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 04:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 04:13:18 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 23:13:16 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, <lijo.lazar@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Drop hard-code value of usTMax
Date: Tue, 14 May 2024 12:13:03 +0800
Message-ID: <20240514041303.605558-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: bae29d9e-56d6-4f4f-9926-08dc73cc2f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HZ4DkHaU8YfRzib8aWnkOYOgyNIWPKfgyD9aCRVYHrX6vla8EzBqQ27nW/G4?=
 =?us-ascii?Q?B9CgWl35LxiaXlmE9IDtTUQPp1kMi8OIXHU2BHJ9y7NXorOzFcuzUe/B3Kff?=
 =?us-ascii?Q?G6ap8xGFqSYLW2jq0UG+dUiHidtGZTKSTWN67FNizdNCzmdoJlRQsv/7R2wg?=
 =?us-ascii?Q?6ujCEzjkd3YASm0oejk9D1FzUAExVrDYRvek91zI0ZGCPQaLQ2+yILmNL/ZD?=
 =?us-ascii?Q?ABKe8kZy1jwXLXhR8NKic1Tz48XMm6gzzGzaBFVRR2udjAA5USgITEUigvYt?=
 =?us-ascii?Q?vnwrgs21mQhhmHi+nn6mO3J/Aa9Lhf4m+P6r8rvhBwWJroRk4HLsuP/LWlaV?=
 =?us-ascii?Q?h0mPjDmKajLh8EVXMWeWeojrUKSgYxANvEFy5s/fxiT+mOnxN1SQqh3f6Rp7?=
 =?us-ascii?Q?WKzXLSCmJXyk5EJEOEfFcjdTwV3x+UOG8PM5RY5DmVJ54Klf/hSUKQXXZHz1?=
 =?us-ascii?Q?d2UOrO0Zgjvhmn24Igs0kXf897+7Od/tjrZCQ81yICLxnYbMU9xPMzCAQS16?=
 =?us-ascii?Q?/qUIPz083ejfsX6ru3btXaIeP3TBmewiLMU1RNPU/JS7QGbWQkJT6ZEiXFUc?=
 =?us-ascii?Q?o8tFd42BGfEDqe6p9Uw7f6/ah0CTKCYNLckZUTO5l4Gvr4jpx9vG6NHuX/B2?=
 =?us-ascii?Q?5LH+thAE7HS0oywi1VxvDITRgi1U10fek7k1rUKcqSWWVduz83HjRNawRhh9?=
 =?us-ascii?Q?rCuDNDcwYhL5HCnfxCk5DmE6jwKBzmud2IeyDqf7hv6rD0wY0oYdEBBbtr57?=
 =?us-ascii?Q?wP3cRSALZ9YQ0En0N2VfjneqfxabY2QHVRS5F3I9m9RA3AIijRfny3mm/GBy?=
 =?us-ascii?Q?liCuZHSTytMi0hyp8Ip0tb2Jf2u1AshBS9iN+PMhXZOP/gTJ7iUAT236ndeE?=
 =?us-ascii?Q?6eCi/PwjsmJr7brbkFHHsnpLbADBSQXAMiYqBC2sPZ90+2fjUg/I9wcHlfOM?=
 =?us-ascii?Q?vF+28Uomg+eKufp7/MEY//ZD3MRW+8TBjHS3S3yKJiY08pqnf6vEr9pwYGoK?=
 =?us-ascii?Q?D/zK94OGQIOhbgeWdF4Qm3VTgXETXSE5tN5ZtD4xSpTIXDhQvxVk0wqtBi1b?=
 =?us-ascii?Q?njMgmWKFjjmkDC/Ox7g/2p2zG7kXJB8xgBq/O7YQStuECNQkNWEqM4EONsoQ?=
 =?us-ascii?Q?ju51nRfQ3L65f0Zq3VFSnLn4fLSH/x68OnhNVvsxkVdPoySE1dxrooONlsOj?=
 =?us-ascii?Q?WdysrtqHZSo7GdC9CENfjhh687FFBqQsqPY5r4b5irTyEgk1qP0Zjq+m+BeY?=
 =?us-ascii?Q?xMYN6sq7Xh5o6zxUFano8JaRLYxFIMwiiz/eLxhHTyIm5CzN8uVZzu2vIwnp?=
 =?us-ascii?Q?w2pQlqenbf6XJ/KgtXb/ZGQTX4uyJCINr9oOUpOdD971B5kq/kDGOJH8YQnQ?=
 =?us-ascii?Q?CexUCpgdi0Vkf/x0IrKb11/Izxgw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 04:13:18.7776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae29d9e-56d6-4f4f-9926-08dc73cc2f94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
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

Drop hard-code value of nsTmax because we read this
value from fantable below.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 17882f8dfdd3..6cfef1b295ab 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -977,8 +977,6 @@ static int init_thermal_controller(
 			= le16_to_cpu(tonga_fan_table->usPWMMed);
 		hwmgr->thermal_controller.advanceFanControlParameters.usPWMHigh
 			= le16_to_cpu(tonga_fan_table->usPWMHigh);
-		hwmgr->thermal_controller.advanceFanControlParameters.usTMax
-			= 10900;                  /* hard coded */
 		hwmgr->thermal_controller.advanceFanControlParameters.usTMax
 			= le16_to_cpu(tonga_fan_table->usTMax);
 		hwmgr->thermal_controller.advanceFanControlParameters.ucFanControlMode
-- 
2.34.1

