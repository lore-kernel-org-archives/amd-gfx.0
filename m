Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D762CF45CE
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 20:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B97310E15B;
	Mon, 12 Jan 2026 20:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CjeZzELs";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AA010E15B
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 20:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xo5o8+Icyh2tVhfUhrVsTBgTYNYks1p28N3KdHJiIOF4osFBr00EaXBos/sbwbTkv+1PvicOaLBW6cvFeUOdys8bZNpXX2DGK8p+zkTR8XfufgDt5t7vZj3ChiM7UXkxVEKM6nWbr4baEe3WUeFj5rCIbgAWWN1/ZAA/5fuoMidV1yLXEMaUkyHXNzm4uRtX2vRNC8kBgVJWFc0vj3e4NfhLi2FmnwUGf709Y2AiCV8wQHGN1kK77oMOwkKpyDclDiPMpQvN8+8z5CvXrcFZYn3Yoczr4KODVpWph8QWJKqWH40pT2z5z97zLjkJy5RPosZ/+iGJ6Pp8z7hIVfwvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VimViTSoj0JLiMcrioK+rJ4oDThVB/vv47b/raxNkNU=;
 b=xRQZQ5EHV9wulVdELw+dBN1DWLWm2zcQe69p1+8/Sy8tOFaCWTGLS0sbGGV9IgI5Vmq1f8skd6naESGaZJDm42Co8gqlQi01OWalC7aiEqjkHZRznPLPWuumGt+y6Rt6OeeqMXfaDcZNiECO+nwBeI6+bSs8obBw5RCjgII+u3pQr1eqxdWYDJT8P8i0XJCks8mDsF+Jn4KiTkCtPuykrZMmh/H6LzbivpC4XgTzPKUeP0otoL+6WUYQM9x2nukVuCiaQSpn1rs8pPA1mo1zoBVoWXgRSCndVSvpW67L15JqeNArj047CEqmpVU09gXOTmmUmTe1Hit8ORHM4o6C0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VimViTSoj0JLiMcrioK+rJ4oDThVB/vv47b/raxNkNU=;
 b=CjeZzELseXOs3jMc6l7kfj7BpfzifOwYWbfbcQjOqBRraUE/9I3gtrE2bafvkW/Dojd2kB4ZGN/rcCAqOVLqtSUwHx/e21I6FVX45u5wdbTRB1wI0Sv/ovNKYuNex564lmuD3vsJVAQrGEQZzT8SVm8SUkuPYVRNTlL4Sj5Dmg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 20:28:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 20:28:23 +0000
Message-ID: <c04c9770-fc06-4e75-bbe5-6e418f7491a4@amd.com>
Date: Mon, 12 Jan 2026 15:28:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/amdkfd: Add support for non-4K page size
 systems - part1
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1768223974.git.donettom@linux.ibm.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <cover.1768223974.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0245.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: 495b2b47-8a22-44b1-541a-08de52192241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjlaMnppeGlyeXJiL0xsMkVVSnlKTEtLaG4vRVM2bWVRdWpDYzQyaHBrMzh5?=
 =?utf-8?B?RWFENEs1a3BVOHNIbWJvMHdRMFlLUFpXVDdHc0RZOUZSMXIvZEFpQmJ0UUt4?=
 =?utf-8?B?eGM5cEI4Y0dxeXk0d3VYZWpDZTQ0WU90eHlTRTF4UzJxWkJabENHQzhuaHZU?=
 =?utf-8?B?eFM1eE9PL0dBdmluTTZrU0xuRndDV29wZGxIM3BVdW93OVBNaHFiL1A3MGd3?=
 =?utf-8?B?VHFjSW9neDFGZGVDK0cyMGRUeTY5cmYrVE1OVTBsOUx1VXZFM0NuKzNMeTBZ?=
 =?utf-8?B?OThSdnZQcVEyV2U3QTNGbks4REg0dDNPV2cwbGpiOUZvOC8vNENmOSs1Y08v?=
 =?utf-8?B?RG5xQ2xXOEI4SG5iTHBWZjY4ZW1ZdXNpcFpZbXhYOFRhcEYwZ0pUQWlBWHQy?=
 =?utf-8?B?bHdqbndPMVJqTVNuTWhIWWJ5T0dmMnJaNGRYWGczTFdHS0toajA2ZWc3ZTBR?=
 =?utf-8?B?aFRRUTBZSzZneWhaMkJDSUJwUlFEME52dk00dmtOREhsc3pmYkN5eWZsNkl6?=
 =?utf-8?B?c3lUWlJTdStQdU5VTExJaVpndXdpV3Zyblp6K28zdFBSZ1BWRkZ1dnpHNnBP?=
 =?utf-8?B?ZG9XU1dSNmdnYXZZSjN0M09UWmc5ZDM1N0NyTUExbmpmdFdIN05laGxHaUkx?=
 =?utf-8?B?WU1Gamw2QXowWGhHWnpua0F0SFZTV2xQWGlxeWtUcFo3NTdVcGE0YU9pZ2hS?=
 =?utf-8?B?d0N6RDR1MXFFUFVtUGhibGFQYVFMQnlOSldNSjNOSUhRanovMnhiZVNIajNV?=
 =?utf-8?B?S29HcFlDYnI5NkVINkFVd0dwREFibGRKKzdvM1Fnd3B4OWZsbXJFQU9Wejcx?=
 =?utf-8?B?NmN4WGVVN1F1ZWY2UWVaTTBja0hQVmVQOEJLaVNjUllQSHh0dzg5ZXhRNXNK?=
 =?utf-8?B?RHVibnNVRzBYc2Jvb3h3S0FuRFFRL1BJSjhUNUtlYktsaCt2b1J3TlJWayt2?=
 =?utf-8?B?U0xuc0lobHdGMXFxZVg0M29CRXNaTWJTdGtVcENvQ3Z0b2tHM2lHR2RLMXJH?=
 =?utf-8?B?VTlVWHUrNTllT1FBaUNHZFVTMFJJOEZTRlc3SFE2VHNkK2toR0lqSU5RdWFG?=
 =?utf-8?B?WkJuUkxScUZTdTJVNjVoTzNqTU9aaDBIZzR4MzI0VG5RZEQ0RW85QjdsUUpT?=
 =?utf-8?B?S1FyTFJCckNadnRaSmp2ZmdyYVJMSjUvVTBXTWJ0Y1liUmdEZ1ZybUh3QUI4?=
 =?utf-8?B?WDc3WWMxSzlhRURRai95K0tFcVIvVmtNVHJWRTRQdCtLM1pVZDVMR0Q3UmRP?=
 =?utf-8?B?QnNuUzNLYlhtd3lLMnVuT1pJUjhBSUVLR1ZTbXZnODYvMmh5Ti9IelFNbW0v?=
 =?utf-8?B?TFJMc2FzaWtFdlEwQzk4c0ZGZGZwSm1lL1NrdmtWa2pOeUQyL3dicVFSZ3E1?=
 =?utf-8?B?czBkdmJLQ3crU0dHeExJWVlvNGJXY1NhNmhzMnFrbndYZWlWSi9lSHVpNjlM?=
 =?utf-8?B?MmFQV0NpQzdkNG8zVFVCV1plQzVsSm1KOHBkbnFhZWFrcEdLeGpuRldVdFJ6?=
 =?utf-8?B?MEc5c3JNeXRsUGxrWEkvb3FSZE5wS3loN0owYTA2d2VtMXFGWjQ5LzdJYTdP?=
 =?utf-8?B?Nm5jbXVHNTZwbExaNkJPV1FTU2JLcEhwSGcwTU54UFFvYWNXYzJKV2F4QnUv?=
 =?utf-8?B?RkhBSHNLUjNxUHlGZ3hXU29lM3ZpUUhrVHdPdWlmbnYrZmcyQjJ0Qk5ZSUxa?=
 =?utf-8?B?NGFBNFNXZ21IT3ovdkNxOU9uNU9tdEltVEkxSCtwSk1HVUo3Zy9ndGFyMk9h?=
 =?utf-8?B?dDhlVEJMQ1dxVjNoTUNiRWttVWJEaXJsOUZUYVh3LzZDNkM3N1BnOENQVlBS?=
 =?utf-8?B?aWtKVXBWTmY0c0hUMzR6SGQ0dVNKVGFEZ2RabTFaQnd4TEVkdy9pRGlTSVk3?=
 =?utf-8?B?Q09iNmIvV0dxcWxSbmRWSk52SVNKb1J2cmsrS1lpOTdvQS91eHlkL0NkbGF3?=
 =?utf-8?B?d1RGQTNUcGFjbEJ1WC8rNnVMcHJXTzd4L1Nuamk0eHlwY0FTTTJNZ2VyRjA5?=
 =?utf-8?B?UlZzNE5mOEh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdjMVlWaG1EbzZXUlYrTGtybFVmUHYzS2VKMVpXSTNyYUpOYjA2bk5tZTAx?=
 =?utf-8?B?QXhJSURhOHFCRUsxTUJ6YzArVFl3VmF2dkhLbG5VNkR3dlU4azA5aWRka1BN?=
 =?utf-8?B?NjZiYjluU3o1U2JmQVhmcllxRVZxazlwT2M3cjBXOWJXQXBydG41MUY1c2pN?=
 =?utf-8?B?eXMwbG1xM1hmRGpDTmFzRjZTSVlLM3VsODV2dGNyMlNackZ0RmFUTzdCeTNP?=
 =?utf-8?B?cUFEK25qRHEyM2xvQjhzcTRzUko3aUdYR1AwMExoam5BT2FkMkQyOFVLNWhQ?=
 =?utf-8?B?OGw4WDgvVVgySjE5WkVjamgrYWw1bzg5R3RuaUx6a1NKMzExZGkyRFF4OXZE?=
 =?utf-8?B?dm15ZzdhZXpWcHhnMU43VmdOSjlaWFlTUWdtNzloVkFlR2NyZWFBRUdFRHlO?=
 =?utf-8?B?ZW9QaFY5ejRrcWxka3hXaVZuME95WXZ5YUUxSUlMK0lsbUxpY3Y1U0VLUmZt?=
 =?utf-8?B?bThCOVhNYkp0cldNQ0s1RFQyY3pTM2dNWWxNbndCUmxMZFpXMkNsQTJSNGhK?=
 =?utf-8?B?SzhBUU1nNGQ2cmFEMmkwSG9oZzJpZ2s2TGJtUnFMWWg0bVZUK2R3bUFTNHNq?=
 =?utf-8?B?ejM4ekF1YkJwdGgvSVFMb09VQnUrSmg0Sm40VmNnQTBQQ2lQUE81aFBYRm9u?=
 =?utf-8?B?WHhCcWt5T2ZTWTBFREZqZHhpcFd5cDhKRW1abVVOZllKYlZ3clZiNmIvTkJD?=
 =?utf-8?B?bVFCVkRiazNBbjVIeW84R1JrYTl1Z1FOajVFOWxWYy8yL1JFNXZBaVFXMnRB?=
 =?utf-8?B?QTk0STl5UklVanJrQ3BjaTRPMUF2MnE2NWVkR0pSUVFaMjlwd09kVjFSNUcv?=
 =?utf-8?B?Vlc1ajgwMngxMG15dVpWcWt6MlhGMWJNeTJua1ZtRDRNZmxRa2VmQWpZWnI4?=
 =?utf-8?B?TENBQVZCWm9GZFNzSFdiOXg5Y214d1pLNG9WRDdNekkyd3V1K2liZWZxYmlo?=
 =?utf-8?B?Nzh0a3Q4VUlxYWdMQnpNMWhMRHA0SFBEMElsRElNUFVOSWJQOE5HdGN6TUh0?=
 =?utf-8?B?TnVTbU03VkQvRFIwdnhqZHdPUjVEQzlOR1dxZEVlc2x5NHphbGpNNjV4OUhC?=
 =?utf-8?B?MzZBS2VFOHVlQ1J6dmRFKzNHUTBob3lJdlBsb3BhK1p0TWMwNks4alVRclZ2?=
 =?utf-8?B?RnA0S2dscUdpckxTTjVDazNFZjZOSVQ3RUJoWHFFR3pjQjhueG4wRjFGNDkw?=
 =?utf-8?B?czhTbS9jVm54VjRLUjRTbmNkQnBQby84TFFFNGtLT2tQN0lueldwM3V6WmM3?=
 =?utf-8?B?VlErZmFNVUFOSGVlb053bWlHK09WcGJxamE5M3F2bnFBbVk1RHNURkRNcGtF?=
 =?utf-8?B?ZkR6MnBJelRnRVRabmIzeHFscnF0VGIxZjA5YVhUNG5LU1ZOU3IyVUJkSUtP?=
 =?utf-8?B?Z3Uxc09kYW5uMHM1eUVWL1VlenptVy9NeDhxS0IveE15Z1dGM3gzaEYxUUNC?=
 =?utf-8?B?dVNrYnErckJKLzU1aFQ3N3FxZWwyaTZuaUR4R2hpVXR2NUxNSjJHMko3UDND?=
 =?utf-8?B?ZXE5ZFJzNitydTJ1aERUd2ZxeTdjU3VEVW5EZHBjdStnUDhmUWxOaVdyNEJ5?=
 =?utf-8?B?TFA1dTkzWmFNb2QvZTQ5NlNJUGZRWmsyc2dnNk9HbGJhUzhVZW5qVTFzRlNv?=
 =?utf-8?B?NFVscUs5ckhWeENxVWhQZkJMZThXVmJsUEVHblNINXZ2dEtNL1V5QXE0cHJZ?=
 =?utf-8?B?OFBLazNoOS9lUGpEeDI1RktpSkVGa0h3QkJIMHRsRUkxa3lGeEFxTEhxVWE3?=
 =?utf-8?B?a1c2K0RsYmFlZVd1amlEYjhQY2VqREtxNEFCWjI5TXlBejl0bGpoeXpud1ZF?=
 =?utf-8?B?eGI4UEhESFVPYXQxSHgxYW92V0lNRTdscEJCVEVpd0d5QXlGdUMxd2lteGJI?=
 =?utf-8?B?RTI4eFIvbGJEb1RiZlJrdkovc0dDZHlYUWhpM0QybXZoLzV0Y1FIbHMvZXlN?=
 =?utf-8?B?dHo3MVMvdmNlLzc4MVJ2U3hKVnJZbG9SR05vVDYwSmNyalIzZG1GclorNVdk?=
 =?utf-8?B?ODQrQ2llanh2TkhXb0xyalJNdTBZdzRqQ0pyTm1LRmJyU0QwaE1uYjVOdWNI?=
 =?utf-8?B?Mk9HejJtNHRSd2tORWdjVE90amRocm1wTk1EVklUaXkrbkNZaTJiRnQ3QUFw?=
 =?utf-8?B?RlRhbFZjb1hLV3I5bUZrMndQazl3amdNdG9pM09uN0FodFNKM1drTXpJQUZ3?=
 =?utf-8?B?eXAzM3JsQVpQSEx3ZjhIU0dtRlpjQkJXTzc3MFhsZE9GSnllUHNCRW5wS1o5?=
 =?utf-8?B?Ry9XUjQvbUlEZ2s3ZTNoamNnanpYRVlnRnJ2dEYxaysyTTFDZzZMWmc4WkNZ?=
 =?utf-8?B?UWpheFk4bFVqMWRLSDNUdjRhQ0lsUDEyd0ZEUCtVdjk2L2ZhWHBRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495b2b47-8a22-44b1-541a-08de52192241
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 20:28:23.7411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A59nyoMeXDQ7Ls/oOjTIFHWjGi7BVR0igqMjCHtB4cTMr4jYKazvjczkU5qyZwC/ClEvMgErFsbMwtj2AjyOlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604
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


On 2026-01-12 09:06, Donet Tom wrote:
> RFC -> v2
> =========
>
> In RFC patch v1 [1], there were 8 patches. From that series, patches 1–3 are
> required to enable minimal support for 64K pages in AMDGPU. I have added those
> 3 pacthes in this series.
>
> With these three patches applied, all RCCL tests and the rocr-debug-agent tests
> pass on a ppc64le system with 64K page size on 2GPUs.  However, on systems with
> more than 2 GPUs and with XNACK enabled, we require  additional Patches [4-8]
> which were posted earlier as part of RFC [1]  Since that require a bit of additional
> work and discussion. We will post v2 of them later as Part-2.
>
> 1. Patch 1 was updated to only relax the EOP buffer size check, based on Philip Yang’s comment.
>
> 2. Philip’s review comments on Patch 2 were addressed, and Reviewed-by tags were added to
>     Patch 2 and Patch 3.
>
> [1] https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/
>
> If this looks good, could we pull these changes into v6.20?

The series looks good to me.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

Alex, what does it take to get this into 6.20? I guess you'll want to 
include this in a pull-request for drm-fixes ASAP?

Regards,
   Felix


>
> This patch series addresses few issues which we encountered while running rocr
> debug agent and rccl unit tests with AMD GPU on Power10 (ppc64le), using 64k
> system pagesize.
>
> Note that we don't observe any of these issues while booting with 4k system
> pagesize on Power. So with the 64K system pagesize what we observed so far is,
> at few of the places, the conversion between gpu pfn to cpu pfn (or vice versa)
> may not be done correctly (due to different page size of AMD GPU (4K)
> v/s cpu pagesize (64K)) which causes issues like gpu page faults or gpu hang
> while running these tests.
>
> Changes so far in this series:
> =============================
> 1. For now, during kfd queue creation, this patch lifts the restriction on EOP
>     buffer size to be same buffer object mapping size.
>
> 2. Fix SVM range map/unmap operations to convert CPU page numbers to GPU page
>     numbers before calling amdgpu_vm_update_range(), which expects 4K GPU pages.
>     Without this the rocr-debug-agent tests and rccl unit  tests were failing.
>
> 3. Fix GART PTE allocation in migration code to account for multiple GPU pages
>     per CPU page. The current code only allocates PTEs based on number of CPU
>     pages, but GART may need one PTE per 4K GPU page.
>
> Setup details:
> ============
> System details: Power10 LPAR using 64K pagesize.
> AMD GPU:
>    Name:                    gfx90a
>    Marketing Name:          AMD Instinct MI210
>
> Donet Tom (3):
>    drm/amdkfd: Relax size checking during queue buffer get
>    drm/amdkfd: Fix SVM map/unmap address conversion for non-4k page sizes
>    drm/amdkfd: Fix GART PTE for non-4K pagesize in svm_migrate_gart_map()
>
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  6 ++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 29 +++++++++++++++++-------
>   3 files changed, 25 insertions(+), 12 deletions(-)
>
