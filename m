Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD09DC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 14:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CAD613C1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 14:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CAD613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014C96E432;
	Tue, 11 May 2021 14:44:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770082.outbound.protection.outlook.com [40.107.77.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3662D6E432;
 Tue, 11 May 2021 14:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7Y10rab/sp4G/TQPy1F7SRMvk8g+8PvtzkGp9Ej7VOsSXyNfU7oIxgflh5AdukMWfI6Yn0MdyTRiVyUM/e/sf6eKk/nB0xmrc09Pq+UlBXNdDrO+9xQyyd7137MltBuU6bA5dRyfNHlQ0lv5KkGyKSQlfqKrhxGN8SJKovpTrMo0YfZ8xTkWWZEkEbDQdmz/L7LwOVmzZ+49KVhJeWsHLWuQdIU20DIHBx8SqDR+kY5uG3PsQUqvbnvo6ffkpy8JupqQzwJE4WthKyNrGgBPYX0fsoueUkv30J5wF7BcrU3IdVJFH8KGUV16jBFSyuXHrGNAU5AylXKbmjsKhT+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCI9deZayktKRRS+2BGIoi+lzJrd8kXzLp/9qZGNbjI=;
 b=IgXZDFywi19pCHYTBjgNzRi+TjM5dbf8+rjcfCTT6NtA2OhznZ5MjVsu/vSjhmqTNluDnDMLjZtgv1O+WRY1CRcPrM89ekPbwhU80anNng80XjVMaB1K+NJEtxKz5AvldKNv96aOSM0RxBvL2Hz9AiCmQQRfMPXavBeSzVv2Brw6H9jbddlblhZXPDNs76e9NIK31Jm/aALfoN3P1Z6NtSxt1yfEMGriVQKbbJYKKaBfYYtjeHNicHL5OBFEecBKIacFEnXFBCYqzMRJ7wAbsjvYShxGidBsA7nFrCxh5WqT3LQAWJYhGSaGVTm6czAX/oAkEju3EdIrqWBs/rrptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCI9deZayktKRRS+2BGIoi+lzJrd8kXzLp/9qZGNbjI=;
 b=XJsFuoW9Q9Nbd+paqXtIqMXb1cKmwVl+qA0tS474H5gOxI9XX8Jjsov7jLPxSTDXeviAzHqvp1niTHTUHTAubKB7YuqPVz9WVIPQ7O80rA/BXJpP8ZTw3r/H8oQSBGIhyUMh7a9fuZDH2iuP3Od6UXoB9bWkAPUYbyw/EvDFyHw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4765.namprd12.prod.outlook.com (2603:10b6:805:e4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 14:44:38 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 14:44:38 +0000
Subject: Re: [PATCH v6 01/16] drm/ttm: Remap all page faults to per process
 dummy page.
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-2-andrey.grodzovsky@amd.com>
 <e4bb49b1-393d-10aa-7e18-f445d7e71ef7@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <897f1ca4-9e78-1136-961e-18e6c2cbab50@amd.com>
Date: Tue, 11 May 2021 10:44:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <e4bb49b1-393d-10aa-7e18-f445d7e71ef7@gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:6a5:47b8:e610:f6a3]
X-ClientProxiedBy: YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::37) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:6a5:47b8:e610:f6a3]
 (2607:fea8:3edf:49b0:6a5:47b8:e610:f6a3) by
 YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Tue, 11 May 2021 14:44:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c18ffd6-b6e0-495c-d44e-08d9148b4d44
X-MS-TrafficTypeDiagnostic: SN6PR12MB4765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4765CC9B2CAF6C2F6EDF0258EA539@SN6PR12MB4765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFEVGxLP+nKxV5SHhCcaxgPRdn5/hLLAXl572o+ImeowvNokItdRTqC8N6BJskO35I6fZxWMyOT97LHfuSRn6njs4ZlSSidAHUWSHnyEIc6CaTE7ZxNrQrI/hn0LceMMsqewBoAkZIbVtDfMbvV1VawzTOZv0gUV5mNSfzyernCfBTPTCCRY999S5to7fMjMoPquRXz3cdZytrb8MLF6b8uCgA7pGDJOUlwbhbRFX6dkE+524baVbPY6c5qM1tNIA1GDGHs5Tlbp+iavs2OV5Bo4SjsBtjv909iuzh1/rFvltm/04DSWLn7Wn6GnRzNRYx5I8RScaiqLcXIxBnLBY+MWTmp8mLj0bt2huvMB29FvPX2c+0qFOSBegG70ZstBLX82YnnEUMCekVoDXsZTkQPzOE68OUKrG0ytxLQZVOuZYPZq6GQfnkgIMvxhFzZ4ID2SUpkdd/TO7DibcGbY/cB6DCE5o8FtMyFkIA4avELMAv4M7/hQdajgF9S2Q+4vRCcNN2F8SbcjhZ1bi8rb+WELm6FTJ0UW7VQdn0XdGXoAzcKxKur6WEIB0XrWJhXGktahrJUcCjtdxI6hB5wSL4hj7SCHi4eg3UiAscGg8pzP221ywsyDMCzlprq7JuavIjfzIkG0ZVaygOFXujqHL2hSXRHA7CnnkEbdheXHPeFSZ+OmgYcc5axJ/G/O7r5c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(31696002)(66574015)(66556008)(44832011)(2906002)(6486002)(186003)(36756003)(83380400001)(8676002)(8936002)(66476007)(2616005)(6636002)(38100700002)(53546011)(16526019)(86362001)(316002)(4326008)(478600001)(66946007)(5660300002)(31686004)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Qlk1NjEyU25qdW9ocWltU0pUaW1SUWhIbDlaY3d1Sjk5YTl3VjNWbE9uM25y?=
 =?utf-8?B?dTZ1dDNEbVFqbWRZM3R4QWFlem0yY1dUR21JMHk4ZWQwMS96TnU5b0hoa0dC?=
 =?utf-8?B?ZXUvSTVqZjNUNkQvWmxKR3dXbTdIU0xoRzBBU05rcndzUUNNNnEwVi9HOTFl?=
 =?utf-8?B?TFgyc1VLK3RXNTZxTzQ5cnFiemxJSzJRYU1nTng4cytqTWYzaXlFL0N3NmY3?=
 =?utf-8?B?bzhaTGJVYndyNCtRMENweEhVblJkeWVWRkIzOVR3OUlSclNERkU3Z0trWlpL?=
 =?utf-8?B?K25ZbXhlbS9Pd1djSHJWRnd1UnhacUVSSlh3R1BIWmQrMWpCRm96QlY4OFNr?=
 =?utf-8?B?VEpKM1Aza1Nxc2s4bmdxWnBMcnhJUWw0UzhucWg1cWZreDc2RWs0VUZtbDNI?=
 =?utf-8?B?NFhvU082TFNsOHpXRGtVYUhDcUdTY25mTmRRREtBUzZ5Wm1FTlgxRzBHM1Ey?=
 =?utf-8?B?eVpZLzQ5N2lFWUxERW1IVk5RWWlheGJPS1Z0UEJpYW42dGJxclRpZ0M4TGRl?=
 =?utf-8?B?YjJMNWFlUFZjV3B1clBkNFRmY1BrL1hybStHMnJteVJHTkdLZ3cxeTA2elEw?=
 =?utf-8?B?ZVpBNmZrcW50cWxNamNhc0NDQllqT0VtYStSNlljMTdJQ3NNY0MwbUtXamNE?=
 =?utf-8?B?Q1UyemtDRUEvSzNiNGJkcE9kRGZ0Y2I0ZVl5YUlWOTJOZUt3YWNVMEtkNGhQ?=
 =?utf-8?B?Qzk5QXJDZEhGWlp6R1FDc2dYK0kyMGFuNG9JWlZ2b2dtbDJsVWUwMjZ0OTdG?=
 =?utf-8?B?M1RqbVpuTXJFWDFaeEkwWW9NMEVwRC9YUitsOFRGeEtkZU5MV0h4S3lUdmU0?=
 =?utf-8?B?RlZZRFJwQW4vcllNYXhZdnZxY010OVc3TEVqRTh3MlpmMzk1T3F3RHVSaDBC?=
 =?utf-8?B?L0R6YmdUeHdLZTZ3bktmR2pVM1B1NXNzZWpHRXVzRlE0TlptaFMzSXVGUVNI?=
 =?utf-8?B?T3NvL1R2QzQwSDA2azJXMWlxVUQ0NmtXN2U4ZmwrT3psR1Y5N0xuSEhmUmcx?=
 =?utf-8?B?VEhzOFkzZEN1Q2NreG0ycS96NFhZdnpEdXdtTm83S0p0ZmwycC85YzBQQjNr?=
 =?utf-8?B?WktURFFkdUIzcy83UFpYeWlFbDhQTjI5QlF0Q290L3h4cUVJSG03YzJuMVNI?=
 =?utf-8?B?RE10K0NxTTRWYW1GcFRkeklqeW45UlR0K2I5T0R0c2JiektyOXdQLzErdWti?=
 =?utf-8?B?YmxGWEo1V3ZwRWJJeUhpb253Vjk4MzRnaUtMRnFJcVBRWm9BT2U5ZVVHQVI4?=
 =?utf-8?B?aGdyRFAvd21FcEhUMzBBQUhWQThNWnJOc0FSYzJFcW9seEY5b0lSbTFpRmk0?=
 =?utf-8?B?Vm45NTlRNmpzNUNBRURXM3JnSjhzUytwMlE1U0ZkV2FYSEYxUldjR0dBRGdN?=
 =?utf-8?B?cEM1eER2RDJPRDQ0R2dNT2dHbHBFYmJQcVFlSzRCSExvamdTWHplOFhQSkRm?=
 =?utf-8?B?NFhtcEFEUGJwdER3Mms0a292WG1sdWpMY1JlU3hhbTAxWlFZeGZ0d285OEpX?=
 =?utf-8?B?MXRzOXJyQnl1eGxLMnFaREdBbVFxaWdYN01MV3JabXVOMHFxQjZVazFKSHg1?=
 =?utf-8?B?Z2JSRWRUS3Z6ZlI5bFhHVnpWVHkrL0o0S1pmT2VmRFVVV1hTbkw3T0hTUTky?=
 =?utf-8?B?QzZOU1h6YWtnL0h5Vk9VK1ZsSmdGNEkyb1JLaTgzWFdZcFRNMjA0YmwvWjMy?=
 =?utf-8?B?SmR5eWY1Z0gzWEVMQkNHWTdET2xuaTRqT3BjZlhOc2sxSnA2WjlRSzBsU04r?=
 =?utf-8?B?U2srQW9zSnlMMk9MYzMwUjhuUTlUS0s4NXc1VzZXM21zYnB4TCtuN0x1a2Ey?=
 =?utf-8?B?MnhXOHIyYnlZdFlNRmUwMU93dk5Zc1VFUEh2SUVyQkkyNGxVQ1FsbFFuckRi?=
 =?utf-8?Q?ZQGao5E6WjbrJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c18ffd6-b6e0-495c-d44e-08d9148b4d44
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 14:44:38.1340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/lVtaRPpMwGqtPqt5TJ+FIS1UNQkJVsTXhGXXfDuNuFwrEaNTXj+GP4CwZ4WfS283QYi5c6/UuhwdvK77nw+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4765
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjEtMDUtMTEgMjozOCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDEw
LjA1LjIxIHVtIDE4OjM2IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+IE9uIGRldmljZSBy
ZW1vdmFsIHJlcm91dGUgYWxsIENQVSBtYXBwaW5ncyB0byBkdW1teSBwYWdlLgo+Pgo+PiB2MzoK
Pj4gUmVtb3ZlIGxvb3AgdG8gZmluZCBEUk0gZmlsZSBhbmQgaW5zdGVhZCBhY2Nlc3MgaXQKPj4g
Ynkgdm1hLT52bV9maWxlLT5wcml2YXRlX2RhdGEuIE1vdmUgZHVtbXkgcGFnZSBpbnN0YWxsYXRp
b24KPj4gaW50byBhIHNlcGFyYXRlIGZ1bmN0aW9uLgo+Pgo+PiB2NDoKPj4gTWFwIHRoZSBlbnRp
cmUgQk9zIFZBIHNwYWNlIGludG8gb24gZGVtYW5kIGFsbG9jYXRlZCBkdW1teSBwYWdlCj4+IG9u
IHRoZSBmaXJzdCBmYXVsdCBmb3IgdGhhdCBCTy4KPj4KPj4gdjU6IFJlbW92ZSBkdXBsaWNhdGUg
cmV0dXJuLgo+Pgo+PiB2NjogUG9saXNoIHR0bV9ib192bV9kdW1teV9wYWdlLCByZW1vdmUgc3Vw
ZXJmbG91cyBjb2RlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5k
cmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS90dG0v
dHRtX2JvX3ZtLmMgfCA1NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KPj4gwqAg
aW5jbHVkZS9kcm0vdHRtL3R0bV9ib19hcGkuaMKgwqDCoCB8wqAgMiArKwo+PiDCoCAyIGZpbGVz
IGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fYm9fdm0uYwo+PiBpbmRleCBiMzFiMTgwNTg5NjUuLmU1YTk2MTU1MTlkMSAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYwo+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jCj4+IEBAIC0zNCw2ICszNCw4IEBACj4+IMKgICNp
bmNsdWRlIDxkcm0vdHRtL3R0bV9ib19kcml2ZXIuaD4KPj4gwqAgI2luY2x1ZGUgPGRybS90dG0v
dHRtX3BsYWNlbWVudC5oPgo+PiDCoCAjaW5jbHVkZSA8ZHJtL2RybV92bWFfbWFuYWdlci5oPgo+
PiArI2luY2x1ZGUgPGRybS9kcm1fZHJ2Lmg+Cj4+ICsjaW5jbHVkZSA8ZHJtL2RybV9tYW5hZ2Vk
Lmg+Cj4+IMKgICNpbmNsdWRlIDxsaW51eC9tbS5oPgo+PiDCoCAjaW5jbHVkZSA8bGludXgvcGZu
X3QuaD4KPj4gwqAgI2luY2x1ZGUgPGxpbnV4L3JidHJlZS5oPgo+PiBAQCAtMzgwLDE5ICszODIs
NzIgQEAgdm1fZmF1bHRfdCB0dG1fYm9fdm1fZmF1bHRfcmVzZXJ2ZWQoc3RydWN0IAo+PiB2bV9m
YXVsdCAqdm1mLAo+PiDCoCB9Cj4+IMKgIEVYUE9SVF9TWU1CT0wodHRtX2JvX3ZtX2ZhdWx0X3Jl
c2VydmVkKTsKPj4gwqAgK3N0YXRpYyB2b2lkIHR0bV9ib19yZWxlYXNlX2R1bW15X3BhZ2Uoc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAKPj4gKnJlcykKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1
Y3QgcGFnZSAqZHVtbXlfcGFnZSA9IChzdHJ1Y3QgcGFnZSAqKXJlczsKPj4gKwo+PiArwqDCoMKg
IF9fZnJlZV9wYWdlKGR1bW15X3BhZ2UpOwo+PiArfQo+PiArCj4+ICt2bV9mYXVsdF90IHR0bV9i
b192bV9kdW1teV9wYWdlKHN0cnVjdCB2bV9mYXVsdCAqdm1mLCBwZ3Byb3RfdCBwcm90KQo+PiAr
ewo+PiArwqDCoMKgIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hID0gdm1mLT52bWE7Cj4+ICvC
oMKgwqAgc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibyA9IHZtYS0+dm1fcHJpdmF0ZV9kYXRh
Owo+PiArwqDCoMKgIHN0cnVjdCBkcm1fZGV2aWNlICpkZGV2ID0gYm8tPmJhc2UuZGV2Owo+PiAr
wqDCoMKgIHZtX2ZhdWx0X3QgcmV0ID0gVk1fRkFVTFRfTk9QQUdFOwo+PiArwqDCoMKgIHVuc2ln
bmVkIGxvbmcgYWRkcmVzczsKPj4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIHBmbjsKPj4gK8KgwqDC
oCBzdHJ1Y3QgcGFnZSAqcGFnZTsKPj4gKwo+PiArwqDCoMKgIC8qIEFsbG9jYXRlIG5ldyBkdW1t
eSBwYWdlIHRvIG1hcCBhbGwgdGhlIFZBIHJhbmdlIGluIHRoaXMgVk1BIAo+PiB0byBpdCovCj4+
ICvCoMKgwqAgcGFnZSA9IGFsbG9jX3BhZ2UoR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8pOwo+PiAr
wqDCoMKgIGlmICghcGFnZSkKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBWTV9GQVVMVF9PT007
Cj4+ICsKPj4gK8KgwqDCoCBwZm4gPSBwYWdlX3RvX3BmbihwYWdlKTsKPj4gKwo+PiArwqDCoMKg
IC8qIFByZWZhdWx0IHRoZSBlbnRpcmUgVk1BIHJhbmdlIHJpZ2h0IGF3YXkgdG8gYXZvaWQgZnVy
dGhlciAKPj4gZmF1bHRzICovCj4+ICvCoMKgwqAgZm9yIChhZGRyZXNzID0gdm1hLT52bV9zdGFy
dDsgYWRkcmVzcyA8IHZtYS0+dm1fZW5kOyBhZGRyZXNzICs9IAo+PiBQQUdFX1NJWkUpIHsKPj4g
Kwo+Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAodW5saWtlbHkoYWRkcmVzcyA+PSB2bWEtPnZtX2Vu
ZCkpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Cj4gVGhhdCBleHRyYSBjaGVj
ayBjYW4gYmUgcmVtb3ZlZCBhcyBmYXIgYXMgSSBjYW4gc2VlLgo+Cj4KPj4gKwo+PiArwqDCoMKg
wqDCoMKgwqAgaWYgKHZtYS0+dm1fZmxhZ3MgJiBWTV9NSVhFRE1BUCkKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0ID0gdm1mX2luc2VydF9taXhlZF9wcm90KHZtYSwgYWRkcmVzcywKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBf
X3Bmbl90b19wZm5fdChwZm4sIFBGTl9ERVYpLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByb3QpOwo+PiArwqDCoMKgwqDCoMKgwqAg
ZWxzZQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSB2bWZfaW5zZXJ0X3Bmbl9wcm90
KHZtYSwgYWRkcmVzcywgcGZuLCBwcm90KTsKPj4gK8KgwqDCoCB9Cj4+ICsKPgo+PiArwqDCoMKg
IC8qIFNldCB0aGUgcGFnZSB0byBiZSBmcmVlZCB1c2luZyBkcm1tIHJlbGVhc2UgYWN0aW9uICov
Cj4+ICvCoMKgwqAgaWYgKGRybW1fYWRkX2FjdGlvbl9vcl9yZXNldChkZGV2LCB0dG1fYm9fcmVs
ZWFzZV9kdW1teV9wYWdlLCAKPj4gcGFnZSkpCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gVk1f
RkFVTFRfT09NOwo+Cj4gWW91IHNob3VsZCBwcm9iYWJseSBtb3ZlIHRoYXQgYmVmb3JlIGluc2Vy
dGluZyB0aGUgcGFnZSBpbnRvIHRoZSBWTUEgCj4gYW5kIGFsc28gZnJlZSB0aGUgYWxsb2NhdGVk
IHBhZ2UgaWYgaXQgZ29lcyB3cm9uZy4KCgpkcm1tX2FkZF9hY3Rpb25fb3JfcmVzZXQgd2lsbCBh
dXRvbWF0aWNhbGx5IHJlbGVhc2UgdGhlIHBhZ2UgaWYgdGhlIGFkZCAKYWN0aW9uIGZhaWxzLCB0
aGF0IHRoZSAncmVzZXQnIHBhcnQgb2YgdGhlIGZ1bmN0aW9uLgoKQW5kcmV5CgoKPgo+IEFwYXJ0
IGZyb20gdGhhdCBwYXRjaCBsb29rcyBnb29kIHRvIG1lLAo+IENocmlzdGlhbi4KPgo+PiArCj4+
ICvCoMKgwqAgcmV0dXJuIHJldDsKPj4gK30KPj4gK0VYUE9SVF9TWU1CT0wodHRtX2JvX3ZtX2R1
bW15X3BhZ2UpOwo+PiArCj4+IMKgIHZtX2ZhdWx0X3QgdHRtX2JvX3ZtX2ZhdWx0KHN0cnVjdCB2
bV9mYXVsdCAqdm1mKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEgPSB2bWYtPnZtYTsKPj4gwqDCoMKgwqDCoCBwZ3Byb3RfdCBwcm90Owo+PiDCoMKgwqDC
oMKgIHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8gPSB2bWEtPnZtX3ByaXZhdGVfZGF0YTsK
Pj4gK8KgwqDCoCBzdHJ1Y3QgZHJtX2RldmljZSAqZGRldiA9IGJvLT5iYXNlLmRldjsKPj4gwqDC
oMKgwqDCoCB2bV9mYXVsdF90IHJldDsKPj4gK8KgwqDCoCBpbnQgaWR4Owo+PiDCoCDCoMKgwqDC
oMKgIHJldCA9IHR0bV9ib192bV9yZXNlcnZlKGJvLCB2bWYpOwo+PiDCoMKgwqDCoMKgIGlmIChy
ZXQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+PiDCoCDCoMKgwqDCoMKgIHBy
b3QgPSB2bWEtPnZtX3BhZ2VfcHJvdDsKPj4gLcKgwqDCoCByZXQgPSB0dG1fYm9fdm1fZmF1bHRf
cmVzZXJ2ZWQodm1mLCBwcm90LCAKPj4gVFRNX0JPX1ZNX05VTV9QUkVGQVVMVCwgMSk7Cj4+ICvC
oMKgwqAgaWYgKGRybV9kZXZfZW50ZXIoZGRldiwgJmlkeCkpIHsKPj4gK8KgwqDCoMKgwqDCoMKg
IHJldCA9IHR0bV9ib192bV9mYXVsdF9yZXNlcnZlZCh2bWYsIHByb3QsIAo+PiBUVE1fQk9fVk1f
TlVNX1BSRUZBVUxULCAxKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGRybV9kZXZfZXhpdChpZHgpOwo+
PiArwqDCoMKgIH0gZWxzZSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSB0dG1fYm9fdm1fZHVt
bXlfcGFnZSh2bWYsIHByb3QpOwo+PiArwqDCoMKgIH0KPj4gwqDCoMKgwqDCoCBpZiAocmV0ID09
IFZNX0ZBVUxUX1JFVFJZICYmICEodm1mLT5mbGFncyAmIAo+PiBGQVVMVF9GTEFHX1JFVFJZX05P
V0FJVCkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+PiDCoCBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19hcGkuaCAKPj4gYi9pbmNsdWRlL2RybS90dG0vdHRt
X2JvX2FwaS5oCj4+IGluZGV4IDYzOTUyMTg4MGMyOS4uMjU0ZWRlOTdmOGUzIDEwMDY0NAo+PiAt
LS0gYS9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5oCj4+ICsrKyBiL2luY2x1ZGUvZHJtL3R0
bS90dG1fYm9fYXBpLmgKPj4gQEAgLTYyMCw0ICs2MjAsNiBAQCBpbnQgdHRtX2JvX3ZtX2FjY2Vz
cyhzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgCj4+IHVuc2lnbmVkIGxvbmcgYWRkciwKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICpidWYsIGludCBsZW4sIGludCB3cml0
ZSk7Cj4+IMKgIGJvb2wgdHRtX2JvX2RlbGF5ZWRfZGVsZXRlKHN0cnVjdCB0dG1fZGV2aWNlICpi
ZGV2LCBib29sIHJlbW92ZV9hbGwpOwo+PiDCoCArdm1fZmF1bHRfdCB0dG1fYm9fdm1fZHVtbXlf
cGFnZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZiwgcGdwcm90X3QgcHJvdCk7Cj4+ICsKPj4gwqAgI2Vu
ZGlmCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
