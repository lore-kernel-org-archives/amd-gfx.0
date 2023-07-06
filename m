Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C049EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 13:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A7D10E0BB;
	Thu,  6 Jul 2023 13:55:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD3410E0BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 13:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Re94o1vgpXP09xbEkd4SXMpDSJgQr3xLJ3F9NHHUya1AvHWg3qltHaol7qMC2QIJDCYkOCt8HUOOsQMRvVlB1zBm46tXteH7/Z3IDjac/wfmYl4SJ+4BlZ2eV/6kgS8vni0ffFL6alFdhIUgYxGwQCQ/hMZmtlPRR4upveVIGM56sUrWwixKrIZggLsahycW9wPezfjE4dzvYK0Z3bebuvcajjyWg565HLMZ+dhzzKII8qIjAAHi+wlFHXcTA+LjrWDib/efPrw6VpC3P6PU5RHCvBRotemWXL8rJ6hmiLq3ZrdNdONrNLQtaNHHut4xx34lUaPADL5EACSmrGNsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eH5cWNEDNyYWLaGSKbQJ5cG0dR3mtMnism4T19VLNl8=;
 b=Qx6d/pJrE9ysI71hsoJBklywWRBgVPSrUljnZeBQ+4SbOXhDN4BQ6Cfbz5TUBy/8BxNwnU7nMGl3YWu0EA7CriA49VNKxKov4Jo8A7cBN1wboIcNFlFbKVqklqaF2D8Qgfzh8Rq6vKC4ELgkLFOZ2ZVMymbI2beFQR3KMkCJIqnMekA2tGd7gwg5i/GV4FdIayGm1exYv3yO8ll5gn+/NpstLRcdODgcxQDobzC3vrslTlAbz3GtTccWcVgg3VVfIx/gtfdG+8DOx0KV44Kvnt7BfUcDblcS5fdZwSb1IB9imiTq758rkTQjRyEd+SBxVX0wIHVjUrJMQHktG5EGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH5cWNEDNyYWLaGSKbQJ5cG0dR3mtMnism4T19VLNl8=;
 b=hn1r7zV8rvuJ5tuwxDx9P7nzsR4nSVuoaPihnDBIl4rIQYlxvwC2FMoj9t1SsSR3FpsGkMaYx+OUAlhFM75BT5USnGlHxUo0z8JOKm80tP6eVk3olTCM06HgBjJrwZ451T7FTNRnI6XFIeOwwoH3nrmpMf1DrSiSJMM/Hk1fJ4I=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 13:55:12 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:55:12 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel.daenzer@mailbox.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Do not set drr on pipe commit
Thread-Topic: [PATCH 1/2] drm/amd/display: Do not set drr on pipe commit
Thread-Index: AQHZr2ug2Rr1VBGArEyzNhkdghCT2q+shBWAgAA/C1Y=
Date: Thu, 6 Jul 2023 13:55:12 +0000
Message-ID: <CH0PR12MB528437E7114C0CD07C1491F38B2CA@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20230705180752.2813978-1-aurabindo.pillai@amd.com>
 <dc331ebc-7032-033a-0076-b80472920e79@mailbox.org>
In-Reply-To: <dc331ebc-7032-033a-0076-b80472920e79@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-06T13:55:11.276Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|CY5PR12MB6105:EE_
x-ms-office365-filtering-correlation-id: 73fe001c-a945-4fe1-dc8a-08db7e289e80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3GV5JEd7Artkyw4H+DK5y6FBW+aA7Dx64NlRlPi5Krnojvf+aG2ShYXXaiyS03YcSXBZG+jqhA4+6CE+F9FQO23/0llyBmj/MFQxfanu2XwNHQbJdnlXZUedkEXxQi8+JxxMRcIFLwAlqZMDhYbGqRIknaHku0SjPPKQDNsBzmrS8J4ye4gBdwMqWuC8oa3+yrwVjazJiGo1EGvC2apYDOzvPGb/0hi8OhVV6BDLgj71E+ZOpBDBXOYmEcuR8AyiE7tPJPSO2Y1niF1a0XHBdkb6KFEXLehtdGUck6XgPP6ra+4tKNNrVAK/sSFKj0XL1+9gyLlS27e5R7Vytrgqw3PcBN99cLOuUGc1Tzi035ozLfTQe9BbbnbzRviySaiItIpuyobuwjFa9fuEuSgyzfHuHJu/HJdzItkcf9OG45IIbM5X3aSJCyAaIT03doRTQ7l6ootxe917TQXCCxosScu05b1SeX/CzbKEO7LFto+HVQqwlIQZ/l+UPPKleGorXHPKyLZRHG66TtRbTbO1nGGFRIuZT2mvuQPiKI4S2XD4/9TwKQ3EgKhvO0ki2bxqSO4UVsuI2IIynRXe/i+S1fvXqFRoXRa6fNN0VFJFPw8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199021)(86362001)(8936002)(8676002)(41300700001)(38070700005)(66446008)(66476007)(66556008)(64756008)(316002)(2906002)(52536014)(5660300002)(33656002)(55016003)(966005)(6506007)(53546011)(186003)(26005)(9686003)(38100700002)(122000001)(71200400001)(478600001)(7696005)(19627405001)(83380400001)(66574015)(54906003)(110136005)(166002)(4326008)(91956017)(76116006)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jspXrpMnaVpTeBNMNmw56qSz3Wo7KbHlOZq6gN84/7tbU/Z/kHiuopl4I4?=
 =?iso-8859-1?Q?BLzTKXDpraRfOAMiy44YkJVKmuv7MZHCG2FtPkPPI6CCyANJZAvfR+Ye7R?=
 =?iso-8859-1?Q?XhnlJ8YlbrJJxVTkZxa6L0gx5EbPTF8u39IBtsoFbwEcgjFF1SIHmz7kQH?=
 =?iso-8859-1?Q?Q6nIALfO0jcOVwX2QkOmezGxhxh5AkJEdraEtxYbEWdiM1qgWsJ/YODa00?=
 =?iso-8859-1?Q?1vvnUIrD5uqW5Bm/p6zMOSQey89y8TmnpJUyK6ExM+MNBiVvYA/4BkM1x8?=
 =?iso-8859-1?Q?8NJEOwUY8Fp3kLpLnLgtNqL38kG6Oaq15wZHrD4gU43+MMMuORyrML1qc8?=
 =?iso-8859-1?Q?5jnj2oDmviZFzJranB+AANFsFuWCOFx23g97e+wvXKM3L7Yq8fTkQiiHIZ?=
 =?iso-8859-1?Q?yVqkTFwbZPaNVPCGgyos9IEzVlv+g/HC/XHExz5sQJeIkRaN+8hfh8IWgk?=
 =?iso-8859-1?Q?LAmhgtn7OS0j8ZLzX/O8HTqZ4rioFstr9bhdhyEauE1nkjkTy10GvBwSXA?=
 =?iso-8859-1?Q?5PBodfFNW/l/q8qYR0ZYlVUnLeZ56Cp0eM67oNHTeh8kGwxgrfAGE1eJKu?=
 =?iso-8859-1?Q?8xFkmKV43gb9S1FypOpuL4FyYYbCtTczyfCrMWZTUcgKIy4YnYlwcYuOfH?=
 =?iso-8859-1?Q?tpU4yxUUf6ndmpKoHT2IQwiwBY57VuHozfAxYhLYeCJ341M/ibsdlW/bXN?=
 =?iso-8859-1?Q?Zs7JrRURrrfUrLEAZkm1ee3efoLxHiPRRDS6b5s8Urxmu15bZxlxeb+62L?=
 =?iso-8859-1?Q?mscpS3qylo32portt/eRgWMMX7u2d/iTAP4eSo1A5N+qLBJ2x1gAn/8+i7?=
 =?iso-8859-1?Q?vgC9CFBBv7pUqzFzmxDj7FtYK2bvIW+Fp1y/jidFD/gXmCSWuLlxHKJzwd?=
 =?iso-8859-1?Q?eNQge2XVLwfc8XY7EeWmBCJrvkb7H8v/2LPXPTW0+l3KLGZhK2accDjHjl?=
 =?iso-8859-1?Q?SXFS9QjYDNTWmOQs8xAHEef1GCr7DqL7ZAqrenUgQFP4QDlKKowqreG6O2?=
 =?iso-8859-1?Q?39dKIvSn6zLTfNhzOI+5eRqieh6aaPXf/VuScbeZmHwpF9KkpIXZqwT4oT?=
 =?iso-8859-1?Q?XxsE2ErFQvi4KpA6I0I+H0piAFKVJxYa40R3Dq4OTtsmTv7hdKnw6CvPM0?=
 =?iso-8859-1?Q?eDyOzTdm0oVVpWN0GRJrJhhf1pw9Kft08aMcSCuEMa01qhrjjkcoLXOEWD?=
 =?iso-8859-1?Q?LuFJhjVim9biZRqpqRQuo77mvNx5xfBxdkrZChxedz+sqsTgubsuoTauWL?=
 =?iso-8859-1?Q?orxlyAligBYuqp2R68EU96QJLzDaem1GKaUKC58m7pp/Jee7e14AcHIImt?=
 =?iso-8859-1?Q?qLlyjAL7Go6iEDA6s4QwkeOxm1tREd1+7AQT0d74dMjkIMWkL5vgG7nl8U?=
 =?iso-8859-1?Q?zSZcoJ9Cubop73EJ86X3SS7nWGvvksWbxiayduXLNIqK6CigPYUDNx0FzZ?=
 =?iso-8859-1?Q?X3qfs1XJ9gntSTJqpPmBABKn1V6BpRrSEklaEFfajqqK0Kqf2UHaA/LHkE?=
 =?iso-8859-1?Q?jgOT8o60yst3Dkq4FEq85v29nq79obesjKkmqhcPhsZcvY7FyGJSOample?=
 =?iso-8859-1?Q?W3WLCm4MBEARKj4itF4cV54YFEYLcWzyvHH5agG0Q08urWzcJlT8irmWF8?=
 =?iso-8859-1?Q?OZVgCeSSdS/Tc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB528437E7114C0CD07C1491F38B2CACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fe001c-a945-4fe1-dc8a-08db7e289e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 13:55:12.5918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljbk6PCb4wXd1HMEvAixaXBVtIa6QEBx5LecRKwMhdTRCaXFHEQiqJot6PocP9y0Y8bbAJd5vi5hnkcsq4BzMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
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
Cc: "Chalmers, Wesley" <Wesley.Chalmers@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB528437E7114C0CD07C1491F38B2CACH0PR12MB5284namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Michel,

You confirmed in another thread the monitor specific quirk for disabling FA=
MS fixed your hang. Fixes references the commit which adds such quirk:

de1da2f7fe25 drm/amd/display: Add monitor specific edid quirk

The intention is that these two patches should only be merged into stable t=
rees after applying the monitor specific quirk.

--

Regards,
Jay
________________________________
From: Michel D=E4nzer <michel.daenzer@mailbox.org>
Sent: Thursday, July 6, 2023 6:05 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Chalmers, Wesley <Wesley.Chalmers@amd.com>; Siqueira, Rodrigo <Rodrigo.=
Siqueira@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Mahfooz, Hamza=
 <Hamza.Mahfooz@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; W=
entland, Harry <Harry.Wentland@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Do not set drr on pipe commit

On 7/5/23 20:07, Aurabindo Pillai wrote:
> From: Wesley Chalmers <Wesley.Chalmers@amd.com>
>
> [WHY]
> Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
> pipe commit can cause underflow.
>
> [HOW]
> Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets
> optimized_required.
>
> This change expects that Freesync requests are blocked when
> optimized_required is true.
>
> Fixes: de1da2f7fe25 ("drm/amd/display: Add monitor specific edid quirk")

Seems like inappropriate use of Fixes:, or how does this commit "fix" the r=
eferenced commit?

(Also a bit surprised to learn about that one only now, and that it landed =
without my confirming it actually works)


--
Earthling Michel D=E4nzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


--_000_CH0PR12MB528437E7114C0CD07C1491F38B2CACH0PR12MB5284namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Michel,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
You confirmed in another thread the monitor specific quirk for disabling FA=
MS fixed your hang. Fixes references the commit which adds such quirk:<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
de1da2f7fe25 drm/amd/display: Add monitor specific edid quirk</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
The intention is that these two patches should only be merged into stable t=
rees after applying the monitor specific quirk.
<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Michel D=E4nzer &lt;m=
ichel.daenzer@mailbox.org&gt;<br>
<b>Sent:</b> Thursday, July 6, 2023 6:05 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Chalmers, Wesley &lt;Wesley.Chalmers@amd.com&gt;; Siqueira, Rodr=
igo &lt;Rodrigo.Siqueira@amd.com&gt;; Wheeler, Daniel &lt;Daniel.Wheeler@am=
d.com&gt;; Mahfooz, Hamza &lt;Hamza.Mahfooz@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.=
com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/display: Do not set drr on pipe com=
mit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 7/5/23 20:07, Aurabindo Pillai wrote:<br>
&gt; From: Wesley Chalmers &lt;Wesley.Chalmers@amd.com&gt;<br>
&gt; <br>
&gt; [WHY]<br>
&gt; Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as =
a<br>
&gt; pipe commit can cause underflow.<br>
&gt; <br>
&gt; [HOW]<br>
&gt; Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets<=
br>
&gt; optimized_required.<br>
&gt; <br>
&gt; This change expects that Freesync requests are blocked when<br>
&gt; optimized_required is true.<br>
&gt; <br>
&gt; Fixes: de1da2f7fe25 (&quot;drm/amd/display: Add monitor specific edid =
quirk&quot;)<br>
<br>
Seems like inappropriate use of Fixes:, or how does this commit &quot;fix&q=
uot; the referenced commit?<br>
<br>
(Also a bit surprised to learn about that one only now, and that it landed =
without my confirming it actually works)<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://redhat.com=
">
https://redhat.com</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mesa and Xwayland de=
veloper<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB528437E7114C0CD07C1491F38B2CACH0PR12MB5284namp_--
