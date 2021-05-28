Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270AAC4708D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D888C613D1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D888C613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CED6F62D;
	Fri, 28 May 2021 20:49:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C356F62D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 20:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ8rbTm5YIwd4WuEZ19rhnhCCr0UFvVHdhdnfdLBpqohIqBRpWfxmldp3dx7d5xoHANEKf1vo37yNmWLqaGYNgJ5DrMXiuS1/MocA12+Tcq4tZLLjauCgJZRPQVQbz6FyQBNXYnViygNJF5OkKlk/FRhGKI8DdrB+Bm5pUQTV7E6stiNSY2ZWxmfN99/50SuxcBAWscRaQTuA5HvtrMR/7vhq8oywHdyt1p2WXOhORBjmw9/ImRQAdT6kTOfNfZLiCu3OE+gdJka5/ZdHYcU0kTJddHrpSQ0I3XvOXQMWGukUImBjKOMoAjXyyjdSIrClr1qsnRIz7hO2R3PODuHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os7O7dIeWwDeDDg8H0/PHukEbK5qa2lE/2XvCPtKuVU=;
 b=igS42ZM2SnikEfCw0KHpVzfztkfq4pqk9AGVjeDZanVkQkl+nX6jAgW5K47VmPqCs7vmBJxfUko1Tz5UzIYpCEh3SpHsVC9ZtLmW1jLTxiP6HYQ28mHzen1ad/XUFcb3M8ehxueNC7zolvykb7Xc7bUkfSOquDHs9UgRzN7WCcjGLqd9QbZH9jgLMcwV+IA3ncHq3u8DifedJoMIRvKXpl7tKC1PHkjoORVkXlDAT50G2pUdCzEhKldazneFzET/IaH794Ffney6K4S2bZREHoKut1reikMJ0noqQolWcTwseVwaoGotgGAGhOpt9j8veu2I5Y00FfGS1YvNEdRk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os7O7dIeWwDeDDg8H0/PHukEbK5qa2lE/2XvCPtKuVU=;
 b=dq34qR0tYb27CFXiL4s/GKYEIIUUlZU1V8OpBL1bSCV4jAMroxQWL3N8T6/lpsxTbv22b6sKg2w7cgDmtSaIvJE6q7GMCeOrcfszLj2paIB6U5n7umrwSiTNMDq3rX3YnE/1WDCd7FBq/3mDpjphZvxRFniDpd+SY9Jt3060JO8=
Received: from DM3PR12CA0088.namprd12.prod.outlook.com (2603:10b6:0:57::32) by
 MN2PR12MB3806.namprd12.prod.outlook.com (2603:10b6:208:169::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 20:49:47 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::30) by DM3PR12CA0088.outlook.office365.com
 (2603:10b6:0:57::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 20:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 20:49:47 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 15:49:46 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: fix a bug for flag table_freed
Date: Fri, 28 May 2021 16:49:05 -0400
Message-ID: <20210528204906.245661-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528204906.245661-1-jinhuieric.huang@amd.com>
References: <20210528204906.245661-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ab1658d-334a-4268-b63f-08d9221a2192
X-MS-TrafficTypeDiagnostic: MN2PR12MB3806:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3806204EF4623E5724C0894F82229@MN2PR12MB3806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7vqncQPWTcvFzTZCQI7I50Wt5BhTAKJ66RmUe5MvOyfeolvZ6zmJkI1481cEKrpp55WNDHgYo72In91Vm/dHhVISq5Of0V4SEjEgTzyw2zPgKEt34MQTRlYFwdeLoFRlQ+5UiipSrZKnmKZ54ZTc9i0SCi6zKACdwyIvWWv/gS01bO+OajyViQpedjh6bYYZ84PMHJeURQ2QbAes62U0NFy08kHcXn5sZeLw+KSPjM+rPwtz+mzpn8Q6bRLPdSZPcAITCfMj4ltNLDCAGRmc9OQjtysEW2TJECnHOD4mX1aDmBa0Ya9TBV+gK6wpAAJfj2eRCEOvBT7kStY0RvV3EyE+lO23c2bOiUZYFqcyMAgHgw5ApK66jOCAbLcC+CsDWhuzff6/0RydUAKKO4SCKckQ/wGk+2W14wkIaJXHt9JKjhx3TudYYh4z7EHBdYIi+rydFdcQxtr/tNQ+SZAcACHvq0jGeJ9scZgA12zwEb5MLqlmGxE/zqwqzgbxkB/iQPO0sJEkHt4WHNRiFmXjXQmQzDtX1Kz5J6Iiw8cmH7xMQdFp8yUtujQMscBoHJlVeMh3G4wf1z2rOYsZvnSFtYevTJhpd8aql5EtNJ73Z+Y60VJyOpFN0F2dji1BgAYL31qI7h3SBHunSCSFTAn7tB9i4lrMBWWcAN4ODhC8mQMiQfDWVERm4SXQ26E60iP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36840700001)(46966006)(426003)(26005)(2616005)(336012)(70206006)(83380400001)(186003)(86362001)(82740400003)(316002)(8936002)(6666004)(356005)(36860700001)(8676002)(36756003)(81166007)(4326008)(2906002)(6916009)(82310400003)(7696005)(5660300002)(478600001)(16526019)(70586007)(47076005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:49:47.6393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab1658d-334a-4268-b63f-08d9221a2192
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3806
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

table_freed will be always true when mapping a memory with size
bigger than 2MB. Using a check of turnning valid PDE into PTE
will resolve the issue.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0dee2e8797c7..b1bdc89cb5d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1553,6 +1553,21 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			 */
 			nptes = max(nptes, 1u);
 
+			/* Fix a page fault in a corner case of
+			 * turning valid PDE entry to PTE entry
+			 * for huge page mapping
+			 */
+			if (cursor.level < AMDGPU_VM_PTB) {
+				int i;
+				for (i = 0; i < nptes; i++) {
+					uint64_t value = 0;
+					vm->update_funcs->get_pt_entry(pt,
+							pe_start + (i * 8), &value);
+					if (value & AMDGPU_PTE_VALID)
+						params->table_freed = true;
+				}
+			}
+
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    nptes, dst, incr, upd_flags,
 						    vm->task_info.pid,
@@ -1584,7 +1599,6 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			while (cursor.pfn < frag_start) {
 				amdgpu_vm_free_pts(adev, params->vm, &cursor);
 				amdgpu_vm_pt_next(adev, &cursor);
-				params->table_freed = true;
 			}
 
 		} else if (frag >= shift) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
