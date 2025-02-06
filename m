Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951BFC02192
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 00:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F8210E0F5;
	Thu,  6 Feb 2025 00:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uPT5QRd6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606B910E0F5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 00:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOBCOOd+BBFwqCmwTr92/xhjK0fn/9crpfx9mBOW5bXZ1Mu/O/EROUiRfxuyAYq369r07Emat1F8oanQDbFkNPuuHgO+E7IRYbFJXoKY8w9sZl8/bRdbjxLmQUbPDSlwGJOq13TIaIX73YN6n3PWnMrnMIIWSQXQgs2FSTp11ahsLvscJpixYFxLBg/6niZx9otkNPFJkcA9WJ3xmnWPhgMMLhALcZDKpsD37y1nW8PN/1obGth4sLdAa14XQXgnp++kgFskRTMDe+Ik5vYhWLBbbbVfMEiTvEpmVWqChC9/1EIvZxM58tD34iuwYvNJU3vUNwW+dSma/0gG8OfzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgM0I4fejaGkqrwGMe2kG1GodCEeXmOPqhXSCqzqQQE=;
 b=O/nP7wFWK/W1WtD6nyhoHO13pEaA1PTjNDtDbH6Rq4fkmDQ3ujl3lzsptoc73CUb8ZX1ddZCPmz94IAOFveikIx6LN7Crr/uCp/ZQvzl9PRHbUXWRmwtao0dFnsskOjAektp8o4+Bg/2xytPdQXm3JtByMbRUnHdA7OxddqOxenDsgV/V0OH8g3J81GULVYFQ6J9hFP8mWJLxL0M3LtbOv5LW21MzwtHwM+SShDuPqMhuXr2BMn7vDC1HPw55bFnJ7Y02TzaF11s7yo09EINARKQFSGuGRK2T+921bxaBLA2embEADEqvwybOh0BPJbTrLYhtASA7iWt3dGa12E+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgM0I4fejaGkqrwGMe2kG1GodCEeXmOPqhXSCqzqQQE=;
 b=uPT5QRd6xTujK2LsfM37zkOcbvySs2LgEn3z677b/scRWskZfNesJd6eHhwD19fJ9kUgqgE3ye6lu28AgD+fsLYPxc7qvAIAGFYf3IymCu02BEGihzTUGSdXXAW8vbpO0t3zSpw7fnlG0pR9ujik6viR22LYL/Q6i5bVd2pGjlg=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 00:25:15 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 00:25:14 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/include : MES v11 and v12 API header update
Thread-Topic: [PATCH] drm/amd/include : MES v11 and v12 API header update
Thread-Index: AQHbd/1Tio60P1LafUq+ZlOOuyv6mrM5FCQAgABWvZA=
Date: Thu, 6 Feb 2025 00:25:14 +0000
Message-ID: <IA0PR12MB82081C5C3CC69ED912B436C090F62@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20250205183738.103990-1-shaoyun.liu@amd.com>
 <CADnq5_OXOegZQ=iHJanfAi6K7ZhpdzccLe3eNcP-ceBTzKCNFA@mail.gmail.com>
In-Reply-To: <CADnq5_OXOegZQ=iHJanfAi6K7ZhpdzccLe3eNcP-ceBTzKCNFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9ee219f1-08b2-4527-8851-b4c47ddb1c24;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-06T00:24:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|CH3PR12MB7523:EE_
x-ms-office365-filtering-correlation-id: 7726dbb8-9bc0-445b-d6fb-08dd4644b9b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q3NFckRMYm1hNHlyV2JEZmNIaGx4aG1KRTI5TUg2eCtES1FQZGswWUpwK0ds?=
 =?utf-8?B?U2NlRXgxVllxZ3BjOUlZdnNnd0FRSzR0eGl0RGordjJsaFFXamdCdTBnayty?=
 =?utf-8?B?QWErYVJNSUM5THo4WmFrdlZLOGMwOHhKc3kyK3ROeTBIVk9vVCs2Y2RxSm5i?=
 =?utf-8?B?SnlnME9CYjg3emd5NEt0WEZiTkk5ZG1COE9iejVrV2l6K1U1OXJxK1JPNnVm?=
 =?utf-8?B?U0pOampNdHNKSFlwM2VRVjZ4aHpYRXVNNWJsajQ3cHlMWnZNMFFhaEZuZ3k1?=
 =?utf-8?B?R3ppYkcwaHBHVjhWNTdXdFFLck0zWmdlSm1YNDJ0Q1o5bjNrVUlBM3lVd3FM?=
 =?utf-8?B?V3FOUGhyQzYrMW8wM2psUHJVS0Z5K2owaU9GSVZpM3pWTTdUeS9iWkx0OHhE?=
 =?utf-8?B?ZlpoanRVdWxYVGhZOVdKMG9XRHpTUmN0UHFybm5INmhtcFRGSzFUOGJFaXN6?=
 =?utf-8?B?WmdsSG1Ka2lqWWxkUEJLVjlaYzFINWI2QmVoTmdsQS9oWmxTSGFYcUpVeWZP?=
 =?utf-8?B?Uks5SnVhbGhwb1dwZ1BKYUZYMllvbE9XcmtCK09sSmJ1NVlJbENYRTBKRTFQ?=
 =?utf-8?B?RzdjUityYVRYak1DWkFOU3IxY2M0YVNQcENZVFM4MFMyZzRJUVdHUWh1N0Vr?=
 =?utf-8?B?bDNwZHJhRjNJem8zV3pBTFNlWEU4K3Rlc28vMG1ObUJZWHZKVjhtMmlNa0My?=
 =?utf-8?B?OWtLYUZyVlVvMWZrbHpMWXprNnIvRmlMRVZ0V3ZEWUhIWmFBb3FIUWI2T0xq?=
 =?utf-8?B?eWlVOHFqYzhOd2ZqczU4U0hXcEVZK2FUWnpFL0xqUUd2MElQck9ZdG5ZbUZy?=
 =?utf-8?B?akxnRXUxbWswYXpOc3BnZSs1eWdBSEZpeVl5cXVsZzJuajVlUVJzbnFNeGtk?=
 =?utf-8?B?bWR5aDBMQ1pDV0lCK3FNbDQ4Q1dyWkwrNzRUcTB4c2xVSTdFNWZiM2VkcGtR?=
 =?utf-8?B?M25kRW14TGllQVVITHhJSFp5SUI5dHUyWjRYVU5KVHIyM3FVMDhIejV2TTl3?=
 =?utf-8?B?Szd4emQ1bERxUVFpSnRhNk5Ua0NINzBYSkZLYWQzVmZ3Y1NQck5JMFBtVjM5?=
 =?utf-8?B?NFFMWlBXU3VaNmFIVTJDRExudmQxZUwyVmpQT2dlVmhUZXRLZEZsdjREakJ2?=
 =?utf-8?B?cmpjeDM3RHdjWTIxVG13UzVRNi9XK3BLNDF0YjVON2h6OXVSOFFXblRKcW5U?=
 =?utf-8?B?SjVtZGkxcm1lVnozM3dxYWcwVGZrV2dyTHJDUU5qbFlGTW5LREZMbjc3djd5?=
 =?utf-8?B?dlIvWi9ERDcvalhlSEhsbVZ1OWhPeVFVLzVRa0VXSDJMSEg5WG9kdHQvZXQv?=
 =?utf-8?B?QS9lUTgwWXQvRE1Hd0FYWXhxdFhwdDBEUGlOUVpUc3loTFhMV0JpejVrWE1w?=
 =?utf-8?B?SDZnbVhsRCtXL1lJTUhFVkFGaUx2SUQwY1prRlR5eUptTW5kbThvV2t6b2Na?=
 =?utf-8?B?WHFtcmlURUZUMlRiL1ZuVjN6dTVGWGNwTFl3QmRPZ01IMW5wY1MrMVlZeHhw?=
 =?utf-8?B?YVBDWVBXWC85U1FPZ1JoRnQxUXFidWV5TC8wZFVTMlM3elV5MFdyWlpZdUdy?=
 =?utf-8?B?SUpaT0ZmcTI1b21QZlltMGZvK0ZwWTZ6WGc4aTRBZ3kyYysxUDNwd1hSSmNF?=
 =?utf-8?B?dGtxZC9CSS96ZXZpSTBUcU5UNnoyWjJrQ2VlR24rcFJubFVLS2d5aEdaOHJy?=
 =?utf-8?B?WWRyaVloZTVscU1TRkNpck9pT1UvRUFoZDNEZTBYVUh0UlF0VmJzaUZFckhO?=
 =?utf-8?B?emo3SzJ1MERJd1F0ZzMwMUlIaGI4SFhjZTNQU0pqS0tBK3M0K1dka01MZ1Fn?=
 =?utf-8?B?RjZLaVp4WEhBaHVBTU90WWhUbm1QTWZlQ0hxY1JVMFUwcExob3RXUGhLZkho?=
 =?utf-8?B?ZTI2VDQwUXZvRG84cm1SWFU2QStYcGdTRlNyTG4waWRPT0duQm11eG9MYW1W?=
 =?utf-8?Q?fvNnj+JlVhxQqKxBh+6A2v7xSnV174zk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUZJREE0U3MyODVLSGdWWFdqNDNEQXF0eDBOeDZRMXhiODBxUWJtWStrcktq?=
 =?utf-8?B?NlhzQ1RYekZaMVU2b1VNUkZjRTJLMjAzUG4zNHpWZTV2M2t1bWJzMVpzWnFp?=
 =?utf-8?B?Z0ZPNmRKd0JKNnRJdlYvNHNEOGt3d3J0eWc0OWhZQ3AyN0UvaGFKbDhGQzBR?=
 =?utf-8?B?RUVNTEFiV2YyQlZQT0ZlUTZNUVJ1Y29lNnBqVlcxY2xNb0NTUEpUYWJtalJ2?=
 =?utf-8?B?VDVtSWJVYzdQSG5lL2lIcDlTd0FBZGRhbFdiNXFqbmJtWnRQUi82T0NNZHJi?=
 =?utf-8?B?Rm1LQ3RtOE9lWTBjNUt6bW9nWmZrYXJvQnI3QnRDUkxCWXFYMmJOUEsrUjh3?=
 =?utf-8?B?dVd1QndRbVZidWgyUFQzNklFTXQ4L1hSWjVSMmJOVkVRZExuYVlXVW05S1lF?=
 =?utf-8?B?ZzdBQ0Q2S296RFFHVGdFR3BGVW53ck9EeWs4MGpuVDh6WHV3eEM1Q3lkc1dP?=
 =?utf-8?B?VzNNOXBCdmh6SjR6ZkR0bGwvTVhSajJBSkdPVlppbVo0SDVLYWQ4eDJOUXZ6?=
 =?utf-8?B?c0VpT0NqVEJGZlRIMkgzMS8zU0lTSkx5aXJhR2JCSWRCY1hiTHpGN1lpNW1H?=
 =?utf-8?B?K1Fkd3dkVGtGejFCTGZ1cXY5N05SKzYwb0MvbFUzdVBUaExlV1hMdHk5MVlv?=
 =?utf-8?B?ZjZhVzVsOTJQMjMzaHFaeDJiVzZuZVE1c2VNUDBOWEkra1FJZFBoL1daRDJk?=
 =?utf-8?B?MFk1Vzl1Vm1jL21LNE5HZnY5b2xDUkREejJlNHgxVkJYWlhjRGxlaEtLMHRa?=
 =?utf-8?B?bnBUWVR0Z3BvQUE3L3pDeElDWFNXS1d5ZE82UTRONTh4Zy9jQitsSXE4QnpP?=
 =?utf-8?B?eEQwRmJjVjhHb1plWXlBcGR1TVREWkVUbkxEY2szeDRKekRPNUJHa0pSbm80?=
 =?utf-8?B?NExjdFpWVlF5VmhTZDI0SUh6cFZBM1M5RmVveWFQY1ZEZ0RBQlZtSXFQT0sr?=
 =?utf-8?B?bGxSOFBCT29iamF5YTdsb2tRaTFPdnpzQlNKcnU2OEhuLzZ4L0Z6WUJCSlhs?=
 =?utf-8?B?b3lOaFFXa1g4Q0g5aWl0d1BTUWxEN1JFeUwzai92NHJmT21FUjRPNjB0cndQ?=
 =?utf-8?B?bTZBM3BoeFdTMTNyOGFENG5VVnpwT1Zwd1NjWG5pdksrcEFLSnNlSnZCSE83?=
 =?utf-8?B?aWE5NVR4R0xFcHZPOUhxMjhLbmY2Q1ExU2QyU29KbG5YVTFwMEsvSzNWMUFj?=
 =?utf-8?B?cE1QbVUvSDh6YUpvUEFjbGhETkp1SDFONERJUWh5MFRldHRFVm9pc0NFZzM1?=
 =?utf-8?B?YjlucWdRTkdjYXBJNkFaazhaaE1GQks1WW9DYS9hZ3lPYWladzZ2MEFmbmxx?=
 =?utf-8?B?L3lveUlyR2NLSmRPQlVHYlNzbjdOQ2pTMjZwOWtLUXdSK3Q3M0VIQlZFTy9z?=
 =?utf-8?B?b1RJaXlyUXpqRnZ2azZyQU1vV2ZNdEZ0emI2aldrVW0vVFlZSVFQZzcyOGhj?=
 =?utf-8?B?MjYreEFqWkI4emN4RGlDMGRFOHNtc00wTXlnbUVBRUF6azJ5OFJWYzB4K2lR?=
 =?utf-8?B?Z3hBQkJzVzVSSE1idlZ3cUxnT3pQTTNzWEpIbEJQK1E0Y1Zvd2JIcjJBYnpr?=
 =?utf-8?B?Q2RyNUs0WDEyK2ltci8vWmViN1ZoZzhJWkUzcWtSYW5acGNVRHpXVnFYV0t0?=
 =?utf-8?B?a2lpc2tzNnFsTGlxTlRpYmdQeE10U0ZKdU1CK1hGaGJxU1ZERzFxNnN4UHhS?=
 =?utf-8?B?VTA5QmhLbVEzRlBRRlRjNFdvWnVCRldWazJTWXhEOEZYZEhvRDdlaG00bEV2?=
 =?utf-8?B?czVDbTRGNzNTckwxVE9lMDBmMTh0QUZFME5yWEJ1SVpsbENvOUFMWmhYVzlj?=
 =?utf-8?B?bURBNkl4RE1kT2ZLV1kyZ1BXMlZJUE1ST1c1SlhRTCt2T3AvUDdJRVh4blIv?=
 =?utf-8?B?TGhHRDk3R1ByVUgwNlJaamVyTFlRY1VEeW5YWWZFeWxWczFEVHB1L09iaVZE?=
 =?utf-8?B?MWdpUkdRczhOL1JiaXRzM09IYy92Ti9iWW9ySWRXSDdsVExia3ZYbmh0MXZ3?=
 =?utf-8?B?eGFPRzlQSWo2UEZhNlowZEZrVkFaRFM3UlRVblBid2tuWmMweSt3d2x5UXdO?=
 =?utf-8?B?bTFkRGlXcWhWK0IvSXgwQVlmeFZ2Y2JNbVl1eDdKTlNoYVJ2Y3VYOGZ3ektT?=
 =?utf-8?Q?J2QE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7726dbb8-9bc0-445b-d6fb-08dd4644b9b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 00:25:14.3679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtfMpmFVW2va4ygW8H07HQ18Q7or9OSWiH9eQCbpXlHwKxStI/yLHV3hkfwj8OcgOSf8sB3Qzyb+gdSHVUGWHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
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
Cg0KQWNrZWQtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBh
bWQuY29tPg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXggRGV1
Y2hlcg0KU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDYsIDIwMjUgMTI6NDQgQU0NClRvOiBMaXUs
IFNoYW95dW4gPFNoYW95dW4uTGl1QGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvaW5jbHVkZSA6IE1FUyB2MTEg
YW5kIHYxMiBBUEkgaGVhZGVyIHVwZGF0ZQ0KDQpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQpPbiBXZWQsIEZlYiA1LCAyMDI1IGF0IDE6NTfigK9Q
TSBTaGFveXVuIExpdSA8c2hhb3l1bi5saXVAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IE1FUyByZXF1
aXJlcyBkcml2ZXIgc2V0IGNsZWFuZXJfc2hhZGVyX2ZlbmNlX21jX2FkZHIgZm9yIGNsZWFuZXIN
Cj4gc2hhZGVyIHN1cHBvcnQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFNoYW95dW4gTGl1IDxzaGFv
eXVuLmxpdUBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9t
ZXNfdjExX2FwaV9kZWYuaCB8IDMgKystDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9t
ZXNfdjEyX2FwaV9kZWYuaCB8IDIgKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2luY2x1ZGUvbWVzX3YxMV9hcGlfZGVmLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1
ZGUvbWVzX3YxMV9hcGlfZGVmLmgNCj4gaW5kZXggZWI0NmNiMTBjMjRkLi42YjVjZDM0N2RmYjUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9tZXNfdjExX2FwaV9k
ZWYuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvbWVzX3YxMV9hcGlfZGVm
LmgNCj4gQEAgLTI2Niw3ICsyNjYsOCBAQCB1bmlvbiBNRVNBUElfU0VUX0hXX1JFU09VUkNFU18x
IHsNCj4gICAgICAgICAgICAgICAgIH07DQo+ICAgICAgICAgICAgICAgICB1aW50NjRfdCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVzX2lu
Zm9fY3R4X21jX2FkZHI7DQo+ICAgICAgICAgICAgICAgICB1aW50MzJfdCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVzX2luZm9fY3R4X3Np
emU7DQo+IC0gICAgICAgICAgICAgICB1aW50MzJfdCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVzX2tpcV91bm1hcF90aW1lb3V0OyAvLyB1
bml0IGlzIDEwMG1zDQo+ICsgICAgICAgICAgICAgICB1aW50NjRfdCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzZXJ2ZWQ7DQo+ICsgICAg
ICAgICAgICAgICB1aW50NjRfdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY2xlYW5lcl9zaGFkZXJfZmVuY2VfbWNfYWRkcjsNCj4gICAgICAg
ICB9Ow0KPg0KPiAgICAgICAgIHVpbnQzMl90IG1heF9kd29yZHNfaW5fYXBpW0FQSV9GUkFNRV9T
SVpFX0lOX0RXT1JEU107DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1
ZGUvbWVzX3YxMl9hcGlfZGVmLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvbWVz
X3YxMl9hcGlfZGVmLmgNCj4gaW5kZXggYzliMmNhNWNmNzVmLi4xOTM4MTUwYTE5NDMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9tZXNfdjEyX2FwaV9kZWYuaA0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvbWVzX3YxMl9hcGlfZGVmLmgNCj4g
QEAgLTI3OCw2ICsyNzgsOCBAQCB1bmlvbiBNRVNBUElfU0VUX0hXX1JFU09VUkNFU18xIHsNCj4g
ICAgICAgICAgICAgICAgIHVpbnQzMl90ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1lc19k
ZWJ1Z19jdHhfc2l6ZTsNCj4gICAgICAgICAgICAgICAgIC8qIHVuaXQgaXMgMTAwbXMgKi8NCj4g
ICAgICAgICAgICAgICAgIHVpbnQzMl90ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1lc19r
aXFfdW5tYXBfdGltZW91dDsNCj4gKyAgICAgICAgICAgICAgIHVpbnQ2NF90ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJlc2VydmVkOw0KPiArICAgICAgICAgICAgICAgdWludDY0X3QgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY2xlYW5lcl9zaGFkZXJfZmVuY2VfbWNfYWRkcjsNCj4g
ICAgICAgICB9Ow0KPg0KPiAgICAgICAgIHVpbnQzMl90IG1heF9kd29yZHNfaW5fYXBpW0FQSV9G
UkFNRV9TSVpFX0lOX0RXT1JEU107DQo+IC0tDQo+IDIuMzQuMQ0KPg0K
