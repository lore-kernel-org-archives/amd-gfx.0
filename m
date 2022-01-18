Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03457C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 08:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630A411218E;
	Tue, 18 Jan 2022 08:13:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C917E11218E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 08:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaCFC1D8jHne2Sqefg/6OMXKxHrv6Uuq0CgT8Fi4GWQ3XA7eMcks0yllbJgo5+VGkDBB776cKaJTYqvXy+XtS9vZ10RzJkbnSLFZyHmIavrHStZngQ6Ynq8gAeoOozWgtJzufVPCEWIM9YYNGNfz/FtrVziEWrc3ezHU9Phr8cxsEjbSDXi7SlTPO2Kl2LgoQVcnAidtC5CbDWuY2a/LDeJc7V7bDTUUKDWNbXX2osjwQgUYidXVeOA57FAI94hUiGFNeL+/2q+TgK4e2e6srRDNWXFIiO+cT9sZMx5OnK57I7Ys0mwFHLBS0wHnW9+YZUS7xFcJImmhy1SxGVP++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM/S05B7DXGxbTtL1bFfYNOEW17LxujtGwrTrJrwN3A=;
 b=b6eXuEx46uqiVKMBpC8ih8ysVKzmlSXjKZ4MJ9c9A56uznn2DauIPq9F8bSMlyXpYvi8LLmku4Aq40KxsHe7WVC/9gnkfhIsGAH1eqkHIZLkcyylECSdBpt39x9LbFU80t/bCX0I8ACmI3AiD5caR7/GwHc/UrnUujbNMii9kHb/y+w4YHWsisc+mp4XvU0TYePP3tJvYxdA0AQQyzvPYKRXnBnXgMxb9/mETVh8+HvIt7W48Inds+SKGjpeDfXczb1dC7hjvjSBJu5SlDiWwq2FtsY1GZC1oIgD1SW+ZFJvQYHvYz4fBq7eQSSpWCF72aZ+UYum2mQWyYxAcOT6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM/S05B7DXGxbTtL1bFfYNOEW17LxujtGwrTrJrwN3A=;
 b=IxW6wYnSqcDvdlWg5vlI9JHbPklkjJ+ZKE22xmF8gLoBROV/XlPxK24b6C5Qvta1Inipc0EMUXaTXsmyDgi1wQ+K49dECVH0NI6hw48ajpmdCRqQrCCsOe80jfiYpMbXz6PIaadByyzmi9HCBX7kEyWvYLcYyPX8156ObqIrpuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB3970.namprd12.prod.outlook.com (2603:10b6:a03:1ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 08:13:44 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 08:13:43 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: fix build up and tear down of debug vram
 access bounce buffer
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220117234307.3820143-1-jonathan.kim@amd.com>
 <88f0e304-c17c-bc50-14ce-37c05d76a3b4@amd.com>
 <DM5PR12MB24692B8100BF87268D08FF3CF1589@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a01cffca-797d-0edd-d64e-e011b53fed04@amd.com>
Date: Tue, 18 Jan 2022 09:13:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM5PR12MB24692B8100BF87268D08FF3CF1589@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM6P192CA0080.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::21) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca8fc5c5-46f4-4fd8-7d54-08d9da5a7182
X-MS-TrafficTypeDiagnostic: BY5PR12MB3970:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3970BDE581E0A21C6AD5BCEF83589@BY5PR12MB3970.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: II4pAGGvXv/zZHlZYa5tY7uD7N9Oh+rEm7sqSJ/MOivdD++ROp0gb2Szvo15x/pMGTAndxpYIeaBTaz+cDQa2y5sLrLAQxwvnq7PhcxOPEtURaxWyAX9MSVRU8UVAovFEDVtt8d12SCMlXWW/Rh1hFTGVQGiGQuMDq7Eswp1u7EEd6F8lRDKjTago2qS9N/O8BMVak3LtPtuXkyaC12J4dvTHyTo5HGPesSIgFA/YcWAKfeKB306QAKITxv0Om1xF0kHFMbf57NNwLjNISMvdjFyRUWZT6ahllaYIPYkWNyKqJMOy1ngjR8aF1TOWbo7P55WCy7smsY764h+opsbV+514N51y0eUeT7qGWB2/+81R6I5vo2G7XUEpXS6mO2CXIquFyCd/OLX0iMmbz9bJgIZ+zSLi8muKRmfgkRDwWdxnJtsh/DvD/qtffj/hQvN/zDJ5a1NWCfQ4w8C45SQIBt8aQXLcmlHrKD1n20awjTXu/o91NmDyWdm2KpXDEIaCh1YVAF4ZjHnyJ4u95EoCIGuC8sd4FTsLk9Mj5pvnMrwRtJ7kRZol9jujX7pM7lNhSdFpWvGh8GlYY2bcepAwRC+cdohDaJFral+ToCLJmMefOJfGujdy3oyuFS+YhJikckcqNWdpwCYq4v7Zx4b9YjYxLjrGBVVRZxaRuZw44g7RV+LNgHN5jVf+3zRgAXTAiU3zHsIK5ndldTvEO/XvMWQQl+EHmhG7ijHB+Nkm/XwQ01CZaKslZ3V5iANMCX0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(38100700002)(6666004)(2906002)(6486002)(2616005)(8936002)(4326008)(5660300002)(508600001)(316002)(8676002)(66476007)(6506007)(36756003)(6512007)(66946007)(83380400001)(86362001)(66556008)(110136005)(31686004)(53546011)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHRLQmNTNEEyRVpPeVcxeG95SUhWTVVIMmkrNHRaR3hVZ0p5VkNVWVdYajhx?=
 =?utf-8?B?WnRTSmRyeWZVOGxob3lHZ3FOSkpiZU1uTHVEVTFKeFFrUU5XTWpDblJFRDJn?=
 =?utf-8?B?a0o2bm5hR0xwYmhsNFVpck5wQVRrQUpiSVU5NlZ3cnlKV3NCaldhV0Nvek56?=
 =?utf-8?B?RjNpcTJNLzRlL2hzbkRkSS9uZ3F4dGdsR05sZTYrU3VUZURpZjhOdUlMZXpH?=
 =?utf-8?B?VVFzbjdaS1J2em4vT2Y2M2Z6cklUOUFSZnZTQTlnbG03cFFPQldLajc2bGJU?=
 =?utf-8?B?QUVRUWE4TGtpTlZpb0dQdWpLU1Z1UG9NcnloZFVOdnNEbUtEcUIraTU4ZHA3?=
 =?utf-8?B?S0pIKzhWRXA2UElWTWJ5aU8xalA2dWJmY2x6NzdGcUkzV2pJOXpWUmdoQVY5?=
 =?utf-8?B?QytNWTFwYTN6VWhLNENhc3FRSndRdHlPcG1oMUw2bWs1eXdoM2N4WS9Ub2Fn?=
 =?utf-8?B?NzhtVTJKRXkwb3BTNXprbGFVR3FMa1U4MWFWbytMWEswTjJKK1ZQVmlrUnhw?=
 =?utf-8?B?VDNPeVFVWU1OY1lyd3NCdkQvc2hibUxiczJqRSsrYTI3eFY4NTZCREFNTGdt?=
 =?utf-8?B?N2ZMYWQya3dSVHRIckI5alVLcm1LQUM2VmdmbFFRbUlJVFN4eS8zUWM2ZytF?=
 =?utf-8?B?MG9qUS95bjIwVHBZUHJjbjYxVmttNmYxb0ZPS1JXYWxCQXIreS9NZi9oWWxV?=
 =?utf-8?B?Nnd3Ry82bjlwaHBPSTRreXkvbGNoSitYMEo1dzhGVDFZVjVtM1VlM3ZXMmRr?=
 =?utf-8?B?b3FDczRkSi85UVl3bUR5MkRXbnFxdFJSWmJCN3hHYkZoT2g3aVJFdXBRQzNx?=
 =?utf-8?B?RHdRS1RHamtlN29QU1pmTk5IWlZCbG9udFBjamxVOG9lVUhOLzUwcnFlOGhR?=
 =?utf-8?B?cmprMTRud3k2dmVEMHpKbWZvQ3VLM3E1bW9TZ0grUUtUeFd1V0tRS1JaeTV2?=
 =?utf-8?B?dWNRNWxPME84WG1vQkU1RDVGVVp0REtRVzNmcnljQXp1eiszN0RzY1prQXZ3?=
 =?utf-8?B?T0NXWkZxbkF1YkZBbTNQZ3QzK0thSU8zS2dkcTRFanpIcXRNV1pTWTY5UmJs?=
 =?utf-8?B?aU5Iem9Ed2F0SGt2M1VZZWdMMFlZNFZSdGV0U3ppY3AxOEdmM3NjQW5QM3lW?=
 =?utf-8?B?dnhBbFBHZ2dKMnVaWm9JVzRGbUN6M3VuaEFWSkZCbXJURCtacTRZRlhGUE1p?=
 =?utf-8?B?N3ZFcEtxd1NTMTl5RnM5YzlkR002NGg3NXBaUkxvLzVtRGlOTWxiNlRaTUJ3?=
 =?utf-8?B?ZUhackRXN2ZNWE9VZGtwS05rOE5qSFhwMjltaFBkbHNqSGhsTmxlMm5PdHpD?=
 =?utf-8?B?cTNiejRSQWlEOU9IaXJqc25UazJPT2IxR2tBazF4NGVTT3FmSFFQcktQalBt?=
 =?utf-8?B?bDgrR044TzJ0ak1KNTFUYThxZi9WMWhFbjc1UGNrNWRsbXlLMEtKcjFvTjNj?=
 =?utf-8?B?WERtRG1vRm1tMjFrMTBtYXFhQ2krajI4OU5xMEhaUW40b2Q2bUNJR3FQbG41?=
 =?utf-8?B?UHhVc2YxWlQ1dEtUWEhVNm8vTnRORk1yODVYbitmWUZmMDV6T3dTOXlWMG1X?=
 =?utf-8?B?K2JhVUg0dW5UMmUrb2c3bVkxbGxrVVQrbG51TkJ4aXVBSTN5SmlpMVRwSlBx?=
 =?utf-8?B?amk1ZER4UlVYT2xZVFE3K2RxYlE0SkVob3MwL0dRNUUvazFLN3ppNGJxeXlF?=
 =?utf-8?B?ZUZIeWp1Lytad3Y3SVpOMEttT3pEaW9BVm05eXhwMHltZXFJL29nck1ZNjN2?=
 =?utf-8?B?eUt2THprdGJyeWU4b2NCUWREdmRIVWhoL3U3WlNLZk1Xa0JHVHYyVnROVHFq?=
 =?utf-8?B?WkJPZ0Q2ZS9WaFJZTFo1TXJEdWlDSW5lWnlzT0pQSjQ0NXd5bzB5UXlwb0JD?=
 =?utf-8?B?VzBDaE90MFhvTElmOG9FekI2cDNLM2NLNjhkTnBQVDVud3hsR0E1b3NJT1Z2?=
 =?utf-8?B?RjhNd3ZTbDB2SGFhOGR0ZHFwT2RMdWxGTWs2L1hHSUkxbmFQaDJ2dUNnVXd1?=
 =?utf-8?B?MkFSUWRMbUI5REM4MVZzTFNEalNGVEwyT2o5Y2VKTDZTYzJIYkx2N0FYenBB?=
 =?utf-8?B?VmJjUkxDcUJRNXBUaHEyaUtKU1FXeWdKVUpxRnp6cmZMcXR1RkxEcThldlhH?=
 =?utf-8?B?M1BlWFpnZ08zT2VhL2NpdkJmK0I1VVE5bXBBTTY1ZzNuMWQyVGRiQmZwMVZh?=
 =?utf-8?Q?43Vg7U6Tiu8dYsvjXS2UmGs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8fc5c5-46f4-4fd8-7d54-08d9da5a7182
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 08:13:43.7330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tW7cRIgU5iqT3uh3+CGrQP89A3c9aoeXVLyzgEFyiWqzJ83ek6Cb/iszzYrLmvME
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3970
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That check is utterly nonsense and should probably be removed.

What needs to be checked is if the GART ptr is available and that should 
certainly be the case at this point.

Christian.

Am 18.01.22 um 09:09 schrieb Chen, Guchun:
> [Public]
>
> Hi Christian,
>
> Re: Well that doesn't seem to make sense the GART is initialized by the code around the allocation so that should work fine.
>
> Below is the calltrace during driver probe. When binding the page(SDMA bo) into gart table, there is a check by gart.ready, that will be set to be true later on in gmc_v10_0_hw_init. So a calltrace is observed.
>
> [    3.381510]  amdgpu_ttm_gart_bind+0x80/0xc0 [amdgpu]
> [    3.381580]  amdgpu_ttm_alloc_gart+0x158/0x1c0 [amdgpu]
> [    3.381647]  amdgpu_bo_create_reserved+0x136/0x1e0 [amdgpu]
> [    3.381714]  ? amdgpu_ttm_debugfs_init+0x120/0x120 [amdgpu]
> [    3.381782]  amdgpu_bo_create_kernel+0x17/0x80 [amdgpu]
> [    3.381849]  amdgpu_ttm_init.cold+0x174/0x18e [amdgpu]
> [    3.381951]  ? vprintk_default+0x1d/0x20
> [    3.381955]  ? printk+0x58/0x6f
> [    3.381957]  amdgpu_bo_init.cold+0x4b/0x53 [amdgpu]
> [    3.382052]  gmc_v10_0_sw_init+0x304/0x490 [amdgpu]
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, January 18, 2022 3:30 PM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu: fix build up and tear down of debug vram access bounce buffer
>
> Am 18.01.22 um 00:43 schrieb Jonathan Kim:
>> Move the debug sdma vram bounce buffer GART map on device init after
>> when GART is ready to avoid warnings and non-access to SDMA.
> Well that doesn't seem to make sense the GART is initialized by the code around the allocation so that should work fine.
>
> Freeing the BO indeed needs to be moved up, but that can still be in the same function.
>
> Also please don't move TTM related code outside of the TTM code in amdgpu.
>
> Regards,
> Christian.
>
>> Also move bounce buffer tear down after the memory manager has flushed
>> queued work for safety.
>>
>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  8 --------
>>    2 files changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index da3348fa7b0e..099460d15258 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2378,6 +2378,13 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>    	if (r)
>>    		goto init_failed;
>>    
>> +	/* GTT bounce buffer for debug vram access over sdma. */
>> +	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
>> +				AMDGPU_GEM_DOMAIN_GTT,
>> +				&adev->mman.sdma_access_bo, NULL,
>> +				&adev->mman.sdma_access_ptr))
>> +		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
>> +
>>    	/*
>>    	 * retired pages will be loaded from eeprom and reserved here,
>>    	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
>> @@ -3872,6 +3879,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>>    	}
>>    	adev->shutdown = true;
>>    
>> +	/* remove debug vram sdma access bounce buffer. */
>> +	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>> +					&adev->mman.sdma_access_ptr);
>> +
>>    	/* make sure IB test finished before entering exclusive mode
>>    	 * to avoid preemption on IB test
>>    	 * */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index b489cd8abe31..6178ae7ba624 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1855,12 +1855,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>    		return r;
>>    	}
>>    
>> -	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
>> -				AMDGPU_GEM_DOMAIN_GTT,
>> -				&adev->mman.sdma_access_bo, NULL,
>> -				adev->mman.sdma_access_ptr))
>> -		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
>> -
>>    	return 0;
>>    }
>>    
>> @@ -1901,8 +1895,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>    	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>>    	ttm_device_fini(&adev->mman.bdev);
>>    	adev->mman.initialized = false;
>> -	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>> -					&adev->mman.sdma_access_ptr);
>>    	DRM_INFO("amdgpu: ttm finalized\n");
>>    }
>>    

