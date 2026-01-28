Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A31AD25B5C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 13:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D429210E2BA;
	Wed, 28 Jan 2026 13:22:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xIZ0jxhl";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED3910E2BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 13:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiT+/E0QyD2Yr4WXyT/YSJCkRDS/kL2zgRfHBTw4MhpZAkF9Tc3XhjOSclqtQ1KWoPOFLAQHN/NYkm0GkqNoqKCCGUcmrcJ/jK9SIDzfV4lYKT88ou+0gN4l5qvKTepq57tSc1SdqIknX1k/+dCIWtfs12Oh5Vl80BdAyVqrf3sF6gS+ubDQEiSAZGW0Nbhpfhe02E6feFgH9aM9vkvBHf5d22D4xt8LR8DiqNPfmhV9dPj/iOAs3dn90bdMQpGv961QFgsWjh2/6BxdbN+C0bZs6XqN+wSTbUjgG8Sq22XngkYU/wHllA8LZiMsvzgv3ZE7FvTu7p5wcTRY1ffCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Q7vxsAvhmMaZS0Lv/BEb2Vtwn27h0oG6Ie3pmZIGBA=;
 b=s+hEPwhmVju5Icga12oMWdTSc8f/nF2u9zsQnqZmlchrb/B0cowJl5hhHwYE4OkvIh8j0NtkWq69Q3fgzWq1+DD8nDVqTDrnpwuGqKyzV0/iSeSPJQcyGTmfOzP/BXU1cN6zlCQjl9QKNGPDeXzRx76QVsQXdHv8VRwSsA2Igp/WlIZ9+b7qnb7t8h7EE8o8wUOgkEBtAsbtr6mLYfVBqpVJVUrMn4P7/WXdw0hmhtSd40IIiRvzL9tu2AYEeLFS++epE0mgZf3pqUGceUBlZA/GMuPdr2m+Bf7e09Dyk5cC4JUM/jndBIzHDBwIF/atizpiy5YI/tp8TxgWGDzI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q7vxsAvhmMaZS0Lv/BEb2Vtwn27h0oG6Ie3pmZIGBA=;
 b=xIZ0jxhlonnxF7fZYDVtGcqj3j7GUodZ/da9mx6H1o9p8ZBVM7eWaeYlH2lLawweayEgI6BcfrwCjWkDwEV+ZFo7VimN/4Zf/ilLcLbyWt3wAXwL6czNeTF82C53mcHtApqIVX0Rre0ueKKW5l2cTcgW9usYeLCabMNNzzw3wGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.16; Wed, 28 Jan 2026 13:21:55 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 13:21:55 +0000
Message-ID: <12f53040-35b4-4add-a245-dca3ddb69a92@amd.com>
Date: Wed, 28 Jan 2026 18:51:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] drm/amdgpu: Add ioctl support for cwsr params
To: Lancelot SIX <Lancelot.Six@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com,
 "Yat Sin, David" <David.YatSin@amd.com>, "Kim, Jonathan"
 <jonathan.kim@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-10-lijo.lazar@amd.com>
 <CADnq5_M6Mi5SJi_AYKhdmwacxumeTUrRHMrKazQxEM4v=utS7w@mail.gmail.com>
 <283b02db-3038-4e6c-b577-a9fa02741b1b@amd.com>
 <bcf37fff-290c-4b17-9207-8a71ae9e5fa3@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <bcf37fff-290c-4b17-9207-8a71ae9e5fa3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0121.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: eec9846d-67d6-4777-5e35-08de5e703509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDhEUC9wRzR5SXptSWNzbDVaQWVSdmtzZFYrV3J2QzczK2J2ZVN1SEdabzNu?=
 =?utf-8?B?UXB3NHZYL1ArSkdzaFFQYTlTaXBPNllrS2RicS93bnlyZlluT2wwNlIxWVdz?=
 =?utf-8?B?NGk1ZkdWM29rb0FLbEVSaHFkbllsYmNBREtHVUQralVUTXl5TGt2RE9xV3g1?=
 =?utf-8?B?T3p1MW9QbWszUHFDNklkNGhLTjBZb2hYeEtoNEI4TjRsMmROV0Q1Q1ZyS094?=
 =?utf-8?B?RXBKM3BSTW4zK3N4a0YwVG1zWmRxaTZPWEFXKzNZbHVlc0x1eDh2SGFuSUU3?=
 =?utf-8?B?Qkt6U0FkVnNncGJZWHl3RVhQNUh3L0NOcWFmbzhQM21SUm9pc0NoQUtROWZo?=
 =?utf-8?B?TDluVTFxdXBPOXprZGdRakpLN1ZFZFpWa082SUtCa1lya3p6RDVEN0JWNktF?=
 =?utf-8?B?ZTZ0STZJamRzNXhuWkJkMS94WGswUlV3YlBMVnRNNlZuZnR2SDRLMUI3YWNk?=
 =?utf-8?B?QkFmbVhoNVF2Z3VwdnRKNm9XR1pmTGRETzJ5aDRkTmpqQ2E3RTRUU3lENVU0?=
 =?utf-8?B?ZGJsQUtHTHVQYUtNMU54NWQvQWQrakZEdGRpTkRZbnRqSzZSTGMrRzEyb3dD?=
 =?utf-8?B?bWhJbTB6UXVNQzJHWmZaUm5md2psUVI5a0ZZY29nOWZSV3cwemQ2dFF3bFFF?=
 =?utf-8?B?U1A2WkZSNDFZWnhxamNnRGRBZUxCSDhyN3lCYkpxWnZIN2U1alNjYnBGRVR3?=
 =?utf-8?B?RHA5Ujh0YzZsODdwZTZBUFIrczduTzlFMFZhaFpiYjF4aWNWL3ZhcjNXc0NU?=
 =?utf-8?B?N2tMRFhTZldvOTh1S0lxa1hCbTVMTnkvbmtLUDliN3hvQUloRjhqSzR4U0lM?=
 =?utf-8?B?eU9ZM1NIUkFyQVVKTFIzNEdncnFORjlmTTNEdEJwdlBqcWNpNlRselZOUlpT?=
 =?utf-8?B?R09RQy9rTlloUWtPRVZxeXFqVVQ0bWdRTUxwc1VIMVh2ZzM2MXNBZmpmRWIw?=
 =?utf-8?B?NDc3MzM3YWhxT0ZXZVZzTk9qUE15QnVCa2hXRDdFT0lWc3k0VWwyMEFMRDlU?=
 =?utf-8?B?QXF3UGQxWWZZWXR1QWtET001TURpQTB6NTc5WkdPK3JNZGxKZFFucGM2K3pT?=
 =?utf-8?B?S1lhSDVaRnJuOWFCdXZOYTRmZEhPcEk2UHREdzJNdDdEeFRibStIS2NJeUNm?=
 =?utf-8?B?bk1vcDFnSUc0RW13dzBueElqQ3Jyd1FrdGRjR1NrZnNOdmc3QllmM1BEZW0x?=
 =?utf-8?B?QldSdDBvUTJ2eEI0YW5Fd3dVakNaaS9ocVVTdk1NSnpVNzBXUDlnUGxUTER2?=
 =?utf-8?B?UmRZeVJhaXFDVFNZd01tUysvenJHbWQwTGUxOE1kY1djNXJURUxSL1ZGMENR?=
 =?utf-8?B?QWkxYnQ2cUF3eW5wcHcyc3F5UXllNld2ZHhqcDBjaWN2VE12dVNsMHI4c0pE?=
 =?utf-8?B?cVNWQ0RMVTBUdk40cHJMQTBhWnlhV3V0eWtFSzQ4bEw2b1RDVExQMDFsbU4y?=
 =?utf-8?B?b1g3cHU5cDNSS3JiUjlaTm51ZmJPcCt3YjhCZjdQN1JNWHRrVlpOSHVDK24y?=
 =?utf-8?B?LzN5b0ZZRVRDR2J0V01DUThFcm8xcmgxNnlBYThNaWlocEpmTWFISm1ZWVJZ?=
 =?utf-8?B?RFRxUXBBcFpqSmVBMU5KK2xGV3ErWEVZcms1bzlwZTZYWmdmTVVWaW1aT1Z0?=
 =?utf-8?B?RlNZa2o5TkhKWjhCRkZIZ0VsZllCT3FmM1ovd2ZZOTVxYUlhdTZnR0JGQStZ?=
 =?utf-8?B?U2trV1NhUzhLM3FKTWphVWhOUjFxN1d3ZUpoN0FNenFOZjBRSng3RWpXT1d5?=
 =?utf-8?B?eVZwZUhuMUk1TXdqaG9MR0UyblBVaGcyMFJqNFJNQnJFRG51ZXAwSmZUMjl2?=
 =?utf-8?B?dE9jTzRZNEgxVUl2a1lkKytkQ3MwbnM5WUxWaFlxRTZKbDZhRFpaVzY2QWhU?=
 =?utf-8?B?cUZGaW55S04wV2NQUVZQUjIvaVhMTE9zR3VBWVd1Y2M4VVF1ZVgrNkliM1hm?=
 =?utf-8?B?b1k1N29tQmNwZHZRWEx2OGlRWi9ZZ2pmZHI3KzEyYWRoQmVDeWZ1cGVTRUZ6?=
 =?utf-8?B?UzJyNFE0OEtFdU1KM2U2bzl4UThDMjl1dU11K0dlQ0VWUjNnV09rbE5JelV2?=
 =?utf-8?B?cHg0TGN6c1FHTWZjZGlvU3JVUGZaT1RoMG5zN2k4OW05YVI3ZkE0dFdJbDZS?=
 =?utf-8?Q?DX1gi+bQkfD/SSoN+F5ZlLYJk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YldVLzNRUk1GSGRBcFJ3TUZXSDZIK1h4Wk81Y083Z01jMjNBYm5zUzBrUWQz?=
 =?utf-8?B?OThlR1AzeDVKa3k5VW9kNEhOMHFjK1VuNGh4RDBlWnV3dFJwVUZzT1R0KzJ4?=
 =?utf-8?B?RlNxWGNxbWRRUDlPVTlaRnJLcUFuaGp0OWdMMUlIenFaTDVlendmdmNYSVpI?=
 =?utf-8?B?NnV4R2JmZFkxQUM1SkpnaW9ObnMyVWVVM3NiR2RqU0FIcUNHaGMyWmRmTzdu?=
 =?utf-8?B?UUZiZTFWSkFuWkNsS1JsYXFYcy9oZWxZMWhqTzlDdEJ3Wm5IbCszb2ZqSGxN?=
 =?utf-8?B?ZU5Ta2RjaXdiZnZPdGFBMEd3NXZzT3FmZzdjMHpzWGFxWW5JdGlnbE1wN2Qz?=
 =?utf-8?B?V3JBeHlRY2s5dnYxempQZWdtRWJySTBleU5rUDVCQkNzY2tMMDRqdzFKZ2do?=
 =?utf-8?B?N2RFbzZOS3g0aGlaQVpqR2txampVdUlFRzBsaDBvQ2dJamhDQW5MellkanBP?=
 =?utf-8?B?SmQ2WW55WHpHSkVnUUFiRFhwS1ZsQXFBN2dwVTdzaE1idVpjVk1VWFRsZDdj?=
 =?utf-8?B?UEdadXo2dkZHVEZSSXJJMDRpRzh4NW80NWxLNlFpeWhLS1VqWHdXNi80M1Zm?=
 =?utf-8?B?TlRLaXQvNzQxaStpbzNuU2dBaDcyaElQV0g3T3RSekR5RlNPQ296NTNwSG5B?=
 =?utf-8?B?WlBaSHN0VzdMbDY0MmVQclpPMlp6eUFXZ05NQWRoS2lTTFN6WHpTeWFLZHBW?=
 =?utf-8?B?VXZ5eHgwam1YOWp4Z1YvRWIydG9TYmNMU3FsWHFWWnhWK3RNY3N5UFBYeVFG?=
 =?utf-8?B?Z3JweUtkVjNGWXVWOXJSRHR4M29qNEZ2Yy91ODR3VXZSMmV1cFJTY0pIL2wx?=
 =?utf-8?B?VjQxZFl3dDRHMXIxKy9GbDBLU3ZJMVRFdUQxbkFtNkRIQ3RIT3pIU3pCYW9w?=
 =?utf-8?B?VjhVZWQ2NnJGYnpSMENDT3R4SG9Jck1nVks4Zld2OExGc2JGMUdzMDZXNW1i?=
 =?utf-8?B?MjVZNk5ucGIvT2ZrZE1rbUtFMVhySThnY29RM2V0aXhYTVp3cEhkL1RodXhO?=
 =?utf-8?B?ampHRlB5bkV5WHNWbG9PVjh0K2JtVms5c1pBK1RFS3ErODBsWTh0d3VFY29x?=
 =?utf-8?B?VmZCQzVEcFpJemF5TEpBN3hpMjdMUzFNdGxjVGVpMXJwUUNIczRJM0lEOVE2?=
 =?utf-8?B?SDVaTit6Tk0xeVQ4ajRpalpJYXF2cDRVMER2QnFweWhGWVNkQlIvblJJazZG?=
 =?utf-8?B?SGNBQlZWTnBDTDZCZFdXMU1NVEJQb0tGMCtMSXJqSHpPbzMxdFdaUFh6YjRM?=
 =?utf-8?B?c0p3KyszR0QxdzNXQmVZbU5JTld6Rk5oL3UwU1R4dnNPVklySTAxLzE4QkZV?=
 =?utf-8?B?Rm5NQlh4VFljekxnMDFmOFRvQXFZNm9xY0ttTlVEMFVjU0twWnZhd0JuWC8z?=
 =?utf-8?B?OFdBTjd6UzlEOWJrVFdZK1ZDSVIyVnRha3lQbGN0YU9hMjlFM1JSSHBCMHli?=
 =?utf-8?B?OEJhV1ZVL1BXWTZZWXFPNWZwVGt2RmpiVFllTlNUbkVuYVRsTWVKVmYyTUl2?=
 =?utf-8?B?ZXVrWjZHYWg4cGxlR0RkQVY2SmVUM2Z4eWlJVG1YVFFUaXN4VHl0RURDV1RV?=
 =?utf-8?B?Mi9ZbFVFaU12bnV1UFlhQmNaTGFLMXhXZm1nV0pwUVVES1VYOWFrV3ZKbE9r?=
 =?utf-8?B?OS9lcDh3cEdkLzh3SVVXd2F5YkVNSkNFVGNTZGwwanB5R1NGYzIyK1hyV2ha?=
 =?utf-8?B?WnZkYUdNUmJydUtFL1A1L3NGRzJGQThMbUFsUWlzWW43Z1RyVFgrS3BEZmsr?=
 =?utf-8?B?THBxWWs0NHNZS2hvRXhudDkrSGZnOThXd3ZNTURDV1dlbFpCcXdGNFdpUnB0?=
 =?utf-8?B?RkYxbEJFVWFHSkxIZi9HemJRK2NQbGZmbFFMQ3VLOU5zalhSclZKam13RzVu?=
 =?utf-8?B?YmFWQnJJL3ZZNDVGdzNtZVRrZUg2RnlQTGhQZU1nMEQ0MWhiYXBRQkhaTk5D?=
 =?utf-8?B?M3ZQdkZKS280NmFyaHFBQmxEZXh3dWZiL2poMmhGYm82RXAwcnNvcGkyNm9r?=
 =?utf-8?B?b0huV0FnMythNjFjYXcrYmdBbEt4MXhuRTZmNHFtOCtOVlcrMy84ZzJrREZl?=
 =?utf-8?B?b2lINC9DSnVMTE1DeGRkWEwyUXRuMUdyS1JCb2VoLzBrWlRIWU80MThlaWZS?=
 =?utf-8?B?cmovNVpjb29pK2RlTy9KWGJzTlF6OXY2VDg4MFRmN0Q2Rkp6UzlzRGVDL0Va?=
 =?utf-8?B?R3IzRE1Lb1E1WUFiRXpwNm16Z1hHU2Rmc2VqNkdsUWZvU1ZKekNQb1IwYjN6?=
 =?utf-8?B?cERuVjJNYlBJSk1FVTR5akpZajI5ZWxFc1N5WXlSZXk5WUJmTmhpY2Fkckht?=
 =?utf-8?B?VFRVNXVxTTNKV3E4eW5NeTRjNnI1TDVRT3NpRWZCZ0VpUlAyVWcvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec9846d-67d6-4777-5e35-08de5e703509
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 13:21:55.3490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kib1Wnk9IofamxANhhBw1SWDP7ZB835CTSYXk5m6LTzT0OEtZak9E/WMq9le2Mih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
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



On 28-Jan-26 5:29 PM, Lancelot SIX wrote:
> 
> 
> On 27/01/2026 05:44, Lazar, Lijo wrote:
>>
>>
>> On 24-Jan-26 2:21 AM, Alex Deucher wrote:
>>> On Thu, Jan 22, 2026 at 5:52 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>>>
>>>> Add cwsr parameters to userqueue ioctl. User should pass the GPU 
>>>> virtual
>>>> address for save/restore buffer, and size allocated. They are supported
>>>> only for user compute queues.
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++++----
>>>>   include/uapi/drm/amdgpu_drm.h              | 16 ++++++++++++++++
>>>>   2 files changed, 25 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/ 
>>>> gpu/drm/amd/amdgpu/mes_userqueue.c
>>>> index 7ad8297eb0d8..2765317f04df 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>> @@ -343,16 +343,21 @@ static int mes_userq_mqd_create(struct 
>>>> amdgpu_usermode_queue *queue,
>>>>
>>>>                  if (amdgpu_cwsr_is_enabled(adev)) {
>>>>                          cwsr_params.ctx_save_area_address =
>>>> -                               userq_props->ctx_save_area_addr;
>>>> -                       cwsr_params.cwsr_sz = userq_props- 
>>>> >ctx_save_area_size;
>>>> -                       cwsr_params.ctl_stack_sz = userq_props- 
>>>> >ctl_stack_size;
>>>> -
>>>> +                               compute_mqd->ctx_save_area_va;
>>>> +                       cwsr_params.cwsr_sz = compute_mqd- 
>>>> >ctx_save_area_size;
>>>> +                       cwsr_params.ctl_stack_sz = compute_mqd- 
>>>> >ctl_stack_size;
>>>>                          r = amdgpu_userq_input_cwsr_params_validate(
>>>>                                  queue, &cwsr_params);
>>>>                          if (r) {
>>>>                                  kfree(compute_mqd);
>>>>                                  goto free_mqd;
>>>>                          }
>>>> +                       userq_props->ctx_save_area_addr =
>>>> +                               compute_mqd->ctx_save_area_va;
>>>> +                       userq_props->ctx_save_area_size =
>>>> +                               compute_mqd->ctx_save_area_size;
>>>> +                       userq_props->ctl_stack_size =
>>>> +                               compute_mqd->ctl_stack_size;
>>>>                  }
>>>>
>>>>                  kfree(compute_mqd);
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/ 
>>>> amdgpu_drm.h
>>>> index c178b8e0bd3f..b7a858365174 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -460,6 +460,22 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
>>>>           * to get the size.
>>>>           */
>>>>          __u64   eop_va;
>>>> +       /**
>>>> +        * @ctx_save_area_va: Virtual address of the GPU memory for 
>>>> save/restore buffer.
>>>> +        * This must be from a separate GPU object, and use 
>>>> AMDGPU_INFO IOCTL
>>>> +        * to get the size. This includes control stack, wave 
>>>> context and debugger memory.
>>>> +        */
>>>> +       __u64 ctx_save_area_va;
>>>> +       /**
>>>> +        * @ctx_save_area_size:  Total size (in bytes) allocated for 
>>>> save/restore buffer.
>>>> +        * Use AMDGPU_INFO IOCTL to get the size.
>>>> +        */
>>>> +       __u32 ctx_save_area_size;
>>>> +       /**
>>>> +        * @ctl_stack_size: Size (in bytes) of control stack region 
>>>> in the save/restore buffer.
>>>> +        * Use AMDGPU_INFO IOCTL to get the size.
>>>> +        */
>>>> +       __u32 ctl_stack_size;
>>>
>>> Does it matter where the ctl_stack is within the save area?
>>>
>>
>> This is the legacy way. Probably, this can be avoided. Adding David 
>> and Lancelot.
>>
>> Hi David/Lancelot,
>>
>> Do you have the background of userspace passing back control stack size?
>>
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/ 
>> amdkfd/kfd_chardev.c#L260
>>
>> Can driver assume that context save area takes care of everything and 
>> assume that user allotted as per the right control stack size?
>>
>> Thanks,
>> Lijo
> 
> Hi,
> 
> As far as ROCr is concerned, the control stack is just an element that 
> contributes to the size that need to be allocated for the CWSR area.  I 
> do not expect ROCr needs to know anything about it if it can query the 
> driver for the minimum size the CWSR allocation should be.
> 
> If userspace processes are interested in accessing the control stack 
> (like the debugger for example), the way to access it and know its 
> current size is by reading the CWSR area header maintained by the 
> driver.  See "struct kfd_context_save_area_header", which contains the 
> effective size (of valid data).  This struct is at the beginning of the 
> cwsr area (ctx_save_area_va), and contains everything needed to 
> effectively decode CWSR.
> 
> Does that answer your question?
> 

Thanks, that clarifies. Control stack size is expected to be passed to 
mqd. I think driver can use the size it calculated as long as user has 
allocated the minimum size required for the whole save area. Will remove 
this from input parameter.

Thanks for the pointer to save area header. The interface to query the 
used size is missing.

Thanks,
Lijo

> Best,
> Lancelot.
> 
> cc Jonathan.
> 
>>
>>> Alex
>>>
>>>>   };
>>>>
>>>>   /* userq signal/wait ioctl */
>>>> -- 
>>>> 2.49.0
>>>>
>>
> 

