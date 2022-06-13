Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A665C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 14:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44E810E20E;
	Mon, 13 Jun 2022 14:52:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC57210E20E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 14:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQMTXvALMMLwy3AphdDPkRDUBz2DMldULmfCHxuwdfYcX1C4nOswg381gXncZatfM3GzbjTUEJ0zCTArGL8EoMGBjPSHXRnwHlhgZc9MiFC1i7B0a0y4KIUPt3QOzO7qDJqQfFDnUwtH2Ofsr5wPI6992R/QBtsQReVCpN9SH0jMQBK1q4YrvYQ+68WGxzzN0/vNsv3aauTbNWje5TxocUq5nD/nH//1EvlaCYWlMWjbRmDOzcVlB1Ixs2rsC2A3nT8EHxT8zP0BGWxtF4J4UROgBjvnxz5kyGYtf1EWTXAHG6+SodPIBPtl2tFGnfHEGH1K06jJEvwMQTKxdE8U0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kw9J1wOj8pUAYRfui4Y7Yld1q4p6UZMhchf4fQeEbg=;
 b=EFfma/dcIBWX/kqX0QfpGUmdRYvkvap/fTmKaerkbZ/TfCtY9HLdsq4F8H9pNbaTH8Qjzb7KcZkMkL+ZT4hYOIQS5rfNkOAYBdrzU5dNUIOKUewnifTJON6VdVwzE/LSn+1+10hrHda3j0bKZMfhIoOQKuLo3ISnqGLchZEcHDJSZHfdPhf4gez+i2BWrAkGxjUkzjYUS0yV+Y8DM3nt45WLvN7WRK7Fj4jKy1QO8y/tNIj+0ui2d3+WWlgwef73Y3EFmzJ3137Y6VbThYAKSDt07vPhIpnuOjMfVxXIVCtCf95MtjTnHRQm68vSPg60lTxFYZd2mEvTF0w3cJhH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kw9J1wOj8pUAYRfui4Y7Yld1q4p6UZMhchf4fQeEbg=;
 b=xXAvC4dEvVUok7N1u+bXv9Zm0wdibjLJwf0l/qW2SWpoIxz3xfytrJ7xGUYSwVbWddtS9CAKQrfuVTVj7iIkbSGGp+jTUKuhfMW9WcFh7Lk9qGdiU5vm18tGKYhfECShzjkCDcSolGQ7bisKTGrgNUoNtBiJj7vS0OMmlQB155U=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MW2PR12MB2522.namprd12.prod.outlook.com (2603:10b6:907:f::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.16; Mon, 13 Jun 2022 14:52:49 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%4]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 14:52:49 +0000
From: "Vanzylldejong, Harry" <Harry.Vanzylldejong@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock
 switching in games
Thread-Topic: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock
 switching in games
Thread-Index: AQHYfQw8BurspX6q6kOZ7GWxvKrbYa1NKhKAgAAhu4CAAAubIIAAE9IAgAAEwYA=
Date: Mon, 13 Jun 2022 14:52:49 +0000
Message-ID: <DM6PR12MB425031A66132DF5CEF04B0B1F4AB9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
 <20220610205245.174802-21-hamza.mahfooz@amd.com>
 <3c4a7856-dc93-8933-0904-0b6f2d270bc1@mailbox.org>
 <MW4PR12MB5668A72B83B72BD7EDB29BFB96AB9@MW4PR12MB5668.namprd12.prod.outlook.com>
 <DM6PR12MB425067D163386CE813BBF02FF4AB9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <CADnq5_O0yYM6vG+R9wf7-v4uNmKqvBXWy_-kKewiBQfN6SmY+A@mail.gmail.com>
In-Reply-To: <CADnq5_O0yYM6vG+R9wf7-v4uNmKqvBXWy_-kKewiBQfN6SmY+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Felipe.Clark@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fdfd3fe2-fe8d-4b61-9b89-087b2525ecc3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-13T14:51:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ab78e29-6324-42f8-2c2a-08da4d4c62b8
x-ms-traffictypediagnostic: MW2PR12MB2522:EE_
x-microsoft-antispam-prvs: <MW2PR12MB2522C688C4BA20FE18C71544F4AB9@MW2PR12MB2522.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OzihDbzpzK7N6nE9hmx3kEZf50+7+ZOkMcxxVlqB/SxNYFiuuqCL3XOlIWsfy22mqUYSkjKIDgbAfHw7FeKW+qgHcVvE9ZT8ywVOp4fGB3Gzw2lch7OcAC+O5n0YLA8g7mObFVzPEFcWqAotndV+KpcYzzziyfbfqP0anwTOKxSleNpjZs7lsXCoPRJAA+J4pRVQ/yWOwGSg0k5dr1xjQT6FGnL6Bf+wEdHCsjhMhludW4uS7jxtTM7vNRCl5k8GArBjqFn9T/fXhZRU3ZWfHn/HXpi899vxsCn0aSGQmw2OenXpVfd3yoIkbI/gE6ynBCfGqdAgISdKoxah5PfM0xqCuHN6yGF7rA2kUsK3xNRfEnOOPYOLpjUx4DYAvyW8PTWRhJtKSf9oFpQIL2lBfiiPwSlnSbNYfu1sBpUUvW/XNSo2HR1cGFx4e4n1CIZfhUk5rOyNPRdwxZdNoX21s34/2wotDV3kxvluSoQHfILRWbWlWucsmuCo/oNz/oJW9ESe74D7XeMggFKFCJc6riZmf263PsDG3FlbJuDk5/gDfCz00Qoks8cKOk7kfk3dV+jmM01sp3NnSpCYbFQJ0gbLmnOslCWgkrAyS+3SSN6sS93/rN9uakGS8eMzknvKDvRrseGJCl3rcH+a+Ml+gAI3U/rfg07ezRDP79tCgPxobgtRa0NQ/Xv7abYIIGTXyXNKHUmuuKuRMsinjs57UWgx3bL0deZHIKS63gpb+dvnPQsRxP76DuG+H2UQSnoAICz42ocQROfHJ7Im2iLAQ5TY6vZ9fItdlUQRDd4CnKg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(66574015)(38100700002)(6506007)(53546011)(7696005)(52536014)(2906002)(55016003)(83380400001)(5660300002)(33656002)(9686003)(508600001)(8676002)(66946007)(8936002)(86362001)(76116006)(122000001)(966005)(45080400002)(38070700005)(71200400001)(186003)(26005)(66556008)(64756008)(66476007)(66446008)(4326008)(54906003)(316002)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NTfD1bFLeGiG1U3m2RzpzlBJC87D6jGKoedxQRnreg/wILAyvTZ+LXLQam?=
 =?iso-8859-1?Q?tp3uF4E/T6xOijAhQ7yCzs/2ylL35Vk+gDs3IyOaS0jXKBywa/HKuK0V0g?=
 =?iso-8859-1?Q?mvdK9JHgJsti1GzCBgJ8d+8cZbAssnVIHFvim1cIes6O125p+qXGsY4lYw?=
 =?iso-8859-1?Q?axptn1QacuiKys9+uezGUwZZMxfz4Rs/7oTa/Jrd0uG+bgv4a5GD5xuiOP?=
 =?iso-8859-1?Q?/lEjN6ZxTdjoLV9vgXRkMfs2nLJJimK6thzsO1OC8+c6y9i6Fx2s/L28BZ?=
 =?iso-8859-1?Q?6HQJB6PFHCe1OAVJSGWfLEgd94VfO7oiQERtiBgxZHgMx8Petgpzx8qruR?=
 =?iso-8859-1?Q?YMFKL2Jiq0hXnm1yoP5ZZ42qUWs5cy12+Rd2f0yKS/wiOfmIk428teTwu/?=
 =?iso-8859-1?Q?NZgYS2p4xwH/OiqQ2zlwOOElQIG7FR2H9keRngGLfbVf8g6OLtFt0mztcX?=
 =?iso-8859-1?Q?RUNuY79JGC6QF6peUZgkus8IpVP6iZDawF64UofFdbqjQLJfpSVYswHxQ0?=
 =?iso-8859-1?Q?2KTS9cy5WOGN5Aa8MVvGuDEDaQjYJ/8f+ssYLZDDpyAddtZkKEyPhXRndo?=
 =?iso-8859-1?Q?CbqV8bsyQqtpV04mPL4b1r1VoFdpVAw0UN6DuAtWERCbVx4Cgh55VEahN/?=
 =?iso-8859-1?Q?TZPvjTHDL6Qa20e4RUXfwbjPCtSQTUZqR9ffbRqhGvRzsHTixGwA2k7ccf?=
 =?iso-8859-1?Q?LyhxmQfOiA7BkPvwGwJAjjVSlIJz5GxGBSuGyt6WOxTCTHWs1cH6jThWbC?=
 =?iso-8859-1?Q?tZRqm+zqJee6tCWl01bLOuShVdA4GA1rUt4YIekSQn4yB6RDBFi3WZG5wG?=
 =?iso-8859-1?Q?pkFLWqNCQLln81ieZ9LXWzJfgKRpdMUCPYspuaJTQ7Fl9jXRVYOklRJyec?=
 =?iso-8859-1?Q?rnBpeZt0fFwVVAff4Kd55xV7J96ye38VZWkpgCYz6ZNbqbSvKMzP1NPNV+?=
 =?iso-8859-1?Q?Z4s5hlsYvZ0srsaI9OU5MXXBBzbY7g9mU4/cGgLtAql/IMYKXKGa92qd2M?=
 =?iso-8859-1?Q?kEe+0Rps8QoFrDyuibBk/hZ11qio/MkaffEgJj/1DduWgMD4ezmwbPUKyB?=
 =?iso-8859-1?Q?JZaksZfgtM9/CUIdl1TaSOChkVunhOOSSfs57hh3dSOOfYx0VaSrIzOrWN?=
 =?iso-8859-1?Q?28Do4R7f9bOOxqfyoSkDTXnYT83n3l+0zHypwqj0ZgZRkuj+f5oQUeP3eP?=
 =?iso-8859-1?Q?HzRuGpBrV2KBJPqL1yLdFkLvy4hj2oDBGcGHMicT3CYJn5orCKP2EeTB46?=
 =?iso-8859-1?Q?PO0PJmGtN0d1TLlxWtQy12f+1VjC5Lyx5Qdsdt/GAss0KGM9N1lPKGS6qZ?=
 =?iso-8859-1?Q?wHC6DahpZUyB/V/DOnDQvUWf026atL4pL0XwKzCtLxIAwaub0zsIIgjtkB?=
 =?iso-8859-1?Q?0entTCkE88ZW54kNFkSNwRNutuguIOuW2wKb3cTZn3KTbyBkoKTTKjszgI?=
 =?iso-8859-1?Q?hOzazoeHCwBzssjNZxwtEaC1pJWaF/HyFlclAzJzT2NZdIzlkasOz9z6Lo?=
 =?iso-8859-1?Q?pZe9IA2wGBtF/NofMQxY9bLOiw+usoio3Vrkkl7JDR1cuZAYZOWSIWQCrm?=
 =?iso-8859-1?Q?3PxL8hxIw8xdQl+fdH6gesJIeEgqFsjeJpAzoFSrUENmHSpKh2z9/4Kahe?=
 =?iso-8859-1?Q?t+XFXyCUM0s7d93Jvp/Cxg5t4XXM4XHTJ3iyUYBjwmcB6/W1erzs9r95uu?=
 =?iso-8859-1?Q?b1KblBCAzzVgITLOJFrojTgzpwhE160qK4nNqs/6cpVv/78mhmiimWnM0C?=
 =?iso-8859-1?Q?i9HOmYoqmoXYkUowMP3ngtNpVCJO0p3fjju0Ym5SYecsu9DGgOvK+LJz2Q?=
 =?iso-8859-1?Q?P5Dh49Qabw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab78e29-6324-42f8-2c2a-08da4d4c62b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 14:52:49.5124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+0rNgHF8Wcuq7sT2kvBfL7J7Babodgs4x81SpputP8e90nClJ8fVSAXPpMvjVNa724Ho+qrLlp8wDRyAoLdYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2522
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
 HaoPing \(Alan\)" <HaoPing.Liu@amd.com>,
 =?iso-8859-1?Q?Michel_D=E4nzer?= <michel.daenzer@mailbox.org>, "Li, Sun
 peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz, 
 Hamza" <Hamza.Mahfooz@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Clark,
 Felipe" <Felipe.Clark@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

+@Clark, Felipe

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: June 13, 2022 10:34 AM
To: Vanzylldejong, Harry <Harry.Vanzylldejong@amd.com>
Cc: VURDIGERENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>; Michel D=
=E4nzer <michel.daenzer@mailbox.org>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com=
>; amd-gfx@lists.freedesktop.org; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.=
com>; Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; Li, Sun peng (Leo) <Sunpen=
g.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Li=
llian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com=
>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Zuo,=
 Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; L=
in, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.co=
m>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.K=
otarac@amd.com>
Subject: Re: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock s=
witching in games

It should be noted that FAMS is an additional feature to enable mclk switch=
ing in more marginal cases than would normally be possible.

Alex

On Mon, Jun 13, 2022 at 9:32 AM Vanzylldejong, Harry <Harry.Vanzylldejong@a=
md.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Chandan,
>
> When using Firmware Assisted Memory clock Switching (FAMS), when the
> memory clock is switched the frame rate is dropped for at least 1 frame, =
sometimes 2-3 frames to make the V-Blank long enough to handle the period w=
here the GDDR6 memory is unavailable when the memory clock switches.
> This drop may be noticeable by gamers, especially if the memory clock
> wants to change it's clock rate several times a second, which is what we =
observed just on the desktop.
> To guarantee best game performance, we disable FAMS during game play.
>
> Harry
>
>
> -----Original Message-----
> From: VURDIGERENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>
> Sent: June 13, 2022 8:42 AM
> To: Michel D=E4nzer <michel.daenzer@mailbox.org>; Mahfooz, Hamza
> <Hamza.Mahfooz@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Liu, HaoPing (Alan)
> <HaoPing.Liu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Lakha,
> Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Zhuo, Qingqing (Lillian)
> <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>;
> Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>;
> Zuo, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>; Vanzylldejong, Harry
> <Harry.Vanzylldejong@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>;
> Wentland, Harry <Harry.Wentland@amd.com>; Gutierrez, Agustin
> <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
> Subject: RE: [PATCH 20/23] drm/amd/display: Disables dynamic memory
> clock switching in games
>
> Hi,
>
> Can you please elaborate on why dynamic memory clock switching can affect=
 Game performance?
>
> BR,
> Chandan V N
>
>
> >On 2022-06-10 22:52, Hamza Mahfooz wrote:
> >> From: Harry VanZyllDeJong <harry.vanzylldejong@amd.com>
> >>
> >> [WHY]
> >> Game performace may be affected if dynamic memory clock switching
> >> is enabled while playing games.
> >>
> >> [HOW]
> >> Propagate the vrr active state to dirty bit so that on mode set it
> >> disables dynamic memory clock switching.
> >
> >So dynamic memory clock switching will be disabled whenever VRR is enabl=
ed?
> >
> >Note that there is ongoing discussion about how Wayland compositors coul=
d usefully keep VRR enabled all the time, as opposed to only while >there's=
 a fullscreen application like a game. So "VRR is enabled" likely won't be =
equivalent to "game is running" in the long term.
> >
> >
> --
> Earthling Michel D=E4nzer            |                  https://nam11.saf=
elinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=
=3D05%7C01%7CHarry.Vanzylldejong%40amd.com%7Cf91798912ad54c6e4ab808da4d49d3=
4e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637907276721240575%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DN9TpPbl5KEIYAR5hhPKeiT0VZQ31SYxa2XottQr=
StfU%3D&amp;reserved=3D0
> Libre software enthusiast          |         Mesa and Xwayland developer
