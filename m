Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C535C07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 08:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C591610D1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 08:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C591610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9036E58B;
	Thu, 15 Jul 2021 08:08:18 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C6D6E58B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 08:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZVoEe+bruOo8I/Zf88OX2ZmZ+Wd95U+DRb1rM8Ofn7a/udb+Up6I1CaPukfQ7NGZ+H0wQD4OpPke4yIcSsXvHgYnNS6rIAvLWGJy9B7ahQ4ed7gGmOzuvbbCvVdwbNXFJePpN43TqfLPpJ4cTawpX1pckPUMw6u4UvxH1nmCbVS1XoSW4vl3t8Q6U0dmDu5KYoUg0iJ/9QsiMRHetgCMzcnCAAiXXb6Zil0KEZEPLgVDYelia5EZ2/cz6nPRr9+VzEHYOwgyfm6GYCkRSKl/vihPHNnY6dd5RDqY3F4VnF8aZt+tndtp5GInDOn+ma57rEv9nwPYDGfacvH7VAsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D79Q9yiCvDuMGLOJZx4+OrUA3+BA0SHrAolDzPqFxs=;
 b=IugLIN0bZj+DAZ/Oz1kUK8tbP4l1EJTNUXV36GUNl+Oa9/MlAzR6rpoo2MmdXrb1acZuThSmuTqmsHMJJNx14SgywiS3hxDVbX04biREyV4d9aDx5KsJW2isovX4l+AH5qpA+yCESFWUuPMTIsj32ZfKXFh0mdz/MZIY698oxDUDWClgHDw0jJ3D85tTQz0kfJuBd09Gl/mYS9Cl2ib2VqL2kGP8eRGtpG+8LRGNSzEEGxbUiIOuZ37ws6kFvcOaBi0eTmYALHFTXd1gP/L75hc3Pp63XDmKYyrlKScoeZk+xVAdA+eOVrPEEkqjaf0bQsXZWIGdfII9osshRh9BCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D79Q9yiCvDuMGLOJZx4+OrUA3+BA0SHrAolDzPqFxs=;
 b=k/wmUWrxqhE1xGwMJd91GrgUitqBVhQGGizjY3obrVxeXsLbbGDH+aulVSNnvUwYcPrzAtyogSxyq4416tNhBqMWqabE2Cqlto1T9cPJIWPCV4rXpJ+/MtcaWwwbjRlRcxHKaPSO0FrNpqrjTzeoAJw7Q2PjH/mtx06nTZEMxcI=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Thu, 15 Jul
 2021 08:08:16 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::4117:5516:ddb7:1514]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::4117:5516:ddb7:1514%8]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 08:08:15 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: Support board calibration on aldebaran
Thread-Topic: [PATCH] drm/amd/pm: Support board calibration on aldebaran
Thread-Index: AQHXeU2yckEjLvpVa0mJeC3uW0qrW6tDrXkR
Date: Thu, 15 Jul 2021 08:08:15 +0000
Message-ID: <SJ0PR12MB548829285C72A55CD22B8125A2129@SJ0PR12MB5488.namprd12.prod.outlook.com>
References: <20210715074718.31681-1-lijo.lazar@amd.com>
In-Reply-To: <20210715074718.31681-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-15T08:08:14.301Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8140fdf-fc48-400b-d09c-08d94767b2ce
x-ms-traffictypediagnostic: CO6PR12MB5410:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB541011E9FCE28135F42D3F53A2129@CO6PR12MB5410.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fHUptVNoMlOMJ6rtzJh+J87UfR3WS/t6MthJWa/YOfm6H1G9LWLrfn/r0TrWT2g4KEyQAUibJgttaVi0JKIS3AlPBZOuZjTRugRNi1c4GtJBC9AoVkdz0UoQQBsO6CrNxWCN1BJxm8uzvKnPf0aI+glDvHC7V234lz6BV5P4Te0FdB84Locy1VuE70JCr5c7piq1oTuitXsz/SUYZeIKj6Mi5yIsGM2+Lin8BDP8R8QLeJj0ep4dzDRgaQJrx/RiQu8XMEaaNM2marUMb0pVDaiRbX2DOCA2ADlNbpLMOYxzlFWL9gM180V3jnnIQTsei/+RZS/5Mpd6YnU0bhhYkFiJXVZ4xxqxWPvBPAL3hM1F6bNScdLog0yPn9JtkPw/h9SRoRtKtdvMk+xCSycZsLEp/zYuH0AMPSVkIxpPC6MAgbQL8xrsS9vlvpq+YUwAfEHz+IHjcL30xSAS34r6Q1mcvJFETVk8NGduTCcVRUGhFPNsX/RunR0YWCQ+I0XjCxLAdPRoGi1UnNCSgyPY51Vkijwlin+5OxmOVXgdrLpGHk5uSQ5O5ff0UsoJWuXyo73cdBXY1tJvl10WmLvNVAuzbGnN7IGgao+FnHYNcLedAvgm8yutH+1i8jTgK1D17qBAxL+0UZQJUT6Aqownv9UIQoJ33QroX5atr6EaHnHmUgBOQxD6y0LASSn54lCNNnjNpk/8UBu/bZeQ+1Yy2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(2906002)(478600001)(66574015)(83380400001)(52536014)(66946007)(110136005)(54906003)(8936002)(91956017)(5660300002)(76116006)(6506007)(8676002)(64756008)(86362001)(66556008)(66476007)(33656002)(4326008)(66446008)(71200400001)(6512007)(9686003)(26005)(186003)(53546011)(316002)(38100700002)(6486002)(122000001)(19627405001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CdIrF/3cAmZHBBxEKHHWljPSK7FRGXWDXMEZ0p0Y1Smqw1RSTsmEFqakoW?=
 =?iso-8859-1?Q?PixVzgnXEQZriIhTJt/E+UUnpBNkNpuLVh0CVFRx2KAcnfddowMvtqF9dO?=
 =?iso-8859-1?Q?F8thp/8WTh5D8PTGs98370YsC4m46DAn83BTw8GgR6j2Z57ztgz6jD48uZ?=
 =?iso-8859-1?Q?N/6OuGi+pmVfZFRs/jrdoHmIg/mAvW9bLeMcqK0AkmCqLqJJVIHxV8320V?=
 =?iso-8859-1?Q?0ONr6gLYewS0q7ec2ciAOpnSRSkO7kG9XM/fADl8bQKlZ20eKJdOmbErL9?=
 =?iso-8859-1?Q?Q+Wqubw3g0hddIxUDllpjF5VceVxEQTVWcHERPsJ7DY7BA1TKvOH8MYkf7?=
 =?iso-8859-1?Q?pPBh7mT7uU5QSB/LVBzyc+ohzd5PSwvLpIB8TOkYFr2xd+AUL+6Vl0dxSW?=
 =?iso-8859-1?Q?fpPnvyxLsDziRv5hNcEYSVEDZpYhdhr0WAwoihODcfUKubsD4piIutkqT9?=
 =?iso-8859-1?Q?JW3ETZVDlFDkdvyzCppda9fGDhs3hYk+eYP5JPjfmjt1oXgvCvZfmtidc1?=
 =?iso-8859-1?Q?Tjq0WGCjtWOa5T3VPFjCFKCL57s7pJsSOUGqlabuuID6j+Yy9aAflxoZ+5?=
 =?iso-8859-1?Q?i0LCl+/bZWOaAo40dHyTcAZ0oxw8vQ2spY+735GbHGLYFiVn76fbNfHQoI?=
 =?iso-8859-1?Q?fLgdunZxV5NrGlYmVfHBRpZoZW8Y74odnkU+nXCqGgvfsR12inaH1X0fSm?=
 =?iso-8859-1?Q?WPrXH3ADyOEd802QjE+rgrLp90v6I3LwWR0Uq8b5IHwkKNU8Yr6Kqaqo9D?=
 =?iso-8859-1?Q?bEkNgvv2oj7PyUHyl4s8slrWuOZ5ZuLvIdTrBiRpjqe+NLFQGqHXuB3pab?=
 =?iso-8859-1?Q?CENceObxKOUr7DEKCbdgVy7n/tmzF+M6A4h0C3QKt5Z8Hlc4UGSqCqQfcP?=
 =?iso-8859-1?Q?kG4es1SrGLff0kSwkNAQMwdHnWQoVUGtsenp2im8mCXZK8PcZvK+sjYWE+?=
 =?iso-8859-1?Q?5lwik5JwSBUme3POpFBA5iqTWhcQbS1B9ca77kJ4TLiCCsem/UAvXimEsv?=
 =?iso-8859-1?Q?KHcm6s66q30P+32ResWC1+ukat9SQ6O5di7tkixwKBjaGGEuHJk1Hzv1Ov?=
 =?iso-8859-1?Q?+k0P/ER/N5JPVV/POZ0fAb2nhepL5BC2/UuXQ9FHMVLxz8h3dNosgbkoIr?=
 =?iso-8859-1?Q?+EVfJ8MQZb0IR79WKnaYjnG0L7PwnypS3CO9JIbYOiQkE4v0o/aOvch6ib?=
 =?iso-8859-1?Q?FYEB6oBoI5KuBamSh0husk21BA+L053f49ScZjOL8qWpz7y71X3jTBpYTK?=
 =?iso-8859-1?Q?1bvcliqvdO5mkW952RQsggrJw0GGfwRVRsByOQHDyxurNhplTfibWmJLrc?=
 =?iso-8859-1?Q?EbuxWWJfNoVtlJaEYT33s8AmQccvKhZbMcoStwQIcxxnXyqjOSbL5PE8gt?=
 =?iso-8859-1?Q?IUCu3XqguE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8140fdf-fc48-400b-d09c-08d94767b2ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 08:08:15.1719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WG5JCsvmpqh8izWfhxBh9lznZcNRVV6HbCtAIqHPQMetrRqKydyn0Us2iU4VGz71
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1681725431=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1681725431==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SJ0PR12MB548829285C72A55CD22B8125A2129SJ0PR12MB5488namp_"

--_000_SJ0PR12MB548829285C72A55CD22B8125A2129SJ0PR12MB5488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

<comments inline>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, July 15, 2021 3:47 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@=
amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.c=
om>
Subject: [PATCH] drm/amd/pm: Support board calibration on aldebaran

Add support for board power calibration on Aldebaran.
Board calibration is done after DC offset calibration.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h  |  3 +-
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |  3 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 42 ++++++++++++++-----
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm=
/amd/pm/inc/aldebaran_ppsmc.h
index 610266088ff1..35fa0d8e92dd 100644
--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
@@ -101,7 +101,8 @@
 #define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrLow  0x41

 #define PPSMC_MSG_GfxDriverResetRecovery        0x42
-#define PPSMC_Message_Count                    0x43
+#define PPSMC_MSG_BoardPowerCalibration         0x43
+#define PPSMC_Message_Count                    0x44

 //PPSMC Reset Types
 #define PPSMC_RESET_TYPE_WARM_RESET              0x00
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/p=
m/inc/smu_types.h
index 89a16dcd0fff..1d3765b873df 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -225,7 +225,8 @@
         __SMU_DUMMY_MAP(DisableDeterminism),            \
         __SMU_DUMMY_MAP(SetUclkDpmMode),                \
         __SMU_DUMMY_MAP(LightSBR),                      \
-       __SMU_DUMMY_MAP(GfxDriverResetRecovery),
+       __SMU_DUMMY_MAP(GfxDriverResetRecovery),        \
+       __SMU_DUMMY_MAP(BoardPowerCalibration),

 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)   SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index c16ca0c78e93..1400ccb3bf52 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -134,6 +134,7 @@ static const struct cmn2asic_msg_mapping aldebaran_mess=
age_map[SMU_MSG_MAX_COUNT
         MSG_MAP(DisableDeterminism,                  PPSMC_MSG_DisableDete=
rminism,               0),
         MSG_MAP(SetUclkDpmMode,                      PPSMC_MSG_SetUclkDpmM=
ode,                   0),
         MSG_MAP(GfxDriverResetRecovery,              PPSMC_MSG_GfxDriverRe=
setRecovery,           0),
+       MSG_MAP(BoardPowerCalibration,               PPSMC_MSG_BoardPowerCa=
libration,            0),
 };

 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] =3D =
{
@@ -440,6 +441,35 @@ static int aldebaran_setup_pptable(struct smu_context =
*smu)
         return ret;
 }

+static bool aldebaran_is_primary(struct smu_context *smu)
+{
+       struct amdgpu_device *adev =3D smu->adev;
+
+       if (adev->smuio.funcs && adev->smuio.funcs->get_die_id)
+               return adev->smuio.funcs->get_die_id(adev) =3D=3D 0;
+
+       return true;
+}
+
+static int aldebaran_run_board_btc(struct smu_context *smu)
+{
+       u32 smu_version;
[kevin]:
change type to uint32_t is better match with smu driver coding style.
+       int ret;
+
+       if (!aldebaran_is_primary(smu))
+               return 0;
+
+       smu_cmn_get_smc_version(smu, NULL, &smu_version);
[kevin]:
you'd better to check return value first before using smu_version.

others is fine for me.

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

+       if (smu_version <=3D 0x00441d00)
+               return 0;
+
+       ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_BoardPowerCalibration, NU=
LL);
+       if (ret)
+               dev_err(smu->adev->dev, "Board power calibration failed!\n"=
);
+
+       return ret;
+}
+
 static int aldebaran_run_btc(struct smu_context *smu)
 {
         int ret;
@@ -447,6 +477,8 @@ static int aldebaran_run_btc(struct smu_context *smu)
         ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
         if (ret)
                 dev_err(smu->adev->dev, "RunDcBtc failed!\n");
+       else
+               ret =3D aldebaran_run_board_btc(smu);

         return ret;
 }
@@ -524,16 +556,6 @@ static int aldebaran_freqs_in_same_level(int32_t frequ=
ency1,
         return (abs(frequency1 - frequency2) <=3D EPSILON);
 }

-static bool aldebaran_is_primary(struct smu_context *smu)
-{
-       struct amdgpu_device *adev =3D smu->adev;
-
-       if (adev->smuio.funcs && adev->smuio.funcs->get_die_id)
-               return adev->smuio.funcs->get_die_id(adev) =3D=3D 0;
-
-       return true;
-}
-
 static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
                                           MetricsMember_t member,
                                           uint32_t *value)
--
2.17.1


--_000_SJ0PR12MB548829285C72A55CD22B8125A2129SJ0PR12MB5488namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&lt;comments inline&gt;</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 15, 2021 3:47 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wang, Kevin(Yang) =
&lt;Kevin1.Wang@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Qu=
an, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Support board calibration on aldebaran<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Add support for board power calibration on Aldebar=
an.<br>
Board calibration is done after DC offset calibration.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h&nbsp; |&nbsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/smu_types.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 3 +-<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nbsp; | 42 +++=
+++++++++++-----<br>
&nbsp;3 files changed, 36 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm=
/amd/pm/inc/aldebaran_ppsmc.h<br>
index 610266088ff1..35fa0d8e92dd 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h<br>
@@ -101,7 +101,8 @@<br>
&nbsp;#define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrLow&nbsp; 0x41<br>
&nbsp;<br>
&nbsp;#define PPSMC_MSG_GfxDriverResetRecovery&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x42<br>
-#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x43<br=
>
+#define PPSMC_MSG_BoardPowerCalibration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x43<br>
+#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x44<br=
>
&nbsp;<br>
&nbsp;//PPSMC Reset Types<br>
&nbsp;#define PPSMC_RESET_TYPE_WARM_RESET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/p=
m/inc/smu_types.h<br>
index 89a16dcd0fff..1d3765b873df 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h<br>
@@ -225,7 +225,8 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DisableDet=
erminism),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetUclkDpm=
Mode),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(LightSBR),=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GfxDriverResetRecover=
y),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GfxDriverResetRecover=
y),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(BoardPowerCalibration=
),<br>
&nbsp;<br>
&nbsp;#undef __SMU_DUMMY_MAP<br>
&nbsp;#define __SMU_DUMMY_MAP(type)&nbsp;&nbsp; SMU_MSG_##type<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
index c16ca0c78e93..1400ccb3bf52 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
@@ -134,6 +134,7 @@ static const struct cmn2asic_msg_mapping aldebaran_mess=
age_map[SMU_MSG_MAX_COUNT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DisableDeterminism=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DisableDeterminism,&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetUclkDpmMode,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetUclkDpmMode,&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GfxDriverResetReco=
very,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_GfxDriverResetRecovery,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(BoardPowerCalibration,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; PPSMC_MSG_BoardPowerCalibration,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT]=
 =3D {<br>
@@ -440,6 +441,35 @@ static int aldebaran_setup_pptable(struct smu_context =
*smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+static bool aldebaran_is_primary(struct smu_context *smu)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;smuio.funcs &amp;&amp; a=
dev-&gt;smuio.funcs-&gt;get_die_id)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return adev-&gt;smuio.funcs-&gt;get_die_id(adev) =3D=3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+}<br>
+<br>
+static int aldebaran_run_board_btc(struct smu_context *smu)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 smu_version;</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">change type to uint32_t is better match with smu d=
river coding style.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aldebaran_is_primary(smu))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_get_smc_version(smu, NULL, &a=
mp;smu_version);</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">you'd better to check return value first before us=
ing smu_version.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">others is fine for me.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt=
;</div>
<div class=3D"PlainText"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_version &lt;=3D 0x00441d00)<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU=
_MSG_BoardPowerCalibration, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Board power calibration fail=
ed!\n&quot;);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;static int aldebaran_run_btc(struct smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
@@ -447,6 +477,8 @@ static int aldebaran_run_btc(struct smu_context *smu)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_m=
sg(smu, SMU_MSG_RunDcBtc, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;RunDcBtc failed!\=
n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D aldebaran_run_board_btc(smu);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
@@ -524,16 +556,6 @@ static int aldebaran_freqs_in_same_level(int32_t frequ=
ency1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (abs(frequency1 - f=
requency2) &lt;=3D EPSILON);<br>
&nbsp;}<br>
&nbsp;<br>
-static bool aldebaran_is_primary(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;smuio.funcs &amp;&amp; a=
dev-&gt;smuio.funcs-&gt;get_die_id)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return adev-&gt;smuio.funcs-&gt;get_die_id(adev) =3D=3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
-}<br>
-<br>
&nbsp;static int aldebaran_get_smu_metrics_data(struct smu_context *smu,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; MetricsMember_t member,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *value)<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB548829285C72A55CD22B8125A2129SJ0PR12MB5488namp_--

--===============1681725431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1681725431==--
