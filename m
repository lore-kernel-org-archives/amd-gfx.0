Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44532C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 12:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54D610EC11;
	Fri, 29 Apr 2022 12:54:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAB110EA0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 12:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBMV7WM+HDHwfRFH0SCrAR0F7NSPN+eIBAkW4TZKSgRZSZqQjC7nAZj7kTUi+51IwyjaDIzGFP7A4uxM1+Bwgv2T4b9SDSjwpKI9qYVt04QOBXUqJxbcRki+s9uqvhEDxMlfcru/OhmXXtEv1XteMyRRf5iQAe2sadlUOkXc4IIUVG36F/R3a0QdstB2vBm/2bY2iD1aRSvvLV22ivSGVK5M+eK72xg0QA/N/SDXkWhIGUEls0+gSX6L6ALPO3/09fJo/6HEKXbV8w72uMWmYEr6cM5q1MDnfKh0EcCRMQaVdhL4iMV1MMqddw4GCIcogLjkRu1IEg11T1SvBS/3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1xVquswhXQ1wfqazWIvlEn/Uw/VWSTJzY4LbgroMms=;
 b=j8Qt6B9WtDTIzsavb3EnQXdfBqTvYBkFHmF+lOVhTFnj/eFc7dcEFQZzManVsDzAquR8l9ZCyDTqJ5DuFPvxhz5+HQ2jPnk1eNSXXwnkzFVG5d9TE8zXcS/YFPYcpFImQi1TI156N3B+iXABdCgrkNix6jANucU+TBAiSmC6iArDb413B6baJfz/J9MBpzODymA+fsNaGQBfDYuexhtM1pmvb+tRJBToHzmujLjpsECbAldX3KQ3AM5uQ4aIWPDTgjgRmpv24cFPywNMk9u3ayaMBiopxzpqppz9Tb686ThhN+544obJ+hSrd7UI9hEfgx3TWQXXZnxqsvQyqYaEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1xVquswhXQ1wfqazWIvlEn/Uw/VWSTJzY4LbgroMms=;
 b=UPf7/2TBKi1FJ5tDuKCuSVNogG7ck2kDomPK+LqDn3O5tWH5vrQWClZpc6v5nhZI7jK6M+t4kdcABXsGpwxlLPYcz/6tI4oNwV0cqHYLBDoa7gKyYAn88/qjaC74Nh/WdMXK/g1qoGlnsjhTn9CptKtWVqk8QKRZMkErTKkxpOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM5PR1201MB0091.namprd12.prod.outlook.com (2603:10b6:4:57::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 12:54:17 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 12:54:16 +0000
Message-ID: <8db428ab-3f2a-1e88-0932-058dfcf66812@amd.com>
Date: Fri, 29 Apr 2022 18:24:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] drm/amd/pm: Disable fan control if not supported
Content-Language: en-US
To: Elena Sakhnovitch <elena.sakhnovitch@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220428202019.1494874-1-elena.sakhnovitch@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220428202019.1494874-1-elena.sakhnovitch@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce79f152-e58b-4763-9b4a-08da29df5e5e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0091:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB009137F084040265BD7CAC1A97FC9@DM5PR1201MB0091.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHE74vTsOV/Ekm3SZ1GmjTD7uy09Vvzlkf1UUwCENZoHnFBUiYdHIcqUN4+WPRgXe19QAlAcXvJ80THENtn+k4o+peT9sr6ty9dbWn3LhW0TBf/CVDvPb4yhwMQdywCbgNJvIt18CVH7LXlTJPZ6ZbViaigJmzamRBQTRyGguDSS4ySEQfXtczDG6X7FrDm2H38YRevwahjOZpW+zHNzzsS1OYOPpj3BYRw+BRyh1tNR4DgnZYPaBNuI8soWrr1JBVnf4S2A8GK80hxOUrd/r2BLZU/TJPdN8Sby6gTOwDuUoXsAIy/o7eIFuWdvJZbSaWmxChDe9I1946RERj9zNXEkopQR9w78IKTH92j7dLbkx5m9VJNMExE0XvAEOjjzpRak9A+3oG9HweYVg+zteTwM2G4CLkbn+Ihf4JjrGRyK+POla8SmhYRLfr+omDt01ApZpJpedOuadgWUKW6R2CKjVNSy+Y9E/NW5r6VTIw1Rrgm99sIIIiz2/uuHp5XQ0A5UU+KaQRMp5zirBU9MLsNpOzMANl8cCNpFtihJsaPO9VI+1BFreeTPaKo3FunyFSyvRYKo8evNutUBW2MgruQaHFP0S33V9GB0QLuDqFGvr/EDyn06U84dapueUIDr5oyyr6VHTtxPXFdyZVIu07zJprXIH51DRR+F+3eYHcdfW0tojQ6tniQany1nQ3sMIO5PJldasjSzFbP6NNj0fJs0crCUdkp9sLW/9P/vsa0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(36756003)(83380400001)(86362001)(6666004)(316002)(6486002)(31686004)(31696002)(2616005)(5660300002)(8676002)(6512007)(53546011)(186003)(26005)(66476007)(66556008)(66946007)(508600001)(38100700002)(6506007)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWtySXhDKzhZc09wcmNlVVQ5dVZTbzBzVVRHSzRaSHJ0ekZJdGw5N2xLbHk5?=
 =?utf-8?B?VVA1TzAxalpzZmRZdTZTeG9WRXc2b2NvSi83aktzb0h3aEtaUlhhaXVHcnBz?=
 =?utf-8?B?RlUrOXNCRWtwaUZIK2dMRnFqMmdENDF5cVFmZ0k5LzBnc3dwR0tmQjZwWFNo?=
 =?utf-8?B?M01DTWp2QjMrR242TVZqZGF6RnF1VlN2U2JadU96RkUyM2hlMW5ZZGt6dVFV?=
 =?utf-8?B?cXY5TFJweWFqZWFsU1VSV2NoYVd5WDRBL1J2RkU5ZGY5WVNHN2I1THJieW9l?=
 =?utf-8?B?ZmJwTEI3eGVCMVJBcndWV09pVHRQdzhvdVZHUXZQeG9hZUJYNjRVK2Ezc1Yr?=
 =?utf-8?B?c2MvZ1hMYVhQVFYxQkcwZG0wV3cyeG4ydjU2ZkhPZVBydmltV0duQnFodStV?=
 =?utf-8?B?VlFDdEFNMzRaaHZBNi9FL2ZaS01CZjRoSUNVVHVXMjhQS1FyQkhFUXd0MFdt?=
 =?utf-8?B?L0RXQ0tvQjkzRmdiTk1WSWJDMG1lM3k0M3RLancvUWR2SnRxaG1GUkVjaWls?=
 =?utf-8?B?UXVHcGtiZVdobkhCQWNJMDd3M0ZGTC9WRXczQzEvckJSNnN3cFpLQ21zNGJY?=
 =?utf-8?B?b2dRbEtzUkZNeTk1cVVUVWFETzI2TlNpMGRDUU5MQWtEaFlBeGlNODRUUTVy?=
 =?utf-8?B?R01rOWF5WmZiaVRlWDdOMjRmNTJUNTBiMnhkR0w4OHhSNlkvU2ZSNXVqKzFi?=
 =?utf-8?B?Zi9RODlEZDZvdUxpK3dWcDl0bXU2MXNLT2liSVlEbTRLWnRGUXltUitVZWFo?=
 =?utf-8?B?dUpubkxSWmt0dnBYYk5yS3doNXZxaEg0QWNBT2xuNjVLdWFHM1pSdGxVZzlz?=
 =?utf-8?B?akZlaUFkaUt1VjdtYzN4MVhEdUNkWkgvN1BveEVHeXBsbzhOMDI4RkdEUmpC?=
 =?utf-8?B?NkNhcmNWdDhBR04xR1BkeEFNMGRFR1F1RE1WQmY1MWlkaVNDdnhuWkI1c1pI?=
 =?utf-8?B?Z1hEeEtPM0FvbjZVUmRQV2xKaUJ3bDR3clRCRW5VaEdQZXhhZTYraVV3RW5G?=
 =?utf-8?B?RlZHajZ5aHV0Skd2WjBIVDJ2NzJobW81emZrZkVGcTA5VDdTVS9OOVJGRlZR?=
 =?utf-8?B?QU94YnhYQ2prblNrcEJ0cWVrc1RMaUw0QTVVMGExRXVJSjl0eUhMZDFXR3h1?=
 =?utf-8?B?Smx6Rk9qZnFWT1ZFbGJDUG5maEpDbWdvZEhMeGwvRE00MThPVXVicnlFcXdz?=
 =?utf-8?B?cXcrd21QSlFNYUltaS82eHJFdHdoS1ByTDFDeWZ4dHo0TkJCTHF0MzFaZVpz?=
 =?utf-8?B?dXl2NkdaMTVzbG14YzNKSUlFclNyYlJEa1ozODZQb0NQUXRvd0UwNkx6VTZz?=
 =?utf-8?B?VkN2WEF5M3BlbDBtdm5qaVFiOGhjWVZNZnk5ZXAvYkRpMEFIYkdhWHFCUy9u?=
 =?utf-8?B?RGNmblhwbGRGcTE0L2hSS2c2VlB1V0Y0RGhSZ2x0akR4MUo0T3lUdXNQMjdp?=
 =?utf-8?B?bXhnSUtRL1dXQSt2WG1McjFnWllSSG5NMkxEb1JlSlZyRmZ3UzBub1lmYXRJ?=
 =?utf-8?B?RWMrZTRXMHo5cFY2R1NXVWN2WnpVTEYxSUh5dXhBNnZCLzhmMW5kY1BPREJ4?=
 =?utf-8?B?UkU2anE4SnU3RzE4QzA4QXBwMmZ2Vy9BaGVPMDdUczZpak9yOXRzL2dNQlNw?=
 =?utf-8?B?aWQrMDNkOXRkZk56SUxTOTJzVDV4RktKRHRKQ3BqdGpUTVB1VzRaSUVzK1A2?=
 =?utf-8?B?NmVPc2FKSmNNVFowUjM5RW4rL3hLUlNsWHR2Rk1rNDk2cEhqWCt4azNVc2Ew?=
 =?utf-8?B?ZEJwM1IxZkh5U2c3cCt3SVpTdEdFbXY5TnQ3L2JaeVI5NWltNWh3S0xJc01H?=
 =?utf-8?B?OWU3aFlKYVZxUVVHSW1wQkk2NXJrSkppM2dnY3dURnhTUklDUTI2NUNBOWxJ?=
 =?utf-8?B?U1dQTGxHQjdUVmRtMlVockRRbFA5OGFjbVhKcENEeDNUcjIyVjgwZHRSTFMv?=
 =?utf-8?B?R00reW83ZUhlUEVQYlhxTStUenFKZVg0UVdKODRzM29rMkJ4UzhNaXhHV043?=
 =?utf-8?B?QkJJNGdDMHg5YmdFVzZTb01jZEQzVC96NGY5Vy8wSEZVSTZGU2U1bFFJb0Ry?=
 =?utf-8?B?SVJsVEVXWG1tQ1NtN3orUEJyQy9uSGVKSDYxMm9HOFA3d1RKUTJERzQvMWVJ?=
 =?utf-8?B?UjR2ZlJWdE9pSkp2YWFVVnZZOEJCTm12aS9LVFRCRWFNZlhNN2hFbDY5MC9S?=
 =?utf-8?B?UDhQQXloSlBGc3RCYVQ5UFA2VThRK2wrdU4rYjU4bkVqYWxRRUUvUzVhamc3?=
 =?utf-8?B?aFI2RTNBRUkyazlKY1FWVkhybWdWUzRIQ05aWWUzOGNnZFNPUkdlNzY1UzlV?=
 =?utf-8?B?d2pyeVRydDRKalVZb0VJQ2dhUk5XejBCOCtmMFI3WjBHdlphQ2pEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce79f152-e58b-4763-9b4a-08da29df5e5e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 12:54:16.7488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTduMzGfU8nNbcxwYWYHUHuoT1bcQ38O6tcOqWBhWMDwxoYDIVkVOthe59OIWcW3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0091
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



On 4/29/2022 1:50 AM, Elena Sakhnovitch wrote:
> On Sienna Cichild, not all platforms use PMFW based fan control
> (ex: fanless systems). On such ASICs fan control by PMFW will be
> disabled in PPTable. Disable hwmon knobs for fan control also as
> it is not possible to report or control fan speed on such platforms
> through driver.
> 
> v3: FeaturesToRun casted as uint64_t
> 
> Signed-off-by: Elena Sakhnovitch  <elena.sakhnovitch@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index ab3e9d8b831e..9ec44b4e9f83 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -371,6 +371,22 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
>   	}
>   }
>   
> +static void sienna_cichlid_check_fan_support(struct smu_context *smu)
> +{
> +	struct smu_table_context *table_context = &smu->smu_table;
> +	PPTable_t *pptable = table_context->driver_pptable;
> +	uint64_t features = *(uint64_t *) pptable->FeaturesToRun;
> +
> +	/* Fan control is not possible if PPTable has it disabled */
> +	smu->adev->pm.no_fan =
> +		!(features & (1ULL << FEATURE_FAN_CONTROL_BIT));
> +	if (smu->adev->pm.no_fan)
> +		dev_info_once(smu->adev->dev,
> +			      "PMFW based fan control disabled");
> +
> +

Please remove extra blank lines. With that

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +}
> +
>   static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
>   {
>   	struct smu_table_context *table_context = &smu->smu_table;
> @@ -381,6 +397,7 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
>   		smu->dc_controlled_by_gpio = true;
>   
>   	sienna_cichlid_check_bxco_support(smu);
> +	sienna_cichlid_check_fan_support(smu);
>   
>   	table_context->thermal_controller_type =
>   		powerplay_table->thermal_controller_type;
> 
