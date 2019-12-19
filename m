Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B487BC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 02:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876F9227BF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 02:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Dc68kBfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876F9227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0786C6E072;
	Thu, 19 Dec 2019 02:48:18 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750047.outbound.protection.outlook.com [40.107.75.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E406E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 02:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJrvh3qyBJp7/i6HRmItc+B/ahKJz9FKuytiVMsdUQbIH4UBQyI6kFEWrhLN3FvySHkqLVKqW6oW4BsTWP82Egg/nTUp6XlCJCJYXXjbdiGZTQ1aTxpCy326GWS3BG4Zt7H1oUVu3AUW13SmJGxa2zytDJr+ESNvwG8UzSag5xpgdXh8G8gaP9LbkB1B/WMvAV5GcJRWsTYnVReO0Vzd98oULkXkeMvNbodIJkev0niZefGVZKNMPeDml3oqdcP8e6zEP1Ookkb5yWIHiTMqBOuMtxTCiGS7gJKEEjgAhjsqJGZxmgn4+em23i/f+6pI91y6nciZn2CvW5n8ZB6WuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMgveCag/m2b44Eka9mFKorl+LxLiZjp45eOnEmqpJo=;
 b=hTmZhrMGZHrckbStrslzZkt902jtbX/Pi0ZyC1FPOD7OO7ojSKQBtTKO13ej70+OqQeyWfw9RnQZ/MCPNKoCp9gf9vo0n740HJESwNYxA0m0pIqJX+hnP/B/syFGKFCaYn2wIV/VACEd9i7KK2U5le3V/Xxr3KohSTlhnRM3qKUinsDXEBBcuP1PJnbZqbuQDa1Pp9K/m4hDEXkHA0hirbqI20Mmo98C3LJ6cXWoP7TDFgX42plG/wRNlYNZvn6ktXKsM66fDIO2mNBA627gpLCJ2eCxV4sw6fnv2bLeJMkpIi94miegCrXJhnm+FNefTlwe6FjA4CZQqKbtO6dHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMgveCag/m2b44Eka9mFKorl+LxLiZjp45eOnEmqpJo=;
 b=Dc68kBfARA14W33Zh3XFz5fDALn+7LBy3dArPRE8Q8UM+pZx8+l/igAqxBEtTHObDyPGk52hvjGNuGFwIGr2p2hgak1nM1kYqMWWSQBn5Uuw9LYcS3P1nyTebYaB4KYosdMrIK+DYsNiANSeDbt8gk8qsHUode/nrSIfEMDV+rQ=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB3085.namprd12.prod.outlook.com (20.178.241.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 02:48:14 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 02:48:14 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Wang, Kevin(Yang)"
 <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training(V2)
Thread-Topic: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of
 memory training(V2)
Thread-Index: AQHVtYBENFQSO958p0uozCUflj9QRqe/lvIAgAABbrGAALwcAIAAbQ9Q
Date: Thu, 19 Dec 2019 02:48:13 +0000
Message-ID: <MN2PR12MB2957401601B970825564553E95520@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20191218085050.28635-1-tianci.yin@amd.com>
 <MN2PR12MB329636BD472939B12B08EFA6A2530@MN2PR12MB3296.namprd12.prod.outlook.com>
 <MN2PR12MB2957F19B488696AF8A61D46A95530@MN2PR12MB2957.namprd12.prod.outlook.com>,
 <8a2e22db-989d-2169-eed6-dbe174a4d44d@amd.com>
In-Reply-To: <8a2e22db-989d-2169-eed6-dbe174a4d44d@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-19T02:48:13.211Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a7a0f34-49fc-4395-6504-08d7842de4a8
x-ms-traffictypediagnostic: MN2PR12MB3085:|MN2PR12MB3085:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB30857822227EEAD82DC65F3B95520@MN2PR12MB3085.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(129404003)(189003)(52314003)(199004)(5660300002)(64756008)(26005)(2906002)(6506007)(15650500001)(19627405001)(7696005)(71200400001)(9686003)(478600001)(55016002)(86362001)(186003)(81156014)(81166006)(33656002)(66946007)(54906003)(76116006)(91956017)(110136005)(53546011)(8936002)(52536014)(4001150100001)(8676002)(4326008)(66476007)(316002)(66556008)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3085;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qrBGl8qn2lOWJxpc0OyCMX2ioDCE/nkmL6TIeveOl/45ZeebyuQr9spca5kgnQLc/TiBwgYTXEONhoUD2AXRWZi/UDFuLk49an6s5fsbiqrJ3TYCuLLO4omBMk1yFTQFfIWji/M9GZLFRzSrGzBkN+nhPMp4SFm17mVUsUdWhvDHJo+vF7jYoUVEgoIhRv05GVHwztof4IhccOGNKjkAH/BWZdTyDjN6sb+N8d8fB6bJL6itcCYYsWJeQcWl1wps0hPozmVuSKn7uUbgYIEowQ+cnm9dhBhweeea+giPLPli8wy+FSBGxrQzgkkIkg2p6EVmn51vP1mEGZZLXKCijj2IpzvjQXV7gRFZkFAqrZioqiGnw471XaLDa/OvSKlN75SxJ4ODTPON7/N5yW7x2rKyiMyQpGSBCwvsCi3F/uVzk1WWBF+ZxGuDakBbSzGfx0wvm/C+PlH1O+wahlCef5d3yEoJ4uGoVqd2U4YGEdll6AXqTWH8AYnthtTBgNJfFza45mFFHjLuIOMK8v+G2Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7a0f34-49fc-4395-6504-08d7842de4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 02:48:13.8481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DTrOP94PuUUV4uCINxRPUDflU+oJpplt4vGUL87oCi8bjgRV6ZOR/KPDm98SA1J3spvSKXl+ql9GqgfMt9Mfyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3085
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: multipart/mixed; boundary="===============0270491352=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0270491352==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2957401601B970825564553E95520MN2PR12MB2957namp_"

--_000_MN2PR12MB2957401601B970825564553E95520MN2PR12MB2957namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Luben,

Thank you very much for your suggestion and detailed explanation!

Patch has been refined, please help review.

Rico
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Thursday, December 19, 2019 4:14
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang=
@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <=
Feifei.Xu@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Long, Gang <Gang.=
Long@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of mem=
ory training(V2)

On 2019-12-18 4:14 a.m., Yin, Tianci (Rico) wrote:
> Hi Kevin,
>
> You mean like this? It's a bit lengthy.
> - ctx->c2p_train_data_offset &=3D ~(ONE_MiB - 1);
> + ctx->c2p_train_data_offset =3D ALIGN(ctx->c2p_train_data_offset, ONE_Mi=
B);
>
> -       ctx->c2p_train_data_offset =3D adev->fw_vram_usage.mem_train_fb_l=
oc;
> +       ctx->c2p_train_data_offset =3D adev->gmc.mc_vram_size;
> +       if ((ctx->c2p_train_data_offset & (ONE_MiB - 1)) < (4 * ONE_KiB +=
 1) ) {
> +               ctx->c2p_train_data_offset -=3D ONE_MiB;
> +       }
> +       ctx->c2p_train_data_offset &=3D ~(ONE_MiB - 1);

Using the macro ALIGN() is a good practice.
Usually when calculating a quantity, such as the one above, you'd
use a working variable, say 'a', and after you're done with
the calculation, you'd then assign it to the variable which
needs it. Something like this:

a =3D adev->gmc.mc_vram_size;
if ((a & (ONE_MiB - 1)) < (4 * ONE_KiB + 1))
        a -=3D ONE_MiB;
ctx->c2p_train_data_offset =3D ALIGN(a, ONE_MiB);

The easiest way to see this is, imagine, if all this calculation
was offloaded to a dedicated function, f(), to do:

ctx->c2p_train_data_offset =3D f(adev->gmc.mc_vram_size);

Now, by using the working variable 'a', you've shown this
abstraction just the same. (By using the working variable 'a',
you've shown to the reader,that this calculation is abstracted,
and could be relocated to a function.)

Regards,
Luben
P.S. The compiler is probably already doing this, and not working
directly on the ctx->c2p_train_data_offs, but assigns a final
result, as explicitly shown above. The above is to make it easy
for humans to read and understand the code. Hope this helps.

>
> *[kevin]:*
> *i'd like to use the marco ALIGN() to simple above code.*
> *anyway, the patch Reviewed-by: Kevin Wang <kevin1.wang@amd.com>*
>
>          ctx->p2c_train_data_offset =3D (adev->gmc.mc_vram_size - GDDR6_M=
EM_TRAINING_OFFSET);
>          ctx->train_data_size =3D GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index f1ebd424510c..19eb3e8456c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -66,6 +66,13 @@ struct amdgpu_copy_mem {
>          unsigned long                   offset;
>  };
>
> +/* Definitions for constance */
> +enum amdgpu_internal_constants
> +{
> +       ONE_KiB =3D 0x400,
> +       ONE_MiB =3D 0x100000,
> +};
> +
>  extern const struct ttm_mem_type_manager_func amdgpu_gtt_mgr_func;
>  extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_func;
>
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm=
/amd/include/atomfirmware.h
> index dd7cbc00a0aa..70146518174c 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -672,20 +672,6 @@ struct vram_usagebyfirmware_v2_1
>    uint16_t  used_by_driver_in_kb;
>  };
>
> -/* This is part of vram_usagebyfirmware_v2_1 */
> -struct vram_reserve_block
> -{
> -       uint32_t start_address_in_kb;
> -       uint16_t used_by_firmware_in_kb;
> -       uint16_t used_by_driver_in_kb;
> -};
> -
> -/* Definitions for constance */
> -enum atomfirmware_internal_constants
> -{
> -       ONE_KiB =3D 0x400,
> -       ONE_MiB =3D 0x100000,
> -};
>
>  /*
>    **********************************************************************=
*****
> --
> 2.17.1
>


--_000_MN2PR12MB2957401601B970825564553E95520MN2PR12MB2957namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Luben,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thank you very much for your suggestion and detailed explanation!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Patch has been refined, please help review.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 19, 2019 4:14<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; Wang, Kevin(Yang)=
 &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lis=
ts.freedesktop.org&gt;<br>
<b>Cc:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Yuan, Xiaojie &lt;Xiaoji=
e.Yuan@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc=
 of memory training(V2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2019-12-18 4:14 a.m., Yin, Tianci (Rico) wrote:=
<br>
&gt; Hi Kevin,<br>
&gt; <br>
&gt; You mean like this? It's a bit lengthy.<br>
&gt; - ctx-&gt;c2p_train_data_offset &amp;=3D ~(ONE_MiB - 1);<br>
&gt; &#43; ctx-&gt;c2p_train_data_offset =3D ALIGN(ctx-&gt;c2p_train_data_o=
ffset, ONE_MiB);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset =
=3D adev-&gt;fw_vram_usage.mem_train_fb_loc;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offse=
t =3D adev-&gt;gmc.mc_vram_size;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((ctx-&gt;c2p_train_data_=
offset &amp; (ONE_MiB - 1)) &lt; (4 * ONE_KiB &#43; 1) ) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset -=3D ONE_MiB;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offse=
t &amp;=3D ~(ONE_MiB - 1);<br>
<br>
Using the macro ALIGN() is a good practice.<br>
Usually when calculating a quantity, such as the one above, you'd<br>
use a working variable, say 'a', and after you're done with<br>
the calculation, you'd then assign it to the variable which<br>
needs it. Something like this:<br>
<br>
a =3D adev-&gt;gmc.mc_vram_size;<br>
if ((a &amp; (ONE_MiB - 1)) &lt; (4 * ONE_KiB &#43; 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a -=3D ONE_MiB;<br>
ctx-&gt;c2p_train_data_offset =3D ALIGN(a, ONE_MiB);<br>
<br>
The easiest way to see this is, imagine, if all this calculation<br>
was offloaded to a dedicated function, f(), to do:<br>
<br>
ctx-&gt;c2p_train_data_offset =3D f(adev-&gt;gmc.mc_vram_size);<br>
<br>
Now, by using the working variable 'a', you've shown this<br>
abstraction just the same. (By using the working variable 'a',<br>
you've shown to the reader,that this calculation is abstracted,<br>
and could be relocated to a function.)<br>
<br>
Regards,<br>
Luben<br>
P.S. The compiler is probably already doing this, and not working<br>
directly on the ctx-&gt;c2p_train_data_offs, but assigns a final<br>
result, as explicitly shown above. The above is to make it easy<br>
for humans to read and understand the code. Hope this helps.<br>
<br>
&gt; <br>
&gt; *[kevin]:*<br>
&gt; *i'd like to use the marco ALIGN() to simple above code.*<br>
&gt; *anyway, the patch Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;=
*<br>
&gt; <br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_train_dat=
a_offset =3D (adev-&gt;gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;train_data_si=
ze =3D GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;<br>
&gt; &nbsp;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.h<br>
&gt; index f1ebd424510c..19eb3e8456c7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt; @@ -66,6 &#43;66,13 @@ struct amdgpu_copy_mem {<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; offset;<br>
&gt; &nbsp;};<br>
&gt; &nbsp;<br>
&gt; &#43;/* Definitions for constance */<br>
&gt; &#43;enum amdgpu_internal_constants<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ONE_KiB =3D 0x400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ONE_MiB =3D 0x100000,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &nbsp;extern const struct ttm_mem_type_manager_func amdgpu_gtt_mgr_fun=
c;<br>
&gt; &nbsp;extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_fu=
nc;<br>
&gt; &nbsp;<br>
&gt; diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/=
drm/amd/include/atomfirmware.h<br>
&gt; index dd7cbc00a0aa..70146518174c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&gt; @@ -672,20 &#43;672,6 @@ struct vram_usagebyfirmware_v2_1<br>
&gt; &nbsp;&nbsp; uint16_t&nbsp; used_by_driver_in_kb;<br>
&gt; &nbsp;};<br>
&gt; &nbsp;<br>
&gt; -/* This is part of vram_usagebyfirmware_v2_1 */<br>
&gt; -struct vram_reserve_block<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t start_address_in_kb;<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t used_by_firmware_in_kb;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t used_by_driver_in_kb;<b=
r>
&gt; -};<br>
&gt; -<br>
&gt; -/* Definitions for constance */<br>
&gt; -enum atomfirmware_internal_constants<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ONE_KiB =3D 0x400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ONE_MiB =3D 0x100000,<br>
&gt; -};<br>
&gt; &nbsp;<br>
&gt; &nbsp;/*<br>
&gt; &nbsp;&nbsp; *********************************************************=
******************<br>
&gt; -- <br>
&gt; 2.17.1<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB2957401601B970825564553E95520MN2PR12MB2957namp_--

--===============0270491352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0270491352==--
