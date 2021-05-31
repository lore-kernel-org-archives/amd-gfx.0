Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1FDC47080
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 14:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0365613AE
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 14:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0365613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5336A6E938;
	Mon, 31 May 2021 14:30:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3C56E914
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 14:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfHfJobKgDGUvd7BTYpGeb8dzbJodYib1H7U9XmSX2HjuLdE7NpbvHqpsQpmriGIFc1iQkXaktitof7Kfc71f9JcCNUA7Ljm/yxrL4+lgr16CbvqHe0j8x3nUd+hKaYWFiOyVdu33mty+VvAZZLbEY3Kh0zM1zthf9H52V1ql1SpOeSN4PNeyCLrb0WAOxhXHytXF0mhc1cS+G9YWsE71EHw56XUnumXWA/y6uQw7tyRjWxmxVl/cLqmwzdJ8LfxQR/rntvCr+8+iZs2pzkZPgFIuT9hPT2kUUfL980YjnqvEJKbL2mB/vyZVDtEAlyF87BxY44bqDT5AvSjY5kUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A6SBKC+k1Qu6Ds/JCZoYRRwZU8FiGlrQMLvCTfVt2Q=;
 b=mqExDjADrROJl8OOZl2b3qBquxhajZOBxGXnJvR3azTDN2wPrhufSrwu5mx8VeumSyGHybov9TjX27mwJ1k6crRnZWBqWDQK6JvsrkeCvTxH88xs4GNo++dc8G2KJ2/nweGwDZHocNtg3/8+Knh/Vb0Bx3blAaHUF+RX5xkWeNuWaNahbxeEgJBL1PvGMP+sdf0FZ0KzGftEoBiy4q4jzJMhk6J5p3iJAOwENToQAaQTVrYEz048I7ndKX3qPZBKZlf+hgpDgRMe2IocVDBv51w0P0o4urBHz+1i5qiSd3nk5e2cDZYqnsn5vlSIOmcvY6M9HkpOIPeVp0wIelUmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A6SBKC+k1Qu6Ds/JCZoYRRwZU8FiGlrQMLvCTfVt2Q=;
 b=17HQ15nI29aVr6BC/a2JGzNawS7s3j2r/JHvMDNV1UkP3TtOr7CXCT7seOyMdifVlAOsNgwgJV/7H8+paLSMEjOL409uR+z5V0VTd3VgHdDF6X+5D3r2vOIqdCDqbDqxzIzZMiiy9Is9Vw6lqWUhaHDnvFO430ji3UJaR6EfFxc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB2668.namprd12.prod.outlook.com (2603:10b6:5:4a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Mon, 31 May
 2021 14:30:11 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 14:30:11 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix a bug on flag table_freed
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210529225101.459466-1-jinhuieric.huang@amd.com>
 <a048b42a-71c6-97c5-0e15-44cb3f3847a2@gmail.com>
 <0e44e35b-2acd-1954-47e4-b5a1f8c3dc49@amd.com>
 <ac9584d2-ef0a-3cae-631e-a0dd42c5555c@gmail.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <bac6a9f2-046c-a0a4-69de-94499c589026@amd.com>
Date: Mon, 31 May 2021 10:30:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <ac9584d2-ef0a-3cae-631e-a0dd42c5555c@gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:889c:5e2:3561:6b91]
X-ClientProxiedBy: YTXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::28) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:889c:5e2:3561:6b91]
 (2607:9880:2048:122:889c:5e2:3561:6b91) by
 YTXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27 via Frontend Transport; Mon, 31 May 2021 14:30:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07311ff2-d2a5-4927-55b0-08d924409931
X-MS-TrafficTypeDiagnostic: DM6PR12MB2668:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2668459F409E5DF76A3E5FEB823F9@DM6PR12MB2668.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNCBos4RfpJHtowo/ckc0BbAelsPXClMZIsQ4v6HNLICANnbwDlY09/Tz77/RrXHXTccidzveLAQUZLZFx/FbUMmq1BwQakeMPiAKTAGYKBnsoQT7mCVvZT+6M5XZVQj+AR4xjs80E87AzhzplPrt6NliqXnw5TWujhOl5sCM2oiBbOj1BVn+DWp+jS5KT37yZEL749lA2CpUf5H7AFkEDHzPdVSxEo9ZhTkk5haFXANlbJJwOAvRKvtfKOw/P5RagkWVPXzKdm2MMuqZ7LTxyJK0RPsyDNiREZVkmvP+vog4haso88npK+qfpHRGQYjruO627iZI9PO527Yc07VIk7O4GZHW0CAhaW667Np18APHgH8liYYYJ0jA5jcqhDI6HDYSGZaJxV278wPjXm0CGfCUtMn5tqibCEeNsmFR6i2++2ln/O0ABMf+SPHj9qXcKgDhEmGBJ5CWZDfVX9Wrhqu1hB5+5AWDiFN8xYEAeQNlI39LOMacPDbJ+IPB+CMUUOThg/fhVLmD6Kj0zH1IPoJ2VaCCUuGeW0gKERLhMgDLu9dgEYJWQ1ZGYvewYGop0eoLJZCCNbpKYHuQefN+3AiKz2Y5eY9s7gz35cOCGRDbTjGiGGQKCacrVNsbxBrwwf4BxwLpMXA0RJ50ezeENplVoqoMg9Vw68w1fgcpioeANOQE6/hs7GuC9dUkNH8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(66556008)(66476007)(186003)(2906002)(16526019)(66946007)(86362001)(31696002)(36756003)(66574015)(38100700002)(5660300002)(2616005)(8936002)(6486002)(478600001)(8676002)(53546011)(6666004)(316002)(31686004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dEZ0ZlRzSXlXUVBRV2VwNWhmT3VwbG1OK0JLWEQ1UDNhaXZhTnlTNkJPQ0xB?=
 =?utf-8?B?VmFFY0x0Y3dmNDUvY3RwOWYvNmJjUUFKUjZkenBhNFhZYTZCdDRtWC9UNC9q?=
 =?utf-8?B?akVWR1JQQ2h4UHl5YTd3REpIZjZFY3B2SjRlaTJPeGlNNUVQR1VrdDVSUStQ?=
 =?utf-8?B?Y2w0eHIrM1Y4VjNSREFuN2dXQUx5YTB5UEdEV2paVmFjTDFXSlV0dVBUQlpR?=
 =?utf-8?B?RjRQUXNVdzhIaWtGOERHc3Y4cUQ4cVY4OVpTQXhFWkpJZ3FDRGpKaGRTbTdv?=
 =?utf-8?B?Tk4vSGJMWTJYN0RZTU11clNNRG1BT0Ewa3U5ZzdkbC9PemE1cWNIMDZOcXo3?=
 =?utf-8?B?STR0NUlLTnVrZnpMSlloWUNtYktCYjVzenlYT01FZ0NKelVhaTFJMGhXUDRB?=
 =?utf-8?B?RWFQcW55aHh3c09YclBrUzM5Mmdkekl4eWp1eXJuTSthM1VsdTcra0VndDNI?=
 =?utf-8?B?MTRuM2t4Smw1Mzk5OGhudWZXd2tsUHhlMW54QVBpam5uMUlDUVUzV1hjNnNL?=
 =?utf-8?B?djV4UXZLdGRBenBuc2NpTkhBd3VxamJGdmJrcjhFRklmVHZBK1pudHpickhV?=
 =?utf-8?B?S3gvY3RzODNSczBjVWx2Ykpqc2h4Z1g3emNEc2FJS01TWUMwV1MwcjAreUY4?=
 =?utf-8?B?dTFiUlFUV2YxM1FzcmQwQkJxaXMyVWdLbyt0L1pCTzBpcExyclBsYkpwUGxq?=
 =?utf-8?B?VW16N1EwYzlpSG9JbmovSm1WSW9za1h6N1JDZWVqSVpFYWRXUSs5MzFwR3ll?=
 =?utf-8?B?WGdmVWwyZjFDcG16OEl1bWd4N1VTeFJ5bHFJelB1VXdoMk1ibHJhQnpoVkZV?=
 =?utf-8?B?K2puOXdBOGRrLzZTNFNHeTBMVUZSOFM0ZUxoa29sdkRIZ2ZOV3gzU3VrZHBs?=
 =?utf-8?B?NFl3RHBucVVHVUNicWwvQmYyY253bnNobGhhb1IyZGkvNmdtZW42VWlXTUdm?=
 =?utf-8?B?Ymk0clVUaTFQdmhCSENzdjBFZ3ltbTFaZnNzQjU3YzI2YXZIVkJlakNueEdJ?=
 =?utf-8?B?ODI4anFnOCtYRXJXdXJOa1lKZ0lza3gwZnlFVnBqa3Bndm15dXlwMHJjRVRX?=
 =?utf-8?B?TmpHWFpXQU5QUVdydVVUdnZsMkUyUWlVYTlEdWpoZ2p0NmRBSnB3ZVdRSTRU?=
 =?utf-8?B?bUl0emttTStUcThWdFNYL1RsNU1aeDgvYk5BMEZGTzQxTlNNMytyQmdLSEVW?=
 =?utf-8?B?OXhmN096aEFKMXZNZW9reml3NVlKcC9TNjhXNDZUV3FYemVkbUZpNFFjbWI4?=
 =?utf-8?B?WHliWGx6R29YWWhHMU9MSWwrRTZjUEpVNW1BOU4rdWdydnVDNVdpbzc3RjRE?=
 =?utf-8?B?K3lIL3NkZjYyWjZrR1dadUhZQ1VGd2pqR1B1aG8zekpmSnJuS0NkVDdYN1Nj?=
 =?utf-8?B?NzJqMEJ1VTFRYlI4Und0RXN5ajBDUFBlcXJ6NVFpdW1lMEZnRzVqMW9jQ2Ni?=
 =?utf-8?B?YjNkbzUvWURLbm9nN01CWWRHMzZrZ2JJWnNpOEhLbzNKTWR2c2ZCMnFYWEtD?=
 =?utf-8?B?ZDIvWlQ5SGIxdVloWU0wQmVZYkNIOXNadGN4ZEVHakVjZHo0UjREWnZVZE1D?=
 =?utf-8?B?VnFSdGkrYVJWTmh5VWVZMmlUMktMZk9CRVpSelZLUW9KUXhZZWRlbmdkc2Za?=
 =?utf-8?B?bEZaSUF0T3lWRXgxY05XSWl0U1RrYzJObnlDOXg1SDFWY0tPd0hoandYc1N1?=
 =?utf-8?B?NXUwZW11aWVEaUNJMFhJUmVabENMTjIxQ0Q3N1dkM1o5MXFMdy9UcUJEM2hU?=
 =?utf-8?B?dFJnK2t1bVlwYkg2Y2Rhc2hrWjd5Y3BaSU9LdG1QY0FPZFMvK05TR2g5WmZX?=
 =?utf-8?B?NzE3MHg2d0IyN1BRK0VFWDRQbnhoaXhwUTBvVDFvVzE0TTFhVVhYU1pyZkNz?=
 =?utf-8?Q?aaaFTyeOjxtVt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07311ff2-d2a5-4927-55b0-08d924409931
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 14:30:11.8349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVfhc1GoOy4ZfZW0nZoItnpq2q++mwY/jo8Lt16NppczFeT35Pcvx6nx/ZeOyYaqGE2CL7bmXJ8sekRDDhZXEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
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

T24gMjAyMS0wNS0zMSAxMDowOCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBB
bSAzMC4wNS4yMSB1bSAyMDoyOSBzY2hyaWViIEVyaWMgSHVhbmc6Cj4+Cj4+IE9uIDIwMjEtMDUt
MzAgMTI6NTQgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Cj4+Pgo+Pj4gQW0gMzAu
MDUuMjEgdW0gMDA6NTEgc2NocmllYiBFcmljIEh1YW5nOgo+Pj4+IHRhYmxlX2ZyZWVkIHdpbGwg
YmUgYWx3YXlzIHRydWUgd2hlbiBtYXBwaW5nIGEgbWVtb3J5IHdpdGggc2l6ZQo+Pj4+IGJpZ2dl
ciB0aGFuIDJNQi4gVGhlIHByb2JsZW0gaXMgcGFnZSB0YWJsZSdzIGVudHJpZXMgYXJlIGFsd2F5
cwo+Pj4+IGV4aXN0ZWQsIGJ1dCBleGlzdGluZyBtYXBwaW5nIGRlcGVuZHMgb24gcGFnZSB0YWxi
ZSdzIGJvLCBzbwo+Pj4+IHVzaW5nIGEgY2hlY2sgb2YgcGFnZSB0YWJsZSdzIGJvIGV4aXN0ZWQg
d2lsbCByZXNvbHZlIHRoZSBpc3N1ZS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgSHVh
bmcgPGppbmh1aWVyaWMuaHVhbmdAYW1kLmNvbT4KPj4+PiAtLS0KPj4+PiDCoCBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDQgKysrLQo+Pj4+IMKgIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAKPj4+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+Pj4gaW5kZXggMGRlZTJlODc5N2M3Li45
NWI5NGM5NWFkYWMgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwo+Pj4+IEBAIC0xNTgyLDkgKzE1ODIsMTEgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBk
YXRlX3B0ZXMoc3RydWN0IAo+Pj4+IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGNvbXBsZXRlbHkgY292ZXJlZCBieSB0
aGUgcmFuZ2UgYW5kIHNvIHBvdGVudGlhbGx5IAo+Pj4+IHN0aWxsIGluIHVzZS4KPj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgd2hpbGUgKGN1cnNvci5wZm4gPCBmcmFnX3N0YXJ0KSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAvKiBNYWtlIHN1cmUgcHJldmlvdXMgbWFwcGluZyBleGlzdGVkICov
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoY3Vyc29yLmVudHJ5LT5i
YXNlLmJvKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYXJh
bXMtPnRhYmxlX2ZyZWVkID0gdHJ1ZTsKPj4+Cj4+PiBJbiBnZW5lcmFsIHRoaXMgaXMgdGhlIGNv
cnJlY3QgYXBwcm9hY2gsIGJ1dCBJIHdvdWxkIHB1c2ggdGhhdCAKPj4+IGRlY2lzaW9uIGludG8g
dGhlIGFtZGdwdV92bV9mcmVlX3B0cygpIGZ1bmN0aW9uLgo+Pj4KPj4+PiBhbWRncHVfdm1fZnJl
ZV9wdHMoYWRldiwgcGFyYW1zLT52bSwgJmN1cnNvcik7Cj4+Pgo+Pj4gU28gdGhhdCB3ZSBoYXZl
IGhlcmUgc29tZXRoaW5nIGxpa2UKPj4+Cj4+PiBwYXJhbXMtPnRhYmxlX2ZyZWVkIHw9IGFtZGdw
dV92bV9mcmVlX3B0cyguLik7Cj4+Pgo+PiBUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3LiBJIHdh
cyB0aGlua2luZyBwdXQgdGhlIGNoZWNrIGludG8gZnVuY3Rpb24gCj4+IGFtZGdwdV92bV9mcmVl
X3B0cygpIHNpbmNlIHByZXZpb3VzIHJldmlldywgaXQgd2lsbCBjaGFuZ2UgcmV0dXJucyBvZiAK
Pj4gdHdvIGZ1bmN0aW9ucyBhbWRncHVfdm1fZnJlZV9wdHMoKSBhbmQgYW1kZ3B1X3ZtX2ZyZWVf
dGFibGUoKS4gSWYgdGhlIAo+PiByZXR1cm5zIGFyZSBub3QgdXNlZCBieSBvdGhlciBmdW5jdGlv
bnMsIGl0IHNlZW1zIG1ha2UgYSBzaW1wbGUgCj4+IGNoYW5nZSBjb21wbGV4IGZyb20gbXkgcGVy
c3BlY3RpdmUuIENhbiB5b3Ugc2hhcmUgdGhlIHJlYXNvbiBvZiB5b3VyIAo+PiBzdWdnZXN0aW9u
Pwo+Cj4gQmVjYXVzZSB5b3UgY2FuIGFsc28gb3B0aW1pemUgdGhlIGJ1bGtfbW92ZWFibGUgaGFu
ZGxpbmcgaW4gdGhhdCAKPiBmdW5jdGlvbi4KPgo+IEUuZy4gYnVsa19tb3ZlYWJsZSBzaG91bGQg
b25seSBiZSBzZXQgdG8gZmFsc2Ugd2hlbiBhIHRhYmxlIHdhcyBmcmVlZC4KTWFrZXMgc2Vuc2Uu
IEluIHRlcm1zIG9mIGJ1bGtfbW92ZWFibGUsIGhvdyBhYm91dCB0aGlzOgoKIMKgwqDCoCDCoMKg
wqAgwqDCoMKgIHdoaWxlIChjdXJzb3IucGZuIDwgZnJhZ19zdGFydCkgewogwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIC8qIE1ha2Ugc3VyZSBwcmV2aW91cyBtYXBwaW5nIGV4aXN0ZWQgKi8K
IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBpZiAoY3Vyc29yLmVudHJ5LT5iYXNlLmJvKSB7
CiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIHBhcmFtcy0+dGFibGVfZnJlZWQg
PSB0cnVlOwogwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBhbWRncHVfdm1fZnJl
ZV9wdHMoYWRldiwgcGFyYW1zLT52bSwgJmN1cnNvcik7CiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgfQogwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIGFtZGdwdV92bV9wdF9uZXh0KGFk
ZXYsICZjdXJzb3IpOwogwqDCoMKgIMKgwqDCoCDCoMKgwqAgfQoKSXQgc2hvdWxkIHNhdGlzZnkg
YnVsa19tb3ZlYWJsZSBmbGFnLCBhbmQgYWxzbyBzYXZlIGZyZWVpbmcgCmN1cnNvci5lbnRyeS0+
ZW50cmllcywgd2hpY2ggYXJlIHByZS1hbGxvY2F0ZWQgaW4gdGhlIGJlZ2lubmluZyBvZiB0aGlz
IApmdW5jdGlvbihhbWRncHVfdm1fdXBkYXRlX3B0ZXMpLCB0aGUgcHJlLWFsbG9jYXRpb24gY2Fu
IGJlIHNhdmVkIGlmIG5leHQgCm1hcHBpbmcgaXMgYSBzbWFsbCBwYWdlIGFzIHdlbGwuIEl0IHNl
ZW1zIHRoZSBtb3N0IGVmZmljaWVudCBhcHByb2FjaCAKZm9yIG1lLgoKUmVnYXJkcywKRXJpYwo+
Cj4gVGhlIG9ubHkgY2FzZSB3aGVyZSB0aGlzIGRvZXNuJ3QgbWF0dGVyIGlzIHZtX2ZpbmkgYW5k
IHdlIHJlYWxseSBkb24ndCAKPiBjYXJlIGZvciB0aGF0IHNwZWNpYWwgb25lLgo+Cj4gUmVnYXJk
cywKPiBDaHJpc3RpYW4uCj4KPj4KPj4gUmVnYXJkcywKPj4gRXJpYwo+Pj4KPj4+IFJlZ2FyZHMs
Cj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+IGFtZGdwdV92bV9wdF9uZXh0KGFkZXYsICZjdXJzb3Ip
Owo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFyYW1zLT50YWJsZV9mcmVl
ZCA9IHRydWU7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+IMKgIMKgwqDC
oMKgwqDCoMKgwqDCoCB9IGVsc2UgaWYgKGZyYWcgPj0gc2hpZnQpIHsKPj4+Cj4+Cj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
