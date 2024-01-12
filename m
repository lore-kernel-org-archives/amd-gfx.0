Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D3EC4706C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jan 2024 16:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149FF10EB50;
	Fri, 12 Jan 2024 16:20:59 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516C910EB50
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jan 2024 16:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD8KplHgX8GDKZqGEou8fvW67t83fK/OiGbbbsMQ8o/mVvWwFfuyttofbC6clWmhlhLC1OkrKELM5jldodbU/aDEt/zsallSX09G0jHCyRKQydNThm7gW44bnr8YGOdDe2302/xd8vRhx86Lcy7qI1CcirW5hqwSoqWe3hcIIM1jxeC2JqNivuCFae0NArYO/7S/5ZsvnQgmKh/a8En+epOWWnH1HMms0cJbeG+3NHgA/iXhKkiKTBI/pkzsPRr1/dtbrUfB2y8wqzJzl7xAreKeFraszS45cXH2XM8gMYp28CYNA2VK90awFrcrLuqfWGWtRxipMcD/gxSM0CMLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWysikO62eot845Hte49QMlN5TT/IRb6LaI7/DrCwKA=;
 b=b08ajZuPWkGoiXMNNM5HCIEXb3pXKEbFZ6rySp4VIl/0Q+L489tjqRzbmTNV6+wtaFrKJG58o5hbKNCmeMi0P4Ol8Me4Ds/0ViqUs8nT1QUX3f8MTVLktdwNyn50rcLCsXirKDDmmwOvNx43agnp1XAUVU/gUg4PUpr3t3m+0VLAJ7ClgqFy+OtCQypKyEyjhoMYtKJ81xrCCL8WQLc06m/PlMqRlonRbDtiRLNYkIWJYbSxKQBB9yT64vPsRldpd9amqvAms9HsmWfnSQV9GtgkeOWhqDyQdNzhkOna/TQMzH8OJMkrJRYHlJoUp/ElYLx/u2NhT+X2aWcFIL/cRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWysikO62eot845Hte49QMlN5TT/IRb6LaI7/DrCwKA=;
 b=LHCMd99DGhSfFUcl2FUzwfQ15KM4fxwnnhZf36taZ6XQSAG7oINwE7zyDtEZ2CtCCs0+nr7YgB+0+umAwwPQCtCIXge8nLPpkdfQZTgCvAkKyebajWTlVaplf5s+9Helj3ae4PmazArqkucSrL0KAJyMLNxh0exsIT1O8IJ3vVg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 16:20:56 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7%7]) with mapi id 15.20.7159.020; Fri, 12 Jan 2024
 16:20:55 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/19] DC Patches January 10, 2024
Thread-Topic: [PATCH 00/19] DC Patches January 10, 2024
Thread-Index: AQHaRA98d69DmPnT4k2kw7peZnNSRbDWXlSg
Date: Fri, 12 Jan 2024 16:20:55 +0000
Message-ID: <DS0PR12MB653491D42669158C36A0DAED9C6F2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0069d332-8a75-410f-acf2-cc3056621a9b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-12T16:20:44Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|BN9PR12MB5051:EE_
x-ms-office365-filtering-correlation-id: e27df3f7-dd0f-40ab-63c5-08dc138a7453
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqwZO97mhuNMxX+fCNcFZHW/modFXtz5U7Yz6hUO3nIDKcFA15K+zx9TeMGyXpYqn6tmLJWrclhEEAmAiPV3Qm4CZsz+mcaKUgH74D/dUu9ak2QJY6zI2F/v3ydlqGOVc0l/PuUbRFbwRJtmcQInvmf3Uoh0cxaCzpXwVMkiAz/1M8bYII0YJRjnkluL4wTO/mz3mgp42yIQ/+9ERUXe5W+sJx6zeoWwtU1dzFKlue0fcFDojTsxKBA4wdcxfsjfK9+Cl6oCv7f/DGyvhf4EYf3zlXIjYNpfW30rIx/epu6oiA6qm4ExtmjN2NYS8AA2o+dk6s/tvjEqfcSa1E+aRmyarXeWMhMsLj6F/QRshsk74PHXwbV+Ic8jq2usc/D7K/NZB4bAiF6TMYOcx5ui8cyON1G8ImDG3AaLexcrh5qcjpWcUNZf38imPzvwWhn70Nydrm7IORmwgK/s/ARXHFCYHFYUInjYiwqT/f5UU97FTsKQC3sm8uITX9/gymy0YNWh22UUGStNakGGEm5ALoD6F8l2CoXITMjSQJQOtQHpYZkgMQ67AIk3RhuvzSaPcmgKWrlhnZlbFCv3Siy61cVRlo5ZgrETBjwf/4hpTFU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(39860400002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(55016003)(110136005)(86362001)(33656002)(38070700009)(66476007)(8676002)(4326008)(6506007)(7696005)(38100700002)(83380400001)(53546011)(122000001)(26005)(71200400001)(9686003)(64756008)(66946007)(66446008)(478600001)(54906003)(316002)(66556008)(52536014)(41300700001)(8936002)(5660300002)(76116006)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uAA7NNRbtHqB6pPBMA9li7Ikd8hDjtdwxzOaK7EPiaGYmM4meAnW+DiQppnw?=
 =?us-ascii?Q?arXREoW9eGmOFnUUOwZCCDjP/b4Sl/1tFbzuHffEHNh0ir7O6QDGsczYw5Yv?=
 =?us-ascii?Q?Ocl8giBIEPF4zrR6bAgGh3jO0Xbo+n6dW8m0M2y2R2ddvh7Dl/UK+6Jabi66?=
 =?us-ascii?Q?ex5Hlzhd5PiQ8uXZQY/3barJC5cLRXNth1ayj3e43ohfpRENYa/bdfjgpPZs?=
 =?us-ascii?Q?uVEZLsqOIAPAIokT3F+GSoAgigP5IAyL5xzNTCupz4qG5IAis3uHmhn5N8Ym?=
 =?us-ascii?Q?RfEq6nd516flfM54XuMzDDo9yFh3hd3NGG276jOkqAx0wmSOdSaGoF/phky9?=
 =?us-ascii?Q?Gxw0wjjI4Krcfhno6zl+zN58eOUvp9aHK1vl0spUTZNF0krHq/NWx+dmugbE?=
 =?us-ascii?Q?PcNcU/xKGKgvm6xUfBqTOkpDnogst3MxjijOetg6A7cOU8/ketTgRnFF2uoX?=
 =?us-ascii?Q?M8tn7nDWEr6pS1YgxpZM9VU8Q1JUfbo+jtOYV+n2lN1t8KsUW5V2GySGpkKm?=
 =?us-ascii?Q?/RgdaxfNPhes3TPLbBuA2I4nz/tlB2ek83p+7k4APTiSU6oV80yvIiGdf8B9?=
 =?us-ascii?Q?GaqY/LPIuLVUIat6NCISZO3XVsQvh3M/5JqKYspXfdDieOeQ0twbHSHJ1cTI?=
 =?us-ascii?Q?nKC4EjyRiI9U8x9EwtWodYzTlK4uMv4WLm/MCftz3yL+q8hg4d+h2S8x17Yb?=
 =?us-ascii?Q?W3Dz/9Ds4ZCtfTl6FWv2Ag1sMtPf8dJWTIYt0cUBsrJhTvKriQExoJ1kuQ1Z?=
 =?us-ascii?Q?9nUh5q6gsxWBxvTVWkfC8GJGc4OAbFwz7FsL7/0FxYRg5b3OKzfPlVrUuSVc?=
 =?us-ascii?Q?3e/06DKIC4P4gEiV0aCQeQ67LFOBELEnxR4WyZZEQo2WP5FqGiwUdYRhFIY2?=
 =?us-ascii?Q?Cwo5WCUoUkRFGRAQMOzvpFp3N4XspvZuySZYdl3WnNouo0GMhNKzDZZJpzZj?=
 =?us-ascii?Q?qYam+NfImj+XWD/j1kkqTA3mhIg7ohZ/PLdRVJtHcBPFf9MiCangOhdwANBn?=
 =?us-ascii?Q?xrvd8o8q0/JZHCaMcyM5jd6W5Xth9Uj16Oa2XXt7sECxTXal6HP0WIsta84W?=
 =?us-ascii?Q?+xqJMqlKXgQP2SPDJm1ESck4YaOVohNS8yG+fWYKCk+K/hCHpCnxqk3WNBcE?=
 =?us-ascii?Q?3qes/QrA7cpCVs+jyViKZnNe+HDpEc80ECClJ39rxUBI9Q8HrIIWeYu4+tvr?=
 =?us-ascii?Q?tjJalkTUwzSoNeE4sX13yyT+7dvgylmpRA95GXwPg12vxgTivbZw/z9PSANu?=
 =?us-ascii?Q?//7gaPhaVtU3xnXNH3cKqJJbsQkqQpehugpirulOsbLLcLuLMQnSg2wL9wrw?=
 =?us-ascii?Q?FO/MJMR3xW1eJq3DaEpEdYXEBAAbP8Sp0v3xMLO7rg0x2TVoBZpP0xXp0kKA?=
 =?us-ascii?Q?Va+ZidYRwxmVpM5SAL9cxhhKEPJTOU5kvO0oYjX3xBg39D/OFhdD22HFXmdd?=
 =?us-ascii?Q?4nVZluhqFfYTl8/2rDmjpr9A4Y4JGmonmcNq68gzysq27x45KvSh3OGcjSPm?=
 =?us-ascii?Q?BYvBlVHg++oxQWHasU1QNVQZMNNmN26eagrxhxOmjVw/u4zNkZDRBXgFKXy5?=
 =?us-ascii?Q?lRYqAgP5qoaDvBnb6Iw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27df3f7-dd0f-40ab-63c5-08dc138a7453
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 16:20:55.7456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4fodU4oFhnPBVjqm6EQ86wrYy8BhhFwzqnPz/ssTiuZyI0rAwmWIw7NCdPKbjEP3ppW9vZFhw27HRrOhYyJcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
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
Cc: "stylon.wang@amd.com" <stylon.wang@amd.com>, "Chung,
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

The patchset consists of the amd-staging-drm-next branch (Head commit - b2d=
b1b01c3ec drm/amdgpu: update regGL2C_CTRL4 value in golden setting) with ne=
w patches added on top of it.

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
Sent: Wednesday, January 10, 2024 4:53 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; stylon.wang@amd.com; Gutierrez, Agustin <Agustin.Gutierrez@=
amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Wu, Hersen <her=
senxs.wu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Hung, Alex <Alex.Hung@am=
d.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/19] DC Patches January 10, 2024

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Fixes on DCN35 and DML2.
* Enhancements in DMUB.
* Improvements on IPS, DP and MPO and others.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (2):
  drm/amd/display: Add Replay IPS register for DMUB command table
  drm/amd/display: Ensure populate uclk in bb construction

Charlene Liu (2):
  drm/amd/display: Add logging resource checks
  drm/amd/display: Update P010 scaling cap

Dillon Varone (1):
  drm/amd/display: Init link enc resources in dc_state only if res_pool
    presents

Dmytro Laktyushkin (1):
  drm/amd/display: Fix dml2 assigned pipe search

George Shen (1):
  drm/amd/display: Add DP audio BW validation

Ilya Bakoulin (1):
  drm/amd/display: Clear OPTC mem select on disable

Martin Leung (1):
  drm/amd/display: 3.2.267

Nicholas Kazlauskas (5):
  drm/amd/display: Allow IPS2 during Replay
  drm/amd/display: Port DENTIST hang and TDR fixes to OTG disable W/A
  drm/amd/display: Rework DC Z10 restore
  drm/amd/display: Set default Z8 minimum residency for DCN35
  drm/amd/display: Allow Z8 for multiplane configurations on DCN35

Ovidiu Bunea (1):
  drm/amd/display: Fix DML2 watermark calculation

Tom Chung (1):
  drm/amd/display: Enable Panel Replay for static screen use case

Wayne Lin (1):
  drm/amd/display: Align the returned error code with legacy DP

Wenjing Liu (2):
  drm/amd/display: Floor to mhz when requesting dpp disp clock changes
    to SMU
  drm/amd/display: Reenable windowed mpo odm support

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  44 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  59 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 119 +++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |   4 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  21 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  40 ++-  .../display/dc/cl=
k_mgr/dcn35/dcn35_clk_mgr.c  |  25 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  15 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   9 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    | 288 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/dce/dce_audio.h    |   3 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  16 +-
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |  11 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   4 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  14 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  36 ++-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  56 +++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  11 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/audio.h |   3 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   5 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   3 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   3 +
 .../dc/resource/dcn30/dcn30_resource.c        |  11 +
 .../dc/resource/dcn32/dcn32_resource.c        |   1 +
 .../dc/resource/dcn321/dcn321_resource.c      |   1 +
 .../dc/resource/dcn35/dcn35_resource.c        |   3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   1 +
 .../gpu/drm/amd/display/include/audio_types.h |  15 +
 32 files changed, 689 insertions(+), 152 deletions(-)

--
2.34.1

