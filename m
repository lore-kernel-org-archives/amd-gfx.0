Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F81C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 11:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F906145B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 11:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F906145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA142891B8;
	Tue, 15 Jun 2021 11:45:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0A7891B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 11:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncrXxqMleaIfoPesXvR7+EroyU18eVclngGoUKrpq3xYkvrDPtvqUSBba/WZsGYf8jU1UqLh8CZ+KGIKxoCTifKqF8BTELF0G6rQoDKZuN77NtchEoqz8HQ3oCXBkXEg0u5W1yOhsL2+tE/VMe4sVPby0vrVHbDqR1nVATlIIuPN8WVlKiMo92aO8jVLzjQk/kLvQUZBjyPCJdpGAnsDVJmM+1KpaT/Ye6ERUaErShytq1MktrMh4HrQSTUWifAAh20+FtWN8vFec+lwUSz/8yuT2VW55ln25vcZH7e7No7i1hku6RtjJXyjsc5HGFjsQUCxIlzxIRT/L0mFOctNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IuY871A1NXvAH/E/2epgWVzUZsYOtVyR/rmPopJfhs=;
 b=n6HB1N8EjDob7hQPPCfxCWTPN230QSmszVJGU9VcTEwdUS014e9sTOstfmTr+GGoo3Slu3qeALsx62/XRAEUALvJrFshxF8ZTz8FURrRK5sqDHkKfPN/rw/jnVD+d2vP81PTJNjjgCpWul+XiLVhwTnlPKejHP4f/TH0tcCGB/nrJiNXbasjUWQ2DGYCnHOVliAREmLBG+j4oRFteYwtj02rKLti6quBNV6/wTD/tE660ANuu0CrJ9BaydXTiXZxaC9Etx5BlCMVpP07WlNQrRWW0I1OZxWRWmAyXafU+GS41Xgh3u/8p2+o/iyW+jHdkVxt8ddiznUMxcN8pZWQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IuY871A1NXvAH/E/2epgWVzUZsYOtVyR/rmPopJfhs=;
 b=v7SUgyhAtyY+iSYCyXrgbEpIC3wtKMdPZN7Ta5iuBIySpAOYk6E0Wzlfqvg4ady1FSQuS91dr02byDIKhAuA0sGsGHU08uADeiCsNRPLAD3U4tdPMHUKpzhzei1RelRbpSL/i24tvvf0PFC4HaJJSssOXcWedgoS0QCpgGwFMsU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 15 Jun
 2021 11:45:32 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 11:45:32 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: parameterize ttm BO destroy callback
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210615092400.5023-1-nirmoy.das@amd.com>
 <88296228-0a02-6078-3a0c-85beaec35c5b@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <fde69bfb-d588-212c-eb77-c74f1a980ff9@amd.com>
Date: Tue, 15 Jun 2021 13:45:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <88296228-0a02-6078-3a0c-85beaec35c5b@gmail.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f25:c00:389e:e320:3bf5:cf96]
X-ClientProxiedBy: PR0P264CA0054.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::18) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f25:c00:389e:e320:3bf5:cf96]
 (2003:c5:8f25:c00:389e:e320:3bf5:cf96) by
 PR0P264CA0054.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Tue, 15 Jun 2021 11:45:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a1dccd6-0b78-4071-43f9-08d92ff314fe
X-MS-TrafficTypeDiagnostic: DM4PR12MB5120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51203A9F4A9DBCF0D03BF4168B309@DM4PR12MB5120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8qIYHaeYmLtxUxl9R2G3ejbXzT88XxBCTQ4bdfOSwHl30lWl2E0aADJHzG8JhmEBSRUfCRukrWrvEW0CxW9LSVOrEb6DLaFK9a1vCoJGOYADbxz19hgU5EAbXKmMPKmjLJKCi9xlii6LnpwQnK1OmaG1UmmNZTbWqkX/a5WJCOwuVc0rMKAvNIggt9r2Zx8MT4mS1tFasTa8nKvAq8g39r3FSpdsJG8cPUQ7bF5+RWVdGzarDxu/WV19V2nX+/QaJK+BHJRJUho6BaoCZEuRxKBFYG2EfrpcEcFF3YfoWiPvNG9l3xd98jPDatNWvVigS/jioMbbWJNvt5UQiLqJFng7Nv313BeVAH7zwlA8whypYijgJj1LTQmYSOOWmjx5aj4yWLw4i92Tr+78+5DUpP/cZjcyLF4jepKzl4GgM/2C8As8b/ULkITeg0p8w6mpwjnnsT/HULj4HraP+JZuqtnwrI1X9acnXunMLcCdlS9vDHS+mpjd/7Xlt0qM2sJ6fBzj7e1cCob+ubis/bPeNomb0zlSkxp0i8aLT+r/ID9E/GeDa4s98hPBxQcTK4SspDuvV4Yatxf90RBjBqw1BA6xoUMXhKl99E8js9KjxVmKLmcCvS4aYoAoMI6Aw/8OvwBAlAzVPA0VnjML5aiqfqK3TAm74+hadBi6WZQg+skUIacmoS2jpVUyvGMC9NckTLTWOfngHObcg5yUCbUIBAi72NGgzuwghKh/FbrarA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(6486002)(38100700002)(186003)(66946007)(478600001)(6666004)(45080400002)(966005)(53546011)(31696002)(2906002)(16526019)(83380400001)(8676002)(5660300002)(86362001)(66574015)(36756003)(31686004)(52116002)(316002)(66556008)(66476007)(8936002)(4326008)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTY4bTZEQnFGQlhJcG1NRXBMWU1BOHRDMzNLOGRCZ2dwVmluNVRzMFNIN1M4?=
 =?utf-8?B?dVNxNUpGYXgybEhUU3FraWxqeHhzcXlFOTVTbzBGWTJXRUxReVFLeDQrdW4w?=
 =?utf-8?B?c3hZWnNaV0Q3R29oSjJvbms1bmZVTEhYUTZkTU9ENGRuVXdCeTlPZWVTVmFB?=
 =?utf-8?B?NTBpZGF1RDRiTDVSY0xqR1dwNTFScm4wajVLUmVodFpNblYzbnhKeXBaUFZ4?=
 =?utf-8?B?cUxQSTNBVXJHcGNIVklJMCtlS0NhS2J3eFBtNnNKSE92YjErcjdHblF3dnJW?=
 =?utf-8?B?L2RTWWNoLzQ2cFFUa05DZ1VWZ2Q0SE9VL2lWVzJkWkREYk9XTmMvMWVwNERX?=
 =?utf-8?B?UGdVK3lscDZNUVhNRzViS0pHb3Y2ODhyZmY2M1VmWEEvdXJDL1JQTUNYSFE1?=
 =?utf-8?B?b3BlaGhLcHIwNVpETFF1MldvalJKM2RRSUJZKzVwMEMybzZOZnAwdXVNMTRO?=
 =?utf-8?B?WWxJVE0ySC8rbTZoNXAxRHFrbUR6UE1TdDhUcC9ySysyZ1ZRbmNNcFM0NU1r?=
 =?utf-8?B?c0lCZmE1WHZLa0lqaGhTNUluMHRiTS8wdElzVUx1eTJEbFFESEtEY1B3ZzJD?=
 =?utf-8?B?c0l3RS9NK1ozUk1OcnB0OUdjZnJiUnFnaFNpVVBRamJaN0NQUWVLM1lFM1V0?=
 =?utf-8?B?dWlLcjFuMXhCQ2lqQmY3OWxpeXREVFBTTkk2R25BdTJMNmhHYnhXRXE5RStl?=
 =?utf-8?B?ZTMrZWFHY292T25YZFpBSndnMjhlNzNibHE4anNlbXFSb0g2dlZZQVA4N29I?=
 =?utf-8?B?ZlJCeEVOM253QXg5UUtlejRnZmhSc0V6K1JEaFNLVjIzSlhHb2x5bHd3dmln?=
 =?utf-8?B?MnlSU0Rjd0x0L25HK2xkc2dTR1BsS1d1cFliRGE2MFNvcHVKVFFYa1RSUjlF?=
 =?utf-8?B?T0VpRENlakFNUzFURTJ6SFRwSHhOQ2JuY0JOVENWQXQwSG5raWFHckh6U0NR?=
 =?utf-8?B?Mnh5QjRpWms2V2lNMkd4Rk9FYUtpYytaNnFJYWZoSzhkRW8zSU9uaHM4YWZV?=
 =?utf-8?B?TnR3Q3J5eUwrZFg4djMxQlc4U1Z0MUI2WnJBOGltQkE0Rnl6bWdqVmNYVnNw?=
 =?utf-8?B?RHBWRHNNL3k0V0tvdXExM1FzUGpselJZWE1FbUVzQUprUmN3YUdTK3NubE8v?=
 =?utf-8?B?bCtaOXpmUEY2Q0dISFVaNGZyckp4bS9JMmRsWmtEL2dQVVJIbEwvTnQ5N25R?=
 =?utf-8?B?cFArODZJMldMbVN4WnpxSnRGRy9QLzNJMjhzbTlTTEVyRDBmZFNXWUE1bHRS?=
 =?utf-8?B?MG5ZdDUvTmRiSUdKS3dKMS8wZVVJekxvQk10azAxZ2NjWHdaVldIRXZRWGVv?=
 =?utf-8?B?emh4VkNwQ2t2d0JpSDloWjhDOEZFTC9NS1ozWStDS2tscWRFc05iZ1VMQ3Uw?=
 =?utf-8?B?Y0V6UjlTMmN6MjJrZW5qTHNqMzBmcXNVUmlYZlBOWmw3QTJHZkQwYjNnQWtp?=
 =?utf-8?B?N1hvWGtJOUU1Tlk1emJaMGJtZWxpdXpRRTgvZHFqZGtua2hENHJzSU1FWUlk?=
 =?utf-8?B?VEd4N1poQmp5YWE5d2NwK1FKNWdBSWVqeGljcFhvbXlHT3hQdURlWlJLZ3dR?=
 =?utf-8?B?amhQWDRXeXF0Snc4SUlyRk5FMjJVNm1IYlljNk0zTkdTcHg2bHZMcHk5TzE1?=
 =?utf-8?B?bjBJQXRnN2F1VFpyMW0yOW5nQ0ZhdTB3S0JxT2xTMjZOckFkM3lTTkFmZ3Jy?=
 =?utf-8?B?c0ZTWUw5cjBxSS9YcmczSUZmZVdGWDl5M1JjQ2FlSER2Vnd1aWRwdmIwUWFK?=
 =?utf-8?B?QnA1YTlLeElrSXZuSm5TeVRlbFJDUmFSN2hVV0dvbVpwMjBMVzRScEpBSWdY?=
 =?utf-8?B?dnB6TGp6d2ViUlc2KzJacEJnUjV4VnhEMWJXbklRMHFOM2pOczNhN0wyVnIz?=
 =?utf-8?Q?OuWTPr75UFCbY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1dccd6-0b78-4071-43f9-08d92ff314fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 11:45:32.8120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F96UfAIzHU3WQumZ8jUZzIITWxDsKoQqtIesPiWujDu1Sp5WeYRTFh/DCW3BU3f2FEASii5ftP4gOQQvGKpMXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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
Cc: Christian.Koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDYvMTUvMjAyMSAxMjo0OCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPgo+Cj4gQW0g
MTUuMDYuMjEgdW0gMTE6MjMgc2NocmllYiBOaXJtb3kgRGFzOgo+PiBNYWtlIHByb3Zpc2lvbiB0
byBwYXNzIGRpZmZlcmVudCB0dG0gQk8gZGVzdHJveSBjYWxsYmFjawo+PiB3aGlsZSBjcmVhdGlu
ZyBhIGFtZGdwdV9iby4KPj4KPj4gdjI6IHJlbW92ZSB3aGl0ZXNwYWNlLgo+PiDCoMKgwqDCoCBj
YWxsIGFtZGdwdV9ib19kZXN0cm95X2Jhc2UoKSBhdCB0aGUgZW5kIGZvciBjbGVhbmVyIGNvZGUu
Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4g
LS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDQ4
ICsrKysrKysrKysrKysrKystLS0tLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X29iamVjdC5oIHzCoCAzICstCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0
aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X29iamVjdC5jCj4+IGluZGV4IDkwOTJhYzEyYTI3MC4uODQ3M2QxNTM2NTBm
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+
IEBAIC03MywxMSArNzMsOSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfYm9fc3VidHJhY3RfcGluX3Np
emUoc3RydWN0IAo+PiBhbWRncHVfYm8gKmJvKQo+PiDCoMKgwqDCoMKgIH0KPj4gwqAgfQo+Pgo+
PiAtc3RhdGljIHZvaWQgYW1kZ3B1X2JvX2Rlc3Ryb3koc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0
ICp0Ym8pCj4+ICtzdGF0aWMgdm9pZCBhbWRncHVfYm9fZGVzdHJveV9iYXNlKHN0cnVjdCB0dG1f
YnVmZmVyX29iamVjdCAqdGJvKQo+Cj4gSSB0aGluayB5b3UgZG9uJ3QgZXZlbiBuZWVkIHRvIHJl
bmFtZSB0aGUgZnVuY3Rpb24uCj4KPj4gwqAgewo+PiAtwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KHRiby0+YmRldik7Cj4+IMKgwqDCoMKgwqAgc3Ry
dWN0IGFtZGdwdV9ibyAqYm8gPSB0dG1fdG9fYW1kZ3B1X2JvKHRibyk7Cj4+IC3CoMKgwqAgc3Ry
dWN0IGFtZGdwdV9ib191c2VyICp1Ym87Cj4+Cj4+IMKgwqDCoMKgwqAgaWYgKGJvLT50Ym8ucGlu
X2NvdW50ID4gMCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9ib19zdWJ0cmFjdF9waW5f
c2l6ZShibyk7Cj4+IEBAIC04NywyMCArODUsMzggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2JvX2Rl
c3Ryb3koc3RydWN0IAo+PiB0dG1fYnVmZmVyX29iamVjdCAqdGJvKQo+PiDCoMKgwqDCoMKgIGlm
IChiby0+dGJvLmJhc2UuaW1wb3J0X2F0dGFjaCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRybV9w
cmltZV9nZW1fZGVzdHJveSgmYm8tPnRiby5iYXNlLCBiby0+dGJvLnNnKTsKPj4gwqDCoMKgwqDC
oCBkcm1fZ2VtX29iamVjdF9yZWxlYXNlKCZiby0+dGJvLmJhc2UpOwo+PiArwqDCoMKgIGFtZGdw
dV9ib191bnJlZigmYm8tPnBhcmVudCk7Cj4+ICvCoMKgwqAga3ZmcmVlKGJvKTsKPj4gK30KPj4g
Kwo+PiArc3RhdGljIHZvaWQgYW1kZ3B1X2JvX2Rlc3Ryb3koc3RydWN0IHR0bV9idWZmZXJfb2Jq
ZWN0ICp0Ym8pCj4+ICt7Cj4+ICvCoMKgwqAgYW1kZ3B1X2JvX2Rlc3Ryb3lfYmFzZSh0Ym8pOwo+
PiArfQo+Cj4gTm9yIGhhcyB0aGF0IHdyYXBwZXIgaGVyZS4KPgo+IEFwYXJ0IGZyb20gdGhhdCBs
b29rcyBnb29kIHRvIG1lLgoKClRoYW5rcywgbGV0IG1lIHJlc2VuZCB3aXRoIHRoYXQuCgoKTmly
bW95Cgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+ICsKPj4gK3N0YXRpYyB2b2lkIGFtZGdwdV9ib191c2Vy
X2Rlc3Ryb3koc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICp0Ym8pCj4+ICt7Cj4+ICvCoMKgwqAg
c3RydWN0IGFtZGdwdV9ibyAqYm8gPSB0dG1fdG9fYW1kZ3B1X2JvKHRibyk7Cj4+ICvCoMKgwqAg
c3RydWN0IGFtZGdwdV9ib191c2VyICp1Ym87Cj4+ICsKPj4gK8KgwqDCoCB1Ym8gPSB0b19hbWRn
cHVfYm9fdXNlcihibyk7Cj4+ICvCoMKgwqAga2ZyZWUodWJvLT5tZXRhZGF0YSk7Cj4+ICvCoMKg
wqAgYW1kZ3B1X2JvX2Rlc3Ryb3lfYmFzZSh0Ym8pOwo+PiArfQo+PiArCj4+ICtzdGF0aWMgdm9p
ZCBhbWRncHVfYm9fdm1fZGVzdHJveShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKnRibykKPj4g
K3sKPj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGFtZGdwdV90dG1fYWRl
dih0Ym8tPmJkZXYpOwo+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKmJvID0gdHRtX3RvX2Ft
ZGdwdV9ibyh0Ym8pOwo+PiArCj4+IMKgwqDCoMKgwqAgLyogaW4gY2FzZSBhbWRncHVfZGV2aWNl
X3JlY292ZXJfdnJhbSBnb3QgTlVMTCBvZiBiby0+cGFyZW50ICovCj4+IMKgwqDCoMKgwqAgaWYg
KCFsaXN0X2VtcHR5KCZiby0+c2hhZG93X2xpc3QpKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBt
dXRleF9sb2NrKCZhZGV2LT5zaGFkb3dfbGlzdF9sb2NrKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGxpc3RfZGVsX2luaXQoJmJvLT5zaGFkb3dfbGlzdCk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBt
dXRleF91bmxvY2soJmFkZXYtPnNoYWRvd19saXN0X2xvY2spOwo+PiDCoMKgwqDCoMKgIH0KPj4g
LcKgwqDCoCBhbWRncHVfYm9fdW5yZWYoJmJvLT5wYXJlbnQpOwo+PiAtCj4+IC3CoMKgwqAgaWYg
KGJvLT50Ym8udHlwZSAhPSB0dG1fYm9fdHlwZV9rZXJuZWwpIHsKPj4gLcKgwqDCoMKgwqDCoMKg
IHVibyA9IHRvX2FtZGdwdV9ib191c2VyKGJvKTsKPj4gLcKgwqDCoMKgwqDCoMKgIGtmcmVlKHVi
by0+bWV0YWRhdGEpOwo+PiAtwqDCoMKgIH0KPj4KPj4gLcKgwqDCoCBrdmZyZWUoYm8pOwo+PiAr
wqDCoMKgIGFtZGdwdV9ib19kZXN0cm95X2Jhc2UodGJvKTsKPj4gwqAgfQo+Pgo+PiDCoCAvKioK
Pj4gQEAgLTExNSw4ICsxMzEsMTEgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2JvX2Rlc3Ryb3koc3Ry
dWN0IAo+PiB0dG1fYnVmZmVyX29iamVjdCAqdGJvKQo+PiDCoMKgICovCj4+IMKgIGJvb2wgYW1k
Z3B1X2JvX2lzX2FtZGdwdV9ibyhzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQo+PiDCoCB7
Cj4+IC3CoMKgwqAgaWYgKGJvLT5kZXN0cm95ID09ICZhbWRncHVfYm9fZGVzdHJveSkKPj4gK8Kg
wqDCoCBpZiAoYm8tPmRlc3Ryb3kgPT0gJmFtZGdwdV9ib19kZXN0cm95IHx8Cj4+ICvCoMKgwqDC
oMKgwqDCoCBiby0+ZGVzdHJveSA9PSAmYW1kZ3B1X2JvX3VzZXJfZGVzdHJveSB8fAo+PiArwqDC
oMKgwqDCoMKgwqAgYm8tPmRlc3Ryb3kgPT0gJmFtZGdwdV9ib192bV9kZXN0cm95KQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4+ICsKPj4gwqDCoMKgwqDCoCByZXR1cm4gZmFs
c2U7Cj4+IMKgIH0KPj4KPj4gQEAgLTU5Miw5ICs2MTEsMTIgQEAgaW50IGFtZGdwdV9ib19jcmVh
dGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+IMKgwqDCoMKgwqAgaWYgKGJwLT50eXBl
ID09IHR0bV9ib190eXBlX2tlcm5lbCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJvLT50Ym8ucHJp
b3JpdHkgPSAxOwo+Pgo+PiArwqDCoMKgIGlmICghYnAtPmRlc3Ryb3kpCj4+ICvCoMKgwqDCoMKg
wqDCoCBicC0+ZGVzdHJveSA9ICZhbWRncHVfYm9fZGVzdHJveTsKPj4gKwo+PiDCoMKgwqDCoMKg
IHIgPSB0dG1fYm9faW5pdF9yZXNlcnZlZCgmYWRldi0+bW1hbi5iZGV2LCAmYm8tPnRibywgc2l6
ZSwgCj4+IGJwLT50eXBlLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
JmJvLT5wbGFjZW1lbnQsIHBhZ2VfYWxpZ24sICZjdHgsIE5VTEwsCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBicC0+cmVzdiwgJmFtZGdwdV9ib19kZXN0cm95KTsKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJwLT5yZXN2LCBicC0+ZGVzdHJveSk7Cj4+
IMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KHIgIT0gMCkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gcjsKPj4KPj4gQEAgLTY1OCw2ICs2ODAsNyBAQCBpbnQgYW1kZ3B1X2JvX2NyZWF0ZV91
c2VyKHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+PiAqYWRldiwKPj4gwqDCoMKgwqDCoCBpbnQgcjsK
Pj4KPj4gwqDCoMKgwqDCoCBicC0+Ym9fcHRyX3NpemUgPSBzaXplb2Yoc3RydWN0IGFtZGdwdV9i
b191c2VyKTsKPj4gK8KgwqDCoCBicC0+ZGVzdHJveSA9ICZhbWRncHVfYm9fdXNlcl9kZXN0cm95
Owo+PiDCoMKgwqDCoMKgIHIgPSBhbWRncHVfYm9fY3JlYXRlKGFkZXYsIGJwLCAmYm9fcHRyKTsK
Pj4gwqDCoMKgwqDCoCBpZiAocikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByOwo+PiBA
QCAtNjg5LDYgKzcxMiw3IEBAIGludCBhbWRncHVfYm9fY3JlYXRlX3ZtKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+PiDCoMKgwqDCoMKgwqAgKiBudW0gb2YgYW1kZ3B1X3ZtX3B0IGVudHJp
ZXMuCj4+IMKgwqDCoMKgwqDCoCAqLwo+PiDCoMKgwqDCoMKgIEJVR19PTihicC0+Ym9fcHRyX3Np
emUgPCBzaXplb2Yoc3RydWN0IGFtZGdwdV9ib192bSkpOwo+PiArwqDCoMKgIGJwLT5kZXN0cm95
ID0gJmFtZGdwdV9ib192bV9kZXN0cm95Owo+PiDCoMKgwqDCoMKgIHIgPSBhbWRncHVfYm9fY3Jl
YXRlKGFkZXYsIGJwLCAmYm9fcHRyKTsKPj4gwqDCoMKgwqDCoCBpZiAocikKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiByOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X29iamVjdC5oIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9vYmplY3QuaAo+PiBpbmRleCBlMzZiODQ1MTZiNGUuLmE4YzcwMjYzNGUxYiAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+PiBAQCAtNTUs
NyArNTUsOCBAQCBzdHJ1Y3QgYW1kZ3B1X2JvX3BhcmFtIHsKPj4gwqDCoMKgwqDCoCB1NjTCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhZ3M7Cj4+IMKgwqDCoMKgwqAgZW51bSB0dG1f
Ym9fdHlwZcKgwqDCoMKgwqDCoMKgIHR5cGU7Cj4+IMKgwqDCoMKgwqAgYm9vbMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBub193YWl0X2dwdTsKPj4gLcKgwqDCoCBzdHJ1Y3QgZG1hX3Jl
c3bCoMKgwqAgKnJlc3Y7Cj4+ICvCoMKgwqAgc3RydWN0IGRtYV9yZXN2wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqcmVzdjsKPj4gK8KgwqDCoCB2b2lkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICgqZGVzdHJveSkoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibyk7Cj4+IMKgIH07Cj4+
Cj4+IMKgIC8qIGJvIHZpcnR1YWwgYWRkcmVzc2VzIGluIGEgdm0gKi8KPj4gLS0gCj4+IDIuMzEu
MQo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZh
bWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NuaXJtb3kuZGFzJTQwYW1kLmNvbSU3Q2IzMjFkZGM1
OTA0MDQyNTZlOWM4MDhkOTJmZWIyYTBhJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4
M2QlN0MwJTdDMCU3QzYzNzU5MzUwOTMzMTQ4OTM0OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhl
eUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
STZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1ZM3pRcm5BZm56U2FsR1JrTlJwOU9jZ3I0bE9aWjBN
dENQTEpvZ2h2RDBjJTNEJmFtcDtyZXNlcnZlZD0wIAo+Pgo+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
