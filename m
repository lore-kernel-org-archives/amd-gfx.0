Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A957C71153
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 08:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6DC310E246;
	Mon, 28 Aug 2023 08:33:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1A910E246
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 08:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GR6Sw73Ve99uJObHbbOqU6ZuS12UHGzsjM1jzPyaRjbdXpKigqxFLW2OFGDqp+Tkl+YQ6ngaRgSA9qGTNGewW+lgrDcqswmKlKnhaMSSIpFdhMIJ3Rh5Wop57RZn/JBcNzV5Pu5QaNplCIXzvfpT9LuTzeTR48b+rm2ozfWNwvjiNVk2uS+bjaaPxlSMCQXH3BidCvfm+8vrhJhJ7VEJCgstos7qhK926P1Y0iqTmaZdHVKv1DdJEC3kkVqJfPJDMrI7rSjVlbTCXy4nxnR721fGK21CYtW8yreoPQX+VzaPQ51A/aqATG5pdYQOqWEaiEViAENyo64zYEv1xfXXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCAu/LwOwgv8kk25M9YdcTyMacjez/suSDPB3lAuFUw=;
 b=eisLmtcsamau9GPbOyqGYTPFRXKu5jdx9lg/chFPIU3ch4ijplUDga2NgQN2udy79kqRilio4M8i2Ly6k75biQG4R+DzaZ+EHPd9/1QP/RFTAPd0HCyVsv4KYNqz/zNYdPVh8joRj0Np6BkwwYtNt3WgAbDVKrIKVNNWpA9GAiVduDHZBxnpYohTRRZbRIMc9IfwsPd/huSOGaH//VjPPl8EMlNgIUJk/rGuVS3A7s9wVPb2k68z40x4odLM2bnq5fJW71dV+uwUlMNivx9uzij3dkxRw5kgm0Chrri6fvwNXbxPQISvPmUIF7YBoiDxYm2RDE4Kldbqc7Np30x5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCAu/LwOwgv8kk25M9YdcTyMacjez/suSDPB3lAuFUw=;
 b=pdM/q/oTRSpR5s+KeT2mL6sg9d+r6xlHQ9ECXmxYP1OPegmELiDjpTE2UCZrBXwMqBxYL8KoLV86VTtE1ETXCjc5mhN5LNfDH5+RBqET/XAD+2wfYM24Y6Sr1NTVS8tdR7+QZsuM7LwlrqcwZDbU4qBrQdXQ4iUcimkif5dQabA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Mon, 28 Aug
 2023 08:33:13 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 08:33:13 +0000
Message-ID: <ed33eab2-7913-0f4a-5a05-f763261a28d4@amd.com>
Date: Mon, 28 Aug 2023 16:33:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] drm/amd: Simplify the size check funciton
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20230825052204.1315534-1-Jun.Ma2@amd.com>
 <1c44f172-99b4-3981-a646-48d2b18ba149@amd.com>
 <b3df28b7-286b-7e5d-f6a3-ab144846247d@amd.com>
 <aaff221e-d61e-f2b0-bbff-c8208e067ca6@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <aaff221e-d61e-f2b0-bbff-c8208e067ca6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|BN9PR12MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: 34beb560-fbaf-4be1-130d-08dba7a16b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/A8Wq9iQfj8sz9QGVjYJHKsqXxENsKoHlqfspIXV2R8BUb/tUwQ9DDotPQmnXhrnmveIgB0V7njf5XV2fGqm8br99DlP5jZ5lKBtbeSU8dSLjbMtDDkW3f0AHT7fuayas58CJTf0Dtqam6hNlRpIDiW/cH32FPCWmx0APJh4X8jkYES5CeKhqB1OEsGHAnBjzEnmccc3UWp+c4d51QhO+QJBsmSEFFCorMXhFpz+cF6tDVb3Uf9PObdesKrQF52+VfTq6QkuH4j7aICBquiUoY3uOLHfTKA0kSnXvlTatdviFlCQoX6ggBj+jgPLfDq9hASFyL4iiFKrhyHL+UiCuwhyS6qFvodtMalATUq2XifJMjYypqhUXQmtKLbzWCoZpcF6dkrP7Ch5n90hzywG8y9hAV1k6NcsnuCV3sqh4AtUiUmbPK809dBy5naw31vuISxHRBrziPFATrbc3YlgvQQtdMXsGjIkGra7n8151WpzeuZYaxVlMID0W522HLZ39CrDpnjSMKkkMyAf3YU6m2wQKljqcQkXFGreKRkl8vzTL6p9shnAXrMw7gwtsv9BCv4LXycL1Wvqixst86IEEwET6adVJ0AA2pR02ADFuHLitKa2znsyws4KEYUncJUQfjSTkqkfDi1i12Wg/OLPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(1800799009)(451199024)(186009)(83380400001)(6512007)(478600001)(26005)(66574015)(2616005)(5660300002)(2906002)(31686004)(8676002)(8936002)(4326008)(6486002)(38100700002)(66946007)(66476007)(6636002)(66556008)(110136005)(31696002)(41300700001)(53546011)(316002)(36756003)(6666004)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXlHVkhMT2FlWm5yWGdlbjFMaHFvbjVpY1QxUFdJaHVGVFFIVzQ5cXQ2QWZT?=
 =?utf-8?B?cm9IdGptUGtNTWI2Y0JoRDNBN1NJOC8wamhiTi9HWGRyM0NRZnNhc2FsQ1Zu?=
 =?utf-8?B?TWdzT0NYMDZJLzNyODdPeTF2QzBiT2NQb2ZxN1hrcWZ1aEkwY1FjWDdzT0hR?=
 =?utf-8?B?SDFQM0NpMWE1QnprRmtWM2JTK1ZhbUozQkc2emxqQm5jcE0zZzFMcENJZW9T?=
 =?utf-8?B?NGNBdXhtN29iYys2OHdhMjh5UmRIT2JwdUh0YVZoR0N0WmdBRGRBZGVndHZR?=
 =?utf-8?B?R1JjNUdjK3k5ejkzbUc2OW0zM3h2SDdLeXhBd1pEdzRDVW1MdEo4eXVSYXR2?=
 =?utf-8?B?RWhFck5GdkxEN2dZbXp6elVISlpGcnp4QXZKZlZJTGNvT0RUcWVua3dRRkFv?=
 =?utf-8?B?NHpaR1B1S21BdlFWMDMyZ3BFNkJSUE9idzJPWituRmV0dEtSdGNhOFZVeVNi?=
 =?utf-8?B?TWV5MWNUOVJQQTZPYUpWWWFzdUJjelh6M3lNT3pVak5Mem5UcVVjZndaeG1h?=
 =?utf-8?B?QUdUeUkwZEtmcG82ck1qT1VHUVRVdS9Od1NZV2hJMm1jQXJQTFlXT1NJYk5M?=
 =?utf-8?B?bm9RbnhZYksvNHFYWEdPT0JVM1RvR0pGd3ZyUHoxdVJNd0hjK3ZjM2cwczFM?=
 =?utf-8?B?Q1RYRExhTkJ2ZWszdlNZT0FFaEhObC9JQzFWODNwZVF4azlCdVh2bTFUTWZV?=
 =?utf-8?B?dEpQelJEV1JTb01lcVhJV1cwZzJjdVlFTDhYa3AwNE1ja3QvSjBCQm9sR25j?=
 =?utf-8?B?NFFLTVdxSzNNNzZGRVhZL2hPTlY0R2V0ejZ4UmxyazZFeDVFWWR0NVl1OGtw?=
 =?utf-8?B?cm43TldoelZwc2lxNTR4K2E3OUxFWHpJRVNSbHI2MDlWbDE5Z0EwMndLWG4y?=
 =?utf-8?B?bGN4Wm1wVlBKeFl1TXNjeU96U0VZaGt1R3ExL3VlYlVPOEFrVm5ldjRKVUxu?=
 =?utf-8?B?dm1QTlRTL0lsUXZ1L0ZDRXRGdlVlNkJXT0NOSTJTcjk2ekdQaDAxeXBCazdw?=
 =?utf-8?B?Z21ENUtCYUd4TWhTbTVDTGRWQjVYWlpFOU5pTHY1UG5pcGNLSENVY1RVUC9k?=
 =?utf-8?B?MHA2V2tJQk85RnlWa1pEaWREdTZYa1FQRWxHdUY4dklQanAvWXp5NTVNS09z?=
 =?utf-8?B?UWR0VVQ0dUU4Rk5ZcU5CTzBSVW9YdkNmN0RaTU0xQ1pocDlTcVhFT0tFR2ha?=
 =?utf-8?B?Y0dMRmIxRWRqNk9jelhaSzVZbjdYV1FhUUhWaC9lYitLMzQ4S1MrbDQ3NmM5?=
 =?utf-8?B?c1lsNGc1b3JmNDdhODhMY0I2UkVqcnhITkt2WTJENzRwUlg2YzU0VkRPK2pI?=
 =?utf-8?B?MVdOK2pXNmtodXNVaVQxWnpieWdlTk14TUhMS3Y4eVpyTEpwbzBRMnh1dG9T?=
 =?utf-8?B?Mmo4Z2wwZTJ2aG9OSzZNMTNUSnh2Q000ZnFqN21XVnN4WWZsazFzTDNTRERl?=
 =?utf-8?B?bktxT2k4ZDMwRFhHZGV5MHZhUjUwMVpSWllRem9keGtRRW16MHdmRXdtOFVU?=
 =?utf-8?B?TUJHeUwxWDdyTERhV2RocjR5emlPYXAxeEcrdTBsRDh6S3B6dDllaXVUeXkz?=
 =?utf-8?B?RWVaOXNaUE44M2tJSnlkRm5tZE5uMUNmS2xNRGFmdFJpazkvci9uOGJOVUpL?=
 =?utf-8?B?SXJtMDdSbys3aDNpeEJpbDBTK0pQSGZ5aXNkeEVmRlJSWG90UVF3MTg4Z1Bx?=
 =?utf-8?B?WVYyeVRtUENzRTY5bXlPbWMxVUd0aWN4bTR0WXVSV09aZDRSdnNGeHNmTkRk?=
 =?utf-8?B?OHFsZE40WjVFdmgxNG5ZK21PV3RNOWJhcUhFSk1pMERxei9zNzQzbXlSY1JJ?=
 =?utf-8?B?dWVwOXYxSEpzY0VuVlZtdmJvbW0xMVBNTkJxR1lseE5WWUErWkZRTGVQclFk?=
 =?utf-8?B?ZlRWQWt6ZGFCMDVYVklxK2svMElMeWZMTUc5aDVuTUwrdUhiV3Urbm1mUlF0?=
 =?utf-8?B?dy8remo1SmxCRGUzTWtTeTUrMHBpM1gzZlpzaDBGR295aWdQdkZmSjRpV3BY?=
 =?utf-8?B?RkhtSlpBeFZkU05YTnhwemhtcjFRY2VFVzNEemlxUlIvU2g1R2RjRGVmTFZq?=
 =?utf-8?B?VStEM09zdnUvRWVkZFhvZkg1L1VDNmtaRHZNQitZcVJXcDlYci9wa05VbHcv?=
 =?utf-8?Q?YAsflXYrIGLvjKNeKtNs5HAQ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34beb560-fbaf-4be1-130d-08dba7a16b0d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 08:33:13.2129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCi2r8swXwXiYHvPuCVyWZt3JXpgFCA+J67c35G9t3hwGiXs94ESR9gNcgovbikJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
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



On 8/28/2023 2:00 PM, Christian König wrote:
> Am 28.08.23 um 07:09 schrieb Ma, Jun:
>> Hi Christian,
>>
>> On 8/25/2023 4:08 PM, Christian König wrote:
>>>
>>> Am 25.08.23 um 07:22 schrieb Ma Jun:
>>>> Simplify the code logic of size check function amdgpu_bo_validate_size
>>>>
>>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 +++++++++-------------
>>>>    1 file changed, 11 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> index 807ea74ece25..4c95db954a76 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> @@ -480,7 +480,7 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>>>>    		*cpu_addr = NULL;
>>>>    }
>>>>    
>>>> -/* Validate bo size is bit bigger then the request domain */
>>>> +/* Validate bo size is bit bigger than the request domain */
>>>>    static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>>    					  unsigned long size, u32 domain)
>>>>    {
>>>> @@ -490,29 +490,23 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>>    	 * If GTT is part of requested domains the check must succeed to
>>>>    	 * allow fall back to GTT.
>>>>    	 */
>>>> -	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>>> +	if (domain & AMDGPU_GEM_DOMAIN_GTT)
>>>>    		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>>> -
>>>> -		if (man && size < man->size)
>>>> -			return true;
>>>> -		else if (!man)
>>>> -			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
>>>> -		goto fail;
>>>> -	} else if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
>>>> +	else if (domain & AMDGPU_GEM_DOMAIN_VRAM)
>>>>    		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>>>> +	else
>>>> +		return true;
>>>>    
>>>> -		if (man && size < man->size)
>>>> -			return true;
>>>> -		goto fail;
>>>> +	if (!man) {
>>>> +		WARN_ON_ONCE("Mem mananger of mem domain %d is uninitialized", domain);
>>>> +		return false;
>>>>    	}
>>> That change here is not correct. It's perfectly valid for userspace to
>>> request VRAM even if VRAM isn't initialized.
>>>
>>> Only the GTT manager is mandatory. That's why the code previously looked
>>> like it does.
>>>
>> Thanks for your explanation.
>> How about changing the code to the following?
>>
>> +       if (!man) {
>> +               if (domain & AMDGPU_GEM_DOMAIN_GTT)
>> +                       WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
>> +               return false;
>>          }
> 
> Of hand that looks like it should work, but I need to see the full patch.
> 
Thanks, I'll send v2 with this change.

Regards,
Ma Jun
> Regards,
> Christian.
> 
>>
>> Regards,
>> Ma Jun
>>
>>> regards,
>>> Christian.
>>>
>>>>    
>>>>    	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
>>>> -	return true;
>>>> +	if (size < man->size)
>>>> +		return true;
>>>>    
>>>> -fail:
>>>> -	if (man)
>>>> -		DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
>>>> -			  man->size);
>>>> +	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size, man->size);
>>>>    	return false;
>>>>    }
>>>>    
> 
