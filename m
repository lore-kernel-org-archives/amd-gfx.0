Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A8C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D34B65273
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D34B65273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 066256E204;
	Tue,  9 Mar 2021 04:10:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739576E204
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 04:10:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2SaRg5WYcCs/+4LlGwx4o28FJ7hWUF73cudgCqDOsm9DaN7drOjxd6LilZC/ksEIn2zcmzEW0VELE8pSle8OC3HQkk47Z78OKlzmukJsd9eqtXvrseiVyyRKv6xNhHmIZ6a7C2R3Qyk1MYiG7wCXP/TQ1wO6TgRrqrwm6+t6qlxnnFnce39BGTgU98EadoUKaS6J7a6KI+tILh9d86cHqVTvb8twlh23FLlasCtjJAzc+yGi9f9DeHSu1btDRUYC85ebsDdby/ukl4GqgazYyskF6mY6XCDfiYbRAf6NbfyUZ2besFNH3HJuLYVZcIAJfQkBwDVzaQqDc2AgDAttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQUSWdV0NG8oYmiY7wgKK2qfHsUKm/sOagtlCkKtZAE=;
 b=Nz4UTeUhlBrEXI9L30wwiVUSaKxwPt8Zf4ZjJl29JKLHaXiQTq45Q4xiEuy5phdxQgG84V3OnziGF/vAZHxihl6RQ+BFhzZ3pyfbmVX0+ZzDRxVw2FeKcKYbtngJPsW4Auz+MoZoaiG5tmYyKauUkt9ImLkj7Pc5uZMHLtM6uW/WSUYVtMdrW3CarXOkKjjS3PHGeJjSqiRIrhLHrzfW2NRwjL7w9KQhaPQRl0UqREPnKOMmfgx3zooNU7lkTJTk/85+jd3JaB6V/2DCP/OFgZbl7uPTZaYdQcSrKRzLFNCAJ/+fvAWJSuyx3jIlRorjERUJAsDKgFoLWetU/K/oaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQUSWdV0NG8oYmiY7wgKK2qfHsUKm/sOagtlCkKtZAE=;
 b=Fl2558HopbnSxwWEW8Sc6PIDmLIUsiZ40/0YFajes1JFhM1qKmXBFtEJ2XBqujfFLHiyJTUidd+8ThdBFnPIopZtTWiamAW93jTmRN1g59KQD/XpO7fb2rG5vz/HrD3SB/s2wzNiGI0p9UPBFJ+Vy9t0Dm+EdtJsWBYDtLCJ2H8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 04:10:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 04:10:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/amdgpu: add a dev_pm_ops prepare callback (v2)
Date: Mon,  8 Mar 2021 23:10:06 -0500
Message-Id: <20210309041012.23367-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0389.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Tue, 9 Mar 2021 04:10:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9bf3bccc-fec1-4102-1118-08d8e2b146ea
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB448640FF8FF1906BB7BB88B3F7929@MN2PR12MB4486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfYdanezwCT/IRb50GpwIIOZLw1WLbVGS6iCa2BzA6AuEFZoba+kkem6ie2ycN+aPoAMQU55R+P2qMo2+Bf0nbYQUuLhFZSWPzCw7VvHBDjOKkTaAHX+B3tSDmiKvec3PwJtCiH1A/dtvufRHFRSTqpRJf3OqugR9j95WC7wltIFhB5D6JtoZTVBITfyFg+mqs2RclzAoaxxwx6lWjVwge1cLljjU/9N+G4f8AxsWpsdfOzajxe5vxaZ5Pr2xxU1MdNdEIN1JLmd5shMfez+N/SKiuWd02sQIpMqidsWJwWGc9XKpbCMBYUIhIekIdalSpEBvs3Tq8w5+LneqKWfSEZY5NkImeDPsnY02sTwpSAYt887hggRozE8yi3uM8l1IPmmOQoFWMt5ZevghF8+FNFV07KJl6OgpAiXaLyXgANaWEICFihjZ1XinjyvRwzO9Rrueq/rdXexhQS3K9CFQueY1qP9Iqy2Od4wezN4kZoZKSCH7CnXSFN5ovMBIzZTlF66cz9O8QAZPJZ3gRqHjuKYdDviX7p6t9MAOfExcYFlWuuNu6PTUwb/H1MQjovfwujsUscPuI25Xiw3kBkCNAttsqz98xHb5Ys/lu+Q7Sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(478600001)(316002)(66476007)(5660300002)(16526019)(6916009)(8936002)(26005)(83380400001)(2616005)(8676002)(186003)(36756003)(66556008)(66946007)(956004)(86362001)(2906002)(4326008)(6486002)(966005)(1076003)(6666004)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5YUQ7HiWs5AZcSx8+0l6gt25Fc7PKurlyjoRrWBuvnnp+a1aH0k2F7ZHA0XK?=
 =?us-ascii?Q?JYKOJaFvycxYjwXPGACy2guuwgXxbHNjUs1kOE1OpjYyYTZ+lw+5dOQbtchm?=
 =?us-ascii?Q?arji2O6zPTvR0kHwxnR8bWiNxBlEoNswMBz2I+NkOTP/i6XUEofgI9CClqO0?=
 =?us-ascii?Q?K8lYLqVitcDCXjM84eE8Z8MMKYxl9M5+mHIXz33xW1DC6N8+WMxVoQxLv0Ty?=
 =?us-ascii?Q?UXtsOtSIJJ1XNHhim/7sTKqMNuJzfKDG19B79Ec/twYMvWtAmFtljT5ZVep7?=
 =?us-ascii?Q?Nql8zVwlO8aeT4QDGR1FQk5+zSjSV3Y5o1QXLb7qK3qU1To4Yf57Yag2gQs5?=
 =?us-ascii?Q?LrS61rHNyYmZyVJQIJ7reME7nG9clgZMZM8jE08FnVwJfdHrLaTOtd/OIKQa?=
 =?us-ascii?Q?6j2Yu84XBQC7wHEursNC72KiXx12KxlPTdyGlVmJ0L5y7HhSUFCDgY+yRq6F?=
 =?us-ascii?Q?Ddkx9lHvkahe4vx8jkCZgBMSIaMvVL2A8ZWY5YjCinqrERY1xeGvs6Zk5pCX?=
 =?us-ascii?Q?/uiR+bvvB9vfLCLk5PIJYy92K/XncTCPT04EhO0QY6OwlQsLu8vbO9hjH+Uh?=
 =?us-ascii?Q?zqWjYJnvXBsDfvxBBYfjCnY9/FiD5LyRaBFjx13i6MHihwZYi8Aw9iSQIV4N?=
 =?us-ascii?Q?OWnAHCmGYqdgpXyydgh04D6rktoXcFuwAJZnizh1AutgQy1PuaOA/mQbjhmw?=
 =?us-ascii?Q?ncveAcbnPLmVlDNpgZHcYHghpNFuFOw6qHdz2VVR8qHagjqixjvfnbJC+9FM?=
 =?us-ascii?Q?ylGTFpdtdPYrnInOblUCRzjrrHQlpc44sTLZhYaSCJAbD9GFEOVrXVUmi8sS?=
 =?us-ascii?Q?28L8UofebTdp+r9ld4VFUY9C3C4hLzIueD+vM4+MrGdNZ9WCiDM309YWJYds?=
 =?us-ascii?Q?51sKQ6h0uduBgLxBYjMw8Rns8szBm2YHsa2XJF7HAv5tL1VE4x9XiQBnHG5s?=
 =?us-ascii?Q?m75bVXynSEJQO0PZRZ2l68w25Fjc5XjVO9ANFPwjRPUEH2wGGNUfEL75AgL6?=
 =?us-ascii?Q?HMe4sCY3N/5tr65ckoVgM6H1Zv1/XHuoIbNhSCRWCDI+nnatxd69nx5xP3vm?=
 =?us-ascii?Q?eTPERaJMV/7ZOctS9nmEcTmMr53lCMknm2oUtqhgNyn3OVeq+yBb+SvosbNH?=
 =?us-ascii?Q?lWqioJ0iyVuPYlro/8HrdbtnWzz+XRw7+/Yke9xXBinqkQs+YD0Tvi1U5lbh?=
 =?us-ascii?Q?eLsVW6Gr2sfLBRLMVOssx+sc6ke7Hbs4FbH2XoP/9SEwAUMPypwa+juPZQM5?=
 =?us-ascii?Q?MK4XSc8JqQJtSuZQoq3HmXE3RzIouwBVuBAXMp+PXwa9jj6WeKo50xOZEMFb?=
 =?us-ascii?Q?WLvnj4/sIpYOFX0+/sYklCe/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf3bccc-fec1-4102-1118-08d8e2b146ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 04:10:30.1789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PnnNVQtV0wupKGO37rWx8qjeJAaPoUTNf7Jv2ZgOx6FGUFSiA61WRAkqy9ZoosfzkTDjj/cZE2XYmCZizE4Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

as per:
https://www.kernel.org/doc/html/latest/driver-api/pm/devices.html

The prepare callback is required to support the DPM_FLAG_SMART_SUSPEND
driver flag.  This allows runtime pm to auto complete when the
system goes into suspend avoiding a wake up on suspend and on resume.
Apply this for hybrid gfx and BOCO systems where d3cold is
provided by the ACPI platform.

v2: check if device is runtime suspended in prepare.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index aecf7baf219a..8d4fbee01011 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -36,6 +36,7 @@
 #include <linux/vga_switcheroo.h>
 #include <drm/drm_probe_helper.h>
 #include <linux/mmu_notifier.h>
+#include <linux/suspend.h>
 
 #include "amdgpu.h"
 #include "amdgpu_irq.h"
@@ -1293,6 +1294,27 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	adev->mp1_state = PP_MP1_STATE_NONE;
 }
 
+static int amdgpu_pmops_prepare(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	/* Return a positive number here so
+	 * DPM_FLAG_SMART_SUSPEND works properly
+	 */
+	if ((amdgpu_device_supports_atpx(drm_dev) &&
+	    amdgpu_is_atpx_hybrid()) ||
+	    amdgpu_device_supports_boco(drm_dev))
+		return pm_runtime_suspended(dev) &&
+			pm_suspend_via_firmware();
+
+	return 0;
+}
+
+static void amdgpu_pmops_complete(struct device *dev)
+{
+	/* nothing to do */
+}
+
 static int amdgpu_pmops_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
@@ -1511,6 +1533,8 @@ long amdgpu_drm_ioctl(struct file *filp,
 }
 
 static const struct dev_pm_ops amdgpu_pm_ops = {
+	.prepare = amdgpu_pmops_prepare,
+	.complete = amdgpu_pmops_complete,
 	.suspend = amdgpu_pmops_suspend,
 	.resume = amdgpu_pmops_resume,
 	.freeze = amdgpu_pmops_freeze,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
