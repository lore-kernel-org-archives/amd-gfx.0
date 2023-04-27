Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768E0C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 11:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E578210E227;
	Thu, 27 Apr 2023 11:29:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9355210E227
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 11:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0KTZjlVh3CzaYWuCJMMwFU7zr16oTer6esc13lSZIz/N+i9WnHaDBqY88Mi6NEswUCNwpyvRuaWehxmofG0z3qldNcoHR5s/yj3zzH2YBKOv5VQw7cpkac+LL3prPJkEgjfKICP1QmqdgNCATaCMd0aXa4lBYF0NS4n1r7Mk2IXWZm+3XowJEvx1zQpsAR3yJhQEfob5o09EPSwu0MEEf6sOdxO4G5yOpiwuoao7be4yzwPowwDwLTcLKpbirIH4S5EdVO5LBdVJmhIuPSvMN4vBBscXkFvSuSB38+IvoTIXSVTweVlqdOVFkH8o++cg6c3FkfJAm7n+ZNk2JSMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFpdekougJ9gxA+8XnBtnc1PKEZNPYuo+gEqeZQDDEU=;
 b=I735KlM2SKHYo44P+nHaFqCorVTJfXYYVRqJ63/+YckqCMCxVNbbSiyNVEaERjC4gLi/95BsAVQtSnzzyZN1Fpqpx+PXi7UlvM68j/95UZRWASmQJqhfRTH75K/Ha8gKgPJ1Fr73HuEMlGGo15g760FpIx9dwR81j4h1wCjv39dkDRKCQiNHkzcjW9QBnT/p4uNf9rHyTGgtB4xgSDAI913SNMmJEY0pGvZ8m8VtUDbu7VEFoOgZ5ONgm6pugM2ey1Qcr7f8VsAmCh7kvgPnCuX0R9hQMJYOh3zrIAHZ3kioyS9wicpaHbYFzChczsfL4tA4/TLtVWB9cfdPr1bDeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFpdekougJ9gxA+8XnBtnc1PKEZNPYuo+gEqeZQDDEU=;
 b=TVPacYKwiPqwpPkkjVqUEFri5Qi3Rj76Jw0poQp/kDr+raalF8sHIqEFV9TpN826q32Wq0MijM9CC4V5SLIAvP1NTP9NNeq+xQTwo1Y73YjBMBWjeyDFM7UrlPDNDi6AZ9fC9Pb35ZSdMqyfX7/9IRCDg74cPXcGBx0s+O/qfLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 11:29:13 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 11:29:13 +0000
Message-ID: <982ffc0b-c30e-d2d1-97c3-899ffd95381c@amd.com>
Date: Thu, 27 Apr 2023 13:29:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 08/12] drm/amdgpu/gfx8: always restore kcq MQDs
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230426212143.7696-1-alexander.deucher@amd.com>
 <20230426212143.7696-8-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230426212143.7696-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: e8706e78-fcab-4665-f64a-08db4712a053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRKjxhfzczLl0uPsdawG+++hfwsJ18OqzehpJq38lkxcNI1a113WZupM/XKXnRxDYupaGrfe8kQ6b4dHKnX9LZXs9KTRwpOPCK1wVAoRqA7/IxGr1zEp612ShYOAg7O9dJrexO8yRD6EUxxbpTA28LbHM7Db2VgGJuO+0uEiAA9jMN7tEhBuZWbpsBtpEQxVG6SPvmla7tA+7LktiZ7kD5iBRJ33fvf2IVNHWMLHuB386b2URuMinBCVaH3gxc0ECUwr/Kr51xbwFwIufksfgRVeaUTVtHGfN0HPTreiKNhArBPpyHiAA97FzH+xHgnz8IsuZnKySWBfF19Se3RkSkmprr2SwMM6b5YwIBPsv+Ik5zSg1FqIgGJyq7vGPv4svpSHpiFOBOxGhZTvisYRF55LgE51n1M4cgRWpTGOZLRsoyCZz+tN/rGO5ohQWaSZ82uSeCSIltXH7VOsUlOmRGpRv90UCJkG/8tPeqXJQWTonQCy0EuP4gQVZ1Tf84Y0YjIiY4tfEwaWnUwxiaLbxiqZuaic8eeWlg/hvFrGrNEZu3LhEpgIUnMs6FRwjNXJCMEfVWGuSfbFMymrba/xRgg2SIXBG7Y2biNUA5R0vEspJYNKl8qzk+Omdf1tkcgdwkAS5fRJIET57afUPLM/Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(86362001)(41300700001)(26005)(6512007)(6506007)(2906002)(5660300002)(8676002)(8936002)(36756003)(31696002)(478600001)(83380400001)(38100700002)(186003)(6486002)(6666004)(31686004)(66476007)(66556008)(316002)(2616005)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnRmclh2UkpZM2psRGorR09GRFRmTiszeUZrM3oxTHBmaVhwWXcwV1JWVWg4?=
 =?utf-8?B?dnUyS1ViTUJzZ21TdnBCcmtCVWhUUUFXbmlnbStMMGErek9IN2k4NDhjczZ4?=
 =?utf-8?B?elJ6VCsyRGI2K3BGTDdHZytiZTlNRyttbGVTdmhmcVBZU2dSZ283UWZoNSsv?=
 =?utf-8?B?amdBeUtjY2VvdkZvNnRZczRoUHFleDgvSkhta0lobXk4VXBva09PcnVSeGo3?=
 =?utf-8?B?c1BXWXRVWCsrT1JzaVU5UjA2OHhwRDlUaFZPbHlvVndtalNYcGs5eW1wL2VX?=
 =?utf-8?B?K0IwSTlCREhhS2FlUmFzSVlVcG41UTkyUTZDR051bFZoSzh3OE14cFdIbEdz?=
 =?utf-8?B?NUhQbGZ6aDI5cGNUdHJMTERVSkRvMVZzVEJ4bG9kelo3SiswY0FLWmRFU0RV?=
 =?utf-8?B?SjhwTGVsL3drbXZTTG5PaHBMaSs2TVo1bEtsTlZMZmM5WS9UeExyTUxXMFFQ?=
 =?utf-8?B?M3F4a2dCdnRjbW1pOWd1aG5qek1FQnJaTW01Vmd3WGh0OVJUZXBEa0RLLzBI?=
 =?utf-8?B?QmwxZmpMTXdlN0FNSGYwa3laMXdwd0ZjUDdTNnZ5YWxNNldXM2YzZXpqTkFN?=
 =?utf-8?B?VXVFalhuZ3VrYUZXWTZjRTNxTjRGaFdJT2ttUU1FY0c5dnZTNVhHZG93cjZo?=
 =?utf-8?B?U25LN0ZaQ01wbDhzMU5SUUJlZld3RzV5OEVIS1VQK1NvNGFtNjlGaHRJKzd5?=
 =?utf-8?B?MDVjandaVjdjVXlJZHNZb0srUlQwZTZjbWxzbDNycm15alZxM0RsSGo0UFpL?=
 =?utf-8?B?S09hNmRQSVp0UUJWdk1DSEhhU1p5RU1IK0xRQjZFT3JiR1hoTWV5NmFDV2RZ?=
 =?utf-8?B?YitpdGlPdFphcUJKY1ZsZnVNaW9mblJidVZWZE5wZ3FMVERkN2xUSGllNnE1?=
 =?utf-8?B?UzBPbWtMSzVNeVlWTjhrei9zdzd0TzFDZTQ1ZktZeXJSS0VsN0dPcFlERm14?=
 =?utf-8?B?d3RSNEtaL1llTmZibU4xUFpsRXliNlVCMUUxaWJaOG1pMjFVUkloNi9YTGly?=
 =?utf-8?B?Zi9wRE9BdnlYQUMxRXNzek5HeXNOTmtRbElIODdybEVLM3BQVVg4WUVBeDd5?=
 =?utf-8?B?YzJWQlFybUM1VW96L3dmT0tJNmFVWEc1emhtakluZmZiUEZUTmNWMnZxUzlp?=
 =?utf-8?B?b2ZpVlBkV3hJMXdkM1Vrb2lZOTZod1BkRWlkVFIyQThpcVBUNi9SMFRMZzhN?=
 =?utf-8?B?R2ZWYXVwMElieHdBa3o5TEpLWVNQSWFidU1oVEFVVWUrUE5ZSlZhekdJK0gw?=
 =?utf-8?B?TWowWlkyNzJEQnA0VTcxOHVzVnJ2Z2hWVXR4UWdxR3FRaEtJSFZQUE1Memsw?=
 =?utf-8?B?aTN2Ym1TV1Eyemc4cFVBc01yakdZSlJYNzJYZ29tSnZSUFBkaWlEL3MzWWl3?=
 =?utf-8?B?cS90dURKWDZ3anJiVnFoWFdXOGhxTUdjRnVEMTRNdUs5c3ZYZERvSThBaUtj?=
 =?utf-8?B?UkR4bEQ1YWlCcVRGNjFzSWRqQlAzMXE2TTZSeGZRQ2NnQ0NKN3pZbnRZTVVB?=
 =?utf-8?B?MXRBaTA1c09wVURXNWRMRnJzUzNGSllEenhQTmdFQm11SSt4NGJmS0Fzdmo1?=
 =?utf-8?B?dHRCTU5aSCtwN0ZCV0xKbjFXcjE4L1hKaDJnUzNkZi9iTk1GNzhwT2YwR3o4?=
 =?utf-8?B?Titia1hEZjZ6aHY3T1Z6QjBmVGJSYkZtVVNudlpqcDc5N1Z6Yy94YStNNFRF?=
 =?utf-8?B?RWlWbkxoNDdaZFlrUU90Sjk5cjljVEFSQVdWSTd0amhlQUFoY2hYODZGczBy?=
 =?utf-8?B?THNQcGM0ZWtVTnU1ckRXWGRzb1BRdjFRSVRLNHNSalpzZkZ6dU81T3lDRkM3?=
 =?utf-8?B?SUpNY0paZTZ5aEd5UmZpVXBqbmxYTzJrMmRsMW16eDFnc1NwZmdVWlFhc0Va?=
 =?utf-8?B?dUp3RGJCMksrT25NUktISXIzMWVyZXgrTHZPTmRpWnpPL3VXOEMwQXRYL01o?=
 =?utf-8?B?ZmVYMzdMNlZ4Sk9OdVRqSzB5bU10dzE4NWo2WTlGRitaRDBWQ2tPMlAvRXh5?=
 =?utf-8?B?enFSOTdJQnQwWXl3TTBEbUNmRmNWZk5MN0FqVlNKU2lGUXlmY2czc0dQYnl0?=
 =?utf-8?B?cVoxNTZNeDduSGdVemxlWFBpSi9YandTb2RiOE9IcGVWR0NrdFVYOGpEaEp3?=
 =?utf-8?Q?dXaM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8706e78-fcab-4665-f64a-08db4712a053
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 11:29:13.0456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DodZFE/ZkFHdIvfqbRyEdPgYLQHbwWe+9SeSFUhz3pg5FhXvDpNg0I8bGYJcYrNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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



Am 26.04.23 um 23:21 schrieb Alex Deucher:
> Always restore the MQD not just when we do a reset.
> This allows us to move the MQD to VRAM if we want.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 5de44d7e92de..b1c6fc24f65c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4651,14 +4651,14 @@ static int gfx_v8_0_kcq_init_queue(struct amdgpu_ring *ring)
>   
>   		if (adev->gfx.mec.mqd_backup[mqd_idx])
>   			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct vi_mqd_allocation));
> -	} else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
> -		/* reset MQD to a clean status */
> +	} else {
> +		/* restore MQD to a clean status */
>   		if (adev->gfx.mec.mqd_backup[mqd_idx])
>   			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct vi_mqd_allocation));
> -		/* reset ring buffer */
> -		ring->wptr = 0;
> -		amdgpu_ring_clear_ring(ring);
> -	} else {
> +		if (amdgpu_in_reset(adev)) {
> +			/* reset ring buffer */
> +			ring->wptr = 0;
> +		}

I think this needs to be done on resume as well.

Essentially we want to always start from 0 or otherwise the whatever is 
in the ring will be executed first.

>   		amdgpu_ring_clear_ring(ring);

Which would explain why we need that here as well.

Christian.

>   	}
>   	return 0;

