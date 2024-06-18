Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3499C2BA15
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 11:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7066310E642;
	Tue, 18 Jun 2024 11:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GU9VFqK+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117D110E642
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 11:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaqR7unlcP8ulEdAI1zNuwfvfVjxnvZmGc3yaVUaPOQqnv29lWElavnX9ERtR71pvwJ4/ePxvKw7nMEGODO3KonyVRalxRAG8onmpAt9JTi4O3dIsleKYz/NXgQJnc3ZQMuH2y4dpF9Zm9YXlK0v0CiPpn9ObZHhz1lWiHw+BYE0gAlMcJp+RdSFs+cH2LIekPRPLXkDZ4Qf3BIlibNMasaA9WHW94CGyy91J5kCBzdKCvCeIgbdBOV7Lt+EYnvNd8tTRW9kIxjtJjDyJ922tOfAXPtekOZbb44tEAs7u72HNuXnqv+WokSWiuuIIeAgDePqBaW1XVFypBfFFAT7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XImb/5vEgQME88CzFqGHV34Y9g1nQ8upcAkEmCnz7K4=;
 b=i1nkkdoBHC1XY3gBNRaVgkL0vysR7p32Js1F77y0T6E8reJT+S5KuOPRQEMzft8U36hzqF/nPSBMhxJBo9KCs4x8lRyC0+KG8MhsfMnMoqNAfffhMNH4JU6L8kz1MdJRsOnARUlWACzsmnOSJo28CkJmZak46jmN7goGKfjLqxlFVE+6ESpTwoh8R2ltwSg+ub8g0CZTkuE2C2c07J6Ck3aodaPMXONXEs3eiRKLx1uF9sdzBNTJ8DEEQKHaAip8WI3VQKKU7PAunuSK3Aj4SPr3KyAewYxOKiNXF8T4cfcPxyQdPIogiCXqWMFpXpIscrIgV9cc53w5dqooa4b8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XImb/5vEgQME88CzFqGHV34Y9g1nQ8upcAkEmCnz7K4=;
 b=GU9VFqK+KDbDgz8bJ2RUcb8isrkpy1tmRF2IbMjicOOZGbDANIGmpzo1YYpxZHUz20ezzZw6e4PG7pL291MQi3F1gWRStl1z1IrEG29BlLGNWkJ+AGcmi+e/rqYXB7QPIrFWu6LaFjMhtViIlhJxP35WbuwqJi2Qng91wgJgtE8=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 11:21:40 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7677.019; Tue, 18 Jun 2024
 11:21:40 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: add completion to wait for ras reset to
 complete
Thread-Topic: [PATCH 4/5] drm/amdgpu: add completion to wait for ras reset to
 complete
Thread-Index: AQHawUmZh+cnncTiokiQg6Zfrfp0irHNTJuAgAAQDmCAAADmsA==
Date: Tue, 18 Jun 2024 11:21:40 +0000
Message-ID: <CH2PR12MB42153072563764BFF1BC294AFCCE2@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240618063359.304293-1-YiPeng.Chai@amd.com>
 <20240618063359.304293-4-YiPeng.Chai@amd.com>
 <cb616e09-aad2-433a-a7d6-a6a322687d17@amd.com>
 <CH2PR12MB42153B70D0E1F0EC8719E371FCCE2@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB42153B70D0E1F0EC8719E371FCCE2@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=379ae3b8-5d07-4ad4-97cc-b2c6918618ad;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T11:06:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CY5PR12MB6177:EE_
x-ms-office365-filtering-correlation-id: 56ee2dd0-da1d-494a-66be-08dc8f88d370
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?ZzBUN1NvQkxRZ1lBZXhKQ1JKVEV0anRYNzlIcW5KUm56OS9oT0taQUxKb1Mz?=
 =?utf-8?B?U3E1WE1BM3dWVytrc0Y5Y0FZZ0EvWHNTUTlDbENNZzNPRmtEaDJWRTFPVjdC?=
 =?utf-8?B?cldPVzhzbEdOS3dRalpHZ0VieEVNclZNQTZQanlwVTBmM0pJcVVwTnkrc2lH?=
 =?utf-8?B?cGk0d0RWcm1Lc3dnem9uWVk4YkpVelhLdnJtYmpwTVdTcE1ZdTN2dm5BSDhD?=
 =?utf-8?B?Unk3MjFUT1RYTWNJVzRCck9pa3dHcFgrVTdzd1dMbnQxUklUMmhUbVJYNXE1?=
 =?utf-8?B?YktVVElDNndxc2piU3c3RFV0WVVUeDg1TmIrcmFzRnZ4SFdoN2Z0RHFpa1kz?=
 =?utf-8?B?cWl4QjZ0SWppTVFEUzdmRGxsY25IYWxiSExNcUJvY3JINnE0RGxVWWNIWXg3?=
 =?utf-8?B?Yi85U1lyQ25tendEUENiaGViU0ZKd3FZY3lDSFJCNXRBdXNsa1BEdmpwZUlO?=
 =?utf-8?B?cTQ1Y0tTWjZzRkdBVmsvWU9MNktFVEVMbWk4S0ZpY0FoVHhwQUlGRTFkUTBV?=
 =?utf-8?B?bXdsakJ2WDVlY1NuZGo1R3FURThDWStPQ3NkeFNwcDRaOUhEN2hwT1pMazh4?=
 =?utf-8?B?Tm9PNzhDbnFPRzBZSE8wRnFFNU9oSkVSSGh1QUxmaWdyb3pJUGxTdEdHOXg2?=
 =?utf-8?B?UGxPSEFDL2UyYXUzTzJYY0pGS3Vna2lCOXdPelZOOEtMVWdiZ2N0YVl5WGxi?=
 =?utf-8?B?bkxRb2hVVnhGMWJudWtPRlFyY3JueGg1THlWcm9HMWUyQkVrdkpDVjBMTkZF?=
 =?utf-8?B?d1JRTnlvUVk3SEc0eHB0OVMvd2J0NEx0SW9SN0dkcEdadzZDNTNtekFEaUFa?=
 =?utf-8?B?MkFoanlKb0FBL2xhWExuUjRNVnpKWWs1aDFSOXBQM285em5hYmt6cERsNk1U?=
 =?utf-8?B?b1lwZnNKNERGVDBwVnhYOW1VbGJGT1c2NVBpMzdiempiOU5KeXlmeTh5dEZW?=
 =?utf-8?B?b3BmQzJuRmtteXRNLzJzUVN2RWxXRWFGc2liSHMvd3JDalZmTW1iczNvTm4z?=
 =?utf-8?B?YkR0TVhMNXhxaVA0c0F4blBoOWJOK3d3SWxGSU92TStVM1F2c0ZxVy9Rb1lF?=
 =?utf-8?B?M2hNazM4VlAxeFBqempyNFh0UDFEL0llOXhhakJ0ZGk2T250Q3llZzBOQ3hv?=
 =?utf-8?B?aCtHWFdtR2ZrYlBHcWZDWmFXTkpoM3hDT3JJNVZDd2pNQlNHMDhaVDg1RmRB?=
 =?utf-8?B?TDFNTUN4YVViME1KdDRGUkttTUhUVVdkQ1dFeWpUdGZWYlN6QjZrNVhFZzda?=
 =?utf-8?B?Rm84c3lzazZnd29jVW1taTZXQXNKL0FDUDVtdis5cFBmaVdQVGV0M3JLL29i?=
 =?utf-8?B?NFk4TTc1WVNBVkR0bVppU3hOMG5reHlWU2NoQmNFYllzc1FyeC9VQ0pMMDVl?=
 =?utf-8?B?WW8vWENJRFhEWVdOdCsvNURjNGpWNXlBRzBNU09EVHZzRlZ3V3NjSngrRmJ0?=
 =?utf-8?B?VjZ0TkNPWCtZb20vWTRXUE1jVHgybGlqdEZxNlFPT0pWY25renVPUEdZZVdS?=
 =?utf-8?B?eEsyQ0dUa2lSVnI5NjFOY3gvSlVVcFBNbCtzMnBwQU5QWlQzdWwyYWNXVHM0?=
 =?utf-8?B?Uko0NFhmK2c3Wk9sbWNPSnZ4blIyQU5iM1Y3NTRrNkQwMHcrUTdMdjNXWTdC?=
 =?utf-8?B?Q040TzZEbzEvOVRnWmxkRUxMU3p5dm9HQUpXVEI5a3EzOGhZbGYwdUQxdVdF?=
 =?utf-8?B?V2lDUW9tNnRtUTlSYyt0R01EeEVRUXkyMHZTajlFYzdHOFE3NTFkZnAzV0pO?=
 =?utf-8?B?UDJ2R0tJcUxmOXo2bHYxRlRKTTMybE43dk5hNHhvN05jZ1ZxVkZ5L1RzZlZv?=
 =?utf-8?Q?SpnxOUauOGy/DtkUOCRDGJYpQ/ra3nk35C1oE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFc0SHRPSWp3ay93RjRWUmV6SElWdVVTREZzWFBMR3NJSkV5RGR0NFJieDZ2?=
 =?utf-8?B?blNDcEVoMUQrUTdJYjVBaFY4KzNPM1ZkclN0ejhXRHMyTGVaSGROYVg5RFpt?=
 =?utf-8?B?cFE2NzR0emJqTm9UaGIxdSt0a25FbWM1dnNzM0lwbW91WDh4OVlJR0ZKdU10?=
 =?utf-8?B?RmQ2eGhYUTZOV2EvQ3ArKzlRK1dOTVhYQy9WRW1kdHFlTGxHOUwrWHJYeHJP?=
 =?utf-8?B?L0tqOUNOVVN1cjlTdHk1S05hZnNPN1lBN1NCQ2ozWmpuNXlDOFZ1eTdOMUxa?=
 =?utf-8?B?ZEo2a2tZdDVzSEw3VEVWNGJGVEtXNE43YVpXUmNHRjRPQU5UY2RmNlh4Ni9S?=
 =?utf-8?B?cFlEK21TV2U5Ny90RU82YTRiNTR0aDNVSUlrNTF0TnBBcjNZYWNLYU0zQkI3?=
 =?utf-8?B?Y3M0dks2d09PeWJ2SGlMZk9aQkxEbGtZN3ZwdUZMMTB2QjVZL3g4ZmpzVk5w?=
 =?utf-8?B?V2ZZZEdUSTdwN05laWp2clh0dll3WVhBRGZibVdqZE5YZVF2R0hxVUZmOHlr?=
 =?utf-8?B?Y21vZmNOQ0VkenBEV0sxbEprRnBvcS9VSFBWeDJoMU9zQkRFOTFuS2JOcCtN?=
 =?utf-8?B?aVc3Ujg5NTMrVzJ2VlpXWDJjWGZaNEYwWUZlN0daUGxaQzJ6Y0pDWG9RVW9a?=
 =?utf-8?B?QXZ1WTNta3lWdkRRaS9QaTlTNGlzTDNodjAxcEpPcm5yaUJHQjZaTVd4RlUy?=
 =?utf-8?B?NlBoUHkrd0hTSjYycXZDbUZhTlFrRkc0RHVHZU1reUNiMUMwcEZTZFZpbzgv?=
 =?utf-8?B?K2NNaHlvazJiQ2Q0eXIrNzltMzRMZG1DZWxaZDgrZXNuSUJ0QlVMMkhDNUFS?=
 =?utf-8?B?RHhsOHkwQnQ3UHMwM2wwUERVcmp5amdwS0dPb1ZTVk1qMWl2YWVNOFp0NnVV?=
 =?utf-8?B?eFlwQXpRTjlUS0E1S1lSamsxTU9zWGZobGdvaXRwYmV4THVTdUVIZVZxQ002?=
 =?utf-8?B?Yk9XcjkvMFJNc0tXa0UvYXdpNzZvVnV2N1F5NzRIWEZ1aERTbDduVzFkN1Vy?=
 =?utf-8?B?TE1zODRaQVlxYmJlUXlFcndMZzQ3Smh5WGYrUG85MmlCT094eWtobEt1ZmJm?=
 =?utf-8?B?OFFCT0syTTA0MTZQODV2enhUajVjUS9YM0lOY1BPMlFMcUdBRWhZZkNOK0Rs?=
 =?utf-8?B?WWdPbE1NbjZ6L2tOMzdoK3BxbE9hV2k0bTIvSFp4YWdpZHA2Q2MxelpSeGNz?=
 =?utf-8?B?V3lXZmpXdDFSQzYzQlJVY0FSZ0R2bW9tT1hFZkFqaFpVa3MybmJ1Sjg5TnFY?=
 =?utf-8?B?cWd2Mjg4eG91ZEJISmcyQk9BWHZNR0xwSXhYRW0rbHVGZGplcG1SSEJsYnRR?=
 =?utf-8?B?ejhOTTVhSk9ZeC9RLzR6ZUxKT0NqZHVtTGJ4cEVKVjNWTkthM2N5d01qbzFT?=
 =?utf-8?B?RThmRldWN3dCSE1acUN6d2xPUVM5Wmp4WU1FL1RGM2ZZWkpoZGxaMFdEdDhY?=
 =?utf-8?B?c1JlV2o3aklZQkxGWjJIeHlmR0Y3T24yVkFFbTJtVnBuYU4zUkQrbFNHa1Nm?=
 =?utf-8?B?eVlBQXRISW8vUHZpdi8yV3VTZFd6MEZ3N1ZmSHdyUmhPTkVPV3dJZ1NYOG5L?=
 =?utf-8?B?ZzRxSFZ3bFpEeTMwYW0wYXJ2aUtWTGxkSWVweXdVMkZBMDcyN1FKWGR6Snk3?=
 =?utf-8?B?SmdoVFZRdHZMNHRhaUVieDlCS05OYjhidno2RkZ4aGYzbE0rOWx1RHdwQnQ1?=
 =?utf-8?B?UUJ5NVRHQmhKM1drbG5MbmVDOTA0SVo2SFJkOHFXNk1NZ2R1aUFNeGkwZWlm?=
 =?utf-8?B?dFN6eFRQeDZuMG5ReTZsZllWR0ozbVRjMGpOQUpud1BKWXFpeGd1aGZseG5S?=
 =?utf-8?B?OUFHaitlTS9RM1NlRFdMZFA1OW52cjQzSWlyVjlZSHE3RGQ0ZEo0N2lTL0J3?=
 =?utf-8?B?WXVmQjU3V0k2dlhqaUo0Z08wVXRNOHZSSXIwaXcxNkxkdUJYTGdwcXhRVUha?=
 =?utf-8?B?bDZUODRNMUUwWllVSDY2emVia0h2bFhRWFpwRnBDMk1xYzJBRTJnNUs3REUv?=
 =?utf-8?B?cEZoTkdCUmRNRXNQYVc3ZXV0VW9Nd3ZrQVVtZm1lQjU5Sk9EU1lpbEthT2sy?=
 =?utf-8?B?bmpMUE8zdXp3bTdsTnF4S0ZCSzkxZEV6aHFRWkJQMHpmRFJZcHhCelpmNHo5?=
 =?utf-8?Q?0nF0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ee2dd0-da1d-494a-66be-08dc8f88d370
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 11:21:40.5220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTRJPdmk7X1ejDRGPM2MewiJqbIKH0Kc5SEPXFSwHs8vz9G6FBNP/xZ/RC6WoENhn1BeaZ2Po5bIAd1UD43/sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177
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
Cg0KLS0tLS0tLS0tLS0tLS0tLS0NCkJlc3QgUmVnYXJkcywNClRob21hcw0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hhaSwgVGhvbWFzDQpTZW50OiBUdWVzZGF5LCBKdW5l
IDE4LCAyMDI0IDc6MDkgUE0NClRvOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBMaSwgQ2Fu
ZGljZSA8Q2FuZGljZS5MaUBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5X
YW5nQGFtZC5jb20+OyBZYW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4NClN1Ympl
Y3Q6IFJFOiBbUEFUQ0ggNC81XSBkcm0vYW1kZ3B1OiBhZGQgY29tcGxldGlvbiB0byB3YWl0IGZv
ciByYXMgcmVzZXQgdG8gY29tcGxldGUNCg0KDQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0NCkJlc3Qg
UmVnYXJkcywNClRob21hcw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6
YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXksIEp1bmUgMTgsIDIw
MjQgNjowOSBQTQ0KVG86IENoYWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNvbT47IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgTGksIENhbmRpY2Ug
PENhbmRpY2UuTGlAYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0Bh
bWQuY29tPjsgWWFuZywgU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBS
ZTogW1BBVENIIDQvNV0gZHJtL2FtZGdwdTogYWRkIGNvbXBsZXRpb24gdG8gd2FpdCBmb3IgcmFz
IHJlc2V0IHRvIGNvbXBsZXRlDQoNCg0KDQpPbiA2LzE4LzIwMjQgMTI6MDMgUE0sIFlpUGVuZyBD
aGFpIHdyb3RlOg0KPiBBZGQgY29tcGxldGlvbiB0byB3YWl0IGZvciByYXMgcmVzZXQgdG8gY29t
cGxldGUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlpUGVuZyBDaGFpIDxZaVBlbmcuQ2hhaUBhbWQu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8
IDExICsrKysrKysrKysrDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
aCB8ICAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGluZGV4IDg5ODg4OTYwMDc3
MS4uN2Y4ZTZjYTA3OTU3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5jDQo+IEBAIC0xMjQsNiArMTI0LDggQEAgY29uc3QgY2hhciAqZ2V0X3Jhc19ibG9ja19z
dHIoc3RydWN0IHJhc19jb21tb25faWYNCj4gKnJhc19ibG9jaykNCj4NCj4gICNkZWZpbmUgQU1E
R1BVX1JBU19SRVRJUkVfUEFHRV9JTlRFUlZBTCAxMDAgIC8vbXMNCj4NCj4gKyNkZWZpbmUgTUFY
X1JBU19SRUNPVkVSWV9DT01QTEVUSU9OX1RJTUUgIDEyMDAwMCAvL21zDQo+ICsNCj4gIGVudW0g
YW1kZ3B1X3Jhc19yZXRpcmVfcGFnZV9yZXNlcnZhdGlvbiB7DQo+ICAgICAgIEFNREdQVV9SQVNf
UkVUSVJFX1BBR0VfUkVTRVJWRUQsDQo+ICAgICAgIEFNREdQVV9SQVNfUkVUSVJFX1BBR0VfUEVO
RElORywNCj4gQEAgLTI1MTgsNiArMjUyMCw4IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfZG9f
cmVjb3Zlcnkoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgICAgICAgICAgICAgIGF0b21p
Y19zZXQoJmhpdmUtPnJhc19yZWNvdmVyeSwgMCk7DQo+ICAgICAgICAgICAgICAgYW1kZ3B1X3B1
dF94Z21pX2hpdmUoaGl2ZSk7DQo+ICAgICAgIH0NCj4gKw0KPiArICAgICBjb21wbGV0ZV9hbGwo
JnJhcy0+cmFzX3JlY292ZXJ5X2NvbXBsZXRpb24pOw0KPiAgfQ0KPg0KPiAgLyogYWxsb2MvcmVh
bGxvYyBicHMgYXJyYXkgKi8NCj4gQEAgLTI5MTEsMTAgKzI5MTUsMTYgQEAgc3RhdGljIGludA0K
PiBhbWRncHVfcmFzX3BvaXNvbl9jb25zdW1wdGlvbl9oYW5kbGVyKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LA0KPg0KPiAgICAgICAgICAgICAgIGZsdXNoX2RlbGF5ZWRfd29yaygmY29uLT5w
YWdlX3JldGlyZW1lbnRfZHdvcmspOw0KPg0KPiArICAgICAgICAgICAgIHJlaW5pdF9jb21wbGV0
aW9uKCZjb24tPnJhc19yZWNvdmVyeV9jb21wbGV0aW9uKTsNCj4gKw0KPiAgICAgICAgICAgICAg
IGNvbi0+Z3B1X3Jlc2V0X2ZsYWdzIHw9IHJlc2V0Ow0KPiAgICAgICAgICAgICAgIGFtZGdwdV9y
YXNfcmVzZXRfZ3B1KGFkZXYpOw0KPg0KPiAgICAgICAgICAgICAgICpncHVfcmVzZXQgPSByZXNl
dDsNCj4gKyAgICAgICAgICAgICBpZiAoIXdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmY29u
LT5yYXNfcmVjb3ZlcnlfY29tcGxldGlvbiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbXNlY3NfdG9famlmZmllcyhNQVhfUkFTX1JFQ09WRVJZX0NPTVBMRVRJT05fVElNRSkpKQ0K
PiArICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJXYWl0aW5nIGZvciBH
UFUgdG8gY29tcGxldGUgcmFzIHJlc2V0IHRpbWVvdXQhIHJlc2V0OjB4JXhcbiIsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJlc2V0KTsNCg0KPiBJZiBhIG1vZGUtMSByZXNldCBn
ZXRzIHRvIGV4ZWN1dGUgZmlyc3QgZHVlIHRvIGpvYiB0aW1lb3V0L2h3cyBkZXRlY3QgY2FzZXMg
aW4gcG9pc29uIHRpbWVvdXQsIHRoZW4gdGhlIHJhcyBoYW5kbGVyIHdpbGwgbmV2ZXIgZ2V0IGV4
ZWN1dGVkLg0KPiBXaHkgdGhpcyB3YWl0IGlzIHJlcXVpcmVkPw0KDQo+VGhhbmtzLA0KPkxpam8N
Cg0KW1Rob21hc10gICJbUEFUQ0ggNS81XSBkcm0vYW1kZ3B1OiBhZGQgZ3B1IHJlc2V0IGNoZWNr
IGFuZCBleGNlcHRpb24gaGFuZGxpbmciIGFkZCB0aGUgY2hlY2sgYmVmb3JlIHJhcyBncHUgcmVz
ZXQuDQogICAgICAgICAgICAgICAgUG9pc29uIHJhcyByZXNldCBpcyBkaWZmZXJlbnQgZnJvbSBy
ZXNldCB0cmlnZ2VyZWQgYnkgb3RoZXIgZmF0YWwgZXJyb3JzLCBhbmQgYWxsIHBvaXNvbiBSQVMg
cmVzZXRzIGFyZSB0cmlnZ2VyZWQgZnJvbSBoZXJlLA0KICAgICAgICAgICAgIGluIG9yZGVyIHRv
IGRpc3Rpbmd1aXNoIG90aGVyIGdwdSByZXNldHMgYW5kIGZhY2lsaXRhdGUgc3Vic2VxdWVudCAg
Y29kZSBwcm9jZXNzaW5nLCBzbyBhZGQgd2FpdCBmb3IgZ3B1IHJhcyByZXNldCBoZXJlLg0KDQo+
ICAgICAgIH0NCj4NCj4gICAgICAgcmV0dXJuIDA7DQo+IEBAIC0zMDQxLDYgKzMwNTEsNyBAQCBp
bnQgYW1kZ3B1X3Jhc19yZWNvdmVyeV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0K
PiAgICAgICAgICAgICAgIH0NCj4gICAgICAgfQ0KPg0KPiArICAgICBpbml0X2NvbXBsZXRpb24o
JmNvbi0+cmFzX3JlY292ZXJ5X2NvbXBsZXRpb24pOw0KPiAgICAgICBtdXRleF9pbml0KCZjb24t
PnBhZ2VfcnN2X2xvY2spOw0KPiAgICAgICBJTklUX0tGSUZPKGNvbi0+cG9pc29uX2ZpZm8pOw0K
PiAgICAgICBtdXRleF9pbml0KCZjb24tPnBhZ2VfcmV0aXJlbWVudF9sb2NrKTsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaA0KPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaA0KPiBpbmRleCA5MWRhZjQ4YmUwM2Eu
LmI0N2YwM2VkYWM4NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuaA0KPiBAQCAtNTM3LDYgKzUzNyw3IEBAIHN0cnVjdCBhbWRncHVfcmFzIHsNCj4gICAgICAg
REVDTEFSRV9LRklGTyhwb2lzb25fZmlmbywgc3RydWN0IHJhc19wb2lzb25fbXNnLCAxMjgpOw0K
PiAgICAgICBzdHJ1Y3QgcmFzX2VjY19sb2dfaW5mbyAgdW1jX2VjY19sb2c7DQo+ICAgICAgIHN0
cnVjdCBkZWxheWVkX3dvcmsgcGFnZV9yZXRpcmVtZW50X2R3b3JrOw0KPiArICAgICBzdHJ1Y3Qg
Y29tcGxldGlvbiByYXNfcmVjb3ZlcnlfY29tcGxldGlvbjsNCj4NCj4gICAgICAgLyogRmF0YWwg
ZXJyb3IgZGV0ZWN0ZWQgZmxhZyAqLw0KPiAgICAgICBhdG9taWNfdCBmZWQ7DQo=
