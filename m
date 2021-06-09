Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27E7C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 07:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2CE61361
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 07:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2CE61361
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25CF56E235;
	Wed,  9 Jun 2021 07:22:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132C56E235
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 07:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDgjZ0x69jiTJ1LaB0oDAjDxAECJHFuLCksAuIooVfWui/BHwzhzEOOLOsBqDKCvD6RlmU05w8IKytqRnwPA5Rw3tklfPyRABakLBN+dwNbdJ8HhCjpG7GNB4y0ibbMQdeYF4SM2GrMqJHLNOCsODyhmfrH0pmeWZGTS6z/wbSTLXdin9pNuZNzRFkuQB+GIJDS5vh5IVtuQhe6jI0CfjO3JSdI/Gt0CEmOIkVtnkEAOWugxVLhrnNFgEPr7fcShcJkgTjDgmYhLSc8oi4Yf5tSSL3vwUUTSB/KV2OkP5l5dFWl+N4Gs7nEpwPmHor54KdTksaM0GoWbOoGRfJXLmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/7d2ioNdtpPBQE7mwN6LbQZWgDqnQKC9xR+vYI9LZ0=;
 b=CCu0ybzBO7fAWM12rMc152zntYbI2nr0yYLp/XfMyrkU6axG6XLEdwztkzrXzhb7YkfJX/ZYMDm7ZsgKV5A4wtIx7Bf+TMK3ITmIHHpyNk+GXh5f5G8Yu5r1F0f0Bn4uemxy8xwvE9hMvrxJx7Cd26tjiZIemHhSsyknOdCGH4R30DjElfYnPFeYoSjDwBSMjVhtJShj/R3CZmDZflIz7yUPoMSQfPWgr7lQkJJmWrdMoWXevNEOwD4uSiPluU8iaQriLEBSl7BWyZCcfVXW4sk7qDiqrGuiyD9/HPJEQ9qPbTaouBy1ymjObRJxAqYw4X07071ugc0Kkl1HAPbr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/7d2ioNdtpPBQE7mwN6LbQZWgDqnQKC9xR+vYI9LZ0=;
 b=2yJwdO0ktTzFg9eS6qRuGk58LHIxchYoDsrboHFRtAWZIegWguorAMyQieOW5RGargF7WlrbmH40EgEujomHC+ZT8UulATid01/nzI7SjQg/oRmIgwhf55X05UhTWjokhyz+lg6mgqty/swVm2SokSkmAKQxhNAxIeVb1/OTvGY=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 9 Jun
 2021 07:22:02 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 07:22:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Only primary die supports power data
Thread-Topic: [PATCH] drm/amd/pm: Only primary die supports power data
Thread-Index: Addc/gkczx5lDivYTV6dTI1O8B/8fgAAg51g
Date: Wed, 9 Jun 2021 07:22:02 +0000
Message-ID: <BN9PR12MB5368E5D295F3BAB6AF1AE290FC369@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <CH0PR12MB53488C033DB25B63D0AF725697369@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53488C033DB25B63D0AF725697369@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-09T07:21:58Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ef0d4082-e64f-405a-bbee-152c7815560d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c875f76f-d399-4d47-ba22-08d92b1746e5
x-ms-traffictypediagnostic: BN9PR12MB5179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51791800969C99A94678191CFC369@BN9PR12MB5179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tYUQMEhiurkElEAWnG7hryoaJLOakwJS5NDtJ2H1fovf+9nZc/GoAGeCPUtgyZ78TwJw6P9T6fjOPiBIIVexwJ4fsuFcxdazy7VOiyuAd1IyaHkg5FYTdMBfKDwJmVHWdKPnvU3Zy41JukgxDlCQp8nB0SPJy2ovkR+GcJM7WsjeMg4camZbo/Jyb+kzRLCklUG6Ca+jFTZGIq+vkGLNrenz1u5Vt//9JujMLOLdOi3LAnPzQ7D+yn8Z/rdCMY97qSKzwyOJGjmnxpIuBZpMHmdPhF/B9KjRp3apift9CuPUPI1EJaFTvJOrMSxde80lXBpp8wYjjnLCRF4jUAU1+aR+i201b8K9S2+TMe+TMfl1UGFHTaI6cuEima5hDumhBEYXLDJ7ESO7k1MUiEc3XEzCGXrSAkKBNp+CUEed5akeyJ36mj2/tdycQFYqPl1jPOwcTQOWFWIr6e6SXAoAJWHGL/RIYEafFEStHuXB2NLmaNwyVmIUGcgzK1+u4vymuiu1VSa1dkOxR1XwMv0l4U/A4eI9/ZwwF1p8YH3SVnGLNia8bAnAFpQYqCKkNj/AbcUacbaUfwniUtarAhrvtlVTe5OR041Zu77dejHwy04=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(9686003)(55016002)(316002)(71200400001)(83380400001)(110136005)(2906002)(54906003)(122000001)(66476007)(478600001)(4326008)(52536014)(66556008)(6506007)(66446008)(26005)(64756008)(8936002)(76116006)(38100700002)(53546011)(8676002)(33656002)(66946007)(5660300002)(7696005)(186003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3fUIlnoByB8W6YLNrHq1DmIlgYQhkFy/XFkUXprvmr6ifJxZVb9XI50TVhIa?=
 =?us-ascii?Q?YLwmcRhR0uDK3PSTAxkevVbDTXagiI4E1TYhJOx5/sdFQ0Hi6WMU52bobaIj?=
 =?us-ascii?Q?8O9meOtFRFutdveRfpscszEbL7/FH71ZauEq0dQtm2NMs0s8N4cHydNRCEhU?=
 =?us-ascii?Q?yeh+006Yi5tfEMXmESklbjLXGo6P+SZNAymMHJ/tgS6h7DFRuknhnRBnhZs2?=
 =?us-ascii?Q?5mi0YWYBNVcDQPHDwgrTYIi+GltHiZ6g5eJDSz4ISwCsfzp3KtEqabJc41DU?=
 =?us-ascii?Q?2RjafOoY2xbPS7rTK8Mgu8LNtd1xa6YqLhcAW2WJIM/pb6biW7JCAkAJCFjb?=
 =?us-ascii?Q?sNjC0EXPhF9lD5eQmgxrWq7HPYmRIErBnXV525SfxgeDimgZB2iIrb/ibXFu?=
 =?us-ascii?Q?Yl1Nw/UGvrhp7NeUPFOQWJwcczbMV1sdpUFlcDkTca102fZqsMxFy+5g0Se4?=
 =?us-ascii?Q?wG/Kxmgh25/UkS1kdmR8IXo7Kh9uwNeM0OAk3zcfXw2b3UgqJQvMUoidxYpm?=
 =?us-ascii?Q?mEDh7VTmnKknWWt+apJH7/lFYdUDvPyEY693Y+zgRbS62aC2/UX7Hjkk1cVD?=
 =?us-ascii?Q?197jJuNcQEzlxYma/vCnTHuqZZmZmg+LvIM5Vk5Pv5/QO0Qx6hh4G9SJa0TD?=
 =?us-ascii?Q?N2h+Ve+ArxqFDQ5HwSMZqhZDhydAqcpM2MQudmI61OfSZ6Mc84LgjFM/eUBb?=
 =?us-ascii?Q?7PHNNdZKY+TV12s76u9Ps0GWWkfB3u05qTZvnVuQdF1DdjJJPwC/STRhysc3?=
 =?us-ascii?Q?adI2pWTXI3ffr0Qfw2QfUpxoGbuMLbdDmdY5xOtIYkVgmh8BLcJJibD58eV5?=
 =?us-ascii?Q?F26cc+OCmKbVoJbIr0vqXXcs40lpjC2Z9yzzd/XzOVCP/l7sqAGNTy7ZBPIM?=
 =?us-ascii?Q?NNOYIJRJVojfQ3y8uZpTgLdpM5suso+uf31z5kEPCeaLOu7a8PiovGEoddB4?=
 =?us-ascii?Q?ZjQZQPmeXFuYaRGlHYrxatsln8Ta7WZBUfHb2qeluOff1yHBeIoNd00imaMp?=
 =?us-ascii?Q?kReRBBYPBNK+hxAoNNiBfBDDi1DJT4EQosE5X5tv0h9KG6+q8cnWKIxuB6z8?=
 =?us-ascii?Q?FN/BMTGzsmzALlUdwoao7DSDi5Qb3JeIUKHROEyjoPRlHvbkjJX8flbcF7HW?=
 =?us-ascii?Q?HEn8a1XGlId/3TnebnpQ9LetcFQPQFpCvXtojltOEcRY36SwVnqDM/is7r3z?=
 =?us-ascii?Q?0iAqDhp32QI33IydgAzYx5/pMLneZqyveoGbfXKLhDCyLxgNY3VU6tRero4V?=
 =?us-ascii?Q?CssGYQUoxjcZkcJM1FNvMFDGfOzrQhyVyVDNiFeP+vn4V0Sve204GasWlZTo?=
 =?us-ascii?Q?AxOZNYQF+aNjp/K7cuBx/aQA?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c875f76f-d399-4d47-ba22-08d92b1746e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 07:22:02.1755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lYc7Oi2JBSKflTgYPioz+7qi8zY8M9NR/N+xrNoXQC5zsrwe/ysAYwmSpf/itsooIYLvL/yZnxUcUO2eOLo6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>
Content-Type: multipart/mixed; boundary="===============1780795344=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1780795344==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB5368E5D295F3BAB6AF1AE290FC369BN9PR12MB5368namp_"

--_000_BN9PR12MB5368E5D295F3BAB6AF1AE290FC369BN9PR12MB5368namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, June 9, 2021 15:09
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kasiviswanathan, Harish <Harish=
.Kasiviswanathan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; =
Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: Only primary die supports power data


[Public]

On aldebaran, only primary die fetches valid power data. Show
power/energy values as 0 on secondary die. Also, power limit should not
be set through secondary die.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>>
---
.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 57 +++++++++++++++----
1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 6ee9c4186f02..6fd78871f272 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -510,6 +510,16 @@ static int aldebaran_freqs_in_same_level(int32_t frequ=
ency1,
               return (abs(frequency1 - frequency2) <=3D EPSILON);
}

+static bool aldebaran_is_primary(struct smu_context *smu)
+{
+             struct amdgpu_device *adev =3D smu->adev;
+
+             if (adev->smuio.funcs && adev->smuio.funcs->get_die_id)
+                             return adev->smuio.funcs->get_die_id(adev) =
=3D=3D 0;
+
+             return true;
+}
+
static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
                                                                           =
      MetricsMember_t member,
                                                                           =
      uint32_t *value)
@@ -563,7 +573,10 @@ static int aldebaran_get_smu_metrics_data(struct smu_c=
ontext *smu,
                               *value =3D metrics->AverageUclkActivity;
                               break;
               case METRICS_AVERAGE_SOCKETPOWER:
-                              *value =3D metrics->AverageSocketPower << 8;
+                             /* Valid power data is available only from pr=
imary die */
+                             *value =3D aldebaran_is_primary(smu) ?
+                                                             metrics->Aver=
ageSocketPower << 8 :
+                                                             0;
                               break;
               case METRICS_TEMPERATURE_EDGE:
                               *value =3D metrics->TemperatureEdge *
@@ -1141,15 +1154,22 @@ static int aldebaran_get_power_limit(struct smu_con=
text *smu)
               if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
                               return -EINVAL;

-              ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit, &powe=
r_limit);
+             /* Valid power data is available only from primary die.
+             * For secondary die show the value as 0.
+             */
+             if (aldebaran_is_primary(smu)) {
+                             ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Get=
PptLimit,
+                                                                          =
      &power_limit);

-              if (ret) {
-                              /* the last hope to figure out the ppt limit=
 */
-                              if (!pptable) {
-                                              dev_err(smu->adev->dev, "Can=
not get PPT limit due to pptable missing!");
-                                              return -EINVAL;
+                             if (ret) {
+                                             /* the last hope to figure ou=
t the ppt limit */
+                                             if (!pptable) {
+                                                             dev_err(smu->=
adev->dev,
+                                                                          =
   "Cannot get PPT limit due to pptable missing!");
+                                                             return -EINVA=
L;
+                                             }
+                                             power_limit =3D pptable->PptL=
imit;
                               }
-                              power_limit =3D pptable->PptLimit;
               }

                smu->current_power_limit =3D smu->default_power_limit =3D p=
ower_limit;
@@ -1159,6 +1179,15 @@ static int aldebaran_get_power_limit(struct smu_cont=
ext *smu)
               return 0;
}

+static int aldebaran_set_power_limit(struct smu_context *smu, uint32_t n)
+{
+             /* Power limit can be set only through primary die */
+             if (aldebaran_is_primary(smu))
+                             return smu_v13_0_set_power_limit(smu, n);
+
+             return -EINVAL;
+}
+
static int aldebaran_system_features_control(struct  smu_context *smu, bool=
 enable)
{
               int ret;
@@ -1730,10 +1759,16 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu=
_context *smu,
               gpu_metrics->average_umc_activity =3D metrics.AverageUclkAct=
ivity;
               gpu_metrics->average_mm_activity =3D 0;

-              gpu_metrics->average_socket_power =3D metrics.AverageSocketP=
ower;
-              gpu_metrics->energy_accumulator =3D
+             /* Valid power data is available only from primary die */
+             if (aldebaran_is_primary(smu)) {
+                             gpu_metrics->average_socket_power =3D metrics=
.AverageSocketPower;
+                             gpu_metrics->energy_accumulator =3D
                                               (uint64_t)metrics.EnergyAcc6=
4bitHigh << 32 |
                                               metrics.EnergyAcc64bitLow;
+             } else {
+                             gpu_metrics->average_socket_power =3D 0;
+                             gpu_metrics->energy_accumulator =3D 0;
+             }

                gpu_metrics->average_gfxclk_frequency =3D metrics.AverageGf=
xclkFrequency;
               gpu_metrics->average_socclk_frequency =3D metrics.AverageSoc=
clkFrequency;
@@ -1898,7 +1933,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs=
 =3D {
               .get_enabled_mask =3D smu_cmn_get_enabled_mask,
               .feature_is_enabled =3D smu_cmn_feature_is_enabled,
               .disable_all_features_with_exception =3D smu_cmn_disable_all=
_features_with_exception,
-              .set_power_limit =3D smu_v13_0_set_power_limit,
+             .set_power_limit =3D aldebaran_set_power_limit,
               .init_max_sustainable_clocks =3D smu_v13_0_init_max_sustaina=
ble_clocks,
               .enable_thermal_alert =3D smu_v13_0_enable_thermal_alert,
               .disable_thermal_alert =3D smu_v13_0_disable_thermal_alert,
--
2.17.1


--_000_BN9PR12MB5368E5D295F3BAB6AF1AE290FC369BN9PR12MB5368namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Wednesday, June 9, 2021 15:09<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Kasiviswanathan, H=
arish &lt;Harish.Kasiviswanathan@amd.com&gt;; Deucher, Alexander &lt;Alexan=
der.Deucher@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Feng, Kennet=
h &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Only primary die supports power data<o:=
p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">On aldebaran, only primary die fetches valid power d=
ata. Show<o:p></o:p></p>
<p class=3D"MsoNormal">power/energy values as 0 on secondary die. Also, pow=
er limit should not<o:p></o:p></p>
<p class=3D"MsoNormal">be set through secondary die.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar &lt;<a href=3D"mailto:lijo=
.lazar@amd.com">lijo.lazar@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbs=
p;&nbsp; | 57 +++++++++++++++----<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 46 insertions(+), 11 deletions(-)<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/alde=
baran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index 6ee9c4186f02..6fd78871f272 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -510,6 +510,16 @@ static int aldebaran_freqs_in_s=
ame_level(int32_t frequency1,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (abs(frequency1 - frequency2) &lt;=
=3D EPSILON);<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+static bool aldebaran_is_primary(struct smu_context=
 *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<o:p></o:=
p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;smuio.funcs &amp;&amp; adev-&gt;smuio.fu=
ncs-&gt;get_die_id)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;smuio.funcs-&gt;=
get_die_id(adev) =3D=3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">static int aldebaran_get_smu_metrics_data(struct smu=
_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;MetricsMember_t membe=
r,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;uint32_t *value)<o:p>=
</o:p></p>
<p class=3D"MsoNormal">@@ -563,7 +573,10 @@ static int aldebaran_get_smu_me=
trics_data(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D metrics-&g=
t;AverageUclkActivity;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_AVERAGE_SOCKETPOWER:<o:p></o:=
p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D metrics-&gt;Ave=
rageSocketPower &lt;&lt; 8;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Valid power data is available=
 only from primary die */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D aldebaran_is_primary(=
smu) ?<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; metrics-&gt;AverageSocketPower &lt;&lt; 8 :<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_TEMPERATURE_EDGE:<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D metrics-&g=
t;TemperatureEdge *<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1141,15 +1154,22 @@ static int aldebaran_get_pow=
er_limit(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_cmn_feature_is_enabled(smu, SMU_F=
EATURE_PPT_BIT))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetPp=
tLimit, &amp;power_limit);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Valid power data is available only from primary di=
e.<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * For secondary die show the value as 0.<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (aldebaran_is_primary(smu)) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu=
, SMU_MSG_GetPptLimit,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &amp;power_limit);<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the last hope to figure=
 out the ppt limit */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pptable) {<o:p></o:p>=
</p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(smu-&gt;adev-&gt;dev, &quot;Cannot get PPT limit due to pptable missing!=
&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the last=
 hope to figure out the ppt limit */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pptabl=
e) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dev_err(smu-&gt;adev-&gt;dev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Cannot get PPT limit due to pptable mi=
ssing!&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; power_limit=
 =3D pptable-&gt;PptLimit;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; power_limit =3D pptable-&g=
t;PptLimit;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;current_power_limit =3D smu-=
&gt;default_power_limit =3D power_limit;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1159,6 +1179,15 @@ static int aldebaran_get_powe=
r_limit(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+static int aldebaran_set_power_limit(struct smu_con=
text *smu, uint32_t n)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Power limit can be set only through primary die */=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (aldebaran_is_primary(smu))<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_v13_0_set_power_limit=
(smu, n);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">static int aldebaran_system_features_control(struct&=
nbsp; smu_context *smu, bool enable)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1730,10 +1759,16 @@ static ssize_t aldebaran_get=
_gpu_metrics(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_umc_activity =3D m=
etrics.AverageUclkActivity;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_mm_activity =3D 0;=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_socket_power =3D metric=
s.AverageSocketPower;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;energy_accumulator =3D<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Valid power data is available only from primary di=
e */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (aldebaran_is_primary(smu)) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_socket_p=
ower =3D metrics.AverageSocketPower;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;energy_accumulat=
or =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(uint64_t)metrics.EnergyAcc64bitHigh &lt;&lt; 32 |<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
metrics.EnergyAcc64bitLow;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_socket_p=
ower =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;energy_accumulat=
or =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_gfxclk_frequ=
ency =3D metrics.AverageGfxclkFrequency;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_socclk_frequency =
=3D metrics.AverageSocclkFrequency;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1898,7 +1933,7 @@ static const struct pptable_fu=
ncs aldebaran_ppt_funcs =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_enabled_mask =3D smu_cmn_get_enabled_=
mask,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .feature_is_enabled =3D smu_cmn_feature_is=
_enabled,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_all_features_with_exception =3D s=
mu_cmn_disable_all_features_with_exception,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_limit =3D smu_v13_0_set_power_limit,=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .set_power_limit =3D aldebaran_set_power_limit,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_max_sustainable_clocks =3D smu_v13_0=
_init_max_sustainable_clocks,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_thermal_alert =3D smu_v13_0_enable=
_thermal_alert,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_thermal_alert =3D smu_v13_0_disab=
le_thermal_alert,<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB5368E5D295F3BAB6AF1AE290FC369BN9PR12MB5368namp_--

--===============1780795344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1780795344==--
