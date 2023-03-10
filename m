Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A921FC6FA99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 15:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C69810E8EE;
	Fri, 10 Mar 2023 15:12:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175ED10E8EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 15:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qa74O58z4H2qFUHr04v+og3G7wOFmfVG7uRmRObp89Hy+vuj3ZL98W/CeQzn8bbFsNAUawB3e5R2Bmo8ArqDwbzcTZhWtHjzMixDmyVydwshjzNnxbAjLuvNuI//NIW4LVDc89Qn83gDPwg1fv63DtEOyXDHgZ7GtmrrYbSLeP7q+dyAyb/8Puv4p2Aio2R0EPAvuxv2InIf9i+yBUZY0/cGG6l8LXs4f52Q5h5kjtP9cjHPgcjIUeIyXxS4OUi/aES9jS0DyUPYY3GpGyavl1LZCXEkuFcWhKJuBzTiuF7lwpvca1y6adO+0bwxjeo/beID78oScyE0ud5m2PKYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yzsUARgejs2JyQxFk3bvijVrM97s8pEGJR97zBQhfE=;
 b=mJkrk8ghMRe6IjrbsTwq7pNhLxvamIKvK+4N+grbd/sOiNM1Bsegg/AVjALBh+onLMGvQj7qmgbpbJrpNb4Lb2lRIgYv6NdCHQPbSH1IGuF6PUZEm/+DO/zp7zmQq8jtwoAO+O2Mn9sGWZpDFmZ7u69BqRJzSRygubpoRLWntDyRELMGe2K4OieKiZ+lh4yTRXQvwF2UGJjlKaesmqcqHLodhek6F3Z3jJq1LUDBTH8ubdbPw6LzN4n3Jfj5bQQmAYyXwu+lGeWpLBT6mY1H01HJ3qCUEAtVzusy2RVydPdcec3XMdOS+GvcAqsTUpbEtZF85J9o3O2L31wcgEaPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yzsUARgejs2JyQxFk3bvijVrM97s8pEGJR97zBQhfE=;
 b=D3dZY3R7VtkTZ8g7s/qsOotDJYK1+oRPjOWuo77Jcre3TqRC0R663kQWmZD1qwPH1uU62Vl5OU+x9a6Xv9GyZ54H+noVDzVIEuQsfH/QbJsBlm7UgjwaI1fDZWI5rJnUtmg3kpYVWJth1T39wqHrKfrOsL6yUD+TiRsYPS3eNHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.23; Fri, 10 Mar 2023 15:12:52 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 15:12:51 +0000
Message-ID: <7f917303-2284-b62f-ca60-789dac1f333b@amd.com>
Date: Fri, 10 Mar 2023 10:14:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amd/display: Set MPC_SPLIT_DYNAMIC for DCN301
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230309181838.463319-1-Rodrigo.Siqueira@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230309181838.463319-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::17) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|IA1PR12MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e377cc3-7dc0-4719-ba99-08db2179eabf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpNwKaDDdHwmooi7tTWJEm/+LtYKKJdYOtDRDd2UvMF/q/w7g4Cs9SgD78jpQP7h6xZfXDzElLF1Pa7whcPo+pDwkhcN7lzfmtwM/QJ117DaTv3vxNCnGgHjYBjlDsD3BKI1BFA71vnDzAT8Z2rzDeIdZBGWFNHdMlLUcAUcJT2Rw7mZV2evNeBN0xsoBhTOnDGZrmG/eYFT0QhlKoL++FBpcICIWJB2VkgvxTC+HHzrxk7cN/aL66n6ySOANM5BMk64HORl+xK3YB0Rkxt6Y7gRkkv3KBvKSlIPEhQaYX7kQt7tQVOsHgtWn97l451sIkAH1c196JzV+cnBSRTC1JyHY9TMS9KgMzFX6Br+gdub9fJ1n6AUv16AXHufsP5pno8/gsSw4+YYAAARPCSmby2QeIfVHMo9kK8fntfzBZ/6RmLO9cP5miAYDV0FPk4nDCkKfV3IHZq5Z8vRyx9dpbgmCwzMX3ZelnliEpXkoc6tNVpUORTzsKY0k8XdO/Hg5I3BCSU7k1yZb0/1URx06hz/1f8op51JdN25PAqk0bS1R3+MUvM+5Ag8mXn0XqCM5JuJIBM95Xo5cumVYePxCefFYVFw25oYCfVfFpdwcaifOCCib+Zm64LOrkmm51ii19f/Mk8/psy8W7IiA7G0NDYxpLy82x7WC838JL1ErM5NAA2Wlvijri8S5Gq7V29w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199018)(8936002)(31686004)(66476007)(5660300002)(41300700001)(66946007)(66556008)(316002)(2906002)(4326008)(8676002)(54906003)(66899018)(478600001)(44832011)(36756003)(6506007)(6486002)(26005)(6512007)(966005)(6666004)(53546011)(31696002)(2616005)(86362001)(186003)(38100700002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVaR2xBUUpBTzcyam5NY1NyQkJ5VlpsMGUxOFE5REFuYmo1WUhNNVA5ZDV3?=
 =?utf-8?B?ajRHZ0o5azl2MUNjeFVjZzk2ZGlIOGt2MjNpU1BVeGtnVEhLbXBHQ0pCR3lI?=
 =?utf-8?B?RkExRTBMV0Z4NFpUeHJZdGxSQTlKT3NzSWRwdS9lWnJKKzFLVnJVdGJUZkVj?=
 =?utf-8?B?QVVOZ05jL1RwSEhWSDl5ejBGQ1puZVJsK3VyOUNYdlRpWnptZEQwdnluTDFP?=
 =?utf-8?B?SWl1SVowQVlJL3AyN2dBOXkzcW5KWldZcjZ1ZnpEdXFRaGpPcEJWZktMOGZK?=
 =?utf-8?B?Qk51YTBJdkJkdDR1dWl3cXVVZ09JYjRzNjJSbHhtK2hpSU5HcVVRZVZpMnVM?=
 =?utf-8?B?TGVjaU44b24rOHNSZG9XZzdNN2JJVGRaVzB1N2FnNWZsUXpITXdJTUN5UUd6?=
 =?utf-8?B?VjlKQkplbWlqUkJGTm1KNWdFemJLMVRBVTdWWk50VDNDdTM0eFN4K3gzcm8w?=
 =?utf-8?B?bWcvVU84dDhWWWVjMTBMRk5aSEJQU2hUb3RwTTBoNlBjeUlFd1dsZDRqQTNJ?=
 =?utf-8?B?dGxHekhoNXpJWmNnMUZCT3N0Q1FzMU1LejdVZ2J3S0haZU91NlFIMGUyNzhC?=
 =?utf-8?B?L0s3RERjbjVFeE1LQzdNeUNxWVZHdk5HTGRQaDZGVDJmdXNGMmIxcFBlS0xm?=
 =?utf-8?B?dlpvN3BwYytoZHpmbnBHQmQ4T291Z0d5RGphYmtOMmcrWExibkZwaUhXVFFZ?=
 =?utf-8?B?aU00eU5oV0V5NkZRa21zQ3N3L0M2dVZjRWNjaVpjMXdnd09UbC9jT2tJZ3FW?=
 =?utf-8?B?VDkxUHRLT1k2ZzdzN0h2QW85MUhZOFVUMkZiYXlUdTNlc0VVZ3AxNFRld1M1?=
 =?utf-8?B?L0s2Um9vRDVyVXJaWno5cFRMSzMyN0NzWFp1SlRpajBweUNlSTh2VndlTFVB?=
 =?utf-8?B?VnlCeEFTeFFEV3VZR2xSRXZValdTZXpwVTBCdFZPYjB2REowMG95Q1dmYWxs?=
 =?utf-8?B?VjR1dXhyemo3OHhRZGN4clE2VDJOZzJ0eUZvSzFXZUFzRmZMcFRWbmtwbTBx?=
 =?utf-8?B?cHB0cmYwN1ZTVXFuNGl4T3dnK0kyRnJ3T21BSURKSDVtcFNoWVBUd1JFK3VM?=
 =?utf-8?B?bkwyUHlaVW9BWGYzZWlzMWtyQkt5WVdIdjA0QWRYTUtSSXArV3E2ZW5VT0Ri?=
 =?utf-8?B?VmthOURlVlR5d2NBemdrc01yUG5vaG51a291REdMSTJkMGQyRjNnSVJVVHFJ?=
 =?utf-8?B?ZHdudjlxVENDaW0xY1lYTWhnQzNQVnNQN1ZYS0FrYW94bWphdHpWcnF4cU9h?=
 =?utf-8?B?K3YyNjAvM2UrYm0yZ2RnbDVvYjJSbE5nZzFMZnd6bUF6U3FaWG9uSGJPYkww?=
 =?utf-8?B?ZUNFa1N2VWN2ZHludHdqUVYwK3hONzhZZnZqR1N6dDM2SW1vbi8xNEdCcEdK?=
 =?utf-8?B?aTJvU0pNaGswMkdtZ090TVEwVUUxVXFwNXJ5TGJnOHEyOWp0bTAvaVd6S3R5?=
 =?utf-8?B?YzY1bWpkaU5UMGNwaStPb2V0QVhLT3AzVkx5TGNPbGFBVHYzV3BMZk9GL2Nq?=
 =?utf-8?B?S1duUXRpY1FKZVhINWRWR09vMWNyUFA1d0VYYXVHdXRkOGxtR3pWbUs0RmdJ?=
 =?utf-8?B?TEJYc3lHTnZRSE1rYThGeWJDOUhSaUxkSjg2d2h2c20zNUlZZHlSV2d1UWFE?=
 =?utf-8?B?RzA3aWNQdzJGc21FeXZ2MEtYTm52alVRUFNZaHR3ZmxtaWs0ekl1WGQ3TnJq?=
 =?utf-8?B?bHgwNk1KOXNxZFQvMnhQMUNoZFF5eUgwTlhqWFhwQjhwMENkaFFLSDBwUDdI?=
 =?utf-8?B?a3ZhTEl1aVEwMHY1RkFBUVZEZVpuODkrSlVMVE5JN3FQUk9UMzZLZHV4bmdN?=
 =?utf-8?B?RThQNnBMeVA5SkVQM3kva0t6Y0lLZFlFV2RCcVEva1pUK0N0a3FtU2JBRy80?=
 =?utf-8?B?QWF2MjJFQzcwOXU2SEh3b0JvSUwvVHBBNk4zU0o1VWMzSE52SmFWd1NoSUJL?=
 =?utf-8?B?REtIYWx0QjRYSW9qWTE3RXRoREMwaUdNN25MRlhOSnpiZGtQZ1hWMVliMlZF?=
 =?utf-8?B?bTFEbUJ4eG95cUh5Nm9wc05TR09qK0owYXVCQzd6QTlnNWRocGVWa1JaVEVX?=
 =?utf-8?B?T2VRaEpId2w1cGRVdlFCeHp3RlBhTkx6cUpQOXBWNXU1NFFPY2FHR3RMM3Rk?=
 =?utf-8?Q?GX5LidakgcJ2gq4iSN03Yummh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e377cc3-7dc0-4719-ba99-08db2179eabf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 15:12:51.8281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rF3sDDErySyE/nxA0VNrG5tFOXDtF/wT71MnqoPV6Dl1VyCHOm1y4uSpYd1ZrrVlz7zbGOjyyD7pCRtC9Mr3OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Melissa Wen <mwen@igalia.com>,
 Xaver Hugl <xaver.hugl@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 3/9/23 13:18, Rodrigo Siqueira wrote:
> Since DC version 3.2.226, DC started to use a new internal commit
> sequence that better deals with hardware limitations. Usually, DC adopts
> split pipe dynamics to improve the display bandwidth and, in some cases,
> to save power. This commit sets MPC_SPLIT_DYNAMIC for DCN301, improving
> the bandwidth and fixing the cursor bug on KDE when it tries hardware
> rotation.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2247
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Xaver Hugl <xaver.hugl@gmail.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index b93b4498dba4..5ac2a272c380 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -687,7 +687,7 @@ static const struct dc_debug_options debug_defaults_drv = {
>   	.disable_clock_gate = true,
>   	.disable_pplib_clock_request = true,
>   	.disable_pplib_wm_range = true,
> -	.pipe_split_policy = MPC_SPLIT_AVOID,
> +	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
>   	.force_single_disp_pipe_split = false,
>   	.disable_dcc = DCC_ENABLE,
>   	.vsr_support = true,

-- 
Hamza

