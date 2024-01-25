Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87108C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 07:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E147110F81D;
	Thu, 25 Jan 2024 07:45:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8240310F81D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 07:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlL5ubk43sdwSA6oW2K5r/tEjUPuywHKPTooQnFUyIU/S7tD5fD4SNGYZ7C7V4shjMsE3llZSdrWFP+mTScBhei0QCJXWoI8tu19b7L1/vF4zBB4cJoCI0hXbm4JM2pgxokz3bPsYD7UUDzwcK/N6FdiBKtCE7aDxc8W3lIMyCehI/nv6WpMTEJOFIKCTU0G3o4/IZlCt3vFd9+4cmcMFT/k100jF6Dq5NqOwveDHGHJA2EIFsSWFsegTLB1PFRna9xJYDB3nXMkJQz6M3SZjxTBRHrje2N/5shzlk3e31KpmyiGwGxqVPM+LZoCUGXF+odme4TaMYxbO3KmGCa07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eJ9GGBvGIJq7A4iDiU7GjWbdGV64AcnHf/WX5JjeTk=;
 b=bgvUUDciqgBgMxWe11yxZNqSbagSZlqlJjAcUDD22V7KMG+eQS+nRdioamMoCJlorCIuOWiJ1C9kN6HZaaeDcC9cKZCFMXjgxRUNUfRMMKcUFaBECqMILy7nOYNrKH2zCyTX3+xGHmRbLRtk2Z5QkG99ufULiv73kGShY7fvzy0zAa7Ez9vTCn/rxZqMtPiO+p1KE1h5BTz+4gGO9NijRXc9nw/yFL/zB2rBUxwhe6Li37XEIs+n5L5TojIajam2h1+Ctcl/0kB9oTVp3cH+hE75/VvC/jmRXPc9lAGZGQKPZuvSU9m71L+k28WagsgZd7+oxepJyoUVGTj4BAsqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eJ9GGBvGIJq7A4iDiU7GjWbdGV64AcnHf/WX5JjeTk=;
 b=SzT1UAyFMG4g+twFBpmlDfi8nxaWuFVDinUUXtvt0Cc+XguhI4crp6q4/hibWkSFBfbHdy37l+J4/y5culcgoaKv0aFjj9mzob9FyW/17KPOM89+2r/p+4D/rLGihG/W8OFb0hi3k/ZTHSWPItY8XrTTbxuvFBxnr2Cb/cDz1WU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.30; Thu, 25 Jan 2024 07:45:26 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720%4]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 07:45:26 +0000
Message-ID: <aede3f57-1b14-40e6-909c-a5f5a1366c11@amd.com>
Date: Thu, 25 Jan 2024 15:45:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu/pm: Use macro definitions in the smu IH
 process function
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240123081326.1066121-1-Jun.Ma2@amd.com>
 <20240123081326.1066121-2-Jun.Ma2@amd.com>
 <PH7PR12MB5997873C916E57FB0D72CFE282742@PH7PR12MB5997.namprd12.prod.outlook.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <PH7PR12MB5997873C916E57FB0D72CFE282742@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 830d992b-5a45-4b6d-788b-08dc1d799827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYKv5SAds141rIZ101BagaMqNKfldU0JIMhSuJzm3XUi0uCTusVHElXcAiixFDRNwOpJqaHpy5GcqAokj2CRqIyMh1HbDmLzfGhi9+fjfsz/NIRsM68G4xhM8qcr5oxLjnTRfjzSlhHcyjAnNz1vv+30mEfQuMHZdz2yfTu4Xb6f5Le1RmBIQJLjE2xvuwKnVonh6/RsstbgJvbcm4aQ/w+PsGZEtWfe1JHiGhP+8VrXiUx2Zx02MzZkgLNlTA0DV2NgMPxoGI4an0g65qBq6zux1J4hWB14eAPjLI7uayz56zmkv1Q6eVAbk/syVi1EsOPFHMQUEgWZFBOxDrmQh+LdGezyKuKD44Msa5XmUw5cRSocbXK6m4d64Zn8RE6VKl0ssD10SZUENqbLA1drkSdHKDxVms+ZAjyBRObzg/VsTpyJ5TuLrV/eoci0yowWlmkAjxt6X2ZgnjJdrLAwcY0tv30245Oy5eVsvsgJTUG258nki6EsWOmS7oxuonk8BkE5tGw3kQK9Kv1yMv3igY8kio7nJLiw+xFSEBwync4+f+oKF2FFa55palll9y0jcnF0le48EGGSSiaLHYL7CvWt0D4IYIYcj0A6Thrn/IG0WG3p97n8dxBgb8bTVeGaLB3vK2MmSRFwizxSU4ckwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(54906003)(6512007)(66946007)(110136005)(5660300002)(26005)(316002)(6486002)(4326008)(6666004)(2906002)(478600001)(66476007)(8676002)(6506007)(53546011)(66556008)(8936002)(2616005)(31696002)(36756003)(41300700001)(83380400001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnBWTmRVa2pXMDBmYzRsNFB3eVZXRW5zc1gxajRNSllGSUJsdWU0TEpYU2x2?=
 =?utf-8?B?Qmt1RzR3c1lyNVFvWnNCMFkyYTR5M2JlOUozSDg2VWIxemZtWldjcm4rMXZL?=
 =?utf-8?B?bkZMZHQxMDZpZ1F6b3FzdFppSjFpTlZDbGhTZUtsVDNwYXIrS05BQWp4WFZH?=
 =?utf-8?B?eldyL29nUXlWcTdrT3ZZdWRWNmpiWVBpMXd2eUxxcmlkTUI4NVF4RkVDS25E?=
 =?utf-8?B?NFBXVFF2UUF1OW9GcDVUVWJIeDlJeVZvV0M1MmludlhnTTR0T3RIMGZBTEY5?=
 =?utf-8?B?TSt4RVQzcXMvZUFHOGxVekUybjhyanlJRk1WM1lMYjBUMEYzYkF3bExEUVZ0?=
 =?utf-8?B?cVNONllwRGtmVnQyc3BBQjUxVFZFVWQxUFJsVjJUT2dtczZJMklrWldFZmk2?=
 =?utf-8?B?bW9LWDdoUEFTSmZWbXVNTEhBVGZGQ0d0T3h6TDBFcVViNS9Pd2RqWHFvTmlW?=
 =?utf-8?B?OXVXdERXUEhKZG5TZDA2djFtRXdnUzVtbFYvQi9IYjVBcTJaaFJZbFI4UE9G?=
 =?utf-8?B?Lzh4RmJmOG9qR1JPS0srZGFhSEJlakxldkcrTlpOeVlPNTRobjNWcDR1aUtP?=
 =?utf-8?B?QlVWRFFsb3lMREVYenQ1ZlhKbzJVcXF0TU04Z1pkY2R3Vmh4ZkI3T1NyUVlL?=
 =?utf-8?B?czFYN3E5L2VzUUlpSURVS3k2V1JyUUIzNkM5YVR6cW9DYlJ6Y3JhMzFSaHBZ?=
 =?utf-8?B?cHhnb3lPMnU3MzI3ZlV3eDZUdVUyeEpqZjdyM2FmNmRPV0VTL3lvQzZpZm03?=
 =?utf-8?B?ZngwRTVHRiszY2FtUWloZlVZMnRDaGpYKzdnVVhnamlicThRZFRMVGxhSldS?=
 =?utf-8?B?dkNqOWNtR3FWTlpKSjVFUFQrenR3M0FRTXhTdy9kWm5xcGNNQlQza1EzVXpV?=
 =?utf-8?B?cHBUUUtQU0E4ZTRaQ1p2NkxTZjhBRitFQlhPUStiQ0EvUWVvcVdqTDVxWDY3?=
 =?utf-8?B?eGl6bVZKNWFTWFd4aUtFcWo2SWVVeVd5WEoxSjBNMXlpTXdYZHM5VlNnNThX?=
 =?utf-8?B?b3F4VkQvY3hZRFFidkk4YmVMYmIySWIxempDOXdYWFYzdTkrWCtBdnMvNUZq?=
 =?utf-8?B?b1A0MzhJbndVbyszQ2NlZStGMHl6bFBZVzlndFhUV0EzSy9CaFpIeTZ2SVJQ?=
 =?utf-8?B?UElpVmFCRGQ4QnFsQXpoaTlGcjRESHBScWMwWllsYjI5czNYclJzL0xXbk9E?=
 =?utf-8?B?amlDbERPNCthSkdBZlFFNVowQ1BxVFErajBDa1lXd2xrMHh3UHlWb0c5Z3Y1?=
 =?utf-8?B?WDZBbnR2dFpIOEUwTjlqRk1McXdQTTN1WlA2TDNpbE8vMlo1MVF1UDk5bzdM?=
 =?utf-8?B?QWFCU00vY0dwd3dzYlZYWTJqL3dyYjUweE1rTW10b3NtU1A0Y3ZEUXNUdnps?=
 =?utf-8?B?czhPNHRUUS9FVWQydWNvUEZwWjZZWHdUYVd4NnNqN0NmNVZMR2h3T3dIU3V2?=
 =?utf-8?B?SjlxdzRNcmMvWHoreW9iLy9iWUdxeks0eU1hTFFNWThYNVl6bUlIdUREMllR?=
 =?utf-8?B?NEswSS9vU3NDK0NCWXNGMUptTWZpRDlUaXhNOUVXamFXSk54N1R5RG4weUNr?=
 =?utf-8?B?Rk1pdkZycE1BekJxd2h2REQ3NmtKNmF1aVhUdEU3NEU1V1F0eUg3dEZNNm5Y?=
 =?utf-8?B?dFlDMzkwKzVWa1N1amxNWHR0NVJyd3U2Q1pEVCs5MkxxQmhrSkVaem1oT2k3?=
 =?utf-8?B?NGlHKy9GYUlZMnRqYVdRMXNDK0gyTTgvbHprYzFIdHJuMHd1bHJkYUgrSjc1?=
 =?utf-8?B?MlBaaFdLUDJ0bThjR3oxd0RpZmVUS1BqbW1QR3d1Zzl2S2JOVjNDMStQT2lE?=
 =?utf-8?B?TEdxS0ZKWnM4L1RBaFZYWC9XMTBpZEl2UDhKdjBkZUoySW9sbmdSaERKNkJM?=
 =?utf-8?B?amF5aTFab3RiYVdqdllNN2NkSG9zclVYOElNRnBzK3lSSEhYSlZPR0JJRFRS?=
 =?utf-8?B?SkZnazNiZWhrRWNXTVVWcHNoUnI5N0xIZGNmZFdSVHJ4d0xmR3BzYXBZQWFi?=
 =?utf-8?B?VFVBLzNNZU9vOGRYQXRlYTQ4NWZvWmpuMFhza2NpZlJubzBDc0xOdGFMTjNY?=
 =?utf-8?B?a2FCT1pSU2dTUkN1NEk5VUF2bGk2US91d1RDZ295RDdEY2tBWSt6WDYrcHRR?=
 =?utf-8?Q?2nNy24gbEUHbQzQ+mXSvVmc7H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830d992b-5a45-4b6d-788b-08dc1d799827
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 07:45:26.3791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOc+Ni+JGWVHgfrjQaO4MwBtNqA6Efi6LRAvnTPYpGpRP+/vAKFf9KJvOnw1TyoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Kevin,

On 1/23/2024 8:08 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - General]
> 
> HI Jun,
> 
> I don't think it's necessary to delete these definitions in smu driver_if.h.
> Adding a prefix can be used to distinguish definitions in the driver and can also make it easier for us to track problems. E.g: SMU_IH_INTERRUPT_ID_TO_DRIVER
> And definitions in the smu_cmn.h file will cause definition conflicts in all subsequent driver if files, we try to avoid modifying the driver_if file and have kept synchronization with pmfw.
> 
In general, we do need to follow the above rules.
But smu_v13_0_irq_process() is a common function used by other asics.
Defining these macros in the corresponding smu driver_if.h will cause the
compile error.

Regards,
Ma Jun
> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: Ma, Jun <Jun.Ma2@amd.com>
> Sent: Tuesday, January 23, 2024 4:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
> Subject: [PATCH v2 2/2] drm/amdgpu/pm: Use macro definitions in the smu IH process function
> 
> Replace the hard-coded numbers with macro definition
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h | 11 -----------  .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h |  4 ----  .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h | 11 -----------
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 10 +++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     | 14 +++++++-------
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             | 10 ++++++++++
>  7 files changed, 23 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
> index b114d14fc053..91229b2dadb5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
> @@ -1618,15 +1618,4 @@ typedef struct {
>  #define TABLE_WIFIBAND                12
>  #define TABLE_COUNT                   13
> 
> -//IH Interupt ID
> -#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
> -#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
> -#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
> -#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
> -#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
> -#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
> -#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
> -#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
> -#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
> -
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
> index ced348d2e8bb..957b177414a9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
> @@ -209,10 +209,6 @@ typedef struct {
>    float    minPsmVoltage[30];
>  } AvfsDebugTableXcd_t;
> 
> -// Defines used for IH-based thermal interrupts to GFX driver - A/X only
> -#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
> -#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
> -
>  //thermal over-temp mask defines for IH interrupt to host
>  #define THROTTLER_PROCHOT_BIT           0
>  #define THROTTLER_PPT_BIT               1
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
> index 8b1496f8ce58..33937c1d984f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
> @@ -1608,15 +1608,4 @@ typedef struct {
>  #define TABLE_WIFIBAND                12
>  #define TABLE_COUNT                   13
> 
> -//IH Interupt ID
> -#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
> -#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
> -#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
> -#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
> -#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
> -#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
> -#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
> -#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
> -#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
> -
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index fbeb31bf9e48..ddf435cdddfa 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1432,24 +1432,24 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>                 dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>                 orderly_poweroff(true);
>         } else if (client_id == SOC15_IH_CLIENTID_MP1) {
> -               if (src_id == 0xfe) {
> +               if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
>                         /* ACK SMUToHost interrupt */
>                         data = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
>                         data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
>                         WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data);
> 
>                         switch (ctxid) {
> -                       case 0x3:
> +                       case IH_INTERRUPT_CONTEXT_ID_AC:
>                                 dev_dbg(adev->dev, "Switched to AC mode!\n");
>                                 schedule_work(&smu->interrupt_work);
>                                 adev->pm.ac_power = true;
>                                 break;
> -                       case 0x4:
> +                       case IH_INTERRUPT_CONTEXT_ID_DC:
>                                 dev_dbg(adev->dev, "Switched to DC mode!\n");
>                                 schedule_work(&smu->interrupt_work);
>                                 adev->pm.ac_power = false;
>                                 break;
> -                       case 0x7:
> +                       case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
>                                 /*
>                                  * Increment the throttle interrupt counter
>                                  */
> @@ -1508,7 +1508,7 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
>                 return ret;
> 
>         ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> -                               0xfe,
> +                               IH_INTERRUPT_ID_TO_DRIVER,
>                                 irq_src);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 1db74c0b5257..9277c5dff5e4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1368,24 +1368,24 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>                 dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>                 orderly_poweroff(true);
>         } else if (client_id == SOC15_IH_CLIENTID_MP1) {
> -               if (src_id == 0xfe) {
> +               if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
>                         /* ACK SMUToHost interrupt */
>                         data = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
>                         data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
>                         WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, data);
> 
>                         switch (ctxid) {
> -                       case 0x3:
> +                       case IH_INTERRUPT_CONTEXT_ID_AC:
>                                 dev_dbg(adev->dev, "Switched to AC mode!\n");
>                                 smu_v13_0_ack_ac_dc_interrupt(smu);
>                                 adev->pm.ac_power = true;
>                                 break;
> -                       case 0x4:
> +                       case IH_INTERRUPT_CONTEXT_ID_DC:
>                                 dev_dbg(adev->dev, "Switched to DC mode!\n");
>                                 smu_v13_0_ack_ac_dc_interrupt(smu);
>                                 adev->pm.ac_power = false;
>                                 break;
> -                       case 0x7:
> +                       case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
>                                 /*
>                                  * Increment the throttle interrupt counter
>                                  */
> @@ -1398,7 +1398,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>                                         schedule_work(&smu->throttling_logging_work);
> 
>                                 break;
> -                       case 0x8:
> +                       case IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL:
>                                 high = smu->thermal_range.software_shutdown_temp +
>                                         smu->thermal_range.software_shutdown_temp_offset;
>                                 high = min_t(typeof(high),
> @@ -1415,7 +1415,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>                                 data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
>                                 WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
>                                 break;
> -                       case 0x9:
> +                       case IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY:
>                                 high = min_t(typeof(high),
>                                              SMU_THERMAL_MAXIMUM_ALERT_TEMP,
>                                              smu->thermal_range.software_shutdown_temp);
> @@ -1476,7 +1476,7 @@ int smu_v13_0_register_irq_handler(struct smu_context *smu)
>                 return ret;
> 
>         ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> -                               0xfe,
> +                               IH_INTERRUPT_ID_TO_DRIVER,
>                                 irq_src);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 4894f7ee737b..9a8b7fd6995d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -892,7 +892,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu)
>         // TODO: THM related
> 
>         ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> -                               0xfe,
> +                               IH_INTERRUPT_ID_TO_DRIVER,
>                                 irq_src);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index cc590e27d88a..9d5d1afe4137 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -30,6 +30,16 @@
>  #define FDO_PWM_MODE_STATIC  1
>  #define FDO_PWM_MODE_STATIC_RPM 5
> 
> +#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
> +#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
> +#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
> +#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
> +#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
> +#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
> +#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
> +#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
> +#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
> +
>  extern const int link_speed[];
> 
>  /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
> --
> 2.34.1
> 
