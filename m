Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC7ED0C5FB
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 10:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B56A10EA76;
	Fri, 25 Oct 2024 10:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RbP24gQY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AAAA10EA7A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 10:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4csOAJMr1CYaDt64JwHbcK/NhEjtHZ3FKKnlJknNdK/0G3zTQmDgQdg/XpkadSXHE1+8lmfeGKH8qqgQjDWapPzfh2jUn034MtdUubNqE5lHSvFWwG87lpSnWbLGyfxLCAJ3eETwJ1mD9p6Ac2qWky8tH963u2iZwi52TqHvKvWVSBZlolPS4++CZLFy+L5xuZh9JWrjlOvvueWOlbwUexAfJdrf2w2Ns/Hjdk9kSZ2Y5X0CfqIHlqRD1DasCOPmZ8VPg58gi4KMedZxucFNMVUGrv8RBW3e7HFw5hUeoXRMMcD+GNZWG/s9uSw5vacqf+oBO8q5wGw1khoDpTNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ChmDEoGTTVPGojZZqkbSLZunOo1p/MvAwYpWSZZNe8=;
 b=iLcIjHiyug9SPnCx7kRWlDiZa9L/XTk82WmQS7Usr25OifRPXZ40oD0UHYDA0gh1sY4CCf+QjXKgV6ILxP8w+UJyg32xdpzHXOxjApcBtNivCEftFURVSeyKuWkClzbLkkTh6bVLQtp92fcyfrlUIGanvIEk+jKRGq18E0IvkJk7QiKNYxk+mH0nTomOwH3srkW7mynqmxzA3BClgUYS8dwR2EML6ye07zrSABW+/lkv32GYFxOecUhhkdPIoSKJyhxHBaP578/JvS9Jmh/O7Yfh8jNweY/CpAShFZfXzDh+m9cviZLUIvYfBv35pCc3OAKYDd0Ht+ECmKWLvaGTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ChmDEoGTTVPGojZZqkbSLZunOo1p/MvAwYpWSZZNe8=;
 b=RbP24gQYmW3PrCqRP0M6fDA0NrwGAK38K6p15ZHwCdJSkjdWsXztMzt8sSShHuCE3804VtFoYwn6PrvvfN4WYtNLO961DrEraiMQD9BJ6NDc3HR88+7P0fdGaPpSxJArLcZZsYZulqTQX771mCGrPvWkGA1a60nW4B4de3S/KUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 10:38:57 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 10:38:57 +0000
Subject: Re: [PATCH 07/29] drm/amdgpu: pass ip_block in set_powergating_state
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-8-boyuan.zhang@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <47bcee70-af26-7959-c583-fd1e1d94ef83@amd.com>
Date: Fri, 25 Oct 2024 16:08:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241025023545.465886-8-boyuan.zhang@amd.com>
Content-Type: multipart/alternative;
 boundary="------------DA1FFAB7DFEF4F7C9BF4BDD2"
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::33) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e20e781-8497-4f2d-6ba4-08dcf4e13a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXV6K0VNb2t2Q2dtNjRTY2prL2ozL2E5amVFeVVXRmI5N080eWxwY1RYUlZ5?=
 =?utf-8?B?Nkd3M1BzaXUzL1lmbWhKcmhaVGJtek5oV0hpdEhONHNwMXZPcXdBbExYa2ll?=
 =?utf-8?B?K1l1SUpYNmRPcUZDNFdTa0FOWkhJenREWnM1ZmlCOWtxOHZXVmw3S1ZPeW0v?=
 =?utf-8?B?aERnRlFhWHJodFBGd0l0SCtycUVIenN0dXBseDJ5d0d3bVR1QUgyWVlUdldL?=
 =?utf-8?B?YkN3ZVdIR0hUanpQV2pYQzR6YzRhY2wrSUM5d284Y2hTQ2JwWHhsVHhFUWh5?=
 =?utf-8?B?NEJjckhhQURzRW84dzY5VTJEWi9zc2dNOHVaUExNcUxjakpaTk8vZmxyVDhl?=
 =?utf-8?B?SE1QMy9qcE40MnNjaHhEQldVR1NhUTBKYXZ3amxCWlpBSFRQcFFJdUpGUWs5?=
 =?utf-8?B?bitEem9MeTd5QmNHNElKTWFZaklEZlpNdUNrNTBUSkN4WGpjNGpRM0gxcDNP?=
 =?utf-8?B?NzA5ZUtsT2JEZjdIbVVvNnZSRVBDRjJTVFU1QktlbW1TU0tLVEVJNDVpeG5M?=
 =?utf-8?B?UmV2MjVXWmtRWlNmSHI3RkJybi9VMksvMlZ4UXh3cktRNlZEUGZWREJRZDhp?=
 =?utf-8?B?VjBDbUV5WFBoTEtyN0VBMUZMNDVEMW1PTVlDOUczVEhIM3BDa2dUU2EyZ0pI?=
 =?utf-8?B?dGZJUEhvc1VIZEhKRjZaUkU3ODQ1cG9veVlnRWE5MUx4WXVzcStkNHdlTHVN?=
 =?utf-8?B?LzV5QU94SUJMaGprOW9aem9xdHRTRXRYRWRMNFQyYnRuUnNneE14dVRSdmRv?=
 =?utf-8?B?QUpXRGJRRlM0UGJma2J6M2VkK2RaWnltb1JKSlJjeGxoY083cW0wTXh2SFlF?=
 =?utf-8?B?c2FoWU5WNzhxWWhXeFJnT1JUWmFzdFIxZ24wNnp5VkV1VDRiTmdQdy9qWkY1?=
 =?utf-8?B?anF2dDl5Z2JWNTFzY29DamxET3pZNG5BTGtrbUY0aDJHcytQWkVBd0pDRHhj?=
 =?utf-8?B?cnpLUWZCYUpBbXQ1elNPRCsxK2tsRUZGK1loUWpYNnVIU0FZdE01c3pDcksv?=
 =?utf-8?B?c0IrdGs4NUY5VGJDcGI2MmxMczRSV1NyNkJKdzRRZGtrbDk4bmd1SHEvNE45?=
 =?utf-8?B?OUJob0I5ZzhUc25yODFPZ2ppREc0NFVLMnVCejhscm5DKzdwRlllM0lETnJy?=
 =?utf-8?B?SWROaG9uU2tWQTdqMXZhTGNST3hnMEZHVlBHcnVpdzRYNTNZM1hka3Q0enI3?=
 =?utf-8?B?bm1Rajl0R0tVSVpjZzUzQTJDcUprbFRaTXR3THZLUlZXNmJEYlNpdUUvaWRt?=
 =?utf-8?B?SEVkaUpXMkQzVFgvOTJZMnRkN0Y5Znd0TlRQM0w3WHl6aG5NeENrZWMyb2xl?=
 =?utf-8?B?VGE3bHRwRUptRDNIaHZCRFJENjJwVjNGYi83bnFqeDNtSGhINkRnTkxhVjFi?=
 =?utf-8?B?Rzg2aFBKbk01SE1uMFkvUDlvOXkreUhxY2VwRzAwTmJCZUhDaGwvR0tRQTNm?=
 =?utf-8?B?M2tsYjlLZjU3ek9YcTQ3RGdTS0FtSW5oY0E5ZFJVbUQ5bU9NUTJqWkgvWGor?=
 =?utf-8?B?VzF0WlF0WTBpNkdlcnVWVXYyRWZqeHBvRGNDV1p0NmhucGErb1RqL2VESlJ5?=
 =?utf-8?B?UGVvZnUvanJyQW9jM0hsa2xKcFdRR25hQ29MUElVRWFXUVNwaFY4NTJ4MTQ4?=
 =?utf-8?B?c0VzSVdYMHFwUXhGQjRJMWl3UkhrcVpkUjVweW42UmtlcDdvQ214c0hINUpI?=
 =?utf-8?B?bGw2eVdsbVdDWlNuNzNLbVhnTzBsaXJKQ3BJN2NDVjJDcHRFYWlpWXN6ekpq?=
 =?utf-8?Q?SwPWBD3jKESI+aWFvDizVVWoownGiubgO7oP4bc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnV6L0VpMTRPbjdUdEdYZ1FnUlRkWWpMaS9rbnVNSDhjZ3VKN0VDcER6eHdW?=
 =?utf-8?B?NEt2ejBZeUk3RWlTaEdIRnIvOVRHWk5pSlo2SWRrNzRiQmN1S2VmdmhKV1JL?=
 =?utf-8?B?bDdWYys0dXdIYlh0V1czSUVPdUdScU85V2ZPcWh2SlZhNG10U0lQSHhsUzAy?=
 =?utf-8?B?S1krT3UxTzhnWTdDMi9EMFVhNzBGN294T21jc09KMFdvN2VPQWdqeGR1RlFX?=
 =?utf-8?B?YVBmRmQvMXF2RnNiMmt4R0lnMUZSbXFSRlBlQ1MwUittN3NjTE9kTytLYUFo?=
 =?utf-8?B?MmlJZ3J1NjdOWUhsMGh1QSszQU5rT2RIejNlK0ZSVndZZTk5U2hITWNFT09p?=
 =?utf-8?B?K3dQV3BDUitoNm5sTWJNNDBERVQ1dEpqRVlZbWhZMHVNMnVaUzRwbjRJWkxq?=
 =?utf-8?B?TTl5SDFZVVlBTEhrWVhaSVFIKzI3VUhoV2FBZGZmc1ZYOXlMU1NOZnR2MkNF?=
 =?utf-8?B?NDVHMk5PaDFrWEhueEVHeVRjOHBtUFNNUndLejY5V1ByMkhpRXhWTjVzMlRQ?=
 =?utf-8?B?VHlpVG9vVURIaVZ2R3gwZ1RHaVEvbXRob0hQK1FpMHRtNlVSR2ZmS3VYNkFP?=
 =?utf-8?B?clh2QVdSRVltOEJtQlg0NHUzNXM2WFFiTVlpdSsyT0l0dG54WGVUZ0dHTmVH?=
 =?utf-8?B?c3pjYy9iVG5iT0F4ZmZBVDVpaFBPaFZ6dmRxeVczQkZYOXlHSXFYWFBKQThJ?=
 =?utf-8?B?RXlCdzh1eXFZbG9hamlBWXduOXBHQkNQY3lQcVV3MWtZTC9BWjgwaTJDQUR0?=
 =?utf-8?B?cFhBK0dzUFNBUWlJdjdNUXBOVjNpU1NiRUxPbDBxS2NQQTJEV3pTd2kwaFRE?=
 =?utf-8?B?WXlBeUdCMmRvekR0TlVDN2wyWmwzRzR3d0l5UW1GTjVSRnRzTWp3MFdWWlg2?=
 =?utf-8?B?VXhDck0xOEhRc3JJUk9rang5TGE3UzEwYjR0aXZtT0dIdUdBVGsyNmhQdll1?=
 =?utf-8?B?QmU2Tmtsb2NMVitwTUgxRS9icUVrcE9Nd3BrS0hNbEUvczM3c1JLQU5rUzJx?=
 =?utf-8?B?MDVYL2pqazAranBxSTZubTZBeHNBNWdQbGkzMnQ5MnJZWGZ6c09MUG9GUlhX?=
 =?utf-8?B?V2cxcGVUbTM4aUpFOWJ2ZFFpWDVtTTU1cVVFZVZjSHNOc21pbTUwUmppOHBm?=
 =?utf-8?B?Wnc0MUEvNHpmMHVyL01KbzhJa3hadFYrM3ZUUXZCN003K1BsK2pTQ1dkaDRm?=
 =?utf-8?B?NVZBMXYrcG9LTzJRbEltcVRpc0NxQ3QvTDZhTHNXUXpnL3MxbGZCVXdKeEc1?=
 =?utf-8?B?eUhrMi9ISnVzQ3RSaW01QXJyRytWTjVOSGVTcHVaZDFDdWhmck9WbHljcStq?=
 =?utf-8?B?S3JQOHRXL1VrVUR5U3JwZHkzd1grTWt2ZVpCMGtNV2d1QWJpTytDRlNidXlD?=
 =?utf-8?B?SEdPUDVrcVhWeGNaTk1VeUxWcmlmdldmakx1ZElleitGUTJrQnJBczk5MW1i?=
 =?utf-8?B?N3lnYlhzZUhRZmF2ZVJKL3NWSmJuOVFxL1BXTnhwMUZ6RWdjTG1oZmVwcU54?=
 =?utf-8?B?ZnZLNGdoV0p3K1dZdzN5QWFuK1QzWnd4VjNVaXFuQjhWekVpaTBuOUpVVndT?=
 =?utf-8?B?ZDRkODhNOE1sU1RYYm5odHgzcFMwUEltM2drMFcvbG9yM0R1VVlwZENPOThQ?=
 =?utf-8?B?aGZzTFVJUzk5ajhCRmRMc2NsY0trMmI4Qm9pdE9qRGpHSEV3T21FRERNaFFQ?=
 =?utf-8?B?aHlITkxyYWxoYmVydjRLSWtYSXoyU0lqZ1JJeUd5SzY0dXcyR2x6VkJwUEw0?=
 =?utf-8?B?amYyV3ZNRDlReDg4dm1vWWVrTVY0VmVKVVgzWVF3ZjZKZkwyb2l1UzVUdThj?=
 =?utf-8?B?RGFQMWZzbVdTRzIzQXc1VktNZUZqeVliL3ZTeHZ6MGpEcG03bkM4V1VWQmVX?=
 =?utf-8?B?S1FrUTZlM3EwUFozeWFHVm9CR1lwZXhuSDUvVCtZbGhFaXo1UXhSTjZFUG51?=
 =?utf-8?B?ZTl3Q2lqek52WVg3cEduNVlZRFBWYmw3aEdXNWsxQld4d2hhcE5nYU9WaWtx?=
 =?utf-8?B?K29ZRWZGRUw2T2dUc1NJa2ZPN2R1Tkd2bkVHdWhsNmFJSFhzYVYreWgwTSt0?=
 =?utf-8?B?WGp6UGJCdmFUNERpWVFnVUFQMU13TDgwQjAwczA3VlF0YWtMOUxwVkhUYi9U?=
 =?utf-8?Q?xrAhdZvF841Sk/1V8j9pP6BhA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e20e781-8497-4f2d-6ba4-08dcf4e13a81
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:38:57.3019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cT62/6g3WDUj6qFapNwFQtWcddK023ZnP1aUanBT20EDNz8HAX1ikYsM/pKfWmBNnwUs8UJwRKDfV+hjKx579w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256
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

--------------DA1FFAB7DFEF4F7C9BF4BDD2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com 
<mailto:christian.koenig@amd.com>>

On 10/25/2024 8:05 AM, boyuan.zhang@amd.com wrote:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass ip_block instead of adev in set_powergating_state callback function.
> Modify set_powergating_state ip functions for all correspoding ip blocks.
>
> v2: fix a ip block index error.
>
> v3: remove type casting
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c        |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c           |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/cik.c                  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/cik_ih.c               |  2 +-
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/cz_ih.c                |  2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c           |  2 +-
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c              |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c              |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c              |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c            |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c            |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c            |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c          |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c          |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c          |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/nv.c                   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/si.c                   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/si_dma.c               |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/si_ih.c                |  2 +-
>   drivers/gpu/drm/amd/amdgpu/soc15.c                |  2 +-
>   drivers/gpu/drm/amd/amdgpu/soc21.c                |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/soc24.c                |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             |  9 +++++----
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c             |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c             |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c             | 12 ++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c             | 13 +++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c           |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c           |  9 +++++----
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c           |  9 +++++----
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vi.c                   |  2 +-
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
>   drivers/gpu/drm/amd/include/amd_shared.h          |  2 +-
>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        |  2 +-
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        |  2 +-
>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  2 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         |  2 +-
>   82 files changed, 162 insertions(+), 156 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> index 769200cda626..cdea150c801e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -590,10 +590,10 @@ static int acp_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int acp_set_powergating_state(void *handle,
> +static int acp_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				     enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_PG_STATE_GATE);
>   
>   	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index b545940e512b..b4d494e003b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -724,7 +724,9 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>   		/* Disable GFXOFF and PG. Temporary workaround
>   		 * to fix some compute applications issue on GFX9.
>   		 */
> -		adev->ip_blocks[AMD_IP_BLOCK_TYPE_GFX].version->funcs->set_powergating_state((void *)adev, state);
> +		struct amdgpu_ip_block *gfx_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
> +		if (gfx_block != NULL)
> +			gfx_block->version->funcs->set_powergating_state((void *)gfx_block, state);
>   	}
>   	amdgpu_dpm_switch_power_profile(adev,
>   					PP_SMC_POWER_PROFILE_COMPUTE,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2924fa15b74b..2f31a6bf9ec2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2190,7 +2190,7 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
>   		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
>   			continue;
>   		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
> -			(void *)adev, state);
> +			&adev->ip_blocks[i], state);
>   		if (r)
>   			DRM_ERROR("set_powergating_state of IP block <%s> failed %d\n",
>   				  adev->ip_blocks[i].version->funcs->name, r);
> @@ -3165,7 +3165,7 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
>   		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_JPEG &&
>   		    adev->ip_blocks[i].version->funcs->set_powergating_state) {
>   			/* enable powergating to save power */
> -			r = adev->ip_blocks[i].version->funcs->set_powergating_state((void *)adev,
> +			r = adev->ip_blocks[i].version->funcs->set_powergating_state(&adev->ip_blocks[i],
>   											state);
>   			if (r) {
>   				DRM_ERROR("set_powergating_state(gate) of IP block <%s> failed %d\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index 263ce1811cc8..bc3b5bfc3423 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -134,7 +134,7 @@ static int isp_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int isp_set_powergating_state(void *handle,
> +static int isp_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				     enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index abd5e980c9c7..14ff69ea2d88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3818,7 +3818,7 @@ static int psp_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int psp_set_powergating_state(void *handle,
> +static int psp_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				     enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index 8bf28d336807..1bd804a8fdb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -638,7 +638,7 @@ static int amdgpu_vkms_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int amdgpu_vkms_set_powergating_state(void *handle,
> +static int amdgpu_vkms_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 46713a158d90..17cd1d66a056 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -644,10 +644,10 @@ static int vpe_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int vpe_set_powergating_state(void *handle,
> +static int vpe_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				     enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_vpe *vpe = &adev->vpe;
>   
>   	if (!adev->pm.dpm_enabled)
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index e2cb1f080e88..b5055181b050 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -2167,7 +2167,7 @@ static int cik_common_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int cik_common_set_powergating_state(void *handle,
> +static int cik_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					    enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> index 1da17755ad53..c49482793c12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> @@ -408,7 +408,7 @@ static int cik_ih_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int cik_ih_set_powergating_state(void *handle,
> +static int cik_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index ede1a028d48d..8da334c71419 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -1204,7 +1204,7 @@ static int cik_sdma_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int cik_sdma_set_powergating_state(void *handle,
> +static int cik_sdma_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> index d72973bd570d..67554e322386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> @@ -405,7 +405,7 @@ static int cz_ih_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int cz_ih_set_powergating_state(void *handle,
> +static int cz_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	// TODO
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index 5098c50d54c8..cd874f9e9a70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -3308,7 +3308,7 @@ static int dce_v10_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int dce_v10_0_set_powergating_state(void *handle,
> +static int dce_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> index c5680ff4ab9f..ec908b524f61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -3440,7 +3440,7 @@ static int dce_v11_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int dce_v11_0_set_powergating_state(void *handle,
> +static int dce_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index eb7de9122d99..ee7b69a63f17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -3130,7 +3130,7 @@ static int dce_v6_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int dce_v6_0_set_powergating_state(void *handle,
> +static int dce_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index 04b79ff87f75..cc4f986bd533 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -3218,7 +3218,7 @@ static int dce_v8_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int dce_v8_0_set_powergating_state(void *handle,
> +static int dce_v8_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 9da95b25e158..2a7a77317d90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3673,7 +3673,7 @@ static void gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
>   static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
>   					       unsigned int vmid);
>   
> -static int gfx_v10_0_set_powergating_state(void *handle,
> +static int gfx_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state);
>   static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
>   {
> @@ -7451,7 +7451,7 @@ static int gfx_v10_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	 * otherwise the gfxoff disallowing will be failed to set.
>   	 */
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(10, 3, 1))
> -		gfx_v10_0_set_powergating_state(ip_block->adev, AMD_PG_STATE_UNGATE);
> +		gfx_v10_0_set_powergating_state(ip_block, AMD_PG_STATE_UNGATE);
>   
>   	if (!adev->no_hw_access) {
>   		if (amdgpu_async_gfx_ring) {
> @@ -8339,10 +8339,10 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs_sriov = {
>   	.is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,
>   };
>   
> -static int gfx_v10_0_set_powergating_state(void *handle,
> +static int gfx_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_PG_STATE_GATE);
>   
>   	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5aff8f72de9c..3e9b6b88b6a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5430,10 +5430,10 @@ static void gfx_v11_cntl_pg(struct amdgpu_device *adev, bool enable)
>   	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>   }
>   
> -static int gfx_v11_0_set_powergating_state(void *handle,
> +static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_PG_STATE_GATE);
>   
>   	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 9fec28d8a5fc..94459162803c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3858,10 +3858,10 @@ static void gfx_v12_cntl_pg(struct amdgpu_device *adev, bool enable)
>   }
>   #endif
>   
> -static int gfx_v12_0_set_powergating_state(void *handle,
> +static int gfx_v12_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_PG_STATE_GATE);
>   
>   	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 41f50bf380c4..2e1e8a49c66e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -3395,11 +3395,11 @@ static int gfx_v6_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int gfx_v6_0_set_powergating_state(void *handle,
> +static int gfx_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	bool gate = false;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (state == AMD_PG_STATE_GATE)
>   		gate = true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 824d5913103b..0124f86f8e63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4869,11 +4869,11 @@ static int gfx_v7_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int gfx_v7_0_set_powergating_state(void *handle,
> +static int gfx_v7_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	bool gate = false;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (state == AMD_PG_STATE_GATE)
>   		gate = true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 9f5a5b2e6de6..f85e545653c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5360,10 +5360,10 @@ static void cz_update_gfx_cg_power_gating(struct amdgpu_device *adev,
>   	}
>   }
>   
> -static int gfx_v8_0_set_powergating_state(void *handle,
> +static int gfx_v8_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_PG_STATE_GATE);
>   
>   	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 66947850d7e4..c6f6907eb363 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5226,10 +5226,10 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
>   	.is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,
>   };
>   
> -static int gfx_v9_0_set_powergating_state(void *handle,
> +static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_PG_STATE_GATE);
>   
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 016290f00592..d61f53921723 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2756,7 +2756,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_4_3_rlc_funcs = {
>   	.is_rlcg_access_range = gfx_v9_4_3_is_rlcg_access_range,
>   };
>   
> -static int gfx_v9_4_3_set_powergating_state(void *handle,
> +static int gfx_v9_4_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 697599c46240..738226310690 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1131,7 +1131,7 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u64 *flags)
>   		athub_v2_0_get_clockgating(adev, flags);
>   }
>   
> -static int gmc_v10_0_set_powergating_state(void *handle,
> +static int gmc_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index f893ab4c14df..b73cd4f9df48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -1018,7 +1018,7 @@ static void gmc_v11_0_get_clockgating_state(void *handle, u64 *flags)
>   	athub_v3_0_get_clockgating(adev, flags);
>   }
>   
> -static int gmc_v11_0_set_powergating_state(void *handle,
> +static int gmc_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index d22b027fd0bb..0ed26d24fc9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -1002,7 +1002,7 @@ static void gmc_v12_0_get_clockgating_state(void *handle, u64 *flags)
>   	athub_v4_1_0_get_clockgating(adev, flags);
>   }
>   
> -static int gmc_v12_0_set_powergating_state(void *handle,
> +static int gmc_v12_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index ca000b3d1afc..8575b0219e8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -1100,7 +1100,7 @@ static int gmc_v6_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int gmc_v6_0_set_powergating_state(void *handle,
> +static int gmc_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 07f45f1a503a..3025ac476b52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1327,7 +1327,7 @@ static int gmc_v7_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int gmc_v7_0_set_powergating_state(void *handle,
> +static int gmc_v7_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 12d5967ecd45..20a6d6e192eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1679,7 +1679,7 @@ static int gmc_v8_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int gmc_v8_0_set_powergating_state(void *handle,
> +static int gmc_v8_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index f43ded8a0aab..c4918154580a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2562,7 +2562,7 @@ static void gmc_v9_0_get_clockgating_state(void *handle, u64 *flags)
>   	athub_v1_0_get_clockgating(adev, flags);
>   }
>   
> -static int gmc_v9_0_set_powergating_state(void *handle,
> +static int gmc_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> index 7f45e93c0397..be3a578596ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> @@ -398,7 +398,7 @@ static int iceland_ih_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int iceland_ih_set_powergating_state(void *handle,
> +static int iceland_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index 38f953fd65d9..b004dc88cbb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -756,10 +756,10 @@ static void ih_v6_0_update_ih_mem_power_gating(struct amdgpu_device *adev,
>   	WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
>   }
>   
> -static int ih_v6_0_set_powergating_state(void *handle,
> +static int ih_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					 enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_PG_STATE_GATE);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> index 61381e0c3795..27d9d4965757 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> @@ -737,10 +737,10 @@ static void ih_v6_1_update_ih_mem_power_gating(struct amdgpu_device *adev,
>   	WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
>   }
>   
> -static int ih_v6_1_set_powergating_state(void *handle,
> +static int ih_v6_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					 enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_PG_STATE_GATE);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index d2428cf5d385..d37f5a813007 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -727,10 +727,10 @@ static void ih_v7_0_update_ih_mem_power_gating(struct amdgpu_device *adev,
>   	WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
>   }
>   
> -static int ih_v7_0_set_powergating_state(void *handle,
> +static int ih_v7_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					 enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_PG_STATE_GATE);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_IH_SRAM_PG)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index d6823fb45d32..38938a624658 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -35,7 +35,7 @@
>   
>   static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void jpeg_v2_0_set_irq_funcs(struct amdgpu_device *adev);
> -static int jpeg_v2_0_set_powergating_state(void *handle,
> +static int jpeg_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
>   
>   /**
> @@ -154,7 +154,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> -		jpeg_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +		jpeg_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   
>   	return 0;
>   }
> @@ -692,10 +692,10 @@ static int jpeg_v2_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int jpeg_v2_0_set_powergating_state(void *handle,
> +static int jpeg_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	if (state == adev->jpeg.cur_state)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 5063a38801d6..a0c0e8bd5978 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -38,7 +38,7 @@
>   
>   static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev);
> -static int jpeg_v2_5_set_powergating_state(void *handle,
> +static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
>   static void jpeg_v2_5_set_ras_funcs(struct amdgpu_device *adev);
>   
> @@ -219,7 +219,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   		      RREG32_SOC15(JPEG, i, mmUVD_JRBC_STATUS))
> -			jpeg_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +			jpeg_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   
>   		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
>   			amdgpu_irq_put(adev, &adev->jpeg.inst[i].ras_poison_irq, 0);
> @@ -541,10 +541,10 @@ static int jpeg_v2_5_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int jpeg_v2_5_set_powergating_state(void *handle,
> +static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	if (state == adev->jpeg.cur_state)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 10adbb7cbf53..057e0c043de5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -36,7 +36,7 @@
>   
>   static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev);
> -static int jpeg_v3_0_set_powergating_state(void *handle,
> +static int jpeg_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
>   
>   /**
> @@ -168,7 +168,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> -		jpeg_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +		jpeg_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   
>   	return 0;
>   }
> @@ -483,10 +483,10 @@ static int jpeg_v3_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int jpeg_v3_0_set_powergating_state(void *handle,
> +static int jpeg_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	if(state == adev->jpeg.cur_state)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 89953c0f5f1f..7a79fac9962c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -39,7 +39,7 @@
>   static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev);
>   static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void jpeg_v4_0_set_irq_funcs(struct amdgpu_device *adev);
> -static int jpeg_v4_0_set_powergating_state(void *handle,
> +static int jpeg_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
>   static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev);
>   
> @@ -199,7 +199,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	if (!amdgpu_sriov_vf(adev)) {
>   		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> -			jpeg_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +			jpeg_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   	}
>   	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
>   		amdgpu_irq_put(adev, &adev->jpeg.inst->ras_poison_irq, 0);
> @@ -645,10 +645,10 @@ static int jpeg_v4_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int jpeg_v4_0_set_powergating_state(void *handle,
> +static int jpeg_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	if (amdgpu_sriov_vf(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 6917e4a8e96a..30ab807be2bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -43,7 +43,7 @@ enum jpeg_engin_status {
>   
>   static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
> -static int jpeg_v4_0_3_set_powergating_state(void *handle,
> +static int jpeg_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
>   static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
>   static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -371,7 +371,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	if (!amdgpu_sriov_vf(adev)) {
>   		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> -			ret = jpeg_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +			ret = jpeg_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   	}
>   
>   	return ret;
> @@ -960,10 +960,10 @@ static int jpeg_v4_0_3_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int jpeg_v4_0_3_set_powergating_state(void *handle,
> +static int jpeg_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	if (amdgpu_sriov_vf(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index f3cce523f3cb..2b25e8f71f4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -48,7 +48,7 @@
>   
>   static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void jpeg_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
> -static int jpeg_v4_0_5_set_powergating_state(void *handle,
> +static int jpeg_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
>   
>   static void jpeg_v4_0_5_dec_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -228,7 +228,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   			    RREG32_SOC15(JPEG, i, regUVD_JRBC_STATUS))
> -				jpeg_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +				jpeg_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   		}
>   	}
>   	return 0;
> @@ -676,10 +676,10 @@ static int jpeg_v4_0_5_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int jpeg_v4_0_5_set_powergating_state(void *handle,
> +static int jpeg_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	if (amdgpu_sriov_vf(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index 06840d1dae79..c870f1a361ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -36,7 +36,7 @@
>   
>   static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
> -static int jpeg_v5_0_0_set_powergating_state(void *handle,
> +static int jpeg_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
>   
>   /**
> @@ -165,7 +165,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> -		jpeg_v5_0_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +		jpeg_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   
>   	return 0;
>   }
> @@ -570,10 +570,10 @@ static int jpeg_v5_0_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int jpeg_v5_0_0_set_powergating_state(void *handle,
> +static int jpeg_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	if (state == adev->jpeg.cur_state)
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 0820ed62e2e8..f51b5dae3701 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -677,7 +677,7 @@ static int navi10_ih_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int navi10_ih_set_powergating_state(void *handle,
> +static int navi10_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 6b72169be8f8..5332e510bced 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1070,7 +1070,7 @@ static int nv_common_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int nv_common_set_powergating_state(void *handle,
> +static int nv_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_powergating_state state)
>   {
>   	/* TODO */
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index 7948d74f8722..0c32e614d8e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -1087,7 +1087,7 @@ static int sdma_v2_4_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int sdma_v2_4_set_powergating_state(void *handle,
> +static int sdma_v2_4_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 9a3d729545a7..18f29e2be828 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1506,7 +1506,7 @@ static int sdma_v3_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int sdma_v3_0_set_powergating_state(void *handle,
> +static int sdma_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 3f5959557727..a2f5f2be699b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2312,10 +2312,10 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int sdma_v4_0_set_powergating_state(void *handle,
> +static int sdma_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
>   	case IP_VERSION(4, 1, 0):
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 9c7cea0890c9..95d5de2bd186 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1830,7 +1830,7 @@ static int sdma_v4_4_2_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int sdma_v4_4_2_set_powergating_state(void *handle,
> +static int sdma_v4_4_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index d31c4860933f..9ee5318be89e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1859,7 +1859,7 @@ static int sdma_v5_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int sdma_v5_0_set_powergating_state(void *handle,
> +static int sdma_v5_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index ffa8c62ac101..bd883a35c7eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1818,7 +1818,7 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int sdma_v5_2_set_powergating_state(void *handle,
> +static int sdma_v5_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 234483d346f8..34106702e0ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1594,7 +1594,7 @@ static int sdma_v6_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int sdma_v6_0_set_powergating_state(void *handle,
> +static int sdma_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index d2ce6b6a7ff6..1a5fc7bc7289 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1530,7 +1530,7 @@ static int sdma_v7_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int sdma_v7_0_set_powergating_state(void *handle,
> +static int sdma_v7_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index 00f63d3fbea7..e32615630cca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -2655,7 +2655,7 @@ static int si_common_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int si_common_set_powergating_state(void *handle,
> +static int si_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					    enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> index 47647a6083e8..4b278904cfd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -672,12 +672,12 @@ static int si_dma_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int si_dma_set_powergating_state(void *handle,
> +static int si_dma_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	u32 tmp;
>   
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	WREG32(DMA_PGFSM_WRITE,  0x00002000);
>   	WREG32(DMA_PGFSM_CONFIG, 0x100010ff);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> index 2ec1ebe4db11..ec756d24aaa7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> @@ -269,7 +269,7 @@ static int si_ih_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int si_ih_set_powergating_state(void *handle,
> +static int si_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 93e44e7ee3fa..8c100db42d4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1473,7 +1473,7 @@ static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
>   		adev->df.funcs->get_clockgating_state(adev, flags);
>   }
>   
> -static int soc15_common_set_powergating_state(void *handle,
> +static int soc15_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					    enum amd_powergating_state state)
>   {
>   	/* todo */
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 1c07ebdc0d1f..7556055b8387 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -953,10 +953,10 @@ static int soc21_common_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int soc21_common_set_powergating_state(void *handle,
> +static int soc21_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	switch (amdgpu_ip_version(adev, LSDMA_HWIP, 0)) {
>   	case IP_VERSION(6, 0, 0):
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index 3af10ef4b793..2a408bc65f73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -542,10 +542,10 @@ static int soc24_common_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int soc24_common_set_powergating_state(void *handle,
> +static int soc24_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					      enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	switch (amdgpu_ip_version(adev, LSDMA_HWIP, 0)) {
>   	case IP_VERSION(7, 0, 0):
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index 5a04a6770138..7c02eb0e1540 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -454,7 +454,7 @@ static int tonga_ih_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int tonga_ih_set_powergating_state(void *handle,
> +static int tonga_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index bdbca25d80c4..c66fe0c8d5e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -796,7 +796,7 @@ static int uvd_v3_1_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int uvd_v3_1_set_powergating_state(void *handle,
> +static int uvd_v3_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index a836dc9cfcad..1f3da607c0d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -714,7 +714,7 @@ static int uvd_v4_2_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int uvd_v4_2_set_powergating_state(void *handle,
> +static int uvd_v4_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	/* This doesn't actually powergate the UVD block.
> @@ -724,7 +724,7 @@ static int uvd_v4_2_set_powergating_state(void *handle,
>   	 * revisit this when there is a cleaner line between
>   	 * the smc and the hw blocks
>   	 */
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (state == AMD_PG_STATE_GATE) {
>   		uvd_v4_2_stop(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index ab55fae3569e..50577cc79dcb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -817,7 +817,7 @@ static int uvd_v5_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int uvd_v5_0_set_powergating_state(void *handle,
> +static int uvd_v5_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	/* This doesn't actually powergate the UVD block.
> @@ -827,7 +827,7 @@ static int uvd_v5_0_set_powergating_state(void *handle,
>   	 * revisit this when there is a cleaner line between
>   	 * the smc and the hw blocks
>   	 */
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret = 0;
>   
>   	if (state == AMD_PG_STATE_GATE) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 39f8c3d3a135..4f5dc46802e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -1476,7 +1476,7 @@ static int uvd_v6_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int uvd_v6_0_set_powergating_state(void *handle,
> +static int uvd_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	/* This doesn't actually powergate the UVD block.
> @@ -1486,7 +1486,7 @@ static int uvd_v6_0_set_powergating_state(void *handle,
>   	 * revisit this when there is a cleaner line between
>   	 * the smc and the hw blocks
>   	 */
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret = 0;
>   
>   	WREG32(mmUVD_POWER_STATUS, UVD_POWER_STATUS__UVD_PG_EN_MASK);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index c1ed91b39415..552866990db2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -596,7 +596,7 @@ static int vce_v2_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int vce_v2_0_set_powergating_state(void *handle,
> +static int vce_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	/* This doesn't actually powergate the VCE block.
> @@ -606,7 +606,7 @@ static int vce_v2_0_set_powergating_state(void *handle,
>   	 * revisit this when there is a cleaner line between
>   	 * the smc and the hw blocks
>   	 */
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (state == AMD_PG_STATE_GATE)
>   		return vce_v2_0_stop(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 6bb318a06f19..6f4a2476b9fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -801,7 +801,7 @@ static int vce_v3_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int vce_v3_0_set_powergating_state(void *handle,
> +static int vce_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	/* This doesn't actually powergate the VCE block.
> @@ -811,7 +811,7 @@ static int vce_v3_0_set_powergating_state(void *handle,
>   	 * revisit this when there is a cleaner line between
>   	 * the smc and the hw blocks
>   	 */
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret = 0;
>   
>   	if (state == AMD_PG_STATE_GATE) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 79ee555768a5..04bfa3b59f75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -691,7 +691,7 @@ static int vce_v4_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int vce_v4_0_set_powergating_state(void *handle,
> +static int vce_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	/* This doesn't actually powergate the VCE block.
> @@ -701,7 +701,7 @@ static int vce_v4_0_set_powergating_state(void *handle,
>   	 * revisit this when there is a cleaner line between
>   	 * the smc and the hw blocks
>   	 */
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (state == AMD_PG_STATE_GATE)
>   		return vce_v4_0_stop(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 7ad2ab3affe4..32b0159953f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -85,7 +85,8 @@ static int vcn_v1_0_stop(struct amdgpu_device *adev);
>   static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
> -static int vcn_v1_0_set_powergating_state(void *handle, enum amd_powergating_state state);
> +static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +				enum amd_powergating_state state);
>   static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
>   				int inst_idx, struct dpg_pause_state *new_state);
>   
> @@ -281,7 +282,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>   		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
> -		vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   	}
>   
>   	return 0;
> @@ -1799,7 +1800,7 @@ static void vcn_v1_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t coun
>   	}
>   }
>   
> -static int vcn_v1_0_set_powergating_state(void *handle,
> +static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	/* This doesn't actually powergate the VCN block.
> @@ -1810,7 +1811,7 @@ static int vcn_v1_0_set_powergating_state(void *handle,
>   	 * the smc and the hw blocks
>   	 */
>   	int ret;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (state == adev->vcn.cur_state)
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index f34cab96d0b4..798d06563c65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -92,7 +92,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_0[] = {
>   static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
> -static int vcn_v2_0_set_powergating_state(void *handle,
> +static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
>   static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
>   				int inst_idx, struct dpg_pause_state *new_state);
> @@ -318,7 +318,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
> -		vcn_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   
>   	return 0;
>   }
> @@ -1796,7 +1796,7 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
>   }
>   
>   
> -static int vcn_v2_0_set_powergating_state(void *handle,
> +static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	/* This doesn't actually powergate the VCN block.
> @@ -1807,7 +1807,7 @@ static int vcn_v2_0_set_powergating_state(void *handle,
>   	 * the smc and the hw blocks
>   	 */
>   	int ret;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index beab2c24042d..d00406e057d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -95,7 +95,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
>   static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
> -static int vcn_v2_5_set_powergating_state(void *handle,
> +static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
>   static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   				int inst_idx, struct dpg_pause_state *new_state);
> @@ -399,7 +399,7 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>   		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
> -			vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   
>   		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
>   			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
> @@ -1825,10 +1825,10 @@ static int vcn_v2_5_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int vcn_v2_5_set_powergating_state(void *handle,
> +static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 6d047257490c..d761bc7c31bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -105,7 +105,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
> -static int vcn_v3_0_set_powergating_state(void *handle,
> +static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   			enum amd_powergating_state state);
>   static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>   			int inst_idx, struct dpg_pause_state *new_state);
> @@ -430,9 +430,9 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -					(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -					 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
> -				vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
> +				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   			}
>   		}
>   	}
> @@ -2159,10 +2159,10 @@ static int vcn_v3_0_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int vcn_v3_0_set_powergating_state(void *handle,
> +static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 4b836b4935e2..8c1d9afa81ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -96,7 +96,7 @@ static int amdgpu_ih_clientid_vcns[] = {
>   static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
>   static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
> -static int vcn_v4_0_set_powergating_state(void *handle,
> +static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>           enum amd_powergating_state state);
>   static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
>           int inst_idx, struct dpg_pause_state *new_state);
> @@ -357,9 +357,9 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   			continue;
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -                        (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -                                RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -                        vcn_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   			}
>   		}
>   		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> @@ -2037,9 +2037,10 @@ static int vcn_v4_0_set_clockgating_state(void *handle, enum amd_clockgating_sta
>    *
>    * Set VCN block powergating state
>    */
> -static int vcn_v4_0_set_powergating_state(void *handle, enum amd_powergating_state state)
> +static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 868302d63a4b..4ac6ee75b27d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -87,7 +87,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
>   static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>   static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
> -static int vcn_v4_0_3_set_powergating_state(void *handle,
> +static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		enum amd_powergating_state state);
>   static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
>   		int inst_idx, struct dpg_pause_state *new_state);
> @@ -319,7 +319,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>   	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
> -		vcn_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   
>   	return 0;
>   }
> @@ -1623,10 +1623,10 @@ static int vcn_v4_0_3_set_clockgating_state(void *handle,
>    *
>    * Set VCN block powergating state
>    */
> -static int vcn_v4_0_3_set_powergating_state(void *handle,
> +static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f0ec8bc031c6..13c0fc9f9894 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -95,7 +95,7 @@ static int amdgpu_ih_clientid_vcns[] = {
>   
>   static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
> -static int vcn_v4_0_5_set_powergating_state(void *handle,
> +static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		enum amd_powergating_state state);
>   static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
>   		int inst_idx, struct dpg_pause_state *new_state);
> @@ -309,7 +309,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>   				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -				vcn_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   			}
>   		}
>   	}
> @@ -1531,9 +1531,10 @@ static int vcn_v4_0_5_set_clockgating_state(void *handle, enum amd_clockgating_s
>    *
>    * Set VCN block powergating state
>    */
> -static int vcn_v4_0_5_set_powergating_state(void *handle, enum amd_powergating_state state)
> +static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +		enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	if (state == adev->vcn.cur_state)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 9f89e152e875..9d16747484c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -78,7 +78,7 @@ static int amdgpu_ih_clientid_vcns[] = {
>   
>   static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
> -static int vcn_v5_0_0_set_powergating_state(void *handle,
> +static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		enum amd_powergating_state state);
>   static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
>   		int inst_idx, struct dpg_pause_state *new_state);
> @@ -273,7 +273,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>   				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -				vcn_v5_0_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   			}
>   		}
>   	}
> @@ -1258,9 +1258,10 @@ static int vcn_v5_0_0_set_clockgating_state(void *handle, enum amd_clockgating_s
>    *
>    * Set VCN block powergating state
>    */
> -static int vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_state state)
> +static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +		enum amd_powergating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int ret;
>   
>   	if (state == adev->vcn.cur_state)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 0fedadd0a6a4..039f1ae2df02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -616,7 +616,7 @@ static int vega10_ih_set_clockgating_state(void *handle,
>   
>   }
>   
> -static int vega10_ih_set_powergating_state(void *handle,
> +static int vega10_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 1c9aff742e43..a8e88c9f6ae5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -708,7 +708,7 @@ static int vega20_ih_set_clockgating_state(void *handle,
>   
>   }
>   
> -static int vega20_ih_set_powergating_state(void *handle,
> +static int vega20_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index b3fa54c0514e..471a66dad9b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1988,7 +1988,7 @@ static int vi_common_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int vi_common_set_powergating_state(void *handle,
> +static int vi_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					    enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bbfc47f6595f..fbdfe37cb93e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -961,7 +961,7 @@ static int dm_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int dm_set_powergating_state(void *handle,
> +static int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 7eefcb0f5070..0f20abbfd381 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -403,7 +403,7 @@ struct amd_ip_funcs {
>   	int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
>   	int (*set_clockgating_state)(void *handle,
>   				     enum amd_clockgating_state state);
> -	int (*set_powergating_state)(void *handle,
> +	int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
>   				     enum amd_powergating_state state);
>   	void (*get_clockgating_state)(void *handle, u64 *flags);
>   	void (*dump_ip_state)(struct amdgpu_ip_block *ip_block);
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index f0f81ecd9ad6..bb8b0799ab7c 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -3183,7 +3183,7 @@ static int kv_dpm_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int kv_dpm_set_powergating_state(void *handle,
> +static int kv_dpm_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index ee23a0f897c5..ed8f755e9ff6 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7855,7 +7855,7 @@ static int si_dpm_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int si_dpm_set_powergating_state(void *handle,
> +static int si_dpm_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 90500b419d60..a3d1c5aa3b3e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -244,7 +244,7 @@ static bool pp_is_idle(void *handle)
>   	return false;
>   }
>   
> -static int pp_set_powergating_state(void *handle,
> +static int pp_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				    enum amd_powergating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c5ef8806dbb3..8d07757adf04 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2198,7 +2198,7 @@ static int smu_set_clockgating_state(void *handle,
>   	return 0;
>   }
>   
> -static int smu_set_powergating_state(void *handle,
> +static int smu_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				     enum amd_powergating_state state)
>   {
>   	return 0;

--------------DA1FFAB7DFEF4F7C9BF4BDD2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <p>
    </p>
    <p>Reviewed-by: Sunil Khatri &lt;<a href="mailto:christian.koenig@amd.com">sunil.khatri@amd.com</a>&gt;</p>
    <p><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman",serif;}
</style>
<![endif]--></p>
    <div class="moz-cite-prefix">On 10/25/2024 8:05 AM,
      <a class="moz-txt-link-abbreviated" href="mailto:boyuan.zhang@amd.com">boyuan.zhang@amd.com</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241025023545.465886-8-boyuan.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>

Pass ip_block instead of adev in set_powergating_state callback function.
Modify set_powergating_state ip functions for all correspoding ip blocks.

v2: fix a ip block index error.

v3: remove type casting

Signed-off-by: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>
Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Acked-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c        |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/cik.c                  |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c               |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c          |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c          |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c          |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/si.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c               |  4 ++--
 drivers/gpu/drm/amd/amdgpu/si_ih.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc24.c                |  4 ++--
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c             |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c             |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c             | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c             | 13 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c           |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c           |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c           |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                   |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h          |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         |  2 +-
 82 files changed, 162 insertions(+), 156 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 769200cda626..cdea150c801e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -590,10 +590,10 @@ static int acp_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int acp_set_powergating_state(void *handle,
+static int acp_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index b545940e512b..b4d494e003b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -724,7 +724,9 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 		/* Disable GFXOFF and PG. Temporary workaround
 		 * to fix some compute applications issue on GFX9.
 		 */
-		adev-&gt;ip_blocks[AMD_IP_BLOCK_TYPE_GFX].version-&gt;funcs-&gt;set_powergating_state((void *)adev, state);
+		struct amdgpu_ip_block *gfx_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
+		if (gfx_block != NULL)
+			gfx_block-&gt;version-&gt;funcs-&gt;set_powergating_state((void *)gfx_block, state);
 	}
 	amdgpu_dpm_switch_power_profile(adev,
 					PP_SMC_POWER_PROFILE_COMPUTE,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2924fa15b74b..2f31a6bf9ec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2190,7 +2190,7 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 		if (!adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;set_powergating_state)
 			continue;
 		r = adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;set_powergating_state(
-			(void *)adev, state);
+			&amp;adev-&gt;ip_blocks[i], state);
 		if (r)
 			DRM_ERROR(&quot;set_powergating_state of IP block &lt;%s&gt; failed %d\n&quot;,
 				  adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;name, r);
@@ -3165,7 +3165,7 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 		    adev-&gt;ip_blocks[i].version-&gt;type != AMD_IP_BLOCK_TYPE_JPEG &amp;&amp;
 		    adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;set_powergating_state) {
 			/* enable powergating to save power */
-			r = adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;set_powergating_state((void *)adev,
+			r = adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;set_powergating_state(&amp;adev-&gt;ip_blocks[i],
 											state);
 			if (r) {
 				DRM_ERROR(&quot;set_powergating_state(gate) of IP block &lt;%s&gt; failed %d\n&quot;,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 263ce1811cc8..bc3b5bfc3423 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -134,7 +134,7 @@ static int isp_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int isp_set_powergating_state(void *handle,
+static int isp_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index abd5e980c9c7..14ff69ea2d88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3818,7 +3818,7 @@ static int psp_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int psp_set_powergating_state(void *handle,
+static int psp_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 8bf28d336807..1bd804a8fdb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -638,7 +638,7 @@ static int amdgpu_vkms_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int amdgpu_vkms_set_powergating_state(void *handle,
+static int amdgpu_vkms_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 46713a158d90..17cd1d66a056 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -644,10 +644,10 @@ static int vpe_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vpe_set_powergating_state(void *handle,
+static int vpe_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	struct amdgpu_vpe *vpe = &amp;adev-&gt;vpe;
 
 	if (!adev-&gt;pm.dpm_enabled)
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index e2cb1f080e88..b5055181b050 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2167,7 +2167,7 @@ static int cik_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int cik_common_set_powergating_state(void *handle,
+static int cik_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 1da17755ad53..c49482793c12 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -408,7 +408,7 @@ static int cik_ih_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int cik_ih_set_powergating_state(void *handle,
+static int cik_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index ede1a028d48d..8da334c71419 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1204,7 +1204,7 @@ static int cik_sdma_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int cik_sdma_set_powergating_state(void *handle,
+static int cik_sdma_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index d72973bd570d..67554e322386 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -405,7 +405,7 @@ static int cz_ih_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int cz_ih_set_powergating_state(void *handle,
+static int cz_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	// TODO
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 5098c50d54c8..cd874f9e9a70 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -3308,7 +3308,7 @@ static int dce_v10_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int dce_v10_0_set_powergating_state(void *handle,
+static int dce_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index c5680ff4ab9f..ec908b524f61 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3440,7 +3440,7 @@ static int dce_v11_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int dce_v11_0_set_powergating_state(void *handle,
+static int dce_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index eb7de9122d99..ee7b69a63f17 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -3130,7 +3130,7 @@ static int dce_v6_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int dce_v6_0_set_powergating_state(void *handle,
+static int dce_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 04b79ff87f75..cc4f986bd533 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -3218,7 +3218,7 @@ static int dce_v8_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int dce_v8_0_set_powergating_state(void *handle,
+static int dce_v8_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9da95b25e158..2a7a77317d90 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3673,7 +3673,7 @@ static void gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 					       unsigned int vmid);
 
-static int gfx_v10_0_set_powergating_state(void *handle,
+static int gfx_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
@@ -7451,7 +7451,7 @@ static int gfx_v10_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	 * otherwise the gfxoff disallowing will be failed to set.
 	 */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(10, 3, 1))
-		gfx_v10_0_set_powergating_state(ip_block-&gt;adev, AMD_PG_STATE_UNGATE);
+		gfx_v10_0_set_powergating_state(ip_block, AMD_PG_STATE_UNGATE);
 
 	if (!adev-&gt;no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
@@ -8339,10 +8339,10 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs_sriov = {
 	.is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,
 };
 
-static int gfx_v10_0_set_powergating_state(void *handle,
+static int gfx_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..3e9b6b88b6a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5430,10 +5430,10 @@ static void gfx_v11_cntl_pg(struct amdgpu_device *adev, bool enable)
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
-static int gfx_v11_0_set_powergating_state(void *handle,
+static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9fec28d8a5fc..94459162803c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3858,10 +3858,10 @@ static void gfx_v12_cntl_pg(struct amdgpu_device *adev, bool enable)
 }
 #endif
 
-static int gfx_v12_0_set_powergating_state(void *handle,
+static int gfx_v12_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 41f50bf380c4..2e1e8a49c66e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3395,11 +3395,11 @@ static int gfx_v6_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int gfx_v6_0_set_powergating_state(void *handle,
+static int gfx_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	bool gate = false;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (state == AMD_PG_STATE_GATE)
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 824d5913103b..0124f86f8e63 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4869,11 +4869,11 @@ static int gfx_v7_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int gfx_v7_0_set_powergating_state(void *handle,
+static int gfx_v7_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	bool gate = false;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (state == AMD_PG_STATE_GATE)
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 9f5a5b2e6de6..f85e545653c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5360,10 +5360,10 @@ static void cz_update_gfx_cg_power_gating(struct amdgpu_device *adev,
 	}
 }
 
-static int gfx_v8_0_set_powergating_state(void *handle,
+static int gfx_v8_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 66947850d7e4..c6f6907eb363 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5226,10 +5226,10 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,
 };
 
-static int gfx_v9_0_set_powergating_state(void *handle,
+static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 016290f00592..d61f53921723 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2756,7 +2756,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_4_3_rlc_funcs = {
 	.is_rlcg_access_range = gfx_v9_4_3_is_rlcg_access_range,
 };
 
-static int gfx_v9_4_3_set_powergating_state(void *handle,
+static int gfx_v9_4_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 697599c46240..738226310690 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1131,7 +1131,7 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u64 *flags)
 		athub_v2_0_get_clockgating(adev, flags);
 }
 
-static int gmc_v10_0_set_powergating_state(void *handle,
+static int gmc_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index f893ab4c14df..b73cd4f9df48 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -1018,7 +1018,7 @@ static void gmc_v11_0_get_clockgating_state(void *handle, u64 *flags)
 	athub_v3_0_get_clockgating(adev, flags);
 }
 
-static int gmc_v11_0_set_powergating_state(void *handle,
+static int gmc_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index d22b027fd0bb..0ed26d24fc9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -1002,7 +1002,7 @@ static void gmc_v12_0_get_clockgating_state(void *handle, u64 *flags)
 	athub_v4_1_0_get_clockgating(adev, flags);
 }
 
-static int gmc_v12_0_set_powergating_state(void *handle,
+static int gmc_v12_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index ca000b3d1afc..8575b0219e8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -1100,7 +1100,7 @@ static int gmc_v6_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int gmc_v6_0_set_powergating_state(void *handle,
+static int gmc_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 07f45f1a503a..3025ac476b52 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1327,7 +1327,7 @@ static int gmc_v7_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int gmc_v7_0_set_powergating_state(void *handle,
+static int gmc_v7_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 12d5967ecd45..20a6d6e192eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1679,7 +1679,7 @@ static int gmc_v8_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int gmc_v8_0_set_powergating_state(void *handle,
+static int gmc_v8_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f43ded8a0aab..c4918154580a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2562,7 +2562,7 @@ static void gmc_v9_0_get_clockgating_state(void *handle, u64 *flags)
 	athub_v1_0_get_clockgating(adev, flags);
 }
 
-static int gmc_v9_0_set_powergating_state(void *handle,
+static int gmc_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index 7f45e93c0397..be3a578596ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -398,7 +398,7 @@ static int iceland_ih_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int iceland_ih_set_powergating_state(void *handle,
+static int iceland_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 38f953fd65d9..b004dc88cbb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -756,10 +756,10 @@ static void ih_v6_0_update_ih_mem_power_gating(struct amdgpu_device *adev,
 	WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
 }
 
-static int ih_v6_0_set_powergating_state(void *handle,
+static int ih_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					 enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_IH_SRAM_PG)
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 61381e0c3795..27d9d4965757 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -737,10 +737,10 @@ static void ih_v6_1_update_ih_mem_power_gating(struct amdgpu_device *adev,
 	WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
 }
 
-static int ih_v6_1_set_powergating_state(void *handle,
+static int ih_v6_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					 enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_IH_SRAM_PG)
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index d2428cf5d385..d37f5a813007 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -727,10 +727,10 @@ static void ih_v7_0_update_ih_mem_power_gating(struct amdgpu_device *adev,
 	WREG32_SOC15(OSSSYS, 0, regIH_MEM_POWER_CTRL, ih_mem_pwr_cntl);
 }
 
-static int ih_v7_0_set_powergating_state(void *handle,
+static int ih_v7_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					 enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_IH_SRAM_PG)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index d6823fb45d32..38938a624658 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -35,7 +35,7 @@
 
 static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v2_0_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v2_0_set_powergating_state(void *handle,
+static int jpeg_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 
 /**
@@ -154,7 +154,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (adev-&gt;jpeg.cur_state != AMD_PG_STATE_GATE &amp;&amp;
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
-		jpeg_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		jpeg_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
 }
@@ -692,10 +692,10 @@ static int jpeg_v2_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v2_0_set_powergating_state(void *handle,
+static int jpeg_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	if (state == adev-&gt;jpeg.cur_state)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 5063a38801d6..a0c0e8bd5978 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -38,7 +38,7 @@
 
 static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v2_5_set_powergating_state(void *handle,
+static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static void jpeg_v2_5_set_ras_funcs(struct amdgpu_device *adev);
 
@@ -219,7 +219,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (adev-&gt;jpeg.cur_state != AMD_PG_STATE_GATE &amp;&amp;
 		      RREG32_SOC15(JPEG, i, mmUVD_JRBC_STATUS))
-			jpeg_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+			jpeg_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
 			amdgpu_irq_put(adev, &amp;adev-&gt;jpeg.inst[i].ras_poison_irq, 0);
@@ -541,10 +541,10 @@ static int jpeg_v2_5_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v2_5_set_powergating_state(void *handle,
+static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	if (state == adev-&gt;jpeg.cur_state)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 10adbb7cbf53..057e0c043de5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -36,7 +36,7 @@
 
 static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v3_0_set_powergating_state(void *handle,
+static int jpeg_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 
 /**
@@ -168,7 +168,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (adev-&gt;jpeg.cur_state != AMD_PG_STATE_GATE &amp;&amp;
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
-		jpeg_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		jpeg_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
 }
@@ -483,10 +483,10 @@ static int jpeg_v3_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v3_0_set_powergating_state(void *handle,
+static int jpeg_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	if(state == adev-&gt;jpeg.cur_state)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 89953c0f5f1f..7a79fac9962c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -39,7 +39,7 @@
 static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev);
 static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v4_0_set_powergating_state(void *handle,
+static int jpeg_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 
@@ -199,7 +199,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev-&gt;jpeg.cur_state != AMD_PG_STATE_GATE &amp;&amp;
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
-			jpeg_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+			jpeg_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
 		amdgpu_irq_put(adev, &amp;adev-&gt;jpeg.inst-&gt;ras_poison_irq, 0);
@@ -645,10 +645,10 @@ static int jpeg_v4_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v4_0_set_powergating_state(void *handle,
+static int jpeg_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 6917e4a8e96a..30ab807be2bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -43,7 +43,7 @@ enum jpeg_engin_status {
 
 static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v4_0_3_set_powergating_state(void *handle,
+static int jpeg_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring);
@@ -371,7 +371,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev-&gt;jpeg.cur_state != AMD_PG_STATE_GATE)
-			ret = jpeg_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
+			ret = jpeg_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
 
 	return ret;
@@ -960,10 +960,10 @@ static int jpeg_v4_0_3_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v4_0_3_set_powergating_state(void *handle,
+static int jpeg_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index f3cce523f3cb..2b25e8f71f4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -48,7 +48,7 @@
 
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v4_0_5_set_powergating_state(void *handle,
+static int jpeg_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 
 static void jpeg_v4_0_5_dec_ring_set_wptr(struct amdgpu_ring *ring);
@@ -228,7 +228,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (!amdgpu_sriov_vf(adev)) {
 			if (adev-&gt;jpeg.cur_state != AMD_PG_STATE_GATE &amp;&amp;
 			    RREG32_SOC15(JPEG, i, regUVD_JRBC_STATUS))
-				jpeg_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+				jpeg_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 		}
 	}
 	return 0;
@@ -676,10 +676,10 @@ static int jpeg_v4_0_5_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v4_0_5_set_powergating_state(void *handle,
+static int jpeg_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 06840d1dae79..c870f1a361ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -36,7 +36,7 @@
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
-static int jpeg_v5_0_0_set_powergating_state(void *handle,
+static int jpeg_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 
 /**
@@ -165,7 +165,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	if (adev-&gt;jpeg.cur_state != AMD_PG_STATE_GATE &amp;&amp;
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
-		jpeg_v5_0_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		jpeg_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
 }
@@ -570,10 +570,10 @@ static int jpeg_v5_0_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int jpeg_v5_0_0_set_powergating_state(void *handle,
+static int jpeg_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	if (state == adev-&gt;jpeg.cur_state)
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 0820ed62e2e8..f51b5dae3701 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -677,7 +677,7 @@ static int navi10_ih_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int navi10_ih_set_powergating_state(void *handle,
+static int navi10_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 6b72169be8f8..5332e510bced 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1070,7 +1070,7 @@ static int nv_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int nv_common_set_powergating_state(void *handle,
+static int nv_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
 	/* TODO */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 7948d74f8722..0c32e614d8e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -1087,7 +1087,7 @@ static int sdma_v2_4_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v2_4_set_powergating_state(void *handle,
+static int sdma_v2_4_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 9a3d729545a7..18f29e2be828 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1506,7 +1506,7 @@ static int sdma_v3_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v3_0_set_powergating_state(void *handle,
+static int sdma_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3f5959557727..a2f5f2be699b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2312,10 +2312,10 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v4_0_set_powergating_state(void *handle,
+static int sdma_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
 	case IP_VERSION(4, 1, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c7cea0890c9..95d5de2bd186 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1830,7 +1830,7 @@ static int sdma_v4_4_2_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v4_4_2_set_powergating_state(void *handle,
+static int sdma_v4_4_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index d31c4860933f..9ee5318be89e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1859,7 +1859,7 @@ static int sdma_v5_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v5_0_set_powergating_state(void *handle,
+static int sdma_v5_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index ffa8c62ac101..bd883a35c7eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1818,7 +1818,7 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v5_2_set_powergating_state(void *handle,
+static int sdma_v5_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 234483d346f8..34106702e0ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1594,7 +1594,7 @@ static int sdma_v6_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v6_0_set_powergating_state(void *handle,
+static int sdma_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index d2ce6b6a7ff6..1a5fc7bc7289 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1530,7 +1530,7 @@ static int sdma_v7_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int sdma_v7_0_set_powergating_state(void *handle,
+static int sdma_v7_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 00f63d3fbea7..e32615630cca 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2655,7 +2655,7 @@ static int si_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int si_common_set_powergating_state(void *handle,
+static int si_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 47647a6083e8..4b278904cfd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -672,12 +672,12 @@ static int si_dma_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int si_dma_set_powergating_state(void *handle,
+static int si_dma_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	u32 tmp;
 
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	WREG32(DMA_PGFSM_WRITE,  0x00002000);
 	WREG32(DMA_PGFSM_CONFIG, 0x100010ff);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 2ec1ebe4db11..ec756d24aaa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -269,7 +269,7 @@ static int si_ih_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int si_ih_set_powergating_state(void *handle,
+static int si_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 93e44e7ee3fa..8c100db42d4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1473,7 +1473,7 @@ static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
 		adev-&gt;df.funcs-&gt;get_clockgating_state(adev, flags);
 }
 
-static int soc15_common_set_powergating_state(void *handle,
+static int soc15_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state)
 {
 	/* todo */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 1c07ebdc0d1f..7556055b8387 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -953,10 +953,10 @@ static int soc21_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int soc21_common_set_powergating_state(void *handle,
+static int soc21_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	switch (amdgpu_ip_version(adev, LSDMA_HWIP, 0)) {
 	case IP_VERSION(6, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 3af10ef4b793..2a408bc65f73 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -542,10 +542,10 @@ static int soc24_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int soc24_common_set_powergating_state(void *handle,
+static int soc24_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					      enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	switch (amdgpu_ip_version(adev, LSDMA_HWIP, 0)) {
 	case IP_VERSION(7, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index 5a04a6770138..7c02eb0e1540 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -454,7 +454,7 @@ static int tonga_ih_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int tonga_ih_set_powergating_state(void *handle,
+static int tonga_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index bdbca25d80c4..c66fe0c8d5e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -796,7 +796,7 @@ static int uvd_v3_1_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int uvd_v3_1_set_powergating_state(void *handle,
+static int uvd_v3_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index a836dc9cfcad..1f3da607c0d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -714,7 +714,7 @@ static int uvd_v4_2_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int uvd_v4_2_set_powergating_state(void *handle,
+static int uvd_v4_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the UVD block.
@@ -724,7 +724,7 @@ static int uvd_v4_2_set_powergating_state(void *handle,
 	 * revisit this when there is a cleaner line between
 	 * the smc and the hw blocks
 	 */
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (state == AMD_PG_STATE_GATE) {
 		uvd_v4_2_stop(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index ab55fae3569e..50577cc79dcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -817,7 +817,7 @@ static int uvd_v5_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int uvd_v5_0_set_powergating_state(void *handle,
+static int uvd_v5_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the UVD block.
@@ -827,7 +827,7 @@ static int uvd_v5_0_set_powergating_state(void *handle,
 	 * revisit this when there is a cleaner line between
 	 * the smc and the hw blocks
 	 */
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret = 0;
 
 	if (state == AMD_PG_STATE_GATE) {
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 39f8c3d3a135..4f5dc46802e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1476,7 +1476,7 @@ static int uvd_v6_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int uvd_v6_0_set_powergating_state(void *handle,
+static int uvd_v6_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the UVD block.
@@ -1486,7 +1486,7 @@ static int uvd_v6_0_set_powergating_state(void *handle,
 	 * revisit this when there is a cleaner line between
 	 * the smc and the hw blocks
 	 */
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret = 0;
 
 	WREG32(mmUVD_POWER_STATUS, UVD_POWER_STATUS__UVD_PG_EN_MASK);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index c1ed91b39415..552866990db2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -596,7 +596,7 @@ static int vce_v2_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vce_v2_0_set_powergating_state(void *handle,
+static int vce_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCE block.
@@ -606,7 +606,7 @@ static int vce_v2_0_set_powergating_state(void *handle,
 	 * revisit this when there is a cleaner line between
 	 * the smc and the hw blocks
 	 */
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (state == AMD_PG_STATE_GATE)
 		return vce_v2_0_stop(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6bb318a06f19..6f4a2476b9fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -801,7 +801,7 @@ static int vce_v3_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vce_v3_0_set_powergating_state(void *handle,
+static int vce_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCE block.
@@ -811,7 +811,7 @@ static int vce_v3_0_set_powergating_state(void *handle,
 	 * revisit this when there is a cleaner line between
 	 * the smc and the hw blocks
 	 */
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret = 0;
 
 	if (state == AMD_PG_STATE_GATE) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 79ee555768a5..04bfa3b59f75 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -691,7 +691,7 @@ static int vce_v4_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vce_v4_0_set_powergating_state(void *handle,
+static int vce_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCE block.
@@ -701,7 +701,7 @@ static int vce_v4_0_set_powergating_state(void *handle,
 	 * revisit this when there is a cleaner line between
 	 * the smc and the hw blocks
 	 */
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (state == AMD_PG_STATE_GATE)
 		return vce_v4_0_stop(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 7ad2ab3affe4..32b0159953f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -85,7 +85,8 @@ static int vcn_v1_0_stop(struct amdgpu_device *adev);
 static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v1_0_set_powergating_state(void *handle, enum amd_powergating_state state);
+static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+				enum amd_powergating_state state);
 static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
 
@@ -281,7 +282,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
 		(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
 		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
-		vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
 
 	return 0;
@@ -1799,7 +1800,7 @@ static void vcn_v1_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t coun
 	}
 }
 
-static int vcn_v1_0_set_powergating_state(void *handle,
+static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCN block.
@@ -1810,7 +1811,7 @@ static int vcn_v1_0_set_powergating_state(void *handle,
 	 * the smc and the hw blocks
 	 */
 	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (state == adev-&gt;vcn.cur_state)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f34cab96d0b4..798d06563c65 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -92,7 +92,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_0[] = {
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v2_0_set_powergating_state(void *handle,
+static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
@@ -318,7 +318,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
 	    (adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
 	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
-		vcn_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
 }
@@ -1796,7 +1796,7 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 }
 
 
-static int vcn_v2_0_set_powergating_state(void *handle,
+static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCN block.
@@ -1807,7 +1807,7 @@ static int vcn_v2_0_set_powergating_state(void *handle,
 	 * the smc and the hw blocks
 	 */
 	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev-&gt;vcn.cur_state = AMD_PG_STATE_UNGATE;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index beab2c24042d..d00406e057d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -95,7 +95,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v2_5_set_powergating_state(void *handle,
+static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
@@ -399,7 +399,7 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
 		    (adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
-			vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
 			amdgpu_irq_put(adev, &amp;adev-&gt;vcn.inst[i].ras_poison_irq, 0);
@@ -1825,10 +1825,10 @@ static int vcn_v2_5_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vcn_v2_5_set_powergating_state(void *handle,
+static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6d047257490c..d761bc7c31bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -105,7 +105,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v3_0_set_powergating_state(void *handle,
+static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 			enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 			int inst_idx, struct dpg_pause_state *new_state);
@@ -430,9 +430,9 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
-					(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
-					 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
-				vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+				(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
+				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
+				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 			}
 		}
 	}
@@ -2159,10 +2159,10 @@ static int vcn_v3_0_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vcn_v3_0_set_powergating_state(void *handle,
+static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4b836b4935e2..8c1d9afa81ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -96,7 +96,7 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v4_0_set_powergating_state(void *handle,
+static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
         enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
         int inst_idx, struct dpg_pause_state *new_state);
@@ -357,9 +357,9 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 			continue;
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
-                        (adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
-                                RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-                        vcn_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+				(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
+				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 			}
 		}
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
@@ -2037,9 +2037,10 @@ static int vcn_v4_0_set_clockgating_state(void *handle, enum amd_clockgating_sta
  *
  * Set VCN block powergating state
  */
-static int vcn_v4_0_set_powergating_state(void *handle, enum amd_powergating_state state)
+static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 868302d63a4b..4ac6ee75b27d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -87,7 +87,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v4_0_3_set_powergating_state(void *handle,
+static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
@@ -319,7 +319,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
 
 	if (adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE)
-		vcn_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
 }
@@ -1623,10 +1623,10 @@ static int vcn_v4_0_3_set_clockgating_state(void *handle,
  *
  * Set VCN block powergating state
  */
-static int vcn_v4_0_3_set_powergating_state(void *handle,
+static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f0ec8bc031c6..13c0fc9f9894 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -95,7 +95,7 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v4_0_5_set_powergating_state(void *handle,
+static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
@@ -309,7 +309,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 			if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
 				(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
 				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 			}
 		}
 	}
@@ -1531,9 +1531,10 @@ static int vcn_v4_0_5_set_clockgating_state(void *handle, enum amd_clockgating_s
  *
  * Set VCN block powergating state
  */
-static int vcn_v4_0_5_set_powergating_state(void *handle, enum amd_powergating_state state)
+static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
+		enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	if (state == adev-&gt;vcn.cur_state)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 9f89e152e875..9d16747484c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -78,7 +78,7 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v5_0_0_set_powergating_state(void *handle,
+static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
@@ -273,7 +273,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 			if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
 				(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
 				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v5_0_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 			}
 		}
 	}
@@ -1258,9 +1258,10 @@ static int vcn_v5_0_0_set_clockgating_state(void *handle, enum amd_clockgating_s
  *
  * Set VCN block powergating state
  */
-static int vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_state state)
+static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+		enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret;
 
 	if (state == adev-&gt;vcn.cur_state)
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 0fedadd0a6a4..039f1ae2df02 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -616,7 +616,7 @@ static int vega10_ih_set_clockgating_state(void *handle,
 
 }
 
-static int vega10_ih_set_powergating_state(void *handle,
+static int vega10_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 1c9aff742e43..a8e88c9f6ae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -708,7 +708,7 @@ static int vega20_ih_set_clockgating_state(void *handle,
 
 }
 
-static int vega20_ih_set_powergating_state(void *handle,
+static int vega20_ih_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index b3fa54c0514e..471a66dad9b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1988,7 +1988,7 @@ static int vi_common_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int vi_common_set_powergating_state(void *handle,
+static int vi_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bbfc47f6595f..fbdfe37cb93e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -961,7 +961,7 @@ static int dm_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int dm_set_powergating_state(void *handle,
+static int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 7eefcb0f5070..0f20abbfd381 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -403,7 +403,7 @@ struct amd_ip_funcs {
 	int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*set_clockgating_state)(void *handle,
 				     enum amd_clockgating_state state);
-	int (*set_powergating_state)(void *handle,
+	int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state);
 	void (*get_clockgating_state)(void *handle, u64 *flags);
 	void (*dump_ip_state)(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index f0f81ecd9ad6..bb8b0799ab7c 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3183,7 +3183,7 @@ static int kv_dpm_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int kv_dpm_set_powergating_state(void *handle,
+static int kv_dpm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index ee23a0f897c5..ed8f755e9ff6 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7855,7 +7855,7 @@ static int si_dpm_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int si_dpm_set_powergating_state(void *handle,
+static int si_dpm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 90500b419d60..a3d1c5aa3b3e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -244,7 +244,7 @@ static bool pp_is_idle(void *handle)
 	return false;
 }
 
-static int pp_set_powergating_state(void *handle,
+static int pp_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				    enum amd_powergating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c5ef8806dbb3..8d07757adf04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2198,7 +2198,7 @@ static int smu_set_clockgating_state(void *handle,
 	return 0;
 }
 
-static int smu_set_powergating_state(void *handle,
+static int smu_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state)
 {
 	return 0;
</pre>
    </blockquote>
  </body>
</html>

--------------DA1FFAB7DFEF4F7C9BF4BDD2--
