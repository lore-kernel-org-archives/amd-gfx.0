Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B7CC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 07:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F068510E33E;
	Tue,  9 May 2023 07:29:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2FA310E33E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 07:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVH9/kSg/RWXzzb+jeMxrEJYcWU1c/VcYc3yFZ7VbhaUHZRTkGCoBSaLlsOdque1QgnhDti2HkOHgKnb1yNoR10WUvqSzdU2r8HeIFpuJkXO2VPyGDGIlyQcIXP8vNXlfrqiaz39Yh9SdpFu8gaEHuGqs+boUZDJf/VaiLsULyucCFwRmRXfRSlBa9YDUyFIWfaxyzEULw1dgA1EyE9ifP8gHRsYcaBpLqwOdtLw80KB7AQMF0s0JKoSqXl3OnNq55KOusL+bjhSPp63WAZh38f0oCpfpZSDlbKkMb625MFgmXlNCUY4E3MqStRioe2TJfMLHgRbskOat5Tn7Gn/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rh2EdnmgNOpDc947HxMPjzQp+bTd3iQOJtIJljlnq+c=;
 b=WeVv0qvVdqNYeVRFlHoQcW3rJ+YsbzMJ1ZTsSehTL5c3Sm0s8p5X+uecitFPehLeRxpYadGxauvDTeM5PzoFiYnNb4zrDpW13Mt1TyGn/yH5LRNNY+gbM9dN5Q40eh5Oz3qI+aGWHg9BTBlcdttBxsj3TRJYodUy0yoYIijXEuU+7SvgcIob313KL+u4i6AAH63STztwm06ho54k3dOz+ghqB4fphj9L6jfNoWM53BNCwlYWCGqae9rguO+pteZnx8tiWh3/mtUBdK+tz/QbYBnyI6N+dDr1cgmuUVuW2hr0U9om8zBJ7Ejfug2VgupKRMKO80qBEj1nWulSOpabQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh2EdnmgNOpDc947HxMPjzQp+bTd3iQOJtIJljlnq+c=;
 b=Lo3krUpqdKixUcfmIJVa2+kp48ZWXc5byl4nhrQkHtrzs12m8h8+wOZcCVLHGyPX2JtKAlLARsI5RnM1CMdB+jF+HlebE+Cz88nISx5Bf69Yvf5lWMf+szFdm4Klo1+kZxcvSSXrCdC5pROhsdKhNNT8XHlVdHdeRuBFuixdntw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 07:29:36 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::45fa:3bba:fa09:720d]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::45fa:3bba:fa09:720d%3]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 07:29:36 +0000
Message-ID: <f26cecb7-737b-9236-8d10-4abf7749e757@amd.com>
Date: Tue, 9 May 2023 12:59:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com
References: <20230509052906.2142723-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230509052906.2142723-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 39427f6a-1f62-4fa5-2794-08db505f23bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QV2BMCgz/tRAKojNpwKmjBhe6iq5H9zToaL8jLBsiOEDmaxzxqbD2MlqiVlLF8NyvvCmqyuA73ZZlzqLhgkMQYzwHo0dqRL6IqI6DBmuLsmD30xGo7gUmwX/UNCuSiPXw6AePaH51kBfnbwZV8JeGZ2ChXZyPmIaNubixBFLmy6xnL3AFlb+Rwg1ZCV308vaPtxYq9qf95Om2fjOIFeQFxEH0CFEzoLmIKbHY/lRiSJJ/TCC5qIkwBeDFSryd3a38ZMqYs0p8GJdN+0tffsWSPMXocR5hze5akNLXGPMVnKVhk28lg5G7b233FGioFU052BqzBz5EIXZ0KZSg7+wQIWf9oGq1hPZbZZH+v/ef5ZruLBCgZf39xv38DgwwJIV90qCjRBeSz5khk/MgdJ5/M2DW26mt84FKHd5iehnLhR0OHbch+2SOCiKVcgMFeTZHw2Mbf5MOcOPc7TgRhjai8hZnEGoxtA/Qngk2GW+0ix++Ys6DNFisBwGmD49EVOjq5iQlfof1lPwYxJNnLJVV/xQOn+e91FhFpI8Fa9I2Rm4x2KWCGDVMyd4Z8ejyqOaOb+FCUbHHrVDdGKnMiBWFIN5eQV1PBE+IE8HR1wEkbLXCoRO1vlWW3BgfM+pQrM0KwdTLyupCqtmjE9nPZfpOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(38100700002)(6486002)(6666004)(5660300002)(8936002)(8676002)(478600001)(316002)(41300700001)(6636002)(36756003)(66556008)(66476007)(66946007)(186003)(31686004)(2616005)(2906002)(86362001)(31696002)(26005)(83380400001)(6506007)(6512007)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFJROSt2RVdlOG1DV1dTTDY3Z0pBRE11dUNuSFU0YUlYY2NVZ3JLM1hrY2VF?=
 =?utf-8?B?N2dzODgxSnVDVkRNTTJsWW9Xc09GdUpzUm1HWmhIZW95UFp2bGFDWUVQWVM5?=
 =?utf-8?B?c0JtZHV0MkY3dUt6TnlZQmRUOFFyRFd4SUFiQVNheTN2VFdZMWpkQk5kbUp1?=
 =?utf-8?B?VXlQK1JuSE9EbmM5MVYvRVlyU3VxYkU2dTF3YUh6WTV0cWNyZ25XWURHd2RH?=
 =?utf-8?B?Z0gyRVA5UUJEQmo0OFlBY09RNDgrSndZeDdvOXZGeEQxN2xpdlFPejY4ZUFM?=
 =?utf-8?B?eTBlQXd5RWpTd3pOWlJtcEtId3l4eG8wV3NnMm9ZSXg5SmxtWS9mQ2RPbVBL?=
 =?utf-8?B?Y1YxRmZVcVZPVVMwbXNTS21EaEh0QUF1TXJ3SC9wT0JQY0QrTXM4SGN3b3lp?=
 =?utf-8?B?Vzd6SEpVWEVUM0JwNVRVVEVPRlJ1ai9Td3MwZkFscmM3cjdTOU1xNTF0anhO?=
 =?utf-8?B?VGlBclQ1UlB2cXVGRTdhSGpUUGtNZnRybmJ4cEJnVFlDRk9pazBRbnorZGRy?=
 =?utf-8?B?b21VeWs5T01vN0szNkZCWjVjZVlTUUhTNnkxN3RsbkRGQUt4ZFIzZzVsb0t0?=
 =?utf-8?B?aHpNU05zeHBPcU5JVFlVdXhTZXRaLzVjcXJhNkViTW9MUFpYZ0tPRzRQbGll?=
 =?utf-8?B?ODdSNTlXRGpqZFYxbXVIbkV1SzNld2RocHZSQ09ocXFseklJeStObWdMYi9O?=
 =?utf-8?B?Wjl3RVlPNlpzSC9KL0VSR081WGtYN21xMmxOTm40UEg4ZU9ZUEYzOGM4MWlF?=
 =?utf-8?B?cjNiUzcwSGdoL1h3QWRqdi9XaEtGWDlNMFUyWDRIdmovVGdDVXFreWc3SUtR?=
 =?utf-8?B?Uk45MDdsTk1Bd1hWME9WK0dBajVhd1JZRUlvYnJ4ZGdZNlIwL3M3QitPTWFT?=
 =?utf-8?B?N0VMR0pFR0M1Yi9zbExZbHBOVmZvdjBBS2JhaGpCUE1WQ3Ywb0VES2JIL2s1?=
 =?utf-8?B?cXB1M0IwYyt4M3VXWW8yd3lLMndHREhMWklKUFJmdmEwMEgrWm5aU3YrQURj?=
 =?utf-8?B?WllpKzk5RER1aUgrSDJkMHNlYUpTYmdDVE05aVR1eUtPcUQ3Vm5XK0NEMG5y?=
 =?utf-8?B?ZnlpSkhMcm1jSkZ1dXFXc0FhejVReGpkYkJXMTBJTTViVlo5d2o1YlRadlho?=
 =?utf-8?B?dVZCZU9DYW9WOWlBNUwyOU5vQ0RLTUdzWU9ueTA5MzFCNGlybjJyMXJ1Qkho?=
 =?utf-8?B?bjdrWGFVaGJKWHcyWVM5WHYwWW5LbnRna2lXZ2FTS0tOT2ZVY1ozdFpPWDRr?=
 =?utf-8?B?bVN4MnR4dEdweHRGYTVXcm40ZVpJdkFncGhZbFkxZ3krdVdZTloxMUUwVVFO?=
 =?utf-8?B?b3ZGV2VkcVg2OHNwOFZORW5OVXo4OExvOVVWNlBYbnFEdjYzL2lZc2NBM2JH?=
 =?utf-8?B?V3ZJeFdhaVR2bVJIWHNmK3g1a3B4eXZwbEJyM1EvS3NjU1B5SjN4eXdMSmov?=
 =?utf-8?B?OTViWEFkRFlJeERSR3hvdFhWWWpZMUtnUTZMN3Q5eUFKQk1CcS9EcStyaUFS?=
 =?utf-8?B?d2xFdUc0Tk5SZVd4MUptVU15QUVLdFhmMnNkU2l4QlBpT0RWczFVbTgyTllW?=
 =?utf-8?B?S2FaNTZUNFlmMU1VeE96NjZVNXd4ODRLVVNsQWJtaXJ6NGc0Znp1d2ZIUHR4?=
 =?utf-8?B?UVNlQ1hWcUYya2Jwa3VZQjh2TVlvV29IOE15emEzSUxVUUw5TkUxenY3dVlB?=
 =?utf-8?B?aUhjQ0U5U0tLOE0rUlVKUnUzTUQrbXRrNGZkUkRFSWxXNkVxUXJGK3h5ZFFC?=
 =?utf-8?B?OEtLNFVJbHRrK1JFVFBWN25DaWVaZTdseDRQNnc1Snlqdnhmb3hZRytiTndN?=
 =?utf-8?B?RnRSMmEvTFZiZXREekl6ZFhwd1YzQThkcVpMY1p6U01KZ1ZLSnZ5bDJha1FX?=
 =?utf-8?B?Zk0yOEVlTG9mL3ZINWJwbjZOWEhBeXJtNnBSQWtFRDRvQW5wNUx0K0MvOXNt?=
 =?utf-8?B?ZTJET2pmMVZ3V0RiVjE5eWprZ1VTcEUrQUUxVmMyVzNPOFIvc3RuSWJlUlNv?=
 =?utf-8?B?VUhxam9iUUNJNkhQZXYyVlNIK2ZpejRpNE1HZitpSGtURGZiK2p6TXZVMU54?=
 =?utf-8?B?NGoyK0Z6dVMwSVkyWDQrZVRuYWZpbFJWY2RDQzlzdWxwT2FHaUl4a01CdFJl?=
 =?utf-8?Q?whDbaJavpLYe9oJ0cyLJbbT+p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39427f6a-1f62-4fa5-2794-08db505f23bd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 07:29:35.8611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD6JNRKYdkMvoEYwPSfGHuyWhoarurMAK8zSkd7yUZNUzGZCNXHBh8kebIJZCmt6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
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



On 5/9/2023 10:59 AM, Guchun Chen wrote:
> Prevent further dpm casting on legacy asics without od_enabled in
> amdgpu_dpm_is_overdrive_supported. This can avoid UBSAN complain
> in init sequence.
> 
> v2: add a macro to check legacy dpm instead of checking asic family/type
> 
> Suggested-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com> > ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 86246f69dbe1..4b28fd62ed7a 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -36,6 +36,8 @@
>   #define amdgpu_dpm_enable_bapm(adev, e) \
>   		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
>   
> +#define is_legacy_dpm(adev) ((adev)->powerplay.pp_handle == (adev))
> +

For consistent naming, you may use amdgpu_dpm_is_legacy_dpm().

Regardless,

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> @@ -1467,8 +1469,11 @@ int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>   	} else {
>   		struct pp_hwmgr *hwmgr;
>   
> -		/* SI asic does not carry od_enabled */
> -		if (adev->family == AMDGPU_FAMILY_SI)
> +		/*
> +		 * dpm on some legacy asics don't carry od_enabled member
> +		 * as its pp_handle is casted directly from adev.
> +		 */
> +		if (is_legacy_dpm(adev))
>   			return false;
>   
>   		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
