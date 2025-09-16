Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16496CAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 14:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A908B10E0F9;
	Tue, 16 Sep 2025 14:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ds9ejyl";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395E310E0F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 14:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ6u33aMMEk0hQq+YzNx7kWL3xBvOGDkwTAfaMaATd63DAIYnNzyhQftyfgnQVUp9UfATjVtkjse2JuMMRcfzaDlhOR0an9luSNrCk4WHK4CukHC9J4qm6XxphY02cIz/NqceJ6ct6cok9X/3BubzM+jWQ0ZSjCzzu8srPWVqIOBM8jiP12MEWK0RZDe0SvQg2JgKhNQzALNU8p9mXUAm24Spx6yGmbz5O0ke4yvR7CI8++Sw3kYeDJZds32xtwR1T6RT5u9STYXN5k0yIIHINCIfGMBKkg1WsEzb4h9mBYoFeP267eI9MWuM6KfMb2254LJP6MHrEjlRrYQybNd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KUq1w/QB55W7gBSnIoWmzq1yeOM65pb0n6lndg4w8k=;
 b=GmG80UbBSWm9D6u7A/5zlncekTBbjWkMT8VuWS4fxqxQFBn1U27TRkqj4UdHbUIl9/+SceLXrbzQVTSDTacobvaNE1cftpHhf8/ElynBklenG5msBS9k2l8Ak8ozoiedVIh8OCZZ2a3wg5+aW3SkECOXSeQc4By34qjiyX4kWxQWKo7qlmgF725faJ1M2YI52vbQzcJ4Lk9a/JVRQdi7GJnRXWPBelPVKQcBWO8a772EtRCahNiPu/9jwO4SuaIUlnCewkl+RKBI3kmbK27FQjSQvoNFAO31dukg6f7X8odZmGNjeVNFfmT0nRsP2BTyoiOE2j+Ew29fGngQ+ushYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KUq1w/QB55W7gBSnIoWmzq1yeOM65pb0n6lndg4w8k=;
 b=3ds9ejylLXCenHTDz7GijHE40KEIke2fHTE7JummWss/LWHJpSS0diFM5ufhDZSlCQAv9Y/Kfmyi5doissWYBfsulnkGQuth7KFBLOHBmRMK6XsQl3ohOQUSWDzoCMDqVx63XgL2RtmE7ODjhlXntPr3AXZmJdhS2eWCSIe3Ho4=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 16 Sep
 2025 14:41:48 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 14:41:48 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v3 3/6] drm/amd/pm: Allow system metrics table in 1vf mode
Thread-Topic: [PATCH v3 3/6] drm/amd/pm: Allow system metrics table in 1vf mode
Thread-Index: AQHcJukZ8E24DYbp1kyMmWgXy/NgzbSV4eXH
Date: Tue, 16 Sep 2025 14:41:47 +0000
Message-ID: <PH7PR12MB5997ECFD10DCCA554F3DC8358214A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250916090527.2727930-1-asad.kamal@amd.com>
 <20250916090527.2727930-3-asad.kamal@amd.com>
In-Reply-To: <20250916090527.2727930-3-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-16T14:40:33.7317287Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CYYPR12MB8891:EE_
x-ms-office365-filtering-correlation-id: c53fa377-3ac9-4ba8-9002-08ddf52f2a51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?gb2312?B?U3RiRVNFRjYweVdGNDZsZjcyL0l5TXRBV09pZ1d2SnppQjNNMDdUMW4vMUlq?=
 =?gb2312?B?SUJ2RE16Nk9VazFDK1JjdkJzQUhramUyekV0RzRwbmVaOWNaT1U5eVZFZ0tx?=
 =?gb2312?B?Qlc5YUNFTHlKZ014eGZOcHdmUUxxTmlNYlJvYmg0azlNMFRoaVMzbzV6V0la?=
 =?gb2312?B?ZjMveW41UU5MWXo3QXMrVDUzSHhxUWdMdkZ6a2VmcEdVZGNiQm5RM05WUitv?=
 =?gb2312?B?dFVyZllRNkRPMDB4bFVHdldSaU1xMzB1RkhCZDNlclI5cGc0L0E0cDl5NE53?=
 =?gb2312?B?cThJV1JUV21kazBzbFRMNEErS1Vvb2JXbVpUR3pTQzY5VWpCTGc1c2VRVHlx?=
 =?gb2312?B?ZU5yck41c3ZwbHU4TjBYOUdUS3cwdWZXV3NnM1g3RVFIaVpUdUVrOXFtMGhr?=
 =?gb2312?B?Wko1MjBWancxMkU4SU9TYUI3Q3JwRDZHSE4yQlZYTFdFMWhSajVpdjMzK0xU?=
 =?gb2312?B?TDFzYms5MG92YmRVVkJMWEltWjlKMCs5NjRIanNWRUtnRFNaeE1kdVF3VEti?=
 =?gb2312?B?SzNIYlpKaU93aTkzWDRjYXFTMmpDZW9oaklyVG50WVkzNWtsclNqclJNdDkw?=
 =?gb2312?B?cFc5ZEhaQ3ljTmcxL01YK2dhSjVqSTRqOFFLZVEwelhTbCtXTzVMaEFtZFJR?=
 =?gb2312?B?a3RCUlVGbzcvQks0cU5ZTEh0RXNiNDYrZUlFRFJRWG1odkE0M0hKaERyekpP?=
 =?gb2312?B?NENxL29UT294MkVLNzBGUFpCck5YVzVPakJuYzNVOWlzd1huR2lBU0tJdWhw?=
 =?gb2312?B?TUdBRjAvWTBXTzNFcTVoemYwMWVEQnRObXY0QTRBdlNMQlFSajhuSDJGMDdq?=
 =?gb2312?B?K3RoeWxIY2IwdUVFNU1pelBnU3lVNFdjWmw1UkZpYzhkRlFsZnpiM3BDNXNO?=
 =?gb2312?B?Ym9kN042M1RYa3Q1ZFRVUnFTUVZnYlNmU21lZXVzZHN2VXNRR2VYTnhlNXFy?=
 =?gb2312?B?VDRDN3pzUWxVV0MxZ0lsVURaNHZIWUhZcXJoMlcxOFAvbExXZG9DWjczM0lm?=
 =?gb2312?B?Vzg3dGdoc3RXSmhodlF2OVBlZTMxSTUzK0Zmclc2MDhMOXgxYzVVbXEzYklV?=
 =?gb2312?B?L296OWd3Uk5NVFN3SmdPMklTWEJCam1Ka0IvV3dTVFFpVXpSU2VwcU1udGpO?=
 =?gb2312?B?OTg2Q3R5dVA4S2lNenRVNFpXNzFtWC94L3dqdU44V25DSVBZdGFJQ2ZFdzhZ?=
 =?gb2312?B?M3Znc2hpVm9YN0Z3eGRRRjBsaGlDUTJhQThzb3MrbU00UUdXRnNSalVXWk1z?=
 =?gb2312?B?ekZYNUxIYzVoZUdCODNlZWlqNUEwMVdtb0xPWWlEZGdpNmJDRnVaUHFLckx5?=
 =?gb2312?B?WXVSUFBPOXlRT1dmOGNwdFd6cDduZExWcUVPZDV5MmE4enhYZGdJR1hhU0xr?=
 =?gb2312?B?MERKSU1tOFhWUU5PcnFENlZxSDZTWTU0Q2JPMzBGZVRvQ3hyUEYyUWF4aExv?=
 =?gb2312?B?ZFl1Uy9jWXFGUlVLT1dXZUJXdzdnZklINy84a1kzV1JxZ1hrUnFHV00xV1hD?=
 =?gb2312?B?aHgxQkJHYnhFeHNuVFQ4Q1RvUUdCQ1Z3QVdyL0tzQkpqQ1FSUmJ5L2tZMDZB?=
 =?gb2312?B?NGhMcERUSHJmRWR5Y2MyR2hNL3lpTmtTbm9zeHZNSTQ1YmFPTjFRMElVd1ht?=
 =?gb2312?B?NWVLVGcyOGxoeHJSQ0NnVHBUeU1KaDRyZ3VmRnc4a1dmb0RuRWp1T0FTY1Rj?=
 =?gb2312?B?KzMva2NVVW1nN1FHYjJOT3RJdmYrN1JWSnlHRHFKK1NnTTFvRTkzOENUM0Y0?=
 =?gb2312?B?QmFHcENJcjYzdUFuZDdrTGptRm16QnBPNktQK2VmbnNFbmZZNGh5K2Jya0lD?=
 =?gb2312?B?THgwKzNIOUdzU3BVOElRTmE2RCtCNGxHY0NwR3NhY2tzdUdaeVkxWlI2aGdF?=
 =?gb2312?B?L1MyZktBQVVSTmFWSjA5SEd4QUVTZ0syT0FIQU96UG42UTNMenliTzJ5MVVG?=
 =?gb2312?B?em9EZlhQMFRodEFmbkJrZnNCek9aYzdJYkx6ZFdtc0x5SWFSVmUwTldzZFVV?=
 =?gb2312?Q?71AVDzw2py7rU1yOG0O0RxXJq7TKnI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TU81bjFBZmRmU1VsOFpJZHNhQVg1U3hGUEhWc0VBbG5Rb1hRVnF2Qmxpb3U1?=
 =?gb2312?B?eVNRNW9tMGNKVmFoMmdiaWMvclhkL1gzM0g3N0VjUGU5N3E3MVBFU0UxM1FI?=
 =?gb2312?B?SHNrVlZzWFg4K1lyR0VMYVkveUVleWlENU5ENDYvcGt4TEpXa3FuLzZoUElL?=
 =?gb2312?B?TmZWVEt6TUYvRVBycnlwb3JKc3NEclEyVmdCaURscWovaEh1VzdDZlI5dkhF?=
 =?gb2312?B?cmRCM1dxbmZZVGUrUHdxbUNOeWJEYXloTHhKYkFaRFlucS8rY3pBZjV5OEow?=
 =?gb2312?B?UGU5U1Q3dVI3RklhOUxmeHZQbmZmVUNBU1VMbWthdFNydUhyZS8veVVZdnJF?=
 =?gb2312?B?OFcrUjEyVm9oVjdidUhaTHZ4M284dnR6OFphcWNkWE0ySmxXYWdmcmpvY1RN?=
 =?gb2312?B?ME5tU2xBaHNoNDBWUVVOdTNTeHA2Skd6STg5aUVlUytoSXRyK2gyRXZOU1pj?=
 =?gb2312?B?ejQ3QU5VR0RiZnArQ01mc3dpYlJSKy8zb0dZS20xaWZBTFhWNmZ4MDUrSFI2?=
 =?gb2312?B?cVFrbGdWMzZ3bjU5RUsramltU0wyTm1wdjRRRktmQk40VzdXeEdqbG5McGxV?=
 =?gb2312?B?N01tU0FGd2dkaTVzeHZvRTU2dVUvd1YyWmxTKzJ4ZzFPKzZqcHRRQWc5cUlq?=
 =?gb2312?B?Nkhmc3k2MUVBeVl4NTV6RllpNU9IcU8yeWxhNGJaRHZxQ1B2M2wvNHU4aXlB?=
 =?gb2312?B?NklCVDZBcTkrcFR0Y3JqQnYyQllsZEliN0RaWE5nUDNTSDJGb2JIRnhvSTQ0?=
 =?gb2312?B?djVtZitsVUF6NWcwSm03cytSTjJKOC9kL3laOEhkZm5BaVVsUmtOL3gyWnlB?=
 =?gb2312?B?TThTWW5udVZDRXVGSVNQb05OeTd4SEpHMlZwT09OYkV5SzczYXQ3Rzliclhw?=
 =?gb2312?B?ZjJCK3VoR3NjVXhnQ0tPem5SYjN3NUNrSDhxS3ZaYmNNaHBaVEtHNlZpMUN2?=
 =?gb2312?B?SFE3OGluWGJMbnc1bEtLWlphUFFtemw2Vmlmcms1VEF0UTZDTjNmS29mK1Aw?=
 =?gb2312?B?aTFyQnlYZG1aL2pMalRlcnZHOHlkd21QRXdEeUp1TGp6eGE4K21vSDUyeW1U?=
 =?gb2312?B?MkZ6UVExUWxCbEpnb0JMcmJJdVVTVlY1SVdiR3JTUUwxdkxGT0QzNzhpQ28v?=
 =?gb2312?B?UFIzWmllcllXcittVjR0WlVscXpxRjZkclN1elFHb1oxR3JPOXZlQTJycE9T?=
 =?gb2312?B?UmNESkRudlhoZzlXb1dYVC9ueUt4NDQyT1BRcHUxMmtDS2x2aVVKY0haMTds?=
 =?gb2312?B?eUNXMFNzZ1lzYWdUWWZKWW9KWS9SVncydzloaEFURUtiZFloQUV5YTdFZTBD?=
 =?gb2312?B?K0d3S25nWEhNZ01aNmFONWJHU0FGOXNKbVVQRDBwMlczaTdQZ2JnbzQvbmhN?=
 =?gb2312?B?TUN5bEhkelBQVXNuTEE1STJFU0thK0Iwa1p1ekZjQmR0UnM1VlhGRTlha3pB?=
 =?gb2312?B?ZitFT3R2a1VzVnUweUZrVU44T1JNeHJTRzhWK3VQS1MrZnFqck15TElONWZ3?=
 =?gb2312?B?MGU4QzNVbmZPSzMzVENXT0xneWZCZXpPNVdlYzVWa084aXJPMFdEZ05KQUFJ?=
 =?gb2312?B?dDgzWnN5U3RSbVFkRm04VGMwWlFXbHZoWGRZeTNZaVJLT2xqemlGNm4yWnJm?=
 =?gb2312?B?ci9UK2JXWjExOGZvTDNJSzNpOFB6RVlQQ0cvbFBBblJ2aG4vemQwOTlpSnFh?=
 =?gb2312?B?U2tvZVJmWWpubFpmYlBycVU3YWFTMnZmVFk4Mk0xWTVvZFBCbER4Z3RrdHZH?=
 =?gb2312?B?aGhqU3NNdElpL3dpT2NLSHFsV2lWMyt1eWRtdjN4M0YzUXZub0YrdExJVFVC?=
 =?gb2312?B?VWlYd3l4NDZHVHl3VVBsS0xHMEwxWjVWaFZrUkpSSVdNNXk3ellEQXNDZ2tM?=
 =?gb2312?B?S3l2RnhjWW5LYjNiMnhVTUlEelJzSmFXU0xQMHNSN050eWNXVk8zWlFBWFlV?=
 =?gb2312?B?clE1N0dHb0N3bEplWFJwWjZIR0RCYUJnaStIUlk0TUZYV2h2UEtrYVBlcU9F?=
 =?gb2312?B?ZTlPc29kU1Rac1gvc1lWbWJCS21EcW5GNjlqS2NXdmdMNTUwb0hQT2hkK3F5?=
 =?gb2312?B?dHlLODVZMVUzaHR1WWpwMEJYWll1d0h5Z0Z0SDQ1NkdMMjJEK2t5ZDhEaFpx?=
 =?gb2312?Q?2tTCUDYQ7IXnldmR4BTKMXXj5?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB5997ECFD10DCCA554F3DC8358214APH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53fa377-3ac9-4ba8-9002-08ddf52f2a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 14:41:47.8092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRQ+nHeO7LQH8QvX+6jXTgoO4pww7p1vTubpq7XoX6lSCMHCd53fiedW3xhqX6n5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891
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

--_000_PH7PR12MB5997ECFD10DCCA554F3DC8358214APH7PR12MB5997namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KU2VyaWVzIGlzDQpSZXZpZXdlZC1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQu
Y29tPg0KDQq78cihIE91dGxvb2sgZm9yIGlPUzxodHRwczovL2FrYS5tcy9vMHVrZWY+DQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBLYW1hbCwgQXNhZCA8QXNhZC5L
YW1hbEBhbWQuY29tPg0Kt6LLzcqxvOQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxNiwgMjAyNSA1OjA1
OjI0IFBNDQrK1bz+yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz47IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQqz
rcvNOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgTWEsIExlIDxMZS5N
YUBhbWQuY29tPjsgWmhhbmcsIE1vcnJpcyA8U2hpd3UuWmhhbmdAYW1kLmNvbT47IEthbWFsLCBB
c2FkIDxBc2FkLkthbWFsQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNv
bT4NCtb3zOI6IFtQQVRDSCB2MyAzLzZdIGRybS9hbWQvcG06IEFsbG93IHN5c3RlbSBtZXRyaWNz
IHRhYmxlIGluIDF2ZiBtb2RlDQoNCkFsbG93IGZldGNoaW5nIHN5c3RlbSBtZXRyaWNzIHRhYmxl
IGluIDFWRiBtb2RlDQoNClNpZ25lZC1vZmYtYnk6IEFzYWQgS2FtYWwgPGFzYWQua2FtYWxAYW1k
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18w
XzEyX3BwdC5jIHwgMiArLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211
X3YxM18wXzZfcHB0LmMgIHwgMiArKw0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTEzL3NtdV92MTNfMF8xMl9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211MTMvc211X3YxM18wXzEyX3BwdC5jDQppbmRleCAwYmVjMTJiMzQ4Y2UuLmYxMDIyOGRl
NDE2YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211
X3YxM18wXzEyX3BwdC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEz
L3NtdV92MTNfMF8xMl9wcHQuYw0KQEAgLTEzNyw3ICsxMzcsNyBAQCBjb25zdCBzdHJ1Y3QgY21u
MmFzaWNfbXNnX21hcHBpbmcgc211X3YxM18wXzEyX21lc3NhZ2VfbWFwW1NNVV9NU0dfTUFYX0NP
VU5UXSA9DQogICAgICAgICBNU0dfTUFQKFNldFRocm90dGxpbmdQb2xpY3ksICAgICAgICAgICAg
ICAgICBQUFNNQ19NU0dfU2V0VGhyb3R0bGluZ1BvbGljeSwgICAgICAgICAgICAgMCksDQogICAg
ICAgICBNU0dfTUFQKFJlc2V0U0RNQSwgICAgICAgICAgICAgICAgICAgICAgICAgICBQUFNNQ19N
U0dfUmVzZXRTRE1BLCAgICAgICAgICAgICAgICAgICAgICAgMCksDQogICAgICAgICBNU0dfTUFQ
KEdldFN0YXRpY01ldHJpY3NUYWJsZSwgICAgICAgICAgICAgICBQUFNNQ19NU0dfR2V0U3RhdGlj
TWV0cmljc1RhYmxlLCAgICAgICAgICAgMSksDQotICAgICAgIE1TR19NQVAoR2V0U3lzdGVtTWV0
cmljc1RhYmxlLCAgICAgICAgICAgICAgIFBQU01DX01TR19HZXRTeXN0ZW1NZXRyaWNzVGFibGUs
ICAgICAgICAgICAwKSwNCisgICAgICAgTVNHX01BUChHZXRTeXN0ZW1NZXRyaWNzVGFibGUsICAg
ICAgICAgICAgICAgUFBTTUNfTVNHX0dldFN5c3RlbU1ldHJpY3NUYWJsZSwgICAgICAgICAgIDEp
LA0KIH07DQoNCiBpbnQgc211X3YxM18wXzEyX3RhYmxlc19pbml0KHN0cnVjdCBzbXVfY29udGV4
dCAqc211KQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMv
c211X3YxM18wXzZfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3Nt
dV92MTNfMF82X3BwdC5jDQppbmRleCBiY2Q2NTI1Y2E1ZTkuLjg1YzA3NzdkNmUzZSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzZfcHB0
LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzZf
cHB0LmMNCkBAIC0zNTYsNiArMzU2LDggQEAgc3RhdGljIHZvaWQgc211X3YxM18wXzEyX2luaXRf
Y2FwcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCiAgICAgICAgIGlmIChmd192ZXIgPj0gMHgw
NDU2MDcwMCkgew0KICAgICAgICAgICAgICAgICBpZiAoIWFtZGdwdV9zcmlvdl92ZihzbXUtPmFk
ZXYpKQ0KICAgICAgICAgICAgICAgICAgICAgICAgIHNtdV92MTNfMF82X2NhcF9zZXQoc211LCBT
TVVfQ0FQKFRFTVBfTUVUUklDUykpOw0KKyAgICAgICAgICAgICAgIGVsc2UgaWYgKGZ3X3ZlciA+
PSAweDA0NTYwOTAwKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgc211X3YxM18wXzZfY2FwX3Nl
dChzbXUsIFNNVV9DQVAoVEVNUF9NRVRSSUNTKSk7DQogICAgICAgICB9IGVsc2Ugew0KICAgICAg
ICAgICAgICAgICBzbXVfdjEzXzBfMTJfdGFibGVzX2Zpbmkoc211KTsNCiAgICAgICAgIH0NCi0t
DQoyLjQ2LjANCg0K

--_000_PH7PR12MB5997ECFD10DCCA554F3DC8358214APH7PR12MB5997namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, -apple-system, HelveticaNeue, sans-serif;=
font-size: 12pt">
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Series is</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" style=3D"font-family: Apt=
os, -apple-system, HelveticaNeue, sans-serif;font-size: 12pt" dir=3D"auto">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" style=3D"font-family: Aptos, -apple=
-system, HelveticaNeue, sans-serif;font-size: 12pt">
=BB=F1=C8=A1 <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Kamal, =
Asad &lt;Asad.Kamal@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Tuesday, September 16, 2025 5:05:24 PM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>=B3=AD=CB=CD:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Ma, Le &=
lt;Le.Ma@amd.com&gt;; Zhang, Morris &lt;Shiwu.Zhang@amd.com&gt;; Kamal, Asa=
d &lt;Asad.Kamal@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.=
com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH v3 3/6] drm/amd/pm: Allow system metrics table =
in 1vf mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Allow fetching system metrics table in 1VF mode<br=
>
<br>
Signed-off-by: Asad Kamal &lt;asad.kamal@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c&nbsp; | 2 ++<br>
&nbsp;2 files changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c<br>
index 0bec12b348ce..f10228de416c 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c<br>
@@ -137,7 +137,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_=
map[SMU_MSG_MAX_COUNT] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetThrottlingPolic=
y,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetThrottlingPolicy,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ResetSDMA,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P=
PSMC_MSG_ResetSDMA,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetStaticMetricsTa=
ble,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; PPSMC_MSG_GetStaticMetricsTable,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSystemMetricsTable,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; PPSMC_MSG_GetSystemMetricsTable,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSystemMetricsTable,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; PPSMC_MSG_GetSystemMetricsTable,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 1),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int smu_v13_0_12_tables_init(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
index bcd6525ca5e9..85c0777d6e3e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
@@ -356,6 +356,8 @@ static void smu_v13_0_12_init_caps(struct smu_context *=
smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fw_ver &gt;=3D 0x04560=
700) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(smu-&gt;adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v=
13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (fw_ver &gt;=3D 0x04560900)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_6_cap_=
set(smu, SMU_CAP(TEMP_METRICS));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_v13_0_12_tables_fini(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.46.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB5997ECFD10DCCA554F3DC8358214APH7PR12MB5997namp_--
