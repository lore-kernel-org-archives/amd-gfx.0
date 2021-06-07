Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3AAC47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FEC60FEF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FEC60FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDDD6E8E2;
	Mon,  7 Jun 2021 14:22:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D24C46E8E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 14:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3G6eBsKMIgWCXABiET/YAVoeTiTUq6xnKOl0Y/kH5dvOVszxzyBPhxifq5N0Z/e0PKHUPsMBA1eQMMWpcMrQJdJKxGE+qZo/cf9SXZ/Q7m9finxf7MQTOeIhBBWWOnFMLcyA1BTszryIdhaklhtxXVcfxpTVjg6a/w2VrAA5mI8IoQzVNg8JDuH3ZT/rcibH+MnmjRqy0qd59JinAxQdZk3nb/4kB3U/9EV0FQPzfNT3+YmaRgKyN8PKcbxuxjbxPSWC62gorqnDqVxaOFePhVw2AxCwrT1r220nb0xE5KxZ1ky1kF8rgRYgYJeWA4fhL2uFE9L0tSO4IOETfAHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7ffo5LmKo+WEfzqkdvFPGCd+Z+YKRnxylu1TodkSGw=;
 b=h2t4T4X2SNfm8scja0RSttlWkdD64945oKp2mf43k0hgaS+dd1JvJY7q5W5hrHwYPH2d+xpM9lzkX4BsuYXBlyOwtPRx87yuXNnBf//Q9Frm5t5dCclvhm5sHLh2zwIFAL4q3eIsBk3oVOrZ+eD5t1Y97weTH4D8aFk565Ao+u+NHmRap5gsLJm82H8ST4rHZuiy40mZyfqQmRYOP6z2WogyTfgFuPTMrts2g7emcmJE/OouIVykO1ImsAmRVp0/iv4Gt6hdzVdi/VAXZpiLN2HtztaKHRX9z71zrtBhuC0th7PYwrUArl7JkQUx6H9DoqHlOJFJXHI3qQ3utLVbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7ffo5LmKo+WEfzqkdvFPGCd+Z+YKRnxylu1TodkSGw=;
 b=2hJPxMwntm9lxCdOuOXkDKUUjkdVG4nX+//6MIftHKRv/CfRsXCSM5IxdHZ0BoKpP/8dFzrEUs7/C9XMvi5+A+YiwxA2Lp9glusFXU0R5xq/+UPV4l6yjlPQ5SwAoRqbPc1wUbw4avbmh9zrkGk1c5cADNphiGPNeItUP8ny8A0=
Received: from DM5PR13CA0069.namprd13.prod.outlook.com (2603:10b6:3:117::31)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 14:22:15 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::60) by DM5PR13CA0069.outlook.office365.com
 (2603:10b6:3:117::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.11 via Frontend
 Transport; Mon, 7 Jun 2021 14:22:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 14:22:15 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 09:22:13 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix warning of Function parameter or member not
 described
Date: Mon, 7 Jun 2021 10:21:59 -0400
Message-ID: <20210607142159.68860-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4498d8c-2765-437c-d288-08d929bfa615
X-MS-TrafficTypeDiagnostic: DM4PR12MB5198:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5198E344B47CAEEE4796BE8F82389@DM4PR12MB5198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEMYHrSXHgAWVpnU653ESuAI/QVmXhkk3LonouhcSWsbndvBacvyZKI0YGr9YWR+0R5PSD542VCBCNOVq8oFW3Nt++O6HqI19l1e7ofLYWiTnPMkHyGfQeAtq/JlmsSRkkt6IrsTZqudtz1jl1kq3l+XDgg5vIuPVxRvv9Fssf2sZMFm3g52h27YxGPjz/IidEmE/dkdr6kpnoOitbJdQ+ydTr7VzKn44xLZ7d5g3KORAXKSArh0QTytUxY4Ju1QLsOBCOSJbPIMSKJhrqPYB/qfkkDO7N4llMNIXv6whNoc3PA6KljiJjuJIKkN05fS0mVuoxFnoe7VAVSmgn2PJR6drQdJtMjhDWGjb/2C7xL8DNfYTS46vKCBvsJpfA6FqFsLIKF0kd8cUYBRtXARqXwXxwovuRu+Cz8pjeZ0jKGZBok7YqfVhkdTlwAFnXXUPcD2LsTjQvr/S81GR/ULSu5mmhOsoxcUX1EH8kcJlxH9Vd4oMeNi4N2HFMu1FszTGOUNzIAzgk72QrFsm9B82YTeGJqniNXB98KbXu53MtlSQ7QAm0/G2gb+mXEmaWKRdMtfkkyhVCTqkX/T3J8Vr6KgIu6EALJ9JmAoVQqgZuAzndvHvIYtxx6doDvvPTzbRDTf8kXF8ZgEnE3DVfP6YOYZIfBLb8c54L/br2lcmwdPp7KQELWh9mFExH/sDPyR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36840700001)(46966006)(2616005)(7696005)(86362001)(426003)(82740400003)(16526019)(186003)(4326008)(81166007)(26005)(6666004)(316002)(8936002)(82310400003)(8676002)(356005)(47076005)(6916009)(478600001)(4744005)(5660300002)(1076003)(36756003)(2906002)(83380400001)(36860700001)(336012)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 14:22:15.0626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4498d8c-2765-437c-d288-08d929bfa615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
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

Add the parameter table_freed description on function description.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b4f189ab672e..9db1b64d16d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1823,6 +1823,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
  * @adev: amdgpu_device pointer
  * @bo_va: requested BO and VM object
  * @clear: if true clear the entries
+ * @table_freed: return true if page table is freed
  *
  * Fill in the page table entries for @bo_va.
  *
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
