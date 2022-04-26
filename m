Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4880CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 15:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCCD410E641;
	Tue, 26 Apr 2022 15:21:25 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83F4710E625
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 15:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WA7f70KqJYyD3FxNZQHeYf6qhHkGhjlTAGP2KhUZ1dUaTBVSRJv48v4p1SpvCT9YIYf8cAAAo2vHYU3H3hGaP13iNGC3vw3TWMtde+LTgdfQMaYx0zvVBREYn99AZ5pGoBoSHFWfa3YkD+vwG190jlzal+0HN/CPAany90CXOzckJtrK9WdWJvhZxH8NCexKOWFmT7um+fRB1CTqATLilr+lleyiWAqrdLMlaYpRMnstqD6y73nF1Qh6om8lueMorzGYlNOR0WP2K2WR3JMa/7Pi63LPm+pT4CdjIIuCnLo1Q1ro0FMLB84a/93l0m2pqZz5oHLqz/a2aCfKzTNuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OM4vNOeCg2HAWEJWEvVznM/VOXjBFuXTcJsGNGgJBXE=;
 b=WHopkr+ndD6DQAuAJTiLy+OK8LRJIkHkFyOBPzgfUBOZ+/rlxwS4v8aTdnflcFH4cvRKAhiyC7XB7xM3ErGp9dmoebxeXhDTckTQ+v03e3mkmDRkIPNp+PImY+I9v34pqE75eygYDGjWFyB1tJ+pU+GVOLXrev/CDtOMpU67e13f21dBpUyghp5jERo7qr5vxaaSTdZO3pFTdjEBv//OBvwsGDcDVeKOOf4QFChsFb9IDnq2d/OsCmGyY4jNClcCJDqpvxwfgSUnW0MpwGGC0ZKyGBAVRext1JspkHObYMi5u+xIesUjO7MghgNl7Uu6IhoRh5tmORGjsgcLIDSl8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OM4vNOeCg2HAWEJWEvVznM/VOXjBFuXTcJsGNGgJBXE=;
 b=KI8urGEjCEMloX2HFVVOUXg4YMtGzIW86wQH354aQ3ikYWuLBplHUrU43zlpnkoKz3iF+92erfSsPFeesVSdmhWMT6W1eD5Iu2yB09ZFNryaIHKZigIpcZVKdDwQqsFqv3CgFBZvQUH/EEgGOxatW30e9bxc0/xb+p7QvjGeyUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY4PR12MB1768.namprd12.prod.outlook.com (2603:10b6:903:11c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:21:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:21:22 +0000
Message-ID: <1e16663d-d95d-04ff-81aa-d6b77e58028a@amd.com>
Date: Tue, 26 Apr 2022 11:21:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] drm/amdkfd: Fix circular lock dependency warning
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220422190232.2505589-1-mukul.joshi@amd.com>
 <20220422190232.2505589-2-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220422190232.2505589-2-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f3cc51a-5020-4bd8-c729-08da27986b9e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1768:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB176849380E0804578742282D92FB9@CY4PR12MB1768.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uWOrxNW+V9JgEJIIc+jYm70QuKBk8A1gmnkMzOmJd92iHQzEhHHUrNMfn6k6+L1f0JAeGm3x5TXYLnargFCSER7yk9bSW3N9j0Pgqrll95/DLnZpMs3EmnKN3sN1mBRJJThzaja4fCq7loUHvUIKvkOfAB7DSSYkEznAY5LXspUAJ3Q3RzlVmS7fJA5o+4FCVYEx270tlzopk12/NiY7HWx5e1ThpO5klp9U5qS62Qmlkriw8TW/IpJwwrGDeyY0OQKFCJJZ7MGDESdOnD0TI2fjdQKx3AKZTyMFIcPD0rAnJUtF+zF4jzfUmau/Qu/LhorC4YFAV6pupZHoStSe0IgI60VbW9J0oj9MnS6hmZhneHj0EWxog0IJtoWPpi0Ws5VRYEzTc0H/nKQAGGt9DC1rhPOx7r6zQN1Hqzk2gnDVKNwQ3t9eghbVYZ1KK1KznKrAY8Ec9TCSOn5blSlvW2tl70pZAmh/2w3qWIhP5xbyauy4sKhKYAJ25QEn4EwNXBHH6AENNRcafxVKhN2T174pKxgZLQqQKF8VD0CFlQbArGLW7nU+SmCNOXR7YAbPPOz6UAsVGLS95KKHESokOKb7p+lMvbvsCVB/6qBz8ns6nGp5n0S7qUX2iEIpuXn3H558AW70kZUPKXxiRNrpaMAJ3Wnsdemr1LlT/Sd2hAgMu1jRAJJ9CqopjeCydqdyLm0G1JqUtpZCAU5MteHmIFLHXGVm1ui4Vvex2e9Rl6LgvBGcHWZoRFlkUVBGPs6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(6512007)(86362001)(5660300002)(38100700002)(44832011)(26005)(6506007)(2906002)(6486002)(83380400001)(31696002)(8676002)(8936002)(508600001)(66946007)(316002)(36756003)(186003)(31686004)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXdod2tWdzFZNlIrNDhiNi9BSDE2Y2JITnMzdmVQRm9mblFxcG94WThBY3Zj?=
 =?utf-8?B?cTNHWTNidFdYMy9WcEEwbHlwcFdEdzBHY01GaDZWYldRSUQyWXpyL0V3SUd0?=
 =?utf-8?B?U1NsdlZ6c1VRL0ZFREdNcUNPZG9rdjNMVTlmc1RKc0xKZFJ4UTIxampKS1JT?=
 =?utf-8?B?U2NFZWNERHAyL2hoMmYvUGJvRlBpZUFUczlTSlhBTFpUclUvczRNeEJHQk1i?=
 =?utf-8?B?Vlc5bEVpVFVSOER4cmpObkpUdmxNRDBMODFOaTlaNVMyRHIxWXhIYW14NTRp?=
 =?utf-8?B?M05RNUNmY2Q5T3hWRU12OHNTdHdpNGhzSUVpeGM1Y2JFbmYwRE5aMDVhcDFZ?=
 =?utf-8?B?SDl6WmhZTEdqMU8rWmJXMDRlWEtPbzUwTTNQWFVNUWtFMndITjVnNm1ialB4?=
 =?utf-8?B?cmVFTnFBMHpObEJodVgzRXB4Rkc5M0ErZG1UWTRTTlNDVi9NMXh6TjJQTmZE?=
 =?utf-8?B?MkdOMVRLVVQ4ZXA2ZmttNmMrL3hZSHJxMTd3TVVzckZLT1RlVXhsU1FXN1dw?=
 =?utf-8?B?V0ZRU1U4bWFyMnd3QWNRdHRxNGgrbllZWmxjM3Q3SStMZ2dOYVdnRjdTeUI3?=
 =?utf-8?B?ZTN1QVo5VkVtbXhKVmMrL3JNQS85WHQ1RHJadDJDOTBQU1ErOXJVblVWQkt1?=
 =?utf-8?B?a1NSWW9BekQrcUc2SWM5VGtpQUorZmFhcThqVW04Nkh3M2FhNFJha1BCcHhx?=
 =?utf-8?B?QnRoT0dXQnlITzE3R0JqcWUveU55YVpHWWhPdjc3NG5yZm1CYWxhU1JGRWxY?=
 =?utf-8?B?T3p2di8vRENXSnlXRDRPSC93M0ZyMjAzaEMyN2hUeGxQSW0zOExobzA0MUtK?=
 =?utf-8?B?RkdSQzUwZjFhaloza3R6eUl4YVFYenVMOGNXNkp6L0NPVG5OWHZZZnJyeW1x?=
 =?utf-8?B?Rk1nZ2NpYURWWUtqRUhHRmJEeGcvV0RLVGRlSHVDSkJyeGQwdVJzNlA5Wk85?=
 =?utf-8?B?STFmSjhpTmpwb1drcGdSa3NVNVN5cDdCYmphcUp6RldPRHdDUmdtZWNmamFL?=
 =?utf-8?B?UW1xVXdrTm1tczF0VmpPeThCRFlnZlIxRG8vZzkvcUpWV2cvaElheHArMFNn?=
 =?utf-8?B?NjlxMEJ0TGxEKzF4azRsTDhZbUt5SlZZcTJvM1Z3WjBOMURhVXkvUU5oNDVI?=
 =?utf-8?B?citleDJDYm1TZllOb0xCSVVLd1ZFdm1oc3pLVnNGVnFNSThJWWhsZHAvQXFv?=
 =?utf-8?B?Slp2TUwrdDBGdjd6VU1TdFFIamNJSTV2N1VuYjcvUTlMekNCSUhuTDF5ZFhs?=
 =?utf-8?B?U1k3Q29FNHZmcHhPV0hxSm1NYXpwaE1FcjZzYktOcjljbVJJSGlnYU5SVUpT?=
 =?utf-8?B?K0I5UXhnZGpIeCtGV01CQnA2L2pxUmhsYXR4YXdpOExkTEVtbHZ5U05TTkFW?=
 =?utf-8?B?aytZejFpaithT09jbm9pUXdkQmM5ek1EWkE1T0hWd1VqREM0Qmd4WnRTTHZU?=
 =?utf-8?B?cmExRzhVSGVSYUJ6dnViWnREOVk3MzV6MXkwSWh6NHpvU05KRFVjWlorc0tZ?=
 =?utf-8?B?aGh3SWtRdGxYSm11ZkZCbkZKQk1kN0YyenFORlZzYUc5cnNHWlFCN3Joemdu?=
 =?utf-8?B?UkMrdFBjQ2p6aWJMcUFGQUt3MUhyTnM1dmk4MXh0aWUvNFp0YnVleEk3ZXZl?=
 =?utf-8?B?UkFhYTRzbW1MSy8yenU2Mk41T1pGaVhoNVpjSzF5UWFpQTZHanJoSzBheGtK?=
 =?utf-8?B?Z2NxTVpKUWNpOVJ2MEUxS2VCWHQvYWlCVmFJQlRRcVRMSFNEWmM1OFIxODQ0?=
 =?utf-8?B?YkRtanN0amxIV1ZJNmMvWXZsNWYveEpZTkhWS3QwdXpUMFZHcUdwVTVUZTJI?=
 =?utf-8?B?R204Tk1OS3BDbURvR0pyYUpwMnFCc1ZxYlVIK2paVlRzU3g1VlF4Z3JGVEVR?=
 =?utf-8?B?SFZ3cFhvTjRLQzd6bTR1ak1icWh5WDRmWkpHN2FmVGFMVzlUS0FWaVpjTHhQ?=
 =?utf-8?B?UkhOSFM4M01WMlBBcmR2VkJSeHlNaFhOQTgvR3V1T1RhbTRZeFdHdWdTaUZQ?=
 =?utf-8?B?N3Z4MW9RT0JPSUJ0RzFhOHNZNEdqdG82MHNkUGNMRVZMKy96ODZEc0lmeHBJ?=
 =?utf-8?B?UUkreFVKM0VnS1E4blY3NkdXeTJsc3ZhdXNXeGh1ek1YaEFFNW1uTlk2YUIx?=
 =?utf-8?B?ajRwck8xNktQcGVCSGNjU1J6MzRFRnlxeFJMWUxKTHZXRDd2cTZ3bEVjaVZP?=
 =?utf-8?B?Yk5VYVIwM0ZqTE5QeWpxRDN5TXhQSy9FWkxxQkNkVlMrVThSZWVYVEZBWkFn?=
 =?utf-8?B?NEwyZkw4RXB4N0lxV2o5d1phVnBTa0xaVml0K1FwbEJzMWo5QWkzaUtOQWF3?=
 =?utf-8?B?Vk40VEUwRWY2aGhWQ29RVEp2OC9GV291dU1PVnY4TkNhSTlDcFYxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3cc51a-5020-4bd8-c729-08da27986b9e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 15:21:22.1988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz7LgFzH8gO+Re3Gwvw5pIgkQn2SQPzo5HNkMmjLWmSiCiKTzVlXxcKuRE48NIxnuxNKEhirCE5kZ38AsBSyKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1768
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

Some nit-picks inline ...

Am 2022-04-22 um 15:02 schrieb Mukul Joshi:
> [  168.544078] ======================================================
> [  168.550309] WARNING: possible circular locking dependency detected
> [  168.556523] 5.16.0-kfd-fkuehlin #148 Tainted: G            E
> [  168.562558] ------------------------------------------------------
> [  168.568764] kfdtest/3479 is trying to acquire lock:
> [  168.573672] ffffffffc0927a70 (&topology_lock){++++}-{3:3}, at:
> 		kfd_topology_device_by_id+0x16/0x60 [amdgpu] [  168.583663]
>                  but task is already holding lock:
> [  168.589529] ffff97d303dee668 (&mm->mmap_lock#2){++++}-{3:3}, at:
> 		vm_mmap_pgoff+0xa9/0x180 [  168.597755]
>                  which lock already depends on the new lock.
>
> [  168.605970]
>                  the existing dependency chain (in reverse order) is:
> [  168.613487]
>                  -> #3 (&mm->mmap_lock#2){++++}-{3:3}:
> [  168.619700]        lock_acquire+0xca/0x2e0
> [  168.623814]        down_read+0x3e/0x140
> [  168.627676]        do_user_addr_fault+0x40d/0x690
> [  168.632399]        exc_page_fault+0x6f/0x270
> [  168.636692]        asm_exc_page_fault+0x1e/0x30
> [  168.641249]        filldir64+0xc8/0x1e0
> [  168.645115]        call_filldir+0x7c/0x110
> [  168.649238]        ext4_readdir+0x58e/0x940
> [  168.653442]        iterate_dir+0x16a/0x1b0
> [  168.657558]        __x64_sys_getdents64+0x83/0x140
> [  168.662375]        do_syscall_64+0x35/0x80
> [  168.666492]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  168.672095]
>                  -> #2 (&type->i_mutex_dir_key#6){++++}-{3:3}:
> [  168.679008]        lock_acquire+0xca/0x2e0
> [  168.683122]        down_read+0x3e/0x140
> [  168.686982]        path_openat+0x5b2/0xa50
> [  168.691095]        do_file_open_root+0xfc/0x190
> [  168.695652]        file_open_root+0xd8/0x1b0
> [  168.702010]        kernel_read_file_from_path_initns+0xc4/0x140
> [  168.709542]        _request_firmware+0x2e9/0x5e0
> [  168.715741]        request_firmware+0x32/0x50
> [  168.721667]        amdgpu_cgs_get_firmware_info+0x370/0xdd0 [amdgpu]
> [  168.730060]        smu7_upload_smu_firmware_image+0x53/0x190 [amdgpu]
> [  168.738414]        fiji_start_smu+0xcf/0x4e0 [amdgpu]
> [  168.745539]        pp_dpm_load_fw+0x21/0x30 [amdgpu]
> [  168.752503]        amdgpu_pm_load_smu_firmware+0x4b/0x80 [amdgpu]
> [  168.760698]        amdgpu_device_fw_loading+0xb8/0x140 [amdgpu]
> [  168.768412]        amdgpu_device_init.cold+0xdf6/0x1716 [amdgpu]
> [  168.776285]        amdgpu_driver_load_kms+0x15/0x120 [amdgpu]
> [  168.784034]        amdgpu_pci_probe+0x19b/0x3a0 [amdgpu]
> [  168.791161]        local_pci_probe+0x40/0x80
> [  168.797027]        work_for_cpu_fn+0x10/0x20
> [  168.802839]        process_one_work+0x273/0x5b0
> [  168.808903]        worker_thread+0x20f/0x3d0
> [  168.814700]        kthread+0x176/0x1a0
> [  168.819968]        ret_from_fork+0x1f/0x30
> [  168.825563]
>                  -> #1 (&adev->pm.mutex){+.+.}-{3:3}:
> [  168.834721]        lock_acquire+0xca/0x2e0
> [  168.840364]        __mutex_lock+0xa2/0x930
> [  168.846020]        amdgpu_dpm_get_mclk+0x37/0x60 [amdgpu]
> [  168.853257]        amdgpu_amdkfd_get_local_mem_info+0xba/0xe0 [amdgpu]
> [  168.861547]        kfd_create_vcrat_image_gpu+0x1b1/0xbb0 [amdgpu]
> [  168.869478]        kfd_create_crat_image_virtual+0x447/0x510 [amdgpu]
> [  168.877884]        kfd_topology_add_device+0x5c8/0x6f0 [amdgpu]
> [  168.885556]        kgd2kfd_device_init.cold+0x385/0x4c5 [amdgpu]
> [  168.893347]        amdgpu_amdkfd_device_init+0x138/0x180 [amdgpu]
> [  168.901177]        amdgpu_device_init.cold+0x141b/0x1716 [amdgpu]
> [  168.909025]        amdgpu_driver_load_kms+0x15/0x120 [amdgpu]
> [  168.916458]        amdgpu_pci_probe+0x19b/0x3a0 [amdgpu]
> [  168.923442]        local_pci_probe+0x40/0x80
> [  168.929249]        work_for_cpu_fn+0x10/0x20
> [  168.935008]        process_one_work+0x273/0x5b0
> [  168.940944]        worker_thread+0x20f/0x3d0
> [  168.946623]        kthread+0x176/0x1a0
> [  168.951765]        ret_from_fork+0x1f/0x30
> [  168.957277]
>                  -> #0 (&topology_lock){++++}-{3:3}:
> [  168.965993]        check_prev_add+0x8f/0xbf0
> [  168.971613]        __lock_acquire+0x1299/0x1ca0
> [  168.977485]        lock_acquire+0xca/0x2e0
> [  168.982877]        down_read+0x3e/0x140
> [  168.987975]        kfd_topology_device_by_id+0x16/0x60 [amdgpu]
> [  168.995583]        kfd_device_by_id+0xa/0x20 [amdgpu]
> [  169.002180]        kfd_mmap+0x95/0x200 [amdgpu]
> [  169.008293]        mmap_region+0x337/0x5a0
> [  169.013679]        do_mmap+0x3aa/0x540
> [  169.018678]        vm_mmap_pgoff+0xdc/0x180
> [  169.024095]        ksys_mmap_pgoff+0x186/0x1f0
> [  169.029734]        do_syscall_64+0x35/0x80
> [  169.035005]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  169.041754]
>                  other info that might help us debug this:
>
> [  169.053276] Chain exists of:
>                    &topology_lock --> &type->i_mutex_dir_key#6 --> &mm->mmap_lock#2
>
> [  169.068389]  Possible unsafe locking scenario:
>
> [  169.076661]        CPU0                    CPU1
> [  169.082383]        ----                    ----
> [  169.088087]   lock(&mm->mmap_lock#2);
> [  169.092922]                                lock(&type->i_mutex_dir_key#6);
> [  169.100975]                                lock(&mm->mmap_lock#2);
> [  169.108320]   lock(&topology_lock);
> [  169.112957]
>                   *** DEADLOCK ***
>
> This commit fixes the deadlock warning by ensuring pm.mutex is not
> held while holding the topology lock. For this, kfd_local_mem_info
> is moved into the KFD dev struct and filled during device init.
> This cached value can then be used instead of querying the value
> again and again.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  | 7 ++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 7 ++-----
>   5 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 459f59e3d0ed..95fa7a9718bb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -944,8 +944,6 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
>   
>   bool kfd_dev_is_large_bar(struct kfd_dev *dev)
>   {
> -	struct kfd_local_mem_info mem_info;
> -
>   	if (debug_largebar) {
>   		pr_debug("Simulate large-bar allocation on non large-bar machine\n");
>   		return true;
> @@ -954,9 +952,8 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
>   	if (dev->use_iommu_v2)
>   		return false;
>   
> -	amdgpu_amdkfd_get_local_mem_info(dev->adev, &mem_info);
> -	if (mem_info.local_mem_size_private == 0 &&
> -			mem_info.local_mem_size_public > 0)
> +	if (dev->local_mem_info.local_mem_size_private == 0 &&
> +			dev->local_mem_info.local_mem_size_public > 0)
>   		return true;
>   	return false;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index afc8a7fcdad8..af1c4e054a23 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2152,7 +2152,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	 * report the total FB size (public+private) as a single
>   	 * private heap.
>   	 */
> -	amdgpu_amdkfd_get_local_mem_info(kdev->adev, &local_mem_info);
> +	memcpy(&local_mem_info, &kdev->local_mem_info,
> +		sizeof(struct kfd_local_mem_info));

You can write this more clearly with

     local_mem_info = kdev->local_mem_info;

I think that would also give the compiler a better chance to optimize 
away the copy.


>   	sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>   			sub_type_hdr->length);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 62aa6c9d5123..c96d521447fc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -575,6 +575,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	if (kfd_resume(kfd))
>   		goto kfd_resume_error;
>   
> +	amdgpu_amdkfd_get_local_mem_info(kfd->adev, &kfd->local_mem_info);
> +
>   	if (kfd_topology_add_device(kfd)) {
>   		dev_err(kfd_device, "Error adding device to topology\n");
>   		goto kfd_topology_add_device_error;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 33e7ffd8e3b5..49430c714544 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -344,6 +344,8 @@ struct kfd_dev {
>   
>   	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
>   	struct dev_pagemap pgmap;
> +
> +	struct kfd_local_mem_info local_mem_info;

This would make more sense closer to other info structures in kfd_dev. 
I'd put it next to shared_resources and vm_info.

With those fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   };
>   
>   enum kfd_mempool {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 4283afd60fa5..05089f1de4e9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1112,15 +1112,12 @@ static uint32_t kfd_generate_gpu_id(struct kfd_dev *gpu)
>   	uint32_t buf[7];
>   	uint64_t local_mem_size;
>   	int i;
> -	struct kfd_local_mem_info local_mem_info;
>   
>   	if (!gpu)
>   		return 0;
>   
> -	amdgpu_amdkfd_get_local_mem_info(gpu->adev, &local_mem_info);
> -
> -	local_mem_size = local_mem_info.local_mem_size_private +
> -			local_mem_info.local_mem_size_public;
> +	local_mem_size = gpu->local_mem_info.local_mem_size_private +
> +			gpu->local_mem_info.local_mem_size_public;
>   
>   	buf[0] = gpu->pdev->devfn;
>   	buf[1] = gpu->pdev->subsystem_vendor |
