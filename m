Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EF1EE4996
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 13:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D532710E252;
	Mon, 21 Aug 2023 13:28:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72BE10E252
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 13:28:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJQ+0Mw8tm/ARwQSZnORlYz3taNcKzJ+ZsaYQjgtd3LA5F8ZcX4kumZmbRzbDGNf6E3KItwJR2LPV1ZSdLHXZqFuwbDGW4M3VnOFNmauRvp9h76/WTje/Ao7sb6/KptuRmkgS1vEIFqgXgT+OLI8qCFdkS9iWQ8kWgXkRYXib+fTecOOffn8lSntXI0xrDx7LJVye8OdRh7TfMjSSCEmfaXh8Rm8oWyf80vg+bKMwuLga7i6xOzQCi3f3KLqhtDo/2k18aAXn5o7smvxZZimqZ57aMOnQmOZeEgkabgnRkuV5tfVSuPISmgd2mqf0Vn0JL8SPVFSBkK3tMe/bJsGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpZMCwdldJIDuS4DzwsgR5vydnpjw7imk7naalgAj1M=;
 b=YMHQQq8I4WuuzdXbqdQz0u6RLP2vPhAdYIb+h81/3Z5y5wXdaFFIMEPEwPCAMEjwBa21BXR58swznMfibbjZb9/6PbQUkm/x0KbQunSJgpp/QRwbNolMq77/th3EcyOMoBw+VXBtvpxEFDo4B61TEJ1/Jb27INrXh0WFy3JY48VB8dimhONEbFGNuBLXzLnTW00LeTvHoScmxC2cjYnvPQX1FSQqyFgeywwM4v30NiSvh2wzY7oeAcYbv1E8fmKA8SEc/nFL1hvOcd9Mf6PAjyK2TBFDpJ4QBWX3CRxE3qHyuW2QC+Sq6O2mXjWsVYl+IQzHvrSfdEr+KImr4Mexzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpZMCwdldJIDuS4DzwsgR5vydnpjw7imk7naalgAj1M=;
 b=opRRL1WAKtQL4BY9jDe/4joQ3/lv+K0yNujnDvDQ0MMFOOfIneABA7ZWJ91Xz/Bo1EEt1B3DB40HyV0oPTsUD7oACX9AwifcAiJ8ht1vbFwquKb7+B9+/WkeTAvHl0wd8JjvA6JDMIzq34NzMRcA5YA/QRzsXCYqLhO94dVJnmg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Mon, 21 Aug 2023 13:28:39 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::fc6e:93c6:2283:ecdb]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::fc6e:93c6:2283:ecdb%4]) with mapi id 15.20.6678.031; Mon, 21 Aug 2023
 13:28:39 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/16] DC Patches August 18, 2023
Thread-Topic: [PATCH 00/16] DC Patches August 18, 2023
Thread-Index: AQHZ0AfmuRiLghIhzEecUVdRWraD/q/0xWbw
Date: Mon, 21 Aug 2023 13:28:39 +0000
Message-ID: <DS0PR12MB6534D35A81229F25A07804479C1EA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bbc1c7c2-8eee-4c63-a615-1a622a06cf01;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-21T13:28:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CY5PR12MB6274:EE_
x-ms-office365-filtering-correlation-id: fa99d22d-39ce-42f2-e939-08dba24a87cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0KWa8xw9qWZz51wBUuA6Z8aNhJqnQh2ymIkHuFg4QlOBFWYSXEwBZVyFN2SbMpxJaBYGRj6tNOBXrpTSgohoHZ9k9QYnjYr2Wi4Kl3mjzDwNmldJxcdnnGmLUoGmH8c+jSuO4ZaE8wS3HmTZXGBLVPPQKmTygJZ4NHc2gkEmMYhz+6vgDeMHqy7C5MgcWaSrbe0Qrs4Zd4EcA7g3FaG3rbMjkuPhBD92V6b1EVgBePAuOlcTr9/iXyORn0SaNtsTqEOx3GGbXoIfG6bImrSIJpCqchuXcyLQSv5lBGQfx2GCFo0ra3Q+U/KMK3iipIKWjpXYNYJdTdl3/fZL04/pgA6x23UOIQ9JVJj2dRkinhmkzaEo4P+pjATSSbq9QCtTfSSFnD41S/YjnMJlWobd/1SIHJ/0OD4CCiRwN1Udle4pEjQudbyl8O7Je/0KtzRD9CmAIzY5bYp89jAIkaVyQSF8CALILK4BKpbSIQw8y5OgcM/aeVDQw5du53FkDP0abvNk7PuLlmjPFuwbaPsMVXVXtA0RYviCEvv2rJ0F1am0px23b0rjUBMXMQ7bX3DPKFmdl7nKpWHdli1VwGzQp9+2jk6ZIBO86B/aKdlHamw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(53546011)(38100700002)(38070700005)(6506007)(83380400001)(5660300002)(52536014)(33656002)(26005)(7696005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(64756008)(54906003)(66446008)(66556008)(76116006)(66476007)(110136005)(478600001)(122000001)(55016003)(71200400001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p1AEU2gaSWGgLANbtf4rxdSSyZcH3R56L8XY0N1xfV5zfxG9QhOnM+YvMYlT?=
 =?us-ascii?Q?pSrbjsBkadA1jSDXky+QaPJ6s3m6qCEtxnFDHOR5OCdCEY+abC1IaWO2ryK4?=
 =?us-ascii?Q?xhaQcldUYkpgrr10i9Ush8ARZqCDytWxJMIS220MtCMZj3/v14PSc7zpfETp?=
 =?us-ascii?Q?ICLtDXzZLbIUYPEztxnaGbi0kV/teV7JodZuaoWwAAZwk6H6V4Jaw9r/7G0/?=
 =?us-ascii?Q?YJd0nj2sy2iAoQZLYSTdJ1j1koSfNbCeIJAgVIcxgcnX5XwKbmCQZ92GTgAJ?=
 =?us-ascii?Q?4Fho4r7+tCGjpIWPeZf4xdu7mUEgBFLdUNOU8iHmybUAX+qDJx5cQnLvsg4w?=
 =?us-ascii?Q?j/PA5OuMYuFnGgY3OocBZniaMSM+IL6AiUoUKaOUxpq7/AMrXUPFM2QQ05wi?=
 =?us-ascii?Q?L+HKHcJ1Jh1hlfAlu01IwIf1AEWV+paTYyGOxVUdTB4ZI6BzH/T8Bku8lJpG?=
 =?us-ascii?Q?9Oh6JOeuMbpjHF4ua8JB3XaSAh/IE0W611yjBtxuGnAb9okvu4G4vCu9xFll?=
 =?us-ascii?Q?0cbheUiYc0NhvOUQIQ3Bt9gq1FkrMS0Js079KMAtZejKz8Vq3BjRG+z8zb5F?=
 =?us-ascii?Q?90ZkZBS2LgE9pHCkVjTgY7bgCzNidqNfY5jqHQAtf3TNKaRkrYLZb7Gi70Rn?=
 =?us-ascii?Q?0AXB7cJZe2q8WcGng/gArw15j5pIwj49OoOZsaukU+L9g3fUIVMTjsQhA4z9?=
 =?us-ascii?Q?2d+05rmi4hYFFa5YIf+Acpm1E4sG8+HgXSGV22CK3j1I7LV0txSVleh802Dt?=
 =?us-ascii?Q?ohwV209DhkBpxkX9KGvu6y1oIMPJS7q8QX86ql0vY3jICiXJqm0FoDjmTffo?=
 =?us-ascii?Q?AC4BdWHk16iLptrtkcAXqm4ZzoZ3NYh1uRTN4FdPuY7c7qznlzjuyGn4AXP1?=
 =?us-ascii?Q?/6wGdEr8CSRZ46ryQDJbm3RGf8OxVyO79Mmx2SxAVCj+LP54YXmycYmM+skR?=
 =?us-ascii?Q?wb27uWoVCas9BKRDuh/wIOlLQqW+/PaVVobiRTLxFIdXHzMEUm6KVluIaG4Z?=
 =?us-ascii?Q?chfDcrFrd6pCa8rJdhm8p3Bg2OUWTrAt7DqMIkabQ2T8jXRb8JGh6NB0FXap?=
 =?us-ascii?Q?+sHwS3CI533b9Wq3R50VoWB9AnvkvpkL6t63j+heVeLREqxEelB/AX9NVhyI?=
 =?us-ascii?Q?RA63NaozcJKIhxNcrW8F34hKSQQZdaUmXZltD6k8GBlZDculTmnr1+uU5x05?=
 =?us-ascii?Q?R+zee1li4Zr6KCNuve+VtSGUews+SWIyvKk2KlzerEgXJmhMpKQk8teC+cXl?=
 =?us-ascii?Q?TmXh0Y4F3QMus1/WRRNUx0IbRyHkyFXTNStH2Znf8qTPv3A0RUGOii9FuLgA?=
 =?us-ascii?Q?GUh9JvLLBLvBmKSO21uWMiUnxT1UkoouveaH61i/2q1c27xu6oqEFh4GFCW3?=
 =?us-ascii?Q?wRWTWRCsREA9AamnLmikB2ZSajE7G8LhXlYDWwtQcK5phZxUENflBCw7bl+9?=
 =?us-ascii?Q?Xm+oZXzXXiAOLrDJ7Drq7dw86ErZ2gYOSDiTx6FSb7biKNKJpe288zIo6Lin?=
 =?us-ascii?Q?FzoMbWVOvcqYopma9+tDEKrHfdM1ekaa0d7NcqPhyE2CA5Bd4aqp0JMeanAw?=
 =?us-ascii?Q?tNx1tao8ubAJGV8oja8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa99d22d-39ce-42f2-e939-08dba24a87cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 13:28:39.2319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMTvHpYAo6uXqaONfPltkGTa/tQPOvKzWJLJQEKbb1gEYJq5C5phn07q4ryzUXa+zTnVU+be905TuA4KkWWNlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274
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
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 06e=
1ec5a9a88 drm/amd/display: Promote DAL to 3.2.247) with new patches added o=
n top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using Gnome for both.

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
From: Wayne Lin <Wayne.Lin@amd.com>
Sent: Wednesday, August 16, 2023 2:07 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Lin, Wayne <W=
ayne.Lin@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/16] DC Patches August 18, 2023

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Ensure FS is enabled before sending request to DMUB for FS changes
- Add check for PMFW hard min request complete
- Save addr update in scratch before flip
- Fix static screen detection setting
- Write flip addr to scratch reg for subvp
- set minimum of VBlank_nom
- Correct unit conversion for vstartup
- Roll back unit correction
- Enable runtime register offset init for DCN32 DMUB
- Refactor edp power control
- PQ regamma end point
- PQ tail accuracy
- Blank phantom OTG before enabling
- Expose mall capability

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Alvin Lee (3):
  drm/amd/display: Blank phantom OTG before enabling
  drm/amd/display: Write flip addr to scratch reg for subvp
  drm/amd/display: Save addr update in scratch before flip

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.180.0

Aric Cyr (1):
  drm/amd/display: 3.2.248

Aurabindo Pillai (2):
  drm/amd/display: Expose mall capability
  drm/amd/display: Enable runtime register offset init for DCN32 DMUB

ChunTao Tso (1):
  drm/amd/display: set minimum of VBlank_nom

Ian Chen (1):
  drm/amd/display: Refactor edp power control

Krunoslav Kovac (2):
  drm/amd/display: PQ tail accuracy
  drm/amd/display: PQ regamma end point

Ovidiu Bunea (1):
  drm/amd/display: Roll back unit correction

Reza Amini (1):
  drm/amd/display: Correct unit conversion for vstartup

Samson Tam (2):
  drm/amd/display: add check for PMFW hard min request complete
  drm/amd/display: ensure FS is enabled before sending request to DMUB
    for FS changes

SungHuai Wang (1):
  drm/amd/display: fix static screen detection setting

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  19 +++  .../drm/amd/displ=
ay/dc/clk_mgr/dcn32/dalsmc.h |  11 +-  .../dc/clk_mgr/dcn32/dcn32_clk_mgr_s=
mu_msg.c  | 154 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  71 +++-----
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  23 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  22 ++-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 104 ++++--------
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  17 ++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |   2 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  17 --
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |   3 +-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  46 ++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   5 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   3 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |  21 ++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  18 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  15 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   1 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   9 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../display/dc/link/protocols/link_dp_phy.c   |   3 +-
 .../link/protocols/link_edp_panel_control.c   |  29 ++++
 .../link/protocols/link_edp_panel_control.h   |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  21 ++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 -
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  64 ++++++--  .../gpu/drm/=
amd/display/dmub/src/dmub_dcn32.h |  17 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  13 ++
 .../amd/display/modules/color/color_gamma.c   | 115 ++++++++++++-
 39 files changed, 674 insertions(+), 190 deletions(-)

--
2.37.3

