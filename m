Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D38C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 06:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E534D10F90E;
	Mon,  4 Apr 2022 06:43:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7BF10F90D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Apr 2022 06:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsVxMAM2wrlGQUEbEgn9pW+rJpd2ZNaURlHsmpZQoe30kDjcXcUDbnKI6FjQ655gl1O1hcnrGQnk4ZORrrJQGi4TiiMGE2p9+T2Eo71uJDPCwyx1fQWiMLww5S+As/LOWnD2MFDsBNGiqWCuj8swZLN72zd+V4h+DdgYk/geIqn/YQ632DT4idORX+wvgTgijF3eFqs5+aSUjrH3N4yqj6yDalABXdYPKnA26MOxZNVx8+sFMBem1B9J5G2CgjtshcZHM32jrrVBWgC8RQsBUz0Eph1k2KopVz8tzUSLZwPlxN0v5joM7F4C6B4PP5lcDyAEWjRrEFhtzF97sKSBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg2on8MsqfOP9CpbOtWkY8EGoagiU+tJ/fHPDYZi89Y=;
 b=MW8ft/0g9bqilnP+CdHEYjgy5j+R/HfLARb+ll1svaTVnB3stXhVRjAY9BuvpMV3OsLUCFVS9Si/N5Zeks9Bo2NKY/zAzEcwJvxcXkk8Rc16H3kw858oESuAsQKl09JadDpRKGVthSgCfqgeJHVMuXzFDR92y+xc28YWB0WslsV3ygXsHfFMq3dVXMFr8VLa9mVJLGMrwlE3s0P0fpN8JBsCH4LoRVM7QNQN3FcZT5Q+DZGAuKagZIkVCIVENrANRt4eTGDzqIX6z3xwTzPaBqpRQ8d1uC+KS5jQiSlEUQtbknCsjmy3g6t3bgMgQnG/wciX/FaGgUApJUWceebB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg2on8MsqfOP9CpbOtWkY8EGoagiU+tJ/fHPDYZi89Y=;
 b=i8siEpB1MjBRHnnSpcWLoLlB5jwtzZA018Ne9lBbGqSSSjPhkkGH0F8jmU40eVC6fvvM5INQWaoCLO4XVKUY0ejLeShtG9/X6b/T6HXthbtR4gZEUq8zBiHlWvjJmTDBk+dxDAdBjlEEYLgXFawy/lHGjTa/REU3JUouCGaxPfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Mon, 4 Apr
 2022 06:43:13 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 06:43:13 +0000
Message-ID: <7f1d5626-8429-c06e-5642-5328f0d95044@amd.com>
Date: Mon, 4 Apr 2022 08:43:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/5] drm/amdgpu: allow specifying a syncobj for VM map
 operations
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20220331094727.27153-1-christian.koenig@amd.com>
 <20220331094727.27153-5-christian.koenig@amd.com>
 <CAP+8YyGwU+xJkBJ-AYPckQqpY6ucUWWp-QYO4b9UN7WcrEMGkQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAP+8YyGwU+xJkBJ-AYPckQqpY6ucUWWp-QYO4b9UN7WcrEMGkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::25) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 742ed1a2-8b9d-4863-3f88-08da160663fa
X-MS-TrafficTypeDiagnostic: MW4PR12MB5602:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB56020B8B926B9FEF7F8AB68D83E59@MW4PR12MB5602.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJ6s6LPaW9fm717M0/wTSE4AI5UyIB7+aAFkD+Oe7w1YwX4Njnc+FWxUsJiy/xvL7XTW+htLHp6bUvs4e0ZDkayn5D9WBsYfnC6jlVygrYJWHZrti/cGm7/Eq5Ht8KXGtl/fCuJK5oZqjCxls37gcjvIwQUnH5lZmrCfJ1eQtNC3kbGAYD7UuYCVDu5+Wl1r+RL3Th+G1N2lfODl4nVrIUCoW4CoYsdeKCGJw+BwL0o7o/e7CLLsU+mmDzwY5Nv+x1z3R0FBqi/7q8wImD+gBpIHgCSiqEyP5cm+74HRptchHTbF9YdeFDpb1wlEbDshVI7iB+jWMAV4qElLSstyIJQR9NikT9uF51+1QDqjn1I8IwhI6mprcCtd2BK7t7Y4B3xcmKxm3S6rK7ITiuLJyqWJbqgUJY6fk1EWisMoDa2s0q+76wMN3OHMbJjqPhLEVGPiI7I2ZzjXHHgJiWySAyEBdx/zkP2RKSwY3ZuJWZ/ON9XQmlwkmbFoTSeUD9qGVqyOxbNUANkClDojmR7IHtkQDOHuL4UQyIGXgBsJ/BpncY9QYknEBwUzDRX2nbxxuUwrTlkFWwYijua1sf/Dyo3WNA88+CRB4iOojM2gWD7f33/Ha1pXSZOF/7rrHyxurHWPz7XUwHmYwcr5TNO8d2KzOe2FM/BF7wO9VauopfnQKppvZPlTham2pwNoqvp6ur43DEcFlNQv1twOsqmU+isNl/3qlcOCv697dFVoPMpXpTdGmec88WcSV3exPAiTz6X9CvWLDZ4LaTG3VDapNoJUTrbeSo/rVLaq9LL6ffOTFD83E65iRqSVUymh8U/LRG7yTQgzuDsv5Ave8ifKzh8hRldsAJEQqtVLzn61R5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(6486002)(186003)(2906002)(508600001)(8936002)(2616005)(31686004)(45080400002)(26005)(66574015)(966005)(54906003)(36756003)(66556008)(83380400001)(66476007)(66946007)(38100700002)(110136005)(86362001)(6506007)(8676002)(316002)(53546011)(6666004)(4326008)(6512007)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnNNVStFY0NUL0hEbUVROXAzN2lMcVVzaUsvZURNTk5FdC9rR2tVRUtYS1dr?=
 =?utf-8?B?RDdpODRDN29xY25Oci9FY3pMVG93NDdRYTNZMlBoVkhyb051cWNhbjlmYWxp?=
 =?utf-8?B?NHlOcWNtYm9TSzZhN1ZWOTh1NUdVY0VmaHFXeWhjRWtjMXhUV2tQQWltc1ha?=
 =?utf-8?B?elNvQmYrb2pnWm83bXkrYk1GNlplb0FXZzdhR01QK3FHbktDKytuQ21VTVZy?=
 =?utf-8?B?eStBVzdoZTN6UVBMRTFwZVVSYXorSm9HQkxqcXk5UVlPTy9PdXdRd3NVMjlC?=
 =?utf-8?B?WU5nWWI0K3kySlROSnpRQ05QMUxZQU9MaWp1T1ZDMmtlTkJlT1FJeGdHVTc4?=
 =?utf-8?B?cE81YnM3Rlp3M1ZMZFp1a1BEb2lVZTdaWHRtV1JaaW5td0pPRjRUYUxRY04z?=
 =?utf-8?B?cG9MVkc0bnlYeG9oKzlTdkNwd2dWMU9iYnRGZWNXbS9ISURqME9SbGtVUG5N?=
 =?utf-8?B?MUpBWEw0WU9yK2FhdmV5aW8zdjdJU2JUSmJxV1F4SjhSN2p1Q1B6MGRpWUk1?=
 =?utf-8?B?Y3RuUUZ6bnQzOXlWUkRtR0FmeUxMZjlPcHdsc0Q3QjBwZnZSRDAyL1hDRjN2?=
 =?utf-8?B?SitZMGZxcVhIaTMxNkRBRWhKZEVqTHpaQjJ2WU1jNkViR2JPdGJJOUo5V1NY?=
 =?utf-8?B?QjJ4VVh5R01MNENqaUpLcG1rVzBoeTRBQ2o3dTMxZjZqR29kUy9ySWFlemZr?=
 =?utf-8?B?OGM2aGtXeExhVkY1S0VPZkVhMEVvaWRKZ2UzVk1ydnNDVEgzb2M3WTZnelpo?=
 =?utf-8?B?TktTM0xkZnRsS1RIMjVxVzBHMkVENENlVThHL3plNWdZZm95MXBKL1pBMnRM?=
 =?utf-8?B?YmdMc04zOUJwT2JNU21CenQ4WWl6c09DMmM1RkFUSWNwd3JUNWI2cDdMb3Vo?=
 =?utf-8?B?TXVvOStZdllENVAxYXdlQ2xQZDg0Q21SUmY1NlRDYzlQSi9xSVc5TzdpWmFV?=
 =?utf-8?B?RzRsblhubkRhbFpyRU41WFEyTFlKU0h1bDhiTDFhTFNYWHlFUXNpaFk2eTR1?=
 =?utf-8?B?TWVscDRsZGpQb2dRb3oydHdhQjAvNXVZVmFraU1ycmpQWTZoaS8zS0pxTk04?=
 =?utf-8?B?N3FvWjd6QUEwcGhqYmxhWi9TQXQrZjBBVWtSZm1RU0J6TUtnT3JPUXRib1BV?=
 =?utf-8?B?a2huaDFCWnVBNmhtaTZaNVQ2MlBRWFdGdUFXYXV1N3E0VE5FeXVpMWxnQW9n?=
 =?utf-8?B?REhGVGx3dWRBVFMvYXFzR2FpRlVNTjhncVRFMlBEL2xrZy9xR2s5bmp0ekRD?=
 =?utf-8?B?ZjE0aFM0bXFmUWMwMllNTWhGWCtGSk1scFpTTnVKczViVUQxU2I3K2ZIU1o4?=
 =?utf-8?B?VzkvWldpVGR4c3kwQjVWU09CeVdVWHBlM0UyNlNLZiszR1dzTGhkckFKN1Jl?=
 =?utf-8?B?VHV0TkxhQTM1cmdtLy85TjFCK0RJVjR1RHoxNFV1SGs0RXVFZldQNU1qMHJz?=
 =?utf-8?B?NzlBRFNUdGN6Qmp6M3J1WC8rdDJuY2loc0VqRyt0M0RrdGxnODZKemtQM3JP?=
 =?utf-8?B?Rk5PZ0gyd2ltbTdXM2FNZFRDZkl0YW95cUdXaVhJR2NLRGJEQytLem9MVVhH?=
 =?utf-8?B?bVRKNllvOW90eDhJS0JZWTNYdkJXUEZjemZkSHFrMS9sUHErY3BEbWt5eDBB?=
 =?utf-8?B?ek9Oak5qeEgrQTNWRitPLzNHYzk2N2dQUENwZm9remhWYTZQS2NHeW1yOTl2?=
 =?utf-8?B?aGt6V3B5OUdBYlN4OGtyZXJsR3NxZjlHNEhQa2prTzRldVdQeFRDMURQZmxT?=
 =?utf-8?B?QW9KUHRVQnJHczl4SXlhU0M2L2pDcmVEREJjbmlKYnFwSXFsNTZ1UU93Vy90?=
 =?utf-8?B?M2hpalloTXhxNlZCTHE5d0dsNC8zZlI3S3hjb3RLY2RKSHJiOUwrcmdURzdy?=
 =?utf-8?B?ZVN1SnUyU1VTVTF4cElWZytsQW5SOXNQT0VQYkdMazNSdU12VDc2cXlJbmZo?=
 =?utf-8?B?OWJHMHRnZ0IwUTQ3VTV6STNUOU1Ka2lSMEdCSzVWb2swY21FbUtuMTY3dzJv?=
 =?utf-8?B?eXcycXNRU1pUNGlVWG9OcFNpZFFKZC93WThpRTJVQWhGUURaWFRiVjdQdkgw?=
 =?utf-8?B?NmFESVR2bkxCeitTbHlCSkxFdnFqTzVMc1JTR0tRNE0zeWxqTFpVYXc3U2Mx?=
 =?utf-8?B?azU4OEtoRlpzU1R4NnJlTUFCSFF1V0hIL1FLUEsrZ3FROURHUHllV2tIV1Vp?=
 =?utf-8?B?RXRBdUpEZ2NBQXV5NDRyNmtpM2M2VnV5WjRQeGQvSVVVOWZUd3pGcVhwT040?=
 =?utf-8?B?b2psc0NsU2pZMkgyVE04cVJOcExsWC9yM2dob2p0ZDVlT2tYYzZwL2pxdVVH?=
 =?utf-8?B?NFgxcXNDU2FnLzQ5bExFWTBiNjdQWndubjYxR2pxSmRWRDI3cDR1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742ed1a2-8b9d-4863-3f88-08da160663fa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 06:43:13.1337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hjo+AHqRDFvNqADjYEbbnhJEunfqVeMOr8cVOZPywQzc7Jx7N6TxA8+NGtgCZlRJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Bas,

Am 04.04.22 um 03:32 schrieb Bas Nieuwenhuizen:
> Hi Christian,
>
> Couple of concerns here:
>
> 1) This is missing the option to wait on a syncobj before executing the VA op.

Uff, that was not really planned in any way.

Currently all VM operations are scheduled to run behind all CS 
operations and that is not easily changeable.

In other words we planned that disable the VM->CS implicit sync, but not 
CS->VM.

> 2) There are no mechanisms to disable implicit sync yet.

Specifying a sync_obj will do that.

> 3) in radv we typically signal multiple syncobj, so it would be nice
> if we could have that capability here too. Technically we can use the
> transfer ioctls, but it is kinda annoying.

That shouldn't be much of a problem.

> I had https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FBNieuwenhuizen%2Flinux%2Fcommit%2Fd8a1cce0c4c5c87522ae8866faf4f67be7189ef0&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C6d4dec03a52b4ce510b208da15daf2fa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846327828400310%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=K6J%2FHb2NAL8NpoTkaqmpjq4xJS9ozpu2UJBZwSA8OIk%3D&amp;reserved=0
> + radv implementation before we ended up in the situation of waits not
> being a doable thing.

Well I changed the TLB handling so that waits are doable now :)

>
> For (1) we can emulate in userspace by waiting for all syncobj to
> signal first, but I'm concerned that will result in GPU bubbles due to
> CPU work.  To test this out I'm starting to hook up more implicit sync
> disabling stuff (starting with the submissions themselves, WIP at
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FBNieuwenhuizen%2Flinux%2Ftree%2Fno-implicit-sync&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C6d4dec03a52b4ce510b208da15daf2fa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846327828400310%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=taf3fjRYd2OT9GR%2FgtBsCcoIOtOW0pYjdcsGAe%2BnJSw%3D&amp;reserved=0), which
> is why you're seeing some random comments on your dma resv usage
> series coming your way.

Which is rather welcomed. That patch set certainly needs more eyes on it.

Thanks,
Christian.

>
> - Bas
>
>
> On Thu, Mar 31, 2022 at 11:47 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> To improve synchronization of command submissions with page table updates RADV
>> wants to manually wait for the updates to be completed without affecting
>> parallel submissions.
>>
>> Implement this by allowing to specify a drm_sync_obj handle and a timeline
>> point for the GEM_VA IOCTL.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 79 ++++++++++++++++++++-----
>>   include/uapi/drm/amdgpu_drm.h           |  5 +-
>>   2 files changed, 67 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 9cdfee67efeb..bf0092f629f9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -33,6 +33,7 @@
>>
>>   #include <drm/amdgpu_drm.h>
>>   #include <drm/drm_drv.h>
>> +#include <drm/drm_syncobj.h>
>>   #include <drm/drm_gem_ttm_helper.h>
>>
>>   #include "amdgpu.h"
>> @@ -598,6 +599,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>>    * @vm: vm to update
>>    * @bo_va: bo_va to update
>>    * @operation: map, unmap or clear
>> + * @last_update: optional pointer to a dma_fence for the last VM update
>>    *
>>    * Update the bo_va directly after setting its address. Errors are not
>>    * vital here, so they are not reported back to userspace.
>> @@ -605,20 +607,21 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>>   static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>                                      struct amdgpu_vm *vm,
>>                                      struct amdgpu_bo_va *bo_va,
>> -                                   uint32_t operation)
>> +                                   uint32_t operation,
>> +                                   struct dma_fence **last_update)
>>   {
>>          int r;
>>
>>          if (!amdgpu_vm_ready(vm))
>>                  return;
>>
>> -       r = amdgpu_vm_clear_freed(adev, vm, NULL);
>> +       r = amdgpu_vm_clear_freed(adev, vm, last_update);
>>          if (r)
>>                  goto error;
>>
>>          if (operation == AMDGPU_VA_OP_MAP ||
>>              operation == AMDGPU_VA_OP_REPLACE) {
>> -               r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
>> +               r = amdgpu_vm_bo_update(adev, bo_va, false, last_update);
>>                  if (r)
>>                          goto error;
>>          }
>> @@ -671,6 +674,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>          struct drm_gem_object *gobj;
>>          struct amdgpu_device *adev = drm_to_adev(dev);
>>          struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +       struct dma_fence *fence = dma_fence_get_stub();
>> +       struct dma_fence_chain *chain = NULL;
>> +       struct drm_syncobj *syncobj = NULL;
>>          struct amdgpu_bo *abo;
>>          struct amdgpu_bo_va *bo_va;
>>          struct amdgpu_bo_list_entry vm_pd;
>> @@ -714,17 +720,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>                  return -EINVAL;
>>          }
>>
>> -       switch (args->operation) {
>> -       case AMDGPU_VA_OP_MAP:
>> -       case AMDGPU_VA_OP_UNMAP:
>> -       case AMDGPU_VA_OP_CLEAR:
>> -       case AMDGPU_VA_OP_REPLACE:
>> -               break;
>> -       default:
>> -               dev_dbg(dev->dev, "unsupported operation %d\n",
>> -                       args->operation);
>> -               return -EINVAL;
>> -       }
>> +       /* For debugging delay all VM updates till CS time */
>> +       if (!amdgpu_vm_debug)
>> +               args->flags |= AMDGPU_VM_DELAY_UPDATE;
>>
>>          INIT_LIST_HEAD(&list);
>>          INIT_LIST_HEAD(&duplicates);
>> @@ -763,6 +761,30 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>                  bo_va = NULL;
>>          }
>>
>> +       if (args->syncobj) {
>> +               syncobj = drm_syncobj_find(filp, args->syncobj);
>> +               if (!syncobj) {
>> +                       r = -EINVAL;
>> +                       goto error_backoff;
>> +               }
>> +
>> +               if (args->timeline_point) {
>> +                       chain = dma_fence_chain_alloc();
>> +                       if (!chain) {
>> +                               r = -ENOMEM;
>> +                               goto error_put_syncobj;
>> +                       }
>> +               }
>> +
>> +               /*
>> +                * Update the VM once before to make sure there are no other
>> +                * pending updates.
>> +                */
>> +               if (!(args->flags & AMDGPU_VM_DELAY_UPDATE))
>> +                       amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>> +                                               args->operation, NULL);
>> +       }
>> +
>>          switch (args->operation) {
>>          case AMDGPU_VA_OP_MAP:
>>                  va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
>> @@ -786,17 +808,42 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>                                               va_flags);
>>                  break;
>>          default:
>> +               dev_dbg(dev->dev, "unsupported operation %d\n",
>> +                       args->operation);
>> +               r = -EINVAL;
>>                  break;
>>          }
>> -       if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !amdgpu_vm_debug)
>> +       if (r)
>> +               goto error_free_chain;
>> +
>> +       if (!(args->flags & AMDGPU_VM_DELAY_UPDATE))
>>                  amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>> -                                       args->operation);
>> +                                       args->operation, syncobj ?
>> +                                       &fence : NULL);
>> +
>> +       if (syncobj) {
>> +               if (chain) {
>> +                       drm_syncobj_add_point(syncobj, chain, fence,
>> +                                             args->timeline_point);
>> +                       chain = NULL;
>> +               } else {
>> +                       drm_syncobj_replace_fence(syncobj, fence);
>> +               }
>> +       }
>> +
>> +error_free_chain:
>> +       dma_fence_chain_free(chain);
>> +
>> +error_put_syncobj:
>> +       if (syncobj)
>> +               drm_syncobj_put(syncobj);
>>
>>   error_backoff:
>>          ttm_eu_backoff_reservation(&ticket, &list);
>>
>>   error_unref:
>>          drm_gem_object_put(gobj);
>> +       dma_fence_put(fence);
>>          return r;
>>   }
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 1d65c1fbc4ec..f84b5f2c817c 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -533,7 +533,8 @@ struct drm_amdgpu_gem_op {
>>   struct drm_amdgpu_gem_va {
>>          /** GEM object handle */
>>          __u32 handle;
>> -       __u32 _pad;
>> +       /** Optional DRM Syncobj to signal when operation completes */
>> +       __u32 syncobj;
>>          /** AMDGPU_VA_OP_* */
>>          __u32 operation;
>>          /** AMDGPU_VM_PAGE_* */
>> @@ -544,6 +545,8 @@ struct drm_amdgpu_gem_va {
>>          __u64 offset_in_bo;
>>          /** Specify mapping size. Must be correctly aligned. */
>>          __u64 map_size;
>> +       /** Optional Syncobj timeline point to signal */
>> +       __u64 timeline_point;
>>   };
>>
>>   #define AMDGPU_HW_IP_GFX          0
>> --
>> 2.25.1
>>

