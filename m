Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C181C43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C2AE10F470;
	Sat, 16 Jul 2022 14:35:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F93C10E0E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 15:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEUtl1/Vx9Xj0Ei8lcX2BJAQYwE/6rROuVpEmiz5YOmg9S7Yxy74albDfJB50JBbMr3ti4PDT2ZxBybRx3Oqr8OWUcUbZMA1se+P+uoXwrcXovCKIDEqIUUiUnOIkqV3XxhTs8UOLNLS2RR8txVIJh+CQcms5+ZXWTxsd4NgsDNb9wx6j/xxen2E3SjPh4ta8f/KOCYpPHneM/g224VIylFnih0uLjHoq3aI70neSMhN+i3T7lBeOiEgT9DNOe87LhHTOXNDssFxr5veyXvGNZSyC7i3jIScFiVtlqAgl6bgYzWS/tF6wHVEaKVeRCzHfOEid3nPWULkp45u6UN+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpdF5S7oo5Uo+4VNBf2z/gzPwwEhr6CqhCvZ2m0AXlo=;
 b=SHOcCbgUP45jFF3at3tnuMiCB5YKtLvoWk90mtmpyBU50aWvAu/Ls9g7Q652Bz8rpZ8Zub8WRiLVjQZY7n03X5qyHwUilw58GS4Wdp1Ti2ro2xc03eEhmFf8isOHo+/m6cgJvMjY5j9qOt0WP99ienE++iO84NirT+D/AhnVZj82IBEw0CC5erdR4dhxzqloXH2A672kKM8FnISoHBi+oBuVUSItN89wbXdNS5mvwAlfsnCJAVSzICT6EKPVgi2Up54IGBFAuY7PxnUU3Nm0/XYu65aj5mLwln0yqajeoycD/Isrmz28Lawcx3OgPnhmeest4NhLIyw7xLxRBOIZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpdF5S7oo5Uo+4VNBf2z/gzPwwEhr6CqhCvZ2m0AXlo=;
 b=qjG4oh9qkhU60fKvRrOfY24U4Db3vdYRVGprdRa2KlVY7GykHYOGUuoCI1/0M7MEsCcqkraH9EZZGsp12qc0faNYNsyhyPn6POw3hHs7kxuhxKN/dg6YjX4n9ef4cf4ekeePAm67zCYi1sWlz0qT0FeaktuiGnwM4T1A/h5SH7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY4PR12MB1415.namprd12.prod.outlook.com (2603:10b6:903:43::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 15:18:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.013; Fri, 15 Jul 2022
 15:18:21 +0000
Message-ID: <c06f6582-46aa-9abb-5094-f027cf01c1c6@amd.com>
Date: Fri, 15 Jul 2022 17:18:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Content-Language: en-US
To: Ruijing Dong <ruijing.dong@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220715144453.46786-1-ruijing.dong@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220715144453.46786-1-ruijing.dong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0045.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::22) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a00a7f58-c581-4902-10f5-08da667540fb
X-MS-TrafficTypeDiagnostic: CY4PR12MB1415:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjIx5GsEL90cycfGv7hesZVC7pJqtwL6C5b/6H8mg7vcrOUJG6K3xyUi2iJ+xv6HOJHCC+H4IdYf4mLm+jhKumiVANHfJx0ac4m3EBwxsZzhEE9cyPNettV99WZRxn7EB3GUsu4c8xqpNT24iUxjBPVPj7+PUinGKr47GTRreGaQH0JI/O1vOMy/1HTQui0HUDJKXUtzjSs+Fgyo/77e5gJsgJPNIAzX7GjD8r3RuDEWyK7//v08Kewjv7PxoVDOyS5/kfCrC3NJsgwhb1PHK/JoEhHlWp2QB0Zma9T5NNb0FflUv89mlqLOfIEGyVJxJAGZcp1hZ12hWSHWPF5kU3L4FH2e0b23lwVZ3KKnwgay/f9q1rcu7fylnij++tETub6EiyvjUphlEmEBgN8xtIWHrrx/MSKKPwZDuw/nNue5r61DVxUookbF7OWbV3CksJsz5q4rgFlV7r0Ny80IBlqsM8mflOgW/SVXNmwqdzA8orGm8aeA2/2hjQf/jIz038OzSp5IRBYSSTNl7+rJ8nqE/VwB0gLt9BtDn3Ujmo/gmOg3rcpi1d5s1zlLQoDECoiaVEOZJxnQu0t+DsK0+Zo3rUSNQBAyGQLeRmsxsN7YKQ4Y291od/7kityEYQfUt9QN+dHJ0z53DCjsH540pw0fScrLBZlA+1nQjhCLR+rvd3Bv0RiLENycOZRPY0kBpa40aANKdHrAoigau5hRWyw0ksmhmYTGXz5EajD1lggklwjYuGsKk4/s1O3vF8Wb5Ef0+zrvrNhbW/z20CIIr8aWfxF8qGkUKtZ2EJFAvXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(186003)(6512007)(966005)(6486002)(5660300002)(8936002)(83380400001)(2906002)(316002)(41300700001)(2616005)(86362001)(31686004)(66476007)(31696002)(66556008)(66946007)(36756003)(4326008)(8676002)(38100700002)(6506007)(478600001)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3NVMkI1LzdvbWl4WGQrWit6U1VtUWxpbkwwS2dOdVlmSmFsMzEzcUV4TDFa?=
 =?utf-8?B?QkZxR1FMSll4dUVXNHpQZ2t1dU5Tb0Rsbk0vTlJoc2xKRHpSWGJ4bjJqU0xV?=
 =?utf-8?B?MGVHVHlFTmR4MVBFem5pVnlCdms0Slhtbmk4Unh0RWI2N0pLeUg5V25vYTVR?=
 =?utf-8?B?LzZEeitMeVFaMW8ySGFORVBJUGlMSURGcE5hSXFQUHBKSE5ZQlg5ZHNMeWZl?=
 =?utf-8?B?S1FldjNsdFZZS2o3UjFxNytWdEdYM3lKait3WldRQlJud0dVTldOd0NiZ1lt?=
 =?utf-8?B?NGxlcXI4L3dWeDltaFMwTHgvUk51ZDRYUGJLWTd6Z1RXaVUzYURqa1RTczAw?=
 =?utf-8?B?ZW05NlRMLzkzbHUwQ2VOVzRCdTBlNlJPaTE1TC9seUZmSlZuRTJPRlRTU1JL?=
 =?utf-8?B?WWxmZ2xDSys2UkduNmdkSTNrUkhVblYrWmR3dnNZd3RoQy9QUTZLRDZoMUlm?=
 =?utf-8?B?R3g3WmN1a21BRmZJZCtOcDdmQWh0OWpuNGtVeUpsNktPMWNoN290TVE1TFBy?=
 =?utf-8?B?UURSOGNPR2tXeGlkUk9DK0lkek84NENwcFE0bHVUMHprS1BaQlVUTWlxaFRN?=
 =?utf-8?B?V0lTTVJMNlVnNTYwTVpoNkdzSndmS0lIYlFVbEliUndrZUhjQnpkWHdoN0Qx?=
 =?utf-8?B?d2QyeDFmMUpXamc3SEYxdGlJRGFPM1RNMjc2WVlVRUNCU2lJSDY2NEUzTGZY?=
 =?utf-8?B?bFZkcHNnUG5LVlVxOHhiVk5NUGdjU3hXT0REVzN1bWV6bC9UQy9lZEZQZmFu?=
 =?utf-8?B?YnVraTZBc2ZUZzdvWXk5aHFxQWUzb1dKUkdBVkJlUjZHSnYzOGFycFNzb3VE?=
 =?utf-8?B?Vjk3ZFpndHF0M2crTDhpMUgydElGcVA2SFhFTkVsOWdCckF3K2RvcEFJangz?=
 =?utf-8?B?R0FRSWJrT1V4QStQbkhNQXRiVzhpN2xnQ0hCSnBlY0ptZDloU2hOZVNtQ0JV?=
 =?utf-8?B?dWk0QmNMNDFNcmNtMUhyUDN2WkpCdUhnRmVLalQ1dnVadlMrMjRNNE9PZ2F2?=
 =?utf-8?B?OGdXaS9aSXYyankya3paY3NCa0JTdzAyZ004MElnRnZUVncyUnNvWUhXdzEw?=
 =?utf-8?B?VW0zdTlSMHpFdmZjaEU2N2dNcGNVa0dWSlVSUmFwak9HV011TzJVQUdicldD?=
 =?utf-8?B?dk1Bb1BON3BOWGN4RzdQNHJpbWEybVA2MkpRRHpJT3lqbHd5RkFNZDBNNE5H?=
 =?utf-8?B?Yit2SDFqbzdrSmtidHZ4dmZ2YWFValJWemprcm5SMTREQ2o5aWRVQTNwOG14?=
 =?utf-8?B?THU2cDRLY0x6NmkrVUN0dEdocHZheVRQNFFjTkkzUzdlU2dpTGZGSmF5WlZP?=
 =?utf-8?B?ZlVtVWVFMW1zdGRFK0ZudmNFZG0weW1oZ3lpeWgvRDBvOGxPWVU4T2pSY3JV?=
 =?utf-8?B?bW5EbGtWQmQ5eVV6MDdtdFp2VUtNUi9FQlZTZzNETGNiV1JxREZtd1B6dTJK?=
 =?utf-8?B?Yk9iR0F5NUcvMWtyZEIyN0RpTVVTbityVUpOTHg5RExsMFpncWZMczRFa2Jr?=
 =?utf-8?B?czEvN2JUTU03VjVsbUtHN0JvWTVEZkI5MUdETlUrLzIyY2FyOHg0RldJdkU0?=
 =?utf-8?B?YnhVaURMWS9mcEFiQ01KMnN3SWE0ZnNkZGp1Vk5SRW9LeUNnaHllMDFPUlZs?=
 =?utf-8?B?MEF6TVg0L0txVW4raGVBZjdrbXRNdit0UXBFeEFkL0Z0eVRIMlRGYThpaUc5?=
 =?utf-8?B?dko0aFQwcGRhRDlnLzhhT1pzeElTcmtjbVAwdXBMamJBSzZFTDdROVZEZUFB?=
 =?utf-8?B?REZPdGdPNGFjWTF6ZDhXcHduckFGaHdGOGlSbFRWb0tZRDdiZzFoRnRiSFBL?=
 =?utf-8?B?K294eFhyQk5YOFBuc2xmTHVXR0daVDErcm9ncTVmY3h2dUdKbTRuV3ZhbkJN?=
 =?utf-8?B?OU5lc0xGbE1pdG5NOUVSa3ZrdW1zSWpwYnovN24wUjIvY25HajNTdmt5SUhX?=
 =?utf-8?B?bXI4ZDZxOWtHVm5KM2grWHp4R0RmOEVKdTNEWHJDWjZHZlMvMHBtL1pwWjlT?=
 =?utf-8?B?QStYbnZWOExzTzJlZGtrdFhsaDcvQ3p0UzZjSnJVcnRzRTFVZGhIQmdQUStM?=
 =?utf-8?B?SmprM0hKOHVWTWhwWVFUODZLVGFsd2E0c3V1bW9KQnRVelRxQ1VwS1RxSlg5?=
 =?utf-8?B?SldoUEpJY3BDUkJPRjNIWnE2bVl0MTFaU3V5UDNmcGRBTVRURGtZVFNyNlVS?=
 =?utf-8?Q?Dte54fjH7YE6X0t91zdb4DfWLiwhOegXTIs37EeemDtY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00a7f58-c581-4902-10f5-08da667540fb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 15:18:21.6248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dD3Ou3h3DcUO25XgCPKKoxTp4ekazDJaO76U/YQPtgDs+JfqLHQWIgvQC2a8DpZU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1415
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
Cc: alexander.deucher@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.07.22 um 16:44 schrieb Ruijing Dong:
> Define HW_IP_VCN_UNIFIED type the same as HW_IP_VCN_ENC.
>
> VCN4 support for libdrm needs a new definition for
> the unified queue, so that it can align to the kernel.
>
> link: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits
>
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 18d3246d636e..fe33db8441bc 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -560,6 +560,7 @@ struct drm_amdgpu_gem_va {
>   #define AMDGPU_HW_IP_UVD_ENC      5
>   #define AMDGPU_HW_IP_VCN_DEC      6
>   #define AMDGPU_HW_IP_VCN_ENC      7
> +#define AMDGPU_HW_IP_VCN_UNIFIED  AMDGPU_HW_IP_VCN_ENC

Why exactly do we need a new define for this? Essentially the encode 
queue is extended with new functionality, isn't it?

So I think we should just stick to AMDGPU_HW_IP_VCN_ENC and not add an 
alias for it.

Regards,
Christian.

>   #define AMDGPU_HW_IP_VCN_JPEG     8
>   #define AMDGPU_HW_IP_NUM          9
>   

