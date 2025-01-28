Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB32C0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 11:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E3610E66B;
	Tue, 28 Jan 2025 11:37:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S91hhihM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 265F210E66B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 11:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hio5fsaruemVsLeh8hXLp0wobq32CcQg5HnFBnP9nWxMXHwtQMwAactFlbEAWymNBD1Iz9mrGC/hKOomCsPDrlsDXqYB+eqdPVJ274r8EIZBZIFQi1lDM5UWQJa0DLW5mO4aD8KC8XcjVBpCPzge6O8ZKnRh7O/RLun5JoCeskl8p7d0lCG9EQqTpPFVb23U8q9H9Arz7Lgrc/li5BmKqjx7mvY0D0K9mdjG9LvVyvQgZdvEhVxmpIs2tmiv1srJQVtkEO22u6woGz+vYc35iOyKhvtYkbk3x8sGOweSZx1if8Gz99RvdMNlNaA2Es5FrxlB4/8cEED71cQeR4pjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwDYDtSscL2cQ73RRer8N1d8wJazJMWta22ViJDCn8o=;
 b=kEMzZGn+FLZ/OI6/T76pf6DNu2yArzDP/OqH58QZdwsAttA5UA0k30vLRB7WQwqzpDWDqnaZAj41JrgvNwv5TpqmbtUp0RFeb2i+5+acjnllGkKWshMHOpDdp7EutjBawM4mJ4oVDZmLV2yyY7pcHwBL38/amvIVjAhYPO2+qQ3PfK+OUUO+6Eakc3B0NwG291rwRPz+Ab63YDW859pmUqwJqxYqds/nkqZ01LMwrXWw72S+aEAlxH2dNnvbuaCMloCuAeqwnCSxWh102SUtkkEh5hHfXBXjF8tAxysz6Q/1liYEsOHG8xHOGSylcYlmmDxiOwo35lMxEw86NfGhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwDYDtSscL2cQ73RRer8N1d8wJazJMWta22ViJDCn8o=;
 b=S91hhihM4DdN4bGs9/WZr3HutVsNc3GLiIUZmFlMk91fzOJOQk+HMDnELX2bUudfv97pmSxLob6GmZtPO5USOaJad+O8dUmEr+inwLz64dpsovFLSmKljS99a7sMHqMCTzVELNSpvlI+Qg1c4rVFs9zuskRc8uP4kpo5K1ZIbu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 11:37:01 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.014; Tue, 28 Jan 2025
 11:37:01 +0000
Message-ID: <9b7392c7-6085-4c99-93b4-2bfac8b332ce@amd.com>
Date: Tue, 28 Jan 2025 17:06:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: Add helper funcs for jpeg devcoredump
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
 <20250128090950.461291-3-sathishkumar.sundararaju@amd.com>
 <16793f54-a7b8-4e45-b899-fb177b39f8f7@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <16793f54-a7b8-4e45-b899-fb177b39f8f7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::21) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 996741e4-3ba1-4c0b-f62c-08dd3f901499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2VUVTRlYTNXSkVVNHpqeHRwQWs3WXZObkFUb21HZE03U3huUVlBSWl6a2JP?=
 =?utf-8?B?Rk1iWE1FeVpCdlJMRUhLRjhBNndwVS9Ca0xUTktVb2NDakdibmwzcEx5cUx0?=
 =?utf-8?B?cit4VEtJUko5SHRUZzZGYWhES2ZIWjRkR0tDNWt6RG1xaE5hWXgzdThwZm1y?=
 =?utf-8?B?dElKVjlqbWJoMmpKOGFZUStzT0l2cWkwUmZvQVM1aHkrS2pZN3lSRmJjOStL?=
 =?utf-8?B?VlNGM0pDUHF6OUZSSC9qRTZiL0ZaVCt3Z3hRMkptNi9QNGh5K1RuM2tEQk9L?=
 =?utf-8?B?dkxJeUd6WkpoWS9oUFVqY2t5dFEySGU4UFd2SzBkSlJFUkIzS2Uxbjg3elpx?=
 =?utf-8?B?elcwYkFxV000MkIyS3A0ZU5SbEQrd3JieWpxT0gvNzhyRW5RZjRhYTgrSGdq?=
 =?utf-8?B?RVU2M2hOL1RvbVhsa1lnWTd6cUw5NXgzZVJjbWw2L0V3NHBuVWErbjFYYzFM?=
 =?utf-8?B?eFpnNWdzcm1zK3hSSVlRU3FLVG41MmplWElmbzhadDRQWlU2SWRyM250VXZS?=
 =?utf-8?B?VFBGQk1nYnA3czlXUTRsaEpFZmZtRnc4RklCU3RpVTJka01NN2d4L0hHYU1z?=
 =?utf-8?B?SU9CRkFpU2dNenNyalJzREhSdldraHhTWnpTSVRDUG4wb202cVcxYVR0UTBN?=
 =?utf-8?B?SVdnUklyR3VUeFhINjRCa1ZNb1FwajBvTlErMm9CRFVyUFlwUGFLM0ZwU0F5?=
 =?utf-8?B?RCtDRGMxdXJFeXprcGlKdGsyTE1EWVdkcTdlQkV4YUVIaFdkeUV4cmd6aHBP?=
 =?utf-8?B?WFVNUnRzQmlqV2xzNzF2QTR5ak9VSFpNWEdFQTNlTHlTTEZQNGZiVThqZGd2?=
 =?utf-8?B?V1l0dGthU2tNZWdXYnZlWExLVy9yOXAzdEtjTDk0REc5WGlGL3ZnQ2pIUmlC?=
 =?utf-8?B?N25kSnRmZnZKUG5MRlh0dzVjSjBXZGQ2bWJtMDhpc1h1U3BRdDhlRDJqUXF5?=
 =?utf-8?B?aUMyZmdGQ1BYYnR0Wk5Vdy9MUUo2VGtlMEF4bUdnUEdKRHFnZk9FSURjb1Bx?=
 =?utf-8?B?YUJka2lvMHFWYjRCWGZ6a1hSOWxVKzdJMzgzT1psNzBoYk1ja24veVVjVGpr?=
 =?utf-8?B?cTBJelNtWklFWTM1S0ZqMlRMZ3RmUE5iYjBVZjJlZ2pUQlBIeEE0RmF6K282?=
 =?utf-8?B?UTRNTTlGYm1jRXk2Ly9HOUExMUFwRStHbzdFdDU0YWRNc21CUkY3NGNxbnpZ?=
 =?utf-8?B?M0RleGFYYmRJdEhKeVNWVlRHNEh0TnZzZWtYZmdCMHRWeHNvdHJCQmV4bElD?=
 =?utf-8?B?U3VkaXlRR0EycWhFRjRCTVJRS1JSNlk4WXBCZmRRVDVpUEpPcDNPempPTk9C?=
 =?utf-8?B?WU01aGlORExmcmdiYkFSZVdRL3ZpUUpkb1g0MFFSQUtNK016a3FsaGozTmNu?=
 =?utf-8?B?U1BTWWJoT25FMVZrbFlmSmFLbTZoK0RHVndFeTdsR3RJT2tqTjdNSHdwTmI2?=
 =?utf-8?B?ZDdWNE01dTRqQmlxWTVCaFBFWlVuZWd4MnNMcTYrdy9VWnBMN2oyeDR5WXRX?=
 =?utf-8?B?YXY4aVhxeUQvcHBCUy84NnlKZFIyZ3hIeUx6bEdpNFoyMVUrQjdGNVliVGt2?=
 =?utf-8?B?bnZkc0tvL21PL0hIL29mS0lOaUNKRTYyekwvN0NFVlBHU1pvM3pJOSs1UzQ1?=
 =?utf-8?B?M3FLL1o0QzJzdXZKY3RsS1ZvaExCMVZWUWQ2Y3pDdU11bDFFbHB0NndhRURE?=
 =?utf-8?B?ZlNoWEk2L0lkZGhCeVlSMTlsbHU4VmxTZE83b0t6dlB0bm1keFhtRERuVzJZ?=
 =?utf-8?B?MG1DYWZpbGpqU054c0RROU1TbjZrNmdPZnowQXZZeUdmMGg0T1NEWWdLM3JW?=
 =?utf-8?B?UnBQV0F2L3VlWmdiUko2VnVpc2RPMzBibUFhQmYvV0RudXVqeUd2dXVCY25K?=
 =?utf-8?Q?5UYgiAIY3MrUD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3pDYnZyMzJiSjNBSUdxTUtpTjdYVnBGQUVkandOQUduVkI3T2g5Y1VRL1NE?=
 =?utf-8?B?T1c3RFdKUXFrbWRDa0Zqcnc4RFpXUjJkWEdMM3BobEprU2F1WHp0RFdERGtk?=
 =?utf-8?B?d04zUjMrQ3c1TzBJWDRVdTFYb1lzL3J3dldYc2ZkUExSdHY2MjdTbGdMVStO?=
 =?utf-8?B?aVRxaWE2VHhTOEk3dE1aNVJNcVRCd0ZBZlRWQ0REbGJRTERRVmNRYVA4OXVh?=
 =?utf-8?B?ZmllZjVMZHJCOWxCUUYvYXFmT3ZWNEU5dkR2QlEvV0tqczNtcFN1NWtTSEl1?=
 =?utf-8?B?ZEhXbFVaZ0RMOFNjTGtnTXlIVkd0VnhDcDhkZ3JINVh1a29jekhCRSt2bzRI?=
 =?utf-8?B?TVVRQXkrdEtVYXNhWUQvUzJoRnduZ09NeWMzd05VUVpISUZ3WG1pRFQxVHlI?=
 =?utf-8?B?SjZNREUrZWhxM2QxcjJvVHN2cE0vTEJlbE9pRVZkSzdWWHozcHZORGMyeUMy?=
 =?utf-8?B?Z05EWWhZdCtHc2tDZHdqWURzVXRpTG4veHRoSFdzeDRXS1NRVGVqRWtQVm9o?=
 =?utf-8?B?a0JTaVVHTGV4bnRmUlpzSm5LVytsTDZkcTJtWTJGS015QkJnMjRNRytoeFcz?=
 =?utf-8?B?djFLRVJJOVAydjZ2cDZwL2NMNy85bFdua0tMbWZCR0VlZTNUN2t5Wm16RG5R?=
 =?utf-8?B?L0RNajRtU3BzSFRDbUgyekRyMzh6NEpZUUovTXR1NkdnRm1GZ1BISjUybnRv?=
 =?utf-8?B?dysxT0tIeGhpZVdPZkw2RUdQVS9xb05SZDQwZ0Z0YjdIUlVkVFdXRVdLVUMz?=
 =?utf-8?B?ZVcvTit6WlZENWF4ZjI1dzIzREV4eUc5QkN5UmlqS1JmWTVGQmVjODZoek1W?=
 =?utf-8?B?NzNHRyt2emJUM0pBYlFTc1h4MzZaTUNoU1Vsallvb211dDNWSHZ0VFFmUmMz?=
 =?utf-8?B?bjRHV0dER0pkVkp1VUVCaUd5YXVwa0lUSWVJSG1pZ282NDlUUUdsT2JERGg3?=
 =?utf-8?B?WWZKMS9DNXNCWm5jNVhPdHlJKzFSc2RQeGE1eFM4SlZWdXkyb29CbFZ2amc5?=
 =?utf-8?B?WHFWdEU5OXpKc1ZqT3lTd0RUb2Vjb0NxdDV5V2duTDhNMGJJK0o2UHhLSWY3?=
 =?utf-8?B?U0pIakQ2WFFuejdNRUl3QTgvTVhnMkpQUkZwdklVbjRBQUxtRmZ0aWtXaERE?=
 =?utf-8?B?OFNHZGYwSk9RbUVkazQ1WDdFR2crZ1UrZ0doU3oxSENvMzdmK0pQL1c1Z0Zz?=
 =?utf-8?B?KytmSXFyTmYrZmlDbitWQ1FaNTVremtKalE0b25YejB3S3pJaGhFZ2U1enpC?=
 =?utf-8?B?aWpGSFFMaTB2WEFlWE50a1BjTWJvQzhmMDE1M3hoMXRJZ3ZsTy82MGNDVUE5?=
 =?utf-8?B?Y0c5MGVKbndsZG1lcVZTRzFUWUxOL2RmbTRvV20xdjFvdERnQkRPZGNZOStI?=
 =?utf-8?B?RExjRnBvVFhMTWVhMTVZMktzeWFwblA5VzArSi9XazFnRTlIeFlvOUMvTzg4?=
 =?utf-8?B?cDVWRndXN1lUMDlOSkx3M2RFZEVQblFLQm5oWUV2UjBrY2pnUDlScHExTE9p?=
 =?utf-8?B?ZXNWZEY1cmRDS3VEMHRENmRIa244a1BUZ0kzZHNyc01LemM0NGI3TVB6a1Zl?=
 =?utf-8?B?dExkSFRjV3JReVNUNzVyU1FsV1FoVi94SU81cGg5N1AxR25jdVZuaTBvb3NO?=
 =?utf-8?B?eTFQN1BPK2RwNVlYcVdUd21RME5OMDh1aHFmdUdGUjlWT3NhcGtBejB3Z3d0?=
 =?utf-8?B?SHJkQ012d2lpMTJQZ2YvMWV4Nmhyd2g3ZnZDbWFPeHV6aXpWUEV4QTRxTkdI?=
 =?utf-8?B?NUZydHlHWEZmUzE1dUNJUkZBWC9nclhzcFJ3cVdYSEZYYzZsa3FyK00ybGJ2?=
 =?utf-8?B?TlNuWmlybzdXNnozVktFUEQ4SEZvZm1nL3FQREd4R3VKdzZuY0E3a05oN3JR?=
 =?utf-8?B?U3ozbXpxT2hHNmkvRGdsR3hDYVlHd2czcjhUcXNxWFpqREFrMjUxbHk4MEJs?=
 =?utf-8?B?bG1IREFrUTk1NnBDVkRueVpKd0pEVnNUQmZvR3l6TGI5L1dKMjNLa2ViN3dI?=
 =?utf-8?B?SGlOaC9SRnJzc1pxNmZhd3lYWUhBR2dYdWRtT2pZRW9ReTd3QmtDUDdOWE1T?=
 =?utf-8?B?YzZaYWR4VUZtNlhPeFRVaGZMUkZad1dvbVF1MHkxKzlQQ0FkWnpIK2pKa0pM?=
 =?utf-8?Q?9AlK8FCXIHF8kKagc0qiRZbRM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996741e4-3ba1-4c0b-f62c-08dd3f901499
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 11:37:01.3892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/JgREu6wNRnHrc8KUrKxnmwk1CxL3XEpi1A/AMzpRSMuiRi7zk884OGqODOwG6XPg337YDCYBxle3c34bHk7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201
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

Hi Lijo,


On 1/28/2025 3:04 PM, Lazar, Lijo wrote:
>
> On 1/28/2025 2:39 PM, Sathishkumar S wrote:
>> Add devcoredump helper functions that can be reused for all jpeg versions.
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 59 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  7 +++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> index b6d2eb049f54..70f1e0e88f4b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> @@ -452,3 +452,62 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>>   			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>>   	}
>>   }
>> +
>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block,
>> +			       const struct amdgpu_hwip_reg_entry *reg, u32 reg_count)
>> +{
>> +	struct amdgpu_device *adev = ip_block->adev;
>> +	u32 inst_off, inst_id, is_powered;
>> +	int i, j;
>> +
>> +	if (!adev->jpeg.ip_dump)
>> +		return;
>> +
>> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>> +		if (adev->jpeg.harvest_config & (1 << i))
>> +			continue;
>> +
>> +		inst_id = GET_INST(JPEG, i);
>> +		inst_off = i * reg_count;
>> +		/* check power status from UVD_JPEG_POWER_STATUS */
>> +		adev->jpeg.ip_dump[inst_off] = RREG32(SOC15_REG_ENTRY_OFFSET_INST(reg[0],
>> +										  inst_id));
>> +		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>> +
>> +		if (is_powered)
>> +			for (j = 1; j < reg_count; j++)
>> +				adev->jpeg.ip_dump[inst_off + j] =
>> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(reg[j],
>> +									   inst_id));
>> +	}
>> +}
>> +
>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p,
>> +				const struct amdgpu_hwip_reg_entry *reg, u32 reg_count)
>> +{
>> +	struct amdgpu_device *adev = ip_block->adev;
>> +	u32 inst_off, is_powered;
>> +	int i, j;
>> +
>> +	if (!adev->jpeg.ip_dump)
>> +		return;
>> +
>> +	drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
>> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>> +		if (adev->jpeg.harvest_config & (1 << i)) {
>> +			drm_printf(p, "\nHarvested Instance:JPEG%d Skipping dump\n", i);
>> +			continue;
>> +		}
>> +
>> +		inst_off = i * reg_count;
>> +		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>> +
>> +		if (is_powered) {
>> +			drm_printf(p, "Active Instance:JPEG%d\n", i);
>> +			for (j = 0; j < reg_count; j++)
>> +				drm_printf(p, "%-50s \t 0x%08x\n", reg[j].reg_name,
>> +					   adev->jpeg.ip_dump[inst_off + j]);
>> +		} else
>> +			drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
>> +	}
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>> index eb2096dcf1a6..1d334f35d8a8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>> @@ -92,6 +92,8 @@
>>   		*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;	\
>>   	} while (0)
>>   
>> +struct amdgpu_hwip_reg_entry;
>> +
>>   enum amdgpu_jpeg_caps {
>>   	AMDGPU_JPEG_RRMT_ENABLED,
>>   };
>> @@ -137,6 +139,7 @@ struct amdgpu_jpeg {
>>   	bool	indirect_sram;
>>   	uint32_t supported_reset;
>>   	uint32_t caps;
>> +	u32 *ip_dump;
> It's better to keep this at per jpeg instance level (amdgpu_jpeg_inst).
> If the hang happens for a single jpeg ring, that will help rather than
> dumping out reg settings for all instances.
The devcoredump infra in amdgpu does not propagate the job itself or the 
hung instance, so there is no feasible way of doing this, meaning 
dumping only the affected instance.
And if every instance is represented by an ip_block then I can implement 
this with a flag to handle per instance case, but I doubt it is, as seen 
from the below commit
fba4761ca00f drm/amdgpu: partially revert VCN IP block instancing support

Regards,
Sathish
>
> Thanks,
> Lijo
>
>>   };
>>   
>>   int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
>> @@ -161,5 +164,9 @@ int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>>   void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
>>   int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
>>   void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block,
>> +			       const struct amdgpu_hwip_reg_entry *reg, u32 reg_count);
>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p,
>> +				const struct amdgpu_hwip_reg_entry *reg, u32 reg_count);
>>   
>>   #endif /*__AMDGPU_JPEG_H__*/

