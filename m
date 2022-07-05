Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB12C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 13:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67FB2113B06;
	Tue,  5 Jul 2022 13:16:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56CCD113CFE
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 13:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgnRZVZRFmXwh/8T73yT65ms6L0ApF5r53xPFnUwo1S3gOh5vwMSwJhkC4Ig+LQdd4Nw1Epr6hAvMK4ctFQHSoJhjm8EGoteguhxrRUVi5zKzI+oWNHv3sM5dS9+sCaMGhx63NfTP9EFTq3Ggqie46YtQwKYiwnHkUBlzQ/NSRk/2YDhIfO6OI0xCCnTVwUeIs61wawb/rIJXWc5AbefiCwrYbfwpc6FT4CjoXOVOO4WGpzmpUENwanetuTmsefGUpFKE3wbJKpJv/CSryY+ys3bPWXOdiH5cMD+3SzOs/3hqnKF+Hf/JKH82QUzEtfH4dS51ttbIQQBcShWe21GMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJ+Rh2hojw9y+FRujuA7Mf3WuabcwJEOyusHCW930Fw=;
 b=Esvu74dXJiQGllkpFeuy2pigmCcS8debZUTj/irCLX/HEOHexmZdeb0QZwlyai428ZHtOC6TDWrSmWNpGkVNzLIW68xkGED+XyvckWkpLU3gAnZpvXQzZaEb2cSfwrqyyiDKwDYa/By6TLFmQTMyJ5/P9QuP8LTOzhMtuQPu8Ytm+LTb1q5xyvEqopB7HityYW7jAyy+aOYPGACjDS7+wl+ostJ27foo4ryPNVhfo9BBFR8WVIJpTqNz9486t71qDUn0BZ9+dDZ1vMD+qUMJ9B4j3FCbD6XT+aIkb6TCgQ7ufMOtze1RRsAfTuCc6rpFiuWPvQRUgUDx4k6YVoAIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJ+Rh2hojw9y+FRujuA7Mf3WuabcwJEOyusHCW930Fw=;
 b=jbGireDpAq+7VcYbTriSox9hagJU/I3osG2SwgwUkqbkobMsWKOcmzijqi1/kNWoL+gb6m6ULO8T+dSHWhqhE2rNJhxcd5D35F3R9DyVhyIBqbr10NiQnwXGMOoSQrB6xtgRGX5DdUhU9tMxGldifziCDUCKzS+7iQa5VKGIlfc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.20; Tue, 5 Jul 2022 13:16:02 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::a991:9d4a:9d8e:70d6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::a991:9d4a:9d8e:70d6%5]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 13:16:01 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/40] DC Patches Jun 30, 2022
Thread-Topic: [PATCH 00/40] DC Patches Jun 30, 2022
Thread-Index: AQHYjLWHGoFVq+zNpkGBZJPJfXr/1a1vyGHQ
Date: Tue, 5 Jul 2022 13:16:00 +0000
Message-ID: <DS0PR12MB65349F62AC414DBA9C0763289C819@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-05T13:15:56Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6cfa71ad-bd15-4580-8946-983cccbc9929;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-05T13:15:58Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 17dd0fb9-ea52-4397-a36e-d6312931fd88
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d09bd9c-f07d-4506-8c8d-08da5e88819a
x-ms-traffictypediagnostic: DM4PR12MB5914:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qNZCaK2IBrcSZ67Ur3JqRf/EKuHpUEEvq2mTDIUh1slit8q0Nuwzpao2+L8WYtH8IKGQHU3nghdJtw5gsh4CjOI64Da93Fz5UDyLm5xP+vWYSYT4Ri41DwUtGv8yMHUq/MQbIyb1r6lOT1rq7j5ilwAb/OTij9ttm6jNtCSQ8zmcDY0Ao7YLRYyUWNaeQ5VxuE1Chg5a39rscskMF/IVSH4Xf3IAg2t2Vxfn0cgvieB6W/oEPY30px/Pg6Btu1Dj9kCgIHYg+7j18o3UFfYkyaL8ICOZ/5/XOpqrEQNBTsL08VZptpgcruYkxQqhKtLNCFDqPGswck+umVQwSpAx0uu0egD3nRaYOpkV2axJBKJJh//S1/FjErryBHnHEWFry9aZNeu/qOUbymFEqX8/ErV9ooJvzaTZ2u7nW8O5iJriMjR9Txjydjj1bxhKLKg33eqDVi0s1jbaRLNluMv3EzlTI7RwdiPbK7locl9cmIP3Z6wXV+HVhZhRHiahXwXH5sVwyBDjY1LsVe5CgsTzPZWQQpMUgq25T11O1QLlixoB7g/fx3biEdghcfWsRnnTw2joO8qXSwe/Tl9naA4OVeJKtLJruwnWHbzUo27e7NbvROasSZhx5qE86Cr3jVcCqwYRQmNeTobkvqLiZxpwbnrJ87zP16fEUJzSzpQ7vAoyXF6ZPthSTTPImaBDxqZ7Am5HfttEglMGvCbRS+sIWxIxodJNx3ql/CWmpDjRgDV6sAtIamdxJla7Rdr9lAvjGnfx87znF+z9+wY5ciZMp9ESlFLp2vXi3Yhry3tFOW4qEpxQJgVX9YgsJMc7TV1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(30864003)(478600001)(5660300002)(52536014)(66446008)(54906003)(7696005)(8936002)(38070700005)(122000001)(110136005)(316002)(4326008)(33656002)(86362001)(66476007)(8676002)(66556008)(66946007)(71200400001)(64756008)(76116006)(55016003)(186003)(9686003)(53546011)(26005)(38100700002)(41300700001)(6506007)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c94tYJfy3mikovnHBnbj/FYnyjjjxoV+H6eu1E/fTL0Wl0dEs1FioMg+UdIY?=
 =?us-ascii?Q?hjUiqju/iOgPbKwq1hJBzg2+HNhjD6Iw2HSNwHWhfARCnkg5HGLHY7utLfpX?=
 =?us-ascii?Q?053Zjtiluma000gDh/Y5VU07+sFFDX3CYvXCm/8hIi1Khpq+2mmLO4sOmiPd?=
 =?us-ascii?Q?dMP9LMn4loXqO3BycAn4fUq6Gfw8FVijyEnPDEdKldqsIKxtLjc+nop69WGT?=
 =?us-ascii?Q?24/HRM5Y0mKVF5BmJyDAdjpHGpbKDCGBo/d0yKFU5o0GLIIsS7nXCyQHsBR5?=
 =?us-ascii?Q?zD8GVR1e8/GshnGraC9XB6ztUrupPAFxgg54I6C85Wk/KH7vhxp44yp9CH2/?=
 =?us-ascii?Q?eATrtdi34sWTHPw+POUuYZ2nNkMQjOidHM6wU4k5H12oXmQkFi68ZCISMaRV?=
 =?us-ascii?Q?xmfAcshmrsnxet4CInWrktuZD2yrGWLth5Zlz0S6J/xXIa28bBjEQbpvRb4E?=
 =?us-ascii?Q?y3vhieR0DeoI7sBk9bdPkYtFiesUsV3bACsAuoy7OXvnmXjRWkRbYbqqO4yw?=
 =?us-ascii?Q?ug7lZI423qBmpQp3ZXB/Jp3SpeND+oh6KLSrhd/b6LpvrMm3Cqv4t2HPnMDt?=
 =?us-ascii?Q?VGQkGaPyJ4d4CFM60Sir6I6Rm4w6Qc7n0XouxaFRGa1KIYwluMKPdvN3uI9i?=
 =?us-ascii?Q?lcEKvtblNrPToRGSoYuR8xuUljHdIPJceclyteuisA+Nq127tmIlRoEQe16x?=
 =?us-ascii?Q?nrnnfvhMr1sY4LYnXloSuWyV3fvIWtuMmK/vaowdhNVjiSJUD9YT/seoTAuw?=
 =?us-ascii?Q?Yc1BmJ97b0NHmnF+H0VhVNy+fWPkgRdgL85/CpP0pXI2nEygVnGtzIRzO5OY?=
 =?us-ascii?Q?5XGKdXfHaOIcbtaWRNCa1nUHd4lCDK1KbJQXPr26AOIV5Qer258gWzm3RVPW?=
 =?us-ascii?Q?LuAXsx7723VKbs1a80VkQ3Hi/arHhmTc+8IKcuKDnSzJeI7C7M45Be8C8ks8?=
 =?us-ascii?Q?Ata7NvEcW31cXc+z/mKdzg44+vb4NVrvRBYKuOJlQIh57XqMlFzM776iSrbv?=
 =?us-ascii?Q?mT9J9ohsykBnM/IoA1sFNAqdOF0ujWzvtML5y4iGu4pj1+YUqJhjn/AdxlwJ?=
 =?us-ascii?Q?XyUHFbqD03lIakgodZulpzOiKBt/CpfcTSgtVTSJerU1/P9E/Q5YoTdkgYA3?=
 =?us-ascii?Q?39EeZ+qZKKUjVqs/fHs7VStHgejfhiyJBcDcEqdFcyrPOtwOISVI+XfRzrUx?=
 =?us-ascii?Q?UYXXlajFdKC51FgQgYQYEFJq8oFC2/KR/mESpPBR/pkQsryIFgJLqhGndf2a?=
 =?us-ascii?Q?fBSXXYGc+Kq0lPUCpyKTuTSHpsFUsFLvurNflFHDJsR82Sde3u4w7TtSKXEM?=
 =?us-ascii?Q?uQDKD/IWK0k7+dCSQrhf1NF7K4teYOvxJfsmr3y9MZqxhAFep08AL4tcRazv?=
 =?us-ascii?Q?rOGrNeihGtKcGxKVh9bdGmZdE9xdpjix7a3Q27xbbAO/FhclEotURsJkzOLD?=
 =?us-ascii?Q?llrgB3qmCkOL0QkHBzcSdjmzBXAnFatNVWnpGW5XIz6ElRfO0UlnSb1g8vI/?=
 =?us-ascii?Q?KWArnuAJjQrL7qRJmHm8PFDYUuvEQmSqeDW8ES8uxrjFu5sNySSvtAlXoU0m?=
 =?us-ascii?Q?4X6d2ZSEcWgU5jSHL80=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d09bd9c-f07d-4506-8c8d-08da5e88819a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 13:16:00.8986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5fsOZZOeR0IMOCnAveU71RyN6fsFBDCR3TdQkybc4mLUelyh3CAc8M7WXwXxFtyu9mnj8IGZqiy1ByXZqn1vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
HP Envy 360, with Ryzen 5 4500U
Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U=20
Sapphire Pulse RX5700XT=20
Reference AMD RX6800
Engineering board with Ryzen 9 5900H
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [4500U, 5650U, 5900H])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
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
The patchset consists of the amd-staging-drm-next branch (Head commit - 14c=
e34dd0d7dc6fe5b030405bac074acf402e2e1) with new patches added on top of it.=
 This branch is used for both Ubuntu and Chrome OS testing (ChromeOS on a b=
i-weekly basis).

=20
Tested on Ubuntu 22.04 and Chrome OS
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
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>=20
Sent: June 30, 2022 3:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Zuo, Jerry <J=
erry.Zuo@amd.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Wheeler, Daniel =
<Daniel.Wheeler@amd.com>
Subject: [PATCH 00/40] DC Patches Jun 30, 2022

This DC patchset is a large one that brings improvements in multiple areas.=
 In summary, we highlight:

- Program ACP-related registers
- Fixes for DMUB, DPIA, PSR, and others
- Improvements in the pipe split
- Add SubVP code
- Add basic setup for FAMS support
- Improve BB capabilities

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Alan Liu (1):
  drm/amd/display: Program ACP related register

Alvin Lee (5):
  drm/amd/display: Add SubVP required code
  drm/amd/display: Change DET policy for MPO cases
  drm/amd/display: Make OPTC3 function accessible to other DCN
  drm/amd/display: Don't set dram clock change requirement for SubVP
  drm/amd/display: Maintain old audio programming sequence

Aric Cyr (1):
  drm/amd/display: 3.2.192

Chris Park (3):
  drm/amd/display: Switch to correct DTO on HDMI
  drm/amd/display: Indicate stream change on ODM change
  drm/amd/display: OVT Update on InfoFrame and Mode Management

Dmytro Laktyushkin (2):
  drm/amd/display: disable timing sync b/w odm halves
  drm/amd/display: disable otg toggle w/a on boot

Duncan Ma (1):
  drm/amd/display: Add flag to modify MST delay

Eric Bernstein (3):
  drm/amd/display: Add function to set pixels per cycle
  drm/amd/display: Update gpuvm_max_page_table_levels IP param
  drm/amd/display: Fix null timing generator resource

Evgenii Krasnikov (1):
  drm/amd/display: add an option to skip wait for HPD when powering on
    eDP panel

Fangzhi Zuo (1):
  drm/amd/display: Fix dmub soft hang for PSR 1

Hamza Mahfooz (2):
  drm/amd/display: enable PCON SST support for newer ASICs
  drm/amd/display: rename hdmi_frl_pcon_support

Harry Wentland (1):
  drm/amd/display: Move all linux includes into OS types

Jimmy Kizito (3):
  drm/amd/display: Maintain consistent mode of operation during encoder
    assignment
  drm/amd/display: Disable TBT3 DSC work around by default.
  drm/amd/display: Fix uninitialized variable.

Jun Lei (1):
  drm/amd/display: Extend soc BB capabilitiy

Martin Leung (2):
  drm/amd/display: Prepare for new interfaces
  drm/amd/display: guard for virtual calling destroy_link_encoders

Meenakshikumar Somasundaram (1):
  drm/amd/display: Remove configuration option for dpia hpd delay

Michael Strauss (1):
  drm/amd/display: Initialize lt_settings on instantiation

Nicholas Kazlauskas (4):
  drm/amd/display: Fix stream->link_enc unassigned during stream removal
  drm/amd/display: Guard against ddc_pin being NULL for AUX
  drm/amd/display: Remove incorrect ASSERT check for link_enc
  drm/amd/display: Guard against NULL link encoder in log hw state

Rodrigo Siqueira (6):
  drm/amd/display: Add missing registers for ACP
  drm/amd/display: Use two pixel per container for k1/k2 div
  drm/amd/display: Add basic infrastructure for enabling FAMS
  drm/amd/display: Add SubVP control lock
  drm/amd/display: Add minimal pipe split transition state
  drm/amd/display: Fix refresh rate issue on Club 3D

Samson Tam (1):
  drm/amd/display: Apply ODM 2:1 policy for single display configuration

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  10 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |  27 +-
 .../gpu/drm/amd/display/dc/basics/vector.c    |   2 -
 .../drm/amd/display/dc/bios/bios_parser2.c    |   2 -
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   6 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   7 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 384 +++++++++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   2 -
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   2 -
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   9 +-
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  58 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  32 +  .../gpu/drm/amd/dis=
play/dc/core/dc_resource.c |  32 +-
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c |   2 -
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   3 -
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   2 -
 drivers/gpu/drm/amd/display/dc/dc.h           |  27 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 416 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   4 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  24 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   5 +
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  13 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   8 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |   2 -
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   3 -
 .../gpu/drm/amd/display/dc/dce/dce_i2c_sw.c   |   2 -
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c  |   2 -
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   3 -
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c  |   2 -
 .../amd/display/dc/dce/dce_stream_encoder.c   |   5 +-
 .../amd/display/dc/dce/dce_stream_encoder.h   |  14 +-
 .../amd/display/dc/dce100/dce100_resource.c   |   2 -
 .../amd/display/dc/dce110/dce110_compressor.c |   3 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |  10 +-
 .../display/dc/dce110/dce110_opp_regamma_v.c  |   2 -
 .../amd/display/dc/dce110/dce110_resource.c   |   2 -
 .../display/dc/dce110/dce110_transform_v.c    |   2 -
 .../amd/display/dc/dce112/dce112_compressor.c |   3 -
 .../amd/display/dc/dce112/dce112_resource.c   |   2 -
 .../amd/display/dc/dce120/dce120_resource.c   |   2 -
 .../drm/amd/display/dc/dce80/dce80_resource.c |   2 -
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |   2 -
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_ipp.c  |   2 -
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   3 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |   2 -
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   2 -
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   5 +-
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  17 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  44 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  12 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   1 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   4 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.h       |   6 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  22 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  | 106 ++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   5 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 172 ++++-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |  14 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |   4 +
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |   8 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 245 ++++++-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  21 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  12 +-  .../gpu/drm/amd/di=
splay/dc/dcn32/dcn32_mpc.c  | 236 +++++-  .../gpu/drm/amd/display/dc/dcn32/=
dcn32_mpc.h  | 117 ++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 680 +++++++++++++-----  ..=
./drm/amd/display/dc/dcn32/dcn32_resource.h |  20 +-  .../display/dc/dcn32/=
dcn32_resource_helpers.c | 260 +++++++
 .../amd/display/dc/dcn321/dcn321_resource.c   | 522 ++++++++++----
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   6 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   2 +
 .../amd/display/dc/dml/display_mode_structs.h |   3 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   5 +-
 .../gpu/drm/amd/display/dc/gpio/gpio_base.c   |   2 -
 .../drm/amd/display/dc/gpio/gpio_service.c    |   2 -
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |   3 -
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   2 -
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c  |   2 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   5 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   6 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   7 +
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |   5 +
 .../dc/irq/dce110/irq_service_dce110.c        |   2 -
 .../dc/irq/dce120/irq_service_dce120.c        |   2 -
 .../display/dc/irq/dce80/irq_service_dce80.c  |   2 -
 .../display/dc/irq/dcn10/irq_service_dcn10.c  |   2 -
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |   2 -
 drivers/gpu/drm/amd/display/dc/os_types.h     |   5 +-
 .../display/dc/virtual/virtual_link_encoder.c |   2 -
 .../dc/virtual/virtual_stream_encoder.c       |   2 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 114 ++-
 .../amd/display/dmub/inc/dmub_subvp_state.h   | 160 +++++
 .../drm/amd/display/include/set_mode_types.h  |   8 +-
 .../amd/display/modules/color/color_gamma.c   |   3 -
 .../amd/display/modules/freesync/freesync.c   |   2 -
 .../include/asic_reg/dce/dce_6_0_sh_mask.h    |   2 +
 .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  |   2 +
 .../include/asic_reg/dcn/dcn_3_0_1_sh_mask.h  |   2 +
 .../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h  |   2 +
 .../include/asic_reg/dcn/dcn_3_0_3_sh_mask.h  |   2 +
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |   2 +
 113 files changed, 3502 insertions(+), 573 deletions(-)  create mode 10064=
4 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_subvp_state.h

--
2.25.1
