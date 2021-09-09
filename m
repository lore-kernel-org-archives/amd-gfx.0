Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B1CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D86560E94
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D86560E94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93436E44E;
	Thu,  9 Sep 2021 07:14:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A7FA6E44E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 07:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPuC3PljXlcPKAEwZtDzCd5wrH90LIOMqG8ZzF5ZlX892V5sJidU+qz2tnJhGewnT2odlMi6DNmvG1qjljzxE6dP1X5hSroj6b2a5jrK92rWrkw6gZCJsQ3X3O3WnIWvWBSSW7B4M8a7/s7TmD3YI9NArzrGkniTDvJhcVE/ytKkIaQC3fiY821hivlzi6Aa8YZXwWVbad6X6Q6UMJqAdx6cxS6u68OCAKijp70HWnkule7KJi3/LzNcGLmoGJpsMQ7qIcC8Gd+Lp+o0P1FgEDjmxIgYbN+E6YSNotjlJNVfIHypscNRefiwDFjgrQVnTHvULXcw7oIMn2a1xzP1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=c2V0yj56ya4SRV1aCzbJ+FONHhJYoOWCjP5Fr64gPFk=;
 b=WT4DAanFhvEhUCRpd//QJG1KxsQyIJ1ztErEv57+UIcDVME0lZ4BDzV1ziKRiAf6RI0KH7yRI1Msi0ihz3VvPT+ecJHPMbsgIzysg+p0uEE2NYKATVxLumlvHZikRK4a+/ObohV1gU+DS48pI4J1ktZ4nLJa2y+4tiGK6bhL/dR+egqE/t+fyvRf6BhHdzVCGZW2Fjt1dmMMJi4KEHfdoAxBk3GElma+XsqlytWKG6UIC101ntsYmj3r/ZxrJ9y8e//Fu5YlRubT9u1PviC760eGuzvDaQIh32EhzX68PRk6soQVPe0Zsh+L1BWeVG4ZPNFQkX6fND5MiJE7S9gP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2V0yj56ya4SRV1aCzbJ+FONHhJYoOWCjP5Fr64gPFk=;
 b=Mnr+v9T8mrw4++wp9xIA+nurVKoNux3TZWaOGDDF++sxCKJRTJpxt/SeoTekua4lFXXoepnSwmbaqBYNROY4HWilx41pRwjJFkOG87TpmmYYb3ia8vI3jOchY/hVheDhqOQJjkLyOEHGWuWVcH91im2sDKsl/GTT/SPsjJhV1Bo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4740.namprd12.prod.outlook.com (2603:10b6:208:84::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Thu, 9 Sep
 2021 07:14:20 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.015; Thu, 9 Sep 2021
 07:14:20 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Increase direct IB pool size
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <DM4PR12MB5165BCC3E4E26C7EE4E85F3B87D59@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8c56cc27-a99b-3ea5-1bf7-59cad134fe21@amd.com>
Date: Thu, 9 Sep 2021 09:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB5165BCC3E4E26C7EE4E85F3B87D59@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0024.eurprd05.prod.outlook.com (2603:10a6:205::37)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:327b:a453:3daa:de36]
 (2a02:908:1252:fb60:327b:a453:3daa:de36) by
 AM4PR05CA0024.eurprd05.prod.outlook.com (2603:10a6:205::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 07:14:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c74c3e73-aa5a-4723-65b8-08d97361715e
X-MS-TrafficTypeDiagnostic: BL0PR12MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB47406FF663F540D1FE192D6883D59@BL0PR12MB4740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NBJuEJD8IjtHAl40v251brtWXNY4Zff5UWSsgG++ZblNm4ojJUvLBU48IYJpR4fbvxUMhHeiis/jIXQIRzQkwFynLfCed+c77OEnixUwS2ccRByfE4a6txOqcRlDEUtaY36S7SerXeHavRDWptJDIbwNz4oJ4UyoSnudag7lk97T7tKFA9AAGpkMZGHgU//iV3nxqcLmss/hVeqWB8JWGmQVkNG8M+S2Hl8K0hj66I86Lam+703g1rc27JkTwbsrau7kso/Xq2gEu9MZa6HUXA57mh14dyFhoa7Slk17y6nBnyPde4Tg0nfViN8uAxMipVoVhiy6Iu9HabpEGLI4icNYBQNUImpuFUD8Z18lPmsTOVa1WvMloMQksSm1MDAjZ0cXLpCd1kZkYVjnAdAV85icoRXjYxgKUFYJcQ4VhpT+9fNffKx0dq/OOPxbpvIAAjI7Z4PsUuSwcX2kFCXStjZRNaTh6Okc11r/VbH7UfVJAB5Xz40sHux1kaZNBhlNHQYWEZ7PgBK+w5FesH0//+d34eee0Tqv+O6zAJZlrPkwkerWtG6Kyee98Jqmuhqhf1AZ5hZejT6kG4UyiyfT2GEzfTW2j5yREe5fcFpMc6vov3lFFJFpvAPH+zr3o5+Uo4VuTvQjbZioYvzcv+f3Qgv+ljd9Eszs8WdHTNNPHx5+yUqhZmwDLNv476tZ5di4cEQzxRwNsmPIuYhWEMIJtYW+adWYcidIUs1ROuM8Qulk4uOT/OpKWuRSgQ3hjfn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(8676002)(66476007)(86362001)(2616005)(66946007)(4326008)(5660300002)(186003)(66556008)(478600001)(83380400001)(316002)(110136005)(6486002)(2906002)(38100700002)(31696002)(31686004)(6666004)(8936002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?aEZNeGQ0dU9salAra1VVbnlxbnduV2gyb3VJYzhtZVZCTkZrdk1JYUxzZzVn?=
 =?gb2312?B?WERiakZQbGl6VHQwU3V6TmcyNnBNbW5OK0FOOExwWGhIYmtXWHVLdHVpWkYx?=
 =?gb2312?B?YW1kK2VsMEd2SVVMVnNMM1lrY09iUktqdG1Jbk5wOG5WaTNiOTJjdVk0Y01Z?=
 =?gb2312?B?Y1ljSGl3azJwZis3WGZjR0llWWdFWU9kdXQ1RlhXWWI2REl4d3UxdXZJUHBK?=
 =?gb2312?B?aXB6RmRRQnhuNGlMbUd6cnJQMkIycStmd3RXcFBhckZUM3pUUGJBZXIrbWo2?=
 =?gb2312?B?L3JnRTZNM1pCdmNhU2ZwM0RIaWhXeGpoTjdnQkdzajYyRnlSTjNRSENPbnFR?=
 =?gb2312?B?bDA5SjBCQmt3WmM0MnNac1JxcUZRQVRNd0NDNzBuclMwd0pSdjh5RldrY3lZ?=
 =?gb2312?B?UENBZ3hWMkVXWGlWZXk5dXFWSXRXTEZVVlhGQ0dvSzBET1hjalFYUnAyTXVO?=
 =?gb2312?B?SXZQVmJ3ZzBiN3dmVXlrV3ZzOUNodzBaVC9Jb3hadjNENDNQV0twVy9GZWh3?=
 =?gb2312?B?UXNaZXVyeE01RDUzVko2T1B4aTFsK1RIWEJ2VG9Va29OaUFMemlrUXlVUmsx?=
 =?gb2312?B?MlVvWDJpa0xmRXB5dXgzT0hGYU55cklqdjAyeG5LZGY5dlRnM2JlYXBtNWEw?=
 =?gb2312?B?ZTdtY09Kd05KbUZYOUdXZTV6ZHpuTi92SzgzRU5BdUtGUHBUZC9sTDRVSmVv?=
 =?gb2312?B?T0RqdFBRYXFpaUhhSnVNeXZHK2JrdkxDaVFWNEgyVHZSbmM3T21aWFdyTkI1?=
 =?gb2312?B?M3pPc1FZOXNIajB6RWNQV0VTV3AyT2NUbzRJbncwd1lHbjA2OG9wU2Q3TlJt?=
 =?gb2312?B?NWR4ZUc0MlZHOGN3RTNSaW1hT3JmakdEQm9EczlLRlBUTmtQdmpQRHVBa1N2?=
 =?gb2312?B?S2laRDl1QzA1dmpjTjVtOEdBR05GNlEwV0hQYXNyUTBoVjBLN1pSdVBySFZH?=
 =?gb2312?B?UG9CRFBIMFI0ZjA3UldQNXFuc1NTM0tvNkxYeEozeWJJZW9PU1FnNDludW1B?=
 =?gb2312?B?aWVKZkV2RmRGblVsbTJkOVlLcjZDU0Rjb1IzQU9EcGZna1BLbEJUTmc2UGor?=
 =?gb2312?B?eHlIVHh4VnZCZWxzbXRBb1pGUmp3NkVUenlEMnIvcWl0ZDYwenlhdC9KRnZR?=
 =?gb2312?B?VFFaYWp6R1ZJdTl6ZzBjMGw2SFlxYWl6MDQwc1N1ejlIYm4vcGN0ektBTDkx?=
 =?gb2312?B?bG9vaitHVG5sNVZXM1pTM0JxQm1raENnejFCZnJSVHM1WmpoaGxpc2hjRDU5?=
 =?gb2312?B?REVKRXg1MWtYUlM5MFpsMUZseDN5ck9hbGQ3WS9vZk5ETWtQNDUzU0U5ZXZM?=
 =?gb2312?B?d3BzVTZMdUJKVmFleTk3TW9qcnFjVUllUUZVbWRYSWZ6b3lxeTFDVVJNSnBG?=
 =?gb2312?B?WUZwRXErV2lSUzQ4TFlUWHpGYXdsUDFkQkQ0ckhXcWI5SnowRXBIOWdBMjhn?=
 =?gb2312?B?Vk1sWDBQWElCSm0wUzRTS1BqNWl1MVY2RDBWUFRkV0NHWjFrd2luU0MrcUdG?=
 =?gb2312?B?RHpVb0ZvL0pkU3M2YVYyclNzbnNUeGljNnArVGMyZDd4dFpGU3YxTDVKNFBW?=
 =?gb2312?B?cTNFamNMV3FoTVBGV0tFcEUzS1dBT2NpUFhsYlZDRStpckhiVTlkOEFIZjF5?=
 =?gb2312?B?UU9iR1NKOHRGTnpjeE1rZVpkck1rZE04bEt0enFaUHZHLy93UjF5eWliTWNP?=
 =?gb2312?B?VkRYTS9LeXhQQ3B4TUk0bU4wbkhoMmlDaXpJQ0syYnFoUXppaFMyek0vV0pp?=
 =?gb2312?B?b2M5QndVdTlMb2NhSFEvOVlyajYybGlienhFeGtTckpCN1B0am8xSXE2cmtM?=
 =?gb2312?B?Uk92eFRuSEZNTGYyU0JFaFkwVzcwYWZ4N1B4T2NEODlScUxzMjIzYk9YOWl2?=
 =?gb2312?Q?ea8pjTObhEawq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74c3e73-aa5a-4723-65b8-08d97361715e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 07:14:20.1808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd3Ob8uFoh7jPSEkd6yXQe+L6LRNRSybHTLpZ7/V+joETuhcmKLtBAr3IIjDR3zM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4740
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

Am 09.09.21 um 07:54 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> Direct IB pool is used for vce/uvd/vcn IB extra msg too. Increase its
> size to 64 pages.

Do you really run into issues with that? 64 pages are 256kiB on x86 and 
the extra msg are maybe 2kiB.

Additional to that we should probably make this a constant independent 
of the CPU page size.

Christian.

>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index c076a6b9a5a2..cd2c7073fdd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -308,7 +308,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)
>
>          for (i = 0; i < AMDGPU_IB_POOL_MAX; i++) {
>                  if (i == AMDGPU_IB_POOL_DIRECT)
> -                       size = PAGE_SIZE * 6;
> +                       size = PAGE_SIZE * 64;
>                  else
>                          size = AMDGPU_IB_POOL_SIZE;
>
> --
> 2.25.1
>

