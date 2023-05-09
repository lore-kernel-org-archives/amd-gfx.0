Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5BCC77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 03:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC8A10E0B8;
	Tue,  9 May 2023 03:47:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5405210E0B8
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 03:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSGUGK+1S8X3Tvb4owNRwsJYezszTMeWlVx22f0nuAoWfu+0hr/Nkm8bgTjHUTA04WNRY7B+CGOnW4H00qC59rpkCcHExk5QlvaPcVLU1omHvhCjmNl3if5sP7J0YerMnmt8HH8yp2xfmu6smkHuBhLth44vTYl0CTKdJsOLdjTQFFEL4hhKjjc22wYdmHI6MNu4Xkos98ZLXLtGSky0PqptTrFHtx7x+4ZgFPvykPgLQYB2mZzXxuSZi0AV9PLdaRiTFvSSyWPqc43oviA7IRG6EFWahYDcH9SxqoKq3kcjcCaPeKgneYFU6vRTstiDJPsnjeVXYqZIDlscLvYb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwdpJ/OFNM5F7nFiTarZwXwZ4QwSJUn/zZa+iclsNhI=;
 b=j+Q4e+Ld9FEVUL8hHw1rxYJGTY+CU3F8/oortdwicd2hsKYxP9WW4tL6nOlMJUpJar8fwIfz6BTs4LPNPcgiClrCbEFbsyJDMwS+3jIrSQgd30yXAIol6epUTssdv7Wj0Pp+G8uwRIjIg1qGKMkakT49k6aa+TeTT77wEBi0/xQtKcSOoEK0Jwk8lyaL0Adsyexc8bjjiYNAZ2DCAq0CYCct5lQETL0WfJF28B7Hk2iZDmeB7UqEu3PheZbON7APidWH+dhbuv+Od/+w7wweoqUpbHYTJxLXDP6r6SqQs+4a2hkOIgaRxK8dSQQ3wPvTpNVTTNzTxcrbUGMMWK4vuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwdpJ/OFNM5F7nFiTarZwXwZ4QwSJUn/zZa+iclsNhI=;
 b=fh7jHTQZM+yqkQfI7d5IA/6tgRfI0BxvzSzNiBFAE0Q0cOgukWjOOhzjgUfQdHyMfF4vQnwTFu2IFwOfnSyZYfo2RSMOlrm9ggmG6pPItEvne7NGnRaVNT/VDHsdyXiTTHlE+SLC1RyOf15YEKmJrcV+yLSAQMcwfcDsQtGeyus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 03:47:41 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::45fa:3bba:fa09:720d]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::45fa:3bba:fa09:720d%3]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 03:47:41 +0000
Message-ID: <a00ae4e8-1ba8-560e-2f31-23c7ebe0588b@amd.com>
Date: Tue, 9 May 2023 09:17:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com
References: <20230509014233.2101573-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230509014233.2101573-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 34799694-c907-45ce-afc1-08db50402336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6NNR+dbPVXhvC4gqXmuWljB3nGA6IzA6mPo7vHWBbVx+Hk9PXTVoS2SoHIG7SErYcbaGBaRrRh6hi7TTZyg5e+UlbRbN/WjXIX0sZuKN40hF4M1g1+b72DSij4m9wCI//JMl4M0WEepFnwP83X7TR3srYh45vQf1N6Au2G8g+lU0fIG/vkmVwx7DFnB5T/VKaE+U9MqeZUmVdl6cm5aqrvsL9U1ifoLjekC4Qpy4MCsdEqNJX60W3YzVy6GNLHNJI3Q2+3uTIkqntBiG1E1mKLpwMRMoJFEFSv6fjgZ/qPvRCwWJzDK+p57gx9uOue9KR5tzABGM5LS13fh/40p7Vy0PcsnEeD1f6ie0EZb/KGtQAvlLmsj8Jjppr6jrnyBKGDPUVsO1757jjlUTESEvJYUUvpvnJxrfrcZSPUCQ5+U4RSJs8ltBYi+lFMLVys7t8p66OeXupeOtQGzzBV9UrUzvkOA/ZdbTvrdb+e5Egj/lsI0M+CJ/XxUOu4qj4KYBoTivaXDwUjOOqiCoXA9THOeZUVld1dnX59s8wzmjWLHBW3Tq1/aI/dJp/xRtpLHbH6tOBI2797vJHBdzXlKzlxNNAZAtKJrUusmKwKsQfy2nIgBT4/RaUI8QJ+GPSMb45WGC/sOT/9ux2AmwCmvLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(478600001)(83380400001)(6666004)(2616005)(6486002)(6512007)(26005)(53546011)(186003)(6506007)(2906002)(36756003)(38100700002)(66946007)(66476007)(41300700001)(8676002)(6636002)(66556008)(5660300002)(31696002)(8936002)(86362001)(316002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjlvTnpLMngrcXV4WmFEQzVhVXdSVktmODRhY3NHbDlQUFFrelVYSThWV2lG?=
 =?utf-8?B?bjRqcW5TQk5JWjRkanAwSnlTdk00S1NSZDBXczB6UHhjMU5pTzhsWkJWc2Ex?=
 =?utf-8?B?SGZWaktxMjZYcHVyUVdmb212YmVlRU1ycHJ3N2VoWjdzRlJvWlRFS1VwMXRF?=
 =?utf-8?B?dkU4TWpOTllkeGpxVmQwMTFVanVscVhjY0Vxb1g3TUEyYUZ5TmJvZ1BYQ09L?=
 =?utf-8?B?cUtVS2EzbjNvNUEyb04wdCtLQWorbHNDQ2QxcktJZkVrRHhVKytQMzN0V0tO?=
 =?utf-8?B?ckRSWkV1L0srSlJLblptU29uZEJlY1NOdXEzaitjdFgyZ2IxdHkrMXhKbFNz?=
 =?utf-8?B?eHdSUFNhS3RaVTN5Z0VjQ0EyNzNYMEIvZTMyMm5jTDhPT1ozZWZTcjN1N1hv?=
 =?utf-8?B?WUFVaVBFNHh3K0JxZFpDKyt1QnovVUlNUUdCTTRwOVVZNXJuNlN3MXpJNERp?=
 =?utf-8?B?MmZoS3ZaTlZTVkVEd0dCWVVWM1BOeEhLMmhwTUt5bVBxSHg4emRQeDk2TUZj?=
 =?utf-8?B?UWN1dnV6MEszOHJ6VVdFYjJPZmJoMGhoWk5rTGl5bjNRQnZKWjBONmJjdG80?=
 =?utf-8?B?NzNTZUxTVmxHMGFOMU1zaEpWRjNsQTgxblRrb0xENk5MZzV3M08vQWVuRlRw?=
 =?utf-8?B?OG1wMmtJdU1RWUxzbUdHUE9JZ3lOMWNqSnczdjFXb1VrcnBPT2pRaW1weXZU?=
 =?utf-8?B?RTVocEVpblllK1B5TUdiWkVZZFdtbFJrUEhEZitHOVRSdk94VWV2WkVIcm5F?=
 =?utf-8?B?ZWsvemxmcm9UdjR6QWVKSm0weUt0MC9MM0tkRjdPb1djcEc2d1I5RDBwWU5h?=
 =?utf-8?B?YVBrUStLejB5SzVnRUp6aTE0eHZMSnY5VjFRdDRTTmJucUlVV1hGV2R3dEpJ?=
 =?utf-8?B?Ti81a0lXYlg0R0RNTng0RFdQeFhuc1Q5citOemEzUHhmQUJIWTVwTFVEeTFF?=
 =?utf-8?B?elBmWTZCK0pDTiswQmpqdUQzWWkzRnU5S25INUZ0NG9pZ29QVWVDUWl2cEhk?=
 =?utf-8?B?S0xTRW8rZGtzVGY0OGVFTnJtN2E1ckJsc2taTm1PYUg4V0tTcWVVNytlaGVG?=
 =?utf-8?B?ZWROUDRsNGZMbEdDbDVscU9zVnl3WThaNnNIdTVkMlJXZU1XSHZEMzhPb1lm?=
 =?utf-8?B?bzJ2bEpFdC9LTmNtdHdUOERiYk5tRUdwS09NZ01NNnl5cXZWWVFpcGV1QUVH?=
 =?utf-8?B?ZU05eGE1Zmhid3FRQkNtckZUYktDWEkrWmlpMkFJaHFqc29SeTlPSDRkVTdS?=
 =?utf-8?B?cjNWYTF1OVFMVWkyRTgwc1R1K0x4YWdKQVRXSFNTdlR5SkRVbFdUK1lxR21B?=
 =?utf-8?B?RytDVlRhSllSdkFxcDRHMks2UVplY2UyT3VSdmNOdG01c1BuMFdiT05xUU9x?=
 =?utf-8?B?SXFNaDBwa2orUEhMdXNmK2w2VktuY2dVa0pDa2M4MW1aNEpxajZtUGJnRjdT?=
 =?utf-8?B?SHVVSXZ4K2F5SXE3bTFjNDBiWWRoM0xVVXdRUklKUnBmQXMwN21Xa2tIQUNs?=
 =?utf-8?B?WjVxOERNRGwzcHNISVRzUVllc0Z3Yno5RWtWSmhjeGR3aG1xdHdyRXM1Rm5G?=
 =?utf-8?B?SUI3ditqa2ZKUlNmREJkNlJJeE5oQ2xXakI1WTZyOHp4RGIwS1ljallqZytK?=
 =?utf-8?B?Z0dXQk5CenQySHpKTXdEYXZ0MUdPT3B1YmZBMElWUFpiSUViUEVraHlGb2lB?=
 =?utf-8?B?cWd2T3FqT3hDMUkzWnVXdU96RFFaM1RlcmdaNjAxM0tQUU80RkpLb3VJLzVT?=
 =?utf-8?B?TG9VMWVpMlZKR0l4MXp2R1lHVjlTbkg0d3JaSHQvZmhnKzhwaFVZd1lBWDhP?=
 =?utf-8?B?cEZYZTAyYkNsL2JCMHRKTmFneEVLMzJXTEFSRGtFZzVEVUdKQk5nWTdESXVp?=
 =?utf-8?B?NUpxUVVOZmN6UWJKWjJtREFTRzM1R0NCcVMwTmJFOWhHbFJyZm0rb0xpeHZw?=
 =?utf-8?B?Q3ZjWktRR0ZEUVJsOUNCNzZnNkhiMGdWdzlxK2JCSlZyVEhIQmNOeEY1dzI4?=
 =?utf-8?B?UnovUm93RUZYZE9ucFlFL0NEckx4Zm8xTk00Q2FZTVJhMDVIUi9aWVhrTkpZ?=
 =?utf-8?B?eVg0RVNBMG9qRmI2SFRtdDNDc1VzQ25Hd2hlaHBZMDEyZGlvSEJoaUxsTGhT?=
 =?utf-8?Q?hPOZfdx+3uikdgZ9tswcypaQD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34799694-c907-45ce-afc1-08db50402336
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 03:47:40.6153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2fq2NQca3LNJiUVbPGRmBZ/WyQbH9OtPJxuKybyggL1r3apXudOl/WmP6Lpgzbp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
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



On 5/9/2023 7:12 AM, Guchun Chen wrote:
> Prevent further casting on chip MULLINS/KABINI/KAVERI when calling
> amdgpu_dpm_is_overdrive_supported, this can avoid UBSAN complain
> in init sequence.
> 
> Suggested-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 86246f69dbe1..ccd3ea89eacf 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1467,8 +1467,14 @@ int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>   	} else {
>   		struct pp_hwmgr *hwmgr;
>   

Instead of family check, what if you wrap it like -

is_legacy_dpm(adev)
	return (adev->powerplay.pp_handle == adev)

Could be useful for legacy dpm checks.

Thanks,
Lijo

> -		/* SI asic does not carry od_enabled */
> -		if (adev->family == AMDGPU_FAMILY_SI)
> +		/*
> +		 * SI asic and chip MULLINS/KABINI/KAVERI do not carry
> +		 * od_enabled, as its pp_handle is casted from adev.
> +		 */
> +		if ((adev->family == AMDGPU_FAMILY_SI) ||
> +		    (adev->asic_type == CHIP_MULLINS) ||
> +		    (adev->asic_type == CHIP_KABINI) ||
> +		    (adev->asic_type == CHIP_KAVERI))
>   			return false;
>   
>   		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
