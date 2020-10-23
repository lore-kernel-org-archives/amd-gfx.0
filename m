Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF970C388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 08:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE58720EDD
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 08:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qQij8R0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE58720EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418CF6E4DD;
	Fri, 23 Oct 2020 08:22:13 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20E86E4DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 08:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUxpY7EaiUgYgmN4QMA5kEnNe7gHQAZDxve8LEG29LIMEpESqFjkQW9bkgNV1BHodH2A+q8zcUc3V1XaCSGoVHulaAwScBQ57f9dqBPfmGL2VByMheDVCXlKwbOboS+dnsKAoaHmkWJ8eLbXfTjIMklG8QDG8XJWLvIbiXttnPqKNDiFsfFelSo7/Osr62SEzBZ2UnO6Nm18mPIwy/6eqjhf4u3oDD36lRLRslX0vgBl0DeYOca9pBoWL/UsE8tF6jaJq4K90j6M9FgF8tEa4KvQML2mKawcd5m896GgR9M8gSVjIPcipS2tGzMnXR4G5oqKu43X4EEXGf3FpmL38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U/XgGMfrmfXZmxDMcZr51WVUV9CyGNUPkpgZzDAis0=;
 b=dulmsiXdPF25TgsTzve/4RCa/i2/lqvg4242molXmv2UqtmIw6s0JIg16IvedBL/ZkSJiIJVXtwr1Sq+Lt2apsLwP4A52PxHHs0zkHMEUht37NVU6JJXc1FKGJ1Dv/8oyDU5YR7Qt4ojojwHvN9Tm9t52R0B+b+XKJlnCrD2k01R5U/fo+aCQ6UqhA8oUhsRUOsLf/Ct6jFDlzDimNbiYDgH4IcMLi+bmcRw9d4paH+yqXmi2RP4A9Maao4Dr2jvXG2k7ce0DCFHsyPdGYTF5iYfnOO6huqn7Dndu3ziInCRLxSt2XjFaD9EcESzi6MfWu/Srt9UZJVD3xxWx4oh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U/XgGMfrmfXZmxDMcZr51WVUV9CyGNUPkpgZzDAis0=;
 b=qQij8R0KIMtJtl9LvnjuGpHHZg32xD1ryan3NK3AMBUl27KKLyQaFfkJ4brBzjpoRgpUenO/jh/GCyohiDkkM1xYqWE2FFBeUli/tV8CCaF404NbwIXLNpu/9i2qV/eFG0KCp27btXfLw4u/0eBA54qaeeCa5YwVue3Bdb0HbxM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1205.namprd12.prod.outlook.com (2603:10b6:903:38::21)
 by CY4PR1201MB0007.namprd12.prod.outlook.com (2603:10b6:903:d4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Fri, 23 Oct
 2020 08:22:10 +0000
Received: from CY4PR12MB1205.namprd12.prod.outlook.com
 ([fe80::ec12:3243:28c3:d15b]) by CY4PR12MB1205.namprd12.prod.outlook.com
 ([fe80::ec12:3243:28c3:d15b%6]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 08:22:10 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: IP discovery table is not ready yet for
 VG"
Date: Fri, 23 Oct 2020 16:21:15 +0800
Message-Id: <20201023082115.13573-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR03CA0029.apcprd03.prod.outlook.com
 (2603:1096:203:c9::16) To CY4PR12MB1205.namprd12.prod.outlook.com
 (2603:10b6:903:38::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (58.247.170.242) by
 HKAPR03CA0029.apcprd03.prod.outlook.com (2603:1096:203:c9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 23 Oct 2020 08:22:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5578ef97-c9e0-42e0-cf9b-08d8772cbcc3
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0007:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0007E1E1EB2850618DCE94EF9F1A0@CY4PR1201MB0007.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:139;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L64aPdV1YhzRuz9kix7QzE50P0VjpPYkS6QvRxXUC6GcaJMpVSBWOfxDk9IXubUrxDk5G3WzQVRFU+goIBiwdMNK5wfL8b7cICDwB7N4lYzhdGDx7EQ/UbLLBRvhTrXQkkgjkT7acyh7TdGwbwXKmPmIbIVlzvovReUupgoxdnbd6o7lfCBm96HE/KUIvPmt+joSInRYcFSUGg207eP4FuaGi36mHEKDQ/mF1Jh+ibVLn7zmRRLzrhpc2ymLnc1GxniReni8f4K6/nt4kgUTa0SBt1zWnbNoReg/u0iqk219HOoGCrcs8pegLLsxBx3RaJh0GJAkXMLNahEusvLMOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1205.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(66556008)(36756003)(66476007)(66946007)(8936002)(83380400001)(4744005)(6916009)(16526019)(2906002)(52116002)(956004)(186003)(2616005)(86362001)(316002)(478600001)(8676002)(1076003)(7696005)(4326008)(26005)(6486002)(6666004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Oy5KjxOJgd7IkzrmgEUvf32q8io9FYghBxJkii++CI4T1ISUm7iGw2y7ONJTOjx8rVNkIMYXBYKdV/vN5RI0h+9aVGYRkHunadp9IREZJeNZh/2bgjCam+jxUrOQ/p3FOhKuyYco8M+9Qp3mFo7JxmlG6i+HD6bR0RZLCtM/vJWxCqzLtHYDbbXFH3BN4eW/CyO42tIdZrQOgWy6n5HMO42G+WUUKJSq7CINyeMXCj9b07BEic9e6HvqVa8AhuIe0LNGdPkVZBr76IppjhFbeJk8T4R7Wk1KQAv0d9qaV97mRoTK1aj2+f+EkWGIZBmXcwGv9XPkODEPEtndZ+h4Fnc0qpEg/9Z2Inscn1rft1qtiEA4ud1xKp9SK5NJVyHKOn9G01OfalPEwu68VpJq68cd7Sc36yjKaINhDlBNvhUNT3lmavQ9r0PwoT3/G/trH9ohJsV/SBND05UAoMfiH6n2F1w8749k6mms4/RT19OaobuMo8HCqsgwZkGbIiBh2ta84joDuHvIdYk3XdMX/lsC4nN1Jh0NLSuABWUMmw/317gGeBJXtX5I5xoIWOAKe1dZlLLNZfeTLhf8tt68q6GKf/TW+8ZxMqCA6AfWrv34/V83fv+8oFaodbVPJTpvb7+0W4j7u4m40fTJjwiCpw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5578ef97-c9e0-42e0-cf9b-08d8772cbcc3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 08:22:10.6278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlVKzW811rAf8vuD4Qw5R24Xw8eB2IuQGkON73hLzDjXgyGQtA4K3KgFbxifehx60q9qY4DyJ3FrAeouS/YOAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0007
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit ba502322c9f216552485cea967aeb8adbaf03a02.

IP discovery table has been verified on vangogh.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 72435e0eb8b9..30ec826c8760 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -449,10 +449,6 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 {
 	int r;
 
-	/* IP discovery table is not available yet */
-	if (adev->asic_type == CHIP_VANGOGH)
-		goto legacy_init;
-
 	if (amdgpu_discovery) {
 		r = amdgpu_discovery_reg_base_init(adev);
 		if (r) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
