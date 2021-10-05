Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72D4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 17:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD66610FB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 17:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7AD66610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EEC6EC02;
	Tue,  5 Oct 2021 17:45:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627D96EC02
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 17:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE54d5THZHQlqDXfAlhEkV3FvGH986dn643Hv2NDsjRORGLw3SKDFAq8uCNfihoAIuvrL2t2W7uUzmqtx/ZdfaiGRIKj9KDzoLhjX3ANIy+iS/Txr6r99PLXozuHkSLx8K4GJ8Zu2FdC4dMq7KnYBl2jtsUwsk7BkYJxhkmzV7wuoTC8FL0xEHMOr9O3+qzenmLg9eGSdvRKmlwEj7zOLUZPrKMn40+DAgh+0CLXj5/wvzFNlzW+t+NALoKezT8O0bKShrYedJQBv4I+LICrCm7Fdn8j7jvnU5B1YA3Bd3GmINweXYjpXJrV4QPgM9ru8fC521x5ep2jKsHxXYxNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKVkKpQ3R08+k4kGzsdOR69PRkcVYV9x7jypkMMgDsQ=;
 b=j9wqu8XdWg8iSvh6Oz1pWOwKjI9uECxXakeuT9zZRe+bhv94OWY3h+1zl2RloIIcf1x7752sXDkc8/4zobjtQiQV+62fFC36ba2DKdGOfuR7tG6heL00jcetinF0Z2oE19iqt8zX8a65doYAQPGBZQypUkHFxwMjskoA1U4COtWEzjF6eS7oVsJNJBEmke3dFA2gbqfkowcOOIPzCnmKthKZD3GYAx7W1ohLp2mhDHjEn6akR9QC4lws/V7ljC7IQ0R67rX1JuB/aZ92VRuJ+AC3ez1H3rR4WriM6/p89okDvnyTjVvwrrdFlVsbKl9h9V8pAslRb0AirUdkem2mXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKVkKpQ3R08+k4kGzsdOR69PRkcVYV9x7jypkMMgDsQ=;
 b=cPjPDhgLi8zuZN7KFOOcA+FRl4gbGf+o+3KgEFVnMNhCtlA81OBM44eEKU0JsSwbY1gepMBNTeIzSA/MBk4H8Dr1xIpyIzRXFtDm4M3R55pRpbD6lQwP7t2p6ALdCLO03+FzitLjnQgrK0GKByBiXrkuX2lwJnPiyE3FI7YSQS8=
Authentication-Results: emersion.fr; dkim=none (message not signed)
 header.d=none;emersion.fr; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 17:45:40 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 17:45:40 +0000
Message-ID: <20f3da02-7b70-1681-1621-7c389f23829f@amd.com>
Date: Tue, 5 Oct 2021 13:45:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 2/2] amd/display: only require overlay plane to cover
 whole CRTC on ChromeOS
Content-Language: en-US
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20210929190603.48890-1-contact@emersion.fr>
 <20210929190603.48890-2-contact@emersion.fr>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20210929190603.48890-2-contact@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0413.namprd03.prod.outlook.com
 (2603:10b6:408:111::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.46.98] (165.204.84.11) by
 BN9PR03CA0413.namprd03.prod.outlook.com (2603:10b6:408:111::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Tue, 5 Oct 2021 17:45:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d88299cc-cf23-4af1-1a15-08d98827f263
X-MS-TrafficTypeDiagnostic: CO6PR12MB5443:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54435809599CB8CBC7EF92858CAF9@CO6PR12MB5443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qifrLNEWOyenTE/XW84+5wsZv1amnCGiYWx6QAbOq8d/mEdpYnAMf6pGZEqH3Rto+Xo2YJwauaoqqYpaXfhI51bX5EHTTcA3SiQgjhNKSrC7B7ACAT0kCsHAhqTPS/8BjrqQbarpTo7ORGcKy0iDcS3x+aOAyncvoLve8aa6CPIablYalc32PYXuOjFxvHeqM3M8zTK81QJyfzVlpn9DOIJQwK3kEOULE1NrPo2kCpqavzuHLl9Km+sx2nExIUKJSITKNmd1SbeaSgT9of5MDu+92Yi8dwNgFY6W+mBkv2BN9a0bFL4RLI9iT0s2MEOOs0leyyA/RXf1ig6K0CrGeK7mYRkE7rmJW7kqsK1DihJaIQbzw2Byzvd6tMhzpnZRoYgD9FgAGOlBN8/eYCFoz8Y+SLMIBnqikBxoYDLVUYKxxuAbcHBTKMiHbWd/jojG2lRk/MYh64fQa+Iax+rcyC60Dc7FdmVYsaWo+N5EHSInmCqbi5SXr45R5sGfW3T64mhiJ6MBaNQsACWIjMlAhBtj+MRiscB6CmDiFLaZq/N//CHpIOtk87cbuS8e081VlAedx64/9OJpAN4WiKhuyJksNCrFWxx4fQd7Cg7PVe1pcsX/fJitZNyTQmCQKbobjaUYGInqcxDD0ATpv9tWiRh6NoC7hBiL4A/U9hlGunWq7PTs77O31rJIJ91QaPJghIIN7qMqN/0r3t3VILRDcJXyp/y+QNJ0YSnZGYF0WtYsNBNSyb/bW29lvFDkilObgSXJqzRkbNm0IK18TVDUQPnHL5Lj8/PGFbpdgem8CKb0pS9lpN/qoCOVwVyEFus0JHXdf8uYiSA0dVgZyGNQgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(36756003)(5660300002)(53546011)(44832011)(31696002)(66946007)(86362001)(38100700002)(54906003)(316002)(16576012)(31686004)(66556008)(66476007)(8676002)(8936002)(2616005)(966005)(186003)(6666004)(26005)(508600001)(6486002)(956004)(83380400001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVlRbmswQkxFMStFdk12RVdzUlQ3SmRHSVpRZTZJVXY2MS9BZlpCSjJtMnNa?=
 =?utf-8?B?ekxBNzNxU2ltTFc4VjBJWEMvQkwwdmlVME5YQXFkMklqMnh4QWMraUxycFZa?=
 =?utf-8?B?UDB1bkNTV2hFSnB4NnBVeXBHWVcrQmo3UXdBTTB4N3BqaW05YkJPQ1RXUkJm?=
 =?utf-8?B?amRtRDdEc3hWcDFlRlhlOHZ4d0ROTFRFYnoxL0tidy90VWcwcmtiTzlnVWIx?=
 =?utf-8?B?Nkc5eXk1L1BOK0pzSWFjVjVURnF1di9IQWpjdFg5T0xMVGs5QXR3MDUyNE9x?=
 =?utf-8?B?SG5xWitlUEtOQVdYWUJBck9kek1ELzRCNkdqbDk2S2trbll6cUgzWFN4VnAw?=
 =?utf-8?B?b1hYQkVSY0dSQ0VocEFaZWNPemg4SllOa29KanVzcHB2dXN2V1Y0dnBObkJE?=
 =?utf-8?B?TStKeURHMzV1NjR1UHUwME9lOUJxOXN3QlBPK1FxZUxDRllNMlV5NGZUUUVB?=
 =?utf-8?B?NXNobG90YWltZThLTDdBZU9TNFFFSkJ0OVZPT0MxRUlxakk5SFE4eGVMM3cz?=
 =?utf-8?B?d2lIM0ZURVFKelRyRkVQS2M2aGNmT2ZraEJQZDZ3ekpGeURRNS9rNlRTdThw?=
 =?utf-8?B?MkNQVGs4VHVZMHRNY2M2bGNjS05TbGV5SlJhSHdBS2RySGsycEZYTnc2L0ZY?=
 =?utf-8?B?aWpjbUIzN1hicWt1WDN2TFk1NkVYSldWWGNNL0o0MWZQWXEyWjJZdDdSQWdO?=
 =?utf-8?B?ZjVFUS9NT2s2cVNxWHM1TFVscmdvVFRxcjB5bFBhSFBEcThUOHBvU3hUbEZI?=
 =?utf-8?B?Z1BMNnJ3UmlmdzlBWkg3QjFEa0tINUg4OFk1bFUxdW9vKzgrb1BKVHN6d3RW?=
 =?utf-8?B?U2RrVHl3TGtPeUZtdnpReGt3Q3YwTllrTXU5VE91TWFVYm9RNTdmNTBUR0hn?=
 =?utf-8?B?YWx4VjVZeHNEZVM1QzF4eVF2SHF2cnM3RHFzYWhRZnhmbVBHTjRZRmZTWjRs?=
 =?utf-8?B?S00xbUhXeGlsY0RvYzRZUjRYNmZXNGFuamJpc05BdXhlVitXZjdOSzZmak84?=
 =?utf-8?B?SDV1MzhIU3MwSmhyZ2V4ckZUQk5wT09tSkg2MSt5Nmsvbm5OL2VwYnFJamlO?=
 =?utf-8?B?K3h1dzEvZzlQTENLWjRhRDIvWlB6TmN6SmNDWGd4dW1oUWluaDExRm80cVlB?=
 =?utf-8?B?YldIVGZGVy9vWHJlYzFiNklHbkgwRG4vVTZVS0ZWRnA2Nk1zamtqQXk4NkpP?=
 =?utf-8?B?aFVDVGZ6eVZUY0VuTEp5STdlQWdFSFRWN0U5SDVNUDFPdFd3aHZYZmFoMDdr?=
 =?utf-8?B?OENvQVpTdkt5WWkyVEhWd3NYc05obGJZWDhndnVTNVl1bnZqZUwwcXliWUtZ?=
 =?utf-8?B?bnhZR2hYRnd0Y1ZLclVVd05CREg1S2Z3dC9sYjF3WXZ6bUx0bEUyR0xpd2xJ?=
 =?utf-8?B?VlQxQi8ycEJ5NmhKc3ZGWjNqaWJNN09yZTZvSyt2YTBOa3dlQXVKdXZqUmxj?=
 =?utf-8?B?OXl0ektNaGsrNzZWYjlBRnlCRzdOdXhnZWtzS0c3UGNKd0VlVkgzRHdKWVJW?=
 =?utf-8?B?aFAwMnR4Z2M2eTNjZ0lnUlNkNWZzY0w2TmVaNmM1Tkp2VWp0a2hWUU5LMlBG?=
 =?utf-8?B?RktHS3Zsa2FGaWhHU2xxakx5Y1dCQnBQem94WlNiNDBZdTExRjFVeGU4V0VF?=
 =?utf-8?B?OGNDdUxvK0RnbDBoM2Q2dWhrdjYxbDViNGI4NUxHaWh2dXBhVGdpbHRHZDBx?=
 =?utf-8?B?cjZPMUFHbXladENCWitQVEsyN2dLMExvaGw5ckpKRWRLQnlVRjBVdWRSeVJL?=
 =?utf-8?Q?QuzVXOzYHBZdXiOhh9zbM9gsN4arRaLSxIAML7y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88299cc-cf23-4af1-1a15-08d98827f263
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 17:45:40.3907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m06jU4qpKGquNes8hUOssMpPPO3hQEjvUtxKXCLBPcNOKUEmclHNyI03+V9Fc7iu2m35HAiwa+Q5t9uz8Ff0Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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



On 2021-09-29 15:06, Simon Ser wrote:
> Commit ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when
> using overlay") changed the atomic validation code to forbid the
> overlay plane from being used if it doesn't cover the whole CRTC. The
> motivation is that ChromeOS uses the atomic API for everything except
> the cursor plane (which uses the legacy API). Thus amdgpu must always
> be prepared to enable/disable/move the cursor plane at any time without
> failing (or else ChromeOS will trip over).
> 
> As discussed in [1], there's no reason why the ChromeOS limitation
> should prevent other fully atomic users from taking advantage of the
> overlay plane. Let's limit the check to ChromeOS.
> 
> [1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8hQArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=@emersion.fr/>> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when using overlay")
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6472c0032b54..f06d6e794721 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10590,6 +10590,10 @@ static int validate_overlay(struct drm_atomic_state *state)
>  	struct drm_plane_state *new_plane_state;
>  	struct drm_plane_state *primary_state, *overlay_state = NULL;
>  
> +	/* This is a workaround for ChromeOS only */
> +	if (strcmp(current->comm, "chrome") != 0)

current->comm is "DrmThread" on my ChromeOS system.

Harry

> +		return 0;
> +
>  	/* Check if primary plane is contained inside overlay */
>  	for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
>  		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
> 

