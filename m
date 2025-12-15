Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52843D5B86B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 20:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F3410E513;
	Mon, 15 Dec 2025 20:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nZcNgZW8";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013047.outbound.protection.outlook.com
 [40.107.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A3E910E513
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 20:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FM3CcLvlMhxUNQKwsWhXaVbDSkf9/d6o4YcpLNlLwcupSP5OYwU1ao2bAaKzjYtTr4JO/L23Up3ivsTf/nmlAvmIyQwlvZYJ2i4/2e8mIrRvfWKbuHfhjHl2/YNPciOD+PlRDup0Vsd/KPA1TJbwuDq1hy1oj1KjIpzb+8Rb2hV0EEDsuNRvmabV0SoXQXLerVwKdQCStKZISGqReiBChyQAIaLT4FO2ZFM3O1FRzZgUqCGxq1hzbrWamBxMCHsPNVyYytB0ivt2Ktjb3DJnbXwdehb43sIeUEUr7Qxxo78itaKz2v83bDEelpdW8l41Cx1o0EQmn0cOfp5QNQRqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC+/NaPwbxDWxVJ7ZDNsIpGG+TFBZfYlcyxgqox6nJg=;
 b=dapZhEOSPG3hTlL4PFVCnwL5P5l4/RLm76L+jBhh3TJ1t1yvqNz//x8r0FCJ/g3Zw3gOZ7g3BRPlAmLKh3XNUK947M4IWlkEGvZEy/zzgEKz1maMXmyEhWjI3Nw3C4/DZkkqE/Bk4yYaMfx3CU0nmKy1m5g77WNli2UJ1L04QX5H4GKfbJ3kNdLfRRJ7JQOAG1atORYrgPC2tefEhHJ8t1GPDljOH3Q9UF5qVUu7+mFUoF0n/Bm8ev9s/2miucYPShzM5PZnJ2LzdtLGoWnKyk667pHe94rFIb6QOo+e4LqstLkC3kOwqY6xfn++U+EPz4j0T/7lTtmOMPhCHQFC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC+/NaPwbxDWxVJ7ZDNsIpGG+TFBZfYlcyxgqox6nJg=;
 b=nZcNgZW8lTlTIi8YG1QiLIfJJwjTES1s/1/hKCyYfRNdEDvjwq3XVzdU2PlMAGaRXiYdXkuE0e69wZH2TeD8ospFpPu3/+jJQ+bt/6ekwMPBayKm1ZBXjx8qBjkSx9wdmqkGsqzzMOWvPmEohyFNWYtNns654cfTmSv5rkhEHZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ5PPFB332093D3.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 20:25:10 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 20:25:08 +0000
Message-ID: <64013bb5-9510-4a29-873e-b23d59c494db@amd.com>
Date: Mon, 15 Dec 2025 15:25:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/8] drm/amdkfd: Relax size checking during queue
 buffer get
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <afa131799094e31bc6180aaa310cbca38185635e.1765519875.git.donettom@linux.ibm.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <afa131799094e31bc6180aaa310cbca38185635e.1765519875.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0048.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ5PPFB332093D3:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e4cf45-a56a-4771-4b49-08de3c180a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1VVSWl0QWtVcEFvMVQ4aUhCdmJUcVp6QmRoejBkVWkwSE95dmc0NTVtRnpF?=
 =?utf-8?B?WTNqZW5WbVdJTXVFSFN0aVlRQ2kxdFh3UzJ2RzEzbVFIcWhFd3VLMFhqdEJr?=
 =?utf-8?B?UWhqeVhVN2doMU1NZGJWT3JyRjYwUUQ0VTk4QkRnQlZNcCsrMEFkdm95VWdW?=
 =?utf-8?B?QWxJcEtXbXFaT3JVUzlhY2dGdUg1ajhWM3BSMTA5WkZ6T3M2Q2E5NFdLaGxo?=
 =?utf-8?B?NHd6akQzSGlMZjBEeTRuTUxnMklRODdOdmFyMFhRYURIemR0dkwrbnBCcUE5?=
 =?utf-8?B?ZmZLdHFONExkTWJpNmZERjFGWk5XRHd4V1c1V2ZaK2tNeWg4RndtVVlMM3Js?=
 =?utf-8?B?U0c3bEV3U0dFWFdYc3YyZFlMbmtqR1ZHemMwd3k4RWRoVEdoOXhuK3dvZGVF?=
 =?utf-8?B?bXp2T0M1WkxoVkFEcUVsVGlheEFja1h3TXFvRFhNeTFDeXMzVmdvUkdmQy9i?=
 =?utf-8?B?WW05TWJhWEduNGEveDhBMS9GUkdXR01zZ3VRVXhYelNBeUQ2NksyeGR2dk5H?=
 =?utf-8?B?ZWhFNUM2dkp2dGlSSnZPb0s0dW14SVRkaE9JYTF0N2hUZEpHdlpBUUwzRG5p?=
 =?utf-8?B?aFdXWVVpamd0NmRJaEJVM3NDN1M5QjkwQWd5OUJ0ZlVwTjYxRE5OUDFob0dr?=
 =?utf-8?B?Zlo5TDRxdnZ2dDFBbTNBYWpiS00xaWgvU2NmZHN2NTNCZ2VKYS9nSk15M1Ux?=
 =?utf-8?B?eG5IWWJYVStNVkR2eGFYMko0WU9YcVBDOGhXR1gwTGVOMll1Qmg2cEFnZmtK?=
 =?utf-8?B?dklWcXI3ei9VYlBNOGE3M0FweUMwTm5POU1YNzcxeVRvL2RCWjVvZFBzeGxV?=
 =?utf-8?B?RGVUU2JWTk1UVC9qMXVSN1ZSZHNXU3dMZFJieEtZMWVUT3BrYjA4czRHYjZ6?=
 =?utf-8?B?Q2Fvb2VpTUFMaGFlVDQwNTVVMmVURnB5RDNpTjhoQUhUU25vLzlKMUNpU2xB?=
 =?utf-8?B?OFZqZVNNemRpUDRzSzd4MkJ1OUpWeEdaM0EzQ0hrTjhTaXpUbkFvWUtQU3JW?=
 =?utf-8?B?R0R3eVhhaklHczN5Uk1KMm93Q0pCUnhiR2taNTBOVzRxdXJybTNQT2pFVk5N?=
 =?utf-8?B?enBHNkM3ZTZ4TS9VSnF3bEZMSG9oYWhIUzFoU1FvL0syZ3BiMTVmQm9IYmJR?=
 =?utf-8?B?blJiUENhOEp4ZE9vNnIwUURHRHBzaG9jaUwzN29xbC9laGt2OG5NT1QwVmtJ?=
 =?utf-8?B?cVZNa3pOYUNoUzYxWEhPTWtnb0xsc3lhUXlYalRObzhxajcrRjlsTmJkdTc4?=
 =?utf-8?B?V2NWQ004R3JUTnBqenZ0WW80UHA5RUNscXc4RGNLZTZmTnFRY3YvNnpnaTI5?=
 =?utf-8?B?L21kMGhoS21xR1JwdjlJelZQR0NjTUUySnpzZUhOcGRzdkZOUWhtSENyLzR1?=
 =?utf-8?B?Q2hpMnI4eDlGVkZlU1M1aklhUjR3U2ZsYVJoTFREMzBGemxjYmFLanVFSlZC?=
 =?utf-8?B?NVIrR1NZVDVDZEVoYy96YVpKK2MxWU9CUVduZ3pxODBrZmNBUlRYVFIzT3JH?=
 =?utf-8?B?WXRVNkVNUzhSdGk1L1YxcnVYWjJDR0F2SnNJZEJURlNvNWJKTmJmNGVkbVVt?=
 =?utf-8?B?WXRPZWhzTXc1U3g1aTcyWUpJanRYV3NqSm9pYWQ2VTIwb0NNUCtpYjV4NnBn?=
 =?utf-8?B?WWlETHZEbktWcHIvQ3N2L3p6N0ZXSGJrN0xucUljaHpNZzZXM2p5K0cwQ1cr?=
 =?utf-8?B?b2l2em4wWGlDYjNEditXQU5laUZqQ3NzalZRcTVFRTBhSlNESG9QUXFmcnBX?=
 =?utf-8?B?VkEvVUhkYXV4TlJJS0JjOC9yUFpsWW1zS1k4WGlOVDFXRDlKbTJyQkQ3b2lI?=
 =?utf-8?B?R2tVS3d2dEcwL0N6U0c0WFlOTjZsdVc4cWpXbGZBWkl6K1gwYk9uL1g5Y1FK?=
 =?utf-8?B?L1NnZVlGSXNmaVgyZEowR2RJSTlqSGVMRU5YWm5wdWdpanBVVHkwUU1Ldlg5?=
 =?utf-8?Q?FinBjPQuRxkReEz5jRRCXTMPA6PbfYOH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1hjMjdEV3NCQ1NGcVhJZXFCYzJpMU81eXdlWDQvWWtWZk5QeDVrQThSd3ZT?=
 =?utf-8?B?YlhtalhkaUdPQkZYeUNXcGRVOUdqcllMRGcvRnJ4THdHUzZKOUs2WjlqaGFV?=
 =?utf-8?B?VkE0KzlpREVRV0NEbWdKbEVRU0ZKbU41QzJRa2pRaVNVaENFRy9FNFFONEVC?=
 =?utf-8?B?L0k4R0pwNGJFdVpTK0tQVGV2c2E3ZEl1MElIWHJqRVBMd0VLSHlBa3g5azlx?=
 =?utf-8?B?UTdMY1pNRzU3aERvNzZIVDVHbmtvVkpQZnlvSHUrWWxXTjYwRUJlcVpPTDJB?=
 =?utf-8?B?V2JHa0xjOTFiUmpwMFRLbkVKTktud3JMTnIxRGV3Mis4dU1RSTlMSk4ybEpy?=
 =?utf-8?B?WHNEbllMTFJJSW5hRmR4UzBrVTJXLzltR1hYZzN4N0wvZU9qdHdQS2ZsM1J3?=
 =?utf-8?B?N2dCTmZEeXdoN3MvTGRTZXpGQnU3VDAxbXZQd21kOEpZaThYTlhOMjRvTkJU?=
 =?utf-8?B?TVNoZ1o4UVdMdjlyTnRWTXVIbE84c3pVODJ2b0JTMDVJaGF1R08xZ0IrM0w4?=
 =?utf-8?B?aHFyaHJkT3pMS2xtYkZEVFlsb0xPaXhpOUpyTk1qaXl6T3l2eHhZYUtuYUlO?=
 =?utf-8?B?ZDZIWDRPMmZvU2g2WFpSdUpEYTBsSmIwNVRhVGJESVc4NUl0NUFHdmlMRHZK?=
 =?utf-8?B?T1RZS0lSK2ZnRlJaakppdVFJRTdHRXY5UHNIQmMrdlA0MFlaUkNoVG5jS0h5?=
 =?utf-8?B?NTkrbHQxSFZpMkYrOWhFNGRHYStrRGNrQ0xydmREZU90OE5ab2VQa3p1OGFZ?=
 =?utf-8?B?KzlXNWlSYUFDTndmd3FteUxvUVBUZEpkSFZkUXJGckJUSkxBL0dCSEMxS0Y1?=
 =?utf-8?B?eVNWWmhtN3BaeUNWdGtXWlpuemZIZXFxcUcxK1VUS3FjS3Z5UEl2OU51R25U?=
 =?utf-8?B?Yk1MZlE1emJWb01OdFFFejVxc0xRVFllaTBRM2w2SDhjRDFGZFNYQ3BoLzVy?=
 =?utf-8?B?THVhbFVQNitsMHVlNUZpRnFQOHNJbjBocVFOY2RPdHhtKzlBUU8wMGVwajlk?=
 =?utf-8?B?K3YycCtFTU9mKzdsWElMa3hoV2hicUg4WDFiVGdLOEdkUUxqaC9GeU5OK0pK?=
 =?utf-8?B?bXZxUEQvRnJoZ2FwQlhTNW9yT1dOOTNFcC9wbDBuMDc4TXpyNGR1UWlQR2U5?=
 =?utf-8?B?MGplbXg4WkdLbVZIaXJITElsa3dJV1ZNdjJGaVZBSXJ5b0xQVWx2QzNzbWJD?=
 =?utf-8?B?VUNxUFRaUzlyYzFQZnRIdlBadzJSeUJEdlMveDBUWVpOSWMxU1g4alM2dDgy?=
 =?utf-8?B?TUlYM3h3U1FEQ3EvbnNPbnVxb0FZMzNvOWl5cEEzU3Qwb0pDazRUckNHT0Zo?=
 =?utf-8?B?N2pvbVl6K2xGRW9vVjlEUnVCNmJTdkcrMWZqWC9UaUk1c0hTR29GSlVFdEd3?=
 =?utf-8?B?Zm9ROHJZc2k1K05wTWNvbnRZeG9EVnZ0T2QxcjVPTU05Tm1mMjlXVVV1alNt?=
 =?utf-8?B?TUQ0M21ubHhNKzFER0ZoeC9VdVVEc1l4dzFvYVozQ2F0YVhhUHJ1b3pMRUxh?=
 =?utf-8?B?YnMyVzJYZUtIQ1hRMjU5OVdmVzN5QnI0V0FNMkVrdHMwbENMVUZEaEROdWta?=
 =?utf-8?B?TGYwaWR4cmJvbFpZTnJoRldab2d0ckxQRHlsejRuM0pTanRIOVkzekpUR294?=
 =?utf-8?B?VlJyV3dXZWp6NE5vSE90WVNLdGJ2Ykk4cGxuUFEzZkZXRWNoN3d1OHZES3Qv?=
 =?utf-8?B?eTJSUmpHcmN6VEdYeDFzbEErdTJNTnFodUIySmpDSHhHTytIWEozMTZpU25X?=
 =?utf-8?B?ZjlzeGpHaFAvenZNZ2c1LzRrMG5JbVNkbXVNVms0SUhEeGRVekR6MW9XWUpM?=
 =?utf-8?B?ZGJ1WXVLcnIySXFGMGJTeW9wOUZadmpxTWdlQUpYNFBQdEJhUFIxVllwcHBU?=
 =?utf-8?B?SDV1V0lPZEkreGY2aERzOHNsYWFsaVJSR0dONFBoZGVCUktmT2tHTWhjcEpO?=
 =?utf-8?B?OGE3czJKa1pDa2swb3NteEhXcG9qMERGM2txWTVsTHJleGI0b09SNlBoWVN4?=
 =?utf-8?B?T0dDRVVNTXgwd0ZaMEd6eEhpcldkWGRUZXh2VzNTUGRlR3k4NVJEZzA5NTlx?=
 =?utf-8?B?K3JrTjlHdE9RYm52UEZ4M2lqdngrcW5zc1hhanVkVjhkb1ZWZVZsWlRYY09O?=
 =?utf-8?Q?ieFU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e4cf45-a56a-4771-4b49-08de3c180a24
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 20:25:08.4650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrLx2NER+NYox1saaZwPCsj+SI5kYKMEQsoORAnrUDgAMkkHJeYxq+UzCaiPamHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB332093D3
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



On 2025-12-12 01:40, Donet Tom wrote:
> HW-supported EOP buffer sizes are 4K and 32K. On systems that do not
> use 4K pages, the minimum buffer object (BO) allocation size is
> PAGE_SIZE (for example, 64K). During queue buffer acquisition, the driver
> currently checks the allocated BO size against the supported EOP buffer
> size. Since the allocated BO is larger than the expected size, this check
> fails, preventing queue creation.
>
> Relax the strict size validation and allow PAGE_SIZE-sized BOs to be used.
> Only the required 4K region of the buffer will be used as the EOP buffer
> and avoids queue creation failures on non-4K page systems.
>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index f1e7583650c4..dc857450fa16 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -199,6 +199,7 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
>   	struct amdgpu_bo_va_mapping *mapping;
>   	u64 user_addr;
>   	u64 size;
> +	u64 bo_size;
>   
>   	user_addr = (u64)addr >> AMDGPU_GPU_PAGE_SHIFT;
>   	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> @@ -207,11 +208,12 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
>   	if (!mapping)
>   		goto out_err;
>   
> -	if (user_addr != mapping->start ||
> -	    (size != 0 && user_addr + size - 1 != mapping->last)) {
> -		pr_debug("expected size 0x%llx not equal to mapping addr 0x%llx size 0x%llx\n",
> +	bo_size = mapping->last - mapping->start + 1;
> +
> +	if (user_addr != mapping->start || (size != 0 && bo_size < size)) {
> +		pr_debug("expected size 0x%llx grater than mapping addr 0x%llx size 0x%llx\n",
>   			expected_size, mapping->start << AMDGPU_GPU_PAGE_SHIFT,
> -			(mapping->last - mapping->start + 1) << AMDGPU_GPU_PAGE_SHIFT);
> +			bo_size <<  AMDGPU_GPU_PAGE_SHIFT);
This change works, but also relax the size validation for ring buffer 
size etc, this may have side effect,
for example FW and user space should have the same ring buffer size.

Other buffers already use PAGE_SIZE as expected size or size aligned to 
PAGE_SIZE, maybe only relax the eop buffer
size check

@@ -275,7 +275,7 @@ int kfd_queue_acquire_buffers(struct 
kfd_process_device *pdd, struct queue_prope

         /* EOP buffer is not required for all ASICs */
         if (properties->eop_ring_buffer_address) {
-               if (properties->eop_ring_buffer_size != 
topo_dev->node_props.eop_buffer_size) {
+               if (properties->eop_ring_buffer_size < 
topo_dev->node_props.eop_buffer_size) {
                         pr_debug("queue eop bo size 0x%x not equal to 
node eop buf size 0x%x\n",
                                 properties->eop_ring_buffer_size,
topo_dev->node_props.eop_buffer_size);
@@ -284,7 +284,7 @@ int kfd_queue_acquire_buffers(struct 
kfd_process_device *pdd, struct queue_prope
                 }
                 err = kfd_queue_buffer_get(vm, (void 
*)properties->eop_ring_buffer_address,
&properties->eop_buf_bo,
- properties->eop_ring_buffer_size);
+ ALIGN(properties->eop_ring_buffer_size, PAGE_SIZE));
                 if (err)
                         goto out_err_unreserve;
         }

Regards,
Philip
>   		goto out_err;
>   	}
>   

