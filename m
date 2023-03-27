Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FB8C7619A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 13:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7987210E5C8;
	Mon, 27 Mar 2023 13:14:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A579C10E5A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 13:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFY3FwwPZ1Qk+95Pbbh/WUcrAjINiAt2EM2OpdiHHlxlyEJbTF0XXHawLDqESldmyp3X3hKE8DqBDxuBtv/8gh8K3TlvcfATT3z6mb4VJcbX4Kf0WxJoUM1C3yBLU/GJIMcpDVRzIXWIGECVGmerDTRLyAhnzNj6PrjV7CI81vyuklgcKm1qiKmuAhc0l9rKfvqTQH9HWWP7flz67AApwrz/fdu/lKp0idoENzF/xA3oQWr5fnBjYqigFga1vhOabCgwt28V7YtTlosdv6qmeLn9ai3KF8jUHw4UC6FCd592CPqgQK9MmLN2qyGjrnO3+ozSVSizavHqJbOPmUL6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tZroj6VcQjEbl+y9utOudpidYlANBw+pvuxt2ZORBw=;
 b=L8cRoI0/VLJrfMGTLD4/an8GIdTN5/M+1BUrcZC7JcITEavyXrWLiY37LSt5fPaslMR3QPifuoGVDQtrPwRR2haDBAVKn+OzHlxmpapDG8Busbm9mmzPraxu9lAjEX223MhXHbLYcvappdkGQbmPwHCpBfJln95JDRJKxsyK7WvTTDxpsLzbrHi27SzznhskQxQBE0W7MTClqsc8z9sphNXp+UcUg65m3vPdZpByr3XI/oA1XrejAjaofTWy4qYyxMzeuxo8VAyjlYUKk1PqqS5PHkiFF90x40NLDLMpvWRmky6QnRK7TqndHMZDWojYjOo9bkblg7SBRl1Kl6smZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tZroj6VcQjEbl+y9utOudpidYlANBw+pvuxt2ZORBw=;
 b=sLZmbcD8QRoH3bG9PriA4B2sv1TqC0duF8leK3WMCbUyHMGx6GTDR3PvZoNBkdSWyameedNZDvjZwQM2v+B7Z/7IBJ6OEhN5uGTXsdO70+o4/pcUYVQsAfMu4WjL3rX3j9YNaD0ZUDUs28clB84xReyCAXqdMuC/DDk1oguW8nc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Mon, 27 Mar 2023 13:14:04 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::d28:1514:96a7:864e]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::d28:1514:96a7:864e%5]) with mapi id 15.20.6222.030; Mon, 27 Mar 2023
 13:14:04 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/19] DC Patches Mar 27th, 2023
Thread-Topic: [PATCH 00/19] DC Patches Mar 27th, 2023
Thread-Index: AQHZXh0aSb8GSeWwN022+Q7FrMZQv68On3LQ
Date: Mon, 27 Mar 2023 13:14:04 +0000
Message-ID: <DS0PR12MB6534B933288DDA87E82D57249C8B9@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-27T13:14:01Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7712178a-a3b2-416a-bb1a-897fd7dcd886;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-27T13:14:01Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 7a24bb23-319b-4a99-b1a2-6464061fd3df
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SN7PR12MB7836:EE_
x-ms-office365-filtering-correlation-id: c387d1ff-3b0b-465a-8179-08db2ec5236c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l7K+wHoPOQVLQUxkFlGGnTbO8zSZwFiWrEJvBKccXxVOloP89nu4CSVUrJHkwcls1NwgcMpc5x77ezz1W40K0KSqqOFCz3kwCY5ABrJMQOXLOJTYOujg8qGuk6L0ay+B6A2V8GF+10ajDO4Dtk4TOrvQE5GTMT6zYa7TNXJ8YasbvuoCFK9d/PWh0jtskX2CJ/QAHgzd2Qj13E+ySfIj3oDebCgrDr28oVnEhoNpwZ/KiG2GPwdkY2kTJc4CdZXHWTeGJ6hutb8oNA+7bv2bU76XahpBkTuLv0pj2fBklxgT2BTMTn60R3XVVGyHYteAcMRDHE6ZKWkvQcO9dJU0coOdsDcgpta8f8Fb3IOLoCNPz301SvG8W1m/hPrOvt/wPbcM4hPWsibYn4UBKMz32DrwQBn5+07SOtoJ7Dpq6xxfGs8l3hd4FQOTuvIyslVjXF0p7M9ag3OZ9KcVYHx0dH2TBF+HWlZY74FkIDTszHFuahuluXc9kLmvn5TABF0y6Kbzbo/XBjKKD2Dsr7bL+6i3vgRvvvXaDUPQKLBlbjwKz1VFMt5jgTNoSeRFEloYpP/tIx8/zDjTtWbcqUSBso+5+AGDNhCYgR/22yZxWj4/UTfJYPWlZ2H4lNlmJ/u1Npo9CGK7oC3vnsXXd1gPUA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(86362001)(122000001)(38070700005)(6506007)(26005)(9686003)(53546011)(186003)(33656002)(83380400001)(52536014)(8936002)(5660300002)(41300700001)(71200400001)(55016003)(76116006)(7696005)(4326008)(54906003)(110136005)(2906002)(38100700002)(316002)(66556008)(8676002)(66946007)(64756008)(66476007)(66446008)(478600001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hFlOK8HBeK4b0CuLwtmILv6QAZ8uauv1Rgkxj5Pke8UsidHmSgTwhMSJQpGa?=
 =?us-ascii?Q?bMBg7GsdADCJTfQ8+jRWqkmndDzu2L6GdiQmrPGimXPrszdE7KyGVQ6v8v0z?=
 =?us-ascii?Q?jcJRkeUlyNzOl725SaQAu0omiEy4F1Jp/QLC1eP5w60dKLcng3RYBzp6IVL8?=
 =?us-ascii?Q?5T/1TR9nbpRNBLdkNmSyYtmPi8smnM4KUEg53Jtibud8hcj5ogXM4gSeayjX?=
 =?us-ascii?Q?K34Bd76dQzGXNGJ8PSeXL6vgnRVxeVwoyILbj/cRLS2SZlDhCdkWBZW/oSya?=
 =?us-ascii?Q?RKpFtjDTblAW6bShfWN9aUmsz+yvV+UD1934mqgnDzYTO28vuB0xIEAo3ADs?=
 =?us-ascii?Q?cxZNuXvxSR2LNOqNZyvR1z99i8e922eAMTjNaszDCav7ZdNs0+yA7niWj3Ts?=
 =?us-ascii?Q?xsZV3L8FMqwOhjzDyDKF3gN4PT+65Lg+/2+IQdzxV4+rD83DQrvgdrTS1vNv?=
 =?us-ascii?Q?/081+I7V76qXqa19uZILliKvt4XeanfRjmixEB85i+E9yvtGadtCKfIOU98f?=
 =?us-ascii?Q?Fd7wFn1QlzYS2zVRteYN0cQ4ljyE9lzUS+NA65RIb8+eep8Y7YsqhRC/dbhZ?=
 =?us-ascii?Q?7R1iflnGYjbmcl4bhJ3KDa2nxNW5sJQqeMGL4Q/2YsNxgAk93D02ECC/PYa5?=
 =?us-ascii?Q?8Kl5cpYulmvuRZMEaQXqAkvxs5S+nN7PMv5BQQlYQ+Kj3kjj4OC6YmSCtRgg?=
 =?us-ascii?Q?/VYYJEwVMqoLpmni32OXeeFVS9+3GlD19Vah+pK7mjXt33eJDI2INrKxKTpT?=
 =?us-ascii?Q?r78QUaP3s2fuUxMJekRTEyz1F9aC9DgU89N94UEUMG1RnfmdWaGn372M3T+C?=
 =?us-ascii?Q?tDSIbJS2KyU0BV0PnN1eMdabm1Bdb370ZxAeckNtEOzuxpo+9KDqi8OoAG+6?=
 =?us-ascii?Q?r+bb1q+u6jTVpRRpKfnkDGFLXn9dT0pRpOz3vnRNF0lKubQsH5llpCDSaDnp?=
 =?us-ascii?Q?a/NHpJWBMJ5NZjQGzD53tcOKnF34j4DH5rkhdh31QlrRR7yCoGeKfa/3/TEF?=
 =?us-ascii?Q?uhbtQeOLWfRyPn5mjNTH9tjGsgiIqW4RCvi1rkV6yyyvqU7yJNpGc/gHVPDn?=
 =?us-ascii?Q?fVDzvbnpQugLFJW2kiIYLGyE6dQRxqZooHK+MgQwGiszbUGGUIxaEk2gitLT?=
 =?us-ascii?Q?Tnzrri171tGarU3mNeHNDI0ShwD+Oj9C3wUHUQk+Yxx3F/Kdto1QCGv0cJFq?=
 =?us-ascii?Q?xNQg7dTnsi1TUHkiIK6ctotenqNNld6qAw+kyY+r300DN0FUOqpMtVuzlsuF?=
 =?us-ascii?Q?htN5wqMgHDjNNJNz801iyCq5R2hVisCZgsEi1GwDi8NNFdbF1Ny4FrqEmty4?=
 =?us-ascii?Q?LyiuLIGH3tYSJ0oPR2HgMcr1n8T0LSFcWZhKv9+6Bag42onQeakP5cX/Z/fd?=
 =?us-ascii?Q?1XE29JYksqOhpIrDYoCS2uuEny6ARfu3eeckxV7iW0PovsLRso/xHe2VK/4/?=
 =?us-ascii?Q?9w6OQGtF31sF+zACpypZHwSv2fp+ZlWX54vY+2MVWRQELq/N4VLzhdx/lcXb?=
 =?us-ascii?Q?gBoCX+G7+M9k2pDTqAnv4t8ZwCquW4Zdj8HE6fUiCBAOPrlRqmVjJ5WCzS22?=
 =?us-ascii?Q?hyzMspiSnOFBkoMrq38=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c387d1ff-3b0b-465a-8179-08db2ec5236c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 13:14:04.0698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUQHPLNh6yXacaxWoLCafoeVLPhSqKJHxrf01MA60iZpEPvywJlIncEiE77mGJs0XQVxfHJV3YTs7EGsBG8rfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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
The patchset consists of the amd-staging-drm-next branch (Head commit - a59=
f70678940 drm/amd/pm: enable TEMP_DEPENDENT_VMIN for navi1x) with new patch=
es added on top of it. This branch is used for both Ubuntu and Chrome OS te=
sting (ChromeOS on a bi-weekly basis).
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
1 Commerce Valley Dr

-----Original Message-----
From: Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>=20
Sent: March 24, 2023 2:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/19] DC Patches Mar 27th, 2023

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
- Enable FPO optimization
- Support for 6.75 GBps link rate
- Fixes to underflow, black screen and more

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Alvin Lee (6):
  drm/amd/display: Enable FPO for configs that could reduce vlevel
  drm/amd/display: Update FCLK change latency
  drm/amd/display: Use per pipe P-State force for FPO
  drm/amd/display: Only keep cursor p-state force for FPO
  drm/amd/display: Enable FPO optimization
  drm/amd/display: Uncomment assignments after HW headers are promoted

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.160.0

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.229

Artem Grishin (2):
  drm/amd/display: Add support for 6.75 GBps link rate
  drm/amd/display: Conditionally enable 6.75 GBps link rate

Ayush Gupta (1):
  drm/amd/display: fixed dcn30+ underflow issue

Charlene Liu (1):
  drm/amd/display: update dig enable sequence

Dmytro Laktyushkin (1):
  drm/amd/display: w/a for dcn315 inconsistent smu clock table

Martin Leung (1):
  drm/amd/display: fix double memory allocation

Nicholas Kazlauskas (2):
  drm/amd/display: Add NULL plane_state check for cursor disable logic
  drm/amd/display: Fix 4to1 MPC black screen with DPP RCO

Peichen Huang (1):
  drm/amd/display: skip ClearPayloadIdTable if device mst_en is 0

Qingqing Zhuo (1):
  drm/amd/display: Add infrastructure for enabling FAMS for DCN30

Taimur Hassan (1):
  drm/amd/display: Add 90Mhz to video_optimized_pixel_rates

 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  5 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 44 +++++++-------  drivers=
/gpu/drm/amd/display/dc/dc_dp_types.h  | 17 +++---
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  1 +  .../amd/display/dc/d=
cn10/dcn10_hw_sequencer.c | 16 +++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 18 +++++-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  3 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2 +  .../gpu/drm/amd/disp=
lay/dc/dcn31/dcn31_dccg.c | 13 +----
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  2 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   | 23 ++++++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  | 10 ++++  .../drm/amd/displ=
ay/dc/dcn314/dcn314_hwseq.h  |  2 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  1 +
 .../dc/dcn32/dcn32_dio_stream_encoder.c       | 10 ++--
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |  8 +++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c | 10 ++++  .../gpu/drm/amd/d=
isplay/dc/dcn32/dcn32_hubp.h |  2 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 49 ++++++++++------
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  2 +-  .../drm/amd/display=
/dc/dcn32/dcn32_resource.c |  1 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |  1 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 57 ++++++++++++++++---  ..=
./drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 33 +++++++----  drivers/gpu/d=
rm/amd/display/dc/inc/hw/dccg.h  | 28 +++++----  drivers/gpu/drm/amd/displa=
y/dc/inc/hw/hubp.h  |  1 +  .../amd/display/dc/inc/hw_sequencer_private.h |=
  6 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 16 ++++--
 .../dc/link/protocols/link_dp_capability.c    | 28 +++++++--
 .../dc/link/protocols/link_dp_training.c      |  3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 14 ++++-
 35 files changed, 319 insertions(+), 119 deletions(-)

--
2.34.1
