Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38AEC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 02:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5BD10E0F7;
	Mon, 21 Nov 2022 02:09:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7FC610E0F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 02:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkrSPhyprCa75L6Qtm25I9thXCD3w1gPZFFSdaRpjabyNmmB9NGthRByW+tRUP/3FaCJdxPZoVfBGpiEMay8D2Nen3ZM8fIKQXlhVe8HNVZ0nX75LoZ2SHe5XfL8gIdMGr4DQUglUXTapqXbKsu/91gtimZFeZ7cf28G7ipDWTVaWGV/qyQZVZNMR1+MfkwI7+U4XAXBli7VSQrUSaeAwVtt0Y4nA3uNAdX6hFiRj/aQMUKExsbU07azSQCd1tS7jR6Zo8tQZ2h4KnE4vgqN96YYwF5CC2p0Bl2rFMtB7kMbYMB5rWErusrCwUZ1AmOQ1V3Xlx5J9VkMYVBCjTWhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUA6+BPJT18F8hM3x76JNaiCFwRAnYaxtcIauH+W9CE=;
 b=RAgL4t2qT8oU8TLrrCLFYPIx5X4TWSQhdCNA5mJiKGikBGZOaM7IUE/snnk9862DUP6CjzY2can1ShGVMnJ1ujqWXuUJzsTPuv7jRkA/vDIihH353LNHSyBp11M1ros1O4PolO17w6PoHOreU+G/TRIpdy+Rhrk6G05DPZQBhMM1/8LDLsMR0OQXfk7hKA7TqJo+xD23aSC17HN7XoaY6A5IN3MJ6oetstAs4170oEwPoOIoLm30JMXGqccHsM8sMdQQDpWQBZpodzTLE2Kj2OJ7pg+BJGT9nEVtwnd96DlFpOqfwqOTG000NkTw30JyRcgg44UlOR+bX6FdfdJHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUA6+BPJT18F8hM3x76JNaiCFwRAnYaxtcIauH+W9CE=;
 b=rv2hWjE17Za1nWG2lo1f20oG/r6txfjdnKTg7RYUWYNRPph2lBBA3m3WSHN+ehH3TqF8KvfELivqb3ygkdyzYzibHL483kHxJ3/jAtllKgnRkcuPYxwF/4hsy5k/KVfL7p3qQTzyM2/1qs3Wppt7Vm41/gLz4AQqPB06XB8YsEg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 02:09:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::22d5:676b:e089:b677]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::22d5:676b:e089:b677%8]) with mapi id 15.20.5813.018; Mon, 21 Nov 2022
 02:09:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Lyndon" <Lyndon.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add the fan abnormal detection feature
Thread-Topic: [PATCH 2/2] drm/amdgpu: add the fan abnormal detection feature
Thread-Index: AQHY/UrurzpdB/upY0mWM5uoIHDHrq5IocAg
Date: Mon, 21 Nov 2022 02:09:45 +0000
Message-ID: <BN9PR12MB5257B27A03BCAFEBB8FD9ABAFC0A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221121014439.2101162-1-Lyndon.Li@amd.com>
In-Reply-To: <20221121014439.2101162-1-Lyndon.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9425c5ff-a0b9-4c31-a7c7-5e0971675f86;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-21T02:08:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA0PR12MB4526:EE_
x-ms-office365-filtering-correlation-id: feaf6a69-1630-41d3-550a-08dacb657591
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSxasG5YuuxadzmZUp9w5CHoNKnaNfi1AfP25LmQfiXh9BQ22tSgFTXGPzbK+cTbGTIkI/7szsychEEnxbaNxpTMMzI7neWsv5zUv4zonr5Oz4nkZ0F87IR1Tf3pB5qaS9+aAGz7ZyajlmpL0qzrbmd9IskRdHxqqo0ZP6aZmJVP4V7E7I7aClJLVVRFggtWqjNUS1vhPFwyKfhGcGT5WBP+g5B4fs7iNoNC+xITlwMlTygb6wmOj60vpsmPT5zsECU+vC5NiKWrOXfDrWVybXJtCun9jkyyS8amZwfSmPCeE7QBnm3sKxGGdmr5DA2o9IOf7/CjQLdpowtMPUwVlhTGWQDR7bvszoNnp7t5C9zzwkNRJHBtMbC2mf3jqLSwsprvzeJozg34Knxs8cvqACzDPbtVQ+GKuhJ7+5DPK8MZDsP2dP5KSbe6ExhyuKDxLVNaovqjXkd/BWSMa2KVBu6TccnCOgYm7LPg5AM2YFxnJWbzejIypmmwlhr4jG2O1ueZu8iamfaG8Ki0nBcOOvMEi6ozbRW4zDeML2a7RvTnwUWgLJnV6shpqgIB0BlO0KuPjyBAuCefmKiHJwzBQTqHUY1BYKXppTOh/QAsPC1XAWaOSCUK/U3Kyd8wEdzuKrDKs6lScPxpuI7lqFYI4+FYzORq0kR+byLdYBz68C+koR+9ySDjMx26B0dQfuU63QR/gEyruWPbMBPxb6qfug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(38100700002)(122000001)(55016003)(33656002)(38070700005)(86362001)(9686003)(76116006)(71200400001)(316002)(26005)(110136005)(53546011)(6506007)(7696005)(54906003)(5660300002)(478600001)(83380400001)(2906002)(41300700001)(66446008)(66946007)(8676002)(66556008)(52536014)(66476007)(186003)(4326008)(64756008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EH4aaYyqGZoZtJGmMsOh//SlUmjttS9fopI412GocT2AsFKlt9NGH1lcLHJC?=
 =?us-ascii?Q?pdJIAh8jOQ5Mz9Qz16g2MZFpLQ89I9uVKWLYHQWTyHVmG5dyGf/09QrxUoD9?=
 =?us-ascii?Q?bhnAro1y5TtU3DWPYPXe2B8C/LPyVWvwHvQIoO+jVJCmAqCtHx9OLJh6Py2E?=
 =?us-ascii?Q?UWjkF0poimbQjdnKz/9cy7CBzvDws6MJ8cc8B6nJNrj7IynyoFRl6AHVCtCM?=
 =?us-ascii?Q?e/0aDxDi6t/NM57eIlOok0/Qd1wi3hfqyTyLyo3BduEkX3L1FiP8Im7d9vaj?=
 =?us-ascii?Q?c6IUeR8FouZkj6OaeJiamrWHvYRgYZ21KrDFU6eSvd2oy10/+BaTwP9ScAmT?=
 =?us-ascii?Q?f8+3brFoSSy4f5UFnuO3Zob//wLA81PZqIVcnwEhs9QSo8az8Bt1qedwqFmA?=
 =?us-ascii?Q?3QcjpEOgMQWV1kaFhZkHuCU4Z2lrlEZZgMwLWD7STqC4VoZyHa/7FTkQryod?=
 =?us-ascii?Q?an8L9YooKC9BhvLwGseH76EeeT/XOnr7bhPjnEHdxWUjK6r/TDGD2fc41qIM?=
 =?us-ascii?Q?MSYEizG+WhhD/Q/PoA8GX6Q9FWOpL9wj+AGpWt09RZS6No5hk1Hk1pBsroJc?=
 =?us-ascii?Q?GNl+d4K7CtzmFFAF5AcFHcyfnHq14EVPCL+2XMTfqi/XTVTIGTSRjCLpokLh?=
 =?us-ascii?Q?eWWr7RqzPpITzRyNxRATYR2f2SwDo4f9yrM0yrBaDXjssZQD+fqyP0L3oSHY?=
 =?us-ascii?Q?tNql+/ylpGPGsrp/WZDJHsHKErPVOBStIFKvPuwmz+jk8CPeBcTQDiow0cEm?=
 =?us-ascii?Q?kWo9RtOs9gQYIlsNPy2kuO7JyoQgG+lP1okH1xYNzRq9X9hihc/TEjqDzUKB?=
 =?us-ascii?Q?BvlBuRNKc2H5GUqdhf5O7Qm/DXJHP0WrDidxGxeSLRmO177NtpqtSEeF0KZX?=
 =?us-ascii?Q?C75uProWMH07lLsgOr0iksJmS8T1b19eX5EPp/Eu65WZDBoaU1F2/5NO+fYB?=
 =?us-ascii?Q?xxiIDUhCBFJGOs7CS0+lna6bfQ8yfIIWL8hlxX8PnG8AUW2CbJa6ILKpvTjH?=
 =?us-ascii?Q?KC8B9l84VyaKbvw6EH6MaUG64LFzGN62nEVz5LZLv7n4oKlLuY734xqUyg1S?=
 =?us-ascii?Q?YpVIzsse+ViKkN0KtIIQN3PucN0/IHUjSmqS/IzO9Hvo95PnHpsFSSKoxYjy?=
 =?us-ascii?Q?BEh34giUjuMnmr71AtsnmFn5KcJD+Wk4X5iSsn1eG7avqEEUn6uygIG9mX42?=
 =?us-ascii?Q?HEp65CpjW1pIjFrQT3Kf2nMFJTU9yHztKe2cact82rzsgTDbJbG3vbLejd0W?=
 =?us-ascii?Q?0XQGNmdx4fwMoKyvdZ1woxBlBJXAE1wp2GHLTPrWitXkhWN0b4LhCuDctuov?=
 =?us-ascii?Q?f6Y9O+eKqVM2j3gBnyUCGOTBPDCoBlyksemD+MRQOivhvz/aQQu7unlnxyEA?=
 =?us-ascii?Q?Ryu+EvTvBeJ5ylyYebWwl18zNuzLwA6sK2PN7CP62VihY2x7jlIYNS1VlRc9?=
 =?us-ascii?Q?tYYlwBp2gnzmzpEjGmE1eSoGHclzNbFINfUGcU1JzokoQo0dkcHHaKrGoLQ8?=
 =?us-ascii?Q?AG/C7322+G9mF6hVY8J9bYDmElqZoy0/3Sv7vhWf94wzBZ86S4j6nX1aQyva?=
 =?us-ascii?Q?0HK2RByP60HbBRlBzuvvNbStaKj565DL5A4CICXZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feaf6a69-1630-41d3-550a-08dacb657591
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 02:09:45.0472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95yitBkqDtfUoY3n6OtGjEpFytsGftoZyJl2IZePzUpIstN5dqx09Rg6no2uTAppuMQkfdVsTf3ee3qzudGH1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>,
 "enneth.feng@amd.com" <enneth.feng@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Li, Lyndon" <Lyndon.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of lyndonli
Sent: Monday, November 21, 2022 09:45
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; enneth.feng@amd.com; Quan, Evan <Evan.Q=
uan@amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add the fan abnormal detection feature

Update the SW CTF limit from existing register when there's a fan failure d=
etected via SMU interrupt.

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 28 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  1 +
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 44bbf17e4bef..3bc4128a22ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -168,6 +168,7 @@ struct smu_temperature_range {
        int mem_crit_max;
        int mem_emergency_max;
        int software_shutdown_temp;
+       int software_shutdown_temp_offset;
 };

 struct smu_state_validation_block {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 89f0f6eb19f3..5a905002252d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1376,6 +1376,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device=
 *adev,
         */
        uint32_t ctxid =3D entry->src_data[0];
        uint32_t data;
+       uint32_t high;

        if (client_id =3D=3D SOC15_IH_CLIENTID_THM) {
                switch (src_id) {
@@ -1432,6 +1433,33 @@ static int smu_v13_0_irq_process(struct amdgpu_devic=
e *adev,
                                        schedule_work(&smu->throttling_logg=
ing_work);

                                break;
+                       case 0x8:
+                               high =3D smu->thermal_range.software_shutdo=
wn_temp +
+                                       smu->thermal_range.software_shutdow=
n_temp_offset;
+                               high =3D min(SMU_THERMAL_MAXIMUM_ALERT_TEMP=
, high);
+                               dev_emerg(adev->dev, "Reduce soft CTF limit=
 to %d (by an offset %d)\n",
+                                                       high,
+                                                       smu->thermal_range.=
software_shutdown_temp_offset);
+
+                               data =3D RREG32_SOC15(THM, 0, regTHM_THERMA=
L_INT_CTRL);
+                               data =3D REG_SET_FIELD(data, THM_THERMAL_IN=
T_CTRL,
+                                                       DIG_THERM_INTH,
+                                                       (high & 0xff));
+                               data =3D data & (~THM_THERMAL_INT_CTRL__THE=
RM_TRIGGER_MASK_MASK);
+                               WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTR=
L, data);
+                               break;
+                       case 0x9:
+                               high =3D min(SMU_THERMAL_MAXIMUM_ALERT_TEMP=
,
+                                       smu->thermal_range.software_shutdow=
n_temp);
+                               dev_emerg(adev->dev, "Recover soft CTF limi=
t to %d\n", high);
+
+                               data =3D RREG32_SOC15(THM, 0, regTHM_THERMA=
L_INT_CTRL);
+                               data =3D REG_SET_FIELD(data, THM_THERMAL_IN=
T_CTRL,
+                                                       DIG_THERM_INTH,
+                                                       (high & 0xff));
+                               data =3D data & (~THM_THERMAL_INT_CTRL__THE=
RM_TRIGGER_MASK_MASK);
+                               WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTR=
L, data);
+                               break;
                        }
                }
        }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index d74debc584f8..c3c9ef523e59 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1223,6 +1223,7 @@ static int smu_v13_0_7_get_thermal_temperature_range(=
struct smu_context *smu,
        range->mem_emergency_max =3D (pptable->SkuTable.TemperatureLimit[TE=
MP_MEM] + CTF_OFFSET_MEM)*
                SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
        range->software_shutdown_temp =3D powerplay_table->software_shutdow=
n_temp;
+       range->software_shutdown_temp_offset =3D
+pptable->SkuTable.FanAbnormalTempLimitOffset;

        return 0;
 }
--
2.25.1

