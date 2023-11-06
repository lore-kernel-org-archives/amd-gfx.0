Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44198C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 16:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26AA10E353;
	Mon,  6 Nov 2023 16:31:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1577610E353
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 16:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWA5j4SO+jsNFKwuC4ev6rKHjwv/AOJUpGR0DPMznMEQtYx/YOIBn+HHqsd/0HB1sVcWdQl23LJYLkoGwl90v+j9FOt65mnUEu/cFSIHx0Bg3NqR+e6TdnKGwtmUmMspHTRHRv7x7v9dkuxH2nNSFdgVhxZMmGu8zkIq4K/LTqzoArbROytUqqBz/fudPBi9UFayTfD+LeMt9LTEhknFX58GAr6l1h2D9CSEOXDaEmI/1VNY6HUz8ZefioFm4xwPFU7v55GBL0CYpHvMgMcpRMc7ZHQWIWJDRn5gqbjAqBXXueFCg0OYH8zZSmgf87sbc8Apv8qy7aOjwgkyAq2bdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boOGIOr3db2L2ABhDJe2D5w4mElty/TA3FmG/g/Pqb8=;
 b=iIW3dRWPk5N1kLkaAwsCEbm8zFlF1zI4HLxcmttj/Ps/lAuVg6Hom/PWR5WGvtHCykZ/SfbsDv6OgId/oIZ1jEx7J+X9TLun4CGYelk5s+gCiM9XgFFcET5AAIlmT2m8oU8YrgcsKyOEI0+yYAlOqCulqAfbofsaXmOEwgrZrAYQRGUvqm56wmkVQuMqCRys5sTVIHkwrGmETpk9dIjoj9KsQCwcdozcCXUnjcapHaD72mjyIyyYczaut2/cZCckHghQGCfd8xHf/yxz5hBoNl90cvL4X4ViHV/xvHTgZBXAWLLvANMIrFbOLXQX8sg9HtOQbdNHX+EPO8umMrTI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boOGIOr3db2L2ABhDJe2D5w4mElty/TA3FmG/g/Pqb8=;
 b=sAa2NBe3pt6AWuZbf3hoP1yakJHp55kb44WzT1/dpZ+K699gF4YPGyoWWzH9wAVd5KjNR+XliYiqURXfIvz5TECMTCmLZ08jQaVvty/NjCnwjKZsfsbQQoSpG8tykRuy0Un7gJiOq63mGJqG1vvTveq5IWFeh7imjfVD+3gQt1w=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Mon, 6 Nov 2023 16:30:56 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::99f9:4c15:bbdb:7932]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::99f9:4c15:bbdb:7932%2]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 16:30:55 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wu, Hersen" <hersenxs.wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/12] DC Patches October 30, 2023
Thread-Topic: [PATCH 00/12] DC Patches October 30, 2023
Thread-Index: AQHaDP88qKIGU9RHREaHksadRxkOpLBtgx8g
Date: Mon, 6 Nov 2023 16:30:55 +0000
Message-ID: <DS0PR12MB653452A9A6F319F213F343F09CAAA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e7297adf-9ec0-4ec5-bb78-7db9b498dbee;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-06T16:30:51Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CY8PR12MB7635:EE_
x-ms-office365-filtering-correlation-id: 979523de-1d9f-4c4e-db3c-08dbdee5c03b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gP0xcOjiuXAr0ga7HYOW98FmLRrosp7D9fuyYkq+gXVDP5CX8JmznXWh6Wu0aGYY1b8YQ+nAUDX2NGmA0RFQdfxFIXjeeyC8vnOYhmDZxZF3Dv9EZUT7Op60QMNL7m7e4vvRiUKm7PrRITmnvYKFE8pjfUxAcwbYCD1RycdAuzP0RcsvxEu0UuaDOQV+dww7nv2edOP80Fl19xWUJrSez//AgmzVgAudo8QfhPM7JV3bVofWgwdXRKnkGtEAZL7zk1+wsJqdcxPItBmWLBkYlj6l59lNlacOClXWkN6m0Hb/zcViYWCtVYR1NcMX93VCj4RHxXFecZizYjeYut74Q5iGiwXCzJojA7/TUHqc2j1r0GBcKgk5ZwY6+DyF037n/shrejzniJcQElCjTccXKbSzbSedNpDzXN/lSCdM9/jZUHZ4VnW7ulVETQKW9pkRHVcD65e7jm/ggVA/JSybp7VHaBVHZThMYnLQdycI0YGTgUmVsWZMTts/FVzrkR7vMMevc0sUVQ2SvUgtzzs5TT6Qu18zPsW0KHYt15rIyu+KPJLw3HdQWm2+C46cGcNPCwma6W4q3DVxy2O52FMXbFKtV3O3qMZlG4LYaIqosSkQdX4VEZx0r5XR/hUKWtlP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(9686003)(41300700001)(6506007)(7696005)(53546011)(71200400001)(316002)(52536014)(83380400001)(8936002)(8676002)(4326008)(76116006)(5660300002)(26005)(110136005)(66476007)(66446008)(54906003)(64756008)(66556008)(66946007)(38100700002)(122000001)(2906002)(86362001)(33656002)(55016003)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Sj3E1T9lenDuxM0ZzWlpId4mRMyH0twB5BpKDzuTsbXriyro7ayESJskKr?=
 =?iso-8859-1?Q?bzCHNN9ESrplNTNlUQfrDjFltrB9XtY2+XMrXJciv58omebhGMFHNXYGFX?=
 =?iso-8859-1?Q?o8ZPriCRjgZZ2ZExAQ30PHNruQvy87uehKaxbP0lDTy8DIJb6JT0B2TMd7?=
 =?iso-8859-1?Q?h9mt3E+od6lg7HFYgDyHDx/lBVDgUStpFFeR5bPV/CCjlxAovMjYtumH+i?=
 =?iso-8859-1?Q?ZD0z45gOl86dfgS9wZ5kgibqIblxo8MMGV8ncd+PQcLEQCok6xXBHKtM2h?=
 =?iso-8859-1?Q?xmut/xWDcejdTieiHQus88mvRuON0Rng7D8Ikhi7K7lUrOA9XGyOO9NncK?=
 =?iso-8859-1?Q?sOku7YBNA0CYHRWipLx2VjZgYf5NvahWFh8419kRL2tkrcK3AxES5z25LQ?=
 =?iso-8859-1?Q?WCvsKhj+Z2pJUzwDOpWcgVZ36gyFMbVXGZAzyFcExgiX2p1tGDoHG42HZb?=
 =?iso-8859-1?Q?RLj8w/YQmyz3TmjMEtAA/EmzaQ1D/2Hyg4x6JmRTdA8kyRGk3ZrwIL/SLM?=
 =?iso-8859-1?Q?uLATKfvBFfCiycarpehsdzLBCk+7Hedle0EGcNYuyovU/22GycAXBtEJT8?=
 =?iso-8859-1?Q?u1bx9UXNlApo+7nspUD8VrnCFnaLs+JeK4GQesAGJDlPFzxwRJYNotfOAh?=
 =?iso-8859-1?Q?VsCKGB7Wiz7DLNNS09ecch9wB4d1GAa57Vuk8HGuHopEVCNY2mrCaxM4LG?=
 =?iso-8859-1?Q?bVgkL69VmZkhA4QbTr/WILgOkvY3nQlS3g1yRcTYYsqPnDg42q1WkzBRnh?=
 =?iso-8859-1?Q?1OzYNtfyTQPLimzZT/ro+tY454cfxk81VI7dd9lBzfjql5BEcyZ2wh0mSr?=
 =?iso-8859-1?Q?9Fwj/hSOWLSr1ANNN6qO+YG2uNZHnLKQLvypxYQQv3K3gv1JLC2rQ+Bj5/?=
 =?iso-8859-1?Q?xoN2fhAV+9C8Knhme9L79KV4ySEIoX5XMD89F2vza9uqPfIad60zM+URZL?=
 =?iso-8859-1?Q?sGCDldMj+aTocoLqQdxZl5Issboqfy0QM1bn5wBqxdJZ++vjbiD9CetCgE?=
 =?iso-8859-1?Q?Z/ImukCR8KiQ+ipHHLSPpl5ksgu+XxOAENTNJXYEyOwkeorBNJuNTNPgXh?=
 =?iso-8859-1?Q?jYrUaa+r89VdG23SUyqXJDg13IMi4vz/fj/tYPxbeaMuv8cfRXoIcg7td6?=
 =?iso-8859-1?Q?v4MJN8b0XnO5x/9w1Sr4YlB+ycQiEsoYS7CeaozcZNEjWJZEUJ+t0w3ymy?=
 =?iso-8859-1?Q?cStjVoYN4xilh9OPytqFok/KMV4TB4ls/X50LLY/e3UZ0nOOYDmpOb4Sq1?=
 =?iso-8859-1?Q?WmCeAl7baMa9ULEcV4ylDxNB1TGntg4s0IJzovirKUPlYpfgj4yjqkOo0C?=
 =?iso-8859-1?Q?DZVq9Zlj20H1H2LFUYz7HobPfwwGdHyXLs6BD2HVBbloTF4gGP5ZPfsyYI?=
 =?iso-8859-1?Q?Zf+UrNgsMHtYqmxN1xVcPNKESKqHCYNZ0R5V3b2ipIp6g5uHHRRCUD1r1Z?=
 =?iso-8859-1?Q?/j+Aa4Jyh8or8zmMCtGO/sdz/Fx61QfWShPQpaNOQpaW+VkKxEKA9a4Iiv?=
 =?iso-8859-1?Q?ZtCoW+Ny2GqT8FPMc+lNWDmSrpLskH7kCSFG+By+3ud/VGgOVzn74D/72W?=
 =?iso-8859-1?Q?00xYLWlfbqoOoesbZ5XDduZVQ0sOTHJ8DbfckwpF460it/x7/D5Yo6WoLY?=
 =?iso-8859-1?Q?71cFBjJsMb53Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979523de-1d9f-4c4e-db3c-08dbdee5c03b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 16:30:55.6559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBY2QaBwMee5B44Y3lz4vQlwr1ljcKwiZy6qvTouciq9b7eko1JoK995fE7i/pLs2XX6MbXVFOPq/mPpzezHeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
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
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> Hi all,
>
> This week this patchset was tested on the following systems:
>          * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
>          * MSI Gaming X Trio RX 6800
>          * Gigabyte Gaming OC RX 7900 XTX
>
> These systems were tested on the following display/connection types:
>          * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 =
120hz[6600U])
>          * VGA and DVI (1680x1050 60hz [DP to VGA/DVI, USB-C to VGA/DVI])
>          * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Inclu=
des USB-C to DP/HDMI adapters])
>          * Thunderbolt (LG Ultrafine 5k)
>          * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displa=
ys)
>          * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 disp=
lays, and HP Hook G2 with 1 4k60 display)
>          * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
>          * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ,
> as that is the max the adapter supports])
>
> The testing is a mix of automated and manual tests. Manual testing includ=
es (but is not limited to):
>          * Changing display configurations and settings
>          * Benchmark testing
>          * Feature testing (Freesync, etc.)
>
> Automated testing includes (but is not limited to):
>          * Script testing (scripts to automate some of the manual checks)
>          * IGT testing
>
> The patchset consists of the amd-staging-drm-next branch (Head commit - 0=
1d1a1e1dddb drm/amd/display: 3.2.258) with new patches added on top of it.
>
> Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.
>
>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hersen W=
u
Sent: Wednesday, November 1, 2023 4:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chung, ChiaHsuan (Tom) <=
ChiaHsuan.Chung@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Siqueira=
, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Zuo, Je=
rry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Wu, =
Hersen <hersenxs.wu@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wentland, Har=
ry <Harry.Wentland@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>=
; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/12] DC Patches October 30, 2023

Title: DC Patches October 30, 2023

Start from:
  9379d9fc18582c69862dc25fb770ae2e102f29d6
  drm/amd/display: 3.2.258

Stopped at:
  0a6aa88e926196036c7cf9edb70924b659461617
  drm/amd/display: 3.2.259

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Enable DCN35 physymclk root clock gating
- Fix DP automation test pattern bug
- Disable OTG for mode switch from TMDS to FRL
- Refactor DML2
- Revert Fix handling duplicate planes on one stream
- Revert Enable DCN clock gating
- Implement cursor P-State allow for SubVP
- Save and restore mall state while switching from ODM to Subvp


Alvin Lee (1):
  drm/amd/display: For cursor P-State allow for SubVP

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.259

Chaitanya Dhere (1):
  drm/amd/display: Remove references to unused dml arch version

Daniel Miess (2):
  drm/amd/display: Revert Enable DCN clock gating
  drm/amd/display: Enable physymclk RCO

George Shen (1):
  drm/amd/display: Set stream's DP test pattern upon test request

Joshua Aberback (1):
  drm/amd/display: Remove unused duplicate register definition

Ovidiu Bunea (1):
  drm/amd/display: Disable OTG for mode timing switch on DCN35

Rodrigo Siqueira (1):
  drm/amd/display: Create optc.h file

Sung Joon Kim (2):
  drm/amd/display: Revert Fix handling duplicate planes on one stream
  drm/amd/display: Fix handling duplicate planes on one stream

Wenjing Liu (1):
  drm/amd/display: save and restore mall state when applying minimal
    transition

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |   2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  20 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |  15 --  .../gpu/drm/amd/di=
splay/dc/dcn10/dcn10_optc.h | 186 +--------------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |   6 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |  84 ++++---  .../drm/amd/d=
isplay/dc/dcn35/dcn35_pg_cntl.c  |  10 +-
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.h  |   1 +
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  22 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  16 +-
 .../amd/display/dc/dml2/dml2_internal_types.h |   1 -
 .../display/dc/dml2/dml2_translation_helper.c |  40 +---
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |  18 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  17 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  33 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   9 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  | 219 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |   2 +
 21 files changed, 380 insertions(+), 329 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/inc/hw/optc.h

--
2.25.1

