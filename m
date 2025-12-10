Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A66D3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1311910E665;
	Wed, 10 Dec 2025 07:12:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iL28+p9z";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2CA10E083
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCxx/ZISfy0DsfBUySUPgDLLOkqFq/uNhi3hzOk8FMAJ40UlqtWf0lKNDlpNpyePlwN/Cj7zVe7SRE0MKFBUaZA+uChzbv49Q7sIiaxwcc7rDqrHW/zB1qDXzC+jxwmbKEktJaNXBjkPWOTCo/KXucrj5Ng1lwBOqq/lvsXfoNDwxvbpMtcS8J4PasA+fxHy/IdgM6EsefVAuLHltqWTGbKa1/Tbm/ghm88g89+1IDhhaA1JQRahYexi1dzkSNLB3GkFtsGZo56xeyuhbOYM7WAkFyG6bPUkPOV0LHIEXHjTcySHCxtAgU3QTTIef0UWdMooPAR5ORwROguIetVB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwvjFhLfUEoCDAklU8ID4qmxg9ahIiF1YKkDZJoC+qM=;
 b=kXhJVwi9uo2O7WP9P48M/LkIelONk3Jt5bgFJCHZ42MbHU05KypCkWnzk40g0nsJtzojzB11I4Wmes2owxcO3lTKJQG4rI9BHhYb3pS7333xnWGW0DMP6/7nfgMIPp3pZevN0+2CDpT59HQ27Oc9zkg+I4MTnjMdJ0dpVnNNS4h0hnWcyBEE3CrcndxmpAlmhh5gN1UuJPyb0JPq/2Zivn8fhFds6nylN4aZTkkZAKfLHgt6wnakqbxT/UKJaziyas2b+MbrYM5qhS1IbK9flj6Tr3pIx1UzexZY79YjjXFcFzqgVl2Na1hbXvWnp7+CdlpYlwk0bgnw3LtXWwz4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwvjFhLfUEoCDAklU8ID4qmxg9ahIiF1YKkDZJoC+qM=;
 b=iL28+p9zx8+HOADfnXTwsWXADtD1lJJUBjSLtZTZtzxsK/c+ducsCPSaD5k/38T+wAUqX+Ftjc9siWJasiLuCje7umM/qojorKSU9rt0PRdc44vsAo8FIIJBbdsfAka1gDE7JqXn+WU+jD8qGIKc/AQli8Gm/cuqaNP+7d61gFs=
Received: from SJ0PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:33f::12)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 07:12:47 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::32) by SJ0PR05CA0037.outlook.office365.com
 (2603:10b6:a03:33f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 07:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 07:12:47 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:12:45 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/2] Revert "drm/amdgpu: add UAPI for user queue query status"
Date: Wed, 10 Dec 2025 15:12:35 +0800
Message-ID: <20251210071235.510182-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210071235.510182-1-Prike.Liang@amd.com>
References: <20251210071235.510182-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: d095848d-942f-49ac-af50-08de37bb85df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/rM5rTiFvc+p4PNEQNZBurfIOz9tkFmo5OuRxstD8aW0t7zb6sMn7Fh7J6S7?=
 =?us-ascii?Q?7iWAEsgI5ts3uefmRjrVsjQGpUaqm+CugkvbdDUW9kHKmFHwTOAImyxkwheb?=
 =?us-ascii?Q?r4UeIY39E6kEnF8oZpQMZ5CGbLBsPOM0LY8zWMuBrgDqjldVYC8kb18AuKph?=
 =?us-ascii?Q?Hj3nobGpuPPpxQXcLMrJFjdEelYsEGsByVicKsDfyahI2XNBr/hog7V0pvoB?=
 =?us-ascii?Q?rTQvi8JS6tk7JPVfN9qjxbSbNZZXBvucxZU4BxvdOZsAbqVqqlP74HMfjh/y?=
 =?us-ascii?Q?IMHAzQWvOsMmvi5/S8+L4l2L6YgZ9efN3fvIEeZ3zRIngARlt97mN7THneD5?=
 =?us-ascii?Q?Kar6qihEQXncU0RyPXuX3IfA82Ieecy3VqTQi6SjW8JL65U3rjTFhAV94pOR?=
 =?us-ascii?Q?iJ8/JFkW8cWyGekbaSrprYmYtTt0fxHu4b0w498edCh/jD0uVYr/TBI0x1RK?=
 =?us-ascii?Q?vMWIBAHqA0J44IgedJ1xAu7HEZytrsjekfFgMEACx9hYcVse6dJoVAk+ZnaY?=
 =?us-ascii?Q?skw+PdsxSkGL7tGOPqbNR+73ZYxH5ebQk/ARga6x7/wBqfnhufQ7WACD1V6B?=
 =?us-ascii?Q?J0bxFPqz3B3TIt14bBtu0qdIfuL2hGMeV9GOL0QWPIMCt7OjQSI64k5UNHSO?=
 =?us-ascii?Q?+zvQMFy89ebqb0l4S1JvleFfdr8zVbHcJeVRfSJ1swuILVkXrSYyE2iGQrtL?=
 =?us-ascii?Q?FMpg70uLZy9nsLHErBwmOjrkI8Pm3yP0lG4fyKVEJsNxV1kOES8WqpTcE28C?=
 =?us-ascii?Q?pjNm8f+ojXbry4FfJ0xv+jirUJ07JYcnezT+3v0s6ho6YsdvvMiPp1uC65IW?=
 =?us-ascii?Q?xCXO2qWRCbXcZP8tbuZipkTFi1oEuQq3Mt0yLdrzFlYsuZsby7/DCBes2KtX?=
 =?us-ascii?Q?58441VPw1HmjRTyo+W4Py5LRCVqk4Un/Ar+PwLotpDWSGqUo9TUy+eEf3A8S?=
 =?us-ascii?Q?zuT7z1ZS8rAec1Jr6V5CYK7L8YgfqtP9WTuKHExp+PGPH+/ex1vdStgHtwnI?=
 =?us-ascii?Q?eQrheDj6yKpfFnjRbNZo1QiI+nzTFg6Ik+FUK4lB04O8UVvNgvf/K2J+O9mk?=
 =?us-ascii?Q?SSj5ux9TRREeVmm+RF4pwyO/u3hBQuM+ag7PsyPeDt/Sw30m54JgIv8UtgYX?=
 =?us-ascii?Q?T7C1WknxWSwUrk5Gq0ZXUVGH5tTtJX6V8wpZJo61sl99p0boYUDjjnHBtOe3?=
 =?us-ascii?Q?FeDlPOGHHp58B5ebgn6rXzgDvqdWEEVeT9AzeazpXDNwWbtRFDdtjWx0E+6s?=
 =?us-ascii?Q?HT5KDxzCuNi08AlzhG/zF2MIO+dGSV743mVmmLIEN/kvO9UY9TJO1plI7UQ0?=
 =?us-ascii?Q?ZRL3PdYcUEBmcnoQ2DEqpiUkpQZ1jID1s+S3Kuf54OQsCWONqAeAy9Xz7tcN?=
 =?us-ascii?Q?cqqTqGwbGghHDWqq/4y8HYXJTbu7vFtgyvhE7J6bFxcnOcfTqX8fwGxKGliB?=
 =?us-ascii?Q?HZwxOTWHmXZWqt/IAXY/9odTcOZMz1pev0/Fr7S93rBwqqsxnk/578W66KPP?=
 =?us-ascii?Q?di63Kay6STvkd8W/YNhs44+nPd0x5BflgrjdUrSRgzvjN+U2PvhshU3nr08z?=
 =?us-ascii?Q?AdQd/LqceHK6UQnhdeE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:12:47.6262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d095848d-942f-49ac-af50-08de37bb85df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
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

This reverts commit cd4fcfed0dd7fb8d1eb2ec937ae1644534a307bd.

Hold this patch untill the mesa implements the AMDGPU_USERQ_OP_QUERY_STATUS.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 986672e7378c..c1336ed4ff75 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -334,7 +334,6 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
-#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -347,12 +346,6 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
-
-/* the queue is hung */
-#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
-/* indicate vram lost since queue was created */
-#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
-
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
@@ -434,16 +427,9 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 };
 
-/* The structure to carry output of userqueue ops */
-struct drm_amdgpu_userq_out_query_state {
-	__u32 flags;
-	__u32 _pad;
-};
-
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
-	struct drm_amdgpu_userq_out_query_state out_qs;
 };
 
 /* GFX V11 IP specific MQD parameters */
-- 
2.34.1

