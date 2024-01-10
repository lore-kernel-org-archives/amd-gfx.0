Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AA7C4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 15:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 877E110E077;
	Wed, 10 Jan 2024 15:56:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1502E10E077
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 15:56:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF2tlCKDQq7ruMkDEFywBVqrBaYrSSYdOkErNThybyDH2M2nRtAs0v8KQA/V3Zri3g2BQyyz+tYuDbCzFzFzp1fvY+9Ael6LB6gS7kpgWlThMx6UIJOm0zjWe4dNsdP+djMrlf5gn0mSGw8TSCp9Gxtp/py+9I6EKjFR38ci95AkLqmII5E7/iaddvbIiDTdr2ym8r5POSVmPokJGxGhqoOgLCTYK77CwiWLSBYso+1pG/k3NBT0whVjJxhnNmidxvKzrraqA0I/akMvhcq8pXAPk/3VMZL9Cn0g9XoVkY/dQdoNfZ19U8Vac+dpcQdo+U7beN3htQXBCxx8LlvT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAjKz7gqP9T46GTModvCAfGQsMOwPhtISeJBFFm7eLQ=;
 b=l/c1Aoodi8py8xBFyhAxcklQ8FS7yyZ6LXTARjFh42Vz2pk/dKjvVdK1dkNocOwSr/M/7GN+AUSSoNV6P5pzC1nBcaLfX+4/ia73oFEvHqqYojy8JkMlcLA/p0cUet87VmwSPxJW9CDBUG3Mj8RNvwBuyspTGO6s1wUIPTCNt+p9mbwdC5K8IEBbFjuQgU08zHNbPonrCsqC8Rj92CNh+HQ+FEnZAN0XjYu+oLnbj+6s9ApoSjd5FlDCTvcBF1oL4maeAsRq/E9ML6kxPk7cloXpOSBhp56EZWx837DqPNkf2TgNGhZndnYQ17hvz/t56Pqy3ntMHRk+AAAySGEipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAjKz7gqP9T46GTModvCAfGQsMOwPhtISeJBFFm7eLQ=;
 b=0hUijhbiKcpTlSr37ppLjQBi/V8dH17U5q0vb+SSHNgBMxPkunmMKWbJB4UUhbC2QniFa/Ps6jr+Zv/j+5h693ZJunsAYwpSsdX7/OlCHf4RJH7+hmTjCfW6r9JtMAzmUtdwOl/z6qH+SKJKoamPmaIyAY20BURBCyJru1dA1ks=
Received: from CY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:930:8::18)
 by CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 15:56:15 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:8:cafe::5e) by CY5PR03CA0010.outlook.office365.com
 (2603:10b6:930:8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 15:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 15:56:15 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 10 Jan 2024 09:56:13 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix variable dereferenced before NULL check in
 'kfd_dbg_trap_device_snapshot()'
Date: Wed, 10 Jan 2024 21:26:04 +0530
Message-ID: <20240110155604.525797-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105105203.2776015-1-srinivasan.shanmugam@amd.com>
References: <20240105105203.2776015-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b370159-8a2d-42e8-5fe0-08dc11f4ad3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zErLTjHNx0MY2iCEoGf4rx2IN0xpZgkqj7Q5jE3Yi9h/tCyp1kNUR4/ZAX8LYtwa1oiN3ZVao/iGNzTrdEdhNTRljuqyUArpveL7L1iKm9X+OOMY7TVsX6D2O7DZ4j4MG/LfUSBHxPvr34Cpx6HX0darDOMcK8Gx7/yOwu7NRXuWXjshu5icOM50akuK2pGidlHnai8eJModzBPS61wRuwz12f30F2wwUMpsKrMbb3jWboa5QXKc/Chgv442bQpSj4J9QGs8Zyr1vOzwm02z5agGbYTzhlYiOCk8iTCqoQvym88poGj3Go3Pxq/40vrioYQAjAFo4bsvCXba50kN+ccb9lesaZdDm4nl3KtJ+ZwvZB+HEts6l16XeO6FWFlcDPDL4fgO9Uir5rNywyvQEoRqXKBuM4Ihm5hHrHrTxeYitq/ZtbFbKem57Kq6ZVPchunfANsE1qZQla4iUd001kxwLdHnIHkPC+dzqJPsx4M8uKUQoPut6dYeINXqxvpmBjiBxZ/VlFxTIkkLFoWY9G/00FDkLGGVD4AySl4TTx8dwP9+3qabEoutDNz/khi4KF3M5nFtpPi5jZJ3dOXeZ2kHmpXJazE+wyr8NIQVHSPVxT98q+uCPiNaa/M6HUG1bIM2gbllmgFGCgOxA7UqJ0TgohrROM4RdV/sCV8ATgKoomztDdYAOsduU5fmuFccfkVmhVNwKZUHfhoTKReUBSNJ9gok6oygqY+PgecId6+cYLs4GtABrlHvmIshPV4h3Gyh0kjiubPzGEsZJeHKUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(2906002)(5660300002)(478600001)(356005)(81166007)(44832011)(4326008)(41300700001)(8936002)(54906003)(8676002)(6636002)(70206006)(110136005)(82740400003)(36756003)(70586007)(316002)(1076003)(86362001)(6666004)(2616005)(7696005)(66574015)(336012)(83380400001)(26005)(426003)(16526019)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:56:15.4716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b370159-8a2d-42e8-5fe0-08dc11f4ad3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_debug.c:1024 kfd_dbg_trap_device_snapshot() warn: variable dereferenced before check 'entry_size' (see line 1021)

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - Changed from u32 to unit32_t for consistency (Felix) 

 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 9ec750666382..d889e3545120 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -1018,12 +1018,14 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 		uint32_t *entry_size)
 {
 	struct kfd_dbg_device_info_entry device_info;
-	uint32_t tmp_entry_size = *entry_size, tmp_num_devices;
+	uint32_t tmp_entry_size, tmp_num_devices;
 	int i, r = 0;
 
 	if (!(target && user_info && number_of_device_infos && entry_size))
 		return -EINVAL;
 
+	tmp_entry_size = *entry_size;
+
 	tmp_num_devices = min_t(size_t, *number_of_device_infos, target->n_pdds);
 	*number_of_device_infos = target->n_pdds;
 	*entry_size = min_t(size_t, *entry_size, sizeof(device_info));
-- 
2.34.1

