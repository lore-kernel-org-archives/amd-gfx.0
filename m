Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3EDE7718B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2024 14:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2FCC10E26E;
	Mon, 23 Dec 2024 14:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JMo1ofsA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6975A10E558
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2024 14:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohu2xkTOCes/xL/SGukcoLrGjSs/3tq/UnghAjDvrLy+CThpPXUpvM/qNy98pvVyhPHP307TAbHawCPTLDjWPfHL4U2iNw0S8jOYJiQ3JcPpO1gbAl2QOx1Xz22r59L/7SKDK3x3mnp88B+We8AHgBTeM1ACZhbBZg1cNvYB/OLdiOlXvkjjKQlrwfxM3kA2+F0z7pbkeA8ksSEzou+NX2DczkDXE7kAgYXoNZwhWZHPnYCq3hJVYjXxnb2s/wgX7A+scGHrzDreaDlfhEfWKxqsLd8ozKS59ZXrAGaxEQWCF3m4uSeUz5tZjGVCfPmpSVcIfGZr5+wqEaYvT24H0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPcoH2HRasJt18SDXPDHBBf74Le8towRaV0vYpEEGhQ=;
 b=ocmhZewrM4Fv97AeSJ0UPneX+JCTtqyMkdIE8K/pwP8ndyf+zHojiPwr7jkBjtMWCmzjYkRkRBtS17dkJXy4xV+MUeL/lLvvcR9RVGdRlr1nEYJ/3OD8d/Zsq3S8yFMu2wbXjrN1T7zAglIJLJzm9X67LYJxXLr2h0rTX+gy1/IK+E+Zt5WFSPaJBbVQ1pCXM21/rl7kYYype25qBD6DYVJnInLFEg7inupGDlBAIqgBSsUIB2Q4UgzhapnNLFPwKbaEd6BUw+6GtEZGrpvyw1CTMDo+vK0YQbv4e85hL+xE5Hrct6W6HfwhT/GnJWvoqrldj0+PgNSXhRsScredyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPcoH2HRasJt18SDXPDHBBf74Le8towRaV0vYpEEGhQ=;
 b=JMo1ofsADQdYHvzUsVqI2E87tTTa+vlL0y7BJJFEP8OrAZnaZICSviwyQSfMAf6DBC6JDRuearaEK1oWdWAcEtHXTezBuMZWFQhkPvYgGxGrsRZresahS+3igRY7B4aTf2eVAbfvLlPDfLY70TowVM5iiLxCcAU1zyLhxhIuHLQ=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.17; Mon, 23 Dec 2024 14:41:16 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 14:41:15 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung, ChiaHsuan
 (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, 
 Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH 00/28] DC Patches December 20, 2024
Thread-Topic: [PATCH 00/28] DC Patches December 20, 2024
Thread-Index: AQHbUyk8SdltpcTeE0uFrUV+qhuY9rLz6ShA
Date: Mon, 23 Dec 2024 14:41:15 +0000
Message-ID: <DS0PR12MB653432DEAFBB217B59B399B69C022@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=43fda95f-785a-490c-bc10-87eb1f64c702;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-23T14:40:26Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CY5PR12MB6298:EE_
x-ms-office365-filtering-correlation-id: 63455e78-239b-41f0-1201-08dd235fdad5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PJlTZt9lEp+oiChxADxo/x/SRIZhm99TAd5igWW+dFO5h4YfbzTmZI7Nkz?=
 =?iso-8859-1?Q?CoEeZt1iUWKYyKYo0T1kCT+mY/sWbCXifu3HyQ3xWp9e3X+xKteyGglvZ2?=
 =?iso-8859-1?Q?ZB3LnDQOb7rbTiFpg8SO1HFZYpLt2/VpB4L8aG4xY14B0YOWobstxL4IX8?=
 =?iso-8859-1?Q?GpWEk7XYelIatumoxMRQ06lpHJMqLe/qIjH1thcFucQtDiAK1gd3qxLuf6?=
 =?iso-8859-1?Q?FhqmPUGxLa3Co4xgQ6AGwbz3vs7vvS/U135BB3+O+ju2UlYeM6kLjSkLR4?=
 =?iso-8859-1?Q?xQFFC5X+2nWsTcpLXOo8IX6XUO94OloQtRN6iBPuij+eXx299/5+gvZBC5?=
 =?iso-8859-1?Q?2B11YIem/oa+UOe8lrxnQrtP/nzFl0GU1uaZla7xqGmPc5AoRoyKGeofz4?=
 =?iso-8859-1?Q?VtRU6AK50w8sT4aL1Abc+Dud/3Bux5DFxp3UH/khTcPBg2s3kleJOFzEPL?=
 =?iso-8859-1?Q?+3QDmpzrKQXXy1SnBWkN0aZXL6Kt7ZFjnzdTtwqS8KmPETrNmEIvUQm95K?=
 =?iso-8859-1?Q?Tt7g6AuNb3KGpw2sjDFCMx3wVVvXXwY2ytAUaz6gF+cn6Pmnu6CPvPxHPE?=
 =?iso-8859-1?Q?vKivVlpGRhC4vN7s8n4i8yUbVn9PVSHwRjGpIwFAkZb/NfX0PuZZfbohXQ?=
 =?iso-8859-1?Q?WYKbiNffF3pxwbniccB7JSoPlfLfrbTEya1Iq7DWDgd0STJaCNyOHZ4AhA?=
 =?iso-8859-1?Q?yXFJaHPbHPB7+m6+utkbot2qCf/0tf9jEG8ieks1BbZupsd0/72jDoneaH?=
 =?iso-8859-1?Q?OC8aaQ12+oohNucWI7rjPWHqNW6JslmJYrWdfcH7uqQwodvf3wBGckFp+W?=
 =?iso-8859-1?Q?Nsrs5N05vw47lyK7dS/L8Uk3WTRt3AnuWm0jdAF3tXpMUrrw+quuqghL5X?=
 =?iso-8859-1?Q?nIgWp33CjgNJo8oqQTt6cxOVJaDrx75ha1fxDu206bNa8VFrbTZUQPLGyK?=
 =?iso-8859-1?Q?zQSojTJp/dsI4AlR9lVONtHwswCv/2PG3XUf6jNNdkxSVoqrcKxMGbd06O?=
 =?iso-8859-1?Q?2fqXbVwHfylnuKet9FTWM/R8e5YrM3dHQrOwC+ogqyAnCGD7jVacDMqo78?=
 =?iso-8859-1?Q?j1HyWaJOWaHBZ3Qr//jXTBwHjai0Th88D0Gv8PJQFDLsPL3orqLzmaOzUs?=
 =?iso-8859-1?Q?Xku5WYjDnAKyzDMLSKoSyYhVR/Biu/eJ3xnXK/8wW3Qmsod4bu/zKS3aG9?=
 =?iso-8859-1?Q?x87rPmB+mwvC8aeHedrVoORvYKBl8wW0Bvcs4Kzjx15Xjkh7RcCen4BUUb?=
 =?iso-8859-1?Q?RPOCpURsnWwWPLp3X0fLBQGdBCNJjvBgxkhwNYfaU4TTwr4DS3mQd54cH+?=
 =?iso-8859-1?Q?uKQead+P0jWV06G18wtTEzVVd3XNzH/el2kzCeloAxdhXn8vG0L9SoUIpZ?=
 =?iso-8859-1?Q?c8ez9GupJGQQOdXN29aroWwFGqOvSQh5ZN9OB+M1mfw0SWyz/f27ITiFDG?=
 =?iso-8859-1?Q?HBlvEkmalpTZ3+pkgRKk/85e7T5daDbCSccPbPlR3uFfPSmdbYPJiiGsUQ?=
 =?iso-8859-1?Q?VmSy4CwOaKmIF+/qiSEg47?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ICG6R+K+zGf07OOpnuwfoGmazy038+JO+dK18CFlTCoNue7QIdpKJvlICr?=
 =?iso-8859-1?Q?ssLTBkaxEOQ+t0eJ4WDwttx8YyK88qDMFGW1TFNgwVrHmmWzuru3Wze5Hu?=
 =?iso-8859-1?Q?DwfZAwUeM2gMpB9doIZujqrRcLyo1yK4dJMTpacsrZM76qNzpE324FTmDH?=
 =?iso-8859-1?Q?BCDkSuBLzPbJHS1/3hmpIMNOq3OjvolCqID6caHQdSR7kh8ImPLRlynYSM?=
 =?iso-8859-1?Q?VlSX30VNODCVKV534Bgpyw3xLUqEzvP71ZVcJP+VjWkjpwu59/pQ3XBD2D?=
 =?iso-8859-1?Q?5Im70bX3qgYGSyGyWEzW8cy9LTXTdStDfdhmx6z+7U7TMxySuD7XHAMWho?=
 =?iso-8859-1?Q?VQazzq2HKErlluSN50U1SJaYuSN2pTWMD7SsZKJKmXEUXlxLmaBXt7g/6S?=
 =?iso-8859-1?Q?GU8ZIQi20+BC4GBlTf6jcixMBL0cGRrRlY6ECXeBFcDukPgnA3Rfx7D9KK?=
 =?iso-8859-1?Q?Qrci54hc3pYs1V2TkX0UT2qcmjwGag+/2L/3S1mbg2sjQ2hAamDmKTjTgB?=
 =?iso-8859-1?Q?HJMWISh88W0gWpza+YA8+n9/8BKC6B9fwDlTh9Z0b1C1Wn7yJXbJPteYQq?=
 =?iso-8859-1?Q?Wple5n/vTjPBzQJ/3lfVSXUCmNoiF4GFwCDrjHDzCEij5hgTahLJJwExUt?=
 =?iso-8859-1?Q?sGcnVy9MW5OiWg+m66BCS0LDrM6AAo0J2VI5LUrIMCR6YNi6Re4sLk/sjC?=
 =?iso-8859-1?Q?piV4X1ykbXQ/afV5ydPUG5frd9JMA6/MWXWbnqTyNm0MLX41RMMP9yQksq?=
 =?iso-8859-1?Q?rUFMkqxv/hmRFLMMZWstcEqQ+gMwhJ6Yc8stvixoa+lYfOaQtOFB4kBu3s?=
 =?iso-8859-1?Q?EjrgdrmWUxD+nz4Lrqbcw3X+eVhEN+Gxtqpg/8OM2mv7qp9L+wVKsGrwll?=
 =?iso-8859-1?Q?Y4NG/1q0ONKcl0F1eafd8dAT/A3Hp5PYwUVeGVzXdLN6w0NS7PXYnYOtMF?=
 =?iso-8859-1?Q?6wCKxG+7EYLva0ah2YqEkx7OykB1rbi71ZeaFjkWygmvniuHapwd49EW7H?=
 =?iso-8859-1?Q?H6uMSye/3QTlhm5FwtOwemSPN61vDWarorw2jn8UyRetDAfkKtFgroHdoy?=
 =?iso-8859-1?Q?M7IS4Hxo7vP7I6aS5p4mGkBQimBdw+Hxw9P4kzIzBvrdCUoA984dEdNNOh?=
 =?iso-8859-1?Q?8jbw3VZDRr3qJeBcu4EFvbavu5rTaLJXKD+l0klL4qTvv5IEFEQnTJJLeg?=
 =?iso-8859-1?Q?s2q0zoQltRYL5gVgQIYa8hJVHig46sYSbntcnQOtYKjwU0WcbyPCkLgZxg?=
 =?iso-8859-1?Q?A4OGlPMCmEhLTFOiwTBU6ydrcz0gSQVbDZQf6ggJKn9w7feuwTUfRdZM+2?=
 =?iso-8859-1?Q?MnhYF3CTS2bL7LXvC4MCoR2IfHiT9ZGgkJNNIcN9KiPKtceaScMwrJGITt?=
 =?iso-8859-1?Q?Ug2Sr12EpqAqZpxMYzYmPvRlci3+NyYNYp/JfLLB8Q9i0S3BFSGNZxRo1S?=
 =?iso-8859-1?Q?JiiEXrb5N0sul2bJjh09Xcb9aj+KNob+nEa1icppydLCNIJlKp882y4+pm?=
 =?iso-8859-1?Q?3pSRnRrvTYzpLr99r6KGX/3txtsJOQ9myIcOtemlow/vjQqF38f5YBVDKJ?=
 =?iso-8859-1?Q?6yjV5ha3dpIV1nGwAspv0HYubET8JkR57d+wUQ6u3uDOmOVk8R17r8A+/L?=
 =?iso-8859-1?Q?e+aRF/63I7TIo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63455e78-239b-41f0-1201-08dd235fdad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 14:41:15.6679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7h20hPvrWP+ocEcy8mcitGBD7OP5mCmRRWTFwxQx6A2PIXtORCKX9Z5AcKzdUWK8gyYVZnxSX1QxGdtWkwJbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
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

This week is the last test set for the year, the testing will resume the we=
ek of the 6th of January 2025. Have a great holiday break everyone!



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

The patchset consists of the amd-staging-drm-next branch (Head commit - 179=
c7f1e901522b474135c66a5ba00e7a743eb89 -> drm/amd/display: 3.2.314) with new=
 patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Friday, December 20, 2024 4:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerr=
y <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Chiu, Solomo=
n <Solomon.Chiu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Li, Rom=
an <Roman.Li@amd.com>
Subject: [PATCH 00/28] DC Patches December 20, 2024

From: Roman Li <Roman.Li@amd.com>

 - Improvements for DP, Replay/PSR, DML, SPL, DCN32, DCN35, DCN401
 - Extended logging for DSC, VABC and stream crc
 - Optimization for cursor position updates

Aric Cyr (1):
  drm/amd/display: Optimize cursor position updates

Aurabindo Pillai (1):
  drm/amd/display: Add guards around MAX/MIN

Brandon Syu (1):
  drm/amd/display: modify init dc_power_state

Dennis.Chan (1):
  drm/amd/display: Implement Replay Low Hz Visual Confirm

Dillon Varone (1):
  drm/amd/display: Cleanup outdated interfaces in dcn401_clk_mgr

Fangzhi Zuo (1):
  drm/amd/display: Add Interface to Dump DSC Caps from dm

George Shen (5):
  drm/amd/display: Parse RECEIVE_PORT0_CAP capabilities from DPCD
  drm/amd/display: Add DP required HBlank size calc to link interface
  drm/amd/display: Add expanded HBlank field to dc_crtc_timing
  drm/amd/display: Add HBlank reduction DPCD write to DPMS sequence
  drm/amd/display: Add 6bpc RGB case for dcn32 output bpp calculations

Iswara Nagulendran (1):
  drm/amd/display: Add VC for VESA Aux Backlight Control

Karthi Kandasamy (2):
  drm/amd/display: Update dc_tiling_info union to structure
  drm/amd/display: Ensure correct GFX tiling info passed to DML

Martin Leung (1):
  drm/amd/display: Promote DC to 3.2.315

Natanel Roizenman (1):
  drm/amd/display: correct type mismatches in comparisons in DML2

Peichen Huang (1):
  drm/amd/display: have pretrain for dpia

Roman Li (1):
  drm/amd/display: Add check for granularity in dml ceil/floor helpers

Samson Tam (2):
  drm/amd/display: fix init_adj offset for cositing in SPL
  drm/amd/display: Clean up SPL code

Tom Chung (2):
  drm/amd/display: Fix PSR-SU not support but still call the
    amdgpu_dm_psr_enable
  drm/amd/display: Disable replay and psr while VRR is enabled

Wayne Lin (4):
  drm/amd/display: Add support for setting multiple CRC windows in dc
  drm/amd/display: Extend dc_stream_get_crc to support 2nd crc engine
  drm/amd/display: Adjust dm to use supported interfaces for setting
    multiple crc windows
  drm/amd/display: Extend capability to get multiple ROI CRCs

Yihan Zhu (2):
  drm/amd/display: update sequential pg logic DCN35
  drm/amd/display: power up all gating blocks when releasing hw DCN35

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  31 ++-  .../drm/amd/displ=
ay/amdgpu_dm/amdgpu_dm_crc.c | 214 ++++++++++++----  .../drm/amd/display/am=
dgpu_dm/amdgpu_dm_crc.h |  23 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  31 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   2 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 240 ++----------------
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  75 +++++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  38 +++
 .../drm/amd/display/dc/core/dc_link_exports.c |   8 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   2 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  38 ++-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  16 ++
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   5 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  | 179 +++++++------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   6 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  26 +-
 .../drm/amd/display/dc/dce/dce_mem_input.c    |  10 +-
 .../display/dc/dce110/dce110_mem_input_v.c    |   8 +-
 .../dc/dce110/dce110_timing_generator.c       |  32 ++-
 .../dc/dce110/dce110_timing_generator.h       |   2 +-
 .../dc/dce120/dce120_timing_generator.c       |  34 ++-
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |  80 ++++++
 .../dc/dio/dcn35/dcn35_dio_link_encoder.h     |  18 ++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   5 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   4 +
 .../drm/amd/display/dc/dml/dml_inline_defs.h  |   8 +
 .../dc/dml2/dml21/dml21_translation_helper.c  |  16 +-  .../dml2/dml21/src=
/dml2_dpmm/dml2_dpmm_dcn4.c |  12 +-
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   |   6 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  30 +--
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |   7 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   6 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  45 ++++
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |   4 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  12 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   2 +-
 .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |   2 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   4 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   2 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.h    |   2 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  14 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   4 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  41 ++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   4 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   8 +
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |   2 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   4 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |   4 +-
 .../amd/display/dc/link/hwss/link_hwss_dpia.c |  61 ++++-
 .../amd/display/dc/link/hwss/link_hwss_dpia.h |   3 +
 .../drm/amd/display/dc/link/link_detection.c  |   3 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  20 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../drm/amd/display/dc/link/link_validation.c | 179 +++++++++++++
 .../drm/amd/display/dc/link/link_validation.h |   5 +
 .../dc/link/protocols/link_dp_capability.c    |   5 +
 .../dc/link/protocols/link_dp_irq_handler.c   |   5 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |  33 ++-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  19 ++
 .../dc/resource/dcn35/dcn35_resource.c        |   9 +-
 .../dc/resource/dcn35/dcn35_resource.h        |   1 +
 .../dc/resource/dcn351/dcn351_resource.c      |   2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   3 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  99 ++++----
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  64 ++++-
 77 files changed, 1356 insertions(+), 576 deletions(-)

--
2.34.1

