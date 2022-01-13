Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36B0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 18:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7379810E1A6;
	Thu, 13 Jan 2022 18:00:14 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB0710E1A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 18:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhdv46RuZbZsgBZj2wKgnuPwNQZdstN9H5iVth1fz1H/TKVwH7yTbWBA5eXxhnUqBHlayYtzWskGjdYsEm4dvY6bewxRGtZASwlufEvzD+UqZwQetdNNr2Wpbsk2LNoGkO5qXErQ1ZFMdU+u36PB8EyAelrgp6KMClCkWMwSDeB5kF8ywV2tyPMAIAKJE4wZaF2+vv4aYAVJ+vwSFvTHNgTJP9gG2UjfH85U+rvcO7TVQ+fC23Vp5JgXkjFvnLF9KC7H/nVzS2gfzYZ8m9OfPzwkIIitchoBQPpIb21etjQlD89xxBWDzeA1HNE3XrFZwXgnT3KF5uRrWMjoiPvOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsSYRe7O8xXcUTUhweS0yU6Hx1UOLMo1JCIkzkHC13s=;
 b=fNIgntYZhEEeR0Px4W2TKFQfkSMcmm5Jv/CH0eJcR5cIjtZkzh36KSrs4Okx2aCGS4RZQ+mYEqyBYah+WaV97clW9s90Yn5cOU676JP2evKAX//fTkV9GPFAsDmSk87GJvS9b4fdEKIVDvqDc/HpStHp+cAunHUyBKQNZNvhQUO/sze69oH6Z/1LpDvwZPZtAL1+KDLk9zGyxLlwpP8eMIN9IwOj0Qf9hhXMDZJ4TrJkI3Uho+J/XHvcJu+2c5yVmZiJK/SOY508Drt6P4K8pJeNvORLMj41ZWa+FAZyAq3IbDN/QwQwOQTNk+SBq83PQLc6T2OKYJ967LeSkDHZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsSYRe7O8xXcUTUhweS0yU6Hx1UOLMo1JCIkzkHC13s=;
 b=10dcmU81AVjpm7J+xKp1eHr4feu4e6Zob20OMijFRWJUMME2lffq3isz7FZXdDoznua6sCmvPvLYGQiUWY6rFs0taNmvEZIA9J9saim5WWWcqKpP8cQ1PEfR0U4qd7v86CO1hBE5+t0iDQtvMDG1BUyhjOxmgc6dkaPdXRqsBho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by PH0PR12MB5466.namprd12.prod.outlook.com (2603:10b6:510:d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 18:00:10 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::f452:e803:893f:2fca]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::f452:e803:893f:2fca%5]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 18:00:10 +0000
Message-ID: <3d93b394-c6ad-5164-0e11-73442f85b552@amd.com>
Date: Thu, 13 Jan 2022 13:00:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH V2 2/2] drm/amdgpu: No longer insert ras blocks into
 ras_list if it already exists in ras_list
Content-Language: en-CA
To: yipechai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220112103832.2910237-1-YiPeng.Chai@amd.com>
 <20220112103832.2910237-2-YiPeng.Chai@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220112103832.2910237-2-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::8) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0978a1b-ece4-4902-6b0d-08d9d6be8a24
X-MS-TrafficTypeDiagnostic: PH0PR12MB5466:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5466FFD7FBFFAFA08EBB5E0699539@PH0PR12MB5466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDOEjhCNh+H90z/spjHyShvlGLnBDA19pe0UOSr3RtGLKRXQK4To28QLJALrMARjWSKMBL/vmcMs/3cJwO+oXEw3yYE9FWWP2ry4QChXdghe50ARQdVbJueUOCameHDg2r3J385+lclXu9QB/H0T3gTLK3C+5VryDEhUnw5N5WW3a51t+6+KkyKTM/Exa1JE1pvrBLiDEMxRsIv9uaue0Gu9pHsj3nTJL8mUjMh0chKIshO3uR+cuN8dVWiZ61iBn5igSL7bo+RJMS5ZdLkAIzW6qKyEqCm8X3SFpG7VDvUomg3hpLsaHjo2vySo2o6EAUfzZbqN1R+E0TBLgJFFJhzzIk04h9ajKtI/nPcc3vqijX1OlH3AepK8WDma4nv0M1ML1+FzSB5E9TzbL8xTiecOflQZ0jUZxYTIYdF+EUFv9xWeF9C4HkBeWtzzZSo67wHzpZCJeMUEbQ1HUzhVZucun7PJCbq9VqVIb5mqlDEP2PHxPUwc0y/sq3rLcX35RsxqtVXZLd2KNNGNiBSqszRNrUb1gI8hPQGhm9Km9lVu8ouAiagKJMI1npas/CrLZq0ZpHS1vni+FKFyUcX3i3g6V7/TzRFhMpfaJam7/LhS6VltnRII7fdAss57TSwk9VFHE2J74XnJe2TxuFIfyOgPN2SPVLgNtZOZxDzVXiaD6mPS/1oOstDXEFtqMEg8VK8xiDUL1sz1vSPIA6xonAHbS0W5zf3pTzrV4bYGdsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(38100700002)(2616005)(6512007)(86362001)(6666004)(36756003)(2906002)(31686004)(31696002)(83380400001)(316002)(53546011)(508600001)(186003)(5660300002)(6506007)(26005)(66476007)(6486002)(8936002)(66556008)(8676002)(4326008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2FyK1hsbTlkaWV5dm9IWUVZWjZxUzJuc2R3eXB0cG1YWVlZdjF3Z1EvV0xw?=
 =?utf-8?B?aGdCVWNCWWp4NGhPZUdpT2x0UFQvU01SdFhsRUU0bFNheXc0Z0Nmb0tJdU1j?=
 =?utf-8?B?Q0dIRjNLSk5YSmNYQXJ3RHRyRlowcXFoZlpOWHVTSmM2SUVXaUNwdEd6U2R5?=
 =?utf-8?B?OERoazZxSzNkRXBYOXdGRUJxdG5OWEJlaElMdDZWZ1NTU2FQTmxTSXUyRjli?=
 =?utf-8?B?enFYZ1E4T3ZDTWtvT25RTlFWUnRQRlp6cTMyTFBQQVJhUFNxbmZrUmo0azdx?=
 =?utf-8?B?K2crNnUxM21UU29JcUpsNTFnSkduVEdLM2NQNWZSVUEyVVpZWk1lWXp0dVRS?=
 =?utf-8?B?akdhN3pvcjRqbWZhWm12Zlcxd205VVBpWGVoK01VRVNhOW1sNm5BdG5CQWIv?=
 =?utf-8?B?R0lVUmZRZUxsdU14cDc3cGNKellsak1QRExMVlpBbFZsU0tIZnhSdWlpSGgx?=
 =?utf-8?B?bS9QRUpXakU0NUtOcGNNNVFxWEI5RVoweUxKakE4aWVSM0huMjhQdUN4NndL?=
 =?utf-8?B?c0diRlhCK3J3bTZRUnZHc3ptdU0welMvWkc0aExMWHJPTUQ5Q2RyR2tNRDYw?=
 =?utf-8?B?ZUtwRnBlM1VmaHB1K0ZPSHJWZ2xSSjRsMVZkZldyaEtLc1Jud3pjaElqN2Q4?=
 =?utf-8?B?bWNIS3V3WGpCZWFkRC9iSkZTMWF6KytzM0d0WjFpWVorcjMwYWM5b3Y5Rk9w?=
 =?utf-8?B?Qk9uMVRDZ01yVDR1bmtKUmRIVlI1ekNnMForQUJFcXhtZDN1c2ttV0NYbHRj?=
 =?utf-8?B?WnlVU0hPKzRoYm5oeWVabW0yQ1RWK2dPSFRlekV1aTlRU2JZTFVyaWlpZDdQ?=
 =?utf-8?B?RkdFYWcwUGViOEptNlh6S2lqczlZVlU5Uk40dHFMazE0aDFsTDBjKzU2OFlo?=
 =?utf-8?B?WXhpODBKT0N6UTY5WG52NllWSG0xTlBTczVqaUkyUFQ3UGF1SzArWDlnbmpY?=
 =?utf-8?B?QVFEQkJoN2hiUE9FSHlweFl1NUpSMFVGR282d3R1L2thTDBoMzlIVngrbnVW?=
 =?utf-8?B?Uy95OUFtQmx0S09DOXE1a3plK01sSXZUZjZVc1BlUno1ZTVMb0MvMW5pb1dK?=
 =?utf-8?B?bUgrOEtMdzBqUU10Mi9lWVNOZG1oR1AzNTJyYU5rbHpnckdEYnVVVmtFZEdh?=
 =?utf-8?B?Q3p3L0grajA0L1A3ZWk2QXZGQURrc1Z0aERleFF4L3pxM0hGQXkwd25YU094?=
 =?utf-8?B?YnN3MFZHYWF0Q3hCNnpEMnhteFdYcmdUYWxORFpzQ3Z2cFo4SjlzT0F5cTFD?=
 =?utf-8?B?cjRBc3N1dHZ2QlVlVGhvbFVGYUdjSllucC9UU2hDTWFRajhxc0ZnOUhHelJM?=
 =?utf-8?B?RFpwODlHY3k5UnIzY0luMm1mSHM5Tm9aWlZhY3lINnJkTU1HTUtJb0tlalJo?=
 =?utf-8?B?ZmxIRHZja1FoU1lxYnQzdnFEUzBUT2l5T1BZU0YycFlmNnVGelR2bGIvaFZF?=
 =?utf-8?B?cmZUc0hYdE50M3hkcXJicHFGeHhCWHV4MHVPbHRxQ3ZBNEtobjlOM1F3VndS?=
 =?utf-8?B?MytrUmdJMGd4ZCsxRnhsK3NZWmxYQmM2OTRnVnY2bkdtVnFqRjh5K1JxWFIv?=
 =?utf-8?B?ZVU3YnVkQSs5U3RwMXVGZ3p4ajNOV1lvSUdvblhUL2NoRXFpNE0zakIwT0E4?=
 =?utf-8?B?Nis5L014RGVhWW9zNUFnUno3UHpPU0MrOU9NYzN1REZHYjI1NlJLK0xrQXFa?=
 =?utf-8?B?OFQxdEdtQlo4QkJ0R2M0MFZia0ZaeDdQOTlJL204cGIwdEpqV0kwVEhhSWYr?=
 =?utf-8?B?N3U4aGxCdWlLTWhJTGtMWHNEcHVVMzQ0Ti9UekVLR3JINWhNVnB4b3lBMFpl?=
 =?utf-8?B?V3Q4LzBYZjNseGU0UnpzOWI0a01BU29uZHc4T1ZBTUgvc29tc3lCVDViOWFF?=
 =?utf-8?B?TytoYVNBR1Z5ZUFjUFlCWGtscDF1RkFoYTJTcWpvTGFPSGdVbXpUWWk4UjFI?=
 =?utf-8?B?V0JRc1d5TjA0aGJ0Q3UrWCt6YnRqVkI5NnpieTZmWGtjVklqZjVGRUZJeS9I?=
 =?utf-8?B?QUNXc1RGRm5ISm83OCtvV0xCYWZNSlhRYUVJbSsydHZLZk1ucVlFdVRvb3Rm?=
 =?utf-8?B?U0p2ZVhmZHNPRWVhZjl2SGNkc0htVlBZMVB1L21kMEZRTUx5cXBsRnRRYlA0?=
 =?utf-8?Q?7hSg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0978a1b-ece4-4902-6b0d-08d9d6be8a24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 18:00:10.0502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5P4E7L+AOkKtZe7vTwBWhKAgPmrTOLshXSsT/9HzBAlZd9PK3DuTYN5LBQTEODHO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5466
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, yipechai@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

NAK.

This patch should be reverted.

We need to figure out why the block is being added and fix this there.

Regards,
Luben


On 2022-01-12 05:38, yipechai wrote:
> No longer insert ras blocks into ras_list if it already exists in ras_list.
>
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 614ae8455c9f..d208fde509de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2754,12 +2754,20 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
>  int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>  		struct amdgpu_ras_block_object* ras_block_obj)
>  {
> +	struct amdgpu_ras_block_object *obj, *tmp;
>  	if (!adev || !ras_block_obj)
>  		return -EINVAL;
>  
>  	if (!amdgpu_ras_asic_supported(adev))
>  		return 0;
>  
> +	/* If the ras object is in ras_list, don't add it again */
> +	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> +		if (obj == ras_block_obj) {
> +			return 0;
> +		}
> +	}
> +
>  	INIT_LIST_HEAD(&ras_block_obj->node);
>  	list_add_tail(&ras_block_obj->node, &adev->ras_list);
>  

