Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0D2C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 18:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E524964F25
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 18:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E524964F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577116E15F;
	Thu, 25 Feb 2021 18:33:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E6906E15F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 18:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLFTP2rB2dYHN+/WicQAw/1gZJmoaiAE4J37N/DvIgx2iN19K9fHrUKxh5te4E7ns8Dhke5oNMDBCD/GKU3/0yLL6RIRZalOrffAjeqqiEOUplap2WaMHwgoUQt+4Vfht1dqcGg8NTv/7+ECzHJWraRKJybmT5fJKgWycaNUk2lLEgBuT8wncVDgwbYQshD33QEHL0B9OtF042Kase3WGeo5BmQNxfagXdOPaar6WxE4qnTb5E//aOcf02RXHFzQqWhivdRt+liczw+WB3NR0lG2d7tDwhRzRJRi4vii7iRa+yWq6UPASQk12xfFKjFhZPDqvxZ2VKe2uRAVGnNTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou+KCBapRIsy7MaSrU2C8cS9HQwLwaSE4NAgVbxneMg=;
 b=KUVx3GdrquGycV5KU8Ej5Ux8GSAdWxqXMF8tR3yGttTpcHIoFKFQJ4E1VSAe706ZAVqP/vxh6CTJtYXmfnsm6a7dwasA3MipgrwdIk5dKqGnojEUDJHhwDdSSfCRttREC5jBnypy6WDh5V942RyQ4Sx8OFPldNpfg/hyPfqgRyiFUN+IRc6039lQfHp+NGytnj1xUa9kA8Retonnak2KWieHcKNpoa7m/cUpcQXLTC1ou94k5Ya4NoeiTq9D5SmZhEryaSdf8/zDpzVCCxqzDJRObSwR0zjFEJVLb771i/bvl/SxiN2BeVVG/oIo6dCshWjd2bHo/QZvQaWVPJ0rMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou+KCBapRIsy7MaSrU2C8cS9HQwLwaSE4NAgVbxneMg=;
 b=KidMkZ25ELpIALlpB+uuRL5yaIyIptGyXiA/aLgszhdgORUz/wqHoyeFjkpkGdKR91dn9o8rwahHeQrzkhEUe67ezoi6Vha13Z8Nn4LyHcZybEX7moVSnB6vRVeB0vHS0oNTX1EE9PkoEiiSVGvxHR9tDMM68uLmPMaIGHNf0Yk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 18:33:38 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.030; Thu, 25 Feb 2021
 18:33:38 +0000
Subject: Re: [PATCH] drm/amdgpu: add ih call to process until checkpoint
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210223211026.116403-1-jonathan.kim@amd.com>
 <6d30f52e-7a7a-5662-a66f-db832b8386ae@amd.com>
 <DM5PR12MB4680F60D6590680E40A90AF5859F9@DM5PR12MB4680.namprd12.prod.outlook.com>
 <92ddf2b3-3ee7-d481-2794-b57daed40ef9@amd.com>
 <8650a46f-f40d-d627-42a5-d9d760400086@gmail.com>
 <00ce83e0-a000-913b-57a1-53c07fdfcdef@amd.com>
 <23f02e39-4ead-a20e-5c5c-749b00fd400f@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ee8342b4-0af7-5c7f-1895-42582d79c4a4@amd.com>
Date: Thu, 25 Feb 2021 13:33:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <23f02e39-4ead-a20e-5c5c-749b00fd400f@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT2PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::20) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT2PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.31 via Frontend Transport; Thu, 25 Feb 2021 18:33:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97dd5bd5-0e84-4c79-3966-08d8d9bbde24
X-MS-TrafficTypeDiagnostic: MN2PR12MB4333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43333AAA97466ACDE9770CF5929E9@MN2PR12MB4333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xiYxEAE1FQ+7rFRERNC/05+LTklUk/An7ZgQOG7WqLfXLYfcmCh4VhstFwAC9IioQ2UIaoauAScnFupzXRsD/vUQGksq5Egp/Lu5a1alw+t2KdWiBiky8GBbPqM3mSPWHJ39vsQVRfRQZNezP1wyfoOVWP4M/oOGuyKmehBNa7O0SDnYXD7CiS+f6P5BUveqtod+h0AeJI3+MghzCXmwBZKjZdnxoqFVF4wdW+AyCNdF5k65S/sFX62upLXxMTQtoVZ/pNLQc8BEkZJKnmelXG51lSkwDwzA8lCHsQ7uBNZvCqrkzfYu6ZIT+c6TxNdaV8RjqyIPnM8gKPiP02PEXu8T1IYnto16um/kc1FHyzUVId3pHAbPE8kRSVXRpHxhPl0Bx+lYiNvM8fOlElUl933u/5/ycZRjlXXUg3YMhIIgU3RpvDR7SZD99l596aao8oAahoCyfTQv5r7aLUR7yUs5fjTHlQpEedqDMt69e18EJkwnPwLchZtva4RH4j2FGW7cwGX20n9SOswYcuqvj7qzjSSlltrSrjvyRwojgRsqzZAgXcOWtkE/WuUQxjaJKmJBhaB/49v47YAe8ta8ybrBTDRJdbu2YTKcVg4K+4aXPoz1mnlYW+MzNIs8fPACLbqXR6HY3YVU9YfSGP3Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(110136005)(316002)(8936002)(45080400002)(4326008)(5660300002)(16576012)(2906002)(44832011)(53546011)(8676002)(2616005)(186003)(52116002)(83380400001)(66476007)(66946007)(86362001)(36756003)(966005)(31696002)(31686004)(16526019)(66574015)(66556008)(956004)(26005)(6486002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TGpEUUtCaVVEem1Rb2Y1UzlvZzlSRWpOME1CcHo3WDNKV0xLVkVnd3BzSEdQ?=
 =?utf-8?B?Q2hQM0xUZ201YytKeTVHZDVsQnkwcU1sZ05zNlBMcWxHWHBEN1pzb1ZhRnBB?=
 =?utf-8?B?WE55YnFIRWs4ekFUUkJyaThRclkza1dhcW9sNnNqamtKMDRFSm1lTUFoOERT?=
 =?utf-8?B?VFFialI0aXJoNzhhNGN4cVFJaVR6MlFtZ3Y2K3ErUG5sdFlwYmpWTmdEQUtx?=
 =?utf-8?B?WGgvUDkwcklGaW1lL2ZXN3VWQzhQc0tpZTRZZ0VIR2xzYXVyM3ZZcXBKUGE4?=
 =?utf-8?B?RnpwL0RwYStHWXg1N0FqTlUvZkZXdDRGNkNsNnBUM2pJWDRicUpnU09WU2ZL?=
 =?utf-8?B?UGNSdEhoeFJOQ2E1ZmVxS3hEbmYycWEzVHJEMmVJVVNQTktLN3RQeGV4aHBu?=
 =?utf-8?B?MzRjeHlFM29lWktCTzg1MEwvRFZ4dk9LN3dERmd1REFFb2lqd3liS0dOeFVC?=
 =?utf-8?B?bGIwNE1ObTRiL0paN0k2ckppbEZ2QnNnZlhQcEx0aUNzQlhBbE9tVVlGOUh5?=
 =?utf-8?B?NzFaOThrN1dqekpzSlpLeUVwTzEyWjRjNDFaQVRzODcvMGlWQkQxWlh1Ykpx?=
 =?utf-8?B?L0NsdFFXODNBUjVWVEY0RlZlc2VuWW9XOFRWRHFNNFg2Y3BvQ2RnNFFrbTJz?=
 =?utf-8?B?SVVkNnhVS09hZE05SUhxRkxuSG1USGN6eVBTZll0RHVCMmc4QW11bWZoaVNw?=
 =?utf-8?B?eGNNQXpDL3dYNktSSWduOGlSNVNrQlE4bmN4RWtoeTZVam5kd0pjbUtmU0Q4?=
 =?utf-8?B?K3dlSXlkS1VVQUVLSDJiWjBjaFFKL3lOR1k4cjRjUCs4ZThSVlFWWk83Lzdl?=
 =?utf-8?B?QllUU3RUVERiRFBXU01UNzJ5S2s3NnZUN0tTY0o3enJwTFcrNmtQUmEwenhq?=
 =?utf-8?B?M2U5VnljdHZqT1hMcFlxOWE0SGliT3B2S0xYYUhMdisvTVBNNGNaSi9Bbnk5?=
 =?utf-8?B?bVZ6djBDWnpmd3lzR0t4dVVoQlZjZ0hjZUtmYXgyQndXUmFiaXZ2YldyMzRG?=
 =?utf-8?B?VUFCdTA4UHY5K2ErN2Y0eFkyREdhRDdKMUREaWlNT0orK0VFOXVCQU1UMTZN?=
 =?utf-8?B?NDBxMFQ1cGlVMDBEcVFrOEVDM3ZnM1NGSjdmamVHVkRuckZKTERzblAxdnlY?=
 =?utf-8?B?cUl2TDlVa0tYM3RBdEdQOEd5THNjMkNjSWhQQW5hUFI1aEtGVlRVNldYb24x?=
 =?utf-8?B?RUJPQVZWM21SOHRleUZpeVNKSXUxU0R1WGs1VHEwOWw4QUM2bklzbGphVG56?=
 =?utf-8?B?OFUwem0xVDZ5b0RjS2VadDBldzdvcmcwekpQbXhUZXc4elRzenN0eDRNK1FQ?=
 =?utf-8?B?T1ZDalY2L3BEU3hqUk9wTlFndHNvTlIyUjlscldxNThVSDl6YlVZc3RvWTJj?=
 =?utf-8?B?R2lremk1eWcwYzdVejZEeElBTE5aYmhla3BqQmRZdXJzekkxOHI0c1FqTDh4?=
 =?utf-8?B?N3ZzY09QcVhGajh1aFhrTGJXcm5LY2R1NCtTWmdhdjRDc25wRW1BRGtjd0FE?=
 =?utf-8?B?cWtVQjYyT0xQbU00aTk3SHVxdC9vQ3kwcXE0cDIzcEJhRnFCanMxekdtTmo1?=
 =?utf-8?B?aUJ6MXNlYTd1U2ZWYUx3eGFidmo3enVpdkFzZHJCeWVSdUMzQ2l0TzFCd2E1?=
 =?utf-8?B?MDFuZjA2ckVvSVB2UXRTMmtRc1k5R1grSFZHM1M0ZUpJbjFWWW1Xck4xWDA1?=
 =?utf-8?B?OHk0OElTY3NPMkNiL0Y3cVl4bGRYeW9TQnVqVld3ck5yWVh3RDgvZUdiZUNZ?=
 =?utf-8?B?eEQ0VHVLbklROWN5ZTAzMmVnN01XL05sQWExaVVUbGw0YUFTa3lzdVJJTk9N?=
 =?utf-8?B?STArKzhxa2hiVHVYQU1ndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dd5bd5-0e84-4c79-3966-08d8d9bbde24
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 18:33:38.4342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoBgix7pRu3LfdrRi/w6V+5034kxzPRHswKUUAz74++0HljNS6PFJbpjv2lfPRWS2EpKBymdJH4EE/MYaln54A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wMi0yNSB1bSAxMTo0OCBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPgo+
Cj4gQW0gMjUuMDIuMjEgdW0gMTY6MzUgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4gQW0gMjAy
MS0wMi0yNSB1bSA4OjUzIGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4KPj4+IEFt
IDI1LjAyLjIxIHVtIDA0OjE1IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+Pj4gT24gMjAyMS0w
Mi0yNCAxMDo1NCBhLm0uLCBLaW0sIEpvbmF0aGFuIHdyb3RlOgo+Pj4+PiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4+Pj4+Cj4+Pj4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+Pj4+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENo
cmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4KPj4+Pj4+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkg
MjQsIDIwMjEgNDoxNyBBTQo+Pj4+Pj4gVG86IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBh
bWQuY29tPjsgYW1kLQo+Pj4+Pj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+Pj4gQ2M6
IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT47IEt1ZWhsaW5nLCBGZWxpeAo+Pj4+
Pj4gPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1OiBhZGQgaWggY2FsbCB0byBwcm9jZXNzIHVudGlsCj4+Pj4+PiBjaGVja3BvaW50
Cj4+Pj4+Pgo+Pj4+Pj4gQW0gMjMuMDIuMjEgdW0gMjI6MTAgc2NocmllYiBKb25hdGhhbiBLaW06
Cj4+Pj4+Pj4gQWRkIElIIGZ1bmN0aW9uIHRvIGFsbG93IGNhbGxlciB0byBwcm9jZXNzIHJpbmcg
ZW50cmllcyB1bnRpbCB0aGUKPj4+Pj4+PiBjaGVja3BvaW50IHdyaXRlIHBvaW50ZXIuCj4+Pj4+
PiBUaGlzIG5lZWRzIGEgYmV0dGVyIGRlc2NyaXB0aW9uIG9mIHdoYXQgdGhpcyB3aWxsIGJlIHVz
ZWQgZm9yLgo+Pj4+PiBGZWxpeCBvciBQaGlsaXAgY291bGQgZWxhYm9yYXRlIGJldHRlciBmb3Ig
SE1NIG5lZWRzLgo+Pj4+PiBEZWJ1Z2dpbmcgdG9vbHMgcmVxdWlyZXMgdGhpcyBidXQgaXQncyBp
biBleHBlcmltZW50YWwgbW9kZSBhdCB0aGUKPj4+Pj4gbW9tZW50IHNvIHByb2JhYmx5IG5vdCB0
aGUgYmVzdCBwbGFjZSB0byBkZXNjcmliZSBoZXJlLgo+Pj4+IE9uIHRoZSBITU0gc2lkZSB3ZSdy
ZSBwbGFubmluZyB0byB1c2UgdGhpcyB0byBkcmFpbiBwZW5kaW5nIHBhZ2UKPj4+PiBmYXVsdCBp
bnRlcnJ1cHRzIGJlZm9yZSB3ZSB1bm1hcCBtZW1vcnkuIFRoYXQgc2hvdWxkIGFkZHJlc3MgcGhh
bnRvbQo+Pj4+IFZNIGZhdWx0cyBhZnRlciBtZW1vcnkgaXMgdW5tYXBwZWQuCj4+PiBUaG91Z2h0
IHNvLiBJIHN1Z2dlc3QgdG8gdXNlIGEgd2FpdF9ldmVudCgpIGhlcmUgd2hpY2ggb24gdGhlIHdh
aXRlcgo+Pj4gc2lkZSBjaGVja3MgaWgtPmxvY2sgYW5kIGFkZCBhIHdha2VfdXBfYWxsKCkgYXQg
dGhlIGVuZCBvZgo+Pj4gYW1kZ3B1X2loX3Byb2Nlc3MuCj4+IFJpZ2h0LiBJIHRob3VnaHQgYWJv
dXQgdGhhdCBhbmQgaXQgc2hvdWxkIGJlIGVhc3kgdG8gYWRkLiBUaGUgcmVhc29uIHRvCj4+IHN1
Z2dlc3QgYnVzeSB3YWl0aW5nIGZpcnN0IGlzLCB0aGF0IGludGVycnVwdCBwcm9jZXNzaW5nIGlz
IHN1cHBvc2VkIHRvCj4+IGJlIGZhc3QuIFRoZSBJUlEgaGFuZGxlciBpdHNlbGYgZG9lc24ndCBz
bGVlcC4gU28gSSdkIGV4cGVjdCB0aGUgd2FpdAo+PiB0aW1lIHRvIGJlIHNob3J0IGVub3VnaCB0
aGF0IHNsZWVwaW5nIGFuZCBzY2hlZHVsaW5nIGlzIG5vdCB3b3J0aCBpdC4KPgo+IFdlbGwgdGhl
IHBhZ2UgZmF1bHQgSVJRcyBhcmUgcHJvY2Vzc2VkIGluIGEgd29yayBpdGVtLCBzbyB3ZSBidXN5
IHdhaXQKPiBmb3IgYW5vdGhlciB0aHJlYWQgaGVyZSBhbmQgbm90IGludGVycnVwdCBjb250ZXh0
LgoKR29vZCBwb2ludC4KCgo+Cj4gVGhpcyBpbiB0dXJuIGNhbiBsZWFkIHRvIHN0YXJ2YXRpb24g
b2YgdGhlIHdvcmsgaGFuZGxlciBhbmQgc28gYSBsaWZlCj4gbG9jayBhcyB3ZWxsLgo+Cj4+Cj4+
Cj4+PiBJIHdvbid0IHRvdWNoIHJwdHIgb3Igd3B0ciBhdCBhbGwgZm9yIHRoaXMuCj4+IE5vdCBz
dXJlIHdoYXQncyB5b3VyIGlkZWEgaGVyZSwgdXNpbmcgaWgtPmxvY2suIElzIGl0IHRvIGNvbXBs
ZXRlbHkKPj4gZHJhaW4gYWxsIElSUXMgdW50aWwgdGhlIElIIHJpbmcgaXMgY29tcGxldGVseSBl
bXB0eT8KPgo+IENvcnJlY3QuCj4KPj4gVGhhdCBjYW4KPj4gbGl2ZS1sb2NrLCBpZiB0aGUgR1BV
IHByb2R1Y2VzIElSUXMgZmFzdGVyIHRoYW4gdGhlIGtlcm5lbCBjYW4gcHJvY2Vzcwo+PiB0aGVt
LiBUaGVyZWZvcmUgSSB3YXMgbG9va2luZyBhdCBycHRyIGFuZCB3cHRyIHRvIGRyYWluIG9ubHkg
SVJRcyB0aGF0Cj4+IHdlcmUgYWxyZWFkeSBpbiB0aGUgcXVldWUgd2hlbiB0aGUgZHJhaW4gY2Fs
bCB3YXMgbWFkZS4gVGhhdCBhbHNvCj4+IGVuc3VyZXMgdGhhdCB0aGUgd2FpdCB0aW1lIGlzIGJv
dW5kZWQgYW5kIHNob3VsZCBiZSBzaG9ydCAodW5sZXNzIHRoZQo+PiByaW5nIHNpemUgaXMgaHVn
ZSkuCj4KPiBDb3JyZWN0IGFzIHdlbGwsIGJ1dCB0aGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgSm9u
YXRoYW4ncwo+IGltcGxlbWVudGF0aW9uIGlzIG5vdCBldmVuIHJlbW90ZWx5IGNvcnJlY3QuCj4K
PiBTZWUgd2hlbiB5b3UgbG9vayBhdCB0aGUgcnB0ciBhbmQgd3B0ciB5b3UgY2FuJ3QgYmUgc3Vy
ZSB0aGF0IHRoZXkKPiBoYXZlbid0IHdyYXBwZWQgYXJvdW5kIGJldHdlZW4gdHdvIGxvb2tzLgo+
Cj4gV2hhdCB5b3UgY291bGQgZG8gaXMgbG9vayBhdCBib3RoIHRoZSBycHRyIGFzIHdlbGwgYXMg
dGhlIG9yaWdpbmFsCj4gd3B0ciwgYnV0IHRoYXQgaXMgdHJpY2t5LgoKVGhlIGNvZGUgaW4gSm9u
J3MgcGF0Y2ggd2FzIHN1Z2dlc3RlZCBieSBtZS4gSSBjaGVjayBmb3Igd3JhcHBpbmcgYnkKY29t
cGFyaW5nIHJwdHIgd2l0aCB0aGUgcnB0ciBmcm9tIHRoZSBwcmV2aW91cyBsb29wIGl0ZXJhdGlv
bi4gQ29tcGFyaW5nCnJwdHIgd2l0aCB3cHRyIHlvdSBjYW4gbmV2ZXIgYmUgc3VyZSB3aGV0aGVy
IHJwdHIgaGFzIGFscmVhZHkgcGFzc2VkCndwdHIsIG9yIHdoZXRoZXIgcnB0ciBoYXMgdG8gd3Jh
cCBmaXJzdC4KCkkgY291bGQgc2VlIGEgY29tcHJvbWlzZSB3aGVyZSB3ZSBzbGVlcCBhbmQgd2Fr
ZSB1cCB0aGUgd2FpdGluZyB0aHJlYWRzIHdoZW4KCiAxLiB0aGUgSUggcmluZyBpcyBlbXB0eQog
Mi4gdGhlIElIIHJwdHIgd3JhcHMKClRoYXQgc2hvdWxkIGJlIGdvb2QgZW5vdWdoIHRvIGVuc3Vy
ZSBhIHF1aWNrIHJlc3BvbnNlIGluIHRoZSBjb21tb24gY2FzZQoobm8gaW50ZXJydXB0IHN0b3Jt
KSwgYW5kIGEgcmVhc29uYWJsZSByZXNwb25zZSBpbiB0aGUgaW50ZXJydXB0IHN0b3JtIGNhc2Uu
CgpCdXQgdGhlbiBpdCdzIHN0aWxsIG5vdCBjbGVhciB3aGF0J3MgdGhlIGNvcnJlY3QgY29uZGl0
aW9uIGZvciBjaGVja2luZwp0aGF0IHRoZSBpbnRlcnJ1cHRzIHRoZSBjYWxsZXIgY2FyZXMgYWJv
dXQgaGF2ZSBiZWVuIGRyYWluZWQuIExvb2tpbmcgYXQKanVzdCBycHRyIGFuZCB3cHRyIGlzIGFs
d2F5cyBhbWJpZ3VvdXMuIE1heWJlIHdlIGNvdWxkIHVzZSB0aW1lc3RhbXBzIG9mCnRoZSBsYXN0
IHByb2Nlc3NlZCBpbnRlcnJ1cHQ/IFRob3NlIDQ4LWJpdCB0aW1lIHN0YW1wcyB3cmFwIG11Y2gg
bGVzcwpmcmVxdWVudGx5LiBUaGUgaWRlYSBpcyB0aGlzOgoKICAqIEF0IHRoZSBzdGFydCBnZXQg
dGhlIHRpbWVzdGFtcCBvZiB0aGUgbGFzdCB3cml0dGVuIElIIHJpbmcgZW50cnkKICAgIChjaGVj
a3BvaW50KQogICogV2FpdCB1bnRpbCB0aGUgbGFzdF9wcm9jZXNzZWQgSUggdGltZXN0YW1wIHBh
c3NlcyB0aGUgY2hlY2twb2ludDoKICAgIHNpZ25fZXh0ZW5kKGxhc3RfcHJvY2Vzc2VkIC0gY2hl
Y2twb2ludCkgPj0gMAoKUmVnYXJkcywKwqAgRmVsaXgKCgo+Cj4gUmVnYXJkcywKPiBDaHJpc3Rp
YW4uCj4KPj4KPj4gUmVnYXJkcywKPj4gwqDCoCBGZWxpeAo+Pgo+Pgo+Pj4gUmVnYXJkcywKPj4+
IENocmlzdGlhbi4KPj4+Cj4+Pj4gUmVnYXJkcywKPj4+PiDCoMKgIEZlbGl4Cj4+Pj4KPj4+Pgo+
Pj4+Pj4+IFN1Z2dlc3RlZC1ieTogRmVsaXggS3VlaGxpbmcgPGZlbGl4Lmt1ZWhsaW5nQGFtZC5j
b20+Cj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1k
LmNvbT4KPj4+Pj4+PiAtLS0KPj4+Pj4+PiDCoMKgwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2loLmMgfCA0Ngo+Pj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKy0KPj4+
Pj4+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguaCB8wqAgMiArKwo+Pj4+
Pj4+IMKgwqDCoCAyIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPj4+Pj4+Pgo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfaWguYwo+Pj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2loLmMKPj4+Pj4+PiBpbmRleCBkYzg1MmFmNGYzYjcuLmNhZTUwYWY5NTU5ZCAxMDA2NDQKPj4+
Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYwo+Pj4+Pj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jCj4+Pj4+Pj4gQEAg
LTIyLDcgKzIyLDcgQEAKPj4+Pj4+PiDCoMKgwqDCoCAqLwo+Pj4+Pj4+Cj4+Pj4+Pj4gwqDCoMKg
ICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPgo+Pj4+Pj4+IC0KPj4+Pj4+PiArI2luY2x1
ZGUgPGxpbnV4L3Byb2Nlc3Nvci5oPgo+Pj4+Pj4+IMKgwqDCoCAjaW5jbHVkZSAiYW1kZ3B1Lmgi
Cj4+Pj4+Pj4gwqDCoMKgICNpbmNsdWRlICJhbWRncHVfaWguaCIKPj4+Pj4+Pgo+Pj4+Pj4+IEBA
IC0xNjAsNiArMTYwLDUwIEBAIHZvaWQgYW1kZ3B1X2loX3Jpbmdfd3JpdGUoc3RydWN0Cj4+Pj4+
PiBhbWRncHVfaWhfcmluZyAqaWgsIGNvbnN0IHVpbnQzMl90ICppdiwKPj4+Pj4+PiDCoMKgwqAg
fQo+Pj4+Pj4+IMKgwqDCoCB9Cj4+Pj4+Pj4KPj4+Pj4+PiArLyoqCj4+Pj4+Pj4gKyAqIGFtZGdw
dV9paF93YWl0X29uX2NoZWNrcG9pbnRfcHJvY2VzcyAtIHdhaXQgdG8gcHJvY2VzcyBJVnMKPj4+
Pj4+PiB1cCB0bwo+Pj4+Pj4+ICtjaGVja3BvaW50Cj4+Pj4+Pj4gKyAqCj4+Pj4+Pj4gKyAqIEBh
ZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPj4+Pj4+PiArICogQGloOiBpaCByaW5nIHRvIHBy
b2Nlc3MKPj4+Pj4+PiArICoKPj4+Pj4+PiArICogVXNlZCB0byBlbnN1cmUgcmluZyBoYXMgcHJv
Y2Vzc2VkIElWcyB1cCB0byB0aGUgY2hlY2twb2ludAo+Pj4+Pj4+IHdyaXRlCj4+Pj4+PiBwb2lu
dGVyLgo+Pj4+Pj4+ICsgKi8KPj4+Pj4+PiAraW50IGFtZGdwdV9paF93YWl0X29uX2NoZWNrcG9p
bnRfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQo+Pj4+Pj4gKmFkZXYsCj4+Pj4+Pj4gK3N0
cnVjdCBhbWRncHVfaWhfcmluZyAqaWgpCj4+Pj4+Pj4gK3sKPj4+Pj4+PiArdTMyIHByZXZfcnB0
ciwgY3VyX3JwdHIsIGNoZWNrcG9pbnRfd3B0cjsKPj4+Pj4+PiArCj4+Pj4+Pj4gK2lmICghaWgt
PmVuYWJsZWQgfHwgYWRldi0+c2h1dGRvd24pCj4+Pj4+Pj4gK3JldHVybiAtRU5PREVWOwo+Pj4+
Pj4+ICsKPj4+Pj4+PiArY3VyX3JwdHIgPSBSRUFEX09OQ0UoaWgtPnJwdHIpOwo+Pj4+Pj4+ICsv
KiBPcmRlciByZWFkIG9mIGN1cnJlbnQgcnB0ciB3aXRoIGNoZWNrdHBvaW50IHdwdHIuICovCj4+
Pj4+Pj4gK21iKCk7Cj4+Pj4+Pj4gK2NoZWNrcG9pbnRfd3B0ciA9IGFtZGdwdV9paF9nZXRfd3B0
cihhZGV2LCBpaCk7Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICsvKiBhbGxvdyBycHRyIHRvIHdyYXAgYXJv
dW5kwqAgKi8KPj4+Pj4+PiAraWYgKGN1cl9ycHRyID4gY2hlY2twb2ludF93cHRyKSB7Cj4+Pj4+
Pj4gK3NwaW5fYmVnaW4oKTsKPj4+Pj4+PiArZG8gewo+Pj4+Pj4+ICtzcGluX2NwdV9yZWxheCgp
Owo+Pj4+Pj4+ICtwcmV2X3JwdHIgPSBjdXJfcnB0cjsKPj4+Pj4+PiArY3VyX3JwdHIgPSBSRUFE
X09OQ0UoaWgtPnJwdHIpOwo+Pj4+Pj4+ICt9IHdoaWxlIChjdXJfcnB0ciA+PSBwcmV2X3JwdHIp
Owo+Pj4+Pj4+ICtzcGluX2VuZCgpOwo+Pj4+Pj4gVGhhdCdzIGEgY2VydGFpbiBOQUsgc2luY2Ug
aXQgYnVzeSB3YWl0cyBmb3IgSUggcHJvY2Vzc2luZy4gV2UgbmVlZAo+Pj4+Pj4gc29tZQo+Pj4+
Pj4gZXZlbnQgdG8gdHJpZ2dlciBoZXJlLgo+Pj4+PiBUaGUgZnVuY3Rpb24gaXMgbWVhbnQgdG8g
YmUganVzdCBhIHdhaXRlciB1cCB0byB0aGUgY2hlY2twb2ludC4KPj4+Pj4gVGhlcmUncyBhIG5l
ZWQgdG8gZ3VhcmFudGVlIHRoYXQgInN0YWxlIiBpbnRlcnJ1cHRzIGhhdmUgYmVlbgo+Pj4+PiBw
cm9jZXNzZWQgb24gY2hlY2sgYmVmb3JlIGRvaW5nIG90aGVyIHN0dWZmIGFmdGVyIGNhbGwuCj4+
Pj4+IFRoZSBkZXNjcmlwdGlvbiBjb3VsZCBiZSBpbXByb3ZlZCB0byBjbGFyaWZ5IHRoYXQuCj4+
Pj4+Cj4+Pj4+IFdvdWxkIGJ1c3kgd2FpdGluZyBvbmx5IG9uIGEgbG9ja2VkIHJpbmcgaGVscD/C
oCBJIGFzc3VtZSBhbiB1bmxvY2tlZAo+Pj4+PiByaW5nIG1lYW5zIG5vdGhpbmcgdG8gcHJvY2Vz
cyBzbyBubyBuZWVkIHRvIHdhaXQgYW5kIHdlIGNhbiBleGl0Cj4+Pj4+IGVhcmx5LsKgIE9yIGlz
IGl0IGJldHRlciB0byBqdXN0IHRvIHByb2Nlc3MgdGhlIGVudHJpZXMgdXAgdG8gdGhlCj4+Pj4+
IGNoZWNrcG9pbnQgKG1heWJlIGFkanVzdCBhbWRncHVfaWhfcHJvY2VzcyBmb3IgdGhpcyBuZWVk
IGxpa2UgYWRkaW5nCj4+Pj4+IGEgYm9vbCBhcmcgdG8gc2tpcCByZXN0YXJ0IG9yIHNvbWV0aGlu
Zyk/Cj4+Pj4+Cj4+Pj4+IFRoYW5rcywKPj4+Pj4KPj4+Pj4gSm9uCj4+Pj4+Cj4+Pj4+Pj4gK30K
Pj4+Pj4+PiArCj4+Pj4+Pj4gKy8qIHdhaXQgZm9yIHJwdHIgdG8gY2F0Y2ggdXAgdG8gb3IgcGFz
cyBjaGVja3BvaW50LiAqLwo+Pj4+Pj4+ICtzcGluX2JlZ2luKCk7Cj4+Pj4+Pj4gK2RvIHsKPj4+
Pj4+PiArc3Bpbl9jcHVfcmVsYXgoKTsKPj4+Pj4+PiArcHJldl9ycHRyID0gY3VyX3JwdHI7Cj4+
Pj4+Pj4gK2N1cl9ycHRyID0gUkVBRF9PTkNFKGloLT5ycHRyKTsKPj4+Pj4+PiArfSB3aGlsZSAo
Y3VyX3JwdHIgPj0gcHJldl9ycHRyICYmIGN1cl9ycHRyIDwgY2hlY2twb2ludF93cHRyKTsKPj4+
Pj4+IFNhbWUgb2YgY291cnNlIGhlcmUuCj4+Pj4+Pgo+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4K
Pj4+Pj4+PiArc3Bpbl9lbmQoKTsKPj4+Pj4+PiArCj4+Pj4+Pj4gK3JldHVybiAwOwo+Pj4+Pj4+
ICt9Cj4+Pj4+Pj4gKwo+Pj4+Pj4+IMKgwqDCoCAvKioKPj4+Pj4+PiDCoMKgwqDCoCAqIGFtZGdw
dV9paF9wcm9jZXNzIC0gaW50ZXJydXB0IGhhbmRsZXIKPj4+Pj4+PiDCoMKgwqDCoCAqCj4+Pj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oCj4+
Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguaAo+Pj4+Pj4+IGlu
ZGV4IDZlZDRhODVmYzdjMy4uNjgxN2YwYTgxMmQyIDEwMDY0NAo+Pj4+Pj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oCj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmgKPj4+Pj4+PiBAQCAtODcsNiArODcsOCBAQCBp
bnQgYW1kZ3B1X2loX3JpbmdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZQo+Pj4+Pj4+ICphZGV2
LAo+Pj4+Pj4gc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCwKPj4+Pj4+PiDCoMKgwqAgdm9pZCBh
bWRncHVfaWhfcmluZ19maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QKPj4+
Pj4+IGFtZGdwdV9paF9yaW5nICppaCk7Cj4+Pj4+Pj4gwqDCoMKgIHZvaWQgYW1kZ3B1X2loX3Jp
bmdfd3JpdGUoc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCwgY29uc3QKPj4+Pj4+PiB1aW50MzJf
dCAqaXYsCj4+Pj4+Pj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgbnVtX2R3KTsKPj4+Pj4+PiAr
aW50IGFtZGdwdV9paF93YWl0X29uX2NoZWNrcG9pbnRfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZQo+Pj4+Pj4gKmFkZXYsCj4+Pj4+Pj4gK3N0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgpOwo+
Pj4+Pj4+IMKgwqDCoCBpbnQgYW1kZ3B1X2loX3Byb2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIHN0cnVjdAo+Pj4+Pj4gYW1kZ3B1X2loX3JpbmcgKmloKTsKPj4+Pj4+PiDCoMKgwqAg
dm9pZCBhbWRncHVfaWhfZGVjb2RlX2l2X2hlbHBlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKPj4+Pj4+PiDCoMKgwqAgc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCwKPj4+PiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+PiBodHRwczov
L25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFt
cDtkYXRhPTA0JTdDMDElN0NmZWxpeC5rdWVobGluZyU0MGFtZC5jb20lN0M4NGQ4NWU1NGJkY2I0
NTkzZTA3ZjA4ZDhkOTk0YmU3NyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdD
MCU3QzAlN0M2Mzc0OTg1ODAxNjczMTMxOTMlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lq
b2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4w
JTNEJTdDMTAwMCZhbXA7c2RhdGE9UnZSSEI5bDRPJTJCcGJwb2dVRktVbW5NR2txS25lY3dRQ1lS
SHJreElDRHFVJTNEJmFtcDtyZXNlcnZlZD0wCj4+Pj4KPj4+Pgo+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
