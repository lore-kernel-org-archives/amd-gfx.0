Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272EAC004D4
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 16:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E4610E09D;
	Thu, 19 Jan 2023 16:00:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5511D10E9A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 16:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnJaK20rEEdu5lutYAXDGjQmLxVpRMZtgYB8Nu7UzkpCltjSSdiUKa3p3nmJOwn0G9omKwo7rhFguar/KIx4TsojQDfJsvGINcbUVf046+SLeQuJR8muHYT9SPqAoz8N3kywap30P2Org3oGleZB+kGKrBo6JEdg05pTnJcJ38KoQsIFlDY4WVdWMm5I7sJHag17qL9dG+j0vKUYhbSj4CNxdJ9PHmmjCTLyibH7cPkC6A1dPwO3bTtx/4Vl/NAI2mYWOPCuk7bZurZjsTj7DlZtgo6mQIyXOGPh+hHTQQ+agN7ULy7Nb9/zNPjQheWRX1+HOA2Z9EC3G3Fatgs7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnyME6ej6HWVx3OTlq3NIzsoG2+77fZJHxN41HGUmpM=;
 b=ib0BBeeiodgbeJqB5Tr3pIn8EeE2bRUk/RCBr2TIP4bVOumYqs9roAzIiAHEER8aVPK9JIVWfJzCUjHQ1bDgUytJP6NCitUaeuO7hkaaCDpD/ceDfqJ/eEbu0j1MCLnxoCzJUtubtFysTyhdUQalGZSyhQUum3A/zC8otxLKHK7n6rAEIT+8PAk/PqourDbYexqGm/bqeX/JjNCKrfBx3EyNzHtO7RhLjnlkvZbeDFypUHQxOnoSEzDnEV1GQsJ5CLPE37u5uAAOcdIZIdv+E600UuK9uRsanU8n1x8vgqlJ2Zaic0FveeuIVEkem3DGAQm11w64NLwaEKqkqH4vmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnyME6ej6HWVx3OTlq3NIzsoG2+77fZJHxN41HGUmpM=;
 b=pIQVGp9kSm64gUA5HpwVm6GpsT+D+7dpVmyE4sxzsOxbQWNf9vf6++S5hckVytDRbYG4PcBi5x4Z0kYM2vE1XddWJi8dJ4t/Y26B+AdeHPbQgJPs2zp9gh7YqfH7NmaUIPDFP+Sb/fCbEnCyIonjK6489j2ERDYQeTskx2xcqNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB5454.namprd12.prod.outlook.com (2603:10b6:a03:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 16:00:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 16:00:27 +0000
Message-ID: <f07552d8-7019-92b6-a298-a76eb077bda1@amd.com>
Date: Thu, 19 Jan 2023 10:00:23 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Documentation/gpu: update dGPU asic info table
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230118211414.2662045-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230118211414.2662045-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB5454:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd68086-da1c-4f75-0ed9-08dafa3647dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFwnHj/OEMXs89i4T79HxLO0DymX/gw4bzmj9mMA5UUgqmcplk0Zipw1k5ECIgWEjz+5zYfbLKx69uD0jEVWOvteZJ9GLTuo/DEkWKXuuQGGEw4NyTU1osMtTvGF/n/2XiDQN6DC23EbGNshJbhZGiEwsVaHMpUsUYa4LMkkLZZgrZtgLSbTMslnA4oL45yYyC4s2mPg/mljJkXDGaUxxwHgzrF6oMIH1eQ/6BjcGBGDz55pwKWKnO/wi3ikGfvqF2lqacKZdcDhvgX7rVbDH3oDUApfvQscQ7aw288olXRluHCyCnjQk/jOcOSvG4U8vS71G1tIVRxeaXSUVhyRJICwbMC4MKkdzNYyw7rWx5UeXN5tZeWpuM6VLX/XNGlKQZy+RratMYL849NYzmC9HOpr/pUvXAwIkew91i3WEgRAGZVIdYc1HAlXFJfvihLj9+ufvvmiOhob4iKgqEez7ZetarG90rqmRrxsYgBq5gCpsmUB5jLreVQtOwa4fLmRcHLS4rF/bJ0mTZApxOgs5h3HKpNYHl+gcvb+14HOoV/FnGqvRZZZDb5WOaixH0npCYz5OkoaQ+qxvMWByrwqUtT9G2xz6tzxprbRra4U+EvIWiU8NqjtNMjJveKbDf9+ilYJgPcGOyq40ESR7RWOOgbn9Z2qwHTcWwBXFYPY7ya/blEqZpt2pz0Pm+4zMwuDNmZt3FABzYNTuEjIsyLxsEjHbfREEyAlWoY7kDTfjWdjT4aEwjZnnV/RYZyYxCwLoY9QRUWabvPl4USc6E69qlsvKL2AMivCpUd/mSl0UVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(38100700002)(31696002)(36756003)(86362001)(31686004)(2616005)(6666004)(53546011)(6506007)(186003)(478600001)(6486002)(26005)(966005)(6512007)(5660300002)(15650500001)(8936002)(2906002)(41300700001)(66946007)(66476007)(8676002)(66556008)(316002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3gwYlRINDA2U21nay9iZ1VpK3cydTRxK0JXY092aVkyQXNWZUxzVUM1a0tE?=
 =?utf-8?B?Q0tvODJ2bnlzc3QyT0dkSUVhdjRpQW92eTBDMmFwNGMydWpRM0JRSlNGSVJ6?=
 =?utf-8?B?dzBBV0Y2ZHk2QlJtZ3Z0QXZidzczZU9FUml4MDNoSE1CL0hvYmJVc20yS3BB?=
 =?utf-8?B?RnRCeHo5ZEFmWEFUTVd3RlZlS2lWNDl3ajZDQzM3RkVUWTBvNExzUmJjU2g1?=
 =?utf-8?B?aXFMV3NqbmM0elU1ejNsYXVwd3g2bU1FMElXQWt5T0ZNYnFUbzl3ckRWbnVO?=
 =?utf-8?B?bTFQeGVTVXRxWW1BK3BmY21rekJyQUZ5YW4wampzNkxZMUo4Y2k1WkVZeFhw?=
 =?utf-8?B?eE9qQ3ZybU95ZjJhR0tpb2lkZnVtSzM5TkczTkxYRGF5cUpCYkt1MTAvZHpV?=
 =?utf-8?B?QS9GYlc3d3g2S0NRaGJWT2p4enk0ZUVNRUhKbmRmVTNnNzIrOEhoMVBjUGR4?=
 =?utf-8?B?OEtKVFYyaVAxRUxrR1U1WWVqVkkvQ0xFdS9GcTFFOC9OcGNFdTljQ2toc212?=
 =?utf-8?B?V0NpdUJTaVJiVnBtVlpNNnhQcE92SXdJSG4vcjh3UVJPT01ma1ZseXZiazBJ?=
 =?utf-8?B?QlBpZlpEaUVJTCtaMENSQjhRaE12TktObStKMjF1TEo2UVJmUDhUSkNGL2xL?=
 =?utf-8?B?cnd6MCtUQVFEcFhoVnhIN3dDYitMSXZYRVNyMWxBdHZMSkRrQXZ6SVQxdUJv?=
 =?utf-8?B?c1A1N25nd0ZtK2x5eCtuM09LTGRZV254SDg4bysySHdpUHlVWVF0N09iODQ2?=
 =?utf-8?B?RDVsWEVRNnQ4bUNoUkV1YkxqaHFlMWVYZUpQTndvZ2U4YktJcHNzRVhhb3Rt?=
 =?utf-8?B?cUphTllWeFBIcUVWTVgrU0JtV2xLL1kySUllTUY4RVJ6TnNBeEs3VHY3dk1R?=
 =?utf-8?B?RTJZZlQ4QXVqRHp0S0R3eFEvL01aOGN5d2RGRTRhOG11d2YyWlpJZE5WNTk3?=
 =?utf-8?B?NXVsNTR5YWJjanNIQzJ3a0NUdjFDL1RRcmZObGxLRk9yS3I3cUVZSVE1cmYr?=
 =?utf-8?B?UnlUYWwxMG01K3czdDkvTmhHOTdvUDY5YTVvaGt4aEJRR28rWnNhYXUrUHhB?=
 =?utf-8?B?eDRVcmZML3hwZDJYamg5SnNHeWRNOWQvOW4yRFR1Qk1rd2Q5a0RRT1JZVTVz?=
 =?utf-8?B?aEVVUlgwN0R6SHJqVmVYdG9RdTlRQnNiZmtiUzcwV0ZXMk1hdmp0WFNmZkRN?=
 =?utf-8?B?TkhwQUJMNU95Z3Q3a1A4cVVtWGxWenRGWmpGbFl1amExeDVLRHJoOTJqQXc2?=
 =?utf-8?B?b2V0ejBpMkJDbDhRRWxUSTJDL3ZwNWc3YU1qYkw2TXg1M0xjanVEVVBXNFVT?=
 =?utf-8?B?VFVqc1NFUFhDVGp4OWJYc1NwYzh6QUhvVTc4UVdlU1BXeGJWdjQ1THdMbXVi?=
 =?utf-8?B?OG8xWVJyRXpQVmdMR2pNUFhzVU9PZE9sM3g5TVZKN3ZaSStPQkRMaG1RRG9B?=
 =?utf-8?B?bzdXelVpOWRrb0paZll4dzYrdkVYTzZTNTZCd0pwaWh0aFcwUFFVNGdRaUJh?=
 =?utf-8?B?NWpVdWZTNENZRVZ5WUlPbG1ZcVRSZEpjUlgrYjNtOFQreWsxYUFEREd0akND?=
 =?utf-8?B?aFRMVTlqdkNpU0FTK0FSNXpGNjZmOHB5WFhzbHZPeGRhK292Q3hJS2xVelRq?=
 =?utf-8?B?T0xKbzVhM1J1ZFJwenpFNjdxV2dpNDU0MkZkMldpTGZlMmdEbnJsY3Fka28w?=
 =?utf-8?B?cHNTQmFrWW40Rkl3dzc3WWRmOXlWVzlLMWkxVFhMTFh6MGtLME9SUThLU2RX?=
 =?utf-8?B?c0k5L2FGWExTZG1Ma2t0KzNkZUxWbERiRGpENEFWTHF1dXR4UlZsb1B1cXZ4?=
 =?utf-8?B?ak8zZ0VIUWtTdFVGK0duMExidUJQOTdmSmhlbjN6ZlEyRFBDRUhOdXBtN2JL?=
 =?utf-8?B?bTQ3SHcyRkFLMnh2NEU3MWEycnNuczZ1aXp2UVBVSkgrdjNzMjNZSE9YTlpx?=
 =?utf-8?B?UGxNOThDblZhYmxnYlB2NzBFNENlMkdMczVtUlpJcm9nU2s5TW9DNURjS21h?=
 =?utf-8?B?VzdLR3RzVXV4VnU1VDBqTStzVEtTNWZkakJRWXF0aXk3OW5OQlJ1eFU2TXFp?=
 =?utf-8?B?bCtYRUpKSVF0QzBna29laHhnMWpIend5R0V2RXFYOTRmQmVtdGZ1MVBZNDlS?=
 =?utf-8?Q?Fw5TjpJPVl5ryrQRZ04FqDP15?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd68086-da1c-4f75-0ed9-08dafa3647dd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 16:00:26.8926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDD9aQkGvDk8WKlWPuTAZsD/xJHe42naAdQgSXIIhliwVc/zlYbFZImyGjeoaB8+gHU5Y2Kwoout+0xQU6Hz9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5454
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

On 1/18/2023 15:14, Alex Deucher wrote:
> Update to the latest launched dGPUs.
> 
> Link: https://www.amd.com/en/graphics/radeon-rx-graphics
> Link: https://www.amd.com/en/graphics/amd-radeon-rx-laptops
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   Documentation/gpu/amdgpu/dgpu-asic-info-table.csv | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> index 84617aa35dab..882d2518f8ed 100644
> --- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> @@ -22,3 +22,5 @@ AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3.0, VCN
>   AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, DCN 3.0.0, 10.3.2, VCN 3.0.0, 5.2.2
>   AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGREY_CAVEFISH, DCN 3.0.2, 10.3.4, VCN 3.0.16, 5.2.4
>   AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.5, VCN 3.0.33, 5.2.5
> +AMD Radeon RX 7900 XT /XTX, , DCN 3.2.0, 11.0.0, VCN 4.0.0, 6.0.0
> +AMD Radeon RX 7600M (XT) /7700S /7600S, , DCN 3.2.1, 11.0.2, VCN 4.0.4, 6.0.2

