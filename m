Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0A4C2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 10:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65DCF206B7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 10:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q5UYvZOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DCF206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 195C56E258;
	Mon, 23 Dec 2019 10:10:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F7616E241
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 10:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyJcPjOMJ/BqVDzQTm+jjPkJvo45vPFyD/ocrJiXEDmtaP1ClnEyAfgUXHXgPiXI6ICgPzy5yoq9KltkwGqk2G5orum5tHezLr7CuEBQSMzMiNbWuuwDAAZ8ijxSW1TJYBaKXn4N68k4EllTH1L6nutGm+chE/TkuXPM0nWpIOlFDa4yHc7v5Rxvrg+m27sVKt0jBshmeCZaQRYRr6bUjnBGbQ2JQSRy6m47gf4f0v4g6yaM7RMgQJQNsHGZxsJ6Jh3InMPS5wXDA6yQYM8PIdcSOd0C7xSlfPwyuFzCL2eoK5t3YseGeGb4iRoDHf0SCGaaRUEIjVWI8FONwV0IgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGLsULmXIJLSxhgRiAtdKpBEezwqM/a8dij4DenZx3o=;
 b=daa83mG3xyGBT6OQF6yX7KX+QQ+M7wuzjFuo3wv6NMh7G0JSTuiuzE14WjzbnSmUj655i9+EnX3+2ZhjumXke7/kMsQTBWyc/+eJJmVFWSUBTWUiwffbhXHIAurflu51Pb6D5zIaDHDOYmCxKdCEFhuzwQcCccEnL8sJ+ni2RBi4GoPMf6Laji2GKmULWCMdnA4uISDDlk2lkmGn4tkQtH6StBhv657xDr77Eg4Ng0BZ1FA79vRbQtjEpW2gK1v5p8WeO6LDm8/I0xK7j/c2gueOj5AowK8cqNMsTR/q0V3YnodpJJ9IXXJivbxfVbolOHT1iHEw7waD/eIZp4Pung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGLsULmXIJLSxhgRiAtdKpBEezwqM/a8dij4DenZx3o=;
 b=Q5UYvZOQlaluzjAmqjYQ2HFJK43Sm7HLV3J/jI2KjlCoiJfCim6gOXOwmhpcLe9QDKFqQpd9LmiQD8CQNmdrbUG23eN558fwiTbwkMpiNt9yJQmS/q5jdNnZjArQDQDW9VBF4Oak+tKr2S9HLNxU8jRExZIcKmYL1BlyiJh/oO4=
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB4318.namprd12.prod.outlook.com (52.135.49.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Mon, 23 Dec 2019 10:10:31 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3%6]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 10:10:30 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>
Subject: Re: [PATCH] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Thread-Topic: [PATCH] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Thread-Index: AQHVuWyH98p430LSk0KUV3nPXXgyTqfHZojQgAAUr/E=
Date: Mon, 23 Dec 2019 10:10:30 +0000
Message-ID: <MN2PR12MB3296FCACEC21D2A6B3F71FE4A22E0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191223083939.9669-1-Jack.Zhang1@amd.com>,
 <CH2PR12MB36724ADD77CE6D8604792A7DBB2E0@CH2PR12MB3672.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB36724ADD77CE6D8604792A7DBB2E0@CH2PR12MB3672.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-23T10:10:29.876Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3bc61b6-5d6d-4cc0-e7a3-08d787905741
x-ms-traffictypediagnostic: MN2PR12MB4318:|MN2PR12MB4318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB431863FF0DA69889892F40CAA22E0@MN2PR12MB4318.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(13464003)(66556008)(5660300002)(64756008)(19627405001)(71200400001)(7696005)(66574012)(6506007)(66946007)(53546011)(66476007)(110136005)(86362001)(76116006)(26005)(91956017)(52536014)(316002)(66446008)(186003)(33656002)(55016002)(4326008)(6636002)(8676002)(81156014)(9686003)(2906002)(478600001)(81166006)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4318;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ht0eaJivupmChRGGEMgI5TTirKMOLRvoopuDYuGipvF35XR41k3qUSzHQPkyxGxorVn2gnB1MIA+9Lmz1NJc9VxEpssJLLX2vF6ivDRNsiuRuSQMJaThtMNTqTBtvoF+r6qMvXLZFt3bfwNEO6RBrxXjRphyQgx6Uu8oe3LyjlBMAjGsIz9wVmExrNZ9pA+Ju67I7l4u1RPTydgWMP6L6eInbbXnhHx9OrJgHiiQzS19t4Bi8yCqYDDLfP7Vd5QT7cuYNj6E00S/Ig109LhCcHXqyttetwthwfXkzj7emG1q1xllOZ/+PHRui6+vNMtF3gr2eP2xFI0kIexvokUcxfpS2Nsj+dyEJcdCHQalz6i66thj2ElC7S6fdhY0nXRE5DcdpTx+e4ryC65ILpETlYHtjL27uKWYNa1+rgHQFG5vRTR8hrwBFpRyAPO3n59HriuLAoSbjAozFklfND00Xnufy7AsgV6foCRqW1PHfSzGol9m1rS+KCHqqgTqonIX
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bc61b6-5d6d-4cc0-e7a3-08d787905741
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 10:10:30.3782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UArbovhd+PMsmjXgH0rHwOLyoCOD51qAza3imMMbsBVhxXHpWx7wDQ4YOqnYO0yC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============0176392829=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0176392829==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296FCACEC21D2A6B3F71FE4A22E0MN2PR12MB3296namp_"

--_000_MN2PR12MB3296FCACEC21D2A6B3F71FE4A22E0MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

add @Quan, Evan<mailto:Evan.Quan@amd.com> to support arcturus asic.
comment inline.
________________________________
From: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Sent: Monday, December 23, 2019 4:42 PM
To: Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@am=
d.com>; Tao, Yintian <Yintian.Tao@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>; Deng, Emily <Emily.Deng@amd.com>
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: RE: [PATCH] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF



-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com>
Sent: Monday, December 23, 2019 4:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF

Before, initialization of smu ip block would be skipped for sriov ASICs. Bu=
t if there's only one VF being used, guest driver should be able to dump so=
me HW info such as clks, temperature,etc.

To solve this, now after onevf mode is enabled, host driver will notify gue=
st. If it's onevf mode, guest will do smu hw_init and skip some steps in no=
rmal smu hw_init flow because host driver has already done it for smu.

With this fix, guest app can talk with smu and dump hw information from smu=
.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  3 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 49 ++++++++++++++++++--------=
----
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 8469834..08130a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1448,7 +1448,8 @@ static int psp_np_fw_load(struct psp_context *psp)
                     || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_G
                     || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTORE_=
LIST_CNTL
                     || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTORE_=
LIST_GPM_MEM
-                   || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTORE_L=
IST_SRM_MEM))
+                   || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTORE_L=
IST_SRM_MEM
+                   || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_SMC))
                         /*skip ucode loading in SRIOV VF */
                         continue;

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index b53d401..a271496 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -827,8 +827,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
                         amdgpu_device_ip_block_add(adev, &dce_virtual_ip_b=
lock);
                 amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
                 amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
-               if (!amdgpu_sriov_vf(adev))
-                       amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_bloc=
k);
+               amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);

                 if (amdgpu_sriov_vf(adev)) {
                         if (likely(adev->firmware.load_type =3D=3D AMDGPU_=
FW_LOAD_PSP)) diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/dri=
vers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 936c682..c07fb26 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -531,10 +531,14 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
         if (adev->asic_type =3D=3D CHIP_VEGA20)
                 return (amdgpu_dpm =3D=3D 2) ? true : false;
         else if (adev->asic_type >=3D CHIP_ARCTURUS) {
-               if (amdgpu_sriov_vf(adev))
-                       return false;
-               else
+               if (amdgpu_sriov_vf(adev)) {
+                       if(amdgpu_sriov_is_pp_one_vf(adev))
+                               return true;
+                       else
+                               return false;
+               } else {
                         return true;
+               }
         } else
                 return false;
 }
@@ -1062,20 +1066,19 @@ static int smu_smc_table_hw_init(struct smu_context=
 *smu,
         }

         /* smu_dump_pptable(smu); */
+       if(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)){
+               /*
+                * Copy pptable bo in the vram to smc with SMU MSGs such as
+                * SetDriverDramAddr and TransferTableDram2Smu.
+                */
[kevin]: this comment is not neccessary in smu module.
and could you describe the function of pp_one_vf and sriov_vf ?
it is useful to help us understand your patch.
thanks.

+               ret =3D smu_write_pptable(smu);
+               if (ret)
+                       return ret;

-       /*
-        * Copy pptable bo in the vram to smc with SMU MSGs such as
-        * SetDriverDramAddr and TransferTableDram2Smu.
-        */
-       ret =3D smu_write_pptable(smu);
-       if (ret)
-               return ret;
-
-       /* issue Run*Btc msg */
-       ret =3D smu_run_btc(smu);
-       if (ret)
-               return ret;
-
+               /* issue Run*Btc msg */
+               ret =3D smu_run_btc(smu);
+               if (ret)
+                       return ret;
         ret =3D smu_feature_set_allowed_mask(smu);
         if (ret)
                 return ret;
@@ -1083,7 +1086,7 @@ static int smu_smc_table_hw_init(struct smu_context *=
smu,
         ret =3D smu_system_features_control(smu, true);
         if (ret)
                 return ret;
-
+       }
         if (adev->asic_type !=3D CHIP_ARCTURUS) {
                 ret =3D smu_notify_display_change(smu);
                 if (ret)
@@ -1136,8 +1139,9 @@ static int smu_smc_table_hw_init(struct smu_context *=
smu,
         /*
          * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for =
tools.
          */
-       ret =3D smu_set_tool_table_location(smu);
-
+       if(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)){
+               ret =3D smu_set_tool_table_location(smu);
+       }
         if (!smu_is_dpm_running(smu))
                 pr_info("dpm has been disabled\n");

@@ -1249,6 +1253,13 @@ static int smu_hw_init(void *handle)
                 smu_set_gfx_cgpg(&adev->smu, true);
         }

+       if (amdgpu_sriov_vf(adev)) {
+               if(amdgpu_sriov_is_pp_one_vf(adev))
+                       smu->pm_enabled =3D true;
+               else
+                       smu->pm_enabled =3D false;
+       }
+

[kevin]:
the variable of "smu->pm_enabeld" is initialize in smu_eary_init(), it is o=
nly depend on module param amdgpu_dpm.
after initialized, this variable should not be changed arbitrarily.
so i hope you can refine the above code logic.

         if (!smu->pm_enabled)
                 return 0;

--
2.7.4


--_000_MN2PR12MB3296FCACEC21D2A6B3F71FE4A22E0MN2PR12MB3296namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
add <a id=3D"OWAAM10677" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mention ms-bgc-nl=
r ms-fcl-b" href=3D"mailto:Evan.Quan@amd.com">
@Quan, Evan</a>&nbsp;to support arcturus asic.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">comment inline.</span><br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Zhang, Jack (Jian) &l=
t;Jack.Zhang1@amd.com&gt;<br>
<b>Sent:</b> Monday, December 23, 2019 4:42 PM<br>
<b>To:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Wang, Kevin(Yang) &l=
t;Kevin1.Wang@amd.com&gt;; Tao, Yintian &lt;Yintian.Tao@amd.com&gt;; amd-gf=
x@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deng, Emily =
&lt;Emily.Deng@amd.com&gt;<br>
<b>Cc:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] amd/amdgpu/sriov enable onevf mode for ARCTURUS=
 VF</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
-----Original Message-----<br>
From: Jack Zhang &lt;Jack.Zhang1@amd.com&gt; <br>
Sent: Monday, December 23, 2019 4:40 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;<br>
Subject: [PATCH] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF<br>
<br>
Before, initialization of smu ip block would be skipped for sriov ASICs. Bu=
t if there's only one VF being used, guest driver should be able to dump so=
me HW info such as clks, temperature,etc.<br>
<br>
To solve this, now after onevf mode is enabled, host driver will notify gue=
st. If it's onevf mode, guest will do smu hw_init and skip some steps in no=
rmal smu hw_init flow because host driver has already done it for smu.<br>
<br>
With this fix, guest app can talk with smu and dump hw information from smu=
.<br>
<br>
Signed-off-by: Jack Zhang &lt;Jack.Zhang1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp; |&nbsp; 3 &=
#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 3 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 49 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------=
------<br>
&nbsp;3 files changed, 33 insertions(&#43;), 22 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 8469834..08130a6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -1448,7 &#43;1448,8 @@ static int psp_np_fw_load(struct psp_context *psp=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=3D =
AMDGPU_UCODE_ID_RLC_G<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=3D =
AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=3D =
AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=3D AMDGPU_UCOD=
E_ID_RLC_RESTORE_LIST_SRM_MEM))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=3D AMDGPU_=
UCODE_ID_RLC_RESTORE_LIST_SRM_MEM<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=3D AMDGPU_=
UCODE_ID_SMC))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*ski=
p ucode loading in SRIOV VF */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index b53d401..a271496 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -827,8 &#43;827,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;dce_virtual_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gfx_v9_0_ip_blo=
ck);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;sdma_v4_0_ip_bl=
ock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;smu_v11_0_ip_block);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;smu_v11_0_ip_block);<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (l=
ikely(adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)) diff --git a/=
drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/=
amdgpu_smu.c<br>
index 936c682..c07fb26 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -531,10 &#43;531,14 @@ bool is_support_sw_smu(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=
=3D CHIP_VEGA20)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return (amdgpu_dpm =3D=3D 2) ? true : false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;asic_typ=
e &gt;=3D CHIP_ARCTURUS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(amdgpu_sr=
iov_is_pp_one_vf(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
@@ -1062,20 &#43;1066,19 @@ static int smu_smc_table_hw_init(struct smu_con=
text *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* smu_dump_pptable(smu); =
*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(amdgpu_sriov_vf(adev) &amp;&am=
p; !amdgpu_sriov_is_pp_one_vf(adev)){<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * Copy pptable bo in the vram to smc with SMU MSGs suc=
h as<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * SetDriverDramAddr and TransferTableDram2Smu.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */</div>
<div class=3D"PlainText">[kevin]: this comment is not neccessary in smu mod=
ule.</div>
<div class=3D"PlainText"><span>and could you describe the function of pp_on=
e_vf and sriov_vf ?</span></div>
<div class=3D"PlainText"><span>it is useful to help us understand your patc=
h.&nbsp;</span></div>
<div class=3D"PlainText">thanks.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_write_pptable(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Copy pptable bo in the vram t=
o smc with SMU MSGs such as<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SetDriverDramAddr and Transfe=
rTableDram2Smu.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_write_pptable(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* issue Run*Btc msg */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_run_btc(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* issue Run*Btc msg */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_run_btc(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_set_al=
lowed_mask(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1083,7 &#43;1086,7 @@ static int smu_smc_table_hw_init(struct smu_conte=
xt *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_system_feature=
s_control(smu, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=
=3D CHIP_ARCTURUS) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_notify_display_change(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -1136,8 &#43;1139,9 @@ static int smu_smc_table_hw_init(struct smu_conte=
xt *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Set PMSTATUSLOG ta=
ble bo address with SetToolsDramAddr MSG for tools.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_tool_table_location(s=
mu);<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(amdgpu_sriov_vf(adev) &amp;&am=
p; !amdgpu_sriov_is_pp_one_vf(adev)){<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_set_tool_table_location(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_is_dpm_running(sm=
u))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_info(&quot;dpm has been disabled\n&quot;);<br>
&nbsp;<br>
@@ -1249,6 &#43;1253,13 @@ static int smu_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_set_gfx_cgpg(&amp;adev-&gt;smu, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if(amdgpu_sriov_is_pp_one_vf(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;pm_e=
nabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;pm_e=
nabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">the variable of &quot;smu-&gt;pm_enabeld&quot; is =
initialize in smu_eary_init(), it is only depend on module param amdgpu_dpm=
.</div>
<div class=3D"PlainText"></div>
<span>after initialized, this variable should not be changed arbitrarily.</=
span></span></font></div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
><span>so i hope you can refine the above code logic.</span></span></font><=
/div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
><span><br>
</span></span></font></div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (!smu-&gt;pm_enabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
--<br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3296FCACEC21D2A6B3F71FE4A22E0MN2PR12MB3296namp_--

--===============0176392829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0176392829==--
