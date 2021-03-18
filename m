Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F44C43381
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E18C64EC4
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E18C64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312A16E885;
	Thu, 18 Mar 2021 04:33:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B01336E883
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qo4/A2qoPMMYefDfIAHYY0HiInFR8LvVJsI/ScMxHi12wqBdkyZYzNSw7e8B4d+tFDDnx+RvC9nDzExshe3de578lt47bcicR5GbXZ9S6dP9kPw82Rb8wc8gb7D8djo4JhaS3abRofll71iqUhber1JewIoGQOCDgqI7mVIhcFW4zmq1JLfSuipxFCdgdMiNxPBrN8mzw5iV1KQBOSgL5qbOboEuPQSgq81MwFg8O3Xua1ggQAq5rqAb5dTuM2yDnhU/MaEsXZd3fD4P1W/Q9LrzyuUdXDzIru/7++FJ/rIMMDbeYbiSRDloOwS9LZL2s2DsGa16PY22vm8WpnD7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4YSpjHLQNEdyzdT6lUIaaPBdTJvZ+BY9fLLJsvDhn0=;
 b=CLU91oXnYAO1s6IlOpwRZtE95sRcu7aRgH3+kwbC1IO9rr7QUt4b87KWxyA4NlhOoroJERhKpWNLVHv3/AjRHbakYQMG1x/TUeFKqRQu1Vhda4Rq5AKEg0UwYXirA0X2zihz1dR+phBmt+2VHs1U5kzDkginLrlXzUlyQ3a4DiG52ViqA154H0jdSLsANXuCiHZOj2Z0qkNp+Cih1fO6ge8xfsPgfz9mSA3xGT68UfkphO9xx9rIltR/w16rQ16+YF/PbNgoLYCIt6cxpMfWVA22nf55O2hqWhkgEl1N0WPNpP6kOPO7rjEv435TzTTldo8T6xvNQSIh0BL2Ad0k/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4YSpjHLQNEdyzdT6lUIaaPBdTJvZ+BY9fLLJsvDhn0=;
 b=juCPJrdA14kqS31milK7XExYGi1GgitT6yCH1RYTyeaUiGw0amoPOQ4i/4WRuqxJNWIY8EuncRyGzEu3SEEvWG+hCmZ3RB91tFOHJBL6JdbmXVX6iyRI1vxaxqS7eIpGoTBvELjJcUpRcyIzy2oivk3ZEdF9ftZwOb2tqj/bl/U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:49 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:49 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/13] drm/amdgpu: skip kfd suspend/resume for S0ix
Date: Thu, 18 Mar 2021 00:33:23 -0400
Message-Id: <20210318043323.3989-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318043323.3989-1-alexander.deucher@amd.com>
References: <20210318043323.3989-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 04:33:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0ff6656-e3c9-4c7d-e3f9-08d8e9c706b6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4016F1AEE9AE80299EF22C43F7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIGOd4Wlu/B/uwkftXpacE/5Sn26FfpPYY5kg0EFWS+oCdfIiedJlkF3j69VrO3aaT5RCD0t8g6+tjOYE/kTqYP/kjb/FdmzAN25L2XJaGEdVe+dc0hZF6BIhU6e4sTQ4xTKyiKNjenqenn24Hk2d8YxfphaLUab8A2NldL0weRRR5hCF5uuacub9O5rwoEwkk4OrmC0GfMOrZlGSnHF4o++MSEHBIeteGD1VIOJoTDfptrlLVy675VMm5u/ljFyhFQEk63lgz/xVQO3noXPS/YxI7FN8enFtTAnxXNCEOtqsqfazLHYWTElh+brx9+mO3DGbeBx3zKshyeH8eho2CkE6BvxCIJbGrK0F/kWMKh5KrlD1RMafwPke+XVfMuY0C7T80yNeUOo7sEJ/dwJCAumOisE21yAgWOGgbgv8qZk+Nhus/gEMJjTiY8Qbny8/pXzPv82dUnvHtQrJvqWIaag5hrKmlh96Y8pxNYdYnX7DLOBtGnnngUjKckKAU5iO3O3EahWZrB2FEmjOsGH+eh4b7SrxlCrOwgL6T4u4jc3frjryb69QEHAedP1vTe4B0JowGDAFlMVNxcj93iwR8khXAbH51+jDn5cDNziJe4OHwlY+7MZyljJWi7i4CkCBlf0pAZI6JkFk9jTC5WV6bdnkZfaGog+r5cwxJ43PkN7fBx1hAkYdlbYFpDGCueX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(4326008)(6506007)(6666004)(186003)(36756003)(66556008)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TS0Vdcqp89cez0vVZXwCGXiWmCpDa+5sJizazeSNsmxmtl8OA4MKJSPJPqcX?=
 =?us-ascii?Q?sRE8Suwvj/hekpIlEa3lkp8L/XS3A/pDn6VWiZhC+MQrd+8MnFw2HBzJZttN?=
 =?us-ascii?Q?wRWrIB3IVcLs2wjCu5t70P2x/d7XKncZfjQM/iqkSwnvmzu703I5yZodGXkF?=
 =?us-ascii?Q?j5jgI9yAxek9haSNEnUSDU8McYzWeqF+J1mXCCvgy2IBv6WqHP0+gC3R6M9y?=
 =?us-ascii?Q?xALu5VaZOs1Iavy+Cbg+JihWBeB8PZUBIJWS3hM1QsZAjLOiMKSs8QDBIWxz?=
 =?us-ascii?Q?0H8NSnQlm/L3bZoL0ogHBlmWN4x7lN/N/pco+Q7OR5P1XaU2bPfQxxvDBA9+?=
 =?us-ascii?Q?0oLkkiKinFh2k7vd5nBTJVUwQ4jzWUyd5MkbwN1oYlTX7b2iNHK7DXkIEETn?=
 =?us-ascii?Q?F5wuZwTBRpigeIsFobJZ80wMu6lY0675Y/JtpJ95DzbGiNyHzbaIiZ2dXtYt?=
 =?us-ascii?Q?E117M+Dl1rGF5g39QKWNFPPBpKszMTq2xSAvBoKWqgx8soqBM/TNnpFXXfuo?=
 =?us-ascii?Q?HzKChfTXShUruoFiNFSgF+k9V7+0NCssVor66i/PtCmh/WKvUizE29zQnQE7?=
 =?us-ascii?Q?NsEV7r+YP3qf3oQpu6U57MNwzezGFfaAmW6otRnpuXXjuGhUDlmpwZXxdJOt?=
 =?us-ascii?Q?t7J4O9KjlmCnCH3OyNKhTTPmQQGuytIXPIP1u3EuP/SFqiELKsYfeEQHvJEf?=
 =?us-ascii?Q?nooOvPa/O7q9QTqYzPxDUp2/RmHoOONtnNvQo135ML/1ERH1vOShN6/TuDT3?=
 =?us-ascii?Q?tAUhEen1FN9vGXRqIWZzbTbJeFaAZBzNJbcujfZINzl5j7mMnV/Nc1QJ+uaf?=
 =?us-ascii?Q?Tj4UsPiHwd3D8NufREZzWpnP1cHze7MuDro4TPgm6hi3A7o9WzY8AjrE0JdO?=
 =?us-ascii?Q?JOhMq17+trPOXjNYB3i2ZFTjE6smaNYTrnz7fyQULrJky/AjjiaNkECe1UL0?=
 =?us-ascii?Q?MWqpmG+x+ktEyegw24U4GfGSyO+Pl7wFBm/6YggvrLnqvxYpP9O0ykKD//QU?=
 =?us-ascii?Q?VujOyaz7CW/uwSf7moxpyDoijOMzM0CLOK+CzK3mxVpYjv8cKeUB9Pn1PBE3?=
 =?us-ascii?Q?0yVIlKbWZpbqE3TCI2LNr4/YG/eUjr84J2tITSkzQPFiHpvilBvl92Zuip3/?=
 =?us-ascii?Q?bsGGN8eDteoG42/9Rf73RPlD5ceoeu2v4A4SPes/SRw62JTXYl+etDSjp/Jq?=
 =?us-ascii?Q?Y6POzD/oBYJq5uIdwVArF2UzSglgJCkUfEuIv5VKTAVYB/7Tiptng9QBN6us?=
 =?us-ascii?Q?FAauoYNHrMCa/qGPsrVUGDPiysxnzHOxah5z5bw21bMZzAtGgZNL8wLQqM7H?=
 =?us-ascii?Q?AwdXpFJHTdHgZAV9RUDlRwIZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ff6656-e3c9-4c7d-e3f9-08d8e9c706b6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:49.5827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NPGSXNJvvDLU6zptl+Vs5AMo6aGE6RVEb2YGy8cTNx4M1y9h3x2oZdUU7HBY7BXhL5vjy7BGFBVmAx0ql3rbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX is in gfxoff mode during s0ix so we shouldn't need to
actually tear anything down and restore it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 965b4f18ddc7..319ad9326a71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3705,7 +3705,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
 
-	amdgpu_amdkfd_suspend(adev, adev->in_runpm);
+	if (!adev->in_s0ix)
+		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
 
 	/* evict vram memory */
 	amdgpu_bo_evict_vram(adev);
@@ -3765,9 +3766,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	queue_delayed_work(system_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
-	r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
-	if (r)
-		return r;
+	if (!adev->in_s0ix) {
+		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
+		if (r)
+			return r;
+	}
 
 	/* Make sure IB tests flushed */
 	flush_delayed_work(&adev->delayed_init_work);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
