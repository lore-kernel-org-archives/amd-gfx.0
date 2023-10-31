Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C07C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 19:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A1610E08C;
	Tue, 31 Oct 2023 19:14:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E9010E08C
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 19:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnLfNyzUJ2/R8APdZlsv/sbQKHYofN6Vk1T+KJf+mYGwhvecwLwFRuqoGG1CQJrC9PTWlDXG+6cUireltJwN1gm4w/RkBZsFJSsA8rgtfcS/gzjDp0IPM/4y1c0H+Cohu0vDcJae1SfZ2cW+khFedYSg86FBkvokzmLMwFaqYOPUwakI5Y/nrzsd44yKPNEdiRDegC+81ypNwE6wsaycQsdWlQTyLYOmRljG8Q9Qx87+pYbahu20VXXMY7CGJzSTsQgOFgSdCwDiRHTYn1K3WaDwheSk5Q9rn7yDG7Biy03r+pJjPDDOW6uskL2cnScFC4/1WodLnlQctXtq6B67iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nA+hhouRjNz+FHq6KB5GDZiSLaEs4s8Ybraq2736ryQ=;
 b=Xu5LwtqE9vnLfyfITAfKtFhHmEbviS2nKi6QwAPQIvJHwAFtXaXK9nNQEVvF6h9chfp832OvyB8ZUXHBnnzCwegnZ3Ofny1a6KjBLz/eIQZoRZQKwWle6f9Kfmj4yN4sna7aspcS8tS4ZS9t9cPWyhmsSCsdutXqDIto4ogvkysD+/M42QdyJAk1YgzUZXwFx/qRC7xs9B8nzqYL8SwhqW+wo9Eu+mIeQzuoadPQClb1kXPY+MZSFrQQRmf5//uItZKO/xyFshwVtN/PTgY3XkJ2lUAizXen8dmSKxbAUB7XNL/se8PyDLO6HVgZz5OZtfu5WtKyZ4geq+f91etH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA+hhouRjNz+FHq6KB5GDZiSLaEs4s8Ybraq2736ryQ=;
 b=QJGrVbc0f/4YLarI7YhzW+VOHLtxLCYpGBdLVxgGucpf85IKGLQmJ/PObQCBq+lsE/B7WbCxbIELxs4bFqLrNjp04ClWnIDvItjK0wY56vTr8rnimbXK6NJtrnqj5k02Fy+PTyBTKN1R9JXxpkcqLd2RkEP2LC2wS2qhGX4EmaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 19:14:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 19:14:15 +0000
Message-ID: <a579f86c-3c45-4ca0-aa26-78c3843584eb@amd.com>
Date: Tue, 31 Oct 2023 14:14:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [1/3] drm/amdgpu: don't use ATRM for external devices
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231027154225.1662448-1-alexander.deucher@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231027154225.1662448-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:d3::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dcae48a-7f07-459b-6fb2-08dbda459295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0Sa0qupuJSsvMK3wZ2Im5LlBquSp/1M7qedw58QWS+95VsN0OQYP79f+QgroHazwqLvj7V+PFb8AYDodwlw8z+hFu+pTgxnsCPYsnoI8kRDVxH4Ges9qp9DEn6MoXswxfEUgar9nk+tOpIcAXJMHREEcbUIEIzpevOKX3D+OUxeF8KfYJkDQsJHm8XlJ3wCqSCjIe1lArGthfxBsiUgfAmR3jA+pKjTXCyYkmsR8iDJ453A72P6qGAiLqzCac+TGaTXIL7WuUHLkXE8uLTDKHi4vbWbrDIn4GuQp9L+02FxigjaHm7nHReyHzYPD/Cib1K4GJWnwzPWwvkXeDleLQfeVFvoZW4Wf7FQX47MD3CpzbberIpFPskVEoM/oZFLGSArZ8ol9E8Bb0L54mrKh0hsjSpLOIgXSpz5vzhDQsLLdhh7TLU9BMlJb1dDz/xTuCtx3WIK3l/eClvDoI74g0b7CKauNWqvOiEGISg7qvbsamBe/dCtbPnVs38YLhmjxb/yl1515blwO+yVeR3qoxs7KfNWhxbmMHXNERnSFKUVixpEl6jzbgB1wn/jPaNe+M6LQmrDYbKng+jyXBnBD5oLR4QlXlCFOjolI090crEUfD0xAhDq9lOChOuDUnvxMuT/L753NrOtIryAdBC8gsatsFoBgI0bYHDFI1mFjYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230273577357003)(230922051799003)(230173577357003)(1800799009)(64100799003)(186009)(451199024)(2906002)(5660300002)(66556008)(66476007)(6486002)(66946007)(31686004)(966005)(316002)(8936002)(478600001)(8676002)(41300700001)(44832011)(6506007)(2616005)(53546011)(26005)(6512007)(86362001)(36756003)(31696002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmo5VzF6Rm91SUVKV0tJTGtYcS96bHIxV2YzSGFIUDhuN2pTMDRsSHA1RThD?=
 =?utf-8?B?em9lYXZKbVJGK3dBV1dnUWlNb3c1OEFZOTUyVFpNYmwzdnB5VmgvaWxGYVpv?=
 =?utf-8?B?eHdZWmM4RmhNY2xSVUVQRzd4MnlQakMzVWdpd0o3YzV2bHZOeEpnTFV4TTdK?=
 =?utf-8?B?USttUnBNOFVCcTNORy85OHFuY3dUNFUvcHdYQjdiM1F2N0hZdmxnV1hiR2RS?=
 =?utf-8?B?TFNkeGtwaDJZMVd3WFF2aUFaK3hubjlRaUxMdGVZa1JNUFh5Y04zbVE0c2hm?=
 =?utf-8?B?aXVJbG1HUVUvU2VKcTBUMENvZDZLdXJDNURpWHFvNER0WllIQ0VndUs0aFZq?=
 =?utf-8?B?NjF6OE1xdk82RDZUWjNTdGlIbUJMZXdKSkxUWjkwVDRSRlp2SjlnMTVTNjA0?=
 =?utf-8?B?R002RjI3ekF1YkJ2STE0RXFwbnppOTlVT3lqL2tsQTlVNnNVcTJOZ1JTdExs?=
 =?utf-8?B?dng4THpmemQwQ3hVWVhER2dTY1JVSExlc2VGdnVUOC8zaTZQUU1GMEJtZ1VO?=
 =?utf-8?B?U1diMjNRTWs4eHV3UUg5N0hJNWVXZk9wbGdSU0lOMzhBUHZMa1NNejIyTVFY?=
 =?utf-8?B?dk81ZGoxWlhveXFkazBUQldZRFErZFBBb0VRWVlPVy9aOEhHWjdGS1psaW95?=
 =?utf-8?B?Tmd4dFYwQks2K3RoRDlaMDJkV1A2MUd1OHFVWmJxRUR6T2JSSnRuUEg0VVU1?=
 =?utf-8?B?T3hHMkYrNVdVaDJTQU1ITkxScVpGL0NGTVFZaXh2dnZ6UlRLaHplRUVxK2xZ?=
 =?utf-8?B?bWhxNGRIcVFLbGxraGgyNnRMcWlBdldmcUFCU2lUS0xlckhSRWVDVnZYUTVN?=
 =?utf-8?B?OVoyZERxTnFWNUVoOW9XdVNWUUFFZVkwbFgvOUVNdFFCeGVlamJqd0J1RGxa?=
 =?utf-8?B?WTJDY2IweklONVU5UkF1OG9hUFkzQXc1bWJQKzNUbndMV0J2ODhYa3RzbVdX?=
 =?utf-8?B?ZVpURTY0cTc3YTd2L3JPVFovWkw4T3hNZnJQRGtRMGt6TWUxSDJoTVFFSkkr?=
 =?utf-8?B?S3k4ejNCQXByVlM1NUErSURtZkhFa2d1RHZQZVN2QTM5anpGTnBtS3I2WDA5?=
 =?utf-8?B?QWdWUjV5akJnSGdpdDNmZlBYQkZiSncxaTRiZ2ZodzBkbHlvcnhCTjA3bi9T?=
 =?utf-8?B?OFRWUFJVNHEyR2JvcjQwRmxYcVp1bWVaazk0Y1Q4WWVUckRIR055Q296Wlc1?=
 =?utf-8?B?czFXYWNGS2ozVklyTy9yVVo0WE1vMmxYYnRqL0dBVHJsb0JWZWd2dmFobUhk?=
 =?utf-8?B?TEFkV3VtSDg2dWVjVTNuOHZUVmRlV0VXZDJiUmFucytiZkRHcHh3WEcydWU0?=
 =?utf-8?B?MEozU1ZVajJmc2NYVDNuQlR6OE1VbGpoZFI0SFBwcVNaZlk5WTBlSlBNWHRo?=
 =?utf-8?B?cjZjanJkZ0dyMDlkVU5ucWVKR0Fub1lmZFBVbThpNzI5aTZZbmczS2pVVEJ6?=
 =?utf-8?B?OEd2SEhOTXZvYytDN1BRZzdkbVJCSVJiL2JWWEtrY2N0anp2TkZ3YWx0enpD?=
 =?utf-8?B?SCs1ckd2Q2JYK1pDVnY2NWJaMDBGd0ozUzZUMHNDbXd1dlhDY0tVMW9TZWlL?=
 =?utf-8?B?K2JxUXY2emdYZTMxRFVMazhveitTd0N6T3Q1ek4rS1JXTFZsZDBpem5MUEI2?=
 =?utf-8?B?UlUzR05qaHg3bDJJSWMyaDl3OTN3TjF0WHRuN055ZFQyM3lQTkwyTGpTcERy?=
 =?utf-8?B?QUxlTTk5amJUUGc2SEhrNjhZYzRaMm1QZmhEb2gyVENkU2VueHpFSStJVi83?=
 =?utf-8?B?MHpTQ1NvMnVyMVhuNXd1QmpoQTlKYlZMU0o1NzN3c2V3ajFKTEEwQTkyRWdX?=
 =?utf-8?B?ejVCQm9udDhYcGtvZWFRV3MvWmR5bXlEbnFzbnNmYVdkUStKMTA3Kytta1h3?=
 =?utf-8?B?cExURXNlNWdkOXJIcDlJamk3WVZvNkgxdXlYMUozaWMvanBGRklRN3BzZFJx?=
 =?utf-8?B?aDcyMldqYURzajBiSVBCaEpQTGNrTmh6M3EwSHowKzdYN2VvSmIwTEUzUWJ0?=
 =?utf-8?B?TGxjRGJscnVwUDRQTmZDMzUyTS9MbjR2ZWlXK2E5ZGdqTjZwNGxWY2p1VVYw?=
 =?utf-8?B?R3VEYnVVNEYvUVFzREpKRzczMWR0ZytQaTl5K1crNUF1NXNxZ1dQM1FrdXJE?=
 =?utf-8?Q?68PAod+NhtPvzFR0nujsd/5RK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcae48a-7f07-459b-6fb2-08dbda459295
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 19:14:15.2051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9gMqU7T3M0cpps8gsKQnA1fKjjUWHaSYFWp9hoLNMqNCJuEjUbIoxBAGBlOZGSsV+vPoMZ+D1LdxXKN3pMO0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
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

On 10/27/2023 10:42, Alex Deucher wrote:
> The ATRM ACPI method is for fetching the dGPU vbios rom
> image on laptops and all-in-one systems.  It should not be
> used for external add in cards.  If the dGPU is thunderbolt
> connected, don't try ATRM.
> 
> v2: pci_is_thunderbolt_attached only works for Intel.  Use
>      pdev->external_facing instead.
> v3: dev_is_removable() seems to be what we want
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 38ccec913f00..f3a09ecb7699 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu.h"
>   #include "atom.h"
>   
> +#include <linux/device.h>
>   #include <linux/pci.h>
>   #include <linux/slab.h>
>   #include <linux/acpi.h>
> @@ -287,6 +288,10 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
>   	if (adev->flags & AMD_IS_APU)
>   		return false;
>   
> +	/* ATRM is for on-platform devices only */
> +	if (dev_is_removable(&adev->pdev->dev))
> +		return false;
> +
>   	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
>   		dhandle = ACPI_HANDLE(&pdev->dev);
>   		if (!dhandle)

