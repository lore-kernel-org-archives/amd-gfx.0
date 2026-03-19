Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E67109022A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 13:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7612410E90D;
	Thu, 19 Mar 2026 13:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lz58dDuh";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12ADC10E4A9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 13:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSZZ8+Qfz4jUhFiqPLMK921Ztu8dWZwYoIXjMnbUDVsyU6QFqNaDhN/Ct1zdKqKGRy5BJD6z4CseV8Q7Snm4hiyR0bfK+oB2V/2GMxDFMXNvvKsC/mQWgaQe9spe7ZqRDcUV4/99VmMkYLSRhBluGjZP7j5HE3Q2K0lUqwaxMgFAxUZZADPn01+6cOTIn4a6zzmq5Uc1fNb7juM8ypgCKjt9c5km0UHSBDkBnkHnBvNeIZjpp42sCCqs5Pbhf6xbBziKeSa87bZJaxMUgeq4WCJx+spvYXCIztQAWqcGao8vGDx/Rj0zy5tXoDxnLYWONo3P7KF8JzyWRmnb296++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHG+fic08HgjvccwiMebMh036j7L458M8umc4BFBqyk=;
 b=WJ6wdeVPzQ+KHngsT9zNl5Pp7fPlHddQkllSWhZZ/i0OMQjA9KxNHxL/6NKYUS3SOuPKYkOZ/i/McmqnpJfRkHcM+GmfkMZ6s3U/+KanQV/A8h8GFpScS7LSqovgJMwWaX+GGTt3UTECtbxIIbLy5PTQU4gQZS99xSxD3vRElb9l5ggGuwS8BGq1SKL0304hZ3V84kc/qEbg9WTPkHSezIcs54e3KPjfQ5x8aoIBHKxuMB8rYRKtnykTuBjkbq+Rq8n7PKt3dkcuv4h1NMsKHDuXj2bUoDO1uyNd6Pv8TbcLVtsdTSJo+YtyWBaGrzzsf+H+dHmabLbM06kmppUxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHG+fic08HgjvccwiMebMh036j7L458M8umc4BFBqyk=;
 b=Lz58dDuh8al8LWrianQ4ZmyGH4viHyaNH9TeG7MRhS03x/MeM3tR4OQLmeZvaxw2Hxv4NLwmTUne7yn8zMw7I7yBoWm5bHK5MjGF8N6Ty9+EjOlCfzKuLUk5ElHVbCi/CBo4b+ZVYk+tT+i6bxDITHWrFSOvQIrWemFyq5/XfcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 13:52:21 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 13:52:21 +0000
Message-ID: <5f6a5b42-3eea-4002-810c-882471940feb@amd.com>
Date: Thu, 19 Mar 2026 19:22:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v] drm/amd/pm: Enable VCN reset for pgm=4 with appropriate
 FW version
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260319104529.3254-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260319104529.3254-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::25) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d799f8-4ad0-44ee-2cca-08de85bebdbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: AIDNWnQh2wmzQs7YorXXPc/i5qgsr7rsm1qELv97eJPk1pWGR9lgeNzhJJ7mF6qphn5cUlYeAi7DBs9DhtfepOtI4gnAWsrX5PVJLuhSlc32bQxioliNwmdJM6t8nO20bLUYDK6UMQyiQgN/CpsonS6eYldHLT7EbvpIIMCJVDbUmT226rzH9V6XtzZNptJxObUi1KPb2N27C1gWqm/u6hiobjm/U11+tQG8zQUxugNmnYMh1deOJ+JBSToMEOGmUW4oMZVA90K6DLcTrLTxnUh3b/FhAYDtx7hzSBxqYrSmP3+vlyZx+DMnDr9ADmrpDoz+e64P2qIo50z9Mt57+knq7e19fHHDBmKJvFbFRtmRdkH/kAOkQ8rdMe4hYPoM/G032wK5/OMpP9kMRfIVmbkyuehRFHUPJm6Zpfa0RhaQjxe8SCFhZ0AMAoSxi/IaPturaASrnQIomTEAx2ZmTc2a2+xIXHzmRmIW9hlM07pE/TQYewrKdA1vE69f3sJD/OgbasoMUCP/Hojn8en+rJ0dX1ymFK9S7ra4SOwmrJ6l20xMjSI5CkOIiN5pKVY4Nf2U99O7X+A3tfFLZoVd63OP7r4x9Dzs3Y/WaG24uhQWc9klrY1GlVDcgdGZF6r9CPzm0d6JqKkxQa8oz6yPGb4NVpf2fRcPUA3okIg9tKazMLuuguaJ1Q9pZoJknHf3qhGPUlzvY6gO7Jw6epU2PJn9t6IFgFa8VosSsQGbo8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmdJcG5KUkVIdmxVZGRCazZYb1BPZ2lXS2FIcFdqcWw5QitpeEN5a3BadGNk?=
 =?utf-8?B?bVE1aXY3dC9vNFl3NDNZdStLS01uUnR2SlhWajZKN1FIcGNQWVd1RVJDYVk0?=
 =?utf-8?B?eXF3ME0rOE1GQzZCSmhOYzRTMmI0QmNlcUtnVE1kcjVkVXN4UHdiWXZhNWYw?=
 =?utf-8?B?WThxZnVxcDV6NmNTUm5FOVN3MVJ6OFNZZVBwTFVmODlZMWRCRnZ6ZTYzR3Vs?=
 =?utf-8?B?eHY3RzhLN01VQUhtSnF6ZHpoZTd3UWxmczlRNlFoQVdrY09mZlhXNitWbmlF?=
 =?utf-8?B?aDF2MjNpeEsxWlhTOGh2MTFybVN1ZHVIeE5hb21WSVZmVXd5T3lQRDNWVnA4?=
 =?utf-8?B?dGVZTHQ0OFdybnhPRDBrWmI0RDZpbk0zbVBsSUZGRlNvREQwNzJCYm9lazIz?=
 =?utf-8?B?dmlpUGNVejNTdXhqb01odFZ6endkZjBVSWhMVGU5NVZlaUpoNGF6OUFBdm9k?=
 =?utf-8?B?dGpiTXZ4Zmh6R0FkQ2dYWFIyK3Z0SVlPQUtNak1tdkVXbkI3L2lhQnk2aGVU?=
 =?utf-8?B?MEFUV2Fxb3FhYUdybkY4cm95TU4zOGpGTktoS21zKzJnUGd4SXA1eVU5U3VS?=
 =?utf-8?B?RFZQOTVWcStZbEx5a0lQci9SMlJQMlJhTWRiYzdyNDBsSnI3Nkl1dDRwUmFX?=
 =?utf-8?B?RmhwWFdXeTdzZjNwdmY1TmNpZW9CVEYyOUxKY2ZVYk1kajl6MWlFaGdDcVdR?=
 =?utf-8?B?NnZHdTdRREFxeEFXYjA0V2dWa0tHRW85dDZlZUlaMUtZVE1GQXpnc1VxU0xs?=
 =?utf-8?B?OTdjMUcwMFM0bWVZT3kyL1A5aUcyTFVhU211OThWQUs2Vy9jakp1T3BxTGd4?=
 =?utf-8?B?RmRIOU5TZ3NNcHJrWVJiZ04rN3NLelI5WkE0SnJOWmhaV0pmbVk2MndRbDhp?=
 =?utf-8?B?RHg5cEp4aktxd1pja1owcFRhQW4rWnVUUWduZ3l1ZVRpbTBycTlvNEVOQTBo?=
 =?utf-8?B?YzN5WVcvTHFlcGdpcDRXOE5PVkErckZzUWR5UEg5N1ZKS3ZTcW1RZmphdHR5?=
 =?utf-8?B?RmNuQkMyTGt5Tnd5N0lpR1BoWW1DM1puQTYxTUhheTdsVTA4ZXBFRWlDcFNv?=
 =?utf-8?B?dlBVZTM3allaclN1Mm5HWi9saXh5SmdqRHJrbGxQb3dXemZUQS9tSVdlMnA4?=
 =?utf-8?B?N0h2ZG1zelpmd1NEaWlwZWMzRWh1Q0d0Vk1KdEV2eFVyU0lrNEJIbVRsSjYx?=
 =?utf-8?B?SXF3Smo5QllrN3BScDh4clA0R1E3dHU1SWhiTEhLUWpJU1dOTjJKTGx4RXdW?=
 =?utf-8?B?cW9nRDRhTjljQk1JdnRacm1rTGlLamZzSGtqMkxLNVlQRnExK3ZDbW5VN2xw?=
 =?utf-8?B?VWZpRUNQUThMMzlnRG5sRHRpSGhCR29Qekd4OHVMdHh5L0lvL2FTMUhUZjdI?=
 =?utf-8?B?ZlVsZW1zZ1VvOS9PWW5Fd3NGb01IRmt5TzJmcG1EcGxTZGVzUEVvWFJOMmNZ?=
 =?utf-8?B?R3hEWUhZQWVnT0VZTDRmcU5NSy9JQlZ5UnRQb0N0bWNGbUdJM1RJbEplbmNl?=
 =?utf-8?B?aCtyOWhlU2RrdnFHMzcvVW1rNGhsVFdDeWRBNGhFc1IyTjUwYnF4ak9EVGp5?=
 =?utf-8?B?VHcxSnNSZnFKZ2dSRytTeTNNU2ZiV2QrRWoxVUhXWmw4NGVDb3hHbUhMSW9n?=
 =?utf-8?B?bS80SEVnalRreEF1UTNGQnlGWlZ0elZXSVROZC9pL0pxdUdMa2c1NGZMUFdW?=
 =?utf-8?B?MllNdml0NVFrWlhyemZGRUJ3WmtZOVBZUmV2MGU0UnpnZXJiazZCeWp3S01P?=
 =?utf-8?B?WDYwRVFuS211WkRWUUo3MW1EVFVXc2JZWHBaMENkeStlVWVHMUJFSkU2NXN1?=
 =?utf-8?B?ZnVCWWhBVHQxUk1JRFlOeEYwdWE5VThISjAvRDBuZE1KOWc4dk5HeXRoa1kr?=
 =?utf-8?B?dzAvS2VvSkhwZXpuR0R3YU05T25tVTZDU2RCbCtXdmQvOWdXMHlvaFJGblo4?=
 =?utf-8?B?c1VHV2hWc2hLN3JTK2oxRktST0xnNUZXTEEvL0VIR1NWSlVhSSs3T0hZMHhB?=
 =?utf-8?B?MEFJYWVpb3hOcmZsTHk3UVpnL2JTaVFZWGFUR0N3N2d4dmxUVlNzekhmWmFt?=
 =?utf-8?B?Vk9iMGdPRjlVbHFSMmZJWFBSZE1MVGhGY0Y4cFVIbWx0YmxpZDJleFZBL3Fv?=
 =?utf-8?B?U215SUQ2Y0hVbHkvbzllQzNPKzBCSTZtY0pURkVqMUVuQlFaWU1zZG9kdmZP?=
 =?utf-8?B?TXdjZmFONHJRbW9NdCttR1V0WGlrc1FzbzRyUG1XNjB0eEJDY25XWWtDQWRx?=
 =?utf-8?B?bE9qWTZ2dGFNaU9vVDVMaTVlOEcyTk1jVjRwaWhrc3VTZWtGdEN3cTNVNXAx?=
 =?utf-8?B?aEs0YXM2WHJUS3E4UzhQUlRSeEFidnVMcUdkZWtveEYzd3lSK2VTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d799f8-4ad0-44ee-2cca-08de85bebdbc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 13:52:21.2043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RABEJHXniMZfzHsokt8xDNVa+CYm0OgzMiF1ScHjxLh9NT/kiktGTmSd8diiaz//
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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



On 19-Mar-26 4:15 PM, Jesse.Zhang wrote:
> Extend the VCN reset capability to include pgm=4 variants when the
> firmware version meets the required threshold (>= 0x04557100). This
> follows the existing pattern for pgm=0 and pgm=7, ensuring that VCN
> reset is enabled only on configurations where it is supported by the
> firmware.
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 5b9580034641..deb8f827abcc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -461,6 +461,7 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
>   		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
>   
>   	if ((pgm == 0 && fw_ver >= 0x00558200) ||
> +	    (pgm == 4 && fw_ver >= 0x04557100) ||
>   	    (pgm == 7 && fw_ver >= 0x07551400))
>   		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
>   }

