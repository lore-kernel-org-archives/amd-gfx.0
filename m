Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AE8C388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 06:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C913520857
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 06:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LT84J6uU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C913520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36126E3E3;
	Fri, 13 Nov 2020 06:53:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A512F6E3E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 06:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIzPB50rHvHkcOX2VIA7doKtqL9knrAMfVWxfJl8HmJPINL4ANnjbtQHLUDATq9BKPDN8Do85tYJOgftY1MFWztBPxq48Ome89CBymVaurSV2Qt48usk6j0w6k4ObWBhuqTME4txoQHJKAAeTvhLiQ+HzGaQDqQO/xpkWbaTHxoQjfjQTo0p3fD+BthHYQguCeLNNMhFJ9LIhYzDMVQXXaW6fX4L9aNQMPm4nXndoW+GPuavKKh1TB4m8gewq6bXPsGC/Ak64nZ5qtVepDYv/45mhOyTeOkx343sjYpWfnRJIH6xvZJnO11aNWCZUWGqJatDbXwvt8MPSvITnuuXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+W+tuwaZyyK9Ra2FBXhmUcMm5GhIeENj5WyTloAAbc=;
 b=MkuORS05oA7IeFCRFHwyOVRsAOWMB8+1GoXfWpE9Iir+F4AeOjmMVi0WRhCsI5b2Ol1wVxE/Mq4p+SLsFveR5wmCf+yX1p/WZTtiSSeWA3B0e9eCqtQ1szAxWBWpajxIJiUrqdxZyfTijPqtCO1I09ME3+ncnXCPCRNvTFDz6X+Rq+4kvUHczGcrZU+G1C8/5cf7cMiT0v4NWRc/Vne3m6bg9LXdfxiNkBDzobDdJiMOcJKA6ghq6/0VpipUNvMjHoLBAQ528MBAmhQGyzdKJYffwut0zqTZMPpPRVRHHhDzMIbe/cUPiiLIv6euI04f185EWu+1NsnmowutpzvDmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+W+tuwaZyyK9Ra2FBXhmUcMm5GhIeENj5WyTloAAbc=;
 b=LT84J6uU5q0h4lwLjFkHKpZTYVhB/LzOfKFUXLvwAwJ7EEAhm3BqefX4uPJoPB39SJ68lwPtO51uirBffiFBfGli+ERorD3k+PCd5OeJlFAxMdIxPtFawYaH+hggWsRIWtyGvl6agiaY1JY5u7kw6OEr8V6rBBuCBU8rEBjPWeE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3333.namprd12.prod.outlook.com (2603:10b6:a03:a9::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 06:53:26 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 06:53:26 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: add s0i3 capacity check for s0i3 routine
Date: Fri, 13 Nov 2020 14:53:14 +0800
Message-Id: <1605250397-15043-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK0PR01CA0060.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 06:53:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d61c460d-7344-4723-fdc2-08d887a0d1fb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3333899BC564A142048FFECDFBE60@BYAPR12MB3333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amLRj8MfmQEoDcakOQ45CuGT6ykU6aWgcjVC3q3HdUiYqgpFx0jfuV8bcOJT44c3a4lr46pQwbnQ4DDznJEHHl3xFnGkdT8ztBsk8CBKHUyGdUXP+Ke8PIq/LoVBE6/Op5w5D9oxidMjAF0Me1PLvpkvufWb4WA5GIgBsoCsk4g8RaeC3QvDL0NRvxauu+JGlC2Nb8ruM31rkXLmhk9Si0f40lmWNpXYImAUKCTb0F3GBMccVdytNdCpR3am+8OC80Va5vQ6t3rfBzeJsK4WlNhddCypQHc8jyEtJEh8pi7WfbwdpcZjQAjazs8epQieJF7zfhDMTzk1FsVwtG03eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(2906002)(8936002)(66476007)(956004)(36756003)(186003)(478600001)(2616005)(86362001)(5660300002)(6916009)(66556008)(6666004)(4326008)(66946007)(8676002)(26005)(16526019)(7696005)(52116002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: O1lLWYSy/tm9XA4UDahLtelrNLRisjl1+ZwPRA08SWfjAyedL5H0eR5MFwYxu4ObgR5K/LBYLGkIppm6obxaRe9UJH7k3CooDTnHvtlTNdcUzAjesDfwqiFMvEThL5pOgRCDU2u5RrdIG/QaJUiO6uHhvrxAz5zeA/kS1ISQEx2Dup1J3WwLRsjjI2GnTv/zj9ZihK4bGuyZClu2c/p0Asd0HUmsX6K2g/SmmdTm+8tRNbhRi60EpqcvysokUX6e6f59K8rPlkZSsGMd+fkQfyKNcUN0k9ivT8vIoYIeDGFCDgYWDcAasPNh3zDXZfUdBuI7Ai8xSkjp4ZNYOJZcic+4gpt59RMDN4El888g18cyaGeyPOK6gVIhTzY4+4zKn8mJOLuVyGBnaDJ5nH5HBcYGxEUSE3wxlOARMueMxX76YYf0hezHoh04Yep0nP/AMKa4BTSuXVj0PvsJ8E1Y+HdLz7Wvuzaicfh60kniD8s65ZwVxSpF75FROh+0lOFCgdC9ePmLdwtBkR7s8BvbkTxTvJeTCxNSQTDWkr60Zr5uIdZ8OfumrArk4r7vrdN7MJSIhtVoq3m59TkinEMohu6h7N92+F1ggSMyNN9E2I6ywU21x+MTM968Obzt1qsbPpNWXaNqfJUabDEXzYhat7HjbLvcL6qnhu/mmn+dX5O53kEgaj9IZHhZDqy0WWwXw8SsHuSiBy9qH1mp36s4d7NTUNNKHPN3tI7bRzLrk6wZZuO0BZ2yMb3Sw5NGLUaCHtpJ9ejs00wIjZhpao91lg6O+hYIxgsK/E1l03BAhlLZRbxDLS46HZFzgIfJ8bHXkpS4FJXknByBf7gtd5haY23bjNvw793jn2uF138h1rRqHln2s4Ybr4ILo2piU1ez5enWSnVR8SLhcJtl7LhPpA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61c460d-7344-4723-fdc2-08d887a0d1fb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 06:53:26.2373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hxfRmWUWArqjtS2QkhVGbsOl5WWp4ZliDE1Iph+EuSjRaUJD9dTPh8Priih5tzD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
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
