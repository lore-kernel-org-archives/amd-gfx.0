Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D834BD33990
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 15:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541FD10E4EB;
	Mon, 28 Oct 2024 15:16:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BFCZpUbP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B18D10E4E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 15:16:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=df/INEN3bMBMzMEfmL2oJqGSsQhcFEqnmhkJ/0TtCTOog1r9qJ17g1nIvKPrFW3l6eM9IbRAvNQbCxFmjwOmO0CJ1c85q/6Sk9l5HrDP8agS+2YfmpTsDyDzuYoOtx39sgm6ucXLtYp5iZj0TIZjVFG0cfY+dxyKYd5ZIL6ujxYwURStB0C1MdstJUCVDDLxHgV/tk7CXUoQ7JD43YtvqE/CcOEhHkfcjYHLURA4Hk9PvLl1o2LL07hZHSoXhZZrkszEslYjZo5/WQpG3PrpSSU946fAaytd3jg/xOX5y5yK0/VKGR7Qrb+dU4Waz7iLv5pt+A0l4IbhpfXh9iYSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP/KldibR6Elw/efMAfMVedC2ciPLAlW/0bml//JMsU=;
 b=j3s4bmEKbh28OaSH89dCkJBOSb1raEmIsMY/Zbmv0vAFCRFsGB8YW0r+Qk4HoHCe4+xT08kOOtVuTU7OeKcmRTfHSDYexEUnnCxkyLtN6te9biaacGVXKUNuCaoWjRc5VqTkk51Uw6RzLBMhF6cX2+EN7opIHrkKepZzy2jawzf/eSPvxl8TQaCCD5rx4o89+wco5lT7DRHgfUPe9B7OAo/lIPsf9rMmg6dfWAtmiJosa62WcOO/FEFW6EKgZmV/0+jZ7/qN+Vw+qZ4tWtsIyTge1AG7uwBMgdoeMiflTUDT74dDTpZsb0WsV5B6sEfIca+WK0o5/dmi5acI5nDunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP/KldibR6Elw/efMAfMVedC2ciPLAlW/0bml//JMsU=;
 b=BFCZpUbPl09+xOWBPvOw8E2Jwgz8XAo+4M542XAUz830zIlMQY90mhE4VPKi+1oqynnUF+ZDU2z2HpOO7s5xFJT0iF6BGLZSgLYZ+05/p/VsFgNv7kYOby3KsHHOp6AkQTotCef/57aOSiiVhYyD1UFtmRync9oby3EA+eWx91A=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 15:16:54 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%3]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 15:16:53 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add ring reset messages
Thread-Topic: [PATCH] drm/amdgpu: add ring reset messages
Thread-Index: AQHbHy5P4cTz5JWmoEa0ysGJ3il6BbKMq9mAgA+kyQCAAAmsAA==
Date: Mon, 28 Oct 2024 15:16:53 +0000
Message-ID: <BL1PR12MB5898FEBF9E7B41767FD5F5FD854A2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20241015181541.2457526-1-alexander.deucher@amd.com>
 <CADnq5_NHmJpZLbbrEsN75gkLOctFtS6nyNBHfgM-0=EpdyKFcA@mail.gmail.com>
 <CADnq5_MAExjgh8xYzfjSPxFUYV-17Tukh6DgH41ba9t6Pe8EoA@mail.gmail.com>
In-Reply-To: <CADnq5_MAExjgh8xYzfjSPxFUYV-17Tukh6DgH41ba9t6Pe8EoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=47bdc945-3264-4971-9f17-3209032e6822;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-28T15:16:29Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|MN2PR12MB4286:EE_
x-ms-office365-filtering-correlation-id: 8d151a85-54fd-41fe-42bc-08dcf7638df4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eUIyUnhnczlNdTR6byttRGNwL1JOSko5VmNmSjQvZTFOZWc4Ulo5T1h2T2NP?=
 =?utf-8?B?dUF3SGFuSnBpTXJ0aXUvMmtUdmUwTThZSFB3cnAyZ2FPa3hzeVRZMkVXZjdt?=
 =?utf-8?B?OW5JakdsRUJaRmlHcWtUY2gwMWxqMlo5c3NuL0M4d0Qybi9wVEJDMVZVaGpD?=
 =?utf-8?B?Z2JvT1NrQU41aEh5VTYyRUdSMytRcllZZ3lqYjhRRkRlaWtnQm5hNHpHbHdO?=
 =?utf-8?B?TC9JRUVKN0gwRzFoMzAreWpkNFZ6MTZrUFJnaG1vOEJxRWU4aXRRNDJraXdr?=
 =?utf-8?B?YmVUTjhqYXRONUdYYU9tNTNJOFJOZjNSeXlGYXE5MmtqM0NsVUdvYmNkWjEy?=
 =?utf-8?B?eENSMXVWYVMxZ011Qy85V0VyQmJsTmRVOEFVWEZKYnE3UVk0bVVNeStiQTNu?=
 =?utf-8?B?OStxU1lLVmpzOFV0dG1rVUFkZEEzcEh0NkV4QVhkR0pINndYTkNGZzZWVGNi?=
 =?utf-8?B?c25tcW9BcEhnZ3JYQUh1VVgwYWRxUGNVUGZNODA0cmgxVVZMM1VDVXBGbnZl?=
 =?utf-8?B?NllWNDNwTzZZVUZYTVhvNkMyZzU4dU16NHRKNWRHNklrL3BrTnJ1bzVVSUQy?=
 =?utf-8?B?aGlMS1ZaYk1qczFiYjR5WEJCUTJzemdJekRaOGhHV3JvQzRhVEFJV1hCZ0Vu?=
 =?utf-8?B?VWNUMFNQZjAwdkExYVh4R2dDbGQ4RnBVSElNSnJPdzJUTmNzNVdsTC9oTWZB?=
 =?utf-8?B?T0NpRzBKUTUrZGNzUjl4MnhuSEY2YkQwK1VESmgvaENCVkJSa2FjTXNRRjJB?=
 =?utf-8?B?bTFaTXJGaWJYclYzanZPdEREYnBub1laWXNTNTYzQTBFZS9ybFN4Y2J4bDYw?=
 =?utf-8?B?NU1IeVVCODFIei9abEY5alE2b21FSW5CSFVIdmNNOUpMbTJiZWQ0SkJVdmxv?=
 =?utf-8?B?RGxkQTNXTUhKSW5Gc1NLdVFYZUhmL2R2eGJkdUVQQThtM3RLc2RxbHgrOUk2?=
 =?utf-8?B?V2dBWTJoZTZXenpWOWxWVE9qU3JwdDR3MmZrT3R4T2VubWVqRndKR2pFRXJz?=
 =?utf-8?B?eCtGdzZYdGJMWE8zNkFURlAvaGQyOGhYRm5JZWtoSWhDeSs0R05IbGFFYmdi?=
 =?utf-8?B?UzFySUVJakZuTW9jMzV0T2hmaTFEVTNpZDQwMW1xU3I1aklFR1NEdGVWWndX?=
 =?utf-8?B?WldxR1VHTVBFQXhjS0E3WWc2N0lGeUJpWjZ0cFFVRVhnN3N1eXJLWkpJYnhs?=
 =?utf-8?B?aGRiU0xqbmg5cE5DcnNlMkJ0dlRWKzVOeFFSbFBtTmI3MU5DMUVMMlU4MkNH?=
 =?utf-8?B?UEF6UVdIMHNzdzBvd0JpOGlPODkxWjdYdjhjRzZRaW54QU1vOVJ3OFlZcW9P?=
 =?utf-8?B?bHdlRytXQ3Z1YjBEdDZHUGxUZ0RmYnhTanVDOTAySzAvTXlPcGNocE9LMlpx?=
 =?utf-8?B?bERJbFlOV3JuUTJVNHBNTk9lNzFOWm10a1dLelV0NTJTWjNRZkJkUFk0Yy92?=
 =?utf-8?B?VE9OeDh1U1dKMUVFVGRHR2FVcGFaM0xIWllWbXFnUGIyclZFZ2drYS9VZURG?=
 =?utf-8?B?Q2JJemVEUDJtTWJCU2R3d0l2TUdMbm1KcExaVXhzdWpCa1QyRTdEeXZ1K05v?=
 =?utf-8?B?TEd3V2p1eE1ENm84Z1RydEdZY29rRThxQlJ1QWNvNzByaXpvd25iMC8vdG0y?=
 =?utf-8?B?K2hZazBrdXd2bWRiUzhmSWgwZXplMDFDV0xzVER6VlZJT3RPcHBYcXRjemFL?=
 =?utf-8?B?a2s5TFZLVjRDTDJXd1U1Z0ZoS0N1WXVnYVNMNlFTOG1yb1NrTjBsa2thYjFD?=
 =?utf-8?B?Zm1lcU1QbE5vMFpNWDUwQURzbjFaSThSdmxCWmFIQWF2UFp0L3V6ZFdKL2J2?=
 =?utf-8?Q?GJpHq1dcDxNNUmoLAhDh998AHjQlo0K3U4rm8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGVRWEtOK1ZuUHVwbkpNZ1JvYU1wNkxQdGxISEhLSzlPcU5tbXU4T0RKbjVy?=
 =?utf-8?B?NEw1N2VlOFhHVjZYWHpPOW5UL3BGN3J5ZWdqWlBpKzZXTkMxTmNtN0dDMFJN?=
 =?utf-8?B?bk9EUUJ0VCtESDNZdlhsWTVGSm44dExHYUM3SVcxM25DR0t3a2wxK0gvZG0z?=
 =?utf-8?B?MEFid3dlSUhaOWFOcGVKVmUvR3Uyc1h5Y3hEeVhUL2hPRmtxbFA0VEtsSm84?=
 =?utf-8?B?L3gzbVl0emhsZi81SXdwdHZIZ09OdDRqRHIvRVBxMC9pdVFsK3ZpV2h1bHlZ?=
 =?utf-8?B?VTMreFFsdDZQN1I3L2tzVFZoUng0YjMvZCtJdFF3cGZQNTJBYUZjLzlRajUv?=
 =?utf-8?B?V1U5YTNIL0c1UHB0YzBFOWFWUkhobWJZdjh6SUJscXY2alRnWHZRR3FsY3Jj?=
 =?utf-8?B?OUV2bk1CeWxZZjJKZUtveG9FWEkwVGtzSWVUVmMyQ29tQ1RDUytvUXhOZVFy?=
 =?utf-8?B?a1ZnaWlMUUhWMXAwbm5MQ2pkVDZOQkNTejVkMUNEWUFPZldpUlc3Zm1oSW1v?=
 =?utf-8?B?UnpTSEpyRGxTV0tGUlAxY2tlRWo4ZFlnSjFMa0pTZHJUQnV6U01sNHJWb3ZL?=
 =?utf-8?B?b09Yd1FoU1BlT0oxUTJuYmxYNU5GdVY1YWZ3TDg5b0RCeWV0U2JHSFhIdm9a?=
 =?utf-8?B?M1JISnNjbld3QUpqeWhrektPOUVIbFN5M1gvclZ1cXp6azVyYmMvc0RGWjdP?=
 =?utf-8?B?MmlhN1FZR3VCT0VjYUFsREJBRjVCUHZhS2I5TWR1RzBmdG1xSDdBRGlOQXkv?=
 =?utf-8?B?V0MwSVBzcU1GTUdUS3F3aUVzays1MHpxT1Y0K2kyQnA1OUxNQ2pucjZBVEFi?=
 =?utf-8?B?KzhXanQzU0lXdS9namMzRW5qd0JKdlJmbWRXb2p2TkFGNlpRaStTSUFnUzNo?=
 =?utf-8?B?OUNmZTBXekZlV21ML29HNFQxTm1TNUpoZGVUa0pnZzFIaHhTaG1ac2lPa280?=
 =?utf-8?B?K09CVlNHdEhZRzAveXRXc2Q4Q29mYitqWjErQndERXp4aDQzckVza3BBUHpv?=
 =?utf-8?B?MUhqNW03c0pHaDhoU2k5UWpBSFZ3TlRoK1phcXkrRmRNS0w0OTdoQVBId3JP?=
 =?utf-8?B?aTVMSGRKMTgvUmRGOHhZMFZuREsvN3I5b2RLUXdtSCtYTzhHd1hLd043YVVD?=
 =?utf-8?B?dkN0TzY4K3dEYVpsYVJ1M2hLcTFBbndCRlU5ME90RVlKbVJrUTAxN29ld3ZG?=
 =?utf-8?B?M1ZEMjB1aUhZeFo5ZisyYVphd1N6K2lWU2ZLeWpPSHEyYzJLczIzclhZbk4r?=
 =?utf-8?B?VEZjZTZZZnk0azhseFZFYzZGajNYcjlIN21ndVByNTFoQzBwTDVrVCtwT1p5?=
 =?utf-8?B?OG9CNHFnMm4zTlFnenlrWTMyR2NMWUhqNm9id1cvcFdyNnd2VXB2SUZJeVJL?=
 =?utf-8?B?ZXZLVkEzMXdxVlNCVm1RMjVhRUhyUFNxQkxMTFoyb0ZmZVcxNXFXUjBjREJF?=
 =?utf-8?B?dWVVL3ovL0JOQ0dveG5ndUtQMVhKa0RzNFZIZ3JBTWFXU2dHTHkxbUdDQWls?=
 =?utf-8?B?MUprMHhTZFpsM1hEbDVmQmhzUWtjdnMrRFRkeXZQVlBSRWJCRmtZZXlDTWFa?=
 =?utf-8?B?UlNDZzgzaktpMHBrb2FiaGRpSDlKWEV6WGl3NElxVzV5cnNDTG1VajlBQlRz?=
 =?utf-8?B?aXpyb0FyQ2xNRHJITkFhSzVnYklsbFpUQXd4SE5oTmJPajl1SDBXbE5XQ2J1?=
 =?utf-8?B?NDNjK284YldOeVUwOEJSKys2S3JIZUpZRVB5WEZVdTRqVE5DWVhRQmxUVnZL?=
 =?utf-8?B?NHM0YkFTN0M5K3U3QlhNR1c0Qkc2NytOL2J6MW5DWkEzNGl1dkxscE5EaTBh?=
 =?utf-8?B?aUdRcGYxZDdiSXg1cVlCbkIyTmtEMWFFempkb2hodmZWRW1wZ1libmYvaGtN?=
 =?utf-8?B?UVpJdkIxV29hQWpRSEt6VE5QWGlPNDF4ZFBzc3ZtT3hXalFpS3BDRVh4a3FO?=
 =?utf-8?B?VDVVY1pmbzhxMGFKbWxTZEdtenlSdHRabWhyZnVLdnNXcFZBazJuZWtmeklq?=
 =?utf-8?B?aXJzeTI2eG9JeXl3NllmRThEQ1kyK3plS0liRU1LUFIzZmFQaCtnWEZPeENh?=
 =?utf-8?B?VW14VDRCcmlLekJ3Y1d2M3dtaHJtcWprY0REenZ0cTU1MHpFcUVvNmQrdnJT?=
 =?utf-8?Q?m3Bs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d151a85-54fd-41fe-42bc-08dcf7638df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 15:16:53.4639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vor1BwDc3PQcfhvddrwSeoV95i9o3B2aw7CyRblCfDdc6qLNQK4MVwNskyFaHxCRJedADZmDfCA2LHjQBlgiag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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

W1B1YmxpY10NCg0KU2VlbXMgc2ltcGxlIGVub3VnaCB0byBtZQ0KDQoNClJldmlld2VkLWJ5OiBL
ZW50IFJ1c3NlbGwgPGtlbnQucnVzc2VsbEBhbWQuY29tPg0KDQoNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleA0KPiBEZXVjaGVyDQo+IFNlbnQ6IE1vbmRh
eSwgT2N0b2JlciAyOCwgMjAyNCAxMDo0MiBBTQ0KPiBUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogYWRkIHJpbmcgcmVzZXQg
bWVzc2FnZXMNCj4NCj4gUGluZz8NCj4NCj4gT24gRnJpLCBPY3QgMTgsIDIwMjQgYXQgMTE6NDfi
gK9BTSBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBQaW5nPw0KPiA+DQo+ID4gT24gVHVlLCBPY3QgMTUsIDIwMjQgYXQgMjoyOOKAr1BNIEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+
ID4gQWRkIG1lc3NhZ2VzIHRvIG1ha2UgaXQgY2xlYXIgd2hlbiBhIHBlciByaW5nIHJlc2V0DQo+
ID4gPiBoYXBwZW5zLiAgVGhpcyBpcyBoZWxwZnVsIGZvciBkZWJ1Z2dpbmcgYW5kIGFsaWducyB3
aXRoDQo+ID4gPiBvdGhlciByZXNldCBtZXRob2RzLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiA+IC0tLQ0K
PiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYyB8IDMgKysrDQo+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMNCj4gPiA+IGluZGV4IDEwMjc0MmYx
ZmFhMi4uMmQ2MDU1MmExM2FjIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2pvYi5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfam9iLmMNCj4gPiA+IEBAIC0xMzcsNiArMTM3LDcgQEAgc3RhdGljIGVudW0g
ZHJtX2dwdV9zY2hlZF9zdGF0DQo+IGFtZGdwdV9qb2JfdGltZWRvdXQoc3RydWN0IGRybV9zY2hl
ZF9qb2IgKnNfam9iKQ0KPiA+ID4gICAgICAgICAvKiBhdHRlbXB0IGEgcGVyIHJpbmcgcmVzZXQg
Ki8NCj4gPiA+ICAgICAgICAgaWYgKGFtZGdwdV9ncHVfcmVjb3ZlcnkgJiYNCj4gPiA+ICAgICAg
ICAgICAgIHJpbmctPmZ1bmNzLT5yZXNldCkgew0KPiA+ID4gKyAgICAgICAgICAgICAgIGRldl9l
cnIoYWRldi0+ZGV2LCAiU3RhcnRpbmcgJXMgcmluZyByZXNldFxuIiwgc19qb2ItPnNjaGVkLT5u
YW1lKTsNCj4gPiA+ICAgICAgICAgICAgICAgICAvKiBzdG9wIHRoZSBzY2hlZHVsZXIsIGJ1dCBk
b24ndCBtZXNzIHdpdGggdGhlDQo+ID4gPiAgICAgICAgICAgICAgICAgICogYmFkIGpvYiB5ZXQg
YmVjYXVzZSBpZiByaW5nIHJlc2V0IGZhaWxzDQo+ID4gPiAgICAgICAgICAgICAgICAgICogd2Un
bGwgZmFsbCBiYWNrIHRvIGZ1bGwgR1BVIHJlc2V0Lg0KPiA+ID4gQEAgLTE1MCw4ICsxNTEsMTAg
QEAgc3RhdGljIGVudW0gZHJtX2dwdV9zY2hlZF9zdGF0DQo+IGFtZGdwdV9qb2JfdGltZWRvdXQo
c3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9iKQ0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uKHJpbmcpOw0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKGFtZGdwdV9yaW5nX3NjaGVkX3JlYWR5KHJpbmcpKQ0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkcm1fc2NoZWRfc3RhcnQoJnJp
bmctPnNjaGVkKTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+
ZGV2LCAiUmluZyByZXNldCBzdWNjZXNzXG4iKTsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gZXhpdDsNCj4gPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gPiArICAgICAgICAg
ICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJSaW5nIHJlc2V0IGZhaWx1cmVcbiIpOw0KPiA+ID4g
ICAgICAgICB9DQo+ID4gPg0KPiA+ID4gICAgICAgICBpZiAoYW1kZ3B1X2RldmljZV9zaG91bGRf
cmVjb3Zlcl9ncHUocmluZy0+YWRldikpIHsNCj4gPiA+IC0tDQo+ID4gPiAyLjQ2LjINCj4gPiA+
DQo=
