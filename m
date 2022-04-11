Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A971C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 13:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243DA10E6FC;
	Mon, 11 Apr 2022 13:26:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 404B310E6FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 13:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuvAb7HkoIQWfOuPvPiGdPOdrgQzALZ7zTtMdWUftLB3psNXzf5DG/kugC7lDy9pBYHwGRTiyLrLe+M7RSbNYRhwhoqLBHbTX8cobHfyC8ZWbdBhSaltQBPbPHVEEwAD6qgeiUKY92DKKGQCG3VKjLl+FmotaC0M+W3VP13r3azIweQvLzaD3mB3etJ4GzYndq+fOExsAHBC7ElLzKtQlpj4IZG4IJnD2g82Q5Ak85+Z0rrDzJz0cfr7Wq/SkNwzlyD0n62htlIYIyXTZRVHXKPVMhcpZGpWPFUUEoKjF3M6VzeNUd5BuFItBKcIrVxjWLQ4fZNr8JUo4EeRiEAkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPFLUDlia7HiBeMRyfK5CUXuFY61/BmEf/xN0I+Jdwo=;
 b=nbtkK92uF8crULD0OG4615fSCZ0NFTqYRjQfu4DMhGtZ6aNCKE4P8XFPHkbF1eBFHVgBhhnhJ4N8pyUXWXy81xK3zoen7o4q+5kZt0/Zp/EpnY012alQMg33idpyaS/eL46V3s5bZAMeT8r8Y+/lkGpA5uX4b5nCxH5ecf/xe8UC/yr9new6Z0xOgsgzw/WeU68O/uaZ7YMWlEXBQ7XjmPTlX2J77RITiKijA3ffSJfiNz/wcnBgP+5/JcqmYeYMPC/RsjECtRNtECmMQLcL7B3wZE4JEecuUhQRZTmMAwU9yPUkYvBfg6Qh+Ck5yw9WTT1ii5ilHitzveiyrhLqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPFLUDlia7HiBeMRyfK5CUXuFY61/BmEf/xN0I+Jdwo=;
 b=VOrtw8Y2w/EwXr0QwTnehZl4SlBJH5gVNZu/JX1RJxJjJdgJ8KnWMlVRfaLe+RdOG2eABxhqfQtGmVObdR+j1v+mCN9/XA6N9qQloU2OvSNW3xob894dZCpOjn48/lcrtijgZbS3ulRkAXEYcb47yfksgCMBvBvkl7xpYOnNY64=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 13:26:14 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::d145:13bb:e6b8:3429]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::d145:13bb:e6b8:3429%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 13:26:14 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Kotarac, Pavle" <Pavle.Kotarac@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: DC Patches Apri 6, 2022
Thread-Topic: DC Patches Apri 6, 2022
Thread-Index: AQHYS23C8qjtUzQW3kGekN1w+qrHgKzquFDA
Date: Mon, 11 Apr 2022 13:26:14 +0000
Message-ID: <DM6PR12MB35294D12E0A5BB04838A41A39CEA9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-11T13:26:09Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2c0d898b-adff-437b-84c0-2767446fcae8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-11T13:26:09Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 5c6dd7f2-bbdd-4375-8fa6-8ac456bb3353
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa5ee01f-962c-4d97-8943-08da1bbeda58
x-ms-traffictypediagnostic: PH7PR12MB5855:EE_
x-microsoft-antispam-prvs: <PH7PR12MB58555803A9AD6B6E351577BC9CEA9@PH7PR12MB5855.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iQmzn4vXzezYOsAHaS6rdFiTiuCeznHEfBsoyF3M0twS2o4doqIsHCHovTQvsB78vJD8dVDTvnqLX5qKBWJJh75uHM7gaXnqkKuYwUYfRpf4pEugubS/5jUPHzafg7XQqGs8L60IL6JQgW8dDG3oj1pzuTC9FgZPK2rgpARumMqbvxsFlH/pVnZ2F4a6RfbRffi4EfV04a27EwD9065adaeIWlxh7H1niRtU7Q4VX3acy1+tS+38cc40AP1p+RIRUZbdOaQkSjh+bmao0NDCaP/76E29ujfg1fEdUeHv82JKCl+j/yoaAZ/9BhEw7eWKSaMs03ATcSOEm+iVJoMVhtChFOPW9WuV3MFMc4y3E/MS6eR8OBs85SYfTtSfYeZi/4pAH8h8kkFssPGM1IeUtMQ05LdR+d2K9yaGytn60+2mMlu+lmdgg5IhkNa8wpPCvx+9XUSCv2C/oNvMOj2yjhZ2lymdbWn1G5ALmZp2XLYg/gLrPPATWxHgnPEHRhAk8jb5ZTo5Mbg3rWBoeRLJQZU/uc8FLLeYLVv9cJgp1FQMxRkoWvPOIPBOIYOGHZ7CrFfMIeNmPhwnzsw87eJSBEWkcigbvYqtcL0U75i41xgx0a0UtHN+tDGYDufBpkQIF1x6iRmdWpa0LbEYMP5eFdIADok7FdVFjmYyOTK+3qLKusaKOtX6pE3WVQF1l5LaabjDW1pLxgwoLcTCRuucgg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(66946007)(66556008)(66476007)(76116006)(83380400001)(8936002)(38100700002)(66446008)(8676002)(52536014)(54906003)(5660300002)(9686003)(64756008)(508600001)(4326008)(122000001)(55016003)(7696005)(186003)(6506007)(53546011)(86362001)(316002)(38070700005)(33656002)(110136005)(71200400001)(26005)(3480700007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uyRQWDuPpJThlWyWjkG3XhZgwnIye0sdUdRyIpTkK6pWX/2yfqi4fr77Hxbr?=
 =?us-ascii?Q?dggq4B+g9SGkSAnEII/Xjt0Zy1NAWPz5VLxUJVGmc/3dABBkV0COY8i7KYRU?=
 =?us-ascii?Q?7GF96eZxpB98tWtmAblk0Dk/VvOJ1/ePRPf3hCj7M+NqxLv4rj0sCX8tuC+S?=
 =?us-ascii?Q?GdX7JnDXsiGffPBvNnLw+dAjtjKONzozZoK5FXYuqbx5bRDgo5OY5LN86Yn5?=
 =?us-ascii?Q?h1Ax7otS3yx1dzmf8xxtw6G5xJ+Uh/a1N5Ux8+tK+Rj3Y60mHaF6vHeGQMWf?=
 =?us-ascii?Q?AkoJnPCM7tD8Rw1juLc7+Zg8/2NDHBnOua2SAPpUDCvvNsrzJk2auIkOkshM?=
 =?us-ascii?Q?wEScgmbXa+pvU9zJIc4hk7dvuB4jGOsEiuIBBOGqBSmvsjnSg2cc40u0NZNW?=
 =?us-ascii?Q?IfdFo7cYhrAxFWQW7Ki8U1Ghi6uL3cqL+ZhZuI/G8zctkWNh1OuehCrAuxzp?=
 =?us-ascii?Q?LWX9XorCVXxu0LK1JdyLnysulo4b6zHRK4vgKwgLt1Z2CuMXp81qm5AGDz7t?=
 =?us-ascii?Q?slylUGAnI3xze+qBh11LuTxlD/uT0wdPIvpbdbpOhZJu+WKDmv2YbbcJ7fZJ?=
 =?us-ascii?Q?s345scO5rPPe3T5iy+6ntsMPea/Zsl14IOjjouj2Ku+tFoi012eHZKMwlMh8?=
 =?us-ascii?Q?pw8q2amNK3UNWTgcIwhM6jOlxem5BkgdmcjCudAGKJs/eozVS7SnYEAgSCSt?=
 =?us-ascii?Q?jUpTj6VZBxazVs3WUDlNVEJABKkbrt4qqBvebBKhJhx+meJym317XN6FdMpd?=
 =?us-ascii?Q?zWDnXOzcML80Gb5NHW4A5+LNMYp4g8sHY7BoUq7j00+aUvIR38kHCDOuCjs+?=
 =?us-ascii?Q?ls4OvuVFBJzx69OdyZQ/i01L+AcZHfQ5OQzs86eLuoC9/aE111+qcKiBIj/7?=
 =?us-ascii?Q?PUpzlgORRzEnWpjJgIlunTX++M+EavoBpauOmluKOsY3T+WQ5U6CSYPkB6BR?=
 =?us-ascii?Q?GOB9XmWFyOYqPbFHxqdkri6dpq4yGc5LncOPp2JF702LQvj/1u/5J/PSj76T?=
 =?us-ascii?Q?WpcODVExV8CEwDeMFD/enz6jpoH2KlknHsQVtQ/azx46m8rRsSvrtIeBiWwW?=
 =?us-ascii?Q?lE1Cl/ouQbpaTPMT9V7cnVFAz1kKB3apvvEFi2sX6A0fLif9w1PlVBxpPydU?=
 =?us-ascii?Q?LmROuvdOjys1EqIsZkQB0WZVCwLsPoME6yJ2V/aKy9q73GpG3PnJ9o4lbHhi?=
 =?us-ascii?Q?/725S+Vds9yL8oAQjt5vlq6p7v+huDtmDn8I2UTcObadSlRsUCQnqGMIYbZR?=
 =?us-ascii?Q?+eMf89b+CWSr0kx90NjEJ+p8sp7h0zx5Vymg/Q/sg/wifsoscrKaRURucIZA?=
 =?us-ascii?Q?iiYaCl1TJKsaTJRbfTwHyWFjup6Koq2pJWXPToYeKJ3Gr3EcSPeaPalFA3ob?=
 =?us-ascii?Q?n9Jglcb35in5eVhJ2ZTuwdJPVDWuENLpQ5Hav651YJmZ+Rntp5H0HNUtwQa/?=
 =?us-ascii?Q?mfUxslUZDwNBsnC11il8sWQzR31SQXzyZBD8406tzsp8fwgBj7OON15lAX3l?=
 =?us-ascii?Q?YjWP5KXNPDd6KM63ZEmtqTMhYzotmPti6cb0aU6FD0hyjCLJ7r87LMWrcrLF?=
 =?us-ascii?Q?RNCST+goUqEjUs8tGYUbBGDL0d59rvO85NJqU1gdraZgSyU1iJRYWjtds/4a?=
 =?us-ascii?Q?Y+9czEDQfzYDy4636o8NrnX33jUQrPAC/hCsis9rinSzr6f1bg0iJbFAJN/Q?=
 =?us-ascii?Q?ds2uZCurUMdsvbs6VJrsiYrFaF0bNy/dTIo49Nit0PHdGNy2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5ee01f-962c-4d97-8943-08da1bbeda58
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 13:26:14.5130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6MQRqE20i44plVxwAoRQVU7hb9/RH3Rgc/HoqXsiAJRcZkEYtevrTvY2a4vzsZlmhpZRK/KAlAIvwtAkm7f7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
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
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
HP Envy 360, with Ryzen 5 4500U, with the following display types: eDP 1080=
p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI)=
, 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=20
Lenovo Thinkpad T14s Gen2 with AMD Ryzen 5 5650U, with the following displa=
y types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via =
USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=20
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=20
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=20
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz and DSC via =
USB-C to DP DSC Hub with 3x 4k 60hz.
=20
Tested on Ubuntu 20.04.3 with Kernel Version 5.16
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com =20

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Pavle Ko=
tarac
Sent: April 8, 2022 1:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pi=
llai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>;=
 Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agusti=
n.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: DC Patches Apri 6, 2022

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
   =20
    *Disabling Z10 on DCN31
    *Fix issue breaking 32bit Linux build
    *Fix inconsistent timestamp type
    *Add DCN30 support FEC init
    *Fix crash on setting VRR with no display connected
    *Disable FEC if DSC not supported for EDP
    *Add odm seamless boot support
    *Select correct DTO source
    *Power down hardware if timer not trigger


AMD\syerizvi (1):
  drm/amd/display: Disabling Z10 on DCN31

Angus Wang (1):
  drm/amd/display: Fix inconsistent timestamp type

Aric Cyr (1):
  drm/amd/display: 3.2.181

Charlene Liu (1):
  drm/amd/display: remove dtbclk_ss compensation for dcn316

David Zhang (1):
  drm/amd/display: implement shared PSR-SU sink validation helper

Dillon Varone (2):
  drm/amd/display: Add dtb clock to dc_clocks
  drm/amd/display: Select correct DTO source

Duncan Ma (1):
  drm/amd/display: Add odm seamless boot support

Eric Yang (1):
  drm/amd/display: undo clearing of z10 related function pointers

Evgenii Krasnikov (1):
  drm/amd/display: ensure PSR force_static flag can always be set

Harry VanZyllDeJong (1):
  drm/amd/display: Fix crash on setting VRR with no display connected

Hayden Goodfellow (1):
  drm/amd/display: Fix issue breaking 32bit Linux build

Iswara Nagulendran (1):
  drm/amd/display: Disable FEC if DSC not supported for EDP

Jingwen Zhu (1):
  drm/amd/display: add DCN30 support FEC init

Josip Pavic (1):
  drm/amd/display: do not wait for mpc idle if tg is disabled

Max Erenberg (1):
  drm/amd/display: Disallow entering PSR when panel is disconnected

Oliver Logush (2):
  drm/amd/display: Insert pulling smu busy status before sending another
    request
  drm/amd/display: Always update DPPCLK_DTO when clock increase

Paul Hsieh (1):
  drm/amd/display: Power down hardware if timer not trigger

hersen wu (1):
  drm/amd/display: expose skip_detection_link_training to debugfs

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 37 +++++++++  .../drm/amd/=
display/amdgpu_dm/amdgpu_dm_psr.c |  9 +-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  2 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |  3 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 17 +++-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  3 +
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  3 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 26 +++++-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 +++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 17 +++-  .../gpu/drm/amd/d=
isplay/dc/core/dc_resource.c | 82 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  2 +-  .../amd/display/dc/=
dcn10/dcn10_hw_sequencer.c | 40 +++++++--
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  6 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  5 --  .../gpu/drm/amd/dis=
play/dc/dcn31/dcn31_optc.c | 21 +++++  .../gpu/drm/amd/display/dc/dcn31/dcn=
31_optc.h |  2 +  .../drm/amd/display/dc/dcn31/dcn31_resource.c |  1 +  ...=
/amd/display/dc/inc/hw/timing_generator.h  |  2 +
 .../amd/display/modules/freesync/freesync.c   |  5 +-
 .../amd/display/modules/power/power_helpers.c | 38 +++++++++  .../amd/disp=
lay/modules/power/power_helpers.h |  1 +
 25 files changed, 285 insertions(+), 61 deletions(-)

--
2.32.0
