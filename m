Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E55606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=38kyl/LF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0569F10E108;
	Thu, 22 Oct 2026 01:49:09 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010049.outbound.protection.outlook.com
 [40.93.198.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB8510E108
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 01:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=semMG3SM1Tb3D+XBUcREspyD7OB0aWfJ5mPJsIt9DzHgzCFnLrjqmxWeZuv9EQT/cUycE7ReE7EgYKpq44SzTO5gqGsyVWlWDOsCcW/KzMFH61dn1PXGS8GANXNmU/Zy+mrnthY88rdGDoZtsz9J+k3aop3RPS5yQxx7OVmVDnO1LhwCPJ2rmPyUm0pLWkgzYz4jSC19NYO2dlxImow41GENEubCTTV5shj7s0NKF2akg4OcOlRTxjIBheyfqTNqs+lXMYQ/XVJEG5uOcGGKHHdIQv/4h62B2qI+vQsdSfsX79K9D0s8tlNi9EqW8v2Ko4Rm0XKYGUMxHtwoHQYAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FACHsnRomG7hL6Z3Ju61Tl46ZTWcPuMx9vsVa3aov28=;
 b=qUo91zKlJH4mBjjk1L6s4zqgqrBh+4MDprGTVL0vh+ukcOVpNrFvib6OZpr+GtbMZeHkv3A1A8YwK2tx4tS56eh1lc0sSJp0KBehOcqpVpX3V5MwRCR4dWTfAxBBFDZpnFDcyC9yodMIgrD9Mn5IAhXhiTADWf8jME1ZGVtKNgyglVyUsM8X7/x7KKzN2ncciYri5kFf7TG8m8MJBAufBGNYK+YC8CiidcY/PW02r0a/SO9ODcVVzC7I1Ub880MiVwjDtssYqIFyzfWRCnMXDTHgg3YK3EzWGQvgwEgSvd1xKaDBeGWKSg9CFFpimb7oURpW5pjut3DrtNjB3piQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FACHsnRomG7hL6Z3Ju61Tl46ZTWcPuMx9vsVa3aov28=;
 b=38kyl/LFfKFjRnZ96J8Uw8cZ863bHYl7obswevL76iNg+ukYxSoK6+GRsHiGvdiai325EIA1lxaQ1GGCSyopQ4R/q16GfMOgR1Ap+ntCpKUXv+hVTgUkly868usUOOLT1R9JzaBF/5hCAQh1r3zFZRZw0Y1gcB8GqDvUqDXt9n8=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by PH7PR12MB9126.namprd12.prod.outlook.com
 (2603:10b6:510:2f0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 01:49:00 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 01:49:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Gadre, Mangesh"
 <Mangesh.Gadre@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode
Thread-Topic: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode
Thread-Index: AQHdYTzag2F/MhWdCE2LnPyKGtsV1LcIyxrQ
Date: Thu, 22 Oct 2026 01:49:00 +0000
Message-ID: <BN7PPFFF39339DD155315E1E27AD5DFB060FC652@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20261021091607.245415-1-cesun102@amd.com>
In-Reply-To: <20261021091607.245415-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Ce.Sun@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-22T01:43:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|PH7PR12MB9126:EE_
x-ms-office365-filtering-correlation-id: b75bd96b-d6fd-454e-9853-08df2fdea502
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|3023799007|261009223027099003|10067099003|261021123027099003|6133799003|10086099003|22082099003|18002099003|18092099006|56012099006|5023799004|11063799006|38070700021|261021121427099003;
x-microsoft-antispam-message-info: GM66CabC94sAswTYz9FN0koVYqPX+j/fdq80XEBhbfa6u10VDhaYSshKJk7TyG8d39DbqEOwBCmrrs/vAk2YZ8B8wC5XKOMq0F8avhXYz14F8ASZ8WShdDQLotj8UGVyzNflhm6I/SoyhYnKrrKo+65v2ylcftD1akjYYI/LxFgK6KWpuzm49O2Vd0+uhvVKI7z+fMgsZXvVPyfO8UzV9Dn4tncU5nxThN/00RaniZt/HHrtxU2Qi4tA8A4bu40Xx9Kz6gllnRyEHtHaqY2j4VU1e/bLTKVlSoW7lLDG+eOC/PiF5pVYzV/fKnMFxTO0gnXiamCwfgoVyLrrk3eII+AiZ+xgTD+vw4L4BDHfoBnQIIkNj9q+XqjNRvsl8bLsoNiSdSLEyhAo8B6w+9nnr3LAbzbBlCrC+1ItTHTuocpZ3c4HPtBRCr/QlB4uBnPdDA5AD6KjTXPEER9Z/1pif7I0dOfv8bzorz/OTUBGzrjctrRYvo4vGS8hiQWol7zXvqf3onLsaBljB46SjJbK8E/dymwCH41ft7rCWTWIAuLz89IW/gnvH/o3P26TRrkkKoTU4ruminEetz/argyK8ZZZBfxij4Y86J8aGz4jzSErQa+gEwIU7OPtEVSD+8aSPbxE9zO2qIXjMlmskUeK2OVmYfSNMnyjqS9JPjuE4vBwbA0fFyIfGqXks643v89sKY9kNG5MqwSp7KTJ71n83/sJCTwJNqLq8HTJY7qAevU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(3023799007)(261009223027099003)(10067099003)(261021123027099003)(6133799003)(10086099003)(22082099003)(18002099003)(18092099006)(56012099006)(5023799004)(11063799006)(38070700021)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YFd3tDudjqbBj3SDsTeuBK8l6Uruo86WKFQOPxaOBflpYBGrY2AzH4M8a82Z?=
 =?us-ascii?Q?L+7fsDwZIzw+gIRmcmppcdCoSo/vCMH6i7UMscoI3kKED+8vZmszOoxiP2ry?=
 =?us-ascii?Q?lGxiOhxs/frW6A9tlpsumjNDy5c4dAn+eOSU6X+X74Y6S9TpZ6/XO6SbVP3Z?=
 =?us-ascii?Q?HARLklAFBRVRC3YoaKxvD6jk2pPtR73DurWEOPq+/7kjut7WY64F4i4SI0dd?=
 =?us-ascii?Q?eKYfv4U7S3b2xgYUgWeWw0pOZDLcBTI99EUlzIuqqZd+/0LCjJOi+iG5G7+D?=
 =?us-ascii?Q?saPrrYoLLQRhRMaHB/tu1oil9BxspCj0qMX0XfRXH5M/vyovYXrrCQ7tY+24?=
 =?us-ascii?Q?BreIPw/Q+wcXMns7noKuBlVDl4KOyf06Jzqg3cQ3qifTVCQdSfsQwbnVxW9I?=
 =?us-ascii?Q?xxlDRStTX9htlCMULDN/PmrLRF2WXZZCAIofs/h+SdoNwdNFrckS+91V3jLE?=
 =?us-ascii?Q?FbKz/QiGnMB5SfuQPDP2NjQVims6uQwqMNgsX8OhhBtzMVNIkDWNVjJbT+BL?=
 =?us-ascii?Q?SkEp29Enr6CJAnxKgarWKs3mT1LK3kWuePE00O8htNA4Tc1QxadF7hvGZNPU?=
 =?us-ascii?Q?y5+bKmY4TNw4uppc4Ld24ITTEJj9LwzH/jWLekWGnKD0HXSZLBWmMGdoBcEo?=
 =?us-ascii?Q?qswocuAUNj+8mOsmsTnu5z+y1YJNE8ITv5pS67UvJUM4ZFVQiN2D73xOC5Jy?=
 =?us-ascii?Q?RAtNpvY4RKk54fLDWBsx4gQ/t8c/0Lm/9oeTxBSnjiipp8BOlusLT5KIYL3w?=
 =?us-ascii?Q?ObH4IpPij7BNmQ23aBf9D0b/WeLYzOqPLGAUCl1o+BEPWRwqQTbUgI5d5hJd?=
 =?us-ascii?Q?MIyxaFU5XnEcLlw/2R+acRBqg7t+FneB1RvcahH8tHkKhDXVWnmlybyQ0FcG?=
 =?us-ascii?Q?jMUviDY0GpD/HNnzb6a6GkRjl/yp30dMhe9yNdMnMp+ICHL9BKZ4yTkBGkOf?=
 =?us-ascii?Q?+sQCqVvioV+FKzQ+r1OcACcnxI88stWcEuTECQgpGrDjsj3g5NXUY0NHyXX8?=
 =?us-ascii?Q?z5kkDDAV6KjaOYzsX87Gy11PHIR63hwrDpeV4jMsXYU2oEDZKdYvljz5kpPS?=
 =?us-ascii?Q?l6CrJ3zHfUbyZAs2AJWHXeFcSg2dpcnGwZC2ESyoFKlLqhpR2/GLn9xwr70K?=
 =?us-ascii?Q?4K87pq3U2xNdO6Lt542hTtnVCPiPUVPxcXm53aJUCzt7pTwZqDYARAeJjHYX?=
 =?us-ascii?Q?KuE4lbtu8YGjAPc0RCONayq4G7Qmppe5rLE3JJdKp89139q6W1ZmebxkOZ/W?=
 =?us-ascii?Q?FELBtzY7ioX43wDGTmvNIsFtp45bKdqAydjd4bfaZ2LeX1duMLmfreOOSD+m?=
 =?us-ascii?Q?U7+JT0plrV/Q0Naarq1W64DivqWwFzZVNBCl9WEk02eTLUaCkqyVas6oV8TI?=
 =?us-ascii?Q?+llz/4vgsu3LUBirXKcHg1/wLg+V6z+Rm/iax8ef4n37l4qbG0kuk8b2Bec2?=
 =?us-ascii?Q?ZtHEFZAg70o5XIkqrwqgZB811j0dv4sprK22ufv2C2xumwmXsG0HDttJlvme?=
 =?us-ascii?Q?gnBGuL5VejC3OL5+WK2374VWwbnu/d9bsTsA78LH7nfnUGx4JRwIk5Ckx8cK?=
 =?us-ascii?Q?7nOxxYzFU3ANPByPafeA3fuY93b4xS1k1fqAd42txmmaGba3vNxGbzg+fbFa?=
 =?us-ascii?Q?QtwijTV81qmazK5OgGEn/P5h8RIUAXPPJDlr3npe6ib6DDMmYOfHgYT0plbf?=
 =?us-ascii?Q?EB64guRpNGV9EA19eva1M1xlytwr2UF4EneNTPXuu4zc8q2L?=
Content-Type: multipart/alternative;
 boundary="_000_BN7PPFFF39339DD155315E1E27AD5DFB060FC652BN7PPFFF39339DD_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75bd96b-d6fd-454e-9853-08df2fdea502
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 01:49:00.7185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1In6iljA395VyNAW51QCQ7cMj2e6qP8qoxCQax/Tb0z6JykzLyhEJUytTUWwO+S9vLfu5rmznZftGwXqtIelA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_BN7PPFFF39339DD155315E1E27AD5DFB060FC652BN7PPFFF39339DD_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


Hi @Sun, Ce(Overlord)<mailto:Ce.Sun@amd.com>,

Have we identified the specific reset operation that is triggering the secu=
rity violation?

Would it make more sense to skip the reset, or remove the direct reset call=
 for the IPs where the security violation occurs?

In general, a reset is still required on some GFX v9_4_3 products to preven=
t stale or invalid error-counter data from being reported at initialization=
 time.

Regards,
Hawking

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Wednesday, October 21, 2026 5:16 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Gadre, Mangesh <Mangesh.Gadre@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode

Fixes: c65c9fc19b6e ("drm/amdgpu: retire legacy ACA support")

After legacy ACA support was retired, some ASICs systems may trigger securi=
ty violations during driver load when
amdgpu_ras_reset_error_count() is invoked in debug mode.

The function only checks whether RAS is supported for the target block befo=
re proceeding. In debug mode, ACA/RAS handling is not available and attempt=
ing to access the reset path can lead to unexpected HW accesses, resulting =
in security violation reports during driver initialization.

Prevent this by treating debug mode as unsupported for RAS error count rese=
t and return -EOPNOTSUPP early.

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 557baca454a9..e8a4fe22317f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1506,7 +1506,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device=
 *adev,
                return -EOPNOTSUPP;
        }

-       if (!amdgpu_ras_is_supported(adev, block))
+       if (!amdgpu_ras_is_supported(adev, block) ||
+           !amdgpu_ras_mgr_get_debug_mode(adev))
                return -EOPNOTSUPP;

        if (amdgpu_sriov_vf(adev))
--
2.34.1


--_000_BN7PPFFF39339DD155315E1E27AD5DFB060FC652BN7PPFFF39339DD_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">AMD=
 General<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hi <=
a href=3D"mailto:Ce.Sun@amd.com"><font color=3D"#2B579A"><span style=3D"bac=
kground-color:#E1DFDD;">@Sun, Ce(Overlord)</span></font></a>,</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Have=
 we identified the specific reset operation that is triggering the security=
 violation?</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Woul=
d it make more sense to skip the reset, or remove the direct reset call for=
 the IPs where the security violation occurs?</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">In g=
eneral, a reset is still required on some GFX v9_4_3 products to prevent st=
ale or invalid error-counter data from being reported at initialization tim=
e.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<a name=3D"_MailEndCompose"></a>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt; <br>

Sent: Wednesday, October 21, 2026 5:16 PM<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chai, Thomas &lt;YiPeng.C=
hai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;St=
anley.Yang@amd.com&gt;; Gadre, Mangesh &lt;Mangesh.Gadre@amd.com&gt;; Sun, =
Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>

Subject: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Fixe=
s: c65c9fc19b6e (&quot;drm/amdgpu: retire legacy ACA support&quot;)</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Afte=
r legacy ACA support was retired, some ASICs systems may trigger security v=
iolations during driver load when</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">amdg=
pu_ras_reset_error_count() is invoked in debug mode.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
function only checks whether RAS is supported for the target block before p=
roceeding. In debug mode, ACA/RAS handling is not available and attempting =
to access the reset path can lead to unexpected
HW accesses, resulting in security violation reports during driver initiali=
zation.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Prev=
ent this by treating debug mode as unsupported for RAS error count reset an=
d return -EOPNOTSUPP early.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.com<=
/a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 2 insertions(+), 1 deletion(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 557baca454a9..e8a4fe22317f 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1506,7 +1506,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *ad=
ev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_supported(adev, block)=
)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_supported(adev, block)=
 ||</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_ras_mgr_g=
et_debug_mode(adev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN7PPFFF39339DD155315E1E27AD5DFB060FC652BN7PPFFF39339DD_--
