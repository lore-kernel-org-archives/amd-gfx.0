Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C111C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 12:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C6E10FEEE;
	Fri, 20 May 2022 12:45:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3100710FEEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 12:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsyptxNEww7R9hav73A2SDdMvTqnxW8U5kuux2Hf3s56fLYhNG3W8wd4+fH3luG8CMAoDiiGsulkpj7e8yFmlnw/bvAJKJQEC+3x3xufHKIhYv857KuukYqDMUEvLhjYXkwgDWZspcfxRXjqFN2OT08sTAbPP2lSp3iAygLWZ+06dOhRbgaF+0Z56uYzsRQtuZ5urw6gj11zGSQ8KAvWtZQ0rdL6HwpEFB8ryXZVNWeaY70KJRCMu5zFnzCZmQaxeIdZJjPtiC73GdLA/zZm40ihcu72WW0qk3ml+H7iPgdsmfdpQ+wlaaJoiMd1gObJHF0G1ZcRWHUa5ZT5QW9ZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJIy26fmQRoLbK/N5KVFgUinczU02MFguEdMMaQjlmc=;
 b=arOhACi9iB3MoOX5le9uRDoaYLmVCVIZJpmkDVnw6svYO0niP/FQOy2bmlu4TkPt8UBeYyvWzvnzOXCJ9zG7j9HQcUzfM1xgCGcU7eTLFzuGXoSxmze3SWHM9j72ohC5F66hGUKD22txT1mH8zzhuZmMvCADvez+n5J5tXw0DhVpaaUw3l5ceSU1wC9TIFYS8kXZx7tMGU0c00+w70gHiE2jI57ofjLxRZbYlOgnTCZMaBFo6KOz2Icrpym1Rjn2NJ7rx2kPghWpAXYi86n5tWgsrQwOlq78xsmSOB/DWnPLv3ZsZc1zlQdfOIACc1TXv6OqIH/Op3zmAt94iD9Whw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJIy26fmQRoLbK/N5KVFgUinczU02MFguEdMMaQjlmc=;
 b=IWXnrIEby6B2Tmjm2aXNwjCDGv3PeXgbiLIQj1zA2Ogw/uYncA9mPAwGZph/qiAG9xI2gOU/uTZifZlQda18ajumpLle0AXl/jRFsmRn+Mj9MJKIQBQlMGf+kOGIXriVQkr4AatNbP5KQdjjPABMnynAFoTFDLqG31roFHoXENE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Fri, 20 May
 2022 12:45:02 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%8]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 12:45:02 +0000
Message-ID: <d9242fbb-fb5e-e03a-fc04-4732c310c947@amd.com>
Date: Fri, 20 May 2022 08:45:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220519162153.6268-1-alex.sierra@amd.com>
 <20220519162153.6268-2-alex.sierra@amd.com>
 <9ec46333-ec80-f258-febc-7c7110cecf56@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <9ec46333-ec80-f258-febc-7c7110cecf56@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:610:4f::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 443f4984-86ff-4de6-f194-08da3a5e8ea9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1850:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1850D8DE12F98DD1C1718F5BE6D39@DM5PR12MB1850.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjiW3P3BouN8bJWtF/eKXavrnPXt8iVvWi/30aa1vATVxbfkg68GKO4Zw8AkXbR6rM5XVr6mr7OWVeYivcDPHyOMTmcCYAZ4BQEYJWW8Xo3VKn3ymy01zkGBYei+8OYw1Le+ZJ6C2dfnxMntr6Cwn0DxCaCy2vWopLOJdNuNY8fGIDANWn97wZWFPbNkfRe1tJYkeRM1n0qkFby6EDUvzthC/b4ij5370XA6f84W6vCiWm0q8foA/JntVkG0iKxr/fATcCdrf4SE/wEG8AAhP7+0bwY/jdqETvvJNxSACpleBj8PvKQao1G90MN816m+rO8WWiDYS/rCPvOQibkQOMjIcq4l2tZYPIQDQpemjdFobPUhlgk4T33taYlGELpY/XQKCh7MlZYV26HCydMRXXJmRmBH4uV1psZFHmYekAkuuwYHqcE2yYdXc+nuP4uJ/QFb7on90bk4rj44MUngvBKq2B1yjhyv6QW1zxsiwBtJAEKYgeKd/kHq5v9iCKW9LpgiBHvBm12FWxs+ZgDEuaz59a3SC3YUyGlbX+6A1Qt2oBCxRdj7sTJlXE4oSUFebE/73YN2vhXC6N81gadPdEks/yNSisXSuTDhtb11sJhxfR/GeYr0J8wrO2jbQIp8zJlN0DRQmQrtAv+M7VuV8tewle5Ss1rOqp4qGoiz13ZAm+7xZLPIFfgVj8anKpi+F0dbP+hKbbpotYJ8xbic4/O3kIPzPBamMP3K3DGwtR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(508600001)(6506007)(110136005)(38100700002)(26005)(66946007)(53546011)(2616005)(5660300002)(2906002)(8936002)(8676002)(31696002)(66556008)(66476007)(6486002)(6512007)(31686004)(186003)(316002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHhUMThPNUpENjg0cldvNHBxZFFET09Dd091THpNaXFzcEREZHZoaiswQkJy?=
 =?utf-8?B?VDNvNzJwZHB4Mlc3MEtCeVdISzY1aElHbGJCSmphdVE3bFhOaHYzeUFpamVi?=
 =?utf-8?B?U29NNUR6Snk3L3h6Z1BuSmY0TnFpMmFOWmhkb3lQUHdOblN5a3Y1alhya21l?=
 =?utf-8?B?NWhrRkZ6VC9rYVRBaTBvK0t6L2MzeE45MUVhNEVzNDcwQnBhZ1JxbFNMZDFB?=
 =?utf-8?B?OTJnaklScWJndkp6YUdiMEg3TEpwT1RGTEhyV0Vtd2tvVjZObERQSWVuUVFD?=
 =?utf-8?B?SWw3MytDanhkOCtQclF1VVVmOXJNNDd0UlNaNk9FL00zQUg1aDBhZ0RLaXhX?=
 =?utf-8?B?UGVNd0s2Z3RiMDQrNlViS1JLbVlwNjNqR3ZYM0szT3gwcGtVRGhMU0JFK2xp?=
 =?utf-8?B?M3NZU3dKQ1lHbFpWMHMzaTRoTHpEMDJsdkVmSUdBMllJdzJnRVJoeG1XNGpW?=
 =?utf-8?B?Q0NXaEFvS2FRRkJrNWM5K1NMUnYwZi9PcU9heXRMTDFaTmh4S0xBT2UvUEtZ?=
 =?utf-8?B?SDVpZjFNSzFkZ0ZLKzdzSVJUK3hoVENDZ1VGN2swbjJLWnkzRnhkUWNYTzR5?=
 =?utf-8?B?TzdBNUEyc01BUU92MVFtQlJKY3ZwdG5mQnFQV3M3MWt3aXV0ZlJuR3FyVTdP?=
 =?utf-8?B?VFFRcWhEaUs0c1V6VVByNldaSk9qTElrd1B6bi93bURlUGRiWVk4SWxhUUoy?=
 =?utf-8?B?NW0yaW00cjZxbU8zRnZRWnNscW9za2FJVkN2RmpsUjNNV0Q2Vm56UjlDdUpr?=
 =?utf-8?B?ZEF6dHlXYXlnODgwemp2Nnc0SHgwNDBsaHFhSDBEWHNPV29JSVhkeVduMm10?=
 =?utf-8?B?Sm13N2IrOWpDT20xNlRqNXBzWHRWTDVMUUt1L2MxTzV5SThkLy9kbnZ2RXdl?=
 =?utf-8?B?VlVuaE9vSVBNS0FVemJiMVA5L1Vlb252WUI1QStaL0dkamEyZ0JteEpDeW8r?=
 =?utf-8?B?ZUVLdjRQNndMc3h6TkI2Y0lqUlFDWGNZSTV4U2p2bnRkVHdQMWtUTnhIWmJK?=
 =?utf-8?B?NWFtT1Z4ZEovWlhVUTE2M2lnMnBoZ1RLeGpJakxrMnVQVlc0aE0waVpyckxB?=
 =?utf-8?B?eWUzUVZVUTh2TDREb0xFM1JUTm8xaFdMZlZHdTBabGxjODVXbldDVWp2c1lN?=
 =?utf-8?B?dWZqYmNDWGhOU2tkZmhjSFU0RGJDMzdUcEJ4cDUvc3NhbVNISnJsM2V5MFlD?=
 =?utf-8?B?S2U0N0k0WkN6d2NybUlkbGZicXNXTHArcDBLMFdxVXRwYmZVd1hwWEJxcTJy?=
 =?utf-8?B?UWpMckVsNlZrdFNJTFRCL202MlY1c3E0Vi9PUHhxZjdxQmpsQjNXa3oxeWh2?=
 =?utf-8?B?L2ozTFd5T3RRZDFhcUZyVGFVZzFlMXdoZm1zRUpTbWZQVkVLM0p2MEFwRmVQ?=
 =?utf-8?B?SjlTQ2todzBXRkpnT0RIWThjNzNGRElweFZyNk5qM2hvQzdGUk1xMEN6c2hY?=
 =?utf-8?B?WWpYUUEzTkV6N1JzL2VBTW1YZHpWYjJrWFZqT28wR29LNG8xbklVNUVHZnA0?=
 =?utf-8?B?elBpdzZINnNNMWFHbDhNQ1oyTkQ2aFN6c2pPQWJqUU1tMGc0clRkOHJ4L0Nl?=
 =?utf-8?B?TlEvdWk0dVY3WFNTRVdzOHlWRFlSL0pQd2hNNXRhNThEcXdxdllnUGVPNmZv?=
 =?utf-8?B?eC9RRkxyZ3lHMWRCMFo4Uzlqb2FzTmtGeW03Tk9zUFRNSUw2TURQZjEwOXZy?=
 =?utf-8?B?T3VPZWVPSzZuVE5zaERrUHh2WG5HZzYwTTlUUmowQi9TNW9udEZyNENYWHE2?=
 =?utf-8?B?RURHWEs0WFNkYmVZUGdZWnV5QjltT2lrVHVyVkd4OWRGeTVvc2ZpejFqaTE2?=
 =?utf-8?B?bzV5TFhPKzlTU1lyYml4RVlqbkRTcXpwYUYvckY4V2FwNlNYUUwvWUJrZUVv?=
 =?utf-8?B?TU5rc0lKVnR4RitlYk1jemFxeUZUTHBEaHNaYzllMkVjaHNlTThtbUNvd1Mz?=
 =?utf-8?B?UkN2cmtqWVFsS2xQWmFUcFJaUjlkS00wb3dkV3FzMWRJYWJQR2R1OFRBazl1?=
 =?utf-8?B?UWVJWE9MWU8rT1ZnRHBxK005VGhydkc0ZzRnWmVPUzNXUjlEMG5SbHBuQ0ow?=
 =?utf-8?B?UlJkcklmNW1UNkZCUXgwUFdkdmtPazEza2d5bVBPOHhoZExWUkNLeksvTENn?=
 =?utf-8?B?K2NiYUV3M1NjWWFXSnFXcWZrSFhPVndraXJhUFVKUFViVURwbmxTUUQvUkZk?=
 =?utf-8?B?TDlXSzhXVFZqS20rQU1vL0crRnNMd3pEZUkyNlRLeXVRSHJGWTJ4MkdEcTU0?=
 =?utf-8?B?RHh6VG1EczBkaDVMWnNPb1ovU3U1UmV4OHJHUUtLa2hnNVdKcDFBd25qZWFZ?=
 =?utf-8?B?K0pVbzUvTW11VFhOTUdnTERFbzJOT2drMTEvWXZMdGVRQTZxMnBJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443f4984-86ff-4de6-f194-08da3a5e8ea9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 12:45:02.3986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnKmcEfYagcPVQCMdSdkTkfxrVYJMO+uyqG8RFtsL/KqUs0K+5i07vKV1J4IgDxS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1850
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
    <div class="moz-cite-prefix">On 2022-05-19 19:08, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9ec46333-ec80-f258-febc-7c7110cecf56@amd.com">Am
      2022-05-19 um 12:21 schrieb Alex Sierra:
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
        Exposing functions reserve_mem_limit and unreserve_mem_limit to
        SVM
        <br>
        API and call them on every prange creation and free.
        <br>
        <br>
        Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
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
        @@ -301,6 +301,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct
        amdgpu_device *adev, struct kgd_mem *
        <br>
        &nbsp; void amdgpu_amdkfd_block_mmu_notifications(void *p);
        <br>
        &nbsp; int amdgpu_amdkfd_criu_resume(void *p);
        <br>
        &nbsp; bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct
        amdgpu_device *adev);
        <br>
        +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
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
        index 966714dd764b..615e2b34fe12 100644
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
        -static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device
        *adev,
        <br>
        +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
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
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev &amp;&amp; (adev-&gt;kfd.vram_used + vram_needed
        &gt;
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
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update memory accounting by decreasing available system
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
      </blockquote>
      <br>
      Add a WARN_ONCE(vram_needed &amp;&amp; !adev).
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.system_mem_used +=
        system_mem_needed;
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
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
        {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;kfd.vram_used -= size;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev)
        <br>
      </blockquote>
      <br>
      Add a WARN_ONCE(!adev) here.
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;kfd.vram_used -=
        size;
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
      </blockquote>
      <br>
      This could be simplified to WARN_ONCE(adev &amp;&amp;
      adev-&gt;kfd.vram_used &lt; 0, ...).
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE(kfd_mem_limit.ttm_mem_used
        &lt; 0,
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
        +&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
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
        index 835b5187f0b8..1380c2fee0dc 100644
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
      </blockquote>
      <br>
      You could initialize p in the variable declaration above.
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; if (!p-&gt;xnack_enabled) {
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
        &nbsp; svm_range *svm_range_new(struct svm_range_list *svms, uint64_t
        start,
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
        +&nbsp;&nbsp;&nbsp; if (!p-&gt;xnack_enabled &amp;&amp; is_new_alloc &amp;&amp;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_reserve_mem_limit(NULL, size &lt;&lt;
        PAGE_SHIFT,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;SVM mapping failed, exceeds resident system
        memory limit\n&quot;);
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
        @@ -1000,9 +1018,9 @@ svm_range_split(struct svm_range *prange,
        uint64_t start, uint64_t last,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms = prange-&gt;svms;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old_start == start)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *new = svm_range_new(svms, last + 1, old_last);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *new = svm_range_new(svms, last + 1, old_last, false);
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
        old-&gt;last, false);
        <br>
      </blockquote>
      <br>
      This won't work as intended. When a range gets cloned, one of the
      clones will be freed later. So when freeing that clone, you also
      need to skip unreserving its space, because the other clone is
      still holding it.
      <br>
    </blockquote>
    <p>Thanks Felix for catching this, svm_range_free should skip
      unreserving the cloned ranges from remove_list, otherwise we don't
      account overlapped head or tail range size now.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:9ec46333-ec80-f258-febc-7c7110cecf56@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
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
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_new(svms, start, node-&gt;start
        - 1);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_new(svms, start, node-&gt;start
        - 1, true);
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
        *svm_range_create_unregistered_range(struct amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last = addr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; prange = svm_range_new(&amp;p-&gt;svms, start, last);
        <br>
        +&nbsp;&nbsp;&nbsp; prange = svm_range_new(&amp;p-&gt;svms, start, last, true);
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
  </body>
</html>
