Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A440C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 15:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027C210E78B;
	Wed,  8 Nov 2023 15:07:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B64E210E78B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 15:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ML+dzdJBN7FIqhaTXsp3Grih3QBAxmu/536S8tkgneNbTTgUKpL3N7qzzS8W2g98TlFNf5F8U3Tj4kv9PT+ZTv3a7a61xXMywCX9fdd6d60pgHIB383Mtn/G05vBzrG2Tcfpz+pY1UyhsBLRta/gshO8VDzocfHUvfVamnp74AevGKKQrxCmxk3PZs1hUshfVDlCR6lHtj3BMm5aB/r6hTguBsyX5LbI2trDKqptLmL20tX2VJyHf78DPqPnI02rZmabBQyj5ZDN3T0DpqjDC6ZqeeKlGLQAS9QjwIbTgb0OSXmfLO6s+J4eh+O4nX9Gd1WOtVRojrbAlZuoqe8swg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD4VSbqjog+vClg7xE74YmvHq/b9dbJfIbMXtefzDp8=;
 b=TW+Dff26VaO3oL/3grdnBJp8IljyqTc2izf6g2sZdOSbfqcOlt97IW2ARwqasJtqMvRqSDnkXxfvqgNqAxpIKK6asrVvQe1MFaEQoKmMNc2tUhQPFkU8X3Toq2/SIJoG5ib0JXASeywoHEHgvrhYubXJldX4lJ2mRbaGUecrbjvZTiyFRjPxiwS5Mnkoo/zHw91jTJOf9HqB7YV9ux0rFNCVYNEcQV0muoo+uiS+j89R+zSF7Rn2YhCDUEp4bZJ5jnC85C55aHXQgZVAMcANV1gGmpl/xlyQDjjDIxUgQ8eTiJYmkLR78DB8OJ/XoppItlQ8ufWseT9mDabqqntl9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD4VSbqjog+vClg7xE74YmvHq/b9dbJfIbMXtefzDp8=;
 b=aQQdnWlif5i7F57CXq4rORlg/4NtGMBW1d6Z3aZTInmvlAywSYTQ0PgfZaUqerL5I3wkvHIBgKxpy6haRtOClHRRI89NmcUUyBoN8b8O7GMFNR76anFMuaGXJuzAD5uMfnPgGkBUCAW2XY0YJB1+YB2o/XdTrdDmgs8IqpJW274=
Received: from DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 15:07:42 +0000
Received: from DS0PR12MB8503.namprd12.prod.outlook.com
 ([fe80::7399:91ed:6cb5:d018]) by DS0PR12MB8503.namprd12.prod.outlook.com
 ([fe80::7399:91ed:6cb5:d018%5]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 15:07:42 +0000
From: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>
To: "Dhume, Samir" <Samir.Dhume@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Do not program HDP_MISC_CNTL in hdp_v4_0.c
 under SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Do not program HDP_MISC_CNTL in hdp_v4_0.c
 under SRIOV
Thread-Index: AQHaEbEwnPHy46h4RECyn8n/lSMV+bBwg4KAgAADIsQ=
Date: Wed, 8 Nov 2023 15:07:42 +0000
Message-ID: <DS0PR12MB8503AA16A3EB7149CC7A4600FAA8A@DS0PR12MB8503.namprd12.prod.outlook.com>
References: <20231107193210.2375-1-victorchengchi.lu@amd.com>
 <MW5PR12MB56004BB3E9D96CCFF6F4E62AE6A8A@MW5PR12MB5600.namprd12.prod.outlook.com>
In-Reply-To: <MW5PR12MB56004BB3E9D96CCFF6F4E62AE6A8A@MW5PR12MB5600.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-08T15:07:41.375Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8503:EE_|DM3PR12MB9413:EE_
x-ms-office365-filtering-correlation-id: e1cd94ab-b5f0-4cc0-4bf3-08dbe06c74c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ppJLmM3leYKlc4rnpHnMoMafqgH2oLVRljQh1uda8jN5gTG9yuGA/T+/BnApG4M3Ovr7wjLQFze1/hn9+utTiPENYqioZWrIVjf8nbfRHe47zvwfFHOvm0xSXOhnWAc8I+JtYEr/YegM8GlfAZVggYcseWBO8vakapqw9r21HfKwqK3gegy464Tp+XWcOCKhWMdEPqWxXMp5hBgc22jnpqCgKOYm5VUWBNLiuXBH7X6l9/IcV3IEiEG580wybpI3xlc27f4jeOPeiN7h2ZsPJeq8uRy+OW4K+QbQn/pkbs769OfknP35cVpZgx5ESc8/PypnVbcYrTEp2LWlgRH3FJOQQXQ9IhWw/zIZXtAe1Ixr+GBaQzNM1dfOablIPjpkVJTMbp3UPSsTEwk7vCZtOyCcud37/Rqdy05O5X6tUL+6l1tnGPmkRU/rLBzoeY8fEcu5+pG05wNNKzca4v9QvCtVXDGMqsI7zFMF/lc/snILCOUbKn84Tb8hyuFIu8k0hL8Dt7cwFYdKhIucm6QI6cqntf1QB60M4vq/8Fz7wHrGFvFKnWoUcHNDSiyFrgGV5EPtATaOBwGVFxuXypr9WYSSE3ifVRF9U3OYcfaKrL5J8mujPgpgd9uJFq0IwTGY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8503.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(55016003)(19627405001)(9686003)(6506007)(7696005)(71200400001)(478600001)(53546011)(38100700002)(33656002)(86362001)(122000001)(66556008)(5660300002)(66476007)(66446008)(76116006)(64756008)(66946007)(41300700001)(2906002)(26005)(316002)(38070700009)(83380400001)(91956017)(52536014)(110136005)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mS+lmFIq2iN4ymRvAULRm9+x1/jK2J0PgXH4DlgKjdtKzxKR0qD0EmN1+wmH?=
 =?us-ascii?Q?k2WJogrH8TQzRK9j3LfFlNP+nR7l6HXDfVWmHg4pcv32ZHF4PidmVXDY2hQe?=
 =?us-ascii?Q?vaA8zMZTN0ZLVDEeCFKRCGD5gdmNrd7WGeZWe8cU4sRzj6WNzcRKmFt+Jkbo?=
 =?us-ascii?Q?dQx7DY108nGR+iRlaSBllhIHGpYIeLOlEcg4Dowi3jzE5jrdwkJbuQHab6Dw?=
 =?us-ascii?Q?ka1BxtaxKjruficA4Zqb9sGb+QCnWqdLRWEsiIfBds4bIXeaRuocyVsIILnn?=
 =?us-ascii?Q?McdUZ2q+10mGECZW5WGvn8On8OeWApjGbfyeXcRJTETC44VE1eOpV0+ryvwk?=
 =?us-ascii?Q?7XlyPI/c/uDGD24dYtNDOYVAe8mtSLylNAcOi5OIsF3p02NydgG1fNLlCGtj?=
 =?us-ascii?Q?3A6OQK2pFsHu+nP5MWjAb6RqCnjC47y8AXFIqD81/HNrIerEdT2nwVch2qUL?=
 =?us-ascii?Q?k6d0NszvCsN3U0r9pUzSHFPsK7gOhty51cHoycHxJtOuJCXra9CkrwOySqtb?=
 =?us-ascii?Q?/ExmQy7l1JxBbXMT1b2GD6+8vWJW5XH3fKmzY8zRJpQ5CTCcZWh+O1NRgGbQ?=
 =?us-ascii?Q?6JL/QIZltnXdcHCZy/3sbdstbsd9WMTu4bgP1F7UJPTo3B9JqTmal8yfqRmm?=
 =?us-ascii?Q?Non6+/tAm5ddGjjZA9SecJCVHoMxAzc7lWHrwD5i7SRBaazBYkDJQAYZq/23?=
 =?us-ascii?Q?ShjGpWaMOpDw7Arv/IVwonujacuETyaXDIE4Z0wY/8bf/jXn3PEEi5Q+j7+p?=
 =?us-ascii?Q?afvYImYev3rrUd0xXAgmCtHtCteqzA/2eFdve6cELy+Xiy4E25I5puPJhGKU?=
 =?us-ascii?Q?RqY/ef+9ZCrzIbxtAMIZJCqJ9X3H6wLxIq6MpZMlfsYknSRazcFjNjYmmoz/?=
 =?us-ascii?Q?iasJHml14dOgYTy9Bt4lKZl643AKCY2NCbjWUuOY9jsNTqbzOP/Noo50zX8s?=
 =?us-ascii?Q?L/PYDUCC9S2ZWq7CCDVhM/pJdmxSx1LEcmkRHvj0SgI2Z0wn6Szo4Y2NF+iq?=
 =?us-ascii?Q?suwG+1r4yjrV2TSIny5rkiAb/nRTg4T5ThdxjrTmAToKmeaRK6G8+l1ogS5c?=
 =?us-ascii?Q?7tmjCM1DWdo93d47rs6goroL1CmFjoAbjUJka/oy1YGl5/WM7N6iPB3B2Y1b?=
 =?us-ascii?Q?iIsPwX8iZhVmuM/AmDr8npvQO2QtYkAubj4S/JJDP8QfA9ul6YOzhO1yDXoe?=
 =?us-ascii?Q?ey0rKu6JkkJX5qIrKvfuvwO3UFM1HZDylar4T7IP++JMKidqFgw17RWOlU5C?=
 =?us-ascii?Q?rwQiLgx2fjejdfrcGbWs5S4/NPvSJE2okxvpPw0FPbGjlSqclLeZHo2cduE9?=
 =?us-ascii?Q?YkArNjctbxa6wXGOQ+4Tog2hDTBLktHDRdAddPwqbIpq8wOYtNEJ1LStRXJy?=
 =?us-ascii?Q?n2t0pLOlW2i8xLHEvE3popoS1eCau9vYqusub/MgTbKpUQbiQ9K8apKc0XmX?=
 =?us-ascii?Q?STwvJfmC4+JMdPSS0Or/z5G/z9RN2Evv2aftCr49GGSolL3COD7YkkFuduEm?=
 =?us-ascii?Q?v9OKABrupOAZyyA7nyc9WIXX3HvFQsorbJ/AIdjk6fHlEmLbLJ17RT4jyCaS?=
 =?us-ascii?Q?BHVKk9DF0WTbPuJznx8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB8503AA16A3EB7149CC7A4600FAA8ADS0PR12MB8503namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8503.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cd94ab-b5f0-4cc0-4bf3-08dbe06c74c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 15:07:42.2533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmwE+exiSkvAxIh6EfFhAl5iIRnzzXp4pq3yIJrvRhRYlV4vd6/T8z4uI2v3HXfdLanSl3LA+W+YvYqyAwUJSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413
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

--_000_DS0PR12MB8503AA16A3EB7149CC7A4600FAA8ADS0PR12MB8503namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Yes, those regs are restricted to PF writes. I should update the commit mes=
sage
________________________________
From: Dhume, Samir <Samir.Dhume@amd.com>
Sent: Wednesday, November 8, 2023 9:54 AM
To: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>; amd-gfx@list=
s.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Do not program HDP_MISC_CNTL in hdp_v4_0.c=
 under SRIOV

[AMD Official Use Only - General]

Do you also need to skip programming of mmHDP_NONSURFACE_BASE and mmHDP_NON=
SURFACE_BASE_HI?

-----Original Message-----
From: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>
Sent: Tuesday, November 7, 2023 2:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Dhume, Samir <Samir.Dhume@amd.com>; Lu, Victor Cheng Chi (Victor) <Vict=
orChengChi.Lu@amd.com>
Subject: [PATCH] drm/amdgpu: Do not program HDP_MISC_CNTL in hdp_v4_0.c und=
er SRIOV

This register is blocked for VF access.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c
index 3f3a6445c006..bf3bdf67abb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -145,6 +145,11 @@ static void hdp_v4_0_init_registers(struct amdgpu_devi=
ce *adev)
                break;
        }

+       /* Do not program registers if VF */
+       if (amdgpu_sriov_vf(adev)) {
+               return;
+       }
+
        WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);

        if (amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 4, 0)=
)
--
2.34.1


--_000_DS0PR12MB8503AA16A3EB7149CC7A4600FAA8ADS0PR12MB8503namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Yes, those regs are restricted to PF writes. I should update the commit mes=
sage</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dhume, Samir &lt;Sami=
r.Dhume@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 8, 2023 9:54 AM<br>
<b>To:</b> Lu, Victor Cheng Chi (Victor) &lt;VictorChengChi.Lu@amd.com&gt;;=
 amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Do not program HDP_MISC_CNTL in hdp=
_v4_0.c under SRIOV</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - General]<br>
<br>
Do you also need to skip programming of mmHDP_NONSURFACE_BASE and mmHDP_NON=
SURFACE_BASE_HI?<br>
<br>
-----Original Message-----<br>
From: Lu, Victor Cheng Chi (Victor) &lt;VictorChengChi.Lu@amd.com&gt;<br>
Sent: Tuesday, November 7, 2023 2:32 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Dhume, Samir &lt;Samir.Dhume@amd.com&gt;; Lu, Victor Cheng Chi (Victor)=
 &lt;VictorChengChi.Lu@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: Do not program HDP_MISC_CNTL in hdp_v4_0.c und=
er SRIOV<br>
<br>
This register is blocked for VF access.<br>
<br>
Signed-off-by: Victor Lu &lt;victorchengchi.lu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 5 +++++<br>
&nbsp;1 file changed, 5 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c<br>
index 3f3a6445c006..bf3bdf67abb7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c<br>
@@ -145,6 +145,11 @@ static void hdp_v4_0_init_registers(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Do not program registers if VF */<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(HDP, 0, HDP_MISC_=
CNTL, FLUSH_INVALIDATE_CACHE, 1);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, HDP_=
HWIP, 0) =3D=3D IP_VERSION(4, 4, 0))<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB8503AA16A3EB7149CC7A4600FAA8ADS0PR12MB8503namp_--
