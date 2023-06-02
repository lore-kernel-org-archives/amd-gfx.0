Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DE9C7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 17:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C7210E5DD;
	Fri,  2 Jun 2023 17:13:48 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E01210E209
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 17:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc16oZxfoQ/KChAO5uvaHKFCCyzEm+B4M0JqiI8UP/pz5Z/m3y6gRXjERrZDB7Rj6KCchVPfW91fUdviNQqjTEM7W0s+WF4h4etaJ3ditamBU8A3wegaWCREpE0yXLX41AuOnUER43BlYUnuMwpYr298cxT7iY0/K5Q8xvbGoCzP7uGLUFiQO0L2xt+aVm9mf6QW2vn+GrFO2qlFIXF0x8Dzw1pcNcod4gff7r+X2rruIy1BiPZ8tKZ/rj+GfW5PnQxdTJfQHOoebT3hbVTEjOrSXpoxqaLlMNitApw9FiROGyd6L/9BC0tCv9OWKXnbDRM+/xPwMxQChfPex4thgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJPuJvp2yaiyMixUqnoEiW8bTaoXS1jdNHFQXG9aBQo=;
 b=EE4iurm8GIKLwkTHvhZx52oZ8u0LtyaraxB6HRH0ZVsL3DKD0Dnne6yGYj+g2ows2S2OdIgD+OrAx6dbKv65ohm6kgdJhZGvxCAAv5JRkU1MX5NTqZrAw1ZQAJwctwHme+bDh35ylVvOO59VJ5DgfK8rHwSwy/9eink+FZuu6p13ufYsa5dfFfl/J8tMRUTj2E+D7bA834Cp6/zX7eQHXw+sbRjeYvv1ChlOU9fMIJ/nABvL2n6sQisO8yIF3/mdw7zoiLHNn7ycQ9fbCgWBtBsrMH5zdszONIsBKEKtm1DB0xQusLhuujUg0p9rI8lc2uPj+Efpy8/4IO69hw09bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJPuJvp2yaiyMixUqnoEiW8bTaoXS1jdNHFQXG9aBQo=;
 b=i0Wiutw4tkrMwoCYsAY3T1YoCPpNyIN69CeG9CvBoeIpRYvW2O3MKLzTv+JQtJKQ8uF31DeNG6Lde43B4VsNnBP6eZkv/TRWW5Aze1nPwpgqzBmyuRj8MDoFyF1LHQL94dG88/WAeXkGdYEs1U7eD2L4AznavGf8u6oZYhC6Bl8=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 17:13:44 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::eeaf:2747:9c3b:cabb]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::eeaf:2747:9c3b:cabb%3]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 17:13:43 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, "Zhuo, Qingqing
 (Lillian)" <Qingqing.Zhuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chalmers, Wesley" <Wesley.Chalmers@amd.com>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
Thread-Topic: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
Thread-Index: AQHZbulXfd4e8U1ZekaELAq8to+gF69R7OCAgAChUyWAAAglsYABEDIAgAB+wQCAAKsfAIAgSsEAgAE6T4CAAAfJ74AAB1oAgAGgZlo=
Date: Fri, 2 Jun 2023 17:13:43 +0000
Message-ID: <CH0PR12MB52844D522925ED7FFFE294228B4EA@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20230414155330.5215-11-Qingqing.Zhuo@amd.com>
 <9deeb132-a317-7419-e9da-cbc0a379c0eb@daenzer.net>
 <CH0PR12MB5284513F3548D749845BD7B48B769@CH0PR12MB5284.namprd12.prod.outlook.com>
 <CH0PR12MB5284BDF5F23009597E1503E38B769@CH0PR12MB5284.namprd12.prod.outlook.com>
 <714c875f-21f1-7e29-fb39-4a1f97eb712f@daenzer.net>
 <14582e0e-58cb-02df-50ae-1af22d194b29@amd.com>
 <ea2f979e-730a-4bea-4092-3798f718ce0d@daenzer.net>
 <8e0d6d87-0f73-1ae0-bce8-8b6231e6c068@amd.com>
 <aca2a2e5-76c3-4df9-336e-2d9060333389@daenzer.net>
 <CH0PR12MB528437770699502A9A26F3A38B499@CH0PR12MB5284.namprd12.prod.outlook.com>
 <e152ce5a-d269-549c-c888-8a21734c6515@daenzer.net>
In-Reply-To: <e152ce5a-d269-549c-c888-8a21734c6515@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-02T17:13:42.796Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|CH0PR12MB5137:EE_
x-ms-office365-filtering-correlation-id: 83454e69-a030-460c-e629-08db638cb810
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8NA4IiWrePUGes3pYK2kqYDWBditwzwDxT9QBxn3oLzifYs17O2wU8A775vmCMaDxZf5030gZB8yUkE3Gnp3uSu88+zAiqEqOlfWxBBbiBge2tF9V6tYf6kuceXXocHb26Dl1cdf1Sy/yfuGV6IfGkrma6DhLFR+J62xmcLnMnCdjwTYgI6+mdKVTj6Kja6JqEqgsUyGTDd0g2nTbZRzHTIBmPgIEjKd4zApepdMEWxbpA5u2MDF9ofZv6FPirz3N4qVomCsYxFMuIkUg0TMB2Dsdie39AkKIxspesZmkIQ/wLqkKcrNZeCou2XuMEJXvLjsLqwItFc2/oH+8u1kHFyckHiBC5zQHlQdAAhtbr1O0o7sJH8Nktndgoguanxpb9POr8R8QAkBqXCltr82hOOtUHN9SCu26ezu7JTdhYwQ7IcryjiZZm366VpaqqexmYzJcB+hUaM2nv46KW5Fk+GQl/tOAc3Y8hslUfBgoCSDFDYG8MxlTFQ8lT8S+65hxPJ3pAfNILfTElKa6tUbiyxAFGfbMFfRaIIFcjgYuSH2EGe+9JOWMZfQ28hAQIZGSZHzVBR5vLsQozV6mQ0L+UmQ4fjOBMvzT0xKzZdkqI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(166002)(99936003)(122000001)(38100700002)(19627405001)(8676002)(110136005)(54906003)(86362001)(66556008)(6636002)(91956017)(66476007)(76116006)(66946007)(66446008)(64756008)(4326008)(38070700005)(33656002)(55016003)(966005)(71200400001)(7696005)(478600001)(53546011)(26005)(186003)(9686003)(6506007)(316002)(5660300002)(8936002)(41300700001)(2906002)(52536014)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XTpQp+sDPe+XEX3ukTWH08Cw1pBjFwsydb8EdlDnldmK+W3RktehpilMYS?=
 =?iso-8859-1?Q?vkoNTUBg8wWTaDEiJBXShlg9DsA5EgYtHe2J5C/qApfoLqDwBIVF/MI1bq?=
 =?iso-8859-1?Q?JLsS3xRFAN/+cRslogP7Myh59RnlZEo1qlr5CW8ZuFi4PAzJy7b8zUzlxb?=
 =?iso-8859-1?Q?yIBEr6DfdC71954RK3FrVMBdl9VrHrJpWyrFPjTmKs71CAL78Q3j+jP5Rv?=
 =?iso-8859-1?Q?h+y21VE0vGchyCEsNTse1MD6CWtNboohx20dw1tLgzsPmf87GbUjiyquJ9?=
 =?iso-8859-1?Q?IhylqeJ1+uyfnxaKLJYPHa67aUnPgDnO3knXaoKqZxaHgZa/X1qjdfBuD9?=
 =?iso-8859-1?Q?aLMS5sZXPLubFek+8B6mXlyaA4y0LU00ZeCJK6E/INw3CTIn3gtgDVlxAJ?=
 =?iso-8859-1?Q?j5LPZDzj+uLGny8lmIjOLuYNQTSdn1BYkKP295CyPwJ9bQ7Xyf0yFY5cL2?=
 =?iso-8859-1?Q?hFfDHlcK5TmE7s7X8JPOduFFRnw5Thh2PfM5q9Lo3SELBzyVdg6sFOvmxq?=
 =?iso-8859-1?Q?uYHxbuHvZdaHyo+xmUQQxgGvrIKHva9tmTZD/Kea2g3zyP4mfPhXnvBisT?=
 =?iso-8859-1?Q?IR6z4dHpApdgGvjmJFq/6ekLDU5RZg9co217svg9AM1Yz1tuyylQLFvo1q?=
 =?iso-8859-1?Q?YDVDFcvGSSW9qcmOwq3yq0UAPjhIFWudl3vXYTgh0KTWQC7wqHUsxK9jNp?=
 =?iso-8859-1?Q?z25OALfjLSBamxJlhbOrhhsC9A4LAPSXtrUIPTFCmeUD4qjWN6A5VilX0m?=
 =?iso-8859-1?Q?mu5frd2I1Aw2de3Ujx0QWkoMNr9/Qeh4xdxdpNIiorap1Lx0zafpLmKpjy?=
 =?iso-8859-1?Q?v6gbzObJSuFqXEoIlu6uFLoo9MqxrCAXCwjMC/Aj1oJXgD+kNOJUVoiwr8?=
 =?iso-8859-1?Q?vFCm8qWwyZjhHNh41wZXRzxVBV3BlkZLVp0OX8QuS0r5WhT1PIor+7DRC8?=
 =?iso-8859-1?Q?JCABialHxRKHR+BOxGp+1APpjZOflorFHUivx+NOFn55s7wzxtrzPRRJER?=
 =?iso-8859-1?Q?H3+fGkdNNbXcNT9OSWsrYPPrAKwp0VY7SqgdRK4zHNKFaCHI5FIwbhKGxj?=
 =?iso-8859-1?Q?fiVVsH71QePDPYRfdSRhz5m2sG+zYJHqQ8a4ct34rZPs56d362qhccwR4T?=
 =?iso-8859-1?Q?s851febdfp5HFU4iMkS/U0cUM02jlQ8m/p0/Q+wR5+BeOK485cy3Q0N2na?=
 =?iso-8859-1?Q?sFd7sdya+Mt+crNHRDbsjBGkdunTxkTkO3iANH3nsNNTqZcO9IG4yit/ln?=
 =?iso-8859-1?Q?J/NhDWwyewdxVeqDn3pLgdKZXx8j1vqiAW5boS9UjbyQZRuR1C6JIlZa9u?=
 =?iso-8859-1?Q?/uFFGRd6NP4hRwe5Xc/rL/QqQd4BomwUCUZ0nvJRfg3BO5OTF5UG7TlXb/?=
 =?iso-8859-1?Q?tOtcSZmoIkuqUbdsCXDE5bL8hWLmRQ8rvGjdzwodansmw+BRyL0rwMUgYq?=
 =?iso-8859-1?Q?1NvxhCf8bR/diuqJzfoLf1ujxNIoSVnL14jYbcD+cJuGugCteW6JFieDiM?=
 =?iso-8859-1?Q?PO/gJh9/5vPQo+VTo2iorlDc/wAlfqQqY5x2BSfOUARgSXq9fB2NwOT5Gy?=
 =?iso-8859-1?Q?aJ25NV1/PmNe0Iugodjl6liT1fa0LURrCcW3HrZpp3ilbess9TLVRIOPxq?=
 =?iso-8859-1?Q?llb+qNwmqacPA=3D?=
Content-Type: multipart/mixed;
 boundary="_004_CH0PR12MB52844D522925ED7FFFE294228B4EACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83454e69-a030-460c-e629-08db638cb810
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 17:13:43.7191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q61JXNQAAs10uOxGg22c18DirfjKDPt84Y68lUP+bN9NNOkhergd0tdvq/unD0ph03cFxkNGsdT7WgxINaoqUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez, 
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_CH0PR12MB52844D522925ED7FFFE294228B4EACH0PR12MB5284namp_
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB52844D522925ED7FFFE294228B4EACH0PR12MB5284namp_"

--_000_CH0PR12MB52844D522925ED7FFFE294228B4EACH0PR12MB5284namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Michel,

AMD driver package also contains various firmware that could make a differe=
nce. Even though I do not expect any major deltas for Navi21 at this point,=
 its an extra variable in the equation that could potentially create a diff=
erent behaviour.

We tried upstream stack (without any AMD packaged driver) on Ubuntu 22.04 o=
n the same display that you reported the issue on, but couldn't reproduce t=
he hang you're seeing (using a different steam game that uses the same fram=
ework). Maybe your custom gnome build could have affected the results too. =
Could you provide instructions for setting up your userspace environment ?

Other than the game, is there any other workload that could trigger the han=
g? We have a set of IGT tests you could try:

Repo: https://gitlab.freedesktop.org/drm/igt-gpu-tools

Build & install:

meson build

# Compile IGT
ninja -C build

# Download Piglit
./scripts/run-tests.sh -d

Run tests
./scripts/run-tests.sh -s -T /path/to/navi21_postsubmission.testlist


--

Regards,
Jay
________________________________
From: Michel D=E4nzer <michel@daenzer.net>
Sent: Thursday, June 1, 2023 11:53 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Zhuo, Qingqing (Lillian) =
<Qingqing.Zhuo@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freed=
esktop.org>; Chalmers, Wesley <Wesley.Chalmers@amd.com>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, =
Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Sol=
omon <Solomon.Chiu@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wentland, Harr=
y <Harry.Wentland@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>;=
 Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit

On 6/1/23 17:45, Pillai, Aurabindo wrote:
>
> I see, thanks for the info. I'll try repro'ing it locally.

Thanks. Note that I'm using a GNOME Wayland session, which doesn't support =
VRR upstream yet (I'm building mutter with https://gitlab.gnome.org/GNOME/m=
utter/-/merge_requests/1154 for that). I don't know if it's reproducible wi=
th Xorg.


> But do you have the open userspace stack from AMD's packaged driver insta=
lled ? If not, could you please try downloading from https://www.amd.com/en=
/support/linux-drivers <https://www.amd.com/en/support/linux-drivers> and i=
nstall just the open components?

I don't, and I'd rather not unless it's absolutely necessary. I'm not sure =
how the user-space drivers could affect this.

I'll happily test further patches though.


--
Earthling Michel D=E4nzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


--_000_CH0PR12MB52844D522925ED7FFFE294228B4EACH0PR12MB5284namp_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Michel,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
AMD driver package also contains various firmware that could make a differe=
nce. Even though I do not expect any major deltas for Navi21 at this point,=
 its an extra variable in the equation that could potentially create a diff=
erent behaviour.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
We tried upstream stack (without any AMD packaged driver) on Ubuntu 22.04 o=
n the same display that you reported the issue on, but couldn't reproduce t=
he hang you're seeing (using a different steam game that uses the same fram=
ework). Maybe your custom gnome
 build could have affected the results too. Could you provide instructions =
for setting up your userspace environment ?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Other than the game, is there any other workload that could trigger the han=
g? We have a set of IGT tests you could try:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
Repo: <a href=3D"https://gitlab.freedesktop.org/drm/igt-gpu-tools" id=3D"LP=
lnk860634">
https://gitlab.freedesktop.org/drm/igt-gpu-tools</a><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Build &amp; install:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
</div>
<div class=3D"elementToProof"><span class=3D"line number21 index20 alt2" da=
ta-bidi-marker=3D"true"><code class=3D"bash plain ContentPasted1">meson bui=
ld
</code></span></div>
<div class=3D"elementToProof">
<div class=3D"line number23 index22 alt2 ContentPasted1" data-bidi-marker=
=3D"true">&nbsp;</div>
<div class=3D"line number24 index23 alt1" data-bidi-marker=3D"true"><code c=
lass=3D"bash comments ContentPasted1"># Compile IGT</code></div>
<div class=3D"line number25 index24 alt2" data-bidi-marker=3D"true"><code c=
lass=3D"bash plain ContentPasted1">ninja -C build</code></div>
<div class=3D"line number26 index25 alt1 ContentPasted1" data-bidi-marker=
=3D"true">&nbsp;</div>
<div class=3D"line number27 index26 alt2" data-bidi-marker=3D"true"><code c=
lass=3D"bash comments ContentPasted1"># Download Piglit</code></div>
</div>
<div class=3D"elementToProof"><span class=3D"line number28 index27 alt1" da=
ta-bidi-marker=3D"true"><code class=3D"bash plain ContentPasted1">.</code><=
code class=3D"bash plain ContentPasted1">/scripts/run-tests</code><code cla=
ss=3D"bash plain ContentPasted1">.sh -d</code></span></div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<span class=3D"line number28 index27 alt1" data-bidi-marker=3D"true"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<span class=3D"line number28 index27 alt1" data-bidi-marker=3D"true">Run te=
sts</span></div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<span class=3D"line number28 index27 alt1" data-bidi-marker=3D"true"><span =
class=3D"line number9 index8 alt2" data-bidi-marker=3D"true"><code class=3D=
"bash plain ContentPasted2">.</code><code class=3D"bash plain ContentPasted=
2">/scripts/run-tests</code><code class=3D"bash plain ContentPasted2">.sh
 -s -T /path/to/navi21_postsubmission.testlist </code></span><br>
</span></div>
<div class=3D"elementToProof">
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
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
ichel@daenzer.net&gt;<br>
<b>Sent:</b> Thursday, June 1, 2023 11:53 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqi=
ng (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;; amd-gfx@lists.freedesktop.org &=
lt;amd-gfx@lists.freedesktop.org&gt;; Chalmers, Wesley &lt;Wesley.Chalmers@=
amd.com&gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Li, Sun pen=
g (Leo) &lt;Sunpeng.Li@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakh=
a@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roma=
n &lt;Roman.Li@amd.com&gt;; Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;;
 Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@a=
md.com&gt;; Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Kotarac, =
Pavle &lt;Pavle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe c=
ommit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 6/1/23 17:45, Pillai, Aurabindo wrote:<br>
&gt; <br>
&gt; I see, thanks for the info. I'll try repro'ing it locally.<br>
<br>
Thanks. Note that I'm using a GNOME Wayland session, which doesn't support =
VRR upstream yet (I'm building mutter with
<a href=3D"https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1154">htt=
ps://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1154</a> for that). I d=
on't know if it's reproducible with Xorg.<br>
<br>
<br>
&gt; But do you have the open userspace stack from AMD's packaged driver in=
stalled ? If not, could you please try downloading from
<a href=3D"https://www.amd.com/en/support/linux-drivers">https://www.amd.co=
m/en/support/linux-drivers</a> &lt;<a href=3D"https://www.amd.com/en/suppor=
t/linux-drivers">https://www.amd.com/en/support/linux-drivers</a>&gt; and i=
nstall just the open components?<br>
<br>
I don't, and I'd rather not unless it's absolutely necessary. I'm not sure =
how the user-space drivers could affect this.<br>
<br>
I'll happily test further patches though.<br>
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

--_000_CH0PR12MB52844D522925ED7FFFE294228B4EACH0PR12MB5284namp_--

--_004_CH0PR12MB52844D522925ED7FFFE294228B4EACH0PR12MB5284namp_
Content-Type: application/octet-stream; name="navi21_postsubmission.testlist"
Content-Description: navi21_postsubmission.testlist
Content-Disposition: attachment; filename="navi21_postsubmission.testlist";
	size=15280; creation-date="Fri, 02 Jun 2023 17:12:11 GMT";
	modification-date="Fri, 02 Jun 2023 17:13:14 GMT"
Content-Transfer-Encoding: base64

IyB0ZXN0cyB0byBiZSBydW4gYXQgdGhlIGJlZ2lubmluZwojIE1PREVTIC0gVGVzdHMgbW9kZSBz
ZXR0aW5ncwppZ3RAa21zX3NldG1vZGVAYmFzaWNAcGlwZS1bYXxiXSoKCiMgdGVzdHMgdGhhdCBh
cmUgbm90IGRlcGVuZGVudCBvbiBvcmRlcmluZwojIFNJTkdMRS1ESVNQTEFZIC0gTGlnaHQtdXAs
IGhvdHBsdWcsIGJvb3R1cCwgYW5kIGdlbmVyYWwgZnVuY3Rpb25hbGl0eSB0ZXN0cyBmb3Igc2lu
Z2xlIG5vbiB0aWxlZCBkaXNwbGF5CmlndEBhbWRncHUvYW1kX2hvdHBsdWdAYmFzaWMKIyBBVE9N
SUMtTU9ERVNFVFRJTkcgLSBBdG9taWMgbW9kZXNldHRpbmcgdGVzdHMKaWd0QGttc19hdG9taWNA
cGxhbmUtb3ZlcmxheS1sZWdhY3kKaWd0QGttc19hdG9taWNAcGxhbmUtcHJpbWFyeS1sZWdhY3kK
aWd0QGttc19hdG9taWNAcGxhbmUtY3Vyc29yLWxlZ2FjeQppZ3RAa21zX2F0b21pY0BwbGFuZS1p
bnZhbGlkLXBhcmFtcwppZ3RAa21zX2F0b21pY0BjcnRjLWludmFsaWQtcGFyYW1zCmlndEBrbXNf
YXRvbWljQGF0b21pYy1pbnZhbGlkLXBhcmFtcwppZ3RAa21zX2F0b21pY0BwbGFuZS1pbnZhbGlk
LXBhcmFtcy1mZW5jZQppZ3RAa21zX2F0b21pY0BjcnRjLWludmFsaWQtcGFyYW1zLWZlbmNlCmln
dEBrbXNfYXRvbWljQHRlc3Qtb25seQppZ3RAa21zX2F0b21pY0BwbGFuZS1pbW11dGFibGUtenBv
cwppZ3RAa21zX2ZsaXBAYmFzaWMtcGxhaW4tZmxpcEBbYXxjXSoKaWd0QGttc19mbGlwQGZsaXAt
dnMtZHBtcy1vZmYtdnMtbW9kZXNldEBbYXxjXSoKaWd0QGttc19mbGlwX2V2ZW50X2xlYWtAYmFz
aWNAcGlwZS1bYXxiXSoKaWd0QGttc19hc3luY19mbGlwc0Bhc3luYy1mbGlwLXdpdGgtcGFnZS1m
bGlwLWV2ZW50c0BwaXBlLVthfGNdKgppZ3RAa21zX2FzeW5jX2ZsaXBzQGFsdGVybmF0ZS1zeW5j
LWFzeW5jLWZsaXBAcGlwZS1bYXxjXSoKaWd0QGttc19hc3luY19mbGlwc0B0ZXN0LXRpbWUtc3Rh
bXBAcGlwZS1bYXxjXSoKaWd0QGttc19hc3luY19mbGlwc0B0ZXN0LWN1cnNvckBwaXBlLVthfGNd
KgppZ3RAa21zX2FzeW5jX2ZsaXBzQGludmFsaWQtYXN5bmMtZmxpcAppZ3RAa21zX2FzeW5jX2Zs
aXBzQGNyY0BwaXBlLVthfGNdKgojIENPTE9SIC0gQ29sb3IgQWRqdXN0bWVudHMKaWd0QGFtZGdw
dS9hbWRfY29sb3JAY3J0Yy1saW5lYXItZGVnYW1tYQppZ3RAYW1kZ3B1L2FtZF9jb2xvckBjcnRj
LWxpbmVhci1yZWdhbW1hCmlndEBhbWRncHUvYW1kX2NvbG9yQGNydGMtbHV0LWFjY3VyYWN5Cmln
dEBrbXNfY29sb3JAY3RtLXJlZC10by1ibHVlQHBpcGUtW2F8Yl0qCmlndEBrbXNfY29sb3JAY3Rt
LWdyZWVuLXRvLXJlZEBwaXBlLVthfGJdKgppZ3RAa21zX2NvbG9yQGN0bS1ibHVlLXRvLXJlZEBw
aXBlLVthfGJdKgppZ3RAa21zX2NvbG9yQGN0bS1tYXhAcGlwZS1bYXxiXSoKaWd0QGttc19jb2xv
ckBjdG0tbmVnYXRpdmVAcGlwZS1bYXxiXSoKaWd0QGttc19jb2xvckBjdG0tMC0yNUBwaXBlLVth
fGJdKgppZ3RAa21zX2NvbG9yQGN0bS0wLTUwQHBpcGUtW2F8Yl0qCmlndEBrbXNfY29sb3JAY3Rt
LTAtNzVAcGlwZS1bYXxiXSoKaWd0QGttc19jb2xvckBnYW1tYUBwaXBlLVthfGJdKgppZ3RAa21z
X2NvbG9yQGRlZ2FtbWFAcGlwZS1bYXxiXSoKaWd0QGttc19jb2xvckBsZWdhY3ktZ2FtbWFAcGlw
ZS1bYXxiXSoKaWd0QGttc19jb2xvckBsZWdhY3ktZ2FtbWEtcmVzZXRAcGlwZS1bYXxiXSoKaWd0
QGttc19jb2xvckBpbnZhbGlkLWdhbW1hLWx1dC1zaXplc0BwaXBlLVthfGJdKgppZ3RAa21zX2Nv
bG9yQGludmFsaWQtZGVnYW1tYS1sdXQtc2l6ZXNAcGlwZS1bYXxiXSoKaWd0QGttc19jb2xvckBp
bnZhbGlkLWN0bS1tYXRyaXgtc2l6ZXNAcGlwZS1bYXxiXSoKaWd0QGttc19wbGFuZV9hbHBoYV9i
bGVuZEBhbHBoYS1iYXNpY0BwaXBlLVthfGJdKgppZ3RAa21zX3BsYW5lX2FscGhhX2JsZW5kQGFs
cGhhLTdlZmNAcGlwZS1bYXxiXSoKaWd0QGttc19wbGFuZV9hbHBoYV9ibGVuZEBjb3ZlcmFnZS03
ZWZjQHBpcGUtW2F8Yl0qCmlndEBrbXNfcGxhbmVfYWxwaGFfYmxlbmRAY292ZXJhZ2UtdnMtcHJl
bXVsdC12cy1jb25zdGFudEBwaXBlLVthfGJdKgppZ3RAa21zX3BsYW5lX2FscGhhX2JsZW5kQGFs
cGhhLXRyYW5zcGFyZW50LWZiQHBpcGUtW2F8Yl0qCmlndEBrbXNfcGxhbmVfYWxwaGFfYmxlbmRA
YWxwaGEtb3BhcXVlLWZiQHBpcGUtW2F8Yl0qCmlndEBrbXNfcGxhbmVfYWxwaGFfYmxlbmRAY29u
c3RhbnQtYWxwaGEtbWluQHBpcGUtW2F8Yl0qCmlndEBrbXNfcGxhbmVfYWxwaGFfYmxlbmRAY29u
c3RhbnQtYWxwaGEtbWlkQHBpcGUtW2F8Yl0qCmlndEBrbXNfcGxhbmVfYWxwaGFfYmxlbmRAY29u
c3RhbnQtYWxwaGEtbWF4QHBpcGUtW2F8Yl0qCiMgRlJFRVNZTkMgLSBGcmVlc3luYwppZ3RAYW1k
Z3B1L2FtZF92cnJfcmFuZ2VAZnJlZXN5bmMtcGFyc2luZy1kcAppZ3RAYW1kZ3B1L2FtZF92cnJf
cmFuZ2VAZnJlZXN5bmMtcmFuZ2UtZHAKaWd0QGttc192cnJAZmxpcC1iYXNpY0BwaXBlLWEqCmln
dEBrbXNfc2V0bW9kZUBiYXNpYy1jbG9uZS1zaW5nbGUtY3J0YwppZ3RAa21zX3NldG1vZGVAaW52
YWxpZC1jbG9uZS1zaW5nbGUtY3J0YwppZ3RAa21zX3NldG1vZGVAaW52YWxpZC1jbG9uZS1leGNs
dXNpdmUtY3J0YwppZ3RAa21zX3NldG1vZGVAY2xvbmUtZXhjbHVzaXZlLWNydGMKaWd0QGttc19z
ZXRtb2RlQGludmFsaWQtY2xvbmUtc2luZ2xlLWNydGMtc3RlYWxpbmcKaWd0QGFtZGdwdS9hbWRf
bW9kZV9zd2l0Y2hAbW9kZS1zd2l0Y2gtZmlyc3QtbGFzdC1waXBlLTAKaWd0QGttc19wYW5lbF9m
aXR0aW5nQGxlZ2FjeUBwaXBlLVthfGJdKgppZ3RAa21zX3BhbmVsX2ZpdHRpbmdAYXRvbWljLWZh
c3RzZXQKIyBQTEFORSAtIERSTSBwbGFuZS1sZXZlbCB0ZXN0cwppZ3RAa21zX3Byb3BlcnRpZXNA
cGxhbmUtcHJvcGVydGllcy1sZWdhY3kKaWd0QGttc19wcm9wZXJ0aWVzQHBsYW5lLXByb3BlcnRp
ZXMtYXRvbWljCmlndEBrbXNfcHJvcGVydGllc0BjcnRjLXByb3BlcnRpZXMtbGVnYWN5CmlndEBr
bXNfcHJvcGVydGllc0BjcnRjLXByb3BlcnRpZXMtYXRvbWljCmlndEBrbXNfcHJvcGVydGllc0Bj
b25uZWN0b3ItcHJvcGVydGllcy1sZWdhY3kKaWd0QGttc19wcm9wZXJ0aWVzQGNvbm5lY3Rvci1w
cm9wZXJ0aWVzLWF0b21pYwppZ3RAa21zX3Byb3BlcnRpZXNAaW52YWxpZC1wcm9wZXJ0aWVzLWxl
Z2FjeQppZ3RAa21zX3Byb3BlcnRpZXNAaW52YWxpZC1wcm9wZXJ0aWVzLWF0b21pYwppZ3RAa21z
X3Byb3BlcnRpZXNAZ2V0X3Byb3BlcnRpZXMtc2FuaXR5LWF0b21pYwppZ3RAa21zX3Byb3BlcnRp
ZXNAZ2V0X3Byb3BlcnRpZXMtc2FuaXR5LW5vbi1hdG9taWMKaWd0QGttc19wbGFuZUBwbGFuZS1w
YW5uaW5nLXRvcC1sZWZ0QHBpcGUtW2F8Yl0qCmlndEBrbXNfcGxhbmVAcGxhbmUtcGFubmluZy1i
b3R0b20tcmlnaHRAcGlwZS1bYXxiXSoKaWd0QGttc19wbGFuZUBwbGFuZS1wb3NpdGlvbi1jb3Zl
cmVkQHBpcGUtW2F8Yl0qCmlndEBrbXNfcGxhbmVAcGxhbmUtcG9zaXRpb24taG9sZUBwaXBlLVth
fGJdKgppZ3RAa21zX2N1cnNvcl9sZWdhY3lAZmxpcC12cy1jdXJzb3ItbGVnYWN5CmlndEBrbXNf
Y3Vyc29yX2xlZ2FjeUBmbGlwLXZzLWN1cnNvci12YXJ5aW5nLXNpemUKaWd0QGttc19jdXJzb3Jf
bGVnYWN5QGZsaXAtdnMtY3Vyc29yLXRvZ2dsZQppZ3RAa21zX2N1cnNvcl9sZWdhY3lAZmxpcC12
cy1jdXJzb3ItYXRvbWljCmlndEBrbXNfY3Vyc29yX2xlZ2FjeUBmbGlwLXZzLWN1cnNvci1hdG9t
aWMtdHJhbnNpdGlvbnMKaWd0QGttc19jdXJzb3JfbGVnYWN5QGZsaXAtdnMtY3Vyc29yLWF0b21p
Yy10cmFuc2l0aW9ucy12YXJ5aW5nLXNpemUKaWd0QGttc19jdXJzb3JfbGVnYWN5QGN1cnNvci12
cy1mbGlwLWxlZ2FjeQppZ3RAa21zX2N1cnNvcl9sZWdhY3lAY3Vyc29yLXZzLWZsaXAtdmFyeWlu
Zy1zaXplCmlndEBrbXNfY3Vyc29yX2xlZ2FjeUBjdXJzb3ItdnMtZmxpcC10b2dnbGUKaWd0QGtt
c19jdXJzb3JfbGVnYWN5QGN1cnNvci12cy1mbGlwLWF0b21pYwppZ3RAa21zX2N1cnNvcl9sZWdh
Y3lAY3Vyc29yLXZzLWZsaXAtYXRvbWljLXRyYW5zaXRpb25zCmlndEBrbXNfY3Vyc29yX2xlZ2Fj
eUBjdXJzb3ItdnMtZmxpcC1hdG9taWMtdHJhbnNpdGlvbnMtdmFyeWluZy1zaXplCmlndEBrbXNf
cGxhbmVfbXVsdGlwbGVAdGlsaW5nLW5vbmVAcGlwZS1bYXxiXSoKaWd0QGttc19wbGFuZV9tdWx0
aXBsZUB0aWxpbmcteAppZ3RAa21zX3BsYW5lX211bHRpcGxlQHRpbGluZy15CmlndEBrbXNfcGxh
bmVfbXVsdGlwbGVAdGlsaW5nLXlmCmlndEBrbXNfcGxhbmVfbXVsdGlwbGVAdGlsaW5nLTQKaWd0
QGttc19wbGFuZV9jdXJzb3JAb3ZlcmxheUBwaXBlLVthfGJdKnNpemUtNjQKaWd0QGttc19wbGFu
ZV9jdXJzb3JAb3ZlcmxheUBwaXBlLVthfGJdKnNpemUtMTI4CmlndEBrbXNfcGxhbmVfY3Vyc29y
QG92ZXJsYXlAcGlwZS1bYXxiXSpzaXplLTI1NgppZ3RAa21zX3BsYW5lX2N1cnNvckBwcmltYXJ5
QHBpcGUtW2F8Yl0qc2l6ZS02NAppZ3RAa21zX3BsYW5lX2N1cnNvckBwcmltYXJ5QHBpcGUtW2F8
Yl0qc2l6ZS0xMjgKaWd0QGttc19wbGFuZV9jdXJzb3JAcHJpbWFyeUBwaXBlLVthfGJdKnNpemUt
MjU2CmlndEBrbXNfcGxhbmVfY3Vyc29yQHZpZXdwb3J0QHBpcGUtW2F8Yl0qc2l6ZS02NAppZ3RA
a21zX3BsYW5lX2N1cnNvckB2aWV3cG9ydEBwaXBlLVthfGJdKnNpemUtMTI4CmlndEBrbXNfcGxh
bmVfY3Vyc29yQHZpZXdwb3J0QHBpcGUtW2F8Yl0qc2l6ZS0yNTYKaWd0QGttc191bml2ZXJzYWxf
cGxhbmVAdW5pdmVyc2FsLXBsYW5lLXBpcGUtYS1mdW5jdGlvbmFsCmlndEBrbXNfdW5pdmVyc2Fs
X3BsYW5lQHVuaXZlcnNhbC1wbGFuZS1waXBlLWEtc2FuaXR5CmlndEBrbXNfdW5pdmVyc2FsX3Bs
YW5lQGRpc2FibGUtcHJpbWFyeS12cy1mbGlwLXBpcGUtYQppZ3RAa21zX3VuaXZlcnNhbF9wbGFu
ZUBjdXJzb3ItZmItbGVhay1waXBlLWEKaWd0QGttc191bml2ZXJzYWxfcGxhbmVAdW5pdmVyc2Fs
LXBsYW5lLXBhZ2VmbGlwLXdpbmRvd2VkLXBpcGUtYQppZ3RAa21zX3VuaXZlcnNhbF9wbGFuZUB1
bml2ZXJzYWwtcGxhbmUtcGlwZS1iLWZ1bmN0aW9uYWwKaWd0QGttc191bml2ZXJzYWxfcGxhbmVA
dW5pdmVyc2FsLXBsYW5lLXBpcGUtYi1zYW5pdHkKaWd0QGttc191bml2ZXJzYWxfcGxhbmVAZGlz
YWJsZS1wcmltYXJ5LXZzLWZsaXAtcGlwZS1iCmlndEBrbXNfdW5pdmVyc2FsX3BsYW5lQGN1cnNv
ci1mYi1sZWFrLXBpcGUtYgppZ3RAa21zX3VuaXZlcnNhbF9wbGFuZUB1bml2ZXJzYWwtcGxhbmUt
cGFnZWZsaXAtd2luZG93ZWQtcGlwZS1iCmlndEBrbXNfdW5pdmVyc2FsX3BsYW5lQHVuaXZlcnNh
bC1wbGFuZS1waXBlLWMtZnVuY3Rpb25hbAppZ3RAa21zX3VuaXZlcnNhbF9wbGFuZUB1bml2ZXJz
YWwtcGxhbmUtcGlwZS1jLXNhbml0eQppZ3RAa21zX3VuaXZlcnNhbF9wbGFuZUBkaXNhYmxlLXBy
aW1hcnktdnMtZmxpcC1waXBlLWMKaWd0QGttc191bml2ZXJzYWxfcGxhbmVAY3Vyc29yLWZiLWxl
YWstcGlwZS1jCmlndEBrbXNfdW5pdmVyc2FsX3BsYW5lQHVuaXZlcnNhbC1wbGFuZS1wYWdlZmxp
cC13aW5kb3dlZC1waXBlLWMKaWd0QGttc191bml2ZXJzYWxfcGxhbmVAdW5pdmVyc2FsLXBsYW5l
LXBpcGUtZC1mdW5jdGlvbmFsCmlndEBrbXNfdW5pdmVyc2FsX3BsYW5lQHVuaXZlcnNhbC1wbGFu
ZS1waXBlLWQtc2FuaXR5CmlndEBrbXNfdW5pdmVyc2FsX3BsYW5lQGRpc2FibGUtcHJpbWFyeS12
cy1mbGlwLXBpcGUtZAppZ3RAa21zX3VuaXZlcnNhbF9wbGFuZUBjdXJzb3ItZmItbGVhay1waXBl
LWQKaWd0QGttc191bml2ZXJzYWxfcGxhbmVAdW5pdmVyc2FsLXBsYW5lLXBhZ2VmbGlwLXdpbmRv
d2VkLXBpcGUtZAppZ3RAa21zX3VuaXZlcnNhbF9wbGFuZUB1bml2ZXJzYWwtcGxhbmUtcGlwZS1l
LWZ1bmN0aW9uYWwKaWd0QGttc191bml2ZXJzYWxfcGxhbmVAdW5pdmVyc2FsLXBsYW5lLXBpcGUt
ZS1zYW5pdHkKaWd0QGttc191bml2ZXJzYWxfcGxhbmVAZGlzYWJsZS1wcmltYXJ5LXZzLWZsaXAt
cGlwZS1lCmlndEBrbXNfdW5pdmVyc2FsX3BsYW5lQGN1cnNvci1mYi1sZWFrLXBpcGUtZQppZ3RA
a21zX3VuaXZlcnNhbF9wbGFuZUB1bml2ZXJzYWwtcGxhbmUtcGFnZWZsaXAtd2luZG93ZWQtcGlw
ZS1lCmlndEBrbXNfdW5pdmVyc2FsX3BsYW5lQHVuaXZlcnNhbC1wbGFuZS1waXBlLWYtZnVuY3Rp
b25hbAppZ3RAa21zX3VuaXZlcnNhbF9wbGFuZUB1bml2ZXJzYWwtcGxhbmUtcGlwZS1mLXNhbml0
eQppZ3RAa21zX3VuaXZlcnNhbF9wbGFuZUBkaXNhYmxlLXByaW1hcnktdnMtZmxpcC1waXBlLWYK
aWd0QGttc191bml2ZXJzYWxfcGxhbmVAY3Vyc29yLWZiLWxlYWstcGlwZS1mCmlndEBrbXNfdW5p
dmVyc2FsX3BsYW5lQHVuaXZlcnNhbC1wbGFuZS1wYWdlZmxpcC13aW5kb3dlZC1waXBlLWYKaWd0
QGttc191bml2ZXJzYWxfcGxhbmVAdW5pdmVyc2FsLXBsYW5lLXBpcGUtKGd8aCktZnVuY3Rpb25h
bAppZ3RAa21zX3VuaXZlcnNhbF9wbGFuZUBkaXNhYmxlLXByaW1hcnktdnMtZmxpcC1waXBlLShn
fGgpCmlndEBrbXNfdW5pdmVyc2FsX3BsYW5lQHVuaXZlcnNhbC1wbGFuZS1wYWdlZmxpcC13aW5k
b3dlZC1waXBlLShnfGgpCmlndEBrbXNfY3Vyc29yX2NyY0BjdXJzb3Itc2l6ZS1jaGFuZ2VAcGlw
ZS1bYXxiXSoKaWd0QGttc19jdXJzb3JfY3JjQGN1cnNvci1hbHBoYS1vcGFxdWVAcGlwZS1bYXxi
XSoKaWd0QGttc19jdXJzb3JfY3JjQGN1cnNvci1hbHBoYS10cmFuc3BhcmVudEBwaXBlLVthfGJd
KgppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLW9uc2NyZWVuLTMyeDMyCmlndEBrbXNfY3Vyc29y
X2NyY0BjdXJzb3Itb2Zmc2NyZWVuLTMyeDMyCmlndEBrbXNfY3Vyc29yX2NyY0BjdXJzb3Itb25z
Y3JlZW4tMzJ4MTAKaWd0QGttc19jdXJzb3JfY3JjQGN1cnNvci1vZmZzY3JlZW4tMzJ4MTAKaWd0
QGttc19jdXJzb3JfY3JjQGN1cnNvci1vbnNjcmVlbi02NHg2NAppZ3RAa21zX2N1cnNvcl9jcmNA
Y3Vyc29yLW9mZnNjcmVlbi02NHg2NAppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLW9uc2NyZWVu
LTY0eDIxCmlndEBrbXNfY3Vyc29yX2NyY0BjdXJzb3Itb2Zmc2NyZWVuLTY0eDIxCmlndEBrbXNf
Y3Vyc29yX2NyY0BjdXJzb3Itb25zY3JlZW4tMTI4eDEyOAppZ3RAa21zX2N1cnNvcl9jcmNAY3Vy
c29yLW9mZnNjcmVlbi0xMjh4MTI4CmlndEBrbXNfY3Vyc29yX2NyY0BjdXJzb3Itb25zY3JlZW4t
MTI4eDQyCmlndEBrbXNfY3Vyc29yX2NyY0BjdXJzb3Itb2Zmc2NyZWVuLTEyOHg0MgppZ3RAa21z
X2N1cnNvcl9jcmNAY3Vyc29yLW9uc2NyZWVuLTI1NngyNTYKaWd0QGttc19jdXJzb3JfY3JjQGN1
cnNvci1vZmZzY3JlZW4tMjU2eDI1NgppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLW9uc2NyZWVu
LTI1Nng4NQppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLW9mZnNjcmVlbi0yNTZ4ODUKaWd0QGtt
c19jdXJzb3JfY3JjQGN1cnNvci1vbnNjcmVlbi01MTJ4NTEyCmlndEBrbXNfY3Vyc29yX2NyY0Bj
dXJzb3Itb2Zmc2NyZWVuLTUxMng1MTIKaWd0QGttc19jdXJzb3JfY3JjQGN1cnNvci1vbnNjcmVl
bi01MTJ4MTcwCmlndEBrbXNfY3Vyc29yX2NyY0BjdXJzb3Itb2Zmc2NyZWVuLTUxMngxNzAKaWd0
QGttc19jdXJzb3JfY3JjQGN1cnNvci1vbnNjcmVlbi1tYXgtc2l6ZQppZ3RAa21zX2N1cnNvcl9j
cmNAY3Vyc29yLW9mZnNjcmVlbi1tYXgtc2l6ZQppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLXNs
aWRpbmctMzJ4MzIKaWd0QGttc19jdXJzb3JfY3JjQGN1cnNvci1zbGlkaW5nLTMyeDEwCmlndEBr
bXNfY3Vyc29yX2NyY0BjdXJzb3Itc2xpZGluZy02NHg2NAppZ3RAa21zX2N1cnNvcl9jcmNAY3Vy
c29yLXNsaWRpbmctNjR4MjEKaWd0QGttc19jdXJzb3JfY3JjQGN1cnNvci1zbGlkaW5nLTEyOHgx
MjgKaWd0QGttc19jdXJzb3JfY3JjQGN1cnNvci1zbGlkaW5nLTEyOHg0MgppZ3RAa21zX2N1cnNv
cl9jcmNAY3Vyc29yLXNsaWRpbmctMjU2eDI1NgppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLXNs
aWRpbmctMjU2eDg1CmlndEBrbXNfY3Vyc29yX2NyY0BjdXJzb3Itc2xpZGluZy01MTJ4NTEyCmln
dEBrbXNfY3Vyc29yX2NyY0BjdXJzb3Itc2xpZGluZy01MTJ4MTcwCmlndEBrbXNfY3Vyc29yX2Ny
Y0BjdXJzb3Itc2xpZGluZy1tYXgtc2l6ZQppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLXJhbmRv
bS0zMngzMgppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLXJhbmRvbS0zMngxMAppZ3RAa21zX2N1
cnNvcl9jcmNAY3Vyc29yLXJhbmRvbS02NHg2NAppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLXJh
bmRvbS02NHgyMQppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLXJhbmRvbS0xMjh4MTI4CmlndEBr
bXNfY3Vyc29yX2NyY0BjdXJzb3ItcmFuZG9tLTEyOHg0MgppZ3RAa21zX2N1cnNvcl9jcmNAY3Vy
c29yLXJhbmRvbS0yNTZ4MjU2CmlndEBrbXNfY3Vyc29yX2NyY0BjdXJzb3ItcmFuZG9tLTI1Nng4
NQppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLXJhbmRvbS01MTJ4NTEyCmlndEBrbXNfY3Vyc29y
X2NyY0BjdXJzb3ItcmFuZG9tLTUxMngxNzAKaWd0QGttc19jdXJzb3JfY3JjQGN1cnNvci1yYW5k
b20tbWF4LXNpemUKaWd0QGttc19jdXJzb3JfY3JjQGN1cnNvci1yYXBpZC1tb3ZlbWVudC0zMngz
MgppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLXJhcGlkLW1vdmVtZW50LTMyeDEwCmlndEBrbXNf
Y3Vyc29yX2NyY0BjdXJzb3ItcmFwaWQtbW92ZW1lbnQtNjR4NjQKaWd0QGttc19jdXJzb3JfY3Jj
QGN1cnNvci1yYXBpZC1tb3ZlbWVudC02NHgyMQppZ3RAa21zX2N1cnNvcl9jcmNAY3Vyc29yLXJh
cGlkLW1vdmVtZW50LTEyOHgxMjgKaWd0QGttc19jdXJzb3JfY3JjQGN1cnNvci1yYXBpZC1tb3Zl
bWVudC0xMjh4NDIKaWd0QGttc19jdXJzb3JfY3JjQGN1cnNvci1yYXBpZC1tb3ZlbWVudC0yNTZ4
MjU2CmlndEBrbXNfY3Vyc29yX2NyY0BjdXJzb3ItcmFwaWQtbW92ZW1lbnQtMjU2eDg1CmlndEBr
bXNfY3Vyc29yX2NyY0BjdXJzb3ItcmFwaWQtbW92ZW1lbnQtNTEyeDUxMgppZ3RAa21zX2N1cnNv
cl9jcmNAY3Vyc29yLXJhcGlkLW1vdmVtZW50LTUxMngxNzAKaWd0QGttc19jdXJzb3JfY3JjQGN1
cnNvci1yYXBpZC1tb3ZlbWVudC1tYXgtc2l6ZQppZ3RAa21zX2N1cnNvcl9lZGdlX3dhbGtANjR4
NjQtbGVmdC1lZGdlCmlndEBrbXNfY3Vyc29yX2VkZ2Vfd2Fsa0AxMjh4MTI4LWxlZnQtZWRnZQpp
Z3RAa21zX2N1cnNvcl9lZGdlX3dhbGtAMjU2eDI1Ni1sZWZ0LWVkZ2UKaWd0QGttc19jdXJzb3Jf
ZWRnZV93YWxrQDY0eDY0LXJpZ2h0LWVkZ2UKaWd0QGttc19jdXJzb3JfZWRnZV93YWxrQDEyOHgx
MjgtcmlnaHQtZWRnZQppZ3RAa21zX2N1cnNvcl9lZGdlX3dhbGtAMjU2eDI1Ni1yaWdodC1lZGdl
CmlndEBrbXNfY3Vyc29yX2VkZ2Vfd2Fsa0A2NHg2NC10b3AtZWRnZQppZ3RAa21zX2N1cnNvcl9l
ZGdlX3dhbGtAMTI4eDEyOC10b3AtZWRnZQppZ3RAa21zX2N1cnNvcl9lZGdlX3dhbGtAMjU2eDI1
Ni10b3AtZWRnZQppZ3RAa21zX2N1cnNvcl9lZGdlX3dhbGtANjR4NjQtdG9wLWJvdHRvbQppZ3RA
a21zX2N1cnNvcl9lZGdlX3dhbGtAMTI4eDEyOC10b3AtYm90dG9tCmlndEBrbXNfY3Vyc29yX2Vk
Z2Vfd2Fsa0AyNTZ4MjU2LXRvcC1ib3R0b20KaWd0QGttc19jb25jdXJyZW50QHBpcGUtYUAqCmln
dEBrbXNfY29uY3VycmVudEBwaXBlLWJAKgojIERQTVMgLSBEUE1TCmlndEBrbXNfcGxhbmVAcGxh
bmUtcG9zaXRpb24taG9sZS1kcG1zQHBpcGUtW2F8Yl0qCmlndEBhbWRncHUvYW1kX2Fzc3JAYXNz
ci1saW5rcy1kcG1zCmlndEBrbXNfY29udGVudF9wcm90ZWN0aW9uQGF0b21pYy1kcG1zCmlndEBr
bXNfdnJyQGZsaXAtZHBtc0BwaXBlLWEqCmlndEBrbXNfY3Vyc29yX2NyY0BjdXJzb3ItZHBtc0Bw
aXBlLVthfGJdKgppZ3RAa21zX2F0b21pY19pbnRlcnJ1cHRpYmxlQGxlZ2FjeS1kcG1zQCpwaXBl
LWEKaWd0QGttc19mbGlwQGJhc2ljLWZsaXAtdnMtZHBtc0BbYXxjXSoKIyBIRENQIC0gSERDUCBm
dW5jdGlvbmFsaXR5CmlndEBrbXNfY29udGVudF9wcm90ZWN0aW9uQGF0b21pYwppZ3RAa21zX2Nv
bnRlbnRfcHJvdGVjdGlvbkBsZWdhY3kKIyBESVNQTEFZLUxBWUVSIC0gR2VuZXJhbCBEUk0gQVBJ
IHRlc3RzIGFuZCBkaXNwbGF5IGRyaXZlciB0ZXN0cwppZ3RAY29yZV9hdXRoQGJhc2ljLWF1dGgK
aWd0QGttc19wcm9wX2Jsb2JAYmFzaWMKaWd0QGttc19wcm9wX2Jsb2JAYmxvYi1wcm9wLWNvcmUK
aWd0QGttc19wcm9wX2Jsb2JAYmxvYi1wcm9wLXZhbGlkYXRlCmlndEBrbXNfcHJvcF9ibG9iQGJs
b2ItcHJvcC1saWZldGltZQppZ3RAa21zX3Byb3BfYmxvYkBibG9iLW11bHRpcGxlCmlndEBrbXNf
cHJvcF9ibG9iQGludmFsaWQtZ2V0LXByb3AtYW55CmlndEBrbXNfcHJvcF9ibG9iQGludmFsaWQt
Z2V0LXByb3AKaWd0QGttc19wcm9wX2Jsb2JAaW52YWxpZC1zZXQtcHJvcC1hbnkKaWd0QGttc19w
cm9wX2Jsb2JAaW52YWxpZC1zZXQtcHJvcAppZ3RAYW1kZ3B1L2FtZF9tZW1fbGVha0Bjb25uZWN0
b3ItaG90cGx1ZwppZ3RAa21zX2F0b21pY19pbnRlcnJ1cHRpYmxlQGxlZ2FjeS1zZXRtb2RlQCpw
aXBlLWEKaWd0QGttc19hdG9taWNfaW50ZXJydXB0aWJsZUBhdG9taWMtc2V0bW9kZUAqcGlwZS1h
CmlndEBrbXNfYXRvbWljX2ludGVycnVwdGlibGVAbGVnYWN5LXBhZ2VmbGlwQCpwaXBlLWEKaWd0
QGttc19hdG9taWNfaW50ZXJydXB0aWJsZUBsZWdhY3ktY3Vyc29yQCpwaXBlLWEKaWd0QGttc19h
dG9taWNfaW50ZXJydXB0aWJsZUB1bml2ZXJzYWwtc2V0cGxhbmUtcHJpbWFyeUAqcGlwZS1hCmln
dEBrbXNfYXRvbWljX2ludGVycnVwdGlibGVAdW5pdmVyc2FsLXNldHBsYW5lLWN1cnNvckAqcGlw
ZS1hCmlndEBrbXNfZ2V0ZmJAZ2V0ZmItaGFuZGxlLXZhbGlkCmlndEBrbXNfZ2V0ZmJAZ2V0ZmIt
aGFuZGxlLXplcm8KaWd0QGttc19nZXRmYkBnZXRmYjItaGFuZGxlLXplcm8KaWd0QGttc19nZXRm
YkBnZXRmYi1oYW5kbGUtY2xvc2VkCmlndEBrbXNfZ2V0ZmJAZ2V0ZmIyLWhhbmRsZS1jbG9zZWQK
aWd0QGttc19nZXRmYkBnZXRmYi1oYW5kbGUtbm90LWZiCmlndEBrbXNfZ2V0ZmJAZ2V0ZmIyLWhh
bmRsZS1ub3QtZmIKaWd0QGttc19nZXRmYkBnZXRmYi1hZGRmYi1kaWZmZXJlbnQtaGFuZGxlcwpp
Z3RAa21zX2dldGZiQGdldGZiLXJlcGVhdGVkLWRpZmZlcmVudC1oYW5kbGVzCmlndEBrbXNfZ2V0
ZmJAZ2V0ZmItaGFuZGxlLXByb3RlY3Rpb24KaWd0QGttc19nZXRmYkBnZXRmYjItaGFuZGxlLXBy
b3RlY3Rpb24KaWd0QGttc19nZXRmYkBnZXRmYjItaW50by1hZGRmYjIKaWd0QGttc19hZGRmYl9i
YXNpY0B1bnVzZWQtaGFuZGxlCmlndEBrbXNfYWRkZmJfYmFzaWNAdW51c2VkLXBpdGNoZXMKaWd0
QGttc19hZGRmYl9iYXNpY0B1bnVzZWQtb2Zmc2V0cwppZ3RAa21zX2FkZGZiX2Jhc2ljQHVudXNl
ZC1tb2RpZmllcgppZ3RAa21zX2FkZGZiX2Jhc2ljQGNsb2JiZXJyZWQtbW9kaWZpZXIKaWd0QGtt
c19hZGRmYl9iYXNpY0BpbnZhbGlkLXNtZW0tYm8tb24tZGlzY3JldGUKaWd0QGttc19hZGRmYl9i
YXNpY0BsZWdhY3ktZm9ybWF0CmlndEBrbXNfYWRkZmJfYmFzaWNAbm8taGFuZGxlCmlndEBrbXNf
YWRkZmJfYmFzaWNAYmFzaWMKaWd0QGttc19hZGRmYl9iYXNpY0BiYWQtcGl0Y2gtMAppZ3RAa21z
X2FkZGZiX2Jhc2ljQGJhZC1waXRjaC0zMgppZ3RAa21zX2FkZGZiX2Jhc2ljQGJhZC1waXRjaC02
MwppZ3RAa21zX2FkZGZiX2Jhc2ljQGJhZC1waXRjaC0xMjgKaWd0QGttc19hZGRmYl9iYXNpY0Bi
YWQtcGl0Y2gtMjU2CmlndEBrbXNfYWRkZmJfYmFzaWNAYmFkLXBpdGNoLTEwMjQKaWd0QGttc19h
ZGRmYl9iYXNpY0BiYWQtcGl0Y2gtOTk5CmlndEBrbXNfYWRkZmJfYmFzaWNAYmFkLXBpdGNoLTY1
NTM2CmlndEBrbXNfYWRkZmJfYmFzaWNAc2l6ZS1tYXgKaWd0QGttc19hZGRmYl9iYXNpY0B0b28t
d2lkZQppZ3RAa21zX2FkZGZiX2Jhc2ljQHRvby1oaWdoCmlndEBrbXNfYWRkZmJfYmFzaWNAYm8t
dG9vLXNtYWxsCmlndEBrbXNfYWRkZmJfYmFzaWNAc21hbGwtYm8KaWd0QGttc19hZGRmYl9iYXNp
Y0Biby10b28tc21hbGwtZHVlLXRvLXRpbGluZwppZ3RAa21zX2FkZGZiX2Jhc2ljQGFkZGZiMjUt
bW9kaWZpZXItbm8tZmxhZwppZ3RAa21zX2FkZGZiX2Jhc2ljQGFkZGZiMjUtYmFkLW1vZGlmaWVy
CmlndEBrbXNfYWRkZmJfYmFzaWNAYWRkZmIyNS14LXRpbGVkLW1pc21hdGNoLWxlZ2FjeQppZ3RA
a21zX2FkZGZiX2Jhc2ljQGFkZGZiMjUteC10aWxlZC1sZWdhY3kKaWd0QGttc19hZGRmYl9iYXNp
Y0BhZGRmYjI1LWZyYW1lYnVmZmVyLXZzLXNldC10aWxpbmcKaWd0QGttc19hZGRmYl9iYXNpY0Bh
ZGRmYjI1LXktdGlsZWQtbGVnYWN5CmlndEBrbXNfYWRkZmJfYmFzaWNAYWRkZmIyNS15Zi10aWxl
ZC1sZWdhY3kKaWd0QGttc19hZGRmYl9iYXNpY0BhZGRmYjI1LXktdGlsZWQtc21hbGwtbGVnYWN5
CmlndEBrbXNfYWRkZmJfYmFzaWNAYWRkZmIyNS00LXRpbGVkCmlndEBrbXNfYWRkZmJfYmFzaWNA
YmFzaWMteC10aWxlZC1sZWdhY3kKaWd0QGttc19hZGRmYl9iYXNpY0BmcmFtZWJ1ZmZlci12cy1z
ZXQtdGlsaW5nCmlndEBrbXNfYWRkZmJfYmFzaWNAdGlsZS1waXRjaC1taXNtYXRjaAppZ3RAa21z
X2FkZGZiX2Jhc2ljQGJhc2ljLXktdGlsZWQtbGVnYWN5CmlndEBrbXNfYWRkZmJfYmFzaWNAaW52
YWxpZC1nZXQtcHJvcC1hbnkKaWd0QGttc19hZGRmYl9iYXNpY0BpbnZhbGlkLWdldC1wcm9wCmln
dEBrbXNfYWRkZmJfYmFzaWNAaW52YWxpZC1zZXQtcHJvcC1hbnkKaWd0QGttc19hZGRmYl9iYXNp
Y0BpbnZhbGlkLXNldC1wcm9wCmlndEBrbXNfYWRkZmJfYmFzaWNAbWFzdGVyLXJtZmIKaWd0QGtt
c19zeXNmc19lZGlkX3RpbWluZwppZ3RAa21zX2RwX2F1eF9kZXYKIyBTMyAtIFMzCmlndEBhbWRn
cHUvYW1kX3Zycl9yYW5nZUBmcmVlc3luYy1wYXJzaW5nLWRwLXN1c3BlbmQKaWd0QGFtZGdwdS9h
bWRfdnJyX3JhbmdlQGZyZWVzeW5jLXJhbmdlLWRwLXN1c3BlbmQKaWd0QGttc19jdXJzb3JfY3Jj
QGN1cnNvci1zdXNwZW5kQHBpcGUtW2F8Yl0qCmlndEBhbWRncHUvYW1kX2Fzc3JAYXNzci1saW5r
cy1zdXNwZW5kCiMgTVBPIC0gTXVsdGkgUGxhbmUgT3ZlcmxheQppZ3RAYW1kZ3B1L2FtZF9wbGFu
ZUBtcG8tc3dpenpsZS10b2dnbGUKaWd0QGFtZGdwdS9hbWRfcGxhbmVAbXBvLXBhbi1yZ2IKaWd0
QGFtZGdwdS9hbWRfcGxhbmVAbXBvLXBhbi1udjEyCmlndEBhbWRncHUvYW1kX3BsYW5lQG1wby1w
YW4tcDAxMAppZ3RAYW1kZ3B1L2FtZF9wbGFuZUBtcG8tc2NhbGUtcmdiCmlndEBhbWRncHUvYW1k
X3BsYW5lQG1wby1zY2FsZS1udjEyCmlndEBhbWRncHUvYW1kX3BsYW5lQG1wby1zY2FsZS1wMDEw
CiMgQVNTUiAtIEFTU1IKaWd0QGFtZGdwdS9hbWRfYXNzckBhc3NyLWxpbmtzCiMgQ1JDLVBJUEVT
IC0gVGVzdCBiYXNpYyBDUkMgZnVuY3Rpb25hbGl0eQppZ3RAa21zX3BpcGVfY3JjX2Jhc2ljQGJh
ZC1zb3VyY2UKaWd0QGttc19waXBlX2NyY19iYXNpY0ByZWFkLWNyY0BwaXBlLVthfGJdKgppZ3RA
a21zX3BpcGVfY3JjX2Jhc2ljQHJlYWQtY3JjLWZyYW1lLXNlcXVlbmNlQHBpcGUtW2F8Yl0qCmln
dEBrbXNfcGlwZV9jcmNfYmFzaWNAbm9uYmxvY2tpbmctY3JjQHBpcGUtW2F8Yl0qCmlndEBrbXNf
cGlwZV9jcmNfYmFzaWNAbm9uYmxvY2tpbmctY3JjLWZyYW1lLXNlcXVlbmNlQHBpcGUtW2F8Yl0q
CmlndEBrbXNfcGlwZV9jcmNfYmFzaWNAZGlzYWJsZS1jcmMtYWZ0ZXItY3J0Y0BwaXBlLVthfGJd
KgppZ3RAa21zX3BpcGVfY3JjX2Jhc2ljQGhhbmctcmVhZC1jcmNAcGlwZS1bYXxiXSoKaWd0QGtt
c19waXBlX2NyY19iYXNpY0Bjb21wYXJlLWNyYy1zYW5pdHljaGVja0BwaXBlLVthfGJdKgojIFRJ
TEVELURJU1BMQVkgLSBUZXN0cyBmb3IgdGlsZWQgZGlzcGxheXMKaWd0QGttc19id0BsaW5lYXIt
dGlsaW5nLTEtZGlzcGxheXMtMTkyMHgxMDgwcAppZ3RAa21zX2J3QGxpbmVhci10aWxpbmctMS1k
aXNwbGF5cy0yNTYweDE0NDBwCmlndEBrbXNfYndAbGluZWFyLXRpbGluZy0xLWRpc3BsYXlzLTM4
NDB4MjE2MHAKaWd0QGttc19id0BsaW5lYXItdGlsaW5nLTItZGlzcGxheXMtMTkyMHgxMDgwcApp
Z3RAa21zX2J3QGxpbmVhci10aWxpbmctMi1kaXNwbGF5cy0yNTYweDE0NDBwCmlndEBrbXNfYndA
bGluZWFyLXRpbGluZy0yLWRpc3BsYXlzLTM4NDB4MjE2MHAKaWd0QGttc19id0BsaW5lYXItdGls
aW5nLTMtZGlzcGxheXMtMTkyMHgxMDgwcAppZ3RAa21zX2J3QGxpbmVhci10aWxpbmctMy1kaXNw
bGF5cy0yNTYweDE0NDBwCmlndEBrbXNfYndAbGluZWFyLXRpbGluZy0zLWRpc3BsYXlzLTM4NDB4
MjE2MHAKaWd0QGttc19id0BsaW5lYXItdGlsaW5nLTQtZGlzcGxheXMtMTkyMHgxMDgwcAppZ3RA
a21zX2J3QGxpbmVhci10aWxpbmctNC1kaXNwbGF5cy0yNTYweDE0NDBwCmlndEBrbXNfYndAbGlu
ZWFyLXRpbGluZy00LWRpc3BsYXlzLTM4NDB4MjE2MHAKaWd0QGttc19id0BsaW5lYXItdGlsaW5n
LTUtZGlzcGxheXMtMTkyMHgxMDgwcAppZ3RAa21zX2J3QGxpbmVhci10aWxpbmctNS1kaXNwbGF5
cy0yNTYweDE0NDBwCmlndEBrbXNfYndAbGluZWFyLXRpbGluZy01LWRpc3BsYXlzLTM4NDB4MjE2
MHAKaWd0QGttc19id0BsaW5lYXItdGlsaW5nLTYtZGlzcGxheXMtMTkyMHgxMDgwcAppZ3RAa21z
X2J3QGxpbmVhci10aWxpbmctNi1kaXNwbGF5cy0yNTYweDE0NDBwCmlndEBrbXNfYndAbGluZWFy
LXRpbGluZy02LWRpc3BsYXlzLTM4NDB4MjE2MHAKIyBEU0MgLSBEU0MgbGlnaHR1cCBhbmQgZnVu
Y3Rpb25hbGl0eQppZ3RAYW1kZ3B1L2FtZF9kcF9kc2NAZHNjLWVuYWJsZS1iYXNpYwppZ3RAYW1k
Z3B1L2FtZF9kcF9kc2NAZHNjLXNsaWNlLWRpbWVuc2lvbnMtY2hhbmdlCmlndEBhbWRncHUvYW1k
X2RwX2RzY0Bkc2MtbGluay1zZXR0aW5ncwppZ3RAYW1kZ3B1L2FtZF9kcF9kc2NAZHNjLWJwYwoK
IyB0ZXN0cyB3aXRoIGhpZ2hlciBwcm9iYWJpbGl0eSBvZiBoYW5naW5nIHRoZSBzeXN0ZW0KaWd0
QGFtZGdwdS9hbWRfbGlua19zZXR0aW5nc0BsaW5rLXRyYWluaW5nLWNvbmZpZ3MKaWd0QGFtZGdw
dS9hbWRfaG90cGx1Z0BiYXNpYy1zdXNwZW5kCmlndEBrbXNfdmJsYW5rQHBpcGUtYS10cy1jb250
aW51YXRpb24tc3VzcGVuZAppZ3RAYW1kZ3B1L2FtZF9tZW1fbGVha0Bjb25uZWN0b3Itc3VzcGVu
ZC1yZXN1bWUKaWd0QGttc19waXBlX2NyY19iYXNpY0BzdXNwZW5kLXJlYWQtY3JjQHBpcGUtW2F8
Yl0qCg==

--_004_CH0PR12MB52844D522925ED7FFFE294228B4EACH0PR12MB5284namp_--
