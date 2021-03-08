Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F49C433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 18:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75C465230
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 18:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75C465230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2006E0F5;
	Mon,  8 Mar 2021 18:12:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E380B6E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 18:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbJ+qz7mxqd6DiZ82z5FyF1XXmTTxm2VVksb/pGADuDH1jLrupWLZGwCAP10q+OctMvM60NFnaZBTGsGEcXWqsyIBrYGgrXoG1ZE9JHnQOrnHIqCSigW4t6YHW2INu83sWSx2tLOWHBqiMfKd7584I09jG4reVkJ3HsHrhcz+aWFbvdmZESzXIO+nqhoS7WsOlcZZsvLNC+1i+TuiGQ8Xr8IARH9xzmN6CDoxlYgTq+B5w08Gy67T3iFxW5aw8E2JS7WRFNV5WExZ7Gj+YRByJHMf2lKh81hugaaocM9DAVLdTTe7lq4m1ntdbWwpBlI+gA3mzwzmjU5Z8zKRzEhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3XF7iW0lmllVCbJWHFKGoBTAwTZCzIxFZ4jNSRN9aM=;
 b=UYpiWU9d3nYpLXRJX2Nmg3z4ghiz4OwTIkE5DYehn+L/9tvjxcwdFfT8uFY3XhDRYuVRVOQitjCOb4jh2BvvG/xD2IEQbf8lJiLMHRQ6spxULY7WQHb7uGhp7RuKaq+/htnOOpDEPFXcmzXlR1SkK66ZjaNryRmgU2bCTN7MJeLsNHoksgdAzwVAyEoVUPoGjkN51KiKaq56L44ODo2RrInA4Q6uSoedTpB4IUcs6ImvEEEKoWH5Ga58XBugthe6HjVS+tFjaTQJSKR/LI0cCuc5iOF+XIJS+l7K+3KU9ovQHHoPqDJR2c6uxMa6GxVo6aGNia+jFo4JsI7VRCA1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3XF7iW0lmllVCbJWHFKGoBTAwTZCzIxFZ4jNSRN9aM=;
 b=UNvDn6I0czEVCaPE7OiaZQ1xHjRXFpwY817xW4HuXvZQnc/iN2UzCVHRTfEqkiQwlA2g9JaUlQRZf3qhNxGec2Z4eek/cPdv4mWWS7dzsFFeOkFtwlop0HXK37XFP9DhOE/OdHAfKFI4mlmWdM/HIU7ReJD+osUZHtyIct/L834=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4816.namprd12.prod.outlook.com (2603:10b6:208:1b5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 18:12:44 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 18:12:44 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: allow variable BO struct creation
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210308153705.37414-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <74fdd82f-1661-a2c6-6cd4-650f33d8c7fb@amd.com>
Date: Mon, 8 Mar 2021 19:12:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210308153705.37414-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:4feb:dd51:df27:4444]
X-ClientProxiedBy: AM0PR02CA0096.eurprd02.prod.outlook.com
 (2603:10a6:208:154::37) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:4feb:dd51:df27:4444]
 (2a02:908:1252:fb60:4feb:dd51:df27:4444) by
 AM0PR02CA0096.eurprd02.prod.outlook.com (2603:10a6:208:154::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 18:12:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d8ffe46-187d-45b6-fea4-08d8e25dc4c6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4816:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4816896B47D9F0B435E63D6583939@MN2PR12MB4816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPBxuiBtPlyxDzRpBvaMORI0JlwFrmneRE31x2bCIsuyr/oViBYgTpmkZSzVltj+WiW60DUHfXa9ct6KrlefXC/pVOVw/8ldXObYJsDJI0yQqpPH542ZGUB0EeZSb6RDLQUnKi8TgsGjEP/jahGgLnoe9/Btq1uo/0L5P4EyTFOX8SvzQVmrGuLrvcKOAwdNv+WBM9Hw7I4Qj5oGO5W5IH0n7KohyK/6Mcr7JFpw2xxB40Pamdc/srxwsbHss7ixhwNNQyb3Lb0BllGudrdyyKUlBtHOm74iJh4AL+Wewoq26Tyv+K575SCLMEkAbRjLFetG9p5ZyXNFXHcSgSXlpktnWBxVYVNf4pyOzVWSF/I/1DWa7dyHujCIU3XKTwjy2FGk3nkBuLFP89EBl8BZ3CIKicX2T9rYjOCKftZUBH/zRRTOiLX//bAu8wYlsS2PYJcu/RUJRo2qetDvuEIUcTiWDnkV2KVdu2J/LT5IfKWQkrnQA+Qvz636tUNe37yqUksA9y2DO+SjwK/BZcIivJmoFfPgcJUmlrD8a3/YsYVW0uVGn/hZDj5EHHXn6u7tYiVGUU5pOmReZxlgcnxAGfAzaSkDWjuNCdZNOjRq0iQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(5660300002)(36756003)(31686004)(2906002)(8676002)(478600001)(8936002)(6862004)(6486002)(52116002)(2616005)(86362001)(4326008)(31696002)(16526019)(6666004)(66946007)(316002)(83380400001)(37006003)(6636002)(66476007)(66556008)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bUpBbnZzeEhxd0ZzdnFNMlNtb2tmUWFFQXF0TmM1LzVNcGxQbVE3RnBaZzRl?=
 =?utf-8?B?bFZDRzNVdWNYK1EwVVM4SkZXSTAyc3M4K3M4NzZ0TjlXYXhhYmtSd0lmRlVr?=
 =?utf-8?B?Qk14WmxIRVBXU0J0WGNxblVsT1lZN0h1TTFXM0tYMCtXVzV6amRGMXdlV1R4?=
 =?utf-8?B?Y1FFVE9rZ1dCMEJkTjZuaEVUNGdRR1BVVjFEUHZjeERPRmVkTHBhS043OEZ4?=
 =?utf-8?B?V2xJY1E0Zk9uTGhvT090ZndmNWJwUnF6Q3dxbi9vNmd6RC83MWduSGVYbEhJ?=
 =?utf-8?B?OXZuU1JueUx5aTZtOFMyaldOQUpVY1Q3T0M0OUE0UlpnYUFHYlFueVRTTUYv?=
 =?utf-8?B?THFBMU5GY1JQNVNvNFRMQndjNHZjSktYcXFadkowVjN3bzJDS3ZuUGJWSTM5?=
 =?utf-8?B?Q3lyaUxxSWZaSEJDTW40dDVBOVVSTE1KdmJlWDlWNDdjTUYvNkpVUGhFbzBL?=
 =?utf-8?B?c0hkOHBmN2tnWlZnTzVEcXhnS1hHemlUWWEyT3FQOGNtZkJ0VzBvdVBkSjBT?=
 =?utf-8?B?alVoK09LbWdmSjF6dE42bk1yTlJ2SnRDOCtVV29YMnpsQ2NNV1pWMkhOUEZ4?=
 =?utf-8?B?clRYOFppUXB3d1BIZ0Q4NmF1RjRoRDkybzI4V1pCVFpIRGt1cnU3NWh6YTd6?=
 =?utf-8?B?akRqMDdUOUYraFVNbk00ZDNzTjVpd01ic3BxWTBENDFNVWJlWVJVRURta2tQ?=
 =?utf-8?B?clcwYXdZQitING5KUzhIMDZKV1VHNlNpQ3RhZ05XSUFBcE9JNXZuem05TjZI?=
 =?utf-8?B?MVIxN1BERWN2ZVpmOXkvOXlDREg0SlJaQ2l4UXg3YmZYNE1nOVE5Q0pGdGtF?=
 =?utf-8?B?eEx3N2Fibmh2dkJ4V2RXT1dtVU5MVlEwTS9TWHJkeXJhTHlFNzlLOHJERjg5?=
 =?utf-8?B?T3Bod09oMWhyL2ZwRDRsR0s1MDlIdFRUOC9tQURrMzhQTWxwZU5Ta3QycFhh?=
 =?utf-8?B?ZHNNaE1wWGZKVlJyVjRuV2NpcUw3OUtwMDg5Wmg1K2lFWjgyVTFhNDRSMGFu?=
 =?utf-8?B?SHJvdjZIUU42V2R2S2xDMnNSbldPdFdkM2cxcWV0M2F3MW93MnNlWnJWc29D?=
 =?utf-8?B?ck5pT0IzN1NlUThKejJocW56RU5CbWlhbmhYeVRsZFdrbmdSOUxkTm5qYXl5?=
 =?utf-8?B?ckJtVTBmSkV0Z3ZjSkl3dzhEZXIvQ25zeUhpa0tpc3RDdEdTUllTM3BuVVFJ?=
 =?utf-8?B?N1I4VDNHLzZNY0FCUGZuMkVaTEQwaDlSNGZDMFhKdHhuSUh4MXc5RitmdW5o?=
 =?utf-8?B?OVVBRnYxYVJuYjdDUEdLckVrRFhhN0FTejE3UUFicnJab1gya0ozZWRsZUJl?=
 =?utf-8?B?cnhTdWVyTko2RzcrcG1rLzYxcWtQVzRmT3hHYUx0enZCZm5qRVhZcEVYdXdp?=
 =?utf-8?B?RjYvWG0vY3VDMWw5UkdyMDhPU2dqdmtyb1FRN2svekVqQnZMWW8zUEpYZG1H?=
 =?utf-8?B?OFMxTnhrcEVsZTZVcFhiRUZSU3dZczRSZE1DWVpUZ2JTVG4xNHVCeWI5WFlo?=
 =?utf-8?B?anlKNmNkUHVSMjR3VjNjeVFwZjBqdndsSlFUaDJKYXNHSDRMZmhxb3FsaGxn?=
 =?utf-8?B?UnZ6S1dWSGt5YnU5QUpjcS9PYWgrb0dpNEhGajdUZkU1eXRnVHFza21qd2pS?=
 =?utf-8?B?WlRSR3JiWlhmbTdjMDhFTXh6UXNZVHNPaExWdkZIM2p3ekpIcjFEelJNQldq?=
 =?utf-8?B?QjdHTWVBZzN1ZTV6MHl4M2w0WDN2YlZnRzdVRUJVYWJ4QnFFWERNaTBwck0v?=
 =?utf-8?B?RFo1WWxmU0I5R294SStPdVhqTEFnVU5RVEM3dWh0MFNzZXFxMkpDU05CNHRy?=
 =?utf-8?B?TkIzZVA4SGRBeVU1TFRFUUdwWjY2aEZzZkJ5M01XWFJwWTg3Mk5DeTUzVS9v?=
 =?utf-8?Q?fJP1Cf0SzV/2A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8ffe46-187d-45b6-fea4-08d8e25dc4c6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 18:12:43.9163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fF5wa5lv8pautZ91XtsqXrpOAMqvKXhswHRCBU77lwZzbtcafDI5IGDwbBUKCog
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4816
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.03.21 um 16:37 schrieb Nirmoy Das:
> Allow allocating BO structures with different structure size
> than struct amdgpu_bo.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 9 +++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 1 +
>   2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ac1bb5089260..d32379cbad89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -543,9 +543,10 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>   	if (!amdgpu_bo_validate_size(adev, size, bp->domain))
>   		return -ENOMEM;
>   
> -	*bo_ptr = NULL;
> +	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo));
>   
> -	bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
> +	*bo_ptr = NULL;
> +	bo = kzalloc(bp->bo_ptr_size, GFP_KERNEL);
>   	if (bo == NULL)
>   		return -ENOMEM;
>   	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
> @@ -635,6 +636,7 @@ static int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
>   		AMDGPU_GEM_CREATE_SHADOW;
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = bo->tbo.base.resv;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>   
>   	r = amdgpu_bo_do_create(adev, &bp, &bo->shadow);
>   	if (!r) {
> @@ -669,6 +671,9 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	int r;
>   
>   	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
> +	if (bp->bo_ptr_size < sizeof(struct amdgpu_bo))
> +		bp->bo_ptr_size = sizeof(struct amdgpu_bo);
> +

It's not strictly necessary, but I would prefer if you change all 
callers of amdgpu_bo_create() to correctly do this instead of the check 
here.

Christian.

>   	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 54ceb065e546..8e2b556f0b7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -40,6 +40,7 @@
>   struct amdgpu_bo_param {
>   	unsigned long			size;
>   	int				byte_align;
> +	u32				bo_ptr_size;
>   	u32				domain;
>   	u32				preferred_domain;
>   	u64				flags;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
