Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306CBC25B08
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 14:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A544C95204;
	Wed, 17 Aug 2022 14:18:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B9814AA8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 14:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S018111O2fbs7M3bR798lwpHtHYowYZc69UcFkInutLzY+im6njuGvrJew/qMmEV23bSs+2s1GMh2LCugWrSjZ2F6GQ6pb6XeNfBDBXJ08sPUcvqtPw0SaTlFz88YXfm6Rx1zaQsF9J7o1rA+Q/kY7UWBTKvjV7AV8WIz2v2Nl/ouiiW35hyBNIg3vcwlbsFtgTZFpaQ8i94IMd6A7EIexkT6p+zoIKSw2+6mDDVyUkKGpCkjfyOKKA6UbDXARrAA2Sd2P1q/i6JSEXsE8tWQGtVBNyglzhzEzKkfEs72hH7h+PSjnGcAKgSu4ygwqgt3Mxu5kEsUImBs7mgjj1ynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/DspEOBHPs6NY1Nu47rNrcx/B1Sd8B8UEz6jpS4B3A=;
 b=iW1BbZuaF6o5eplYR52oAKuLzQFu76FI1BV/TWt1M0R/V46YXuPPB+Ucv1k94gs0RPoh8RwiebkfbeN89SsRcI5MLeYmBFDLgC5UUCKKqwu0blxdBs9EoSic7iGHv6qKbDw+0yQviE0aNLpGS4wri+XXmdRGXKvSupWR8FPev6Qus5jJA77Q6kzxTW8k1ghUKsQRfK2dIQuvjdxT11XqJvO0Hfd1nUbFYljFAsVViNTwW+eLW+1Iq8uUveyF57cMw4GcIcnIXBmLf3wUquHdD9nRyDg/SQ1jvJPqix8CXXwfncLAD3YnPaakEk6e0j599WhacfoBw8GYzI7MmXD44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/DspEOBHPs6NY1Nu47rNrcx/B1Sd8B8UEz6jpS4B3A=;
 b=zRLy8smoeE027BkdeprKpkWy/3o+KVYZaVw6TkU95OmslVqKNQfu5EWDaoTuI2MD+yYRfCFvchrfmdb3E2+PFlzTNFxrjHLSPe+aDou49jumismP9dcBrqGjcDxdoA9nywK6g31KHKpGEIst+ya/i7bPoCIq4mCV9QCWATHhv/c=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA0PR12MB4350.namprd12.prod.outlook.com (2603:10b6:806:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 14:18:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::b938:8710:3028:4e99]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::b938:8710:3028:4e99%4]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 14:18:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V2 2/2] drm/amdgpu: fix hive reference leak when adding
 xgmi device
Thread-Topic: [PATCH V2 2/2] drm/amdgpu: fix hive reference leak when adding
 xgmi device
Thread-Index: AQHYsgFndLDhdBFTc0GICPZHD5CMPa2zIWk+
Date: Wed, 17 Aug 2022 14:18:04 +0000
Message-ID: <BN9PR12MB52573E364709F1D10700D2D5FC6A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220817061854.706010-1-YiPeng.Chai@amd.com>
 <20220817061854.706010-2-YiPeng.Chai@amd.com>
In-Reply-To: <20220817061854.706010-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-17T14:07:39.6556621Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03c77479-e5ea-4584-7114-08da805b4cbe
x-ms-traffictypediagnostic: SA0PR12MB4350:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQybaf/5SNGDZxK9AwHvjY+pV3e3Uoan2FF4YW+T7HhklSw77yc1bwBdWgkAJ2vEaBCDJ0nwLXTz8nhwnqFfkQ4NZBFMLGT7Q969VjGBVzXeDac47mc5Ysk+XTY61blwt6KTIUstJaxj66ixSM7DwY+EcOoyCjfKObCUmHww0cPpSDhEJodhcMRroMXeLf6T4Iyj2wNAMmxwH3Gb98XcCfw5u2lCYRLTS+TdrGysV1PfonqH3oqsabQ+dtUtyEgM+xErdNy9KtkjJ1qaa3KvBvml5GNKtsS/PpwdptmZFfR3GOX8TAWvfWQcXH9uaSeYh1usUSAOgTppA7StckVZ/38710rBWi6CpfokzUdbFE1DSSoeICgqzBySh8mzcd7W4oWhR8xc/2npoaPY//osuqvCe/faCDjsh9OXfFn2prPvJMXc9KgwIJYEqyKtcMnr93CI4GqzJhQEaoloHBWK/C3xKxk2wjD/K+ncwvHAfMupL8yrwY1oK6jxoCsPfojCGc6KbsCol2aXfZAcTmijL0aI7iePTca26QuTqgKvtqZ6p/jWdZJIOitooG8KFchpL/CKdMMdf4WdoptQtw/RQW8fEdGvVA1E23AK2Z+qora0qrNtisBBPblGxaENRWvHTGfhyRF0ebGRGrN6zDbwOyWqcbvigPtUwznW+3WQgAvYw5I2vpN8pSe/OjHISuky9UslGqmLsxVlPlBVTojQRwAZNPRtSguSrZ8pa0ITTI6Fn/vq8I+q/9pHgZYFESGhBsrVfb7aujqKn1Faba/mJ3iYfBpj0QVibXbp//LewGE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(110136005)(54906003)(316002)(122000001)(4326008)(66946007)(38100700002)(66556008)(66476007)(64756008)(66446008)(76116006)(8676002)(55016003)(91956017)(9686003)(7696005)(6506007)(71200400001)(53546011)(26005)(186003)(41300700001)(478600001)(33656002)(86362001)(52536014)(8936002)(5660300002)(38070700005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GQoHhmMNNrSli+M/mYyLS4QDUpEXWRj4z2i9+dgcT97ZoqxsGqKqTMV0+2Pz?=
 =?us-ascii?Q?BiHLE3U5Pbw594LyEvViSHLuWF9Mt/ETPB9So2ZCCKTydnLYsc5xVN8eobZw?=
 =?us-ascii?Q?adbIroK/eyxkXnd1bwMYlBpQC/p1A3qGybWN8WXXj4151tAGC2bwVovmCcI0?=
 =?us-ascii?Q?lAgwNmaNfdGuA0fffLqJSk35ftTJCETGGppxlBlCq0W1j+0KZDh0vLpORo+u?=
 =?us-ascii?Q?/6ovWC75q3t0ssmpp4GUD0ozPlpxnBafpEBSpBoX0QdDfQ7Vm6fndljpvrAq?=
 =?us-ascii?Q?V+0gdY/J4sv9IswNM/Nkt/xlXIUVvBLwra8EzyBsgdADb+e+WDKz7wXrO0pt?=
 =?us-ascii?Q?t9cQ321EgLuP6PdoZ+HLHirTJ6abjw6UhwnbTgXvVSTrIdW5XoYaTwqQRgqP?=
 =?us-ascii?Q?7n80pzNs+DW4O86KgMBlqZNApYtEn2bEx3UQK+X/+w/vRUsNCXozGm9U70WZ?=
 =?us-ascii?Q?dhiOAG/KQFMzc2DhmL7/bSBjXGYspIJWAdKtS9/v23iIDAXJlR1YzfuyH/4F?=
 =?us-ascii?Q?prYriW/iQ5VHsb6TO/a3vXf39O4BRu2JXCXYaPEisp5MqEfVNmPEtN6pNaHY?=
 =?us-ascii?Q?KZYfZPJmHea2+xN5xJvHt4bfpoORoIP5iwXRIjfSQsz4Zo8iyuAXM7d2pMtw?=
 =?us-ascii?Q?1IaLbhuFcxrHM4g/THgxlF2z+47k3y2tFSul89lrrnKMmpdmGtxeJNhOWUJ9?=
 =?us-ascii?Q?RZ1kY1FAshxjSUZKtvX42HHPqBIOLXNcYQXXMP4aUaoZKQTRjGPbQC08GSOv?=
 =?us-ascii?Q?HswREXOEgWrlVCk+b/jlXspS5SI5ZGLpj6GL68bnI/pDh/mu5xEAj36l6wxe?=
 =?us-ascii?Q?gaow0/+wSwerSZ+6CZ5tZ850ixXwUMI4grjToxFX/653o6vP5W8NXkjRdovE?=
 =?us-ascii?Q?T1kikEy7Dj/vVYDKzk8IFsuuw/Wmt+1uJajSTD4S1UIH9pZ/EA3F8a3Mm0BF?=
 =?us-ascii?Q?XsqWR56IRfldhxSUCKQD+dMf35EvbNlgjjMT9kxISP/J3nsPsXlE7XEnER7y?=
 =?us-ascii?Q?59eQ2ASfGd0W/BpTOR0kaHMup0Bhmf5YjGGXkcU6N1QAvzuDTp6RCXwtqSWp?=
 =?us-ascii?Q?xztzO9dSUadWtVV4T7QstuJzkl+kDGNFZfoilGehpIokzxNsRoj/D7uE/7Dp?=
 =?us-ascii?Q?oVnZsNVZtRI/QBBkbHi8pisHqVcY6u1BL0MGvEz59BbbQaQm3cN2kut6jXRp?=
 =?us-ascii?Q?pMkhzh/i7bTHy7UsffT8IqF0xyVotkQOiC1/TfHDrCiW16qMAW11Hp9tJ/jX?=
 =?us-ascii?Q?6vIpV4wuUZ04j9GAcYBIqKTWUBxVRJJLfPBOrtgTxwFzu2jdXb/C8XJ7e7Bv?=
 =?us-ascii?Q?M8FAHg+V0Q7T6aINz77vhB7WcI9MKYpGQ9UlGcyAJuS60xSN/xckEL8zBaLd?=
 =?us-ascii?Q?3ZTDcWnDzoQKZCThcVR2CEQSwAdefjlObhwKvlvCjAMoecPnrAsQCLfRSMwb?=
 =?us-ascii?Q?NIdUFIvURiO5p7Mf7qof+WMYAFMCLZjFIeXspzhYHL3SWpljWCVg0VdHapWe?=
 =?us-ascii?Q?vdYMTE/xzmn64uiRMxWW8N2Ly1R0e4mpVzGZnezbjKDSbpGxXuhJZygO7qYj?=
 =?us-ascii?Q?rk3RjnTvmCMjQ9VT3ujYHl6MdX6JjQOfGlwbGqsDYgDCH5xuub0eQOEHxNqc?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52573E364709F1D10700D2D5FC6A9BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c77479-e5ea-4584-7114-08da805b4cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 14:18:04.3506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQQYS89cFW3VNQBNMXVPqPZKVy7Jd6HRGRAosbnL9qGyVo5wzYci1asKvSUloaVUrz555KMpEsDJRCaheY2/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4350
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB52573E364709F1D10700D2D5FC6A9BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Chai, Thomas <YiPeng.Chai@amd.com>
Date: Wednesday, August 17, 2022 at 14:20
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chai, Thomas <YiPeng.Chai@amd.com>, Zhang, Hawking <Hawking.Zhang@amd.c=
om>, Zhou1, Tao <Tao.Zhou1@amd.com>, Clements, John <John.Clements@amd.com>=
, Li, Candice <Candice.Li@amd.com>, Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V2 2/2] drm/amdgpu: fix hive reference leak when adding xgm=
i device
Only amdgpu_get_xgmi_hive but no amdgpu_put_xgmi_hive
which will leak the hive reference.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index c84fdef0ac45..cf55b9354831 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2456,12 +2456,14 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)
                         if (!hive->reset_domain ||
                             !amdgpu_reset_get_reset_domain(hive->reset_dom=
ain)) {
                                 r =3D -ENOENT;
+                               amdgpu_put_xgmi_hive(hive);
                                 goto init_failed;
                         }

                         /* Drop the early temporary reset domain we create=
d for device */
                         amdgpu_reset_put_reset_domain(adev->reset_domain);
                         adev->reset_domain =3D hive->reset_domain;
+                       amdgpu_put_xgmi_hive(hive);
                 }
         }

--
2.25.1

--_000_BN9PR12MB52573E364709F1D10700D2D5FC6A9BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Menlo;
	panose-1:2 11 6 9 3 8 4 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
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
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Series is<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Reviewed-by: Hawkin=
g Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Chai, Thomas &lt;Yi=
Peng.Chai@amd.com&gt;<br>
<b>Date: </b>Wednesday, August 17, 2022 at 14:20<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;, Zhang, Hawking &lt;Haw=
king.Zhang@amd.com&gt;, Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;, Clements, Joh=
n &lt;John.Clements@amd.com&gt;, Li, Candice &lt;Candice.Li@amd.com&gt;, Ch=
ai, Thomas &lt;YiPeng.Chai@amd.com&gt;<br>
<b>Subject: </b>[PATCH V2 2/2] drm/amdgpu: fix hive reference leak when add=
ing xgmi device<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Only amdgpu_get_xgmi_hive but no amdgpu_put_xgmi_hive<br>
which will leak the hive reference.<br>
<br>
Signed-off-by: YiPeng Chai &lt;YiPeng.Chai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index c84fdef0ac45..cf55b9354831 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2456,12 +2456,14 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
hive-&gt;reset_domain ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; !amdgpu_reset_get_reset_domain(hive-&gt;reset_domain)) {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -ENOENT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_put_xgmi_hive(hive);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto init_failed;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Dr=
op the early temporary reset domain we created for device */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_reset_put_reset_domain(adev-&gt;reset_domain);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;reset_domain =3D hive-&gt;reset_domain;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_put_xgmi_=
hive(hive);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB52573E364709F1D10700D2D5FC6A9BN9PR12MB5257namp_--
