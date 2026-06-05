Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F388FCD6E79
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7353411A838;
	Fri,  5 Jun 2026 13:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RUdUwHoo";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE4111A838
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRA1H4mzLBI4d0v/1QRjyQmrpabVslirL9Hxgx5Txd7AepnnmjBg0MlPdmahvisD482TCH7bb3vs73xFZJ50R/vDUPJWU/JHFUle4SzDkvLYvDF7ezNsTwn51mtUKexigxhIipuLVIhXBmMuQGOs4bF2/QResEJ33xIJUDPIhJ0EkbYbQzYlnxGvFAF+X8MYCRDGOLxXeUkRysyCDbcMY7XgZ0gcfvihP6m68eaIIFCmVp821pva14V9Db4GoirqeWWubq4z6cqT/NHEWHyE5qqVjFZg8QAOvnfH95S/6HxETJOt+TkxxumSCOPDQ4ZkSBzTBAFYtN1ATdTV0FYP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwS7IxtG+SDJ0rHaX19oJyRKjmz8rx7JNzIok0KnHpk=;
 b=qSwURfTUgVosK9GvyUrub+GBPEKn0a8ckkBqHmt6yJ2bBxcHGJm1bzkhFT5pu4aOfiXzwpzWGhGq7jjc6w8Mn6ukl3ysywLjY7sM8DoqjyC+5T19XpM966k5fzywTuh3cG0TElnlynEnlKAZH8HSU/ipoR37nGATYsvdvL14zL++7SsF8TkMnphvCJ+mHEzGxmNX6MvtkZrxhR8GEOiajiPFYMwJvGbDIpU4hOz6xg46ZXThFxOh5sjec2qvKKxyl5G16V4SzARvk2LFeds5B0UTQK053yWH4RGK6g5HJxUDhiJ+988gLPKLzsmGRH9LWtEq3jYJNWLi20wGVKf1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwS7IxtG+SDJ0rHaX19oJyRKjmz8rx7JNzIok0KnHpk=;
 b=RUdUwHoodBZeW1enEIfPimscL6wgya9ySlCVXeNQ2yFe7u9Kh/QXMSwsUn1amkjIk6BEraCTBMqksXzGqKSJwExG82qOiWHlSKvLDTFNJ5xUnVc1lLl8YJL5ic/NfEqszTFsBd1wlxQzGSRzY697C06Jr01/riAiA3iSYVEd34w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 13:03:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 13:03:37 +0000
Message-ID: <b278a60d-69be-4a7f-9468-e38b0eefce60@amd.com>
Date: Fri, 5 Jun 2026 15:03:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/11] drm/amdgpu: Wire userq manager to fpriv eventfd
 manager
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
 <20260603163350.2678309-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260603163350.2678309-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0bdfb8-3919-4243-b4e0-08dec302db97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: yN5TJ5VYpOafv7m3Jt0JHsBriIIQ+yl9fLBNe92RLKpErvxnHcg1sdL/B4VUmoIQ2MX2tihlpCN9hdXbyevrPsdvfh6oE6gha3ILs+BMdrAehIKXHqwcZqtEVvrPChJ6aDQqGND4dANai0xJa+BsWOqxKG/DiB7tGYfJyggPtIJQNK8pUCKPsL/9ZDbsPwJMBnodCYQ2Q1LVaS17cIw+f0CtnZ1aq/Aug+AjULTzr6iTreYUTaRAS4QTuk6+tcu5MOluFu3i5UGAVl4+A0rCFi7RgOrQYn5/2gdTZj/ccPVdm9d5d02AVmN9XMnHfh6fae4pY0yM4A3Vyp+q3YsEMMM2DxVH/+45ZctXiwhxrYeWChSvGg+SdE9GQ3iLOKk56E3sywKecn6batq4qgU6iBCUkfXHYfmPEWhhrcWp66j6pRClA7ruWweaTBI5xyTYm7XfOXYftEOviBIiRBq/xcOnuaVyIruzXUiz3Ci1qZJ52MRldCcqdd7Esm3TZq9F/VH2zMhgQ5tRkKiFZe5gaR4/M+UCOcngKnYhmpC5VdUciB3UEWJOWgkd7MCtIXyH3Jp0GvKvDZvCSk8z2NKajtoudvVW3LAtcYiSxeL6N313+h3LW/5bztXBQoD16M4DTdYX3Ar/hIrMI3JC9Jf6es+CAHjx/ZG/vQcBpB0dxCt4Q1zrg0DndOdE15CCEC0+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QStHQ2N1YmhlNzd6Zng1eU5ZSnpDV3ZvUVo5NkloSW0xcjZWK3NFNEYrZU9w?=
 =?utf-8?B?empiKzNBNU1zaURyWlNRdnNMME5nTzNiZFNVd0VQM2hWb1RuVmc4OG1LRkZZ?=
 =?utf-8?B?TEgyM2tNbGVFMUl3ZlNnMTl6RjYyZ1hFTGdrVWxJTHhyaXhzTDJEbkxVd3Zu?=
 =?utf-8?B?RkZmUVAzNEVoMnozTUNmSnhQeThYY1lyVWdKRERtbGJjV1BzcHJKRkVFcEE4?=
 =?utf-8?B?dHRwVkxhWXdoOElmUGJvd0FITU1KU0N5OW5Idk1pdzczVkdBSkNrYnlubVVq?=
 =?utf-8?B?eXR5TllVZE9pclcyRS81c2IrdWdORTJnT0RrNnJLbWFJNjFkMGRBS2J1TzRO?=
 =?utf-8?B?ZEwyUXVkR0R2U2c4eTdRQk1FTUhqUjczNWFYT1JVbm9OckxmSmhhNVhsUUJz?=
 =?utf-8?B?RitETnZmK2Yya3VzaGU4RFlhamcwK2Fka3ovdUxDRWp2T3pvanc1VmhwUXJx?=
 =?utf-8?B?eFIwNks4MmdkT3hyQUUwcXp5YlpQUUFiemtDRlI0S1pqK1N0VThiS0NFc2Er?=
 =?utf-8?B?T0hFMy9hbi9Dc25lZW1lVlBRZnBlVFArVno0ZUpBVVBlT28rSGRyenU5ZVdx?=
 =?utf-8?B?ZHJxS3RhdVM1d1FPZ2hRZU1aRFBCdk9PeFExRmN0enFLNElYRWxSY3V4dFBa?=
 =?utf-8?B?ZStYVDBpMGd0VkJxZ2R2RnZGWmp4Vjg5SXd6ZnZJUlR6VVpnK2ROcE1KTnNE?=
 =?utf-8?B?dDBLUXkybjQvbXVyZUhDNWxkWEtKQWl5MEVGRUVobnlIRHVjYTBhMi9mcDlO?=
 =?utf-8?B?akdvdGE4VDYyeitYNGtRZjQvVzFoSU42NTBvekFSN1pmTUVlRXVUdzhpZTBX?=
 =?utf-8?B?WDAxMitMUmZyZGxhTVZtV0xSNHMrVElvL3pYelk3cTZPQnNJeUV4VDNMcXo2?=
 =?utf-8?B?T3ZISDlhQkNKb0d4eWdhd2xIZ0pMNlc2UmNJcHpjVlVyRThYNFF6MVVGSStB?=
 =?utf-8?B?eW1LckpCdUFtVXdmZ2UrbGprSHZWaHhaaHJZOGhZQ1VGb2o2TGlXaEttc1Qz?=
 =?utf-8?B?N3N3RHUvTTUrMmpwNFBjV0hvTnhhVnlxUExoWVNmY1ZieURFUnkvY3JqbjZD?=
 =?utf-8?B?VUhEVHQwdUFqcmhId1dzT2Ewd3hIMlUzU2dQWTdRbFhKd2lVcVhHbEpOREVp?=
 =?utf-8?B?R0JNL2hoMmY3cmMvZUtrWWVsYXVzSjdNZFJmMmlxcXR3aVVORVIyL1lDUzFy?=
 =?utf-8?B?b25MR2ZWVFBzVWk2OWJLRFdEc1BlN3BNZUVzSTVhRU53RmhPRFpFcUljaE50?=
 =?utf-8?B?SDRMOUVhME5uZWVkaEpNNmc0VURzVWZnU054cTBYb2t4aGNrZW1YNjQxUjdp?=
 =?utf-8?B?ZVZyUUU0ZndMb1NoczBrMDJLVEdKYzE5c2xUQytlUTBSL0lVMVNUSXQ0U2VM?=
 =?utf-8?B?MHlHalpRQ1FkekZEU0tuSnBYbnNXVnZHNGJCamtKN0JGcjRrY00xQWphWk1Q?=
 =?utf-8?B?amVSMFp2a1pLcERrUzRWamZZSFIzRmVQU1psVTlobnVTYk5aZDg1bkhjdmdi?=
 =?utf-8?B?bk5Hcys5WSsxbFIyV2ZXaC9VY0QxdzNoaWpWenFKdmFITUpOdHRMMmJPRndu?=
 =?utf-8?B?dGpyam9wTklFMjgxWllLckZtTzdaWHZBM3grQnh0c0dYMDVWUzRLRmUwaFZB?=
 =?utf-8?B?SXlLeENCYWhHem5qMU0xR2JrcjczeEFjdURKSjlSR0xmM0VGZDRSSVFNZTNQ?=
 =?utf-8?B?NXJLU2ViU3h6VzBHNDFKRVB1blZPRlJJVkhMS0JPY2dDVzVpUHF5Z1QzZXNG?=
 =?utf-8?B?amFMbHBDTnVkVkc3WHQ3YW1mMXB0UWMvOEcyYTdmcHI3L240SE16bUxLNmlU?=
 =?utf-8?B?Q04yTXRmdStMWFNVclBpUWRqUDQ3dnd2a0srcWxlZzh2VzVzZFBqUFBnYmZ5?=
 =?utf-8?B?ZzFpaGhmMmpHTzRCU2VYMmswQjA1azlnNXA5R2pJdk9kSnFHSVQ3MWJ2VUdh?=
 =?utf-8?B?OS8yOWhVVmlwd1Z3bW9CVUdhdVR0TUFtMzE0aEZSaG1McHkxSjZETDNWbFg1?=
 =?utf-8?B?ODJ5TlV3Q01vUnFTc1pLamh5MlZPNzd0ZTR6Q2ZtcVBVRnBvVmZUNnpwajUw?=
 =?utf-8?B?cDlFOWVGRUIzVVRnVWgvSEE2ZmFEOGlCZDVrT0UxOStPa0c4aFFjeCsxUWlB?=
 =?utf-8?B?dlhhTk81RjNoOFgrQ3NQMW9JbHBpa2dUeSsyL0JhcWNHdDJuUC8vcE93ek5N?=
 =?utf-8?B?czNlUW1jd2ZWM0lVQVJ4dzlaNFBjdXYxcW9lcGtwUFg5eHMxMWlrOFlYRnZq?=
 =?utf-8?B?cm0wL2lXV3JQY1lOWU1RR2JzRnVIamVvam8xckYrK0xoMHpNOTljRThsbzlO?=
 =?utf-8?Q?UlNd3QrOCGi6D/L/Jt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0bdfb8-3919-4243-b4e0-08dec302db97
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:03:37.6782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkj4d8lEnXuLmTBcDqybxbJSgMSrlt06FOaHDyKcol0U3kkWFf4cLi+GJDiwWrsc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944
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



On 6/3/26 18:33, Srinivasan Shanmugam wrote:
> Store a direct pointer from amdgpu_userq_mgr to the per-file eventfd
> manager embedded in amdgpu_fpriv.
> 
> This lets IRQ-side paths signal the correct render-node eventfd manager
> directly, without walking back through drm_file -> driver_priv.
> 
> The pointer is optional and may be NULL until the manager is initialized.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 99c711ddf71e..93e9cef9856e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1168,10 +1168,13 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
>  			  struct amdgpu_device *adev)
>  {
> +	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> +
>  	mutex_init(&userq_mgr->userq_mutex);
>  	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
>  	userq_mgr->adev = adev;
>  	userq_mgr->file = file_priv;
> +	userq_mgr->eventfd_mgr = fpriv ? &fpriv->eventfd_mgr : NULL;
>  
>  	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
>  	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index d1751febaefe..baafa066097e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -127,6 +127,7 @@ struct amdgpu_userq_mgr {
>  	struct amdgpu_device		*adev;
>  	struct delayed_work		resume_work;
>  	struct drm_file			*file;
> +	struct amdgpu_eventfd_mgr       *eventfd_mgr;

We already have a link back to the drm_file, just make an accessor for the eventfd_mgr who extracts the pointer.

Christian.

>  
>  	/**
>  	 * @reset_work:

