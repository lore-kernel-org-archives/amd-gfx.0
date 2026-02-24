Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082BCEFB801
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A06910E4E0;
	Tue, 24 Feb 2026 08:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Sv9CGFu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 499A910E4DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 08:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etlGlj8SfB5cZRo9Tpx8Mf/zTGZj1ioZQeoJjmC4JxOho3NfXxSaS0bif0jsC4yiU7ueVmlyGpF98mSJQGZfEPEZ733YFpYtzzooMRpN/DZnkPqIMQbfx8G3X05KPfDWUltPMUD6S73F9G9OwcmMN1IRUWFdnCl64veWXikF110MFRtVwBL4k95MsK92+aCCeOb/m813cYWkJGhSmg2dJVibf/DvNGhxyVM/zmc8tgJrlykU5u7p2nJQ0U/EWitzafPd4GR/iNku1uF5SX6BQ/hOyBnSzhRtu9Jj98vnFcHX/Q2l+tf9pmNiBVV8R22FZbeF2aZ6zg3qh0IcMQue5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56INm0WUH37IfxJCTs5MRTsOeh88L8fnwGn6pki+PYg=;
 b=cXLREkvHKW2xA9wU0mI70fuI5yykG64bvwNuszQR7bK9DxzLaI7NVc0IYWPNFrEJ+MjadM1a2zkwbwz/aaxWtgsQykgLveWSraRQ0l5H4p6OjGTsfuMx9eeCQ4xt8HGL1gDtWC6AU4M+AHrJlG+yEqbBL7StxXVneuTidOd07IH56TX+gUCdnBMBNozf89Hr5B4MnLjgbN3S8V48NeYmyEACDY3KeD532yHKXzwHxOdW84TDspfae+jCVbIqvBL65b2GO91ouFtiLvXJwAokTHuYjzsqBryKOsQeQ6KogodCw+ou5gyn2VYqGB7O17CcarqyUzbFTHykE7QGX2n4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56INm0WUH37IfxJCTs5MRTsOeh88L8fnwGn6pki+PYg=;
 b=0Sv9CGFug7OIQuWXPDvCrrhAejjDWGs8uCIAGhGRITsx7ETAq8LiQ8GjeWGjiUMySfqIoCN4Urn5snAvFHx3Axhlkfqj8vGYvLyHLDh6ap5Ujv++zDPnv3yJkcV0zzH48M9WW7XXMKawlxiGdP51BkEpfxy1DcmSQpRC7NFNoSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 08:27:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:27:01 +0000
Message-ID: <8eadc199-4f3a-4a10-bf0c-02c6106f7530@amd.com>
Date: Tue, 24 Feb 2026 09:26:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/62] drm/amdgpu: Unlock a mutex before destroying it
To: Bart Van Assche <bvanassche@acm.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
 linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
 Christoph Hellwig <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
 Jann Horn <jannh@google.com>, Alex Deucher <alexander.deucher@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260223215118.2154194-1-bvanassche@acm.org>
 <20260223215118.2154194-8-bvanassche@acm.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260223215118.2154194-8-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe62f3c-f7c0-48fe-b8f1-08de737e7bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVB2VmRmMTFnbDFDRksxaDBqSWpjYnl4bzVtUWhuSTB1Zi9hUHJ1RlQ5SmhG?=
 =?utf-8?B?NTcyRHN0QVQxQ21pSjJvLzZpTWJkSUVjSmVxVUVHRFQxeFJzZEZ3QXRYQWl1?=
 =?utf-8?B?Q01tZTgycnBjZHdiWVAwUlcvYjN0Z2J3eTlDQ3VESmV4NHdFKzZpL0VaeVJF?=
 =?utf-8?B?Q0h6emZuY3d4a0p4SFNtVWhXam9QRkRDeUROa0Y5dDV3eC92c3o2OHZyTkEr?=
 =?utf-8?B?Nmh3QVBsVXA2SHJXTUJBQ1dtRjEvdkNSK25jeGNEZlBsdlh6WXhsQzNPOENZ?=
 =?utf-8?B?angzakFNSS82Z1dzQUhWZk84SnFxOVB2OWJzbmdMUndySGxBaHpFV0pSRG9n?=
 =?utf-8?B?bUZ0TGtWeVZ2Mzg5Y0E4a1cwS2Exa282dzUzODhMSi8wR2E4TGJEMURTMTlz?=
 =?utf-8?B?VlNsOTQ2OHRGSlZsV2RPcFpJV21HYWwxZzV5V3pnRVdFSTdzeWhnSjRWRmtY?=
 =?utf-8?B?YnY1ekhBNUxJanl0ZUppa3hLWURRUG1ESWJXRWpPOUwvbnp4TlBFVFFkYU1D?=
 =?utf-8?B?WVQrVHJZbUMvVkRSSDdQcklSc0lmeitTeEl1cFVkTWc5d25YWG52S0xjRkRp?=
 =?utf-8?B?MUtJMTlvSTNMNDJrSUVlbm1ib2YrYmhtaThRSXVxcUdwQlowdUZ1NVRhcGFU?=
 =?utf-8?B?T1ZEODJXMitHMUpjVVNnRXovUWxTWjAvNkVlR2p5SmIvUmFIcXI2VDZIOEJV?=
 =?utf-8?B?WFV3UHRLb3JQMEhaTnVJSFFIeEhnOHROZEtBZitTZHNZWHU5eXlSUk1VMk9x?=
 =?utf-8?B?YXJ1OEU1a1Faa3NhQVV4VFM4OTJBYjNKeGdQUnM0NWloVWQrT2hpYUJpUVhz?=
 =?utf-8?B?dGRDTi9hMElFZ1pqektiRFoyK1UwLzZ5NmNXOGVrbTFXbjdvQ1lpS2VleXNQ?=
 =?utf-8?B?dmVSbGltdEVQTUJvWkJUM3J5WG0xYVBORnJiWENJWE1tRUpRVGxTdnhBY1BG?=
 =?utf-8?B?Z2RSZUMyYWRtYjB6VGdIbnhVaUw1eE11WXVqbVRoWHYvU0dQT25FVUxHUkV3?=
 =?utf-8?B?UFp4NTFXaStUUndaSVJ3cEdCalU3WnJNSHBDK2lPK3JPSjk5dTc3NG91YkYw?=
 =?utf-8?B?cnpNWTJuVzhKbHNOMTc4YkVKSHJLaTVBSzRKc2tLNmdlbFNDbGgwdGI1cHpV?=
 =?utf-8?B?ZHQ1Y3VtUHdPT0RFOUZxbnZNSWlDTHVtOU1RN2RndWNMaVZraUxpbGF4dThI?=
 =?utf-8?B?bTRSVDRlL0QxcGk2SEU3VERJVkhtQlZZeHBXY2hwUEVkalo0endXU1BKWm9j?=
 =?utf-8?B?NkFGcXcvWjhQN3R4TXJOWk5CZHhGUFdZdllpallVTG5OQUxHSDl3VnkyV2xN?=
 =?utf-8?B?bXNIaUVHTitQTkN0YXlXeG05a05GTHBJdU81c0FudmVwMGhwbFBSOGluY1cz?=
 =?utf-8?B?NE1pbGM3MkZueEw0aUdQc29uTHVHajA5RkRSMjlxdEpVQWlYNjdHbTYrUVZu?=
 =?utf-8?B?UWFZM1ZlUVNJYnhVL2JQeUlMQUJ0Nzc3MElXVUlnR1JUeGVpZHVCVExXZUtv?=
 =?utf-8?B?RTg4YXJVeXRwZ01MbWE3SGNRbUJtSkdCbjBJZDRsWFJZMmhmaWxWOUg0aHIy?=
 =?utf-8?B?ci8zVXJ0ZGVoMjdCa3R4VHI1NS9xMEg2d3gwS1JWV1lYSlBrQmJ0ZnNFK3Rw?=
 =?utf-8?B?ZU0xUm4xVTJIVGU4ZTdlZmhSd1o4ZDBocU1ZL2Qxd2FmbjdicUpVYWJtK2g3?=
 =?utf-8?B?NkwvaFdEZHBNNU91T2JOU2pxcE9XZTN5dCtvZjEwOW95V0R5bTRzK21sSnkw?=
 =?utf-8?B?KzF4OVFmOGRidnRQYU56RUFZYUlLL2JVdTBDUVZiMy80aWlYakNySlhrQzMx?=
 =?utf-8?B?N291aXM3N3A3Z1hWL0ZmcHZCQkxHU2xHTkE4bnVmR3Z4QXJvcmtvS2x5cU1W?=
 =?utf-8?B?MUZWcjZwMjRqQk5VTDA0VXdFejU5L1pBaEtUNkQzS0RBUWxyaDhzMTkreVd0?=
 =?utf-8?B?N0V1ZERYWkZ6NVV2UEVYb1JQb3huRmxLTTBLNEVrS0pWVG5idXBZalRKbmNX?=
 =?utf-8?B?ZDUxODF1cld0dlM1bXQ3WXFscnd6VXczRGVsVHZVbVA5WWsrYzgvQ1lXOTZy?=
 =?utf-8?B?bkdaTCtPUStVSUVoQ25OeG5NdkdheXhaSWtRR2h5SUxpemx2N1Y1ZXZ5RDZV?=
 =?utf-8?Q?fVB8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXlNMmhOdGU4WVdVMDN4ZUJOcTZqOTBEcUp5MHE5a3VHUVh6dkpiSy91dW9E?=
 =?utf-8?B?OXpTZlhxRjRJczB6cXVQeTl2ckl4WlRNRCtGZVlNeWJJS01zdExVdEVEL3NJ?=
 =?utf-8?B?MDRMOE5KVDYzNTVkWDN3WG5seVFjS0dERHh1eTUxdklucHlTMzlVUGJJRWtB?=
 =?utf-8?B?bGJPK0ZEaG1pMGE4dUNoclZjWWJzWHJPNW51R2ZvTkFmUE83NjdtbVA2TC9B?=
 =?utf-8?B?YW1IY3B4RFFuaE9KUXVuaDNBRDh4SzFNdUhSUEtmNm5ReW1lYkdPeHdNa1pr?=
 =?utf-8?B?L0hzRXFYRjEwa0JaajIwRGJSOXp0aXBtSndrZkJJaVk1SlA2dUpqL1NwNGtV?=
 =?utf-8?B?Z2FrejhUN2VHYkd0ZHA0UDZMc3hhSE5HNHRRWXk2cFN2MXZ0bW9FN0RJOVBC?=
 =?utf-8?B?TUowUXBYb2ZlSW9TS3lSZHZyUU9NMDhudHp0YlRRRE5LYzRacTRTU0Y2S2ZY?=
 =?utf-8?B?SUFaZmFPOXVaUHB4RzFqQVhWc3lMM1ZDTXBXL0xmWGpQMlRTek4xZXZwMklN?=
 =?utf-8?B?WitISTN5SHFuTDg1TzFoak9IWFhFeDJuOUQwV0s4b1NHMEZTTkZkMFppYlVm?=
 =?utf-8?B?cTV4U21nQlh6UHJuR0JVOWhvT0NPb3dWOXlrbVl5aStFbnFrUDFQbHdOS1pw?=
 =?utf-8?B?OXN6cHUxbDlCd0JRc0hTdmxUeU5qWjZjZm1VRjNHVHVqa0FoajVMVVY3NlZr?=
 =?utf-8?B?UVNqV1QvTVE1TGlBNGh3SU0xR3p1UXhaTXU3aEtzOFRWMTNrcEhVajdMdC8z?=
 =?utf-8?B?YkZpMDdpcXZQVG8ra3ZhUUpQdTdMYVY0NWs3OCtaZ0MyWXlZNm44cXlaajNF?=
 =?utf-8?B?VWJlMnE4dzlRYmFCUndzRUxBMGU4K3VCQ3A5SWkrVWdxRFFURTMxT2NKMkhD?=
 =?utf-8?B?QTdOVmhtdGJZTnIwSDJuMGNMQksxN0Zhby84QUkwMGtMcGQ1NHJ2dVRDZm9H?=
 =?utf-8?B?SmRnL3BOQXBzWXA0UTQxMVlyQ0dTTUhKSVBvVldlZEhRVVZmWnk1V3Exc2Rt?=
 =?utf-8?B?NFZrUjI3VVk3TjYzeUtKQ0VMczJ3S1plczIrdFo4TDVib3drejV0Q1JMQ2VQ?=
 =?utf-8?B?Z3E5ZEVqdlVGTEFLcGVlaW1Oby9QVnJSb0gvMVJBUTlBNXZKTXpMbVdEQzFI?=
 =?utf-8?B?TStnOTdxeVprUVE3a00zSEFnOC9pZ2NNNEhLQnFkM1pZMXRCdzhpN1JPM1Az?=
 =?utf-8?B?Q0IyWnQ3MXNwcUdabkdicDN6TEp6MFZLNDlmM3VvZ2pkV1BPUnRmeDlRdktj?=
 =?utf-8?B?NkRWcTZBRjlPWDlodnFNMWpEc2JIN2huckhWcGZGQ1UreTMrV3cxNHRsZ0Fa?=
 =?utf-8?B?U1ZGOXA0STI4dUhsSC9UdnBhQXpDc3d4RmQ0VkhLNkVtZVZWcXQ3dWFRL2ho?=
 =?utf-8?B?WXA5dFhtd2dQcWozby81R3o2SDRaUFlwWWZvSTR6NkJUZVMyeEZjcVN2azk2?=
 =?utf-8?B?N01WcXZ1VG5EZXE5cW5kV29UR2l6aTZyOTBwem1yZjVpYm1xZW1saGp4RG5o?=
 =?utf-8?B?eWU2MEJsYXRFVzhzMUVlbVN2L2JsZ3NiL21zcms0Q3VQNkcyZ1llSE1FaVZz?=
 =?utf-8?B?TU1vNHlXdUVISjYvVGZpL1krbndUVko3ZUVSRGw5dCtlbUl3ZUlqZjNGMmZi?=
 =?utf-8?B?WTMxU2V4Mk16bEQwdVBoaHhFTjdyTEM4LzJUNTljeGptY2swbFY1YUJQSDFY?=
 =?utf-8?B?Umc1WlhGSWIyTkU2MXJpS3FBZWg2WWJhNVZMd2l1cGZOYjU1dzgyazRUR3F5?=
 =?utf-8?B?bHBvd3ZzSHlaQXFZK0JxY3ExZFdUOVQ1N2ViOTZlcGREdHprMjRMelpNWFhY?=
 =?utf-8?B?MndYRnozczNzLzdSREVsamNmZlhQdWxMdldlNlp2ZkFralNKVldxelVmdVBJ?=
 =?utf-8?B?VDlhZ2s3UThGcG5zZkR0M3ZLV2lqaFpVSHhxSGY2TUxuWXFsSkxmZERNbFAr?=
 =?utf-8?B?NC9NOGlSYzcyYkhwclBjbXZmMSt5NTNpZGFFbjJOVng1bEFJUGp5bDg2RUNk?=
 =?utf-8?B?SzRoM1RDMFg5VC82ellabDY4UGJEbTNUL3YyM2U1anQ2bHZWTHljRFdOQzZF?=
 =?utf-8?B?TFViMmx6U3hZVjZ4ZlJySElpVHdtbHluelg0SEJMRXMwS3VudWw2c1pYb21n?=
 =?utf-8?B?M1BNS0RDOS9RK1Z1ZTZzaW5SQ1haTmRhN1pyVUhpdmZLWjEzMWdUWUVVQklz?=
 =?utf-8?B?Z09YcGlrNWkwUWNyZ1V4N3g3WEdZV3ErOWpXblFPdGw1dG1VODlWcGFkcHhM?=
 =?utf-8?B?cTEvNTIyTXFJU3pxLzI4MlRHYVorZk1TN2ZOaWNXYngvd29iblR6Z0ZxQzQ3?=
 =?utf-8?Q?TKuQRGkhb03hJOkZ+a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe62f3c-f7c0-48fe-b8f1-08de737e7bcf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:27:01.5117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9N2Z+XmzZv08xc+to7+BBxeUJyzftWF0p8TAoC3LcMNzNJ/KnMZTdmEb3Kh0MfL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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

On 2/23/26 22:50, Bart Van Assche wrote:
> Mutexes must be unlocked before these are destroyed. This has been detected
> by the Clang thread-safety analyzer.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Yang Wang <kevinyang.wang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Fixes: f5e4cc8461c4 ("drm/amdgpu: implement RAS ACA driver framework")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks reasonable to me, but I'm not very familiar with this code. So only:

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> index afe5ca81beec..db7858fe0c3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -641,6 +641,7 @@ static void aca_error_fini(struct aca_error *aerr)
>  		aca_bank_error_remove(aerr, bank_error);
>  
>  out_unlock:
> +	mutex_unlock(&aerr->lock);
>  	mutex_destroy(&aerr->lock);
>  }
>  

