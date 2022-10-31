Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954C4FA3741
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C2710E30B;
	Mon, 31 Oct 2022 16:25:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE88010E2EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDN2yAsErrbO4km/yPiQQsqDytOCNdg9T4yM1gXMkiYi5cQt6VuQG7jmGOZNwY8lKJN+/dd/+zsBi71Hd9uLdS0qtvDHg2coYNgSmhwY2i/u/Dwu6u3np87DMote97uT8cycs1gVtGgR0eaGT7Xy+4DpwaPlLTA+C0rurM7IIrznfiCueyPfLeE/iAb5KdMQKuwsN8gaObrGWlh7W7M003t8Pp+suU54R4rCfN+/dJWFSjqLg+GB0d5O3ntlXiYbSt8nvtecbcIjz/VVeaM3Ir+4EnXp+2O8HunjXUKGLzADC8SP/j6nB04b1IQZ93+X9A+0jo8f9J7A7YVVixdW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hi+XwiwZvHxDMjgVWMV3FGw9W28Q1/HPtVw+3kXmmG4=;
 b=QJ1sfx+I1Sm8vadUDyvF0mFWU2vyjAOTVEpzqbKk3koevFOk0s4RVMsYVtBa8R9mAghxMekWLO64i/8bGRXly+YcCLqjIqjtYrFuPYQFz1VNuhSY1pgYOFX/4U/47vPffSDSdyEMS4McL9BcxG6Vbh3wsEQF8CL6iHL5mo9KZkLZVmm6FvLCj/IK9qKe71eoGtveqeh8fvoyfhM6NiA5CTcMzmvkWkc+HF4zcx4pqWwg8Vs6H9PV2mXrnj+wtLmHIT2L0Uu4YIQwOblF8pWoJV9VVuQGeBphlZLOpTpABrhHG7eM3SM21CidK1IvruvHQk61fYHIrSslpt6sAjIkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi+XwiwZvHxDMjgVWMV3FGw9W28Q1/HPtVw+3kXmmG4=;
 b=T7QRh+8LbQvUgDBcIYkuUkmBrNUOoGGtc+FQHO9qvbjRVDTrE6tSsh1mg7S9qxV3OW1R1ahM1V5c5n5hG+4fbfnA6e67xbj7ZvjrhVbh3i6KD7SGh6T5WTZfiWLd0ZBy8pjPKPQ2aEr4assqq3VQLHSBOg0s24o/Y0MYdyPAKRs=
Received: from MW4PR04CA0173.namprd04.prod.outlook.com (2603:10b6:303:85::28)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Mon, 31 Oct
 2022 16:24:32 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::e4) by MW4PR04CA0173.outlook.office365.com
 (2603:10b6:303:85::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.21 via Frontend Transport; Mon, 31 Oct 2022 16:24:32 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:28 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/29] drm/amdkfd: add debug set exceptions enabled operation
Date: Mon, 31 Oct 2022 12:23:49 -0400
Message-ID: <20221031162359.445805-19-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 11658521-4d53-4823-e200-08dabb5c646b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxpqWSC90LLxoKGyBmA2vRp1iC72Qg9p2fe3KkDvgkE8zWt2CDnwLzNcxx0cE+y7Jg7hXzPrUg4QtRHrzMfDqFW07O/IMQT+QHN0Kg/PSDqd1K9W4hRIiAP74NgqP9AR8drii+wl+GIaMX5cInnoekCXNl24RNlVU3n03dQt5jI/FNvNL3ml5LtP77j3DRYGL1U29Z8qVMYoUDjsJeot8pGnsvT4yXTjyipFD6XVUoFT92NPqoY/FDGJGs0Byo5Sz9xcUzc2jMLoDW4BPuLVWDm4N0Ny18F5QqCP0SEI8z9J54MiWkrrm3+Bm5U+Kr3G2xFjvltOuEa4nyIUG4jp8d69NuUl8keymUbgbyiIAGuPM2pbq7+9lK+GhjKUjYfar2NlC9XN+qlS6ViPODxQGZd8FrbTeISQ2wQx6ZaS0xJSA32VYn/1EjdJ9wvNKwuKHEjBwXwR/1oT6Q1oYQwan5pWlqXghtYsBHA9ZWC67bvq1JDcp8U06zn3ElNWj8LQvv9BWK9pobFsihxBXJfrA+8/4n4mY/Z0+yhXkdumYXc/S92zyFtkC7coryoa2B2idmkNV6oCjHy05FwZgBXsbczxtHhR2sK2Uy5D8oDiI0YWNRo+oMN5TzCf9oNt7OANvPZ81vSw6xJ1LgBihO6S0MYqKiafnak1hJME3e3pefi5Xbq54sX/xKOn2qEpQEzKN/BlTBGN4D54B1PA4YTrwjWy1mpBeh9NpTLwOPMikvJueo06Ahzub9CHpw8lonX/tqzUXxE07DUAYPbWTeKaepQmE6vVp+LETQF+iTsdCbPyv/gfJGQZ+0A7wg1KGrQM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(26005)(7696005)(478600001)(6666004)(40480700001)(2906002)(5660300002)(82310400005)(44832011)(40460700003)(36756003)(2616005)(4326008)(8676002)(316002)(6916009)(8936002)(70206006)(70586007)(86362001)(81166007)(356005)(36860700001)(82740400003)(47076005)(41300700001)(186003)(1076003)(426003)(83380400001)(336012)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:32.1117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11658521-4d53-4823-e200-08dabb5c646b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The debugger subscibes to nofication for requested exceptions on attach.
Allow the debugger to change its subsciption later on.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 36 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 27cd5af72521..61612b9bdf8c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2887,6 +2887,9 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				args->send_runtime_event.exception_mask);
 		break;
 	case KFD_IOC_DBG_TRAP_SET_EXCEPTIONS_ENABLED:
+		kfd_dbg_set_enabled_debug_exception_mask(target,
+				args->set_exceptions_enabled.exception_mask);
+		break;
 	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE:
 	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE:
 	case KFD_IOC_DBG_TRAP_SUSPEND_QUEUES:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 3d304e8c286e..594ccca25cae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -441,3 +441,39 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 
 	return r;
 }
+
+void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
+					uint64_t exception_set_mask)
+{
+	uint64_t found_mask = 0;
+	struct process_queue_manager *pqm;
+	struct process_queue_node *pqn;
+	static const char write_data = '.';
+	loff_t pos = 0;
+	int i;
+
+	mutex_lock(&target->event_mutex);
+
+	found_mask |= target->exception_status;
+
+	pqm = &target->pqm;
+	list_for_each_entry(pqn, &pqm->queues, process_queue_list) {
+		if (!pqn)
+			continue;
+
+		found_mask |= pqn->q->properties.exception_status;
+	}
+
+	for (i = 0; i < target->n_pdds; i++) {
+		struct kfd_process_device *pdd = target->pdds[i];
+
+		found_mask |= pdd->exception_status;
+	}
+
+	if (exception_set_mask & found_mask)
+		kernel_write(target->dbg_ev_file, &write_data, 1, &pos);
+
+	target->exception_enable_mask = exception_set_mask;
+
+	mutex_unlock(&target->event_mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 5270d5749828..837e09491a76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -58,6 +58,8 @@ static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_dev *dev)
 
 void debug_event_write_work_handler(struct work_struct *work);
 
+void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
+					uint64_t exception_set_mask);
 /*
  * If GFX off is enabled, chips that do not support RLC restore for the debug
  * registers will disable GFX off temporarily for the entire debug session.
-- 
2.25.1

