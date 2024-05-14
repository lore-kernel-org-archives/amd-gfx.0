Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81047C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 06:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 207B210E25E;
	Tue, 14 May 2024 06:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ss1gMNCG";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E62F10E25E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDNxLNcpBKdAwwq9DFPNxS+Ej2P2nIiFzF/zbPsVJrZxLUMpGtGP4WWsvKsyO80Jttt1nD1hv9pC8HwG6IKrvBnrs2QL1ABuTp5ETh/Jwnn+f1of4TSrkMOeIlsAow9zdzt9ZU9/8Wpg+5I/G/AOUPQFRLYIyap83X1TJcv4PtFOU+sujgsql17KH440W0KjzG9RFslHpUSsW5A9uhN9JdIMoVyvOEZ7Ymq0iyBSEMRsPkqJya2WFh8qkM3a1HNyntmP5KAjyle/TsOZi/JZv3r7g687834bHmZKM2v1rk3q1UUypJoWmULtHvDhVFd08Dtl6gGOpW2yUQ1bKUKvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZELJSka/G4xWvOwEn7XikVV5XxabYaVxY2OVd+ifEY=;
 b=llschIO4wI13QOLkNX0E5TxoqVlPd7udPU84Y1mrBCcZuVTRHuMWp7VZ25Cq7G621T2uarc2/4NfuAFZWzkpDezb6Ek/T1MR9XwtDJHth0PnCLMeLyMAh+/VyF5OgENZE7LHAouCQ/YfIxaPSBTaste1+ptdD1Zjmx3K92hR1tGL8bBKEAOZrCrNRO/oczivAM+zhArCmqDD4wi4rcSh9GCxXzhUGsYIcTFALVsdmZO81+59K0TNnBmTr6Lm8iLQkAPo/A7Jvnoh0wstkA9FGkb39KXDXG5ggpuwjLX1faIPa4mS8BvkdGprTyp2kjEuGQbQxJKIWI7Zy//WXz55Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZELJSka/G4xWvOwEn7XikVV5XxabYaVxY2OVd+ifEY=;
 b=Ss1gMNCGIzrDHLzdUYs0XzI1MIVOyorW52MI6rtykJvc5Nz5ZzEZXTZhMfgfpej2N3z7xzpWYP/YkaPjC1l2d3dUhet4tM6Xzr+wkQMiA7uV3r9A+yUFclEl77opfpurKskMM8Q6HX8atqbKO1ITOnekH596Zks7/AtBLWQkdis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 06:57:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 06:57:08 +0000
Message-ID: <0e35298d-fcc5-4885-992a-8e02a7de1317@amd.com>
Date: Tue, 14 May 2024 12:26:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Drop hard-code value of usTMax
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com,
 christian.koenig@amd.com
References: <20240514041303.605558-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240514041303.605558-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 819b97cf-d301-457f-6ea6-08dc73e3123c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aExrK3Q0cGNlR0xXL2R2b1hDMktpbmNXUGFXbkxKQnpaWkx4RXJ4ZVpyY0xK?=
 =?utf-8?B?RnJuR3NnWVlaeXJLZzhGYlhuNmtuL0RUV3NDbnZKb1NLeG12cDJmWXJYcDZD?=
 =?utf-8?B?Zm9NOWR5THVRWkJubk1wbGxUT0MvaUN1SWhEL2ZaUGk2V2tyS0pEakV2M1hZ?=
 =?utf-8?B?bmF0SVlNeGtjb1lpYUZnMEQvc0gzNVBZTU5Pc3htcmJkTFF3Z2VQUk1oVlNj?=
 =?utf-8?B?Y2Z2ZjIrbnRFWWUzd2ZydHZERFB2Lzd0aVJwU0lXWXZibGNENlg2R0R0K0Fx?=
 =?utf-8?B?amkwbFkzWXM1anRsV2QrZFYvVU9mckxIZ0lwZE9VakZOYlYxYUEwTmgvMmxW?=
 =?utf-8?B?MGZxTVpJWXJMU2t0OWtVUldZNXNYRjFpRk00SytHc3lhdGFibEdJTVBtbVJL?=
 =?utf-8?B?eXZQUFRYcVdIZ2RHT2ZZTlhSOXE4Qk52bXJaeG85cEZHNlZuUXdiZGdmZUZs?=
 =?utf-8?B?aHdJKzY2dVlIVUJISnFGc29GaWo4RnpaZUE5SGFWdGhnL1gxalVrT2NCYmp4?=
 =?utf-8?B?Uzd3MW0yR3hIM1NkYVMyYlBJRDc5R0VrbkE3bkREa0VBdmJMS3piUDdLOWND?=
 =?utf-8?B?NDYwQTl1N1pnRDE4d09zVWhCTVpXQXZhVCtCYVRoeElPYmZLVjA2Z0JDL1dv?=
 =?utf-8?B?QWJIQ1FEU3VuNmFUaFFPTldxd0dBcjNSaHlFR2h2cy9mY2k5YVFUcnc1NlJM?=
 =?utf-8?B?aW5VOGJPYjduL1crbktnOFM2UTVhMHVERE8xV2pTZXcwY29mc0NnOGVhVUdN?=
 =?utf-8?B?R2EwUzFIU3d6TzBmSXRlZU5pQmR6NTRGMzl3Rk9zeHEwVThZL3ZFRkJnYk1p?=
 =?utf-8?B?QnJmL3ZhMmlhSTgwQ0RsZGsxVE1maEpJanNQVGc2WGtEOGRSeFI4Y0IwUGJF?=
 =?utf-8?B?YlVtSW43UXZBQ28wM1plT1JaTUd2SG5mVnk1MGdsVm1VK2JpZW84QVNFQXNv?=
 =?utf-8?B?YnVYNHNWYkIreHJxZjNZallCOHNYK0t2Qi9UTkxhVXNma0dBTkNrZFNFeUJK?=
 =?utf-8?B?ZVcvaTRwV3Y4ckg2Sk1sNm5FQjAvTjFuQ0M3cFN3RjJ6aXVnT1lENGFIMVZk?=
 =?utf-8?B?ZUR6QVA4OGdpN2thSXA4cmRidXE5MHNVdm9xdEdMdmlleit2LzBUendDQWJU?=
 =?utf-8?B?Wk9IaE5YYk9SSENxTldqdld5M0M3YVJQWDB0ZTI0Tm01dTJVOG1OQ3hpd1pH?=
 =?utf-8?B?cjAwcmkvbk9CVTVMcGpqYkJCcFRXT0N5YzF4TGV0dytvNXd6eEhVVjA5QXFB?=
 =?utf-8?B?QlhpOGJBaGM2UWw3M1o2Zm9uZW10c09BY1VOZzdZM0toSmNjOUdtT05Oaktn?=
 =?utf-8?B?c1oyUUVnZVhHTGJjanhvUDZ6bEc2RVdLanBOY0JCbVR3QTVIbzRLN0JURzdv?=
 =?utf-8?B?bk1SWXdTelBteE1vS0s4VGZLTXViOVZLaWx2RXRmVzh2dE1oMmxmWVh1aTcw?=
 =?utf-8?B?amNjMDR3UGpYQThRNzY1czMxN1laYUZMQ0RzMGdrL3RERlMvVmVjRjIzblF0?=
 =?utf-8?B?QWhtZ2thY0o0aWQ2cUwrbUc3eG95VXZYbDMzVjRvejlwNWQ3eXVuaWhDS2RE?=
 =?utf-8?B?b21UaGZMZVNuV3l4dld1bGViYnFYL0JRVWNGMmRwbWlTMW1UY1hlVXFqbTJq?=
 =?utf-8?B?UlNRTmRDNlpRL1JLa1lObGdyY3R1STdCQW5BSEp1RnJvTlo1b1VYQUxtd0Z6?=
 =?utf-8?B?M2NlejVkbDF5VzN6bjRwMjVpSnJEVHdtbUVKajA2RFMxdGx1QjI1T1JRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjQvbnNoZ2loSUJEQUpQMVNiZDlXUFR0dks3ZmZrYTNPd1czTkd4ZDlPNDZO?=
 =?utf-8?B?MlQ5WHBFcmpKa3JpZ1hqNDRWNmxZNTR4VlhFa0V6RlVxcGJjazFPeVJsZXFY?=
 =?utf-8?B?VEEvSXlMazVlZXIzbTdmdmpQNEVUMktySEkzN0Rrdm43a1hZM095UlhhWk1l?=
 =?utf-8?B?SDVYNUVBUWZyY0xPTzhrOHc1K1Y4NEcza1J1czQ4QlVuK1BZcytaQnVMTGIy?=
 =?utf-8?B?d2N3NkFUYU1nWURTN2xnMUxKaHZ3MytoMFZzQlRnSldvdDVvS2gyQWszaGMz?=
 =?utf-8?B?NDBEdW5GV1JDSWNGNXlrWk5Nc3BMbkZnbzlyTlNGQmFLcG1qbDFKOEE5Y3R1?=
 =?utf-8?B?TVJCcFlCWHpWdUdXcEpxVTM5aDg3N002NktjVkcyVlVUSHAyekRrMUh4T0cw?=
 =?utf-8?B?ZjRSWTBOcjVuZ2JKQlhma3BvR1U2cHdvdVN5WVBHTzY2RGtCbm9NaVlXL2Nm?=
 =?utf-8?B?ckM0QW1iUXZuRVdYR2FEbEt2alNOVnExblBzeklSdVZ2ak9FdnVpUlkzV2dG?=
 =?utf-8?B?MW9NaHppaVJ3aTV5VmNJTjlLakxBUHBTaXIxK1AxWWZJcHhxUHNvOHhWSGJu?=
 =?utf-8?B?cC9CTTRJRGxudXNKTktJcmExQjU2d2JSc3BrUmlQYVhkZE9vemF4RktUbkZM?=
 =?utf-8?B?ZmVrd1l5eDNlYm5GV0prOU1qRE9pN0NPcmxFUHVLQUgxK3E3OEh1aG0yY3l2?=
 =?utf-8?B?cnFlSG5iV0orSFFqYUJlNEFxUWtGaDRUMExXVDJkOGFNWnFHZkxCaTArUG0x?=
 =?utf-8?B?WTU1T3YrNzFYV05jUENCNHFJeVpYSWVHam5qekJYRmhGUklEQ3ZBSVlyZU9t?=
 =?utf-8?B?WVV2aVBuUFRPaEVrdzI4UCtSRXRzSkVTUDMzeFh6WHN3Q3RycHQxR1ZhT3hF?=
 =?utf-8?B?VWJMMkROdXc4UkpneS9Sdzk5NnczYlEvRUYxRlhkUGtCRE9icDBUcEsxcnBh?=
 =?utf-8?B?Z05JOGtYeWVZQVdEQ05NMGhPZWZqNkpmMUxiY3NNaUFsT2pLV3dJeGZXZ2Iz?=
 =?utf-8?B?WWpUbzRzZXEyVXVKTVJlUEtNZ1QwWHRmNFNJYU5nR29oRTBLaGhCOUxjdVY3?=
 =?utf-8?B?K0JCYzV1RlcxS2VkclJ6K1hzbEUxWUpYQXRQWXYyNXZsUnViRUxZTFB6bXVJ?=
 =?utf-8?B?S2poRUxNbXJ0MDVka290SEloODNZclVWWVhZYnV0Y2NBc1BQVlFFOWRSR2xy?=
 =?utf-8?B?NzlRZnlpT0VoYnpoYXFIaHJOZ20yT21kcFNzUExZcGYzeGhGTjdLU0VrcDRI?=
 =?utf-8?B?c0dMZjFOSEJGWG91bnpwN2JISHZGRm9xRm5maFB1eVg5b3ZVOW9COG1lT3Zk?=
 =?utf-8?B?MWE4Y1JaZW82QmNmc0daaXZ3c1pwV2NwZVovRi9BV0ZkdHpWdzJKalZpejBW?=
 =?utf-8?B?TS9Jem53bGdOYUoyblUrUHRDWGZ2cDJjVjRiaVpVZ0d2Z3M1cUQ3eTQ2YTJV?=
 =?utf-8?B?NmVLZk84Y3JuTmJqV3plQkdFR28yeVVIUEI2c2dZeVhsRUgyeTczWUR1cEtk?=
 =?utf-8?B?bEdGMnF4bEFtcldCV2hYcHIxZW8zeGpnNVNzL3QySnpXM1RwUDQvcE9seHly?=
 =?utf-8?B?NDlXcS9xYzZPa1Z5Q1RIcU9NQ2FESXhKTE1aVEtKSkE5VHYxOXFmakVJVkZ2?=
 =?utf-8?B?NGpocjdvN2pSWmJobGZrNWtRN0laSW1zRUM4YUMxWEJGazNBR1U5bS9DL0sx?=
 =?utf-8?B?MHJMQ3R0eXArWEpqdHpqSFZlVVZ2ZUYyREFBYXFPWXJITlB3cDd2VG1GTktP?=
 =?utf-8?B?YktoWjFGUDBNYk1mcTUrRVR3WEM4WXp0VFN4Ukp0cDFEK291WnVuV1d4bExx?=
 =?utf-8?B?SWJjT3Z0dWlYOHRNYXc4eUU0eG1sVFQyK1Z2OHd2TTlHdVdIS1VlNWpteXY1?=
 =?utf-8?B?QUdmdVU4SDFScHdSWm9XZ1hJblVnOTdLMXdtcVFad0xyYnQ5WEhjKzFRZlpY?=
 =?utf-8?B?L1ZyaHBLZXE0a1luSEN1Rk9CRFprT3Z0S3RmQ0NIbUtWMVZ1QXlVcm1UdVZn?=
 =?utf-8?B?VjVpVWRFYmUrdXJ3Q1lsQUk3RTlldlpIOGFBYU5hWktqZkFBYmVCR01oNEg1?=
 =?utf-8?B?QWx2R24reEhWQ1l1MTFCUGM4SUIzOFNnYUlic0toVHhmS2pmOFhhUXVSOHB0?=
 =?utf-8?Q?Tp7hlC88LqbaVLuzHSitwU2ra?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819b97cf-d301-457f-6ea6-08dc73e3123c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 06:57:08.3859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRaKaUYY0Yf2N1EZsKD/av4Mr/luQ7zW6Ze8OihsICkk8ll2QDdBlRIJ7qMn2S7m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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



On 5/14/2024 9:43 AM, Ma Jun wrote:
> Drop hard-code value of nsTmax because we read this
> value from fantable below.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> index 17882f8dfdd3..6cfef1b295ab 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> @@ -977,8 +977,6 @@ static int init_thermal_controller(
>  			= le16_to_cpu(tonga_fan_table->usPWMMed);
>  		hwmgr->thermal_controller.advanceFanControlParameters.usPWMHigh
>  			= le16_to_cpu(tonga_fan_table->usPWMHigh);
> -		hwmgr->thermal_controller.advanceFanControlParameters.usTMax
> -			= 10900;                  /* hard coded */
>  		hwmgr->thermal_controller.advanceFanControlParameters.usTMax
>  			= le16_to_cpu(tonga_fan_table->usTMax);
>  		hwmgr->thermal_controller.advanceFanControlParameters.ucFanControlMode
