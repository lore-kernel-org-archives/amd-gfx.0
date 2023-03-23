Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB28C6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 13:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6DA10E9C2;
	Thu, 23 Mar 2023 13:29:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D37A110EA88
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 13:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1xLqOJl+lqNp08v1Tv7HXE36vuBhyo4muxG3Qx5gVsmPxFyPqpCgL5wLQz8t4FNSl65U9WrFo9GeAz7jHkfBToc4GjzkYAxxH9pgdU4i2p56snxykFlW98p6TNaqcaKMGsnEUPcY9ZMQdcG9BwbOdsHhSTHFXKx67WOS+nFV3qzzp8lc5IxIES/dHBfMBqLkec9yvRm9h2CZ2+vgsLMp5OJAp7U4pAjQ6WpMRu048MPH4craWHMieMdG8KC8+UBkYlwUN98LMLrHbNy6ySbsX2ZpMiqKkzJgmoYtaqAVWNd4qtYDM+PijZfZwUouXxxJrw6wGmLNkW1Xwi+QrCqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qjztAkQc0WACsjEqMyb2947fNg6AflqvLQVFSYLumI=;
 b=nlP64BbouZpZlPpfD2YUVXnxkmhrhjVySnX5AC0ndZn6/nZGUppuN65qx1BYSLNE2ah5SzHwTwjJAA7qJE9iAm8rfIHWYulDeVKZOscG99FpPO67LG1c0dKLeH9y7K6QeRHfC1AjFNDC16bnhjdUqaeT41AaUsTiFK8oVKbjYdFMPmeqCbHi6gzSrPOVfleXQBCARwXt+dlMybYwYQBWwTIBnlclNRSP6X2g35zBJMKsYg+TfVn7CVcmcVA+UvV11dmzEEU8MYkhnmO1WWHClxKchL3l9m1shzzwgJC00B0eu2iV1Qsdx/ndBfvdcHBKu+rr9kU/klQ+M5B5iFLF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qjztAkQc0WACsjEqMyb2947fNg6AflqvLQVFSYLumI=;
 b=y5UekWWCAYBe4GG7+Vpg7ZaCv51ub4hw+zFc8+ByfbHargdVNX9JgIbEHvOQ9GuUuqnTThWIcmhuE10oYK31Q83yo7dFU2/xZySgKzh8fbCqAx4iWSba8irnqVRs+sidgigqBkafx2wz1r+XDGJGxNLfoCbcZKriQVyh+UKvRL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 13:29:33 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 13:29:33 +0000
Message-ID: <98edaa70-bba0-77c9-1ece-64700a3562b6@amd.com>
Date: Thu, 23 Mar 2023 14:29:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>
References: <20230323120426.3960144-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230323120426.3960144-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f35f30-1506-4f28-6054-08db2ba2a32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/POmpRIJ2zSZcoZ1P7zrenSLts3Lh5bo5yhjE3eb7FYmQjzzrBy12CnpmQQaon3H88q5e7+hD44qPPpCi0YuDdBYgHk1RzkHxCYLlvcZRMfTjBEVrgPYmC/eHg/2FGaLwoY+ko2XE1Ub5W6xL4WTaHS0Uj+ch/lJPilnZQ8OliAuz5h0apaEk68EgCuqg4+9/gTf37KUGsjb4DzT7SNj/gswvTo1xB/ZU2J2gSULd/rVB86ADXrzmcIgOY66tGNqRDlNdSVoWuHHy5XQol4tzQJwNmxmXUI/b7wa+Bv+6k4HvlJ7g7yC/dHiM9vHReVMluG3YSyL1+Bwy6VJ6hRyd58uPMDqbtR6GX3zB6g/gcANhlbbAOJKhMeIqPZa2bo7DiyPUqVqGwmimCLwi8wApXP3xrxGVkwCgi6uLiAouXh24uU2e2Pjv2wLT1J4uQCZCYDv8ZSBAs14A/FgOBHQdmmoeqxrGNAmOJRcJMwEo9y6HJvDAGSOc69PN5lBz1R+P8abW3HhcVyLU6rpvEOgIMlPyx3+GryXbyOdPRt+/5uCwmWOHzGZfkJitHvUFFj0AFr5uXbGhGFupitI8eB+2wgyZw1hCjoqpPLp/VYBOkNWui9euUqY2jU0GXtqrVHh7NXE2mfBraQa0e40CstmdRDn1Qfh7GofvtgVPoYGfsEsQdaHJK5UlzTG0A5x2PoHlJSk08M2H+8M49v/r0Y2NBlovy7KoHfPtNjHHoBA4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(31696002)(36756003)(86362001)(38100700002)(2906002)(41300700001)(4326008)(66476007)(8676002)(5660300002)(8936002)(66556008)(2616005)(66946007)(186003)(6512007)(83380400001)(6506007)(66574015)(478600001)(6636002)(110136005)(316002)(6666004)(26005)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N291SkxkaUZtN3lpd1dqOEd2eGFRMzdmTEljdUQ3RHlLQWUxdjBaUDBZMTgy?=
 =?utf-8?B?REsxUXNDV3lZckp2Y0NMMVVZQ2xjUFpkRUVMcXhYTGlWYjgyNDlHeDRoT0lY?=
 =?utf-8?B?UmRCUlZFRGQzMnVSWkxKQmUyZTZEUnNpR3I1anNWV1M1R1JVNVpjMnB0YkxI?=
 =?utf-8?B?Rm5GQjZMeWZwMWhZSXZXdTVwdUVLTlIvYk80UkdWN1I3WXc0MW4zU2d6cWpM?=
 =?utf-8?B?STBmNXRBTjN3SXhvRjRKNUlnbHhEblRYdkxSWXh6U1NhNlU0R1ZacGVxd2dC?=
 =?utf-8?B?Q0dpdEJyMUM4ZmN3Z0FrTlVwMDB1L0s3SC9HTFJuT0hrSDErQWMxNmdDb3o5?=
 =?utf-8?B?cDk3ZlZjaTJtY2l4VlNKanJTMVN1aXBRbHVuNG40MXlDOEtuenRpcXh5eitG?=
 =?utf-8?B?VnhRUXFHYU14UHpQVnF0bUhSMURhKzZ2aVhOd1h6Q091eHlRUkVpTFJTK3hE?=
 =?utf-8?B?ejAxZEQ4SGxhZW9ESWFzUGIrN0xFTlZDQmJaeHVQYXd2cWJxZ2p6TjBKejVa?=
 =?utf-8?B?QnhzbGFWd3pWTGRVRUNDU2I5NXJaMis1KzNmeDZlQkhIcDJzdzhTVWZadU5w?=
 =?utf-8?B?WlF4RngremI3clRyYnFTQ3NXRjQzc1RIVVp2UC9KWXFWUXRTK0dWaFdGbzda?=
 =?utf-8?B?RmhGVWp6TG1Ya1VvRXBFM2IzWVk0RWpJS1BUY0tBWE13WEFQUFBac3JiVXFz?=
 =?utf-8?B?WTVpeC9ZbzZYaVZiSU1qRFZmczdjdUpXQ2dwTHJ6YmtJNzVaN0hxUDVNdmpE?=
 =?utf-8?B?NUdGOXhWRTRKSlQxZFRMMjQ5YjdyZ2Z5L2d2aUwxS3Byc0ovTUlsYVhCMDRB?=
 =?utf-8?B?Qm1kUzE2M3ZMNXVEK2ZrN0tzelY0WFpZSjN1VDhsVVFXc0Z0N0c0R01LOHAz?=
 =?utf-8?B?TWZtSnI0NW5LSFZESWRZMzF0ZDhWRXB2SSs5YTF6U2ZhbEo4bGF4emQ0alZ0?=
 =?utf-8?B?bno0bWRmV05aUDBNUXh6T3ptR0lqZUpvbDBtZ3AzUE9TZzVId0oyenB1UUFk?=
 =?utf-8?B?UU10RnBjNDZwakJlRFd0b1UxNHdlSHRneGcwWG15ZVp1TzVlQWgvanhUS2lF?=
 =?utf-8?B?VFJmR2h5bUZyeEJ3TGsybkpQZzFsalJGNVo1WWk1eTMvQkJ2dEJOWFNDZ2s4?=
 =?utf-8?B?QUhQKzBaNCtJaUJINTAzaW5aVHk5RWhZYXdQSXRRVmI5aFh2Tyt6QnR6L0Qz?=
 =?utf-8?B?eHVMUVZXZU9ycGtOVStMNUE5aDlQN21ua1hYYTBGTGhTRzhxY0g5VWlHbEd5?=
 =?utf-8?B?cVRidmQvdThtNGpWNG03cG0rbGpQM2hpRHJyQkpBZUJ5anZOMWo3RTVXZVVW?=
 =?utf-8?B?akFMa2lrWVI2K1hxVE1OYXlPeEJZaG81anhyOVNOOVFuSUZMZWNMelhpTTM4?=
 =?utf-8?B?VHlkYVB6alI0dzFqaFFad25zc3NXa3FpWFB4MHA3QmgySkozTGxucm5vVEpo?=
 =?utf-8?B?WUJkbVNxZHdXNkhIMERLQmtocFlva2dpZzN5SEhVT0tUTVI0SzFUUkk1YUNZ?=
 =?utf-8?B?UXRiR3VMMHNjd3kySmMyQm4rN254WW5Id1FCU3VqSG5DdmxYN3hrcE9LeEx1?=
 =?utf-8?B?eG5ocWxNSlB6YU1hd080cmJSRVozcVdpYWtwQU1JOHdxZzZNemtrbXp0d2dK?=
 =?utf-8?B?cVhTdjJ1NmcwM1dibXVWWklZT3ZRcTdBVVRUQ3BMOFBJMUF1TDRFNVlFOWty?=
 =?utf-8?B?SG5lWmdmc1MvNjJJRk9oLzhwbHQ2R1VGeVZYT05ZZmhJV2t4Qm1wdzUwZVU1?=
 =?utf-8?B?WTg2SUY0OXo0bCtQS0xZK0x2blU4czJSV3VnTnowdSs0RG5ueFRqMHVIalN6?=
 =?utf-8?B?TzJIdSsvQTAyL1A0dDQvK1VRaUdlSGY5K0xYbnB5dTBaR3V0NGFSNmk2bXZw?=
 =?utf-8?B?dXByTFRyZzJKS2hnY0Jpd3JaOHkrVWgrU0UxSDc0ZUFzbTZoaW8vYUxkSjhh?=
 =?utf-8?B?WUFMWWVURHJjK0JSOWZqMkFGQ1llT2JDNVg5S0MzVzNGMUZaZXJ0eUMyZC9T?=
 =?utf-8?B?L1c0bGdmVC9hUk5sQldGZXYxRmRiOVZzMWpSTGhhVGxkYjMrNVd5UGFsZDhq?=
 =?utf-8?B?UXZESzhKSWUwT2ZMV3k1ekhFWmNMSVFnK3VxSGRqRjZBMEMzaUIwcG83d0lP?=
 =?utf-8?Q?N80QbIUJxpBjqK8SYZ+byldAZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f35f30-1506-4f28-6054-08db2ba2a32a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 13:29:32.8341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7LbB9w8A3RX0YhDnHCyVFo7fHHEcdYyaydAfcIrDLZdPh2XfNqR2ZcEYsZllL71
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.03.23 um 13:04 schrieb Srinivasan Shanmugam:
> CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ras.o
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2567:28: error: bitwise or with non-zero value always evaluates to true [-Werror,-Wtautological-bitwise-compare]
>                if (adev->ras_hw_enabled | AMDGPU_RAS_BLOCK__DF)
>                    ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
>
> Presumably the author intended to test if AMDGPU_RAS_BLOCK__DF
> bit was set if ras is enabled, so that's what I'm changing the
> code to. Hopefully to do the right thing.

That looks like a nice catch to me, but I don't really know the ras code 
that well.

Hawking, Luben or whoever is more familiar with that should probably 
comment as well.

Christian.

>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5b17790218811..fac45f98145d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2564,7 +2564,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>   			adev->nbio.ras = &nbio_v7_4_ras;
>   		break;
>   	case IP_VERSION(4, 3, 0):
> -		if (adev->ras_hw_enabled | AMDGPU_RAS_BLOCK__DF)
> +		if (adev->ras_hw_enabled & AMDGPU_RAS_BLOCK__DF)
>   			/* unlike other generation of nbio ras,
>   			 * nbio v4_3 only support fatal error interrupt
>   			 * to inform software that DF is freezed due to

