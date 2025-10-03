Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D50CCA471
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 18:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB1810E153;
	Fri,  3 Oct 2025 18:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UKBjiomV";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81DAA10E153
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 18:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyHtlHZclW89YBVQhrbSrPgZcJU2hmVrbotGdaLlj5NAVHdtpLPI8wpNTlS/t0RjpvqtTT93CvNPx6Zm0rdR1lxYR91gynFAfNjJYUXmUx8+1EgUSPq5nydAF4fteKm0cIQWymQDyTRA4J7uzQYxg7CvnU5cdNKilk5YQV3YyIDSlmoG0kISDusFbCeaseAAaeAajqUpRiOhaod3cuW1B08WA+Mh+EwEbXl8h6t0wiMyq1wLkScaU3iSaY2qNbilkCT8cqdONS4OF6yOceyDlx7LwDHWaggUBj273E+z+2esLwoQLN1fyfVb6zVWYz75UGr/nHFuTk9NMBzKEPJ+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM5iQL/APds22rPV5b9sAAjIr0bau2Jzw7PjjNUS+5U=;
 b=k8j55hZX3CHK2z19GMa0IDAUQXZlDAix2PW8aLScWJFxEDweeGt9NzRIfCA6jlADyU7Byj4QdC9RAO8QcpNnwiWsQmN0Un6LobHMdDMy0Ce0QMWaBpuB98QcxKjp/wqSHtlpbFtH/hpF6q3sax3yF6up3NwCc3N82rCT6f0/ZNpM3yFjBmBNYwTZ1tcHmFqGqVlroKUFS04JAGH3MyZfLbVXG3WeYirXid8P5QbCBfadWpUeRHpVknQ4Fz2A2Bo6Dmclf1yLkkHF18XvUq3OmkwZsvoZeNKL+0rOBalc43RrN7EkZ61VUOC2gu3r0A8GRQJnEOtrK1aunvHUhSbirg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM5iQL/APds22rPV5b9sAAjIr0bau2Jzw7PjjNUS+5U=;
 b=UKBjiomVNIZMKiowefFgsC3EnUeeyW5UR3jnimfUwQT8ToYQrYp0IZqvRc7ZNfJupEg0nLsJCb10Kj2PIUe32JBbmOQdF9v+A1HPf3dJIZLJ9zMRRsayIbhfm0UX1V63/+IGu60Mt8Amv5cPxWdZS9mVEZ4hDupF8pacEJFxQcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Fri, 3 Oct
 2025 18:35:00 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 18:35:00 +0000
Message-ID: <6fd40823-96a9-4307-8364-8a6c70153a85@amd.com>
Date: Fri, 3 Oct 2025 13:34:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdkfd: Don't stuck in svm restore worker
To: Philip Yang <yangp@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20251003181518.24270-1-Philip.Yang@amd.com>
 <20251003181518.24270-3-Philip.Yang@amd.com>
 <DM4PR12MB656658906DDEEEA2D86AA64AE3E4A@DM4PR12MB6566.namprd12.prod.outlook.com>
 <85af42a8-25a0-5614-a35b-fdfba1b7589b@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <85af42a8-25a0-5614-a35b-fdfba1b7589b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:806:127::14) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 824a06f7-7ff4-43b7-ab7d-08de02ab8f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHJUUWw5K0d1SVQyWVhCdmVuSWVqZ3BHNHR4cEowSThvRjArZGdqSExRS09z?=
 =?utf-8?B?UnhvcnBkWGtHaFVMOG4yS1ZDMTJjVEV3cHBNalYvQ2lDL205Vnd1WStZQTdi?=
 =?utf-8?B?aE1neHY0WEtNRldydisrUTVlUy9RcFhEd3ZJUWxLd1hHT20wYisxcGZDSmJM?=
 =?utf-8?B?YllRbzdVandkWEJDbXZhdUdYd3ZUdnQ0ekxpN2ZMUGdLMWhBd0oyZ1B4Wmcv?=
 =?utf-8?B?WEhBWjVRKyt0VEc2aWI1Y2cwR2Y1LzduUDRWNGR6bDBnNUR2OFZ2dmkwSXYx?=
 =?utf-8?B?Nzd1Y2RXUUdFb3UxMHJ1MnA0K3ZmSmJBQ2lMTnFOMXlJVUZjLzB3YkVLaGhR?=
 =?utf-8?B?STZ0R1hYd25uMTczV3JMc240SlYxV1FNV3JvQUUzRGpvZ2tRYldMWFh1Ui9a?=
 =?utf-8?B?eGdCRXJIZzlYTmpiM04vWWJncDZRaWM5YUQ4amNLMVRkOTROVWZFOE81SnRO?=
 =?utf-8?B?NW0zQzhWYWNzbUNzTUtZMkltL29aZmQ2STRMTEVpNE1VZVhNdHd2UTA0Y0JI?=
 =?utf-8?B?TS9qeHg0UmtkZVJRRGxFWFpYL0JHT0dKOEs2TEFpdE15TjB3K0NxQlJVZ0tU?=
 =?utf-8?B?dHZxcEp4UGgvakZpRjBkeG5DU3pmeVhlOWh3bHl0TlJhWUxiMThkbEFqK2Yz?=
 =?utf-8?B?SmV6Z2hrclArZit2eDIxaitYKzdNMnE1NktsbGJJdTg2VHZXRFVyOTlDaEor?=
 =?utf-8?B?TWVPWVhxSWNCMWR1YjNYY2drR1BDQzBpb25RVml4Um0xUkJpNWlFZ08wRWZz?=
 =?utf-8?B?N1ptbmM2Zjc0bU5OZjg5TEVNZlNacyttTnlDNVVKbm9iMTRvWWVLN3ZXeDln?=
 =?utf-8?B?UVhwWHhEREpkYzBPWVZkb2diUWEzeGp1SFF4dFRpSVM0dVB5RFRQc05YUjMv?=
 =?utf-8?B?OEk0RXJLSERROW9mM2xGZWlRSUlEUVJQSHdCcFRCL0ZoVUp0dVd0cjR2dTZW?=
 =?utf-8?B?Q0VKOXE4Z0NMNC8rZ2NhMy8zYXBaMUhESkcxWWVkYk1aUXlXazkrWUZNTG1M?=
 =?utf-8?B?V255L2F6U2ZaSlFCNUt0ZXpWZlBBMml2QndqWmYyMzhqTCtLRWsydlNWVlZH?=
 =?utf-8?B?SVkvOFRaL2dZd1hHTkZKY1ZTd2N5a2IyY2N3VWtvSlp2ZEVJZnJEaEpubzJO?=
 =?utf-8?B?QmdKNlB2c0M4d1QvN2hhcVBKMzd2OE5UenI2SStUMWdPeVM3Q1hJRFdPTnNt?=
 =?utf-8?B?L3FTd0ovNTF6RWs4NnlYSm5lNDhEMUpOQ3RNeWpkOG9BUU9MTFNBVGJOTWNW?=
 =?utf-8?B?bitjTUZydkduYjVkTWFZOW1jdGd2OW1oeFhuSkhLQ0dCdUU3TGxDeEVNKzhs?=
 =?utf-8?B?VVp5eElRVmE4RG5ZVTBlS28vOWQxb2ZySi9BOS9ZRWpSY0xuOURhdithNjZt?=
 =?utf-8?B?NWtCaEk2bHZuTmoyaWFJNHVqM0FDTjlmS3VabCtVMlo0UlJvRXpWOTVzcHhI?=
 =?utf-8?B?QjF4bkQ2aHI3SWErVmcwUnA3ekdkOVdOa3IyaW9vWEhyakk0SWF0Y0FMczVo?=
 =?utf-8?B?SDR2WVBhN2UyVU5lZmQ0TDBPMGpaQk9oQy9Eb2ZqNFhiaE1iUXZiajF3Vnly?=
 =?utf-8?B?M253czFXVm5GdlhMZjhmNHM0clVNTVNja3ZsL2VhWjg5ODNQb0tIRU43Mkdr?=
 =?utf-8?B?b1NTTmhhYUN3T1VQZGZkU1hYVnV4VHdGNC80UzIzOHNTbGQ4U2tNSVk5M2dr?=
 =?utf-8?B?amNBL2NocmpETzRYV25QS09EVkdFZnZYRkZLWGsxT1o4c2lNVnkySDNNb0Zn?=
 =?utf-8?B?U3pQTXU2ZGF1cERmclhiZm1SUE9oZmtTcHhIbkczR1NJWGRZWERlNDgvOEU3?=
 =?utf-8?B?U3p0ZUc0TUtSTDZXTXVMS08vb3poTXUzUzNVV3RCVmlVbWN6MFZrSi9wUnpz?=
 =?utf-8?B?cnl6bTNQVDZFY3Fsa3pLR2RXYi9WU2JjOXVpRzlnRUNSRG1SbnpRSERoamd5?=
 =?utf-8?Q?RAibxY0cmJD9I58pZtJhMI9df9Hltpwp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGNIb2dKV1RhaWg4SnpYbm42MkJKN29BM1RYMEYxVkU5d2w0SGY1K3h6S01K?=
 =?utf-8?B?T0k0S09OVkdORStuaXM2clczbDdPc0R0ZXRpd3JRdUNtNTdXK0tpRC8zM3dn?=
 =?utf-8?B?ZFlLU1A5MU52ZEs0NUVWcHNUTkNocE1uU0xHbEtvSEhMcUV2Sldsc0dmUEVp?=
 =?utf-8?B?ekt5ViswMllxZkZSZmVEYm1pNldoMmtrWk43ZTJnUEdxd1k3bHlOL2g4ZVhR?=
 =?utf-8?B?SnZYVDlZVnJZNUtTRStxbzhGeUVOOE1BWTlVWHZOL0RkYmdWUm9LQ1lEcjd4?=
 =?utf-8?B?U0kzSGo3QUFYbXZ6Ty9DMkVTNHB6WmJmV1RnZnVpN0dQcXZYMG9tcGc1bUtp?=
 =?utf-8?B?Z2doWk5hNjd4bkNiU01zUlRyVWZWd0lNTzlkVStCNDRjU1hSU01nenpMVE1H?=
 =?utf-8?B?cUxpMDZYcEg3NkZRT3o0Vit0YTVRcTFwajY4b2hIeUkwNTluMjM5NGlqVG9l?=
 =?utf-8?B?TkZvc2taYjBuTGl6M1Y2M1BxcTJjM0lMQUsyZmRFTW9ENUsvM3lld2QvOTEx?=
 =?utf-8?B?ODlLR1RKTUFKUXBWU3FCVFFaNVJJN2RVNTRvTExEVmdQK0NsbEdKNkhsUXN0?=
 =?utf-8?B?MFFTMkx4a1krYjJjY0tjdzRPWUlYOG1vTDR6OTAxRXRNTUZ6MUJZajZhRWpj?=
 =?utf-8?B?ZlRLS0tYZ2xtUXBIMGMvUmxhZDdlU3pjQkpFUUxDUTBLQnBwTC9oaTk5R3g5?=
 =?utf-8?B?Yloxc2NZd0prUm5FT0F2L01LRTJWbmphN2cvWG9ENHFUbkxrS0M5R3FmNnJC?=
 =?utf-8?B?WG4wK0VTUTBmc0NCclpHZlQ3M3A4NzY5aVFVclBYVEtPSXBWNHg2aytIUUVP?=
 =?utf-8?B?a2hTRHJEVHlDa3ZuN2pmQnJMT2oxMy9oNHVveWk3bEoyOVFUeU8wYkhOUFJB?=
 =?utf-8?B?SWo4OFlBYXdqRUFKUmorTlNYbkRTTGxpRUU2U3RoZHVmUTVCSGQ4SHhTZnhr?=
 =?utf-8?B?RWpZTHZ0QWFoZllGWDFNTGxDVzBQMXVkUnQyWGhmQWFRVS92a3FNOGdMeURB?=
 =?utf-8?B?RWlFeWoyMENDWmtvTUlQN21vUlJ6TnpoL2JjcGVPYlFjQ3pKMVZZVlAyMmFU?=
 =?utf-8?B?T3kxRGFqUkZuaTN2K2kyci9yL1ByeWxlU0tZb3d6bWJiRmdnWm5xUFlieFdj?=
 =?utf-8?B?Z1htdHNNc0RIMUthVlArTlVPdy9QOWJnVmZHVWo3ajM2M0MrMW12Rm93UDdV?=
 =?utf-8?B?U2Y4Q1JZVk5OeTVnYkdBeDhXeVQvaWVwT3pKMEFRb0pYRE9KeFRhdEI1SUY3?=
 =?utf-8?B?RDJwenU5VkhxeW1LZ0x5Z1dGdnhCREhsUVhodU1yKytXQldjM29vWVpld082?=
 =?utf-8?B?cnQrdjdXZWdFSmZmSldMa2JvcVp1OGptRzJ6UmxTZU83bHJyUlc2S3B0ckpY?=
 =?utf-8?B?TjhCOVM1TWtQL05PSGQ2L1o3OTdFMXlWbEhJeXBRYkF0M0hWcW11cFNtTDhv?=
 =?utf-8?B?WGRRekJyRGRCbGg2OW9TRE1BTjV5Z0FMcUk1UU43TEwrK0RuL2ZpRm9ncTBk?=
 =?utf-8?B?eFVmWWw4ekV1LzRNQ1BwNk5jRjljeDFENis4Rm9KMVBnVnFwU01uSkU2eHZl?=
 =?utf-8?B?RUxVQjBsOWNuSnhnUXVneGhiL3FITFp4VXFJaGVOVENxT1ZoRlprM1FsZGdN?=
 =?utf-8?B?YkZDNmVUc3lFNlB6VFpYQmFxcUNyajFvRjBYdlBoZDZFZEJmQnp0UEUxZ0VB?=
 =?utf-8?B?eXRuWTdyd3A5TzV0MDY2SmdJaURwMWtGQi9wN0hKYTV2ek1QOW9NckpRelZL?=
 =?utf-8?B?M1g1dTBJWmVzWjNiUGVlSm9Sa2thYXVZSXpnalA3RTZ6eFNKdHpUc2NmTmtp?=
 =?utf-8?B?MVpmb0lEQ0l2OG9pb3FEcjhva1g1VDJrVzFRZmVNZlppckpNVUpHM05Dd1ZM?=
 =?utf-8?B?TC82S2grdkdWRVNwa3Bra01icmpWY2VPUG1IdzU0M1MrVDcya3c0c2xGQzJo?=
 =?utf-8?B?SCtibkROdGxvNFBkRi9hRkw4MnN1N3FoTGRQaFZIVjRtY2xuVDYrSEViWE9r?=
 =?utf-8?B?TTJoTnVadFRzSTJqUXc3eEJualpOOHEwM0dRQUtlcTVJam8rajllN3lyc0F4?=
 =?utf-8?B?VGNEbmtnRVgyUUxnSGpyUHlvbGZkdDF2ZTNocXlPSlNjM0w3WTZFcjJkeXRC?=
 =?utf-8?Q?nBdc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824a06f7-7ff4-43b7-ab7d-08de02ab8f65
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 18:35:00.3523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dQkTA0ADa3XffJzrH6fT900dejLwWRFkDxEWViMbQLlMF/i+XK60jTu9gvtjjCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
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


On 10/3/2025 1:27 PM, Philip Yang wrote:
>
> On 2025-10-03 14:22, Chen, Xiaogang wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> The MADV_FREE is handled at 
>> madvise_free_single_vma(madvise_dontneed_free) from 
>> madvise_vma_behavior at mm/madvice.c.
>>
>> It calls mmu_notifier_invalidate_range_start(&range) with 
>> MMU_NOTIFY_CLEAR to notify registered vm intervals. I am not sure how 
>> driver don't receive the notification. Is there something else cause 
>> the problem?
>
> I cannot repro the vma not found issue with madvise MADV_FREE on 
> Ubunut kernel 6.16, this issue reported on a customized older kernel 
> version.
>
> Regards,

One principle of hmm is gpu vm is mirror of cpu vm. Whatever happened at 
cpu vm need to reflect to gpu vm. If there is something wrong from hmm 
that driver did not get notification from mmu notifier driver need 
update gpu vm, also the correspondent prange. So, besides unmap from gpu 
vm, I think driver also need split prange to remove correspondent vm 
range from prange.

Regards

Xiaogang

>
> Philip
>
>>
>> Regards
>>
>> Xiaogang
>>
>> -----Original Message-----
>> From: Yang, Philip <Philip.Yang@amd.com>
>> Sent: Friday, October 3, 2025 1:15 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish 
>> <Harish.Kasiviswanathan@amd.com>; Chen, Xiaogang 
>> <Xiaogang.Chen@amd.com>; Yang, Philip <Philip.Yang@amd.com>
>> Subject: [PATCH v2 3/3] drm/amdkfd: Don't stuck in svm restore worker
>>
>> If vma is not found, the application has freed the memory using 
>> madvise MADV_FREE, but driver don't receive the unmap from CPU MMU 
>> notifier callback, the memory is still mapped on GPUs. svm restore 
>> work will schedule the work to retry forever. Then user queues not 
>> resumed and cause application hangs to wait for queue finish.
>>
>> svm restore work should unmap the memory range from GPUs then resume 
>> queues. If GPU page fault happens on the unmapped address, it is 
>> application use-after-free bug.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 75 ++++++++++++++--------------
>>   1 file changed, 38 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 0aadd20be56a..e87c9b3533b9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1708,50 +1708,51 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>                  bool readonly;
>>
>>                  vma = vma_lookup(mm, addr);
>> -               if (vma) {
>> -                       readonly = !(vma->vm_flags & VM_WRITE);
>> +               next = vma ? min(vma->vm_end, end) : end;
>> +               npages = (next - addr) >> PAGE_SHIFT;
>>
>> -                       next = min(vma->vm_end, end);
>> -                       npages = (next - addr) >> PAGE_SHIFT;
>> +               if (!vma || !(vma->vm_flags & VM_READ)) {
>>                          /* HMM requires at least READ permissions. 
>> If provided with PROT_NONE,
>>                           * unmap the memory. If it's not already 
>> mapped, this is a no-op
>>                           * If PROT_WRITE is provided without READ, 
>> warn first then unmap
>> +                        * If vma is not found, addr is invalid, 
>> unmap from GPUs
>>                           */
>> -                       if (!(vma->vm_flags & VM_READ)) {
>> -                               unsigned long e, s;
>> -
>> -                               svm_range_lock(prange);
>> -                               if (vma->vm_flags & VM_WRITE)
>> -                                       pr_debug("VM_WRITE without 
>> VM_READ is not supported");
>> -                               s = max(addr >> PAGE_SHIFT, 
>> prange->start);
>> -                               e = s + npages - 1;
>> -                               r = svm_range_unmap_from_gpus(prange, 
>> s, e,
>> - KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>> -                               svm_range_unlock(prange);
>> -                               /* If unmap returns non-zero, we'll 
>> bail on the next for loop
>> -                                * iteration, so just leave r and 
>> continue
>> -                                */
>> -                               addr = next;
>> -                               continue;
>> -                       }
>> +                       unsigned long e, s;
>> +
>> +                       svm_range_lock(prange);
>> +                       if (!vma)
>> +                               pr_debug("vma not found\n");
>> +                       else if (vma->vm_flags & VM_WRITE)
>> +                               pr_debug("VM_WRITE without VM_READ is 
>> not supported");
>> +
>> +                       s = max(addr >> PAGE_SHIFT, prange->start);
>> +                       e = s + npages - 1;
>> +                       r = svm_range_unmap_from_gpus(prange, s, e,
>> + KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>> +                       svm_range_unlock(prange);
>> +                       /* If unmap returns non-zero, we'll bail on 
>> the next for loop
>> +                        * iteration, so just leave r and continue
>> +                        */
>> +                       addr = next;
>> +                       continue;
>> +               }
>>
>> -                       hmm_range = kzalloc(sizeof(*hmm_range), 
>> GFP_KERNEL);
>> -                       if (unlikely(!hmm_range)) {
>> -                               r = -ENOMEM;
>> -                       } else {
>> - WRITE_ONCE(p->svms.faulting_task, current);
>> -                               r = 
>> amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>> - readonly, owner,
>> - hmm_range);
>> - WRITE_ONCE(p->svms.faulting_task, NULL);
>> -                               if (r) {
>> -                                       kfree(hmm_range);
>> -                                       hmm_range = NULL;
>> -                                       pr_debug("failed %d to get 
>> svm range pages\n", r);
>> -                               }
>> -                       }
>> +               readonly = !(vma->vm_flags & VM_WRITE);
>> +
>> +               hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>> +               if (unlikely(!hmm_range)) {
>> +                       r = -ENOMEM;
>>                  } else {
>> -                       r = -EFAULT;
>> +                       WRITE_ONCE(p->svms.faulting_task, current);
>> +                       r = 
>> amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>> +                                                      readonly, owner,
>> + hmm_range);
>> +                       WRITE_ONCE(p->svms.faulting_task, NULL);
>> +                       if (r) {
>> +                               kfree(hmm_range);
>> +                               hmm_range = NULL;
>> +                               pr_debug("failed %d to get svm range 
>> pages\n", r);
>> +                       }
>>                  }
>>
>>                  if (!r) {
>> -- 
>> 2.49.0
>>
