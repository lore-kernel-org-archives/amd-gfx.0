Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC0AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 14:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9B210F9E4;
	Tue, 10 May 2022 14:36:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A9B10F9F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 14:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqM1+mTWKaouhJvISpjqHCDYzDGLchH1FvsRry8JeBPJv9ZA9VnAzA6teCjV7XI2/57N94G6RYiYWtKKcE49epMZt+NAV3Ho4JqY1JDETVtlOHuJk8KPGKGO+sRAQDEEASinDA+ydZL8Ug9wGBvqQqzcDuPcCoDSzrLz3KLiGmlOhPBfNA5vKp54ZGhgvRGOT6m1R0XIPj56VcpssOdJP/5GfRqrcfgWP+ZsLGJ3zgupKJ+Lg3tIblhz9juFEJ2CmpnmODmWBcOkT+YhMBR9uUjE1BgKOkp7leEnI9zCvbW9t7kfVizS+FPmVtFfTClG/3+03w5nFLKOVUF2TpWHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BkLfBEstpX3r6z3xFk98SmGexbGhMo/6GB2C1gNFq8=;
 b=WYI4ecmQx3ivJpWkz368Aki+jC7ceNBs3PzIWpgLjysTpeUAvKWMshKKiPKRAnJRXumsruRL+cZCi4P1PEGThFNUwiqV0emfyo0g1MgdiI5vgvY91/nGdNEaBs7cFxEkSQnPMtVWAXv5/h7zo7Vk0TqNXjHqjUSyzJ+WRAh5Awd558u0dzXJ18IYTb5Nb3GMahrm76Mj5fWx76IZWPrN1rOBbhR1yIOoKrhdFA0bXeYHuMyAu0bJEGFuC6Zf81lKGP7GulD1zzAYSH7Wn8aiYHncmY7akSn3VosBU6TVdkW3Cj2k45xA7xBWQRwP7FuWqeEC2iP/yVrZqh7X4B47Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BkLfBEstpX3r6z3xFk98SmGexbGhMo/6GB2C1gNFq8=;
 b=h5rNi1x4OVsoLCvtstw/1HDBvtdN/Eq4hXzo24fesgWOsrW/xCbL5FUfcMR1vOD8FeQt9zfxlm+28UaXwJhNGaxvaZuX9VfAfoyMhnOP2/ybffefyDWJVS0gumKaDJimKgbSCiMNrhau6F13/Bpwjqc+kx7MXO+ozmCdwAZ9Y5c=
Received: from BN9PR03CA0705.namprd03.prod.outlook.com (2603:10b6:408:ef::20)
 by MN2PR12MB3664.namprd12.prod.outlook.com (2603:10b6:208:159::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 14:36:29 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::a0) by BN9PR03CA0705.outlook.office365.com
 (2603:10b6:408:ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Tue, 10 May 2022 14:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 14:36:29 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 09:36:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: vm flush needed after updating PDEs
Date: Tue, 10 May 2022 10:36:06 -0400
Message-ID: <20220510143606.22282-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2690fb82-9436-428a-1dd0-08da329278b9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3664:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36643349E60A2F229E0D84ABE6C99@MN2PR12MB3664.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jc1YdeqWuijfggO1BLmE89LXlmsA9aQ/0LP50Z060qh3afnlZSdxwe+2aZ4J4gydf6BiTlFdfVJlM6cbkp1B7NpuBxcaOj15qR1NHhvlOHPXw/NBdMQf57rjtU1X/t2OTfr7wVyCaDc4WhZHChrYPD1EQUa0jCd2LDngM8AB9w412eZEAn+qrFAVd4zAqUvC5+ePO0EocZ1Tfimcv8JezwQvJrsK52bceFmWH37SMUh1+Pvfc4aD0xQNLB2SDQbOnwy4zBUo7nULRGLU680Fv7VnzYFqhUQtim16UczgAzhUr61yaazz7V39mWM0jUpOfIu8OTDvg3Ixku0ux7h6ZRyXeV80iAHoYZM7ayCfWyPYWcx5DBUiATBs4wLmLFmxZ/aOmRx+gZOcWtxws+CoH6PoOrOr1tTNctrpUDOyJQfrfchNzGl2l0pq8W13t0HZirQUEexmvEZWrU2WoQce31PjaEMt0aqqHYYjAG4V45oVo+eJUZ5mCgeZGgRGECj3h1CilGmj9mX7Lz3/YSSpMJSyZxeyYTZ8dy+132cxGPpJbono3LRK3+RCzQziiiT3f10NFwDTfx2JvCYtdLJhTXCIzHMoQF3WIMva09exYXUrz8O6GdAit0bYX+Ru9LSdwfGmfNjtjObijj0ZcwKzLtFhzYuAgVVAbvgjvukxivfQsjrpkg/o8S/Gcz2TqaZ24dlitIg2z9U3y/cdg42WUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(186003)(36860700001)(70586007)(2616005)(1076003)(4326008)(8676002)(4744005)(26005)(82310400005)(8936002)(86362001)(6666004)(54906003)(6916009)(7696005)(426003)(47076005)(336012)(83380400001)(40460700003)(356005)(16526019)(81166007)(2906002)(5660300002)(508600001)(316002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:36:29.7733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2690fb82-9436-428a-1dd0-08da329278b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3664
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
Cc: Philip Yang <Philip.Yang@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If page table PDEs is evicted and restored, after updating PDEs, need
increase vm->tlb_seq, then amdgpu_vm_flush will flush TLB before command
submission.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7276b03ef970..9596c22fded6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -764,6 +764,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
+	/* vm_flush_needed after updating PDEs */
+	atomic64_inc(&vm->tlb_seq);
+
 	while (!list_empty(&vm->relocated)) {
 		entry = list_first_entry(&vm->relocated,
 					 struct amdgpu_vm_bo_base,
-- 
2.35.1

