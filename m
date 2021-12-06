Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51BEC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 11:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F606F508;
	Mon,  6 Dec 2021 11:41:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 935366EADA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 11:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ4ipERgynm6tcCGzqSmRXzVn6QoDEb1AKnqSZZcXmC6Dgh7m4q9pha4ZlKIviFiQUG+Tt/Ph143g8VCxxenHb3k3piVWNsNhOyWDbD237jPezkUsTBM/lUrSQnYWpDyORR2Z9STnqZmrcHGBhRuoa+DwxY3iWCqriX2JclGTcINyOsqPIWPL9rlqZCCou6f71BHBei9C9pT6nKwpXAasr89b7VTda2lVmHS92OLMVmmKe8wQ9CInAJ0DdHbaoi2y1a3Bia96PYs8h/FJBACxjakMr/Opsd8wkz0EVtKVxNLvJEHs0HAEasf7fvKU/JyhoyvVUtEZlTr2mTVeEIgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjDxSI/Se+vSGj3kDJqc8DELP2R1ZeYKXLkXm3NIObY=;
 b=KlhbKf/OPzchk8DkHDyiC58cr3hNDAmEATt9iWBNUeD2GFVh7WD1uZR47UDKf35mWciMfinflk1q8EKBDAUWl/JWtw8LjQkCi7ElIHrp82qK7X8nfTKGXRoADvtIap6dNl+YU9RWLCoeTxrdEULCxwA1giQJ+i3QKS6AYF2IMKLBka6zCvYYe/Uip4DIRrwv3grcHJqzfUgJeqdHiW10beDncNjBnV0EkCxgu+8VBQz/g9dEps70aBOfVwQmDfqVAfhyIbaFw6tZnKF1e10F5kniVfIlyFw7HR/OzdlVa/ykSZGDZfLzh9ZL0ii0AKEIN1UrrrtnDPRsnjWYj9Htqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjDxSI/Se+vSGj3kDJqc8DELP2R1ZeYKXLkXm3NIObY=;
 b=lsc10ZeLJ94dtQjHclyWEIDz8Owx+uTmE2iWD2Gq3dRC/Pmwnobs89ukfVUJxbHQTD61yob8SDnjwNWtWgmBHG6dXTs5FsqcyT3ayJisj/t0ABLNvmFrIex8uvC9zeMC8QnSpKdYArA9ewXe94Dj+e5X4gcTi23Ur3Ci50pBLSI=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 11:41:10 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205%9]) with mapi id 15.20.4734.024; Mon, 6 Dec 2021
 11:41:10 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] drm/amdgpu: add helper to load ip_discovery binary
 from file
Thread-Topic: [PATCH 1/4] drm/amdgpu: add helper to load ip_discovery binary
 from file
Thread-Index: AQHX6orRg9VZUKarmkGcXVX8ao4+SKwlVV4M
Date: Mon, 6 Dec 2021 11:41:09 +0000
Message-ID: <CO6PR12MB54737EF267E8CDBB06B26D4B826D9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20211204102032.3063-1-Hawking.Zhang@amd.com>
In-Reply-To: <20211204102032.3063-1-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T11:41:08.377Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: de0d570a-0085-98fe-f28d-eb9e30436a8d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4195b830-88fc-416c-a689-08d9b8ad4c64
x-ms-traffictypediagnostic: CO6PR12MB5395:EE_
x-microsoft-antispam-prvs: <CO6PR12MB53953985946E5A92C6695A5C826D9@CO6PR12MB5395.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQPyL69pcaPS+c/kHT3KxZ8YsxCugALOJBJWHUkAS/NLuqldL/ufaInrZ0jilX61+XHg87XJlIGOSOYFr0GIxP4HmE7KPsvb7oQbiB7EUhbuBBrp7puLsEfxOeybiUuX4Rlv7fuyTEPLtlmhTsrEW2vfoRNnwmSEqeBzoG6vg+eIl2ExdFXLi7XnnR0m+ll5AVEiTDBPPUIub8A+MzAMyb7EQ8TSctgWi3tOa27kQpDtgjMawIezZYAqDs6KDWvv96n3AAjGKBbO3K7N6Yx0uUwLd6xE6RwLjk6e6d4hBdtkrwcCQ2OE0DS6nBYX65uNOaX/jv9xrh2eqSFSEYnIogX62nhN5qgNPZjv3Iz//OWaXJOJIi6sdt46FwRAUkPPguoSknd2EizCaJepztyBqThB8F2NSvrmeEBVm0DRTWyiXKyXcuB1zl2hVuFCd6TCsa5b2oFWh5PQ/kKww20Bzem8o0D6zol4Me727KVQ/lMwRWMGHdLDqA5OduDRG/yPTI6HBcXOfOVUeOhnLx5BYaaSrh/Tiva0cD5NDqgUklzqXWyG+CcHZS/4AH8seqjw1AU4LdboAOGqiFpRL4n+jnreT5D4ZbtzG/TMOnKx/oKlEzEZJqVRQgMLQehKFTBz6OIDvhJeXujs+r0UjxHcVi2m2md0too37KdKuCniEzD2pUt4+306Q62mMuCAsC37iL8G+rgJELb4ZbbTC83v9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(7696005)(110136005)(5660300002)(9686003)(55016003)(508600001)(8936002)(66556008)(86362001)(66476007)(8676002)(91956017)(76116006)(2906002)(52536014)(186003)(71200400001)(6506007)(33656002)(19627405001)(66946007)(38070700005)(38100700002)(66446008)(122000001)(64756008)(316002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PO83Clf0ruBYPJnUpCt/n+9i7JaGOXpL2j5vH+1PA2dL+bS5GlHM00wYuJ?=
 =?iso-8859-1?Q?Fsa3WYn6XeVKCHHu2GFKNEfBRkRjEHxgPBezoEjm9cczEfy5yAR2KFVrCa?=
 =?iso-8859-1?Q?Yd/YWduXX6xVQuC13tvBvdO+8Hsoy5d+qHxcRCNT2ApyFmcl6DXNNYHRa0?=
 =?iso-8859-1?Q?F8l1+ntusqJ8jSEA9zUEuezgqzhFBY8/Vu9ANF2mkY899IuzA++72ZpBME?=
 =?iso-8859-1?Q?LZ+qbumnldoeSUOQkSwComWDjupOy5p8D4mJefHd7x3kyqwDPP3u5wnMhm?=
 =?iso-8859-1?Q?uNANU7xtyuTCA6kaGlppVxSqi4Tw0whTzMpCQCBuDSKoVQd68m3vsDK88g?=
 =?iso-8859-1?Q?8NIA4fUbmgO2y16GdrS/UguMW6bfIYFMkjyFig9AAu1R2Oc7F3jMkhgRdX?=
 =?iso-8859-1?Q?RZlC9Vpz+3Qekc5V6t4EkJ+3U809o/3SeUyz2ebKtInxsozB3jAeXIpLv3?=
 =?iso-8859-1?Q?Fpk+G0neU4Vsv8Ae/CIClbAxR/S8DYZfEvsABmcW2Izx3bVlIo19u6oMa9?=
 =?iso-8859-1?Q?b9H4HSSYjdNFEtyG3Qh0y657SDzZoe0f6Vky86EJjpibzbmzT8n3mgR9tp?=
 =?iso-8859-1?Q?/fnzatmS0Uq5jA8oVf0jRb5NoocS7it527ONuwykk1K8bNVDQnGsE7Yi6l?=
 =?iso-8859-1?Q?C4nsN6qo/ZlX2f7lTtGhR46Eze2+f3z2j8RDY9oJhuwfOzK98zLiuAEqD4?=
 =?iso-8859-1?Q?9w63PvCHM1Mk0CX8UcEKezIqNXBVOjOlGT43ZH6HVOszpaQe6CmcZCbt/U?=
 =?iso-8859-1?Q?j/AGl32lEVuJOhkzQMJWLodb2s35gRNF0mw/iXe/fi2aKn7dVWkwoTW3Nz?=
 =?iso-8859-1?Q?KQtl4CtYmLsgRnl0sE6xQxptQ/jCvmLm6l6Zq/PxYRHD1KUJ/dQTKKP3eL?=
 =?iso-8859-1?Q?n5QqT3H/kCavL4ZZYxrvM2jhZAet6M5CQCgZGu4aiuPyb0SBenDbv8is31?=
 =?iso-8859-1?Q?+7gMP8zAuDhsjT4zroQExZrlHU06PeJ11i5Qb7BLjGWBW21L9saqOA1Ilw?=
 =?iso-8859-1?Q?La6usi8gvD7tzTg6OZBjcXnwDAROjGBUjqaivTIbTSEvGSV19SlwAbUNXF?=
 =?iso-8859-1?Q?Sa0fXM5WDtHldonKjbgDD70A1+VB0zWge9kGmnTF07rclyAV2xcVqks3js?=
 =?iso-8859-1?Q?EPYlOC46xkAvEZy6IqnTA5B33NftwJ128IpDSNOorQmS4RRZyAjJKrN+MJ?=
 =?iso-8859-1?Q?35IuEZEbUN03JedEnK2GnmJI4XzHTxRBu6CMVl+pMTZ/aoXmSt8Wv9w1BE?=
 =?iso-8859-1?Q?2TLGo5/cO88c4sci3965iAEU52cqxyKkHue6E999k8pMMrf4zZu+1aFG6I?=
 =?iso-8859-1?Q?qquG1YOP6kb29E/50w1PKfOdLY/FiSs8BXM3D3i5r87GmPPDMUWbQ74F9S?=
 =?iso-8859-1?Q?1LuDyQRPiKtH03AkhydCOA26wVDcNjJhUviTy7AMYGU6An4n/PhDDjTxz7?=
 =?iso-8859-1?Q?q+SeWvqGPEY8IcwHxhTiulgYmd3+mMPRMz5Iz2ZkGy9k5ZLfvxqHTn3fUW?=
 =?iso-8859-1?Q?wIrMYKcYLkFFZZtbOWKJozm0e9b9FZwWFj4QcUxZl555c6180V/jR0ICNM?=
 =?iso-8859-1?Q?Ww18EGJdTFK78TlGq79dLYWV2TCHSfy3OkPNtG110J+hB9ynp38UgTX/lE?=
 =?iso-8859-1?Q?bibdpE3LEVbzVwSotw6obE+BVLj7WswyLKuH7m0PLP/3Xw6vuHYSdUCTgX?=
 =?iso-8859-1?Q?/GhdCDzkDqaL8Hn+H1E=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB54737EF267E8CDBB06B26D4B826D9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4195b830-88fc-416c-a689-08d9b8ad4c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 11:41:09.8301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ei+t248Os5vOosXjgd6Uus6vTN5WP5nGtnzI8oTHDzIh89fgdazMdx4N+6DCqoFa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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

--_000_CO6PR12MB54737EF267E8CDBB06B26D4B826D9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Hawking,

A new function is defined in this patch, but it has not been used.
I am not sure whether this separate patch will generate a warning or whethe=
r it can be directly merged into patch-2 ?

and the "(u8 *)" is not necessary for this case, discard or using (void *) =
is better for this case.
__visible void *memcpy(void *to, const void *from, size_t n)

thanks.

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Hawking =
Zhang <Hawking.Zhang@amd.com>
Sent: Saturday, December 4, 2021 6:20 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add helper to load ip_discovery binary fro=
m file

To be used when ip_discovery binary is not carried by vbios

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..8ec60f826c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -67,7 +67,8 @@
 #include "smuio_v11_0_6.h"
 #include "smuio_v13_0.h"

-MODULE_FIRMWARE("amdgpu/ip_discovery.bin");
+#define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
+MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);

 #define mmRCC_CONFIG_MEMSIZE    0xde3
 #define mmMM_INDEX              0x0
@@ -187,6 +188,34 @@ static int amdgpu_discovery_read_binary(struct amdgpu_=
device *adev, uint8_t *bin
         return 0;
 }

+static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *ad=
ev, uint8_t *binary)
+{
+       const struct firmware *fw;
+       const char *fw_name;
+       int r;
+
+       switch (amdgpu_discovery) {
+       case 2:
+               fw_name =3D FIRMWARE_IP_DISCOVERY;
+               break;
+       default:
+               dev_warn(adev->dev, "amdgpu_discovery is not set properly\n=
");
+               return -EINVAL;
+       }
+
+       r =3D request_firmware(&fw, fw_name, adev->dev);
+       if (r) {
+               dev_err(adev->dev, "can't load firmware \"%s\"\n",
+                       fw_name);
+               return r;
+       }
+
+       memcpy((u8 *)binary, (u8 *)fw->data, adev->mman.discovery_tmr_size)=
;
+       release_firmware(fw);
+
+       return 0;
+}
+
 static uint16_t amdgpu_discovery_calculate_checksum(uint8_t *data, uint32_=
t size)
 {
         uint16_t checksum =3D 0;
--
2.17.1


--_000_CO6PR12MB54737EF267E8CDBB06B26D4B826D9CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">Hi Hawki=
ng,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<div><span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">A n=
ew function is defined in this patch, but it has not been used.</span></div=
>
<div><span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">I a=
m not sure whether this separate patch will generate a warning or whether i=
t can be directly merged into patch-2
 ?</span></div>
<div><br>
</div>
<div><span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">and=
 the &quot;(u8 *)&quot; is not necessary for this case,&nbsp;</span><span s=
tyle=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">discard
 or using (void *) is better for this case.</span></div>
<div><i><span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">=
__visible void *memcpy(void *to, const void *from, size_t n)</span><br>
</i><br>
</div>
<div><span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">tha=
nks.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">Best Reg=
ards,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">Kevin</s=
pan></div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Hawking Zhang &lt;Hawking.Zha=
ng@amd.com&gt;<br>
<b>Sent:</b> Saturday, December 4, 2021 6:20 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/4] drm/amdgpu: add helper to load ip_discovery bin=
ary from file</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">To be used when ip_discovery binary is not carried=
 by vbios<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 31 ++++++++++++++++++=
-<br>
&nbsp;1 file changed, 30 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 4e3669407518..8ec60f826c7e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -67,7 +67,8 @@<br>
&nbsp;#include &quot;smuio_v11_0_6.h&quot;<br>
&nbsp;#include &quot;smuio_v13_0.h&quot;<br>
&nbsp;<br>
-MODULE_FIRMWARE(&quot;amdgpu/ip_discovery.bin&quot;);<br>
+#define FIRMWARE_IP_DISCOVERY &quot;amdgpu/ip_discovery.bin&quot;<br>
+MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);<br>
&nbsp;<br>
&nbsp;#define mmRCC_CONFIG_MEMSIZE&nbsp;&nbsp;&nbsp; 0xde3<br>
&nbsp;#define mmMM_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
@@ -187,6 +188,34 @@ static int amdgpu_discovery_read_binary(struct amdgpu_=
device *adev, uint8_t *bin<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *ad=
ev, uint8_t *binary)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct firmware *fw;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *fw_name;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_discovery) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_name =3D FIRMWARE_IP_DISCOVERY;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev, &quot;amdgpu_discovery is not set properl=
y\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D request_firmware(&amp;fw, fw_na=
me, adev-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;can't load firmware \&quot;%s\&quot;=
\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy((u8 *)binary, (u8 *)fw-&gt;dat=
a, adev-&gt;mman.discovery_tmr_size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(fw);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static uint16_t amdgpu_discovery_calculate_checksum(uint8_t *data, ui=
nt32_t size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t checksum =3D 0;<b=
r>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB54737EF267E8CDBB06B26D4B826D9CO6PR12MB5473namp_--
