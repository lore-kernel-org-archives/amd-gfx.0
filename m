Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CFCC282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE35D10E178;
	Thu, 13 Mar 2025 14:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zuOyQV+m";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B3C10E178
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBm+5/K6jEarqptcZDfLVDScpbGFpqW7krVxe2CEXrzeJA+XqMODQZkhOvM5KVDkRVMeOpQcxaESPQfzk5P67TpP0LQQNw4mDynBSFjrtURJ6BZg+j++hSLh7AkS83KLjRvAQQljJciEgnSgHNKeXM9AugK1xnMVG205tsjSzV9aRHMoVrNjZtIl/hh7RoiGVmBVSIHgnQ+8pS/bvXGLhusPjBAvCFbWNolA3vZhlaa3bS27z9ZKdky4396VVDpq387VpZp22BPWrE1WUr/MVrMpLl8B8cIuRcHN1OkUAqGuZlVUvV0JMDr7WK/Jye3ZDf/CtL4gd/kzGoztwPIfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsH93xEYgBqqZHwFHVIu15FgaIQ+sxPIookStPnz1J4=;
 b=s96BIvCQw/EdPr+RTvGj7Vm1nL7QX+ZRU6Q6N3UlK1IDsvr/wzvRGF0S5hL+Oq/EBNVUz1z3lT8CTC6Al0ML5r0H2wA7ngq7e5kBACzm/0Zxjj3RX/YNqIRu+WuSUToVwEiE62FsRuOz8WJs77BxRcqsCcdtRs+ZwjqKBF/YsnW2bq5u/A5USX4KIiUETa5ZZeMgW5YRTUa4v49t8xagPaCnEKpqrmQr9DpHHqr5Cg0fO1+fpJeYI7Ct1wH4JF1gakkesLcGxrYm8zenp97zMYkS9o6v0wufW1SS2QUD4WmlyRSTikg6dRlocrQl1XqehY8TBXfJWNgCEOI43yGPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsH93xEYgBqqZHwFHVIu15FgaIQ+sxPIookStPnz1J4=;
 b=zuOyQV+mJ6lIaq3zb1TvpxSlOJpZFn1QJsNFyVRyoLaj9qSlAmtItT4zgXxKdbzO1DyDjYD55b2SzF03dgtjJVfUAMVc3SxzB5xNAShODOYb3d/e25n6F6SwzQIa6L22aEqbzySLhBfJ5VsWjHF8N7UKngGTqC925eD0A2NOCCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 14:10:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 14:10:09 +0000
Content-Type: multipart/alternative;
 boundary="------------7g50p1V78ePFjcAfyO6ybxmV"
Message-ID: <c33ec6ec-cd4a-4e13-9516-0702a4a2b7bf@amd.com>
Date: Thu, 13 Mar 2025 15:10:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
 <0bc3ca8d-8a65-472d-ae63-ef570d08d1ca@amd.com>
 <DM4PR12MB515277590EC11D3757BB448FE3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
 <dcf2a1b5-f079-41e1-b310-79db0b927272@amd.com>
 <DM4PR12MB5152C8596272C0BED39068B4E3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB5152C8596272C0BED39068B4E3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: e73ae612-2350-408b-c81e-08dd6238c358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHczUmRQMFZZV0Z5cVFGSHF5RXQrWXBONmVYZjlRbG11bU1iN3h6bHArRzVR?=
 =?utf-8?B?VkpTRTVKT2JxcTBZRkE3a3dEb3dBbDR5K3RhYVhaM0hDK2MrWlpsNC8rRU52?=
 =?utf-8?B?bWNDZDVCZkczNXlSTi9OQ3RXYk8rcDFaekNKSC9LZWMxM3hlWDB6anB1bllJ?=
 =?utf-8?B?ZlArSVVxejg2aTRxcS9ZVWF5TkIzTndhc3VabDBCcDByZVB6bzl4YlBYd09P?=
 =?utf-8?B?WUxSVE5pWjlOUC9pWmtLeWdmQVAwcUdROFB6VjdTeTVoUW1uWTNSWTlnbmNr?=
 =?utf-8?B?OUViVEQ2Z1prbEdlUzJGZDBDQUpCdXBsVEl4a3BjY0d1ak9qZDJZR2R6Skdl?=
 =?utf-8?B?dEhrK0NXQWltRkIvdkxCRkhBQmJwTTBIa1Y0cWdXTHUwRUNnM1N2UFB4S1py?=
 =?utf-8?B?WGFzV1Z4WjF4d0JLNDVKV3lWanZSbFF1MGMyeG10OFFGL3JCMXNHOHJNSDY4?=
 =?utf-8?B?Qzlhdnh3TWtLbXhkVTgzMTBJT2twS0l4M3NiOVJ2eDRBN0pkV0RLOTdmL3lj?=
 =?utf-8?B?anRobnNRZ3JhR3dpZ3ZSYUh2d245b05yc0lmdS80N3ZJd1hnRFQzdjFGVEM1?=
 =?utf-8?B?dUlROVBwYjgva3JTQ2NWTkdlV2pndW53N0U4ekJnS3h1ck1jRG9jZ0JlMDh0?=
 =?utf-8?B?bFdQSVdmbHpudkpnS1FhOEtKcWRlblZsVHN2cTdFRTJQQUI4Q3NGT09PSTcw?=
 =?utf-8?B?NFpsRFJ0bmpJSnlDYldVRGRzTFFWdm4vVjZRT1owcWhibFZ3bmtaRktuSGhi?=
 =?utf-8?B?Q2U0bHZXY1RsYUdhQklkWll0djJBR3BxWkh6a2I5RTJzVDh5Q2NuOExNckxV?=
 =?utf-8?B?OGhLV3dkek5XdGd1YXBRdXFaMmp1NWNLQmlYZ3BQc05hcUdhdG1EZXAvb1Vu?=
 =?utf-8?B?c2dMWmFjelcvaVdQNU5TZXZjdmlNMk9jRGM5R1FNUWZGYVJpNWsyWFVtNnht?=
 =?utf-8?B?UXhWN3ZJZXViQjhGdmwyS0gzV2dUV3dUMC9ObUQwSTRrUWNyZ2QxRWlZcVVt?=
 =?utf-8?B?QnZQbVlHU21UOG9TQWo2eGh6QVJXdEd3OE9PUzdpSUlmMVh0eGRLcjQvUjFM?=
 =?utf-8?B?NVl3TGRMd2oyUS9sSjM4OTZvbWsxT01lNjVmVUN4N2ZiTHFrenhCSFAzMUI1?=
 =?utf-8?B?ZnlXbURDSmszVGNlS2c1OVVaNlVUWTR1ci9jc3d5V21HQlF1TXBiOGVXUkZW?=
 =?utf-8?B?UmdlcWdnRWRlUWE3Z2l5dzdhRHN4ZU1vNzJGaG5hVmNwMFNiUFNzL2piOWhH?=
 =?utf-8?B?R0pPQm9WV3A2aDE4RDl1SzFHODFRZlRici9JQ0ZOb0FxZVlvb0QvUG8zTGZ2?=
 =?utf-8?B?Z0lKOVpHLzlBd1l6dHRCZGtDM0hyTVB5U05oNGN2MGhuZ3pzcEp2RTJ6aEFv?=
 =?utf-8?B?NUdSNTB2NWdDYkJoL2t2amRDQitTbVRpaVlpbUZabUtOci92S3NLQ3dZZHBy?=
 =?utf-8?B?TmZ2ODdlZ0x5VGRyRUZTNkkrdjZiQ2tCd1JicC80b0ROaGNJWStKUkhNdkV0?=
 =?utf-8?B?bG9hWXlpMmZrcXV5Y3lyNC9EaVV2T3Nxbnh4OEtURU1uSGZhU2NUM1VaMXlP?=
 =?utf-8?B?Q3kwSHIvT2dzWGRrZkQ4dmN0QzdncGV1R3kybW1Kek9mSkdheDcrRVcyZ3l3?=
 =?utf-8?B?amZzanI2dHQyUXVzMWJwRWw5aGhvek5PbmZNUUVkUzB2bXRVZDlXVDMrVU0z?=
 =?utf-8?B?Tkd3NXQ2b1l5T1RpcGZoN1cwKy83SS9kMk5ma0hQbERHUHJNbmx6bEtzVTJy?=
 =?utf-8?B?LzBoZzJocnZLNkEwNHRLTk9rRU1KdktPWG0xcEQ1RzR1UmV0Y09oWk5BRmhZ?=
 =?utf-8?B?Z05LV3RsNTg1RTdTbGU5Zmswck9NeU5xUGZwcmpWOUxOVGpOaVNsL2hLcTRU?=
 =?utf-8?Q?UgPieBWhXcRfo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFhzSldWc055bFRwbE9VZlpiNkJCdS9kcS8wRU9NUXgzZTIraU4xTTBXWU5n?=
 =?utf-8?B?cjNaY2tVV1E1YUhjeSs2U1FweUdpTi90L1UrYldMQ1Q2UlBBNnJQSmwwaGNC?=
 =?utf-8?B?NlpDWkVnYTA0K1VndmdNZDhwT25Vb1M2R0VUS1NpdlZ0SGZ3QkQvRjU4UmxY?=
 =?utf-8?B?aEVaTzBJMVRvQW1IOXgzcU5URzdYT2t1VjhJcEpuRjQ1SjAxcnRFbEdLS0tH?=
 =?utf-8?B?Q3lsUzFFbjN4aU1GRnF5clF2TDVhakFia2ZMdzZvVUViZDVRcWo5ODZDV0NY?=
 =?utf-8?B?S3k1K2d0Yk1XM3gwR3VTcEpXTURFdEtDbUlSOU9XZzgya0tBSEdGTzRhaTZ5?=
 =?utf-8?B?R3lxVzE5VnNDeUdVaU1GYnJQMjRESUpkbGpVQVh0TjArMUlEaXRYb2lIYzl6?=
 =?utf-8?B?RENianpGUG5xTGJ2OGFWOGladWxBRi9YU3BwVkV1cy9meVVOSUQ1K1lvTU1k?=
 =?utf-8?B?MGVZcENrT2RkTUwzZ0w5RjRrbGYyY3JqdFFhcGJGTG1wenFZTjBRS3NKYXZC?=
 =?utf-8?B?YjZYWllMM2tNQk1ueFpHQ2RxcWsyZUR5NHpkQmVieFViNHhuLzlBeW5wSjk3?=
 =?utf-8?B?TXJlaGJLSGpyK09hV1lOYTI2SlAxakxqRDN2aHgzWlBKZ05WUy9RcUJBQjR2?=
 =?utf-8?B?LzNDditnOXVtcWtieU9IMGd4Z0Uyd2hsUGE3UFMxVkVKZ3FXOGV4WUN0VWlp?=
 =?utf-8?B?QXpMTWl3WFk3SkpNNHVXaUtYRk5odWxsaU9peVVRMEtxNmJkaFZCTmZvSTgx?=
 =?utf-8?B?OWYrZkJ6S0hmT25vbTVKV2E2RlJlZC94czJrRFN0NTVmUHRxOG1PNFRGRm0v?=
 =?utf-8?B?U1dBUytZU3FpdExxQlR6SjdzejZ3aWZaODNyaGpLNXpWd2FYRUVVd0x2dmZl?=
 =?utf-8?B?SDhvM0wwc2VxTlg1N0crMFp6N2hodnEyN081cjdOM203S0ZYVytEU25tNEtp?=
 =?utf-8?B?cUdmOTdDLzNGVUZHVDBUeGRTOVlXR2h1T2JIZGxxcXdkdTVzZElHdWVkOXBy?=
 =?utf-8?B?QVJVQmhlT2tnODJMUklQejEyN0JxMncwS3JYSFVZRlFiUmVONmwwY1RXUDdC?=
 =?utf-8?B?MjdESGF5b2hFd1VlWVl6SmV6NnkrTm9ZS2tOZFpoR3pwekZJOWlyaUovL3h4?=
 =?utf-8?B?eE1rRW92L2dYelN4cHdCSmNuUmVEVllLK05xWS9PVVNPMzNjaXp1SjVJb0Fw?=
 =?utf-8?B?UkF4MmlRQWhJWHJFZVNUQ0VhZXMzY2pma3Yrd1ZiY2FBT2NJVXp4em1Rd2RY?=
 =?utf-8?B?NWkrVEJId2hPWkgyUWlNYkZ4djgyTGhHcnBaaXRkWTBzY3Zuc2ZJWFdDUnFq?=
 =?utf-8?B?UHBBdTBhb0RwcnhvbVZza0Myd2ZvSnFBTDV4K1NPSGVUSk90bHh3OG9ROVdy?=
 =?utf-8?B?cnFFOE1Sa2QrYVpadU50cHZXa2VpdkVySVJoRnYvNDk3aTdic25oNmExRHNw?=
 =?utf-8?B?citmczBPaGhOM0pGRkRtZzhDWTEwZS9MUE5ZeXNOS3JyeXJFMEZQQlBxa0ZD?=
 =?utf-8?B?Q2FwMS8rZHNnV2F5UlUvQnlLNHJEcDdnSHQ0SGZhOXNuWEI1TDVCVk9TaU54?=
 =?utf-8?B?VmxMSHc3MGNrYU1LZXFIMG01ZUpnWURpcVBQVksyWGk1VjdFMUlOY2RpemFu?=
 =?utf-8?B?SHQrYnFmVld3dXUyUGpMRWVUUHBXMEdkZHZlbS9uVlRRVUJua2JUT21uYlBa?=
 =?utf-8?B?bVp3ZWVscGQrZkN2RjIrRVM0SWxBK0U1aWpWWlFqc1hGNWlUYzNUWU12ZTV1?=
 =?utf-8?B?OG1UMHVpY2xGL0pOMFFmV0ZuaU1IbzlaVXVlL2NkL3Z0bmpFSnRGTWRXeWda?=
 =?utf-8?B?enJNSXIvOHN2cExJZitaRVNDZWdwbWpaMWNzY0l5aVhhekxqdFVtRUZrcHA2?=
 =?utf-8?B?OGZ6bXI0c2twMXpJL2gxZjB4MzlsbW13RXplbnYwdWNuVUlHaUFDQTVUUnd3?=
 =?utf-8?B?UEcyWHdscGk2SzhGQXZ5RWplWnpKL3VFSm5OUkZKWGl0UVNwVk0zbzZlLzVt?=
 =?utf-8?B?WEIxb2FMcGtZSW5kbUtsUnEranhlaUVJVEpnbXhjd0luUmVUeWVoNDh6Zkgz?=
 =?utf-8?B?UHJMM3ZyK0g1c3E2UHJ5cUYzeCtBZlVBZkRRak9lY3lSNkdFeGdQQVRIMDRu?=
 =?utf-8?Q?qxFo7MIT/9eVseX6aI/E3vAtb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73ae612-2350-408b-c81e-08dd6238c358
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:10:09.3396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQLftwLo3df/jvq3H63UJE1BO0SPuiC1iFeuPmtvErCyq3cmljRCIDwntRzx4r+5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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

--------------7g50p1V78ePFjcAfyO6ybxmV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 12.03.25 um 10:23 schrieb Zhang, Jesse(Jie):
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
>  
>
>  
>
> *From:*Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Wednesday, March 12, 2025 4:39 PM
> *To:* Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>
> *Subject:* Re: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by removing dynamic callbacks
>
>  
>
> Am 12.03.25 um 09:15 schrieb Zhang, Jesse(Jie):
>
>     [SNIP9
>
>         -
>
>         +     gfx_ring->funcs->stop_queue(adev, instance_id);
>
>      
>
>     Yeah that starts to look good. Question here is who is calling amdgpu_sdma_reset_engine()?
>
>      
>
>     If this call comes from engine specific code we might not need the start/stop_queue callbacks all together.
>
>      
>
>         Kfd and sdma v4/v5/v5_2 will call amdgpu_sdma_reset_engine, and start/stop_queue callbacks are only implemented in sdmav4/sdmav5/sdma5_2.
>
>
> Why would the KFD call this as well? Because it detects an issue with a SDMA user queue  If yes I would rather suggest that the KFD calls the reset function of the paging queue.
>
> Since this reset function is specific to the SDMA HW generation anyway you don't need those extra functions to abstract starting and stopping of the queue for each HW generation.
>
> kfd can't call reset function directly, unless we add a parameter src  to distinguish kfd and kgd in reset function, like this:
>
> int (*reset)(struct amdgpu_ring *ring, unsigned int vmid, */int src/* );
>
> As Alex said in another thread,
>
> We need to distinguish  kfd and kgd  in reset.
>
> If kfd triggers a reset, kgd must save healthy jobs and recover jobs after reset.
>
> If kgd triggers a reset, kgd must abandon bad jobs after reset.(and perhaps kfd needs to save its healthy jobs for recovery).
>

I don't think the source of the reset should be relevant to the reset procedure.

The source is basically just the first one who runs into a timeout, that can be both KFD and KGD.

But the cause of the timeout is not necessary the one who signals that a timeout happens.

So as far as I can see you should not have that as parameter either.

>  
>
> If we can add a parameter, I am ok for that solution too.
>
>  
>
> Additionally:
>
> For sdma6/7, when a queue reset fails, we may need to fall back to an engine reset for a attempt.
>

Yeah, but that should be trivial.

Regards,
Christian.

>  
>
> Thanks
>
> Jesse
>
>
> Regards,
> Christian.
>
>
>      
>
>      
>
>     Thanks
>
>     Jesse
>
>      
>
>     Regards,
>
>     Christian.
>
>      
>
>               /* Perform the SDMA reset for the specified instance */
>
>               ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
>
>               if (ret) {
>
>         @@ -591,18 +573,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
>
>                       goto exit;
>
>               }
>
>          
>
>         -     /* Invoke all registered post_reset callbacks */
>
>         -     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>
>         -             if (funcs->post_reset) {
>
>         -                     ret = funcs->post_reset(adev, instance_id);
>
>         -                     if (ret) {
>
>         -                             dev_err(adev->dev,
>
>         -                             "afterReset callback failed for instance %u: %d\n",
>
>         -                                     instance_id, ret);
>
>         -                             goto exit;
>
>         -                     }
>
>         -             }
>
>         -     }
>
>         +     gfx_ring->funcs->start_queue(adev, instance_id);
>
>          
>
>          exit:
>
>               /* Restart the scheduler's work queue for the GFX and page rings
>
>         diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>
>         b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>
>         index fd34dc138081..c1f7ccff9c4e 100644
>
>         --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>
>         +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>
>         @@ -2132,6 +2132,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>
>               .emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>
>               .emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>
>               .reset = sdma_v4_4_2_reset_queue,
>
>         +     .stop_queue = sdma_v4_4_2_stop_queue,
>
>         +     .start_queue = sdma_v4_4_2_restore_queue,
>
>               .is_guilty = sdma_v4_4_2_ring_is_guilty,  };
>
>          
>
>      
>
>  
>

--------------7g50p1V78ePFjcAfyO6ybxmV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 12.03.25 um 10:23 schrieb Zhang, Jesse(Jie):<br>
    <blockquote type="cite" cite="mid:DM4PR12MB5152C8596272C0BED39068B4E3D02@DM4PR12MB5152.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Consolas",serif;}span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                  Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
                  <br>
                  <b>Sent:</b> Wednesday, March 12, 2025 4:39 PM<br>
                  <b>To:</b> Zhang, Jesse(Jie)
                  <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                  <b>Cc:</b> Deucher, Alexander
                  <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kim, Jonathan
                  <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a>; Zhu, Jiadong
                  <a class="moz-txt-link-rfc2396E" href="mailto:Jiadong.Zhu@amd.com">&lt;Jiadong.Zhu@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH 1/7] drm/amd/amdgpu:
                  Simplify SDMA reset mechanism by removing dynamic
                  callbacks<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Am 12.03.25 um 09:15 schrieb Zhang,
            Jesse(Jie):<br>
            <br>
            <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal">[SNIP9 <o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <pre>-<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp; gfx_ring-&gt;funcs-&gt;stop_queue(adev, instance_id);<o:p></o:p></pre>
            </blockquote>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>Yeah that starts to look good. Question here is who is calling amdgpu_sdma_reset_engine()?<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>If this call comes from engine specific code we might not need the start/stop_queue callbacks all together.<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp; Kfd and sdma v4/v5/v5_2 will call amdgpu_sdma_reset_engine, and start/stop_queue callbacks are only implemented in sdmav4/sdmav5/sdma5_2.<o:p></o:p></pre>
          </blockquote>
          <p class="MsoNormal"><br>
            Why would the KFD call this as well? Because it detects an
            issue with a SDMA user queue&nbsp; If yes I would rather suggest
            that the KFD calls the reset function of the paging queue.<br>
            <br>
            Since this reset function is specific to the SDMA HW
            generation anyway you don't need those extra functions to
            abstract starting and stopping of the queue for each HW
            generation.<br>
            <br>
            <o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">kfd
              can't call reset function directly, unless we add a
              parameter src &nbsp;to distinguish kfd and kgd in reset
              function, like this:<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">int
              (*reset)(struct amdgpu_ring *ring, unsigned int vmid,
              <b><i>int src</i></b> );<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">As
              Alex said in another thread,<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">We
              need to distinguish&nbsp; kfd and kgd&nbsp; in reset.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">If kfd
              triggers a reset, kgd must save healthy jobs and recover
              jobs after reset.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">If kgd
              triggers a reset, kgd must abandon bad jobs after
              reset.(and perhaps kfd needs to save its healthy jobs for
              recovery).</span></p>
        </div>
      </div>
    </blockquote>
    <br>
    I don't think the source of the reset should be relevant to the
    reset procedure.<br>
    <br>
    The source is basically just the first one who runs into a timeout,
    that can be both KFD and KGD.<br>
    <br>
    But the cause of the timeout is not necessary the one who signals
    that a timeout happens.<br>
    <br>
    So as far as I can see you should not have that as parameter either.<br>
    <br>
    <blockquote type="cite" cite="mid:DM4PR12MB5152C8596272C0BED39068B4E3D02@DM4PR12MB5152.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">If we
              can add a parameter, I am ok for that solution too.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Additionally:<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">For
              sdma6/7, when a queue reset fails, we may need to fall
              back to an engine reset for a attempt.</span></p>
        </div>
      </div>
    </blockquote>
    <br>
    Yeah, but that should be trivial.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:DM4PR12MB5152C8596272C0BED39068B4E3D02@DM4PR12MB5152.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Thanks<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Jesse<o:p></o:p></span></p>
          <p class="MsoNormal"><br>
            Regards,<br>
            Christian.<br>
            <br>
            <br>
            <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><o:p>&nbsp;</o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>Thanks<o:p></o:p></pre>
            <pre>Jesse<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>Regards,<o:p></o:p></pre>
            <pre>Christian.<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Perform the SDMA reset for the specified instance */<o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = amdgpu_dpm_reset_sdma(adev, 1 &lt;&lt; instance_id);<o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<o:p></o:p></pre>
              <pre>@@ -591,18 +573,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b<o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto exit;<o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp; /* Invoke all registered post_reset callbacks */<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(funcs, &amp;adev-&gt;sdma.reset_callback_list, list) {<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (funcs-&gt;post_reset) {<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = funcs-&gt;post_reset(adev, instance_id);<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;afterReset callback failed for instance %u: %d\n&quot;,<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance_id, ret);<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto exit;<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp; gfx_ring-&gt;funcs-&gt;start_queue(adev, instance_id);<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre> exit:<o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Restart the scheduler's work queue for the GFX and page rings<o:p></o:p></pre>
              <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<o:p></o:p></pre>
              <pre>b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<o:p></o:p></pre>
              <pre>index fd34dc138081..c1f7ccff9c4e 100644<o:p></o:p></pre>
              <pre>--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<o:p></o:p></pre>
              <pre>+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<o:p></o:p></pre>
              <pre>@@ -2132,6 +2132,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {<o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,<o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,<o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset = sdma_v4_4_2_reset_queue,<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp; .stop_queue = sdma_v4_4_2_stop_queue,<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp; .start_queue = sdma_v4_4_2_restore_queue,<o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_guilty = sdma_v4_4_2_ring_is_guilty,&nbsp; };<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
            </blockquote>
            <pre><o:p>&nbsp;</o:p></pre>
          </blockquote>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------7g50p1V78ePFjcAfyO6ybxmV--
