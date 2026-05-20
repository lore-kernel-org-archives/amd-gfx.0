Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA653CD4F5E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 07:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4763A10EF33;
	Wed, 20 May 2026 07:14:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UfScxvY0";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1E910EF33
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 07:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp00lkiDHhH044DLnBrf6rhZsJym3ZhRC5BrC4E7PAX+mXgxo0wJ9amiye8AQ53xFursl92ZK6ZW4uXEmriRoNnc2mFL6b5f0ZwSTaxu50KSi3pM1wB4ZkgCxetTxgFRAmX/J91Q8hs7M4/HWvTMwSTXuzqTAH743znXRHbXJy2F+z75RSSmtLEtit4Y1mzp5v2gscAC8eAJZYoDOtP/3sy6CkNsiZwgGLBFTpecoT9NAAkx8PtlkK0Wb2He9nB5x1L0BmjouUpi5F21EdqAE/tmUcrE71VoQXUIiINBRez2ndAzY5JAUThzo472czZ1BGhScUERLcaa7GGdW4Up3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEqWFhvls7y4xxJRcD1n0d58xQMwdFd0CTPSxDBKJxc=;
 b=amfR8Q2xJ3I4G8WZSpYZrQmeEXwNz99eYCfeVBHm8RN/A7fCL8zDj2hYHKfc8AjGRIETmjZ8N6Y7OugggbQniGdFMYy012EnYZN0BPI9hAvAsnmmfH5yZxIvkMAzzgoDPwH4sXhpQfGD0opO4KVxMaghYXiKJuH4pJJCXBFMJR5srWsc5Xl7N2DoTZEBN7JmmsqtISSxcPgeVLt3oVA2rcEaBSZMTh/RoAjofDI4OkV4nJ3Q9j4PoRwQlrc/Vft2NiMkpTeyG1DrlGQfRRYpy6Ve/z3yvmhn0ujBr5hVY8glrLPOlSDv+FkcajokbG9v++n+5n+JU8cLv3rn6NauzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEqWFhvls7y4xxJRcD1n0d58xQMwdFd0CTPSxDBKJxc=;
 b=UfScxvY0H0z6MtICtNSWCSjPiDHtDLNMbBYKZN4LN7IVGtOgDiDNapXopJroVB9D/cGtVYIiCVvgUGR88BGt0Vn1CtLeROwKtuHAHXVN9dB3LAFJMlAqhRXqZkHoqFw1bg5nzNbRFDpIvfXKKZJiZDU8v4KnxeZbjZEGp5e++nE=
Received: from BL1PR13CA0250.namprd13.prod.outlook.com (2603:10b6:208:2ba::15)
 by LVUPR12MB999161.namprd12.prod.outlook.com (2603:10b6:408:3a2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 20 May
 2026 07:13:57 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::5a) by BL1PR13CA0250.outlook.office365.com
 (2603:10b6:208:2ba::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Wed, 20
 May 2026 07:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 07:13:56 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 02:13:54 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, <David.YatSin@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Change sigbus delay value type to u32
Date: Wed, 20 May 2026 15:13:35 +0800
Message-ID: <20260520071336.1573860-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|LVUPR12MB999161:EE_
X-MS-Office365-Filtering-Correlation-Id: bf750683-31fe-476b-f632-08deb63f5b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|30052699003|82310400026|1800799024|376014|18002099003|56012099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: efjGKx5ezNGxAtmJyJLNsshBxkdrPibOb2twqsHpp0+Qi5yrHLUqgkEzS8N5sra0wVQQtRQmmjmzatIfJQ9vbVXoHEHat5hXY4sFWriR8DQI/OagZaJwfzFth0OSk8VOalnPM9GzEYa+WfXN7UklbK3K+p6n/dcbOZdXD9qLjeBZIjLtG1XuoUz0+UdtEkgn5se5S74b6uWe0ZrhWQnyzaAW8RNYNF9SNhknk34m7N4wwVO9Im6Im7Yw9ZLbuC1ijLruboIVTakfhmiGh0YaQgu9Fv5FNWjnbRo1l7Vt7er4jSmWsSvr4Q8ou0RXJsykigLYf0ZGeTlBwcArk3fsQ2XYX2CQmP9s5tSsTajv7O9kH5QeKprFVMVCe0RqlLman2rRKVmOto9PB5hmWTS9HBKmqWITj49a1810Tfn4nFPWpph3CGR+7papqR1np52uV1vdPVYomyg8nmg4mq5OiSJMdwItSvU/Rdo17oiCnhp9phllTxh8SG5/N5NzUOLLafq9xxKp4HXN63TfvH1WFq1pmvhoF1ONx5+Inzy0oe/81HpMXQ55Wbb6S2yusOC6pMeVdyccPVdHGE/mEaeyfuW3g0N9E8Oqd6Ulhgar22ZebF4G+hFlOlCXezjb+qQHikO6rBljkeNSthwkmgjIBFepW8uFe5TZtQS9JnBAW0uhbxYhDdJZYB89tQUV6Tb6b0M9QyPvLIH5kuj5WzigqeKEkoHHmqLk9gbXNNEzxPY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(30052699003)(82310400026)(1800799024)(376014)(18002099003)(56012099003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1SUMQ19eDyFQq8mFFnTUkM10jTBbM3IRvierCHlKhxLHbg2clOw7t3e1oGH/MMHEyIcOMxrdsx3mieEiPLkLdQiMfsboYtCzloAij6QOPK1UkiF9UhjKpzhwkvdmOJ8ty3CfHmQT01kO034ZJ7mCywIMbMpARNRWgohALCO0OhJ8z21xGef3ER4EfL2lFf6AzQCrVg+jA7085IFiriVc+YEuGrk/MefgZD4oolo3CvuKlyG7cBrXfOq5j94XqsGBYkF6FvFDiD6ZBU5vATPps03eosHyBCZHCsAukzsR3V+GIqq+AVWHfXmxc9kFV7Hw+Q6AnBBXli+VhztzVqxfV/bkkeaxceNOHSZsxV/OPfkC9SAHZ5eWbV1mBrlbdATSq6vbXxjUlF1JtI0hLQ+uGdrl1W0xjyksSdHol0kn+eyEbpWeFbBrEnjBmfLdwjRg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:13:56.4700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf750683-31fe-476b-f632-08deb63f5b5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999161
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

Previous u16 type may not suffice for GPU coredump.

Fixes: f207b038bc38 (drm/amdgpu: add ioctl to handle RAS poison error)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 10 +++++-----
 include/uapi/drm/amdgpu_drm.h           |  7 +++----
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0408476f1070..6a5459b59af2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -461,7 +461,7 @@ struct amdgpu_fpriv {
 	 * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
 	 *
 	 *   0          - send SIGBUS immediately (default)
-	 *   0xFFFF - suppress SIGBUS delivery
+	 *   0xFFFFFFFF - suppress SIGBUS delivery
 	 *   other      - delay SIGBUS delivery by this many milliseconds
 	 */
 	atomic_t		kfd_sigbus_delay_ms;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 200570401f51..8b4e0a208e86 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1352,7 +1352,7 @@ void kfd_signal_reset_event(struct kfd_node *dev)
  *
  * Encoded value (set on any of the process' amdgpu render fds):
  *   0          - default: SIGBUS immediately (no opt-in)
- *   0xFFFF - opt-in, never escalate to SIGBUS
+ *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
  *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
  *                handle the error in time (safety timeout)
  *
@@ -1388,16 +1388,16 @@ static void kfd_signal_sigbus_delayed_fn(struct work_struct *work)
  * Rationale: if the app has explicitly opted in on any GPU it uses, it
  * wants the chance to handle the error in userspace.
  */
-static u16 kfd_get_sigbus_delay_ms(struct kfd_process *p)
+static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p)
 {
-	u16 result = 0;
+	u32 result = 0;
 	int i;
 
 	mutex_lock(&p->mutex);
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 		struct amdgpu_fpriv *drv_priv;
-		u16 v;
+		u32 v;
 
 		if (!pdd || !pdd->drm_file)
 			continue;
@@ -1420,7 +1420,7 @@ static u16 kfd_get_sigbus_delay_ms(struct kfd_process *p)
 static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
 					 struct kfd_process *p)
 {
-	u16 delay_ms = kfd_get_sigbus_delay_ms(p);
+	u32 delay_ms = kfd_get_sigbus_delay_ms(p);
 	struct kfd_sigbus_delayed_work *dw;
 
 	if (delay_ms == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index e88d7cf53858..e0a382673b90 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1680,19 +1680,18 @@ struct drm_amdgpu_info_uq_metadata {
  *
  * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
  *    0:          Disable sigbus delay - SIGBUS will be raised immediately
- *    0xFFFF: SIGBUS will not be raised
+ *    0xFFFFFFFF: SIGBUS will not be raised
  *    other:      Set the sigbus delay in milliseconds
  */
 #define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY		0
 
-#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED	0xFFFFu
+#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED	0xFFFFFFFFu
 
 struct drm_amdgpu_user_options {
 	__u32 op;
 	union {
 		struct {
-			__u16 value;
-			__u16 _pad;
+			__u32 value;
 		} kfd_sigbus_delay;
 	};
 };
-- 
2.43.0

