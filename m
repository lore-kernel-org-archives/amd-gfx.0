Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09225606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uk7tJT/j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD8410EBA6;
	Tue, 20 Oct 2026 10:55:48 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011032.outbound.protection.outlook.com
 [40.93.194.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5AA710EBA6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 10:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gze2vS5IHJzj/SAc1rs0cMzYO9ANv7GC9+ix4JBGHfbp8T5nN1coYnk9+IqK2bSpSLuYdniEMZFXLViaSZfn97Wlqddi8oRkwpMwLkqfJ8cgzVhn339bUPUWkHKl129Nl4lLwwRiaWAwu4clhvctQB0FntE02QMA5c0bJwYLTA7bnqyPyqa9x1y0MTclt76Gq5661Z+fRF08aHDNY5Lwfe6AcwSZULxGypjDcKoPa69BWmPbfOZ7Imk67TO/CzcuWqi+cvsC4e2WKmDUl38srKE7do1CH0KssVYvFSTCSPqqWa3RIsSzHs6t9d6gxGe/9Vn/4O+H7wjLu/xyfHccoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0RpGXibtF0hB5Kn7i7oJwLlEuq05cSLMBuoFw/PhSk=;
 b=VFcqGAn5M0lwUAoV2zEofb4jg1kxHyP8FV36RIquNaFS8nlNaxGy01NucrrJauqKPnaDzk4v05TFmxzCH1M0YoQRjL5tSL616aSzIL+16aQ7kJfsr6h2IXlRhrl3wkDGFlsRgZkw4Sgbv0bveNw7YRGdXAJfh/DrD5bdZKcOXardg3RsAP5YvzPSPKwJzYbictPVFeFpWbLzF32atCOGYsmot0p3rBiw1/BzyooBKBCOa7TNKPcwXeExuHj+d6BOTnBhq/ZyLgbKXDueujb6ep8PVJgE1jMUNaG8jn2RlS39T1DyGVUcbYC4jtQdMdp0qYPJWyJevhOQ1iqXNwIw1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0RpGXibtF0hB5Kn7i7oJwLlEuq05cSLMBuoFw/PhSk=;
 b=uk7tJT/j/qtt9+QjihrPbdCzByC+5jm8ZMzaFA3r8CxxU1MNC4Mni89x+F8aZLkNsXu7WfcCoJRPbRsHxFUXx0QWPSBo6wD/kLi1tufPZE5ub1eO/8aEvxHoqXgBAZiTWD/7dkA0j+g0RefEZ+I04yZJ/g8+NVGMOzbsffRk1xY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SAWPR12MB999116.namprd12.prod.outlook.com (2603:10b6:806:4e4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:55:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:55:38 +0000
Message-ID: <d6de271e-ef65-455e-b778-42a8066113ed@amd.com>
Date: Tue, 20 Oct 2026 12:55:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] drm/amdgpu: Check correct field in
 amdgpu_ttm_tt_is_userptr()
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Felix Kuehling <felix.kuehling@amd.com>
References: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
 <20261019130159.11739-2-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019130159.11739-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SAWPR12MB999116:EE_
X-MS-Office365-Filtering-Correlation-Id: d1af1278-8ac2-45a3-2274-08df2e98acc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 1gzYGsOsdUXFbMFIDitcekhfkcev4r3P/Fgmg6yZ0hnVp75WT+XEhISmQjYS+kEwnfx49SZryPzWrzOg3ii6964Eq39pxSTNxyz0gAxvxhTljuxUBNEnpWExFjBd49uk0oGp/xePgf8U8RlPQYzeiKsji01jtE5ikLN2OF8MhdsaoorCc0AXSxNKWPsmKJTYOvhuR6j+mkuVarqFsr32MYZvJBvKj55wejF45adKPuINmWnMK0LO402bSjVDkz4ueF7hO/d84Ff3xiMQWk5HhF2fClaiO/c/6Qi3FT4fWjELFhRoZAZRGrHFJYc9SOOfoPRyswqntyWmFkrKnpwqKj9mtrvCYRYUSL7tkGnWb6YjESNWNYichox89erP8LzHqyLr8utTgLK0wjbh4GQlgXolKz2U6hmz9r4KoCr3WD0YKuesjuWh6F8pBy2PAwH4F93sNp8577r+d5yXAp8zlV2osqmIL0/F5kdsLmR6iVPCfbnYCCjeXe+fTjfAtlLYXz8oyPV4dclRE1fvQd5NGmVNNtB0W0eTNEzZky88mQ0bf5wQgQ1uOTWBXJM+3LJC+6oXkyBwGTpysTkI81svFZU3z4p2NVtI+FNRgb7Ara4wltmFBV5+uFAXGi10CQv7iNY/a9bLavUu5dhcLO54Mmqcf+iAPAWddWxAv1vEV50=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0NpYUk5aXZlQ2NaanAzaGlNNnA0aXJCQUZ2QkRFczk0Nm43NUd4MFJ0WHFJ?=
 =?utf-8?B?WkdkRTZ0aFY1alFTeE51dE9tT1NyNC83RGF4NWFJbFpSak0zRGdzdlVtcSt6?=
 =?utf-8?B?dUVEMzBydHlNdUNNMU9tbmpXR1gvWEgzaXhvZEdmWm5URjU5empBM2YxWlRK?=
 =?utf-8?B?U2xySFplSHBFRGkzeGN2K1QzSlpIcHNDRm00ZlBQbmk2SnZaeGRIVzBvemll?=
 =?utf-8?B?ellodW9YUm03L2RwTnl0ckt2VzNVVzJVZTV4bkptb1NzbDZLUjMrVzlWb05I?=
 =?utf-8?B?dC8wSnJKSDVRdlRCUGZPT3JMZkQvcCtBMTYrYzhsc2VKZlpaeUpJdDlNVzFI?=
 =?utf-8?B?UzFZR0pvanJMVHBVYWQrREZsRXJjZVpqWFJRZE43YXJ0MUdQc0VmMFBDclpq?=
 =?utf-8?B?SnlrV2VZNmhWTXdyN0lWR29BQ1pHNVlzNExhVHFZTHJQMUZacmsybUpLSmtX?=
 =?utf-8?B?MDFoUW95bTF5R0hqQ2tnVDVuYnk1djI5STJtY1ZPSUJPZUkwOCtqc1Z0aXlO?=
 =?utf-8?B?aFNjUlUxb1BETzdiMnlwVGlTdFVpVmpYZStMcVFTWnlWVVJsbDJ6d29VRk9l?=
 =?utf-8?B?OEFvcE9qcXRIWWd5aVJZVm0zcnkwcDMwdVA1S2ozS3RwVTVTNnFOa0QrUWE4?=
 =?utf-8?B?S2VDTWhvdFZPaHpSMkVUc3JnTllDOFRzTGVhMFJHK0lzY3E0SjUwM21MeDc0?=
 =?utf-8?B?UE8yZ0NwczU0citQT2NYQmEvZUsxSWRNRzF3MFBsTDdtTWQ2MjBoRUNHN1Mv?=
 =?utf-8?B?UWZmN3pBM3pBZGNqQThLQzVjK1NtK0lNeDcwLzIwMk4ybkxMNUQ3VnVaL3Bx?=
 =?utf-8?B?S2gyY3dXb3FhOHRWUGdHRHZWWXdPbzlwWWJnbVJRaFd6THBHajd5MFFaeFlG?=
 =?utf-8?B?N1ZBdzBvb1M2NnNGaWgxdkVtVVdZMXFCRUI4Z1pLQlhreEhUSFZGV0dIZnBo?=
 =?utf-8?B?ME1KVnZ3UnQxYXI1WkJMYjFKcjNrMkYrdzRvMHptRUR3dkJJd0p3QkpWL2w4?=
 =?utf-8?B?WGNiRGVCcHd4MnFEM2ppQWZGVjJ6L2hYT2RpZFcxckJteVh0QVZIRy80Rk52?=
 =?utf-8?B?cXZFeGlKWGxOQ3R1Q05hRDhJdjkxa1pJMU11SHdZSVJNaS92YVA1dnBrb3BF?=
 =?utf-8?B?Sk1JMmRKSkNUREl6SU1iZTZmT1QvejNwbWtBQVFOdXVkaDdBRFgvR3ozRE1v?=
 =?utf-8?B?NVdFb2hpcXY5UVBjSTFLZHBDNVcvTVI5czBqWFg3UU1US2F5dGpINVpacmtK?=
 =?utf-8?B?MUhKWWNlY1RiSHFaQklJeSttY3c3TDdkQTArY0dPak43ZnVZUVpUWlhqOWh6?=
 =?utf-8?B?L2JHd1BlMVZzTS9yN2JkTHNXMzVzK25CWktENEtPQ2UvRzRsUTZseDM1Y3dp?=
 =?utf-8?B?cGZ4eUcvZXJHcFljNkxBSGhzelA0MHprTzZLTDBDdUlPTGk5aEYrRkZvZHd4?=
 =?utf-8?B?UlFVVVhDMmdLOXJxQUE1RWNhRjhoWWc4eU1rZ1lZWG5iV3FoSFlacjV1bGJW?=
 =?utf-8?B?MkNXcDFDcUxqbHRHVlJLNHhDZ2xocG8wQ2dtc1lWOXBtcU9LQmhVdTZYWkVu?=
 =?utf-8?B?aEJWajRXeWJ0d0xMWDJlQ2ZqTVZIVzJ6cGhhWlgxY1VZUHFYUkl1R2JDbk5s?=
 =?utf-8?B?NGZTancrcEpPWFpQdHNoMjJzWTh2eTJieVR0NmlxTHBSTVkzcFpHRVVCWjh6?=
 =?utf-8?B?YmZOelpEZitRVkRFUmI5eXd1blpWMHE0L1M2eFRwRGRGcnBEQU1mYXQ4bUlO?=
 =?utf-8?B?d3JWWmhtdjI2TEg3VWpwSXhpMnJXVFQvQzE5Wko5UUl1b1J6d05aMW4zVk0v?=
 =?utf-8?B?YkxFb0dJZGlDTkFQNFNjK2JsdGljYTRmeTJIMi9oVFdsWDhKaTBQblM0aXl2?=
 =?utf-8?B?VXlSSmtEVXJTSmlpUTNXa3pNSS9ZMytHZmNkSVUyVFlEckwvaEJReFNiamtq?=
 =?utf-8?B?cllZY3R4citSRktHSSt4TUxhSUVTWXV4K3JybzhMdkF0eHN3ejFIcU5MS3JQ?=
 =?utf-8?B?WWE5UlVjYkpDR21hdmNBU1llSWtHQkxFS2tidS9sYmtjNkQxQnVMbkdIanE1?=
 =?utf-8?B?UnA0YkRmb0NUbnJNM2hxSzVuMjNIa1hDMC9TV01jUzExVEdia0QzM0F1aDg5?=
 =?utf-8?B?ZjdWb1ZTdGJiTnM2RitubzBZa0VlQjRUdE5scFdldWZrSitITU02QXJ5bXdq?=
 =?utf-8?B?Z2l1OFNwK2ZXdUU5c1VnWlRCNE15ZE9XRDJVZUtKdENSQWw3UTJlTUlNMHZV?=
 =?utf-8?B?akZrcUVhOGNrZUZzdnU2MWphTkY3dFFqOUZCazRKU0tPSnBMWmhXUW5nRmdF?=
 =?utf-8?Q?Zj56i/LfiEKnX6Hmmd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1af1278-8ac2-45a3-2274-08df2e98acc4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:55:37.9841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YH9sl/Rc3RC+E2ixTdvb/pEDEe/j1JXGLO0Q7JmdUg7UuRQd7l6e0NiQPfSjG2fB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999116
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 15:01, Tvrtko Ursulin wrote:
> Presence of a task is a better indicator whether something is a userptr
> than the address of an userspace VMA.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 8f0720a77520..8acb12da6e8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1416,7 +1416,7 @@ bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
>  {
>  	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>  
> -	if (gtt == NULL || !gtt->userptr)
> +	if (gtt == NULL || !gtt->usertask)
>  		return false;
>  
>  	return true;

