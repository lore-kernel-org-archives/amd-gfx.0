Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6741DC54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 16:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B21410E00E;
	Tue, 27 Sep 2022 16:59:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C380E10E00E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 16:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdVQrGyDD9EIhbPCn2SriO/Plh5Xo3DM3fEvyRugJIzCgtqCafW6RS+Av80ZIzf74ZCh7oi7Vpao1bvP+ina/423QsOEnd6ywepQks2tuGm8cBXu156gSNyRjMpcJvdAxZLVGNQYjfbBABNSJ/gzFHbziATi7a7t6yXoQ5W/0uTdxsHoVBHBB6500mfJpas+/GthO9Kkg/AEljRWX8Gksej1RD2Vrh1FiHMvynWrUrhoV+KjffINkrS4a62r4/gsNhC4YqyPV9R02wyR+DPlL0cXBDOqjXpFmrZ1hwAQzbgR7XpbP3cbaRHdj55cvNAVygoKOvLegV7NR6uIO7LIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z5jiXvq4NYxX9vS7KJx+Iq28oAmO4iHVY+t6bJvid0=;
 b=WSbWKxvroA8GyftySp5Fs3zq6EPN0/epdGaNPuoM5H6WJQhULZO3MQ1pe+rcgLUz92NGdFx2fn0E2SzYDSGl7fj8AW1ig+xThCc1AozCTRQYmf5kkVI1s3UaMoBLI6U8/AMcd01+vhKhLPOLBTxcPe2nsCXgHBrSabjsjIpN2d67KHEij56m6vfYFyeZrnkjaw0Hh7p3UEoroDkQHCJy82cJuepZF8MIVynx0M0f38SdVd18pB+CAYh8oBpzNwycuyPGIU2OpRwVhRW1hNzBpMO9PXSUFxVDwCvLWSPpA4akhQNFmH3Vnwml9Hvr/PxUlQXcBvR6ANukDIndatA6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+z5jiXvq4NYxX9vS7KJx+Iq28oAmO4iHVY+t6bJvid0=;
 b=dX3HQkr4sCXfMmYvRtRVNeMRVBdGIEhVzE8xOKtwnbAtJ13vo6FI451y/toT0APZ3qSQ5XZVwZS30yXFQtkSfHj5br6fvvIOAhz5RzJgwYf2UvIuvZHh9Cc9otmTXR3yln6Ke4JrZFTSUJvLlLLNsDZwUcQMixMaU3AXc8X1530=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 16:59:45 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f%4]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 16:59:44 +0000
Message-ID: <181b4f95-7a46-c8a3-0ffd-0d338f3cb193@amd.com>
Date: Tue, 27 Sep 2022 18:59:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/5] GPU workload hints for better performance
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <1b549873-106d-1e93-7f77-4a3966828b9c@mailbox.org>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <1b549873-106d-1e93-7f77-4a3966828b9c@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0380.eurprd06.prod.outlook.com
 (2603:10a6:20b:460::34) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|PH7PR12MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: b829d315-8f14-4d19-b73a-08daa0a9ad7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLgEPd9e+5YCGQW0ourzoHhjn4+MgTJZSntNKIDiuuPp+y7yAvGT2TedwwtKTFc8aU0zmSmaiz3KFFLoV2LALxgORTdsVk93o+kpIo1Cr0a4mOR0UPauquHyqhxzbIu/41MzRz6X66AFh8xhycYZ2wORs7VXfOZTEvuFU6/YRf4m1TJAPhn1Nx/ZFUg2fouXFRnmcMcT+mYITD+7hOxhUhO5W6QDIeRMjxzXDyUaAgPtN0vj82CL1ZFzMxYnxKn21gx19vpwuUfkdnP9ZPORL2NY6TmZUJ272fRega6CyTJcJ8QKjuk/vi2UBAnzYK66HJhWt8GQvDw3mxjF89JG1+9S9eDeH8h2YSQz9xu5+LSk007rqynN5Eb27XrODdnKCYxfMyRoqE+Z8BxW5vy1m344V3D2Qr8BomZZN8CKfrcL8J9aJievjEPDXQdo/uGOuJhjqj0bkjqgFgF5cyV8Ip4IEtSKSsJfoFQX/6WO19z5FyOFrolwmTrPmP9U6Z6eXdOOXjsWH9Ia9n/J1yeapUBg3Yvoomgcat8izjycCHi6NT6iMF3EEp+/eSV3Budv+1CeZ/C/w6UcVU2DosVQxOKMbbC4QKWQhYTSlddcGviUb5I1sjRaZnVUm2St/nfZ/kEarP2m3nlyJbmd9OSdN9Ur39GSQC8/jmlMl6XVpTflBH4de3GS9Hm7NU3tS0oq8KFqfKNkdl7Ey1oHxurW6vho0kZOgo29CdQk9Qg0GV+akuwkCCb0iG4wOeOwfobiQ5srmRB+rCTi4wqv6x7HD9Nt/3UxW5QD4KGb8ZmRxV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199015)(31686004)(31696002)(86362001)(6486002)(478600001)(316002)(6916009)(66476007)(8676002)(4326008)(66556008)(66946007)(38100700002)(6666004)(83380400001)(41300700001)(26005)(5660300002)(6512007)(8936002)(53546011)(6506007)(66574015)(2906002)(2616005)(36756003)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm5QOWlRc05IVDVqMTBidEwzUEwrSEhybXR6YjdtOTlHc280VmZQeVd0WE1H?=
 =?utf-8?B?SzJvaElCcVhHRHBYZEV1bUtRQUloSVp2bVg0bWY4NDVXc3pEWkdRQWRCQ0c0?=
 =?utf-8?B?SHBIVlA4QnBhMTlxU05Ba29TeHlrVm9TWmU5ZnExVTJnb2RCait5VTRTTk1j?=
 =?utf-8?B?SHhSWXozT1luc0l4bVZETnUySGhxbGtJcVFidnRpaGE2ZjZmUnRzR0E5R08r?=
 =?utf-8?B?clZ0NG12emlmbTlCQ0NVakNrOU4yWHpITjIzV05SbzhjQTFpSHBWUzFJcUNN?=
 =?utf-8?B?U25zdmVTbWYwQnVIVlZkT3E2WFRQUkZwQUVtdkZIRkpMSkdEU0ZoOVlaMVc3?=
 =?utf-8?B?TXd1U20zcFZnOWVydGhVUVZLdWVDOTZ4MEN2SXBpN1BKZmhKa2NFMVZLUGRk?=
 =?utf-8?B?WEpoVVhBVnhsM1FBeTVoVW1KVWo0REJKZ3Y0ZTRDQTVSVHQyWlFuU3p5ZnNR?=
 =?utf-8?B?VldyTHBlVFZmRkZZSVBLV0ZXanVpVy9LU2Mvc1VjVzV6dFlOcnc2aUV6emd4?=
 =?utf-8?B?RUVtN1UyN3RQTFplNm9naTRvYkc4bTlDRjl6ZW5UYklYeCtIT01nZjN0b01Q?=
 =?utf-8?B?VCtGQmxTZGlTQTFZdmc5TVEyM2xNUDc1MzQyZDIrYWZxc1I2SkZXdlZWblZG?=
 =?utf-8?B?S3dJK2IyOTAzY21UcmFIMHRNWEg4RHhNeXNkQUl1QUErY3JhOE0rNHdwTk52?=
 =?utf-8?B?YXZFM1BNZUZZZkR6TEhtVERtTnQ1U0I0SXlDZzRROXhkZGM3YlBpcFlHOFJn?=
 =?utf-8?B?UjNqNHZ2Z25LMEtIVkxoTlZ5aEtHc0RBZkhEWWoyOUY1enJiaXQ0bU0vVFZ6?=
 =?utf-8?B?Q2xubjNiZy9nTm5OQkZubmdIK3lVTEMxOVJYQit0TGEzMzQ5QlB5QzFrTjVB?=
 =?utf-8?B?WC94U1NDRHQxSWltd3VrcFplZ3FQaXdOQ0NYSXRLUnhHOE53TTlBQjFPc282?=
 =?utf-8?B?Q21HWVE2RjJqajVaRk1OWURMeTUwZ1RhbzE4QzhXN3ZLRXREYWpJMm13NDJl?=
 =?utf-8?B?SzM1VHdnTjNyaWVnMG44Z2lqem5ETUxFRGd3TzU0ZnY1ZHJXbGRqTE0yS0R0?=
 =?utf-8?B?SklWUnlmazVPRXo2QngvcFBBeDdyUXFXMXZpTllpbFhpSTduajlQN0EvOXNG?=
 =?utf-8?B?eFAwemVzbW1SQ29ZdmJDYm9Sb0lndlg0aEdlZ2VZSkZSczNYT29RcjFrNHNH?=
 =?utf-8?B?eVdwWFJXdGU1NHYyWWpHNjBBdDRyYWdoeExIWEcra0EzY28xaUtXWVBoS0JE?=
 =?utf-8?B?K2tkVTVIb1NMZXlKWDhTU1dEbkFvWkZ3MEFiL2Q3cG9sNC8yY1g0ZE1vTzg5?=
 =?utf-8?B?dXpWdWhOVmpzOUpKWFA4dmlFN2o4VHZMQXpWWGtiMzBBZHpNbjRGSWRQekl4?=
 =?utf-8?B?SWd3WlMvQnM2Ui96T1h5UElpZ3J0V1p6MWtlMmRLNHNFNURlbkl2SEpqS3lD?=
 =?utf-8?B?czZ6OEFHT2M5eGx1dFkyMzB2UE90TEI2ZVdHYVQ4YmpiNlVnRTNqNXVlOUhC?=
 =?utf-8?B?TWpwRVlKb1pZcWdMZDV2UXBySHFjRHAranlEWTJZem1GS05CZmJNenI2Nm1E?=
 =?utf-8?B?T2RnTnQrcU1FQVBUNnB5K3EvbGM4cW9JQUJVMXB2TENwc2tqRE12ckJtRGly?=
 =?utf-8?B?M1ZSYjZiWkZDSHZ1anhHOUNTZGhnL1ZUZk5BQ1QwVDBHSDJNVHlqczlLNmZC?=
 =?utf-8?B?T25CM1B6S2MxWkJDUEJlZFhwM0JYdGVaaEZCUlUwUzQ1dzZJbnBjS25kRHVS?=
 =?utf-8?B?SzYvbEllTDNVZm9vbElXZGtIbkFTNGc5b0ZNMSt6S0dSelRUcDQyYU5kUUFI?=
 =?utf-8?B?bUFIRmxvZy85elhZaUxoQlRka01SUXNiUDQ3U1dlYUdTaXM4dVl1cDlNM3BR?=
 =?utf-8?B?Y0lWWVloYlE2c280ZHhMcGtGeHFzRXJxOHFYLzJqSE01YlNRUit5d1F4bllz?=
 =?utf-8?B?K25KWGZsZ09Yazl4RlhxUThnM1RXLzg4WnROMXRURmFueEZ0d0UxU3VrOG4z?=
 =?utf-8?B?VVArek1hR3RFcmNDbTRzZ0hJclNxQmdaNkRBeUowbjFYa3hXQzFsWTFXWktO?=
 =?utf-8?B?N05hMDh2NmlpZEwzam8rTjZlOTFVRTlyYkNlTkFNUitTc2J6d1F5UmExK2RY?=
 =?utf-8?Q?2uZ8/gw+IDou8axzDGXksJ97u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b829d315-8f14-4d19-b73a-08daa0a9ad7b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 16:59:44.8860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40INkdwp4UZJtN2zA5qzagNkb+Lux9l/H3XNmzJc1OxzlTaL7sOF6JVQltFuQNnkFvdAObni1TKzLDzF7nf0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Michel,
Thanks for the review coments.

On 9/27/2022 6:24 PM, Michel Dänzer wrote:
> On 2022-09-26 23:40, Shashank Sharma wrote:
>> AMDGPU SOCs supports dynamic workload based power profiles, which can
>> provide fine-tuned performance for a particular type of workload.
>> This patch series adds an interface to set/reset these power profiles
>> based on the workload type hints. A user can set a hint of workload
>> type being submistted to GPU, and the driver can dynamically switch
>> the power profiles which is best suited to this kind of workload.
>>
>> Currently supported workload profiles are:
>> "None", "3D", "Video", "VR", "Compute"
>>
>> V2: This version addresses the review comment from Christian about
>> chaning the design to set workload mode in a more dynamic method
>> than during the context creation.
>>
>> V3: Addressed review comment from Christian, Removed the get_workload()
>>      calls from UAPI, keeping only the set_workload() call.
>>
>> Shashank Sharma (5):
>>    drm/amdgpu: add UAPI for workload hints to ctx ioctl
>>    drm/amdgpu: add new functions to set GPU power profile
>>    drm/amdgpu: set GPU workload via ctx IOCTL
>>    drm/amdgpu: switch GPU workload profile
>>    drm/amdgpu: switch workload context to/from compute
> 
> Where are the corresponding Mesa changes?
> 
> 
This series here was to get the feedback on the kernel side design 
first. As you can see from the patch history, we have already changed 
the design once and this is V2. So I thought it would be a good idea to 
get the feedback on kernel UAPI, before starting sending patches to 
mesa. The mesa/libdrm changes are ready and I was using those mixed with 
libdrm/test/amdgpu stuff to validate the series.

Now I will fine tune them to match the feedback here, and send the 
updated series.

- Shashank
