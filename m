Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8460C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 21:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A7910EA7A;
	Fri, 18 Feb 2022 21:54:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F039D10EA6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 21:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1WKp9OreqZqjM2pqWHGOi4LeI5V2pocuPdv4zwYAjfb+fEHAz4GgGcfBoyoUkC3MMnJPJET/GiQKaPmh8bDVHFJJrTUzfAsFQRtnC5cpQ6VuCb6gYTrOTPFBT553LLaLMfrnGuLHHZLEOXBFAIB/67JDhLL4iHnGx3OoVR6VIlNk4VjmyaA3aUoZ1G66KY4GFecBQv6v4wQuNfBHBFU4Fqtet0MlRHTY0Itov8q/r1o0/kFggibD+JXGmkBK93NE2me1cjtArQVTTUv9y+8T6WUp/T/R0gnREjY0lYsF31lA98zFH08A1ezx7KCMhO3fV75r7hGtV6HxHGE5ZALdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd/X8Vo7sNhculk74rr6JSxzKuh2GYphuzYKeiInGns=;
 b=L03rqsVOEn2PUnmRjDpv5xdQuKQPVqsBBOGFGGM6mjdLtATe6tiqf8JXZtZuTdYqyYwz5A9koSi6TScKeQZw5EC/hqTi5eWWZ9tSads47dEG5uMKxTIrGhKe6HKdRi38xxl5MXCiBel/T5xQBmD/4mw+yyM0f7a/iU2FJ+aBboYMQO22GJ2e7DwkHJY9kytyjM0up6DshGjCsu4hJ2N0gQZHd7JCYy+8yiAXEw79YKC9z76er/j8b0pvyYQtOxg6xYUc8oGhHBUcx3Cdlb/v0lOYQNBPHgd6uALVCQNfTenppWCLP+IP0ERkFABYBbs7bnGcZVqx3Razie6Faq2EWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd/X8Vo7sNhculk74rr6JSxzKuh2GYphuzYKeiInGns=;
 b=sBm9WXWJrvPdDrnhJO3ocnGgOv45OW9dozAK4p/PWddk+FXfbY1S+zx6RXeXPIEGsyjnCPXyMEValR/uJ/FM4tYfc9X+xYP9XMaHZbs40DOkXRw9wCHtY6ViXpkvYFb79qoXfIaVBoLgae46p+McNyS+3rncuvErQ19a4UyPhok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4921.namprd12.prod.outlook.com (2603:10b6:610:62::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Fri, 18 Feb
 2022 21:53:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 21:53:59 +0000
Message-ID: <d367030a-9347-a236-8d82-9f834a319488@amd.com>
Date: Fri, 18 Feb 2022 16:53:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: make CRAT table missing message informational
 only
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20220218204248.830299-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220218204248.830299-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e46f690f-b825-4386-50c5-08d9f3292b12
X-MS-TrafficTypeDiagnostic: CH2PR12MB4921:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4921A81CD64B41352C9AF89892379@CH2PR12MB4921.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viQGD1ViIHbmNHPVpaz9shpDTgoYm07gz5WX+LGuiE+Pb0CzzIe1OAZEvoDGYDXUFrUr3rq5w88W2x7lffOryPD0+rINH5Nj+JqPdAKnVFvH8tTYOLgls9fZLpK3ji+fXmjZwQjcdr95URc+IL5xoAsQHvMTMZlZyJt9UoKWD4w1JQ7vDyUyM9YxU6vPrMFx0ZXR/yLzAL4IAXxHdDjsStBzj+5UMXgI0l53XvFb21AQcI89YZZQrJvX4EgDLsFptJuskwETdbqbV92wCK/fBzoVY2hcPpR84y18LdDH8p/4CNHTLk+JvuG4Kv7P/J38C2tJ+o1+TIQkFjGj/bNAJZwLWWs9bHqTU6DZ9iC8V2wEk84pGOSOW1NNYSNUiKmdePxAyMA5c9PZU9O0xU4k12m+skDM/FpqIFyMvILwd4Nl2RCRbDDCxKCGe1et4vT5DkI7lPLseQQruaInfKxL/vhK6S0HNnluXc4jlOyQW4URxR3itzqn+2QmfDBYTf606FVbJQtNNcbqQPCTj6q9C/PGypt2/JL+/iirjSiAaJK9uydqciBCXDU4Hf62/lNHF3LcE2SIocZrrPiRrSPMKtaAlJSzKXyHgcdE2bMPqMCBV/RXP51TaXBXaabiRNhVkCiX47Wu/Gu73b4EEJ6NSsjYvPM54C76Hf5p8+uqN7geJa2IXR3MFQqLlwdhLT1GHJs8Irp4AdGWV1r5TL1NuP6Oh30SJGk8qi/QvuiuMsCaUwTkt+VC1+ZoP4U3U3dM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(36756003)(26005)(31696002)(8676002)(38100700002)(83380400001)(66556008)(31686004)(66476007)(6862004)(66946007)(8936002)(508600001)(6486002)(186003)(316002)(6636002)(37006003)(6512007)(2616005)(44832011)(15650500001)(5660300002)(2906002)(6506007)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjVqMnVhS2lWQllEeU9LbnF4OWxmYTJ2YWhzU2dXRWlIYnYvc1VMWG53RUt2?=
 =?utf-8?B?VDNrRnViRXhQU2tJTWJJU2x1SU4zTEhZN3ZiS1BrSWxnTmV3aWNBZmZWM1ZR?=
 =?utf-8?B?TnppaUNuWDlSdmdONEJid25TQ2E3K0toVlJsQUtIbDBoUlV1NFlMbSs0c1Jv?=
 =?utf-8?B?Zk9YWllpWmUwQ2RJZitiTzl0aXJNU1NZZDhrWUxMLyszUjFtTzF0ZmV0Q0hG?=
 =?utf-8?B?MENDVUJ6aWw1M1Z6MkZuZzJPYkpZYTd5aTkxZWZhRkhsdWY5enNJQ3UyYlhp?=
 =?utf-8?B?blg1SkcxMGpOdjkwMnVwQ0hLNjZnekZzRkxRQXlDVUhXWTlML3NOcCthY2hZ?=
 =?utf-8?B?L1U0dTdUT2R3ZDRsZVJVTStuSUtFU3dZYTFkMlhJa2EzU1liWjk2RXk0dzBV?=
 =?utf-8?B?eUp1QjlseU9KOFUzck9HQ2Q1YWMvekI0UmV4QjV0azlOampoWi92T3RjUEI3?=
 =?utf-8?B?ei83ckhObDJoQUdkMVcyMXBoVk4yYWlyUmh2YnpJRkd6SnFyWVZIelRKeEVJ?=
 =?utf-8?B?dkJCbmxsN2lPdGo4R21JQnRpTitIMXJUMzFDV0RaSW42OGlSZHozVGc4MkY2?=
 =?utf-8?B?YlN1UDhKZWxEcngvWXV0Nk1Tcm8xV3dsdXJEbzYzNUJLbFU3b1ZpWnNZeCtR?=
 =?utf-8?B?bm0vQTVGZjlCNWkxYWdiTXdkTDc0NVZIcmRZamQyUWN6TUhPeFcrYkhzTWp0?=
 =?utf-8?B?NGk4ZVJSN3NXMTNtTm1DVkdLTUNsNUZ5eDZET0N2UkxNNDB5MHFmb1F0QzdV?=
 =?utf-8?B?MXpJMTZEbHpCbTNMcXgrVWd4djZtOEluM1llN2RCc3lkQXVKM0piR2RIUlhy?=
 =?utf-8?B?aEUyRDlMUVlzM2pOc1d3R2xiSEpRU2h2OGJ1aTBLV3JNZWkxdnVnSFVYdUxW?=
 =?utf-8?B?NkJ3dG1uWGRyVGJ0TDJGU0ZSY3ZrZHBvQUc1RzNDWDBlZDFCaEM0Sm1wbEt2?=
 =?utf-8?B?NFhsVHpEenMyRlJMdms2Z0lFM0NoRk45a2M2dzZmNVdzKzRkYzZPR28zTXhP?=
 =?utf-8?B?dGVRTjJIL0tpRzVwNG80Y0dpcUhhWGRGdDQ0R21pT1RCcVZwTGRmMEVmUVBG?=
 =?utf-8?B?Ri93TzBadWEyaFBEQW5BOVNlbG1hWWUwVzF2OWtJSVZ1eXN3SEUrS2Z0bWpE?=
 =?utf-8?B?M1ZhRGJnVjJjZjI0OU9OVEZ6WVY3YUVlaHdvcGt1Z0NJQkNkWXpPSEJXV0Uy?=
 =?utf-8?B?M3E3R2xTUnNFbnpUWFRBL0JJK29DMUVxYmVxLzZwczFkbElSQlBXLzQrdXk2?=
 =?utf-8?B?dDQ1TFdtVFljWHVYV1lvUmRaQkVMNWpkemp1blZPVU5nSG1ZTDc0bEFiNjdW?=
 =?utf-8?B?ZmRHSys2ZGhOTm5jbFhqRXphUEhoKzIvdUhXVS9kN3p2OXk5bjdYRGJwejYv?=
 =?utf-8?B?NGgva2pjRG1QUnBxVCtsSVhRUE0zcVdMWjJPOG84ZWdMajhPeURGNjBvT3Zq?=
 =?utf-8?B?RU5qNFpjdzVkL0hhUW01SHk4OHc5RGJxUEFvZnZEV09wa29sdjBIUjZZRFg4?=
 =?utf-8?B?dzNzaEZHT1YzZDVlTDFQTDRlMU5EK0NUUTcxMm8xcjdKUy9uSG1aL0VhaFVi?=
 =?utf-8?B?cWtDblN2RVV2bUs4cWNwUVJYQ055cFFzcmpRTzZ5VDIzUWlpYWlmY3hXOFdm?=
 =?utf-8?B?bWtnVldzbDgwclMyWlZ5VWZybGRnZnhNQzFPNFQxV3kxUk9ZeHg4M1U1dVgy?=
 =?utf-8?B?SGFJaUhSUC9NcTBkOENKQ1pRZTNvUHM5ZzZkMEZRUzVXbDlYSlNGUFlGTDlO?=
 =?utf-8?B?TnRHSGM1bjlOWW1tK0lMUTVvZ3FscmhaYWpYajhLdlR0ZitOek5tSjcxUXdD?=
 =?utf-8?B?OThXdHJTelU2MCtTbDJac0FRTDd0N1YwTEZaYlRLMjczUjlsZmJUaHc4U2J3?=
 =?utf-8?B?em13aEFPb3FEaUpDK3FnVWNDNFFOaXJjNmY5Ti82RVc3MHBiOU5nbVpjbGkz?=
 =?utf-8?B?STZva3g4T05vN3RBN3JYNk1ad0U5cEJaZW5NUHQvRlh1ZmJXWlg4S2pMYjBh?=
 =?utf-8?B?elh4WG9CV1F3VktZZzQ0NmU1Wkt3VWRUY2ZGNjQzZjVZTEdEazB3ZlFjSjZo?=
 =?utf-8?B?TWNXWUJ6Q2MzV1FCM0gvMXBLUXRCa1ZxKzFrSVFuSmY4M29oWUc0R3NLemNn?=
 =?utf-8?B?Z0lmRVpYV2NsZityZTQ5dWZjck1ocE5aQjhWQ1FFeXR5RXJrTjBrU2JaZkFx?=
 =?utf-8?Q?c/GAWYzsBPsFI+1deM7KS6c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46f690f-b825-4386-50c5-08d9f3292b12
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 21:53:59.3039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoupApm/nGrOmhTHzOUq3ucI6gvnYJ2aXYEmKbf7ZfHkOgKU0av0T1sulYZ7nTK5F8gXDdWFkme1OLE35xhK6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4921
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


Am 2022-02-18 um 15:42 schrieb Alex Deucher:
> The driver has a fallback, to make the message informational
> rather than a warning.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1906
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Thanks!


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 24898238b024..1eaabd2cb41b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1569,7 +1569,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>   	/* Fetch the CRAT table from ACPI */
>   	status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
>   	if (status == AE_NOT_FOUND) {
> -		pr_warn("CRAT table not found\n");
> +		pr_info("CRAT table not found\n");
>   		return -ENODATA;
>   	} else if (ACPI_FAILURE(status)) {
>   		const char *err = acpi_format_exception(status);
