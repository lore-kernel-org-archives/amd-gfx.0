Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D812C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 09:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80FD20848
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 09:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jaLf0Mdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80FD20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0740C6E0FB;
	Fri, 16 Oct 2020 09:21:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA916E0FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 09:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5xMUP1hZhbUUdPF8p2iZ6EKVtJsblnpSvlnnPL8H4yt5/ws3GGYYAQLzCZ0SstMB4Go5/cH5x2hQYgBUoFhJvbgp7H8nDt3X19ByakGniInvgMwBZgJ10KPLKZUv0bnQKcD0kUlv7Zbjei2qzVuKwOA0iucBiLLwbjspWrE2V68yzI7CNuLDfj5g6K06nDp4B13ld9fd4KAgji/OpUDP6INEaFI5sWLhyesxVqgeo8xh50kT9SftRgHJs7im5O9IApudrjWxAR9uP8fXeM01xUBNFdtbLeFKoKg/CcREdVrBhLAIxJ7HoQON3beHjwZ0h+96dFDU/s8vExuLUgemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUTzjpvGM575dUkOpRB6EG4X+CX8HNdiC5AVDcJTWs4=;
 b=TWBsv1ge4m6m6CoVs1EjMs36IJxeX93pOSTJ/Ub2n/LQi5t8TMrxZseaA6Z+2KXd4XUZcdSzTbH1RGV8zHAZIuGh8f8TJCOfQvgrV4+wkGWxGwlpq20mswcu6L8bmGXcNG/w/d8SeN9fdnKqUJDNjcGfBfDwzLM3exorol1U7NBtMuS6zT6fXjU/A4D4XQ2IatIEIOLCZIyy4M+xhyHST5a3rxW9XLqwA4kpiGt/vj8yCvKmkEO/vCvYf8CxZc9mTkhjMC+jGjMAw035bIjMaYcI9pNml/Y5f4NUp9QqEgQKpOri33AlAxvSTmJ+1ScrlqKxSLxU4tJgk0XA5GNpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUTzjpvGM575dUkOpRB6EG4X+CX8HNdiC5AVDcJTWs4=;
 b=jaLf0MdlM+fboOBFTv0inRZx/uzbsmZzU2TxPvBupahoATahH36xMgnhWkKZzWUyaRejmxI8na7pBqx4wAJ40K3ptLStnUj24nyjmZaSaJvcdLCorvJOrw+/puog7Nzdv1PkAMdD/O+upxu5U0oV2PxaBRPHxOZFSBu5siLO9mY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3128.namprd12.prod.outlook.com (2603:10b6:a03:dd::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 09:21:52 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::2c68:c110:d658:f219]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::2c68:c110:d658:f219%5]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 09:21:52 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: add s0i3 capacity check for s0i3 routine
Date: Fri, 16 Oct 2020 17:21:40 +0800
Message-Id: <1602840103-21053-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com
 (2603:1096:202:14::33) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK2PR04CA0065.apcprd04.prod.outlook.com (2603:1096:202:14::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 09:21:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69842c93-73b9-4d45-0275-08d871b4eb0f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31281DB170E93D8A09970400FB030@BYAPR12MB3128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAeYKDdhT61DMIJVukTnqNeCcsDZr0OFdQRUJhbFQoRdUs/w4+7+lSZWf630rf8JxbBhMqIf/MsefM5PsOK9vIU0Xm0EDTQIKc14fecCX5R0vQWDGrWUyqP14vwDdpw5KDJYxXMbVgb78ySz5nXz/iLqvL0LqP3gLw3ITTWcXk56P+aMwFrkWc62Gzl4vLWNMwXkIgHO10SkGxKR2j1OFcuBzYrrScBKI9zthFGSx3UpxxaMC4yNBP3CZAC3HZewJCR1sCWQa6yokuFkeSxRHACw4WTOWWAmIs8PGsnJdX6hI6Dt4v/hcWOvn3dFwe/kSc+c/PxhvzyJ/iNocCBXpoaWezfroZSdHfbwUSB5HGnA6YebRjW3J6Qhjuf6RBDE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(86362001)(478600001)(2616005)(26005)(5660300002)(186003)(16526019)(956004)(52116002)(34490700002)(7696005)(6486002)(4326008)(66556008)(8676002)(8936002)(6916009)(36756003)(66946007)(66476007)(316002)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5Jd5y+8/hXFM5hyidq+01C5WhDoZ6/rSWccYv6ffmDBeiCFh0mEJtaIpY82Y+xZDOb8qwqcPFZQ/P3iT1qyL7HfkqLW40Ebt8lPq+yShugo2nC0XkgtSHBZgfWg0PnSw37jnY1JS3aQs3WrSVqutVF5Hv4PCHQHTiv7fd/yVs+ACucpa02gz3y+jISWDpslbg4BUDJUc+j7KEJladC8X7xxQAy8lGtKjo5JOEupqZ73fHL3+Q6s6rNcUTFtAaP4Y6ZBy4ZJRiWYBGq0cMS7bK27ANoKSAa5h606yIxEE9HsfjqIfcwPJVKfjR8uY6EC8uk8Ot8DgcysuDCTpapzFPLEnEd31TJPffjt8j3kAo3idBBBcNjy6OIMbaixeRnzH5JJKKfIldJ/ijobgYoHqDl6QrosGzRW8e2VGb1NTQGOIMzF2moXBtBdH1Zy02z0BVEjRvZRg9ZNvucwVke4+501pNLsU7Ohv5YRLpXu5Lu8i5XirS0rlZWTiTUZNzqQ72KVzXhtMnSCSqB7NE5YOHYN/m6npL8WyG0oZxiVfSyCWyiuZvzODgph9ucQGvpQY/dqKXq5mbm63LCFNAV9b5SivC/2Ap8gDjWl2DD8j0ZjSdeW4D9xs49U365ZIcSaeQcqPNOp7HKlzQ5ybXDGpKw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69842c93-73b9-4d45-0275-08d871b4eb0f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 09:21:52.6725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLpe9YZARTkO8XBwV8/SiBQ+zJG1kB716K0OlD7MHKofY1iZQNvMW4Hqq8luYcby
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3128
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add amdgpu_acpi_is_s0ix_supported() to check the platform
whether support s0i3.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cd91398..6bbeb04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1228,9 +1228,11 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 
 void amdgpu_acpi_get_backlight_caps(struct amdgpu_device *adev,
 		struct amdgpu_dm_backlight_caps *caps);
+bool amdgpu_acpi_is_s0ix_supported(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
+static inline bool amdgpu_acpi_is_s0ix_supported(void) { return false; }
 #endif
 
 int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 956cbbd..88740e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -27,6 +27,7 @@
 #include <linux/power_supply.h>
 #include <linux/pm_runtime.h>
 #include <acpi/video.h>
+#include <acpi/actbl.h>
 
 #include <drm/drm_crtc_helper.h>
 #include "amdgpu.h"
@@ -907,3 +908,16 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
 	unregister_acpi_notifier(&adev->acpi_nb);
 	kfree(adev->atif);
 }
+
+/**
+ * amdgpu_acpi_is_s0ix_supported
+ *
+ * returns true if supported, false if not.
+ */
+bool amdgpu_acpi_is_s0ix_supported()
+{
+	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
+		return true;
+
+	return false;
+}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
