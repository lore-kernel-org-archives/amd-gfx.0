Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99122CFC275
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 07:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD3110E528;
	Tue, 15 Oct 2024 07:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2/WktFIM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6AFE10E527
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 07:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jiqc269qm1n9DqwFcvQaXW3IlIv0tj0IsqhbpUrLr8HqwanP90ZFDuFe69K7AAZoG0dmLiXHD5ZTkzYmknezcgyMmE8lOunk2ikBJG8amxXRxaDcrfCRcAYGihLgK+kYSCSxp02obqHqWbtXVJxcHpUSgzkXjQawD2eg7AgOnmR08rDnefx7qXqlUmC2Bj8Xr/NhFk8JzTCZq6DhWRXCc330YB/JFydOF4uQT+akcoOmp1r6knf+lo1E6iCO+yqiMF6FymTepon2lY8KTrroMWhStQFupQWRzY01kyrBga5rI197NIgbve7KfDRISla4eUToRxWmJpCKwcIKq6x70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeqApCubutP+AIvYGxnY7tUk+x9k6haEZYHRRE4r7rg=;
 b=IlcfA/QY3G35I3O7alHlyVLGcRTktqY/4Qb5mcIn0TYsoeGV2nPWOVJe0YOy/dRVEWX8VHHY/c5GHvC+yXtFuRxx1mIxg6IkH/JPertsRocgPw1uYM04/lXxtWXNBoRpHVnqWoZRZDZxUsx5bSbQWDNknWHSXkj6bvFJd88egSREeJnxoxT5RmXFjdSY9ihDLRboXVyOgkTzBgxgUvfTmucLt6wp0Q60uV1e7SNrmool1agZDsS8K15DeZbeSlfq+cN+e7fr4V7ALZaWlZTIH8l+t9PNjMPnWA9KjqygsF9EAZW9MIVZVfH40CqoABaLgMiD9vANTqtD2G/HLyCqyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeqApCubutP+AIvYGxnY7tUk+x9k6haEZYHRRE4r7rg=;
 b=2/WktFIMsi3vbxWcvE971EuByh1R/vudrqgkpOvvyc44BdtVNLNACfTA9Xt6u5G8Y1ck9q4MkBokJgOOpVecjq2PeHVkYwQHHMwGKIW1OPu25r8d8Sar2FtPIrPWir7dXakrchdPK5lqfFrom2xGOrE0l4d6iLiKjDn8gMiwXvI=
Received: from BN9PR03CA0661.namprd03.prod.outlook.com (2603:10b6:408:10e::6)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Tue, 15 Oct
 2024 07:43:44 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::72) by BN9PR03CA0661.outlook.office365.com
 (2603:10b6:408:10e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 07:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 07:43:44 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 02:43:42 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4 07/09] drm/amdgpu: Add the missing error handling for
 xa_store() call
Date: Tue, 15 Oct 2024 13:13:07 +0530
Message-ID: <20241015074309.2484264-7-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: d390a6ce-60ae-465b-670f-08dceced1886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXI5T3hnK2lHU3VLOXhDTDhYT0JUemhuM1Y4T1JnYjJyK2txNkZMeGU1Z1Rj?=
 =?utf-8?B?WjB2ODB2cFlad1VTU3lTS2lIYStZUy9wcGQ5WkxkWUtwVG1nUjR0SjRWZFRl?=
 =?utf-8?B?a083TDBoRW5pMnpWSUdnbzFlUzA4RFdOSjY5SHhBeHg0WVRvRzJvc0RLQzcr?=
 =?utf-8?B?THlyOWJaNUZwNFFCZ2UrWjNqUTNqVW52WjllUHRGOHRFUDdnM0kxSXE4S3hP?=
 =?utf-8?B?QkhFOGpTTEowQ3R6QXYyQkt2aThzeDFiT3hOL09RRFpjbkZaRURrT1NUZ0RI?=
 =?utf-8?B?QVFaZWxFdjhINGVWbGdrTytZVVRYVUJnd1BsaldLdDduNEtDR3VWYnpVK1Fr?=
 =?utf-8?B?WXJ2dXNPam1BTGEvcDVxQk5wN3lVN1lzZzErMnhkNlFja2RGZHNWMWdUNVdj?=
 =?utf-8?B?clNOcklEMEs1Rm1ZV1ROc1l6YmdibzBncXRMNjFtVkZ2Y3VkaWpocE12WGpU?=
 =?utf-8?B?aXdvME14S0QzOU1qQnl5Mm1NT2Nlb3F4VlMwN0M5bmNsUUdxaWJhWFNGZ1Fo?=
 =?utf-8?B?dm9PS1JwK1VGcytoY01DQmVmaDR0WittUnQ2ZXVRT2libUZtZzEvS095VFp4?=
 =?utf-8?B?cWlkWnp5WTAzYUVXdlZSVjVMaDIrNWs2NkNEV3V2VVFiWWMvb1M2N1hBUURk?=
 =?utf-8?B?K1p6dlNrVUZkRHNZMFp3WmoyaXFBak1LNmdxUlpCQnI3WjFNOVNWY1pKQUNU?=
 =?utf-8?B?dVlKbHhOUXlXN3E0RnpZNDI4VEVFOVB4d01ZV0JFRVJHbzNRQWVRU1J3VXZq?=
 =?utf-8?B?OGdXaG1BQ21PL2hyR0t4Tlh3YmVzRE9vOXRzNzEyRjFTRlIzS1MxM0JCTGtC?=
 =?utf-8?B?OGczM2lSNWY2MlFjN1FNdS9SYjBnUkJ2aFI1Q0tPVW9HdzRrZjQ5ZzA0M3k2?=
 =?utf-8?B?ZTg4enNpVUwrKzZEdTNVVlBDZ1FVN0RidXE5OVVoeG1FS0tYR0dyK1QwS0Jx?=
 =?utf-8?B?K2Fxd1NyVy9JN240Y1dlTUFpYkw4QmZwYzRUYk1qY2JJeTk1aFpOOWM0Zm5H?=
 =?utf-8?B?Z3l6aU14M2gzeTJDbHl4QXdYQktFT2ZPSk5NL1NEMElXaVdBNXZqczA2SmtF?=
 =?utf-8?B?aU5Ga3dVZjdBK3RTWGVEUHh3aTVwbC9CMG1YZ1pqQ1R5VXg1dEhlUHBHR1lH?=
 =?utf-8?B?SjJib3I1WCt4OVQ3c1NjTEZuOEhjZ3hBU2ZZRmI0d1c2clNoUVQ4UWVnNnNZ?=
 =?utf-8?B?U2V4TFBIWHFZK1hIWjYra2tsVlh4WTVZTnVlKzhTRG51SGxFOGw5UmJVeXFs?=
 =?utf-8?B?SnhNcmhXUU1TRGpxNFQ5RWZLZVU2VGpqR0VQZFA3Tzh3U0lnZGJwWWxQdnBq?=
 =?utf-8?B?MC9ZU2Jnbi9zTzhvK0g3YlZiOGVPTU1jc2RjWGlzRHoyRmRlOUtUUEJGTXFL?=
 =?utf-8?B?a3FCdDROWFd2MEFVUXVvbzRjWkR1bDBoWjJWRTFJbWxmai9PK3crYWVhV2px?=
 =?utf-8?B?RGtkaWg1MEdlbUcyNERpR2pWTFJ1K1lNUG5OSnpTa2FUbFRNSm9ZdncrYmxn?=
 =?utf-8?B?Q1labldCRWNLTTRGbW4zbzFMNUdRMFAwRWYzalhXbFg4dnRSdWwvNW1Fd0Jy?=
 =?utf-8?B?OURVTGJROG9qYU9mNmNSWkJlemlSWVNqNUZrR2tuQUNFMWZuY0VkajZoZ0Q3?=
 =?utf-8?B?SWFmcVlIbXlWWm53Nnhxb2NDSE84Z2g5Ky9BMUhPNURheTNrRERwcUN3Zkc2?=
 =?utf-8?B?M2Z6WURRQzhoU20vNGtQYVlrM0dFRVJ0bUdsVzQycnUrYklPTnp2dkowL3Rk?=
 =?utf-8?B?bHkxNnN6bFBadEJ6ZlRwRFVBVUNUL2FBWXB0bnoyT2F2S2g3c2NXNlRHMUFn?=
 =?utf-8?B?M3dhblFKcDg5dnZrOThqT3lVRlBwUEpwaHJrbzE4ME12Vjh4NU0vM0wyVmFP?=
 =?utf-8?Q?M9my6mkvG1L/n?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:43:44.1227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d390a6ce-60ae-465b-670f-08dceced1886
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
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

Add the missing error handling for xa_store() call in the function
amdgpu_userq_fence_driver_alloc().

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index b6fcc04a23af..93f2656a37e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -102,9 +102,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	get_task_comm(fence_drv->timeline_name, current);
 
 	xa_lock_irqsave(&adev->userq_xa, flags);
-	__xa_store(&adev->userq_xa, userq->doorbell_index,
-		   fence_drv, GFP_KERNEL);
+	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
+			      fence_drv, GFP_KERNEL));
 	xa_unlock_irqrestore(&adev->userq_xa, flags);
+	if (r)
+		goto free_seq64;
 
 	userq->fence_drv = fence_drv;
 
-- 
2.34.1

