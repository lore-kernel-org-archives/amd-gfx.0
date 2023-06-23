Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B15EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 20:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D51610E6AE;
	Fri, 23 Jun 2023 20:26:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA4810E6AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 20:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feVbM2rF4T/GNo0QJJn6MycDXH2remIiL2jd8l/SmXBfDj9vyUMgDRNAftRL+kuqI5f3le/MR7FMzCYCg33zxrdaZOkCNkUknGYptAcwdXfBu7qXc0xgrYh+VFK0hu/KfNYfd1+9rPh+5Vt8eb9mz0N5zcGha4Vpm4CH1Z1WJ06r/RrRwjOhEnbUj5F6xGg4mrR3KBauRwFBxC6e3fC/jbZ49tm7iue7JjUfI1SEm0QBYX6dUNHJl4NLvhCjXe8nVDKNLhQfGX5z5Huj2WAdrTf+NyMLYQwek/o1HfRbkPGppKQeU0ue7OZlZBHghqEOf2354pHBVPiYmNzQW3jakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJU6GovrEFlrLx/hUXnp+LMbQM4J7xC4OdsK2QZhg28=;
 b=CBvjYaG+oGpoScxD4K1B1v4Rw2XPTa6xWbsxmGObl7Gh9T00oVxs9RSECEfZYhfNxoyC+XAuy8wNy3rM8tyKjWaatlS8UMY1GVQH8mWTLKYEACnjtfhuzYsKCmCPq1K99h3jli7GzV8jstmXJJZPCoaHl0dchAZv9fG3EAwG7+eD+VU2sewZTtZJTtImaLLqzy8sUqYaAPDiNMVxrjuOmRnD0LqOSmhLUnS2cLlzjEBvDUm6yVf8C5VgLoLG9EYb+NLEyd0M7coBp0uDGejb5UjGM+FfOw5o6eYV9k8tu/cHuqObPifY9ZNmyDn5Hl6LSEi7ty6HDsiZHfPuxKpujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJU6GovrEFlrLx/hUXnp+LMbQM4J7xC4OdsK2QZhg28=;
 b=10ypi5dMNV/Qu8ajdB92ZjCqFN5Ug5CCjVT6QYn9h8fSi/W8UqyTMK9qR4bI622p4y/2205wy0KUFqxY6WNfn1ynwm/lUOUCB1BDUp+aoJVeh705INHKlVJZ6aQKVzrqlkauex6hdxbB9apyoCdExP/wFQzZ/Hdx+8opqba27rg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 20:26:39 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::20af:1871:5c7d:548d]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::20af:1871:5c7d:548d%6]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 20:26:39 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/11] DC Patches June 22, 2023
Thread-Topic: [PATCH 00/11] DC Patches June 22, 2023
Thread-Index: AQHZpVSkcdIvksfnV0GCZlMH6o81Mq+Yim5g
Date: Fri, 23 Jun 2023 20:26:38 +0000
Message-ID: <DS0PR12MB65347C953D426AE7B53E94C29C23A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b139700f-122b-4a8e-a7d8-3b9e6b371b83;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-23T20:26:35Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|MN0PR12MB5881:EE_
x-ms-office365-filtering-correlation-id: 104e29ba-44b7-405c-5662-08db74282611
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: huARRrh44mqOTPW52BzS6ph0ZQBBul8Ojg9EO5Hq8BhOCAJC0NwTk4neTzidJMkOE6rzofADCqHKL44fok7EC9Y6Tg6WxjSMMFCdP2Rgfxd0nH3dKwO9DnZp1WDWjWM1liMHV535RERO2alitb0BnMug8FDyrMxByjipHVcD4N8NpXKGh8yfD06GbYCCZw1iTMqbcsj0/N0mHLDiS61FghCFo4riduDS9EbqZ3q7jvu/fq568Th46i5WyDd0mSYLEAQ6wRzcFd4MPE49uUfXhAsNeMgU/LOhdrkfNZoqdNPqlnjQGnGgqqTLb4lCk7CuWtSWvMkmuYpzUW4kgocmvrgUi3Rwh6Dr8DTvZLXe7+dTKrUzwnbNULJ/l2+U7jVvhNl2zNPLlvN7t9C46pzxHbMdDTbWQnyboeL7AwDBZkevWa3O3Dt9LgayYApFOeHUnGhiDZsAKQaEJ6iZbs+3QYHZYLeedf6WP4ZANTaq0oPDHlyiuGvSihkMOo7tHJANpgLZ9zHwQPHxWpXL7CmzSFDtmcPeOmisik2ih8Yj4wlyao4n7FyXCow2rTCA+WHuszovc1Mle5nPa3sagwSwyRUVBly5Bfm64d9s1DbGTBvDBgUPHRMZt0fD/AGvD3N8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(4326008)(66476007)(64756008)(316002)(66946007)(76116006)(122000001)(54906003)(66556008)(66446008)(71200400001)(83380400001)(52536014)(53546011)(6506007)(86362001)(5660300002)(7696005)(2906002)(41300700001)(186003)(55016003)(26005)(9686003)(33656002)(8676002)(8936002)(110136005)(478600001)(38100700002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1VupHTO1vlNVgKA/WEk8pAhp4JLVsQVv0ETYrj1X7eRIVzRHURTwIMH+Xt0B?=
 =?us-ascii?Q?F0vaCFuQUfEyUnBB7Fe3qlgpff3dUTJLgDBYsMrYH6LHr9lkMoTnlaex1I+g?=
 =?us-ascii?Q?61MnGKJtWzOHxR4lV/uePMsITPnobGW/iGP/pa09JS9HaWu0lPY/6XlLFCaQ?=
 =?us-ascii?Q?02g939jEXVD7NUK/npLJzVvnv3YfMSe+UikFSHc8lUMMv0M3JbcraEJtMEol?=
 =?us-ascii?Q?4fZ/v/tj53VNw65GNbOVXl1iwgTYjehcUaF0lKSzXkgaK9JycnSJI8Vwapfd?=
 =?us-ascii?Q?+bdIw9i2Ese58rfUlIBxmy2BB5pY/brEV/1/4S+WCyNYWpxi1PQlEXJfKn5g?=
 =?us-ascii?Q?Zu5exZetzEiiAGjbkcinTfNVB/AIedyc3QLAvqTvMrjVwXJ3hKxbJdzF6n81?=
 =?us-ascii?Q?oPzFlcRSDRDAEZUWjo5nKOQmiFClaC5ZZnI72fu9jW5Ue0lksI5ubnm5Fqxa?=
 =?us-ascii?Q?JxjR5xhLGjvBzgv9r/q1cVLeWOEsmoBp4SYX4AnPosgeniuvHfuP5Bv/xbiS?=
 =?us-ascii?Q?l6PPHnGYdVS6NlCbLbODp2NMOfYrtBSZ//ANYkju2N39V8YTfnqhp3bjsb7K?=
 =?us-ascii?Q?ZEtn5C9kBq10e4Wr+Jess3MAB57qNov7CoHBvCNsLY4Bhw5PxmlqkKIILEGu?=
 =?us-ascii?Q?3D8GKpKZssDrmS3SZw+7762KZcJg13r5K5lPV+Co1cj1zvgeqbD9FEox/cuJ?=
 =?us-ascii?Q?jV1cc72H3TRdZghh9YsZxeatk4evz/t+jiRhbpDYiJBl1qDajqVpfEhJgDIQ?=
 =?us-ascii?Q?rJ9nNO1+rV7sZnkP7bH8MoOutaiCT2J+ymSFUmX2EPiRYd6NLj6nhiohOB8/?=
 =?us-ascii?Q?WP86RMhdkGnOCLnrjlAzfechFWWjsaaY9qLVsN3z3iiE2U3RIMXuJ/C95MWd?=
 =?us-ascii?Q?hKCZqcXOwki11TXpATBUqgrkDc39nvEaLf5eo71Cq9zVseYG+c4/QXHNt0NS?=
 =?us-ascii?Q?owUHp5Dnr9YuStpx0NvEbv5iJC+oLQBN0t6/UYxc8R3whryyu6v+CH1seEIm?=
 =?us-ascii?Q?9XAtII3ELS2+wzkJfs4rx65Vlt50EGL8Xs7RCruQ6W+DaXUzKn1iQm5ckbd7?=
 =?us-ascii?Q?njQ0l5VrlHLYt+SvqGQl9DBRbPVyV/gl50ASfPRJWfKyI+HQFww4itwZtdK0?=
 =?us-ascii?Q?WH4BpGu5KeWGcR8uU2jhmtkzxwDJQf8PbBsYOoHLW4i+LQqzmqz1+O7Pefc9?=
 =?us-ascii?Q?bt/lXwJH7Gxd8qsfZvNn4hNZQPl5BWWmA6Dc6F4e/vWC2HGeMoHLVU13XE/r?=
 =?us-ascii?Q?Rax5bdo1Xx6pfbh1tJSCLXmXTe4Ko2kmdJFLVcCGm5aMMYe07OdVURXqNLyj?=
 =?us-ascii?Q?msr/Yn7/JYa7nWioZXfc70zssVL6ETl08ALtC0JtE+IXnURnZCIEvg3saTtl?=
 =?us-ascii?Q?0pVQJq4hqPp1EncMWSCTtwWAs3bWCqk9rXY6rGhLMYPlawHkd7VLPfllyCvr?=
 =?us-ascii?Q?rJseks2pS25f1JGZsCoHYZszGKykARnWQZxLL6IGodPEd8EDyGUP3Bd+AX8O?=
 =?us-ascii?Q?OY3sRQ0givT+1hUAkdrbpZNorgpqpn7tAEdaz03RhHlCnVl7Ic1zYWGJ4BN2?=
 =?us-ascii?Q?a8vpEslzyajSc2fS7XQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104e29ba-44b7-405c-5662-08db74282611
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 20:26:38.8747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnbQDAHqINqQ9P8VQv0PVFqZ/eJ6kFWXDaaYAW1qJMl+wGeT9UO9NAFaxMDbSyrSrlGpeW+vHjFiUwwPtzozsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
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
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Chiu, 
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

The patchset consists of the amd-staging-drm-next branch (Head commit - be7=
ba5b1098d drm/amd/display: 3.2.240) with new patches added on top of it. Th=
is branch is used for both Ubuntu and Chrome OS testing (ChromeOS on a bi-w=
eekly basis).


Tested on Ubuntu 22.04.2 and Chrome OS

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
Sent: Thursday, June 22, 2023 5:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/11] DC Patches June 22, 2023

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Improve debugging mechanism for Gaming FAMS
- Add monitor-specific edid quirks
- Fixes for Phantom pipe
- Fixes for Shapper LUT
- Clean-up asserts

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (3):
  drm/amd/display: Limit new fast update path to addr and gamma / color
  drm/amd/display: For new fast update path, loop through each surface
  drm/amd/display: Take full update path if number of planes changed

Aric Cyr (1):
  drm/amd/display: 3.2.241

Aurabindo Pillai (1):
  drm/amd/display: Add monitor specific edid quirk

Austin Zheng (1):
  drm/amd/display: Remove Phantom Pipe Check When Calculating K1 and K2

Gianna Binder (1):
  drm/amd/display: Create debugging mechanism for Gaming FAMS

Harry Wentland (1):
  drm/amd/display: Fix the delta clamping for shaper LUT

Hong-lu Cheng (1):
  drm/amd/display: Remove asserts

Ilya Bakoulin (1):
  drm/amd/display: Work around bad DPCD state on link loss

Melissa Wen (1):
  drm/amd/display: program DPP shaper and 3D LUT if updated

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  26 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 121 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  14 +-
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |  19 ++-
 .../amd/display/dc/dcn10/dcn10_cm_common.h    |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  11 +-
 .../drm/amd/display/dc/dcn30/dcn30_dwb_cm.c   |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   3 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  10 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   3 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |  16 ++-
 .../dc/link/protocols/link_dp_irq_handler.c   |  26 ++++
 14 files changed, 224 insertions(+), 32 deletions(-)

--
2.39.2

