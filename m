Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22DFC433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6985B64EB9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6985B64EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C706E881;
	Thu, 18 Mar 2021 04:33:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EAF6E090
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnWGxHIctU2/YQL7tCurXhh43d2V699ctWSuWcEIP2eC1W0cZ6pFAVxzRag8iL1KnPv7+bUiqgMORMt57Bx3nxIOb94lXGcjI5mwj7ZxTa4psQ+goSwmTyTDINRNFTjgzLTW8ufuN4XsKNqNE9peYjsLXfxpVDNA1HjMTgqwkDDBAP9PBnAfYjv3yyfhszLZbDGtHl7RmqZT0o6kADixTQiPSDthTnStmfELuYGh1ER2B98n2J9mVysgJPtgYQMWbWNiI4dR8r4qLblxtFa4b4cMm9HbSYz1/t7lWWWey51eK6yzE5gNy1wJX+2AcAvrFee+eF0jdczalqvyPKuUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8VNOwDxhavoPR8eGifRMQIUa7xMVSCUarKM77dF10A=;
 b=OZ7aLAT8/m+zp0api8jWy5Z7IAyHKhB5Qq1LFuIhmErCRQdoc/VrBbJ44hnqAa61QBmkLgw8uC4QtYK37HO2dPgV5ImqQhXhagxsRwqPbGL073RzPsvolICWS1Fd3q4lHhbzMLqAFoBUE33YC9Dw0i3eBcU0L6B9ENg2GU5VxOgtqWH+2UFw90hgoHzDYIWcBmI0VlZXoMnhR0qI05gOU3iy5fWe0nn+4WC/+KnM/CnOHGRy/Hv3rD+pQsuduGWvPeTfJ+wCRLlHHW6DcTTZPILi27DfElLwQy5QcD9I61gmFndLNonTE7l08EPaiEha9pBGM+Er4R9DwVejXbd3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8VNOwDxhavoPR8eGifRMQIUa7xMVSCUarKM77dF10A=;
 b=gutO8hJzBy69dK+1Ue+uyDpGmbW/0o8BpYrA+e2jRRedhUvdu9EN3xBGqbWbcU85YVuhEzyHydNcMmv6zBQYGNbQsM0nzZmQJta6a2G5LdnvNrs5E2mz063cYX98kA3el5wg2WoMeF77pNeYcBRZNQwZVXGauOc3fX5k/Rz4fIg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:42 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:42 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/13] drm/amdgpu: add a dev_pm_ops prepare callback (v2)
Date: Thu, 18 Mar 2021 00:33:11 -0400
Message-Id: <20210318043323.3989-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 04:33:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 573f4b51-2cea-4119-c4a6-08d8e9c7025d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4016E17184A39F2E8E2A4C63F7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/r2h3LKJlfuTjSXtH32F+OjHGmginqhyLGxbFtA/asStBDnF8x+s2TK8ttzCGLvcA4hSv1OvLvzmosaKIvKkbIJm8qhrxUM9VznDVKuIKNn+9YB08sz5Qpuz1OCKQFT05VZF3NiGzpKNYnmkUKpBFVXnSMuyInBdRnjMYJ+XX17WhQhbE9AiKMPxxVhH6ao/as6p8S6aUhpSJ9X8XiKVmvM6ZatnnA0wCpAGXvTO15dNb3ecWSzx2+RDuIKdRyNp05tkEsLyG+ReDi0oYW2ej5tuQN1fWbdR9fnx8NmbtYUuI5KpJT6oEnb8p479En/uiV5D5ftzBiVLSuRUQBTFml7eQehj1WGeYkcoN23CWLs0HDSgIcbTOM60xBaJI1XPcYoJgRLqtbTCmwDYJ0ThUmjO4laJLEB7jINHjmAJjS5nppAmhtBvf9UZz0OBLBEy632V5ILY8Zfp+KuhyBUsDfasp9dhHBZQuevJLjKy39/SNWK/y27ucjKgEXbinRaa3LHxEX+qED4P0/7jrpvkBb6+CMPRWNyJj60W9vZIqxM37CI5a7nm1xGnE92xxh8d6f4jbXTAIG9OJi2VKz9ZOKoP1BhIuuZ2oq+0zssbPa7bGOQoKZxmFg+IgRe0UUZbjCxHCWNlucC2+XcGgbtCMrTS7SjBomZkGqAlB8NyBWGKy92Jkd45Gzvh3tTu3gjW5N+ghPAVflFq7tTvigK0ghadduSshR9QGu63SBNCAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(966005)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(4326008)(6506007)(6666004)(186003)(36756003)(66556008)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ik1Cw/+lWbZB3rzlu2bng2Lwq5K8NM+2oPkjyWlAddWhaloZSuLEbhqZzuwx?=
 =?us-ascii?Q?BzE+q/JvkfQ0f6cA1cSL9t10a0cCeunX0uapgxBTJj27+yjie+ihOw0P+HbK?=
 =?us-ascii?Q?OfVzXPsgg6/3vZDImHVAlHDpW+OsndW+loLzMB9Z2MOzB/3qrbMQB5sOId/V?=
 =?us-ascii?Q?5mmLPTaz2hRfDI57JIg15PVGnfaNWhBBUXh3CtFK2ufs/OHu5+D8mmTGZUcS?=
 =?us-ascii?Q?soLbRIkGMPOKwGZsfUh/1fDJnoUSTby9Q7sJ0NippID5/gaPEFs1v3/fLAoR?=
 =?us-ascii?Q?+vY0OKON29COHy9pUtJvC9nBQM59e6ki4QcNHXbHD4WZ9I6nG5OnRIPXEE4j?=
 =?us-ascii?Q?0qUrqtloLjghwwMrcpdlqftSFqqlG2W08ruadBBTvRaf/CxCQrXiusN0phuY?=
 =?us-ascii?Q?WKzFobvgx406M+sDrH6Bvsrs9xdCok+AgFPGV0ZElZjp2YnRMn43/9IcOXrF?=
 =?us-ascii?Q?ilQZYWwxbaO9wLfkRnBAOVoWlLl2tVHos4Qq6WQcf5q5fp8v6V4h8AZdHc/Z?=
 =?us-ascii?Q?NhwEePw5XFQ6MUl9VD4SHgpFsUcGIwdkLjvpeub5iGY4wH7FVod0dVuInl4U?=
 =?us-ascii?Q?Tn/iqCRfwLnHHJ19XUnFNz9wDReBDW6avNWazlNQMe7TVKqlKpLRlCdIxqLA?=
 =?us-ascii?Q?cHz0SoI+JpUS8QExyArNTgsKNZDNORsTFIEgF7GSjRqh2wszqbXQu7MOGhIS?=
 =?us-ascii?Q?mln+gEPmYjVoQZV0sizNb+bazwezzcuhb0wdXdj7LkXvlqZL7XXpTjArvqlA?=
 =?us-ascii?Q?ErHtSUK/bUxPJJ+cVeMm9Lo/8/i87mykUpXeUhAYzZcto2YmzIVJdLgB7Vjv?=
 =?us-ascii?Q?+SI3enn6fDmTVkjuiBcUyrEri/2YXMpRVYRXb0z3NAnVMsBCMOtYTIw5G4pt?=
 =?us-ascii?Q?UUfESxPaHwBYMzlkuQDono8e1cY0+1C6DyZrwxaW+Fsnotvle3eKRUyuFFbN?=
 =?us-ascii?Q?wrxxysxpucfe55Y/d1u/1PVtOF28GdaFEBeMf9n95ufv2z82euovKBJ5b/1X?=
 =?us-ascii?Q?uW3H31CIfP5RUJKdP1Y3sGe99yrAxrECt/cTRhK3GFCqPbt7N0pK38+Xy8Bo?=
 =?us-ascii?Q?YDBmAI3J//eI+ImXcrN/dp/ajR5usV4rLceCd9omwmY1CLguH0uV7TGIGHPx?=
 =?us-ascii?Q?mTubV6cnRgYKgbw1wuEEuGJ5vDsAlUPpl4DHdIuWe8/eT3kga0FG+thjEsMy?=
 =?us-ascii?Q?dbi20fh9sQy6lUfjFp04JrTHDUcs2H3CDbUa3qFQ71RfGmd52fozXIxksUA5?=
 =?us-ascii?Q?QZOKebarIN8pWgskqAcPEbIyUiXoCsPRJ/KmE/FcaQ1gxbCzC9HGjOx0NQ3e?=
 =?us-ascii?Q?D7JouGlc5gooPfni6gzDrDL9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573f4b51-2cea-4119-c4a6-08d8e9c7025d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:42.2549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH7ZqTSiypGpSZDLl2pl+h787pv79ZrIutqabhBmTe9q03/6xlHSM5IR9/LFFzLXi/mGrCsfBR7hkVay1/6Zwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
index 49484ea5366d..60fba0454368 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -36,6 +36,7 @@
 #include <linux/vga_switcheroo.h>
 #include <drm/drm_probe_helper.h>
 #include <linux/mmu_notifier.h>
+#include <linux/suspend.h>
 
 #include "amdgpu.h"
 #include "amdgpu_irq.h"
@@ -1402,6 +1403,27 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 	return;
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
@@ -1620,6 +1642,8 @@ long amdgpu_drm_ioctl(struct file *filp,
 }
 
 static const struct dev_pm_ops amdgpu_pm_ops = {
+	.prepare = amdgpu_pmops_prepare,
+	.complete = amdgpu_pmops_complete,
 	.suspend = amdgpu_pmops_suspend,
 	.resume = amdgpu_pmops_resume,
 	.freeze = amdgpu_pmops_freeze,
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
