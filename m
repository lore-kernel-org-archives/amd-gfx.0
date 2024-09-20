Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C04EC78850
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 14:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB23E10E100;
	Fri, 20 Sep 2024 14:00:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IoLBxq8e";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A45110E100
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 14:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2eygiYJL226MJ26qSJlPZybEm6f817ROXF6ncCuJVoaff1dPvVttUiPQVH4xADV1PqXA5GGgYviZtEHWSQUShjVeq3U1RXe6sxlzmSjJ3zeoC+Kss7KMFF7Qcvld1EXIlp7LupLC8oMQoxmCDayJsjOg3foe+aCJ5/8fZXlqdOIdYjeetEfBB6jd9f8lOVztxGBWGFvhqmmnqiiQJWMWcZPTmXIrkiKnYej3iw+whjU/K5gnLc9eqigIbTYAAYYGo6M+QpoKRho6rvE86TPBzTn5fNzy7ZMMtdXVzzcMGFXTDYG1QWdX2rO1uRytfsxrmcnzMYIGzUq0nDxaKRgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn1yhlDeH1WJYpz6M29QfgjcMSHqw02IR3erX75a28s=;
 b=ou1eOXvmtP6C27psxiW2AKaiTNBB3sRElfjIZ7v43UUM46ITSoOTgg4OG8WfK9RA2iZaQ1lNo9qJ7lQsV1lWRPaqC7rtDgfianLMCUR6r7AWhnzyQsyVAeEoQXQ6JAQXNKlkYS/kV94826LzxtZEOQiOauJf1EwmABXdKNJjVT1xb0G3ONEpGXdyZM8QJAKHcRaACySvsCFikjsnhp06QAboQqN/rFMrR/MqsO6+p9TkyAiDS8RI9QAlps5Uh9l8Eqcpobr/hUNm0tv52yl3WYGRtEdRlVYCBGbpCa3g8AkxtoRjq4hZt4QXHlum9VWQjSgIBpk3GGVCq7sDm2sXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn1yhlDeH1WJYpz6M29QfgjcMSHqw02IR3erX75a28s=;
 b=IoLBxq8ejb9vZWsYN8IrMobZ4x9iR/whoe5OX6FPyJeWXazZQZ0IMdqdHDuh5KVziI3Ax37/fZNCYoDqODUJhirERWqP0y2XU7FZih7NB1j0hZY5CBFlrHXN5Xn7/bf0sz7IlJqzFnPOPw6cO15M5KzfEvLR2ALzJUeBRcujXZU=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 14:00:55 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%3]) with mapi id 15.20.7982.016; Fri, 20 Sep 2024
 14:00:54 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>,
 "Chiu, Solomon" <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/21] DC Patches Sept 16, 2024
Thread-Topic: [PATCH 00/21] DC Patches Sept 16, 2024
Thread-Index: AQHbCsKWmr9zYmGZYkOpg0POjqyhdLJgtHhw
Date: Fri, 20 Sep 2024 14:00:54 +0000
Message-ID: <DS0PR12MB6534A1F4DB82DEDB36BEF3F19C6C2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0b2e63f8-b598-4183-af03-5cd74d9a95bf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-20T13:57:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SJ2PR12MB8110:EE_
x-ms-office365-filtering-correlation-id: 70ac8796-6644-496d-a91a-08dcd97ca4ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ohvibli6Yz0CXb68M8rrPdN4vyS0aMMwclpJisig6RZelFmh3sL7ylwMawFe?=
 =?us-ascii?Q?K/Yeek/4BjElY/XwbZWdxl6KrUfvAdvR8dePDXavUI1/CblnrT19pPDhW0HA?=
 =?us-ascii?Q?fRdYkDRDHuu2V6SADVkb5vqF0FI80EETmHbLyOdz6abcCB3cBA5f9lO/QT1V?=
 =?us-ascii?Q?AqsIpua6Mjza6gttyiZfOabZqaGs6rMBYu6PHJ1QkXEeoxvVLPCZBS+CLt29?=
 =?us-ascii?Q?9McleVizCiA6iv9DV1FBe4w9x5VNywN1870soiv282//MszRVFIxTZDpSp+g?=
 =?us-ascii?Q?M4Uo3e+ZKMXv0McC9mitFoIkhODFY+3tv18E3JNDNUTflhdrRxp47GgtU0Lo?=
 =?us-ascii?Q?UUy+hUrixvyWeiSUDZZ2PRhHkVri5g+ST+PH7FNI41JoZBk6QkYrkNchxi2U?=
 =?us-ascii?Q?N/kixfli/cRoE+jHv/G12PnmZjsixVbiQrLZEEvK1D/DH6u/gpYzE/wlSqXk?=
 =?us-ascii?Q?ckfQKhWi5CECnmgOMVuqqGa9bLGFvkmcYwK5xfpiZMsn843NLJwbd/riftvv?=
 =?us-ascii?Q?3xCJYaQjn9ktPmxqOIZL0m5sAHmqwIxkXF5OXA8AxT9GzGb9tPrPpZWc3pt4?=
 =?us-ascii?Q?sG6NtG8GlpYnrNV3fFKwsQHEUDt7cOUfbX7w6gXaKK6VqRHe2RiZcFnk87ji?=
 =?us-ascii?Q?9XtmOuO/CHW0CAPrn5ofhyhqg69pteNq2vEhtDWZ0QacfIuvOSbHYQtkXWj3?=
 =?us-ascii?Q?xOtyjjHKQrItwIQ+p5S+Dsh/DmTbGCv8FEBaKWuadblH0VclNJqZWf7hyT/q?=
 =?us-ascii?Q?vsXy5LYWv26hqPKy9sKCMqIe4cJAdofb+L9yORpzs4map1at7Wwtc7PdJ3ZL?=
 =?us-ascii?Q?Lj7Cq5Rsrf57e2XhkqqAEWn9sJ1Iv8hMXiXaRNV8aI9uDpaDuchqE0IflDrd?=
 =?us-ascii?Q?I5zkZyt5VC+bdj6RBAxifKQezEfMWmMOnHGGn8dEfZR5B+Ia2m/FsmUuFQw1?=
 =?us-ascii?Q?IpyRRKaghbx2a3Dqyk4KOVOWsPfV5s5yMjUpfHbuLV0ex5LWf/U4ren6TiB5?=
 =?us-ascii?Q?XoeJ+xnqu9NpJ/4VP2Q+9/IZZ5oCedRhmNv6H7iV003YTu3qAfzylxCG6JXF?=
 =?us-ascii?Q?F8B0zP6y8bkYr7t7+/u2qqfvfkVEVdwa4h9zf0FVulqlvJGdJ5RbCB0WxVca?=
 =?us-ascii?Q?9AYdItQhu97MeoRf7mIAZCQpjZomDsX7GUBfIBNJjL7Ioi3Uq7r5uFk0y3uq?=
 =?us-ascii?Q?3TJFc0DeEApVa0/snPW1mcJM92d7o++yTroJKgS7/pZAKpfuuQYmN7CRHoXm?=
 =?us-ascii?Q?h4i8scG8jvxFkSN44jdUWq2eGcdbM44oUh3Qv7u1k703Cn3wu4QdRkGMlE9i?=
 =?us-ascii?Q?XYdnSWB9g64tsMa0NjrKCIJoL4MA2bNf+3mJBTkuo8KUSA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZNmJ56tIiri4AUz+FAPaXWaJFNWgo/iQLaZX06LKGSiXOmmrrGu9JgY0bK1h?=
 =?us-ascii?Q?sNy25Rymhioe6Nh3Bp3x57JdmeyaG6jgy1QHzasjDDvPMnfBV/Ob5FOGjIsb?=
 =?us-ascii?Q?GAhSHjVgeaTiZ6+QSttpD+so/BL8fYG9OfqjmN5Jrhn/tH78tl/cdZJUPZYe?=
 =?us-ascii?Q?IkzK7vGHEcIP4RqJhAGkjtlXG7PKlMs65I2HEQ8pFzH5z5yz3LAl9zWa8C3r?=
 =?us-ascii?Q?ki/p1Ok7jpGUP5fZ3vLtkTX9ZObjIKCX8rkBYX3HJ4cr/AlYo/hRYOD5eMJf?=
 =?us-ascii?Q?0Rgqfxp1B8QhcW6/chSbrL+aSxx4wqkK8jhor7VfE6Vphh16bCPRYVXE6i3D?=
 =?us-ascii?Q?OD0CaRoFAJsuefF9C7FWzyrlnRf2/hzdXG44n8eudELyRuDT4TMjHKznV7TD?=
 =?us-ascii?Q?lqURSB0CMB1egU9BQNzu+8KftLqIY+ZXT0ZSjRT/R92l5yXKhHYYzoIJt2mq?=
 =?us-ascii?Q?ASarXIu6P16AD6ntFbTZrUNxM1j2tIy6W3WTor9eHg6J+CC82f8+wqzxwEVK?=
 =?us-ascii?Q?I56UxjuiP2AlKEfpVo2qDqssHghcoa/dPpMhuLS0XEeCqJ4fN1oLr1dxco1o?=
 =?us-ascii?Q?/b3HA/lMjG2gZ1tGIZ6UNgaWoPXiNELwjD46OYazlq4WUbX2Fhlo2h+TniLU?=
 =?us-ascii?Q?+E/VJcezLyHr+NHXoUgFygflP0fsYDw6CleODBu8OgFX2PdicWprWjS0klqx?=
 =?us-ascii?Q?aSMv/tqcnF68Ug+4D/HyP3DUhf4oIqQ93cUUpaDZKxiNcCyczrsYjUV3dcor?=
 =?us-ascii?Q?PUS4vufvS0f8meH7nwlsbAKBc9PPg3DlZOlEWHRnrkFiI16r9VmB4DxhhZEK?=
 =?us-ascii?Q?nBFqZxIo0Rd2eBAmsINcSndq0WRx7Q2pEK+zHy+xgOCwb1+XRZRE5EBQEZz5?=
 =?us-ascii?Q?etcCyPZ+C4IkfcK/Ma/g+rIqHUxEoVE9dobYCqDzEXyXukuOrLmcDbmAYzU2?=
 =?us-ascii?Q?IQfIqNGLJbrUskOu4WHlGALK6kARK62PuT+Z859GNsFJaKm05ukBfvYfDiql?=
 =?us-ascii?Q?jWYaarOnVkUtIdn5TvhJOMxEKEHeuiDs2yGPVNuD8KqQUUqhLca8nNmWA953?=
 =?us-ascii?Q?CernOZfoO5FOi5fTUAVwtzTzHnt2EWQeeuZad/OmWUhBOdtX6k09ZSL0o1Fo?=
 =?us-ascii?Q?xEJ+J5Xzc8HYszARmVDySszH0KXAQGWbTBnmsA3aPg331uwtOHxqp4X6ON6U?=
 =?us-ascii?Q?HJY6ja/pwa3meoehWZ+S7q9Qh4h6/ul2AvY8D+fApnAmH6dNzSyNkiO/8eDn?=
 =?us-ascii?Q?qb12CNvx6bdsDekIOu6J2zhO9qQ8L9d1CzXaNoaFhG2AM9D6DoBxWh0UHzxp?=
 =?us-ascii?Q?6ii4tNCIqWkv2aBh4C6HZivOJ762owpKfe9cRnfCFp8fO6oSKzIkxZjBvH/P?=
 =?us-ascii?Q?rsZs+Z5jxgiO2k4t1Xk2bxR1g+5njOq2bs8uGcWrIL7XLPTS9yPu+onYSSVe?=
 =?us-ascii?Q?kepUeaTyfybiZSJlTIDaC2fMnyWfeSXTEcHcBfyTzFiSMNtW4qzeYDECstaE?=
 =?us-ascii?Q?qJz4jAddy6z7JAtAovzgu/7As8gp6bY29trCgxOW40B2hoT28GvX3E9YJUNF?=
 =?us-ascii?Q?s3+msgI6c7wtfABLw6Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ac8796-6644-496d-a91a-08dcd97ca4ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 14:00:54.6551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqnV+I8/R6uFnmpruiEFC2NQsVPJVFWugACVOb+K8AoEgSP9e5M5X78kgMdvuOOhi1h+8TtlmPhCjtMZaIBB/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
        * Single Display DP -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz displays=
, HP Hook G2 with 2x 4k60hz displays + 1x4k30hz
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 1x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * PCON -> Club3D CAC-1085 + 1x 4k 144hz

DGPU
        * Single Display DP -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz displ=
ays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 818=
24f7aa52c0909085a083cfe24fd9241db7989 -> drm/amdgpu: remove amdgpu_pin_rest=
ricted()) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

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
Sent: Thursday, September 19, 2024 2:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <H=
amza.Mahfooz@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Ro=
man <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (T=
om) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zae=
em <Zaeem.Mohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, =
Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/21] DC Patches Sept 16, 2024

DC 3.2.302 contains some improvements as summarized below:

* Stability fixes in DML, SPL,
* Improvements for MST, DSC, eDP, IPS, HDR
* Fix clock gating on DCN35
* Fixes from static analysis checks
* Other bug fixes and debug improvements ___

Alex Hung (1):
  drm/amd/display: Add HDR workaround for specific eDP

Alvin Lee (1):
  drm/amd/display: Wait for all pending cleared before full update

Aric Cyr (1):
  drm/amd/display: 3.2.302

Austin Zheng (3):
  drm/amd/display: Set Pipe Unlock Order Outside of HWSEQ
  drm/amd/display: Update Interface to Check UCLK DPM
  drm/amd/display: Wait For DET Update Should Use Current State

Charlene Liu (2):
  drm/amd/display: avoid set dispclk to 0
  drm/amd/display: correct register Clock Gater incorrectly disabled

Fangzhi Zuo (2):
  drm/amd/display: Restore Optimized pbn Value if Failed to Disable DSC
  drm/amd/display: Fix incorrect DSC recompute trigger

Ilya Bakoulin (1):
  drm/amd/display: Fix cursor visual confirm update

Joshua Aberback (1):
  drm/amd/display: Clip rect size changes should be full updates

Kaitlyn Tse (1):
  drm/amd/display: Implement new backlight_level_params structure

Leo Li (1):
  drm/amd/display: Enable idle workqueue for more IPS modes

Michael Strauss (1):
  drm/amd/display: Block UHBR Based On USB-C PD Cable ID

Samson Tam (2):
  drm/amd/display: disable adaptive scaler and sharpener when integer
    scaling is enabled
  drm/amd/display: fix static analysis warnings

Shunlu Zhang (1):
  drm/amd/display: Change dc_surface_update cm2_params to const

Sung Lee (1):
  drm/amd/display: Clean up triple buffer enablement code

Yihan Zhu (1):
  drm/amd/display: update DML2 policy
    EnhancedPrefetchScheduleAccelerationFinal DCN35

Zhongwei (1):
  drm/amd/display: Monitor patch to call blank_stream() before otg off

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   4 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  19 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 121 ++++++++++++------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  26 +++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  11 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   7 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   1 +
 .../gpu/drm/amd/display/dc/dml2/dml2_policy.c |   1 -
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  |  10 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   5 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |   3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.h   |   3 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  27 ++++
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   3 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   1 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   5 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  41 +++---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  13 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   4 +-
 .../dc/link/protocols/link_dp_capability.c    |  22 +++-
 .../link/protocols/link_edp_panel_control.c   |   7 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   9 ++
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |   7 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |  45 +++++++
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |  13 +-
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |   3 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |   9 +-
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |   9 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |  16 +--
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |   7 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |   6 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   4 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |   6 +-
 .../dc/resource/dcn315/dcn315_resource.c      |   6 +
 .../dc/resource/dcn32/dcn32_resource.h        |   3 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   1 +
 .../dc/resource/dcn401/dcn401_resource.c      |  18 +++
 .../dc/resource/dcn401/dcn401_resource.h      |   5 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  12 ++
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   4 +-
 .../gpu/drm/amd/display/dc/spl/spl_debug.h    |  33 +++--
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   |  32 ++---
 .../drm/amd/display/dc/spl/spl_fixpt31_32.h   |  17 +--
 .../gpu/drm/amd/display/dc/spl/spl_os_types.h |   3 +-
 54 files changed, 456 insertions(+), 190 deletions(-)

--
2.46.0

