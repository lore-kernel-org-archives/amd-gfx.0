Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464F3D132A6
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 10:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C293F10E025;
	Mon,  4 Nov 2024 10:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V3RNSYGV";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 164A210E025
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 10:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4wm5EScToPPZBr03M10GlHyRsL99+GxGWtJPCuIUOizgDpdLJyyEvQST01alzwG9Tl75wH1yoiq57W383Pt4sdEyaRLr1RXe6SEcWNdOScyDyPhKkDwPOfV3El6IGUaIkLwMnjgF+kXFga4MCDNvnzrbslpRWFb6qpUSd5FbWa590ItxmtMFQaMepnaTSTxbiKajN9+7MgDEcJdiMpVjhjF3LDMgq4x7Tp3JlmgvXLzakXmJ0atSmyC08wfrtPkMtb3EE5JaxTM6tYBDdxlrTU+i4kKW57eU/vWH4aFklK2uK297mVIYNJSohnGr9xk5dgYSY42ww6HLpryjCGOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUoPIX+4hK/1JhCu8QSGJclVKTezfnq2tgSmLftrorQ=;
 b=UMrjQCjFMiGzYfLo8US/+XJ8FaniP39+LYp9fQkCg5pJd/EvzYJfmSmjTv70Bubcl0OaO5tv7wOq2bgOLzV/RG+dvtuomZjf2+dPSyh2R8FkARXkSxK+7c0O/2JOkD3NVdMvIF1EYV+MOcXgo3BCB/AnMIsFPtkySzDxCZaT3jcxzUiGlZLnB/xXAPVaflzaN2mIVZUXqypBFID+V5bULis28vRk3tNM6WtUlsIe01U1vypaCS92INNhERo7S4DmwJgFhYUe5FVxCuydMDpQJKHz8SrzDku5EVuuBRMDwm9zTZyQYaQfFkOX7eubjQuSrDBBXgOrShbjBhYwqDQIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUoPIX+4hK/1JhCu8QSGJclVKTezfnq2tgSmLftrorQ=;
 b=V3RNSYGV/vUD9+GHZFUcZGQzPRg4nx2xJoJftLQ73bCKDJA6hGiFU5BAT9zNg6+/B71J3tXP5AdV+NM97m1U5ov4E87walwkpks2ZoMCLEBpM/E86ACdVuusZH6j773veJ8JeuMZJVtGsrvUw39oP+83j9VX4jozFJ6EAQz9mxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 10:14:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 10:14:38 +0000
Message-ID: <728214a0-4ca6-43bb-b5b3-b3bb464c8751@amd.com>
Date: Mon, 4 Nov 2024 11:14:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: set the right AMDGPU sg segment limitation
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20241104070629.167841-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241104070629.167841-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR4P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 187e109c-02ab-4c7c-233b-08dcfcb97d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2FFcGlLNnZoWmdXaEQ1SUxvV3YycnBaMTlpTFVEWGRtNjArVitYTXZBOU1G?=
 =?utf-8?B?MkpCYzY4dmFuQ1RBZ2M5UWU0a0ZSb2trbUxMV01kUm9yczRhR3lDeForWmVW?=
 =?utf-8?B?SVRGd0w3enFTRVEwaHBWR012SndVUzdJeE9WTDZqTGY3RHMyRW1vdk5sODkw?=
 =?utf-8?B?SklUcnR0WnlIVFVGRGl1NHpiT3p6bTJQTjBnSEpVSUY1c3pRV0NxWjhVdk05?=
 =?utf-8?B?VzRQTFF6VW8vZEIzaVg4UFY3aEh1ZUhndVBpZDE2ZElHakprSjdsSTlCbWxa?=
 =?utf-8?B?ZEdwcExJN2tmMGdhZFVLQzZQcUhhb2h6Zkc1Qk0xNjQvWjRWa2NXVlFWWkVp?=
 =?utf-8?B?cE1OWXpSaUVjKzVYQnpOclZ6eGhCVElPbkxDdS9NaG5QL09pZFFyMWRaM200?=
 =?utf-8?B?aFU2d2FUSkVaYXY4NzNVcHN4QnNURWFWTVlILzZneXRWZjRCc3kzYkM3UlVD?=
 =?utf-8?B?QWhtbG9SNTB6K1p1eEUzLzlpeHF4cmlFa1hybzBnL1lNd2FGUmNGQ0xGeWs5?=
 =?utf-8?B?b1BhS0JEVHk1YmR4TjNwSkI2TWFBcUcxOERhNVliaHd2N01DaE0wcnNqQkpz?=
 =?utf-8?B?OFpZZERDV2VVWXBMMlBUb2pXL1IxcENoajEwdjRjcTJqR29vZDBUbmMzQ2oz?=
 =?utf-8?B?UjBTQUI4OGtVelQ5aHUzS1U0cDhTcWk3emFqcUlDblNmSE9KOC9TWGRXV3Qy?=
 =?utf-8?B?a2tHeCt6L2w2OTFibzg4b0t4Rm8rYUlnR00xS3B6ZHFrcXFMQ2VGQ0NzcjRm?=
 =?utf-8?B?bDVBdFpjQ3BpOVIyKzVJclM1a3lWK2ZzbHltSEw5YTBoSDcweFFtOFpoUG41?=
 =?utf-8?B?SDlLL3k5SldiYmhEOWtFbWo0dUZFcXRZdEJ1cjR0U08ydVhFdVZtWmtlTzNS?=
 =?utf-8?B?SUJPbmU4aTZOMThJbWN1M3ZHYXdlQ25EbUhwUlBpb2pmQTQ0Qk5LcTV5U0x6?=
 =?utf-8?B?bUlMTnpkNyt3UUU0aVBReUJFeHlTbjRtS3ZLZmZLYk9haTkrU2lSSnNQaUZE?=
 =?utf-8?B?WGZQTkdSZ2h1TE0xeWRRenBpOERQSlF4L1FOZVBSeWdNbmpTTXQ5dlVQdTBV?=
 =?utf-8?B?QTVFTDBaeGlKYzNVd1A3NUxOVFZ0YXM0bHYrNVR6a1ZLQkptN2JkYW40Sk16?=
 =?utf-8?B?bDJCT1dJRzZRY1lUa0R0M1J2ZjNnTmo2bTBXWjViOXBQNnpvTTMvdzdrdHhy?=
 =?utf-8?B?NEw4d3A1VHk0VjA3WHZPRVA2ZUZidUR4U2ZSaCtkaUswSnlzRXNqdXJkV2xG?=
 =?utf-8?B?RlNsRmlyTkhqdDFGaUJJSmMyTWdORkRTbFp3cTZRUkhVampBY1dsMjk0ZU0v?=
 =?utf-8?B?MGZua0RrbENWWWpWM1JpdFdQMzhXZVJDKys1djhHSE1jTngyOEhIRFpPRWNO?=
 =?utf-8?B?RFYrYmRaTnhqMFhBQzY1QjEvdmhTNkdVanhjVlFFaXZ1ay9YbDI1Vk4reGJk?=
 =?utf-8?B?K3V1aWhvdDIzMFhvM01Gd1Y4ZmZBSTd4enVvaDQwZnFaNmhLdlI5QUlMSW40?=
 =?utf-8?B?eEFKaVd2YlNaNjY2UVdUY2dhWGJYWDRQUVVmWVAvY0R6ZEFnRmN5QnNLUy9a?=
 =?utf-8?B?VGFJVHhQY0dPVVBpK3l3V1JMVnJ1WnFEbXZBTWQ3YXl1Rjhmd3FvL1hqTFhG?=
 =?utf-8?B?QXI5S2RMbUFid2I2KzJaWkd4eXVOYmtPcGk1Q09lQUJtbGZpZ3J6bklpK0Ev?=
 =?utf-8?B?WGdpWWx1Y2hmOU5ITWlWa3RPVzc1THJkNVZOZXFBclUxRzlaNEVpVmpWd2x5?=
 =?utf-8?Q?okVP4FJlqo1ZvNCQs4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk1qVDhZV2xXYmhGUHZmQ0VKbW1LS2xpNklNeG1YVW5pR3RzQUFwZ2Q1ZC9B?=
 =?utf-8?B?RXBIb2tjMTc4enI2dGJnU0pOak9VUEZScnJCOHoxU2RMVlJpVjRUNXB1TlRW?=
 =?utf-8?B?ZjdRcWxaTEhWN1VrQXNUR0o4d015aCtwYTdjcFNNOUt2b3A0ZVBXUjJuVjEz?=
 =?utf-8?B?SE5uVkJTdzJWK3JQN2hHamJBYlU4Sjl0OFhlOFUrN1hwYVUyZWVZaUZiTzFY?=
 =?utf-8?B?MWt1MW9hUytiaFg2eWRuM1BlMVpPZk9idEk3ZEMyZ3hGaEdQbzdLZlZST1k3?=
 =?utf-8?B?YWdUMEZiRy8vV2tTVGRJK01LdWx1b2RNanh5dzN2UzlIY25jRk1zMTBuQTlX?=
 =?utf-8?B?RnhJMkhZd3BKaUlXdzhINWp4eW9iVDRiT2tsTE1jYWZOV2ZhVmpLcmRrQ3VS?=
 =?utf-8?B?SVdJTHFRR1hPMmVFSmhOMzNmSE5QQXRlelRHS3ZLWkk1eDVMNStpLzQwZFFU?=
 =?utf-8?B?OVFSVUdRR0YvY3B2OFVsK0thVVJacVhnNHpBQk8vd2pTTXNtU0pPK3ViaVRV?=
 =?utf-8?B?UWE5TmJLbTk1T2NuYzF3TU1YT0pSZktWU3BzaHZhU0YrcVU4c2t1L0dMektI?=
 =?utf-8?B?OVRoSjFCbHFIWUZES2hnVFl6VFpwdHB0cE03WVJNM1ZyZjZKNEVTMHV1TGJ3?=
 =?utf-8?B?S08vdWh2bjVJdjJBSnBya0RSSUxsQkRwN1JvN1EzTDNydmZISHd5TGc4WkF0?=
 =?utf-8?B?c1lGMFVGM1QxdCtCTmVuMUU3K1d6VW5XYlpyNk9sVHQwdndBVUQzVVVpQUIw?=
 =?utf-8?B?ZDNDcDJVUmFZbUMxZ3EzdUFWVjlMZVZHMjk4VHJYUXlVWDY1RjNsUUNja2tv?=
 =?utf-8?B?TWdMSmx3dmxZRXU0SXJ0amc3MWM0N0pDTS9QNFYrN0JvYzdVcHFZZ2ZPc29j?=
 =?utf-8?B?ZUdUQXBta0RXNGFzczAyVVhDL1ZEME15QkFNSWNrOHk0WUx4TGxBQi81bDhk?=
 =?utf-8?B?Y3krcFhkQW9mV1NIWWFPdUZYK3p3a1g3ZHB6NkYzTnZqcDN6TXIxOGFSWkpV?=
 =?utf-8?B?U09CMUhFajdlb0VtOEp0R1RneE9CUEt2UTk3ZUNWVkdSelEvbUNzdE9sNG0r?=
 =?utf-8?B?bnZaU3Jkb1U5MGxqSGNrRUw5amZkTzc2R2ZBcjRUYVRyZXVLQ1U3ZVc0aUdK?=
 =?utf-8?B?V1N5Nm9iTkNNK0ErdFpXM0Y5MnhIaUlpY3M1ZXF0UGNFdm44YTNxM1lzL3pI?=
 =?utf-8?B?bzd4VU5lVVl0THk4aUY3T0pqejRmNVV6Tm5KZW9IR2pSN2IxVTJ6K2dieStz?=
 =?utf-8?B?WkFPM25INkg0dGl0eXRJMDRsaFFoVVJBaFFtWUVBSTBQYWQzb2NFcXlJWXFL?=
 =?utf-8?B?OFcrQndqZXRBSG00YVNQRVhKMmRUSmh6Vjh5UXpLTU52R2czOENnNzJObWRa?=
 =?utf-8?B?L25EUGg2U0kxSnFTdVFwclNydzUzWHZXSHk4dXZ0Y3RRR2tqSXJqVEVmaGRx?=
 =?utf-8?B?eEFsSkpFNzA5WXpCTk1RYm5nQmNzN05jM3MvS25tdlpqSVRCN1RVdHA5RnJs?=
 =?utf-8?B?Q3R6UGRvb0FIN2pTZGNHVnRKS1JuTDNKUzY4Qk0rbGJaMDlHTDJzQnJVOVNy?=
 =?utf-8?B?MjNNUU8wNnlPbGRyeWE2MDlWNEk3YTFqWnEwYk9KcjlKTjlQeHV5L1pETkxX?=
 =?utf-8?B?ZVFHVnFSdHBXdTZhNFJHK2txcTBmY0lUdi9oVnVLSEVGbktVWjRyeVkvQmdE?=
 =?utf-8?B?Nnk0dFFSYkp2bmgxVER6QXE5R0lRdzJDYUNYZCtrZGN3UnhIYlZyYytma3ho?=
 =?utf-8?B?cXhLb1lreGh0aUVsZUxxWktodlI5ZVJpcG9qM3k3YktnbTRaZ3VzMHNRUjdJ?=
 =?utf-8?B?SzUyaWVDYmovWWJvSDVxcEIwQTlWMWZZUnFqa09KRElTUnhOMVdFSlhPd0sr?=
 =?utf-8?B?bm13MlZIcFRUZFVrelRrVjN3ZUV2cmVQRVorajRYR3lHOFBtRG0wcFJ4SHpD?=
 =?utf-8?B?WXNPd1BZMW9rMTlPWDJ6V2dCdUd4ejN3S214OEVTMzNidjYrQUp0a0Z4N2gv?=
 =?utf-8?B?ZWs1Sm1Qdlo2dVFEVGc3cUpzZEdoWWNKRTI3STRTLzJOemdBN1JKNFcwWkxy?=
 =?utf-8?B?bEV5RUZqb0wxZ2lZakxMaEszK3VGendtWE5IV1VNQmR5Y202bzM3eW5LZGNS?=
 =?utf-8?Q?HYpU5vPX2N12WAjSHo1M8lJeW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187e109c-02ab-4c7c-233b-08dcfcb97d24
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 10:14:38.0920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQZLg1RDv8grUf4uQNFky3L7zbDqzi+fxrmAcbfPT0OkZzN/PIyIXQ415m77Priu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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

QW0gMDQuMTEuMjQgdW0gMDg6MDYgc2NocmllYiBQcmlrZSBMaWFuZzoNCj4gVGhlIGRyaXZlciBu
ZWVkcyB0byBzZXQgdGhlIGNvcnJlY3QgbWF4X3NlZ21lbnRfc2l6ZTsNCj4gb3RoZXJ3aXNlIGRl
YnVnX2RtYV9tYXBfc2coKSB3aWxsIGNvbXBsYWluIGFib3V0IHRoZQ0KPiBvdmVyLW1hcHBpbmcg
b2YgdGhlIEFNREdQVSBzZyBsZW5ndGggYXMgZm9sbG93aW5nOg0KPg0KPiBXQVJOSU5HOiBDUFU6
IDYgUElEOiAxOTY0IGF0IGtlcm5lbC9kbWEvZGVidWcuYzoxMTc4IGRlYnVnX2RtYV9tYXBfc2cr
MHgyZGMvMHgzNzANCj4gWyAgMzY0LjA0OTQ0NF0gTW9kdWxlcyBsaW5rZWQgaW46IHZldGggYW1k
Z3B1KE9FKSBhbWR4Y3AgZHJtX2V4ZWMgZ3B1X3NjaGVkIGRybV9idWRkeSBkcm1fdHRtX2hlbHBl
ciB0dG0oT0UpIGRybV9zdWJhbGxvY19oZWxwZXIgZHJtX2Rpc3BsYXlfaGVscGVyIGRybV9rbXNf
aGVscGVyIGkyY19hbGdvX2JpdCBycGNzZWNfZ3NzX2tyYjUgYXV0aF9ycGNnc3MgbmZzdjQgbmZz
IGxvY2tkIGdyYWNlIG5ldGZzIHh0X2Nvbm50cmFjayB4dF9NQVNRVUVSQURFIG5mX2Nvbm50cmFj
a19uZXRsaW5rIHhmcm1fdXNlciB4ZnJtX2FsZ28gaXB0YWJsZV9uYXQgeHRfYWRkcnR5cGUgaXB0
YWJsZV9maWx0ZXIgYnJfbmV0ZmlsdGVyIG52bWVfZmFicmljcyBvdmVybGF5IG5mbmV0bGlua19j
dHRpbWVvdXQgbmZuZXRsaW5rIG9wZW52c3dpdGNoIG5zaCBuZl9jb25uY291bnQgbmZfbmF0IG5m
X2Nvbm50cmFjayBuZl9kZWZyYWdfaXB2NiBuZl9kZWZyYWdfaXB2NCBsaWJjcmMzMmMgYnJpZGdl
IHN0cCBsbGMgYW1kX2F0bCBpbnRlbF9yYXBsX21zciBpbnRlbF9yYXBsX2NvbW1vbiBzdW5ycGMg
c2NoX2ZxX2NvZGVsIHNuZF9oZGFfY29kZWNfcmVhbHRlayBzbmRfaGRhX2NvZGVjX2dlbmVyaWMg
c25kX2hkYV9zY29kZWNfY29tcG9uZW50IHNuZF9oZGFfY29kZWNfaGRtaSBzbmRfaGRhX2ludGVs
IHNuZF9pbnRlbF9kc3BjZmcgZWRhY19tY2VfYW1kIGJpbmZtdF9taXNjIHNuZF9oZGFfY29kZWMg
c25kX3BjaV9hY3A2eCBzbmRfaGRhX2NvcmUgc25kX2FjcF9jb25maWcgc25kX2h3ZGVwIHNuZF9z
b2NfYWNwaSBrdm1fYW1kIHNuZF9wY20ga3ZtIHNuZF9zZXFfbWlkaSBzbmRfc2VxX21pZGlfZXZl
bnQgY3JjdDEwZGlmX3BjbG11bCBnaGFzaF9jbG11bG5pX2ludGVsIHNoYTUxMl9zc3NlMyBzbmRf
cmF3bWlkaSBzaGEyNTZfc3NzZTMgc2hhMV9zc3NlMyBhZXNuaV9pbnRlbCBzbmRfc2VxIG5sc19p
c284ODU5XzEgY3J5cHRvX3NpbWQgc25kX3NlcV9kZXZpY2UgY3J5cHRkIHNuZF90aW1lciByYXBs
IGlucHV0X2xlZHMgc25kDQo+IFsgIDM2NC4wNDk1MzJdICBpcG1pX2RldmludGYgd21pX2Jtb2Yg
Y2NwIHNlcmlvX3JhdyBrMTB0ZW1wIHNwNTEwMF90Y28gc291bmRjb3JlIGlwbWlfbXNnaGFuZGxl
ciBjbTMyMTgxIGluZHVzdHJpYWxpbyBtYWNfaGlkIG1zciBwYXJwb3J0X3BjIHBwZGV2IGxwIHBh
cnBvcnQgZHJtIGVmaV9wc3RvcmUgaXBfdGFibGVzIHhfdGFibGVzIHBjaV9zdHViIGNyYzMyX3Bj
bG11bCBudm1lIGFoY2kgbGliYWhjaSBpMmNfcGlpeDQgcjgxNjkgbnZtZV9jb3JlIGkyY19kZXNp
Z253YXJlX3BjaSByZWFsdGVrIGkyY19jY2d4X3Vjc2kgdmlkZW8gd21pIGhpZF9nZW5lcmljIGNk
Y19ldGhlciB1c2JuZXQgdXNiaGlkIGhpZCByODE1MiBtaWkNCj4gWyAgMzY0LjA0OTU3Nl0gQ1BV
OiA2IFBJRDogMTk2NCBDb21tOiByb2NtaW5mbyBUYWludGVkOiBHICAgICAgICAgICBPRSAgICAg
IDYuMTAuMC1jdXN0b20gIzQ5Mg0KPiBbICAzNjQuMDQ5NTc5XSBIYXJkd2FyZSBuYW1lOiBBTUQg
TWFqb2xpY2EtUk4vTWFqb2xpY2EtUk4sIEJJT1MgUk1KMTAwOUEgMDYvMTMvMjAyMQ0KPiBbICAz
NjQuMDQ5NTgyXSBSSVA6IDAwMTA6ZGVidWdfZG1hX21hcF9zZysweDJkYy8weDM3MA0KPiBbICAz
NjQuMDQ5NTg1XSBDb2RlOiA4OSA0ZCBiOCBlOCAzNiBiMSA4NiAwMCA4YiA0ZCBiOCA0OCA4YiA1
NSBiMCA0NCA4YiA0NSBhOCA0YyA4YiA0ZCBhMCA0OCA4OSBjNiA0OCBjNyBjNyAwMCA0YiA3NCBi
YyA0YyA4OSA0ZCBiOCBlOCBiNCA3MyBmMyBmZiA8MGY+IDBiIDRjIDhiIDRkIGI4IDhiIDE1IGM4
IDJjIGI4IDAxIDg1IGQyIDBmIDg1IGVlIGZkIGZmIGZmIDhiIDA1DQo+IFsgIDM2NC4wNDk1ODhd
IFJTUDogMDAxODpmZmZmOWNhNjAwYjU3YWMwIEVGTEFHUzogMDAwMTAyODYNCj4gWyAgMzY0LjA0
OTU5MF0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZmZjg4YjdjMTMyYjBjOCBSQ1g6IDAw
MDAwMDAwMDAwMDAwMjcNCj4gWyAgMzY0LjA0OTU5Ml0gUkRYOiBmZmZmODhiYjBmNTIxNjg4IFJT
STogMDAwMDAwMDAwMDAwMDAwMSBSREk6IGZmZmY4OGJiMGY1MjE2ODANCj4gWyAgMzY0LjA0OTU5
NF0gUkJQOiBmZmZmOWNhNjAwYjU3YjIwIFIwODogMDAwMDAwMDAwMDAwMDA2ZiBSMDk6IGZmZmY5
Y2E2MDBiNTc5MzANCj4gWyAgMzY0LjA0OTU5Nl0gUjEwOiBmZmZmOWNhNjAwYjU3OTI4IFIxMTog
ZmZmZmZmZmZiY2I0NjMyOCBSMTI6IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgMzY0LjA0OTU5N10g
UjEzOiAwMDAwMDAwMDAwMDAwMDAxIFIxNDogZmZmZjg4YjdjMTljMDcwMCBSMTU6IGZmZmY4OGI3
YzkwNTk4MDANCj4gWyAgMzY0LjA0OTU5OV0gRlM6ICAwMDAwN2ZiMmQzNTE2ZTgwKDAwMDApIEdT
OmZmZmY4OGJiMGY1MDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPiBbICAzNjQu
MDQ5NjAxXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMz
DQo+IFsgIDM2NC4wNDk2MDNdIENSMjogMDAwMDU1NjEwYmQwMzU5OCBDUjM6IDAwMDAwMDAxMDQ5
ZjYwMDAgQ1I0OiAwMDAwMDAwMDAwMzUwZWYwDQo+IFsgIDM2NC4wNDk2MDVdIENhbGwgVHJhY2U6
DQo+IFsgIDM2NC4wNDk2MDddICA8VEFTSz4NCj4gWyAgMzY0LjA0OTYwOV0gID8gc2hvd19yZWdz
KzB4NmQvMHg4MA0KPiBbICAzNjQuMDQ5NjE0XSAgPyBfX3dhcm4rMHg4Yy8weDE0MA0KPiBbICAz
NjQuMDQ5NjE4XSAgPyBkZWJ1Z19kbWFfbWFwX3NnKzB4MmRjLzB4MzcwDQo+IFsgIDM2NC4wNDk2
MjFdICA/IHJlcG9ydF9idWcrMHgxOTMvMHgxYTANCj4gWyAgMzY0LjA0OTYyN10gID8gaGFuZGxl
X2J1ZysweDQ2LzB4ODANCj4gWyAgMzY0LjA0OTYzMV0gID8gZXhjX2ludmFsaWRfb3ArMHgxZC8w
eDgwDQo+IFsgIDM2NC4wNDk2MzVdICA/IGFzbV9leGNfaW52YWxpZF9vcCsweDFmLzB4MzANCj4g
WyAgMzY0LjA0OTY0Ml0gID8gZGVidWdfZG1hX21hcF9zZysweDJkYy8weDM3MA0KPiBbICAzNjQu
MDQ5NjQ3XSAgX19kbWFfbWFwX3NnX2F0dHJzKzB4OTAvMHhlMA0KPiBbICAzNjQuMDQ5NjUxXSAg
ZG1hX21hcF9zZ3RhYmxlKzB4MjUvMHg0MA0KPiBbICAzNjQuMDQ5NjU0XSAgYW1kZ3B1X2JvX21v
dmUrMHg1OWEvMHg4NTAgW2FtZGdwdV0NCj4gWyAgMzY0LjA0OTkzNV0gID8gc3Jzb19yZXR1cm5f
dGh1bmsrMHg1LzB4NWYNCj4gWyAgMzY0LjA0OTkzOV0gID8gYW1kZ3B1X3R0bV90dF9wb3B1bGF0
ZSsweDVkLzB4YzAgW2FtZGdwdV0NCj4gWyAgMzY0LjA1MDA5NV0gIHR0bV9ib19oYW5kbGVfbW92
ZV9tZW0rMHhjMy8weDE4MCBbdHRtXQ0KPiBbICAzNjQuMDUwMTAzXSAgdHRtX2JvX3ZhbGlkYXRl
KzB4YzEvMHgxNjAgW3R0bV0NCj4gWyAgMzY0LjA1MDEwOF0gID8gYW1kZ3B1X3R0bV90dF9nZXRf
dXNlcl9wYWdlcysweGU1LzB4MWIwIFthbWRncHVdDQo+IFsgIDM2NC4wNTAyNjNdICBhbWRncHVf
YW1ka2ZkX2dwdXZtX2FsbG9jX21lbW9yeV9vZl9ncHUrMHhhMTIvMHhjOTAgW2FtZGdwdV0NCj4g
WyAgMzY0LjA1MDQ3M10gIGtmZF9pb2N0bF9hbGxvY19tZW1vcnlfb2ZfZ3B1KzB4MTZiLzB4M2Iw
IFthbWRncHVdDQo+IFsgIDM2NC4wNTA2ODBdICBrZmRfaW9jdGwrMHgzYzIvMHg1MzAgW2FtZGdw
dV0NCj4gWyAgMzY0LjA1MDg2Nl0gID8gX19wZnhfa2ZkX2lvY3RsX2FsbG9jX21lbW9yeV9vZl9n
cHUrMHgxMC8weDEwIFthbWRncHVdDQo+IFsgIDM2NC4wNTEwNTRdICA/IHNyc29fcmV0dXJuX3Ro
dW5rKzB4NS8weDVmDQo+IFsgIDM2NC4wNTEwNTddICA/IHRvbW95b19maWxlX2lvY3RsKzB4MjAv
MHgzMA0KPiBbICAzNjQuMDUxMDYzXSAgX194NjRfc3lzX2lvY3RsKzB4OWMvMHhkMA0KPiBbICAz
NjQuMDUxMDY4XSAgeDY0X3N5c19jYWxsKzB4MTIxOS8weDIwZDANCj4gWyAgMzY0LjA1MTA3M10g
IGRvX3N5c2NhbGxfNjQrMHg1MS8weDEyMA0KPiBbICAzNjQuMDUxMDc3XSAgZW50cnlfU1lTQ0FM
TF82NF9hZnRlcl9od2ZyYW1lKzB4NzYvMHg3ZQ0KPiBbICAzNjQuMDUxMDgxXSBSSVA6IDAwMzM6
MHg3ZmIyZDJmMWE5NGYNCj4NCj4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxp
YW5nQGFtZC5jb20+DQoNClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3R0bS5jIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gaW5kZXggMDYzNzQx
NGZjNzBlLi45ZjkyMmVjNTBlYTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90dG0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMNCj4gQEAgLTE4NTEsNiArMTg1MSw3IEBAIGludCBhbWRncHVfdHRtX2luaXQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgDQo+ICAgCW11dGV4X2luaXQoJmFkZXYt
Pm1tYW4uZ3R0X3dpbmRvd19sb2NrKTsNCj4gICANCj4gKwlkbWFfc2V0X21heF9zZWdfc2l6ZShh
ZGV2LT5kZXYsIFVJTlRfTUFYKTsNCj4gICAJLyogTm8gb3RoZXJzIHVzZXIgb2YgYWRkcmVzcyBz
cGFjZSBzbyBzZXQgaXQgdG8gMCAqLw0KPiAgIAlyID0gdHRtX2RldmljZV9pbml0KCZhZGV2LT5t
bWFuLmJkZXYsICZhbWRncHVfYm9fZHJpdmVyLCBhZGV2LT5kZXYsDQo+ICAgCQkJICAgICAgIGFk
ZXZfdG9fZHJtKGFkZXYpLT5hbm9uX2lub2RlLT5pX21hcHBpbmcsDQoNCg==
