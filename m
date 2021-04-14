Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0EEC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 23:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250826113D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 23:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250826113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 802A96E97C;
	Wed, 14 Apr 2021 23:35:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 336916E97C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 23:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fehxAYeUoksNPTvyHPB8CjT4L6yD2LeAKwN42dxRdtuwcfpfGdOFTCDMm01Iy4I59jHP4/zzLT+538R3AtwCQkU9yBTsOpPWMbM9pL36av2BqdIsdu5ybwjLymRm/TR6VMe2FBJ8hHghle9/dZ1dGMlOaBar3qvGYZr33A1jAKb/P2TjkWK5K18A5jvbMr8PfiK3n2EMmiikjLmqto40QstXsAcRZwbyC9wuNezO6fUnh+RqPF7rzaB70qF4Ta4MclHLzJWHWBPdbb8+e6ATnJ4ICJLNDDxP3Fv9ctQI4ZGUhsCmCBsZ3KeYWrA/zQ+iBFTujk2zNZZLT38oHwfvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prAS1AZpoBTSwwQR86MQXx5vuvfFhanecSbAH+EbcUg=;
 b=AxB8SN/RlMrbDs1eWQH14+24GroHvsp1uvLs4gaS+AZIONHOPob5p5F+CbK3azEZeA3iLRJrqfD67w88TApLN8S3PBtWpKbG26/8th/+o8BJW6CUGhOjhGfZkRePKzgn888ds/7E9CDLKwGFnRdmiR0eDfWJvZVCx6yutpXZCDhdwX6Vi1umwxxU1RoH6hrXcqU65xEoEPOgPn6AheZqR3O9o/3yUaq3BziFYwl/N2qoKk/VtLstIqkGXwFPLPmIZIHosGwWE6JGU9ooy3MAnlbwUS9QqcMyEcOUmyQSfx1Kvtb+m+/jlmAbsealCrPAWKNii1ZeoVZWaWmWKtYgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prAS1AZpoBTSwwQR86MQXx5vuvfFhanecSbAH+EbcUg=;
 b=pwCKtAHIzDp4fwRUsILP1pMw3txwQwE6nsXdbDYg+3JqSnF/SJlmNAb+Jx16dXesLuMj+l4X6GbCNo5Eh9D59xmbq8OlRfQs3eVkYJryygvxvC679ERqT4DkgYIS0nWXtuXnuT4x+BtcFYREuZ0Bz/s45Ll2nVkTuk7oWMOctGk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Wed, 14 Apr
 2021 23:35:45 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.037; Wed, 14 Apr 2021
 23:35:45 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] Revert "Revert "drm/amdgpu: Ensure that the modifier
 requested is supported by plane.""
Date: Wed, 14 Apr 2021 19:35:33 -0400
Message-Id: <20210414233533.24012-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210414233533.24012-1-qingqing.zhuo@amd.com>
References: <20210414233533.24012-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::36) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Wed, 14 Apr 2021 23:35:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44b32bc7-0e1f-4dee-90a5-08d8ff9e0691
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4265FC34ED13E2D8B798DD17FB4E9@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfJt/Yi9ZxA/cMwY59p82cjyRj3k1krCKYUG98vX1cts323n/EsGOS0mGqO27ULzZNsARSY2HgiEiZvyW5NfNJFSKDbSUCZpMlHa4rH5u1xjkrYRteW4VoKpyCMlbe7zvpb2t+Dlt7Txklgxg7svqOj7oqzlIi97ruuzFvZSx/uDZVXxBvP6+wYn8wv6mJFszuQlFYCra92zxvUdFme+BKQ+5lI+vvn5paPPmEAkFWBhij2HIhhqIN152QPkmjmOasxw/wcYWzSayPwAxG2IFaMFd1NDraUc8yVfD3lYyE8/a/hdbtwGWUTm6LxMZEJPDMYy4VLjNs18gK6ZE39jbnesa6/dLUF7K/G7Kkhf1zJ19VblB77zmps/JRZxJgi4AyW/pqv6cWBzBoyhDuqJbFEfUzxZOQ3NM336xRGkmPSa34IKQGdFMTGME1tfqrHFFvbDjdoQ0l/jYRp9cwV/lqUYKu4bTzPue2kcHjeWwCqDejYKSezOKfsoLqZidEi5Zqoa79R7VgPsQuVq7k6TILx495/O22b4xJOaYSmSclrRkwzw4KJ7yVduBuedgUvTe1FE2mZgYPpYCz7GhAe5janfIE3gVKvqxi48mRRfdz/PQSrB9k/USscqd6Bwi9kpWPa0Viw9irkE3ipchhLZ7+EwQxgsbvc2Ctnw2NTzR5oyYZhVZMrSNopLcnhqkisx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(66476007)(66946007)(38100700002)(66556008)(38350700002)(8936002)(186003)(6666004)(44832011)(16526019)(26005)(36756003)(8676002)(1076003)(2906002)(956004)(6512007)(2616005)(69590400012)(6486002)(6506007)(4326008)(6916009)(83380400001)(478600001)(316002)(52116002)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NZv/NozIiz5pE/yNGuaVitoxbjmyASkganndT1CuuKxmAk6FwdKoGPRZDh+V?=
 =?us-ascii?Q?l0ABB1ExFcojF/0cuHG1s7Y45MbKEEatleUF9o6djR73HveC+3TVBffC1zrE?=
 =?us-ascii?Q?rRG5SHbE/q1raVB4C7OHpBsqD82XvYs3aCfTjQOh8+FVq/i5Zoxrw9S0IbpG?=
 =?us-ascii?Q?paPDqse+SeErO80UECccjeKb+GnTN/ymqQeZ7aUM11Ss6nYKiwhJqL6Cjb3D?=
 =?us-ascii?Q?3RDBThOcw36JgV8rUYzRo0WdNKhvwaMT1QfCsiHUlOKNp7uuCNqYDAvUDR0G?=
 =?us-ascii?Q?J2YKTFHEetHCUNgXrvQK0DvL6hjmwPkFnVLRugZllvxK2eF2RVq0lIbQwThR?=
 =?us-ascii?Q?jL5iobLH/DBn0UGn5hXLiEeR7fU/jHOwDH2csiyhf8f/9FB4FZCiScIPD3t2?=
 =?us-ascii?Q?PblzngWXFId460fovzcMZgINJIUoVkRgr95KRqhCOALz1aAh39ZCIPsySnwm?=
 =?us-ascii?Q?UxxwyuJ1LvJFCaz33qQYEHRnAMvjL9hKuEQ6o35SyhvfKUfqkPnzGulDIhs+?=
 =?us-ascii?Q?Z2ntQ1nIv8nr+m9+Kt4ElDpCH0kzkvYjPc31CnVJ3eklPMi0j4AfYRG/AyjU?=
 =?us-ascii?Q?CmnbOChN3bDBH4bOBXbHUPRQaKFg0zLOYsgtov7aD8dHZa/sKzk0SRaFgbOn?=
 =?us-ascii?Q?5UGvXDXP4wyYzhqd5LvnWsQkW9Ctu5v6D1OqBDYO4ZLA8xInPXTuDdFwGK36?=
 =?us-ascii?Q?b4NxZsHNnf+xXFMx+VV3yB8o/StDIByl1TrAX1+awcIBv5pgzQB/e9coUcod?=
 =?us-ascii?Q?3Xl2/2PR6RMFQqAPn1byyG76qJtXi4zeiGscAvHw90ayWAzoyQIRAF4Oa4OE?=
 =?us-ascii?Q?yBg/Kib6G77EuHLKbzFmx0bzbzHA1pUFh1MryhZChX5UsCH0mn3gQ8nFg0un?=
 =?us-ascii?Q?hdlchyzbtBZM2/q48BstXDJ7djmz69vzxxgsmuw7Y8t0GkXgADjTsPed7u+s?=
 =?us-ascii?Q?l8qmHB0Er0m+OFRWebvJWYsIHNUZ36rYX/U6kk2gn9HJ0GHZtZz6UE4FRu3s?=
 =?us-ascii?Q?vMae/Lsp31Mxq6ZEB+a7AsktfticLJM0q6o9cQQW3sP05kbbApuvBCeeWXjS?=
 =?us-ascii?Q?Q0pYMvF27oiSBbw59NAyoJQ3fgt6Hy7VqW2+Jn8bPj6pugXjPTNn9CInynyH?=
 =?us-ascii?Q?FKVcQxWFkI1sgkrtIwx5fi+Ni0ITiC1jtXa+D3zAxwAyyUYb5EWkK9MA5Mf5?=
 =?us-ascii?Q?C+L4I8fhDJcyePI0xmIj82sNZHl7hF16CQnu7ZPj8ImAz2zXfVE6ZY+qgIGw?=
 =?us-ascii?Q?d89L3QUdGrk3lfrNzVY2EAvgEwz9/1RXnlcFoQqm0/D4sqM7/Ex7nCQOF7ND?=
 =?us-ascii?Q?xTWEOp7YGIfDNKn/6uTZ/lBf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b32bc7-0e1f-4dee-90a5-08d8ff9e0691
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 23:35:45.4932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eV//Yvr0RDl4cWiij6GUd0Wvs6Wwp5Y4L1ITEhetjLIhIZDqdDEnsD4bDo4DAeB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
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

This reverts commit bc3e72b3c3f20ab1583a8464e64f1a68169a28c5.

The regression caused by the original patch has been
cleared, thus introduce back the change.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c    | 13 +++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 6304a49b02fd..0f17984fdea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -908,6 +908,19 @@ int amdgpu_display_gem_fb_verify_and_init(
 					 &amdgpu_fb_funcs);
 	if (ret)
 		goto err;
+	/* Verify that the modifier is supported. */
+	if (!drm_any_plane_has_format(dev, mode_cmd->pixel_format,
+				      mode_cmd->modifier[0])) {
+		struct drm_format_name_buf format_name;
+		drm_dbg_kms(dev,
+			    "unsupported pixel format %s / modifier 0x%llx\n",
+			    drm_get_format_name(mode_cmd->pixel_format,
+						&format_name),
+			    mode_cmd->modifier[0]);
+
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c3cbc3d298e7..11cd441c033f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4306,6 +4306,7 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	const struct drm_format_info *info = drm_format_info(format);
+	int i;
 
 	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
 
@@ -4313,11 +4314,22 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 		return false;
 
 	/*
-	 * We always have to allow this modifier, because core DRM still
-	 * checks LINEAR support if userspace does not provide modifers.
+	 * We always have to allow these modifiers:
+	 * 1. Core DRM checks for LINEAR support if userspace does not provide modifiers.
+	 * 2. Not passing any modifiers is the same as explicitly passing INVALID.
 	 */
-	if (modifier == DRM_FORMAT_MOD_LINEAR)
+	if (modifier == DRM_FORMAT_MOD_LINEAR ||
+	    modifier == DRM_FORMAT_MOD_INVALID) {
 		return true;
+	}
+
+	/* Check that the modifier is on the list of the plane's supported modifiers. */
+	for (i = 0; i < plane->modifier_count; i++) {
+		if (modifier == plane->modifiers[i])
+			break;
+	}
+	if (i == plane->modifier_count)
+		return false;
 
 	/*
 	 * The arbitrary tiling support for multiplane formats has not been hooked
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
