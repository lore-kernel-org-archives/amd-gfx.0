Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9C4C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 13:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F7410E7B0;
	Mon, 13 Jun 2022 13:32:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0470010E7B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 13:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ck/dqgJRU5z5MIOt9VBl0PeMQFsWnuZTcRCIr8mD3GXd+e745M9fAJ8BbUw9iv8MzcDWbUMb1ExbFH/KfFZrU6BvcB7Cnt1E2fLEyUohVmvaK573Wb80eY3GopsWCJuT1Zap0u0CiMdqJyBD58t5gqE/rpE4s33zY+taDFjknY9nBsHK2QjqhloL5Gi/oHQjOGy+0IVVLpJLdHK0za90XxMJfHIxvCbCnBXTvouEMwDydqhaRYCZN5OLVA0LVg1iP61byKtG4BsyRnbqfM+GKk3HvG0q1pYnFRHPWlGCHPzXVqBhhHkTdKbKP+V9ZwIvsDD8a4rFwk4gSUdrOKXqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxaDZHLPKhX5XrGwmpVTdaGxcSe+VKlyRnVBdOt/Af4=;
 b=gxk6vGjpLurfYvmY9q5mVG9VJYz3h8ovk8Gweeyl0NZAayxCCAf37+HpuRoGES+65bRqWSxtewkVfxxAFapYK/hHZS5r1YDfxPsI7LGGPRetz2IVDxMbkS4bBd5cfl7Z6SuxUQ6hEb91objBh5ofuJMrmibYNP0P+gHZW3ao2mY78xpSMAx1farccJ41y1mgfeWPfktUkQZe3FnpfiQNIjEL8+FhOmWNVL2ykt3v4nPkV/3IVT5ikR0cqF3qlynpXK2KxI8A+igEgH8GMqodsjNf0RpoSvIYHilK2qDa0N/+ZEUuXu/s2v1DwIPkCSwS23sfWJBMb9fkZ8Jig4cWZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxaDZHLPKhX5XrGwmpVTdaGxcSe+VKlyRnVBdOt/Af4=;
 b=Nwb4+a8//64jp6BWAvdbg1+tMWMYsJ8aiXh+4iavNIFkG4ZNG1b39JGKpaU0mgNll7GP7nqSfzRchkf6QJuXX/rmFPHtweOSHd09vYB5B+v/1XGah5wlP4m1YhaBMp9SJGFxk4vFrpQ6gcmO9Ueu48w8P/iLRCtcmP4ZmLGUTPs=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BYAPR12MB4773.namprd12.prod.outlook.com (2603:10b6:a03:109::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 13:32:35 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%4]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 13:32:35 +0000
From: "Vanzylldejong, Harry" <Harry.Vanzylldejong@amd.com>
To: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>,
 =?iso-8859-1?Q?Michel_D=E4nzer?= <michel.daenzer@mailbox.org>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock
 switching in games
Thread-Topic: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock
 switching in games
Thread-Index: AQHYfQw8BurspX6q6kOZ7GWxvKrbYa1NKhKAgAAhu4CAAAubIA==
Date: Mon, 13 Jun 2022 13:32:35 +0000
Message-ID: <DM6PR12MB425067D163386CE813BBF02FF4AB9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
 <20220610205245.174802-21-hamza.mahfooz@amd.com>
 <3c4a7856-dc93-8933-0904-0b6f2d270bc1@mailbox.org>
 <MW4PR12MB5668A72B83B72BD7EDB29BFB96AB9@MW4PR12MB5668.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB5668A72B83B72BD7EDB29BFB96AB9@MW4PR12MB5668.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c89e7441-9f24-46e8-9953-7ee41e38d39d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-13T13:23:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffc82068-8c34-42a8-ca4b-08da4d412d53
x-ms-traffictypediagnostic: BYAPR12MB4773:EE_
x-microsoft-antispam-prvs: <BYAPR12MB4773B4A334100408D34C64B9F4AB9@BYAPR12MB4773.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: odK2tLvuDsFBejo9lhLwIcOteP3v4qWjkwxEwuvmelez8NtNgwvcmWmufiLeevJYmvtstjzwz4vIrgGAf6+vO6eO7hv2ET37hOFRAUIZVlfpqbk2N1dztOdozTDMy7gaHAy66cX3nTvLqovK7OPeDHoKLZLMZD5DCT4WPxCsw/RCMG02d7rrwW2bWkHUUt5+a/Wzlspijg9RpiIab+M7/dNH1wsHjvs2mdVwfz3+wmIZp4Rf8jlwYrYaOeRhHz0Of3au8L6ANoXbxuTESk6wKzOueVf+/sfLO+cZl/uUGSgR1f9rtaR/55pW3sB6lSe1gBzRndeJddb3v6a9mmusYn52yLgKwa+D//lO74x3a1IqD7pQL0ELFzSTHzYPv7WL2wsYiii96HvpSGrMKggz9kNGebBlM/3AHboY5j2uwNQTc9UwvuOHRJFwtPv+uurFMsPfW88bMelch/6tWFsRNQNMTr618JJoR7B30BfmXcG7DjhnNsDtUnseA+3Tmtvycl1c+dexa6vLIdgu5HOFnmvzknPYBvwdUGNJw71oTxGEtbmGJ+CZuPs5spDHX/he6urnOpzcaojRkYBCAHxisede1FVIcaPFh1IaLdeksSTqewyJvwyVH+O1eCJCGtXIrHJB0ySbpuIepHXj0LmMCJXm4h1YojRZfkyWmZEu8JwrCW+ZeVGw9Bz7uuUr+CAB56ag7CbvPDOz4exGUZhhbUHS5xC65JnSsFrrkbuIDjcqXCHY9sk8ITiP1QErAV9DrYpcRGBFPjK5oq3E/LhtSxrGIrHYsUGlH/ujjxL9QbM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(316002)(38070700005)(53546011)(38100700002)(186003)(86362001)(6506007)(2906002)(54906003)(110136005)(7696005)(66574015)(9686003)(8676002)(64756008)(4326008)(66476007)(83380400001)(508600001)(5660300002)(966005)(52536014)(66946007)(66446008)(122000001)(66556008)(76116006)(55016003)(8936002)(26005)(45080400002)(71200400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?C3iuZgNVOCxIYicCleal3pmc8s7PjzEKypEi+dLwSyJUYggGKYnHNUS8h/?=
 =?iso-8859-1?Q?WGRkjlaOCm53PQibJiX3yuTuEmHRZTwo9oO+RQxdyWqfiprcSi1n4dlwmU?=
 =?iso-8859-1?Q?0vIGQ/fDLvnUgYuFcSD6j/c2Yw5hvb/CFduRuqAJYS7jmWF2OJorTgdBDi?=
 =?iso-8859-1?Q?VUTJWhKHi+N14YTBX2vkgyrT0R7uPPwP3qHO6bBEiLmZKevrMRh9W8imoA?=
 =?iso-8859-1?Q?1I69MLPdWzBpZZseWB4K3NrQhs04sBq1/QzYrILMesw6n4gd6YTuEVpRvQ?=
 =?iso-8859-1?Q?3Ota6x2V33NZLfmnqklW2u6aY3NRv9Md6Lks6X9yXFhQ1y+rDi0hCLVpUD?=
 =?iso-8859-1?Q?Ux40WOW0PkCLQqiZK0gQcp5NZn07qAjRKUUFLjQtq3R9kerRKyrixKYr/f?=
 =?iso-8859-1?Q?cNjCpwuw+RJU+k75g5DBO4wXkhImCC61oh4gyMq6La2n/qgwzc7bKjpfgs?=
 =?iso-8859-1?Q?c7kQVOAWULn5mu4FugC2RIYEFFsTMbicheGOLGEYpm3FFBNF2tW+kDAOof?=
 =?iso-8859-1?Q?Jw/dxW7nXcI9WjpRePrIqf4Jjhz3VoWI+RIH+KhWFdW85sHjYdKiC4XAYe?=
 =?iso-8859-1?Q?UhPubxYvrD+MhnIxq0GuyLZUiaKSifs9x9zNU5mAwLtAzQcgQQedapAIq+?=
 =?iso-8859-1?Q?kqgDgzx3rRbjkgbebUyLEwsV4LeMm9c17n++yYDWXCWzr23hWqzA/Sz0cw?=
 =?iso-8859-1?Q?CxywvqmoHrWU39Fpmyk2g5Doz/SNn+FoVUoPQ74L+NCcJe+RqAcUTDQ/pi?=
 =?iso-8859-1?Q?dvSkc6CcDfkpzecIpL/UsWV7sjaZ2Kf53W8Bs3V0qijt2zebiyHoPMUam/?=
 =?iso-8859-1?Q?NJpIg0U5G8Z84ehMY7EVCoJGl8ptJhfHRw5VYNPTARujAJGmXYwYlY1zZm?=
 =?iso-8859-1?Q?ndoxOUpYPs5TIlyJ+kG4lEsDRXYSt8JXnJmFTkokC/EQvB4/sU0Xs+DhM6?=
 =?iso-8859-1?Q?x4dHFPY/RiseqKLT3wZ7glu49ZLhldd/EodNyjCX9PyvOaERD5C4Jh5A3M?=
 =?iso-8859-1?Q?dN4EeVWpK7OOFSS9ByF4c7BC14XtgVn4Kak92gRSamqchuwNfc18dkgKtq?=
 =?iso-8859-1?Q?EG6QcP1HevPFgr4rYZyLZ9gU0x6l/cKAGu/BF5goRHcMyMN/nsqugjcmZg?=
 =?iso-8859-1?Q?RWnI3qETtKY1E9hFkiU62FeYjtad3BMPjsEHWRu7HQ4Jb/TJq1VdY0Pvm1?=
 =?iso-8859-1?Q?hNPxbTou4MMDSmYl9j2d5g59xmg2uM8aPu61hNeedn0W1duN/sDZ7Rc5Rd?=
 =?iso-8859-1?Q?loiDiE3h0OrVL/iOIyzr7K5oVWHLuT6TS4v6TVhpeirBJSU6H5heBmvXBf?=
 =?iso-8859-1?Q?p1LJkn3v9vF8vw9mP/MN8MSiDyjqbQIIsApaYwnq1OM/Yuy2fZQCg5p44i?=
 =?iso-8859-1?Q?o8izjn/3f2L/yh9wD1Erc5+5Q+lgt6WJAhXETQS8D9oZfePzcN7Y70fsSP?=
 =?iso-8859-1?Q?ob5iCkIpr2xGqqD+1DV6rDoXbu72f4SwO86AE80ApLvJAcD1JvT1/9eKZp?=
 =?iso-8859-1?Q?nazzDeOkFEX4j4Ztvk2zA8Xz7kSQNw+f+zSDe715lkFZaiKc9Akm6uX8hD?=
 =?iso-8859-1?Q?WfU29b/AXBG3wjpPIOdNmU2p4UCNRsPvofjeK0Lw4bG1d1ScLsRgWYQ1hC?=
 =?iso-8859-1?Q?A4A3CxOEw0ObuEKTGMff5z+i7lbRKMiJkcBIUcReRT4Jhi/BnOhsQlDdI4?=
 =?iso-8859-1?Q?r6FJqt4NHjS2kmCGGU8248eW6jphAqj4jtXVtmRr9B/RiOOOCgVr6F1QUG?=
 =?iso-8859-1?Q?P3cIC/cIgQ0Tx7/7/Ej0cweiyVZQPiC3/njAbMNoqdAs4X4HAmAKSskDxq?=
 =?iso-8859-1?Q?W6mqrvs/ug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc82068-8c34-42a8-ca4b-08da4d412d53
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 13:32:35.4556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvUlsj3420XeFaoZkJyzK/+axMumPV+1W9CFIVZ6L/8vTB/WVOFbM/mt1V0oN1hLbzXOts+JVxZQsXtClRoYzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4773
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Liu,
 HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Chandan,

When using Firmware Assisted Memory clock Switching (FAMS), when the memory=
 clock is switched the frame rate is dropped for at least 1 frame,
sometimes 2-3 frames to make the V-Blank long enough to handle the period w=
here the GDDR6 memory is unavailable when the memory clock switches.
This drop may be noticeable by gamers, especially if the memory clock wants=
 to change it's clock rate several times a second,
which is what we observed just on the desktop.
To guarantee best game performance, we disable FAMS during game play.

Harry


-----Original Message-----
From: VURDIGERENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>
Sent: June 13, 2022 8:42 AM
To: Michel D=E4nzer <michel.daenzer@mailbox.org>; Mahfooz, Hamza <Hamza.Mah=
fooz@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Liu, HaoPing (Alan) <Hao=
Ping.Liu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Lakha, Bhawanpr=
eet <Bhawanpreet.Lakha@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@am=
d.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@a=
md.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.co=
m>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Vanzylldejong, Harry <Har=
ry.Vanzylldejong@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wentland, Harry =
<Harry.Wentland@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; K=
otarac, Pavle <Pavle.Kotarac@amd.com>
Subject: RE: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock s=
witching in games

Hi,

Can you please elaborate on why dynamic memory clock switching can affect G=
ame performance?

BR,
Chandan V N


>On 2022-06-10 22:52, Hamza Mahfooz wrote:
>> From: Harry VanZyllDeJong <harry.vanzylldejong@amd.com>
>>
>> [WHY]
>> Game performace may be affected if dynamic memory clock switching is
>> enabled while playing games.
>>
>> [HOW]
>> Propagate the vrr active state to dirty bit so that on mode set it
>> disables dynamic memory clock switching.
>
>So dynamic memory clock switching will be disabled whenever VRR is enabled=
?
>
>Note that there is ongoing discussion about how Wayland compositors could =
usefully keep VRR enabled all the time, as opposed to only while >there's a=
 fullscreen application like a game. So "VRR is enabled" likely won't be eq=
uivalent to "game is running" in the long term.
>
>
--
Earthling Michel D=E4nzer            |                  https://nam11.safel=
inks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=3D0=
5%7C01%7Cchandan.vurdigerenataraj%40amd.com%7C005764271a144b5832c408da4d293=
dee%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637907136793233201%7CUnkno=
wn%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DNSiOtjfwkelxkZMRFLzFs1mFPvosOFZnqrcNvR=
b9J6E%3D&amp;reserved=3D0
Libre software enthusiast          |         Mesa and Xwayland developer
