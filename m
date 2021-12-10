Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D93C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 14:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A971410E445;
	Fri, 10 Dec 2021 14:06:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C642910E34F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 14:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKD/pwntVt3Kl02mKmLIL1LGV9HjUgEv8ARDUjwjWVS3TNMr4SIUbbIoTdzyCwnijhS653t0vpkav8h9gDPoian+fXEnXNmIdO4z88VW/3oez3MHiA4iySqMbH5qmmUYkcuFo4jrL4+F80mM3cZ04qsxnSjvLKy8lMXtYBgYsLuRF6y0Rk2qAc2ZaRiFhR03cVlY29c81+eT4moRa9RCiuKw+9Ak2IJKdhU9opEu8usyn6M4JYqivRDU0ifiVjsjLOpbGYJVmDqC8r2yifRQ40QHFOIv0suNqnerxDelxt6kYznazWw3k+ot7XJcmpeANjX6hgytEKrakgEufw6SJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRn3lmFmhCUepjPfAdiQp171c9PhZ3PZFYgeFxwhv2c=;
 b=gDOZYBE2rcXwezYlQz2sSvZp+YnjBgsPj6lid3vls3yeUCR7d1lEILTqLVBXWaka1cgxJ3DwjRof7HwHCEM5wZnLm+Cyqq4rH8gyHs9QfPjaFDpGC3jtOajfkKdFvE00TiUDaRQO49j3YA/LCycg1jQOyFWr089Gvol+e6d5vw6Hv2HVjO4EQGLiPJJHRvK8ZwY65UoA1EvYjkgNkPSJfccgA/Vq+k8Zzy60tT5XQRLToA3+P3B/SHzUEb3LtNRuTKdnrPxnWe7UyILxwRt9RWUyqNIAwO36etynRuZFIrYvRd/kj/FYEzU+nArxLwNC4iF5gSpcJOYf+iKKI7U8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRn3lmFmhCUepjPfAdiQp171c9PhZ3PZFYgeFxwhv2c=;
 b=ScwJ2odwFThcHHIHWCoaY1U5QCZqJScVIzoenCW9RUM5gPgkgbBayP6hXpSEuT/tCjyVQSTz+ATgISIYWSOq+OVsrUMertyLSKj4h+ccyKSFUa76wPFajqk/YAoDYXiOf3UnTVFRaSnRoalPSkx9bTzXxCm1Y6DWzzovQsqZ8Mw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 10 Dec
 2021 14:06:46 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%6]) with mapi id 15.20.4778.016; Fri, 10 Dec 2021
 14:06:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "alexdeucher@gmail.com" <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix dropped backing store handling in
 amdgpu_dma_buf_move_notify
Thread-Topic: [PATCH] drm/amdgpu: fix dropped backing store handling in
 amdgpu_dma_buf_move_notify
Thread-Index: AQHX7aF2URruUUT880uwGlqfANK05awrwvxX
Date: Fri, 10 Dec 2021 14:06:45 +0000
Message-ID: <BL1PR12MB51445BD73E21F0125DB9E24EF7719@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211210083927.1754-1-christian.koenig@amd.com>
In-Reply-To: <20211210083927.1754-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-10T14:06:44.988Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 553a8ff7-c62d-a43c-9c7a-d2a948177259
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06468cc4-ecc2-484b-df4e-08d9bbe64d06
x-ms-traffictypediagnostic: BL1PR12MB5351:EE_
x-microsoft-antispam-prvs: <BL1PR12MB53513B7E9A9F518650BBBFB8F7719@BL1PR12MB5351.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHLur7/zi/4s1a9I5J6yibhhnuFGM7ga84GuDbYaQwDAt2iYCYKo1CB5OHxhEJ6Y8owjqA/WYCOb+uj5S2fGY7HAkfsaUboHCdHp5vXy8PJ4BCfj0MaxrYNsr0x17595FIv97286FbEz0+Fwxuj5YDG56yhIdT2YKO56t2leTcWZwvQONlIkzXQ109yCEQScCmsz+uZ2QYZaJX3QsFlH8bzOjJ3zQ6GjjsoOSpw3Yhek9ab6rrkPMyIVQV9kaat/6RyfRpYY1hzPm9RuoouTHbWdbBO+sr2Bz2fy+FEd//7BFCsgnbbyyJPg/cUzflS4d1P88Sbhpscs+Us/BlPkmc0qJg02l87/hUy5DXRU5rD/095C8OOKpTQSqM+9XQUY7/LxSPj7c1GtbppkaLDge9Ol3B6mTqb/TaHI7o5lKRiDyxvaOGpSgQWGGi3uy+p0MdS466vE+j+H/cAsa+KHTvYoVfKfmjAlH09p1/E9ZPBsX2SvrxxxIZSpH3iUM0OhgtxvIm49TKwmktp9IT/p2l9qDIeDfAHmo0VyrFQXZkGDBHxthTr8lkfUHx8luefc1okEhqQ6TCxUzWBhTovIFpr2HR1EikaS7mA4ElnAtW8mSZPGG82Bf0BeihvEVuJXJyZvI0wCXxmXeYHOmeFLaQKzGb/1w2cBZZk2N0wy2fjieiqJ0sxJDxb7qkVyBHsylHkcVMwQ+V4xh+0txozxPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(66946007)(45080400002)(66556008)(66476007)(64756008)(508600001)(53546011)(83380400001)(316002)(66574015)(110136005)(2906002)(9686003)(966005)(6506007)(26005)(76116006)(7696005)(19627405001)(8676002)(71200400001)(122000001)(86362001)(52536014)(38070700005)(166002)(186003)(5660300002)(55016003)(33656002)(8936002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Gn4oeHhU53NrOraU7C/tK30YDTOo6F66nYwO7jRl7W5rjTjX2qztru3DAn?=
 =?iso-8859-1?Q?aNdxjMNVb0KcD2FN3Wdfj/G7E9cItIo3yl7Kbe1rjddAGHsYLf6CX0lHpT?=
 =?iso-8859-1?Q?C5ugKMvUHM7DcZsCn/uVNM3bbyHw9ln/Sm0islwHqTvDitwZPzdmVJoPUC?=
 =?iso-8859-1?Q?crXgXAyEsN+2MjXidEONxZmoHFi6M6vwFLt7fDwDL/FqUixqi0WrY0Fp8x?=
 =?iso-8859-1?Q?OopH3wWE7pgtTmkqNs69S6TzK8om3R+eFxON0aqN7GAnWevTB1RESBD+sF?=
 =?iso-8859-1?Q?i2+EHRuKyB13DMcD/SjeB0d4md5odXoCqXVYDQMSamBnJ77VRouzJWstqw?=
 =?iso-8859-1?Q?8CGOMwImHoyADqaGyitDlWNbhD42qR/6KgZ22dWE4CaZivpVPXCGmPS6ma?=
 =?iso-8859-1?Q?z+pCamuVie4l27nNDmH2gCTT1XJmWimuCfV8KV4uSewf6/VX9NZbTa3UOD?=
 =?iso-8859-1?Q?UL1zDU1rCUbMBZP2H8tmY9PcgYhxhp73fDVrCv3qNeHT3VxMuZEBK5T20P?=
 =?iso-8859-1?Q?MoVKDhuSkXaNUKJR7BK0paXAbfD8jxi9NV/Ju0P4hJDLgV3CJCFBxR5ZyH?=
 =?iso-8859-1?Q?jPAzICA9Co4bTfk/NvaLguxSBjAvN3gW7erYdt/fGJ5JrQIxAvirUFcoMm?=
 =?iso-8859-1?Q?GcX8Erfa7i2ToTHN7GT3VCWfmYSIahJ2VdjeleFz96VP1ygkC3hJjiGPdf?=
 =?iso-8859-1?Q?NjG7rg07V0klYXJDFtr+NZ1oUqb9Qlcebx/DifkR+Kw0fPmRoMkYU4rg/G?=
 =?iso-8859-1?Q?aPztugPruyxsyQVlJ3Qk7T5vHptTJafaRvquEBJvXb4z6xdCExOOeoDBpD?=
 =?iso-8859-1?Q?Pr0E+NfZQe/kmWCYD4mKIo2orjpRc05erpAQDh0HpbZ7Ec0f194aPwSTuy?=
 =?iso-8859-1?Q?0YwJOE+aMQvPah6XI1mTKJIlvV/oSTWUjg22YlGNXeS6DwYmTNWy1I+Vx2?=
 =?iso-8859-1?Q?L8v0gO1BBZ4lrDr2UXXRSOsovs2bqGRbe3t9stGbb97rkpP/7Si026aS9D?=
 =?iso-8859-1?Q?l2kqyvEW92rhp5e+6wM0C6ibrJeww49IPWF4Apwfnr3svjblxrZxjJlpRu?=
 =?iso-8859-1?Q?iClBarUXRjsXlqr2+QsacYwA8rCatuy+1A1JN4qfJzsyJNKrlTXjzopcax?=
 =?iso-8859-1?Q?/c2T1zD+0G7mDqGth0Z+o5WhqQXsJpT7ODFvJc4QnOjQCP4moLuSTzXNPr?=
 =?iso-8859-1?Q?tygZrH6B+kA46rHRYovblg1VzgBQCX4oLgVtFpaBPU/mD6E8XoA0CSYN2e?=
 =?iso-8859-1?Q?7cQW4yeaTOWVbXQPgxstnpGmMZa3nJEjDcJbcODaxBJaYydCpnbkajoGlb?=
 =?iso-8859-1?Q?fiEmY430yXa88tvUcB2VXEYsyhpfb3fy4kY/En61OFDfy5rAm32OYEmsAe?=
 =?iso-8859-1?Q?vj87NgYTiiCeWUK9FmYb1tqyXxavGRpfT/axCquAvpA0AvQxEjs2P/iWNM?=
 =?iso-8859-1?Q?0wN9Tvx51WGrEDz8FPQJog1938Cu7zw/HVtMfQko8fExJ54kbA8ehe2ygz?=
 =?iso-8859-1?Q?oGQ0IpUnsvX4aLnEhLtucd8uiMCLd/cYlOvQuatdHvCq0AhXS9YA0jM9Df?=
 =?iso-8859-1?Q?xmkderPPmmILxENULmSqq+IoufolcogBmO7P00BwgzVuE65WvFz5DKkMaW?=
 =?iso-8859-1?Q?jGRLMJVqrcjPFhLR9xT8yiDHNB6SI8dRBteyg1wj8fhW0qAS9A+Hs2dCiD?=
 =?iso-8859-1?Q?ke7Iau+iV5AnhhEuzmk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51445BD73E21F0125DB9E24EF7719BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06468cc4-ecc2-484b-df4e-08d9bbe64d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 14:06:45.7866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxCMVnfZ24FBUvPYSKw1dmehgnaSKLw4aqIl+JXaQsx0eUuNSWtxRH7xE8EvepqSx7pXyDFii3eOPI9Y2mTp1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
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

--_000_BL1PR12MB51445BD73E21F0125DB9E24EF7719BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Friday, December 10, 2021 3:39 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; alexdeuc=
her@gmail.com <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu: fix dropped backing store handling in amdgpu_d=
ma_buf_move_notify

bo->tbo.resource can now be NULL.

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1811&amp;data=3D04%7C01%7Ca=
lexander.deucher%40amd.com%7C8ece16670f1b44091a4308d9bbb897e5%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637747223768954678%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&a=
mp;sdata=3DN4gltO0T3wozmHbROWRr3RiWFWXNu522ghTewe8T3bA%3D&amp;reserved=3D0
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c
index ae6ab93c868b..7444484a12bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -384,7 +384,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *a=
ttach)
         struct amdgpu_vm_bo_base *bo_base;
         int r;

-       if (bo->tbo.resource->mem_type =3D=3D TTM_PL_SYSTEM)
+       if (!bo->tbo.resource || bo->tbo.resource->mem_type =3D=3D TTM_PL_S=
YSTEM)
                 return;

         r =3D ttm_bo_validate(&bo->tbo, &placement, &ctx);
--
2.25.1


--_000_BL1PR12MB51445BD73E21F0125DB9E24EF7719BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Friday, December 10, 2021 3:39 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; alexdeucher@gmail.com &lt;alexdeucher@gmail.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix dropped backing store handling in a=
mdgpu_dma_buf_move_notify</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">bo-&gt;tbo.resource can now be NULL.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Bug: <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1811&amp;amp;dat=
a=3D04%7C01%7Calexander.deucher%40amd.com%7C8ece16670f1b44091a4308d9bbb897e=
5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637747223768954678%7CUnknown=
%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6=
Mn0%3D%7C3000&amp;amp;sdata=3DN4gltO0T3wozmHbROWRr3RiWFWXNu522ghTewe8T3bA%3=
D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.=
freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1811&amp;amp;data=3D04%7C01%7Cal=
exander.deucher%40amd.com%7C8ece16670f1b44091a4308d9bbb897e5%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637747223768954678%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am=
p;amp;sdata=3DN4gltO0T3wozmHbROWRr3RiWFWXNu522ghTewe8T3bA%3D&amp;amp;reserv=
ed=3D0</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c<br>
index ae6ab93c868b..7444484a12bf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
@@ -384,7 +384,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *a=
ttach)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *=
bo_base;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;tbo.resource-&gt;mem_type =
=3D=3D TTM_PL_SYSTEM)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bo-&gt;tbo.resource || bo-&gt;tb=
o.resource-&gt;mem_type =3D=3D TTM_PL_SYSTEM)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_bo_validate(&amp=
;bo-&gt;tbo, &amp;placement, &amp;ctx);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51445BD73E21F0125DB9E24EF7719BL1PR12MB5144namp_--
