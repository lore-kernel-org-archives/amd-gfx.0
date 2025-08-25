Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F784CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 13:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1286D10E4A8;
	Mon, 25 Aug 2025 13:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FgFmxArp";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26AFC10E48F
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 13:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdDhzT24LMS//CY0CTptEujfSXQV1pB4NVxMAbcoFPdw+qHs/qo27Da+xl0enizvxD3YgxNRteN81eam84ArdZa6y32T7Y6bIeL5fQtvJuyOr2oy3A3bsJeDTFCesOSmLUEzCw4TCU5m+0dtyOJLXODIrUOVP/SsqPmmkOYb34brUNKF5vpTijv3JA8QI2Zt3HQI2lRvmc/NtrUprTplQ53/SI3IjdlNwH2fvAmhutYumbCwDQeOnUl/ODIw67g5lUY1zZdffOm8mrKkLX8iQ2oa2xe3ivtUhjIjAdgAz7jxd0yaPYBw18W88/wOBai+InnDpQkLRoLkZk2UhDAsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cmu/jp1k/EyzMS5uC2A5aqOz8foTPyEJhGhH6fRO7M=;
 b=Mln389U+x9NdBVrt6nLDfpKvk7OUwa0W2ue3rdo2wqpqBU88/dkcw0OeX8xyYC/I7wMthM4NN+1ne9MRgtmtGfurgH9p/NgXj8Kyi3NI0JKT0LaSerXH0CUQP20EMIQ69cXDJmAfv/+UpNuhW7M2kGet965d2GTeDcVuchJGsGwAqg0ToZ/ifbCTG0nlMX7QA0Hxd7/G6Z3J6vE3DOT//tdAqHzgMjK2Fm2NT3XAE6lmUH1Dlwlp3p/onAgN2/b1e03h4lRe4gp3CxbYpoH9Q4eQcMiwhrKbHaSE6zeGCDCV9FcoGTEOyMHnI0e9+cp99/oQQ/Ez9g/rqRex6myEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cmu/jp1k/EyzMS5uC2A5aqOz8foTPyEJhGhH6fRO7M=;
 b=FgFmxArpSursm1k3oh94a1ifffABa1Jt6KxPi/7HqSj/KGmfHkTRtqYUyd7mXoPwjZa4LsTseZZSAMim3yDVp9BvVgCBXjEy3cbXIsH03lQyZfbmO4BKR765TsygtBfxemUY7GIfgmA4P4ulyqbPHx6DlycyJ9EJkE7/sfvDI/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 13:45:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 13:45:16 +0000
Message-ID: <7755bf44-de37-459d-bbf2-882e5fa4732d@amd.com>
Date: Mon, 25 Aug 2025 15:44:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 3/4] drm/amdgpu: Add mapping info option for GEM_OP
 ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250822194749.362771-1-David.Francis@amd.com>
 <20250822194749.362771-4-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250822194749.362771-4-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: f87738d8-0ecd-4c01-4d78-08dde3dd9f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG1FNTRHQVZnTjdXcnBwMG54V0VYTE4xL1BiTDgrV3g3WXIwNjQ4blV6WDVI?=
 =?utf-8?B?UGlLbUhndFU2TksxVTY2TDBCQWh0NlBjZEIySEljV0lpTXh0bGRueDJiMWF6?=
 =?utf-8?B?T0NOMkNoYms1RzBBbEpUbCtGSWFIaGthcERweWpqR0cwRmd4aG1SSjliYXZW?=
 =?utf-8?B?QlRNKzgzalJZV3FBTnhVeE9HZm13b1dhbURlSFFycThNYU01MmM4ZFpYNEtR?=
 =?utf-8?B?TzdDRlprWTJ3OVVKcFEwcEdiZGRzdGZmczNKcWo1aW5RTE43SU1LQXY3VC9x?=
 =?utf-8?B?ZkhnQWV4ZkFRL01ZQ3U4YmJ2VGNDWjk4L0E2ajJ1QWIvZG5VR0FHTGdNTmxp?=
 =?utf-8?B?bis1NlV1NnpraVpXQjdyQjhlSWdVQk5rSExoNmF0bWUyZ1IrdEt0MW9USStW?=
 =?utf-8?B?bHlYT3pNN0w2ZFc0NDhEK2lGbVlsbTUwenVOVnBIZ1lqTVRxZ3JkRWIwSEE3?=
 =?utf-8?B?REJXam1yaHFFU2g2R2haSWpHY05MV01TenY3ekovTDF4V0dRTlBsSFkwcW1X?=
 =?utf-8?B?bGlJOXlOK0ZYd2ZIWWtmLzhFcWRTZk5JV1R0TEdIYjV0L2VRa1E3UW96Z0FV?=
 =?utf-8?B?OWs0bEcyRExsV0xMeUY3bnZWRWhkNklHb2M3a3Q4dnp1OHVRRmVYTDVmSkI3?=
 =?utf-8?B?RHp3U2ptZFhuT2tVZFV5VE9EUGFBd1JnL0JRN0w5eUlkOU1nTDFNa2RRcC9x?=
 =?utf-8?B?cEU4L0pwRzhNQmkyQWNjcDRJU2JMeVR5MU1lMk9xdWFZeXJXbjI4c0F0VUZw?=
 =?utf-8?B?OGR3cGl0S3RVMmFXd1dlQlg2VDlURGkxNFhGUCtuK3p0a0dBeEFPZ3pSVWN4?=
 =?utf-8?B?N3BFUExBbmpsZHAzYzRDSitqekRnckVSdWNTeStPU3hHZkNaUmhSYzJoVEl4?=
 =?utf-8?B?ZnBpVXc0Y0ZBTWNicEUwcjhETnFZdFZ1RVlyU08vQXQvV2hQT0s0RkMzVFhq?=
 =?utf-8?B?VXNBdWRxSFFNTDUyUXNlM0VDRnZxeFpncTFjOGVGUUdCY1NoT3U0U29ra3Uz?=
 =?utf-8?B?eC96eEs1T1Rucis0RnllNm02Qk5mMWIydGh5dHVEemNiTURvMU9NZFBlR0JD?=
 =?utf-8?B?SW1pMzl3ZjhkQnN4WXU3OGxMZEJQb3k0S1VUTldCdDU1V0pqQXBJKzZrM3hU?=
 =?utf-8?B?SzB6ejhReEtxV2FXZE5jT2pFK3RuMklmd3FESExXQWFXanZocUFOWWU0OGt3?=
 =?utf-8?B?ME5hTmdKSFNXNStQZWgweWJoQWExNmZmbjRkdG5YZHZ0L0k0VlpEYVoveEZm?=
 =?utf-8?B?cit0czVGa3ZUd0Y4V29HOFFRY2FwZUVRUXhFK3p1dVpGa2xHSmpMckxFcFJs?=
 =?utf-8?B?UDZRK2x0NXFsV21Rb0FycGxGYWJVakt1QlVHK05XY3RSVEZXTGFIdzBVRmx4?=
 =?utf-8?B?UnZFb1VHVGlrcUhYUTRUak8wV0Y0cng4M3hDUDFTNGpXVGE2S055VllDNGda?=
 =?utf-8?B?VnU1RG9zbmdyT1ZsN0dzckhYY01TY1hmMm15ZFBJZWo5OFlyNjZMQmRoL21L?=
 =?utf-8?B?M040MHlyVHZPTlhaell5VjFtUlpHdkgwaGJTV1FMNDlacEZXb0VnOVN2d0Y4?=
 =?utf-8?B?WmQwTExBZ3A5TEFlZzJmTkU1amQ4blZiSjQyYVJMbWlUcHpraVpjeXloazdH?=
 =?utf-8?B?UjdIMGM4NHNaTGVXQjY3VkZYeHhjdlF6YUEzdCt0SlUyL1VqMDZkYVpoZ01R?=
 =?utf-8?B?Y0NsVEV4NHQ2b1pUTzdRazRTaXZGcWJ1YjYxbkV1bzBZQWJtTkhZdXJ4MHQ5?=
 =?utf-8?B?NEljaTNwaVE3NTJBUGsvY2hMUzRJZnA3QkVvR3dsUm95bFRtcTNnY0RjeG5L?=
 =?utf-8?B?bjZpNDlyOFdiT0RpTzkyNmFhZ1I0L0dpUE1HeW40NzB0R3QyOHRIMXl3R1ZS?=
 =?utf-8?B?bzBNOXpneE1Pb3VYNDM0MVFWZStMWkFGM2tzR0QvcGFRU3JLcVl3TnUrN2lh?=
 =?utf-8?Q?BG5cLYPAWvk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUtYTVlVa05SOGJwaWhwZXllUzRQcTFFRHV3a25Rc0MzZWg2UFR3bXhwR2sy?=
 =?utf-8?B?bGJoR2NCRGxRMDVWcEhCd2l5MjkrSDJBRUdrUzNFUHVRQWp5a3o3UHB4RUw0?=
 =?utf-8?B?Q3huL24rMUZIOW9FczZibTMyTDNYUXpNbkVPQUpRQytUTHp4S3E3Z0NPUURS?=
 =?utf-8?B?OG1hTHd1YTZSM3RtalkzZmV4SW53SDl1REJTeTBqdkZza3JGZ2taTThLSWVn?=
 =?utf-8?B?MGlnVmI5M2ZqcW1hQ1FMYUkvcy9xbVViT2s0dENuWVJGWXp6Nmw5MUwyWk5M?=
 =?utf-8?B?NGFLekdyN3B6Rnl1bmw2RlZXcEdFZzJDS3BVelBQakQxSjhNYVFjdzJhYnhD?=
 =?utf-8?B?S2tLLzlHWEViNzVqWjgrM1VLeE9BU0RpbjMvU0NDbFprWjZHVFRaczhnbUl4?=
 =?utf-8?B?MGZORFlzakxWcHc3aG05bXdMTSs4bUVwMDNqWElSeHl4ZmJrQWpRR29ONE1W?=
 =?utf-8?B?YkVMc2N6ZFZvUkJyQkNDMVovZHNjSXg3aFB5R3o5VVd6UmtCVUN5dTBwQ0gx?=
 =?utf-8?B?WStEMUViWXZlYm4vMVJ2cU1UYS9yUlVRNEZ4VEtEeXVXcS94MEtlbndManRR?=
 =?utf-8?B?c2laNzRVa2ZCRXRqV3c3WDBleG9acEM2OUw5WWZ5ZHhoWnlrcVh3cnhHeUJ4?=
 =?utf-8?B?WlVoS1pHV3g5OEZnZ0ZjTW5zOTBiemIrQWgzdzBCVE9ZeURDVnhrRmpoMmRj?=
 =?utf-8?B?OGx3U2xmejdHYzNSa2srSGhmUnFiRng3cVRaenMrQ1l1QnFyNFdSL3o3aGpX?=
 =?utf-8?B?UUMzVlpJVkxqcVk4bG9YN1lYYlFCRXdBM1JEMURxWnNHVmpWLzlOMkZ2UllH?=
 =?utf-8?B?RWg4S3Vyd3BWZmVxZzE0MWdRbTMyOHJhOXl2VXBETjZiTUJ2aFBkL3M3VVBG?=
 =?utf-8?B?NmNHakxGL2ZiNnlwaWtkdEtIZ2Rib3R2ejZKS0hjYkErWVM1WUg4ZEhNeWhT?=
 =?utf-8?B?WDIzV3ZSeXFqeGxGS0JNd3VKSmhEYnNlZmdzbHY1dm96RlpGYlhlcC9UeS9r?=
 =?utf-8?B?VVFobEg2aHlLVU0vSWdhNlR1OFdZWTYvR1ZVV09yTkdtOVIyb21Db2ZuM1hn?=
 =?utf-8?B?bXlQQXpRVGJUOWoyeXpZSHNOSVc2Mzd4cmhIdFZGbWZsMnJQN0lrc2FKYllT?=
 =?utf-8?B?VUJiSW9sVjNkb2g0aUVmM2RuMkc0R05kdGxiaWxoMXU5OEVmbjI3OWNDNnJs?=
 =?utf-8?B?T2tocEROamxqTDdmbTI3bksxVVd0dVZRN3piWnV0ZmNzUURSMjNVTkJ1TFJE?=
 =?utf-8?B?bmNIK21uOXd4eFdrejJOd2ZxYUJKcTB2V1owVnovNDV2REw1ZTcrZVVSR1Nv?=
 =?utf-8?B?UWVNc2s0dm9HUHJBY01maFlUdEExQmRqbVFqL0pqRjVCSUpNMzhIWXB1THNK?=
 =?utf-8?B?WE11eitxUG44SUhNd0J4b3F1SmM2SEQvQ0phT0V4eWdTbS9FYlRVMVBwS0s3?=
 =?utf-8?B?U05Neld0ZkUwWXpjNzZMSndMOFp0TTN1eUJVblZ1TFVqSGYwZWN5ME0vbkNH?=
 =?utf-8?B?UDdESDI3MDVuQkhqU1MxR2daYWxEM1VJV1hJV3ZRMG5UaEpjM2hlbXoyYlpG?=
 =?utf-8?B?NHZzU1F5aVhGU1d0WTVqMDB3TS9CeWNmQ0Naek94SXVycXBXZUR2QSt2NUNL?=
 =?utf-8?B?a3BMRzJqRVRnMnVGclQxbFBZZDRpZHpZOVhNbzdYTHZUdkNqTzdDWmFndnZP?=
 =?utf-8?B?bkdNZnJWSVdKdC95WE1OdmJWSUpXRUhoTXFaRWY4OHVLcFFGWWlEdGMzUWIv?=
 =?utf-8?B?S0M0eUZIaTBUMFFZZ0g5cDZVUzg4NC9oRTliaHA4QUhqM25naE15WUtWc2ZR?=
 =?utf-8?B?WE9rS1YvVnN0NCtuRW00OFFDOGFYZGg4MDlQbmlvN1dmcWhBNkdNTXpma1JT?=
 =?utf-8?B?c0lSdlpxS3BqUlUvWFlwbEt5eElzZXMzN2gwOE5BRTJvR2VoWUVNSXBTWWJy?=
 =?utf-8?B?b0cvUm9xb0lqUVlFZFZvS0hmS0NwaHFBcjdLbmVzbEJydXVvblRGZ0JvVGEw?=
 =?utf-8?B?cGkzVFpYVE9rRE1leVAxV3pmbmJiV3FPNHh3TmluaEo3anNJVkxOMklJbHg2?=
 =?utf-8?B?TkVNOE1Ia0lhNWtlMDRZdUxkZEUxbkRNTDhJckVhUFB0VVplN2FrMjZtbStH?=
 =?utf-8?Q?+/cWPC3fGNuDjVuQNjaJWGC+5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87738d8-0ecd-4c01-4d78-08dde3dd9f63
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 13:45:16.1245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IOn7PfHDkFcEv9GCZsWBsOHUom23cIFrf6jK+YXUVmxubY/AQGEzb8MJXLW3s61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171
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

On 22.08.25 21:47, David Francis wrote:
> Add new GEM_OP_IOCTL option GET_MAPPING_INFO, which
> returns a list of mappings associated with a given bo, along with
> their positions and offsets.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 98 ++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
>  include/uapi/drm/amdgpu_drm.h           | 21 +++++-
>  3 files changed, 120 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e6741d6c9a55..15d588f7acdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -948,6 +948,70 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	return r;
>  }
>  
> +/**
> + * amdgpu_gem_list_mappings - get information about a buffer's mappings
> + *
> + * @gobj: gem object
> + * @args: gem_op arguments
> + * @fpriv: drm file pointer
> + *
> + * num_entries is set as an input to the size of the user-allocated array of
> + * drm_amdgpu_gem_vm_entry stored at args->value.
> + * num_entries is sent back as output as the number of mappings the bo has.
> + * If that number is larger than the size of the array, the ioctl must
> + * be retried.
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +static int amdgpu_gem_list_mappings(struct drm_gem_object *gobj, struct amdgpu_fpriv *fpriv,
> +					  struct drm_amdgpu_gem_op *args)
> +{
> +	struct amdgpu_vm *avm = &fpriv->vm;
> +	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +	struct amdgpu_bo_va *bo_va = amdgpu_vm_bo_find(avm, bo);
> +	struct drm_amdgpu_gem_vm_entry *vm_entries;
> +	struct amdgpu_bo_va_mapping *mapping;
> +	int num_mappings = 0;
> +	int ret;
> +
> +	if (args->padding)
> +		return -EINVAL;
> +
> +	vm_entries = kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL);
> +	if (!vm_entries)
> +		return -ENOMEM;
> +
> +	amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
> +		if (num_mappings < args->num_entries) {
> +			vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
> +			vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
> +			vm_entries[num_mappings].offset = mapping->offset;
> +			vm_entries[num_mappings].flags = mapping->flags;
> +		}
> +		num_mappings += 1;
> +	}
> +
> +	amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
> +		if (num_mappings < args->num_entries) {
> +			vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
> +			vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
> +			vm_entries[num_mappings].offset = mapping->offset;
> +			vm_entries[num_mappings].flags = mapping->flags;
> +		}
> +		num_mappings += 1;
> +	}
> +
> +	if (num_mappings > 0 && num_mappings <= args->num_entries)
> +		ret = copy_to_user(u64_to_user_ptr(args->value), vm_entries, num_mappings * sizeof(*vm_entries));
> +
> +	args->num_entries = num_mappings;
> +
> +	kvfree(vm_entries);
> +
> +	return ret;
> +}
> +
>  int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  			struct drm_file *filp)
>  {
> @@ -955,6 +1019,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  	struct drm_gem_object *gobj;
>  	struct amdgpu_vm_bo_base *base;
>  	struct amdgpu_bo *robj;
> +	struct drm_exec exec;
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	int r;
>  
>  	gobj = drm_gem_object_lookup(filp, args->handle);
> @@ -963,9 +1029,27 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  
>  	robj = gem_to_amdgpu_bo(gobj);
>  
> -	r = amdgpu_bo_reserve(robj, false);
> -	if (unlikely(r))
> -		goto out;

> +	if (args->op == AMDGPU_GEM_OP_GET_MAPPING_INFO) {
> +		drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
> +				  DRM_EXEC_IGNORE_DUPLICATES, 0);
> +		drm_exec_until_all_locked(&exec) {
> +			if (gobj) {
> +				r = drm_exec_lock_obj(&exec, gobj);
> +				drm_exec_retry_on_contention(&exec);
> +				if (r)
> +					goto out_exec;
> +			}
> +
> +			r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
> +			drm_exec_retry_on_contention(&exec);
> +			if (r)
> +				goto out_exec;
> +		}
> +	} else {
> +		r = amdgpu_bo_reserve(robj, false);
> +		if (unlikely(r))
> +			goto out;
> +	}

Just simplify that into:

drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT | DRM_EXEC_IGNORE_DUPLICATES, 0);
drm_exec_until_all_locked(&exec) {
	r = drm_exec_lock_obj(&exec, gobj);
	drm_exec_retry_on_contention(&exec);
	if (r)
		goto out_exec;

	switch(args->op) {
	...
	case AMDGPU_GEM_OP_GET_MAPPING_INFO:
		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
		drm_exec_retry_on_contention(&exec);
		if (r)
			goto out_exec;
	...
}

Regards,
Christian.

>  
>  	switch (args->op) {
>  	case AMDGPU_GEM_OP_GET_GEM_CREATE_INFO: {
> @@ -1014,6 +1098,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  
>  		amdgpu_bo_unreserve(robj);
>  		break;
> +	case AMDGPU_GEM_OP_GET_MAPPING_INFO:
> +		r = amdgpu_gem_list_mappings(gobj, fpriv, args);
> +		drm_exec_fini(&exec);
> +		break;
>  	default:
>  		amdgpu_bo_unreserve(robj);
>  		r = -EINVAL;
> @@ -1022,6 +1110,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  out:
>  	drm_gem_object_put(gobj);
>  	return r;
> +out_exec:
> +	drm_exec_fini(&exec);
> +	drm_gem_object_put(gobj);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f9549f6b3d1f..5a63ae490b0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -668,4 +668,9 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>  				 struct amdgpu_vm *vm,
>  				 struct dma_fence **fence);
>  
> +#define amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) \
> +		list_for_each_entry(mapping, &bo_va->valids, list)
> +#define amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) \
> +		list_for_each_entry(mapping, &bo_va->invalids, list)
> +
>  #endif
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index e5d1c24cabcb..2e7a4e599e5b 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -802,6 +802,21 @@ union drm_amdgpu_wait_fences {
>  
>  #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
>  #define AMDGPU_GEM_OP_SET_PLACEMENT		1
> +#define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
> +
> +struct drm_amdgpu_gem_vm_entry {
> +	/* Start of mapping (in bytes) */
> +	__u64 addr;
> +
> +	/* Size of mapping (in bytes) */
> +	__u64 size;
> +
> +	/* Mapping offset */
> +	__u64 offset;
> +
> +	/* flags needed to recreate mapping */
> +	__u64 flags;
> +};
>  
>  /* Sets or returns a value associated with a buffer. */
>  struct drm_amdgpu_gem_op {
> @@ -809,8 +824,12 @@ struct drm_amdgpu_gem_op {
>  	__u32	handle;
>  	/** AMDGPU_GEM_OP_* */
>  	__u32	op;
> -	/** Input or return value */
> +	/** Input or return value. For MAPPING_INFO op: pointer to array of struct drm_amdgpu_gem_vm_entry */
>  	__u64	value;
> +	/** For MAPPING_INFO op: number of mappings (in/out) */
> +	__u32	num_entries;
> +
> +	__u32	padding;
>  };
>  
>  #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)

