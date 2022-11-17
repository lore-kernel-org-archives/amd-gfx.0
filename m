Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C39DC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 10:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90DDC10E05D;
	Thu, 17 Nov 2022 10:25:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282B710E05D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 10:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iczmhL/PJQXQzGuCgI2ZDD74LYOqOe+aUsn9hltXG/PZU9oCYQR5Oc/JbVHiNDCp+/X+b1AL5Ll7XlAO6PFyeOkZcTmyGV5LkbY9GmXleRc1GlZCjwDHMdhM99PSSAJf7SREJuGcHzlAPJSXz3ifPSI2ZBLPqusMcv7LZPRORYOdqzXM8Cde0NSBFmPDik3xfFlp2UNpf64Dbg0o8UI9+9g+iC1heKBB+lAcxLBXdkbM6uN0GUmeE/A54qGKswRGsOFo85CpNrsTEiF3C/0HECy/0uQ4FeHDCrV0s43L4sziHjvYc5t+WO/tXO7XzCcE/Ya7dmjTLFQpfMtqm0brFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ughz0ZBnBCXc/lAC5xp8tAPoiJ/rH2UOL/VRO4cPZsk=;
 b=K4pYPvaZoV1xUcfVZLlq8jPLYYwMf3H/3CvKLbBqgW+8X2A90pad8rmZoT21ds5eQPxNc+RdpefK3sZ6cW465eu8yZBUbrW+EzZY4sLDfLtsTqS0ET02U26a43zSZDqUIZkGnJrDAEwQld58O1sd5ywY5M7Ld5+NbeIb/OqGqbao66MkSB1eQ6SZwTnT3jQQexXFG9dq4A4zqIIDA6oThJaDphM0eRkCN0FNkjM8Bo9o+K84D3Dc3DNl59DUDJcENzP6yGpPfmXZypBbcvyRibN/TI2nj1uZbbCZ0yqygYRm9ZWvO4yfWqQnpGZB5azVPdF34cw7RsPvSmcYW/Fucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ughz0ZBnBCXc/lAC5xp8tAPoiJ/rH2UOL/VRO4cPZsk=;
 b=Pz3MaMswrm0SAK6lbZcyMG17zzOlaIUkbLjF14Mqi3xcOGARoEIy544u3XcCmk1X/VsnMA8NEZtd59KXLq2qNEcFilGSZ6q2pYWIeyCBZohauF96SO9BH/aa43dKw9J3xUEBzNOwOKgOWUA/BimS00OdHq9ZoPn6mwa4/HJ9y38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 10:25:50 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 10:25:49 +0000
Message-ID: <dbdf8cef-f075-80cc-90e6-a38b61f179eb@amd.com>
Date: Thu, 17 Nov 2022 11:25:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amd/amdgpu: reserve vm invalidation engine for
 firmware
Content-Language: en-US
To: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com, Xinhui.Pan@amd.com,
 Graham.Sider@amd.com
References: <20221117091119.106597-1-Jack.Xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221117091119.106597-1-Jack.Xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aba6906-16da-4cb5-f707-08dac88618f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2mqX0neIvaDCgz4ekfga7UFLSCasTCBR1ItwdDJxvbbtt3w1Pz8EEfaQ8DjJLEulPiQchS7as0DdY5EIrTndIAZfG6ybu+BSx54sCUPh+xDmRM1Y999QdNeNXgiBVvI9/KOmzWN/52bE90u2+MPwatr4YmTwY0hNxbLhNDI8aqADsokfjw176U+LrX8K6iH5PTKi//RqbgQdzulto0tF9ExujBjQXsmlLdZuz2XPckkJcH8a/8reWi6J3fFjRh/EcV2zwdILEc0vbGa9I0r1DIbOIg17uw1SN4ATma02oTlySpJWY49Bg6vwNyZYJtMgQhsZNgqRcT//XJM0JFlKZaw838I5GSfZm5qpzQrFtIk9lbZDsDmLv2LdJoHgrEcy8B+TNz9qc9o5XpTV1+u+Pedqxh7Bm/ctm4/nhQubsdsFlWOX858MKIN0qq04HpjUVx3/H+azJxq15tblt4jerUHwtV4orbpgTH8/M9HLNhgMCDlVlgPlRPn1IpGOx/ZhoME+4tOcO4EKWdZ0+9HyhPMq4bEzK2aaBPM8N/4ZnfE6UcmVaUJWLhfzXNg5zT+dpFyYkrjrHyM136WqcafR6orRuD6CooIYuTWxIp6EWnw20JanJoOwOCv5dhSmGBAStWm6FGkYGJsXK1FRe3u2OlJBrbnpJ16ONHwW9ypjUoYgd6O1CMk8LI/a8Tn5Ws3SMLghOLj5/IHBE2HdPfn/kGmB49ps9dwrlsZ/krOmvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(86362001)(31696002)(38100700002)(8936002)(4744005)(2906002)(66946007)(66556008)(66476007)(8676002)(41300700001)(5660300002)(6666004)(6512007)(6506007)(26005)(2616005)(186003)(6636002)(316002)(478600001)(6486002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGtsaDBvQkRON2Nya2t0NWx5VzRhSEYzMkk0QnRjR3VDUnoyMWVDT0g3TzN4?=
 =?utf-8?B?Z2VsbFVNWU1jUnFsTkt1bms5aFVzYnJsdkJORHJDRUQ5cWp6bTI0V0RDaXRt?=
 =?utf-8?B?eHEyUnFIQ1BZNk1pWUVBa240T2d1MkdkSHdYR0dOdnNqMjI0VnV2aG5mQkxo?=
 =?utf-8?B?K1EzbWNvUW82WllKa0JBQVEwL1F1QTVoM2RXSmpmdUVrek1wMUJnNE4xWlMr?=
 =?utf-8?B?cGs0dU82YUJqWkoxVG82Z2VGSDlDZ3pmYjkrMnJ0TWtlci9JdEE5KytSU1Jx?=
 =?utf-8?B?YUJoVFlwcTk5ZGlibkJzV0dhdWhqU2JkWWNPaS9VTnh5V1Fja1U1TWc2aDdT?=
 =?utf-8?B?NFI0ZzNWNGhqVm1jOEVtcmZaV1VvcDVzYWZvWlloZnppNmsxeUdDTmx1aGZm?=
 =?utf-8?B?a0t6N1dleGNGYmp6dTB5Ukc2MUxXNHZkcTlRMkZuR1pmOEUvTk9qVlNCY2t5?=
 =?utf-8?B?emdoVjFHSnhodHhDcWhGYmlxVy9CSkRIc2ZXYWxCUXVYZnVpUnVPRzViTVEz?=
 =?utf-8?B?MnpyaEpXRGdOdUZ6Z2RpZWFQSlNySGRDanRFd2phUzdhNkVodzJVQWtZVTgz?=
 =?utf-8?B?QUV6SkxlNis3YnIyMnhkRjc1QlF2MFlZUUtnRnEwdHJhbTNXY1RSOTl2TDlz?=
 =?utf-8?B?N1FLQnJsNG5YNk1tZzg5OE1PSWFzS0gxWk5qSTR1UFpDRmszUTVDRzU5ekdO?=
 =?utf-8?B?R1NmZXRMaDJWdUlraDM2ZUlsTm5vQ2dvbVlPTXViWkU3MERWSThFNWtmd1My?=
 =?utf-8?B?YzdKbi9BVVdhbmpScDFKQzRBckM1VDJxeVVtcDUvOHNjN05TM2xic1N1VGhS?=
 =?utf-8?B?UkFuVjRPdzBXMXhMa1RkNzVwb1d5V0gxRXdzb3kway9DRWI3T05YQW1abndT?=
 =?utf-8?B?eWVNNG5tWWJlVEMxU0o5bUhJV0s1Z25xMG5KYmxPNmVaTGNRcGtNUUFwNEll?=
 =?utf-8?B?NjgwTXBmRk0vVjRLeGVxeFJHN01WYVVyMFJrRExudy9zUk5xTzNUbHZhaFpw?=
 =?utf-8?B?Z0wveHEvajYydG83NDJCNGJIeFd2WU9jcC9IVTF0Q1RkNVZ1RTEyWWlCZ1Zl?=
 =?utf-8?B?SzlhSGtxalFYYjM0b1NIMG4rL1RwSWZ6ZU9qdXUwem5hSmEzbnBpa21LWHZK?=
 =?utf-8?B?eWFZcHk3cElmTlR3dDJuakk4OVdGRU85MThTR3NuVUtFYUJRU1hXamVGZXUx?=
 =?utf-8?B?NjdXQUZGSS9zWkRRdmNMK1AvdFI4Z3FaSDlmY01qNWpyUmVkMjZXVGhhN25B?=
 =?utf-8?B?VEhlb2F4Wm81WDVqN3NtNlN5ZEZSWWVmcUF5SWhINitucytaMU5udDV5dG5h?=
 =?utf-8?B?MHhTRHFPQU5YbnBoL2J4YlRid2VEbFY4Q1NkZGRvbDhhaXFJd09jTGR2bUNr?=
 =?utf-8?B?eFM1U1QwQ1c4U3Exc20yV3FWNWZUTitHZTFuNWNPUU9LUHZ2ckR4MlBvMGVx?=
 =?utf-8?B?YllOaXpUaXU1L0FDWjVQYVo0WEhQTTdvN1J2REtRREZqTkFWNU5qT2EzTjZa?=
 =?utf-8?B?Q2piUi9EQXBLQVlJTjgyM3Qzdll5NnhFWWg0M1FGcmRGRUhWS3JCc25ZTDNG?=
 =?utf-8?B?QThsVm5WWjI1eDkyYVBQbk9YeDBBQ0dDR3RoWHVJVk50US9YdlhDRUhCM0ll?=
 =?utf-8?B?c1pZU0lET3R3eFY4TGQwdWpwYjhIWTdkUkVhZEprVzVpUDAyV2Q4V05VQ1FP?=
 =?utf-8?B?TjZnTGdsUktIbWtWQ0pWdGZtUzRmc2c1Qk1odHBvbTYyOXcrYnVxL0NpcjBt?=
 =?utf-8?B?cHNvYU9VOEpULys3RHBaV29ENVRZUmhWeitqUURjRVk3dDh3OUVPRUVhSGZk?=
 =?utf-8?B?N2F4YlN3bU5Za2dhdGszNlVnZStZWE9EcGtWamxQSlhleWNmT29kZE9ib3Vm?=
 =?utf-8?B?UlZXUy9tV2VWWEtxRG81dFdYSG1QM09kWEhpMlc4NGNBQVFuV1hYNnkxWE9y?=
 =?utf-8?B?SlNXVmFMenpIdklkTy85QStvdkxMbFVtYzZTZ1FKNWo3NzJHcjd5RDBocXY5?=
 =?utf-8?B?UXFIN056TVcvUzJ3RWoyTWdlTVhkVEdldEtaQlRUMDNaVG5pNk1jUUFHK1FG?=
 =?utf-8?B?VUJiaWI2UXhKWEJ1VG9tUnFUYVlzdjFUNjB2QzlwYlJKbnNZTHVmL1N2SHEv?=
 =?utf-8?Q?Axk5VXQXRR0YX0JA/9ngckqpG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aba6906-16da-4cb5-f707-08dac88618f3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 10:25:49.8192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBJSncXbP5I7w6gXSJXk6+z+OQ/VeykJ77BHhn6JY5Cy2kgDfjgXhIUQtpR21sIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
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



Am 17.11.22 um 10:11 schrieb Jack Xiao:
> If mes enabled, reserve VM invalidation engine 5 for firmware.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 4365ede42855..e970e3760cec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -479,6 +479,12 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>   	unsigned i;
>   	unsigned vmhub, inv_eng;
>   
> +	if (adev->enable_mes) {
> +		/* reserve engine 5 for firmware */
> +		for (vmhub = 0; vmhub < AMDGPU_MAX_VMHUBS; vmhub++)
> +			vm_inv_engs[vmhub] &= ~(1 << 5);
> +	}
> +

Is that fixed and nailed down with the fw team? If yes the patch is rb 
by me.

Regards,
Christian.

>   	for (i = 0; i < adev->num_rings; ++i) {
>   		ring = adev->rings[i];
>   		vmhub = ring->funcs->vmhub;

