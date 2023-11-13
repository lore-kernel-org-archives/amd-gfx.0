Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29F8C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 14:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D8F10E37B;
	Mon, 13 Nov 2023 14:28:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D271210E37B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 14:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfH3iLiIYMb8bRT7T5EFFmf5DYWRWGvYFObNfuMzD39IEXqGOyJj5bCTMh8EAY8hfl30I+m+P/QoQr+e2kyOo2sAViMhUDURxXC7M++ceNS8k/dP8abTMJt/vMxnbvpDIcIONSZBPiNOni4v4QkthGCka/r00dfAPoywmGVfzKyBiDEeDp9HOprquLRrB6JnwgCrm2f14ZV8tn4822WQmpnXWv2fqrfrNtp7uc3Sun5Y6b+uuPtACj3AAC3VVe+a0dbdPr35w08/mvCzhDO78uGzUJfPJExg+SNGokQwo102QAg86zw6m7h1EqhtC3hIbjFkZM8uZxZTQGJsXbwBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6I1A3kpqDn6fwIu5/pwL7JwHMolFgvUcQeUYChPi8Gs=;
 b=ik0eQT5c0o5Kehzrq7TmeyiBhFrT8YhcAhXSsJj6ACeIy7VJs9quWMkmSkQMHPUwJamjVyXa27zS6+nvBBdQsrjQm5ctgb2tSoqUkfLDahSl1k7WjgzMmezBhtruW8jPKav5i+4jzVI1fw0ZuTvoQ2rNUc9l7ZXTl967vU0l12Ka/cyPDOh4h+E13vAjEeewkUZ+7QkzPFTp0W1Bnfozo2grY+md2fX6CWVDosaWchO+1RSNm/5L9Qg3Tfeg3ksa0y3dhDd/FqU/3y7Fcbi+7MYsbnCF0gPT7Unm4bURJXg5Wg+hEksBiGj3kEXbi5shZytMwzH2G26moMsTB8rwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I1A3kpqDn6fwIu5/pwL7JwHMolFgvUcQeUYChPi8Gs=;
 b=b5UdghQ5Psc2xelT9xI1Bd1euUC7olFMVbMO/X7thyrsd9NpzJ7KXYL2ICH1NTN8RNDaAvPOr4n1zHDbZKZUJ0NnXa1tVBeK+uvOAADemTBOSa1UFbtkKU80bxn35BoVt1HjtSMbbRbtv0A9pH+WVgV7GUVVXkWYAa4WX/TJ3PM=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 14:28:35 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::99f9:4c15:bbdb:7932]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::99f9:4c15:bbdb:7932%2]) with mapi id 15.20.6977.020; Mon, 13 Nov 2023
 14:28:35 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/20] DC Patches Nov 08, 2023
Thread-Topic: [PATCH 00/20] DC Patches Nov 08, 2023
Thread-Index: AQHaEnXpLxAHLfU2t0qIeRPcVOEsmbB4VVvA
Date: Mon, 13 Nov 2023 14:28:35 +0000
Message-ID: <DS0PR12MB65343F1E8392FF3F2A48304C9CB3A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3d548b0a-dee7-44c4-959e-ece164b52ab2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-13T14:25:02Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH3PR12MB8710:EE_
x-ms-office365-filtering-correlation-id: 84447eeb-fee5-4646-5bcb-08dbe454d1d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ScbA0a4kHOAriJChthRhONyronts5Rik/ew9ytHG9V4oTBK0eKxq3jKnooWP+KevM/iUsBsRYEifhIM17tLdYhoSC54Nch/reVNNWvYCze7eB7vC1MNWJBjyir0l58hyl+NavbvODn8jqCAcbI64Gbho7z+tSMTikHvnmSqyJ/BDthepuZsPaIoKkvJ3781mlWPvKeGYadNoxx/Pr5MHzxLwTZIgIFJPpcIlciGiop826I6tvBIpVACM/oP5+oh/L4xfOkmFOemr6eEJNyxrFQj0PubSEDK2y9YfiZzzeyft4+RivkkX2zN1F2wPs8t2CLMhbtr/ZFr6bNVha+fZKpO5WYin8eHNxdwfPjx3WScmaThGKN9HCzC5QNugum0dMXC4hKToME9y+3I48YMFOc5Eq/hJPPbzPj3mr+vznWg3f0y3OA87vxXfn2cQ7JazpIlQXPMdhX+2/4gJscbEFOUlXLv9Ta5sEB/C8La2l7vBPckq1Fzrndxl66q0IRHTNjFyoVg6q5HKgYyXL4c77KniExdIRH/hlv01Ur86y2mnnLSXazKnV4BivcWurA4eiVzkZ1eDu3kuycdtxDTacErCsYa99XTnUGT4rm9w4wlT8pZ8IHMkqKgAVCjvtv3i
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(110136005)(316002)(76116006)(54906003)(64756008)(66446008)(66946007)(66556008)(66476007)(478600001)(71200400001)(19627235002)(86362001)(5660300002)(30864003)(38070700009)(41300700001)(33656002)(2906002)(52536014)(4326008)(8676002)(8936002)(38100700002)(122000001)(83380400001)(26005)(55016003)(53546011)(7696005)(6506007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s63mqbXi/Rmr3p2f2mLCcNFEST/bxfydDV2duXsKd8suxaPr2kEJUSLWgHyx?=
 =?us-ascii?Q?EiSC5BVdeShzH8UeYQQ/K7KY9t+9BcO4Gpr5033E0e6v9anM4fmmE7XGqmrR?=
 =?us-ascii?Q?dXwRLMgHOkOMjdPFO2xDBBX7cwRUIatUTrYxvu0/BTgrvuQqVErCG+fJpxja?=
 =?us-ascii?Q?IqMdQtVxBYezJ8zvBtiwcAF8ZEqJ2IrGMNQX+129HkvZ1XCocMvtiNIP6k6k?=
 =?us-ascii?Q?Cf/ICfoaYq7zamIHLj7L+UA3LowtWvilMlGskdoTMBu6F9fpDGdHyBbRxuI+?=
 =?us-ascii?Q?i1yWAx4sYH6aamcuPbUYsprp1tCFQYApqP7HoMPcwrJhpV33owwg0sXgb3XM?=
 =?us-ascii?Q?Ya3RHCbEPAbuqJz6XnaQn6qmE7htzt23x7kbPXCczYMzF1vpUDAaHAKKF1O3?=
 =?us-ascii?Q?R15gplnSZs/bLrA1/ZjCvDn5BmrlgVti+BcfC0Jd+m8A5U7d9RSjJ6Ezl0ud?=
 =?us-ascii?Q?nhblPJ/w45InqTKLdFbGP2c8WcCalfd5/74RIx6XFlMGxfGKmgWMWHmy/j3X?=
 =?us-ascii?Q?MahBeMac1rIenGpV7dGG7Ivm6hlikQJMJAIpPbvZX2eCQFpdci0PsV/8zLgI?=
 =?us-ascii?Q?YlUiybHWy6sJZMm0mUH0PoENIZLVxqsSyfoNT18ozjxxOwUMQFqXW9hfZQ0l?=
 =?us-ascii?Q?ECpNrabQaHsNthwheUFou1DqlY8LuU27fNtr9o50x8uKjExgz0l0JG6+3QM9?=
 =?us-ascii?Q?EBmHIduf8B7ygKhYxAy+5StKLsEJSu67ZvfYdtXoINEgZt3tZxGbXwmCm1ta?=
 =?us-ascii?Q?JTIrNSsHh/P9CrwwfRlKerQY3aYfVcCNy4LpXpwSX+nVtPGadFtBO39Mz376?=
 =?us-ascii?Q?V0d++tDbIzbdqLu5gcP1nx6Lt64HPFaXS2jc9T/4kW/Uh1vmaRoWR40YwET6?=
 =?us-ascii?Q?ED6KUCQV8AjnDizj/XaDLXZjFcpB5j6UeMFa77iWxR6tsXY5VvvHrGzSWlFu?=
 =?us-ascii?Q?Hmh+501BQjEZRZpmh69pq20Mcj6wzvAnC+b2xiVV+yGoSKczUsu7Jp8JrQrz?=
 =?us-ascii?Q?Cv7in6SET/Qov/kyQ0lUzrngGrmVVLzR7EqxT+JmnDrMjYNFurtUKmEFcg1X?=
 =?us-ascii?Q?ycIqfpMbvJAF2FKrKMhcvq4X0RQ/4U+V89PiAQhhzRpwSYdMlpbqYJrJF15R?=
 =?us-ascii?Q?6fIFLtZY/CiBS6JLevO+w8yNvCNwGP8GhNpHJHHU+gPuDC/SvoePZQpmwqfR?=
 =?us-ascii?Q?XyVS8q6apZstRgvDSiREyGmNyTfp9srwHenib0JGw8695RizHTVTV2KmwsmB?=
 =?us-ascii?Q?RAmmyjGoGJ4XFWn5F/VPegL3NrUesyIjwBKFRbgL8tH+D9bZxzn2sBX8YRFH?=
 =?us-ascii?Q?LRTrAbtzK1/R2PctbO4Z60b9ZzUCWBFaPFOKahbW8r4deLgumBoaGw4SLAvd?=
 =?us-ascii?Q?c8aHyhoO5X0annB71qBNVMGaE+U+E6J8/DpYB6k8m6V6DFuHnKxtOLEua2Mm?=
 =?us-ascii?Q?mP89Dv/5r4CJAiD/27Axb7IZLFcezvPUdSocQcTsKduJPA5ddWeUpIoR3xq/?=
 =?us-ascii?Q?CcH3OqdaC2i9SGh8BbYxMhEjTm5G2L0pLADEEB2pEA+G4UJ34x77LQJLtjf5?=
 =?us-ascii?Q?7XA0Wow5t/MFbddrdaQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84447eeb-fee5-4646-5bcb-08dbe454d1d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 14:28:35.1621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXIDqW8YoG1RdanjPL+ep7V9lOsz+duZS/kE9p8FDKE3zQ6AixSNfL3QQ/PbNEJPI5k/9E2liJXZ9GhujjFGiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 7bb=
6e298b738 drm/amdkfd: Move TLB flushing logic into amdgpu) with new patches=
 added on top of it.

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
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Wednesday, November 8, 2023 1:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Gutierrez, A=
gustin <Agustin.Gutierrez@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung=
@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>=
; Hung, Alex <Alex.Hung@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/20] DC Patches Nov 08, 2023

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Add missing chips for HDCP
* Add new command to disable replay timing resync
* Fix encoder disable logic
* Enable DSC Flag in MST Mode Validation
* Change the DMCUB mailbox memory location from FB to inbox
* Add disable timeout option
* Negate IPS allow and commit bits
* Enable DCN clock gating for DCN35
* Prefer currently used OTG master when acquiring free pipe
* Try to acquire a free OTG master not used in cur ctx first
* Clear dpcd_sink_ext_caps if not set
* Enable fast plane updates on DCN3.2 and above
* Add null checks for 8K60 lightup
* Refactor resource into component directory
* Fix DSC not Enabled on Direct MST Sink
* Guard against invalid RPTR/WPTR being set
* Enable CM low mem power optimization
* Fix a debugfs null pointer error

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Anthony Koo (1):
  drm/amd/display: Add new command to disable replay timing resync

Aric Cyr (1):
  drm/amd/display: Promote DC to 3.2.260

Aurabindo Pillai (1):
  drm/amd/display: Fix a debugfs null pointer error

Daniel Miess (1):
  drm/amd/display: Enable DCN clock gating for DCN35

Duncan Ma (2):
  drm/amd/display: Negate IPS allow and commit bits
  drm/amd/display: Add disable timeout option

Fangzhi Zuo (2):
  drm/amd/display: Fix DSC not Enabled on Direct MST Sink
  drm/amd/display: Enable DSC Flag in MST Mode Validation

Krunoslav Kovac (1):
  drm/amd/display: Send PQ bit in AMD VSIF

Lewis Huang (1):
  drm/amd/display: Change the DMCUB mailbox memory location from FB to
    inbox

Mounika Adhuri (1):
  drm/amd/display: Refactor resource into component directory

Muhammad Ahmed (1):
  drm/amd/display: Add null checks for 8K60 lightup

Nicholas Kazlauskas (1):
  drm/amd/display: Guard against invalid RPTR/WPTR being set

Nicholas Susanto (1):
  drm/amd/display: Fix encoder disable logic

Paul Hsieh (1):
  drm/amd/display: Clear dpcd_sink_ext_caps if not set

Rodrigo Siqueira (1):
  drm/amd/display: Add missing chips for HDCP

Tianci Yin (1):
  drm/amd/display: Enable fast plane updates on DCN3.2 and above

Wenjing Liu (2):
  drm/amd/display: Try to acquire a free OTG master not used in cur ctx
    first
  drm/amd/display: Prefer currently used OTG master when acquiring free
    pipe

Yihan Zhu (1):
  drm/amd/display: Enable CM low mem power optimization

 drivers/gpu/drm/amd/display/Makefile          |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  21 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   6 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  63 +++---
 drivers/gpu/drm/amd/display/dc/Makefile       |   5 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  18 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  50 ++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  39 +++-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../gpu/drm/amd/display/dc/dce100/Makefile    |  46 ----
 .../gpu/drm/amd/display/dc/dce110/Makefile    |   4 +-
 .../gpu/drm/amd/display/dc/dce112/Makefile    |   3 +-
 .../gpu/drm/amd/display/dc/dce120/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dce80/Makefile |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |   6 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   1 -
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   2 +-
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |   2 +-
 .../gpu/drm/amd/display/dc/dcn303/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   2 +-
 .../gpu/drm/amd/display/dc/dcn315/Makefile    |  30 ---
 .../gpu/drm/amd/display/dc/dcn316/Makefile    |  30 ---
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |  13 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn321/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |  30 +++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h |   7 +-
 .../dc/dcn35/dcn35_dio_stream_encoder.c       |  10 +-
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |  10 +-
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.h  |   1 -
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   2 +-
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |  15 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  42 ++--
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |   2 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  12 ++
 .../drm/amd/display/dc/link/link_detection.c  |   3 +
 .../gpu/drm/amd/display/dc/resource/Makefile  | 199 ++++++++++++++++++
 .../{ =3D> resource}/dce100/dce100_resource.c   |   0
 .../{ =3D> resource}/dce100/dce100_resource.h   |   0
 .../{ =3D> resource}/dce110/dce110_resource.c   |   0
 .../{ =3D> resource}/dce110/dce110_resource.h   |   0
 .../{ =3D> resource}/dce112/dce112_resource.c   |   0
 .../{ =3D> resource}/dce112/dce112_resource.h   |   0
 .../{ =3D> resource}/dce120/dce120_resource.c   |   2 +-
 .../{ =3D> resource}/dce120/dce120_resource.h   |   0
 .../display/dc/resource/dce80/CMakeLists.txt  |   4 +
 .../dc/{ =3D> resource}/dce80/dce80_resource.c  |   0
 .../dc/{ =3D> resource}/dce80/dce80_resource.h  |   0
 .../dc/{ =3D> resource}/dcn10/dcn10_resource.c  |  25 ++-
 .../dc/{ =3D> resource}/dcn10/dcn10_resource.h  |   0
 .../dc/{ =3D> resource}/dcn20/dcn20_resource.c  |  24 +--
 .../dc/{ =3D> resource}/dcn20/dcn20_resource.h  |   0
 .../{ =3D> resource}/dcn201/dcn201_resource.c   |  14 +-
 .../{ =3D> resource}/dcn201/dcn201_resource.h   |   0
 .../dc/{ =3D> resource}/dcn21/dcn21_resource.c  |   6 +-
 .../dc/{ =3D> resource}/dcn21/dcn21_resource.h  |   0
 .../dc/{ =3D> resource}/dcn30/dcn30_resource.c  |   2 +-
 .../dc/{ =3D> resource}/dcn30/dcn30_resource.h  |   0
 .../{ =3D> resource}/dcn301/dcn301_resource.c   |   4 +-
 .../{ =3D> resource}/dcn301/dcn301_resource.h   |   0
 .../{ =3D> resource}/dcn302/dcn302_resource.c   |   4 +-
 .../{ =3D> resource}/dcn302/dcn302_resource.h   |   0
 .../{ =3D> resource}/dcn303/dcn303_resource.c   |   4 +-
 .../{ =3D> resource}/dcn303/dcn303_resource.h   |   0
 .../dc/{ =3D> resource}/dcn31/dcn31_resource.c  |   2 +-
 .../dc/{ =3D> resource}/dcn31/dcn31_resource.h  |   0
 .../{ =3D> resource}/dcn314/dcn314_resource.c   |   0
 .../{ =3D> resource}/dcn314/dcn314_resource.h   |   0
 .../{ =3D> resource}/dcn315/dcn315_resource.c   |   0
 .../{ =3D> resource}/dcn315/dcn315_resource.h   |   0
 .../{ =3D> resource}/dcn316/dcn316_resource.c   |   0
 .../{ =3D> resource}/dcn316/dcn316_resource.h   |   0
 .../dc/{ =3D> resource}/dcn32/dcn32_resource.c  |   4 +-
 .../dc/{ =3D> resource}/dcn32/dcn32_resource.h  |   0
 .../{ =3D> resource}/dcn321/dcn321_resource.c   |   2 +-
 .../{ =3D> resource}/dcn321/dcn321_resource.h   |   0
 .../dc/{ =3D> resource}/dcn35/dcn35_resource.c  |  20 +-
 .../dc/{ =3D> resource}/dcn35/dcn35_resource.h  |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  22 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  41 ++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  50 ++++-
 .../drm/amd/display/include/hdcp_msg_types.h  |   5 +
 .../amd/display/modules/freesync/freesync.c   |   6 +-
 .../include/asic_reg/dcn/dcn_3_5_0_sh_mask.h  |   8 +
 94 files changed, 655 insertions(+), 308 deletions(-)  delete mode 100644 =
drivers/gpu/drm/amd/display/dc/dce100/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn315/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn316/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dce100/dce100_resou=
rce.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dce100=
/dce100_resource.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> res=
ource}/dce110/dce110_resource.c (100%)  rename drivers/gpu/drm/amd/display/=
dc/{ =3D> resource}/dce110/dce110_resource.h (100%)  rename drivers/gpu/drm=
/amd/display/dc/{ =3D> resource}/dce112/dce112_resource.c (100%)  rename dr=
ivers/gpu/drm/amd/display/dc/{ =3D> resource}/dce112/dce112_resource.h (100=
%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dce120/dce120_re=
source.c (99%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dce1=
20/dce120_resource.h (100%)  create mode 100644 drivers/gpu/drm/amd/display=
/dc/resource/dce80/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dce80/dce80_resourc=
e.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dce80/dc=
e80_resource.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resourc=
e}/dcn10/dcn10_resource.c (99%)  rename drivers/gpu/drm/amd/display/dc/{ =
=3D> resource}/dcn10/dcn10_resource.h (100%)  rename drivers/gpu/drm/amd/di=
splay/dc/{ =3D> resource}/dcn20/dcn20_resource.c (99%)  rename drivers/gpu/=
drm/amd/display/dc/{ =3D> resource}/dcn20/dcn20_resource.h (100%)  rename d=
rivers/gpu/drm/amd/display/dc/{ =3D> resource}/dcn201/dcn201_resource.c (99=
%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dcn201/dcn201_re=
source.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dcn=
21/dcn21_resource.c (99%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> res=
ource}/dcn21/dcn21_resource.h (100%)  rename drivers/gpu/drm/amd/display/dc=
/{ =3D> resource}/dcn30/dcn30_resource.c (99%)  rename drivers/gpu/drm/amd/=
display/dc/{ =3D> resource}/dcn30/dcn30_resource.h (100%)  rename drivers/g=
pu/drm/amd/display/dc/{ =3D> resource}/dcn301/dcn301_resource.c (99%)  rena=
me drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dcn301/dcn301_resource.h=
 (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dcn302/dcn3=
02_resource.c (99%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}=
/dcn302/dcn302_resource.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =
=3D> resource}/dcn303/dcn303_resource.c (99%)  rename drivers/gpu/drm/amd/d=
isplay/dc/{ =3D> resource}/dcn303/dcn303_resource.h (100%)  rename drivers/=
gpu/drm/amd/display/dc/{ =3D> resource}/dcn31/dcn31_resource.c (99%)  renam=
e drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dcn31/dcn31_resource.h (1=
00%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dcn314/dcn314_=
resource.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/d=
cn314/dcn314_resource.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D=
> resource}/dcn315/dcn315_resource.c (100%)  rename drivers/gpu/drm/amd/dis=
play/dc/{ =3D> resource}/dcn315/dcn315_resource.h (100%)  rename drivers/gp=
u/drm/amd/display/dc/{ =3D> resource}/dcn316/dcn316_resource.c (100%)  rena=
me drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dcn316/dcn316_resource.h=
 (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/dcn32/dcn32=
_resource.c (99%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> resource}/d=
cn32/dcn32_resource.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> =
resource}/dcn321/dcn321_resource.c (99%)  rename drivers/gpu/drm/amd/displa=
y/dc/{ =3D> resource}/dcn321/dcn321_resource.h (100%)  rename drivers/gpu/d=
rm/amd/display/dc/{ =3D> resource}/dcn35/dcn35_resource.c (98%)  rename dri=
vers/gpu/drm/amd/display/dc/{ =3D> resource}/dcn35/dcn35_resource.h (99%)

--
2.42.0

