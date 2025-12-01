Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813B1D116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 20:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A6910E48C;
	Mon,  1 Dec 2025 20:31:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KsOwRv6i";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 584A610E48C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 20:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YielNjWTpMpDaGr7aBHWwyUE+6BkcDfzhYfPgKb5tPX0wwNkr4+s+HAd3ReIJsBQg78yz4C6zSst5L3fx/htquqxAxDDCzcmKuscGpatqa1lwBWhMiW+/48U2sWN0x4w6v7qT0CwKORLhlFJPGnX9c4c0Bck4sWpZoslzPDDT0aJ31JJD+mPUdavbSINlUQrRUCQ5rUXC5I1hqxVULha0P/YCFg3X3LPglmFwQBsE9qaC34Ln3jcwDn0vOJNZlxwgAwoO7wjPXfT43pvhS+A0f3BCbD8ec3bZDaaYaIEKArLoZ1a8hUlI4hMaM9hxEq9+uqxptkM4y7R4M4fVZ0zNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FobMGWHLSiueBAVxLIuuJs2U09YKB74WM3vyYpWbsEs=;
 b=PtsdtxsKv69Mcb0OZ4jA5EHtiUnsQmjNYFuo0762OvqZ9aQpCH8KsoWou23dofcLlaryFmMww4N9X4A9ReILI/33yfFjURlMlu/qDaL9/xFWI5gc0fgxfXwLK/ssA8zGrvMLn0DhqnHxR5RQzAAH+c3I99FDv9Jy9nWKXb4niazql/xy/ww7TFn76NgtYPGE4eVZrUAiF8W7QJPmfxgPbiE/4rX46yjtk4TN5VfirSWY+aagUmVzIfiYum0o9uAjE2ExB50u3N0JftFqH2zPnxXOi2pIEEQoFY0KkLlXvhyDZHqVPPwkt2FTB1VI0dMeuUC/WDggxiLYu4C7AeMT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FobMGWHLSiueBAVxLIuuJs2U09YKB74WM3vyYpWbsEs=;
 b=KsOwRv6ilaJVCXmtsBb2N/TZg7viTYnNSc4ffydC8t/eODnmITBvn20+X6j0Q1JvxuMAXJjlNS1vsC2FlDhjKNoauD8rB1zJ6DEiDLQfJli6RCTz849Vpss+nSU/3YQx8NFbwOjIGx4QQKKX3bJJrY5bQ59Yvyu2zeuILlZNgu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 20:31:27 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 20:31:27 +0000
Message-ID: <1256b740-65b5-48ad-ad65-4149d3b880e6@amd.com>
Date: Mon, 1 Dec 2025 15:31:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/amdkfd: Add domain parameter to alloc kernel BO
To: "Russell, Kent" <Kent.Russell@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yat Sin, David" <David.YatSin@amd.com>
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-3-Philip.Yang@amd.com>
 <BL1PR12MB58984080C0F17CDA486C8B8085DBA@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <BL1PR12MB58984080C0F17CDA486C8B8085DBA@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::9) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4d1ae0-3b81-4cde-14b0-08de31189a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHJaTHJqOUNXSnE3eWNPaXY3Vjc2cHVVWlAxOEtacWZnY3RzVmEzS3N3cytG?=
 =?utf-8?B?a3J1TUJpRDMxWGNhRkVaRVp2Zlh1REpUZnZDRy9XQ2syL2FxTWZwZ2lVQVE4?=
 =?utf-8?B?UkVXTy90ZmpRYVFDeWl2UGpxSzQrVDJmUmd2WFYvOVV2Zk9WWEwxamtyOWFE?=
 =?utf-8?B?RFplamVmMUJHcFNKNk9HdXJ2cE1JQTdGL0MrWWlCMVVoSklINjMzUlBNemhP?=
 =?utf-8?B?cisxdWdGUU8xdi83R2lOQ0F0RGNpekl1RkZLMEtXMnBXWDlnR1ova0ZnQXEr?=
 =?utf-8?B?UGYyS3ZRVXRDTUY0anFOQXBsbHRPd0ZTNjdUR2ZDYk56MUZ1TjRsZmZ1Zk9S?=
 =?utf-8?B?UnN0TTN3ZytDSStJZytzbHlsSzZKSHh0OHpraFQ3WEEyN1RDYmZ1ZjA3anMr?=
 =?utf-8?B?dVJLeGx6NjlFWG5sV2JjVVVwaDVvUk5aYlk1cmVQd2JNYzFCVGZxMVB3VnAr?=
 =?utf-8?B?NkxMVTNFQ01CeTZNdWlFb0laM2VxeG1tcXRFc2txSHowcWNDVUZMU3A2VTJs?=
 =?utf-8?B?UUFyOWkrWXNvZHZwTW92S25uTmFqZGo3YzRPdUp2cTZncjllR0lBWFBrTHZ3?=
 =?utf-8?B?TE9VRTlCcmVFN1VlRjZkVDJqL3IwY0ZMTDVHZHh2NVJpcTFJUWxpVS9DSnRZ?=
 =?utf-8?B?NFFrMnhyRGVKSUxKWlBkeHkzWk9mWmFWUFdWWFZucjE4U2h4MmtWczUzUzlr?=
 =?utf-8?B?bmN2aFMyZ0Z2V0RIdUkvNXUzZjVMQmtpWTg4bnB2SzM3Y09ZZ1BkMEd2Um01?=
 =?utf-8?B?Z1cvejhEVE5qZXkwS2ltdzlHNVdHcTA5MEdzZFZFcDRpUjF2UWRDTzhYNFdx?=
 =?utf-8?B?ZkRQZFVzd1RlTUhFcjFTSVhib3dqcUVtb3VuY1BOTktKd0tSZ3JObnBVNGdP?=
 =?utf-8?B?Tjc4Y2xkbU95NWxnV09KUHZpaFZlUzFvVm82QkpxYW50Q2tqeFBuM1M1ZGFU?=
 =?utf-8?B?OWNzQlYwQmk5WFBOc0x5dDB1WWk3K0dwdk1Hbmo5SWpvcDN2Wkd0U1hJZTAv?=
 =?utf-8?B?cjA2STFiclROeDVkRXJ3OUk5Tnh6L1hUcUd2V1V6UVNBRkgySWZVN0VRQzFm?=
 =?utf-8?B?a1Fwajd4WFdUYXlmOU9IcUVvUDF0cjRtQjJFTzhhdXhlQWV1djRmeDFRQXFD?=
 =?utf-8?B?ZmdJQzcwcktPTzBrTVg1clBaVmcxQjNBVjByWjdLQmpTVnBVaHdvZ254VXdQ?=
 =?utf-8?B?NXZNaGJUTWpoVDRNb2xEaDdIenVHWlMyaVJFeVI2YWdub2NoaHB1eThObHN1?=
 =?utf-8?B?RGV5WmpvdkR0Y2ppOHN0ZFBEYUlXYnJTdlNqWW9RaFpORWh6d05GaWpBQmh5?=
 =?utf-8?B?T1pwTWcyNHdtVUFDblQ2YnFJSGtzNzFXbHJNVGlkQnc5YmhTQy9WVmZDbnQ0?=
 =?utf-8?B?WFplMzYvWnFFUVIvM0NxYmhBNWltdUI4ZHdMcWQvMnpXWXRmQUhGV2FjcmJ4?=
 =?utf-8?B?a045T3lLbkY2NGhhTmdDNDl3VFZRTW5sbTNjTlJqampOcTlxSVBPVG9zMmlC?=
 =?utf-8?B?RkQ1NmxZMGp3a210ek1NVEVCdUFjTTBpUlNKM0RxeEU1Z2E2em4yTm15dUlk?=
 =?utf-8?B?T1ZaNzdZVG52eFNsUDJMK1hyM0tlU3BEc05GZ1R6MEk4SGtObzZCaGw3aTBS?=
 =?utf-8?B?QkE3bndRdXduNlVCbStlWG8vUFY4ZFRyN08yYXBYSCsrSWc0TzE1d2V6ZFhF?=
 =?utf-8?B?dHBaN3Q5VzB1WUt1ajdsWkFYNDVRVFlxSFVsWnJBdkZpRkd6Q0JGa1FwM1R6?=
 =?utf-8?B?eUNIcjg2eTRFdExWWDB2NjA2dkttb0xKVUN1ejNFZ0dEQWJqenV5dzFBVDZt?=
 =?utf-8?B?OWhyQ2JNZnI4bjAzWm1aYjhaeDA1MDRaZGVhZXZ6cTlNMytMTmxwbWlxTk5a?=
 =?utf-8?B?QlVva2I3dlBsbDV4b0ZINmEvUGgrbFRwS250MTlBSTNFSkJiWEpzTWl3alRi?=
 =?utf-8?Q?OcF9bDw26NTnct+muyMBuEx5R3JhgD+5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V24vS09RRUd2S2V6MG40ZUUwZFRsQ1d2MkZVenpqSCtzRnFLMUZqMHZHbWYr?=
 =?utf-8?B?U2l0aUU3aTF1OE93Sy9iMmZQMW5IMFp5MThjSmlzcnFQa3ZEcFhsbjdwcHZ4?=
 =?utf-8?B?STFidHZxd1ZVNFVzNnREQWdxMU5zb2g5WG96OWpsTkQ0UEcrNDVqZXhXU2lm?=
 =?utf-8?B?OHlCcTFtR2xOb2JBS3dlR1RTVWgyNzlUS0hpV2RwRk40dnI3Zmt6eTRTWU5T?=
 =?utf-8?B?YVFPUXJVSjJKUStjbTdIUDFBRk1saTlYbERsSHhBVk1ScTR0S29mYW16SzZT?=
 =?utf-8?B?UW92eUQ3azJqS2tQSjRWZU81WkFHM2tFc0pPWkhuN2VvbndtVldlaDdZRFRN?=
 =?utf-8?B?U1Rrby80R1JuWmovS0MrZWF5QkNyRC9uZFRkbllmRHhVeTRQUWdCTkRDc2gw?=
 =?utf-8?B?MHA1dzN3ZklOZis1bDYxOVJ1QXFYcWhscHI1c1FJNlB5UkljNXFsS2hvck9X?=
 =?utf-8?B?cUdYTERiWE9lUlZ3a05HUXlKTmtCVmQ4RnBQOHR5Z08rSlZ6a3BZMXJUWllN?=
 =?utf-8?B?ME4wRm93eWlnWkhreEpFbENFdHJZT2RHU3ljWEE2blByY01qQUJQbEo5MmdG?=
 =?utf-8?B?cnVlempuQk5ZaDVmcGJzdTk5Ymo2ZkVpMDNKRUVKbHBtbjJvSU5rajZVUXhG?=
 =?utf-8?B?U0tFb2dvU2ZZUEQ5di95aVZGejNUdzgvakN3WEpVWlFyOUFXbk9FSFhsZlI4?=
 =?utf-8?B?NGdtT09pcDROeEN6a2JMUmRoV28rdklLYkRGcnM2MFR5UkJxaHZzQUwxb3oy?=
 =?utf-8?B?MGUyVlpjdjVJenRQL2p2Ukppak43aStQYnA5b2xYa2t0RGNFWE9YQlB0QTlV?=
 =?utf-8?B?Z0NZWUUxL0RGeXJDRDF6S3RyejlzR3dDQUtncmQxeGltd0l6L1g1UnRpUWl5?=
 =?utf-8?B?RjBmOExFUDVnTktNdUNmNWlFcDYvOGFBTFRrZ296bWRXQ2hTTHdMR1BnNElK?=
 =?utf-8?B?d1hqRWZQaTRzemIxMkZrQzNvWHYxaC9PR1ZNSlI3d09wQWZQRDB3dS9NR2M5?=
 =?utf-8?B?V1RST2VKNHJtaE9xaWJNOUhpUjBCSVMxN05EWXl0V3VsNXZERVVBTG9zSjRq?=
 =?utf-8?B?aG4xKzVNU3EvQjBaYUJnSWk4MStnbzhCUjY3WE5UWEx1TlFhZFZiSWU0RnBQ?=
 =?utf-8?B?R0V5VlFWK2QzNXhHdzNFME5IWUlUY0Vna3Jnd0krSllKQ2laa0dTb0tYY3A2?=
 =?utf-8?B?Z1RSYk1PZTFPRVE3Vkh0c3ZCcFJ3WHNCbmFJb3dVaGhrd0hLVG5BeFBIbGhP?=
 =?utf-8?B?NU04OE9DeE9pd3YyV3kwZ3NtK3UzRWtZZkZ5ZGFNcS9qQkIxV2RxenJ6RGtF?=
 =?utf-8?B?YWlUaGZNaXI3OXp6dmpSb29CaTZQa0pxL2g0dDhTMlJNS1FVaWtydGVmVkht?=
 =?utf-8?B?bzVWWnEwUmZhRXVIK2lSNWhxZWplcnNLOStRQ2ZNZlBuWHBiSGdEWjJPTGg0?=
 =?utf-8?B?bjF4UTRYKytyWGJhMkNlMkh6YytnT0Nwck04c256dkVDSGtMS3ZTdnF3VEVU?=
 =?utf-8?B?UDhQR3VMaVRaMEUyTS94cm90cEVWajdVb1J0V0tLdDBCT1BPYUFuOTc4ejR1?=
 =?utf-8?B?WTNrZWUzSHZxUnBjaEZqalZXbkVvM3doUFdvRHJEVHgzUFFzVCtyZmYwNUtl?=
 =?utf-8?B?QkRTV25oVmk2ZVN5K0d5NWZhZGNIcGptV2NNNFJyUEtoc2FPWk1lZ050M2Jr?=
 =?utf-8?B?SWFnbVVLUWJDOG1LNGR5VXIyamQwUlo2UGFvT1FPZ2VGOG43NzdqSEJWemNs?=
 =?utf-8?B?UDl2d203dUZ5NHowWGl3OUVhc3lZQTVDR2ZLa0pYN0xRYlQyK3ZqbFhReWNT?=
 =?utf-8?B?WGdyYVpYTGVvSEhkVktkTmlNMlVmUHpxUW9YV3RpVTFjNlhHK3o4TTRwM1BP?=
 =?utf-8?B?QWsvNXFWeU1qdzNYSW5IbzJrRFVCKzl0Z2dYbmxEbFZjcngzQ1lHTm04K3Fh?=
 =?utf-8?B?bVYzY2E4S2RPYkx5akwyYVRlY1gxTyttVEhOWTFNZWdDbWVueG0rcktiK3pj?=
 =?utf-8?B?clZ1SFhpdEtnQTdYbmVxL0pBVVllak5SelZIRE45R21rQUh0UjVkMU5qbytk?=
 =?utf-8?B?MU9HOWI4Z2N6cnFhWFRPbCtDRkk0bmFLemp1ZlNrdXdaQXVabjRkNys5MFh2?=
 =?utf-8?Q?0iLw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4d1ae0-3b81-4cde-14b0-08de31189a8f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 20:31:27.6738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nf/id2t07Aw7DgFQM7aEutgDCdIC1KjbcUUgE8Giy4QozZLFWIrbe78E8U0q2D7U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
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



On 2025-12-01 12:38, Russell, Kent wrote:
> [Public]
>
> I know that it makes the change more complicated, but should we be renaming the function since we're no longer guaranteeing a GTT memory allocation in the alloc_gtt_mem function?
yes, you are right, I have the patch to 
s/alloc_gtt_mem/alloc_kernel_mem/g, s/free_gtt_mem/free_kernel_mem/g, 
and found it is too much changes, not related to the purpose of this 
patch series, so I dropped that patch. We can cleanup this in the 
followup patch, probably remove the alloc/free_gtt_mem functions and use 
amdgpu_bo_create_kernel instead.

Regards,
Philip
>
>   Kent
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Philip Yang
>> Sent: Monday, December 1, 2025 9:29 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Yang,
>> Philip <Philip.Yang@amd.com>
>> Subject: [PATCH v2 2/4] drm/amdkfd: Add domain parameter to alloc kernel BO
>>
>> To allocate kernel BO from VRAM domain for MQD in the following patch.
>> No functional change because kernel BO allocate are all from GTT domain so far.
>>
>> amdgpu_amdkfd_alloc_gtt_mem has many duplicate code as
>> function amdgpu_bo_create_kernel, with one extra flag MQD_GFX9
>> to bind MQD and control stack in GART with different mtype,
>> the duplicate code could be removed in future.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c             | 6 +++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h             | 2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c                 | 1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c                | 3 ++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 ++
>>   7 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index a2879d2b7c8e..9cd1660b8f60 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -317,7 +317,7 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device
>> *adev)
>>   }
>>
>>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
>> -                             void **mem_obj, uint64_t *gpu_addr,
>> +                             u32 domain, void **mem_obj, uint64_t *gpu_addr,
>>                                void **cpu_ptr, bool cp_mqd_gfx9)
>>   {
>>        struct amdgpu_bo *bo = NULL;
>> @@ -328,7 +328,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device
>> *adev, size_t size,
>>        memset(&bp, 0, sizeof(bp));
>>        bp.size = size;
>>        bp.byte_align = PAGE_SIZE;
>> -     bp.domain = AMDGPU_GEM_DOMAIN_GTT;
>> +     bp.domain = domain;
>>        bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>        bp.type = ttm_bo_type_kernel;
>>        bp.resv = NULL;
>> @@ -351,7 +351,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device
>> *adev, size_t size,
>>                goto allocate_mem_reserve_bo_failed;
>>        }
>>
>> -     r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
>> +     r = amdgpu_bo_pin(bo, domain);
>>        if (r) {
>>                dev_err(adev->dev, "(%d) failed to pin bo for amdkfd\n", r);
>>                goto allocate_mem_pin_bo_failed;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 335d733751cb..14b5ab6fa051 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -237,7 +237,7 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct
>> amdgpu_bo *bo,
>>   #endif
>>   /* Shared API */
>>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
>> -                             void **mem_obj, uint64_t *gpu_addr,
>> +                             u32 domain, void **mem_obj, uint64_t *gpu_addr,
>>                                void **cpu_ptr, bool mqd_gfx9);
>>   void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
>>   int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> index ba9a09b6589a..494a563e072e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> @@ -359,6 +359,7 @@ int kfd_dbg_set_mes_debug_mode(struct
>> kfd_process_device *pdd, bool sq_trap_en)
>>        if (!pdd->proc_ctx_cpu_ptr) {
>>                r = amdgpu_amdkfd_alloc_gtt_mem(adev,
>>                        AMDGPU_MES_PROC_CTX_SIZE,
>> +                     AMDGPU_GEM_DOMAIN_GTT,
>>                        &pdd->proc_ctx_bo,
>>                        &pdd->proc_ctx_gpu_addr,
>>                        &pdd->proc_ctx_cpu_ptr,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 9f183d27a0ef..b0cfad750919 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -787,7 +787,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>        size += 512 * 1024;
>>
>>        if (amdgpu_amdkfd_alloc_gtt_mem(
>> -                     kfd->adev, size, &kfd->gtt_mem,
>> +                     kfd->adev, size, AMDGPU_GEM_DOMAIN_GTT,
>> +                     &kfd->gtt_mem,
>>                        &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
>>                        false)) {
>>                dev_err(kfd_device, "Could not allocate %d bytes\n", size);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 36ac35d64126..028fca1d2755 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -2906,6 +2906,7 @@ static int allocate_hiq_sdma_mqd(struct
>> device_queue_manager *dqm)
>>                NUM_XCC(dqm->dev->xcc_mask));
>>
>>        retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
>> +             AMDGPU_GEM_DOMAIN_GTT,
>>                &(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
>>                (void *)&(mem_obj->cpu_ptr), false);
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index 2e9b6bcf2704..a489d43d5f64 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -139,6 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node
>> *node,
>>                        (ALIGN(q->ctl_stack_size, PAGE_SIZE) +
>>                        ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
>>                        NUM_XCC(node->xcc_mask),
>> +                     AMDGPU_GEM_DOMAIN_GTT,
>>                        &(mqd_mem_obj->gtt_mem),
>>                        &(mqd_mem_obj->gpu_addr),
>>                        (void *)&(mqd_mem_obj->cpu_ptr), true);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index 5f8cda4733f9..e0c5ec7e2fe9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -266,6 +266,7 @@ static int init_user_queue(struct process_queue_manager
>> *pqm,
>>        if (dev->kfd->shared_resources.enable_mes) {
>>                retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
>>                                                AMDGPU_MES_GANG_CTX_SIZE,
>> +                                             AMDGPU_GEM_DOMAIN_GTT,
>>                                                &(*q)->gang_ctx_bo,
>>                                                &(*q)->gang_ctx_gpu_addr,
>>                                                &(*q)->gang_ctx_cpu_ptr,
>> @@ -369,6 +370,7 @@ int pqm_create_queue(struct process_queue_manager
>> *pqm,
>>        if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_mes) {
>>                retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
>>                                                     AMDGPU_MES_PROC_CTX_SIZE,
>> +                                                  AMDGPU_GEM_DOMAIN_GTT,
>>                                                     &pdd->proc_ctx_bo,
>>                                                     &pdd->proc_ctx_gpu_addr,
>>                                                     &pdd->proc_ctx_cpu_ptr,
>> --
>> 2.50.1

