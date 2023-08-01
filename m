Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072A4C00528
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 04:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE9310E0D5;
	Tue,  1 Aug 2023 04:45:02 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A0810E0D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Aug 2023 04:45:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ4HZdRiC6pLdgjfJt2js3AvixiM5pVCn2cs/9zLMPHbHGhCmO8CAqzeSZje+ZBPHaaVUy7t/9b8apQRS+SaXuowRWwoCl79phBFa2CFgsgMze2/sv+7cKu6nrE2ZhhOiRLDgCpaO/rULah5JlReFKRHDyLAvwanBaF9nY049CdtXLsd97i6kh5cQHjrPal/XAVpoG+/4WvCGSnVzbuOernKe5WLrVRK/z03dGFV7NeZ34sSSVjAYPInDufEVzbgkd8JqgZ9eR5a1o45uWHSqrVGLuWPdBoOsSkhZXTvudaD3jKksxAl75XGNiYEaVKwt9ImDc/Pno2TSUxhYexbww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0XHkinMp7Q5fQtGNokkF+8C02AecGyh3FyNXUHyjcY=;
 b=h0JNCNzaWXIKEfI426bXF2g4vJ+Rr1sb/soC2yTjBiRMjYsXYwmmc1JE19vGjg76viDxJC8oACSvJgZGyrbUElP1jEJEN2tRapO7cqhgAyPPJt2EhdukX3cpRqTtFQdaxiqHVdIJVPih0f86IY8Q2gGr/gNxnHwcJmirWuAIHTV/cxH1BO09chzllJ5Mud53i1EPAb/9q5bzBxccQw3VKpCt6z5VFa/4LpUwrvF1CrMPR4IHE+4r5651gz0zPksp/3rQloFCOBHSMZnDhFpMrZ1AOO+Nu3tsQLQCFcpr/ouXRLZ1PtxxL45RnB7bvuD68w/scEjL66SAHoBjMJvCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0XHkinMp7Q5fQtGNokkF+8C02AecGyh3FyNXUHyjcY=;
 b=oFYNptJgA1r734t+M6prxFNlN1VgWk71/9OaMpuKykYSZ2miad4YRz72PQ5ZoT/9tw0DjAeQXRRNv3XEsPD5cLqa9y0U75rvFHKvZDdpQQadyjzNNlN6pvtaBa8bg3frZFDxKp9FPz4CwDaxnP0GLyIMsk2/6H3W4knj8a5R3bY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 04:44:58 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87%3]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 04:44:58 +0000
Message-ID: <25519235-1f96-e7b6-746b-633ca44822c2@amd.com>
Date: Tue, 1 Aug 2023 00:44:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "drm/radeon: Prefer dev_* variant over printk"
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>
References: <20230731120416.2850594-1-srinivasan.shanmugam@amd.com>
 <20230801025446.2950427-1-srinivasan.shanmugam@amd.com>
Content-Language: en-CA, en-US
From: Luben Tuikov <luben.tuikov@amd.com>
Autocrypt: addr=luben.tuikov@amd.com; keydata=
 xjMEY1i6jxYJKwYBBAHaRw8BAQdAhfD+Cc+P5t/fiF08Vw25EMLiwUuxULYRiDQAP6H50MTN
 I0x1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+wpkEExYKAEEWIQQyyR05VSHw
 x45E/SoppxulNG8HhgUCY1i6jwIbAwUJCWYBgAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIX
 gAAKCRAppxulNG8Hhk53AP4k4UY5xfcje0c5OF1k22pNv8tErxtVpgKKZgvfetA4xwD+OoAh
 vesLIYumBDxP0BoLiLN84udxdT15HwPFUGiDmwDOOARjWLqPEgorBgEEAZdVAQUBAQdAzSxY
 a2EtvvIwd09NckBLSTarSLNDkUthmqPnwolwiDYDAQgHwn4EGBYKACYWIQQyyR05VSHwx45E
 /SoppxulNG8HhgUCY1i6jwIbDAUJCWYBgAAKCRAppxulNG8HhnBLAP4yjSGpK6PE1mapKhrq
 8bSl9reo+F6EqdhE8X2TTHPycAEAt8EkTEstSiaOpM66gneU7r+xxzOYULo1b1XjXayGvwM=
In-Reply-To: <20230801025446.2950427-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BL1PR12MB5362:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba5cc61-0df9-495f-93a8-08db924a0eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4idUY9pP+4xgA8yjqjbOlp8F/BIQIfJOiB0FGrY/jw/oaFu9HU0AJ5r9Tcjblph8GVSyNVLALlOYbLdMOV0rsejcVWPUZbeMBPbzYU43gFG3afFmgD/UC4sAzn7/bOqnUs8aJye0HlqyQOHjoPXmHtMOGeW/F4t6PdaFC1Tr4AF3sfCXqjniqoojO8RjTNNaR/6NPFsoxM8P61vZo5WRu4xDiJOk9FYhEddkOZconGTA//SpQ7z5SiTwn3KG/pFBJqx5pfaQwdkVXtP5ZmdxhyoekHpdypqFNARcenPsuzkF6gZ86VgjgRNoOPfoVshM5nCeY5S4H8qM88yr55Z2g1tQcB2a9iu6dnYMmxziLS0DAwyj4uKn7QkEelpxamXBLRzXWOmYqE5l0oUNTgkD7XpVWK5O4Ie6EyQvE1TngntuSWOpd74Q7MHjyzhQpKydhojJqEtBnzq5oDKeV8UvjpFXAUWqLUg9itAnPVygLgbBNOq242qvF99wr+eXSK/43vD6Fm5d4oPB5NLB/HZSpR6Bb01vwNtl5YD7ygK5Lp+0UCDv94zIET9h8f8mGjVxZLRL8KlWTSOL3hTGEAl/xZCOrILTG5Z/nMKYPqufLIm3QNNbX3YOIrbaiQ+UmSIx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(5660300002)(66574015)(2616005)(8936002)(8676002)(53546011)(6506007)(26005)(83380400001)(316002)(44832011)(478600001)(186003)(41300700001)(66476007)(66946007)(6636002)(110136005)(66556008)(4326008)(6486002)(86362001)(6666004)(6512007)(966005)(36756003)(2906002)(38100700002)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEhIQU55bHNudjFvaktjVG5hVXFxU21KdGhVRk1mTWRuT1ROdWRlM29KVTgr?=
 =?utf-8?B?Y04ySk8rM1BjYXpFMjRoSy9zUG9DRm9vMnV3N25jUm0rVUQ2ZVlKRG8xMzFI?=
 =?utf-8?B?WHJJbWI5Si9xMDYrbmF0dmhEcUxzZDc1OHJxbEFoWFFrTDY3RWEyUEJISWRY?=
 =?utf-8?B?eit4V2c4SU12WjBicVdXcS9rUjJmaU4zc3Zvb1pUSGdQVk41Q0g2WXVoMita?=
 =?utf-8?B?MWF2OHAxZFNINFM3dUIwZDNCVDUya2RRcWdkZmoyeDB3OFRHMWRsdUZKSGo4?=
 =?utf-8?B?eVlCOFUzRjJzZitKNlNYYmdTc2tTeXlyYjlWK0YycFFSbkE3eGtvUDIxVzlJ?=
 =?utf-8?B?UDRWVnhndXFLODJ5czlJWlpURGNFOHhEM2VNRlR3MElvanlnd3VSL1BVVWQv?=
 =?utf-8?B?dFo0SnF3YmdEUFF2WEZEeDNPdFVOVitIb3pGRlU2bFVzVDc0UG0vaG5ZUDhv?=
 =?utf-8?B?d2xVZ2gxbE03MWtnemdzWm93SGhpRlhUT1pQNHlyRjhVQ1ZLc0ZpMlNVbXNW?=
 =?utf-8?B?amFuSlVzTWFrbUpCU2ZDV09nTE93Z3Z5VksrYkJLTlVWVHRTVWNtcUF6WmlH?=
 =?utf-8?B?S2x1dUczU3dKR01RbWFkNERockk5QUdOeXFveGFPN0dKNVlWMHJmNk5LMmpl?=
 =?utf-8?B?VjNjUFdBR2JxRzduTTBVV0JEWEkwMldpK1VCbGFURVVNakJQVXBXL1h2bXRw?=
 =?utf-8?B?alJNWXZiYTNjWHNtZnM1cnQyVGoycFpsUGtvSXRjZGFWQU5zeHFMR1ZQSkhY?=
 =?utf-8?B?dVJSK1dwSVlMSmJ2a3BBQ0xMNEwzMjlXMk8veG5CK3dUVXNIajc0QkNnUHp1?=
 =?utf-8?B?MWttbVlaclhSNStic2E3UXA2ZDFXYVZiRVU4RjBEZ28xWElUcmJaUGZhaDlB?=
 =?utf-8?B?VS92d3Z3ZzlXN1RJZCs4eEFSZDJaUngvZjBQNnpqQmNKT3dVUjN6Z2NLUkhU?=
 =?utf-8?B?SkVqdHE5bU55QnJlQ0l3Z3M3bFo0Y0QzL2hpclVYK1pteFdNd0tyVXRkai9D?=
 =?utf-8?B?MFVmZlNPWHRSTkJsaUpSWWhIUVQvQzNuSnZVZ3hEcHEvUmN5QkZBaEhScFhJ?=
 =?utf-8?B?bXZ4T01XRWZ4Z2VyOHlHNitMbGh3Zi8vN2pydjU3NmM4VnQxWjZZL3o1cEVG?=
 =?utf-8?B?NTRudU9iN3NwM1ZDcEw0M3dQdHZWR0oyT3FiM1I0QjB3OXRVQ082azNzN3lG?=
 =?utf-8?B?Z0hwc1AyaWcrYkpydTdLVkhLY1JsM3BJVG5md3pKak1HN2ZGSTQyZTFzS1Ri?=
 =?utf-8?B?NlNMaFRNb2dMcUczMktWZGJnMmxKL0FCMnBTeTZQbkJLMTBDRnpPUXBXVzRI?=
 =?utf-8?B?VGhJZjZlVUtKcFNpMERyc3lQeWVCQ0tjcmpGaFp5by92SGFLL1dwZTlyWkhu?=
 =?utf-8?B?a3NKY3dHamM2TUFhTHVuRlJYMkEwNHNleVo1OUFZREZrQXdBZjJoRlJ3M1Ji?=
 =?utf-8?B?Z0ZEcFgwMXpMYXVPNkNyWHM5OVZVUXozUWlmblFJOUlINkl1UEpNNjhsZUNG?=
 =?utf-8?B?azB3anRBajF3N3dnUG0waURxOXpIVHdSbXp0OFZyeG5ETC84YnZIdUhQY1lj?=
 =?utf-8?B?VWhXMFhZS0FMWTVUVEpoS2d0VkVleURKWFJ5cWZCSXJCa3hrNy9LTnZtQk9h?=
 =?utf-8?B?L3lFUDhMSnRTRzM5bDNsZDl5eDR4MmlMRVBhV2lhVEwxTkVDM2huZWRFTUx6?=
 =?utf-8?B?bnY3WnpNNnFyT2tHcU1nUHkvcW1ZaVJPb1FVOUJ1NjRSbEp2UW94MEJpeFdZ?=
 =?utf-8?B?YUEwZi9Ccy9vZFlhT1llQ0NzZnQ2MStFWTNjNGI2NEhsNlgxZ2g2VWlWTFBi?=
 =?utf-8?B?OWtDMUd1ZzBRVkxGdmdGbVMvOHB4WS9KS20zczMyV0ZmeExNYktTVkZqUFE4?=
 =?utf-8?B?TkNORG50Qm4xaUxzRnk3MGowcFFjUW5zbjlnWURtN0hVbHd4cXNWRU42elhl?=
 =?utf-8?B?QTdMbkh4VDN5cEs4QllFVXNqTS9QWDhienA0bUJpNnJObGFWenl5L1N4UERN?=
 =?utf-8?B?L1FicTdlNkFNVm1MaWxoUlNyTzlQOGF0aDNRVTN6L0wwSGFIMmpFV1NZM2RR?=
 =?utf-8?B?eW9PM1BZbzlWMDdYWXV3d0RLVDYvTUNhWW43T0l4djVUTlVacGg1YzB3R0Er?=
 =?utf-8?Q?ZBo8SpBh7Qk8RXSx0tXt/TUJE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba5cc61-0df9-495f-93a8-08db924a0eed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 04:44:58.0514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Tz/onghr4a1aFLYqXpvckzxo1VfvZn9fJR2xW68VIRK5wdZFFPtBCFSZQLto+c6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
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
Cc: Bert Karwatzki <spasswolf@web.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-07-31 22:54, Srinivasan Shanmugam wrote:
> Usage of container_of is wrong here.
> struct acpi_device *adev = container_of(handle, struct acpi_device, handle)
> 
> This reverts commit 35ef33db90303589c76658207347539cf33f5ae3.
> 
> References: https://gitlab.freedesktop.org/drm/amd/-/issues/2744
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Bert Karwatzki <spasswolf@web.de>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> ---
> v2:
>  - Added missing commit id. 
> 
> 
>  drivers/gpu/drm/radeon/radeon_atpx_handler.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
> index fb4d931fdf18..595354e3ce0b 100644
> --- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
> +++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
> @@ -94,8 +94,6 @@ static union acpi_object *radeon_atpx_call(acpi_handle handle, int function,
>  	union acpi_object atpx_arg_elements[2];
>  	struct acpi_object_list atpx_arg;
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> -	struct acpi_device *adev = container_of(handle, struct acpi_device, handle);
> -	struct device *dev = &adev->dev;
>  
>  	atpx_arg.count = 2;
>  	atpx_arg.pointer = &atpx_arg_elements[0];
> @@ -117,8 +115,8 @@ static union acpi_object *radeon_atpx_call(acpi_handle handle, int function,
>  
>  	/* Fail only if calling the method fails and ATPX is supported */
>  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> -		dev_err(dev, "failed to evaluate ATPX got %s\n",
> -			acpi_format_exception(status));
> +		pr_err("failed to evaluate ATPX got %s\n",
> +		       acpi_format_exception(status));
>  		kfree(buffer.pointer);
>  		return NULL;
>  	}
> @@ -159,8 +157,6 @@ static void radeon_atpx_parse_functions(struct radeon_atpx_functions *f, u32 mas
>  static int radeon_atpx_validate(struct radeon_atpx *atpx)
>  {
>  	u32 valid_bits = 0;
> -	struct acpi_device *adev = container_of(atpx->handle, struct acpi_device, handle);
> -	struct device *dev = &adev->dev;
>  
>  	if (atpx->functions.px_params) {
>  		union acpi_object *info;
> @@ -175,7 +171,7 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
>  
>  		size = *(u16 *) info->buffer.pointer;
>  		if (size < 10) {
> -			dev_err(dev, "ATPX buffer is too small: %zu\n", size);
> +			pr_err("ATPX buffer is too small: %zu\n", size);
>  			kfree(info);
>  			return -EINVAL;
>  		}
> @@ -206,7 +202,7 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
>  
>  	atpx->is_hybrid = false;
>  	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
> -		dev_info(dev, "ATPX Hybrid Graphics\n");
> +		pr_info("ATPX Hybrid Graphics\n");
>  		/*
>  		 * Disable legacy PM methods only when pcie port PM is usable,
>  		 * otherwise the device might fail to power off or power on.

-- 
Regards,
Luben

