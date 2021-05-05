Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C097C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 20:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C844C60241
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 20:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C844C60241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D8B6EC3F;
	Wed,  5 May 2021 20:11:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65E56EC3F
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 20:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEOnPy+2oqZDKs3A3vHgGOPJmxST4hDn9ncvrxxV/jR29Q76OwbzVfz1oNsRk9rj6g4qd4VIzt0m39QtrTa0iO0jVw+qEx2GVtAuRqgtgNnTBYt4gA++boBu41Dwq381so/ywJoujRy1CDsih2UtTyThqwNuUUMrius7T4gteE+GR5kMow7/0z/5o71msCPHL8o4Tq8n8SVcNqsL34FWvibp/d/5S3hlb84bA8hgB4GTRt+5M2HZrbW5hPevT5EO+pOMMljB7CZNXaYR3zgh06bzI7l+2mlLyEkFTmM0xL6dNZdwNu5Efs83GvajHuOWq1rAkZJgsF6sd3vdB7vOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVrMzqEOOfZE3RXxh60pZTiHzFuiG8W6tSgcbi4Waz0=;
 b=b3MUhh7Ny0PkobDP3LZuet/GUJPOFgekbcBmAMsU4S4qoSGswWiOoEgYUrmMlCoiiN9Xa0SFLNyzzDOXELceQRfHBokX5M2ETcdD7r4hEycbKBKtl3WXCWv4CSfUBJO9bd2feaaw8PS5IeAPlDfhAvFwP33TnzfY6Kn6GFPJtCeTyaA8X6JWGmeTM6Ro653snVCa4TYyNNMPTyqo2EWqhkMmj5SrrOW7KzmNMggYRjuup3rfVg5SiCAGV1m8quVibHac/AZulYMJgol5q3SbYTZlXWMTta7X3KYw11CxSLp7ZbUcHWeK/OMVa7Sn7jzU7iY8/e8sAjC1Da3lxCExHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVrMzqEOOfZE3RXxh60pZTiHzFuiG8W6tSgcbi4Waz0=;
 b=bDiXvpGfX05t4emEHXmEFXU0iCI0Zy/BcWZ9oZ+dLj/lFVoyET6PkkxeRxrZYxTFGHoXDmKILenBxS/D532IlmI/XUG6BGm7TC3hukiMI8hvaP7X6SMASIeyoFYPM8tkZbH7CTkBJRDqWfUNv5kjJLBqD5v0G1Z8MX6YeOGPY+U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Wed, 5 May
 2021 20:11:27 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4087.039; Wed, 5 May 2021
 20:11:27 +0000
Subject: Re: [PATCH] drm/amdkfd: handle errors returned by
 svm_migrate_copy_to_vram/ram
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210505175529.30180-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f2dfa78a-156b-a6f8-2a83-24355e244228@amd.com>
Date: Wed, 5 May 2021 16:11:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210505175529.30180-1-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT1PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::14) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT1PR01CA0075.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Wed, 5 May 2021 20:11:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4ce3bd6-2c92-4c4e-1162-08d91001f70e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5161:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5161E95AEA9F2ABA9653702992599@BN9PR12MB5161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAnbcXpHs1huux2q7ddhbozxs+efCHsFJs0PVgJed8PwX/rOTo5uEozrgfwHn+cu63t0kdxKAo4LdVawzzqYYh+R8u6u8PVBhQPmiNmQOnlDaOKtRzFrSGclfD0bP2im6nloihqSHSWOWLFsTzvjQc7Mj6ozOWHKpnG6RY5VhIUGmxy6S7UslFakwUytwmcm5TqSzs+Kwt9T/ihbtlgIv9NQ8TUiIaG6tbCJDEH6XIfDBQAUnkiHJTX9xrPkvBYf0ut6IbV7UqGPEsWaDsYOGvQGJTADE280cOcR4Ga5TlrvA/Kt96A1226YFmig4nOfd95XPfmsT+n0Pgaf2LczW7YxYIUQyoUttCPuExc3EI/GrzDvGClvDU9SY5XyioJ9ulcCqb/jmYqu1UXmoA2Jv89PnIJxLv7M/roVuEaCqxhY2CSfSYdNqMe8oic90GNYYtYCyqtP1PK2WoOYYu9g46zUhohp7YSAb++tjQAQTh8GjUr5Qn68N+2lxd/iN1IeJlb9abrnBbUl1tavFTv0h54c/Z7XwwuG+JHfu+qirACnx7qxf05ZLtr5yk1tr4lOafBv4x5zYRDgs3D0zrR0YGC/zsYGotNb62N2qlhKsaY1hN7mWA3/Ux4o+Rd92JTjWLp2Yau7dB8JZc2YHkNtwE3lu4p97NWnAZnuxt490vYjGMk1aiYrvVmLmdQVmj/U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39850400004)(44832011)(66476007)(31686004)(66556008)(38100700002)(16526019)(36756003)(2616005)(16576012)(5660300002)(31696002)(86362001)(66946007)(956004)(316002)(8676002)(2906002)(8936002)(186003)(83380400001)(478600001)(6486002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NFJ3OCtvQ3YyTFB4NXNpRzEvcHkxc3IwUjh3RCtoUHdWVGV0cktxVVJFSlhO?=
 =?utf-8?B?RDFpb3pkR2dMUEIzQW5vcmR5OTBaVS9TRkJFa0toRmRycGhGRkYyemZTYVJD?=
 =?utf-8?B?eWJjK090b1Ric2hIbFdBZjVEVkhjaFpOYXBSUC8vODhFeUt3YkVOUWRGTVZC?=
 =?utf-8?B?SGZidWo0cEFwZXVGSnNWUGhOalgyVWdVMG4yaUUxN2NLTkNDcStIUUhnU2RH?=
 =?utf-8?B?bytLVVlpellONVpyYWM2czQ3azVuMWlodW1CVVcvTS9Fa3Zib0NHS3FJeHZY?=
 =?utf-8?B?c0hseTE5bWlJSTBjeFRPcitGS2NJUlJLOXhMQ0R5akV6eGdMdU9tdS9OMHE4?=
 =?utf-8?B?SU0vRU9oYXliR1IzSzRVR05rNTJxc1o4Q0IxNW1zR21MVFc2cHZCWUFmd1JS?=
 =?utf-8?B?a1VtUHBqL0JWTVlLbEt3bytmcjFvaDBIMVdwWXJhNk02WGcxK2VpbXZXemY4?=
 =?utf-8?B?bEQ0ZEh1ejg1eGRyNDFNWUI2N09VcWtwbi9TNG9XRDBkTXd0a2wvVjVKSnoz?=
 =?utf-8?B?SlJEK0RLbFBzejM2VGtCK2ZmeW1QSzN0TTFZL3cvMDNTL0tGZFBRV3FKMVg1?=
 =?utf-8?B?blpZTTg1ZFQ0a2RlY1VHcVNYamdMdmQ4dlRHV0JSMW9KczZsTDRuNTJ0eDlt?=
 =?utf-8?B?VytoNi9qdnpuY252SzhNem96L0V0ZXFaWnhZQVNGczMreUpZd1U3aGdXSTZO?=
 =?utf-8?B?SmtFWjZNeTZjaENmZVV3c21xc1p2Uk9lbXZUNnN1c2xvci9neUEycis4RTFR?=
 =?utf-8?B?NFZUeG9IektSN2JvTmFsRVFyU3U5c0F3Zm5tRFBWTXVSWFExNnZXa1R4cm1H?=
 =?utf-8?B?bkFjQnNPSENMOFROTUJ1bExibkw3RDd2T3M2SDhoWDBVc2VhUkRhMlR1WnF1?=
 =?utf-8?B?SU5aTG1SQ05ZR1daWDRNRlZCMDdQMGoxZGx2MjNmeDFkaDJvcmk5SE9DeFdQ?=
 =?utf-8?B?dVpDSEFoejRmWkZiYmdaU1NhQ0lub2lEMTJLVHFSWXpOK2VyMjZuRFVtOG56?=
 =?utf-8?B?OG1wbkhHcXdSNUU1VXFCZTJHcTgvREtzaVcxNERWOWpoVmFuTk5KQ1NrK0JQ?=
 =?utf-8?B?anJxbjBLd0ZrRzNhOW45RkFRWEgxYXNIbHJONVVTa0NLN2xzeWNFcU9HVk5j?=
 =?utf-8?B?dklOdDBjVWo4VnMrTTkwekFNVGFMYVRMTzU4eFBhVzk0RkFOV1QvY0pyeUJn?=
 =?utf-8?B?QXgycWdIUVpwNXpNUVZsdDQ1Nkx4SW8wa0g0cTZ0aFZmUXVweTN4bFhnZlA2?=
 =?utf-8?B?OWREK2gvS1pGVyszNkZyUWR5L1J3L0pqLzVMd1F2UmNzc0xXWFhRaEdIcExT?=
 =?utf-8?B?c2FHZ1VuSnRTcWlyZVFnaWllM1BaZ2x5ekJsT3h6c3JCUmE2RkQ4bXBjUk85?=
 =?utf-8?B?N1pWUXFCajNwTDNQZzFxWDNTUjFhNllwZzJOa1owYzhlc1ZYUEZtM1VFMTFL?=
 =?utf-8?B?WXBHQnl1K2JqeHlOdi9Id1poREtEUXF5bHdqbHhFOG1yVEtyck5HVXB0bXh3?=
 =?utf-8?B?bVoyZmhuTEtaV29jWEtzTTI1a1c2K2l6Rmh5UklLNkNYditTTmFlS0NxQVU4?=
 =?utf-8?B?cVF0ZmZNUUE4R0x5cDJUZUhCcS9uS0k0UFFDNmZkUncxbzRudVNadW5LUHFy?=
 =?utf-8?B?YWZEN0FkQTZuUkxEa3UrYzBrSThNWUhJMXlWQTZaaERYQklhQmUrei9VVUpN?=
 =?utf-8?B?U1Q2M0E5Wm8wTkgzN1REMFFFMXNZVlZnNmc4cjhkUmNNQ1NvRjJhQ2RvZVds?=
 =?utf-8?B?QVUwSkFrRGk2VE1hMzVMNVgwYkxoTkdnYU5UaW1JZk54bU5HMDlKVlZEUHNF?=
 =?utf-8?B?T1VrS0ZCeFJvbWxVeVAxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ce3bd6-2c92-4c4e-1162-08d91001f70e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 20:11:27.6507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6ksZTso5fbTOJOfU/CCddBVNF/hadWrDzojYZ7/AC1xNeVWTpmwEeyS2Eb/o5l1PGhqjftXuEwMj92kank3IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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

Am 2021-05-05 um 1:55 p.m. schrieb Philip Yang:
> If migration copy failed because process is killed, or out of VRAM or
> system memory, pass error code back to caller to handle error
> gracefully.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index bc2fc528ad58..fd8f544f0de2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -460,8 +460,8 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  	}
>  
>  	if (migrate.cpages) {
> -		svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence,
> -					 scratch);
> +		r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence,
> +					     scratch);
>  		migrate_vma_pages(&migrate);
>  		svm_migrate_copy_done(adev, mfence);
>  		migrate_vma_finalize(&migrate);
> @@ -663,8 +663,8 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  	pr_debug("cpages %ld\n", migrate.cpages);
>  
>  	if (migrate.cpages) {
> -		svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> -					scratch);
> +		r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> +					    scratch);
>  		migrate_vma_pages(&migrate);
>  		svm_migrate_copy_done(adev, mfence);
>  		migrate_vma_finalize(&migrate);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
