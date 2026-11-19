Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D2606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p5MO2quw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39E881121C3;
	Thu, 19 Nov 2026 09:06:24 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013011.outbound.protection.outlook.com
 [40.93.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91631121C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 09:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+VhwJzWVw1CMsf0unNo47CEdJD5Y1IvTH9np1sSExBHqbWY181fbu+IAL9U2waLHnYIu0f7ACTK2xUafuP8FRD0oZqXjGrEkOWUlJcyefopB2fJMiMccUpCwiLb7VcPB9jaKyjcJhHu7AWzHxRDD2oSPdiajzT4foSDtFBw+PSFWTsiZ0nSj2BLVgHt3KsjMlFlUKitbfbK6qzMBG3hv0wm3Lprl9Xm8mCR2fx6WNQwzSrNB13wD6K/3M+kWlCt5iHmDBaZZuUtNLoLg2UcQ4EhhpyxMMD2o/i1pajouAsK3J1vmo4+GzpzBqx+5D7YtLPdKDKOQjBZFzYKdAWClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X0M6nYwnSRTLcmtMs4/Sl+lhd7CnN5K+IKAHd8+snU=;
 b=x0klYM/0domC/mKcnmd+mD8Ls6acAY+8/2yVsiGpUamyp3LZHw8PUoRGYVOue3r/LwMA4oQGeO9l/EVRYK2g9aBidGLuc+x5L/dYPPB37+ztFP2ReZESsLHtkSSHh9xo3O3jX7wddMpAQBk+VEfN2doHJNkOi9WQSTINFqGMrcvRnvMHZDQXNTflm05YPT9ZW7XVaD1WkrDg/ytyU4pMHu43yq3CjKNvF7XlLmvttLfRMIi9HtBdMJf7mvEHsMgX/BQOW6Z7cwtszoq51RB1LVdd4BFsGLu3ZnZj52w07DLWEbKZ9xNj2kqEA5gsbhDcW2t8epneXsJo/UD+saLmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X0M6nYwnSRTLcmtMs4/Sl+lhd7CnN5K+IKAHd8+snU=;
 b=p5MO2quww88uXj4ObawJUkY8V6QKoKEIrQPppTCvheyYxCST1SdYzz4zssIXM2HoTnCSNhE7jwBldOn1YJFJi7i3oLF1z/LKUeHf/KD7G130QskM5RFo5vkpCmskWXAQg8juA9h+AMkujEKAjyBRCLlOuQlkBPjNjaWqOqVSufo=
Received: from DS1PR04CA0011.namprd04.prod.outlook.com (2603:10b6:8:44f::14)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 09:06:14 +0000
Received: from DS4PEPF000001BF.namprd21.prod.outlook.com
 (2603:10b6:8:44f:cafe::27) by DS1PR04CA0011.outlook.office365.com
 (2603:10b6:8:44f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 09:06:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001BF.mail.protection.outlook.com (10.167.23.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Thu, 19 Nov 2026 09:06:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:06:13 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:06:11 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Jonathan.Kim@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v2 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Date: Thu, 19 Nov 2026 17:04:55 +0800
Message-ID: <20261119090557.3494649-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261119090557.3494649-1-Jesse.Zhang@amd.com>
References: <20261119090557.3494649-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001BF:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: eaee22a4-5fa3-4694-061a-08df461c5c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|5023799004|56012099006|11063799006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wSeN7PJ+1zuuec9CcCFKMXMyulz1D7ru24oEYNt/Tx/+lFsPQuMY9ieSIcqc7bXSDNGI8GP/4Y5GkrZeCos2kZoDntQ/HGzccj+QprFYwFoitH8pEC8S5IB3oSrdspyGyJC1lr2fjtxufgTyLWU7W7RMtpaL1PBueQdyA+o/dRyCncpCBwU02dBqepqQh2jAN7jIKvORpnMngGmaH2aM2wxou3/IrWDKlkgXeKxRMoJfcqt2vPnMci5oaiKfUy9x3vAbj0ia+cV0VuG/aTOgwj6Jz7IXnH5ybebXxrmp/0hvQ3pKonlm3HXMMdSQWNnwJm7mlUzx9grR9J2AN4xqTVl1mmT/KtprLuLaMZHf4bG0NX8L5JG9OQonqBFzzOzFRp0/7OQ1Mo7pgQxOSLJ4HzBdGTtSYR6mUbGwsI8kVOsWKPqTte2j6CSl9D0ApaMF93MLcV0NE8GoPx9TaC1oWJFau0P8g1w5aXiTq0ClsyAxSA/T0YszhVGa985d5GAsOdshdJx2/VY3z75H6TJyjCMBwXQqKxMjcZo/tywGMc47oD5bzfQKKjqEnnxfYC7O5Zc+VHLwfJP75CQ5zi5Kj56jcaESXQmWQPD3foD8PMrEGV7iaHLQNvLjsbyISGy2sLp/e0cdcCw1U5NQRI7Tcg7lH9/dzeFYI/1saiYRk6B8X7w2I8C0T6Ahe9tnKbP7/g0llRAByc6lnFrrAtbgyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(5023799004)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QSyzcqbDud2M49D6M/NZj7M2UCUZvWqY8Agr499nnTmh4F3JDcKjxJM4gIzL1rPpR5JTFNIt1UHZcyE7sVUTLSK1uT/4qKN0S4Rp0tfXB1vMQsRrPPZTd2a2BNYj5ObL/fzpnYqAHucMAe4bmDCgjK0BQYtAoRmSVtmkIZgMBSXbvQ2hqIY5sGhsEjXIBzu52FOw14UGC1KRssWxiwIpZDYXVnfj07mC3MhdPWmX1dED3g6wYCZfikVx4QQbCnBolDBBeoLIozWBDq4hvdihPMFC1XbdeG11FpihdjtdHc5BZwspWoPDZjQ6dOssrO+3PFbzZRtNn7b1bkj/z9Gjb5DK31Ki8S8PVtYAwzh1OjnhaUHmpV6i2g2ufEeHdTsxAsUt6UAJmVgqOTgJKyMsQaZ8OppZTvXFB4ddOOJhuDxiBCep5lN5bBNz6oF26UPW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:06:13.5844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaee22a4-5fa3-4694-061a-08df461c5c99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001BF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

KFD_IOC_DBG_TRAP_ENABLE stores the caller in target->debugger_process
before calling kfd_dbg_trap_enable(), and nothing resets it when that
fails (-EALREADY, -ENODEV, -EBUSY, -EBADF for a bad dbg_fd, -EFAULT).
The permission check at the top of kfd_ioctl_set_debug_trap() accepts
any caller equal to target->debugger_process, so the caller keeps
debug access after it stopped ptracing the target. The pointer is also
not reference counted, so it dangles once the caller exits, and a later
successful ENABLE by the target itself increments
debugged_process_count of the freed process.

A parent that ptraces its child, tries to enable debugging with
dbg_fd = -1 (-EBADF) and then detaches can still enable debugging on
the child with a valid fd:

  1. ptraced, ENABLE with dbg_fd=-1      -> -9 (Bad file descriptor)
  2. ptrace detached
  3. not ptraced, ENABLE with valid fd  -> 0 (success)

Clear the pointer again when enabling fails, a session that isn't
enabled has no debugger. Step 3 now fails with -EPERM.

Return -EALREADY for an already enabled session before touching the
pointer at all: the exit of the debugger of that session looks for its
targets through target->debugger_process before it takes
target->mutex, so even a temporary change of the pointer could make it
skip the target and leave a dangling pointer behind.

v2: clear the pointer instead of restoring it, no local variable and
    braces needed; clarify the comment (Jon)

Fixes: 0ab2d7532b05 ("drm/amdkfd: prepare per-process debug enable and disable")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3d768511d002..9256a2468081 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3227,6 +3227,16 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 
 	switch (args->op) {
 	case KFD_IOC_DBG_TRAP_ENABLE:
+		/*
+		 * Don't change the debugger of an enabled session, not even
+		 * temporarily: the exit of that debugger looks for its targets
+		 * by this pointer before it takes target->mutex.
+		 */
+		if (target->debug_trap_enabled) {
+			r = -EALREADY;
+			break;
+		}
+
 		if (target != p)
 			target->debugger_process = p;
 
@@ -3236,6 +3246,9 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 					&args->enable.rinfo_size);
 		if (!r)
 			target->exception_enable_mask = args->enable.exception_mask;
+		else
+			/* A session that isn't enabled has no debugger */
+			target->debugger_process = NULL;
 
 		break;
 	case KFD_IOC_DBG_TRAP_DISABLE:
-- 
2.50.1

