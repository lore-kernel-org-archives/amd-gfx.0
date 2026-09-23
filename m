Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8321C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 21:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42EE910F1D6;
	Wed, 23 Sep 2026 21:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="owT39bT2";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E96C10F1D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 21:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fx1Qzb5GMK6+WA0fVFF4wp2Nn2ss7mPT4lOqC82xhfuIJ958HtC6ZVJmAe7COCRNLhL1arcH7sKiFIdNY18PjCwB7oOFFnE4pAzUuJQ1lDsw1FCEH1jPaV2K9KnGqD6aQZBDO5cUZhY3vm20lVmt/zrZgK8q7CpUo5qyRCkmwZj6QZTRn23c1XIM2VhWsj8h8J+In9TmTdz3nBV/yOA7HyIPu+W6pBLw46aQh3Sbad06dKQPnHTSvSYEjCqA20FNYM2rWggsD7xVI5ostwD+imGFa3MMGBppJ+HBuMR0iR4d1BP60PVUvv7yXOpZE02A2ZG42fKxntybtPhdZgoeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJsuZIDZEAUDYTzM0gDjyvRFk0MIGYhUF2/71w+3/GM=;
 b=uu/+nM1mXvi3ALcYd8VmXEqRqc9GVPWTZWqx8XDa1BhCpN/bwa/TieHyBbuqSjc6uDZlH+QFmJSZCXs1naWoZi7AgWtLFBZDz510RD85+MxBXfiLP0t+iNFUAvNvJEctC5l0LhlUGnMP6mR9MnqVbsS8qnOcx0JIOepw0ApXyEavW4ZzmAx5uPM6vgB4Gb1K2RdwSGY1mHiOsbzDoAaRF6ZKLa6Cro2UXbpkmZ9QOVbhFgpaWDHU7eCIEtF6gn+W0NWGLULn2GQgtF/7pOUSUXfzWgPfO0ddJ6z/nwQCQ7OaVk5c2WhjpBej+SzliWX/P59YC7MYD3qV6uJY5vBqTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJsuZIDZEAUDYTzM0gDjyvRFk0MIGYhUF2/71w+3/GM=;
 b=owT39bT2v3dbT2AXaMYpHmOKssuUT5yB6LXO8R+iZ/PQ69yEw5b7l7c+q72VqAb4iU9h9i3NPDFhiVEc0guGw+ADDV7VY1sE5KT6OeU0oIFfGcRKUAoQ9kLG5ykK+cADiRWRSJ22aEknpJRhOjEYtPEs8PDnW2th/hjJC6bpKTw=
Received: from SJ0PR05CA0175.namprd05.prod.outlook.com (2603:10b6:a03:339::30)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 21:29:02 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::5e) by SJ0PR05CA0175.outlook.office365.com
 (2603:10b6:a03:339::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed,
 23 Sep 2026 21:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:29:02 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:28:59 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, <Christian.Koenig@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix bo_va leak / WARN_ON in gem_object_open
 error path
Date: Wed, 23 Sep 2026 17:28:38 -0400
Message-ID: <20260923212838.1421843-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923212838.1421843-1-mukul.joshi@amd.com>
References: <20260923212838.1421843-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 2811e500-14fa-4c95-10f6-08df19b9b035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JC4hsjPFlZkYQ2typgkNpId0AOkC89AsQrmKujzUCWLEit2FkAzub37i2w8IaUzknRI+Q8fTHDvowkP86Z/5Ubp4Ab54OlLiWpam0ZLTGzA75hZnHYmH7jL7Qg9408ACZMynS8bLcU10T76Yn1BZhzcdUJKQKwubEtJ0Ra+inZqnpSiNpMTtINj7j8fL0zrNZ1h1cTnGCtXrjeMlyxHb88mNbgQ6pi0gLUyYT8Ro0iJBskvEvABDLeQVmjEmsZLcJbQXrtmzjIFdo4LO4gMS29AzS1wJw609JBDUjOeYNO8OfXJpB9c27zmLmf0kaywmL92XvtHYddsMEbsKPWeMgBpABPMP3Q3eQkDHGROUtlMAaX5VH/d+cwgOy3/nu7xulz73OM9npJ5q/O2jXo+8OKzBzGG3wERqC/hE5b5OOND9Gn5l2zO2tIHgUDjoHalD9f/2osHezMMpy4D5wZSb5FtcxfsXSA0iyUI+ssmt/Ochw1tEiLtXAtUIhzN+AfR+WJxLmO75alc0nC1xWPskiAjSZvyoxrtBZn7fPWrRneHaLOdKZLZ/uXSw+U7gELYGnkBry83zk7bHrVcZ3nEW1Zcl/6KqJU/2EtQxguHl1Pz9ZIt3kBV3OFa4wv0ZMoQKP4RP9NnAKA2R5+Hu+Yb5RWHs40V84jAekBtLTHw0dr6VWzhhiJrUNlHstaW86QlyQcLN730hAfj0JsXS8sWVcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y4OMHF2Euq/DPZStGvfXIFTPkAsisL/UyoqyGI9J00FMSyGEHxTLNevQ9U2jRed5UIotX2Dn5dw9UUd7v3DJhLJS+156ggWZHCfjrjNx0XxVB5Hn8X+lV/9cnJZJy3AAhviJmIdyZ/gN73BOV22DX1NB7u4uXmwU/tehjgGQyGy3Wc6XUKDR/cFBw7vDlxRZ+AQ1DFF7b1+LWqAcI/efJg2YjA+kLd8fTtLchdEWgJpWxZhEepQzpgIFzmgy6O9Eiz6oe+vtawePkvzpSRwa+6J6B2WQfmYdK6shfxL05z6ZgHzLoLUI6YPGxqKRJswlytTfJYGK24HxzaE2E7xefbHwcxUxFvA7Yalyu2MB0cSRHjFqkADbyjiPDAtwapoJuBrVilVAUlcEB3LetRe/vaPUPpLkudvN3p6tKYm11D9D9XjTHrJI+7dlTerzr40T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:29:02.4500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2811e500-14fa-4c95-10f6-08df19b9b035
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
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

amdgpu_gem_object_open() maps the BO into the caller's VM early
(amdgpu_vm_bo_add(), which sets abo->vm_bo) and only later validates and
attaches an eviction fence for dynamic dma-buf imports in compute VMs via
amdgpu_amdkfd_bo_validate_and_fence().

When that validate/fence step fails, the function returned the error
without undoing the VM mapping. Since .open() failed,
drm_gem_handle_create_tail() aborts the import and drops the last
reference, freeing the BO while it still has a bo_va attached. This trips
WARN_ON(abo->vm_bo) in amdgpu_bo_release_notify() and leaks the bo_va:

  amdgpu 0004:04:00.0: validate_and_fence failed: -12
  WARNING: CPU: 96 PID: 2868883 at amd/amdgpu/amdgpu_object.c:1343
           amdgpu_bo_release_notify+0x15d/0x180 [amdgpu]
   ttm_bo_put+0x149/0x350 [amdttm]
   drm_gem_prime_fd_to_handle+0x132/0x1c0 [drm]
   drm_ioctl+0x251/0x3d0 [drm]

Roll back the VM mapping on the error path: re-reserve the BO and PD, then
either delete the freshly added bo_va (also detaching the eviction fence)
or drop the extra ref_count taken for a pre-existing bo_va. Also clean up
the bo_va in the out_unlock path when the eviction fence attach itself
fails right after amdgpu_vm_bo_add(), which had the same leak.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 53 +++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0d579517c03c..d52bbdc42b31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -237,6 +237,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	struct amdgpu_bo_va *bo_va;
 	struct mm_struct *mm;
 	struct drm_exec exec;
+	bool bo_va_added = false;
 	int r;
 
 	mm = amdgpu_ttm_tt_get_usermm(abo->tbo.ttm);
@@ -264,6 +265,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	bo_va = amdgpu_vm_bo_find(vm, abo);
 	if (!bo_va) {
 		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
+		bo_va_added = true;
 		r = amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
 		if (r)
 			goto out_unlock;
@@ -304,9 +306,60 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 		}
 	}
 	mutex_unlock(&vm->process_info->lock);
+	if (r)
+		goto out_vm_bo_rollback;
+	return 0;
+
+out_vm_bo_rollback:
+	/*
+	 * The open failed after we already mapped the BO into this VM. Undo
+	 * that mapping, otherwise drm_gem_handle_create_tail() aborts the
+	 * import and frees the BO while it still has a bo_va attached
+	 * (abo->vm_bo != NULL), tripping WARN_ON(abo->vm_bo) in
+	 * amdgpu_bo_release_notify() and leaking the bo_va.
+	 */
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&exec) {
+		int r2 = drm_exec_prepare_obj(&exec, &abo->tbo.base, 1);
+
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r2))
+			goto out_rollback_unlock;
+
+		r2 = amdgpu_vm_lock_pd(vm, &exec, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r2))
+			goto out_rollback_unlock;
+	}
+
+	bo_va = amdgpu_vm_bo_find(vm, abo);
+	if (bo_va) {
+		if (bo_va_added) {
+			if (!amdgpu_vm_is_bo_always_valid(vm, abo))
+				amdgpu_evf_mgr_detach_fence(&fpriv->evf_mgr, abo);
+			amdgpu_vm_bo_del(adev, bo_va);
+			amdgpu_vm_bo_update_shared(abo);
+		} else {
+			--bo_va->ref_count;
+		}
+	}
+
+out_rollback_unlock:
+	drm_exec_fini(&exec);
 	return r;
 
 out_unlock:
+	/*
+	 * If we already added a bo_va (e.g. the eviction fence attach below
+	 * failed), remove it while still holding the reservations so the BO is
+	 * not freed with a dangling abo->vm_bo.
+	 */
+	if (bo_va_added) {
+		bo_va = amdgpu_vm_bo_find(vm, abo);
+		if (bo_va)
+			amdgpu_vm_bo_del(adev, bo_va);
+		amdgpu_vm_bo_update_shared(abo);
+	}
 	drm_exec_fini(&exec);
 	return r;
 }
-- 
2.55.0

