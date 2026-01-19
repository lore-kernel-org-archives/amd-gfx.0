Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37A6CCF2F6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 12:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E99410E435;
	Mon, 19 Jan 2026 12:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xySQ8ta0";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C2FF10E435
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mV21eKFaqhEB+71/a1hy5QMtC/MlZoA9NDs6T/uoSA9x+hioDbMzKr6ifN7t6nFR1XTlty7DdSpyprlMxajWOmIEVyXpU4r503ldbcEo7w2+Ah6JICCuIEMpC6OQqgIhjfsfJOqBCJU25ouPZwPwkPPKceU57u1HuQeXHUTI1tRffkpzaCqyUJ7uVgzYTRP+RoM2SQHHZP9bSqRSplgsh0cpHLplJ1+8zDsmsJml6xdNtbpi40tpzdoPVGcEK7zwdTL1YW281l/s6bnNyJKzWqPiqZ/VflVuzBP/LR1olPC5DNLix+AGLoTwTEXUnLTqBkYXbJnlobbdSmPuFnLZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVDdY9/JV8/Dq1ncHCWRTPVxv7Mr4vk8G90QkJjJ01Q=;
 b=gPoJ6omXvVIyPL8K++2ynUCE3CK5mxoGSwvOxyxDnlq2Abvn+leIM7TPZmYvimAsmBbOablwu3vMz2cGLnqqwDmeoiLE9ErdG40dlb9CIKnkQ11Mvmqn+iiruIiW3KlkmNJFq2EZMoAxUDNQxVB75T/UT2drO6L+VHBOKUgasDUfCgWQGW4UfcazEaIhsKGBOV2ogOpeEVet2O29oIreDkqNfqHoh3RBj10wZN0+PdIQqKsJEc9Tzw+KtDg5ytJyIoMJPmNcVbOgnOaWw8r6bqhtfSyv76gqLBWfiAfI9MJUJ8QzgzaE2fJhXBFe7hK6s/X+LokyODBp3CisKFptfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVDdY9/JV8/Dq1ncHCWRTPVxv7Mr4vk8G90QkJjJ01Q=;
 b=xySQ8ta092NKsLtYlG6eAUKLL7PJtFNGXykltylAa57MAGuu2cNsEbOWrLkGeWdfn/JmGDqgZ4YQ09Nx3NHGE5mPrbxZIbUxwlb0qU1MZNqec8o3SSUzg12yl9Ui6RdZt5Cj5+sklI2X3ReMtW0P0eOUpGUsvcCAAGFnUN+9kGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:44:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:44:47 +0000
Message-ID: <79140e5b-65cc-4914-9db5-e37384ea503e@amd.com>
Date: Mon, 19 Jan 2026 13:44:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] drm/amdgpu: drop drm_sched_increase_karma()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260116162027.21550-1-alexander.deucher@amd.com>
 <20260116162027.21550-8-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260116162027.21550-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9f86b7-0dc6-427c-b6a2-08de57588711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amlsTjRmcC9KQnpuamtiQUk0Zi8zY0dRSkxwM28vSlc0elNUbWVtQnZCaWhS?=
 =?utf-8?B?NjRFKzNVVWppc3E3bFBLajBTOWN3Mm5NbTdBN2VCNW5aUmd5enZnRk5EblY5?=
 =?utf-8?B?WVdnL2FBN2RkZlVZa3FJb090UGZnNC84R2pPSXpoemkxTUVzdktzaE1lNGkw?=
 =?utf-8?B?ZWh6NEpOdXpiMnVqVTgvUnNwcnRCdXRKcjNiZ3JMR3hFNWI3NHVRejY2MTJW?=
 =?utf-8?B?ZEozbUZxNFpwa3VRRzNaajVFdmZlTnFzcFFxbUpPTzdydDY2SUV0dE10cEps?=
 =?utf-8?B?dUxINFhUNnVhOTlETG5UYnpDRy9xU2pYcXIvM1pzWFY2SHJVSHg2Zmg0VXQ2?=
 =?utf-8?B?aTRXd29aM3E1WXYxTlE2N3hZd0haNXNidUdRck5rWUY1UHJyNWU3dS96TnRn?=
 =?utf-8?B?WkcxN2wyaW9JcE82MHVFWW1SRUJwcEVzYysveDR3SjBFS2NxMXRSaUlIdG5R?=
 =?utf-8?B?SWdSMkp3TFhXNU1tLzdRaHM2Y1RTSDg1QjA3dncwYnMrV1VEYVMveTJ2Z2hM?=
 =?utf-8?B?amlkdklyWXNZSERPU2J2RkdoMHZYVTdsZFIrWnRuYnU1NWVsWGdsL2JuOXNi?=
 =?utf-8?B?RlhTSjIxSlg0V1l1TExjU1RmbjJPNGorYWgxcmpUWGFuZkhMQzYvMVJTZU1a?=
 =?utf-8?B?U1hrSTRnUkFxeUVSc2F1VXh5d0V0ZWtieFp0L0o3VTA1bFRyaGxiVkM3QkVG?=
 =?utf-8?B?dE51LzY2NnowOVhHYUJJT052b1FTZkVsUmt3UmZVZzNTQmxIUGR1THliVGVl?=
 =?utf-8?B?U1NvY1c0ZkJ2U0M5OHVKaVhYR1o0TFRmdWVJd3duNXg5aHIvSWY3akxDbUVE?=
 =?utf-8?B?eXJMZTdLQXNIODJEVlFweUJMTGlXZUNNMEYrcm5tTmYzR0ExMDBEQmJZUXZn?=
 =?utf-8?B?TVFXTGRETXBVSXRhR1ZXbS9LMHgzN0JDbzNjVWYvM21laUdNd2FtTktBM2lB?=
 =?utf-8?B?d3dTQUJVQlEyblc4c1RKeUtmM0hTeUtDaTlsZDArQlNVQmtNWDZBa2xvNzJi?=
 =?utf-8?B?NmY5MXB2TXlybm5vaEhCcHFtYzZnMTdFZVhNUEF2a0d2VzhIdU1Md29oQU1Y?=
 =?utf-8?B?b3NoNUV1SFFibU9HdWhBRjAvbmdPOGRxb01PcmlmNWpGZmc4a1c5RU5YbFpQ?=
 =?utf-8?B?Q3RqZ3VTQUNFbzJQSk1teEQyZXJwdXhSODF3T05JS3REMlhYNTUrOFRtY1dq?=
 =?utf-8?B?aEVNNFdsQUFqdERmajZHR1JZQ1ZEYnpKbVJzb0ttR3lhVjNNZjkweFRqRE9Y?=
 =?utf-8?B?dlV4TDk5c3FUaHZGOWoxZ3BtUTViaUhJbEdQbTNXNW12TDhKcWJDbXhRTllJ?=
 =?utf-8?B?RzRMbkpkRnQreFVBUFFDVW41OFF0cnJaeTNkSjhXRE90d2lLeWR1cGRSYm1E?=
 =?utf-8?B?aDRZSW1kS2x6dkRzaTR2My9PTXcxMm45d01XUS9wcWdFWWVxQTlRR3R1bm1I?=
 =?utf-8?B?bkFDdmc2N3dIWmxkNFUwa3ZSTGZuR0FmejRoTTJERGNvMmlnUW5IQlc3aWth?=
 =?utf-8?B?YmhJamFCOXhhbTFVWVFUTUM0bTM3RUczSXI3M1B3VFgrSFpvblQ5YUl6UmZz?=
 =?utf-8?B?OWZJMy96WDhMZkxZbW5TTG5NZFN6dm5SYVk2NEFsQUZvdXYvb0JFblVKM0dD?=
 =?utf-8?B?Tmt5SkVUMUE4OGpyM0JRNUpNTWlMSHZCa1hTeE41dWlZQmJoN0lkU1RHZUJC?=
 =?utf-8?B?eEFsOTVheGF6dCtqVk9Ya3pwNVFuZG9vZU9WcDhTd2NJTjBtRjljT0I4akph?=
 =?utf-8?B?Nm9CU0o1ZXRubWpsTGxmZXdJamQralFBeW5RNFh2UkpKZkxIZ2dtYnJaTHF4?=
 =?utf-8?B?MHh2ZVQ4OXZhcjNZeW9ZWnN0Y0U3NXFYaDhBVXdzVEV0ZTh0Um01WWRBZk85?=
 =?utf-8?B?SXZGaFovOFpaMFdYSEdPOWhkNDFsL2dRczFuVkZqNWRWVFRPbkxDT1lKQzBw?=
 =?utf-8?B?Q2c4M3NPMFhMQUNTaVR1TzNyclpXUE1DNS84YXZBaUhBMU9SY0hiQmdtdkdP?=
 =?utf-8?B?QTlJNVhWNUZORVQ2MWJQTWhIVXY3eitZZHY5QnFjSWNJSTJIa1JMeWlTOVo1?=
 =?utf-8?B?MG4zWElyTHZxUGNjeTA0KzBXVk9yb3RVODE4VlRyTkhKVWRwQmltdndiMmpK?=
 =?utf-8?Q?bZRw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0ZHYURyQTcvLzV3Rk1VTmg3OXRmcnU1NVJBQjhPUjJmZ2U5cG1KMzZRT0xM?=
 =?utf-8?B?SlNyNXlydGpBRFhFNlNNUkZFa0dmNWdTQVQ3MlZUWGVKQ1ZpUEY4MjZzQitJ?=
 =?utf-8?B?THlmL1UweVJDZndIY3VPUWlzY2RsRDVRVUpONlU1MkxJR1hod0E0QUlmNGZk?=
 =?utf-8?B?RkducFI4ZGFiTER1ZTRDU1E1a2FKNGpFQTFicE9HZjdubXY0WDNZVmdZalp3?=
 =?utf-8?B?bEZ2aGNVRnoveEpPZk50c084eVg5K1A3M1BaNmlGSlZxTDBIdE91a1ZIWjBw?=
 =?utf-8?B?THBPMTlMcFo1WEhGVlI0U3dlL2JEMS9TOVd0NWxkZUM1KzVYaFFLaE1UakFh?=
 =?utf-8?B?VWxPb1hHY21zZExZMjZNWmVMdjJvdDcwZFUzOGxSU0RYN2U0UGV0SCtGMlNw?=
 =?utf-8?B?dW5oanUxelJGNW0wRnZKbG1WRElGT29jdk93a2Q5US9obnFvWHZtMTgyMmN1?=
 =?utf-8?B?SlErelpra2taaUs4OVIyeFN3aDJnOWo5dzJkM2ZQVEZ6dTNIdnA0R25ZRGxu?=
 =?utf-8?B?Zlo0Zk5oOG5SVWEzbVhJaE5XSDBDUy9BV1ZzNEpKanNqdDVTcTkweGI1aDdB?=
 =?utf-8?B?UGNXZllqaEQvOUFsMUF4YytQWEhTYmdLaUczdlJUTFVlbzdRMEhRYXBBMEVx?=
 =?utf-8?B?bEhXbThyTDBWY3NVaFVwdkRJbE42Zy80eXlWSUpaTVpBOStkMmV4eVpJMU9h?=
 =?utf-8?B?Y240YWVrL3UyejZaWDUzTUxBR2FwYkpXdDlJV3pCSk1iQ0tQdmFvQ2RGOUU4?=
 =?utf-8?B?amhWaUNsQnF1S2JzMWpVOEpFVzVwaFEwV0ZMMXBTelhRMWtQSkdieEdiV1cv?=
 =?utf-8?B?M0ZyQ0U0NEtWczNERFV5R3JTeHovN2lIRGg2WHRJVHRFWGlnU0RKaUpzY1Iy?=
 =?utf-8?B?WldrS0pCVDZkQUplZzY5ZWZaSENyb01iK3dIaW8xVTN2WXdUcWR0eTJZSkNF?=
 =?utf-8?B?alpuckxJZzBnZkV2aHQ2VHpTbnhlTHdJNUl6ci8wMVFQWXdVSlRFemE3Rys2?=
 =?utf-8?B?Sitra0lBY0FjSzBxdjEvc1E3NE5NbXFVRWdGWHYxVjFyellZZFJNNTlvRkdL?=
 =?utf-8?B?MDRmVFl1cGVCcldFMFgyODdYQ3JFZG1ScGpha09RZjZHNUFZWUJmVzFjcWlw?=
 =?utf-8?B?RC9JeFNEQm9UdTV1LzJGV3RUamQ4VUROcGFjZ2tsRU1qUG5VeG4rVDl3UFh3?=
 =?utf-8?B?UXhndnk3V01zbkQ5ZzBoUHM2Z05zdGVwR1JONW5XZVFxTkNRdXFYdWk5bGlF?=
 =?utf-8?B?M1FVaHFURm1BRWhoS0VoZFlMekhQeU1yMTFNWnRVZkZNRS93dUhtc05hVmE4?=
 =?utf-8?B?U25PUmROc3RsUFQ2V0t6ZWpqVXM2dWVsYWtkRmdjOFoyTkNrS1BnQlJsR3BH?=
 =?utf-8?B?RU12elM3N3hmVHFxL3pNeXRSYUw0M1NPTTg1NTRuRmJhNDF2bE9GajkvRjE4?=
 =?utf-8?B?ZndIbmprU1g2a20rUStBeFZNTHZLMHZkTGNINmRjWklJYnJrd29oQzVacVk5?=
 =?utf-8?B?cy9CVXY3dmM0QnFYSU1pNnIrb3hUbVBrQmhqRnNQcWxTeHdES2RkWlhUd3J4?=
 =?utf-8?B?RHdMdE9MWTFudGtkbzlSNzArd1d1Z0ZZbndGWXFuZFF3ZUp3Z3J0Snp4KytQ?=
 =?utf-8?B?S3ZZcTI3OVFmWmdNZXFTa2FaVnhWdWJXRExsTkphTkI4NHBHaHZWR3pJNFYz?=
 =?utf-8?B?NFpTWlJGZ0RZakZibzNTUU01YmRXay9aTi8zbS9ER3VvOEtKbVRXazlkbEZ4?=
 =?utf-8?B?STE3Z3VhY2JvS1ZFWjJEekhOSml1Z3hYbytxZllaVGZ4QW5TMGtkLzIzaVV5?=
 =?utf-8?B?YVNVRno2OEVINmZhb2xZSDFrWnl1OVhaSmIzaitWVHJMbDNZb2Ficm5Bc0Jk?=
 =?utf-8?B?YjMwcWRuM1lGZStwMVRiUzN1NHVxODBMc2NHUjhnVWcyZ1ViTkVVZ0pHUkUx?=
 =?utf-8?B?RTJab3VzZHg1Y0Zwb0Rva2NyTFVJTDI3d0loM3o5UHlHMmlhYU9HZWJPMEhq?=
 =?utf-8?B?cWE1Wkc4VDVnQnZpdXlheDRkd0RZVzVOalRLaFhqa1dsWXJ2dTduMUcydEd3?=
 =?utf-8?B?TytJam1YN01UczFNMm5VbFk1S2g3Q2FhZnNSaGthY0JGUHQ3WnhWNi9BdWg5?=
 =?utf-8?B?dDFOaisvNGZPL1NUUE1UQ2x3RXIyRTN1bDBYQnZkZGEraC9KZ2hodDh4NUJD?=
 =?utf-8?B?NnE4STU2TDhNY0NzMjhCdGdDMUhUMG9HMjVaQXR5VUFQb0dQSk9kT0VkQzdF?=
 =?utf-8?B?dXp6Y3VGQlhoZW5zTE5RcDVad2hjaTUrUXFZbGhFZW9meWx2UmlKa0VlcFlG?=
 =?utf-8?Q?zzJfRSN8bSt0nuJ4Cp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9f86b7-0dc6-427c-b6a2-08de57588711
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:44:47.0772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNIv1OBpYXZWVQhCfphIznY8hgVHnr1A3Q06eZSinXnb5G+oXO6pkNvwXXrisTYu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968
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

On 1/16/26 17:20, Alex Deucher wrote:
> It was leftover from when the driver supported drm sched
> resubmit.  That was dropped long ago, so drop this as well.
> Leaving this in place also causes userspace to treat
> the context as innocent.  Removing this fixes reset behavior.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Looks like you didn't saw my earlier reply.

This won't work because we unfortunately still need this for the AMDGPU_CTX_QUERY2_FLAGS_GUILTY.

We first need to fix that one before we can drop that here.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ed7f13752f462..70faf914b4f0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5817,9 +5817,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>  
>  	amdgpu_fence_driver_isr_toggle(adev, false);
>  
> -	if (job && job->vm)
> -		drm_sched_increase_karma(&job->base);
> -
>  	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
>  	/* If reset handler not implemented, continue; otherwise return */
>  	if (r == -EOPNOTSUPP)

