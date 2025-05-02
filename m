Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9C3C3ABA9
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 07:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311DF10E0C7;
	Fri,  2 May 2025 07:55:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z/XdQfni";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62C510E0C7
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 07:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlfZqFgq+w/5/1zycF+uL4DrOfBOP9bQ59e//mZqQ5ybWJdL7cCZuuERPj3FNgMHGUftaJZHgV+JTBeX4TW4FsJUxTpxKVBWkfEXwhZN3+gXc8pNwuzuNbZnIYrBdGOMz7x2nt0K/zDYKhW4Hy96VswE4O+ghDwdxOruzgxBk7UgH4ugtnpmCtxw9iRtlCWe2qpe56uv0TL+xTfKCq+STSIIyl+vR05fWGy97DCKtWoE3CJPnQGXKJGhDQ6EI+HNu0WRAjsA2FNHFE6ECoSb3fTcopy2KEEECRvVgX8Ic/lKvNQrp/V8kQh3SCqmdPv6uY+YH3vOr/IDECJX5UJDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLKG7pouBuEyz6E0p8G25SXzXxMHaWUavfse3WtSyuk=;
 b=AoRcQTGS7saInYjqDlajFp90WhLe/q8usEVW/xL+95qQierVQMZbb9o9ybi4fHM1hjwu5dc02C694OLRNXR0LtL88Ypsm6C28jfwPiWh714p/Bmpymjrtq1FRorPy5mMu7rfvXB1I4c8dYX+4R67NPe4pn7KxNRjqtkCoef7iL2wcHPbyWiy0v567QjUHXtZzz0MDnsRq9kv9FqfC1le1s7jW0dzboEdO+DS+vl5/NQsCuxnuxOosPsnEFKDbqgKp7LZb4ngBMBP808LoQdxmQng/LVYCl5GXk8+2zePVPqMltgSGfvnOs8JGLfy1cZ4d8ulRlk6jKlZ+ksoyzjkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLKG7pouBuEyz6E0p8G25SXzXxMHaWUavfse3WtSyuk=;
 b=Z/XdQfnidwMrSuN+MukbY2bu9h4EjXsFt66Cw+ZHMRTkDplftvxoVxkyA9jJ/7lIto9wul9qKqyhHJGliBB6E8is9uy3BBt2SUMYGkV3v6j+SmAeqIk+Tw/MFSPUEWStVEEpkaNX5bVtSrBGkypkGNdawQGUs3m6pxt5ifFEQ2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 07:55:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 07:55:08 +0000
Message-ID: <b3f05cf9-2d96-4846-b768-834f0295aa39@amd.com>
Date: Fri, 2 May 2025 09:55:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dma-fence: Add helper to sort and deduplicate
 dma_fence arrays
To: Arvind Yadav <Arvind.Yadav@amd.com>, alexander.deucher@amd.com,
 sunil.khatri@amd.com, Arunpravin.PaneerSelvam@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250430160521.35670-1-Arvind.Yadav@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430160521.35670-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f0a6ac-aad3-4ce6-9b14-08dd894ea88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zm4ySUNDd09YRDJxOWxHS0RkR0ZGSVRCNjViSHVxNkdyRkcwcktXcGNEaEZy?=
 =?utf-8?B?YXFiYm1YeTMvY1pMKy9CNkl1YXo5TDRMamFnK3NOeHpaSkVQVEJuZDdjQldO?=
 =?utf-8?B?U0craGpIZWVBbVVzL0lQQnc2aWJRaTB5RS9HdzNNcDR0cWN5aW1KUXpadi9t?=
 =?utf-8?B?cyt2cStBSGg2Q1MxL01vNS9DakZodHB0ZmtFbEZ3SHQ1VUh6bW02U3NmMkds?=
 =?utf-8?B?RU1aTlg4aFRnUHVBdHVwZE5vMUFRUGdXZDUrQ3Y2TEhudUxWMnZIRXRNWHpB?=
 =?utf-8?B?ZitySUNsRW45bHkzTVYyUGljWWMyOGtlUVduMVdhM0phVytDWmhCOEpIMUpL?=
 =?utf-8?B?SHBRRjJ1NEpNeHZpTXNVdCt5aDV2MTBTRzBaSWhNZ2IvZnBxNHVIUy9EWUJH?=
 =?utf-8?B?UnptWlhqbXFNMmJwcU9ZRDF5WE5HckJieWZXNlhVRGJUbnJHUzVxeU9rKzRh?=
 =?utf-8?B?bEc5Y3A3UWEza0pRcnRrK0JNcUEwWWwrR2ZLejBJR0ZCaEFzemxqcVBDUEpL?=
 =?utf-8?B?VHBZam1RdlcxbVNOeWZYM0QzSmhVTEhiRkVNejFzN0hydnh4UktxSE9DUzZO?=
 =?utf-8?B?RnY0UkM4L3luS1lsUVNpRkx1NFg5RGJmMXVDQTg3M1BMc21wNjJjTEVuVW1a?=
 =?utf-8?B?OXVUakdaR3UrVUN6b00vdllrTUtFQ3NqVTQvdURmMG9EaWtZU2R0VVIyREVH?=
 =?utf-8?B?MVRJemRuUnpGS3NKWlN6RHpFOVg1WERld3dpVjJUbEFVWWQ0QldWMHdydW1Q?=
 =?utf-8?B?bDZxVTd4S2hlRzRJMVhqQVZscmN5SmNIU0MzcGFuOUNmV2tjYSt2UnBPbzcx?=
 =?utf-8?B?QmFtSmZrTXZGYlI5UWhtY0VJakhWZXFBdjN0K1N3aFZvRlBzZUQ4SVBDWFZS?=
 =?utf-8?B?Zy9TWk5VRWpKeEhRSURIVlV0aEV6dW01UjNtSW9nZVV6QTZSUm5PdUtGMGx1?=
 =?utf-8?B?Q2tWSHY5RklVSnBkT1YyWjFXQ0JPN2h2bjlBdm1HQjMwWHgzVDFMTDE5YTky?=
 =?utf-8?B?b0ZSQVZMT2dhbmd5UGN6WUI3ait0d1JzTDBFQkZKdFk5RGRlVmRKNmZNN1BN?=
 =?utf-8?B?bjhoM0R0NlIzUDVUZ0NRZUhHZ2RyVXQvUTFGUkxOZnpCa2hFb1NlSXJlWGxS?=
 =?utf-8?B?WGlKZjhrODA0U3psNk96SERCZEhxSDdwbTNxQ1FZaVhFUWw2cmRQOVJhMi9s?=
 =?utf-8?B?bFNGRlR0Q3JiV1B3RXc1SEJTTlUwZ3dPaWx4bDEzY21EUkpaV053VVN2ZXNF?=
 =?utf-8?B?MEZ4SlBNVEFUeW00UkJNVjFhbGdNQ3hDeXNMd2Y1T2lTaHVaU1FzNWlVQzFv?=
 =?utf-8?B?aGt1RmdydW9kb3dsWmhkL2VUdWk0Mm5YU0hIR1FWVG9IcTZZckxCQXd2UTlF?=
 =?utf-8?B?Q0VNNktBUzlWVnlrY2Rzam9HZUE0UVhocVMvRm82eTlvNmdiQllWVVJLb203?=
 =?utf-8?B?QU13NFlIa01QNHB6LzltSDQyaHlPTmpXUHVNNDd6RGVhUVVZNWRINWgzOGF2?=
 =?utf-8?B?Vm5pcDFVTytWdVlFZWsrUHc1MHQvRG9tT3dzd3hEbkVEOVRaMm52MGxad1Q5?=
 =?utf-8?B?ZTBMYVJaaHFoZUFPNmtHL0Y3LzlrMDhmMHpiMWVFcWp5L2pqV3V5UE5aNWd0?=
 =?utf-8?B?bVNPN1JmWGRaUVdyQjd5LzdTU0lRMWUvWHZLTXhrMXEvZ21mR0ZIMi9hRXM3?=
 =?utf-8?B?akh3Y3paN3VEcUw1QVhRVVowaFVhSFVQMnFXUkpydEkzMnpBTS9NUEdWbFZk?=
 =?utf-8?B?UmJ1MVcvOUxqWHd0d2tSNHJ0dXoxdVRKRFhQTUF1TTYxMERrZThGZlJzV3lG?=
 =?utf-8?B?Y28zU0kvNGY5T1VnVEZ4R3oxWW9ybGlCdVNVa01sVy8wbVMrZFlwVVRDUUdr?=
 =?utf-8?B?cm9EZjkwSFBoZ2hTZ2RCQk5EU3Q4YlhEeDZMRGk4SjRRNnBJVUE1OUVmNG10?=
 =?utf-8?Q?qR1rOFO3kzk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnU4L25naFBUVDNlc3RPUld0NENTRW1QNHdDenV2TzFjeTQ0cWVma2I1cEpx?=
 =?utf-8?B?MGU4VTZMTWlFOHpTdFFhd29aTm9rRG9mYXZyVkNoMTFCUGg5c3N3MkhqT0I0?=
 =?utf-8?B?Q2o5ek9tTnVoaXl6RnRGTkNtRkdrdnRpTkJxZzZvYkZCekxpRW05SmhPOThV?=
 =?utf-8?B?a0ZLa2FOQ2RKUUVGNnB2V2tVWTkvL2ZPL1hkRVJ3YllSWGNwUWRpUkNwUk1V?=
 =?utf-8?B?STBmOTRrOWNaLzViSXdvSmNuLzhSNndGdkE3NDkzU3JheWFjOEdEdmxlNjhi?=
 =?utf-8?B?d2htcWpaWWxYNlliNkd1SHFISldYMERZYTZHNGVYS0F2WlgrbGJRNHRHaXBJ?=
 =?utf-8?B?UGtma2w2ZUFzMG94RHBIMGk2b3l5Y1dGRzFOYmdiN2JQZG9wN3N6VU9uZjM0?=
 =?utf-8?B?djdKNHMzdTEyU3hNUHdQdFNzeUZBaGp2aktvNEprSTJLTW5pTkx6NEVvY1F6?=
 =?utf-8?B?VnFyN1hkRE9hU1BxSW5QRkRNNXBDK21oVUprM01hd3JEZHlPWFVtYTZSN2pS?=
 =?utf-8?B?ODBuRERCWllES2pMbzFQOUx2ODNIUWluT2pFb01JYmdPWUk2U2RjT0FtcGQx?=
 =?utf-8?B?MlJ1SUVaZnZ4cDVMQ1Bpc1BDcHJRZExQZ3hSQnZMOGJaejhPV1Y1eTkvMXRS?=
 =?utf-8?B?c0Z1SXhEODZuUHpsRS9MNXNzRHcwbjloZWY4S2FRZUIvQVBFMXluaWdVeGRV?=
 =?utf-8?B?L1U3UWxzbzEyakVsSHRaR1A5eElqS3VJK2w0VVUvVTFPTUlKTkNmenB3YmZG?=
 =?utf-8?B?RFM0ZGZWbTd0ZnJLMnd6SG5kUS9YaXd1YkZyZldyQ1ZCWTlGeUVFdFR4cUJO?=
 =?utf-8?B?MCtHTFZ4bmZzblpJN0Q2UHkwTU9seGFDTmI2Y3JnQW5GZ2Z2Y3ZtblhBMnVI?=
 =?utf-8?B?cGNLTGxiT3ZKdU14Z2tPZkVLYVhxQWFKbmdoUVFHT3paa1FpSjh5cjVlREhX?=
 =?utf-8?B?MVVwaHowQmhIVzhaT1V5dG5adUxWdTA4ekFWcVR4RTh6dG1WZUFGNVE1WkN0?=
 =?utf-8?B?UUhTa0k5c1NZRGlUbmN5aDRIa01HdWtpVnRYemNEQXp3eEF4cEZpWmV2UmJN?=
 =?utf-8?B?bEJNd2E5UWdjbTdINVh1bDdNVElzMEE5cnR3cmkzdXgwZHhaZFV3QXBHUVFX?=
 =?utf-8?B?VlFCb0pOdDVUQWw0RXdhSmE5bHpUS1JyYUxjcVRHcE80ZzgvSlA4NFhWeC93?=
 =?utf-8?B?TkFHN1RKWHYzRG5GSHE4aFdoQk9rOVozQk1HNjYreUJZR3liTlc5ZUJPRU5B?=
 =?utf-8?B?WEZMTmtGaDh3b2loYXd3dzZZb1g4K0ZWeXczZzluaDRyWDhTUTlYcTA0L1RD?=
 =?utf-8?B?WmUrN3k1RWx1QTVnYnhRUXdqb1VQeklqM2hUaVNmTk1NWHcweWdXcmxZQjJY?=
 =?utf-8?B?MGJkTVIwUVJBaWwvRjkzYk13azJXdzBLaFhLbXIvelc5enJNTE5qNlQvQ0g5?=
 =?utf-8?B?K1NYRDVkdkNpb1QyR2Z6QXFiR0hzejVTd2puZlBOZ2luVkRFMHBJT05iVm5p?=
 =?utf-8?B?TWpMdHpCMzhSbWVmb0JoOWdwQXZZV0toY2hMQnBSN2ZtdjJJTXJpYStKWTZk?=
 =?utf-8?B?aklZQ1piRTBPZ2lvSG52emdxSkt1UTZyb3poc3B6czhEbU1UR09pWkQ1TFN3?=
 =?utf-8?B?dmNVK0xEZnZrMFFoYnJnM3ZYRzhtK3RJOVdjZnRaYjZ3UkhxTEx4Uzh3MHRp?=
 =?utf-8?B?a3JHZDA0dW5IT3pqSlhMWUM4ZWVOMXdra2pST2dOVEEwQ25sMWlYajUzU1Yr?=
 =?utf-8?B?VnVtSzhLeS9WVDh5Zm5NZEJNcHEweVdZWDRhWkVXTUw5ZVdjYWxQQ3VQdWVy?=
 =?utf-8?B?aW1mckE1QVVVVkFSTGxrcXJreHFNM2xscmhZRzhJNzROK2xYUzErSVpNclF4?=
 =?utf-8?B?ODNZRjJHZko3dytNaXpkdjc1VnVWY3FxTDNZL1hZUjIvVk9PRm1LU2tucWRW?=
 =?utf-8?B?L2ZsdWhRL3RTN3FIS1E3eVArOEpvOXBZOUJSNGNBenYra1lvdWJhM0dYbnJk?=
 =?utf-8?B?L0dhVSt3WEE1Kzg0Ris0YVFCaThDNnZpa01aM2RVREtEbjQyWVZZeVpoQUJT?=
 =?utf-8?B?NkFwa29UUmM1VlJaNG9lTkNaRU5CUlV3ckNSRTV3TGRoK1BVakxoZVZ1Ui9t?=
 =?utf-8?Q?qE99yZUQcqmaPOh3JmPwVVVtu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f0a6ac-aad3-4ce6-9b14-08dd894ea88b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 07:55:08.7970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0Berf285xWW2pB+E+VvC6/Z76w/xSOFtBviB3noVfpgEYH8F+0siuja1MUpGzoo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
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

On 4/30/25 18:05, Arvind Yadav wrote:
> Export a new helper function `dma_fence_dedup_array()` that sorts
> an array of dma_fence pointers by context, then deduplicates the array
> by retaining only the most recent fence per context.
> 
> This utility is useful when merging or optimizing sets of fences where
> redundant entries from the same context can be pruned. The operation is
> performed in-place and releases references to dropped fences using
> dma_fence_put().
> 
> v2: - Export this code from dma-fence-unwrap.c(by Christian).
> v3: - To split this in a dma_buf patch and amd userq patch(by Sunil).
>     - No need to add a new function just re-use existing(by Christian).
> v4: - Export dma_fence_dedub_array and use it(by Christian).
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/dma-buf/dma-fence-unwrap.c | 51 ++++++++++++++++++++++--------
>  include/linux/dma-fence-unwrap.h   |  2 ++
>  2 files changed, 39 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
> index 2a059ac0ed27..a495d8a6c2e3 100644
> --- a/drivers/dma-buf/dma-fence-unwrap.c
> +++ b/drivers/dma-buf/dma-fence-unwrap.c
> @@ -79,6 +79,41 @@ static int fence_cmp(const void *_a, const void *_b)
>  	return 0;
>  }
>  
> +/**
> + * dma_fence_dedup_array - Sort and deduplicate an array of dma_fence pointers
> + * @fences:     Array of dma_fence pointers to be deduplicated
> + * @num_fences: Number of entries in the @fences array
> + *
> + * Sorts the input array by context, then removes duplicate
> + * fences with the same context, keeping only the most recent one.
> + *
> + * The array is modified in-place and unreferenced duplicate fences are released
> + * via dma_fence_put(). The function returns the new number of fences after
> + * deduplication.
> + *
> + * Return: Number of unique fences remaining in the array.
> + */
> +int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
> +{
> +	int i, j;
> +
> +	sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
> +
> +	/*
> +	 * Only keep the most recent fence for each context.
> +	 */
> +	j = 0;
> +	for (i = 1; i < num_fences; i++) {
> +		if (fences[i]->context == fences[j]->context)
> +			dma_fence_put(fences[i]);
> +		else
> +			fences[++j] = fences[i];
> +	}
> +
> +	return ++j;
> +}
> +EXPORT_SYMBOL_GPL(dma_fence_dedup_array);
> +
>  /* Implementation for the dma_fence_merge() marco, don't use directly */
>  struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>  					   struct dma_fence **fences,
> @@ -87,7 +122,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>  	struct dma_fence *tmp, *unsignaled = NULL, **array;
>  	struct dma_fence_array *result;
>  	ktime_t timestamp;
> -	int i, j, count;
> +	int i, count;
>  
>  	count = 0;
>  	timestamp = ns_to_ktime(0);
> @@ -141,19 +176,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>  	if (count == 0 || count == 1)
>  		goto return_fastpath;
>  
> -	sort(array, count, sizeof(*array), fence_cmp, NULL);
> -
> -	/*
> -	 * Only keep the most recent fence for each context.
> -	 */
> -	j = 0;
> -	for (i = 1; i < count; i++) {
> -		if (array[i]->context == array[j]->context)
> -			dma_fence_put(array[i]);
> -		else
> -			array[++j] = array[i];
> -	}
> -	count = ++j;
> +	count = dma_fence_dedup_array(array, count);
>  
>  	if (count > 1) {
>  		result = dma_fence_array_create(count, array,
> diff --git a/include/linux/dma-fence-unwrap.h b/include/linux/dma-fence-unwrap.h
> index 66b1e56fbb81..62df222fe0f1 100644
> --- a/include/linux/dma-fence-unwrap.h
> +++ b/include/linux/dma-fence-unwrap.h
> @@ -52,6 +52,8 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>  					   struct dma_fence **fences,
>  					   struct dma_fence_unwrap *cursors);
>  
> +int dma_fence_dedup_array(struct dma_fence **array, int num_fences);
> +
>  /**
>   * dma_fence_unwrap_merge - unwrap and merge fences
>   *

