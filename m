Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942A1C021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 16:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E4F510E0B5;
	Tue, 18 Feb 2025 16:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tG4K51LU";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CB710E468
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 16:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpUUY7rmRRvnb73BL8mevFcRDzaFZrNQ90qOzfb9LxPRJc+ymt35F0NOqT+88KUtj3legifPnVTahJWP525IHDj5KPJQKh0tSwGSgx0AN56KvDWimfcfPq1uwPpDiQOd4/i3obA/doL5DASxRspI8kKwRQ/6LfEU4YJbvyq3vlrtbUvntJwWHXoFqhqFlWtFH00aQ8OI16QT/Unhu/NTotazUqS1+cP4pwUag7wrQ+04XuLbX3Rb5t6nUq38SCtISWmZIAp0pf2aLAqmLZGinq9PYheWICgnyvhCdiG+zQwn8X20yzfm5yB81rc0uUoJTiYpV+fIXa9ni6gboB4y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejxZP0rhdk3uLhWWAkUICeL/HkVJZDuqqwML87xQJP4=;
 b=N5X6nzp/xpsJ8VZZiiEhnXd+pI67n1eFCpg50N8nSFIDdwJ7d2bdfuI+c3Qc7UQfPsMV7oVbjrMtGpV5cB3Xy5HwewuP8CdqS7bgoq5eYyMZXJOYNXb62emH+X5j6n3FXc3n2ZP6syypXc6Euu3TJjV+a1b2SCdZ55YOF6OnNqHtLfCrJbON7hsEIROiccVKp3Y5P3sAuxKta7KXsBwYQ1g+bDh/oSJyP1DnLILAIRhX5X32vnRrIHkmPkuaMf9rl15fdlCFq2lSi3ahpmNYAZABwNn5wXiRrEtqxBSGTM4XbzWOWkYdtY0CUKZQ0CZTEO+clxBIGWfGkPfNQMY7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejxZP0rhdk3uLhWWAkUICeL/HkVJZDuqqwML87xQJP4=;
 b=tG4K51LUuu71u3mYGHmuY5Emn+JbsM/o9N+jQiSRiM0NgjEJnoreDTcTJuerPJ7wGRyJcKvtlw2ounKOleO/kp6oGDjh8rF+GgIJovW26xpsO21a5b05XyPX4FjqDtWn/To9Y7RgSylsajwrzwmXw3EHMIlw23ErEEgF/NKhjvk=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Tue, 18 Feb 2025 16:10:32 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%2]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:10:32 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon"
 <Solomon.Chiu@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH 00/16] DC Patches February 14, 2025
Thread-Topic: [PATCH 00/16] DC Patches February 14, 2025
Thread-Index: AQHbfvFaH+BdNIMA5Um0z6GrCW4y37NNQMWQ
Date: Tue, 18 Feb 2025 16:10:32 +0000
Message-ID: <DS0PR12MB65340F4CE28B60ABE59E0E2A9CFA2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=fa9574be-1d3c-49e0-b77f-74746c60d602;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-18T16:09:47Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM4PR12MB7648:EE_
x-ms-office365-filtering-correlation-id: 06419419-3bf6-448a-91b0-08dd5036c565
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3atVUIHozlfx10WPbKlg/7wiZvx8dZVLYm0AsSY7Xqq+kuvcAWwkfi1ap6sK?=
 =?us-ascii?Q?tnwVwS1Qgvz1FuGeUF01ht/MGCgfGRrvQAmKbZfGgKRUdTYEy7MF5ECtCk1e?=
 =?us-ascii?Q?jP+VUIxM7nGhDOQS3altGIr6veSncgrHecRt/RljfyTbECIml02qkfPJFgK+?=
 =?us-ascii?Q?GjVRMpK76ip3SWBrH7AnKf7/HQavf2Zr0TY0iDqrtKlohxPT3i3ms97BAj7h?=
 =?us-ascii?Q?5SOAR3vDR4UCfIwBEE6pA9QCD4Xyt3G1M+mez/DrxF5j5L0OetMqU24LFMrL?=
 =?us-ascii?Q?+4iGx2LUHR3wEXkwkvKkjhl+KU1lFtZN8nuMqP64B2pZbUhFFiYCTpArCWX/?=
 =?us-ascii?Q?RfgtUuHWI21m1F9NnuIRDJoGhsHWPMV33CkeKP2iY83sNPPCYGR+vOH9sLyK?=
 =?us-ascii?Q?o5UguemEHVo8d5Dc0UtT4geEz6b7Hj29a68qB7cCkr6kRQYjzwZASQi00mnH?=
 =?us-ascii?Q?YM9/BH4y1xtLa8C9GAgRf4fWgIwMiR4laXyesvkKzkP0hkuA6/NeSTtqce2E?=
 =?us-ascii?Q?QqjWtFbNp0J5BLxpV0owDV2R9BKQDUiYygb1qKge1OZUpDtlA0Tien+nwoAD?=
 =?us-ascii?Q?8axK0ixYOeoTv1guvodvIY3KILgvNIwqbRNurBjI+kLt7qz07DYs31ukGofR?=
 =?us-ascii?Q?v4aWD5qI6H4kfGy8N4dPFSdO1Q9o38kHIEJUjcpd12HWWmcUIJ7/DHofA4W4?=
 =?us-ascii?Q?F6jwioLTAHq2KajBbiSG8e5W29Y/HgcErUuHkF8OqYPpp81+DukWZSmJ/DbY?=
 =?us-ascii?Q?2/0U+TSLvJYtnhE6+oEMGAcMvewRUwPcBte+aCQYooGhzpztQ0F/KII6jN5/?=
 =?us-ascii?Q?tYfLDuprDyoF3/uNb1dktzSP2E5iZgXlPRhFObYpbvMYGrU8SF8Zrs8P0I2U?=
 =?us-ascii?Q?SAP9j0+SfxZO4NYZdGYCBqc9K0K9qMkVb1XScAozzcOre+GmHt0bHvhvKEbc?=
 =?us-ascii?Q?jjOnnLvrnqL+EeRABbUuyhkUdzMdIZv6qtROPGrwklZCaIt6EJcRXvBOjmDv?=
 =?us-ascii?Q?4rfC2gRNYMyzE9v8NGUVpT77TKo9zmGdz1/Qd2hQoePQveJuKgzZqb84/TR5?=
 =?us-ascii?Q?qKy//bIOz4uoaMJwt0094d9NvvI1qL2l0PBd3MunuYwt9NFTRida55lzDwCj?=
 =?us-ascii?Q?tWgkvlv7c3LX/MsXboUAzjB2Ob6vbiSPZtCo3Hl487GQLkr8jxERTQb20g/Q?=
 =?us-ascii?Q?3QInQPtnkI8vcw8SVyx6M0k66WoQR5nKtxxUSdYQ+mhWYPj7827dHTaaSIN3?=
 =?us-ascii?Q?+I0RHCGYqiZfu4v1yGAMoRrb23aTVLoks2muYwFUmKVhbrbx8z0wjkklHgeY?=
 =?us-ascii?Q?9eEq45Fs/8h3tmoaEG6Y3CMQnUpxNS8EyB2bNHmhY3cNvVR0mnUVrx3DS2+b?=
 =?us-ascii?Q?KBnol+nIuNJGl+XeEg5fxPvVFJVxx0vt+x3g/vtI6DDT3vc8KZ4yYU3y3Hzt?=
 =?us-ascii?Q?mGpFCLtG4n8qVptg6fXaksSpxNN+WxuD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5iSUWpsf5hMIz9Zo/GEF2piydhbUjpnsRSJ8HyXce26ewVkENHagwmdnrHpQ?=
 =?us-ascii?Q?rST59iI7oXm3IGK6hLPCwr1ouTibM4WZ/gbi6hQWWZgS0oTzxBqJA1TXq/AY?=
 =?us-ascii?Q?MVKKou3fYBMji40HN9Ma17Af4R6A0W2y2uts8TyuW/b0DTQcrv9Ibu8lIj1W?=
 =?us-ascii?Q?F17wfXplyS9SXNqLRvYSBsPTMm+4J9ZddkhG90ennvzsW2ODlNABzLFvsXGz?=
 =?us-ascii?Q?6TfWFDFcxoMmGRd1gZ4sdG4nuaZWEBx/Yegm54G8b6jzNeaN6lcc0Gj4TxAC?=
 =?us-ascii?Q?916G79pwgBYG++Rf3sjkvIhaGFVQEa5PkTK9WPtDuoNV52PZbUVf6t7vxStl?=
 =?us-ascii?Q?6HYGHN6Zzt+0gkNQTZsnSWhc7wD8pRfc60DdanjLkDCRmV2BHqCRqo3Ow0PW?=
 =?us-ascii?Q?gUzA2PY+27Y3943cp38KrBkFqzeMgOu32Ka7Iondpope6jF+Pwd9F0DuZCu9?=
 =?us-ascii?Q?9TYGJl2S6FBj1vJidKFfvQr+3qDnZ1ZFM8qvs5OdWLqc9dGQJYwz9FP8BJQh?=
 =?us-ascii?Q?VlesRBfBa6a0CXTtdxmSosW3Q0V5nYlLOjGVaY1hw8TeVyH8JCJFxhfrCxLy?=
 =?us-ascii?Q?oZPjjiGczrU4tIMw3pozEYuX9pZkHYp0bMeU+TV5TZ3Ofs6BKEAyRvgngkyx?=
 =?us-ascii?Q?Wlj23f1sS8UY1CnVsCpkdKEvj+2mr26alv3X1b+4k8FfqmKD7dzRbGfHvuIg?=
 =?us-ascii?Q?JDpv/q+HP/kwsYQAtNgvC9/dh3LUPruE2W0INKxzOCd+EI0aYUQHtpBOcm1I?=
 =?us-ascii?Q?6pPO6CDGkT3uGQOs/gGdEdJndFDeIORl4SKaRBwKa2LDpyWise76ao5zWTO2?=
 =?us-ascii?Q?1ihqv8BHyZbtin0LnotXmK8fk82k/e/YkYOf8qSeXVKj8ZIt5BrYh8rI4j4B?=
 =?us-ascii?Q?jiwDkjrQBlROa22P4DjCgnUkfFdcSA8BkLyG81gR5ob7abr4+5BQjizrRz4f?=
 =?us-ascii?Q?U5IgAnK5jxT1ynFsl+JmBOJg9YbFsivT76c9ZsI1szQKx3SZM485d6rmdXLZ?=
 =?us-ascii?Q?gOeHG1rdnla5Z7OGkk1taEACJ5KjByAzqdHH6m9LW07878wg92MAhX5kVcBS?=
 =?us-ascii?Q?x4FNA2apI3/yT35a9TelnukNtJpSi0bPLFMY8GPqrQntAz8osbn6gBmhL7lG?=
 =?us-ascii?Q?um1IClZrCgIrkM/aVzaMC9ZzgxDET+OmAUUjLypJ+DZHOvGZueL2gLilU/zc?=
 =?us-ascii?Q?FliAfkjo9XPRun+y6DpEK14Ktc7SHKkoilBSWqYsgYzHJixNE/R0tWkUv3Q4?=
 =?us-ascii?Q?xFLNWS7SLtYoaCkhpzwKvhssHIQ3ldkEFQ3hHWVSxPCv0iB7tgYuGCDdO6EG?=
 =?us-ascii?Q?bDU6Nmm2Sjd5epdMQkG2XqQszDJ/3WwJ0wBvnJiydCDn9ap4vo7QbHW0zZcW?=
 =?us-ascii?Q?Qf2M532HK8by7pmimpcCRoZ0B8kcxYt5xgQZhPFneY2VR+8kxESvUvbKtJ4n?=
 =?us-ascii?Q?+RKCS7LRr2bJz0LBqwbMZtnGtKdwUzYEkqk8vTd2rFSm+/HzIFJyyo5ga4rF?=
 =?us-ascii?Q?LBDoIYNV2If7UnXd4xE2JyKohiz+D74g6X+s8dR3+/deOwg8UAbqGAtVycQ4?=
 =?us-ascii?Q?/kfbZvKWbYpDnEObD/Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06419419-3bf6-448a-91b0-08dd5036c565
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 16:10:32.6139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jix0iO957eulTrTmXPoDcUFj/T4tBgD+T8T7a6174mPt1j3BLp43vPYfUwAJfpmZ+gtMd1T/2mMCmX3fPTZupg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

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

The patchset consists of the amd-staging-drm-next branch (Head commit - 662=
1ee40ced88ecf6b9901e26a11ed1b56e9e9f5 -> drm/amd/display: 3.2.320) with new=
 patches added on top of it.

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
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Friday, February 14, 2025 10:00 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.M=
ohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, Daniel <Dan=
iel.Wheeler@amd.com>; Li, Roman <Roman.Li@amd.com>
Subject: [PATCH 00/16] DC Patches February 14, 2025

From: Roman Li <Roman.Li@amd.com>

Summary:

* Add support for disconnected eDP streams
* Add log for MALL entry on DCN32x
* Add DCC/Tiling reset helper for DCN and DCE
* Guard against setting dispclk low when active
* Other minor fixes

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Print seamless boot message in
    mark_seamless_boot_stream

Aurabindo Pillai (1):
  drm/amd/display: Add log for MALL entry on DCN32x

George Shen (1):
  drm/amd/display: Read LTTPR ALPM caps during link cap retrieval

Harry VanZyllDeJong (1):
  drm/amd/display: Add support for disconnected eDP streams

Harry Wentland (1):
  drm/amd/display: Don't treat wb connector as physical in
    create_validate_stream_for_sink

Ilya Bakoulin (1):
  drm/amd/display: Support BT2020 YCbCr fullrange

Leo Zeng (1):
  Revert "drm/amd/display: Request HW cursor on DCN3.2 with SubVP"

Nicholas Kazlauskas (1):
  drm/amd/display: Guard against setting dispclk low when active

Oleh Kuzhylnyi (1):
  drm/amd/display: Add total_num_dpps_required field to informative
    structure

Ovidiu Bunea (1):
  drm/amd/display: Exit idle optimizations before accessing PHY

Peichen Huang (1):
  drm/amd/display: dpia should avoid encoder used by dp2

Rodrigo Siqueira (4):
  drm/amd/display: Add DCC/Tiling reset helper for DCN and DCE
  drm/amd/display: Rename panic function
  drm/amd/display: Add clear DCC and Tiling callback for DCN
  drm/amd/display: Add clear DCC and Tiling callback for DCE

Taimur Hassan (1):
  drm/amd/display: 3.2.321

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 ++++++++++++-------  ..=
./gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-  .../amd/display/amdgpu=
_dm/amdgpu_dm_debugfs.c |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  6 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  2 +-
 .../gpu/drm/amd/display/dc/basics/dc_common.c |  3 +-  .../display/dc/clk_=
mgr/dcn35/dcn35_clk_mgr.c  | 13 +++++---  .../drm/amd/display/dc/core/dc_hw=
_sequencer.c |  5 +--  .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 16 +=
+--------  .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 +++--  .../gp=
u/drm/amd/display/dc/core/dc_surface.c  | 31 +++---------------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 12 +++++++  drivers/gpu/dr=
m/amd/display/dc/dc_hw_types.h  |  4 ++-
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |  4 +--
 .../amd/display/dc/dce/dce_stream_encoder.c   |  3 +-
 .../amd/display/dc/dce60/dce60_hw_sequencer.c |  1 +
 .../dc/dio/dcn10/dcn10_stream_encoder.c       |  3 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |  3 +-  .../drm/amd/display=
/dc/dml/dcn32/dcn32_fpu.c  |  1 -  .../display/dc/dml2/dml21/inc/dml_top_ty=
pes.h |  4 +++
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  5 ++-
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.c   |  3 +-
 .../amd/display/dc/hwss/dce100/dce100_hwseq.c | 30 +++++++++++++++++  .../=
amd/display/dc/hwss/dce100/dce100_hwseq.h |  4 +++  .../amd/display/dc/hwss=
/dce110/dce110_hwseq.c |  7 ++++  .../amd/display/dc/hwss/dce120/dce120_hws=
eq.c |  2 ++
 .../amd/display/dc/hwss/dce80/dce80_hwseq.c   |  1 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 29 +++++++++++++++++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  4 +++
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |  1 +
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |  1 +
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |  1 +
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |  1 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  1 +
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  2 ++
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +  .../amd/display/dc/h=
wss/dcn401/dcn401_init.c  |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  6 +++-
 .../dc/link/protocols/link_dp_capability.c    | 12 ++++---
 .../display/modules/info_packet/info_packet.c |  4 +--
 47 files changed, 192 insertions(+), 87 deletions(-)

--
2.34.1

