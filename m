Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDCEC54FD2
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 13:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD24E10E769;
	Fri, 20 Feb 2026 13:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JWlUJubg";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C0B10E769
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 13:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsMT6+HGlwUN3Tw7JpnKs8QOIXyhJPJXk4Qgo8kBrgEdUg0dXVqwtyj2fjm3KxPCZMnsSi0d1fxBrPJCr/89xdzeyAlwELp60PU5N+07lvIylCigqOjbq0HH6huVONHxLbMjQ/A0V45FbuFbC6QAcTy33bmVZ/NaXZztH3+lMOpqT+6FpurC3hh1r53AbhTVt13sdlQBg9MC+B97lM5R89FXc5d4lvDVsPgyy+nHjQ36kgBnYv4GljdiGezlDuCz0HvGKeal0GqAJb6eL+mO+wGKdsHN0znEFUZG3KOOc/wiFnpHiOnU2PJXji/W51uD2Gv1jp8iVa79oFtQykc5eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yr+IYJR9w5ooWADi4nzju4Fukeral//Nfxs6+mNnWpE=;
 b=eiv2Z1eqy7h2rfhycapvjZiMMZw4LBa0t4Xo3P4oAfEV0+RwAQGGJPzn1W6pZvUx/+HnXhRVscjFUCyQg3yery0UuJRCiz6IYlXPj73cY27g7uqaA4aKYmAFJjDlZdKUj79ccQ/za0kQVMXNMOWKlXRuG9XpK9J0b4K0GTkZ+uYqh7cjcYaZjaAm+KFURyfU2d6hL/qFt5dOr9FiLzZcVPyZq2YRUTflM/0uwpwYkza3Oz7aPEGSTu03vnAZpnJ1zyRLbgyDUND9YauUi5IcHz86o68hta3yf2Kj6hyiV6yfFSlllUglcTYmoNHB3K21UMosljrMF5jquMjCwyMYsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr+IYJR9w5ooWADi4nzju4Fukeral//Nfxs6+mNnWpE=;
 b=JWlUJubgx7/EUUsWPUhkNEPjYaPQJtirNhYHA+la6yBVWr8CnB6doRRJ1yy2uofkSXMwasmPRQmdhIlpqAml8T/qqWUCetom3GrPz3TOF76FYGCvKQeTj+6j3aoKGAYo647synrRXttCuG3dSVhl1OQ5ywx3sGT5qvmJ7kiFiYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.16; Fri, 20 Feb 2026 13:33:37 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 13:33:37 +0000
Message-ID: <50870491-3387-445e-9751-f4b9cefac64f@amd.com>
Date: Fri, 20 Feb 2026 19:03:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update memdup_user with
 memdup_array_user
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260220082840.2192325-1-sunil.khatri@amd.com>
 <3c7f24f3-d1f7-4724-bf2e-8540fa2e2648@ursulin.net>
 <4a824f5e-5279-4cb7-b6a9-fb4c6f87cd91@amd.com>
 <c6759efc-8c96-48a2-bbdb-ffbe4398471b@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <c6759efc-8c96-48a2-bbdb-ffbe4398471b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cde514f-2970-45da-8700-08de7084a6e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVNFTWhsMkthUlZOMlBxTGRNVEpVR0VmeUpTSEF5aXRYSmtRU25HVU16ek9t?=
 =?utf-8?B?R2tMNDN3K1IrQ093N1N1WndOcmhjbE9DYW5WUjVDU1RlMyt3bTcwTHFZTDNR?=
 =?utf-8?B?cmxuenp1MDZ0OU9HenEyL2NGY1JpL0gzbUpXb1hDYWF4QUdDUVdneHhSMVpM?=
 =?utf-8?B?OUFQVkhCeXZTMndnbm1OOVI5OW1jOWZRZmVBdEp6d3Q1dGpna0oxbWdZQzY0?=
 =?utf-8?B?TWREQzZEaXRCSHRVV09uNEhkSGZVcWlrVml1cmZmVEJyT0dkSFloR2ZlWDJs?=
 =?utf-8?B?MkFRRFpzVTR1L3BUTzE4R3RHMVp1Q213NHY2dUduWUR3TDhCR0Q2NjVMQ3N5?=
 =?utf-8?B?UVd1emI1U0NGUk1ndHFxOUFtOGlCNFd4azQ1OEQrai8xcm9IYzZwVHpqM3Rm?=
 =?utf-8?B?S1cyUXhVUXhBampSdEtWOTZkbFJHVW9YM1doSU14WFBmZmZoalN6YUhiVlVI?=
 =?utf-8?B?TGxwU2QrU1FkRHBXelJEaDQ5V1pwaHpNbHNCa1lmQU1yNkFMWmw1UXlzWFJH?=
 =?utf-8?B?QlNLc0xNTGVCZWpmWUlSZURXZXZSY09ZRmlWZC8wczhQc2xMbzhCRTBmcXFR?=
 =?utf-8?B?Qm10cUxtcWtENEJkUXdvYVl5RGxEL2hIOStzMThFRTdkYkwzVlVCaThMZThU?=
 =?utf-8?B?QWhBWk9UdmczL255R3hDc1BZR213ZFZlR2JmVW0rUVhnRytyR1FWMTdLT1oz?=
 =?utf-8?B?V1VXamFzVEJwL2ErWGlBVmxIb1A3NjRHRXRlWldmSnpmL3JweTF1clFmU2E4?=
 =?utf-8?B?Q3BFYTBzczkrek5YYmFGVm9UTlhDc2VWUExDN0g5WWdYQW5pTkZmZG84NHdM?=
 =?utf-8?B?b1BSbHZHeTR3Wm1tbjZ5OXE2WmNTdnlHMENtUHhBdVJTbDRVWGtDaDFtT1RH?=
 =?utf-8?B?R0ZHQ0dlMDRHazZnQTVyd0wydS9ZR1lDbVN5Q3d6bjlSMHYrVDhFVjRxS1hR?=
 =?utf-8?B?Q0xYbEF6TWsyVXU1N0c4UTZZdXdpOE5FN1AzYVNqU2pjelVUc2pXWmM1Uk1k?=
 =?utf-8?B?ZU9ObDhjYmlSWFNPemw0TTVJQUw4Z1BvU3V5TElLTSt4aGpJRGQrREZHaWU2?=
 =?utf-8?B?MGd2aHBMVC8yOWg1T21mcE9PUUJ4cEpWRWRaYjNoNmxYU0lMSDdhQlgwZGxU?=
 =?utf-8?B?ZTlPMW9DakRxRC9BMmlWNUVSR1M5UWVqTzNyS0J3ZGlUTmRwV2hyTXpTRi9i?=
 =?utf-8?B?WmdqWHZBaUpPWG0vZWlqSW42QSs0QS9XYUcyRGxzNTdKTE1QelVhV09aTlp3?=
 =?utf-8?B?UXU2bDk1ekdRQ29acmlicmxmaE40ZVV1UGRjeHJZUCtsb0dCeDZ1WEF4cFI5?=
 =?utf-8?B?UHVQNEU0RkhPVHZKZm40U3gzSHZSczZTTEg4ZHlhQ0tkY3h4RmxaOERRK21X?=
 =?utf-8?B?QWQrRTFsckYydDFDaHFkWHFydkxndTVkRlJISG5SZkt1Tm9pU3MrV1B2d2NL?=
 =?utf-8?B?RHdIVVVCdmRGOHdZWlQ1VSsxRmorOEVUWWRhTFlVZllXRk5zTWdKcEVtb0RE?=
 =?utf-8?B?dnZibm53REt0cXF2OXI1OFVpZW1mdFRZUHJDdUREMEdSRWF6WGNGWnQrcXF6?=
 =?utf-8?B?WGpPeC9ORW03VXhndHNmRkdVa0I0UERtVFEwNUlQNVk1Z0dUR1F6T1VtU0Iy?=
 =?utf-8?B?VnZjS0FEWmxkRUV1NFU5V05ZWEFyRTdGR3YzN3B1aUJWYnEzWnEzUDQ4d2NJ?=
 =?utf-8?B?bHBqaU9JdWx4cjNueVhJczdlbmlTL0dKUXNPbkFTMEJoTkFYT0RmY29OR0Ey?=
 =?utf-8?B?OEE1Q0tIMWduNUIzUzhpRnd2MWtPdENabVhndlpsMDBBaGxGVjRvTTRQS3No?=
 =?utf-8?B?UytDenFMT0FHamlSYit3K2FIbm9sNHRndUdCMklqaTV6UlB1Q2ZrTkc4U2c1?=
 =?utf-8?B?dUFsTjBSMFRCNmk5Tmt2MnhLdjdtbWdPdjdtMUpnazRSUWJzWGt4UXBNUXJD?=
 =?utf-8?B?Qzh2R21ScnVVN0NvQ2NOaTllbjk2RUhDWUt0MGdyUXVDNGNBWDRJKy91Yy8z?=
 =?utf-8?B?aFQ2c01XV2NmUG5nZGdJMktKaHVzS1RuV0JwQ1FBZzUwbHJJTFpRT1FOT3c2?=
 =?utf-8?B?VEIwc29zcVNtdDNlSmovMEhYK2Q4SEwvK3RuMDNoMzlHYTRqRXZRN21kZEdM?=
 =?utf-8?Q?DrtFvy9XZAL68ue7Bpx8KdiCF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWN3UDlJR2l0NkVXVlU5ZXZpWTBGS2lScWJJMjdtTFFZOHRHUURuZDZobmFy?=
 =?utf-8?B?OHhvb0FUYitrM0hMdjd3N1dCL2RVZ042Q3pNQ0FqeDVjMVQ3TXFRKzNES2ZS?=
 =?utf-8?B?Wm1ibkRlRURweVVwOFpRaWFMT0F5MGtGV05QYXF4Rlg2Q0Q1RXppLytNQUhG?=
 =?utf-8?B?NEFRMEJSNTM1VmNrY1VxVUJpMHVlak9hWTd6UTRoK3NCTDRYZXkxOXYzR0hl?=
 =?utf-8?B?aUFKRTRTWi9FMXA3NC9XSzdzQXpDdzFkaG9Wby9hZ3B5TksrTnJ6THA0VldK?=
 =?utf-8?B?ZHYxWVJSRWowTkxuSU5Xei93b0hwOTBnNG12ajdhRys2bWJaaDF2aGRjRXNS?=
 =?utf-8?B?YXNiZkVUM1JqckxpdnV4WXk4TEY2TEVNTE44bDI5S0s5VEdnVlBPQWdSUDBQ?=
 =?utf-8?B?VWtFaUpKMmZzbVdxRjlPVVhSVStBUzg4ZVBWYXc3WHR2bGFGdVhkU25Gajdl?=
 =?utf-8?B?QTJrclNFNTZ6OWRjTXl2QVYxVXZZVUxSSkthTUpQQ0tkZzRiTnNsV2hETXdp?=
 =?utf-8?B?TzRRMEYrcndxQ0RCRVlmdXRDNUdmRkJuZnB4S2poc0txUmM4eXNVRjFMK1Bn?=
 =?utf-8?B?VmhOUktNMWFmY2VnRy9xV0w5RlZOcHVINkU1eVc4d21nZkRsK29XN05SY0pC?=
 =?utf-8?B?dUdtR01KbnBwTCtocDk3RVp0cjlwT1FtOFdDZEFNdXB2Mkk5ZXFvd1FZTUdP?=
 =?utf-8?B?eVlMTktrSCtOMTZ2aVdtc1ltMFk0SXJvTk10V1VLMnVoUW83OU84TEtLUGhi?=
 =?utf-8?B?VXZQRHhHK2FqRjg3R2t5bGVkQjI1eWxGNnNJV21CZGU2VU40OWltODJMR2dT?=
 =?utf-8?B?RFI1RW5nemVBc2JScHhXK0QwTWpaMDJINExGejRPOEN3dTQvZFpWQ0pERkVh?=
 =?utf-8?B?MUYwQkxtS05LQnNyZ0JkUi9JRGxmT0xIRHJpR01RV3RYY0tnUUQwZy96YWpm?=
 =?utf-8?B?WDl3ejdKT0FWTU9QMDlHdHE4YU5QbFIyQ3Rqem1LUEEySkl4TlpSUWxKczMx?=
 =?utf-8?B?UXRIMFp2WUJjRmNEUFdqY1dpeEhoSkUydThKUFMrUjZhZ3c0Z1IxVU5tY053?=
 =?utf-8?B?UUVGUUJYbHlQYjRiUkpXUU1SMTBCek0vb2pYRDJKbHJQY3k1STFrb2JGS2Ew?=
 =?utf-8?B?K3d6K1ZzOFNUVmFZWW52Y2FldFFoRHZNN0tXa1NKblErc0dxbm55d295SVQ5?=
 =?utf-8?B?SFpuYXpYeG5FemVJanRLUTEzeVExbjVmQTZGYmR3YlYxQ24vNWpwUmplU1Bq?=
 =?utf-8?B?Y0VoK3hnQm1CWmRkRThtMDRKb004REtxZ3Qwak9iM2ZZZHc1OTZWbDJEOFVy?=
 =?utf-8?B?TnIwb0I0R3lKcDNiR2Q3c1V1Mmh4NC9DN2hWVjNSeEpzOHNtYWNJNFk2ckJx?=
 =?utf-8?B?MzMrYXBQWi9mWTcrS29OQW8zdkZyczFJOVlubVZFaktDSmM2dUIxOGxRcVlq?=
 =?utf-8?B?V0hNaStKUHpUMlBTbDFOaWRiQnhIV2gySGRsVDJmVXBYWU1RbXR1aysvellj?=
 =?utf-8?B?ci9UK3ZOMjF3bW8rNEJaQmVLTlB2dE92VnRSVHdKemhTaFdrQi9GUkdOT3Ru?=
 =?utf-8?B?c1BCVDlqVlo1S0Y1Q3FSbEZ5eHJLalhQRjhGMGJtM2ZDQnMwS3JEN1RLWDND?=
 =?utf-8?B?NWliOEVObGxaK3duWHZzU0J0Um5ya2EwejRpcTRNQkpGd0swV1UrdDRFbVN4?=
 =?utf-8?B?Z1k3TXZCbXdhNWJzdDBaWUxlNy9PTVBEc0tmZ2NWV2ltbzZxR004bmFRL1ls?=
 =?utf-8?B?Tm96MW9maXdnbjl5S1MzYzRsR3VPUmNndFNpbmlCMWdrUHJCRFFUS1BiUy9E?=
 =?utf-8?B?UThDcm9PUE1zTTg3ZlFjSFdRSThPNXU5YjhCbWNIYkM2QjgyQ1pDSy9rMXZF?=
 =?utf-8?B?ZFQ3WWlwVUJLSkRGaEZHRmtlNno0RC9uWWNEVWx5ZTVOSlF6MHdYRGJLQkp4?=
 =?utf-8?B?bm9OQnZzNGNsS0RSMUxneVhkbjExak91NjVZeVhUcitER0wwdnI1eXBwbXNL?=
 =?utf-8?B?UWtTZytYMXIrWGFtKzNCT1h4NTFYL0ZMNzhUa0pkMnI1R0gxaXVPTmQ3eEpn?=
 =?utf-8?B?YUdRdVNrZnkzOEV2TFlYY3VXNUVqSDlybDNWc1czaEpIaTdaSlQvM3QydzNY?=
 =?utf-8?B?M1dUcG1RUTBDemhQdWk4ZGphd3ljbTBGUkpLWjZPT013alZOMm5ObkVkSU1E?=
 =?utf-8?B?S2hjZU5TTEpmbVZ3b0hRa050Tkc3M1lPUS9GRHFVdlJGWUhMLytRNUsxTkxK?=
 =?utf-8?B?Z2REUE11NkpLemRGbXptbjc5LzRrcEVLN05UeHhUa3UybHUwWU5NbGV5dkxG?=
 =?utf-8?B?V3lidjJtV3JDRmI3enFjN2FORnQ2MGRHQmJpNTRXSnczV0YrdnVqZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cde514f-2970-45da-8700-08de7084a6e4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 13:33:37.3765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhowweJAu5z+gf8121BIRWusSfmXD6QE8Sj0jTq4L93aXGW/DSI2eQF7aibiDuK4Tx9Ik6Rs4/NPn/HbnDgeOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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


On 20-02-2026 06:51 pm, Christian König wrote:
> On 2/20/26 14:19, Khatri, Sunil wrote:
>> On 20-02-2026 04:54 pm, Tvrtko Ursulin wrote:
>>> On 20/02/2026 08:28, Sunil Khatri wrote:
>>>> memdup_user could return invalid memory allocation if
>>>> there is an integer overflow. Using memdup_array_user
>>>> make sure we validate the size requirements upfront
>>>> and return with an error.
>>> FYI:
>>>
>>> https://lore.kernel.org/amd-gfx/20251205134035.91551-1-tvrtko.ursulin@igalia.com/
>> Are you awaiting for anything to merge the changes Tvrtko or they are merged in drm upstream already? Since issue is reported now so we need to fix this.
> I simply couldn't find time to review those patches and then they felt under the table.
>
> If Tvrtko came up with the same patch earlier than us then just take that one, review it and push to amd-staging-drm-next.

I have reviewed the patches for Tvrtko, change, you can review patch 2 
as that is not related to this.

regards
Sunil Khatri

>
> Thanks,
> Christian.
>
>>> And later:
>>>
>>> https://lore.kernel.org/amd-gfx/20260202125149.2067-7-christian.koenig@amd.com/.
>> Yeah i am aware of these Christian changes and we decided we will fix the issues first and reorganize the code later as needed along with Christian changes. So we are going to push the changes
>>
>> on the existing code base first.
>>
>> regards
>> Sunil khatri
>>
>>> Regards,
>>>
>>> Tvrtko
>>>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> ---
>>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 +++++++++----------
>>>>    1 file changed, 16 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 212056d4ddf0..a6eb703b62c4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -480,8 +480,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>            return -ENOTSUPP;
>>>>          num_syncobj_handles = args->num_syncobj_handles;
>>>> -    syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles),
>>>> -                      size_mul(sizeof(u32), num_syncobj_handles));
>>>> +    syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>>>> +                        num_syncobj_handles, sizeof(u32));
>>>>        if (IS_ERR(syncobj_handles))
>>>>            return PTR_ERR(syncobj_handles);
>>>>    @@ -501,8 +501,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>        }
>>>>          num_read_bo_handles = args->num_bo_read_handles;
>>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(args->bo_read_handles),
>>>> -                      sizeof(u32) * num_read_bo_handles);
>>>> +    bo_handles_read = memdup_array_user(u64_to_user_ptr(args->bo_read_handles),
>>>> +                        num_read_bo_handles, sizeof(u32));
>>>>        if (IS_ERR(bo_handles_read)) {
>>>>            r = PTR_ERR(bo_handles_read);
>>>>            goto free_syncobj;
>>>> @@ -524,8 +524,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>        }
>>>>          num_write_bo_handles = args->num_bo_write_handles;
>>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(args->bo_write_handles),
>>>> -                       sizeof(u32) * num_write_bo_handles);
>>>> +    bo_handles_write = memdup_array_user(u64_to_user_ptr(args->bo_write_handles),
>>>> +                         num_write_bo_handles, sizeof(u32));
>>>>        if (IS_ERR(bo_handles_write)) {
>>>>            r = PTR_ERR(bo_handles_write);
>>>>            goto put_gobj_read;
>>>> @@ -666,37 +666,37 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>>            return -ENOTSUPP;
>>>>          num_read_bo_handles = wait_info->num_bo_read_handles;
>>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
>>>> -                      size_mul(sizeof(u32), num_read_bo_handles));
>>>> +    bo_handles_read = memdup_array_user(u64_to_user_ptr(wait_info->bo_read_handles),
>>>> +                        num_read_bo_handles, sizeof(u32));
>>>>        if (IS_ERR(bo_handles_read))
>>>>            return PTR_ERR(bo_handles_read);
>>>>          num_write_bo_handles = wait_info->num_bo_write_handles;
>>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
>>>> -                       size_mul(sizeof(u32), num_write_bo_handles));
>>>> +    bo_handles_write = memdup_array_user(u64_to_user_ptr(wait_info->bo_write_handles),
>>>> +                         num_write_bo_handles, sizeof(u32));
>>>>        if (IS_ERR(bo_handles_write)) {
>>>>            r = PTR_ERR(bo_handles_write);
>>>>            goto free_bo_handles_read;
>>>>        }
>>>>          num_syncobj = wait_info->num_syncobj_handles;
>>>> -    syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
>>>> -                      size_mul(sizeof(u32), num_syncobj));
>>>> +    syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>>>> +                        num_syncobj, sizeof(u32));
>>>>        if (IS_ERR(syncobj_handles)) {
>>>>            r = PTR_ERR(syncobj_handles);
>>>>            goto free_bo_handles_write;
>>>>        }
>>>>          num_points = wait_info->num_syncobj_timeline_handles;
>>>> -    timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>>>> -                       sizeof(u32) * num_points);
>>>> +    timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>>>> +                         num_points, sizeof(u32));
>>>>        if (IS_ERR(timeline_handles)) {
>>>>            r = PTR_ERR(timeline_handles);
>>>>            goto free_syncobj_handles;
>>>>        }
>>>>    -    timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
>>>> -                      sizeof(u32) * num_points);
>>>> +    timeline_points = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
>>>> +                        num_points, sizeof(u32));
>>>>        if (IS_ERR(timeline_points)) {
>>>>            r = PTR_ERR(timeline_points);
>>>>            goto free_timeline_handles;
