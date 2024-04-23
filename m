Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573F0C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 05:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E8811310C;
	Tue, 23 Apr 2024 05:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M33JKqrc";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A788311310C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 05:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCgqOrZAlpzyWeOFQNuReVQch6SzVws88QXn4pMIqmnFZwNm8PiIh/xJW6A70z5HO8utyki6f2J7X3HroJ/CaVmNMCHfBMzX7aRw1d0qiEC5Hl6aUp+GLKPopKIHQ2oX6eIJN33a+mLWryki++8bfZLz6rZIZURy7W6AmtBXVB8hSBnzCnYDqktmUM1QBEe883FcN16IEaA26EjQPd9bwsfgcuDdL5lwTZzSbePlZPALW5l6H1hc4BmkAKth+M7i1VkhGRcwjOurUJGuTGSBh8okcm7taWWBZGXdBU8ndE3v7c/bGUq9Plq5BTRbn03BkfAQzxFXArkLxwtITs0yhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zc085p0jxpMubCrUHtt2bduBAMFLGYIKgTc8YyyE6IY=;
 b=IJXusVLYZqrR44qYdUERUOZ0q19KG883cySrcrqLngT9pF7PcMtSgZl9hn6rsDG924xeHbZnEG2QJM9+H9VGmZVduausS89gMxJDg7mAkn178me028MHuxjaeS973xYlLZB5X5N0YlG6AQ3cPbogl5C9VKvAczSavoXWJzaTKnAm9dZ9Kh2GGAcFrH8YADUuZXfuWx/0HqN+lMyOeKV7JjwgiNSVbeppIDfvMDYZA/5qkg+DzWBfTo8OHeQ8GExYX4Q0k3fxYZJZS47I89cMq2FeQsDG1R1w6NC1AJrV2ZSVbDJ5vMdwjC8PrmCeHqh61y5sT02S3jUb9MLNHbDJWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc085p0jxpMubCrUHtt2bduBAMFLGYIKgTc8YyyE6IY=;
 b=M33JKqrcOvUAhoEt9rlAnXkRFOGkjRahvhSLmZTrguMa+5latSj3z9M0H0dzw1ZnhEXJNW2zxfezXRh7Hm/22p7mAJAm293D21OQmx6AACVIEvWZR+mcOp9Jrb0V/GPxhvFXUAP+qs2sGDGFXPRBYL61JFxIt/mmjq0fon0zPLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 05:57:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 05:57:04 +0000
Message-ID: <44b028fc-4d7a-4f9a-9eed-19d4e6397a78@amd.com>
Date: Tue, 23 Apr 2024 07:56:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix two reset triggered in a row
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
 <f9eb9cc2-4e95-4bf9-b2db-a459eca10686@amd.com>
 <SA1PR12MB8599D7D541AFC7840BC7B090ED112@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB8599D7D541AFC7840BC7B090ED112@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0098.eurprd09.prod.outlook.com
 (2603:10a6:803:78::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: fde52f82-0079-47cc-08cc-08dc635a335a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y21JZ0cvMFhRNlU2RnB2MEMvMkR4bVpxUlFCNGJrVVBvMU5ka1Z5N3NUVS9s?=
 =?utf-8?B?TDhvZm04Zldobm9GcFZSVzlsNW5oSmVhWjNnTmRQUllNSnZPMXZxT3QyQVNa?=
 =?utf-8?B?MUZtT2xndmdPaFFCWFVEMnBxR2FTT3JkbllLV3N0TFE2OHpnazdDcUQwaDZI?=
 =?utf-8?B?MlBZeS9HVTdDbXBLWVlmNzRoR3k1NDZDM2luMVJ5Sys3SCtPcEIzcTliS3JF?=
 =?utf-8?B?TkppMW5pK3Y1WXlKVTlGTUdtS3NHejdONEoyUEwwSndqRmcrVk9LV1NjKzUx?=
 =?utf-8?B?d24zT1RaaDBlZU1sOENIdTN3T0tySHNwTGxodFBiL2toS2JYWVBWQjVuREtT?=
 =?utf-8?B?WnhBZ3dVTWNCNCtRUzdtOU1RR0xOc2s1Q1pGNllEb0Z1YTZlWWxaVGlqNnhX?=
 =?utf-8?B?aTJsZGF2U1k0M0J4NXN1TCt0Ry9oZkRyYlEyVXRqT3JMMTRraFJTeVN2S1Av?=
 =?utf-8?B?NjVDYko2WHZIb29RbnZoOUVXVkcrVXUvSWJoWUtUZStkb2hHaXRBemZodW5E?=
 =?utf-8?B?T2gvT0tJcC8rTExhQW1hSHFGTEhXWjBSSEs4MUk1T3J5a1hheCs2SFdsOTRy?=
 =?utf-8?B?YVZBZDNJMTZMTW1VeHJXaE1Zdlp6U0txbHR6aTgvc1VBNS9QNXQ4TkZnTHgw?=
 =?utf-8?B?VWVMb2ZEQWE2Z0kzOFpQUndWQkdrNXhHenl2Mkp2WUlGNFNjTVE1OUVpY3B6?=
 =?utf-8?B?R0VZdWErL1g3RFFZUmcyYVVwdllRUEdsSTNaUUJLb3ordUdXdHZMNHdhWkI1?=
 =?utf-8?B?MjYxNmNtTjd6S1ZNWUF5WFlZbXFpdlk5aDA2a1J5eFdzRXBwQlFQdXY5ZWZT?=
 =?utf-8?B?YllUZjZ3WGo1WTdiSVZFMlBlS3hac2l5UjBhaTg5U0EwV3gzK2Zic1FCalBZ?=
 =?utf-8?B?VDFBKzh6SFRXRlRlbnB1YmlqelN0RGVTNUNMVzB5aC9RSkpzOGdyMTg2RFMr?=
 =?utf-8?B?dHVhR3c1VkNRNmdpZlQvdjhYZHExUHh6aTRWZUV4azdkMXVUK1Z2MS9TYzQ5?=
 =?utf-8?B?SkhzUzh2YlVJaUZaOENubTBlMm5HbE03YmJKRy9zUWd4VlJXZlBFOXk3ckl0?=
 =?utf-8?B?ZDI1QWdZc1RVOC9yRVJYY3Vycm9QV0ZoRXBNbXZZdUpCSkJpbXFqcHFGWHgx?=
 =?utf-8?B?V2QwTGVETmZ5UEJmNlpxL2FBL3ZDMnliRkVFOUNoTGROR3lzRnJnQ1E4VlZ6?=
 =?utf-8?B?MkgvR2VPdnRZUVBka0xycHZqTzBBYnZZZzU5cVYxQVZhN2pjbVBkVUorRU0z?=
 =?utf-8?B?S3hPSGRZTVJsbUNKWC9keXJDenZuZlc1R2JPcnExL0VxelV2a0gzNXBHUzRZ?=
 =?utf-8?B?SUs2czRCMm0wekNsc24yeGpPTUJjYzRFcnRNcitmMnNMck5lMjVlem1ERHJJ?=
 =?utf-8?B?WDN2T0JkdWZvTmVUTGtUS0FGRjRWRWJNYWY5WHNhVURZdkZ6cUhnVjA2a3Zj?=
 =?utf-8?B?VklqTndLQVYxWFdCQzlvaFhvT1cvRlhhQXVaVEJLRUhPV2xWdDRRRzgreUNs?=
 =?utf-8?B?Nkg5c2ZHTDBXTXExM1M2WUhLek9KK0RiT0R2c1p4dVhCUXhYeEZWRmNkc2VN?=
 =?utf-8?B?d05NKzhEWFN3WVF1c0Q5TGNlOGdxK2FETE1XOGNoeGN0SXdyTlZEdnFlWWhs?=
 =?utf-8?B?RHcrQmFwbkhOUnRYaGNRMExlbUN3UGlpNDN2WVhidmNvRkNZc3lsSE9xV0Yv?=
 =?utf-8?B?YXR0NDlVQVk5WkVEOCtUMGVhZ0IyVWdHSkwxeDVvWlJaSURCMVRZeVdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFlOQWFwZlI3NzM5T1EzY3dwVGoyZlorem9hcUJmcFVXL05GSUpRT3RTMlh5?=
 =?utf-8?B?SGR5Tml2OC8yUEFRZWlRelREVXcrWFYvRHBWODExams5a25JLzRtUnRHTHpu?=
 =?utf-8?B?b0Ftb1E2T0xYa3Jtd3RodnA4WU5HL3NmZmF6UGs0enF1Q2cxOEhQdkhmZjVH?=
 =?utf-8?B?cnlsTGticnRJZGtjMTlKdEdjTEpObGNMa3M1eSt6WVlJUjFuUTgxaFZGV0lu?=
 =?utf-8?B?K3R0NjNna2dJSXdqaFJuV2JoY3pRa2RmcGx0bnhoOG5lb01qaU5rcmI5a3A4?=
 =?utf-8?B?RStXaFhDRVZzai81L2kxNkoybU5IMTk3UXFwampMUUNsTDRXRmM4amU5TXFW?=
 =?utf-8?B?c1VVMlVOTDgyczhKTU5oK2xwY0gzRXZ6ZDNucytTM29ncGo0RkpoMmhyRUJk?=
 =?utf-8?B?cVFOcGp2TFpwWUc3dHFNVXdrd09lR0FnaGlhb3I3OWl1bVp0UmZnbzQzbmpz?=
 =?utf-8?B?QjRPTkpSbnpQWituM28xREdCK01iSnR4NURuc1lLZFpEQWQzUWg5amdaTnVT?=
 =?utf-8?B?bFhwc21Ma3BZRGV6WXFoTWhkV1pJQnI2dVN4dzQyNjB4bVVQaVA0K1BJaUN4?=
 =?utf-8?B?dUJvYnVTLzVGRStsdzl5amlkRFFSVmFQYWg2ZTh4VE5WRkFYZm5iU1E2UEpT?=
 =?utf-8?B?cFVpckttUjhKOWROSkZ4OURKTm56SHIzWWxqWjlMM3p0b1RleTRDU2kyend5?=
 =?utf-8?B?UGp1TmZNcXRpK3pQei8vSURvdXhrTXRwckpYTmh1b3VMeEZ0OTQwTFJsL2R6?=
 =?utf-8?B?M0xSWk1HcVdJVzJTWXh3a1I2R2ExVVRlTDNrQ0hsc0p6NUNYV2l6UHl5TFhD?=
 =?utf-8?B?WVk5V2FqRHIyWGcveS9icWlCcCtnTjhvQzYzM3huY0Vwbld2OE5IVlM5QThS?=
 =?utf-8?B?ZkhFZXQzMjZxSkIwS3ZKZnFYMjJCc1U5cnlST2tkVVZKN2tWbVFES3ExNHdY?=
 =?utf-8?B?a3QwczBYdGtraGk5VThDK2duNW1QTU1COXM1Qm9UdGl2aldQWERjWXRQS2Nm?=
 =?utf-8?B?TGxDWUxSdkdHdjlCeEw1Z0RQbjFpbDIxM1RQa2VudC9QZGVuQ3MvaFRQaWEw?=
 =?utf-8?B?UDExdkRZQXRtK1BJWmZGdUhqMFBTM1hSaER4UkcveEsrUDQ2VUYwSThPRU5z?=
 =?utf-8?B?NEJ1NmhrRitRcWdUTjBMd3ozUVd0Tk1vcm9WUHNRWklBTVBma0daUk1EVGpV?=
 =?utf-8?B?NnZkaVEzdmt5bXFUSWZLbWh5Y2ZISFI2R2FBYzViWDdySHU5SVh1Q0daWXRU?=
 =?utf-8?B?TUNQNnRESlp2azN5d2R3SXZlQkxtZ2FTUXRuREFTR3lHUWZDNXdRemIzZTQ2?=
 =?utf-8?B?V3JqYVdVL0VmeHRXMnU4V2pFc3JBMko4RENOVnhIQUJWVjZuSFRIZENnSjdn?=
 =?utf-8?B?K2RKb2NqYWpjTzYxQkV0a3Zycm11NitmMURxSm16OXY4L0dGMjZFQUhKa1pz?=
 =?utf-8?B?Y0Z2by9hbDlsWDhBc0F5VVN5ODVrakFTdjdaZXhBdmpwbkJ4bER3K1A2Rndq?=
 =?utf-8?B?TmZQanZ5eXFoSWJlekdIelROODRxR2ptUVEwbi9WVlozVllVUUpxYVV5N0Rq?=
 =?utf-8?B?NW1RVDM4SVJDcjhPVS96UktqY1NFamdnOXpOQlN6V1kwMm14Q2oySjhmYUJo?=
 =?utf-8?B?V2xuekdNandiTjRONGc0SXhqOVduc280ZHhwUUtmSkpweXlwM2prMW4zdWpp?=
 =?utf-8?B?LzNhamttTEV5WmhrOHlQcXNEcFl4dHdTVzl1d1U5S1M1bTZaVzNCV0d3dS9x?=
 =?utf-8?B?T2VhQ2N2bmtpMUdoTklLZWM2TC9vR0s1VTNHVm16azI1MURmUitHK2lpa29V?=
 =?utf-8?B?bWR5U0dYSnZXbGdQL3h3VVd1NUlidTdLRTBjU1lxQ3NGeGVYc3kydHlEbkFl?=
 =?utf-8?B?NEpqQkxVMVhWWXJuRldCYlo4WkY0SWJSUkE0bjVXOXFsZGNYY3BLSHR6Ri8r?=
 =?utf-8?B?Q2pHTm9OeXpud2NlVVpDbU9rN2JSRlJZRjRuZDdzZGErb1BONnV2U0syTW5y?=
 =?utf-8?B?VVdJRUtjcURjRnFEajRzWDBxK2xOV1VNZnFhcFF3V2tQbDUzeGtFeXhuM21m?=
 =?utf-8?B?RFhLYnZkVDBEQjFKQXkyMGd1bThhVkx2SkVBNDgrVnVCbUZXdFNtMVduUUs5?=
 =?utf-8?Q?HzkooQuyq0uWH8Y7SuAq8ANlU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde52f82-0079-47cc-08cc-08dc635a335a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 05:57:04.3401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcMeLPBgVY/NppqEKWY6Tw/yKZeiE3WguAHokXYnHha+nbd1Zn24mJ57tICC5J5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
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

Am 23.04.24 um 05:13 schrieb Li, Yunxiang (Teddy):
> [Public]
>
>> We can't do this technically as there are cases where we skip full device reset (even then amdgpu_in_reset will return true). The better thing to do is to move amdgpu_device_stop_pending_resets() later in
>> gpu_recover()- if a device has undergone full reset, then cancel all pending resets. Presently it's happening earlier which could be why this issue is seen.
> This sounds like it is a design issue then, if different reset workers expect different resets to be triggered but they all use the same flag. I wonder if the other places that check this flags are correct. FWIW I was testing with SRIOV where it always does full reset and ran into this issue.

Lijo is correct. The idea here is that all reset sources which have been 
covered by a reset are canceled directly after the reset is completed.

The approach with checking amdgpu_in_reset() is broken because it can 
still happen that multiple sources signal at the same time that a reset 
is necessary.

Regards,
Christian.
