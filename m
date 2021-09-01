Return-Path: <SRS0=BBbY=NX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6A8C432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 17:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4C061090
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 17:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA4C061090
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 446CB6E22B;
	Wed,  1 Sep 2021 17:54:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B436E22B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Sep 2021 17:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTOc84GgpVRFfQO7PbCsrn5MBTt/0duH5kHnU7aCbyfkLskdqZ0uDgkJAYGkEMCTQ8+A4APV4doo54UfV7ZTYYXDdcyQErH1vTwft4QHIWJEU+5cXMr+HaOd+ghtjGlEReYeZETlHBhCq1vsq4hiC7rrSHvB41nT2UegKl0+1EUBUP6rO0FrXp3c+nZG/wnN9Nk24UbZXLiFtgMMuluoq+RXo9BGA+xjZ9QGmYT3Vi2xdtEKdb5oa3yo3Gx8wZ9STCrIlqg8Oua/XLsfQf0x1YIoJx+DbNUy29BWyu53uC335oPbvPkVOzzdugrkZYcHcM7U+XEmE54T5wHd/bPO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ihoWLgM2/Pf4pfRxcghMpqyNID6y1LDRv61Gd1JOVBU=;
 b=Beec3dGmxkvtc/+AlyRL+2rh0ggg05fMQMFwpfGPBveqQH6d54I3wXBuuBWS8iWdIInmqwhb4lgFEeGb3e8zcEkLo6jQwJrKF870IrTIQ6EmFT20jLUyyCkZEzk10uiPHeTewa1n/7Zb8k6XrmSC1nbm7hXnLOpI7adbwN+rz7eEOsOVyi2IQqsFXGU6m62UEd99Myt7sWOT49s5aLvHqw4OJBeGVR9ivp9sdsWQWOGQ1DKd7yk3friIzo28EyHqUO24/vftBMrOFUTm41LQ+zp5QTdigLfo2EpyPkvrZ1Y7ChB28wCnfiDi9W7bzDUZ40CZBAfMKMC2mBNS5KYwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihoWLgM2/Pf4pfRxcghMpqyNID6y1LDRv61Gd1JOVBU=;
 b=O1yG9SkuiAok9JgyWbV2W+z3HtfKYMnGJyQTbJGtaxJ0jGsEfQkBCKHyC7SB21ZNofd6GzZGOEY7M0DybaZzDkDotAdMDx7OQBS+L9seh22RRmGEz38gnWjK39QRnCUi+uCmlqnwNBVIWifcd8LioYL3h0YnHGwhQ305lgnv0kI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5276.namprd12.prod.outlook.com (2603:10b6:408:101::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 17:54:10 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 17:54:10 +0000
Subject: Re: [PATCH] drm/amdkfd: drop process ref count when xnack disable
To: amd-gfx@lists.freedesktop.org, "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 Alex Sierra <alex.sierra@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210901024121.23964-1-alex.sierra@amd.com>
 <b690d7a8-6c4b-fc52-0076-7a8c0bc7a391@amd.com>
 <DM5PR12MB4680D1A4C08DBD7DCF72120985CD9@DM5PR12MB4680.namprd12.prod.outlook.com>
 <813b0a09-a81e-3d0d-0342-eaad81f67f8a@amd.com>
 <DM5PR12MB4680F859F8CA637B9BB9B35185CD9@DM5PR12MB4680.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <69eea37c-e36d-0239-962f-c7908d72e778@amd.com>
Date: Wed, 1 Sep 2021 13:54:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM5PR12MB4680F859F8CA637B9BB9B35185CD9@DM5PR12MB4680.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::28) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT1PR01CA0119.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 17:54:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4237d2a0-d7dc-4da2-de5f-08d96d718011
X-MS-TrafficTypeDiagnostic: BN9PR12MB5276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5276D730DE9B267ED4AEE19692CD9@BN9PR12MB5276.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2KTBNVbGHRf2aDwy3YeiOlCaW/4A1G4iMw0gY+5pSKGG46epb7XO8r4z/ZKwhXviEnJySV2CJHabYWGK3uAFEo3swOcTEfFJCPPVfveNrzzTxgk+5tbp+jb1v7pjA1AgGEWVvyIb8OGJzMvFgy5oxSuJi/CCHiXTc2SW75lwjj0bUm5DtO/7XwxJzZdN5aofr2tGIFKtPmKiDVt/+j3F7oZTm6KcuHm02JEtCYmG6lO04sRYu1q28Dsdeh3F6ewpIORBHK7eNuV+YLi6THYP3H3XlBC7v2fXW9q6DlTEonXa4DnL2W20lBhIWowSGBv64JvbRgoYRIHQtOaPkGgT2Yno1YnxLQnWDWS5tmh8hShgV6a22C8ivBkSHdjRsYzHR1CzxWY/aWjllW4dSB4Jgmf+S912CtQXOxqqcXwDXTud22X9ikJB5pWhVuMB33hiwkQKGvscFcsRUMfbfZ6vRWhq5e1cSNAuCQCR1Q0+EcRZlzfA+1MEJxIIHYLqKkbrPidFYvGZekFe/gf/E88iIcKDoh6RgAe4C2flHO9uHgTwpKzFL393TGNhc0lg6uSCtInMwg/V5cBYrRX74TyCfoglKrYc1xcMysDj5MEkUpYURb8fRgjGn9EYS81LI8dkGteRZsCbT1vm3L8xT4qNiZu1dpXl+vSbLz4byzTNUdMh/jtBNPfYHQaBMCLgWt9Ft6xQrKU/e9FRaK22PtpPYLXwo6rFIpFcV745GFb9+Dk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(2906002)(38100700002)(478600001)(44832011)(16576012)(956004)(66476007)(8676002)(110136005)(66946007)(31696002)(66556008)(5660300002)(6486002)(2616005)(186003)(83380400001)(26005)(36756003)(53546011)(86362001)(316002)(31686004)(8936002)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkRQZjlOQWd4b3VMTWR3RHMxcDdDMk5YdWdKVnM2amY1K0xwbnBZRFAyS244?=
 =?utf-8?B?bENsTU5QNUR6SW5QQkdEa3JxcnBSK3FUeGEwWmt4dzBJTHN4Y2t2MUtEdDlp?=
 =?utf-8?B?NDBSOXF3am9SYkxVQjB5UXBKcnBFV3EzUU5pMVhzelRvY1REQUVxdkF4REND?=
 =?utf-8?B?SEkwV1hpOFVGM3FTdnJwV2FWZ3VhM2dQVmR2eENmVXV3bnJaanBDenh4YUlC?=
 =?utf-8?B?V0Ezd1hXdThUNGlNcHdTVzBVMVgvamZlTFhSdkNKUFo4YVJVbU1nMWdwNGIx?=
 =?utf-8?B?Wis2bXV2VmZOYUFCczBUVGozTlBZSXBvcnJNR1FYMmY5WVcwMGtxM2cySTVO?=
 =?utf-8?B?djNFSHR6SEE5SUw1OHE2eTd6WEpjV3Bmb3pDMmFTaHZNd3YyR0ZqbWJEK1c5?=
 =?utf-8?B?cmdzNVBEbEpYejZCUXhrSzlvaWdVS0VOZFNqb1BuMWxUYVRReWh5MHpsL0l0?=
 =?utf-8?B?TFlFbzZiOE9pZnRnWkRpSHFKMm04eEVwVXdRYm1la0NEYWRjdXBKN09aUG5M?=
 =?utf-8?B?elhRZ0NWQ3ZSZmVzTUJZdVJDZ09CcnM3Q3RZeXA1dG5lREgzQjFrMXhuK21Q?=
 =?utf-8?B?N3dYeXp5bTdaQ1pyRGhab0IrQ2xGNXA0ZmNBNlltZ0YxcGNNN3dGV1FWNnRU?=
 =?utf-8?B?R0lVOGNyME1lMXdlWGJYMG5OMnZQcFI4Q2Z0SmN4b3lQaTIzVXVWU2RKdjgx?=
 =?utf-8?B?UVlLMlRVSzA1STYyTDdsdkZFMzhRQ1I1bjVuYTYvbHFBRXZSL0puK092eWsx?=
 =?utf-8?B?OWhqQXdwRGUyWDZhUithT29Yc2RiWi9Gd1piOVc3VWJHcUUreXorcmRzYUh0?=
 =?utf-8?B?bEpJOWZQUmxFWTJiOGhac3RTaHhVUVphSjRRbG1BaUpMWFptNXR4Zk5RNmgr?=
 =?utf-8?B?Z1l1R3hKNFowVkIwamhNWGQxT1dCS3dOYWZ4enVjQlRTa016cVVyNG5OQ1dp?=
 =?utf-8?B?WlpyK3dtZEdUNkt5cmozVm84SVBWSlZTNGQzZTRjUXk0N2REZjJqRnFacEox?=
 =?utf-8?B?ZjVEYTVBSzEzYmhzTDltTWhEQSt5OGIvcVJ2TEJkVGx3a2VZQXRsWnhXRnVv?=
 =?utf-8?B?Q1NPY2JJOHBCWVhaTTNjMTk0UlFoNHdOVHRVNVYvZHltQU1qSmMvblNscWRV?=
 =?utf-8?B?Nld1MzhxbzZQYUxCTUZhRzJEdlk3NGlCU1NCSmV0WjRWczgyZkYxUXVmekt5?=
 =?utf-8?B?S3VVQ0hCYWdDVWovcGR3MVhYN0VXQUc5dHY3YU9UaWphUnBWQmx3M21EMHN6?=
 =?utf-8?B?NVFRNEo1cGV1Sk5XSjJSNzZXQ2Irb2ZTcTNaVkF6RGVPZmRTUWNzZFZVV0VP?=
 =?utf-8?B?dGk4b203UzdNSkphWStSZ3NsM0pUcHlLZnpSWGRKMEY1VXA0N1Z1aWJXaW1Y?=
 =?utf-8?B?ZSt5K2VibURvWjBGTHBaeUtoTWZqYllVWThtLzAxN0ltM3k3SUgwck9XV3hV?=
 =?utf-8?B?eDdLdHp3Vk9nUXAvcFdINllEVy85cXFLNWZzbFpjSHBwTHZoTTFWV2pUdjd6?=
 =?utf-8?B?bXpPNS80eHpHTXZPUVRpRExDdmJ3WXZUMllZckZqRDVZSXlKYlpGTm1KS2Y2?=
 =?utf-8?B?VWEwbXk5a1VuT2x0VkRraDg5WEg4U3MzMVN4R3ErQlhKVDRxWStPRk41eHZV?=
 =?utf-8?B?QmlTbnFVaGp3VzY5cDRKT2NRaGQxakt6Skw1OUg1b3h4eEQ0R3FWMWhVMU54?=
 =?utf-8?B?UmdXWTNmNEdYdXN5bHZaVjJMeHpKejRkbHRJWWdqNEVvL0dMVDVsaU9KSmMy?=
 =?utf-8?Q?UXAzk2/lBkSiTtpDYdJzr676ec9JuK36QvN8531?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4237d2a0-d7dc-4da2-de5f-08d96d718011
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 17:54:10.6341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwiT4amPRlkKqpFHtn5vhFougs9oeTCcIOKu0wKJtLWZDAudIxPzc/ChuCmkRiDgFTlBfcGu9YCxooqsMmKnxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5276
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

Am 2021-09-01 um 12:59 p.m. schrieb Kim, Jonathan:
>
> [Public]
>
>
> [Public]
>
>
> I wouldn’t know if it was another bug elsewhere.
>
> From what I was seeing, the leak was coming from !p->xnack_enable on
> the svm_range_restore_pages call.
>
> If it helps, I saw this on Aldebaran where a shader does some bad
> memory access on purpose on a debugged ptraced child process.
>
On Aldebaran the XNACK mode can be changed per process. But the page
fault interrupts are retry faults (until they get turned into no-retry
faults by updating the PTE in amdgpu_vm_handle_fault). The retry faults
go into svm_range_restore_pages before they realize that the process in
question doesn't use XNACK.

The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> The vm fault prompt pops up in dmesgs and a stale KFD process appends
> per run without this fix.
>
> I’m just assuming at this point that the IV retry bit is set but I
> never confirmed that.
>
>  
>
> Thanks,
>
>  
>
> Jon
>
> *From:* Yang, Philip <Philip.Yang@amd.com>
> *Sent:* Wednesday, September 1, 2021 12:30 PM
> *To:* Kim, Jonathan <Jonathan.Kim@amd.com>; Yang, Philip
> <Philip.Yang@amd.com>; Sierra Guiza, Alejandro (Alex)
> <Alex.Sierra@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] drm/amdkfd: drop process ref count when xnack
> disable
>
>  
>
>  
>
> On 2021-09-01 9:45 a.m., Kim, Jonathan wrote:
>
>     [AMD Official Use Only]
>
>      
>
>     We were seeing process leaks on a couple of machines running
>     certain tests that triggered vm faults on purpose.
>
>     I think svm_range_restore_pages gets called unconditionally on vm
>     fault handling (unless the retry interrupt payload bit is supposed
>     to be clear with xnack off)?
>
>      
>
> yes, with xnack off, sh_mem_config retry should be off, retry bit is
> supposed to be clear in fault interrupt vector, we should not try to
> recover vm fault, just report the vm fault back to application and
> evict user queues. Maybe it is another bug cause p->xnack_enabled and
> sh_mem_config retry mismatch under specific condition?
>
> Regards,
>
> Philip
>
>     Either way, this patch prevents the process leaks we seeing and is
>     also:
>
>     Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
>     <mailto:jonathan.kim@amd.com>
>
>      
>
>     Thanks,
>
>      
>
>     Jon
>
>      
>
>      
>
>     *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>     <mailto:amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of
>     *philip yang
>     *Sent:* Wednesday, September 1, 2021 7:30 AM
>     *To:* Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>
>     <mailto:Alex.Sierra@amd.com>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     *Subject:* Re: [PATCH] drm/amdkfd: drop process ref count when
>     xnack disable
>
>      
>
>     [CAUTION: External Email]
>
>      
>
>     On 2021-08-31 10:41 p.m., Alex Sierra wrote:
>
>         During svm restore pages interrupt handler, kfd_process ref count was
>
>         never dropped when xnack was disabled. Therefore, the object was never
>
>         released.
>
>     Good catch, but if xnack is off, we should not get here to recover
>     fault.
>
>     The fix looks good to me.
>
>     Reviewed-by: Philip Yang <philip.yang@amd.com>
>     <mailto:philip.yang@amd.com>
>
>          
>
>         Signed-off-by: Alex Sierra <alex.sierra@amd.com> <mailto:alex.sierra@amd.com>
>
>         ---
>
>          drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-
>
>          1 file changed, 2 insertions(+), 1 deletion(-)
>
>          
>
>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         index 8f9b5b53dab5..110c46cd7fac 100644
>
>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         @@ -2484,7 +2484,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>
>                  }
>
>                  if (!p->xnack_enabled) {
>
>                         pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
>
>         -               return -EFAULT;
>
>         +               r = -EFAULT;
>
>         +               goto out;
>
>                  }
>
>                  svms = &p->svms;
>
>          
>
