Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D8C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 03:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAF565256
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 03:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAF565256
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154BA89FC3;
	Tue,  9 Mar 2021 03:52:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4109289FC3
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 03:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUvd/tp7rAjHz11l+to2gNr61RN60I8u1ZVMWjzxel8VYYwRykA+tNN2GLIfxN2aFgVGUyk83G09+KmrR/+fWL5KLgkhVkASg1uNlEHcpNlZOcXFT73wOZ8AVQxcTgF+XoXCAnhv5WeM0bZgJWzsjt/hgD0DUZ3+dzjFhLeu4QAdmWGThXHXFU8nx+qHErGQaUGnKZ7xR0QQzYf23YBl9Sv/zrV+4OGBGW/x3UdNiOCBgVpZMIEwuKTCplnAP3yodxiAV1WUw9FyaNQ+VFt767Pnn+lMRDa72r+0d2Auw/iM4RRo5zspgOqrg6PmiqF56NnlrWJ2z0citrV+G8tBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxJtth8OUfvnw/CNrpS+5bMKf6oMWlAR9yAcXduIikA=;
 b=VWIgDrBZLmvs8SOqRtsUVk+aE6igGJFk+t57pYVl+oDQuzSefF4xS4ZzwU5r6Vw/B7pt50kS2PcZF50+RJ0pggGN9nKwyvYpb5d5QacG4x0KxLgAxVSoVCFS/ERvPFABveD+hsX4LqpXAoe5akhDKIypop6r8ZlXx9V/v7DGIS8iDreM3hZ//++YqAm9t9DYMt0+fDiN87pxfIkE0VOYuo9Uc7975gaXIj0PMgytpqP4iPzZwHZr+vsCeeqtV83l63rlelL3IreAWpQ5iZLTd5VCPEmRozzttjqyvAndFt0YhpezF3JX6QCthNTeZWx7wlUFxOmd34lMbiWJKHpHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxJtth8OUfvnw/CNrpS+5bMKf6oMWlAR9yAcXduIikA=;
 b=XFfTI1TBaGSYFZo1xjnmqJ86Kjjwcary0PYHDoeDfNDLrsyT5dj8OD5RgXiY5wkrlJiM5ob24e6RexkiCJ0dGWQySlPwlPy4PDY7lxxqobWnXwfOO/IeJ8jNHDWPKTr0xdhVEcGa/AtepubpFru3g02CJ+jgQhwX5mqCXXZL/Jc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 03:52:00 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 03:52:00 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix the hibernation suspend with s0ix
Date: Tue,  9 Mar 2021 11:51:45 +0800
Message-Id: <1615261905-10482-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK0PR01CA0069.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3912.17 via Frontend
 Transport; Tue, 9 Mar 2021 03:51:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0431abdb-df71-4716-166e-08d8e2aeb188
X-MS-TrafficTypeDiagnostic: BY5PR12MB4292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB42921FC152A6A30698A655A7FB929@BY5PR12MB4292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtMvHRAsrCx0ojGJvP4fmGpR3Iq5puT1EIkf5ob3Gu1UmLPQKreUBQXxxwrhL4/FEkFLMOe/3Y1qEDmmrEJv8+4VBep37cliRf4iRwiSOZoxixjULaDQwNt0B1uOJhhM5UPHBoKdvHgCVr8Zz/6e5rwMkwn6LwbZOOX0gaufVkAIVO5Yj8r7M4aAWj/4ddED9mTYKYTz8Lx3tgn+c5AQy9UxfS++GdTcaf1U5roDeC7kx2GdhViVzjkNhZiYFKDToDn8d73Z4+MYH6x05hzlqvEECNEj/3J0HZKsPhpkAOkL09DbH4CThzPrV2hg5czLqn6b+78O8fQ0TKzCqeNN2q1U5ckhmmSzbjhbq6qGwLFGe99ryaULuDtnqR3BAipwHhZ/7mogk6bO4PJ7YM7WxfYeFiQYJfyICMYEecDAxx8e17qE93deI6lfNh68FxhvLUL3zQO+gRx8q+3SjnrxtRerM8u8nUhOLqN2YvidYdyFEkHVCwSwBwI4m+GNNiKOKe6o+csyfqI6RYYQVH8nqOhJ6u+bFp3X1gJiTqRUhkFHmCCkhowNf9qWX6GJZYSL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(478600001)(52116002)(6666004)(66946007)(15650500001)(7696005)(2906002)(83380400001)(316002)(86362001)(956004)(6486002)(2616005)(5660300002)(26005)(6916009)(186003)(8676002)(4326008)(66556008)(16526019)(36756003)(8936002)(66476007)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NTXdSQxIfQltBCsZOdetHvOrRAlu15XcIKiDrwuoZWCe1w5SeDq7EWAtS/n9?=
 =?us-ascii?Q?Ni+sh9OC1ZjcY6YPoPhqptemria+diqRxEEINQ/vrlNPmvV9fxcmHLQ1d7zY?=
 =?us-ascii?Q?D0DblLVAe8RP51GbtVZcNzhCWa9GhiHyyXSq5UijEyikWpngnuVXzaMGYE5q?=
 =?us-ascii?Q?v8oD1uNi0Ch0YaVwrC5fHR/3X7UvMQaot4hvl2E4EzCF58HkTjzrIRcZ4XzT?=
 =?us-ascii?Q?1rTSjd7ohIM03/k/UzrF5TKpSs9ugX6ccVVNhxol9xzkpGKRSc/NZVgQIwLb?=
 =?us-ascii?Q?k7p4JQXInwGw2HQOr63fswe82EGvZaEJxqbF5mp3hlYLqPIXGp6m99v+Jddj?=
 =?us-ascii?Q?Wyj24OPFcZ3IW3veTXdHiViIE4pCSyss/LfwqLvjrBCciJgxVHg9dB8xbsjV?=
 =?us-ascii?Q?+DK0qyxoyARkC6wM/Hxd5fEG7KLzAXmWz/cCauz7vYgkjsCZhrwz5OAmoiZ/?=
 =?us-ascii?Q?i7xin644+L3G2FmlgSMaOydxGDN/oawTisE0/L+duMU+QTxxt5/rp/O7G5nT?=
 =?us-ascii?Q?b8MrokEOdqU2zbW5vH+uzm12umJpyTfQnnbz/n5gt+mi8viQARin3Bw6pHpc?=
 =?us-ascii?Q?avzxDhz7/ErlVLCSquL/IyW4j3UOvqVz/tbOae8iWNGBfyJl5GzH9n6EfaSm?=
 =?us-ascii?Q?EoQJUf8U+H6C/fYv74veSzI1r2+nydaGq8IE6MnQNCStvdf/hF3DE2WzmObG?=
 =?us-ascii?Q?KEQ6XNlTYOGfYFKgUUNlhjlY0ma0pC4N2307dGIf7VmKXfZR/cRLQ/q7FZiW?=
 =?us-ascii?Q?LqA6ZKtacOONi5ClqUmi21cAkRZezwHk2hWigYEbj63F/IMbKh7tjJYa1YTL?=
 =?us-ascii?Q?4Qv5NnfQq3HUbY/+tgaRk9phCUx4SH8sZcYcnEgha4QctumKz7HMfnk4v6Eq?=
 =?us-ascii?Q?KTFJfUvVt2ANPa/BVv1hEOMYWbpLlftx7o9SHWEWCqGYTE6Ix3tlTOHZjShV?=
 =?us-ascii?Q?wRmlgR2OuZZGm6ds4TJfna6qYdJ2tg2qORdYPWdDifHGO2BuV56PcEtfSQ68?=
 =?us-ascii?Q?bc5N2MSaf8dkXoQtwPBqfC63+znVun+ExDq7r5LmM+ewHFWg0hhVtiJtmzYe?=
 =?us-ascii?Q?trpAxDpy3j4I8laUHPVMJl0BqhV8mTqZkjnDpDOMCUO29gOPWwefgTkGdEFn?=
 =?us-ascii?Q?fDBzHF6SkR1u/2223f4kYGvOL8Gya0Ieq0AqNhPpPV9NBTD4UvZpGqdicrsx?=
 =?us-ascii?Q?6Cy1CACLUgYHVfcnvlzT6sRY17+LuZQONmf9q47lhWKF5m9scgW2r4c8BOi0?=
 =?us-ascii?Q?6AcXI0SoIXDk/QNcu1MowZ7EVuG9LiHgLK1GIK+5tTT5DH5LRS6vPLL+1aLP?=
 =?us-ascii?Q?dAcTn2uGxm93ngVuEBpd0hXy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0431abdb-df71-4716-166e-08d8e2aeb188
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 03:52:00.7096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sly/W5jvamKFzqk4RH4Dp9iUKSmv2qc9k2lHH00fy1tOcQzyWJ7NBk2eu8us0njt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During system hibernation suspend still need un-gate gfx CG/PG firstly to handle HW
status check before HW resource destory.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e247c3a..7079bfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2683,7 +2683,7 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (adev->in_poweroff_reboot_com ||
+	if (adev->in_poweroff_reboot_com || adev->in_hibernate ||
 	    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev)) {
 		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
@@ -3750,7 +3750,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	if (adev->in_poweroff_reboot_com ||
+	if (adev->in_poweroff_reboot_com || adev->in_hibernate ||
 	    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
 		r = amdgpu_device_ip_suspend_phase2(adev);
 	else
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
