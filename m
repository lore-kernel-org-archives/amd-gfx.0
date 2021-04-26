Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C4C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 16:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6EF6127A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 16:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6EF6127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F366F89369;
	Mon, 26 Apr 2021 16:33:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F408189369
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 16:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juhWDbJodiahlBLr9cqfANLfRz3EG+Tl+3wfahrhc5WGrNR4Cqjl1tK1wmoCF9f11+Po/yQL83BpYocUyVw7pRA2qj92KA+uokhUh0xjk1QFFTgNaMMT3NPW6ZbIvBU1XQMf6w8XL40Ra853ecj0iiVF9Xs5pJTdwO1zFYJo/N0XjE0CI1TS0VEggEj+u6l501sjDPgrre4TRzwlcHbmyoNvCTzqIisRhM/3aFSIhG20GbLotgG5f/nXuEjnQuCdVwXhROhpx6LvtTzHSXKm1VQgI9WhoVtAa2XNYGYct3x+SKl1AG0/9GSOgi5KflKoUtal+iPos0EV6e5t14DIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx+1qjrYQbBDfBb9MHqkaRet4EKYofzb6D+zP5Hyfwg=;
 b=kinPNQ76yPoGsEAa4jJj16gJd7+hYKQpdFzKkBw7WFoZ/H11t0HWDbH9+Ss9JZUGb216JHppA9Z4qNlD7k7xmgCMN9eb7PzXKLMdMakNpI/TpW+3f7TCcl0/UO1hlRICJPWHVfXQlQBRpPO3Az3Nt+MjPg3t6dH8KA8evPJutplYLIU4sWqsI10bQDrgJbxacSlB8biFqGMMOl7jP+OjTmdLFQAKZz5HXKIEdleCSOg80lmZVEqvarbkUdQgyNGwQXwdYOpnyj57cJmDylHbRbuu/NzxHpX+Yu+9lacDEDdSZU5ORsExq1tticmqILhjWBPrcJrou/vvuxr9eVMYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx+1qjrYQbBDfBb9MHqkaRet4EKYofzb6D+zP5Hyfwg=;
 b=IN0X4gvp1X2kI8W6i/uJhAj13RqtvO9/cPff9bCk46cgty9yt45xWT2SSgdsjD27Pf9aFEzUNlb+ndOkXr46YllkJ5z9KAAXawWK8sMKa9cgF2gouNWMVMUxYMlrovD0eCgl/gks9wrtMXBkZoGquPMjG/J9/baaMGyJoy2U/AY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 16:33:39 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Mon, 26 Apr 2021
 16:33:39 +0000
Subject: Re: [PATCH] drm/amdgpu: restructure amdgpu_vram_mgr_new
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210426085434.2974-1-christian.koenig@amd.com>
 <3bcff580-1c9c-c9ab-b5f1-263ea2388cb1@amd.com>
 <888ba759-d316-5aaf-f3c4-d5380d63b795@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2115a868-6baf-cc4e-a67a-d16a3d3e035a@amd.com>
Date: Mon, 26 Apr 2021 12:33:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <888ba759-d316-5aaf-f3c4-d5380d63b795@gmail.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend
 Transport; Mon, 26 Apr 2021 16:33:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf63fa7b-6215-48b2-0519-08d908d10c30
X-MS-TrafficTypeDiagnostic: MN2PR12MB4253:
X-Microsoft-Antispam-PRVS: <MN2PR12MB425364606B77431A0EEBE5D192429@MN2PR12MB4253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuFjgUC5qmaPin3v3lYuINRsWo4WdbqS89VqVg1rQ7AnAAfCyFcShX1TYoYmv8e8QdQpKNw9mKdNC+LTHCR2/E39+48k/G3RQukhA/55sIwEJS1anpND1n0cQ1Hbbwj1zo1YvLkpPU/UFpNvZPUhUdRdiFmxYL9dfHTNvC/L1oG4dwrCjEjfS5FUqvN5leOsnfCxQPoPsCZXpN3EMvWUQ/ujHQFMABZNOelxmLtijAcFTstOL4lBOOTM3AtU9B8bpaXuoIzUeYl177ayNy6Ew2iHFPbda/RpisV7zsam1wnolDTpiOSIMeJ9kARa5oZgAK21HWP16SfMkxMjxzZy5UJaaIU2aNHuw9yTNrG90fmgYQtlt4vwJDsd5FXquwyJSxI/Cm1lu6HWGwmfYiSK5cFy/r1emVJ0RvQla5fLR7q+8Iyvvkxiibc4EXLCl8HufxQfKJRY4zZNiBbMryqj7hZ0kuspZKg1765F0tuRlBGe7PF/wR/JtvHCjk6ZdwuDenes++57b2CunlYdtTPUyW2WwL1k3j/ZrklJo8kXOURR9MECXs/mlDrlSrVZJM9IghC/JbWTzDHyjLlxh5oY2uGA082JUL+X+KAs54s3eYbvClQxsTINv/jCcLs0dx73ua5zOnLP52LYF9aMCP9EyL7IpsLk3Kn6Lq/4mlcCeYdJia2Y4XWYEj8UcP/r6HJh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(6486002)(66574015)(36756003)(5660300002)(31696002)(86362001)(66946007)(44832011)(66556008)(66476007)(83380400001)(26005)(186003)(2906002)(8676002)(8936002)(316002)(478600001)(31686004)(16576012)(38100700002)(956004)(16526019)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S1U1YmVRVzBsVlBtQkkyUC93eWhPMGFKTDY5Y29mcit4TEUzQjk1N0E2VEk0?=
 =?utf-8?B?SGducytJM0dJWTdzcjdJeHVKYktLMkdEVjgwT2JVYnNrT1BsNkRlaU1MV3h5?=
 =?utf-8?B?SytVMGtsR0JLb2o3N1JJNnU3TGFiTXlLdWFCM3g2QW40eVgrS2tlaElBeDUw?=
 =?utf-8?B?NGpmZkJxdklWNm1qRVgvMUFYSFMzckRuMm1qOTlRRTRJYzJxTllmclFGNmRx?=
 =?utf-8?B?V3JOWnd5djdtYklIVE9JVmRVSEFoTEFSMjl0MVF0Q2JnRnNoRUZCWTBESjg4?=
 =?utf-8?B?NVRKRlZKZThJRjBaSkxCVUJFK0RvTkkvZ0JtZWxTbW9ZaUVZOGhERi8vQVlC?=
 =?utf-8?B?d3JFUm5wdGxMazNIbTFSbXFhak45ckNPOUpXWmZhUWl0eDg1bmM1N29YZGJ0?=
 =?utf-8?B?V3RZb2twa3dLMzNhNStaNW1talI2KzJzQ0NQZzArNnpadWl2QWlTcVVweE9N?=
 =?utf-8?B?NFB5eVpucjRWenZjR2NmTVRPK0ZoYkFrSWh1TlBsN3AvT2lPRU1KYkxzRGVC?=
 =?utf-8?B?REFuMEY5ZWtMOUNTSlF6YTdjaE1HZGs2c09PbE5HZ01uSzIzS2VSZ2s5L1Rz?=
 =?utf-8?B?Tzg5ZTRleStIR1o5ZnlubVJZRzdpZE43SVZMQ0N6YmFEV3BZaHZyTjZ6RDdp?=
 =?utf-8?B?Ui9Lc2x0UnE1TXFUWnZ2QW8vL3BTRW90M2ZoSE5ZYkMxdXZtNGJabnErbWJY?=
 =?utf-8?B?Nm8vYm1BYlhybGtVZk8rMnVaTld4QTdKYmJIQnh0bEpuc0lkeDdvV3p5SWxH?=
 =?utf-8?B?SlRxNHdlOFF5TG01L0s4eXhpblV0a2VvajdTY0NwRDRVYmovcTEvVmdQSkZT?=
 =?utf-8?B?UTAzZGJFaGRtbmdYQkFwbGtnN0VxMDk1Tk13R21TbzBmWkNvM1Z2empSSFVm?=
 =?utf-8?B?WHE3QVgrWXJmd251eldqd0Z5UXhrZ1VPMkJNV0xudXpNalQzcWNrbXptT1hC?=
 =?utf-8?B?YUY2Y3VhTm9rcjByNFJYRE1US0FIcVRKcnZaTENCbkZ5Q2NnZHZWZ2JmUmxs?=
 =?utf-8?B?UEZnd0QrUHJsQ0hXUHoxSk4zUGMveHNlQ3Btb20rRmdUTDV1UUVzdE9TbUhG?=
 =?utf-8?B?azJ3Yk9kNmREK01wMW5DSnNvUXdxMmlYU05OU2FXWGorT0dVSDNZWkNRbW05?=
 =?utf-8?B?MFo5OHg3eDZXU2VPU1lHaWNSYkozTXp1M0JBU1JTa0dld0pWUjVRWWZDM2Rv?=
 =?utf-8?B?bWRjZU9CMU9nS3pRS2RZNnBqM0thNWh3K2JSWElBNGRCVjdTWUl4ZUx0SGxq?=
 =?utf-8?B?Uno1ZU5tRGxreWh3Y3h2SmZpWklVTEV5Vm5waE40S01LM0lSSlVHN0pHNWVt?=
 =?utf-8?B?bksyRXhFQ0RNWDZpNG9wam95a3VYOU1pSVRJU0txblZ4Z2RaUmh2d3p5NXdz?=
 =?utf-8?B?MnBMUFJjaGFtMkgvTXZQbSs5d2NHc3ZXUDVMWVpyMDhKak5OdzFTb0hKcTdx?=
 =?utf-8?B?b2ZzTjIrUlZBeFhtNG1zdE5wZjBmRE85a2s3QXNBOERSYThJb0w0QmZsMXlX?=
 =?utf-8?B?NnBTQVFOcFRMeUNuY0MzVkRQV2ZnSkdJcFlkK2VMenZ0a2cvaEdMbThaaHN1?=
 =?utf-8?B?LzVYYmxVSUd6ZEljUW9rSXpLTjRScnEwTS9RbEk4Tkc5YkpENUUwQndrc0pr?=
 =?utf-8?B?N0ZjaDNHS0pFM0RpRXUwbzM3QjRJTW1YMzNsVjFVSjE5RHhtSXdFcTdFVDh4?=
 =?utf-8?B?dXdBazBkREc5WnF2a0YrS1pVam5HWXlrbWFVMWo2ck4xMkZHMkg3WVJBWnFj?=
 =?utf-8?Q?kzIF+2+KJZKCHuRuwcJE9rgNZNKZzpmAN8v9ecX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf63fa7b-6215-48b2-0519-08d908d10c30
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 16:33:39.6202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ILBprxNfi0SOaMnvM62RtcbiSNn7HDZ25j0YnVz7JqQd5Xv2JQSbnUuFyBRUODH97UDRjHcdWLplsi6Y86d3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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

CkFtIDIwMjEtMDQtMjYgdW0gMTI6MTIgcC5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4K
Pgo+IEFtIDI2LjA0LjIxIHVtIDE4OjAyIHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+IEFtIDIw
MjEtMDQtMjYgdW0gNDo1NCBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4+IE1lcmdl
IHRoZSB0d28gbG9vcHMsIGxvb3NlbiB0aGUgcmVzdHJpY3Rpb24gZm9yIGJpZyBhbGxvY2F0aW9u
cy4KPj4+IFRoaXMgcmVkdWNlcyB0aGUgQ1BVIG92ZXJoZWFkIGluIHRoZSBnb29kIGNhc2UsIGJ1
dCBpbmNyZWFzZXMKPj4+IGl0IGEgYml0IHVuZGVyIG1lbW9yeSBwcmVzc3VyZS4KPj4+Cj4+PiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21n
ci5jIHwgNTgKPj4+ICsrKysrKysrKy0tLS0tLS0tLS0tCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwg
MjcgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jCj4+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jCj4+PiBpbmRleCA1MjljNWMzMmEy
MDUuLmUyY2JlMTk0MDRjMCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92cmFtX21nci5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdnJhbV9tZ3IuYwo+Pj4gQEAgLTM1OCwxMyArMzU4LDEzIEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3QKPj4+IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4s
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHN0cnVj
dCB0dG1fcGxhY2UgKnBsYWNlLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgdHRtX3Jlc291cmNlICptZW0pCj4+PiDCoCB7Cj4+PiArwqDCoMKgIHVu
c2lnbmVkIGxvbmcgbHBmbiwgbnVtX25vZGVzLCBwYWdlc19wZXJfbm9kZSwgcGFnZXNfbGVmdCwg
cGFnZXM7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfdnJhbV9tZ3IgKm1nciA9IHRvX3Zy
YW1fbWdyKG1hbik7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0g
dG9fYW1kZ3B1X2RldmljZShtZ3IpOwo+Pj4gK8KgwqDCoCB1aW50NjRfdCB2aXNfdXNhZ2UgPSAw
LCBtZW1fYnl0ZXMsIG1heF9ieXRlczsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IGRybV9tbSAqbW0g
PSAmbWdyLT5tbTsKPj4+IC3CoMKgwqAgc3RydWN0IGRybV9tbV9ub2RlICpub2RlczsKPj4+IMKg
wqDCoMKgwqAgZW51bSBkcm1fbW1faW5zZXJ0X21vZGUgbW9kZTsKPj4+IC3CoMKgwqAgdW5zaWdu
ZWQgbG9uZyBscGZuLCBudW1fbm9kZXMsIHBhZ2VzX3Blcl9ub2RlLCBwYWdlc19sZWZ0Owo+Pj4g
LcKgwqDCoCB1aW50NjRfdCB2aXNfdXNhZ2UgPSAwLCBtZW1fYnl0ZXMsIG1heF9ieXRlczsKPj4+
ICvCoMKgwqAgc3RydWN0IGRybV9tbV9ub2RlICpub2RlczsKPj4+IMKgwqDCoMKgwqAgdW5zaWdu
ZWQgaTsKPj4+IMKgwqDCoMKgwqAgaW50IHI7Cj4+PiDCoCBAQCAtMzkxLDkgKzM5MSwxMCBAQCBz
dGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXcoc3RydWN0Cj4+PiB0dG1fcmVzb3VyY2VfbWFu
YWdlciAqbWFuLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBhZ2VzX3Blcl9ub2RlID0gSFBBR0Vf
UE1EX05SOwo+Pj4gwqAgI2Vsc2UKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBkZWZhdWx0IHRv
IDJNQiAqLwo+Pj4gLcKgwqDCoMKgwqDCoMKgIHBhZ2VzX3Blcl9ub2RlID0gKDJVTCA8PCAoMjBV
TCAtIFBBR0VfU0hJRlQpKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBwYWdlc19wZXJfbm9kZSA9IDJV
TCA8PCAoMjBVTCAtIFBBR0VfU0hJRlQpOwo+Pj4gwqAgI2VuZGlmCj4+PiAtwqDCoMKgwqDCoMKg
wqAgcGFnZXNfcGVyX25vZGUgPSBtYXgoKHVpbnQzMl90KXBhZ2VzX3Blcl9ub2RlLAo+Pj4gbWVt
LT5wYWdlX2FsaWdubWVudCk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcGFnZXNfcGVyX25vZGUgPSBt
YXhfdCh1aW50MzJfdCwgcGFnZXNfcGVyX25vZGUsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVtLT5wYWdlX2FsaWdubWVudCk7Cj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgbnVtX25vZGVzID0gRElWX1JPVU5EX1VQKG1lbS0+bnVtX3BhZ2VzLCBwYWdl
c19wZXJfbm9kZSk7Cj4+PiDCoMKgwqDCoMKgIH0KPj4+IMKgIEBAIC00MTEsNDIgKzQxMiwzNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXcoc3RydWN0Cj4+PiB0dG1fcmVzb3VyY2Vf
bWFuYWdlciAqbWFuLAo+Pj4gwqDCoMKgwqDCoCBtZW0tPnN0YXJ0ID0gMDsKPj4+IMKgwqDCoMKg
wqAgcGFnZXNfbGVmdCA9IG1lbS0+bnVtX3BhZ2VzOwo+Pj4gwqAgLcKgwqDCoCBzcGluX2xvY2so
Jm1nci0+bG9jayk7Cj4+PiAtwqDCoMKgIGZvciAoaSA9IDA7IHBhZ2VzX2xlZnQgPj0gcGFnZXNf
cGVyX25vZGU7ICsraSkgewo+Pj4gLcKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgcGFnZXMg
PSByb3VuZGRvd25fcG93X29mX3R3byhwYWdlc19sZWZ0KTsKPj4+IC0KPj4+IC3CoMKgwqDCoMKg
wqDCoCAvKiBMaW1pdCBtYXhpbXVtIHNpemUgdG8gMkdCIGR1ZSB0byBTRyB0YWJsZSBsaW1pdGF0
aW9ucyAqLwo+Pj4gLcKgwqDCoMKgwqDCoMKgIHBhZ2VzID0gbWluKHBhZ2VzLCAoMlVMIDw8ICgz
MCAtIFBBR0VfU0hJRlQpKSk7Cj4+PiArwqDCoMKgIC8qIExpbWl0IG1heGltdW0gc2l6ZSB0byAy
R0IgZHVlIHRvIFNHIHRhYmxlIGxpbWl0YXRpb25zICovCj4+PiArwqDCoMKgIHBhZ2VzID0gbWlu
KHBhZ2VzX2xlZnQsIDJVTCA8PCAoMzAgLSBQQUdFX1NISUZUKSk7Cj4+PiDCoCAtwqDCoMKgwqDC
oMKgwqAgciA9IGRybV9tbV9pbnNlcnRfbm9kZV9pbl9yYW5nZShtbSwgJm5vZGVzW2ldLCBwYWdl
cywKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBh
Z2VzX3Blcl9ub2RlLCAwLAo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcGxhY2UtPmZwZm4sIGxwZm4sCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtb2RlKTsKPj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAo
dW5saWtlbHkocikpCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4+IC0KPj4+
IC3CoMKgwqDCoMKgwqDCoCB2aXNfdXNhZ2UgKz0gYW1kZ3B1X3ZyYW1fbWdyX3Zpc19zaXplKGFk
ZXYsICZub2Rlc1tpXSk7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3ZyYW1fbWdyX3ZpcnRf
c3RhcnQobWVtLCAmbm9kZXNbaV0pOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIHBhZ2VzX2xlZnQgLT0g
cGFnZXM7Cj4+PiAtwqDCoMKgIH0KPj4+IC0KPj4+IC3CoMKgwqAgZm9yICg7IHBhZ2VzX2xlZnQ7
ICsraSkgewo+Pj4gLcKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgcGFnZXMgPSBtaW4ocGFn
ZXNfbGVmdCwgcGFnZXNfcGVyX25vZGUpOwo+Pj4gK8KgwqDCoCBpID0gMDsKPj4+ICvCoMKgwqAg
c3Bpbl9sb2NrKCZtZ3ItPmxvY2spOwo+Pj4gK8KgwqDCoCB3aGlsZSAocGFnZXNfbGVmdCkgewo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGFsaWdubWVudCA9IG1lbS0+cGFnZV9hbGln
bm1lbnQ7Cj4+PiDCoCAtwqDCoMKgwqDCoMKgwqAgaWYgKHBhZ2VzID09IHBhZ2VzX3Blcl9ub2Rl
KQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChwYWdlcyA+PSBwYWdlc19wZXJfbm9kZSkKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFsaWdubWVudCA9IHBhZ2VzX3Blcl9ub2RlOwo+Pj4g
wqAgLcKgwqDCoMKgwqDCoMKgIHIgPSBkcm1fbW1faW5zZXJ0X25vZGVfaW5fcmFuZ2UobW0sICZu
b2Rlc1tpXSwKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHBhZ2VzLCBhbGlnbm1lbnQsIDAsCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBwbGFjZS0+ZnBmbiwgbHBmbiwKPj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1vZGUpOwo+Pj4gLcKgwqDCoMKgwqDC
oMKgIGlmICh1bmxpa2VseShyKSkKPj4+ICvCoMKgwqDCoMKgwqDCoCByID0gZHJtX21tX2luc2Vy
dF9ub2RlX2luX3JhbmdlKG1tLCAmbm9kZXNbaV0sIHBhZ2VzLAo+Pj4gYWxpZ25tZW50LAo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCwgcGxhY2Ut
PmZwZm4sIGxwZm4sIG1vZGUpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICh1bmxpa2VseShyKSkg
ewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHBhZ2VzID4gcGFnZXNfcGVyX25vZGUp
IHsKPj4gVGhpcyBtZWFucyB3ZSBjYW4gbmV2ZXIgYWxsb2NhdGUgY2h1bmtzIHNtYWxsZXIgdGhh
biAyTUIsIGV4Y2VwdCBmb3IgdGhlCj4+IHRhaWwuIEFuZCB0aGUgdGFpbCBzdGlsbCBuZWVkcyB0
byBiZSBhbGxvY2F0ZWQgaW4gb25lIHBpZWNlIGlmIGl0J3MgPAo+PiAyTUIuCj4KPiBDb3JyZWN0
LCBidXQgdGhhdCB3YXMgdGhlIGJlaGF2aW9yIGJlZm9yZSBhcyB3ZWxsLgo+Cj4+IE9uIHRoZSBv
dGhlciBoYW5kLCB3ZSBzaG91bGQgbm90IGFsbG93IGFsbG9jYXRpb25zIHNtYWxsZXIgdGhhbgo+
PiBtZW0tPnBhZ2VfYWxpZ25tZW50LCBleGNlcHQgZm9yIHRoZSB0YWlsLiBTbyBzaG91bGQgdGhp
cyBjb25kaXRpb24gYmUKPj4gImlmIChwYWdlcyA+IG1lbS0+cGFnZV9hbGlnbm1lbnQpIiB0byBh
bGxvdyBtYXhpbXVtIGZsZXhpYmlsaXR5IGZvcgo+PiBhbGxvY2F0aW9ucyB3aXRob3V0IHBoeXNp
Y2FsIGFsaWdubWVudCBjb25zdHJhaW50cyB3aGVuIG1lbW9yeSBpcyB2ZXJ5Cj4+IGZyYWdtZW50
ZWQ/Cj4KPiBTZWUgYSBmZXcgbGluZXMgYWJvdmU6Cj4KPiBwYWdlc19wZXJfbm9kZSA9IG1heF90
KHVpbnQzMl90LCBwYWdlc19wZXJfbm9kZSwgcGFnZV9hbGlnbm1lbnQpOwo+Cj4gU28gcGFnZXNf
cGVyX25vZGUgaXMgYWx3YXlzIGxhcmdlciB0aGFuIHBhZ2VfYWxpZ25tZW50IGFuZCB3ZSBhY3R1
YWxseQo+IGNhbid0IGFsbG9jYXRlIGxlc3MgdGhhbiBwYWdlc19wZXJfbm9kZSBpbiBvbmUgYWxs
b2NhdGlvbiBvciB3ZSB3b3VsZAo+IG92ZXJmbG93IHRoZSBub2RlcyBhcnJheS4KCk1ha2VzIHNl
bnNlLiBUaGUgcGF0Y2ggaXMKClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4KCgoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IFJlZ2Fy
ZHMsCj4+IMKgwqAgRmVsaXgKPj4KPj4KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGlzX3Bvd2VyX29mXzIocGFnZXMpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHBhZ2VzID0gcGFnZXMgLyAyOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlbHNlCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcGFnZXMgPSByb3VuZGRvd25fcG93X29mX3R3byhwYWdlcyk7Cj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJvcjsKPj4+ICvCoMKg
wqDCoMKgwqDCoCB9Cj4+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgdmlzX3VzYWdlICs9IGFtZGdw
dV92cmFtX21ncl92aXNfc2l6ZShhZGV2LCAmbm9kZXNbaV0pOwo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGFtZGdwdV92cmFtX21ncl92aXJ0X3N0YXJ0KG1lbSwgJm5vZGVzW2ldKTsKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBwYWdlc19sZWZ0IC09IHBhZ2VzOwo+Pj4gK8KgwqDCoMKgwqDCoMKgICsr
aTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocGFnZXMgPiBwYWdlc19sZWZ0KQo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFnZXMgPSBwYWdlc19sZWZ0Owo+Pj4gwqDCoMKgwqDC
oCB9Cj4+PiDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZtZ3ItPmxvY2spOwo+Pj4gwqAgCj4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
