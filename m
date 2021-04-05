Return-Path: <SRS0=xdDd=JC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1651CC433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Apr 2021 15:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7070461398
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Apr 2021 15:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7070461398
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 067D189D8D;
	Mon,  5 Apr 2021 15:08:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5929C89D8D
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Apr 2021 15:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw4P5p2Jd3u9Tw0KfJ7MgSykvRzakkmUQ3kRehTEYKpu9gdu+ssuca1NRtxhEr1yHuo+7YTIpw61Fy8eC3Z+Glv3XDsJxJB+Uh2yeTHma1Ph/Iivhc70B39lWEh8YLF3zBmZ2fAzkYvi5my1B9yJcpxlyLs5NyDsHA01DKU4jaAjSiAhsNdemttZYdskcK2poXXSHLXQDZAfnP4EpV/eR40UnLpUVoUVhXIWpUi6PRQ8g3TyBTQcnC4uZX4kYHqshlN92nYThxuQGtTpWheV1rOHIxS6o2H88n7K5GALyTLNUGrB6TvzYw7QbHefZNkCNizJsIL02QIuex8SkUswdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt3FCBQZ7/Zyvwt1STpYH44cJcXBEmWcu1UGvKSfogM=;
 b=HB0BFOcsHeMtttBZICFGXjP46aIsUpQF5gbUjQP6t4L/s3i57lqVxymAwIlx+LWftpeJQRDOQQ4/7letKzDTK0lCQO8MRRbxZO4c7d4X5T1gaaoTSbG8Qv2ocJbwusUbVrAsXiKyL+mV4plAaFweclHDhKlmHPAy63eydsa76Rs53GNu7l1cXN47KbzOt23QiWY+ZNx3V4YiDpdg9szY44GtK+bRADKL//sjYz7cyYzZUhKRrLgLkXmeIHEw2Rpj6m7kXfEeoxMyxbz6Bj+IVMEtEmwRNItAZ50wGN2m6whdpNNIH4pHH/i97yzjSLWhvkXU+/5TuykvJPGRf/ECdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt3FCBQZ7/Zyvwt1STpYH44cJcXBEmWcu1UGvKSfogM=;
 b=TcNz1QOCjNWnNasBwkpc9SowxtKILH81xPD8AMVBJd5iCrNpnaI3DAVzu2VbbKPAXXMjK4cZUytmZHXYEPr73T9fPdTKlQbRL+gwx5vu09G6Mp/DctyVxsyilZ+luDQjXWmyvEiWRS0zyB9MknQ5F+XzuzJZGToTQmDiRCLwJi4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1340.namprd12.prod.outlook.com (2603:10b6:3:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Mon, 5 Apr
 2021 15:08:46 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 15:08:46 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: Ensure that the modifier requested is
 supported by plane."
Date: Mon,  5 Apr 2021 11:08:34 -0400
Message-Id: <20210405150834.3942-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::11) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Mon, 5 Apr 2021 15:08:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5008e09-a781-4de6-4efc-08d8f844b564
X-MS-TrafficTypeDiagnostic: DM5PR12MB1340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB134096CB2EEFEBCE7D45C0D8FB779@DM5PR12MB1340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJm7k3ZKTBW6ex4L2pdqjGb6j9clxjxC5t3XhdjrarIFRsIRaLB+DprB+Sf/GAUMarjxdWjp/B5eikjQvR49GwDeqxcJ84XSxYalnkQD0ykAJrHmwnCva28R7xESOVSBL26YKZmtP+KcFtfvxqMXPgz708HaNcNmxCz7whZ+PRDA7qcrC6XtO2uJYHnFrrbcR3gvfr8oGDdO3setHwTHe9KMt1szllM8TEky1T/i24QsPk+cSmaInqXSuV945Q49ZcaRFUIXV6w+TMmEZuX/J+U1osyRkzidZwV1B8EoOcxq2X95OKqieK4rGNY8xZaQkc/nZZ9LKnW+Fiy0K6+aYMZLMHC58+BK9+2anV1aa5V2dRK8+5zlzjqGGQ3IomArAHVPXai8B20ibBkvWSSpT7KbrcKkf9qJWVAGeP516+S5bHCQN6NpY2cnvKcnZHDKA2v+Ydn7tip7r60UY0OpvJW1DbHiNngAw8vwOqI7UslAMuT3l6TkQgp6T/mLMmzC14JiDF7fDk8mmZEjUJH6eWHI1tVs8gf9HCUMIO4bZJYaNofOz+ete412OiRXWCBAuWDNwH+JEOBHIZLyTqJyDqDCbqMyQvu5Je3pex6bR9oLeYuzjQnfy8FdoyQYalatpKZ3hl1V6143Y6Uv/Z1lwocKJyLEAZU9+XVQrW2Ng0SBe8pTSwS/U60UqrBeftbS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(69590400012)(66556008)(66476007)(26005)(6916009)(2906002)(1076003)(6486002)(83380400001)(52116002)(38100700001)(44832011)(8676002)(6512007)(8936002)(956004)(16526019)(2616005)(186003)(4326008)(86362001)(316002)(6506007)(66946007)(6666004)(5660300002)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AAu5iU0elWvdQkWWzyp0d6HOWlXneLW5X5GtEWrDgiR9SN1HRrDkHaV5IkL9?=
 =?us-ascii?Q?y6PJqdqUNU7KFKgZu+81utX4ZYFuf1KC8xuuBgYj6HsPAZrb+7DhnSF9/64K?=
 =?us-ascii?Q?ZSccD/ILUD5GQ9KuRCfz+sg8e3zsV4kUQSi4oa5pxNA87ZX5OJgoOCyf7p6s?=
 =?us-ascii?Q?Q+mJNb8rZG9ca+jyDAD0SzBb/JmWdKpLa7DkqK87YrrY4L5DWOiZC0uraaLK?=
 =?us-ascii?Q?pnOhE1hG8SbzTt5/NEHZvAuhOpfilcrgUHgXokwYCTWutooO3piKZGx1JJVR?=
 =?us-ascii?Q?pVTTaPahviFVGjWN5q/S7ljNJSzXKp9YaeoaB6SJRjGnaNmhbEGVoRgJlFpY?=
 =?us-ascii?Q?OmXUGSVfu1M7DGiVaR9gHMgrY4tUMluhoBlfGuqlUzFh/yotqpclqpTfOZLu?=
 =?us-ascii?Q?0LT8FEgxB0+kYRDpsx5TnOGGX/LLoGtB9D6GZIaW2lP42cIpgk6fyGAZFuGQ?=
 =?us-ascii?Q?EOys+sidF7kl2zI63VjKwljc/2aq0ZB6hoKloHXXGOgnCuSYuJ67R+ri6CMF?=
 =?us-ascii?Q?TxeboIeuFY1xuMLVw3r6QAJuYBICMP3EDETsRzFG0MN9gfP+XMh8xwV0V0NK?=
 =?us-ascii?Q?kUmumW9QX7EU/NVkPiWhWaAkvDE/uzV1rIKpr7Ms9gWPAzPPM4eIgdV7xGbb?=
 =?us-ascii?Q?xaYXy/fuKLIIVKNs/z61Y9PXYAuuzyHQcaxXOGuicySYdmEZWmRnHFYVarzS?=
 =?us-ascii?Q?/HUjKAS60MNdCReLGpkcigcCmyEIVebae6lE2jiFO8MIJeoQugOzWfskP6m6?=
 =?us-ascii?Q?Zkr7mNUOJqRDm13zloQUF2TaGtJVmqbW6wwG5MsCoqE+5fj305ka4v3YbDdw?=
 =?us-ascii?Q?NeQ5W0dQk5XqYj7zxk0EpS3EqQePN/fNdQoyruRG6mv1qeHNk3czCqd4MNw8?=
 =?us-ascii?Q?3yNIrQhcRNt436KgrFRwONE7QRye86/JMX/nIaqavPwWPZflR9vbDEx+gcS2?=
 =?us-ascii?Q?WtDULmiPG+bTjSNNUa4UTXgEvBjc93eEz/qjPmNvWFkTR2LJGt41oujPExNN?=
 =?us-ascii?Q?sFyIwxXLyrILEgMFzXyEyVEC7gr5xjZdQ/gaXWVOrDooAyIpsiqzfIDTFeTV?=
 =?us-ascii?Q?4YlJnoH6DzW966nXhXxuH/Sks/6KEnAcUknMkZ0jnL9EpDpIfbAJKaG31pHB?=
 =?us-ascii?Q?IOjJgo4WroSUbBupyDbpjlJthlbT+bBT4r2/4CcS5qm63Scl7nJJzxjhn/Bu?=
 =?us-ascii?Q?h+SHcrVKaXp4X7kEMzKvWo+y9szvd6UxklDlDB9I8f7uUr34EBCxFbwBDg0t?=
 =?us-ascii?Q?J2sDJVjVd4mk12l5e4ePrHeUJC5KhuLWB1htUCAfniOF1I/EyOgeeXOJPTsD?=
 =?us-ascii?Q?s6ETKryob56ILG0hL6+17QeM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5008e09-a781-4de6-4efc-08d8f844b564
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 15:08:45.8569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hE88vAhv+lm5OaFNvgWYHsH9KRK/DHJ5+Gu34M7fYKfSiX/8Wp2GyE3f6VWBQBCd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1340
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
Cc: markyacoub@chromium.org, Rodrigo.Siqueira@amd.com, daniel.wheeler@amd.com,
 bas@basnieuwenhuizen.nl, alexander.deucher@amd.com,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 9f81b5d40ca2c689334ad8288a4ddca4722a6e10.

The original commit was found to cause the following two issues
on sienna cichlid:
1. Refresh rate locked during vrrdemo
2. Display sticks on flipped landscape mode after changing
   orientation, and cannot be changed back to regular landscape

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c    | 13 -------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++---------------
 2 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0f17984fdea4..6304a49b02fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -908,19 +908,6 @@ int amdgpu_display_gem_fb_verify_and_init(
 					 &amdgpu_fb_funcs);
 	if (ret)
 		goto err;
-	/* Verify that the modifier is supported. */
-	if (!drm_any_plane_has_format(dev, mode_cmd->pixel_format,
-				      mode_cmd->modifier[0])) {
-		struct drm_format_name_buf format_name;
-		drm_dbg_kms(dev,
-			    "unsupported pixel format %s / modifier 0x%llx\n",
-			    drm_get_format_name(mode_cmd->pixel_format,
-						&format_name),
-			    mode_cmd->modifier[0]);
-
-		ret = -EINVAL;
-		goto err;
-	}
 
 	ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 54ef0f3f37b7..ac6ab35f89b2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4299,7 +4299,6 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	const struct drm_format_info *info = drm_format_info(format);
-	int i;
 
 	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
 
@@ -4307,22 +4306,11 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 		return false;
 
 	/*
-	 * We always have to allow these modifiers:
-	 * 1. Core DRM checks for LINEAR support if userspace does not provide modifiers.
-	 * 2. Not passing any modifiers is the same as explicitly passing INVALID.
+	 * We always have to allow this modifier, because core DRM still
+	 * checks LINEAR support if userspace does not provide modifers.
 	 */
-	if (modifier == DRM_FORMAT_MOD_LINEAR ||
-	    modifier == DRM_FORMAT_MOD_INVALID) {
+	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return true;
-	}
-
-	/* Check that the modifier is on the list of the plane's supported modifiers. */
-	for (i = 0; i < plane->modifier_count; i++) {
-		if (modifier == plane->modifiers[i])
-			break;
-	}
-	if (i == plane->modifier_count)
-		return false;
 
 	/*
 	 * The arbitrary tiling support for multiplane formats has not been hooked
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
