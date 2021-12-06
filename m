Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD94C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 15:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E87972C3A;
	Mon,  6 Dec 2021 15:23:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32D472C3A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 15:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lazDsBDczqg2VPzhkNJCn1/+K5nfNLlaw9jY3dSnFto1Ka5HQIgprbHwTBflpZOYq/GoNm85sSgYpb1gMt83TpBZQrzKVvx90XiCpmoVfuLlXmoS/rfHz2mEw7h8Kc5Tp4zeywi2K8AUJ961ArgTmk74se8S3aB9gGnhjmtRZDGhyo/2f0k+f+EaGUQ2OUUoouzhKZOzPqZ6NLvC60Yd47cOoo8J2xwLCJQyplPJJ1Gbp3V/bCzNTrWkH70wD0J6ZLJJQaTD58d564rrzBgOfOJgjROhmIecU8MQThk6ojOj//gRCCP2+U03NA5lTQ0cL51fMJU/PHvax+SRJ3rWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1liQmOBAnpqg1O7u1sx42THH18FyjTqlu1wgyiiFZAc=;
 b=FPcnvFT1I3oYcZIDm4J40+Sb3krZvGiTPoA8tJYcPIXGpzmseE2uGpSHKIzqyGcw5hTnX0KlnkV7UIDoGDy8QiOjFZFcRkj64CgnL2LSoJyb32o0mWbg6Ih4uOGdpENsJex6JTtb61wPHb65Q2Y62Tc/YCbmkl+0HbU5BTOUaQweuOX6+7/evpgJqDmuitvYA03IX3XEHBcXs33Mk1VqkZApW15zmtz2tge8jrLWLNVeUVrsSvqeLZagYLzgT7IPx5DhZTCzsqz+13WG3DwCgGhIYDmEzA1SXYtKVlAEuqZFUN/A1VP0qqEPd+rfZHvjI/5/nDXls9+ISI4yfdZ5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1liQmOBAnpqg1O7u1sx42THH18FyjTqlu1wgyiiFZAc=;
 b=VSJePudonW0BFgXqb29Mfa/PLCjK9yVxnezVbTZD4xQF80nwV4nHRm0tbt/t2Sx2Y+JPHGEvkXFuHeExsOC1UBNO9pt4jFykYACjA+XIUQytH8K4joJHjdRF7zBIDZQPvbdX+pzmcSQ2raqvhJxR8Kfvb7BNGTFGqJUPHEXDcl4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 15:23:47 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 15:23:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Cui, Flora" <Flora.Cui@amd.com>, "=guchun.chen@amd.com"
 <=guchun.chen@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>, "Shi, Leslie"
 <Yuliang.Shi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: free vkms_output after use
Thread-Topic: [PATCH 2/2] drm/amdgpu: free vkms_output after use
Thread-Index: AQHX6ovufwO/p1viOUG9OZo+JmQiQqwllVoT
Date: Mon, 6 Dec 2021 15:23:47 +0000
Message-ID: <BL1PR12MB5144B3CD4CAA4BFA6855BC8AF76D9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211206063445.104874-1-flora.cui@amd.com>
 <20211206063445.104874-2-flora.cui@amd.com>
In-Reply-To: <20211206063445.104874-2-flora.cui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-06T15:23:47.288Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 74a41050-c2a7-a2d8-67d4-f15cb8ff72af
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa15f8b4-56f0-46e3-c59c-08d9b8cc6656
x-ms-traffictypediagnostic: BL1PR12MB5255:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5255DF833FB448EAA85FD6FEF76D9@BL1PR12MB5255.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ww+TmKLknvLpjivixYUKOwZnYl9dotaBRdKgbn6mAJ7EzG57y3ulGi0oFbBUvPZ8jiWoPW+rb/sfxfJmrSg4YKq34hopPZz9pPYhj2ZfYuD/N6mGElBVPkb0rhT6t5J5TSLLkcV9fdWh9c3B9zmz0YJ8Rk6+Te05caRMNsWE+aubVPiC98+4DuysaHw+SwJA37qqohe1G76H8DUAHgpJBIJ31rtO5UId/zSWoEcOsrfv+RwAUmEZOC9V8vTDGjmdWjkwP0n6NkI9ORelIpzAaPKVelrIJ71IaiqrcGnREzwGNjf4VJUVlqN9Mjde8VFV8UwYYbxqauH5NTSBRpkA7aU7BukI9rbBpoAnqElRZ8e//1UGQqEtP4OCwWot5UdiZv2st+WrX2Oruu/987WqsstAKDSUuq2zHn9gcHvcuSHYHlYQgdB1A0jONTJ7MFzUUolb3oztWovoi4SRg7CAB0eDZECdkLFNpYYgQjjPH6NDWOE82jk2AZsIFi2ZJh4kLovI/lwX5ZvCwU+/kbMJvq40pIrU2WDKGjEdg5dV32wYnJQ9cQQGK+8xtjE5LzODGPz40rH9xNVr9WFA4RMxxFdCjG9B6uZB1zGUngp5t21orflLOSXl0XLSZZ+mXwVGjRML5kcUMOsGq4gkQj/rWPughzJdUyx5WmKqqMi1uCUkZhEyzwqOV+abCCdBKm/vvXSDzVuy6P/60kilm1VuLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(2906002)(38100700002)(66446008)(76116006)(86362001)(508600001)(66556008)(5660300002)(64756008)(9686003)(66476007)(7696005)(8676002)(66946007)(122000001)(110136005)(316002)(38070700005)(33656002)(52536014)(186003)(71200400001)(55016003)(19627405001)(6506007)(53546011)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p83zzy1eeVnoCmvuXxnbPP8Ym6o+keRVTt7M2YZBq9kpu85M7VNwaPqrghk3?=
 =?us-ascii?Q?2jZpXEQ8S1VCk39wojhWeOEsGSYXe7GB+LU+4q5bnXw/VxciufGoKNAc397u?=
 =?us-ascii?Q?UhxDEh04Ce1Lme3Tx5iGKxXjeTvVaAnAUPbs8So+K/wQH1xqEfHmsobesZQw?=
 =?us-ascii?Q?FrEC86e0mSzGG4U7vWOABbVPRJ+26PzpidvDtIyLK7wZE0X6V3cSpWg23XBp?=
 =?us-ascii?Q?3v8s0zY7OC9U7OkBIsRI70rTKuhIszxMRnjvmPaD6pT/8m03+Ia2Po5FeEVR?=
 =?us-ascii?Q?UW0lEKY5p2W1gJiCHt5dsxVy3qH9n9xg2FZMosGw4VnevVK1KF6hnZHlfP9w?=
 =?us-ascii?Q?Kt8W82xh8qJRqg7EKyq8gq0GF8VTDCHc/0rty6CJZauOFXr7s+Ei3wEHr55d?=
 =?us-ascii?Q?GluyAVHz/rvWlcWbqSEcyHBAM9Hy95efIk59fm/uGe0Sh3WcmhYKH3Mp8i42?=
 =?us-ascii?Q?Zh5tvd4TzV7Y+/DD38iUfd2Hi77laXpyVUKK3S8nIDgpJC1rTvaHRGyBYxv+?=
 =?us-ascii?Q?EP5Nxj2I3Bnc3BGb9LOxShVAs8BnC+9Jb6hk/8hbSpyKsiRdbAjGBP1/SEHB?=
 =?us-ascii?Q?rE3DthAwEGYgt816wtuIfV5uVB4xtTBe5/Imig6dQCWOmOcAvL1oMeS9D1db?=
 =?us-ascii?Q?iuWGH1dH5Vuc6Cv45XdjoqPW7YYEy3HUubv5x5iuru1xCKg9ZZmVJEhGVxLT?=
 =?us-ascii?Q?GJ4jk1hKLNxLKlQ2hPQrGNsLXoMt2yckt5OtoQqdSRJCEviTuE6N5VtYkGtT?=
 =?us-ascii?Q?PJZUZUV13KXhUgyXXajmFJQYrZQha+W7B7R2hVfIZSQPfF5A+FbwAXxkpR4E?=
 =?us-ascii?Q?fTf4BVMVBrqWjAQi6x1NM5OTtrgphdOBnPSnzJt2403oDcPNPduao245lZ4L?=
 =?us-ascii?Q?ebwMqLEKq0a/sl5tzb0YT/5Y4FFfF8YsldUVui6rh6iQtPh6dFI1h8Hl5kxZ?=
 =?us-ascii?Q?pbU6lEZm8O/jBGHp4byijETo2wUpcXLHID9kP9DmbAnnLNYOKssjPJCxuLUD?=
 =?us-ascii?Q?C9qKz5oinzPPb9aUnCbYpLGnoynsh5VVQjbEPhNy1Qqa42HNMfxHVmuLJS1n?=
 =?us-ascii?Q?j+6PzMebcu39yovX86ih3oGF+L5vp/jhzgX9QAwnXatpNo6V4TCTaGt2R5I2?=
 =?us-ascii?Q?37x1aovAnmVxIZBYmSnRybROQleEP8mOnSv7DsKiObMbDQzxo1JFdyM9oZq/?=
 =?us-ascii?Q?vCeNRseSfh4BTmEkNzrezn1M0jBqYUTJhIYE4bxL1+ZBkKgCsgjsTum4Ck1z?=
 =?us-ascii?Q?J5hN6sfar6gud/wQ4QmVADQUbMqIJLPU48kiuhmQWty9ro15zEsn/Q9VNLDt?=
 =?us-ascii?Q?6fHd0jz0CnFLTKxXxe1emycNQX3Gp0ujlGLWLSb+L42xsEaEWR81Ei9Hwjzj?=
 =?us-ascii?Q?CjoySpyM64Xb8b5LaLZw6LjCkpsAsB47QIv+ud1hL17seEyh1lKqnvXsFygA?=
 =?us-ascii?Q?RDBMrvDxYFJGLBSoKugkzOjWP+xJzzm0uoMLEAS/WMtFERm+oJiaGQPzBZLi?=
 =?us-ascii?Q?LdIEvxEai4+elIn5sHi/cqfaLKWzTeAUMtjj7n/9yfrSqkpVnd69yphs2sgy?=
 =?us-ascii?Q?0ub/83EnYl38izf51GPbACtahivf2RJqbM+ovcCmADRBfVqXFDTgJo1rH1/v?=
 =?us-ascii?Q?dQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B3CD4CAA4BFA6855BC8AF76D9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa15f8b4-56f0-46e3-c59c-08d9b8cc6656
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 15:23:47.8302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOchC8I7EwBTgdIiWGvuGNz6CkXQdZhFK+g9w0aBRvpcHJl4ad8f5h6iRFWxdaQgdHGGEsvVP4k9umwMAwWjPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144B3CD4CAA4BFA6855BC8AF76D9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Flora Cu=
i <flora.cui@amd.com>
Sent: Monday, December 6, 2021 1:34 AM
To: =3Dguchun.chen@amd.com <=3Dguchun.chen@amd.com>; Yuan, Perry <Perry.Yua=
n@amd.com>; Shi, Leslie <Yuliang.Shi@amd.com>; amd-gfx@lists.freedesktop.or=
g <amd-gfx@lists.freedesktop.org>
Cc: Shi, Leslie <Yuliang.Shi@amd.com>; Cui, Flora <Flora.Cui@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: free vkms_output after use

Signed-off-by: Flora Cui <flora.cui@amd.com>
Reviewed-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index acc2d31ea93f..af3a2f8c12b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -480,6 +480,11 @@ static int amdgpu_vkms_sw_init(void *handle)
         int r, i;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       adev->amdgpu_vkms_output =3D kcalloc(adev->mode_info.num_crtc,
+               sizeof(struct amdgpu_vkms_output), GFP_KERNEL);
+       if (!adev->amdgpu_vkms_output)
+               return -ENOMEM;
+
         adev_to_drm(adev)->max_vblank_count =3D 0;

         adev_to_drm(adev)->mode_config.funcs =3D &amdgpu_vkms_mode_funcs;
@@ -496,10 +501,6 @@ static int amdgpu_vkms_sw_init(void *handle)
         if (r)
                 return r;

-       adev->amdgpu_vkms_output =3D kcalloc(adev->mode_info.num_crtc, size=
of(struct amdgpu_vkms_output), GFP_KERNEL);
-       if (!adev->amdgpu_vkms_output)
-               return -ENOMEM;
-
         /* allocate crtcs, encoders, connectors */
         for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
                 r =3D amdgpu_vkms_output_init(adev_to_drm(adev), &adev->am=
dgpu_vkms_output[i], i);
@@ -522,12 +523,13 @@ static int amdgpu_vkms_sw_fini(void *handle)
                 if (adev->mode_info.crtcs[i])
                         hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_t=
imer);

-       kfree(adev->mode_info.bios_hardcoded_edid);
-       kfree(adev->amdgpu_vkms_output);
-
         drm_kms_helper_poll_fini(adev_to_drm(adev));
+       drm_mode_config_cleanup(adev_to_drm(adev));

         adev->mode_info.mode_config_initialized =3D false;
+
+       kfree(adev->mode_info.bios_hardcoded_edid);
+       kfree(adev->amdgpu_vkms_output);
         return 0;
 }

--
2.25.1


--_000_BL1PR12MB5144B3CD4CAA4BFA6855BC8AF76D9BL1PR12MB5144namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Flora Cui &lt;flora.cui@amd.c=
om&gt;<br>
<b>Sent:</b> Monday, December 6, 2021 1:34 AM<br>
<b>To:</b> =3Dguchun.chen@amd.com &lt;=3Dguchun.chen@amd.com&gt;; Yuan, Per=
ry &lt;Perry.Yuan@amd.com&gt;; Shi, Leslie &lt;Yuliang.Shi@amd.com&gt;; amd=
-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Shi, Leslie &lt;Yuliang.Shi@amd.com&gt;; Cui, Flora &lt;Flora.Cu=
i@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: free vkms_output after use</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Signed-off-by: Flora Cui &lt;flora.cui@amd.com&gt;=
<br>
Reviewed-by: Leslie Shi &lt;Yuliang.Shi@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 16 +++++++++-------<br>
&nbsp;1 file changed, 9 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c<br>
index acc2d31ea93f..af3a2f8c12b4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c<br>
@@ -480,6 +480,11 @@ static int amdgpu_vkms_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;amdgpu_vkms_output =3D kcall=
oc(adev-&gt;mode_info.num_crtc,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sizeof(struct amdgpu_vkms_output), GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;amdgpu_vkms_output)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev_to_drm(adev)-&gt;max_=
vblank_count =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev_to_drm(adev)-&gt;mode=
_config.funcs =3D &amp;amdgpu_vkms_mode_funcs;<br>
@@ -496,10 +501,6 @@ static int amdgpu_vkms_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;amdgpu_vkms_output =3D kcall=
oc(adev-&gt;mode_info.num_crtc, sizeof(struct amdgpu_vkms_output), GFP_KERN=
EL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;amdgpu_vkms_output)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate crtcs, encoder=
s, connectors */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;mode_info.num_crtc; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vkms_output_init(adev_to_drm(adev), &amp=
;adev-&gt;amdgpu_vkms_output[i], i);<br>
@@ -522,12 +523,13 @@ static int amdgpu_vkms_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mode_info.crtcs[i])<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtim=
er_cancel(&amp;adev-&gt;mode_info.crtcs[i]-&gt;vblank_timer);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;mode_info.bios_hardcod=
ed_edid);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;amdgpu_vkms_output);<b=
r>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_kms_helper_poll_fini(a=
dev_to_drm(adev));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_mode_config_cleanup(adev_to_drm(a=
dev));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.mode_co=
nfig_initialized =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;mode_info.bios_hardcod=
ed_edid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;amdgpu_vkms_output);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B3CD4CAA4BFA6855BC8AF76D9BL1PR12MB5144namp_--
