Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27413CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A3010E5C8;
	Tue,  2 Sep 2025 08:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pgjCdXPj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B891710E1B1
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFWhEq39moOUezr24M3k3fk/xwHtTlTgTqlyV8ktW8yKmlB/BnuuSEcFuR2MY6guWgcoeYm9VeQ4h4y/rhoz/k9FSwQqezcliETNFmVNRAHT6vStCUVsPVR7TLeAPke4hLyL/rAqywvITk8bjIZ4yWBiTaPeXEvgzXnb2+dlxIIsILaAWgHFakyw1pH/46aDejnZyQqvC/3M++LjdmW9Qr/OKpi+1CNsc9zkB8iRwjQ8mVnZwaOMql3urOAceQpIHO6mh7mR2eZ3H4NJdA7CrKC7v24jRPqIKQHOm66w5fLG4qi9JAQDt4r3o4u+BAcry7jZwSXNxCngNg+ZyAn8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=LHJ4FGaKTPP2UD9tu95nnBM87bGYwzDWiWN4JQwO2pDQ1xF3AxMDwoYI1aTqiidaI9P0CPd3bzUDyvYjQ5HzlTO59kTawTK7DwW4CVmsxY2mhH/zudelEXUxwJ1nPQglJR73CSPZYrkBxAF6ml5rlvhERDpO+zh8ay78Wlt4qlVOlJ5uRqOzxbasVqCCQ33NwVepMI2pk1CUcb7cOLvy4nkkKqv/sk2a8bYodb0CZONH31hozquB1Ebl2q9vFtVvWqOB8Qoq13BP0q+3t82PME87bqF/j2b+Wd4h0YIEYXDMUS42nQTKbfhySE3yDMoW0JM482DjiQe6ETBsVMAvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=pgjCdXPjCSYbdc19I8drnkBPuYB68XrEzfTWqp5XK5/fqdfMEkFfvlFSMRj3NvyZcLz/wH3SRznb5uNeFhyjEIY58/WLPUFPIhwqu1Q1Tq7GZwOGMm8n81FKl77EpqZ4JjoQTTryoZQHtJG7E+nkfjt3MCBoWEC0ATCBmMxjw94=
Received: from BN8PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:94::42)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Tue, 2 Sep
 2025 08:07:20 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::de) by BN8PR03CA0029.outlook.office365.com
 (2603:10b6:408:94::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 08:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:07:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:07:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 01:07:19 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 2 Sep 2025 03:07:13 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v13 01/11] drm/amdgpu: Add preempt and restore callbacks to userq
 funcs
Date: Tue, 2 Sep 2025 16:04:02 +0800
Message-ID: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: b40cd041-cc40-4271-818b-08dde9f7bd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WKGxl+upr/pzFwNLgIjanQdHIeYiDMaFrIbiHOMaTDKCitK27WWlnzHgeWnT?=
 =?us-ascii?Q?V0+JJmH1I9oKMF2qxYiR7ocESMdHWcA7ULsGK6E5aTQfUvVVCtLD7TBLtCCx?=
 =?us-ascii?Q?pnWpMf/5NWYEFbZtQpgotX4+lVvkujwI1OvygFhpizsTh8nWa9iajwsrDTfV?=
 =?us-ascii?Q?67pCHihueAaaySqeseZmthhMiRFljoKTBKTSdg/7RLS8LWTSPZ0TO8/siEmd?=
 =?us-ascii?Q?kCLogr5Ml/1qd+Zi02zED/d5tyBEPjztBDyi1WhQF/bwcpO26k7duYtdd6HY?=
 =?us-ascii?Q?+fgMJQVZ7sZv4LKI4gs8eIz77MjyYA1qlgOkh+S/jUFla0iO1WFQORVLdkNC?=
 =?us-ascii?Q?ouVqSdOjbhkDVJsadlwiFVyHqMdIL5nqdLodORyr8ySUWqEGPLk6xb1W9LMG?=
 =?us-ascii?Q?0fCznuKf5FGHimvxQ0QVGPY72+XSVqw2NfWYNfqM1KqhLZ2HM+yzFkh0fROt?=
 =?us-ascii?Q?DyW845MOxFZq0TaqeWzcJNKh6FVr6YDJ8zxKRJEKlBXgvPVpAKi9tzpOXEEm?=
 =?us-ascii?Q?gbbIWmkf41sT6pCTNdaWZ4loOCMVFdNdiRz4QtmXsEUtEo+9Ge3C1pE8Bsqh?=
 =?us-ascii?Q?bCOj3ywzFxuIFGdqbT+FFxYOHQf7iC1MuFnnLgQxaoe6NdgjpuGuH67Bj1xl?=
 =?us-ascii?Q?PO1z53aSoyUoc5sAnEGY33wFKzoWEvKQkDj6OD7M+q9dBvd95THGwNfeElVz?=
 =?us-ascii?Q?REraYFDsg4mDa+skyEQYPyt31Kck5NSAUWFilFRLjbmNjAjALlv0ZUmyKvWv?=
 =?us-ascii?Q?Z8bLF/5+pS/2iyRliuHfkNr4xap/CoozFj8fII7L7ZCmOHeYt2emoLWp6KXD?=
 =?us-ascii?Q?bU/t97KlwQSlo54a5VAb6448UxbXtMFcw1pP7jP6MFr8iQ+Jgn56Mqw1JWsE?=
 =?us-ascii?Q?xNErNKgs2G4uIUxUCcCIrKZy7SC0354ydDozByZjYOETsiVYeQ1GOYvHF/1v?=
 =?us-ascii?Q?l0mmzTguG92kJd84v9mlC/h+ScUxKrEMqsxm6LNkHpCh8olU+0WQ7CiCzJyc?=
 =?us-ascii?Q?IN77B7UqaOWIQ3qve4fZZIBBWGSCVa3giJInlVSxbciUekR5nY5NSfkiOnUh?=
 =?us-ascii?Q?QepsWJfOKlTRwve39dDIvXcvMPAMCsg7vBlWr9Edko6HUDW42uvGY2Pg/q/O?=
 =?us-ascii?Q?uDMrms0MF0/x4dZsbfS0YA6FQpSeFTVYxrLuK3v13RZnHaPw5/jtI0Pyw5dK?=
 =?us-ascii?Q?Z0m7Se/CYhh9cyq1GtLIbuEf18GJCdWSCkETCE4w/Eu+KYuaVen6UG+dY4XV?=
 =?us-ascii?Q?4hVLg2Dgyk5BZm4QIApd2mvFFVnzUGdn4U/+TEBvgarZ0aXAPAeR6Mi4buJB?=
 =?us-ascii?Q?BUleYAv+GcbClpc2txqlCf/SCIcIQG0F14kcc/Mygct/vLF5KxdnbGBZep6Y?=
 =?us-ascii?Q?1hLgtVWzTzK895YjJDse0e9hRL/eptymLDDoTQS3HZcTF4dYfbm2j+McMbN+?=
 =?us-ascii?Q?O42EDeWuGQZpRuzVjcGTdSMRZ58hfYm/4nbOc7/BRWrXL78cAYFsPrIo2OEY?=
 =?us-ascii?Q?trUgxBjfkwrIHNJziBvlht7ltYAIxTOjpgo2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:07:20.2075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40cd041-cc40-4271-818b-08dde9f7bd88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
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

From: Alex Deucher <alexander.deucher@amd.com>

Add two new function pointers to struct amdgpu_userq_funcs:
- preempt: To handle preemption of user mode queues
- restore: To restore preempted user mode queues

These callbacks will allow the driver to properly manage queue
preemption and restoration when needed, such as during context
switching or priority changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..5111d7dce86f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,10 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*preempt)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
+	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

