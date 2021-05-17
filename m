Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C9C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 06:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F3660C40
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 06:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F3660C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3EC66E8CB;
	Mon, 17 May 2021 06:41:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF02D6E8CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 06:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ2kWpZzGfoJKztAzOgKVBJjND99P9w22gtFNRZqH7TKXkXpeB9ceY8DnHOvNziyuYo7Zn3WErnxilKePBF2FYaesJsD4igmBKs4max5WULfK+Ukvu7/dRDaUNyaIjjeZUM+yVjcsWFrRpzR49LCjnUaKQHgXN17JnfkCCQBtK/yFIh3rLvU+y4HkUY2mLAQPsv9f0HNpuO/L/qp9HNQ9uX9dIGu44q6iEibXeSFNCglrCOopsKZwN3HJk9C5Yj95dEEBIC0JFMIgGFaj+dodVxZfpEitUyWughQvoHlUWAmXOovhZYKpm7Zq9QcRsCY+x04gEG5yqhfDyCD+nFjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUbNAmc2VQu/mrSBIb74eSjsIemhrmBEs3Eg2VIJPNQ=;
 b=MTvQ4FfEjM8LTM15QF65mX4Go73WVBLXNcj3KDiziBF7c6m8i5J1GFjfVujPrZG346qy8EbvkGNM2d2yMrRDTWuXX15nAisLua+BnFxAcZKjS/8ILuI64bvqsT0M+5SMV/OvDIcCgfmi6tDJy9V49ZHxHkxwqkqwooRxaDL1t2XW22YSLwSpJgXEtvD+HozNWfKQsx4t4lWJkqEJavp8uagfcNpB3Un3LAlv+Z7mRtsHR4sVcOzYTlDYYEn5ZghQoFFhAK8pruws4oTmKyCsBNLhAP9gSczDCMRtslvW0toZ6v0SKvt6QtogCZfKRp3d7QqTUQtfCC2tT+NoCwO8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUbNAmc2VQu/mrSBIb74eSjsIemhrmBEs3Eg2VIJPNQ=;
 b=2yxtChelniIVKUxYP5q/yCdZKwY7ZuVnjl/n0lFKHtpfdiQVLJo5KU8QoZV695F6WZfRFLBWOFqNeCKmAdy3YPMAxpX00Z/tGu//a1lMXJgdsDjJ5EHrCCSR8AyWvhfk2U4m7VrI4dfGpIR8vNAEOsFplSHM2lLfMOHq7YlRb5A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2546.namprd12.prod.outlook.com (2603:10b6:207:3f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 06:41:47 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 06:41:47 +0000
Subject: Re: [PATCH] drm/amdgpu: optimize to drop preamble IB for old GPUs
To: Jiansong Chen <Jiansong.Chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210517043940.99603-1-Jiansong.Chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bc81cba1-b338-3ef3-c488-178768d14637@amd.com>
Date: Mon, 17 May 2021 08:41:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210517043940.99603-1-Jiansong.Chen@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:6bbe:b48c:2de1:422d]
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:6bbe:b48c:2de1:422d]
 (2a02:908:1252:fb60:6bbe:b48c:2de1:422d) by
 FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.11 via Frontend Transport; Mon, 17 May 2021 06:41:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fc12977-1fff-4320-b0d6-08d918fed804
X-MS-TrafficTypeDiagnostic: BL0PR12MB2546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25461E6000B4E758484DEB92832D9@BL0PR12MB2546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8BJ0goT9OQ6k7JRFxg0ioclt4KcoL9o3PQT5RLhwGm43chSF6OtxATMiEgIgh1PG3iqQejLn/nPakHHQvWh/bUyOHjKHgHQW7zzFP+Z5w0Ni/VJ+kEbJVhKPsEg2z4+wGgl++5V3gLpt+WHsVRhVJSP33gxAhs4HZ9T/vA1sKw07ZsiD2PO5IF4eALno3OviZ241h4XEYP/XNFayb2L1/WW5tSeH/q5MOCnw8Cp1EIDsPQo2ZS4sNbwUEu/njPE+UUClXHuLf8rZf5bqN2jl++bV747ceURj4en8ErlP4m8q2gEnuX6pUMwAWgX1pq9ry3Rn2b23LtDCXoBYoMLDLkIr0Cf9G2AVieqy2jw5XgIwfj+YoF9GAaHrxswTCUyvrnbtfYyRYrcwQT/yssGkg+NPpdrdPFJh/GLyoIfN/gARRX4x8/0y+bQVP8zhToFXjtxb3koK9aapyMmIleFkt1wrGEH4Hpi2xZzgVFQMXtSO7mXi63cyE3lnJtV3Uo15nLRJhqIM2x6+cjkcO4nOstlHKqthLdIZbT2LMV2VcTvMwLR8qDSZu9FnRp0PkZagVFXg/BmtMUVWI8enuQsQQyBtHYVlvNJtDX5tpiKhSdb8rPkjQTlVzytDSguIDWmbPDE/P7SRzaQcG7hBVH/Hn2K8Iw1tL/w//wFX3//oxgGd3wIdv+BRnLdtWXl8ySq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(16526019)(5660300002)(38100700002)(186003)(316002)(31696002)(8676002)(8936002)(478600001)(52116002)(2906002)(66476007)(31686004)(86362001)(6666004)(6486002)(83380400001)(66946007)(36756003)(66556008)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MUNZbHBuaGk0YWxsN2E3UER1THlxRWpzU280ckNSWEx3WHpSbTU1VHdQTlpT?=
 =?utf-8?B?NEJ2QmZsL2NGbHlLVWtTSEJXckU5eGVPaDF3WndHYURwSUxlOVVvUkVrTmdX?=
 =?utf-8?B?UkVnTkorTDIxVmo0VjU4c3l0L3M1L1VjSHN2NDVJcE5VMUtzY0RUeU00QUx2?=
 =?utf-8?B?WjFqRjNuVmkzUHM0bW8yTXZINEU3Nmt5R245cjF2czFhcVZXcmgybnZTMzdZ?=
 =?utf-8?B?ZlpuZjlrNnZUT1dhZlNtL1U4VFNpajZQZnIvU3RFMGlDd3YwZGZNRmpHTWtD?=
 =?utf-8?B?REN5VHFRSHkvOGJ6SWJaQzlKVjQxcjc2RjJNVCtUbWpIL1hENmdQcGtJa1U5?=
 =?utf-8?B?c1AyK2lGbmtQN1doTTVIR0F6bmJYK3RqVjg2Q3hsb2dpR0tTUWhrNzZ4Q3VY?=
 =?utf-8?B?b2oveHRYUEdHTEZZTEt2ZDVOSlBoZWtFQVRPOXkwMndlbXlueXVZUnA0VmRX?=
 =?utf-8?B?d3BUNWJlYzVoNDVlMC9UVmR4SzIvbnlsK1c2Tm5mUDRFMzVaMkhPcmM5UWdD?=
 =?utf-8?B?UVRUSTFBY3pjNk90eC9BY3cvOFVvRmF2V0IxdjFZbldCaFBrWFc5S2J6RmFu?=
 =?utf-8?B?Yyt4NlllSi83SDRXaFlZeEhwV3hCMVlCS1p3WXBndTlSYy9oUnUrRXlwZmMv?=
 =?utf-8?B?ZDJLTlpZc3c0SmRIeklqNUtvRWhBbVAvMTNJRDI3V01FejA5dmY5a245QnRL?=
 =?utf-8?B?QzhzQmdsa1ZJTkFyNDgwZG1sSUtNTjhtSVFaSlVGU2lkSVAwTHM0RVk4YWFY?=
 =?utf-8?B?N0J2dXl4UkhZVWQ5aVNFZWJCUlZkaC9hRFVxWU53clJ3K05LeHduMFJtYVdv?=
 =?utf-8?B?MnduSXEyNzFRQkN0SkxSbXlWa3ovYTFSNkxKQkxWTXNsc25HMDQvZUpWQ09G?=
 =?utf-8?B?blQ4dGtJVjcrcGVWc3FPeERvNDRTS2FiLzAwUWxieWN1QXpJb1pERmpxUlRF?=
 =?utf-8?B?dE5UOWZya1N3eER5NDN2VFpYVncwNnZ0MDY1TThKSlQ5aCtsVkx3MHBEN2tX?=
 =?utf-8?B?ZVRhQ2x5NWZqYXhEdnJjOUhTL2lRL0tHSVBIcDNwa21FZEFGcWtBbW5McU5m?=
 =?utf-8?B?QTl3VVBabU9yalN4bjhKZlliZ0JVbnc4Tmd1YjhxbmtCNTBDOGhBV2JmRHNQ?=
 =?utf-8?B?UXVYbjFqakZTNWtPUTZ6blhqRjlaN29jeWIzZEI3bGhPdEJ6ZjVQSkYrNG9z?=
 =?utf-8?B?bGtueTFFNUplMDNQaDVjR2Z3VG41Zml2QnFEd1ptMWhMajVaMFEyS0VEMlc3?=
 =?utf-8?B?MzFzeWpubE1naGRWS0c1b3dTN3BMdDNTY0lJbm9aeHZHT0hmd290QjZUZTV0?=
 =?utf-8?B?VlVwcGNMbkRlZS9rcXZzRjBUR0VDbnowb1ovUkxSOE9PdkNlTU9rT1V2VDFB?=
 =?utf-8?B?Z000N1lwTnFZZS9MdG1NcFBreEkrbHc5L2c0VHBSQ2h0bVd2SXJtV3RoL2dC?=
 =?utf-8?B?clNZNG1qcjJFNWgycnF0ak93bXFjempoVGFWL3Q2WXA4N1RZbStQdnFsR25V?=
 =?utf-8?B?c3JqM3VXOFdnOTRtWkRURmxTOGszdC84RXpNUGtrVDZRVllCVVhCcndBUnN1?=
 =?utf-8?B?MFF6ZHhkaWd1RlVVR0xzQkM0dFlIcnNtaVhvVCtpQm9VOW5kdzZJM2dpMGlN?=
 =?utf-8?B?ZE1GK216amR5dldWenRYby9BVVloTTV2VVlFTHdoM3Q4V1ZzQlRvcGtIaXVE?=
 =?utf-8?B?LzYrbWdHSktFa0RyR0tDSzNicGxpZ2JCVnhFSVVhdm9tWFVZdlVjdUtuSnZH?=
 =?utf-8?B?cUtRZ3BuQzlDd1U2QzFmT2QvajBGc0U2a0xsbU10dUxnb2MzZVdYZW91b01p?=
 =?utf-8?B?UWo0YWxzTWF6SHhIRFpQT0ovOWZhYjdFWDR4R25jZ05iaDdTZmlUTjFhcEI3?=
 =?utf-8?Q?FrylEoN8+Wot8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc12977-1fff-4320-b0d6-08d918fed804
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 06:41:47.5950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FWSmiYkMr2X+OwU5Dzu+ueO7PeLkBAN7b4C77QGbU5DqzwUIt/RvaMHagi1oGk6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2546
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well NAK, as discussed checking the global flag is more flexible since 
it will still enable the preamble drop when gfxoff is disabled.

Christian.

Am 17.05.21 um 06:39 schrieb Jiansong Chen:
> The optimization is safe for old GPUs and can help performance.
>
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: Id3b1250f1fe46dddbe8498894fb97e9753b7cafe
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 3a8d52a54873..c915cc439484 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1873,6 +1873,12 @@ static void gfx_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
>   		amdgpu_ring_write(ring, 0);
>   	}
>   
> +	/* drop the CE preamble IB for the same context */
> +	if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> +	    !(flags & AMDGPU_HAVE_CTX_SWITCH) &&
> +	    !(flags & AMDGPU_PREAMBLE_IB_PRESENT_FIRST))
> +		return;
> +
>   	if (ib->flags & AMDGPU_IB_FLAG_CE)
>   		header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
>   	else
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index c35fdd2ef2d4..6d9ccae48024 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2269,6 +2269,12 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>   		amdgpu_ring_write(ring, 0);
>   	}
>   
> +	/* drop the CE preamble IB for the same context */
> +	if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> +	    !(flags & AMDGPU_HAVE_CTX_SWITCH) &&
> +	    !(flags & AMDGPU_PREAMBLE_IB_PRESENT_FIRST))
> +		return;
> +
>   	if (ib->flags & AMDGPU_IB_FLAG_CE)
>   		header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
>   	else

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
