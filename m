Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D4C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 19:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709E52076E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 19:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mtB3fl5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709E52076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA0289FCE;
	Mon, 30 Nov 2020 19:25:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EAC89FCE
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 19:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZGG3jm5MMGLBwSqDSl3InVI9t2BHeyyRstwYYbR3s4k2AzczMmI2kiOyTgs5JJ2uelA54AqkYs8LXcV4c6ooAGyLwEE/Z4aLNTX2KV3xe06mZjpNMHpi65M2DLuV79z1pNDZBiCy7QSXeu2uM2NIU8FpulUimrHs9blhEkz7XncNRI1IyhRvCENNxBRT+FKwWRlPIB7zBtgIPEWhwq7p6GXRWJn8aSAw6a+iy65Ou28gIKBwCNd1tJ1a/6lCY729JKqXNrM+JZk4HY6DQNPH20audhinzXznSwHLF12XMEI7YqSQi0K5Oc0sJYm/WlJVTGMA+YCVe6XjRDS7QShQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzPrmlgM4gk7amPM3KVgK936+GvM3X1eGf+ka2I5mEc=;
 b=lBtpUk0MHOt3NDyl5bEB/BIIlQp+pO1qc/yXmKElFW1c5rcDDFf2qA50CCyBnhYtzdcwdcm0UJQ7+ZvhiZbNdySIE7nHzTOfTHRcDmO/VCerm0w0PpEQlJeI2cyfQPOUrnlna9l9i92r8GrwvZ6wVuGgJMFMVwJM4Bc2PS3aGcdMs3FQw3ygwuMJY+nNiT5CBVrcbWZ0A4zNs1jSOemLtPNTKLe77aFuoQvSqzmaPUmOsKtjtOpSpZm8bXBAqi4LvORjk3oApaNJPMgwzkWWnqvzkHGgI9FJvfn9wkXnvpeO7Y0S4lyeXxejoZNP8gCqZrVXNZP1FGN5SCE7Z7PgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzPrmlgM4gk7amPM3KVgK936+GvM3X1eGf+ka2I5mEc=;
 b=mtB3fl5kj6zBzPKwvBsqoVrhCDf+nzhOodbmZX6tgZdjR120iIPchx6x0jKDItu9DAqf3dkhQWKORmVKOK+2sAly7fh/tDZMjeuX7QYVeoX0s1zmM08zjJNcAN6xKc5gsrwnBRCuXg5UypAQWBa5cSfvVvAaFPZjLyDsQZlEKMU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Mon, 30 Nov
 2020 19:25:17 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%8]) with mapi id 15.20.3611.024; Mon, 30 Nov 2020
 19:25:17 +0000
Subject: Re: [PATCH] drm/amdgpu: default noretry=0 for navi1x and newer
To: amd-gfx@lists.freedesktop.org
References: <20201130185837.291258-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <6aacba1f-6f0d-650e-c3ac-e20f88469891@amd.com>
Date: Mon, 30 Nov 2020 14:25:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201130185837.291258-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::23) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YTXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 19:25:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4a78e58-b349-4e5f-c250-08d89565ab93
X-MS-TrafficTypeDiagnostic: MN2PR12MB4391:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4391AB3EBE7E0910CCEE4BE692F50@MN2PR12MB4391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGn/H7yM65ihOxtgRam0VTScs21evmfoKj7411Y1Ga6QXbkRDl7ddOzGfbbHrcO3nz0HT44BDLpsT+J9dLUH4x11SAIvJY9NVrSxDNq7bjyKO+ocyMfCTFXjtSmOsWwYlIBia9EtznppJhaBQorKpg+6wBD6B+vmFazhZVlSyNrfi8hoFDRorAPOyrrhD3fPoRVKWPvdQnoxw+DHdhlKoy8VPKcrHSz7kfUvaM63ecJs0B7jIbxX50dt9ushNPh1qCrnCooufmDZGK/0AKY1wime9cTULRpvnWcONsVmR8wMJ9lpy8Hd+pdyGC8js4XauryZQjJq/hF0FLZJN1ZIsufoauhZi4RcxGyRqCg7I6pVNVgjAq0E4a6kA2Mc4EqfVgTUHtJrQQX1Q+6GE/YFeUlh+Ni1+aukHpwxLzRQAPw7MiUYdUNKAyZjvTuqmG8s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(31696002)(26005)(956004)(86362001)(44832011)(478600001)(2906002)(36756003)(52116002)(83380400001)(966005)(186003)(8936002)(16526019)(16576012)(6916009)(4001150100001)(66946007)(2616005)(316002)(8676002)(5660300002)(66476007)(66556008)(31686004)(6486002)(32563001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Znd3R3ZtTFFmamo5QVZ5RjE0bHFSZnR1QXMwMjdrUjI1QjBaanc0Zmd3dWYy?=
 =?utf-8?B?cXJaS2FoZ0RMQnB4c2tsNk9TekFkVkNDUVY0eG9UQ25CZncxemV5K3FabG9t?=
 =?utf-8?B?WVdiZEROSzFhZG9ZcmdDa2o1ckd6b044VDF4c3pQSCs4ZGdxd2VHSDh1cTV4?=
 =?utf-8?B?K3IwamdBUmEwdWcyZUtnL0tzWDBGaWU1Z25UaE5pdUNOOWJrbmFJOTh1UnZZ?=
 =?utf-8?B?eUJWZlBUcTFOVkh4RDg5bC9TNmVGZ1JaUW1LdUxQSHZ0VWtLUVM1dy9jTkhu?=
 =?utf-8?B?MlZaNnlJUVEwOUlGTGt1SStaUHZ2ZHBkdkRnMzhYVkRQSTBlcVB0V2pzZ3Vl?=
 =?utf-8?B?S0VkQWRYSTBzdEJmZEh0U0E3OWZvODUrazVzM2hFalB3dUduRHg1YTg4Mk95?=
 =?utf-8?B?QnZRSXQ5b01OZmMycVlxQlZITHZNV2JpTERDYmdxVlFKRWN1U1pDZ1NhVWQ4?=
 =?utf-8?B?MHRzeTJGTC9rVFFVYnlCakdsVTExM0ZqRUZxemlaNEpjQ3d5dUVqMlhHcTUx?=
 =?utf-8?B?STl4R2lhRzRuc2FIQTAzUC9SSHRIejBML1dyOWFLL0poaGZEWHZZZVFYRHhq?=
 =?utf-8?B?VDE1NXJpQ1pTcGVjNzhDak9aeUVVNGJ6OEN4d0lxcWtKNkRpZXhoY3BRQXIw?=
 =?utf-8?B?cjRrMlZsTlM1dFdkTTNzNFVqMXE5L3lRcmpodlFZLzRIVm1yczZ5Y2dVc3Qr?=
 =?utf-8?B?VStabnhGZkJFRzlnZFhuaFNvTkZwTVlLOHJIM2ZpS2c4T1VHZHdObjB4c0FC?=
 =?utf-8?B?MFhKMEZmL0RqQkZIUFVKNzlJaU9XVmFkMGRaY1QyazZ3ekRpcGZjMis0NlZz?=
 =?utf-8?B?bmxMRk9wWm1BTlhUR2ZCYmJpRzRxQ1lCeWVtVGxXaVY5VDk1YUxBbjdHK2Ji?=
 =?utf-8?B?U1RiRzVxWDJhd2VWNjBFN1hzZ1JsSFd3eHlYaXpxVmVVNzB3bldpaUZwakFT?=
 =?utf-8?B?TFAxaEhaMUtRWWFQNEhiR3hDVmNJSkxYd3NzSzdpb0g1WkRkNFJyK0hwZUww?=
 =?utf-8?B?V0Fnb3FxMjhlak5yM25pOFpoSE5YbG5rd1c0YWVuUFNtQ1oxaVVQVzlUc2dV?=
 =?utf-8?B?NjhYbjZwK2l4VGlrTXFnR0h6NFlkZDJwRUFDTHk5WDBCdnV2ZXNmK2ltdk9o?=
 =?utf-8?B?UnY3R1J6OHdwRlJZRzI0QXI2aXUrblVuaWlnTXNRak5vMEF2WHVnQW5KdnRQ?=
 =?utf-8?B?NHZ5aG5zWW9MNGRLWjkrQTJJY3N1TEp6ekl1eVhLNGFMbDM2cC9XSEduVlRD?=
 =?utf-8?B?cVdYcE1GOEZ1MDRWSS9VU1lRV1VVQnExTUVyODUvam8xTVlYSW15Zm9PVjN4?=
 =?utf-8?Q?zzTrlfA2ixh3LXeSy0K43492HC5QZjBlMN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a78e58-b349-4e5f-c250-08d89565ab93
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 19:25:17.6913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ciRoaK6DCPHxx/rfPiWez0PDVGPocDppW/jXwUNtsgswM7d6EZEynvPV7yLrNrTu6zy0cmmce9r4mZxsk3rDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-11-30 um 1:58 p.m. schrieb Alex Deucher:
> There are no performance advantages to setting it to 1 and
> it causes stability issues in some cases.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1374
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index fede84509dbc..02b2ee9b8939 100644
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
> @@ -437,6 +432,11 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>  			gmc->noretry = amdgpu_noretry;
>  		break;
>  	case CHIP_RAVEN:
> +	case CHIP_NAVI10:
> +	case CHIP_NAVI14:
> +	case CHIP_SIENNA_CICHLID:
> +	case CHIP_NAVY_FLOUNDER:
> +	case CHIP_DIMGREY_CAVEFISH:

Is there any point listing those chips here explicitly, given that it's
the default case? Anyway, the patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

>  	default:
>  		/* Raven currently has issues with noretry
>  		 * regardless of what we decide for other

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
