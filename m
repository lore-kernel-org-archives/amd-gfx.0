Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BDAC5517A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 07:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4A120791
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 07:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EaOGPdhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4A120791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ECDD6E140;
	Thu, 12 Nov 2020 07:06:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C32A16E140
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 07:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jewT0YVoBDFvPWj29WdxNQd/aDtgRe/xc4cyc7hXtKLCx6Tr7VmQmbDIHa0KnprBhcXgfDv6R9kK8FHJf76wm9N77Ed5rk2Qt81RZM7n4ax2FS61H2YA4OjvRC04KI9bBiLNLmr4JNVIdyCXV8h/q8ANmm54Az4PDt9yViU/bHcNAmHFdv2Sk/qYcQHLCuElxDeMvmmt9zixociwTJjHdkM0imjet37cHTqFOA4LV08F2V/qFJJpMTY3hoctQaEzPSaUVB7rgBCPuyZMzUkROTJQ8AzPOm+OTiK/qNNMMRyfKA7bsV0xCN3SQAQL/OZ7U/Qr0mkswDEUrO0WDJYJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXJZNdgqNvyyLUqLoA96k5HEbRRg0TaWhbyNrsqzL9Y=;
 b=SA/U1+crTKNqGf9MkClpvFu+2VGoPlIU+YN0FK7q6IygN6SvyndunE3PQeP5sUKENAqybLGbyvBVnuRRAIwLf7h0sWlrCrwuO0OYLXu9IDPGLPhXCkjBKB63YvrsqIqHv0BkF+8X3+SrqFxnA+pAOdOu4UfIJMcG/BqgqaCUbvb1uPMQOiXertrVjmkmr2KtBT/yK+g3AURU0cXS6ZFaUxhqXt7m8c91c5HJVExjWq53VYvhGC2fSAwWadj4QMobZzB8Vsr5zn5/JESBmlhpzwCHN+NP0tradLXiTMEb0JD+GHDU0PIP8apyH3Jkms8bpRFcDu6wofzYiEJaFde/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXJZNdgqNvyyLUqLoA96k5HEbRRg0TaWhbyNrsqzL9Y=;
 b=EaOGPdhx8NA4axtcmYLCN1ux7S9Z1d+FX6l3r72uQffCNnzWAfVQk86mJWAIdtcVuZRMEtn8i21tY5S/4G/Kme2uggey+sDqlgX1b/D8Z72lVWng0hqvuLbXyQRgOWkHDU+n50TpfUP2hFGVNEhVDi1fJ+E06P0qX0jV2UUaixU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB4789.namprd12.prod.outlook.com (2603:10b6:a03:111::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 07:06:49 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695%7]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 07:06:49 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: fix reset support for s0i3 enablement
Date: Thu, 12 Nov 2020 15:06:35 +0800
Message-Id: <1605164796-22215-4-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
References: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 07:06:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eaa9c70a-2497-40fb-36f3-08d886d98622
X-MS-TrafficTypeDiagnostic: BYAPR12MB4789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB4789A278A08BA4B3116E7F0CFBE70@BYAPR12MB4789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZiuR8d7LOzOA8fWriQoh6nfMj6HXDtq4QPjrgnIi6VPffRfGEr0u7qguyVK6GEt3/74P9ncEX8JDDk24f7qChJzWOhzZHphiCPClePkrWoWSJGEuXLbBLmQHm0ZAuCMefbQ1W7yXiro+5FxADU5RQSQQI2RT+YDSDhw6V4KRGoaP6HMhnoAMD5StHPg/IEJ6O8ilNznGNv+OXB6mFDUL+YTs7XXmcyOmlMNOT6zxT3beMG4sG7jWaV9GO8+hsBtNqtoLCge/IaJCIX4UfrXkKkly56Ct2RRk9us4OWIBeiFas7oXnJ3qNJEGTrvHnl3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(7696005)(478600001)(316002)(86362001)(6916009)(6486002)(66476007)(4326008)(66946007)(66556008)(5660300002)(52116002)(83380400001)(36756003)(2616005)(2906002)(6666004)(8676002)(16526019)(186003)(956004)(8936002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: s5Eho7jK/Wg6Lu/NJBxtXJ0Jbx3Fhw9+DU9Cmwxug1u5mjyBCphbxUkoMb9xsdJGquGmrcRcDjpAC0kGcc/TDV0tPSgnJRmNloLzAbfPnmPDKSPk5FtTTM1G2HCVkB2Gw3HYh0cFt5GXIwHaW2z661/DAQGPeVC6r1OBsy/h/gn/QBzvG2EoQd/skf1p4XHLtBjHkk2IVmQnMkR8qGk0mfq1konCMjOFiOvIRrl2F4Jep7+RKsWgm9U5rQpTqGZVRgwhveTgBHRWNuGigeWT2Sd3DyFfbUL3bw0vEVUlnDAPiqAwhHZGWfCZloy3P1lMUfQbloiKuAiDbHXv5wjpWXyT1m+z8SlpPkXqHJkKMzBEhJaaKGpSdSTXmDXaV9/xfkvSK0BbhrpWl03nNd3rS3Au+z39LRXbHWeEFFiW7CeDVBVKIQC4/23tsyCIczrjQkSZ9HDOaBrt5TaKqlFxQ9sMjf1JZDYJkcVTq7lJaWKdUhnSUbKl2uppg3qWFR0lUketop5adXPIGKxLjNwYu3mucQPgCpiauNl+hm2OQzDQTcwWvF4zCV3ojWjEIC07E/ebW4Ni5GTwknsotP+eK6TbL/VKs+mu1yvja4SzOlWAoDjyJVBmaI6+tA0MvpePZOGfcNm7TXgC+r6wTz2UOxahsY8SO86qOX369HCHS0ZJeUarU4pg6iz5OglKQLP5ZRRnyqtO+jF3D+dbRU2xNvcb9KuJOoZG87iBpEJP3Eh/33vOi29XI7NJQFzFF7xJt3HIUMI9eq6HSXxMKnWROuHYxSYy+CSpcfSQzTBYfKskqlSA5Y14mqGyNG2HO3UANoZ/38XVYoXlLILT/eJqofiCuNSJw+6vdWrMK+LkOfDNVv/0oPCL4y5JUfbF/6qIVLrYPomYnUuQdUie/TPUpg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa9c70a-2497-40fb-36f3-08d886d98622
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 07:06:49.2577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4L3Kwm42ldHIL2WEJJa86/x3kV6h4p30XCBUwLEjLhE8I1HZPvG48r1rooBe7HJ
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

update amdgpu device suspend sequence for gpu reset during s0i3 enable.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cf6a1b9..2f60b70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2650,7 +2650,7 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (!amdgpu_acpi_is_s0ix_supported()) {
+	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev)) {
 		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 	}
@@ -3708,7 +3708,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	if (!amdgpu_acpi_is_s0ix_supported())
+	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev))
 		r = amdgpu_device_ip_suspend_phase2(adev);
 	else
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
