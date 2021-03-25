Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B47DC433C1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2230D61A12
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2230D61A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FEF6EB63;
	Thu, 25 Mar 2021 16:14:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2556EB63
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 16:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqXuxZU65/W1M/1XwM0ZqbMAoxr6/zbar6WVwCIgh0ZVhZ3gMBUvZ8V/isuDfdDKHk0UJsB3j6gSIcA3GopwYGgtbyTJgzuj92CxEvO06LL/JRlF6gDbLsFNeEZejWxoIbLE/DqETjzXMvf+a0pFUejdR0SWMLY1bmOuNf7qyx5qwAoOQ6+ZoFWNC50giH8Vb5hbakPYCF9PyewZf6IqpBDbQGP6AMVucDt8L2YJoV7w06C4r+3kUTMuwAN7rXEWcHInTryzTr2AeYZ3vOMgluIAaB6tkJ2cF3Bh26uO7ouMztdr8NzfhK7UU72c4l/vE1Wg11HxxWQgodVeRs1tAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8N8a93Pbl2ZPPJcrgLjMhGqj/MUiY7jrwg+8Rpdp7w=;
 b=LlZ4rOSNfnaPtBRBuR7O5zx9kcRCaVVX4+VqGE1XWF0QvfGLez2JxF9/HBxQJQTAhR/h9jbQbvW6TUVyOC5K/uqFSzutrK8wcZ029Aj3pWmp7GYyVPpGmcBpbBPCT5OlblrCGYPD/IbFKmiEPKsKqJjDiYSXZnTbfSwKVK4lWubwLBcjNbNSVulL9jDbiWkeK54XeENOkWnmXz9kxuai/7LsuopGoxnPe7T2J8EmELxBSKio3vHeedhYuNGPZpetpkyNF5RZ+qTmEQqNIujrwAuTSuLB7vvaXs7qqSf+bIwJinyk/QcsKZUSw6L3TXbsHSGQYWItZhyncYToM0q63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8N8a93Pbl2ZPPJcrgLjMhGqj/MUiY7jrwg+8Rpdp7w=;
 b=C8OtocSNFdYXXpMaBCQI9mWssPpEsiMlpvKanevxhv29ZpeRkFrEc5JBjvE/36J7IxcV6jsnQdUYMpMec5dG2om+amTU0TwEgPl4dRYuhYZDaj2RDlQlK1pXI6WLul2ocrYg2enK/H6QHiJycHJLWmf+MTSFmDWCq7gOcgCARkA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4658.namprd12.prod.outlook.com (2603:10b6:207:32::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 16:14:46 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.3933.036; Thu, 25 Mar 2021
 16:14:46 +0000
Subject: Re: Need to support mixed memory mappings with HMM
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <ba49d13c-6b64-f9a6-f309-0dda56e90abf@amd.com>
 <dc28799b-d3a9-6922-f06a-c19eb75a9805@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <415c5920-0c70-819b-555e-a0c0fce301ef@amd.com>
Date: Thu, 25 Mar 2021 12:14:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <dc28799b-d3a9-6922-f06a-c19eb75a9805@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.84.209]
X-ClientProxiedBy: YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::8) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.84.209) by
 YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 16:14:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be9c16ad-d9e9-4f6f-61db-08d8efa91b59
X-MS-TrafficTypeDiagnostic: BL0PR12MB4658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4658AABCB1DA91C67ACCD14492629@BL0PR12MB4658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnv9Jo84xRM5nVCFB8psq/CAkfVEPPUi1y5jLvJwo7nQcY9Uar0P5IF9T4xZpUES59s8Gz/UEZv3AK7Lr3izpOOl4WKQMERFzEfTTsV7UBXDXY55WaCBcKdY+9ILqGAPzpHb5GVuP8tba52oxAtuku6B784MBk7mFECTp4XS5APAoMD28OwXmJBZekfH2SaTHEW0KsTvITDVDuByXeVg0a0SOqdaKc1o/vbNZuUizsDIEGBYhAJarysOq3JyTcsPAMhql+afAMGOeHyPnStL4o4otJeyL5CpXczdlU74/ZMrbElOrHg+SlKZ67wthIY6Tit1XTlo5LYu0N8r5edrYdXDJHKnxou61xwPlQ+4oL9VurIV3bim1ocspmbBGIhP7XHec38Pigb2kp9Zet/d04vCmZVFKyIhr73b5dooxFP5SxaowEb9fiw6HGiLBMlT/CHUorD5Z1wa9P8bfUAgfyZAh2uEeJeh0xHclH46rZXgNRy+kykbd2YrQ8Dh3Phqfu+wWudPtNLr1ZbQ3cwO06mRrYOZAvsrIQAsOcE0vo9v3FVidzcdhnV+/3zVJhptRsLhqp09pfQ/lkZjH3J/6fe2ryub/7i5LNcFP6HAW9FrD74Mt9jk1TA6Gw/e9OxEkP8giMIPEK/iSZW4SSal0RYTsaMlm4X+jpYbU5H05KWSNQfmLoyi1jsNcbCMOylKQmKGF1cjeqeCf8Htead219U8h5jlMX8xVh6491iqwec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(498600001)(26005)(110136005)(66556008)(66476007)(66946007)(31696002)(16576012)(2616005)(44832011)(86362001)(2906002)(6486002)(5660300002)(31686004)(36756003)(186003)(66574015)(16526019)(956004)(8676002)(8936002)(38100700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RGZXeWUzM29STnNleWhxaHJhS0RGRFgwbWs4ZHEwOGpaY1FFS3c5UVhqSXhG?=
 =?utf-8?B?NTZRVlBNMWl5UVhnUkhoUjZwanJqQUYvWWEvTnhvNHZVQ2xwNytXRXN5ZzV4?=
 =?utf-8?B?b3Bkbldpa1FUYjFhQmM1aFdrN3F4WndudmJxWmlmdjltaUkyNFZxSVY5cEZo?=
 =?utf-8?B?VncxMVRScXgwWkF0eFoweENnUHBROER3akxDSEh1WDlUWGxRRGRLRnJJOURm?=
 =?utf-8?B?Vjh4OGtDNEhlOXBBc0IyL011U0FCYzFvVGFVRTZMQ3g4VDAyaVFZUUFqT3pj?=
 =?utf-8?B?N3E4NUFQRVUwOXd4VmQ0dEpyTDdrT3VIYys5V0hOcHl6c005a2Voc3dQOUdS?=
 =?utf-8?B?U01LTUZCSG1ncVlKMzl1U3h0VlNPR0dvQWIyUHdHWENxYWlSM0MrVU5wd2Vo?=
 =?utf-8?B?ajhaQjg5T3FXKzBOalNHY2o4UmsxUjljMDdRbEpRaFNTQ3RCLzk4bEx6ektP?=
 =?utf-8?B?M0hDMFdLRU1BUXQvdkFuQUsvK0NaZ0NubkU5K3NWMEFrNXZYODd3VGFCM2lM?=
 =?utf-8?B?MG9QcmF4bEEwQ3I1NlFkRjEyS3l5MUI2d1gyN01qVE56bFVzbEE4RzcvQ1lG?=
 =?utf-8?B?Qm1KUDEvOWJjUDNRdmF1VVdwanNwMnhCMGl1V2JXc09hQ2QxYlBsQm1ZU3BT?=
 =?utf-8?B?T0FaMkU4aEU2OWlQa0hGbC9EcGdqaCtGR2lJNTZwYVdrQkZZNlNGWXdrWSs0?=
 =?utf-8?B?RGRzdWJ4TlFRcEN6WWJzbzdHZ0JDR1U1QjJZMDFYb2R0MHJMZlRVSllDUEFr?=
 =?utf-8?B?bHJINWxpbTcwY0I3L1Eycm5veThQYXgwVVF5UFRxNkhUeXV5djBMQVpaNUto?=
 =?utf-8?B?NGNFaHpuSHFJNG4rcmpzYS9raDRlVzRSRkhKQ0ZPL05xb2wvbUVuL1hoVTVm?=
 =?utf-8?B?cGpVT3VZcUtkczRORWIzeWlvangra1ljeHJobVk1WnpDWkVGWnNreHMzOVc1?=
 =?utf-8?B?M3I0S3ZZalIrNmNBZVY3NG5mRVVESC96c1FZR240Qnh3M0VLMG9uU1dZWHpo?=
 =?utf-8?B?bmZGSkE0RGFhUUttTU95cSs0SUdXMWVMVnBib202bjhoQk5wYUFGM2I4TUUx?=
 =?utf-8?B?MnpGbGJwdjlVNC9hVXd5bWRpYWh3UmhSR2MzOERMb01YeGw4RUZiRmNjTUZZ?=
 =?utf-8?B?Mjh6eGtkSVczTWpQUWFhWEszSmR6Vm9jb2VvVUJmSUR5bTNrMFN4ZnBnR2xZ?=
 =?utf-8?B?M2JVUXRYbXE3amhzM3drbDZ1RDgxcWZ3THVWaEFxUVNpYnpHRWJrRHFVYnhU?=
 =?utf-8?B?czUveVdGNzJBVTFDcCswU2tWbzNtUDBFZXJibmw0SW5Ta2pHajdXZ2xtOVZQ?=
 =?utf-8?B?ZHhicDJHTmN0b3duYi9tajJ2MmZhKzE0WGFxa3JSWHJWekhOcEliMGRGcWJw?=
 =?utf-8?B?dzl2K3h5dG5MUkZ4c2s5WFUxMlY3OEMwVUFxYVMxOHV3R0xqanFTTkk3Wm01?=
 =?utf-8?B?M2tGaDQzalpoK0l3V25mRFltTmRmR2NaSi9la1pmakthYjlEbStrdWpjbmVY?=
 =?utf-8?B?b0ttSHE1Tm9ObklURFBQUXdLcWc3MW12UmErdlM0TDBKQVlIeVZOUVhkTFBF?=
 =?utf-8?B?NFJHYm9pM3ZFN0NVWFl6SnY0SEdic2RUblVaOCt0b3ZzRTJaYlJVOVF3alcr?=
 =?utf-8?B?dHl5V284RnlxSEFQaUh6Nllhakx1UFVCcUw1MWwwdXVGMUtpYzFKczgvTHJo?=
 =?utf-8?B?RmJIZi8xQW8wSXRNVE9FcnJLOFpFOTVOL2ZpQVViY2xHcnBJdm4zV0hlNGRJ?=
 =?utf-8?Q?PkkMCqMYwDHGlT9AzPhx4LWlzM+adU7DurLtVxJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9c16ad-d9e9-4f6f-61db-08d8efa91b59
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:14:46.1693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDgirjilSvKgt0KFUeDWF+m5lQJLaEtsx234M+v0Aci4NrzknQOHFGXAgK2lcs5AcL34JnHyQZjkrauI6gw2qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4658
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wMy0yNSB1bSAxMjoxMCBwLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPgo+
Cj4gQW0gMjUuMDMuMjEgdW0gMTc6MDMgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4gSGksCj4+
Cj4+IFRoaXMgaXMgYSBsb25nIG9uZSB3aXRoIGEgcHJvcG9zYWwgZm9yIGEgcHJldHR5IHNpZ25p
ZmljYW50IHJlZGVzaWduIG9mCj4+IGhvdyB3ZSBoYW5kbGUgbWlncmF0aW9ucyBhbmQgVlJBTSBt
YW5hZ2VtZW50IHdpdGggSE1NLiBUaGlzIGlzIGJhc2VkIG9uCj4+IG15IG93biBkZWJ1Z2dpbmcg
YW5kIHJlYWRpbmcgb2YgdGhlIG1pZ3JhdGVfdm1hIGhlbHBlcnMsIGFzIHdlbGwgYXMKPj4gQWxl
eCdzIHByb2JsZW1zIHdpdGggbWlncmF0aW9ucyBvbiBBK0EuIEkgaG9wZSB3ZSBjYW4gZGlzY3Vz
cyB0aGlzIG5leHQKPj4gTW9uZGF5IGFmdGVyIHlvdSd2ZSBoYWQgc29tZSB0aW1lIGRvIGRpZ2Vz
dCBpdC4KPj4KPj4gSSBkaWQgc29tZSBkZWJ1Z2dpbmcgeWVzdGVyZGF5IGFuZCBmb3VuZCB0aGF0
IG1pZ3JhdGlvbnMgdG8gVlJBTSBjYW4KPj4gZmFpbCBmb3Igc29tZSBwYWdlcy4gVGhlIGN1cnJl
bnQgbWlncmF0aW9uIGhlbHBlcnMgaGF2ZSBtYW55IGNvcm5lcgo+PiBjYXNlcyB3aGVyZSBhIHBh
Z2UgY2Fubm90IGJlIG1pZ3JhdGVkLiBTb21lIG9mIHRoZW0gbWF5IGJlIGZpeGFibGUKPj4gKGFk
ZGluZyBzdXBwb3J0IGZvciBUSFApLCBvdGhlcnMgYXJlIG5vdCAobG9ja2VkIHBhZ2VzIGFyZSBz
a2lwcGVkIHRvCj4+IGF2b2lkIGRlYWRsb2NrcykuIFRoZXJlZm9yZSBJIHRoaW5rIG91ciBjdXJy
ZW50IGNvZGUgaXMgdG9vIGluZmxleGlibGUKPj4gd2hlbiBpdCBhc3N1bWVzIHRoYXQgYSByYW5n
ZSBpcyBlbnRpcmVseSBpbiBvbmUgcGxhY2UuCj4+Cj4+IEFsZXggYWxzbyByYW4gaW50byBzb21l
IGZ1bm55IGlzc3VlcyB3aXRoIENPVyBvbiBBK0Egd2hlcmUgc29tZSBwYWdlcwo+PiBnZXQgZmF1
bHRlZCBiYWNrIHRvIHN5c3RlbSBtZW1vcnkuIEkgdGhpbmsgYSBsb3Qgb2YgdGhlIHByb2JsZW1z
IGhlcmUKPj4gd2lsbCBnZXQgZWFzaWVyIG9uY2Ugd2Ugc3VwcG9ydCBtaXhlZCBtYXBwaW5ncy4K
Pj4KPj4gTWl4ZWQgR1BVIG1hcHBpbmdzCj4+ID09PT09PT09PT09Cj4+Cj4+IFRoZSBpZGVhIGlz
LCB0byByZW1vdmUgYW55IGFzc3VtcHRpb25zIHRoYXQgYW4gZW50aXJlIHN2bV9yYW5nZSBpcyBp
bgo+PiBvbmUgcGxhY2UuIEluc3RlYWQgaG1tX3JhbmdlX2ZhdWx0IGdpdmVzIHVzIGEgbGlzdCBv
ZiBwYWdlcywgc29tZSBvZgo+PiB3aGljaCBhcmUgc3lzdGVtIG1lbW9yeSBhbmQgb3RoZXJzIGFy
ZSBkZXZpY2VfcHJpdmF0ZSBvciBkZXZpY2VfZ2VuZXJpYy4KPj4KPj4gV2Ugd2lsbCBuZWVkIGFu
IGFtZGdwdV92bSBpbnRlcmZhY2UgdGhhdCBsZXRzIHVzIG1hcCBtaXhlZCBwYWdlIGFycmF5cwo+
PiB3aGVyZSBkaWZmZXJlbnQgcGFnZXMgdXNlIGRpZmZlcmVudCBQVEUgZmxhZ3MuIFdlIGNhbiBo
YXZlIGF0IGxlYXN0IDMKPj4gZGlmZmVyZW50IHR5cGVzIG9mIHBhZ2VzIGluIG9uZSBtYXBwaW5n
Ogo+Pgo+PiDCoCAxLiBTeXN0ZW0gbWVtb3J5IChTLWJpdCBzZXQpCj4+IMKgIDIuIExvY2FsIG1l
bW9yeSAoUy1iaXQgY2xlYXJlZCwgTVRZUEUgZm9yIGxvY2FsIG1lbW9yeSkKPj4gwqAgMy4gUmVt
b3RlIFhHTUkgbWVtb3J5IChTLWJpdCBjbGVhcmVkLCBNVFlQRStDIGZvciByZW1vdGUgbWVtb3J5
KQo+Pgo+PiBNeSBpZGVhIGlzIHRvIGNoYW5nZSB0aGUgYW1kZ3B1X3ZtX3VwZGF0ZV9tYXBwaW5n
IGludGVyZmFjZSB0byB1c2Ugc29tZQo+PiBoaWdoLWJpdCBpbiB0aGUgcGFnZXNfYWRkciBhcnJh
eSB0byBpbmRpY2F0ZSB0aGUgcGFnZSB0eXBlLiBGb3IgdGhlCj4+IGRlZmF1bHQgcGFnZSB0eXBl
ICgwKSBub3RoaW5nIHJlYWxseSBjaGFuZ2VzIGZvciB0aGUgY2FsbGVycy4gVGhlCj4+ICJmbGFn
cyIgcGFyYW1ldGVyIG5lZWRzIHRvIGJlY29tZSBhIHBvaW50ZXIgdG8gYW4gYXJyYXkgdGhhdCBn
ZXRzCj4+IGluZGV4ZWQgYnkgdGhlIGhpZ2ggYml0cyBmcm9tIHRoZSBwYWdlc19hZGRyIGFycmF5
LiBGb3IgZXhpc3RpbmcgY2FsbGVycwo+PiBpdCdzIGFzIGVhc3kgYXMgY2hhbmdpbmcgZmxhZ3Mg
dG8gJmZsYWdzIChhcnJheSBvZiBzaXplIDEpLiBGb3IgSE1NIHdlCj4+IHdvdWxkIHBhc3MgYSBw
b2ludGVyIHRvIGEgcmVhbCBhcnJheS4KPgo+IFllYWgsIEkndmUgdGhvdWdodCBhYm91dCBzdHVm
ZiBsaWtlIHRoYXQgYXMgd2VsbCBmb3IgYSB3aGlsZS4KPgo+IFByb2JsZW0gaXMgdGhhdCB0aGlz
IHdvbid0IHdvcmsgdGhhdCBlYXNpbHkuIFdlIGFzc3VtZSBhdCBtYW55IHBsYWNlcwo+IHRoYXQg
dGhlIGZsYWdzIGRvZXNuJ3QgY2hhbmdlIGZvciB0aGUgcmFuZ2UgaW4gcXVlc3Rpb24uCgpJIHRo
aW5rIHNvbWUgbG93ZXIgbGV2ZWwgZnVuY3Rpb25zIGFzc3VtZSB0aGF0IHRoZSBmbGFncyBzdGF5
IHRoZSBzYW1lCmZvciBwaHlzaWNhbGx5IGNvbnRpZ3VvdXMgcmFuZ2VzLiBCdXQgaWYgeW91IHVz
ZSB0aGUgaGlnaC1iaXRzIHRvIGVuY29kZQp0aGUgcGFnZSB0eXBlLCB0aGUgcmFuZ2VzIHdvbid0
IGJlIGNvbnRpZ3VvdXMgYW55IG1vcmUuIFNvIHlvdSBjYW4KY2hhbmdlIHBhZ2UgZmxhZ3MgZm9y
IGRpZmZlcmVudCBjb250aWd1b3VzIHJhbmdlcy4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPgo+IFdl
IHdvdWxkIHNvbWVob3cgbmVlZCB0byBjaGFuZ2UgdGhhdCB0byBnZXQgdGhlIGZsYWdzIGRpcmVj
dGx5IGZyb20KPiB0aGUgbG93IGJpdHMgb2YgdGhlIERNQSBhZGRyZXNzIG9yIHNvbWV0aGluZyBp
bnN0ZWFkLgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IE9uY2UgdGhpcyBpcyBkb25lLCBpdCBsZWFk
cyB0byBhIG51bWJlciBvZiBvcHBvcnR1bml0aWVzIGZvcgo+PiBzaW1wbGlmaWNhdGlvbiBhbmQg
YmV0dGVyIGVmZmljaWVuY3kgaW4ga2ZkX3N2bToKPj4KPj4gwqDCoCAqIFN1cHBvcnQgbWlncmF0
aW9uIHdoZW4gY3BhZ2VzICE9IG5wYWdlcwo+PiDCoMKgICogTWlncmF0ZSBhIHBhcnQgb2YgYW4g
c3ZtX3JhbmdlIHdpdGhvdXQgc3BsaXR0aW5nIGl0LiBObyBtb3JlCj4+IMKgwqDCoMKgIHNwbGl0
dGluZyBvZiByYW5nZXMgaW4gQ1BVIHBhZ2UgZmF1bHRzCj4+IMKgwqAgKiBNaWdyYXRlIGEgcGFy
dCBvZiBhbiBzdm1fcmFuZ2UgaW4gR1BVIHBhZ2UgZmF1bHQgaGFuZGxlci4gTm8gbW9yZQo+PiDC
oMKgwqDCoCBtaWdyYXRpbmcgdGhlIHdob2xlIHJhbmdlIGZvciBhIHNpbmdsZSBwYWdlIGZhdWx0
Cj4+IMKgwqAgKiBTaW1wbGlmaWVkIFZSQU0gbWFuYWdlbWVudCAoc2VlIGJlbG93KQo+Pgo+PiBX
aXRoIHRoYXQsIHN2bV9yYW5nZSB3aWxsIG5vIGxvbmdlciBoYXZlIGFuICJhY3R1YWxfbG9jIiBm
aWVsZC4gSWYgd2UncmUKPj4gbm90IHN1cmUgd2hlcmUgdGhlIGRhdGEgaXMsIHdlIG5lZWQgdG8g
Y2FsbCBtaWdyYXRlLiBJZiBpdCdzIGFscmVhZHkgaW4KPj4gdGhlIHJpZ2h0IHBsYWNlLCB0aGVu
IGNwYWdlcyB3aWxsIGJlIDAgYW5kIHdlIGNhbiBza2lwIGFsbCB0aGUgc3RlcHMKPj4gYWZ0ZXIg
bWlncmF0ZV92bWFfc2V0dXAuCj4+Cj4+IFNpbXBsaWZpZWQgVlJBTSBtYW5hZ2VtZW50Cj4+ID09
PT09PT09PT09PT09Cj4+Cj4+IFZSQU0gQk9zIGFyZSBubyBsb25nZXIgYXNzb2NpYXRlZCB3aXRo
IHByYW5nZXMuIEluc3RlYWQgdGhleSBhcmUKPj4gImZyZWUtZmxvYXRpbmciLCBhbGxvY2F0ZWQg
ZHVyaW5nIG1pZ3JhdGlvbiB0byBWUkFNLCB3aXRoIHJlZmVyZW5jZQo+PiBjb3VudCBmb3IgZWFj
aCBwYWdlIHRoYXQgdXNlcyB0aGUgQk8uIFJlZiBpcyByZWxlYXNlZCBpbiBwYWdlLXJlbGVhc2UK
Pj4gY2FsbGJhY2suIFdoZW4gdGhlIHJlZiBjb3VudCBkcm9wcyB0byAwLCBmcmVlIHRoZSBCTy4K
Pj4KPj4gVlJBTSBCTyBzaXplIHNob3VsZCBtYXRjaCB0aGUgbWlncmF0aW9uIGdyYW51bGFyaXR5
LCAyTUIgYnkgZGVmYXVsdC4KPj4gVGhhdCB3YXkgdGhlIEJPIGNhbiBiZSBmcmVlZCB3aGVuIG1l
bW9yeSBnZXRzIG1pZ3JhdGVkIG91dC4gSWYgbWlncmF0aW9uCj4+IG9mIHNvbWUgcGFnZXMgZmFp
bHMgdGhlIEJPIG1heSBub3QgYmUgZnVsbHkgb2NjdXBpZWQuIEFsc28gc29tZSBwYWdlcwo+PiBt
YXkgYmUgcmVsZWFzZWQgaW5kaXZpZHVhbGx5IG9uIEErQSBkdWUgdG8gQ09XIG9yIG90aGVyIGV2
ZW50cy4KPj4KPj4gRXZpY3Rpb24gbmVlZHMgdG8gbWlncmF0ZSBhbGwgdGhlIHBhZ2VzIHN0aWxs
IHVzaW5nIHRoZSBCTy4gSWYgdGhlIEJPCj4+IHN0cnVjdCBrZWVwcyBhbiBhcnJheSBvZiBwYWdl
IHBvaW50ZXJzLCB0aGF0J3MgYmFzaWNhbGx5IHRoZSBtaWdyYXRlLnNyYwo+PiBmb3IgdGhlIGV2
aWN0aW9uLiBNaWdyYXRpb24gY2FsbHMgInRyeV90b191bm1hcCIsIHdoaWNoIGhhcyB0aGUgYmVz
dAo+PiBjaGFuY2Ugb2YgZnJlZWluZyB0aGUgQk8sIGV2ZW4gd2hlbiBzaGFyZWQgYnkgbXVsdGlw
bGUgcHJvY2Vzc2VzLgo+Pgo+PiBJZiB3ZSBjYW5ub3QgZ3VhcmFudGVlIGV2aWN0aW9uIG9mIHBh
Z2VzLCB3ZSBjYW5ub3QgdXNlIFRUTSBmb3IgVlJBTQo+PiBhbGxvY2F0aW9ucy4gTmVlZCB0byB1
c2UgYW1kZ3B1X3ZyYW1fbWdyLiBOZWVkIGEgd2F5IHRvIGRldGVjdCBtZW1vcnkKPj4gcHJlc3N1
cmUgc28gd2UgY2FuIHN0YXJ0IGV2aWN0aW5nIG1lbW9yeS4KPj4KPj4gUmVnYXJkcywKPj4gwqDC
oCBGZWxpeAo+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
