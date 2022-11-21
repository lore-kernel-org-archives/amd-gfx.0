Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1033CC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 02:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E01B10E105;
	Mon, 21 Nov 2022 02:16:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106E110E105
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 02:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpRzXuZlZTCWsa6QkQcbeQLL8gurYZGmWhhAjtSN+MxmOsAtYceDhq2tROJwN4KP1Dv6FecRzy5EWjVn7oi577Zyiszwv6Unmxz3VQb/7L2bgkqUAdBDSFBtk4lYiNOkOz+CHL3OXV8tuWki//krcVQ+OGUciFudRG1lcFiXE+vR+wwl44eyoIyeR3G7DCLDE7gVCriAZ+1qM8CCnzBDZpAgiTb7g2wDBHykxmyssNET9HJ8zH0XJ16ivPg2mkjf1xp7bCmXAZDL5s2mcxG7FaBl9FkUsOV+DjQq6h0ojjctNUPeQ0vX/hzJ/d2gTttBSbrdpjk5P9jR4dUnpqhc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqOcV8oLepDfgRRjYDEKddXAI0x6ui9OX+8nzYuVfn4=;
 b=hymBfaU1AcNemygWnKtndlR93qHvH8dRSWxuZVK/OGvWYP94wo7DhSku/KudhN36tkj/UnZuT+h3+XL7WT09GO2KOGfaO2jBgCwd+VhCAdihUl944ZKNXA/MaU45YJzeCIVjS6SHvjeIxQJiQvABsMY1OjnVPDOBkwT0vy+eFIbwchDiqtbpUINa3exYlDPwhAnp+UJzhoY5SDi0mEpsQ5uDYZTi10W+yOtX7a0X6ixxyXvFoYGWwkx8zsBj/PZDLxuGduiqRs4GqHLOeSAGY6i4hYC8tDIxx/xoWlsh8hBRbqHOCdr/h99LGf5pwW0ANIQvszMmlS3A63b0ubO7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqOcV8oLepDfgRRjYDEKddXAI0x6ui9OX+8nzYuVfn4=;
 b=yQa8gMniI12GSMRlLaAeOLDeftj/cI+w9ONwTKGopch1BDsPHedAnhlPWiQVuxZoSNHQfDkbL/sMQ1R1tTSj/k7Vlzf+Z8PfF48tbVO4ykLmWIT9BlB5+LzasMLmPDVbHtuqDciCXVHBoLmAtsVIZ/0xJRcpkXbh2J7UmVzWfxo=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MW3PR12MB4570.namprd12.prod.outlook.com (2603:10b6:303:5f::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Mon, 21 Nov 2022 02:16:08 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::201c:5d11:7ae:416a]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::201c:5d11:7ae:416a%3]) with mapi id 15.20.5813.017; Mon, 21 Nov 2022
 02:16:08 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Li, Lyndon" <Lyndon.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add the fan abnormal detection feature
Thread-Topic: [PATCH 2/2] drm/amdgpu: add the fan abnormal detection feature
Thread-Index: AQHY/UrtYbFWzvKvJEih5M3H4H8Lra5Io8Ow
Date: Mon, 21 Nov 2022 02:16:08 +0000
Message-ID: <DM4PR12MB5165B6B9F7E3A039C436ECC58E0A9@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20221121014439.2101162-1-Lyndon.Li@amd.com>
In-Reply-To: <20221121014439.2101162-1-Lyndon.Li@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=02d2e709-87e0-4fac-9432-9fa0cd951908;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-21T02:15:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|MW3PR12MB4570:EE_
x-ms-office365-filtering-correlation-id: f72ed4f6-8970-41a1-a904-08dacb665a32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6L7Id4b7A73FZ2CrNptPn6Wb4bpX2dN8Rcdz59BPKnW2fj0kZ2lhjheLKIjjCQqDd6QT9N6J18OzbEJwjLM6c911lmGNQYVC5ebOg4OhtsRC08bsn7Pn8L0nSDZiCYRbgViZv6gVuCnfsIrtQY9/IevodD6MZ92VtYiYIVp0ZFgehd8TNrxP74UszFpGS3NQ2rZ0ZsWZOHLGeFFjg0Io+4QEi94X71A+1y5+hyJV8a7UjZmgngu2+wkMxooW0hInywLazQWEWj2htehFuNQMUC2HaQm+SM4J5oh+9id2DWYZNyNhOe2+p5WvXhxbwiK8YjYppSUmBtUVx+IKKnHLQDOy98WIxhoWL3mP/R97bTaX27N2IJUYyY0FKoZjWcJZtfmNxvkJRqd3AnhKYL1WRRXZFyC3Pw66Q5CIi/qN1J4EKFFXhGKYfwIT8ci9QOLM3SEIn1E5KL6xKmUMY0pa7URi9tTSDbdlHdC6jXbPJGtqjXfgT0SijMH3fhquoU+TX0OZ5stiDLrsObJpNKMimULHmSUQalCZBz1LGCd1r6saQNmH4pTSRmyS5QRbtwfIpdCzWap6Opc5v/CozTFa/ADMJLYQs4jnMc4wWkZt9hUzkPUm5/NAQzv48JALw+QxnfnOsHSHTNmnUPIXPGPgtBZQqafygzW5ZVWaGki+rmQq5aUpmuVim41IcCsePDbVBi04UiHLad940xE6q3RtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(83380400001)(2906002)(33656002)(76116006)(66476007)(66946007)(41300700001)(55016003)(86362001)(122000001)(54906003)(53546011)(6506007)(7696005)(38100700002)(110136005)(66556008)(38070700005)(52536014)(8936002)(186003)(5660300002)(64756008)(66446008)(4326008)(8676002)(316002)(9686003)(26005)(71200400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?htiVYhH9YQiYaFom0tlyGm7W8QhNn1CyIMkjwHA4DchF5yieOVMX+xnWo71w?=
 =?us-ascii?Q?5iiAsM/ZCkjC37bulKz9fTI1FVBNMQdWuB8TYVUIeZaWWpIu4ed68dFYsXbb?=
 =?us-ascii?Q?pJhKbCVWSU1JoGi2jwYfZOB5/nGUeDH7RyZWUl/JNsxdm8jUfS9Of30PR4K8?=
 =?us-ascii?Q?3pD17QZvIY3lSjDaRFS9aLBg22ourp6ntTPyVddSQ1+MztmJOtW/J7vbEdkO?=
 =?us-ascii?Q?QxvOnXBqrsA0SObxHvi2K9L/yqyLxhRNXJXTpMCpmtVI/q/q/AWOhplMUCZ7?=
 =?us-ascii?Q?ZMiS3Oxopn/ZYZ8mQuDLRmqEb0EJ9zrB8zkcFG2wdA/3+tWie2PhojQr4cap?=
 =?us-ascii?Q?z1J+8h/w18vBFxqt/rWViRjiZ1IvQUUeUFgPX7/VZSI0TZQMvtLaFDwGvF4s?=
 =?us-ascii?Q?iI+tQ9J2MX+g3kX7JxvDPcYznd6tBIEiowBfZWBxrQwD4xPTmB3yaYOutbcI?=
 =?us-ascii?Q?ot93oviaTGCcF+OKUdc7WZy3lM8PBMgvwWamv3+XirUAdMOyW7y/TqCMGQmt?=
 =?us-ascii?Q?/NjfeGTs/dtFf/cl8qhfzHZuNS8UKpQqaGoxIO0eIbQrdaB0IhK6/TvCikSo?=
 =?us-ascii?Q?JjBHQiuwDeBarpgnLiinGzMthlLkcwgdBEDHIuBccwYaWMzlO37GBcMMC1Mh?=
 =?us-ascii?Q?5vLQSsCC7oJwLOFZFujYD2nhLciJRXEv7uEXSWxNWYOzwSzHRlfJkcf034wJ?=
 =?us-ascii?Q?A/XUvQb/Kdpc33DqTRPACC9TsNbPbj+FbVN8N4d4TOKoAOwWoWayCI7VvHrJ?=
 =?us-ascii?Q?HhQ8DSMka7X2pftKOYP1+MoDlPa/gUwO176Fi06VtOfBdnK5ebLISDZBIS+Z?=
 =?us-ascii?Q?sDrYCgVESlxfNdlBztZjDBMTBe0f6DX8lWSK2Ie1VH6et/b2gi1fNQm/Wd2K?=
 =?us-ascii?Q?GBd9CBwCFio/lsMAw9Ess+J/ZfRvIvu9VCuK+pug50ivhYjdfvndt6JX6sst?=
 =?us-ascii?Q?wJvb7uqPimHBclVRjnmI0efhWniMZ5fJkRPT887X9ohrDgGkFjuoEbmyII6L?=
 =?us-ascii?Q?pX/ornC+5rxjdFGjCncm5kI42mEKOEJih/VYMM9cOhfwjSV7P0j0uwGlnt63?=
 =?us-ascii?Q?5F+ywvr7AMdHQKhJ0BqoDxhZVGGDirzMgrHqbdtAwBlTgs9S/ekzoceWjSsY?=
 =?us-ascii?Q?44S+v8zbTeqcjwArBv8i6qqFWxu8te7aMXA6FK/80uOmyVLYO/k1aG6f3kuC?=
 =?us-ascii?Q?Qf9TXiDXCLPKOclmncW60sDWAV8eTwu80GsaCb02sbXr+7ohR1wrUewJMM+/?=
 =?us-ascii?Q?+54J/n1ykQuuZlQMVSHmBCs6kxCinABkTMOvu+MiotbI1JWhMtdX+PzY+LoE?=
 =?us-ascii?Q?rtBrRladOaY394bvJSahHzhA4j9Ilx/1zeJMzeJpZfaE9f+FZjGTjBzRN6Ao?=
 =?us-ascii?Q?m88kAYHZ4pSBdIK/tC2NCKy+tef+JkSFMnn1G4y70qPDPZZzgYDDJvh/i1RN?=
 =?us-ascii?Q?1jVHIQqr3SSBw32da/XtFJmt7xm0d130iuBCEIg8FzivUjK6AOZwUGCisxzE?=
 =?us-ascii?Q?Ko8VUibXRdEr0CwFQef9s6utskOxJ/JRP0oYhfjgNTU6OpXUrt71NzeapvsS?=
 =?us-ascii?Q?qVmjFx5eA+vuawV2mLo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72ed4f6-8970-41a1-a904-08dacb665a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 02:16:08.6406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SW2Ti+MrzokxfOLDw/QoAPn+uqLUW0Ai0cJ4SjtZ4TVtnVhujPi30tlUqXGmwstW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4570
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Li,
 Lyndon" <Lyndon.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of lyndonli
Sent: Monday, November 21, 2022 9:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; enneth.feng@amd.com; Quan, Evan <Evan.Q=
uan@amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add the fan abnormal detection feature

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


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
+
+ smu->thermal_range.software_shutdown_temp_offset);
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
+                               dev_emerg(adev->dev, "Recover soft CTF
+ limit to %d\n", high);
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
+ pptable->SkuTable.FanAbnormalTempLimitOffset;

        return 0;
 }
--
2.25.1

