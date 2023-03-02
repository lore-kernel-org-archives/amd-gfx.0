Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14790C678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 00:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF8D10E0A2;
	Thu,  2 Mar 2023 00:22:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7F810E0A2
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 00:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0oRKOHnh60i05u7bY/q1kk31BacZ7mSeC10HMzivU2qpll72IOZ87BhIQCsQe7IJ7DJi99lr86l856DH8W5OSwx1IA6cAu/tg7FHvysZb0IwaB1kyNRzYHY9EZukf2Y+JJSW+n5Oc8gOOohkOOJLyucpFqTe6dliwYVgTFpZWjrQNGgCawNxYWEryD14rvZfBHsmHnt82ySVl7yIThucK+G/Ewsb2PvdsYeYM0+uz8y5Ng77/eITKK6OTnX6QnaYsQKnjyBde1fYdKr5Pg4BQ5TwWCI9TPQi/mOVtqUYjK5SBsgCbYausqj2U1gtjGJlIJ1oYwB9FCWiM+KVauMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAC0cu492CkWS3X70LCM5tdm4BJuuriH6heA60R+iZw=;
 b=Qcx1c6WHM97/D2q36PaHhlXqLUEE/7kDh7TbOWjXw1UtaCGKV2ml6Xqgf/eC/Qa8J6OiGGL2YzmEi5Phqn/RpU04hTObvs6x33S2WIAsZIdUTG2JABoEauPw0PVdaSJFcjPSZEfxH8O39fzBbxw8KztT9vQNJxbPYYaPOLIW63HFoMdus5SfMP1y4/a/cvIRrEDEXh1ntZcuM642BzrjL6B906h3rtNkJZQ6f7/rLCcaz1vC/KO1iJOISgRLs0wMqCDZgCWYXm5boza1t8h09IOsyU/6AhMpv/+OVYIPOwrRZM1htMWa5jpQJeh56vZJ4oN8VrcbxY/SHo5k/wwi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAC0cu492CkWS3X70LCM5tdm4BJuuriH6heA60R+iZw=;
 b=VM9dkSo3XD7H3nBwXfZc7Oend0OLe4CQVHC3ofSngo3vNlahTZEPBm23lgFoEv1ZSSrsX1nXYA9TBkBkf1wv+abCEytPKKz3gzSPuXEykRbUICC9XnLJDvHKUgyp1RUZV0F9qP11Tu8KIdLoMBINCaXEHzHPuVZrocmTl2MpnIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 00:21:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 00:21:59 +0000
Message-ID: <a8dece32-5696-5fea-03de-1a7066e6d595@amd.com>
Date: Wed, 1 Mar 2023 19:21:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] amdkfd: Memory availability can never be negative
To: Daniel Phillips <daniel.phillips@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230301234602.17113-1-daniel.phillips@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230301234602.17113-1-daniel.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: e27079be-2249-4c1b-7dff-08db1ab42320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvf1eZOjPGDpwJPT7/GKNYlrhLRh+eYHU3eTmqh1xiQSh9wF62gYKEZhyL5gqvrVZktkU4cjxR0yp9b17zX5OavhcjHH8ZJwBarjWuk0jwDji3x0rrOS+rbRZ6lH6kGIclTUeKzYRJX+w0qz9k5q3ZACPfde4zxfPlR+j6OS4tDToQWI0JpwkPCKXrhlvac1In4HVlVgiEpQ/3JbEangCNLBjwFSLUJ76FzKBlFoiSdNp4FHYdPhCsl7+eBINOb80HO8VL2JF0Qj2+WiFyrBSSOK/YaHZQ7QhMrstJH3J9VLQbtOZSfQHG7Y/ZlVesEtp9lfbGG84uBLPh4NfP+saNbjJdPNcGuBtN5z4n+2sV1sx7L4VsCu0Fmx/Bg8RRG6OPLML8xEqJeh5xMPfepgI90APu9SQBoKBxAYIRynlbdY+gikhbP0dn2BxBVXiVGL9y2yk3jALYn+c1Fs2vj4bZBBaD0j3p2TRUSEp6J4uI7WCOz6CJKf0S2JE6p1F39ybl362xxJK6/rCkgOintiG+J8Xj3Ov1PkUflAX70Z2V6qDxpaSWlaTJFfKl6KwbxbQ7vQ2QRZFbHqhyq/yUQEZnxNTYU0Dn/+gcbBaEyGUHMYGQXkvs9yBk8qei5T/WpZWOEpcOKP34PSbJAxZoZxJ7y6o1Z4YWvTm38j4nxHGcOOeosztt24H5qM31HfROApY5ajaDPQhXwHKCi0Dq6t6CbLQgoVc1NbmWbSdpKt6O4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199018)(38100700002)(5660300002)(8936002)(86362001)(66476007)(36756003)(31696002)(44832011)(66946007)(66556008)(41300700001)(2906002)(8676002)(6512007)(2616005)(6506007)(186003)(83380400001)(26005)(478600001)(316002)(6666004)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0hsRXE0K0FmaHVvS2ZNbzg4bWtiYlRqMTFsK0VNeUlGeEU4N2xZd1RhVDc3?=
 =?utf-8?B?c0g2MnpSemMyc1loUFpZZ2pPTzlCRHJVV1R5NVVJaWVFWjJRZlpvQ1FtRHp4?=
 =?utf-8?B?K3pNZHVXaC9veFQ0SjRKamFLZ0kyTGMrd09OS09DZkpSWGFTRFdDd0R6eEtT?=
 =?utf-8?B?Y3kwc2poaGFnMFFSWWp6MUR3SHZ1dUsrRXUralllc2hXVm1PNUFUakR6amJx?=
 =?utf-8?B?WDF0a00xQjVGdHRRTHdZajYrR1lHeTJJd1Azbis4WG02ZnZwKzcxa08zS1pC?=
 =?utf-8?B?dUZJbVFUQU4wU1ZaUitVc3c2OGdMczE3TW1KeE5nNWpycWw4RlQ4ZnMzanJk?=
 =?utf-8?B?eUtnc3dsam50OVF1Y2NEdjVoekNIaExra2gvZEI0TmVyYmU1clBXU001ZHRK?=
 =?utf-8?B?R2lka1E5aDVZUDJBNUsvSTJvZXlzZG1tWnRDMDhwWVhWVzV2NlpTNGlUZHk1?=
 =?utf-8?B?cGZTUjc3NHlOZHQ3MDRLRGE3VDIvUDFabGZGTWE4eC9WR2NONlFrc3VBU0Zi?=
 =?utf-8?B?NnBCNnhQYjVXWFRpZkFZUlNJYmI2UldRL3BVbHlNSjBtbmZPSjZlQjN0WGFY?=
 =?utf-8?B?VG9NOEd1cXhVOFBnaWFMcWMyOFRnNCswcjVjZk9hay9OSXkwcVJsYlFVaDYz?=
 =?utf-8?B?WXU4Z1BtS0Z4R0lkNXdYYUh6bkpIOGxDUThuc2ErV3pBTmY5Q0lsN3ZDNVRD?=
 =?utf-8?B?a0F5UWxMbzBKQ1A0UERWRzViYkZTY0YzTStlRTlPRnh6OStRSkxoL081S2JE?=
 =?utf-8?B?QVNxT1RIVWVHRnFjUlA4Lzg5bFlPVFVlVVI3TTJtTm56elZXNmNPc2VJY0ZJ?=
 =?utf-8?B?dzRTRGlVTUNwcXAzeUxRSWQvZHpaUkJBMTRWNHBaNXdGN1RkcVI5TE5vS0Na?=
 =?utf-8?B?NnBwKzVsQ2pCbEd1ZWNWTGE1ZHdHZldsZ1JHMFU1TExRcWd2TlZRYlJmbUtR?=
 =?utf-8?B?cko3TXlXLzc4U2dxR1VEVDlYei9hMWZlUlZwdnJJRVZBTE9SM0UvbnJMTFJk?=
 =?utf-8?B?MFVzMWFHN3BSVitiZUg3ZWpROHRORFlyckM2K0JCbVJ6cVR5RUpBRHBqNXZ6?=
 =?utf-8?B?VnBtTzBIZk1xMVRoWVRVVkJIMmVDN1N5dXk0UTNjS21oWnl5b3pNaE11MHYv?=
 =?utf-8?B?M28wZUhGYU9KcmErS3V3Wis0NHVxaFJmZFhIM29vcVhjNGdQSmF5THdVSm8z?=
 =?utf-8?B?bUJDU0dVd1VoeVFXWDlZMWNOZlZPS2s1OHpDRG1NSkVOUkZyK25ZVU8zUUZw?=
 =?utf-8?B?VSsxRWhUalhUNzJBUXN1VFcyVi9Ec095ME0veVd2azFBTjAyd2t6ZGhJcHlL?=
 =?utf-8?B?a2hWd3dUZjNEalA4OEZpMmRYNWZiRU5LY2M3aWZTbVhoNU5pd3B2bzNpUmMx?=
 =?utf-8?B?clZEL2puanhIL0E4OHgwcW1ycGF3UXpYemgzaE1hbWoxUGZKME9CY21PQmU0?=
 =?utf-8?B?WEhpLzBBWW9Qd3lVblFGdXdrb3NjRTNoOGRsWkY1dGgzWlZCQkdkeENCTE9I?=
 =?utf-8?B?aTdaQXhOSFVLMkhPTGl6U1BiSjEvYlRITyt0aU9uSXBqRGI4RTIrWTJFaVlT?=
 =?utf-8?B?OGp2TWp4L2M4bkplZHRsK0Q3ZmE2TVF1bkgxazhtaU1DYVNKNU1vMnRWdTcz?=
 =?utf-8?B?Wit0b2ZXb3FmOW04LzhSREM5eHV2Uy9LaVA4ak03eDZTQkRlQUhuQ3FxYlFh?=
 =?utf-8?B?eGNQdXVmL2ZGSTB3bUk0dHJoQjNBUjY1RkxocXVUUzduNnVYaXZGOEI3ZWtl?=
 =?utf-8?B?OFViNnloNTdhVFk0SExicm10N3kyaTZrakE5RW4xZDZvNWlJUW10b0REdHRm?=
 =?utf-8?B?aUdXN2s3NmU1YUZMNkhKTVV3R0tCdTVreXpueWtVc1V2ZmM3K1JBV1ZpYkIr?=
 =?utf-8?B?d2paT0d5a25HQ0ErbGFLenpLcDNKVEwyN1ROOEQ1d2I1akdVRXAzY3U2emtI?=
 =?utf-8?B?bUhjM2hKRUUyUENMcEJwa3Y2SmdRdXFCcXhQZFk5c3NoWEpRYzVWOWxqMElT?=
 =?utf-8?B?SVVTVnN5Y2NlT0xFMS8xaHRhakVFby9MampHRnVlRjFvVC9xNW9qbXdmZmZQ?=
 =?utf-8?B?NlBTeFVoMjR1U3dUbkU4S0N2Mk8wZTZ1SUVMVnF0NVpVd01uQVJrR1Q2QXds?=
 =?utf-8?Q?UMj5aTczdBfHuM8/iIek8NY06?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27079be-2249-4c1b-7dff-08db1ab42320
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 00:21:59.0543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNVGe4ZXAZRcWujox2ewUwJBgqPiVhxT/TtCVi5n//TKbui3gQKDMXoBVr+rumisvUODPVFXtrxZdDVbRHVFAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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

Am 2023-03-01 um 18:46 schrieb Daniel Phillips:
> Our assumptions about how much KFD memory is currently available for
> allocation may be violated by various complexities so we define the
> reported value as advisory, however we should never report negative
> availability.
>
> Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 6f236ded5f12..293f9b2292fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1583,6 +1583,9 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
>   		- reserved_for_pt;
>   	spin_unlock(&kfd_mem_limit.mem_limit_lock);
>   
> +	if ((int64_t)available < 0)
> +		available = 0;

Instead of casting avaliable to a signed type here, you could define it 
with a signed type in the first place. ssize_t would be appropriate.

Regards,
   Felix


> +
>   	return ALIGN_DOWN(available, VRAM_AVAILABLITY_ALIGN);
>   }
>   
