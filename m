Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E458C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 13:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F82D2072D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 13:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="11jOe3Aw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F82D2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEDFE89C07;
	Mon, 13 Jul 2020 13:48:15 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750074.outbound.protection.outlook.com [40.107.75.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B983189C07
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 13:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht274rsD5ybo1J0nQ9M9jbn9BY/Hqc6oMoB/wFqg/chpg+HRwryTFzO+YAC5W1o8CA5U1rxKAlX7D8eGseR1xjKaCL6uq15/VJNOZwCa6bQa3y5HFmBuRE96blRD3Pu4lnz7GAj9xYh6t/JYmL7Hi29lA4A+Z2EHTM8veOvdJjiWXHxWiiDhmyKa/ALfVuPrEihL7XXBLH7khLkuk5MAio91t65QVNOISWJPQdgwNfRSHIiSyUkJ1Gk05s5rC2OaGkZQRRkRE6eo4QqvQrtYFf3cRHe33zEXcouy4m6tZ92tSckthwTxTaphGvYRQ9uMlLcgogCbB0vAslGObk/1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyxrP1kgPZnyBGtk4FSlgcL/M9xfqcCSHB0ypJ9giLg=;
 b=lTO02JhQV4Z21bwLby69eKPYGtDYXNq7eMZDeA2EMGex3QWsMEKEE4sFison/yC23TlHwHySkJpOt0VxkHsP+s0QqWQWGuOX3BQPKPEyOHhYybZjM+FD/cYY/rlIkb4zYpoLBYQLe8+pOmH7i8ALZYmDW9N33PgQFmhCTFYqlbRb9JK0tztBU2fMjzSjktRQX93TsdBIaZ/33thSWGjTX4eiUi+peW8Ta30Qt1In4x177Mhrx/rsGd5Kuj19FrFaCv2OnTbhCOVF7+hdtOmETZ5EcXEs8E6/xMMR9LE2F7A4N60Rp0bmULEWU2btMPzKyn1fQJlqqEpE51FTy9deiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyxrP1kgPZnyBGtk4FSlgcL/M9xfqcCSHB0ypJ9giLg=;
 b=11jOe3AwiVMgWuqKfctr6CHQ9tIM5dxBPzNJOSu7+mxh3HO3m+MD2tSALeweK6IVK8s9ahee9JG4gsV0vjuszdajCdq358aj7zQFep+uLKNU6VL43ydh1aB2wBnhnqs+Y71PAG9K/jntt90sJGKKpVKRSvpzsTpIAzulCDWFPzg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB3608.namprd12.prod.outlook.com (2603:10b6:a03:de::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 13:48:08 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::a9aa:96ab:b5f9:fc73]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::a9aa:96ab:b5f9:fc73%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 13:48:08 +0000
From: Shashank Sharma <shashank.sharma@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: don't ignore the return from thermal_init
Date: Mon, 13 Jul 2020 19:17:44 +0530
Message-Id: <20200713134744.2731945-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MAXPR0101CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::13) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (49.207.193.46) by
 MAXPR0101CA0003.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Mon, 13 Jul 2020 13:48:06 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.193.46]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff8b8a34-ca7c-457d-e5f0-08d82733604e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3608:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB36084EAC9F6A9AF757C663C3F2600@BYAPR12MB3608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjl9Cg3jNiz73Xt1Yk8Poia/2PtuodagLvDySnGoO1o4gUF9RMIOoeo0bmeAKOwlTtPrtuevIco+/0wmVjTfr8wOWBifO26gvh1IcMnpsFCz/dk6XAIUtSVdvzCusMJQt7YTAMLMOf13854yWnPY3hPvgEemxWRHkQi17VoJJRTDkrInD2sj9rTZ92nMd0M2XywUT7TFH94pm1MYWGXd6sU8oMCemxyXG9D5QyZAWE8kfAEo8T6YkmhtcFsbJXj7sSgZuHKxLmumRpxGSVNTcpQ/ldiQYCEOIrdirHnj09cH++7gF5oadWFZ2BA3H8xR+LdKZohOFYaAc6q3b8P5XvTsf9LiQW+z+4wMs9pjceeEH5VTmicdVfcOcCsyjJ1C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(6666004)(1006002)(8936002)(6486002)(55236004)(2906002)(6916009)(1076003)(6506007)(2616005)(316002)(16526019)(8676002)(86362001)(956004)(186003)(6512007)(478600001)(26005)(66556008)(66476007)(66946007)(36756003)(69590400007)(5660300002)(54906003)(52116002)(44832011)(83380400001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4Qg1SepRlrK3+EtBigSgd7aYiBLEo3fZc+lbEfeyEIoNTy9J20eqTYwyB0LTBFSj8m2DrBuSDPl4id1/04WkuPXjeNW5hZ4Z02bXMB03sBR4eO8+pvG8tojWA0V5OY0PnRu6tPVvOEbjDV4TYUouWi/3zgtmh4q9PKFDRphR3C719BoR6uXaG81LIwNpShB/+p/Gr8aJNyzEBIRDUUuGKUXNcxFuYX343AjGi6PmpcCihek5qXtboiC8RwcswPxglOq9CTcz2ti5tV/eDuQmlwuKDyO4o2h/pRDCVxJ9zzX5wYAqMdpo3PTQpuP6hyWk1Za/fS3krmIoMYpECIbO+mGSDrZeOAea3mBAdb8RJ89etBcnpFg2s4NaPytdrae86Tm9Jg5yq//iIGfuSuqKKWBAgTkQ46AxNQH0/sSSdaf8nrns4cenVJE4FhxbcUT3VzYbHlITAiMenLXSX64+PZac4qDy2S4N1dKipEy84ow=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8b8a34-ca7c-457d-e5f0-08d82733604e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 13:48:08.7712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmo3h/vrjQZ4RjFxmUKPiAsOYn6Z4TAW2E66KAwOrhkZoWmiunUDgRYlxKBnFFcPs1JF57lx+SkpnQIcZ7QXUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3608
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Sonny Jing <Sonny.Jiang@amd.com>,
 Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The current hw_init code for si_dpm ignores the return value of the
function attempting to initialize the thermal controller, which in
turn sets the dpm_enabled status wrongly to true in hw_init, which
should be actually false.

This patch:
- Adds the return value check for thermal controller initialization,
  and passes the return value to dpm_enable().
- Adds a DRM_ERROR to indicate this failure.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Cc: Sonny Jing <Sonny.Jiang@amd.com>

PS: This issue was observed on OLAND while running the reboot
stress test.

Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si_dpm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index c00ba4b23c9a..923a1da554b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -6868,7 +6868,11 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	si_start_dpm(adev);
 
 	si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, true);
-	si_thermal_start_thermal_controller(adev);
+	ret = si_thermal_start_thermal_controller(adev);
+	if (ret) {
+		DRM_ERROR("si_thermal_start_thermal_controller failed\n");
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
