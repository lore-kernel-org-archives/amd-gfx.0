Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D9AC4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 11:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1108823A33
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 11:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1108823A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C3C6E96F;
	Tue,  8 Dec 2020 11:43:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502F16E975
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 11:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loNeJ+qVkuDLID/K4BOfr2EdZplDX0VlTy02hTkU0U+IkdCMJiVm6wrSYxyULDdYZ01g3rSqNWiVIkdMe5hnCYbck199FM/tUNnucrxY+n5vegS4+tmHdnh0rbhQkqiVd/KnC25AggDlw/ytjMLWrxnbQofv4lutwakMxPFo4cfpFriE4CFzC/2vICqDj9+l5P3YzGEfsxMtdBce6o2Yc95kBHcVzBWbCw92Qwye6oUVGKWh+GRLYaIL21ct7HUhXN0FgIPMERetD68kAxtqSc+VumzfXhrE9oH1A14jU/GOZmVb65pgZUkmiITgWPB4UFuKOwkGoOuRi00VxyTpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZpl+toBJK4WUaRIleZD9HrB6Jd6q/ERQhbuF18WCeM=;
 b=fZC7Rc4l6Tje5xfvX8FjF6eMJMu3JqxMkR2f0LDrFwYWTpqHSHSU/s/SZlZFjvFKYGFUwEyN+Et13c7DbNxUM/1VwcLW0H3JoXkYc7M6NY5tWC11jJ7lVkbub32HTxAIvQISIoCwYpBuFRihp2y+dmg9tuWTVVLnzExiiYwlcLZ2U7wH4t0VeUSb3EPfzuZtHpi2/LDHIaYvDCoIYpeGEPlxQTkdaOak4lx3XlJwQY7SSGS/YjAOSnDxfCcY596nJYzg7N/Z0c9v8zeqSdJ5Ij9bCA5O2kDL8grFBd5XfPWDwxcK4O7iWvFXMzw1CYUYlAqzVml4PUSFku1cqkgmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZpl+toBJK4WUaRIleZD9HrB6Jd6q/ERQhbuF18WCeM=;
 b=WyDaCMSeLGdJp+Bsm7jHc9TIX83PQldgZPYsUgNjHj8xdyx6X+XzAhy+wQtEvnOlZEjR7/9r/aqSK44jcwu78iEMY0uUZRZ7JgSGK3mkhLEmTl4/wqg/kKOIXsGCf5NDa37t4ZXWMRZun52XayyL/ksAmBVrcNjYacoz8Kl2GKc=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3469.namprd12.prod.outlook.com (2603:10b6:208:ca::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 11:43:27 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3654.012; Tue, 8 Dec 2020
 11:43:27 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amd/pm: add interface to notify RLC status for
 vangogh
Thread-Topic: [PATCH 2/3] drm/amd/pm: add interface to notify RLC status for
 vangogh
Thread-Index: AQHWzVQqfS85SRBLVUGjSms9w9o++KntExCo
Date: Tue, 8 Dec 2020 11:43:27 +0000
Message-ID: <MN2PR12MB3022C989D9B434BD2AAB3BA8A2CD0@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20201208111942.6292-1-Xiaomeng.Hou@amd.com>,
 <20201208111942.6292-2-Xiaomeng.Hou@amd.com>
In-Reply-To: <20201208111942.6292-2-Xiaomeng.Hou@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-08T11:43:26.406Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f6f3320-6a43-4dbf-14c5-08d89b6e7a47
x-ms-traffictypediagnostic: MN2PR12MB3469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3469DB194A676F9324D39AE1A2CD0@MN2PR12MB3469.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rM937gL/6ioOuPyXgkRLM6eNglFP9xLiKtzEns5hupEpcR/QRblRxPeDhysFZ+MnVItQgkboPnjlKClTczX3Smb5d7y7AlbDfJCSXAy7vnULv6BeWQ2dbJg5vcvwfPMMIoWmZ0CDh9ntqWqsCgy/bBT6Fg4PnlMn3JML+2vOQDlNzewuhWD1Zl/2NI4qEm1szb7J0k81F4fxV7my+coA3IUfq2mbtA9FUZXLA0e+/o1bMCwk05/MsSNpPA+92xJFaawm1/8QVSsdyBEhrtQqVa4b29vzoNLyHpeYFagYl3+F0JvtEgAtUDUbjlrVTzweLCaRmZ6DNBPG8H99pLqUuIQFbIL5y9BLvBDziysEUmU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(64756008)(66476007)(66446008)(66556008)(66946007)(33656002)(9686003)(76116006)(26005)(2906002)(53546011)(6506007)(7696005)(478600001)(186003)(8676002)(19627405001)(166002)(83380400001)(8936002)(52536014)(91956017)(55016002)(316002)(54906003)(71200400001)(5660300002)(86362001)(4326008)(45080400002)(110136005)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?JyRUIWvDtul1HvBWkdY0yYqj5jBPKpUsU7MTfL4wdT+BmfDyU1mRw7uq49?=
 =?iso-8859-1?Q?ZTw4K3GOk0ptCPiAdZWknSsyLy2zQFw69gmR3bMphmzQw42mdVZI9ECPX2?=
 =?iso-8859-1?Q?r6iKpR35yhbA1J289LQXs1SQYROX8lW8W433xk+mG00GQxJ1Hc9FFUSU1p?=
 =?iso-8859-1?Q?hRq4+lQrDwAS12nk+NEksrSPIYOcC4wS0xkNzjwcBitp4qODOw1mvtvfmz?=
 =?iso-8859-1?Q?3IuELf8Td6/nURaM1+7FmRPmILf5/kiZBd7QQNsiPO9DTyV5XzBMvMomOc?=
 =?iso-8859-1?Q?cwTmsQ7BV7VBEe0zFrNnybYqD0hv//ewuF7vFVAn+QOivbFCSbXA8H5wlb?=
 =?iso-8859-1?Q?mxiWHbZEGy8g/Y3JRcGwDBADtdEf/KwaHR7zVAk+CsBgFa0PUZ/qzhKUex?=
 =?iso-8859-1?Q?NoUaR1DswwjbqE+1nWEOLDQJYO0NFARS8/veT5bq0CyYruz6fJluwJqQER?=
 =?iso-8859-1?Q?ujOEOSxkaOKzIz9rcVjxP1qfgOpR03n3GKzqM8p/18G4a9GzsDkr0as13E?=
 =?iso-8859-1?Q?ILQqw4w+grCvr7W5OrQQ9urhg56zKWqBG23i1VdIZp4vAkjHLp0vMtjrEy?=
 =?iso-8859-1?Q?mbWanY882+yocPtjxDs0fLDEM4MVmyqBEMkL+OBQavCz6ZEXAclezkmBMG?=
 =?iso-8859-1?Q?ETMtt0NBzUIassOgeD9lJgvaylyP9DWWS0yEUsR0V9ltC34cv8QF6fsT+b?=
 =?iso-8859-1?Q?aT+j4p8QNSzLbgYp8HJIZofxISXMOCg6OKWlGvwNQx5GrKRqjOCZ2GJ4ji?=
 =?iso-8859-1?Q?z7BiKkzc+R57mL68oQgn/SDMUI8B8enduMVXSPgvEJ/jY4EZ/amaloH4NX?=
 =?iso-8859-1?Q?IA6buOh0x/fWlcbt9cOBek2LMNXTSagucdE6CxZu1IUW4CFgSHEz9tDKsj?=
 =?iso-8859-1?Q?16yQJ5Pg+Fo1RynmNXfBss/guCVkBVYhXE3GbssvuJp/vob061fGNpvS/3?=
 =?iso-8859-1?Q?+Hakll3+xtJ9+twi5b7WImq44v6uwn5CFysuLiJfZHBf1W2LmNZNdLm5KE?=
 =?iso-8859-1?Q?TestoBB4c0cnxIPSQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6f3320-6a43-4dbf-14c5-08d89b6e7a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 11:43:27.2012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRgqrdJhDQQPYIY4acD7yjXT7VSUithe3Ea84FLtc77rahKUP4dh+6aauo5NFKGL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3469
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============0354971049=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0354971049==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022C989D9B434BD2AAB3BA8A2CD0MN2PR12MB3022namp_"

--_000_MN2PR12MB3022C989D9B434BD2AAB3BA8A2CD0MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Xiaomeng=
 Hou <Xiaomeng.Hou@amd.com>
Sent: Tuesday, December 8, 2020 7:19 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Quan, Evan <Evan.Q=
uan@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: add interface to notify RLC status for van=
gogh

Add this interface to notify PMFW the status (Normal/Off) of RLC engine.

Before notify RLC status normal, need check its current status first. Send =
the
message only when current status is still off.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Change-Id: I2f1a7de23df7315a7b220ba6d0a4bcaa75c93fea
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 24 ++++++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h  |  4 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 13 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
 6 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 89be49a43500..0da00a92b478 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -583,6 +583,7 @@ struct pptable_funcs {
         int (*gpo_control)(struct smu_context *smu, bool enablement);
         int (*gfx_state_change_set)(struct smu_context *smu, uint32_t stat=
e);
         int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu)=
;
+       int (*notify_rlc_status)(struct smu_context *smu, uint32_t status);
 };

 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index ddaa6a705fa6..03c2cd7a52a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -64,7 +64,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SM=
U_MSG_MAX_COUNT] =3D {
         MSG_MAP(PowerUpIspByTile,               PPSMC_MSG_PowerUpIspByTile=
,             0),
         MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,   =
              0),
         MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,     =
              0),
-       MSG_MAP(Spare,                          PPSMC_MSG_spare,           =
                     0),
+       MSG_MAP(RlcPowerNotify,                 PPSMC_MSG_RlcPowerNotify,  =
             0),
         MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,  =
              0),
         MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk=
,             0),
         MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNot=
ify,          0),
@@ -722,6 +722,27 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(=
struct smu_context *smu)
         return 0;
 }

+static int vangogh_notify_rlc_status(struct smu_context *smu, uint32_t sta=
tus)
+{
+       int ret =3D 0;
+
+       switch (status)
+       {
+       case RLC_STATUS_OFF:
+               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPow=
erNotify, status, NULL);
+               break;
+       case RLC_STATUS_NORMAL:
+               if (smu_cmn_get_rlc_status(smu) =3D=3D 0)
+                       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MS=
G_RlcPowerNotify, status, NULL);
+               break;
+       default:
+               dev_err(smu->adev->dev, "Unknown rlc status\n");
+               return -EINVAL;
+       }
+
+       return ret;
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs =3D {

         .check_fw_status =3D smu_v11_0_check_fw_status,
@@ -750,6 +771,7 @@ static const struct pptable_funcs vangogh_ppt_funcs =3D=
 {
         .print_clk_levels =3D vangogh_print_fine_grain_clk,
         .set_default_dpm_table =3D vangogh_set_default_dpm_tables,
         .set_fine_grain_gfx_freq_parameters =3D vangogh_set_fine_grain_gfx=
_freq_parameters,
+       .notify_rlc_status =3D vangogh_notify_rlc_status,
 };

 void vangogh_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
index 8756766296cd..eab455493076 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
@@ -32,4 +32,8 @@ extern void vangogh_set_ppt_funcs(struct smu_context *smu=
);
 #define VANGOGH_UMD_PSTATE_SOCCLK       678
 #define VANGOGH_UMD_PSTATE_FCLK         800

+/* RLC Power Status */
+#define RLC_STATUS_OFF          0
+#define RLC_STATUS_NORMAL       1
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index f8260769061c..2f3e66b03dd2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -42,6 +42,9 @@
  * They share the same definitions and values. That makes common
  * APIs for SMC messages issuing for all ASICs possible.
  */
+#define mmMP1_SMN_C2PMSG_63                                               =
                             0x027f
+#define mmMP1_SMN_C2PMSG_63_BASE_IDX                                      =
                             0
+
 #define mmMP1_SMN_C2PMSG_66                                               =
                             0x0282
 #define mmMP1_SMN_C2PMSG_66_BASE_IDX                                      =
                             0

@@ -731,3 +734,13 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,

         return ret;
 }
+
+int smu_cmn_get_rlc_status(struct smu_context *smu)
+{
+       struct amdgpu_device *adev =3D smu->adev;
+       uint32_t val;
+
+       val =3D RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_63);
+
+       return val;
+}

[kevin]:

these are not common code for whole smu driver, please move it to ppt.c fil=
e.

\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index 01e825d83d8d..7584089ef15f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -95,5 +95,7 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
                               void *metrics_table,
                               bool bypass_cache);

+int smu_cmn_get_rlc_status(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/=
amd/pm/swsmu/smu_internal.h
index 68d9464ababc..8ef3713f7f3c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -91,6 +91,7 @@
 #define smu_post_init(smu)                                              sm=
u_ppt_funcs(post_init, 0, smu)
 #define smu_gpo_control(smu, enablement)                                sm=
u_ppt_funcs(gpo_control, 0, smu, enablement)
 #define smu_set_fine_grain_gfx_freq_parameters(smu)                       =
              smu_ppt_funcs(set_fine_grain_gfx_freq_parameters, 0, smu)
+#define smu_notify_rlc_status(smu, status)                                =
     smu_ppt_funcs(notify_rlc_status, 0, smu, status)

 #endif
 #endif
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7Cf740746f29d14d4777e808d89b6b4971%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637430232414406734%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DVP=
Gv9GuTb22ZkzKp98iG3ibpG7BSwKaw%2FBT%2F6DFDnSs%3D&amp;reserved=3D0

--_000_MN2PR12MB3022C989D9B434BD2AAB3BA8A2CD0MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Xiaomeng Hou &lt;Xiaomeng.Hou=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 8, 2020 7:19 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Hou, Xiaomeng (Matthew) &lt;Xiaomeng.Hou@amd.co=
m&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/3] drm/amd/pm: add interface to notify RLC status =
for vangogh</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Add this interface to notify PMFW the status (Norm=
al/Off) of RLC engine.<br>
<br>
Before notify RLC status normal, need check its current status first. Send =
the<br>
message only when current status is still off.<br>
<br>
Signed-off-by: Xiaomeng Hou &lt;Xiaomeng.Hou@amd.com&gt;<br>
Change-Id: I2f1a7de23df7315a7b220ba6d0a4bcaa75c93fea<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 1 +<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp; | 24 +++++++++++++=
+++++-<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h&nbsp; |&nbsp; 4 ++++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 13 ++++++++++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 ++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_internal.h&nbsp;&nbsp; |&nbsp; 1 +<b=
r>
&nbsp;6 files changed, 44 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h<br>
index 89be49a43500..0da00a92b478 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -583,6 +583,7 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*gpo_control)(struct =
smu_context *smu, bool enablement);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*gfx_state_change_set=
)(struct smu_context *smu, uint32_t state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fine_grain_gfx_f=
req_parameters)(struct smu_context *smu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_rlc_status)(struct smu_c=
ontext *smu, uint32_t status);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;typedef enum {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index ddaa6a705fa6..03c2cd7a52a9 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -64,7 +64,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SM=
U_MSG_MAX_COUNT] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PowerUpIspByTile,&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_PowerUpIspByTile,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PowerDownVcn,&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PowerDownVcn,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PowerUpVcn,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PowerUpVcn,&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(Spare,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_spare,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(RlcPowerNotify,&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; PPSMC_MSG_RlcPowerNotify,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetHardMinVcn,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetHardMinVcn,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMinGfxclk,&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_SetSoftMinGfxclk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ActiveProcessNotif=
y,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_=
MSG_ActiveProcessNotify,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0),<br>
@@ -722,6 +722,27 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(=
struct smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int vangogh_notify_rlc_status(struct smu_context *smu, uint32_t sta=
tus)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (status)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RLC_STATUS_OFF:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNot=
ify, status, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RLC_STATUS_NORMAL:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (smu_cmn_get_rlc_status(smu) =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_=
send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify, status, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Unknown rlc status\n&quot;);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;static const struct pptable_funcs vangogh_ppt_funcs =3D {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_status =3D smu_v=
11_0_check_fw_status,<br>
@@ -750,6 +771,7 @@ static const struct pptable_funcs vangogh_ppt_funcs =3D=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clk_levels =3D vang=
ogh_print_fine_grain_clk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_dpm_table =3D=
 vangogh_set_default_dpm_tables,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fine_grain_gfx_freq_p=
arameters =3D vangogh_set_fine_grain_gfx_freq_parameters,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_rlc_status =3D vangogh_notify=
_rlc_status,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void vangogh_set_ppt_funcs(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.h<br>
index 8756766296cd..eab455493076 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h<br>
@@ -32,4 +32,8 @@ extern void vangogh_set_ppt_funcs(struct smu_context *smu=
);<br>
&nbsp;#define VANGOGH_UMD_PSTATE_SOCCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 678<br>
&nbsp;#define VANGOGH_UMD_PSTATE_FCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 800<br>
&nbsp;<br>
+/* RLC Power Status */<br>
+#define RLC_STATUS_OFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0<br>
+#define RLC_STATUS_NORMAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
+<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index f8260769061c..2f3e66b03dd2 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -42,6 +42,9 @@<br>
&nbsp; * They share the same definitions and values. That makes common<br>
&nbsp; * APIs for SMC messages issuing for all ASICs possible.<br>
&nbsp; */<br>
+#define mmMP1_SMN_C2PMSG_63&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x027f<br>
+#define mmMP1_SMN_C2PMSG_63_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+<br>
&nbsp;#define mmMP1_SMN_C2PMSG_66&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0282<br>
&nbsp;#define mmMP1_SMN_C2PMSG_66_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;<br>
@@ -731,3 +734,13 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
+<br>
+int smu_cmn_get_rlc_status(struct smu_context *smu)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15_NO_KIQ(MP1, 0, m=
mMP1_SMN_C2PMSG_63);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return val;<br>
+}</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">these are not common code for whole smu driver, pl=
ease move it to ppt.c file.</div>
<div class=3D"PlainText"><br>
\ No newline at end of file<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h<br>
index 01e825d83d8d..7584089ef15f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
@@ -95,5 +95,7 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *metrics_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool bypass_cache);<br>
&nbsp;<br>
+int smu_cmn_get_rlc_status(struct smu_context *smu);<br>
+<br>
&nbsp;#endif<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/=
amd/pm/swsmu/smu_internal.h<br>
index 68d9464ababc..8ef3713f7f3c 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
@@ -91,6 +91,7 @@<br>
&nbsp;#define smu_post_init(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; smu_ppt_funcs(post_init, 0, smu)<br>
&nbsp;#define smu_gpo_control(smu, enablement)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; smu_ppt_funcs(gpo_control, 0, smu, enablement)<br>
&nbsp;#define smu_set_fine_grain_gfx_freq_parameters(smu)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(set_fine_gra=
in_gfx_freq_parameters, 0, smu)<br>
+#define smu_notify_rlc_status(smu, status)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(notify_rlc_status, 0, smu,=
 status)<br>
&nbsp;<br>
&nbsp;#endif<br>
&nbsp;#endif<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7Cf740746f29d14d4777e808d89b6b4971%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637430232414406734%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DVPGv9GuTb22ZkzKp98iG3ibpG7BSwKaw%2FBT%2F6DFDnSs%3D&amp;amp=
;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7CKevin1.Wang%40amd.com%7Cf740746f29d14d4777e808d89b6b4971%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430232414406734%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DVPGv9GuTb22ZkzKp98iG3ibpG7BSwKaw%2FBT%2F6DFDnSs%3D&a=
mp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022C989D9B434BD2AAB3BA8A2CD0MN2PR12MB3022namp_--

--===============0354971049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0354971049==--
