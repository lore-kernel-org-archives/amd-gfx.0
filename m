Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F1DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 18:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9621264F3F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 18:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9621264F3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF708999C;
	Mon, 15 Mar 2021 18:42:41 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760052.outbound.protection.outlook.com [40.107.76.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B01A8999C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 18:42:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlicLy1B2H0FNpFu1hnUnbBi1VLBJ5sj/MVCl2JE4BZUdpOu5OHuHxqMUo+aPNP7pXP57BZJD5Bns7BluoY2N9b9Op3YHhGvruDVKQ383ezbxY7v9Ku3W2VZEJFBdT/qy+hfel5sI6ghrUWmuqtETaaqe74TlOHGKnfgP6FLgdN0rkZ4uU7lp80wyAqrTyPuKJ0+EUfMDgTpYOAfG2qIvplpFtHLObvQ43CsIE09gV9xnVwMyS/E8srchFRnEvphfsEiEljsfy/S8qadLOWUXtX70JR5I0wUbsm7TFAZvGn4xfM69+oxKLICf/LCv+L85p840tbeAd7zutM7fGwKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qYaFG8gmGXKNbluFwinqfOHRQSMc9ieWjbNbq61c6c=;
 b=jCijGySfoZ15YfMctbGLMWeCl/i9soE742jf2fKgaoh3LecFwuf5whfrRl9G9P9PWR/IBd0FgDhExhX8uU+0CGpMMR2l/4J8g69jsB9QimOuMwBAwsymPKNovdqOPy70aD34d+Nq3uEvI3CWjLBjbFapIjNbxiFOUNf7x+2/9GnPGF5lTsTWrFCsZMZOlmrjpjg+nGmYuPTXgxk6d6rHBWfGQATpXPIXW5PyoK1mu/8GCpc//UWs+Khfdwam8sdeEHppXL2cRMYMce/gbFHLYu4NjJkLPvkn18kwO4LdmQdwUDtu5Gm4H5FD0VNjUtUrBaC5L7ZWheJ7moXS0cUorg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qYaFG8gmGXKNbluFwinqfOHRQSMc9ieWjbNbq61c6c=;
 b=K/V4aLxiZ2C7V9RiVMwDQT+FBOVwzxOvk5JsRBBOUhbnIoc0L8kE3+88VSorU+qH2kpUqPqbz0kBPezNayPSTSAxq8K64ir1GfwZxRualqSqmYlwYKmeguMPGKgV1PsGids+LAcMHmnX3UFhrp3KsMHPHhVooJMJnJ9Ed0JWAVU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1239.namprd12.prod.outlook.com (2603:10b6:903:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 18:42:36 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 18:42:36 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: fix compile error on architecture s390
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1615433344-16267-1-git-send-email-Oak.Zeng@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <34b7c10a-b255-36f1-4cbb-f3d05c760590@amd.com>
Date: Mon, 15 Mar 2021 19:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <1615433344-16267-1-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.103.190]
X-ClientProxiedBy: AM0PR01CA0158.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::27) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.103.190) by
 AM0PR01CA0158.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Mon, 15 Mar 2021 18:42:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b96fb882-6778-4ad4-ab56-08d8e7e21a3f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1239804F1A572341470739C98B6C9@CY4PR12MB1239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zv2DJQmRqtBnHnbotwEsn+xYHcnxsfCwyl548XNf9wCnOzgRxNYwNxKgOZkckq5uoP+ekq3O5G7+MLR820nZ6l7g6Ydr0M0KbxhlwLLbnqQnmHoOs7fd4LU6hxGUMcn9kYEiBu9y7MxMahzoYB7guRdrlWneKm/cfTOXQbHCyH64adqF2WQlkZDwQLwSVcQ0KjKrAXp4REgBfjR/YGYGtsYfs47Nk+yObiLNE2B7LBMDmAv2PK3ZKNwk7N8orcpqutWcJms55jwFHcKUMvwTdukMcWrumFdiPjYaWHf5XxfOE05tb/9MkR44uio6v9Zpzm9wo6IaHnQNh+YHrmp4kTDsWkIQO5IH/iNbmX9HeFl3Ah9XpnsVhG23CK4Yk/MJdF/arRe5md46tPCH26/xbtguEh0VYeEuuR/k1+M9BncW9pgkb5fH77UqEP8bKbgZHiex6RlhnLwF1OGK4IBcwyBc9aW1lovMMCrdQJIu6n51sODDNE/+pD8OSGDqb4AHq4ZzyomdE2u3apMykrdPpIvB7SgY/385cWHegDz+HY/4ASVjFqmhxxJXNXEolcyUoGvyue6PxUgXVM3zvh5MGBt4yz0y2Dht33Z9m8Z/GoXXFgemZnqv3Nz3GeMmp1Yj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(36756003)(31686004)(478600001)(8936002)(26005)(956004)(6486002)(52116002)(83380400001)(2616005)(2906002)(16576012)(5660300002)(6666004)(31696002)(8676002)(66556008)(186003)(16526019)(53546011)(66476007)(66946007)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YkxYU2tNbTJ6MURqdDMvZjFuc2k3OGwxTXdRVGNDclN4dHFDSHRocWRwdXRZ?=
 =?utf-8?B?MGZvWENQY0RqaFhTMWtia2ZrQjk1emVtZWhYT3ZTMUJ6Vlh1NEhyZDhyOEN0?=
 =?utf-8?B?NXN1OU9MVS9FRXpSRXhtMHRTM1RiS3ZQL2hYOWd3WlhzL3Y2RnUya2M2SGFW?=
 =?utf-8?B?L2ptV2hxVENnM0dmN0N2cXkvbG5LZEhKWUxxZHJxT3ZGOVFSMk1DYlRsQXJM?=
 =?utf-8?B?ck9VYk0rMzFQK00yR3h5S3ltbUQwL0h4SnhUbGViZ0FvbGw5MDR2dFgzYnB3?=
 =?utf-8?B?cDZMc1ZZc3o4UjlPSUUxNUF5MmdzdkhFQ0g0RkRjMTM3T3VhcVM0dmZndzhI?=
 =?utf-8?B?eHAvK1JLd3lLNklEdWdzTkNkMVlZeGlXbEVRUDdGWFpiVnZJWkZnbGp1Vlhk?=
 =?utf-8?B?QW5LVEJ6cjB1aVNtUFU0K2xJalYwVkxDZXp2aExYVjQvNXhXSHZWQnVIbXJj?=
 =?utf-8?B?eW9vTXVUSHYyMnBraFppV1VEQ1BkS29lM3A2V3U2MEtGVUR1aVZRSlFHL3Z1?=
 =?utf-8?B?ZzlkVlNBRytITFJTUS9lOUVUNy8zT3VEYzZqNnVqSk14WENzemtLdklFZ0Qv?=
 =?utf-8?B?Mk5BemkrWms3aVNWTXJxOWQvSjNZSzQvVldWb3RuZTlaR2xocllCM1U2bXN2?=
 =?utf-8?B?NW51dE9FK3dhcSsyeVl2aFRTUnY4K3ovVzMrMEd0OWwzQ1MxTVhFdm5YanV4?=
 =?utf-8?B?akZVclp3RlQzcGlrZk9wOFBzQzk1cXhBQjdYSzJtdkZ5RUxuSkhKcE0rZ2ZU?=
 =?utf-8?B?QTY2RkN2NkdBcVNpTjhnT2t5OWZ4YWxZMGtuOU5lVlNhN1UwSE5vRmNOQ0xQ?=
 =?utf-8?B?Q0FvTjdiVmVuNFhEUHJsakFCMmVCcDgxNG1jY0FkYWZqVk9rcmVwUENnSURU?=
 =?utf-8?B?VTdQWlp2VCtKYjhyZVE1eEdHUW43cVdwUHgxTWUwclVWRzBNa3NqcW1hRUlh?=
 =?utf-8?B?S2FGVkNQaTZ3dENqKzNvckpwRXFhQ09hQlNGU3NOaUUvbFRWQ3hiNGJEMGNv?=
 =?utf-8?B?dXVzM1dzQUo1eXdPQS9HZWN5UDRLYksyR0RaZ05SVklubXgyMzNhRDBtWS9B?=
 =?utf-8?B?Zmx2OWtaTlArd0JOVUQwMzZVQnI0TTdYVjIvTDQrbE9qYk9QeFg1VU1QMFV6?=
 =?utf-8?B?WGloejZ3TFUydnJoTldtbkM2ZlcyT01mZ2FFSHB5M1NMQXZ5TTZ5MUF0dmN1?=
 =?utf-8?B?VmpVdVRUcUV5dmo4Y0h6ZFJOS25EdnJudXdXUEpmM1hFQ2pIWktwT2VuM2Ja?=
 =?utf-8?B?TEQ3MEZHSS90dzhaSTFZWjlhTGFUL0cwcG5xQkNTSVQxZlpzQ3FQR1RxRmlq?=
 =?utf-8?B?Ums1ZElrSnZ0dzRNa0RoL3hxS3hlc3BhYUJ2MVpRb1EzeU5PTjlsdy8zL1g1?=
 =?utf-8?B?MkpiQzZEQUZFL0E1QXF6Z3BkVUpYNCsxT0tneEErb0RrVjNPQ0YrM0FwSUtZ?=
 =?utf-8?B?OFJrQ3A4TE94Q1hnUkFmTXNUM1djTG9UQlVmV0pNS0Q2aGVsY1NTSW5RUlJV?=
 =?utf-8?B?RGlTZDVJeEZmM2JVQ1ptV2RKWGxweVFnWXEzNHF0bWNNWXRHalpqMFd6Y2VR?=
 =?utf-8?B?MnpHVTB2MDhkSWNCaW1qbzJVWStWTEthSVQrUFQ1eldBRGtPOXZvRkVnRTJ0?=
 =?utf-8?B?d05ORWRCTFNrWFA0TVgvWm9zQ2N1RGV6ZjY3NXZaenV0MzhCb281RVlQK2dU?=
 =?utf-8?B?d2o0UnRadVBtUnNmNFRuWlAwWTNvM25HUmFoYkNJNzgvczk4MVdXMDVrd00y?=
 =?utf-8?Q?XFeu9vtIAd5M0JJ9BROFSOeCKyk4t6sW0N3FGDl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96fb882-6778-4ad4-ab56-08d8e7e21a3f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 18:42:36.4709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiXBGY3QuyOfdXHG0oNSL+hbDNqydzIFKYdigDWc7wAXgOR7uj0VgSJgLEg5UBqffxyEN8BJyoo1is+JIHnkvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1239
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Wouldn't this restrict amdgpu for only x86 platform?

On 3/11/21 4:29 AM, Oak Zeng wrote:
> ioremap_cache is not supported on some architecture
> such as s390. Put the codes into a #ifdef to fix
> some compile error reported by test robot.
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> Reported-by: Kernel test robot <lkp@intel.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 37751e7..1091585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1817,7 +1817,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   
>   	/* Change the size here instead of the init above so only lpfn is affected */
>   	amdgpu_ttm_set_buffer_funcs_status(adev, false);
> -#ifdef CONFIG_64BIT
> +#ifdef CONFIG_X86
>   	if (adev->gmc.xgmi.connected_to_cpu)
>   		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
>   				adev->gmc.visible_vram_size);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
