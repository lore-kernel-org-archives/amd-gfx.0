Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2FCC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 06:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765A5206E2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 06:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R54UQFmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765A5206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE8A6EAEA;
	Fri,  3 Apr 2020 06:04:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4FC46EAEA
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 06:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYuRVQgqYoVzHpyOxUD/00uhGvX1gIKrINtZj9j2YCLGK0tDHkmT+x6NFXJXktq0Oeb1EKy3hy7qFpjJ6PNGQFDJn3jPdnMy0lHW/yx2pHUftPJpJM2oDMIgPWK6m0JUWAL1hEZ0jOg7mUm36WbyRtn3F/+NHMQY55xqZdJOSjDrZ1iZmuBksRPA69vq8o/Fpw94QcwUwTe2BdebeCEYWg4JXoNUuRBaIVFgjX7zwhX/p54H2R1ryiEGxSVpke1MoJM0WAFaKk2h51Bh7GzZZKrqnFcAEaMnbD9JxbEuQ6SHJ3B7x8I+DEfFdT3A7ZCKRjLHNnX+8dqitMhlYdIJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj5rk2TsEjc+pYl6JCqO5ANG+Zzc41PB9iLt6oOy2yg=;
 b=j7qkHYq+2VR0Qgtub9PaS+ne1biP3rpM1z3DxLXGljl1LIjrohzoVbn7WwQ+W1nFat7vXQuHl3ec5ErYwBCF2S3ZenB6TWdsvoAUzRzLsw694lTU2eeS+oaiA8ehZQOL7MfcC/dFT4rkWJeS1hT3ZYw05XK4T1tRyGLV50Yv4U7bD633rIdoTPq34a4FeIydI7/eIzMPZjdq3YOFF9IHXx8pPw6gepGpDIlOvicfxjneRrCZUhuwdjPWh/mF1iHbsQ8weJ+tLtge2PJmhUl3XZnDt/Xeste3S79mfH2nn+0PXK54yLokfzuusyynqG6gWTaSVXX9u1OjhxQvm6oUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj5rk2TsEjc+pYl6JCqO5ANG+Zzc41PB9iLt6oOy2yg=;
 b=R54UQFmoZvEF3nbN5HqcedSlbiX5JkngAT9gF/Jrj1VMuHqhSlsfH2oZFiSr913pV8/I7PZsSGZCov+xJibG5FfNBbvi9Xf/duYCBsvBAu8AMqqcCWwCONvYr/bkeEHgGzI3NltCaET86VUPmwX/R7z6KjIDHfJdOi/PnpflDtE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
Received: from MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Fri, 3 Apr
 2020 06:04:13 +0000
Received: from MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b]) by MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b%4]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 06:04:13 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: implement the is_dpm_running()
Date: Fri,  3 Apr 2020 14:03:32 +0800
Message-Id: <1585893812-25475-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To MN2PR12MB3536.namprd12.prod.outlook.com
 (2603:10b6:208:104::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK0PR03CA0115.apcprd03.prod.outlook.com (2603:1096:203:b0::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 06:04:11 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25acb1c0-442f-4720-315d-08d7d794d599
X-MS-TrafficTypeDiagnostic: MN2PR12MB4375:|MN2PR12MB4375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43757CA93C71CE0E0126ADC1FBC70@MN2PR12MB4375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(6486002)(81166006)(5660300002)(4326008)(26005)(186003)(6666004)(16526019)(81156014)(8676002)(2616005)(8936002)(36756003)(956004)(478600001)(66946007)(6916009)(7696005)(66476007)(66556008)(86362001)(316002)(52116002)(2906002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/1NraA7JUVeQw/qKbBiomK3B/TEs3/UxLOmEA/VJW3ihL6AI3Qp1CcWWzrkI/meMeraWLeP0IDd09iUzWP2NjwZu2vXqZJZtW22XdpSaAixKAD1RSDXy+qYdz8+XVE5Qv5E13hvZPFE9qaExRe1qgewt9AiBRHhotqaTDSJkLq0Jb7Wt8Pgl21LGA+yx0YNfD/8sXYcVYkA/v2Cbx0h7Q4fvVybJaAPG3v63FLvJsI9EZ/eF1UdvENojKcUSSQhzu51P0Ldcz8Vdbd0CaCN/9KQC04MJ43CWqF/kquMP9zR30lcq7wfO25GWhuiuxSxnOftTwoTP/ODKTVY5QNqZhXN3XoVNZ8OgxNhZpBeGxnG+GsAlEgWbHvd56vxk165Rn5YSfhKm1NgRuRGiF0QMKeMNQ2piSJw7+rl7o5xbcVefmap8xC3u04KbZAD4nEp
X-MS-Exchange-AntiSpam-MessageData: 4JSRejPQK70vncdaELKB6d1kFch3HOnKlEDEL4xMXEnrdjxuM3+jYEiz71QfbHwlceW8Hghm38o8HUj0/fLZfS0d9g/hWY3Qzvu/NjtXO9JrbBnCZvpJkX2cJFPuCJOuNYMP3gGxchdCzQYQ0lMCHA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25acb1c0-442f-4720-315d-08d7d794d599
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 06:04:13.6541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sd47gaxA1j3yEWfD2ffh0lR2CwRx5gZ04YBQ2JXegtF4shvGq71xKesVu2axVjcw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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
Cc: Prike Liang <Prike.Liang@amd.com>, evan.quan@amd.com, ray.huang@amd.com,
 aaron.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the pmfw hasn't exported the interface of SMU feature
mask to APU SKU so just force on all the features to driver
inquired interface at early initial stage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index c6b39a7..ff73a73 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -893,6 +893,17 @@ static int renoir_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static bool renoir_is_dpm_running(struct smu_context *smu)
+{
+	/*
+	 * Util now, the pmfw hasn't exported the interface of SMU
+	 * feature mask to APU SKU so just force on all the feature
+	 * at early initial stage.
+	 */
+	return true;
+
+}
+
 static const struct pptable_funcs renoir_ppt_funcs = {
 	.get_smu_msg_index = renoir_get_smu_msg_index,
 	.get_smu_clk_index = renoir_get_smu_clk_index,
@@ -933,6 +944,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.mode2_reset = smu_v12_0_mode2_reset,
 	.set_soft_freq_limited_range = smu_v12_0_set_soft_freq_limited_range,
 	.set_driver_table_location = smu_v12_0_set_driver_table_location,
+	.is_dpm_running = renoir_is_dpm_running,
 };
 
 void renoir_set_ppt_funcs(struct smu_context *smu)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
