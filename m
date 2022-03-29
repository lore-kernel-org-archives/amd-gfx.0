Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFEDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 04:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE4E10E02E;
	Tue, 29 Mar 2022 04:34:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A4E10E02E
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 04:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvjGgRBMNSH+YhjjBW8PtUJfZaUeXeJSoorpX6w+iI8Ua2mip1DLAzs3TbGrYTUbj5JiY593R6n7ztzFN1w7kqnRh039U0CWUbu3J0bSJyv3Hb82IqYk8DyWYqaOQ3y2+PNehn/zAbOEzyuVdmEwC7mxAdYeFu1mu/VbQiKRG5p0A0Xfa12YbqWi/Dcn+WZ+1Pxlr4K44DYpSR+VFj++6wb9S2tYU7CK4XYYN1y9Kfgl+9saL8UKMW42sqosgQ/+R/DwiqHa6pM2EMG9eowRZiY7DLd+tN0ZbLpgEvVtetCYahcelcuvcRQfTDmjABksLXdPI+U/7hOuWmjGZ3pPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x57kkb46UDCnYpumVOfP4ULdwS6Ej3clUl2MmajUnbo=;
 b=NAxjrT6ts5pcb5Ipb2qtOtHNNFjE1+hHsEwrvYbMFciqErPev3ZkZJWS3B3lKLX1F0cwrHIqzYg9JD6n/lHYnuOcl7EUVhjzYr6hSJw6HDwFBeSi1/K3LbvUMXuzWkxPnHslaQBMZAe2b+HNAbSBRy0BBRMfz+1KOccSpm1Hqv9UowFMpMUBsN4ypN4L+7cgFBb2ARf66b7kHYGukWX3QaVIlIzlknXtE1xdSKp7ji0JFclgZsCxcRff14y6cei1G9gHddlFmM6q+JdLbVvlAlDvxUTgtSGxr1IKBIikg0Vg/4xu9SPQAwAhjKsixfudzzFwXGfrd9N32lFgUSSs7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x57kkb46UDCnYpumVOfP4ULdwS6Ej3clUl2MmajUnbo=;
 b=GPBMPPvo1EX4HVmFAdNc6J4zD0OiD2LMphVcak6oox3N3Vu4/nRYgD0Ztv4BxTBvYq3RZKblx+nQ03eOUtjVCM+nKTVPsyRBlKDuaI/A3SLGaEqwFUq7mt529+4gqJcfx3TaLjkMGWfbgmO1xXsm5Lx2irijioH8oGkVWNZVFGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Tue, 29 Mar
 2022 04:34:36 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 04:34:36 +0000
Message-ID: <414e2374-e0a3-affc-6ec3-931375ef29ac@amd.com>
Date: Tue, 29 Mar 2022 10:04:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
Content-Language: en-US
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220328170759.1267968-1-kent.russell@amd.com>
 <20220328170759.1267968-2-kent.russell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220328170759.1267968-2-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::14) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c5ba0e6-cebe-45a5-bc99-08da113d6dc4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5077:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5077CAFEF7A899CAA61285F2971E9@BL1PR12MB5077.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZdtSTHjy4T7slHu0g7a9qRmbnKP0932W2He1KGsLmtxeSBHAcFa8XGOXu98ChQJQoncTEY99Bjc/s17ChFJGZIVzNaWomHQVc7a/D4uMlTKg3epjp9AAVCZIMsjDS/TX6iMh3oPj1QGoFBbhSSwAn8O8lE1PQr2NBJZBCQ+aMZU9qI/hDrrMFY5yMMr0MjDAZdV/uhMKcRQljVeTskXKitVz1BnzYDV2gnkATRlpDwMFmWN3r2DxRTCHxrwjeTbgQ50Q5PZGYVcF/SAO/WjziaSjT2/h1fTea5VG0noTZ9yXdpZm3lktfl/qhs2CKmQVgCi/n7dBsJRbSO1LW2rqkhGSqwRYfBCFVd3d7cJh3Ye4n0+hKQvXVFNRQIvXnjiCBok7CrgshBX1lR+9R4YtjMaI8qIy1yAihE/EmVhKGdbuJDqTfoCvzK6C9jhsqvbd8eKk4VpFpeHFYLe4WXP4Frfs3PGAeJzxd1n9Md4ex4fwGFoUysauDFspApH8sMV5y/HHu9kWL0+rbIqYa7PGV0YwLioGOl5d6PljE9V0Mue17Fhx65z9U3e0JJSrhWUfexjqdF02hzRF6gXNtqYNpu3sjWYAByL6WMs+5E8LoM/Iw2vy4NbUSPQSOfMhi+cgiRdfg94jhRvcQvztsqu8CK2SFtXd4t7OsWzS0r2ExRgdXrke6FK1TM9DuX7QvmNEiilSAoD0XsDFO3rm1x5j5YfDXS+ocQE0p0GcnMFjf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(86362001)(31696002)(508600001)(2906002)(6666004)(6512007)(6506007)(4326008)(8676002)(66476007)(66556008)(66946007)(38100700002)(316002)(36756003)(2616005)(6486002)(31686004)(186003)(5660300002)(83380400001)(26005)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T29kRVJaRG5KL05zelpZRG9vb0RkV0picllzMUdIejgySmxZeUZuMnN6MEJP?=
 =?utf-8?B?ZE9DeHF5bGtpSGtzUE1VcEwvcXBxcVRnTWg0LzFZQk1wNk9mdHdkbzBPU1A3?=
 =?utf-8?B?ZUtRTUFuUlJvTU10NjA5dzRibW0vMThiUityamJqOFovWkVrSjROWnFZem5r?=
 =?utf-8?B?Q1RRQXBxUTQ2c1hzaGJLUHh2cVR4MlByN3hQdUd4L21OQ3FSdEk1eEpEVVk3?=
 =?utf-8?B?MUUzeGpaS1FBdmFDaXpjWkIxa1NjM2FLekt3ZWtzcnNUL015YTVIdlpaTnlN?=
 =?utf-8?B?MklzYnZOWWdST0ZTNktBTWh3UVBOcFdGdmxvMmJzcmE5RnM0OXU3cHdWcFBD?=
 =?utf-8?B?cEdFck5LNlduM0JPejNQbE5CbGQ4UkM4R3JyajNBQTR5UFUweHVoQnFPNDBF?=
 =?utf-8?B?aitacmJHNjFjT1FES3IzdzVHSUxrM1htaVJrVUN3U2EyQ1JXK3pQNENEdlk4?=
 =?utf-8?B?VmxTdHBaNVVaTkE1VDVYZ05zdVZZVzhYOWNzd1JlVEZNMmN6R0JsVmhBcUll?=
 =?utf-8?B?VnRydy9nNEVsdW82ak5KWnd0RzlpSkhNSDFqN2ZOZG5DQXdHYnFIWUZJajFL?=
 =?utf-8?B?dXVCVWJ6T1lGYTkxSUVBSkQzenlyemJtc1RsR0RzdjhjZ0NSak9hbWhJWTE3?=
 =?utf-8?B?VTcvVk1ZUzMrTDFtQkZROURla0V0c1lZYUV3K0ZrQkI5RU4xSGlTZ3gwR1dJ?=
 =?utf-8?B?UXpIQkV0aWRTM0ZETTFxOEpUWFVZa1FQM0I2RE1NaHh6MGxlZTZUcUxHd1pI?=
 =?utf-8?B?R0QzSkYxUnE3eEVyWU12RWdZQ1NpZ1kzaHNEOERKVXdWRDlBV3IxQWtrenVi?=
 =?utf-8?B?bkR3ZjJHN3ZOcktXR3dxb2RyZHFxNTJrWUlHZndEZ09KUkhWNFE0WU52dW5j?=
 =?utf-8?B?Q0JFMEN4ZUMwOVVLeGU2MkVmUjhaamhQTjhONVFhcnRweHZyeEVKcHdwOHN6?=
 =?utf-8?B?bjNUN1FJSlFZQTF1MTdnbnprR0NHc0R4eTZtaUN4ZnRQQ0lXdzFGOG0wVkdC?=
 =?utf-8?B?R1FZdFBpZkZhV2Yzd3NBem1vaXVZaVFNQzIza3lQQmp4TEYyV1RiK0R0dWtP?=
 =?utf-8?B?WW5VT045bHUrR3BQVmI2amNTWDVMVU1EekVYZFZsMzRaU3FkazFHNmFQSlI5?=
 =?utf-8?B?RDE5WEkrVnBnR0VwdnRSSVVsN3JCTG5XWmlkUDNUdUxVdER0Zjg0WGVXUENz?=
 =?utf-8?B?UlltcXd2a2x5ZEhYRzRGQWhLTDRCWkVDek81VWtiSEVKbEZVL25WcnNwL2Vz?=
 =?utf-8?B?UkhWR1pSUkpqMGdSYWc0ZzcwQTNMTkRPMXdJRWhueGtQRGJvRFJJNXE0UHhy?=
 =?utf-8?B?Y1I2NFIyUVA5M2EyS0dSQU1RbXRRTVBnV1JSaE5RaDkxUUtjWEFuY0svQWZQ?=
 =?utf-8?B?TzJQK21UaGZjeWxrWmw5QUtxV1RCZDZrUWVvNm1sRU11NERXVU9Bdkc0eEVC?=
 =?utf-8?B?VHBUaVpRU3R0TGlDRHNwZnhIcDBqeSs2VHJaRVhaaFZRbmQ0Ly94di9FWU9p?=
 =?utf-8?B?cm9iQlM2bS9XdlpBckZodit4T2RRWmpMbTMwR09iZVV3ZlRmU3BQWkQ5bUR4?=
 =?utf-8?B?NSt3aVZvbVd1c1JsUXlTc2o4WUZOVllLSDNkOGZIbWQzV1lTU1hvK05rdEVq?=
 =?utf-8?B?TitvazU3eFQ2OU1pZVA4NmpUdGYwTlpKY0VuVVhLOTVBTkxsM1dUOEpVbFVU?=
 =?utf-8?B?QkpuaTJJVFdYZm4wc2FOUzBNUGh0WVFveXZaNEtORy91UVVmdWxrMHpQQU1y?=
 =?utf-8?B?WU5YbDlENXd5dEd0ZE1jT2JidFM3bWdvNHBxaS8vVGFtMHlydStnMHJoL3JQ?=
 =?utf-8?B?UVBkcXczWnB3N2hmSVpOa3NZRzBseFpFemJQOXY3Zm50bHNFaGozTUsrcmEz?=
 =?utf-8?B?RGxrTlpoS3llVzUvRDg2WllLQXFWSmxEV0ZuVUdtRVBaM0Q4dWgvam92dUtq?=
 =?utf-8?B?anE0c3hlM0VXWndUVng5NXNoNWZlb0M2VzNsbmI2NmpRY0VGeUlYbC9vcVJP?=
 =?utf-8?B?RWJkZmoreDBHQkltVDJxWTczZDRKOE0zUTFUUGg1Y3QxaWZabVVGSFJVWnV4?=
 =?utf-8?B?QUNsd1ZxQkI4YTRGNCtHRWFWQlc5Zjk3V211WW11OEpsYit1UjJoK3pBdWNi?=
 =?utf-8?B?R2VlWjlvZUc3QmNlaW9OTWVaWHZwQjdzd3VpN3RERUlPMDJPaVA1Mi9LUExh?=
 =?utf-8?B?bUxtVHlpS0krcTBtMnhOcjNSRFBBWjlPblhYczdCejJyVWlta203SzFjNGNa?=
 =?utf-8?B?elM1c3kxb1N2TE9haWVucW4zOUVkRjErSW4wK1pwNDBLRHFzeWNsdG9EdElu?=
 =?utf-8?B?ay9obXRZR2dMdERHOVZOR2RPV2RyTC90SjdwdTZOeU9nOVpoSHVjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5ba0e6-cebe-45a5-bc99-08da113d6dc4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 04:34:36.2852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSkz94VgUiGK3n61f50GzlyebezzLxe5iKU8miwZxeo+qmL5SMYsulYS6z4Rf9Va
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/28/2022 10:37 PM, Kent Russell wrote:
> This is being added to SMU Metrics, so add the required tie-ins in the
> kernel. Also create the corresponding unique_id sysfs file.
> 
> v2: Add FW version check, remove SMU mutex
> v3: Fix style warning
> v4: Add MP1 IP_VERSION check to FW version check
> 
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
>   .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 10 ++++-
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 37 +++++++++++++++++++
>   3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 4151db2678fb..4a9aabc16fbc 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1993,6 +1993,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   		case IP_VERSION(9, 4, 0):
>   		case IP_VERSION(9, 4, 1):
>   		case IP_VERSION(9, 4, 2):
> +		case IP_VERSION(10, 3, 0):
>   			*states = ATTR_STATE_SUPPORTED;
>   			break;
>   		default:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> index 3e4a314ef925..037f38b0fa15 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> @@ -1419,8 +1419,11 @@ typedef struct {
>     uint8_t  PcieRate               ;
>     uint8_t  PcieWidth              ;
>     uint16_t AverageGfxclkFrequencyTarget;
> -  uint16_t Padding16_2;
>   
> +  uint32_t PublicSerialNumLower32;
> +  uint32_t PublicSerialNumUpper32;
> +
> +  uint16_t Padding16_2;
>   } SmuMetrics_t;
>   
>   typedef struct {
> @@ -1476,8 +1479,11 @@ typedef struct {
>     uint8_t  PcieRate               ;
>     uint8_t  PcieWidth              ;
>     uint16_t AverageGfxclkFrequencyTarget;
> -  uint16_t Padding16_2;
>   
> +  uint32_t PublicSerialNumLower32;
> +  uint32_t PublicSerialNumUpper32;
> +
> +  uint16_t Padding16_2;
>   } SmuMetrics_V2_t;
>   

Hi Kent,

Are you using the latest code?

   uint8_t  PcieWidth;
   uint16_t AverageGfxclkFrequencyTarget;

} SmuMetrics_V3_t;


V3 is what I see as the latest in our source and this struct is 
consistent with the latest PMFW.

Thanks,
Lijo

>   typedef struct {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 38f04836c82f..140005bf6d9e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -481,6 +481,42 @@ static int sienna_cichlid_setup_pptable(struct smu_context *smu)
>   	return sienna_cichlid_patch_pptable_quirk(smu);
>   }
>   
> +static void sienna_cichlid_get_unique_id(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	SmuMetrics_t *metrics =
> +		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
> +	SmuMetrics_V2_t *metrics_v2 =
> +		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics_V2);
> +	uint32_t upper32 = 0, lower32 = 0;
> +	bool use_metrics_v2;
> +	int ret;
> +
> +	/* Only supported as of version 0.58.83.0 and only on Sienna Cichlid */
> +	if (smu->smc_fw_version < 0x3A5300 ||
> +	    smu->adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7))
> +		return;
> +
> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
> +	if (ret)
> +		goto out_unlock;
> +
> +	use_metrics_v2 = ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
> +		(smu->smc_fw_version >= 0x3A4300)) ? true : false;
> +
> +	upper32 = use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
> +				   metrics->PublicSerialNumUpper32;
> +	lower32 = use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
> +				   metrics->PublicSerialNumLower32;
> +
> +out_unlock:
> +
> +	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
> +	if (adev->serial[0] == '\0')
> +		sprintf(adev->serial, "%016llx", adev->unique_id);
> +}
> +
>   static int sienna_cichlid_tables_init(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> @@ -4182,6 +4218,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.get_ecc_info = sienna_cichlid_get_ecc_info,
>   	.get_default_config_table_settings = sienna_cichlid_get_default_config_table_settings,
>   	.set_config_table = sienna_cichlid_set_config_table,
> +	.get_unique_id = sienna_cichlid_get_unique_id,
>   };
>   
>   void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
> 
