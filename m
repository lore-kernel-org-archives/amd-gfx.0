Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F824EB64D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 15:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F95610E57B;
	Thu, 22 Jun 2023 15:05:23 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7897410E57B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 15:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IodepLiF1zOnHKC91Zlkt0lpXSuw5YTacfaNtQpHbSbRPI6PbcJ/LtqdbiWEJr1cIBpi3plsU9qm8OaPIl5eetzVvR2mtvMsT2eapkLNuXs/QBGwcgjSqwHk0Lf343yaMdnfTuySzpemnaZiXD+ZRCOhpFNCzk2TyNH4X6BhoQZOE1kMYDPtho9h67vtT4ujv55ha/+ZuO8uijljxXDZHF6Qaa+mNSDo/WnN5LGa5gAYzQDoGCLg6XOo0k8H/9iljO7BtCtplogoVIfYFhLNgf322A0I7DFUAPiZJLeqRmGlyrFGQc+nJNRJRAcP75lpVJH2Cev4/fgQwOUPEoSL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4NkQjfri2n1lIYkH681qUQJLvgxEKVjTnmJN5LhgNA=;
 b=WMWo/gnMr2vCGF+Cjx1gufe8YUHSMuQKCwsXJ57jD74uKrNTEINdRf7WDVpVRm0ezDblkiK4vxUssmvQ+pw/QyjfSw1YyQJjWI/698JpCsRH66JIJMSllR01PP72PzvUcqYgX1zpkyZYFvwOhlLUpZ7A+H5oaKIV0FR3LdBdtqE/LzM0kmnQK3/WQF2CfBqGj00H2YDxFpLhQJNcB7Pv/Jyet8sHFMnAryY22hROFxe7YfRVYCzObQpznV3GTLEzYOSFpUkOOLy0CLiGJMSMoD7nz/k+jIIfXBYOPKaTbOD6EAr2/FW/EY/djGB50G8TPgBtWtDo2IeBlKsJ5Jf2Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4NkQjfri2n1lIYkH681qUQJLvgxEKVjTnmJN5LhgNA=;
 b=ZQc/ADIuF11sxETEOdz2wGfuQFx4t9KTSLbV5ulIFKKRjxOidx0ARARz5BABPra2/Imwo3LQ9PTfuU8Lu4HqeWbBA0AWO/Jh0nasWim8qyvNlNt0IWm3mQqIceaQHfDg0zmnK67FjVjqaDPSRwif/Px1suP9iowp/mAvdqblYbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:05:18 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%5]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 15:05:17 +0000
Message-ID: <27ee8486-91d2-6c4c-4a58-7e3830d92891@amd.com>
Date: Thu, 22 Jun 2023 09:05:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd/display: Remove redundant braces in
 'amdgpu_dm_crtc_notify_ta_to_read()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230622093844.1088508-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230622093844.1088508-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN7PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:408:20::25) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM8PR12MB5416:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1f4987-b590-4f76-f9bc-08db7332172f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EluqABWT1CrHHgmSZsRAi3bl2HBKvTj5gmVDM5Ml6kuH7SAb1n8hbphO3XUPoWKtOx0m4wEhopdJiLrI1O9txiTSjpAqN8zEst9L0jRMHbN3qVO+ixrbwnAAxdjQeny5d6MtcQt4ZVecYQ1qX5yhxstuBmSjuph/Lr+mn7fkUIA4+5ONCDTREJug/se9RmhetuI5sGolW9U2WneKbjfhFNhUk9sg3UyfwGt1fypIkBkF2PqcHwVvO3AYHoA7n6TfYf56fp8NJYWjw1HNAs93lBWeinxq7JrSgmu4iXrTLNPjhK8lhdbLggfBhQyahL4t1gFVhQqGREDJxAVAfVuciGO5nQIvPIsB8OgmyxAqWghlY8yPRZZITY1u/lQ+Jo6BTw5v+ubFyLvj3Wi1Uv30Kj0nII9ioXaVrvTeVLN+EcVHMXiMX7gl91WAnei+uth/C8leFfyWqNIle4wKLZQ3CW2kIW3eResEWd/atFOroLqoGR+P3vhYBsXSwl4DDLbuJ1LtiUNtq03KhuQB6LLGTWOLfG9S3or/efJxzU4WSGw6uUgm0hl6XCpmaHKNpKv9j/2przGdS5USpYkLtQlhyOG1sl0KKAIxoaHxmUAnbOwB3XphHluVtx5vx/4do0dVgDxmvkPuZp9e49c4rYnyNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(53546011)(6486002)(478600001)(110136005)(6512007)(2906002)(66946007)(186003)(31696002)(8676002)(66476007)(316002)(6636002)(4326008)(8936002)(5660300002)(66556008)(41300700001)(38100700002)(6506007)(86362001)(36756003)(83380400001)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZXcy9LOUlneEUxUXlzbmpaTlMyQ1ZDeWF4RllPaEtuNGFlbHpBVFdBcWNi?=
 =?utf-8?B?ZzVFQVFUS0NuU2dsTnJObThGMmdzSkNZTEsyZUhzSHg5OGNHenNDay9adWtE?=
 =?utf-8?B?UjFZVVhsTUZlQnlwZFA4NEQ1VXo3d3RER3BPWDJkeXNrSGdlZ1I1TWZqamJL?=
 =?utf-8?B?aXVYOHNGdkFMNGV5czk2M211bEtLb1Vjc1BnbkxGSzBkUi9TRDFOeGVTdWFu?=
 =?utf-8?B?MktjaitjcER0bndJY3lCNVd3YzdXMXFtZDFUa2dxb2ZPeUZzdXZ1THpKRExI?=
 =?utf-8?B?bVpodUNINnlrWG41cm1vUURabWZPZWpFUHROTlpCeTNrcWExZlpUS01YSWtm?=
 =?utf-8?B?QWtRRFNoYWpPYllCMzJLaHFoMzB0bnRlbnI4RHQxc2p4dmlMUXZqWGNoUURU?=
 =?utf-8?B?YmlGWXMzQ3dra0ZFSytxSHAwL0hveVdaVFg2YzQ3eDZlTlVWRVBZRWR5Ti9m?=
 =?utf-8?B?R0NWeWJQaTNudXB0aGNQU1FvV3lVWm1FRGIrNS90VW1FZEhaZ0oyK3Nyb092?=
 =?utf-8?B?akxNVTI2OTIrNDhhQ2Z6V1FMNGljcG5aZGRxWnpwbVptV25xbC9CbVYzVG1l?=
 =?utf-8?B?QkpRNDFLNFZhcVVPTE5RZFRqQUtPWHVKdWtLYkNrTmpDdStSNWIwZGRuMmx0?=
 =?utf-8?B?K09SOHg2cE9RaFVxQXMwNWQ3blBnRnpXbjR2QlV0c0l6VUx4aERpbG1hWFdt?=
 =?utf-8?B?Y29Zc2U3K2JvM2FWWk9MUlVyUlFMQjBEUlIrc3k4YXhuci9BKzV6bjRZY1oz?=
 =?utf-8?B?NWZSVVdZWkZpY3NBSVFPV0ZwdTFhQ2NUKzRRUmVLakN0cFNUZlJpcHVWTjFZ?=
 =?utf-8?B?R2R0a0tmZmx6cHlWM0dmeUhkRXVDcVRiRXY3WHJYTjN1cXoxR2xXdGgvejZ4?=
 =?utf-8?B?clR6Yy9zVlZ4U29zU05BQ3N4L3dqU2pqdkorNFN6d1lGdzZaRUhvSGk0aVAw?=
 =?utf-8?B?RDZSaSt2ZzhsblFGOFl0RTdzZ3owZkFBblQrVEJ1LzdrVExJUnZWYmt6d1J1?=
 =?utf-8?B?UUpUc0dpKzFvT3BtQU5ycmR4cThScEVRSytSNXJYQ3hMUnczeTVjNUdOUG1V?=
 =?utf-8?B?c0MrdnNob0xpS2pXMTErSEViT0hEcVBHK25HVkdhK3plWVJVTHd0WFZjak84?=
 =?utf-8?B?Tmd6TE1QNWgvSUpOOXN1N3FPa3haME50WkJmaGwzSUVJQ2VFam5kT3pwOURN?=
 =?utf-8?B?NC9VSjVoRGJ4QTlDQ0M1eEkxcml2WWdVbUZkYi8zdHdBVERIbmxpK0orVHdp?=
 =?utf-8?B?bnVEL3pBYXJoVzhvVWJmMURuUWRUOVA2V013RzQ1OVVNbjVRS2wxd0lRR3Fy?=
 =?utf-8?B?VEhZaWdYa3BhbUZuaWNjN1Y1NTJVWHNkYkxvU0xMb2VJYVBueWxXdW1VN0Ix?=
 =?utf-8?B?MkJSRHJ3OXNtM2VzWjlqZ0VhQ1ZnMlcyRGw3aU5uSWlLT0cwZnlnVlphMkl0?=
 =?utf-8?B?ejAwUG5oSFZLOVhlSHc1NWdzay9IOHl3RFNZMUIzRjFrVW1JZGFsWjNzWlk5?=
 =?utf-8?B?Nm8zc3dLWE5sRW1NbC9MbVJrSVNRLzY0M3p2bTdEUDVWbEkyemp5eWJTcnVD?=
 =?utf-8?B?STZkZzgwWE95c1ZaaVY3am1TM0RGUm02Rk55QUluUmRzUWcyMVg0SzRkQTl5?=
 =?utf-8?B?ZFhKOE0xaE5rV0h3bHgxUDdEazZCZWd4T2R5dTFXdTdqSjRUTGJ0UlZoSmRo?=
 =?utf-8?B?SlZKdms4T1dRekdIZlBGQU1kUDV1YWJKTzl1aFFRVUxFTjRxekJTakhjSVUx?=
 =?utf-8?B?U0pMUDVSaUVSWDFTaDQ3c2thejZWb2lqcmIxcVRkQkF0bGRIaVpoLzdMMm8r?=
 =?utf-8?B?eG9idWhrK3F3SWhJaWc0S01sVG1hQXJDQ00vNjZaaVdWdkVPVXNKL21MU3VD?=
 =?utf-8?B?TDViZTJISWFYRTY4b0lJbHRNZlgycDVoeHg4eVZYdEJOMjFYR3FhSjNyb1dz?=
 =?utf-8?B?M2JzdFU1eHJPcHk0SXFqMG44U2hzaG91V0V0Z29DRXB0MGtxU00wVE5HUkxn?=
 =?utf-8?B?STIyOWtoY2xiNzIrandiMVFZc2lHNVRqMVVDYm0rek5iUHQvWUVIZ0dJU1BJ?=
 =?utf-8?B?S0tMY25EaFo5S3g2dm4wa0ZqdVdRV3hmK2ZTTW5xWlBlRkRGcjBqMlhDK3ZN?=
 =?utf-8?B?Y0orTWpJa3dUN0I5SjRXMk9SNVlHVXRwVTBNVFg3VldOcElKRVFIbFhFSmVZ?=
 =?utf-8?Q?uwbpZgrQr3aBNrp0S1skmD+pK/5qZFB6IAsDsr/oD+J/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1f4987-b590-4f76-f9bc-08db7332172f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:05:17.8849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgP7N3hFQkkqswEbphQ+ayHZFc3TFkITfesuWlNVyp2gEKItnSxgQgleVxR7VNT/a2JwM8xmBYQeCpsBqTyIfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/22/23 03:38, Srinivasan Shanmugam wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: braces {} are not necessary for single statement blocks
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> index 0802f8e8fac5..52ecfa746b54 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> @@ -123,9 +123,8 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
>   	secure_display_ctx = container_of(work, struct secure_display_context, notify_ta_work);
>   	crtc = secure_display_ctx->crtc;
>   
> -	if (!crtc) {
> +	if (!crtc)
>   		return;
> -	}
>   
>   	psp = &drm_to_adev(crtc->dev)->psp;
>   
> @@ -151,9 +150,8 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
>   	ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
>   
>   	if (!ret) {
> -		if (securedisplay_cmd->status != TA_SECUREDISPLAY_STATUS__SUCCESS) {
> +		if (securedisplay_cmd->status != TA_SECUREDISPLAY_STATUS__SUCCESS)
>   			psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
> -		}
>   	}
>   
>   	mutex_unlock(&psp->securedisplay_context.mutex);

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
