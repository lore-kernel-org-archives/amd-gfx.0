Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E770C0015E
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Aug 2023 17:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A089B10E0A6;
	Sat, 12 Aug 2023 17:17:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EAA10E0A6
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 17:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FclNDnbzzzxj6VuobneOOJ0g311VZ6OgdtQTug2jtx54eiBcrt+pDtMZUH6G8fpzKSius2QST3tb9O0kezDJCZ5+y2FweBd0B5xN9h32NDopty8pRGfeqSj9/nt6wm5BIzM3V0m3NxdCogJr8jThGvESwWSD0FCqr20IlE5wdbhGZSAYi0O53rEP86NpVjCP5Ty7AVHfSdAMjlNv0wzYjdCP9qjGDIBEGXRxK1JcpZNh4nNSxTO1MJmafq29VpZPT0aBcvtqFdnFUaQ1aLP3JXzfVSk8TubsKhyKSfOnTFP44yA9EApFZzptGUfjioKq2kp+9617EUBZz/f56bgPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/QaJppL+JU+YN6vZK2uZ2rBa/pmBOR9X4S7wh8g2hg=;
 b=DudRud/KlA9w05N2g6+HqUpREJAyFai0JRVTeF1Y1Xn7m8ePR/EhLwUXLY3sTg6Wcdkw7sSI34C6QPms367Nvonf8TBXXm0tW6JW8BKSnqosHvd4Xi4nkz2jnEogz5cmwsYdAonVIjmbJ4YmvSCWvksvGCSQsgScxqL6UrOm7HK7BZrhlLHmv6FnSmPxWAllWJh1wUtluLpQFgu9nROghJz2wOyFcN66Tz+j8KOXqGUraYeFJT/fKzrzhX/9ktjSYwFnBVcz2E8y9OcIcEBhZPW8DSuwcAUea9tvsFJczFnFFn5GDH+mqOG0y7gSKKFKtxZeype6e9WqOrLXAj4mqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/QaJppL+JU+YN6vZK2uZ2rBa/pmBOR9X4S7wh8g2hg=;
 b=pC5uErJcJrxtvHyhDXJHqCo+RLte2y5X1u05HDwlcG9o8JKbuDofkfw8z1Q7bIKRrvkzTRHOwbWltpF6Hgu1ifrxAKjD2R6IV7A3sQdDz/bbK7dxfO+J1Xw7iaSH9H78ALh/ev5faKOCJeLfOLO+JtpY7l4l09hFjd/glcMoB7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Sat, 12 Aug
 2023 17:17:12 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%4]) with mapi id 15.20.6678.020; Sat, 12 Aug 2023
 17:17:12 +0000
Message-ID: <63968a2b-c3f2-0337-3e5f-d4a73df7117c@amd.com>
Date: Sat, 12 Aug 2023 22:47:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/2] drm/amd/pm: Update pci link speed and speed format
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230812103342.1091608-1-asad.kamal@amd.com>
 <20230812103342.1091608-2-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230812103342.1091608-2-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: e56586ff-7fdf-4611-a151-08db9b57f79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlTqHYjLLd1zkhBjkOnpYfS8My74p+6DIvmtwCXY4Hq+B1VE2ZzwnrZ4WsO8y+kpGaNF9fYgORb3BZuNY1sO6r4u4JD/BC0liPod//ocrUEaj+YqHXSBDh3yepAp/sQ/nlg+9gUA8s12JoAEctvnah/DWRO5+Tl7WBufGEcoMZhWexigR2UH+d+FhmX2yLEbGHfWIqsg2Eub3B8QFYWcTVLTNfKa3RC1jH3XAo9V0QaDvh1b0v3IrhF8YB94ke3IcwlWV7KLcJ190T+RNvRT1gOHoaGUDyADMwd9pHwNBO0j2FGmnNs8sIAv5tg7Ypha7aj970ndnkxdoTLcmZcJUkA4/etJrbTbIXy2I3+vwc07EfCRj6xBJpc/PZls8E/d0j3OpcHdpzDs+sQgRoaWL1q1A9UPZG79N3mGqOxYLkOqEt53+g+mkEJ6pbE8TZwouGdgp1oY8DA4ZWBFBmBRr3bZDVTSUTny0pKjoTXBQ22+RvXcvG1cqx5xnHsB0LFnE2pSGYP4Doj9dNrFZdFjUN7QAtf+DrMp1RMcrcAhqXpC0rQXW8uoIj2P1YTs/LBQBVcI+tkOOkhKKgPfjbt38EwcGTv0X6tjkZXNaWGyuj9kn5sHONUmaXuC09JWFiVfTPVATGJ6M1+rqlFYAJzS8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(186006)(1800799006)(451199021)(53546011)(6512007)(2616005)(83380400001)(26005)(5660300002)(41300700001)(15650500001)(2906002)(66476007)(66556008)(66946007)(316002)(6506007)(4326008)(478600001)(6666004)(6486002)(8676002)(8936002)(36756003)(86362001)(31696002)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkNCKzVvLzJrTlZGNDBSVzZ5ZUNWa2g4Z3p1QjVqUE9LWjhvWkJDbUJyL2hr?=
 =?utf-8?B?MFkyMm42M0svellvTTlCQVRBaExJZjh0NDJzTGYzV1YxK3hZSlNjYllLZmh1?=
 =?utf-8?B?S2krYWUrQko5UkFRVDF4NG5QSE5GNTIxSmVrc0tYaUx3Q3FEVEFyVlRObGp3?=
 =?utf-8?B?NCtKQ2czTFhXN1BQb1EvTEltdnpxRkQxNFNBb01yd0IyaEo1dFhmclUzc05X?=
 =?utf-8?B?Z2hTSnJLb0hEY3BHTzZRTXJNajkvTGVIUHBZRnhXbHRiMVlvTGYzd3ljYnNy?=
 =?utf-8?B?aG9IU3ZjYUdBdkRFY2VERlp2R1ZrbERmbkpnS3loVVYrOFpKVzJzWWY4cEZ3?=
 =?utf-8?B?VDhJdTE5eG5XU0FTenh2dmp2T0E4RDlXa3VaMzVsVWp2d3ZDYXcrSElWUW5M?=
 =?utf-8?B?MHRhWmcyRC9UaG9LRkZzb0MzUWJPOW92WTFzT0k5S01kbldMN1l1R0ZDOGVk?=
 =?utf-8?B?dXdlOFZQcldaY1puYUx1UXE3M3ZKajVOdytzcm1UcWlxWGJXOWdacGVJVUNx?=
 =?utf-8?B?R1YxdzNvckpub1VmdmdHUzNqNnhZdjlYV1M5bVZSMjMzV2h4eWwyQ3JKdS9D?=
 =?utf-8?B?dDc0YzlCZUNlZWZXNlRHQy9WbkRCbDVPcW1aUE0yMjZ4VXp4L05DNWsyQUN6?=
 =?utf-8?B?OUJGbEcwRDZ5c0FMR2NNMVM5QmhHbzA1cVNpV1R5RXlBMGR1UVJhMm5CV2Rm?=
 =?utf-8?B?Y1NwenFZbTlPaGUyeVpTU1hlUjIrY2dYSDhnR2FDVzNHOVZCU0NOdmwyeDA5?=
 =?utf-8?B?MkpXMEtFdm80MExjM2dtQmtaNHdTemZKMStuRGtJcWxORzBNT2NwdWljM1l6?=
 =?utf-8?B?ZnBuWDNFMWl5SlNiV0pqYTNIQ3AwT0VRM00zcnh3dmE5NTFhZ3ptQmkyRlBw?=
 =?utf-8?B?dURDNG5yRUJoSDIrL1BadWJZYTNaQS84MkxmUGtmdytEaXNCbzFuWEdlTVdy?=
 =?utf-8?B?dSthU0h1cjVQMTVTdzllcmhma3YyaW1XVitTL3puT1VkZU9RN2NOYnp6UTBT?=
 =?utf-8?B?WHRLYzhvNnNydmFxYkJoWTV5Ty9yaXB1M0Z6YzhNdDVXKzF4SWt1Z1ZlaEdE?=
 =?utf-8?B?NDg0VnpZbjBtNEd6UFl2Y1AzakJCNzNDUHZtV0g3YzEzTktFb1laWThOTHNO?=
 =?utf-8?B?blRRbWRQd1VpNjNvbUtnQzhSZ3E1eE1sWlUrWGZ6K09xeFF3dDdoM084cTRZ?=
 =?utf-8?B?bHNqdm1tL0ZiSm45ZUc2R2lsMHJXN3JRVE5Mc3RoaWlPZDNhYk1qbGovUTFM?=
 =?utf-8?B?TUZzempXSGpVcXZuT1d2NVYzY1lMYm5SUzhFQmVMbE5YTUlKMWRoRy85bmRT?=
 =?utf-8?B?K1ExcmFyZU5JOGVHaXdXL1VPRTY0cFk0Q3RUUWQ3MVdLVjRjL01ncFhXVHpN?=
 =?utf-8?B?ckcrRUtnM0JlMDA0bTUxNUlUemJzSUlhTld6VzRzeTJsei9SbURXOGRKS2dr?=
 =?utf-8?B?bjZNanB4M3E1eEtUc2RpeGJsV2pndlM4NDM3b0JwYnF1dldHSmtYMGpPVzFk?=
 =?utf-8?B?UDNaaGVML1gvNmlMZFo2VFdPTXFvUUd4OTVPV2NpUTdrYjRjVmhqZHREOWdO?=
 =?utf-8?B?RSt5KzNyV0k0UFlYWnBZUjFyUmRyeTN4ZlBQZUFtdVFZSDRldUdSODcrSVc4?=
 =?utf-8?B?WUN3bXJGdFJ1VEUvbk5NN0trRUZFeDhzUmJPNTBsdzdUYUtIbHdXbVhEU284?=
 =?utf-8?B?Qnc0TVZSRFUyemZnK2JwREF3azJUcWFCTUVQZ3IrMmJ5eW1kN2VlRk9pU1M2?=
 =?utf-8?B?elFOdzhwc2dGSUU3SU9Ld2hENmluYUlKZGVvb3RnNUwyWFAza1I1MlQ5V2hi?=
 =?utf-8?B?TlRhd24xeDkxNS95TXNvampKeFo0UGlHYTFUZ3ljQ3M3eGIra0doejVib3Ji?=
 =?utf-8?B?eUZvMjhJNTRjc2poT0o2YVVDZ09KZXZqL0lqaDRRQWZSREU0U2U5bURBK3Av?=
 =?utf-8?B?cWVIQkdIR3drTDVoemRIREtkYkRDazhuU1lYRVdIRVZCNCtXaE1CMTJjcVQv?=
 =?utf-8?B?THViV3NENGxOenpEN05nYkE2SjdYbUZmV3J3SmRpdlVYeWRSekloN2s4LzFU?=
 =?utf-8?B?RVM5UnFJeW52czBzQkRDVHNmM0NYK3J5UGQvQi9wWWtnY013MFN6RHQ5TXpK?=
 =?utf-8?Q?/+AJorooaUc4stRDe9v3EMdo2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56586ff-7fdf-4611-a151-08db9b57f79e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 17:17:12.5187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjDVEoz/EHKZG06Gut3sDRGup7K5OHil2Nqt3bHJhUKE7irzJ4IQxbkBai+z7SLB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
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
Cc: le.ma@amd.com, shiwu.zhang@amd.com, maisam.arif@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/12/2023 4:03 PM, Asad Kamal wrote:
> 1) Update pcie link speed for smu v13_0_6 from correct register
> 
> 2) Populate gpu metric table with pcie link speed rather than
>     gen for smu v13_0_0, smu v13_0_6 & smu v13_0_7
> 
> v2:
> Update ESM register address
> Used macro to convert pcie gen to speed
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h     |  2 ++
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c   |  1 -
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |  7 ++++++-
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 16 ++++++++++++++--
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c |  7 ++++++-
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c           |  2 ++
>   6 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index 355c156d871a..3a03f84d3288 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -52,7 +52,9 @@
>   #define CTF_OFFSET_MEM			5
>   
>   #define SMU_13_VCLK_SHIFT		16
> +#define pci_gen_to_speed(gen)		((gen <= 0) ? link_speed[0] : link_speed[gen - 1])

Rename from 'pci_' to 'pcie_', it's only converting PCI express 
generation. Also, move this to smu_cmn.h and keep a comment like convert 
from Gen1/2/3 to 'X speed units'.

Other than that, the series is -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
	
>   
> +extern const int link_speed[];
>   extern const int pmfw_decoded_link_speed[5];
>   extern const int pmfw_decoded_link_width[7];
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 895cda8e6934..6863186937f7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -83,7 +83,6 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
>   #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
>   
>   static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
> -static const int link_speed[] = {25, 50, 80, 160};
>   
>   const int pmfw_decoded_link_speed[5] = {1, 2, 3, 4, 5};
>   const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index fddcd834bcec..164fbfbc70fb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -96,6 +96,8 @@
>    */
>   #define SUPPORT_ECCTABLE_SMU_13_0_10_VERSION 0x00502200
>   
> +#define LINK_SPEED_MAX                          3
> +
>   static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
>   	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
> @@ -1761,7 +1763,10 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->current_fan_speed = metrics->AvgFanRpm;
>   
>   	gpu_metrics->pcie_link_width = metrics->PcieWidth;
> -	gpu_metrics->pcie_link_speed = metrics->PcieRate;
> +	if ((metrics->PcieRate - 1) > LINK_SPEED_MAX)
> +		gpu_metrics->pcie_link_speed = pci_gen_to_speed(1);
> +	else
> +		gpu_metrics->pcie_link_speed = pci_gen_to_speed(metrics->PcieRate);
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 2572dc210739..a8e90a1e6ed9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -80,12 +80,17 @@
>   /* possible frequency drift (1Mhz) */
>   #define EPSILON 1
>   
> -#define smnPCIE_ESM_CTRL 0x193D0
> +#define smnPCIE_ESM_CTRL 0x93D0
>   #define smnPCIE_LC_LINK_WIDTH_CNTL 0x1a340288
>   #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
>   #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
>   #define MAX_LINK_WIDTH 6
>   
> +#define smnPCIE_LC_SPEED_CNTL                   0x1a340290
> +#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xE0
> +#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
> +#define LINK_SPEED_MAX				4
> +
>   static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
>   	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
> @@ -1923,6 +1928,7 @@ smu_v13_0_6_get_current_pcie_link_width_level(struct smu_context *smu)
>   static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> +	uint32_t speed_level;
>   	uint32_t esm_ctrl;
>   
>   	/* TODO: confirm this on real target */
> @@ -1930,7 +1936,13 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>   	if ((esm_ctrl >> 15) & 0x1FFFF)
>   		return (((esm_ctrl >> 8) & 0x3F) + 128);
>   
> -	return smu_v13_0_get_current_pcie_link_speed(smu);
> +	speed_level = (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
> +		PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
> +		>> PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
> +	if (speed_level > LINK_SPEED_MAX)
> +		speed_level = 0;
> +
> +	return pci_gen_to_speed(speed_level + 1);
>   }
>   
>   static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index b43c5d13f8d9..915e57d3afa3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -72,6 +72,8 @@
>   
>   #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
>   
> +#define LINK_SPEED_MAX                          3
> +
>   static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
>   	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
> @@ -1741,7 +1743,10 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->current_fan_speed = metrics->AvgFanRpm;
>   
>   	gpu_metrics->pcie_link_width = metrics->PcieWidth;
> -	gpu_metrics->pcie_link_speed = metrics->PcieRate;
> +	if ((metrics->PcieRate - 1) > LINK_SPEED_MAX)
> +		gpu_metrics->pcie_link_speed = pci_gen_to_speed(1);
> +	else
> +		gpu_metrics->pcie_link_speed = pci_gen_to_speed(metrics->PcieRate);
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 442d267088bc..c1d377e58b3e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -39,6 +39,8 @@
>   
>   #define MP1_C2PMSG_90__CONTENT_MASK                                                                    0xFFFFFFFFL
>   
> +const int link_speed[] = {25, 50, 80, 160, 320};
> +
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(type)	#type
>   static const char * const __smu_message_names[] = {
