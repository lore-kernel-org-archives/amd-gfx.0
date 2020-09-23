Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C628C2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 18:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C538D2371F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 18:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rgJqkqdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C538D2371F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 296ED6E9E5;
	Wed, 23 Sep 2020 18:39:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7603A6E9E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 18:39:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oV/fxz2kOD0DDZdC9UNwp+r9rIFGpaegwZrxEh9uW5tmHRZ+6as0/jTjuJSC6IeIA9AfMehXr49hcAdtr4ncaGHHK+5slBC9nclBz0pmbLFo0mVwaEbU/floeSQbRmuSdlknSsJeoeJ/2T3SwHs+SnuIu06PiiyLGy5/wxNLN0VUBjt8tz5box2qcv0HypwgK4Ay3KiJXdh+SCN2EfI+i6SM1UGGNHItUTeHtqVeotSQnMbDsmnWBkgmLe66nStHUdYp8D8JY2oGkJ+hVn+YUD7yD+ylHMPW6iA+BC7OQLkgPEoc40F5XDkj27xiCL812MCxDqP0P8ETF0eu9prtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBqz5bPZ7LvY84hluCi1oVEwYv5e0GOl/2dWLuPmwkI=;
 b=manTYgpTsRKukTwXIYYquh/fNpF72voduJSnalaBq8cnNpeo5RyXRg8I6juawDqb1iAVdw9iTDeEcMmwNWbNd/QD7FO8V/KBUk+Id2gKngtVOKb72xPHXW+Yn7D41b5k/SOmdwB7xTRMxEtMVVzuFAYzP+v5dVFD9kbodZ6zkGvR6c7sZIOVfA7FsY2ucLq+AJ9Nb1w1ULXMZmfdPyij7a6fpPCcjUsszslpftzlK5Hy2yZqTXs+5UofQc32rj82/GEkeeyyC2G/TGcU/qNSpYXVAHFbsFsN08zMfOjOFcz6eUmi03jap4+WQlmN4YRhul7yh/MGzCQrSQ7h3vZYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBqz5bPZ7LvY84hluCi1oVEwYv5e0GOl/2dWLuPmwkI=;
 b=rgJqkqdEz1RV5Ez+qudQ8mi+PkBdOwu4/rL38kiuT84yjFzl8Nb1j1p/5EwO44xN1j41fmo3a/CEKvwwugdfsGcF0xn9n342h+wS2INDRzY4eAnIWAeEAmnvKuMMZJ1yWiEJ4lTatIJXJ+HxzqKWPfafsLz1yjyxwt3T+hUeDTE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3221.namprd12.prod.outlook.com (2603:10b6:a03:135::29)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 23 Sep
 2020 18:39:39 +0000
Received: from BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::d492:66f5:21c4:7046]) by BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::d492:66f5:21c4:7046%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 18:39:39 +0000
From: Ryan Taylor <ryan.taylor@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/include: add PP_FEATURE_MASK comments (v3)
Date: Wed, 23 Sep 2020 11:39:02 -0700
Message-Id: <20200923183902.16575-1-ryan.taylor@amd.com>
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2600:1700:9260:7260::f]
X-ClientProxiedBy: BN4PR10CA0020.namprd10.prod.outlook.com (2603:10b6:403::30)
 To BYAPR12MB3221.namprd12.prod.outlook.com
 (2603:10b6:a03:135::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Desktop.attlocal.net (2600:1700:9260:7260::f) by
 BN4PR10CA0020.namprd10.prod.outlook.com (2603:10b6:403::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22 via Frontend Transport; Wed, 23 Sep 2020 18:39:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8dc1a935-16bb-40af-b468-08d85ff00708
X-MS-TrafficTypeDiagnostic: BY5PR12MB4068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4068648981C3629E1666006FEA380@BY5PR12MB4068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKYjXaoDw0ewl1/9EfbQH4YEEMMdv8fCF1YfO8xmOiGznV7xpqLjU8tQOq+lD5c+sdzGYKvgn6zRfn1aJsNfGxP7zHC1lgmet8kTvvCW/eE6cJiigkhAWcZWFiagsPDtvLIMuX3/ZPYMIEm3d7hRT3HZpna+IWiZyFlV485DQIqwMbGrjgNCVJi5PTxnsPYJZzkMKv7L2z+NrQrUH4/WbAEWlBdcfO+1+RfI3a/Fc+xmaaTHGTU5twvZ7XTkwCJ7JXrPISQ7nXFV/6WsJK51LQypMZjAPQEWuH6B6RfKbehoIErqyyxxsXKAo8VYXtGOZTWjaIYXGJyWiSdclf400k+8YMNrXMCXcHG0AM8xHzZUG2bjqRkJBa4KMXD5K5Wl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3221.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(6666004)(2906002)(6512007)(478600001)(5660300002)(66946007)(66476007)(316002)(36756003)(66556008)(1076003)(2616005)(52116002)(44832011)(54906003)(16526019)(4326008)(86362001)(8936002)(8676002)(6506007)(6486002)(6916009)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vsbUdV8eTezuGSBnXKlyAaSDUNbBJP04FG8RMpaTK7xCdfJQ1NRlalv0U+9cDpRdJmAwdE9kD8vYSk4RBJupcKZn9v0vyI5cHClai/yyUTHzSaGib2qnboqSeyKbBRxBavqvOxEEKXmLulxE/IdphbYHnh7eqL+Ygxezsw6b1ndtiEyWI3jRB2xJ8ftYgAunw8po97BoT8EH15q2RLXaSv/ln8iE422xWr+kyoMrmPyk0ZcnMlafT5YKezN9ayRggbZWbBgJbt+QbYAcnlkpcIDeouyqCQ9wh9anCW8U3Uzg4HoSkuVR/1RrJkht81Lb4JErW6cELghIINuUs+4oKG0uzJta5pZG80aYGsBUE9HzHBJ/VogyJYrMIDNvRRkRwo50WxgTpbcfZXbHILkpk4nYvGtXLmCVehyEitx9/E4lSaLD2uNlLPtcTaDKPrvtAVIORnucXbfEzvoq1/nr5AtZvXGb/o8TdosipkM0JtfTindnNc3FL9QMvahvBeo4vsci69KTv+8wL6wfsVKR14HjEU7v+MjlOr9RXolJ8dzxa1wq97WxbbiClIWVmAXZujR6dkLLj9BPQVypTzye7iOh2a3Enof2uFdIMuMI91Dt5gMgBJsjlRsc5pLSvHKk5P0ed48VgPWjBbPkxatxiOizWszzvV/5JPMvEq3jvas=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc1a935-16bb-40af-b468-08d85ff00708
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 18:39:38.9554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ae/GXwH6S9S7iIYo213Ny0lJ8ZlKYLhoGfI0h8ET/r+E9QhHakFS13ELpJr8VENK5UZpLkjYn6AgoE+YDXsTjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Ryan Taylor <ryan.taylor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Documents PP_FEATURE_MASK enum.
Provides instructions on how to use ppfeaturemasks.

v2: improve enum definitions and add kernel command line parameters to
    ppfeaturemask instructions
v3: fix alignment issues

Signed-off-by: Ryan Taylor <ryan.taylor@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index e98c84ef206f..6f1469742b3a 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -128,6 +128,34 @@ enum amd_powergating_state {
 #define AMD_PG_SUPPORT_ATHUB			(1 << 16)
 #define AMD_PG_SUPPORT_JPEG			(1 << 17)
 
+/**
+ * enum PP_FEATURE_MASK - Used to mask power play features.
+ *
+ * @PP_SCLK_DPM_MASK: Dynamic adjustment of the system (graphics) clock.
+ * @PP_MCLK_DPM_MASK: Dynamic adjustment of the memory clock.
+ * @PP_PCIE_DPM_MASK: Dynamic adjustment of PCIE clocks and lanes.
+ * @PP_SCLK_DEEP_SLEEP_MASK: System (graphics) clock deep sleep.
+ * @PP_POWER_CONTAINMENT_MASK: Power containment.
+ * @PP_UVD_HANDSHAKE_MASK: Unified video decoder handshake.
+ * @PP_SMC_VOLTAGE_CONTROL_MASK: Dynamic voltage control.
+ * @PP_VBI_TIME_SUPPORT_MASK: Vertical blank interval support.
+ * @PP_ULV_MASK: Ultra low voltage.
+ * @PP_ENABLE_GFX_CG_THRU_SMU: SMU control of GFX engine clockgating.
+ * @PP_CLOCK_STRETCH_MASK: Clock stretching.
+ * @PP_OD_FUZZY_FAN_CONTROL_MASK: Overdrive fuzzy fan control.
+ * @PP_SOCCLK_DPM_MASK: Dynamic adjustment of the SoC clock.
+ * @PP_DCEFCLK_DPM_MASK: Dynamic adjustment of the Display Controller Engine Fabric clock.
+ * @PP_OVERDRIVE_MASK: Over- and under-clocking support.
+ * @PP_GFXOFF_MASK: Dynamic graphics engine power control.
+ * @PP_ACG_MASK: Adaptive clock generator.
+ * @PP_STUTTER_MODE: Stutter mode.
+ * @PP_AVFS_MASK: Adaptive voltage and frequency scaling.
+ *
+ * To override these settings on boot, append amdgpu.ppfeaturemask=<mask> to
+ * the kernel's command line parameters. This is usually done through a system's
+ * boot loader (E.g. GRUB). If manually loading the driver, pass
+ * ppfeaturemask=<mask> as a modprobe parameter.
+ */
 enum PP_FEATURE_MASK {
 	PP_SCLK_DPM_MASK = 0x1,
 	PP_MCLK_DPM_MASK = 0x2,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
