Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EEFC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC76961447
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC76961447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E7A6EE01;
	Fri, 14 May 2021 04:51:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06DC6EE01
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byXi2c9hWJkfwtCOSZAFEkaWaixpfzdnwy4f2IJZoTq4oJfedg0pQXvDDydhTANxYsrlSFQhc5DflASvK+M4mB951r16mA08Gz0M4faR1ZtULccB2FKTr5Su7fvl1Pc4DxiTUDNTrk1wDr3b/p69Ygzy5gt1giuQyE3tD372sYAxcxLRCPxQcbjAHEJpTLa5IL4vm375KaF7odcjlVTpbw+A0s27/tlkLIHMJacm//Getucb6oFLyurqrJkGy1xgFrpxR5CAMUc3w9ds5Av6rtMJZS7mXB9FHhEH9JRlWcBCVxDtLDxOaX1oiS5OIcOyK66rJb1IKIzA4TvzvAYCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ+DdYpphQwV4r1Uw2QVK6lXOuZ6ERo19eTB6wHI8Ac=;
 b=SnTfool99lwBz5fp3DQOFGuJXWYFHwE3Fo3/JaU0lXDba28pJKf/dRRwYq0UcXDrsLwhfbCj2G8LqLQxrjrac+zymkRd/Q/6S/zvUl2L9crKeQey20GJJxzMxp0cLWUQWu20gSC36B9Avsf2axQsa+UJGb8IccVHlCZQMYPzLxR1L5+1N6595V/QjsxN053dk2W2Z4uRYyIjyGyiI+ku60+0wJZVAz/rgp770a3iGZsqIwiSLKBCbQrxVb264VxwdIPIcU7kgk3BxdPHrqUIupAEpeSH/znmQb8Ucrazuf43SfqNDGBLedM6Q2Ta56RdTkj3XHCqM+d2bnmIz0BqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ+DdYpphQwV4r1Uw2QVK6lXOuZ6ERo19eTB6wHI8Ac=;
 b=Ki7caRWTXKtUXfmWZdH1iTwFEJDw5YsT5Qv2UcKtfdNQNcfn/k4pAwgtVMZRyOAeNUjhTj+un/TyhrOjbD0WiYAD1LTky6afNNdYXYe4EsGwH5EzZAaq1SutC4u2jrWyhR8uDXLrnOj2OXC6dkZGjL68J4jmQUVfftjGCE9Dme0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:51:24 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:51:24 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/20] drm/amd/display: Avoid get/put vblank when stream
 disabled
Date: Fri, 14 May 2021 12:49:59 +0800
Message-Id: <20210514045003.3069681-17-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:51:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f58b09d8-44ef-4982-cddb-08d91693ecd0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129541559E0CAEE804C2D6EFF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:128;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+n37jd7HQPvKBcGsQuT2DoPcyWGeUo+n4yjG1SEC7mKNMQ9i7T0+vkuRatRDGcTUh0y7Ua6e4Dyb7QfAqjcYMLnzgtexr9S7UwOAAiWmYxHJZ0YcXmxftkJVbiCJQs1VPrSIKWlRhmBEB2twfkUpTjK1Ix9xiLSXfVZykCGnoUuy4TKWDEdEKX+B1ceuXHyezaTUlWTarjGWSYuS5qDQa8BCyEq2QjTpt0RThGJ4n/K8L/h+kQsmZaWTGLex2thyGeWqjJmciQCSUaCyQiyaGznd7Q8kDsR5Fp0yKBf30MNf8BPsviPt/1ML4jTrv3tFKr4EdfoOnZTjnDMMtvfqqOgXeDZ26kdIYlR/ajOjJ3LAjjV22gViNqx324OzYnN9q8W7RC7BaLXn0GNGgC7Vo4EFGlcK3RzGzf4PL6VLg4z2vozbzcPm71bT7lvQ4+bQtYWDpkJk/PEhXIgUJSVvTMlGllDChz0heXZPFyOwsLIbD+b2ou/Zjh9SaMn5kKLALENSC1Q2GU1opNlpH7iHZkaznobZHtia8aKl+zD8GZ+uhBE6UCJDCgU0Qwm9PE2ybQPu3Vi20dqRYPioztRLAnk9GRp7TAqHMIPDH0Pm8ph+Z1Ji7mdnfz7uVCwljIzC4IqV03boH1uLa1G/EnendOZn94zICH+5Luv4zvCUS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9akzGGwf/GqkNQMlAIe6E56CGoLnuXkVI9biIIMERShNX99LTBPGu89ZVzj9?=
 =?us-ascii?Q?BGNSqywcnvm/a1liQU+mNVJBzqL3Mr0yFTjR0zEHpInTrhDz6St7jViIzWnr?=
 =?us-ascii?Q?nkk9AkXwx+lIilKQe/fzPpVcGdB3n/ec/nZtjj2X3M05d9U15g17uX+3dBPG?=
 =?us-ascii?Q?Oo8ew0RadQn6cnME15Pj0ZgvCCU4k801IGmV4/DVfCf5/5z/ga8DBWHMl8OA?=
 =?us-ascii?Q?UQqi5OGD5+UUzZaxvlN5rv2bbv/INIktPBxkhUcLb5J0pR6T81/UKb/EBYzd?=
 =?us-ascii?Q?hBD3IxLmf5nGEP21r6+/rQvzUigLlShUyVyT2Zcj+HxI5L48DqHZSs0gz/3A?=
 =?us-ascii?Q?SjApgT77Yer6uxHojd0Tz7X0zTQ9tAqK87/8xrpY6avqqjgWehmHjuzCcC94?=
 =?us-ascii?Q?GDIQSvhcqIHw0ELb5FrRbDM9uh/DuPhf86BFefvpfgFPR+Z9JpsTwj713RE0?=
 =?us-ascii?Q?obpXIZH4V+Ez4bGfUvNEQbhZZ1FET/c1YuUai2KvxHqPgFukZPzkrVeA6Leh?=
 =?us-ascii?Q?92OG50CdOQIi/02gZXJuQtY0IcNY7S8mENXqNsfqXDOfURY9APOea1i8uQLN?=
 =?us-ascii?Q?rkr6MTDd9gDmLoI1fEvb2PeIc1GRcUjFbGcycK+uVW0tkn8htta+f5HvRDFD?=
 =?us-ascii?Q?tULUK7dEheIpzFZ5xF9tgXYCcLNe6oopJJ3+v7RQorqxRkgbM8iG2br4OLjp?=
 =?us-ascii?Q?+PXgkbpiFQleNbKFm8iR8lr20e4LtCycDOi/w9xndQXip3EhkUxs3ma/r2c6?=
 =?us-ascii?Q?E26mJdvuJPgNdIgDxNg/Dn/gLfJnzr1ZoAn+WfDRGY3GKZnlvPzJZV3N4W5B?=
 =?us-ascii?Q?hJ+bPdueKVqsx6DoZm5EUWbSvrKOgDtgTMT/KhgChf6eweVIs+8LIeZMRRjh?=
 =?us-ascii?Q?/Mpl2TM2iV4woJu7MYb3zRN0ySF6NXgjnJ8u64NWXW6JWJ7L9UP8aJaMnj4g?=
 =?us-ascii?Q?1qGpL7x1gJAs2VT9ITe6R4ZIDQqGKvi5SmmE+00mLDRb+Og00MPU5JWIMEvW?=
 =?us-ascii?Q?tz8TFGf2QyBkuVsWHNPoj6tDMj7Qk4WvGHEUvDZ6bSUVgnuhRJRhEofl+l7a?=
 =?us-ascii?Q?UydLqRDM167vQzeKEPDhfq2UlU/COhYAHGbrFcQOAV+Q54A+Z45Y0FqAFNzt?=
 =?us-ascii?Q?wRbPZaHmsUv4P+Hz9qWb5MML5R6cXYsnnHR052lUvjaBek7WPI9SO/k2NFVb?=
 =?us-ascii?Q?Isfrwbpyd2ZUv7LRGD6uqMOHgoWQe9RAyR/5CKVx06J66UEtcOxoqEWeObQ8?=
 =?us-ascii?Q?wf5+lVuoyj5hebwziO7wV7TFZLabNk03pbjxm/g7JTQbEYasvc+H4GJ+d6G9?=
 =?us-ascii?Q?FDZnvarO1z63Ksv44zKcMa8Dr8BBBATTJRblq3UFBy1mNw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58b09d8-44ef-4982-cddb-08d91693ecd0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:51:24.0455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyycwKVMuQzIxMquIHNfcLdcvNPgBxTG46cPMztqKkl2r9lj/isK6iyhV6KPPfAnztFFKRuff5mtMeeJ1B0jtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
amdgpu_dm_crtc_set_crc_source() will call
amdgpu_dm_crtc_configure_crc_source() to enable/disable CRC
generation. However, configuration will be deferred to stream enabled.
If stream is not enabled, current flow will still try to get/put vblank
refcount.

[How]
Return EINVAL to skip actions on vblank refcount when stream is not
enabled.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Chao-kai Wang <Stylon.Wang@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 5 +++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0495d1ad6222..812a916734e0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9122,8 +9122,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			}
 
 			if (configure_crc)
-				amdgpu_dm_crtc_configure_crc_source(
-					crtc, dm_new_crtc_state, cur_crc_src);
+				if (amdgpu_dm_crtc_configure_crc_source(
+					crtc, dm_new_crtc_state, cur_crc_src))
+					DRM_DEBUG_DRIVER("Failed to configure crc source");
 #endif
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 7f36b2bbbeae..cce062adc439 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -176,7 +176,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 
 	/* Configuration will be deferred to stream enable. */
 	if (!stream_state)
-		return 0;
+		return -EINVAL;
 
 	mutex_lock(&adev->dm.dc_lock);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
