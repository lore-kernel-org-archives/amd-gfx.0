Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E686CD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 10:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B271E10FC1C;
	Tue,  2 Apr 2024 10:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MtRaPy4H";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2119.outbound.protection.outlook.com [40.107.220.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 766B410FC1B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 10:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpF3DkL+fl2/pyKz3+cPMwy7a4szNa9H0P7F3/mUCJI99Yc/Pnbx71sHkgohqiJw14CXMMltis0lYWvIt1hPyIDuYhJ2u4vpzAffI8BPCp9rNaNpMDwnDpW6LZ3ocZlaMTKZ8f7dPAwgkUNL/PmvmFZINpXLQsxEoVxAqvcUyWrOfodqEd5SEJR5IbWz/RvgoxgUlpDPSkp/pGAVYdoeNcHWop9Fw7XO76yrHoMapmtGEWilBLQwsl44UiQW2Jj5D0ZFIhXpS8m4fucj7eFo2oLyIOaaJJS0Op5zwF34NwkJDWTlDQM5HYZuFtIQsiEgoguL0ucrq9N+C1BL1wLwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvMfWj1dcvORABU05/75sD321M+7AxYeKpXrZSbnGwE=;
 b=MHLPQF9Z1uMGwoggfyRx+PrWTV5nIPJeUgXxOoTnKq/ckYzITlWLMt2voRA7OSfqSltZr2JJLZ6TTsWuEezyEImlNg0k+7ijC7y+sZdcBoypmo0WvpQ1ezFzrnLzAla+0Bf1enAeF8m9wdPkfbNwlk70XS7u/vuXTAq8/Fk6vbPe6zJBteB8woj4UKJYOlWbfJAUnaXvFZiziM6vBRRpWtE3399psOtYma1mLyd58ODIjDqjM3q+DY+J/nJVF3JJISIg2XtpubtpzX1tHgphsoOVlm7NuTUlNx1mEIFkXpjkcgpuTs7G25LWWXsjRcpDleUk2hNsK9pL8ttXhq/YGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvMfWj1dcvORABU05/75sD321M+7AxYeKpXrZSbnGwE=;
 b=MtRaPy4H/rhf0X/OgOzApOLQi8fyMhT/B2B4c4kT/lw3UlPklT5+mZ9FtAjMSJ6DENhFP2CWx6laT+/0p/LqpZrNUmfNXhyYxzWevQeYt7q9cyLaEwVd4hd8uhdtVYzIJ3zbESlc873ReNmnXUyYCpfK2Td6Bi3PNIUdnXiUXl8=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:31:46 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:31:46 +0000
Message-ID: <4136ae58-2807-4a3b-b2c8-9492b7a389eb@amd.com>
Date: Tue, 2 Apr 2024 16:01:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: Update uclk/sclk limit report format
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 donald.cheung@amd.com, sepehr.khatir@amd.com, daniel.oliveira@amd.com,
 charis.poag@amd.com, Shuzhou.Liu@amd.com
References: <20240402102244.3374108-1-asad.kamal@amd.com>
 <20240402102244.3374108-2-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240402102244.3374108-2-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW4PR12MB7468:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIOZie9Gp+tFRgoVxTYhVDbguoXLE5BKyLx48Rd6rLbz0aVHjke+uuX9el7+NCGUPHYSnBWyqAHlaDBOew58Nd1J7HXIJwEamx0uR9/18Vz3Fev4VeUG9VaGngjjzxh7VfZPJXBbWfQyp7eu3NYUVM9gQe1WVFiE7rlVyVgyZz4r3wotzIE4rsbvcSZbr6Go0NsOt+RVOdS1idDJU8buKKlI9P9Vb8P6dbMJ+PyCN5G9cabDMl15auh/I4KGOmVKuvtf5pfdYUTS3mrz9Ss53k24mMhiwW2pleSoN8PIWwjqKNq9cXzBvIs7T4i2OndPoSFuAbW50UHcoyWssv4hNa9eNCNH0djYPeDAylOlXP81cMuJx5u5Hk8OVH4D9wtT336mHURiFx5AXoIVmklBrUX+qyN4EOZQ8dRUAIY5os8ytJLjCqKUxTTY+Pz2zJzpfRLWjADt2bvicOULsl0vni31s0JVa1tCPBjLbz0qlmWQMmw+dK+QeQDkdWlskV2GyIWQX0VC3uiR51jgIClnrK2l9tF66+UEu/+zfP0jYC4YlZDLNIfqS03awfNeKtcZDTYUhq8sQc8Neow5DShDrQ6h+evc4xFiCWfJ0ChdCpE4B+rdSDU0c+7xVY9XCYIKznaThrmkNfQ9+hUJcJM/7qobINcMYaLcVLz9tWR8Igc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aSsyZTVRUFY5MjVqa2lydFMwdUJ2SVNqL1k4VjhaVlN4OVdBdlM5YkRMYmdK?=
 =?utf-8?B?Yll1M2RicnF5b0htamRFRnlFL0VPb1Z1RXNpOGJhNU1mckU5OUQ5YzdxUEVI?=
 =?utf-8?B?QW9IWmV4d1hweUpjaFFaZW9TYzFOdW9jeE1zNG9HbWFYZHZoTEFJcGJtNkZj?=
 =?utf-8?B?NFo4L3c3cFB4ZzZnbDNKWTBRNXBydTYvWjFxcGQxWU9OTVFIV0hldGZsL0lM?=
 =?utf-8?B?ZmRPeE93K1hrOVNmamhyMmNVRzlvMlk3SVlOK2Vrd0l1QkJMMm5PaDRMa0dL?=
 =?utf-8?B?bGcyNTlPVFZEamhoVUZFUzRicldJSkMvWkR3ck1qU0QxNk1PUEwySk9VT3N1?=
 =?utf-8?B?UGhvbWU4YmJoa1FjZXZlOUZ3eC9QaVl4OGQ2Y2NHQUVBbWNpYlorNC9qTjJm?=
 =?utf-8?B?dGhmYjNPNEgwMDd3S0ZFVzQ4bW5WZGVrVFpwU1NPZ0thSTkyR2ZyQTdmT0Na?=
 =?utf-8?B?TVB5MWhkTExsa3N1eGV3bGowMERxZW53Tm5LaDc4czNQNjFhKzJjazFPV2Vt?=
 =?utf-8?B?RkhWUm44VGwzTTdpL1AwQllUYzRxWnZVR0t6R1dsYlZPcENRVTNrYUFpRnJZ?=
 =?utf-8?B?RzQ2VXdyc2g1UUY0U3hSQkNkQVorMHhhUVJEaHhBcjdtVnE3SnZKZUdLSVc0?=
 =?utf-8?B?VTNEZDlPUlZaVDNhTkVwTDAwT2s1V1NFV3l3UDVFMlRDYU9nT2tNMElRb3Vv?=
 =?utf-8?B?Z1I5dklaTW40OWxwOTBVYTN2L2N3SG5udGlOSW96ZWZEZGdpK3Q3MzM0K3ZC?=
 =?utf-8?B?Snl3VjdyQkp2U2dWNzZSRXlOZ0xsWGplT1hJUmw1dk9yamU2OWVtYzdabGIw?=
 =?utf-8?B?bEV3NjZRSXVSaGZCaWxSV3c3R1kyWjRFQloyUmpiUW9kZHVWUVE5K3lTQTV1?=
 =?utf-8?B?YjVsd0QwWDFTOXZQQldINVNzRVQ1SzFxWFBZcDFoOXJ2Y21LT2pRRGxhTHFE?=
 =?utf-8?B?cW4vTWpDRmN5YkZGcklWbUtwQ2R6YzlsM3hEWGttMUsrZHphY0UwOXphaWwx?=
 =?utf-8?B?RFF1TkJ6clpUTUxOSkREaWJmZ3hEclA1R3ZaOWRuVkVXUFV5clBHTzVjL2Yx?=
 =?utf-8?B?cDZrdm1JTlhOU3RRc0dIUVNEREZOOVBBbm1rNUVQR1FQVmlUMEIrVXgrU3E0?=
 =?utf-8?B?ZkRiK05qajRFYmEyeHlzL3Q4bGllQi9qYXRPZnF2NTZjT1pERFJ0RnJ1am94?=
 =?utf-8?B?amVxSENmM1hPYW1DTkNZSGxvM1Nid3JpZ2xpbm00TTcwZkFpWmU1bFVGbEZI?=
 =?utf-8?B?TituTzZZbEVHWWU3K2N5Q3F2RXA2YWMvMnJoRkhYaHBOOW52akRBbXZXV2Y1?=
 =?utf-8?B?MHFraTdYdS82RGlKZk1DdXFxb3BnMXVrYzY3VUhlVVYyeGI2K0FCZGo2VXBi?=
 =?utf-8?B?S2FLTUJwVzVMN2JaR0lxNzVHcTdRekdNenFyem43dWQ5QXg5OUE2T3dxVVNV?=
 =?utf-8?B?RWp4THFzVlBmSlUxTnZQSDVadC80bHdOTm1zdzgrMGxUcjJxVzdseERKMm50?=
 =?utf-8?B?Q2w2ejVUNzkvMWZXQTh3WG13NlU3V3Y1TWRxdC9uRi93bTY0aVNnV29nejBC?=
 =?utf-8?B?RGFxOS9aeHk5ckFpZ1hjN1BWRmptVWZ0YjJkbWRnS1dyS1ppN1ZEWk1FenBP?=
 =?utf-8?B?Sm4za2gydWhyd1JhaVBqM2lNL2pxTG9Wc0N4Z0FvTkhjNnc2aTFIVDNVU3A4?=
 =?utf-8?B?RTk3QkVPanV2bFJUQk1qbnpUMzlKSnB5dkVPZFQyc20xNUQ4cEFHcnA0eE1n?=
 =?utf-8?B?U0EyekNrTVNFZTlsQkErVTNiOVlEQjJnRjRCRC9QUk9kMWJFMGUrNGxYZklM?=
 =?utf-8?B?TEt5dHR0WTdid1h3WkJOSXFwaWVNNC9vYW5tVUpsallTdHpTY0hGNGxRc21D?=
 =?utf-8?B?dkhtTEg2KzMrSWh5WUc0RDFhRzN5eGpBWkdjWk0xdHkvbWtjQ1BsVzMxMERu?=
 =?utf-8?B?ZDRtY3RKWGJSajI5VWxFMmlkWGFUT0JZNkVIaEJMbnVrTFBZelJFR0M2bU5N?=
 =?utf-8?B?RXRpWjdxY3FrV2p2UDRkazdBM2Z5Q2JYYlczMzBUL0RmWDhEcVZvRU0xQnNB?=
 =?utf-8?B?dndUa3ZJdG5UcFdQQlJBMDkrbGZqR2VLR3pTL2pHbUU5TUljVlJ5eE1xSHo2?=
 =?utf-8?Q?dZE3Xf6FnziBOQO/trYF4uR2y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28036952-b4e9-4f6e-8272-08dc530018bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:31:46.3379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+5jPJO0p8pHhK0dVlVd6eJyZC6GVx/rP2Tdo+ZmZY9x/Yjbxqtk+KQef6VgUO93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
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



On 4/2/2024 3:52 PM, Asad Kamal wrote:
> Update max set uclk and sclk reporting format for smu_v_13_0_0
> 

Use aldebaran instead of smu v13.0.0 - both are different. You may also
add the description similar to patch 1.

With those updates,

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index f4b31b86e2a4..6f0d7602d2a8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -759,8 +759,11 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
>  	switch (type) {
>  
>  	case SMU_OD_SCLK:
> -		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "GFXCLK");
> -		fallthrough;
> +		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_SCLK");
> +		*offset += sysfs_emit_at(buf, *offset, "0: %uMhz\n1: %uMhz\n",
> +				      pstate_table->gfxclk_pstate.curr.min,
> +				      pstate_table->gfxclk_pstate.curr.max);
> +		return 0;
>  	case SMU_SCLK:
>  		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &cur_value);
>  		if (ret) {
> @@ -788,8 +791,11 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
>  		break;
>  
>  	case SMU_OD_MCLK:
> -		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "MCLK");
> -		fallthrough;
> +		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_MCLK");
> +		*offset += sysfs_emit_at(buf, *offset, "0: %uMhz\n1: %uMhz\n",
> +				      pstate_table->uclk_pstate.curr.min,
> +				      pstate_table->uclk_pstate.curr.max);
> +		return 0;
>  	case SMU_MCLK:
>  		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &cur_value);
>  		if (ret) {
> @@ -850,7 +856,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
>  	}
>  
>  	switch (type) {
> -	case SMU_OD_SCLK:
>  	case SMU_SCLK:
>  		for (i = 0; i < display_levels; i++) {
>  			clock_mhz = freq_values[i];
> @@ -863,7 +868,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
>  		}
>  		break;
>  
> -	case SMU_OD_MCLK:
>  	case SMU_MCLK:
>  	case SMU_SOCCLK:
>  	case SMU_FCLK:
