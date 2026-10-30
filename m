Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A868606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UjoIMNZS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17123112642;
	Fri, 30 Oct 2026 06:31:34 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD8B11264D
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwk6nyvTG887fjYPjNc6tqMrO+kweM9Jzg68eu0q/LfhlpYVYDgQ1DjHGKSHWOUPaB74fHDnMgDF/+k+zz9vcPadyT3btjtkdYFk/xcfC/4jxr1lXWdBaWVa0rDq3kF73edaDK3qgeircJGMv5t/Io3BKlB4h3eKwKbxDkU6xrAsOf+gYHm6u+ryR221I6R8yjy7vB//NzRGjK2CuR9IfTt9AuoSFhHhvsi69Y+4Z11EtU2yEa9B3SU/pQWWaCSgmJTT1Z0V1PfikFaycKnRlsRdGgxoeMWYJANv/Y6Siv8JcSj9ffO6t0YcINHyjhgzqfG8sllDvhtLNvv6Cx8PKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXnA6guHimyeBYzk4dBCZSlTc02ogwErAUkTHIxD//w=;
 b=ecweRvGd5KX8ihHtjWkWaTE/6Sur23OrUZgh5YmbHnYQZyW4U75xwGsHcYMaNDmiMBmDmxuIEVja7Y/lHOtUzGaJOlTqfD64SH4LiyCLjG7do16+p6zdS74u7bMJpMzidkAL1aU9Fg8vc8p8PZ8D5goGtpo8cTDr2mVNguH0EJIGKga2OCVH5bCsbat86vezxb8bRPZMVdnnXHQBY1zVXgA+PypYckunq6VnKuroHiewyG8APEfEumViwcU3DzlEHWHu9RDFMW1ZGH9qoNMlrK/qoF1opUbPIFlhbf8s31Uh2HOTAvJqEW83HQrvu2axmWdve3T80A5OaVEQtiZrCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXnA6guHimyeBYzk4dBCZSlTc02ogwErAUkTHIxD//w=;
 b=UjoIMNZSBSmUO8eu3nLvfSdvYblP0YMPwZgLrWFUIFcXRiKg68ujZQVHvwRkqocpsOwl6lUujW31FAkgi4ub8Km+ro6jKvhZQofbtKMgwT/7rtzujtSWIiEtKrLOGAR5+UCc7wUXtfinnDUOAMMr4qCsEW3ra9hrFfQGFk9+jwc=
Received: from CY5PR19CA0001.namprd19.prod.outlook.com (2603:10b6:930:15::15)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 06:31:02 +0000
Received: from MWH0EPF000D8953.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::56) by CY5PR19CA0001.outlook.office365.com
 (2603:10b6:930:15::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 06:31:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D8953.mail.protection.outlook.com (10.167.249.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:00 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:30:58 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2 RESEND 00/13] amdgpu: implement Performance Monitor Counter
 support
Date: Fri, 30 Oct 2026 14:31:28 +0800
Message-ID: <20261030063141.2773032-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8953:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca9b344-50c1-4a6b-161c-08df364f5d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|261026140227099003|261021123027099003|18002099003|261028144727099003|261009223027099003|11063799006|56012099006|261022075727099003|261021121427099003|10067099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: RvcMVTow/R6rQ4hnvhiRnHaoUeaICCK0L5T1E2mjkKYAat+1/O/cKi+xlfzMwxKjiwKGSM+6gANLcxDitRlTS/n6c89bvj/G+bMlz4yTkEJR12OUOtvpqaTcBPkeBvaFe1h55CuNMdMh9VnqrUFemtuKSm7HE+yXDc94raPSKkQt6npd2gLKz+B6ABn+BOn8zGEOwaoKwC0az0zoOjfRnJkAEJCRAgP/8lK6JmJgoO89v5LxTtL4fGy/zO5BX5XHbLfsl5SV4p5i5RKqyJ9lHr8rw04ioZYmhhkOld6RpDVRVFTXuGxA7dc94hijrlrN+nd8O/dGVkmPVpX6/mBdqXq+YyR3UY0LZQaYTTRA9rAH+fmJHlfhK1Y1NJ+FPCY3kfES2P8sse0KvHm7ivFTnAB+sDsb2zU8Y2RqWSIwMLnw1l9KCOaJWb5+fwCaiuwwMbJGhrYksUSE2CV5w6jx+Hjrbc/VYUrlN3D8p4eK+5Vb24SNoOsy18qVKpM9VD2ojaOUWP9xfrBgWlRJpBrJJYnbeUbdGdj/iiRJOBKAHhyLolchc5TUni/BToV8TY8WugUf7Y4vf5/gJajeLntdK/MouMkm0jUKcTIhZkwOGr/GFaQakPxbevUykKJ98P48h3Hpv1PEYvantwhirvWleaTh/ztn5m3JhgBPTVwm2VbhqkNA4NOt+VcpBrpQheu9Noj36MawJ6jTXvs/w9PkEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(261026140227099003)(261021123027099003)(18002099003)(261028144727099003)(261009223027099003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(10067099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /wvHcZ40yKf8BjUs+msVVGkWYeqV+NnECppEgwF5xl/CuJ97Am1W7gN1peDGUrjfItKIiVPnVylAKayZTdYm2Xoo+XtGbo9HLzaHYFKK1qIfbACIPP0grAKVrhVXYHIvhVyMdgK3OZGl+jAm/cauVCgVEpa6+qSOrRE5+dIYWJInU6SpaNqSoHBB5ta4c/qBVizGU7NImwzyrEqkPZma9/XXHtKpV+zlrbl+Pq7tjRmERXT/75eCekJFYbAZdSOhOMo1HI3kPWk2Jxpj/eHZk2nPNW8PU6phYn/sUM7D99m4RSrenm7fVcOr6HyN75RMi04sS677tChx68XAUlrYN53YvHkRHAiXWaEcVV4vBt7RXuJfNAif0fq6h+Pu5W6+DWlukCZH9emrDk0F57Qh9TaGIeIlQw7s4NE+Rr2fSy23pWT4dgCZfIrYX8MnbK/y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:00.7391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca9b344-50c1-4a6b-161c-08df364f5d7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D8953.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

(Add Benjamin's Reviewed-by tag and resend)

This series implements PMC support for amdgpu. Including two parts:
1) PMC Enablement
2) Profiler Reservation

The user space should take the reservation, then set PMC.

Changes from v1:
1) remove per-IP set_mqd_perfcount, use init_mqd with modify == true instead
2) squash amdgpu_userq_xa_find into the caller patch
3) keep CWSR registers when modify mqd for GFX12
4) minor improvements

Zhu Lingshan (13):
  drm/amdgpu: implement PMC ioctl framework
  drm/amdgpu: add device-wide PMC config
  drm/amdgpu: introduce PMC ioctl handler
  drm/amdgpu: implement reservation mechanism for PMC
  drm/amdgpu: set device-wide PMC enablement indicator
  drm/amdgpu/gfx11: set mqd->perfcount from mqd_prop
  drm/amdgpu/gfx12: set mqd->perfcount from mqd_prop
  drm/amdgpu/gfx12.1: set mqd->perfcount from mqd_prop
  drm/amdgpu/gfx11: set pmc_supported for GFX11 family
  drm/amdgpu/gfx12: set pmc_supported for GFX12 family
  drm/amdgpu/gfx12: keep CWSR registers when modify mqd
  drm/amdgpu: implement device PMC handler
  drm/amdgpu: set userq perf state before publish it

 drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 183 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  38 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    | 164 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       |   3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c       |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c       |   1 +
 include/uapi/drm/amdgpu_drm.h                |  36 ++++
 13 files changed, 451 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h

-- 
2.53.0

