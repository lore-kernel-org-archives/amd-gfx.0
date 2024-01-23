Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35797C47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 09:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB79810E483;
	Tue, 23 Jan 2024 09:17:20 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1D510E162
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 09:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndZK/JxGUaGo3uHWO9Il+NlX+ruDXPQia0UbrkhB3vBMlM8f2NAlK95zcrQls4ORdNmiP6XDrFukDE+/4I8kRU1xxQZMXZ4YhbSzRP0jYGhwfZxB4vP2AodImyiw4Ln0gLFN6Yl69C2pyPsnb4yImFSeRxt/qjswIeNxuioSvpmLr04hdQ2ezG9430TBFIDO9icZQOvJiDXGPFSQ8raqQzZvU/+SCVZY45e2xws6udHmvJ3kCRM9h4rJhrQp5CwZCSvpXDfFuoyuMFbk+XFjWyLJTmZqDy3MAjut8SrnBi4/LPsJTUTInJ0NisrqHmRW9BV8Q1kjenaPCu+Kr20k7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtuAJUPVqlo0vM9wu9QsX5mFcrAzktn+Oe+YKjgJ9c4=;
 b=ePivdcq7z7HgtEGup4uJGV7p+MPtiik+jhntu6U+P2oP/gMhIcuEsESTb+Wms42coXxItPWtxIzzY8CYaVDBEl2hsTwxo3TEKLCA6KwoEJv7HDWby+/+hnaBs1/Krs1PNbjY+oYZv/BzT3/83Bhx/dKehNjayW9EDwj0H8BsemxVKWcIw3C9t+N9BnBUUCwgmQfx5Y8bE9UHlvGjX6tjySuo6Lf+qzF2P0ilC+Wo9gKt/sF+RnFI9rzZcwVuJXbEW1u14HokV3A91kfqjcPPyOs6ZxB3KGR3F41bx1CLgCGuRCsex7JcVDGsKXmSjyRofH31e50An6sz19hhGB8iMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtuAJUPVqlo0vM9wu9QsX5mFcrAzktn+Oe+YKjgJ9c4=;
 b=me+B5VQ7ItSX0yfZMz3VJU532YIXEm3WGposPd2pG/C7SHJ8g2slmN4kNL1hkVCmLg74rsoM97CeWJbwrnXVLJewgLyMp0So1b1rdU3HTbYpmAmbReE5XfZMg4rhQDedhCJIIHqnQaam1neSW7iU9BjHrjFDaknFwAEPHwU+T2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 09:17:07 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 09:17:07 +0000
Message-ID: <a3a825f2-a0c8-4516-bf31-3e6ecf2b093c@amd.com>
Date: Tue, 23 Jan 2024 14:46:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu/pm: Use macro definitions in the smu IH
 process function
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240123081326.1066121-1-Jun.Ma2@amd.com>
 <20240123081326.1066121-2-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240123081326.1066121-2-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 126e5c69-ef1e-4f73-19f7-08dc1bf41235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wtjXODlidWkURBC0UIeHQWjR9Lk7JOYAZ8e0scmhpEG4dAptzFqaree8tq5mka8W84WhrXbEOIZLrOvn6O077nyUP7T0v5auEWt2fugnNiGK8sotkaRmOOsizvi+m995PGADH1wtG3MT9+0jcB31ZwnsTxhc+7uhOAXKvxrGPChdTp7g6NucIhKhK9LS3ZEgk4hZnPyS+N/Ck7vwUdWFQdCTEPPYk65Fwv+mGbRskiNmQ49SW0aY8KcLF6bVn6TMsN0ueX9RM5woV925DBREBENYwe9flpkMSYihPkhGDHbWNetTHIh5tBf4vgFazmTkcr3H9aW8tpY+qNDq+jaZKMWNdIelC5JCFcy8MF+O2nDfTSBezvcQyI7I39oHjG2tKkVUC3Q9heJTQyI0Wh+2FJQDfE54HItKHsf/WScgQcao2fvQ8X4N7gcUzii9UZ1B0FeBvoLXdff5bIl7aRcBdwI14Bq4DHxZdkjVm7Z5e0fIpczC9vWX+AtGs5goNnvWx5MCT+o5XYjlgODjBqC0aLYEt0S7KG1qUWMpKf1tHLSvBGlF8XneInCz2eo14zxkkec5G40BxjUpafKM6jwYMBc1HzTmAS7jx0Qatzm9RL+4362mBfD2FQDx3T2XLRgpXyN2VJO55DBfKn75L0RQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8936002)(8676002)(4326008)(316002)(36756003)(5660300002)(66946007)(66476007)(66556008)(6506007)(2906002)(86362001)(41300700001)(31696002)(26005)(83380400001)(38100700002)(6666004)(478600001)(6486002)(2616005)(6512007)(53546011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWdsQyswQUZUWVd3dndIeHRsaG9OSm5peWxJS1dod0JTVFRYVTlaUmJKS0tY?=
 =?utf-8?B?RDRMYUtxOUlBN2s1RU9oL0ZGb0cwRU8wVGFPMTFHelNaalhnT1lublZZYlo0?=
 =?utf-8?B?WnB3T2Q1WFdTU2xiekEvTHlOOUUyZHU0UFFteXBiMXA3TjJ1YWU5bWRCSFNO?=
 =?utf-8?B?TDgyMTJCenlVNS8yTDF5Y0tubUlWK1BVdlYrZlR1T1pXT3BDbEd5MDlMZkdM?=
 =?utf-8?B?dWlyTzgyL3M2VXkzTXIwU1A2bmJ3MjZzYWtIQTVRemRWOTdKUTFNL00yazVo?=
 =?utf-8?B?Ynh0TjhxdXNNUUYrM3p6d0xISGNzbnZHeUlpenZlMkVpSzhvSVJUK2pYLytB?=
 =?utf-8?B?akhBcldVYUpNTFExcmdPTktNb0ZoRG9oZ2hJSTdrTGlyVEp2WXFYYUx6a0x3?=
 =?utf-8?B?amxSR08vcFYyZ0VVNVdwNXYwdndpc3ByL3NIUGFpWE9vSGxndmFGSEx4Y3RU?=
 =?utf-8?B?TDRJbXltdGw3MzMrWlFaQ3E1OXhQczRSR0JlVXFSM29UUWk4UzBJS0U0eWJz?=
 =?utf-8?B?YWpvY1hrUWhsZ3NJZlU2eWxLaENhaHNpOVZZazBDZEpDK0RwMDBmQUViZUNo?=
 =?utf-8?B?a0tncjVJOUJUM29ZQ3hMZjVVSmMzQWQrNDh5THljbzhSWVh2YnpYWElVbHpE?=
 =?utf-8?B?NTFhV1ZIMVBZM1BMWWRqcjBuSGtPNkwydVQ4MU82Vy9EQTRUMDFIT2Vvb0Nu?=
 =?utf-8?B?ZHgwandMVmlITzJpUk5aeUJ2b2JWalo3dS84WDFMOSt6QjlXcGhjenZyVHVv?=
 =?utf-8?B?Z01JS201VWJBeXJYb0Q2eWloY3N6Y0Q3V2dPNnlXSlVwblRrVGtjT2VPNnBS?=
 =?utf-8?B?NWpTalFZMEwwZytUS2ZTVnpMM3pscXJGempzWXY1aE9GWUZsdXR3eTlCRkhp?=
 =?utf-8?B?dUVMNzhjWGFXUVJYSk5rZ2xPc0pBdWhEQVE2V2JoR0w0K1FTTmwwdlVveDhW?=
 =?utf-8?B?aHdST2RUZGNGQ1p6VXd2anRSZ09MZGc2MWRSWWgwRklSRFNUSlpxelB6Nms0?=
 =?utf-8?B?aklDdCtvcEZ5UkVRT2tjQzMxQi83Y21vU0ZyeFY0a3B5enRjcFlUemU4VlFr?=
 =?utf-8?B?UlpYTFRyTUY1a1dtVVczby84UE9rOWpIRTJ1clRzRVBYWXhhRHAyT211cEdC?=
 =?utf-8?B?WVpBVkFxYUNUSEluYUk4cktVUlp6c3AzVkpSRjdmaVR0YmY4MTN6N05OR0hS?=
 =?utf-8?B?NGhrUEZDdVpSeEIrbnZmU3BNcVErWDdhZmUrUTZEMGZPZ1FncVFVMFpFdWpO?=
 =?utf-8?B?KzkyaENMV2tHcEFuOVdQL1JVRk5XVy9XbHBQRkhmMk5wNTA1bmVIK0o3MEFy?=
 =?utf-8?B?YkxCV1NOa0VnTkxlMFFXUkcvOEZNQm9Qd1dPdjFHTlVzTGJ2OGZJR2hJUFlD?=
 =?utf-8?B?UW9HWHBxbGJOZ2xGS2lEZW56NVF1UWY1NmIwazFjbWdQMGlnb1hDODBicEZq?=
 =?utf-8?B?YTVFdkZ1V1VhMmlseDA1c2lkc0VRWHJXTHg0TytEbVh2T2xlOE5WTUhmejM5?=
 =?utf-8?B?UkdlSzlYWmtUNWQySkFNdXZNZ0hZRWhCRCs2alJLRTVMakszZTM1ZTRzUHll?=
 =?utf-8?B?ZmJyYmhrMHZUZUhnZ0xSTDROYWZIWEtlNXRJVVhvcVN3Q3Q5SUV5R3ZMYy9w?=
 =?utf-8?B?S3BPdHgvaEhPc2pxZVpNR0xrNm9MSkQ4YTQ4MjNXMk5oeTBONkJRMGhqd0RE?=
 =?utf-8?B?TmhBU2JBK1diZ0wyYVV4dkZvQnZ6eGNwR0pJZTZjNk1saFNzUWRCbmFFQ0R5?=
 =?utf-8?B?WWQ2bDdtVnJFWlBPREdJL3RJTVdlUzBwWFZ3a1hPZjRYUCsxaGgwSmluYXdz?=
 =?utf-8?B?NGJRTmwrektlUk9XeDB4Zi9mU2xsRjBrNHI1ZUJEd1ltKzdpMnBSZWFOdmNa?=
 =?utf-8?B?SUszQTRqcENSbGl1N2FuNkVadXhBNnNrU3Z6MkhyYytyUXh3TWNDUk9mNjRQ?=
 =?utf-8?B?WWhwVStjTzdCcmxKSzRyY2hXQ2ltWkQzUXN5b1hRODlMRisrSDZ2R2tScDNR?=
 =?utf-8?B?bUNqbmNRTVVWNXhXcHFaMy8vNEd6eGJURit5UkZpb29iYnk2TEN1SXVmS3NN?=
 =?utf-8?B?anJoWDJpS1BBdU9yQUk5c3ROVlByVkhhMXB0eFdQR2k4cmdBaWZpdTBaaW1o?=
 =?utf-8?Q?PdoTlHYF+eaxPCmgtWuDpLxIu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126e5c69-ef1e-4f73-19f7-08dc1bf41235
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 09:17:07.4421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1be4JMa3kKGSBcasRhrhYUvXY5gRYt4Kg8X0AR5NqE+X44YwnjTrLKh0QT1wUwuc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/23/2024 1:43 PM, Ma Jun wrote:
> Replace the hard-coded numbers with macro definition
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h | 11 -----------
>  .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h |  4 ----
>  .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h | 11 -----------
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
>  		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>  		orderly_poweroff(true);
>  	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
> -		if (src_id == 0xfe) {
> +		if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
>  			/* ACK SMUToHost interrupt */
>  			data = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
>  			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
>  			WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data);
>  
>  			switch (ctxid) {
> -			case 0x3:
> +			case IH_INTERRUPT_CONTEXT_ID_AC:
>  				dev_dbg(adev->dev, "Switched to AC mode!\n");
>  				schedule_work(&smu->interrupt_work);
>  				adev->pm.ac_power = true;
>  				break;
> -			case 0x4:
> +			case IH_INTERRUPT_CONTEXT_ID_DC:
>  				dev_dbg(adev->dev, "Switched to DC mode!\n");
>  				schedule_work(&smu->interrupt_work);
>  				adev->pm.ac_power = false;
>  				break;
> -			case 0x7:
> +			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
>  				/*
>  				 * Increment the throttle interrupt counter
>  				 */
> @@ -1508,7 +1508,7 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
>  		return ret;
>  
>  	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> -				0xfe,
> +				IH_INTERRUPT_ID_TO_DRIVER,
>  				irq_src);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 1db74c0b5257..9277c5dff5e4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1368,24 +1368,24 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>  		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>  		orderly_poweroff(true);
>  	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
> -		if (src_id == 0xfe) {
> +		if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
>  			/* ACK SMUToHost interrupt */
>  			data = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
>  			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
>  			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, data);
>  
>  			switch (ctxid) {
> -			case 0x3:
> +			case IH_INTERRUPT_CONTEXT_ID_AC:
>  				dev_dbg(adev->dev, "Switched to AC mode!\n");
>  				smu_v13_0_ack_ac_dc_interrupt(smu);
>  				adev->pm.ac_power = true;
>  				break;
> -			case 0x4:
> +			case IH_INTERRUPT_CONTEXT_ID_DC:
>  				dev_dbg(adev->dev, "Switched to DC mode!\n");
>  				smu_v13_0_ack_ac_dc_interrupt(smu);
>  				adev->pm.ac_power = false;
>  				break;
> -			case 0x7:
> +			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
>  				/*
>  				 * Increment the throttle interrupt counter
>  				 */
> @@ -1398,7 +1398,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>  					schedule_work(&smu->throttling_logging_work);
>  
>  				break;
> -			case 0x8:
> +			case IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL:
>  				high = smu->thermal_range.software_shutdown_temp +
>  					smu->thermal_range.software_shutdown_temp_offset;
>  				high = min_t(typeof(high),
> @@ -1415,7 +1415,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>  				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
>  				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
>  				break;
> -			case 0x9:
> +			case IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY:
>  				high = min_t(typeof(high),
>  					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
>  					     smu->thermal_range.software_shutdown_temp);
> @@ -1476,7 +1476,7 @@ int smu_v13_0_register_irq_handler(struct smu_context *smu)
>  		return ret;
>  
>  	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> -				0xfe,
> +				IH_INTERRUPT_ID_TO_DRIVER,
>  				irq_src);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 4894f7ee737b..9a8b7fd6995d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -892,7 +892,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu)
>  	// TODO: THM related
>  
>  	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> -				0xfe,
> +				IH_INTERRUPT_ID_TO_DRIVER,
>  				irq_src);
>  	if (ret)
>  		return ret;
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
