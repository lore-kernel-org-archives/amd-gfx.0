Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF0ED1CA3D
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 07:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EFD910E52D;
	Tue,  5 Nov 2024 07:16:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hybvkoXr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E87C10E52D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 07:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t34lDSAegM+YedCVQn6DL8IWgI1JRa8jeDibX0G5VHkhQU+GXzQT9nLBIDOYJobtKILSUBXF5ZkJP34AWAoYdWBI1XO7VcolLPaYVpNrlmkoGRqbkqJiuxo4/sq3baaBv7jbfNTJIeWYvfr0N18L/O5FDacmYQ+p/WsN3q7B3Uwy2Zcu/2rwQPtykxFExrj3P+ODN3peLMRoEU8mv8ekXmm5nK/EaUJWMf2TJk/gw3q/m8sN32QhSltGpZkc0vgXtiLgH1IRfdUvDlm8kIs8tcNbnYLDBB6Va2DgwIhfFbMln7NZfegxP4jxyohzyNrNWmgbS5uVfA7sRqrlHuzEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1wJvvf6inVgLokbGtycEkDRB2M/JrLALcYDnlTS3FI=;
 b=LyDxQ2FzHJzD+AzMdo7TXTzOtZIS+T96GJYq+DvGLI89bptMz3ov7201yIChZpvQJUY/CFmBrfl1a9gPMoIF+TDYZ+Vya7lr7mW6D8iRK/XkDb1blHcu2sq/1RpEtxNLlvViwMHQNxboYxTswcphr5uPJdwfad9rP1shljpHAEUTJhSTqGbFRVdjSeEb9tGQh5OjCIWV+jI2Z+vkCL5ObxEArOWvy2vp3HI66OMhG0bxM+kA0mZ5+Qki77+WN8a/sSTO84JY2DVDWjeppwqzFAJvJqNPPz/RP+bph6SXp7oB/9sal3TUi1OeNFtHVsUbj5Qul88FrayrqEbuvtAoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1wJvvf6inVgLokbGtycEkDRB2M/JrLALcYDnlTS3FI=;
 b=hybvkoXr/7eLuFJMMvMUhh6mrZJnkQ/l4FIPmMZaOWcPYuESfvVCl7aJxC8VzwxV6gCzNwe+W9xSqRBcM7Q4VzOUy8IDkfCp3Pyy9bo0dj+vvb4ATaBQtJ3l5OMtHLiv3DGw50Jfm5QY/eSsYTZb4v8XZXKxcwFVNfJF75U4qs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 07:16:47 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 07:16:47 +0000
Message-ID: <84a81f12-6d5e-4d4d-81c6-fd0c4b948ba8@amd.com>
Date: Tue, 5 Nov 2024 12:46:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add supported NPS modes node
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: le.ma@amd.com, hawking.zhang@amd.com, shiwu.zhang@amd.com,
 charis.poag@amd.com, donald.cheung@amd.com, sepehr.khatir@amd.com,
 daniel.oliveira@amd.com
References: <20241104134947.663648-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241104134947.663648-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 573c95bd-a4c4-4a94-e88a-08dcfd69cf36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDlIRVdNQmZFM0lUQndnb2cvNXVYUllMTTVmMjFKbE5yWDNYRFduUHEzUXlF?=
 =?utf-8?B?QllKRnNKd0VOb2hKdFNieW5mSTZFb2dGR3ZWV0tuYmFUOU9kUUdTdzV3eWZ1?=
 =?utf-8?B?SjJmOVVUeEpqQzBjVkdhOU5Ta3dFV3Fmcll4UTZqc3pJNjFzSFV6WkdEWk9j?=
 =?utf-8?B?KzNaZkI4UG5lMExQelBTSGt0OEg0c3Y1M2pzK0NRVEdieHRuR1lhR0ZFMWNQ?=
 =?utf-8?B?Rkc2SHhlUFJWc3RqaWJnaFc5QmhieU5zckhWdTZVUG5GUzRmSEZ0dUFVV1Jp?=
 =?utf-8?B?eHpSSDBPSVJjeEJTQW5WblMza3B5eVZFS1U4M1lUNUtzRFI5RXVyUUx0RmZK?=
 =?utf-8?B?SHVZYTdUbGNVY2sxVldYMXhZMWx3YkltQ3cwTms3WVNWamJTOGJ2THZDTFky?=
 =?utf-8?B?WkRQeXk5SXg1cjh6VnlLZ2djU2x5MzBOOTY0VDRzbzY0YkhiK1BHQUZmV3pt?=
 =?utf-8?B?V2x0YXM3bWFZSFZSSnhWRGYxTk53RSsxYS8rRHBhRnJheU1EL0ZMbWpzM3N5?=
 =?utf-8?B?UExXcWhHNHRYbVM4bzllVER2bkxNUHltUUtROFFPMUpaOFJQNGlJY0tJamNR?=
 =?utf-8?B?ZmFrWDFFTW4waVpET1QzUitUTmlKUk52Y2JTdGxZQWNnd3dPTzhZSnVCbUIz?=
 =?utf-8?B?VjQ4MCtRYlZoeU9NWjJJT3M2SnNGODNrblNZZWtmY2RlcFBDcnRJSVIwelFh?=
 =?utf-8?B?VGdOVENZS2gydGFTQ1hLa3FxWVdIOURvOVQ4T2xLVVRkM2FJY0EwdEFQMFJE?=
 =?utf-8?B?MmNNQkxMTnhJbG03dEcxQVB5WS9VRnd1YStKVzM4Q3pKZi9Zc2xzS0x2SDhO?=
 =?utf-8?B?YTNxdVQ3MUNCM0FNcGFFQ1VUU21VZ2g5OFJuODdXYlF4MTBrVUVwY3F6eE1y?=
 =?utf-8?B?ejJGOGZXR0c1eFVmdm1pbnppL1FXWVJ2Tm5FcmVjWGVHWnJQbWE1cGsrb3E3?=
 =?utf-8?B?cmU0RXIvOTc2am93YllNRExRdGJ6TGFYbzdXN2tjNTF4N0NRditnZnQyWnFG?=
 =?utf-8?B?emJweTVtbXZyTGtsc3R6cWtoLzEydVRod2FLY2NJQ1AvK29YK0tuVzYrcklh?=
 =?utf-8?B?RFkyUFIrejd3Q0NTeE52WDV6T3ZTVER6UDVsSVpEZis0MDNDM1pGQjBsQS8v?=
 =?utf-8?B?enk0YjhpRWFST0Vld0hDRCtPQ2MrdThodzhodEdBVytsVUZCTHlMYXN3SWxB?=
 =?utf-8?B?YzFuRTN1TnV4dGNWUjhsMFdKMTh6eVdQaWo2TG8xWWx2KzJVbHRqdnpQeW9T?=
 =?utf-8?B?Sk5ndm1OeWlWM09SQi9KZkdwT04wbXBoMDFVWnAzbjBCV2JERFRYRFo1TTR3?=
 =?utf-8?B?Snh6eS9ZOXg3V1FndkhETXZBaEFsN05vVGRTc3Vpb0t3a2Y4Qmx3NFdkTzlE?=
 =?utf-8?B?RC9ZaFZnRWNGc3RCR241WmxESmh6RFEveFZlc2o2ekswVE1jWFkyeW43d2du?=
 =?utf-8?B?NDltd1dJL1B5SStnMy9ITWsrS210NDhyekVMbTJoSU1ieVVjR2NvUFcxeDc4?=
 =?utf-8?B?MXR0WU1yRVgzdTVsVWVpdTllZFRIdHU5K0tyOUQ1Z0ttODRwWnBDemhvZ0hL?=
 =?utf-8?B?bS9RaStnUVN5NStMUEcxMThMOHF6WGRsTkc3M3VqQnNJZ3M5cVEvM0hzYzJL?=
 =?utf-8?B?eDRNOW95YkhCVUwwZ3FNYnlQelU4c1ZXNHZLdVh1NWplTWJId0RLNFhwS3FK?=
 =?utf-8?B?OXgxQ2Zsd3N1d0FWQWhXb0VSNUkzd1RrL3ZqcDhuNXhBVk85RDI0SmhZbWlx?=
 =?utf-8?Q?Iw6POYZDzhgzd7iDEaNghPpQDvcp2HiF/l7cgd3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFBmREgwdlRZbzBVUmpaZi9nVmxPVFVHNVlYVWRqY2F0aUNFQjFSb1VrVGNT?=
 =?utf-8?B?SHBCREJhVDJUc0dzTXZiTFhXbjIyTlZnZHVLTGthY3JCTm5qL2FvbUtkb2xI?=
 =?utf-8?B?eHFaVnBwZUVRU0t1d3pIOStHRE1UbktGZi9QMC95MTlScmFzTG1DZ1pmbDlB?=
 =?utf-8?B?TmQ1U0IySlNVSVJkOW1TSzNDUzdUbTNMR0tJeTdLZkdtN2Z6SEcrQ2JkRjVr?=
 =?utf-8?B?ZFAvTHgwUFJvYlZsVDY1a2Rua2ZYbTVpcnFaaFpISmJHbndVbk9JOU1qdVVY?=
 =?utf-8?B?dCtrc0w0ZElUUWJjZXlYd0xpK21XVG40TkpJSzl5VVpJUThieVZKc3JIU3pU?=
 =?utf-8?B?Q29xUTNVU3ZabXBISXhtTENZSlgxOFRNNVlVS3BNcUdEeW5zd0tnZlBwK2dj?=
 =?utf-8?B?KzlEeUtnV3QzdUJVOGw4eXZ3SlhZb1UrVHZKOHFpWllMeHF0ellsYlprcXht?=
 =?utf-8?B?TWUxbng3S1BKYXRBaTJNdXFwbDFBNVpIM0xIZXRHaXpRQktrWCtZYkV2WHZq?=
 =?utf-8?B?YWJNMGpVRWZCaDk1bWQvUlY0VWhSQnFSVTZoZVZMQlRkUWcranRGa0xMdVlu?=
 =?utf-8?B?RUh4VkVxeWZFU1hvUDdLejIxWURYSzFuMzZ0Q21uQTU5ZVRubktMczd0Rjht?=
 =?utf-8?B?aHZncU8wUWYxeDQ3bkpXNHZaY0k5SE9UazRFVFJLQlBrdEdRMUpKbGlNRzhJ?=
 =?utf-8?B?S0FrZ0U1cVovTlM5Zk5xekJzK1FNSVhSVGlQRXpHVzdpM2NlbkJZSC9zUWZQ?=
 =?utf-8?B?Q3RvVGxoalJLT0YvYnp5R3p5eXZCSm5IUEt3WWk3OGU3c29DRkNzaUlza1c1?=
 =?utf-8?B?djdocnMzTFJhOFBSUklHckFKYnVRZGIrZk1uZjV3ZG4wKzlldHMvVmthRGpw?=
 =?utf-8?B?ZkU5QmFxMFJQVjJHdEpjK2MyOXY5S1IwZ2YrNGJLbWo5Q01rUDd6SGdyTlk4?=
 =?utf-8?B?RzFkazhZMmxKRVhScjVYYUtsemUzZ3gzZTJ4NDAvazBwdXRmbkV1NUMvM3RV?=
 =?utf-8?B?SUl0QkEvQkJYWE5ndG43YXFEWWs3N2pqb09oWG9qTEpBeHpFLzM2SjJjT2NS?=
 =?utf-8?B?cmd4RFNKL1BkMFkwWUY4M3QvUllydS9IbnB2bWEycEI2L3JieXNGUmgzYmpK?=
 =?utf-8?B?S0hjenM3T0xKUk1jSVNLV3oyT0FxMm02RVdKZUNWVnpzY3NNRkYzdjdIQldw?=
 =?utf-8?B?TXcvREJUN0M0TFlTTlpLUkNYNE5qQ2xNTVZBSEtaS05RQWFLc213Sk5udmlx?=
 =?utf-8?B?UEJsdXViZVpQYldpT2U2eENVMnhFcDZuY29Oa1hPcHhpYUMyZGo0ZFF0LzIv?=
 =?utf-8?B?bUJtNjVVVjB3L1F5eVdsbXp4ZnhyY1FxaVJxZ05ScGRackhWZkZTdVF0UHJu?=
 =?utf-8?B?L21nNkpVVC9qbTBJTWpyTDVMS3lLTThvcHlIUytkb2dwQStlUGdHWTFOTUN2?=
 =?utf-8?B?Z25OQUR0aGk4V0xpNVBNOXBvOVRhVXpROHRSN2RBeEZIV0g5bjNxRzlPa255?=
 =?utf-8?B?Z09xT1RSTmF5YUd1WDNyRGVoQ1cyZG50THVFODI4VE5iaHNXQWdsYnRiSEJs?=
 =?utf-8?B?Q3JrNmVpQS96d0tOMG4zR2psMmIrQnB3aXk4YlNocXNKWFI2djlwRjJuckdZ?=
 =?utf-8?B?c09xdjdGOEJhTGtRRy9lUklCZXBsTkNnMGNHSlE3N3ZMQnBTQitiNkZGeWN5?=
 =?utf-8?B?ZFR1d2IxVXJFL1hVQVBzMDFVMUFwV1JaS2IyUnFoUzF4ejJ3eVBOYloydXY1?=
 =?utf-8?B?b3ZtaTNIOTRYZmx2cEFkdmFta2lZcmJGbVdkdC9OQ1hTampQMkFoNHZFZFNN?=
 =?utf-8?B?WjNJdTZCVVlSWXJKUzI4L1ovYzhvWk9oajk3OXNtb1JWZWkvTStnaFlGZWxZ?=
 =?utf-8?B?VGZuNlJjdmV4WCsvcS81aWtVR3F0bFdMdC83elozdGhsNGlvejN4YXVhMHlJ?=
 =?utf-8?B?RlFFQm84UDA1ZEpmWEJ1cVI0NjhndllobTFEYWRQN24yOHBzWnZzZWFsMkl6?=
 =?utf-8?B?OHFSRkxVaHhkVHVkN3RYTGN2bFYyWWdxZHJ3WXc5MVVheGZCbUhoQVc0QkxP?=
 =?utf-8?B?aFNJVjRlTksxUjRoMmR1YllQR2tQVkZLZUp3cU5hNU1lTkhBMXNIWGl4VEtO?=
 =?utf-8?Q?aZsu6MfToki2r/rnZZGRPCiME?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573c95bd-a4c4-4a94-e88a-08dcfd69cf36
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 07:16:47.0997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZXUM6swTfw/FDQLjC81qrUWz2BImI1V415ScXnV9CUmX2KFX23B+WpH6kJddUAh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876
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



On 11/4/2024 7:19 PM, Asad Kamal wrote:
> Add sysfs node to show supported NPS mode
> 

Better to add more description here to say "supported NPS modes for the
partition configuration selected using xcp_cfg"

> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 34 +++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 83a16918ea76..5e1673b1a30c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -471,6 +471,16 @@ static const char *xcp_desc[] = {
>  	[AMDGPU_CPX_PARTITION_MODE] = "CPX",
>  };
>  
> +static const char *nps_desc[] = {
> +	[UNKNOWN_MEMORY_PARTITION_MODE] = "UNKNOWN",
> +	[AMDGPU_NPS1_PARTITION_MODE] = "NPS1",
> +	[AMDGPU_NPS2_PARTITION_MODE] = "NPS2",
> +	[AMDGPU_NPS3_PARTITION_MODE] = "NPS3",
> +	[AMDGPU_NPS4_PARTITION_MODE] = "NPS4",
> +	[AMDGPU_NPS6_PARTITION_MODE] = "NPS6",
> +	[AMDGPU_NPS8_PARTITION_MODE] = "NPS8",
> +};
> +
>  ATTRIBUTE_GROUPS(xcp_cfg_res_sysfs);
>  
>  #define to_xcp_attr(x) \
> @@ -540,6 +550,26 @@ static ssize_t supported_xcp_configs_show(struct kobject *kobj,
>  	return size;
>  }
>  
> +static ssize_t supported_nps_configs_show(struct kobject *kobj,
> +					  struct kobj_attribute *attr, char *buf)
> +{
> +	struct amdgpu_xcp_cfg *xcp_cfg = to_xcp_cfg(kobj);
> +	int size = 0, mode;
> +	char *sep = "";
> +
> +	if (!xcp_cfg || !xcp_cfg->compatible_nps_modes)
> +		return sysfs_emit(buf, "Not supported\n");
> +
> +	for_each_inst(mode, xcp_cfg->compatible_nps_modes) {
> +		size += sysfs_emit_at(buf, size, "%s%s", sep, nps_desc[mode]);
> +		sep = ", ";
> +	}
> +
> +	size += sysfs_emit_at(buf, size, "\n");
> +
> +	return size;
> +}
> +
>  static ssize_t xcp_config_show(struct kobject *kobj,
>  			       struct kobj_attribute *attr, char *buf)
>  {
> @@ -596,9 +626,13 @@ static const struct kobj_type xcp_cfg_sysfs_ktype = {
>  static struct kobj_attribute supp_part_sysfs_mode =
>  	__ATTR_RO(supported_xcp_configs);
>  
> +static struct kobj_attribute supp_nps_sysfs_mode =
> +	__ATTR_RO(supported_nps_configs);
> +
>  static const struct attribute *xcp_attrs[] = {
>  	&supp_part_sysfs_mode.attr,
>  	&xcp_cfg_sysfs_mode.attr,
> +	&supp_nps_sysfs_mode.attr,
>  	NULL,
>  };
>  
