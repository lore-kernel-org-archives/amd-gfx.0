Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E2AC3600B
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 12:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F54C10E3E7;
	Mon, 31 Mar 2025 12:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N5wo59Ql";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E5610E3E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 12:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCNrXZ6g9S4eOjgGrXbU3+XRR6kIUfF3JAaAsq/XSRnBcCiU1LbBsfjCPGxeRLLgyOv4UT/rfEaN5xbQbmMug/lR1/Lt4bpiAM1zzZcwocjnn2CYSnsXJpP3srlJ4fqLEDrmztqPcmRjZl/IBpT/Ng32M3GZsn4hnEgsi/9Gi6JylmMHltuH3srHDO5KZm1dVJjQhi0xDGIatPJIMRicHzK4wFfn3ISkRwU9dXMTWC1v0ycc4tCfCJ88HP8jhUodohondQvlKuSS+BMJOBDa/+5vMszQvsUyWweHeEwO3ijV2qm6fgmqufdXfuyaLCEfPhXFZZDG36zgDqh8cGWvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX9chJqGcZnfKuTyuptt118Zw74qfrv/DPX52wywpnI=;
 b=RXhtw+xZN3J1+MibSNeiIpAVSVvIFUeFuFN1eyHkoi3ZgjgFupFaMWQrLgsXHo5epjGozD2VGBn3hdwsES1XNEbxnyNFT5M1NttAhkMZrJv/NUcotjfPYJv3ycT3nH/dpqlXu2c517TAOnKqivREbkscPKjfmvg8q1MwsDq7oSEL1emch+f/3WIJa3JqeSQs3xIJFNyT/41hoSaYmmj8GoLNvRZ7WvUrRecT86lEqEXfepTLVx7d1brnDLTyqcRI4r1Hrfk6a6K7MfZ4/pHSVVRpzDQ6Yxnc61vzfkYhCFLDtTOqzbWzQflLZYmOddtoK3r0OOy7hxDOPFLPXvH15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX9chJqGcZnfKuTyuptt118Zw74qfrv/DPX52wywpnI=;
 b=N5wo59QlBrEE1FrQjYejTMERjPL8k6dKLfbO6+/CuWp4CXfZuu0ncwgLprUqcORoGl2NdOp5nM88XLY8LkddXksqImXbkCF3UatgFgBr/d5y6223v76xWludKEJJazs6Ak3wclgW9KNJal3LywC96Z3yp8BolSojIF/wv6ttRfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 12:14:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 12:14:26 +0000
Message-ID: <682fa469-b0c8-45ed-8477-ffbd37c81a63@amd.com>
Date: Mon, 31 Mar 2025 14:14:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: allow pinning DMA-bufs into VRAM if all
 importers can do P2P
To: Alex Deucher <alexdeucher@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Pak Nin Lui <pak.lui@amd.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
References: <20250109165756.26401-1-felix.kuehling@amd.com>
 <CADnq5_N465Z58E9EroVDMtx2E=cAhGbJgC=TE6BhCsVdptwcmg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_N465Z58E9EroVDMtx2E=cAhGbJgC=TE6BhCsVdptwcmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2c7146-1994-401b-288f-08dd704d9453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWZKaVJuZ3BsNWZTR2RXc2Q2b2MxcElVdGhLWXFiTWc1WmREVnowWGlKVCsr?=
 =?utf-8?B?eW5lcGNBSjlaY01ndllqZzNOUFlSaHpXLzY3NFVjM2lWYXVDZjEyZGlSamor?=
 =?utf-8?B?NytiVkcyNVFzRW4ra2RBeE40UG9BcVlMald1UER5MFEzMzFtT2ZVRkJ3Qktx?=
 =?utf-8?B?cUJxemlHM3FZUWlKL3RudTJ6YzJVbUFkckFubUk1M1hJaWRycE8wQjZVRk9o?=
 =?utf-8?B?TGtyNjU0U0N0dXIzOHA0WGtXQk1CQ05haStoVUQwS3Bubm9yOTRZZzEwbnNW?=
 =?utf-8?B?WmJMWHJlNGl1a2lzdWZ1WDVkdUM5aVhqcEJVM1Q5VWd0Vm1qMCsvTUpCbCtn?=
 =?utf-8?B?d2poMjBleVMxRlh4QVB0RFhpai8rSGswRUF6SitVVWZlSmFDSERjMDZuZk1N?=
 =?utf-8?B?dGlmeU1HOVhPRVJGZFpLczBFcTNXUm5kaFlrNENZMHpNVHFFRHpnbGFtWnNt?=
 =?utf-8?B?ekNJcHc5aWVoT2NpZDRXRmk1TFN5V3FuanV1anBRejFERld6akV0M00vWFJw?=
 =?utf-8?B?V21vcjMraTZKMDdJR1RCVENjblZsUEZDMzZuZEtZaG9qNFV4U0F4THg1UlhV?=
 =?utf-8?B?QWdJem03aXFtR2krbndGS29CTit3MWtiMDZmQWp0c3FvU3poMU9tazVvSWlZ?=
 =?utf-8?B?UmJTRWQxOHkyT05ENVJrUzNIRXhBd2RjczV3S2JpS2MrUmt3QkhsMWpqSVk2?=
 =?utf-8?B?KzVZWGY3TVlxMXREUCtkbVVQcFRibEZWcDlNT28rTzhja0hXeUlqV2pXd0d5?=
 =?utf-8?B?M1VzZWNsZjRIWHMyU2NnZm9lVXJBdFlLcEJoUEhJNW5Gc1h5YmsyMWVGRDF3?=
 =?utf-8?B?d2hqWlBSQmRHZWZBdU1CN09wNVFhNTBhMHV3QnFkcHNjS0U0UXlhdDR6dFJF?=
 =?utf-8?B?YzFEaE85RjZxUEUzQXNQNEhTSyt0ckluNno2WVErclpnVTdQeTM2N0NzSHZL?=
 =?utf-8?B?Zkc3TXNPZWxXVnFtbXErMEFyc1BlWStVcWpGZmtpY3I0UmtNc01PQjl0MnZY?=
 =?utf-8?B?RmFZaE1WUUtHdDc5U2pCSVlNQ1pzRC9VSm92UmdmanhGUVBjZjd3Y0pEbTM0?=
 =?utf-8?B?dGdSQ0ZEeGMyUkxzM1lEOHNaem1vNGt2d3czd2l3NUtIVDl0OC9hSDFVTXVP?=
 =?utf-8?B?VERERm9adVlSSnVFM1FYK3AwSlBVY01LcndZank2WEMrZ0RPRGpuUDFsVzhi?=
 =?utf-8?B?VFVxNUpSTFlVNzN3YzdBQWZ3eTdKdjc0T0pqWC91eGZ0ckt2RWRkVm5RRXFz?=
 =?utf-8?B?T0lTRHI2MFNTQytKVDNRTHdDY3Y0aE1EMTJ2UUh1KzR6ZFBQSCs1V3ZvTk5F?=
 =?utf-8?B?aFNyK3dtZElVbG01Z1dVNkd5WFY3cGgyQUd6SDJWTGt5WmNzTFVZUEhCL3Fi?=
 =?utf-8?B?WTcxRktqNlY4SW41ZEp5d2NUWjg4REpDcFdwaTlOdFVFTEFIblF3cjgzKzZR?=
 =?utf-8?B?cDJpbUtheHhaQWlWRStZL1JzSDE0U3pTbis4NUxyU1pFSFNhREp0SkpWK1p3?=
 =?utf-8?B?WkhqZ203UTdCWWF4ZzZ3VFdrZ1dkaGFtQXJBNEVkTERIdzA3V2h0MHNuVG5l?=
 =?utf-8?B?cmw4ZzBQZFp1M0wzVUxXN3Z6cXg0M004M2NUL2sxOHQ3U285RVo1amdSaFNQ?=
 =?utf-8?B?SFBxK01uQzdKYUZYam1rdExjOFgwVUZGbXN2TTNDRGNacUlOQXBRSzJnVWFG?=
 =?utf-8?B?UHRObDluVXltLzBYV0w4V0FLeDQ4Wm11bDR2WGJYVTdqb1RvZVBKeUxLOEx1?=
 =?utf-8?B?ak4xWGpxNUt0RzNxU0R5ZkxlZ25OMERjdkROYkhPbkRVYnJCTXRUQkY2RmF3?=
 =?utf-8?B?V1E0a1piTk44aEt5TzlBOVJScElWZHJlUURmNUlkOEdpUnVKdXNrNVB3UWY5?=
 =?utf-8?Q?WcXpdt0/m8tct?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHRoeisrMWl2dTZmTm4wWmxkeWgxaVl1MFU3RmdOQ0xpRWFoRTdOL05Feklz?=
 =?utf-8?B?Y3piZUhPb21HOUFUMWZ3Q0JuRXkxRjNxM1BlbFlXM28vTXlMSDBNUjBIUnBk?=
 =?utf-8?B?YVlJT3dOM2N6TVNNdEVGSTVJekFieHVnZEFWTmswUmVWNi9PUnpIMVhYN0da?=
 =?utf-8?B?QzRZOWJmcXdGMFVLUU94U3ZiUzFPNzcwMmIvTTJpclgwd0RaclQ4Yk5PV1hI?=
 =?utf-8?B?d3o4aWNuRWNYU2I2VzhEOGRwdDhoOU44UTNJMjlFTjNuQkZzd011ZnM1Qmg5?=
 =?utf-8?B?TVdvL0ZXNUpESUloRG5VZG16MXRadm9ZZ2RpTFhDQUxqQkY2Wko5blp1Znhj?=
 =?utf-8?B?RTR2T1hST3B3eHlQZU1USjJhNE5ybGk5Vk04WnIzWFJNeFNjV1R4ZWIwcnpt?=
 =?utf-8?B?Q3FEaGtueHBMclRDQlp3aGNKRlNhV05iWTFmK2Y3VlR3RTZXTnprRWJ1S2Fq?=
 =?utf-8?B?L0tQYTFiZ0JsUWtsY243d1pNSGFuaGIxZlA3d0VXenJ5MzlLZWM5RmFaQ3Ft?=
 =?utf-8?B?ampQSzN3Zmp3eVNjdTlya0NVSld0ejNnS2t6S1d3bnlvdDVHQWt2aDNnSEZE?=
 =?utf-8?B?ZkhOTlFLSjlZdjJja3JHWG5NTTlyK2xyaWpqVVljdWE3U0ZQNGJRQTkrWUtt?=
 =?utf-8?B?RHpWeWtYTlhCUWd0MEp5bzNneWdpZytZSU9VQVVCWjNJdzZyRU1YeVJyQ0hY?=
 =?utf-8?B?WUhKcG81b3BZWU0rYkRDK2oyemcvYkh2d3BzMm5SaDBMRG82Z01oYlJGYXNL?=
 =?utf-8?B?blRBcWFYbUp6cFZ1TXpaeTF4MHE3YUc5aUJzSDR5N2ZnaTJ4M1M1bHNBeFJn?=
 =?utf-8?B?NHEyWE5Za1dsY3hOQzdOUGx0UmF0QXhzK3k0TkhGdkdDMXM3SmZzRk9DcFph?=
 =?utf-8?B?cC9DbmpFVFBWMUQ5NytmeGdnQ0FGV0FQN24wY2JJeDBhc1RJRWZ1RDlzK2dn?=
 =?utf-8?B?WmZVZnlOWDk5ZGVNN1ZxVG1VWVY5WGFTZGJWK21BY2V1d2ZWa245YW14T3E0?=
 =?utf-8?B?T3Q5WktPdWFqVTlmcXBQTWFtZVUwUThsOTF3c1FkeXBoajVYUXQ2aVFzaG9D?=
 =?utf-8?B?Zi9VSVFMS2hoMmFhRjdEdmZEbGdPV2VyVkFlZ2tPYmNCZkxMNkJrem1leVpM?=
 =?utf-8?B?N3hRUlE3Ulg0MVFpN0t6WTRKZmp3cktvTlpjZlBTdzZ3aDBHT1BFeTB4eFY2?=
 =?utf-8?B?VFZON3lySzN3YWtRdDJGUWQ3ZEMwSXAyN3dGRjgxQVZMUnpzYWZ3ZW0raDN6?=
 =?utf-8?B?KzBuUFV2ZDljL0pGUFJoZHRySEp5a1U0SHI4T0JhemVMWlNDUkVRb2JJMjZC?=
 =?utf-8?B?N1ArMXhOcFJVUis3Wll4VXFjTkJQOHhHU1cwSjNDVzk4ZThHeUdTSldPdHhX?=
 =?utf-8?B?c0hpNlBxWThtaTVuLzd2Uk9NTldqMVhMbEZ5NzRrOGxCK2xRbys0Tmd1R1BE?=
 =?utf-8?B?WTZDVmRqakhYS1BkZU56ZmdUNHdGNUVDNlFCclhNZzFQMXJLRFVoVnlhdm1W?=
 =?utf-8?B?T0MwRnVhNksrcWs5ZFg5U2xGWk9qYjB0RzBMR1JQbDRTdm1MUi9GQ2xlM0xp?=
 =?utf-8?B?WFIySmNOaDZrVllyZ2EzWXpwR3RHenBJQlBOWUhCUkYxNkczSEpPV09uUVU3?=
 =?utf-8?B?cTUrbkplQUIrT0dzTVBIZG41bjc1TDhJT0plaGc3WEhHOHI4c2ROLzBCRlBa?=
 =?utf-8?B?VWovVGhzazNlSG9KNmN4blVWaURpYW4xUDdSN3pVZ3JFTmZ6eEN5d1hvL2M1?=
 =?utf-8?B?TFE5OWRXT2YvNmVvUDJqYk5yZDJLd1FwUGNQS1ErMi9GRzdOaGJSSEVWcHpy?=
 =?utf-8?B?bjhqUDZzZHZGRTE2T2VJekJLdnFuSjNER3lrZ2JudmVKUnhsMlJzOTZUa0Zx?=
 =?utf-8?B?VnZ6RDRiT3lNc1lkaXRhaFpXRXl1MTh3czcxZ1A5N0x2Vk5oamdjR1owbm52?=
 =?utf-8?B?VDI5aXdGT3VnKzBsVGZJY2RHL29PT3pMaGgvSGxwamo2dTloNGt5SWFIQXJY?=
 =?utf-8?B?T2NjTXVZQ0xaN2p0amh5QzY5cjhaZU1sWld6QkJCcmttMmdkZ004ajk2ZVk3?=
 =?utf-8?B?S05mOXhvd1J4RG8zaWZSV3VLYU5sL3d6aWk0K25VWks4dkZwS0RxRCtySzA3?=
 =?utf-8?Q?kVFyt6IEz1N0schXuWuM4+d9A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2c7146-1994-401b-288f-08dd704d9453
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 12:14:26.1265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLE+dWUfurR5+KBvX5pkRXmVDqEe7vAJyzPXkUbWIvJGLGk3zckEGhJ3JVxNNK+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315
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

Am 28.03.25 um 20:14 schrieb Alex Deucher:
> On Thu, Jan 9, 2025 at 12:07 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>> From: Christian König <christian.koenig@amd.com>
>>
>> Try pinning into VRAM to allow P2P with RDMA NICs without ODP
>> support if all attachments can do P2P. If any attachment can't do
>> P2P just pin into GTT instead.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>> Tested-by: Pak Nin Lui <pak.lui@amd.com>
>> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Applied along with the cgroups patch for amdgpu.

Nice, going to update the internal people as well.

Christian.

>
> Alex
>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 25 +++++++++++++++------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index 8e81a83d37d84..83390143c2e9f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -72,11 +72,25 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>>   */
>>  static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
>>  {
>> -       struct drm_gem_object *obj = attach->dmabuf->priv;
>> -       struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>> +       struct dma_buf *dmabuf = attach->dmabuf;
>> +       struct amdgpu_bo *bo = gem_to_amdgpu_bo(dmabuf->priv);
>> +       u32 domains = bo->preferred_domains;
>>
>> -       /* pin buffer into GTT */
>> -       return amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
>> +       dma_resv_assert_held(dmabuf->resv);
>> +
>> +       /*
>> +        * Try pinning into VRAM to allow P2P with RDMA NICs without ODP
>> +        * support if all attachments can do P2P. If any attachment can't do
>> +        * P2P just pin into GTT instead.
>> +        */
>> +       list_for_each_entry(attach, &dmabuf->attachments, node)
>> +               if (!attach->peer2peer)
>> +                       domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
>> +
>> +       if (domains & AMDGPU_GEM_DOMAIN_VRAM)
>> +               bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>> +
>> +       return amdgpu_bo_pin(bo, domains);
>>  }
>>
>>  /**
>> @@ -131,9 +145,6 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>>                 r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>                 if (r)
>>                         return ERR_PTR(r);
>> -
>> -       } else if (bo->tbo.resource->mem_type != TTM_PL_TT) {
>> -               return ERR_PTR(-EBUSY);
>>         }
>>
>>         switch (bo->tbo.resource->mem_type) {
>> --
>> 2.34.1
>>

