Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA80E73156
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 10:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D9410E417;
	Mon,  2 Feb 2026 10:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dG1hyhjJ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010030.outbound.protection.outlook.com
 [52.101.193.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE78D10E417
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 10:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkpzTF43HhE9IbKwbmHJVrIC5p6dDo8qBJSl9BDK5eFVieTRySTH/2EX+smugkpy1x5ofFrdZhOYzGq8Ej0tOy/sP/5vhuQ4YC8fPNXqwOTfbaYH4t9Z8Oy1y+/C7mhB95gjlRWL9O2O/XnTl5OIEYfD/0IFZeFwtXmwcE5Cp0NfpfLIP+Zd7NPXhWxRIX+hgYsL/H1fOzc7zvR7F9DlSPCNRLFoL9S0Qa8srriFQu+CXY8TMYb8/Fb45+Q/JYMckA5VQt/xVUoQxajOl27sUIKa2zpiikMEDnXtdDnBQg1aF77ppqRo3rMj1wvHsAHExfmMtU1A24Y9ZefJaFWqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUnLkHTOmBR1iJTGI+BQxohfkUdYdEpw4vRMheCMiVU=;
 b=tefxhioK5Sh6aJWxvLgUsKoDIHXf/K6DN+auqAmzpe+2Be4/rU5iDqoTwpEkX+TtOXktQ5KN0zVOFqKphJvVf8EpG5eu5mcr6HNAIieyQEAAioep3w98QlUPlV2RE9hJK2lijspeKIJgyCP0swxp2hCQXZXl4pMM2eRLjuHmRLI2omXRaIiNwyTO79xjG14FI2xBz4fS2PZIbdt/bONyvtlOvM4oX2gWaaxyby0JMUABiSVzBd3xgJyqr3jGXna1wINzuCGKyXPNE1sU8GZHAWeCWTAMguaaEH/lPDveX70MNuh2xcgOszn6J9f05RHPk3TAisBPpDf9KHcICd2flw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUnLkHTOmBR1iJTGI+BQxohfkUdYdEpw4vRMheCMiVU=;
 b=dG1hyhjJUtorxB81hyOtO0fYKfSmZ8a2K4tPTm5CJMIbSg6DERHKR0i6nrLOtHLcf7Ard5gIcoQPnGQLLQPKTwKK9ZIf4sqyZABHuDnWFlziSvtig/XtuvutnAr5t0PXPk7tS6XFaeI3EYSgaTqGOpWq0/9iPOS8TSc27xL/VgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 10:39:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 10:39:46 +0000
Message-ID: <d57a4e9c-d0a8-4ae0-b289-6131bde9c72e@amd.com>
Date: Mon, 2 Feb 2026 11:39:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix TLB flush failures after hibernation
 resume
To: amd-gfx@lists.freedesktop.org
References: <20260126194057.7376-2-sunlightlinux@gmail.com>
 <CADnq5_MSvWLVqhgkdaYn6bjPC2L2=jf5v=h3n1cx=ZYgnXLQPQ@mail.gmail.com>
 <20260201190535.18575-2-sunlightlinux@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260201190535.18575-2-sunlightlinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0371.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af415b0-a547-49c6-8fd6-08de624761fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFhTYWU1ZEZBMGNUa0xkejRISGxQdXEvRzFXcEJpQ2ZNUS92VTY2eWJEbENB?=
 =?utf-8?B?V0gyU1BXVXg2ZTZ1RXdUTGRDSVdNTmVwZE9iNk5SRzdJYUJrMS9mZnpjQkpi?=
 =?utf-8?B?WTNQcnhEUEZOWng2a2pqWFExQ25uTG5UTXdnZVptemhKWEVENm5NWjIydVY3?=
 =?utf-8?B?bnFEN2gvN3Z2Z3BmQm1oU1lNRk14cFkxZHlYcThGcWdUQmRWQXFRSFlmaEJq?=
 =?utf-8?B?RjFzc2tsT3JISEh6Y0VraUU5VFVBVGZ6VUdVbHp3eUljKzNnbHMveHdvdXh0?=
 =?utf-8?B?VGkwWS9yVFZXUVNjaC9nOGYvcnpOOHd1ZHhmVTQ1UlhjalZ5eWgvNTNKYTVn?=
 =?utf-8?B?cllWb01JbmE3aHZtVWpVb09UTGxKVTdXNDdBaWV4eHQ5QmttWUhUeFBGdDZT?=
 =?utf-8?B?d0FGZFFnSlNDeFhrVXJycGhFQXNYS0NaVXBuV0pUbi9SRzZvR3J0ZU1jeU1D?=
 =?utf-8?B?RDRXM3hQTEkzbURQVWd6U28zV1JpTENtWHhpTWUwQm5mN2p3Ym45T0p3Q0Nv?=
 =?utf-8?B?a1UxTXVtUkVNTkJDaXZaR3Z4V2RrTE44SEpMVG5ZRU1YMDdwV3gxVUVKcjJL?=
 =?utf-8?B?eDhKbzBBV2dxaHJleGtzZ2dEV0FkYVNEYmdXbjFxTUVXV2p3Sml4YkswN29V?=
 =?utf-8?B?bEE4U004aXpIcFc1a1UxQnZYVWVJcm9QanZUTUhuVDJUYkVNVW16NDludVg3?=
 =?utf-8?B?cldQbEJVOTB6V2gxbHkzSzN2cEFSQlZXTDBycVdkeXFaU1dJOE53eEhpUVpi?=
 =?utf-8?B?MlkyUHZ5QXdRcDVZandaWlpJeWd2TGMzd2ZrbE55ZXNjOHViOTkrYXM2Ly9M?=
 =?utf-8?B?eEQ5OGdLWUdOVS9UeVRPbERUakZYb1oyRVNyTXppWk9hTDV5N3NTZmQ1WDJ0?=
 =?utf-8?B?Y09Rdk1GNGFTSkFBRGZpUGhLbjh1dHVNcDJET0RNNEFTY0p0UGMreFIxU3Nl?=
 =?utf-8?B?R25SUkxHdVVYSjBhOGZ1MWt2Wm9wZ1RFVGNCNTlBb2d0R1N5dGZ1OWUvTmw2?=
 =?utf-8?B?TzFBb0VBZUcxSXBLN2ZUMFVtOGRRVDhaVFUzSys4NTZkd3A0VHBDQkRmL09u?=
 =?utf-8?B?NjRDTjUxZWw0SUpGcnd6Y2NJWlRKSVlMUHJEdUdRTXdCRGhReDdJbUc4TFFs?=
 =?utf-8?B?K0xqanpVSTl6dExLeEpuZkJMQUlaM2UvZzBXdTdHYVpGK2Q0c0FSODJKZi9v?=
 =?utf-8?B?YzNRVk5TZlNUVlg1YjZlQ0psalZOOUhualN2ckZtSjFqcW13TGtRWEtiS3JX?=
 =?utf-8?B?VThpVjNiR3U2MGpCOGNncHRYL3JUdHgybzg3SzJXZFZ6R0FXOVRIODBBLzc0?=
 =?utf-8?B?SVpEeHE4VHlvNENFRnkrMTBTTzh4NFBsSkxSQU5PSFpseFBNUUVwU285cmlD?=
 =?utf-8?B?VnFocmwwK3dTbEN6SG9zcU9WQ05CclJZN0MvUUJwUzBrMUZ1TmlkOU5ub3Zr?=
 =?utf-8?B?cVFjN0F4cXR4enpkQ0dCMXdNNnV0ZmlQT0hUcUdXR0xhck0yenAvcmNVeDEx?=
 =?utf-8?B?UjM3ZEpGd2RMM21oblZyWE05MTlSck12QnZ1K2RJRDBaVkZEMUl3QUlPYllS?=
 =?utf-8?B?WXJLRnFTVkxNaHhGcjRDelhjY2kwNDRIeUFQS0RuY0pzb1JiOGtxaW9reFdo?=
 =?utf-8?B?MDJYYndnRTBQbDJ3OFlWejhEK2JmUzYxNGlqL1ZKZk16azY1Y0M3WXNhWkVT?=
 =?utf-8?B?VzE4YjF1RVBYNGZ0YkVRQWJzY2c0RTkveTZsVU9CWlB0VUpiWUYzU2FTR2F0?=
 =?utf-8?B?T2VIZEY2S2hXNkV6bVdWTXpMdGhVZlNVSHF6bW5PaVlkemxJRjlMa0l1WU83?=
 =?utf-8?B?ZEFobTFrM3JjZmVMQUJQdHhMU3hFcGFJcFNobXlZdnZNcGZuZENSVHkzMkRK?=
 =?utf-8?B?SzNrU09UWjAvMUxNcWhxb29LNWZmYk5BUXJMSmM1OTVoMjROeFhSakhobG0y?=
 =?utf-8?B?L2d4UHRlQU55RVNxME5STytzNnhsZ0xjUCtzeGJ4bWRUUTZRK2FFdFVoUFFD?=
 =?utf-8?B?dFkrd0wwR05YRm82VnpDMlRiZVptRisyU0xBMElrQlZFdU84aWxXTEpVZVhs?=
 =?utf-8?Q?h3W3ij?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVlLMWVKM2RIK3Bxdldkb21lQTlwZzdkV3czREhEbmdWM3F1Mmo2TTIzaTJZ?=
 =?utf-8?B?RXhCN1NOakZjSW8rTlcrbzZYdk1iWDBVUC95S0cwUkdNNmdueG15QStJREpw?=
 =?utf-8?B?b2h6SGlaRTNKUnd0QmhFWUJBR0VUWnV4QnNiRFpyNTVKQzFZbVZ2b0k0TjZp?=
 =?utf-8?B?L29PbVRBcmNDbDd1amRtc3ZMRlYvMUtLNFUwNGRGRU1KU2wwdzhjLzNRbm5D?=
 =?utf-8?B?Mi81NEoyKzQydDRGamFzQzNZZks5SlRjYjhJK0dwZDFpUlVMdEd6bjZyUThZ?=
 =?utf-8?B?dURESm1FSFhyNzhYMXJNRm9qMnlNSnZWMlZkQVBmYVFwdDFUQlFYaFZvVmF0?=
 =?utf-8?B?eld2Q0JUSExwb2pCSktrR1RGRUlmN1JTVkI5K0JmTzhBdUdKbDYrUHgxTWVI?=
 =?utf-8?B?aTdzYldvangyMVV3c0cweWtxZnZMcHZaQUVSZXl5VStyRWpwanJhRTZ2Y0gv?=
 =?utf-8?B?VUhTc0NOSzQvWGNYcUkvbXRIYzlQSEl2WDE4TFA1am1wWmVsZlFoajBGME0x?=
 =?utf-8?B?U0gwZm5YdUd3RUJOaXpXVktnUEs3dng1UHkxN1JQM21pcWFSWG9yWTdPRHlD?=
 =?utf-8?B?YXdBWngxL0dNQ2VRYlRtdi84c1l6dkJEWDllWk0zb1RwZ0lPczBQWHgyNlo3?=
 =?utf-8?B?WVdZU05oUnYzUzJLb1RycDdHRDZLRldDVFZtRWovajI2d0tUa21FS2h1ektR?=
 =?utf-8?B?TEh2ZUpZcW93aGQ5bEg1YVBFUWV5N1V6NkNJSUROQUVac1MrR0NFUGNYSW5L?=
 =?utf-8?B?ano3K0t0UjMwdXhTVFMramNOZUxNU3FTSkJGbzdlVzduWGxTYXdpOGVYVzUr?=
 =?utf-8?B?NnIrcHdpcW4ya1BIeFppT0d2YjFJZFZrWm5CcjhNNUVRcDErSzNvK1BLTFRy?=
 =?utf-8?B?NTlPajBzZlVCU0s3UnYyVkc4U3ppTUFrWFpmazdUeHIxY25zeUJ6cmRCRGpO?=
 =?utf-8?B?aEsvTDlhUjIwYysvQUxmVGM5am5lV0Q5K21zeEpLbU9mZmExdkh5NzViOEJ4?=
 =?utf-8?B?cnlSU0toV2laN1hOL0h0c0xkZ2V5WG9hbjVUbzd2SXI5eGpWSVlBOHp6RjRi?=
 =?utf-8?B?UnFpWkI5OFJlbERRL0dPZFk3T1BpSmZOSVZxdGQvM0hVNVNmWDlkUVg1NkRa?=
 =?utf-8?B?Um5DOVJGZ3hETXcxcU1EeFRGb3hxNXh2dlROSGJZTmN4Tk8yMmRGZDRtT1o2?=
 =?utf-8?B?SG5BWTlreENSenkvNklJRkFnR05teFByaG93VzlGU1dSVjFKQlIvdXhSUTVn?=
 =?utf-8?B?TW5HQk85czduNHFMWklreEd3bzZIMS9tWkdQT3NMSHY3RUlSZU0xakhMbUph?=
 =?utf-8?B?aFF6WWN4eDBmcS9MS1hMQTlDL2w2d2E5S0JTaHI2Z3dlV3ovR2hEZkJ1ZGRI?=
 =?utf-8?B?MDZMc045R2Q2OEt0OSt6b3FQeEQzQXZHZ09qU3FucVZKamR3Q3kways1RzIv?=
 =?utf-8?B?S3psNGF1Q0UzQ3FQSzVUZmhKcXUyS0ZWTVEwc0UzMnQycnpCNTZyeFdXd3k2?=
 =?utf-8?B?RW53aUhCTzZ1U0QyQmFaVHRNM3ZYU3oybDR2WnJPRlZHcW05QzlLb3FzMFQ3?=
 =?utf-8?B?M2lrTU43MUcrdE9Cenl1WnRZSFZYalZ4T2czK2ZYR2VvRmJVRHFRTG1lM3Yx?=
 =?utf-8?B?Q0pmeVNVTGljUm4xUGZ5WlpHeTAyN0kxYWJSMnU3ZXphWDE0QVVhTFIwdlNr?=
 =?utf-8?B?UW9VNEd6elBYMTBucEpyV1JKRUQyMEU2VC96YmVYNHVBdzVubXo3bnJBY3Vu?=
 =?utf-8?B?d3ptcTdDaFRhWFpQcE9FS20wS09Dck9XbHlwTXBwVXFwaXJVYjdjckgwVjdr?=
 =?utf-8?B?OHFkeWdxSzRLTjAvN3M3YnZVczA5Mk04MWlRbHRkU0VYbDczNnJtOFMyY2tC?=
 =?utf-8?B?bXFDaloyelo3c05Wb1F5dkI5NUtuL3Z4SWhVb0tCeWFONXpweDE5VVRxNGJp?=
 =?utf-8?B?M1ZncXNOaWt3ajl5bFl2dlJwWjhWbFJZN3VMZCtENkMyVE9TMjVNakp5QmZl?=
 =?utf-8?B?QzNMaHdhT2V2VC9oR2Y4UlhEQzdjekV4bjJ5dVVVZzduelFxbWpPV3UxeHF2?=
 =?utf-8?B?WVdqZXdKSWJhcFhEK2lTM1ZyZVVabXJMNUxldWNsK1NpRkRmS0dIaC82Y05V?=
 =?utf-8?B?ZnBmbHR4NFVwbnFhZHRjQWViRFBPT1hGNkpTek8xclRmUk9FcW0zVXJWSG1D?=
 =?utf-8?B?a1N5QkM4bDQ1Tm5PZS9yT0YwNW4wZTlUODMySDhUSVFXSFZuSXJBR2NXeGdh?=
 =?utf-8?B?WVBpam1oNzBUcm0vMVFlbXlUd1UxM3ZwYWJOR2NwRk1oRnp5YXVaS1pNSXNJ?=
 =?utf-8?Q?rm7YLbs2IiGGl9Iayj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af415b0-a547-49c6-8fd6-08de624761fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 10:39:46.2736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8o2VCjyGJdWDwQm6ErNW+mRw1EqgSmiJr/yx6nFeZO/SvyNrVopsIKRXOX0snl4X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
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

Hi Ionut,

On 2/1/26 20:05, Ionut Nechita (Sunlight Linux) wrote:
> Hi Alex,
> 
> Thank you for the quick response and for the information about hibernation support.
> 
> Here's the stack trace showing the call chain when the TLB flush failures occur. The issue happens in two places:
> 
> 1. During resume (hibernation restore):
> 
> Call Trace:
>  dump_stack_lvl+0x5b/0x80
>  amdgpu_gmc_fw_reg_write_reg_wait+0x1c7/0x1d0 [amdgpu]
>  gmc_v9_0_hw_init+0x2e2/0x390 [amdgpu]
>  gmc_v9_0_resume+0x26/0x70 [amdgpu]
>  amdgpu_ip_block_resume+0x27/0x50 [amdgpu]
>  amdgpu_device_ip_resume_phase1+0x55/0x90 [amdgpu]
>  amdgpu_device_resume+0x69/0x380 [amdgpu]
>  amdgpu_pmops_resume+0x46/0x80 [amdgpu]
>  dpm_run_callback+0x4a/0x150
>  device_resume+0x1df/0x2f0
>  async_resume+0x21/0x30
>  async_run_entry_fn+0x36/0x160
>  process_one_work+0x193/0x350
>  worker_thread+0x2d7/0x410
> 
> 2. Subsequent failures during command submission:
> 
> Call Trace:
>  dump_stack_lvl+0x5b/0x80
>  amdgpu_gmc_fw_reg_write_reg_wait+0x1c7/0x1d0 [amdgpu]
>  amdgpu_gmc_flush_gpu_tlb+0xd0/0x280 [amdgpu]
>  amdgpu_gart_invalidate_tlb.part.0+0x59/0x90 [amdgpu]
>  amdgpu_ttm_alloc_gart+0x146/0x180 [amdgpu]
>  amdgpu_cs_parser_bos.isra.0+0x5d6/0x7d0 [amdgpu]
>  amdgpu_cs_ioctl+0xbd0/0x1aa0 [amdgpu]
>  drm_ioctl_kernel+0xa6/0x100
>  drm_ioctl+0x262/0x520
>  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
> 
> Error message: "amdgpu 0000:04:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706"

well thanks for doing this, but that unfortunately doesn't help us solve this. That result is perfectly expected.

Can you check if the KIQ ring test is executed correctly after hibernation? E.g. what happens when amdgpu_ring_test_ring(kiq_ring) is called? Is that called at all?

Thanks,
Christian.

> Full dmesg log available at: https://gitlab.freedesktop.org/-/project/4522/uploads/6a285ad2e24f4807e5d75c3f4ed5a7a1/dmesg-dump-stack.txt
> 
> Regarding the hibernation support issues you mentioned - I understand the limitations with secure boot and VRAM eviction. In my case, I have secure boot disabled and sufficient swap space, so the primary issue I'm encountering is this TLB flush failure.
> 
> I'm happy to test any patches or help with further debugging if needed.
> 
> Thanks,
> Ionut

