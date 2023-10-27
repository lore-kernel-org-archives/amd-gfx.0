Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14500C25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 21:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E7F10EA54;
	Fri, 27 Oct 2023 21:25:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB55610EA54
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 21:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXv3hzC+zHc+ADWqN2fBeu+zcPqQR0500UwaBDEiD1l3+MlkuAZQCQnb21fL+t0DEZYc6a/0Dm3tqYgtSfnCBAZsRB8zRvELBdfCmkERqE0xpBu+Aqd/GhCk4Uy0wpbkRWuQFEtOCA6W1sjiYtVSTcca/llMtFqQsKO/pLlP62QkcHW2dlAr2BFInevu3t9oD2r6gX2iUbewt0ATlgFFbe+R29MKu709ISCVnO2vMVynKJU+0OBvVLvBhOO7pj6WOPB5VI+LS86Wck2uJXB5O5jilqymZt1QLiiqfAZRWtJf+dKemANfrJDG/hsJ7tCRFNqQXATHnauB+YnuTVQJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/CMEpHT90UN7ANe7bLYGPNEbgBiHEiFnniFEQXJhGw=;
 b=gBVEE3hS7QezHDnvG6O/rLOco79kdqRbHYun2EOFdiuI+ZYcGD/NEA6bFcBkBbRpTSA0+PbSEd6eiCG/Yp64wziOFp0QXUi8XrhzS+dupZaXTcbnUKaWi3gs67tKuKFh5HvQ9qUTKOEwBiwDy7J5EKMIMduI3LskgveF+1skStGMNEVGFdWJ5306aRWfKTgMGSbNxS5H94WVMEGLraEMTsfzPz3XdbUgwMCzoG3yN3e+jvReoErJNGfiiKrZQEmYZzCe1crA6rOSgYkyn1auy8FWhmbJ9YPq2gOgZh3CUyy6uSTayZqGim/UZfafCPYKcDVvs6uHBIcJON4+X57vhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/CMEpHT90UN7ANe7bLYGPNEbgBiHEiFnniFEQXJhGw=;
 b=UC2sQBzwmcMCHLtHcCcKvMwIAwNcxaY+eCSsOqtW0mKtQ8JVs+Q5DrVSSoiG6QHGhbss5VIhFF6IFIHYUfKP+WbaLUou8Y1hinwolRWPL82GMeUz1TLfvVpJ9iky3ng8M1tHxLxNjMqPy1YN0S52lvra2y+ELsyXoT3B/kEdWNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Fri, 27 Oct
 2023 21:25:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 21:25:13 +0000
Message-ID: <4147692c-0866-4166-88a1-ea8a6c926b13@amd.com>
Date: Fri, 27 Oct 2023 16:25:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: drm/amd: Fix UBSAN array-index-out-of-bounds for Powerplay headers
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231027204148.63090-1-alexander.deucher@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231027204148.63090-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f40460-36a4-4efa-b954-08dbd7333511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9fkY9nBdT0rXwVtrTzAYfHjYbVYAMFBuApY+LvNOCDJPq+ETgk8S7GopLBMrYdfRw9jzoHyCRMSQ2/1KpybUGQ7dHuOV06Elm53OJC7MrxOFvEEAIacHSfKwREcHnKQbu8hBWKb91vFIQJlOE+nY6L3w4uEr3jKJu2Gx4Nc9BTK8qMMAvYvwLRkzBw8CRs5at52BOZktBSP7/iqjbAZQ/Mi2ajy7iwzk6GI84dhvtVXdB3vAafsGtH1y4oWzJ9JjmrVrZMTJWobe1FdI9ti0xtOALMLSkC83zBlUleSJBNvUKpIXRNxmWhfLH0oq7Pt66V0Lq0/BmdbOMsaIlqlx7b96Z84T/L56arxYq94oTtpKP1Qkr6QvrRrGJGqxnLwW2aZHg4S+kqSp6cTezllfv00JTaFnE1MbQxajhGhWhVGs66qUhJ0NvXH/soG9TXlOKqLLqn5XOfnJkKPsPQboDRX+s13Ti0S2haXu7rlL1dkB5uOd/4la1A6XNnvavU00DTAAQyVkKNPsJIDJWfRuoY17Ux6k6asA5YLbbeivaedEECgXMEGIxqwnnHi363MwemQJNfD+RMCYK5erKVXQq6rYpHR3ubXnc1Lz1yituHj7E4+uARNXuahz6Xay/9vetiBrY9Acy6VM741frUobA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(36756003)(86362001)(53546011)(6506007)(19627235002)(6486002)(966005)(2906002)(478600001)(26005)(83380400001)(6512007)(2616005)(44832011)(5660300002)(316002)(41300700001)(8676002)(8936002)(66476007)(31686004)(66946007)(66556008)(38100700002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUlkTTg3eGNaRDU4U3NtV0QvOC9TL2lBUkxmK3VuL1VKQ0swemZVNTMzVVlT?=
 =?utf-8?B?b3dFeXBQa1dZY21FM3pUdzlFZWhrMmd3Q1ZyL1pjRFZ1T2gxVkxmZEhxOTM4?=
 =?utf-8?B?THhDbUpqSm5qQXh6aG5Ldis1MXhKbmNrL1RPNjM0TkNwU0pCalRjRW5tVG04?=
 =?utf-8?B?QU5Wa0FadUZDQXN6YStMWlBRUTJTWFdrSXZubWNCN2pWTnI5amZrU3pHTzkw?=
 =?utf-8?B?U2piV2FOMHhKa29aWDcrcEgwbWsvbkZzMHBnb3BjbStaR0c1RFhJNE1UT0ZK?=
 =?utf-8?B?M0FGRlFZalYyNVB6L0VkV3ZsbDAwZXkzdHQ4eVYzZGZBQkNraHZxUWYwNlIy?=
 =?utf-8?B?RE1JU1h5dHY4dkN5VlpZUlhYdDJlRUlJclk0QW9kTUlUR2pvWnk0S0pzVDFr?=
 =?utf-8?B?T3dzQytQQzdOVjc1bnFFYzIvNHcya2FDaDh5Qlg4VVBsQTZRQTczclBHWVVi?=
 =?utf-8?B?cGxXNWRSb0VSL29rRjJYdnFxZjdUUlZUNVRLSXlKKzJUYWJtR1ZKOEd0M2t5?=
 =?utf-8?B?cjZ0ZTRLa1QrcWE2ME9VajAzYUF2djhlQjhpcVFRRmVCeXlZdlF6NW03ZGk5?=
 =?utf-8?B?LzJkck5mOSt6OFNKZ2Rua1Y3d3ZNYkQzWjNleWJUcmNacjFaejFyRG1FaHhW?=
 =?utf-8?B?QnZ6R0laN0F1QWVNRkF4RHJBR2xXUzFjc0VHMHEvY3k3b2R0aTFqN05DZnk3?=
 =?utf-8?B?UzFxSzNLbm5sTWV5eFA4dU9KRUJmejVqU2QzU1pGY0c3WjNDL0p5cGpJY3Rk?=
 =?utf-8?B?REtQT3VEclcvRktTQW9nNHZYcURlTVQvcThlZGNkSlNSQ3IxQUpEaG84eUxz?=
 =?utf-8?B?SUdiR3VvVXVnNGhreG9acXRZWXVIdHA2VkE0VThqelJHM1U5OC9QRG42aE1B?=
 =?utf-8?B?dVBBTGE0Wnl1RFhrOFNaaU9zRUE2TzNvMlp4bGZFWXRsWlJmWVpIS3NXY1Rr?=
 =?utf-8?B?amp2SENML3hiVm1XK1ZXSW1FZGEyYmpuQlJvVTUwY3ZZYTFGbytKWXFwekxY?=
 =?utf-8?B?a0tkWFJrb2Y0UDBBcnM5Lzl0L2VsVmt0eFBlakJTZk1LMS82T0ZLMFBnQ1Ix?=
 =?utf-8?B?MnlrWndxTk1vaFY1aExoekRJSFhVdG5jWmVyQmY4dWEzVW5rZ0ZiM2pEZU9K?=
 =?utf-8?B?Vk1VdU5FRnphaFl3czUvYkhrNVNvZi9jMVcvUFh4OTJCbk1TYm5oSWZ6cVc3?=
 =?utf-8?B?WHl5dGRGazdqUFZ6cEJPdG9ZOWNYQStFK2VHRTg5MlNPcXNHdk9VVFJTamhH?=
 =?utf-8?B?MUxZbWgrNklpa1dub1pCbTFIYndkU2ppQi9YZC9JdzZBeXA0ODJ2YmYyZ2VF?=
 =?utf-8?B?MmtYRWhSeHpyWUlET3RhK29SbG9NTVhrZ0puT0N4Q0ZZc2FieDU0cVcrL1Q3?=
 =?utf-8?B?SXdrZG5SR25mN0hiYXNHU0taWDRDanlzSTIxeUFJTUdpVmg5dmIyWXdCWnAv?=
 =?utf-8?B?MkNnSy9zQTIxa05iVnZjSzg2YVNUVkJtbGhCTDFKVFVVU3YwdFVWdUUxdWFu?=
 =?utf-8?B?VkJyQXRBdW9zTC94ZENEaWluYklST1lNWUZMZVpFVFBLMnYyQSs2Zy80TlJi?=
 =?utf-8?B?M2h6OHI4TGFrNDRzdmxhaCtLYUM5WXZ0MzZ3YWx3clFsSG1YUE5STnJGWS9O?=
 =?utf-8?B?a29PbjJTbDlISlNOQWxFeXVDUnJjbWVFdWcrcTZQV1FvNzM2U2RQdTl0Q0E3?=
 =?utf-8?B?WnprYWJYeE8zcUF1N1p1dERzVmoxNVJ4NDZhSFdsNWljaHBSbGtVNkREd2Q5?=
 =?utf-8?B?eHRWWXlSVGZDTWt2WXpkbHhSOUZDVENobkEwdkFTVzI0K3NRcytLRDJxWlpa?=
 =?utf-8?B?QjZkVXN5d0tmYjBVblJlaFNwVU9INkpMVUZPY1JzR0lsaXMvblo3N0pnUkZv?=
 =?utf-8?B?MGRIWnVlNzR0N1YxQXBaaWFsNkwybjFYbldPSVQ1ZG5sMld2cmgzVUFRRkdB?=
 =?utf-8?B?cGEzdGs4WGtWTlNRREFMaVJjUzE0NzFXSE9vakVYeTlRWnZDdXpmMUtpV0cy?=
 =?utf-8?B?RzVEUHZ2U2pBQXBFZ1ZOY2JSQmsxUXZId1RSTHE3dmFvZVNyZUVFK1NHcHUx?=
 =?utf-8?B?Ui9DSzd6NDlmZlBybXpLbEFhSk1sYWl3R1VXUGZHaUlRSTc0QnpLVlppT3dM?=
 =?utf-8?Q?GIohuEgbliFUXnnXgp5yktdsQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f40460-36a4-4efa-b954-08dbd7333511
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 21:25:13.8624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYqTNwH/QJQJBRopFUTKiCWdRlA8zE7d/YPAPt/ZHDjBXtXPJwqXlxmY89VNY3R3zx/dCKp4ckguXeLrakaNjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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

On 10/27/2023 15:41, Alex Deucher wrote:
> For pptable structs that use flexible array sizes, use flexible arrays.
> 
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2039926
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   .../drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h |  4 ++--
>   .../amd/pm/powerplay/hwmgr/vega10_pptable.h   | 24 +++++++++----------
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> index 9fcad69a9f34..2cf2a7b12623 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> @@ -367,7 +367,7 @@ typedef struct _ATOM_Tonga_VCE_State_Record {
>   typedef struct _ATOM_Tonga_VCE_State_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;
> -	ATOM_Tonga_VCE_State_Record entries[1];
> +	ATOM_Tonga_VCE_State_Record entries[];
>   } ATOM_Tonga_VCE_State_Table;
>   
>   typedef struct _ATOM_Tonga_PowerTune_Table {
> @@ -481,7 +481,7 @@ typedef struct _ATOM_Tonga_Hard_Limit_Record {
>   typedef struct _ATOM_Tonga_Hard_Limit_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;
> -	ATOM_Tonga_Hard_Limit_Record entries[1];
> +	ATOM_Tonga_Hard_Limit_Record entries[];
>   } ATOM_Tonga_Hard_Limit_Table;
>   
>   typedef struct _ATOM_Tonga_GPIO_Table {
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> index 8b0590b834cc..de2926df5ed7 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> @@ -129,7 +129,7 @@ typedef struct _ATOM_Vega10_State {
>   typedef struct _ATOM_Vega10_State_Array {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;                                         /* Number of entries. */
> -	ATOM_Vega10_State states[1];                             /* Dynamically allocate entries. */
> +	ATOM_Vega10_State states[];                             /* Dynamically allocate entries. */
>   } ATOM_Vega10_State_Array;
>   
>   typedef struct _ATOM_Vega10_CLK_Dependency_Record {
> @@ -169,37 +169,37 @@ typedef struct _ATOM_Vega10_GFXCLK_Dependency_Table {
>   typedef struct _ATOM_Vega10_MCLK_Dependency_Table {
>       UCHAR ucRevId;
>       UCHAR ucNumEntries;                                         /* Number of entries. */
> -    ATOM_Vega10_MCLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
> +    ATOM_Vega10_MCLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
>   } ATOM_Vega10_MCLK_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_SOCCLK_Dependency_Table {
>       UCHAR ucRevId;
>       UCHAR ucNumEntries;                                         /* Number of entries. */
> -    ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
> +    ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
>   } ATOM_Vega10_SOCCLK_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_DCEFCLK_Dependency_Table {
>       UCHAR ucRevId;
>       UCHAR ucNumEntries;                                         /* Number of entries. */
> -    ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
> +    ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
>   } ATOM_Vega10_DCEFCLK_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_PIXCLK_Dependency_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;                                         /* Number of entries. */
> -	ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
> +	ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
>   } ATOM_Vega10_PIXCLK_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_DISPCLK_Dependency_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;                                         /* Number of entries.*/
> -	ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
> +	ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
>   } ATOM_Vega10_DISPCLK_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_PHYCLK_Dependency_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;                                         /* Number of entries. */
> -	ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
> +	ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
>   } ATOM_Vega10_PHYCLK_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_MM_Dependency_Record {
> @@ -213,7 +213,7 @@ typedef struct _ATOM_Vega10_MM_Dependency_Record {
>   typedef struct _ATOM_Vega10_MM_Dependency_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;                                         /* Number of entries */
> -	ATOM_Vega10_MM_Dependency_Record entries[1];             /* Dynamically allocate entries */
> +	ATOM_Vega10_MM_Dependency_Record entries[];             /* Dynamically allocate entries */
>   } ATOM_Vega10_MM_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_PCIE_Record {
> @@ -225,7 +225,7 @@ typedef struct _ATOM_Vega10_PCIE_Record {
>   typedef struct _ATOM_Vega10_PCIE_Table {
>   	UCHAR  ucRevId;
>   	UCHAR  ucNumEntries;                                        /* Number of entries */
> -	ATOM_Vega10_PCIE_Record entries[1];                      /* Dynamically allocate entries. */
> +	ATOM_Vega10_PCIE_Record entries[];                      /* Dynamically allocate entries. */
>   } ATOM_Vega10_PCIE_Table;
>   
>   typedef struct _ATOM_Vega10_Voltage_Lookup_Record {
> @@ -235,7 +235,7 @@ typedef struct _ATOM_Vega10_Voltage_Lookup_Record {
>   typedef struct _ATOM_Vega10_Voltage_Lookup_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;                                          /* Number of entries */
> -	ATOM_Vega10_Voltage_Lookup_Record entries[1];             /* Dynamically allocate entries */
> +	ATOM_Vega10_Voltage_Lookup_Record entries[];             /* Dynamically allocate entries */
>   } ATOM_Vega10_Voltage_Lookup_Table;
>   
>   typedef struct _ATOM_Vega10_Fan_Table {
> @@ -327,7 +327,7 @@ typedef struct _ATOM_Vega10_VCE_State_Record {
>   typedef struct _ATOM_Vega10_VCE_State_Table {
>       UCHAR ucRevId;
>       UCHAR ucNumEntries;
> -    ATOM_Vega10_VCE_State_Record entries[1];
> +    ATOM_Vega10_VCE_State_Record entries[];
>   } ATOM_Vega10_VCE_State_Table;
>   
>   typedef struct _ATOM_Vega10_PowerTune_Table {
> @@ -427,7 +427,7 @@ typedef struct _ATOM_Vega10_Hard_Limit_Record {
>   typedef struct _ATOM_Vega10_Hard_Limit_Table {
>       UCHAR ucRevId;
>       UCHAR ucNumEntries;
> -    ATOM_Vega10_Hard_Limit_Record entries[1];
> +    ATOM_Vega10_Hard_Limit_Record entries[];
>   } ATOM_Vega10_Hard_Limit_Table;
>   
>   typedef struct _Vega10_PPTable_Generic_SubTable_Header {

