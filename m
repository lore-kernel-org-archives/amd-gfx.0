Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8407CC38142
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 15:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DDC10E4B4;
	Mon, 23 Jan 2023 15:01:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB37F10E23D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 15:01:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk+yqVqEDXtiJGRTBVoPHJwc9qUgb+DWiowjw0wcQhvcLQOdZ3jnZIDliiIht70D/bXpzd6wcVAkk5YbenyohOg6pNmik1a3n/70XkZ3ag7LFw/6jnNxomw4KgsLZvyP1V1CO3Rr7Y6nqcShU49+HNv248yH1J78edJSlIBPXw0wHZpOfPJ1/WAZDUz58r1j+ydF1UiFF94HYgH9wbZKyAxS6H2rpKv5qhhDz7n47z+sltFim55RxSSqNkXFOi6+VWr3woc0GXM9RZHMazbzpKAMUdI7+GGjg74jLdym5GwQsMPGGGYVhuD9DyPMsk1I09bU8ohc/Vy73iMptT9KBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj//TVdtKD6uPbQzlonycPniqS9xgALZUEC9DHcKJtM=;
 b=XzyFs1/XvV968r3fAwz7SvF7uxP4mfKGilZ+KqXsuZsw8RMKdj6MPLwDma4kdAVE0u2n6lYzWRZFGogrAIP4H5qtFGVEfdKKhm2es21koJzlc40za72h3+8lw8Ab0lm2xhjodUy5B1ANObA8iBeqABWQW/N+9f4Xt7pnBbdoLJ77lGD5ZY9dzoCSTgTojFcHFnK//NhVZKu9yPKy+0y6I2B3UIFDFIpa4Zwn7bHYGQ7sA+b/sixjcSLNwb9RhozKx1i9obTMSLlx/NKoe8jJxgF3FSmR5vwzSki24WMQW+uFVJlUSDKO2khC7uWHbl36T4FelaCIYGpFburtPI3uQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj//TVdtKD6uPbQzlonycPniqS9xgALZUEC9DHcKJtM=;
 b=Nu/WK2aDSu+sUC7vBIcCesmRQlCIK1y7OW4X8LBpWClQwXRvkNZdEezUmrnfrU5Cb38ud+PaX2DVFabWrcwQk9ZKHQbp/YlHlH4nMIOD6QleKdt3dyzmo0/W6WzBYwmLqC9tGGicM9pRsybC4/jdzJnLWZmrjZE2bZtuX+UBhEc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Mon, 23 Jan
 2023 15:00:58 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::fbe2:dc44:4197:f457]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::fbe2:dc44:4197:f457%8]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 15:00:51 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Wang, Chao-kai
 (Stylon)" <Stylon.Wang@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>,
 "Amini, Reza" <Reza.Amini@amd.com>, "Bernstein, Eric"
 <Eric.Bernstein@amd.com>, "Cyr, Aric" <Aric.Cyr@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Lei, Jun" <Jun.Lei@amd.com>,
 "Leung, Martin" <Martin.Leung@amd.com>, "Liu, Wenjing" <Wenjing.Liu@amd.com>, 
 "Pavic, Josip" <Josip.Pavic@amd.com>, "Sun, Yongqiang"
 <Yongqiang.Sun@amd.com>, "Othman, Ahmad" <Ahmad.Othman@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH IP-REVIEW 00/26] DC Patches Jan. 16, 2023
Thread-Topic: [PATCH IP-REVIEW 00/26] DC Patches Jan. 16, 2023
Thread-Index: AQHZKnODNJYrT0GJe0+MztrthLGvaq6sIdaw
Date: Mon, 23 Jan 2023 15:00:51 +0000
Message-ID: <DS0PR12MB6534493F2AE21CCB6181CAD89CC89@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230117125848.837122-1-HaoPing.Liu@amd.com>
In-Reply-To: <20230117125848.837122-1-HaoPing.Liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-23T15:00:48Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ad6cf770-c632-4a56-a14c-9faced005be9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-23T15:00:48Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: f3696aad-6784-40e9-a584-38a17d8455ce
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SN7PR12MB7809:EE_
x-ms-office365-filtering-correlation-id: bd600c3e-bc4f-4523-5896-08dafd529e8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VcJLD3GQEDJHM2DoniHKG8fFoK9k3D5b7S2pYm5zO2GUYpaGQ9yovn6mXJFmNFVFK/Y6gx4rhqJoqQqGzi8D+ghs7oSjNNbHH8p249Jb320oQVRr1W2zbKjwKz5GF8HDnEeEVFBuPzyQRhws21eeE0mAgv/ZECJ9ZvZqGqPoGTaMJ56BQTXmIcAVN3Sm2ix4qV/1lRUOu6TgzTO03/3eWo4HQRHWL9V8QqrUbTCdTbbBjLei3js1l9UeVAauFF/XeR85TKf5O3nG2EU7TD9/X0+t8NdhShCzEWg3j+eA37qJf/xdNUI9N5MWBy1LmJonG4LVT17WN3m2U3qV021CVos3SDKR0aXvlh/7g6ealp2B3R3Dr3AGyM/DTHJ3sEYdcvpCeYbQ1SNKN+2B4Qe7oKzBOHnBXZ4iEonCLJcYpk6Et4C3qhiT3wnSIVz6UE/Oh6sdd3KrGh/6nafz+9KVBvhLQQ/iF73B7r/MK+We0+tNH0Je8gTFCIDoRk4Mw5Jgrx9ftGuA39EXqlJzYYS5vUu50ZMVNH4oF0cXdAMUDGsC4TH/zskLZtU4ZI5LnQqPECjbllPHNcqC7GNTaPTLo6Imogcs7zBEtEh2J9EAiOaN2iy8PDKROeOo+4WD2JJpgWVqIbPtc1A2zCTkSWBWMEB5B6TbhzJ15VoCNm9LWwMsN+53cDIDF9KC70RCcYVCKtlNea3G5yPu8y7FxF5vjF8LPHZiy8XHebdo4KXaGU4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(7696005)(55016003)(30864003)(2906002)(8936002)(478600001)(52536014)(122000001)(5660300002)(83380400001)(38100700002)(41300700001)(38070700005)(316002)(66556008)(66946007)(64756008)(4326008)(66476007)(66446008)(921005)(6506007)(110136005)(86362001)(53546011)(33656002)(9686003)(186003)(26005)(8676002)(76116006)(1191002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D1SCYL0vdKeW6fqbAm1GH/QgeSi2RnN0AV1KnnF+oM1aJcQj0Psm8KNhVDCr?=
 =?us-ascii?Q?DQk3NZbkndpkCuDpWgMcGqNzqGUob4uQbcdgEEIz6/Is1Q5l84dOS/GvzhSy?=
 =?us-ascii?Q?49+BF0xx5DTcRucFei472/655TWUkR+a547gXVVgWCarfp3xAzDEImIJsGwh?=
 =?us-ascii?Q?tvDXOzaquSZbRcBFSZJTXlM7jXek7QCEE6drch1BMfE7cFpxfWtOivHIPEpj?=
 =?us-ascii?Q?kHVsJwI8wfvNQGaKm7P4kcMrdXvxOVyS4j2eCIIUTsh92PfdTLZItETkJ6GN?=
 =?us-ascii?Q?/PpG5cpQlNS8MH38JrL1qoDfanQui4VcCf9f2HJmZJEPmJEXZH4dJRw95XSM?=
 =?us-ascii?Q?mSrS448ARVor3x0BOBfGXycukGq0phgXNe7746qnaaC0cti77Pc887RqJt6M?=
 =?us-ascii?Q?QcB4/WnII6fEZYxJsTq9jOhCHGFwKaeIFdvO3rJuTLT78g9rmCYrCCvGyzxW?=
 =?us-ascii?Q?ypj3+Blb1UCDm+WZbQozSQaPjh3KqHzctWXAYVBtGed/KV9pmUd7AVc+iZj6?=
 =?us-ascii?Q?YMpl0D5wu//qiQwSu6Pd+GOpAsw3bWorA9oPfbOtRE/McdWMwm4OzNWiA82S?=
 =?us-ascii?Q?GDpE58+uxvVuwCrht9t5OmvLlN0i7p1qgr2C76gW6b9R3G5/Q1S8hOryCDNs?=
 =?us-ascii?Q?7SG3sL5X2+ZiLcRUUQOIG56BiglPzlOYZCs9Mee8B5ZZjX3Cj7ws8Km7asiX?=
 =?us-ascii?Q?g+xrKnRG6s4iUEmwVDR/jwAFL0azC1kn8wFEiDQv4HHGyIlc8IUeO19LVWAh?=
 =?us-ascii?Q?nU5P4qIKekqeewS/ZTFKtWLXUHQOaVnQvuTeNgDVpUuCKLL9OPCsbG0CqD7f?=
 =?us-ascii?Q?Cmkar9mEsQTJU6LgafOB85hiOg6hPaeaHZJ8lUentpnqJAeLvAq1Cu9Fx9Nw?=
 =?us-ascii?Q?//QfpV+uqdaRu4dOtsBlecGlS5yKp6a9uSTXDZIuuWCwmDQ0Oln5yS2YroZV?=
 =?us-ascii?Q?/E2xxcew/MwT5fvC8knM8+PuxK4yqNXiFf8f6fAh2LqC0JvvTOyMCV/3LqE7?=
 =?us-ascii?Q?sHlqDfvh8wfsnzQ0S/nkwu1r5Z196PWBlagDzq4ClN5QoBGKqIbJJqagyu8m?=
 =?us-ascii?Q?OLud8oY7wLpByJ5GPhr1j2eHydvCgL3k2H2iL5xWKounRzDfmBcKwTSM8vSq?=
 =?us-ascii?Q?et7aChuwPOB2zhs6yApoa/I9Um10Brbqhw1L1OtCnZG8Tb9EuHHQtMmEmcLL?=
 =?us-ascii?Q?0BryQAZGqoaTebQdOkMrr+K51/WIGXd60mRKt2Vgr8TYrFhroUTu8Tlsunfj?=
 =?us-ascii?Q?xplwdXkrE9jVWoiNMGA61RCAPYwpb0P7Uh1yp1nFrJ8WI7GnGDyHSc5N+A04?=
 =?us-ascii?Q?ssWauGLsujDzaG4zh6QV7aDjeUXp0z1xPZfKXlEcMuDl43GFfnQ0V1nzMCIW?=
 =?us-ascii?Q?kvAxO+NcafPUufHFoBHQ5+c9R8bLHK9vQDZDkpI+Y0F3Ly7ZHzMDXbVSPrfh?=
 =?us-ascii?Q?Mglg3J2rIIE7eW4eN4ujKAh7eMIu2+BFAl5Edho/1RSZxpWEQWAxKgfhcdA4?=
 =?us-ascii?Q?hVWl4R2/+DcDg+BWeFAC9AFX2g+BuKQNhs+C9kvbQZxjouMs1fqDl8z59E3K?=
 =?us-ascii?Q?zhtOJ+ovf0XMXDTiH8M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd600c3e-bc4f-4523-5896-08dafd529e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 15:00:51.5061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXEAU6QT0rnZrMI0aKyCPCFuVjZ0z5cAXXY6qCz51gUhY9eBFmOOBf+jugsDYZ6R6MVA3/aXNTPW7H7wBYK71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809
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
Cc: "Liu, HaoPing \(Alan\)" <HaoPing.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U=20
Lenovo Thinkpad T13s Gen4 with AMD Ryzen 5 6600U
Reference AMD RX6800
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [4500U, 5650U]) (1920x1200 60hz [6600U]) (2560x1600 120hz[=
6600U])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
HP Hook G2 with 1 and 2 4k60 Displays
=20
The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
Changing display configurations and settings
Benchmark testing
Feature testing (Freesync, etc.)
=20
Automated testing includes (but is not limited to):
Script testing (scripts to automate some of the manual checks)
IGT testing
=20
The patchset consists of the amd-staging-drm-next branch (Head commit - bc9=
269304ec8 drm/amd/display: 3.2.218) with new patches added on top of it. Th=
is branch is used for both Ubuntu and Chrome OS testing (ChromeOS on a bi-w=
eekly basis).
=20
=20
Tested on Ubuntu 22.04.1
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Alan Liu <HaoPing.Liu@amd.com>=20
Sent: January 17, 2023 7:58 AM
To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Amini, Reza <Reza.Amini@am=
d.com>; Bernstein, Eric <Eric.Bernstein@amd.com>; Cyr, Aric <Aric.Cyr@amd.c=
om>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Lei, Jun <Jun.Lei@=
amd.com>; Leung, Martin <Martin.Leung@amd.com>; Liu, Wenjing <Wenjing.Liu@a=
md.com>; Pavic, Josip <Josip.Pavic@amd.com>; Sun, Yongqiang <Yongqiang.Sun@=
amd.com>; Othman, Ahmad <Ahmad.Othman@amd.com>; Kotarac, Pavle <Pavle.Kotar=
ac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Zuo, Jerry <Je=
rry.Zuo@amd.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Wheeler, Daniel <=
Daniel.Wheeler@amd.com>
Cc: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>
Subject: [PATCH IP-REVIEW 00/26] DC Patches Jan. 16, 2023

Start from:
    c3e3354d0433
    drm/amd/display: force connector state when bpc changes during complian=
ce

Stopped at:
    2452279f91cb
    drm/amd/display: 3.2.220

Please, pay extra attention to the following patches:
- c71cc6871515a drm/amd/display: adjust MALL size available for DCN32 and D=
CN321
  Code that changed by this patch is not synchronized between dal and
  upstream. Please help check if the change is ok.

- ab109555e11c drm/amd/display: move eDP panel control logic to link_edp_pa=
nel_control
  There is a IP_CHECK_BODY label but I seem not to find the IP words in
  the code. Please help check it.


Extra notes:
- drm/amd/display: Refactor PWM Mechanism for MiniLED
- drm/amd/display: Fix ABM not enabled when S3 resume
  I drop these 2 patches because they depend on another patch (commit 75c0c=
3caa0 on amd-dal)
  which was dropped in previous promotion cycle (DC version 3.2.217).

- drm/amd/display: Avoid ASSERT for some message failures
  Drop this patch because such code change is already in upstream.
 =20

Below are all of the patches in this promotion:

Alvin Lee (4):
  drm/amd/display: Allow idle optimization after turning off all pipes
  drm/amd/display: Disable SubVP for PSR panels
  drm/amd/display: Use |=3D when assigning wm_optimized_required
  drm/amd/display: Set init freq for DCFCLK DS

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.150.0

Aric Cyr (2):
  drm/amd/display: 3.2.219
  drm/amd/display: 3.2.220

Aurabindo Pillai (3):
  drm/amd/display: Revert "ignore msa parameter only if freesync is
    enabled"
  drm/amd/display: set allow_freesync parameter in DM
  drm/amd/display: Fix timing not changning when freesync video is
    enabled

Dillon Varone (1):
  drm/amd/display: Disable MALL SS and messages for PSR supported
    configs

Ilya Bakoulin (1):
  drm/amd/display: Speed up DML fast_validate path

Jingwen Zhu (1):
  drm/amd/display: avoid disable otg when dig was disabled

Qingqing Zhuo (1):
  drm/amd/display: force connector state when bpc changes during
    compliance

Robin Chen (1):
  drm/amd/display: Pass DSC slice height to PSR FW

Roman Li (1):
  drm/amd/display: Set hvm_enabled flag for S/G mode

Saaem Rizvi (1):
  drm/amd/display: Correcting prefetch mode for fast validate

Samson Tam (1):
  drm/amd/display: adjust MALL size available for DCN32 and DCN321

Stylon Wang (2):
  drm/amd/display: Guard Freesync HDMI parsing with dc_lock
  drm/amd/display: Properly reuse completion structure

Sung Joon Kim (1):
  drm/amd/display: Enable AdaptiveSync in DC interface

Wenjing Liu (5):
  drm/amd/display: create accessories, hwss and protocols sub folders in
    link
  drm/amd/display: move eDP panel control logic to
    link_edp_panel_control
  drm/amd/display: move dp irq handler functions from dc_link_dp to
    link_dp_irq_handler
  drm/amd/display: move dp cts functions from dc_link_dp to link_dp_cts
  drm/amd/display: merge dc_link_dp into dc_link

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   90 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    2 -
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  124 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |    1 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |    2 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    3 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |    1 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |    1 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |    2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   28 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |    2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |    1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    7 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1175 ++++----  .../gpu/drm=
/amd/display/dc/core/dc_link_dp.c  | 2376 -----------------
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |    1 -
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   56 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   21 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   72 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    2 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   37 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |    2 -
 .../display/dc/dcn10/dcn10_stream_encoder.c   |    9 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |    8 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   20 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   26 +
 .../dc/dcn30/dcn30_dio_stream_encoder.h       |    4 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |    9 +-
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |   25 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |    6 +-
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |    4 +-
 .../dc/dcn314/dcn314_dio_stream_encoder.h     |    4 +
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |    2 -
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |    4 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |   19 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   63 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |    4 +
 .../display/dc/dcn32/dcn32_resource_helpers.c |   10 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |   10 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |    6 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   39 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   55 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |   47 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |    5 +-
 .../drm/amd/display/dc/dml/display_mode_lib.h |    1 +
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |    2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  117 -
 .../amd/display/dc/inc/hw/stream_encoder.h    |   17 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   17 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |   36 +-
 .../display/dc/link/accessories/link_dp_cts.c | 1055 ++++++++
 .../display/dc/link/accessories/link_dp_cts.h |   33 +
 .../dc/link/{ =3D> accessories}/link_dp_trace.c |    8 +-
 .../dc/link/{ =3D> accessories}/link_dp_trace.h |    5 -
 .../dc/link/{ =3D> hwss}/link_hwss_dio.c        |    1 -
 .../dc/link/{ =3D> hwss}/link_hwss_dio.h        |    1 +
 .../dc/link/{ =3D> hwss}/link_hwss_dpia.c       |    0
 .../dc/link/{ =3D> hwss}/link_hwss_dpia.h       |    0
 .../dc/link/{ =3D> hwss}/link_hwss_hpo_dp.c     |    1 -
 .../dc/link/{ =3D> hwss}/link_hwss_hpo_dp.h     |    1 +
 .../dc/link/{ =3D> protocols}/link_ddc.c        |    0
 .../dc/link/{ =3D> protocols}/link_ddc.h        |    0
 .../link/{ =3D> protocols}/link_dp_capability.c |   27 +-
 .../link/{ =3D> protocols}/link_dp_capability.h |   13 +
 .../dc/link/{ =3D> protocols}/link_dp_dpia.c    |    2 -
 .../dc/link/{ =3D> protocols}/link_dp_dpia.h    |    0
 .../dc/link/{ =3D> protocols}/link_dp_dpia_bw.c |    0
 .../dc/link/{ =3D> protocols}/link_dp_dpia_bw.h |    0
 .../dc/link/protocols/link_dp_irq_handler.c   |  401 +++
 .../link_dp_irq_handler.h}                    |   15 +-
 .../dc/link/{ =3D> protocols}/link_dp_phy.c     |   33 +-
 .../dc/link/{ =3D> protocols}/link_dp_phy.h     |    5 +
 .../link/{ =3D> protocols}/link_dp_training.c   |   14 +-
 .../link/{ =3D> protocols}/link_dp_training.h   |    3 +
 .../link_dp_training_128b_132b.c              |    1 -
 .../link_dp_training_128b_132b.h              |    0
 .../{ =3D> protocols}/link_dp_training_8b_10b.c |    1 -
 .../{ =3D> protocols}/link_dp_training_8b_10b.h |    0
 .../link_dp_training_auxless.c                |    1 -
 .../link_dp_training_auxless.h                |    0
 .../{ =3D> protocols}/link_dp_training_dpia.c   |    1 -
 .../{ =3D> protocols}/link_dp_training_dpia.h   |    0
 .../link_dp_training_fixed_vs_pe_retimer.c    |    1 -
 .../link_dp_training_fixed_vs_pe_retimer.h    |    0
 .../dc/link/{ =3D> protocols}/link_dpcd.c       |    0
 .../dc/link/{ =3D> protocols}/link_dpcd.h       |    0
 .../link/protocols/link_edp_panel_control.c   |  833 ++++++
 .../link/protocols/link_edp_panel_control.h   |   33 +
 .../dc/link/{ =3D> protocols}/link_hpd.c        |    0
 .../dc/link/{ =3D> protocols}/link_hpd.h        |    0
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   10 +-
 .../amd/display/modules/inc/mod_info_packet.h |   36 +
 .../display/modules/info_packet/info_packet.c |   55 +
 .../amd/display/modules/power/power_helpers.c |    8 +-
 .../amd/display/modules/power/power_helpers.h |    2 +-
 99 files changed, 3929 insertions(+), 3257 deletions(-)  delete mode 10064=
4 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp=
_cts.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp=
_cts.h
 rename drivers/gpu/drm/amd/display/dc/link/{ =3D> accessories}/link_dp_tra=
ce.c (95%)  rename drivers/gpu/drm/amd/display/dc/link/{ =3D> accessories}/=
link_dp_trace.h (91%)  rename drivers/gpu/drm/amd/display/dc/link/{ =3D> hw=
ss}/link_hwss_dio.c (99%)  rename drivers/gpu/drm/amd/display/dc/link/{ =3D=
> hwss}/link_hwss_dio.h (99%)  rename drivers/gpu/drm/amd/display/dc/link/{=
 =3D> hwss}/link_hwss_dpia.c (100%)  rename drivers/gpu/drm/amd/display/dc/=
link/{ =3D> hwss}/link_hwss_dpia.h (100%)  rename drivers/gpu/drm/amd/displ=
ay/dc/link/{ =3D> hwss}/link_hwss_hpo_dp.c (99%)  rename drivers/gpu/drm/am=
d/display/dc/link/{ =3D> hwss}/link_hwss_hpo_dp.h (98%)  rename drivers/gpu=
/drm/amd/display/dc/link/{ =3D> protocols}/link_ddc.c (100%)  rename driver=
s/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_ddc.h (100%)  rename d=
rivers/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_dp_capability.c (=
98%)  rename drivers/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_dp_=
capability.h (85%)  rename drivers/gpu/drm/amd/display/dc/link/{ =3D> proto=
cols}/link_dp_dpia.c (99%)  rename drivers/gpu/drm/amd/display/dc/link/{ =
=3D> protocols}/link_dp_dpia.h (100%)  rename drivers/gpu/drm/amd/display/d=
c/link/{ =3D> protocols}/link_dp_dpia_bw.c (100%)  rename drivers/gpu/drm/a=
md/display/dc/link/{ =3D> protocols}/link_dp_dpia_bw.h (100%)  create mode =
100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
 rename drivers/gpu/drm/amd/display/dc/link/{link_hwss_hpo_frl.h =3D> proto=
cols/link_dp_irq_handler.h} (80%)  rename drivers/gpu/drm/amd/display/dc/li=
nk/{ =3D> protocols}/link_dp_phy.c (98%)  rename drivers/gpu/drm/amd/displa=
y/dc/link/{ =3D> protocols}/link_dp_phy.h (93%)  rename drivers/gpu/drm/amd=
/display/dc/link/{ =3D> protocols}/link_dp_training.c (99%)  rename drivers=
/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_dp_training.h (98%)  re=
name drivers/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_dp_training=
_128b_132b.c (99%)  rename drivers/gpu/drm/amd/display/dc/link/{ =3D> proto=
cols}/link_dp_training_128b_132b.h (100%)  rename drivers/gpu/drm/amd/displ=
ay/dc/link/{ =3D> protocols}/link_dp_training_8b_10b.c (99%)  rename driver=
s/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_dp_training_8b_10b.h (=
100%)  rename drivers/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_dp=
_training_auxless.c (99%)  rename drivers/gpu/drm/amd/display/dc/link/{ =3D=
> protocols}/link_dp_training_auxless.h (100%)  rename drivers/gpu/drm/amd/=
display/dc/link/{ =3D> protocols}/link_dp_training_dpia.c (99%)  rename dri=
vers/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_dp_training_dpia.h =
(100%)  rename drivers/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_d=
p_training_fixed_vs_pe_retimer.c (99%)  rename drivers/gpu/drm/amd/display/=
dc/link/{ =3D> protocols}/link_dp_training_fixed_vs_pe_retimer.h (100%)  re=
name drivers/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_dpcd.c (100=
%)  rename drivers/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_dpcd.=
h (100%)  create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/=
link_edp_panel_control.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_=
panel_control.h
 rename drivers/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_hpd.c (1=
00%)  rename drivers/gpu/drm/amd/display/dc/link/{ =3D> protocols}/link_hpd=
.h (100%)

--
2.34.1
