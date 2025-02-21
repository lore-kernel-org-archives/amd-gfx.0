Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF08C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 17:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1906410E216;
	Fri, 21 Feb 2025 17:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W6jiC+kB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BE110E216
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 17:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBqtHHzO9SMS/qKdcyvyY+YE61iEYfQAznZCzEoRL93QHKmtZHwKN+fhCoMH/xRGLEDVnjutqB4vqj6b3z+bUxANiZYaPx4cIRo3yqMbfzlyAteJnJwLFTFBqN67vxuozuLjVPTXGQrYK+GDGURaAqhPpyPbl8Pd4KS0PQARUBRgNmM7rGrRvr7Z802bGauIyWBKgi1VyOcwxuZ1ORxUp1MLrEWpZR+vyrDgSIFp8Txakue+OQiIrv9AUAAsLPHDYh+UfILp92NPnkE0Qwm+bsUrf4uSW1H2dpyJSSFIU4bcbM7uODo7qFaBGESLklnED+lmNbQNPBtfiS/Qp5CHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpPb/kkaGeFXzAuXRvvh4vg3RdMjyyJuUCOA9IGRyFo=;
 b=vPXtKNqSE0U712lTb3lPiQ+E8j5x5+0RCh0rMbevJarVAjH3wdrpePY1UVdV3nrsto8ZMWfQ8mD+hvBrJK4ZMY1DblAO6RFpu+fiaMynminMcesx+VimJPdvWyH55EYT0x0Rx9rL5mAod8FaXq5cczpHI36+/V6cKiyYcM01kotteFCVIUNCT8TA+MJ8EEMq07I7G/ull6URzwO3GIvcG+yJ041FDt/bNEh5lyHMQw4gzB93P29sL0qyOZ98eua+XNmj8lkvetR/J6akm96J0eI3Rj5spKIXsPjmv2xrg8Enl2NJC7tT1GvNplHRxudhHutrWpP+EWOzqrMEcK123g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpPb/kkaGeFXzAuXRvvh4vg3RdMjyyJuUCOA9IGRyFo=;
 b=W6jiC+kBougOJQcWwgwkF3yI+WuIqLg3TjvepADyH4OhXatzBpwjN++Pfycx3xdwxRqXj6275QdO6ap6aEFcCKe7uhojtQEi9mNLvLDwpy5pF4HpaLHtxFaIqkfCVr84sii+OD6O01jmde+LXlT65yy0VmgrT8szaCA8GHMqmjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 17:04:18 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:04:18 +0000
Message-ID: <cce3f32d-0037-4e4c-b9e8-749601c07d21@amd.com>
Date: Fri, 21 Feb 2025 12:04:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix an indent issue in DML21
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, sunpeng.li@amd.com,
 kernel test robot <lkp@intel.com>
References: <20250221150904.246929-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250221150904.246929-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::18) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea277d2-6c10-4749-dbc6-08dd5299c733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWEyY1h0NHg5K0xuR3NVOE5ORWt4Umx6L2hrQ25pTEQzNGVZTkhkUHFTMThG?=
 =?utf-8?B?NnZ6enhxMTJGbjBtTVNWRi9yMHpGekVUYXpyajR3Q1J0MW1KZGViVXp4M3p3?=
 =?utf-8?B?aVIzalFsZ0dDZGFCY2ttMCtaT2YxMUhNT1FEVllGN2VvSmVTQkNhekowMzVo?=
 =?utf-8?B?YldrbjJ0V0NJTHJ2emNyWDFiMU5leWErM2RBbG1xQm5KcjN5Wkd5MWNGMVhQ?=
 =?utf-8?B?S0tDWTdyL2JoQS9DNmptQ3lkSFlSZk1pZnZTd2JrSFlacEt0ZlNvQTJ3bVdY?=
 =?utf-8?B?Rm8ydnBKMUZudFo5QU1OaytHV3YycWJPT211dEQwZ0hjcWJGNWFvODBJTkVI?=
 =?utf-8?B?UFNMTjFuOTdYcWcrYk8rOHkwT3l4TWpTM3EvSCtuc3Q3TVE5Z3ZjUmZXODZj?=
 =?utf-8?B?QmVFWTEvbFQzT2JUV0FGYTh0eHJLaFhzOTlPdVZTdmdDY0U5TUNXZnVDQXVE?=
 =?utf-8?B?cEt0N3U5MVFMdlkxcnBOK2NOM0FYMldVbUVxSGpvb2EyL29ISEJmN0hpb0gv?=
 =?utf-8?B?UytjSkVHUW1rL3RuM2hDV3YxNk4yOFN5dnFlZS9sWU9YdC9RNUVDUUhpZ3NY?=
 =?utf-8?B?ejZzeThJQ3V0Tk52UXh0ZzErNXI3ODVzczFaNkpWZVF0dnNMeTNMR1JqWkhV?=
 =?utf-8?B?bzhDOFpGNWJ1SVEzck44Tk11NWNCQW9XVjdoRWV6cEJ6TExteWZLZ0hBR3hm?=
 =?utf-8?B?VWw5elpoRkFGT2dmdkl1YmxiSitmdU5EeGF4bTNTZDNGemFqVWxjMTJvRWl6?=
 =?utf-8?B?cElwbVlPL3R2VW9NSExSd1Jtejd5NWl0SHFxN0dHS3FGQ1dHNHE0QWRXVEZF?=
 =?utf-8?B?OXNTRWtsV3dxdEVxNG1SYlBhQ3N3bEp2RlhtU1QrL3hKclRudmVqUFU0Y0Vk?=
 =?utf-8?B?Ri9pc1VwL28wYkZvVnFQUWh3WFdNQSsyMk1sbWs3RFNSb2pKY1A0enF5ajY5?=
 =?utf-8?B?aTRNNjRCbFR0U21zTkp6bTQwZzNOR3hzQVpyRDYwckVWbzZDUmtYREVvNkJU?=
 =?utf-8?B?a3Zhb1M1a2RFelVic3Q0QmRyenV2RFNYSnVOUyttODMrTUczWVZQSDNqaitq?=
 =?utf-8?B?b1FEQzhhaVFNZ0pOQ1EzQmFkblF6S09Xd1FkQWd2cUxWK3Zjalk3b213Z2c2?=
 =?utf-8?B?dmN6ZXJrWUw4V1phY3h4QmEzOXVrcVpaTWNyYzd0YWp3RHRqMUdQeWhaTWtZ?=
 =?utf-8?B?Y3pLOUpqZGZKaWZ4bUJpN3pjTy8rOTBUT2hLS1c1em9Rcm9Qb0s5UmdiRjZz?=
 =?utf-8?B?ak9adlE4TFdtVDZCUlVuc3FpQmtrRTRtNExGVk1SdlJqK1dLMUJMQzdSQy96?=
 =?utf-8?B?VkY2UU5FeXRHYXUwaVBtV3RuTXdGcEJubDFma3B6Yy8zREhJWmU0UHAwMHJY?=
 =?utf-8?B?c05LLy9UOUkvRXBIVEcySjg4T21kOVBNanQ0RkVwUnJsZEVuc2FhZWNVQWEr?=
 =?utf-8?B?ZGVIcU9jcnRiMEZzbTFsOGc3V3MrWll1WHRkdkNXTUc1emNJclM2SjNBQjJw?=
 =?utf-8?B?WE13WkVUcVF1WTc2VktoL3hPdHUxTUZ3TEI2S2tIbHRQbHVMNGhiTXJuSmZv?=
 =?utf-8?B?WjB6dmdwaDN6d09odW1YTWhVcHlLTUZZQWUzMlVERExDL0ZkdFM1VUNIRWVq?=
 =?utf-8?B?YmxnUWVkWUxJQ0d3NDAxZVJ2eE5IMzJzNW1qVmFhNktIRTdsSUNKVi81Vm1K?=
 =?utf-8?B?bmxDditTK3J0cytYV3ZEVkJrNnNrV2tiYXlZOVh3RUV4ZjF1cUZROFVLYXBB?=
 =?utf-8?B?ZWRUVml3dStiZ3BTTHVZTFBHYnFQSHphOGxUamM0bDVZcnY2WnpCOFNZQnEr?=
 =?utf-8?B?dWFPNXBTWlhJdUpqTmpwNGJHQWlnS1B2YnZwQngyWW9EZSttZHdQZnJOd3dP?=
 =?utf-8?Q?rzXmLoXok2Tiw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTFwUUdTcnFWcUpLQnNHb2RlcCtlUE04UjMzbzQzbmg3T285a1JyUmJnVU0x?=
 =?utf-8?B?VE0xZHZ3VFhESjM3M1JqenZzK2cvR3RtVEdwVlNpZXo4M0ZjajBPaWY2QVdq?=
 =?utf-8?B?N3FCZENzMHZDN2Vldk5FTExRV3lqcXVlWXN4UnRFdmdLRTBxMGZ0UDhzamd3?=
 =?utf-8?B?VTg2eWp2VjBTUTMxN1RDMGNVV3RWekhPczJyVHBjemJUVS85ZWNoMWV2OERJ?=
 =?utf-8?B?VG1Lb2RtUU1TTmE2bHBEWnJkR2NLOElTSFlScjdvTjVVMjhvaDc0SGpSUmFO?=
 =?utf-8?B?dkJscVlkT0t1dHdwTDRqclYrUStEZGdTSC8xWTF2M2lUZEJrbU0vVW9pd1pC?=
 =?utf-8?B?UG5GYzhhU3hFMU01Q2ljKzlNNnF0cjMxNG9Bc0svYTZxNGlVcml6Sit2Y3ZF?=
 =?utf-8?B?YXRTTC91SVk2ekdhZDJQTVZTVzZ0dXRXTnkxME9BVnNkUU9idU9EQlRZdmU3?=
 =?utf-8?B?R3A1dnc1NUxiUEt3TmxyTzVrcEJIa3NGSVN4TWgrd2g3b0I4VFpKbkw2VDMv?=
 =?utf-8?B?NUh3MEEyNld4QmFmOXV1VTFsWE8yQktzUklrTXJxRkd2bWlLdit3S29sa1li?=
 =?utf-8?B?Qi9xRUlWQk13c2Q1V0hhd1NIcUE2MUp5V2dYZVpXakdjc0RqZXNrQWVrMU94?=
 =?utf-8?B?RWR3d1ZTRlgyYnpZWlFzM1EzOEhVbmJVSlQ4QzRlWDJnNys0aWo3dldrVU9I?=
 =?utf-8?B?WVRNUVM4Y2dENWtvUnh3OXRKbUR1c3FKaFdpZFFrbWZkYjZoUzJkZnRDUEN1?=
 =?utf-8?B?WW1lSWJWalN0M0tEaDczeGwyZzM2Ym5MZnVkTWZUcS9kSGlUcmNBcUx0dURs?=
 =?utf-8?B?MVNORVFsNnUrR0c1RDB2TEd0aWhzdFJQUnNYcGxjSTFXWmdUUi9naVNBdzYz?=
 =?utf-8?B?K0xKeGtZOGUrSnZGZURBUTR2aGdUaFhUak0wUjVCeTNtNmZyN2J0Yk5SZk1m?=
 =?utf-8?B?T0VSaG9VOEV3UCtuUklMNkxyZENXZlFOekZ1aEdsN1hHeXNmem41RGYzdVRL?=
 =?utf-8?B?YzBuQ0N3ak0xWmhKNHZ1N0IyYk5DbTM3bG9JcE1Qdmt1aTNkQlpjTDZGYnh0?=
 =?utf-8?B?WXkrUkd4TGIvRHFYMEl3d3N2T2RwL0srLzNHcWdUZWFsSm4xQWt2RThEZGFE?=
 =?utf-8?B?NEZFMStuQVZUWDVNeFdsYVFvWnpEMVh1ZlhoSWpIU0phMUE4Riticm1vQURQ?=
 =?utf-8?B?LzZTVUNnc3QvZDlzTnY1ZE8rdDVwaFQxTjBVZVp0OUZhbVQ1RGlVKzJiV2hZ?=
 =?utf-8?B?MXl3K0ZRbVRZSkJTcWJiRFJuODdVUVZ4a1lTaHlERDJXYnhuaTdoaTZBeEw0?=
 =?utf-8?B?Q2lLSGpxOC9PTHRJcFZoM0Z0YnZwMGd6aXAvZTluVngxamZwZnNwUkNZZWpH?=
 =?utf-8?B?Y2JFak1vVSs1QzBqMXB2TDduU3BBTi9DaU82ek9rZU5QSWQ3NTEwMFhISXNu?=
 =?utf-8?B?Qmc3YitRdGJONmFGYTV6bTNaRFBBZ0tSdmQ2eStLcDFQOW9WYi9UZTU5Rm5y?=
 =?utf-8?B?WmdvK2VsQTVMdHFzUWlaa2VNbWhLTHRwWHhYQ3MxdTNiajRkL0xIQ0VtK3FZ?=
 =?utf-8?B?Y1NGSkFFSk9HVzVZNzBBQVpOZGRyNi9BdlI0dUs5MEJTTDNRUllaNnV3WTRo?=
 =?utf-8?B?S0E0MGdnbTlEeW1wTUtFTSt6WkxiLzFuNGVXOUVJYk1WNTgxcXlWMGJ1Sjls?=
 =?utf-8?B?WkgxYlRiZXVsRTJNdS9PT1JvUnkvbnFwYWw3eUFYR2JpWVRCL1JKdHRjY0Jv?=
 =?utf-8?B?UGNYRE9aL3ZqRC85Yy9BNW9MSkM2RWR6dTJPMUpwdldvVk5oNVdrNHJod1pY?=
 =?utf-8?B?eFBRYlRmMlJ0NEM1UGwvM3pBeTZoYWN0M0lEZjdxTmZUazM5dGpBYmRDK0c0?=
 =?utf-8?B?MjZ1MGp5dWpTQ2QwN3pMYlV4YlhBWGh5ZFJtUTV5ZURHZFNEanZHbFBVanBX?=
 =?utf-8?B?N2taWncyY0djaENJdzhVd0hTNmlLSEhMUXBTRnhtRGJobnR6VWphZmhuMDZp?=
 =?utf-8?B?OS9xa3ZjSlloQWhHM3p6U3Bya1loRHBjRy9ZVDEvM0pZZ1ZaRmFHN2xNRmxs?=
 =?utf-8?B?bWZGVDRMWUxrREdyejV0SUFhRy9OeW9jRjR5SzJIbFVDQjhET2Jwd08wdUtI?=
 =?utf-8?Q?Sv90LSsi3uus4Wn4TYgdT0D+o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea277d2-6c10-4749-dbc6-08dd5299c733
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:04:18.3946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QImiwmd2NmOVbZVkpxF768fEvVNFYFC3qVsQdgzfgIzTbjoBQdoSZzRFGgqD8SGYFhX3JtboYG5U1hoDukdL+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
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

On 2025-02-21 10:09, Aurabindo Pillai wrote:
> Remove extraneous tab and newline in dml2_core_dcn4.c that was
> reported by the bot
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502211920.txUfwtSj-lkp@intel.com/
> Fixes: 70839da6360 ("drm/amd/display: Add new DCN401 sources")
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c   | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
> index 3664980d1574..0f4ada64461e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
> @@ -141,9 +141,8 @@ bool core_dcn4_initialize(struct dml2_core_initialize_in_out *in_out)
>  		core->clean_me_up.mode_lib.ip.subvp_fw_processing_delay_us = core_dcn4_ip_caps_base.subvp_pstate_allow_width_us;
>  		core->clean_me_up.mode_lib.ip.subvp_swath_height_margin_lines = core_dcn4_ip_caps_base.subvp_swath_height_margin_lines;
>  	} else {
> -			memcpy(&core->clean_me_up.mode_lib.ip, &core_dcn4_ip_caps_base, sizeof(struct dml2_core_ip_params));
> +		memcpy(&core->clean_me_up.mode_lib.ip, &core_dcn4_ip_caps_base, sizeof(struct dml2_core_ip_params));
>  		patch_ip_params_with_ip_caps(&core->clean_me_up.mode_lib.ip, in_out->ip_caps);
> -
>  		core->clean_me_up.mode_lib.ip.imall_supported = false;
>  	}
>  

