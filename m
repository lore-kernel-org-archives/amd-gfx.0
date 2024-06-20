Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BB2C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 09:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2318E10E87D;
	Thu, 20 Jun 2024 09:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LWKniXeg";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D5F10E889
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 09:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM9NWaXZoRRRY9FASJczcx7/1Yj+n6pUMB8aY/zP+rIuXegKpDmfeXzgaYLzV5w/1pX0yhaucmEUNuMhDSNfrrDC2t/cRUo1t0/kK3FQfv5gQrI0xGrkeB10jx+LoFF61E3+NbUVu5+fvb//0ABIOFjjy8RzVEQ++OX0s2JlvjCkkfgQJNMcj5/nNVB6E5Q3FF3Y09mNpkegumlDy3tFs9rJzZLEHPA9j4/D8di0OVZre3uycyWfURoNnT3daXB/wpgI9bL2bdoHQFbU+lVBGZvANt9NjZl1Zud2FRfTIWsW+ClRJoxmgLb1jbta8U2bu6l7AzH2qk36QmEK7rnv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvUX075Ap40Bhuwt/c+aVhoKdIdyyzEKFrkXtMPPQG4=;
 b=Fz+4MWytUcJjtMimlXLwiXv03ywiYs4x7RT8G+/n7USRwNKCmz+CMgAZSLajy1RosprTON7jl0JxOY7S0nkviAQSgtDH6BuKRsCTcLOtcVDMxHwTFds8Hv+3S+KHbTv/ALBlyRdYh58Z3CJZGTc6jnf1BjOZb9Gqj/QLAterj5+D7SUSaj34G+x9kyWbKG9yOtzmkeIhianYGbWSlZRMAQjpXAzP1gi66RW5R7panKPCCZzgyWDpYY0AzkiXA02ELpQrlL0eOLXyoD81bg0PqSSq2Yr9lGi2oMCHHk+cBNksrf7Ej/Bdzp9z4Yq7AOuz9ceovygrQcdtoaKnpHGong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvUX075Ap40Bhuwt/c+aVhoKdIdyyzEKFrkXtMPPQG4=;
 b=LWKniXeg6hu/zcCMeFuutPA5lo/K5wSMoiAtIOVxksUC0clDjHWl4pLSs/BjeFfZhAoKCD7MlbMQdii5Ls8Gyg26MsMDCTAyQkBl9IzXww36W25doFwS6jfJw7Di/3i0NzXpiGBajB38yZKnZNe2tbdKM2YbZhVXKTiCoiSmSRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 09:26:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 09:26:45 +0000
Message-ID: <f56fc803-dd1a-4dd3-a06e-d268fdd76e1e@amd.com>
Date: Thu, 20 Jun 2024 11:26:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: track bo memory stats at runtime
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240620003014.21453-1-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240620003014.21453-1-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: 293fb107-245b-4c3a-5e2a-08dc910b1a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHZTQmh0NEg3aEpTYitYOENNb2M2aEFyekY3Tlp4ZmVLVm5vamhMMWNjS2Vn?=
 =?utf-8?B?SE82WHlBcjlBdFlldUNHQkVCaTZMTHZzR05uRTBmSzNFZG54T0FjcUlGTk9S?=
 =?utf-8?B?OGE1NTlaakM1eTEyblJtaklJNytlaDE2RzFpWmxVdHdPZ3B1VGxDZTRWaCs4?=
 =?utf-8?B?MERLUDJMTEpKMCtqbXVQV05MdWlyVi9GZjhhZlVPSDJuazZCNHk2RWVWaFVj?=
 =?utf-8?B?VFA3dXN0SzYxVFlIUkJEM1d3T3p6Mm02UFdxTWxYRXRvT0N1aWhhaUY3cm9R?=
 =?utf-8?B?NWRKZ3NQaUM1eC9kaE5VeUJ3WFQzeFV1b3dHVDRwZk9RUDVYL2IrejMrMm5V?=
 =?utf-8?B?UWR5VnlDVEJPVlVER01YQlpnNTZxc1ZMRGVnL2xyTjNhK3l3bGlsZ3pVMVh4?=
 =?utf-8?B?dC9USnNGeEVIckt4UEJmZGg3cmpaVWFkZG1JbFJaNk81b2hjTjRadHlrU0N4?=
 =?utf-8?B?M21DZUxXTWZicUh3c3Y1R2diVFk5S2t5SEgvZUt3UTJUUUJrVy8zKzMvaVNy?=
 =?utf-8?B?cXNrcWYweWthWkxaQmlzUmxtcUZQS0JOaUNZbEF4L0lOVkh6eGdoSmU1T0Vs?=
 =?utf-8?B?N291NlVQekRqSUx3dkpzRmx0S1dncEZBcVJKTzA2ejdoSXBSZU9yZHJ4cm5m?=
 =?utf-8?B?alZmK3ZxeGdqdXhJZitzbGllTW9FQkFnNWUwSVkzSmZBYnBTWXNlSitQUlFW?=
 =?utf-8?B?bytFU20xOXZIYnZ2T2VCOUJBY3N5NGdSNi9yRmgrcjI5Zm1hdTRGblBOcnVO?=
 =?utf-8?B?U2FvS3EwUXJhbWMyV0ZMcXNqejR2RzE0SEVJV2JqbGFUVDJwRFVYRG5YWTR0?=
 =?utf-8?B?MGRBemMybWtMaThaeHIzbHdERlNYSkwzQ29SamlSMnpCUFkrQ1I1cmFzVmcw?=
 =?utf-8?B?OERwNWdSMmQ3dmpkOTA4dG4zRTZlTG44S096MEJmOGlTa3VYMXdXbWZQM2x1?=
 =?utf-8?B?L2g4VE9YbUcyeDM1bkpmQjJ6alFXaG51MEpCVi94TE9BN0hkVHRtSGxkZUVm?=
 =?utf-8?B?dXRJbjBLVk55Qit4OWhndWxoVVd4d1FhWFJLTmFEeGUrd3cyY0U4dDVvaTNs?=
 =?utf-8?B?dTQvTTQvWndnc0R5YTc2RVpwN2s5cHdCOEthTjlBMFoxK21mU0ZiQXE1dGJV?=
 =?utf-8?B?UWhaaVppRlc4RWw5Q1hETitIdU5UNXdzRWs3bFIrQmx3NHByRk1iYzM0NFZQ?=
 =?utf-8?B?UlFkN1JWRTNCMWkzZmIxR2ZEWHhNcW9lQnhtK2VCVk5SekZFbHVjZUg3NHE0?=
 =?utf-8?B?YmZLK0YzOUljVjJubEkrUDFLODlmcG1Lc0psSHh1akQzTzl4eWkxME1FdC9a?=
 =?utf-8?B?R2Y2TEJodDFoV2MvWjY4VVpCVDlVYW9CK2RPV3prdDIvcG9adlM5aFdIUGRm?=
 =?utf-8?B?SXZNVVJiOE1rY3ZPYnhrd0R6c1NaUGFGZjI1WUlBUWZlZVVXcEtsODVjUWZw?=
 =?utf-8?B?RlBKZmt0elBlYkZGa0dkSWRIQS9mZUVZUUJoN1daMmZyRkFFYmduUGZUNTk2?=
 =?utf-8?B?ZTdwNmEvZlBiWklabGdDNUlweGUvaHJVY2hCUThXTGdISkhBRFU3cExhTkRE?=
 =?utf-8?B?eUY3cjRQVjJDd1N5cnRhQVAxaGJzSTlQL2kyZ1BpOWxPeEVHVW0yaUZRaFE5?=
 =?utf-8?B?VGlqanl5L3dqdGZMS01MSWp3c0Z3dXlad08rZk5NbDY1d0tvNGMrcUhIVjBn?=
 =?utf-8?B?WDZyMXgxREJLOUI3SUVDTE5FZVl4aVZwOVMxRlpjdkkyZklvVVFGUUFhRFdL?=
 =?utf-8?Q?ITrN8coj5NkP1uLUxlLnmjvegWaitQ3js872mUP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(366013)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2cvZmgxcm43RWRNd1A0KzhoWWZZWWwwVzBjcUVxRmxUeEFJL3pDTEZBZllC?=
 =?utf-8?B?VzZoUzlMRGVERzQvWCtXMDlhYitBZDhxSVlDREhBTkZoZmhCdzZOY21kTDR0?=
 =?utf-8?B?cGhQRlFIZDg4emI3NFVSazBoUmlZV3hQbVJYU1Jzd3pKb29nazVOZ1RoaFFa?=
 =?utf-8?B?RFlJN3ZQTkpWN0E5MXlSaU1VMVNQRXlRZm0rTnByYWVpRXRaNnRVaWE4eFRi?=
 =?utf-8?B?S1VSalZJTDR6T0xxKzFVQTVKK1AzazZQc1k1U2h5djZTbzdrRmlJNXVMU0Mx?=
 =?utf-8?B?YUs5YVkwbThTZGNSZHlPemRGSU1GWHRDU01ONG9hak11RnFYMzlZeXRTNXN6?=
 =?utf-8?B?UHNJTUtXci9UbFR5SXR4ckFqMXJlUVowOEw3NE5kMkZsdGd0N0dLd3JhUUhM?=
 =?utf-8?B?Y2hPNm9WNmlMZGY4S3dRTWExWWdQR2VqcDFYS1VVQXo0NGM5VDJoUVZMSXVI?=
 =?utf-8?B?VmMvWUhtWUpPcDdWU2NWZ09qaHBmQ00vYjczYXhJNHJIMWhOTHZGdlNhSkE4?=
 =?utf-8?B?eUVURUtvemRkYWR2ZXZyWGlXWThMOXNiUEYzMUxFdGZleTdBQlZxZDZWcis5?=
 =?utf-8?B?amRvWHhxUFlFZEFoNXVxL0N6c2pPOU1ZMHMyMWZxTisvSlJtMEhPaDFZYW9P?=
 =?utf-8?B?dE9JaEZDTDVDYTg0OCt4dlVYd2NsNkhwOUZSYmpGS0FZSDRabWVPSmdDVXIy?=
 =?utf-8?B?Sm1pemdtTGJ6YVE0Zjh0czV5dlhXNlJCKy9DWFZXQkxZVjlscXk0MDJjRlBw?=
 =?utf-8?B?ZWsvTnFjYk9pZGZGL1A4TzlOeitJblc4anJkQjNqcjQ2dzBlYkpReFdyMGpN?=
 =?utf-8?B?TTlqOFpjMDljckw1L1VwTG9RT3g0V29wWXk1TTdjczdmVlNKSWZDT3ArQVpM?=
 =?utf-8?B?L3Y4bWNPMDU4a2JSUzI2YzNVTlVKMzgyU2RjeW1rTkpsYnNDRHk2a2xhQUJL?=
 =?utf-8?B?SE1zaDhXbXMxd3d6YXF3aUhJQjRVb0dxbk81OXlCM3JtdkZ1c3dPTTJpaDZy?=
 =?utf-8?B?bVBJY1p3WGlzNWhRQTNOSWVVc0FsTTJmVWZCRlVOc2xUQ1pkS2pqRWVyRVpo?=
 =?utf-8?B?ZitCSVBDVU4wVzhRRHV4Wk4zQ1ZUdVQramRUdTU3dFJIbG9pMmNUMzFUaWpi?=
 =?utf-8?B?VUN0bE5sQTQzQ0hvQkhRRi91Tmt0d3IvTUt1YVhLTUJab2RxZHV0VXJKc1ZC?=
 =?utf-8?B?T3JEclBiWCthQTBRaWFUSFUvUEMrU2I5aW16UDloKzhHeUtoVWZ3VnRjWVRK?=
 =?utf-8?B?RzNPQXVtbTFnSWkrS0dyTTFRR3lSaDNpQ2Z6eHVEKzN3U1JWOE8zVkRwVmRC?=
 =?utf-8?B?WVEySkM1T1RBZmxUNzZRR0hZSGxWMTAvclpMa3d6aFFGTGU3dUIvVFM3SUF5?=
 =?utf-8?B?SVFxMDlRVFJiQkRVRnJUYk5Ma3hUQ0tDNHV0dUtrSWdNQ0d2L09XQXJRck9r?=
 =?utf-8?B?SVVWNXExQzlOS0s3eklmYXk5aEpiQklmVU5SdjkwdnBHdGswMTY2aTA0WEpE?=
 =?utf-8?B?ZzZ4QVU5SUVIczFvdFNWYTdrV3hsTGZZdElIYkxIaGM5eC9IWC9RSGwwNVNM?=
 =?utf-8?B?cXRJRUpkNkFRcTRwUEFSRURBMjJkTGt1QVg1bHZnaUQ5VlJLdm1sVWRnRVdC?=
 =?utf-8?B?OElZZ1AzTEpVZXFMU2ZhVExVaVBrZU1yWHlhV1NjWGJTYWM0S2UwTE1oRE9m?=
 =?utf-8?B?VDRqR0U1N0lzQmVCeFgza0dvYW5IVTdRWEc2QVNlQUtockJOL0VJcFZwQUZE?=
 =?utf-8?B?eU5sbjVBTTUzTFo3ejlRRmhacVp0UE9WbmZ5WFF2N3Fyd3hhNXhRRUg2azZO?=
 =?utf-8?B?ekNzZCtMazBRandKMGJiSGxrM0JLcmViUGhKWmxSMmFQL3lSMTRhR2NOYmF2?=
 =?utf-8?B?VmJkVStyZFFEVzUycEZ4UW4zUzN2RkRpdjM2aEtJRlQrMnFBLytQbDR5aUtm?=
 =?utf-8?B?T1FZQWpsRSt2UjJMdWFMOTVNS1kxcFJPdnQ5RGNYbWxZa2tTNC9RMUlkRTYz?=
 =?utf-8?B?bWlKSWd4UzZ2a2JMdkxDRTdhc0MyOGRCWXNBL0xXYkplYzllbHZLYk9DZmJS?=
 =?utf-8?B?cjBBRW5LQXR3RXNyZ05kTnRjQVpzNkJpZlJzZm9IOHRQRnM0bW5zWWxUMVkw?=
 =?utf-8?Q?hz8Z33acxq3Kn9wjfMQ6qkoK7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293fb107-245b-4c3a-5e2a-08dc910b1a56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 09:26:45.3518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMsfVoiKd3f0i4gURCznsRfFJrGF5mxJehV+GwohsXhOyng8mPbNsM6JiaWneoos
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350
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

Am 20.06.24 um 02:30 schrieb Yunxiang Li:
> Before, every time fdinfo is queried we try to lock all the BOs in the
> VM and calculate memory usage from scratch. This works okay if the
> fdinfo is rarely read and the VMs don't have a ton of BOs. If either of
> these conditions is not true, we get a massive performance hit.
>
> In this new revision, we track the BOs as they change state. This way
> when the fdinfo is queried we only need to take the status lock and copy
> out the usage stats with minimal impact to the runtime performance.
>
> To simplify the initial implementation, this revision drops tracking how
> much memory is visible, since on modern systems all of vram can be
> visible anyways. Also we do not track "unsharing" a BO, the shared stat
> is only decreased when the BO is destroyed.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 26 ++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  6 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 52 ++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  | 31 ++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 15 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 47 +++----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 25 +++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  1 +
>   include/uapi/drm/amdgpu_drm.h               |  5 ++
>   9 files changed, 111 insertions(+), 97 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 8e81a83d37d8..cc78704a5f4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -35,6 +35,8 @@
>   #include "amdgpu_display.h"
>   #include "amdgpu_gem.h"
>   #include "amdgpu_dma_buf.h"
> +#include "amdgpu_object.h"
> +#include "amdgpu_vm.h"
>   #include "amdgpu_xgmi.h"
>   #include <drm/amdgpu_drm.h>
>   #include <drm/ttm/ttm_tt.h>
> @@ -259,14 +261,36 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
>   {
>   	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
>   	struct dma_buf *buf;
> +	struct amdgpu_vm_bo_base *base;
> +	struct amdgpu_mem_stats stats = { 0 };
> +	bool update_stats;
>   
>   	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) ||
>   	    bo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
>   		return ERR_PTR(-EPERM);
>   
> +	dma_resv_lock(bo->tbo.base.resv, NULL);

Why do you grab the BO lock to update the stats? That doesn't seem to 
make any sense.

> +	update_stats = !(bo->flags & AMDGPU_GEM_WAS_EXPORTED);
> +	if (update_stats)
> +		amdgpu_bo_add_memory(bo, &stats);
> +	else
> +		dma_resv_unlock(bo->tbo.base.resv);
> +
>   	buf = drm_gem_prime_export(gobj, flags);
> -	if (!IS_ERR(buf))
> +	if (!IS_ERR(buf)) {
>   		buf->ops = &amdgpu_dmabuf_ops;
> +		if (update_stats) {
> +			for (base = bo->vm_bo; base; base = base->next) {
> +				spin_lock(&base->vm->status_lock);
> +				base->vm->stats.vram_shared += stats.vram;
> +				base->vm->stats.gtt_shared += stats.gtt;
> +				base->vm->stats.cpu_shared += stats.cpu;
> +				spin_unlock(&base->vm->status_lock);
> +			}
> +			bo->flags |= AMDGPU_GEM_WAS_EXPORTED;
> +			dma_resv_unlock(bo->tbo.base.resv);
> +		}
> +	}
>   
>   	return buf;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index c7df7fa3459f..9a40ff5c6dd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -85,16 +85,10 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
>   	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
>   	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
> -	drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
> -		   stats.visible_vram/1024UL);
>   	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
>   		   stats.evicted_vram/1024UL);
> -	drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
> -		   stats.evicted_visible_vram/1024UL);
>   	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
>   		   stats.requested_vram/1024UL);
> -	drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
> -		   stats.requested_visible_vram/1024UL);
>   	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
>   		   stats.requested_gtt/1024UL);
>   	drm_printf(p, "drm-shared-vram:\t%llu KiB\n", stats.vram_shared/1024UL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 1eadcad1856d..4d6fda142f65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -29,6 +29,7 @@
>    *    Thomas Hellstrom <thomas-at-tungstengraphics-dot-com>
>    *    Dave Airlie
>    */
> +#include "amdgpu_vm.h"

In general please add local includes after global ones.

>   #include <linux/list.h>
>   #include <linux/slab.h>
>   #include <linux/dma-buf.h>
> @@ -1260,12 +1261,20 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>   	struct ttm_resource *old_mem = bo->resource;
> -	struct amdgpu_bo *abo;
> +	struct amdgpu_bo *abo, *tmp;
> +	struct amdgpu_vm_bo_base *base;
>   
>   	if (!amdgpu_bo_is_amdgpu_bo(bo))
>   		return;
>   
> -	abo = ttm_to_amdgpu_bo(bo);
> +	tmp = abo = ttm_to_amdgpu_bo(bo);
> +	if (tmp->parent && (amdgpu_bo_shadowed(tmp->parent) == tmp))
> +		tmp = tmp->parent;
> +	for (base = tmp->vm_bo; base; base = base->next) {
> +		spin_lock(&base->vm->status_lock);
> +		amdgpu_bo_sub_memory(tmp, &base->vm->stats);
> +		spin_unlock(&base->vm->status_lock);
> +	}

Don't touch any VM internals from the BO code.

>   	amdgpu_vm_bo_invalidate(adev, abo, evict);
>   
>   	amdgpu_bo_kunmap(abo);
> @@ -1279,27 +1288,22 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>   			     old_mem ? old_mem->mem_type : -1);
>   }
>   
> -void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
> +void amdgpu_bo_add_memory(struct amdgpu_bo *bo,
>   			  struct amdgpu_mem_stats *stats)
>   {
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	struct ttm_resource *res = bo->tbo.resource;
>   	uint64_t size = amdgpu_bo_size(bo);
> -	struct drm_gem_object *obj;
>   	bool shared;
>   
>   	/* Abort if the BO doesn't currently have a backing store */
>   	if (!res)
>   		return;
>   
> -	obj = &bo->tbo.base;
> -	shared = drm_gem_object_is_shared_for_memory_stats(obj);
> +	shared = !!(bo->flags & AMDGPU_GEM_WAS_EXPORTED);
>   
>   	switch (res->mem_type) {
>   	case TTM_PL_VRAM:
>   		stats->vram += size;
> -		if (amdgpu_res_cpu_visible(adev, res))
> -			stats->visible_vram += size;
>   		if (shared)
>   			stats->vram_shared += size;
>   		break;
> @@ -1318,19 +1322,35 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   
>   	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>   		stats->requested_vram += size;
> -		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
> -			stats->requested_visible_vram += size;
> -
> -		if (res->mem_type != TTM_PL_VRAM) {
> +		if (res->mem_type != TTM_PL_VRAM)
>   			stats->evicted_vram += size;
> -			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
> -				stats->evicted_visible_vram += size;
> -		}
>   	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
>   		stats->requested_gtt += size;
>   	}
>   }
>   
> +void amdgpu_bo_sub_memory(struct amdgpu_bo *bo,
> +			  struct amdgpu_mem_stats *stats)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	struct amdgpu_mem_stats bo_stats = { 0 };
> +	uint64_t *stats_arr = (uint64_t *)stats;
> +	uint64_t *bo_stats_arr = (uint64_t *)&bo_stats;
> +
> +	amdgpu_bo_add_memory(bo, &bo_stats);
> +
> +	// stats is a struct with all uint64_t members so we cast and loop over it like an array

// style comments are not allowed inside kernel code.

> +	for (int i = 0; i < (sizeof(*stats) / sizeof(*stats_arr)); ++i) {
> +		if (stats_arr[i] >= bo_stats_arr[i]) {
> +			stats_arr[i] -= bo_stats_arr[i];
> +		} else if (bo_stats_arr[i]) {
> +			stats_arr[i] = 0;
> +			dev_err(adev->dev,
> +				"amdgpu memory stats doesn't match, some bo was missed?\n");
> +		}
> +	}
> +}
> +
>   /**
>    * amdgpu_bo_release_notify - notification about a BO being released
>    * @bo: pointer to a buffer object
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index bc42ccbde659..23c1c9385f7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -135,33 +135,6 @@ struct amdgpu_bo_vm {
>   	struct amdgpu_vm_bo_base        entries[];
>   };
>   
> -struct amdgpu_mem_stats {
> -	/* current VRAM usage, includes visible VRAM */
> -	uint64_t vram;
> -	/* current shared VRAM usage, includes visible VRAM */
> -	uint64_t vram_shared;
> -	/* current visible VRAM usage */
> -	uint64_t visible_vram;
> -	/* current GTT usage */
> -	uint64_t gtt;
> -	/* current shared GTT usage */
> -	uint64_t gtt_shared;
> -	/* current system memory usage */
> -	uint64_t cpu;
> -	/* current shared system memory usage */
> -	uint64_t cpu_shared;
> -	/* sum of evicted buffers, includes visible VRAM */
> -	uint64_t evicted_vram;
> -	/* sum of evicted buffers due to CPU access */
> -	uint64_t evicted_visible_vram;
> -	/* how much userspace asked for, includes vis.VRAM */
> -	uint64_t requested_vram;
> -	/* how much userspace asked for */
> -	uint64_t requested_visible_vram;
> -	/* how much userspace asked for */
> -	uint64_t requested_gtt;
> -};
> -
>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
>   {
>   	return container_of(tbo, struct amdgpu_bo, tbo);
> @@ -341,7 +314,9 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>   int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>   u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
>   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
> -void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
> +void amdgpu_bo_add_memory(struct amdgpu_bo *bo,
> +			  struct amdgpu_mem_stats *stats);
> +void amdgpu_bo_sub_memory(struct amdgpu_bo *bo,
>   			  struct amdgpu_mem_stats *stats);
>   void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
>   int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 9a92dd3c9fb8..af1b480ea4d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -478,6 +478,7 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   	struct amdgpu_device *adev;
>   	struct amdgpu_bo *abo;
>   	struct ttm_resource *old_mem = bo->resource;
> +	struct amdgpu_vm_bo_base *base;
>   	int r;
>   
>   	if (new_mem->mem_type == TTM_PL_TT ||
> @@ -494,14 +495,14 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   			 bo->ttm == NULL)) {
>   		amdgpu_bo_move_notify(bo, evict, new_mem);
>   		ttm_bo_move_null(bo, new_mem);
> -		return 0;
> +		goto out;
>   	}
>   	if (old_mem->mem_type == TTM_PL_SYSTEM &&
>   	    (new_mem->mem_type == TTM_PL_TT ||
>   	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
>   		amdgpu_bo_move_notify(bo, evict, new_mem);
>   		ttm_bo_move_null(bo, new_mem);
> -		return 0;
> +		goto out;
>   	}
>   	if ((old_mem->mem_type == TTM_PL_TT ||
>   	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
> @@ -514,7 +515,7 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   		amdgpu_bo_move_notify(bo, evict, new_mem);
>   		ttm_resource_free(bo, &bo->resource);
>   		ttm_bo_assign_mem(bo, new_mem);
> -		return 0;
> +		goto out;
>   	}
>   
>   	if (old_mem->mem_type == AMDGPU_PL_GDS ||
> @@ -528,7 +529,7 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   		/* Nothing to save here */
>   		amdgpu_bo_move_notify(bo, evict, new_mem);
>   		ttm_bo_move_null(bo, new_mem);
> -		return 0;
> +		goto out;
>   	}
>   
>   	if (bo->type == ttm_bo_type_device &&
> @@ -575,6 +576,12 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   	if (evict)
>   		atomic64_inc(&adev->num_evictions);
>   	atomic64_add(bo->base.size, &adev->num_bytes_moved);
> +out:
> +	for (base = abo->vm_bo; base; base = base->next) {
> +		spin_lock(&base->vm->status_lock);
> +		amdgpu_bo_add_memory(abo, &base->vm->stats);
> +		spin_unlock(&base->vm->status_lock);
> +	}

Don't touch any VM internals in TTM code.

>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3abfa66d72a2..b373bafa7b4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -332,6 +332,9 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   		return;
>   	base->next = bo->vm_bo;
>   	bo->vm_bo = base;
> +	spin_lock(&vm->status_lock);
> +	amdgpu_bo_add_memory(bo, &vm->stats);
> +	spin_unlock(&vm->status_lock);
>   
>   	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>   		return;
> @@ -1088,51 +1091,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	return r;
>   }
>   
> -static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
> -				    struct amdgpu_mem_stats *stats)
> -{
> -	struct amdgpu_vm *vm = bo_va->base.vm;
> -	struct amdgpu_bo *bo = bo_va->base.bo;
> -
> -	if (!bo)
> -		return;
> -
> -	/*
> -	 * For now ignore BOs which are currently locked and potentially
> -	 * changing their location.
> -	 */
> -	if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
> -	    !dma_resv_trylock(bo->tbo.base.resv))
> -		return;
> -
> -	amdgpu_bo_get_memory(bo, stats);
> -	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
> -		dma_resv_unlock(bo->tbo.base.resv);
> -}
> -
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   			  struct amdgpu_mem_stats *stats)
>   {
> -	struct amdgpu_bo_va *bo_va, *tmp;
> -
>   	spin_lock(&vm->status_lock);
> -	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> -
> -	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> -
> -	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> -
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> -
> -	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> -
> -	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> +	*stats = vm->stats;
>   	spin_unlock(&vm->status_lock);
>   }
>   
> @@ -2049,6 +2012,8 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   	}
>   
>   	spin_lock(&vm->status_lock);
> +	if (bo)
> +		amdgpu_bo_sub_memory(bo, &vm->stats);
>   	list_del(&bo_va->base.vm_status);
>   	spin_unlock(&vm->status_lock);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 046949c4b695..3f9650ac612e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -42,7 +42,28 @@ struct amdgpu_bo_va;
>   struct amdgpu_job;
>   struct amdgpu_bo_list_entry;
>   struct amdgpu_bo_vm;
> -struct amdgpu_mem_stats;
> +
> +struct amdgpu_mem_stats {
> +	/* current VRAM usage */
> +	uint64_t vram;
> +	/* current shared VRAM usage */
> +	uint64_t vram_shared;
> +	/* current GTT usage */
> +	uint64_t gtt;
> +	/* current shared GTT usage */
> +	uint64_t gtt_shared;
> +	/* current system memory usage */
> +	uint64_t cpu;
> +	/* current shared system memory usage */
> +	uint64_t cpu_shared;
> +	/* sum of evicted buffers */
> +	uint64_t evicted_vram;
> +	/* how much userspace asked for */
> +	uint64_t requested_vram;
> +	/* how much userspace asked for */
> +	uint64_t requested_gtt;
> +};
> +
>   
>   /*
>    * GPUVM handling
> @@ -336,6 +357,8 @@ struct amdgpu_vm {
>   	/* Lock to protect vm_bo add/del/move on all lists of vm */
>   	spinlock_t		status_lock;
>   
> +	struct amdgpu_mem_stats stats;
> +
>   	/* Per-VM and PT BOs who needs a validation */
>   	struct list_head	evicted;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index e39d6e7643bf..ed98bc78c8e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -595,6 +595,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>   
>   	spin_lock(&entry->vm->status_lock);
> +	amdgpu_bo_sub_memory(entry->bo, &entry->vm->stats);
>   	list_del(&entry->vm_status);
>   	spin_unlock(&entry->vm->status_lock);
>   	amdgpu_bo_unref(&entry->bo);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 3e488b0119eb..7ddf020817e1 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -174,6 +174,11 @@ extern "C" {
>   /* Set PTE.D and recompress during GTT->VRAM moves according to TILING flags. */
>   #define AMDGPU_GEM_CREATE_GFX12_DCC		(1 << 16)
>   
> +/* Flag that BO was exported at one point and counts torwards the "shared"
> + * memory stats. Once set it does not get cleared until the BO is destroyed.
> + */
> +#define AMDGPU_GEM_WAS_EXPORTED 		(1 << 17)
> +

Absolutely clear NAK to that approach. This is not even remotely an 
allocation flag but some status.

Additional to that completely unnecessary since BOs are usually only 
exported once.

Regards,
Christian.

>   struct drm_amdgpu_gem_create_in  {
>   	/** the requested memory size */
>   	__u64 bo_size;

