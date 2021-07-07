Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F9AC07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 04:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FED061C7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 04:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FED061C7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F5D6E054;
	Wed,  7 Jul 2021 04:47:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8346E054
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 04:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtgRLJdfyvVLxiaU9LiiJaXwX4LmvysdzYs/hnj+ZksfaeNI779ftpHNKTPBbhQFgvRHq/tLttyInq4ez7AHyBNOK5sJ0CQIMbuQhYuH16hDdEYwSzJVyDEnMl+6yZR1Zf5zzV1hczhbLdCUaRwOWYZ/gr10eI4xbb5BlxjIHMXTqHwjIkddZXwr1us1vEWu30bxK4Ci9/OUxILpzIrpolhpNarh8rj1oxz0DqW3fSW0/Y1yO7I2To2IkIuDGeYlNI+AtKGiHegp6a/6LiwwMomZT8t5rWnBQJ9CpK+ZGf7/9AiO+E0dzwGxqp5buITTmHgizBfp5df4aj9/pIFWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocAeXeb0OI3CierpE544jSnnAnTAdoxYcCyBbEgyHHc=;
 b=l34GvS+NnoDGvgyOKm2nm5Uq9XLhXZMjAbNDtgoRMmVp0N8i6Ah6IIvTA7knIqu99oIP07q0j3L46Kzncws/MKyfQpZqdNZjUkpW9nKl6nodmMOfJCyVE+3o3s6gjdhbz6V3/g3Ta0c69fN6ZYhDbIdC1+Kkha2nqlQBIlUiCVFfsHmAnHvce37JDBujq4U4NAib3CX47x7LfzI0u6FGFeBr7cnmwTIIuBDp8Mh/voNdfCzZwhZ7CPBggsN9uzGOHTHF1T/EhIglQsRWxGMmURIF9xwZyJB9H/MtMhiUpQOGR1mWTorFLnvz4bfc+2e58EWky5I/YkVJ8z0OCc9C8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocAeXeb0OI3CierpE544jSnnAnTAdoxYcCyBbEgyHHc=;
 b=ih+79b05r6RnDgtlLnWGZfyrrfqqHSNcCmCIOO8O1KD5o0qWO9zM+61T3/H1uCB3lMV81kRIMDCrBKgeLqFdTOUuVFE2sViF9eiMt/2721ZzOgRhGTo+qEX7GoLqoyBEtjFxqSV6/wx5cBCnLnhRrM1SpC1GcUHkCbAWiMKcuAk=
Received: from BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8)
 by BN8PR12MB2850.namprd12.prod.outlook.com (2603:10b6:408:95::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 04:47:43 +0000
Received: from BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::e4fe:164f:3b8b:7e7d]) by BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::e4fe:164f:3b8b:7e7d%10]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 04:47:43 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/7] drm/amd/pm: correct the fan speed RPM setting
Thread-Topic: [PATCH 1/7] drm/amd/pm: correct the fan speed RPM setting
Thread-Index: AQHXctO3SI+wfXPQDUmm1NTooRtqdqs2743A
Date: Wed, 7 Jul 2021 04:47:42 +0000
Message-ID: <BN6PR12MB1283FFC825660548C25FF23CF11A9@BN6PR12MB1283.namprd12.prod.outlook.com>
References: <20210707015647.139127-1-evan.quan@amd.com>
In-Reply-To: <20210707015647.139127-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-07T04:47:39Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=076c083f-5276-4aed-bcc5-284a72787de8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc448099-bf87-4914-5aee-08d941025b79
x-ms-traffictypediagnostic: BN8PR12MB2850:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB2850166E75A4C5C353898349F11A9@BN8PR12MB2850.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3DbPTm5IgsLQzXaQt/89rgKzO3LhSIeXTFEgou3ZhSnzti8EKziTA6ihlixxOrWSRmdVS4emkDTnFle+gtVg747I8o89aavhZV0bQnemKTvrnugrSvNfYbkblMmEVbND0J5ZnmwvBr3pF8DlxwqwIMIaES8DJeRkBx8MoOMe3qaEWrAaNYbdGTzeB6w9IVl9zywposMZ45J2/rgKO1aLPW5u1Q89VHCJ0mvxT78QDi5ywweFhpokqk4jGXHP+xz0655JfcoXaqF1ky3oJNQX+dnymIBfG7+EeXu4X8qBrqmKSIAnRV9jnWZgMsAQY6JSpW5PzNJ3WA+cWex9ksyxGQd0deCOMG2vrfkVZPSL+tQ1YteV2n5vXPEZL76QbaN8lVsREeNJjaSBOew2AdAEclWFa3MB1SG+Ahn3qDHguaqEGvnN4wVn2/9dqX0poyKQ/RoOeTKwwq/sVCRLuG4dLa3lNvvvJuhKnLiI8ZYJzb6CQTmJ31JzO9kFAPyLgHRVyuZtWqEs7mdGHcDZOtmGOPE+zwU5oBIrwrJZcrUAPlxqcQvfgmFuMW4BbIvD5dJ+bIOVsT4CUPf5MUOeTXV1upEp9V9YZxmXwwtD1kxrXZZY5dRdN4AsOPmJI9z4aHnuMmMMktuIn4eQyxnUGj0Mgg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(110136005)(9686003)(33656002)(5660300002)(52536014)(54906003)(71200400001)(966005)(83380400001)(86362001)(316002)(122000001)(55016002)(38100700002)(66446008)(66946007)(478600001)(45080400002)(66476007)(4326008)(26005)(66556008)(76116006)(186003)(64756008)(2906002)(6506007)(8936002)(8676002)(7696005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Tlx8us7224Yk3UJEDkJpmUIY/uPzImiJF9Kd2bwsCKDsYLLAQ8Gw/YNA8RT?=
 =?us-ascii?Q?7viz8p2lgrAuBoyyIl3Mfar3gSkBn9TUiesm/A2Qy+4lab1xvG1lR1P+DGna?=
 =?us-ascii?Q?soqrKiGvjquysiuRY74wKPfLcQ7vT8C4aMF2LBQjDGd7Eg/hHnycnYT49d9J?=
 =?us-ascii?Q?fPROnuJyqquVNNtN6iSPincsAtLPwpDx0Q2xgPhUJMfqsn/b++I8qISnICCZ?=
 =?us-ascii?Q?dkK0YbzLEceBO1TXln2YRwnZ8hAFDPH7ImOyZLz6dyzLvLohWeKS9MQHMuwo?=
 =?us-ascii?Q?Z29GAoL6w9o4w9OQQ96zoZ/520vQK+zyf0JNjWwmscQnitNTNygDi4n7secB?=
 =?us-ascii?Q?akayyHkYJTQMM/rLYQCq7t89L1H1a6YQscYu94zQDgRU5fFMbZpCQi7EuuA5?=
 =?us-ascii?Q?2qPSgJ/CdbjqExidUageYyuJSynzI4wQuSmRtDwUxJuSPGxJ8tVkTS6ADSty?=
 =?us-ascii?Q?5nBmwaI7JXVtR9o5zT8FgxHOQIY77fs6zRHF55xn9U46WYjnCVXvu+1FOBU7?=
 =?us-ascii?Q?DstxSCxpPnSXBEGrxVZTQ+8AOnRcB6HKECVGQLW3DJAzW6MI28hXrRb68eXg?=
 =?us-ascii?Q?Nl3v9aYVvZFTewiLVrpSYupD960icbF9HPQ6sV2RMgoqOS1RzUpjRxZ5ZHv/?=
 =?us-ascii?Q?JsM4vPgBdf47paqMoagLv7G9B3bfeed1hxHHh+iuqsGJfYJ/1nFeqLo2wAAa?=
 =?us-ascii?Q?k0oiyYuaA3fs/tFO30jk8eEIA8tx4h48gawjQpbmWfGjr/Gm1ToUqgM1v/5R?=
 =?us-ascii?Q?3PyRUrAY1BQXPDarg/lqsPwB0gBlpr3zvn5yRFUab0OYvhdyA3v1UuPoK3KS?=
 =?us-ascii?Q?J/U6WH3j7CdwvhbrrRCTQNrdfoG2eVmzKoClkNshuWOaD9bHgXMcG9vWgMRG?=
 =?us-ascii?Q?RbqZaplhjmMIp87tW61eedI2S3DH6OOt8dAc4eOK4m5Ph8c7uIVW3ifcQHV1?=
 =?us-ascii?Q?tuR1S5C/nmHDsAds0aOmIe8Yqrp2WUCtBl2TTk6Bb7ShD1S47tdjg6EdZi/2?=
 =?us-ascii?Q?V7baiFdHNQATYSpt1bviXfEdvdcL9WvFAIX2UeR3Zv/8s1GMq86mPQb93dXD?=
 =?us-ascii?Q?bGBHG+9u9mw+u8cQOSHLXigbHva2tv8hcnaJn60Jaxi4IBGUvJIAnIcy0gzG?=
 =?us-ascii?Q?oSV3LQoFpFFX1ig/FbNlSfcH1MSHm6OAR63BU1khtVydlJJL7tQPG4MXxFCV?=
 =?us-ascii?Q?Cogav6OiNNXYFE6BeECmISUakMYDxXUUFcRif8Ep4e2EiGSJSjh0/gU9I7Vs?=
 =?us-ascii?Q?waLmJIqeQAlbdWaeumPZq4xJ2w+sEKlt464VB72w9QFMYfcELeSbEGlS80K3?=
 =?us-ascii?Q?F45QQquRO6SMheH5pZzR4/nL?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc448099-bf87-4914-5aee-08d941025b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 04:47:42.9006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tP/u6ZsRPm/uBLp9q8NfQD/3M0NxCf+JhlxKsL5AsVCn+KxOx50y1eA5GxMkTrYvcgYEC73ELZjLOwaIYC6+gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2850
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

tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);

Any multiplication's overflow possibility?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Wednesday, July 7, 2021 9:57 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/7] drm/amd/pm: correct the fan speed RPM setting

The relationship "PWM = RPM / smu->fan_max_rpm" between fan speed PWM and RPM is not true for SMU11 ASICs. So, we need a new way to perform the fan speed RPM setting.

Change-Id: I1afe8102f02ead9a8a07c7105f689ac60a85b0d8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 +++
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 36 +++++++++++++++++++
 7 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 3e89852e4820..6301e4cb3c2a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1039,6 +1039,11 @@ struct pptable_funcs {
 	 */
 	int (*set_fan_speed_percent)(struct smu_context *smu, uint32_t speed);
 
+	/**
+	 * @set_fan_speed_rpm: Set a static fan speed in rpm.
+	 */
+	int (*set_fan_speed_rpm)(struct smu_context *smu, uint32_t speed);
+
 	/**
 	 * @set_xgmi_pstate: Set inter-chip global memory interconnect pstate.
 	 * &pstate: Pstate to set. D0 if Nonzero, D3 otherwise.
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index b89e7dca8906..134a33e3de91 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -223,6 +223,9 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,  int smu_v11_0_set_fan_speed_percent(struct smu_context *smu,
 				    uint32_t speed);
 
+int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
+				uint32_t speed);
+
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ebe672142808..576e9ea68fd1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2174,11 +2174,12 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_fan_speed_percent) {
-		percent = speed * 100 / smu->fan_max_rpm;
-		ret = smu->ppt_funcs->set_fan_speed_percent(smu, percent);
-		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
+	if (smu->ppt_funcs->set_fan_speed_rpm) {
+		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
+		if (!ret && smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE) {
+			percent = speed * 100 / smu->fan_max_rpm;
 			smu->user_dpm_profile.fan_speed_percent = percent;
+		}
 	}
 
 	mutex_unlock(&smu->mutex);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 6b3e0ea10163..047adf6dd444 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2314,6 +2314,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
 	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
+	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler, diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 59ea59acfb00..d8a011483dcf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3248,6 +3248,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
 	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
+	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler, diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 83d8e53ca1f8..dad120294c19 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3886,6 +3886,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
 	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
+	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler, diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 388c5cb5c647..fefc8e93fdc6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1213,6 +1213,42 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC);  }
 
+int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
+				uint32_t speed)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t tach_period, crystal_clock_freq;
+	int ret;
+
+	ret = smu_v11_0_auto_fan_control(smu, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * crystal_clock_freq div by 4 is required since the fan control
+	 * module refers to 25MHz
+	 */
+	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
+
+	/*
+	 * To prevent from possible overheat, some ASICs may have requirement
+	 * for minimum fan speed:
+	 * - For some NV10 SKU, the fan speed cannot be set lower than
+	 *   700 RPM.
+	 * - For some Sienna Cichlid SKU, the fan speed cannot be set
+	 *   lower than 500 RPM.
+	 */
+	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
+	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
+		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
+				   CG_TACH_CTRL, TARGET_PERIOD,
+				   tach_period));
+
+	ret = smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
+
+	return ret;
+}
+
 int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 			       uint32_t mode)
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C645297d9dabb45cde58708d940ead718%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637612199673041719%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=u55f4UA2CryPci5gT95LVEm%2F1%2FGeys0N39USkBTgTFM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
