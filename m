Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1ACC3ABBC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 15:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B618910E6EC;
	Tue,  6 May 2025 15:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i8EUresA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F66510E6EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 15:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3GbYfP+CS3QIDFkfZwWt3Y3omEFDfpa7TNyilrwAQoPS84jehyieQIwhCiBBXEh/cD9Aj7dJ/FJlEbKKi04a8MgxgihMnpwVMXl3Wfo0wwFgSWKZTQ+fYJYMRVrXQz+SCot2l2AZyaERgrDda3+OTZySiWW6DevMlBzMnewSwX334zlhS4qin3uFKa1rsM6CMjmYdpEjwHIcvJtWSPqoXUww0pMng6gH6s0X+tptBHYPP/S+77bhfCliOhvLJkPCYyYJX30D2o9dNVTMErSPgNxeDMk4V4Gp88X3/JjWckpaVvtmBCUItphb+wHUJR9oW7qWrzCFjl0Q+Chzx/N3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WNNRzde4g3OKUf8p2eLR93KNWMkV7fhnB9YUKR/JYI=;
 b=g4cZMxQmnMgWEoL1WlY2M9WkgYrrFAVbi8uTnYJJj/20UsnQ7yMtI6O14tNk/PtWeQGUAt+FNQxT62oKXiw9iJyxhvX05EXlPHsf3GMmeKV65JQ5wE7Wk8OAH7U2UIsMPT4DhzjbcALstg2k/aBXfhvDn0oeGnHmntt0ysJOMOsq/kWmEx4iNK8WFVjXAepyGJ/1B0I3YqcgzwXaZUrq1f7kXyIsmHG/+t7iJ2YsULPYTudO+iCfN5/9FzBbeAcsR1ECKZJ/JC4p2rUu6JdQfYxcjNJ7GkhzX5MIAoh0c6H/27d4eBjYaDZHKfl/yyRh69FoUVHYMRf5pEjqCRXCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WNNRzde4g3OKUf8p2eLR93KNWMkV7fhnB9YUKR/JYI=;
 b=i8EUresAEdddFKV3XwUy013fhk+HWaDFlXVcp6oh4B4TdoEeQtKzXzLXzowEX68rt8d9gO1GcR7H4XhIfn7mdUd/dllDOPKpHD6rsg5x23smT75ppJGOzqdBNvWpKxV9IqS+/hkGywEukB5mBOHqcRWpAreh8xbdpeGF47cPslk=
Received: from BN9PR03CA0227.namprd03.prod.outlook.com (2603:10b6:408:f8::22)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 6 May
 2025 15:59:15 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::f3) by BN9PR03CA0227.outlook.office365.com
 (2603:10b6:408:f8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.32 via Frontend Transport; Tue,
 6 May 2025 15:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 15:59:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 10:59:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 2/7] drm/amdgpu/userq: add callback for reset
Date: Tue, 6 May 2025 11:58:54 -0400
Message-ID: <20250506155900.3866874-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506155900.3866874-1-alexander.deucher@amd.com>
References: <20250506155900.3866874-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f65e6c-5662-45d9-2b0e-08dd8cb6f39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RSsxTVpXRGdRSUVOODF2QTNUcEVrOHI2Yk5kMG9xUVNNTVRJZGc1N1lqVlUy?=
 =?utf-8?B?SUw1WWpBTHBrSVZocm1rbXNhTm8rbzhUTXg5YTBZd01JMkVycklCemhSVXU5?=
 =?utf-8?B?RVdiTHp5UnpaSjlnS3Z5S1RTVTR1VFFKSVdLNDhLaDJRMlU5aU5JcEpoMVNF?=
 =?utf-8?B?VUdRRzc1TTRHeE5QaWxjZklCNVVHTkxyZXpQOHJyeGhCaW1Fak9NaHdTbVNK?=
 =?utf-8?B?azlkQ0NyQWpBSnVLSU5PM3Q2ZHVkRmxaS2pwL3JJbEU3UVlMTUhXbGYyRHVW?=
 =?utf-8?B?dVFoK1AwdElpY0dDVEFFUTNjNkZPWXZiMzZ0dUFUSzlJa2xJR1NWS1NFVmZn?=
 =?utf-8?B?aVhoeVB0M2t6YTJJcXJiSXR5cEk4Q3JzT3JkUlViMG1TOFhDaG5MZjRFUFhH?=
 =?utf-8?B?dlU0cEJnS0dXSURsYmMwRVZVY1Jzc1R1NHVWbHplTTlXVlFPWWRpK1NIZ1VK?=
 =?utf-8?B?Wkp5aTg1UUF4SlNMT0krcWFiMERBdHRQdW9YWlZEZHd2UFJvNGFZdjc5cml6?=
 =?utf-8?B?Nm9kS0w0eDNNd2N3OFVuVHZINFh2MlBudWhRYjdzL2FkWEl6VEFvdDk4cnpI?=
 =?utf-8?B?WFJwR0kyZHgvZ1NONlFWUkpDL1JPSmZENHl2ZENEcFhTb095UmFSTWVVc0ND?=
 =?utf-8?B?UDlJNjkyeDVGeVRNakpheVRNc1pjT3gvQ1dpZ0NoNUdXVTY1STBYMTYrQjgv?=
 =?utf-8?B?Wi9JZldGd2pJSUQyUWhZZTBjdU1EdytJMkxvM3RPa2N2R0l3S1E4UURLeHVw?=
 =?utf-8?B?OVVHZzYvUVk0ME9iVWtFWTUyOXA1MEFkb0gxVGJCSEI1aU5BbHRJbXgwWGRP?=
 =?utf-8?B?Yk94QnFQelBuTmJ6OFFSUjdEMFk3NXViTE1oSmJ5emhKUWRLUU52eCtjUGMy?=
 =?utf-8?B?OTRLajhtQ2J6b2NvUzFESDlaQ3R5RkRiZDNxSzEvU3JEOEQwaVhpdWtFczdj?=
 =?utf-8?B?aFdmcm5sVjF1THVQUXZ3cFRVd2lndUY4M1RVMWRqbU05VUtEcWpSWlNITnBB?=
 =?utf-8?B?TjZZQWc4Y2x4VjhZVGtCOEpLanFOOTY2eUZ1M0E2L004SUtUeFZmMHd6QnFa?=
 =?utf-8?B?Q3lsWDZ4eUFWSTlBTkdrSWp6ajFqb0UvaFhiMHZaRVMyajgyMldXMXZzL3gw?=
 =?utf-8?B?ODJ1bTFVOUVON0FrQ0h0SDgvVHJtRDVDTEZ0cEFzMW9sVVh4OHNFMlB1T3A2?=
 =?utf-8?B?OG9uVkwxV0U1V013Q3dhTUEvUjdRc05sMnQ1anhXZ0dhMnFodUVNMjVJNjhn?=
 =?utf-8?B?VlhjUkMzZ0NsQnNvYVJkZGhpc0F0TVdPMFRvVGV3MmZWWWkySUIrQ3JLZU1w?=
 =?utf-8?B?OG9YZEcrbS9mbGpVVVJpQUpEdzdWTjR3dmNzZThGNDVseHdOMlNWbWhLQXhM?=
 =?utf-8?B?U2RXclo0c0JTQmJjWGZEa3k0alFBNVVHay9TcXBjaTVIbmpsNUY0ckZuSzJG?=
 =?utf-8?B?VG1rc0tFVVVnb01jVXlqZ2dOSjREanU0dXJMMy9ZZ0ZPOFdBK1I5bUlrU0Jo?=
 =?utf-8?B?d3RWR2RyNDRlcml2cURJWDhTZFZUQXBIZVRSMFBBdGxJVkJpcCtiOHFTVkxF?=
 =?utf-8?B?R0NZL25LUmJNdEwvRG5TYWtRNGFNbmF1MEJML0tKSEwvWG5SMDhLM3QwZE9y?=
 =?utf-8?B?dHliY0p3bjBqei9nK1NxWDZOZnU2N0RmWW5Gc0NneXVUaGttR2p5Nnk4b3Fa?=
 =?utf-8?B?ZDZ5RGpDbXBZaEcyS01yTXNmWU11M21PVWJWWmxGenhJbW1KajF5RVl6Rmha?=
 =?utf-8?B?WXNXQnlWVWtOUGJiazlVb2FsVWczLzNmS0NXUktCaDc0U1VhT3dudHpRSjBi?=
 =?utf-8?B?MEZ6Z3RqNmdodWJmTDI0ZGQzVHB2VFJpTmxGWFRodGR5UmZoa0E1WjhucGZZ?=
 =?utf-8?B?cmd4MTJXQ3Uya3JrUmI1YzhiKzdNUjRpQlFVNUdSTFIyMDFOZk9MWGkwa1Bl?=
 =?utf-8?B?bFFCMjk4dE5jdnRyNG5MMlc3aGFkRnVva2RrekNPaTg1VHI1dTNpVnRsdCs0?=
 =?utf-8?B?MmhSclJ5L3RFbWhTeVpSVVBuR1VLVzJmMG1pNmNvQVdNbFB5TDhmQjR0djh1?=
 =?utf-8?Q?cPWGdF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:59:15.5268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f65e6c-5662-45d9-2b0e-08dd8cb6f39f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
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

This is used to reset a queue.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9a..3cc0ad8919f42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,8 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*reset)(struct amdgpu_userq_mgr *uq_mgr,
+		     struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

