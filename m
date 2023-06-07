Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ADCC7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 17:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C9210E533;
	Wed,  7 Jun 2023 17:35:12 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637B410E533
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 17:35:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIV4MBJ/3+Lu50hH/BIV+473dH4EQN4+pVk3wiGbIUlCBhXQRJBusguOqA76+WHrqhLH3mXnxfUOM11RW3m84mVdtBZiGYzlYVGls55m3/iQaJNGPoIvrxOAS6nBUhZPe3BzxD3hvVVnqVWayIOX616HWgePQewfV/dZ70K975P/k6NjJLORn58eLLkJO87TpYBurX2qsje8YITofWyFE6q9WO8Qz7JLL3sbYpkACHafJeFRUYnObc4fBfvG5wpU7sI9pj9GwvpiseN6/yDbTT5vLWdQ49JmsFH2qygYYFfhy42HnhWG8u541Ko5PLLj6PgJfu3WkFJDR0bak9SRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNXxjhphGls73sPnkWvYqka0oX0xy7+0r2W7MYKVRiE=;
 b=SsU/lXvfsTtifpATQP7oCe/shawfOp0P9i0+zyAc1S7itgAgq9mp8n2m/+flC6gxQfWSPI8/ptjr304hI3sHrtMDb472TUxPbSi8NvUUruyqESXQG4VjvLnA1Gmbiny7+j4kt5VfzjiEz3rjEpXmj+dstnp6QgeRw1hegRk3ThdWdljTcUyLSVosvQQRSLFex6PRyyouhO+mhsHdoOzFL348w5m9WDWks4vioN1KHBtW9z0Yv5gYWDmIljZIznLutNXz7WnThaQHlVNehcbfh3w3X5E2BVqSJRgFkGBlTBhk26jiH7fOJMBJ+1xorJqNFRJIJyyclcPra584k6/MVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNXxjhphGls73sPnkWvYqka0oX0xy7+0r2W7MYKVRiE=;
 b=hRKBPYOLZmlVJr9EhVrUrNGx1GFmYbAm8KCmFM59kjkRWE0+B5AgqHbO9YV7kNe8Kmq/9hKLlJfFrjAOIMfIaubmT0YzjedsUZYOsbbnJYAMaNJEYrj/L34PrVaAmJjNzUDVQEBlTxio/Z/LaKq+zilEKYBROCg6hJvOxM/EqqA=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 17:35:07 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 17:35:07 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, "Zhuo, Qingqing
 (Lillian)" <Qingqing.Zhuo@amd.com>, "Chalmers, Wesley"
 <Wesley.Chalmers@amd.com>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
Thread-Topic: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
Thread-Index: AQHZmE+p2kFzkjFxL0CbkqT2G2DnrK9+CffjgAGIgQCAAAYZqg==
Date: Wed, 7 Jun 2023 17:35:07 +0000
Message-ID: <CH0PR12MB5284C88ABA0C45CD177F9C5B8B53A@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <bc662b83-f117-2f61-c580-086c3f404086@daenzer.net>
 <ec919f31-2f33-f085-dfdd-25360b5e082c@daenzer.net>
 <CH0PR12MB528496B026471110065187488B52A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <df1dde7c-f789-97eb-5b67-266bbb95c1e1@daenzer.net>
In-Reply-To: <df1dde7c-f789-97eb-5b67-266bbb95c1e1@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-07T17:35:06.306Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|CH3PR12MB8330:EE_
x-ms-office365-filtering-correlation-id: 5bf15b50-b03b-4089-760f-08db677d892a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GXatx97/HP95LQDn4Q5CqfcCppOpDLShAzWVUlMs4NfxFdMG0svbhIyrdh6ONKtNta0mV1xXNl6CeYbLBVV1LeDIy+vS5qx5a7E88D27Fo7TsEVvGNyEOy1vm0WGWi8M2A1kqCnD0nzs/p54mNNgJKzGl4wUd0Ih37+lZU80q2bX6KiUfFzT/ZArQvLVkSMO7ABx5OrX3FQpvRJXfVWBURgfmFzJdCF7o9d7GAU0VP6L8PEa8JSLQ7yzMW8pefXv7+nwedIKZgDegZBOkEqMXoln8RWjt/DUxv9acWQRYaqjv/ruFD7d9suDwVKEkcyR3UKYHoAMqXwBfmuSVgLKLwLBpDCWIVIN78yQd4myKt1TooEqwwnv1kthuB7MIPxSTUGSOJ5AJbumgeRZzf8dS52TQkQLWOwqoS8e6pB0VgSFpEqcJNFfHxJewtejB7j/Cn+t7BfT5l9af+BrmZFB6kA6Itg/pFQeCyPJgBVvcG6vfn0GxkTH+1oqd13N+TVx0h+QDQU+YBSBPneJnZQMQvCE7GvrzehgQSlbGf+2u/YkmMdAHYahyau258/yRs/zVxHAPGBpYHdG6I+Xj3GlqmIC9YMPkiNekwgwrsB1L4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199021)(86362001)(83380400001)(966005)(478600001)(110136005)(33656002)(55016003)(8936002)(8676002)(316002)(41300700001)(38070700005)(54906003)(64756008)(166002)(66476007)(76116006)(66556008)(66446008)(52536014)(66946007)(91956017)(38100700002)(6636002)(122000001)(5660300002)(4326008)(7696005)(2906002)(71200400001)(26005)(19627405001)(186003)(6506007)(9686003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?O7VArlv9XjDBzroyi9qVqvnPb4IfbOxSEjhTHKhqzlZ76RZVyoRq3oN7LW?=
 =?iso-8859-1?Q?odSyDmAKkUWaqAUUuPcN9qD0OGalvepwzOtP1ot2PysJPkzpz/lmYIuCce?=
 =?iso-8859-1?Q?Bj5dnIXt9fEOzx99grBnM54GHh6qCE42OeKCiORC9y6nhToNUCgj2e1d9w?=
 =?iso-8859-1?Q?JORDJ+no0Yd7x1iEkgzmI00OqKpTwthr+g6wRaLzasGqI12XOtYdd76Gh3?=
 =?iso-8859-1?Q?DUz7ExcqjEhcby7BjUzcBWVyk2RxNOm4YEI/1BiRkk0tZVU1P9s9YeB6oT?=
 =?iso-8859-1?Q?lU/zgDD2qJc/OK1YTvuqMekExlqLVkxHwMxIPcO3z5qB7AbTy7yBoFqQSm?=
 =?iso-8859-1?Q?YbDVCvLcw1XmFEXtqWpoiBMR+owH+opaQsNspxJX3VItRAwUrV5X+hIFmd?=
 =?iso-8859-1?Q?0kBuD4P978MfIePsJK9LMf+JSP5hovzgeRQibV3h5UVkxmDH8JVkzCsLn9?=
 =?iso-8859-1?Q?P7U6l30QzOp9lVJgk6oudWAzaLDTDPcnNUmjKcsvFKsCJOsLUfDnytA9pU?=
 =?iso-8859-1?Q?GBdFKEnUfvvcl4+g/0nyDcYPXAix2SxNWIZ+7aWwftgvoU+tS0Rf81ySSt?=
 =?iso-8859-1?Q?4FHy/nCM724OqERn6WrLk4mBUqHQWmdoit76zHAruJA1qLDRNpzy7iIcEB?=
 =?iso-8859-1?Q?FM6TcUOSmxsrvPOQWI/33XdgHyyeqC+qb8j0kHRkdGiqlnaGB8ahERekVI?=
 =?iso-8859-1?Q?SjxraPVDrWyLqYWOde3Pdw3czUcMJzyyFu277nXKFs6gYbZccJUPf93ydu?=
 =?iso-8859-1?Q?kslCy866bP8cPMNFMubemsffcdUbRzm7bRjs58KYyFcuDKWNZsV0Cgh+LA?=
 =?iso-8859-1?Q?r3i1/kZJSQvmieCpMQbJgRkoWVRJ0AcfWmO3VOIv77nGiuwoxxi4hF5Ruc?=
 =?iso-8859-1?Q?ONkpdIROoXuglEAo9XyuBYEZoE2dePWu02lHZ+kLPiUd5KpjZJMJpmnT9B?=
 =?iso-8859-1?Q?FUluzQXlXxKIfolRtTWxwoe5t9pbAsm63aiPK4lQ4DzKhUBIKxBAfknqtW?=
 =?iso-8859-1?Q?kOdRZ86tjBi2p+eZCSC6pS/alq05s3lK3M1zPZlkb5js+7t40RHyQGqgCW?=
 =?iso-8859-1?Q?JHpZJJzPsob/uGDHdEaXIS9o7TH34l17TqL/CZwc8bQhLHi6PxtGfcm/z9?=
 =?iso-8859-1?Q?5mfwElRwwKJloLXxqR78u0VYAta5EvELZiTW02SGwPUM32aAax9PmzUpJz?=
 =?iso-8859-1?Q?fuSn5E6FWr+eW3SnkddDODDT3xX5Qt2ItRwwoI5QaDHUixYDG3kjXSTu/W?=
 =?iso-8859-1?Q?1Y6izkc1oSUUuRkgFoRvsaqD3dAoCU1VR7MLrMxcsg1D1KtdZqDepYEOvQ?=
 =?iso-8859-1?Q?OKmp11ATnwn7R1vHLbqRu4jecW32T3IgKETFbFNW8VyLqSapyId5BK+iPc?=
 =?iso-8859-1?Q?BThD5MVDD8lNrmt/J+IhuCq8YJDQom2rhmVQl46ZgzmGwKMyF0Nn2hLdVa?=
 =?iso-8859-1?Q?+5ZGZeLgT490q3/YUqIYjsMGSI3dU/9/ahy6NX5mCYJrqQzenvCkkmU1pI?=
 =?iso-8859-1?Q?64xoyGjqi/kFrqPsrgOX+2fjHxtU7iLjAzi5xNkzicEgbSm0hVEOgcg5xg?=
 =?iso-8859-1?Q?VJ05mj3+H4B0IZUYcX3uYGpFDkl2RKF0044KUVfeuuYc2bWdGekRUy+1gm?=
 =?iso-8859-1?Q?Y6DzrGGTC6Lfs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284C88ABA0C45CD177F9C5B8B53ACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf15b50-b03b-4089-760f-08db677d892a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 17:35:07.2834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wjoP3gvNSo04RpfOICjxRTkocVU9K2I2DM+idz0w6zmZrWwcmHshdS9NpDU1JGhh6FZ/nV1T7Bb7XZZbhEMjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5284C88ABA0C45CD177F9C5B8B53ACH0PR12MB5284namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Thanks Michel.

Do you see the issue if you force disable FAMS?  The following diff should =
do:

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index f4ee4b3df596..475c16aab518 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -725,7 +725,8 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
        .dwb_fi_phase =3D -1, // -1 =3D disable,
        .dmub_command_table =3D true,
        .use_max_lb =3D true,
-       .exit_idle_opt_for_cursor_updates =3D true
+       .exit_idle_opt_for_cursor_updates =3D true,
+       .disable_fams=3Dtrue
 };

 static const struct dc_panel_config panel_config_defaults =3D {


--

Regards,
Jay
________________________________
From: Michel D=E4nzer <michel@daenzer.net>
Sent: Wednesday, June 7, 2023 1:00 PM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Zhuo, Qingqing (Lillian) =
<Qingqing.Zhuo@amd.com>; Chalmers, Wesley <Wesley.Chalmers@amd.com>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Siqueira, Rodrig=
o <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <=
Solomon.Chiu@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <=
Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>;=
 Kotarac, Pavle <Pavle.Kotarac@amd.com>; amd-gfx@lists.freedesktop.org <amd=
-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit

On 6/6/23 20:01, Pillai, Aurabindo wrote:
>
> I'm attaching another DMCUB firmware which has the bug fix for the hang w=
e saw at our end and some added tracing enabled.

Still runs into the newer hang when starting a KDE Plasma Wayland session.

Should I try this for starting the game without the program OTG patch as we=
ll?


> Could you please grab the dmesg with the following added to the kernel cm=
dline: "drm.debug=3D0x156 log_buf_len=3D20M" using stock gnome/kde when you=
 have all 3 patches merged ?
>
> Also attach the contents of /sys/kernel/debug/dri/0/amdgpu_dm_dmub_traceb=
uffer

Both files attached.


--
Earthling Michel D=E4nzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


--_000_CH0PR12MB5284C88ABA0C45CD177F9C5B8B53ACH0PR12MB5284namp_
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
Thanks Michel.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Do you see the issue if you force disable FAMS?&nbsp; The following diff sh=
ould do:<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
<div class=3D"ContentPasted0">index f4ee4b3df596..475c16aab518 100644</div>
<div class=3D"ContentPasted0">--- a/drivers/gpu/drm/amd/display/dc/dcn30/dc=
n30_resource.c</div>
<div class=3D"ContentPasted0">+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dc=
n30_resource.c</div>
<div class=3D"ContentPasted0">@@ -725,7 +725,8 @@ static const struct dc_de=
bug_options debug_defaults_drv =3D {</div>
<div class=3D"ContentPasted0">&nbsp; &nbsp; &nbsp; &nbsp; .dwb_fi_phase =3D=
 -1, // -1 =3D disable,</div>
<div class=3D"ContentPasted0">&nbsp; &nbsp; &nbsp; &nbsp; .dmub_command_tab=
le =3D true,</div>
<div class=3D"ContentPasted0">&nbsp; &nbsp; &nbsp; &nbsp; .use_max_lb =3D t=
rue,</div>
<div class=3D"ContentPasted0">- &nbsp; &nbsp; &nbsp; .exit_idle_opt_for_cur=
sor_updates =3D true</div>
<div class=3D"ContentPasted0">+ &nbsp; &nbsp; &nbsp; .exit_idle_opt_for_cur=
sor_updates =3D true,</div>
<div class=3D"ContentPasted0">+ &nbsp; &nbsp; &nbsp; .disable_fams=3Dtrue</=
div>
<div class=3D"ContentPasted0">&nbsp;};</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">&nbsp;static const struct dc_panel_config pan=
el_config_defaults =3D {</div>
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
ichel@daenzer.net&gt;<br>
<b>Sent:</b> Wednesday, June 7, 2023 1:00 PM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqi=
ng (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;; Chalmers, Wesley &lt;Wesley.Cha=
lmers@amd.com&gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Li, Sun pen=
g (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.=
com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roman &lt;=
Roman.Li@amd.com&gt;; Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Lin,
 Wayne &lt;Wayne.Lin@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@=
amd.com&gt;; Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Kotarac,=
 Pavle &lt;Pavle.Kotarac@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd=
-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe c=
ommit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 6/6/23 20:01, Pillai, Aurabindo wrote:<br>
&gt; <br>
&gt; I'm attaching another DMCUB firmware which has the bug fix for the han=
g we saw at our end and some added tracing enabled.<br>
<br>
Still runs into the newer hang when starting a KDE Plasma Wayland session.<=
br>
<br>
Should I try this for starting the game without the program OTG patch as we=
ll?<br>
<br>
<br>
&gt; Could you please grab the dmesg with the following added to the kernel=
 cmdline: &quot;drm.debug=3D0x156 log_buf_len=3D20M&quot; using stock gnome=
/kde when you have all 3 patches merged ?<br>
&gt; <br>
&gt; Also attach the contents of /sys/kernel/debug/dri/0/amdgpu_dm_dmub_tra=
cebuffer<br>
<br>
Both files attached.<br>
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

--_000_CH0PR12MB5284C88ABA0C45CD177F9C5B8B53ACH0PR12MB5284namp_--
