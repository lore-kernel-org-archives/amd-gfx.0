Return-Path: <SRS0=TD2D=DN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CBDC41604
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2020 06:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE5B2065D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2020 06:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oBHuKXsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE5B2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C667A6E106;
	Tue,  6 Oct 2020 06:05:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C13F6E106
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2020 06:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrM6xZWPFRdhztMmj3+O1guWc9t3+ASyIIMWQwrh9DLoDDqYS+yJmvyCs3UMVsQuujRLHYzzBweH2dVYZzXEkdiZhK3umI+iPVnp1YVTSN6KOcYNIWzbzk+ZID2KU9zcsc0cgM5SNSnJu9N1polOWI7frV2ByoOeBfRNYtc/KlMGQOjBJ6kR2bvf25s5SDpRhsGy+l7/8IcIl8vNY867tMN7IrOrItxPZIEH4T/LAoPuhWf8vUSYi0Ja2cZ8GaTnWKKL/msuCmTcDPrH+7sl7AmDb/Rp7vDln0eNALuWGJJbMgY3hLkBc5rdaqKDEfeWgUoGdjDLqRQBtux7PlLGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/UQXn9wdF4OABIDEhOkmBjIGsUK0nBTyFb6UFviJX8=;
 b=YNNd3say+cu6b+Ah29XYLAnLFPeZHeCzCYP8Ps/QZSItraa7Mw6hMp3Uk1fNtnLQzztKavLYO5uSxATsiApw+34tTWpluzXrUeFsZZ4wJjc8US07Clrk8WwXPlNKkDFj6yitzsDQJr1TvXIsTwra3eV92mFr/BvnerjTFU/heCt0p9Evf0d8zR7X6bqNTkSMX5PxzO2T3eud7MzRNC11i/flNtSFATBggKbmfmnuEmBMxttENPH64Klvq4tfml9Dkth5F+DwPxiNY+w4dBXwKAllR6N9gqOMaSBruCN+v8xSabgKL48MogMEjveIDObpKSfWUPHwO1wkgbiZeybPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/UQXn9wdF4OABIDEhOkmBjIGsUK0nBTyFb6UFviJX8=;
 b=oBHuKXsQlh6tsJCtXpD2HLFZ9MLblzVOpCT6Pp6rAmmuTvQhlduxVfiK6fDBQcFlpyZirRstnryIKL0TVkIU7vgsJNR0+0ZKShaDjK3m5NoNDSKtAUkaWmcswMSuToT4XCkwroBjNUjChQ88kKnwXH1pwjqZzto1VezzbJkODxo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB3510.namprd12.prod.outlook.com (2603:10b6:a03:13a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Tue, 6 Oct
 2020 06:05:43 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::98f2:8459:fb8d:577f]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::98f2:8459:fb8d:577f%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 06:05:43 +0000
From: Shashank Sharma <shashank.sharma@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add error message for DAC setup failure
Date: Tue,  6 Oct 2020 11:35:15 +0530
Message-Id: <20201006060515.4622-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: BM1PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::31) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shashanks-target.amd.com (165.204.158.249) by
 BM1PR01CA0161.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.35 via Frontend Transport; Tue, 6 Oct 2020 06:05:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a601e124-ca28-4193-16c7-08d869bddbc6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3510372CF32EFD9C16534AF4F20D0@BYAPR12MB3510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jaZzCppLrKjfuOQyAOq2QLVlNfqhl50zhkV2dV8WQbWsYKxZnRao4ddb0qqUxCSK/Q9/EcQQJtEM4TQXDySOmXBPED5eN3f9nEq9MhpDB9xPAeiE9svyG4aX2KVgTBx0npdqvaUmk/IxSThQia8ahka98jSxbtrH+Vm5OlBE3cE32Vc96ZuvPelDgimNNYUBJn0IQTp0U4hUnA/9QGFMY0h2BrlO77xEqzwX/ybETY2xLfxxHeCQHM9dpOkVp3fPs6Gu8yFWr2Nax3k7G3Za0YfOZQN8+Uz+Cu2zoXtV8WcSRzFYuJkgorxE29TF20+/g0OeoL5jX8/emf38c4dvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(4326008)(83380400001)(44832011)(8936002)(478600001)(6486002)(15650500001)(2616005)(5660300002)(956004)(52116002)(6666004)(36756003)(1076003)(66946007)(8676002)(16526019)(2906002)(186003)(316002)(66556008)(6916009)(66476007)(86362001)(7696005)(26005)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: C/79V/H5nkX7nTlKG9PB9vxp3INPNlzSqRuklRK31A20M3WtwaemUmlAZLYgb3/n5bFT18tRsLXqqpPLvhg/A3qtAgz6S0USC0xMs37PosXDJTbtlEyVMYhMX+qaGuMyot2ebOSOnszCt7LyPAwedM36lyeb4OArLHBVDWEGhGzxU45nCpYulQ5WaFutA6MVP08JaDjusRAz3jMXQ1O1X4jlBx+JrLTIbK/Lnw5M2bHqWXv9+rJtpbL7kW/jP3ShLxynerUkIVRKKkYiil1EDlJbW86oBdjPy46ntjbNjM8xj+F6UYjBaY4wGdDB8+FbZxrWP0yxSbE0t2T5t/na9BZnpnciv9dZHHvB8TJgHIqi/MvBgYvAPJUXxDvjA7V9q2ECMaKkspcIDaf43sJ85oQHBrgdQ9MZrRc7yzeedn3LDnQ4XTjsZlVd2iUmf73T3xmtg5lJ8jXxqjhJcvvaW7Y1H7OZCBaNAVN5raWUe+pWn2d9ZQ2J0E2DWxK7K2ljWAmFo6zS491GaUgZIboceuUQ37/fR28WAly8UilP8Ao26k9TtzPPM8OkQmXlZgQQQvzb5CWEOMgyTFvSBYgRkiNfFsINvXNz5E5NMu6BeBv+XYjxBjKm+G5UXnbAOck/izlnii/yd8f0WayzdCSV6Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a601e124-ca28-4193-16c7-08d869bddbc6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2020 06:05:43.4780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbaJlGnXb6ZgQAQgMsebMO7Rwg2HSHwV5ZAUeydLshghnhtoQ0wP426vZwbouKm4fq5ipDAPjTkS3DJAT8kqkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3510
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
 Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds a return value check and an error message to
highlight the DAC setup failure case during encoder DPMS
operation.

Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index 1e94a9b652f7..3779f933564b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -341,8 +341,8 @@ amdgpu_atombios_encoder_setup_dac(struct drm_encoder *encoder, int action)
 	args.ucDacStandard = ATOM_DAC1_PS2;
 	args.usPixelClock = cpu_to_le16(amdgpu_encoder->pixel_clock / 10);
 
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
-
+	if (amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args))
+		DRM_ERROR("AMDGPU: dac setup failed\n");
 }
 
 static u8 amdgpu_atombios_encoder_get_bpc(struct drm_encoder *encoder)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
