Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E41AC8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 13:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F323D10E46D;
	Mon,  7 Jul 2025 13:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ycz98w7Z";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1AC910E46D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 13:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaOuY1FdLolUcWp69h1+EP7AYe9v9oCGrtz2BHcr6k9xtwuZCbmkoJenk5WdCmBJCSnIgLBt3XB7mhBDMtxOdZSO5fMvFvifVeaA6ygvlZpln26fTf0tJJWcWBIlSUkr9tN3QlwCjTzuuvNRrMokPe6CUOqUM6JmZV/Z23NCqXIs20GXmhM/mbNtAR+sAuEJYhpJFk/kBikSLzLgxW+JMPK6M/3vxYYE8IjiUK+tRemjmpVRCFZlH11yDZqDtzGEmzASLg6lqfB7tK2xgKNaXfgneOoN0bKW+zMy4YoFeCbBB3tqFh+zEUQZuWV2UFTD+W14gToaRPbHKBsTA5LXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0My/BoyNL/IZt0SA86a5LeQtHtdT9IXBam5grPPispA=;
 b=yhai+RNPAnA41ePDb6IRgrC0ZA6cWVQ+ityEZSsjeWkZl13yDZc0GiHUmb6uBxvlSHELYfo6CKu17OU+O2DBSphWS6B45OHI07+u9BAIRusLLEGOwFcdKuCH6+SfCvdzUQG+/yU+NMNBSXL2pUDFGmdpRp6uq5ZvmSHTR0umGbc78mCpWHmK/vQf2iMumDUG//WggTnattx/UiAS+CGC3ZWJnN4Oy60Kv0s/AZ4wE0x7IhRd23vFO7S5XEtwimskG7h/0PIwcUq+ayAmzWE4bSetGe0K2dZLfQWxwM3DzJ+2Lo1vasVDqgq6BJdG/YlTMKxahQV0Es2nd2OrkVxJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0My/BoyNL/IZt0SA86a5LeQtHtdT9IXBam5grPPispA=;
 b=ycz98w7ZjurKDlYLywAawCV0wbOkmEm33jl2fO7o8skka5sBzdIAXuQPNgR6W0xgD9spnUU2kQ9UiYlvtPBTVzqaiDU/po/V16OjihaYMnpnCq4b+d4ko5z52bHiehcOy1XYyKcQqDex1jco7uPYNx9Kio7Qi5pjKZNMCVdxFv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 13:24:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 13:24:29 +0000
Message-ID: <448919d2-675b-401e-bb7d-0320d8c7109a@amd.com>
Date: Mon, 7 Jul 2025 15:24:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace HQD terminology with slots naming
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Marek.Olsak@amd.com
References: <20250704072657.553572-1-jesse.zhang@amd.com>
 <b5cf1085-5a0b-4b32-8e6a-348f173a247b@amd.com>
 <CADnq5_PrV6RBuiy3vtogGyxhK3QyROCk14WLByfNpOMewh2KMQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PrV6RBuiy3vtogGyxhK3QyROCk14WLByfNpOMewh2KMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee75742-e562-4343-772c-08ddbd599a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0xYa01ocVNidUZIRSs0b1JIK3RFREFtd0ozNjdab3ZrUHg3K2gwSEhleVRa?=
 =?utf-8?B?L0duTUVmZVVOL1lkOFpYL1NOUkY3dDd0SExZWlFqYmdjZTRWRXF3Q1ZvMFJs?=
 =?utf-8?B?UU1UVDAxSjBLTDZjRThyYk1JUmdmM0ttODJuNTJod3doaDk2eE5WQkJIUzZ6?=
 =?utf-8?B?Q3NzTjJRTE84UklSMVowUXVnNVBPNWNZaXoxanpxUElNOUVOVkNOSGFCdkZk?=
 =?utf-8?B?ajQwTWh4WDI0L0Y2WjlkYS9STWJ6dzdmeWhiTlZKUUltbEU4Rk50dnJEQmxW?=
 =?utf-8?B?SjRENXlLbUxoYTBlYUJhQ3lBd1F3TzZUWHJia2h3OG1aOGhNalBoZEVUZ29G?=
 =?utf-8?B?d1hqNEpBWUhxeVlDR0tLd0JUUWxhMGdzUUs4L1gxdjdYNUprN3JOekJ2cjlW?=
 =?utf-8?B?eDFQTFQvRk51VnFiQ0MrZUV2NkN5MTNFUHhEUEFVMS9iVUFveThwR3FtaHAr?=
 =?utf-8?B?MDdSMlRFbTUyK0hpc1dBUngyMVA0ckFnM2Y4blR0b3BTVnpQTFlZbVluMWF4?=
 =?utf-8?B?a1J2NzdGQ24yWlRrUXhXVlF5SGZUdVg4MkZiTTc3YzBXQ0lHbFlHTkRGWng1?=
 =?utf-8?B?M2QzVUdZMHhqVnZBMUpIbzltWmp0aVUydVJWTDVNRnJxQmsxMkhMMDM2cTRS?=
 =?utf-8?B?YnkwVWh5N0ViUFZXQ1dVc0EwdU1Obkxjdzg0WEJaN1pVdG1ZdFFhTm11L2V2?=
 =?utf-8?B?ZXM3ZnBEL1k5dnlRcVVxbDVPNXR3cFhRaHdBRGtldEVuL0VJbDcwNnp6WUVD?=
 =?utf-8?B?ZHZlQVlEVnlEWVFLbE96K0ZMMU41YytaaXErRFh0c2E3N3prK1lyYUZYMkR2?=
 =?utf-8?B?ZEg3ci9IbzhqelF5dWYxNm5aMGZoQTZpZjRUNks4S3VieU9nK1dOUjBrS2ZT?=
 =?utf-8?B?Q0dWZmlmbXg1enNrVVhiWEplNTRuZGdXWDVOc2hFQjFpMkNvREZIaUE0UGhU?=
 =?utf-8?B?OWgvd0tJajhrRWlGbUtRTDFuUFowUHgrQkNKRm54eExpdGlTcVRXbGNlVFBU?=
 =?utf-8?B?YjIydEU5SzZGaDhnSW95dHNXUmFtTE5EWHFRL0I5T2pMYjFHNDIyWG1oak15?=
 =?utf-8?B?VEw0TUxWVGRIZEZScjJMT2traEhlcU5YM2s5WXc1OEQzaVR1MU9PWDNoVFQy?=
 =?utf-8?B?VHluT1dwTHlvTkFEbVFLZnpBRm5yYnNrRWF2Wlo2TUxwWTFUODRUME5rNkI5?=
 =?utf-8?B?R2FuOXpORm1qbXZjdGVxRXBLc25WQTE4cm1iMUh4eXg4UmExcWpIL25xVExK?=
 =?utf-8?B?WWs2K05KaTdienEzQmVHZW0wOU5kbG9GcWdxU1dBTVAxUmttbTQ1bWZOdFZB?=
 =?utf-8?B?TlJSV0wxb29ncENPOVZtWHJWd04zTUNEck04Snc3ZUJqdnA1aWkraFRvaXl0?=
 =?utf-8?B?N2RLNHJDTHBFTytSbXQ0TkNHckFPclN6R21UcENvWi9LbHlvQk5iWCtRd3Z5?=
 =?utf-8?B?eGR5M0JKYWE2ZjA2cHBHUUJRdWpDMmlqbFJrZ2RhTnp4aElNSnRhVlhlajBU?=
 =?utf-8?B?WlhadGh6elVBaFhvWVJzNkd0SXE4Nldzd09zNkF1WFphYjF3ekd2c2tybkND?=
 =?utf-8?B?SmdPaWxzaitNdURjWkxkeG9WOTRCWWJMazBwOVp4eE9tZS9kd3l4VUc2ZENR?=
 =?utf-8?B?N28wV0U1Z01WYmFpZm9YZ0haalZ0U25obFY5UGhHOVFWL2FzNGs3Tjl0SE9n?=
 =?utf-8?B?Rk1ZK3dXZHNHWTlnWXJpVFA3M0txMzdNL0VST2V5REFkRU9NT2pFeTVaTXhl?=
 =?utf-8?B?dGNBWDFvckszdGZuTnl0bmZFdHphK01Da0hHNlRneWM0Myt1bFdtRDJsMHlZ?=
 =?utf-8?B?TUdFWmI0a3p0aEZBRUVDQlFLV0xvSVJGTjBoaGsyNUh1ZE1mTWVJbHd5SVhU?=
 =?utf-8?B?VHd4Z0VRQXhZR1BYbFQ1d3k3K0dHTVpER0RKS2hEcnJNNDN3U05sSy8rS2RD?=
 =?utf-8?Q?dedOnuN5QoA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzVnekdvcEJGTzNRdlVTbTZER3VGSXpuUDdDZW1pQ1dqWTdSZHc1NURvZ2ho?=
 =?utf-8?B?YzMyUnpnV1FxTXZjYjgxc0VEYzA4eHRBSmJUbjFaUWt2amZlNGVSUWpEbXdl?=
 =?utf-8?B?L3NQMXMwWEhJNjE2SHNnMXMzQzJSei9vQnRSYWhCVWZ0d1FNUDlyN0loZWVv?=
 =?utf-8?B?S1YxajlYUUpPMGxMeGNpVVI1M1UrWVVCT1lPczlxakhzWlFPc3I2SmJlZTdm?=
 =?utf-8?B?VWJZQTNsRCt2UlJEcUZBeUM1aWpkaWdxdWFzcjBDekFhdngxQUN5Q0QzMVhF?=
 =?utf-8?B?V2l4ckVGZllXT0ZLem4zZU9UdUp6S09oVERJUUNiSUJEd2Rxa2RkMm9jWTE2?=
 =?utf-8?B?V2J1ZVhpcTJoYmhoOXJ5czhDSU1hZ3JwcGFIWHZ0bTNNM05LTVc5SXFCSTRW?=
 =?utf-8?B?ZWVEUzlNb0lJS3ZGQm51alhLck8yYytOYTJ6VFhpdHRrQXZLQTV1NUd0M0xZ?=
 =?utf-8?B?TjRkdURYQTVueE56d1hBWXZFalF0MWFWeVpkSHB3clVZbzhYTzFUaXRybmpU?=
 =?utf-8?B?S3g4d2FLSGdyVFUrQUdoNlA5emhmZGl3M0pyVTdrQ0MvNzlCeTF1cVg4MVBT?=
 =?utf-8?B?MGxpNGhDS3RFZ0cxV2dQMXhjVXhsamxwOXdlcEFBZlRXMHlSdnhXaitUcVJu?=
 =?utf-8?B?WEgxbFJvTUUyTXlvNkZMYTMrVGR1RGVFOHNtSHVjamZzUWNSa3hiWGpQVy9K?=
 =?utf-8?B?SkEvS0VnOUlvM3AyOXk0NGNYZkJrWFgxN3FnOVhFN3MvTm1tWXcva3JmRnFs?=
 =?utf-8?B?akwwZXJBVVZpdHh5dmJuMCtqOWxQS2xjRUlOUkttTDJzR0ZqZHErWFpCTENY?=
 =?utf-8?B?TEJhcUtrVVlkeTd0ZmNFaml5OU1PVStGNFZUZGlVbUlPdnNFeDZBQWI1Z09u?=
 =?utf-8?B?LzFEU1NoN3VzNmgrTzBPT2pnTlR5TzNkdjc3Ui80eVBHU0NKUlhoaVZWT3hI?=
 =?utf-8?B?Vk80YkpnQ2wxdjhQZGVRVldZNHlEenRRaDhBOStyYmJUWHZ4aWdseUtsN1Zz?=
 =?utf-8?B?dWE3MDhjTXpLalZNWnlpUlVHdFlBQ3ZGVlRCd2JIS1lVR0dQWUd2dkI1ZENM?=
 =?utf-8?B?TFdLcEMzck9aYjVaV2RTUGRzc012V3p6M29CSEM5RHd1OFVrckdOTWlsbDRa?=
 =?utf-8?B?UnhTRzlpaCtxYlNsK0g2aDl3M1N1YzJqWW9VY1hubnZ6cTBibWo5ZGxtbjl2?=
 =?utf-8?B?cWF2b2Z4YXhjVnQvWFA3eFpKR2ZsbUlSNWxpVGxvT3NUbGwvSXNDeDNka1NW?=
 =?utf-8?B?OUFiRDQ2eEhMeGJkWW10SDA1T00yOFU5U1BBYmdHT3FBdDlmckFhVm5pbGp0?=
 =?utf-8?B?NlV6MlBFR2EwVHRTYUxDdEpDaG5zVThIVVE3dDFVRFNnR2NMaEQ5Q3A1UGs4?=
 =?utf-8?B?MzMrUGNTTTJIK0I5cFFkSWpEejVkY0tRNUIzdTUyTFlaU3Q2YkJOQVdUS1FS?=
 =?utf-8?B?SSt6Z1dRQzlkZGl3alpvVDB1TzdQOTlwQTJpcTZmcmY4aEM5dmtGUkc1QTA0?=
 =?utf-8?B?dVo1N29kUnpnN1JsS0k0TDFkOFlad25mRFI1RjV4UVhzMUpwNTdqSkhhWG5F?=
 =?utf-8?B?bllnTXVaOFFwR0R3YjJ2Y2hKc28rcHRKL3FHUkNIMEJYelA5SUNzVk0wa3ZK?=
 =?utf-8?B?WkJHdmpIRnZDSWhzbmxVVjVBQkUydjRkZStObDVyM0ZSL2tPVW1uL1JKSFNH?=
 =?utf-8?B?OEhjSGpDSjRqSEdaVkx3NGRnS1Q1QkFZZXZMcjQ3MnFBU2E3ZXVjVHMwNHhQ?=
 =?utf-8?B?dWNZOUwyYzBDeldGbHRwT3ZBUlliVkJuS3RzS0h1V3FrS0d4b0YyNGlVODEr?=
 =?utf-8?B?MWNaYzhUT05OYlZsVmhxbWp0NEpMRFQ4QXRoaDZWSWZ4RmNqUytGUzk4VG9x?=
 =?utf-8?B?WFp3S2EzMlB2MWk4WDkyWG1HQmhrRWN4ZVBOOEpFT052ZDJOa05KajA3eUZD?=
 =?utf-8?B?d2Y1RFNxY2V4bGFqb2ZBMCs3dzY2QU13WWo5eWJtYWpGMndsaUNmVEY4N1FO?=
 =?utf-8?B?MmU5eGdNL1NUQTQwMzZteEFkb2NaV0hObmNjVW95U1JKeEVwZ05PSFpmTWJx?=
 =?utf-8?B?bTZZc2k5MlZVL2ZickplOG4yaVFBZUlRTy9LU1R3b3hLbCtYeXdBTzZNamR3?=
 =?utf-8?Q?lRS1CPfSnfo2q2IVdP57mXKhG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee75742-e562-4343-772c-08ddbd599a62
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 13:24:29.8942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fL9LXb/tQ8v7XuM/6xKi+MUQl+z77P5lbWc6OKdH6rQdEgCipyWktIvoICCz9K0u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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

On 07.07.25 15:22, Alex Deucher wrote:
> On Mon, Jul 7, 2025 at 5:48 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 04.07.25 09:26, Jesse Zhang wrote:
>>> The term "HQD" is CP-specific and doesn't
>>> accurately describe the queue resources for other IP blocks like SDMA,
>>> VCN, or VPE. This change:
>>>
>>> 1. Renames `num_hqds` to `num_slots` in amdgpu_kms.c to better reflect
>>>    the generic nature of the resource counting
>>> 2. Updates the UAPI struct member from `userq_num_hqds` to `userq_num_slots`
>>> 3. Maintains the same functionality while using more appropriate terminology
>>>
>>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>>
>> Acked-by: Christian König <christian.koenig@amd.com>
>>
>> BTW: Why userspace needs to know that in the first place?
> 
> So IGT can determine how many queues to create to hit over subscription.

Ah! Good point!

Yeah, that makes sense.

Thanks,
Christian.

> 
> Alex
> 
>>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 +++++-----
>>>  include/uapi/drm/amdgpu_drm.h           |  4 ++--
>>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 4aab5e394ce2..e2aa2264fa0b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -399,7 +399,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>       uint32_t ib_size_alignment = 0;
>>>       enum amd_ip_block_type type;
>>>       unsigned int num_rings = 0;
>>> -     uint32_t num_hqds = 0;
>>> +     uint32_t num_slots = 0;
>>>       unsigned int i, j;
>>>
>>>       if (info->query_hw_ip.ip_instance >= AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
>>> @@ -415,7 +415,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>
>>>               if (!adev->gfx.disable_uq) {
>>>                       for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
>>> -                             num_hqds += hweight32(adev->mes.gfx_hqd_mask[i]);
>>> +                             num_slots += hweight32(adev->mes.gfx_hqd_mask[i]);
>>>               }
>>>
>>>               ib_start_alignment = 32;
>>> @@ -430,7 +430,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>
>>>               if (!adev->sdma.disable_uq) {
>>>                       for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
>>> -                             num_hqds += hweight32(adev->mes.compute_hqd_mask[i]);
>>> +                             num_slots += hweight32(adev->mes.compute_hqd_mask[i]);
>>>               }
>>>
>>>               ib_start_alignment = 32;
>>> @@ -445,7 +445,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>
>>>               if (!adev->gfx.disable_uq) {
>>>                       for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
>>> -                             num_hqds += hweight32(adev->mes.sdma_hqd_mask[i]);
>>> +                             num_slots += hweight32(adev->mes.sdma_hqd_mask[i]);
>>>               }
>>>
>>>               ib_start_alignment = 256;
>>> @@ -589,7 +589,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>       }
>>>       result->capabilities_flags = 0;
>>>       result->available_rings = (1 << num_rings) - 1;
>>> -     result->userq_num_hqds = num_hqds;
>>> +     result->userq_num_slots = num_slots;
>>>       result->ib_start_alignment = ib_start_alignment;
>>>       result->ib_size_alignment = ib_size_alignment;
>>>       return 0;
>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>> index 66c4a03ac9f9..bdedbaccf776 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -1493,8 +1493,8 @@ struct drm_amdgpu_info_hw_ip {
>>>       __u32  available_rings;
>>>       /** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
>>>       __u32  ip_discovery_version;
>>> -     /* Userq available hqds */
>>> -     __u32  userq_num_hqds;
>>> +     /* Userq available slots */
>>> +     __u32  userq_num_slots;
>>>  };
>>>
>>>  /* GFX metadata BO sizes and alignment info (in bytes) */
>>

