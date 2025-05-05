Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDACC3ABB0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 16:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12FEC10E104;
	Mon,  5 May 2025 16:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iznrB2Ao";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA59B10E104
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 16:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qp9ezuCzpFtlZeahXv/KApPw+RpGMNxz9qrObbLrJ2A+cLadu2DGc3aEIUz6nUdo/2n7nqbA03Qrsa+t/wi6MKZfgGPiVbv+Y9r3/zUUIrbAeySOGNvxPY5zNiOEz5ytVONlku8eZ06auEYAdYC734xcCKkOQCh82YsDfXvvHGLM3/Hzt3CM/qrzZmURicfR7ziOAIF5KsXAuTic8yJ6bBQ2QifRp+lhdZP72HMcxpPfei6nEz5u3Jzn1B62+UINJdlntwx0L0NbU7g1qzQGetNJWDdIOTX4eGkbi/qefl0pHxIQeHB/R24GrcCQDEGGJW0HrS+dwCd1JrkSzyaTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YgtIh8gC5e1rJ3aDEuS62KpYxoaV2C7d+MVxy1zKN4=;
 b=HuKKdPccic6SZzjHaLDru6d3T+Wa4GXK9Aa3oXSGo3EeYJIczsLQWFE0I5MhqxiQgmnxoNNW4K8UTMkjDDZ8SSuq5FLONbTPGP7lS8t7Q3pmBU2qvvpBBxEFaGI1Gm2oS34BiRbajbxIsAQX5fauJlmQWteESOzdbQX9xDgpgEyftKpsYmSbgdYwPRx9aWzsao9aFUrCrMQwlUP01ZLjU1YC1sXx80iMrhnHagOs99JUL/ZM1W3Koo47R7FfRL1jL24DZbBp4HTn+NszL0nsUnb+ul086UApdYghMJDuJGoFhdtGEuETg0Gu5Q97+N7J9qPXqtu1/VJRXmTBMjQQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YgtIh8gC5e1rJ3aDEuS62KpYxoaV2C7d+MVxy1zKN4=;
 b=iznrB2AoMb72Se3RWKX1qgAaCk4b01uKMhJGs4o2lTatJ8VgJOEA5e/RbPcsdJ3S2UoVGBieOZPD17QxtOxF2J/lzpL+lictJDTcJprrvmnCVKpWB2rMhw+V2PVFiO6cgrgJs1fkZimbW/yHbXhikSkTMNDKhsHde1ucXvPQ4Yw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CY3PR12MB9678.namprd12.prod.outlook.com (2603:10b6:930:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Mon, 5 May
 2025 16:27:34 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%5]) with mapi id 15.20.8699.024; Mon, 5 May 2025
 16:27:34 +0000
Message-ID: <41016b22-d09d-4cdb-abca-a2ab016e47ed@amd.com>
Date: Mon, 5 May 2025 10:27:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amd/display: Use optc31_disable_crtc for DCN 31
 and 401
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250504221154.409695-1-siqueira@igalia.com>
 <20250504221154.409695-3-siqueira@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250504221154.409695-3-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::28) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: cb889e7a-45c8-43e5-46f5-08dd8bf1bdbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWJBbDVYMWc2ekgxSTBnb0orWDNyMk93Z3ZXWENrelVNaU9HMWtBRE1RNTB4?=
 =?utf-8?B?VE52UmlBdFNnd25aTlVCVWVzL01sejhubko4ZHBCekNDQnNZVmVya0FmWldC?=
 =?utf-8?B?WG5XcVdJVGRaSy96WCszcVZtVVZZVzkzbURUZWs5UnhVWHlIU3ltclpvbEFC?=
 =?utf-8?B?ODJ1K0RPYzFRcG5FaHpucFI3M3crWGtuVnVVaTJ3bmhQbDdnK2JCV2JXZDc2?=
 =?utf-8?B?dFhzZzVZSGRuNnk0SlFjM0E4alorbmNqQmtSQ1NBbmJMSCtDN1UzQXZTMGJo?=
 =?utf-8?B?TWRFdy9XbHZFS2RleHFRV3N3T2dna3ZMa0pBb2lOaEdLZGY3T3JocUFyUjN4?=
 =?utf-8?B?MTMvQWxsQnlHMVR3MlBiSXdvRDJQVGlrcWs2Q081Qy9wbitoRC9ZWHh2cSs1?=
 =?utf-8?B?cy95Q2h0WXZuM3lBMHB6emh4QXJUV1lnOFdsL1FqbkxuL2pya2tFamdIdm1m?=
 =?utf-8?B?aGNVTk9iTXB0QkxmbnZuU1NtUGZiTjNGdzhXaFFYSTVLSkpjVmRicm1DYkR3?=
 =?utf-8?B?bkRmVkx3U0pVaGdVSmxqMkFvUGhGTmZyZEpCNzUzN0o5UzdmaUJ6SmRGbnZ3?=
 =?utf-8?B?YVVYWkpUNVNFYjN0WitHRlVWRDhSNUc5N0NsUmlXZE5kVng2SXRpaC9vMlJ5?=
 =?utf-8?B?T1RtTGJtb3kwcitsK1ArSnUxMW1IYjlCL1RicnptWEFSRXkxMHpyeDFSb1Fl?=
 =?utf-8?B?Nko3c2MvajRjZGVyRllHQmR2RW5EbmVNemZHV0p2VkdQU2RCY25ta3pPUDJO?=
 =?utf-8?B?WWdwUmZ4SWZXL3RnNzAvS1psZFBvK3hVK08rK3R4TitiazhZSWFMdjEvV0Vo?=
 =?utf-8?B?N21qYnJKbytZRFlRaVdZWGJxY3hDaUZod21HZDhDclV6RUlPRWpBVCtybkN6?=
 =?utf-8?B?VHhwY0JjTVZsbVJmdHhYd3hleDF2YUhEK2V2UnhwTmw0ekQwZS9kckJ6YnRI?=
 =?utf-8?B?Q1dFWTlpVmx1Skc0SVJ0eTlhUnJ2dWF6NUMrM1BOaDBaNWt3WXpoTmJodldx?=
 =?utf-8?B?ZzBvayt2dG50VmNra05vVzljZE9PUFBvZ3ZDN0dGRVlid2daTHB6QTJ3Mk5v?=
 =?utf-8?B?Q2lFLzN1dTJ3dkpWOWZCVkJDdUlEcE1Zem9PRU9KZXFMYzRkVEtiRTRocjVi?=
 =?utf-8?B?RTd4ak5QWFJBaUZ2REp2NUlSYmNJcjhuKzFvWm9XdFRFcjgwajhqREk3UDNj?=
 =?utf-8?B?K3Z4SG1NcUxpaUxubThaU3Z6cE1VRFZsR29Ec1VhU2xoNkg4TTgrckxiMFdm?=
 =?utf-8?B?K1ZSMFNyczdZWUNrWlNIVnBMblZXSU42OE05WEJ2U2VMMll0WGJtVWs4dDJv?=
 =?utf-8?B?L0hkMFpEYThqREVEV1BOUDk4ZmdXcktmZzdpRHp5TFhranFxcjFRVTZhQ0dH?=
 =?utf-8?B?TGRESzdqRmFKZ3AwUUl0NkVLRW4xYVR1TlpPL0xOZldrb1prL0ppT0NzY09S?=
 =?utf-8?B?RzJySE1zeG4za3htd01VdXNiM0tHbHJvc1VEV000OXJwVVFJVkgwamFoZndQ?=
 =?utf-8?B?TTlBM0dQb2pzUU5KSVN6L2ZoVmJiZ3F6aEE3cGFRaFFRdmNrUWRNUjFjYklr?=
 =?utf-8?B?SXlvRUhybHB6eWhjRURoQnZXeHhtSTg5cmI4RTZpWmJFTC9IRElPcS80ekhz?=
 =?utf-8?B?TXJkMFp6d0hYK0NaYUFWOElPbThoUzNoNkNRcWU3dDVBK2RBb1ZGT2k0L05n?=
 =?utf-8?B?Mk85d3dJcVU5SElHT2krN05zazJSUncwN0VBT2hHcHIwQlczSUIvcW8wMzBD?=
 =?utf-8?B?WUlmdlFId0hBU0JtaDJ4amV2Y1RMUmR4RUFkb045UVF0T2xRTnBPbVZOK1ln?=
 =?utf-8?B?QWw5bU0rTlFUYWExRlFhSG1MbEJYZndrUHQxclNLSktEM0lVemVIL3JPWG55?=
 =?utf-8?B?VElGUTRqbWl1SEVWdGxLQ3dTMytxSjBMS24rYVpIazhRY3FoM2pYczJqZmJr?=
 =?utf-8?Q?w6kvTzpeC58=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Lytib21SRVZlWEw4Sm9ueTU4cDVsTGFZaU91dWhnRFhzSDhiaEVqbUJ0Q2lQ?=
 =?utf-8?B?Skc2eWR1cXh1NEFxL3RrT1ZTVHlzOEV0ZFZuWGpISTk1OVhPNlVkdjErTHFV?=
 =?utf-8?B?T3U3cHdsWXhndW0rRU9YNXRzQnFKTDRBMmRpMytPb2k1d2lpS0lSYko3bkVV?=
 =?utf-8?B?ZlA0bmtONURYWklzOHh1bDA1WE9rRXJRQTlTVmFHbm14TTgyWWxleHNhMWJV?=
 =?utf-8?B?Sk9KWitGUjAvaWFZL25Fb05SM1dOWGxvSFJWaktLR2F5Q3o3RWp3NG9MOHdo?=
 =?utf-8?B?NHZEbjJHUnp1YUlEY3FSU0hva3NZbkxFTXJNV3JEZnUwNnJObTV1ankzTTJT?=
 =?utf-8?B?bWZ3SDJiZ1l1em9tUTNjdHZqNUFsdHFIUG9UbS85NFhOUExTSmVwdmQzY1h4?=
 =?utf-8?B?S3oxSERESFhiOWxlZ2w5RnVGaVJ4Sm9nZDJYZ3Nac3N3cjFDVlkrTlppeVUv?=
 =?utf-8?B?R1pwOFE3TGVjVlBGd2IwVEVHSFFIWVg5M0hxMlNjTFJFUHQ0bHl4MFRXSTVF?=
 =?utf-8?B?dnhGYTVzSWxycmUzWncvMGVxY3oxTURNZHRuditZREV0aTFtMENQaGNpYjg3?=
 =?utf-8?B?TVpQOFdLZUVON1pmaWl0L0h4S3Q0L0c0TllWd0JFdVFoSHRBZHQxbFpzcmdx?=
 =?utf-8?B?M3VNY2cydHZrYnU3WGtpdk9IekQxZ0RsY1F3OGg3ZFUvMVN2eUoyQkVPRkd5?=
 =?utf-8?B?WnYrZUpZZXFjdThDMkFaSWdDU0ZqVkw5N2JhRmc2VlZDS0ViMVcybmRCYjlY?=
 =?utf-8?B?dzlpeU1ncDd2U285a1lzOHd4b0UwRlhxb1hwQnVZYzU0N1FTY2RSbDc3VXlX?=
 =?utf-8?B?bUpqd1FBbUdZY2c3ZWZnTi84bzNJZDhXN2V1K21NNHFHUGh0WXlSMFpJNU1T?=
 =?utf-8?B?Z0NScU01VUNaYmF0RkM5NHlZYUJqend0ZzlVVGoxUXdjbVdWUXBLZHJPUmRL?=
 =?utf-8?B?SHJmV1hibkF3WEV6YXMzdDRXakZNV21oelZiaGdQcy9ZYTJONHlDRXZpVGZB?=
 =?utf-8?B?a2dSS1hZVlAvb0NCbmNoTFpWSFF2Ym8wZDVvcjhUVmpXOURybElxMmNabGkr?=
 =?utf-8?B?NHhDekt2NUpSUjE0U3o2ek45bjdoaHU2S0J0OFBuWC9JZ0QxVVVROGoyMTU2?=
 =?utf-8?B?MkN3cnFmZDBSTkdpdTllQmp6Zml0WkJneGFJZm96dXJyVGhwamVBMlRsdkFP?=
 =?utf-8?B?MlY5bGdZeUpweU1sSk10Q2VJSXdHZTJ6M0Q1K3BjeFRBaktGOHJNWjdBeFlt?=
 =?utf-8?B?cVRwUmVFMGtTSExGdUE1a1NETU9LOTlxV3U3Q2dpQzRNSTl2ak85aU1DeWdO?=
 =?utf-8?B?UXFFU0MrOHFhbXVQajFmZFB3ZGRLa2xwWmJTMnRpbGV1SEpzWjJkRHZvTkJQ?=
 =?utf-8?B?TDN0TEhUUEIvV3lpUE14TnBLS1hjeklkTFB0MGNpT2FiSnN1RVhSZDAyemJs?=
 =?utf-8?B?RDJkL1pSUWpZc2dESXlLK04wV2dBMVdMR09keG9FQzFuaFpTekNrVExuWS80?=
 =?utf-8?B?UWtYZDBQT1NPL1EvWEcybkswaVVFazJJQ0x2cE1NRjVHNU0rb2FEM0FIQWNC?=
 =?utf-8?B?VjNBYUlvTlhjV25hclFwRUREVFIveSsxMmtQZlArU2gveTUzUlVaU1BDNDF4?=
 =?utf-8?B?bGVwTStibkY0VEJnd01BVUVROXhyUFFvSjNwMG1lYmxOZ0F5SkdESktpNnov?=
 =?utf-8?B?c3RaT0QvejhId2tDcFYrTkhkaVlKQ3VoQm9yeWNoRzNLaWc1WEFDNlNWODQ5?=
 =?utf-8?B?REYvUGcwVThUeFViRlVESUNmZ0tlbk9vQmpGdnRGVDRPQ1NvaDZWWlQ1aVV6?=
 =?utf-8?B?UjFsNHFDMlVxMVkwODF1eGg0Tmk2VVpDZnFOZjYxZTFHVHcvamNiTkpQdTFk?=
 =?utf-8?B?WVhSbktxSFp3OTFJSy9INko5RG42c3VzUFdmbWR5V0poYjcwckhoS0lTd2VQ?=
 =?utf-8?B?RE9aWHcyUXRMdjJCYWwrYlNIRTVHMmRSN092c3hEWU9EaVdQSUNxdUxkVUth?=
 =?utf-8?B?SS9XZkhzb3ltSWV5TStUL0hyU0UzcDBqTFplRzVRY0Z3aHZjc1h6SmtWWkx2?=
 =?utf-8?B?WTVhNFdnS3BDYVFFb2lZVkFvQ1NKWkhVNUFUczM4eXovM20yUGE3ZUMvVWhW?=
 =?utf-8?Q?nF7zYfwdFN9nrtif/hs6gbRX8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb889e7a-45c8-43e5-46f5-08dd8bf1bdbf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 16:27:34.4644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cr83uAXGFnUYefp95YqnkHL0xm5USxf8vxe059RO5z7vLY6gMpgeetRv+wGQaJkWLzFcsYiYHjV49APN9b2csg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678
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

On 5/4/25 16:11, Rodrigo Siqueira wrote:
> DCN401 and DCN31 share the same implementation for disabling CRTC. This
> commit makes DCN401 use the DCN31 implementation and removes the code
> duplication in the DCN401.

Hi Rodrigo

optc31_disable_crtc is not the same as optc401_disable_crtc. Please see 
the dfiff below:

< /* disable_crtc - call ASIC Control Object to disable Timing generator. */
< static bool optc31_disable_crtc(struct timing_generator *optc)
---
 > /* disable_crtc */
 > bool optc401_disable_crtc(struct timing_generator *optc)
147,148c232
<                       1, 100000);
<       optc1_clear_optc_underflow(optc);
---
 >                       1, 150000);
152,155c236,237


However, optc31_disable_crtc is the same as optc35_disable_crtc (patch 
3?) and optc32_disable_crtc is the same as optc401_disable_crtc.

> 
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>   .../amd/display/dc/optc/dcn31/dcn31_optc.c    |  2 +-
>   .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  2 ++
>   .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 34 +------------------
>   .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  1 -
>   4 files changed, 4 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
> index 13c1f95b5ced..e6246e5ba86f 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
> @@ -125,7 +125,7 @@ bool optc31_enable_crtc(struct timing_generator *optc)
>   }
>   
>   /* disable_crtc - call ASIC Control Object to disable Timing generator. */
> -static bool optc31_disable_crtc(struct timing_generator *optc)
> +bool optc31_disable_crtc(struct timing_generator *optc)
>   {
>   	struct optc *optc1 = DCN10TG_FROM_TG(optc);
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
> index af67eeaf8505..db7e51fc787e 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
> @@ -267,6 +267,8 @@ void dcn31_timing_generator_init(struct optc *optc1);
>   
>   bool optc31_immediate_disable_crtc(struct timing_generator *optc);
>   
> +bool optc31_disable_crtc(struct timing_generator *optc);
> +
>   bool optc31_enable_crtc(struct timing_generator *optc);
>   
>   void optc31_set_drr(struct timing_generator *optc, const struct drr_params *params);
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
> index 6eba48de58ff..f472d2efe026 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
> @@ -170,38 +170,6 @@ void optc401_set_h_timing_div_manual_mode(struct timing_generator *optc, bool ma
>   			OTG_H_TIMING_DIV_MODE_MANUAL, manual_mode ? 1 : 0);
>   }
>   
> -/* disable_crtc */
> -bool optc401_disable_crtc(struct timing_generator *optc)
> -{
> -	struct optc *optc1 = DCN10TG_FROM_TG(optc);
> -
> -	REG_UPDATE_5(OPTC_DATA_SOURCE_SELECT,
> -			OPTC_SEG0_SRC_SEL, 0xf,
> -			OPTC_SEG1_SRC_SEL, 0xf,
> -			OPTC_SEG2_SRC_SEL, 0xf,
> -			OPTC_SEG3_SRC_SEL, 0xf,
> -			OPTC_NUM_OF_INPUT_SEGMENT, 0);
> -
> -	REG_UPDATE(OPTC_MEMORY_CONFIG,
> -			OPTC_MEM_SEL, 0);
> -
> -	/* disable otg request until end of the first line
> -	 * in the vertical blank region
> -	 */
> -	REG_UPDATE(OTG_CONTROL,
> -			OTG_MASTER_EN, 0);
> -
> -	REG_UPDATE(CONTROL,
> -			VTG0_ENABLE, 0);
> -
> -	/* CRTC disabled, so disable  clock. */
> -	REG_WAIT(OTG_CLOCK_CONTROL,
> -			OTG_BUSY, 0,
> -			1, 150000);
> -
> -	return true;
> -}
> -
>   void optc401_phantom_crtc_post_enable(struct timing_generator *optc)
>   {
>   	struct optc *optc1 = DCN10TG_FROM_TG(optc);
> @@ -435,7 +403,7 @@ static struct timing_generator_funcs dcn401_tg_funcs = {
>   		.setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
>   		.program_global_sync = optc401_program_global_sync,
>   		.enable_crtc = optc31_enable_crtc,
> -		.disable_crtc = optc401_disable_crtc,
> +		.disable_crtc = optc31_disable_crtc,
>   		.phantom_crtc_post_enable = optc401_phantom_crtc_post_enable,
>   		.disable_phantom_crtc = optc401_disable_phantom_otg,
>   		/* used by enable_timing_synchronization. Not need for FPGA */
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
> index 8e795e06e615..be74fd709d43 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
> @@ -180,7 +180,6 @@ void optc401_program_global_sync(
>   		int vupdate_offset,
>   		int vupdate_width,
>   		int pstate_keepout);
> -bool optc401_disable_crtc(struct timing_generator *optc);
>   void optc401_phantom_crtc_post_enable(struct timing_generator *optc);
>   void optc401_disable_phantom_otg(struct timing_generator *optc);
>   void optc401_set_odm_bypass(struct timing_generator *optc,

