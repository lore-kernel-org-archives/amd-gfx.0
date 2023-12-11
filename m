Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B0EC4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 14:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CB010E10B;
	Mon, 11 Dec 2023 14:43:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A6610E10B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 14:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZYqvNgstX3AF6VqbEm89xfWSZSuQnveIf62he4GydjLdtUOmxKww0SffEfIHHfO9wOfeyzS8FbMOP9AZCAiRg53XXPndVjhx8WBHBpqDvI1lOQka9A01VYmFy4mDS8MKr++h/MBVvrRsGIvmayxq+Cz2GVes9g9ajOhNW1XbDHzp9oaWy55PSbcSvhzkS7auf7RYf+oZO8Jhv59agLUm98nQ80odhrn9KE+b7Rqf0CEdjc2DasUIgiH6D8DFfXVZx6+UBuOqr1Imc13nATpjvDHA/WFstUvHmdlPW7rr5pE51KPuTiYK0qytr0wDWKYSSNRJAvwCn7LEqfZaGM8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMrDD7zvmPInPSnfgHSKomMh51ypdtpmU3meyoxMRRc=;
 b=K3I3FAZ29YH2gs3tgNxRxV5UzpodDGlf3T6oZtvfdd/FsOch0aT6GlTe1KRm+h6NBwQN0zOKHfagY/L4xxr5oYTAo7TXPCLxYZ5PjAXA4eiyTRTYYz6YQeCcUmz4ZffPWKTnQatUS4AbdHvSZsJ80aSByu3GRzcPO16jPCK7Jvki6kZUEmx5clCI6cUMZhb00uq1j6fkcloTWfppJ4OFV4qAJoZD7expAtIdiW1NUCfvyaomO5SCRIPopIkaUTDLYo+NX81jN3Ab7f6U74+M/lFW02GIwW5kQ+OS4nnWxbUXN08KKDCEPekv1xbWNTj5X/2SqYmudw+McrLPzF7Log==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMrDD7zvmPInPSnfgHSKomMh51ypdtpmU3meyoxMRRc=;
 b=DFLjsOm96VWd/bOitv+ZQPEBNc29UbGyq7k5fAlii8W5v1Ah9mnin8Ri43xECEhYmwEjvkSIszPukLinokKvOR3Y7hDLkfNZSKPRtGwmRa0oTkfSHHNXtuSbDBWorbx1MpD63Xyz6BA4oSEQ33U3E7mZkoZunT7XZzbWEXQOiVk=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 14:42:55 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:42:55 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/13] DC Patches for Dec 11, 2023
Thread-Topic: [PATCH 00/13] DC Patches for Dec 11, 2023
Thread-Index: AQHaKH3EEtoD5uS8RUa+/f31Bq5SmbCkLxJg
Date: Mon, 11 Dec 2023 14:42:55 +0000
Message-ID: <DS0PR12MB65344F38E185B7DD4E32A4F29C8FA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=757bc7e9-83a3-48ee-93a5-c36047423aae;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-11T14:41:01Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH3PR12MB8234:EE_
x-ms-office365-filtering-correlation-id: 7f77bbed-0faa-426c-ee94-08dbfa577610
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m4XL2hiZfHWFMbHKIe1FPNDJqpQ9zxFOYZhOv/LecheeDjyfS+aqhNOAI/7HNZzt5oXfIhUSPfWe9iE1XnxeYKOEZtQoQJR8/Kjpg94YWlWe2I6aoMwUdzsSQmRS/1oKtkO9m3cER8x0cCWYuvO65Q/nrQJLqD1++G9c8HcIqWL7njrbOZvZTiaTBsRmY5R4k4QJ9EmvSXbVB3K9ovFkYgH0leiIFew+Ed/om9sKRuZdkOWXQZGQorDa6oj3uvg6HVBBGBzdYk/R0eyN+qSRbYVEyRkOErnNx02VrpvQPxEPP04/lxyW2wL81ReFT1tvICCeEegmdBD1Mc6TIZZxd2dKxVXT5Mvo7F+veswGHlopz3CSlVBH5DjNhUYLyqdR0rQd7hjJURFE/j1ab/LeBdTWEZzsHPT/4IDqiY1bivcmfLzRa0Ur6rzN3V1Kf352tU4TVRwEzpDS1r+2YaCfP48uZqv5/lh2gjJ7BZF1fUWuiZ5+myt/zLYEvY1law3peBU0aqFUHPrqCEYujuZPHnO8jAzMkeK7ea4f+W1fqr+/WsoQ4Seqav1K01Dkl/b31TinJ20kpQGBigh+xih5vGse6Ao/b/ec60Tt71hPDPB3QK8dD/36t3osCiy35mV8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(41300700001)(38100700002)(122000001)(110136005)(33656002)(86362001)(9686003)(26005)(478600001)(71200400001)(53546011)(6506007)(7696005)(83380400001)(4326008)(52536014)(5660300002)(316002)(76116006)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(38070700009)(8676002)(8936002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wS96RDYaY4eSRsOq5HkcVyXwg+OKyuLncRxax6Tq6xJSTIDu9w7c5P/G7UK/?=
 =?us-ascii?Q?GkNVJlqmD0SmHON9X7a5wk5ZTYK0cIToHBkB89xiNT66BLgabBBETfeKiqIs?=
 =?us-ascii?Q?oRiUtT+gAVLEclO3OUdmSOk+08IHGtqrQoyGxG0dnt3+1KVrW/xU2GS1+cGh?=
 =?us-ascii?Q?Qopl6xqrvCQrTIxl+qRRgOvXog0DggHy2FxJWpuec6AylPV4t+UzpsGWFWb5?=
 =?us-ascii?Q?eiw1CyJxAihKSX9lRJrJOofH7YWqpWIEiwFhd5pJZMjbWIcLSDdwdW7qufty?=
 =?us-ascii?Q?ByseZPlYm+5KmIwdHC5Y8/Lc+5TXhXtv1yKH0f7I/Ig0S645N9s3lOnsJXYo?=
 =?us-ascii?Q?WoNu2ode1l3HMtpXi/MiLCn1h70uNYHmUOGub/tXc0AjfokcSSWLrZTjIZ1t?=
 =?us-ascii?Q?xvCSaAt4bFMKYs6SRLErGX08Wnpynmjcp8sMXixU0GoRIN9wjxsStgy+sYU+?=
 =?us-ascii?Q?SsLG/++Nu6TbUWZpcLKW5KtFmyK8/eUaFxyMTOn2h/TtYMHlFbLrlI8dS/Ja?=
 =?us-ascii?Q?c5XnxRQws3QbuQZD2Ej81jE4Nv1GaKJ0ir74vyRwPbax8dK2RCp+yLsFQHYv?=
 =?us-ascii?Q?MSWoaJXn/dYJx1tu0oByyD7gW5eQWsJqRT3kV/ARyvE4QR1kLsJQAekKCpF1?=
 =?us-ascii?Q?tthRciGF1dF/jdGRsmiTOaiB9voK2SVMOPtsNA9qtjZqne4wuJkFyEmOFpnl?=
 =?us-ascii?Q?HsPSAB5m4XGRAtzugCioBbcdE/IYHzcTzWqhyLWY+/s05pANUvrSYfW/ylJN?=
 =?us-ascii?Q?usx+/Q2o19rv3OHV8YLT83dBjjqp+cVMeNa5EY3xYOz8noPGim3XKYDaPvZq?=
 =?us-ascii?Q?jDgNfb5ki3tBhRF1PxqMENaH7a3T2S5r5oDnX0j6emsE9cvoszIpOEjo/gLD?=
 =?us-ascii?Q?Lcvm7HialAS+zgkrE956L+9CQtIqLAQvdqZA9TqZGQfmn4TMntvJHt1Hq/kV?=
 =?us-ascii?Q?eyyu9qwf6KjlYTfeaveDQihwefllPrT9CCoQYxVd1v9N7yy0XPpyv1iM0S5U?=
 =?us-ascii?Q?eNpYS8g97d9i3uBJXS6hJIKFqyCuTDndPBx35a3AbA3ADBxnW/KR5cwSoBSv?=
 =?us-ascii?Q?yjoKCpHCeOBele14vEqJEIKDyfkWp9FrMgjokOpAM7aNZ5ZQ28aWJMBjysAp?=
 =?us-ascii?Q?PSIZzuaQgR0/ae8t4oU2w9IQVoOzHRQxXtwGQx4lkFUzFItMsnKsJhc1mhFJ?=
 =?us-ascii?Q?Oz4UWBOia7QwYZFACneFtVJM76v5vmSqQvEoziBKJkNSGlpFz5IppzK/hlZP?=
 =?us-ascii?Q?IV6x8knWfkAJn5J2oV0QxkE2TzAYL05Tz4uJs5CKQGAH634JHvz3ukpl4KbF?=
 =?us-ascii?Q?YByJ/FywyLUBbrmtNjJVPM0bRYhwASEscC+onyIsdW4k+lG18L5NXG/pKeF3?=
 =?us-ascii?Q?pcvv3LhngH+q0SVLEIpYygQr2+9JGZ+NAe3zvykbpDOWrjHm1sknoO2qIKa6?=
 =?us-ascii?Q?8OXKkIOwbsAe40An0s1thgNgEgWbsH2bOQ5ISlqny6HvbrVE2TeOA5om7Hnd?=
 =?us-ascii?Q?hVb7xSfDzXke4KuRs+Ah2xWQysPEGaCl6dqqAjxSY2KEttAMb9ftKWL7+LQY?=
 =?us-ascii?Q?4O4BANd9dmGQ+bSfiNA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f77bbed-0faa-426c-ee94-08dbfa577610
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 14:42:55.2951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /t803z1RagIC63MiGGDhN0zx/dtvI/P/PrqqeBXKKIq98OJn3d+iKbetCFI5UjgISZmYH/ExRQJ37GSMbdQHBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Chung,
 ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Wu, Hersen" <hersenxs.wu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,

This week this patchset was tested on the following systems:
        * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
        * MSI Gaming X Trio RX 6800
        * Gigabyte Gaming OC RX 7900 XTX

These systems were tested on the following display/connection types:
        * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120=
hz[6600U])
        * VGA and DVI (1680x1050 60hz [DP to VGA/DVI, USB-C to VGA/DVI])
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ, as th=
at is the max the adapter supports])

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - 93d=
e84df60bc71c5f0d95de84a71eb119b51afe1 -> drm/amdgpu: optimize the printing =
order of error data) with new patches added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, December 6, 2023 2:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Gutierrez, A=
gustin <Agustin.Gutierrez@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung=
@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>=
; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/13] DC Patches for Dec 11, 2023

This DC patchset brings improvements in multiple areas. In summary, we have=
:

Bug fixes for:
  * DCN35 power gating
  * P-state change, & prefetch logic
  * ABM
  * DP 2.1

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

=3D=3D=3D

Allen (1):
  drm/amd/display: Disable OPTC pg to match DC Hubp/dpp pg

Alvin Lee (2):
  drm/amd/display: For prefetch mode > 0, extend prefetch if possible
  drm/amd/display: Force p-state disallow if leaving no plane config

Aric Cyr (1):
  drm/amd/display: 3.2.264

Aurabindo Pillai (2):
  drm/amd/display: Use explicit size for types in DCCG's struct
    dp_dto_params
  drm/amd/display: trivial comment change

Charlene Liu (1):
  drm/amd/display: fix HW block PG sequence

Fangzhi Zuo (1):
  drm/amd/display: Populate dtbclk from bounding box

Joshua Aberback (1):
  drm/amd/display: Remove minor revision 5 until proper parser is ready

Michael Strauss (1):
  drm/amd/display: Revert DP2 MST hub triple display fix

Ran Shi (1):
  drm/amd/display: allow DP40 cables to do UHBR13.5

Sung Joon Kim (1):
  drm/amd/display: Exit from idle state before accessing HW data

Taimur Hassan (1):
  drm/amd/display: Revert "Fix conversions between bytes and KB"

 .../drm/amd/display/dc/bios/bios_parser2.c    |   2 -
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |   4 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |   3 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |   3 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  33 ++++-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   1 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  14 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  16 +--
 .../display/dc/dml2/dml2_translation_helper.c |   5 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   7 -
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  20 +++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 134 +++++++++++++-----
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   6 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   4 +-
 .../dc/link/protocols/link_dp_capability.c    |  14 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   1 +
 19 files changed, 195 insertions(+), 82 deletions(-)

--
2.39.2

