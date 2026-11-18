Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF50606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pqvYqVv8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5B2E10E13B;
	Wed, 18 Nov 2026 05:50:32 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE49F10E103
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 05:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDy/dI6U9Ttcd2o/qKlQideBNz8gTidT37hi5AIgI9swtIJ2aNfDoSzEt0LnerU8hsNoK1Wde74WXrKufT1xxari8FU0cBMmIBYGhaR+3kbFBs+XWrcfIgttZKWOaQTkup8nicQHwDq0bBGMjmDjurcy0Ssgoqo4RmtC1oP4W0uOrD9FWM9nTsW/yAmjvVZylR94t8CiMfiP9uJvLOVva5TdVwv7w4f283zB0HllA6lr0FpUKeXTPNLOvpFsNUC+FzYzIbadmUOx2GqMo0uorY7ZFYg8yA5yqKtwWUXvJRDEwyhA4PnGRJGLtn+m72kxumiYqEx9Vike3az/G3mF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1mjATM4ZlNY2XBJMjr5kpZG3aW4G9m9jIjhRPLzoUw=;
 b=BtOLHu/HwZVeEUqczNg8qj96D1mNZ2us1bsCIOVuMoADrUd1AFmEFSmjZCJGuszbxz4sXp1xXXGOR9ukXQrx4rys4qZE9raE2a1FTEpSow+zmD+efwPJdDKd3S58nsExR1oYuWjr9l6H4i4IBa9tmSsq6XQcMw5R2096sVVp2cEhKfVDmb4MrF3ztTF/BBRd++/Oph0h11kkNZdX/WR0UQLY6J0t3+Sz+sKeS9O8LJyWMoYFxffXNo/+ZhWKKQP1DpXXaVKPjwJB6qW2B9UVD8L4Q22URrN+Sy8jqK/KsXskIgdg0XfvxjbL/bdzVPBmyc+AGTMMTdRK21GcxChVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1mjATM4ZlNY2XBJMjr5kpZG3aW4G9m9jIjhRPLzoUw=;
 b=pqvYqVv8DqcpR2/EEqkOfNLXZHVk1H2Xz6TDH//DGWfbgelRuiABATdQDU+NYvXWsTyaAW0hX4ZSoJ3011uux8RCcgX45I0+bHlrgLS6DQ/tiCISKsAiOkdEY3BEAh0xL8Vw2l/60czkcwMc7CKXCDtqDQ+rl4Ww/Qq+5xY/hhg=
Received: from MW4PR04CA0156.namprd04.prod.outlook.com (2603:10b6:303:85::11)
 by DS2PR12MB9685.namprd12.prod.outlook.com (2603:10b6:8:27a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:50:20 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::68) by MW4PR04CA0156.outlook.office365.com
 (2603:10b6:303:85::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 05:50:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 05:50:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 23:50:20 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 23:50:18 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: don't keep the debugger pointer when
 DBG_TRAP_ENABLE fails
Date: Wed, 18 Nov 2026 13:50:00 +0800
Message-ID: <20261118055009.3005630-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
References: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS2PR12MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc073cc-3aff-4838-b914-08df4537d4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|5023799004|56012099006|11063799006|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: p0YP/BphABIxwpKk0ACqAeh62/+Xt0suw0XDe43lxt/61UAjaTLyoWwOe+djn71VDxKqhHzhD5TVx+lg5M5VuycYZ/G2UiZ9FMVe9B7T/6vN2kWF6eVNr0fVOA2VtzUukLdrc/6Q9Js09Vv0dynZhpyw+ZBwX//PZfWKRj9hEsWXiGjnKyUeDcnVP+gml81A9ABXdnsy9OIvWdzh8PiShPOzkxNCToyKrNRybCpTA9dv1tBri7JAg2DOac/l+ZG9BXYMIKi0+Utv7MmFd6UOhBvQZQ4rGcFBEiF272kei/a7S9lxD3ddUh7OhXiZj5om8PzcgUTFNG74yEQPznh8nXIR0Q34YmPfukAq0j1HjWOEmq2iFZXDzAl83sxS0yRut+lbIYi3T844o1jt/QtGP68TenZbw3NO/IImE/UnAQw9qT/wf83TlrUkcCCHzeZUchw3BzjUiBwt1enrqFf+4JCHmHPVYaomtBQ9lirkgSvA2QnHOA+ulKPH1rlGZBBdB66NUwkfQOuaunm/mFFiHlOHayFzeUOVlJ+k+HLrOaIKG8b3QwCqul1fZ2vBTfCx238sJZ+q9b7hiFVrBCItcc9oeUJWDER1wHLM+AH5USOFfjnbocBHA7YKmG8o6hZMv76+1q08QlIRVGhhpzYbQtWfCezT8NSax8dS1/q/tsjp8Vx3ooZM4FwXSdduj6gO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(5023799004)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9U0JdTkFPgY4sbzuHXxkjACoD44mMBhZMo4aDN03p4Y+/LuR3a1AysWr9/i2xgCzNV3conxPxmKL5WKrcuEQ7IZdDRVUHXu5q2bgGDGOB8WTidRPVznOpRxoC7QxK1F9hiFlZNCA2e+G7iPBpDZ2rDt4TSXZqOcfJHDqwLBs3IazslA6Zfp5HiFVGq2I1Qlx6cV9dZoVlYX1Tx7M3Vm2LyoIBaGjvpScv3wAAT8Hixlj8bQr5IiZuSb2yD6sJPWxLOZZcBqNbMy/tS8l/gdmGDECRXgtt5HBJtkY1aDh+jlR2udv2eQ1PsusNVuoyUPPel4zdedJKGRD6Rgaftg4Dz1cA2M2Tw8YeB843IxO4N6uUaWF5OCfNi/8IsO4aBz9qB4mgOlXu3EL/Ey23qAfU7i1x1NWUFTJ8kpn/NEI3opJNi0RizOBykL0uWM+pH5X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:50:20.6213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc073cc-3aff-4838-b914-08df4537d4e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9685
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

On navi31, a parent that ptraces its child, tries to enable debugging
with dbg_fd = -1 (-EBADF) and then detaches can still enable debugging
on the child with a valid fd:

  1. ptraced, ENABLE with dbg_fd=-1      -> -9 (Bad file descriptor)
  2. ptrace detached
  3. not ptraced, ENABLE with valid fd  -> 0 (success)

Restore the previous debugger when enabling fails. Step 3 now fails with
-EPERM.

Return -EALREADY for an already enabled session before touching the
pointer at all: the exit cleanup of the current debugger looks for its
targets through target->debugger_process without holding
target->mutex, so even a temporary change of the pointer could make it
skip the target and leave a dangling pointer behind.

Fixes: 0ab2d7532b05 ("drm/amdkfd: prepare per-process debug enable and disable")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3d2136adb62b..c42c30b459a3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3226,7 +3226,19 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 	}
 
 	switch (args->op) {
-	case KFD_IOC_DBG_TRAP_ENABLE:
+	case KFD_IOC_DBG_TRAP_ENABLE: {
+		struct kfd_process *old_debugger = target->debugger_process;
+
+		/*
+		 * Don't touch the debugger of a session that is already enabled,
+		 * not even temporarily: its exit cleanup looks the pointer up
+		 * without target->mutex.
+		 */
+		if (target->debug_trap_enabled) {
+			r = -EALREADY;
+			break;
+		}
+
 		if (target != p)
 			target->debugger_process = p;
 
@@ -3236,8 +3248,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 					&args->enable.rinfo_size);
 		if (!r)
 			target->exception_enable_mask = args->enable.exception_mask;
+		else
+			/* the debugger check above trusts this pointer */
+			target->debugger_process = old_debugger;
 
 		break;
+	}
 	case KFD_IOC_DBG_TRAP_DISABLE:
 		r = kfd_dbg_trap_disable(target, true);
 		break;
-- 
2.50.1

