Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6818CCF9EA
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 14:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4121110E4B1;
	Mon, 27 Oct 2025 14:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u2oY6dmi";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012032.outbound.protection.outlook.com
 [40.93.195.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CE210E4B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 14:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCeJZuBIYaUgm1/NrAPzHY00tEe4T70EI/CGNFBTtxh9eCOfqUkkC56ktlzUdf7XDbpN8DzVIWKq7+pKrMeCLckjPyQD23+9C17dh3Kt96tq1c1/WBD8gVtDaZSm0Mb88FcjPvmTF2ZolvTDG4L2oVRfrcI+mWirNkZ0DuEjz/CI/yaAuyqDPFn9B17pIgjco3bUwIs9SvMHWlPU5N5OFeYRW7RejqqhFbNi5jZwZEgdpdI8bBRsSfByfx9e0pxXn7dhfjwLuYB6PKAi7D1X+5szmfJUPfct5uB4Rd84G8KGOYOR+SxOq55kUW6K6BHdovOha8uSOiYFxQEMrjHLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wfM6Vimq/fwAOSdI3gtjmLVrl/Mz6S/3IZFeqeG0Y4=;
 b=dGx7UvZVW/em9tmspf8o8NLkRolwftH6OIf7UP0bvWKXjhOqPor1CfCcK4OsOBXbUUIqYRqo+VA8+hoD5MUAvG6FE/sa5bUdXQA5KJUKK22xi+c9Em5u39qCrD6I4TSlRgsDp1DssOpqurdVG4NRWJeSKbh05C+SaJyN9LDNtuzpieSAuG1sexN6wCiVv0bLbcr54F3xoNIII7rO2BQdS/rvpM6ikxqeUV7wbs0ka5dxR3ZECPt/VGWLlv2yw6hKWhPs/xRhaF1JQ9OZHgiJh0Nl9EpDt7SGVZL79ZCcPUqOsd+rzqeYR5EV3KyqyzPqgzZ6+TXmmzMAd/vc9NA+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wfM6Vimq/fwAOSdI3gtjmLVrl/Mz6S/3IZFeqeG0Y4=;
 b=u2oY6dmihLwr/E00+i+ss2keaINOQ80tQqTtRFHMROgans5SyRJMR6bf3/66OXbC6+NfYP8S8datLjnpwjeP3Lxw7HMW9Bd3BE5mupk0v6s62aBxUVxvrpgy0nmE45dD+lkjh1RgFetMELULHVwpYeJUbTOS/ZXGlnTVx1xVjwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 14:28:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 14:28:21 +0000
Message-ID: <f8ccd8cb-8ef3-4c6c-b512-a469da7f5512@amd.com>
Date: Mon, 27 Oct 2025 15:28:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu: null check for hmm_pfns ptr before freeing
 it
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251023065848.1664757-1-sunil.khatri@amd.com>
 <dc5cbf60-d73f-4590-ab7c-0ac3e919fb5c@amd.com>
 <a1c87ae7-9f8d-4fb7-a141-c285776d76b0@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a1c87ae7-9f8d-4fb7-a141-c285776d76b0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0302.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 2123a5f5-5a9d-48ac-3e8c-08de15651426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGM1RVRBa0V6TmlCeUkxTDdVaFFmOWhTa05UODI1c2Mrb2ZEeUk3YWZzOHRK?=
 =?utf-8?B?c2RGNHMrbUVpNmx2Q0o4aTZpSTBxNXVJTW92Mlh6U05JRjFXNWh2MmpCdkZw?=
 =?utf-8?B?TkdmdGo2ZG80azBuK1UrMEhyVUFOVG5JcGZ5R0VIWEFzZ1luZUdST2dacjFW?=
 =?utf-8?B?VldEN0t6ZFdXTnF1eXhDSFIxM2lrcTNnUWxSM2hjdUxRTy9zTmQ4bzNTNUUx?=
 =?utf-8?B?RGFuM2NwTVRqSnRGbmlVMlNXdWphL25zZ1dVcWYzbWYvWGxUVTBtUTlDOFkv?=
 =?utf-8?B?cWd2TlFQcGU3a0dKelZtWWZVNnlXSmFjV1hCS2FxaHRuQzByTHFxTUpydVBn?=
 =?utf-8?B?WFpCVytRYk5oQW5PbHdxSlk2UTZwWVl2ZW9zUjQ0N1ZGT2lLc3RZSmJnVnc0?=
 =?utf-8?B?MVlWMVphRmF3OFk1V0dVV290dWNBOFA5SHdITW12VXhUQnUwdjlYTVA4ZE5t?=
 =?utf-8?B?eWxuOFF3Q2VJbWRlMnZsQ1l0d3h1ZDhjalM0OVJOckJqMThMalhTNGFTSU1W?=
 =?utf-8?B?SG1waDRjb1h6UzFGU01aejZOT0lNV2dEMnAwMUFmSTFoM0pBcU92K0VlNUdx?=
 =?utf-8?B?RlVKallpMkRQQmNlb0NOZlZqSDhVQVBxMGM3Qmo4L2EzOWFFc3hPM08zMFNu?=
 =?utf-8?B?ckxxMTFSdXVCUDY0LzYwTW4rTWVIYTBYdjVxM0F0NTVaUHQ5N3RYNFc2Qjl0?=
 =?utf-8?B?S0tReWZCRnhOM2l5bjZXMml0MlNpWi8wRDNHZGVOQzhCbzdNT0NGbDJ6ODhF?=
 =?utf-8?B?am9tVDRLdGh6UkE2cE5qNFZpcU5zcnpDdVBlMVp5TjdBL25TZmlPTHlRb2Ju?=
 =?utf-8?B?UEowblUyUkxoUVBOK1hnWjRSbFp1eWc4QzhuQ1VRaUVwakgwcFdTVElSVVIz?=
 =?utf-8?B?MkdQZnY0VDJ4ZGMzRDRMNS9oaS9oZDV2bTQxZk43c2R1VnFYa3FEb1lxQ2J0?=
 =?utf-8?B?UStMV1EyaVVoQVRRVWRsVlZWVmpMWGNTK1psTlRGQ3AxbnBmdjUzNHZFbmtj?=
 =?utf-8?B?ODlPa0NFenEzNmVySVVuVGx1aU1OUmJQc2FmUmNTbHBkSFR2ZnhjbkhCblVU?=
 =?utf-8?B?T1dPVXhiQzRDSHhvWllDMDN3SzFJelJwMG1yTE9sQ0ttRGErUm5SNXliT042?=
 =?utf-8?B?RFFuQzFUR0E2bDBpMWRBOEt0c0Q2UGJ3R3hQNE1ybFc0d3pNMEx6b0t4MEhF?=
 =?utf-8?B?bGxpZDRCU1FXSVJMREZtQ3NiSnZhSjliQk1ISG1TT1lzN2ZhSWx2UExuVkda?=
 =?utf-8?B?TTJNS0w3cXhyL052bXJMT1c4UWQyblRqS2FpWkQyUWFubGZIckNkWDd6czEy?=
 =?utf-8?B?WGJtSmt6V3lHbGpoTG1SMTdaYmtNWmdJSStHQWg2eEhoZzM0NHNHMGpGU1Bu?=
 =?utf-8?B?Sm5mTXpvd3RFTGdhbGlJS3QxRGVCZkJjb0lMNmUxUGJNTkd4RThoNTBmNkQ4?=
 =?utf-8?B?RnZmNWRYZE9FOFU4VU16ZUlBMFpiVUpDeEZtYmlWZTl3aFEyTkxZaDdyMTJm?=
 =?utf-8?B?djh5LzIxV0hETU1KZEowbG4wOWlQejFRaE5hamx0Yll1RGpvYnN6YW85azQx?=
 =?utf-8?B?bFZhMWNLM3hHVDVteWZDdSt2SFZTS1ZXTkZ0NkxBMVlCVUpNclFKSmlBaXYx?=
 =?utf-8?B?a3dIbzE3L09aMWZ6K3M3MUJQSHQvc084dGF6RnRkMy9CME9VdDFkS1NLMkhx?=
 =?utf-8?B?U2Y3YkVPbXphNXZzSUFKMDE3YzFhWi9WcjdIaStCQVhuZEFhL0RPeWw5c01R?=
 =?utf-8?B?YW5aNEFDUzd3a0lKNmNSN2hvd2VjVE00aG9WL3lURWZJWXB5dnJLc0JBclhu?=
 =?utf-8?B?SllIVUhRTGpOVGhlbWJzUTF5VHJVOXVraUZGNDZSWjQ5R3VmYnAyQm9ERk1j?=
 =?utf-8?B?cm55ZEdVWHZ4K0I3UEUwWGEycnBiY2NzZ1JSQlNzUjFEaVU2eVlVdURieFZJ?=
 =?utf-8?B?clNRaEsxV2JBYU1NS2tLTU5FNWpYMFZ1UmcvUlF4Y2NqK0xFajljV1pkeHlq?=
 =?utf-8?B?bXR1ci92dklRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5ndWdUQWtKak1BU3pwY3F0K0RIV0pHajhzcUtKSGNzenRwME9scXlCOE1I?=
 =?utf-8?B?Q3JNTk5xQzdKTDdMZ3FtdkU1dHN5R3dUaG0waldSeERDd0xKaWZlbU83MG1u?=
 =?utf-8?B?VHplU0lSNUF0UVZhdVA3SEtHRCtRTit1dDJMejRvbXpaTFFVdFJvOGZySnJo?=
 =?utf-8?B?TFRCSkJnZEk1UHFmd1F5akVvTkY3RGhXUjRiWVpEbUgvTE8xby9aYlBsZmJL?=
 =?utf-8?B?VmdiM3dqamlxZUlLd2p5UmwzVFBUbFJXbFM1UjhFdnhLZ2p4ZnpZQW9JNVZ4?=
 =?utf-8?B?c0FxSGpmQnlYYWhhSjhRcWhETU5UK3dBNWtOOGRVOG9RTXpZcFViVHhSYnoy?=
 =?utf-8?B?bTFxUlBFSFhWa1U2SzZEOUQrcFdwVG9JSWJsRU1zRVg4bFVBaWFRU1pZS09k?=
 =?utf-8?B?WVpNaDBsblhSVmh3eTBUTjZDQXVsMTM0QWJMRTRkczhDYVdHUXV6YWZFUFlC?=
 =?utf-8?B?OWFadWJqYlZ3Y1RVVGx1UGRDRWRwdHFnNUVTa29Fb1ZPWHBnOVZrMTBqVzRa?=
 =?utf-8?B?SWpoRE5LVWJzcDNaVjFmOXdySGRHQW9jZFI3TkRIRVZaTmlsOXN3aFFxOVN0?=
 =?utf-8?B?RzRwUGZ4bmtVQWlIM3lkQ005VkNmOWVHYXlybk9PK2pDSHhxY2tiQkV1TXJQ?=
 =?utf-8?B?YjVycW9DeXFoMjdNaSs0K0plMnljNFlnWVpPdHFqSXRTQWxmbTVWM3Q0K0RX?=
 =?utf-8?B?anFWdFlNZmhEWWtKNTVRV0tqYU5uN3ZrcHMwQi9TTHVsTWcyQmYrdm1wS2lW?=
 =?utf-8?B?UE1WU1pTSzA0Q3E0ZGdoL2NaaG9wbTBQb0UyeGtwZWxGdXkzc2daTERqdFZT?=
 =?utf-8?B?YUJhUXMrUTVpZGtoTi9obzNXM2Z4ak5wMDMwYVdNVDVSVkFRYnhvc3c2VzdS?=
 =?utf-8?B?aDUrMFVEa3F2V3hlZytWU3FKWFEyK3FhQk1IbHQ0Y3Z0cW1uVUhva2xkWUZD?=
 =?utf-8?B?Z05ZVi8ybWxkS2drQlJKeXQ1b2k4bHpxRm45ZmhTVTRSSmtRVjdjVWQ0S2dv?=
 =?utf-8?B?aDZ6U1BxRkJFdU9GMEs3Z202Mk9OVkxDZk1pR3JhRTVUc25NeXZGdFc3V3BR?=
 =?utf-8?B?Q0tYL1hjRFhUeTFxdmg0UVg2REVTa0g0QllFc2w1N3VWK1Y5U05ZbEZSdU9q?=
 =?utf-8?B?Q1A4S1gxRDFxRTBPdDNZSzlKS1k1ZVk0Qnlxb3RQRXR5UzROWE5aaDJlc2xk?=
 =?utf-8?B?MXZCc0pIOVh6eXFheGVlQzFUWG1xM3dXblY3TXpPK1NBZkJiMTFMOW82OXht?=
 =?utf-8?B?QU9pWVIzUUc5MnhsNjJDUENONGtqZjFOYXlPSld1cnlyeHFmN3dPNmtPQXAr?=
 =?utf-8?B?eW5yYXptZ0pHY0U5Ri9uMGhKVk9nNGRYV1o0ZDhEMDJyeHRVcmZpQXV6UVVl?=
 =?utf-8?B?c0xRVUF0UVEvMnlKOE1LZkZqcytCNnpCM1NYQTkrVTh4cmxtV1dEUmZmOXBa?=
 =?utf-8?B?OVNnOFQxeEYzajJLOENVQ1NmODBja2ZPeDNHckovVkhXdXJEYVUzMk8vS0Uw?=
 =?utf-8?B?anJla1dleUdSQ25uQ3pkWDZGQkh5bHBaSnB4S0tUQ3FaWWlnYTV0WHZmTkZV?=
 =?utf-8?B?U0w5OHIrNXNGODJPWElUYjhHODRTVmxtZGJLVlk3L3dTWE9QSFVqd1M2NjBs?=
 =?utf-8?B?TDB6VWZ4eW9GWGI0bjdiUG0ralBwTDUxNko1bUliR2liWFRPRnJpK1FMc01n?=
 =?utf-8?B?c2xXZ2lza2pyaHJqUmplTjFWT1VXOGRtSnJpVE4rUEdWRmQxem0yVjE3Y1ZO?=
 =?utf-8?B?UEM2MzdHSzcrNzlXaDFWTHNhRlhubUN4MWVDOUJYYUJjYzlUYmJRU3pmVmp6?=
 =?utf-8?B?eThXT2lOVjFDV1BSZGNyc2tLSDB0enQreFhxeU9XUWRGQkxiTGNTcThNUEhD?=
 =?utf-8?B?Tzc5Yy9ndDBucDJ5L3NNTS9ZSlRrQkZIS0J4ZlFsUkYyeHVnTisrdVk3aGgv?=
 =?utf-8?B?MmVhNGNCY3dUUFFIUnRyOUI3VUhFak9oZG5UNWhNalV5MVRzTm9HRjRhd2xt?=
 =?utf-8?B?RlRXZ2lDTjNqYTQyRWtBMk85bVJ0WGdkMVNvbGwrYXk1TFRZZWZHTzluK1hm?=
 =?utf-8?B?SXN5cklpdVczY21GOU5Bakd4aXdpMkpOSHZydFN5dW5na1c5c2NuWS9UdTVE?=
 =?utf-8?Q?1224=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2123a5f5-5a9d-48ac-3e8c-08de15651426
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 14:28:21.2402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSQx8uGh+wzuD6PHQ2EsCESlhEYYbQ7u9XDhEhXoxZwkdCC/Rq2NtL2R3pEiB5On
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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



On 10/23/25 17:30, Kuehling, Felix wrote:
> 
> On 2025-10-23 03:48, Arunpravin Paneer Selvam wrote:
>> Acked-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>
>> Regards,
>> Arun.
>> On 10/23/2025 12:28 PM, Sunil Khatri wrote:
>>> Due to low memory or when num of pages is too big to be
>>> accomodated, allocation could fail for pfn's.
>>>
>>> Chekc hmm_pfns for NULL before calling the kvfree for the it.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> index d6f903a2d573..6ac206e2bc46 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> @@ -286,7 +286,11 @@ void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)
>>>       if (!range)
>>>           return;
>>>   -    kvfree(range->hmm_range.hmm_pfns);
>>> +    if (range->hmm_range.hmm_pfns) {
>>> +        kvfree(range->hmm_range.hmm_pfns);
>>> +        range->hmm_range.hmm_pfns = NULL;
>>> +    }
> 
> NULL-checks before kfree and friends are unnecessary. There are actually static checkers that complain about such unnecessary NULL-checks. For example, see https://lkml.org/lkml/2024/8/11/168.
> 
> The same is also true for the standard libc free in usermode: https://stackoverflow.com/questions/1912325/checking-for-null-before-calling-free.
> 
> Finally, setting range->hmm_range.hmm_pfns = NULL is also unnecessary because you're about to free the whole range structure anyway.

Agree completely with Felix.

Sunil why do you think that this is necessary and blocking KFD for some reason?

Regards,
Christian.

> 
> Regards,
>   Felix
> 
> 
>>> +
>>>       amdgpu_bo_unref(&range->bo);
>>>       kfree(range);
>>>   }
>>

