Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E105C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 14:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B65C10EBA3;
	Thu, 19 May 2022 14:01:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7211310E592
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 14:01:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oyb9ZSpbk6uvmBn3tGYNh+D3B3cLWsFC4Toh5g+d0ZqWcyGHBWmZqpfDkEL18dQ1MPWwF+YATxtMU8S1OId5ysQCv9GUi4s7hEH1sEfwuMBt+Rh8SEXMV04go3LeUc6PcgcSAeHv9xVZNEunKFnQzRlxACpCOEmOXF8c34Zz3vYd7dJblgjnHq5Me+BY6ku3sCj7frrltfVU32MENQCDG2sAMjy7oz+eaPTir4JoMCiPLjNaV0rJVZUHzmB9cwTOOCSheI/NdlT40nGgWjqFYk3gAtnLEFoTUqne7GJ3EITVwe12hB08M+cZ/xS1SUk6Gu8IgtyxyF0HHQNzysuIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtimLF2J4Ymdol5Y45/CBG+LPA7W1f0BorK9EjSKL0Y=;
 b=Y4r14a9wkOzm3fAumOb0yDfcyw52tet9m1e/BC8miLxHn7wJ0Nld+IK5g5il5hDy0aEhWXTIAiRsGkCQ+84Foz6P+kINyNpoR/7hbPSL/5VjOkNpUVHyXce1zpGwPgtR7X3CS+BxNx1pn27Duo0BHejdw4Th80p4VTBXUHoF3Ihg6PmxiE3KIRbrl7qXA3ArXyBvEYnUayoAm5omWDO+gCCj7b8VXZ/OYZURVhwA1TWu0ftWp1p3Cbl1HbOGQjCyEQyCGWFDBQ2GjLmgCy6Hk2H6SSwCEEkA/IpThiYxDtkNJ5xWgANdAH9TmzquuVxtsuBLLv0b2G4KjCYX8WVCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtimLF2J4Ymdol5Y45/CBG+LPA7W1f0BorK9EjSKL0Y=;
 b=HiaDeLa/HB6EdzOkHCpHo10ATL9WgFjOntrBFBAQLM12XwjYRKChkOV/AAPpqATZhTCJ3PuESiIGgpgcjHlVlOzYbZZLdtNQHEMXgoj+A1u8hibZVECSSa6pgAvVrXDvFz6yFvICjHLyaOj28sjy7eI9qcVii/0cj7GythULE3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB3148.namprd12.prod.outlook.com (2603:10b6:5:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 14:01:42 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%8]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 14:01:42 +0000
Message-ID: <c0144b04-d97c-6624-3614-c749b6dda811@amd.com>
Date: Thu, 19 May 2022 10:01:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220517231108.14048-1-alex.sierra@amd.com>
 <20220517231108.14048-2-alex.sierra@amd.com>
 <e225fdde-d11a-2d83-c129-393f7284a6d2@amd.com>
 <55882ef2-9dc7-36cb-1d60-2c868ea1c14c@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <55882ef2-9dc7-36cb-1d60-2c868ea1c14c@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0042.namprd15.prod.outlook.com
 (2603:10b6:208:237::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12fda0e7-02a1-44ed-33d1-08da39a01a18
X-MS-TrafficTypeDiagnostic: DM6PR12MB3148:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31489F70D432CD6D99D457BBE6D09@DM6PR12MB3148.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgPfKzErzC6LeE+VCo5w1eaa8xxsZD5JPgMenDxN4i58JmbD10onHF6K9uoq9yw26zt4BwYenXzMgp46jOcxayNC2k7LkCGxjyCQ1t1Yv7vjYxalSlvugu/H0WLMornbb8BcEjSxVhBkMiOfJE4dePZZqV6Hk4ZlDqy6oqS6fNcvkpABuEga85uVePKWr+uqbI//nRim4yD6B40uYMdYz0Z2FGdw6x7i/c5LT5D3zH98fbKZ7ruCJLlqsfkbYm+H5IvCbXQ+JSTUn86p3gtdqQ9l8Mf6EtpqLEKH3R2fl9m/vTi3WvgsQ3rnwlDLSvqTUdUKj+f4u0/HFD2bXjYsdHNxFRfKeFcBRYnkEuoX6pbZyKiDrbGU0ftci7xUAoOOqoOOfSPOXnn1aS7oOtuAN43pfPWoyNbsWgIXjzelxOmyB9nvd/eajhvpnXk0Qmw0P+VU87rCO1B1iGdftvL4cDW/50Q1Oq6OtBTBikluY+JNZWztFC3nuOpByM+eMN0UNef4IisY00nSIuJhG0ZYcRuzXQZfrijvClkMRXEKdhNWS5DUx+pk2UrYom1JyV7pm0WeRDU0w0ahosYerBf+MRBIoBCQH/3yetOdqfb7mgdsrFn2ONAAFU/qWmHj3bIf3fjKZmvVDE8qpKixuPgeQH78PAiJBH2tKtfFBKmx38daOXQEcmO+b+AyGb6YpZ5IdpcardDGEMV03Qs92YRN0WG17TRRXDxTvHcpXlALVwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(8676002)(66556008)(66476007)(38100700002)(83380400001)(2616005)(53546011)(8936002)(5660300002)(316002)(110136005)(31696002)(36756003)(31686004)(186003)(6512007)(6486002)(26005)(508600001)(2906002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di91cTd6SXgrMExzbnhqcGdscEdWTll3cjgxSk53ajByNGkrNG9XWUJ3V1pm?=
 =?utf-8?B?UUF6WnR5SVBzMklqZWxnZU5lcVdMRTYzUWt5dytQRlJidTd2TnBDWDlhZUZw?=
 =?utf-8?B?Q2xJWWhuT1dUWmVsMXZiQ25qZmFwQWVpNTBCU3VNQWoxdDFXTzVSbjg5bVUr?=
 =?utf-8?B?TG1CbkpLSVF2K05oM0g3cnFNWkxxVE5ObFVhSFNYRExMZ0F1M0k0YUFRWFdj?=
 =?utf-8?B?UWhzWWR5VTFIWjBadVphL0tHL3RpWENVK1RvV2Y0VHJnaW5JWXVBbTB2Vlda?=
 =?utf-8?B?ZDB0THZrcHNMN0craFlWT25PQlBkdHdidWRNWmhwTmk0RHFsNGZTRG9wOXVQ?=
 =?utf-8?B?eVFBazE2aklEQ080djdQRWl2U3dqMjlnNlJ2WFVpT1hsak12dVpYVkNoTHJK?=
 =?utf-8?B?MENKU3hlYzI0dDQ3bWdpQW1jWkZ6czlIVVd4Sk9HMkxkdGtOVmFKOXNGa1Bh?=
 =?utf-8?B?eHpTUWdmT1YrVlY2MFN3dUdNdElxZU1yTEc3WGt3Q1F4cGgyUTZrMUFWd2FR?=
 =?utf-8?B?RjRYNENqUmd5NGFWNkpXUEtIS0tqYmd2Rjl0UzJtbjdXckhqTHpacmw1dUF4?=
 =?utf-8?B?cnN1dEpVRzhNQU5ZZG91TEZwRW0xcUtnVUpqNjZXYStJMzB1TUVRbzE3TGtr?=
 =?utf-8?B?cHhTLzVmaDVRSXY5dVM4elJDc1VUcEdQL3hYL0piNG5xT1lneGRsV1Jzckg0?=
 =?utf-8?B?cTYzYnpKckZFdFNqVzlQMzhRU2k1NEJxdHpPKzRRSmlQVXA2c0JnemJob1Nv?=
 =?utf-8?B?MWNPTzUwaDgvSGRRZko4OWNNM04xbUVrdHdEUE4xTElhTEVIc2N1SU92Z1JR?=
 =?utf-8?B?MWVtZ0luWFQwaDloOEtRc3BsRGhWQmR0L29CSDNuelpNY3pFOHJPNVRQcEVQ?=
 =?utf-8?B?THJacjNvMzdPRzF1Z01sSkZZcVhwVGI2Zm9rOXgrRUJRQ1RJOW9MU1g0djRN?=
 =?utf-8?B?bS9yd1ZEdzRPTHpQbGJKZU92V0pFa0V5d2RVMGUwNG4zaUtHMUVwYkFzeDA2?=
 =?utf-8?B?K1AxMHNCMzJTWDVZb2I3RUlMOXRFTzF3eFpZV2I4TUVwREJZZUhVNEZXKzVC?=
 =?utf-8?B?MlJjOWlmT1RQSGZZZ1FLWXI5V0NES0hibVBIQkYzZHkzTm1RRmNKVXk0aDI0?=
 =?utf-8?B?RXdqNG5pZTgxTDh5d3J6ZjhOM3lUaTkvRDZqMmNZU3VPZDFLNU1qRmNhSllk?=
 =?utf-8?B?bnkwZ2tpNUFDQzNJekhxQndITUZJdHJzWUJZQVlHdnNVK3JYZTI0dnAwZm11?=
 =?utf-8?B?S0hoUlhzTDJtRnRXSDRiMGM1Z0hVR2cvZlJ2aXNPNVBTWk5LMkdzTFltdERt?=
 =?utf-8?B?VURBTVdUd0dCWVJPR2NONmovWWFBRE9WMjJEZUJtbngraXQ1WUpMNEFCQ3l0?=
 =?utf-8?B?ZXM5dnNUajRQZitaeTJMdTZEc3Z4bVJ0a0JucHloNW96dlRyWFU2aGFiWUZB?=
 =?utf-8?B?bXIrcFpPUDlhK1oxcnAyVndJSXQ3V3dPSk1TWHVFL2d0eGpNQ2l4L2ZDZU9j?=
 =?utf-8?B?c2tnN0R0eTFwWkxVNklBU2RVMWRjb0FndjUrRmwyclFjYXlYNnVsc3U2aUg4?=
 =?utf-8?B?bW84MjhxYXp2UGM0Z3A5NTlDekN3K0lRTGxGSzg2ZUloMFlBUGJ2WEF3cG9R?=
 =?utf-8?B?TTR2OFBxdEFCR3IwMDQzYlltejRlQlk4bnJaSVhtTFhBU0NiMitJelE1VmZL?=
 =?utf-8?B?QXpDSXMxSXE1L05vbWFCejBCdDhaaHJleXltdGtKTlFVSGRrdS9hanRUU1Nu?=
 =?utf-8?B?Ry9Ib25Xc1R3bWc5K2ZpR3RDeXVOWGY2cWVVMXNDOC9ZaVJ3RDNDdmh0c0ZP?=
 =?utf-8?B?SitWRjByaitrcU9mcFJQTHdXUUIyZEdaTEtqSW5zcVpXeWpQOEwxREJIclZh?=
 =?utf-8?B?S01vTVQ1NHhJNW44VldVaEYzZ2Q0NFhHYUNOREt4djFGWXNQeXpJeDdneUVl?=
 =?utf-8?B?bjZFRjJGNWdTQW9XaXp1aVRmOHU0NXJUT2t6eXF5KzJKZUpLTUFGeUZvMVlw?=
 =?utf-8?B?Z3d1YkVRSzd5UlpzcEdDTWdZNHM5WThnVm1BSnNCVVE0UlBRVW1vSlBvSjlQ?=
 =?utf-8?B?VVdqaktpU3JQZjFiblFFdWIzSnhzaUZNWGxiM2RHMGdJZW5zY1J6d0hIc2hm?=
 =?utf-8?B?bHJZakxIUHBXUm14VjdlUXJsSjlHRHJjdFRvcHJudmNueTg0QW1IbEprRWNQ?=
 =?utf-8?B?NktIbGw4ZE1jQVVQbkJiWkxHWC9rL3YxbVEwL3RPUDlIMkgrT3dTYmlDSDl6?=
 =?utf-8?B?aEtRcHVwRFdBdTIyc0UxSmVoL21rUDdmR1R3MTdZc0V3TTl0SUtWY0RmbThH?=
 =?utf-8?B?TFRlcW1NUVE1ZzZ1S0lqS0pWd28wK0psYks5aEdGbm44NytWc0pkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fda0e7-02a1-44ed-33d1-08da39a01a18
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 14:01:42.3252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20S4A6yEw/dwshmsWnGowrAdtswILZDJ7aWcTpz2qv7L4byPwxqpHKK6z1eKxeOz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3148
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-05-18 17:40, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:55882ef2-9dc7-36cb-1d60-2c868ea1c14c@amd.com">
      <br>
      On 2022-05-18 14:36, philip yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2022-05-17 19:11, Alex Sierra wrote:
        <br>
        <blockquote type="cite">[WHY]
          <br>
          Unified memory with xnack off should be tracked, as userptr
          mappings
          <br>
          and legacy allocations do. To avoid oversuscribe system memory
          when
          <br>
          xnack off.
          <br>
          [How]
          <br>
          Exposing functions reserve_mem_limit and unreserve_mem_limit
          to SVM
          <br>
          API and call them on every prange creation and free.
          <br>
          <br>
          Signed-off-by: Alex Sierra<a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp; |&nbsp; 4 +++
          <br>
          &nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; | 24
          +++++++------
          <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 34
          ++++++++++++++-----
          <br>
          &nbsp; 3 files changed, 43 insertions(+), 19 deletions(-)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
          <br>
          index f8b9f27adcf5..f55f34af6480 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
          <br>
          @@ -301,6 +301,10 @@ bool
          amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev,
          struct kgd_mem *
          <br>
          &nbsp; void amdgpu_amdkfd_block_mmu_notifications(void *p);
          <br>
          &nbsp; int amdgpu_amdkfd_criu_resume(void *p);
          <br>
          &nbsp; bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct
          amdgpu_device *adev);
          <br>
          +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device
          *adev,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t size, u32 alloc_flag);
          <br>
          +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device
          *adev,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t size, u32 alloc_flag);
          <br>
          &nbsp; &nbsp; #if IS_ENABLED(CONFIG_HSA_AMD)
          <br>
          &nbsp; void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          <br>
          index e985cf9c7ec0..b2236159ff39 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          <br>
          @@ -122,7 +122,7 @@ void
          amdgpu_amdkfd_reserve_system_mem(uint64_t size)
          <br>
          &nbsp;&nbsp; *
          <br>
          &nbsp;&nbsp; * Return: returns -ENOMEM in case of error, ZERO otherwise
          <br>
          &nbsp;&nbsp; */
          <br>
          -static int amdgpu_amdkfd_reserve_mem_limit(struct
          amdgpu_device *adev,
          <br>
          +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device
          *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t size, u32 alloc_flag)
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t reserved_for_pt =
          <br>
          @@ -157,8 +157,8 @@ static int
          amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.max_system_mem_limit &amp;&amp;
          !no_system_mem_limit) ||
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (kfd_mem_limit.ttm_mem_used + ttm_mem_needed &gt;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.max_ttm_mem_limit) ||
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;kfd.vram_used + vram_needed &gt;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.real_vram_size - reserved_for_pt)) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev &amp;&amp; (adev-&gt;kfd.vram_used +
          vram_needed &gt;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.real_vram_size - reserved_for_pt))) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = -ENOMEM;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto release;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          @@ -166,7 +166,8 @@ static int
          amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update memory accounting by decreasing available
          system
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * memory, TTM memory and GPU memory as computed above
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
          <br>
          -&nbsp;&nbsp;&nbsp; adev-&gt;kfd.vram_used += vram_needed;
          <br>
          +&nbsp;&nbsp;&nbsp; if (adev)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;kfd.vram_used += vram_needed;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.system_mem_used += system_mem_needed;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
          <br>
          &nbsp; @@ -175,7 +176,7 @@ static int
          amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
          <br>
          &nbsp; }
          <br>
          &nbsp; -static void unreserve_mem_limit(struct amdgpu_device *adev,
          <br>
          +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device
          *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t size, u32 alloc_flag)
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;kfd_mem_limit.mem_limit_lock);
          <br>
          @@ -184,7 +185,8 @@ static void unreserve_mem_limit(struct
          amdgpu_device *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.system_mem_used -= size;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.ttm_mem_used -= size;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (alloc_flag &amp;
          KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;kfd.vram_used -= size;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;kfd.vram_used -= size;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (alloc_flag &amp;
          KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.system_mem_used -= size;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!(alloc_flag &amp;
          <br>
          @@ -193,9 +195,9 @@ static void unreserve_mem_limit(struct
          amdgpu_device *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;%s: Invalid BO type %#x\n&quot;, __func__,
          alloc_flag);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto release;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          -
          <br>
          -&nbsp;&nbsp;&nbsp; WARN_ONCE(adev-&gt;kfd.vram_used &lt; 0,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;KFD VRAM memory accounting unbalanced&quot;);
          <br>
          +&nbsp;&nbsp;&nbsp; if (adev)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE(adev-&gt;kfd.vram_used &lt; 0,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;KFD VRAM memory accounting unbalanced&quot;);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE(kfd_mem_limit.ttm_mem_used &lt; 0,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;KFD TTM memory accounting unbalanced&quot;);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE(kfd_mem_limit.system_mem_used &lt; 0,
          <br>
          @@ -211,7 +213,7 @@ void amdgpu_amdkfd_release_notify(struct
          amdgpu_bo *bo)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 alloc_flags = bo-&gt;kfd_bo-&gt;alloc_flags;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 size = amdgpu_bo_size(bo);
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; unreserve_mem_limit(adev, size, alloc_flags);
          <br>
          +&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_unreserve_mem_limit(adev, size,
          alloc_flags);
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(bo-&gt;kfd_bo);
          <br>
          &nbsp; }
          <br>
          @@ -1601,7 +1603,7 @@ int
          amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Don't unreserve system mem limit twice */
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_reserve_limit;
          <br>
          &nbsp; err_bo_create:
          <br>
          -&nbsp;&nbsp;&nbsp; unreserve_mem_limit(adev, size, flags);
          <br>
          +&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
          <br>
          &nbsp; err_reserve_limit:
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;(*mem)-&gt;lock);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gobj)
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          index 5ed8d9b549a4..e7e9b388fea4 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          @@ -261,11 +261,21 @@ void svm_range_free_dma_mappings(struct
          svm_range *prange)
          <br>
          &nbsp; &nbsp; static void svm_range_free(struct svm_range *prange)
          <br>
          &nbsp; {
          <br>
          +&nbsp;&nbsp;&nbsp; uint64_t size = (prange-&gt;last - prange-&gt;start + 1)
          &lt;&lt; PAGE_SHIFT;
          <br>
          +&nbsp;&nbsp;&nbsp; struct kfd_process *p;
          <br>
          +
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx]\n&quot;,
          prange-&gt;svms, prange,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;start, prange-&gt;last);
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_vram_node_free(prange);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_free_dma_mappings(prange);
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; p = container_of(prange-&gt;svms, struct kfd_process,
          svms);
          <br>
          +&nbsp;&nbsp;&nbsp; if (!p-&gt;xnack_enabled) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;unreserve mem limit: %lld\n&quot;, size);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
          <br>
          +&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;prange-&gt;lock);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;prange-&gt;migrate_mutex);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(prange);
          <br>
          @@ -284,7 +294,7 @@ svm_range_set_default_attributes(int32_t
          *location, int32_t *prefetch_loc,
          <br>
          &nbsp; &nbsp; static struct
          <br>
          &nbsp; svm_range *svm_range_new(struct svm_range_list *svms,
          uint64_t start,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last, bool is_new_alloc)
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t size = last - start + 1;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange;
          <br>
          @@ -293,6 +303,15 @@ svm_range *svm_range_new(struct
          svm_range_list *svms, uint64_t start,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = kzalloc(sizeof(*prange), GFP_KERNEL);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; p = container_of(svms, struct kfd_process, svms);
          <br>
          +&nbsp;&nbsp;&nbsp; if (!p-&gt;xnack_enabled &amp;&amp; is_new_alloc
          &amp;&amp;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_reserve_mem_limit(NULL, size &lt;&lt;
          PAGE_SHIFT,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
          <br>
        </blockquote>
        The range will create svm_bo to migrate to VRAM, so count
        acc_size is correct.
        <br>
      </blockquote>
      <br>
      I'm not sure how to understand this comment. The thing is, the
      VRAM BO can be evicted without losing functionality. So I don't
      think we need to track potential VRAM usage of SVM ranges. We only
      need to account for system memory usage. That includes the system
      memory being mapped, and maybe the prange structures and dma_addr
      arrays used for the mapping. However, like I said, the old
      acc_size isn't really suitable for that because it doesn't account
      for mappings on multiple GPUs.
      <br>
      <br>
      The dma address arrays take 1/512 of the memory size, per GPU.
      Even on an 8GPU system, that's only 1/64 of the memory size. So I
      think the 15/16 system memory limit still leaves enough room for
      those data structures. If that gets too tight, we may just decide
      to use a lower system memory limit, or change the system memory
      limit based on the number of GPUs in the system. That would be
      easier than accurately tracking the data structure sizes for each
      allocation and potentially each mapping on a multi-GPU system.
      <br>
    </blockquote>
    <p>Yes, based on this calculation and acc_size is not accurate now
      for mGPUs with IOMMU support and svm range, we can remove acc_size
      for svm_bo, only count svm range as userptr system memory.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:55882ef2-9dc7-36cb-1d60-2c868ea1c14c@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to allocate
          usrptr memory\n&quot;);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(prange);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
          <br>
          +&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;npages = size;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;svms = svms;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;start = start;
          <br>
          @@ -307,7 +326,6 @@ svm_range *svm_range_new(struct
          svm_range_list *svms, uint64_t start,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;migrate_mutex);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;lock);
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; p = container_of(svms, struct kfd_process, svms);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;xnack_enabled)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(prange-&gt;bitmap_access,
          svms-&gt;bitmap_supported,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAX_GPU_INSTANCE);
          <br>
          @@ -1000,9 +1018,9 @@ svm_range_split(struct svm_range
          *prange, uint64_t start, uint64_t last,
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms = prange-&gt;svms;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old_start == start)
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *new = svm_range_new(svms, last + 1, old_last);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *new = svm_range_new(svms, last + 1, old_last,
          false);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *new = svm_range_new(svms, old_start, start - 1);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *new = svm_range_new(svms, old_start, start - 1,
          false);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!*new)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
          <br>
          &nbsp; @@ -1825,7 +1843,7 @@ static struct svm_range
          *svm_range_clone(struct svm_range *old)
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *new;
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; new = svm_range_new(old-&gt;svms, old-&gt;start,
          old-&gt;last);
          <br>
          +&nbsp;&nbsp;&nbsp; new = svm_range_new(old-&gt;svms, old-&gt;start,
          old-&gt;last, true);
          <br>
        </blockquote>
        <br>
        clone prange is not new memory allocation, use false.
        <br>
        <br>
        Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!new)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
          <br>
          &nbsp; @@ -1951,7 +1969,7 @@ svm_range_add(struct kfd_process *p,
          uint64_t start, uint64_t size,
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* insert a new node if needed */
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (node-&gt;start &gt; start) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_new(svms, start,
          node-&gt;start - 1);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_new(svms, start,
          node-&gt;start - 1, true);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ENOMEM;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
          <br>
          @@ -1967,7 +1985,7 @@ svm_range_add(struct kfd_process *p,
          uint64_t start, uint64_t size,
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add a final range at the end if needed */
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (start &lt;= last) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_new(svms, start, last);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_new(svms, start, last, true);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ENOMEM;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
          <br>
          @@ -2585,7 +2603,7 @@ svm_range
          *svm_range_create_unregistered_range(struct amdgpu_device
          *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last = addr;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; prange = svm_range_new(&amp;p-&gt;svms, start, last);
          <br>
          +&nbsp;&nbsp;&nbsp; prange = svm_range_new(&amp;p-&gt;svms, start, last,
          true);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Failed to create prange in address
          [0x%llx]\n&quot;, addr);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
