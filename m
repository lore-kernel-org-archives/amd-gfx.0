Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4232C44503
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 10:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE4710E744;
	Wed, 21 Jan 2026 10:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ekdLR5M";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E70B10E744
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 10:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZWbpexFQWVCgzBXzeEQJYX2yGNGz6FCNBPej1V2Ejw17O6heZqS7EvNWvoQ8HEueXtizTiFYipjVz6RHR4Loao9eP2BsK5R+p1sA5BJ4v+VblpTYuky5O5OWG55fmyf4ANqxKn6Ls3fBfLNBh/cWy5gmgYsBEvU0BEeGsrbfJqikFBgOkZ6CxMZ6Iua6H+XsSEh19BM/uBlfnXCe69J/bXK5tTtYjZShucxlWKHZpdsxWzML5BZ24F9H6z2PnDQ32mKnGJK3cUDG2KN9M8bvh8SLJVFUptPrqbuQxailZSC8mPXnIVgG7uOC4OghczlxN/+yOGufs33UnkmOL+Ciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtRF9qq1g5sZ43LVTTUVhLa/KtT4yJY/c5pewzMNxFo=;
 b=mkG7qbR24kg6VRUfiYSqIJFzEdjJiEtflRgK0O2krjqHnn+Q21WNx+KaF2HqBG+nOEKFIebHrAZh/gbmdRJRcPqJZ35Rl43bl65UX8ffFZYwJcd1oUNaYfq3XzD2W3yxDpDn+Z7JPO/vNT6ACXNLylbIlEHh82f5meDdXVeNB2k83/JfZKI05MSspv6ZGoMtod1Dxk1JRfADfplNF2fm8jwDxZ7zPBN7KiDXDEzElzpCbkvb5PScJFB9zgoucRmFXhQh47ISZkQ9P9lHOZZ5dujfKxWMkk6qnQOBX0An68FK8MWg17/MKth1lLtjUa1YDjV2qQk/J7250DU76RWvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtRF9qq1g5sZ43LVTTUVhLa/KtT4yJY/c5pewzMNxFo=;
 b=4ekdLR5Mq0dU1yC1jF0c4KHUmigX2NlV7PVkhzteAv1ifIm9sc0+ttvDnwfj1lHCNBenG6srzXjWSxk1Z5wOJL+TnLWAiYxDnEanLRKa82fd4svs1F1mvLz/jpj6O6PSPEwqTVJXMiGjR7FGvoWjBDalCsmas6UVbc6L7Yiuyvw=
Received: from IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8)
 by PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 10:32:21 +0000
Received: from IA0PR12MB8647.namprd12.prod.outlook.com
 ([fe80::14ca:b414:8e97:f4c0]) by IA0PR12MB8647.namprd12.prod.outlook.com
 ([fe80::14ca:b414:8e97:f4c0%4]) with mapi id 15.20.9520.009; Wed, 21 Jan 2026
 10:32:21 +0000
From: "Indic, Vladimir" <Vladimir.Indic@amd.com>
To: "Six, Lancelot" <Lancelot.Six@amd.com>, "Cornwall, Jay"
 <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
Subject: RE: [PATCH 2/5] drm/amdkfd: Fix scalar load ordering in gfx12.1 trap
 handler
Thread-Topic: [PATCH 2/5] drm/amdkfd: Fix scalar load ordering in gfx12.1 trap
 handler
Thread-Index: AQHchyhbmYzddjLHk0efZASROdImebVbrKuAgADHVRA=
Date: Wed, 21 Jan 2026 10:32:21 +0000
Message-ID: <IA0PR12MB8647EBE507971B86A992376E9A96A@IA0PR12MB8647.namprd12.prod.outlook.com>
References: <20260116203932.988704-1-jay.cornwall@amd.com>
 <20260116203932.988704-3-jay.cornwall@amd.com>
 <9bf05977-e1a8-4213-aabc-a92e5d60b2c0@amd.com>
In-Reply-To: <9bf05977-e1a8-4213-aabc-a92e5d60b2c0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-21T10:31:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8647:EE_|PH0PR12MB7984:EE_
x-ms-office365-filtering-correlation-id: 452491e6-f2ce-46e2-c222-08de58d85c15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cE1uVnJ3aFBTNGZWSTREYjAySk1WMEJaNmVLcU1JV05wS0tXQmhYdGswRlFB?=
 =?utf-8?B?M0w3dG5nTUNIUGVrTXZpaFVOTnJEdkgySG9id2xSOW1lTzRYNnBiRnhUcVk0?=
 =?utf-8?B?STBtZUx1QzNBWExXVWxaRllmeWhFQk8wZkZ4Q29PUC9EaHlVdFIzZ2s5ekdR?=
 =?utf-8?B?WWx3V2x1R2RMeUhjTmc1QlNXRTRBMUh6dGlPUU5BRDJQVTB6T2FTM3dPTzdl?=
 =?utf-8?B?NmNMc3hoS2JLUkNXZzNmY3ZRYzZxNkZrNzZqL0I2YWVFYzdSWmxUZ0tpdU9z?=
 =?utf-8?B?aHgvNlRaVGJjTjhyK2pnZGhQUG81cWVDWnc3S0VrNmkwSDNoSE5qR24vNGxm?=
 =?utf-8?B?bmMwVm9OYkxLdmhWbEc2d2pLRG0vdVQzUmRrSVVBK0FkbEFSdFNMNWZlY25s?=
 =?utf-8?B?c0ZpOEdta3hPOU45VEdoV09la0I1VTdDVVdUVjJTUEl2RGNsQ1AyU2IzVTh0?=
 =?utf-8?B?dWVVNmpLOUl3dmdWRjFzcFN5Y3duWHlEeXhEdUQ4U0QwOEJ3czFpVlQyeUNB?=
 =?utf-8?B?NXRXcmM3Qmh6RTF6d0JidVpjVjVKN2NWR0IrZGhwa2Zjdnd1YTdYVGJOeFYr?=
 =?utf-8?B?bFUvd1pSaStJSU9EemZjNTY0dzBUVFpPbHdOamV2VUxBZlpEa2doWmZjVm5Y?=
 =?utf-8?B?aUZGbWpuaFFvOU9HZ3FHR3BOdnBPb20vSEZPT0JINnZzNDIrTXJNZmpqYVlN?=
 =?utf-8?B?WVpsREI1WHhtV1EzbGNCdElEeWFhNjUzSklSWmtYaTVUZkI5U0JoYlQ5Tk5r?=
 =?utf-8?B?OGJQU1pmbnJuL3RDR2M4Rm9sZTVWVyt5MktZN2ZsS1pKWVZRNmFoM2ZEWnhi?=
 =?utf-8?B?L2J1SGFHaFZqYW5iRXg1R1pMbHdxRS85a3ZjRjBUQUJvTTBJaXQvTzU2SlBq?=
 =?utf-8?B?amZWRWpHVkdwazBvcm5kaEZnaURoemM0WXhsNlBpeDEya3cweWk5SFdiUjBO?=
 =?utf-8?B?NW9kWlB3UFo3Z1g3bUluRFV3Z3BJOWVtYmtUeFBGVFREVHhJWVNTS2tOVEpi?=
 =?utf-8?B?NERwVlVBYmJSdWdJcm5maUNCMGVxQ3B4b0R2VHkvU0pLOGFTUlE3US9zRFI4?=
 =?utf-8?B?M0c2Y2V0RVVnd2lFeGhMbXQ5Q3NDYWlmbTFCUnc2bkRweDhaSFYwOGM5bnlZ?=
 =?utf-8?B?WGNIQVI2a21EbS9ZaXJPSUwraEM3ZmxpNHhUUHJ5bXFYZHk5WUdQNkk3N0pi?=
 =?utf-8?B?RVBEa2dQdDR4dmpCa0FXaTQ1empLNFhKM3BFOERrQUIzMCt0aWNYT05Jb1N2?=
 =?utf-8?B?WlM3TXhqc2F2bDE1VUZsV1hwWE9Gb21lenkxeU8ydW5FTWVITVNVNEs3UGZm?=
 =?utf-8?B?Mi9GY1lNRHRhdUFUeWdUT2ZLRHl0UUp4QnJNM1hLTWFrSTg1ZXRlOXArU28v?=
 =?utf-8?B?QWNkcHNEb2h0UmVCVE9MRlBWY0NiVmpUT0UzRkZwQ3d3eC9ZblN5bmFOSFM2?=
 =?utf-8?B?ZVZMQUhtaXZvbWlwczh6UzFaS3kydXdZeHVzR1ppTUZKK21jeVRyS0ZLQy9k?=
 =?utf-8?B?ZGVNNVJNRGl5NXJCTzlHdE5PeEVoNGo2UFlWb3J2RzVBZldEN0t0VkdnUVFB?=
 =?utf-8?B?dTU2ZjI3aDNqNTQzM2RadS90VWRzVlkyQU5ZWk15NTB5MElWbGJWYkNhOFls?=
 =?utf-8?B?TjBXODBSanZCRC9xcW1RVnV3UW5UajRZWGw4QUlucmVBV2srSDliZkdCZEpV?=
 =?utf-8?B?ZFV0Mkplb2w0MkpGU0VXSytuQlIvQ0M0ck5mNTV6VlI1VHVWQzgxZFhhVFY1?=
 =?utf-8?B?Nm5FL2w2c0xpOFc1RDAzdHNDWEk4RU1MNFdLTitMcEp1RkM3cVRJMk9Gem1E?=
 =?utf-8?B?OXh3K3FzcGN3RjI4M0NxdTExZm9WZ09OeWhaSXhFOTdDdkZlMktaVW9XbEYr?=
 =?utf-8?B?eEdIMktaYkZPdkNkMjU1OGMzWUpjZUxkdHA0WW1ZQmVkd1B0c29PYmk1QXo2?=
 =?utf-8?B?OTNKcUgyWUNJRGw5b2x5T09QRmdTeEtsS3JXRkQvTzVUS0Jpa0w1Vjl0Ni9W?=
 =?utf-8?B?NmlMYWs2aUdrNVppdHR4aTRkM1RMMWR6SGVJaGdQQ2pnMWNjdis1ZlVaRmor?=
 =?utf-8?B?dUMyOVM3R0FweExoYWR6cWRwZlRFUlJHMk8zT3l2MWFvVkNhUUhMd1BCS2tI?=
 =?utf-8?B?ZVl0N1Jnd01ZcUplUDdXN3FJK1pmYUpjdXBpbmYvS3pRV012NldSUTFUTnA2?=
 =?utf-8?Q?FrxHiB4xxlqZOys0gI809Wo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8647.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHZqZ1UyQjNrOUJRa0RZTS9HNXF4MjZiMmFkc1dWUUZKcTdDazhZWWR6ckI2?=
 =?utf-8?B?TDRCS1RGVVlsU0VtZXJvazg0bDc2cHlPcmR5aWVFMDlpUUtUa3cvTkhGWXB3?=
 =?utf-8?B?YkVVZUVPR2xWYk5PTzlnN2JtY1Y1SlFKTXJ6SXA3NEhKRTliK1c5Q3hHcE43?=
 =?utf-8?B?emI4RVdCRDBrSmJwbUIxM3ZpMjZqbEt0NXFPd2VKYVJoQ3N4MVdVNHV4Q05p?=
 =?utf-8?B?a1VmOUUrajgrKzdXd21QNXdab0JZaW5LQy9ZMnJoUzNLZFVDSldudmdiWDBW?=
 =?utf-8?B?dDRhK21QUFVyQzhLbUk2SFMxNlMxNjhvdnYwY2pSWUNTUE5way8zYjUzZUlv?=
 =?utf-8?B?R2dJYXRsMlFCc0xmamx4UFVnNXFCdGhYZkF5U2t4cmFDVllIclFpdVBBczl5?=
 =?utf-8?B?eHJUZElSaUY1YWZrdUx1RVJ4dEFmVlNFNmo0QVlYN0krdWgrRTc1aytFMTRN?=
 =?utf-8?B?K2VIaG9tR3RnamVPOWVSQzZEVG9CbUo0UXh5TU1scCtqcVhxSm9IZUdNbVpF?=
 =?utf-8?B?VHZwbzJsb1pocXpTTjhrQWxicTd3a0dvVi9jQ0ZSTUUwWE9IOEVvalFwUHNY?=
 =?utf-8?B?UXdSdERWRFRqU0RGSzlHQkRHa0R6TnlhN24rL1dUNVM3Zk5JMDhHaURpajZa?=
 =?utf-8?B?TnhVRjhFZTNydU1DVHgzRVpLYVFSWVlnUXRiNGRzc2Q1WlJaV3lsaW56Z2pI?=
 =?utf-8?B?a0Z0Qmpwc1lQRHRWeHVCTU5QUkl5Z2JLTElQU09GamVBZjJRNUtuOFk3aGJD?=
 =?utf-8?B?Rkd6S0RvN1lyczczRHQwTkJJanpnd2lNNWZrSjJDRmhDY0t6cTJUbWxzSHV6?=
 =?utf-8?B?ZHlOUkhjSTFoZFFPVU5OMzQzZlYrK0FPNDFmOWdSS1ZOdmhJZkxpbEtoZTh2?=
 =?utf-8?B?a1Bvc1MwWWFCUFhZdWxjYVJYaGhBSGZXOUd6UkhNMHBjTDJDcTErTjFHRXdx?=
 =?utf-8?B?b1RRTy9xdTVoM1R4YmMwYUN6NEltYXVlc3ZKN1U1eHkxWENIbEozWUNhcHc2?=
 =?utf-8?B?Qk9mOEFPQXlNa2hqK3hhRzQwTVZ4eHdYY2VvbHF0Q2Fubmw4REJOVjUrMmJy?=
 =?utf-8?B?bTZySGJGNmtkQzRnQ1FXcmtXRHRBUDFIWXpuOTNoK2EybzM0TWd1eks1QmNl?=
 =?utf-8?B?eGJhK1BRZGYwRGlQVklGMlFJMVlaTjIvWFFSNW1KR1EwV2k3b3R1azRqWVk1?=
 =?utf-8?B?Uk5vdlhpdHFoTmYrL05tY1MyMGFJVjJnU3hsLzhybHNJc2ZHU3BpUVBNdUYr?=
 =?utf-8?B?NWoxRlVYMGVwRmpySlJJd2l1c09TS3V2T1VvN1Z5Si9EQ3Z0TERvcXVXaFpH?=
 =?utf-8?B?THF4L0lpSkJPRm0rM0dYN0ltcTNRZE5hczZMclRtR2NEQzRveU5qaFRHK1JH?=
 =?utf-8?B?L3JjL3pPRjU3UDNPTDBaNU50bDE2U1M5STVsbThETFlxY3RDWFZDNE13YjBD?=
 =?utf-8?B?dllBOWJ3U2YzaUk1dkJkdmhZZW9CbCtrQWhIbmNMMW1CRWc3L0lWNUtYNTVN?=
 =?utf-8?B?clhEMG9CTjlQNGpmMm5rbVRqQStURkVKR2ZhY2lRNEVvaHVaUXlsbmlMWmJM?=
 =?utf-8?B?bE00TzdoTnliRER3OUdEUUN6dGZ4WjZ0ZnA4cUx3dkZmYkE4Y3kxNmFTMTdR?=
 =?utf-8?B?Mk1NVDF4c1hKellQdGs0NEJiSDNXMUp5ZU55MGgvbzlNaUU2R0cvSmdEdjVi?=
 =?utf-8?B?Q0puazNSQi9zUkI3TTF0OWZKaFRHRy91dmwxMDFJcmRQVmtLV2dJcHh0ZFRI?=
 =?utf-8?B?eXl1UDV6TFdqVklYdFFRSDBMcDJuRTBmbkJPOVZqWFhLeDFBNElmUU1MTWR0?=
 =?utf-8?B?NFNvVFREeEV1eER4ODZUT21Nbk90UTNwK0IvT3VkYWRxUm9TWTV3L2UvcVJh?=
 =?utf-8?B?UDlqUzZJb1hDNDc5enlMWEM1eFBCNHlLK1JpNXZmb003WjkwRVFURE1mOXM4?=
 =?utf-8?B?Uk9zQlNSSEhYNy85TWI5M1ZFVWNZK3BnN1FRK3hHUENqemtDdkFoQzhOOWdK?=
 =?utf-8?B?TVI2cC8vTy9OSW9oZEZ4bU1zaUlrZ3JkRmpmbm83ajIyb2xmdGc3NnBKZFF4?=
 =?utf-8?B?TWpqUWU3SFBGZnJPV0FyN2l3STdodDQzSkc4ZG9BMkwxQmF1a0VaOWl1TnZs?=
 =?utf-8?B?TU1kZnkyQ3ZGOWNrZitFQzBJQTUrTzlmVVJsWUJ5NGdmWUVMWm5pRUUzMzFJ?=
 =?utf-8?B?WTJTZEpycTkwa0d5bm9FMzZFQkxFZmx0Zm1MTm1SVXYwbEV5Sk15eWdKdkdt?=
 =?utf-8?B?T0pyWmY5cTZRSS9pSFg4U1B4bFZVSDRoYmk0NG9tU0w4UHNaYW82dVNabzha?=
 =?utf-8?Q?UbwpqqYcSwzl2SUzh8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452491e6-f2ce-46e2-c222-08de58d85c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 10:32:21.3997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSp6BLKVPdN4mPA8ZHg+4oIqagib1E8hJCT4TEHYlac7e8ofw22ZQ75ThncGg/GWLhAecKtmpMvHPZgEF8la7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KQWRkaW5nIG9uZSBtb3JlIHJldmlldy4gTEdUTSENCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWly
IEluZGljIDx2bGFkaW1pci5pbmRpY0BhbWQuY29tPg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogU2l4LCBMYW5jZWxvdCA8TGFuY2Vsb3QuU2l4QGFtZC5jb20+DQpTZW50OiBU
dWVzZGF5LCBKYW51YXJ5IDIwLCAyMDI2IDExOjM4IFBNDQpUbzogQ29ybndhbGwsIEpheSA8SmF5
LkNvcm53YWxsQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IEdy
ZWF0aG91c2UsIEpvc2VwaCA8Sm9zZXBoLkdyZWF0aG91c2VAYW1kLmNvbT47IEluZGljLCBWbGFk
aW1pciA8VmxhZGltaXIuSW5kaWNAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMi81XSBk
cm0vYW1ka2ZkOiBGaXggc2NhbGFyIGxvYWQgb3JkZXJpbmcgaW4gZ2Z4MTIuMSB0cmFwIGhhbmRs
ZXINCg0KSGksDQoNClRoaXMgbG9va3MgZ29vZCwgdGhhbmtzIGZvciBmaXhpbmcgdGhpcy4NCg0K
VGhhbmtzLA0KTGFuY2Vsb3QuDQoNCk9uIDE2LzAxLzIwMjYgMjA6MzksIEpheSBDb3Jud2FsbCB3
cm90ZToNCj4gU2NhbGFyIGxvYWRzIG1heSBhcnJpdmUgb3V0LW9mLW9yZGVyIHdpdGggcmVzcGVj
dCB0byBLTUNOVC4NCj4gVGhlIGFmZmVjdGVkIGNvZGUgZXhwZWN0cyB0aGUgdHdvIGxvYWRzIHRv
IGFycml2ZSBpbi1vcmRlci4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSmF5IENvcm53YWxsIDxqYXku
Y29ybndhbGxAYW1kLmNvbT4NCj4gQ2M6IExhbmNlbG90IFNpeCA8bGFuY2Vsb3Quc2l4QGFtZC5j
b20+DQo+IENjOiBKb3NlcGggR3JlYXRob3VzZSA8am9zZXBoLmdyZWF0aG91c2VAYW1kLmNvbT4N
Cj4gQ2M6IFZsYWRpbWlyIEluZGljIDx2bGFkaW1pci5pbmRpY0BhbWQuY29tPg0KUmV2aWV3ZWQt
Ynk6IExhbmNlbG90IFNpeCA8bGFuY2Vsb3Quc2l4QGFtZC5jb20+DQo=
