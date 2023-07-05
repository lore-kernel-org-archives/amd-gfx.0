Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E1BEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 06:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F192410E31F;
	Wed,  5 Jul 2023 06:11:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36DA110E31F
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 06:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1xANHg7vzxlyGYpu25tcDVnzghg5YCIRNLTJpHGV9wxVHDSGuG+Dt7uXQFulkR/kM8+zpR2J6hAS785GXdeHwc2cS2XVcjrvIRR8j2FKFdD/VL0nxk0PKDNIpacTLH8jb67e1BA0AU9ODaisobJjjsB6SA2TPIeuP9SvIPXqupndds+BgX64FEu9dIVYDzQzmO4tYfyiRqNNOJdG5tAHtlOPb+Iv3IYAKb+hyGkKcV84qq7UOA/VxOseECz4ALwAXo5ocyhnT/jqbeivr7/m9+No0cWQcg8BuYcCVduqQ3uPRW9d4vSxy77jrs4Ezk06/NwmMITHAxTbgQ2FLU9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dezthk+lAdUXw47ey92hk/XzYsG/ADKZ8b2dWRH03Z4=;
 b=MznbicWX/jUYJ5XlWI+8aJpluw/OYADDKw5ZeV5IczRNEQnj+hkjqI5Ojpl6EKbdt1jeIyMC0SgxzLIn4PdSjZF1nxqj7FOf/AHTdS+1TS87Ci+Qx2ReLZ5hiklAG0qqrCHlC/VTcvh5G9l08M5/yPfmVIaKm/iOKH1aF2pRBvyQIOyWNh8MMVgb49MXL8S7wBxl+toOb3ZCQhGGqu8pjqya6hsM9WivFVfRvK5XHBcd3BTV+CYiF7YNjbTD61ZIf9ljxBg0iwHmiJ/SpBFXhRlH5RpWnnPUIIbY8/SyqJuPEippb5Aifm0Oo0Io4Yd0RJ4XPLYKe6A9dM/Ub0b56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dezthk+lAdUXw47ey92hk/XzYsG/ADKZ8b2dWRH03Z4=;
 b=KUiJcSpnwna0KLCwzN59UbkbUnXGVGOIJ51xHc8odglr/+MsAWcPkpRhsAnfTVOUHRNNSaGCdt5EtruZxfDOgmGEks9WCoy6nfXIgaogV/9uV7MrrNaihb1IvtosNMMqDctQnm9hLAB+gHyUWAmLQE/Y1R5Dp3tpLp000IcqV4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:11:36 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6544.031; Wed, 5 Jul 2023
 06:11:35 +0000
Message-ID: <eb6979ae-7eba-b9f7-cecd-dfd6a581c790@amd.com>
Date: Wed, 5 Jul 2023 11:41:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amd/pm: disbale dcefclk device sysnode on GFX
 v9.4.3 chip
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230705060427.3698857-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230705060427.3698857-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0211.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::6) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 209ab3f3-a958-4db7-d3f3-08db7d1eafa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6FypA9Sw7LI3E28Y3sXVbwwY5cIxLqV1DTpUeqjHPUpFZOph5d2L3x6EL5uyANALSu+an7xPyJ2c82Ufa/FNw7xunmLGFFW+rglSktOGfebsBzS7A2qTOjJrK4PHIiOyCVbZR0PsQOmC8gXXzj35rnPa+J1NzJrAjClJI769gQjApF4O2lxLCaCjQPoZEne5z+zfvLK4NDC/gNvp54zG/TeY+Ccop2NT6fFW6KV3Y7p7SJlpX8idB+BiRfUHb3CTfsR0okQXLPv7229sX40bqPz6gr2b1TDfu35zaK+9k5ojZN0qWTN1vuaqbCFNpobY8RWiQ4wZOjYPP+exiVzaQYRcuSfdNHst3lnlJGsxpMsq+yHNcimDd8v3wc/rYveUMCFzng/YPIw/7NhYad1tnmLDC+8HAguLbz27WkZMYDT4inTcVdV0npcTxECTKI5lWI5k/iWoL/PjiL6X5y8nFMSfN+GtHGcDpna/AOnmj1KBY33QaGn27RmEL3nkQykh+fiwdYIWXjVLj6yzTH1vujdQbhuqNiX7Gs8vZz4En2eRBsy/fp2YO4dwZs8J04TbWfWCRqF2qjCiw100V6/NUNRyYWwuKjb5uG2LbaSg14HXzZqGT86CBZ3XJYnz0epU/J1FGTZxKR4a3Vt28P8CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(4326008)(31686004)(316002)(86362001)(186003)(66556008)(66946007)(6512007)(26005)(66476007)(6506007)(53546011)(83380400001)(2616005)(31696002)(2906002)(6486002)(38100700002)(6666004)(5660300002)(478600001)(8676002)(8936002)(41300700001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUF0YzVxTS9EZUFOcHFCZytZYWljYm1neXhXSVkwU0lGZnZHeldYWDUwalQ4?=
 =?utf-8?B?ZmdSTWlVb0JSSGMzTnNCekVYQklkWmU1Q1hadWdLL1NVSkpHaU5sblZrdnRR?=
 =?utf-8?B?bTVZZWRWR2drQkV3NHk3WGVNaGVhMDZscEpibmNBRFd4NGdTdzBxUEpnVHI3?=
 =?utf-8?B?S1RlS2N4M0xYcDVhYWFLTWhISGx2ZDhzRTljN3h2V1FWVTd6TThuampLWGpF?=
 =?utf-8?B?U2p2M0Q5ZFN6Nm1FOHhoQlBEUzRFc2N4VVB3MzJUMHRtZTVTaklJWTBEYnpP?=
 =?utf-8?B?TkZ0VkJsY3RrUFN3U3VYUU5ETVJPNmpNVjFUYklrcy9sWUU0YThwVTRqbDdR?=
 =?utf-8?B?d2EvbFQ2MFFlZWxJWTNUV0dDcFNDZ2FuQzNaQmlOZWxVczNjVHJoVEx0U25v?=
 =?utf-8?B?S2k1Qk0zaUVXT3c0MVJvTS96VWd5RzAxWjRJa2Z5bTBIN2VUNEdDWUVrTmg3?=
 =?utf-8?B?emYyU01qRWYzSlNudkR6UWdOYzNZZmRNczE0WktUNkVTbE1NTmtCK0xTcjJk?=
 =?utf-8?B?V2F5NzBDMkt2c3MzdVI3Y1lLZVlWRHREMnhnenFxWHJkTXVNNEMzb1B6Q3dm?=
 =?utf-8?B?S0p4RThzY0tuUHBqVlorMTIyUzNkeHZESnNuQmlYWlFLK2ZWck12UmozOFNM?=
 =?utf-8?B?MzNVR0VZT2RGNlZsQTUrbjZheW5mdnQwbzRFdkZON2hwd1hTRm9zOHd1MDV0?=
 =?utf-8?B?aXlURFcrVHVEV01YZ2s4TFhyWmFPaWRoL28xUWk4TUtPK2o4YXQzbFVWRENn?=
 =?utf-8?B?VWlzRC8xY1IrTU96bmY0SjVpOWs3RWRyZ1d5d0FzaHhYMml0dkRaWXRvQ0ZT?=
 =?utf-8?B?TElmMUNYd3kwQjhiV0R6cGhxS2hUTC9JTDVDZWJ0RFJrbEt3bUF2SVUyNkZk?=
 =?utf-8?B?Vk1ZYXdjQVd4ZFUrc056RjRQaEpBSDUrc01tV0JVaWVxdHhCOVVNM04rTmZS?=
 =?utf-8?B?OFhUcXRkUis5QitHWTdpS3BPODFHVzl0Y2oybGFUVlY5MWhTOXpqSkRleVFM?=
 =?utf-8?B?djQ2ZTExUUNpY25HTFV5VDQwbG56UEMvZVpzdUVqcjJIQUpZM3ZxZGowc2dv?=
 =?utf-8?B?ays4WksxR3ZvbktlYXBGYmRLbGZtdHRnREU3NjRONlFBc2pQZEdPMEpHRExj?=
 =?utf-8?B?bDlDMWg2NXdvb3g1KzE0Nnp6MFF6T0NhckI1OUNOZDlVcmRoSWdXbVBFVzV3?=
 =?utf-8?B?VjFRVS82Y2t4Vmw1eFAvcWo3U0JWbXg0cWsxU1dJcDFneG5wN2pZUHhzRWhh?=
 =?utf-8?B?QlFaSkIxc1doQlp4bEVQYXczbk5RdEtBTksrdlN5eTZVMU9DUytPZjRzbXh5?=
 =?utf-8?B?RnJ6ZDdyUHNiaDZzbThXQllwMm1pYUNIOXcwaGp5TTlUeXBFRGRrSVEvSlhI?=
 =?utf-8?B?ZXZLcXVIT3NaajJSOFBkazIrWitCWEpYNFFna3NUQlN1OVhmTlBDQ0J6Ni9z?=
 =?utf-8?B?NFFCYWJyakhIcElFd3llSkV0RVJnSkw3dGtMK1N4bDliTVVIVkk3Z3YyRFJN?=
 =?utf-8?B?djVIbXJ6cWtUY0tFYnFNd1lMaFZZeTJ0cXhnSTdHbXlma3JlNVhIY2wzektV?=
 =?utf-8?B?RnJ2MEt6NnpaY1Y0RTlpUjh6Uk8vYWZ1QUUzRGdEemlhWktlNXZON0FGK3lp?=
 =?utf-8?B?ZkJ4WG9adWgzOG05b3BUbkorWHM4NlVFUWR6Q2dUVXdtS1dteUxtR1dSbWlU?=
 =?utf-8?B?OTBFV0lIc0hZZGUvbHk1WEQxS0Q0ZVJ0Z1NBVmNlekg3UUdSWEpHMGNwd1RP?=
 =?utf-8?B?VW9RTHMvZ0NjYWcxcUVhdGpEMzhuamx3MXA0WVluUXdia0FDRzVuL2svOUxG?=
 =?utf-8?B?SEpadDFqRTJXVWFkN01LOE5BZ0hkNERjUnB5VDRxN3BYQjJFeFNwS09Ec0pR?=
 =?utf-8?B?Z2YxZDdOd2FOb010d0lWaDAxSzkrSldaNStQU0I1eXlGS1ozeHlmZmFDc205?=
 =?utf-8?B?aGJsOVE4L3JGU3pERThNMkRMTnVGdmErM1ZXb2hGTU4xQi9mZnc4dkVVQXJp?=
 =?utf-8?B?d1BkdTNxK0RLb3Vla09wenA4YVBLamFuUHVsTnNLWEo2cHVtQUlLNGRCZWRs?=
 =?utf-8?B?VEc5bjhUdFNiTG40SUQ3ZzRuaDhvMnpOcWw0MGFyZ0ZUYjRNU1Q5bmU1eUM5?=
 =?utf-8?Q?SplQU0dymLQwCT3Z8viY+sLRi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209ab3f3-a958-4db7-d3f3-08db7d1eafa3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:11:35.8694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwIkx9TBwyOKEUA6zIO3JYYxMZbuMA9pn+G4bOzWVtDhjYcOmtmFbkk9M/mexA6I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/5/2023 11:34 AM, Yang Wang wrote:
> v1:
> the dceflck sysnode is not aviable on GFX v9.4.3 chip.
> 
> v2:
> simplify code logic using helper function: amdgpu_device_has_display_hardware().
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 9ef88a0b1b57..3922dd274f30 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2049,8 +2049,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>   		if (gc_ver < IP_VERSION(9, 0, 0) ||
> -		    gc_ver == IP_VERSION(9, 4, 1) ||
> -		    gc_ver == IP_VERSION(9, 4, 2))
> +		    !amdgpu_device_has_display_hardware(adev))
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>   		if (mp1_ver < IP_VERSION(10, 0, 0))
