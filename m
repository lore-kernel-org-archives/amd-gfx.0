Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0326C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 19:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 726E289339;
	Wed, 23 Mar 2022 19:11:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34FA89339
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 19:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCODtHFMAT32Cc7L6k37IuvBWYki3F5pmUTsPZAoE7vlxn5NK7WWNwOIMO6f1bvYCfeTIdvU+jhwkakYWt37+hxI/UPYfhDcmKHch4dytjOZzUo4aaqYCuOM501aMl9ZGBWb3FZpvOW/CbLMVtk0PkhVSPsfp7zQ8b4QVsBOF/w2h4/q2UOUGApCw3ev3vJHg7uuuwudpMZZQiKNeFFC0YrR6xiqvNmfhFWOktSrvS5LKvzpweeubwENalo8QPRWEEnkR/s/TZFetLd5KWOliQJb/MgcfTST/bUAHuX4V9xQ2INT5Em3nzxrusWkQAi5hwadcnPzmIZxYXic+7cvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKKGp5u8WtfG+wzLEszALps8vVJmiZUWg025XZLoJjM=;
 b=HdLb+EsEiv7xAUHjspXvewiLczb2H22gmhW7dWMR1FodYDOcUlcZC0AOm0ixw+G2LtJa7CPOgDv3kUdPIlbMNrviv7Q8b203arVbVvCnFEbqecBAD8ExlehJhBqb29S5b86Mm4yPysd4xCULZjn66OFbK1TyWY2ic0DKc8nmk9dVGrGcgex9vdljIBWzAU4tJq6tMv5PqGKlWZ/VVtUHbdmAYXbver982B6IZa9kHW95ZLbxtK9NdMOyLNxyIpX/5OPAnLyPNdwhFOvXKy99cMRyJ6xAStZqBpGp0jI0F+olbCJZ5rXxZBzl9ioO1h11SVRqSSI/0hMpeT3jZiSwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKKGp5u8WtfG+wzLEszALps8vVJmiZUWg025XZLoJjM=;
 b=I482UkZaLBQ/TLl5Fbc7QW8X+svvj0srAZc8ZtSKpFfJHGGighrJ8luLwNhCNEASMO+zG8MIyKo7sfAwNzw+U/qslXcjQy4aMV8pjZMciH62K66xjNOfzdgjhE7eikDG9VT6vV4dNWM7IT1XtxywsGV0QVIAZmxgWYk+fjZwB+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3472.namprd12.prod.outlook.com (2603:10b6:208:d2::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 19:10:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 19:10:54 +0000
Message-ID: <c0b8794e-8daa-cf91-af4f-547e56e658fb@amd.com>
Date: Wed, 23 Mar 2022 15:10:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/amdkfd: Check use_xgmi_p2p before reporting hive_id
Content-Language: en-US
To: Divya Shikre <DivyaUday.Shikre@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220323142016.1810918-1-DivyaUday.Shikre@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220323142016.1810918-1-DivyaUday.Shikre@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b7bec2e-1619-45cd-681a-08da0d00da8d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3472:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB34728DB498D639EFE8469D8592189@MN2PR12MB3472.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9GbwIWknHacqSMPlwEwAYr9QawedlP+hIklLP6MJM/ZO7uR0PD1VzzK4oHhuPwwJs5nxsC0xGYPCynbDql/ZE34v2e1UneS3EkoqLw/z4tVfD1/zEPwwivZjlCZpqrG3d3pOeGQ2jERFIl7g5avduq2dSZcOM0gVovlbMoswb85M11ixPcbEViyQSPjOIIS83W5kMb6gp0hcqVCENWwULKt6AY06O7/h/jVw8++BkYX1ARa5FKmx9h5H4dK42ZRqIi7zlULzlVqVe0EmPaSxhT7MbefRtnd/A7Bfhr3G9XgYRFTRaWfrJCuzh58twns4S91m28EuElVJ46oy2XylHG9v+8V2qKifaAb3R/dcieYSpEjq4ZoC/qQhezIJXo0wi+19+FLrPLLbnDYqGAG22Nzf3HGO1rwa5NwvvvQTmSGCbimSOgjzJkZTFMmC426RFr7f+m+VSbzQCL87rqow3eKHBqEoyne4TZPJcoFp17TDrw/wVEWv0XBPNjGRf0ypE4Nt7SedBqpNAtKCH2TzG5ViM7ztSmM+xa8Vb+e36grSBnQtUVKN3/L5CeRjNzrt99FE8moY2NjmNBEDIG22EupJz+nVL92r0OXE603Hnnz4mNkNJk0fJp6DvIE8EEQ8rxTYP7hOXARvG2eDqXA0pXtb03WrgSdVMfV4Tf9Qy4rQTajTlTpbOcMEx7uDJi77y9Phlji1OhQltWJRwWCqh2qM3Ea+58wm4ZyNBaKomG0Tf69MpJz/SMly7qYxiDn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(2906002)(508600001)(2616005)(6506007)(6512007)(186003)(26005)(38100700002)(316002)(31696002)(31686004)(86362001)(8676002)(66476007)(4326008)(66946007)(66556008)(44832011)(6486002)(36756003)(8936002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlVPMFQ0VHNKOUdGRmRBVkc0aWNzNnRrYTdiakF6eEszMmhDTlJQUDhiYlAr?=
 =?utf-8?B?aVFtOFdtY2JWT2pQOGVyTFFRVFd5S2dRZjVWbVZiSWNHdWlZSS9qLzh2T2Fm?=
 =?utf-8?B?Uy9oS2VBS0RiL014MXhwSjJrN2FPZTJnSWQyQlZRY1RmbHhPTWVSOTN6N0lz?=
 =?utf-8?B?dUlxTjJ5Ym1ROFJIMEZETkhEc09lV3RmVzMzUDlHcUpXYWlKSEdDWUJzem93?=
 =?utf-8?B?Q3FhTjhwek02d3AvbHFsWk5VUS83MXl3QzB5cXlDZndjNmJxSFNQY1ovMVZ6?=
 =?utf-8?B?Zkl0LzVMZ0Eza0svNTEzbzdYYVRoTmx2WGdsMjJYU3hkWFhxSmI1K1FaQnB3?=
 =?utf-8?B?d0lRSVNENDR4U25nNW5jNTRaYThQVDFTenlhb0xaRGZMMjlTa2g4bVZ1enR6?=
 =?utf-8?B?SVRJeWMwaHJXb1lYelQ1aXZvcHdKa3JJeE5FT3dseXZvcXhoRjZxbVBZWEt4?=
 =?utf-8?B?REhhU3Z6bXlzZURPS2FoWHd2cUJSRkJZWndjRitOb0dKQkc5N1plb1RHdlpM?=
 =?utf-8?B?eVY1Vko0Mk85a3lleXMyalQyZnNwOE1MT1dTaGFFZWsrWFZUVmdnVHpyeWRj?=
 =?utf-8?B?TDBDb1MvTjBZamdtVmF1NWJhbkw0ZElBK0EyRnRwSmwvTi9xcDYvQ05RSjY4?=
 =?utf-8?B?KzZUeElQK0U3ZmVvZGhPVEFtb1lNTEhobEtzVjM1Sm1pR1FrZUU1UVl1MUNV?=
 =?utf-8?B?TVdrT3UydG4zL0JyYk9DeXpOR1pXd3lyRUtZMy8zZ0FaeVpJTGtGdjl0aEN6?=
 =?utf-8?B?c1FLc1hsR21uV3JtZHNWWEZMZ1pDNE9RaU5QUURLUjdscnZXY1Y3d0kxT1dn?=
 =?utf-8?B?eXpISkNJYmNNVGV5MVlFVEkvWWFlSFF5Y2N2SlJzMWxYSW1UY2luVkYrOVRr?=
 =?utf-8?B?ZFA5ZGdQcjVsemNLVHFLYnFId3VvVlR5RTdhb0k2SEhlOXlmZjF2N1J2MHhJ?=
 =?utf-8?B?NTd4Q1JvUFFGMDIvSHhQekRBYU1zTjRzNkVhRHJ5UUtBWEJ0ZUJFeWJybThh?=
 =?utf-8?B?QSsxdVYrTjVETnBybmV3NVR6WHhyZUlYNTNLWkhuY1dxY2VqZWhUaUcya1M3?=
 =?utf-8?B?VEJ2OXp0bzNyUWZRZ0ZoOHlwaEhQUXpGS1ViaFZ6V0FmS2V6YTEwSE14Ry83?=
 =?utf-8?B?NW5vbFA0c3RGdmRyUkdoMG02UGdISitCRWVmMllnbnhJSFhPZXZGTUQ3RGxs?=
 =?utf-8?B?bmxzZ0hlRXJlOEg2Z1ZNSmRjZ3AvSEk0RXlQbkJkVXdaNkQyWUpDZ282a0ty?=
 =?utf-8?B?UkQ2STNHa1kzMTNCOENxVm0vdit2TE0rMzhMaTEzQUhPWTBwZUNrMXdiMEg2?=
 =?utf-8?B?eEoza0dxeEIzV3oxM0IzNjhKVWM1amt3ZDFiZFhjSWpmVUR0UHB3N2JrVjBv?=
 =?utf-8?B?VnBEQ0lZRUVqTXNDdnFPMmVxYjFmaWR2Nmc4VWZkdFJIaU1VakJodjBZanFV?=
 =?utf-8?B?Ly9yakt4ejUrVjNGdXdZSkZISGhOVjVHY0dtUk5mTXAyeUpZdVJFbUw4ajlz?=
 =?utf-8?B?Y3YyUkttOExXdUVaQnpFUVcxSUhmcXlqN3VxNC9mWStvQW1vcXhMaUJudFlI?=
 =?utf-8?B?dkhqM1hWVlQrUGo4ZktxSCtsQUlGVEpIbW5TODJJMHRYd1lwTUQ3RFNnZ2xQ?=
 =?utf-8?B?TmhlelZQRUsrVWcxbmMyaXBPYnZ6aEVZcjl3N1ZxaGhOb0NmYW8wc3p4QkFL?=
 =?utf-8?B?RDRHOTVDRS9YRGZxcUZPVlFMaUFyQVg0bStRVkRCWW9mWG9qV2lXbDQ1T1BL?=
 =?utf-8?B?cmNJS1VsQzhSZTdhV0h0R3lQUFJ6eDAyZmFTY2V4Q3QxS3UyendUVHJOSXQ0?=
 =?utf-8?B?VW9sd3ZSSWtJMkJGUGN2N0RhMWswL2QxdDAyOGNYdnVYOFo0OGR4bEQ0ay9m?=
 =?utf-8?B?Tmk4d2JDY1U4RW1jcUM0S0o1aG10UmJFYmRGVkRkRkJSRWtZTVpsbTFtUVFU?=
 =?utf-8?Q?To3Z0Ptme9hPqzGQcKySXgYtt8R9BNAE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7bec2e-1619-45cd-681a-08da0d00da8d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 19:10:54.5926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7ofLrOiR6IIDYIP4w34g/JRz5ovfZZoeDqODwT+zZhVf6y2WvHGv2Di1L4/8QF/RsG2u6pYrPml+HD9din18w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3472
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
Cc: Alex.Sierra@amd.com, Harish.Kasiviswanathan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-03-23 um 10:20 schrieb Divya Shikre:
> Recently introduced commit "845ebd6b7c32 drm/amdgpu: Add
> use_xgmi_p2p module parameter" did not update XGMI iolinks
> when use_xgmi_p2p is disabled. Add fix to not create XGMI
> iolinks in KFD topology when this parameter is disabled.
>
> Signed-off-by: Divya Shikre <DivyaUday.Shikre@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 339e12c94cff..d5536e33b3d8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -536,7 +536,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   		goto kfd_doorbell_error;
>   	}
>   
> -	kfd->hive_id = kfd->adev->gmc.xgmi.hive_id;
> +	if (amdgpu_use_xgmi_p2p)
> +		kfd->hive_id = kfd->adev->gmc.xgmi.hive_id;
>   
>   	kfd->noretry = kfd->adev->gmc.noretry;
>   
