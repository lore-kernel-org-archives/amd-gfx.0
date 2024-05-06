Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E94BC4345F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 03:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECEB310F25B;
	Mon,  6 May 2024 03:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RzPJ7+Ms";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C89A10F25B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 03:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cobMsyWLHoSquY2uReA3ei+M5oNy6Xyd0MZI+dyzsUbxlqmNHQ16MUqsoG+DXN6LRPmukJbx6DcYOLey21rRdH01FJhGmewWuf8ziUjEyJduS8hQ23y0Irj4TfFTdkZd3WIk8lNJb9s13W9ld32PVjGqodDzUWSz245f3FxUyVdtDu26P86V6MrqTZ0yADDzZ8ntYuVQnmJYv+4TMoLdy7u4z4g1H8Lyl85iZVw7eKUyRtCAxtgHly091cZ73CExyWyF5YhnQU/Uq/OeUnph9yqyPc9sjCqvZIwQvJUKlNvycksl/6JVp7dJUCOMvqawLhkFuMi9YXtbvuCR5ViYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z/Iw8ZkbosyKcMNgSERVMLH4bvyCJFJpCLdQ5ahdrk=;
 b=fzjl0PEQkEfFkCA+9DMkPOLJWpRrsAMV6+gvN17QLBA3bykh8EodWWn3fSCSyJr3Z8lwvcatIfjGqR7HOPv+J53V/7Z6f+gn7k3ZfDd093LEsshYRwRys/+mCxGr2Ya0Jwq2fzgGigXarRcnFsgK14Pr4l7YZzMevtrU0Pve1dRafHrECPQ5X7T7BioMgVNyc4R5bUAveC+lZGMFnTcx+D34r0GwiywUaHbxla9rjN+0cYp5tHnKpR+Ng0taOoJ3oGZg93DjoMlBf0bhL84rXE9uTLiZL+ePpXVAXZJrz91x93ZGpVqFcexUQadCHIDlU+iDjlhiuq4BQVFiI++nXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z/Iw8ZkbosyKcMNgSERVMLH4bvyCJFJpCLdQ5ahdrk=;
 b=RzPJ7+Ms4HGUHFqp6xFjyIe3/oI7ofwHWuEHDkYQ2XJHtJabbLzWhiSU4iZZAz8eeQTVUjdYWMB+O4JuZzo5x9dmgUXkBWTZalPNXAOoyLXIIcvg99GR/zFcPT2dwdrBaVQ6aL5ekC7a+8VM11KPsAWNFS6DindUEpm3Tc8EsL0=
Received: from CH2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:610:20::17)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.40; Mon, 6 May
 2024 03:31:28 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::96) by CH2PR07CA0004.outlook.office365.com
 (2603:10b6:610:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39 via Frontend
 Transport; Mon, 6 May 2024 03:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 03:31:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 5 May
 2024 22:31:26 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, kernel test robot
 <lkp@intel.com>
Subject: [PATCH] drm/amd/amdxcp: Fix warnings
Date: Mon, 6 May 2024 09:01:11 +0530
Message-ID: <20240506033111.17883-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4a5878-f85b-48b0-2885-08dc6d7d03b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WBIXMqsMh1YtkunvZMYbThoLq/HKjd+SKI7MVQOXA+jKyLt+CRZmi2bOt+dC?=
 =?us-ascii?Q?8qpZIK+gLQOTy5llfdBK9KBdktvsssZLR/tHNUDcJMpRKdr5N+Utf/Fni6oT?=
 =?us-ascii?Q?NwZQCXWzzNHriZaa6czYENJVDvPPBDHNYWZJX29oqrcIYRSXVVSamffJ/v/J?=
 =?us-ascii?Q?DVBcH4rNOBmtNfm3XWylCFlA5JR50UDky4G9k5le8GFIGZEmIqcMmvhZLnU3?=
 =?us-ascii?Q?9pw8JbDkfZJm6xjqIYsEhRVZH1Wo27XuSCg8+F1AJvYJx74Pb+NHpf4u/oXw?=
 =?us-ascii?Q?jGKr9VVp0OokkeVf2/rwimYwnRsgpU6IbJNu9Tz8HU9fmwlc+jS5ZtNKLqzz?=
 =?us-ascii?Q?HHtcXd+CxM4N/N4a2iELlgha57DcOZcQkt5zQwiQ3bIOXBL4oEsTTK7SmR8i?=
 =?us-ascii?Q?H8xtzIEqEoHWOnCVhl2yWYm1VBMlk71KwiPeVgVtWoW0eS3/ASU3CFCw1BLD?=
 =?us-ascii?Q?9zzv2wp6XD7eSR1OWFvu4yA3bs5hrUp6VNFpKHKRhkzjXLcyvqSBAsM9f193?=
 =?us-ascii?Q?c1m1C6w9wpjmEV4YAD7TCOKrIPJvJkI4HqLrmBC6EI7QwzkaZ2fLtzw1cgUe?=
 =?us-ascii?Q?06/MLxI1EW27kWQnC3tBg5eCZ/TgH3pH7PaMG35pVszUYfRaAJ/qNi/yrsC9?=
 =?us-ascii?Q?YGhTmv3jXKAHftzQc0yKONu+bqJXoR2s/GE5rC3Iwg9yVZTKnDnTe3j+osOW?=
 =?us-ascii?Q?2KthfEqnfFuDKsMWcOrOO1xhINDXG+YKz7e26w1aMrpSmM1TScYtE7RFO1wB?=
 =?us-ascii?Q?eCIO1CPnNLgXOgIbmKoV1zJqr20bH33k24CjWA8DoXSUpo7BaeMY4ihxGswG?=
 =?us-ascii?Q?GfGzlrevAz9fOu0rWXR/LFYZ49tReWiCoisuDAtyohrss5POAiVvF4XygUa8?=
 =?us-ascii?Q?O87pDUHfBfZH2uFczdgqi4YYHIxMZP6t/uC0s8q7v8XDepEMBuHy4gDZukEW?=
 =?us-ascii?Q?8x/4OdFU+lvMgTvglD2FwXAE2W6CN9vR5eN3MV1XULLbiwuw4tM60zw91neV?=
 =?us-ascii?Q?zYaFWCcz1n8yzijU5xwdPTPoMyZfGpZ/fxoxB13CXekAcnQmu6vpf8bvNfj0?=
 =?us-ascii?Q?C/4fkMc4rHseBUUCP8zUGUl9iqiABlv4Ra3BI9hxyu0rCvDtEF8nn2nL4kbW?=
 =?us-ascii?Q?+ygjZceRIPweSiHAeM19iLpReIKyoLnF7+Odcl5BwfoA40K4Gy6FlrSaE0eh?=
 =?us-ascii?Q?4aaaWoEwowsH1kD9fy1vxAUpc6Ib68r5gygrYFX5b71G6K8ME5JAl5CS2wCv?=
 =?us-ascii?Q?171/k+3joM9vB0hfEE4Wq/7UkI4uvRw+i631LZ7L8fkfct85rcE09iKmTjCR?=
 =?us-ascii?Q?ivQ7uZOSFShYvleLdD5I6cybNuwlOrZcaAqQunL9voDaazT5vPagBUYMQRDI?=
 =?us-ascii?Q?ybXDpB0QYhZZdzJY1KAtVdEJ+7CE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 03:31:27.9817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4a5878-f85b-48b0-2885-08dc6d7d03b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
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

Range of possible values of pdev_num is 0-63. Use int8_t as data type.
That also fixes below warnings:

>> drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c:59:58: warning: '%d'
>> directive output may be truncated writing between 1 and 11 bytes into
>> a region of size 9 [-Wformat-truncation=]
      59 |         snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
         |                                                          ^~
   drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c:59:46: note: directive argument in the range [-2147483648, 63]
      59 |         snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
         |                                              ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c:59:9: note: 'snprintf' output between 13 and 23 bytes into a destination of size 20
      59 |         snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: f3b4c9a2746c ("drm/amd/amdxcp: Use unique name for partition dev")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index b4131053b31b..faed84172dd4 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -43,7 +43,7 @@ static const struct drm_driver amdgpu_xcp_driver = {
 	.minor = 0,
 };
 
-static int pdev_num;
+static int8_t pdev_num;
 static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
 
 int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
-- 
2.25.1

