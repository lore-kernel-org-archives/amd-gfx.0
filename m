Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24E4C36010
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Apr 2025 10:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 463FB10E067;
	Fri,  4 Apr 2025 10:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ViKMrc3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA6210E067
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 10:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9ruZkgqL8/y1mTyMNtpwIkwxyruQzGOZLbnafE6iXqmLCi8w9KhBjhVA8suGvTCUTNIqB78cWwAdiSAoQn/OEe4GIKaxSvBRb2iGPaaYv1sxs2G5jdy+qf1b8lAet0VuTOHPYLbvc5kHHdK9f+hRK6PwSSiBwUUpe7Ib3eU0yzld/0VUkxXEHQTpTPt1y/IZlvnd8AYFBuvctTwKipggglOWm157bp1+mI3eZ6ffsYzMnMCntRsjTuhPDWsividotzRRMls4YrfQMZ3uO+5YCv3gxccGEapWwOdsTnOMFrXoy/Zuei91+Vp1d3rCEzAcTCCfJ7Q8gEMHI2mImzmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJjC+p4xeEma8AwvTdXs++rOHrKrYiiYFg7e2dIGuSA=;
 b=Ioo7Gj1+9EzJvooJljMu4HBlKpubiyKAOwhxMoiQpYZoRlK1kSC3oO8LNmZE901dDe4hD2IOXkBB2Cn9Nb7d1iXHvinilImr8idXJB1VWH3Ocmr8oUxRQ2CSy9Fsj9YzAakNz8E4ieI1EueLoWLx/EE5ln4L5Z0slYa0OnjYkGxVcfDVG1oTkqpExCCnkMB72BMvhNX4t2xGqGiwoQVpgDwQfExO1HLOKm+UDV5HYXrRtn8MC/2NoV7P8EZTEy5k4Ah7IkiEJdiAjZ+YqVrpo3i/wNFNEyvS82rA6TnJoWpEbs944SB6wSksmhgK/4PH+iFrOhmPWwwoS3+SdRjQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJjC+p4xeEma8AwvTdXs++rOHrKrYiiYFg7e2dIGuSA=;
 b=0ViKMrc30do6Gi0pB6FyGhE1OqqRosqRfLX9f/k4uMiqJMynriIYX7N2YP7fvg7M12xeFh//kF70qPFpH36uuFYMgPMSdHvPzES+flMGh9FEUxYxVJjxdJhuALepkU21rm5GMYt/4cXsO8J+qOkUnaK3XOmEAEBumUhRuRnyl7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Fri, 4 Apr
 2025 10:50:18 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%6]) with mapi id 15.20.8534.043; Fri, 4 Apr 2025
 10:50:18 +0000
Content-Type: multipart/alternative;
 boundary="------------yJOAT78ASJWGtHtkpJEZwb6x"
Message-ID: <75751513-150e-4ed4-8a99-34e01cf4e1b5@amd.com>
Date: Fri, 4 Apr 2025 16:20:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/userq: prevent runtime pm when userqs are
 active
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250320165249.1238463-1-alexander.deucher@amd.com>
 <20250320165249.1238463-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 mario.limonciello@amd.com
In-Reply-To: <20250320165249.1238463-2-alexander.deucher@amd.com>
X-ClientProxiedBy: PN4P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::7) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: cd784972-69ce-45f2-fc95-08dd73667cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVo0OXg4akFWRWFabFczbm9yUlY4N3E5dWU3TzF2QWhpVWU5ckdsYlkvb1oz?=
 =?utf-8?B?NzdyMmZja3NONGQwV0dRTFNBOWtUQVVhSjRpb2ZRRFRURW4rbVlHUGRvSHlG?=
 =?utf-8?B?QVV2cDBmaGc3SHNtTGRtVmhHemtCaXF0R2pZbWdiRXVFejNHV0luczJPNGhF?=
 =?utf-8?B?bTNZdmJncmRKTU92eGNTWXpBZEpIY1IveTJhOGg1VkMyWjdWdzNRc2J0WVhi?=
 =?utf-8?B?QmUyMms4dXozOCtEWXYzVmg1RU52WGoxbEV5SC9mVFlSZ0s1VjMvZkJOTGRP?=
 =?utf-8?B?M2p3c3p4aVhBdGw5MFh5Q3RMVnZpNjVXc0tGRUNOTDQ5emxLUWxOakc4Z0Uv?=
 =?utf-8?B?OUNkNlo0SUZhd1JqOXdXTTBjTG1nK0ZEMERncU9semhCL1orWi9xSGptZC9D?=
 =?utf-8?B?N2V0anI5TnJmSkcwUWptTDRsVlJyVCtQMFM5SFEzWEdhdGtwUHcvTWdQeWNq?=
 =?utf-8?B?TysxbGF4YnE5Vm9UVVRqVWVxQ3VjOW5jcUEwUnA3WlVLNFdDbmpXUnhrZ0NR?=
 =?utf-8?B?TXNVT2JKUVVUSFIyUVpnWERrSjM2VmdjRFUwcEJiWDRtdno2U1J3em5FSi9V?=
 =?utf-8?B?NVdRcDFja05WZmd6ZVU0bEtQZmpINnpTR2NPdVFFQmcyeDh2ckxmWGZzaE5z?=
 =?utf-8?B?K1VSWTZzbi9SeDVnSUJnVHRMUHQrcWVPaUFmMDEyWDdMdTlMeFg5V2QrWXNz?=
 =?utf-8?B?ZFJoWUs3OHE1Q0srUzc4UEhralZ2Q1NURGcyWTNXTlBhOFd0TXN0YjBaZFJI?=
 =?utf-8?B?dWRIT000SWl0b2ZjWW5HZkpyaHJ2ZVp6akRwbk9RM1RVZm5XWTVqdEdJODVl?=
 =?utf-8?B?SnE5UnE2eHB0RXBaMGRKOVJybjQzT1l5aHVPdGRvVWViTitsOVd1Mmd1QVE5?=
 =?utf-8?B?THZhMWVyS3pvZUFxOVh5U3B1TVVkMEpFbDkwaGV4dkErR3dyN29UL3g5Z3FL?=
 =?utf-8?B?Wk10VjRCWEwyUFVvc21nWmlRbEpTUHNrWkNzV050WXIxNVc0RTB0TWxXd0dP?=
 =?utf-8?B?Q29KdWFUeHYyZ00zMVcwWUtmcE9nWUQwYzBPakJSL3ZRZGlWWHhCc1FWZ3Vt?=
 =?utf-8?B?SzNRSDhodldlak96UGJTeEV3c09yaTUzTDQyelFLV0lIbGlYKzloUVgwZVBV?=
 =?utf-8?B?NTVyanhoN240RjBLNFZ2aFk5eklKd3dPdGQ1Nk5VUlBmci8xSVZLUWd1aGNk?=
 =?utf-8?B?VzZ4Y2t0VUlPQWhrdDJiN0M3MzAweGRqK29aL0FzN2VJUEQwbEVEckcxVm4y?=
 =?utf-8?B?SGtCeUdDUmtaR2czNU1ITzE5V01tMlFycGEvS0tjdWloR2tmRTZyRldYS081?=
 =?utf-8?B?VXcvZlQ2bGw4Mm1SOGdUbHlNd2tYUzU4T2UzRzl3ajVlTVpPeU0yNUlUdWFZ?=
 =?utf-8?B?K0wvNjRIbWJXcHRmVmszTnlySDFsVU1KMFVqam1tTGxiNFBEWVZJMlZNdU05?=
 =?utf-8?B?REwrVjVxTTNOa1B0NjhQenJaQ1cvdmI0aGVSdWlseFU3bjgrRGhTSXNPZ0tQ?=
 =?utf-8?B?Slo4Wk43TnhGT3A3RWEzRHllcGdIYnNGTjREKzhFQzhhR1ZhRnVVQUtGdmkw?=
 =?utf-8?B?MHhoSXRuRlZzRzRvcGJPRU1vYVBCa0tHT25uenpvWmxhK0dyK2Nxa2ZFNHF1?=
 =?utf-8?B?dS9tbzN4UkJqVnpPVzlIR1hJWkpwT3gxSWdPajA4TUh3OVpEd0VtRnQxSExw?=
 =?utf-8?B?QlJZVFZaeVU4VmVib2RRN1o5bWl5d3lRd0FCOVpYSmkzSUZpT3B4SnBnemlt?=
 =?utf-8?B?bUNoNWxIbjY5ZVQrbFB3WlgvOTVGRndTdDQxNUgrNWw1bnJBVldvT0tqTzF1?=
 =?utf-8?Q?8dV/nt++8Q+zKnqrOyUrT+wNunJVlO/Cw6tuA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXFrVng4ZXV6amhaSkd6UDNqbmtMWTNBZlgxajhuTXlzbklVSExaK3NEVStS?=
 =?utf-8?B?QStpMUJLYWNXQTU5QUxOakF4dDhUcURYQ3UwYzBTa0lYYTFzQTM0NStoNTFt?=
 =?utf-8?B?cnBpcnhvOGpVVnp2cFl1TUY5OUl0bGJ4OUw4d0ttWjErcGVKRHRYYklHV25C?=
 =?utf-8?B?MU45azhwWDJndHJPQ3Q5b29VMlhWY0JxZGp2eUxXdW5yMXFkbVVEbnhyUTV4?=
 =?utf-8?B?UGRwWHlmSmQvbFM5NmZMNzR1ZTdNM1MvRGFXNXBWUVRpbCsxbUZDVyt6WHg0?=
 =?utf-8?B?S0pRMTBWMlovdzJLN2QxdlNUUWpDZ3FDN0p3cGViTThYRzJJeTVrMjByNnRi?=
 =?utf-8?B?YUswMlJMdjBVeEMyR2RPb1gwckJoai90cjJmOFpXdHM1aVgwNEd4b3hod0d0?=
 =?utf-8?B?eXgvZXU0cUJYVlpVM01mV3FRNnprRi9ESTJWaHk0dXUrdXBMUnE0TmdHMUhC?=
 =?utf-8?B?NEtFajFRS1A3MHJJNDFrWnBvMU5hZzdGcGNhcDN5ZVFUaWhMMG1RTWRzZjNI?=
 =?utf-8?B?RFBzd1huNVNLa29NcGx5RnMvNFJKNG1HbVozdGVHb1JLRVArZUw0azB0bThX?=
 =?utf-8?B?eitVVzk1ZS9EcEtSQlcyUUE3TzZURGx4TDBsRVBndXFuNEthcGtSQTVBZk02?=
 =?utf-8?B?eGNtMnNab25JckpBMFNucDAxYzZreFIrblRlQVl0cEttRXpzRHMwWDVVcTJ0?=
 =?utf-8?B?d0lIMFdSN3d5MDhCd3dyZGxaak9sckdMVHBScCtBZlVVYU1ENkVRZjZaSmtW?=
 =?utf-8?B?am1mT0MvVmdNam01QjE4TmVLWVc1YWlNU21iUlZLK3MxeWQvVFhnVXB5WnA4?=
 =?utf-8?B?MDFZWDU4QXhHazZMbmc2ZjBlU2VFbjdnakNsQmZMaW1JQ1hUNjJhNVNUWFBw?=
 =?utf-8?B?d3M5R2dROGl6Nkl4WmVLOGxQR2w1VS9Lc0VudFpiUVVJMmFIY2xQR0NGNjdy?=
 =?utf-8?B?WXJ0ditnS3RybUo1STRRYnFHRFVSUERhM3NrOVhYdHcza21WWGppZHA4M1hj?=
 =?utf-8?B?bzk5VDY1cURIN0hJKzBEYzR1Zy9qYlZ5bmE3SCtMR0JyOXJKZnNRUU1seFMy?=
 =?utf-8?B?cjZWQUxadVVKcnFMOEgrYzgrZGFiR2ZldWpibVV3NlFqWUgwajZrSFRaNWxy?=
 =?utf-8?B?bTl4OERNQlFwRDBCZXQ2ZjFtSVNGRGxhMTM1TEdQb2hQVGFhTlcrM2xaaGVN?=
 =?utf-8?B?Q2liVXJqck9BUmQ3cUI1TjFkRXZmUHU3RlJJWElheHVwUWR2RlE2cjZBYjJZ?=
 =?utf-8?B?dnJVUTBwUkZZNnVWYW9XemdmbFEzbVN3QjBoOVZZWjJNbGxqSHJKNEVLVHZh?=
 =?utf-8?B?d3FQb05scEx6ZjJQRUFRSlArWjM2V09OWmNrR3lnUVdGWWRETlVoNGFWVWly?=
 =?utf-8?B?T0Q2OEFIU2crOXhMVVNNK05IdWtwR21jVEJuQk1wc3ZmamhHS1czV05TSDEy?=
 =?utf-8?B?VDVLV3F1d1JGYTgrM00vOHhYYytXTDBMckJQM3FWeXVJWUZSY2R1dDJReW1S?=
 =?utf-8?B?ZHdYTVRGcXk0Vys2L0hTWHI5N2huaTVJSERmcklwZEFIYmR3UGZmRWVFT2Zq?=
 =?utf-8?B?TWVqK1NHek5yNnBWa3ZYVkwvVkMzRWlPeW1LYVk5dWEzb08zQnAwb3RzcWEx?=
 =?utf-8?B?c21oeFhPQ3ltSUpmWEVidjI0U1RJWjRLVmhxNktvc2VrU3dlU1V0MmFvUkVH?=
 =?utf-8?B?WEN2M3MzdVpOanRoNUNVbFAyMytocnBJa2FDU29pQUlIdDNFc1hyTWhXWUcv?=
 =?utf-8?B?SGY2czJrbW45RGV4MnZkcUk5ZzRMa1dTbVhXdlVtczdFWnJNVEhQd2hVQXUy?=
 =?utf-8?B?NGpjdlNnZU5XMG1jWm95cjdZNU41QnY0cGFEK2Exd0tWV2NwYTdkVHl4OWRJ?=
 =?utf-8?B?M2hSN0hhVmxaeUdBbTZnWTZvRWQ3b3ZHTFA2TEZhV0JvOXlETEthUjBENE5p?=
 =?utf-8?B?c3c4RExSNEQxcTZER0pZQXUwaDZ1WDRMTENvN01TcUVTcVRQRDZlTnZ5c3Qv?=
 =?utf-8?B?VFhQR1dNNk5DNFVzQlljb3BUNnczckhXMHhDS25QMTd6OVZkSFBETTlPMW5D?=
 =?utf-8?B?NFQrQTg3bWtqdkk2WjdNbGdsNjRONElZUVozclY1dU9jQUd2VUJ1NWppSG5P?=
 =?utf-8?Q?IW9/gGaMkMTZxO8xEX/6uMWJS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd784972-69ce-45f2-fc95-08dd73667cff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 10:50:18.1661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmHptKdUCPWX0XiOqMohtE12Df047xCwH8mSJuyiiuXc40z7wkLCqkCOooZCNuxkQze5qEQ1FdCLaaRLAWianw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710
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

--------------yJOAT78ASJWGtHtkpJEZwb6x
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

This patch didn't help to resolve the system hang issue during suspend 
that was introduced
by the series - https://patchwork.freedesktop.org/series/141717/

But as you mentioned, the runtime pm needs this change while user queues 
are running.
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Regards,
Arun.

On 3/20/2025 10:22 PM, Alex Deucher wrote:
> Similar to KFD, prevent runtime pm while user queues are active.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 30 +++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7d49a0bede1e2..4ff2e423c50cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2705,6 +2705,29 @@ static int amdgpu_runtime_idle_check_display(struct device *dev)
>   	return 0;
>   }
>   
> +static int amdgpu_runtime_idle_check_userq(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_mgr *uqm, *tmp;
> +	int queue_id;
> +	int ret = 0;
> +
> +	mutex_lock(&adev->userq_mutex);
> +	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +			ret = -EBUSY;
> +			goto done;
> +		}
> +	}
> +done:
> +	mutex_unlock(&adev->userq_mutex);
> +
> +	return ret;
> +}
> +
>   static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev);
> @@ -2718,6 +2741,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   	}
>   
>   	ret = amdgpu_runtime_idle_check_display(dev);
> +	if (ret)
> +		return ret;
> +	ret = amdgpu_runtime_idle_check_userq(dev);
>   	if (ret)
>   		return ret;
>   
> @@ -2841,7 +2867,11 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>   	}
>   
>   	ret = amdgpu_runtime_idle_check_display(dev);
> +	if (ret)
> +		goto done;
>   
> +	ret = amdgpu_runtime_idle_check_userq(dev);
> +done:
>   	pm_runtime_mark_last_busy(dev);
>   	pm_runtime_autosuspend(dev);
>   	return ret;

--------------yJOAT78ASJWGtHtkpJEZwb6x
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Alex,<br>
    <br>
    This patch didn't help to resolve the system hang issue during
    suspend that was introduced<br>
    by the series - <a class="moz-txt-link-freetext" href="https://patchwork.freedesktop.org/series/141717/">https://patchwork.freedesktop.org/series/141717/</a><br>
    <br>
    But as you mentioned, the runtime pm needs this change while user
    queues are running.<br>
    Reviewed-by:
    Arunpravin Paneer Selvam &lt;<a href="mailto:Arunpravin.PaneerSelvam@amd.com" class="moz-txt-link-freetext">Arunpravin.PaneerSelvam@amd.com</a>&gt;<br>
    <br>
    Regards,<br>
    Arun.<br>
    <br>
    <div class="moz-cite-prefix">On 3/20/2025 10:22 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250320165249.1238463-2-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">Similar to KFD, prevent runtime pm while user queues are active.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7d49a0bede1e2..4ff2e423c50cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2705,6 +2705,29 @@ static int amdgpu_runtime_idle_check_display(struct device *dev)
 	return 0;
 }
 
+static int amdgpu_runtime_idle_check_userq(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&amp;adev-&gt;userq_mutex);
+	list_for_each_entry_safe(uqm, tmp, &amp;adev-&gt;userq_mgr_list, list) {
+		idr_for_each_entry(&amp;uqm-&gt;userq_idr, queue, queue_id) {
+			ret = -EBUSY;
+			goto done;
+		}
+	}
+done:
+	mutex_unlock(&amp;adev-&gt;userq_mutex);
+
+	return ret;
+}
+
 static int amdgpu_pmops_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -2718,6 +2741,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	ret = amdgpu_runtime_idle_check_display(dev);
+	if (ret)
+		return ret;
+	ret = amdgpu_runtime_idle_check_userq(dev);
 	if (ret)
 		return ret;
 
@@ -2841,7 +2867,11 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 	}
 
 	ret = amdgpu_runtime_idle_check_display(dev);
+	if (ret)
+		goto done;
 
+	ret = amdgpu_runtime_idle_check_userq(dev);
+done:
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_autosuspend(dev);
 	return ret;
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------yJOAT78ASJWGtHtkpJEZwb6x--
