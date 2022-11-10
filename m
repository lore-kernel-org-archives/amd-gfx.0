Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3368C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 15:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1241610E848;
	Thu, 10 Nov 2022 15:05:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D7E10E848
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 15:05:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrhG+a+48a3MajBOm01kT8cwW0lykVW9Y0D6uJ9Z63pzz7vibkDsSxbbbR/Bo72X+Qt7eaNjxyUEprTZNGe6m9afKm52GRuWBvhyypVbGHLZpSGrwLGY0PL/bzWJKqWxc/P36kEY4PLxtCeP7k/QN9KxWV35LqpAjjRAI2MbqEk4k5d1k61dpcO7GUmPoIpVNy4Ji9Q0JkG0P6cnZ+8SgXABuu0SdgZ7NAn9R9ZxVPK826nuhWgEkUi+YrCuq/2jb+uFnYkEak6XuRxqAqmbKATBexrFCQzFEJsrBJ7z12Z7ehVDBZbK6gWevz9emUtlJNMwOZo9H68INSli1owRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AirOPns4nWOXKTsRjxMbG6GNhLwNilojrlEXf4ildZs=;
 b=hkmBOTjZzIOM7a0RuiOdse1S+5BBeLl6FfdS7VCa0nWCpO6mptkL/BD8v/14sFlCQz3q8lYlquVBC9yVkbgiVENXM/ZG/UA6LfO8luIqWsgBzgVY94cKK9KN/FODxHTGapAZyqcDPRqS9ySAtk3jD4dtrB+6GdDs430mwWmYj6lQwOuKWwJ/kWXPRSJsPwWZ+sDiq+XADjW4jguO3PqskXuXGJdjBcswRZEAvLAGSoPmRnpGymUSpaQkEdoXSayCkVd653iqAciuCEMxQK0sfivlp1PlVupaTzCPRyRT8aTTqFgHECksDX81jSTwbFA2xayDwGISrLTKRrzjSyJa/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AirOPns4nWOXKTsRjxMbG6GNhLwNilojrlEXf4ildZs=;
 b=otQPy4cX42NvvdmW8JfygI8w3EYyJ6S3svYAuXbdBjGhfZjM6qnbISDFBG2nPKWERCVkaOl9VO45a3SefDUGsshYloxewLI69jVj35nR+3cS7AWY/Q1OGBZLp1QC+tCU6W0FEbIVLMgspOzMkpBxxRHRNYMTM/C9SPfKMEH7wSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 15:05:10 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 15:05:10 +0000
Message-ID: <ee98c68d-7a86-abbe-aa58-447159092509@amd.com>
Date: Thu, 10 Nov 2022 10:05:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-CA
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221110084240.2949984-1-YuBiao.Wang@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Stop clearing kiq position during unload
In-Reply-To: <20221110084240.2949984-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0085.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::16) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b0fe73-b166-41ca-9366-08dac32cf5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tHKo/UW6Pe16a70FOua9hAN7pYPzBaier0lgvhouhP0OGq+xdhQlJwj+Y1a+8CO+kUFEzgt+MyaE+5YaUmxjHRjNu5VpIwGRhPKRaNAVsrTwQBYzKMKQX8oe/VipW/uN0WMgizzQE5HTEK62c5EaBKRDV6Yos4UqO/GSH/FIqnOYAf/8IVxK8VUE4GIrFRHoT3lmJC4MFo0GvgAUbq5xNM6f3gvLTbZTxIydFI9nVR376LTQRTy7l41zWv9jpbkkZxhijpa1vRoTX3XSZok+lVMuC6B8q5+s1MrmN0F2LDoV5LMr7A6WDq6oxRKtCQt1j4TovfyvR45ryLMxsT66TKljo77yvAyiT5VHf9oStqlAoblpshP+vcJ6E7zJRPa7N0F8WzP2rW7UGg4OIPI0tGufHZIHCnV9Mh2d5PWc7ZlZCmsObOiBLOK5yuR7bGt1FPVIk4oUTqDa9zbl1InBtjmeNwWUg1Cw4+6gcFDhaI5J3kdbu2vplOAn10prZb4TQtfGDEYxSSkMQ9d3p/o1kmLKyE5mmnmJHvgZJshwXmMFhON0KG2wscazRGSb+xxcitE68uo532xb/sucCpG5NW9wQFXRMnwJQ347/mN4ZIrNuNrDoDi/BCxvouP4JxA0lmSHcM+yACHtQL/gKea1SY0yLo8u1tDxB5Ea0wMWgjvFp5Q+UJe++hTOGjRxzSCaWwq+dY//X4OXllghuqrJ6L/oO1lLI+TkOGnAn3q7zA2aiCQrTBd5i+/MZuVCZvoy3vjA6AhQ+TK+NLjqgfaHOpQHeYxRQTjuiVWlsJxXfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199015)(38100700002)(31696002)(66946007)(66556008)(6666004)(8676002)(4326008)(66476007)(41300700001)(2616005)(5660300002)(86362001)(316002)(6486002)(478600001)(54906003)(186003)(83380400001)(8936002)(4001150100001)(2906002)(6506007)(44832011)(53546011)(6512007)(26005)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2pDblZ4U2xqdEtwaUxkZFd2UzJMZ0VIeDBSZ0JIQytjN0dyTkdpODhURldG?=
 =?utf-8?B?RzFXNWVRcFEyQXNzak5vUXJscGpMWG9TM293blQ4MW5wbXIvamhXNXhLdU9Q?=
 =?utf-8?B?T2Q3eGROZ3p6VHdGbGFEUWJ1bnVJdjF5QzhwcjVobmRRRVlOUlhOOUIrU04z?=
 =?utf-8?B?N1puVE9SSHcvSkVWRnUwOGtnMEhpN0Z6dyszME1PUjR6UGtLcUl3SmV5bEJ0?=
 =?utf-8?B?cUt2WldEYjVqYmtacnYzbXpYRkJrNmNFSjVIbzliTEc0dmhoSHVJZ0J2bW9r?=
 =?utf-8?B?YVk4NllZcmFJL0xITnR3U0NBMEZQK28wb1dhQmtKSUx3MlNhUkZYNW9Nb2RG?=
 =?utf-8?B?WDlCSjlxVkNLRGFYbXBlVjZtVjk4V3BpandQMzc3VDNhWHJZY1M5cFlnclFp?=
 =?utf-8?B?VkJUdTBZb1ZXZ01MR1dEQUFFWUZBWkhCdE9TajZwRHdFa2FwSUthVk1aclJQ?=
 =?utf-8?B?ZFgyYlUxQzdFSGRuM2V1ZVpUTGJtYnpFTWRtQkFpNTMvM1VrK0NFTUxnZ001?=
 =?utf-8?B?TTBSYUt5N3BoM3Y2SFBDSDUyR0RKd1gzTVY1eDRSVkc5aWk4RndabUhUY1Vn?=
 =?utf-8?B?NW1Wak05bjEwc2wxVUkvb1ZQcFBWcmF2T1AyRTFFbVFsQitPZGlRVnhqQ1VM?=
 =?utf-8?B?ZUpwaEpxSDZwVUdSKzBkaVJoQllJbkI0ZTJYZGZrUUdtOG5LRUNnSTgycDNG?=
 =?utf-8?B?ZkNKdVlPTmNzNGpyVlBzQVl2a3gyakdTMldSSGtiWC80WmpMQTZUQ0JEajBD?=
 =?utf-8?B?aXY5a3VYT2xMdDhCUkI5Qm9ueVhMNGpOZ1dhNWRjUGR1aXBRcmFzcnZlQytP?=
 =?utf-8?B?VE0ybE01Y2pWMTRteTdTeTgxR2g2S21iWWRqejA3WllRR3NUSTRSSG5jampO?=
 =?utf-8?B?TFM1WURxa0oyL2Z3UG9tSVd4U1VXM2xMSG4zLzc0bnNrMHF3U1dPY01kZ3gy?=
 =?utf-8?B?Q3E3OE9qU2JNL3o1N1RZd3cyOXVUTmNZc2tTakpXRTExODV6OGh6ZldKUm4y?=
 =?utf-8?B?UCtKUWFMVTk0djBRa05tWWZWMmhDN3RHZG5YdW5DQW5zWXpSTFZJN0JRdjJ5?=
 =?utf-8?B?U01oZUF4ZWNocUlqQXRlV1NyUXRDaVN1a2xyQ1JQMHlEWFowUm82L25uQlFR?=
 =?utf-8?B?eEI0UXlHeE1iUWY5OUZrOWtRSEU5YjBPYTYxV25lM3Q0eVpVS3ZYNWoyZmxo?=
 =?utf-8?B?QXU3dzFqNE0zUmdkOTA4OTlsZTY4Y0FEYUFZbllZZHBMZlJFRTVKZWI2U1Jk?=
 =?utf-8?B?MTd3ZXdaeE5zVE9ZZHExSWNtYUcxWTVGNkNkaTNYVzd6VlJ4MHBBbFp0dFYx?=
 =?utf-8?B?c2J2d3k4THhwbzJ3RWplZXVMTWpKdmFiWEd3N2kya0hsd3lETXNhUS9DUW9C?=
 =?utf-8?B?K0JFVTlkcWpDcWx2M0pHeWtQZmxoUWRGbmc4V1RUd2RjcGl2elB0SGppMW8r?=
 =?utf-8?B?QVRSVnFGdTNYYUcxTmFFWXhTWHYyZUlzODZxOUxQM1Z2YUZxMjRMd2dMRWVF?=
 =?utf-8?B?VlpTVnJLNklsa1hNcndvblV2cld5Q1RGL2ZyYW5CYXluVnFPQ1FqcG9mbDJP?=
 =?utf-8?B?ZmlKN0hOb2ttU0o4a2dvYnU0NFpBR0lpUzVQTXNFZmN4Y1Y4ZzNqVjdWa3pW?=
 =?utf-8?B?NFpYc2Z3TStNU3k3Mlh6Tkd5RXpSQW9vVG1IeXRDb1d3UHRIaTVuOXFGY1hu?=
 =?utf-8?B?T2xScGdLbEVNeTYxdVJiNTJBcDgvYUhoL0NkSHI2NUNBbW4rMFhURTFFSkdm?=
 =?utf-8?B?NjVobEROT2lnQXpibENxTkRHTVB2amxkTTJ3dG5ZNG5GK0lCVW1hSVZmbmk2?=
 =?utf-8?B?dlRINDFheTZiZlVmMEMrOGxMQ0I4VXdiTEYydlA4M2QydFNJZnFpdXBDdDRa?=
 =?utf-8?B?RzdyUDlYV2IvS2FZNVc1Smx0cG45L0lrTVIveVZSUzZTay9rcDdFSWJGVGta?=
 =?utf-8?B?RGpLYXZzQVl3a25SS1JJMHIwNmFibGZLNEFneGlpMDR4RUlpMVVKQ1NWbURo?=
 =?utf-8?B?RGZXY29pUEttV0RHUnVQMk1Ld2NVSkxZQzV5SXRoeU8rVHVuL09HNDI4VzJ1?=
 =?utf-8?B?UHNhSGZhTXZwckhvYm5vMDRTQjN3dUJwOG00SlZVR1ZXczBxT1hTRVd6RDF1?=
 =?utf-8?Q?scfXSU9fuvDBfTlie4XfpvFGk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b0fe73-b166-41ca-9366-08dac32cf5f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 15:05:10.6844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoqLyMdF3WSuG232GDljjGielu8F9qtq8+69Os/sXlIZCGrD/UFgstN+pwpjR8BG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-10 03:42, YuBiao Wang wrote:
> Do not clear kiq position in RLC_CP_SCHEDULER so that CP could perform
> IDLE-SAVE after VF fini. CPG also needs to be active in save command.
> 
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 14 ++++++--------
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c |  4 +++-
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 9447999a3a48..232ccd639184 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4411,15 +4411,13 @@ static int gfx_v11_0_hw_fini(void *handle)
>  		amdgpu_mes_kiq_hw_fini(adev);
>  	}
>  
> -	if (amdgpu_sriov_vf(adev)) {
> -		gfx_v11_0_cp_gfx_enable(adev, false);
> -		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
> -		tmp = RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
> -		tmp &= 0xffffff00;
> -		WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
> -
> +	if (amdgpu_sriov_vf(adev))
> +		/* Remove the steps disabling CPG and clearing KIQ position,
> +		 * so that CP could perform IDLE-SAVE during switch.
> +		 * Those steps were to avoid a DMAR error in gfx9 but it is not reproduced on gfx11.
> +		 */
>  		return 0;
> -	}

Wrap this comment to the 80-char limit. If you're using Emacs,
set the pointer (cursor) anywhere in the comment, then
the following key sequence, C-u 78 C-x f M-q, reformats the comment
to look like this:

		/* Remove the steps disabling CPG and clearing KIQ position,
		 * so that CP could perform IDLE-SAVE during switch. Those
		 * steps are necessary to avoid a DMAR error in gfx9 but it is
		 * not reproduced on gfx11.
		 */

From then on, you can just press M-q anywhere as often as you'd like
for format anything.

Also note the change from "Those steps were to avoid ..." to "Those steps
are necessary to avoid ...".

With that fixed, this patch is,

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> +
>  	gfx_v11_0_cp_enable(adev, false);
>  	gfx_v11_0_enable_gui_idle_interrupt(adev, false);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 7bfe862aa83e..02ad84a1526a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1248,7 +1248,9 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev)
>  	if (adev->mes.ring.sched.ready)
>  		mes_v11_0_kiq_dequeue_sched(adev);
>  
> -	mes_v11_0_enable(adev, false);
> +	if (!amdgpu_sriov_vf(adev))
> +		mes_v11_0_enable(adev, false);
> +
>  	return 0;
>  }
>  

