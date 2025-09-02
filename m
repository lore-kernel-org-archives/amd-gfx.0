Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187DBCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 14:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4AB610E740;
	Tue,  2 Sep 2025 14:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0WoFqqL+";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BCB610E740
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 14:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWcnsmJPngHxfdkwKr2TuqPYiwHOwELiTQE0Bnkb4+k0ndz8m1fAZJGZuP5BKCfwPM+zHGNAQmnchdeQ46Ksz2pPri14mowjBmZywWoLTI598TuanGrZ1DtuqY9E4wgCPmW3lmQNZn//HZCr9idg9sYfUhjHc9Bc2JmXTkNU2CeytVWTrNBF9jCy20WAO9ZJTXoYFJG8uQFGsVL82Vay6F72V6+BbKChXnwDiZLrUhtXD8fGWCubZMzG6OQqlYm7/wRQlEdh9cR3sX3buRrUPr1cWMQ1Fc3KauBA8+NKEsrthyVryR8oyz5mBhMkCd4NOOUrqEkTKPuLvGbv31BJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs7ezvV9s3QPMFkFZh36ZCDgPsCB7PKJRnMglI81CV8=;
 b=pyDvPqwUgr1mnDRvMosDLwounw0XY1yScL50GEr1REvXE+ZnuOTOlS3EbNjbvnQN97U2fv8d8sHdR/cyTMK6rlUqST/N9qscjweqqVyx+0BzxfBKcys6aSpo9QstQCETblcLnMzuO85Mt0I0h4AVCMDw1pJTqURhZYA8P9tVRu1f55iKfNDqtIy82EOv5dDqCD6lvyQ7OC51JWS9whs6RHeT0Cu3O6qBVP5k/mkC8UKlKc1eAmROyhYhSWaQrdAP6/b8JBdk1HR0krev4vHH+HhWGiXB+8nvf0xtGh5gNah0zoPADrlyTUekxqW56K1+v8X5TU/EcrNQGcdshzzkIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs7ezvV9s3QPMFkFZh36ZCDgPsCB7PKJRnMglI81CV8=;
 b=0WoFqqL+aNT6f/SJ4IdyZZB/xYayprM1cUHWG9cJBEsgEwD1xg3/bFgJ64wQGomHsEzmtmq9wtgzyN0LJwTD34HBGsQH4ltaIovtM94orzwGqZpavVXcOPN5uN/P4ri1MLvp1mSC1x2OnMtmI4gjPcCYH/8HNpyKczS/WKRPNE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 2 Sep
 2025 14:04:04 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 14:04:04 +0000
Message-ID: <6e516c2e-b159-4773-816f-f03c271d939f@amd.com>
Date: Tue, 2 Sep 2025 10:04:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix p2p links bug in topology
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250825142347.45997-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20250825142347.45997-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0242.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::21) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: d92b73c2-2c46-460c-0019-08ddea299351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFNTOGppQnR6cDBVMTdvMnIyaXhzaytTNUZxNU90SGxBK2JVNGtvTUk3Zy9Q?=
 =?utf-8?B?b2UzSzV2bWRsL3k3VG1Zb010am04NVBibnhERVA1OVJ0RVlSSDdYeFhyYVh5?=
 =?utf-8?B?VTRQQkppTXlrZVRQOUZsRVZYdExrdEFVNmswU3NjZVdDRU5UaHVzeXhmTDFD?=
 =?utf-8?B?SnVvNXk2N2JBSXJIcFByb2toUDVNR3lSQ2xvbVQwRE5sdzZnblZEaUNmN0lp?=
 =?utf-8?B?d2dDc3hpYzhxdWpYVHhxdWg1RFByMXJ2eE1vM1o2My9OeHE0WGIyODZTVnFx?=
 =?utf-8?B?NU0wREJZaVZETVN3L01IS2JmK3ROcktkTEJKQ1B5b0VQeFZtSThPS1gyL0NY?=
 =?utf-8?B?bUIxTkZWZjZDcFljbjBNYTE1M2xFckovWktqNkFvQUdOb29nZ0NXZ1lMeTJz?=
 =?utf-8?B?WGhLeFR0VFMzUDdhSE1TdlBzSnAycmxya0pwc0JVQUxoREVPUEJJdkxTWGxY?=
 =?utf-8?B?M1BMajBOTGUwS1B4KzQwZE9BaWxYVzFYdDBCdHcrUzhVZy9NZ05QemMyNEhR?=
 =?utf-8?B?dzQ3Z2NMK2dIT2hpVXhoMUc1clM0QXN5ZlpzcHFBeXhlamxWc1JyRzlOSFJC?=
 =?utf-8?B?UXVLRWppVjZxTnhwdkJja1JrSFBBdnVCWkhnY3BjMWJxcVo5aHhmUGVtbjNY?=
 =?utf-8?B?MEZGOXpyYlVmdmk2Tmp2QyttU2g5Q3JZWDh5cGF6bmszckE0WC9GZmlaWEtU?=
 =?utf-8?B?U2F3ZTVmcXM3VUJvUkl4R0s5UTZta1NsQk8ycXIySkZEdW9Sd28xdGlrcnhH?=
 =?utf-8?B?aTdPNlY3N3JZKzk5b3g3RFRlQTlOcjB1dGljempHNWh5ZWJCVUlHR2JIa2pk?=
 =?utf-8?B?OG1SdFF2bEtUSk1VNlMyVHlQZk1MZTV3ekprd1FkazdxUnB5ZHJKcXpFRmJP?=
 =?utf-8?B?U0RDV1FVL2YwVjdLMTJjRTZCQ0hSNm4yV0tsaFlaVE1ySXBCalMxQnRvSXd5?=
 =?utf-8?B?L2dXMHpHTDNQVEJyenAwYzgvbXBVdy9uL1ZYNkZ1YTdqaDRGOUFtejN6Mk1L?=
 =?utf-8?B?Y1lTanEvTEVMa1BPbnNaSkRPMmJDdTgvYU9XS3dZeXZXZXdHMlFxSHFjeDly?=
 =?utf-8?B?MEdia1pKWFltbjZzNUxnMEt5dTNMYk9Ld0U1cExRdlgrUlF1R0pmeVBDQkV6?=
 =?utf-8?B?eno2Y1J0OGg4d2x0Si92RFdTalZTOXFKRGtSN21keTdLdGFxenEzZ2hWclNa?=
 =?utf-8?B?VU1SMTlIa2NwTWxMWEtuWnVjSXlNTEhVY3hKNXJ2d3BublA0UXdoeHJmVHVG?=
 =?utf-8?B?QUEyMWVqbEkwc0ZzSk16TWluN0haaXozRk1nMzBXRHZuVVZ6bEF1VUgvMERO?=
 =?utf-8?B?MjFWRFVYdm5Ebjc3eDNYWnRXcnd1cTVuNVZGMXhBRlNzWUxzSE5yeWcwTk5G?=
 =?utf-8?B?ZHBoWFE4dk9ZdE1kdkFrWWQ5bElqbmdxR0pzN1BjVEJZVjdjdGVGUVdaZkc0?=
 =?utf-8?B?bktacitpL3N6S1gxTXBUYU9lTC9qMnR1V1cxTEhsVjhnNHlGMjJOWkFUMnZz?=
 =?utf-8?B?L3IyTE1PU3Z1ZkRQSXFHR3pJbEo5MzJ2TklDNk14ZlYrNUNFeVRpQUx2TnRF?=
 =?utf-8?B?NXZTblhkVlZIMVdCcEVwOWZjWlNSeFluZmxsSHdpN1REYWg4bXpRdHRZQmQz?=
 =?utf-8?B?U1ZKd3Q5LzFkM2pxYUx5ODM5MGdsQ3kwNmxGVis3SmJQL3EyMFc0TE9ZNmN6?=
 =?utf-8?B?NHMza1p0WjAxN2UwUWdSZnpGNkZtS0txTnlqRlB3b1hManh1V1c0WGYwS2F0?=
 =?utf-8?B?VlF0cEtLYjdodWMxWnp3WkpKbGlIbGt2OHdVa0ltR0ZOY2ZpMDdKazR3MnVp?=
 =?utf-8?B?N0J3RC8vZkVvZ3V3OTlCZDJ3UnJwd0ZqSUFoL1BrTXdXOVhnSXI5Mzgzd2pz?=
 =?utf-8?B?YkY5Z1dKT01ZOHM5RWJVSy9hVzRTV3g3SkJiVmhxVGZ5Y091RUFNY3MrK1ZN?=
 =?utf-8?Q?EwpXOJzKcPo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0Jyazh2Q3VtOEpBUG1HZHFZTSt5enl5cVdycUNPYkJ6Y2tMTkpKZkkvemJp?=
 =?utf-8?B?UkphY2dDVlF2RndOSUxxUnM0ekNLc3BjZkJNQUU4SGNrYk00emt5S2xxQXlZ?=
 =?utf-8?B?STE3OXA0Wkx3NFg3TG1lQWxYWTdsL040WU9KRjBVNHREeEExajJmSjlLUHl2?=
 =?utf-8?B?VVlWd3JLRW5rdzU3V1R5VzB0eTRGVzBBczBmb3NhWDlrN1NsNUY0akpsSVV3?=
 =?utf-8?B?SkpCUFZUdHJ0MjNsTjRpTisvTVo0MDFWUE9ha0RDY2hITXcyYVhYODBCUHVa?=
 =?utf-8?B?T1ZIdnZoaGVhaFBrMWQvL1ZXdXkydkpjampJQU13ZEVZczRrT2NFZFZzT2V6?=
 =?utf-8?B?cDIxQVl4cEV6amRQa1YzZTZLNUp2SURhU0hxV2lvdllJNzV6Y0o1MUhjK2xx?=
 =?utf-8?B?eUk4N0NDZk5sSUJIQVIxM3psUFdqV1QveWlITnA4QU1NcWVlTUh4dWtibU9V?=
 =?utf-8?B?V3ZNQUY0Vm0yMkl2OE93NGFEVXVwK0NqcG1qY2FIb3hGRHBYRkttdHlaSFZa?=
 =?utf-8?B?YXBZejF6ZGNrMWt5UWlUVUZqajJ6U0dsYnhnMUJvRklVa2x6STNvNzZoRjBT?=
 =?utf-8?B?QlNqYnlWUzVSSVF5ajJCZStLS1JNOWp1eDE0Q0hTUlNDNStVS1k4alcwZE1B?=
 =?utf-8?B?Tzh0YUpyWjJPUXdoM2tGNEZQYzVlYjd2dTk3RWtkdW50dngwVTNVZEZsd0x2?=
 =?utf-8?B?MkJFcVlCMUFwQWUzaEFoaTJmeEw2MVJvWURKNitoVzM5V1BaWDRFVE9ObHVp?=
 =?utf-8?B?SXp6b0xiSW1JeWNjY1cwTHJzYTFJY24rQ2U4SlcxK0o0RW5EcW90NzFyVGVY?=
 =?utf-8?B?YkNxOXRtRHVKVFBySDhlQ3ovRjEvWFhIUTcvb1pjbkVRQklrTTZyNXlNZTY0?=
 =?utf-8?B?RGJHZzBUdWJtNEtDM1pRMGQ5aUxUVVpvZHB5SDVSNzhkdVJ1ZGdZa0V5cGVT?=
 =?utf-8?B?RjNIR1NtSTVyK0JxdmlKUzhaRU5reitJekhVbGd4SlNtaDF2TVpBSUplVWlZ?=
 =?utf-8?B?KzU0eGZDNTRYWEQvMURPcERENDl1bjA1VDRjSVI4ZEExQ0RxZmhmckQwUlla?=
 =?utf-8?B?QllkN3ZMT1pkZzVjTi9PMnpUSkNEank0OXdQTnNaYzFYNlg4UWlrY1pkcHJE?=
 =?utf-8?B?SWp4RTRRMW5XbXd3RVZvTWxXQWUxY2VZajltUVltTHhtVzNXM1ovMnU4bDlQ?=
 =?utf-8?B?N0N5UlJVcjVZWmJJZnlsY09ERDB5RGtsQlJ2aDF0aCtQYmFOVmVLOWtCRzFt?=
 =?utf-8?B?T2xuK1dTL2gvazN6WVhQNmhUNzNWUkFLN1RKdWNweHZOckFDdUc4N1Vpajhm?=
 =?utf-8?B?ODVVWlJpZkRUS3lzVDJ3ZG5MQXJIZ20vd2k0eDJaamp6VnBMaE1jSDhnVURk?=
 =?utf-8?B?YVFqV1cwUUhoZFp2eGt4UFlmemZrU09hcmdzZVc1Z2pjZTZhNUpxbkVoRWtF?=
 =?utf-8?B?Yi9DWmVIUXYyOWpGSXRrWGlPT2pnY3JIOHFtak5WWEhydHJOSXlDbkxwQnNM?=
 =?utf-8?B?ZEJDa3ZocXV5WDVJU3dEdWhZckV2dEFoVlVleDYwL0cwaWRBa3ZKZ2VlMHZW?=
 =?utf-8?B?clVDWFhhNTdwTkVJS1VESkhEbW9HaVJFY3Y5U3dVNVRFdTg2aml6YzRndGV2?=
 =?utf-8?B?TWl1TUpZK00wQ0dXWWNtWEdWMjhTZStwVXNMOE1xSXJPcHdmME5Ha0Jyc0hL?=
 =?utf-8?B?YTVNREl5Q1hBUlBvZVgwWTlWVS8zYVNMRVc0TUZhWGdYb0s0SEkwemlSWDNt?=
 =?utf-8?B?V2REQ0hrSzlVRTlKWTZVdFF4Mjh5OW1Od2tSUnE1T3RiVzdjSENCdVY2RWRJ?=
 =?utf-8?B?VllFOGZvT2xVMW9VTk02alBndFZUeDFCeklLbnlwaUNYMGVGKzAxdEl2OEJT?=
 =?utf-8?B?TFpoZXg1Z0Nnc21abzVYaGFEU2wwMUIzVTRCS2NFK2FpazBDYzd4d052Y1Zn?=
 =?utf-8?B?bVh2eE5kY2dablAra2tBdjQ4aHJDQm5PMUJBN1dFbGlIc0hjR21nd1lOQ2hW?=
 =?utf-8?B?eE9pNXF1d1YrbGZLVjVZK21GUXpveGw1MW0yY2RFMk9ocXZWcUZ4SGxuRlZQ?=
 =?utf-8?B?UndWNitHcDArdU50Q29wamZUU01kUFRJbEcxUFByTzdLNDZwbG9YM3padkRL?=
 =?utf-8?Q?XQ8plFsAvBzpA1KcIFAg/qXbz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92b73c2-2c46-460c-0019-08ddea299351
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:04:04.5641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlVBUUeVbdq9GsVGqm6ZEE/DlyXcGEYOdVzQkmy69/Mo/UmT3Nnc9/iZGWMwO9q6cUO9QmXEF1ORo+K/3OMQXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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

Ping ...

On 2025-08-25 10:23, Eric Huang wrote:
> When creating p2p links, KFD needs to check XGMI link
> with two conditions, hive_id and is_sharing_enabled,
> but it is missing to check is_sharing_enabled, so add
> it to fix the error.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 82dbd68d8c99..5c98746eb72d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1589,7 +1589,8 @@ static int kfd_dev_create_p2p_links(void)
>   			break;
>   		if (!dev->gpu || !dev->gpu->adev ||
>   		    (dev->gpu->kfd->hive_id &&
> -		     dev->gpu->kfd->hive_id == new_dev->gpu->kfd->hive_id))
> +		     dev->gpu->kfd->hive_id == new_dev->gpu->kfd->hive_id &&
> +		     amdgpu_xgmi_get_is_sharing_enabled(dev->gpu->adev, new_dev->gpu->adev)))
>   			goto next;
>   
>   		/* check if node(s) is/are peer accessible in one direction or bi-direction */

