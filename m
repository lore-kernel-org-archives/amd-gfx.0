Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B1EC05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 11:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5738610E375;
	Mon,  6 Feb 2023 11:19:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF0610E372
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 11:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ru/tiUTkh3v+Ngf3yXfgInbDGsfm/PE4sfHij061UzHSVEMh0pS1sXTYN3FpIB1ohhaBYrhcyVKTe3u2ZBX47AjqpMjIQeBVPChih50Y5XUNNb9Blef7xTYMGqV0wHNT4hLTD0PbleKdHZm/AwA775Jw4owrUomKGPFZluQ6Z1T05BmtHvHC1I8t1ANjPI1FDVs+3rO6sEAsl1G88xpDGgbk4J1TFgnuK+Wooo2IXbuQJ3y4uBl/XWlz7s3LpP51g4ds0JZSxzKWMFDhe9+63zPp/BF2Yfi+JDCLB0V8l/RTX03/da+7wFqQwUKyJpRN0Vqsai0MP/yFfaus1ZC9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8NSe9KOwSx1h0WddCqWdL8XR/fNUrMatjxi3px4U/U=;
 b=kxlQfwTAKk//o3u81CTox5cQuA5GMeqvO/O4VkK55mUIoXMyQLeIAO7noo3LHzswCcyyqmns1ZVc2XoZPLf8D9GykQhr8hLOGxqQdG4hnTQhaZs1+JFYMaNGViQkFJu3ZPao9imMZk3qzdrxZWcf8/IIY02qqphC0taDdoOQQ0OHbqcZD3nGD8Q7rzBTJHalMWiDJb/r+zvlYKsZEWc2iXZ1N+hTftdAtr9mG8nuMjZDurVUnfqkfuBL40fuPGE2pRjoGfgr2R1OlnYgVJKuWkydb2dS5+WNOXUbWI0eLu4niAFFbBsQekfKrdlg8NvKJB4Ks7FWagk97gg30C/gBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8NSe9KOwSx1h0WddCqWdL8XR/fNUrMatjxi3px4U/U=;
 b=fZMloFy6gO6ANFUMNCS4sLuVCnmQ/lCYXxLWWFdZNsEjv9kN6uoKbkEN0iBoxxh2zTNjoxC8qzeqNoj8C8TZl01yxZ5BEu/hDVy/+u01/tcncNepHN/q74SscIPPyp0Pz+lauL9XL4KT/oeDiXiRCOB+qekQUV15TywcddYkktQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Mon, 6 Feb 2023 11:19:39 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 11:19:39 +0000
Message-ID: <d494db26-ab52-d21a-7ca9-d07fed34397a@amd.com>
Date: Mon, 6 Feb 2023 12:19:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/13] drm/amdgpu: add UAPI for allocating doorbell memory
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-2-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203190836.1987-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 720e122c-9aac-437f-d2d4-08db0834091e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKkJLCwkWnE2lMw6gaGmqbsfByqCLxFIf98v21QRY9gKJvwE2qRgtkLTLA9Tl1du6bMLKtM7/Pk4WT03zmXvxwprb55DTGp2APMf80c8Mi/Ct2Cbe6Sgju8eyQTV8tjoZNEi/7fG00DJgQnFIwN3e9ymksDgZPf5iZom/lhPDe8dCfIAADy3ZSViDJM/BCZCsJMP3Drq5nANgzkIzD7daEtm8647H5la8rZw99uGHuU31KBY/6pPHNqtdwbH4T8wen0aK8n1s8XxRF452MmMv/TOQoZFOAFHwHjau7oi5C84uS72AXQv3n2eUyZrTM8bEt9vPXmT9X1JW12XkH634Y55kbfDuFyNX/PEIpfqcZQHgZuTbsFlKeSI4xSNxChjSsy2uUuNifmkA0cKvBT0JYcj/0BSrGiZkY3CYCj4DcWnvgD/qYLm+hsMi9Gl2NG7Nz90jEN+lEZjLUyo3EmDZRQkhuW2oto35bxN48iK8GERXU//6tmfFvVLQ/4s6PRTPbo/rgdjLk0q16puf1mmF23wkfB5wg+zWe25XBpzvdRMg00BW1n96BCkqR9yW4+pLP4N7XJC5o35VhxhUOjrg5W7OinC2VZLoHPDKAZbuJ43UYu5Lf5q1AbnzllYYM/Vxj9mEPTUklSiejaDhSwZCum4uYiCOeNpZF1QtmWias+uLkbwzPw1R9DFgpPbbXpryDjP6ZaHSRiOiJPgyp+fSbS6eQq5p3MOg0kJwDiMjeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199018)(36756003)(316002)(6666004)(6506007)(8676002)(6486002)(5660300002)(66476007)(66556008)(2906002)(66946007)(41300700001)(4326008)(8936002)(26005)(6512007)(31696002)(38100700002)(86362001)(478600001)(83380400001)(186003)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dytQUGQzOXNEMXUzWVYzK0RFQ2UvU2pqYW1NMlRwREpaVFpRcEt6OWV5UjRn?=
 =?utf-8?B?SCtwenphVk1jekp2UU5FSGx2bEtsYkVhdDgvbml2aVo2YTNHUjdoVnpiWXZW?=
 =?utf-8?B?QVZ3MGdoL1IyRWlaNXlBcXh3cTJjUWFGMUJEU2RWV3FzTHkyczN2UUdsbE82?=
 =?utf-8?B?akZRNUFVckZJd1MrVUpNNlZzdjAyelF2UG1odVlZei9FL0Y0TmNtZE5TNmxU?=
 =?utf-8?B?L2Z4NEp6V3F1V0l1M1hQc2JRNVBzejdOcTVpV0pQRi9uZmgxNFZwN0ozVEcy?=
 =?utf-8?B?MWxvM2thT0t4RWt6UnQ2ZWVkL0MwLzR6R3ZITzdQZEhla0RWVFBicUNaVkpo?=
 =?utf-8?B?V2pZUS9vRTE1d05tMDBkQ1d2TVlYYS9LTTNseVNicXdzdDNKU0Z4NHZrOC8z?=
 =?utf-8?B?UU8wZWhuMGV6Zk4wSTRsZG42cWd3Umh4ejU5RXo5Rng3OTFwUW9ncWdRQU5H?=
 =?utf-8?B?Zm5sUjFHdTM1UFBwdDRZeVR3eEZFa2g5TUtuZzNXUWlnNm9FSHFYcEhtYmVW?=
 =?utf-8?B?VzZhdXE0cXlucEdnMnVJVTRMQlZxekdEbUdkaVVqeHBjMDJBbFVLdzdkd05Z?=
 =?utf-8?B?cWdBY3ZUR1Qva3MrejJaaXNTWW9tZ3ZKaVNHZ3p1Q05kNmxkcjIrLzcrdmJv?=
 =?utf-8?B?aGViblFocEQ3S0kyY2JRcXJzMFZwVVNjb2JuSG9Qd1k5TG1URzkwNlRGSkUy?=
 =?utf-8?B?MDY3a3duVWRKTXIwYjFmM1pRcDd4UXRxaEsvU0hRdWVmQ1BXUjdKbWdlc2VG?=
 =?utf-8?B?bTd2RnEzOWc3anBJOVZ0S2s5c1JqeTJHVERwdzVhWmNrL0R2RnpsQlhQSU1t?=
 =?utf-8?B?WEtSd3FQOUVYTUZLNUlWNkRqVmpiQlUvZ3p4aS82MXFNemZTeGRJem4yejll?=
 =?utf-8?B?WVpLSTdzTTdudkVJUU1rRVJ5LzVXc2JRbGNkWitFQWtDQk9TblNJcGJBV1BT?=
 =?utf-8?B?MEN4VUUxV0JoV2Z6cjZEVmdkS0RZMSs3ZnFxcmxtaEpGQ01hNFl6TllReXNC?=
 =?utf-8?B?eWRhWEJJR3UyVXJ2NmdGNEt2RUxnMWV6bkY2T0E1NkhSYlBWckFRaXE0OWVZ?=
 =?utf-8?B?d1BYdEUySmZMdGJRWU1ld3I0UU1id0JVK3ZLbmd3WXZkQXJ0MnhnR2djc1ZW?=
 =?utf-8?B?Vm40ZDdDdlF1TlNHZ0ZLOXh0OHpqMVVnaGVGY1A2TFdzWWw0T005dmZDSmMz?=
 =?utf-8?B?Ump3Uk9SaGZGWXo4dm44L09WQzZYT1FsTUovdW5wR0FlakpwVm1lQWF3YUJU?=
 =?utf-8?B?OVA2elNiaWJKU2pJL1lCcDgrQ0x4Y0RCWVJnVm9USlRyUitDZkgyVkkrTUwy?=
 =?utf-8?B?RXdjSldyMitLa3IrTHNoSHI4cHFNY2tqWkNRSEREcHJRWEJMV1p6UGhxaUd3?=
 =?utf-8?B?ZWFBS1E3ZmJ0QzliZWNBSFZoQ1FlQ3FTUWFySHVReFRLOW52VWsvYmxSbjZS?=
 =?utf-8?B?dTB5SEVTRExiV0RoczZtNmJvMThwTFpXMWREeG9xSkc4VDdGNGhiUGNnbjk2?=
 =?utf-8?B?TnV0VVVlQnExdThLRzMwS0p0R2xicnBObnIrNTN3aUtyM2FZYnFxLzl2dUhs?=
 =?utf-8?B?aXNUYVR0RDcrWUs3S09ZVllSWFdBUXBVL0owUXd3NVdnd1JFWVU4REhGZ3M5?=
 =?utf-8?B?RHZMSnBaSGpwT3p5NkdnS1hpSk5nbzRVVGVtMnh0V3NhRnVzb3hSamhLS0tZ?=
 =?utf-8?B?cG5WaUFqVzk1Uy9KUFJIRnd2cHpRZ0h4S3NHZTd2NW1mRVRKVWh5OEtDM1J1?=
 =?utf-8?B?NHJuSFJ0NW5uWGFJQlgycnRwck1XMSthQ09xd3JHVFhTeW9XOVoyamJEK0hw?=
 =?utf-8?B?MHo1QkNNMFpibVR3WENmWFFkV3RFYUIydjVoZ003cC85M3pwN1NLbE1EU3Vx?=
 =?utf-8?B?a2g4b2thU0RNUUQxZUFQOURzb3NqVXMzRTVLSXlNVjU1WE1lYm5qSTlaL3BB?=
 =?utf-8?B?azNNZnNQaW1zaWUyREtUc0dJMGlZMkN3anJzZXBtQkNIOXNBWHR0QnJ3UHRa?=
 =?utf-8?B?dlc5eWVGd0t6WXlhaGdweHg3d1BLc2dpSTFsaldDSmJtOVJyNU5BNWxtcnJl?=
 =?utf-8?B?bjY5NDk4VU1kZFpjR0ZVK1ZubHY5WStKT3V4cFd5OUdrbU1XZnE3U3B2cXJi?=
 =?utf-8?Q?Z42HlkcNzojrhI7GFqnVbH78W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720e122c-9aac-437f-d2d4-08db0834091e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 11:19:38.9737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGQb6uEBYUATAVNq1Qr+gwS1PdQebk5MpitRYYQQly6XccmWMx6KsarE7xN8sGA4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.02.23 um 20:08 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 4038abe8505a..fd1c65d78ded 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -94,6 +94,9 @@ extern "C" {
>    *
>    * %AMDGPU_GEM_DOMAIN_OA	Ordered append, used by 3D or Compute engines
>    * for appending data.
> + *
> + * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell memory. It is an MMIO region for
> + * signalling user mode queues.

Drop "memory" from the sentence. The key point of doorbells is that they 
are *not* memory :)

Apart from that looks good to me,
Christian.

>    */
>   #define AMDGPU_GEM_DOMAIN_CPU		0x1
>   #define AMDGPU_GEM_DOMAIN_GTT		0x2
> @@ -101,12 +104,14 @@ extern "C" {
>   #define AMDGPU_GEM_DOMAIN_GDS		0x8
>   #define AMDGPU_GEM_DOMAIN_GWS		0x10
>   #define AMDGPU_GEM_DOMAIN_OA		0x20
> +#define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
>   #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
>   					 AMDGPU_GEM_DOMAIN_GTT | \
>   					 AMDGPU_GEM_DOMAIN_VRAM | \
>   					 AMDGPU_GEM_DOMAIN_GDS | \
>   					 AMDGPU_GEM_DOMAIN_GWS | \
> -					 AMDGPU_GEM_DOMAIN_OA)
> +					 AMDGPU_GEM_DOMAIN_OA | \
> +					 AMDGPU_GEM_DOMAIN_DOORBELL)
>   
>   /* Flag that CPU access will be required for the case of VRAM domain */
>   #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)

