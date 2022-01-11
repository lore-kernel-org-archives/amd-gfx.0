Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D1DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 07:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15DCA10FC1A;
	Tue, 11 Jan 2022 07:00:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB0510FB3B
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 07:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odIlKkgUfx4gKMb+LibKCc7EPcfRRgJ9dRejO43cKVP2yVK0j8rqYjF7Hs9JZ51XltU1KI96qUmiWA5st7V/kep3eV6VT23tYyqdw6o5nfxE8o22I4BzQ1oEDpjXdMdLYm8hog3pWe/Godp55BAq09rac/6fl/SOe5073NUf+XdiAPZUn0DDPuzN7/vVRBgvAohVRxvddD74RtikWN7bnIzIdAtl36riqq+jZCpZj67Rm3pEHfZSxAjXmGjsxMh0EmpA1RXqaAuxqCVy2a0X2HMvTTzXP9Fve85MaA4KEMgvwRaj1n34WxyL40B6RqsedyWhOTls9TsLDWPnApxHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhUB+DnoR7KHh+R0ppkarwIMuFD0PiECbl2xMyp4rcE=;
 b=GlKKFi1pr2sECLfMRarjDKcK/rVpvF8tyh3X6AHXjs9zUnEhRG1+mZcoWQ3bn8/m6sOtdvzKas8pXGDo0MZpyp32dHH39/iv4ZT50M7zI6JGJ3VCS7EK8LHBNFkYLLfgGkJn/n/wYjecveHmsFMiLTsludUKpdjbRIN3vzH7gvzF/4b4ajWZ1N5NQ/SekhSIqBPvlwXZw3lGjq1zACUq8LpuDOFXVbbHekSW0aKRJ0DRRNbn5nmcqvSb4t4mnmSL30v02IzIIy3V3b3ZyGMKKWWjgkl04ing9i0gkzrKkYGob4w1NoaIlf7M1qBvrIaY91+EYKnWliuDh9Za9XCmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhUB+DnoR7KHh+R0ppkarwIMuFD0PiECbl2xMyp4rcE=;
 b=jts8dMdY8zzxxCnUX9sfG8y7g6JfrD/bTLtHyRkcCWVbUoaKfwN5edpfMpRGPwwmBd+6oOo9Ku48Wccrcz6sjmoEePmeAOGwusqxKLp+hOfudqvRwGO8hEFwPobPSE3of3RaSfuGmXbhXaOd0BD/GX0BnnkEva5qykHnAncdYgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB4632.namprd12.prod.outlook.com (2603:10b6:a03:110::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:00:16 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:00:16 +0000
Message-ID: <8172b93d-cde7-9c89-a81f-647466ce6891@amd.com>
Date: Tue, 11 Jan 2022 12:30:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: only send GmiPwrDnControl msg on master die
 (v2)
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, Evan.Quan@amd.com
References: <20220111063352.16123-1-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220111063352.16123-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::25) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 445fdcd4-c913-4e07-8160-08d9d4d00532
X-MS-TrafficTypeDiagnostic: BYAPR12MB4632:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB46329F3BC295CD9AE64E687997519@BYAPR12MB4632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRG9gzoNFBcmheFn1I3lWK7QIqyBBUHNg/bwrGqwNmDvJQfr3kU8+rTkYvStP5tXriGi6N9jTafjnEGVgXaMrhxiSfP/xofBIq9p8GUwM8pKscBbtmIrt9LePgYCNN7JUZUuBdBBvKBylVjQyftCM4RDmKsvKLYNAiklb/fJR1KKjl8kqdyG6qUms9TvbVwJVOMFlQvOqLFA+SevnnpuVYWK3EmKNubEMShtm+uftxZzuUuiKWleOOX7ZM3LEEBYUhZEaNA3mdiHfZ/dRWnDwbwOVo1oxXF2hINjjw5EwM3yh6qjbgYGyO7tmuonTn+3pJ0ZjvRi5xSQAgvJyPkGH9tb3WieNcnhlPORYKwmcKDGjO1UMl/VnoraVtnISHa6Q96dwM+UHck47i2D4F8IqMg7rxskgKpqubL6emRQ4KjwVespSc973cEKe49z/Vh9Rp9PTSP+nJ98ZmaJPthvPZoSwnrgEKuNCj5JfwRxM9mUy7QDS/pzwKLPbMdIy7KOaNEz3L5rygDdQRT0dMtOMK2a7138e6gMf7TSxZQlUoH/QGYP2qI4qzTRHIVUByuMPz/416D2vbpHBAyQFIIfz321u4DfQDwPnxwsuVgbBZvCWVcqhpKEciZiD1UUr43GFYa2YgU0gE8dn17vV4g7b9OP8eNKkNpxoNPYuNa0edyK4MvDda5BhoeH+eb1Zs5N3ozo67TPYbuHli2dgI6nVnRgaLK+kWGLtxEe6Lq5/6yx/f9QIwlE9x+0Qp1qgYqN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(6029001)(4636009)(366004)(316002)(36756003)(26005)(186003)(508600001)(2616005)(38100700002)(31686004)(31696002)(6506007)(6636002)(6486002)(2906002)(86362001)(8676002)(6512007)(6666004)(66556008)(66476007)(66946007)(83380400001)(5660300002)(8936002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVHUzRYdVJzTzY3T3BVaXNHYlUyV3JmNDBLVGlJOEY3VXlRR1JlcUpWMXlS?=
 =?utf-8?B?VExuQ3J1bVhrNzAzQU5SUmo5dVR4NFNISGV4SUIwek5LT2IrS1pxNEFRek1q?=
 =?utf-8?B?QnRmSTN2L0VPeDJtYjB5WW9JUUttVy9pcXJsRzRXMVozaFp0TEIvaUFmdm5I?=
 =?utf-8?B?d2pPcFkweEQrRmhSTmZHSkwybmJ4Q0IraDNKMFYvenFlc0JJM3MvR0R0OVZI?=
 =?utf-8?B?a2pRbm51Q291ajBxd2RuaGdWS3ZpS0tSMnhObnZ0cXl6QzJRTkhxOWVtUWZQ?=
 =?utf-8?B?SUJ5VVdhRjVJSnU0NjIrQkF4WVpySnhNcHJrcGhKS2lHdjlPQlJDbHBKN0FS?=
 =?utf-8?B?NGo1eXJmRUFMbVhpR0R0MXhwVThNemR5ellLTDhlVm5IREpNQkF3U1BlVmZC?=
 =?utf-8?B?ZXNnam5qSEFqby82dDN4YUR6ZS81QTRhWGw2Wm92TEdIaFlNcG9oY3BPT1BD?=
 =?utf-8?B?WE9hYXlvVVI0cVkrWUtaYlUzMjhVRTRoREJ2dTRkelVIdFoyWnJZZkZvRmJU?=
 =?utf-8?B?dHlIbm9JbU0remR1NGF3NG1iNFJnTTZaVmdXQlB3NlUxdXRYdjZkU2lVaFQ1?=
 =?utf-8?B?MXZ0NytMTXBsK2g0cTlYUXJNelNoSWlheFFOL0NJYnU1ZGs3TWlXUFVGZW4x?=
 =?utf-8?B?VnEzK0RQNzVYNnkwTVVrSUMyM1lyRUF0bFhwaGxmaGFHSDhnYjFKMnN6d0Ni?=
 =?utf-8?B?dDFvVVhnb3dWL0h0aXdyWDY0bXJrY0lmNFNjTEZXdUk2V1pEN0k4TXhQOVJu?=
 =?utf-8?B?VSs3cVlKTFFzTGRJeGV5aFplOWhKbGlsZEVvVS9odXg4bmtoelBIOHk0NjlD?=
 =?utf-8?B?bXlrNU5tVzYwaXpuQ0drOUE5bEhJcGVXQnVCVVRIbVhJbGFGWE5uMFV3QzhC?=
 =?utf-8?B?bmdpNzhFQ2xUdXpuWVpoLzkwMWtOVHh2bGlGRzVhSFd5RCtielV0bTFWYjh4?=
 =?utf-8?B?dU1TakMraGZIV1doNm1qMXBqVkhOR01DTjZTbWZoaURWck9XMFByNk5kR24y?=
 =?utf-8?B?V3ExbDZhMW5IVjlOaTdwTkxBR0ttU3luMmQwZXQyVlFwRHdneW1KVmFaY0pP?=
 =?utf-8?B?bjdQZ1FDMFgrRms1bjRpTGN1dGY0N2grNitoVlR4cnpvVDdaTlJGQkhNQTE1?=
 =?utf-8?B?VEpOYU5MVERtODdUNng5dE9EajRBSnJacVpYWjA1MTNmK3E3WGZRd3czTTFH?=
 =?utf-8?B?NWhXN0FZVUM0aWJrb29TUjFKSE1ieTB4UEtHZEczcFFyNXFGZXJ1Y09wYVBJ?=
 =?utf-8?B?TXVCdzMycTYwK2Nud2tpeXBzRkR2cnlBakJPSDJCVlJIdFdJTmRFeTBTc3Nt?=
 =?utf-8?B?SXJ3VWVoSzEyK2JEOWJUenJSOUJVUVovSFZrOGdCWUZ6NGhDc2VFcWlNdUdi?=
 =?utf-8?B?Q1FSTTU2NWlxNjZ3dWVnL09aL244a01pWHJOdzJGd0J5cTNRbG9ZUHFNMitk?=
 =?utf-8?B?TlVOQUFrelA1THNCUUdZTmY3QWc4UEVIOVBxeTlmNzR1dWRNK1VUbWdTUjN2?=
 =?utf-8?B?M1BHdEJieER1SEVONUtMNi84cFFZMitVZFhobDFlWDhkYW5kZmNBSFptRXhU?=
 =?utf-8?B?MEZqNXE2OXZrZm1OaVVETU9kb3VTVTc5ejFOTm0xbnZGck0xRmhWMjZFMmFi?=
 =?utf-8?B?WFZYTUY0Vnh6WDFVWUhwanRkaWNPUEgveWIrcS9KSFFBQ2d5ZWdLQWVJSms5?=
 =?utf-8?B?TlQvMlpqSHpFdlU2UjMyVVFsOEhZS095L1hsT2lzNTRBSElFdzNacHB0ZjVw?=
 =?utf-8?B?eHBkR0hQY0Y5QlRpZTVybW1YaSt0bEx6RnJMMHdITmhtVSt2aHB6dk1DaVRR?=
 =?utf-8?B?aU1GYklLR2szK2NoQUJlQTc0L3lQMHh5Z1paQ0RKK2NlRGZpUS91ZDlVeXYx?=
 =?utf-8?B?WDVnem5oSFp1MUlFL2hjODJBcWExQ0VDaVdjNmtWYjRsZ2FxckhBZnF0bkIw?=
 =?utf-8?B?NFlGYUo4dWwzaGZKQVJMWE5WTkloUmJEY0g5dzZqdWJXVmhjVEZwRTAzbjN6?=
 =?utf-8?B?Qy83K09kbnVMM3M4cFJnMkVoMUlZemJZbGhkb0JnTURpajB5eTZzSG05ZEdn?=
 =?utf-8?B?bGdBcXRINlNwNURKS0hvS1laZUQ1aWtTL241UnVwTHUvekJEcXBlU2tSc0hM?=
 =?utf-8?Q?Ctpg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445fdcd4-c913-4e07-8160-08d9d4d00532
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:00:16.0898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTRUTHZ77TBQ45FCkxXVOmbNWVrJNk3ZobWN52C4rlNmpd4o/Qrg69YIC70DxjYQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4632
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



On 1/11/2022 12:03 PM, Tao Zhou wrote:
> PMFW only returns 0 on master die and sends NACK back on other dies for
> the message.
> 
> v2: only send GmiPwrDnControl msg on master die instead of all
> dies.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 25 ++++++++++++++++---
>   1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 261892977654..3fe5c05ced77 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1625,10 +1625,27 @@ static int aldebaran_set_df_cstate(struct smu_context *smu,
>   
>   static int aldebaran_allow_xgmi_power_down(struct smu_context *smu, bool en)
>   {
> -	return smu_cmn_send_smc_msg_with_param(smu,
> -					       SMU_MSG_GmiPwrDnControl,
> -					       en ? 0 : 1,
> -					       NULL);
> +	struct amdgpu_device *adev = smu->adev;
> +
> +	/* The message only works on master die and NACK will be sent
> +	   back for other dies, only send it on master die */
> +	if (adev->smuio.funcs &&
> +	    adev->smuio.funcs->get_socket_id &&
> +	    adev->smuio.funcs->get_die_id) {
> +		if (!adev->smuio.funcs->get_socket_id(adev) &&
> +		    !adev->smuio.funcs->get_die_id(adev))
> +			return smu_cmn_send_smc_msg_with_param(smu,
> +					   SMU_MSG_GmiPwrDnControl,
> +					   en ? 0 : 1,
> +					   NULL);
> +		else
> +			return 0;
> +	}
> +	else

The else part can be dropped. We always expect smuio functions to be 
present in aldebaran.

Thanks,
Lijo

> +		return smu_cmn_send_smc_msg_with_param(smu,
> +					   SMU_MSG_GmiPwrDnControl,
> +					   en ? 0 : 1,
> +					   NULL);
>   }
>   
>   static const struct throttling_logging_label {
> 
