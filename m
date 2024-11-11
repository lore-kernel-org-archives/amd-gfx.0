Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09301D12D59
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 00:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9811A10E3D9;
	Mon, 11 Nov 2024 00:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PK5iVApp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0163110E3D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 00:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDLRkDNXCrp347zOoZ3PXPl+zwbuFkRUrl5Da5HQImNwpKvcrmSxBCxy/NGRWmUXmJwIheH0cdVh/RZ0adh1DJUF/geY8n1dKE/O3lK3rSDCDb33fDbdx1fPijcP/Q6G6hMCtp9p03kDeQPNAS81UD6mWApUxst4I5MoWI7NYp4XIHSnBwIE0oTcsqNdzjYr6Ocs8S8BejAMtZJJy12XpR4xYtNAYneQVB1BHjZ6XN8HBmcNTz/cxSD373C+2TGM3JJMWRx5SuPsMu0o2NTQ3jyENZ5TuPuM/LLA2JQPUWU2SytwmEeyQWX1kKZwEwyNqFPaQMPbVF17N3AvF55BXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxMWaiYEyPwYqqKxfoazoLcmimwx6jz3j/THGQHN8lk=;
 b=zDncOsTkxByJFGPPxODafRC71oq6WTR7jgGTAMe7p9jQvMnLTsWoJbu6q8lNT3ZYHedAyva5KEUAA35VxkYdJ17EJRJS+Csv4lyS5Rx5953qRSXqVRQYhHzmsbfm8droGLcSQRUJSMNWAjoQf8OYIlf9ZvuAVjLSAGeQ4G62a+k73N+ahmJbsGvsKeV5WO1auw+eKJqNlXboVv5SoKmT5lnBA/736ZoBepNsRIk0MAz3KqMc3Xw0SQmMmrKSc+CthOIPU5uaEgXJc1nUiNX8qEeUke7wkfmj6GHBRBJAk2nzTJAl9tiB+WFLR1MnzDWgplWAa+KSE5WMIECO1zns0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxMWaiYEyPwYqqKxfoazoLcmimwx6jz3j/THGQHN8lk=;
 b=PK5iVAppfeLOp1rmwmA3E3je7E7S8TcXt7lJ+Sh2J1n26Ie3blqFoQLngkBebuLczn02P0eGIgTRg9GwNeC8Y3iAEH4wIr6QdmLfiW4HzqO8dcl1qVNkbe2k2Q99egOpW8ellYgcrsrmPdQux6chG7znCkxbf5XMVyGLvbnbsdA=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 11 Nov
 2024 00:12:15 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::962e:1ce3:e83f:8482]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::962e:1ce3:e83f:8482%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 00:12:15 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Zhao,
 Victor" <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
Thread-Topic: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
Thread-Index: AQHbMBZHMXJO9/1Wb0SUcDj9uFrCqbKqXF8AgAD3oQCAAGQwgIABdj0ggAALTuCAAAgzAIAALWGAgAPMGWA=
Date: Mon, 11 Nov 2024 00:12:15 +0000
Message-ID: <BL1PR12MB52697A3C9F6116D28F9E638984582@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
 <20241106063322.2443403-2-Victor.Zhao@amd.com>
 <CADnq5_NDDBsWrZvxQrCk8-qXfk-xBUBTM62SNawC__BANtpjOQ@mail.gmail.com>
 <6dc831bf-f7d8-4e9d-98c8-8204b330e466@amd.com>
 <7c8e9102-0d4f-405c-8749-1653118400f1@amd.com>
 <BL1PR12MB5269C32C36AEBAE40FBC131A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
 <BL1PR12MB52690F8688563810F74A261A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
 <7c0bc3a5-756d-4c60-b459-73a2ee910ce7@amd.com>
 <67758e2c-489e-46e9-be94-161aaa6da57b@gmail.com>
In-Reply-To: <67758e2c-489e-46e9-be94-161aaa6da57b@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fc5ddff1-9609-49ac-92a0-276ef6e88af4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-11T00:08:09Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5269:EE_|SJ2PR12MB8011:EE_
x-ms-office365-filtering-correlation-id: f6c4047e-22e0-48ee-3024-08dd01e57f57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K25vRWZoL1pDMGlsRUJ5enp5MC9aT0ExbmRSUkdHOGUxb0djRkhicDZXNjI1?=
 =?utf-8?B?bTJsS3lSeWhodm9YVVV1RDN0eVR4NC9MRGphWHVPN1VYR3gySG1yRjZTVGtL?=
 =?utf-8?B?RVFjZkRUZ2JDN3RkY2d4L0tNSTR5bFBQSjlHajBabFhqbmZ6SWpyNHBhVFd5?=
 =?utf-8?B?dEZGVlpGa2U2eFZxZFVBWVZEckJEZWRHdG5lWmMvdXg2dXJDcVBHMEl2MHln?=
 =?utf-8?B?MWRHRFFUUHBpbTdJZDdyclg5T3hGZ0dWVnQ3bCtiZitzRGU0UUVWVXZwcUdm?=
 =?utf-8?B?MGZKcmRpWURRTU5PYjhuY1I4TThUY2d4UjFkMkVOeHJqK0VoUnBRMUhmeElP?=
 =?utf-8?B?M000eUNoOFFTSmwxYmxUV2ZKWTlidEF0NWN0OUs3MVVaRTFGQ0JsNU5aM0tr?=
 =?utf-8?B?YXkybkptajdlSUordTcwWHhNbFhWQnJqY3dEMTQ5cXhrTnM0UEtLaEFHSFEr?=
 =?utf-8?B?U2dYQkdieWxsU1hQYmg3TXppRDA5TldkblNyYkdmT2FhVnUvLzJTVno1aS82?=
 =?utf-8?B?VnVqRXJEbTZEUUNxWlRTcGIyV21hZ2lRZ0tNNjVCZm5Oa25CelNJU3NoajhR?=
 =?utf-8?B?d25mYVI1TXBGaHBpWTF2SDJwT2E1OUVyYW91Z29PNWNoQmZvZnp2eWNWaUhV?=
 =?utf-8?B?enZqL1Y0bnJDS2phek1Kc0cvL3dHMmtSOGtrSDFVREREeUlyb2hacExjWUkz?=
 =?utf-8?B?RnVPWDRFRG10U3BaRThMcmRRN1cyS0VrMjN4dnVia0ZOaVpaMGtSQ1lpU2Yv?=
 =?utf-8?B?dkxpRHY1b3BLeWpVSTd3eDlyQ2hvVXp5b08zZFVBaHlGeWpKb2U0QVRweTR4?=
 =?utf-8?B?bTdCNWNKNjV0dEhZc0lFYmduOXEvNUZ6YjJtYnNnMi9OMHJsZ3lhenR0Y3NC?=
 =?utf-8?B?NTdsc2hkdHptSlhyZFJGcDNKaGRTd1NDUWx2WjRTL3RvVmtyTStadHZBOEd5?=
 =?utf-8?B?U0VYUW1tdHRCWjBDOUFPQk43ZXlKL1VjM0VKSXU5R1hjZnF5azZPRmF5M0Zh?=
 =?utf-8?B?VFI0aXd6c29YSVRjVG1DaTdZZStidzNhQkpYZG1JOGJvbldkbm1zMXJkK0RZ?=
 =?utf-8?B?cm8zKzZ6UXViNTd3a1RVNU1MN3luZFBxNi9sWjFrM1greC9JYU11aWwwMzlN?=
 =?utf-8?B?Z25TT1NoMVYzUmMrTUFXazl1dmhUSWVIUEdvY0xTQWpyQ3JqY0tKWWVibGhs?=
 =?utf-8?B?YXY1aTRWSTNNaVg4OTFGMStqYzVITFBSeGdiVENkNWZjbkZ2M1p3VXlFdW5k?=
 =?utf-8?B?Q002NmJuTk1mUjhreTdvcWZaemEvQkpRZUtFeG1qbGlOdUJaejlUM2FObHJi?=
 =?utf-8?B?dHA0a2IvRTJQNjVWRnNBWWIvQjNuOWRwZEppZGRCd3NmdEY4MTVhUHNGZTA2?=
 =?utf-8?B?S3B0UVNuakJwMHJmV1BPWUwvTkdkakFzTDhpVldzVDFUNWhoRXA4SkxORkIx?=
 =?utf-8?B?RUNOaW9ZM1E1cEkwMGVyZkxVMklQRnB4WWJKN1BLdmpkRlBvMi94emhjbFNV?=
 =?utf-8?B?TmNOQURRTlh2Q2tWY2h5VDdaNGhoOCtFTTNXUG5uaFlZTngzTS9Jb1Jud05E?=
 =?utf-8?B?a09ieE55V1Q4akFVSGxPbGd2bTRiL2pyZ3RvTGxwTXV6R1hNakVDc3h3M01s?=
 =?utf-8?B?aXY5ZHExRlI3c1hwMkZHT3FXdEx1c2V1QUtSOGRkME5adFYzbG5pTDdLL2pJ?=
 =?utf-8?B?WWNReHdzdHJERUdTdkhaVjZQZjZRRXBrT0Z5cDhzSkhwRnQxYUxrRUxnVVdz?=
 =?utf-8?B?M2lVQVU1UmtrZlNpYWIvZG0wcGkzMFp6cGF6SjN5bzNOSSsyUnpOSFZXRWdy?=
 =?utf-8?Q?A/5E2uObbsn0xdGIZf0cCP7FsnVDk8I2O/mIs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHp0TEZLR1l1RHE5Y0hYVWpuTURDZGRkdzhJdGprb0tPYkJoTGc0aDZTMlVE?=
 =?utf-8?B?d3d2aWhIemR3S3BrL2grdDVKZXBwVXN6QjFRVDRwUno4Q1VpSkRrR0NHOWxr?=
 =?utf-8?B?VWtxN1NZVFFlUHRXSW1QVklxMnF2ZU4zZDBRdEU4UjRyOFFkNk5JM3BGWmJZ?=
 =?utf-8?B?SFpCVkp6VGFSZ1VvaHZXTmprWjI1Rzc3VFd2OFZxbWE0clpRSEQrcENoV0tN?=
 =?utf-8?B?TXFQSFhTQWtPTmtyRmUvZGsxaHN0dC9aVDhDenhiUXRJRFBRNlAxcTVtK003?=
 =?utf-8?B?eGdXK2o3MXdSeElXbm5TbFFaM1BDaDlMOFZvVjVZdENvS1JXWUFjb2NoMWRw?=
 =?utf-8?B?a0RhM25OVEZIUmNWTStzM2lLbmoxY0tScW1IUjB6WWxoWG5Lb1lzUE5tYnNM?=
 =?utf-8?B?Q1crSEd1V0wyNjdXdVBXMEVkRmY3ZlBaS3F1SFNobWJMcFhvMnIzS3Q3UGYw?=
 =?utf-8?B?dmNpMHlPWXJuaExzQ04yUEdrSmZRWFpCaC9lY0c2RVVwV1VDRHBwWm1zMkdu?=
 =?utf-8?B?cHFvV2QzUWF0ZEtxV0RGSlNZMTh3SWJPR2pYb3JVQjVVYlUzSFdBNDRrRG8r?=
 =?utf-8?B?Z2F6N084anYweUlidWRNU2t1c1EzemgyQnFqcHM0Rlg0UGE4Uk1aRlZxSUdV?=
 =?utf-8?B?QXprZzZtd3JDUkVnRThnLzJVNUhEVnNva2FRWE84VWdZMG5TbzhZWjBGSkQz?=
 =?utf-8?B?ZE1lQWhQV3NQbTU0Y0kwMmV4NUQ4TnRpbVh5TUUyb2MrOXR4dXBQYTNqRTFo?=
 =?utf-8?B?dnlRVUIrNkRzVW1TcUpDVUYwWTNBQ3ZHdWw2bFUyKzlhdVpmWnV4ZU4rWG1M?=
 =?utf-8?B?UWV2Sm5nR2k2M2JRVFhscmRnbWFES2pzRGVmc0hkb1g1MVNQalpOaERGZGtj?=
 =?utf-8?B?REJlQ3E5cG9pL2pCQnIzaXYrbElYdHdVemQ3S2NmVG1IblVOL1hSYXB1YVlO?=
 =?utf-8?B?OUVySWtrUVNyeXBHVWdmOS9IVzlQN1lGejJncWJrajZaK3Nudm84Z09mY040?=
 =?utf-8?B?YjNVTnVQUnZFMEdrbEpBdWxINHNPVkxJT0M0M21TVjBQNFB6M1lNYTlPck93?=
 =?utf-8?B?U09nMHBJdXFKNkR2ZHZ5ZDZwcnFhWG5yK1NieGtwbGgvamVpRWJmR2pHTmZU?=
 =?utf-8?B?TXB4Wm5qVEFOM2ExUXJwS21nbENjSGJtR2FWTmh1V0FCRnpiRnRleFJVUDZD?=
 =?utf-8?B?TC80RjkvdGlMaHR2SzE0Y2ozc3BhZWNWUXdtTVdUNmFqMWE3alJ2M2M4bTZn?=
 =?utf-8?B?UmFLMndXN2tWaTcrb0ZDMFF6WU5LU2pqSWdWeDNIR3NUOFRUYzBCNHR4ZWJN?=
 =?utf-8?B?ZHVmSzZYeU1XUWRLcU5hSWMrRDlLTzVGT2pHcnRvTlpUYk9QVDZ2NzMrdkY0?=
 =?utf-8?B?L1VPWExDWFdzakRhVW9NUUUvRFdGVDZBeDZudGNDM2NUV0lUOG8zU0psTkU0?=
 =?utf-8?B?K05JVXdmeTVqeDRzbHhwaXkyRnkwN3lMMmRNcXp1dDFQQVBGa2hFdmJLS2gv?=
 =?utf-8?B?YmsrajRGMWI1cUtsZTZUaXZ4TWgrZUhORVBwMzF5QXRqOWRrc3RmSURjdWtS?=
 =?utf-8?B?NmR2WkpQRm9GeWxubi9oQ0c4L0lEZVFRdkhqSi9HUGxGYjhPc293RjFzakE3?=
 =?utf-8?B?S3ZKZ3RVcDFEV0xsQmhITGpKeEdRdSt3TWFZenN3Mm5qUDcyZUJZRUF0Q0Vx?=
 =?utf-8?B?ZzBMWlNHVEZBQ0ZMd2tiZVZHTFZNZkRPMHg0YldNNk9EdWFXM3JPTDB6M1BS?=
 =?utf-8?B?UlljVy9VMkQ1bkVkZS9KUmJpeWVkUjZ2bGJWdnRNcGpBT2VQQ1RGSktPYnJP?=
 =?utf-8?B?WHpYUTF3SVMwNkhyd0FrbjRnem43RVBHWlBaYmhrWExtSHdwRElSaEphaW1C?=
 =?utf-8?B?UzdCUzNQQ2NCRXM2M0NDNTd4Z1RwZmwzaDdjdXFyUjJLN2g3R2pUclI1dHps?=
 =?utf-8?B?aTB2dzJWSTljYUF5b2tRZFNmejRnUGF0Lzd3bFpXQzR6Y1hpR0FMc085QlNY?=
 =?utf-8?B?UEZwbjk4Zm0xUXBGWVB3NHUvOTRWY1dsckVObXZuTkxhTkY4THU0bDdGOFNG?=
 =?utf-8?B?V2xXdE04WVlyRXo2aFJIZWtZNi9Qb1lGeW1kbmZSOTdvdDZRNFlTcnBsMUF5?=
 =?utf-8?Q?KW+8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c4047e-22e0-48ee-3024-08dd01e57f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 00:12:15.2007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xnvimoVZQHaRLVk3565vhrAQBThtbp+p7jGtQ1Y0Ki2UnCUol69Bsz9wRzb06sS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011
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
Cg0KQ2hyaXN0aWFuDQoNCldoYXQgZG8geW91IG1lYW4gIldoYXQgaGFwcGVucyBpbnN0ZWFkIGlz
IHRoYXQgdGhlIGJyb2tlbiBLVk0gcGF0Y2ggYXBwbGllcyB0aGUgZ3Vlc3QgY2FjaGluZyBhdHRy
aWJ1dGVzIHRvIHRoZSByaW5nIGJ1ZmZlciBpbnN0ZWFkIG9mIHRoZSBob3N0IG9uZXMuIg0KDQpG
cm9tIHdoYXQgSSBoZWFyZCB0aGVyZSB3YXMgYSBLVk0gcGF0Y2ggdG8gY29ycmVjdCB0aGUgbWFw
cGluZyBiZWhhdmlvciAtLSBwcmV2aW91c2x5IHRoZSBtYXBwaW5nIGlzIGZvcmNlZCB0byBjYWNo
ZSBtb2RlIGV2ZW4gZ3Vlc3QgS01EIG1hcHMgdGhlIGJ1ZmZlciB3aXRoICJXQyIuDQpCdXQgYWZ0
ZXIgdGhlIHBhdGNoIHRoZSBidWZmZXIgd2lsbCBiZSByZWFsbHkgIldDIiBpZiBndWVzdCBtYXBz
IGl0IHdpdGggV0MiLi4uIGFuZCB0aGlzIHJldmVhbHMgdGhlIGJ1ZyBhbmQgaGl0IG91ciBpc3N1
ZS4NCg0KQ2FuIHlvdSBleHBsYWluIHdoeSBVU1dDIGZvciByaW5nIGJ1ZmZlciBpcyBzYWZlLCB3
aHkgaXQgd2lsbCBub3QgaGl0IGNvaGVyZW5jZSBpc3N1ZSwgd2h5IHlvdSBkb24ndCBtYWtlIGFs
bCByaW5nIGJ1ZmZlcnMgd2l0aCBVU1dDIGV2ZW4gZm9yIGFtZGdwdSBzaWRlIGlmIHlvdSByZWFs
bHkgYmVsaWV2ZSBVU1dDIGlzIGlubm9jZW50IC4uLg0KDQpUaGFua3MNCg0KTW9uayBMaXUgfCBD
bG91ZCBHUFUgJiBWaXJ0dWFsaXphdGlvbiB8IEFNRA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFp
bC5jb20+DQpTZW50OiBGcmlkYXksIE5vdmVtYmVyIDgsIDIwMjQgMTA6MDkgUE0NClRvOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29t
PjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IEFsZXggRGV1
Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPjsgWmhhbywgVmljdG9yIDxWaWN0b3IuWmhhb0Bh
bWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBZYW5nLCBQaGlsaXAg
PFBoaWxpcC5ZYW5nQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFt
ZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZGtmZDogdXNlIGNhY2hlIEdU
VCBidWZmZXIgZm9yIFBRIGFuZCB3YiBwb29sDQoNCkFtIDA4LjExLjI0IHVtIDEyOjI2IHNjaHJp
ZWIgTGF6YXIsIExpam86DQo+IE9uIDExLzgvMjAyNCA0OjI5IFBNLCBMaXUsIE1vbmsgd3JvdGU6
DQo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBP
bmx5XQ0KPj4NCj4+IFRvIGJlIGNsZWFyIGZvciB0aGUgbWIoKSBhcHByb2FjaDogRXZlbiBpZiB3
ZSBpbnNlcnQgbWIoKSBpbiBwcmlvciB0byBhbWRncHVfcmluZ19zZXRfd3B0cihyaW5nKSwgR1BV
IG1pZ2h0IHN0aWxsIGZldGNoIHN0YWxsZWQgZGF0YSBmcm9tIFBRIGR1ZSB0byBVU1dDIGF0dHJp
YnV0ZXMuDQo+Pg0KPiBJbnNlcnRpbmcgYW4gbWIoKSBkb2Vzbid0IGNhdXNlIFdDIGJ1ZmZlciBm
bHVzaCBpcyBhIHdyb25nIGFzc3VtcHRpb24uDQo+DQo+IEFsbCBwcmlvciBsb2Fkcy9zdG9yZXMg
YXJlIHN1cHBvc2VkIHRvIGJlIGdsb2JhbGx5IHZpc2libGUuIEhlbmNlIG1iKCkNCj4gZm9sbG93
ZWQgYnkgYSB3cml0ZSBwb2ludGVyIHVwZGF0ZSBhbHNvIHNob3VsZCBndWFyYW50ZWUgdGhlIHNh
bWUNCj4gKEZyb20gQXJjaCBtYW51YWwpLg0KPg0KPiAgICAgICBUaGUgTUZFTkNFIGluc3RydWN0
aW9uIGVzdGFibGlzaGVzIGEgbWVtb3J5IGZlbmNlIGZvciBib3RoIGxvYWRzIGFuZA0KPiBzdG9y
ZXMuIFRoZSBwcm9jZXNzb3IgZW5zdXJlcyB0aGF0IG5vIGxvYWQgb3Igc3RvcmUgYWZ0ZXIgTUZF
TkNFIHdpbGwNCj4gYmVjb21lIGdsb2JhbGx5IHZpc2libGUgKnVudGlsIGFsbCBsb2FkcyBhbmQg
c3RvcmVzIGJlZm9yZSBNRkVOQ0UgYXJlDQo+IGdsb2JhbGx5IHZpc2libGUuKg0KPg0KPg0KPiBJ
Z25vcmluZyB0aGUgYW1kZ3B1IGRyaXZlciBwYXJ0IG9mIGl0IC0gaWYgbWIoKSBpcyBub3Qgd29y
a2luZyBhcw0KPiBleHBlY3RlZCBhcyB5b3UgY2xhaW0gdGhhdCBtZWFucyBzb21ldGhpbmcgaXMg
d3Jvbmcgd2l0aCB0aGUgc3lzdGVtLg0KPg0KPiBVU1dDIG9yIFdCIGZvciByaW5nIHR5cGUgbWF5
IHN0aWxsIGJlIGEgc2VwYXJhdGUgZGlzY3Vzc2lvbi4NCg0KWWVhaCBjb21wbGV0ZWx5IGFncmVl
LiBBZGRpdGlvbmFsIHRvIHRoYXQgdGhlIGNvbWJpbmUgYmVoYXZpb3IgYmV0d2VlbiBVU1dDIGFu
ZCBXQiBpcyB0aGUgc2FtZSwgc28gdGhlIGFyZ3VtZW50YXRpb24gaXMgY2xlYXJseSBub3QgY29y
cmVjdC4NCg0KV2hhdCBoYXBwZW5zIGluc3RlYWQgaXMgdGhhdCB0aGUgYnJva2VuIEtWTSBwYXRj
aCBhcHBsaWVzIHRoZSBndWVzdCBjYWNoaW5nIGF0dHJpYnV0ZXMgdG8gdGhlIHJpbmcgYnVmZmVy
IGluc3RlYWQgb2YgdGhlIGhvc3Qgb25lcy4NCg0KTWFraW5nIGFuIGVkdWNhdGVkIGd1ZXNzIEkg
d291bGQgc2F5IHRoYXQgdGhlIHJvb3Qgb2YgdGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgZ3Vlc3Qg
aXMgdXNpbmcgc29tZSBpbmNvcnJlY3QgY2FjaGluZyBhdHRyaWJ1dGVzIGZvciBzb21lIHJlYXNv
biwgd2hpY2ggaXMgZXhhY3RseSB0aGUgc2FtZSByZWFzb24gd2h5IHRoYXQgS1ZNIHBhdGNoIHdh
cyByZXZlcnQgdXBzdHJlYW0gYXMgd2VsbC4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPg0K
PiBUaGFua3MsDQo+IExpam8NCj4NCj4+IFRoZSBpc3N1ZSBoZXJlIGlzIG5vdCB0aGUgcmUtb3Jk
ZXJpbmcgYnV0IHRoZSBzdGFsbGVkIFBRLg0KPj4NCj4+IE1vbmsgTGl1IHwgQ2xvdWQgR1BVICYg
VmlydHVhbGl6YXRpb24gfCBBTUQNCj4+DQo+Pg0KPj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+PiBGcm9tOiBMaXUsIE1vbmsNCj4+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgOCwg
MjAyNCA2OjIyIFBNDQo+PiBUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT47IExhemFyLCBMaWpvDQo+PiA8TGlqby5MYXphckBhbWQuY29tPjsgQWxleCBEZXVj
aGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+OyBaaGFvLA0KPj4gVmljdG9yIDxWaWN0b3IuWmhh
b0BhbWQuY29tPg0KPj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBZYW5nLCBQ
aGlsaXANCj4+IDxQaGlsaXAuWWFuZ0BhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPg0KPj4gU3ViamVjdDogUkU6IFtQQVRDSCAyLzJdIGRybS9hbWRrZmQ6
IHVzZSBjYWNoZSBHVFQgYnVmZmVyIGZvciBQUSBhbmQNCj4+IHdiIHBvb2wNCj4+DQo+PiBDaHJp
c3RpYW4vTGlqbw0KPj4NCj4+IFdlIHZlcmlmaWVkIGFsbCBhcHByb2FjaGVzLCBhbmQgd2Uga25v
dyB3aGF0IHdvcmtzIGFuZCBub3Qgd29ya3MsIG9idmlvdXNseSB0aGUgbWIoKSBkb2Vzbid0IHdv
cmsuDQo+Pg0KPj4gVGhlIHdheSBvZiBtYigpIGJldHdlZW4gc2V0IHdwdHJfcG9sbGluZyBhbmQg
a2lja2luZyBvZmYgZG9vcmJlbGwgaXMgdGhlb3JldGljYWxseSBjb3JyZWN0LCBhbmQgSSdtIG5v
dCBvYmplY3QgdG8gZG8gc28uLi4gYnV0IHRoaXMgd29uJ3QgcmVzb2x2ZSB0aGUgaXNzdWUgd2Ug
aGl0Lg0KPj4gRmlyc3Qgb2YgYWxsLCBVU1dDIHdpbGwgaGF2ZSBzb21lIGNoYW5jZSB0aGF0IHRo
ZSBkYXRhIGlzIHN0aWxsIGluIENQVSdzIFdDIHN0b3JhZ2UgcGxhY2UgYW5kIG5vdCBmbHVzaGVk
IHRvIHRoZSBtZW1vcnkgYW5kIGV2ZW4gd2l0aCBNQigpIGdldCByaWQgb2YgcmUtb3JkZXJpbmcg
R1BVIG1pZ2h0IHN0aWxsIGhhdmUgYSBjaGFuY2UgdG8gcmVhZCBzdGFsbGVkIGRhdGEgZnJvbSBy
aW5nIGJ1ZmZlciBhcyBsb25nIGFzIGl0IGlzIG1hcHBlZCBVU1dDLg0KPj4NCj4+IFRoaXMgaXMg
d2h5IG9ubHkgY2FjaGUgcGx1cyBzbm9vcCBtZW1vcnkgY2FuIGdldCByaWQgb2YgaW5jb25zaXN0
ZW5jZSBpc3N1ZXMuDQo+Pg0KPj4gQmVzaWRlcywgZG8geW91IGtub3cgd2hhdCdzIHRoZSByYXRp
b25hbCB0byBrZWVwIGFsbCBHRlggS0NRIGNhY2hlK3Nub29wIGJ1dCBvbmx5IEhJUS9LSVEgZnJv
bSBLRkQgY29uZmlndXJlZCB0byBVU1dDID8NCj4+DQo+PiBGb3IgcGVyZm9ybWFuY2UgY29uY2Vy
biB0aGF0IGxvb2tzIHRvIG1lIGFsd2F5cyB0aGUgc2Vjb25kIHByaW9yaXR5IGNvbXBhcmVkIHRv
ICJjb3JyZWN0IiBlc3BlY2lhbGx5IHVuZGVyIHRoZSBjYXNlIEhJUSBjb250cmlidXRlcyB2ZXJ5
IGxpdHRsZSB0byBST0NNIHBlcmZvcm1hbmNlIHdoZW4gc3dpdGNoaW5nIHRvIGNhY2hlIG1hcHBp
bmcuDQo+Pg0KPj4NCj4+IE1vbmsgTGl1IHwgQ2xvdWQgR1BVICYgVmlydHVhbGl6YXRpb24gfCBB
TUQNCj4+DQo+Pg0KPj4NCj4+DQo+Pg0KPj4NCj4+DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT4NCj4+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA3LCAyMDI0IDc6NTcgUE0NCj4+IFRvOiBM
YXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgQWxleCBEZXVjaGVyDQo+PiA8YWxleGRl
dWNoZXJAZ21haWwuY29tPjsgWmhhbywgVmljdG9yIDxWaWN0b3IuWmhhb0BhbWQuY29tPg0KPj4g
Q2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMaXUsIE1vbmsgPE1vbmsuTGl1QGFt
ZC5jb20+Ow0KPj4gWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFuZ0BhbWQuY29tPjsgS3VlaGxpbmcs
IEZlbGl4DQo+PiA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMi8yXSBkcm0vYW1ka2ZkOiB1c2UgY2FjaGUgR1RUIGJ1ZmZlciBmb3IgUFEgYW5kDQo+PiB3
YiBwb29sDQo+Pg0KPj4gQW0gMDcuMTEuMjQgdW0gMDY6NTggc2NocmllYiBMYXphciwgTGlqbzoN
Cj4+PiBPbiAxMS82LzIwMjQgODo0MiBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPj4+PiBPbiBX
ZWQsIE5vdiA2LCAyMDI0IGF0IDE6NDnigK9BTSBWaWN0b3IgWmhhbyA8VmljdG9yLlpoYW9AYW1k
LmNvbT4gd3JvdGU6DQo+Pj4+PiBGcm9tOiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4NCj4+
Pj4+DQo+Pj4+PiBBcyBjYWNoZSBHVFQgYnVmZmVyIGlzIHNub29wZWQsIHRoaXMgd2F5IHRoZSBj
b2hlcmVuY2UgYmV0d2VlbiBDUFUNCj4+Pj4+IHdyaXRlIGFuZCBHUFUgZmV0Y2ggaXMgZ3VhcmFu
dGVlZCwgYnV0IG9yaWdpbmFsIGNvZGUgdXNlcyBXQyArDQo+Pj4+PiB1bnNub29wZWQgZm9yIEhJ
USBQUShyaW5nIGJ1ZmZlcikgd2hpY2ggaW50cm9kdWNlcyBjb2hlcmVuY3kgaXNzdWVzOg0KPj4+
Pj4gTUVDIGZldGNoZXMgYSBzdGFsbCBkYXRhIGZyb20gUFEgYW5kIGxlYWRzIHRvIE1FQyBoYW5n
Lg0KPj4+PiBDYW4geW91IGVsYWJvcmF0ZSBvbiB0aGlzPyAgSSBjYW4gc2VlIENQVSByZWFkcyBi
ZWluZyBzbG93ZXINCj4+Pj4gYmVjYXVzZSB0aGUgbWVtb3J5IGlzIHVuY2FjaGVkLCBidXQgdGhl
IHJpbmcgYnVmZmVyIGlzIG1vc3RseSB3cml0ZXMgYW55d2F5Lg0KPj4+PiBJSVJDLCB0aGUgZHJp
dmVyIHVzZXMgVVNXQyBmb3IgbW9zdCBpZiBub3QgYWxsIG9mIHRoZSBvdGhlciByaW5nDQo+Pj4+
IGJ1ZmZlcnMgbWFuYWdlZCBieSB0aGUga2VybmVsLiAgV2h5IGFyZW4ndCB0aG9zZSBhIHByb2Js
ZW0/DQo+Pj4gV2UgaGF2ZSB0aGlzIG9uIG90aGVyIHJpbmdzIC0NCj4+PiAgICAgICAgICAgbWIo
KTsNCj4+PiAgICAgICAgICAgYW1kZ3B1X3Jpbmdfc2V0X3dwdHIocmluZyk7DQo+Pj4NCj4+PiBJ
IHRoaW5rIHRoZSBzb2x1dGlvbiBzaG91bGQgYmUgdG8gdXNlIGJhcnJpZXIgYmVmb3JlIHdyaXRl
IHBvaW50ZXINCj4+PiB1cGRhdGVzIHJhdGhlciB0aGFuIHJlbHlpbmcgb24gUENJZSBzbm9vcGlu
Zy4NCj4+IFllYWgsIGNvbXBsZXRlbHkgYWdyZWUgYXMgd2VsbC4gVGhlIGJhcnJpZXIgYWxzbyB0
YWtlcyBjYXJlIG9mIHByZXZlbnRpbmcgdGhlIGNvbXBpbGVyIGZyb20gcmUtb3JkZXJpbmcgd3Jp
dGVzLg0KPj4NCj4+IFJlZ2FyZHMsDQo+PiBDaHJpc3RpYW4uDQo+Pg0KPj4+IFRoYW5rcywNCj4+
PiBMaWpvDQo+Pj4NCj4+Pj4gQWxleA0KPj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogTW9uayBM
aXUgPE1vbmsuTGl1QGFtZC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyB8IDIgKy0NCj4+Pj4+ICAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMNCj4+Pj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+Pj4+PiBpbmRleCAxZjFkNzlhYzVl
NmMuLmZiMDg3YTBmZjViYyAxMDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9kZXZpY2UuYw0KPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2RldmljZS5jDQo+Pj4+PiBAQCAtNzc5LDcgKzc3OSw3IEBAIGJvb2wga2dkMmtmZF9k
ZXZpY2VfaW5pdChzdHJ1Y3Qga2ZkX2RldiAqa2ZkLA0KPj4+Pj4gICAgICAgICAgIGlmIChhbWRn
cHVfYW1ka2ZkX2FsbG9jX2d0dF9tZW0oDQo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
IGtmZC0+YWRldiwgc2l6ZSwgJmtmZC0+Z3R0X21lbSwNCj4+Pj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJmtmZC0+Z3R0X3N0YXJ0X2dwdV9hZGRyLCAma2ZkLT5ndHRfc3RhcnRfY3B1X3B0
ciwNCj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGZhbHNlLCB0cnVlKSkgew0KPj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgZmFsc2UsIGZhbHNlKSkgew0KPj4+Pj4gICAgICAgICAg
ICAgICAgICAgZGV2X2VycihrZmRfZGV2aWNlLCAiQ291bGQgbm90IGFsbG9jYXRlICVkIGJ5dGVz
XG4iLCBzaXplKTsNCj4+Pj4+ICAgICAgICAgICAgICAgICAgIGdvdG8gYWxsb2NfZ3R0X21lbV9m
YWlsdXJlOw0KPj4+Pj4gICAgICAgICAgIH0NCj4+Pj4+IC0tDQo+Pj4+PiAyLjM0LjENCj4+Pj4+
DQoNCg==
