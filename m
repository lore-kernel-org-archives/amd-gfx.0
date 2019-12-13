Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A0DC32770
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FE524689
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ue5Ud2gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FE524689
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CA66E093;
	Fri, 13 Dec 2019 16:49:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A006F6E093
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 16:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aarta5z4J2v4gymj7esi3lLUmD8P+OWun83mlzyyn09hgm/XJr/0BP466MgHN2JScdzlV3zMuPRiBkHS+uB8Dn81jtGMCOke0cKV0dKfe7h+LtuP0cftUYz6grzAiHf2GlNXmGY3EqMDd8NqxEazVnzgvo6xmls9s5cpzpQhRjJ0sCunDd2e+VatMDwrv5hFWZOf1dJG0oYo40DWM2N8+v0G+rENyfeRrzmMax0CpxHpWieyu9PuyubBkfOrjDKnzK3Z/czK7fSWbRxyeold2PgDDuMLUPx/ahcn4iAGKEAoayS/HnAA2WXvqKxQb9vCcEIADl0t7GLNFonRyygVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HLCutJCDRGVvj+G24T/PIIZQUew0txAyFyYDQPCAXg=;
 b=gGPn6N3KCaQXcimIU/1OfWXXptmjbki3WxBGLuI1kC9dw1Iuv3PDrH3EiRbHXo3uMcKB6V0cZNHcjzBFBkOzLCawZCiArvSBV1JcHBheIo0HaJ/x4Eh9/HhA2UsMk+xbPYCtd2LMq6OeKs2nTqnxW53BqKLjqojj9D4JRjqxwZjE9fbP6FeV2G+K3Az6GpgbpTuD+DELwV015IrCmCgi7fiKbkC3Mxa3i06mu51M8UdhMjmar6lyOrPRSC8Fa5OLaELaeXEJiG1Ou3zFfcyK9RabmaQR52nx2oWKRQM6JnSu5KE+OGdXBsdgr6GkOT3wasFUtnOfT8EM94esAOV/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HLCutJCDRGVvj+G24T/PIIZQUew0txAyFyYDQPCAXg=;
 b=ue5Ud2gjcmV458aPl5IM2q9YErnNIL0NTHFE8TJECy79oMJQ+5bdQoFkMzoUREpeWl0NTn/WvlewH3Iath3ig5CrJ69kbbp0uKjZaHEDShe3AoRCmhdzMxfYFqdHezvid3L1rQt+C5swRRuLe/KQ4STIA2Y6do+ClTQO2/GeaW8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB3612.namprd12.prod.outlook.com (20.178.30.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Fri, 13 Dec 2019 16:49:51 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2516.020; Fri, 13 Dec 2019
 16:49:51 +0000
From: Zhan Liu <zhan.liu@amd.com>
To: amd-gfx@lists.freedesktop.org, hersenxs.wu@amd.com,
 Alexander.Deucher@amd.com, Kevin1.Wang@amd.com, Evan.Quan@amd.com,
 Tianci.Yin@amd.com
Subject: [PATCH] drm/amd/powerplay: Add SMU WMTABLE Validity Check for Renoir
Date: Fri, 13 Dec 2019 11:49:31 -0500
Message-Id: <20191213164931.26471-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::45) To DM6PR12MB3466.namprd12.prod.outlook.com
 (2603:10b6:5:3b::33)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 590cc8e8-36d5-475d-8f2a-08d77fec7889
X-MS-TrafficTypeDiagnostic: DM6PR12MB3612:|DM6PR12MB3612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3612BEE90956378367EFCB499E540@DM6PR12MB3612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0250B840C1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(6636002)(6512007)(186003)(6506007)(316002)(5660300002)(52116002)(44832011)(2906002)(86362001)(26005)(8936002)(1076003)(2616005)(66476007)(81166006)(4326008)(36756003)(6666004)(66946007)(81156014)(66556008)(8676002)(6486002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3612;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LiA+WSrTzqRwowJJjEftUR8oaXS+OYEo0w1Yo1/FdvF5Nv7Xs+YWmUQCQbrbVM43VrW83m/b8b/wLmw1zv562VhNo/HZLlWaXl3Rq4cq0Nu30IjPkvwX0/SdwAc/pxiwPnI1EUMhYnCVdTNkp9qvD1QEsLHMMmFpsUQ8hhL/f9SYt8iOMAeWCfJ09kv8OKAq+iegL+NQXp1IH80bkLtpxhpRuSCCMe2wngZ9C5JykK+oX0BTHylEtUgRzYNWtgOKdlNOzpPqngdvHQjmopy3W2y5YxiOSLqWmDcMgl4cw84Awg8bBPxui+JTE5Vd6cn+JVuvUIfC6mSrtSHpf5i+iTTJV839ElAlV+2tuLdDoCECRUM9qVwX/T4BHP7i20cMtYAATiFNQRcloxKk+PiS1WpPtGPrG+SV3qPGC3m5uBTZGZg4of5cNbVAMzMDW2P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590cc8e8-36d5-475d-8f2a-08d77fec7889
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 16:49:50.9773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRHP43mdLxoBjusLPg2x0fkfcB8MleQFxxC+po6oTgsWIxXQ5INnbWvsj8KpylQi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3612
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
Cc: Zhan Liu <zhan.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
SMU watermark table (WMTABLE) validity check is
missing on Renoir. This validity check is very
useful for checking whether WMTABLE is updated successfully.

[How]
Add SMU watermark validity check.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 89a54f8e08d3..81520b0fca68 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -777,9 +777,17 @@ static int renoir_set_watermarks_table(
 	}
 
 	/* pass data to smu controller */
-	ret = smu_write_watermarks_table(smu);
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+			!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		ret = smu_write_watermarks_table(smu);
+		if (ret) {
+			pr_err("Failed to update WMTABLE!");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int renoir_get_power_profile_mode(struct smu_context *smu,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
