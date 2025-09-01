Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BB1CA0FF0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 09:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637AD10E0BD;
	Mon,  1 Sep 2025 09:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ty+nB0sD";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E3310E0BD
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 09:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjQZ9B/KV2Fh+OUcl/ovbyMpxrT0fp4SGyZPsvuuXhGsG3+PxBKVTWiyk4lZ8mxTRmLeU6+U/GdDJlYPkDbD1Rp8sn76gwI4MAn7dUG5p3DDTWHbfU0xiJJb4QnNQIqnVUKBb76Hba8/sIcr32o9eg0qisIJL8QnLrQgeVg1XlVaOXu42gw8GOeXDLWIfY/bx1DRnhm3ncR458YFP0fbN4PGGZ6YMdzEpK2snLXiN7xyYqCUEM7rdv412Fc0qMRWa7QeTfLVue7G+AASlgpGU1U/bUXbWkeRoLK7SxUFAa3JB5VcJF9dI1SM5wneDM2BFxH/t8SNXIJu36c2oLAlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJQiQC2AbdRp6EOGOne6b4AKVIvodoLx6BRs7+D0alo=;
 b=LjWbMFt1ainQE+55PkWGqa+OvHwhNWmefHtlLLiNNWos7tVU2/LQSahIvDGXR5n/65Cykq5+naJJfDGz5i7wHgmprGVBmlh3NPjlH4RbLcReuHR9oN/JNqo0WFH06gJYVG6MQiNNJ9mzIxzEpWyzOwqlOtZ2RqpJ7JSP3jcNthbXNoFhAaZFvx/RGt8coRCCx9AaUjCBEux80rBlrgvHivPQwccBx0EdDQf7xkVJbPeLATJtKZsyESiDFOJ/lblZbyil4nB9BN50qc3FicGBxO3ehHTi6IcOrG5JvyqTQcZx4tZxKl++qVAUpKVCkO6wj5u6gsiHUIj9SAQJNVTO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJQiQC2AbdRp6EOGOne6b4AKVIvodoLx6BRs7+D0alo=;
 b=Ty+nB0sDYLchOYrX18vIMsxzYM9CJiUxsVxNNwLSG24pceb5pmyW2+04ZpbU9HjAA8dAtYeRPuzJo/wIk/K7uFlRQbQslaMJhJ4CvgpaPfuthJZn9zhWy4fN0MClqjvGEvW0wfxXd2ZjDfqNOCBq7e13kObabo4cdIyV9yD0XiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 09:24:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 09:24:38 +0000
Message-ID: <f2c38451-2a7b-4f8f-8cd3-e19a842e2fad@amd.com>
Date: Mon, 1 Sep 2025 11:24:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] drm/amdgpu/gem: Return Handle to MMIO_REMAP
 Singleton in GEM_CREATE
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
 <20250829135523.4032168-10-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250829135523.4032168-10-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:208:15e::48) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f683391-cea9-4ebb-bb5e-08dde9395fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1htUGFnS2FreGlWeVYzbUhIZlZjYm96ejM1VGpkYk9PdVJlSm9uSTNyTW0z?=
 =?utf-8?B?VWVtNWd0RE5ZNDM3K3daV0x0M1VETkJKS0U2WE1lZ05WdVdjRXJQUmZnelcv?=
 =?utf-8?B?ajZpa0srYldlK2tRWlVlSllkUkFwVTE1U1V3MWlxQitYK0hnMGtvWDYzRGt6?=
 =?utf-8?B?WC9sMHBlUEJiYUlRaHZjNVRHdjRmRlRsWHRVc3ZtYTRjTjVxRzdaNjY2NklH?=
 =?utf-8?B?Yitha0psU01ReVdaNW9KYzMxUEUwV0JJOXE0YlB0c3poOGN2eGF6VWZ1NTNG?=
 =?utf-8?B?ZW5aMWI0S0QweWZlenJrbHBCYUkySU81Mk14aWhwMkpWYmV4Y3BhemdsUWJv?=
 =?utf-8?B?Y08wM0J5NGVlWnVuTytMVEtBMDFhOUhpemsvL01jTldJUnJ4WFN2TStZdmk0?=
 =?utf-8?B?MVo0dTNyMVpMeU9YWFhhZElwa2prRVRQSzNkYnFsOVdvVWRvQWF4cVZjUUF5?=
 =?utf-8?B?MElpNCtSQlR3KzhQWG5vOUxlcE5iSjJBN2MwNWNkdGRMODJaZ3NjNkhYUDhY?=
 =?utf-8?B?Q2lxaFo2RmZseHltTm1KRTBHc0IvUTNsMUo0cmpXNE1YWUpPWXAxYkpUWHdu?=
 =?utf-8?B?U3RrYVRXd2NQYUFTdGREMTdYTHR0azFhZVJVaVJUZjF5eFZuZUN2Q2NNQjRr?=
 =?utf-8?B?VmZnU3pqLzFCQnN6alprUGZRSk53WVRuRFB2aTVJKzlzbk90QzBuY2xnQlRt?=
 =?utf-8?B?d3k4Z1pqT2F5NEl6RVZzdEUzTGRPaHEwUlMwaWhRVWE4L2EwRkxEb3ptcnJT?=
 =?utf-8?B?Y0RiTThyZGdNVEE1UzhVeGlFOUtGak5SMzR6VEJDdzAzeU5VSFNQL2k1cE80?=
 =?utf-8?B?TmZsMHQxemxPQWptUkFSZnVhNHM4ZXZ5eURKbUZ4ZUtEcXF5bXZ1NUdyT3Fl?=
 =?utf-8?B?MUZrWTNQcG80YXR6cGQvUEd3VzZJQ0YxZ0JOamhUaWtkUGtTYXB2cmo2SjFj?=
 =?utf-8?B?L05oYzRWV1F1VjBjdDRsV2hOdC85dmhUR2IrTm43THNUd3UyeFg4dE9UcFR2?=
 =?utf-8?B?cWI0TlFaSzZJQ1dEVHFmNFB3a2VrcEpPejltMmlWTE1zakJrbzZrbDhMTmkw?=
 =?utf-8?B?bXJGVjVQVllsTUdQWWszUE1KRS9sVjA1UmtqSUdldzJwQTlieUM0VHE1SGlI?=
 =?utf-8?B?RUZmVDJBRE42MW1SSUU3L0tFd3FGdFlrd1NnQXNmSmRxclBzSE5MVmd2aWxW?=
 =?utf-8?B?blAzbjV3RUpKOEhVYkpvSGx5WXFzdU9qZkRrbUJobTlsS1hoc1YzelByOTdZ?=
 =?utf-8?B?TmdCS0Y3RUIxY0hrVGZRQTVWL0pNa0JCTFdCNmN1Ly9zT2UzdEJjK1hsYWho?=
 =?utf-8?B?U2lNQlluUWlFOTFHZkd0L1UzanZRZDlSTTduUTdKQVJVWVZyK2txZ1BnQlp0?=
 =?utf-8?B?dzZWNTFOdkZOQTBqdC8yU3djN1QzQ0FocFFYMVVSL29hd1JFVUNFRzJscU8y?=
 =?utf-8?B?U0FSNlVtRkZXdGpvQi8zRTBCcVQvLzFMbTdKSnhXaUVwY3NUMVBDZHRJbEpk?=
 =?utf-8?B?aENJQWlQNmw2RlBYaENpc3B1NGVBVU5yKy9BdHJFa2d0U0FObjN3LzB6RXh2?=
 =?utf-8?B?Ykh1alJIUWpCeGpWZTNsRWZFbCtOU2xHTXhETzMrQmlFSWJPYnBVeFBEVUZo?=
 =?utf-8?B?WFZqZUpFN1dFeTIvSTNQVUpsUDI3bUdqdjVIN1JQa3NuSXFiNUtHTEdjcGl3?=
 =?utf-8?B?WlRjdFVSck5HMUN0VVNxOTkrYjJUc25XNU9CVC9jZ05ISFp3U1M1ZzNhb2E0?=
 =?utf-8?B?S1RQbC82ZndBM1pOMk0yQmNtMXFkT2N2NmRWcEN0aGxJY3o3S1loREJIU3h0?=
 =?utf-8?B?Wi91T2VJb2twNm1SQmQrb0swNHZPVHNSOEdwVDNldStpdHpYRytGL3FhVTJo?=
 =?utf-8?B?NEVHNmJIbFVjQ3JWd2ZaU2JUNzl1cXJmR3dEcFdnZTh5NzZpaldMSWNycnZ6?=
 =?utf-8?Q?/wOCnMujx0c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXN5MVZPbGtmM21YRmwzV0QxZ01lZHdaZUNjMnJlbU51Z2I4dFQ5MzFiYndV?=
 =?utf-8?B?M3J6TlRyZWdBRTV5bWtPL2wvZkc4ajV1UlNZcGlUSk1CbURJOG1xdjhRUXQw?=
 =?utf-8?B?SkwyTnpROUxFYXE5M0ZkSlRXV1ZveUI4TnRsNXpaRjFXdWpJdTVoWVJSUllq?=
 =?utf-8?B?enBZZXVQcEh1NmNKdEI5cXgwc3BURENzUEFaRkhkcjZ5Q0oyU2NPdVRuN1pT?=
 =?utf-8?B?TlNvOVBLY3VrY3FsUnQ3MXJLY3J1OU5SWkN5QzJOZVJjekMyZlpNeTN1UWpU?=
 =?utf-8?B?Ryt0eGxUdFJ0RWJRZENDZ2JTV2xTRUZDOTRTSUx0L2ZibTJvWldjWmFJSEZa?=
 =?utf-8?B?QWRHQ2ZMSXpIMzVKVlptMVRRam9SclAzMjV3M1RtNGtET3lTZmJxV0pOanNI?=
 =?utf-8?B?WmZ4MlZBelZsQngyTVpQY1Biam0vUmZBcnZnSXE2dlB6c0Q1RnNnQmkvN2Fs?=
 =?utf-8?B?d0JkQTZKcXZQOHVlTGF5ZE40amk3eW90UG1yeUQ4NHN1eGRaSFFyWVRUZGJn?=
 =?utf-8?B?T25ZWE41amdPQUdad0oySVNpQUxBMEVzblQ0QWZvK3BRUkE5TUxsQWV0VHg5?=
 =?utf-8?B?bzhHamx5ZWlqS05IcnFBV0ZDclYzQlFMeUxaNk5kTUJsWEVrcXhKdFdEdnRY?=
 =?utf-8?B?Q2Z0ekFuQVYwQ3JGdEpKUGhlczBFK2dvMThxUFBMcURkMUdoR0JGR0dmVDNU?=
 =?utf-8?B?WGlCZnQ3bVl2ZlpuQXdtdTFKY3FCY3kxNWRpb3l2TVNwcXdxQm8vV0laOTNS?=
 =?utf-8?B?YWhCK0NGUFpvaFUrcm5hSDJ6a3M1b01EY01CRjVEZFkyUng1dDdLazlZZ1lH?=
 =?utf-8?B?OU5hbHNKL09yTUxIbEZMUFJxNnBKeElaSWI3MncwYUI1Zksvb21vSjVLSEFZ?=
 =?utf-8?B?VGV5YXloZzVCb05MenE3VEliUzRvSTYxVThzSTZzZW9sSjdBWGJWQUZKNEdW?=
 =?utf-8?B?ZFVIM1lubmgvbDFObkRmYTI4K3p4cDAyQnd0WDlXQWtGa21iQnBHam0vTWJZ?=
 =?utf-8?B?aEJhdDQ3cmUzKzFreFdEbGxzdFd4ZUdhMmZlS3JJOG5iQ2NXL0x1SlJVZ3d5?=
 =?utf-8?B?bm5wZ04vYTkwWnpoemMvdmhleDM5Z0o4WWtnZ0FYcmJ4emNWdksvOFk3dnFp?=
 =?utf-8?B?TXRmMzdTaGhLR2FMd2lvTFh5bThON056eGM5WlJaQnNpU25UaVN0WkJSYzVa?=
 =?utf-8?B?eHdoUFhsVTVRZkVOOHZDMXp2RlI4SXhIZVJITDF2Mk9peDcwYUlGTFZwT2E2?=
 =?utf-8?B?bytFRXRBRkJXNkJLWThYM05wa3ZHbUVJbno4VjVMSHQwZ2R3dWNFUHdnUTdv?=
 =?utf-8?B?a0VTaVhvazhXSDA5QkFLeTljMnRkRllJSFEyYXRybW81aFoyKytzRGNSTGFY?=
 =?utf-8?B?UUpyUGRpdGRjYVU3cm5oODIrQlVhU01CcXpWaEZDdzlJa2FyUW83MmpBSldu?=
 =?utf-8?B?elRzUmp4T1drSkN3NHZYeG5CQzhteFpCWGFTd3Y2eE44ZFpDTndkbjRvVjFB?=
 =?utf-8?B?WmJycDNDNmNsQTRPQmNNYVo5c0dpZmNLcVc2N0dtclBubzlLcDF4bHpqN09i?=
 =?utf-8?B?dFUzK3QxOHRkT1pKTGt0NUJZcU9hVXdUdGttbURxYncwSXZ6RDJqaXpzR1JH?=
 =?utf-8?B?SDQ3NEViamZWYjcyRHhaSTBnOW9hSG1SUGdrNlU4VUhoOFpwNVVMNmlHcXp4?=
 =?utf-8?B?M2tsbU5WWVlFRGdmREhReFNKcFI1NS9KbmtMQ1R0UEJ1Yi94Z2toMHB5c3BV?=
 =?utf-8?B?ck40d0NHNFNXL2EyQnR5YzZiQzRJSFFuTDU1VTJJTXNGUEZCdks4aXloSDZu?=
 =?utf-8?B?clpWUHpNQkR3MEh3aDU0clJaZlRCeTdGZFRvc0NSYmZVVEVoa3k4WFhYOU1k?=
 =?utf-8?B?alpXVGUwWHBzZzVnS3lxYnpIN0xHUjNUdUFvK211RDFXT2VFOVpKZlJEaG9D?=
 =?utf-8?B?L1IzcjRnNklTYzh3ZWNjS2x5bklTSFlNMlFBL01Rc0UzQTFkSnVsREd3OEJr?=
 =?utf-8?B?VlRUUTJFaG96UTlrVVhPTGtVMFR2eHZ3azJra0tGY2lIK2lRYjJUSVREZ3Bi?=
 =?utf-8?B?enRhK0JJMUxhWUtxbkVBMVllaDhsVWVZS1B3UFR1TmorM2NOZWdIOGFqbEdr?=
 =?utf-8?Q?DdKzLo7vereyhnd4QfTgd9nw7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f683391-cea9-4ebb-bb5e-08dde9395fd0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:24:38.8299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWgRF+n2xqWztzOSrxQHucD8lkDUxyWU+WsQLnJV9CrmrUJW8qkjO/RIKhgh1C6N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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

On 29.08.25 15:55, Srinivasan Shanmugam wrote:
> Enable userspace to obtain a handle to the kernel-owned MMIO_REMAP
> singleton when AMDGPU_GEM_DOMAIN_MMIO_REMAP is requested via
> amdgpu_gem_create_ioctl().
> 
> Validate the fixed 4K constraint: if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE
> return -EINVAL; when provided, size and alignment must equal
> AMDGPU_GPU_PAGE_SIZE.
> 
> If the singleton BO is not available, return -ENODEV.
> 
> v2:
> - Drop READ_ONCE() on adev->mmio_remap.bo (use a plain pointer load).
>   The pointer is set `bo = adev->mmio_remap.bo;` ie., The pointer is
>   written once during init and not changed while IOCTLs run. There’s no
>   concurrent writer in this execution path, so a normal read is safe.
>   (Alex)
> 
> v3:
> - Drop early -EINVAL for AMDGPU_GEM_DOMAIN_MMIO_REMAP; let the
>   MMIO_REMAP fast-path handle it and return the singleton handle.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 61 ++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index d3c369742124..7f331c34e581 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -424,6 +424,38 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
>  	.vm_ops = &amdgpu_gem_vm_ops,
>  };
>  
> +/**
> + * amdgpu_gem_get_mmio_remap_handle - Create a GEM handle for the MMIO_REMAP BO
> + * @file_priv: DRM file corresponding to the calling process
> + * @adev: amdgpu device
> + * @handle: returned userspace GEM handle (out)
> + *
> + * Creates a GEM handle to the kernel-owned singleton MMIO_REMAP buffer object
> + * (adev->rmmio_remap.bo). The BO is expected to be allocated during TTM init
> + * when the hardware exposes a remap base and PAGE_SIZE <= 4K.
> + *
> + * drm_gem_handle_create() acquires the handle reference, which will be dropped
> + * by GEM_CLOSE in userspace.
> + *
> + * * Return:
> + * * 0 on success
> + * * -ENODEV if the MMIO_REMAP BO is not available
> + * * A negative errno from drm_gem_handle_create() on failure
> + *
> + */
> +static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
> +					    struct amdgpu_device *adev,
> +					    u32 *handle)
> +{
> +	struct amdgpu_bo *bo = adev->rmmio_remap.bo;
> +
> +	if (!bo)
> +		return -ENODEV;

Mhm, ENODEV is probably not the best error code here. EOPNOTSUPP or something like this sounds better to me.


> +
> +	/* drm_gem_handle_create() gets the ref; GEM_CLOSE drops it */
> +	return drm_gem_handle_create(file_priv, &bo->tbo.base, handle);
> +}
> +
>  /*
>   * GEM ioctls.
>   */
> @@ -465,8 +497,33 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	/* always clear VRAM */
>  	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
>  
> -	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
> -		return -EINVAL;
> +	/*
> +	 * === MMIO remap (HDP flush) fast-path ===
> +	 * If userspace asks for the MMIO_REMAP domain, don't allocate a new BO.
> +	 * Return a handle to the singleton BO created at ttm init.
> +	 */
> +	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
> +		/*

> +		 * The MMIO remap page is fixed 4K on the GPU side. Do not
> +		 * allow use if the system PAGE_SIZE is larger than the GPU
> +		 * page size.
> +		 */
> +		if (PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
> +			return -EINVAL;

That check doesn't belong here. When the BO can't be created it is simply not available.


> +
> +		/* Enforce fixed size/alignment when provided by userspace. */
> +		if (size && size != AMDGPU_GPU_PAGE_SIZE)
> +			return -EINVAL;
> +		if (args->in.alignment && args->in.alignment != AMDGPU_GPU_PAGE_SIZE)
> +			return -EINVAL;

Either moves those checks into amdgpu_gem_get_mmio_remap_handle() or completely inline amdgpu_gem_get_mmio_remap_handle() here.

Regards,
Christian.

> +
> +		r = amdgpu_gem_get_mmio_remap_handle(filp, adev, &handle);
> +		if (r)
> +			return r;
> +
> +		args->out.handle = handle;
> +		return 0;
> +	}
>  
>  	/* create a gem object to contain this object in */
>  	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |

