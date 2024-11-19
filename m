Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3D8D4921C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC8110E03F;
	Tue, 19 Nov 2024 06:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="La455Nfu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4D110E03F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aetaT1eTdN0DegHhQa8tpQxj9SSFG+tdvX3g0JdTgZ2X//LokRmLkCzH1kenQCw+JX5fkKjF3TtQzD3ohgbiTgT+3lslCUH+EH28VqNZSwNMRygDYBmYkha+j7XGpPWwJeGQnqPNKQeSclKkFp9dAIDaph47i0r/gyCyjia8Lb7G7H5naPKy1i8cqdV1X5yVJYY9elExecGG1bixzFGoA+JnfQF4Z8TeMzW8jMSFlCHZug9S9rm423CujkUj/meUlNFDX9VuyiKSAzzqWT9N9vC5h3Y1avGkPewAtG8os0UVWy/E+DgWsdLD3wXIsgTNBitfLE2r2nbnm/dDzz/XBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1TZjHuJNwKpEowZ1/mNeeLGxpGJ1MtrlU8gfq1R3Gw=;
 b=n4T0XJ1D/k4NVNxpER9gAAtJ/MuAFKMdcZF9lUS3IBPn1Avx+Sk3s9KmvuYYPYEQfa/eUDzcp1jpqbTxwe77hKsSZaDY27VNNQ5nib9OvrUHtv28JWivRayATfp6/VIcfrpK8dfE2/2dmHXbogwVIMW8RcvIwDEWYakQS6aJolXuVdmidi6KCG3AEPueZkweFNHCNjDJZaGmVCigvi/J0rjwaeRDHBc0IMXZhrSWgC33dDQYDuywZww+OzR5Cwiqdpr2IY5sn77tyrYZiAWfzYNMmZUYywPoQ6BgKMnY3qOEgctNi9YWqpEBPDUWh+oVV6gH/NJWAak9UDNNghPu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1TZjHuJNwKpEowZ1/mNeeLGxpGJ1MtrlU8gfq1R3Gw=;
 b=La455NfuhhKFtnvPl/Qqo0ZZMgZMVPwpbVSHXQgwFghKTQ1DVyXYxkmByg0Jo6fQ9Xf4j/6JnN4R060WpjSCkBMJhg7Hl0Qyb6bRIBwYQ2e7qHgwCzzssJYvIaruYw8xnG1nsm5nGk465GEf9Mw0tuirR2Lazg3YALgJ7xn7H9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Tue, 19 Nov 2024 06:09:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Tue, 19 Nov 2024
 06:09:40 +0000
Message-ID: <05e036ed-74d2-4d66-9193-fd3dd5c71cb3@amd.com>
Date: Tue, 19 Nov 2024 11:39:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: skip the power source check on smu
 v14.0.2/3
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kevinyang.wang@amd.com
References: <20241119054823.436238-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241119054823.436238-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 84330a2c-c95a-4b2e-8da4-08dd0860c0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZCtqbnk3ZXNMU3krZkRscUh3R3h1MjRvM0ZQcCtRdVA0cG1pRVdQTTA4NWRL?=
 =?utf-8?B?VjEyeEJDc1FNMjNjaUhoSWVtWDhDcndYZVdHcGRxK24rM3ZRR3k1d3d2eFMw?=
 =?utf-8?B?alRrMFRLMEdnRTZGVldiWUJDTGhHMy9iQ1FMWklUcHpxRE5weGQwS3ZqSVJw?=
 =?utf-8?B?eHE1WGpTeHg1dlZjM3FVQlE4RitpakNDa2FXWVV4TnlPalIxblNTN095UUJR?=
 =?utf-8?B?cHIyM1JMdkl6ekdWNWcwdEpPdXlPNzcwTjMwV2s5TXptcEhUbjNZMk9idkc2?=
 =?utf-8?B?bmRXRThoaSs4WmRpY2xTNmcvbjRZTU11M3RxSXl2Tzg0eFhBam92V2llbTRV?=
 =?utf-8?B?ZWl0TFFkMWkxajk5aHYramhTYXVJMlFEcDNoemVYdGNjaEpnbkFjUG5lbnlP?=
 =?utf-8?B?YUxTcE1xUXoyYndoWVJ4ZTFxUWNKZXZFbC9ndUlsT1p0SEltcENZbUFIUVY2?=
 =?utf-8?B?bjBPcGdoeFNNZlBTci9FVS9kcEdmeXEwU2F4Rk1BQmdkVEhVOWRmVVlXU1dB?=
 =?utf-8?B?OUhDdjQ4K1ptMHlXek5zMjVXRkpDa1M1aWFrWDBTUWNhc0pVL0NUL0traUI1?=
 =?utf-8?B?bE5ySmJZbnR1YldoSmNFaHFUaEJzQ2Y4c3EydVpFR0o3M0EzOGwxbElMNnpK?=
 =?utf-8?B?dk1tVU5hQXp4MGtmN1FjTmVZeU04VC9yNSs4dkM1ZDMvTW1NWGRsREpiOFN6?=
 =?utf-8?B?eVNYWEVTSGJWQXc5cE1OSzVqVTJSZmV5aCtzWW5vZEFGUzUzNUh6SDdMR04x?=
 =?utf-8?B?REZMbjlVVkMvLzJuQlJaTjA1TlRxeTdyS0FJbVZBYWNpQXAzMUo3SGczU0Ji?=
 =?utf-8?B?NEQvbXk5dXVkRzdERjJDU3ZOYVdEVHF3TURNRHFLeDBScm5XaERSeFhjWnVV?=
 =?utf-8?B?eTl6YWhvT3NBTVNmZjRnMFJHbGM5aS9UY3E2ZCtqK2dVMFlOOG1Kc2U0Yy8z?=
 =?utf-8?B?Y1JWa2w5eEloeTZQSUZKaUVVUmhZa1RoTjNMRkxkQ3FMckNuVGdjeE9YM2lz?=
 =?utf-8?B?KzNSbitwWDZuSHozbFQ1MXNMYjZwb0Jjd05UVWVFcVYycXc5eU5kNGhBMlJw?=
 =?utf-8?B?K0RLRUl1SFJqTU9Dek5ubEdaYnM0Q2xBdjNPelU1bTZBTmVTS3Qzd055QmxE?=
 =?utf-8?B?aEtlekRyZVFMaUdCei9vUUI0blA1SnBlaDBXSU53aFVEV1VYZTJ1YjNvd2R6?=
 =?utf-8?B?dDNWMUowNHlXVXFySllhUDZTRGpDMklKeTRSNWkwaTFNL3RXOHY2dmlidDgy?=
 =?utf-8?B?TS9zOW9pdElYdXhPQ1RpQTVhUjFJc1I5MzR3K1NJbnVkOEVJMUJtZFRLRlFQ?=
 =?utf-8?B?cjN1STExY3FaaER5aHFqRXhtOTRNTjRPWEdRT0NhdEVqaXFwWWZlMDB0ajhC?=
 =?utf-8?B?NWVXRHQzVzZobkd5bnJVSTV6UFBDUWFrWjI3WUtvMmY0TkppMUhyZGg2WGN1?=
 =?utf-8?B?SGtrL3lydUI2a2sweEhoUlZvZWVPUW5qYlE2UFBrT2xWNHFFSHFUeGw3NlF3?=
 =?utf-8?B?TDhYWnNNNGtXK0Rzdy8yNVdaRi9GM2lLQ1FnOXRMRkcvcEd0VGpXRCtqc3JS?=
 =?utf-8?B?NmM1VmcwVnkwRmIxSTRTZW1lVUJ5VEhEQ1ZzRmJobUo1M2dKY0l6MlhiQTZP?=
 =?utf-8?B?OTBPRUo1TnhVa3AwZGt6Y3czb3pvdVZDdkF1WnorZFh3ay91WnZkU3F5SU1h?=
 =?utf-8?B?ZHg4bnR6YlJWM3hFM2dVTFczdHZjclU5K2E0UFZON2dEbFhzaG0xUVBHN3Z2?=
 =?utf-8?Q?7GyogpGGgkhz00ZRVD5iCJ1cpVa1EUOf8FpW66v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sy9GME1Ic3VnZFNLdzB2eXZTMzBTVlowMmg2T25oRnBLbWNSa29uQnB6VC9M?=
 =?utf-8?B?amhjSlJxYlZjdFdhb1JienRNMWIxZmc0ZWxaMkFOUTZpZVdkL25CMmNFRXJQ?=
 =?utf-8?B?RHFZSkFrYWxRV05DenczYXd6YUEwQ3hIZHBjejQ1cEdYMXZmWVorT0RKN0o0?=
 =?utf-8?B?RkVGNW1IRTM2YXdjOFptZ0ZydWpCVFl3RitiaEE3aFAyWTc4dHd0UmdZUmZ2?=
 =?utf-8?B?bTNKNEdCZUFjK2syc2N1Y2RPMWRRNmJDNmxSdUdlQVM0aGl5WXNGa3AxQUpC?=
 =?utf-8?B?TXhYRXlZTCszWTl3V0hnVXI5U2UyOFVYaWNiOXNqc2lRT0hkTVoyRjdkUkw1?=
 =?utf-8?B?Sm1TdGltZm5rT01MYTF5emlteHdkNGtFQmRYWlBhdE9Wa0RLVzlkcGVHdDI2?=
 =?utf-8?B?S013MTB5dTNCQWU5MWhOQ0lmUVo3T2sveGsyZXUzSmplcUMzYlJidHliaE50?=
 =?utf-8?B?Y0lFZUhKZUlBaE95ZkxDUitGTEpEeUNOblVFSDl2RUMxVXNzcy9PSlhwalVL?=
 =?utf-8?B?NGJNZmNJZ3JnSkVSeG5TTXRHeE5ubTAxTjNuR0F2dTNtbTBRTHo4NlBHR1Fm?=
 =?utf-8?B?RUVub1hnMFk3ZFlFRVZMa3l4NEcxdkF6RnorTVRGN2ZQdEVhSWZ0ZTBMazJw?=
 =?utf-8?B?Z2hqSE8wRDVkSnIvN0hKMExYbC9Wc2J5V0VtRzNrTmxxUlA4U3FPQkFNZlNX?=
 =?utf-8?B?cWFOSzlJdkdJdmc4K0Vab2NUZUZLbHNHNFFvT3VrMTZDMlZyUEl4KzI2OWc3?=
 =?utf-8?B?UlBxL0M0WTNNbStRZCswcmhYYnRrdmV2MnN2Z21nMzYrQmc1eVQ0Z08vdmdy?=
 =?utf-8?B?ZW55YmZ2bmJZLzA4MkN3Z0MxSXl5Z29yaStMbFpydHJPS0t0MW1BT3dIYi9F?=
 =?utf-8?B?SFVWeXhhTmFCTHVzMFAyaExiZUk1ek9FbmNybXlGTnVPem95Nk1OYVVreHRp?=
 =?utf-8?B?eWZXajg4RWdtTnhnNjB6blpWNjcrZUkxazYrSG5RSDEzNjhEa0EwUDhZdmQ2?=
 =?utf-8?B?WjNMNzlEdjd2NkJJUE85cjdsYUlVRUx0VEJEZzVVb3dWaEdRb1g0d0dydjY4?=
 =?utf-8?B?RjJ3YzF2bVI0Nk10Q1VYR2ZLTElUZzJtcDE5U3dGbDQ3MWNaNlRYdTNMdVVP?=
 =?utf-8?B?V0VXRE5QRkhxZWNLb3p2OTF3RzFidHNyYU9kVjN5RXlwMjV2UXUxZFp1aHdZ?=
 =?utf-8?B?aDJNeFR1NFJUaXN0SmJkU3JiVjFCLzlBQkFYbXhCSVNNRVA3Ky9hZjAxZjYw?=
 =?utf-8?B?dE1Gb1hFUSs5alhrQjN2cWJmZ1VDNFRLcUNKaVR4OFc3ckNzOHhlMEk4cEly?=
 =?utf-8?B?SkxMSURmeC83TzRkcUtOc1o0WDhGblpvTENaUDgzUmN2Ny92bVZTZmJWL3o1?=
 =?utf-8?B?T2FIdHo5WDN3N28vVlpZYW1RRXVmdmZpeWRGYURNUG9LMzVhUWViOGxHRG9R?=
 =?utf-8?B?Yzh6T1hvQW5TdHRlRFZJVFcxNldBWlZlQjlCT0tQcU8rai9tUUFEcVNVMitE?=
 =?utf-8?B?VWZhcU9ReXFtRVNrWEwxZldLa1lMYUxiaElQdDR3cUMwWFJ4d3l5ZXBaWkl1?=
 =?utf-8?B?bVNEaEF1eHRkOXRzdUpqTlhIMXFoeTd0MVh1UTJrY3FOU2U2K1pwL0RSb20y?=
 =?utf-8?B?dHFUK1EyS3VrQm5IbFREZzdlVnRLeHI3eHVhRzdadVQ3UTUyL2ZFdE0vRkwz?=
 =?utf-8?B?Myt4WHVEbWg1WHJsTEdtK2lETm5rQTFHcGVwbDh0cFRiRWRLY21nbE4yRjE0?=
 =?utf-8?B?Wmdza0poODNobUpyTXdXOVhOQVJpYmUyK0syZnNkVWxjdktXK2MrK0c3UGti?=
 =?utf-8?B?WmxNd24ybHo1K3RCWXhpMDRwOHdRcC9YSlJIckRuSGFQSDdTODFUdDI3NU83?=
 =?utf-8?B?NlZsNEFLdkcyWml4M09NcTF2SlRwc3Z0RWF6eEUzdTdYdGlpN0R6elJnVFBQ?=
 =?utf-8?B?YjQrQWNIdVZGTFhMWnV0aTNDTy9jTW5TaDZtdFFzSTFXMW5ncmlrM0ptTTBU?=
 =?utf-8?B?dnFEMm5wMDE2Q01pek9qemcyd3BydzlGTnI0dzdOYjJYeWZOcjhENVI3TUp5?=
 =?utf-8?B?d1lEM0hBRStPYU9GOEhXYTZwRTYrbGx6WkRoeDBIYlVmemVwQTBUdk9kOStq?=
 =?utf-8?Q?R+hjbwsjTbua4k1As4Uzl02/x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84330a2c-c95a-4b2e-8da4-08dd0860c0f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:09:40.7366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8a+ZG0wiSeMFDPuwp0RqTSX2zYEG7Ex6Wn1/MWtHzo0Ds4ce7ejCV4ekMIZ2YNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
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



On 11/19/2024 11:18 AM, Kenneth Feng wrote:
> skip the power source check on smu v14.0.2/3
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 5460f8e62264..b60837bd259f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -1365,6 +1365,10 @@ int smu_v14_0_set_power_source(struct smu_context *smu,
>  {
>  	int pwr_source;
>  
> +	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 2)) ||
> +	    (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 3)))
> +		return 0;
> +

.set_power_source = smu_v14_0_set_power_source

The right way is to set this to NULL or remove this line.

Thanks,
Lijo

>  	pwr_source = smu_cmn_to_asic_specific_index(smu,
>  						    CMN2ASIC_MAPPING_PWR,
>  						    (uint32_t)power_src);
