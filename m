Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2A6C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 09:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE9C10E673;
	Wed, 26 Mar 2025 09:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5D1YLp4D";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C0310E673
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 09:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tc9FOh20gyWLHxXvpg++WrqJIHeJguU6BwOfrHpsamY+WHLczpgST4qbOpgSrXxHurDklSl92N91P9SJcJ4Itk5DtywoqGoqkRIWO5k3nWDxuAY1Gb16Wia9Yovt0xPHTeAyjWrMbpewPPzTokP/Z+jpgNcGP0jCKAHPlA7dpglDcKh/Zl9xxmAcFdIoxh2mSWGT67fmSQy3ikDFxE6isW7wErYg5WnZQshHx0KgPkAs8KEtnptCxdFZubGO3Omi8lfezY4raHdbGt9q/TYoD7cdHTakZ74QX+0qagPnzC140U+aJLNfyPbu5X3ULe5XyYiI8H0RHuNDgBEMLOdfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+k+Tbo37B5cuh1njT8uwU96NOHGTlZES1fkUjro6qI=;
 b=SrrCw2qWr1J4viiT4UfQUGnZW9owJ62CWHArAzVUd8mz5BSyjRdKOdOPGTKR1z/mKEI7EAl6Sax/haPbJBfao+81qEsEeaGgaYMcC/dYKAw5sJ0adOlDzNBMpVmwB6/IeNl7MbISV5c/TPXx4IGurK5Ndp/INXyjQmErN9bvP0bLTmtJANgPl321U4sfNHqzAXuDa1nGsDErJl/ntP3Fqxx5MN0DFspsHSvhNzwSOf2KwSlVYrioGfIP/6Q16LYcp8nK/Z8xIF58wMV1KvQ3qG9NgTjzegrkTXOp20PgGSgjEcrq+s1SqDir+s4kPWl+Qw1l54hq3CeqIQAG7YYH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+k+Tbo37B5cuh1njT8uwU96NOHGTlZES1fkUjro6qI=;
 b=5D1YLp4D+aH/ApmZCKcII5vnhFhfLWmyYPZfPvZY6z2rqTNzff5IRN51n+D0aZ2xVD0EG6Yc/Gd956u4E9LHDnKb5CVzSMl+i1nYWBf6XB5b5Cp1kl6shbBdDtNQdq5ERRmy42l4Ye4b3KH79F7L3bNFusfOPZaBKYv4Ln9ZdUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 09:04:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Wed, 26 Mar 2025
 09:04:18 +0000
Message-ID: <4d89eb35-f29b-4f13-8a43-34b3a4c2316d@amd.com>
Date: Wed, 26 Mar 2025 10:04:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] Documentation/gpu: Add explanation about AMD Pipes
 and Queues
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Melissa Wen
 <mwen@igalia.com>, =?UTF-8?Q?=27Andr=C3=A9_Almeida=27?=
 <andrealmeid@igalia.com>, =?UTF-8?Q?=27Timur_Krist=C3=B3f=27?=
 <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org,
 kernel-dev@igalia.com
References: <20250325172623.225901-1-siqueira@igalia.com>
 <20250325172623.225901-5-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250325172623.225901-5-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f8f093-d3db-4df8-8e24-08dd6c4530d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUlqeUZXbFB6T3FnWFhNTXVWY0s3T29YWjhkU0ZZMm9zYVhOKzdtT1dQdUU5?=
 =?utf-8?B?cTdxVnVqZmVYRGtqZUlpc1g0MDZGeExjZW5UTms2UHhpb24zQ2FXMExSdjE4?=
 =?utf-8?B?UWNBbmVyNCtvZGErcWpVOHZpVkluNHJkQlNNR3R1Q3pRalVPdWpaREZmOVA3?=
 =?utf-8?B?V2ZFWWo3TXE5NmlZSEdrNUFMcDlsSTZZVzhXYVU2Y2VROHBkVEVRYkpUWFoy?=
 =?utf-8?B?dUh2NGJVVDEwU01iRDhsV2pLUEptaU9PdmxQd2FKcDV3NkRuaVNHbG9qNnIx?=
 =?utf-8?B?M2I4UHdycEV3S0RXdXlnM0c5M2kzbHpCaXkrOHBUQktxV1NsY3RGQVFBZFdx?=
 =?utf-8?B?OTlCc1ZsTVVvR3AyVVBscEZaQUpmb3FPYlhOWEF6V3dlZFg2L1dCQzRqU0d4?=
 =?utf-8?B?QTR4RFdNb2N3KzJLYlUrZlpZd3NaYlBLaU94K1A4Ykl1TWljWEkvK2tuYW45?=
 =?utf-8?B?bWJhWXRobW00OWVxZFR4NmdUd1JCaVNkVGd2ODBzYW9vdS9sYlllUmkwZFB0?=
 =?utf-8?B?cWNPUHdPdTJmV1dtYWRhek5tV3N6dCtjWklValF1cVpNaXNzQmJrQU5peWY5?=
 =?utf-8?B?SmFyZjdtelFGNG9UWU9tcVpYZXZSWllBakRmcW9aQmhQUi9ma0NTL3VQQTdv?=
 =?utf-8?B?YXlIbHFGeGFiYTVva0Q0M2NTc3FOSnQ0WVhaUGZRbFZGcm52MjVIeEtsOW9P?=
 =?utf-8?B?azJDVkRmZW4rMkZrTjVoekVrMG1sNVlWd1JCb0NyS29seUdaNXd3YVIvZVhj?=
 =?utf-8?B?ZW9wSUR3OHJJQjUrY2lLdExXd0NlRWdyVzlSTjhtbUhaZGVVNXhPNE5NL1JU?=
 =?utf-8?B?VU5UU3J2QWJ3V2h0Uy9URWloSDVUK0NZaE5QRG1rK2RnbTFOdm5Fa1BSQWVZ?=
 =?utf-8?B?My9lcU4wcGVNenZMUGcyL0xTR1RmaHpnbFNJeDRPS0ZCZE5GZkZLRDMvZjcy?=
 =?utf-8?B?VVJjVGZtdXFtVnEzdDFLcDdjejA2SE5tOWthNXJnMGpGb3NjUUtiMEhWNmFY?=
 =?utf-8?B?NEI2bm5wRmFRcGdabitWc05hM1N6bGlIbmxGM2dkemFyZG1OL0VtZ1I4c3VF?=
 =?utf-8?B?UndheGhWaklOWCtnZVVDWnlGZldPTm4xd2hDcDVqbisrY3daWnpTenZFNWRG?=
 =?utf-8?B?dmVhbE01L0xyRENFWkNzaVhWWWoxdHJRcWRKVjgrUTRPNlBtQUdFcnFFaDNl?=
 =?utf-8?B?MjM3M0FuZjd0aEdUTFFVZERBTEI5YlluWTI0YkdncGZORThrakhkY3RjREww?=
 =?utf-8?B?MmhxcVFhamlscUZ5UGQwWHZKWnZJbTkzS09lYk5QZHNScndyQWthZ1QvYmls?=
 =?utf-8?B?aXFNZVdoUGVYbUowSWdXa0NIbjhBMjZ1RzNSRXdlT2FTYXc1L0xKenVYUnZx?=
 =?utf-8?B?QjUyNXorbVE2NzVQQ3drQXJ6V2I5d054bk1pRjU0M0JzMENRUUJuTG9VWUJT?=
 =?utf-8?B?MDcyNXg4YzFleGlLY1pwZk42N2dhaFAxQkxyZDZDeWVYQzl1NnpRbExLS2xz?=
 =?utf-8?B?NVFpTGdNSnlwOXlQZVZINnpadHdoQnVDUFU5QjZBR3ZKOWVkanJGNDJ5NHVQ?=
 =?utf-8?B?WkExRHNiNXV5cENEaFU4M2VOcDQ3MEJwMUYxQVJnUHp5Y2FhZGEzaEc1bmVD?=
 =?utf-8?B?QlRvdWpaZCt0ZDU1czY1ZTY3T2wvSVVBbk4rbTBOcTgzc21NSDJGeU04eTRo?=
 =?utf-8?B?YmFmZ2lzcG52K25PdlJxT1ZZL0haeFVrUDAvM29XQVF2bnUzaUVPNWw2WUlx?=
 =?utf-8?B?dGdvUkVLM0EyeVNPdlhvNWJwVUdSb1IvM1BobWtzeVVKNGlsc1lzRnBZNjNE?=
 =?utf-8?B?R0ltR0cyeFNqMXZFYmtlZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHdMV29KUjdDTlcrRTFvR21UTHY1Ky9xUmpiUHpRb3FhaGxJS0lFNW1IQzRD?=
 =?utf-8?B?YWR3c08rQUxLMlZWcVRoUVFqd0tpMHFkZHlVMEd5UWdybHhkWnh4UjhXTW8y?=
 =?utf-8?B?ZW1qNFdKUmpnSTBEL2RQc1diTjJINWFTZXhSWktDRzgzY1k1WUFCbUduVWZL?=
 =?utf-8?B?SERsRDNPVGdsKys1dVV0ajREMlV4WlVyYnBuRWozejJ0S3dSZGNjZ2JKYkJi?=
 =?utf-8?B?aVFSUDYreGlMSkNzUitIdHdSVStpamFGRWR3eDhNSkIreFIyVEVaMCtaYXlv?=
 =?utf-8?B?dDEvc0JnL3FZY05GSHNib2pLS0gwY3VRRHFlTElySS9nanpDT2NyaXZMQTdz?=
 =?utf-8?B?UGw2b1JXNlM4UVRrYjZzV3EySDcwVDF3T2c3ZVYzWDA5U25iOXFxa0lSNHFi?=
 =?utf-8?B?VFNiZkczRnhMRGg5eDNnMjdoc0tiZGhUNHNPSEx2eG9uUGxWT2tBazJYWVlm?=
 =?utf-8?B?RjVjUFdMZzNQYUZTNmx3OWdOdTMzbkVPd25uNGFUWW5rN0orNWdHTVJ2VW9H?=
 =?utf-8?B?SUJMT1FFaG02Y2N2a2s2YXgwQjJlb1F6eE4xbnVlWVJQSUhGRjlIR0IreXhG?=
 =?utf-8?B?WTVUSW9WTzFUTll5MWhEckZTRTBTNDl4Rm0xNmxjNy9xL3hwVFo3OGlDa3pM?=
 =?utf-8?B?T1JhdUY5cHJBcWRicDVyUk9HUXBjNWhjODhJdDVXQXhTTmIycldEaUtwUXF0?=
 =?utf-8?B?Sk5WWU1sNGFOdjVCTG42VEFwZkY4NmZQd0Z3UjRuKy9FSVpYYTIrVU90TnRR?=
 =?utf-8?B?c24xSWVYZFhuZEp2LzAvdGtFZjhsckdjUkRhQThMblRZTWlBZEh5Y1o4NVF3?=
 =?utf-8?B?d0FWbURTN0NoVnl5Zkg3ZlVmMS9lc0Jhank5NUk5K1lNNExMcHI5N1BybG0r?=
 =?utf-8?B?SEhOZWFRQmhDcHM3cTFJSERBR082UU13MzNsbmVSS2t0MWpuZkJjbWNpc0hP?=
 =?utf-8?B?SzZaT1ZkVTdVWkZrWDZNUVVPdGFFQVQ3OTBvTnNlVmpiT2FmZEVZeVZSSHU1?=
 =?utf-8?B?VEhyQngza3gvRnFyL3BWZVZObWtDSHJKcHVoVStkYml3TnBZSy9BSHRpMVE4?=
 =?utf-8?B?QkU0ZkFmdjR6YS9TYWlnYjhVZkNudGVzZ2xKWjI1WkRjcDVoKzVzSkIxTE40?=
 =?utf-8?B?SjVzZWVsQmVKVVZ4eFZYUFc2Y050WlU5dlNFWGpVMlpsV1JhY0pTQm9PNlZQ?=
 =?utf-8?B?bm9PdVRkVmhDYUZKbUlyRDNVdXQ5YWJYZmtxb2MxVm1YV2Jkd29JYnVRYzJl?=
 =?utf-8?B?aldxYjZBUnBoZmdoNi9zNkc0RDBwcUY4cHVsRFhPK0h5Y25IZHQ0NmZGWlNB?=
 =?utf-8?B?NXNOKy9LWld6VXNNdHY0Z2UxMW82aFZxS21LWkdGR3VidjRjRzlwTGFDVCtC?=
 =?utf-8?B?dkc4NWwzS25HT0RVLzhKNWlwSFg0VjZ3Qlh6MWpOdTBPVmp0YWFYN1ZOR2dz?=
 =?utf-8?B?NlBiN2pPQm1PUStocVI3UWlEeE1tQlAxNzFyS3JSR21qZlcyREJTZXVIdGI3?=
 =?utf-8?B?eEo2OWJIRWZ4NHdaWlpqcXhJYk1VdWU1T2FTUnZoSVUzME9PYVZ0TVJOSEg4?=
 =?utf-8?B?RFJsaHB6Qkc5bE0rMDVReldLYlJQaGd2Q2doMUVEUlRzaEJoNlFtQkdjWHlp?=
 =?utf-8?B?Z0VNTllYNy84Yi9sRFZGU3A3YU1QUWpERkU0QTErRnd3YWRidzJNTkNaay9B?=
 =?utf-8?B?Y0k3eFRrM1hENDRtOUFPN2dUMnBuWDA4U3NJenhTQVVEelNJS3VpTG1RZW8y?=
 =?utf-8?B?My9INFNmVWF6dm1SVFhUYjFITWxYVWFDa0dqL0FRQW5lRFFINkhTZWVkenBZ?=
 =?utf-8?B?MTlDVUM3Tjl0SmZXeWFDdGhHMm5xRDRSZFpkSWcva1N1NVZ2ODI5RmVCdG04?=
 =?utf-8?B?KzBzSHVBbDVXbjR4a1pLWmt4bVJkb1M5angxb293Zk1GRVdJeWZubzNRb2lE?=
 =?utf-8?B?RnIyZGpsZUgrWGFQRUE2RWc4M1p4N3FaT0c0MTluSmdJQ0l4V2dQZHpqRXFM?=
 =?utf-8?B?WHNLSTFETFN2dEEwN2sydTE5V0pDcjNrcXdCSGNXU0ZCdkFLdDR1L0pJWU9o?=
 =?utf-8?B?aStUNXpSSkdxOGl0ejRrVjcvY2NlN29mTW8xT2x6YTkvQW90Um04Z0g0OURw?=
 =?utf-8?Q?WkWeC++A9EDwab1TuX18J2YWj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f8f093-d3db-4df8-8e24-08dd6c4530d4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 09:04:18.8928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rodB3TURzSlJJKK4yqIlcwpGI6neYXQZU3kEWhy5vqqQ1LZfVroLiVa3tdaBOBD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
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

Am 25.03.25 um 18:18 schrieb Rodrigo Siqueira:
> Pipes and Queues are two common vocabulary that pervades discussions
> around amdgpu core features. The definition and explanation of those
> components are spread around multiple places in the code, mailing list,
> and Gitlab, which sometimes leads to the wrong interpretation of these
> concepts. This commit attempts to centralize the definition and
> explanation of Pipe and Queue from amdgpu perspective in a kernel doc.
> Most of the information in this doc was derived from:
>
> - https://lore.kernel.org/amd-gfx/CADnq5_Pcz2x4aJzKbVrN3jsZhD6sTydtDw=6PaN4O3m4t+Grtg@mail.gmail.com/T/#m9a670b55ab20e0f7c46c80f802a0a4be255a719d
> - https://gitlab.freedesktop.org/mesa/mesa/-/issues/11759
>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>

Oh that's really nice to have, especially since I'm constantly mixing up the terms queue and pipe as well :)

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  Documentation/gpu/amdgpu/driver-core.rst      |   49 +
>  .../gpu/amdgpu/pipe_and_queue_abstraction.svg | 1279 +++++++++++++++++
>  2 files changed, 1328 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/pipe_and_queue_abstraction.svg
>
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
> index 32723a925377..746fd081876f 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -98,6 +98,55 @@ RLC (RunList Controller)
>      The name is a vestige of old hardware where it was originally added
>      and doesn't really have much relation to what the engine does now.
>  
> +
> +GFX, Compute, and SDMA Overall Behavior
> +=======================================
> +
> +.. note:: For simplicity, whenever the term block is used in this section, it
> +   means GFX, Compute, and SDMA.
> +
> +GFX, Compute and SDMA share a similar form of operation that can be abstracted
> +to facilitate understanding of the behavior of these blocks. See the figure
> +below illustrating the common components of these blocks:
> +
> +.. kernel-figure:: pipe_and_queue_abstraction.svg
> +
> +In the central part of this figure, you can see two elements, one called
> +**Pipe** and another named **Queues**; it is important to highlight that Queues
> +must be associated with a Pipe and vice-versa. Every specific hardware may have
> +a different number of Pipes and, in turn, a different number of Queues; for
> +example, GFX 11 has two Pipes and two Queues per Pipe.
> +
> +Pipe is the hardware that processes the instructions available in the Queues;
> +in other words, it is a thread executing the operations inserted in the Queue.
> +One crucial characteristic of Pipes is that they can only execute one Queue at
> +a time; no matter if the hardware has multiple Queues in the Pipe, it only runs
> +one Queue per Pipe. When a queue is running in the Pipe, it is said that the
> +Queue is **Active**.
> +
> +Pipes have the mechanics of swapping between queues at the hardware level.
> +Nonetheless, they only make use of Queues that are considered mapped. Pipes can
> +switch between queues based on any of the following inputs:
> +
> +1. Command Stream;
> +2. Packet by Packet;
> +3. Other hardware requests the change (e.g., MES).
> +
> +Queues within Pipes are defined by the Hardware Queue Descriptors (HQD).
> +Associated with the HQD concept, we have the Memory Queue Descriptor (MQD),
> +which is responsible for storing information about the state of each of the
> +available Queues in the memory. The state of a Queue contains information such
> +as the GPU virtual address of the queue itself, save areas, doorbell, etc. The
> +MQD also stores the HQD registers, which are vital for activating or
> +deactivating a given Queue.
> +
> +The Queue-switching process can also happen with the firmware requesting the
> +preemption or unmapping of a Queue. The firmware waits for the HQD_ACTIVE bit
> +to change to low before saving the state into the MQD. To make a different
> +Queue become active, the firmware copies the MQD state into the HQD registers
> +and loads any additional state. Finally, it sets the HQD_ACTIVE bit to high to
> +indicate that the queue is active.
> +
>  Driver Structure
>  ================
>  
> diff --git a/Documentation/gpu/amdgpu/pipe_and_queue_abstraction.svg b/Documentation/gpu/amdgpu/pipe_and_queue_abstraction.svg
> new file mode 100644
> index 000000000000..0df3c6b3000b
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/pipe_and_queue_abstraction.svg
> @@ -0,0 +1,1279 @@
> +<?xml version="1.0" encoding="UTF-8" standalone="no"?>
> +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> +
> +<svg
> +   width="395.47891mm"
> +   height="234.73715mm"
> +   viewBox="0 0 395.47891 234.73714"
> +   version="1.1"
> +   id="svg1"
> +   inkscape:version="1.4 (e7c3feb100, 2024-10-09)"
> +   sodipodi:docname="pipe_and_queue_abstraction.svg"
> +   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
> +   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> +   xmlns="http://www.w3.org/2000/svg"
> +   xmlns:svg="http://www.w3.org/2000/svg">
> +  <sodipodi:namedview
> +     id="namedview1"
> +     pagecolor="#ffffff"
> +     bordercolor="#000000"
> +     borderopacity="0.25"
> +     inkscape:showpageshadow="2"
> +     inkscape:pageopacity="0.0"
> +     inkscape:pagecheckerboard="0"
> +     inkscape:deskcolor="#d1d1d1"
> +     inkscape:document-units="mm"
> +     inkscape:zoom="1.6489689"
> +     inkscape:cx="713.17296"
> +     inkscape:cy="466.65527"
> +     inkscape:window-width="3840"
> +     inkscape:window-height="2083"
> +     inkscape:window-x="0"
> +     inkscape:window-y="0"
> +     inkscape:window-maximized="1"
> +     inkscape:current-layer="layer1" />
> +  <defs
> +     id="defs1">
> +    <marker
> +       style="overflow:visible"
> +       id="Dot"
> +       refX="0"
> +       refY="0"
> +       orient="auto"
> +       inkscape:stockid="Dot"
> +       markerWidth="1"
> +       markerHeight="1"
> +       viewBox="0 0 1 1"
> +       inkscape:isstock="true"
> +       inkscape:collect="always"
> +       preserveAspectRatio="xMidYMid">
> +      <path
> +         transform="scale(0.5)"
> +         style="fill:context-stroke;fill-rule:evenodd;stroke:none"
> +         d="M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
> +         sodipodi:nodetypes="sssss"
> +         id="path110" />
> +    </marker>
> +    <marker
> +       style="overflow:visible"
> +       id="marker109"
> +       refX="0"
> +       refY="0"
> +       orient="auto-start-reverse"
> +       inkscape:stockid="Stylized triangle arrow"
> +       markerWidth="1"
> +       markerHeight="1"
> +       viewBox="0 0 1 1"
> +       inkscape:isstock="true"
> +       inkscape:collect="always"
> +       preserveAspectRatio="xMidYMid">
> +      <path
> +         transform="scale(0.5)"
> +         style="fill:context-stroke;fill-rule:evenodd;stroke:context-stroke;stroke-width:1pt"
> +         d="m 6,0 c -3,1 -7,3 -9,5 0,0 0,-4 2,-5 -2,-1 -2,-5 -2,-5 2,2 6,4 9,5 z"
> +         id="path109" />
> +    </marker>
> +    <marker
> +       style="overflow:visible"
> +       id="ArrowTriangleStylized"
> +       refX="0"
> +       refY="0"
> +       orient="auto-start-reverse"
> +       inkscape:stockid="Stylized triangle arrow"
> +       markerWidth="1"
> +       markerHeight="1"
> +       viewBox="0 0 1 1"
> +       inkscape:isstock="true"
> +       inkscape:collect="always"
> +       preserveAspectRatio="xMidYMid">
> +      <path
> +         transform="scale(0.5)"
> +         style="fill:context-stroke;fill-rule:evenodd;stroke:context-stroke;stroke-width:1pt"
> +         d="m 6,0 c -3,1 -7,3 -9,5 0,0 0,-4 2,-5 -2,-1 -2,-5 -2,-5 2,2 6,4 9,5 z"
> +         id="path108" />
> +    </marker>
> +    <marker
> +       style="overflow:visible"
> +       id="ArrowWide"
> +       refX="0"
> +       refY="0"
> +       orient="auto-start-reverse"
> +       inkscape:stockid="Wide arrow"
> +       markerWidth="1"
> +       markerHeight="1"
> +       viewBox="0 0 1 1"
> +       inkscape:isstock="true"
> +       inkscape:collect="always"
> +       preserveAspectRatio="xMidYMid">
> +      <path
> +         style="fill:none;stroke:context-stroke;stroke-width:1;stroke-linecap:butt"
> +         d="M 3,-3 0,0 3,3"
> +         transform="rotate(180,0.125,0)"
> +         sodipodi:nodetypes="ccc"
> +         id="path1" />
> +    </marker>
> +    <marker
> +       style="overflow:visible"
> +       id="Triangle"
> +       refX="0"
> +       refY="0"
> +       orient="auto-start-reverse"
> +       inkscape:stockid="Triangle arrow"
> +       markerWidth="1"
> +       markerHeight="1"
> +       viewBox="0 0 1 1"
> +       inkscape:isstock="true"
> +       inkscape:collect="always"
> +       preserveAspectRatio="xMidYMid">
> +      <path
> +         transform="scale(0.5)"
> +         style="fill:context-stroke;fill-rule:evenodd;stroke:context-stroke;stroke-width:1pt"
> +         d="M 5.77,0 -2.88,5 V -5 Z"
> +         id="path135" />
> +    </marker>
> +    <marker
> +       style="overflow:visible"
> +       id="ArrowWideHeavy"
> +       refX="0"
> +       refY="0"
> +       orient="auto-start-reverse"
> +       inkscape:stockid="Wide, heavy arrow"
> +       markerWidth="1"
> +       markerHeight="1"
> +       viewBox="0 0 1 1"
> +       inkscape:isstock="true"
> +       inkscape:collect="always"
> +       preserveAspectRatio="xMidYMid">
> +      <path
> +         style="fill:context-stroke;fill-rule:evenodd;stroke:none"
> +         d="m 1,0 -3,3 h -2 l 3,-3 -3,-3 h 2 z"
> +         id="path71" />
> +    </marker>
> +  </defs>
> +  <g
> +     inkscape:label="Layer 1"
> +     inkscape:groupmode="layer"
> +     id="layer1"
> +     transform="translate(149.03517,55.110629)">
> +    <circle
> +       style="fill:#ffeeaa;fill-opacity:1;stroke:#1a1a1a;stroke-width:0.733436;stroke-dasharray:none;stroke-dashoffset:0"
> +       id="path98"
> +       cx="-35.757576"
> +       cy="-10.495151"
> +       r="44.24876" />
> +    <rect
> +       style="fill:none;stroke:#000000;stroke-width:0.878057;stroke-dasharray:none"
> +       id="rect1"
> +       width="167.79619"
> +       height="24.831829"
> +       x="14.21942"
> +       y="57.862854" />
> +    <g
> +       id="g11"
> +       transform="translate(24.021362,-46.545299)">
> +      <rect
> +         style="fill:none;stroke:#006680;stroke-width:0.459999;stroke-dasharray:none"
> +         id="rect2"
> +         width="131.09708"
> +         height="5.8163381"
> +         x="23.245802"
> +         y="107.16314" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 37.884707,107.26337 v 5.53565"
> +         id="path2"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 52.466233,107.26337 v 5.53565"
> +         id="path3"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 67.047758,107.26337 v 5.53565"
> +         id="path4"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 81.629283,107.26337 v 5.53565"
> +         id="path5"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 96.210809,107.26337 v 5.53565"
> +         id="path6"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 110.79233,107.26337 v 5.53565"
> +         id="path7"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 125.37386,107.26337 v 5.53565"
> +         id="path8"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 139.95538,107.26337 v 5.53565"
> +         id="path9"
> +         sodipodi:nodetypes="cc" />
> +      <text
> +         xml:space="preserve"
> +         style="font-size:3.175px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         x="86.713425"
> +         y="110.1963"
> +         id="text11"><tspan
> +           sodipodi:role="line"
> +           id="tspan11"
> +           style="stroke:#006680;stroke-width:0.5"
> +           x="86.713425"
> +           y="110.1963">. . .</tspan></text>
> +    </g>
> +    <g
> +       id="g18"
> +       transform="translate(24.021362,-32.25779)">
> +      <rect
> +         style="fill:none;stroke:#006680;stroke-width:0.459999;stroke-dasharray:none"
> +         id="rect11"
> +         width="131.09708"
> +         height="5.8163381"
> +         x="23.245802"
> +         y="107.16314" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 37.884707,107.26337 v 5.53565"
> +         id="path11"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 52.466233,107.26337 v 5.53565"
> +         id="path12"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 67.047758,107.26337 v 5.53565"
> +         id="path13"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 81.629283,107.26337 v 5.53565"
> +         id="path14"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 96.210809,107.26337 v 5.53565"
> +         id="path15"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 110.79233,107.26337 v 5.53565"
> +         id="path16"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 125.37386,107.26337 v 5.53565"
> +         id="path17"
> +         sodipodi:nodetypes="cc" />
> +      <path
> +         style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         d="m 139.95538,107.26337 v 5.53565"
> +         id="path18"
> +         sodipodi:nodetypes="cc" />
> +      <text
> +         xml:space="preserve"
> +         style="font-size:3.175px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         x="86.713425"
> +         y="110.1963"
> +         id="text18"><tspan
> +           sodipodi:role="line"
> +           id="tspan18"
> +           style="stroke:#006680;stroke-width:0.5"
> +           x="86.713425"
> +           y="110.1963">. . .</tspan></text>
> +    </g>
> +    <text
> +       xml:space="preserve"
> +       style="font-size:3.175px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +       x="113.37768"
> +       y="68.463142"
> +       id="text19"><tspan
> +         sodipodi:role="line"
> +         id="tspan19"
> +         style="writing-mode:tb-rl;stroke-width:0.5"
> +         x="113.37768"
> +         y="68.463142">. . .</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="25.005701"
> +       y="55.308445"
> +       id="text844-2-9"><tspan
> +         sodipodi:role="line"
> +         x="25.005701"
> +         y="55.308445"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan2868">Pipe[0]</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-74.441521"
> +       y="63.075123"
> +       id="text844-2-9-4"><tspan
> +         sodipodi:role="line"
> +         x="-74.441521"
> +         y="63.075123"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan2868-7">MQD</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="30.264952"
> +       y="65.490654"
> +       id="text20"><tspan
> +         sodipodi:role="line"
> +         x="30.264952"
> +         y="65.490654"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan20">Queue[0]</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="30.264952"
> +       y="79.249001"
> +       id="text21"><tspan
> +         sodipodi:role="line"
> +         x="30.264952"
> +         y="79.249001"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan21">Queue[n]</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="30.264952"
> +       y="71.84066"
> +       id="text22"><tspan
> +         sodipodi:role="line"
> +         x="30.264952"
> +         y="71.84066"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan22">...</tspan></text>
> +    <g
> +       id="g71"
> +       transform="translate(-23.283342)">
> +      <rect
> +         style="fill:#ffffff;fill-opacity:0;stroke:#000000;stroke-width:0.5;stroke-dasharray:0.5, 0.5;stroke-dashoffset:0"
> +         id="rect67"
> +         width="18.533583"
> +         height="114.96632"
> +         x="250.9435"
> +         y="54.754276"
> +         ry="6.0427966" />
> +    </g>
> +    <rect
> +       style="fill:#1a1a1a;fill-opacity:0;stroke:#000000;stroke-width:0.499999;stroke-dasharray:none;stroke-dashoffset:0"
> +       id="rect68"
> +       width="188.21231"
> +       height="139.5948"
> +       x="4.0113592"
> +       y="37.597778"
> +       ry="0" />
> +    <g
> +       id="g43"
> +       transform="translate(0,40.745853)">
> +      <rect
> +         style="fill:none;stroke:#000000;stroke-width:0.878057;stroke-dasharray:none"
> +         id="rect22"
> +         width="167.79619"
> +         height="24.831829"
> +         x="14.21942"
> +         y="57.862854" />
> +      <g
> +         id="g30"
> +         transform="translate(24.021362,-46.545299)">
> +        <rect
> +           style="fill:none;stroke:#006680;stroke-width:0.459999;stroke-dasharray:none"
> +           id="rect23"
> +           width="131.09708"
> +           height="5.8163381"
> +           x="23.245802"
> +           y="107.16314" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 37.884707,107.26337 v 5.53565"
> +           id="path23"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 52.466233,107.26337 v 5.53565"
> +           id="path24"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 67.047758,107.26337 v 5.53565"
> +           id="path25"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 81.629283,107.26337 v 5.53565"
> +           id="path26"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 96.210809,107.26337 v 5.53565"
> +           id="path27"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 110.79233,107.26337 v 5.53565"
> +           id="path28"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 125.37386,107.26337 v 5.53565"
> +           id="path29"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 139.95538,107.26337 v 5.53565"
> +           id="path30"
> +           sodipodi:nodetypes="cc" />
> +        <text
> +           xml:space="preserve"
> +           style="font-size:3.175px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           x="86.713425"
> +           y="110.1963"
> +           id="text30"><tspan
> +             sodipodi:role="line"
> +             id="tspan30"
> +             style="stroke:#006680;stroke-width:0.5"
> +             x="86.713425"
> +             y="110.1963">. . .</tspan></text>
> +      </g>
> +      <g
> +         id="g38"
> +         transform="translate(24.021362,-32.25779)">
> +        <rect
> +           style="fill:none;stroke:#006680;stroke-width:0.459999;stroke-dasharray:none"
> +           id="rect30"
> +           width="131.09708"
> +           height="5.8163381"
> +           x="23.245802"
> +           y="107.16314" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 37.884707,107.26337 v 5.53565"
> +           id="path31"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 52.466233,107.26337 v 5.53565"
> +           id="path32"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 67.047758,107.26337 v 5.53565"
> +           id="path33"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 81.629283,107.26337 v 5.53565"
> +           id="path34"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 96.210809,107.26337 v 5.53565"
> +           id="path35"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 110.79233,107.26337 v 5.53565"
> +           id="path36"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 125.37386,107.26337 v 5.53565"
> +           id="path37"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 139.95538,107.26337 v 5.53565"
> +           id="path38"
> +           sodipodi:nodetypes="cc" />
> +        <text
> +           xml:space="preserve"
> +           style="font-size:3.175px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           x="86.713425"
> +           y="110.1963"
> +           id="text38"><tspan
> +             sodipodi:role="line"
> +             id="tspan38"
> +             style="stroke:#006680;stroke-width:0.5"
> +             x="86.713425"
> +             y="110.1963">. . .</tspan></text>
> +      </g>
> +      <text
> +         xml:space="preserve"
> +         style="font-size:3.175px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         x="113.37768"
> +         y="68.463142"
> +         id="text39"><tspan
> +           sodipodi:role="line"
> +           id="tspan39"
> +           style="writing-mode:tb-rl;stroke-width:0.5"
> +           x="113.37768"
> +           y="68.463142">. . .</tspan></text>
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="25.005701"
> +         y="55.308445"
> +         id="text40"><tspan
> +           sodipodi:role="line"
> +           x="25.005701"
> +           y="55.308445"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +           id="tspan40">Pipe[1]</tspan></text>
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="30.264952"
> +         y="65.490654"
> +         id="text41"><tspan
> +           sodipodi:role="line"
> +           x="30.264952"
> +           y="65.490654"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +           id="tspan41">Queue[0]</tspan></text>
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="30.264952"
> +         y="79.249001"
> +         id="text42"><tspan
> +           sodipodi:role="line"
> +           x="30.264952"
> +           y="79.249001"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +           id="tspan42">Queue[n]</tspan></text>
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="30.264952"
> +         y="71.84066"
> +         id="text43"><tspan
> +           sodipodi:role="line"
> +           x="30.264952"
> +           y="71.84066"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +           id="tspan43">...</tspan></text>
> +    </g>
> +    <g
> +       id="g64"
> +       transform="translate(0,85.195881)">
> +      <rect
> +         style="fill:none;stroke:#000000;stroke-width:0.878057;stroke-dasharray:none"
> +         id="rect43"
> +         width="167.79619"
> +         height="24.831829"
> +         x="14.21942"
> +         y="57.862854" />
> +      <g
> +         id="g51"
> +         transform="translate(24.021362,-46.545299)">
> +        <rect
> +           style="fill:none;stroke:#006680;stroke-width:0.459999;stroke-dasharray:none"
> +           id="rect44"
> +           width="131.09708"
> +           height="5.8163381"
> +           x="23.245802"
> +           y="107.16314" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 37.884707,107.26337 v 5.53565"
> +           id="path44"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 52.466233,107.26337 v 5.53565"
> +           id="path45"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 67.047758,107.26337 v 5.53565"
> +           id="path46"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 81.629283,107.26337 v 5.53565"
> +           id="path47"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 96.210809,107.26337 v 5.53565"
> +           id="path48"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 110.79233,107.26337 v 5.53565"
> +           id="path49"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 125.37386,107.26337 v 5.53565"
> +           id="path50"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 139.95538,107.26337 v 5.53565"
> +           id="path51"
> +           sodipodi:nodetypes="cc" />
> +        <text
> +           xml:space="preserve"
> +           style="font-size:3.175px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           x="86.713425"
> +           y="110.1963"
> +           id="text51"><tspan
> +             sodipodi:role="line"
> +             id="tspan51"
> +             style="stroke:#006680;stroke-width:0.5"
> +             x="86.713425"
> +             y="110.1963">. . .</tspan></text>
> +      </g>
> +      <g
> +         id="g59"
> +         transform="translate(24.021362,-32.25779)">
> +        <rect
> +           style="fill:none;stroke:#006680;stroke-width:0.459999;stroke-dasharray:none"
> +           id="rect51"
> +           width="131.09708"
> +           height="5.8163381"
> +           x="23.245802"
> +           y="107.16314" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 37.884707,107.26337 v 5.53565"
> +           id="path52"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 52.466233,107.26337 v 5.53565"
> +           id="path53"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 67.047758,107.26337 v 5.53565"
> +           id="path54"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 81.629283,107.26337 v 5.53565"
> +           id="path55"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 96.210809,107.26337 v 5.53565"
> +           id="path56"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 110.79233,107.26337 v 5.53565"
> +           id="path57"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 125.37386,107.26337 v 5.53565"
> +           id="path58"
> +           sodipodi:nodetypes="cc" />
> +        <path
> +           style="fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           d="m 139.95538,107.26337 v 5.53565"
> +           id="path59"
> +           sodipodi:nodetypes="cc" />
> +        <text
> +           xml:space="preserve"
> +           style="font-size:3.175px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +           x="86.713425"
> +           y="110.1963"
> +           id="text59"><tspan
> +             sodipodi:role="line"
> +             id="tspan59"
> +             style="stroke:#006680;stroke-width:0.5"
> +             x="86.713425"
> +             y="110.1963">. . .</tspan></text>
> +      </g>
> +      <text
> +         xml:space="preserve"
> +         style="font-size:3.175px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +         x="113.37768"
> +         y="68.463142"
> +         id="text60"><tspan
> +           sodipodi:role="line"
> +           id="tspan60"
> +           style="writing-mode:tb-rl;stroke-width:0.5"
> +           x="113.37768"
> +           y="68.463142">. . .</tspan></text>
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="25.005701"
> +         y="55.308445"
> +         id="text61"><tspan
> +           sodipodi:role="line"
> +           x="25.005701"
> +           y="55.308445"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +           id="tspan61">Pipe[n]</tspan></text>
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="30.264952"
> +         y="65.490654"
> +         id="text62"><tspan
> +           sodipodi:role="line"
> +           x="30.264952"
> +           y="65.490654"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +           id="tspan62">Queue[0]</tspan></text>
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="30.264952"
> +         y="79.249001"
> +         id="text63"><tspan
> +           sodipodi:role="line"
> +           x="30.264952"
> +           y="79.249001"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +           id="tspan63">Queue[n]</tspan></text>
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="30.264952"
> +         y="71.84066"
> +         id="text64"><tspan
> +           sodipodi:role="line"
> +           x="30.264952"
> +           y="71.84066"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +           id="tspan64">...</tspan></text>
> +    </g>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:7.76111px;font-family:Serif;-inkscape-font-specification:Serif;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:#000000;fill-opacity:0;stroke:#006680;stroke-width:0.499999;stroke-dasharray:none"
> +       x="92.18071"
> +       y="128.21965"
> +       id="text65"><tspan
> +         sodipodi:role="line"
> +         id="tspan65"
> +         style="font-size:7.76111px;writing-mode:tb-rl;fill:#1a1a1a;stroke:#000000;stroke-width:0.5"
> +         x="92.18071"
> +         y="128.21965">...</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:7.7611px;font-family:Serif;-inkscape-font-specification:Serif;text-align:start;writing-mode:tb-rl;direction:ltr;text-anchor:start;fill:#1a1a1a;fill-opacity:0;stroke:#000000;stroke-width:0.499999;stroke-dasharray:none"
> +       x="198.72205"
> +       y="80.708267"
> +       id="text66"><tspan
> +         sodipodi:role="line"
> +         id="tspan66"
> +         style="stroke-width:0.5"
> +         x="198.72205"
> +         y="80.708267" /></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="97.905846"
> +       y="44.725101"
> +       id="text68"><tspan
> +         sodipodi:role="line"
> +         x="97.905846"
> +         y="44.725101"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan68">Hardware Block</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;writing-mode:vertical-lr;text-orientation:upright;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="236.36934"
> +       y="112.10503"
> +       id="text68-7"><tspan
> +         sodipodi:role="line"
> +         x="236.36934"
> +         y="112.10503"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;writing-mode:vertical-lr;text-orientation:upright;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan68-4">EXECUTION</tspan></text>
> +    <rect
> +       style="fill:#1a1a1a;fill-opacity:0;stroke:#000000;stroke-width:0.940575;stroke-dasharray:7.5246, 0.940575;stroke-dashoffset:0"
> +       id="rect68-1"
> +       width="68.749969"
> +       height="141.2751"
> +       x="-129.49162"
> +       y="37.881134"
> +       ry="0" />
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-114.4223"
> +       y="44.966106"
> +       id="text68-2"><tspan
> +         sodipodi:role="line"
> +         x="-114.4223"
> +         y="44.966106"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan68-9">Memory</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:12.7px;font-family:Serif;-inkscape-font-specification:Serif;text-align:start;writing-mode:tb-rl;direction:ltr;text-orientation:upright;text-anchor:start;fill:#1a1a1a;fill-opacity:0;stroke:#000000;stroke-width:0.499999;stroke-dasharray:none;stroke-dashoffset:0"
> +       x="212.6013"
> +       y="64.823341"
> +       id="text69"><tspan
> +         sodipodi:role="line"
> +         id="tspan69"
> +         style="font-size:12.7px;stroke-width:0.5"
> +         x="212.6013"
> +         y="64.823341" /></text>
> +    <g
> +       id="g72">
> +      <path
> +         style="font-weight:bold;font-size:16.9333px;line-height:1.25;-inkscape-font-specification:'sans-serif Bold';text-align:center;letter-spacing:0px;word-spacing:0px;text-anchor:middle;stroke-width:0.0690111"
> +         d="m 185.24734,83.96512 h 1.28693 c 1.20226,0.01693 2.09973,-1.015998 2.0828,-2.370662 v -9.393759 c -0.0169,-0.711199 0.33866,-1.066798 1.10066,-1.066798 h 0.2032 0.0677 v -1.557864 c -1.0668,0.01693 -1.38853,-0.270933 -1.37159,-1.236131 V 58.96308 c 0.0339,-1.354664 -0.88054,-2.387595 -2.0828,-2.370662 h -1.28693 v 1.676397 h 0.62653 c 0.57573,0 0.77893,0.321733 0.762,1.100664 v 9.122827 c 0,1.219198 0.44027,1.710263 1.64253,1.862663 -1.20226,0.135466 -1.64253,0.626532 -1.64253,1.84573 v 9.122826 c 0.0169,0.660399 -0.23707,0.965198 -0.762,0.965198 h -0.62653 z"
> +         id="text70"
> +         aria-label="}"
> +         sodipodi:nodetypes="ccccsccccccccscscscscc" />
> +      <path
> +         style="fill:#1a1a1a;fill-opacity:0;stroke:#000000;stroke-width:1.25;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
> +         d="M 190.40199,70.278769 H 224.6663"
> +         id="path70" />
> +    </g>
> +    <path
> +       style="font-weight:bold;font-size:16.9333px;line-height:1.25;-inkscape-font-specification:'sans-serif Bold';text-align:center;letter-spacing:0px;word-spacing:0px;text-anchor:middle;stroke-width:0.0690111"
> +       d="m -88.44114,74.337891 h 1.28693 c 1.20226,0.01693 2.09973,-1.015998 2.0828,-2.370662 V 62.57347 c -0.0169,-0.711199 0.33866,-1.066798 1.10066,-1.066798 h 0.2032 0.0677 v -1.557864 c -1.0668,0.01693 -1.38853,-0.270933 -1.37159,-1.236131 v -9.376826 c 0.0339,-1.354664 -0.88054,-2.387595 -2.0828,-2.370662 h -1.28693 v 1.676397 h 0.62653 c 0.57573,0 0.77893,0.321733 0.762,1.100664 v 9.122827 c 0,1.219198 0.44027,1.710263 1.64253,1.862663 -1.20226,0.135466 -1.64253,0.626532 -1.64253,1.84573 v 9.122826 c 0.0169,0.660399 -0.23707,0.965198 -0.762,0.965198 h -0.62653 z"
> +       id="text70-1"
> +       aria-label="}"
> +       sodipodi:nodetypes="ccccsccccccccscscscscc" />
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16.9333px;font-family:Serif;-inkscape-font-specification:Serif;text-align:start;writing-mode:tb-rl;direction:ltr;text-orientation:upright;text-anchor:start;fill:#1a1a1a;fill-opacity:0;stroke:#000000;stroke-width:1.25;stroke-dasharray:none;stroke-dashoffset:0"
> +       x="200.88817"
> +       y="38.990276"
> +       id="text72"><tspan
> +         sodipodi:role="line"
> +         id="tspan72"
> +         style="stroke-width:1.25"
> +         x="200.88817"
> +         y="38.990276" /></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="205.12828"
> +       y="60.090775"
> +       id="text73"><tspan
> +         sodipodi:role="line"
> +         x="205.12828"
> +         y="60.090775"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan73">e.g.,:</tspan><tspan
> +         sodipodi:role="line"
> +         x="205.12828"
> +         y="68.028275"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan74">queue[0]</tspan></text>
> +    <g
> +       id="g75"
> +       transform="translate(0,40.745853)">
> +      <path
> +         style="font-weight:bold;font-size:16.9333px;line-height:1.25;-inkscape-font-specification:'sans-serif Bold';text-align:center;letter-spacing:0px;word-spacing:0px;text-anchor:middle;stroke-width:0.0690111"
> +         d="m 185.24734,83.96512 h 1.28693 c 1.20226,0.01693 2.09973,-1.015998 2.0828,-2.370662 v -9.393759 c -0.0169,-0.711199 0.33866,-1.066798 1.10066,-1.066798 h 0.2032 0.0677 v -1.557864 c -1.0668,0.01693 -1.38853,-0.270933 -1.37159,-1.236131 V 58.96308 c 0.0339,-1.354664 -0.88054,-2.387595 -2.0828,-2.370662 h -1.28693 v 1.676397 h 0.62653 c 0.57573,0 0.77893,0.321733 0.762,1.100664 v 9.122827 c 0,1.219198 0.44027,1.710263 1.64253,1.862663 -1.20226,0.135466 -1.64253,0.626532 -1.64253,1.84573 v 9.122826 c 0.0169,0.660399 -0.23707,0.965198 -0.762,0.965198 h -0.62653 z"
> +         id="path74"
> +         aria-label="}"
> +         sodipodi:nodetypes="ccccsccccccccscscscscc" />
> +      <path
> +         style="fill:#1a1a1a;fill-opacity:0;stroke:#000000;stroke-width:1.25;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
> +         d="M 190.40199,70.278769 H 224.6663"
> +         id="path75" />
> +    </g>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="205.12828"
> +       y="100.83664"
> +       id="text76"><tspan
> +         sodipodi:role="line"
> +         x="205.12828"
> +         y="100.83664"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan75">e.g.,:</tspan><tspan
> +         sodipodi:role="line"
> +         x="205.12828"
> +         y="108.77414"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan76">queue[4]</tspan></text>
> +    <g
> +       id="g77"
> +       transform="translate(0,85.725048)">
> +      <path
> +         style="font-weight:bold;font-size:16.9333px;line-height:1.25;-inkscape-font-specification:'sans-serif Bold';text-align:center;letter-spacing:0px;word-spacing:0px;text-anchor:middle;stroke-width:0.0690111"
> +         d="m 185.24734,83.96512 h 1.28693 c 1.20226,0.01693 2.09973,-1.015998 2.0828,-2.370662 v -9.393759 c -0.0169,-0.711199 0.33866,-1.066798 1.10066,-1.066798 h 0.2032 0.0677 v -1.557864 c -1.0668,0.01693 -1.38853,-0.270933 -1.37159,-1.236131 V 58.96308 c 0.0339,-1.354664 -0.88054,-2.387595 -2.0828,-2.370662 h -1.28693 v 1.676397 h 0.62653 c 0.57573,0 0.77893,0.321733 0.762,1.100664 v 9.122827 c 0,1.219198 0.44027,1.710263 1.64253,1.862663 -1.20226,0.135466 -1.64253,0.626532 -1.64253,1.84573 v 9.122826 c 0.0169,0.660399 -0.23707,0.965198 -0.762,0.965198 h -0.62653 z"
> +         id="path76"
> +         aria-label="}"
> +         sodipodi:nodetypes="ccccsccccccccscscscscc" />
> +      <path
> +         style="fill:#1a1a1a;fill-opacity:0;stroke:#000000;stroke-width:1.25;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
> +         d="M 190.40199,70.278769 H 224.6663"
> +         id="path77" />
> +    </g>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="205.12828"
> +       y="145.81558"
> +       id="text78"><tspan
> +         sodipodi:role="line"
> +         x="205.12828"
> +         y="145.81558"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan77">e.g.,:</tspan><tspan
> +         sodipodi:role="line"
> +         x="205.12828"
> +         y="153.75308"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan78">queue[n]</tspan></text>
> +    <g
> +       id="g81">
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="-18.502264"
> +         y="65.642387"
> +         id="text79"><tspan
> +           sodipodi:role="line"
> +           x="-18.502264"
> +           y="65.642387"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#800000;stroke-width:0.0690111"
> +           id="tspan79">HQD</tspan></text>
> +      <ellipse
> +         style="fill:#800000;fill-opacity:0;stroke:#800000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
> +         id="path79"
> +         cx="-18.407015"
> +         cy="63.2188"
> +         rx="13.317666"
> +         ry="4.4124799" />
> +      <path
> +         style="fill:#800000;fill-opacity:0;stroke:#800000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Triangle)"
> +         d="M -4.6361224,63.2188 H 10.606988"
> +         id="path80" />
> +    </g>
> +    <g
> +       id="g82"
> +       transform="translate(0,14.287503)">
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="-18.502264"
> +         y="65.642387"
> +         id="text81"><tspan
> +           sodipodi:role="line"
> +           x="-18.502264"
> +           y="65.642387"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#800000;stroke-width:0.0690111"
> +           id="tspan81">HQD</tspan></text>
> +      <ellipse
> +         style="fill:#800000;fill-opacity:0;stroke:#800000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
> +         id="ellipse81"
> +         cx="-18.407015"
> +         cy="63.2188"
> +         rx="13.317666"
> +         ry="4.4124799" />
> +      <path
> +         style="fill:#800000;fill-opacity:0;stroke:#800000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Triangle)"
> +         d="M -4.6361224,63.2188 H 10.606988"
> +         id="path81" />
> +    </g>
> +    <g
> +       id="g83"
> +       transform="translate(0,40.745853)">
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="-18.502264"
> +         y="65.642387"
> +         id="text82"><tspan
> +           sodipodi:role="line"
> +           x="-18.502264"
> +           y="65.642387"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#800000;stroke-width:0.0690111"
> +           id="tspan82">HQD</tspan></text>
> +      <ellipse
> +         style="fill:#800000;fill-opacity:0;stroke:#800000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
> +         id="ellipse82"
> +         cx="-18.407015"
> +         cy="63.2188"
> +         rx="13.317666"
> +         ry="4.4124799" />
> +      <path
> +         style="fill:#800000;fill-opacity:0;stroke:#800000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Triangle)"
> +         d="M -4.6361224,63.2188 H 10.606988"
> +         id="path82" />
> +    </g>
> +    <g
> +       id="g84"
> +       transform="translate(0,55.033362)">
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="-18.502264"
> +         y="65.642387"
> +         id="text83"><tspan
> +           sodipodi:role="line"
> +           x="-18.502264"
> +           y="65.642387"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#800000;stroke-width:0.0690111"
> +           id="tspan83">HQD</tspan></text>
> +      <ellipse
> +         style="fill:#800000;fill-opacity:0;stroke:#800000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
> +         id="ellipse83"
> +         cx="-18.407015"
> +         cy="63.2188"
> +         rx="13.317666"
> +         ry="4.4124799" />
> +      <path
> +         style="fill:#800000;fill-opacity:0;stroke:#800000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Triangle)"
> +         d="M -4.6361224,63.2188 H 10.606988"
> +         id="path83" />
> +    </g>
> +    <g
> +       id="g85"
> +       transform="translate(0,85.195881)">
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="-18.502264"
> +         y="65.642387"
> +         id="text84"><tspan
> +           sodipodi:role="line"
> +           x="-18.502264"
> +           y="65.642387"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#800000;stroke-width:0.0690111"
> +           id="tspan84">HQD</tspan></text>
> +      <ellipse
> +         style="fill:#800000;fill-opacity:0;stroke:#800000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
> +         id="ellipse84"
> +         cx="-18.407015"
> +         cy="63.2188"
> +         rx="13.317666"
> +         ry="4.4124799" />
> +      <path
> +         style="fill:#800000;fill-opacity:0;stroke:#800000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Triangle)"
> +         d="M -4.6361224,63.2188 H 10.606988"
> +         id="path84" />
> +    </g>
> +    <g
> +       id="g86"
> +       transform="translate(0,99.48339)">
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="-18.502264"
> +         y="65.642387"
> +         id="text85"><tspan
> +           sodipodi:role="line"
> +           x="-18.502264"
> +           y="65.642387"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#800000;stroke-width:0.0690111"
> +           id="tspan85">HQD</tspan></text>
> +      <ellipse
> +         style="fill:#800000;fill-opacity:0;stroke:#800000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
> +         id="ellipse85"
> +         cx="-18.407015"
> +         cy="63.2188"
> +         rx="13.317666"
> +         ry="4.4124799" />
> +      <path
> +         style="fill:#800000;fill-opacity:0;stroke:#800000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Triangle)"
> +         d="M -4.6361224,63.2188 H 10.606988"
> +         id="path85" />
> +    </g>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-35.2131"
> +       y="54.673237"
> +       id="text86"><tspan
> +         sodipodi:role="line"
> +         x="-35.2131"
> +         y="54.673237"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan86">Registers</tspan></text>
> +    <path
> +       style="fill:#800000;fill-opacity:0;stroke:#1a1a1a;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0;marker-end:url(#ArrowWide)"
> +       d="m -45.247972,57.442462 v 5.888987 h 11.344412"
> +       id="path86"
> +       sodipodi:nodetypes="ccc" />
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-74.441521"
> +       y="82.441582"
> +       id="text87"><tspan
> +         sodipodi:role="line"
> +         x="-74.441521"
> +         y="82.441582"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan87">MQD</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-74.441521"
> +       y="99.240776"
> +       id="text88"><tspan
> +         sodipodi:role="line"
> +         x="-74.441521"
> +         y="99.240776"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan88">MQD</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-74.441521"
> +       y="116.03998"
> +       id="text89"><tspan
> +         sodipodi:role="line"
> +         x="-74.441521"
> +         y="116.03998"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan89">MQD</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-74.441521"
> +       y="132.83917"
> +       id="text90"><tspan
> +         sodipodi:role="line"
> +         x="-74.441521"
> +         y="132.83917"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan90">MQD</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-74.441521"
> +       y="168.3002"
> +       id="text91"><tspan
> +         sodipodi:role="line"
> +         x="-74.441521"
> +         y="168.3002"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan91">MQD</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:10.5833px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-74.441521"
> +       y="148.1461"
> +       id="text92"><tspan
> +         sodipodi:role="line"
> +         x="-74.441521"
> +         y="148.1461"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:10.5833px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;writing-mode:tb-rl;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan92">...</tspan></text>
> +    <g
> +       id="g97"
> +       transform="translate(-5.8208336)">
> +      <rect
> +         style="fill:#aaffcc;fill-opacity:1;stroke:#1a1a1a;stroke-width:0.5;stroke-dasharray:none;stroke-dashoffset:0"
> +         id="rect96"
> +         width="58.726093"
> +         height="27.598055"
> +         x="-142.96434"
> +         y="46.852512" />
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:4.23333px;line-height:1.25;font-family:sans-serif;text-align:start;letter-spacing:0px;word-spacing:0px;text-anchor:start;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="-139.74622"
> +         y="52.62756"
> +         id="text93"><tspan
> +           sodipodi:role="line"
> +           x="-139.74622"
> +           y="52.62756"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:start;text-anchor:start;stroke-width:0.0690111"
> +           id="tspan93">HQD Registers</tspan><tspan
> +           sodipodi:role="line"
> +           x="-139.74622"
> +           y="57.91922"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:start;text-anchor:start;stroke-width:0.0690111"
> +           id="tspan95">Queue Address in the GPU</tspan><tspan
> +           sodipodi:role="line"
> +           x="-139.74622"
> +           y="63.210884"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:start;text-anchor:start;stroke-width:0.0690111"
> +           id="tspan96">Doorbell</tspan><tspan
> +           sodipodi:role="line"
> +           x="-139.74622"
> +           y="68.502548"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:start;text-anchor:start;stroke-width:0.0690111"
> +           id="tspan97">...</tspan><tspan
> +           sodipodi:role="line"
> +           x="-139.74622"
> +           y="73.794212"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:start;text-anchor:start;stroke-width:0.0690111"
> +           id="tspan94" /></text>
> +    </g>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:4.23333px;line-height:1.25;font-family:sans-serif;text-align:start;letter-spacing:0px;word-spacing:0px;text-anchor:start;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-61.293022"
> +       y="-19.380915"
> +       id="text93-1"><tspan
> +         sodipodi:role="line"
> +         x="-61.293022"
> +         y="-19.380915"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan104">SWITCH QUEUE:</tspan><tspan
> +         sodipodi:role="line"
> +         x="-61.293022"
> +         y="-14.089252"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:start;text-anchor:start;stroke-width:0.0690111"
> +         id="tspan101">WAIT FOR HQD_ACTIVE = 0</tspan><tspan
> +         sodipodi:role="line"
> +         x="-61.293022"
> +         y="-8.7975903"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:start;text-anchor:start;stroke-width:0.0690111"
> +         id="tspan105">SAVE QUEUE STATE TO THE MQD</tspan><tspan
> +         sodipodi:role="line"
> +         x="-61.293022"
> +         y="-3.505928"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:start;text-anchor:start;stroke-width:0.0690111"
> +         id="tspan102">COPY NEW MQD STATE</tspan><tspan
> +         sodipodi:role="line"
> +         x="-61.293022"
> +         y="1.7857342"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:start;text-anchor:start;stroke-width:0.0690111"
> +         id="tspan103">SET HQD_ACTIVE = 1</tspan></text>
> +    <circle
> +       style="fill:#ffeeaa;fill-opacity:1;stroke:#1a1a1a;stroke-width:1.88976;stroke-dasharray:none;stroke-dashoffset:0"
> +       id="path97"
> +       cx="0"
> +       cy="0"
> +       r="0"
> +       transform="matrix(0.26458333,0,0,0.26458333,-149.03517,37.347779)" />
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-36.659206"
> +       y="-44.828983"
> +       id="text106"><tspan
> +         sodipodi:role="line"
> +         x="-36.659206"
> +         y="-44.828983"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;stroke-width:0.0690111"
> +         id="tspan106">Firmware</tspan></text>
> +    <path
> +       style="fill:none;fill-opacity:1;stroke:#1a1a1a;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0;marker-start:url(#marker109);marker-end:url(#ArrowTriangleStylized)"
> +       d="M -84.242601,-9.1838245 H -98.041629 V 33.17598"
> +       id="path106" />
> +    <path
> +       style="fill:none;fill-opacity:1;stroke:#1a1a1a;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Dot)"
> +       d="M 9.9745536,-9.3442784 H 29.549918 V 37.170287"
> +       id="path107"
> +       sodipodi:nodetypes="ccc" />
> +  </g>
> +</svg>

