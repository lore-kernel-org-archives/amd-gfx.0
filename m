Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA861C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 10:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B6F6195C
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 10:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B6F6195C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A0456E8A4;
	Tue, 30 Mar 2021 10:40:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1047B6E8A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 10:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaFfLDRPLnvIXVmjnLtmao5Q/kCM0mOfDizEwHncWoqh/sB6S8/TAgM+cwijRrSaYndlvfC4B79bS9wELHAtecN4fXqM0oc4Yvyd5tqi8xHNn26d2vVHlg8ZJTiWSIzbfGOHlpaAIxPGbla2vt8kqdJyukHbo0C5t72E57R9zH4NF9KXQlr/bgjQbSas/TEK6WgPQFILfSyMQMCv/rlome036BUbKZkISBedGstmzP2UJpCurQTDnFIByqKJWV+gLfdHk0DK4UuBgmwSosqqbyDm0HDt5FsA5xi8+N7j3mjOdbi+DLj4KsmwTncOVw9ZnDtQL0TUtz9Fqd5mlh4vYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVedna8hNAOuozWNdgJaruL0YHe4dVBOWZ0a6/r7tOU=;
 b=JuGp3EnOY3N7qlqPw16hiMvbxiuUi5ruO2oLHovb68zexUWB4yNVAsNkztU1PAdHvSsdqScIAIvmbPgG6Gvg6p87/iQ+pR5MkdKf7SjbwhYDA56gEUqctAsG60VyWZ5GvHbcQwziR10f60ADUtf/ISN6+Ak4mkNoMeii75ao3yKG7kMTGkULK9uLYEa7a6GeIJg9/lUcOcPxtL8ItJKA3+iZoEO2hXEsjiAzpb8ij39pCjD+T3q3GuMBD3FVgdse7qLMZcp7Fh2++4WXCBSt3DZpUH0TZ1s1SbSCT4MwxWfzLqKxtG0ocSf6C8O7BKYxOkmhv350aP/53FezRCfuaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVedna8hNAOuozWNdgJaruL0YHe4dVBOWZ0a6/r7tOU=;
 b=NrN2Axw6PlDxgEYUuM8RHYrF3WIK4FalsDycjwN/VSseN9H0kTEX+DW0Z/Qp8NSXK0cPasW2zANFQU8L7ECZocAjRWP70v2nD00jbvgaHA8LxZeuWq8WaVtGqdGamkwvjIxIdKBbrJzmvlJ1rZrJBVw49rcYeQHT3E1T0X/i+Nw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 10:40:33 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 10:40:33 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: fix compiler warning
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
References: <20210330100229.26435-1-guchun.chen@amd.com>
 <20210330100229.26435-2-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a8fc10aa-b410-efd5-ae29-7c4bbb76d05d@amd.com>
Date: Tue, 30 Mar 2021 12:40:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210330100229.26435-2-guchun.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:8ca4:a46e:6aa7:208c]
X-ClientProxiedBy: AM9P193CA0018.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c]
 (2a02:908:1252:fb60:8ca4:a46e:6aa7:208c) by
 AM9P193CA0018.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24 via Frontend Transport; Tue, 30 Mar 2021 10:40:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f3ef04c-b3fa-45fe-ccff-08d8f3683f10
X-MS-TrafficTypeDiagnostic: MN2PR12MB4318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB431820894BB9AC01A1D8F021837D9@MN2PR12MB4318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tyL/Hi8xUnxvRM/1cT0YtrzKvOeb4pcxyFAui43l0XRDhrX1C7eHvlRTH1p7NKT91AgrkNDTYoFWeIGq/spZiWIGUaCHl7o8HwBqkXnysrXXNlubHb9b8hDHivQ3JxL4sqyCT1BAC8Bnu/t7PfOwSf29SqL2m9MiJWNLmBA8yc2bZ1cYji7Ixij49kyiMGFwZBHc3Xki/LskhOY5q2wvhX1tY2wvczftKjEamkZkbtCzxvK9dlExRzADgjC4+mmIN0rwjGrdChgvEQJWFCVjHJxQzbQ81uSC38iKI1NfyiKIq3zL/QXV+xXxM7AEP51kGN1TzmQ4IvyjpV3rtqjUonlECmpoBMeuNVfPFPxE27TEdfKHwffwk+sOl+cFY9pc3YY3itHEYMrxji8gqTWmhtfnmOO19Mvo0pTioEKXS3z6pjFvI8Duba+RfoJ7dnZJfD/hqOeItEFjWH1npQrWQsUtjOeV0Sib0MHl5jBrrTK9wEFEzghv9u1DqnpUWOUlTWZeL1eavCbHu4Ah/ANyMPTkKwYy87w4TBaN/RlwOdX8Qe6KEQ8//vDDfPkTATekQQBfQDq8i54j8+sbUCMeiQHWJhGckx8pnzpIVuOYCUAS3GRctxHk/M6NSjpUjdK5ApNfCrbvKr3OcAfnhvigitzWFjlKZ3yQ9EwKZg7vjhZiPqo2ux0XOaxk1AbVehxmEoUotM8wdHWKUMnxPU4JHe8/KzDeKjUcG94rDgMKEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(31696002)(86362001)(66476007)(186003)(478600001)(66556008)(16526019)(36756003)(5660300002)(66946007)(52116002)(83380400001)(38100700001)(31686004)(6636002)(6486002)(6666004)(2616005)(8936002)(316002)(2906002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U280d3BRMXFpODBVb1NUa3VyOXdPZTREVFdUQTVtU2lLQTZjUzlrc0tiNlBu?=
 =?utf-8?B?U29ZVjZLTDVSaHNCc2htMzVYTVJ4WVhJMkhNbGlES0FnTS9BMDNreVdVaXpz?=
 =?utf-8?B?TzZqUXNuY3RLK0lIV3hvSEFqSUxvYlBKRzJYVk4wa2VTS1V2K1RITFN2aUd3?=
 =?utf-8?B?ZTF3S2g4U2VTOXArdWJxcENiWjdRVG43VHNWd2FtdGN5ejZxaEdJbUxTSzgr?=
 =?utf-8?B?NDNQeEg4VllubGJTeHN6bjRHMVZRY05PVFB4SFJtbTdTUldNbjI3K2FkMlVS?=
 =?utf-8?B?UUJ1SzlXaFBMMHp3dXc3aW01WUlwYll2MHhyWjBZb3ZoKzdQaTFuNHdjL24z?=
 =?utf-8?B?OUsvS2ttajl0Z3p0Nnd0YStmcitGaGtDMFVISnBnV0tCam9JdGlxOGk1U3V3?=
 =?utf-8?B?VldKSzcrUlpXK2hBbGFHbm9ITHNxYTRpUWhscHJBNFd6OGQ2UldNaStmc3Z5?=
 =?utf-8?B?Q0NxUm80dFNjbGl3bG0xb05EdWlkcDV4Qk9iRkFxNUdzQ2tPNkhUUmxFV2Iv?=
 =?utf-8?B?OC9YN2wvYW9NZDAwcGxnNlVuYzJ4dFlJeWxMUW5sYWU2dnlpdWlxU1FJZ1NQ?=
 =?utf-8?B?T0t5eEdKRlJuc0w4MWxzODRoekhLOUQ2UnZ4WXJlaFp4VGNrM2t4S1FxVTRR?=
 =?utf-8?B?MGZ6V1U2OWp1NWtyL3gvdGYyMWxqZHc4VVpIcGwrcTRrWFZjS0N4UEVXZzYy?=
 =?utf-8?B?WXl2dG1PbzB5LzRiY2t4bzFPbWhFNVR3WU9VYzV0MGh3NVpNRlpUSmNZamxI?=
 =?utf-8?B?eXY3YmVERGJWQUdGZlFLRzBTTTVlSTN2UFVIZWVhYnl0ZGFkZVh5QjJOVEhK?=
 =?utf-8?B?M0FpclByd1Q1TFgzZXIwd0RxMXN1SVBEZEpwdjJUZUVKN09BYy9EM0ZTcGlz?=
 =?utf-8?B?enBaeDd2TmNBVXJab1lCM2t2SnI3ZUNQTnRueXdZTDVCUGMxME9KM20ydG1G?=
 =?utf-8?B?WkJURGNTRmkyUEd5VEFldUJmeWhqa0l3ZmQ1ZGxwNy92d0VkTmtkMXYybVZD?=
 =?utf-8?B?b3BnS3JzK1kwZVlWckg1dVovWWk5NHJRL2Q3MHFZM0hSd2VzQ3JwcGs5T3hZ?=
 =?utf-8?B?MHlsRk1DWGNpeWh5SnZnL3JicWpiZWxzV1JSeFgyeXQ0N3FScW5NbWo0aS9Q?=
 =?utf-8?B?RVliOU9VbGwzTFhrdjVFdVV1NWdFOWtiakptbW5iTTFtWW5VeWVQZXNhRUdz?=
 =?utf-8?B?MHdZNGpveFI2amt0aGVkbVNLaGQyMEpSQXNuckJzelBYbXBkVCsyN05VT2JJ?=
 =?utf-8?B?cGhqNGIrb0JJR0ZwTWRqakhMcFFoMm1pcFdMc0VMMlU1RFVRaEFGaERkMExO?=
 =?utf-8?B?SGxsK1lYNjBmNFRCa1NZbXU2RTMzNlBsbjUxK1AvL1I4cjR2N05nMXpEVG0r?=
 =?utf-8?B?VmRGVmdGSW1qUzNFK1BPcUtwa01FVHR4bEc1K0xQTTQ1eXdYVzFzbnh5S3dR?=
 =?utf-8?B?VVNIb2NrYXJGY2ZnMzVTcWNNMlZpNGdCYkZCYm0ycEhpelRRa2RyMkVwYjdE?=
 =?utf-8?B?S0N2TStPQlFpWHdGUGxJZjNiNFh6SURmOXYycjZOUFVrdnJlWXM3M20xeFdw?=
 =?utf-8?B?Vnp5ZG5TeElmeUZON2Q0cVZKa2dENnJ1cm9Bamk5ZFl4aUJ0OFkxZmlCcDZI?=
 =?utf-8?B?OC9LN1ZjMVg0b3M4eERrakpCVERpdjlrL281K2VjcVF5MHA3K2RJamtpeWd1?=
 =?utf-8?B?NzJqWC9OQVNYKzlScnNmTVZ6aXdOVUsrbmVrQ3h2TmhpTFhEOVU5TFBvdS9L?=
 =?utf-8?B?dnEweXVySk4vek5PcUlBQ1MzTnF2eTFNaGgxeE4wa1Bhb0NpMVJVSnY3SjhJ?=
 =?utf-8?B?OHgzeXowR0J0NFQ3enBqV1cyNWdmYVZVa2ZCYVEzQnNLZllpbEkwdWduVnJh?=
 =?utf-8?Q?GeKzA0jgo05t9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3ef04c-b3fa-45fe-ccff-08d8f3683f10
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 10:40:33.5088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nncI2qh/s5tNOT/pjvA1gKVz2UTjcNuzDgIrmDWLZck7xYYpAJUIhqQszibXQk/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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

Am 30.03.21 um 12:02 schrieb Guchun Chen:
> warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>    int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);

Well there seems to be some kind of bug in the compiler if it complains 
about the code below.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 722efd86718e..2a6fc0556386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -824,7 +824,6 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>   	struct amdgpu_ttm_tt *gtt = (void *)ttm;
>   	int r;
> -

Better have variable like "r" and "i" declared last.

Christian.

>   	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
>   	enum dma_data_direction direction = write ?
>   		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
> @@ -861,7 +860,6 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>   	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> -
>   	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
>   	enum dma_data_direction direction = write ?
>   		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
