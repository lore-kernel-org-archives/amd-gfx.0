Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27636C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 03:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF29204EA
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 03:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hdu3J+Db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF29204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B6D89FAD;
	Mon, 27 Jul 2020 03:04:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB2289FAD
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 03:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPIslRTElzaPN89qIoU0sbCyZAyQ9LQOCZcC/S8bWZo1Km7B1NQHDi5DFMfltpUlZzDJfAitB518tLv3fgTzQ2LNpftar6EHMn/rQwLyEf9/+hwU/fJ/CEEYDirr3WfawuFdBm9Ae58h4qmBLngjGExp9EcI7VR5G4RKi5bLIQgLdvM6ILV6D3R/O+dyqyGvG0ALF2b/iP1Xk9PxzXzFyOeW9qFhLLElTekAWZHQ/gnJj0IP/AZ3kuRQFpDrWBLiDpGh5lV52ywCvbyygo+fku7dAu1ScJ7DU50/I96LMtG2leqYx8emCK6VvmgOILGQYTQ2jsrKBiiSC0gmgoYq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ7V4xTND58A/LFGmVNaP5rHtv8x0QtN2C01Sy8DqQI=;
 b=HOxqXUCTqP0OqLWdYnzBWLpcokfIBRLutjUgNM3xx+OTl8EHXLBIGh5SpsOa5iPTYdTnv0ASYsFBAOsGj4CG00cuapeLvtSJnTKkhmu7ozO7+sl0RoLEaSZjcK2CSb5O5iIN/v23L3xK4o57ByOENhImYyKTnHr3CqJIHCrQVFw5F7sJvJ7/7kUaT0XRr8uPuFq1VHMxOVXy2VrMwLTNi9NDmqWif92+SICVdNTFnwfpf/Ekp1SrUVYORoLulWhU2j8cYHUC5cMP8fk3Ql2hwrJFL1EXgVmBcRItZH7mtQqYA3bma5vcHTmRBrIusKH96eb57V1R9awWa8q/j2ufcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ7V4xTND58A/LFGmVNaP5rHtv8x0QtN2C01Sy8DqQI=;
 b=hdu3J+Dbmsb2m7nAQeG5mXiYz/JnstV1Jd/Kp02sTAT9ET4ApN102aueDt3cPN2bxxyIIx5EW+Ixtz5t+JtokFk0H+ULSy87nDjh5XlhxFeK61EPRLNXDQ/HenAhViAuuf35jL/+tS0NoPCaD2BTBIG9Vp7OAnDCz+aCbJwu3eY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 03:04:27 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 03:04:27 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/swsmu: correct smu lock type on smu_read_sensor()
Date: Mon, 27 Jul 2020 11:05:28 +0800
Message-Id: <20200727030528.586004-2-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727030528.586004-1-kevin1.wang@amd.com>
References: <20200727030528.586004-1-kevin1.wang@amd.com>
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-pc.amd.com (58.247.170.242) by
 HKAPR04CA0003.apcprd04.prod.outlook.com (2603:1096:203:d0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Mon, 27 Jul 2020 03:04:26 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4481257a-1c26-4aae-5653-08d831d9c602
X-MS-TrafficTypeDiagnostic: MN2PR12MB3598:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3598523E8B34EAADEB342A38A2720@MN2PR12MB3598.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWvvyxcuz56r0OSHa9EbS/5BaoNfRzbz2VjuQB6LvKLyDEsJ2MOlF+GSEX8/Cme4mgJIAZ+0DRLK+c/ZnljnLuj4KS826p/945SH5WPH8s4Z54OxTioaw3cK3HYckV8OGns5LM1lkg431TO51laZFDsAonardvMVKpsDB7Yy9Cwr8dq8IHpp5dYTwMwB9DIlFnu97Tgh1IV1kJwtPi+4tu7+IboCmuPCERgP2PapW+wymSHWhMZKgODMTEb2GFaIojh8aTT5BcIkM02akekpoA0Lz9DVxhjvgf9qvza3NVJagP9WFczcXbqOnSVggReF0TDl/OOlIbT3v+RBZxYhI9Weimc01dSQSQJSQOjtrfuAd4EiybgkttYiaHOaHfwM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(5660300002)(66476007)(83380400001)(4326008)(66556008)(1076003)(16526019)(186003)(6486002)(26005)(66946007)(478600001)(52116002)(2906002)(8676002)(2616005)(86362001)(316002)(6916009)(36756003)(8936002)(7696005)(956004)(16060500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KkTOh9FEOH9RKpFief6M4bBCeRFVaKSnF5NSxO1PltdP85zNiGqNaIeKW3rRYtlR7sn0ciW3mt5XWFG+2odYqmKxtPIpztOx+5uUMWFQ4CvCHOguZ4nUsy9ulG7qMrVo9t2dPi1fZwzhMikVTo0b2N8Xv5VIoJiZPlafcT7rgyc2NYJkNbpmWX5SyGljGm9DgmMzTTJHlbawGnB9o3+UlQqldkwpKCYJ9R3weP0v7PVfV0d4/YW5Fnpcs6QtE10vhWSZFvdJlJ3bx/f0n5WCHZ6N7QJxTTM/HOPMvZqe/SHXHOgN/+t2JxCwvQ+5raeUQnkW1glexlT9FBJoeLpYX8CNNpoFOsh1QcloapMM+l+YYovMAR4NK1FIHHHXMim6qAGU9fAYFHifHNmOiPwzMGhHV4/qL/78Yeuo6jP61qs1eubNO7+yISDik/ReW0ZQGGpQp961EPVyU6qEPTAsNLRjOM4eSDCkxgfFxSQtrvr4/yiUzvAvd7XrDr2jCh+f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4481257a-1c26-4aae-5653-08d831d9c602
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 03:04:27.6309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqmtO3+aH3vv47lJgHT1eAh0etWmY/LJRtnUhPoD79kbrZQt9cMKDgfVO335RsSW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3598
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
Cc: Kevin Wang <kevin1.wang@amd.com>, kenneth.feng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

instead "mutex" with "sensor_lock" on smu_read_sensor().

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 4 ++--
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 2 --
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 2 --
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         | 2 --
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 2 --
 5 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 55463e7a11e2..69d7f7de9adf 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1946,7 +1946,7 @@ int smu_read_sensor(struct smu_context *smu,
 	if (!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
+	mutex_lock(&smu->sensor_lock);
 
 	if (smu->ppt_funcs->read_sensor)
 		if (!smu->ppt_funcs->read_sensor(smu, sensor, data, size))
@@ -1988,7 +1988,7 @@ int smu_read_sensor(struct smu_context *smu,
 	}
 
 unlock:
-	mutex_unlock(&smu->mutex);
+	mutex_unlock(&smu->sensor_lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index f13979687b9e..5e56509a8f54 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1066,7 +1066,6 @@ static int arcturus_read_sensor(struct smu_context *smu,
 	if (!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 		*(uint32_t *)data = pptable->FanMaximumRpm;
@@ -1109,7 +1108,6 @@ static int arcturus_read_sensor(struct smu_context *smu,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-	mutex_unlock(&smu->sensor_lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 6aaf483858a0..ece0f2a37704 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1710,7 +1710,6 @@ static int navi10_read_sensor(struct smu_context *smu,
 	if(!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 		*(uint32_t *)data = pptable->FanMaximumRpm;
@@ -1749,7 +1748,6 @@ static int navi10_read_sensor(struct smu_context *smu,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-	mutex_unlock(&smu->sensor_lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 575ae4be98a2..3f4de2c30bfc 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -950,7 +950,6 @@ static int renoir_read_sensor(struct smu_context *smu,
 	if (!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
 		ret = renoir_get_current_activity_percent(smu, sensor, (uint32_t *)data);
@@ -974,7 +973,6 @@ static int renoir_read_sensor(struct smu_context *smu,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-	mutex_unlock(&smu->sensor_lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index dcc5d25a7894..d4e52866e04f 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1521,7 +1521,6 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 	if(!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 		*(uint32_t *)data = pptable->FanMaximumRpm;
@@ -1560,7 +1559,6 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-	mutex_unlock(&smu->sensor_lock);
 
 	return ret;
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
