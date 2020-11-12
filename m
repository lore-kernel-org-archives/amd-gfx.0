Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DF8C5517A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 07:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6386D2085B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 07:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UhS6ZDno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6386D2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A03F46E134;
	Thu, 12 Nov 2020 07:06:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4FEA6E118
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 07:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tkwsl0b4SHObwT9bA2zGn9mKpVwGnLkbmEBTl7khg6cVT0iZTLa/vcg4OMcIvSSr+p7XabduJlciTvOcm6CMJ1JD0HNEDgfR0xuLRS5ovQTb0nS9O84BPVup2T73TSliho6cZXcoGGDmqYr5egsqoJUUUjoLRHjcdfPPJ3iA8Q8SreqAD4KDui1pjbi6+B60On5qh+gmQ3B3dSYpPJz8Bcz5+kg5iSeJwG9zgVNJWVB6jl6dGCsFCgT3qFKvL4SIbNBKTnlqsSN6zFI4uceY6vreWsYzhe1GIFwrm7yQhsR1cQ3ebkk9Nj4QGVonvVUIM0+vbeSpN+WrF73GEygnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+W+tuwaZyyK9Ra2FBXhmUcMm5GhIeENj5WyTloAAbc=;
 b=cgTMX056x0zATCZNCbz0i98+C6C07ETYGK26IIl8brDt//ck4ahjQThwa4QVtcEfFh2F3lLKuB18zyPMfOg+fhkVgcbR6nGUB32rdX68H2lkfCkzreFTzOCkU3fUVPs25Js/sNJInkD5UItG5bGK8B3V5p+ON4aBNR+viZCFOB+iTFjDPMeOxUrEA5Gb8EzM90cck4S0Sn3b3afV/8qXN9UaPaN+D3YHCsQ+M768eAtJVI2DA5SFOAT6TgVj1490Z4a+Mrgl2CGfY2uMx57ATGDMcT5woDjVsyg61wLxaImW56CQ4oAg++jh/6dUbW+aXzmbbykNKSXC5UfsTNavrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+W+tuwaZyyK9Ra2FBXhmUcMm5GhIeENj5WyTloAAbc=;
 b=UhS6ZDno4v1ZG+8tZjHcEM4j/6fJg9OrqLD9Z24eY9NiJ/xQWynKK/i8y5sXrl/L7QITeudsDyeaXTPmGF8yMg8kPDrmCryZzQJdRb6lkmZbVngotb9fZ38dTKQ+DsKxhycV2soB85n15mUjD4sfgebKce1EOXhF4VVfUyV7nRQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB4789.namprd12.prod.outlook.com (2603:10b6:a03:111::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 07:06:43 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695%7]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 07:06:43 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: add s0i3 capacity check for s0i3 routine
Date: Thu, 12 Nov 2020 15:06:32 +0800
Message-Id: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 07:06:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b39ec9e-83c2-4bb1-dc6a-08d886d982fa
X-MS-TrafficTypeDiagnostic: BYAPR12MB4789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB4789D057EA71A1B5ADAFC08DFBE70@BYAPR12MB4789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEikJCHaT5MchVOXNMXp0UTIhErVAa5a/8bhJQiEG3Vfe49zdv1iRGQVlTyAH5NB9D+XUBwXiXI13HmTbDv9yQb2YB/tmSrKJOMBvG3ujqCiRFFX17H72ubiNS9pBtEmpIK+umJ8RPWjCSEDN7v0xZ6/1t5Uh9T1eOvKBpfTkc1jWBO4fpNo0X4eNKL//gFQsHXYTigrIj/zixlnLTxCa3zEx/c1wXqaWjpgcjZWE02BX85xZhBOnSKK0rewTnPErHx2qyaBHNENhHcZWTHt2dl8u4OByOiWcLsoklFFh6Hpd+HNJIPHaKrYaRf8IzuMNx7xaxIG2t6XikDy0PyjXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(7696005)(478600001)(316002)(86362001)(6916009)(6486002)(66476007)(4326008)(66946007)(66556008)(5660300002)(52116002)(36756003)(2616005)(2906002)(6666004)(8676002)(16526019)(186003)(956004)(8936002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jyUgY/PvFWoq1tOCJuiX8tYGQKoEC/Rr+CRp9ZRbsQocm+Lpp5LKQ/d3N6ehIW8JDFyIRev5PyYBYP1UES+pb2zSqSRnlCyeGjetF0kf1ZVg+jbjyogb52NQGi7zjKVRMSwknbOI9QUyElx2+XF0B+m2QEle2434S9uvZxDup2A6VFuxHPtJQ1St7JbnkUPeDCi2ZcX6BqxwRSZiilkR5swAPwwL3UCaXzwxwDfv8L7MqYLNEkql/JPgbMC07NQFHZSPI3OqgYzygHgFLnxGw+HrlCsG3yqd+Q07qdCOEceEbu0Q/YgKkhafL6fo1LhTUAxsLOlVGsN4cQCeiDt7gJhBjRvP4Za2sxEIJyX8nN9RWoUZ3wqifnYOlatOBHXBz8x8CM0d20kIMSrgAcffEpawkXGFKMdE2UMsH4NYxjBGXrWrt+84Jb+MNHEGES8mgF2vzh5C54uBywILU6gbZZzbVScmujZLdmrthVJOyrZIZwliJttqTfwZ291x4XuY5D5ErwpdXiipPO6FJiK3DQ9rLmVONnHQ7FSkqwpGXud1iC940ZKS8HKeld6pX5ZjKrLvCRzMtnQWHGTtepp1gFl0264EW4ZkucyBgQxuTh50PRgF8uhTy9IV+djzW5guO6+t71Ky53fCuW/n24YxTwDGoF4USlUqcA3LyBySCnA0DYMViDHpzZfkV7kOnRKDzoh4oGsx5ec9OiCf/uPGQ756nInArx3vwUqU0R907tLVYgQINgdpZwBcPf0L3TEjw4f9FhE04rQXno69IEU0mlCUwuMs6s+Ni2nY3895+ZmruCa62PAsbDPaze4VxEtYr2MSuchKY+2nQQpOAkyBytoH/6w1rUIfQ33a5fQu/Mqoy3++B9p6ukdY++IwOlUBrw2rh532QLUsS/5/fe/gow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b39ec9e-83c2-4bb1-dc6a-08d886d982fa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 07:06:43.8287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJMSSss3JnnmhWENfIv7MULyahx4DGmb9phxbaEDn3jNA1B+nENfudXos48oMse3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4789
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
index 20400ec..83ac06a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1314,9 +1314,11 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 
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
index 165b02e..fd66ac0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -27,6 +27,7 @@
 #include <linux/power_supply.h>
 #include <linux/pm_runtime.h>
 #include <acpi/video.h>
+#include <acpi/actbl.h>
 
 #include <drm/drm_crtc_helper.h>
 #include "amdgpu.h"
@@ -894,3 +895,16 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
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
