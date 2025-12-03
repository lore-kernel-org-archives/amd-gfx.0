Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F34CD15DA1
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 15:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9FC10E86C;
	Wed,  3 Dec 2025 15:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="03Y/H5h0";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 181D310E86C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 15:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akwV1nfDPxuK2KUnHmRmDa1Om2dgp+lpbByr3P/jmJ09V1nJUcS2IMUKwYJznhJrMUy/MLUbeDAw7Mu7kX9SVMstSMwaZ+FBCiXlyA3d3TX6X0pfRaC1fdrJRKDrWJYM+JHWi3BBRV2Cm4Hvue9mc9l2BvNxkKBhD4i8zLHTOeWCxE9j4WXx8Pez1DOaiufR3wXS/iWz1rbAdzuiCvp+DTethQzEaw2vhtFOauIbTlNY5+eK0hK4tYsrMbIxdOCNxmVw74X+0gH620Cjf5Yl6eGObRknPBBxY/Iwwv8WLYDQDPnQXZvNC4kyeuPTZQ1dVTulB7Tu4wJnJuVAuLs47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lecnDbb5QmSnX04xZJLbEL5tBn9PmT44YUUtdDjs7KU=;
 b=I1zuQwPWnqk0gWOTLOODWSbP1OKvhphS7rLl8fDC7oy7GUNgEV4kTFBpNJBQFTctBWSFc/7hv0F/eD2tsbf/6p7WdUB8DgEzeyHIMT1MBTWv/R3bmD/48VAc+bR0OGtbw8fh8yC15WbVvgw3WGKTxjLXpTbUc5dPgxqHtIDhsuYfAMlXzwftWH9Gkl9GiGU9hlyqssL0TIbZpdRUhDKiv/0uF3Hn85wAKr38IFs6C559DhIuXrDskf1b9VcruISwie/50P1xz6uA9GiMNYKIK62filvGOnijRrozJ0h6trMaBw9QDEkreTjha+xAaHjAlOnNf+0Fzfuc3REdZ0BnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lecnDbb5QmSnX04xZJLbEL5tBn9PmT44YUUtdDjs7KU=;
 b=03Y/H5h0phsfPvljeGoS+el4wyWxGtkKqr5K7VMbZu+Z59BtCiYg9cJ3jUtSxEljmquarTOqmVSXvV5ghYWGj4bFwUVI1ZyXGjoUJuIbJLSL/YE7J980ZyskmaV/VmaCbNLt1GYcV2p1LwTVIlTOfpNbGf/jaM9WbrMwOFOxBSA=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 15:45:23 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 15:45:23 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4] drm/amdgpu: Ignored various return code
Thread-Topic: [PATCH v4] drm/amdgpu: Ignored various return code
Thread-Index: AQHcVb4Kwy39YKaZnEeQ3abVTqPR/7UO2T2AgAFSrjA=
Date: Wed, 3 Dec 2025 15:45:23 +0000
Message-ID: <SJ0PR12MB8138C492A85692987DF66F95F5D9A@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20251114232546.1586273-1-andrew.martin@amd.com>
 <9072b455-9a52-4623-9272-4921825f8320@amd.com>
In-Reply-To: <9072b455-9a52-4623-9272-4921825f8320@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-03T15:44:25.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|IA0PR12MB8863:EE_
x-ms-office365-filtering-correlation-id: a55c4509-86b0-4577-16e9-08de3282f8e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VUlndmlCbTZPUlFrRHBVN3hUSC9DOXRxVWNQZVZFZlMzQmtjM1N6eTRHZS9a?=
 =?utf-8?B?TWxOSllVeFVyQU5TL1RBQjhVSElzNFg2NnU1b2ZxUmpEa3BFMDhEcVIxMEFu?=
 =?utf-8?B?RGxUOHp1Y1JDYXcvZHpqdU1hbGwrU01rTVU1dVJ5aTJJdVFCMHJIMDlrMnZK?=
 =?utf-8?B?aldwSFhEekRxYVBkNFZNTmlLeHJVcStWNVNNMXNKektmVkV6VDBrdWhqdGZO?=
 =?utf-8?B?T1Z1TXk4RWc4cXRwamo4THBjRjNmclBFdkxwRnM5bU5TYUY2aDkxT3JyRFBu?=
 =?utf-8?B?Uks4ODlQS3FNckxlY1FMU1MvbVdhcWNPdjlReUhlWk05THBCZXd6Y3pnT2RI?=
 =?utf-8?B?dUlLZVNHdHdSMHp1aUh6WlNEYlJsVWVsbzNadklaRmlzQkgwUXFJRTRrQkpy?=
 =?utf-8?B?L1pFLzZqTW5tNGNlTXhtbCtsd2tmQzZMSmVDYUtTQkM4dWRtODFYUXc2UER3?=
 =?utf-8?B?M3hPWTdDUVpBTlFlaFVPL0tSUktTamNOQ3FtZGVoZFlMOUI0VDhPUm52Mys2?=
 =?utf-8?B?d01lMEVJTDcrQnplMlZWbHArYUs0L3FqNThycDlubU42L3REYkQ5VWRqbUVJ?=
 =?utf-8?B?MHMveWJldFlMejRaOU0xS21PMDN5eklIY3hVdGtHWkdKeTdoeFJ6azhrMEpn?=
 =?utf-8?B?MU45Y0pzNlZXVlZsOWplR2llK1ptMllmZGN5VEJRc2hIeHcxQ0hycEZZNWdj?=
 =?utf-8?B?U012ZnNodm5DQkJaQ1Z3RUw1ZzdHTTFQdGhYUkU3WmV3TzZBUitkVk1aM2Vk?=
 =?utf-8?B?NEZBbnlPeHI0VUw4cWtYZkF6TkVFY3JQR1FsTUlCR1RqdjBmaTlvSXE1d3lz?=
 =?utf-8?B?WXRsbFdPNC9Ia0lsc092WElRRERHTG1Md0dQdGJ1dnd3bFM3TS8vMEJ6RG9l?=
 =?utf-8?B?UERkVzlidTlFUXRqWnJuWmFFNlkyakhiRllIRzhxOXRDQSsrN0UrT1MzVm1k?=
 =?utf-8?B?R3BHTy9Rb3pMTFlSZUhMYmpodzRVbHd4S1BLS2tFdmprNXNHL0grNFVrMEVC?=
 =?utf-8?B?M1ZzNTVIV3NxOHZtT21VZGQ0aEZ5ZHdrMVU4SmhLMWYrMTNvNkc2bFFtOHdm?=
 =?utf-8?B?cTBwYVpuYkZHSXZRdm8rNEJUa0N0L1ZQWW95a1FuUERPQ0FYVHlqQVU3ZVYv?=
 =?utf-8?B?TktsNktNUzU0SFpXRTNQQ2NMdUtQRk5XZ2MzRnY1cmwzOUtJVGJWdDBPaldF?=
 =?utf-8?B?Ni8vK3dXREwrYTlkM25aaTRCUnZ3YTFFWGdQQTUzeFViTCtYUjB5OGhNWTFv?=
 =?utf-8?B?TjJ1NllvM0FMcUl1U3BBakRmTm5mTTBpUVZhMUZTZnN3TkxwZk9VZEpxekh4?=
 =?utf-8?B?K0ZaK2k2cmM4aTlYc3lzSzEzK2F6cnZuR3pxUThFVmE5b0FOTEdkaG1SazRV?=
 =?utf-8?B?bEg0MTlUaHB5TkVlWURtdW91bEt6T01ydVZvS2czb3hybi9Lc1ZrNGxRUGNF?=
 =?utf-8?B?N3hmZ21yNmQyQ0RXSDl6N0pyZEtUMG5vajZ2enR3NmQvR0VCOGltTlFVd1Fu?=
 =?utf-8?B?eGpjL05xVlcvRDdmcTR0bDRBSGNzdVhjc2ZmNFpTQlR4RzlJMUFJWmZBL2d0?=
 =?utf-8?B?NFlxRmJkV2dYMTgydndYbTdGU00wR1N3Tk55Qy9HNVZlMWFvRlkvZXJPZ3g0?=
 =?utf-8?B?bzNBdzJ6RkI4SXVZRXVyZkpTRXNsQjRheFg4ZEc2YzUyZUNYOFBZVU9oZ2hQ?=
 =?utf-8?B?Q3lERkFVSTRzbWMyTTA5b2cvcU8wOVNTTENDSHBWRG0wLzBIYkdMeGF1UVVH?=
 =?utf-8?B?bDJFMjlOOUFIZy9wS0Z2dVZ4S0dqSnhXNTQxVWhmOW9VNGpubXlVTW9sT0dw?=
 =?utf-8?B?R0NqY201S0pKaTFERGxRd24ySjhlbFg3UWVCRnI1YnNNeHErbExON3ZHYUhQ?=
 =?utf-8?B?MVc5QzlwZ2ZYckZ2cUVvLzd2cTFpZzlWbUZEdFV4VEc5aTBjL3dncW5aSmdw?=
 =?utf-8?B?Q2dJQkRrWXZnd2U3Q3d4MUFHZlJrYTY5a0VweUVUOEV2ZUVSZHJwRlpUWThq?=
 =?utf-8?B?QkNwd0pDdTJ0R0I0VkFIR0hLdzNROXNlVjBweVlnVVkxYmdIM3Q4TTg2Rjlh?=
 =?utf-8?Q?mRe8+R?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHZDQlVRd3M1ZzRIR0p0TzRURkJFKzJ5a1N5V0tyTFBhNUJlcUFXOFJKMUJz?=
 =?utf-8?B?cUZXeW5vTVdFOFNaRFh6MGpaNFpBVWFnbmZtY05BVHJQNGhmaUg1ZHhxR3Jq?=
 =?utf-8?B?UTFDV0VUK0tvK1Uzb0tqTWE0TjMvNElhQ0VFTWl4NVJpZkx2bmp5elN2VDRP?=
 =?utf-8?B?RHBhN2NHdVVla2JaOGpSLzYzNmxHaWhCQkgyRDhlQTFxVFNTQUxCZW43eVM5?=
 =?utf-8?B?cTV3cnRldHpRVng0SFViQms4OFB6bzdPNGRmODlPTUhscTVFZWtmK0dUYVB3?=
 =?utf-8?B?RnBlNXF0aitqdXp3bEdINkxwZlJSd29sS2p5T1d3enRodzF6THpHNFVaMURy?=
 =?utf-8?B?dkRSQTI0YThGSlpjK3ZjMnJaaFJ5REZrU2RLc3RhSTZlQ2p6bkprSWxidkFN?=
 =?utf-8?B?RTVzU0hKTklWcXQ4K1FRdTRDSU1yMHhrR3NZZnB1bUdVbGFObWtCdHJNZ2t6?=
 =?utf-8?B?R2lNQi91amFvVVZWanVOd3lYUnc0bHVzUzB2WlJDZnN2d0c1MUVXZG1haGZw?=
 =?utf-8?B?cy94WmtTUmxieTVlc3V5YW1UcFhOczg3UkFTczZzUDFMdW9Cb2h4dDhHUkRG?=
 =?utf-8?B?ZGVHNUU2U0dRektJSEhIZTFRem5Bb1VKMnVBa0xtWW80U3o1S0JZYUhlSGN5?=
 =?utf-8?B?Ty9Lc2tXSkttUHhmL3Vpek5tSk9DWUhxZGZQVVNrcWpDazhlVCtNUzBvRFJt?=
 =?utf-8?B?UnNZaDdoS2MxRjBTREQ2dFV4RXlCTzEwTjZDbjFZQVMvZTc0SkhOOTh4VUNP?=
 =?utf-8?B?eHV4REV4VHpka3JIMVFWdXVGOFUwZFI2QlVXaDY0SEgzSEdVYnp4Skw4cmxO?=
 =?utf-8?B?MWk5MWp1NzV0VDZRMFd4Ulhqak5HR2RaQ1dYd0tCVVZZOXNnWkFYa1gxT1VC?=
 =?utf-8?B?SFYvQWRxUFN0clk4ZjVMbHRrRC8vTE1MU0F0MGc5NGtNZllQR0p0WU94bUY4?=
 =?utf-8?B?UEVBdXhWTnR1SVJtbmFEdkxlY3gzTTF1Zk45Wi9LaWQyWW1GWGVTU25WdTlr?=
 =?utf-8?B?VVY1UEU5YVg0OS9nK3l3bGYvSWQxZmJacXhDdFhpbnFUY0hNM3JaVVNxTXBy?=
 =?utf-8?B?cU5BNlRsK1JZVWxJSWxMU0JUVlpWa3R4Y1NZRlp6VUxxZ3E2bnRMYTVYMUhX?=
 =?utf-8?B?YnoyeFZGbmN5T0tMM0dsQjNhVi82cFdZZTZpaUNxUWZhTUpna3AzL0oway9s?=
 =?utf-8?B?WTFIT012SU1LOFFSUlFqNjRLVk9Rby9mZmVwZXFjOVh6ZGJPckVVVXVzS3o2?=
 =?utf-8?B?SllmSUlYMGxmT25aZmthZFZqWjV4bHp2bVZ5SjlOaVJJRi9OZk1hZ0RvK1Ns?=
 =?utf-8?B?T3lpYVhyc01INk1ycWVraDZsK1VNM2xJWDE3NWNaWDJKTkNXQ0swVEZWSTJ3?=
 =?utf-8?B?YjhKb0JZem11YVdpREhCNE9XTHVuRUZNY2d0VStHVjNpOE02TjdjUUNxMm5H?=
 =?utf-8?B?RkdKdk0wQ3NkME00dkFNVDhLRnhGeXNJVnJGTHVLUHNEeTRUY241ang0VkpB?=
 =?utf-8?B?V3B5ODJvVTduTEMxMEp3bVRHWTVVQThlelVSS2tFc1cxK21uK0xFNWdiUFZY?=
 =?utf-8?B?by9rRkxNaUVhcWp1eWRUWFBQZ0d4YklMNUJzblh5emJYQkVRYU94QkFLN2tW?=
 =?utf-8?B?a3ZZOFZQTWVnamJuYzQ5Ulh2NWxoZk5Ba3p2K1NZNktCS2VGWlNKUzFDMUx5?=
 =?utf-8?B?TjY4YXF4WXpWdzZLMER3bTVlcHFrQy9tRmhlanJFRWpkdTBFR0J3eUJaNnk5?=
 =?utf-8?B?bWNGQktpcXlOOTRQZStsYXJsdldreHZhWUJESUpOZFl2MFkzeVJ1SERpOVM4?=
 =?utf-8?B?S0Q2WG1JZU9TQy9VVzA2MGFPQ3NodEhZZDMyWVJPbFRseExMbTNwQzhhdHFi?=
 =?utf-8?B?K09ieWlPYzU3bUN5SEN6WEVrYTh5SmhoaDVvNmE0M3BUM0ZmNksxMGZiZXdo?=
 =?utf-8?B?aHhVQXF6R0NWc3RDNzZNdEczVm44NXpIOGFHUy9NUlp5VmpYMW8zWkp2RCti?=
 =?utf-8?B?cERqV0Uvc1ZEZUZ5RnhacU1DU1hyMmZEbGpCTXQ5SkVzQmFpTGhHQm1wQjl6?=
 =?utf-8?B?Mk1heEcwNnBZTjc5VXYwWG5rSE8xdlppUXRyMDA5Wnd5ajVra3ZpOFhCSDF6?=
 =?utf-8?Q?OEJw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55c4509-86b0-4577-16e9-08de3282f8e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 15:45:23.6168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHqhObFoR4aN3cK4KjKgsXporY6ZxM9jm+CKaIyI6Ay6cukm6qmJmbknY9PxefKqnfyHFqosIPXfLfIzdLSLjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863
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
Cg0KR3JlZXRpbmdzIFBoaWxpcCwgdGhhbmtzDQpEb25lIQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT4NCj4g
U2VudDogVHVlc2RheSwgRGVjZW1iZXIgMiwgMjAyNSAyOjMyIFBNDQo+IFRvOiBNYXJ0aW4sIEFu
ZHJldyA8QW5kcmV3Lk1hcnRpbkBhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjRdIGRybS9hbWRncHU6IElnbm9yZWQgdmFy
aW91cyByZXR1cm4gY29kZQ0KPg0KPg0KPg0KPiBPbiAyMDI1LTExLTE0IDE4OjI1LCBBbmRyZXcg
TWFydGluIHdyb3RlOg0KPiA+IFRoZSByZXR1cm4gY29kZSBvZiBhIG5vbiB2b2lkIGZ1bmN0aW9u
IHNob3VsZCBub3QgYmUgaWdub3JlZC4gSW4gY2FzZXMNCj4gPiB3aGVyZSB3ZSBkbyBub3QgY2Fy
ZSwgdGhlIGNvZGUgbmVlZHMgdG8gc3VwcHJlc3MgaXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBbmRyZXcgTWFydGluIDxhbmRyZXcubWFydGluQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgfCA4ICsrKy0tLS0tDQo+
ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jICAgfCA1ICsrKyst
DQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YW1ka2ZkLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQu
Yw0KPiA+IGluZGV4IDY0NGY3OWYzYzlhZi4uZTFiMjA4YWE3MmM4IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYw0KPiA+IEBAIC0zMTMsOCAr
MzEzLDcgQEAgaW50IGFtZGdwdV9hbWRrZmRfcG9zdF9yZXNldChzdHJ1Y3QNCj4gYW1kZ3B1X2Rl
dmljZSAqYWRldikNCj4gPiAgIHZvaWQgYW1kZ3B1X2FtZGtmZF9ncHVfcmVzZXQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICB7DQo+ID4gICAgIGlmIChhbWRncHVfZGV2aWNlX3No
b3VsZF9yZWNvdmVyX2dwdShhZGV2KSkNCj4gPiAtICAgICAgICAgICBhbWRncHVfcmVzZXRfZG9t
YWluX3NjaGVkdWxlKGFkZXYtPnJlc2V0X2RvbWFpbiwNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZhZGV2LT5rZmQucmVzZXRfd29yayk7DQo+ID4gKyAgICAg
ICAgICAgKHZvaWQpYW1kZ3B1X3Jlc2V0X2RvbWFpbl9zY2hlZHVsZShhZGV2LT5yZXNldF9kb21h
aW4sDQo+ID4gKyZhZGV2LT5rZmQucmVzZXRfd29yayk7DQo+ID4gICB9DQo+ID4NCj4gPiAgIGlu
dCBhbWRncHVfYW1ka2ZkX2FsbG9jX2d0dF9tZW0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IHNpemVfdA0KPiA+IHNpemUsIEBAIC03MTUsOSArNzE0LDggQEAgdm9pZCBhbWRncHVfYW1ka2Zk
X3NldF9jb21wdXRlX2lkbGUoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgaWRs
ZSkNCj4gPiAgICAgICAgICAgICBpZiAoZ2Z4X2Jsb2NrICE9IE5VTEwpDQo+ID4gICAgICAgICAg
ICAgICAgICAgICBnZnhfYmxvY2stPnZlcnNpb24tPmZ1bmNzLQ0KPiA+c2V0X3Bvd2VyZ2F0aW5n
X3N0YXRlKCh2b2lkICopZ2Z4X2Jsb2NrLCBzdGF0ZSk7DQo+ID4gICAgIH0NCj4gPiAtICAgYW1k
Z3B1X2RwbV9zd2l0Y2hfcG93ZXJfcHJvZmlsZShhZGV2LA0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFBQX1NNQ19QT1dFUl9QUk9GSUxFX0NPTVBVVEUsDQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIWlkbGUpOw0KPiA+ICsgICAodm9pZClh
bWRncHVfZHBtX3N3aXRjaF9wb3dlcl9wcm9maWxlKGFkZXYsDQo+ID4gK1BQX1NNQ19QT1dFUl9Q
Uk9GSUxFX0NPTVBVVEUsICFpZGxlKTsNCj4gPiArDQo+ID4gICB9DQo+ID4NCj4gPiAgIGJvb2wg
YW1kZ3B1X2FtZGtmZF9pc19rZmRfdm1pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMy
IHZtaWQpDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9j
aGFyZGV2LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMN
Cj4gPiBpbmRleCAyMjkyNWRmNmE3OTEuLjgxYTNlMGFhNDBhOSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiA+IEBAIC0yNzgwLDcgKzI3ODAs
MTAgQEAgc3RhdGljIGludCBydW50aW1lX2VuYWJsZShzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsDQo+
IHVpbnQ2NF90IHJfZGVidWcsDQo+ID4gICAgICAgICAgICAgICogc2F2ZWQgaW4gTUVTLg0KPiA+
ICAgICAgICAgICAgICAqLw0KPiA+ICAgICAgICAgICAgIGlmIChwZGQtPmRldi0+a2ZkLT5zaGFy
ZWRfcmVzb3VyY2VzLmVuYWJsZV9tZXMpDQo+ID4gLSAgICAgICAgICAgICAgICAgICBrZmRfZGJn
X3NldF9tZXNfZGVidWdfbW9kZShwZGQsDQo+ICFrZmRfZGJnX2hhc19jd3NyX3dvcmthcm91bmQo
cGRkLT5kZXYpKTsNCj4gPiArICAgICAgICAgICAgICAgICAgIHJldCA9IGtmZF9kYmdfc2V0X21l
c19kZWJ1Z19tb2RlKA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBwZGQsICFrZmRf
ZGJnX2hhc19jd3NyX3dvcmthcm91bmQocGRkLQ0KPiA+ZGV2KSk7DQo+ID4gKyAgICAgICAgICAg
aWYgKHJldCkNCj4gPiArICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+DQo+IGlmIChw
ZGQtPmRldi0+a2ZkLT5zaGFyZWRfcmVzb3VyY2VzLmVuYWJsZV9tZXMpIHsNCj4gICAgICAgcmV0
ID0ga2ZkX2RiZ19zZXRfbWVzX2RlYnVnX21vZGUoDQo+ICAgICAgICAgICAgICAgICAgICAgICBw
ZGQsICFrZmRfZGJnX2hhc19jd3NyX3dvcmthcm91bmQocGRkLT5kZXYpKTsNCj4gICAgICAgaWYg
KHJldCkNCj4gICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiB9DQo+DQo+IE90aGVyIGNoYW5n
ZXMgbG9vayBnb29kLg0KPg0KPiBSZWdhcmRzLA0KPiBQaGlsaXANCj4NCj4gPiAgICAgfQ0KPiA+
DQo+ID4gICAgIHAtPnJ1bnRpbWVfaW5mby5ydW50aW1lX3N0YXRlID0gREVCVUdfUlVOVElNRV9T
VEFURV9FTkFCTEVEOw0KDQo=
