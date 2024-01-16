Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F311C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 11:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6FE10E48F;
	Tue, 16 Jan 2024 11:15:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62BB110E484
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 11:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj2jJXU1TRhtPQR5UXsthH1TOO6q29RDyoDml0qENo/g69nL7ECi117tSq7NxfVZGJmQVK/LrLjis45eqjY9h/nYHdxbx6C74bAsE6Dzfz8XFBgqJLam3mBVxU8e+roXHDE90CXTiZqMhblJ+OV81a4EVOkv1eUAutkstgD0MWQSshDcuspN6jj4aHC/awpYiNU4s5V3c6AuiwPpvpkg8k7pHZqlS6DV8aVoAF6CMkn7TAWAccNKXA7ysN0Tzz4s7RAol13RABL3pW+HCkZliQXC4Gxg9jmvZ/Km54//xMvSLM1QNz/szpIrxyAJkFEUWMwOMA16tYTtc7LHXOAmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eMLl6tnTwR+Umsaphgp0LSBV40yrzHCJEP5h3SCrzI=;
 b=ifLO/SwuFfTn4+ckXEfuhzlTLmEdpLxvqd6uzG5CYMLykPnt0A0ZoIbnCeG8+hqaGoBCotkVPbgdOy9yUiEr70Zx93G0HKNyTMavCBrcUea4U9HKQp2IeEjQKAHqFQLekAnF2XEFF+uYAVItXyFmc5OnMFYqxlns5KDe/llqNIDFgzlc2tbAGxL44iv+Zktao+LaHOEnolqDGsouBHZMIeFKn5ckq30AcKz/UrI8RBFaxTcNHHTd6cFGlxZZajVIpwGNaneV7LjnJfTKgoiyMJWJXlQ2l9QMpCf9Gr8lvfw410PlDgVUFltgBSqKbrdVRk8IsxbaTEFE+rOp65ZxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eMLl6tnTwR+Umsaphgp0LSBV40yrzHCJEP5h3SCrzI=;
 b=eK0RXJs5gDAEyC5o6nZCMtrTeL5pd+jjRoWYwO/NtopF9BBBb5lsgY3E8CLvkgNQXwLXoegRplIkgqwD72HZlWPeUxY36hlLXrCbZcdzMIQWRdjTuse+DxnXtJVf93r71s2wQtV4gPDj6pCvNsnljWIj7jv+8RUDWQtcU+rZ+6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 11:15:42 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%6]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 11:15:42 +0000
Message-ID: <8da7b544-f868-4eb3-a28c-cd032fe79e22@amd.com>
Date: Tue, 16 Jan 2024 16:45:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix UBSAN array-index-out-of-bounds for
 ras_block_string[]
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240116110204.1352227-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240116110204.1352227-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::20) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 42993d6a-e030-44cb-6a49-08dc16847a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNxZbTiqN90qZDurVsDIdPe+vpQfyOmLGRIa/FxcoLp0yuV340YxL9x2B92aXJJBV0OC6NP2irwg5GxNwX814tvoheN7Dipa1ysuHab6Hzj+6cJAbexDxcvYWKU9btFR3jhG/lO8JNpHuz3I35zUlLh0RWgEu39wcUalL0iKgrWGj0pkAYdjJIMs/YUYU9Q72CO4r+RJT66SvF7ttf8XSZAwSIOg6pBE3FryjQ5sTY4tz1iANzDSwsu53S9o33HgVjSrVzH+TVHsOOYJlruEbzcC/t13M3aNAVedLATxVicvMzBEMcvlfnYjAKfvUkQvN2zBSFQC9HjhT8mXhJWYv2aTJdPKFMhkdzTldf9MhiIJTSQH7lQyY+LkwWNRBnSDWtaD5N03MRs7uH82/MP0rjqfI9mg+py+FQ/gTZnYZngvt4HEw8fYUHkOCtkUYNQ/0CF7Esbet8jNX+lGUP22eJBCvqtq0XrTIrkkSKCahgwhlzfHiRPraVCSIREuj+ysVtoGth3cl1zCPC0uDeUYRLpNLb2MZ0WClaETmnDk1T8HLGa5zueqt9aGEWqqGj2peN/jqP8TNb0LaIMCvvxo/v+Ew9AJ/OOQYluTnqEFGt0njur3pZmq8/rUrTqXnOEylJJ78le47YQQaFARaJTSfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6666004)(53546011)(26005)(2616005)(31696002)(6512007)(6506007)(478600001)(83380400001)(4326008)(5660300002)(2906002)(316002)(6486002)(66476007)(66946007)(8936002)(66556008)(8676002)(86362001)(36756003)(38100700002)(41300700001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkdLdEdpbG5temsxZEwrZ3RSZGRHd1gzMzkwTmptSFlBZjV5b1ZFTUpCWk9Z?=
 =?utf-8?B?SFRDSTFMNkZaejhPSXFOUTFhTnhtN0ZxNGM0RFM1WFBpWXlQR3FpNGc3YnU4?=
 =?utf-8?B?akFJYmNiRGVHRFFNTEUyOVArRkdtVUtXc1ZQS1BuS1ZpK1hCam9rdDdXUGVG?=
 =?utf-8?B?cDMzVi8yNTRINnJ1U1hNOTBvdlJOREJwNWdJWEt3MnduUnl6NktubmtWVmxO?=
 =?utf-8?B?eGlLcFNEZllQcmtweVlWbTlnenJWUVFnZUtjYWgyS2JHRndmWElPV3RmK0Fy?=
 =?utf-8?B?bnZXaElwSVlkb1IrRUlmRzlnSGpiRXhGSWpCT0w4d3VIQUczTW1LRTNYTi9t?=
 =?utf-8?B?KzFhNXhEVWZwOG1WV1dCRHl1ZkdkYUx1UHJOdk5xa2Facm0rZURLb2c3L29o?=
 =?utf-8?B?WmhpSXVPZjd3VGd6dlplQTFiYlI0dld5bmY4SnRvUG1kWTVPWlhOU0RNNloy?=
 =?utf-8?B?dEliSm9wUExveTBFZ2JKUUpQWVAyaStwcGNOMEJ3UThOMFRTVEFwV1RQWDhq?=
 =?utf-8?B?Nm9DQ3c4cjNLUnh6c2tSUnpFblFlemt1OUZJRGlZSnFKNnlvV2NuUmk2T3VC?=
 =?utf-8?B?dDFTQWNYUmdraWJqZm5Hc0gxbGE1NGFPS3laZklVclAzSjRVUGNzK01nMWQz?=
 =?utf-8?B?L1U4MHl2NTB6cmtVbUpKeStTcFBkNUFUczIwUE10eGJYQVlJaitSbm5tdVBt?=
 =?utf-8?B?cVljTnJuY24raXVYa0dJcEptWWhJV1ZRZUdhRW1RUU02VDFyQVhTek5jTEx1?=
 =?utf-8?B?NGV5NUpKTzlNRFNMcVN1bElCWUE1dDBGdTdmVFBoY3k1ekhTak1Ba0lOUGsr?=
 =?utf-8?B?ZUFzKzhCQzQ2bEVGMmI1Y1VxTnRTSmRjMmk1ZnpoTkRHY05yMUdHaTQ4Q2Fh?=
 =?utf-8?B?SzdtSVFZSEl3SzhoWUk0L1pGbk1IRGtqZ3Y5VnZ6cSsxTDF2dTIvVXkvSC9k?=
 =?utf-8?B?M0ZmUW9CaW9JSWc0UXhtTDN2KzRrQy9WUGJIcUxjU2ZUVkFGbHFlVHN0QTR4?=
 =?utf-8?B?Mjd2T1ZER1BTMDhvbCtjUjIrZzNGYldTMHlIa1dlOUc4dnlocFhkWTlGMkFF?=
 =?utf-8?B?ck9naTdzS2hBR01vRjJTNXhrSHlNb2l0L2ZTUVBPQUlxTWk5TW1sZSt2dUNH?=
 =?utf-8?B?RjJTK1RRbUQ3YmpuWTdjTHNzQlB3QUxMcERzNlpLZGpWSXNZdjE3SEd6Rndh?=
 =?utf-8?B?QWRrN3psYjFxMC9peHF6Z3FtNUdlRlJ5Sk5xeENndXVGd0ZsaUtUaVU5RjZ1?=
 =?utf-8?B?RFRRTkp4UHZEdGF1MHdnMFlsUjQvczBMdTZic3RjZ3NSNFAwcm1UVU45ZTJk?=
 =?utf-8?B?cjc2cEZTSUZGWFUvR2ZnNTI4YkhrRTE0ZmRzVEg3K2c3b0dxUHp0eXR4T2hq?=
 =?utf-8?B?K2lSbThBc0I1cE56d25VNHJrVUlWWjVSNkp1UkN4Ym1NTXZpbkx3U3pNQ1Yw?=
 =?utf-8?B?NDA1bnl6M1VWMUtLQXpJNHUrTWwrSUVMbkRmZnRHOXRpbGtkK1loazJkanVC?=
 =?utf-8?B?ekozaTc4M2NibU1pa05iZ3NTS2NHRkowaEpjSUdjUXlSK1R0clhnSlQ2VjB2?=
 =?utf-8?B?WCtUQW96NVhzb2NTbFpMSGwwSjZDcnNUWlIwZEFtN21LN2x1cGI4TXJsM0x4?=
 =?utf-8?B?UE40eW1BanVZOGJrL0djMTU4L1czcHdQUDQvNGNKUm5ROXF4UEp3K3FoNHMv?=
 =?utf-8?B?VUsrUXRBWlpLeUU4enhFSTVxRnJMazRzOGJUOVJ3QW1VZmNJTk0yNmQxSDRD?=
 =?utf-8?B?dlJqMGxTTnYyNDFjY1FZK09YWWNWeXBxcW1NT2RrckNTMDlnb0IrSWR2cnFm?=
 =?utf-8?B?cERkdnZhWThUbDhTK1BhSEZYTW1TMTU4R1Z6VTA1eXNVMHMvN2tLL2hmbzF0?=
 =?utf-8?B?TVZVQXR6V0ZERXBaZm8vRzNNY3Z0K2h4bmNnQ0IxWHFBRTdpZm5QakZuTm5M?=
 =?utf-8?B?V1Z6aWhHd0ZwaWlzRmNBZUNmQmNuVk9LTEQ1V0VvWHR0eFdMb0tRcXJvVytI?=
 =?utf-8?B?SXJVSmxybzAzNStWY2JQNWprYnc0eEZUbVMrTDhhRXBGYW1sT3VadHc3MFo0?=
 =?utf-8?B?MFlIVTFJTTl3UTAwYTdUc0IyaXBTRCtFTXIrY3ljTDYrVVl2V3JSVlJZRURT?=
 =?utf-8?Q?8xcTHcCUn+UQJh8rg32T8AECS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42993d6a-e030-44cb-6a49-08dc16847a1e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:15:42.3667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrIe3FSnrZWFeqVRCkMKz6hLoBuWjJlkhJ/BrSiF0S0wmaGqf0ECKPn5zkLcJ9CY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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
Cc: Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/16/2024 4:32 PM, Yang Wang wrote:
> fix array index out of bounds issue for ras_block_string[] array.
> 
> Fixes: 2e3675fe4e3ee ("drm/amdgpu: Align ras block enum with firmware")
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ff6f84714f68..8004863719d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -74,6 +74,8 @@ const char *ras_block_string[] = {
>   	"mca",
>   	"vcn",
>   	"jpeg",
> +	"ih",
> +	"mpio",
>   };
>   
>   const char *ras_mca_block_string[] = {
> @@ -95,7 +97,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
>   	if (!ras_block)
>   		return "NULL";
>   
> -	if (ras_block->block >= AMDGPU_RAS_BLOCK_COUNT)
> +	if (ras_block->block >= AMDGPU_RAS_BLOCK_COUNT ||
> +	    ras_block->block >= ARRAY_SIZE(ras_block_string))

Better to keep another condition for this check and return a dynamic 
string like "<block>_unnamed" or "<block>_nodesc"

Thanks,
Lijo

>   		return "OUT OF RANGE";
>   
>   	if (ras_block->block == AMDGPU_RAS_BLOCK__MCA)

