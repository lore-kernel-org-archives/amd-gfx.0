Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62E1CEACFF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 20:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598E910E112;
	Tue,  1 Oct 2024 20:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s28NruXJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FD110E112
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 20:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcQe/Ab4ytMn76SfBOeZdLaDDz2NvOxt5iNgOVM1BrjwWvBopFKVc8sPS6PPo5E9a+3km0jVitXahnP8YGxPIPBbjzWtA76ouRoMwpDnBmQuQqkApKFLaI2UvLOYHGtJLiCcDlPGEKf0kCd6+xFHcn84IYsvP5SQh0j1rnT7iPgSgWKRntwOa9q6Gw/SXZiWacLI/3Prg4P8Zt2Lq/FxeHXSBQDnXWy7OXBk4TXTOUaRGt3MUR2qjKmxcf99GwNMdRD+flCyO3JtJ+XMCRR44jnEAxyl88Jf+dNmpXIAIaD5vwnlUfjC6Eir8IUSfGUa333xNBVIDAdurHkqgML/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TXMXnHZts5f+ooVUqy5SY9o5BeG/OzHqmpVFCCbj5U=;
 b=vUikHN+MN8H/H759mWLTkySfUN4mdaZaP5g10tzUuMYynreUw9qELwtrkcGL4NUy7RuXPPnCRmBMsJNtezuhFquS8/9HOyVuVNRuXT8RMDMJz/c/5fFn2HrcWatcmfoN/wt9MepBo7RBpsxj51hfaQjT+ZGQoSwEMzhIJ8dOxYqgdTmXiJX7dJ9uHph5s6RNn2tYKWnt56GkX7iIjd/adZc+Iao7bfLTJmOcz2ukSRiB5LZ0lMv4plOjoD1L5niKZ5VpKSJq3kGUdbOjGXfrCApBNyAbKR1mVfZXFuZjjmy0h/OC6ug6FrTfz9B0HBJD9WueraSSF3kTujqDoes6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TXMXnHZts5f+ooVUqy5SY9o5BeG/OzHqmpVFCCbj5U=;
 b=s28NruXJJQ6f6PhSSqKhZLvkNvThl+gilEVPlGiYGvPA3UJLS/dvbvqJS9KKsUw+mFgSsXe0/UcAzQRunFl9hWwb6mAcBTMPCqefJ3G6hiDxuYVvwBNdXLnaoPOYQd6ijiAeUJj+c+qcXj9VIPjWfgrnoEkTv3ia5BfxJOJQT90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.26; Tue, 1 Oct 2024 20:07:10 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 20:07:09 +0000
Message-ID: <bcc97e4e-ffe0-47a7-bd29-c993e5404a33@amd.com>
Date: Tue, 1 Oct 2024 16:07:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] 58a261bfc967: choppy GPU performance
To: Mario Limonciello <mario.limonciello@amd.com>,
 John Rowley <lkml@johnrowley.me>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 regressions@lists.linux.dev
References: <9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me>
 <925cd47c-8f1e-4b74-aeff-6d13ae5f0753@johnrowley.me>
 <95c575a3-100c-4808-b451-b92f14598188@amd.com>
 <836c2c82-4dfe-40f4-8d50-5e7bff04c38c@johnrowley.me>
 <7ed81635-3872-463c-94e5-e4972da9d014@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <7ed81635-3872-463c-94e5-e4972da9d014@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::8) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 344182ef-977d-453b-1283-08dce254a191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2NJLzM1RUNuU0VsbFVqU3B3UGN6WDVsYmhqaTNVc3cxS1hFSmI5MWF6QzQz?=
 =?utf-8?B?ZEdDYkMyTVo5MWl5SCtRbDFhbjN3NVBHNldSbnNQT2dIYk0xcFRwUkcrakZ6?=
 =?utf-8?B?ekgveXhRYVpOUFRGZjFscTkvWDdOL25iYXhzeUdHUEZaWEZTci84MTdBdi9S?=
 =?utf-8?B?THZyMzNUcEN0OXZQMTZJVTJJMEVaVDBzZFVDNXdtVE5JdHRVeWUzMW9DMUsx?=
 =?utf-8?B?cEdLYkxPNTlsQTkyOXpDYTBmazBvYUsvcG1pZW1rd1liNEk2SXlXdzQ0dHZK?=
 =?utf-8?B?MmxKNXZ2aTlnSnZocEszWnVYU285M3BJUmUwS3JSVkZGaHRzc0V6amxjOFFk?=
 =?utf-8?B?dVJWNUtMbW5BYjJWdThKNks3RmdXczhCK05vMkRJSXFCQmFnMExGay9kZmJh?=
 =?utf-8?B?aXVGMWVwck9CTVpEWjlQbGs2Q2xUQldSUC9wMkpndDEybHJ6aEN5bWhCaEtH?=
 =?utf-8?B?Z3ZieVpmSjJqeEhXZVluYTNud2c2WmYxSWFGRXlaRytxSm1sWUZZd3RMVGVz?=
 =?utf-8?B?ampWeDdXNWZoREtWVXJ5QWJZSklQWmtJYTNNdUtRTThKTjJsdStYOGowWlRh?=
 =?utf-8?B?SWVBZUY1T3JRdFdmcUhGSHErU2tCaHRYcndyV0lUT1FOajBkVkdlNkdpM0k2?=
 =?utf-8?B?M1ZQU2pRdkVVUkcvMUxxVXIyRUlORlp2Y0NWWE84bUNjYU1yaUJyQ1Y4WE1P?=
 =?utf-8?B?L00zd3l4bXNIYUNXMmFBcGZJcWNuL1BhRlVZbnMyY3JLMVZ6NFZmUDN4dDZw?=
 =?utf-8?B?d0l2WWNuMmplY0FVZUQwaXYramh1R1pyOFJQRzBZMzRmV3Z2TDFFZFMzSHgv?=
 =?utf-8?B?MXQ4OUppOHI3aEUzZTNSOEcyenNJLzZQclVheGF6MEUyaXQrN0xHUkV3V2Z5?=
 =?utf-8?B?c05BdEY2dkZoQk50Mmw2SjYrbjhaOGJkVE45UGVqc2gya3kwOXJXcGRqN1Nx?=
 =?utf-8?B?UTFYc0F1S25FMG82cUNhbjl6ZnoxTm53SGQ2cy96TzNtUWVqZmk0YjMxaHcy?=
 =?utf-8?B?cldYTzQ4KzQwWjF5cElwUStCc005eTA2aFh0VHhDY3piWUxIcmh1azBYcUNv?=
 =?utf-8?B?V0FIUXR5Rko5aEFuelZCazNxTDdrTHhxcEcxL2pHVFNkWWNDbVRYb0pnUTNB?=
 =?utf-8?B?TTRXN29TakFkTXF1RGhHUmlCZlBBWk9oQm90WnNsTjVqb2hRNXRiTVQ2dy9q?=
 =?utf-8?B?UnpHTTBZeU9LQW8rRnR3cFl2MmZTL051S3VXckRESE40aWptUnZRK1pIVDBX?=
 =?utf-8?B?anhacHNTL1Z4TWpOMVkwOHpxeEFhRTVTbmNpcmhsVzdEZlpJZG5MQ0ZvMFFZ?=
 =?utf-8?B?OFUweVZMWWJCTEZTMFRNM2ZoMVpuVUhadVZWeE5WNVNnWWR2MjBWdnFLYXVm?=
 =?utf-8?B?OTRVUzkrdG4yVGJGaUpPd3pYdHBPNXNRTXcxbjZvSGNRN3VYQXAxdktld3d0?=
 =?utf-8?B?UklHZWh0UEZzcC9jRzRveHI1SVhtUkJJdFg4VUF3by8rUmQ4d0Fkby8raG52?=
 =?utf-8?B?OUJyWExIbGpXV1Y0N0ZibGxIcy9oWnlMVjdWTlA2SnJOcllISks1VkpaRFVl?=
 =?utf-8?B?R3NaZDBMc1d6dnNzZzl1YzkyeW5xeDFzUzRFcS9HaG5WRm9RVmdSUGdVaStl?=
 =?utf-8?B?OVlkOTNwVnMzTElsSjF5aCtLUUQ2WUl1Qm5ubUlZQzZHWDdjYnVlelp4bncx?=
 =?utf-8?B?YlRCVW9jZDNCT2graElYMGJna01STS82K3JEYmJlT3hqczJ2L3pabTkvK2hs?=
 =?utf-8?B?SFhZZDZXTE12MHhERjU3SE1ueGpONkhjcnRVOUxicFc2SjcyLzFUQk4rdFV2?=
 =?utf-8?B?K2hKNUdzZ3grM1Qzay8rdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzhoTXVLMTV2UGdqM2RIb29XejBaN25FSVhLQXZwdEt4emw0L2pOMmpkTklJ?=
 =?utf-8?B?bk8yMUc3V3RaU25RM2x5LzBzZWxLRklBUVpwSEVFU1gvTUluY2IvWUltcWNu?=
 =?utf-8?B?a1liTDFZVzJCc3NnY01jOFpqeVFBaGJUM3I0UHZhR0lnaUpHTlEvbVdiVFRG?=
 =?utf-8?B?R05hbHhGdlZIcUxJMG9ueUdyRWNWbXRxeGFyZE02Z2w0Y09rd2doUUk5K0kv?=
 =?utf-8?B?M2tqRFNsUFNVc0g5STl5MElTcmpGZ1ZSNGdpSUJ5a1ZKaE9Qa2lhdjcxOEoz?=
 =?utf-8?B?VnhScS9VOFVVUkpQTWpzcXVkK0hXSWNFcGxROWlMcTZBUXFpYmRFMmZwMnlo?=
 =?utf-8?B?K1ZxVUg2Ymhxemh5c2ozL1ZkWUhvTUpxeWVtZUdhRnJzR1FaV2dybWdKYnJG?=
 =?utf-8?B?Zk9iaDFHV0d2UkVvWjlxYklmSDlMaFYrSUxoRXNPYnI5Kzd3UnpjT0FKYjds?=
 =?utf-8?B?bER3UFBNNWVQZHBUcUpCdVZkU085MHpYRWpKZTJLcS9uczNWNW40VE9Zdjkx?=
 =?utf-8?B?NVQyOXRkb1JHelc4S0RjSytaQWdYQTdLelBwU1NmQ3BGSVBUaGxjT2l0cTNz?=
 =?utf-8?B?dmFLbnRqU295RERtOEdPeWZXbStCMTU4cEg0bGhPWmdza1B0RmVleVJ6VWU3?=
 =?utf-8?B?ZzYzWC9PcEI5VkQ2Ni9QNFpYdVl4S0Ewd0hXd2NQUmVXVnlkcUJUbjg4Y1pk?=
 =?utf-8?B?SFJrOFcyTlYvdkxUS2tadVRhNmlHNTFQM0lSMWd4YVBYRWRjV1RMTzZ2MklP?=
 =?utf-8?B?b2tBRUR5bW1aV3hsUGVJNXdiOVBHOVFXbXFFa2d6aWR3cVdNVjg3S3Iwa2Vn?=
 =?utf-8?B?SmVuM25DR0p2bkRlWDVCL09jYU5rRjdQMTRNTzFEZGRSaFg1NzF4UmVscG4r?=
 =?utf-8?B?TmZUb2xJTWFUenA5aGdCZTRKZHFqY3p2VnFoTWwyMU00WlJFOVBNdnMyZzdC?=
 =?utf-8?B?czNwakhzR2V4NkpTK0M2cUtyb1hsVHpta1lNbndGcndqYytBdEs1ejZza2xj?=
 =?utf-8?B?UE1pQkh5NWUyTFF5RDIzRXZRMjNGK2dDVFpIQUNudXMxdW03ZndvY0NNb2k2?=
 =?utf-8?B?ZUNxV04xM25ic0E0KzdkYmNPMExXMXFGd3hBMHp5M3RCeG56N05LMVVKV3hs?=
 =?utf-8?B?UUViNDZ3cFMxU1JoaHRHTEpwSlRRTlI2K05iOTVIZUc2U21lOUVvN3dXVjNy?=
 =?utf-8?B?QTdVSkhNZGt0OEFrZ0ZuR01ORjhUMGdrSmhNVjFiRTJ3c282eDNCRGZRbTN5?=
 =?utf-8?B?TFJYejJVcDVHTlJIVXJUVisyR2hYTHFwWm1WVHNBUjF0YjNsOUtZUmJHNTNv?=
 =?utf-8?B?dHhyd3lNQU1oekFNSU8renkwQVdVUXpaZWFaWUp6Um95b2YyZGZCSGp4c0Nt?=
 =?utf-8?B?bE51dExpWVZLQ0lxNWVzS3lzRHhmNUFQM21LL2MvYWFhb2l6cUVmdzFRQ0h3?=
 =?utf-8?B?U1luZ0NXbTY5NkVtZUtHeEhvekZvdGtLbk9yRzFVMmxQWXhWM1B3cXEvdVUx?=
 =?utf-8?B?Sms2SUdmVDcwVEVSTEZlc1E5N1NlRGdDdTBFWUtnM2phd3h2R3ZLN1VhNE01?=
 =?utf-8?B?MXhTR250eWZqTTEzTjl6Qk5XbVpVQ1FmekkzaXRjaGkzbEZjUnIvdnNLRk91?=
 =?utf-8?B?MmVXaVlYZk9ZUE9jZjdjNUlrNHJuTVRsUHNSazJQWVU2dHp0K09pUFl3T1lW?=
 =?utf-8?B?M01XelJHRVRmNnVrMGliZWtTZllZNmNHd2dWeGg5cW1yQkNxTjB1TFpjVjNT?=
 =?utf-8?B?bHpESlpTMVZDQXpCMmdUU0oyRUZ1eEQ2TGo1bVZPNFdTSG9ReWh1Q1RZNXdR?=
 =?utf-8?B?T05yQVVoa2FRSmthMUhHZXgwRk5zU0FDSCtTN0ZVb3pIV044ekUvRXk2bXBs?=
 =?utf-8?B?RVczUVFTNy94UHdycS9ZeXNVL3ZwVU5rMTI2T0xXeTJNdlovQURQUGt2blY1?=
 =?utf-8?B?MWY1b1NDeWJqem9TSHorVEFCeTRtRSttZnF1T08vMkdqYmxPYnAxRmd5VnlN?=
 =?utf-8?B?eXlHSnRIUE52L1lzN1BrSi9WQXZEb0VDcDkxdWZWWkh5RkhrbFg5SXRHaFRu?=
 =?utf-8?B?QUdnNjV5TG1rTmJPbjhkMStVWnNBUWd3cHJtTXBTSkk4UXFQdnkvYUFtT1BP?=
 =?utf-8?Q?kM20p3DgOdYNl5KTvQf+cXocX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344182ef-977d-453b-1283-08dce254a191
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:07:09.7238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zss6hO2iq8F721Pc1uMzFIxyGdVL1HVy0LSQEU1sH0tfNLHOL4i3H/Zt2jAVHARp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122
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




On 2024-10-01 15:10, Mario Limonciello wrote:
> On 10/1/2024 14:09, John Rowley wrote:
>> I was using power-profiles-daemon version 0.23 in balanced mode.
>>
>> I also tested TLP, and vanilla kernel without any power daemons running. 
>> Without any daemons I use the following:
>>
>>      energy_performance_preference: balance_power
>>
>>      scaling_driver: amd-pstate-epp
>>
>>      scaling_governor: powersave
>>
> 
> Thanks as long as it can reproduce in 'balanced' mode that should exclude PPD 
> from being the cause and it most likely a pure kernel bug.
>  

I'm curious if you have a PSR supported panel. Does setting
amdgpu.dcdebugmask=0x10 on your kernel cmdline help? This force disables PSR.

Another flag to try is amdgpu.dcdebugmask=0x800, which allows PSR but disables
idle power optimizations. I wonder if that may be causing extra latency.

- Leo
