Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79175C47088
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 00:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D01E410E4F0;
	Thu,  1 Dec 2022 00:00:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999D210E4F0
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 00:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAyGnXnd9551FQY+aVRp+epYEaWe3Ekl3tjR4WncnvN+/REorLYGRHX5AwBC7yRbjlshGTZEU5BvFr1w4T5oxASSn3j0DvV5cALQFpIzy5r5Z+J9ZEpOrbtW4A6uLazxzBGZAwXLpyeAmG95fSxMPFXxvtjS30NeP+HXzMKFVbZWbVYws1v50ZWg+4f4xN7+0QbCMC2NHZ98i+psMHM4ENaom4jSGubHCzFLKMd4L7iwawJz5zVucH9zd0MAg2Az7PO614h0rR9W7m0T8/jLJFkF+HJoHzytuOVg72No98U4yTcAAEJzPs3UXbUxNDq+mKBAL2nkVcYdM7sfOaxL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chXp4JKe8y3Q4gfn6+59yyejHWhIjVkxVje7d2WHYGI=;
 b=ft/CI0ms8A1iqAFa299RvTGgH+9IY/0QZ6mh8RuP1/ECcu5Ez0DecnH1W+PnXxmy34Jxbn56q/ndXO5Rl6/FoUX2tIely9ZywmPgxan62Og+ZB0FK1WSZd9nSaG/itQ4kxxI2V/hdUFCEThT+pbyH/69D4FCgOtC33wwqQGMtRbF3FZPUch+GyDZpE646HIq6btWZPE5LhKOvC+ZLtompjRp7bL6jMo16gVvYbdYlWM3xAYrx/kuxjPGlWjhMQNGasxg7H/TUkDCZ/vcVtSRpHPl/bRfm674CWC0qBTauYYxBzRWTlVgsYacyBQhiUi536skQMc6vFWqgctu9XFxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chXp4JKe8y3Q4gfn6+59yyejHWhIjVkxVje7d2WHYGI=;
 b=OEfGc/hPDMLBsCXuC4DeuWVHL0FoHb8BmlVpGpmlxMHfklNRzrfD/9wwlj+0u2yjAfNCGQGEpAP6n0ZGKn3UjLYc9MXlXGLWnG80sgHjs2hFfU2Wav5WECGGaC/1Zr116+tTeoZsWNvp2bkCKPv0/+d5GOPP/7JnbClRLUm4eJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 00:00:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 00:00:48 +0000
Message-ID: <a6dc7ca7-0c50-a361-0be5-2f78ef43668e@amd.com>
Date: Wed, 30 Nov 2022 19:00:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 29/29] drm/amdkfd: bump kfd ioctl minor version for debug
 api availability
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-29-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221031162359.445805-29-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0032.namprd15.prod.outlook.com
 (2603:10b6:207:17::45) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 32494246-26d1-4c5d-ac37-08dad32f19df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YspbmpiC7bp2JX4wE/6DRc+1CvFajY9y2fPONNlTMJAjv3a4j/OprzJpw0HiaUKy0fnbv4HIQxx9bRlw/bbvwIsVVDJ0ruDC+En3VKrOtszUBIIDzyXmxTvozW4yH1jXio1uuQMewZR8WsXjTP6Vn//YGWPVGGoQHMODUcapEC7Y1MttQHlJEi8VtXOlTDbRfl2D4AQzUpmTYPc9Bhom7FMItTkHQVlfsUBS3wZzPfWxkTuS37PRYUUH5wajXuQccs6owH5tnnE1uR07+mS6BRZFJa+JQXArIIDW56qvXgrCCeJq3IxBrq453BAWV4GJ91H3TBzCAReN9uvNhmafAQzreAuPeN9MgfoUGZ5wwUxJKLmvjvfcmWcg90TDlIcz9p8HGS9zwRzxG1B8e7IE3xrb/7U7O9vXq0ORwnyuy3L9LKmZmmtSudT0DJW8KJfeVFb7EeEArStmR52BrpKoOY/RbvJhjbl6gbIkrAB3C9Z34tw70OiNAFIUVcfbkS5RsOQdTYR3e2ovAASx+iP/Av5iCoXLIXmW2wVg2eAWkfGIGoHuul5KrtmsAneFG+ZdtTaZkd3VCp9yEMK2i+wBfx+oKenCMAqhGnN8OfmeWMGfaLiV2aOfxGWQ+qOTQnjVaucFLCecX0kp4MMpaOj2Ger71/y0kXUzdI6l64KefrQMN7+5dbGlLMYQDsiAU1pKermxAgZ7zIc3zK6wEv9MGmioSoOofVyaSZHp/NkBTfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199015)(31686004)(2616005)(83380400001)(26005)(6512007)(53546011)(186003)(6506007)(66946007)(36756003)(41300700001)(66556008)(6486002)(316002)(8676002)(4001150100001)(86362001)(36916002)(66476007)(38100700002)(478600001)(31696002)(2906002)(44832011)(5660300002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZURUVHlzc2VBdnk4U2kwcFJBK0xEV1ZCY0p4MnRJZFR6N3k5RW54dzc1R29m?=
 =?utf-8?B?Z25ZQkxMOEFvZy9QZCtEOUU4RUxvZjJ5TkJrSEI1Ukp3VUc5RWdTVW1paTZp?=
 =?utf-8?B?RTZZaVZyN05kWFY1bGhaTG03eXorN0hPV2tyM1V5R294cys3akQ1emtHSG4y?=
 =?utf-8?B?Z0hsV3dKaENwS0FwTVpUNE1nMVZKNGMvcnpDQU9oVG9rRVpyUFQ4TUgzZ01S?=
 =?utf-8?B?SjJGMCtZRFFSLzFLWDcyajJTZlRXVmV4OWthMzQ4UWRBeGxCOFpCelZIRVFh?=
 =?utf-8?B?dHR1ZE0rVjZ1RVNvNDk4WmNnWHlnMmlFRzV3MTl6ZUdPekt0VjRIc1huWVlq?=
 =?utf-8?B?ZzdOLzRYaHBHN2c4QzYwOFNDQWVSNEtLaFJRc0tKU25rNVRjb1E2NG9aeFZo?=
 =?utf-8?B?Ui9xSUJCeDZWdjZ2MmZPZlVLWldyT2EraUE0S09FZjVybWxRd09uemQzVDRU?=
 =?utf-8?B?NllscEVySXg5S1JPb0tLS2p3QUlQZHNxVXZ4V3dyL0xLYVRVTXprZkdFM0dj?=
 =?utf-8?B?dVhlc3lLK0UrZTJONVMvTWxON09lMFpSanBZeC9Hb05pYmwwSkRCWURaQzN4?=
 =?utf-8?B?Kys1c3dyWnhvNlRWYTNKVzRGNzVocHFEbGdOV25nTnNRdUk3T201Vzd0bWtW?=
 =?utf-8?B?NEdHY1Y1dlhjSDFrTmdSYlFtcWwzUU4zL3lUU0FhSTJzMkRvemlUOExrWE96?=
 =?utf-8?B?U1I3bmFXV2EvMjJ6VUhMeDl0ZWg4OWxqMVVQWTB2dHdrTUxkUjR3Y0paREFI?=
 =?utf-8?B?blJzdFhoUHgyNU5oYm9wNnVxbHdDdjFESkxsTEw3MTYya3VvSGswU0pESUMr?=
 =?utf-8?B?N0Y2Q2ZDZjhodXhRdjdtUEJqYmNyekdQaGFhWk1wKzBRMXZqcGFzVWpBRDBr?=
 =?utf-8?B?ZTdOY1VxOEU2YngwZzR6UGhBNVhtalJ1eHh4MlRFMExtdUMyRjlueElkRElx?=
 =?utf-8?B?UncwS1BwelZkYzdiL2tuTHNSK1kzeFBiQmo3N0VzYkhKN3BaZlF2WW5zTFlu?=
 =?utf-8?B?RnBrWDZjU0VkS1R6TjNvUlkxTWdSYnVveTUyU2orQjA0V0hMRjBLSnRJWXFG?=
 =?utf-8?B?WDZWWEJyNDBicjV0MnJ6QkJFcGxaRVhXL01qbzB6OXhGbXlFMy9JRkVaNm1j?=
 =?utf-8?B?T0dxVmE2K3ZuaUQrNkNVNmRJSFdFZmk5V1BEZzcrUlpnZ1l4cWxURjNhdC9U?=
 =?utf-8?B?TGd2UTAyWFpReG5lWVc3dWpIMFNUdlVGamliTWpVTHJJaExQMDE3b1A4NWdz?=
 =?utf-8?B?anIyQkVIenNPUzhvbVk2VEpES204K1dyZW85MXNMNjdYTzFjL3NKc2xveTQ5?=
 =?utf-8?B?TWkyVkM5SVdJM1ZKVlpUdnZ0TjZTRDF2VWo5bmt4SHVOUVExb0p1a3dLVVVy?=
 =?utf-8?B?bzJzYTVMd283L2xXcVJocGxjRVd6OWZTTlRvcFlEamk0cnY3VnJ2dEFtaXIz?=
 =?utf-8?B?TjVxaDh6UVJSNVNrZ25YNjBMSEJYMjJJSWlBM1JiUzBNcHlkTm82SGdUTTlv?=
 =?utf-8?B?dU9YODU1MExXNWtOVXhsZmNxdmNzSGh5YjBKU25FVUJvWmZJais4Vk8wWTht?=
 =?utf-8?B?SzJJaHowVnUrUDVVQlZVTkJCME9wZHhkTHM4MTZieTJXQi81eGc5VWhseXBP?=
 =?utf-8?B?WXZLcG9rN0tHOU9BdGlkK0ZUYzFBMnBRZ3YzeUtJNzY5dFh3Y3NYYlBkajlz?=
 =?utf-8?B?TWlpSmdhQjB0Wjh0cHJyeG5ZcW5NcE9rNDhwcUttWEphcE02Y2NzbFhZRDRN?=
 =?utf-8?B?NGxVcDM5aU5zV2Y5ZlhucTI3QitOTTJRWGFheFUra0VtdWtMYjloaFhVT1g4?=
 =?utf-8?B?dndqN3d2RXNTaTQ2alcxWWx6RU1Eb0h6VjN5TjZhUFZNUm1sUDYzUmJlTWVJ?=
 =?utf-8?B?RTErLzYralRUVTJET3FJc3c3U1hSY0hKZStRREJQOHd4bVVUOFlrdWpMZ1BL?=
 =?utf-8?B?a0N4cjFhbTI1WnoxMzBtYy9weDdjSDdPUUVRZHZOUDQ4c3REY2JCV21TdXZP?=
 =?utf-8?B?dXAxU0J2dWFQalV3VjRMOFZXZHlwcUZqVm56ZGlqTUM3dlMwdG5CdUdVWVZ0?=
 =?utf-8?B?d3dYNWlLbFRFWDFHTG04T2hIdkRENVUzTStTaktaNmJTNk5xWC94VHNhKytk?=
 =?utf-8?Q?yrqTIxTwrbQYSlZV3BDCPPm70?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32494246-26d1-4c5d-ac37-08dad32f19df
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 00:00:48.1435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFATU9wTkxO+Mwn2Oi1FP2ZlJGHnhlo4+Jv0QpQmcPztp++1YsbYShRxO50IQX9oIepJ0kyvHSvEFbycjBTMgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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

On 2022-10-31 12:23, Jonathan Kim wrote:
> Bump the minor version to declare debugging capability is now
> available.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 1 -
>   include/uapi/linux/kfd_ioctl.h           | 3 ++-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 115a80686f7a..2f7d8b230527 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2891,7 +2891,6 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   		if (!r)
>   			target->exception_enable_mask = args->enable.exception_mask;
>   
> -		pr_warn("Debug functions limited\n");
>   		break;
>   	case KFD_IOC_DBG_TRAP_DISABLE:
>   		r = kfd_dbg_trap_disable(target);
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index bedf1b823f57..fe5acee2684d 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -37,9 +37,10 @@
>    * - 1.9 - Add available memory ioctl
>    * - 1.10 - Add SMI profiler event log
>    * - 1.11 - Add unified memory for ctx save/restore area
> + * - 1.12 - Add debugger API
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 11
> +#define KFD_IOCTL_MINOR_VERSION 12
>   
>   struct kfd_ioctl_get_version_args {
>   	__u32 major_version;	/* from KFD */
