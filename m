Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478C5C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC8961A21
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC8961A21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1056EDBA;
	Thu, 25 Mar 2021 16:22:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5EA6EDB9
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 16:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHiJJV0ecAAo/aJZin9Xb4T1Q3QIiCguICNEoGbr+bB/Gvnfp7ImBi7e7V0YvfL8nQzPSFL/MaliTXjdQYtNP32SmTQrGK/0czW/M1ILzLDP9TZkalHglrOvinU51hFN6dJ9k1dfJHU25foSXWQY+j6x/dnZvdPy3KcDG6J61COL02QaGf5Q+YLlkbyc9757EiCf5+H4KQ+aoHlPx4MBWlR3siEoWNy28RddpItf1/qEJFKS+LNOk7rq8xEIjrhGE9pkyF1wdJSidSJA6YzYiIWxGFRzQmHaHAD+4JL6W769fpSQ0U0Iy2fM1ss6DzL1Zo7GwNHEHW+l0ymEBOPMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5WwXfRPQ9yY9OWbgPc9mKGd+juN91gjeVBPCsu9DWc=;
 b=YaRLe/NypX7OaTZgEPbf8zg73ypLR7l7m4rqjhT/AIn7HiXD581dSmcLrmxSgcPhKK/P9Dtw52UDxsnJDBFilnPVdt2tecySNPhsYPpJyhRy7eHu861f6rLuyZOI7UqgozywuiDzJiy+gNzzsqfPnIS/ZKLdIRQAH1O20Yynutfya74KVaWF4KmbKGjiOdp3zptxhdWEgh4llxkvUcyK/6Wu0NJFeUv5C0MpTtt4m6gMSeC+w/gVIe5RHL0jE/7CYhrMmOYAwsqC7G6/ZfE+3U8NeQEnTrwGH+nF1EtLphxiw6yQr4YzkjoDtmInTPRx0P0jg93O2rCIBKASwgOnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5WwXfRPQ9yY9OWbgPc9mKGd+juN91gjeVBPCsu9DWc=;
 b=fkFEpMfF6ObxdTXlOlOWKODsaTGNfSpbcQ5dlvNWKNMF70dJ+wWOetrGUiNNIupMRKqB3sCqNczmj4GoqbPX3JwJJW/4iWtiixVCy0mnndZqe3kdeAqnt99rI8GbxsqS8UpVGvkG0+C6SSV8Vikyb9Wtky5mfISdArwJ5Jby/5o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 16:22:34 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 16:22:34 +0000
Subject: Re: Need to support mixed memory mappings with HMM
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <ba49d13c-6b64-f9a6-f309-0dda56e90abf@amd.com>
 <dc28799b-d3a9-6922-f06a-c19eb75a9805@amd.com>
 <415c5920-0c70-819b-555e-a0c0fce301ef@amd.com>
 <ee1951eb-f789-14c2-608e-a6f77355c9ab@amd.com>
 <a6b6ac1a-d3f2-379f-fc0e-3b10908abc46@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <94b1e462-eff6-77f3-f0c4-1ae99f02a178@amd.com>
Date: Thu, 25 Mar 2021 17:22:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <a6b6ac1a-d3f2-379f-fc0e-3b10908abc46@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:52c7:fa7f:c799:1b6d]
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:52c7:fa7f:c799:1b6d]
 (2a02:908:1252:fb60:52c7:fa7f:c799:1b6d) by
 FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.16 via Frontend Transport; Thu, 25 Mar 2021 16:22:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eedf1bc3-a599-4b4a-3180-08d8efaa3279
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2353E09021C7F4EDC295CBE983629@BL0PR12MB2353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8nJ5pD7gkyTd9n/GFOxMVvGJzhfXragBdQaFjzTzO6glBlQRAUgmfKA0e8VhZ87lpXPn2KHqUlBmTb+KtFEhVaswUZS0SdfG3q3w+qmSXFzaEHm3MZdQw0OxPLh8YOUgAH2r5x93nLC/LiAdbJz2RikdHk08RGmvcVXZvK8M9Jg3HZIG9xnFxwiO39m60uTvRly/6Css2ms/pchr2+C9BzoyyD46sF7PTBpK49LzqaINDdU3EbrAUpGHJ1tIp6mw1oMJqTHw8Q6tE8v3OWF8jYP7bjjElFTRqpQWEmhoxel0+Oiyt0W279dsKBOyobiW7Nj2USuS2z9Pgnl2kXbDk0xnTTWuP1PT0zj1Ume2FJAH+KIsS0hEtvJg17gw7XrkikkLJP2pIxw/AvrVaQsufrg0qJMCE0HclC6h6xAT4DrH45b1H96NZdr6GW4zWWdrhHobAu8VlsPtXX9zhbeDQSPjYX4CvM5qErkDTkTdNnuykPdviI3QjufxVLALVDoLbb9q1Y9jGrubu5vlPjOXPsZ6g8n2WDUHW6Rw+Uzcgaflm0m9E1ZaJ2QRKdS4UvNSVcH3gaiF4t4f28TV+tUpkZQT4JaS4DdZzd21vWgnbfFtymdpmd+ayVnjghrjWomxEvc0oZQmC3q3KMWdHoCgy+owtYkaKQV5q3pvTFzAEcqLLxa9By9P9AmvvoyBJr3X9t0i/z1Ep9N30vC3onHDeZISpD16c8peNFatetFqNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(83380400001)(8936002)(8676002)(186003)(66946007)(86362001)(31696002)(36756003)(16526019)(66574015)(66476007)(66556008)(31686004)(6486002)(52116002)(38100700001)(5660300002)(316002)(2616005)(2906002)(478600001)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TnVuNHJnb2lVWFpjb0l5T2VkVVEvYisyU1ZuelRPRlF3UzFtQ3JBRXlmcm13?=
 =?utf-8?B?Kzh2K0ZrdmE0Tll0dm5jUE9uQkpTYzFLd29GbjdDWU14cFkyWFFpdjI5WlVC?=
 =?utf-8?B?OWFuVnZjcTJjTExYSGJEOVFtYnZ0aEFOdXNKbys0bFhPTUFJOVRmR1VYdGN0?=
 =?utf-8?B?SzFUNTh5Vi9NODNMWkRlellscVArMlN5b0hJeDNrcDVnU1QvQmVidkhiVHUr?=
 =?utf-8?B?cEJPRjlLUlhnRUFGT0ZHUHhRVjNmSSt1aFBNVFZQNUFlcE5EYXlrdFNVM1VR?=
 =?utf-8?B?Z2h1TW1KVndiR3RScThLS0VoSkc5S3RURTJxSVBKaE9McUhUd1Z2NmYvNnJH?=
 =?utf-8?B?ZFlqZkhQM1RRS0Q1TDY1a2JvVjlxOWhsRHhkRVh6dGpGM21KMEthWmJUbTYx?=
 =?utf-8?B?b0NpSDc0M1JhUWt5RGx2QlRUL25IMUFXak5MSDVjTHpQaDlhQnNNSDNoSGxh?=
 =?utf-8?B?S1RuVU5nOTNhTHQrVGIrcStXVk5yc25TOEJLSE1DVzF5UVJVNlFMSmhkMFdz?=
 =?utf-8?B?MTJ5anB5NSt1VU5qOFJuRHRkdlQvZmx0UUZVWjh3VWV1MFlQVUFWcytWWnZH?=
 =?utf-8?B?UUFFeXA3dVZTeGdVSFY2TVdESEI3ajAxU1l1cDNRTDM5RGtXcHM2emx4dTU0?=
 =?utf-8?B?QWRmOEdFbmhOM3V3WnNZTjlXK2JZR1pBV0p4RWlaVmdlaDZNSTJaM3JWYTRz?=
 =?utf-8?B?Vys3d3EzdXFtSDlMeHVIUnJmMStacGdObHRxYjBYN0ZlcEFFditCZUFvTE1P?=
 =?utf-8?B?alJlcGZ1Q0JheVptaHRFZ0pHbW1Yc0dQUzk2OHhZbzhFUGZva3ljVndSQ29U?=
 =?utf-8?B?QnQxa3l1WWQvV0VVMnJ0RjNvamdVd09SbWlKd0dQRTR4Y3VxOW1qLzdXREtp?=
 =?utf-8?B?eGFNV1k2Vms2blFQMnFIU00veGZPc1AwQ0VnRXhsWlVEMFR2NGRUWGdlSUV6?=
 =?utf-8?B?N0V5V2RsQm9TNmdvVEVtRVlML0pFWmNJSEtBQjBVQzVQbHUwUUZPUTlVQzVl?=
 =?utf-8?B?U1lOcE5UNUpKbkg0bTdqTXljZ21ndmtpNGFzQS8yRWpsdkczQnRNTGsxRnRy?=
 =?utf-8?B?eWRUeEI5aE03S3hYZ04yc2RZYjhPLyt5NUpKYlZVS3hGSTZHVUF3MlQ3MS83?=
 =?utf-8?B?NFlMZnhuVGd0VWxBMGZKU2pCVnMyZUJHYmxuUmxJUi9XWUZHdi9qRkhUVEdR?=
 =?utf-8?B?TWVxVTRaeitsQ1dJemZUblhUYmxUaGtucGNwbm1CZGVibGtUaHFsMTJqOEx3?=
 =?utf-8?B?ZFR6RkJhd1lOenpFRjRyT1RHMGphS25uRVdZRHZ0RU1rMGpiNU9laCtmY2VT?=
 =?utf-8?B?UmFwZUJoaWZnUmhhSkZmK3NxZjBDVDhwRW43STdoNEpjTUQrb1kxbCtSWkR3?=
 =?utf-8?B?eG1RdHdXYzdWMC9sSERoNUhNTmJnZ2Roa3JCTWNqQXd5Tjc2MzZIUW9lbHBO?=
 =?utf-8?B?S2w4a3RCTXVhUitHeCtDNDducGp6QVl2THE2WkI5SzVMYjFWejIzaWFrMDRJ?=
 =?utf-8?B?bExDeGJNSUNHQ0tyUWdLZlNLc0ZvclhzS3FJYklxRUgzclE4THE0YTJEMWoy?=
 =?utf-8?B?WXJVamtEVCtpNVZFMFNZRUs5ZU1oZ2Z4VXdpN1U0M0xxUkIyZkRpSENXc3FZ?=
 =?utf-8?B?NEJiU2VNbzdpdnZNY1RHR1Y2MDcwbmJXVDRDUzNGZnNDVVdKbzNRcWFOVjIr?=
 =?utf-8?B?OVZ6eUIyRVVHbjRCbWpUY0VCa3JYVjFaSEt1L3R0MFdIRDZLdVVhYXJwVldq?=
 =?utf-8?B?K1hIb2svQk90eERoaFVGQW8wczJ2a1dpZjVCZGpQbmorTTJaM2t4OCtTMDc0?=
 =?utf-8?B?RzBBSmhEUTZaRnpGZXkzQTk2aW04cWJRcUpkeFgwM0tUdkpqNCthblR3RXZl?=
 =?utf-8?Q?QARDSqQwBP7Mp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedf1bc3-a599-4b4a-3180-08d8efaa3279
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:22:34.5216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83i5bd+VpXC4/Op6/xdayArceiomsEotiEhb0UqfnnGxgm0MEtBnSGgfR7XED2Di
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2353
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjUuMDMuMjEgdW0gMTc6MjAgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIxLTAz
LTI1IHVtIDEyOjE2IHAubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+PiBBbSAyNS4wMy4y
MSB1bSAxNzoxNCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4gQW0gMjAyMS0wMy0yNSB1bSAx
MjoxMCBwLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4+PiBBbSAyNS4wMy4yMSB1bSAx
NzowMyBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4+PiBIaSwKPj4+Pj4KPj4+Pj4gVGhpcyBp
cyBhIGxvbmcgb25lIHdpdGggYSBwcm9wb3NhbCBmb3IgYSBwcmV0dHkgc2lnbmlmaWNhbnQKPj4+
Pj4gcmVkZXNpZ24gb2YKPj4+Pj4gaG93IHdlIGhhbmRsZSBtaWdyYXRpb25zIGFuZCBWUkFNIG1h
bmFnZW1lbnQgd2l0aCBITU0uIFRoaXMgaXMKPj4+Pj4gYmFzZWQgb24KPj4+Pj4gbXkgb3duIGRl
YnVnZ2luZyBhbmQgcmVhZGluZyBvZiB0aGUgbWlncmF0ZV92bWEgaGVscGVycywgYXMgd2VsbCBh
cwo+Pj4+PiBBbGV4J3MgcHJvYmxlbXMgd2l0aCBtaWdyYXRpb25zIG9uIEErQS4gSSBob3BlIHdl
IGNhbiBkaXNjdXNzIHRoaXMKPj4+Pj4gbmV4dAo+Pj4+PiBNb25kYXkgYWZ0ZXIgeW91J3ZlIGhh
ZCBzb21lIHRpbWUgZG8gZGlnZXN0IGl0Lgo+Pj4+Pgo+Pj4+PiBJIGRpZCBzb21lIGRlYnVnZ2lu
ZyB5ZXN0ZXJkYXkgYW5kIGZvdW5kIHRoYXQgbWlncmF0aW9ucyB0byBWUkFNIGNhbgo+Pj4+PiBm
YWlsIGZvciBzb21lIHBhZ2VzLiBUaGUgY3VycmVudCBtaWdyYXRpb24gaGVscGVycyBoYXZlIG1h
bnkgY29ybmVyCj4+Pj4+IGNhc2VzIHdoZXJlIGEgcGFnZSBjYW5ub3QgYmUgbWlncmF0ZWQuIFNv
bWUgb2YgdGhlbSBtYXkgYmUgZml4YWJsZQo+Pj4+PiAoYWRkaW5nIHN1cHBvcnQgZm9yIFRIUCks
IG90aGVycyBhcmUgbm90IChsb2NrZWQgcGFnZXMgYXJlIHNraXBwZWQgdG8KPj4+Pj4gYXZvaWQg
ZGVhZGxvY2tzKS4gVGhlcmVmb3JlIEkgdGhpbmsgb3VyIGN1cnJlbnQgY29kZSBpcyB0b28gaW5m
bGV4aWJsZQo+Pj4+PiB3aGVuIGl0IGFzc3VtZXMgdGhhdCBhIHJhbmdlIGlzIGVudGlyZWx5IGlu
IG9uZSBwbGFjZS4KPj4+Pj4KPj4+Pj4gQWxleCBhbHNvIHJhbiBpbnRvIHNvbWUgZnVubnkgaXNz
dWVzIHdpdGggQ09XIG9uIEErQSB3aGVyZSBzb21lIHBhZ2VzCj4+Pj4+IGdldCBmYXVsdGVkIGJh
Y2sgdG8gc3lzdGVtIG1lbW9yeS4gSSB0aGluayBhIGxvdCBvZiB0aGUgcHJvYmxlbXMgaGVyZQo+
Pj4+PiB3aWxsIGdldCBlYXNpZXIgb25jZSB3ZSBzdXBwb3J0IG1peGVkIG1hcHBpbmdzLgo+Pj4+
Pgo+Pj4+PiBNaXhlZCBHUFUgbWFwcGluZ3MKPj4+Pj4gPT09PT09PT09PT0KPj4+Pj4KPj4+Pj4g
VGhlIGlkZWEgaXMsIHRvIHJlbW92ZSBhbnkgYXNzdW1wdGlvbnMgdGhhdCBhbiBlbnRpcmUgc3Zt
X3JhbmdlIGlzIGluCj4+Pj4+IG9uZSBwbGFjZS4gSW5zdGVhZCBobW1fcmFuZ2VfZmF1bHQgZ2l2
ZXMgdXMgYSBsaXN0IG9mIHBhZ2VzLCBzb21lIG9mCj4+Pj4+IHdoaWNoIGFyZSBzeXN0ZW0gbWVt
b3J5IGFuZCBvdGhlcnMgYXJlIGRldmljZV9wcml2YXRlIG9yCj4+Pj4+IGRldmljZV9nZW5lcmlj
Lgo+Pj4+Pgo+Pj4+PiBXZSB3aWxsIG5lZWQgYW4gYW1kZ3B1X3ZtIGludGVyZmFjZSB0aGF0IGxl
dHMgdXMgbWFwIG1peGVkIHBhZ2UgYXJyYXlzCj4+Pj4+IHdoZXJlIGRpZmZlcmVudCBwYWdlcyB1
c2UgZGlmZmVyZW50IFBURSBmbGFncy4gV2UgY2FuIGhhdmUgYXQgbGVhc3QgMwo+Pj4+PiBkaWZm
ZXJlbnQgdHlwZXMgb2YgcGFnZXMgaW4gb25lIG1hcHBpbmc6Cj4+Pj4+Cj4+Pj4+ICDCoMKgIDEu
IFN5c3RlbSBtZW1vcnkgKFMtYml0IHNldCkKPj4+Pj4gIMKgwqAgMi4gTG9jYWwgbWVtb3J5IChT
LWJpdCBjbGVhcmVkLCBNVFlQRSBmb3IgbG9jYWwgbWVtb3J5KQo+Pj4+PiAgwqDCoCAzLiBSZW1v
dGUgWEdNSSBtZW1vcnkgKFMtYml0IGNsZWFyZWQsIE1UWVBFK0MgZm9yIHJlbW90ZSBtZW1vcnkp
Cj4+Pj4+Cj4+Pj4+IE15IGlkZWEgaXMgdG8gY2hhbmdlIHRoZSBhbWRncHVfdm1fdXBkYXRlX21h
cHBpbmcgaW50ZXJmYWNlIHRvIHVzZQo+Pj4+PiBzb21lCj4+Pj4+IGhpZ2gtYml0IGluIHRoZSBw
YWdlc19hZGRyIGFycmF5IHRvIGluZGljYXRlIHRoZSBwYWdlIHR5cGUuIEZvciB0aGUKPj4+Pj4g
ZGVmYXVsdCBwYWdlIHR5cGUgKDApIG5vdGhpbmcgcmVhbGx5IGNoYW5nZXMgZm9yIHRoZSBjYWxs
ZXJzLiBUaGUKPj4+Pj4gImZsYWdzIiBwYXJhbWV0ZXIgbmVlZHMgdG8gYmVjb21lIGEgcG9pbnRl
ciB0byBhbiBhcnJheSB0aGF0IGdldHMKPj4+Pj4gaW5kZXhlZCBieSB0aGUgaGlnaCBiaXRzIGZy
b20gdGhlIHBhZ2VzX2FkZHIgYXJyYXkuIEZvciBleGlzdGluZwo+Pj4+PiBjYWxsZXJzCj4+Pj4+
IGl0J3MgYXMgZWFzeSBhcyBjaGFuZ2luZyBmbGFncyB0byAmZmxhZ3MgKGFycmF5IG9mIHNpemUg
MSkuIEZvciBITU0gd2UKPj4+Pj4gd291bGQgcGFzcyBhIHBvaW50ZXIgdG8gYSByZWFsIGFycmF5
Lgo+Pj4+IFllYWgsIEkndmUgdGhvdWdodCBhYm91dCBzdHVmZiBsaWtlIHRoYXQgYXMgd2VsbCBm
b3IgYSB3aGlsZS4KPj4+Pgo+Pj4+IFByb2JsZW0gaXMgdGhhdCB0aGlzIHdvbid0IHdvcmsgdGhh
dCBlYXNpbHkuIFdlIGFzc3VtZSBhdCBtYW55IHBsYWNlcwo+Pj4+IHRoYXQgdGhlIGZsYWdzIGRv
ZXNuJ3QgY2hhbmdlIGZvciB0aGUgcmFuZ2UgaW4gcXVlc3Rpb24uCj4+PiBJIHRoaW5rIHNvbWUg
bG93ZXIgbGV2ZWwgZnVuY3Rpb25zIGFzc3VtZSB0aGF0IHRoZSBmbGFncyBzdGF5IHRoZSBzYW1l
Cj4+PiBmb3IgcGh5c2ljYWxseSBjb250aWd1b3VzIHJhbmdlcy4gQnV0IGlmIHlvdSB1c2UgdGhl
IGhpZ2gtYml0cyB0byBlbmNvZGUKPj4+IHRoZSBwYWdlIHR5cGUsIHRoZSByYW5nZXMgd29uJ3Qg
YmUgY29udGlndW91cyBhbnkgbW9yZS4gU28geW91IGNhbgo+Pj4gY2hhbmdlIHBhZ2UgZmxhZ3Mg
Zm9yIGRpZmZlcmVudCBjb250aWd1b3VzIHJhbmdlcy4KPj4gWWVhaCwgYnV0IHRoZW4geW91IGFs
c28gZ2V0IGFic29sdXRlbHkgemVybyBUSFAgYW5kIGZyYWdtZW50IGZsYWdzCj4+IHN1cHBvcnQu
Cj4gQXMgbG9uZyBhcyB5b3UgaGF2ZSBhIGNvbnRpZ3VvdXMgMk1CIHBhZ2Ugd2l0aCB0aGUgc2Ft
ZSBwYWdlIHR5cGUsIEkKPiB0aGluayB5b3UgY2FuIHN0aWxsIGdldCBhIFRIUCBtYXBwaW5nIGlu
IHRoZSBHUFUgcGFnZSB0YWJsZS4gQnV0IGlmIG9uZQo+IHBhZ2UgaW4gdGhlIG1pZGRsZSBvZiBh
IDJNQiBwYWdlIGhhcyBhIGRpZmZlcmVudCBwYWdlIHR5cGUsIHRoYXQgd2lsbAo+IGJyZWFrIHRo
ZSBUSFAgbWFwcGluZywgYXMgaXQgc2hvdWxkLgoKWWVhaCwgYnV0IGN1cnJlbnRseSB3ZSBkZXRl
Y3QgdGhhdCBiZWZvcmUgd2UgY2FsbCBkb3duIGludG8gdGhlIApmdW5jdGlvbnMgdG8gdXBkYXRl
IHRoZSB0YWJsZXMuCgpXaGVuIHlvdSBnaXZlIGEgbWl4ZWQgbGlzdCB0aGUgY2hhbmNlIGZvciB0
aGF0IGlzIGp1c3QgY29tcGxldGVseSBnb25lLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IFJl
Z2FyZHMsCj4gIMKgIEZlbGl4Cj4KPgo+PiBCdXQgSSB0aGluayB3ZSBjb3VsZCBhbHNvIGFkZCB0
aG9zZSBsYXRlciBvbi4KPj4KPj4gUmVnYXJkcywKPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4gUmVnYXJk
cywKPj4+ICDCoMKgIEZlbGl4Cj4+Pgo+Pj4KPj4+PiBXZSB3b3VsZCBzb21laG93IG5lZWQgdG8g
Y2hhbmdlIHRoYXQgdG8gZ2V0IHRoZSBmbGFncyBkaXJlY3RseSBmcm9tCj4+Pj4gdGhlIGxvdyBi
aXRzIG9mIHRoZSBETUEgYWRkcmVzcyBvciBzb21ldGhpbmcgaW5zdGVhZC4KPj4+Pgo+Pj4+IENo
cmlzdGlhbi4KPj4+Pgo+Pj4+PiBPbmNlIHRoaXMgaXMgZG9uZSwgaXQgbGVhZHMgdG8gYSBudW1i
ZXIgb2Ygb3Bwb3J0dW5pdGllcyBmb3IKPj4+Pj4gc2ltcGxpZmljYXRpb24gYW5kIGJldHRlciBl
ZmZpY2llbmN5IGluIGtmZF9zdm06Cj4+Pj4+Cj4+Pj4+ICDCoMKgwqAgKiBTdXBwb3J0IG1pZ3Jh
dGlvbiB3aGVuIGNwYWdlcyAhPSBucGFnZXMKPj4+Pj4gIMKgwqDCoCAqIE1pZ3JhdGUgYSBwYXJ0
IG9mIGFuIHN2bV9yYW5nZSB3aXRob3V0IHNwbGl0dGluZyBpdC4gTm8gbW9yZQo+Pj4+PiAgwqDC
oMKgwqDCoCBzcGxpdHRpbmcgb2YgcmFuZ2VzIGluIENQVSBwYWdlIGZhdWx0cwo+Pj4+PiAgwqDC
oMKgICogTWlncmF0ZSBhIHBhcnQgb2YgYW4gc3ZtX3JhbmdlIGluIEdQVSBwYWdlIGZhdWx0IGhh
bmRsZXIuIE5vCj4+Pj4+IG1vcmUKPj4+Pj4gIMKgwqDCoMKgwqAgbWlncmF0aW5nIHRoZSB3aG9s
ZSByYW5nZSBmb3IgYSBzaW5nbGUgcGFnZSBmYXVsdAo+Pj4+PiAgwqDCoMKgICogU2ltcGxpZmll
ZCBWUkFNIG1hbmFnZW1lbnQgKHNlZSBiZWxvdykKPj4+Pj4KPj4+Pj4gV2l0aCB0aGF0LCBzdm1f
cmFuZ2Ugd2lsbCBubyBsb25nZXIgaGF2ZSBhbiAiYWN0dWFsX2xvYyIgZmllbGQuIElmCj4+Pj4+
IHdlJ3JlCj4+Pj4+IG5vdCBzdXJlIHdoZXJlIHRoZSBkYXRhIGlzLCB3ZSBuZWVkIHRvIGNhbGwg
bWlncmF0ZS4gSWYgaXQncwo+Pj4+PiBhbHJlYWR5IGluCj4+Pj4+IHRoZSByaWdodCBwbGFjZSwg
dGhlbiBjcGFnZXMgd2lsbCBiZSAwIGFuZCB3ZSBjYW4gc2tpcCBhbGwgdGhlIHN0ZXBzCj4+Pj4+
IGFmdGVyIG1pZ3JhdGVfdm1hX3NldHVwLgo+Pj4+Pgo+Pj4+PiBTaW1wbGlmaWVkIFZSQU0gbWFu
YWdlbWVudAo+Pj4+PiA9PT09PT09PT09PT09PQo+Pj4+Pgo+Pj4+PiBWUkFNIEJPcyBhcmUgbm8g
bG9uZ2VyIGFzc29jaWF0ZWQgd2l0aCBwcmFuZ2VzLiBJbnN0ZWFkIHRoZXkgYXJlCj4+Pj4+ICJm
cmVlLWZsb2F0aW5nIiwgYWxsb2NhdGVkIGR1cmluZyBtaWdyYXRpb24gdG8gVlJBTSwgd2l0aCBy
ZWZlcmVuY2UKPj4+Pj4gY291bnQgZm9yIGVhY2ggcGFnZSB0aGF0IHVzZXMgdGhlIEJPLiBSZWYg
aXMgcmVsZWFzZWQgaW4gcGFnZS1yZWxlYXNlCj4+Pj4+IGNhbGxiYWNrLiBXaGVuIHRoZSByZWYg
Y291bnQgZHJvcHMgdG8gMCwgZnJlZSB0aGUgQk8uCj4+Pj4+Cj4+Pj4+IFZSQU0gQk8gc2l6ZSBz
aG91bGQgbWF0Y2ggdGhlIG1pZ3JhdGlvbiBncmFudWxhcml0eSwgMk1CIGJ5IGRlZmF1bHQuCj4+
Pj4+IFRoYXQgd2F5IHRoZSBCTyBjYW4gYmUgZnJlZWQgd2hlbiBtZW1vcnkgZ2V0cyBtaWdyYXRl
ZCBvdXQuIElmCj4+Pj4+IG1pZ3JhdGlvbgo+Pj4+PiBvZiBzb21lIHBhZ2VzIGZhaWxzIHRoZSBC
TyBtYXkgbm90IGJlIGZ1bGx5IG9jY3VwaWVkLiBBbHNvIHNvbWUgcGFnZXMKPj4+Pj4gbWF5IGJl
IHJlbGVhc2VkIGluZGl2aWR1YWxseSBvbiBBK0EgZHVlIHRvIENPVyBvciBvdGhlciBldmVudHMu
Cj4+Pj4+Cj4+Pj4+IEV2aWN0aW9uIG5lZWRzIHRvIG1pZ3JhdGUgYWxsIHRoZSBwYWdlcyBzdGls
bCB1c2luZyB0aGUgQk8uIElmIHRoZSBCTwo+Pj4+PiBzdHJ1Y3Qga2VlcHMgYW4gYXJyYXkgb2Yg
cGFnZSBwb2ludGVycywgdGhhdCdzIGJhc2ljYWxseSB0aGUKPj4+Pj4gbWlncmF0ZS5zcmMKPj4+
Pj4gZm9yIHRoZSBldmljdGlvbi4gTWlncmF0aW9uIGNhbGxzICJ0cnlfdG9fdW5tYXAiLCB3aGlj
aCBoYXMgdGhlIGJlc3QKPj4+Pj4gY2hhbmNlIG9mIGZyZWVpbmcgdGhlIEJPLCBldmVuIHdoZW4g
c2hhcmVkIGJ5IG11bHRpcGxlIHByb2Nlc3Nlcy4KPj4+Pj4KPj4+Pj4gSWYgd2UgY2Fubm90IGd1
YXJhbnRlZSBldmljdGlvbiBvZiBwYWdlcywgd2UgY2Fubm90IHVzZSBUVE0gZm9yIFZSQU0KPj4+
Pj4gYWxsb2NhdGlvbnMuIE5lZWQgdG8gdXNlIGFtZGdwdV92cmFtX21nci4gTmVlZCBhIHdheSB0
byBkZXRlY3QgbWVtb3J5Cj4+Pj4+IHByZXNzdXJlIHNvIHdlIGNhbiBzdGFydCBldmljdGluZyBt
ZW1vcnkuCj4+Pj4+Cj4+Pj4+IFJlZ2FyZHMsCj4+Pj4+ICDCoMKgwqAgRmVsaXgKPj4+Pj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
