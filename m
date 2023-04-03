Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCDEC76196
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 13:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F78710E46D;
	Mon,  3 Apr 2023 13:17:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3776910E46D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 13:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtWEJdDfYdLAEGIs5n+vDdQ7ju2MlCgqKL04OOzx0AJeWe7d9XhhPXeZaD8Xzg9eMz5mXeOtvRK9sha7ATgQCmH1FjnpQsG8uJCyW5R+7fO4B+b97yadGwjqeQ1WlwGAi11EY+n48neoSEgAQuBYTIOjK0+K54dqTHii+0gINkmLLxU3gloM6Qfn3UDooplT98fmi6+lOfx59upMjaNKgnKCwvjjIyRK1j6lZwZ3cBKEeywRy5Gixm7rr8J4p3DaB9M0ixxFWRwShfqBAC3zugjSkNU2ld+/lTRiyPcHkpa3RjXBoWhDfNOYxpFNtQTIhHdbcrWvlXByQIhY3glYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie1Y1AeqsRzVZSOYp4bvs0FWNPjdvqlqyq0qfPIaiw8=;
 b=WlrHGsVYYcx0ZBbauTxzUuYckrnUyrZSy1C1+4v0slFqwQBkrbf+gzOa9AQecrb+/aF35ydSval+7ostoHoxySFTpBXdQ9vxbj7viqSrwDxKUVLzXS/TW6969d92ubnaejeQDFFNey864aM9cTzwIaBH+hKnexR0PCmFVMb1hGytK72KQ43ITlt9t8282b2n+LnZS+LKP/SENHB7sddkuq6rhemSDR0BDw/u3sLMRuCWi1TRPpjwNAFG+f1ILxugAthdsyzLPLfSId38sVbZthWFI3i/phMgnzEMiDhVgTL4STLaI+5Dyv5RpohQ/bY2oxxvQG3OjTULYxFj0TQu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie1Y1AeqsRzVZSOYp4bvs0FWNPjdvqlqyq0qfPIaiw8=;
 b=mb5qeZpUlwQG247F1xW6jm2yoAT4q9duiNngXaai4SvQXZkFJZ/bRqHBKkvvfaY4qANOOdWqtWJWWa17xjDUMOVjZJmSv/Zaikje/X+NOBiMuX5ARaokODmXTvXZmYQJAf6t8PKb3vNy3ogZt18z6cHxD/dNhgYHVcdY5TmLlu4=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.23; Mon, 3 Apr 2023 13:17:32 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::d28:1514:96a7:864e]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::d28:1514:96a7:864e%6]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 13:17:32 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/10] DC Patches Apr 3rd, 2023
Thread-Topic: [PATCH 00/10] DC Patches Apr 3rd, 2023
Thread-Index: AQHZYuXF87YYMry6iEeZQnf8i7nH068ZlxCg
Date: Mon, 3 Apr 2023 13:17:31 +0000
Message-ID: <DS0PR12MB65346823A78405D9BEB8F20D9C929@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
In-Reply-To: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-03T13:17:30Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8cd758b2-338a-4939-bc0c-bd3e977ce543;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-03T13:17:30Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5582bb7a-92b1-4e3c-b928-1b1f0f23f092
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CY5PR12MB6479:EE_
x-ms-office365-filtering-correlation-id: 730627bf-7dee-4d13-6666-08db3445c82f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWazozPaBv55djnry178EqVMc8vx6Y+0esMtTMw+z2Vky5ByYvuw4eku/Q7NE93newNlRf9c53FQJN+W3FXeXbsf9z9r+yUQ+sGfQ9TKYca2rnaWMvsNuCjuqo+/lMHgQ8vpwiHp3z2I4YUN7tMX4oZ54TH4HUYBi1mc5G8w++nSQHKsVlS8y9U/t2sKIDqLjS4IlYDm8BmL9i/BqUFYmlmd3JQpnZ2j8ggX3vk1hC4ghBc6/DktB2q58eIIUAm4bWbKWnYal2dc4B8u/prTlt2sEsCdDDOOxz5YWbHFaKvQidYo574pXguwoE+hS/5nBRA2ND1p0PQ8cWzzh/AvvXCQOv8J5VWQNtvHs44CXloaswuT+wfQfs6/gQ2PthvFMU4ROk7pb+AmRkI2rGB6kTqiPbkOgEcmMBaq0kp8sAjFVFOuR0WY5slGMDcTq2irMFnEtbyxOuJRXOs9dtw7HvESNWkXEOcPgTRKMwInvFu2IkEkzDO8lKndNU/BjfvPw7ZTReJSRuZOYL+7KUgeBdYGTqduga25kCZlp8CRLjO3bMNy2SjEbIN/KbjJZcdLm8u7G3mHnvFH/LsvjlqFLZILz2oEMiiJk4jiGD6KDBOdS/pssi6rhsG/XztI/MkC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(38070700005)(33656002)(86362001)(316002)(76116006)(41300700001)(110136005)(54906003)(4326008)(66476007)(66946007)(64756008)(8676002)(71200400001)(66446008)(7696005)(478600001)(55016003)(8936002)(52536014)(5660300002)(38100700002)(186003)(2906002)(122000001)(9686003)(6506007)(83380400001)(26005)(53546011)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5Z0uQG7MTzdluCj+3hQutE8RxHQqPeOQPp1vgB7nUZgMqj+nkpZAxWcKvn?=
 =?iso-8859-1?Q?tjMdDmXfN2336cB5LEHQdFdhdBMFx3Dvg3JRTCOs58XDexDMrpJSZMKnOD?=
 =?iso-8859-1?Q?233QPBSmVRP6NmHuf0Y1s5tEzRajtxGZ0c1awXvbUnd2GXml1kpQ6o1Xhr?=
 =?iso-8859-1?Q?9/Wyf8KZopoSezuFmIr642ejWtkSGROv99We/q42+E+JYiUcoYR7oyF8Aj?=
 =?iso-8859-1?Q?DobyewLylvoXHcm54+r1DMvBwb15VWwjx5Jfr2efriGV4ShhBklJMnwbA9?=
 =?iso-8859-1?Q?F/0QLhWx75qb3WAw2ZsY66RKxHlUFrqR9og0pFp50z+xfZ9Z36J7W7uIox?=
 =?iso-8859-1?Q?pPen9vHk2UGeqt2rZI3ZhuylFwE2hGWMRxPXxzUP/FgTEoltb1bqAjWpd9?=
 =?iso-8859-1?Q?dYil7eD0WxklA5egtsDnW+Y/wh+l6S5XybW8tarwbNWiJNdjS2C0qklcTJ?=
 =?iso-8859-1?Q?7wX3/HrPTa5OwqvQq3nDGHvA80r2oeUX36maglIzx/VtIj4oHajnAVLscG?=
 =?iso-8859-1?Q?eMoM+jQx2beI6eKtu22KTqlnGcirutoa0olYT2/NiJfirqroQuAzjZvMhX?=
 =?iso-8859-1?Q?oT2SHFdbYgkAO1504W119D2yt+io1O5BD5ccgiGDuYvY8YrtXNS6yqnXBu?=
 =?iso-8859-1?Q?OaknLPH3sQJf8VUnqSsFroPxjBk2f4HDOnAeTuXY4SMIfBl5m91iZpt/gh?=
 =?iso-8859-1?Q?EZUVoekOjB0yc/4R2bEjA6PBLn3cN1I0DbXUOGkFsBlLR/drsrTkxO4Z8k?=
 =?iso-8859-1?Q?bGdPn96MDFb9V3lnzdb96Fx5e3Z0K3vZiUjPhE0OywCbx53fp9k1lLMx/h?=
 =?iso-8859-1?Q?QgoWGp8pc4Ltamw8UPgWb52qN6KKW6819rVB4OoNBN1un7bGXysJgUBSCQ?=
 =?iso-8859-1?Q?E4U13PZizhIgWkTcgHxGFq7J4tfNJulKEGqHRSs+yiNLb1xOkcjF2Ws1pa?=
 =?iso-8859-1?Q?cqOwXYe6c1Ocz0J4ISFJ28Wvr2rC4NBilYtebC5Xfr/R62jeEgtVEvM4ml?=
 =?iso-8859-1?Q?VW9J1vAcgdjygcXdUfb1brXea9+LSRLlMbnpe3hxASgR5E9Kx7ccPXgchE?=
 =?iso-8859-1?Q?YxBgk4coPYwYDTx2YY/TZvBe9je3L0cHBXTyIOlFRm6H5jtR2z+joc4eVi?=
 =?iso-8859-1?Q?cKeCatRm8JRQKuklclIHRVXH5VCD0Rbu20dkfp6IN6nR7bvlS3CVY8Cxyg?=
 =?iso-8859-1?Q?EIPJk9EKejbqCiEdMxWLyDL4RRFiemiEzxsjnSy6xYS3b3icC/vcimv+5x?=
 =?iso-8859-1?Q?MKFLNF6w88ZlompFhza+YMW+JApYvBJ07ljo8g9Mb86Ol2NNxVMEhbsuTA?=
 =?iso-8859-1?Q?ia5dKRIOmjy4Kbo58L7a7KMx3gevqDeXxw5FBT20HEeXQtFWeOrWg2S3pz?=
 =?iso-8859-1?Q?48j2US52lrlntCnuNgqj2D327rnVjiFemXr4Lz7ofXSdx8wsi0LXWhfv3b?=
 =?iso-8859-1?Q?IeaTEi15q9Yibcj1LHZN8fKhsLxRIJ3Km8ykdf/cNaEqObh1Hf4tVUm46P?=
 =?iso-8859-1?Q?voCZJ2xS7VWsztXYTBItabulY1KAi0PMefidHPrn/n4sSF83oM/f/4BaAw?=
 =?iso-8859-1?Q?9Tu0EqUA71ijy3Ig717iiq3rO3oHIkf0V7CuTE48iZnNtJKFf7AAhiB+mX?=
 =?iso-8859-1?Q?spNN3H+Wm7a1c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730627bf-7dee-4d13-6666-08db3445c82f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 13:17:31.8862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nBanVOsPGnlQ80bZjEoAZdLdk2Bhbaa9/7d5brkrndueJp89tTVSi5cqmFFJm4grH6lvEDOBEbvti0dbREhYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
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
eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120hz[6600U])
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
The patchset consists of the amd-staging-drm-next branch (Head commit - 705=
a9d96f697 drm/amd/display: Promote DAL to 3.2.229) with new patches added o=
n top of it. This branch is used for both Ubuntu and Chrome OS testing (Chr=
omeOS on a bi-weekly basis).
=20
=20
Tested on Ubuntu 22.04.2
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
Thank you,

Dan Wheeler
Sr. Technologist=A0=A0|=A0=A0AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>=20
Sent: March 30, 2023 4:57 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/10] DC Patches Apr 3rd, 2023

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
- FW Release 0.0.161.0
- Improvements on FPO/FAMS
- Correction to DML calculation
- Fix to multiple clock related issues

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Alvin Lee (3):
  drm/amd/display: Clear FAMS flag if FAMS doesn't reduce vlevel
  drm/amd/display: Add FPO + VActive support
  drm/amd/display: On clock init, maintain DISPCLK freq

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.161.0

Aric Cyr (1):
  drm/amd/display: 3.2.230

Charlene Liu (1):
  drm/amd/display: add dscclk instance offset check

Hamza Mahfooz (1):
  drm/amd/display: prep work for root clock optimization enablement for
    DCN314

Michael Strauss (1):
  drm/amd/display: Improve robustness of FIXED_VS link training at DP1
    rates

Paul Hsieh (1):
  drm/amd/display: Correct DML calculation to follow HW SPEC

Zhikai Zhai (1):
  drm/amd/display: add scaler control for dcn32

 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  18 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  20 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |   8 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  18 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  28 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h   |  10 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  26 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   3 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   4 +
 .../display/dc/dcn32/dcn32_resource_helpers.c | 156 ++++++++
 .../amd/display/dc/dcn321/dcn321_resource.c   |   3 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |   2 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |   2 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  85 +++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   4 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   3 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   8 +-
 .../dc/link/protocols/link_dp_training.c      |   5 +-
 .../link_dp_training_fixed_vs_pe_retimer.c    | 378 +++++++++++++++++-
 .../link_dp_training_fixed_vs_pe_retimer.h    |   5 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  28 +-
 25 files changed, 807 insertions(+), 19 deletions(-)

--=20
2.34.1
