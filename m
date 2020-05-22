Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1E8C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 07:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B4D2072C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 07:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="us3FhcUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B4D2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C5F6E3D3;
	Fri, 22 May 2020 07:53:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 587EB6E3D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 07:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qrbg9FUtwqrGvSqXHadkO/VYiE67OPm+YvPR9X7vXXBifP7qN35W4QIrXpuWY7s14bpgBB9Y0oUVKVi+dKMx9pV2gljNut8asdJJBnn7ebmaP8Bc8HN7m6UmZ8rrDUXPKMpBhNpT+dmNqsaw0fjPyM+nTi78/Jxl77fA/oAl+9fJjJeIqy8GKQhhj40OiCsbmqPfK9TQqToj4uxkBmRcLZhyI+2Ox8LwBfIibN8zyVNbDP1Fs/goZn0azuXTrjlQikYTDlj8BXyI3bOnLrEUtM8g47TjSMBVGMQn4fhjkJq12/jSOTkFXmUQwNdgvx7bmX1BsvzI8nzsECAYaufj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9FkbBX44COWpSbhoGqQLnoJBvGgTIQnMKF6JQvNmKA=;
 b=g6iKwoCECMeyQWplvvPnX+oQNBE0TaENvfHq4sqCsXEvJzU26LAdtuVflm84uDLM92fOiBqcuLJ+8/CtZZcjGNmhWyyqo5K2+FSIeMJQv2jtIBdHyHhWXhXLqiKKvbVSyLJ9DJi9C7EQH3D2Krd9igEhd6xOFileov2vOIO1XTh/cTbs9H6IcfJyHuzYkK4Qa4Odgzm/+5+BhSfjfMsVIUDnh1P+D3f7P07mfG8/LYrfXP758bG4TXhlXLvwrMyUJtdQwRvba57v5aFfASda1AJy0wIIB44ND4vMEuzLJc2y/L/k3vKQvHZB0Dkz75nuIxvCDcW4T54AVR9YEDdcNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9FkbBX44COWpSbhoGqQLnoJBvGgTIQnMKF6JQvNmKA=;
 b=us3FhcUnuihHJx1i4yUk3nrUS3uBNPIfq48VsaFal+U9ADxtoA6vNSwFNLZx5n4sKdo0sWOKZtPUcS8e6XLWRkzgWGs8u/+TgKNmnxE9nwLUTPJozzpeEZRqOUtcSTeEGW4yHnddw+1L0/+CWJHuc+nevuAZgeZAru6o9l8ySSM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1831.namprd12.prod.outlook.com (2603:10b6:903:128::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 07:53:26 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 07:53:26 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com,
 John.Clements@amd.com, Dennis.Li@amd.com
Subject: [PATCH] drm/amdgpu: print warning when input address is invalid
Date: Fri, 22 May 2020 15:53:04 +0800
Message-Id: <20200522075304.22231-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0160.apcprd02.prod.outlook.com
 (2603:1096:201:1f::20) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR02CA0160.apcprd02.prod.outlook.com (2603:1096:201:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 07:53:24 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4664bb31-b33b-442d-130f-08d7fe25355b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1831199C6E07BF108F4E2A64F1B40@CY4PR12MB1831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAj8VUn3tpMEjHLGnkdZP5uK5/P+LVQbPl05qJkhuI/ig6RA+GIs9WC1K/uPZTB08e0N9YEfQigdCy5laaF075HZPwlU+aAwT2N1yfkMEo2KXpJi7cMgj9hteY7ug4WNJNTU09V/LZh01Yq2p/ztWwQRY+YCp4HhTcj/FVjskmS8Oq7bqTuoNICoi/jfAtBWOf1vG0YlElLyxHzNSsq78vdgyVAP2iN4kvMOdAwfPEwNVV1YxFwNmJ46jfu2XZtGJj2tir/iDNwjQ0AqAI9LfwP8l5YJKKXIObhnrq1A+4WR9ncGShDURIn4lja8QONBf0WhnDXo++/KOy9ZIKRR5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(8676002)(7696005)(16526019)(86362001)(5660300002)(186003)(478600001)(4326008)(44832011)(6666004)(66476007)(66556008)(2906002)(26005)(66946007)(8936002)(52116002)(2616005)(316002)(956004)(4744005)(6636002)(6486002)(1076003)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CzmUbAUZG3SwRoiffj0+VcEjLoOZd8mSkRd891ytn4JbkQvmwP6aE4YMwou5ITDwKHVvEuHHa+ctZeyl+rSwJmmnmTddqBCLQ1iaL0KOyNyBXkutQucr3w/nbctWBrHf3950UNXW5FhvByhy1jlQltNXdNV0KAYcil++UCxwCueM29y0h+gmeRqLkuZOIMcqpZPu6j9AkkZ+FoysK8qFKLTG9LcoOCyyfl2NCTDJeOaPOBOIpBYR/FE0gMiMLBZPfDBUycXteuyLmj2iASawNDGpmAMZDcKVOdeUWANns02zWd8zaMI3ZLtNRJ3vZPwLDJLH9d+Ln5O6jABPqkvDVJglydCC0HSMxeewWjOT5OwbDLRk5UFvxwu5dMufTen/sflRPwKD7k/Z/hqzsJ69ihqnmujGAu1eoBzfhfVYPrnntGWHS6OtEZjr9YzzL/TZ5Nb5+kJrTfMNGqdsgMG6w6CKrsTtsjDTJY5lpu4VMo8XUzLw/UYvs98av+pSXV44
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4664bb31-b33b-442d-130f-08d7fe25355b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 07:53:26.2898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkuocMNVOJBEJKvYzSLulAsPudAsW+6zcs6qX4ChiFfVA7VSDwEp1Rgy3yL27byKMkMLI2xUEGFdR2JO74P6YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1831
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will assist debug.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6e911ca97038..5c73f444eaef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -318,6 +318,8 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 	case 2:
 		if ((data.inject.address >= adev->gmc.mc_vram_size) ||
 		    (data.inject.address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
+			dev_warn(adev->dev, "Input address 0x%llx is invalid.",
+					data.inject.address);
 			ret = -EINVAL;
 			break;
 		}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
