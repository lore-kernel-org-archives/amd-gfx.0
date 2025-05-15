Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16008C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 17:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C0110E93E;
	Thu, 15 May 2025 17:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EIIjoOvZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E3210E931
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 17:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydHTGhMatQt/0d2I5pdUoF/gHIUgV6ODRKBYyi/3TlMhfROqZCfvZmzt+Ao9N8OGfw7UI1ZL76T6fOGIvlPyn4iEwu+GacvGJTKqCe5MJyAyncgdqqdRbvK7SPHWM7a0Ar81OvCeFfN/n9PPIFR0fpVqxnNkQXT0u4d9NH0IGRfVuw1MQ6CKURnGk/Tp6yUSqjJqH8Q0i5KWtkYgmMouEhyitPLBcgezPT8EOo7xvIfJq9WYCsZMAkECRqm3UHWBR+slXBgeJf2boSldwhZPVrFajw0aiDKzsNe8W8GnJey3ji0KmjofyCH37E03a+J347ZEsMqrqjuPPGrIohHxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70aLfK89S2djw0X+q4Ur5WFwFawDwlK+CWRKYdj/ZcM=;
 b=Od4hbqyO8emllVdTnE8q8FEslgaeo25wA1qucELv60SpYksXBsSOYO0rE6gmAzvIKhFh0cqwi5wOz7AUj1rBwKp4ZeNF2C/I0IPYlmcbJdy3Le7rR0HN2Pdkq0wdoTYA4hixchtScYiaWUSWqJwICUCENPbUvkKndPKn2uBZl2JM6nFIbsfhYmMXLHFEGRiBTYNwnBVKDfYguW2EA6WD71coJLb9Y6BIptTVXMeEuDu55h7J9+Xih+9aM9DT4G2RatC6p6qfkxfBtPEaKqTm2AuiG9NPN77oarosWwx/iqaXPwtYhrRX2BK+nTeQdohr/3VjknFgOZH8GjSD5lAspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70aLfK89S2djw0X+q4Ur5WFwFawDwlK+CWRKYdj/ZcM=;
 b=EIIjoOvZqkpBaUntvj3antpdUQWC7fOD/5A4haVp7OlIxzYXMbYFl0UZXDSQQoLAygbRFUhXI1qVD1A3eFzS4IiS4UtjPlM4zhAsWV/xbRY7EaZxhN4vGLD5pVz03TK9fMLikeF8lpAIjzXlYnUwaGTo70Xh10Dyx7JO34o+yHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 17:30:03 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%5]) with mapi id 15.20.8699.026; Thu, 15 May 2025
 17:30:03 +0000
Message-ID: <60bff45d-fca4-456c-984b-a09eaf081a86@amd.com>
Date: Thu, 15 May 2025 13:29:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] drm/amdgpu: read back register after written
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>, "Wu, David" <David.Wu3@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
References: <20250515164102.808954-1-David.Wu3@amd.com>
 <20250515164102.808954-5-David.Wu3@amd.com>
 <SJ1PR12MB61945DCC12B15B2F29F079079590A@SJ1PR12MB6194.namprd12.prod.outlook.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <SJ1PR12MB61945DCC12B15B2F29F079079590A@SJ1PR12MB6194.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::25) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d70aaa-f9b3-4957-e3a3-08dd93d62068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MktuVXl4STRIQVp4U3VzRjZaaVNWMnAyOWRhMmhLRHA2QXkxeGFjWTd6cFMv?=
 =?utf-8?B?QkZuNTRKOTJ0YXp2SlVnOTJKNk9FeDlhZEpHT1RUSDRxdWpsbmZ0RjdQYW9K?=
 =?utf-8?B?c2Q1TnBuMHlxejAvUFRjdTB2MEY1RWJ6NTJnVk1YSldxWW01UktnYXRDYklN?=
 =?utf-8?B?RXJINktURndKNjM1dkYxei9McjVaeXExRE1HUG1uZU1jT1p6NFJXbFI2TXNV?=
 =?utf-8?B?YlFNU1pKbHc4dFB6WHJtZi8rN2MzUDU1blRFVXNOelB4UUxEaTQydWlkZksv?=
 =?utf-8?B?TExDUTVSUjJGNGsybkJneW0yMnFUMnRTNVBMTFNHMG5IbHZmOHA2OHZzcG1N?=
 =?utf-8?B?YXZSRDc4QXdoU3lnZ0JDeHEyUDVoc3JrRmlKTGtEQzR3Tm9yNjBlZHdwcC9E?=
 =?utf-8?B?UzZWRFpPeEJkT09zTjl6MTQ4R2NuQmxaM2FJMDBTekxpeGRneTFTRGQ3MmdV?=
 =?utf-8?B?WGRyK2o4SHAzUnhKcWVUUWsyaGxTT2lOWFY4bllGWnlaV2xObk5pZjlycmhv?=
 =?utf-8?B?K0tVU3phZUMrQis3UnA4NTZ1clRlUFgrWlBvWldhQ0FSNTg3Ymo0NjF2N3pL?=
 =?utf-8?B?WUlWRVN1YnJoeFZONlhTQTRNQlB2SUhqZFcrY1pvRVdYSlJSRjU1eWVYUlVt?=
 =?utf-8?B?ZmYyNFM3WkZ4cGJoOEsweklveUJwSVJHNGthR1liM1Nuck05NUNWUm1sazNI?=
 =?utf-8?B?b2pHS2YvRmlIRkp0eGtGd0dlSC9ZWlc1QmErdGEwa1FKT3JWQVo3QVN6WmZW?=
 =?utf-8?B?d0pBUWNSVXJwbnJZUmhGczh2NVlWNnlhT0tOS0RldFJSd1B3aFJtOTVXYm45?=
 =?utf-8?B?cDFlcFlIQW0wcXlmWERObDJEZUFLaFo0Y2M2TnFSQUJCTE9TaHhQdDhBK3NF?=
 =?utf-8?B?bVZRRnF2b0NvZFlvUWhla1pOV2ZqeGl3SERPdlBNd2tndHRxdHY4Q0lpRTB4?=
 =?utf-8?B?eWFMOWorTUsrR0tQTi85bEU4bEQ2eVlJb25hRmRjZ2ErUjRTSGgrWHdWanky?=
 =?utf-8?B?dDRpYk56R3lDbThmUk42dWQ4SFU5QVdiZVp0TGhzcnJGUGJycVpYTXNpTG5z?=
 =?utf-8?B?MDNiek5IaGFIMlNTUmNPVnl4UXVCNnpxM0pXOXRYeDhoODRTOU9vM3lZa2F5?=
 =?utf-8?B?Z2I1MXFNMTBKSlIxWjNweTVod3pXL01LdHFPajJpNnZkdkNHOE9IU0Fmb3Uv?=
 =?utf-8?B?RWIzNFBnNVVrNXc2N2FsRWNoUXF3MHd4YlNjeDVUc3lhYlRLay8wOVBVQlBY?=
 =?utf-8?B?SVhsaEI3bTdZWW9JWk1nN2pEM2NBeDdTdHpEUElESHRvbzEvM05URSs0dHFB?=
 =?utf-8?B?SU1GSG1Db3JzeHcwenFxVGN6c1V5RDBCb0V0cWpzY2VGNVNMSmxaUkV3QlJJ?=
 =?utf-8?B?bDc0cTBNVk9qc0t6U3JUUFF3cnlIZGRsZFJCS3R5NjNRNXc2aVdaQlgvQVdF?=
 =?utf-8?B?Z1hjL3QvYlRtWjZ3aTFQTU42cFB1TlloYjNsSFJMNTFrUGVPc3M5Um9LcFpB?=
 =?utf-8?B?VitPNDV2OUVYd2FMdFJqbUZFUExiV05mdGh1OC81aFBHMGUrc3IySU40cDBE?=
 =?utf-8?B?NDlJKzZubjllOVVJa09vRk5aTTY3b3B0UnpmVEJYQ01DMXpIUmJkQ1cwMElC?=
 =?utf-8?B?SDFHaGUxejdpU0hRWXh1SVFmbThqaVBlTklXK1poNlJ2NVdJZHhaWEpiVHVv?=
 =?utf-8?B?NHQ4YkcreUxkcXhkNWVtc3JZVlpURUU0RjhLZFZvNFZpb3ozbTB2Mk4yREp1?=
 =?utf-8?B?MVhBeDJjeUtURXgwZWNwUTRuWlBYbXh6NkRnMU9lRHhSeU16K3F2U1FSdDNM?=
 =?utf-8?B?aGRHZC9odXk0d0JXUjBxc2FPZGNDZ1I4eG04bDRZVDN4eWhpNDJKNmtIeitI?=
 =?utf-8?B?R3ltam9xSm51U1NZVGNVZElEK1BuOHlaZXYyRVdWbWFvR2tCY1BRSjJhWmhl?=
 =?utf-8?Q?k5K+MdzB+60=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWF0aXdacktJTzBxZ3ptZnovRk0wUEgzUUpjbVkwWmowMFdVaVFYcEx1OWx4?=
 =?utf-8?B?dVFiMGd0Q1YxaExPMVhsSXhYNUE0azBwVVMzNExLVFcvUTJoTU5RUDZrTmxk?=
 =?utf-8?B?Uy9pNzFucjg3NGdzb0pLRXZHeW5COTIxUnh0c2MwWlNwZ1ZtSC9RRnJFWkJH?=
 =?utf-8?B?dHUwZjZGajBFRnB4QXJMS2VjQTlwOXZMcWRRL3l2MGw3SEd4Zk5la0FnM2ox?=
 =?utf-8?B?UVJ5dC8rL2x0SzFmaG9uMUczRzU4UGtkQ0FQK3cxdVVyeVBMaDZiVjBwL0Zi?=
 =?utf-8?B?bHJ6QzZrUTBYZHF6Rk45UFlqRm9BTWJSR3ZpMEpVZUorU1hQVFFKRTdkU203?=
 =?utf-8?B?aElEQ3BUSlEvamlxY0R3TDZBRXg1Wm5ML24waCtlYmg2aUVlcUdXK2lSQ0VX?=
 =?utf-8?B?ZlBkV2tPSXZFSXVRQ09iRUVlbDhSSjB3RC9rNXRSQUdHYmJKbmVCaGxlMTQv?=
 =?utf-8?B?STRvZjZkb0hlK1VKay9nQlJPNlpNQnFKRXNyWURya2ZvRUUrVzJBbGNpbGtw?=
 =?utf-8?B?U2EyWlJNUTJxekIrdjZhWjRvZ2Z4bTRaYUkzU3lEL0trV1JvejZla2Y2QXJy?=
 =?utf-8?B?R2NLT3V6SjNZNU1ITWU4K2grckkxNmZmdzZldmM4UjFvVWdJQkQ3Ty9wUzlN?=
 =?utf-8?B?bkpkb3d2anRkclhwZDIrS3ljTk1RNWI3WHdWM1Jla1hmRDJ5QnlqNWVIQ21z?=
 =?utf-8?B?bXFLcVJDbDFGeXFDbmJwajhtcUE1Um1SOXRmWC82a1BpUVpTYy9hZUFSc2hl?=
 =?utf-8?B?UWVkakpkYWlGQ2tGLzBiSHBidFM0djFBT1VVQ1g1YnlYVFRlVXlwdnJncnQx?=
 =?utf-8?B?cHBjejlVM0s3cVJNbnM3RjQ1Zks0SjU2dDhMYkV3YXd0djJsdGNkbUxVL2Rm?=
 =?utf-8?B?UFY3RlJxRk1xMERxazFMeWtZSU10bWVGRStYTHVkSjlTWHZqbFR5bUdXNnds?=
 =?utf-8?B?SW8vcFRCT1dZWEhZek1JS0V0RWtWeDNJd1E3SUNCRlJDb2lDaFBTSWRHck9y?=
 =?utf-8?B?VnUwa0tNYkE5bENaejdieW9TRVdtZHpzWkhjK05FWWRCT3RDWXA5NjJBb0lu?=
 =?utf-8?B?ODZORTNkc3g1SHV3eExzUlpwSzNQREQwRGorMjBGeW5aQWwraEJPeThRMlhQ?=
 =?utf-8?B?K0pWU1h3UnV3K0VjaENGUVVLZS9qQ0NWOHJqT0ZDVXZ2Vk8xM2Uxc1F0aU9C?=
 =?utf-8?B?WUJNOEhIbEJxYllqd1pTS1FvaGFYZXFBUHByL0wwS09WUUg1YktLMURvYUt5?=
 =?utf-8?B?UkpJektwdXhXejhXcUJIeGlvck1UbVJERFpWaitEMFAxUnN4VE5uZm9HdmZU?=
 =?utf-8?B?Qmtxc0lYNC9WeUdBL2hlb3JTWGRHL2x5dlRMaVFuTWdOMG45RUZBMWNjQUlH?=
 =?utf-8?B?ekYyYktBTHYybnZDcWJaWjBKRWxybEttZTh6ZDlMTlQxcHdBOTBhQmlyaFFL?=
 =?utf-8?B?MFZsWDVGL2pQRGV4Z2U0NGx4aGg2NmZSNXlqYTUxTUtKd0dPdHNjdlBPbFM1?=
 =?utf-8?B?cElPL28wSGZkNzQxYW5tRUhKV3VIQmRhYlBDUG8ySlM4RU11dDhsQklJUVZK?=
 =?utf-8?B?anROZUJVV1VrMjg3Yy9PUTRsMlZFMFl1Wk1TSzhnNVVNR09ua0s5eVFWVTVF?=
 =?utf-8?B?Znd4NEpBZnZ0SUVYNGpaMElZdzkwSU0wbmhkbHF2ZHlEanFXQ0dyRkFld0dX?=
 =?utf-8?B?MlltVmxaR1c3VWhIVENnbDRTUHVwWS9RUUQ0QW5MVDlpRWo2RGZibXZNUkpj?=
 =?utf-8?B?UGRna29laCtzcTE0M1MybVBOUlprTDNRbWN6cDZUeTBMb1hvWjJHbXRVTjdl?=
 =?utf-8?B?ZVg1ZllwRnMrbUFzRHNKRVgrRFpDNytGa1FnTjFyZnlieGdzdCtTOEtXVWNr?=
 =?utf-8?B?bHV1M3liS1FWUUQrOHJzcVFVZEl0NmtoUFV1Yjg5SzNqWlh4MkFLVjlVcVhk?=
 =?utf-8?B?QzBzbmZMMCtxaEpFbWFLclNTY0RpY0F0RHI2ZHJPaVpTczBDVFlzMHdSenlw?=
 =?utf-8?B?V3VLM2JVV3p4ZHZ0ZFB6Ky9wblBQQWt6UVEwTGkvREs5MkEzcS9DalF1WXZ0?=
 =?utf-8?B?ZEF6d0loLzgvcG9zSUJTQi9yVDRpaHp2R1h6ak1qSVl5N3djODdxTkxibHVF?=
 =?utf-8?Q?nsw+gq9k+PhLbsUu/RM+dQzbw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d70aaa-f9b3-4957-e3a3-08dd93d62068
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:30:03.4854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9JL5RzeHi6e3qDOR/dbIoVdfnAoa1Y1+tV5Gv9Yj2UxvWJLOd2y+0lZai0DVG2y42E9ABpZ1WERcTFy1dn61Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
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


On 2025-05-15 13:25, Dong, Ruijing wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Wu, David <David.Wu3@amd.com>
> Sent: Thursday, May 15, 2025 12:41 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>
> Subject: [PATCH v2 5/9] drm/amdgpu: read back register after written
>
> The addition of register read-back in VCN v4.0.0 is intended to prevent potential race conditions.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 8fff470bce87..5acdf8fd5a62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1122,6 +1122,11 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
>                          ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>                          VCN_RB1_DB_CTRL__EN_MASK);
>
> +       /* Keeping one read-back to ensure all register writes are done,
> +        * otherwise it may introduce race conditions.
> +        */
> +       RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
> +
>
>
>
> Use the same register regUVD_STATUS?
good catch - I will change them.
David
>
>
>          return 0;
>   }
>
> @@ -1303,6 +1308,11 @@ static int vcn_v4_0_start(struct amdgpu_vcn_inst *vinst)
>          WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
>          fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
>
> +       /* Keeping one read-back to ensure all register writes are done,
> +        * otherwise it may introduce race conditions.
> +        */
> +       RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
> +
>          return 0;
>   }
>
> @@ -1583,6 +1593,11 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>          /* disable dynamic power gating mode */
>          WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 0,
>                  ~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
> +
> +       /* Keeping one read-back to ensure all register writes are done,
> +        * otherwise it may introduce race conditions.
> +        */
> +       RREG32_SOC15(VCN, inst_idx, regUVD_STATUS);
>   }
>
>   /**
> @@ -1666,6 +1681,11 @@ static int vcn_v4_0_stop(struct amdgpu_vcn_inst *vinst)
>          /* enable VCN power gating */
>          vcn_v4_0_enable_static_power_gating(vinst);
>
> +       /* Keeping one read-back to ensure all register writes are done,
> +        * otherwise it may introduce race conditions.
> +        */
> +       RREG32_SOC15(VCN, i, regUVD_STATUS);
> +
>   done:
>          if (adev->pm.dpm_enabled)
>                  amdgpu_dpm_enable_vcn(adev, false, i);
> --
> 2.49.0
>
