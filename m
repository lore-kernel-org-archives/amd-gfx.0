Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A7ACCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 13:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4ED910E26C;
	Tue,  4 Nov 2025 13:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EZQeOaY3";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A3B810E26C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 13:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zB6Iiop27NjVU3BoVC0iZrkCqcruS1w7EVb/SkVQeejRWrPeTCqc7lJ1hEMbr9ZavYswVvgOoBxN3I0SkvTy/uixk0Wz/ExHf+14CRQqL+8PTMU0xTawd40QTe7KLmNgsfB7C+bdsdFj7+PshI4dM0Itt55Oj0mIRhk692b3MLP+nM23Zp6x0popH7pc4ZYq5xI1u05YthEkrHx0PjZKFMq56QNMfj5nbNb1PzO38TZFhYiSSEiZtpefFe+6RStFBPPrMm3Z1yDCCIS+3/LNZKJ3oj6JQPuoZmZKqrpyUP0kk+BdFnWwdR0TL7Lhj31peqtjQ9rwj0X+jxJkVP5NiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yOHcyBQ+SxGtohAG9+MtoIWmBLsWZNhzChG1J4PuNc=;
 b=a69rFbT2blltUnA1cp0OAYxK6b7qYQtOmeJI0l0CY/A7rN6VKPsNashK9DEKua/hiuli93oX5t1UpI4LNQxZg4kdNe9FpVFa4+sEK0P/X1PgKC0NciWwy6Q4wgeiYGqiT+/3orf1f+S+hYBEfJq7S7oJiRoY96bFIisV6geZnR5089M9rUK9lChQN4HL2q55x4cszyASTnh4nxVelECOKAmRayQp5BRlIXSf0pzGiW5vZhoUwLfC7AHALGE02IqmKfNhJcejkcldzwHqd7IIyfq1p79VpAzq62E34AZ85blYnUy7g+swMEf8O+9YDVLijos6vyI8zBXXm0BgAv4RTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yOHcyBQ+SxGtohAG9+MtoIWmBLsWZNhzChG1J4PuNc=;
 b=EZQeOaY3UppuED/v+YA15AoTqpfC1xQZMx/DMVchnjzv1DI/8a10Cu+zsGazseLjZz+/EowLqIQq2/HAbXpfRlpBkA7FooCKPYKOtVoIMu3u9I4AK6fyLiNja0kc+slf5V0QU7xpLSrkdnxOnMt3gCapXu5FdE2hbXh4FmG2g90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 13:33:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 13:33:57 +0000
Message-ID: <6814cde4-0b65-4873-a006-ee52520a8fa2@amd.com>
Date: Tue, 4 Nov 2025 14:33:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] drm/amdgpu/ttm: Use GART helper to map VRAM pages
 (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-6-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251103222333.37817-6-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fc7d0e-3d68-40b6-9f24-08de1ba6ce0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHBoeENSMkhnUk9lMk8zallKQUNmbzM0d1FTRlFEb2JwYzl3M2xPWHNlamhM?=
 =?utf-8?B?OVhkVENBN2dzaWI3UHdQS3Z4cXRyUE90S0FaamVQbWpDcjltSDVqWGpRWWV2?=
 =?utf-8?B?K1R6NlFSa2FEelpoYnhmTUpnUnZaM01qa0xMWE1kS0FraU1RQmh4L09EMGVC?=
 =?utf-8?B?QTBLUzJpMGs0eTZ3RFVJZ1Fpa21odjN0Sy9qd0VxcEszMXhGUzV4SlhuNFl5?=
 =?utf-8?B?VmcrRHc4eXhBNmZ1dHBUdmlmalV4cUNzRmw2OGZ5c1h6NXpocE5vcnBDTm5K?=
 =?utf-8?B?QmtLQVpYNkx5MVU5UFBzaGdaSHVJMS9JbFN2WUc0ekhEQmcvWjFyaThnZXJZ?=
 =?utf-8?B?TE5GaTZqKytBVlh3VFF0MDladWo1ZU9qVm9Cdk9XTmxjU1J2NVQvUTd5SGdh?=
 =?utf-8?B?NTgzOUFOOTE3YS9Lb0tBZ1JkVjZOTG1GbXBzdnBSY1R0WWs0cXc0WHNvT1Uz?=
 =?utf-8?B?M0pvV1ZVUkQxdHlLMC95cFdUTHBhcTRUY0N1TUEvd1JDTDFVVWt4ekEwUEg1?=
 =?utf-8?B?L3hiNWJuVGQvWFJpUENacWMrSkx0VDM0Z0VHbFB0NWdodzNEa1FKeFJSOG1k?=
 =?utf-8?B?N1ZyOTl1dDVnWEZnb1lXZXlxL1pVenlIQ3plQSt2QzhIeENQNmhwTHVCSW9y?=
 =?utf-8?B?NGNZazBFOVE0enJ5M2U0dlZ6S3ZjbkdudTNBOGZpcDdLMVVMY0lSQ2ZPVWFW?=
 =?utf-8?B?aytjTXA3akY4Nzd5RDhmMkJUSDRaaFZxd0RhbGdlM2d4ZFlHbUlXc1BiRUVK?=
 =?utf-8?B?MkxpOEpFWTFCRlpSUDRndkhhOW83VnRlNzR3L0pVdGYvVTBqK3N3eDRjSjBt?=
 =?utf-8?B?bVJTdTNLWlFWM3JJdVFHdTlqb0VZWkxyZ01XdU0vMHRqTlZ1azVVYkFWM3NH?=
 =?utf-8?B?cEZRamU1N2ZteUtxcHBTdk8vZVRaUFpJTy9EWktSOHI0TGNFcTd6SzdHNHFw?=
 =?utf-8?B?dkdJeHZLQUJ0YjFvdkYxY2RZbTQvMUlFaytXS3JQTXFrQlQxVUhLUzZKVnVS?=
 =?utf-8?B?QUpFeTYxNW1jNGZOU0NNTGFKbmZTU0NPOFVvQ3JSdE9ObjdiRG8yNGRCQlNJ?=
 =?utf-8?B?RnlWeXpFRFZPTUlQSFZxQ05TemdIK0lac3RPVk5UcGhnRHVQSnRSRnhzTHU3?=
 =?utf-8?B?MjJiMHZEd2YwRUFCcmNLM28ybVNaYXFlRzZEdS9NYTlBai8rL01CR1BHcHRw?=
 =?utf-8?B?VVNXZFVTUjNSYWhBOWFQYTlSRERjbWZLd214S2VhN3o5elYwK1VBUWhYeW5y?=
 =?utf-8?B?clAyWGEvbyt0N3d6b2JpVUprMUhnbUs3NDFvV0tvQ1lYWHdvWjZOU3dCaGwr?=
 =?utf-8?B?Y2d6NzhlamJGeFdpOWl4Qk9yTGZ6U0J4Mk1PM3RCS2RzanJNOEVab2tiRzZB?=
 =?utf-8?B?R1BweXVzQ28vUVdGZnNOenRiRkczcVhmeDczK1NOS3MvRzZvaFVmei8rbGNs?=
 =?utf-8?B?RDBTSCtWY1JMb0xFTjhpRzFlSlV6MEJ6SkJnVVB3dElHUjNGbGNJczV1dGwy?=
 =?utf-8?B?YmFndmRPU2NmeFhZTXBlWE1hNU1RVzAxeTJIVlp2QUMwOEJTZXNMWWpNdlNn?=
 =?utf-8?B?MVc5SXkzN1kzSGxKemZNOEoyaEg5Vmdma21ub2lGYnRMeE1UQ1RtckxrVTFN?=
 =?utf-8?B?ZXhqVkRKd1pWS3VwaVNWdkdYcm9PaURWcVZWMEZ6RkJxMkRlYUNLM3EyTXY3?=
 =?utf-8?B?aW9sTXNENDF5MlRwbTdYNERsYnNkMzBEcmR4TnU5aU5uakFWNXpwWUlCNVl3?=
 =?utf-8?B?RnA0THV1OEdQdW9oLzJRb0psUC9YbGl3NTZnTTJpeTJrK0dOa2MxWDlYbDM1?=
 =?utf-8?B?UjNMMXBQeWlRcVA2YzN0RnRXa2kvSk1SOFdwTlRiSC9yZUdmeUpTYWM5TlZi?=
 =?utf-8?B?dUlCZUtSUXdGQmNQRkYrYVoyWVZrT2VuQmN0ejVWSXJWNDMzR1ZZQWxSclRV?=
 =?utf-8?Q?B8peCQD17VHCiBg0vzcNMbTRsi+QfLyg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHg2d3dsNmNISG5hZnd0YlhYeGlsSXIvN2xuMDIwbTlxbjE3SnRyWDJjU0w2?=
 =?utf-8?B?ZTI1aU5DTi82K2ZkaE1UZG1IUitlcWZ6dTJIWFgwQmpwMWJyQzRWc2J1eits?=
 =?utf-8?B?cU5DQnhXVlpGcXczNHRaMllhT2FaNmI4eFNQZ1E3STh2VlRUcnJsLzNmd1BJ?=
 =?utf-8?B?aHIxbDZzL3ZuaWlvY3hpUVNCaUgrdXlpME1TTjFTSW90TjNOTTg0TEFXNDA0?=
 =?utf-8?B?NHc0SXBKSTllbFRPVlRjdzlKWGIrWEdBcXIxNUx5SzM1MEo4akVxNzQ0YjM3?=
 =?utf-8?B?bUR1YzhyQVl6K1ZZZmU3UUNMUnRYMWxiL2JkK3JJWllCQ0J1VVYxR05oQTNp?=
 =?utf-8?B?RGh1NGc5Z05WU2xuTk90RVQxSnpzaGRZaWhCbVlNK3ZqMnVaSEx4L3R3T09E?=
 =?utf-8?B?K3pXNEQwQzJiaDBKRTFTTXkreVpTTnFXNGlLOWt1K2ladUU1T0dWQ1U5WFhQ?=
 =?utf-8?B?NWx1dlhyTmVpeFY4dVFJM1grNUdVKy96S2dqcW1QdUVlS2xUSVhjZFRNVmJq?=
 =?utf-8?B?bS9MenI2cEp4a3F5VTBackFmS3c0OEpyT2RyRHc2ZEJTeDk3Q0dCQVZNRGR2?=
 =?utf-8?B?ek1Na29pM3NoUnRkNC9YUnFKQklpeDA3amQ4UVhhTlZ5OFNDWTdqR0VGbysr?=
 =?utf-8?B?RFpGNkllemhaTUZSbkxXU2p5UVQ0Z0wwNkFhdC80Y3ZPbEpnYnNwMkk5aHdC?=
 =?utf-8?B?OVpqdkJadWM5UFNMaWNzbm5EZ2MrVlNYdHIvZWhrZXkzSCtXV09iSGFvRUFk?=
 =?utf-8?B?SXVMWEdxcVlRak1CYjd3aERoUk03a3JpeXZsUXVtRTZYNW1lUXpJOFZEeFA0?=
 =?utf-8?B?SU9hRjNnT1pzZEVDRUtIQVMzVGkvcEc4dnVrN3NoMkxLeXVFRHE0WTliTURC?=
 =?utf-8?B?a1l1THN2djZEREQvZE40eXl1YXJaSG5TMjMzejhRaXJpL1FpMEZSNkVSdlZn?=
 =?utf-8?B?aDR1QW9NZCtieHhyS0VqUTNidWExc1BvTm54ZXM1Q1gxU0dCMzZTRGJsbjNu?=
 =?utf-8?B?SUVsSmRDMkVPM0dFSUV3SzVyTkIrSFVzZktqZFVvMzQybEdWaG03blRteG5o?=
 =?utf-8?B?L3NrS2pjcitQMUJlV3YrNXV3MVhaMDN4NUJnbnM1VjBwSkExc0VFdnVUL21B?=
 =?utf-8?B?V0ZQd01CNUJYRHV4M2U3cXZWQTJRWFF0WXBGaWMyQXdaTENhZ0F1YWN2N0tO?=
 =?utf-8?B?TjJVcWg2ckFNalBYcFRvWFV4Y2xmWDN5bDVXcUZXOUhVQVJxMDRQWlZFVTh0?=
 =?utf-8?B?NHZLc1ZpcnltbmlKcGE0TmxjUlZaeFljRUhUQ2xrYy9qV1pvSUhBaElvanFO?=
 =?utf-8?B?L3NLT2srazVYUXByNWRqcE9ybjd5VHQ3b21pelZGbWdsZ2IvbXIyWnpDaHNu?=
 =?utf-8?B?RGFFZVVrbmE1VkRwRnVGQnppbGlsTklvREdFcFV6cVRGVmZvSFR4WW9QanMz?=
 =?utf-8?B?eVBZM0tVcWlQRHJqWHYxTWFhSXFEaVFibVRPaHU1QXNsUWVKb0orTzUvY2Qw?=
 =?utf-8?B?UTM4SXdzOGRyNjcvQmhEd3Vkdy9MeXFmYm9zOXlyYTRZWTgyWnhFTmJjeExR?=
 =?utf-8?B?eWJRczdLaHVUL0NGZXplODRodVJaVSthZVdIMjVxdnZwNFkxa2l5YXVDZkxU?=
 =?utf-8?B?d2V6bXQwVXI4L0NBektnQ3B6WDFkcGZCWldSNk40Z29HZmd1RU9RK3Bpb1FQ?=
 =?utf-8?B?bzZXckRCdjZmNGhzaXg2YnpjVkZKc1lORVNBKzVXSDAzNE1rWGxaZ3F5UzR3?=
 =?utf-8?B?VWMwRENSQ0tPT0Z2djBGa0x3QjEzNkYrQ0hsd204V0hTMWZqRCsvVzVidDBK?=
 =?utf-8?B?ZzN2bVFoOU4wbVpucHhIRzd6NjRmODh3WFRmWDRuL21iNWNDSWhMdmZKbEdK?=
 =?utf-8?B?akxCWU8zTVdSM2lNVCtld2xHY2JKRkcvQUYwNnVBZDlWZW9yb1dHQzBELzE1?=
 =?utf-8?B?N0dXbDc0allwQ2NmY09NRGdVYkpJMlYvKy9lNXVCOGxHU28xdjN0WmkyRlZ3?=
 =?utf-8?B?Q3pyZ1R6RUlGWnVsazR0NVc5dmQ0RGZibVVMeUFWVm5iRTNXRXVhQk03dVh4?=
 =?utf-8?B?OHMzb2FUS0VNdWVJK2t0MWRoS2FUdnBQZGR0U28vUmFrNmNhMGtuTDhudVRY?=
 =?utf-8?Q?6l/HQwvdymGtbe+xXLqk0V1qi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fc7d0e-3d68-40b6-9f24-08de1ba6ce0e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:33:57.2056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BI444u+x7NBt/EDE9HTs9XE9sl7gAQaNGMjdJKFcoWawoDWVyhI1zKHu0ota2xkb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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

On 11/3/25 23:23, Timur Kristóf wrote:
> Use the GART helper function introduced in the previous commit
> to map the VRAM pages of the transfer window to GART.
> No functional changes, just code cleanup.
> 
> Split this into a separate commit to make it easier to bisect,
> in case there are problems in the future.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Could also be squashed into commit #4. Otherwise commit #5 just adds unused functionality.

But not a must have from my side.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index e226c3aff7d7..84f9d5a57d03 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -188,7 +188,6 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
>  	struct amdgpu_job *job;
>  	void *cpu_addr;
>  	uint64_t flags;
> -	unsigned int i;
>  	int r;
>  
>  	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
> @@ -254,16 +253,9 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
>  		dma_addr = &bo->ttm->dma_address[mm_cur->start >> PAGE_SHIFT];
>  		amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags, cpu_addr);
>  	} else {
> -		dma_addr_t dma_address;
> -
> -		dma_address = mm_cur->start;
> -		dma_address += adev->vm_manager.vram_base_offset;
> +		u64 pa = mm_cur->start + adev->vm_manager.vram_base_offset;
>  
> -		for (i = 0; i < num_pages; ++i) {
> -			amdgpu_gart_map(adev, i << PAGE_SHIFT, 1, &dma_address,
> -					flags, cpu_addr);
> -			dma_address += PAGE_SIZE;
> -		}
> +		amdgpu_gart_map_vram_range(adev, pa, 0, num_pages, flags, cpu_addr);
>  	}
>  
>  	dma_fence_put(amdgpu_job_submit(job));

