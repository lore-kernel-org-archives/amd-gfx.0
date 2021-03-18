Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB813C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661D664EB9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661D664EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379FD6E886;
	Thu, 18 Mar 2021 04:33:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 446E66E87D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WARJv9dcg1X0B2Vnd10XEAvBEEMmGtbHIhvslV2+5btZ7yG1VdGELuVH9+i1Rkf+an75U/Bfb/Ji4t+sjIha3nh4S/BGQ1SqdoYCbRWuh6LGisOLdz1CTYmpHAbyOQNz0QIMs2o9McAuaZiu0OC2zKtkYByVkY5KKTsf8ciWqgDePevb1EJSGMjARZaLCH7v5++4+gHdtLlqgle5S5srvjJq/3R1w+c1uTlvnfIx/DeDuTMzFexBz1WnpbC5EfMQy1fpx5wwjJPU0x5gkA3yefgMghB73WmhpKpfhPDR5/FrFjc7iUUW1GCtrBYqLM8yOiJb/RTEqB8g5tDAi//RJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wefLTmaCXbjkZCQoxsQ+TAYclsFy8uzj1sxw1fryTQ0=;
 b=G8CyJzDbSZb7+Dgn/HmIMuAhPQitF8fCfjUIBynL60JAoqLxUXNm+4TdamDSrwfdtOWwOna9fxmYbSjMAuVYNJX/DBKyxuk+mtclZyNg1Msxic5dt/Ngvjkkibr6tLWdfPfaNeTmnkmAbZN3TMB3bAUnOaW1djWAyKO/yz/PB/6Tq6Lwh6AQwQg6rmYF9cICSKxfth2g52OXE3dpOxyRA4vhjwRsGSBQ1S8hQ7Mlv9XJRKpNAGaefh2XGQtE0d5pm3QNCH9ixgWatW+dZHTls7Ys7ph4jXIte6JrGHI1BmjKRlFyoUoUJ65whfNJzkKA+V68yi1kgfxT8IKbJkNYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wefLTmaCXbjkZCQoxsQ+TAYclsFy8uzj1sxw1fryTQ0=;
 b=hQ9xHIGC+9YthpjYSWz5Cn44R1csgztv3/xtVT/bL2zIi6yGrLTRMSJL6GTP0Nmof8hny0iw2lS221p0Ziu/qACXaV6t/8kthkI8HtdXhED+eofQARvxlRmtKrB35vRwvvXSUh6wIN81SQUbYvoOM4hAugAXEbi7igzTAuKwEQI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:42 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:42 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/13] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
 DPM_FLAG_SMART_SUSPEND flags (v2)
Date: Thu, 18 Mar 2021 00:33:12 -0400
Message-Id: <20210318043323.3989-2-alexander.deucher@amd.com>
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
 Transport; Thu, 18 Mar 2021 04:33:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d8ee923-3c41-4a7b-d195-08d8e9c702b4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB401612CB1EE1F08AFD9B1ACBF7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZeK2RBS7KhVJwFDt/qWI2apWhSdqxeLlFU618e0NST8qKK5bFDxrh26zRsbdBGShPxfrFhSw0lqGOw+T7wt8eUFN+d1S7rf9URf2ctT4AGuDmUlqUL9WiAk4QaO/3RGZxqyDZJuuFL3RU2u28Tc30nAvXagBulFxQh+0gcbDIZ0HBbvteK1kSaBw6LBExHVTx1blKAWi2+TNmTEKvn2Uow6XZkuc5v1ukspgpH+/Dpq/N193gyoxlbJfnayavAPCCWtKAEI/LSKYOpBv2zuS+iXOa49IFQzOpzd1G/Bngt8Ch0t4pawIErzPJJh8OFH9cJQRVupvQ2Q11ONj396WG/VeLfsHwXZfqh9mRhPRLfbmpzRFF/AW+Da6Fr34PB8HipRq6k8GIl2lblhXjKYdfX10qbFprNF3HfAHR0PsrgpfYt5vdB3NzzBFBGNGqDGXogARZfBPIhmbjFs9YiA08d0qk0bLfp/GFmHDmraHKp59weacPS+hMCHnYAwK0bKYhF9CouN33jUeczxgtCUqhznxcXlBAEhJijCyDKKee7T9XD3wqUdIR+vZ7FwKxvahNa8iAwfp5AcbsadYVKyF8slCik2D19yc0tKHztTuw7SIPwurRGlUsERTUBmi2ZvYKflJK0VD+zEVspxPWEMAHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(54906003)(4326008)(6506007)(6666004)(186003)(36756003)(66556008)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sHBDZMQ6J0q9TOohSF4H/e7lDpCxgKsif0ViO50jYRoHwKEB+DjM/2evNxnd?=
 =?us-ascii?Q?+ifB1XYcQkT6wKfPQyhSEPI2uEmqgTPjC2al3pkf6FsF7ngN0tKVArbPnGQB?=
 =?us-ascii?Q?qgzVNiOD2FjM2CRHppDY/PwId8Gy98IcDcGdDEwzEhLFqjdzMW7cafFtyrtP?=
 =?us-ascii?Q?0S1ZIWfk+7Z7jPNp0D789oWoWOnOubEog9IlvMCdowR1j0+CKQqZ7lpM0bBQ?=
 =?us-ascii?Q?042jj2xebrdjwLX++IaZ/T8q0HRlraMj3mh9M7ss5gwNI2wa8dEgzGjPV6Qu?=
 =?us-ascii?Q?7eo48co8k4Xc51AABiQutzqLotut7DyCWXV16EGEvu956VOrVA4v8GRkWH58?=
 =?us-ascii?Q?HvdGa6RpVhFx/vO7LJ84TCCSf7ns2GfjeTag8n3vRGote8bC9TM8zr7+p9ND?=
 =?us-ascii?Q?fohUocp9IjIobKsH/vQFnAFa7JkOpsH9Vmy8Msgt4mPDvlwGP+W9Vbv5tKhH?=
 =?us-ascii?Q?1Cj88p0hZYh9M6NAdjuN+70N1gkMrorLLa8+xLgiwUxWilMaVgZGjSIOFY+Z?=
 =?us-ascii?Q?7I0P55P9fcxaAcwT7Cg3ysramPeS6a3bz3YYpHmBXbOPTeV9wFuRnX1/HTQx?=
 =?us-ascii?Q?pG+u22qRQgeTaWCoX8VcporcU5VtBhx6lGuYGnVrCAN3GDbfgX5RmZRuTgyU?=
 =?us-ascii?Q?3P6zmGPrTKV49PWqKaQudArNMB5u1aLnTLZoshO2AYwzc5dvnypgNjM/lOMW?=
 =?us-ascii?Q?qY2yzYoiQn7znOxp2U4S7Qq4xAUHMlQdZJLgnJeYZt34harv1RN8QA4G2jqt?=
 =?us-ascii?Q?jqGSiz9Jr/IFkbKqtwe1ATMQCzKZ8VUI3cMEGVVnQECBAT118n3w5T7PE5TP?=
 =?us-ascii?Q?E8SpO5N+A9PA8aGE6xHDh9nlqgriIlpExMdc5Xa1Zbs0WK92UOEHMkpKZw4g?=
 =?us-ascii?Q?OjEqxyI8qG+rYrdgOqnwzgZZC4j7+evMnG6sH3PwiOaY/7HYxBLMcEHgwxsm?=
 =?us-ascii?Q?qJFffcFcp1KD7UOnm++Y+iUn+tL9hRQHYMjnLYIR50ysejUMzxqHbhxRZIQK?=
 =?us-ascii?Q?oezPiAqz+wWOxZXZMrljXw/jr7ECYwWQoFpvt6OlnUgU2YBgMh6FqeT1Kn0K?=
 =?us-ascii?Q?RsSqy3YtWaqd6yKBqyNNU/6xZYHHmte9u1GbQd3gOYiE5R6O2JZTldSPs/GD?=
 =?us-ascii?Q?m9MI2VU37ul/OjEvEduCzp2dcZ/WyUrd7I/hrN2ihIJ855tV1HaPxkcWPTtk?=
 =?us-ascii?Q?Ux7uHFGWgg747Argm7+Ja9j6infvkV42gkOPnOAdNQxRyxXVtTi0MXiNdVHz?=
 =?us-ascii?Q?GwA8p1EVkX9yuMK619a+iO0QSjRtu63KOKXchiSuGpYZ/Nsz9h9t2KdI/Msq?=
 =?us-ascii?Q?j94Jjlx3wtkBb4i91rvj/CeN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8ee923-3c41-4a7b-d195-08d8e9c702b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:42.8273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcBz2kCz5rB1fj5U8gn0xuicFzQ3MRrSDNHglld8Ur7ynbP8VRQCaEZfymbugqCvpSXkuNXPrCwgUnTwQboAOA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Once the device has runtime suspended, we don't need to power it
back up again for system suspend.  Likewise for resume, we don't
to power up the device again on resume only to power it back off
again via runtime pm because it's still idle.

v2: add DPM_FLAG_SMART_PREPARE as well

Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f269267a96d3..8e6ef4d8b7ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -205,6 +205,13 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		if (amdgpu_device_supports_atpx(dev) &&
 		    !amdgpu_is_atpx_hybrid())
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+		/* we want direct complete for BOCO */
+		if ((amdgpu_device_supports_atpx(dev) &&
+		    amdgpu_is_atpx_hybrid()) ||
+		    amdgpu_device_supports_boco(dev))
+			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_SMART_PREPARE |
+						DPM_FLAG_SMART_SUSPEND |
+						DPM_FLAG_MAY_SKIP_RESUME);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
 		pm_runtime_allow(dev->dev);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
