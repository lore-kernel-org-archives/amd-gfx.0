Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87044C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 20:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4455660EDF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 20:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4455660EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA4FC6EA95;
	Fri,  5 Nov 2021 20:57:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E82E86EA95
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 20:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5XFTPXexyBnJPQ8acd5kehSRF3oKgQjmZLyr9dHlqwypnN9ba31+44BZcQnPgnP8XipDCNgnW++uKN2ua1sZE/E31jv984EX9QS2yO7K7edmqG/l/xUi1jgTdUU0SShm1jsJs4O7DW6HBk8Y6kJIfwHvy/OjTRHsKjT3TdGlgieWpCIdiSRL8rlrVnDoVXb6mzgFCGGixfaFMtkxYrJ3ZKRN2MKLoXJUSVMiDJxMA4TJzl/r3v1rTsQVI2s57bJYFbUjwNqK4/HUq95wCcVrMFX+TLX1oG6aUnxH2vJKtzh8R4FjeD2XiYc1gau2MBVmJ/5zw7mDmXa+QKgufDNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdavtoOcseenIrpEIROP4syrVeXRBRXRQvb8p5AyaN8=;
 b=cnZqjvGHTWSPikm20z24s2jjnjsUhQuKXRN0s0/X2a/LQOVKNI+Oqo0B7KdaxqR4EvARTsoiwfE2elIfiK2Srv5x8zPbwm1RkmAZ6xVm3URqX5Q1Q6u573Q/3pT3M0mIRh46hyBC/RzQKHaB3nFbL1HsOLTK1hEwCM35elRcaeBGNv6FIHg/OYngq+yugbfR0APRBX77MsOQnEAEu6YsoFHwmXwpstMwA3n0X72GBN/tCpbtKW4Ab9fas0cq/agJN3yzWDdfvBHVJetVyJ0VLgS+KYPVads5uMUrfYxlWVpPpZvWkeRF3KO0TxPkSiyMTWTuqayrSqhLvEFIjnBJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdavtoOcseenIrpEIROP4syrVeXRBRXRQvb8p5AyaN8=;
 b=N1sg9Vkt4GqeUCtznL9gTiyq3BGeNKkAcLBqZtSinsCC/uCF6MzWB7otj9uMGTQLYGzs6htSuaI8hyjY5hjPLf5O8ljVUuqDNgFaOo3k3X7hncPKKxSr51d16qo+E/dX2nY26BIGmhTqG2a+YCvaLNZJGliHkDZtnI8SME08Tk0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 20:57:30 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 20:57:30 +0000
Subject: Re: [PATCH] drm/amdkfd: lower the VAs base offset to 8KB
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211105192540.16241-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <607686c6-7dd6-919d-3499-999e5d3cd097@amd.com>
Date: Fri, 5 Nov 2021 16:57:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211105192540.16241-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PAZP264CA0089.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa::12) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 PAZP264CA0089.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 20:57:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6c14688-766d-449e-cc91-08d9a09ee1da
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3835BF153A3326E1B957DA7A928E9@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4H1B3HYNrME/OnocIygwnc5rHL0nnvXFvhnyyKG71G9sVFaO48tfX4vKfwWqYV+v18rbjfDjBjPo89RyvtmqjzmEVdWVN3Q0+ZjcliSmpXb4wxpmnknyM16idqcG9fW+YTn4PKZMzyR8WQb/rPFLG8zu1/bTEyhcB2TN4qcasM8DSEzrOiJIvdB9PVDVy1J8zK6WnFAwuKRz14x2bY7yyitFq0uA0c/wfNr+i0nswK5bcBtcm3mrxBrjANIvYmW4PHSW+UCE92tNBqKvPxMhiZbQrmTBtKqJwHw5VrOSNGPpfzV/gezYOHNvAmFHHhpWFM6R5K3aM4Lx4lDJRDn0ALApzsfGs09w03uLwhjLAXhvq6/u3vVL53bCQYb5RCeHd2OyYlF0jaceLoRZCHKZWJsrvpb3xLLleIbDpoJ6Sq+QIWpxmj4ZbUvbFJ0FySkgMDn6Of0Dgd/ZKB/SW49wcErqW9eBlsFGf8DP5EwkKKL9+Rnt4P0TW3GFnXjDZTVNcmm1Wd6p/di0V7L2/dF4wtLHTM3XSBZ5fD4g/THEkgWxv1sTvI8hNc2V5MoI66NbCFaV/Gu4KKLwXvXR1TonfUxwtxGbIs1c44pFw74m1aBeifx/GQTbgRGEFS0yC4tdbwHV7sz4T8j1ocPxnGeRZSsRPQtp1KfukR8VWFCKEcdc9543/Z0NZlnomgNkPVeCV6gOmoQljN7ut/I4LvO6u9guMNKz2MudrFXkzChpQsMivfpGeUp9iYqP+O2UPfF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(5660300002)(44832011)(508600001)(36756003)(36916002)(53546011)(26005)(66556008)(2906002)(66476007)(8936002)(66946007)(316002)(16576012)(38100700002)(8676002)(6666004)(956004)(31696002)(2616005)(83380400001)(31686004)(6486002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlpL1ZTWUIyT2JZQi8rZmw0L25OVERRSW1sSHk2bDRHQ0l3VStNY1BiNVJF?=
 =?utf-8?B?WnF0Z3BjdmFFMnZ3U3pVUnNHWC8wNGVDRjIrZVJMNm8yaXRnZGZBL215cWF2?=
 =?utf-8?B?T0pvK3VFSjQrdit1dkk3cE1aN3FZVW9tZEJXV3JTWjVJM2grc2FWMVVFU21t?=
 =?utf-8?B?OFJpdnlDSFVKVjIxNDk2ZnVqZC95VTNZNHVFcWNub1BjaDRDRmNibmJlY25t?=
 =?utf-8?B?OXZlU1B0QjhaTlFaQ0hNVzRxZ09Ldmd1ZS9vSnJnRWZWWkNWVG55VXJzN2p1?=
 =?utf-8?B?dGNPYVl2RFUwTHdYTkIyWlBnRWcvNFdWWENYTlpLQURMd2Q3cTJYdk1kUXBw?=
 =?utf-8?B?VGZaU3BkbkF0Z3NBVmhqczRHdjZsaHpINktzZUs1L3BaMGxsQ2xvZ3pkY0tm?=
 =?utf-8?B?Y1p1QTNHK0E0NjczWlNRdDFOSldlVDU5SzB1dWMyVm5Ba3BWRVY2NlRCa0dv?=
 =?utf-8?B?SGpVc254dElUWG5zV2YxNnJzL1JOMmpjME1oU2tvczJ6bkJCVEZCSk5PcHQy?=
 =?utf-8?B?RE16R2xmNmtISDM5SDh5ZS9ZcW5lcy9HUmJWUlp0bURLV2pZRVZFWGJ0L0sv?=
 =?utf-8?B?VFhlS2F6ZjMyVFpydE8yMnRoeUxuYVNhNkF4VlZ0ZnRJb1hud3JGYVZOYWdU?=
 =?utf-8?B?OU4yZmxrenRRc3hOcHltZ0V1Ry9lcnpRdWp2SXJLZHUvaTRTZ3ljTmZzNTRX?=
 =?utf-8?B?V3NFY0VRamdSTVMzYXl0RDlIUldoQzlFL3BMWWk3RTc1UVR4NFUvc05yQjl2?=
 =?utf-8?B?YXNEYWdNenlvWit0eFNlZUZkVUl3WVZ5SE10Y0tyVHFCZUoxMERleHdXY082?=
 =?utf-8?B?VEx4Z0ErKy94eHZzZ1FjdFhQYXorN0VUR3YyUzgvRFZ3QlcwOWowOWtuRWhT?=
 =?utf-8?B?UW84VHFoejFuTElWVFVUOHZrNFhjNXZOemFyRnFUTFJ5STBGTE5hL1FmNWpI?=
 =?utf-8?B?MnFxNHF6WHlJMTZHTTF4SDN6eE1HMXE4SithVjdSS2FNSXJEWGlCZVg5Q0I5?=
 =?utf-8?B?R3h1aU8yWXlTanpGeVZUWmFxTzA4K09oRWZRbzhlVlhUT2ZtNEM3WXpxVTBv?=
 =?utf-8?B?dmJQUWw0Yyt3T2tUekZOd2s4VXpWOUx5Wk9KR3BoQ3E5bzQ0bnh1NWVkZWJx?=
 =?utf-8?B?eC8zOUhXLzN0U2F6SmtMRWVNUyt4ZnJQWjI4SDQzSGlkM290dVNiNXFraDEz?=
 =?utf-8?B?dHdLcW9yTDBLNnRRd3Q4TlZxamU2Nmc2bGdEYnNCbStqaUFQc3RLaWdISUY4?=
 =?utf-8?B?UFVjUXE1WUZua0NpdkNZV3RqVm45MHNOTnBaNENva1ZrOHZwRGxtQWgvWGdW?=
 =?utf-8?B?YVplQjBoR1BpTEM5TXhQT2pYM1k4aDlobEk2Y1JUR1lndDVyL0N1UTUzQVhl?=
 =?utf-8?B?cGUyY3NFbVBkNFFmTnVHTjZKLzk0dkpxOElZYzRoVjluR1BDeUg5NGc2Rzhi?=
 =?utf-8?B?d2ZtamlEUVJzeFNkSjRUZ0EyUW8zQThSeTRMbmJRTzQ2TUVUODJyMHpybERN?=
 =?utf-8?B?dFBSVGxFN0h5SkFRQ1ZZK2h1Vkw0T1RHNnBseW95aFpnMWVsY1ppeWNSTmQ2?=
 =?utf-8?B?a1U1Uyt0N0R2czErYm84U0xVUVFkd3p2WlpUQzg2SVd1M1hmNC91WSsrRWUx?=
 =?utf-8?B?eUY1amlxSmVsSTlnZ3o1bTJ5dkVPdHdQYUFkaFV6SFVRZnduNG5uOWllWENp?=
 =?utf-8?B?UlRpbUhsMUlVMHg5eUZudkR4bnB0WGxySlRacUNha08zTUVOWHA0R1VvMTF1?=
 =?utf-8?B?Q0hzMndGcU5lcHhhY0ZQT0VMc25BYmlEbDdFUzQwWmxDeTEyRmFxZE56QnpJ?=
 =?utf-8?B?M3JvemdUS1RXKzQzRG0yT0FPMnJnbFIxR2tIYzdFMWRIQzVsWHdvQlBJZGVC?=
 =?utf-8?B?eWJSR0hvbENlTUFRREF2cU9IaEJFb3YrZUdmbGRGMGlYYmJ3WEwzbG9GR1p2?=
 =?utf-8?B?clZodHBub2V4UW5oazIwNVhmcWpaMHhzdy9ncFVONVB2a3hHZ2ozS3hDeE1S?=
 =?utf-8?B?RU1KMG5GUHMrWE1NWFRpODliWmZSdG5oSHQxSDFCY3gzSjIxMWkwY00zVFdm?=
 =?utf-8?B?Z0FGTU1aR0prZTBmc0tXUzNJWm40WWVYa0YyZE50M2NzcVBqYUNJTlB5bDFF?=
 =?utf-8?B?VTB5dTRWKzN3MkRoN21KQ0FTV1VJckdaY0EzTEhDSlQzY25HbTVuaSt2NWNK?=
 =?utf-8?Q?8rax5xQYUr3YJIU2JrACvvU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c14688-766d-449e-cc91-08d9a09ee1da
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 20:57:30.5554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Khb8Oi8F5kLVa2cBe2A4TnwEliOL3jERHHrvXYCWbiMoPpS13/WHydY5Eo1Ol05u9+qocr5JoiAbkTYb2sU1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
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

On 2021-11-05 3:25 p.m., Alex Sierra wrote:
> The low 16MB of virtual address space are currently reserved for kernel
> mode allocations mapped into user virtual address space. This causes
> conflicts with HMM/SVM mappings at low virtual addresses. We tried to
> move those kernel mode allocations to the upper half of the 64-bit
> virtual address space for GFX9, which is naturally reserved for kernel
> use. However, TBA (trap handler code) has problems to access addresses
> in the high virtual space. We have decided to set this to 8KB of the
> lower address space as a temporary fix, while investigate TBA address
> problem. It is very unlikely for user space to map memory at this low
> region.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index 2e86692def19..d1388896f9c1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -308,7 +308,7 @@
>    * 16MB are reserved for kernel use (CWSR trap handler and kernel IB
>    * for now).
>    */
> -#define SVM_USER_BASE 0x1000000ull
> +#define SVM_USER_BASE (u64)(KFD_CWSR_TBA_TMA_SIZE + 2*PAGE_SIZE)
>   #define SVM_CWSR_BASE (SVM_USER_BASE - KFD_CWSR_TBA_TMA_SIZE)
>   #define SVM_IB_BASE   (SVM_CWSR_BASE - PAGE_SIZE)
>   
