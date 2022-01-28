Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32300C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62DA10F005;
	Fri, 28 Jan 2022 14:48:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D07E510EFEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ14C9H+9bbI6bRBQuPlk5/qPm42+sr1sf+Q07kz8Z/nujByklP7wNK7aLHxw5NGHgySbRTDySbIpE0QuWWP3Wllw8TjngxQztC0S9MhjgyKViYrpa5C+AaGX0UUM86Qz7g03CdN3P0XnuiFGJ2fb6+2DK9bGrnXKEN58oAwjrGPnP1Nm+z/UzzLRXqrBkQvtjkPXrwWsIlSrU6M6hmiRNNLUFDU7xbihQTRqlrMn1icD3Y5nLYvXpKtzmokVTaNtWnu6tLqc3Ju6OsElkv8qV1sZ+Tfg7KwQR2B2OOz22ufP7S7/Y3xDmgbSI8ON5RC5npanCERrr6iE1UiSAU4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4JMGceT2ZNBfVaEXxe5sHrAACFcuEJRdbvG+fvXxdI=;
 b=cUQ5m0Me5gGYVcEudinVAUGp3jywW/XHJd1N2s9zSOnET4VgznFupIKekfOLJM2rix3A5gq0idJCUzW8oqeo3PbYjUVq4JECBmHUIbVgBJnx8l94cWp3s1wA4BOnuPhZNU6MEoDoNS0dEV9YcbYIdB/N1sCYi6lpLME0JbkizcmuDO2Hq8UqF+D/uK5L78QmGcBwjzG09XZ4iNELgR+b+deSGoVjkKPNGlpjwYayZDyXel+S0EqjimUtV7WPku64HJILZUUR9b5TvYI5Z+zxKgiKhetgxaqOWDYc+t2N0C2F3JtreyVNta4HGjKrsN3gJTxWmtwTR5wA9igxixP53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4JMGceT2ZNBfVaEXxe5sHrAACFcuEJRdbvG+fvXxdI=;
 b=VVTbGZfATxwBjOMnkqQo6qt7d1bC/u3/lqRGn+2Bpcg7/uPg9N+RYh0lX3sHYFfRq85esnv9hY0HcSeSh81TbHLj4Gk3Wntwr0YXhyAofGcV6NweANHaYIgkykSChaZ0RGGyULIoSAoziEAhW51TZjQpE5GA7t8gfuDZJe2LK+U=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB3339.namprd12.prod.outlook.com (2603:10b6:5:119::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Fri, 28 Jan
 2022 14:47:57 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 14:47:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix uninitialized variable use warning
Thread-Topic: [PATCH] drm/amdgpu: Fix uninitialized variable use warning
Thread-Index: AQHYFBH3eDpSkuzHzkGNiKdVtnrh2ax4g9Sb
Date: Fri, 28 Jan 2022 14:47:56 +0000
Message-ID: <BL1PR12MB51449BDC8B5304FF6CFB09A6F7229@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220128064019.2469388-1-lijo.lazar@amd.com>
In-Reply-To: <20220128064019.2469388-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-28T14:47:56.211Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 4b7c56da-ad91-41d6-d6bc-d4018996ca6b
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61c48a32-5dd8-4579-1e48-08d9e26d2c2b
x-ms-traffictypediagnostic: DM6PR12MB3339:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3339202D4FD1A3D489FF484CF7229@DM6PR12MB3339.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OA7KGwcFoZd5dOH+EEppxmZ61ZLQb2PpLMAK3jndF2Vq1YKqS3h3sJWhyYhHI4zW+C89laNIvWIzFhGP8duw9ZXg/G4ACImztIRkLpAMB8emKEpUVzro5fPwKArQyj4SOkKe4mTqrofdqdc2r8jWlT3AlzEI6FcPhRClktFQqTNLy3pTUKlDfykrCKnaskURvNIWhrTp6AM88m/64R3lbSCvyYtgtMHyaMiFxXh5vH67lBAL1vsSgg4EApNzb0gl470XDsgwjR/9Ay3m2aOs1d5uZzwjz8ob1ikUHCAt47fifl86Fd80PhA9SD+6CHOaBZydzM5duyk2ESKfgNnQouyPLyWH5si/V0Wrf4Ov/h72uru0fUHQqO13oZy2e/Q1g3sE9WvX3KKFCmlAgFv7pp/9+ZBKqYponEiQkDr1KlxupP3e7yWQH6Uw+BQo585Ue2S7icQa6Rbq9PhZvnviF5WuDWv2m1C+ISjDzFklkBrMYOZX1QB3gOiXhZkQ+u+ebvExN3L+nL2yeubOKPYsgpeAQ4lOYhgBNH4+ST60tR+nrUBkgRFj12p+99gQDMGK3xY1X4FdMuZS+2b8g8uMR0Pdiw18zV9jnlD5wMQFcTSTb92XGA35znVQ+OWv6vRb05ge6wpIfdb8mNqFjKYZtxYTmdn+Yc203EHnUyO8S0n2D3XrvvzjZi5hV+E1x9LBb9A8E7sStr7A1WMT4EN+mA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(83380400001)(6506007)(26005)(7696005)(316002)(54906003)(5660300002)(9686003)(19627405001)(186003)(110136005)(66446008)(66556008)(86362001)(71200400001)(2906002)(8676002)(53546011)(66946007)(76116006)(38070700005)(8936002)(508600001)(122000001)(38100700002)(64756008)(4326008)(33656002)(55016003)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uyfc2DRjpC1oFFTYIgL5wkjyDALKaj9clG+pSBbaHRYV49cJXU2Q7ZftTVcD?=
 =?us-ascii?Q?xIK3VsfPP53wHGbVCj+X93tbXusZN9YH5ArcH4nYxHCxriWTTgKqDrDjQex5?=
 =?us-ascii?Q?6z58ihp9RSwln8Ppxh585Eg24+DJGarQ1gpePJkSEgYuG3Kv0f67tckoaN6w?=
 =?us-ascii?Q?0nnHONI+Lnd89ImUMm44ixNRtZ+q0k5jHmw/G2FrgQa0rQ+DUujWD2st+jkv?=
 =?us-ascii?Q?/AS+I+1VLCEjvIqnQADVS0oN7fTRXt5knL38uvSa03kOdFE7fViN0p68mfVF?=
 =?us-ascii?Q?Vtxfmr1WlsHR8C6YGxB2zPX2vgMxz1elEEko9iS7sbGS0xXJhFh7XnVIqc2a?=
 =?us-ascii?Q?IWwiCnR8h5joTmhEfNt2ZDuk7KIxbwN6IHMZPXyaDOROgOEcBVrJUNEC1bT4?=
 =?us-ascii?Q?PiSrlNZO+6qCeveFSTfJRN7CTlXl1236eGcX8BnXHz23QwzDngJIvOs+lU7g?=
 =?us-ascii?Q?tSFwG99oTlF+vuNXFyxsWFl//JehzWO6/HHDqbJig0EwEhTq6DeSWh7zEMBl?=
 =?us-ascii?Q?Mqcx8y3/UEll9mHlLdV6cdDORIdx82OlHQ2JQSBy0lup21un2b0KVF5z+LFp?=
 =?us-ascii?Q?fG21u8CNbV7YNCN5SVfbxBxLK0JoWlALQAFWuwmlAaSQjg4DesHKXG+oD8J0?=
 =?us-ascii?Q?k+f00CyuURey6zGbfKgCMjVAeFqzr5UYfKyJPmQdY0ee8vsRUiyQWjlePRrH?=
 =?us-ascii?Q?4xk86IU+BoVzxIS15JlrliLw+w+WcljSz3RyzP3pbhxxyqErhwUA5rZAV/jZ?=
 =?us-ascii?Q?2qcsH119pWxZf4ujr22SHb022GqQAP0wyHUXOefCYzGevArHPghIH3DlATtp?=
 =?us-ascii?Q?/wyBVaSzTR0MUzTJhUEW3vMG5SzUi3jtyvE+QPfrI3FscPQdoGMRBMbUcAvV?=
 =?us-ascii?Q?ZWbGndZvZAJNTRONk/aSQ+Xsxf4pTRYIVWdrAr1lWJl5J/G4VntbPs83WHeE?=
 =?us-ascii?Q?R9wP/dl9X9+JlUSexUzsoGlH2LZjQHabrfbv6RwjyRIuxxBBcpFDPnnFVei3?=
 =?us-ascii?Q?2Tuf1xC4COr9oHe8epTaI9NDuGcpedzvUKSxHCQX5XynvNbPJc+oZ7Rg21Er?=
 =?us-ascii?Q?81iB5+Saf0lr5mUVB6elp7nqgUaWKB7IhPVDYaU9pGJc9GNAC7z2NVJEw4Wf?=
 =?us-ascii?Q?huYh1wbzfiDPLfWZUw9o1PmzKdW/qqlRKiU+JYNj6fPMkMrnNdAcSp7BSc1V?=
 =?us-ascii?Q?BPSfbAOY3LuyZwhrY4S8BVkecQHBDeRAg7P5hNljGRPC0IiXomAqZvpqqU6H?=
 =?us-ascii?Q?+ts1KP4R4ubD7nryHpX1zjECDfcjYPcdPRn+DfyGFP8u+/JOsDkWkAN/dhDH?=
 =?us-ascii?Q?S2KX8tl5SyMfc0fWAs45qXxeqEGS0Ha3J9I4uUVPhHu7sM+nk2wSDSDuhGE/?=
 =?us-ascii?Q?uqVx0nPsH7hRrMCkjm9cpIcoq/xP9T4MwewuCXgfbNuwsiHsiIZ0G8ZiGhEz?=
 =?us-ascii?Q?QvyDkdDgBYNtaBUJOeSLugkpIvQ5bEtTYNJr0A5ntOhvvWck1AY4nq0y3vPn?=
 =?us-ascii?Q?EpmzwvrhPUWs+ZWGXWnTmXKKrYcBcnM1vLjVkWoLM3vZmB1+VYjoyYfbxlkj?=
 =?us-ascii?Q?6NORTlQY7K/EXuap81NOuiGd21kbFpUaPQ3KuOoaE7G4o/yWE+ewB4e/uvLy?=
 =?us-ascii?Q?2xqO54F0kNl4RutaYxA9edI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51449BDC8B5304FF6CFB09A6F7229BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c48a32-5dd8-4579-1e48-08d9e26d2c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 14:47:56.9034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RhYL/uYrhxPTXl1+3TplknmlN3nX/HRjJW285JInaUuFBXQqiOrlLdz8zhEaa7CeaHvQOD0p0o3mQpV0udaM6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3339
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
Cc: kernel test robot <yujie.liu@intel.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51449BDC8B5304FF6CFB09A6F7229BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, January 28, 2022 1:40 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; kernel test robot <yujie.liu@intel.com>
Subject: [PATCH] drm/amdgpu: Fix uninitialized variable use warning

Fix uninitialized variable use
warning: variable 'reg_access_ctrl' is uninitialized when used here [-Wunin=
itialized]
     scratch_reg0 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->sc=
ratch_reg0;

Fixes: 51263163eb3f("drm/amdgpu: add helper for rlcg indirect reg
access")

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 80c25176c993..c13765218919 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -875,6 +875,7 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device=
 *adev, u32 offset, u32 v
                 return 0;
         }

+       reg_access_ctrl =3D &adev->gfx.rlc.reg_access_ctrl;
         scratch_reg0 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl=
->scratch_reg0;
         scratch_reg1 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl=
->scratch_reg1;
         scratch_reg2 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl=
->scratch_reg2;
--
2.25.1


--_000_BL1PR12MB51449BDC8B5304FF6CFB09A6F7229BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Friday, January 28, 2022 1:40 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; kernel test robot &lt;yujie.liu@intel.c=
om&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix uninitialized variable use warning<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix uninitialized variable use<br>
warning: variable 'reg_access_ctrl' is uninitialized when used here [-Wunin=
itialized]<br>
&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg0 =3D (void __iomem *)adev-&gt;rmmio + =
4 * reg_access_ctrl-&gt;scratch_reg0;<br>
<br>
Fixes: 51263163eb3f(&quot;drm/amdgpu: add helper for rlcg indirect reg<br>
access&quot;)<br>
<br>
Reported-by: kernel test robot &lt;yujie.liu@intel.com&gt;<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index 80c25176c993..c13765218919 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -875,6 +875,7 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device=
 *adev, u32 offset, u32 v<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_access_ctrl =3D &amp;adev-&gt;gfx=
.rlc.reg_access_ctrl;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg0 =3D (void __i=
omem *)adev-&gt;rmmio + 4 * reg_access_ctrl-&gt;scratch_reg0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg1 =3D (void __i=
omem *)adev-&gt;rmmio + 4 * reg_access_ctrl-&gt;scratch_reg1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch_reg2 =3D (void __i=
omem *)adev-&gt;rmmio + 4 * reg_access_ctrl-&gt;scratch_reg2;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51449BDC8B5304FF6CFB09A6F7229BL1PR12MB5144namp_--
