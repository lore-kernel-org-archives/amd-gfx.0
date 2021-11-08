Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F39C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 22:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA641604D7
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 22:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA641604D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C156E12E;
	Mon,  8 Nov 2021 22:29:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFEA6E12E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 22:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9fVeuAA61QS7FEyMItxFwWtdw59MIFDQcknrc3mlrEzWc6YBBSy6MiCej5yIGnSA0WP4d4P/ERnvEVpaGPsqtxuTXCXNcthsJMnVPetEkkAIVr6ulzqtGHXU+ib0bPv4JI+cfe2vP2Xd+TkiFG62VfxAwVhSGTsl09jEhyuYr6XqRsynJun05oGdIs4O0e4CS2XiQdZXCJmXr1kxugiCU9yqaKpZTOWCVINegRkuNYs26wVN/SEm2/ABJ9khgXCgIOr9vP0Rz1Oe51SNV+zSruQ/m4vVAucdBuQNfldmjf19RNa6pEoJCTTc2LHXMBHoQ30++e06ranckLW/GgHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IBcpqhGvtUoTEwU4k8svh9L0W0A0Fujv5sHq8wVLkA=;
 b=Usz96f7PeRcNs75vLg/dv7XxV7SJ3y2JY4FYkcStdgf0QRNh21KjjQ7sILgehkVDOzQUyTJ2GBALDVHqSufiisxc7mxB5XrvNhlaxoKqKypQ8wC8k6sAe08L80OVR4TBpKlC6mvplqmUkcKGhD4cjQk7dWFOJou2rs12ZklO6mqZumAdI3pgQ5slOCCXc1ySt5T5yhZZSZNl5hlQtiB18CcmmrlHEbRGJaSRe1hqEWUVbvPracplTKfVU0WpfExnBMZn/nxhKSm9ed1ISXDsyNxWIrQ4YkD0NvClU1NCsLTuXk4juKE7PFK3kGx9BYrc1Zu5cy5rio3BoxUwGh6HaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IBcpqhGvtUoTEwU4k8svh9L0W0A0Fujv5sHq8wVLkA=;
 b=ji7ccl96ZRNfbNFHW7y3nKR6PaHaPjRHqJhJL9/r3EIvVtSiYTHbS1RF3IWW7bmddwepqe1U6hc/Nf3h2FONjKvua5yDkvB9q4I6N6ltfLEhus5D/ZqfmREmkSfJ7HjwXwUPrVUasnYpYSWJ1wJPsWPsfr/9TG/TUL2GBMvJhVE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Mon, 8 Nov
 2021 22:29:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5174:fe56:1dec:1342]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5174:fe56:1dec:1342%9]) with mapi id 15.20.4669.015; Mon, 8 Nov 2021
 22:29:15 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: convert to IP-based version checking
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211105195805.2275921-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ea90a118-57c4-e903-417d-733992cdca5c@amd.com>
Date: Mon, 8 Nov 2021 17:29:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211105195805.2275921-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 22:29:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a08909b-f325-4c34-3fb0-08d9a3073236
X-MS-TrafficTypeDiagnostic: BN9PR12MB5097:
X-Microsoft-Antispam-PRVS: <BN9PR12MB50976937F06E10BD7ADB0AEF92919@BN9PR12MB5097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ObAq12r7uSBiBRk9Q87o81TaHb8Z6SyVVCDuXwz+agXFsL5yqGJE85MVrRNolCHaswZ6ZA27fp1sgOKiVJTFg2OZNpKWGqf1q7NAODxjSLtl9OK/bBwr+rwByAwhStgIUPDw3uXso3JkQjL++B99RoGmHt+tGFtuo9zo+VLARZwKUMjSfgQdLY97tAbqsrI4buxmNJCeBBTmSC/VojzE5j3d/4W5hXaL+UoNboRXlxSR1B5TnIsoMsa3476jNpSNuzEK44qOSgLt6Gk5oO7IdiWCj0PaVcy5JhDMPVIplqVWzlS38y2CQ3pcy+tVIGyp7f45aDfm72on0xmZ2usqxCGEFHY81ndCtyT5uLuJ7A6rqKWJmcad5pObZZIXNaNeTfeRbgp0NSvidhkGrWsYaC83CZftS2wJRQnMa+kcJifuw+fEAZRgbzk10Xj8vmXjP/ApqcsT3UVrA9V9wI4VC3KFpbDd6vRAcMa0bIjKgnwzX4xZxXxCzVi97Yjp7rcir6MbIfT6JzNYHHKM9fShSUGDrfWV1UPGlJYSS4JIBu+fqNHNq6YCx1szTiy6V2XmHu8IixkDheGgaTtWzglLuzvS8Ep/BEUR9XZe/YXASCCOis457cJe/7gJs/zTSuHc8Zn8eT6JsZRitrl3W0e6Tgye29/+dBRrKjpm50ettIVslregk9Ey/ybbzs26W1OrJfpQjQQXQSFWVnTm+HWHqqHESx7pLhrLwRe6u9oAvvzJ+11qilAxhfKRyio+i8Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(956004)(83380400001)(316002)(16576012)(2616005)(66556008)(38100700002)(26005)(186003)(6486002)(8676002)(31696002)(4326008)(8936002)(5660300002)(66946007)(508600001)(2906002)(86362001)(36756003)(31686004)(30864003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3l5bFR5S0l3VzRqKy9EUUw1WU4yMU9maG9Gd25OOU1ZbzdBUllUaVovNDk0?=
 =?utf-8?B?czBOSGpkTzhnRk94dGVsT3g3ZjBhaVlvYUlHVzBySEdXd1J2NHhldHg2Y0NG?=
 =?utf-8?B?eGw0N1VyRTdNQVdETVBidGQ3RlBBekhYNXdUSUdteGgwSGFvVmZVT2pXbnB3?=
 =?utf-8?B?cVFPdGJ4WWp5R3ZSRnJnczdrQmRQRzQwdFhSL1FldVJ1OGYrUms2RkpFTWRl?=
 =?utf-8?B?QnU0djRsOU5uRHo0eW9Cc1pwTGZaQS94MDVHK0JFeVNtRFVHMEY3TkRyWCtw?=
 =?utf-8?B?RDhlWkZrQ2Ird0YwSEVRcGJ3SE1uTmVLdmMra1JEN1JkelhlZnlmZ1pXeUlH?=
 =?utf-8?B?WjJEbE45SXhqZzlldmpWb0h2bksvcklMS0xxSnlLVlJJQ3pqeVhlYjMxa3p1?=
 =?utf-8?B?b1E3dDJ0ak1UTmFwQkxhQnZBWk9GdGlhNVA1Uk1FQXZRUzFWMjcxcldSeHJ1?=
 =?utf-8?B?QkRxOGJsTGo2b0VMNjB3QkxYUkxEMVczMjJWMHB6ZlRGUHZQbkd5ZWY1ZHhu?=
 =?utf-8?B?aWg2dktFYnRTWlhteGVkOWFiWUdJcS9icGFrVHRCZmtkUEtCeGpzdXhhRmlo?=
 =?utf-8?B?QzJ5V29XRUdQV1VTejd6Q3pMMlg4U3lkZTJZOWpZbzNQeGtJTUJlb1JjZGJC?=
 =?utf-8?B?K1dzL2JTRmJFM2E3THhKZFdycWxPOFkvY2VWcHI2Y2I4UnExTDNGQ0E0MEVm?=
 =?utf-8?B?anE4MlZTek5jMUozU3pXNi9UYng5bUNmbEhHeEN4eFk4Rjg3S2VUWWxDOGgw?=
 =?utf-8?B?d3ZkV2VCSlZNNERaMXdvRUQ4MWhGTGNjaGIrVjgrM1JBR3p1byswSUxNeCtT?=
 =?utf-8?B?Mit1dU9TUk5TOHY4Y05MMnJTVXF4bmFsN0FSUDFlNThDOE1tK1kvYWpoQkJJ?=
 =?utf-8?B?QTlBTUk3TDgzZktUa3FGbys3M0Q5b2ZWL29RYnQ0MlpaY2JTbHUzN0dOYWMy?=
 =?utf-8?B?VUw2Q0FPUGFEVXBtRS8rS2ZaWkZHUEhOYlVDaDZXdzl0bC9uYk5ZLzJrNjkx?=
 =?utf-8?B?YWZuZU56RGxOUzRzT3hDMVBhTFJ2S3ZPTFJ0YUpKcDhpSXc3UW1TZVVMQTVV?=
 =?utf-8?B?c2ttVWRUZU5GUFQzSTZ6M2ttb29BV1UxWGFIbjhRSlA4SWt1TW96bzBiblAy?=
 =?utf-8?B?NFVqV1BQdG42ejdFUmNvTHA2ak5Ud0VaN2tYZ3o5UU9VV2F3eGlxZXdtMzBG?=
 =?utf-8?B?UWtLOFh5Y0R1emNPVjRmc2NWSFVLY0lKb0MvR2U2YXhCWEFydUNXaC9CUzdy?=
 =?utf-8?B?SDM1NHZ5ZEx5WUI3NEdVT3lWZGV3N0tFK0YyeWFSNWpSdnJjNFBxNjFaWVNX?=
 =?utf-8?B?VllrbGpzdzJWWDdpYk5YUk1CWDQzSGt2N0ZueGtHdVhZSUxUYUovR1hqVlFF?=
 =?utf-8?B?Uzlpd3Z2NVp6cC92QXF0cVJ3bW5ZaFlIZnVRZ0hiZ1VaZ1QwOFUyTGFNYmlp?=
 =?utf-8?B?WjZpb2p1QnJYSEkzZ1IyRUhjM0NLMXhxNnVaY0lEYXdSYnltYkJjYUpoMzJK?=
 =?utf-8?B?VUJsRm9qQ2d0OUoyS1ZEdEdHd3RIYkdCNHJHYWhnUmtDcmFYUWwvS3U5M3Ni?=
 =?utf-8?B?VkZiZUhDR3ZDVzhwdmxXYTJDZ2pacE1MSVA3enM1OStwZmNBZjd6M21uNldF?=
 =?utf-8?B?ZU9lZGF6SE9lVTMyN1g2Q2Q1OUZjOXFOK0VDRXBiRHF2eUV0N1h6eDlKYWIr?=
 =?utf-8?B?UEp2SE9NMW1XZjR2bWIxYjZRTnhlaVUrVU4zb29mMmh3a0ZWUWU5MURnMlJ0?=
 =?utf-8?B?RVFURGUxWnlneWp5eUllUkZnY3JybXdaaGJXbXZGcnNBVjF5a1JNdi95T3pO?=
 =?utf-8?B?UzA3Mm9HcTN3cEM5M3oxTFk5ZHNnOU9jM1dZTTUvM2I3K01xNTVrSjV6Z2RK?=
 =?utf-8?B?MzVrSHFlZitjVVhNRmplQ0dCaGJvTG9IZjA3dUNRUkVKaWZ0WS9jeFVvb01P?=
 =?utf-8?B?WGFrdUtOaC80NEk1cGZZZEt5dnFKSXlkdHN1dXVYSmVUeVhJbHl3aGRQT0Fi?=
 =?utf-8?B?WXpXNXl0Y0NmZHVGM1dVY1JXV3l2NVkrMGUvRnhaazkybHRmdDhUZ1NiUXVy?=
 =?utf-8?B?S3A4alRmdW5sVTZNS0prNEpwNzdaK2NGZFZJVWFiQXlBaTB0OWtxaXkzU3l4?=
 =?utf-8?B?MUQ3MklPN00vQXFkdFhEZmlEVi8vbGdINUNobUVhanVaamg0QmZtVTV0Y2pG?=
 =?utf-8?Q?1N1krQCe3o9sAgYKFGXXd3o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a08909b-f325-4c34-3fb0-08d9a3073236
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 22:29:15.3424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QakqzvS+z7fhLIEyVJ/aAWr1AZClerQKlprWZdiMA0CfMu5imRaL/G+0++Z3pa/k++D1Ri+8L6B1Jo4pr+Zl9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
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
Cc: Harish.Kasiviswanathan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2021-11-05 um 3:58 p.m. schrieb Graham Sider:
> Patches to change KFD to use IP versions rather than asic_type.
> Converting IP version checking in main switch statements.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 124 +++++++++---------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  56 ++++----
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  52 ++++----
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  56 ++++----
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  54 ++++----
>  5 files changed, 189 insertions(+), 153 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 1dc6cb7446e0..500bc7e40309 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1377,67 +1377,71 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>  		pcache_info = vegam_cache_info;
>  		num_of_cache_types = ARRAY_SIZE(vegam_cache_info);
>  		break;
> -	case CHIP_VEGA10:
> -		pcache_info = vega10_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
> -		break;
> -	case CHIP_VEGA12:
> -		pcache_info = vega12_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(vega12_cache_info);
> -		break;
> -	case CHIP_VEGA20:
> -	case CHIP_ARCTURUS:
> -		pcache_info = vega20_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
> -		break;
> -	case CHIP_ALDEBARAN:
> -		pcache_info = aldebaran_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
> -		break;
> -	case CHIP_RAVEN:
> -		pcache_info = raven_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(raven_cache_info);
> -		break;
> -	case CHIP_RENOIR:
> -		pcache_info = renoir_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(renoir_cache_info);
> -		break;
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI12:
> -	case CHIP_CYAN_SKILLFISH:
> -		pcache_info = navi10_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
> -		break;
> -	case CHIP_NAVI14:
> -		pcache_info = navi14_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(navi14_cache_info);
> -		break;
> -	case CHIP_SIENNA_CICHLID:
> -		pcache_info = sienna_cichlid_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(sienna_cichlid_cache_info);
> -		break;
> -	case CHIP_NAVY_FLOUNDER:
> -		pcache_info = navy_flounder_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(navy_flounder_cache_info);
> -		break;
> -	case CHIP_DIMGREY_CAVEFISH:
> -		pcache_info = dimgrey_cavefish_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(dimgrey_cavefish_cache_info);
> -		break;
> -	case CHIP_VANGOGH:
> -		pcache_info = vangogh_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(vangogh_cache_info);
> -		break;
> -	case CHIP_BEIGE_GOBY:
> -		pcache_info = beige_goby_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
> -		break;
> -	case CHIP_YELLOW_CARP:
> -		pcache_info = yellow_carp_cache_info;
> -		num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
> -		break;
>  	default:
> -		return -EINVAL;
> +		switch(kdev->adev->ip_versions[GC_HWIP][0]) {
> +		case IP_VERSION(9, 0, 1):
> +			pcache_info = vega10_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
> +			break;
> +		case IP_VERSION(9, 2, 1):
> +			pcache_info = vega12_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(vega12_cache_info);
> +			break;
> +		case IP_VERSION(9, 4, 0):
> +		case IP_VERSION(9, 4, 1):
> +			pcache_info = vega20_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
> +			break;
> +		case IP_VERSION(9, 4, 2):
> +			pcache_info = aldebaran_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
> +			break;
> +		case IP_VERSION(9, 1, 0):
> +		case IP_VERSION(9, 2, 2):
> +			pcache_info = raven_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(raven_cache_info);
> +			break;
> +		case IP_VERSION(9, 3, 0):
> +			pcache_info = renoir_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(renoir_cache_info);
> +			break;
> +		case IP_VERSION(10, 1, 10):
> +		case IP_VERSION(10, 1, 2):
> +		case IP_VERSION(10, 1, 3):
> +			pcache_info = navi10_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
> +			break;
> +		case IP_VERSION(10, 1, 1):
> +			pcache_info = navi14_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(navi14_cache_info);
> +			break;
> +		case IP_VERSION(10, 3, 0):
> +			pcache_info = sienna_cichlid_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(sienna_cichlid_cache_info);
> +			break;
> +		case IP_VERSION(10, 3, 2):
> +			pcache_info = navy_flounder_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(navy_flounder_cache_info);
> +			break;
> +		case IP_VERSION(10, 3, 4):
> +			pcache_info = dimgrey_cavefish_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(dimgrey_cavefish_cache_info);
> +			break;
> +		case IP_VERSION(10, 3, 1):
> +			pcache_info = vangogh_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(vangogh_cache_info);
> +			break;
> +		case IP_VERSION(10, 3, 5):
> +			pcache_info = beige_goby_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
> +			break;
> +		case IP_VERSION(10, 3, 3):
> +			pcache_info = yellow_carp_cache_info;
> +			num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>  	}
>  
>  	*size_filled = 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0a60317509c8..8a39494fa093 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1947,31 +1947,39 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
>  		device_queue_manager_init_vi_tonga(&dqm->asic_ops);
>  		break;
>  
> -	case CHIP_VEGA10:
> -	case CHIP_VEGA12:
> -	case CHIP_VEGA20:
> -	case CHIP_RAVEN:
> -	case CHIP_RENOIR:
> -	case CHIP_ARCTURUS:
> -	case CHIP_ALDEBARAN:
> -		device_queue_manager_init_v9(&dqm->asic_ops);
> -		break;
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI12:
> -	case CHIP_NAVI14:
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_VANGOGH:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_BEIGE_GOBY:
> -	case CHIP_YELLOW_CARP:
> -	case CHIP_CYAN_SKILLFISH:
> -		device_queue_manager_init_v10_navi10(&dqm->asic_ops);
> -		break;
>  	default:
> -		WARN(1, "Unexpected ASIC family %u",
> -		     dev->device_info->asic_family);
> -		goto out_free;
> +		switch (dev->adev->ip_versions[GC_HWIP][0]) {
> +		case IP_VERSION(9, 0, 1):
> +		case IP_VERSION(9, 2, 1):
> +		case IP_VERSION(9, 4, 0):
> +		case IP_VERSION(9, 1, 0):
> +		case IP_VERSION(9, 2, 2):
> +		case IP_VERSION(9, 3, 0):
> +		case IP_VERSION(9, 4, 1):
> +		case IP_VERSION(9, 4, 2):
> +			device_queue_manager_init_v9(&dqm->asic_ops);
> +			break;
> +		case IP_VERSION(10, 1, 10):
> +		case IP_VERSION(10, 1, 2):
> +		case IP_VERSION(10, 1, 1):
> +		case IP_VERSION(10, 3, 0):
> +		case IP_VERSION(10, 3, 2):
> +		case IP_VERSION(10, 3, 1):
> +		case IP_VERSION(10, 3, 4):
> +		case IP_VERSION(10, 3, 5):
> +		case IP_VERSION(10, 3, 3):
> +		case IP_VERSION(10, 1, 3):

This could probably be replaced with an if (ip_version >= X) kind of
construct. That way you don't need to list every individual supported
chip everywhere. Minor version changes often don't require any changes
anyway. Instead of the default case, you could have a check for version
>= IP_VERSION(11,0,0) (for now) expecting that a major version bump will
probably require some attention. But minor version changes can probably
be supported without changing anything (here and many other places where
we currently have switch (asic_family).

Regards,
  Felix


> +			device_queue_manager_init_v10_navi10(&dqm->asic_ops);
> +			break;
> +		default:
> +			if (dev->adev->ip_versions[GC_HWIP][0])
> +				WARN(1, "Unexpected GC HWIP version %06x",
> +				     dev->adev->ip_versions[GC_HWIP][0]);
> +			else
> +				WARN(1, "Unexpected ASIC family %u",
> +				     dev->device_info->asic_family);
> +			goto out_free;
> +		}
>  	}
>  
>  	if (init_mqd_managers(dqm))
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index 2e86692def19..6c56e43e2f7b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -406,29 +406,37 @@ int kfd_init_apertures(struct kfd_process *process)
>  			case CHIP_VEGAM:
>  				kfd_init_apertures_vi(pdd, id);
>  				break;
> -			case CHIP_VEGA10:
> -			case CHIP_VEGA12:
> -			case CHIP_VEGA20:
> -			case CHIP_RAVEN:
> -			case CHIP_RENOIR:
> -			case CHIP_ARCTURUS:
> -			case CHIP_ALDEBARAN:
> -			case CHIP_NAVI10:
> -			case CHIP_NAVI12:
> -			case CHIP_NAVI14:
> -			case CHIP_SIENNA_CICHLID:
> -			case CHIP_NAVY_FLOUNDER:
> -			case CHIP_VANGOGH:
> -			case CHIP_DIMGREY_CAVEFISH:
> -			case CHIP_BEIGE_GOBY:
> -			case CHIP_YELLOW_CARP:
> -			case CHIP_CYAN_SKILLFISH:
> -				kfd_init_apertures_v9(pdd, id);
> -				break;
>  			default:
> -				WARN(1, "Unexpected ASIC family %u",
> -				     dev->device_info->asic_family);
> -				return -EINVAL;
> +				switch (dev->adev->ip_versions[GC_HWIP][0]) {
> +				case IP_VERSION(9, 0, 1):
> +				case IP_VERSION(9, 2, 1):
> +				case IP_VERSION(9, 4, 0):
> +				case IP_VERSION(9, 1, 0):
> +				case IP_VERSION(9, 2, 2):
> +				case IP_VERSION(9, 3, 0):
> +				case IP_VERSION(9, 4, 1):
> +				case IP_VERSION(9, 4, 2):
> +				case IP_VERSION(10, 1, 10):
> +				case IP_VERSION(10, 1, 2):
> +				case IP_VERSION(10, 1, 1):
> +				case IP_VERSION(10, 3, 0):
> +				case IP_VERSION(10, 3, 2):
> +				case IP_VERSION(10, 3, 1):
> +				case IP_VERSION(10, 3, 4):
> +				case IP_VERSION(10, 3, 5):
> +				case IP_VERSION(10, 3, 3):
> +				case IP_VERSION(10, 1, 3):
> +					kfd_init_apertures_v9(pdd, id);
> +					break;
> +				default:
> +					if (dev->adev->ip_versions[GC_HWIP][0])
> +						WARN(1, "Unexpected GC HWIP version %06x",
> +						     dev->adev->ip_versions[GC_HWIP][0]);
> +					else
> +						WARN(1, "Unexpected ASIC family %u",
> +						     dev->device_info->asic_family);
> +					return -EINVAL;
> +				}
>  			}
>  
>  			if (!dev->use_iommu_v2) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index e547f1f8c49f..0bee4b965e1f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -236,31 +236,39 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
>  	case CHIP_VEGAM:
>  		pm->pmf = &kfd_vi_pm_funcs;
>  		break;
> -	case CHIP_VEGA10:
> -	case CHIP_VEGA12:
> -	case CHIP_VEGA20:
> -	case CHIP_RAVEN:
> -	case CHIP_RENOIR:
> -	case CHIP_ARCTURUS:
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI12:
> -	case CHIP_NAVI14:
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_VANGOGH:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_BEIGE_GOBY:
> -	case CHIP_YELLOW_CARP:
> -	case CHIP_CYAN_SKILLFISH:
> -		pm->pmf = &kfd_v9_pm_funcs;
> -		break;
> -	case CHIP_ALDEBARAN:
> -		pm->pmf = &kfd_aldebaran_pm_funcs;
> -		break;
>  	default:
> -		WARN(1, "Unexpected ASIC family %u",
> -		     dqm->dev->device_info->asic_family);
> -		return -EINVAL;
> +		switch (dqm->dev->adev->ip_versions[GC_HWIP][0]) {
> +		case IP_VERSION(9, 0, 1):
> +		case IP_VERSION(9, 2, 1):
> +		case IP_VERSION(9, 4, 0):
> +		case IP_VERSION(9, 1, 0):
> +		case IP_VERSION(9, 2, 2):
> +		case IP_VERSION(9, 3, 0):
> +		case IP_VERSION(9, 4, 1):
> +		case IP_VERSION(10, 1, 10):
> +		case IP_VERSION(10, 1, 2):
> +		case IP_VERSION(10, 1, 1):
> +		case IP_VERSION(10, 3, 0):
> +		case IP_VERSION(10, 3, 2):
> +		case IP_VERSION(10, 3, 1):
> +		case IP_VERSION(10, 3, 4):
> +		case IP_VERSION(10, 3, 5):
> +		case IP_VERSION(10, 3, 3):
> +		case IP_VERSION(10, 1, 3):
> +			pm->pmf = &kfd_v9_pm_funcs;
> +			break;
> +		case IP_VERSION(9, 4, 2):
> +			pm->pmf = &kfd_aldebaran_pm_funcs;
> +			break;
> +		default:
> +			if (dqm->dev->adev->ip_versions[GC_HWIP][0])
> +				WARN(1, "Unexpected GC HWIP version %06x",
> +				     dqm->dev->adev->ip_versions[GC_HWIP][0]);
> +			else
> +				WARN(1, "Unexpected ASIC family %u",
> +				     dqm->dev->device_info->asic_family);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	pm->dqm = dqm;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index ae7c9944dc4a..5353f43c67f3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1425,30 +1425,38 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  			HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
>  			HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
>  		break;
> -	case CHIP_VEGA10:
> -	case CHIP_VEGA12:
> -	case CHIP_VEGA20:
> -	case CHIP_RAVEN:
> -	case CHIP_RENOIR:
> -	case CHIP_ARCTURUS:
> -	case CHIP_ALDEBARAN:
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI12:
> -	case CHIP_NAVI14:
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_VANGOGH:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_BEIGE_GOBY:
> -	case CHIP_YELLOW_CARP:
> -	case CHIP_CYAN_SKILLFISH:
> -		dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
> -			HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
> -			HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
> -		break;
>  	default:
> -		WARN(1, "Unexpected ASIC family %u",
> -		     dev->gpu->device_info->asic_family);
> +		switch (dev->gpu->adev->ip_versions[GC_HWIP][0]) {
> +		case IP_VERSION(9, 0, 1):
> +		case IP_VERSION(9, 2, 1):
> +		case IP_VERSION(9, 4, 0):
> +		case IP_VERSION(9, 1, 0):
> +		case IP_VERSION(9, 2, 2):
> +		case IP_VERSION(9, 3, 0):
> +		case IP_VERSION(9, 4, 1):
> +		case IP_VERSION(9, 4, 2):
> +		case IP_VERSION(10, 1, 10):
> +		case IP_VERSION(10, 1, 2):
> +		case IP_VERSION(10, 1, 1):
> +		case IP_VERSION(10, 3, 0):
> +		case IP_VERSION(10, 3, 2):
> +		case IP_VERSION(10, 3, 1):
> +		case IP_VERSION(10, 3, 4):
> +		case IP_VERSION(10, 3, 5):
> +		case IP_VERSION(10, 3, 3):
> +		case IP_VERSION(10, 1, 3):
> +			dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
> +				HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
> +				HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
> +			break;
> +		default:
> +			if (dev->gpu->adev->ip_versions[GC_HWIP][0])
> +				WARN(1, "Unexpected GC HWIP version %06x",
> +				     dev->gpu->adev->ip_versions[GC_HWIP][0]);
> +			else
> +				WARN(1, "Unexpected ASIC family %u",
> +				     dev->gpu->device_info->asic_family);
> +		}
>  	}
>  
>  	/*
