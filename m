Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC75C25B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 07:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB6410E081;
	Thu, 23 May 2024 07:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bAZ4MbOS";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07AAC10E081
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 07:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOrOvuPevoqkdFNPPAtU062YWxDJmO59nGuJ759ppfiGeCoMZJHCGgiL+c7omzq4BA+IrSpjsEDmXSU431qZRm7zHgKjiXtZ54NrMHI+nqQBv9Rs5rUhfZxqIGrMxq3TWtBAODusX50MdlJ2sH3EaYgOufUscG/BGORQ199Czmpj9Hveag97c5N1YSC7kewuAqOi0mPLdTopnSqG9meeZSgZpYInuIkIOm9Rw4RzWn0NCdlWYJaiwxD66FmWcH7EbbELNV9ftgNvnucdXcrUFH6VP8tXLoJA/NXS5bJ5tMFvbTJhQy2MzuHZ4rDpTl3xppFkr2+CVU7HqrlFjqk4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9fG9ooZLnpZ93q7/iomBKyoguOsBxyAXJqtJoS2XCU=;
 b=dWSLdzeQdqpulhcYbTxXCOjdnv+vDhKTAe3jhVJMpv+js3WwFU7Ig65Nj5/y2DCB3jNLS+PahaN+JT34GO4Bq/3NSH9oJR/rfLDRA6VBAgmG+6M2N4P+TPoN/uj2vgf4KvpAu/NMFxWZNInVfopZTIoRJUvrYBPyOjzPbfkns5yPjd6qpdiD6oaVzaQ5AOzUlP/O29njNxi0cWAPihguCsB1nn0XvW+a52OSdQbTlvtQFDc91zJGaelEmrIV90laItGA1xmfCXPtpAJVqqvGymGJp3EZB3TxOpqS453E+rp88mjCLjZd+2KFdOVNi8IiZsvQqFdSlgh8wNVuUYbUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9fG9ooZLnpZ93q7/iomBKyoguOsBxyAXJqtJoS2XCU=;
 b=bAZ4MbOS4t5zVAZ0UHTGcfhXmLH/CGIf1Q/75FBQPK2dKSUpP7yNmUOVbJ6XvMiTh3wiYkJOC1jcJzi/TYAeZTfyYus6y288VUGMGj1+7XWxagnpRYztTdHUgujIYbJJ6ElOMDG/YfaSaG84YDb6S8hL4hnzrfX5uVFwJLaMcNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 07:27:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7587.037; Thu, 23 May 2024
 07:27:33 +0000
Message-ID: <0d844cc7-5286-4919-a38e-3999bc8faa85@amd.com>
Date: Thu, 23 May 2024 09:27:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix dereference null return value for the
 function amdgpu_vm_pt_parent
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com
References: <20240523061325.1418911-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240523061325.1418911-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c9acec-a907-4aa5-1cda-08dc7af9cfde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3hWMGhrUUR4dWQ1eW5KS3JXcmtSUkJVODdDRjY1Y05YUUM5Tm8rRFJ4SzRz?=
 =?utf-8?B?RjlNNHowamg5L3BRV2dhZ3dwT0QwRXZha2ZnQWtDY1NlR3Y1U3VNbTFaalJa?=
 =?utf-8?B?cDJjdHZnb1FNYVVKR0ZPeC9McGszNzFFYU1KN2RmU0xrTnUveW1DbWVKMzBD?=
 =?utf-8?B?SE52YWJwM2VxZmJBVW80aXJteWpsUE5VZytZbm9xaW5Cdml4dUFRcFZvNVhX?=
 =?utf-8?B?K1hNL015UTNWeWs3UTBjekw2V2lVakVwRHd5L2lnNUNaYWFCUGtteDM4aG0y?=
 =?utf-8?B?U1NNTlZWTWxMUWM0T3ZibUEzbklqMTZCeE5ueXkveTJGdzVVZ0xVUDNQUnB2?=
 =?utf-8?B?RnRUWkk5R0IwNWxuZ0F2dFVrOFFVZWNHa0ExS3Q1K1Z0UUNwc3oyekxyaTRt?=
 =?utf-8?B?elFZMlBzS2VtdGVlVVV0OUN5d1lWMmN6TSsvSU5pQTNBUzN0aW8rUlRjQWRa?=
 =?utf-8?B?MktkaWt5M0JEeXdiK2pSYWVlWnd6ZGNxSEgrcGtvbVFRQ0R0SldMdkxyWVo4?=
 =?utf-8?B?U0VoaTZVQy9pNkU1WkQ3RVhnRm5ET1gzdGROYjMrWkdqbUpDR0lqKzdxcFk1?=
 =?utf-8?B?ZzU4NUFuNEJ5bGx3ZEU5c0FWZ1drTHhvT0F6UXBORGdIa1RVNzZUSU9rdVpn?=
 =?utf-8?B?VkVPSVhLcjZrT2JNeFJVN0drNXc1b3BQaVl3QVczQzBKeUtyZW05bkQ0dHA4?=
 =?utf-8?B?Slg5MnlTQnBtVHlmL0dBSXhmaVM3NERLWGtjSU9Yc010VHFMYmk0blhOQVRD?=
 =?utf-8?B?TklWYWp0YlF6VXIyL3hTUzI0aEljam82ZkErcGR2MTNYTFljQzEyZFdCZnB6?=
 =?utf-8?B?LzhSd2VHb2F2Vm5VWjNSck41Y0orNHJFU1JHb2xWNkxTdlg2RThBd2J2WUNI?=
 =?utf-8?B?cDFsVTRkVFhBdjBoQjhUTWlLeXNaYTVVc3BYNlkxYnVGNUF5UmI3bG13RDFS?=
 =?utf-8?B?dnd4RkhONGNhTU5OaDFvOW15T0VnWHVhbzk5eURPMUFLYzk2akJqMS9OcXky?=
 =?utf-8?B?RERxcnJYcFhqZCtFcUdiOWY3ZkF3M050TTU1ZmJObzNUMFVtNEVnald1eDRz?=
 =?utf-8?B?cjZNZUFFSkM2WHRnMkdXcmhNMm84cUNjZ2ZJeXA2UWVxcEcwV21nNlpWYmd5?=
 =?utf-8?B?LzNQb1oreEpUOE9vUi9hRlVXSHFlRGoyMWlnK0dTNGEycU9sTTRYbHQ5MDIv?=
 =?utf-8?B?MWxLOFV5V2lqbU9UT0FoTW4zSGFTQlRKSnFOV2JGQXlCak9jb1VTRDRkTDhS?=
 =?utf-8?B?ZjVWclJBQmFkYXdZOER5NkNFdk9IQjV4K1hDZStmK1VWcnMyTGx1QzVJVmVm?=
 =?utf-8?B?QllFa1Y5UmF3ZjJmb1c5cUxaaUFIQmtocnQ2S1d4Z1l1Tk82dnRQRjNCOVhr?=
 =?utf-8?B?bnJnbTlrUnNTWk9VTG5jV1FYWUJYZGFUWFl0UncvKytPVFJxazdmbEFVelUw?=
 =?utf-8?B?ZW5kZTFGczNHdjloWFBQTlQ5em9oYXdXcGdCUk9xbDZQaWNOekVGK0VRYlRt?=
 =?utf-8?B?YVl6Y3JhSUs5aXdnTVREN3NhSXd6TG13Vm1PaC9wMm5WRFNFWWhaVUNLbk1v?=
 =?utf-8?B?V05oMmpQNjdqQkpTVGloUGdvTmV0M0MvbXBsZk52WktFM0dkTEtJaVB5K2tu?=
 =?utf-8?B?UUk1UE9MZjhtQXZkZFlYZWV2eHdWZXlsRW0xb2lQZUVKdkNWS01MUFFFNG5l?=
 =?utf-8?B?WHpEUHdmMUd2QmlNeXZSSnBtSDNKK3JDTGZhWmN3RkxUV1RrdmVxY21nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emkza3BWdTRMZVowYllJRlBLb05LTkEySGNPdUZwNjV4bG5iN3JRUklqNlEx?=
 =?utf-8?B?aFphN09iRU9Nb2ZBVTRUOUIwSnFsVE5oaHdOckdSRFFrMWVCUFZyNnVNZFFi?=
 =?utf-8?B?enJaNWNwdUF4dnBLQ1pnYnBJV3NiWWdIQ0dtbG5UQXhZbFF4VDh4SzFXTWt4?=
 =?utf-8?B?aHo1WXdhWTRIM0N0cmIvREZCRFBSK3N3aGhVM3RYbDR2RU10WmFaejRWaVZt?=
 =?utf-8?B?NlFsdmVNbzdhZ1FraDV3N3FLWEU4dGxIYVphb0JsaFhBWTBPSkN6bzN3d2ZV?=
 =?utf-8?B?TzVUazU0enBValBRZkFrYXNEY1FUbnFyMWtZajhxUk9KS3BtQ0s4SHdwK2JN?=
 =?utf-8?B?ZFBoZCtEbEZ6YVQ4Y253Wmg0cDNyYzFXS2dHbmZpT3BnVjFlakE0OVcrRGNQ?=
 =?utf-8?B?OFplNVJPZm51R2p5TWoyWFJxVFZ1RVV5LzlNejQ3eEZuVFBNUnRjT1dWaTBm?=
 =?utf-8?B?eVJaKzZJOHV4eFFyNlMvRjFvbEZtTXBRbmxGQmxJY25KenJyU0NWUjZEekhk?=
 =?utf-8?B?UWpoaGFJMi80Ui9Tbm9YdE5TdXZQbDdvZnRyWndXY1ZTMkthcUNUUlJjZk5x?=
 =?utf-8?B?b04rd1AwNWM0V1lKa0xxU1U5Sk5tdHFvdVNIZ1Z5d0E3VmJrVmYwa01XQ1hU?=
 =?utf-8?B?TE4yWHdmTHRQa2xqTVBYSEtUcVNjdzBHNlBHb3BVUU1GdG5UWXpwUm1pM09M?=
 =?utf-8?B?L3JhNVpNb1JMMjFqeHYyWnlrVkpnTjk0aTJ0ZWhkUnAwR2RlZmFJRzM1Q21H?=
 =?utf-8?B?OFdTN0N3UUt1blJWZUlJZm1oZ2VwSXpSLy91QmhabCt0c1QvVTh6Y3g2Zlc2?=
 =?utf-8?B?bjNoWCs2bjJndTdxdmFwRE1xeGdPYzZEVHllZFZHeXVGdHZNeFdDNExSay9i?=
 =?utf-8?B?ZVZDeGZnak1JaUJSTWNDV0o5U2dTcStlbHFtMU10eXdCekkzRHAwZkxoNkZP?=
 =?utf-8?B?Sjg2VVUvSDUzRlpPN3cxdGFvK0RnM0k3eFRyNVdRSTlHU0N0NXo5dzViSG9z?=
 =?utf-8?B?UDZodExtL3prZTRVajkzWVBMbUNFQS8yTVhMdmJtYzFKRFlPaG5LbGpHaVln?=
 =?utf-8?B?S2NTRkZsMkw0Q3JvVmkvWE9CWEprSUVodVJmVGhwWGRFZkRvWU9jL2ZuUHN3?=
 =?utf-8?B?WHNXcGk1U3ZHTFpDU0p0VHNtYlF4M1p4cE15bmJEdWFTWkU2ekdpa3o1VVRK?=
 =?utf-8?B?Um94cGZJejltNkNaYzY1NUNMNWRLVkEzY3hCM3h3ei96VjRIUEsrRFNtenFz?=
 =?utf-8?B?Y3BLQm5MVmFzOFpLVTRCM0kweHVnMjVROGY2R1JkTzMveDlTeE9qV3ZReDJr?=
 =?utf-8?B?emlqRjlIdm1ySDVQbmZnQkJPbGxTRWJONDVuZDlUYTRiSjZKMU1rOGhjT1FM?=
 =?utf-8?B?eERySVlWb2RxUHFmSnE4a2dQMVE5OS9yOU9MWEI5eEtFNkZkb1ZUd3lqRDZW?=
 =?utf-8?B?WW9lU292MmNWSWVnckJnZG03aUhIa2RoZU54cE9iYzF2Y3EySW8wS1dKdFNH?=
 =?utf-8?B?aHNBLzl1bXlQbTd2ZnNWdXF1NGlMS25mdWxMWFlEVVYzYk82cnE1dE1DRVYv?=
 =?utf-8?B?MllFTmtLMEZCS084RHFiOUJQNnppV0ZtYldnSXZybXIxcWZnS2JFM0hocTNI?=
 =?utf-8?B?T2tYSWhmWUJEK0hBeU9BUnJEZ1BTd04vaUN6cndTMkp6bGtqM1REZGhZNFo2?=
 =?utf-8?B?NzRXNzQycDQ3TnRqQzBVR0tZVG1pTEw1MFJJWmp0dU5KKzM0aEFiUWtHcWcx?=
 =?utf-8?B?bzkxRXZJcTNZMGhqV2ZJazdGNUtuM001WkcyL29JSjc4UGtXRUp3VFlTMldB?=
 =?utf-8?B?bklaZU5kYUFKZCt3Si9CcG5hY0E1OGxQaEVwbUpScW5ta2d4UU5kdlpiK1pp?=
 =?utf-8?B?dzQzYjBZb21VdWVOeU8waXpSd3hQcXZJTDZZZFNTeVBzTXB1VlBtU05ncFJU?=
 =?utf-8?B?dWhzRkNlUXZ6MjFSbDNXdlJLNjhDcnFDV1FoRFhsdjlFRmJERUJyTUw2V1FV?=
 =?utf-8?B?ZHkrKys1VnJKZmd4WE56dnJUWEVkR0tDTW1TTHhxZ2xjblE3cWQ2ZHhRMWRu?=
 =?utf-8?B?N3FOY1dTZW4vQVd5b3RWR2xwYjlhMng4dm1WWFF3aGEyaC9ITnhMNVFmUGha?=
 =?utf-8?Q?2gz+kGTUq76r9PPGmeoZ/zECC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c9acec-a907-4aa5-1cda-08dc7af9cfde
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 07:27:33.5635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKrY3PIHxJORlVuhBJJjqfiDwbIYshMA5YSi4+eTqYktFswtDXKBVXmUCUvFI8j3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
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

Am 23.05.24 um 08:13 schrieb Jesse Zhang:
> The pointer parent may be NULLed by the function amdgpu_vm_pt_parent.
> To make the code more robust, check the pointer parent.

No that doesn't make any sense.

When parent is NULL here we should probably call BUG() instead.

Regards,
Christian.

>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 0763382d305a..bad8d2c31202 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -706,11 +706,15 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   			 struct amdgpu_vm_bo_base *entry)
>   {
>   	struct amdgpu_vm_bo_base *parent = amdgpu_vm_pt_parent(entry);
> -	struct amdgpu_bo *bo = parent->bo, *pbo;
> +	struct amdgpu_bo *bo, *pbo;
>   	struct amdgpu_vm *vm = params->vm;
>   	uint64_t pde, pt, flags;
>   	unsigned int level;
>   
> +	if (!parent)
> +		return -EINVAL;
> +	bo = parent->bo;
> +
>   	for (level = 0, pbo = bo->parent; pbo; ++level)
>   		pbo = pbo->parent;
>   

