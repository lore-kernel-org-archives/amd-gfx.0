Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF89EBFD0F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 08:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 995BD10E0CD;
	Mon, 13 Apr 2026 08:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="14opmKlb";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE9510E0CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 08:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h91c0gnnCrJH4sQDtpqspBQiqTWATUf+ApERxz5dhZ7OumrpKjwXJxTBM4IW2YYUdOJ5SgiJR9Jn8hJEygMGP8eXUAPxA5aNjt305WmFXh/W+mCl0r7PyoBXE5M5++NAlUx3caPXF53oo+6Z79/AdcZBbnp7lsB0Q7ppnUbO63uhbSd2qQcpnD8k3oJALWNC+KiOA4Yr9rW+gxXlFjv6dLU9MQ7KslYpwAM518I2EQnLAF6d7rp0HypFSK+5ATCT2F5zOAeOUzVwmaxF7W0wnD0uK2GrsbcRQJa957YlrbNQidFQAm76fRUomGfjYaNIXtqfJ+O9SGhrBQvSy3QIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUrSg+dYBFSOH8bDCw73+O8z2wYdaVPtRIOGr0SZscY=;
 b=sBRP4QshbR0qnQVPkIwAlGofGTFV+pT1CzQR6PSp/SqPymmsgThretqEXOfOlj+lYBrPU834Nq/r3/AP7l06BjCZELPhMQuKaTA8ow2VJx1gQqFQVK6N1I7EwbFFxGyMzicVxtgA0JMnvLQVjDNV2OescVGw1a8vblWGPItimf4UeU8sWshJDByjlXLbHgLuqwYIAN5ig/Kuk+tN+r7Wtw+q6IjLtdUMJE2b75MiwavAMFOx4kuDGWWBkQWcm4ud6ffMtkIm6hywD6VyRLSuH8NGuL3LlrpAqQveKINJF88lW4la4j5prmP7Sxwvrz8jGpvEckKVIg8oeILmyPMyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUrSg+dYBFSOH8bDCw73+O8z2wYdaVPtRIOGr0SZscY=;
 b=14opmKlbW0JkX7b2CkgGWFsz8HEsa3WhHpmX+neG81XYzWUd9HNWgsa7+uPN5De4gGJrRLY9mYp85S+qs7oi3/jfJan/SNbpQfF/5jj3k8vJFb44fs/bBQW6pg4ISc+3rAStPL/Zs0aJB3EWJ2BIc7OgN+2KiJxVnYHIm+Nlw78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by SAWPR12MB999140.namprd12.prod.outlook.com (2603:10b6:806:4e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:09:59 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5%7]) with mapi id 15.20.9791.032; Mon, 13 Apr 2026
 08:09:58 +0000
Message-ID: <e60ab1a3-4d5d-4294-9af8-577a55867112@amd.com>
Date: Mon, 13 Apr 2026 13:39:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] drm/amdgpu/userq: unmap_helper dont return the
 queue state
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413062153.4050981-1-sunil.khatri@amd.com>
 <20260413062153.4050981-7-sunil.khatri@amd.com>
 <eddfc400-5b5c-4320-964f-c7b57b749bb1@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <eddfc400-5b5c-4320-964f-c7b57b749bb1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::14) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|SAWPR12MB999140:EE_
X-MS-Office365-Filtering-Correlation-Id: d79770d9-6b8a-4374-be7d-08de99340e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: pDYhxhfK+YIVtG/MLsHhX7TJ7g9xWCyXVuOfTSGnPkuEEtH6sH/NduIhN6lbGi3hQK0V2BF7CCUYUq21qLdEF7yja/xtpn107i/EKSlB2QfzNNBZpZZWrFgwQ6xJSHxNss8LyMTq93L6jThv3f0PiINPyEOi7FrB5+rdFmmrKh05Y5u2haTZaTQ6AhUB62oX40TLzCA1gFa6ThiKshX+5VESxoeXeJibsfP0iQfQRv+frwyQziYRg7tA2LR/APn/XQYqLoEo6kyA+kwnMKL6PddB+Nsm5Ie7pOcyaRc6o7m0lSEXJYdDfhwsrX7wARHt1DmJ27fUqYnaO0lDEMAX5zwsGPDHKwJVBHL/0frmCM0hgNLWtBVaI+g3ybU34tbaRCJC3SM7XjwPOo1TiK+jHZ+yOko7bNVB6uJbzcuFchAxgzBpQRtcm5zaNK3xW0zFTgDbUdbfXHU0Ixs3VPeoDux2zsCvksxjlNHfACW/s9bz2PEtqQ+0HqvTe0WyLZvH7OyEUyJ4nxCXIP22h0aIJeXWKBOupkwJoP93qXF6/JCq0LbwO+OVjmkLxEa0Iy6GfO6ptxl9uSt47xFm1oq3v3qApBEDv6BIaiwOcsnMH1LYSG7aVcd463UuIYqJktehv46lZJkVSSbL7Hs5oisymS4T7V9aZSuxtnkSo7QKMkvdILHVkrANT1Iv2ZvQCW9FJNNz9ofcuDJT+f/KCB5/7g8RKAl9KcOc7l8uHArfmpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTZuTjFRMlBpZjM2OFJVK3NTZ1piQlIxbXZEYXNTUjlEZnNJVXBYU3NDZ0J4?=
 =?utf-8?B?c055a3p1S1hDZERZQkxXZ2pmUGQ3Ri9lVEkzb0NleDRSY0ZBcmlRQzhTN1JZ?=
 =?utf-8?B?SjNEREJlVVZBOEJzTTY3Mm8vV3o1Q1gxMnRkeFBjK2RjOUY3Yi9uczhxU1li?=
 =?utf-8?B?QWltWVVSTzJQOGpqYWZSU010QVVSMnFuTmtsY0xqZ2piNmVFTWJhckdqQkN6?=
 =?utf-8?B?S09zM0p3QWpiaG9OYlVBM3dSUHk5YlpXTTlDUnQ2YTVRSXkwM0hDT2h6bGZo?=
 =?utf-8?B?VVRlN1NsbG16ejBOOCtleG9Eb0Rqb2o3eHVzcWFiWUNud1o4L2NCMk9IRlRL?=
 =?utf-8?B?dnF4MWwwbUc5UEFUNW1raDJKam9XK29HaFZsRVlqUGZqTDlsVURUaUhuVmhw?=
 =?utf-8?B?cU5reHVvOE1wY1FiNTVoQ29JbUg4alNNeDAxUmFCSklPSjJrOXUwb2ZaNjBC?=
 =?utf-8?B?Vy85OUtUa0VveldQLzM4UnZMV0Yya1JSWlVNckNVZXo0THFuSjYwcTl5NkFj?=
 =?utf-8?B?N1VJT2NWLytLYXZmUjVRb0NmOFI1ekpWUUw1ckpYQkZiKzFPanExclF2QURS?=
 =?utf-8?B?N2Z6MUFHNzJZRGpCWUh4a215SjhKMUZHNWp3RjQzbGNLSzdWTHR6SlZXQjJu?=
 =?utf-8?B?QmJkVEdJVGltRlRnT04zYjJWY2JoOHNZTlVxeE9MZUd0RzdxRzFrVHZiTHM2?=
 =?utf-8?B?aVBDK2pnaWM4dFIvam1sQ2h6YllXU0NRajhTYk1UdEM2OXBNQW0wUGMwQVlm?=
 =?utf-8?B?alV5MmZGdXFvRjREb2ZpMTRmS3JFSFRYTlJVc09VTnczOTRYMFluNGZ3ZzY2?=
 =?utf-8?B?Q3dBWXFyUGd6ZzVldnptM1FXVUdrdHVnQWNpdkc2NE4xbllkamZMbzE5bEtx?=
 =?utf-8?B?ZGFLazRURjcxT1BvTWhrSWNsZVVEY2RpSjhIdldRRHNHTjJ3L3N3OWZGSnNy?=
 =?utf-8?B?QmFnaDQrdWFUY0hTZGh1b2FZUnZLY2Ryd0tHWkt6MGZtYWJRZXJBaGgvbVlL?=
 =?utf-8?B?QURVZTByWFM1WlRSQngyVEtwWmMwdXRrMjZCZlpEYXo0MFNvQ01Jb2tTMzcx?=
 =?utf-8?B?MTRmTElPQTBtcmVrLzQ0Z1FITnJiMVpKTlgrRkFXYThBSG9tL1crM0pjMHZH?=
 =?utf-8?B?R2t1ZVdTdjRnWUdlblBPVEFKS1RQT1p0WjU4Y2JSdStIUWI5T0pBc1hxQk1r?=
 =?utf-8?B?VWhaZm9FRUQ4TERCUjl0dHMrYzc3dGRsVC9kc1VQcWdxT2FnWEg0emhITkJr?=
 =?utf-8?B?ck4xV0hsL2M5NmtDdjdtb2hzaENYWHVrYkRhRklwcXRFQlVuUmdqUGMybFVH?=
 =?utf-8?B?QzhKSUV6RWt2NmN6ZzhZZ2RTVFpXa0hEOENKSmlVUlRHaVFBZUhTS1ZWNWNE?=
 =?utf-8?B?cGY5LzQrNWRUS0JaaGZuYStEM1Q4U3Rhcm43WDhaaUFRSktVM3NCalpibFM2?=
 =?utf-8?B?QVBjdjkwN2szSDNWV253RVZxT1IxREkxZGhDdmJnYWM2dExNb0FpeWJjV0pZ?=
 =?utf-8?B?UXI3MURZaHRiS2MvZHFoVFFrOGozKzhJTVdCSjJXUkpkK3FwYXZua2xITEtV?=
 =?utf-8?B?UitZRE1qZ3VXVnlWV0h5bldYVEQxaE9MaktkUW5lM2xSdWFZOS8yQnd5UmpI?=
 =?utf-8?B?bkhFNFZXWXBLb09qVjl1SVdNeGo4UE11YktnWGRWZjVhNTlOZ0x0Nk94Ly90?=
 =?utf-8?B?T1dhWUcxYWd2VHZZYzk0MThvb3JKUDJiWUtGUTBUb1haL3BuZHFBMnRkRnQr?=
 =?utf-8?B?T0QvcDB0YnpXdysxd2Zsd3RrMHpMQVQ3TVdCNFNQMkZhZDBWTW5UUEQ1VnVo?=
 =?utf-8?B?RlAzc1pjY3VkYlM2cDNET1YxdHQzOGZHMkJicGhFYXkyZlV1RmtqOGM4dWZB?=
 =?utf-8?B?K3BlSnJLTHUyYkhiMjNWSjhHc0s2dTljUkpNdER2dlNLSU91U3BPSzRxalhS?=
 =?utf-8?B?U2VLMTh4SmxuZVFzQXYzS0FmejRTNUpSY1ZMMEQ0Vm9OU2VhSHh3N3A4eFNF?=
 =?utf-8?B?bHArd0g5Z0JTYWQrU0tTZzdzNkVTb1lxV251ZGZSUmMybTY0OENFTENwd2lE?=
 =?utf-8?B?eVMrOC9MYlBlOTlrZjlPK0pwcjZZZ2QrWGZQOEpzSGtyaFJJYnRycHJnWVRG?=
 =?utf-8?B?QzNvM1VBOUpXQUZJaXBmVkhTb1laTWFWTmt3eXR4SG9vek5kMzQzcGVMNklS?=
 =?utf-8?B?UU5PcmprdHczVTkvKzhzK1RmV2NJYnNkQTlsem8xQ1dpd0YyK05wNEdTYVpR?=
 =?utf-8?B?QTB3QnplQ00vcDAxbDN3Z1NRa25FeGt5RlRjYytDZnpXUE4ya1ptc0JydmlL?=
 =?utf-8?B?Y3l6Wld5OXBRZlJ2SEN5OUloYkxrRGFoL2dNVXgrVUgvM29KR3grQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79770d9-6b8a-4374-be7d-08de99340e05
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:09:58.8833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djFmW2JnEKoeVZNKeo1KGof0lKP4f4xLoPgw8O9kr8nyrnRsroD9RkOtxU1QgiA3KeLIhhxRxaWx3Xh54Q464Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999140
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


On 13-04-2026 01:38 pm, Christian König wrote:
>
> On 4/13/26 08:21, Sunil Khatri wrote:
>> We check for return value of amdgpu_userq_unmap_helper and
>> compare it against the queue->state which is logically
>> wrong and we should just check for failure and do the needfull.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 86e7a93e93a4..e6d1811172b9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -641,7 +641,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>   	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>>   	r = amdgpu_userq_unmap_helper(queue);
>>   	/*TODO: It requires a reset for userq hw unmap error*/
>> -	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
>> +	if (unlikely(r != 0)) {
> Usually either just if (r) or explicitly checking for if (r < 0).
>
> And unlikely is only justified if it is a performance critical code path which that here clearly isn't.
Sure will update that Christian

Regards
Sunil khatri
>
> Regards,
> Christian.
>
>>   		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
>>   		queue->state = AMDGPU_USERQ_STATE_HUNG;
>>   	}
