Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD749CA0ED1
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 09:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5115410E83E;
	Thu, 14 Aug 2025 09:20:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0gsU7Hk6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D6C10E83B
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 09:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8TMThIwtAN6ASOOn0FNqSsqDEWPlmzBTqQ2Yav5mSj5zpyzZqrxJRR/WEGmY3IQA8MrIuh2ah6TEQSExO8KHDNUxOEIyBvEj9oZljKL9hWrCwjiF5oRb3qOASfdiKYI3QhHirsAFN/BaxapqhfPYSvLFpJXvv0TcBKBTCJ4WplqpF7qlW7D2NoZX3fouFyMIpE1+qe5cgZyfdApSzl9x1H7zUZPAwecz/N6CH2YQ4ZedSRRtx/gQhALiq/EiO3EjkPmMcmYa1aSdvZTC3l1hjdAMg7PD+AI2SXsP8j062YckFespT0+oFdHcDL40DIxyWcsIs1sWy+pmhLU2apOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raWM+PXVCTBgEryc4+6D/e+ILmxbSpQAnxFgRGVgRKI=;
 b=beFSrjbLs+WIym6xSgzqRKpMASD4G+x+kzpn1X195xX4IOJYLXtxNdSUMr4/qu9WUmCucNFHwiLbbyBNdBlH1Bssl2zT8ozAfIhS8TsuROhsOl0caNJnMKxheTA+TVTL2TTfiMt/eYJ4OgZxTRmvWlMst6X4iVNSRWB67N2MNxEjfbR5XPJhoQz8VC+hhwI3FpGiOZlm+lY/6KIi6KwnunjS1B6NP+Qhk9sRNXusedYpgPGMVqvs0vYCOhKB4HpYd/0MwymYL2AzKjxjG3w36fGJc0FZqE5sVIMQWaIHaNiVkZdUtGUtjsu/wn/2pmI20wl5IV1xpJeFicFObH+Xqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raWM+PXVCTBgEryc4+6D/e+ILmxbSpQAnxFgRGVgRKI=;
 b=0gsU7Hk6YQF5F4irWDw9cT5NNpXOowPCS4apJ5I7cltWfw5R1e+zTlwedu/OLnVnf4/dydZnsOj8uHpQA5d+QfREBhtMqMe1M8kRiFg6RbiLqe2lI9Y/Po7qQpF+/YKNjCE5xSDYOd7/93kmlHpHrTGkFpSkuYCSOF+thERdsZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 14 Aug
 2025 09:20:09 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 09:20:09 +0000
Message-ID: <905e0c51-a673-642c-758b-baf04167c507@amd.com>
Date: Thu, 14 Aug 2025 14:50:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: Fix video_profile switch race condition
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>, 
 Wu David <davidwu2@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>
References: <20250814091032.1354857-1-sathishkumar.sundararaju@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250814091032.1354857-1-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::8) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: d38c8695-c3b0-489d-9aeb-08dddb13c3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVcrVUt2aXVWRGF3Ujl2TFhjN0pxbTYva2hJdjVXTHhFRm5ycWp0N3l0SmVi?=
 =?utf-8?B?NFFodVpxTUk3OC9QNE1mdmc0L2ZXaW4vaFBFb2JSTFB0L0x3UTJEcFNUV051?=
 =?utf-8?B?WCtWRHJsSVM4THlJbEdlVzU2UitXNHZOcittNFcrTnVuU2k0bzV2OS9qMmpG?=
 =?utf-8?B?L244UGtkZ0Q1RmNkdzljbXV3aUJxUDJzK2c4Z1dtc3dWcVJZMG9oQXdkeWtm?=
 =?utf-8?B?ckZnb0RObkFBVkV6V1AvZGtEUnI5blRZLzZxWW1rN0tuT2p2d200bTY0K1cr?=
 =?utf-8?B?dGQyck1EWVpORE93RnVINUg2MzhWTnpFc0tubUI2L1pIRXNnS0NCRDFhdjdU?=
 =?utf-8?B?U1Z0ZjRmZmJ5QWlaQ2ZpNEpYUTg1VUtGUXJVem9GcTdLL3dGUTVacSsvTUMr?=
 =?utf-8?B?cllGTWpLY2tQRHBSMVpSRE5DWk1UVW9lVy83SnJWd0VRdFljQ3RIRkVOeVp2?=
 =?utf-8?B?TEROQVNHcEhlZnZNM2o1ODVJUlBubWZXOURMY253T3U0bEdSeWpCVlNNaTU1?=
 =?utf-8?B?NUtxcmxyRXdRMkp2NTVGVUIyUzNxWmxya3ZsYWpnY3pqVjkxTTdkWmdWVENz?=
 =?utf-8?B?Y3QyWENZTi8yMUlLTjRHWElZM2NMWTJUc2g4QVlNL3J6KzRhNEJwTFJoS3VX?=
 =?utf-8?B?V1QySWI1Z2I5dy9BeW1CRFk1NGIza1dyNTJYL0lqdHRuVjBUUEJodG0zZ1FU?=
 =?utf-8?B?YU5EMjM3Uk8xcWxEV2JZV3RzeGt5cXNqR1pGQks1MldlaXY0V2pOOG51a2lt?=
 =?utf-8?B?Snl4OTlibDZEd0ZlTWlPYkg0NkdCNG4zMWw0MFNkNlZHTCt1cWZzZytPRldG?=
 =?utf-8?B?Mm9mZnlmenBlaXIwZEFadjRjSkhTUXZ3Mi9GZmdjbHc1TWsvemZqOE5Hc3Uz?=
 =?utf-8?B?NDBQTkxVVzU1ZDNyaytwTG1semYzakVuRmViVW9DbHB1aVhtUDR4cmwyaVlH?=
 =?utf-8?B?L0xrUVAraEhpeWZRRHVNTlZuTnJFTW1QVWZwbUxaR3c2ekFFTFVDZ3FueFE3?=
 =?utf-8?B?OXIrUFdOMDJxL3h0SDJZcDZJbEcyNmVQRFVEYmN3Vm5jb3hWVExMZ1A2QXNT?=
 =?utf-8?B?TGlPL29kVHZna2J1dmFpUnJ3aTBhaEJZczFyZXMrS09Wa3BPWlFQOTF6alI4?=
 =?utf-8?B?QURraFBiV0drVnlBYUk5d0Yyb1o0VGFqbjFGSXVqT29hS1hLS2RJendjcE1x?=
 =?utf-8?B?U2J6WHN3VWVtNXMwYW96NzMzYWNhbncrbjAxd2VzSEdkQ2hFVTF5VHdsRDFR?=
 =?utf-8?B?TjJuRS9iOUlSZ1c3eER4Kzdkd3lFMVRqWm0vM3BoY05JYno1UWkrd21UNllZ?=
 =?utf-8?B?cDB5UUpXb2xOZGFiUUo1SWdSM25HSFVXOWxuNDlXOE11dnVIbHYzV0IyVnFa?=
 =?utf-8?B?NndEbXpwbFFaL2JBOFZiU3o1b2pZYWg1eEF3N1dHR2ttMnFVYVAza0RYK01r?=
 =?utf-8?B?bGRSU2VCWHI0M1RZQ1lIL0Q4K1ZldWdhek42aDlTU3ZTRTcvSXQ1TTR3Y3ho?=
 =?utf-8?B?SUFzWUVseEdhTmVHbThYMm5hVjhLNGhaWGpjTU5LZnRGcVZSanVlcndiTURo?=
 =?utf-8?B?UkgrYWFva3FoUjMxT1lVWFBhVk5mQnpBdkV0ZHBmeW9BTSs3bGdzRml6dEhk?=
 =?utf-8?B?RFB3cUVSMGVpN3NyQ1Y4eFZybitMQ0duT2JYVDl4VzBHQWpwT0NsbS83cE00?=
 =?utf-8?B?cEdJZXBncTNmaXI2cFBBRDJyUjBreE50UHhTa1JVY2U2YlV1a2xzOEtycUw3?=
 =?utf-8?B?eUM2WUZVRHQ2bG1adFBWZ3JKTndXYnVHck5PWlM1R2krWU5jdm9tMUIxcnFB?=
 =?utf-8?B?WjVZTEJaVnNXZjhGSzFJUkY0THplanExS2p4MkdlSTd5Uk9ROVhIOFZzQ2Fm?=
 =?utf-8?B?U1ZIc3J0SVhyRzFGQkM5T1NGdnh5cE9LY0Z6b0ZnNDdZYnRQaGVLbHFnOFVG?=
 =?utf-8?Q?f7ZURMUTZko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm5KTWFuM0t3c2dVNnBFVUdpUmlETkU2TEtqbWIySU5XandKYmFJbmFpMDV5?=
 =?utf-8?B?ZmZhWGlRUUtSOVhhTkMwRS95QjZ1eEFlQlVMWS80K2RSbmhRREFDQ2t0RDE5?=
 =?utf-8?B?b3RFaUNwUGpGKzZiV0srSGhVQ3pmaG8yL2JPNkZlaVVmdWJEdXFRY3g5cms1?=
 =?utf-8?B?RTlKUFUzS2hUNWVCL1lJb0VPLzJRQlBPTC9jcGliemlOcUlSajAyY3B2bzYz?=
 =?utf-8?B?a3dQeDJ6L1ZYV0dMQ255SjBCZVIrVDFoNDAzUThINzJFYSsxaGg2OTVCWkFL?=
 =?utf-8?B?cjFBM1NkbWtLRkx4VytPSm1kYTRKV3E0bXpFRVZxSGdkZ0srVmlOME9ITFE1?=
 =?utf-8?B?VkFiY2kzTmhqSXNaSEEvdVcybVZ4Q0NuVUFaOVJRd1Vjc3ZJd3VxRWtJT2dh?=
 =?utf-8?B?NWcxckYzNzZDb05wNkduZ3BteVpwZ3h4K2o3TkhPMTIrK243N2ZTTU1jMWMw?=
 =?utf-8?B?eFBDdm9qOGtNN05aVjE0bkh0SlNXSzU4R3pIWENuYkNWRFpoWGNVK24vVmhQ?=
 =?utf-8?B?OXZRRTBxd0hYVWQ1d3NjYWpHeXV5TVA1M3hnMjBsbVFSQWxkd0Eyellxcmx4?=
 =?utf-8?B?a1lxamt1YkhOdHNrbEJ5Z2xEQ1ZRUlphYW55R1BVRE1YeVk4TnFBbkJPeU5O?=
 =?utf-8?B?UUQwZ0hjaFVBL2owREh2RkZXTjRzaWo0dUNrZnFzMGlMNlBaeWY2SVVFRFVr?=
 =?utf-8?B?NXFoUGwzd3Iza2dyZWhwM0RzajJSazZzQnRTS2xIckdJbzYyNURUQ2FHdFla?=
 =?utf-8?B?STc1akNmSkdtZ01HUHlpZWk2dFRScGtqa0E5SEVHWkl3Uk1adG1mVVlwaUFV?=
 =?utf-8?B?N083OHhTTnQweS9nNzBIdmxIQ2dSOUxWM0VlV3VYOFR1RU1MYk9LSWgwazI0?=
 =?utf-8?B?SlI5aW84TnhLRGRmY3BRZ0hNWUZQRENtREdEYzljUndPbG1GemV0MitDK2gz?=
 =?utf-8?B?R2duL3ljSDVkT204UTAyL0RxMVJIdjFBaGRxTlo4YTVXSHJwUUMzdzE5K2d6?=
 =?utf-8?B?VjdpcGRvL0VoQjNHSDIyV0hNK1NuUGV5S250VzFRa280eVZLdmRoSjZuL3hu?=
 =?utf-8?B?V0hYbGpwaHl3QkJob0xlSldtNjhMV3VxVU1iOW1JNW1qNldJWUlHQTd6UGI3?=
 =?utf-8?B?aXYyRkQ1ZFk0bjlBM2Z6bklDV1FRdHFNT29YeDBIbElVdVJ5cFRSWDZSelFO?=
 =?utf-8?B?WDRPWGhsc1lTSTJ3YWhyczlEcFQ1S0M2QXlTeDlMLzVhWTVFbEsraHc3SWp5?=
 =?utf-8?B?MTV1bHBJcjg1ZzNOR29zMElIVjByUVhOVmRiUmtyUWlSOFdxcHlRbnBNbWRO?=
 =?utf-8?B?MnQyQUVxcEo2ZGdVVXhmTTQ1bzREYkJpQlBsNWFhUjV1WC9DSHR1K2c2eWow?=
 =?utf-8?B?TVNENWdjRVVLVmU0dGs0THB5R3M1K2MwSnNIRnJFNHBCaVpZdG5jMWIyYllR?=
 =?utf-8?B?eE9EazREeUk4UUg0ajhjTnF0RmZoMWExQUFCYnl5U2M3YXJpU1ErZ3ZXb1lp?=
 =?utf-8?B?enJTSkNBTE9FZ2JBQ0tDelp2UmoxTTRZbE9oQmUzd0lMSjcwOEtvc3dMUkJO?=
 =?utf-8?B?RVdhWit1WlkrbUxieEZ2OWU3L3dNUzlSRFNhdlB5aWdIazRrd1RmYVNvajdM?=
 =?utf-8?B?Z0NNMGxHa085RTRBSGlKNDBDbGkvRFltQzJiVGdEdUwxOUVaTXFONVAyd0pT?=
 =?utf-8?B?OEhkNTBJUHk2ZkgyVE5mSUMvNGVtL0RHNC9aQTFVUmFMVkpXRUlVZnBVTUJU?=
 =?utf-8?B?NlZBWmZaUTkxT05COGQ0b0Uya0hFMTZMbHdHbXNBVUFOQVhoV0V2SmozVjBO?=
 =?utf-8?B?OUlmWWxxOWxjQSs0eWFzV0xBY0RuMHNjQ1ZFZldjY3k0RTBTdDJ5V0F1eHAw?=
 =?utf-8?B?dFZSUVZwTjhFU3YzK3g0VEVHZ0JSVU56RVFmTmJ4ZlRVRzNoeDY2NzV6NUc4?=
 =?utf-8?B?RFJkVUhvbXZBSGREaHdhUFBsMmhVUjVreFNhL0JnbDROV3M1eEJJV3YwZDVr?=
 =?utf-8?B?SU1wbXM4VnFCcUpwbVhhaHU3SDBBYVpPNkhOV0FiSUNLUEVwRXNDMlpJUWd0?=
 =?utf-8?B?UElwYUg1Nm45eWNiRGlsZThVQVpLOGRiV2FBN1c5cGFjU28xcy9XSE92QWhq?=
 =?utf-8?Q?0CTXlyobt02Fmum7j6N0BxJUY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38c8695-c3b0-489d-9aeb-08dddb13c3a6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:20:09.1907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pv0nr75T/OA6qopE8gRbcp89xx0qXcuz/JEd6z6gr6Y9a/JtNpEaESZbJOkkDf5HQg1lIySd8ZYtmgiELgmrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
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

Please ignore this.

Regards,

Sathish

On 8/14/2025 2:40 PM, Sathishkumar S wrote:
> There is a race condition which leads to dpm video power
> profile switch (disable and enable) during active video
> decode on multi-instance VCN hardware.
>
> This patch aims to fix/skip step 3 in the below sequence:
>
>   - inst_1       power_on
>   - inst_0(idle) power_off
>   - inst_0(idle) video_power_profile OFF (step 3)
>   - inst_1       video_power_profile ON during next begin_use
>
> Add flags to track ON/OFF vcn instances and check if all
> instances are off before disabling video power profile.
>
> v2: (David Wu)
>   - pg_lock is per instance it doesn't help solve the issue.
>   - protect flags also with global workload_profile_mutex.
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
>   2 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c18..b677b287dd49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -447,7 +447,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>   		mutex_unlock(&vcn_inst->vcn_pg_lock);
>   		mutex_lock(&adev->vcn.workload_profile_mutex);
> -		if (adev->vcn.workload_profile_active) {
> +		if (!adev->vcn.workload_profile_active &&
> +		    !(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_MASK(adev->vcn.num_vcn_inst))) {
> +			/* video profile is active , we are holding global workload_profile_mutex.
> +			 * it is safe to check if flags are 0 here and be assured that all instances
> +			 * are off, since no other begin_use paths can be holding this lock now.
> +			 * so off video_power_profile and update workload_profile_active = false
> +			 * since all vcn instances are inactive here.
> +			 */
>   			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   							    false);
>   			if (r)
> @@ -470,24 +477,23 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   
>   	cancel_delayed_work_sync(&vcn_inst->idle_work);
>   
> -	/* We can safely return early here because we've cancelled the
> -	 * the delayed work so there is no one else to set it to false
> -	 * and we don't care if someone else sets it to true.
> -	 */
> -	if (adev->vcn.workload_profile_active)
> -		goto pg_lock;
> -
>   	mutex_lock(&adev->vcn.workload_profile_mutex);
>   	if (!adev->vcn.workload_profile_active) {
> +	/* If inactive proceed to ON video_power_profile and update workload_profile_active */
>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   						    true);
>   		if (r)
>   			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
>   		adev->vcn.workload_profile_active = true;
>   	}
> +	/* Holding global workload_profile_mutex, so none of the idle handlers can access flags.
> +	 * and cannot OFF video_power_profile at this point. Can safely update vcn.flags to
> +	 * indicate active vcn instances, which is visible to any idle handlers who later grab
> +	 * this lock and check flags for any active vcn instances.
> +	 */
> +	adev->vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst);
>   	mutex_unlock(&adev->vcn.workload_profile_mutex);
>   
> -pg_lock:
>   	mutex_lock(&vcn_inst->vcn_pg_lock);
>   	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index b3fb1d0e43fc..a876a182ff88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -366,6 +366,10 @@ struct amdgpu_vcn {
>   	struct mutex            workload_profile_mutex;
>   	u32 reg_count;
>   	const struct amdgpu_hwip_reg_entry *reg_list;
> +#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
> +#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
> +#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
> +	u32 flags;
>   };
>   
>   struct amdgpu_fw_shared_rb_ptrs_struct {
