Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF04C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54A661966
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54A661966
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED0789FC0;
	Mon, 22 Mar 2021 05:57:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3CDE89FC0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 05:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVAhW1fwjeqs7mlsaFKxAelOh+B2m5UnhY0hBf5qzc0DXM8AMuUQbMfAl0ymUHs+TYErYfgz1Q9Rm5PqW+Q5rs9P7Nfail3rHtrqBmGVK50Plj9pa3Gy7XgWzvVF3u6MB+XHpObs5MNrUqa+h3kMf8Va5w7wUVvhZl2X6ZYo+fzO5LZBtyFFjky4+BQhK/d04sZhJ3d4GPcz/VBVGWvEgSW9VGBc95ezZrhjC1KmxuVFtE04CUvX1er4wnZ9sS3XJ38dsUFoGefsjGfWhmbRYPkAnie94RuYYX84LgWCwc6SzRUcfhU/EWn3RE+tOT5R8rXzIr/WBm99LG3eQB8cKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5HQR9VMh2Z1TmXQfgYtb2xhzPxgD3FpaCWXaGKAIlw=;
 b=fwbYZI+i6kAu3548VfQiNENaroym9B1/xQIVKU1dJ4dIkdG6EHjllhNBex31DlDTon86pTIGei2J/dyWANx87e43/fTBrZ/ng/C9u4a86/RA7dDx/au3OJSLcG7926xYEIi/VDKgPlc2UbsjTtFftSBzTR0NQ0EpuZRHZoeylRH6BduIxOw8/E9gfQq46kfFr0Txv0PamL5D3WwrqBtg4bJGo/TxfZu1woRas56k1leq4AgceLVt4jK1JNUlkwFemCcAd2kA/jkFPnbxm0lQxEQnmVIwdw/Ian6/v2765p/lPu6NW3GwIcSGaXS6A2C9vlZ95Yq5ypRchSeLzfMzUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5HQR9VMh2Z1TmXQfgYtb2xhzPxgD3FpaCWXaGKAIlw=;
 b=Ln0EYuGGZBERNgpQ037vPhr/HpwAORjRvTu4+iWOO0JKAZOioRaZM59zLbcNIow5XIvSYz/Hfyq1vvwulx6cyL42fwdehlb6zi1bGlUYHlUE/b4N1Uyk536lmiZQzX2So5Wy7mzUsl034jYtGcJddUKzyosUicQbCQ7BQbgz9mc=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 05:57:13 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 05:57:13 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/8] drm/amd/pm: Modify mode2 msg sequence on aldebaran
Thread-Topic: [PATCH v2 1/8] drm/amd/pm: Modify mode2 msg sequence on aldebaran
Thread-Index: Adce3yV1ycicod9dTSSqc93cZafgpA==
Date: Mon, 22 Mar 2021 05:57:13 +0000
Message-ID: <MN2PR12MB45495479CDDD90B1FDFD468D97659@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T05:57:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=64e797ae-da8c-4043-a3d6-d642cce70754;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.224.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 881a4e7f-bee2-4578-c2ac-08d8ecf75720
x-ms-traffictypediagnostic: MN2PR12MB4302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB430288FEF1D1D48EA47AFE4D97659@MN2PR12MB4302.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v8E8o4eCH8EBufEZiyrkjBnfATCYG+Zfc4HmBekEMgAg7hrKyBzJm6bnu1vgLc7Ov+vQlSTRRsT6n8HxSuiCBTc2LkJaKclhTWFajukfJ1T8XFvoYx2Hz+RyQ7IWdqgRF89zZ2o2MocutnomTR7Rt8T0aHEiKm13omRc2VBDfzfgrnIAf02Kef5DHLv2UXU/3/OlPG1UTx7G45Lzt/e+y4ORjsl6g5VWrQfNjHNpUPValsX1NZTTaW10n3eEjW3CqzX6zWkKZtws+nQSLOzQ80vphxsvVGeHYp8pMPN6pbh/DZG3//vY4D/xdDbNoNeqYpol6QAWJptIAH/Y5ADazQALlDQ8dZVfl9R2Ls/Voh3r1yYnZ3r0GqfSZ6y+Bkh5ZA1TCOwq8ADA/aEJ9nkK6oeryEo2FMzhINxewj1cH1rkEW+ACr15nWkTqZOj0ANRCBA1LvqwWCsQ1pvnKLHuwk5Ugq53k1LnfcQs8uM+gBTlJ9hNpiMC8DitOM9fBD1sKWxl5ndDuvSrZMMkCccF27Hl2pXIGQ/OxWwsf0y1zjzO9hStJb63oXSANavPv2N0YUz88SgVj678c1frO3vPVDo2B24jE9prg0n7B5BKeAGhlBY1i8tdpbFrhDEsj7wBoKpsAkV8veeSS3PsOx8I1gsSow+bA2m3sWWAwjjpwSk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(64756008)(66476007)(55236004)(33656002)(66946007)(38100700001)(6506007)(8936002)(5660300002)(4326008)(54906003)(186003)(76116006)(83380400001)(7696005)(66446008)(66556008)(8676002)(71200400001)(2906002)(52536014)(55016002)(26005)(478600001)(316002)(6916009)(86362001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?scsyJjpA6cNm2nPYvHgDkbp3refoUfBDVzjkRDDeRnFBstmHkIxAln6jSqGN?=
 =?us-ascii?Q?NYoEVQOXieiMn5eoaLGiQcULf/Hk8TVrDqDlObpjYKRdmhr+guGIAVZ0NJ02?=
 =?us-ascii?Q?PXS2M9Ql9Q2O1Cqs/yisqQuZ0I0wPvs5wXnc+/R7yGh4JdrDIZE4h5fM1tqz?=
 =?us-ascii?Q?aqHziXjarIv4GlAuvfdQ2nSYHQYSyuCShIL+00EUaaGhrqw1OcgZeFIOQtAB?=
 =?us-ascii?Q?nRwy2uVHwPtEWsRGKplHPKxHIWebaX3uyd04vQqqsG6MYtQw1WrF2dyl86me?=
 =?us-ascii?Q?LAnIosRPFn73De/4GYpIX8KyeKVFd4W1TyAPOa6oT5v6Gt2aZ/ayXR8sfq1G?=
 =?us-ascii?Q?ohHoplG6rkYYil1V2CUl4horM+QAneXdjWTunpOU092cxZ82dzo+sP8LZB9I?=
 =?us-ascii?Q?H0HQ6u4/mPtKgDfIVrjiBOewHGZIGYtUmd5bPCaef8urEf4WVwuUL+QPJDaq?=
 =?us-ascii?Q?bFQ43Whjc39B8PC4b9r4lJJxdW8bOlNbDowteS7w3h07o1BDl4l5NNwlJH03?=
 =?us-ascii?Q?0TnLq9ZWwqCrG0PE6m15VbWB1zCiB8j5sFLvZEAjpexasXTF/MpINhI3URKV?=
 =?us-ascii?Q?+FUysu1yANn6DdhRSr6GJSV85Ust/J0pNcIq1ofAdRsrmkjYncDeubltqRvn?=
 =?us-ascii?Q?iiH1SFSZMoPbGECmB9lI6Jen7Tk6KuPRnKkAlQt+v3vQ2WkoFgpzYWFCG/Oa?=
 =?us-ascii?Q?Ad5xbwsW3DHg/NvnKyepGhA/lCqn6e8dHlK5VQglM1dpD0f5Yb5stcwz0o7a?=
 =?us-ascii?Q?jLJPJ52qo4W4xtbigAkvkNOtF/qm9TbnHl/qetVY1swvEBx1Y8DCg2vIxN/X?=
 =?us-ascii?Q?w/sJJxZbxJZ6qCq4lSKxQbdmPAptSjGv5QKJgIPGQahPik31TxH8V1MeWP3h?=
 =?us-ascii?Q?5UpAxx/uVVg7new1S2Ls05lqHJ+dA23ZKp2HMFXF/nXW7UurXIPa8Jqb+a9e?=
 =?us-ascii?Q?Kp//th4nYn/GPhW2GyzIqZkJyFo8t6mLgilZXe5UEiW63o2PV+reIIFne/bv?=
 =?us-ascii?Q?d7XDrPvtiEk0UihE7i2yjqZGV7jwwi4/PUhBWNjbWIoZKhtC5Q9bJgtzw8zh?=
 =?us-ascii?Q?Mbyy3ZZ2be0EKV5x/jI2Kyvbuzk65QPSs7qrvjevQLpj7I8RaIsSt6T3Rnd3?=
 =?us-ascii?Q?Ak7lryyt/VVdoJI7AWxBQCzRJKEiTFZlvFg3gC57lawJGu+vZdolDpL8UYxV?=
 =?us-ascii?Q?oot8ECgCog2Y/HRW/4QttoTgRcq1Cog5dPdyYjAom7y/vHXBpkO2X3k0d2y5?=
 =?us-ascii?Q?hwLWeca/ENQ/MkG/84vDUm3rWXBjAkGrttlqQtFW/Gw9JxRV85+PyRSLN1MN?=
 =?us-ascii?Q?/zRAYVY3r9Pwpxn1oacOqM6R?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881a4e7f-bee2-4578-c2ac-08d8ecf75720
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 05:57:13.3566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uk6yJgVytU03FZBeGL7VTE6CybFrxuHMeISI8Myr5WILUmeAAMv/d5zAOBzSPU1Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Zeng, Oak" <Oak.Zeng@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0871342064=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0871342064==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45495479CDDD90B1FDFD468D97659MN2PR12MB4549namp_"

--_000_MN2PR12MB45495479CDDD90B1FDFD468D97659MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

v1: During mode2 reset, PCI space is lost after message is sent.
Restore PCI space before waiting for response from firmware.

v2: Move mode2 sequence to aldebaran and update PMFW version.
Handle generic sequence in smu13 without PMFW version check.

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 53 ++++++++++++++++++-
.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 15 +++---
drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  2 +-
drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
4 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7d38b92a78dc..ec485308b921 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1432,6 +1432,57 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_=
context *smu,
               return sizeof(struct gpu_metrics_v1_1);
}
+int aldebaran_mode2_reset(struct smu_context *smu)
+{
+             u32 smu_version;
+             int ret =3D 0, index;
+             struct amdgpu_device *adev =3D smu->adev;
+             int timeout =3D 10;
+
+             smu_cmn_get_smc_version(smu, NULL, &smu_version);
+
+             index =3D smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPIN=
G_MSG,
+                                                                          =
                   SMU_MSG_GfxDeviceDriverReset);
+
+             mutex_lock(&smu->message_lock);
+             if (smu_version >=3D 0x00441400) {
+                             ret =3D smu_cmn_send_msg_without_waiting(smu,=
 (uint16_t)index, SMU_RESET_MODE_2);
+                             /* This is similar to FLR, wait till max FLR =
timeout */
+                             msleep(100);
+                             dev_dbg(smu->adev->dev, "restore config space=
...\n");
+                             /* Restore the config space saved during init=
 */
+                             amdgpu_device_load_pci_state(adev->pdev);
+
+                             dev_dbg(smu->adev->dev, "wait for reset ack\n=
");
+                             while (ret =3D=3D -ETIME && timeout)  {
+                                             ret =3D smu_cmn_wait_for_resp=
onse(smu);
+                                             /* Wait a bit more time for g=
etting ACK */
+                                             if (ret =3D=3D -ETIME) {
+                                                             --timeout;
+                                                             usleep_range(=
500, 1000);
+                                                             continue;
+                                             }
+
+                                             if (ret !=3D 1) {
+                                                             dev_err(adev-=
>dev, "failed to send mode2 message \tparam: 0x%08x response %#x\n",
+                                                                          =
                   SMU_RESET_MODE_2, ret);
+                                                             goto out;
+                                             }
+                             }
+
+             } else {
+                             dev_err(adev->dev, "smu fw 0x%x does not supp=
ort MSG_GfxDeviceDriverReset MSG\n",
+                                                             smu_version);
+             }
+
+             if (ret =3D=3D 1)
+                             ret =3D 0;
+out:
+             mutex_unlock(&smu->message_lock);
+
+             return ret;
+}
+
static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
{
#if 0
@@ -1530,8 +1581,8 @@ static const struct pptable_funcs aldebaran_ppt_funcs=
 =3D {
               .mode1_reset_is_support =3D aldebaran_is_mode1_reset_support=
ed,
               .mode2_reset_is_support =3D aldebaran_is_mode2_reset_support=
ed,
               .mode1_reset =3D smu_v13_0_mode1_reset,
-              .mode2_reset =3D smu_v13_0_mode2_reset,
               .set_mp1_state =3D aldebaran_set_mp1_state,
+             .mode2_reset =3D aldebaran_mode2_reset,
};
 void aldebaran_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index bd3a9c89dc44..fa0d8ca29982 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1376,17 +1376,14 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
 int smu_v13_0_mode2_reset(struct smu_context *smu)
{
-              u32 smu_version;
-              int ret =3D 0;
-              struct amdgpu_device *adev =3D smu->adev;
-              smu_cmn_get_smc_version(smu, NULL, &smu_version);
-              if (smu_version >=3D 0x00440700)
-                              ret =3D smu_cmn_send_smc_msg_with_param(smu,=
 SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
-              else
-                              dev_err(adev->dev, "smu fw 0x%x does not sup=
port MSG_GfxDeviceDriverReset MSG\n", smu_version);
-              /*TODO: mode2 reset wait time should be shorter, will modify=
 it later*/
+             int ret;
+
+             ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDevic=
eDriverReset,
+                                             SMU_RESET_MODE_2, NULL);
+             /*TODO: mode2 reset wait time should be shorter, add ASIC spe=
cific func if required */
               if (!ret)
                               msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
+
               return ret;
}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 2d216f5b167d..b725f263092b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -76,7 +76,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
               *arg =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
}
-static int smu_cmn_wait_for_response(struct smu_context *smu)
+int smu_cmn_wait_for_response(struct smu_context *smu)
{
               struct amdgpu_device *adev =3D smu->adev;
               uint32_t cur_value, i, timeout =3D adev->usec_timeout * 10;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index 155e2a68fa1c..da6ff6f024f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -37,6 +37,8 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
                                                enum smu_message_type msg,
                                                uint32_t *read_arg);
+int smu_cmn_wait_for_response(struct smu_context *smu);
+
int smu_cmn_to_asic_specific_index(struct smu_context *smu,
                                                                  enum smu_=
cmn2asic_mapping_type type,
                                                                  uint32_t =
index);
--
2.17.1


--_000_MN2PR12MB45495479CDDD90B1FDFD468D97659MN2PR12MB4549namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">v1: During mode2 reset, PCI space is lost after mess=
age is sent.<o:p></o:p></p>
<p class=3D"MsoNormal">Restore PCI space before waiting for response from f=
irmware.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">v2: Move mode2 sequence to aldebaran and update PMFW=
 version.<o:p></o:p></p>
<p class=3D"MsoNormal">Handle generic sequence in smu13 without PMFW versio=
n check.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbs=
p;&nbsp; | 53 ++++++++++++++++++-<o:p></o:p></p>
<p class=3D"MsoNormal">.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbs=
p;&nbsp; | 15 +++---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +<o:p></o:p></p>
<p class=3D"MsoNormal">4 files changed, 61 insertions(+), 11 deletions(-)<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/alde=
baran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index 7d38b92a78dc..ec485308b921 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1432,6 +1432,57 @@ static ssize_t aldebaran_get_=
gpu_metrics(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_metrics_v1_1);<o:=
p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+int aldebaran_mode2_reset(struct smu_context *smu)<=
o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; u32 smu_version;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int ret =3D 0, index;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int timeout =3D 10;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_cmn_get_smc_version(smu, NULL, &amp;smu_version);=
<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; index =3D smu_cmn_to_asic_specific_index(smu, CMN2ASI=
C_MAPPING_MSG,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_GfxDeviceDriver=
Reset);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;message_lock);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (smu_version &gt;=3D 0x00441400) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_msg_without=
_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This is similar to FLR, wait =
till max FLR timeout */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(100);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(smu-&gt;adev-&gt;dev, &q=
uot;restore config space...\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Restore the config space save=
d during init */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_load_pci_state(ade=
v-&gt;pdev);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(smu-&gt;adev-&gt;dev, &q=
uot;wait for reset ack\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (ret =3D=3D -ETIME &amp;&a=
mp; timeout)&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu=
_cmn_wait_for_response(smu);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait a b=
it more time for getting ACK */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=
=3D -ETIME) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; --timeout;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; usleep_range(500, 1000);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; continue;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret !=
=3D 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dev_err(adev-&gt;dev, &quot;failed to send mode2 message \tparam:=
 0x%08x response %#x\n&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_RESET_MODE_2, ret);=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; goto out;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;smu =
fw 0x%x does not support MSG_GfxDeviceDriverReset MSG\n&quot;,<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; smu_version);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D 1)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+out:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;message_lock);<o:p></o:p></=
p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">static bool aldebaran_is_mode1_reset_supported(struc=
t smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">#if 0<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1530,8 +1581,8 @@ static const struct pptable_fu=
ncs aldebaran_ppt_funcs =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset_is_support =3D aldebaran_is_m=
ode1_reset_supported,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode2_reset_is_support =3D aldebaran_is_m=
ode2_reset_supported,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset =3D smu_v13_0_mode1_reset,<o:=
p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .mode2_reset =3D smu_v13_0_mode2_reset,<o:p></o=
:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D aldebaran_set_mp1_state=
,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .mode2_reset =3D aldebaran_mode2_reset,<o:p></o:p></p=
>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;void aldebaran_set_ppt_funcs(struct smu_contex=
t *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_=
v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index bd3a9c89dc44..fa0d8ca29982 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1376,17 +1376,14 @@ int smu_v13_0_mode1_reset(st=
ruct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;int smu_v13_0_mode2_reset(struct smu_context *=
smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; u32 smu_version;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<o:=
p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_get_smc_version(smu, NULL, &amp;smu_ver=
sion);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_version &gt;=3D 0x00440700)<o:p></o:p><=
/p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_m=
sg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);<o=
:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quo=
t;smu fw 0x%x does not support MSG_GfxDeviceDriverReset MSG\n&quot;, smu_ve=
rsion);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /*TODO: mode2 reset wait time should be shorter=
, will modify it later*/<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_=
GfxDeviceDriverReset,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_RESET_M=
ODE_2, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*TODO: mode2 reset wait time should be shorter, add =
ASIC specific func if required */<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(SMU13_MODE1_RE=
SET_WAIT_TIME_IN_MS);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c =
b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 2d216f5b167d..b725f263092b 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -76,7 +76,7 @@ static void smu_cmn_read_arg(struc=
t smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *arg =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_82);<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-static int smu_cmn_wait_for_response(struct smu_con=
text *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">+int smu_cmn_wait_for_response(struct smu_context *s=
mu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;ade=
v;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cur_value, i, timeout =3D adev-&g=
t;usec_timeout * 10;<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h =
b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 155e2a68fa1c..da6ff6f024f9 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<o:p></o=
:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -37,6 +37,8 @@ int smu_cmn_send_smc_msg(struct sm=
u_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;enum smu_message_type msg,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;uint32_t *read_arg);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+int smu_cmn_wait_for_response(struct smu_context *s=
mu);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">int smu_cmn_to_asic_specific_index(struct smu_contex=
t *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;enum smu_cmn2asic_mapping_type type,=
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;uint32_t index);<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB45495479CDDD90B1FDFD468D97659MN2PR12MB4549namp_--

--===============0871342064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0871342064==--
