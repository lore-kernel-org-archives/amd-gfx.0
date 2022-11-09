Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442BDC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 18:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C78C910E61D;
	Wed,  9 Nov 2022 18:38:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C0F10E614
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 18:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbXsbuLMkPuQ+RCvOmU8CPqZzfz/ljp270M353Tm4vvZvOOvvyMWQ8Khsb5qOvlWK6nV+sf7hIxxQuhfuA1cUWh1h+tSQPn6m+GRcnO5faswpDW4CPODY8OnkbEZtyZgPWvKbfj1O8L48LbvSZ9oP52pCtbZ2khY23OVd3JEBzN1cu9HGkDZhze2vYFg3y+xfE7hEjeyBM9bkC3J3z9uR3uHTyfAjiNjowy/tqzDVR+mBsRz9gyGpFjbh+7jR9HjGLuJxicPGNKJfulMPEECgiG8a5kswcaoSlvHtts5ZcH13i/VugYhUXm8D7CRylfJxIphsVMO4/amBFI4RVgadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7ZwyarjQd/aRIy5OAoelmiVcQV/r5QPt8YH+fHXMKo=;
 b=KeGRTAnAlS9meLwZYwpr7q+ybiXeOWsTvT6zVYQyei3kWqadLPcN6xfTX+YPHJ8/ky79P5Wj+72nTHygHIT4g3YF/XtmiD6U8KrneVgFaxY7qJnUhBlQHzHf2di8VOSuMdPofzCdp6nnzQqbU2JlWPut2PedjsSWjFjYuILVfWn+ktZ0Uy8Xv1Rz59eQwdqdyw01Z4Pd6FwI0oR+uAWG1t11wlz+ZkanXeQzwI1XxfrZNQUvF8uy7GGT/dq2u7RY3DxPYhoYCnvme5K6/dWiQjoakz+u/QP6XJOtS5G06uqdzTSTluJ/9rzihOEL7LRwn28br/0mJrisi1t//H357g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7ZwyarjQd/aRIy5OAoelmiVcQV/r5QPt8YH+fHXMKo=;
 b=Kwz6mizMlLQOhay0AtZXSCZGcIVAced6+DegVhfcxLHN8LbjaH6SnZwnOMoA+ljEWyJ55pOKX/uCOJXUoTZVcBdMhymSM+TmzFb7JQslz9TxwGr5n5yo8A6RUKDHZL9fnJ3oG9fIHAMpbmrvW4Vr+ZwP3OFby16uDXZFdTThKMw=
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 18:38:51 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::ca6:5273:6972:38ef]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::ca6:5273:6972:38ef%9]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 18:38:51 +0000
From: "Chickanayakanahalli, Sirish" <sirish.c@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix for suspend/resume sequence under sriov
Thread-Topic: [PATCH] drm/amdgpu: fix for suspend/resume sequence under sriov
Thread-Index: AQHY7zmg7Jkp1P0N1UGaQyHlZJdBYK4slOZAgAphS1A=
Date: Wed, 9 Nov 2022 18:38:51 +0000
Message-ID: <DM4PR12MB5182449CB433A374932FDE788A3E9@DM4PR12MB5182.namprd12.prod.outlook.com>
References: <20221103040605.796752-1-Victor.Zhao@amd.com>
 <DM6PR12MB43400434192DC55507A93424FA389@DM6PR12MB4340.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB43400434192DC55507A93424FA389@DM6PR12MB4340.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-09T18:38:48Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b4f48c2f-2dec-4fb8-8d0d-9a310d327d38;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5182:EE_|DM4PR12MB5119:EE_
x-ms-office365-filtering-correlation-id: a851b87a-0a59-4984-5933-08dac281a5bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P4ecIDmmhC63QdohPr/m9fydKobbBGfVZZKO3dDKvWDGiS7p0S3Di7CFzPzbDYThh/eUCFJ9V2aX8ml6g2R4ds9y4nmzPkFWZUhooOMCl9Yjx8P0ooSQ7dhaQQvqg3Rjysf9ZFnn40JVtjOnXRaHyHmr/adHlwQSZsqzuBMgZsonty04qPSDYyRH2aCr2wh5YoBdNW85teu3iwZP8FC6RRFsUy7K+KqIIRCcgofKLZneQunAO1TkVnjg3dZdDBupDObTC6EJcASyiDsKOvq7wgrZtRnaEsRiDJ7+2AVuNU0tdW3azui7MraJiQBMm92BP1aBc7VX8JltBV2Fb5CD0powiyw6FclC7no0J2LyZeuOH0gec8AgvaVkHZzvXI/r/Uty4MkGByGXv3Mj8bIqmZu7CGb9lpq5D6sKze07OvrgU0ClDAz8mFcIWb7cE/Y+Lnd4wNiFOVGUfolOAUNnnnCvsxBEjKfHuIHqov9OYXhEXYVaZnN31vf3wYO+yKtVvC4czeYo+xRrUN1eSeJvB3W6tIOxoXJY6bIZP5HO/fNADievTvvPN6xkcIS9p9QtYfmmOgZLErxDEKAFrZouh/ijCUyOCLdlQEItANpnzWYziOr9AX8CAyQm+0XqvxhXfmiNs0DdoGSye24gwXfjcCmUeoV+f2A4SOb7MAnrbAmmqjoplcHfhG7uGBxHI4AiKTBcTERE5uxHkY0OagKcr5Eg5MvF4hs6makIotG8maaLCWJ1s/UTRw0q93rCzrSObOT/qWUVrX1xwOpXeQX73Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199015)(110136005)(6636002)(5660300002)(478600001)(66556008)(53546011)(54906003)(71200400001)(76116006)(64756008)(83380400001)(8676002)(26005)(41300700001)(9686003)(2906002)(8936002)(52536014)(4326008)(66476007)(15650500001)(66946007)(186003)(66446008)(38070700005)(55016003)(7696005)(6506007)(122000001)(33656002)(86362001)(316002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8cKussWWawLBw8Tq3hk60p8QA8h6RlTTGqWUtBf//Qu+8Km9onsC1S05poX2?=
 =?us-ascii?Q?bRFixaIp0aWB0/rb9cKVvQvTt8zzN0mikUE5UVeJ1ROju2pfpA61nE6ZlbRZ?=
 =?us-ascii?Q?X7SfI0Fmh4vtPM5zMnvXR5iV0GDXkosaRSfHsHc2c+W9mYzUU0aX7hUMKZvP?=
 =?us-ascii?Q?OyT8cBKCMAlzKoLIQg47gsWxqSl7aIdGjgtA7bii7x/OEQ4TordD05cy1OLs?=
 =?us-ascii?Q?ahHvpiO58Li0/Awqgjp0GByFn2PFyAMYRbp7C+5+j+JG5cw8tboi6wm622Jw?=
 =?us-ascii?Q?fnKKpzBimBa8dvfdDDEFnvD45PZcL5YRMjqc54WMw+nWm12FV6sqsesotIta?=
 =?us-ascii?Q?yVUbEhzyjalpJ7LDYtV2owsz6au/C86kXeqNZ+gPzkdU772FbQ4YfoyoC9HI?=
 =?us-ascii?Q?kYN3aTOiV3Ay4s6B/sHoypcoW3aVWuyoxkNYNx0vb/99goJqcye51SdCX1Oe?=
 =?us-ascii?Q?CgixZZYpvAPLHJ9ghIacGAdL0QnaTs3pkS87m0ofJV/K5ELdv5XEJPdQP/xK?=
 =?us-ascii?Q?CjfBXmvjLLDpXexRTzKwnOB7bhbtku8GPGzV0CTYum8Tn/XxzeSnTiFv82Ye?=
 =?us-ascii?Q?nv2UXbjpPJYA1l29MGwE81OFh8Zc5Z/CWgYCRxVRiccG39wr6H2nQ20RfSRL?=
 =?us-ascii?Q?JD7/+LkI14sdJu4RuyZgrMdRMnAeZ0633ob8LbHi0Y6kmHiNNnFqMTDyCv7s?=
 =?us-ascii?Q?k6YLYeZpsMASpnqx2Vstm47fQ3JxYaTWBAra4qo2hNa4cVf9D7SCwdzkjpic?=
 =?us-ascii?Q?O3pHzdmesktDQ2JUW5hfQ+gH+hVsegqE+q55IkExYvMtx3dqS/le0ajsSMBJ?=
 =?us-ascii?Q?M52xxDSGHwYa3xqAz5xm7ev8fLtM94OX28LI9i0Wk+xR8RyQejdtEhUqqoYi?=
 =?us-ascii?Q?AnZzvUg+09S5if6h2WRpqrHKnPGI83OReRYQUVxg3ognS0XUxVONusqIldzJ?=
 =?us-ascii?Q?4yignDzGne/jZsP/O/qv6a31YfnVVEAds6Z+aDaMTBPLc5BpDYyoNDeceSsf?=
 =?us-ascii?Q?mFNKWtMVetGwqp9TTDk8sIt/p2KdSG+QyfWHblppUqE+PXExbb9GOroIYw0Q?=
 =?us-ascii?Q?mZp6AjRt1awcsFKFq1fkdTdCt2cZ0hOVx3vLpgu12Hxgp7ety5DTHTne3nqt?=
 =?us-ascii?Q?CuTHNirY/Ao9Polbq8a7MvZOJOd9JMUuNkJnTtNaAXoyDMplnzVPG9XWwZan?=
 =?us-ascii?Q?YJeeYgbgQRST/KL/t7MgDw6gI0GyNRFF1jAt8pz1ZRnhcYZIADJwSJo0AH7k?=
 =?us-ascii?Q?MtayHqIkc3+YSoc/mttQViezThJkub4qq93ldO4293IfqD7MJmH8Ddy5JFb/?=
 =?us-ascii?Q?+cakTTBaMgUN7mtB947MiDxoZd8DTL8Vu9HbP9rDI5hzzeV7G8eX3u6TSe1D?=
 =?us-ascii?Q?Zbx9ekknVPL2CtBRGJga4V0qTs4kGQtVP9xNXlLtEu68mWublOps+XHyJyhU?=
 =?us-ascii?Q?WIwAFjJ7NUVCO25PLtYzpCNAAcwDTdVc7tERCbv/ZQnxcyFOoxGSgVXbE/CR?=
 =?us-ascii?Q?5bUpv7tiU+AjrPCGLe2aqPwYAUk8yfinETZ5sYJmapGKbmQirkbwHV5yYyun?=
 =?us-ascii?Q?OUKkRzNUNGvDrSphCklRTidc9ePd6KKlWlYAbYoq?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5182449CB433A374932FDE788A3E9DM4PR12MB5182namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a851b87a-0a59-4984-5933-08dac281a5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 18:38:51.2966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+HpoNRT21sdi3pQeNVs0O7CPC1fvCHqiks6y/UIe8q1kac+KVMbbXVkesnJ4sFEbDU/snDzOLDgnflQhxRQfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Jiang, Jerry \(SW\)" <Jerry.Jiang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5182449CB433A374932FDE788A3E9DM4PR12MB5182namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


@Deucher, Alexander<mailto:Alexander.Deucher@amd.com>



Following up on this to see if the patch reviewed and approved for up strea=
ming?



Thanks,



SIRISH



-----Original Message-----
From: Zhao, Victor <Victor.Zhao@amd.com>
Sent: Thursday, November 3, 2022 12:08 AM
To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org; Deuc=
her, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>; Chickanayakanahalli, Sirish <sirish=
.c@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix for suspend/resume sequence under srio=
v



[AMD Official Use Only - General]



Hi Alex,



This is a patch fixing the sriov suspend/resume sequence. Please help revie=
w.





Thanks,

Victor







-----Original Message-----

From: Victor Zhao <Victor.Zhao@amd.com<mailto:Victor.Zhao@amd.com>>

Sent: Thursday, November 3, 2022 12:06 PM

To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; De=
ucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.co=
m>>

Cc: Zhao, Victor <Victor.Zhao@amd.com<mailto:Victor.Zhao@amd.com>>

Subject: [PATCH] drm/amdgpu: fix for suspend/resume sequence under sriov



- clear kiq ring after suspend/resume under sriov to aviod kiq ring test fa=
ilure

- update irq after resume to fix kiq interrput loss



Signed-off-by: Victor Zhao <Victor.Zhao@amd.com<mailto:Victor.Zhao@amd.com>=
>

---

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++

drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 2 ++

2 files changed, 4 insertions(+)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c

index 522820eeaa59..5b9f992e4607 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

@@ -4197,6 +4197,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool=
 fbcon)

               }



                /* Make sure IB tests flushed */

+             if (amdgpu_sriov_vf(adev))

+                             amdgpu_irq_gpu_reset_resume_helper(adev);

               flush_delayed_work(&adev->delayed_init_work);



                if (adev->in_s0ix) {

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c

index 7853d3ca58cf..49d34c7bbf20 100644

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c

+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c

@@ -6909,6 +6909,8 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_rin=
g *ring)

                               mutex_unlock(&adev->srbm_mutex);

               } else {

                               memset((void *)mqd, 0, sizeof(*mqd));

+                             if (amdgpu_sriov_vf(adev) && adev->in_suspend=
)

+                                             amdgpu_ring_clear_ring(ring);

                               mutex_lock(&adev->srbm_mutex);

                               nv_grbm_select(adev, ring->me, ring->pipe, r=
ing->queue, 0);

                               amdgpu_ring_init_mqd(ring);

--

2.25.1

--_000_DM4PR12MB5182449CB433A374932FDE788A3E9DM4PR12MB5182namp_
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle22
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:blue;}
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
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><a id=3D"OWAAMD3450450D7EF4059BBB8826BF515F3BA" h=
ref=3D"mailto:Alexander.Deucher@amd.com"><span style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;text-decoration:none">@Deucher, Alexander</span></a=
><o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Following up on this to see if the patch reviewed=
 and approved for up streaming?<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">SIRISH <o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Zhao, Victor &lt;Victor.Zhao@amd.com&gt; <br>
Sent: Thursday, November 3, 2022 12:08 AM<br>
To: Zhao, Victor &lt;Victor.Zhao@amd.com&gt;; amd-gfx@lists.freedesktop.org=
; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;; Chickanayakanahalli, Sirish &=
lt;sirish.c@amd.com&gt;<br>
Subject: RE: [PATCH] drm/amdgpu: fix for suspend/resume sequence under srio=
v<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">[AMD Official Use Only - General]<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Hi Alex,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">This is a patch fixing the sriov suspend/resume s=
equence. Please help review.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks,<o:p></o:p></p>
<p class=3D"MsoPlainText">Victor<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<o:p></o:p></p>
<p class=3D"MsoPlainText">From: Victor Zhao &lt;<a href=3D"mailto:Victor.Zh=
ao@amd.com"><span style=3D"color:windowtext;text-decoration:none">Victor.Zh=
ao@amd.com</span></a>&gt;
<o:p></o:p></p>
<p class=3D"MsoPlainText">Sent: Thursday, November 3, 2022 12:06 PM<o:p></o=
:p></p>
<p class=3D"MsoPlainText">To: <a href=3D"mailto:amd-gfx@lists.freedesktop.o=
rg"><span style=3D"color:windowtext;text-decoration:none">amd-gfx@lists.fre=
edesktop.org</span></a>; Deucher, Alexander &lt;<a href=3D"mailto:Alexander=
.Deucher@amd.com"><span style=3D"color:windowtext;text-decoration:none">Ale=
xander.Deucher@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">Cc: Zhao, Victor &lt;<a href=3D"mailto:Victor.Zha=
o@amd.com"><span style=3D"color:windowtext;text-decoration:none">Victor.Zha=
o@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">Subject: [PATCH] drm/amdgpu: fix for suspend/resu=
me sequence under sriov<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">- clear kiq ring after suspend/resume under sriov=
 to aviod kiq ring test failure<o:p></o:p></p>
<p class=3D"MsoPlainText">- update irq after resume to fix kiq interrput lo=
ss<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: Victor Zhao &lt;<a href=3D"mailto:=
Victor.Zhao@amd.com"><span style=3D"color:windowtext;text-decoration:none">=
Victor.Zhao@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++=
<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp=
;&nbsp;&nbsp; | 2 ++<o:p></o:p></p>
<p class=3D"MsoPlainText">2 files changed, 4 insertions(+)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_de=
vice.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index 522820eeaa59..5b9f992e4607 100644<o:p></o:p=
></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<=
o:p></o:p></p>
<p class=3D"MsoPlainText">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<=
o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -4197,6 +4197,8 @@ int amdgpu_device_resume(st=
ruct drm_device *dev, bool fbcon)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Make sure IB tests flushed */<=
o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_gpu_reset_resume_h=
elper(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_delayed_work(&amp;adev-&gt;delaye=
d_init_work);<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_s0ix) {<o:p></o:p=
></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0=
.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index 7853d3ca58cf..49d34c7bbf20 100644<o:p></o:p=
></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">@@ -6909,6 +6909,8 @@ static int gfx_v10_0_kiq_in=
it_queue(struct amdgpu_ring *ring)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;=
adev-&gt;srbm_mutex);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset((void *)mqd=
, 0, sizeof(*mqd));<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &am=
p;&amp; adev-&gt;in_suspend)<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_r=
ing_clear_ring(ring);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;ad=
ev-&gt;srbm_mutex);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nv_grbm_select(ade=
v, ring-&gt;me, ring-&gt;pipe, ring-&gt;queue, 0);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_init_m=
qd(ring);<o:p></o:p></p>
<p class=3D"MsoPlainText">--<o:p></o:p></p>
<p class=3D"MsoPlainText">2.25.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM4PR12MB5182449CB433A374932FDE788A3E9DM4PR12MB5182namp_--
