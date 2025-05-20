Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34D6C3DA6D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 08:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7397610E514;
	Tue, 20 May 2025 08:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D0tNT/52";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2921B10E514
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 08:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk25levWHuig+1Mi4pvtxOF9tk+U+9mt76+Kj1ShvdD3RKU82M7lc6D4W5NK8nt+ShxLR+x9zyMy0zGOu5NfoCc0+oSjBHpwBnoysEpDpKDBaquyYOWWJZXvLDtwMsfn6XyNb8Es5qNN6Z/W00JODBQmRx21ngQDmQ1ytotMv5QCjKbxrrGNZRQF3sHLPUlYaUL4icvfBBRSOiSbIOVRpUgwt6PDT0DnLxFXTUaKX0wT7B+4gcZ5Jay/pUueMteRGu0TYDDyPcE6MKdFW7kgUL4iH1oU6O8EAS+BITY19qC0ASQqsoXQgPT8fsSLfBpemlssVIJOyC3gO/H6oKReqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+bJUsAP5d39gnKRBHnMggK6YgRUXqXrdIJn3wClsOM=;
 b=y8qqXiSBtP4L9h3fVwwOY27qpbanVkjh4hK4FXOgxOC9ph1tf7aTB4CWziZMegKrSZZR32yqCRgfmXkRv/3NV8SI1jAvtzuytQdRo71yDjeWEHgX2shp1UKtjCdoX0kekMQO/nSRGKyBruhznfxKpzrsDEfhx+WUqddctBQeW+BXJW5PU139FFlZQ7G5Z2Xpk4Nq9Pv1gPsC/RRKKU47v5/0k/kM+hfIkLXkTSqfbVcnB/1IdlH3q9wqK1zIvLaZUKN3TYhQReRn/AkPUXD2Df3khudwEaef/fkkW2jj/d/6L5QLYb/B2DWumgvNK8OSkebCTnO4PbhVkIPTcP+hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+bJUsAP5d39gnKRBHnMggK6YgRUXqXrdIJn3wClsOM=;
 b=D0tNT/52eqxckpfXyuyc1AD5Z0Ny0UF2TZkqB/O1+1NyMDohUrfx6ijq5l6tS7NkXhq6xdzeH/Uj+BLVBMhaBPFlj9p29cqqQ9HHovq7+9Ele9C9SEa4kfZ039wZfxXnPtrkxfg012HFCqEqt6wtd8e6bJaEBwDq4ZIE5R1vjks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 08:23:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 20 May 2025
 08:23:43 +0000
Message-ID: <03b9d63a-db0c-4886-af7a-c7908431104c@amd.com>
Date: Tue, 20 May 2025 10:23:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] Revert "drm/amd/amdgpu: add pipe1 hardware support"
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250519182209.18273-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250519182209.18273-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0332.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b18427-046b-4af0-db76-08dd9777a21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE1VY3ZHaTdSMGRoelZUOEM1am5ESkcvYytDaStEcXRVK3N5VE5wVk5OMElt?=
 =?utf-8?B?TUFNR2lsVjlUK3cxYUdkN0l0YmdSTE1WQUVFNE1sRHVRaU9mLzhsYkpPZjFK?=
 =?utf-8?B?eHQ0MHJsSmVvOFZ1ZXpvclViakkzdHI1QjJLbzNVYXYrYTRxRjdyQ1FocXZj?=
 =?utf-8?B?cDBTM2Erdzc4R2sxa21HYzhJWnFJQ2ttTm5pTkFWb3YzT2hDMjJRMHRmT3d1?=
 =?utf-8?B?eW9WdWJUYkFMRFlWVXBMYTRlbjFyK2JlclVNSVBhbjhQMTNkelByM2RqSEdl?=
 =?utf-8?B?dWR2ZXdpS1o1U1lSUGxDMGtuQkNXeGd0TWVqdU1JeDYxU3VpSlgwVVI4bUdQ?=
 =?utf-8?B?Rmc2bXR2Z2crVHJSTmgvMU9wdm1aQncxUXFqWG5YOXN6VlRBTGxLNG5aVlJQ?=
 =?utf-8?B?azlXNnh5ZUpqV21sNDdvdWREV0RueXYzZlMwejR4NFZ6b3dkWkljSS9TdXZk?=
 =?utf-8?B?WE56clB5VWNTVHcyRlJtRUxERkVvRGVEdGNSUkY0dGxnaXNBUEVzSzJkQUhk?=
 =?utf-8?B?OEpKLzJYa0hibzVHdm1wMmJqVkl3N3NJT1lEVDFneDJ0V25MaDJtcVRFMHdo?=
 =?utf-8?B?SXhkWVplR1V6U1RaT3dSMCs1emtJSkNNMXRmTTBsV0RvNmFuNm93TXIzSnhG?=
 =?utf-8?B?YzhQZXUrRGFiZm5JbittYVlvR1pPWVdyWWdvOHJhaFBBMlNNd0haNENJbE1k?=
 =?utf-8?B?WmY4ZEhpR0pWSHd1YWw0QmVLRmVNWDMycFRwN013ZkxUbUZrNWR4WkNhN3k5?=
 =?utf-8?B?REp1VjNiMS8yWEtWME9MMUs0Nm5ZQy9mdzZ5NVI5SmdRQ1BSOS9QS3dOcVVq?=
 =?utf-8?B?QjdZcWp3Qnh6Q2dpTkxTdE04bzRvNmxwb1ptcnMrMGJFVUhQVC9IUGRHNDEw?=
 =?utf-8?B?WEV0cXlmc2RxQS80bmdLb0F3Qis2MmV6OXZ2WmtzcHRZZ1RVd3FrckZlUXl6?=
 =?utf-8?B?V091ZkRHeTVHc0RxN055ZjVDZFlGNWJqV2NHdjZHd3YzUnFsUG9vNFZBZ1dH?=
 =?utf-8?B?ZzB2OTJPZElWeWFvYTRPWVdyczRGb0Q5WHRVZGp2ODltUVF4aVNMZWR2TGJN?=
 =?utf-8?B?ZnBEK3lXakc1ZUVOVE9HUCtsUTZoSUVuQmNhaW42RGQ2ckpBTUlqV2tSekM2?=
 =?utf-8?B?MXFhNlRJOHJOemlnRURObGF6WjRabnVGSVNDU1hPUmtCVVNmMmlBR1kwZURp?=
 =?utf-8?B?V0lXS001TVVqOTZWNW9iaXE3Y3NoRUJDbUFDd0xmZVpWUDNWQXhUOTZzZE9F?=
 =?utf-8?B?UEF6b2haLzkyRFUrdjZXUk1QVnNwb2VaRFdna2ltQ3FXNG5kOWdyWGIwQVJI?=
 =?utf-8?B?ekFzT1BMQ1pQd0Jrb05lRDRYbDNTdDZSbk9ZclRJeGN3dURxdDc2Tmw2dmwv?=
 =?utf-8?B?bDhIRHhRbXk1OGVRN3RZQ01YdWtHVWg3Y1J2WFpXTWNCZzVzVTRFL09ud29r?=
 =?utf-8?B?Ym5RdWUvb0VpMTM3d3hCaTQ0Z3krOUJsU01OelJIMlE5V2MrdUtzRHR2V3Bu?=
 =?utf-8?B?U1lPRG0zdldDdDNkSkwxSVVwV09wNzZaeTBNQW1vUTdPZmZwbVpNODVIaUNB?=
 =?utf-8?B?V0ZRSzY1VkxMbTVxejhVN3Mzc0Z4NWZyTDVOMHhaSzg1eDZYbWR2ZkRyV3Ny?=
 =?utf-8?B?OWU5WmpZWG16UkxpcXBXME5PUk1CRitERy9GSUhIMHNRYmgzNW5sckRsQmor?=
 =?utf-8?B?RXMzQVRmRE9CRENsMnRnbk1mVjhGbm5qSCtwQk1Sd3NMcnFaS2pTVVFRd1pR?=
 =?utf-8?B?azB3T0oxMUZRN1cvU3EzaVlRc2RTelFsSzIzVkN3Vi8zdm9jamxBQ0pqTlRW?=
 =?utf-8?Q?4gqOKnuW4Bls9rJW5AvrkY5m4rVxZti4G2rxo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUg1UHBsMC9UTkZnY2FNRlo2NFZ3dmwxYW5JcTBmVSs0cGdnNVNHLzlra2N4?=
 =?utf-8?B?VU0wS1doaWxpd1ZqazVNR1BwcGVKOXdNQmJENkwyZEpwdHJRbkV4cHU2VlVT?=
 =?utf-8?B?aEg0L3JveEpWWHNyNzBJWXZhOUFnaTNoQ254eXIwcEUwbVNUVFN6OGkwbTNK?=
 =?utf-8?B?bkNSNklOTzExYjdUcE4yUTYxZkVwbVlVZkFsM0o3Z2Q3VW9hMnFDdWFlUHg3?=
 =?utf-8?B?VTV1bDhzNENuSk9rWnkwME5tQWI4ODZENklHTk1QY2xMSEZicEx5bkRyemhh?=
 =?utf-8?B?aGFRdDM4QW8rWjNrQTQ4T1lIcFgzeGxabGlidXBYeVVoL2w5QW5FSVNsYmZw?=
 =?utf-8?B?UDZtTDFpam9PQ0x0NzJiZ2VmWGRHcUVTb25QT3hXWFZHRnpsRVcrWHlCK1hK?=
 =?utf-8?B?ak9Lelp1L2pEc3B6MW5XUGRlWjB1ZFh1VmNhcTNmdjZ3bWJuRU1jMlY3Q25s?=
 =?utf-8?B?d1NLT2FsV0dRU1hnSWw3aFcwWUJTRi81Y3VLdTZldzRlTForZE85V0FzZ3BB?=
 =?utf-8?B?TkVOdlVVcFBoaEpOM2lCRTNndEdnV2ZWc3FaWisvRk0yN1RUUXpFSVlNZ1dQ?=
 =?utf-8?B?aDdvakF5akUrYS9UZ2o3Mjh4TzJJT0RYZmFuUUJudGtvTXVPc3Rma3l3d1VM?=
 =?utf-8?B?L0FZN2M3VlpudjVTNVlwVGZvMXBFSnZDZzQ2Tk9UM1Y3ZkZzS1JUM3RKUzhs?=
 =?utf-8?B?R3JYR1NFRC9yL3pQUENObi95TXRKNSswUHVnczdUNm9OZVJhVVNtUXlzVCt4?=
 =?utf-8?B?L28xRll1WDF4T3RIVC84NEIxb3dCYmtqVUYvWVZVa3NnSGNlN2JVajlLcmdo?=
 =?utf-8?B?ZElQWllabmhSOUl0Zzh1SHlxZjg3TXBJM0NOczVrTlhlMkp2Vm5RVmRGeFVK?=
 =?utf-8?B?KzVONWNKbDRLYzljNGt1cVY5MWRpeWI3c1Q5TjRGeVVBNmhScnh0RFN5TE1j?=
 =?utf-8?B?NmQzdTN2TUFidEYzL0FKSHJ5RVZMaXNYOWxsOHJZUXcrbzNlWVNFYktRak0x?=
 =?utf-8?B?LzdwM1NUbjRPMU1Pc242ekhZVDJHZjF2Yk02VUMrU0tPN1IzRDk2ZUVqRUhm?=
 =?utf-8?B?cGE4Vmd5UTB6S2FKdWViQWQ5WW5pZjFWU1Vkc1E0SEtlYkRYVnhTazIxN0dW?=
 =?utf-8?B?R3JPZlNHNWx3MWNMYlpWTzlvdGVXcG5Mb3cxT0xyaXYrdmF0ZU1EeVRwRTBL?=
 =?utf-8?B?T21va3V6U1RoTU5RWTI3Um1IVWllZ3FVS1dPY3VpZFNTM2w0THRld0hTRnU2?=
 =?utf-8?B?VkxTajVtNFNwWHBwbG40bXpDeEtLMlJTeHl1V3pHN29ZbGJNSGdjMTZuL1VV?=
 =?utf-8?B?enJUOGdJVTdMdE5ZOWVnL0NKckpXRXNSVTNzQmE2ZmlYZXdza1pGVk9ZdVBL?=
 =?utf-8?B?T3JVdUpYd1kyUVQ0QUtSenkzRGdJQllkTTR3VVV1R1ZyV3NpSjJ0dWdnMThh?=
 =?utf-8?B?Wkg4dWlOdmkwREhLZFVFeXgxczlFblNJdnRpeGpwV0NxaEVEdkhzRnNPNkR4?=
 =?utf-8?B?UlhCN1FGaFdZMnI0eUVzMnNFM2pNWnYyR2QxOHdONVN2a1lER3JOWDJscDhl?=
 =?utf-8?B?UzB3STRJdnFFbVpRU1ZXQ0hUMEdwaEUrVGVNaDZPdFpHazNlYmtHdzZTSSt2?=
 =?utf-8?B?QVhyRW9uMUh6Uzh5VDV6T1lCbE9GSThMU2tHbGI3ZWx6c2RiMXcwdW9oc0pJ?=
 =?utf-8?B?UmtLZXZ6OStsRFhjZ1pJM3FZZ0xWQmFCdXNaN25ib2xNNnZjaGZRa0VRWE9D?=
 =?utf-8?B?QzRzeHoyQXVYK251dmgxUFBrWDRUZkd3U1pFUlJtVUQ5OUVrbVlDb3dOS2pq?=
 =?utf-8?B?N0pzWVVMNm8yWlBDUWVlb2JoeURVTTNJR29CbnBuMG9qUU5xbXVZTG9laHhT?=
 =?utf-8?B?b2lJRng2UnNGa3ZiNVpDQlVCOE5TTTcwd1NReTlMYVFwUW9sdU55R2E3ZUY3?=
 =?utf-8?B?UXh0TmEwdks5OUhwd3B0YzhxeUZJSTVWMkM2SUVtQnd0VDJGcGUraWRnSHFB?=
 =?utf-8?B?cTlYWkZoUWlrcWgwWU9WRzF5M3pNVWRMenNOZmpjRHltMDRWNVpwZ2VlSnhQ?=
 =?utf-8?B?ZDJaeXFqemtCNnNtUHMyZ08wQy9JSmJvNGxXM0FqQjhEVHdGZTBMTEh6bTRq?=
 =?utf-8?Q?+9r1SDnd6Qat1q9i4N0BBnX3b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b18427-046b-4af0-db76-08dd9777a21b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 08:23:43.7849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8v4uzMtpp3TzOex9Enes7fn7x3fKE8+GtDRF1243f/YKpce1ku6OQM69wWyI2Ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813
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

On 5/19/25 20:22, Alex Deucher wrote:
> This reverts commit b7a1a0ef12b81957584fef7b61e2d5ec049c7209.
> 
> A user reported stuttering under heavy gfx load with this commit.
> I suspect it's due to the fact that the gfx contexts are shared
> between the pipes so if there is alot of load on one pipe, we could
> end up stalling waiting for a context.
> 
> On top of that, disabling the second pipe may fix the reliability
> of vmid resets.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3519
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this one, #7 and #8 in this series.

For the rest I think it would be better if you add your rb to the patches I think.

Thanks a lot for looking into it,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 75ea071744eb5..14cbd1f08eb5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4781,7 +4781,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	case IP_VERSION(10, 3, 3):
>  	case IP_VERSION(10, 3, 7):
>  		adev->gfx.me.num_me = 1;
> -		adev->gfx.me.num_pipe_per_me = 2;
> +		adev->gfx.me.num_pipe_per_me = 1;
>  		adev->gfx.me.num_queue_per_pipe = 2;
>  		adev->gfx.mec.num_mec = 2;
>  		adev->gfx.mec.num_pipe_per_mec = 4;

