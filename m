Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C93C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 05:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE7C10E060;
	Wed, 12 Mar 2025 05:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SVCuOGQp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 575AF10E060
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 05:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFncg/ipQ510bqSNiRQ/gOJng2rLfHdv1eiLt4fRyE22OC3+Aiv13iH9Gpuvj6C2wz8cWDyNzhpnzYxdS0P65RfRCUNsUf2fdcQrzhtgAe/0jz+13sLjMUk8CMadtOavyF5T9TfZRP6rUDVWXmkXkMStcJj9O48yyIKDOq7y/02XcgVDMI7N1ea1wFCeHqDAHGpdi6R0RUSzhvhCeHX/KhaTHZGL/Mh0j4CrYJYDDxSBYGDELwvk44yYzeVl4JIOqJcFt12cun32RZt323OWlhOBlHOaxXsrwjdthM7W9VUQ5vT0dzCmGG1Pgycw3NqdXBtY3WEX13D5A05yUaZO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB2lqArEsdp2HJ29ETiaNIQ0QqGGCmuPzwNIJaArL+A=;
 b=sem15+FyGpNIrq0BF+szoN3KgIjmxSut957X/mb/YmWA5NNgErYm2exwIyIgcal851CP4MIyu5NUk8LUui/jWO+T8KLe87At7lEvkZotXGb03dBOMeppaqwlWzycCPXeMfoA3O1TcAEfHmUionKp+qWwcdDnB/GlaItRdTjQUmZShXMyY/oEpdh8Yagzia25rjnEkZWSRuIjByJTCd77tysCacs5KJzFS5m7a/Xqkz69p8frSuYtPqS6ugAn7MQKHoM9aA/KhK7FJ+zIFDLpkELewY76HpgiV/MIAAPqISTt9RuPSTEu4QovhvZ+LKnWrM7SIt/eBBNP2aKmwJufJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB2lqArEsdp2HJ29ETiaNIQ0QqGGCmuPzwNIJaArL+A=;
 b=SVCuOGQpND7Q5+UaIQPwg4WyEZSUI4Ijm/O3YjGeJDgeQQSNIf/SRGmKiI++xUvX+bDlfp0+JQScKSNMvCqG8sI0egiblQk/+AeioXYXHig6yXOVhu9HSOGp6o/hNLcZbLF12ZPB+aU6J+WMihM3Q+hLn6znL74fXyk1Zc57YC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:59:07 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:59:07 +0000
Message-ID: <297ea4e1-d57d-47e6-8350-ab18164abf27@amd.com>
Date: Wed, 12 Mar 2025 11:29:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu/pm: add VCN activity for renoir
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250311204459.23864-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250311204459.23864-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bf5113-e814-4b9d-bbb5-08dd612affef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjVlVTBBUUJYVW12WHdKd0dCYUIyYTcrMHg0MThlbWFJZDZmcnIxbXFVK1ha?=
 =?utf-8?B?SWtjbWFZTVZyVFozOWJrbnNqSjhzMFplTkF4RkZhN0tJRThPaFF6U2swTC9B?=
 =?utf-8?B?aWJMOGFzWW9UZGpqRlN5Tmt3RFpiRWllRExvUTBXOHVTd1E1QXovaVdiQVFo?=
 =?utf-8?B?Y1habHBuZWt5VjFLbVFSMUE5Q2RSMGdBSUZZR25pQlZ6dWZTSy9rZlFQQmdN?=
 =?utf-8?B?STVZMkdaUHZ0UjZLS0NlbUczRHhtVkVRR0JMcVNQeXRzclFSZ1l6QmlPRTRv?=
 =?utf-8?B?R0Q3RVlEalBFdTk2VlVKeUxpaU0vdUhOL0Q1MjVzMVRlZ0JySm5GSFdVSk5h?=
 =?utf-8?B?OEhHNDN1WEZMM3BKM0hpR1MzZ2hjYzdWL1BlaEkrTzdDSkVuL2RlU1RQZkkv?=
 =?utf-8?B?dk1seDFLZWg4MGdKdUZhdjZCa2U1ZHZjRkZDNlVYL2pEWEpPWGZrUGFkdDQv?=
 =?utf-8?B?cmo1elBrY3dmRGxVWndiT01qM0R4UXZqU3FEcWZpODB6NXBQUkYwckx1bit5?=
 =?utf-8?B?c3ZWNzh3YStna3dNK0F0Vlh3N2ZEeVR0Q3R4amsyUVlYNmJvb3JuMXNvamZT?=
 =?utf-8?B?dXlnU1A4Nkl5bE9lSWlVWmNXK1FiNnIwL1IzWlJPSjF5bGlkQjUvMkdIa01q?=
 =?utf-8?B?cEoyM01iZ2RtWnN4WnlObUoremdmandVWG5XdGNSVjBUKzZnQzZqQUlJNmJJ?=
 =?utf-8?B?djh4VDdtVzdKMHJYcURNbW9pQk1Xc3I1bFk0akNaUTFUMjV1OHhUd3BLcFAz?=
 =?utf-8?B?UXJXY0xsWHhWYWVlUFRzQjFJalFnWlFHcEhHRjlBbzFQcy9ZUVJ0cGMyUzNz?=
 =?utf-8?B?OUJyVHFHMUU4UHVmR3hWekF0L29EK0oyaUhZUE9KMjhxbnp3em4rQWZUajJu?=
 =?utf-8?B?TW1WRjk1VmV6Y1MyelBGSEpyUDI0SU5nSStLVjJVcU0wVStvcHh5N3dsMkRs?=
 =?utf-8?B?WlhvZE5EaFE4djJhZWIwejNNRjUwQkQyUkZXUzF3azRVcGdmQUlJcFR0eWdp?=
 =?utf-8?B?STlaTXBpT1BHa3dmTVVIK3NtYmFZbzd2aCt0dSttVGtvWG54bmk3U3V5L3A1?=
 =?utf-8?B?WVEvdEtLY0U5cFpMMkdPaWNPeTA0VUFSMGJOL1N6WGhXOG1tZHFQVnJWWU95?=
 =?utf-8?B?by90Y1VQYTVTcFFJZlQrQ1dQa3Yzb2VFYi82UDQ4dGZBZDU4SytuNTlvSy9J?=
 =?utf-8?B?UVZKN0JoWVdCNXR4M1RnTi9PTW9zc3R5K3VKRjBkQm5hamhjcS9VNlNqWkd0?=
 =?utf-8?B?NVFBUWYxOFVGTkZmY3pESkNNcW9jZWFBQkxiQW5vKzljbkczeEQ0aXBFcEt4?=
 =?utf-8?B?UGtWZHRtTi8vS01ZSWloVlp6K2VRWUpnM2l2L05lSUF2MFZmekVlb2R4azZP?=
 =?utf-8?B?TzVKYTFhYmN5NDRaYTVFNUMxWHZCOHRlUjR0SW9uUTA5S050VTNHb1dxRVNh?=
 =?utf-8?B?RGxkcU5Xdy96a1ZmSFJMS0Myd0NTTE1hL2k0Q2pQSmFHdkpSUUJYOHdIRjlt?=
 =?utf-8?B?bkVnWlgvbThrZ3ZoZndBN2wwSnltSGVNQzFPeWlXSkR6MitEbFV6WTFRZzFX?=
 =?utf-8?B?Ulg5d0hSdTZJYjN3VHl4Vm5RVHJZL09Kekl2djdXYUtkamVZYUJjWmp3bDdJ?=
 =?utf-8?B?UXdmL0MxWGJBUUhOWTBlWFpoTG1SK1FNdHc5Vjd3RlZYN2k3NlhtTXc1ODZa?=
 =?utf-8?B?Njc3Nk1LeTd0aEVVbXdqTk5ocEEzenNacmtqZUpRRmVQdFpmeHJhUkpNVHhN?=
 =?utf-8?B?VDlGWG4wSHFTSnNoN3ZqZ0o2aS9SMzdZcjBJSGNiczR6by9OOE5rblJsUDR1?=
 =?utf-8?B?YkVVaVY5aXdNZWorVXNaOU9Hc2xhQXI3Zlg2ekxzdjh6WEcrbG8vaTYrZ1RV?=
 =?utf-8?Q?CywnT+g9hm0Mb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVVPclFFeldWOVZXdFowUVdxN2J0MXlRdmNicUFoZlNWbGswMU1QVmxCOEhZ?=
 =?utf-8?B?OSt3RytSZXR6ZmUzYUYrWWdRTEJGRno0Y1RUUm1DcEc1L2ErZjQvRDZncVdo?=
 =?utf-8?B?WWREN21HQzMxaUZxZjdtemdNQ3g4ajFOT3VqY1FqQXhjZFR1bllvbE5JZmht?=
 =?utf-8?B?TDVKdU8yZVgyR01JanBmSithY3h0YjhKSElUbDliaytOYzZTWVFhbzZXOS8v?=
 =?utf-8?B?Y0FsSGlVNnFsVmVwcHROQ1I1U21kbDhmNUQrUTZmUWF3MzdSM28rY1E0ZUkr?=
 =?utf-8?B?Z3RDeFVlaGlUS3p0K1Y0d2tNNE5NZ3V5d29yMlJDOG1rU2RsdEFnR3J1dER1?=
 =?utf-8?B?RXpKMFVjV3RzMkp2eEY2NFZ0alpERXZlU1JpcWNkTm00QXZiQ1c3Qm1kbitE?=
 =?utf-8?B?N3g5dTFPSi8wYzlOc0dSZk1pUER0cFNoeXlFTHpObFJvNy9oUmpEcTdtTERq?=
 =?utf-8?B?V01FM05USzZkWUpoVkVOY2xqNG90YWlPa3RNdVJhSXoyTGdsdjZXcmZQV25t?=
 =?utf-8?B?Uk1BbCsrOXZuZVFUL3JtdzZPUzdSQ3B3bmRrdGw5ZFFzM2lUeUJINjI1N2JK?=
 =?utf-8?B?WkNOSW5rZmhvcC9RZjdLa1F3V0w2Zk50ZGZ2aFJkdnlJU2c1UDJpb01yY1Nt?=
 =?utf-8?B?RXc4N040VDhjUGgrUkZadGJ6RzQ5UC9XQjVETGVCc3JFSXNvOWJOOUgzRC9X?=
 =?utf-8?B?TmlFcnMvUnpTbG9ZUlQ3UjU4RUhrU1MvWnphajVMN2FTai8wTFdlRGYyd0gw?=
 =?utf-8?B?UkpNb1psa3M0ajIyV1M4L1NwbXFjcWVTUWhGQytYSlBEZTIxTFVkOUVBVTdW?=
 =?utf-8?B?UkNyVTJiWjJ2YnlyTGJ6Mm1YV2h0YytHWFlHUDNPdzFHR252M0U2clJXbDFj?=
 =?utf-8?B?WmFZbmp3MTVDYXNYaExpRWt5R04xK0tpTVVpZS9BZnBiTFMyYjQ2c1kzRUZj?=
 =?utf-8?B?MGJZdEdvRit5OVR5eVVCK2Z5Nm1aT3M3OElLN3NuYUFQdDdITC9kMllGWkdO?=
 =?utf-8?B?UkRxbSswQWNtbzFIRWp3N3RIdFVLRnhHWGJQUllubnhpeWpLazM1dXRTQlc0?=
 =?utf-8?B?NnhjRnlYdkE0eHlwVU83aUk3aTVYTjFFbW5mQnJRU1FaUHRiblpjNnhTVzE3?=
 =?utf-8?B?OWlQOTQ0N0s2TEV5Y2E1SStvV1NheWZxV3JTY01ITVdpL3g5NmRLNXFjNnpr?=
 =?utf-8?B?d3I3RzNiaVVoSWl5NkYrdDg1RERSbWRQT0JWbWxxWGw0UnBFdFIxNmppRUtk?=
 =?utf-8?B?VEptRmlHQTlOZCs0Q25GU1ZaZ253NldxU2EvTmFHT29TL3NWZk9vdUQ0clVB?=
 =?utf-8?B?Q29INGxHZXBjM2tXSmpVdnIvckJrdVQzZXZGVXQvZW5teXJnVmRGTWgwUTdG?=
 =?utf-8?B?NldKaitnQjk2UXV6dlZWQ1RYdE1TM0hOTHdsdzhDMWIzT2ZJdlgxUWxUWExM?=
 =?utf-8?B?eE1UTExvZXdsOHljOG9vc1RQUVhnWkhPckFMK3ZwbzExeEtCT3paMGwwdkRC?=
 =?utf-8?B?OTV6UkgzckFFZGV6SUpSV3BRSE53ajBIb29QOEhTQ0V5Q2t5WkowcWxxMHNw?=
 =?utf-8?B?VWxjZUFLWjg2cXV6YmpzYWZHZ1BmcXpiTVlLM1lHYXhSV1NRSjRrTWRhcmF2?=
 =?utf-8?B?RTZmNVVqdHgvamNUV3Fsc2x2Kzl0RDJsSCt6ODVPQjU1S0JnM1FQeFRFZTcw?=
 =?utf-8?B?Tm1PUjM4ZlhhandremdRM2RhL25aRkRTZTF0SWJkMDliUG91TlpVWnl3Qnph?=
 =?utf-8?B?YmJBZGRMdEJwcSs0ejZZOEQwcHNJKzVlaXBxZ0RsaWhneVE0THgxVHV0MGVR?=
 =?utf-8?B?Z3g4a0FkTkRhZ0tMVFFWaEdJQ2lZTzFlQlAvK1c0UGxhSCt5akxxa1NSbWIw?=
 =?utf-8?B?ZFlvbnlwN0s1ZGtiRXNLR1E5c0FMNkFObWo5U1RPR3RjNjluRnRZWmxPbFJI?=
 =?utf-8?B?ekM0MmFqOHlYRTc0d29jdVdPQ3E4WFVZUDZJTVl0Tm1GVy9GVFBNeDdEVzh0?=
 =?utf-8?B?cmhDcVdMUUtRNXhHbW9kdEszazI2cEkwRUdGN1ZNM3B4N2NaUm1wVWEwUUhN?=
 =?utf-8?B?V08yMHF5MnVyNXZQVys3VUhCVUpsZjUyQ05EdmJ4TkVCZU1jZWIrQzF2YU5s?=
 =?utf-8?Q?8A6zzid8wGLAljvZmloFhWTPc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bf5113-e814-4b9d-bbb5-08dd612affef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:59:07.0367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JDdtYSJx1r04S8QQR4vb5MwtaQBG1FRdmfksvUDqB4WO/7+4jXklkmI0iLEMbHw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175
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



On 3/12/2025 2:14 AM, Alex Deucher wrote:
> Wire up the query.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 37d82a71a2d7c..9481f897432d7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -1285,6 +1285,12 @@ static int renoir_read_sensor(struct smu_context *smu,
>  						  (uint32_t *)data);
>  		*size = 4;
>  		break;
> +	case AMDGPU_PP_SENSOR_VCN_LOAD:
> +		ret = renoir_get_smu_metrics_data(smu,
> +						  METRICS_AVERAGE_VCNACTIVITY,
> +						  (uint32_t *)data);
> +		*size = 4;
> +		break;
>  	case AMDGPU_PP_SENSOR_EDGE_TEMP:
>  		ret = renoir_get_smu_metrics_data(smu,
>  						  METRICS_TEMPERATURE_EDGE,

