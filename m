Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E57C369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 09:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BEE10E503;
	Mon, 14 Apr 2025 09:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zVBo94bT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E4710E503
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 09:19:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqK7836tPpT6S6qpSmd1VpdLK9ntivH1y+qNLzn3R/BDmxFYGOAR8kCA5XTraNm8kJzW4UhAFOpT/G3lKwSjDImpINAEMIJVjYq8I+qbD3nEklQ3Ga+9J/fJzJIMq+Q+xeOscaEFH8BoXvMDAShnaurxmQsUt/Gnnl6aW4EqYfdp33cVbIavGQr9CHRt5A5S6thiWjP6JjSUemFNT07LROF0140X8rzGD6gHoJ/BKxGvTQQo2feOdl84gXpIfBA9RYbPAuW/RWrq+chj+PWp1KSH0zEfH3wVLGz1cwbn9S/u/qRexCWQWlDKX95DkPLyTgYkZ381YTy7NUALKgFP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmrS9MgUisF+fXKOWCmtvKhLekEpO1Md4qc/MyQnRmQ=;
 b=bS4FKhSD9uS0NkQR1izumpE0C3P9+BCtNhcVNANw1OySFEsTAquh17UeRmj20aeYVaBysgwn3DrgJu1c3mGaQd1kqhIL2tbB7Yb6ABJL0zn0nIljvq3ah+n2Q7IpHajfTNz8+E+ztnKc3cddZ60wZnydMeOSt7WY23BEmHeH4BVfSWxD8dNPVuoP4TFdtVZtBJuwqzW03wFJH0/I5enlj5SZOx25euOMehmOBsgt7TrV3uXS0M45H9wRDicIGVtq3+51h9TO26RJbYSGgDqZc/M+vgUeVyrpVUPoWZlLrrG8ko2chGhGpCDSoN7b0gWENavlb+DL2CX/B1qemW5tWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmrS9MgUisF+fXKOWCmtvKhLekEpO1Md4qc/MyQnRmQ=;
 b=zVBo94bTD9RUxh8kv5a3EQ10JMse8qo8qNl/sEgAsdGxDxy0zWWmdIjhMbox+pRJ2NFBqJ96SHXlo/2xILp56weexpIrNNOikeoZcdpwdbVrmY1n94RXzOOP2mVQI3IxoVokegvpbpPF9Cpzk4Wajft9o9UayZKSXBFEl+cRTnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 09:19:17 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 09:19:17 +0000
Content-Type: multipart/alternative;
 boundary="------------54X3T7gsATtCMQEDxU36sL8G"
Message-ID: <a953ab5a-17e5-456a-8666-5374589110b4@amd.com>
Date: Mon, 14 Apr 2025 14:49:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: move runpm handling into core userq code
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250413182415.2712146-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250413182415.2712146-1-alexander.deucher@amd.com>
X-ClientProxiedBy: PN4P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 14719f49-9267-4969-fa19-08dd7b356e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGhEWkVwYVloOExPQVg4VzZ0VVZlMXJVT01JV2VsTFptUS9IamU2NE9OcHNo?=
 =?utf-8?B?bVM2M3RRcmI0ejEvRXhUZkhoWkxqVWNxU1lySit6cDErbEo2UDVnRVpnenE0?=
 =?utf-8?B?YUVhL2F6S21DT1VnaGhLSXhveU14aVA4WDJpK1Rrd0FRdFVTckhKcFdRR0Jk?=
 =?utf-8?B?MFNZd2N4UHh1bmpJZTl1SUVpenAwcjVJR0o4bmRFQjBXNmtVRTlaM2p2bzFV?=
 =?utf-8?B?djBpUC9yc2U1NGdMR004djJ1ZXc2Q2hPSVlaOWp6MWhDaHRMRHhSSlE2d2lT?=
 =?utf-8?B?S3ppRUxaWHZsQXdUOU1uM3BYeDRoakxsM2p0R2Fhb0VqT21wWk1kNXdIVDJB?=
 =?utf-8?B?bGUzSHEvcVdJYm1BcDB3UnlQeVB1blEzMitjaFpadHdRTVlOdUV3Sno2NGFm?=
 =?utf-8?B?SUlJSmhGL0kxWjlubW5ESnd0SUg1OEpLeHVjdWx0eWs2Rk1KTzJCd3A0bGVu?=
 =?utf-8?B?QWx5V1QrMXQwZ1ZaU3ozTm5vZXVjUkw1T3NtY1hKMVMvWW5rWUVmcmNlQUZw?=
 =?utf-8?B?eHNkaHc0eVVNVTlPYWcwa0NNWUQyVTAzVmFaQ2ozRVo5YmdzUnhzaTNocHNs?=
 =?utf-8?B?WndYSGlISHFUTGNlNDd2aU5ITHFsbk5EUGJhOGxuRUZUZ0tsdHMvOXRsU3d1?=
 =?utf-8?B?ZWM1a2wxdEVxU3hKWUJHN3RzZnFxVGJoeHZldXM3WlErYTVWWlpmdkZ3M0dD?=
 =?utf-8?B?VjZxL0tNWnRkQ2x5V2UzdmZaUjVYUHlHM1BYNlFBTEhhc3VxNG5GOUxiVk4y?=
 =?utf-8?B?N3o3R1gzY2xjTkRHOXQ4bTVUdUZCZHZCTTh3MzYwckRUVlllTUtpUWM2Y2tS?=
 =?utf-8?B?cVBzWFpCMGFzWCtTOUZPeExlTUVQM2czSkRQb2ZoYXRlUVF1VUVYMnhRQkFs?=
 =?utf-8?B?NjJJZUw4U1pBcTBGRkdMTEV2UWN0aFJtZWduc3M3SVRrWlBtczc1ZDE4eHB2?=
 =?utf-8?B?bGhiNkp3SlBpa09hWGdDL09qV21Gd21YRUZEU2ZJL3ZTSFNhRnVNOHdQMTNq?=
 =?utf-8?B?dlp1NURxakRscUJ6R0pzWEVPcFYwemRnNy9sdFhONHlrRjZibklHQVY2bjZj?=
 =?utf-8?B?aUFZREI2NFJTd3VDb2VlNGlscTNQVVBSQ3RUWUk3Q0hMOHI3YVdWQWJYL0ll?=
 =?utf-8?B?MGhCZ2J1YTcxUUl6WXo1TGVIeFovRXhaUjN2R2M0cGNWTk83Z0R0S0hVTXJs?=
 =?utf-8?B?MFpsenBLK2g1VU95eGNoZXVWaFdEZFk2TFloRnVXdFV1ZXB3Y01NSDVES3A4?=
 =?utf-8?B?L3NOdlU5UVlQeUdDcG8rZDkxZVhhazd4Ri9ZNG1KbzVoQzFWOFdxNm85ZnFu?=
 =?utf-8?B?TkpVU2k0ajhRaFpBeTVwTUZrY0tHNjRHVFRFMUd3Skl3U29yM2pCOWtYR0V1?=
 =?utf-8?B?N0QvOUlIVzVpcVZUQWE5aEtxMElOVWdaY1BpSlh6TmRtWm42NkNsckx4VjRp?=
 =?utf-8?B?RThhcTg5U0Nua1I3Y0orYldCWHJ4VGVwZnF3WXNLa0YxU1MxMkVmaEpneTVV?=
 =?utf-8?B?dWtrb0s2UEt1N2pEOGtQdFI2S016UWJaLzRKWDlnZUtsZ1dXTjRpaW9tdmVN?=
 =?utf-8?B?V0lGVytWWm14amU4Qkt6Z1d0MDdJMFdRV0kxUlpKZWN0ZnJFaGUrYlR1dUIy?=
 =?utf-8?B?YzJ5NHR0eU1ZL0l4SmxZTEo0NzYzSlRYS21ZM2NWLzhhdnZ1MWoydTRFaE9x?=
 =?utf-8?B?NmcrZENIV3pkeUpKei9Pa2xFM0Zzd2tBamdCL21FVkt0alRGT0xWVGlkN1ow?=
 =?utf-8?B?NHAvSG5lYUZwYnFPNkh6YTFEYUpaQ21lOE5CUmhhNkc2SXJBWWNiWVNyeGJx?=
 =?utf-8?B?T3ZlTXF5ak9KYkFXVWR3Ymk0Q1RZNTZaRE5EcS83VlEwTlJ0aW40WDVZcVJL?=
 =?utf-8?B?OVJYaWx2Yld1UG54VmxNZlZwdENXYWZqMkRKaEwyZ3dXN3lUaDVCa09kTWhW?=
 =?utf-8?Q?UI0YsnAiHIQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUppREVzdXhrVU1TVHZES2FoM290c3ZuTUtnVUNvQW9IY0tlakM0aWNObXBq?=
 =?utf-8?B?KzJ2UE1IcFNPTnZEa1FFbHRKQzVOTVI2SkE2SW9oclJFbmxhS3M1VW9rTzBu?=
 =?utf-8?B?eE5hdGlsOWdZRENMSkxSanpHVmhDMzZobWNCblVsTWE2aWRBclgvVzRJUk1Q?=
 =?utf-8?B?UGk4eU83WXgvZWtmMStxakRlNVB1VGtFQVZKTVJtYzRoVExybCtGNlg0TzQ3?=
 =?utf-8?B?WWE4SEVxVWR2MnppOHh1L1ZNMk1jUGdLcFBSSUQ5UHJlZlBSS2x1bmozVmhS?=
 =?utf-8?B?OXVBclZuWGIzbVY0TXJiRndFUmF1NFBxbWdLSUI2MTltWk81cGJsWEVKd2pU?=
 =?utf-8?B?bkxwUitKSXRqVnRRTk0yR0lXN3JBMmlySjB4MFBuaDU4V2FHS3pWZnVFS0ZS?=
 =?utf-8?B?Zk1GSVdyeEZDb0NWbU1qZXZDL1cxTXd2TnUrckFSU3NqWW8vNlU4aUFMZzRK?=
 =?utf-8?B?ZnZJUjBqa0xVMkI2Z0Y4dFZKSkRlb3RhOFluY1NVYXpRcUFEQUJhaEdWMytD?=
 =?utf-8?B?ZXMwN2IwSTRPVmt1aWtBQXVyRnpUNTZzTHZRcjh2VElVTGZSUitkaHVxSEd3?=
 =?utf-8?B?Njl4UklNaHBvUENMQXRQU2JzL1EvcGFFSEpMMzJ2QnlGNFZ4K3RJWmF2OTg3?=
 =?utf-8?B?YnZHSEZwcFlyY3NjRWVjaDhDTFJYRFVlbTZobGt2ZG5ha3JEQm1BbVI3bHJV?=
 =?utf-8?B?aFcxcGdCeXoyU1NCdkErQXdLamMrRklyNENOanNTZHRSY25wZzNhTTZ0TTkz?=
 =?utf-8?B?UUxNK2RGQitPWnYySk5JVjdNaU1EMW1IdWM3YVRpUENxcWtCRmhzS2Z4R1cz?=
 =?utf-8?B?Y2M1MG84WWl1a3YrZTAyL2tOYXpiZlVPRWtqNVlTdzBUdGt0T0VEbyszbkU4?=
 =?utf-8?B?MFNNaXMyL3JhSGlzQmF0RFhYckdNRk9YSTRHeEN4b1J0MkZDeDBBQ3dPZHVU?=
 =?utf-8?B?QWtXVzl3ZmpzdnNGQ0pDMjVrZW5oeUgvajk0RUVXTXVQdExpRmlqMDJ1eHNu?=
 =?utf-8?B?eXBvUml1UC9LYWdPbnU3R3NUczg2RDU0RGhyalZQb09NOTNhWVRpUHdERHN3?=
 =?utf-8?B?UmZiM214cE5iblUxN0w5UFprOSt5bjdzUXdmbW51THVlRlYrclp3eXJMWlF1?=
 =?utf-8?B?cnZ3cVNtYWc3UHU0c1VNd0hQWkNyQVFOMm8vdXBTTGZWQnJjNXlvdXVLQmxW?=
 =?utf-8?B?V01COUZNejNrcVkyZzdDMEg2bzdiNUpaVFBOUGJXakxubGU4VVh6S1R6QTJR?=
 =?utf-8?B?TnNPYlJCdVFQQ0ZreEZWbFNYZHVnVHBPRG5nWllST2VDbndVUWdyaVdGTHFW?=
 =?utf-8?B?UVN1bU5yRGk3dEJPdDczeDJOcXg3dDdBeFAyOHoxRHlDMzA2TGJGMkExbld4?=
 =?utf-8?B?UUEvaVhxc1VSdGR0NTBWU3RLaVc3VXREZHlNc1hhRy9vSWMxZGVhQ2JaeTNs?=
 =?utf-8?B?c0N6VW5GQnBqbnpBZWczWW42YUFqR2x0UEFEbDdFOFNFbStzeWRWVVhkd2Fs?=
 =?utf-8?B?R2J1L1ZOcEgwSDEvMHdhWnFYTUxFOGplNGxnQ3grZUU3QVhsS1ZUUTFJOWFa?=
 =?utf-8?B?aHpCNzh2akJZSjFwYnpXbWJEWlcvVWhESHBrL1BvQzNPcXZyVUtnTDd6ODcv?=
 =?utf-8?B?aEl1RzZjdTFUZ2pKVGZaTTJ3MEJwOVN4ckVLdmZ3TkVXSm9wdkNCendVWC9p?=
 =?utf-8?B?TE4zY1VpMFlYT0dxWjdkL2lDMXNyS1FEMlpaYWd2WCtQK3FnQjloK29nMHlw?=
 =?utf-8?B?UEMxSjcyS0R1bEdyNnE0WGdiQnRETzRNR1cvdHM3TTl6bWlPY3lJc282TDFE?=
 =?utf-8?B?emNGZ2JnUWtiSVVxb1JpVHorVjV1VlR3UEY0RmlBazVram1uYkRNb0FDbCtj?=
 =?utf-8?B?ellVNXdUSTJySG1lUlR5RzlDdE1ibDZhVDJxMFFFdUQyVXhEcWx6ZU5KSTVi?=
 =?utf-8?B?aHFkNjRjK2c4bU1CWFNLRHNNYWR0WStMZXN4TjlTK2ZoNjQzQXByaExidnE0?=
 =?utf-8?B?bzBscUt5UnBLTnFPUEljZlNXZHRtUVJNVm5lN0c2TDExL1YvUDFCOER5ampq?=
 =?utf-8?B?VzREZlNRajhmeGRpeFVEOEoxSUdaNFJBbUdWckpBZ1kwTnorMit3bDN3Tmlh?=
 =?utf-8?Q?6jpxQlElLqnsiNjbG1kgMjFR3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14719f49-9267-4969-fa19-08dd7b356e0c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 09:19:17.0151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rhIw0df8Gkscr1HtVGJyxkQDkrNG+7kURE071ziyFDfHX+ZMbqQeXhwM8u1a52YCN4hhmVMdKi/f8doacO12w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328
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

--------------54X3T7gsATtCMQEDxU36sL8G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/13/2025 11:54 PM, Alex Deucher wrote:
> Pull it out of the MES code and into the generic code.
> It's not MES specific and needs to be applied to all user
> queues regardless of the backend.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 15 ---------------
>   2 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 98e1ed794c346..08a94822eb17c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -24,6 +24,8 @@
>   
>   #include <drm/drm_auth.h>
>   #include <drm/drm_exec.h>
> +#include <linux/pm_runtime.h>
> +
>   #include "amdgpu.h"
>   #include "amdgpu_vm.h"
>   #include "amdgpu_userqueue.h"
> @@ -258,6 +260,10 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>   	amdgpu_bo_unref(&queue->db_obj.obj);
>   	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
>   	mutex_unlock(&uq_mgr->userq_mutex);
> +
> +	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +
>   	return r;
>   }
>   
> @@ -311,6 +317,13 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		return -EINVAL;
>   	}
>   
> +	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +	if (r < 0) {
> +		dev_err(adev->dev, "pm_runtime_get_sync() failed for userqueue mqd create\n");
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}
> +
>   	/*
>   	 * There could be a situation that we are creating a new queue while
>   	 * the other queues under this UQ_mgr are suspended. So if there is any
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index e175f05bba6a9..b3157df8ae107 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -25,7 +25,6 @@
>   #include "amdgpu_gfx.h"
>   #include "mes_userqueue.h"
>   #include "amdgpu_userq_fence.h"
> -#include <linux/pm_runtime.h>
>   
>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> @@ -313,12 +312,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   
>   	queue->userq_prop = userq_props;
>   
> -	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> -	if (r < 0) {
> -		dev_err(adev->dev, "pm_runtime_get_sync() failed for userqueue mqd create\n");
We should update the comment "pm_runtime_get_sync() failed for userqueue 
create". With that change its reviewed. Reviewed-by: Sunil Khatri 
<sunil.khatri@amd.com>
Regards Sunil Khatri
> -		goto deference_pm;
> -	}
> -
>   	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
>   	if (r) {
>   		DRM_ERROR("Failed to initialize MQD for userqueue\n");
> @@ -346,9 +339,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   
>   free_mqd:
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -deference_pm:
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   
>   free_props:
>   	kfree(userq_props);
> @@ -360,14 +350,9 @@ static void
>   mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>   		      struct amdgpu_usermode_queue *queue)
>   {
> -	struct amdgpu_device *adev = uq_mgr->adev;
> -
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>   	kfree(queue->userq_prop);
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> -
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   }
>   
>   const struct amdgpu_userq_funcs userq_mes_funcs = {
--------------54X3T7gsATtCMQEDxU36sL8G
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/13/2025 11:54 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250413182415.2712146-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">Pull it out of the MES code and into the generic code.
It's not MES specific and needs to be applied to all user
queues regardless of the backend.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 15 ---------------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 98e1ed794c346..08a94822eb17c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -24,6 +24,8 @@
 
 #include &lt;drm/drm_auth.h&gt;
 #include &lt;drm/drm_exec.h&gt;
+#include &lt;linux/pm_runtime.h&gt;
+
 #include &quot;amdgpu.h&quot;
 #include &quot;amdgpu_vm.h&quot;
 #include &quot;amdgpu_userqueue.h&quot;
@@ -258,6 +260,10 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 	amdgpu_bo_unref(&amp;queue-&gt;db_obj.obj);
 	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&amp;uq_mgr-&gt;userq_mutex);
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);
+
 	return r;
 }
 
@@ -311,6 +317,13 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		return -EINVAL;
 	}
 
+	r = pm_runtime_get_sync(adev_to_drm(adev)-&gt;dev);
+	if (r &lt; 0) {
+		dev_err(adev-&gt;dev, &quot;pm_runtime_get_sync() failed for userqueue mqd create\n&quot;);
+		pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);
+		return r;
+	}
+
 	/*
 	 * There could be a situation that we are creating a new queue while
 	 * the other queues under this UQ_mgr are suspended. So if there is any
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index e175f05bba6a9..b3157df8ae107 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -25,7 +25,6 @@
 #include &quot;amdgpu_gfx.h&quot;
 #include &quot;mes_userqueue.h&quot;
 #include &quot;amdgpu_userq_fence.h&quot;
-#include &lt;linux/pm_runtime.h&gt;
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -313,12 +312,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 	queue-&gt;userq_prop = userq_props;
 
-	r = pm_runtime_get_sync(adev_to_drm(adev)-&gt;dev);
-	if (r &lt; 0) {
-		dev_err(adev-&gt;dev, &quot;pm_runtime_get_sync() failed for userqueue mqd create\n&quot;);</pre>
    </blockquote>
    We should update the comment &quot;<span style="white-space: pre-wrap">pm_runtime_get_sync() failed for userqueue create&quot;. With that change its reviewed.
</span>Reviewed-by:
    Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a><br>
    <span style="white-space: pre-wrap">
Regards
Sunil Khatri 
</span>
    <blockquote type="cite" cite="mid:20250413182415.2712146-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
-		goto deference_pm;
-	}
-
 	r = mqd_hw_default-&gt;init_mqd(adev, (void *)queue-&gt;mqd.cpu_ptr, userq_props);
 	if (r) {
 		DRM_ERROR(&quot;Failed to initialize MQD for userqueue\n&quot;);
@@ -346,9 +339,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 free_mqd:
 	amdgpu_userqueue_destroy_object(uq_mgr, &amp;queue-&gt;mqd);
-	pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);
-deference_pm:
-	pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);
 
 free_props:
 	kfree(userq_props);
@@ -360,14 +350,9 @@ static void
 mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_usermode_queue *queue)
 {
-	struct amdgpu_device *adev = uq_mgr-&gt;adev;
-
 	amdgpu_userqueue_destroy_object(uq_mgr, &amp;queue-&gt;fw_obj);
 	kfree(queue-&gt;userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &amp;queue-&gt;mqd);
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);
 }
 
 const struct amdgpu_userq_funcs userq_mes_funcs = {
</pre>
    </blockquote>
  </body>
</html>

--------------54X3T7gsATtCMQEDxU36sL8G--
