Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A0FC07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 04:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA3C6135C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 04:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA3C6135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4266F6E811;
	Wed,  7 Jul 2021 04:53:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 033096E811
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 04:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXQyG30nKQFr3Rbm/vKebYA+PBcRYOSh+myXyB5yrbuoI/sy5dZ/rEh9S4t6MY8oODIX3UtJN+MUpWZAM5XgjoAQ0sNUxk+RdX3ial7LG2aRFSHz0tQM5vHDpbXyGRUClUcU6Rp2J2BaRmsC8i38wzQ3UtZWPG30YI3A/6uirFpo42nLY/mmZN04Qp5oByBNDoNedsVUZeKa6SJZmG2dXryT1MeA9dp/C+qwMKVPWFZMK3eEN3g5QjaQDFmeMb/3faqr/N5fxBJTsge32hjdxrrHARJXpyE2rDJJexfYpaCXH3FZuZU4TSvfmpXowdwYcyaoMHiDUOoT7sQlLLKCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oqyfk+ylOzmC2UrKPzqvtP7fFLHR8b3yuQxn2L9fBqs=;
 b=ba1HBnDd2pletjTzwXK3UggL8O9H8bu2SO+QeAqMot3HHZdYLsQw46YJrt3HDjHj0E+aZXgLnwDwMRKSDnKEnvbg6RrjmBY8By+6o8K95Yc+UxK2uknLLghYUyimmhH4dhKMU2LWF2cD9u1BwukKafyHfvoVGLA75O1vloVh6pVEO5TfpgJzQNREp/tuE57CRp03HDm/ZuTgh3vPnDN8MRe13Q6Vog7MggqiPZxnj9TKdxxhiNY3C/VF4/znpsh37aj/Q0rNS1iv4hLMHOMYFimhXEjl41S+vSAEp5V3RxI6doUCucymwKtIKp8R56gtlbXwKVeOiC2Ryj8DzyimtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oqyfk+ylOzmC2UrKPzqvtP7fFLHR8b3yuQxn2L9fBqs=;
 b=SyOEWIj3sPzmQehVSxg1xucLknd35jUP9yw5FzDGFVoHabmB7f6lySUy/eiNZSDL96leMiutL4u9/kD3nc89TFjg4rDWBt6AObAhs9Q7tOCgJqfrSK5N2feZay7yXDXy4fyI7XRKKlGvmbNMlTIYOuR63++NjMWj6mGAXqfAzMc=
Received: from BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8)
 by BN6PR12MB1361.namprd12.prod.outlook.com (2603:10b6:404:18::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 04:53:45 +0000
Received: from BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::e4fe:164f:3b8b:7e7d]) by BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::e4fe:164f:3b8b:7e7d%10]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 04:53:45 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
Thread-Topic: [PATCH 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
Thread-Index: AQHXctO4bYGVjG5Tv0SHJbyCZRJjV6s28SCQ
Date: Wed, 7 Jul 2021 04:53:45 +0000
Message-ID: <BN6PR12MB1283E9E30E504CBE8EE2ECDBF11A9@BN6PR12MB1283.namprd12.prod.outlook.com>
References: <20210707015647.139127-1-evan.quan@amd.com>
 <20210707015647.139127-2-evan.quan@amd.com>
In-Reply-To: <20210707015647.139127-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-07T04:53:42Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7e46a69d-575f-4bb7-88c0-5642bfb29325;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7ce079f-9132-4f9d-3f8f-08d9410333ba
x-ms-traffictypediagnostic: BN6PR12MB1361:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB136104EC3082D96EF3D6059FF11A9@BN6PR12MB1361.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7goWfqvt9FO6maZJZkWn0Sp3sxhEKi/PMBArDSPTzadiHwOtgetXuxt9xZNeJiyGYD7BvBzDsCuAlE1RfX88mGRUs0BMQ0AjnAl+vA4jDyvlxDXpLfc7wz6KB4QIPbM6sz6llwM+/PFtgtMaaZpoJq62Co5wMc074qnjohYl60h6dNScmrEUeiTwy3bnMiA9t8PK7DxBw6nW1yYjYf39JRMxLm2Zd1dTxZrrKqO9qNbZHQ+OH2P9h3g50vVol8s2+iX3XSOnNz4Q5Pt2sdnX5+LdrkzIelpo4mr+0hS5Rc84pi40MDf6WALXa9OCadLgKa/hdcl1ylgnvzkwalVmOQH+IsrnyOyOYUw/OUAlDJnrCyfHshX63psipXZbVL3z3lEpdqPRD8vu02XgkmIAVJa/U029UIHbGOJXkoIxmdysiS1Wrw1WRbtSKKD2tHLZQvZ9WFMlyfErQSHkwqYF1xnlIKCSfDFreuR/clWymq28QuCVNQsEyAIXfHK0WAdNXhadptvHHOsaS2WoNy9Lc1YAIWmSvSgqI4YmZxniRJnezWwr6yPT6TOqtAS0/RocMR6Fyuf2YquUv2P1wuCHV9xBpsfF9UMeZC316hoSM7lZjoM1eW3qaeEVnfc0X4cwO8VdW+WqNTso2ISO+fhs3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(71200400001)(966005)(9686003)(45080400002)(55016002)(8936002)(26005)(478600001)(66446008)(5660300002)(186003)(7696005)(2906002)(33656002)(52536014)(66946007)(64756008)(66556008)(76116006)(66476007)(316002)(53546011)(86362001)(83380400001)(6506007)(110136005)(54906003)(8676002)(4326008)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VhmrQz2/uB1bXn0bVBLBYEgadi+vhNHvYaZox/g3HaH+funckvlCh1t3suVt?=
 =?us-ascii?Q?258uhPvLtLI70tCuESb6Po4nh70B7wRhlnw1Aqb1Q5DQ/Cp5RYP/vOJei/qJ?=
 =?us-ascii?Q?Fvl3n0LFrQt4HRYUJrJvH1HVUvgvmhnvb/2z9ugL7NRJkr5asH02DOgCXX04?=
 =?us-ascii?Q?WAc5ReEVBuppTTdATzYsPTfIRMp6cJx0OxnItlACTFc+0bsN3iWjaFGWzzby?=
 =?us-ascii?Q?roP2aB2x41osX/Qs7PoSLxSIcTaJapah1YiOTLduDvdRJJSOO6OXKMYhNysC?=
 =?us-ascii?Q?khvnn60HbQXhgzEWTNkM31TZYCH4rDV+8cVxbLredYG95JhYtz+Gee94MeWi?=
 =?us-ascii?Q?0D5H8diIdi7IXHWN32IrBjSjvzUdmzanwFm1ZPcHoMd1zLgeGLEBgHkltOW7?=
 =?us-ascii?Q?V/L3f0JT+6awNBuCv7Z103rZJK72e3z6LMtoH5wZcbuitgz8LwbNL3ba6TgO?=
 =?us-ascii?Q?zzElhWwGY5/QeQsA5sV8JcI85c9jpe9HRi99m0OD+Q6c1l0tbW4E76n2Fzma?=
 =?us-ascii?Q?ogSLP+FuxBX1DdVZE0cKXhB+UyEXV8ht6r+2QsTZ0afUfZrUKqHGRoi9KD1n?=
 =?us-ascii?Q?/G6UY6PqAsDQ/RFCRD9i7qOhCIoMEMoL05Zn46iQV4beErFEWgDFXelccLB2?=
 =?us-ascii?Q?qMOP2SEqgCpjeit35yFFuTZrmhLsUKpMhQfSCRUUsUNh5WrhNmHAt6bf/0u8?=
 =?us-ascii?Q?V3cuMrOWZSx72y1LiQbkCSClD+DhXOUpSot/ISVvaCrC3Y7V/cRwXH2h4xRq?=
 =?us-ascii?Q?wI3Po44QSZZGrOvYWOxhsfuSY4tB2EMmAG9ooaiq71ScJ/raBKh0XRuzSx1+?=
 =?us-ascii?Q?WPFvah+29Qvt7JyIs0xuL4V3rP4pktuseAL+Ss8URiFpd4bnUOPPt+Owot8b?=
 =?us-ascii?Q?VBsBj32TIE9+sU/nHREIzW5/4QUmDaPFBJ0Qcm5XfsRVztqMH4dILuPv2pMc?=
 =?us-ascii?Q?sqNHM7nn2jMYmpHdIZiK4NJQ2tYd/ZX+8EurfefjmR0JdzD/HazlWtt0H1fU?=
 =?us-ascii?Q?eERFWTSVlzStvr9628eTWrdvkvYg5GkKboU78dzKbQ6uyMMIF7Gv6kCvLh7+?=
 =?us-ascii?Q?sqZoyvaVuQvaz+h7qofjjArfBFG/U8hnJQU7LU/7TZ3HBwx+GqWWwI6oGzS+?=
 =?us-ascii?Q?/JphbgKxkXJkc4TRZ/qiPqExqKpbqspdZrpiywjDxa65EP8JLP45pKolg718?=
 =?us-ascii?Q?SAD1kGkDh4lcPn6umH71jG9PZmZzyRXZ3kPaJ01Geonuous/AqnLWV2Kypqo?=
 =?us-ascii?Q?wX4qBGS/KDFUBPzlEpgUoNIIysxLPLa+C1BFUZyuueXxsNdB3iftP9TYYPHY?=
 =?us-ascii?Q?uKwH/Ll3JK0EoU/tC/LFCarI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ce079f-9132-4f9d-3f8f-08d9410333ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 04:53:45.7107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkoE560rGD/jtJ4J+b4+zhB0QIbcXkuHpOrJhCvXQ4tZWGuaEHsOcYS9VLDPeVB5lU+Oqveu8w+J62EDCtOn5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1361
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Two nit-picks.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Wednesday, July 7, 2021 9:57 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/7] drm/amd/pm: record the RPM and PWM based fan speed settings

As the relationship "PWM = RPM / smu->fan_max_rpm" between fan speed PWM and RPM is not true for SMU11 ASICs. So, both the RPM and PWM settings need to be saved.

Change-Id: I318c134d442273d518b805339cdf383e151b935d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  8 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 20 +++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 6301e4cb3c2a..fa585f0be530 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -226,10 +226,18 @@ enum smu_memory_pool_size
     SMU_MEMORY_POOL_SIZE_2_GB   = 0x80000000,
 };
 
+enum custom_fan_speed_mode
+{
+	SMU_CUSTOM_FAN_SPEED_RPM = 1 << 0,
+	SMU_CUSTOM_FAN_SPEED_PWM = 1 << 1,
+};
+
[Guchun]A coding style problem. Put '{' on the same line as custom_fan_speed_mode.

 struct smu_user_dpm_profile {
 	uint32_t fan_mode;
 	uint32_t power_limit;
+	uint32_t custom_fan_speed;
 	uint32_t fan_speed_percent;
+	uint32_t fan_speed_rpm;
 	uint32_t flags;
 
 	/* user clock state information */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 576e9ea68fd1..9a25443988e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -414,6 +414,12 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 			if (ret)
 				dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
 		}
+
+		if (!ret && smu->user_dpm_profile.fan_speed_rpm) {
+			ret = smu_set_fan_speed_rpm(smu, smu->user_dpm_profile.fan_speed_rpm);
+			if (ret)
+				dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
[Guchun] The error log is the same as above error case. It should help debug if we can improve it a bit to be well distinguished.

+		}
 	}
 
 	/* Disable restore flag */
@@ -2166,7 +2172,6 @@ static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)  static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)  {
 	struct smu_context *smu = handle;
-	u32 percent;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) @@ -2177,8 +2182,8 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	if (smu->ppt_funcs->set_fan_speed_rpm) {
 		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
 		if (!ret && smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE) {
-			percent = speed * 100 / smu->fan_max_rpm;
-			smu->user_dpm_profile.fan_speed_percent = percent;
+			smu->user_dpm_profile.custom_fan_speed |= SMU_CUSTOM_FAN_SPEED_RPM;
+			smu->user_dpm_profile.fan_speed_rpm = speed;
 		}
 	}
 
@@ -2539,8 +2544,11 @@ static int smu_set_fan_control_mode(struct smu_context *smu, int value)
 
 	/* reset user dpm fan speed */
 	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
-			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
+			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
 		smu->user_dpm_profile.fan_speed_percent = 0;
+		smu->user_dpm_profile.fan_speed_rpm = 0;
+		smu->user_dpm_profile.custom_fan_speed = 0;
+	}
 
 	return ret;
 }
@@ -2591,8 +2599,10 @@ static int smu_set_fan_speed_percent(void *handle, u32 speed)
 		if (speed > 100)
 			speed = 100;
 		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
-		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
+		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
+			smu->user_dpm_profile.custom_fan_speed |= SMU_CUSTOM_FAN_SPEED_PWM;
 			smu->user_dpm_profile.fan_speed_percent = speed;
+		}
 	}
 
 	mutex_unlock(&smu->mutex);
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C4a4ff7eeef7a40c12be008d940ead96d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637612199692523088%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=y%2Fk78g%2FRdJ7kEjzHHpfo7DeEUo0hfCOVOH24aTiqG4g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
