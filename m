Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027E8C369B0
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 09:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED8588A3E;
	Wed, 25 Sep 2024 09:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WduTxYTR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC8088A3E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 09:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZKK13/C8hhAn9BA4xpNIFXB6Phfa5Nb64zojDAmiLrPd/rbYhFM3BhH65MH/4vipI0nyRCt04/HNmkxUNsYHzwuMOjwwrUNWlqZ/QC4jBxN7jmiF+QZPHWnCCy85yaMU98WywVvQWqAo3K+Oq8tVuTWliwCTKV9tRAdx31btqCKc3JldJkk5dwKsHByBKNydisU2mG0yjIvN9Zwu74ZDOssu8jxnCJiIe6bKt/F2FzyUcccambI03YaniwUYBKeS+20JuX15STyjIqHOQB1/UtR8vUCPic8wHbpEOt2xAGvHltGNUi9cObscvP2pslybh3bk1LD1KFxzhLgw/n12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+mP6RLTsOUrQgBZzC+7jetfEaPYZWW9Vjs6vDLDgvI=;
 b=wXHXU+meV6Tb9zrhBWYVKEKXgUYZNG4wqacWXTp6oUCXXeo4tN35sJFr4/R1k1Kxuo5NX+JI1ZDxMu08wXTo8H+eHfwH2/QcSfHU0FhCmLJ3obIhRX40DoHjyQSXvZTTNhvODu7mYLkTT8CXL4dA1Aji+9YZg/7q4TdPwKFDSjA07yXdJtqE7ggJRtbXxc1FO4urPeCsYDFm74FltY018zItRrduUoQle1htr1dX+9e/JAa73KGkO9WFL88U+FdF5kncBeo6XJsK2YSQdGleQwJ5P/5JCGjQKgzKYD9BN7RxoDBix+LP3MUOX577jbA6F47zrQM9rLG570KFqDyOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+mP6RLTsOUrQgBZzC+7jetfEaPYZWW9Vjs6vDLDgvI=;
 b=WduTxYTRlZAX7+V0Fb4etVzbPwtOu1h5nf4BvjQNfJbSXNnc6q2c3nGPsXE5wjS7sF1fuu6R8v4XoAUi7cl8FhwIxFuk4uc98Mwt1fZDi//n4x2ChbboWl/joP+OrUxp4en3ZSbd5+CQ67lSEFtV61zrss64WLC9bGW0B48+DNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 09:13:52 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%7]) with mapi id 15.20.7982.016; Wed, 25 Sep 2024
 09:13:52 +0000
Message-ID: <c19838a5-d58e-48c4-8247-71dc0441fbf1@amd.com>
Date: Wed, 25 Sep 2024 11:13:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 23/28] drm/amdgpu: suspend gfx userqueues
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <20240909200614.481-19-shashank.sharma@amd.com>
 <24e0e708-661f-4488-86be-ebb9312187e4@gmail.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <24e0e708-661f-4488-86be-ebb9312187e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb7e2e8-08d0-4827-0a31-08dcdd425f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEJyaG5VbzE1dVNMQmxxM0p0UjVmZzFvd2tlcmpvMWxteTlzWG1BVWU4SE5Y?=
 =?utf-8?B?UThreDZxd012WUMxNGVvZFRaYXBIdUhjU3hZQm5KYWVjSzEzUzBNQVBNQ3E2?=
 =?utf-8?B?Q3JCcVozUGlmTVRTUEJKQ3U5Q0JlR0RBVXlmd0Nna0h6Nm5tWFpSMFl1QU0z?=
 =?utf-8?B?bmhzUkhzWVBmK3JrVWdCNThNZ2tWeG02L1RXSXVmQ2F3Vm5GVTE3UlZ5L0k0?=
 =?utf-8?B?MisrQjdKWkNhMGs5UHREdzM3MDZScXNrUDdPeVg3czZNc0twNG1yZExVdnhr?=
 =?utf-8?B?cW92ZVRxWXJtcmFMM2J0RlA3NWNoZFdLaFhpTm5pbnBSaCtaOUF5ZVBBWThN?=
 =?utf-8?B?bUx1UmhscWRjdStVQjVqeStCSWlNUFhJRXhFaHVFcWx1TmNEOFdRUnF1Z2sz?=
 =?utf-8?B?ZERSQmp6Skl3TStpYWJMM2dydnQ5UitDZkYwNXo2bEpSZThGWTBCbG9ob0RE?=
 =?utf-8?B?N2svOEdaVU13Lzh6akJlT2pISEw2Um9iTzdORnphaDZyOTBkcCt5K3h1bHF2?=
 =?utf-8?B?Si9PdzNaQU94ZU5lRUFwL0NBRE5oeFFJZ1B5WW14WG4rNjlTV2lRUGZJbE03?=
 =?utf-8?B?YnMvRGZFdGV5WXFqMzhWUWdBazQwNFBrTnhhUHB1NUNlV294UHNkYnJPb0g4?=
 =?utf-8?B?RFFaTHBpNDdzazVBam5ibk1rYkJYM1ZvQ2JaYW1JUkd1L0FOdkFkeXJ4THpn?=
 =?utf-8?B?Z3RrUk9SVmdtcU1BK1hlejhFTmdTeE0rejJZS1kzdFRGMEkrM2FDb2JLQWpF?=
 =?utf-8?B?cXJUQmdmTUNIdFRZVlFqVVBka0lYTEN2ZVZmZVFoMGVRS1ZBZ0JIcjUzcWc1?=
 =?utf-8?B?SnFqaWVralY0eWtUOU5WS2tuTVJmUkhqemZ3MVpxeXVNRXByYTlwUEUvYStF?=
 =?utf-8?B?TVJwcTZDejNWMmdaVldpcUVIUVVNcTNEWkYyRWQ0bEJlejZtZFFSUXVmWjMy?=
 =?utf-8?B?WDhUdHpIY3E3Q3VMRHR2MTkzeTVNdlU1dFdCU0ZsY3R0cFBoT2lOZHptTndF?=
 =?utf-8?B?bUJiQTlmWEZNMkNud2p3dEdwQnBNTkJpMkkwZDcyVTJhNWdvZ3N2ZUVXa1V4?=
 =?utf-8?B?SDFsOWxtRlQwWnUwN3czNDZsTW1zMWg5aW95cUdmTXQrbGtaR0lWc1M0eW9H?=
 =?utf-8?B?YUdtRkp3QWdWRE93V2N6bmkvcWs4M3QrUVZRMDdiQ2lseEQ5dTN3V2dXZ1kz?=
 =?utf-8?B?T3dPbFJjbmRIbHEweCt0WjJQODc0cTh4cnBJUC8vQ2xvOHY5SHpROE15M2ha?=
 =?utf-8?B?NGsweVdhOWVnR2NZaTVuSGNiOWFUT1ZDZmsrT1JocEZhWUl5SHRkYnJDSGZK?=
 =?utf-8?B?WXdHcC93azJnZDI0OWRBSlNVaG1RNjZGWnA4T0dGSWJyN0dkTmpUSUo3K2s4?=
 =?utf-8?B?am9qQlFwWkxFWkNWV1lYZitRbFpMblpPR0JkZStrZzBBMHM3VHRKYWNleEUx?=
 =?utf-8?B?TE1oRm5uRUs5VGtJWjNQZll4R1huMEpzcGVPK29SZDZONlplT1VOODhpVXY1?=
 =?utf-8?B?YU4vWXRFMlByNnhUbDlpWlhzSGU0bTE5LzdoQkdNVm9ObThCRVgwNWFRTHFt?=
 =?utf-8?B?RmpzS3ZOUXNCWDlxdTVMcUhQNDNuZXoxb3JMcUVSbjdXaDhJTU5nNmhVeWdO?=
 =?utf-8?B?dnJGSjZTRWcwaDRzTXNuQ1poY3hFZmIwRzR4aklNS0M4S2d2N2t4d3NEQjRI?=
 =?utf-8?B?Z0pnckVIS0pDRy9vUnpWN2JqZmJqRU5EamJ0Zisya3lnbTVtNWg4cDZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cElwWWNMWlRDWWdwMHZKT2V6Kzk2UnVoTWtPZFhKV2VnczFlU2EyNXhyQkwz?=
 =?utf-8?B?MUlvZUlFTWpSbm5Mbyt2bGFVTVNvVWxhWFhwdnI2Z3VXakdxK1VhN3NJSWda?=
 =?utf-8?B?MWVBWWhScEtLUnRaaTk3UmtFZDc3ZGlLZ0krYWpqU3QwbHF3NFNEQjR1b3Ru?=
 =?utf-8?B?WVNSVERHTkkyOVFHdkJtK3ZoVEViL3grM0dVNWJSRTFNV3VpbG1jWE5jMDVX?=
 =?utf-8?B?QWh6ZS9EMnZ0azdONk9jeCtRbFRaUi8wYy9veXJMN2dzT2htU3VZN3dqdXJy?=
 =?utf-8?B?eTBRVGhRQUt3cHR2MGwxVDdhTVFNUC9RWlNVRDVXVEpocFE4RXo4aHRWbTZ4?=
 =?utf-8?B?ZUJ1NFRJQWliR2hGZUV2cW0zOFNvZncyQXRqWDducUlKL1BkT05KNjQzZWUz?=
 =?utf-8?B?ZXZabWNOUzdkU1dhc2RCS1crMWRCbGh4UFcyeW90UEIyWWcrNTQ3Zm9RS3Z1?=
 =?utf-8?B?K0JjdCtkNDJXTFcwNUVDRmNydWY1RDNhbGNGSTd4OWhEd2tnbk96ODJsdXlC?=
 =?utf-8?B?MkxFY0VqWE5rcTJ0R3dpa3lORUpManZxMm1sd0w1dnVtTnpCVjE0cW84SDRv?=
 =?utf-8?B?eDBYbEdaZGJIenBreDBvWHNydDZXbTJVUHZFKzBPa3B4TFN0anhpN25OaTVS?=
 =?utf-8?B?TUhXMnR4WmJ0aHJ4cXdlMmIyNkFSQmRZTDVZQlRMZXcwR1dJdzIwSFlFb2ZP?=
 =?utf-8?B?cWFDdnpQQjFPbTBGVCs1UUwxdk16dU9rQm5rOUp6WVRteEVIei9NdUlIeTdP?=
 =?utf-8?B?T0ZXNitwMGpQeDllak1DTkUrSkszbzk2eWJTdjRLRVNKUnpueFVRQ0ljZXJB?=
 =?utf-8?B?M1E3dVNNQ2lNR2lPM2pXcG1Bb3lSdVJBOURodWpDU1paQmhybUF4QjB3bTBR?=
 =?utf-8?B?SUZjS0dySTFrQ2tsemU5cHhhZG9leTJGOHpyVUVhN1c0a3dPN1cxeEMvZVEz?=
 =?utf-8?B?S014OENMSFVyUk5jdE5vZkZRYml1UTFIRG5tZmxuV25KY292QStSRjViTU1T?=
 =?utf-8?B?M282LzFHT2RxNEFyYi84KzNIbUoxRy9KcUU2d05KKzN6QUFlcVNva0FYNXR2?=
 =?utf-8?B?TytvWk9XQ1AxOXJYRUprUHhJSTFyOGh5R2tRU3BEZ0x3ejlmR0g2cEhRaVAy?=
 =?utf-8?B?bHhhaFRydld4OUcxeUh2dk13M2x2aitvczZvaHpVdnpsejdvZFphck1nUkh3?=
 =?utf-8?B?ZTJXWXpjV2ptN0dDaGhiVjg5S094Ti9mYzlOMEh1ZEIxUDhVbHdMWWY2QWNi?=
 =?utf-8?B?SzJmNUszNHpYZUtYWDYrVExzdWoyOGkrR1JaTkEyazdKUElkcDVKYzQ1eVgr?=
 =?utf-8?B?T0ordzRZMHVTbjQvb3JHN29tL2oyb1BOcFIzQ2kyaE5BRnZEenp4OG56ZERu?=
 =?utf-8?B?WFdaRTVEb2Z3WjJuRlNndjdwVXpKV2xaMGFPSWhXSW4yRUxhNGVxYlpMZHRO?=
 =?utf-8?B?Y0VCY1hYT1NDbzN4UFI3S0t6emRNVExmZGp1cTM2b1dBalJQMFRJQ1pPWXRV?=
 =?utf-8?B?cGo0ZHd4SzhpSXNxOGlHQjJvVm9yQ2UwNmZoSCtPQTNFc2pqUitETW01Y0Vo?=
 =?utf-8?B?TE43b1F3VlFIVmpZZHQ3eHZxUmorbmltY2tlU3ZqOGpISjdRWW9ac2x5UGlZ?=
 =?utf-8?B?MHczT2RhUWFzNk5DTWpSK0lEc2JnU0JPbmpRTk44bEsvZ3NWRXB6clFFb0hx?=
 =?utf-8?B?aGdGd3Y3aG9UM1RSZnRuOVdzK3N0NmlWeHY2eldwR2FIcSs0d2Y1NjdxOWNB?=
 =?utf-8?B?RjRzajhnOHBoYTVWU3MwUXNpdzRSSWc5TmdrSk1SbitveG9JQkhxUEUvOU1L?=
 =?utf-8?B?TmZsUldWRVhpVG84ajdpRzNsMW9hTVQrdWl2d3R0MVZCalRHZ0RMVUswNTh1?=
 =?utf-8?B?MEdIVkRVdUVxSEN6QUFuaG1FVlpwYVY4K3JkTFJVZ3JBT1BnVXdXekZwNG9r?=
 =?utf-8?B?Q1FpMHNzbW1KNWFyejQ5RzRMSUtiVnhVbVYwVWZlQ2FZMkd5aUJ0L1JkcUR4?=
 =?utf-8?B?OG1SRUR1anc0UTVRd0dSVjQ5MFZGTHpWLzhLSVNtUlBkS0gxVDJBUXlka0wr?=
 =?utf-8?B?U2tDRFRzOEpSRTd4T21vM0V2L1ZValJHbGhXdis2amdRRGM2b1VPMFNZaTdH?=
 =?utf-8?Q?2jjIjKt1NGvRF1GVeXacNs30L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb7e2e8-08d0-4827-0a31-08dcdd425f79
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 09:13:52.0244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TpbzniumtuUNxP7Er4XAasrPaoe1lX50Icm42/O+0yDQfSqpTYLmwJCK7a5Kqsb5lfmMk2b84rSaYRq6e4FTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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


On 17/09/2024 13:58, Christian König wrote:
> Am 09.09.24 um 22:06 schrieb Shashank Sharma:
>> This patch adds suspend support for gfx userqueues. It typically does
>> the following:
>> - adds an enable_signaling function for the eviction fence, so that it
>>    can trigger the userqueue suspend,
>> - adds a delayed function for suspending the userqueues, to suspend all
>>    the queues under this userq manager and signals the eviction fence,
>> - adds reference of userq manager in the eviction fence container so
>>    that it can be used in the suspend function.
>>
>> V2: Addressed Christian's review comments:
>>      - schedule suspend work immediately
>>
>> V4: Addressed Christian's review comments:
>>      - wait for pending uq fences before starting suspend, added
>>        queue->last_fence for the same
>>      - accommodate ev_fence_mgr into existing code
>>      - some bug fixes and NULL checks
>>
>> V5: Addressed Christian's review comments (gitlab)
>>      - Wait for eviction fence to get signaled in destroy, dont 
>> signal it
>>      - Wait for eviction fence to get signaled in replace fence, dont 
>> signal it
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> Change-Id: Ib60a7feda5544e3badc87bd1a991931ee726ee82
>> ---
>>   .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 149 ++++++++++++++++++
>>   .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  10 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 100 ++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  10 ++
>>   6 files changed, 272 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> index 2d474cb11cf9..3d4fc704adb1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> @@ -22,8 +22,12 @@
>>    *
>>    */
>>   #include <linux/sched.h>
>> +#include <drm/drm_exec.h>
>>   #include "amdgpu.h"
>>   +#define work_to_evf_mgr(w, name) container_of(w, struct 
>> amdgpu_eviction_fence_mgr, name)
>> +#define evf_mgr_to_fpriv(e) container_of(e, struct amdgpu_fpriv, 
>> evf_mgr)
>> +
>>   static const char *
>>   amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
>>   {
>> @@ -39,10 +43,150 @@ amdgpu_eviction_fence_get_timeline_name(struct 
>> dma_fence *f)
>>       return ef->timeline_name;
>>   }
>>   +static void
>> +amdgpu_eviction_fence_update_fence(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr,
>> +                   struct amdgpu_eviction_fence *new_ef)
>> +{
>> +    struct dma_fence *old_ef = &evf_mgr->ev_fence->base;
>
> The spinlock is protecting evf_mgr->ev_fence so this access without 
> holding the spinlock here is illegal.
>
> I think you should just drop the local variable.
>
Agreed
>> +
>> +    spin_lock(&evf_mgr->ev_fence_lock);
>> +    dma_fence_put(old_ef);
>> +    evf_mgr->ev_fence = new_ef;
>> +    spin_unlock(&evf_mgr->ev_fence_lock);
>> +}
>> +
>> +int
>> +amdgpu_eviction_fence_replace_fence(struct amdgpu_fpriv *fpriv)
>> +{
>> +    struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
>> +    struct amdgpu_vm *vm = &fpriv->vm;
>> +    struct amdgpu_eviction_fence *old_ef, *new_ef;
>> +    struct amdgpu_bo_va *bo_va, *tmp;
>> +    int ret;
>> +
>> +    old_ef = evf_mgr->ev_fence;
>> +    if (old_ef && !dma_fence_is_signaled(&old_ef->base)) {
>> +        DRM_DEBUG_DRIVER("Old EF not signaled yet\n");
>> +        dma_fence_wait(&old_ef->base, true);
>> +    }
>
> Please completely drop that.

I need some info on this. If we reach here to replace the eviction 
fence, but the previous eviction fence is not yet signaled, should not 
bother about waiting on the old ev_fence to be signaled ?

>
>> +
>> +    new_ef = amdgpu_eviction_fence_create(evf_mgr);
>> +    if (!new_ef) {
>> +        DRM_ERROR("Failed to create new eviction fence\n");
>> +        return ret;
>> +    }
>> +
>> +    /* Replace fences and free old one */
>> +    amdgpu_eviction_fence_update_fence(evf_mgr, new_ef);
>> +
>> +    /* Attach new eviction fence to BOs */
>> +    list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
>
> It's probably better to use drm_exec_for_each_locked() here.
Noted,
>
>> +        struct amdgpu_bo *bo = bo_va->base.bo;
>> +
>> +        if (!bo)
>> +            continue;
>> +
>> +        /* Skip pinned BOs */
>> +        if (bo->tbo.pin_count)
>> +            continue;
>
> Clearly a bad idea, even pinned BOs need the eviction fence because 
> they can be unpinned at any time.
Noted
>
>> +
>> +        ret = amdgpu_eviction_fence_attach(evf_mgr, bo);
>> +        if (ret) {
>> +            DRM_ERROR("Failed to attch new eviction fence\n");
>> +            goto free_err;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +
>> +free_err:
>> +    kfree(new_ef);
>> +    return ret;
>> +}
>> +
>> +static void
>> +amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>> +{
>> +    struct amdgpu_eviction_fence_mgr *evf_mgr = 
>> work_to_evf_mgr(work, suspend_work.work);
>> +    struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
>> +    struct amdgpu_vm *vm = &fpriv->vm;
>> +    struct amdgpu_bo_va *bo_va, *tmp;
>> +    struct drm_exec exec;
>> +    struct amdgpu_bo *bo;
>> +    int ret;
>> +
>> +    /* Signal old eviction fence */
>> +    ret = amdgpu_eviction_fence_signal(evf_mgr);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to signal eviction fence err=%d\n", ret);
>> +        return;
>> +    }
>> +
>> +    /* Cleanup old eviction fence entry */
>> +    amdgpu_eviction_fence_destroy(evf_mgr);
>
> Of hand that looks like a bad idea to me. The eviction fence should 
> never become NULL unless the fd is closed.
>
> In general we need to make sure that nothing races here, e.g. we 
> always need a defensive ordering.
>
> Something like:
> 1. Lock all BOs
> 2. Create new eviction fence,
> 3. Publish eviction fence in the evf_mgr.
> 4. Add the eviction fence to the BOs.
> 5. Drop locks on all BOs.
>
> This way concurrently opening/closing BOs should always see the right 
> eviction fence.

Noted, I will do the sequence change as suggested.

- Shashank

>
> Regards,
> Christian.
>
>> +
>> +    /* Do not replace eviction fence is fd is getting closed */
>> +    if (evf_mgr->eviction_allowed)
>> +        return;
>> +
>> +    drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>> +    drm_exec_until_all_locked(&exec) {
>> +        ret = amdgpu_vm_lock_pd(vm, &exec, 2);
>> +        drm_exec_retry_on_contention(&exec);
>> +        if (unlikely(ret)) {
>> +            DRM_ERROR("Failed to lock PD\n");
>> +            goto unlock_drm;
>> +        }
>> +
>> +        /* Lock the done list */
>> +        list_for_each_entry_safe(bo_va, tmp, &vm->done, 
>> base.vm_status) {
>> +            bo = bo_va->base.bo;
>> +            if (!bo) continue;
>> +
>> +            ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
>> +            drm_exec_retry_on_contention(&exec);
>> +            if (unlikely(ret))
>> +                goto unlock_drm;
>> +        }
>> +    }
>> +    /* Replace old eviction fence with new one */
>> +    ret = amdgpu_eviction_fence_replace_fence(fpriv);
>> +    if (ret)
>> +        DRM_ERROR("Failed to replace eviction fence\n");
>> +unlock_drm:
>> +    drm_exec_fini(&exec);
>> +}
>> +
>> +static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
>> +{
>> +    struct amdgpu_eviction_fence_mgr *evf_mgr;
>> +    struct amdgpu_eviction_fence *ev_fence;
>> +    struct amdgpu_userq_mgr *uq_mgr;
>> +    struct amdgpu_fpriv *fpriv;
>> +
>> +    if (!f)
>> +        return true;
>> +
>> +    ev_fence = to_ev_fence(f);
>> +    uq_mgr = ev_fence->uq_mgr;
>> +    fpriv = uq_mgr_to_fpriv(uq_mgr);
>> +    evf_mgr = &fpriv->evf_mgr;
>> +
>> +    if (uq_mgr->num_userqs)
>
> I don't think you should make that decision here. At least of hand 
> that looks racy.
>
> Probably better to always trigger the suspend work in the uq manager.
>
>> +        /* If userqueues are active, suspend userqueues */
>> +        schedule_delayed_work(&uq_mgr->suspend_work, 0);
>> +    else
>> +        /* Else just signal and replace eviction fence */
>> +        schedule_delayed_work(&evf_mgr->suspend_work, 0);
>> +
>> +    return true;
>> +}
>> +
>>   static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
>>       .use_64bit_seqno = true,
>>       .get_driver_name = amdgpu_eviction_fence_get_driver_name,
>>       .get_timeline_name = amdgpu_eviction_fence_get_timeline_name,
>> +    .enable_signaling = amdgpu_eviction_fence_enable_signaling,
>>   };
>>     int amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr)
>> @@ -59,11 +203,14 @@ struct amdgpu_eviction_fence *
>>   amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr)
>>   {
>>       struct amdgpu_eviction_fence *ev_fence;
>> +    struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
>> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>         ev_fence = kzalloc(sizeof(*ev_fence), GFP_KERNEL);
>>       if (!ev_fence)
>>           return NULL;
>>   +    ev_fence->uq_mgr = uq_mgr;
>>       get_task_comm(ev_fence->timeline_name, current);
>>       spin_lock_init(&ev_fence->lock);
>>       dma_fence_init(&ev_fence->base, &amdgpu_eviction_fence_ops,
>> @@ -143,6 +290,8 @@ void amdgpu_eviction_fence_init(struct 
>> amdgpu_eviction_fence_mgr *evf_mgr)
>>           goto unlock;
>>       }
>>   +    INIT_DELAYED_WORK(&evf_mgr->suspend_work, 
>> amdgpu_eviction_fence_suspend_worker);
>> +
>>   unlock:
>>       spin_unlock(&evf_mgr->ev_fence_lock);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> index b47ab1307ec5..712fabf09fc1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> @@ -37,6 +37,8 @@ struct amdgpu_eviction_fence_mgr {
>>       atomic_t        ev_fence_seq;
>>       spinlock_t         ev_fence_lock;
>>       struct amdgpu_eviction_fence *ev_fence;
>> +    struct delayed_work    suspend_work;
>> +    bool eviction_allowed;
>>   };
>>     /* Eviction fence helper functions */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index e7fb13e20197..88f3a885b1dc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1434,6 +1434,7 @@ void amdgpu_driver_postclose_kms(struct 
>> drm_device *dev,
>>   {
>>       struct amdgpu_device *adev = drm_to_adev(dev);
>>       struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>> +    struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
>>       struct amdgpu_bo_list *list;
>>       struct amdgpu_bo *pd;
>>       u32 pasid;
>> @@ -1466,6 +1467,7 @@ void amdgpu_driver_postclose_kms(struct 
>> drm_device *dev,
>>           amdgpu_bo_unreserve(pd);
>>       }
>>   +    evf_mgr->eviction_allowed = true;
>>       amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>>       amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>       amdgpu_vm_fini(adev, &fpriv->vm);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 614953b0fc19..4cf65aba9a9b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -455,10 +455,18 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
>> *dev, void *data,
>>       if (r)
>>           goto exec_fini;
>>   -    for (i = 0; i < num_bo_handles; i++)
>> +    /* Save the fence to wait for during suspend */
>> +    dma_fence_put(queue->last_fence);
>> +    queue->last_fence = dma_fence_get(fence);
>> +
>> +    for (i = 0; i < num_bo_handles; i++) {
>> +        if (!gobj || !gobj[i]->resv)
>> +            continue;
>> +
>>           dma_resv_add_fence(gobj[i]->resv, fence,
>>                      dma_resv_usage_rw(args->bo_flags &
>>                      AMDGPU_USERQ_BO_WRITE));
>> +    }
>>         /* Add the created fence to syncobj/BO's */
>>       for (i = 0; i < num_syncobj_handles; i++)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index ba986d55ceeb..979174f80993 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -22,6 +22,7 @@
>>    *
>>    */
>>   #include <drm/drm_syncobj.h>
>> +#include <drm/drm_exec.h>
>>   #include "amdgpu.h"
>>   #include "amdgpu_vm.h"
>>   #include "amdgpu_userqueue.h"
>> @@ -282,6 +283,7 @@ amdgpu_userqueue_destroy(struct drm_file *filp, 
>> int queue_id)
>>       amdgpu_bo_unpin(queue->db_obj.obj);
>>       amdgpu_bo_unref(&queue->db_obj.obj);
>>       amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
>> +    uq_mgr->num_userqs--;
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       return 0;
>>   }
>> @@ -369,6 +371,7 @@ amdgpu_userqueue_create(struct drm_file *filp, 
>> union drm_amdgpu_userq *args)
>>           goto unlock;
>>       }
>>       args->out.queue_id = qid;
>> +    uq_mgr->num_userqs++;
>>     unlock:
>>       mutex_unlock(&uq_mgr->userq_mutex);
>> @@ -402,12 +405,109 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
>> void *data,
>>       return r;
>>   }
>>   +static int
>> +amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    const struct amdgpu_userq_funcs *userq_funcs;
>> +    struct amdgpu_usermode_queue *queue;
>> +    int queue_id, ret;
>> +
>> +    userq_funcs = adev->userq_funcs[AMDGPU_HW_IP_GFX];
>> +
>> +    /* Suspend all the queues for this process */
>> +    idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>> +        ret = userq_funcs->suspend(uq_mgr, queue);
>> +        if (ret)
>> +            DRM_ERROR("Failed to suspend queue\n");
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int
>> +amdgpu_userqueue_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +    struct amdgpu_usermode_queue *queue;
>> +    int queue_id, ret;
>> +
>> +    idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>> +        struct dma_fence *f;
>> +        struct drm_exec exec;
>> +
>> +        drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>> +        drm_exec_until_all_locked(&exec) {
>> +            f = queue->last_fence;
>> +            drm_exec_retry_on_contention(&exec);
>> +        }
>> +        drm_exec_fini(&exec);
>> +
>> +        if (!f || dma_fence_is_signaled(f))
>> +            continue;
>> +        ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>> +        if ( ret <= 0) {
>> +            DRM_ERROR("Timed out waiting for fence f=%p\n", f);
>> +            return -ETIMEDOUT;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void
>> +amdgpu_userqueue_suspend_worker(struct work_struct *work)
>> +{
>> +    int ret;
>> +    struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, 
>> suspend_work.work);
>> +    struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>> +    struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
>> +
>> +    /* Wait for any pending userqueue fence to signal */
>> +    ret = amdgpu_userqueue_wait_for_signal(uq_mgr);
>> +    if (ret) {
>> +        DRM_ERROR("Not suspending userqueue, timeout waiting for 
>> work\n");
>> +        return;
>> +    }
>> +
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +    ret = amdgpu_userqueue_suspend_all(uq_mgr);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to evict userqueue\n");
>> +        goto unlock;
>> +    }
>> +
>> +    /* Signal current eviction fence */
>> +    ret = amdgpu_eviction_fence_signal(evf_mgr);
>> +    if (ret) {
>> +        DRM_ERROR("Can't signal eviction fence to suspend\n");
>> +        goto unlock;
>> +    }
>> +
>> +    /* Cleanup old eviction fence entry */
>> +    amdgpu_eviction_fence_destroy(evf_mgr);
>> +
>> +unlock:
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +}
>> +
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct amdgpu_device *adev)
>>   {
>> +    struct amdgpu_fpriv *fpriv;
>> +
>>       mutex_init(&userq_mgr->userq_mutex);
>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>       userq_mgr->adev = adev;
>> +    userq_mgr->num_userqs = 0;
>> +
>> +    fpriv = uq_mgr_to_fpriv(userq_mgr);
>> +    if (!fpriv->evf_mgr.ev_fence) {
>> +        DRM_ERROR("Eviction fence not initialized yet\n");
>> +        return -EINVAL;
>> +    }
>>   +    /* This reference is required for suspend work */
>> +    fpriv->evf_mgr.ev_fence->uq_mgr = userq_mgr;
>> +    INIT_DELAYED_WORK(&userq_mgr->suspend_work, 
>> amdgpu_userqueue_suspend_worker);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 37be29048f42..8b3b50fa8b5b 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -27,6 +27,10 @@
>>     #define AMDGPU_MAX_USERQ_COUNT 512
>>   +#define to_ev_fence(f) container_of(f, struct 
>> amdgpu_eviction_fence, base)
>> +#define work_to_uq_mgr(w, name) container_of(w, struct 
>> amdgpu_userq_mgr, name)
>> +#define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, 
>> userq_mgr)
>> +
>>   struct amdgpu_mqd_prop;
>>     struct amdgpu_userq_obj {
>> @@ -50,6 +54,7 @@ struct amdgpu_usermode_queue {
>>       struct amdgpu_userq_obj wptr_obj;
>>       struct xarray        uq_fence_drv_xa;
>>       struct amdgpu_userq_fence_driver *fence_drv;
>> +    struct dma_fence    *last_fence;
>>   };
>>     struct amdgpu_userq_funcs {
>> @@ -69,6 +74,9 @@ struct amdgpu_userq_mgr {
>>       struct idr            userq_idr;
>>       struct mutex            userq_mutex;
>>       struct amdgpu_device        *adev;
>> +
>> +    struct delayed_work        suspend_work;
>> +    int num_userqs;
>>   };
>>     int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct 
>> drm_file *filp);
>> @@ -86,4 +94,6 @@ void amdgpu_userqueue_destroy_object(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>   int amdgpu_userqueue_update_bo_mapping(struct drm_file *filp, 
>> struct amdgpu_bo_va *bo_va,
>>                          uint32_t operation, uint32_t syncobj_handle,
>>                          uint64_t point);
>> +
>> +int amdgpu_userqueue_enable_signaling(struct dma_fence *f);
>>   #endif
>
