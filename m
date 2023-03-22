Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A0CC6FD1D
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 01:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9A510E012;
	Wed, 22 Mar 2023 01:40:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02EE610E012
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 01:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUwTAmFPo4YX9gCjHMKNdxQN8nzkx8YQ1b4VUkzj8T9TZU63q+UaaDupWvNC9OmsCfxwptYEbF+S5L7WjJcDs2UUzr4dXfBMoAvGE8Fb1VOaeSxXupT8KDroVZLjtP6+eq/y8uBWHVzdq9N+OBrKHPoIT8ksBRkzLWIR2Go59o6qpZmuPoL0Ivliv2JJe4uynmIM2LCXT8bXWEr58Qq3NaoQasKsCe1tdirg9r5ijs8RSR+2+LkfEunBDWA4pctczbdfe5Jx/R86S+W+4n0iLyatkqTraDLW8NLBTzWp/hfMT1oObJ2Il6MefFuKF+d30mJAuzy1EUDwebqZFG73lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTVDVl5UhVaRwJuJ4stL042VqHOmYX7BgmOckvxwb8U=;
 b=jbROVB/9yqTk4zZrj/tR7YNLP3TigDImkZNNdqQLgaE5yaUP3VfHt1fcaUAtrdOz+se51uEnTrJMOANHO8Qq+8+Od+CYeDIoe0UZ3Ktf7LhuaCGNoQOwwyr/ag2jrYlfVgZ2nlDk5GrNyc3ehwybxXdoAhVopbcBCfKrINy9Qt9yWDFFIFjChD8k6VEq4l+tsq6i+Q+fOcoamm/HhENhmJR4RHy/QToJbYKyRA5ZyV3FL4pyn7jvvhYwedsNBfmSMzIn/xFgFscebACA36tOpyKYJSgmABhPp1GYxBl2ybSXVLmf0rPHBiuiWLPMqaUsCMmCW19aUEntHOR48eBx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTVDVl5UhVaRwJuJ4stL042VqHOmYX7BgmOckvxwb8U=;
 b=DOWJCsqay88pRDY0YDzwnCtOXyRmazKeoZbke0oqtoNfHDNZ7gViqkVnf7G3NrZg+dFxu2UpG4d7Mkjd3RwW/EoTi31RSzh+Ib3KH1LuF1t35ZetAQFFotqa9EeK7wMb0qecaPi6Av1u6tTcvG6mmnVAdZcsV8Jtm3Zxy6yMC8Y=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 01:40:24 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 01:40:24 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu01, Tong (Esther)"
 <Tong.Liu01@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded
Thread-Topic: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded
Thread-Index: AQHZW9Y5lnmh2DBnWk6DFx100jQ0YK8FS6GAgAC6q+A=
Date: Wed, 22 Mar 2023 01:40:24 +0000
Message-ID: <DM5PR12MB24695E3802F747A6D97B19A8F1869@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230321091900.144479-1-Tong.Liu01@amd.com>
 <BL1PR12MB5144C514C69B42718855FB22F7819@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144C514C69B42718855FB22F7819@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-21T14:30:15.328Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS7PR12MB6285:EE_
x-ms-office365-filtering-correlation-id: 3fba202a-d0b1-4bac-3b65-08db2a766849
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hxo2r3BSN8MjesESkCVx22EQHGmi4pRcLbuWQJ+G0V2a2bisIrHM1iVQ/mqbVZE2cIAJaGhvY34PQdJDfDWnZzSNyIYhPiib8Bj65szNn26RUp4487dTVhUuOE6WM9425378m2vP9O+YhhfAniddqVMXaaMDBFvIfhYYTwmPz8WjzAACwWyF0LA5/Um4Xk+eUSwpY2nroRtC4Yl7EdFa4ailObBcjGGU9JFwjwJuBrCm5jM81e5cTSi0xllLT7C5CvZoH3ZMMBqNMlns6kIhV/5JDbDI44hcSpoZkVzN0i2E1ndcViQaF2gU1nEL2ymzQWT7Nm7oYtqjqa5kbVZC0yCoTBUIjf+fAEwsGmu8vqfZOFziFiBK6rt78Kx4rAQaOlgfu8gFGgGa0PWtqPNozUR9mxBb49Kajlzr/7QxzmaS0crH/gcgwEhIvxMnb7OtWCI5mNHOA8tBk+WLHckJVg5eraZ2mdnx7aCd7qfOT6wsI+Q+e+S+oBOCKsICaA1l6RzEA1UfY9k6inXNH0D5UMGB4GLyT9LlnZsg1lxw5AXK6SW3kcZwOouxyb4bJKjHzrL5KOXQvSTmUr1muTdFe3mwTzBeW3wm6rkVclHwRUL0FSjXPPOzDnQvI1uuYxWYqEC6zDqSCg/zAn4/y8vgsSUIPsllt4+PGZrb2UmvENCyEy0i6E4yDZLFGdcZZKuWKOrkNRp5XWBolGeH+VZyKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199018)(110136005)(6506007)(26005)(53546011)(9686003)(4326008)(66476007)(66556008)(8676002)(316002)(83380400001)(71200400001)(186003)(76116006)(54906003)(64756008)(66946007)(478600001)(52536014)(8936002)(5660300002)(122000001)(2906002)(41300700001)(66446008)(38070700005)(7696005)(38100700002)(86362001)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J4cirHeqh0IrtDdPxiy5Ei83xfXgHwEVMAIi2hZjMdZ+KzlTMSCHPcTZFPpS?=
 =?us-ascii?Q?Y9G/a/E6kXrdKtrxJaS1tjUSn9J/NqCGRQIyPJcJECsZQ4KQpRggmxX12wGR?=
 =?us-ascii?Q?baAkyVccFafoGIQJJvAJuSguvQlAExdtM+mH6pyOrOwdv3hyOg+FKDsQ9SYu?=
 =?us-ascii?Q?jeXaOpA6Ax3i/iCLNzthHc1gkxc9IsMn4/6SY7aio9dxwBptESAhdmL8GEII?=
 =?us-ascii?Q?8SMPTyMUDMQXzWDL7sCbc46oS82vYVcKcgXcJY0zvraeWhKox/VLfjT1Oj/E?=
 =?us-ascii?Q?pj3zP+B0+OIKknLIdJz57bRQ0+G4gcpsmCJSBXaUcl39ZN+JhRY9bFmWlSJG?=
 =?us-ascii?Q?6KqGCL3jli9pFr23pE5wqShvOLqeWA/5V+dUh0xn6TcusZvKEOxCys31I1QB?=
 =?us-ascii?Q?djgIbWz+FvzoT0ix22kS3bh3v+4BVa1Uqn5jwptGt0PFl8MvQeOZgZw+jSCh?=
 =?us-ascii?Q?iy7hc5wQl157Qx0vf874BLhJabsYNk4L4nMt50Aj+33fw+Ll2HRlnwkaiOzO?=
 =?us-ascii?Q?20Q8UySjB35YIUJ6xsqSgCCgRZdc3rypqEBT/6ShOWP7APKXpnGy1GZLAdMt?=
 =?us-ascii?Q?noOTpnLHNoDJWLitMEOciqttw/dBjWuuFgcXuv1GVrIUo2uOuMyb8NsQmELC?=
 =?us-ascii?Q?RO9i0Vj1Vurznhj7JuRtHjMhhBiXz96VuXffY9s8f1l1cjCZX9uMgormmqiQ?=
 =?us-ascii?Q?Stts+yE+2DFH2U3cAKWb6foSeCF15hmFg/uPd1y3jfGahIPQ9I2iT2zFVxf0?=
 =?us-ascii?Q?n6MWH2yobxoSLP+c1xsJvL4PK+Jqde6ZysMwIiwf1hLOJdoE8K8dnwroyf5k?=
 =?us-ascii?Q?3jGSqqOSKiN6h+Oz0Y3fxXgCFX3sSwXUjq1GX6z/EXniEfFRSwufZ57BLySa?=
 =?us-ascii?Q?9RN4KFZQvZ9I4vp0cKYgcOBriiCAcJvSnoumslOnXS3gzpDQXT0KVOzN6mfj?=
 =?us-ascii?Q?Kc0o6raLzbo9Nxa8/raJ1w0TK4Z7khaMQ00RAa1w4uEsKb/1mYlWbHopVEKf?=
 =?us-ascii?Q?7ZTiC5+Hp5jkYpCWJgeiDUePXywQErb/PiUpcrQ4uRR3Q6NFtfS/zu0z40QH?=
 =?us-ascii?Q?ExJ5ns34uWQ9lfSY2/uJby6MITF4c/ktdlCyNwjbThI8NoipMYsjHz+Vz17B?=
 =?us-ascii?Q?CyFWBino3ZHXYx9KZiZfjrHju+/7zroow/hOGlvzTZzQgeS//0boY/mtAKH5?=
 =?us-ascii?Q?u3zm7XHWoi/qCpwMrQD5td8FyDJkQ3PICfxOdQJIeHHOalwrjSJPWLaGkgaW?=
 =?us-ascii?Q?aCn/7mT7yYOb0X2CIOEISTnzYUJMeGWQcS034TnwKBa+1NV1YQq8gntzj3Rv?=
 =?us-ascii?Q?pMhfSY+4HM18oWFG4HtYOpiXyELB4a8KbiwUfzs2j3GrNpbNFKVlvoEjcOBq?=
 =?us-ascii?Q?imbI3NPBWtAhHuY1OY5R3W7OU2fW8BOEIL0UHDvqf2u3BFgMLAiGQMYg1wWs?=
 =?us-ascii?Q?n8yx8rGsj8H0fOKza7TQZQJ3OqbGJyqRr04HAkh91OGAzQtaYhmzAajuoOET?=
 =?us-ascii?Q?UbR4IAZkHupE1eIuOWdDc9ZYsYi0UOJykj8hAV9UDE48EeAv1Ikbm2Sa6yKj?=
 =?us-ascii?Q?FdTpeyCbftfGrqZ8w2mwmfzWif4hMy5i/vuuGJC1?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB24695E3802F747A6D97B19A8F1869DM5PR12MB2469namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fba202a-d0b1-4bac-3b65-08db2a766849
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 01:40:24.6725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6OpAz/qT0p8ZkaHKK3oOVz/vsDJ5eV/3SQaa+9ypUP/eWQQcjyhjEVz4jSJFZH8Q+A1WPWKcxQuPNDr2aO2Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB24695E3802F747A6D97B19A8F1869DM5PR12MB2469namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

         struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);

+       /* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR.
+        * Already set up by host driver.
+        */
+       if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
+               return 0;

This will lead to a psp lock leak by acquire_psp_cmd_buf. It needs to put '=
cmd =3D acquire_psp_cmd_buf(psp);' after SRIOV check.

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Tuesday, March 21, 2023 10:30 PM
To: Liu01, Tong (Esther) <Tong.Liu01@amd.com>; amd-gfx@lists.freedesktop.or=
g
Cc: Xiao, Jack <Jack.Xiao@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tui=
kov, Luben <Luben.Tuikov@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Koenig, =
Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>
Subject: Re: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded


[Public]


[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deuch=
er@amd.com>>
________________________________
From: Tong Liu01 <Tong.Liu01@amd.com<mailto:Tong.Liu01@amd.com>>
Sent: Tuesday, March 21, 2023 5:19 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Chen, Horace =
<Horace.Chen@amd.com<mailto:Horace.Chen@amd.com>>; Tuikov, Luben <Luben.Tui=
kov@amd.com<mailto:Luben.Tuikov@amd.com>>; Koenig, Christian <Christian.Koe=
nig@amd.com<mailto:Christian.Koenig@amd.com>>; Deucher, Alexander <Alexande=
r.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; Xiao, Jack <Jack.Xiao=
@amd.com<mailto:Jack.Xiao@amd.com>>; Zhang, Hawking <Hawking.Zhang@amd.com<=
mailto:Hawking.Zhang@amd.com>>; Liu01, Tong (Esther) <Tong.Liu01@amd.com<ma=
ilto:Tong.Liu01@amd.com>>
Subject: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded

[why]
For Navi12 and CHIP_SIENNA_CICHLID SRIOV, TMR is not loaded. Should
also skip tmr unload

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com<mailto:Tong.Liu01@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 0b9e99c35a05..69addf2751aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -841,6 +841,12 @@ static int psp_tmr_unload(struct psp_context *psp)
         int ret;
         struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);

+       /* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR.
+        * Already set up by host driver.
+        */
+       if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
+               return 0;
+
         psp_prep_tmr_unload_cmd_buf(psp, cmd);
         dev_dbg(psp->adev->dev, "free PSP TMR buffer\n");

--
2.34.1

--_000_DM5PR12MB24695E3802F747A6D97B19A8F1869DM5PR12MB2469namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
span.EmailStyle20
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For Navi12 and CHIP_SIENNA_CICHLID=
 SRIOV, do not set up TMR.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Already set up by host driver=
.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev) &am=
p;&amp; psp_skip_tmr(psp))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This will lead to a psp lock leak by acquire_psp_cmd=
_buf. It needs to put &#8216;cmd =3D acquire_psp_cmd_buf(psp);&#8217; after=
 SRIOV check.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Tuesday, March 21, 2023 10:30 PM<br>
<b>To:</b> Liu01, Tong (Esther) &lt;Tong.Liu01@amd.com&gt;; amd-gfx@lists.f=
reedesktop.org<br>
<b>Cc:</b> Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Chen, Horace &lt;Horace.Ch=
en@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Quan, Evan &lt;=
Evan.Quan@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; =
Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loa=
ded<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexand=
er.deucher@amd.com">alexander.deucher@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Tong Liu01 &lt;<a href=3D"mailto:Tong.Liu01@amd.com=
">Tong.Liu01@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, March 21, 2023 5:19 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@am=
d.com</a>&gt;; Chen, Horace &lt;<a href=3D"mailto:Horace.Chen@amd.com">Hora=
ce.Chen@amd.com</a>&gt;; Tuikov, Luben &lt;<a href=3D"mailto:Luben.Tuikov@a=
md.com">Luben.Tuikov@amd.com</a>&gt;; Koenig, Christian
 &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christian.Koenig@amd.com</=
a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com"=
>Alexander.Deucher@amd.com</a>&gt;; Xiao, Jack &lt;<a href=3D"mailto:Jack.X=
iao@amd.com">Jack.Xiao@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailt=
o:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;;
 Liu01, Tong (Esther) &lt;<a href=3D"mailto:Tong.Liu01@amd.com">Tong.Liu01@=
amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded<=
/span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">[why]<br>
For Navi12 and CHIP_SIENNA_CICHLID SRIOV, TMR is not loaded. Should<br>
also skip tmr unload<br>
<br>
Signed-off-by: Tong Liu01 &lt;<a href=3D"mailto:Tong.Liu01@amd.com">Tong.Li=
u01@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 0b9e99c35a05..69addf2751aa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -841,6 +841,12 @@ static int psp_tmr_unload(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *c=
md =3D acquire_psp_cmd_buf(psp);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For Navi12 and CHIP_SIENNA_CICHLID=
 SRIOV, do not set up TMR.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Already set up by host driver=
.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev) &am=
p;&amp; psp_skip_tmr(psp))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_tmr_unload_cmd_bu=
f(psp, cmd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(psp-&gt;adev-&gt;d=
ev, &quot;free PSP TMR buffer\n&quot;);<br>
&nbsp;<br>
-- <br>
2.34.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB24695E3802F747A6D97B19A8F1869DM5PR12MB2469namp_--
