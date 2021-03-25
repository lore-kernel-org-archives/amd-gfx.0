Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A6CC433C1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 13:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF86861A1E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 13:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF86861A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89CDA6ED74;
	Thu, 25 Mar 2021 13:40:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB7C6ED74
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 13:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAXbKUn/TCG4aDMA5DYh5NBQFKn3/e2zj46EcxnCoBzILB+f3OWA2OEVJb4GBHzrP6mb6VQ/B2ywxOAPPThCh3JQlLY3Udfg3iwDMRrgdB1rFURoV9BW+k+SVPNoOB7BZ6pIUHFUawZXxu7wxynpHoQKqKfzenFKUoweEWggrebbTfTlWDQjTSnsiAJEW4hMFgJFaObZin5rklXrMKFst4czqXrwapqQu7KhSfraPV14p6PM2U0nr59okNAbf69ieP7i30B+vsp52IZVMhiL2vfbL6unVXKWtJ3CywOba1yokGuMI9UbV2CW4uIihMX4Dy5i4FriZ2EToXYRifQJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFsFEDfQJrctl7IcHhpVXCaTEL6BRtIEOZiRYeQVffE=;
 b=art0WXkwdBjS6Tf2zqMhSxkEJXBX36/twPJ5YCdqIyv4j5WAxF5t+SYDGZwXpXbg9i0JDmg+4SxLh+AVdUFBSgP6OociTDwzgzuT97Y3pu2QBzPqqq2ML1+J2r78LjDnFsLpE6VJahXZm2fpbpwZ4AmoEkCjM03ARY5G1yhMbC/+AyI9wVXJ4ENXgfBTnaH/IorwLlrqmtghIolUWEc/2n3FgJJu9AQ1Ml9NYtVeUgjlheuMskP5yrfh2kR8zkJn3IDYdCCZHNFMbSWZ/cqCqt4A5uIeCheTJ7Kr2s/ZXs3Mxk/WEcYHCEq2KaqTIRsCJSFwtHbZcVI0DCmHGTGLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFsFEDfQJrctl7IcHhpVXCaTEL6BRtIEOZiRYeQVffE=;
 b=zP8VEjfD9nkf8OzNkqS8hT2EQuZ2lynHu81QJhFG5n2WMgecXHzNNdR73Pgp8Fcu0kL30UNuOWDR4O0iIPBK5ClqZbUKbjPksRiOucuWexmQfBaHFJ+ib4Bcc2cUpK0Mq2yfSuS9NO7XzBrLar/6ZDfAmtmBLoMdqNpSYmj26qQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 13:40:15 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 13:40:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: no need to force MCLK to highest when no
 display connected
Thread-Topic: [PATCH] drm/amd/pm: no need to force MCLK to highest when no
 display connected
Thread-Index: AQHXIS4EgWeqi+rTEkqn4A28lD4VqKqUtkUk
Date: Thu, 25 Mar 2021 13:40:15 +0000
Message-ID: <MN2PR12MB448842679A64E3DB9657F91EF7629@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210325041852.1104483-1-evan.quan@amd.com>
In-Reply-To: <20210325041852.1104483-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-25T13:40:14.876Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff4dea36-a3a7-4ca8-b45b-08d8ef9385cf
x-ms-traffictypediagnostic: MN2PR12MB4064:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4064EF02B6BE83004545D844F7629@MN2PR12MB4064.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s2asvjeoGEwD0/f4Wei/FeAJLR0xsm9v9fbiAxecxNemLHTOJf1LeVraSwSwxBDostOFFRbodWV03NwWMF9sN2D1PipJ9Y4gqmZbUSWBTQFvnwclTlLA95VMtFxQcJQeYHv0Q8kLmwxER5ELFcdQoistzZbs5sXfcyrfGEFPbmT272aZG5fCksvN0BL+PbtzXovhLDtf6vUDCTiE5YwTwFcFLSfJkpP2f4MG28rMROOhfiQy/42i4lt4gqv5dCV9XJYlzRO9dbrLDjCxXLFpC6Ngxxg8qvPJnbyA2cVCI6fu2exbVHbxmzzMzZ+meAJt0j6FDoVK0pE395C4p0RZdGMJYp7d25oTf2yll89DNHGw74PMx5GTbn8W2168CF1lYDdu3Aj0j2ticKeM3liNPG7yRunYq5nV25qIpWOxLaA828KN7LDcRRXSIMoR6cn5/hEasvII4Dd/WWLKIG6zENECqvbX78T1WhC+WrqX0IjUsgOgwvUZzvw1CQUiAimXBD/WRu0XydQfr01IgPgwiQNVIqY/9Fpk5kffpw9BLysSz8xlwp1xydpP4PjyWhH/TGapzVEFGEBM9OkFxkmzpVGosCTGN6WFcPXqZB7PAfuTYnFBSsLulgzwjfXi5HZTRZWocDilxsXswY1fcAOt79FMLVKSLPSi//TWGdTI5DCx01NnU26B8AV8BIw4f2Oht0JNisS/1uA0Hxw/kKIkAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(966005)(83380400001)(64756008)(478600001)(8936002)(19627405001)(5660300002)(45080400002)(2906002)(33656002)(6506007)(66476007)(66946007)(76116006)(7696005)(66556008)(8676002)(186003)(52536014)(53546011)(9686003)(86362001)(71200400001)(166002)(26005)(110136005)(38100700001)(55016002)(316002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WtbGWC9tNEVfA0O4X4t38cVq/0Z91NI7EGSL2EJyKA7nvu3Dgr6Fow1xetpk?=
 =?us-ascii?Q?+5UdoeTdrJYS4tvs7g5sZDYrCvpPZMI+fWgox0P+GGVRTDIsvTy4buxf2KKU?=
 =?us-ascii?Q?xzhrDvkH0sx2YVw+oOhJs8YpCF4AyJdc0HLkbeuWdG6aB5dU4wsZFkw/NlTm?=
 =?us-ascii?Q?/HH95eR251C+AbZpdwaLpO61Vyn2Nq8XvPVOVFnNO109FrGuW0FuBr0je058?=
 =?us-ascii?Q?v0X95EAevDzNORMP2wNiREVh4+n+8zDMcKG13SyXAFgcxYtlX2H48/T8n8Aq?=
 =?us-ascii?Q?+vilwulloRtJ+14FcCrllmBIeUh9B58tHRmIiSkUyrFuSfv6xqiqR/gOTO1c?=
 =?us-ascii?Q?BtqPsUBwQMT/N7mg6e2NclhyAS4j4Eo1uTXflFBoGAFQmVfJ5xU0xS448SOO?=
 =?us-ascii?Q?KyfKuw0KMbkdYCsvjfbAA3kitdKUcioXM4APu0acEwUeTIGuldwCIYbfgmUh?=
 =?us-ascii?Q?ajOCwFJPXbwOPfx8JlzEHw3rbDJDwDliaPKX97N3YTmZ1cd9eeE+oceOQlr0?=
 =?us-ascii?Q?kubx1JY1dn3h9qDETkkaLTR3m0ifTV303Q5Snlna84AeAo9V85pHJcs37u+3?=
 =?us-ascii?Q?USOGhYCz6cQbo9gvunDXZLdv9twN/iIoLLCh3bwMRf3aP0bwxlh60ifR5eFh?=
 =?us-ascii?Q?0eB0khsCOm8Ig1yuAUPn5ie7wC6foAe1l4rncU6HnGmzhxc5EpWkCs2WMEkw?=
 =?us-ascii?Q?YD8vjLRoRv6RbRNDL0KM1Ec0X/gRvu4D9MfEQmG2CwCqXla9zPXcwTwSYn9w?=
 =?us-ascii?Q?F/BGUxM06UOYy1nHyiRWoVdxtJluZkFqQTi5C5TfnTi7OVrNxnqj0Nxa2O29?=
 =?us-ascii?Q?EHeSJIFGN9oaGsS0rgBvYmFFDlEh0U/b1Pye2MqG93He+BB5OJjPRWifLHD+?=
 =?us-ascii?Q?yg1aXCXRrfY+nX9K+iFiLLpzwctkLdQY2R46knEq6AyqFV7HkO+dXAlSK4no?=
 =?us-ascii?Q?l0bahexGT933STlgOGR9HA0vmalB0P1Xzen2IdvBZI1WtDOJjqMUwiYfRHsD?=
 =?us-ascii?Q?ytmyEpDxvVlFdX7IvAsfy9Z7o/ihBHT2tN5ozokKekovi6zF6LthOhEHebLg?=
 =?us-ascii?Q?ghHwqc1+uz+BomDzz4hXRn+c/BoWr2e/J+fqefLCePIj1DUFt34Mo1GIyxwc?=
 =?us-ascii?Q?3KQQrxgjenCwoE3OQivWyY7VMxYY+suPm7oZ2Xoa0O35XahlMZTN15TQf1pf?=
 =?us-ascii?Q?jfsDiBzB2Q0okpTlB+tLv0ZIS0N7GezFa3zAZChAxQHUdWwQbulBwEgttFra?=
 =?us-ascii?Q?WAHuP/5qdVEqWSNzXTqHo+Y7OQneaLURFUhqZw4IHtJUJKZodiI5yTJ+XXMY?=
 =?us-ascii?Q?qHs0w2S647opmGf7eC45T2zz?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4dea36-a3a7-4ca8-b45b-08d8ef9385cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 13:40:15.4529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6J2lJRoJhMIpwbzi+8gZ6QVhsaevAS9U8qRDdgzaeGGwazQWDoZQaWQxuvEgQdjvw5djrGHr7AYmHR9bdpDUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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
Content-Type: multipart/mixed; boundary="===============1664259104=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1664259104==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448842679A64E3DB9657F91EF7629MN2PR12MB4488namp_"

--_000_MN2PR12MB448842679A64E3DB9657F91EF7629MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Thursday, March 25, 2021 12:18 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: no need to force MCLK to highest when no displ=
ay connected

Correct the check for vblank short.

Change-Id: I0eb3a6bd95b7f6d97029772914154324c8ccd2c0
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 7edafef095a3..301b6769f007 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3330,7 +3330,8 @@ static int smu7_apply_state_adjust_rules(struct pp_hw=
mgr *hwmgr,

         disable_mclk_switching_for_display =3D ((1 < hwmgr->display_config=
->num_display) &&
                                                 !hwmgr->display_config->mu=
lti_monitor_in_sync) ||
-                                               smu7_vblank_too_short(hwmgr=
, hwmgr->display_config->min_vblank_time);
+                                               (hwmgr->display_config->num=
_display &&
+                                               smu7_vblank_too_short(hwmgr=
, hwmgr->display_config->min_vblank_time));

         disable_mclk_switching =3D disable_mclk_switching_for_frame_lock |=
|
                                          disable_mclk_switching_for_displa=
y;
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C96ae73006f284dd59a5d08d8ef452656%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637522427565407677%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D3S%2FkGh8zi1uLEonF3G4kWmozbBPazZJeuwTNAFhRgdQ%3D&amp;reserved=3D0

--_000_MN2PR12MB448842679A64E3DB9657F91EF7629MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Tested-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, March 25, 2021 12:18 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: no need to force MCLK to highest when n=
o display connected</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Correct the check for vblank short.<br>
<br>
Change-Id: I0eb3a6bd95b7f6d97029772914154324c8ccd2c0<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
index 7edafef095a3..301b6769f007 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -3330,7 +3330,8 @@ static int smu7_apply_state_adjust_rules(struct pp_hw=
mgr *hwmgr,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable_mclk_switching_for=
_display =3D ((1 &lt; hwmgr-&gt;display_config-&gt;num_display) &amp;&amp;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !hwmgr-&gt;=
display_config-&gt;multi_monitor_in_sync) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_vblank_too_short(=
hwmgr, hwmgr-&gt;display_config-&gt;min_vblank_time);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (hwmgr-&gt;display_con=
fig-&gt;num_display &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_vblank_too_short(=
hwmgr, hwmgr-&gt;display_config-&gt;min_vblank_time));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable_mclk_switching =3D=
 disable_mclk_switching_for_frame_lock ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; disable_mclk_switching_for_display;<br>
-- <br>
2.29.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C96ae73006f284dd59a5d08d8ef452656%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637522427565407677%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D3S%2FkGh8zi1uLEonF3G4kWmozbBPazZJeuwTNAFhRgdQ%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C96ae73006f284dd59a5d08d8ef4526=
56%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637522427565407677%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3D3S%2FkGh8zi1uLEonF3G4kWmozbBPazZJeuwTNAFhRgd=
Q%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448842679A64E3DB9657F91EF7629MN2PR12MB4488namp_--

--===============1664259104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1664259104==--
