Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2C4C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 13:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBCE710E550;
	Mon, 15 Apr 2024 13:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xx44L4Yy";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099EA11255D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 13:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2buRemnfE3zKtR+Iu10ohzHf4sfCV7h+z8Aze1QE/Lr5nzju10yloyslb+CcofhzqMDBZTWL6ovWRwH8lggDOC9v5mvk16t2bE3TFZleoNN3ka2MVtI4AERlBfpT2unfUrnwVI4TbFLDosx7+BpKRLeWGRXoXnFrRVIGi3mMPMPpwC5mkjiJbE+3AVwDHhS4g2dm6Wdpuq2jblWkVE7HeUYYrR1zQYRMMWXDEgVnaP2bObjNw694corlbf6JwmCumi8gIPB7JoBt1OON5l8uMDu5wZoVxJQ4Jh5QutpxQyARXktK2RvykMUeZbkkaimWf5QeC/+kvjxUlQUxoyGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACQfZa5YGrFZsS/lLSClJKeucWhz/3oZIpt2fclo4ng=;
 b=EaDiSJ8BOFMAFOzGMgSQ5L6icVq67Umel+i2DW1HcT5gUTQd7yADhRGLCTOjFy6cGTGmkPEEeRo8ZReN43Ica+y94o1at2intrZip+N+ofniiR6ZyP54ouXtRX5vTMx06wo+J80EjYAX/udSgC71IBlkn8NlMJ5FyP/YOTtoPIOU+Pq6krKw2xroFEd259IygXkufE4YcLxn9fraO6IeU/IB7kq+u86sXVU5ML8oVHCFuxdbAW+VS4dqpHmdQkSKcln79egaHTaxjtae50ayahNCTPHuzJiGPsn5dcCDEiiTREC8LCkIYmr7oifAcFn8oXFwIZDENjNy7Ra0+p586w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACQfZa5YGrFZsS/lLSClJKeucWhz/3oZIpt2fclo4ng=;
 b=Xx44L4YyOr1wNEuNxlc4fbqUtsyUuZM3gvx4aIfdQkRGirXUUig6SJCdkhqAy/LWaflvZqg5BZlcDauaUfAYVJCcTjoW3q7TnPWPa2gaVAhAt9SXyfbBsj9v3pSGuo+nrtQaFrBVdcv54hE/ZF2bIYVY6E3L1fR4Pnd8Fj3CVnk=
Received: from CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 13:02:30 +0000
Received: from CY5PR12MB6527.namprd12.prod.outlook.com
 ([fe80::57b4:7663:f7f6:6b39]) by CY5PR12MB6527.namprd12.prod.outlook.com
 ([fe80::57b4:7663:f7f6:6b39%6]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 13:02:30 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/25] DC Patches April 10, 2024
Thread-Topic: [PATCH 00/25] DC Patches April 10, 2024
Thread-Index: AQHai43z8A5CWEvAAU6w3maF/muwA7FpUsiA
Date: Mon, 15 Apr 2024 13:02:30 +0000
Message-ID: <CY5PR12MB65272602D73C71ED544012E79C092@CY5PR12MB6527.namprd12.prod.outlook.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cb375771-9ae6-4031-ac07-cfa6b19e8c1d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-15T13:01:05Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6527:EE_|PH7PR12MB9224:EE_
x-ms-office365-filtering-correlation-id: f08c7475-af0d-4e0d-a613-08dc5d4c4ef5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WwEG56M4HmzTD23UC1hAQfULlbZMCsABFFhxrxT3A/gZGXZ+PlwokD1BbxbSudjp+0SeQb4QNKcEZskMGLBivJELZ47vizxhDLXSU8CFO8RzuGmnGWjw6GIjVGE/fyrTsEkk6/rVb9AryzcXVvHjnZQhmpdGxMUL3b38P2SlbkhS1ZA2ipTL97i7yd9SuYOTxIfxGW8+cF3vYq6eqnzpM4/OHbb+bKWn7sDRew91JljxG7ZSOL+4KLfO0hKuvf3mt2oNozvHdkkJCq4xj+qcIfjtAxmU8tANmRSQMlMZHH79xEuLnNrYZ+oiCc4wVNWSUhIPuqPNWo8dmKEOkOmikoJo7FrbvlzHWBhZy8hASzNF9zm5EBCG3mHFvf8Rk8vk4fp5Rb46c8n2CqqIVbtWMq539mKsKQ5T/OX6M0rAaXZA3UkfzjKx8Jupoh3iNQOcdOruSbdVIsJJ0F9X6WVdLKj9WwQyAjqce2jTTG10sXVzYKU1PTrDb3AJOdOzLmqaaAAt/+FSkjHKa7Uee+8s8b9YVstypDDdwP4Os/FZyqBzxvTjbvTPg+0pq5fL9fQaiIGIjDXtryM5S3lQLsANEXx0LxazF9I+nDtK22qSSzz2GIt0kTGn9gwZaVuAFReLsPB8aBJFovLLQoFF7EdqAVmyTLcD7mFWTbhCeiwXF/oBM8sIWm3l58aYqfJohAAIAYyz8lBB58wqNV+8j1YNbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6527.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dmLuH+qgH15ijUguaodzW3m32FyjHrREBMIhXNx7IyohOH06gRpBN6b2SL+u?=
 =?us-ascii?Q?mLRGkoSMilwkpUZc4IiPpTk2VmKTmdrxIABsrj6qPYUVf/gCKsCdorHv2mxr?=
 =?us-ascii?Q?aRcqOYWA2zr74FskuYheE6zqfdz8xvwfzXHlg0IB2gBG2nosMKCJUADweoWs?=
 =?us-ascii?Q?aA/ZWE1FmfJqi0zsWUoWS//MP26l++iJ2NaqTulkYXsxnOi/475K8qmASh7Y?=
 =?us-ascii?Q?m8F4RA2uCleks20LWxcAzJyyft2ibpq+NesVUI+LgCzEzjcqhJQ1x637tDLu?=
 =?us-ascii?Q?fbijWUHRdvx1/RaO1C6Q7T5JIjxiHqtblh8pvnENWL6RRHrVzvM5FWSi6LOx?=
 =?us-ascii?Q?yDREeny65oHN1SJG/r2AZjwyaJtJ2z9fe2zyJeA7Bb+ShRjrwij6Yp6LKxup?=
 =?us-ascii?Q?Ow71h/61ZC04HWqwRpF6mu1srseqTvaoRpB5R1ucBFOnJmxcP+eZZXdNiXgq?=
 =?us-ascii?Q?gcjDOtH0r0c0G9VOj7bpnR/angLXcEOp0vGFIkyLrtDkZa3GV9nYeFK4fqQm?=
 =?us-ascii?Q?uHFh579/ugzEVPCkjCSlPwSmIanviVfcI+yFDRmH+XIlvRYYD1qkb38WMdRZ?=
 =?us-ascii?Q?NEzhcEXR6Synw6txji+cRg9ACXz21iXU9hZd9vRTJ+S8hiOrc5K68nED1ZjA?=
 =?us-ascii?Q?e/KHONsNo26LO1EHXA/rQy7rsfnHvFQTA4D1D2LlFazQ3FlptgpN67QbxoRG?=
 =?us-ascii?Q?HIcgxfL69PFkfLmpLUcROJlBhNCivLzIgtoYAE0sqahEVraTExoPcir/kR19?=
 =?us-ascii?Q?ZZBlChycBbcSN0B+O/r3eGBOEfJaIj5u0KydJzxQAN2xwksR1dy4yZgGGjV6?=
 =?us-ascii?Q?s2+7UG+mlczxg06rsB2MedQVt60GzPnzCddmxm6YI6nMsuoz+XiOWqDjEZoO?=
 =?us-ascii?Q?VUqbbMIHuOULLRDXJ78hGRyGVJQA8y4m1ZYVuptvbQXrknanX/xm8Ikb6g+A?=
 =?us-ascii?Q?uzkcXI1qZWtqREMmvXDXGvd+o7On5Na6U/4x3CiC7V/TfdjUUc4gNUUWolbI?=
 =?us-ascii?Q?f6MgkmW0wYom6oIJyqMu8RiT59mQt8ig74/SF9Vy9Yfx3IR/5vhnhOm8n7zL?=
 =?us-ascii?Q?796/hPpHCr6mYTeZLl3K5yIfH1HCCDaQcSdfKQnQeY+nDDaBX5058etaKYwl?=
 =?us-ascii?Q?a+J8ONPnqu8qDXYajQNJN4nfuMGsjJ3XQ7lttM2u3kY6UPsYvv3hg3JvtWIS?=
 =?us-ascii?Q?bV1odq8b4tgjxammnkzpMLcBqsIW52npg5yPNuoylgYAq0nzYY0B5a+7w+pU?=
 =?us-ascii?Q?+9LLERkKUYgccar44GdDWQWlPpj3xZzbmfw0oRGunKEZxpW7Rkzeo4eLw8qz?=
 =?us-ascii?Q?aVDLewxdzPJnUZxFSHuvytJlFTy+Nj33h5w41yRL4+n302tgiJ3Twwy4DhKN?=
 =?us-ascii?Q?Xyk4xb9dgVNepNAvLGWQXNyWcgQ13plH9lIyttuGGftOe4imKsiSkLtpyQ8x?=
 =?us-ascii?Q?O31WdEvFa2i/enJGhAEXXoBEhVJL8x+9gvcblrLVwuU93rGpZ0nFQgQjpL7j?=
 =?us-ascii?Q?WDt47/8WnLpRsB9hR0k9pwayRzyw0ToiIUhgVlGsqIAAL4qyRL2TP+FJKo9f?=
 =?us-ascii?Q?iS9AtB4CCLQUAr/bbeU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6527.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08c7475-af0d-4e0d-a613-08dc5d4c4ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 13:02:30.2865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/x+XKPSO33vFv5FoPXZjg/Yl8tQUi7Zv/XUuQiYSBnfBNAN8h8mBV53Vofhr1iq12TcSQT1rGYlkg4Ft7BwQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 9ef=
923c9f876 drm/amd/display: 3.2.280) with new patches added on top of it.

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
Sent: Wednesday, April 10, 2024 5:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/25] DC Patches April 10, 2024

This DC patchset brings improvements in multiple areas. In summary, we
have:

* Expand dmub_cmd operations.
* Update DVI configuration.
* Modify power sequence.
* Enable Z10 flag for IPS.
* Multiple code cleanups.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Anthony Koo (1):
  drm/amd/display: Expand dmub_cmd operations

Aric Cyr (1):
  drm/amd/display: 3.2.281

Bitnun, Ethan (1):
  drm/amd/display: Improve the log precision

Chaitanya Dhere (1):
  drm/amd/display: Fix incorrect pointer assignment

Charlene Liu (1):
  drm/amd/display: limit the code change to ips enabled asic

Chris Park (1):
  drm/amd/display: Add a function for checking tmds mode

Eric Bernstein (1):
  drm/amd/display: Update FMT settings for 4:2:0

Mikita Lipski (1):
  drm/amd/display: Fix PSR command version passed

Nicholas Kazlauskas (1):
  drm/amd/display: Pass sequential ONO bit to DMCUB boot options

Rodrigo Siqueira (11):
  drm/amd/display: Use dce_version instead of chip_id
  drm/amd/display: Adjust headers
  drm/amd/display: Group scl_data together in
    resource_build_scaling_params
  drm/amd/display: Replace int with unsigned int
  drm/amd/display: Update some comments to improve the code readability
  drm/amd/display: Remove unnecessary code
  drm/amd/display: Rework dcn10_stream_encoder header
  drm/amd/display: Move REG sequence from program ogam to idle before
    connect
  drm/amd/display: Update DCN201 link encoder registers
  drm/amd/display: Add missing callback for init_watermarks in DCN 301
  drm/amd/display: Add missing replay field

Samson Tam (1):
  drm/amd/display: add support for chroma offset

Sung Joon Kim (4):
  drm/amd/display: Modify power sequence
  drm/amd/display: Modify resource allocation logic
  drm/amd/display: Enable Z10 flag for IPS FSM
  drm/amd/display: Rework power sequence and resource allocation logic

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   5 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  10 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  16 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   7 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |   6 -
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |   6 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |   9 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.h  |   2 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  10 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |  10 +-
 .../drm/amd/display/dc/dcn201/dcn201_hubp.c   |   5 +
 .../display/dc/dcn201/dcn201_link_encoder.h   |  14 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h |  18 --
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c  |   2 -
 .../drm/amd/display/dc/dcn301/dcn301_hubbub.c |   1 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |   2 +-
 .../drm/amd/display/dc/hwss/dcn351/Makefile   |  25 ++-
 .../amd/display/dc/hwss/dcn351/dcn351_hwseq.c | 182 ++++++++++++++++++  ..=
./amd/display/dc/hwss/dcn351/dcn351_hwseq.h |  41 ++++
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../dc/resource/dcn32/dcn32_resource.c        |   4 +-
 .../dc/resource/dcn32/dcn32_resource.h        |   6 +
 .../dc/resource/dcn351/dcn351_resource.c      |   5 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  53 ++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   1 +
 .../drm/amd/display/include/signal_types.h    |  13 ++
 35 files changed, 402 insertions(+), 82 deletions(-)  create mode 100644 d=
rivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq=
.h

--
2.43.0

