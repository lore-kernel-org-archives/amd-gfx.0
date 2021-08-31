Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C11C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 04:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6C460F6C
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 04:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C6C460F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE99089A98;
	Tue, 31 Aug 2021 04:03:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC8889A98
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 04:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+w5fEdAaNHoOet6FbESafMBj+F1tvpOT/x6e/UrV9S1ow/MxzB569DC+rzNqScn8Xt4Gd4qRZ3yAgpKXm9aW/sH2yzr2Z/g9o61Ehb9j0Mz5ctwZsNAAeP81DeZlAazHIYo2VN4bcNg6x3y1xwrmwp5bhKFbexCl4REdwB8wmdDJR48tgStws4jQBHhbBr/DifFOb+42pXQWtPSr+1SUT0fUZwvA+9w0ypjnCARHQhkS6shCAneMLzfhm4NlV+Eh65UrYS6FTD5cl1N8uEtEENkkdytiY9b1DByF/2HEYxKPFwtmwSO7zVbbhtfjnwd0jNvHfLF/JJ7uJMnf/E9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYLavtxZkoSG+/E8qUd/5CK38hXruo5/gzz4St+mg7E=;
 b=LPeqBJBHVTYBiV+JiLp+YVefr4EI9ziHAhSEbUC7TtmPXIpve9nOs/4Y5Kc7syfWRAK1w7d5+K2Bl1d+oQwqzUfaz6/so3TH6tSGUsSuenRvO94vfT72APZB6RpA0MFZMS+GIKLr9ci8ap9Fn1JV/nmgHki9dh9gijNSLsdmPrGj0EgMUjM2KP9AhHLj4XfS4ka3QzRoRVZkUuyPbxY/zXpvouhme/wn539dfZ1VaVyCkgdjRzGClpq/2BD8EMqtd2hPVtZz5AWhwyPr0RGzzm5YCu0Z04nE4Roae7RHbCPvnQsbZjdojtwvZFb/idpVUQysT5TNO4TtX9STSG9nAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYLavtxZkoSG+/E8qUd/5CK38hXruo5/gzz4St+mg7E=;
 b=C8TY6G9NPFxioOjLQbGLQCJmV0kdjAyGwG++ddCQf3u8ME8hDYuCNacG3eg8DdBaTWtOmPl62VQQFuQTK7bA8ctXs35kCPuO9qlf9OrGLrDVImQRf3i8/Pks5lz1POxPfNPkWssKJjpnZLQHaXqaYr+kWQ/odLR5xEd+MPssCGE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Tue, 31 Aug
 2021 04:03:57 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d%6]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 04:03:57 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation fails
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <DM4PR12MB5165AFECE854E6A4E82A05DF87CC9@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <0a52e64c-c5c7-ab65-4370-94374e2d0458@amd.com>
Date: Tue, 31 Aug 2021 00:03:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <DM4PR12MB5165AFECE854E6A4E82A05DF87CC9@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::7) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:fe36:59a5:493:2924]
 (2607:fea8:3edf:49b0:fe36:59a5:493:2924) by
 YT3PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23 via Frontend Transport; Tue, 31 Aug 2021 04:03:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f2174cf-cb17-4c7f-b29f-08d96c345b23
X-MS-TrafficTypeDiagnostic: SN6PR12MB4623:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4623EF124BBB7C3A5F896B3CEACC9@SN6PR12MB4623.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdTryzfgnyzfebyGxLBqULyukIJImvKGK/cXfjpLHnbqwmMhBZIa67cp02SWNftGKtKROdqtmvQcRHVK/jOWCOZB/GvBMMuwVp+rwjoYHiuSn10ZVMn0X5dPJxYVS9YqOWwOqHFXGp1WVmoPGEvI2LrPFrbPPr1S8rAE4k/V3FhY8Ih/QdR80fH1j16o4bKNju8xShrfqY8ASvr+osmPLj8Jln7/Em+u5Wp4h1CRMqr8Hh135esW8wwFLrOjO8ITzkvLuQDBgwGu5plmkqGp0SK2/aytxLF0F3Re/fr4DiIGxdw6nkEaefQomV0wWeovoWFkUiB+bdbXqQl1fuArt1AHtK9yddtCqp5iXaiX+qsH11sUTi6fnXDyzHWTMZI3pPwADcBaZXZFozKU4hActxUiOmqgxme9LVh2kOBPp/15vCdiyPL+WTmK9P2ROB2pwIIHDsUmEFul20YtpUSndLmbZFwpRyBAiqW0rxHSW7l3T/nU+uWznqtb75gi7mKFUu7DqJ1V3UT2SBcJyTStMFAFedEnVEN8jL9OS7wjEL5ELCsAI75pWTji88a1wvaMw0jCOJYAHaVqAgICyxV6ppa7X9KYpBVVXxYNqUPeuUUYDRoqNDYIK3NBykXZtO672Sw+fgJE3NcaqRyYPKYDS//Cj78IzRT3nbKdyj3KBijKMKHjkLHyMYBABb8kkhuxsTy71eFxbkA/1chowHCJy8adBUNaD060EDq3Ju1GKbftA5gDWQBj0js5gSSiBO+P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(54906003)(2906002)(6486002)(110136005)(316002)(31696002)(66476007)(66556008)(4326008)(8676002)(8936002)(36756003)(83380400001)(66946007)(186003)(53546011)(2616005)(86362001)(38100700002)(5660300002)(508600001)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?UnVYd2c4STVTbHVqL2YyU3JTWHp6YnRidUtIQWV4OHByZ25XM2xLQzRyK1Y2?=
 =?gb2312?B?c0ZzZm1kRG1NRGJGSkdYemFOaTZtNGl2THJ3NXVFTG9KNUsrMXZqZzJNOTY5?=
 =?gb2312?B?UFJyS1ZjM3Q4aUpZbFZGclF5emNjbDZ0czJvUzBLaDV4SCtWVWpQc3oyc0N2?=
 =?gb2312?B?SFRmTjdiOW9QRFBXSHpXNVo0NzZWeGxMb29xdjQ5Wlo3UFc0a2dQMkNSZmtk?=
 =?gb2312?B?TzRWNEVrS0R0UkVnUmhtd2lSZmxLREpJQjRFcGRtbEpDV0g5MHF3L0FUYWFJ?=
 =?gb2312?B?RWRRb3lFVU5ncTBieEE1RFhBekJUOTBQQUtHN3hZbjVEREtRaVJwZjlTUUFj?=
 =?gb2312?B?bytXSTZwVHpCeHJkbzNac1ErZS9yNzF6S1JqYzQyMytNR1FrbmVnR0U5bkRC?=
 =?gb2312?B?T2VJMWxmM0hrUm45Ri9tN3Y0RTJwR3BiTHJnOVk1NVBRdDFObjhMVXh0UGp6?=
 =?gb2312?B?RWtJY3E2dW56R25DZWc4NmJnWVNENlE4cWtMWTFwekpSbUk3WXVWV1cwQjAz?=
 =?gb2312?B?RStkNS9hZmQ4QTB3WDlEL2pVZFROaE8vaUlYN3JpOW1FTWZTYjNLdER3WXZ3?=
 =?gb2312?B?MnpDc2h3cHlqV0dwNGRVT0tuYzcvNmtHdlRsUDFERzlIT3NSTlBnYXl5bTlt?=
 =?gb2312?B?VHJobXJjV2FOcTYvMnJQVlpETmhRbTNzZUg3TmlVdGdHczh1clY2TUZPZm9W?=
 =?gb2312?B?N29sN3JKbStqWFNwRHJwekhIR09mamJkR09iZ01MSWRKeE9jaHN4UUk4ZURk?=
 =?gb2312?B?Ri93SVI5MWZQUGc0VlViUERPdHRnR1AvR0dQbXlqZ3JMOUJRNVp1MlBBOUs1?=
 =?gb2312?B?T2NpOVViRHR0dU8yUjFMbFRzem95WmZSVHV0clZXVVZvMVhwWVhhd2w1eDRr?=
 =?gb2312?B?SG1VWi80bms1cFIyWGVqMjRIa1NCZnRBMFVRNDVlbDZFZlF0WEhseEZ3REdG?=
 =?gb2312?B?SGFsUmMzMnNubWlrQ09SOGJ0MWFIZVZZTkh2a3lmYzNKNWJyUUEyRTRoQnc4?=
 =?gb2312?B?RjY0cXJiUWd4bzhDZmYxU05KVHNzTURaOUJ2Sml5TFJGbG9SS3d3bXVaVEJN?=
 =?gb2312?B?bEVwR1laQ1NGWS9ObHFhTWpkeVZqQldocWRPT3NYNW9KdDVtVXdKOEt4c00w?=
 =?gb2312?B?Yyt0UTdHczdVMXFPMHRiS2hTNWh4cGQxTzBDcHB2TFBCSWMza2U0N1QxcVo2?=
 =?gb2312?B?MFUrc3VQTUJFUVlOVTlpZlBQUEFEWlpBMjM1R0lPWmFHd1dQbDZyNStKN0xM?=
 =?gb2312?B?bkhOamIyZVNlZ1U2bjg0NTJQM1g2ZHN3RjlkVXNqbndxa1Aydll4WXNPL0FV?=
 =?gb2312?B?SGZIVlN2SWZUWXFVSGpoUk42NUkraG5aaGdlaGY2RHArNlc0ZVN2bjVnR2tN?=
 =?gb2312?B?dE10cDMrZEtzajNiMy9wK0FkQVIxNEo5R2IrWEk4NkFUMUtTNEhrUEpLZERN?=
 =?gb2312?B?bTNRV3I5cjl0M0tSQ3BZZ3U0dGxoQW13NExUY1kyaURNbXpxNDV1dTdCZ1hY?=
 =?gb2312?B?UzNtV3ZLVHZlRjdiYUhiM0l4UVN4ZW8vbGpvYVdOc1ZNVGlIb2NRWGlSQnZQ?=
 =?gb2312?B?eWMxZ2dnNmtqZVFJNDI0VkhMRDRpcFlDWXRTTG5XTFdTNUx0aUFyWlhlcFJN?=
 =?gb2312?B?QVkyck91KytVV21zMU1tQWFiTE1SeUJhZ0xlclBPVHZpWTkyUnpHMHpXYnN6?=
 =?gb2312?B?V043VmpSZTBhSHBFRjBwc2MwWXkrbVJ3emVVZTk2c1pGOXRsM3d6N091MXAr?=
 =?gb2312?B?N29XdHZkbzdEaDY2SDMxMVZaUG5jTnZKUi9aMG9SWHpKRXdDbk4rMk5aTGtW?=
 =?gb2312?B?MkI3SGNMc01SM09TeFNQN1RoQUp1TVlTcWt4RjJHZVBrS09CSytSZFRZWmEw?=
 =?gb2312?Q?SzXvVLzQJP6wb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2174cf-cb17-4c7f-b29f-08d96c345b23
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 04:03:57.5029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBo1qLVsh7QY77ssb9uWVxtUdti6cycNxvMYohzqsPotHts9kcX6z7cKgKd8QpjOTmyq5c7u6rGpWHHmXFXeGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4623
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


On 2021-08-30 11:24 p.m., Pan, Xinhui wrote:
> [AMD Official Use Only]
>
> [AMD Official Use Only]
>
> Unreserve root BO before return otherwise next allocation got deadlock.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 85b292ed5c43..c9db7d2c5816 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -355,19 +355,18 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>                          DRM_DEBUG("Failed to allocate GEM object (%llu, %d, %llu, %d)\n",
>                                    size, initial_domain, args->in.alignment, r);
>                  }
> +
> +               if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
> +                       amdgpu_bo_unreserve(vm->root.bo);
>                  return r;
>          }
>
>          if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
> -               if (!r) {
> -                       struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
> +               struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
>
> -                       abo->parent = amdgpu_bo_ref(vm->root.bo);
> -               }
> +               abo->parent = amdgpu_bo_ref(vm->root.bo);
>                  amdgpu_bo_unreserve(vm->root.bo);
>          }
> -       if (r)
> -               return r;


The above early return seems to be needed for -ERESTARTSYS case.

Andrey


>
>          r = drm_gem_handle_create(filp, gobj, &handle);
>          /* drop reference from allocate - handle holds it now */
> --
> 2.25.1
