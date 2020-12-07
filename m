Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006AAC4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 03:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0C322C7E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 03:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0C322C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10D96E566;
	Mon,  7 Dec 2020 03:45:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3366E566
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 03:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWElv7BSCAlr5ARB2y3gILkZXIsmgSFczdKagpNOit7FBAYwltlrguHTDms1IsCk5vhOmCCf/enxUs0CQakGJJE8IU4foPOl/dTwIxWUougEfcxrGlJJYOKaXczRlijVROS2QMY2dShCJEw9EOgeUYrVjgALt+O7+b3BRIXZyiXlsPPWRoO+dejYmQDJ4HmMm3qJoLEeTzrLnWav8kX6nLAqtnljf0vyOGv1LQM0G1mchpax0glyT+ARpsH2nYE5y/3Wt7+tSD/Y74J26fHl1JP/ruhlgbS/PMaUjOfjsz8QqN/P2ncw6eY8f3+bPFBfEIqWi+8qng5YPEJnDF5E1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj6dtRw62IDqjjs182ql3RLclzKB9QoWSK024bnRE4A=;
 b=SBNYMDf9W/Uv6ntqgG9EIEZkm26grAKLsDFEO+h1cZ+N8hnT09vAGmScXZP/SMY/oGTte0D4xdWvGH/tNYTyPiFDdt4r8Rq/JHzdBuACJccAjpxp4UZLQGdxonx+KNSLno+OWyBYV365Rh47IOVJkt5s5wGgHl41WsqsbI882J0iH+CltanFXFpI2mwe+F0lMJGHZbRQKSnAApIKZUmMQBcfhd6iMMMCalbQ3Qd6Nkk6V32+OJcIpc3+ir8YqzBLp/5X/ePaNMFF4mnD+UOgsQ8Pf2+FvMVlNuxXKDnp8f/1vjzReHUIaP3Vf660KAnhB4dUcqkLnZYGqOTYnSwFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj6dtRw62IDqjjs182ql3RLclzKB9QoWSK024bnRE4A=;
 b=stjMawpvmWeJezge20RJn6fK5NN+0WoyAfxI21qNnCTBB5cmVDvUmQ2VBaCkr+F0HZJ3YLkXMdnFmYAnDkEKD4LPwh278ndsZC4mNU/0xCBg6RUT4FUH0n+Nj8QufFcIXRaSnmAKswxOZCbtuDjqgfC+I8/lGH8VQj9y9kXBCwE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB0174.namprd12.prod.outlook.com (2603:10b6:301:55::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Mon, 7 Dec
 2020 03:45:47 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 03:45:47 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add judgement for suspend/resume sequence
Date: Mon,  7 Dec 2020 11:45:17 +0800
Message-Id: <20201207034517.2074717-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR03CA0062.apcprd03.prod.outlook.com (2603:1096:202:17::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Mon, 7 Dec 2020 03:45:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e9bacdb-ff79-43a2-47f2-08d89a62956d
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB017466368823BB6F41E5FD12EFCE0@MWHPR1201MB0174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cR2nkdsyjQ2Umi4B2oYkYoroNHOCzr2CSZg47nhcTd+VislA9WpM0j/j0FVDrlNmYuj/lf7hE1c3b5JCtEC7x70MPck/8u2rxkBk5hdsHM7mSx6iHbW9FtV2q3AEOKsBg5/ASTdbYoboGoU+fSLZ/Q3ke7L4ZTmwc7eLJQ9675t2IfSIY3buKYD+SOvgEKTeCKpRdu+nh3T8RwWQdCFPpk0X4t1lXhBCRxMr9dQa7kwa8fPQb6yz/ITRXDuBkT7+MI6RtKwgbyDEgQxLNW4OwTHSWhgljT1++L54VtCfcekVNeVGKIaHmacFmDwLSeBUI4a8MZ3HUuAV2YYzAo+ZYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(86362001)(478600001)(26005)(16526019)(5660300002)(54906003)(66476007)(44832011)(15650500001)(186003)(36756003)(66556008)(6666004)(4326008)(2616005)(2906002)(7696005)(52116002)(8936002)(1076003)(6916009)(316002)(6486002)(83380400001)(8676002)(66946007)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MyTxOCfyrqLO5B/qRY02uIRzRBvEQG7bYfpbMS3kPd9+H9p2hTIHLbGRGFgY?=
 =?us-ascii?Q?sS+/O+YiyiPNUBW+OFKcta0iE8uiy0hNEbhkVS3V1bZq4XdLoEFB0vpRX1II?=
 =?us-ascii?Q?JYuYQCJWUXwsUH5wNlSCB9ml20NssXVpJIE5sYEpcI8PM7+i6qL+VvL4VIgp?=
 =?us-ascii?Q?p38nmX71F5t6iHFFvJroLnemih1IDEbnVLnjTUzu4IjIqF/A9K1K7aBGH85h?=
 =?us-ascii?Q?76w0YZKx22ztkWtwil7bZ2avrbMQGFFw/uAKhOZw+RppXqRoY0Asbu3jKDp+?=
 =?us-ascii?Q?QC+FeCQRslU301QebIMxInoNwtedyNHy9LjOZ+oUAx3DPeN1HImfX/cBV46b?=
 =?us-ascii?Q?MrpYexpFKO8cE7tACYcdJ5DKsCGmXkUfnLkuFWJi1/WdD400RExV9rTY8Wog?=
 =?us-ascii?Q?kl+f2ue+KMz8e96ekGBVaBzYIW2Yo9CmYseOIPg1yzRPGzFXLsGyI37uARq5?=
 =?us-ascii?Q?eV45PpNC9fncY4l2gWzAXyGlyjuKfXur/wYD4DbwlgIlzFJAXvcbizdlsegs?=
 =?us-ascii?Q?uOJaEzVRD/Qxh1keho2qjXo+iNWO4uxb/Rf8pJ/Sji7y8ozX3zFuS5Aze6qb?=
 =?us-ascii?Q?1vSUVSGEjoiI0t88k65SCW3dwuRukFUnWg0pbbgCDOdIkKe1CZvu7xlcHUdN?=
 =?us-ascii?Q?RDpsiYFurTNrEzCHfT8a33qkN+GnKm7dssGkVmZ6rHZg1G0OIlMM0PSbExDC?=
 =?us-ascii?Q?vw35gVsINEhpslNaebbKf9neB737yHeopXIOOAHcVgXZ7wwR+phqntd7uzuO?=
 =?us-ascii?Q?bFJ04sNq2usR4EOHjIWdEzVogzH4f7mvtKvTB4De6gF5Y7OYjFiaq5og1zMV?=
 =?us-ascii?Q?1HK5fmxh7OT/JAS14Njo1GqDu1k9+ikA/1ndOXT3205QpMqkm/cBO+7PrhTW?=
 =?us-ascii?Q?+xsssUQ9Luw8RGQbyMmtk+IjCjcbh4qT5Jve5ZfPSWZ3DH+oDShVDfkoRiKt?=
 =?us-ascii?Q?C9Fj7wWbRWAyA9nG5hYgf3q7/IQpt9HMNl/yvoY0rV2iOoqITkXbTlCgzDx7?=
 =?us-ascii?Q?lso5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 03:45:47.6345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9bacdb-ff79-43a2-47f2-08d89a62956d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoWwpzvNQ47R3vGWOSEgR7pOEx+Xj/Q8DRtC+2h96ev2vq9XM8K/T3giHacBY0pL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0174
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
Cc: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Only APU should deal with the situation that amdgpu suspend/resume with
s0i3 support to skip RLC/CP/GFX disable during suspend.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Icca91b3497f12a6d78f005ee63461cf0e8f24958
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 79dd85f71fab..75f40a8c59f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2650,7 +2650,8 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev)) {
+	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev) ||
+	    !(adev->flags & AMD_IS_APU)) {
 		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 	}
@@ -3710,7 +3711,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev))
+	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev) ||
+	    !(adev->flags & AMD_IS_APU))
 		r = amdgpu_device_ip_suspend_phase2(adev);
 	else
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
@@ -3744,7 +3746,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
-	if (amdgpu_acpi_is_s0ix_supported())
+	if (amdgpu_acpi_is_s0ix_supported() && (adev->flags & AMD_IS_APU))
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
 
 	/* post card */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
