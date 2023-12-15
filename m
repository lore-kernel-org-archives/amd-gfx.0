Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C09C35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 12:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8013B10E9F8;
	Fri, 15 Dec 2023 12:13:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FA910E9FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 12:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHBXd47NcJlK4OX1t9TjAj7gJuAPrnuU/UmO5hJXJxaG9nfZBl+tDZDazBlslGnOo6m3qW9FaP9S38mdudYZS1y6l+yrskDfwyR18YQwaRK3Dh+/1T3MNTvt1Rm/Snr2y3piIVNW+IlKWi0m+xcPE31SC+oTwXdsHatmHV4plqmaswo+/ipj0NJ7IuDiLXAM1KWnRFqg1DPQPYJpkR+MtCN/e99VrurmNevKzRD/bs0JPOD1abnyeDr81cquZevit8BKBdtpWKpunW1Bwn5x9zrzW/w7o/ZQMhcKmhsHQgh1txci339viviKOeIChnm+kWnLw/I7BQ0KGnoKZH8Jmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt+mPW5WPKmU/6bCG4piKq+ORaSZDIueTeWXhF9Hzko=;
 b=lBuqVXYfQJdYwNHaIGPLkI6mIZwhTMsqcFek+hU3uWKUhEjapSdGenrra2cIFNO2TjC9josqFCKEh33XlfAI16L/vjnewX5BFo2yJC7jPGuNFYWsySfWTjwZf0N+4SeQBsIIzlkvc+1vPUdUVnYe6vxWepLaXL6WOreeTQXTwiyQz4E0KADxMrjetJrVEE6fye9qlC9YRVwL4/fuxC8yd6c7UwgicipeUW/1/iWzT8pKKf9iS/RO8ZTyuJV3XM10bwUIDtp9oWaDvtDCYYt67UVv/NL4mEh6pRfokYigTYPOSx1pTCOaTf9Ah+qd/Ot6uSHmswnx6ysPlPqaHgLf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt+mPW5WPKmU/6bCG4piKq+ORaSZDIueTeWXhF9Hzko=;
 b=bmTIEDg0CqIqF7v0eNf2pCE2oZtwmR421GN54087racVB6aWjyJQG8gbP4maBOfdY8BqFjarGiWGZ/7/gg/QaVrfWTGAGm4SWFFkSzuUn2XX5vdFLB3lar38TZCAXRo0DL6mTnJsMn0b8TwuU8tTImYP/wEZQV86kla64Fvgxk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 12:13:09 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 12:13:08 +0000
Message-ID: <494d717a-7b5b-47d4-afea-0a703d78c672@amd.com>
Date: Fri, 15 Dec 2023 17:43:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Make SW CTF handler cope with different
 read_sensor() results
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231214164547.6739-1-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231214164547.6739-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0244.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH0PR12MB5402:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff92ffd-3d1f-439e-59af-08dbfd673323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6u0z4eQf6Gy+V5Jgq84asF2LavMDto1KooKSz5Sl185AU9FO7kED0Ei94g7IfBcFk01NVcvu8M+6VToLDtrtqUOiTMFq1vez+7W3pB2pAaESXKlFjKsBKnTuaMj+8qQoiGoPmHc6sG26XaMZQ82uOBqkJIss/NjGvbVBB1iJe7aeG6t/mj4zw4GxJM7naJo/Q7lI1Lprn1Fdla+MDX+Vi9s/Bmog/9Z1X/oMZXo1WGjKXvVBbzn5T6uGAYJOhBugkWMQsa6easnDArMWG2sZ48/pyta4mjj9WGW7FqtT/js3zmozDPYbjb9LjLPQJcSppyaT/57khBK2u9Qv4Oo8gmY1JuiSH1j3+yZCTl5Mygb72RWut3nSxYHDja2v/UZOB1Z3htTYkL4IAaZ0u/VSm/R42Z7+wO51oZqWVqyRIGqguy+TOsNaoXiJ09PNGwwPfXYOGJUCxZX8FdJCTQtUC+fXfqQd4YB5AlA9mqT1qyE7/wiVs1BowE/N414Ju+h3u6hph7ODEFLH/TriEejbrENhyVJ35PLlA5nXtN1q3tE1ZKXSg6dlgFcRMjEsML1yP88T7X3o27co91vhOWvz1olerBqeiCmPCe5wmMghRU2SGPIubOLNYyJi6IQcxUZOuwAbGxqBFYuZI4r4mpHDiC8v739pZ4Pvl2uhwn/nBlzRzdiGt/Gs+plLviOrHIhT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(66476007)(66556008)(31686004)(41300700001)(8676002)(6666004)(83380400001)(2906002)(8936002)(38100700002)(5660300002)(66946007)(316002)(31696002)(86362001)(6486002)(478600001)(53546011)(2616005)(36756003)(6506007)(6512007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2xwZjFleXQrcHBZNmpYRFN0TGJ1QmhSNTNOc0t3MTlJRWJXbjBqTGtsOTB3?=
 =?utf-8?B?VTd4RkltdWVQZ05tL3l5SnF2ZFhRZE1mQnR0K2QxWDgxbHZid1lkNWE5VDNi?=
 =?utf-8?B?ZlZzRWZpaHhBeHV1TXFqbTd3amJaa3MvcXFCOWlRMWYzbVI5UDdUaUxYRGcv?=
 =?utf-8?B?WnN3VkJnNEFDcW9lblh6TWlpRy9TQnJaU0paNWJFWExORlRpQXJjOGJlejV2?=
 =?utf-8?B?UCtwMlJ3SXN2YVJuU2Zqa3Y1dko3TFZjMUtXNyt4R2xHOUNiSnhRR29zeHJD?=
 =?utf-8?B?bGxwVGMraGpnVjcvZlNXMzVSbk5FOHUzSFdXbUFsSkRMTkxwcUs3RGs2b1Z0?=
 =?utf-8?B?YmYzNjJhWWFaWmY3R1FoYUV5Qm5KZzdiL0orUkxKenlmSE1MOFdMQ0thMEps?=
 =?utf-8?B?VFBCMHpBaUFFdHdMakJPK2c1VmwxbEk2ZTludGZML3Zsb1FJNjRoaWY1RHlU?=
 =?utf-8?B?R2VnVzdjRDBHRTY5U2g0TGlTU3lMZHFHYi9ibTllNUN6c1lhck9ZeEVOU0U1?=
 =?utf-8?B?c05aQUZtN2RISGJGdjJaalBMcWJFYS90NTJ0TllRUDJ1RVZxMU0yL2JhVkxT?=
 =?utf-8?B?U2VhaTJReTFETnpSTWJ6eFdQUGFjWE1oMngyN0FEOG1DL0RKTWlxbUhLV2FD?=
 =?utf-8?B?U3ljdklSNXBUU2tVMThodmkyY1Y4dzI5aUhCTnZEbmNRa3lKbjF5UGhPNTU0?=
 =?utf-8?B?ZnBiY1ZYdXNlQlE4MGlxbEZ6ck1tdDF5dkRTdm56RHNud0UyQnpoNWR5Nit5?=
 =?utf-8?B?VGI2bFZHVVRxdkZ2SnVGYW5DNVdnTitpU0NDVjVUTENPMHc5OFRtZW9KbjBV?=
 =?utf-8?B?NS9tWEJ2WnlMS3ZEN2w4clhBTHhBRmk4bFhGTi9Xc3lmRzlDNnM2anZDK3NE?=
 =?utf-8?B?MWZneEh4Y2dhZDZVam9BQUZSdnRmUWdRTG9TRERtQkNTbm56MzVqbHZ1Rm42?=
 =?utf-8?B?WlpPNGoxUzNOUTRRRlJBTDllTlpNd3czN3poVTczQnIzampDZlg5SHVYVzNx?=
 =?utf-8?B?eEdnR0pTWk1JcDI0aVZJOGp0MVpHU1BmSVVueUh2TnZRa3NKckN6NHY0b0U2?=
 =?utf-8?B?d2I0aUpCcU81YWZ0MkpQbFVvVUM4THJrTzkvemdHZU1QdnFVOGlmZjZHbm9o?=
 =?utf-8?B?c1o5UlQyaWY0V3p1LzF4cmlhbGJ0OW9iUFVBYWJFa0twZWNmVlUwdHF5ZG5T?=
 =?utf-8?B?d0hxM3EzWDQyTHN6UXlBNkhoczUrcFdWQVlsSXI0MnJsbWVUYUNVYzVibVlH?=
 =?utf-8?B?UlJlY21xWjVaSk81YmQ4MFVUZjBMODFwUlhnTzZBczNsa2JmMHpDUmYvdTlT?=
 =?utf-8?B?UkFMcWNXWkc0bGN4akk4ZHRaQnd6S0JKVE5jUURpWjlaa3ZpSzQ0Z2dJcXlJ?=
 =?utf-8?B?c1RueVJ2eDdpbDJFb2VzK1lnc2l0NU54STgwM2o1b3pheXc3aERMS1ZUYlFC?=
 =?utf-8?B?aTdqaDVmVGVMVTlSb2JwTkZYc3grRjltWU84anVLNndmdVFKOTNXUnRtYXhF?=
 =?utf-8?B?SVBRUDdNRmFucXJ3Ym1GOFN2bG5uaDRhS3pRa3dIOUZXLzFhOG5SZW45Vkg1?=
 =?utf-8?B?cng5dG9jNVRhcURSRHJJYm1uNGR4K1JpbjJMak9OR2hUK3pKVzJidkRPamtn?=
 =?utf-8?B?QWNUREFZRUZteVExK1Q4Vm5BVlo0QUZaTUlpaHBtVld3aE5xUHpRd1JxK0FJ?=
 =?utf-8?B?QVNtQ0RGQ0JyTWdrR2VBVVFuakQ4MWxIcjl1SDFBMTBGUWtDaFdya0JTZlly?=
 =?utf-8?B?akR4cDJmT1I1aU0zUi80akM2ZjVIcVZMaXh0TUNwcjk1Qk5ZbjlmbFZJbzVV?=
 =?utf-8?B?ZXI4OUpJRWRqbDlYOG1pZ3ZteFFmOXRrZ0RUUGNubnZtcE5lRnRYZEJDdUFY?=
 =?utf-8?B?N2ZZSmRTd2VlKzBIQ2RvcGg1b1o5TXNqK24vSldOV0ZqTGR1dmgwMGdoZHMz?=
 =?utf-8?B?d0ljeS9rM3FNcU1HV1haM2F5cEdlRFlTYWFTbjFKbmVWaklJeGwvaTVBcUZK?=
 =?utf-8?B?RlRGL1lZNXdPcFZ2Z0J6bG4vb0lLUEp0M0xRMnBMM0FWYURoU3djak5PSWZl?=
 =?utf-8?B?YXNraTYxNDVHV3Z5QkpOcW5nOGxEYlU0ZU5jdnBWbUw3Q25xTjlGVDZDbUNM?=
 =?utf-8?Q?31kwVBbhEZ+uJm5zpTP57HONd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff92ffd-3d1f-439e-59af-08dbfd673323
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 12:13:08.8114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoaE4lbFCpYpKlBucKtLax3Wv5vHbYZsN1eRgIDV3hCEsCRCU0RLYaQslAqXEZFY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
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

On 12/14/2023 10:15 PM, Mario Limonciello wrote:
> The SW CTF handler assumes that the read_sensor() call always succeeds
> and has updated `hotspot_tmp`, but this may not be guaranteed.
> 
> For example some of the read_sensor() callbacks will return 0 when a RAS
> interrupt is triggered in which case `hotspot_tmp` won't be updated.
> 

The fix needs to be in the return value of read_sensor() to return EBUSY 
or similar. That will also help other APIs calling read_sensor().

Regards,
Lijo

> Adjust the logic to catch this circumstance and output a warning.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index e1a5ee911dbb..5473fda5c6aa 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1163,21 +1163,23 @@ static void smu_swctf_delayed_work_handler(struct work_struct *work)
>   	struct smu_temperature_range *range =
>   				&smu->thermal_range;
>   	struct amdgpu_device *adev = smu->adev;
> -	uint32_t hotspot_tmp, size;
> +	uint32_t hotspot_tmp = 0, size;
>   
>   	/*
>   	 * If the hotspot temperature is confirmed as below SW CTF setting point
>   	 * after the delay enforced, nothing will be done.
>   	 * Otherwise, a graceful shutdown will be performed to prevent further damage.
>   	 */
> -	if (range->software_shutdown_temp &&
> -	    smu->ppt_funcs->read_sensor &&
> -	    !smu->ppt_funcs->read_sensor(smu,
> -					 AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
> -					 &hotspot_tmp,
> -					 &size) &&
> -	    hotspot_tmp / 1000 < range->software_shutdown_temp)
> -		return;
> +	if (range->software_shutdown_temp && smu->ppt_funcs->read_sensor) {
> +		int r = smu->ppt_funcs->read_sensor(smu,
> +						    AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
> +						    &hotspot_tmp,
> +						    &size);
> +		if (!r && hotspot_tmp &&
> +		    (hotspot_tmp / 1000 < range->software_shutdown_temp))
> +			return;
> +		dev_warn(adev->dev, "Failed to read hotspot temperature: %d\n", r);
> +	}
>   
>   	dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
>   	dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");

