Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B18DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 19:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF7710F2F1;
	Mon,  2 May 2022 19:11:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11FA610F2F1
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 19:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwdPsV11jV5JkFIGCmQ2TWwhNYuqB1i9ZO0FbznwUEUocKlWQCqFZGHv+ySXhfLaBqeLlt0yWtzNr3pDBqtZM8Zs93hrEgGxN/5PfFGq9d5i4w6VZBybyWD0GwxTlpq54WH8cM7ndSE973FfmTdS5sskM9h5p9J39NOjL4qdz08dX9uDLNeaxKQOne7Ef60Lxz+ebPas9O1+HsZxEd4008REtHH3ut+1aBrqAQpxxoIP9m92S5NUV/TMIS5KzZ21yW5Qn/3V5ddtBhfAfrg9TH4kKHHTR1RbhBNG4nbPai0XN4gImtZCLJGMH+POdiGIzeT+qhQAi47Wk5vHP8qkaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls6idx3d8wgl7W28Cz7YU4DqPzgehOcsXDUNuBpeHZo=;
 b=fmlFmUWxrHkPe2bIAAh0G9pQeZWCGgFV5Kvtapyi8D1MSePuRt/2JzvJ8ww0AGad4wPuNZIvEhWu44XtU3VBYTYH5OKA4m/EZ/XZIvMIXLw+sUGqH5Nv656e9ibcc9eCdYosg6WyyfY5wmmsWAQf3MTBntuAwQC0o47+488U1XRbxxuNf60Z5qTHuVRzqQ2D127PQIIdoszLm5ABCt/rrOTl5Llv16jWYtsuofLtEWYxohOhl02IaB9NQ1XuE2fJw4/fwBEcsqM69exm3OtIP/d0iJ1zRJER6616wjHTYvFLES/vAUrs7y0eZJzJp1cRQTbQPdsvLdwl4BtjHs0iyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls6idx3d8wgl7W28Cz7YU4DqPzgehOcsXDUNuBpeHZo=;
 b=W8CUMU2DxDNCoZHZMAM8kNorkIrOmeecI19Z9UXiYnIzA+rfTDKnmRLjORMis55lOIqi0u9VhMHt/y1dYTCm+TEqtdtMO+YoZaoS6ZVz5smdZeQmrTLcTH5CwQe38bFojUAsiyKEMq9/CnonQA98hlzdCndJWNW6NFe6FJ59jAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MWHPR12MB1805.namprd12.prod.outlook.com (2603:10b6:300:106::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 19:11:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8%5]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 19:11:22 +0000
Message-ID: <5c11bc42-0ad2-22a4-b648-cd6e0842ce67@amd.com>
Date: Mon, 2 May 2022 21:11:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/11] drm/amdgpu: make software ring functions reuseable
 for newer VCN
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220502190804.784271-1-alexander.deucher@amd.com>
 <20220502190804.784271-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220502190804.784271-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0169.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::33) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44500580-947f-4007-d72f-08da2c6f8ba8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1805:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB180590D9247072F7339D335383C19@MWHPR12MB1805.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+KJ87Ufiu15gpOE+xrlVxQ9KyEUWJy7iOOBw54iHytspNq8637APsRaiu8VD0S6z5FXEdHieYj++S9TXOTfgBpmJfG9Scn+tM8QQSPbC01v1983IodNHw/drMS6SNg8t6cjJ06s8spouiHnlsUlJxUPqh/RrB3QeCY59kTFPMfI82o8p4l0/aiQdiWs2IQQkyoszX3Ts6D7NW1vUNyY2aU6JyBh7G4l/j6jIVUHRAu3zm523A5pO6NE8wxBSjXUECSJ11Gw6Rrepi2+55TN0QzbqUnXUxfkejbnjHdx9BcWTOXzeZA61Ax7NAC+wxN0+N8Uozbs4hQhvA1YjOfivKD9nEPtC0zGRTH25bn5WBsMSsnFnT28t9GdK14p848PR14C1USP0Rns3UqOY2OUkdBHig8eS3ZK5jSe6PRWdmON9+Hv+uq9MpsknrJjiAtsOW/1R737c+vlDCLfOhKNT/Pc4IEgqFkeAgUVKMuSsiBHkBzw0oxPKvFFTDZX26o/gIYOWnLw2m1UCjXq8EpcJSppLLoLLx0Jsqdzut1edfq6TMJ0BB0/DNpeGcowadkyIFof3xwWZ8Zv++UVVU3Jq8mlKbq2P7XZi00rWu0pil8C0h0SvtlXOjMrSLwqvuhxpx3PhUPNg4DB0DjDUVSiY5075zESYjW8IOiJOdE2x0Ps1nmlgrAf1iKS1TkwO6i3M56ROgHAjYzyEQBNGsiac9FovCBomusE7k1cvTltPxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(8936002)(4326008)(86362001)(5660300002)(31696002)(2616005)(8676002)(66556008)(66476007)(186003)(38100700002)(83380400001)(36756003)(2906002)(6666004)(6506007)(31686004)(508600001)(6486002)(54906003)(6512007)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGNzUDNkc3k5TFJQQ3RRaXBHY01FZlcrMkJ4ODJvYmw4OHpmbzVaYWpJNThs?=
 =?utf-8?B?L21mTkpFNFpEUFJqdHZ1WHUycDBMU3JvRjU1K3VHQWEybW5rY0hJWStyTjlY?=
 =?utf-8?B?dTQ3TGxJWU5zcC9Cdjd1VExXTU5CQjJHMWNxcnF0eTJVdmdSRjdTbTdHOUtm?=
 =?utf-8?B?bm1rZDFlNDluYWlNRmdYSE9JejRqNEkzQlJJKzl6SGFKcEVLendscVR2MW9T?=
 =?utf-8?B?YmMzQlhyOHUrY0FWaWxMYWIvekc2YnpEMXFoeXE1aFZmWTJpQ3VOVVpKcVhP?=
 =?utf-8?B?STRPQXF5U1dJM1c5OFV6R0lHaE9XQUpTKzhZMXE3c0tsVGFYQjBrY1RUWGVX?=
 =?utf-8?B?cHJNWnNsNHZXTlh3NDRIV29zeTVDMWVxSzBHdHpjMjR3d1dPUHRZd3hKc04r?=
 =?utf-8?B?YXUrZ282L2xpMlZUYktFQWtqTmQ2ajNwWkl5Z0kyaFg4M2UreW1LeG1aRzR6?=
 =?utf-8?B?NWtOU1NHMUFiNVdpYkh2VWp3TVR1eHR5dnZzQmhEYkliUERHcGUvRkZ0ZU96?=
 =?utf-8?B?YTl6L1BUcWhBcnh4MVJiM1FNWFNzK2xMbnROYnBwYnF1TmUwQ2VVRG8xZ0la?=
 =?utf-8?B?d2IyeGJVL1dQVW9lbm9tRXRsUTBoMHdGNklCK1F6UysxWklzVHY4dGxLcnQy?=
 =?utf-8?B?MnR6NnBwU3p2SFAvSXN3N2QycExFcnJBTEVlV3d5YjdGNGxodGUva0xPdyt1?=
 =?utf-8?B?eDZlTUE3QStPNXF2Rm1PbFdzUDZiR21oQi9rbXFqKzFKZnYvY2wvQkx3Y2l5?=
 =?utf-8?B?WjM4Rmx4d0hxWU0xQnRYSmhTUHNIb2Fkay9OYUs2K3Rsb3MvdFdWZFdGK0Vx?=
 =?utf-8?B?TmpTMi8zM0ZkME1BZjVmN0lMS09MTlp3NnZCTU9xbitVOStlVEw3NVBiV1VX?=
 =?utf-8?B?TjRoTVJoNmlDVGxaa01oVzc0M3hFNVBuZlBlUGNVTlpRcVozV25EMG10Rytx?=
 =?utf-8?B?YzFrcWtheXZyWUovZFQ2ZWFIK1I2SW5OQnpiRjJ0N3RFdWJxSWRFMGkvMEhE?=
 =?utf-8?B?RHMvbmc0ZmJUS1JvUXE2clBNampVQlk0MUdhMlg2L292UEdQbG5ZblFGWmlk?=
 =?utf-8?B?NGxTZ2oweHJ5TVBSN0VXK2ttTUZ1dmppRmlZU0U1cW9MVnU1QWVFbTdEaTlW?=
 =?utf-8?B?MEF0MnJKc1JrbGFFajZUYzh5R29ZcFVyckRUWWN0VEU3WHlVYVlrNGhtTjF2?=
 =?utf-8?B?OUhOR0JrOFVrUzJnaW1QT1NpU21YMVJORHg4cWJ6UklHU043cW0xNVRjaUN0?=
 =?utf-8?B?NCs5MTdodjcyZVBtaldMcndCSEdrODdDQmxCK3lNSDEyeWlLdERTeTByQUc5?=
 =?utf-8?B?M0loc05rSC9TYjltSVRkQUlJOEh6djdWWXo5YlcvWUwrN3FmeS9YNVlaZlhq?=
 =?utf-8?B?aXRnekRKeHd1ckxkcHNRcnBkSHZIT25YSDljeXBYdGY4UkltUDkzNHRLRWZw?=
 =?utf-8?B?cjRjdmhSeDNiNVZTeVh5ck03RXdkbG5WMnlGekRLU1VLOVlRc0VRZXpwUnNv?=
 =?utf-8?B?ZEZWSHU1OUR1U3BWNUxIVTB2TkFtM0o4dUlycllBSEZ5RDAvY1JnbGpRZDdh?=
 =?utf-8?B?RWduVk43b2EvT2E3KyswRytXVlJuUGkrSS9aUXU2ZG1XeGVtcng0T0Rzcndr?=
 =?utf-8?B?VHhFeE1yT1dTWjc5WHBrRU9sNEpJUkE4RjRQenhoMDZCckRjT1NJUStVOVJ6?=
 =?utf-8?B?QXdEdGxhUWZaU3lpU1hIN3NTU1lGNU1HZWRocTE4eTB6Y045R0R2S0F0Q2JL?=
 =?utf-8?B?NDNyVytVUjdBZy82VHUrN2RGcWZoeW9GRmdoTzdUc1Exb2ZmNjlBVE1YQUQw?=
 =?utf-8?B?MTNNUEU2cGViYS9Daks3eFRYVXQxTmNCdFFVYXJUY3dWTTFtbzZTRUVwR3V3?=
 =?utf-8?B?Q3poS1Rvcmt6UU0xZmtmQTB6b2JVUGE3NEpUWE8rVHRKZGpDb0FueVVKWUNj?=
 =?utf-8?B?ZG9wYm1JK3VHcTd3QWlRUXdVNTNNa0pvaHU0SnlWRTg5VTczM0thd01LSW5m?=
 =?utf-8?B?OUcybHZHUml5TFlwK090LzZYWnZ0YnR0ZnR2V3lZVXJwZ01WNmFhaFhKWGNP?=
 =?utf-8?B?dkVpTzB2Tk5kVjJTakgyN2NuN0ZaS2F1UWJpRzJnNHpFUk9rdmhTc2hrVnFG?=
 =?utf-8?B?K1BpR2ZMbnY3TFFvZXdQZVdPd3FLcTRPZTJhUForTm1MM04yZS9hNXlMSEVo?=
 =?utf-8?B?M0hTV2JTbldUVm9uUEF3czZRVldzWWEyMTJXZm9wUmR1U3k5TE41WDlJMW84?=
 =?utf-8?B?blBCbG5wRENVNldiUGQrK3dPaDNJZlI0Q0F4L0NXQk9ERkZQdDA5TnU1dThO?=
 =?utf-8?B?c0Zsc1NrWk1XaVRLNUJkQ0pLb3pQbWRkRjljd1kyODBBODRZVVF3VDg2OGtn?=
 =?utf-8?Q?QJJfCPdgR1iPgFv+enEQpZe3PJtb3n4XgJLLol6HiG4ef?=
X-MS-Exchange-AntiSpam-MessageData-1: jnLXP9IAV3TTlg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44500580-947f-4007-d72f-08da2c6f8ba8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 19:11:22.4780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2r4kDQXsIGgWmAGhqq5cwcnNCl7F8THtHihBJKZDHcc3qPEvBxpMdHgFIZvL67C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1805
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
Cc: James Zhu <James.Zhu@amd.com>, Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Maybe we should make nails with heads and move that into an 
amdgpu_vnc_sw_ring.c file since it is completely IP version independend now.

Regards,
Christian.

Am 02.05.22 um 21:07 schrieb Alex Deucher:
> From: Leo Liu <leo.liu@amd.com>
>
> Software ring will be supported only from VCN4
>
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> Reviewed-by: James Zhu <James.Zhu@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 23 +++++++++++------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h | 12 ++++++++++++
>   2 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 19cdad38d134..930d3bcbb3e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1728,8 +1728,8 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
>   	}
>   }
>   
> -static void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
> -				u64 seq, uint32_t flags)
> +void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
> +      u64 seq, uint32_t flags)
>   {
>   	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
>   
> @@ -1740,15 +1740,13 @@ static void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>   	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_TRAP);
>   }
>   
> -static void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
> +void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
>   {
>   	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
>   }
>   
> -static void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring,
> -			       struct amdgpu_job *job,
> -			       struct amdgpu_ib *ib,
> -			       uint32_t flags)
> +void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
> +        struct amdgpu_ib *ib, uint32_t flags)
>   {
>   	uint32_t vmid = AMDGPU_JOB_GET_VMID(job);
>   
> @@ -1759,8 +1757,8 @@ static void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring,
>   	amdgpu_ring_write(ring, ib->length_dw);
>   }
>   
> -static void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
> -				uint32_t val, uint32_t mask)
> +void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
> +        uint32_t val, uint32_t mask)
>   {
>   	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WAIT);
>   	amdgpu_ring_write(ring, reg << 2);
> @@ -1768,8 +1766,8 @@ static void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_
>   	amdgpu_ring_write(ring, val);
>   }
>   
> -static void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
> -				uint32_t vmid, uint64_t pd_addr)
> +void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
> +        uint32_t vmid, uint64_t pd_addr)
>   {
>   	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
>   	uint32_t data0, data1, mask;
> @@ -1783,7 +1781,8 @@ static void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
>   	vcn_v3_0_dec_sw_ring_emit_reg_wait(ring, data0, data1, mask);
>   }
>   
> -static void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
> +void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
> +      uint32_t val)
>   {
>   	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WRITE);
>   	amdgpu_ring_write(ring,	reg << 2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
> index 31683582d778..7a6655d3b79d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
> @@ -26,4 +26,16 @@
>   
>   extern const struct amdgpu_ip_block_version vcn_v3_0_ip_block;
>   
> +void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
> +      u64 seq, uint32_t flags);
> +void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring);
> +void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
> +      struct amdgpu_ib *ib, uint32_t flags);
> +void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
> +      uint32_t val, uint32_t mask);
> +void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
> +      uint32_t vmid, uint64_t pd_addr);
> +void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
> +      uint32_t val);
> +
>   #endif /* __VCN_V3_0_H__ */

