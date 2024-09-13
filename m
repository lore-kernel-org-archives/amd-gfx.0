Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220B3EEE245
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 07:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C254110E9DB;
	Fri, 13 Sep 2024 07:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AIsKBTAW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DAE10E9DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 07:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUyWpzemDurRwxTSKYtjQZhN+yGGYImkIGY7p9XXs/yThvuHctjB+ZzeTiTM74mxSbDl8ko4LkYlTRPrat0t8NMkDTp4gMR7kvHCgrTxLYHqUgSdeAvWRTjREdZk3gsFkEosu2kQxt8foYEP4jM7jIcnSdPIPyqEdDJcrZ8N2AhJJChlyv3hTGmVcVIchoAP2mtQpfj+Zmci+wLaTVwtTyVjCpUM++ZX2k/fnEthKEa0xDxvlSDyLuXYSxSpzdtP+jWKwLCPBb0+YUnXc4NTikNrSbtRIrNyZFDEcHECce09RPXInKRpaaw7T5pxI/4UsjuJLRYf29oMM6OcsvD1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASLPu7xzjngG6ZXzdzTiKWUP8B0jFLrX3abagpMjbj0=;
 b=L6E8rQRTBJHNucoG/KrILzvB084BRlPspUF1xuaIj8FjMcGyi7Buy35nxGnaQnp4I4iVwQFRSEDjGFDOqfG+b+n5dt+l8kFEwZTPValbPzQN7nM/6pEPtFIM/0HxmVQsT6f7D63Y1NTNNTWn4bW9qXdINm6htKLhbdpRRtsDC6jBokACyqzUFUuOxylilzyYkETJ0sAvaSVpyCpXa6zI0beiAtsAZF3OICsfnW7a2XjveC8OeprQEVGuJE88M+tHN54YnQhvy3VduMqOYLWDPCnxoW3xd20TkuumWdBLb+z+LwoM2sRYZeV6/Vq1ZjSQmErkWGeFDxo2dEwN6toBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASLPu7xzjngG6ZXzdzTiKWUP8B0jFLrX3abagpMjbj0=;
 b=AIsKBTAWhNO5BV9W9in+bRfguQ9YsTEa6BBZKpF44nMj7dQrp6P7ILefEq+4/xHXb594CQnIu56d+hWSu9C0jAb2Bsf0DMO1pok23qyo65eW5JtUtHgZ9It9BUzAgYmmzkux9ieSZMwOeHHUG41vdqTEO5aDb+d+RM3HYyVKP84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 07:34:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Fri, 13 Sep 2024
 07:34:18 +0000
Message-ID: <cd41a455-a445-4c88-8531-9f92b54db2b4@amd.com>
Date: Fri, 13 Sep 2024 09:34:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/amdgpu: remove unused function parameter
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240911151329.9438-1-Yunxiang.Li@amd.com>
 <20240911151329.9438-2-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240911151329.9438-2-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 530e541c-6a8a-4a41-8e28-08dcd3c67a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGhxU0hnVEFWemIyN0JRTzdoZkI5NFNRa2JYVUluN2lZYkRnSCtKdzJCSWkv?=
 =?utf-8?B?U1NZc2NDN2FJYis1V3FPTk9UeUpnSUsvRVNEbWNVaVNWbktyNE52RXU0ZmlS?=
 =?utf-8?B?RTB0Q0daWWFPbEJrdW5POGVGRjB6K0NTb2h1ak1lbnJMcVNFYTA2UjF2UFZF?=
 =?utf-8?B?OGJKWExRMU9VcFRXREtabFAwTWUrKzBqWnBaTGNwZkEzd1I5L294UmJvN3JC?=
 =?utf-8?B?d3BoRmpFcDMzRlM2ZGcwbFBmSXJSUGtGYkFSQ0pRWkxvU0tTQjlTaWtPc1RV?=
 =?utf-8?B?S0J6YmlNNGp0YUxDYkZYL2sxcXIyVkJKUGlrYVZEcjRKODc2c2pxQi85cDVx?=
 =?utf-8?B?S1BBL3IxSWl6ckxBNGtGeCs3dElyRnBoWjV6UnpvaWZtKy9LZUpad0pKcGti?=
 =?utf-8?B?ZjE5djhsYk9Jd2tacDRGaC9wb1FEN1NoS2xkS3lFNWtYY2piL3FxSWtKR1V1?=
 =?utf-8?B?T3E1MXkrTkZOa2hpdmJOYStjTUVIbSs3UVA5MGFvaTVzWjVxY1FHK1FJYngw?=
 =?utf-8?B?NlBSV29mRGs1L1l2WFRteXgzeU9MVStzcmxsT2RKS3dCSE9rNFJVV1grWG1V?=
 =?utf-8?B?L21sekttbWVvd0VQSzR3c09YRkZMSTdPV0FZazlUeGNnOG1IeWZCb3FzcFF4?=
 =?utf-8?B?b0JxUDhQbXRsQXIyZ3dQWHhpWG1YSFRMaEg3Z2V2c1JvWmJaOHVhNHRwYTlE?=
 =?utf-8?B?Sko1TFFGOGNxb2p1MGdrTlE1SG5jQ3BkaHVHTmtZemFJbHBKdWcyUzZqR3V4?=
 =?utf-8?B?ZWdDYTFRMDlvRGJNeURvakdBdVI5LzhLZ2RQNGNaUUttM1h1R3lJTnVTUklu?=
 =?utf-8?B?U2k1R0N5V3k4eFNhcG05enJLdnFvOXBhMlNONlRodGEvck5wWHYvV2N0OTVH?=
 =?utf-8?B?U0tWaXorNC9zQjNUOXdLckJvdExmZm9WOHhDcG5BVUNzeEd6Q2FoMHN3QlFC?=
 =?utf-8?B?UXFvdXNYa2xDQWJBSDZ0R0VmU3RlVHl6RDM3TUVib2dlRVE1cUNKVlNLT25H?=
 =?utf-8?B?MEVFb0liNVU1RFZKNjd0TFo1cjhuMDJmbDdTd25QajdQSWc2NWo2OWorU2Ny?=
 =?utf-8?B?TXJnbmFYdzFZb01SaFZ6MHJqM2NzWSs1MENNMjlSeHZ0QWpWMWF4VmN6MDJu?=
 =?utf-8?B?Wjk3TmRWQTdQb0QvdSt0ZlRtYTRWOXdPWmlJb0Nhd3V6a2VFcTVWRHZkWlkx?=
 =?utf-8?B?azVSc0FRQnJ0S3A1SDE5bWFWWHhpUEs1T0xjUjR1VlcyOFNlUGRYVVpIU1hT?=
 =?utf-8?B?bUdnRVdoNFNaZWhzTVlRS2dnQlZPSm5Neldpc29kSUFpK2JlZ0ptU1lTaGht?=
 =?utf-8?B?S1l0ZzkxaTkrczZFblNudllBdGZkM2VpQnhlMU5mcW1HUVFKcjJkUjNiU1VN?=
 =?utf-8?B?T1NyeERJdTlYWWxieWI3c3NLV0RmQUlUbkxzNk5tOHlKaWw2Q2NVQkR3VVB3?=
 =?utf-8?B?cGE3TjJNdmVzWDkzMkZ2M3IyOHVPZVhsRC96QTh4UXM4SjJWdHhOV2VtN01N?=
 =?utf-8?B?VEJwUXQ1R0dTRXlCcTJjbmZDellGNEd1cEgzK2tHc2RUcCtuL2tOM3lKaXpU?=
 =?utf-8?B?bERhdWNGME84Y1VlY1F2WE50UDNXR2pVSWY3cUZyRGxwd0swUGw2TFZtTXlJ?=
 =?utf-8?B?OW9adUVTbHFlQXg1bEFIVVpDbFRmZFFCbFJuRXRmQ1JkY0NOTjJ1NGYreXpv?=
 =?utf-8?B?SldJckovRzZOdWNZNGh2NWZNNDV4U3ZQQllVc1NnUk9ZZnZzcEJvQ2E2MzBG?=
 =?utf-8?B?NE1hLzArZGFQeXBWU3E5b1pCdzNaUExoTTAvbmZyQ3dZRXdNSFhsYUxkZXE1?=
 =?utf-8?B?MHdjTWhORlRkaExLZExZdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUpjaHNGMGwrYXAveS9MdFFEbE1SN0ROOFJlTnFsdm8za3hQbnZ4SVBYcmVQ?=
 =?utf-8?B?a0hSckdueVgyRGFpMUZUNE1jb3lnalFxSkI5eDNQLzJpbDljUXppTm9yU0p1?=
 =?utf-8?B?V052dmdtN0lFbmEzZVpPYlp5YXhmcU96K2tXSFdMRFVCTzdRTy9STkYyZG5U?=
 =?utf-8?B?bU1pMzFiMG0yWDRnSUE2ei9KQ1gxajkvZkhmVDl1Z3RWemNRUzRzaXVwcEsr?=
 =?utf-8?B?UytqVHg4ai9ZZlR2eVVIOVMvc1FTcFlzOGN3dDNXaGpqYzlYanJRQVBtTngz?=
 =?utf-8?B?bmZ1TUNtNFRnTFlaVHo1dVJoMEpKQWhleEQ3bUJIaHhLbDh1TWl0VDdEYXBR?=
 =?utf-8?B?a0pIOTNvTFV6bHdFWVZXYWZwdVlLNlozZXNmczkxQmEwQi8zMUp0TEZjKzln?=
 =?utf-8?B?S3RvTk5waXdmWEFQdUs1Um9WNWJaR01ZK1dHOGJPNmpkQTRxcFdab3c4Y1Fm?=
 =?utf-8?B?a3oweGlVZmZ2UnFyOXp5ZGM1SUR1YzVvbmFqN2pDMjdQL3RqNjdST1BCN2wz?=
 =?utf-8?B?b3dQRVFVby9XOXhxanVyZ250MVAweHZtUTZUYk5ibmdiQlFUK0piUzMrVkFJ?=
 =?utf-8?B?aWxoUDdtb3ArRm5SYVhZTHhjaHlBZTZ3SWREUEdCNWNYaG5aN0xmd3FqU0dP?=
 =?utf-8?B?UUZtTEJtRTlQQTh2b2doQ0QwYUNRNDY3Y2VCQUVwR3hZWUdDNVZLd09mZmN1?=
 =?utf-8?B?TjNEcmFvajk4S1RMRXA2ZEM5KzVTVXVzRUpKSVk0WmZ0SzFQVHNMZUlJSWhs?=
 =?utf-8?B?aG9WaDVyb2V2Umd4MndEaEVyWEJBNU9Ec0R0WWZVRkhUaVhITmRtYkhRWldr?=
 =?utf-8?B?clh2OXpuSnExazRsV2I5YU10SHRCN1ZCc2c2bDF0RUxIOE9INGhCODN2czdU?=
 =?utf-8?B?VlhpczIvYmErTjVFYUI0OVRBSFBvcURDWW5OQU5iUHdWa1J3Vm5PdkxQeDJY?=
 =?utf-8?B?WXh5UUdxMGhzekRnVGVKMkdVWjduazgycFdXT2xXR1dtaFlYL3BmZklUS1FH?=
 =?utf-8?B?dEl0bk9VNThLTVlwMitMbHIrekJjWkV0UFlLNUFLSXc0L0draFFTcDc5MGxF?=
 =?utf-8?B?c2JXenNkdXZEZ01zNi9GTnVpWUtIL3VGVURka1dHdFJzOU1Wb2c5WXBCSW5r?=
 =?utf-8?B?Y0dwcWF5ME1nVkpWWEpXOWFidlZERlM1SHB1TFJzeGcveWI1NzBxeW50QWNE?=
 =?utf-8?B?Z0IveHNDNGFENmRYM1RBdmpDYlJmMVlLdGpuanBNL0hEbXMzWSsxN1Jud1VY?=
 =?utf-8?B?cGNoZEM5aVNQcVhpLy85ZkFpSks4WW1YQWozeFhPYlpVZkcxN0NVWVR1aWVH?=
 =?utf-8?B?ZlUxZXdaYkJkRCthbjhMOGJTUXMrREZtSmxMTmxwSDR6bTY1MHpZSUFDTFls?=
 =?utf-8?B?ajRLSy9DcVB0VnRFSUl3SU1EdW92dFEySXYrMTlhU3l3anV0emFRZnNlenhn?=
 =?utf-8?B?dUZxOHJPMEtPYlI0b3M3RVhBZ0FMVUVob0ZGc0IzWVZBeDJXNjFXRit1bjI2?=
 =?utf-8?B?NEZEU0ZmTU4vT0tTYjg2bzlYc1pxY2lMK1BvWFJnRXQyUXVxUjhMV2Evc1BX?=
 =?utf-8?B?aVh4Y2d4a3JXOHVPZUFKWEQzMit3QWpLaG5Oc3ZscmhLNTZnenNSRjdiQ0p1?=
 =?utf-8?B?ZWQwc0JRazRFdmpoeHRGN3ArYUYxQjA2NHE2d2VyeG9XS1BRa3BFSzVFMXBw?=
 =?utf-8?B?VkNKckNxZGhmNlF3R3J5RmlHcStzKzY1cCsrTUJadEcwbGFVcGI1YlM4WGRs?=
 =?utf-8?B?M0RQd21neGNtL2c0U0crSGE2MHdrcnVxc0JRanN5YXBCMHJvNW1iU2lrSkxO?=
 =?utf-8?B?bFhFRGZ5Z05uR04wMmdDT3VHdUhRTTFEVHNzSG5kVHRlZTNVd1VSVzNVRVRh?=
 =?utf-8?B?RXVtZjMzZjlveEdnK1F2d1l5UWs5Mm9CczQ4a3gzSmxWdm9XeWRrM1Vlb3h3?=
 =?utf-8?B?cG5YZmNoV0dQTVBmeUZhQ253a3A2VXZvTDhNYmdxM0VGOHFPUUFZNGRuUVdC?=
 =?utf-8?B?M3pGQUFiNWk3N1JXdTA5Q2dDS2JVZ3RiQkJYYUorVnpEak15R01jelA0Tjc1?=
 =?utf-8?B?NnRCSkdhYmoxRGpSL2I3VVVCZmpCNk9YVTgyRklKNFhmQkhWTE5lUjc1aXBn?=
 =?utf-8?Q?9PuQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530e541c-6a8a-4a41-8e28-08dcd3c67a2e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 07:34:18.9225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGi20stinc7QQPKFRMRxX1/phMPZTZX68BtHKxzykSe5Im/l66t+GtC/SsZyl8oH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388
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

Am 11.09.24 um 17:13 schrieb Yunxiang Li:
> amdgpu_vm_bo_invalidate doesn't use the adev parameter and not all
> callers have a reference to adev handy, so remove it for cleanliness.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 3 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 3 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 4 +---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 3 +--
>   6 files changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 1e475eb01417..538d7523adcc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1105,7 +1105,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   	 * We can't use gang submit on with reserved VMIDs when the VM changes
>   	 * can't be invalidated by more than one engine at the same time.
>   	 */
> -	if (p->gang_size > 1 && !p->adev->vm_manager.concurrent_flush) {
> +	if (p->gang_size > 1 && !adev->vm_manager.concurrent_flush) {
>   		for (i = 0; i < p->gang_size; ++i) {
>   			struct drm_sched_entity *entity = p->entities[i];
>   			struct drm_gpu_scheduler *sched = entity->rq->sched;
> @@ -1189,7 +1189,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   			if (!bo)
>   				continue;
>   
> -			amdgpu_vm_bo_invalidate(adev, bo, false);
> +			amdgpu_vm_bo_invalidate(bo, false);
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 8e81a83d37d8..b14440490225 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -345,7 +345,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
>   	/* FIXME: This should be after the "if", but needs a fix to make sure
>   	 * DMABuf imports are initialized in the right VM list.
>   	 */
> -	amdgpu_vm_bo_invalidate(adev, bo, false);
> +	amdgpu_vm_bo_invalidate(bo, false);
>   	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
>   		return;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index ebb3f87ef4f6..62c81b74c78e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -838,7 +838,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   			struct drm_file *filp)
>   {
> -	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct drm_amdgpu_gem_op *args = data;
>   	struct drm_gem_object *gobj;
>   	struct amdgpu_vm_bo_base *base;
> @@ -898,7 +897,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   			robj->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
>   
>   		if (robj->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
> -			amdgpu_vm_bo_invalidate(adev, robj, true);
> +			amdgpu_vm_bo_invalidate(robj, true);
>   
>   		amdgpu_bo_unreserve(robj);
>   		break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index bcf25c7e85e0..1d2929ad8cbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1258,7 +1258,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>   			   bool evict,
>   			   struct ttm_resource *new_mem)
>   {
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>   	struct ttm_resource *old_mem = bo->resource;
>   	struct amdgpu_bo *abo;
>   
> @@ -1266,7 +1265,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>   		return;
>   
>   	abo = ttm_to_amdgpu_bo(bo);
> -	amdgpu_vm_bo_invalidate(adev, abo, evict);
> +	amdgpu_vm_bo_invalidate(abo, evict);
>   
>   	amdgpu_bo_kunmap(abo);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 48d0bec8e278..6f169e0ea30f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2138,14 +2138,12 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>   /**
>    * amdgpu_vm_bo_invalidate - mark the bo as invalid
>    *
> - * @adev: amdgpu_device pointer
>    * @bo: amdgpu buffer object
>    * @evicted: is the BO evicted
>    *
>    * Mark @bo as invalid.
>    */
> -void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
> -			     struct amdgpu_bo *bo, bool evicted)
> +void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
>   {
>   	struct amdgpu_vm_bo_base *bo_base;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 52dd7cdfdc81..b4424a757b38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -515,8 +515,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va *bo_va,
>   			bool clear);
>   bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
> -void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
> -			     struct amdgpu_bo *bo, bool evicted);
> +void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted);
>   uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
>   struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>   				       struct amdgpu_bo *bo);

