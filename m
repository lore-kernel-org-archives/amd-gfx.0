Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9219FFCC9AA
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 02:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B8C10E1A3;
	Tue, 10 Mar 2026 02:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VPsLBCoT";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011035.outbound.protection.outlook.com
 [40.93.194.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1BEF10E1A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 02:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bY1y68RJqtbNjuUHFOM2S/Y8LLmCQ7/HAjWwvyVw802Qt2p0iibGTmx8yNuB1Tnpy7M1svVUNFrsKXBJ3c8qyjce1g6d/FWDTxJwlDGFLugWFhgzpUpJ59NXSj3dn0LE25Atj8IOWhGu7jzDFqWYaoYOZ8Ln6a5dT15A4Vnu/mw/ktNsjbxgUFSiRux7aEkdxl+gW/b7PzF7op02aoEzcGG11AY0i20gduGGbfL6P89sTrG6MpayxSiokfMZr9Oo+EkkaVe79wcJT6RdJfdjN5CoM/ho6XE+e+vkf/mk13ytxWeHMChp6kGwLWgoXWOXmFvi/nEwjMjFXsJBHLz3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKVlG8HbouuXaufvQP1hTeFxZPajh3yC81oIc8eNX4I=;
 b=tRy9uoXdqeUosPd2BNVf04ahi9QYyaKA8rJlCwUAK45xeYtssJ9v6r5r3MiHgopAjMCaQ4eL2LAiX6D9bCo6lBlsuq8dZgaw+5pulHMrfs1sxcX+LHDOE7hf3AoDFXu2ohibaxBVhK7ipTEiL9Zessq05FN/pJTs/yeusicDSiK60CTmPkMq0d2WrlwAivWd39U1WkScTAlYi9+AcSLfs47kC2qtCo1dphmuz6UFfwRsvExAtYGz+6j8xh2MnXpwlRtkBAENfkS3B7gFS8yiKa6V3loSUtRKv0oWzycz3E/Q4CnYIqRSVo9qerHfAIMzCU0pX4pRqiGtCPB3tuk17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKVlG8HbouuXaufvQP1hTeFxZPajh3yC81oIc8eNX4I=;
 b=VPsLBCoTJ5h4jnhTJJ2Jdi0rxUvWIR81ybGWTYgqK2kk/LwASbbv7Y2PoD4tjAZJTBMdtTfs3QdE4WoRns5S6B1o9z5l3wlw3KCGEq8RnOYta3p53DXygkZDGDhIHRkt/Bb6CHkN9rYhqddLHX7O8/84r5QGsOvJWrgZ/9u9/dw=
Received: from BY3PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:39a::15)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 02:23:14 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::6f) by BY3PR03CA0010.outlook.office365.com
 (2603:10b6:a03:39a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 02:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 02:23:14 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 9 Mar 2026 21:23:11 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH v2] drm/amd: Set num IP blocks to 0 if discovery fails
Date: Mon, 9 Mar 2026 21:22:31 -0500
Message-ID: <20260310022231.2838680-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f988a8-8ba9-4d5f-9fae-08de7e4bfb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: VT+zW2Tvivkb1wxyLmKH9fueIAy10TJoOXKRGG6DRI93Bf7RBx0cUpxhMM/aR8iMgyfCbSlGEHDr2xlPRVEiDhTposV4mkhx6uglgFiaSCsj2kO5yOGQ3H2nJ7FBx4QtlkIS6TTfg1tDpIkvXZcf61mpBvmveoOmRCls+Bg+eutUny9I4olXpgxo3aIEadHeAYPrvuWPIZb6K/GvOW/hgG2gW3IfE2uy4qR2Xog75JVa93248CTSpLJfSr265M+AbO6qD4/roPfzmonI/kaWpDn9bToitAOkScW8FTqlJMCbRzkoOReKXddnWk/TOyBQZAVE/lcGBLZNeA5zZusUh53P7XYnwmCjj084N5ZVbey7BNZ89kvpIFTehigBawaUxGsTP4SbJiLj2Xa1b4L9K6Yxx6H0fy/QJBrAgweFQO4oDBiCgJ/WABV61mASZRlCHapfETwFSDclfJO4QMgJinoJcyd9jiI+QzuK+6ByYO+oKrS3hfpGQcJVKa1fUJH9KplS07gsyT8/4wie7Dl9+L6JqlsAeHauNHu5yJbAJzf8yA8y7gAX4Cgvv3ZzoRQwet1MyZ4mS2pcRUXx5I7TYJEdYSK3Vv2LJN5dLHBh6aKliqak96eVq/XcFjX1Vv+quhVusJ5MkDNBMBnUo3bGG+qiFzpMT1YAC88/vS5SrAADYDp41mmnqr1Vl3Sru9yQ7Rf7cJZcUFGD77Ps/3kpdc0TmH+d0BS5pOEXKCRaNJ6ubNjmondE0L9x4TKBfJqDJrKRHFMRZ/IoH6AUfeMz0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d1tjY1Wp8+lQ7GXQRSSusw4HsmDZipN2OI8mfC0sZzPY72Ot6Pl+Vkh/h6DsvMsJP903IWteWMXMQmPiwPpSymqSuppiePOdWOVS5rFuVjySov10XrwRatuwFTwdX2OTgaqIBsLrKA8mRsdIjVMVa+FUVCpEwGob9L+6uArhGMtXZoY1lH2vgkmRzn81mUKJ2C3rJCWfssxMQ/Fb7jxJlDSOjiVJrlk+hIeDNO69asdp9K6ltua15YBK1vDpOxQzAixcNr6dHrCRNt1SULKqrvPu2J6+MqnhnZK2d3MS97JhP/kB+2Qpt6ZdQ+VAxNz2RL5MHfNaP82MGoCv14dvbABONCAS5m+sgZ90WDOukc220tv8O7pdqyHkTAnv3nlRFagJD45HCbnvt75l2Pl6QATD/Qd8v+a9ukaI4iep8irtTHeklprWNm30nI66rTsN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 02:23:14.0104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f988a8-8ba9-4d5f-9fae-08de7e4bfb88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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

If discovery has failed for any reason (such as no support for a block)
then there is no need to unwind all the IP blocks in fini. In this
condition there can actually be failures during the unwind too.

Reset num_ip_blocks to zero during failure path.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Stop chasing NULL pointers (Lijo)
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bc6f714e8763a..042f24a0e10fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2701,8 +2701,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		break;
 	default:
 		r = amdgpu_discovery_set_ip_blocks(adev);
-		if (r)
+		if (r) {
+			adev->num_ip_blocks = 0;
 			return r;
+		}
 		break;
 	}
 
-- 
2.53.0

