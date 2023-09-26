Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9862E7D0C5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 05:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225C310E0B5;
	Tue, 26 Sep 2023 05:52:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9876210E0B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 05:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZEmdLMwmzJXHKN9cyBn7tHe9V2NBMMULUqhqLTjqD/YPIkGQeaSlg6/Px9/VWahNnSweTkzG/9hloyBaamhBqQOu84BnWhTE4edDntyctkOWaLWbwJ0Nju8M7+5kN+MqdAKoT6QdLOr79fV3LMx558QEqutEFGuIgM7q8zi+NkWStI5VjkjV4cNUDiFU6rIdbF0xSj2Xmo9vkVUVLEKXTK9KycOfXT3u3pIlAkEX6lfBDkC3NocsEmPSny8i/IhtnSy8CCg4dUEfYdsyVfECI0WRWIuNv3/DaYKxoGkVZQC/Lj/ntVyBEroLP4MkKDkLBiW3jIxFlNAgqwC6zhcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sga4z71hZcr9m6ZxhhaMaMJjktEy95mlAcxVEmu7q40=;
 b=CL44EkoxE9R7mK97tJuoa9h+z8CtCuzv6hVzTUWOOKtolOg0oAdSIUorcWoVErQfChyrHhHGvIc3L6ZVMyMHTerLoRY4hz+xjkWFI0V97+ZvcEYBwzcWp+4w/g0XzNAl8/m8hk7FwWmtQMetxUsPh4C8LF3vHTxodEHvrLW2w+O9liKVJXyTp2CfiIrY2s7jqnB5MEv4G+f97IoQxbUT2n7Xqwjc74vm8kG40LHuS+j+qtSUElMoFKwnv4gOiqlXUAgIzOJ3NBhlpvO0Mc4h/qdnYcGkBDpsTDNF1bgbPOfXHZf+YatlANW3EKe89mtXKYP4qv8dDlGibRBD0qLXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sga4z71hZcr9m6ZxhhaMaMJjktEy95mlAcxVEmu7q40=;
 b=dG7FYvhm29uewWm1jlMyF66ViAiJlCpqBE4jJBujJL3hBcpxBa04ZwMshFRgTWYKv9yWW7j+Ik4PbsDJUBjrnQyGoDMXnLnDMgGaO8fJd4k0ebUrlScp50XZGSck9lk1E0raH2Io84z5DeXqt6qkwlSTYAeP0odVmyFs0uMBqNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:51:55 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 05:51:55 +0000
Message-ID: <cc2fcd5d-db74-a6c3-a765-239e3aa29b3e@amd.com>
Date: Tue, 26 Sep 2023 11:21:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/7] drm/amd/pm: update pmfw headers for version 85.73.0
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230925042752.3847-1-le.ma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230925042752.3847-1-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::26) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: b883b475-f4a9-4606-99cc-08dbbe54b022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZ0heAF2in8XREUogxQjlox9tNQ6pFOntLFCPikCWJfP34l+WcZVKHpcmirVL462pyRc4UifNjusodQnYHYGCg/wrdYdbVXWT9FDvhs0s+rrOkig3IHz0/Q64ZKlrBIFSvF7HLHp3ZeIV5Q6hHAO0sSOho+d/1bLifXA4ed1vGwka1pa9RN2pXNIhRsnpsAiRmfMdoQaMzgyL6g7PvbtJf9pAhCToXTew99Ul5XUH61U+BUWNlmJWhdFNHkbcHV8iNU7cZrrHqnsM3vix+S8gU6Zlw7fQ7m4O5GfVWSV41vFtKRciqNeQ0yLcLr89VUChYYoURwj+RYcDdnDoDAh5SZqMAjuBkVxfCl1tSXCKf78W+4bMEPCqk6UGMDg3Z/1GNNBTA8hmh6deeTxeF6F7iMejB1Z4+ff9+GHNzZSIdX6bfOiYeSZrPB8igUK1THAIz13fezwpew0vE79BShpraOaGdWP596JqBPXw2/9EB+A6KQWUm896iy5saW9deiFWWq0FfldAmqTSVw+CX52yCi1fRQFh4aXQotEuAKLjBouzYj8/y58B1p4EfpJ7nCZKwUElf3QdsymSfZakP4r8T6ueM94aLgKncd7H5l+2U1CabBTOzQ8YoEnSjuCUFAVbXPfYwpCytDq8FudGMZyog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(31686004)(316002)(41300700001)(66946007)(478600001)(66476007)(66556008)(38100700002)(36756003)(83380400001)(2906002)(8936002)(6666004)(6506007)(4326008)(8676002)(5660300002)(6486002)(6512007)(53546011)(15650500001)(2616005)(26005)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b25haVYrKytLWUNLZDhQUXVHdWl1cWFET3JtUGJGVERXeXdveWJrd296aTV1?=
 =?utf-8?B?R3l2S3RERndLZk5vemN5YytQeWtrUUlkVTJkY1EzbXNsUUdPckx4YXI0dmx3?=
 =?utf-8?B?RlBZVzRjTlUzalhzczN4MjV0N2R1Ri9mbnlxQlJ2SFRaUEhRMFVGM0Z1dkwy?=
 =?utf-8?B?YmpUbU11LzBzMXhScnQvcGl1c3hLOTJGbGMwV1JaYXpSYURtd1Z3WEF5emk3?=
 =?utf-8?B?Njhmc2ZTMjZ6OVcwaTR1blQ4V1FWMEpnbitxTm82bWJMcFZkUW9za0hJZUhZ?=
 =?utf-8?B?YTJQU2ZuK2RSQkh0aG5ORXFaZDJvSXAwaXZnZ3gxdllCR25iMkNCQXE5Y1Fv?=
 =?utf-8?B?ZXBldjk2NE1hRW1RZFc2MEZDejUzOWZqblZJME5ST1Arc0hPajVHeEI0eUQv?=
 =?utf-8?B?RXRyQm9DMHpoSWNTZzFhN2JYZEJGMVBjNGFhanZOdHhRWkV2aTRQOFh0blVa?=
 =?utf-8?B?ZW1PYk1vcXdXSmVOOXBzcEprMDRxSVdzMEpDQy9SSk9HeXg1dVF2dk5RcDcy?=
 =?utf-8?B?ak9PSENUQzJibXNnUzgweUdDQzhJVXdDeDFCaTZjVENRSVNDa3VYc3l5Tzg5?=
 =?utf-8?B?ODhHL1MvUlVRU3plWmpDejVpa29vY1VGUG5SNW5kRW9ZOVBxaFFVWXFtN2pz?=
 =?utf-8?B?dytEOGNJZjNFbkV1RGg5TEdPRWdqV2JwMG1VK2pNK3ltZVd4OU8wRHpFSUda?=
 =?utf-8?B?U2VCME9VaFBXcS83T1dGaTVpcWtodzIwS0RLK0xVbVV6dkU1bkVFb1JqWkRT?=
 =?utf-8?B?SnBMRy9BYTJDNWx0eFBMOCttbmpjRlhCcUY0RHNKRU50VktlQUQ1THEzNWFQ?=
 =?utf-8?B?b0VRN2FxV2lNeDg2Y0pURys2ZW1rdmJaZ2JFTXovd0xxbnY2VEpsQUVPeEdC?=
 =?utf-8?B?SGVVK0hKOU5HRVRlUWtucmxYRnR0ODkwUU5QWXNQcm50czVqVUY1amcxN0lz?=
 =?utf-8?B?N1dqWXZYNTh2cURxcll2ZVNWa1dsNk1pQ0dESTdpckNiaXBTYVVDM2l1T29l?=
 =?utf-8?B?NE1sUGUyd1RqV3VhQkZIRUpxRkdKQ1o2czgvL0RNOFVCdzF2NVZVTnlFRUJO?=
 =?utf-8?B?TE9Cc2w0NFZ3K2NKa21FZTNoTk9aNHllYkhub3U3bSs0TDY3OVRMMVo0NEZQ?=
 =?utf-8?B?cEJNQzhRU2RYQzV2cmZnM2tITDUzRFFLNDA5cUR6RzYxMUN5c0lJOVBkeVBX?=
 =?utf-8?B?bVM3RWtiWk5jVHBMMVJndjBHdi9HSHVYd3k5V2ZoSWVERkxKR2NHRWZFSFAy?=
 =?utf-8?B?LzJReWNpNVlmM2ppRUJVLzQybnhlV2lFblk1aUxXcGhCMEx2b0RPbTFRYWhv?=
 =?utf-8?B?bm1VSkxlNGliS0RyeE9QSU5BY3VZSkpXMjQxd05UOGVrWnNPMEVJbnRjczFl?=
 =?utf-8?B?a3hTVkludTdxZVJQRGszRVNiUm5WdHNzYzB4SE05TFV2a2YxM3BQdTRkOWhI?=
 =?utf-8?B?MmVEazBZZ2J1TG02WWVVaFBmSjc4ZCsyZldVRyt2SUo1QWxyRGllZ2RrNkVR?=
 =?utf-8?B?R2I5b25ocWUvK0w3NTFyZTlhN1pPQk5kaHcwOU10aG90Z2IwajVpSzlvUU9F?=
 =?utf-8?B?VVBZZkorTk1VU3Z2SVBLaVBmN2JjODRxT0ZySktwdUZ6OFVDS2FmTkpNM2l6?=
 =?utf-8?B?RVR1eiszOEpJQ2FMT3ZGSDRaL3ROV0J0TC9GVHU5YnMwRWFlK016ZHpTbVp5?=
 =?utf-8?B?VFJoZXZRdG5KSGIwKzRoTWNXSHdabVl6SDlXSjJUWk45TWQ3NkdvckVjRStD?=
 =?utf-8?B?YTUzeGFudFlneDVVTWNrcFBoVnRuNE9MaS85d2t6bmhoWVlJR0RzbHNrRGVI?=
 =?utf-8?B?NTdlQ1gybnUyOVZKcStVYm0vWmg4cDhqaHlHM0NVMnFQdWF1clAvdkwvbkpn?=
 =?utf-8?B?TGhEc0JhbzJDaXVPbFF1dFZKSEFERXUzWHdnTWd1TllOcDdLZithV2Zhbmlh?=
 =?utf-8?B?QmRVdzl0OXU2aFFaWWR0dHhISXo0Y2xBMlh4d0Fsd0V4bmhxZXMvaVlxeTZP?=
 =?utf-8?B?aWxrZnJOSFZvTnUrUE1KMWcraWFHQnBoMDNaSEVOcjQ1SzhWMUE0N2kwbVUw?=
 =?utf-8?B?TFhZeDhkOGJQbTBHS290TWxON2RVbGt5eURQbTJnR0xUN3Z1QmF5RjVTWTFu?=
 =?utf-8?Q?mSIYClbgVsVGbbGweinKFx53A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b883b475-f4a9-4606-99cc-08dbbe54b022
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 05:51:54.9128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a5XYaF4Al78UlTnLrAMreWaIZc+y/uJZxeO5K7kvVTaLnUbeMZKQ9hENI+kgTrB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743
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
Cc: Alexander.Deucher@amd.com, Asad Kamal <asad.kamal@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/25/2023 9:57 AM, Le Ma wrote:
> To add message to select PLPD mode.
> 
> Signed-off-by: Le Ma <le.ma@amd.com>
> Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Series is -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> index 021dcbe58473..509e3cd483fb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> @@ -90,6 +90,7 @@
>   #define PPSMC_MSG_ClearMcaOnRead                    0x39
>   #define PPSMC_MSG_QueryValidMcaCeCount              0x3A
>   #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
> +#define PPSMC_MSG_SelectPLPDMode                    0x40
>   #define PPSMC_Message_Count                         0x41
>   
>   //PPSMC Reset Types for driver msg argument
> @@ -107,6 +108,10 @@
>   #define PPSMC_XCD_THM_TYPE                          0x3
>   #define PPSMC_HBM_THM_TYPE                          0x4
>   
> +//PLPD modes
> +#define PPSMC_PLPD_MODE_DEFAULT                     0x1
> +#define PPSMC_PLPD_MODE_OPTIMIZED                   0x2
> +
>   typedef uint32_t PPSMC_Result;
>   typedef uint32_t PPSMC_MSG;
>   
