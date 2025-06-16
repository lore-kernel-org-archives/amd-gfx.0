Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA47C71155
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 13:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E4610E3B1;
	Mon, 16 Jun 2025 13:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OFQxqIq+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CA6510E3B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 13:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fC3UHFtUXj2ChVv+VVauot7z9gbHQcSsmTqAHwkawITNWDYI7vthxHeY9v8OjiaXXplU3BUGtDNWCbXfkrKuEVxsV7WpUHegCp78If2Ge577wC90JCwLd5609VP/zIC8il5FHu4F0AkyeKEV0OtM2SH784RCNsncOkjQ8YUSz5E53itcfg8PSsr7Qjrcg5anwTFRYzWkZRNRzd8xvGpWgoX0BJCeHOwhjD/raZHRhnym4yynDTHDbNtPPXzPItEmAbxK0tQD3vAUcRrB5YmE8m6VgLQWo5gHVE8pLShtcKDIFgML3UfHvGFSiADBfHKFpmGqZ+G+wQkYYPMmuQjyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDBad5Ji4G/1iYueQr/kiwQJag1Cf5lcrkwfVxcI+fI=;
 b=qYJxybKwO6Lo80vpdk9cjHjflMc5B9gaFDANyVSRwugJ5s7lPp/a79Ry2XlyC77a0IUrb5slQCl0DEOZqE5yT8wGbzkA8KXbx+S+IcfDgzIjbcfQUwfM2BP/gQUONxfz9zQW28pA+Y2ZQSZwUr8+sccNZvpYcKDIHDolYwghBFgOepzfMAhIRVgiFMTBe/XFgWPzpVGAsXCIej1nEy36JdMpWA9aEGYlibzKxbEO1KrQQAGK0o+75KhAmYti7X3XpjijdcFTW4QhTcD3CGunWXz39hUBid/vj3zJ3aGLGdpsQjrvZpkGaejqZ9SjY+YskgT6IU64g3P+QTjwAH2dyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDBad5Ji4G/1iYueQr/kiwQJag1Cf5lcrkwfVxcI+fI=;
 b=OFQxqIq+19LaSTXFTNkPNry5P6uG7ApN/u1NtBTGazKv/uwk/dkm+OndblOTXBxIM1Q0Zxz/efOpgflyW2bN9d/iv9Y/aDKZphKqzRT6ys87DWuSxnTh5jFxhnoFU9Woe4W+mUvcL1Ei6YIOLV+zW+/oQW7mWfFhV6+BBIaAQko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 13:51:17 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 13:51:17 +0000
Message-ID: <2bef562c-fff2-d42a-0190-36c2692b37c0@amd.com>
Date: Mon, 16 Jun 2025 09:51:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix SDMA UTC_L1 handling during start/stop
 sequences
Content-Language: en-US
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>
References: <20250616114324.3495363-1-jesse.zhang@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250616114324.3495363-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::22) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed2dd95-9b58-4ee1-2820-08ddacdcdda0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3pZZERETGR2R1lLTFJnc0RORFEzTDdDZzQ0OVcyWXRWVXptcXlObUk3eU9M?=
 =?utf-8?B?eW5EejQ1MW9uV3hrRlVSaWtEV0tPWDhzTm4wRlNRa29tNkFlQzFXNHFOZjF2?=
 =?utf-8?B?SmxNNk5WODBSV3V3bm5tQUljaGlZbGQvS0JSQklmMGhFMGVaZkQ3TUkxREF6?=
 =?utf-8?B?bHpJSytvdVBvUWtJU3F1N0ZGVHh5dHd2R1VydTN6djlVNVI2eHhqUWFGUFRZ?=
 =?utf-8?B?RVJHNjNRNDdCTGtPN1ZLMXphRkxyVXNMU2ZoMnZBRnJ0SUxpN3NwOFYyR1ZW?=
 =?utf-8?B?RTk1Uk5jaTdrV29kWDFHUXYwaVRubUFnMlhXUk10dW0yMzJJYmd0YlFVWUw3?=
 =?utf-8?B?Z0VqQW5aWlZWZEc5US9BZlBzWllUa01qaW4zbE9rcHU4VTBjeDNBbjBreTVq?=
 =?utf-8?B?SjNsNEs2VGw3T2NXZGtQbE9lVE95RW05Vml2K08wOW42VGJscFRtQmh1cUxP?=
 =?utf-8?B?N2VrWUxNRUlwUWp5SWNGaW5XOENMNkpkbGM2SUcwUDI4c3JKMGJwaGZ4bkw5?=
 =?utf-8?B?b1JPN0xTRlNVNW5ucURIa2VDcFZiVnA1YzFkb2VjbkZYM3JieHUwUW1QdkpF?=
 =?utf-8?B?ZzdDdm1pMG9vVEtYem05RGZ3MnhjQlBGUVN1VldXUjdSSEhGUWU2dGxvSFhl?=
 =?utf-8?B?enNWRDF6bXZoY2wwZEp4UG1HNkhRc00wejdWVFRSZjJHSXRCT3NBa2xCR2c3?=
 =?utf-8?B?UGhDckd0YVRVVkdVeTZzYy91TzNYY3ptZG9ndGszdW56V1A2WldIU1hBTy9R?=
 =?utf-8?B?T2EyMHlqOGlCNTB3a0Z1MjJpQmVIV0prbE1Fc04yR3pURWMybDJPNHhxaEM1?=
 =?utf-8?B?b0Y3OE1zYTFENFFVWTJ4Z0U0SFRoQUVzLzVTU1R2VFJOMG9oOFUwL21JeEZ5?=
 =?utf-8?B?UWlmanRiQzdRR1NuR202NEtFaXd6c3E5L0djZ3BKVENHUmh1QlZBSEMxVWJQ?=
 =?utf-8?B?MktkQjl0WGlGM2FhOUFQdjRDQXRNTkdMaE8xRmIrNVdlMEt6enZMTnJJNzIy?=
 =?utf-8?B?dGg0bWhVbyt4UU5nblVGQmJYaTZjSFJaMjlwbE1xRitKKytKZks1WGpyM1BR?=
 =?utf-8?B?d1lDYUgrcmtmcXFlTnpOU2tqZmwxeGFLd0gzY0Y1LzFNOGhGbjA3N1V0TUkw?=
 =?utf-8?B?NlpQZ3FrU3BWKzFDQUtDUDAxVFRRMWRPbFUyQ2lIWlZSeFY5cmp2V2Jqc3Bs?=
 =?utf-8?B?c0ZVK3N4WHpHME1MRWZ6ckhnTk43UFlJU0V0TnRKeUlGUTJid1NTcE5YeEFz?=
 =?utf-8?B?M3BNYnFLdG5HUWJuUmprWjd2K1lxdlFWcElTY1VORm85VldMTDJUd2pvWGJm?=
 =?utf-8?B?cC9mQWtxT244U3ZEeFUrWXd5cmFDRlZLZXc4cGhhK1RNdlVuclc4cXFVUFNl?=
 =?utf-8?B?TE5xWS9XQ0ZGVVJBUXhtL05weGh2bjAzSXkrcUhhYy84SzZ1TkdKVUZENE9V?=
 =?utf-8?B?b1hmL2FjNituL2VReCtJdzVFYUwzUGFQWHVrWTlhQnRMQ0VxU0Q1Y0xOUmoz?=
 =?utf-8?B?ancxMUxvQlR6TnFCd2QwTUVzZW1LT3BjZko0UzNWRXlmNXorTTU5RWg4aWJF?=
 =?utf-8?B?WDZ2RGNMWkFOQmVlUmo1cFcyS3ZrUkppRHVxQlBxZnRRbEJkTXJybU9qd0xL?=
 =?utf-8?B?L0trdXV3NlVaVlJpcnltRDIrNkY4MHRaZXpqaWFSQnF0U3RBbm02YnBYZTFq?=
 =?utf-8?B?dE5PWGJqUHJUUmZEY280ZFp5OThJM29kU2lWMUtFY0xaZTgzZTVtVmE5bkcr?=
 =?utf-8?B?U0NhT1ZiS1V1ZWFqU1BUbDJ3NXBNQnRnWVdFUkd5ZTE0M1MxVmZPK2pXaFBO?=
 =?utf-8?B?NG01a3IvYWRFV1BmSllYSWtwamtZVkNSd2JPdlNmTzd2bkdnWnpDZ3FGM3lh?=
 =?utf-8?B?OTNqdjNBaFh0TjhQdTZUM3RUd3NqR0cvTGE1d0pnRWVaWVQrcHVIU1V3cFRw?=
 =?utf-8?Q?sYWPJ1yMGrY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdsU3RPMHF2Z0VSWnBNM1RmTWsvWENqbFpna0dEY3ZMUkxXRHJlMUo3ZWlL?=
 =?utf-8?B?N0pwdXRCZFJOblJSK0RoeHRMcjZMNFlBbDg0eHBCZ1NOZnovbUdYWDBhWkFZ?=
 =?utf-8?B?SENocldpTjA2a2lDeGpCY0wvUzloTXBKM2RGcUpBeElldFlhMnJyeHV1Y0Nq?=
 =?utf-8?B?VVB6bW43ZWZMaDk3bndPbUVuUThCaktrR21RUlI3dGRIY2loUUxvSVBqdnNT?=
 =?utf-8?B?bzB0STl0d1U4Y1pTUVhXNUR4YTFDNG84cjlxRVdDNWt3M05SdG5ZQW5LZlFQ?=
 =?utf-8?B?WEhScnRZbWpHZWFDdlFYendiVGFJd2FaTG1nMFRrM2J6SWVleU5jYkZ3RzE2?=
 =?utf-8?B?V3BiNlliaXVWaHgyK0s5ME5Od2ZHT1pzdTZ2dEVndTAxN1hNbE1IK3JnS0Rh?=
 =?utf-8?B?cVdNK3lGVXJSeXR4cmpnM0c1dzRXZmQxK2hwekJaWU1TdU9pTnFzbERjNkg1?=
 =?utf-8?B?TWk5S0pKMUhSSk9XK2doY093NkZRcGhyMVowU2Nkc05vMDNqR3pNNGFOcHYz?=
 =?utf-8?B?dkt1aUxERkZrYXVrZXhXczNlSUlZSGNrWXIyOGNPUUMrdG9lNGpkZUdUNG9R?=
 =?utf-8?B?bGI2SGhCd0xBTW42MG5JVFN4aW9lNndDcmwvV0JIVkZDTE1ldmlRLzY5Y0F0?=
 =?utf-8?B?aUIrOWhINThac0s1OGU1YU9ScWsyZCsxUmtkVWZzc1FhajgzN2JmOUpCM3RT?=
 =?utf-8?B?dU1pb2QvdUxQeGVBd3AwU0g1VnFrM1d4dUtuQzZuRTBBN1BVcGlNWll0OGgv?=
 =?utf-8?B?Q2ErYkNkSFA1S0EwWFVjUzRPVml1cEU1YlZTM2NybFdPWGxkcHhvTTFYem92?=
 =?utf-8?B?S3lvM3lQTXZGbVNVRVlZUXlWNG5YVTlPaXJuZzAvbk5rRWhlVWdVdFppbVk1?=
 =?utf-8?B?cEpkdG5VajNhdS9ZN2MrcEY5cVlDTy9hR0ZWU0ZFaitEZnlIQ0prc2RLTnhE?=
 =?utf-8?B?WGJJU3JYeVZVeU92VlVQbzdKQTNzRUhBZmpiVVh5ZHIxaVZIdituVUI2QTVO?=
 =?utf-8?B?MmQrZzk5WkE1c2oyZzhlWm5XdjFORHRzZFljT2VLdmVia3dYWENFVURsZlpC?=
 =?utf-8?B?d3BNTW5JUmN1MHhCYlp3VC96YXhWSjhvclNHdVR2ajJWbzErTFBWQVhvd1VU?=
 =?utf-8?B?N2hpcDh6cmZsSUQzNVd1NnBNcFhxZDhOaytjZmU3U3VSRVBTOHZBSG5yV3hX?=
 =?utf-8?B?QU82YkYzWDVFdjVPNWFaRzdoL3J3eXhKcER1YmYvMHhSV1NnbWdnbGg1RE1B?=
 =?utf-8?B?VFBUdG8yYVo3eXhUeSt2WWl1dXdyUWVqaHBFVW1XbC9ONzZqVUF3YUxyMXFi?=
 =?utf-8?B?VWNBVDIyalBBOUpzS2ppakduT1E4KzJRTFJYYVF2OGxnM3h0UW9PMFVqMkhN?=
 =?utf-8?B?WjZOd1lnZGlTb2Qwc0swVzgzTHlneVdSempaWjBldUNvQnFUendUZ3VLV2ZI?=
 =?utf-8?B?aXhFaFd6Q055YWxxUHBMejFSR0FsOE9waHhYSXpBeWRaS2tBa1VuZXBrTHQ2?=
 =?utf-8?B?WENDcXE3aTJ2dDM1alZBeDRhUXZ6N3h5LzBpVE5pMzJzWWhPeDNVK1pJTVdh?=
 =?utf-8?B?OCt0SStBOGV4WWxUd3ovNjRNM2Y4b0dISkJZMGhzNmZaN0RUVkhTR25FTTVr?=
 =?utf-8?B?NG51Vjc3VWhiaG9yVEtXeUQ2T1l0c0NCM3lieW00eDRqYjNCK0wvMmJoWE04?=
 =?utf-8?B?TGF0aXNLblFtcktRMTQ0dCszSHgvY1M2Z25hVXB0V1dmSUJhRE1tRlMrK3dT?=
 =?utf-8?B?UDhkdmRmZ2w4SjlkbVhZdld2ZVBjdTgyZTZmSVYyZi9mZnowRlZIYnlHc1FM?=
 =?utf-8?B?UVBUWFZKUGEwTUh5Z1gySXRrdHhQZUlOaUhaV1lGRGwxbEVHM2pJeFA0YzY0?=
 =?utf-8?B?OGlHS0hidmRBNE4xN2VvZmNYYTB6ZUJFR00vcEh4NnNVdjNWMVNDazJ6MWdl?=
 =?utf-8?B?bk9QN1JTd2ZHak5oNTRWdmlpWkNiQ2ZLVnZUOWpVS1BialBDTmpNcTZ3YTdr?=
 =?utf-8?B?alBiUHdWZk13dUtERVAweUgweFBOYVc2UDVBT1RvM1RrbklnSUMyWEErLzNI?=
 =?utf-8?B?RUIzSFRNK0ZYcWVFVzJEeEhnUDBLMzgvV1UweWNtWUdlQkFIZVNnNHE2R0t0?=
 =?utf-8?Q?k47o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed2dd95-9b58-4ee1-2820-08ddacdcdda0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 13:51:16.9908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ml+vDYrTapAXLiecIOIZoo1jkLDZS64R3Z0HejZ+rzc6sJrK23C5mgjpKyQvdFYm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
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


On 2025-06-16 07:43, Jesse Zhang wrote:
> This commit makes two key fixes to SDMA v4.4.2 handling:
>
> 1. disable UTC_L1 in sdma_cntl register when stopping SDMA engines
>     by reading the current value before modifying UTC_L1_ENABLE bit.
>
> 2. Ensure UTC_L1_ENABLE is consistently managed by:
>     - Adding the missing register write when enabling UTC_L1 during start
>     - Keeping UTC_L1 enabled by default as per hardware requirements
>
> Fixes the commit 7f03b1d14d51 ("drm/amdgpu:
> Remove sdma halt/unhalt during frontdoor load") by maintaining proper
> SDMA controller state during initialization sequences.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index e6af50c947a1..1f6a8944b1ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -492,7 +492,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
>   	u32 doorbell_offset, doorbell;
> -	u32 rb_cntl, ib_cntl;
> +	u32 rb_cntl, ib_cntl, sdma_cntl;
>   	int i;
>   
>   	for_each_inst(i, inst_mask) {
> @@ -504,6 +504,8 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
>   		ib_cntl = RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
>   		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_ENABLE, 0);
>   		WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);

seems using random value sdma_cntl to init, probably you need add this?

sdma_cntl = RREG32_SDMA(i, SDMA_CNTL);

Regards,

Philip

> +		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL, UTC_L1_ENABLE, 0);
> +		WREG32_SDMA(i, regSDMA_CNTL, sdma_cntl);
>   
>   		if (sdma[i]->use_doorbell) {
>   			doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
> @@ -997,6 +999,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>   		/* set utc l1 enable flag always to 1 */
>   		temp = RREG32_SDMA(i, regSDMA_CNTL);
>   		temp = REG_SET_FIELD(temp, SDMA_CNTL, UTC_L1_ENABLE, 1);
> +		WREG32_SDMA(i, regSDMA_CNTL, temp);
>   
>   		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) < IP_VERSION(4, 4, 5)) {
>   			/* enable context empty interrupt during initialization */
