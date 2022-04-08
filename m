Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B475C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 02:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971B510E34A;
	Fri,  8 Apr 2022 02:51:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A180610E382
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 02:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N29913qS1N28mewKg2J4BONBf/HCzaf9sdD8U6bQFq1GgpWSIAnTtdKidniLnww9H/wLCPKlWRzo2C1u0/ukH3VTbMXlGWXSwBR0O82ddMvEljfwx5WVbotMBZcVSS+ehPntH4kCPc5mqGdeHCD3AWyoTY+tmtccUbXz1j94emvxqTJT01nmFhLier7B6rc7jaMDWcvEs91BGPS0/kp8SAewLiVGIhMI0OWAqE9kDzjdXgRMx/D2GNZg1Qv6I2GCVexo9Qnn+PnsOMf6fWZZaOstomCTCHuWmlzry0pjOuQnauYknN1NWg0rTpQKmswAJPa2rQTlsREUefjytx/ruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/Fw6S2Tz9FevtGJJHBB9zLg+gV7+hGnfTWumdJww7c=;
 b=RR3ej+x1gSD1kpg6ha0VIfXY0Db77VI5si74uTsOHkOR158FQFnZKDF4g7W1nL4PRbXg6YRgBl+ugmihAXs6jQ611XLGsR8JzuZgN14MvHaCzoDngnC4aSedBGRBmezIvHocisVreVcs7u5BaDJ/3Ow9C/T9Jm3VcqwgyCxJt71o4VhDKp8vcCeyni82EILXnHS2QKh3wxVbepzxIDmd0LRXfBgOxxtSj4J1RzJYZpuseHasxq9hZIIqPfJQDrkP6jpWc4iKoztDKYK+opFErU1JkquFci9HBpm93qtTXMxnqPe6zHB7/2ytk0WVZLTrYhilHa8u3Wz3H+EuRFRBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/Fw6S2Tz9FevtGJJHBB9zLg+gV7+hGnfTWumdJww7c=;
 b=LCMX7EUgpxtm1aGZUNZQsRO8I4l+CRg2lWcIgzVcT79P72h2yCigdDuqqQWdwgg7TsLSZE0nb6udxQREPUe9hCLKPLPQ3TK9CXrOgEMxuibGKYjWMNj8AuMuV3HrN86j3hB17UrK4y0NLjL2mEODP9jlQhRV4QpzvRImuzU69ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3871.namprd12.prod.outlook.com (2603:10b6:208:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 02:51:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::346b:537c:e42f:f0da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::346b:537c:e42f:f0da%7]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 02:51:44 +0000
Message-ID: <71697e4a-e598-2355-914e-d4b8705e6472@amd.com>
Date: Thu, 7 Apr 2022 22:51:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Handle drain retry fault race with XNACK
 mode change
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220408012152.27045-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220408012152.27045-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d1cfe36-e56f-490f-8e6e-08da190ab715
X-MS-TrafficTypeDiagnostic: MN2PR12MB3871:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB387173B3BAC15F448549F78592E99@MN2PR12MB3871.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WD9DuHYewbYEnixzKG3qdytIZc5vywT14I0YMUU2KaXAWJvvCZn7h2Q9/VD192yhgIKc3Tdig5R+/jPpnJ0uABNDX0XHI99xaB/oZp3PgN2yRyLwehGHep7NvYucG2Z4c9DURiWkePp3rnoHvDt1xuUN6PppFSg1U792ChqbdSV7VsYhM6fV2ARSVlzESCPlv3ipV4t5Qe3sbzejULaurjgXhs4UXwZ/ZBOta8MRm2kheWiDxjJ3bNJhfibZrnGFnR45s/i97JYNwUtygpgM7iRKpUUZLdIe0+EDQgDP7MnVP2aFaKh+sS91TYnGg5Oa5EECx7UcREEsir7LtLFMw12b86CYqDhF3Der4Fglod+crhAMZdu3vIyPJAI5DwMp3wl2BXjDoHD5qt0iZrKXw5CCNAST3y0Yri9Ezwyf+0TXcNeflmfEl3UbhxiwmQAqHFb3RPvSeO9fIvpuX4JjojTqeuyFPvS5LpMXp/i/deBDE2h0Cnlcwj/WCQQRrQ1hVrzs497e7qWXAs8NdKR4pDAov1/pfGg97iPiaYnmLelb12vwCKgbQeGuye15cI0IGOcnvMMJIe2WoP+czssz20brU4xtQSet72gax8fu4zRz5PUHj9xID/7KEO5mEkH3aluIZ0V3aAzYALis7fC8NpgrnJNfHFarhup/H7Wu9KSM26TXnWWh636tMAGrTCfQP8g9vXG3yhdFv+WtlkgK3PVZnfj7df/OQhKURjoMD/yk4aQL+yAJLcFPF4KBc+Bs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(38100700002)(8676002)(66556008)(66946007)(66476007)(5660300002)(6506007)(2616005)(31686004)(44832011)(83380400001)(86362001)(508600001)(186003)(6486002)(8936002)(2906002)(36756003)(26005)(316002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGcxM0lLdE1uOGpaRzVRN21za1N2NWFIUUNQdWFiYTdHaE56T3BSaUJBS1RM?=
 =?utf-8?B?RXJhUnVCZnhhYzlaMVNSdEdDUnhiMVNtUnhRd3FKVDV3a2JLc2ZxajNwUHNz?=
 =?utf-8?B?dVNsMHdHYVQ0UWlsNVNyamFEWERXbWtaOG0vQkxTa3BLb3lQSC9scHZndWNm?=
 =?utf-8?B?UDRRWGx2UFJLbDlWMEFvOUdXc3ZzVnI3T2t4clMxdHNKMjEvbnhDbUVva0F0?=
 =?utf-8?B?YjVING9kL3lDVG56M3daRnAyVmxQZVBTVGlkWjZYbENVWXk2NUZHSktsLzhL?=
 =?utf-8?B?L0tOcWMybDVoZWt5ekxva3Y4bGE2ZmVuMmNERVpoNVZ2NW0rNHdKaHlsaU1B?=
 =?utf-8?B?MXRzd3ZpWU1nSW5QRmRyMnE2cWVWS2x2cHorMWJVNGZGQXFhc2ZONGw4Snli?=
 =?utf-8?B?MStuYWhKVTl2TFdCRjZtYkZaZGh3VGVpTG81WWY4dmNicnRVZ2UzcXJ3RmNS?=
 =?utf-8?B?NnhEMGtGa09aekdoSFFDN25mMWx5bWUxVWRpdk9INEhUQnNGTFpTSXMwNURR?=
 =?utf-8?B?cUxlbDh0SHNTZnNPWjluL2VPR1M3Q2xuUWxPOVc3blBlS1liU3BCdVNmak05?=
 =?utf-8?B?T0g4dGZLQ1psN3hxMy9EN1Q5bHRqdzgvODM1T3FFVUR4Z2lQWGU1QWlDd0o2?=
 =?utf-8?B?cEdHRFMyVFAwSSt6bmgzMTNVNGM0R1RXbTJrcmxjRzdjdU5aNEV5REpoVlAw?=
 =?utf-8?B?WEVaMTlNb0Y2M1M2dFpQYUFhSWRFY3BpUWFaMG9ZNC8zeDduWG1vQkVWeThI?=
 =?utf-8?B?RjFSd0V4SjRlRUUveXJna2crajZFZk1DQ1ZXcy9GTW5HY1ZLQ00wR21qVXla?=
 =?utf-8?B?QUl2NWRHZzVkTkV6Mlg4OGF5RmdqVVZDWWRxN3BxdnZ5RWIxVWJNVDVzTXB5?=
 =?utf-8?B?cTJXN1k2QnBZQ2dXRytNTnYvVFgrcDVaZWphdHJpczJCWE15a1V1NnpBdGdi?=
 =?utf-8?B?QWlOV2U3aWVjd3pxcUF6MFkrbmFJN0hKZkhKbk5pOXkwcDBCUEVTclMxdFAv?=
 =?utf-8?B?RDVtWXpwaGhCcnAzSmNPNWl1TVA4SWVsdHUzbDJ6QnRHTWZibVJWRm5yZE5F?=
 =?utf-8?B?Sk5vbTZlb3dlSTNuaENqNnRacEhONThWekw1cHMwNzRIRmZJeEFZNTg3dURy?=
 =?utf-8?B?T3hlK3F6WU5BUEpEN09IZXc4UXhzVkF5RFRHemNVUlhadjlwVDhyRWhoVDdi?=
 =?utf-8?B?Y3krV1VaTXJUV2VZc0poZjRJQ0poVVpNTyswV1huSGxULzFSRVNTSW9DclhU?=
 =?utf-8?B?dkttRnBmajI2MU00VGZSQTA1TlQ5TjdkMkdpRUJORWs3MDdJYUVQbmdzenlZ?=
 =?utf-8?B?ZVNXL0tGbllpelBhelptME02MEhYb2hFK3FvRi9rdkpHdjVhMVBKRS9ES1hD?=
 =?utf-8?B?Z0x0MWZ1bkhNVVozbzhHUnNCUGdJOWhBODB5cnNzSXd5ZlpoWUdDUlRNRGVn?=
 =?utf-8?B?RFArYndrdTBuNlV2Uy9JbTVtZzNnRTdIZnNyOTBHOVJRYTJsb3BnZVJBZGtL?=
 =?utf-8?B?dmYyRnF0d1pGODY3ZmhqVWdZNVlXbjhDRFFMVGdIN3BDaEJFV1VEd1haSElu?=
 =?utf-8?B?eUtVbncrV2twOFV2VW9CTGcwaWFnY0FmejN4aUVRSnJ0Rm1oK1I1K2ZmeC9R?=
 =?utf-8?B?TmVWQXpRTWJUdlN0Qk85VGxudUNYeFNGODViQW5QVURUZXRhRUtEVGpRRVdB?=
 =?utf-8?B?Z3ZyeGhwQ21XMFJTdTR0OGY2VFYrQUFpMys5b2c2ZVlsZ1QwYnc1RmR6VGdp?=
 =?utf-8?B?SDZYWW1SNk5neFZtRERxdkYwMlREd1hYMGxCc3JwcUlOYWNFN3dXaTFBcUp4?=
 =?utf-8?B?YXBiU1BCT0lXSVVtZ2hoUk5Ralp4a2NQMXdOdU5KeE05Q2REdUNqcjZhN296?=
 =?utf-8?B?bklHek12MGhOeEY0OVRUK1RCaXR2VDg1a21VNDg0MEtXdUNtNDRsdmIwdk9r?=
 =?utf-8?B?VWorbS80TG14ejFhOE1qWlJWOTNpSUJlNnYzdy9UQ01yQ1dlaEVWWk1lR3lD?=
 =?utf-8?B?bytsdU9SSHVmNjVURXdDWmxNUGtZY1VEeUYxTlFTbnpabllmeWdKc0YyTndm?=
 =?utf-8?B?Z3BaSGRZL2VJWGxXQlhwMUlFMEs1N1hSMkFaR1E1V2xnN0k4aFFCNTNIVExq?=
 =?utf-8?B?VVZkV1ZqL2szaFVwMGpSSTY3WDZIanhjdjhXdTZOYTl3RUpUaHFreTRJVVRG?=
 =?utf-8?B?MGU1UVk2V2V3QnRYVGJrZzZ5bk1XYVh4UE1qZVFHcWh5ZXF0WTErQ05OY2dZ?=
 =?utf-8?B?bFZCU0JCR055UlJVZGdHa2xNOHloYVRGQ0FYaVU3VjRzUHBCdlhJYm1MZGFa?=
 =?utf-8?B?akdOY1M0WUhXeUIxWjVSeU5UMDBFWkc2ZEJ4R1NMcE9SVm90dW1RUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1cfe36-e56f-490f-8e6e-08da190ab715
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 02:51:43.9763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tkhz1kLltftKk114SB6gpg/qRD4uCQXfEYygT+cqPlmWi1t6okxjnmwJCbjrueTQ2SwXOChU/KIXybrNkIt2NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
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

Am 2022-04-07 um 21:21 schrieb Philip Yang:
> Application could change XNACK enabled to disabled while KFD is draining
> stall retry fault, the check for whether to drain retry faults must be

typo: stall -> stale

I think there is also a word missing, linking the two sentences. Maybe 
"... stale retry faults, therefore the check ..."  With that fixed, the 
patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> before the check for whether xnack_enabled, to avoid report incorrect vm
> fault after application changes XNACK mode.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d011d620dfe7..c76d29a22e9d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2700,11 +2700,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		pr_debug("kfd process not founded pasid 0x%x\n", pasid);
>   		return 0;
>   	}
> -	if (!p->xnack_enabled) {
> -		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
> -		r = -EFAULT;
> -		goto out;
> -	}
>   	svms = &p->svms;
>   
>   	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
> @@ -2715,6 +2710,12 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		goto out;
>   	}
>   
> +	if (!p->xnack_enabled) {
> +		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
> +		r = -EFAULT;
> +		goto out;
> +	}
> +
>   	/* p->lead_thread is available as kfd_process_wq_release flush the work
>   	 * before releasing task ref.
>   	 */
