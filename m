Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2368AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC370611ED
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC370611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A6626F3AD;
	Tue, 16 Nov 2021 08:32:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83426F3AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 08:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mj9QQB8hmVr5mVY3xe8xtyeK3Q5ZixhtEj7ZjVm+uNUFc6CyZ/4m/3ldEE1P++OLFvlfoNdZ5n8MxfEdFUWJ3OR+2hkCCypODXEiyMKTF98ujXox3kVyGy6wftpod+WKSjKaRe5pubPPLOWNJWs0XMpeIIVjRf9X6qpvLeWnBBod3ydz35FPdEfKzGovQbdCvd3RUD36PMX4BLABrH2DTgRLMO7uWR0QDWRazh5ven0VVIhBAm7NznChwmHJhngRwGulWcmW3/2UVBhveqC8lP8xyvZONZTwU1sl42xO5cFmIjg2d5hoxZJgO9oWvnjZvpI7HJg4onOQLmyypRa2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBCYC8YvnS+0ZK1yvZC6mNRGERaCiYTrK8U7osgoSmQ=;
 b=Qw9ORb7ugkcDqjA5jlunJ24g6FP4MiW830v0tLyIcDdExtx2g9o49irDcoEYv5Au4ji7MgE3jTyu0uYOKLEORifAezXQb4sxkh3O/RafaEh/klSGMf3YUrI3K+RnCWNkfVsze6uwEZzCy+67JhZ9qScYku0F1Fn528ogzH834dddfu7acWgxKoHl3ZPXYyyzCNs6JrMHVCj+1k+p0KI8wP5JOkRjTOTjNl53YKELSkR4EUCjRaiJg0Y8w0/EE74nhKl7VWUFe054xuFXIbBZMmAXP7J3fNuFxMXTI9bBRCQK6jXHe0HnYfxiEjTpBCvlUBwvwvhoblFybNHaveXmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBCYC8YvnS+0ZK1yvZC6mNRGERaCiYTrK8U7osgoSmQ=;
 b=BLKWYZJlWoZIKoBdx/iyhF/S40HDjs2kiP9bIb9Zgoi33L4VWq779blb7eTiwiXWfZaSw0N6IcbsHNyPYjsI9Appxp8CR0vSXrQoQQOVnnG9al6q9FITqjiHRlopuajGOnFdAxoQYLIufQLgARissfsvVduOq66g6GFdclgyCJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR1201MB0202.namprd12.prod.outlook.com (2603:10b6:4:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 08:32:03 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 08:32:03 +0000
Message-ID: <122fa974-0150-f7dd-d3f7-ad3c12aca7f8@amd.com>
Date: Tue, 16 Nov 2021 14:01:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH Review 1/1] drm/amdgpu: fix smu not match warning
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, John.Clements@amd.com, Tao.Zhou1@amd.com,
 Evan.Quan@amd.com
References: <20211116080247.32143-1-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211116080247.32143-1-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::12) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:18::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Tue, 16 Nov 2021 08:31:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb0c4778-f2f1-470b-41a5-08d9a8db9091
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0202:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB020286B022A35B16F885091297999@DM5PR1201MB0202.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXd/LRwkvJGUOoRlDs2i1AgFCo0JVkzxtyVKvCLjEpq5BTS0t3q8I2mjCIqCYjXou6pWZkfpMVlO+N0I8Koi8sEmIHJ4oIJrTVUOlNp3I5omMBUl4iQBBdPmOHknnVLmCDVfd1O6/ra+hwax5O3o/YWqDTApAE8gAfumYxrYPsP3pv/tq5W2pA94mn96xNWgIxOLqY72DM7ajHRNf+1oITMttjNumyMRwj1Z5yW4vCWQD+gKc+inkBf1oLYXtI/72q6E3RoOrO5F9AVV7Kt9pMGRCAApxEM5OTRx0GEbmnPpUDilewSRolgOuc8Thugk09ZZVsFhKry/bqKNFS2XY3+sGwUWZ2mbiziITqGkdXCFn242PGSuNiHdAn+Mm8a7TCu37e1GfxtRZNYkAxSMYVBkWZPg84R90KpeS04qASYFWnGz23gcT2wGZZav7BBJjNpptZpPWVEkeZCbRmqHVyQKoIxtshLUUe5kjr5mQfKxefCzCLHfeBu0ie0755wh2YYXW/dwTFBGFONy3ZbYikDpwJeTRzT5MxJD195ex/UgFQppCKNu6nFimTLBzh3ZitQJtw7AyRY/AAaDDUUT/GigZKAEWMR4p3IOcNisYyVmsuahIgmlWtZ+4mgNd+keI3oQcuZc78/HdWhNu5IqhRzABCQtNz1QwbgftSJ0BIvclnxxWZCfZTjaGXZYo61cgLA/Kdu49M2aKmDsOlo8OyHuhGnxCi0+GEJIKzlcBMP+4ktTOvgThK8qGJLITaO3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(186003)(19627235002)(53546011)(2616005)(6636002)(31696002)(26005)(86362001)(38100700002)(6486002)(36756003)(5660300002)(6666004)(316002)(16576012)(2906002)(66556008)(508600001)(31686004)(8676002)(66476007)(8936002)(66946007)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWxZd1lXenNPZzNaRi9WQWpVS0YrZUN4b1l1OURheWFlWGVuaTQ3RXdyajBl?=
 =?utf-8?B?OHpKMTZBSWwxVkYyMzRGU3hwTGtnTE42eTNrc1JVWFJXRHgzeXd1azYrK21W?=
 =?utf-8?B?Q2g0akJPTUdqRSs2UDlEYW5mUVdEOUdUMGJsdk9ENU5nYUVYazVRcSs5SWhk?=
 =?utf-8?B?a0RRakRpclZ0bEFDOTJ5UHNraHdnT2o1R0FjN3lpWU8rWjNObWMzNkM1RHVT?=
 =?utf-8?B?U1FITzQwajNKTVpGejE3Sml3SlZFMEhOK1hNaEtpZ0dqaWdaMGZJWXdTcS9Q?=
 =?utf-8?B?RnhuaU52Z2xxQ3RRT09PMzFrclFWMFdJM3VTbm9ZY1lnVVlGbXUzQkp2djNl?=
 =?utf-8?B?L05BR0hJUzB0U2I3QURlc3RhbXo5SFhZaDhGeCtJdVBJSG51UUQ3dU9jRi9J?=
 =?utf-8?B?Z292ZnYxMnFZNUVNMEtRNEQ2Q0lJeURjVFJJTkQ0WGJ1UG9MeStzYVRXcGpz?=
 =?utf-8?B?RVd1RjVTeGo0L1dlWk55L1RvRHhhbWJIWlhsUUJTTGNaaEhwUGNXN29JV3Z4?=
 =?utf-8?B?UldnUWtnWC9KNmhKM0dFdFpSSW55WUhidFFYTW50bHlLNjMzTmRaNlpIMlJM?=
 =?utf-8?B?dkFabEZXR2lUdG1WSFpETGhKcDh3T1hyWVA0cnVvOGY2RTJyN1FrWG5PSWZX?=
 =?utf-8?B?NWFnK0R6eVVMbExkODB4dEJvaVdVek1CREtmdDNsVnV1TGFDbnRIejdXOE5H?=
 =?utf-8?B?R1c1NjdJZVlzODlqeDQydGpWVndPMGJXVy92cG9XeXl3YnFqSzFhLzRrU2ND?=
 =?utf-8?B?R2pEL2R3dEZ2MlIxVU5IL2Vyd1NXWGFhUEtRNTA0TTUveFB4aVpIcHQ3T1la?=
 =?utf-8?B?OHY0UlZVUW5QU0htZjRvOGx0ZVlseUtHRVVGa0NVbFdWeHpqQ3ZFenlnOHNO?=
 =?utf-8?B?RUlKRXVCU0orM2RCQWo2eXZPallTQW1oTkxZVFE2YWNpNWZRR1p6WUxidXh3?=
 =?utf-8?B?VUNIVEZvVmJjUDFwNEpQbWtZaXRpT29oTkN1WFovNWRDKzhKVnJtMzNPRkxB?=
 =?utf-8?B?NTQrVVl3Q2RZMDV2L1oxNFFqRVp3UlVKN09IWGVBUjdYSmVUWkRwYVc1cnBj?=
 =?utf-8?B?bFgzSElmZGhGZWw3R1JTWS9VYlNWVEpTV1RjOUZ5RnZqeWcvRWhkZnFzT0Ey?=
 =?utf-8?B?amtabDBLQlpKNHR2SnMvdmlEVmhyTmtIYWdLYUp5akFDcE1IMEpXOXhqTjZS?=
 =?utf-8?B?NFFVbzd2dG5HQ3V2eGRMbXg0ejdINEpsRmZBV3A0Q3BURHY0YVl2VUNSSlVI?=
 =?utf-8?B?VXJHWXZpWjFBUFB1aU5iOEtEVTVoTGhwemUvTmIyZjdxbG1RY0M4Z211YXZQ?=
 =?utf-8?B?b0oxQTZ4V1U5TTdVSHpvQTRvWXgyR09SQUN4Um9LWjd5bEFqUlhBN3YzS0lD?=
 =?utf-8?B?K2dyK1pmOEY5bTVZMXgwdjlsRTZIZlgzeTM4TUx5bEEzZ0JHdWlzQjU2empz?=
 =?utf-8?B?b2lXOUZTWUFnYXd1a1ZZMjhBeFNyVllNYjkwajZQRTVpV0s2NGJrM1haczdp?=
 =?utf-8?B?d0s2cWFINXFaRVBWMlkra29aVFoxYlpQYjR0UFZmV01KTzJOK1grNFIxSHNG?=
 =?utf-8?B?Q3BnZ0FxQlQ5VCtGakoxZWhaWExiellLVlNubk9RS3l3S25VTnJqNG5WZ0Ju?=
 =?utf-8?B?WEJoOEdqZHVLWWd1elZaaDFBV3R4VFJ2WEZPWHcrNXU5NDZlWmpUSjRSLzQr?=
 =?utf-8?B?aUlrK1REcVREa01nOHU1SkE2NVJmQThJRlU3UFgxaEduZWVPRnVXNFdpMHlK?=
 =?utf-8?B?S1MyRFh6bTZIdzJtdEM1Z1dpYnRTUVN1ZytORkZzOHdWaFhKN28wWnREWWNS?=
 =?utf-8?B?Zmk2WnA3dGNMMjUzVkxNcXg1Y2I1Y2VUTm43clYxcUZROGptRWxxM1Qxa0Zh?=
 =?utf-8?B?MnpaeFErUUwwK1NhZ1M5VkJ5bXlndGYzZE5MQS9oUThVVXpuYUdlS0trUTUx?=
 =?utf-8?B?bGszZURuUE1JWGE2eDE3TDNmbkpuVW42bitzdXVTM09wY0ZNd3o4L01rc0JT?=
 =?utf-8?B?S2wwKytmOFpBZUZJdGhCUityR0tvc25CYlBnUHpXVUFtTnAwTHIyeUI4RU9I?=
 =?utf-8?B?VElsMEIrcDFndjhRU3NYTmFzcnV1T3BxTXZpZXF5VDJUWVdYakNmOWdyVnZh?=
 =?utf-8?Q?QTZY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0c4778-f2f1-470b-41a5-08d9a8db9091
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 08:32:02.9976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGUhM7cpJlWKkpMQG15kOXEDkkqoNr88rFrgoSFgt6lfBvEHHbrWY9ai/GJHbd1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0202
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



On 11/16/2021 1:32 PM, Stanley.Yang wrote:
> update smu driver if and version to avoid mismatch log
> 
> v2:
>      update smu driver interface

A version mismatch can still happen with an older FW. I think it's 
better to change the patch subject also as - "Update smu driver 
interface for aldebaran" and provide the version number in comments.

With that changed,
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> 
> Change-Id: I97f2bc4ed9a9cba313b744e2ff6812c90b244935
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   .../drm/amd/pm/inc/smu13_driver_if_aldebaran.h | 18 +++++++++++++++++-
>   drivers/gpu/drm/amd/pm/inc/smu_v13_0.h         |  2 +-
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
> index a017983ff1fa..0f67c56c2863 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
> @@ -140,6 +140,8 @@
>   
>   #define MAX_SW_I2C_COMMANDS                24
>   
> +#define ALDEBARAN_UMC_CHANNEL_NUM    32
> +
>   typedef enum {
>     I2C_CONTROLLER_PORT_0, //CKSVII2C0
>     I2C_CONTROLLER_PORT_1, //CKSVII2C1
> @@ -507,6 +509,19 @@ typedef struct {
>     uint32_t MmHubPadding[8]; // SMU internal use
>   } AvfsDebugTable_t;
>   
> +typedef struct {
> +	uint64_t mca_umc_status;
> +	uint64_t mca_umc_addr;
> +	uint16_t ce_count_lo_chip;
> +	uint16_t ce_count_hi_chip;
> +
> +	uint32_t eccPadding;
> +} EccInfo_t;
> +
> +typedef struct {
> +	EccInfo_t  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
> +} EccInfoTable_t;
> +
>   // These defines are used with the following messages:
>   // SMC_MSG_TransferTableDram2Smu
>   // SMC_MSG_TransferTableSmu2Dram
> @@ -517,6 +532,7 @@ typedef struct {
>   #define TABLE_SMU_METRICS             4
>   #define TABLE_DRIVER_SMU_CONFIG       5
>   #define TABLE_I2C_COMMANDS            6
> -#define TABLE_COUNT                   7
> +#define TABLE_ECCINFO                 7
> +#define TABLE_COUNT                   8
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> index e5d3b0d1a032..2e35885c7287 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> @@ -27,7 +27,7 @@
>   
>   #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
>   #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
> -#define SMU13_DRIVER_IF_VERSION_ALDE 0x07
> +#define SMU13_DRIVER_IF_VERSION_ALDE 0x08
>   
>   /* MP Apertures */
>   #define MP0_Public			0x03800000
> 
