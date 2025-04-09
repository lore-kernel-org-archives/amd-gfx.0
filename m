Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81497C369A4
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 13:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EF810E8C2;
	Wed,  9 Apr 2025 13:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nYIertZK";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2043310E8C2
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 13:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe5to5ixPv8jQ0WHDZ0rgoBPuW3sTuy8wUel0dYo0jsbXd4MsRmdJY5KKobXfYmoEaPQwO/TEgIn2T8WjGqqOMvjkG4iDWP55JTsvLXgacKxhYhCFDUULZaYy4SXL5F9T5yE1g2lJ+zsc2gceZuNkz7tqX1kbh5rz1vdk1KickS+BsjeJPjTSKFOI8GlbdQM9nmFIOEriBFHR58KJFzJEeweLtqUAtepzKpVd2Ncj/4qQO81mkU2R7NvGX0GUc+Fq4gMvLd00pgO7Mb+dHID4bcm/eB2+dPG1w6wl2Y/mKG7k/aQ/WN7fch2LREIx1EvgIpr8XMT7CU4oCNIjvbBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWJR+xag8637UKr0X+TNZptcqgbOE+qrVxUhacqlXyQ=;
 b=eXwbyb7NlxGWY0AU8T8RhjnYHxCE9oSQITcH8cqxGqcUiu/91fd/LWANbk+lmKAl9j5f9azDJGIw1KNwCoQAOO5muRJ+hPbjh9g9XmNxk6cMGg1u7y4WaQ7Po1P8rsik5OuhM2wJX6/JxQmnn7Ugyuv48lloxMWVZ7cMTRq5a39TYTjVV02lmimCq8Fu8x1XjBsFnWVjuoJ51Z+mJ/s2daARmKw/qcd4to2qriby8N0KtOl4y1YZwn17FxP/NTriAZxVH5p8yriH+Qz4mWdWPfGt9tWLpAw/yooOtpYynJSvkIifVANpcCf4ll3a7zxUhvQ9UQTNYWMNgLuDAM7qBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWJR+xag8637UKr0X+TNZptcqgbOE+qrVxUhacqlXyQ=;
 b=nYIertZK0eaA2lzMRFVIlOTUJJAndKPXoC4ZgU0m2t1EX2KkqiJPpJq473AKuLIMApVB4upNnxxSunCqHllMMUHGI3r5KYp00VxoLpDCwfpzYYdgTcdhMSb8V3uJsPqQsGuT7Zk0BVANh4kaGuoxAOb/eZd2l+ZcDV+5q3rRW0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Wed, 9 Apr
 2025 13:41:27 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 13:41:26 +0000
Message-ID: <c2270a3b-943d-477d-9220-593e05631d82@amd.com>
Date: Wed, 9 Apr 2025 19:11:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: cleanup amdgpu_vm_flush v5
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250409104500.2169-1-christian.koenig@amd.com>
 <965773b6-40fd-481e-8699-ae7234cc1934@amd.com>
Content-Language: en-US
In-Reply-To: <965773b6-40fd-481e-8699-ae7234cc1934@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:4:54::26) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: a86442b5-e5cf-4b48-2207-08dd776c393e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDVDMnRRblhDUzlJeVlBNEVSYWpCNXBmZUdvYkMrV1FDeW9QbVNJUU9QYS9o?=
 =?utf-8?B?QjB0L2t4WGtPalNNVVhhOWl1VUgwN1B6OU1CR3c3ZVpRNWJYa2R4a3pDdXRN?=
 =?utf-8?B?UW1HcmYrQitZQ09XYVUvRW5vekdGZ0QrVmdMUXVVVDg3eGpCQ1NCTGdFbm0x?=
 =?utf-8?B?bm5MZzVhZ1hhTXpxQ3NoejQwTUI2N2FDaHJxaE1Xc1g0aEhOdHBid0JrZzlZ?=
 =?utf-8?B?MDBRTHFXbjZpeHB4K2VnSlp0MGwxVFNKYTFXZ2g1TWZGdHUwdWlmallTY1Q4?=
 =?utf-8?B?UHlHOVQ0ayswMVNmZnVKSmlPUlVCTHZYSm9YZDcrY3ZjYmhJU0E3RjY1Y3lK?=
 =?utf-8?B?ZzdzMEZ6cCswL3krdDJiVU5oOVU3R0JCT1YwT2ZpWVQ1RTRSemhBNlNlcE1k?=
 =?utf-8?B?Z1VHMWFDamZ5dWcyKy96TCtPZUNOTTRqMXhTVzI1c1ZRSzE0SmFUVUtIbzU5?=
 =?utf-8?B?cXcyL0VGODNDcjAxdEw0SW56R1hxK3pQQ21MNEduRHRXQVdmR3F5RW1uR0Iy?=
 =?utf-8?B?NmRhc0toKytKdXNlazlYeGRaNmI2b3pLVG8vLzZQSkFPU3I5b1cyNzJoME9E?=
 =?utf-8?B?RTgrUEZCbERrQU9HNG1OOU1DQUZwR1lBdnhTM1RUWUNQZndWRDJJYWVCSDk0?=
 =?utf-8?B?R0txbjJCU1A0SjRERTI5blN6SlQ3SVdkbFpUQm15dytXbVdGdEVSeC9VVWY3?=
 =?utf-8?B?ZG84QVNlaEhGQmtkYm1STUt5c2ozMTQ4blUwM2V5TWk3L2doMldaKzFSdlpE?=
 =?utf-8?B?cmFWV2NLVzlFNXVJTDN1cUlLVHlwRU83TXlzK0hrYnVBTUg5ZDZGRkRlU1JV?=
 =?utf-8?B?eWtVMWhXSnFuU0ZRbGswbk52NlRjRmVTYjVXQmZRaitRVTlhZU9ndFFLbjRX?=
 =?utf-8?B?c2lOL29mMXZkNUpOZEQ5R3k0RVZlSnFrd25HNmtneWtJVGk4YkVKUWFyWk5h?=
 =?utf-8?B?TnNFTXd6Vk5KR0hNcmtEbjdtay9GMXluMGlIaDNybTdGenJ1cDlFeERobzA3?=
 =?utf-8?B?c1BMM2U4a2RUYUZoclM2WGU3bFVlK3ROb1BUZUVFZ1hWRFlGY3pEMzdTVGtH?=
 =?utf-8?B?cDFQN2NsWEtSc21mZGZMOThlci9TS1I4cExlTnBuRVBQazhyWGpTQXNGeEZG?=
 =?utf-8?B?SWNnLzJHT0QvZUFpZ3N3ajZvclREUmRDL0h4Ny8wSUhiMTltaXM4UWplcER6?=
 =?utf-8?B?eTgwV1FYb09YczF2VGo0ODE4TWtHVW8yVm54bGZBSlp1OGZYREQzRlRhVEhH?=
 =?utf-8?B?elVFb2JhRkRKSXdJVXdzYVRlQ0lOZWd1bndsNjdXdTNiK2tuM1RkT3ZFL0RE?=
 =?utf-8?B?cjkyNXRVVW1XTHNwSU8vSzAra0FVYlI1WUsyYjlobzZXSktLSjdJOXFpOGNE?=
 =?utf-8?B?ZXBrekl4K0VSTnpZTk9HQmhra2FEK2ozZUNIY3hmZHBldTMrRGR0aXdNVnNk?=
 =?utf-8?B?Nmx3bnFsTWw2ZXdpUkRTYXh0eEg4dnZBMWdmQ0JhWUhObWE1aDBsenZQakNX?=
 =?utf-8?B?OE5JWnMxRWNMdXN3U0w2V256RUZmMi9aaERrU21WVG9xRUZBZ0xvbW0wbjVn?=
 =?utf-8?B?R1VUWExmc3h3UDZjWi9wOWVmTGdXemh6OFVjMzF4WEkrcUJzT3ZINTl3YUE4?=
 =?utf-8?B?RW1sOW5sdDZqdHRBSGZlRm9kRFFTdUFBNmJINnRKQU84UDdUV0tmTlZRdzdV?=
 =?utf-8?B?UnJ1YXRXcTNsZ0hJVUE1SE1BT0k0TjRvOEVVUkNIL0FIZkh0UFlreVZ0SGJC?=
 =?utf-8?B?OFhyUEN6L1ZxUTlERTNCYzhyTmVuRWMwbm01OUFKZ3kyRE1vM1V6NUdXa0Vm?=
 =?utf-8?B?UGV6cUJqOXh0UktML1JZZHE3MkRZRC9aWVJkdHhXOUhvQmtBZHNoS0RCdzMw?=
 =?utf-8?B?eXpiR0dxYXBremFVNG1sRXEvMVcxUnRrdUJQaFhBVmJ1QUJ1YnJ5Yitnek1W?=
 =?utf-8?Q?TnZOj+Rv0f4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGNjK3d6UUhiQmRxZkJPSDdMaTlVTGFSWitIa2w2ZFZvdlFBUWtWL0tOV25h?=
 =?utf-8?B?WSswM0FCcUpBNkErc25oL1c1dnlaNEZVemtUb2FHT3FUc0oyRFRNQ2J2TXJF?=
 =?utf-8?B?ZFFJbk5DVE42MDFGWStsakY1QmcrYnN6enMrNHcxQVE2dit5QkZCZTE5VTdY?=
 =?utf-8?B?OUQvQ2ZxSWVyZm4zWEpza3JqZ2NXdCt0TzUyR3NLK1lmbTZscGFPUnlXNE5W?=
 =?utf-8?B?cHNRUWo5WHRBKzI4YjF2SWtVSy9XZUl4YU1HdnBORmFROGg3VFNGWDQrbmlB?=
 =?utf-8?B?Y2tpeE01VSt4TmJJSWJ1OUl0eVNuVmhlSjBzcVVldmViWVlXNmkxcytNMFBj?=
 =?utf-8?B?aGJzZFRPS3AyVnB0cWZiVjRlR2VzbHFrd251eGdnamYrdWFpcWJveGdIcGpZ?=
 =?utf-8?B?TVhNV3RhSHJYNERyS0tSbUpWMVd6SG1LeDNlbU04ZUFKV3ZXNWwxRVhLQld5?=
 =?utf-8?B?c2NpWjVBSndUSGNIMW0rR25YaE10d24weXo1WXU3cXh0c09JVzkydkJWZWhz?=
 =?utf-8?B?WTZPYjBlamx6REdSMGttckpWL21YY1lVVE9TOXRFTUt3Q3hGbGxScy8vYlpm?=
 =?utf-8?B?SWNkNnViWmpGc21TTjlzdWI1KzJSRjNTTk5YYklaWWdmeDdHVW5xL25TcVoy?=
 =?utf-8?B?NWhkaFdQSGxSYnJpRVZHcy83eDlvK0M2UlZDNmtxcHI4OFlYMFNteTJ2SkhU?=
 =?utf-8?B?bU5QSEdXMUF1OEh3OGNaUS8yOUlxZWRaZ1hOYXRFTmU3S0NIekh0Qkh2WSsx?=
 =?utf-8?B?WWhueW9aWWVhZjlBL0VQUlZad0x2TWt1Q0lBV0s2QlBwTHQ3TUtVSkhRSjd0?=
 =?utf-8?B?NGpxM3hjQUpGc292RGpFMFA2bk82KzFwVEpadjRJSnRlWVZZSTJ1azhiR3hD?=
 =?utf-8?B?b3hqd0hycTV2cUpsVzJvUWVqSHNROHZja2tRYkpDUTJCblNSL1ZpRHVhWXQ4?=
 =?utf-8?B?WEZhbU4wT0U3YXIyZURFbk5XbnJnWjA4MWdDWVZmSjhCMXF6L2xFUGplZ0Vx?=
 =?utf-8?B?MzJDWXllVXVTVVo5VENVdU1qSzZXanczWENyejFzbVhiR05aY3dJcU8vY0Fi?=
 =?utf-8?B?VVVSZ1pNMisra0pmN3N4T1ViOGxQLzlJMnJSMllxbEtIcjdVWmhSdVp5KzYw?=
 =?utf-8?B?RDdHcUExbUVxSlIreTRjMGYzN0xZZkdLT0xVMmxYQWtQMmROY1FGWkpDcmdV?=
 =?utf-8?B?ckFCZ1VTVEVxQllXbklJT21rZHpqQlN5aS94M3ltRkd4ZGdFQm4rZ29BcVFD?=
 =?utf-8?B?UWcvOHBROVduNlVzYnVnRUZ0L0dUWGRQOUZGMWh0Y3FFRWZnN1BpTkVsRWFS?=
 =?utf-8?B?MzBXc3hTUStGVFEyczZ6S21VaFJNWC9NTEp0dXZHRjN6SFRBOU4vNWR1QnNt?=
 =?utf-8?B?d3YySFBEZEtEWHVobndNUUFJdWxnKzdLMlY4VDUxRlRGdEl3bktPMUlJVksr?=
 =?utf-8?B?NzlCd2NudExrUlQxUDR2MENpditIRkpsdlVHZ1NlMVgxMTVJUm5yTXlZdytQ?=
 =?utf-8?B?a2FsR3ByOUt0WWJMaW5rRzBWTjc0WitydGxHcW5udXR3MmNuWFR3QXJvRnRt?=
 =?utf-8?B?dkJaMGNZRlRpcnJKMXNiZ293REJuQWpyL1pJaWJMT1FjenM5RldNSHQyem4r?=
 =?utf-8?B?bTRYOTdEaU9LZExZMmlnRnNXOHI2aVlTeVV6YUN6aktGOER6VlJ6SWFhSzYw?=
 =?utf-8?B?TlZoWmtTaTlpQzNtSlhrNU11STlMUlA0b0ptZ25wTWZ5YlBUS2c4TnBBc05H?=
 =?utf-8?B?M2pwZ3F4VU9aSDJ1TEY3L0dhYWVzRkJLeWdYSFpnUDdmSXl0OXZlVWEzUkNv?=
 =?utf-8?B?WXJ4c09CaGNvd0l5Z25Xa2dBM21UaWRiUlZNRCsrUG5RSUZDNG54Z1RXY3Rn?=
 =?utf-8?B?T3piWEh1U1g1Tk9SMkR2VWM0VmpDY3FpUEVaNWc5TnRFSHFlWG9RUk5PM2di?=
 =?utf-8?B?bmh3eXM1Y2xKbEZSSFgzeUpYbWRxNG0wMkl0czY1aVF0Q2x1WVV5Q1JIYk1v?=
 =?utf-8?B?b0MrenRKbzNlL1BCMHdkUnc2TERsVEtHdTI4TWdZcmpNVi9sQms3aTVuZWN1?=
 =?utf-8?B?NUtUWjhQeUlHYi9KVnpaRnJXZ1F0Rlo4R3kwUldyL0NhRExMd29KMnVIb1NF?=
 =?utf-8?Q?kCSFXRb0d23VtOYYVisFHskBH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86442b5-e5cf-4b48-2207-08dd776c393e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:41:26.1103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wztL0Gdr7BKVtN3us6GhHOKSP5Vpv9DwdSvrm1K1t5FIAWez6jTPnmuI+2gXc3jspgYjanCotOoK7H7s8mCHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
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


On 4/9/2025 6:45 PM, SRINIVASAN SHANMUGAM wrote:
>
> On 4/9/2025 4:15 PM, Christian König wrote:
>> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936. Turned out
>> that this has some negative consequences for some workloads. Instead 
>> check
>> if the cleaner shader should run directly.
>>
>> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
>> if the VMID has seen a GPU reset since last use and the gds switch
>> setiing can be handled more simply as well.
>>
>> Also remove some duplicate checks and re-order and document the code.
>>
>> v2: restructure the while function
>> v3: fix logic error pointed out by Srini
>> v4: fix typo in comment, fix crash caused by incorrect check
>> v5: once more fix the logic
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  6 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 94 ++++++++++----------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
>>   3 files changed, 39 insertions(+), 66 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index 802743efa3b3..30b58772598c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -189,10 +189,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, 
>> unsigned int num_ibs,
>>       }
>>         need_ctx_switch = ring->current_ctx != fence_ctx;
>> -    if (ring->funcs->emit_pipeline_sync && job &&
>> -        ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
>> -         need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
>> -
>> +    if ((job && (tmp = amdgpu_sync_get_fence(&job->explicit_sync))) ||
>
>
> Direct assignment in if condition looks like may not be allowed, may 
> be can we split this logic , something like below:?
>
> /* Check if job is present and get the fence */
> if (job) {
>     tmp = amdgpu_sync_get_fence(&job->explicit_sync);
> }
>
> /* Check if pipe sync is needed */
> if ((tmp || (amdgpu_sriov_vf(adev) && need_ctx_switch))) {
>     need_pipe_sync = true;
>
>
>> +         (amdgpu_sriov_vf(adev) && need_ctx_switch)) {
>>           need_pipe_sync = true;
>>             if (tmp)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index b5ddfcbbc9fc..8e99dbd70968 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -596,37 +596,6 @@ void amdgpu_vm_check_compute_bug(struct 
>> amdgpu_device *adev)
>>       }
>>   }
>>   -/**
>> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
>> - *
>> - * @ring: ring on which the job will be submitted
>> - * @job: job to submit
>> - *
>> - * Returns:
>> - * True if sync is needed.
>> - */
>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>> -                  struct amdgpu_job *job)
>> -{
>> -    struct amdgpu_device *adev = ring->adev;
>> -    unsigned vmhub = ring->vm_hub;
>> -    struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>> -
>> -    if (job->vmid == 0)
>> -        return false;
>> -
>> -    if (job->vm_needs_flush || ring->has_compute_vm_bug)
>> -        return true;
>> -
>> -    if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
>> -        return true;
>> -
>> -    if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
>> -        return true;
>> -
>> -    return false;
>> -}
>> -
>>   /**
>>    * amdgpu_vm_flush - hardware flush the vm
>>    *
>> @@ -647,43 +616,49 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, 
>> struct amdgpu_job *job,
>>       unsigned vmhub = ring->vm_hub;
>>       struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>       struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
>> -    bool spm_update_needed = job->spm_update_needed;
>> -    bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>> -        job->gds_switch_needed;
>> -    bool vm_flush_needed = job->vm_needs_flush;
>> -    bool cleaner_shader_needed = false;
>> -    bool pasid_mapping_needed = false;
>> -    struct dma_fence *fence = NULL;
>> +    bool gds_switch_needed, vm_flush_needed, spm_update_needed,
>> +         cleaner_shader_needed
>
>
> I think, should we initialize the "cleaner_shader_needed" here, 
> cleaner_shader_needed = false?
>

or somehow, try to move below to here?

"     cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
          ring->funcs->emit_cleaner_shader && job->base.s_fence &&
          &job->base.s_fence->scheduled == isolation->spearhead;"?

>
>> , pasid_mapping_needed;
>> +    struct dma_fence *fence;
>>       unsigned int patch;
>>       int r;
>>   +    /* First of all figure out what needs to be done */
>>       if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>> +        need_pipe_sync = true;
>>           gds_switch_needed = true;
>>           vm_flush_needed = true;
>>           pasid_mapping_needed = true;
>>           spm_update_needed = true;
>> +    } else {
>> +        gds_switch_needed = job->gds_switch_needed;
>> +        vm_flush_needed = job->vm_needs_flush;
>> +        mutex_lock(&id_mgr->lock);
>> +        pasid_mapping_needed = id->pasid != job->pasid ||
>> +            !id->pasid_mapping ||
>> +            !dma_fence_is_signaled(id->pasid_mapping);
>> +        mutex_unlock(&id_mgr->lock);
>> +        spm_update_needed = job->spm_update_needed;
>> +        need_pipe_sync |= ring->has_compute_vm_bug || 
>> vm_flush_needed ||
>> +            cleaner_shader_needed || gds_switch_needed;
>>       }
>>   -    mutex_lock(&id_mgr->lock);
>> -    if (id->pasid != job->pasid || !id->pasid_mapping ||
>> -        !dma_fence_is_signaled(id->pasid_mapping))
>> -        pasid_mapping_needed = true;
>> -    mutex_unlock(&id_mgr->lock);
>> -
>> +    need_pipe_sync &= !!ring->funcs->emit_pipeline_sync;
>>       gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>>       vm_flush_needed &= !!ring->funcs->emit_vm_flush &&
>>               job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>>       pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>>           ring->funcs->emit_wreg;
>> +    spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
>>         cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
>>           ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>>           &job->base.s_fence->scheduled == isolation->spearhead;
>>         if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
>> -        !cleaner_shader_needed)
>> +        !cleaner_shader_needed && !spm_update_needed)
>>           return 0;
>>   +    /* Then actually prepare the submission frame */
>>       amdgpu_ring_ib_begin(ring);
>>       if (ring->funcs->init_cond_exec)
>>           patch = amdgpu_ring_init_cond_exec(ring,
>> @@ -703,23 +678,34 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, 
>> struct amdgpu_job *job,
>>       if (pasid_mapping_needed)
>>           amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>>   -    if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>> +    if (spm_update_needed)
>>           adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>>   -    if (ring->funcs->emit_gds_switch &&
>> -        gds_switch_needed) {
>> +    if (gds_switch_needed)
>>           amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>>                           job->gds_size, job->gws_base,
>>                           job->gws_size, job->oa_base,
>>                           job->oa_size);
>> -    }
>>         if (vm_flush_needed || pasid_mapping_needed || 
>> cleaner_shader_needed) {
>>           r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>>           if (r)
>>               return r;
>> +    } else {
>> +        fence = NULL;
>> +    }
>> +
>> +    amdgpu_ring_patch_cond_exec(ring, patch);
>> +
>> +    /* the double SWITCH_BUFFER here *cannot* be skipped by 
>> COND_EXEC */
>> +    if (ring->funcs->emit_switch_buffer) {
>> +        amdgpu_ring_emit_switch_buffer(ring);
>> +        amdgpu_ring_emit_switch_buffer(ring);
>>       }
>>   +    amdgpu_ring_ib_end(ring);
>> +
>> +    /* And finally remember what the ring has executed */
>>       if (vm_flush_needed) {
>>           mutex_lock(&id_mgr->lock);
>>           dma_fence_put(id->last_flush);
>> @@ -749,16 +735,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, 
>> struct amdgpu_job *job,
>>           mutex_unlock(&adev->enforce_isolation_mutex);
>>       }
>>       dma_fence_put(fence);
>> -
>> -    amdgpu_ring_patch_cond_exec(ring, patch);
>> -
>> -    /* the double SWITCH_BUFFER here *cannot* be skipped by 
>> COND_EXEC */
>> -    if (ring->funcs->emit_switch_buffer) {
>> -        amdgpu_ring_emit_switch_buffer(ring);
>> -        amdgpu_ring_emit_switch_buffer(ring);
>> -    }
>> -
>> -    amdgpu_ring_ib_end(ring);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index daa2f9b33620..e9ecdb96bafa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -493,7 +493,8 @@ int amdgpu_vm_validate(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>                  struct ww_acquire_ctx *ticket,
>>                  int (*callback)(void *p, struct amdgpu_bo *bo),
>>                  void *param);
>> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job 
>> *job, bool need_pipe_sync);
>> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>> +            bool need_pipe_sync);
>>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>                 struct amdgpu_vm *vm, bool immediate);
>>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>> @@ -550,8 +551,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device 
>> *adev, uint32_t min_vm_size,
>>                  uint32_t fragment_size_default, unsigned max_level,
>>                  unsigned max_bits);
>>   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct 
>> drm_file *filp);
>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>> -                  struct amdgpu_job *job);
>>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>     struct amdgpu_task_info *
