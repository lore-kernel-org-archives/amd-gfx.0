Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1307ECF3962
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 17:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC2810E735;
	Thu, 19 Sep 2024 17:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Te2+fYx7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC3C10E735
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 17:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLbE4R6ShyUCJ15aL2ijOODQl6XVn9YzAN9HDfwrw6iVGGhfN9t4Vnx8aFijrxhxMj6kQG9J3VstAorXKTkK6ety3GII4CQdUa1IIDLXkPMbOxTMNAtwCF3wk+EwD/cbh2niOn8zmqY97NB7uOneQDxs2hwajLa/RqzSMsj2JmB0QldUFLN7006Ao0Uh563Zz/SsRJPIabdDoyBGz3VWlzQGr6JJutdNfbxw5KpqrfvTi1VTH1Lcrt8Mqk4/eUm/gR1Z+J2+sD7dA/7ZijniaulA8Nc08UUGR0r6EmUZGNPgo7B7MqTsWXG6HbxdZlDU+hg3YaffF4/m5XeQsw81Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQcrIKekjLYi4M7K9019I5xO7w1KjjpDYAR5ndKSCIc=;
 b=JexehelSBHjTdoAM6VrAh3Mkl9YgdJfi7DBlzp0ZwTk3URGxYSvADAP92+va4DnMgp2FKzNQ3aT1I0eCtZgY/QZ+P8cNDUGRH4P9c2q1UBwAs8kuEl0+XS/W3zYi/8OPpOOfL3oBIqM5qdlxqjneZCv/0GGL+AY4kM+Hk8twHVz+FbT1zNWZNWHJ4ndtHP2OFG1UjpgFSKHnz5x6WBYqw5bW4hY9QD6OQSyul9FCMSd2ZPOXA0+wWbrKN1xujAhwAyJpMU8uuuwyXj+AB4DddYMqmvyztFonXazSshwX1Fqxd1/imddbAPuMV+IF9pCIAvK6u6VohiOZ8mO1LavG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQcrIKekjLYi4M7K9019I5xO7w1KjjpDYAR5ndKSCIc=;
 b=Te2+fYx7n+fZACKNRTZLlKTc+DNImJfQb+sw42yO9OBntuc54z7Bg3E8KBCB8eVjq5in2lt13Fj2w3DYryijH6xGrAIwWHH6NTNQM+qu5haiDt1wJvIg3R390udEpUSr0xhbbIbESDymSAmW5d7OoAy7ZUL2COahRnqkaZdPSQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 17:43:50 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:43:50 +0000
Message-ID: <17fb1f6b-e013-4a19-b1fa-c03ebdef12a3@amd.com>
Date: Thu, 19 Sep 2024 23:13:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx9: Explicitly halt CP before init
Content-Language: en-GB
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240919164700.2579011-1-alexander.deucher@amd.com>
 <20240919164700.2579011-2-alexander.deucher@amd.com>
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20240919164700.2579011-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::8) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3eaf04-eb98-45a5-c6c7-08dcd8d29ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2pxK1VIazFNa2VWSitwSDMwR21hamlENEo1TngxbDRsWmlTbVZ1RkdFVXh1?=
 =?utf-8?B?NitCNk11dG54Zld3YnBid3FOMkUyZmpWSDlFeTFmd29tdHhzbDE0d2IwbXNP?=
 =?utf-8?B?NDdBZ1hiVnRmbmZPM0dHT0VsZFNkTGxiK2w3bzF2L3c4U3JKV1N6L1F2WUN1?=
 =?utf-8?B?LzV5MFI4a3NtU3p1S3NQM2xwS0JuY2I2a2xEN3lhREErQ0hzZ2F4cmdGTE5Z?=
 =?utf-8?B?allhVnNzK1VsbExYVTBrMlRxL1I0cE50S1VpUndqdEFwRG4xekd3a3dhWVZE?=
 =?utf-8?B?UXhJb3pmNG5YY3NmNkVndmlsaVVwclJBa0h4ZzdrNXFuQ0RSaEkvWElHdWly?=
 =?utf-8?B?ZUdCckJ4VitPbzNJQS9sTEtHZXNQM2luQk9TOTVwTEU4TGRoQnpQSDh1RDJo?=
 =?utf-8?B?V243TFdJcDdlakdZYS9XamxwMXJES29kM0hISVlReVc1aERrU0ZWUnNyOXdN?=
 =?utf-8?B?TElMWFZneDFyOEpyMUlvanB0Tzc2L3hmRUJieWp5NzlTa2cya3A5VHVRaEJY?=
 =?utf-8?B?ZXZDVzBxL0xYZG5pRjJseU9zSjhxYkRybU5aMkQwQjdPU1J5Um9xQkE3NExZ?=
 =?utf-8?B?WVV2QUlRTzJpT0w3aXM1THpzNURhQzZXZEVWeWhMRTZzcDZVN0IyUFFZcWg5?=
 =?utf-8?B?OTl4ZzM5ZlJCZTRNdVRrV0FyYU1ZT0ZQejhYVU8rWWUzVlRFcjlRb1VBempE?=
 =?utf-8?B?NEpXQ1FpQW9ZYkdXNGc3bUZ6OGhlaHpiOEw5UHk3UjRyMXRRNnN2KzJ2c3pn?=
 =?utf-8?B?WkVBUFAyQUxnRlpMQlhzNnZYVmF5OHRzaFdBQ2RWWGZxQ0hlQWZkaXBzNC95?=
 =?utf-8?B?aVdnSCszVlBpNFhYMlI0cDQxNFc4MU9aYXdrWTNNSHZOd0NtYlhRdGl1K0FE?=
 =?utf-8?B?eFNidTJoRWVUZzdTVlJPd2NycUhJQmhKaVZObUpxVkh6UzRMV1VnOUdLOUdH?=
 =?utf-8?B?OVBRSFQ3WStENG5RSnk0cThmMkw2ZEpYQ2wrWk5kRytST0NDM3RTSUE3a25r?=
 =?utf-8?B?b1NZRXBjQVZCQjBYWVhHQWNqSngzVW9nQmNNand4RW56RE5TSk9BaUZhMk1l?=
 =?utf-8?B?b1NVTW5TcGd6QjN5QXd4ZGFNRjJwVXg2aktFVVRQTkVhZ05UOWFocG1peHAw?=
 =?utf-8?B?SEhldDNMeVZSN0M5eHBRUDIzaEgxZzFJSk9pWXVKeFo3VzloMlJrenhlcld3?=
 =?utf-8?B?Z1RmRGFOT2hHaG92N3N0VkZPcWhWRWZ6c1Y4ZVBiRHhLWUxCZXJpd1lHbnFO?=
 =?utf-8?B?cWdpYTg1OXZKRUdtU1hKclVmY09FMDR4eE80aEhBODk1S0U0bEFoMmdCSnJC?=
 =?utf-8?B?OGhKS3BGNSt6NVprL2IxMGNMUVNUejR2YVp0Z2liRnhrdGNwNU5DWU5PVEZX?=
 =?utf-8?B?cUVvQTg5WmFoM0VIaXNxSnVHajlGcEpsOHhTeDZjK0h0UzAwejU1OUtJb25Q?=
 =?utf-8?B?dWkzTzJIYk5UcmpreVFLNlNXS3c0eGttWkpvZzFkUHZCRERjOE1OTkFlYXpP?=
 =?utf-8?B?dzlMT1d1U3NsSk9IeDdiSnpGcU55SU1Ma1V1WnEvc2N0akZIRmpsNHVidnB0?=
 =?utf-8?B?VW9qYUgvTDVqMEtOcktZNVFNdWxPMm9uMFk5ZmtBSTMwZ2RQa2VqcTByN1dN?=
 =?utf-8?B?L29Zb25LSjJXbU5GZEhqT1ZIdTFtY09nN0JVZ2FvOXdiak5hV3BFYU14dW1M?=
 =?utf-8?B?S0pxY0o0dTQzV0VPb3lkc1ZGQ1NRR29mR1pXaFJOalZIUHEvaWlNTnV0NVhS?=
 =?utf-8?B?R2NSVmZES1BBSHRwVE8wN2VoZzB0amRYd1RLMkV1eGIvM3lmQ3hTbkF2Y0Yr?=
 =?utf-8?B?R3VNcDhVb0NxWVhMcFFOZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmxmUkRLQ0hvMk80eDVGTDlaUWY2c3d5TDZIZTlYKzNRTjRPQnJ0ZTFydXh1?=
 =?utf-8?B?ZFZVVk9nRFU5UmltSjBrdlJ0dmNYZTFSbjJMaVd4eUsyNmgxR21CRmMrWEU5?=
 =?utf-8?B?ZENZaVBkbzJsR0JHa2JCVlkwZkJmS1BIZklsVkVVN3JWcUduODFRWDJSNGpo?=
 =?utf-8?B?bFh4NjV4dzRvQVdGWXMvNk5OekRRd21jaGttcTRMMzQ0bGZrdW9SYStFUnBk?=
 =?utf-8?B?cytLVmNVQ0R2YVk2RldwSHdBY0IvRklGVUdlS0dEUFNhenNMR2RZVDdKeEF1?=
 =?utf-8?B?VWM4SFhKaWYrQU9DbWlZZmZHTHp5cFFOM2ZzcTR2NXp4VzdjQTZXcnRRUFpB?=
 =?utf-8?B?Qi83dWw1bzd0eGNFWGRMYndMVDArVTdjV2wySmdSdHhYNVhoR1NTeitaU1ZO?=
 =?utf-8?B?dElpazVwZGFjSEdHT0lqbWNaWTRLQ1Vjb3BLZE5ndWk0WXJrRVJOSTZQc0hD?=
 =?utf-8?B?VG9URTdEL2Z5UGlRQW5uc3lyRytDY0NGOENmTFNHMEJDaS8rWmVJbTViVUdL?=
 =?utf-8?B?N0phdkNha1lpUkxIUS9MZURUWGNCMENFcWEzSnBxdTlqVTh4WTZjWTA0b2FY?=
 =?utf-8?B?NkxtUWlOREF4U2pscFA0NWliT3RSc2FDbmExRG9Za2JZT0RtdUxXWkcxY1pJ?=
 =?utf-8?B?SndwTGpqTG9VT1hNWVBWd1JwN213U29XSUV4bEJIVkR6a1UyN2xidWk1V01U?=
 =?utf-8?B?cTNLdnM0RWxBSVVhM3RPZzVBRUhKK1RiOHV4QUo2dFBEYTJ3WFo2cWZBQlVD?=
 =?utf-8?B?YUxERWcvMlQzOW1rZ3hDYTk2SnR4OXZTTWlHSGhRUXBudUI0Tml5akhMZzQr?=
 =?utf-8?B?c1ZDdzVEajdFWGJYampkNm5DTTJBT1czRGhwdnh5WjR2MDNXV1hSN0pIZVYr?=
 =?utf-8?B?elQxcWplS3FLRml6QUhiWlRrS3o5UFZ3anBsdzFtVWQ1RW96Q3Z1Q0RMMDhD?=
 =?utf-8?B?SXd5UTZLeVFJelB6ZEkvMU56cURPWTJITVNEQ2dJRnVXd1QvKzVBZDVtMmN4?=
 =?utf-8?B?cTkyRlFWYUN4RjlsbzBoa2VidVVCbWZRdGFhVDQ3N3BiLzVGRlRWbHFzOUVJ?=
 =?utf-8?B?cWpESm1pdFdaUDJybVFEMStMWENacW5BQU1RQkZqVEpYYis3MTRPdXBYclFV?=
 =?utf-8?B?YzhvZUcyOEpXSXVJckc3NldlRkpTZGVmRTF0a0tBa1VrUjZIV0J1blBEK245?=
 =?utf-8?B?bVJYcFpMNzhwSytvK05lVUhJeDNjdnJoUks5MWp3YnRZM0owcStaaU91TXIx?=
 =?utf-8?B?c29GcjZiV2dSdlFOdks5SktSUnlTVTNhQktTUDVSS3p5cU1Zb1JwRmFhMWRQ?=
 =?utf-8?B?SENiNWVhb2ZpeUQ2OFFvSDQvQ0tGbTdiN3Rvd0tJU2ltM3NYbk5yOTFnT0dX?=
 =?utf-8?B?aEFnemJCS250NjBJTHRGUUl1QnJVUTFUemFmNWl0dUVCamZJSVUrcloxZStG?=
 =?utf-8?B?RUh4Vll0NjJRVEM3cUZzejFoL1ZUTnF6UUZCclVqdzlDWHY5aGlYUloyU3lX?=
 =?utf-8?B?eUJ0RkkzMWF4Y1kwVWJzOFVabUhzQ0V5eG5Ea0hsSFFtR3ZTai9HTUJnZCtO?=
 =?utf-8?B?cEVjQ0syN1JwVVZJTjVWaStkUmJBaDF4WkRxM3BIRmZoQUN2MWdWVy96VHp5?=
 =?utf-8?B?dG1NMFp1RTc4SG9GMER6RHFtTW9qL2NwT2xrTFB4SWZIaFFCNm9TS3pDSWNa?=
 =?utf-8?B?U1Jub21qcUQ5Z2hHSjJSb0pPWkt6V0Q2QTFMODFaTi91aWgzZ0xPR0lCZGdp?=
 =?utf-8?B?Z3lmTWNFNlRsaVVTUzVBTElMVDdlemJmZVlrTGpzME1jMTQvSHg5ajZJZkFv?=
 =?utf-8?B?Q1BNRHMzakJ5cSt3Vkp3WmlrS3c0U2Y3bEQ1UjRiMzRNdGMrYTJOOGZibGNR?=
 =?utf-8?B?Q01jdTN3U25tN3l0Qk9sQ3puenVNOHhpOWt0aU1vd2hxRUp3Z2VodkdOeWx1?=
 =?utf-8?B?NEUwMTlkMWxwdjRMK2NCdnREK3BINTdSd1BYL091OFRQQk85M3paVm5qMmRR?=
 =?utf-8?B?SWt6bTdpdmxkSE9yMmhseFpaeS9KNnZUSENpMCtKT1BuQ2REZ1hxaHo1UjNw?=
 =?utf-8?B?UnpUZk5oU1JLU285N2NkUzFIS3JHQmo3YVBDMFVSUnFUSk5JSmxMVjczQU05?=
 =?utf-8?Q?3uqov3mUqa4Isj5W/PNwCvlwr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3eaf04-eb98-45a5-c6c7-08dcd8d29ecb
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:43:50.1488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNPN3sbO9r3GwbFEnfG3Jo0d615gTK8TOkw53VbR2yvVdE7x7oTfyNoMd7/IC9dMUy6YuPKj2GTmgSYoc+ZKog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
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


On 9/19/2024 10:17 PM, Alex Deucher wrote:
> Need to make sure it's halted as we don't know what state
> the GPU may have been left in previously.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index d4f19eb8ff6d3..3a3ef93f2f43a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3931,6 +3931,10 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> +	if (adev->gfx.num_gfx_rings)
> +		gfx_v9_0_cp_gfx_enable(adev, false);
> +	gfx_v9_0_cp_compute_enable(adev, false);
> +
>   	r = gfx_v9_0_kiq_resume(adev);
>   	if (r)
>   		return r;
This is a precautionary measure to make sure that the GPU is in a known 
state before the driver attempts to initialize it. Adds calls to 
gfx_v9_0_cp_gfx_enable and gfx_v9_0_cp_compute_enable with enable set to 
false to halt the CP before the KIQ (Kernel Interface Queue) is resumed.

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
