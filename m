Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894D2C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 17:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA47611BF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 17:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA47611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA8C6EAA6;
	Thu, 15 Apr 2021 17:55:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83F286EAA6
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 17:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6OJQgBF4TFqrwQz5O8Wsc8weLBokHjvV77t9nRhIPehgqVEpxQaWEs5GrHPfM2dT6dG2rFfgrqKki6WfkQazhsJRUJtla45Aki5Qba2WrZ025F5T+L2+aDpMkJ3ViQF+N/abIshhzEjIrRriWCyy7UikQkBkdirKNpPyHpqB/0VOfV90ojJa4XWlASSmjF7EMUuBO9diyWlRlFV77Wqj8hKXJEKgd3Z5AVqIqODKKl5rpX/V6KgDLonp1UKyhuXwNuQP+vMaYsrQdCVJRK5QKZDxEEeU3Y2Lp2ps72lhNforrRrCg21QquJXrZU9pfR9PBVxpfPPWsmeHtwxF09UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1YNO+bHuZXAbA0VD7Fy7RW6lQ+WaKuwi5p07sElHKA=;
 b=giBCqtKRciB99LiXYoDWLzNKK6e0ovjtDlsMPVicUlkK6wI4XRjyuwTusqegW2yPESli0t0v6yXH6Fmxt4q2p6JDtHDmoBH0yoa/xynERcR81f50zspRJFpHj9jTUJx6RJRcPJ07WRjhz+yLXE1RLUh6TKgSZmgclRpEHuRb9iRqVXVbG8/eRxYB22dZoaCeIovK3+7Y4++b+kbHd6c1SGWdgPkLYntYAvwPWR70DOtZdTFHnCla5zDyvuAAzVON1HR1q+hhc8rG9t1LRRiSZ7BYLoKi+v1B4tlGSAqcdB1Hdbl8vH6UHdj3Wn/uD/tCNWngtf5maltxO5QkOaSD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1YNO+bHuZXAbA0VD7Fy7RW6lQ+WaKuwi5p07sElHKA=;
 b=PhSX7kweEDPxBe/PkLXXzc1CrphXRy2UJZ0V03+10IrQ0QPrtPvjYlKVLTsiKDdpktRBlVdV+fX+mqGEMuYmw3Rz/hHByPl52ytU378ha1U/6yu83VXLPRD3s6SQm2Z4HRgUOxj9pGNttvhium5PC68HplOzpZ/qHAc/7E7OmQU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Thu, 15 Apr
 2021 17:55:52 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1855:9722:849:a7e0]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1855:9722:849:a7e0%7]) with mapi id 15.20.4020.022; Thu, 15 Apr 2021
 17:55:52 +0000
From: Shashank Sharma <shashank.sharma@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/dm: Fix NULL pointer crash during DP MST hotplug
Date: Thu, 15 Apr 2021 23:25:24 +0530
Message-Id: <20210415175524.63137-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: PN2PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::33) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shashanks-target.amd.com (165.204.158.249) by
 PN2PR01CA0088.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:23::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 17:55:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9c43ac2-d425-4543-13d1-08d90037b549
X-MS-TrafficTypeDiagnostic: BY5PR12MB4162:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB41620BAD2962FC926BB8350EF24D9@BY5PR12MB4162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Jn1LbOhQhi9n6dZavmaH2aXiDGL49HpJ+zaPqB3D42++1nh7TAHI3kIJwaRMkd7vhm5FHqoFPObMC7oQIQkE3lgbklNh9z0F3CgzU28xlMPDWRs8A8FOueaNM4uLP9siRiovUo5os7Jy/LQ5/Akp2s/JsD9XCZzQ1/HVqcmsVQqss0XM4N1W9yCuB1nC6U//SYjaJGCpj6/v/0F9OAmCR2KRrrTJwQz1Fs7JPu5+uBQJkUWmOnaEV5PzE0Omm9BMvkyQQY7O48POKrmSNXGlO7sL8hEFUw6eTrNPgrBXjp2NvXp6pG32FQ/gzGI2PIHaIuqEotbZUHHL6LP1Qvqzsc7TD992gE7JsR3M55RtNar6mVhkG+HWR4YNqlzey3NgjbIabiw+4Xq1VtEF5tqEgkQBwX+FUHCkGTye7ERIeWdX3ar1WM5URHcq419PziP8f9VaoIQXvnUDl/TF6AGSMBm7pHGMYkcs+ZtE1WVgIo5U7YanLWmCM5UeZB9ltVVZr+mig2XXXnqC9VjcI5vx4WCSPRzQTkzjsoFuGvBPN6B42OlqxXhr1ocY9l+DoYGeWSgy+RVU/8fK3iDxygRzPK9xHzz45kmfYRb2nBR5/hraXpYc4RgXTawTlh1u7Rt5AM6v+5Nov6oW6MVwh3Ihw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(5660300002)(2906002)(26005)(6486002)(6666004)(8676002)(316002)(478600001)(6916009)(186003)(1076003)(38100700002)(38350700002)(54906003)(66556008)(66946007)(16526019)(66476007)(44832011)(956004)(36756003)(2616005)(4326008)(8936002)(7696005)(52116002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MES+Ov2R8V0cA+ih8iV8iXXFgtkX8GbwNT5xrYm0Xh8/eagy/hqG2CgebMdS?=
 =?us-ascii?Q?tUITLlF7+dpf1WbWFNA3kqIKeRZvBXlCTQHEa+1o27MWOem0+b1m71817Tba?=
 =?us-ascii?Q?4EX6PNryt6lk6uAMKPXVzbA7wwMqt49U1yRCL1UjdYq/1x2oamrtIlwncw6i?=
 =?us-ascii?Q?j9W9VuKuoQVGmvVR5bedauEDQk9849OeZJ7hyKGIzPkI9saRMI5votCUMBDC?=
 =?us-ascii?Q?Kk6JT5Qyxw/0qFkSggLwbYKDdLBPIlKAStT8m8bCa4ZARaP2TyLRgaSAys+h?=
 =?us-ascii?Q?oD4Uyty2hXJZluhLsqpeIjnPXqaVS1dLKQu97ZLYgXBbYpZUXkDAtuQVlqEy?=
 =?us-ascii?Q?S7TzFXsGiwP1sZHHGOLTOGP75BmrTNptvN/k+PMeFOZvXhbCFP4uC8JuY+Ft?=
 =?us-ascii?Q?f5hqVVcoQ35Nx5okL47cXLY6j0CYc3X0f1L68gYHqDOhKrBt7EIR+XPiW3by?=
 =?us-ascii?Q?DEsn7yZSA3frCTtqXDAVF0S4vuAA2WiA5IDYQQBF0Rxw5Pz3Xnhy6oLM3TUi?=
 =?us-ascii?Q?uhvliJzjhnOOq40kBmTzSQSGuWESoDhKaURZLFrEoF5gQBIxclgRFRMh8G1x?=
 =?us-ascii?Q?w6gFGT+lnZVhMSthrbDQK1LhdtFaol2oH3dHrgnQRixEzFq/Qtu+nizswj8P?=
 =?us-ascii?Q?GP6mAAttICPhBVjZ6R0xXmiJZtIjhCYe8poygGukhV4XhHOM24LqRnrHiCF6?=
 =?us-ascii?Q?Pd0YHI3BD3vV9o8GaKaLO9lUZuSE85GgqxIjgloY8J2LjTrDgwQkzL6B+8dU?=
 =?us-ascii?Q?tq5sHnhWl6IQCD6mKcAT9HptP0tx5DxnloOpEpXVEfG3Pi29HBA/yP8VjD2Q?=
 =?us-ascii?Q?v+yDG69kZrvJWZWBCzAGgkqAwpepMB2VfybrBhyyxbNQ5YTSfrnahOxDCi19?=
 =?us-ascii?Q?Dj93KbYrbI6uEk8cfxZA9yEE1On4Hf3VKliAUdkqG5slgBHqhEeaQIJDDXOU?=
 =?us-ascii?Q?3cwMqCtgtfd/99/VlwocjdHzNUonp3Ly/Rqq+e5bW/2efzUFUtJi3nOdNJjp?=
 =?us-ascii?Q?LF8/wKrZOf6i2+P5IePxOSIuHNe/SpSdoFNpuirOgux+oBchhZwkaCn3Qbmz?=
 =?us-ascii?Q?qNBVOjkzbgmRy2FUmzDcgJLxHWsVG3qy5XCCd/U7a4iGytPKeMMdL+6G6lLR?=
 =?us-ascii?Q?vwqKe08ph4fdJl3VA70w04MrLqm4Yb4dDHO+khwfwyEVMZqU85dI9/4+TiBP?=
 =?us-ascii?Q?J0oivIU1IthmILGXOoAvCszcT3ElxSIBfJptFDnt+rhkMPQnfhK3h5b1ENA8?=
 =?us-ascii?Q?Hrnv3skEnJSqpRF/XLsgMG0OzUDjldGQ+nErgUFAI0Qyq+s29UCSGljeCOyN?=
 =?us-ascii?Q?XE4F6rLbDQNI7g96Nl9TlL1u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c43ac2-d425-4543-13d1-08d90037b549
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 17:55:52.0229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKWJirKj12l0kgxXuhOPEBBnkT8faErLEYtao7YvEWWsvUxWpVRW3jp+BqpjhRBSf+z0RM4VRKROE2UrxrvLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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
Cc: alexander.deucher@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch checks the return value of the function
dc_link_add_remote_sink before using it. This was causing
a crash during consecutive hotplugs of DP MST displays.

Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index eee19edeeee5..8dc5005bec0a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -226,6 +226,11 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 			(aconnector->edid->extensions + 1) * EDID_LENGTH,
 			&init_params);
 
+		if (!dc_sink) {
+			DRM_ERROR("Unable to add a remote sink\n");
+			return 0;
+		}
+
 		dc_sink->priv = aconnector;
 		/* dc_link_add_remote_sink returns a new reference */
 		aconnector->dc_sink = dc_sink;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
