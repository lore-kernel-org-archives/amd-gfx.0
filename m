Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CD0C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 19:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA192063A
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 19:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QvxShBv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA192063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826FD6E80B;
	Mon, 30 Nov 2020 19:52:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308A46E804
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 19:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj6slK29V1bMosFGgz550O4f0tjRHFl2PdhbXeUkb+jcE9MsoVxcVYjleR0YdbIJmfN2MkFC7MoZNN34pn/pEiIDJ1m/0lbwcnQeDMyB71ZzOA8tqJpgYessrXALqIQwCugo2YskusmyIS7X7FAeLZcUAXez1XvwSRcXeVAnmZaEyvA5W0fID8pVIiH/bExE6CwASsmcj5m03tYruN99fB37SxNO1AJBmlM/UY8eypOrMRFPqOnJjOBlhk6HMqb0IPEAjdqLyB37AZ1vKLMnvgOMqAqNYQgB+5X1g9BlfUFZ+OzsWuBMxevqyl5U9oiD6XPdz2aXN5gV9MLiTZvSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDx19+vJTHBVDyksBwbxHI14iwSATrlEC152Mh6Pfj0=;
 b=moRlz1lAw7GMEgVO/kC0oUUf8u7p23oB53GoZJwPGeEv5wubfrpH2HZO8KLTkURBMLLCnzwwo8SJfU7WDVclRn+jvi7g8xpbylrx9eF8Bs+u5ib1MqrQEe4EF2FEmrl9Rr/i6ujtORu+qFYROZlCPSiXD39bI8Yk21O5OF/fGz4s32kGEB0Q463Q45aTBA4rv8SVeBvR1+pJ44gWb6iitvXkYcZ6EFKTSjYEnQHEeBeosRK24xmgF7L795dTbDFsFskNVbQh3CZtLzLzXrgSZVafNr1imykVoKFSs4MV9pABiZ+X2D/RSUD9hPeFKoc8GLfkOPapOtvcTKDuhkUN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDx19+vJTHBVDyksBwbxHI14iwSATrlEC152Mh6Pfj0=;
 b=QvxShBv4LdoCor6okL0eyrzXyaeIcgXktqu3Jt80svZ58XQeAHHcFG3LfK02bb9Fsy2QTdCOQ5iirkuWXrU6Wy9W+1VZpO3wXc5L0hoO/olkYmedQymlOGpGhih+V8Ql+YKOekXDyhl4XoXsMENiT1Wbp3y7E+Rzjgob0dgI8qY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3837.namprd12.prod.outlook.com (2603:10b6:208:166::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 19:52:21 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%8]) with mapi id 15.20.3611.024; Mon, 30 Nov 2020
 19:52:21 +0000
Subject: Re: [PATCH] drm/amdgpu: default noretry=0 for navi1x and newer (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201130192515.305306-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <9075d858-0008-2583-974d-08cc4ae31fed@amd.com>
Date: Mon, 30 Nov 2020 14:52:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201130192515.305306-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::14) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 19:52:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10ae24b5-0193-4437-63fb-08d895697367
X-MS-TrafficTypeDiagnostic: MN2PR12MB3837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38375B9CE2ABFD0C47DF9A8F92F50@MN2PR12MB3837.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tJWYAq9iNPKsUuqJmJ2KGqWuAsxlz3oNrez6uXHyR3vHQVBc7/EgFmpQfTRuKkzIkdOV6W7vOOpMZ7FzGbYt+0GgPnT5daWiqElhOeMKmppp5X0T2jqJhf+KjaFlmOxYd+2Zk2amYRrEnt1ko0cAuwx232bw7bDish83CQcgX4xY5U+Xt0usJMvdZ0qK20be1nkKuYMh6u940RkUjePMfJ7MPyu8CZ0CCAfLAjZOIliBnOY3N5DMCYmPGGL1GE8ro8JSejzCeyegHC0Au3LC8qVmbmG4NxPumGHqvwX3qvmkLmtq6M0Ihi+xnE68jTtGoRpX6jeP76yQNdZj1zdynAExH33LlBTquX94OCIIl9ZclZFiUTJbH9w1lnWRQA/FW58VPBH+v4JGD9hxZvEgm//Pjg+dvL1zO3TBJbMOlI2IXnKCmj+JimXkAVlQSWQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(956004)(26005)(2616005)(83380400001)(16576012)(16526019)(44832011)(86362001)(186003)(316002)(966005)(8936002)(52116002)(5660300002)(2906002)(6486002)(31686004)(66946007)(4001150100001)(8676002)(4326008)(36756003)(66556008)(31696002)(66476007)(478600001)(32563001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S0pYRjNKMHZGMDV5Vk54RkdXSTczc3pDV3hmeno3c2FIelJidDdpaDNLT3Jm?=
 =?utf-8?B?eUNUTm4rT0VtMzZnaXgzSkZ4Q21UY1ZuNFg2ZzhEaUlwYnpJekVDTUVGZ3dY?=
 =?utf-8?B?N3BjTGVOaDZSaiszajlESi9tcTUxUXdjRENmUU1SVFY5eEZZQkZFOVcvN21X?=
 =?utf-8?B?eDRIemg0T1A5QTlVWVFRWFNISU5FeGVRcWYwYkdqYlkzYkZaK2NURlB0dkY0?=
 =?utf-8?B?Ymk1QTNHbWl2bUsybFpEVTZpdEFza2JsVXhqSlBEVURhNnBWb3c2aHJrU2Y0?=
 =?utf-8?B?S25sYmVHZkQ4MWVIa2l4a1Foa0Q0d21WZVE0NHRKNENqSlZPV3V0UTFkSEpm?=
 =?utf-8?B?T2xHWmw4U2kvZ1Vjb0pGWnh6RWtpcmhwZ28ycGEzRjdGejZEVlBRbEkySkFQ?=
 =?utf-8?B?WHd6VE9pK0RIU05RSkNyVTZ5WkY5M3dqMituS1V1UVQwbnZxdzgrajRaT1pr?=
 =?utf-8?B?Zi9HeUI3NW9TaGJkUUN4R2hPVHREY1o2ZGQxQ3Z6OXRWd0hNc2pJWVVSN1VL?=
 =?utf-8?B?NUV0OGVnRWNFSldCd1NtM0RjQzJHcnk3YVROSmRwbWk0MW50Tm1tdlNqZFNx?=
 =?utf-8?B?REc2MHljSzNaSlRwNFJaY0lzU0h2QWdaT3VLMjVrWDlCa2tySU9zcVZqMFBy?=
 =?utf-8?B?K1QwaXJwK3ljNkVvZVF5WEoreDdONWF0ejAySm9FR0dROVBheFlLUU9oVGc3?=
 =?utf-8?B?UlNCd0E3NDBFYk9wT0dVSmxHaVhNOVFOb0VpcVpRTkY5dm1KZVhJVXQzaDND?=
 =?utf-8?B?bDZVQXBOZ3hqcXQ3WlVrMUU2NmxjS2hSUmN6dFg3TTloV2c5M2JhTEZMZE1V?=
 =?utf-8?B?NHpTeExjOWQ2WlJRYjRZb0Z0b0J1Qit5VThXWTMyOUJNK0pwUmdHV2NKOGJp?=
 =?utf-8?B?MS9NcDhiTWVaQXZlVGVlVjRlTGVsNnZlUTBzcTFyc2dkQnpwcjMrY1hIa2J2?=
 =?utf-8?B?YnpWTWd3YXNKb3FpMnRoRDVRbW9uYktoSEE1eHNMSnRTTzZLMGVScFBFaS9P?=
 =?utf-8?B?ekFaSHVrQXRTNXJYLzJycTRFa210amFub3pIVFJ3VXlVYzVDWHBtODVVNjJ2?=
 =?utf-8?B?ZVNydUtMYjYzRUNRaXlKUzZndlRXT1hpYmVBTWIzMjhYN0hWUloyVkUzZEFD?=
 =?utf-8?B?U2hLYXFHUE1pM3BSLzFDZ2o5a29sYlBxYWVkWWV3R3pYblZoa2ZjUEV1YlAw?=
 =?utf-8?B?c3NnNWdMWTRSUDIrOTVzRCsrcWFYNEJXRkp6L1JrU0hEdzE3OGZlYjJsWEk4?=
 =?utf-8?B?S3FkMWJXbE5ONDUrMjVOeHpHRmVEOHZXOGRWakpFbG05NlFpQ1owQ3hZemNM?=
 =?utf-8?Q?MDa6PDIoRznWNVmIhMY1UE2mvQSN7PC5QB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ae24b5-0193-4437-63fb-08d895697367
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 19:52:21.4927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEjy5Udukwo9By/1g/w0Kj17BpgtzxYxubIetW3rMsEZPisY0IELdQ2ne1helpr8f9Gtq5wBaWI0ChKguk8XkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3837
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-11-30 um 2:25 p.m. schrieb Alex Deucher:
> There are no performance advantages to setting it to 1 and
> it causes stability issues in some cases.

See my later email on the other thread. There was another consideration
besides performance. It had to do with retry fault handling, which
depended on being able to reroute the interrupts to the IH1 ring, which
the security policy doesn't allow on many boards. With Christian's
recent changes to reroute retry interrupts to a software ring, this
dependency is gone and it should now be safe to enable retry on most boards.


>
> v2: simplify the code
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1374
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index fede84509dbc..b07c47cacd28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -422,11 +422,6 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>  
>  	switch (adev->asic_type) {
>  	case CHIP_VEGA20:
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI14:
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_DIMGREY_CAVEFISH:
>  		/*
>  		 * noretry = 0 will cause kfd page fault tests fail
>  		 * for some ASICs, so set default to 1 for these ASICs.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
