Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B9DCD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 23:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 616DF10E590;
	Wed, 27 May 2026 23:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ymWMqoki";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012052.outbound.protection.outlook.com
 [40.107.200.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD9010E590
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 23:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfyk9jjOlaIEe33oX5GupONFsfSM7ndH56u80WEbRAh2qAeoccxqjj6xxGqSo7tD3ND0XINzPCsUylS13+jEmIxJGHO1yiM2UsjVH+J9V/5s/sjgk+6vroBf6u1dUC8xgMbBiqy+hIfLSaT4vHP8Vcz2Mbj+mQyZnY+F/wNMORsmPE7PACUUoHxair9sj+pMeWOPZaGv8Hicpte4/LH3tWUnKvUA0sidGPbWWi0FY5w7/JMJM+4U4NjUtt5iu6TMLedgN674a5a4YAUDGGlp+v8t/x949xUjF4qwY32TxLRQw7CBYtohnBgYRXMBIAB+5tv7Wge9yQlRM72x70Pk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JP3A9OIHDrDsK/KRNgLyYXIaRjLwyL+sFiU4BIEWUE=;
 b=qEF+xAw0RZhBIfhdArupOPc7r+UFMW/pPVbG8OlMt1LJOloUQrq1fYM+qBkV3j9HKL6sU3ZShNgvSrrS/w+ag6jcBgAAh5gHXrajdoj7KxMaNyRzf+zoIXC2XVLUBKFGnyZqH380q437n3rmflacN9/AaU5Ta/prod13E50Q/lSUeYTP5EaXricgG6eNGY6sfzwqi/gUfKmXmNr1rf8FHwxOFtYNOoSp3KRsrjix+gt0wT8luZ4FPKzGcukvv1S/6qinaYyUd3qDHysuu1ODNRiDAUFSBkQMR05ZJnBW4mdAgRAi90zXalhtGYYMS3IFfhPK4CPpHKtbOhHEHbTHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JP3A9OIHDrDsK/KRNgLyYXIaRjLwyL+sFiU4BIEWUE=;
 b=ymWMqokiIbwLLvskyEsh9pfl9Pixo/xzJaunsgBkCl34j8DpsHOM2f+tPrCvfFEIFrF8q6Fpr8M+uwEU/nE+NKRWaH30axI7GUpWpq3nB3hGB/f52u2/hFcb39Qm7TYd2Wnw4mmXDWqtb8Tdnns1VCEJBSDStqZpV/3+Kbo3PCw=
Received: from MN2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:208:239::35)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 23:36:09 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::a1) by MN2PR08CA0030.outlook.office365.com
 (2603:10b6:208:239::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 23:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 23:36:09 +0000
Received: from yunxiali-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 18:36:08 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH 0/2] drm/amdgpu: balance GFX IRQ get/put across
 init/suspend/fini
Date: Wed, 27 May 2026 19:35:02 -0400
Message-ID: <20260527233504.1830940-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb54e21-beb8-4566-002b-08debc48baf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|13003099007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: B7Xb7EHjY6T0Hvz8XfdHVwbuRVr7Ntz0QcqZARkuAp1fWyFrOrnnDqHr/X9V5P0y4MSb8uQu8pgNd8Mckrtfi5+tAGdtCYqBu4aYGZmbkmDmlohnolfNm5zQU4efOofGBIYWQ8Q9mOKKQFdPT7RJZ13JunZssf8bpoRZbdL3VuScdXMewjWTesr0GfPnGA0zkllUJvewKnbaNoRpYT0w/UjLl6EbCJK8jAU9RBj9YZeqVYiWAjwAxacGkHrf/xacUQ6CrAil7Y5c3qTu1v3Jq6zowBtqR5HyT9jwHhBNPFPmfEhb/SC9tTl/7vDRZujr1++pQzGZXQN+6rG/dtr6t4VHpHtUfkrs6n7fQBqO06HRjyeVowg9PBMI19BE1h30MxdxojYC4ro3udhlxNW51vtLgjIu59cXPRZZ1DjdSuVOVN1EShVsiTR1XoOAA/mU0rd8HGMdrZ98Q2rb3MQjIPXoGD9VVStsMVaL+oMqRfmcVbImd+KfdqDwksDNMXBJWzZBGudaMUtMPy+ILorbWflKlV37aQLmS4G9DTKglFESR3veUVDJi6s6BZTkDVs1o/nanMlDUaTnxhJPIWzN07iclHQWSOq9pUSHEQAzunYL7VMGmEZnJbR5UrVspbpj0IGArHZrlAH10Hv/5yTzI/nKeibXNb8haK+3ICQWmcuTzTxusOGjALmhG86uqqwr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ay0qdGtdQzl1i8gjbIjfbaYUMDrTMCvx+RELLN5V1Cu5GL61O8zvRPwTVwp9AkXW8XGrinNdPZzrJ0X+LFAbQal40Rz7VKF/aRf+AujDP65kh5f2Kjz6tL+UpdOF2Aq4Dm6qvdz2wyt6ZkgCbaYvxlb5EJ1oFp3uhSzNk+UtP4i9qcJvXvTVmD9O5vBzLZoKENQlpJrXEnbsuERcsOBU1GqfmXisR/ejTAS69Im2KWBjAhVz7rVnOYibOUM3sZzin/pjfSbNbCeFn6YCNYsWsjQfsV1Kegpol0zoGKRqffgRrUFFtS8iQiXELUBBOI+wi1cZfCa228F8Bg8E6LuyuECth+BDhh0x1AiTAgsOlLiA8UrnWBVgLWHaAQHMUnKiqMKyn4+NG0Ft6NONGVmFAIdXIbrrP4xBnZFvoJw2Sne+DP7VX5lw03FJ3bkz+YgO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:36:09.2789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb54e21-beb8-4566-002b-08debc48baf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
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

The current GFX IRQ handling acquires the priv_reg / priv_inst /
bad_op and (on v9) cp_ecc_error_irq IRQ refs in late_init but
releases them in hw_fini.  hw_fini runs on paths that may not reach
late_init (SR-IOV VF skips the cp_ecc_error_irq get, an earlier IP
init failure short-circuits late_init, etc.), so the puts have to be
defensively guarded with amdgpu_irq_enabled().

Pair the gets and puts properly:

  - Patch 1 adds a per-block ras_suspend callback and uses it to
    move cp_ecc_error_irq's release into amdgpu_gfx_ras_suspend() /
    amdgpu_gfx_ras_fini().

  - Patch 2 moves the remaining priv_reg / priv_inst / bad_op and
    userq EOP IRQs from late_init to hw_init across gfx9, gfx9_4_3,
    gfx10, gfx11, gfx12_0 and gfx12_1, and drops the now-unnecessary
    amdgpu_irq_enabled() guards.  It also fixes a pre-existing
    partial-failure leak in set_userq_eop_interrupts().

Follow-up to https://patchwork.freedesktop.org/patch/728675/.

Yunxiang Li (2):
  drm/amdgpu/ras: add ras_suspend callback and use it for cp_ecc_error_irq
  drm/amdgpu/gfx: move fault and EOP IRQ get/put to hw_init/hw_fini
