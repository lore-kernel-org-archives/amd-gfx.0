Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C616FE81BCB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 14:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59CF510E402;
	Mon,  9 Feb 2026 14:12:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ydD0eS3i";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7DEF10E402
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 14:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHUDXL1DaXYqKYTFcxeyR3Cl0g7AfpGLEiligcEd2Ho3K6e3geE5GgZ2SD3DsbZNE87obLxy5stjS5iiZrmlWTxlEI5P4hMoRN42ohdnWXwa9cMioxwL9X9H95iiVrGDMY+iRYrJV+oHCajWYnGWyr/aa0UwefrExuhsN1YEiiYOMiXoUm7LkISMN9MNFSTA0oY1kKLcQjYidxHl2AbRG4dWnX+HCeQ+tDtFoAYOwvvyl59FPPjLMAGk2ybTYsPNYrpBj5ihemteZ4F7sh2Z+0xAjO4pSliYfJ/TQOLK3r8pDGmwC+7ymwiWHuVqool2B0iQgTnV3T6Xi+EmmsJn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+sgu1q9nH5yK3Yz+XiKh0YkpJneR13XmAnN7B7CbaA=;
 b=MNlKywgwNZOyBN8VoO9kmoziB+OeuoGHe8QYZcvoa3TEua2+ex9nf0paoJ6TYIuPyxTBnDGFyptA33Rjq0HCyB7PXcNGBCwB6fJXSFOdFsDisLrcdr4PT+LLSRiGRY3uw690w6/MNdDWNz4Xxx+wJ/+KA9M9l0Zk4o46J3UA3yl3zkU6a2VhykJp4ApKNbPVpZJQdWIim48wFwHvxMTk21S6Ky67moXvw+SeqEq8M65ycV2B2BPW6Tv7TAe/KMRmfzuP11x8K4sIUtUhloBuLnERHtP5V6NzNi28PYR1czSp62erBWJBpMmJ/k/bZ1BmZpp810Nr9YVB65LDdiWVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+sgu1q9nH5yK3Yz+XiKh0YkpJneR13XmAnN7B7CbaA=;
 b=ydD0eS3ih4AdxmgRlshCtqvyubBUH95BO8tyKTVuJTYNRsD+scP+uHJO9p0jA/vg5HXQR0xdq0ozQoHmuc1VJ9B9WbSwNO0oTgWPJcYGvEMugJfFfnZw8AxMuurbIHq24SzHo/gK/8icaaDFGExBd5rfEEyPzAEQJS8X8ojXjlk=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 14:12:31 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 14:12:30 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 00/16] DC Patches Feb 09 2026
Thread-Topic: [PATCH 00/16] DC Patches Feb 09 2026
Thread-Index: AQHclR+UPFVZraDUXEitapGnPkP2O7V6cbyQ
Date: Mon, 9 Feb 2026 14:12:30 +0000
Message-ID: <DS0PR12MB653478598E68EAC0377C67909C65A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-09T14:11:46.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|LV0PR12MB999092:EE_
x-ms-office365-filtering-correlation-id: 4fea2a50-b4c4-4a5e-9282-08de67e54355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?tcrVluE4pA+wzRIB7Yim1AIsh/mKMw5rc3hGLXOybxb3qNmk9WLwGYIHO/?=
 =?iso-8859-1?Q?3q9hl1o2gaoBm+U3k7hxLveBbVPb4VLtVDjRzVA1dmalmYd4jvMCp0JHg9?=
 =?iso-8859-1?Q?qUzZ96VrR6bxLxktCwDWrBTqD1oaXhA3gGxwErJ/pQFsRv+qtm/79lu4+Z?=
 =?iso-8859-1?Q?/uuH2XGh2h7WnKqrk0SQwKk9InW8oepytOfmOWlmuCH3Hfg7hypbiairnG?=
 =?iso-8859-1?Q?PEdmVaFwMMPefoUWu/UWIiVZcOKvhIAmF+LBc4JNKfIQp+JqKMknIEfsUQ?=
 =?iso-8859-1?Q?GD+TimS4kktbsoG5kkOLuz4F8efk3Cp3fI2ijSJgq35i7Z2XBgmRv9xW5E?=
 =?iso-8859-1?Q?Yo/je7qKQWpmjecYwxOEiwp+5CykSsBat2psZGIU4o0FkJy3EaCdURSP4K?=
 =?iso-8859-1?Q?R5BcN7V9qTr1soqE8cWPTzzTGLqAdkKd2Mbn9dvq04IQjBxcagZNwUI1FN?=
 =?iso-8859-1?Q?DMitu722/Bgj2Vuzo9CI/3JgTRZw/d2BuHjIJDAazad52YVLqq1x6QOcwA?=
 =?iso-8859-1?Q?/bqWV3ApAsN+YvZywZqOkaHcqlFOqKG4bAUwqdSbpfE2hjOujBoAl+l8aj?=
 =?iso-8859-1?Q?g1BNPanFBmOkl0J9+9RyCNPcfCr5p6KrubcgP82IDpvERgNWIGI8BRxRCa?=
 =?iso-8859-1?Q?QvwWfKlFV0atq94o2CD97teaEKXEjapj7fyq7rtDL5Wuk1IsGBNtgMLXpZ?=
 =?iso-8859-1?Q?Ack8mcQXQLvph8WTlkqDqhgJvGRY809JYblQS+52SE8EQMn7DiiqW1s5F/?=
 =?iso-8859-1?Q?Aa1Q823Om145o3o7dSINoQ0MHLIozegPporPWXFeoBIJjbmg9FE1muSu6C?=
 =?iso-8859-1?Q?eBJ9iThf+vhjtjyKlg74CJGq/4Cx762ozN7apuKeqCJ/A8c8EYZp2PnBzS?=
 =?iso-8859-1?Q?fqHgD4qWfvQLID6feDOresliqtteWGWcqfqMEF6eG79uYzGpU5kO0fhKtd?=
 =?iso-8859-1?Q?cDvo6qW9yNczrCn7S22k+7ir9IsB2wqBWDwzKUx7XCRPxjr28LydZ7nNdR?=
 =?iso-8859-1?Q?+MaV0EEldLpC6k5+kN5qdlSAuctuIvithglGt6OnUmEeCudki0IPgeFFa1?=
 =?iso-8859-1?Q?8m+Lub79+qzQiYRXwEr4Im/n9B0lzgPJdBaltRpU5tTcxYK4uczwu6Sq08?=
 =?iso-8859-1?Q?teOZonGDPt3hmT2y4giTHmacqsPhQfQyu+4lQwCVc3+XKqeYtpV+loOnUX?=
 =?iso-8859-1?Q?+u2PByHzABHrjW6L5E02ahHwQK6qp9S5I0rBbwW7JSEBQs0k2X+xX1n1lo?=
 =?iso-8859-1?Q?+BSi8l8oLKR5ykO5hXh0y3zhoNdYdLbkWiMZMD3G3IRMF8HC636JnHiDkA?=
 =?iso-8859-1?Q?Rrn5Lwy51kabuGrmfjiKzZMOoyCs6PGMsPu25YBATiJOmRIsf/4unNx1NQ?=
 =?iso-8859-1?Q?Lh43s1z4R6EcwGsgFACAijZYC6rKSuoa9Po/BmlFESEUixT8m9HqHM7Qxx?=
 =?iso-8859-1?Q?XjG/OpjcoBlIgp+Ab9HoEdeeLBZckSaHlCiD43sKxYexfGFZDuchU9Nq0j?=
 =?iso-8859-1?Q?Xspklkgsv5Q+0enA+RZ28Vw3ms28kITSrb0IIJzJMnErhOSOSuFcHZyhS3?=
 =?iso-8859-1?Q?K3eN0wg4AbasHFOgBhJs9V0cGDsCqBmUNNjU62naCEj7togFKFQL9au03j?=
 =?iso-8859-1?Q?K4/UWc8fFLO1J+qTwRNmS8GCFKkVBC4uuG9aFZr0WbT5sWF4+PqM3aHGm8?=
 =?iso-8859-1?Q?MO+pPMpO4K87B1w92Z4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3uswxsWTafoYGiYKe+cUjW+lvn2h4+P9dsW2cVwLVbVVtOyZzMIC8wAOvn?=
 =?iso-8859-1?Q?26SLscuktIWGGrmnPG1tCoRXj17Sxm8OYyu+PpET40tBnD1eS4f4nLJvNs?=
 =?iso-8859-1?Q?9miEO9iugHQlcs5U9PyIcvxvOHYjTsFJ7QRtqA27t49nw8FYj4f77JZUcC?=
 =?iso-8859-1?Q?vsZEZaWrXJnkhsqgXFgDSvvV7Zn9J2MLMScmRZ7ub+jO3uB+L4tqVNjcSM?=
 =?iso-8859-1?Q?Q9jLRBDlV7eR4UVYxBCRsc+LGs+pmBV0hRemJ0kXBpAbs776cRA7ZgHgPV?=
 =?iso-8859-1?Q?iWjnYmPxijpKWQsM9+g0H9CN6AQcYkPRmC18+1l2SP9ANFqtl70lDXP7wr?=
 =?iso-8859-1?Q?IMshm8luTNWupGSD6wRYxezwRuFlMsRQHcYD5HO0mQeiOI/uSGqycUybI0?=
 =?iso-8859-1?Q?/Yxqany1usWW6Sjv7nvsahHpOB4bBWaXmj56gQ6BtG+MGFKgOqnaqj0ii7?=
 =?iso-8859-1?Q?PsFm7empZPbtLOLuTgI8sp2ikl/30E+M0Sz7+nChhknsEgYMIV+DWdggPx?=
 =?iso-8859-1?Q?42bDH1J+LcPd1qzUWnilUbNlFQajRS0sOSEiKr+oOhc9PRU9PpPUMBWyCW?=
 =?iso-8859-1?Q?srL5OgEO79BU1iWjaav04PxBhMtJoY0q1iXgSu4As8ci0BtIjaBVKyd4E1?=
 =?iso-8859-1?Q?avq3d3EVVq00884vmpjmIoDtBaW1t0ZRuettwtJKQC+bEGH7kZ9p/eTB32?=
 =?iso-8859-1?Q?0yvwVGms/9W4Z57Yxy0MjMhlNEkVXOnD2APZayRGHdsl19dbC0kUax19Ul?=
 =?iso-8859-1?Q?d+ieJoisPWxswyWxiBMlv7IdJzqH7olg7relrBS7J05IIMIL7pRLh4iPKz?=
 =?iso-8859-1?Q?MU4uYPnq8k4E5q2cjHwVTrNcWfeVUFS518fg1EQmdAkxZ61N8+GOZ53+FN?=
 =?iso-8859-1?Q?Rv6pMpNYICwbnrA5y3k2lb4R/Y/dZXFP1lUEfhSsGkgsDvoV3nF6pVEf61?=
 =?iso-8859-1?Q?uJ0DW5lXsUUvkZ/tZazYAEstb1HM/pVx7roITtgK1Nz0nam22tG/pcBQJ1?=
 =?iso-8859-1?Q?HYv/WU/TWqU39wSZ2OKNiby/fnqr6wknfWnVHvdHL1aX0a9W7/9a6EyZ29?=
 =?iso-8859-1?Q?7q1hAn20ApRjLjpVEJWUpHqzqcHNvyURb27xRjOUWXgf1fGomAKwraRYym?=
 =?iso-8859-1?Q?SQB2tt7D1jCHxsesjwr4Owfpa/jMH9kuToAWpprYM/5d4fXPpFeG/CDWYt?=
 =?iso-8859-1?Q?q5cofiVrBI+5YKO2TlHF/C/5YQfvkQo10CUgs6Lr+PoZPmU/vocEy85eTj?=
 =?iso-8859-1?Q?HRnnPq0Ng4MrM1fz1YXiSSUQEsN4+wdSRKjlKlf4ux/fJUuRTD50gRlT1Q?=
 =?iso-8859-1?Q?XQBWiOeKj2+2nu4+dib1LRQdAemYVjcNBUyLHScIx6o5/6GzSsfZ7SBBoj?=
 =?iso-8859-1?Q?8d+fNHUOSSL1F0ijWcSwY4mJ/VWxt6v8DmIgAE+0H/pCXkA/Zv5Cv+Bqtg?=
 =?iso-8859-1?Q?RVfB95cC/Jo9LFB82LOqMIXLuYMQmj9sJIlzs3whuHrut2f9dp1u3lUMQF?=
 =?iso-8859-1?Q?fBzrGdMu/SXxPLVo096fqsiftkWn7125N3/Hwyf3e04oAxHAOl4JW8lRak?=
 =?iso-8859-1?Q?GWDx4o6KrSmVEcVpJ9sS1SDleStO7y/w0eEWwh4AXR1D1VEPex+b/k63Ew?=
 =?iso-8859-1?Q?HyV4UIzje0Gfo3pfS9i5Yc4GoG4JjChJdlN2xdh5R0/NjDfOBJyjJlQujQ?=
 =?iso-8859-1?Q?P+Z3xj8/N6X4GLYX5UDnrxFpTGEiL0kgqZYeruQTrIO0aLNJdjJhjsB1tJ?=
 =?iso-8859-1?Q?Jsfk4l8S5kEwjMLbJ58xNRuHMZIUlqYhXXanKPguFvPK/y?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fea2a50-b4c4-4a5e-9282-08de67e54355
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 14:12:30.7902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w5OQ0Uotre2twi/OMkJtTQcCWkOYyXpsUeoNA0oM5sncu6oMrn0OxPm2tUyHuMTF0KOK2YzzfGJmQjn0IT5iTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092
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
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
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
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit - drm=
/amd/display: Promote DC to 3.2.368) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using Gnome.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: Tom Chung <chiahsuan.chung@amd.com>
Sent: Tuesday, February 3, 2026 10:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/16] DC Patches Feb 09 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Fix system resume lag issue
- Correct hubp GfxVersion verification
- Add parse all extension blocks for VSDB
- Increase DCN35 SR enter/exit latency
- Refactor virtual directory reorganize encoder and hwss files
- Set enable_legacy_fast_update to false for DCN36
- Avoid updating surface with the same surface under MPO

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Fix the incorrect type in dml_print

Bhuvanachandra Pinninti (1):
  drm/amd/display: Refactor virtual directory reorganize encoder and
    hwss files.

Clay King (1):
  drm/amd/display: bypass post csc for additional color spaces in dal

Leo Li (1):
  drm/amd/display: Increase DCN35 SR enter/exit latency

Leon Huang (1):
  drm/amd/display: Check frame skip capability in Sink side

Muaaz Nisar (1):
  Revert "drm/amd/display: mouse event trigger to boost RR when idle"

Nicholas Carbones (2):
  drm/amd/display: Correct hubp GfxVersion verification
  drm/amd/display: Revert "Migrate DCCG register access from hwseq to
    dccg component."

Peichen Huang (1):
  drm/amd/display: use enum value for panel replay setting

Ray Wu (1):
  drm/amd/display: Parse all extension blocks for VSDB

Roman Li (1):
  drm/amd/display: Make GPIO HPD path conditional

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.46.0
  drm/amd/display: Promote DC to 3.2.369

Tom Chung (1):
  drm/amd/display: Fix system resume lag issue

Wayne Lin (1):
  drm/amd/display: Avoid updating surface with the same surface under
    MPO

YiLing Chen (1):
  drm/amd/display: set enable_legacy_fast_update to false for DCN36

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 16 +++++-
 drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 16 +++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 13 -----
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    | 54 +------------------
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    | 18 ++-----
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |  9 ++++
 .../{ =3D> dio}/virtual/virtual_link_encoder.c  |  2 -  .../{ =3D> dio}/vi=
rtual/virtual_link_encoder.h  |  0
 .../virtual/virtual_stream_encoder.c          |  1 -
 .../virtual/virtual_stream_encoder.h          |  0
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  4 +-  .../amd/display/dc/=
dml2_0/display_mode_util.c |  2 +-  .../drm/amd/display/dc/dpp/dcn30/dcn30_=
dpp.c  | 21 ++++++--  .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |  4 ++
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |  6 +--
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    | 35 ++++++------
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    | 28 +++++-----
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 28 +++++-----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 29 +++++++---
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |  5 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  9 ++--
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  5 +-  drivers/gpu/drm/amd=
/display/dc/inc/hw/dccg.h  |  4 --  drivers/gpu/drm/amd/display/dc/link/Mak=
efile  |  3 +-
 .../hwss/link_hwss_virtual.c}                 |  2 +-
 .../hwss/link_hwss_virtual.h}                 |  6 +--
 .../drm/amd/display/dc/link/link_factory.c    |  8 +--
 .../dc/link/protocols/link_dp_panel_replay.c  | 14 ++++-  .../amd/display/=
dc/link/protocols/link_hpd.c  |  9 +++-
 .../dc/resource/dce100/dce100_resource.c      |  2 +-
 .../dc/resource/dce120/dce120_resource.c      |  2 +-
 .../dc/resource/dcn10/dcn10_resource.c        |  2 +-
 .../dc/resource/dcn20/dcn20_resource.c        |  2 +-
 .../dc/resource/dcn201/dcn201_resource.c      |  2 +-
 .../dc/resource/dcn21/dcn21_resource.c        |  2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  2 +-
 .../dc/resource/dcn301/dcn301_resource.c      |  2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  2 +-
 .../dc/resource/dcn314/dcn314_resource.c      |  2 +-
 .../dc/resource/dcn315/dcn315_resource.c      |  2 +-
 .../dc/resource/dcn316/dcn316_resource.c      |  2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |  2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |  4 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  2 +-
 .../gpu/drm/amd/display/dc/virtual/Makefile   | 30 -----------
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 15 ++++++
 58 files changed, 229 insertions(+), 238 deletions(-)  rename drivers/gpu/=
drm/amd/display/dc/{ =3D> dio}/virtual/virtual_link_encoder.c (99%)  rename=
 drivers/gpu/drm/amd/display/dc/{ =3D> dio}/virtual/virtual_link_encoder.h =
(100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/virtual/virtual_s=
tream_encoder.c (99%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/vi=
rtual/virtual_stream_encoder.h (100%)  rename drivers/gpu/drm/amd/display/d=
c/{virtual/virtual_link_hwss.c =3D> link/hwss/link_hwss_virtual.c} (98%)  r=
ename drivers/gpu/drm/amd/display/dc/{virtual/virtual_link_hwss.h =3D> link=
/hwss/link_hwss_virtual.h} (92%)  delete mode 100644 drivers/gpu/drm/amd/di=
splay/dc/virtual/Makefile

--
2.43.0

