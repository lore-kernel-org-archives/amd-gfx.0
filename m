Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE24C4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 14:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A1110E1D3;
	Mon,  4 Dec 2023 14:32:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D2F410E1D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 14:31:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyZ9ktDEDfhUp3Oq471GM/fpjoiYEoZ0tULXwh6HSkxlwpAqdTvreWt0SVgTwn0Kn5BgTX9eT3jgXiQhrvcTBXPlec1EB1ULGbdlGU+JqwnVR9UOKBoIK8yEn7hZ9XLTqDE7APyLP52QzdPIGpUXxQXRqwccwQ8dDnLBNuEZvtOReEJ/RgZ9WrII4tuz0rHhSshrL49lB5hpWKJjnU0guSorh2tKXMJUyq+PBwhLmnEZTs9V96Y1VoH0UMlqpFbBs6sJ7TKZOXocDbE4iYqFxbvQC5KQDuMhzskECoWbYWwBmMEDnkHl+JK9WkNIz/pxcnwrjITGeiW+qgdNDL4MsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN/V0qXZ3fBM2uDh+TVfG+WY8eur5qXdatCKavfHi0c=;
 b=bvwpwF4fm9cnrWfBrszJfBmtifxxyWiEm80UR1u/uNY1gT1aOi5kQQwVVH65nqPjEXE/fSE+dV11Pkj8+oUn4RLUMtK+Rkhk7rZTX9BRLJVLpG63ez2Gtq/4fkcCcju7fo9p51xzDni950/tVagLc9K3PP2ZZNaJxZS4nS35cYYdE/aL16cEHD8/m4JbQGnYsWohmzIDAjtXoccWKtxpAAVjBvo3iJMLYNbi0lInvMzfOQSjGJcYpp7ijBga8szJV/WcrSoSVv4nNh5th5XKvbNxp5ztQtbshHFFSpXxCUiZ0C/e8knqCPK7uFUVLnDg9tvpr96xLoBt1p0QvpmpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN/V0qXZ3fBM2uDh+TVfG+WY8eur5qXdatCKavfHi0c=;
 b=EvviNdzMxXS76v1vkjgNH70yOcUhNX6vLjAs/Ik4ELIOrOmvkFlcbKv9AtpJ6SlLRFHYUTCkTjaorJ8b0Ij8w8EN9AriX7DvnHcdH2M2XCqWRn5ahH5tJqTcBUQ3zgO5mj+qfsoEt3rfWanXQAMSAhwKfbH10OBQbRE357NWZ6M=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 14:31:54 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7%7]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 14:31:54 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/47] DC Patches December 1, 2023
Thread-Topic: [PATCH 00/47] DC Patches December 1, 2023
Thread-Index: AQHaJFoxDN7LT5gvz0mU/8xYyCA2v7CZNC9w
Date: Mon, 4 Dec 2023 14:31:54 +0000
Message-ID: <DS0PR12MB6534B6B10A0645F66677FEA19C86A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c9e543b4-9264-40ae-aba5-2e67e932fb73;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-04T14:31:19Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH8PR12MB8607:EE_
x-ms-office365-filtering-correlation-id: a8ddb147-5e3f-4965-f03b-08dbf4d5c33f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3+Xh9OoS4v2mqzyh70whJ6n3yhE1lm6o5SyfToMmKBH2sXc6MYLlF/bNESmPp3wrplOFbdURSpUkACJo4mgBuXIXSRciaCYfe8JRNfI13aa40ClAFLU5qTw7K5p/nayusy+5d/BxfqwTgzUCzI3CvbHdKUw5d6qmlFfAgyYYs74fPzGeCEIOc6SA+R/kdPH5XVec6356X3LWucCSD1JkASebqAQP/pKbjsSFp92PnaOp6E6/76Azhc/hti0fKpyEelY04avsLHUTHz75vTeVC/eapJPm1u9GWeoU3XTaUiFleqHBshIQj/Zj1j/U4vAwMDSUCzE6EfXkZMw8rqW20BECfBdVdlz1qvFhybxAt+/g2ml0T0fK4O59sZKbQZJ3I0wC4Qs349KvjiPQapS9kpx4T26kan+mEMEyQ3klq0Yn8rxVzQ3nb34gvxLMReH3Ef96kXCMwsY45UvQZLqAjfu+yxuFgtiEQgX+d2dnRLmdGVS4t0FyElNoM77cTT8ml21rrhVv7qP+Hvhr/FsIWlozhkS6CGBp2e5LYgFi0EfbrBHgh98MS4zLOgMtyUSpyQbot/c0Wq2cYnFXiXGs8MwQotIUdjBlTufDMBciknK79rgs8Z0twlvNumKJNMX6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(122000001)(4326008)(8676002)(8936002)(9686003)(6506007)(7696005)(53546011)(55016003)(83380400001)(26005)(71200400001)(478600001)(66476007)(76116006)(66446008)(64756008)(66946007)(66556008)(54906003)(110136005)(316002)(33656002)(2906002)(41300700001)(38100700002)(38070700009)(52536014)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ifYfgnnIS74GHA+B+Ia/KuztXXjGYVWRinB9U/I+eBrROJSVaaj40xMGPN/F?=
 =?us-ascii?Q?MdG/DLESVsQJDtWT+WpzS0PSdPpuN/fYHMpY5niQZKE3HhAzfsVN2y/0/8QI?=
 =?us-ascii?Q?TwXDRni9ALrTMj3WhMfpZlZzOFqdJzEAU8NYT0P0p1q2bN/3j+q27qcT+HJN?=
 =?us-ascii?Q?MaLH+qyHjSsKHjF4u9EunV1UvLyFuY1kpUaEXxn5l22ELkn+FEsvvjXAsvbN?=
 =?us-ascii?Q?9QkbYP6d2DTfXlD+vuC84liOvJDZKz9zvTd8ZoRRGTHDXlg6KrsTK9/Pd0Dw?=
 =?us-ascii?Q?SxzpxaEFnkDSVpkDdG7Go9WHJkV34QOv9FZegFBXgdxzBPXixZZVoNRnZIfN?=
 =?us-ascii?Q?DoypL84s5lmSMuQ1lH6S7tR7Di8us7GybcY7cxgmfE7MCiZ40mzKE2WjfxbB?=
 =?us-ascii?Q?Kb6YYC61YFpA0ThsKMdPcsiOfG5FAGOSFPF3AFLD+0pT7ioylySEvcgp6n8q?=
 =?us-ascii?Q?YurlOKYZjKxAnOysFcTUZjvVKXrimJPLiB5TQMGhUBcKQsgPiWGHsG6GJUO1?=
 =?us-ascii?Q?JOk8GPJhXyo8BzbFPyW2msd0UywtarC1qT0gzfINmjVILg/Y6RAszIucRN89?=
 =?us-ascii?Q?86POx1u2v8m1mwPbA9TusDV2J9acxIsNMCw9RxxeT5w4BtvDtNf0JAhRkrQH?=
 =?us-ascii?Q?htcFFfBlK+1ekeCdGKYQ+dSLjE5iB/0nkA0uopWh1yJ98XADLSEfOpPHUoK9?=
 =?us-ascii?Q?xmI5Oe0xbVmJH5SA4NGGV/XrMnpLXQ4dwFXTlGCceNKuatzIDO8i88FFGgkZ?=
 =?us-ascii?Q?zGAXG2INVjB08lJbtB6PJgYGn8HsIdguZDp2QjdD9DJhCom2vTRcE1LvSddj?=
 =?us-ascii?Q?j1dbgK8Vd2lU/kgaPwn0grhqMtl1aoKe1SXNYk6EIPHj819FKZMxpK4xlT73?=
 =?us-ascii?Q?T1t6eLz6lbsCgqX+3O1Hhhw7dnXQqCs6sPruog2TpLT3EauoBf/vQvSrN8ng?=
 =?us-ascii?Q?2uFAXDdSTGA95buoFiCR/zCserePAHjiFrPdTDgMPHAielBk0hd0rJ7+Z4tw?=
 =?us-ascii?Q?qdhMZYXKBbIsJSh9gMX2x/aN7HqzKw16oM2u2q1wK4XMVk5oYirRUGffYroB?=
 =?us-ascii?Q?CrXzcIN8y3l6N5qyjfZKlPEFWJx7R3Gk4mg77CvMgr3wQ5HJbGBSpAHZmWG8?=
 =?us-ascii?Q?NSaeeDawHeWRGqQX9onOxMIaASlaEd5vRRAOc5Rrw4KiikmByVIGWAn0OJfZ?=
 =?us-ascii?Q?MWjDYzqW0hTTHivPisnI+6ZJIAywrfwhA3duxfs8U9e46EwZCFpp7y4OfysG?=
 =?us-ascii?Q?Ah1KmhuQHiMp75YpWdhGBNHjguUyxyvcXJfrCM8o3keO2v2yM73oGDp7Onhq?=
 =?us-ascii?Q?VTRDOZTqRB8qfukFKsHtAzQRq3ZwzombW/EkWx3lLPRoS41ol0LEzs5xpghw?=
 =?us-ascii?Q?bUMr4xDkzOX/6zjkoBOFxDlDyapnZmzp8UNPkzc3eyZeRhcSNS7ZE2lGCeJV?=
 =?us-ascii?Q?KjYJdmXH2KLxu7A5FIyLnLtmlGsYU1bxZA3ufHmUwik3Xyg8waFEMci2MggZ?=
 =?us-ascii?Q?IIG1cJy8Mvh4TB6A3Lv8D2DgUr7T1XNPHwHPTg+onpDJ+Z4hRsEkjjmdepvj?=
 =?us-ascii?Q?iuN5q4bWEGrFOyc5WgY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ddb147-5e3f-4965-f03b-08dbf4d5c33f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 14:31:54.3846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3X+0mLqz0xdyk5dEZSGoqZbhRMkzcgQsv4wLDdgDFxMOOb6oomCLrRfHRrJMPKcDEZKyD9/ZUn9Iih8ZA6aCzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
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
 Harry" <Harry.Wentland@amd.com>, "Zhuo, Lillian" <Qingqing.Zhuo@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz, 
 Hamza" <Hamza.Mahfooz@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 135=
b1ad12685 drm/amd/display: Promote DAL to 3.2.262) with new patches added o=
n top of it.

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
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Friday, December 1, 2023 8:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wheeler, Daniel <Daniel.Wheeler@amd.com>; Wentland, Harry <Harry.Wentla=
nd@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Lakha, Bhawanpreet <B=
hawanpreet.Lakha@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pi=
llai, Aurabindo <Aurabindo.Pillai@amd.com>; Zhuo, Lillian <Qingqing.Zhuo@am=
d.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang,=
 Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.c=
om>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Zuo, Jerry <Jerry.Zuo@=
amd.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
Subject: [PATCH 00/47] DC Patches December 1, 2023

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Enable writeback.
* Add multiple fixes for DML2 and DCN35.
* Introduce small code style adjustments.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira


Alex Hung (12):
  drm/amd/display: Avoid virtual stream encoder if not explicitly
    requested
  drm/amd/display: Initialize writeback connector
  drm/amd/display: Check writeback connectors in
    create_validate_stream_for_sink
  drm/amd/display: Hande writeback request from userspace
  drm/amd/display: Add writeback enable/disable in dc
  drm/amd/display: Fix writeback_info never got updated
  drm/amd/display: Validate hw_points_num before using it
  drm/amd/display: Fix writeback_info is not removed
  drm/amd/display: Add writeback enable field (wb_enabled)
  drm/amd/display: Setup for mmhubbub3_warmup_mcif with big buffer
  drm/amd/display: Add new set_fc_enable to struct dwbc_funcs
  drm/amd/display: Disable DWB frame capture to emulate oneshot

Alvin Lee (2):
  drm/amd/display: Optimize fast validation cases
  drm/amd/display: Use channel_width =3D 2 for vram table 3.0

Aric Cyr (1):
  drm/amd/display: 3.2.263

Charlene Liu (4):
  drm/amd/display: initialize all the dpm level's stutter latency
  drm/amd/display: insert drv-pmfw log + rollback to new context
  drm/amd/display: revert removing otg toggle w/a back when no active
    display
  drm/amd/display: keep domain24 power on if eDP not exist

Chris Park (1):
  drm/amd/display: Update BIOS FW info table revision

Daniel Miess (1):
  drm/amd/display: Add missing dcn35 RCO registers

Dennis Chan (1):
  drm/amd/display: Fix Replay Desync Error IRQ handler

Dillon Varone (1):
  drm/amd/display: Add dml2 copy functions

George Shen (1):
  drm/amd/display: Skip DPIA-specific DP LL automation flag for non-DPIA
    links

Harry Wentland (7):
  drm/amd/display: Skip entire amdgpu_dm build if !CONFIG_DRM_AMD_DC
  drm/amd/display: Create one virtual connector in DC
  drm/amd/display: Skip writeback connector when we get
    amdgpu_dm_connector
  drm/amd/display: Return drm_connector from
    find_first_crtc_matching_connector
  drm/amd/display: Use drm_connector in create_stream_for_sink
  drm/amd/display: Create amdgpu_dm_wb_connector
  drm/amd/display: Create fake sink and stream for writeback connector

Ilya Bakoulin (1):
  drm/amd/display: Fix MST PBN/X.Y value calculations

Ivan Lipski (1):
  drm/amd/display: Add monitor patch for specific eDP

Johnson Chen (1):
  drm/amd/display: Fix null pointer

Josip Pavic (1):
  drm/amd/display: Increase scratch buffer size

Krunoslav Kovac (1):
  drm/amd/display: Change dither policy for 10bpc to round

Lewis Huang (1):
  drm/amd/display: Pass pwrseq inst for backlight and ABM

Michael Strauss (1):
  drm/amd/display: Only enumerate top local sink as DP2 output

Nicholas Kazlauskas (1):
  drm/amd/display: Pass debug watermarks through to DCN35 DML2

Nicholas Susanto (1):
  drm/amd/display: Fix disable_otg_wa logic

Relja Vojvodic (2):
  drm/amd/display: Add ODM check during pipe split/merge validation
  drm/amd/display: Added delay to DPM log

Rodrigo Siqueira (2):
  drm/amd/display: Adjust code style
  drm/amd/display: Update code comment to be more accurate

Roman Li (1):
  drm/amd/display: Fix array-index-out-of-bounds in dml2

Wenjing Liu (1):
  drm/amd/display: add support for DTO genarated dscclk

Yihan Zhu (1):
  drm/amd/display: add MPC MCM 1D LUT clock gating programming

 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   4 +
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |  14 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 356 ++++++++++++++++--  ..=
./gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  10 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  22 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  | 215 +++++++++++  .../drm/a=
md/display/amdgpu_dm/amdgpu_dm_wb.h  |  36 ++
 .../drm/amd/display/dc/bios/bios_parser2.c    |  76 ++--
 .../drm/amd/display/dc/bios/command_table2.c  |  12 +-
 .../drm/amd/display/dc/bios/command_table2.h  |   2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  26 +-  .../display/dc/clk=
_mgr/dcn35/dcn35_clk_mgr.c  |  25 +-  .../amd/display/dc/clk_mgr/dcn35/dcn3=
5_smu.c  |  43 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  18 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  80 +++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  10 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |   8 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   7 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  32 ++  .../gpu/drm/amd/di=
splay/dc/dcn30/dcn30_dwb.c  |  23 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |   2 +
 .../drm/amd/display/dc/dcn30/dcn30_dwb_cm.c   |   3 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |   5 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |   3 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  26 ++  .../gpu/drm/amd/di=
splay/dc/dcn35/dcn35_dccg.c |  62 ++-  .../gpu/drm/amd/display/dc/dcn35/dcn=
35_dccg.h |  51 +++
 .../dc/dml/dcn30/display_mode_vba_30.c        |  29 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   3 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  19 +
 .../amd/display/dc/dml2/display_mode_core.c   |   6 +-
 .../display/dc/dml2/dml2_translation_helper.c |   4 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |  11 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  29 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   4 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  16 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  36 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   4 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  25 ++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  22 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |   4 +
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |   2 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  40 +-
 .../drm/amd/display/dc/link/link_factory.c    |  59 ++-
 .../dc/link/protocols/link_dp_irq_handler.c   |  18 +-
 .../dc/link/protocols/link_dp_training_dpia.c |   4 +-
 .../dc/resource/dcn10/dcn10_resource.c        |   5 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   2 +
 .../dc/resource/dcn32/dcn32_resource.h        |   2 +
 .../dc/resource/dcn35/dcn35_resource.c        |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  14 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   2 +-
 62 files changed, 1328 insertions(+), 240 deletions(-)  create mode 100644=
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h

--
2.42.0

