Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693DED262AB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 22:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E1410E186;
	Tue, 20 Jan 2026 22:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5U8hOAOP";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C1310E186
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 22:38:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1jTVcy0v/B6WNaxoDsJFXTPH25/dgOJCBnMjMJAt8oU9zGiLWa4R2cOIAH0Vjby6PhVgaJ5yBHKnYDFN0FVM2nlXEAIKtbZ88tqcgc/0s9GC0NUzIqKxADMkX9WJAg7Ab8Ll5YUY9t21U3TR04tuRZpe2cFJ1QhLSf5+9QYE6FOReHX1Kv3i+yatI8A+HeFeI5qgAXu5z107NLawAS+UMlif24tjaK4VLHUTSoDgme6dvZnCTD5FmG9h9CMm6IHogU4xU0OkT930bB37ELhqxBDahDDCMlyBOcLEhPZdA0bc5nhYFLzsLJkuJWN5K1PtpM/2JXGuSlllnJ7o7oxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCJSoLh9MzgWkRaPpoPTXeO02A4BwlAtbsveI5F9Kvc=;
 b=OhUV53zfyj43O04REzwSdTJOrDALqKaInYymk7pKkH4RBYaDCxj4BCclynXpH1fOnGuBiZ5m01vMFATTm5AyIF5wyWkSg8OeswXN3fKlw0Zdk56SrZ/h69qpGPhrH5xBFF5GCEk2y2QFLWR2Pi3vccC4ix0plEXOeoWxz0XPopzVODDOeigxq5UF1dWFU0reebnTJFbND47hXRnsZwPf/KHxWRKZt0pKEj6Zt4vy7eSIefTH/IL9/oH1hvJvaM+l644Japh0dUs91m4JMfH7DbfmyDA0WJvC4ulIMmuDi8q47bApeUtHRcJ9Gx8n1T1leXDF+1STQd/EQXVr1Vcerg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCJSoLh9MzgWkRaPpoPTXeO02A4BwlAtbsveI5F9Kvc=;
 b=5U8hOAOPf2VvA0KTnNCC7J7uDWnyqLbpbW/v//inblvJG1BtBMjzxACGmY61Agnh0xbb1xx3OqVnwBLWE7Kkp9loI4VpO0aFcnnJNXYnN/5Dfx2iPgiP75EgNcMO22EOx5fC7WznJpCxQ0rBaHTs1hVWPHJQBmdjHVhgn7KS7S4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 22:38:32 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3%3]) with mapi id 15.20.9520.010; Tue, 20 Jan 2026
 22:38:32 +0000
Message-ID: <9bf05977-e1a8-4213-aabc-a92e5d60b2c0@amd.com>
Date: Tue, 20 Jan 2026 22:38:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/amdkfd: Fix scalar load ordering in gfx12.1 trap
 handler
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Joseph Greathouse <joseph.greathouse@amd.com>,
 Vladimir Indic <vladimir.indic@amd.com>
References: <20260116203932.988704-1-jay.cornwall@amd.com>
 <20260116203932.988704-3-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20260116203932.988704-3-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::14) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f961377-1861-4cbd-c142-08de5874a37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHRiNkY4ejFVbG11dTZkSW04aVJ3am9JWkQ5TUtsd2YvbTNMdU9NV0hHRlVa?=
 =?utf-8?B?Q1REZmtUUWdwajQ1QkZpNFQ2clkxbnpDdWdQNWRnUWxjcE9KZHBXb3VpcUJR?=
 =?utf-8?B?N2M2dXFBaVhDcGpGeXRobk5oZ1dhU1RUQmlIT1hXaSt1VWpTUzJ1NUVRbm5E?=
 =?utf-8?B?V1hvK2hPQ25zSXFZeVUxM2xzb3czKzJEQWNKTEZaY3M3V0UrTzl1dlVsMEdv?=
 =?utf-8?B?UVdUU2NIVEJhejdoNVEwYTVVa3NkTjc4OG41Mk12b2RrazhVWkhYNUxKOTJN?=
 =?utf-8?B?bTlsUnBxRTJTQkVCU3F2ZkVvenVYU2FtNzZJZnMvWFRRT3F3cFdmRzhQdERG?=
 =?utf-8?B?OTFtNXdoUWYrQzVOTTgvbzlTYmpCeCttRzhJc0VYK0RPUTRxRms4Zy9QZkRV?=
 =?utf-8?B?OGFCQUQ3cmpxRnFlSHE5YnhpckFvSzcvejZNcXUxVTRGR2hibmpvSHJNVlVJ?=
 =?utf-8?B?TjBYMVR1QVNuK2QvaDV3bWVvZ1F3cmxUakpUcElDNExrS3UvWk93WDR1U2du?=
 =?utf-8?B?M0twTkRvS1I3dkVEQmpxcHBaQXgxY3I4aEYwMGRWSmFvV3I3MHdKOWRiTHk4?=
 =?utf-8?B?K0xIL2VXYlV3KysweWJhQ0FLVGdudHZNeDc0TkR0ckNVb0ZEM0FaMDI5b1FT?=
 =?utf-8?B?N2VSU1RUZkRwV2hzTTJ4bEo1eWxZOXBpTkJZSWJMeGpFQkNrZEY1WXN1SnNX?=
 =?utf-8?B?cGZEYmhSKzNycHFkemhHNFBlajVGR2w2QWZDdlVpaHFieDZCK2piaTEyVis5?=
 =?utf-8?B?TkgrTm1UTTJXKzA2NE5lUlMxVCtkUjRGK1Z0Ym9yUnE3RnY1VnVZL00zZlli?=
 =?utf-8?B?d3FQSFFpOGNjMnZNVGE2VjlaeWtVR1orZDhDUmw1c0kzd0NoQ2J2MjNzWFR1?=
 =?utf-8?B?RE15cXl1Mkc2dVBQYmxaMGRXb3JYVWxUTmRCSmxHYkJJcXM4NjhrY2Q2RElW?=
 =?utf-8?B?RWhuYW9zYUNKMlI5c2VjYnhLNjBlMndERFlHQUFOT01YSGk4Rnp5K1NtbGpI?=
 =?utf-8?B?WTM5WDREZzVIZVdxMHArei9laExqM3JQOWJEQ243bzkwWlQvdWhIdDgvQm9U?=
 =?utf-8?B?YWo2dW5LMFJDajIrSkNzRVlQOVFscENjTHEyalhWUW9DazRxR0hVb0hEanF1?=
 =?utf-8?B?NFVUaDBSVE5iSUVvazNtbXlBaFNnM25CUGpUU2xpUjFFWEYzKzRJb0VUbUNv?=
 =?utf-8?B?RUEvT21QM3Y4MVVBd3U4aWFzSFJlMDBwaGdiNHJxdGZyV29qRUR4UHc2M3o3?=
 =?utf-8?B?OFNjRENTUDlteXlNTWt3SUU4NHFjZEtBbk53RnFUeU5pN1N2c1dkaExWQWxL?=
 =?utf-8?B?d1pHVEd0SE94Q1dTNjRSSWxoU1R3YmtCbFcxbVJ3aWJxTnYrdHl5VlBVakZt?=
 =?utf-8?B?ZG5jWFpsRi95Sm01YlFmVm1aellSbk56VW10SkhFcUgrSUVTb1hFOW5rV201?=
 =?utf-8?B?SjdTTFZzZ3JxK1dQYjNSVnYrTC9lV09BblFrOTA1WWhMV3ZBWlRZZC9hdXB4?=
 =?utf-8?B?eUR0WnA1Ync0RVNlQStNTWlNSW1tWHRCaHRtWWdidWFTKzI3N2ZQRnF6WG4w?=
 =?utf-8?B?UlRlSFZoVUZHRHhLY2FNdysyWlMvdS9mUmJsUlEwa0tZSnlIYjZuOHVWalVD?=
 =?utf-8?B?UVl2cTQrZ29ibDRXOG95MG9mdUN2MmJYUjdmdVJpTGZxYTJ3QTduY3NseGRZ?=
 =?utf-8?B?RWwwTkdHRzlFM2NrSDNDK2ZRazZQSkhRdVIxeDFhWXAreWdidE9jencyWVVw?=
 =?utf-8?B?LzVtMlgrdGZEUllvU3JkcXNvUW04enk1MFErR2RFeTdQRHhkWWZmNGtOc25y?=
 =?utf-8?B?TTQ0RVE2OWl2dE9iUUtlMXhJZE1TZW1TN1RCaUppZ1JlVTUwMml0aThZNXA2?=
 =?utf-8?B?RzQ5VTJYbjRqRi8weWRHeWNoZ2hUcVdGd1NTL1RaTktjaDNHeWRWMnNoR3VE?=
 =?utf-8?B?WDlXajBScnNyS3RJdlF2YzBraVYyUXk3RE9RQkdWNjgzMHBhY1ljc1Z5NE5P?=
 =?utf-8?B?bkl2TVRhU21IaGVnQUV6S1ZkcllVRUYvK3J6RW9GQXFvSjJUV1h2VFowekVH?=
 =?utf-8?B?SXZwejlYVTFWbEFUdkZkY2lIUG52NXRKYzRIVVRhbFE5YngxcGJ3U3FDZzBh?=
 =?utf-8?Q?X3ds=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dCtBRFZQZ1MvR0ZycGx6NzV1TEU1QXB3WkNraDQwODVEbGRCckFiTVpSZE5p?=
 =?utf-8?B?MUlFYXVISDd3bHB6cnNVRHhjT1BlM0VKZW1BdGRBUjZRZHNRZStXbzgzN2Jk?=
 =?utf-8?B?QWFvVXppc25hcFdRUUxTd3JleW1XM2sxRHUwdnhJMlh6bjh1VW9ZdHZzcjN5?=
 =?utf-8?B?WGFGMHlyQ2g3Q1J3aGZhUi9pbVZRS1FhZFhFeTFJYVhEMk9DbzJyR2JUUmho?=
 =?utf-8?B?by9mdEp4UlhGZVlKOS8rOUJ2Y0dISjRzMG1zWTUwdUdtQkxvTWUySEVXUUtr?=
 =?utf-8?B?OEVqMlU0MUlkejZ4SmxHNzJWWWVWSVNuVlMyV2pXd29RaUFhRjY2YXcwa1J4?=
 =?utf-8?B?MlBlK2ZPWXl0Zkl1WmxxaUpWTzkyWDBNeVhPRE02NythbFBMK2czbU5GUXNE?=
 =?utf-8?B?ZzY1NUhBR2dzeWZ5b21HM0xCZWd2bk9yWFpPRUU4T1phUTAxZ0Y5Njc0K0dp?=
 =?utf-8?B?ZFlWZjNrNklCZmt5Tk02ZGExVk5rTk1xaGlrdUMxT3FhY21EaWNCNnQvV2V2?=
 =?utf-8?B?TW5rMUw1UDBsOFZSa3pGM1E5cFZ4c2lMWlVtNk1qZEdpZXNRSjdRYUNHYVlB?=
 =?utf-8?B?VXJtdTMzSFZOU3ZIZDF0THZSZElKU1hxUHdJZ2wybGt3YVhYbm9Oc3Z3RC9j?=
 =?utf-8?B?U0dudGFYYlNsbVhrZ2xYVElYRm01cU8rWUdUWmZWMGMzYkhVcytFWjl3Si9p?=
 =?utf-8?B?aG9UQjNDeEoxNUFrWU5XRVphaFFTUk1OQ21VaWdWMG50TFJsN2RxWVNPWHpp?=
 =?utf-8?B?VVFHSVNLNTNncFZxZXVtQ0ZtUG8wU3JKV21DYlI5Y2VNbFg0cWRMcjBpaUxq?=
 =?utf-8?B?M0czUS9FMkxzdVQvR1dSOUt1MjhycStIcGlTMldHU284Z29LQTlPTWlpRVJN?=
 =?utf-8?B?dExYdS9rdmhhdUNxOGd0TnMrSWpDNlNHanZ5NG16bjJudU1EYTNZV3ltNk5o?=
 =?utf-8?B?VElnK01LWFIrYWpjMjVqTnNQZjFxYThHT2hVSVBnL1VvYVRLWFB5bkx4NDFa?=
 =?utf-8?B?eFNEQUVqQnpDMEJWNXBGRTV4dnh2UHMzWjFPOFBpeElQQjBrZ0xQNGxabkpw?=
 =?utf-8?B?ckZsdUNLc1pYcFl3TVdXcjFJREJUdG1CVStWOFNzY1hObFZ4ZUVRcllWNUMw?=
 =?utf-8?B?dklWOWVXMDJOdXpmallBSk5iTEJUZjREd0lqTmozbDlaQlhUUDZLZFZITzdt?=
 =?utf-8?B?S0RXK0owak42WUNlRnl5TGQ1RldTS0l5SUNUSXpnenROODd1SXk3ZHlVbVFn?=
 =?utf-8?B?aVFyQThMS0czMzBPV2FZMTMxbE4wVUlYcGhVcUhob1l4a3VONjNaUTYzVFZX?=
 =?utf-8?B?THUxaHJlbUxuNVNCZWozd0RMclArWFFteHJIV3I2OUdqcGZ4SFN3SFlQSlFU?=
 =?utf-8?B?L0YzQ3V3UG5YMFJPL1ZlbnYxZktYYi81aklsYVZqTzNMaDVISUtoVFNObGZN?=
 =?utf-8?B?a09ETWZ3SXpnaUlheE84SEVwWnpqQnRkQlNDZUFXSDUzMmxyYzhEdVA2MHB6?=
 =?utf-8?B?MjRJSldyQ3lORGh0ai9KUjlsQnhDYWZQd2lMMWxxMGlQbDRpUEtnbG5XUzJv?=
 =?utf-8?B?QUZPbCtQNFpQUHdrUER4dFE4K0pxL3gyTjlhOW1OdjdmNXBPNzl5VE5mNjlP?=
 =?utf-8?B?S0tscjVEc1ZaVnRSZTdPVmI5b2dEUkMrNVRyKytJbEZZSjhxSmYyRHF3bTdt?=
 =?utf-8?B?QjQxYmVqSFpkeUV5NEU4SlIxSHlXemthRU5YYVNiVlBVUHZsZzVJcGVtbm1X?=
 =?utf-8?B?aHV2dXBIMzdKZVZwRTlJemh4U2c0MnVWR2ppZGxJN3prT3BZdTBwM1djU0w4?=
 =?utf-8?B?cEtwaDdXUFU1dkdEWXBZQVhsc0RjaWJEVWtqZ2VZWXhDVWFibElPMVNISjR2?=
 =?utf-8?B?TEM5VmFMN0lrWHJSVW5waE5hdzZrUjRIREhRTXpFUU1XMmZ5ZEVuWGtQTHVl?=
 =?utf-8?B?NGZrUlBEZXZVOXVPaHJNTWw2Mk54STJOY1JwaXVUK3BNYkFJSk5kQVhrS3M4?=
 =?utf-8?B?Z2tsTU5nQkg0b0dCbVVPUlFldDdJL2QzS3NOeHByNTJLRDJqYzBQdXZrdjIz?=
 =?utf-8?B?RFdzalJLemRWVkc4OWkxbm4rT01mUkF2bWIzSUE4OWhWVUlBdEQrd1lBL0FD?=
 =?utf-8?B?eUxXVXNMTjJaWk0zZ2ZidzBBOWRHbEwyV0l4aDJDWGNWSUNOdlhZY05Ga1FV?=
 =?utf-8?B?WUN1R3ptZEdYaGFlRTVtTDlpTjEzcHV5ZFhLNldXdXVuZzhudWFkQmJhU3Bi?=
 =?utf-8?B?cHR6eER5MWg2eFNQS0tXSVRxcDI5ZnQ2bEJJZTVuVVBOcnlQaEV1ZVdTcXhy?=
 =?utf-8?Q?rfV88NbsO++vCeF4s+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f961377-1861-4cbd-c142-08de5874a37c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:38:31.8970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3TMmj8z3oKhobQv6YiOHZaTzo0wZiLUQPDY96ZuEpTfHzxVjl39DTBlh3JeC37JcwPTFgxoZFJtwvhJlBCFkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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

Hi,

This looks good, thanks for fixing this.

Thanks,
Lancelot.

On 16/01/2026 20:39, Jay Cornwall wrote:
> Scalar loads may arrive out-of-order with respect to KMCNT.
> The affected code expects the two loads to arrive in-order.
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Joseph Greathouse <joseph.greathouse@amd.com>
> Cc: Vladimir Indic <vladimir.indic@amd.com>
Reviewed-by: Lancelot Six <lancelot.six@amd.com>
