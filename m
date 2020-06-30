Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D50C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 13:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5474D206B6
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 13:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BqxciGs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5474D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E91F7895B5;
	Tue, 30 Jun 2020 13:36:12 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750084.outbound.protection.outlook.com [40.107.75.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F8C6895B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 13:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLyTkXwAbegs3bfplY8gfK3iFOeFI3hmWflr4qPGS9x86dlt6n9vZtaCOy/a10I/YoO5Ht4jeo8sYOBahbiFS2SpaDbcvxfmJbnRqzlSsqhMaGWQ6gH9GBAc+hX5TA8VtGFTSG8yO34ofm7F8SR0yrVpTdYVFzVtQQyndcRaX/ZLbrmkUL196bTqXgH0EfFGbUAfG58Wzxx8VQG8BTHIkNm9GTVNha+dYfgqUzJy2MnIJlw8DtPZfg+9ONgtENn+5SyG+p+i3N+gGqvUE25tKbmVFfVEZKyH7lx398uzkKk6FEi30IvRi/9BgO94BF/dPWJTpgmn/znbASMX2tN3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b9yZ+0NRvTLcCcv1bBPXuVS7347vlderf3Tlhxp9Tw=;
 b=AqPBTjT9ffH+R66oezwXhhOuotMsUn//pjaZD5D3ODiwt7y/9HFtM0kRA0IBNxDn6sGySTNIwTLgWguglRjI1rjzFRipgGHiRiLBXWqOaTVS6g2WLb7TIX9VGnmCA3n38ugXmcwy+fpb4q5rTzGNDgzQCFmfU9EQPQ/+ZOa3lsFaRYlxzHxbqX7YZo1xjo8QDU+J+nKcIMeLf5wIog52tY2Pj6PtF2lgskHfwtFoOG6LC1yV13nhLlcXZvYsfyEyTqLueMl9DDUHf5PmaCs6zJUVL5mt1ZmObfvGjqiBdhFs58k2xH/wKBer2d2sgrDylxAD4fn1KhFsRqGxsxAliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b9yZ+0NRvTLcCcv1bBPXuVS7347vlderf3Tlhxp9Tw=;
 b=BqxciGs9OpYwJwZaiWcqr8lMMNI/oVGTUI/UX0bb912030uIk0EtOFiuj2ayPDJxJ8aeBsJN31zShXWkYSRbCbdP6p6ZH5dsAk0MDu7kD6QW2oeErFqglLIxSNK/MFRITo35oZtJg8XrKwt7TdOK+LS0Hh+2LM5UN7FkOa+P++Q=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 30 Jun
 2020 13:36:09 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%4]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 13:36:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: add TMR destory function for psp
Thread-Topic: [PATCH 2/2] drm/amdgpu: add TMR destory function for psp
Thread-Index: AQHWTsmttD4xYoFzDUOravtJWdxGxKjxKO9J
Date: Tue, 30 Jun 2020 13:36:09 +0000
Message-ID: <MN2PR12MB4488D0EEA187FA8D420B366DF76F0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200630103051.1206401-1-ray.huang@amd.com>,
 <20200630103051.1206401-2-ray.huang@amd.com>
In-Reply-To: <20200630103051.1206401-2-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-30T13:36:09.214Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.51.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcad9af6-b8b6-4e4d-23d1-08d81cfa8c88
x-ms-traffictypediagnostic: MN2PR12MB4437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB44372EC87EF504D27CC5496DF76F0@MN2PR12MB4437.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NC5Bo+3558WbfTkfEX6prJs+UEGW+kKNclIA7yhguaclfCq3CkAvKAccvbLLbhDs3bzm/ptlp6x0zCdMNt1IntikOklXk2amWZ6N84UGg+fvrMw8160ZNp+nDvDV/pt2o2zHd6QVEUclYs0H5i5HiXydapph4XurZMwIvOfJLc6KvEdUWVX1vMZ4gNqWEIgaytBH4yvSC8Oyv0lwx0yJeQIGE1eY5qKAptPW7VlWbcaTvfi50p27qRjjwsL72I2Q57ylZ3NJuOmzxhh39xGM7oNQ/iIdr9M0kWLVMN+FbQT8sdzbL47jQX7yYL7F3bAiCHpE/6Dgy0IJVh64Mo39cPHWAMl/0tdBqxeaQ9pK/S0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(55016002)(166002)(7696005)(9686003)(966005)(53546011)(6506007)(45080400002)(478600001)(71200400001)(19627405001)(86362001)(316002)(110136005)(186003)(83380400001)(8676002)(52536014)(8936002)(64756008)(66446008)(76116006)(66946007)(5660300002)(66556008)(66476007)(26005)(33656002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: nifZE4cLP23m9wHKxuBAzM6fKlxxYRPSKngIeQHYs9PSLLNYFK7CbfvFYbABeqUhZGQg4JST1Nqgrf/Sjbo+pR+0pmyel7pPEjU4HRXcrR40FI/4mcyb5Na3aQX17ZX/1WGVx0yr0EetWTrLt+EgrntyY0ZAIJyIgtt8148IFf/BIArjCx18WOkf9xQADtxEvhM5h3ZnyMUkrs9909HlYaJyib7rTkq0OK8XikBuZhQlxHWSPfpsIpBqo5KXOBIp6Fvx4O7PsU7G/mueUOjTGisMCD92763dkD1YAQ3ce0yiXUVi7NMBE8Z6p+jVijgn65Wjv/z4xoi/fx4kJXGAGB2UrTtd9kn04DHF1hYWgQ23dpb/GGcgTLimtspgB4NCljfQjTPLmR9r1AcOENhcYzS7XEPuKs9i/Y02zX1v2BA87L9Mr27414GBmHrvlSrAHAsv1WWGG0AJV/BgwpUZgbvL7FuGAiVSpBL61ciRCFTFR8cURLvQoKpvRUiWEal3
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcad9af6-b8b6-4e4d-23d1-08d81cfa8c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 13:36:09.7023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdslWxtuhtJc7ctygqL6m6HSEwzqQ6PSU8dRRlo/YeRZxsdiMuheKwr9JDG0yiNEgJDJi+FEJXlwmd6J5fhcfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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
Content-Type: multipart/mixed; boundary="===============0560251689=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0560251689==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D0EEA187FA8D420B366DF76F0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D0EEA187FA8D420B366DF76F0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Huang Ru=
i <ray.huang@amd.com>
Sent: Tuesday, June 30, 2020 6:30 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add TMR destory function for psp

TMR is required to be destoried with GFX_CMD_ID_DESTROY_TMR while the
system goes to suspend. Otherwise, PSP may return the failure state
(0xFFFF007) on Gfx-2-PSP command GFX_CMD_ID_SETUP_TMR after do multiple
times suspend/resume.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 57 +++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index e57a53d5ca96..23ebb50b1a19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -430,6 +430,52 @@ static int psp_tmr_load(struct psp_context *psp)
         return ret;
 }

+static void psp_prep_tmr_unload_cmd_buf(struct psp_context *psp,
+                                       struct psp_gfx_cmd_resp *cmd)
+{
+       if (amdgpu_sriov_vf(psp->adev))
+               cmd->cmd_id =3D GFX_CMD_ID_DESTROY_VMR;
+       else
+               cmd->cmd_id =3D GFX_CMD_ID_DESTROY_TMR;
+}
+
+static int psp_tmr_unload(struct psp_context *psp)
+{
+       int ret;
+       struct psp_gfx_cmd_resp *cmd;
+
+       cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
+       if (!cmd)
+               return -ENOMEM;
+
+       psp_prep_tmr_unload_cmd_buf(psp, cmd);
+       DRM_INFO("free PSP TMR buffer\n");
+
+       ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
+                                psp->fence_buf_mc_addr);
+
+       kfree(cmd);
+
+       return ret;
+}
+
+static int psp_tmr_terminate(struct psp_context *psp)
+{
+       int ret;
+       void *tmr_buf;
+       void **pptr;
+
+       ret =3D psp_tmr_unload(psp);
+       if (ret)
+               return ret;
+
+       /* free TMR memory buffer */
+       pptr =3D amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+       amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+
+       return 0;
+}
+
 static void psp_prep_asd_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
                                 uint64_t asd_mc, uint32_t size)
 {
@@ -1866,8 +1912,6 @@ static int psp_hw_fini(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         struct psp_context *psp =3D &adev->psp;
-       void *tmr_buf;
-       void **pptr;
         int ret;

         if (psp->adev->psp.ta_fw) {
@@ -1883,10 +1927,9 @@ static int psp_hw_fini(void *handle)
                 return ret;
         }

+       psp_tmr_terminate(psp);
         psp_ring_destroy(psp, PSP_RING_TYPE__KM);

-       pptr =3D amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-       amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
         amdgpu_bo_free_kernel(&psp->fw_pri_bo,
                               &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
         amdgpu_bo_free_kernel(&psp->fence_buf_bo,
@@ -1939,6 +1982,12 @@ static int psp_suspend(void *handle)
                 return ret;
         }

+       ret =3D psp_tmr_terminate(psp);
+       if (ret) {
+               DRM_ERROR("Falied to terminate tmr\n");
+               return ret;
+       }
+
         ret =3D psp_ring_stop(psp, PSP_RING_TYPE__KM);
         if (ret) {
                 DRM_ERROR("PSP ring stop failed\n");
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C282cd5829fbe4fca8ac708d81ce0cdbb%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637291099162588481&amp;sdata=3DUfOBa7Xaa6qvWClFnYB=
4OSngc8k0YyUmDCwtKmZ5BQQ%3D&amp;reserved=3D0

--_000_MN2PR12MB4488D0EEA187FA8D420B366DF76F0MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Huang Rui &lt;ray.huang@amd.c=
om&gt;<br>
<b>Sent:</b> Tuesday, June 30, 2020 6:30 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: add TMR destory function for psp</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">TMR is required to be destoried with GFX_CMD_ID_DE=
STROY_TMR while the<br>
system goes to suspend. Otherwise, PSP may return the failure state<br>
(0xFFFF007) on Gfx-2-PSP command GFX_CMD_ID_SETUP_TMR after do multiple<br>
times suspend/resume.<br>
<br>
Signed-off-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 57 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 53 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index e57a53d5ca96..23ebb50b1a19 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -430,6 &#43;430,52 @@ static int psp_tmr_load(struct psp_context *psp)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void psp_prep_tmr_unload_cmd_buf(struct psp_context *psp,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; struct psp_gfx_cmd_resp *cmd)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev)=
)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_DESTROY_VMR;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_DESTROY_TMR;<br>
&#43;}<br>
&#43;<br>
&#43;static int psp_tmr_unload(struct psp_context *psp)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp=
_gfx_cmd_resp), GFP_KERNEL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cmd)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -ENOMEM;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_tmr_unload_cmd_buf(psp, =
cmd);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;free PSP TMR buffe=
r\n&quot;);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, N=
ULL, cmd,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;fence_buf_mc_addr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(cmd);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;static int psp_tmr_terminate(struct psp_context *psp)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *tmr_buf;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void **pptr;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_tmr_unload(psp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* free TMR memory buffer */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr =3D amdgpu_sriov_vf(psp-&gt;=
adev) ? &amp;tmr_buf : NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&g=
t;tmr_bo, &amp;psp-&gt;tmr_mc_addr, pptr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;static void psp_prep_asd_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t asd_mc, uint32_t size)<=
br>
&nbsp;{<br>
@@ -1866,8 &#43;1912,6 @@ static int psp_hw_fini(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_context *psp =
=3D &amp;adev-&gt;psp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *tmr_buf;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void **pptr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;adev-&gt;psp.t=
a_fw) {<br>
@@ -1883,10 &#43;1927,9 @@ static int psp_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_tmr_terminate(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_ring_destroy(psp, PSP_=
RING_TYPE__KM);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr =3D amdgpu_sriov_vf(psp-&gt;adev=
) ? &amp;tmr_buf : NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;tm=
r_bo, &amp;psp-&gt;tmr_mc_addr, pptr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp=
;psp-&gt;fw_pri_bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;fw_pri_mc_addr, &amp;psp-&gt;fw=
_pri_buf);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp=
;psp-&gt;fence_buf_bo,<br>
@@ -1939,6 &#43;1982,12 @@ static int psp_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_tmr_terminate(psp);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_ERROR(&quot;Falied to terminate tmr\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_ring_stop(psp,=
 PSP_RING_TYPE__KM);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP ring stop failed\n&quot;);<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C282cd5829fbe4fca8ac708d81ce0cdbb%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637291099162588481&amp;amp;sdata=3D=
UfOBa7Xaa6qvWClFnYB4OSngc8k0YyUmDCwtKmZ5BQQ%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C282cd5829fbe4fca8ac708d81ce0cdbb%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637291099162588481&amp;amp;sdata=3DUfOBa7Xaa6qvWClFn=
YB4OSngc8k0YyUmDCwtKmZ5BQQ%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488D0EEA187FA8D420B366DF76F0MN2PR12MB4488namp_--

--===============0560251689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0560251689==--
