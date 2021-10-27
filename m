Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82762C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 13:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4371A60D43
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 13:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4371A60D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D4E898C4;
	Wed, 27 Oct 2021 13:47:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49150898C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 13:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRJV+glcS1bRGvqGaVQz2LMjyRyTRMHhqYDfT2d7tVKn1HNWXyGJd9tcr1kBudgIs60JFDHuJypDLgxu3++/ng0pfV605MrPyaQocRDeqHlyWeG5DBCTejQhy5fWsijky9IJNUPHFV+C4QMIc/Z2f8jaGd+e1v5Ue6gimz4uW9FwBuH9MAeEIgJS8tsXSk2WrkwMDPutcThud49AFQaFH1tZCDnvSSoNMw5b522bOgIoCHa+pGYj3yFTRV9WzZyPKP7258mdEjuPxJUkvf/UIgqb06mW4dJO470MHhNslfV8riv1sM5PoA93Ya+0ftcldlIyrydL6cK60LGv4PqU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIZwo12vLIxO0DflpT+12lMgCME9mogJ119LIToO+84=;
 b=gxYFCbcHwEOKluKT5hL30EBwirrTqdusOU9yBAvtSZlZHl5Rrst19QF8TaKIJQgFnYMrSwuKk6jqe7O1Wv5pFU8YRCigqxYMkPmmY+4jYatHWBx4IBh6wgS/jn+7X8UjDwsBxEy7NUhh+zaDiPpekNsBoMqtA6PUpfhRCiqIkYRttVBfRjWEQpuDM6MG3v4dJFnKM+RFtod/0g/wE+L5LFX2H8QtcNWf22ClbYDoungA6L+EKXv7mbSOY9iWqMKfWxE4zQKEdKfeQFIVHUV2ha80g2sBVCHTReeGLH/JlYhFegWbPcf1P8IB3NaWbZqpIWySgo62kGriIufSwRXE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIZwo12vLIxO0DflpT+12lMgCME9mogJ119LIToO+84=;
 b=bPIXdGUFZ9E8vLeakm+dTHtJyHbsHqSdAOejeKRfX3mW4a30K/IKJXpv1O5EwtaczZ5Fr6PF1Us0Z4qIHIFZi6meq057y+9eC+V5orYYqGNFryZMFnbXlwREqHqVSEfntIh3oj7eWKpCl9bsvyBnXzsRe3Hv36YEzUXv93zDDLk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 13:47:49 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975%3]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 13:47:49 +0000
Message-ID: <c0744024-bd4c-3849-d218-053377c28b44@amd.com>
Date: Wed, 27 Oct 2021 09:47:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu: Fix even more out of bound writes from debugfs
Content-Language: en-US
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: tdwilliamsiv@gmail.com, alexdeucher@gmail.com,
 Patrik Jakobsson <pjakobsson@suse.de>
References: <20211027130312.28383-1-patrik.r.jakobsson@gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211027130312.28383-1-patrik.r.jakobsson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:405:75::46) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.37.32] (165.204.84.11) by
 BN6PR17CA0057.namprd17.prod.outlook.com (2603:10b6:405:75::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Wed, 27 Oct 2021 13:47:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d452f4fc-0d8e-429a-369d-08d999505d16
X-MS-TrafficTypeDiagnostic: CO6PR12MB5410:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54103A05CDDFAD6C26BF1B3A8C859@CO6PR12MB5410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E54naACwsaFNKpg3Ex1/Q71EBlBn68gU2ljqBH6QxxMwWpytp8/nYoet5JvpXsRjImVKCzh8+HDpdajqpcOJ8Yily4rI7b8Z+tdKZVMIk92avdCWy7i+I2Iu2PrwtO6RrPzExzyjx8R/GAGNpkHNXW/yIDFKAoQ7xCyoDDZkwqH6StVe3zZnIqcL7fd9ALWNJD2oz5vzrJvHyoPhhZuTV/J7q4Gg/JblgfMRwoyE7azgZ+vVVIpPsFEKbfqZpLiA0o+LOj5HoimTs4BWAyAZcnvWrQeNpCrQPWnxBzUWVBzbupweeI2JY73B48xgQ+bJ7WphrARiJJeGvvQZJ4MzPpFZxCffw++dguODmoPwUL6j7sXrqfjnVH9qKp8p6fMuy05K7S1SQEJz0xpW/MxnWNgW8uzrqMRP1prU/TP5TGr7Vr+wDhfOKNcnEmoF0qfH/roqMY20XD+vODDHjENHWpyk6BXPadP5SJFkPwdxLoyVKj4Ap1BGmf0Z5uUH59XxrkCXPdwV6+aNaxhSqmVHB2OlkAXHkrl6IFlwRHqt34GTwbvSYsUUsNllugur0Qas44ZvaV6Klf6j+DKFMr9BONuf+bi6Q7+FzvQd4xZ1YbBhL+dSR6LxvZZRrMSgLr4PJt4b7TJ2XGm9VTJ1EP/Cejs+PCu/Bnzi7IDIXAbGSWSEDqEt3P/eS0Gp5QZmWf0ybazlYUOgOF0607EdvrQ1vBOr/j+flVv+R4IqCzMviKyw8gv3Xqmpmucgw4cI66Ub/TNvlRXxw2SEPKraDtyJOhVX0S8JK4vrrlcKyx/2DmywloNP+aFSgpVmJXDu3f7cvGzmIliqL5XNRMI5nip9MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(966005)(53546011)(83380400001)(508600001)(6486002)(2906002)(4326008)(8676002)(8936002)(31696002)(5660300002)(4001150100001)(16576012)(31686004)(66556008)(316002)(66476007)(186003)(66946007)(36756003)(38100700002)(6666004)(956004)(26005)(86362001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFBiREZhYVpoZzJzb2IzU05qV0tKTm9vOFFsREpzaUpLNVF4MXhLUWQ2V29u?=
 =?utf-8?B?dGJJdVl0WTVjSDBucXRra3pDU2VXREFyK0xNV3Uzb3Z3VTRsZnRUeURhU0RQ?=
 =?utf-8?B?TVZwaFZsMXVpSkhCcWFhMVFaUTNmYzVYMWJqbXdCdlc5eFI5d1ljVkVJNkk3?=
 =?utf-8?B?Mm5ESENzSHJLSWllTzhDZ1F1TlMyQ0FGUFljVFoyYzJqZG5HTExheTlwOXNG?=
 =?utf-8?B?aVR3SFRKamIwa3hweXArVGxhRTVnR2xFUEpTM0M0elhWbHJyOGRDUXV5M255?=
 =?utf-8?B?V0M3RnI4T1owZU1GUmJHSmFPQlRLdnJNcnFpNFZ5NkJ2aUZGaTdndmJvbWpN?=
 =?utf-8?B?VzRsU3VrOFRHRGJRT0x6Uk44WXlPZFl1a0tuME9jeXRISHVPc0hweEd0L2JZ?=
 =?utf-8?B?dW1zNkhTZWlJbzVaSXZaWU94VGc3anA3bzNya1BZdkdEcU5hSTU1czI2Y3dO?=
 =?utf-8?B?anU2ZUR5UGFpcWYrZlhGOXlmbUYycEdJZUlFR0xGSzR0dUFJbTNleGlaMnkr?=
 =?utf-8?B?bXNRczF5TVJCMXozanpSMm1OdENhd3ArVkpQOVluczVGUXNrL0JON25PcHd4?=
 =?utf-8?B?ZDV3eFM1TTdJOXovT01xaXVjVktBMnkzVjVubHZLVmlUQm9ITXJvSnlESXhm?=
 =?utf-8?B?VS9UanYxWkRqTnh5VlMzcTc1aUFhWUFwYU4xRzJJcWlTUWhTRWQ1aTErOFps?=
 =?utf-8?B?VjY3bVpmVXhVeloxa1R1UGZ3Q1lqeStucXRTNzR4VUM5WkRneXNzUW03c1Rk?=
 =?utf-8?B?TWVYejBmVTU5eDhCdXA1WjZOVU53bHpkaXlSb2Q0ME04dm15SVVyazFZSEJH?=
 =?utf-8?B?d1NaSlNUajVaV0dZMHhHczlGWXMxVFJlL1UrNzdJVDVmREZ5ZFpWRTRjWWI0?=
 =?utf-8?B?eUZsUFdlSEhWeXM4cjlRb3ROek1rbWRXWThXTTVtWkFoZjFaVXJUMjREUmRE?=
 =?utf-8?B?VXlabWw0ZXVsTjExS2hIc21CQTBOQVczT2p2SG9HWTNobUxGMHp5YldHclNR?=
 =?utf-8?B?bkZoTWp0eEVMaHcvMnBaRkxIenJqcXJLUmVESGFlTjNxaHdJZEdaUllTVlpN?=
 =?utf-8?B?TWJaMWd3Sy9jS2xQODhCdWpldW1McjZoL21IK2FIM1haZFFHWTRXcElBWEdz?=
 =?utf-8?B?QlF5Skxpbld2b0tXRjFGcG01V2dnbzRoZkxXdHlRaVJJSXd6aFEyS1FXcHJi?=
 =?utf-8?B?THhVUEFZZGZaYXo2OHdWSWk2YkNmeFRwenBwQU8vWmJJWHlxNE1mYms4UmFa?=
 =?utf-8?B?NEFRR3owUVVJNjFHY2pPM0EyblpWVHVuaXd5QVZyZHE4aTlMQ0g5bTZhZHhu?=
 =?utf-8?B?MGsrMWdyOGZuZElneWoxODdOeEFmS25pNmtxem1lYW9TcXF0cTQyWTJaZnps?=
 =?utf-8?B?QVBwenAvdWJSbTlwNURRWFYxUkZJakZjTGRvYVpVenpLbWN6U0tmWXNBLzBy?=
 =?utf-8?B?Mktaa1lsUjEyZHg0bW9FL3pCUk5pbkRCOWE3RWxWV0FlQm1NUURjZVZuWW1i?=
 =?utf-8?B?WFdxeXVNWkJUYk02RHZleTVlTmlXNGhTalRMcU1nc1lJZ1JaQzlxZkZYOWNX?=
 =?utf-8?B?cTl5M3pLTTRNb2dlQUZGWEIvMTRmdnhtNkJ2TEZVOUJZZFZ4QW1PZ3VZUjVa?=
 =?utf-8?B?QzZRcDlDS1dlbDFLVmx4WU93QU1zR1czYmJUdTMxNjBDUW9abmdrNlZ2eUlr?=
 =?utf-8?B?aU9RSGJjbzlFTGg1NUhvZDJzYU9JQVVIUGhVNVpjQWRkV1AxbElsNlEyb3pV?=
 =?utf-8?B?ckhUd2FZZzBYSlFuZ0dBNlBhTFJiT3c5UW1KeVlSVzB3NlFTQXg5V3IvYkVu?=
 =?utf-8?B?M3pyNmgxZkY3SCttNjU3RllsYjZVRU5KOU1SRkFRcHRIc3NqV21sRHRMT2xM?=
 =?utf-8?B?YlE4dFZ0RGVBL0RiVkR4UFRrTmxZaUtycmxreitMdEt1bDhkQUlyOFpOd0tq?=
 =?utf-8?B?RVFrbG8wUUQ3SDl1bWl5WjZNTDE2WUI0ekJpMlFWMmRHdUU1R3pNM2s1K1VL?=
 =?utf-8?B?QkJjODl2RzA5T0I1L3IzRWp5a1g0RGJjTkRVUENodXNuRHlVczI4a3ZlMkdP?=
 =?utf-8?B?dWVmZk1ZazJxSE5KT2ErdTB3eHB1YTFlOCtUYndLQm11NVIvaWpmTGdoMkJv?=
 =?utf-8?B?bitZSVZkellERTFweWZuSHMrRGM2TnptdnVtMlNHNTIxQVp4cDNHWFZMdDdS?=
 =?utf-8?Q?QxhcuXxY2NnxxEKksXxW5kw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d452f4fc-0d8e-429a-369d-08d999505d16
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 13:47:49.1071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5W1RmU0EJFTXamCi3TZSLDzvaj9LD3bXvZCZOTVdwDUifTXJYg+I+15cd4AMMOfTSQ42flZUq9METycWqaHzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
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



On 2021-10-27 09:03, Patrik Jakobsson wrote:
> CVE-2021-42327 was fixed by:
> 
> commit f23750b5b3d98653b31d4469592935ef6364ad67
> Author: Thelford Williams <tdwilliamsiv@gmail.com>
> Date:   Wed Oct 13 16:04:13 2021 -0400
> 
>     drm/amdgpu: fix out of bounds write
> 
> but amdgpu_dm_debugfs.c contains more of the same issue so fix the
> remaining ones.
> 
> Fixes: 918698d5c2b5 ("drm/amd/display: Return the number of bytes parsed than allocated")
> Signed-off-by: Patrik Jakobsson <pjakobsson@suse.de>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 1a68a674913c..33bdf15febc6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -491,7 +491,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
>  	if (!wr_buf)
>  		return -ENOSPC;
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					   (long *)param, buf,
>  					   max_param_num,
>  					   &param_nums)) {
> @@ -643,7 +643,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
>  	if (!wr_buf)
>  		return -ENOSPC;
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					   (long *)param, buf,
>  					   max_param_num,
>  					   &param_nums)) {
> @@ -918,7 +918,7 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					   &param, buf,
>  					   max_param_num,
>  					   &param_nums)) {
> @@ -1215,7 +1215,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  						(long *)param, buf,
>  						max_param_num,
>  						&param_nums)) {
> @@ -1400,7 +1400,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					    (long *)param, buf,
>  					    max_param_num,
>  					    &param_nums)) {
> @@ -1585,7 +1585,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					    (long *)param, buf,
>  					    max_param_num,
>  					    &param_nums)) {
> @@ -1770,7 +1770,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					    (long *)param, buf,
>  					    max_param_num,
>  					    &param_nums)) {
> @@ -1948,7 +1948,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
>  		return -ENOSPC;
>  	}
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					    (long *)param, buf,
>  					    max_param_num,
>  					    &param_nums)) {
> 


Thanks. This looks good but you seem to be missing another
instance of this in dp_max_bpc_write.

We'll also want to Linus's suggestion in [1] but I can post
another patch for that.

https://lkml.org/lkml/2021/10/26/993

Harry

