Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1EDC3601E
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 06:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B4D10E2F5;
	Mon, 14 Apr 2025 06:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4oae4Ygh";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F59510E009
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 06:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3ofMoRch0xRmncHti1OaxQvXQWE21m8yZ0xg4Dzpn7OGFvljX8ZWa7D+MhN8wzCxvYvefzgNTFz2zu9sJIznsRl8zEHCjGOrbI/oo4MH0LQMpkrDxdh+Jkdxb52LBqWQCJfSuwYiWAEn4i1cegEdJBkzhYztMw3bk0OCuwSfWDHRIfBSvonMT7IpaSBJ3QCMnaFJWdRvXnqsGw0kGoxCRy68bHUdOQA/j4LMUCPeYPsoCsws5xK4ZyDlSgBhbFD7yuH3a6CI5woBXWw1MY3iENa7d8kM495eI6jo3JwUW1w8r3jiFjXMQRNkiPNGlhi3QT2W95SC8FuDhuQBlDMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5jvlURRSD7wrq784zh8ClR/J40FqdHP0bqI2Xbw4DM=;
 b=ZDCUYYt88YlhcVXvTlKikI7ARTChLhPmF6FnjFMXRZz9GAQQXozROfl4y/WpUJWp3JFtWEDqIunQNzgs/M2ltQKWOCZ7LoCluBtSAxC/tiPf5Vhf03tbQ0D1zK5YMJh14rN+MLQ4IdNdkj/zh1dh5FbaQ38s9a8SXvprNQpt589kcTMZ/bFjRyVa0uTcQYdQ3OJ8d5q639mccX4Lsp8Wvhd/k76CC3VqUmY3J04ohiP3EEfRdJRIxhlwtkxwD81xhdvrEL661IKQetppJ1J+wTzK0pN1KeDXItQPpiN7IGs6rg/MzL+A5KczkSSJsrRaTodcQJOhIhy4eh0NVtIQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5jvlURRSD7wrq784zh8ClR/J40FqdHP0bqI2Xbw4DM=;
 b=4oae4Yghi8P3UazVCTU2ElDQwm7frIEA95k2i6cvvGgZZx45DbeS/J7BUk6eu+jyLLGmbkXqMeiJVWgDTWJS7sMzQeU2orbn64nFEjjBo1Gv4BCf1lSViE2x3seZDcjh1Z7gJMvp7fNJAK62YwgDYB7Wxzy9xu7Hb9VJL3fS5BY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Mon, 14 Apr
 2025 06:18:57 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 06:18:57 +0000
Message-ID: <c7436ccf-d819-49d4-8a13-8dfd0fe4161d@amd.com>
Date: Mon, 14 Apr 2025 11:48:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] drm/amdgpu/userq: track the xcp_id associated with
 the queue
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250411184825.2890189-1-alexander.deucher@amd.com>
 <20250411184825.2890189-8-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250411184825.2890189-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::21) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a63d3e-2acc-433b-1611-08dd7b1c3d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1pzTWl6L0Fla0cxQlYxeUFzRVUzdTgyM2V6ZlI0b0RmdFFGRUoxc0RaMEFa?=
 =?utf-8?B?bkZxVitpWENYRDlCMGNML0xrRWcrRDZJQTZWeng1WTROOG0yYXlHQ3FTMEtO?=
 =?utf-8?B?cVNuRXJPUHdCakhaVWpubUZIWVJiazFIK0tuMU83T2FhamZTSGRYNk8wRjgy?=
 =?utf-8?B?dHFXTW55MEhBclJMN3JMMksvUVozMDYxRm40eTg1UC9na1NKTmZ0T2N0OGFR?=
 =?utf-8?B?dGVwNlpIeTNpOUliWVl2Wk0rbVRDRE5UNVFjT0kvOGplMkRSODhKYncrSjdT?=
 =?utf-8?B?MUNIaERSYzUzVFlWaXlGdHVHTmFCWjVveUNOY2xXcFNLOTNuTFdXOVlpSnlm?=
 =?utf-8?B?L0VRazQ0L1Y1WVBKL1dVNVpTS3ZOcUt5YTVzb3pISlg1MVdOemFpWDdZYWo2?=
 =?utf-8?B?Z3hDVllLS0JCZnpEQ1B2MWdrMTBDUzVqMk9wSk13TEZLelhheDdzQldXZklZ?=
 =?utf-8?B?Kyt6NmIxcUV0cnZLbThTbmJvYmE1cE9zUUFjTkx5WHRwVm9DWGcrejBTY0hD?=
 =?utf-8?B?bEVpSnAvcDVabEg4aEVFelgxNW91R0pQaWlRZDFvL3RkR0twQkUwenYxcW5n?=
 =?utf-8?B?cDV2dytjaDk1VEFELzNmckR6WGVVSWpBeXJoSWJZdXpIMXNpcW5PMnZKTi9R?=
 =?utf-8?B?M2lId01rUVFhZzZFTGZ1Zk5tblFGd0k1NEg2azdoL3hSQVV6bHVvTWxSUWdu?=
 =?utf-8?B?MmJlRmo2bUgwQjY5MWlqVXhEQVduNWY4SGNpOGxOYXhGUzB4aS9jNkNMb2xH?=
 =?utf-8?B?YmJyVDFOV2tsVzlBYW1ZUno1UjdXZWRyYzFqcXlFY3IxK1FhakF4VWRyQ1M0?=
 =?utf-8?B?TkNlUmVxYkpJK3RjSURWWGlhL0ZKd3c1VHNKSVQzOGxNZlNsbS9rekI0Y2ZK?=
 =?utf-8?B?Q2xJdlJPV0ptWHR4ejNkei8wT2xQdDU3ais3QXhMSm5VaHd6dWszM2YyQmp3?=
 =?utf-8?B?aGk4UnRjTFlyUGJRbU5JdElmRXpFeXE5dVVpWmtUcldEN1hHQ3dFMEY5ZDg2?=
 =?utf-8?B?NXFFSllJM3JKSjlzb3BuYnllUkpoMWNuOStwWG1zZUJEWjBPeHlTcFJLZ29j?=
 =?utf-8?B?U2xkenh1Qkk5em9sdDJ1MGMyUG5PNTVYSnRaTFJRbEhUbGZBb0FQZmlBeVdH?=
 =?utf-8?B?YkZLM05MWXlUU2pUVE9nOTk3MlZ2SWZhWDlJdmVvSVpma2NPalBaZ0llRitR?=
 =?utf-8?B?RHREMTBaSVozbXJvcjJnUTR4akJBcVMrT21kazZWYnhnbzk2ODMyNWpwVVNE?=
 =?utf-8?B?dzVJN3Z1ZHpQUWZTWVVjMkdtNVdSMTY4MEdVRTlTUjJ5Q1A4UnlMWnBjajBa?=
 =?utf-8?B?UjY1QWZmZklDMDQ5b3dsYVZkeVNjZkNPd3RXTTRRam1mZWFLL05OUk02WENu?=
 =?utf-8?B?dERoVjZTOUtSdjFLTWc5cHhqWnRjZkFDZWxXK0JUT2hUMHpMUWJMbWhvVXg1?=
 =?utf-8?B?cEdzamN5WEVLMmI5dmF0ZGZMVllUOGc5aWFCQ1g2RWMwaTFaK2czSXJBajNL?=
 =?utf-8?B?NVRzazZDSTM1OEhGMUN1Y0Qya00zaTdyeDJWN01WY0FIeUp6VkYvWDZ4WXdZ?=
 =?utf-8?B?SG43UGU1V3lCbTRsMm1JU0ZkVWhLd3dGUEdWK0lkZGt0RDJIbklYR3NKNjJM?=
 =?utf-8?B?SjdvMXBuY3prdFFIOVphNlhwd0dwUy92a2tpbm5RWG4vSUxBMERKM1ZXMVNy?=
 =?utf-8?B?dXdTN0NqUjgvbjhhK0srUGRwK1Q3SXRScnlkZkhadXcxLzZlclQyRk90bDZ2?=
 =?utf-8?B?QVZZMHFoN0NWLzZpMk9aOFNaOXYvZG92b1Z4Y1NTVE9hdXI2Nzl0dkNuV1Ry?=
 =?utf-8?B?NWhmNnM0OTdTS3ZCbVJ0WmZ5VWx3UFRieEcyYjdnaVljNTR0RzNUTC9UcXFt?=
 =?utf-8?B?dFlwOGFtOXYxRFlMb3NDQnh6RGVjN0k4Rm5ETW5NOWJQdTc3YmxWVWkySU1i?=
 =?utf-8?Q?J5kEsfUhpDU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU45NTdMNE9LUUJnS0tjbmIzWTIrRmFIR2VaZHkzbXF3SzU4MDNSSHE3RzhW?=
 =?utf-8?B?b2FSWHZJY0FvTW00dG5VcmxrSUlEdldxT3k1d0lhVkd5QzBnRHVNbzZVTndu?=
 =?utf-8?B?b21RTHJiUVh6NWYvbTltVkYvdTBkcUNkcEkraGRQNFc3UW9sZ0l4Wi9CZkxY?=
 =?utf-8?B?MjFQUWp1ZzBXTUVQMG02Wko1eE5uRzZIbjF3cVY1bHFKcXNtcDFBQnJjakVN?=
 =?utf-8?B?QnBpQWt5Ty8ySGJIV3JPckxRWk1rTVgyL3NZbnFwMzNiY2xiZGROcFlxcU42?=
 =?utf-8?B?eFdqNzVmQ2VScnM1NjJIZ253K0FCWmx3WnBHT2xHamhWV3JTMUN0N0dVNTNN?=
 =?utf-8?B?bWNSeXAzdUp0eGNlNUpselVKNWZad0cwVTlVUG1jL1MraGZtZk5oeDlUUnht?=
 =?utf-8?B?dkI1T1N4VWVrSGluZG5pNTNXMHhpTnZQQjZOcEpEOWlVR1phcHdmQzVjY0hx?=
 =?utf-8?B?cUhNYjFXOEtoUW9kR3VSN2dST0I2YWl3V3JIWks1S0tQbkNKM1YrUm12TFNz?=
 =?utf-8?B?TnN2ald6QkxuM2ZxUm4rWUFrc2RSdUsyRnlLWEVlNlNjbFNSTlpqd3p2VXFM?=
 =?utf-8?B?TlVzOE1HZThIeTU3dkhJMWMwV2hXWlFhbEtyNmI4QVUyUmNnSnM2SGtSV0oz?=
 =?utf-8?B?eExESzFQSWttN2YyVE13TDZReUFCODFsWHhITlhKWFVpdm5CcXZpTDh5VTZC?=
 =?utf-8?B?R2NyVituaWZqUXdiM0JjSFN0ZEVGQklMcWNMOUg2d0NVSU9LRXg4aFRKVWov?=
 =?utf-8?B?Z1BleU1jSG94cWl0bURjVUZRbElTcnh0Y2ZmaUpzOXhkdS85YlNlb05Pa1oz?=
 =?utf-8?B?V3BwRm5oR2dYcW5mdERkMktCTGd2VHNuL2VzWFk0NXVNcCt4V1l2RHVoaXdY?=
 =?utf-8?B?Q2YwdWREUEZBdDdXLy9jYjlQVm1wMGo4NTFESE02VnFLbkFMRThLdVV3RURn?=
 =?utf-8?B?UkxHZXJCbG1xcnR4UzJqeWRLNW1IMFc5eUlaSHQ2c3VtWVhZWC9iTTBpU0dD?=
 =?utf-8?B?VEwxVDFhODNaOWNjWU5JUkF2WDUrOFloTmFXcGZNQ09kVFc5QmozbHJTVitQ?=
 =?utf-8?B?TndYOVZiSnh4djU1cTZxM01qOEFwcVVXb0YvSkc1djV4SmhQa1dFVEpVODVF?=
 =?utf-8?B?bVduZDZLL1RVaGI1ZW45Ym0yekZWVzM3RnZRSGhrNXVNd3VsY29ZVStRK1Rn?=
 =?utf-8?B?cWdMZi9oMzcwWFBROVQzR01Zc1RrY0lKU1cyOFdMTTZxOFZSTEVzU2Q4SXQy?=
 =?utf-8?B?TGpDcm1MN2xxOHNVT1pPamRJejZFZjU5U1FPV1prOUJwbGx4NWJnaDY4aDUw?=
 =?utf-8?B?Q2NlSFNMN2FDd3JQMFN5N3gvbEpGNVI3ZlZ4TUtSL0pxT04xUHk1b2JRejFX?=
 =?utf-8?B?b0pGcGNXNVRtQWc3UWNmR3BxQ2JxZFJVU0czWGVlcThEd3had2ZsNkNYVStO?=
 =?utf-8?B?RmpNczhsZndLNVpxakthcUhmS2N3OStNMUtKVE1iazZkcUw0amJ2eGtsVGo1?=
 =?utf-8?B?emhVNy8xMnZ2SGdkKzY5Q3kvai9Zek1YNjBSenpYemlnK2E4OXB0dTdiNjg4?=
 =?utf-8?B?UmZMQjMyMDF6cDZKODIyWEVhN0o1NE9GMkJEMUIza2JRYkFMa3dmZWdhaXRi?=
 =?utf-8?B?UlpmY3AzTXFiZWozaktiOW9RUFd1c3RRN1lVWVorUlRFcDYrV2gvbFpLakMw?=
 =?utf-8?B?dFIyL2Vmc1dOenBQVldKRFdneFFNVG5tSEwwcWpJdmpReVNka3dCeFNyQWcw?=
 =?utf-8?B?M2Eyek5rQ2xIdVRiM2F5T25SV1VaRlhrVXBDcWU3ZlRNM1dtYTlnb1VuYXFP?=
 =?utf-8?B?K3grZ1A1MVNEZUlqU0ErQkR2TTRRdkQ2WkI2QWtRV1JxeTR5UWhKN094dXZW?=
 =?utf-8?B?cDZOZUV5MjFmSUN3QjdHZGpHS1o4RkFoTUszT3g2cVBoc3FTRlhCc0hFVm1q?=
 =?utf-8?B?YUxoMEw1aW9wVkFGdm1BMHZCaktzL0d6SnNjV21MLzdQRE95TTlvc1VZbTdk?=
 =?utf-8?B?TFZWSDdsTnQ0RU1YK0Y5NXhpTVJTQURWTXFKNHVQdUVuRGdVc3FFUkp0OHUv?=
 =?utf-8?B?dFROVGhYL2hnVGlMWnBMQlludWVSU1pKakdtemdrazdULzVlQ0x5VXVxVE1T?=
 =?utf-8?Q?tH4mNRgJTXXwBwiuw2b0QA71y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a63d3e-2acc-433b-1611-08dd7b1c3d35
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 06:18:57.6120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP15I+jI8PD7YoiXasfZJdoV3GYe3+OcLFW0Sni0ijhQQBqUTGudK6Jb0RcvPPJleyS1z2GRwFVrUj86TlF0IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/12/2025 12:18 AM, Alex Deucher wrote:
> Track this to align with KFD for enforce isolation
> handling.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> index 381b9c6f0573d..db79141e1c1e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> @@ -56,6 +56,7 @@ struct amdgpu_usermode_queue {
>   	struct xarray		fence_drv_xa;
>   	struct amdgpu_userq_fence_driver *fence_drv;
>   	struct dma_fence	*last_fence;
> +	u32			xcp_id;
>   };
>   
>   struct amdgpu_userq_funcs {
