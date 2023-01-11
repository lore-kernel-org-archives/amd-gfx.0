Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E948C46467
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 08:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD52310E6FC;
	Wed, 11 Jan 2023 08:35:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 284C510E6FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 08:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYOztbX7NFiKZq/mS5kChYF2po6S7PB3qFsxGjluec1wu9Aqs51RZ8R3nxnMXwHS1gzWm8WH0A67mSaIySgh8klcLyYv1A9Z/2vrudJ+tVyezfUR+4Bpw3C4+gpoQhjpP66+Oi0xyyiZZT/VRWS7Mj7MbMHZF2xYI2cZq16eWnKhco+NFfTg18cT2l7PrMarQXa6BgfuiXrhmAwjntuun8tAyPNbiEs0XW36FbMiy58srYF/ffODz/Ag0cxe6ZBKH/ZuTukqJUK5+7F1HIGWaTafoEXzLVWD++83qTlBNwFsADJ4RFc9yb2z9unGuAjxuQGeeRJW222h+FdAAoeiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dV3HeRhryLWthzd7LxkcToBuXdZbqud1gGUZifkHhA=;
 b=Exz5Q/gnqcX22foEe07aKSjBKgjaL/IQLMTXxZnJgoRC2fIO8olu6XxLK2jP7oXpyP2oPvVNH2hQU9eHR3yt1sMySAQeZiuyJsWQJ7R8O/d40Q/WHSrZeFv6Cs3TvEzGdu6GGDPUST/HXf9UZBWYMx+VZXmy1+cr40yj92qaF/38022BMosq34bG406AVVBhPph4s4wqqzFJHP9dHgHGiwokLR7WRvqGR8T+UgX+a8GGKFbcDSZ7mrnqh63R99Rnh2Hba6tEJ+KoWH1uSP0mXRiMYzkVfq8L6xcMWdy/l9EDjMovhaIjunAShjHeL6BQqyWQfz+LihbHkPsQeYp9ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dV3HeRhryLWthzd7LxkcToBuXdZbqud1gGUZifkHhA=;
 b=Oi8CoiVSoHiWpsk39WRSwGfwdKHpzJgn8ygiSO9efr0E878tVoTYjCOxiPZfAqe9vg963Z29kxdpcw5BqqI3/4lt1qc9cTRfcFFopP4CVrchPQ+q7Z/ssou89zcAcAPoJQ9FNJksruHSxVOrFkxAIRaazoeb9Z0g2DWX9FNilQI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Wed, 11 Jan 2023 08:35:16 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::d068:807d:11c:eee0]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::d068:807d:11c:eee0%5]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 08:35:16 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Yury Zhuravlev <stalkerg@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: Wrong revert commit in stable channel
Thread-Topic: Wrong revert commit in stable channel
Thread-Index: AQHZJZZnun9ZlWX9h0CgMxUiBRz2fa6Y43SA
Date: Wed, 11 Jan 2023 08:35:16 +0000
Message-ID: <DM5PR12MB24692E12F2C533BD8D88508AF1FC9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <CANiD2e9bdhxdJr_N9wb7O0Su+LRhzE1n=TepvbBiOoqmKRRgeg@mail.gmail.com>
In-Reply-To: <CANiD2e9bdhxdJr_N9wb7O0Su+LRhzE1n=TepvbBiOoqmKRRgeg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS0PR12MB7874:EE_
x-ms-office365-filtering-correlation-id: 8e312e14-432d-4d8b-a307-08daf3aec42d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQNQEpEADNToCEXhem0Y5Io84a2t+0XFyiAobho3e27AbELwLdn9ZP5ecZeqcPy2m6NWaFmxl8NHokONW4rqqhHUGeln60ickmtzSlGvKVdBLhy8z+adwemIyO899W0ncygrnnObKXUAwFHbj5hgWuOv9u+XQPByWjjqQqgnO93czCbyrHj2U7AB2rORbdES/AaswNdOAGbJrKsNgU0Zp5wVFlNxnivjKaaQyTknJRBuNuPv1U6XvJeSZ2QiO2qHpD+35z/X1d/sHzF2LmlPLSlxRPxVu7EtRDfhqs51EkmQ7y2oIXZMRMNdGvKfzmoynZ9OTmXEgIyS6Ht7g/5L8BWOkjUlFHd2Wiq//A4ceXx71a6QEaf6fqQosxRcoHVml5TvWNFFv7a/b5Vur2kBezmNfteN9PqMWi6myODLdg3z7c+8HEp5MR6HzlG1DLDZ6Wmp+dIAGYmy/WbxuupUiJ3mPWDAh6cWaOfXFyhOXZqImqr4TGchhBrzw7n1TnynspzT86opcKUx/HtMRWYkJSAjj6dEUFYBJKQQeUkglrTNN9BUebIj81rdGI5FrCd8nvhwkdYP9UM5RwL2eKUY1ru3qVHuTbg+HeJyev1bQR6VKS2VIDrSzO+jNMkxCBqvuKbK5Hr81IJ1GNwSo647Pm+rdqriqTPR18vTdupyUFDouwXml7Xsa49ipy9V1GSKFdvGSiLJR3p2DSX1h1WhXRs/0eQFWAbAMHnLEqWQSzDiPPCeF2tIAAhu+KXGmHPAIjxgbJl34wNOqlwvAuaYHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(6506007)(2906002)(8676002)(64756008)(66446008)(53546011)(5660300002)(9326002)(8936002)(52536014)(122000001)(38100700002)(9686003)(478600001)(41300700001)(166002)(38070700005)(33656002)(966005)(26005)(186003)(66556008)(66476007)(66946007)(76116006)(7696005)(55016003)(86362001)(71200400001)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mKsq83sc6RrhyNjeqFsG+ve0PbB2vlU1ndY5leM7yK9nkZxUNhDiKIIcZZ8I?=
 =?us-ascii?Q?/usss/rQ46Q+btatRsFOYPnuk976OYoUI0tSELdzdn2L40kBXOSkLro4PmJd?=
 =?us-ascii?Q?TCSneWV1nLkupQRQqHAwLmreqJRWDDpL0iF5egnnfQq6bg4QVDYgTnJgFHZ9?=
 =?us-ascii?Q?KjRxNT4p0UoSfNonpHong+3PuwwZk4xm/1j2325hUHCn991deAVTR/6VpG+c?=
 =?us-ascii?Q?LwLJqJm+djCNRDKuzBtieaQ9teWM66rRdm6blVXJY3G/NbjvHiyfHGbuc0Vj?=
 =?us-ascii?Q?kOuFiJ+UOICpZrjOg7kG68ZMh/vOvvuzBGBuICat01kCghwn+BD2266vJMqe?=
 =?us-ascii?Q?UTjQIc7CQZ2kojHWYH+Z7E9x7OHNeKi56TEjMGT23u10TmoP/JU9EV7BtpAb?=
 =?us-ascii?Q?Ykg7dnH67UEu52Y7UTdt9KgdxPUmH9+6cjaoUrD1vxD1u3meCORs5B5FfiAF?=
 =?us-ascii?Q?j7oLEKXjGvbVr+boXmnlulWkta9qSH+zqMvOoiv60T3qTWQjydGSlUZtv8DG?=
 =?us-ascii?Q?Z5vL2GuV9IzXODQl1ef3s9oh2UcGT2TxeKHPY9OvTe2aj8rwsgQd2sC0RN1N?=
 =?us-ascii?Q?kYdJ5EnxF87+mWDmqcHduoafGnI+i9OB9fIIIi1xPAKFnCp1fujHdK1srU7A?=
 =?us-ascii?Q?lN/qTyeOil++SNiOEzOPcJXWQn16hD/VzvJegimSPcLXAD17eE1rGGtEAPEM?=
 =?us-ascii?Q?9A5UtEfimxUke/9SJAGYwtFUtmQ2iBqebH9wg+obv8MHsN0Dasq2KPi8oPq+?=
 =?us-ascii?Q?7Stfbx4KLxBu25Yq0WtYHYkleyy1f/nqGW3eFfhL0vNRTUqLWHdRq836HMaJ?=
 =?us-ascii?Q?dYrZw4mPhl4ycI9iIDjSLsztg/9rW9XW/Jv2al2S9jPJY8nIX5w0xk+AbOmx?=
 =?us-ascii?Q?NvrpK1RD/z9XGds2hiJ6/+3jFpfQlkKuuOWEBWorLVp/lIIM8O8lIw8Aykiv?=
 =?us-ascii?Q?x1UCCCTC7xkjedP/gpKVAMvx6fpuxKz9sJF9osizXuQyWmPy6RG/u/0mbpeL?=
 =?us-ascii?Q?6QFg/+1BaQ8zqafLXG0UG81sgeFclCqXW26TUs4jyDEJeMWzAGT93mBn9XbS?=
 =?us-ascii?Q?fkr2lKhSp1QC+oedNdvJV1zXlY6I8yEuqn7twU3SeU2yTAFqWXcQPAoL663s?=
 =?us-ascii?Q?JpbOOh3B53Ce1I1lNycZqpTcknjLv/5O/8WyWLbJDYkRN35bhp3jobRwb313?=
 =?us-ascii?Q?LqQC3ifTAKP0MXt6SZUOmg9mxRPezwndtnKCXt0LxSFFdHYChRfwM6mVfsEk?=
 =?us-ascii?Q?SKycL2yGutBKnaUYQpCivHDsPosaSPhuqqysaXvdU0474k5lMrf2TQzmZp+e?=
 =?us-ascii?Q?qgnvl6veFAoNlF9SJma7XxfMAY/uyVepkp9Iv83MINVDxdKOwB0B2jLoj0Pj?=
 =?us-ascii?Q?RSTG/xwzX3GeyVOpLoOkRGEqPHRYcTd/gSdYCNQh+Z+YpcCv2eT51KFRS60l?=
 =?us-ascii?Q?Bs0zIokTSxPxTfopOHmk4hfh3LI6/C6ocZb6E1PU+p/ao5NKHis9usHjNxBI?=
 =?us-ascii?Q?7btoyU3i/MszoCNHANC1RQioelZm/EAbasku0VcBxz98Kl+o62x8DVzstIHf?=
 =?us-ascii?Q?zxszjgwKVWsyVZaBHsBOqewM1M89VCsNDs7Ucm+r?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB24692E12F2C533BD8D88508AF1FC9DM5PR12MB2469namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e312e14-432d-4d8b-a307-08daf3aec42d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 08:35:16.6905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dODJZdfHD3V6gi7CuqF1tovjcOIOvo8EQIWo95wpb2oqJwNQ38pKUhe4WyExX5v+C/p82bcQL61kTM7quM+46w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
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

--_000_DM5PR12MB24692E12F2C533BD8D88508AF1FC9DM5PR12MB2469namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Yury,

My understanding is though that's a revert of your original patch, we did a=
 revert again on top of the reverted patch later on. Can you please sync to=
 below commit to check again? Or do I understand wrong?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/gpu/drm/amd/pm/powerplay/hwmgr?h=3Dv6.2-rc3&id=3Df936f535fa70f35ce33=
69b1418ebae0e657cda6a

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yury Zhu=
ravlev
Sent: Wednesday, January 11, 2023 4:26 PM
To: amd-gfx@lists.freedesktop.org
Subject: Wrong revert commit in stable channel

Hello,

Something went wrong, and we commited what we diced not commit.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
h=3Dv6.2-rc3&id=3De5b781c56d46c44c52caa915f1b65064f2f7c1ba<https://nam11.sa=
felinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.kernel.org%2Fpub%2F=
scm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fh%3Dv6.2-rc=
3%26id%3De5b781c56d46c44c52caa915f1b65064f2f7c1ba&data=3D05%7C01%7Cguchun.c=
hen%40amd.com%7C9b399d97a2624b5bc46e08daf3ad88a1%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C638090223898249455%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=
=3D%2FkLymTjCMQ3uC669%2BWNXePiZ9ysaAGdvm7gFw5kIGeQ%3D&reserved=3D0>

and

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
h=3Dv6.2-rc3&id=3D4545ae2ed3f2f7c3f615a53399c9c8460ee5bca7<https://nam11.sa=
felinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.kernel.org%2Fpub%2F=
scm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fh%3Dv6.2-rc=
3%26id%3D4545ae2ed3f2f7c3f615a53399c9c8460ee5bca7&data=3D05%7C01%7Cguchun.c=
hen%40amd.com%7C9b399d97a2624b5bc46e08daf3ad88a1%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C638090223898249455%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=
=3DI57dx%2FORRXDeu0TTENlejr0IcuSncVHfy7LCPOJNekw%3D&reserved=3D0>

It's wrong reverts because, initially was an issue with a test case, not a =
patch itself.
My GPU is not working correctly again after such "stable" patch.

--_000_DM5PR12MB24692E12F2C533BD8D88508AF1FC9DM5PR12MB2469namp_
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Yury,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">My understanding is though that&#8217;s a revert of =
your original patch, we did a revert again on top of the reverted patch lat=
er on. Can you please sync to below commit to check again? Or do I understa=
nd wrong?<o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://git.kernel.org/pub/scm/linux/kern=
el/git/torvalds/linux.git/commit/drivers/gpu/drm/amd/pm/powerplay/hwmgr?h=
=3Dv6.2-rc3&amp;id=3Df936f535fa70f35ce3369b1418ebae0e657cda6a">https://git.=
kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/d=
rm/amd/pm/powerplay/hwmgr?h=3Dv6.2-rc3&amp;id=3Df936f535fa70f35ce3369b1418e=
bae0e657cda6a</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Yury Zhuravlev<br>
<b>Sent:</b> Wednesday, January 11, 2023 4:26 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Wrong revert commit in stable channel<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Something went wrong, and we commited what we diced =
not commit.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"https://nam11.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgi=
t%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fh%3Dv6.2-rc3%26id%3De5b781c56d46c44c=
52caa915f1b65064f2f7c1ba&amp;data=3D05%7C01%7Cguchun.chen%40amd.com%7C9b399=
d97a2624b5bc46e08daf3ad88a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63=
8090223898249455%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D%2FkLymTjCMQ3u=
C669%2BWNXePiZ9ysaAGdvm7gFw5kIGeQ%3D&amp;reserved=3D0">https://git.kernel.o=
rg/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=3Dv6.2-rc3&amp;id=
=3De5b781c56d46c44c52caa915f1b65064f2f7c1ba</a><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">and<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"https://nam11.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgi=
t%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fh%3Dv6.2-rc3%26id%3D4545ae2ed3f2f7c3=
f615a53399c9c8460ee5bca7&amp;data=3D05%7C01%7Cguchun.chen%40amd.com%7C9b399=
d97a2624b5bc46e08daf3ad88a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63=
8090223898249455%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DI57dx%2FORRXDe=
u0TTENlejr0IcuSncVHfy7LCPOJNekw%3D&amp;reserved=3D0">https://git.kernel.org=
/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=3Dv6.2-rc3&amp;id=3D=
4545ae2ed3f2f7c3f615a53399c9c8460ee5bca7</a><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">It's wrong reverts because, initially was an issue w=
ith a test case, not a patch itself.
<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">My GPU is not working correctly again after such &qu=
ot;stable&quot; patch.<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB24692E12F2C533BD8D88508AF1FC9DM5PR12MB2469namp_--
