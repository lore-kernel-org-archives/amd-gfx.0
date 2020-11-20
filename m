Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCC5C5519F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 14:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6AE222BA
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 14:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pEcUSduy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6AE222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8368D6E8B2;
	Fri, 20 Nov 2020 14:00:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E196E8B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 14:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsEmmh1lQ8uNFWLQ12e3bXHn+s0+7kQXoUDYQAQOZhZ2smLzNzFxyvzW+uW0X4WtU4Be8Kt4PcsohSOyw8dJSZJPs33J0XcRnlrJEMWxyCnJXl6ScQZAAKUCsTMK76sBuGuw22/4IM3q9M6VB01l38Pb3hI7jzOEiSGWQ5KcooD4VOmt75OxviZxE10i0nPv3mdqseFMHs34RVgGKMbdXCb0zQkSeup8xBcrlfA2VhZOUhkJBEvZPnclyS0ym0mRJGlVfC+LIeI8FQ6Qw/nj4PDCC2u5LzL4w4VGnV9RbeSn3kFWUg7D+ajFsZCFYkjF7pQcSiZea5DCHAC5TTnl0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFgni+XymKZJVM9Y5WocU73bwWKHKQlfKJJ6mPgFKnk=;
 b=mdd+7kN9Xam78hluwIqAFMAah1Z0fVSN+KAV01rSY/LzW8FJeDYm2Dn0D4XUmPWOcexWck+gEiIBpkizvqFz9oya9Ly2Aj0MRt8jGAlcHAwYRdpQ2hjs4JWl65YlIno+jWPTRXGmR9EADr0p/0Zng1lnHl1/O44d7Hy5gxibfH3RYxALdZFru0eeCAHqJpgI9wwsO/P/2rwGnqXgsc1JWwHRYm90uPu+8cGk6vkJmDmLGyOa/tedYou5xyGa8rgfjRksCmnG8gKzfL5tA2rctcvXIRNhr2FEmc+4H2mPeOi4k/Yb07qJL3U7zeVoqMRtvawT/tfO/vcCvRjqVTmT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFgni+XymKZJVM9Y5WocU73bwWKHKQlfKJJ6mPgFKnk=;
 b=pEcUSduyZiAJG3ZUITIgZxsh5mB22gWdxRSGwMO42pC5lOFHoiK/qMMbRn5YSXZGM4A1bLrhVvrzVLT33NNlZjIaMU1sP4b1z2LJJSbMpTVg5mlFf2pD//kyxeiDdK/j5uBI4qAA9npbmad6YsJpIPLcpW0uQ93Q1OkQkTV7XQU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 14:00:09 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 14:00:09 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Avoid HDCP initialization in devices without
 output
Date: Fri, 20 Nov 2020 08:59:56 -0500
Message-Id: <20201120135956.2387185-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:610:20::30) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:610:20::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 14:00:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c251254a-1363-48db-10ed-08d88d5c9757
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3925DD2E783CE335E5BD5E8698FF0@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IDIgkXIYF5lNLQcyvrXhTIWCgva7OwzMYCr99HGu4RDFnzIIPf7zTdbjIX/7khY6IGD55XzR4/dTNKmTMiDe+LzAZftDbgazzhahgvfDGn7PUPFOPXUs/LWlo27AppKW2SQCWVyBeVQ6ZgVWLqVvvHwYkkb8QKz1TZxEyQ40tuez842KrmNa9fP4WZzNLjBOxnZcSBcJPXMVAa3Ac21QPVAUKTBoe8ROM4e22fkYOdfPEPwaH1UAgBiR9obnsOWQ+HoTVd6TkfGf4TztlrjuXNmK1yKNCFZGKH17kw2eYfnspxgsjs0yqfDrD+PaesA399EoxnU/odGyK4AzAGqgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(52116002)(316002)(86362001)(478600001)(2616005)(83380400001)(8676002)(36756003)(6916009)(6512007)(6486002)(8936002)(6506007)(16526019)(2906002)(186003)(6666004)(54906003)(66476007)(66556008)(66946007)(5660300002)(4326008)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fQ+Smvm2Ym8r3gV+H5H2HNOOBBnmevC1DTRUaserXY1qUusMcqbdQVtdR0vydHHKbyGY6H3Nyl6dg3Z4HqcA7ijX7CuBdflbtMizIkJMeKnt3qEaKHFmERKNGO+5M6ekibudCCx7usJyWoT5353ga207YLCLcDyL17qBbAFTOjl9EyPUQapDIljHPrXlDELU+6SEBo/zcPyg+TnwrJhAw0jM7nGi4Rdr+Wy941Qf5woFWzp6zme277AhQjlr7n32Uq7Veq56Im+Xn+xfC9uy1hNvcKhEgN21tfEc7K5z14CXiI7mX+K8k2u2qmgr4M2mc8VBhM8xRfznRHal9ZqBK/RjyWRn8rTBdelsrnZKhYk7sXV6f9QNo2jv+Nw6KnbTOG9psLpXbY4XUJ78ekpVI08Yuomchllep9Gotf0uj5ScvQ3QPmNnVf5RfAf1FWjF4QMqF3PrnaCBmoHaumC4kgk/RRJhS37QSZvAjmGbaP5QBfG/edJKqDlnHrMfNWQW+vSLSXhMxNcZDqDS2QNllcGcmEzySfJhdgw6jMWHg1fzwU8Bo16EacHPMXeXaKyge+nZ2pqDpNv/9e89JVnJg7Y8dTFPdu6iPzAbi34dQodepr17DC1JTMtbOfs6QbFkZVSu8nY6t6GLtNtPy6cEehR3/KVnuaRgSNYzsiy6QMDIYr/3pbiofBiSVBVyhIwIkAnUhojhVGPa8QYQI+RawfveUE5+MIxLoim6qKokSFQCaIB5OVAhlUqHhZeZspXPAVVax++auOwIHldr6ThYvsrSjd3HMEWMPxyvpWu/q8uQt05zqNX/Q/vKCsLhK0Y/gidTPhW3LKb9k86cI5Ama7b+EyW0sD1BSmY07EULZPxMfHZtKnkrYjve/CAGBRp+xcMPYsKeYcP+iPllMZIrDC1qmIGW4R8sIakuC/LHWgs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c251254a-1363-48db-10ed-08d88d5c9757
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 14:00:09.2975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrFSPZXpK75amIbG7egWqZ4VOmMDXnUF7ZI8Zp/TTk2m9XB2l2C+ovJWaD+kySGkO8CHYr+9Su2vik8VVaMu3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The HDCP feature requires at least one connector attached to the device;
however, some GPUs do not have a physical output, making the HDCP
initialization irrelevant. This patch disables HDCP initialization when
the graphic card does not have output.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1da4ad529309..e213246e3f04 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1109,7 +1109,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	amdgpu_dm_init_color_mod();
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-	if (adev->asic_type >= CHIP_RAVEN) {
+	if (adev->dm.dc->caps.max_links > 0 && adev->asic_type >= CHIP_RAVEN) {
 		adev->dm.hdcp_workqueue = hdcp_create_workqueue(adev, &init_params.cp_psp, adev->dm.dc);
 
 		if (!adev->dm.hdcp_workqueue)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
