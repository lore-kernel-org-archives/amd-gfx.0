Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D73DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 16:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15630112C36;
	Mon, 10 Jan 2022 16:18:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62912112C27
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 16:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ/zQBT4iiGTqoIw8ziKRwoOGaxxICe0SQLpk+T17D7OW4rkWqv7sk+fkqSKx5dagFEnxKv6jVko/gDxBZftJy0hlm/ZE8x3OV8KGnYm/NUoNfnNIVSXrdMb4F4eehxD1U5lK71sR8OPJErdWc8O7F+7l1+8eOLrEYD9ae8qBaG77OBkbXLjc5IJueWdwOCNtt6CYTzUfWbK1M8SHV2z6ztuUDiwZTbFsrqQKyo0E04UyU70Gqke330iDSCz7ceNkR6VXMbLzk//+cSjV5girRPPBZ0LqlcepnHQn7UlJC0h8cw0/9fth/XxSiml9IERpVcjgaVURVlMbRxrTHTjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wya443akmFozc4e+k6aMh5Ne+FIKOm2cQj7/tuKDAHM=;
 b=nVcnnMkhfzZ7qeIYicCJbhESFFsxdIbsdHVjfc8mUOyMgwqeSq2wDt/Ugr8CRmG94kUXyfWgmB/6RbqNly/xWtxGM3tMO/WCy7SV6k9PJagor4NZcAF5q8OOMbvdPGgGqfpKOA1oHO0eL1zbLKlcHG15qkD+mdF2nheZl+oA2lxKUMKinGgh8VnYt2whdEfr0tbSO3SamxhGzZ56lFQ+2bl3zEr7wvrqjx3EPdUcl5QVt/kioQ1e2A6qAZKO3Bmrx0hGEKOvN7S0DjqT+OwKvFboifW3OoL+KjuJfS4oWa6TseeHL96ySaXH5iMRR9359zrnCPfViHih87WV7yOJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wya443akmFozc4e+k6aMh5Ne+FIKOm2cQj7/tuKDAHM=;
 b=Pf742nFUeFGV9WNI0lbIYTpYNoyfhe0xdkOSZTobDqnjjuqi2PzUISQ/Nd682aCoZ2UdGqFV2dF7IlX9xLX8ip+1DXAdqDriX7vOsVVmQYClT8wnB6r3WUY65cVwT1cGfEqQAG+yfaUvu44pr+z7el5LnbPQM799g8LwZx+EePk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 16:18:09 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 16:18:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>, "Wu, Hersen"
 <hersenxs.wu@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: Re: [PATCH] drm/amd/display: Not to call
 dpcd_set_source_specific_data during resume.
Thread-Topic: [PATCH] drm/amd/display: Not to call
 dpcd_set_source_specific_data during resume.
Thread-Index: AQHYBgFyiymel+rBxkGSQ52wV/py9qxcby0H
Date: Mon, 10 Jan 2022 16:18:09 +0000
Message-ID: <BL1PR12MB5144F7AB8D1275D4E569F7A1F7509@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220110090652.3759559-1-rajib.mahapatra@amd.com>
In-Reply-To: <20220110090652.3759559-1-rajib.mahapatra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-10T16:18:08.526Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: a655d042-8e6d-60b9-5694-92e37c05b3ff
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebc15082-d743-41a3-dce3-08d9d454cad5
x-ms-traffictypediagnostic: BL1PR12MB5173:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5173FFE99864E775EEE77CFDF7509@BL1PR12MB5173.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4yY8Y9erVHYexOpAXNjT+wFqm4ae46ONaMHHGC9miss2VgV1OcoclKkeD4GumBOmEBLwlmTR9NP8UI/x+xSDZiMc+HV4tmot+g9qKGvzR3c4hJ731uc20xEpqgI5WhRWuL+bFp4cI2cGom9fxvpz3qE6s2aWXrbZT1K+lfMFPJINTSFTHmFa/vqQu4DJtP/tgDmjSZoNMufjtolbuHOGFOiApGuEMZirTYPLCaPZfPJKhHijwuNoejtsDmgH8zSzVnur+/3DJZHnWbC11MQxoxiVC4mIHLDY7nVhVmw377IQFCit8k3eoVgWmzwPK7cYeT4wY7WN8v9M6CunQQ3LfSw447/JC/ZOtul+z4dDQG1wBbKIQtVSoCGCNlRrHTReIk5YkVDfdd2QLy16TU860VGuORGfBaFwKtwTjLldm2/aWtIEHgY+8PvwqSmnkEO5QgtI9gEhyGXvIPsvjT1wJ8HiOgfBbfpKvSP7w7xBJ6fayBlJmBbEFnjNGyCLxquVIsaMPIwjRvm/ThzzAnFRjxudKB6BGKX5ei6kTEAdwItxmjHnFJOqs5ga7b2DGQweWO9ZNtl4D1Np/hKOyjmBbUEhNaMw4nMRyfaDcP5G01InWCwdSBfFrDj4s0iEf9CjalCwQ8p1LmjjdtBxFpMonE4twiwIDwU1cM/nQFCLNp/1WXDv1ruCyZrCxKocBW4XC6o7SjkndBBry+imhcUrbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(110136005)(54906003)(9686003)(26005)(5660300002)(8676002)(38070700005)(83380400001)(4326008)(7696005)(86362001)(52536014)(186003)(316002)(76116006)(55016003)(8936002)(66946007)(6636002)(66446008)(64756008)(66476007)(53546011)(122000001)(19627405001)(66556008)(2906002)(38100700002)(33656002)(6506007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b9VqerXh0o31l8wr5AULV8PeC0MvrXu6HdSWitROvp/YULd2nRaA3WzS5XhQ?=
 =?us-ascii?Q?twJWBUr39Uw3Yw6sIBYDcAekr14MZtp7dRvHtFlrCBEAaoun7KQ7Orv9kC6L?=
 =?us-ascii?Q?eieFiUX7mf1zdfnFNcjoFP09FaxYR1v67p684+SCJnDCr4YXPMerurRmo8gP?=
 =?us-ascii?Q?BeHaz7YvUQ4Y2yI/aPhLigw92A+Xc+GtvUjNBbZ6K1w8PHCZt3M01foosQ6i?=
 =?us-ascii?Q?Ofrcb1lndI/lIp7cYsHcrma6hUJS48YjWBkShGwUMXNpR5Z/wi209+AoMIxG?=
 =?us-ascii?Q?lbVm3QoyqeTsmwcPtw6mqXIkXzZW9lNOS/ZKPUTl+KySuLkFxyeQz4NM37di?=
 =?us-ascii?Q?3Hth+YmB7bvqUrSdKnXo4T/wJ8yqoY3nvBQirngeXphCxVWjsipiKsAxZMj1?=
 =?us-ascii?Q?uD/IfV84tgvrNYUzX8sN9qp30lHWS2AgYwyTdT8r3tbVjrdIRvu97fxwr1RC?=
 =?us-ascii?Q?yYM3AZxDjE0FH9nEGZdYJSO+SzF9R9ez1kAg1ipuDzrRfSl8msO5w+/BeBOQ?=
 =?us-ascii?Q?jlMTeC1fSG5/Kds5rfxCxJ7vDSs3Oa8mhUByczjC/GxckEd4ACTcbgwlMgFe?=
 =?us-ascii?Q?g4YMAs1k7HC9axAOY0yImTc7eggGAxHq5fI5iUBKbWJ5J7iQCFCPV0y19Kvr?=
 =?us-ascii?Q?NLKfo0UrK/6CZLNWDgjj+0R+YOCRKn/L67vhbA2mwbLzzoJ7vNULc27XjrI+?=
 =?us-ascii?Q?18CpOcJsatTKt9svwgl6w5tWLo0ReTgLqGaIX9ZIhCTjh+DjhmMZ2+AVUVVt?=
 =?us-ascii?Q?H7xB3aDm6e3OZ6KUB8hRc/pvE+4n0iT9SH76+M96JaTmW+pwjTEUUpB1i4Sf?=
 =?us-ascii?Q?2LTyLykl44YM4wXHLILACqciC2v/DTDX0Si3KaYUt4L8eVFYrHl1Q4nEfMRg?=
 =?us-ascii?Q?WLkkqb8PgaW4W6CeXN8I0B6+VtGQ3+osppdddjBLb36VJllBYaHI3Qcp9HR3?=
 =?us-ascii?Q?O/p+cr9gltY33lHDX6vdahch1u0n/D/HP3306dRiYMRxJGPVPB+GizQWQ+5N?=
 =?us-ascii?Q?lVEboNYb0rboZghB9MyMG0UusBP8Bf0ceQg6bWWG6Oi5l9Iv5oMNmmOVPGnP?=
 =?us-ascii?Q?PgZksWU6PAkL6bXeWRXTgrkWAaY2pk3wpzQGGhz7+AzaC6xnduqZ450LSfpm?=
 =?us-ascii?Q?A3hk68IgQ+8YI85kTgPT56HAvKkQrCr/Fd2DMJcLo6AuFK62szaqTj2XHuX/?=
 =?us-ascii?Q?rV4BPgh5GhSCp0LTy5msT7Fz+iCOkgjUiJyc10dLzBqV46APPdS6dO/T4sVt?=
 =?us-ascii?Q?bIHswYQMWELMuM5dcMtjp2YmNoW2AUtGoAq3GHx8+swyp99o/7rnwLLg/qkt?=
 =?us-ascii?Q?3/61w5qVNp/uJ3wUJi2Ux/9N4+jGvggziRSt28JK1Js7e98D36/Eodrrozy/?=
 =?us-ascii?Q?c/TNGOo4PnnJl8lTN+0QaTwtoyerYOOyVn7fIjslc6ueciRqyhJ7LQVyPWIg?=
 =?us-ascii?Q?TyTwVyE7JZ49O3TcxmaYXmU0hpCnexzwH23dYYkDXfd5Rq7FHBdiNeFoMaCH?=
 =?us-ascii?Q?pZeMARVzV4ml8f7PI1T0MojrzLSgXwFJgMVF548xRQCo4seqjMlSb/PbcNz+?=
 =?us-ascii?Q?FrsCVSEQPa2ILP4AGeyQfP4yqAQzoDHj/CHo8vamr1fnMwkSIDFT8Msgy6Xp?=
 =?us-ascii?Q?OA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F7AB8D1275D4E569F7A1F7509BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc15082-d743-41a3-dce3-08d9d454cad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 16:18:09.3272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TgmkhbCxQZTQZZZ40eZLwdMCHqawdqeWw+KvxzsBPb3G1bV9JQyKEm4hYEY/y0MGCFTIFsIkPoWkBVc9d3uJFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144F7AB8D1275D4E569F7A1F7509BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Seems reasonable.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
Sent: Monday, January 10, 2022 4:06 AM
To: Wu, Hersen <hersenxs.wu@amd.com>; Wentland, Harry <Harry.Wentland@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; S, Shiri=
sh <Shirish.S@amd.com>; Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
Subject: [PATCH] drm/amd/display: Not to call dpcd_set_source_specific_data=
 during resume.

[Why]
During resume path, dpcd_set_source_specific_data is taking
extra time when core_link_write_dpcd fails on DP_SOURCE_OUI+0x03
and DP_SOURCE_MINIMUM_HBLANK_SUPPORTED. Here,aux->transfer fails
with multiple retries and consume sigficantamount time during
S0i3 resume.

[How]
Not to call dpcd_set_source_specific_data during resume path
when there is no oled panel connected and achieve faster resume
during S0i3.

Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c
index c0bdc23702c8..04086c199dbb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -892,7 +892,8 @@ static bool dc_link_detect_helper(struct dc_link *link,
                 (!link->dc->config.allow_edp_hotplug_detection)) &&
                 link->local_sink) {
                 // need to re-write OUI and brightness in resume case
-               if (link->connector_signal =3D=3D SIGNAL_TYPE_EDP) {
+               if (link->connector_signal =3D=3D SIGNAL_TYPE_EDP &&
+                       (link->dpcd_sink_ext_caps.bits.oled =3D=3D 1)) {
                         dpcd_set_source_specific_data(link);
                         msleep(post_oui_delay);
                         dc_link_set_default_brightness_aux(link);
--
2.25.1


--_000_BL1PR12MB5144F7AB8D1275D4E569F7A1F7509BL1PR12MB5144namp_
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
Seems reasonable.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Mahapatra, Rajib &lt;=
Rajib.Mahapatra@amd.com&gt;<br>
<b>Sent:</b> Monday, January 10, 2022 4:06 AM<br>
<b>To:</b> Wu, Hersen &lt;hersenxs.wu@amd.com&gt;; Wentland, Harry &lt;Harr=
y.Wentland@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt=
;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; S, Shirish &lt;Shirish.S@amd.com&gt;; Mahapatra, Rajib &lt;Rajib.Mahap=
atra@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Not to call dpcd_set_source_specif=
ic_data during resume.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
During resume path, dpcd_set_source_specific_data is taking<br>
extra time when core_link_write_dpcd fails on DP_SOURCE_OUI+0x03<br>
and DP_SOURCE_MINIMUM_HBLANK_SUPPORTED. Here,aux-&gt;transfer fails<br>
with multiple retries and consume sigficantamount time during<br>
S0i3 resume.<br>
<br>
[How]<br>
Not to call dpcd_set_source_specific_data during resume path<br>
when there is no oled panel connected and achieve faster resume<br>
during S0i3.<br>
<br>
Signed-off-by: Rajib Mahapatra &lt;rajib.mahapatra@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c<br>
index c0bdc23702c8..04086c199dbb 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
@@ -892,7 +892,8 @@ static bool dc_link_detect_helper(struct dc_link *link,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (!link-&gt;dc-&gt;config.allow_edp_hotplug_detection)=
) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; link-&gt;local_sink) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; // need to re-write OUI and brightness in resume case=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (link-&gt;connector_signal =3D=3D SIGNAL_TYPE_EDP) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (link-&gt;connector_signal =3D=3D SIGNAL_TYPE_EDP &amp;&amp;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (link-&gt;dpcd_s=
ink_ext_caps.bits.oled =3D=3D 1)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpcd_=
set_source_specific_data(link);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mslee=
p(post_oui_delay);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_li=
nk_set_default_brightness_aux(link);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F7AB8D1275D4E569F7A1F7509BL1PR12MB5144namp_--
