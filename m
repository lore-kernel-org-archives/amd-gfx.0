Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A338AD374B1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 23:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D3DE10EBD5;
	Fri,  5 Dec 2025 23:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GD/lduR5";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB37410EBD5
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 23:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGlE2hI6mDesFz1YJ0xXiWu0JIGrddwXGxfVlmBXjtnrLAng3dRgYuP1FNseNvY9eghKmgX+87NjTdqgBANDSCmpppPsY0zMCtFXtucYlVQM991NYWbDWqjY3JZZjIl6k9gFpTXGzmlcOFwoOcC/Lwv+g85NyXX9hHBz3gRRE4qGeeH+ptsXOYpo19Nr/y2Z8vn/tgRJeDbpA0v4NW1XkjA5Nq7nZbFVY71L8WS9UfqvcD9d7HazL+Sx5IpFeftjaz5LSNdC5l8ql/Z3lz+6Eq+xhI5aeriw+sjlDb7pCCBCeEoFPtRo4p+NOdnkZtYZk4xeYRXBD6kXMG2bXp7/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPeCw+PCVb3AH+JbZtLoZJYJR8LzX3H4iFAae7Z84pY=;
 b=kaJxPKewgUb8ZLjoGo+xBVAJ2CbtrLI3P9j4DQ0eFEIqHW0cQ7YhrE+af4a81Vmyt6xZbHxHMTcT0+QoQpDTk//Tcd2DvW6v3oq/OI+U0WnbGc1u3hBzZEiRfvYdfxqu9wDqevBNfoz9+RuZKKpCzYuNZKRX9d1BcAd0KV/uWsYjYr+fIv7pA8pFqRi+hexUrAjXxkqlrcoFPhw8CcK1W1Jof9xBcqhRQsQt9PTr2Or3Ob2/1ASR82/Iz27fSZDFjRld74H9N9RdbJRhDgLvyha1X2rHWiTWEdk2X2z6zq4Qo9pMgHBr8xn0QJeUfUGMYIHhfr7LWwJ/ORB5ZEKTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPeCw+PCVb3AH+JbZtLoZJYJR8LzX3H4iFAae7Z84pY=;
 b=GD/lduR5YXFICvxEz6klbIp/jX0mUSS1Y3+taPDHN0YPJD4Ay4iftO/1hQUW9cOCrMaE2pTlhuY7lbxMT2AYWnZeLzPZa4CSGd+reaoa9ykt6j03riNZvy6ienQDeGFEVnpkt3OSPGbW7IGBrv7McUo7GIcR3ysn2fHkkrPbq3M=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Fri, 5 Dec
 2025 23:04:18 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%4]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 23:04:18 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5] drm/amdgpu: Ignored various return code
Thread-Topic: [PATCH v5] drm/amdgpu: Ignored various return code
Thread-Index: AQHcZGNjpu4mNYHpFEKWQeRQ2SjAmLUTQY8AgABsXoA=
Date: Fri, 5 Dec 2025 23:04:18 +0000
Message-ID: <SJ0PR12MB8138BA866155607670ADBC16F5A7A@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20251203144435.62300-1-andrew.martin@amd.com>
 <fb4a772b-5774-4aa4-a6a7-80a9b6cc080f@amd.com>
In-Reply-To: <fb4a772b-5774-4aa4-a6a7-80a9b6cc080f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-05T23:03:21.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|IA1PR12MB6113:EE_
x-ms-office365-filtering-correlation-id: a9142247-a4d8-4e05-ec58-08de34529e6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?YmJjcWxrVDczZzN3THFPRXFTUkV6cUNUNUowMnU4Tlh2ZjRXZmRnTkdvTFR5?=
 =?utf-8?B?VTFlU2FWNFJCMHpDZ0lSZnp1UDBYR3EzRzl5VWpUQjFzUElqNjA0OU1TbDhF?=
 =?utf-8?B?WlpBaDAwbDdWVEc4VHp0NGxoY0pFL01PZlV1bS8zNUkvRkNhbkJTbVMyMzhj?=
 =?utf-8?B?MW1YRVJNUFN4TDdJWExQMkxzb3lmMFRhZmhYZDdXMlk0TWRKaFcrWmt5aWtB?=
 =?utf-8?B?U1JCS05CS09HOTBtd3hwdnU2cFBHejJHV3RKbW9CRGJhY1FwSHl3ZTlLdVF2?=
 =?utf-8?B?c3c4bmZjdG5PL1ZMZmJramJtSjF3bXZ5MlIvWGh4WDFobHJuOTloSFFjRjda?=
 =?utf-8?B?djE3d1prdEdUdEJCMEJaMjFkS1Vha256eU1jTy85OCt1QnFYdTZlS2FjaUhJ?=
 =?utf-8?B?emxFNHpsTFlpckY3Z2xZVG1VMFAyR29QVG9BSDhIUWNnZ1ZkbXVwNzV2amdE?=
 =?utf-8?B?VVNUNmRqVGw1RG5BVjVFWVNISUVjWE1YWkhnVVhoS2JFakM3TlN0VXNJTEhJ?=
 =?utf-8?B?MG93c25ZNnB3V05qQ05pNWV1dmpaNXhTTkNKS0IyZEcvNTVxRnN0OW5vN0JG?=
 =?utf-8?B?VHpqVll1bzBsdXcvZ1RwVmRyeUF2SUhRcmFycU1PaDdjRmxyakdONW16Rjc4?=
 =?utf-8?B?T040QTZkZmNsTTFuN2dJMkFRUHNXWHkzZXB0QkNkTG9IOFUyYkxSbkZvSld3?=
 =?utf-8?B?eDZOYjV1SEFKN250NjE0UGpjdWoxN2lwa3VKWlB3YlNrSGMrZWRFeEVMVlFK?=
 =?utf-8?B?YlNyWEpUNmwxNkIxNGpVdk5HRGNRQzJFREhBWVRlTWt4MzBad0ZvQXQ5VHkv?=
 =?utf-8?B?K2ZXdG5xWVlyVlhIR0s5NDFWY3VXeXFlN0NGeGZCQlV2RUI5ZXEybXdzOVB0?=
 =?utf-8?B?V0VXdnAvWEVZQzBvY0Zpd2diMWQ2S3FRNDBEMmNUenFoSFdiVTVnRjViZkxI?=
 =?utf-8?B?WXBpNGVvalVCOGZ0eUxocjBSNVFlN3FPTnlpRHdEc1h1aVRLRmozN05BLzJK?=
 =?utf-8?B?Qmc0QzdkdEh4LzMxUkR5a1NKaEpQNHFndmorc1hCdkQ5Q3h1UEpxZlA0OWF1?=
 =?utf-8?B?THVEWWhia0hQT1NKQnVTZ3ZlWkJzVVlUSUp4YkJzZGdYcGI1RSs4VWt2c3ND?=
 =?utf-8?B?RllERXQyRGFXVjVCQytHRDRWZDZQM1pFSml1dDdXOWlrZzVEb0VKWGd0cmtT?=
 =?utf-8?B?a2VESzVOZXBtSmJhOGU0QUs2TDNGMzcycVRyNDc5MGJqQlZkUUVFOGp5THdO?=
 =?utf-8?B?TzdnbFYxSExwTzh3b1NUZFpYMlNjWWxKSW9TSzh4NUJ1RUVtWmErMElvc2ly?=
 =?utf-8?B?V2lURmtBWmNLay9aMElnZ2V5TGRxNC83WUoxTDJtbnBoS3FmUnJ5akUwdjMz?=
 =?utf-8?B?d1V0aTVRWUdMMXFoMm1PZmFIRWxOR0FUQk9MazNtRHB3V1B4cUFuRy9DaGFI?=
 =?utf-8?B?azNaSXZ2cWNqZjNwUWg5SnFJQVEzRnM5NFkrckkraGx1NVI4ejVxU2FJQlE4?=
 =?utf-8?B?YVMzN3lCTmVqa1VhZE8yLzZoMHVsYTZyY1Irem5FVGFnWlpWU203cGpoWTQy?=
 =?utf-8?B?TEFSZG1uZW5iZHRRaEV0eUhRUm9qQm9SS3N1ZzE5OGtyVDQ0RjcwaFI4MkRS?=
 =?utf-8?B?UkVzVWVOTVBacmt2MW5zQTVud2RUSVJlMnZVcXRxdVdnRTZ3RjRhdUI5dHFh?=
 =?utf-8?B?TXdvN09HemcxQXhBcFZRdFpGRDZxU2x2a0pmZTRtdVljRnZ4VzVvVTRMVWZr?=
 =?utf-8?B?dzRuUGQ4djIrUVVmVVR6Qm15Mi9kNllSb3VkNWZ6SjFQbkdoOGxJemFVbjNE?=
 =?utf-8?B?QmxVeWh5RUNhUEtNbUNWRkgrSGpaNVN6V2dTM3MvMkJRVG9kK3M2by8xSWFL?=
 =?utf-8?B?K0taTk9UbFlrRkhTYjVTWXZkZ2dVR254UDQzTHhDSitGWitCaUZ1L2ZRZWNH?=
 =?utf-8?B?QWFoM0g4dk1Va1JlMFNJVXpIdU93Ky9uNkRPbHBlVUVVT3FwVTNNd1pBNjg3?=
 =?utf-8?B?d2V3TTdVM25nclVveGthTGhBRENvUzJCVlRTbHFDRmpabVNxM3N4amxzV1I4?=
 =?utf-8?Q?g0w5+3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEZNMmhhMXE5TEpRVEtWU0RPRVk1YVIxMjdqWmgrQ2dEZkhXSTUybUJCOW84?=
 =?utf-8?B?L1UrY3A1RDBDWlo2VFF1clFtRG1rZC9IU1F0allja1RQL3padnVUWGNGb3lR?=
 =?utf-8?B?aWQ2RVRVWDRRcFZkcjArVmhiZ2lXZzFXQlJZSWVnMUZzQUQwdU9lcVBiaXdS?=
 =?utf-8?B?Qms5Qk0xTFV2QVNJd0lvbFlNTitpYnBoZHRvZVA5SE1KOGlTaFlSZDEzWWIr?=
 =?utf-8?B?dWg4L0Z3RkFIb01TWWR2NnB3MGpFc0dHNy84QmVsak5iU2tDeU1CK1E3bEEv?=
 =?utf-8?B?a2NQd0t4c0pmNURjeFlnWTNxbUFpVEFJTW1tUTZqZ0VhK3hzZzBGMTk4LzZS?=
 =?utf-8?B?WGFaajd5OFY1bnRjQ2Y1OWRGWjJhZ0NzekROQ2FDdFNQRkdRQnYrc1RwMlBr?=
 =?utf-8?B?emdBbldFOWhxMHgxOCt3QVFySWNBSDZQbGxyRWxNQ2w5QXVtR1dhMWZpUlo2?=
 =?utf-8?B?eG5CMDRDRTZ0NFJFQy95N0FsVldmSVFFNHY1aUVIUEZWSFk3Zk8xRlVsbTls?=
 =?utf-8?B?U05mQzdDaDhLOTBqUW9scjI3NXpIZ1lvcWhGcVRLM3cvVzVoZUJwMXB4c1RL?=
 =?utf-8?B?MkFLUFBBT1lzbnRyREpobktjTHZNK0pzWDR1WVZxZzJnQjd2Zkp6QjZhcHNt?=
 =?utf-8?B?MWo4WXJ5cXpGdHdoMkl6N2UxZWZTOS9oeDB6b1dWQXZYNjVFS2xYZVp2Ymg0?=
 =?utf-8?B?L2k3d1Y4QkN0MHYzRG1tNnRyZHE1Vlcra2YxRWJ6TUpUWU5hNERLR1U2Rkp1?=
 =?utf-8?B?aWVXMloxWTBJYm9wN3FwcEcwWXduT1JzRmdUMGtXd2J1UHVRb0ZwbnhqZHI3?=
 =?utf-8?B?emRmZHVxV1prNEZOWThpVnFHdm9Hd3dudDNxQ0lOQVI2dkQ5SlYzUUcyQW91?=
 =?utf-8?B?Y0NWSFcrZHpaazNoSndLNnB3ZjljTVAxcEY2cEFZQVVvTXRmenl2MXg2MzNU?=
 =?utf-8?B?ZWN3MFE3YjRZbU96aW0xNXdKaUFxVi9ndXJvSDhjSWhISlh0Y3NRZXNUUm80?=
 =?utf-8?B?TmhmdmRRNHh4K3p5MDZEc1g5MCtQZm1VdEM4d05MdzlNMHYzNSsrbmtXYjF6?=
 =?utf-8?B?QUxJSDI1OVBkUGNzcU9hLzg3MXBZRGJKWXVwRUowNTJ5dzc5U0pneWZ5Q1l4?=
 =?utf-8?B?TFkzSVpaTWw5MWo4K3p6V0pJVWpyL0gwQXhaZjZveUFhaG94aFcrZmhoZzky?=
 =?utf-8?B?MElQOUl5ZEpFeHlQOGRBUnd5QndPQzR1aTVGQ21EMWFrREcvTGduYk9Qbzhk?=
 =?utf-8?B?OFlVdlpSQ3d4ZXRXQzlHVFJGNUNTMzVwZXcwWXhyRWZVTDJGbVVvUExZUFFt?=
 =?utf-8?B?R1o0cGNucXJRQ21IQXZmaFJrNzY2VWtmanVqbk9JNy9jVWZQU0NMVHVhYk83?=
 =?utf-8?B?TTQ3RWpXY0lMNHdwVC85NkFMRUpEVFRrTUpJYk5lbTJBUVN1dXlVWSsydDlG?=
 =?utf-8?B?TG5LbG9DZ1hGUjhxRDc1azhrM3J4RytGS1FIaWtuM3VYdXdGVWlycDBBL3Ju?=
 =?utf-8?B?ckgzV0cvcnE3UndYTEZjQjdLK3dMaVBSQUNMcTVuY0NlN3p4b29WOUR1V1hG?=
 =?utf-8?B?RXA3cEhWVHpxRi9LVUU2OWlkb0U1eDI4VUM4d0lEdEZxcVduOFBIVjlOcEFy?=
 =?utf-8?B?Wkc1MkxicnpiSmU5ektPYmpQbGl0bFNzWlhMN3U3bTd0enR5MFppUy8xL3l5?=
 =?utf-8?B?Lzg2a1RtTlV5OWZaTHBVUkRpS0tNOXFsQU5SNWQzeWYrUVZjSUFidkJDcjFV?=
 =?utf-8?B?VG9OSHJuUy9iVWFONEJuRUNmR0svblVjZHFiSUdzN0lOVUM1UldMWVFwbUsw?=
 =?utf-8?B?MkJSREJ1ZldRTkZPTDNsUnJDRkg0VjVwUmd2TnQ3V0U4SWNJVmYvSzh0NGg1?=
 =?utf-8?B?c1VyU0xZUzNLRjcxUjlVTGg5ZmNOSjNtanRXU2pGdnh5Rnk2S2JiTGMxeXZl?=
 =?utf-8?B?SUlMM0hQalhNOFMxK3hPUit4WmtQR0xpWmtWWGV6dVNMeW5saTRQdjdaVERp?=
 =?utf-8?B?Z1g5WTB3UzBndDZFcTNVOHhVemRwK0dCTnQwK0EwOU94TGNkS1RaZ25xSGpU?=
 =?utf-8?B?cHhLM3h3K0FRaTFNTlZIQWdRdUZPK01lL1hFdzYwdGJzSWFIM3ZFN3ZFZWww?=
 =?utf-8?Q?WH90=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9142247-a4d8-4e05-ec58-08de34529e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 23:04:18.2403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAjNb6d+ql9pxL/hHAWTMqdRlgVVSYGkkDjAk13mG6APibjPCqYHR38IQg4qZS25egc0WeY5OjD3cKlPxUhIWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
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
Cg0KR3JlZXRpbmdzDQoNClRoYW5rcywgIGZpbmFsbHkhDQoNCk9uZSBsb3ZlIQ0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhs
aW5nQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgNSwgMjAyNSAxMTozNiBBTQ0K
PiBUbzogTWFydGluLCBBbmRyZXcgPEFuZHJldy5NYXJ0aW5AYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjVdIGRybS9hbWRncHU6
IElnbm9yZWQgdmFyaW91cyByZXR1cm4gY29kZQ0KPg0KPiBPbiAyMDI1LTEyLTAzIDA5OjQ0LCBB
bmRyZXcgTWFydGluIHdyb3RlOg0KPiA+IFRoZSByZXR1cm4gY29kZSBvZiBhIG5vbiB2b2lkIGZ1
bmN0aW9uIHNob3VsZCBub3QgYmUgaWdub3JlZC4gSW4gY2FzZXMNCj4gPiB3aGVyZSB3ZSBkbyBu
b3QgY2FyZSwgdGhlIGNvZGUgbmVlZHMgdG8gc3VwcHJlc3MgaXQuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbmRyZXcgTWFydGluIDxhbmRyZXcubWFydGluQGFtZC5jb20+DQo+DQo+IFJldmll
d2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4NCj4NCj4NCj4g
PiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyB8
IDggKysrLS0tLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2
LmMgICB8IDggKysrKysrLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZC5jDQo+ID4gaW5kZXggYTI4NzlkMmI3YzhlLi4wMjI1OTg4NmY5M2Eg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5j
DQo+ID4gQEAgLTMxMiw4ICszMTIsNyBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9wb3N0X3Jlc2V0KHN0
cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2KQ0KPiA+ICAgdm9pZCBhbWRncHVfYW1ka2ZkX2dw
dV9yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAgIHsNCj4gPiAgICAgaWYg
KGFtZGdwdV9kZXZpY2Vfc2hvdWxkX3JlY292ZXJfZ3B1KGFkZXYpKQ0KPiA+IC0gICAgICAgICAg
IGFtZGdwdV9yZXNldF9kb21haW5fc2NoZWR1bGUoYWRldi0+cmVzZXRfZG9tYWluLA0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmFkZXYtPmtmZC5yZXNldF93
b3JrKTsNCj4gPiArICAgICAgICAgICAodm9pZClhbWRncHVfcmVzZXRfZG9tYWluX3NjaGVkdWxl
KGFkZXYtPnJlc2V0X2RvbWFpbiwNCj4gPiArJmFkZXYtPmtmZC5yZXNldF93b3JrKTsNCj4gPiAg
IH0NCj4gPg0KPiA+ICAgaW50IGFtZGdwdV9hbWRrZmRfYWxsb2NfZ3R0X21lbShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwgc2l6ZV90DQo+ID4gc2l6ZSwgQEAgLTcxNCw5ICs3MTMsOCBAQCB2
b2lkIGFtZGdwdV9hbWRrZmRfc2V0X2NvbXB1dGVfaWRsZShzdHJ1Y3QNCj4gYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgYm9vbCBpZGxlKQ0KPiA+ICAgICAgICAgICAgIGlmIChnZnhfYmxvY2sgIT0gTlVM
TCkNCj4gPiAgICAgICAgICAgICAgICAgICAgIGdmeF9ibG9jay0+dmVyc2lvbi0+ZnVuY3MtPnNl
dF9wb3dlcmdhdGluZ19zdGF0ZSgodm9pZA0KPiAqKWdmeF9ibG9jaywgc3RhdGUpOw0KPiA+ICAg
ICB9DQo+ID4gLSAgIGFtZGdwdV9kcG1fc3dpdGNoX3Bvd2VyX3Byb2ZpbGUoYWRldiwNCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQUF9TTUNfUE9XRVJfUFJPRklMRV9D
T01QVVRFLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICFpZGxlKTsN
Cj4gPiArICAgKHZvaWQpYW1kZ3B1X2RwbV9zd2l0Y2hfcG93ZXJfcHJvZmlsZShhZGV2LA0KPiA+
ICtQUF9TTUNfUE9XRVJfUFJPRklMRV9DT01QVVRFLCAhaWRsZSk7DQo+ID4gKw0KPiA+ICAgfQ0K
PiA+DQo+ID4gICBib29sIGFtZGdwdV9hbWRrZmRfaXNfa2ZkX3ZtaWQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHUzMiB2bWlkKQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfY2hhcmRldi5jDQo+ID4gaW5kZXggMDQxMjM3ODYxMTA3Li42NmRlZDNjMDdlZWYgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMNCj4gPiBA
QCAtMjc5Niw4ICsyNzk2LDEyIEBAIHN0YXRpYyBpbnQgcnVudGltZV9lbmFibGUoc3RydWN0IGtm
ZF9wcm9jZXNzICpwLA0KPiB1aW50NjRfdCByX2RlYnVnLA0KPiA+ICAgICAgICAgICAgICAqIFNF
VF9TSEFERVJfREVCVUdHRVIgY2xlYXJzIGFueSBzdGFsZSBwcm9jZXNzIGNvbnRleHQNCj4gZGF0
YQ0KPiA+ICAgICAgICAgICAgICAqIHNhdmVkIGluIE1FUy4NCj4gPiAgICAgICAgICAgICAgKi8N
Cj4gPiAtICAgICAgICAgICBpZiAocGRkLT5kZXYtPmtmZC0+c2hhcmVkX3Jlc291cmNlcy5lbmFi
bGVfbWVzKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAga2ZkX2RiZ19zZXRfbWVzX2RlYnVnX21v
ZGUocGRkLA0KPiAha2ZkX2RiZ19oYXNfY3dzcl93b3JrYXJvdW5kKHBkZC0+ZGV2KSk7DQo+ID4g
KyAgICAgICAgICAgaWYgKHBkZC0+ZGV2LT5rZmQtPnNoYXJlZF9yZXNvdXJjZXMuZW5hYmxlX21l
cykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgcmV0ID0ga2ZkX2RiZ19zZXRfbWVzX2RlYnVn
X21vZGUoDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHBkZCwgIWtmZF9kYmdfaGFz
X2N3c3Jfd29ya2Fyb3VuZChwZGQtDQo+ID5kZXYpKTsNCj4gPiArICAgICAgICAgICAgICAgICAg
IGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
ID4gKyAgICAgICAgICAgfQ0KPiA+ICAgICB9DQo+ID4NCj4gPiAgICAgcC0+cnVudGltZV9pbmZv
LnJ1bnRpbWVfc3RhdGUgPSBERUJVR19SVU5USU1FX1NUQVRFX0VOQUJMRUQ7DQo=
