Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DA5E8B399
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CB910E57F;
	Wed,  4 Feb 2026 04:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVc8OQkV";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C314510E57F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6KANG2HS0LWGVwOeSrKC3usqnNI7tMGFi/sbA7fZhZ6/NLdLFFNFj+0+riN62e8lF8h5VrMItVNeMBSmcpkofERlLNooi8f6eFbZle+sec9lIAd44xeM2UCpUpQTeolkwDBzOOuDj2vmtqV7Zd093dT5ZZg6oL/gQMQtDe771lI0fNM4FQKJjv1mPOSEy548aq91vCHGNzCVbpxg6AKZX5IlBA7AACNDtTTZ5V8NRoojavuq9j6o9hlNcm2isbdg9eBUzN2pmKhuwaZ1iYhRqHxhaeNXRtf2RXWBSboPZjV8ooGely9Z09U1TV+4aKM9K27b7z+62cnMqeMHSs8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbP38rWwqLK3lVV6TyN0XkvrCHq753+pN9tTFWCE8h0=;
 b=q0do9s59Oz48DBE3spIfJy+DIcQIlYRm2Pspo/wKutCWoRUDXhpRK5gC1lhRDI+GVDRgmQNwq2z8w9dII0mbZMOZ1bh3FZOvf8KHgM7SQAp7Day7i2wQ8CjTjHWrhtCwdA7UEvNd8jJDX77MR8GugjrvzJO9z9qxAhMINYJ1ae03sCD7DEfHMzBrVrcnXfxnOPK2JCfCisA05rVs6LZPSsAM0Qbeg/++/TFPrbEE4eBlreyW0eHKIL94EFc33DbD7g6c0ucdDn6he2H37Ojs5LpHGvJI4nhomFshyt6pXSwoo4gVNXQ9pH0Lc6q5LkCj466rn7P0np6PFcIGMmrLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbP38rWwqLK3lVV6TyN0XkvrCHq753+pN9tTFWCE8h0=;
 b=nVc8OQkVfski+QRj/UtPojTgHcxseDzBfcn+hObjXajh0Tf5RBn0SvMzCROSG6Gwk+JaPgZqp42Rr5rA63px+fopzoYusKw65RgSOhQJUsVjLC5u6DCpsjSW9WmIwOWGc8maUzalcDTjLcMw5Xw9XosNU0KP/ahenlfdQJ+TX40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 04:49:00 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 04:49:00 +0000
Message-ID: <72777119-86d6-41b6-ac77-3cf02d861273@amd.com>
Date: Wed, 4 Feb 2026 10:18:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix missing handle PERF_DETERMINISM level in
 smu13 & 14 & 15
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <20260204034732.187325-1-kevinyang.wang@amd.com>
 <9f783e4c-9609-48e5-8a11-1c6debcf9916@amd.com>
 <PH7PR12MB59979ADFBC092D6DF4549A228298A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB59979ADFBC092D6DF4549A228298A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:269::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 99829c69-2171-4d67-4010-08de63a8b67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekhsVXZiZWlxM2NyN1BFNzZCRnZyRWlBZktDUVorWVFqbEFKVmlZTmtzM2NL?=
 =?utf-8?B?SmJ3QXZKMDBpMmw2eFRhQ1dIZmYzakJTc1hvVHlBSFdXZkVmVmlLMXo1UkEv?=
 =?utf-8?B?ZVdYMy9hR01TVnlBMi9YbkE4RS93RE9vMFR4emQrNWd0WVRRdEg2azNYN2N3?=
 =?utf-8?B?empLRTd6aThibENPOWQyeWdqSDVYS1N3UXU4dVFlaVdSdTZWSytqWUR0Ynht?=
 =?utf-8?B?RlhxcXZhZCs5aWx0ZmtjOXpLR3ZXOFA2dzd0bXdJRm9GZ241aFdRTkpmd3dQ?=
 =?utf-8?B?aXc3NUtCSlYzQXdmRkJmc3hkVjRVdFBIa3JVdkVkTGUrN2p2Z0lPNSs0VWNO?=
 =?utf-8?B?RW0xcm9TSE56cGhQNVM5N3FrSnB6Uk5jY01vUGVBY0tQN3MyUDVlUXFFV1dE?=
 =?utf-8?B?dUlyTTV1NTREbk5IaHJTVGd2Z2R1Tk5nck1ZVHFzK1pqVXljYWRwamd4YXdJ?=
 =?utf-8?B?UnhJcG4xTC8yK3lmYjcwWHVkTis1dHVGTnpXOEp6a3N4dmc0eVVRdmJHb1Y3?=
 =?utf-8?B?NFdZUFhzZzJVU2NmaXZYeXBuMGhzQXlJNk8vVDlzdzdmSUtOcm0wTVd1M2hm?=
 =?utf-8?B?TUt1c3VzL0hiZzg2VmJnSkZqbXQ1ZUwwWjdmeTZSdWd3cnBKMkI5R3RVOXNl?=
 =?utf-8?B?VjU1TGJqVCtMbkNSazFLTmx5TTR1SVhaSjljcWdvRDVackNhMm4xL1I1TTFs?=
 =?utf-8?B?Y0lTTTBKTlJLaVUyNFNnWncvc3pocjRiWFZrZ3NoNFJtTnJFQUdOV2lYbDJ6?=
 =?utf-8?B?clNXL2FuSWZzQXpkV1BvTjdFM2NmTDVHanNqTEs2T2dnZXZFOU51aGNUNUpO?=
 =?utf-8?B?aHVBcUJ0RGN0UWxNUDFPSklsdkUvbkUwSTFvSHFEaGJTczNxdzJVRjBWTUJw?=
 =?utf-8?B?cG85R1o2dUt5bm9TN0gvenIzUktRRjVvWVExdWttTmYzdXpVVThXUkhiWjJY?=
 =?utf-8?B?ck1MU0c4eVM0Q3Z3M1BCdHJwOSs3d3I1Qms1ajVqNXR5cll3WDliK1pSRmV4?=
 =?utf-8?B?V2t6TkVEMzMwTFgzSFRSbmE0eFZoZzU2S2pZc1QxcEtkdFNlSmxUNFVmZnI5?=
 =?utf-8?B?ZDgwUWwweE1oK3IvTDBPUkZSeEI4RHJ6RG5xM2hQL09QQUZhZ3FRRVIxanFX?=
 =?utf-8?B?S0dIbytIbWdJekdiUVlicVNDSG5NVTdUSUNyUEs3SWlLWGZuWHgyekRVOStr?=
 =?utf-8?B?NGdmcnVCY0RmWi9vWXAxTzZRSFdUa1BOWVVCNUoyWkpJMTFuUjFOb0crcEdo?=
 =?utf-8?B?OU1tU1d2YW53Qjg3SDQ0bUloTlZSWEZMeld0TnNVWFNzNkNDakU3ZHJzTTZl?=
 =?utf-8?B?UzVDWm9PTUhRQmxoMktKb0cyaTRkUWVWaFpWT29pODk3ZmphdEpDdWFRSFly?=
 =?utf-8?B?TGY5R3VuUGM0MjVReDc0UVdNdXJrUmlpVVlJUk82YTNPTGZZbEJPRTlJdXVm?=
 =?utf-8?B?TXBqUmI3dkhRVWJwOFNLK09IeDhCcGh0bUlHK0Q1UWVqYnFqRkFWZmRGODc2?=
 =?utf-8?B?aXozMG5Jb2toaUp2eWFwcHdmOWhMcS9sTjFRWDlzdWdXWnlVUTQ4K0ZvOVJB?=
 =?utf-8?B?UG1seWxlSmhacnZ4TEE0WFUvVkJnTEIwV1dTdXFMbFJDS2pZUHRObjAvZTNH?=
 =?utf-8?B?aXJtY1FBZUcvdjlITGhJSEhucGVVNldWNkRRQTVPc1R6TERhckRNK0ZWR0M0?=
 =?utf-8?B?Y29pcFNJYlFaZUwvcXY3RkZSQXFnRU8vaEdYcndwN2tNR1E2eEppcVlsMG9p?=
 =?utf-8?B?VjBnT0ZTMm82OG9SYkxqdjNjekhVVmU2TlcvMmlETDVVSnYvc2dGdnpXaFhF?=
 =?utf-8?B?QUF5SXhWVGk3YW1nM0ovb0RnV1VFMW5LVUhNK29ma25PaFpkaDRsVE45OS9K?=
 =?utf-8?B?OXVaTDVYenBwYTJBWDVUY2ozdkFaT0s2V0FTRXdDYkE0YnVBWFlDYmRqOFl4?=
 =?utf-8?B?R1hxbVY0QjBFRDBpUFF5eGdLLzd1aDBUK0duQklxbkY2dS84OVZ4bzJGTXVB?=
 =?utf-8?B?dnZvbTNMb1loZEhxUmp4c3NZK1FGR2tGendjQVdKWHdXeG1QeWVIWU1WaWhO?=
 =?utf-8?B?T3ZObjVrM1RUQ1p3YXFpejJ5VTY1bGE0a2pIdVI2R3NzTUV0NEFBcEdCOU1a?=
 =?utf-8?Q?wxmo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGtaZld3VzU4eXRrUitSWE94TWc3aVJTdm9tRnIxTzdGenB4bjUxWXlDLzk4?=
 =?utf-8?B?SVJwek9uanFQdGNxV3dVdmlnd2hlMWx0TjRiNCtjbll0SHNMTWRLeVRBNUZ3?=
 =?utf-8?B?K3BhaC9yLzJLYkRYaklMN21XYXJ3blpmZEMwc3dWdllCeFpzcmsrQ2pSaU5J?=
 =?utf-8?B?MHhVTHNYMXVNVVdWUE5ORUhsMk5IcXRqWDRXbkg5WFNVTFljOWpVWDlwa1BP?=
 =?utf-8?B?U1RTK0EvZi9FYVdvcmtwUHBLNDNRV2oyNGRybWZUMGZzSVlJZHhGd2dONURD?=
 =?utf-8?B?dDhUMGpxeXJrbW5VZ2JpYTJCbGhMZ0ptakRMcy9KbWVqcmN6cmhLTlRUazZJ?=
 =?utf-8?B?a1hhcnBqZCtEN21ZRGNZb0xGMC9VRW56eFEwODhBUFhScWIyZmZMSDZpOGYw?=
 =?utf-8?B?T2hRR0RMam11ZWhnb3JPVThndlB0eGIrNG1zbk4ySVZKbDF3NThmUUZuckU3?=
 =?utf-8?B?bVRKSGRNS0RoTU9VTzFJSzhmbnY3RXJGWXFmb0VJUmk1R2hVekZycjFZUGpr?=
 =?utf-8?B?aU1meG53TGEvZkcvV2p6UFVvM0ZpaUtGblp2WTN2RStwWC92dUhIS1JDcVRY?=
 =?utf-8?B?WHJON1dtYkRSTi9mdTZZOXYyTzFPQWJWUzdiYXBpeUVyYzRleDFKTjBUeVJi?=
 =?utf-8?B?SXBaQnZiUG4yN1pDYVBhNW9Wcjh2T1JGVUhPM3k0RFJUd0RNMXJkQll0MXo5?=
 =?utf-8?B?UDE5V0ExRlNyaFFSdEt2bEVrYnBBaUNVeDgvVkxoTWZPNTBPNGFSUmczcnQ5?=
 =?utf-8?B?Wms1R3pUMEFRNGxWU0w3RVZSMEpQRnJuRDhmK1o4Y1ZkL0c2VGdNVzQ4Zk81?=
 =?utf-8?B?U0p1Vy9USGllNGI0RzRVK3llR0JZYi9meFU4LzJwVTBYVWVFUUgwMml5VlNH?=
 =?utf-8?B?TEg1a0tQMmNOSlA2UjNydzVEcWlMdlpNdXBOS1RmbTQrb3VFWkRKa1pxaGxG?=
 =?utf-8?B?UUhNWTRXQVpwZnNpSUR6MTNaSnkxWENMVDR1QStrTCtxSTQ2VHlHR054VVJS?=
 =?utf-8?B?L0ptU3R2dUZFUVNnSyt1V2lzZytPTXBoRXRGZHo1Q1pLankwL3c5MjBycVE5?=
 =?utf-8?B?NWlFRDFNeVQ5Q2NKNmVIRVBRMTJRVDRMaElwMFl6TThFWWY1ekxKa25kekxt?=
 =?utf-8?B?VklwVDNqdjV0eVhWelVrMFJWZzVvRE9oTXdBZk53M2NwL2ZKeTAzT3RTTXNV?=
 =?utf-8?B?Vk85bWw2MnNQVDhUSHlPa3A0MVRYMjlsRGYvNlFJeDFTZ0RTTE5WWVNmZ1pB?=
 =?utf-8?B?aDhWRFAvdkh2SmIvY1phTGpma2dGbU95ZjF4SzBzYTFBN1dlWjEweVRBVU01?=
 =?utf-8?B?VVZkZDljRDBTMmkzUXRwU3B3bFFiZkYwTUxUWSt1QW16eTR0aDkreVlKbGdY?=
 =?utf-8?B?Vk16S0dXRys3ajdWMnpZdTJ0QmVkdHFBS1p2MFJLYmo4c3pxdHR6b3JTNHVF?=
 =?utf-8?B?dEdaZ2NxUEFSSExKNDV5OWJYRnlxend3ajd6OVJUY2gyTU96QWV2aTk5Q3FR?=
 =?utf-8?B?b3E3TVVTaGVnYlFRbDlJcHNBNmxEZk03VE5SRzhFRGdOS2ZtQVgwSk1VVElJ?=
 =?utf-8?B?S2dSNXFmU2dpb2k2M29yZUt0THliZTArK0V3cXhSZy93L0JwZVFvOTRUSnVI?=
 =?utf-8?B?MTN3M096aFR4Z0dwUS9KTU5GUzAvY3Z0R1c3L0E0b3c0clJkTG9nNHMxVXNP?=
 =?utf-8?B?YWZ3L3hEL1daeFUrbzdDSmppQXk4RmJqck4vTFR5YnVPLzJTYXFjODdjN2xj?=
 =?utf-8?B?blZtRUt1VnNhZ05INGpFcmFzK1I4RTVoNklBSFlHRjBhc1BQd0xSTWZTSTJi?=
 =?utf-8?B?eFdpTUpYSmV5c2tsUUwwY3FTRlprd3FLbXJjTDhOWVp3RFdqRHJ2cDcxdlhh?=
 =?utf-8?B?OUhnQ2dEcE5kRksyZDlXMlBaUHAvY0wrS2FoYllieE4zZG0zNVBzalJrUzZy?=
 =?utf-8?B?cGo2RlVCcXNDMU85K0xVSGM3b1diR0syTjdHZTFFUEhBSGY2c0E4Ym5xNFBn?=
 =?utf-8?B?Z0gvVWVlNFJpVi9iTFBheTJuaU5PalpqaEZteXZ5bnRGRkVkV2l6ekxBWVRZ?=
 =?utf-8?B?cDRqMXhWaEpQTWZzbTU2RkEzell0blFUVmtIMDc4dC9xM2NaYndSbHpXcFU5?=
 =?utf-8?B?SmdyMFNrSXI4dGR1cm1aTitCV014bERDeGpFOGtkalRSaFR6b09TZWZKd29j?=
 =?utf-8?B?ZXcrblhzYmFJeUtXYUhQcmJaS2xEbmNSd0dpbnFHZ0oyYWRIV0hSb0Q2NGlo?=
 =?utf-8?B?VnR3anVuMlNEQjg0Q1dYeWt2djE5S3g0SmZJWWQ2SWhOQWwwUXlUM2Z0WHI4?=
 =?utf-8?B?WUZVT1FmTDdYTFpnKzYwTnlkWVpCSmk1TWFMaWR6eDNETkRsc3VVUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99829c69-2171-4d67-4010-08de63a8b67d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:49:00.4778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rA2uxTLIphae05tVPn/NhCaGTmnYSoisGTeZkI5QNtsmzNtnT2Je2V5MRdWFIUxZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
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



On 04-Feb-26 9:38 AM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> The term "invalid" in the dmesg log may cause ambiguity for customers.

I don't see anything wrong with that, it says it is not a valid mode 
this SOC. Similarly, modes like AMD_DPM_FORCED_LEVEL_PROFILE_PEAK, 
AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD etc. are not valid on Aldebaran.

> The software-defined performance levels shall be properly handled by all pm swsmu/powerplay backends.

I don't see anything wrong in returning invalid for something which is 
definitely invalid.

> In addition, the kgd interface should provide a consistent set of APIs to ensure that user-space programs (e.g., amd-smi) can invoke these interfaces without issues.
> 

That is missing a query interface for valid modes. It doesn't mean not 
returning invalid for something that is definitely invalid.

Thanks,
Lijo


> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, February 4, 2026 11:52 AM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: fix missing handle PERF_DETERMINISM level in smu13 & 14 & 15
> 
> 
> 
> On 04-Feb-26 9:17 AM, Yang Wang wrote:
>> add missing performance level AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM in smu13,14,15.
>>
>> kernel dmesg log:
>> [1217924.810528] amdgpu 0000:44:00.0: amdgpu: Invalid performance
>> level 512 [1217924.810537] amdgpu 0000:44:00.0: amdgpu: Failed to set
>> performance level 512
>>
>> Fixes: 6be6424684cb ("drm/amd/pm: Enable performance determinism on
>> aldebaran")
>>
> 
> Determinism level is only available for specific SOCs, so the the error message is still valid.
> 
> Thanks,
> Lijo
> 
>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
>>    drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 1 +
>>    drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 1 +
>>    3 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> index 63a65ea802fd..d17d6cd71028 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> @@ -1659,6 +1659,7 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
>>                break;
>>        case AMD_DPM_FORCED_LEVEL_MANUAL:
>>        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>> +     case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
>>                return 0;
>>        default:
>>                dev_err(adev->dev, "Invalid performance level %d\n", level); diff
>> --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> index 7dc6687c3693..68ecba0d5e0b 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> @@ -1321,6 +1321,7 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
>>                break;
>>        case AMD_DPM_FORCED_LEVEL_MANUAL:
>>        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>> +     case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
>>                return 0;
>>        default:
>>                dev_err(adev->dev, "Invalid performance level %d\n", level); diff
>> --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
>> index a2854d528bab..1860bd0f1091 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
>> @@ -1210,6 +1210,7 @@ int smu_v15_0_set_performance_level(struct smu_context *smu,
>>                break;
>>        case AMD_DPM_FORCED_LEVEL_MANUAL:
>>        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>> +     case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
>>                return 0;
>>        default:
>>                dev_err(adev->dev, "Invalid performance level %d\n", level);
> 

