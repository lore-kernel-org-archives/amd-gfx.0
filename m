Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D852C5479A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 19:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D22910E2E9;
	Thu, 17 Aug 2023 19:54:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8835010E0B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 19:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmYHuxCUetRpbzSJGGq8249ZQRlaT+7JkiDSTw51yli2V/ybxcX99HZoniprzQG7hymaCNH0yOcqTjGe5ZArjaLGCmpINhyXx2hnPDZY95bGSiAb6TbxHxZEKSQwqQLPg+PgdcsPOQVq4dk+r7BGRRkSn9tGF1HigppAQD/p2Vnf5fX8Ckv2ccm99jTd2e6WQpk95NQtuYO9PTQedZ7S9O66vx578hKeRAiCKtLfjuF2EZlLqmUxdwS1O/gxaGQgYa9Zt2Vso+u9+iEhtuCVTXJWSmTSUFT3jPy/C+wCtryDumPRz+Iq2eye+0Qabz33DveAYqn2wVnItj2YQ2CpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXS5IXMqQDvB9bfowue1oS3nPGvq/VR/wLHUP86vZW0=;
 b=QWgfn+qLAsk0O5M/afRkDtizN5vp6VYMtI+ZDBiutmO1r3ROpt04TaIqs8v1F1BC8VPAsgS5RWn/thbg5KeLUkco0mFT0xHJ++2U4LdogKbHUa98eAxdZ77QXEon3mvEj9bm52pQ8VP336lpo8E/Ce1vW8Mb/t7J+snXrA29LjZtUSWAzyHdMuLDRpQ2L46ea/BF9NekdCjDHdfuAF6ETEi1AIZFdEEQx0hGDnqAiRMfCpBIOcbsm7hnrDyRJPBjZKjJUp9RZg41m7ZyaSqKeblKEq4yhWqKVyPup4gvpjKsOYsxFySOqB8HoNq9ykLSSGL3dgwyfYmMVYTHVKQaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXS5IXMqQDvB9bfowue1oS3nPGvq/VR/wLHUP86vZW0=;
 b=vquD0DDmVpEPineTrAfRCcfgf8p7g+lNUtZrP+C9HPf6oxkEzw87yFpKU2+2t3t7Br2TU4807T166JXc7zh0H6DzEJ6ayx/jd/VGqpfuaIHnI/yBU7b6Scmy4EKvQuVm0MiHCQnOn0SWPCjbYI7qqqUZcOTTMxpWD0KVTy32deo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 19:54:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 19:54:45 +0000
Message-ID: <3d43f411-1708-0f3e-57aa-0f2ec6143ed1@amd.com>
Date: Thu, 17 Aug 2023 15:54:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: retry after EBUSY is returned from
 hmm_ranges_get_pages
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230816184450.11165-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230816184450.11165-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 9024e698-9683-4f25-d0c8-08db9f5bce05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPKj6gxBO73+RK0120XWoKgABe+GAkhV8dvH1+oG/yZSyLyAv1G6zNDnSjABG4D1IMy/gBa0fwQZQUiJsRKnB0NJZuttRBp9fcp+nG2JTybfQ4oOElNuvx3fE2J/eunrbyh7jE2GPxyI/0hmDbJwGFy/5dx8MLVb7NqcGqI/Ry1J2VcTjbnV5/ADs0VsVEGK/sO3gasmjp0ARjOJJpDc7YvYkndHkzzZ8aV+0L6SQpDv5PUG8/XF+9MTfEcdow9HYyLHsxgU5GWtChG7zN61F4VOfQ1pUSiu+ioYC8T7oKD5Q4Yjhvf1zoxh5FWuzPOpC921KQ/7pSRZUKSw9k7faepV/4J1agtk5A31Lydn7u3yj/iEn1jrmYvvmb25y7NDIwo1b3QETxOalbZDELTVuagoIB2lepJgN9HP71Ltq38hYL/ob3UA/NHD7ps2Pz8As60mFw6iJafCApgbdf6JXFvkBD2eZ9FZ0xmYBhuS8VH/Aj2repd65wizTpaa37fiPubDwSvj53A+Iz8Bg+ucUmuTDlJXak7YYHDQwWv3GyzkJsUsv375mQMtiUX53vOOfd50FbPSmMQ3vDrJTpJhWHoscJR8vzRF+sUbokMq+hb7QU6XreNz82gxaB3GUI+HmcepzS+A0CJIwMR9L9BB3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(4744005)(26005)(86362001)(478600001)(6506007)(36916002)(2616005)(6486002)(36756003)(6512007)(53546011)(44832011)(5660300002)(41300700001)(316002)(66476007)(66946007)(66556008)(31686004)(4326008)(8676002)(8936002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjVqbmVaZGlIa2xvc1RtbTZMaklVRUFDUmpiZHBidTlqYlVSZDhYSVBJK25x?=
 =?utf-8?B?dmN6bzgzRllxa3J2V3RyLzdRc2ovY082T0ZEMlNoVFNwNUxtK21vZUpoNzMz?=
 =?utf-8?B?U0xuMTRlOFliZE02U0V4NTZwaTdDYWNMZ0ZSNFJ0TXlpczgyVjhLRERZR1Jo?=
 =?utf-8?B?SWN4SUdpMnA5RGx6Zy9HVFllUklDVlQ3NmcrUEhPM0ViU0JDSkI2Ny9abk91?=
 =?utf-8?B?UGl2Ukg0RFd0VnkvY2VnRXJjL2wwSWJ5WTZzaHdwUmowWHdGemFqcTNsWTVJ?=
 =?utf-8?B?OXZTOStaZ3dwRngzdHJGU2VaTGl6VUNmLzIyZGVjNng3cU12RUZxUXJlTUhQ?=
 =?utf-8?B?VGNyU2NwKzcxTE1tQ2ZPYllXK1V3NEtCZDM1TCt2UHJ6bnZVa1FWaWd0bFJu?=
 =?utf-8?B?NlhEWSt0M2ZrMWJWMUpnVGZiTzRlMmpyR2xKbmh0ZkdnSjdVdEtPVGtUQ2pr?=
 =?utf-8?B?d3dnSlM4RzRrcjVEYzhXSDFEVEZ4a0VFaHM4aGlCdlNGTHVSU1ZtR01QTFRH?=
 =?utf-8?B?UENJaVllQkJHVG9uTVZvS3U3bk9OUU1RQnZvelQyTTBFU3lZb1hlenlmOUVY?=
 =?utf-8?B?QStLVy9CUWoyMlNkNi9qUlBDSGFLODhLOStScVhzVG9PcmRFZWluN1RDQlJu?=
 =?utf-8?B?dTZTTEFUK1dmbHMxcWZqRjBXRnFKZWJyWG1QQWxCQWJTR1RPVTd2WWVwU0Ft?=
 =?utf-8?B?N0J3OWI3UjdkR293em5HN241ak5LUWRKOFk5MUpGamFoTGVzeDNkR3ZBeEI4?=
 =?utf-8?B?WkpOY3pPKzR3MFhiU0dEUURaMERROW02b3lxNjJFOHNBM3BrNXFqYmVBYlVz?=
 =?utf-8?B?N25pN2xMTDNVNnBjMFRUVzN1Z3VBdVpOMkhDdzRuWkM2UUdVNzF0S1lzNjJ6?=
 =?utf-8?B?M3JXeUgvK2IyeURWejN2aUxKWVFURHRnVVZFa2RpSy84SFhwVFhqcFhYV1E1?=
 =?utf-8?B?MWgzUWhRekpHaTYyU2NBZzVBMm5NZUFmbVBzckZFWHRxemxiWm1YL0NDZm9o?=
 =?utf-8?B?TVRRTlpNZ2hhT09WK2VWMkRtdExxSVpXcGsvcmd1cTAxejh2c0ZXKysvaVdY?=
 =?utf-8?B?QmI0SXhTeTBxaE5ZS2s5SnNzUFA2UU1PVERKSDc5eGNJK1FYNWNacmc3Z3dO?=
 =?utf-8?B?Nm9pUjExdXRyOVpQTCsyS0ZoWFRidEpmd1VnRFVSeEEvalh6bEdKTXdUcjRQ?=
 =?utf-8?B?enI5MVQ2RWVrS01PZW5ZaXN3NTJ3V2dGR01hV1dUdk1IczdiYXpwSGY3ZXBp?=
 =?utf-8?B?NDM1T2pKM2ViV1BZYWdISllqdTNCeFljL2tMWmFhLzViRVNFOTJuYVJrV3pW?=
 =?utf-8?B?eWd4VHhWc2Z0SkV4T0ttNVQvYm9VTEY5QjFVd2pMSGNoSHZFb2FuV2hjWWZH?=
 =?utf-8?B?amE2RXhESkhrN0xGNVFPc0Z2WElFalJuNnUxNzZZS1c2UnV4TFpJSW9YSDh1?=
 =?utf-8?B?STV4UUZyK2d4MmVxOGlPN3dNUTlZbWRobVE2dVU1UVIxT0UrYm5lS29uRzRS?=
 =?utf-8?B?cE9OdTJLajdNSU1CdHJkVys3ZEhCVS91V0VuR2x4MnZhOHh2elpnMmxPditO?=
 =?utf-8?B?dERtenVzalBMaFZIZFVSM3FNeVVKQjk2ZktraUkvY0FqZDdabm5xaG40ZVY1?=
 =?utf-8?B?ZkRwL3luT2E4NlVlTU1uZExoTmhIQ00zdE5VOGN0WTZ4VmhHWTFLUnFPMzJN?=
 =?utf-8?B?eWkrSy8rUHR0czFhYTBmVE9YL3diVWY4UElWM2dUSkYva2d6Rlk0bGEzQzRa?=
 =?utf-8?B?dFE5MldZTFU0d2pWL1d5STl6TVMzZk9uSDRmSmUyTU9Rb3ZPS1licGdMbngy?=
 =?utf-8?B?ek9ZRXlsOVJtUW1EK0RpS21YTEl2OWZUQTkxcnlTNWhyeFh1SEZDL1dqQm5O?=
 =?utf-8?B?VGVYVzZEZWN6Wk5kdlpUWTUwZEUzOHhCeEt2c2tZQUg5ODIxR3FZNXkvMUN5?=
 =?utf-8?B?TmFCQ0xGcGxvRWJHOFpkYm9POThWc2cyeXhHc0VJYVd1NzZtcXlvQllROUZ2?=
 =?utf-8?B?Wnh6TFQ0VWh4VUZHTVJxL2NHRjhQclpsWmVzd1VWTDc3QkRLTUU3bUZXMXY0?=
 =?utf-8?B?c2hMYkJ1NUk5bk5aMDFBeXcwQVp5QTdoc0p2Q1BUUTRhMFBKQ3ZCaXFoV2dF?=
 =?utf-8?Q?2gl9aEQcUK87hABh8aX0pQGeT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9024e698-9683-4f25-d0c8-08db9f5bce05
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 19:54:45.2149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPg3WZ+3XUyNjI1+XDMqeaoPBx29/UKHjtmXbU69CLjy+55W4QhrJZou7kRnUe/6HXieHuBCKFj1FJZsU+DsDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
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
Cc: aristotelis.kollias@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-16 14:44, Alex Sierra wrote:
> if hmm_range_get_pages returns EBUSY error during
> svm_range_validate_and_map, within the context of a page fault
> interrupt. This should retry through svm_range_restore_pages
> callback. Therefore we treat this as EAGAIN error instead, and defer
> it to restore pages fallback.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 93609ea42163..3ebd5d99f39e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1685,6 +1685,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		WRITE_ONCE(p->svms.faulting_task, NULL);
>   		if (r) {
>   			pr_debug("failed %d to get svm range pages\n", r);
> +			if (r == -EBUSY)
> +				r = -EAGAIN;
>   			goto unreserve_out;
>   		}
>   
