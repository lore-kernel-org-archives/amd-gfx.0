Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605BFCCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 14:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB04F10E14B;
	Thu,  9 Oct 2025 14:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aacGD45a";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547BA10E14B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 14:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggyPFpHUF/JjHDNOp9QkZ0QJe6eY5Dz7VgBZ9aHIp5ZqtR2ycmQl5oYtnpe31y5by/f6MbRe+EKGlLcyVAYKzKA76k9RHTv6HY8tC6VkifU5ljyX419tt32w+i3Mklx9+Gtl8ly2BTXhS9NYeUpx5CWo7pX4Y/qOvpr36eWvRwOF4cSn8L/ldfOMz1cQ48bCG4x2cHqoG4LUabLnd5Rcg/fJ0r303Z1tLsLXA9TxqopAgrc6leCu6pE4n4p47yG+g9LuggMebKAsArTuLkVUawSNPqBmDmUN4rBq+Duo9rBNIRYSVmgr/UwDZuSbxzQeLUJTBWq0oQIn7uTDOqdHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9EJqgRlkETHHAO7s1UkWMueomi1VN3GBs3z1/MaPSA=;
 b=VWzYuq1Hx6f1kqve9gc9QDtzqceSWqd6KSbl08x75gsVMUqhntLGz63uwZ8IiiIdMQ12jLw40HmhYi9iChvG8gpS2FAmtSEekkQ+Oqz3nk+akpLuSupa5iVW1VaA4YFZzjHVxbhCrd4G1nXwdD0zI0p8VkVIz0s2ieBAwRneEtVGwI/x2FaV15jVb4sJvAn1Ewu3ilY4eq+wT/hqJnjDwTO/LjlVRr5uDJeoOnWHnNjG60cnoMCQneuCdl347QigPuNgDNYsclkMP1EjztkEUjl0ro4Cx0MPfm/beY6j4PcEAnaMsehfNoL98JIBQ9AWfBQNb+rJwZ9TY2fROTsSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9EJqgRlkETHHAO7s1UkWMueomi1VN3GBs3z1/MaPSA=;
 b=aacGD45aOzp4JsukqvO7A85Ex9PwEVit5vAB2WZOh9FjY7R5EbeM7ieQ60l92dzcwHXbBfQZg/jFR4hY3qYKBfKq30UYRgL1jd3vOPB7nlcbx/UJ9/gQTUl5P2OQrPX1LWb3lX/Ssfs4y03V4wjTesaST8qMcgLa/dPrNZLPPAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 14:12:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 14:12:41 +0000
Message-ID: <189a2289-0383-48d8-af03-966a518e8e40@amd.com>
Date: Thu, 9 Oct 2025 09:11:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] drm/amd: Remove second call to set_power_limit()
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: Robert Beckett <bob.beckett@collabora.com>
References: <20251008191153.3145554-1-mario.limonciello@amd.com>
 <20251008191153.3145554-4-mario.limonciello@amd.com>
 <DS0PR12MB7804BAD6C3418F15CD60634F97EEA@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <DS0PR12MB7804BAD6C3418F15CD60634F97EEA@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: a0edbf1c-0bf8-4ec0-aef0-08de073de901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHBzbVRqU2Q2U0ZpOWxJekh4ZXRsR3k0K3o5ZFVLZGNLZ3hiL2FMWVJSUFNK?=
 =?utf-8?B?R2FiRjhIVUxhTUJBdVZoc0VEdDFiWDRZaTZqb3FSQ3c3TTdGZ2F4Y01vKzdh?=
 =?utf-8?B?U1hjdThES2w1RXV1bmhhbXAyLzBLenVTcCtBY2JxTnZnNlpJVVFoZkF2UCtq?=
 =?utf-8?B?cTB6Q1NBL3RTaFdla2RBZ0JlZm85MnpEMDg1ZEdyMkFtZU83eVhFQUdvZWlM?=
 =?utf-8?B?WTVJeEswOWtubGdGZHJEbTNRZTQ4OWNyaUZPNmxhRFFaam43endOdURGWFJt?=
 =?utf-8?B?ejZ1dEZRZDJ1QytCMHpPamZMZUQrNTc2ZmtiU2hic0tPOUFLQ1Jib3UzZVFw?=
 =?utf-8?B?U1YzQlZTUW9kbmxUVGp6NnRKelljNGpnTzFPWHRXVW9zWEs0U1V6c1A2WFlr?=
 =?utf-8?B?Q0ZZdmtuRiticlBzYmRab2g5RUZMNDQzMFY4SVNBaGhGMXNrZmJaT0VOQ0I1?=
 =?utf-8?B?dUJ6REdmSzE1enFFZjl1Vjd0MlNMVGp2VVR3MVE1YWphbVNKNVlyZGQxWHpT?=
 =?utf-8?B?aEYwc0tIUG1LeGN6ZWp1UkFkcDluM2JYQ2ZTMWozQVJrSkhkb1JOTk5rS1pN?=
 =?utf-8?B?N0gxZ094Q3F2aEV6UHpvN05PZEh2T1ZEL0g2YUVEdHRJcEpNSFJidndoZlB2?=
 =?utf-8?B?V3FwdnNjS0htamlaWVFSWE9JelE4YTlWVjV1TnNMdWtPWER6NUsvWmdBcGZK?=
 =?utf-8?B?cmhxMTVZeEtZSjNmcnFTTGlRUG1PVXgvY2Y5Q254OVBTeUJhVmoyZUVUK24x?=
 =?utf-8?B?SFdUS2FzSnFWRXpVVzNUMDRWSEVEaUQwWVJyUXBPM2E1ZkE2cFBJbXZXMStQ?=
 =?utf-8?B?UFJvNEpBSmdwOHFEeGRpQmg1VnAzRytMQWs0OFo5ZktHeTFndWtBanRxeFlq?=
 =?utf-8?B?ZXhKeG5aWU1wUFhQVjE4cWlkQmpDRWRVdXl5TU1MSVNHK2N2cEFlQnZ4N2p3?=
 =?utf-8?B?OHRNeWtUREJNTlRuYmpTZ3N2dkxJWjIwdjhySlBlbVVrUy9hck52aThvMVd4?=
 =?utf-8?B?Y3FlWWlva3RBblQxK1ZvMGpOdFVOU2s1MkVITUhaWDJKSHVIeERRMmNNWitQ?=
 =?utf-8?B?OTlRTzYvdWxJZW1nY1FMU2dzdVN1WGViQTlpSDM2clZYbHVGbGt6SVd0OHJp?=
 =?utf-8?B?YVkyTEEyemtaaDhJei9HeWdPNU9Vd1dRVDFIWTA2anBhSnl1SHpGMjJ6N1Y0?=
 =?utf-8?B?bTJ4RkJ5TDdhSjFLcFQwc2QzV3VZbXRtNE1lRFRsZGxleVV2aitKa0M0UVBU?=
 =?utf-8?B?ZTN4ODV1aEYzMzFuUzc4N2hDVkM2ckNDSyt2cUU2RzlncnNldUUzSU43Ymhy?=
 =?utf-8?B?d2VGTFcwTE9iQkxZaEZXeFdwOHlOMWFDNW5LUnh1RkxadGJ1UFl6T2pIOWkv?=
 =?utf-8?B?cUtSajZBQ2NIUi9OK3JRcCtCZjVlRDl1VVVXbnZrNzJZeERhaUpHNTRLZ1By?=
 =?utf-8?B?UUxXZkIxdFk5c3drQ214QVBJQzd3Rnd6SlE3UmJvSFZYOEtSVFVGZTJKUmpV?=
 =?utf-8?B?ZWFTM2c4NjkvT3kvb1dPTHlxOEFNdUtMYWhQL2RCRmhVOGk4ekxOanFSQ2Nv?=
 =?utf-8?B?cHlpMHh4czl6OEdBUGcvY2xIMjYzWW81UVVVN0J3TEtrdStYZ2dtMmZRMWJo?=
 =?utf-8?B?WDdIUnBGbEZ4Sy9iSWVEa1ZGNHpabTloVUhwTk9oQ2FxT25YSXVMM1E5VWtt?=
 =?utf-8?B?TW1BeXBLTkZoN1plR3pMQXhmOTNtSFpkSEM2YXlxK0VQTUJtL240a2tiQ3JJ?=
 =?utf-8?B?ejRTTW5lV0lMM0hFdEFCK1UweVFoOHZMbnl5K1NkeFpoaXdBanJOT1FvT2da?=
 =?utf-8?B?ZXQ0ajY1UnVpbytKYUxlVTF2QlZhLzREclRaSjdmRjZBM3VaQmFaQ0dJVWZv?=
 =?utf-8?B?NHd5ang2SE1TcDhIbTBwQmZKMjVuMWpqSzh1N1BwM0RWQnVoV0hBa1lXUEZp?=
 =?utf-8?Q?7BPayrVVK2tovtPERmUnLnSulPVqnT94?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlI0ZmJwL1IwVUFmMWRwelpyTFpnRTNGaEkrU3VWeVIydmw1SFV5VmZESzBk?=
 =?utf-8?B?TzF1YnNZL3IzRXJMYlN5T3hrblo3ZVhrQmtxNjEvSVpXY2hmNEw2NEVEd0hz?=
 =?utf-8?B?S2QzbUlpd2xsWkJiTDNEY3ZmdThvdkMwTU1ISjFCdENzeE1ldEVUV2NlbXBD?=
 =?utf-8?B?alI4bWpvaFZaanJqbFMwK2lLMkhzS24vUi94K25rUlBvSWlQL2w4dG9TNVox?=
 =?utf-8?B?OVZwSXBHU0pha0Fkb1hqQ3JZamI1Ukg5NUpRKzBjemVGRUFITnhNOStUeEVQ?=
 =?utf-8?B?aVlCV1orbWR0d1ZtN3NMOGR3b1J5M0NZQ3FhdnNnQWlCSDB5QTh5RFZyOWpD?=
 =?utf-8?B?Si9mNG13ak5iRko4UktoNnJ3ODBKeEJ5NWtCZEdTTmFBM0xqdG1MS3l5d1p6?=
 =?utf-8?B?T1c4czVjeExZYlVmeDlSM3dJaCs5cjUzdWZza2RRK1NwR0x4RWJkY1VtUFN1?=
 =?utf-8?B?NXViZ0cwdVIrdmxHSHlLOXlDS1RjT25TTmpOMmtwWXMycmsxS2cwYjZUZmZP?=
 =?utf-8?B?dkJpdnJKTzMvL0x1Y1dUamRYL3ZTZFY3cDdyWGpCSnJYQnpYeS9RM3lGVEJT?=
 =?utf-8?B?WE9KaHlzNDAzVVJWSUZ6Uk9Rczl0MG9MeGVxNWFMQzIrbXFvOUU0UGNCUGd2?=
 =?utf-8?B?N3VQSmhaRnQ3ckhxb3Axdk5JT21zRlo0Tml5UXN5VVZKdnFzb3QzSStjWkFT?=
 =?utf-8?B?TEoveFFNeGdESk4vTVFNcm5nWldHTWtXelRJRHA1d3BFNHFhUjJERkpkRE9L?=
 =?utf-8?B?SEVjMlEvek9wR3Q3MzBPL1gzd250Qmt5Zm4wZVI2WlNBMnhxak1tWkV0Z1c4?=
 =?utf-8?B?cXZFaDYzT2lEQ3RQY0tGbXUzOHdtdkh1ek01cm9Hc2tJK0RjWURVZ2o5Z3Vs?=
 =?utf-8?B?aS9sVmlMRktXbzlJNFNXTlJLNFlNdVM3MkJKUEdtMlJhc1lyQUFYd3Y0aUhh?=
 =?utf-8?B?MjM0RmNEZjFaMWQwUHNsaG12LzVPTmRlV2NMeUZhSmdrbExpUXNJUHIxbUFM?=
 =?utf-8?B?YkVxc3ZHLyt1eU9hcXJTY2E5Y1E3TTMxa1FtUTNIVGZIUEJ2Ni8vMGtjNzRH?=
 =?utf-8?B?MG1Bam5WNmZXblVEcG1PeE9XZG4xZXkzcVhqU1Z2aTMyTHhBSmtLdzJsdXNI?=
 =?utf-8?B?a1pvdjJMWW9uVEF3NFplemtOMHl6eHpIaTdha2RGQ0xoaEpwWUpBTGNnTlBo?=
 =?utf-8?B?cTBaaXJpR1dPQnpGV21rS0U1dzloNTFLZkVBYUZZV1lmblYzUjdBVzE1QTZF?=
 =?utf-8?B?Rlc3OEkxNU5hUDJPZ21QdDJodjRhUUs2WS91WHduWlFyN3ZFVnBDRXdRK21L?=
 =?utf-8?B?dTQ4NUVKMFpLb3poczhqZncveWxTK0hSOXY5NjJlRDJuKzA2OWdjcjh3bXF4?=
 =?utf-8?B?OWJzZGp3c0Z1ZUhZVXZQN0ZrM090aGg4ZTdRQ2lKSzBDMjN4RUFvamIrWWc5?=
 =?utf-8?B?OGRUUmVBazlweG85YUxUamtIL09oeHgwU0NZM2ZsbGgvYm5PZ1pxMWw3b0Y0?=
 =?utf-8?B?L1JBaWVSTWxBR0JiRUs2THJ2QkVrbkh2Ynh4NjRCSUdMQldKTmVBTEduVUR4?=
 =?utf-8?B?d05PUkJOTnNyM2xhbnFRd0VKME9KQXdOYlpuWjJhclRaRzlYSW5UbGh0Y1BC?=
 =?utf-8?B?NEV1ZnNJNk5FalBmOWpNdEdQdzUzZkx0NnAxcTA5Uy9TajdZMkVxSWZOU2xK?=
 =?utf-8?B?bUZPTzJVc1FJY29XR29OWklZRERMYy9MUXRCYWU4VVpVME5hV1pGUXVybnEz?=
 =?utf-8?B?S1ZhV0xVbUJpOUkzd3ZaUTFtdmFJQmpPa1Vlby84RlJ4bGZDM0FLdnFBT2RJ?=
 =?utf-8?B?RmZTWm1hTjZyeUVzaEQvcXdDYTBzVDZyN1lRcEpFZlM5S0E0QzhLVFJaaWxa?=
 =?utf-8?B?RTdKNjN4YUVlUk05V0xYK0lHNWpZVHFYMDl0WmNYd0pRaTJ3YTNTMzFMVnU5?=
 =?utf-8?B?MjZkWklvZFQyWWtXR2t2VzVoTGtHSmNVTUxBZVRBREQvRDVxTWdlUkd1cW9M?=
 =?utf-8?B?czd1V3prMENHeHRJQWV2ZmNQM01PWkZHaDc5VE9RcDlrV0dXQ2ZSWFN5ekpq?=
 =?utf-8?B?OWxQS3hySVRUeUtVVW53TEpYWGxtZGgwUnk2M2hmWDJDRW1kQXpTRGNZcyt3?=
 =?utf-8?Q?+XlnOUk43v6Cb8AzQQDRyPdrz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0edbf1c-0bf8-4ec0-aef0-08de073de901
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:12:41.8594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acBdaSaTsz9gErCHDg7eptgsghNfHGP8LwkuNMuoLxGONFQ8My3LZKJ/c824JudnI2d+CgzX+n7Vio2T+J18DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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

On 10/9/25 4:29 AM, Lazar, Lijo wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
>> Limonciello
>> Sent: Thursday, October 9, 2025 12:42 AM
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Robert Beckett <bob.beckett@collabora.com>
>> Subject: [PATCH v4 3/6] drm/amd: Remove second call to set_power_limit()
>>
>> The min/max limits only make sense for default PPT. Restructure
>> smu_set_power_limit() to only use them in that case.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 20 +++++++++-----------
>> 1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 1c5f37cd5b75..f946effc1776 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -2966,20 +2966,18 @@ static int smu_set_power_limit(void *handle,
>> uint32_t limit_type, uint32_t limit
>>        if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>                return -EOPNOTSUPP;
>>
>> -      if (limit_type != SMU_DEFAULT_PPT_LIMIT)
>> -              if (smu->ppt_funcs->set_power_limit)
>> -                      return smu->ppt_funcs->set_power_limit(smu,
>> limit_type, limit);
>> +      if (limit_type == SMU_DEFAULT_PPT_LIMIT) {
>> +              if ((limit > smu->max_power_limit) || (limit < smu-
>>> min_power_limit)) {
>> +                      dev_err(smu->adev->dev,
>> +                              "New power limit (%d) is out of range
>> [%d,%d]\n",
>> +                              limit, smu->min_power_limit, smu-
>>> max_power_limit);
>> +                      return -EINVAL;
>> +              }
>>
>> -      if ((limit > smu->max_power_limit) || (limit < smu->min_power_limit))
>> {
>> -              dev_err(smu->adev->dev,
>> -                      "New power limit (%d) is out of range [%d,%d]\n",
>> -                      limit, smu->min_power_limit, smu->max_power_limit);
>> -              return -EINVAL;
>> +              if (!limit)
>> +                      limit = smu->current_power_limit;
> [lijo]
> 
> It seems this logic is expected to work only on SOCs with min_power_limit = 0.  I don't know the history of this. Shall we move this up and make this notation generic - a 0-limit passed will try to reapply the current limit for any SOC?
> 

Yeah I think that's a good idea.  Basically if your write a limit of 0 
that you always end up with resetting to default power limit no matter 
what the min_power_limit value.
> Thanks,
> Lijo
> 
>>        }
>>
>> -      if (!limit)
>> -              limit = smu->current_power_limit;
>> -
>>        if (smu->ppt_funcs->set_power_limit) {
>>                ret = smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
>>                if (!ret && !(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE))
>> --
>> 2.51.0
> 

