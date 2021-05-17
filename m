Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A64C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D970C61CFD
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D970C61CFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C826E9AE;
	Mon, 17 May 2021 14:41:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460986E9AE;
 Mon, 17 May 2021 14:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfNNOIubHpBEbkSExoGLMYS1ZdrLBz6k93p0Vbk0qCPAFtncTtCtf00TYptnOcMWqOpk7q9RgmXikChk69MpE1n2TVsZJ0Sh8F4OhMhYEoxbfufxYPbIt+CR9LG4HBx+XFpSoEkn1bQza4Zrcu05GgkT6RqAyxv6ElAxj4cdKLdvbdtEo6wXWo8YGm59ulTh/JXJdNp6BnNzjSWbVI1Q26M6EJX9FXn3Vv9Aufntw8widGVIBUcKOYEkRSJlnY7VPpMU3RjrM0u4BjkTo49aplSojK/QoeOivX27pUyqHLVTeMkW+bAbMguh/cZbx+EO2hmNhJmMoGpNMBCw2OTNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF8hxzqxfau3eK1fDMo1UVfoYa4Oj9P1NKMYJOU2u5k=;
 b=P1OVaKwgONDGvHBA++FJ+pANSJd6G6AVumOcqP0TsqqkDdPBJGkI3irN2Cx/nOcG8ZzoCb2BtDHmkw/vLO5XMqFikIo7VuPbuQQGdzrn039gyET0TFWWEMTg51NzkQ5dx3UWhwVkyda/e/80jApILFRliAkagxjEHVeAaM9+oxjies9ODRVLZH2ykaABiOJ8CHq5lArAnbxlrtuegzRdGyMBccPHVBbzDN2J+y5XB3lal3Pe+2MliHBvyzQSFmKPnb6BZyk2OiDAvUJT+d8kOVykA3RXMTqsNGD9lzkDTMABzwJrkiqNWMbVWxgdyDaawSfEem4bLU6947+ybdQfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF8hxzqxfau3eK1fDMo1UVfoYa4Oj9P1NKMYJOU2u5k=;
 b=zMvlSs2RPYkdT3vbSdwcDrvx4SCgwieZq/Ksc5XtmPVGFtXgmFii6qHCfdErF86F7ZZEC1uUriRLbOzNqs+Sd0U7Y/Ok/gaWLq9hzYvXuZL8TvgHn+b+QDe9DTdH8HwZ1IRB1wHmtWjY7ViyZC2GVj+bKjxSv8WXg1A6s/B1oz0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4766.namprd12.prod.outlook.com (2603:10b6:805:e2::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 14:41:07 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 14:41:07 +0000
Subject: Re: [PATCH v7 16/16] drm/amdgpu: Unmap all MMIO mappings
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-17-andrey.grodzovsky@amd.com>
 <5e2f2b3a-78bd-38e6-8cc1-d138fb4ddaa3@amd.com>
Message-ID: <cf88ff87-211a-4b85-9415-c91afc26bdb7@amd.com>
Date: Mon, 17 May 2021 10:41:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <5e2f2b3a-78bd-38e6-8cc1-d138fb4ddaa3@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:e3b1:83be:2b02:85cb]
X-ClientProxiedBy: YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::18) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:e3b1:83be:2b02:85cb]
 (2607:fea8:3edf:49b0:e3b1:83be:2b02:85cb) by
 YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Mon, 17 May 2021 14:41:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eaf5d13-5157-45d1-ebcf-08d91941ccf2
X-MS-TrafficTypeDiagnostic: SN6PR12MB4766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4766E0DFF113080A608C7D3EEA2D9@SN6PR12MB4766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JRVrPswyIra3/DxlxOd5nV9XzfqsNxtZmJZ0KA0weXVcqKxQw3+BaHb34YsbN8I09mqU0SBIIP8kFGfiUxyc4J5yfIeDfN6zHAtjneTogbcu/YPAMPivV+cqn4ZCQtrxdaPdjNaVyHAgQf43Ne1XdcBkjbHn/ZCrQ14omB3ecPO6+kboiKhzsMVk8jD48FFkUkjWfDoeRbVXjhhO1EUZ7bFNQ1xjRSE8XISGT6XnXTptHixbyqX1ennAsgnPv8UVjbELXJh1ovjMJvZ5GdDnLCIhDobg+MiTJNZmcj+dr9QyDP73cAMgahpsOBGw6cNaU+imfxZ9IVnBF1p7l5Zf84qWwfJFxqBWEX7Buk9UKy8RGC6pRjVkbXeiGWktmBa3XvcL9ya4gTdLtxEJj81NCaBDF/T+FQYab5ieZMsRffNkGXlDwGS9GCEjga2ZaxIgtAtHyz2QnPY6Bl6fL5Th5dDwwOVxRJTHhbmgn9p9lWuDUQFvqCM/Igs4h1DUVw6c0u9A1CuVp3Yjz8fi4yHOwca3E7HdjaOxTAJF+HFyFH1/YDbvI/qUxxlEnN6wj7ArWKJN8TutVMX3QQ1Bb4h3Qu73Z7CGOx8tLkCNQ36DsHmd76CMHq9JIaUbE+w1JbJ5H1tRFyuoqN3PC+REeaWyBg2hxOsoFYBtLL8+Yf/JAnUr5M1qoSmT7Huqv+8337Ds
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39850400004)(366004)(136003)(6486002)(31686004)(66946007)(52116002)(4326008)(53546011)(31696002)(186003)(8936002)(8676002)(2906002)(6636002)(83380400001)(5660300002)(316002)(38100700002)(86362001)(2616005)(16526019)(66556008)(36756003)(44832011)(478600001)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NVdMOFc5TjlxVTBRQ1VCQnFFVFRyRk5VdENFMFJ6cmlzRHhtN0pVNmdkSzU2?=
 =?utf-8?B?Uk9ueWR0TXk3cU9PS1hYZDRleHdzNklGVFhLMHlsTnhvR0JCa0NoMXNka0t5?=
 =?utf-8?B?VHp6OGFQZ09za2VUSngveDE0SWhMUDc2UFB3aU1zNlkrbCttaTdoNkFBMk5E?=
 =?utf-8?B?aWNjSVB0SXRmd21zelQxMzJGbWllYnBzSEZNcXdkWEdGMVFlQTI0MDVaVlRM?=
 =?utf-8?B?ZkFsR0t4UXFiWTEvRTRwVkZreFg2Z3NlTUFLZHB3WHlXK3NRaGFVUXZGMzFy?=
 =?utf-8?B?Q0xkU2dFeStDWWV2U0ZnK2IvQWVkYjdobWh6TnBvODVya3ZuYkpITmZnN2hJ?=
 =?utf-8?B?VExyVzUxMDJOUkp3ZEViSVNsNE8vRmFhVXJOVnBrVFN5SlhZOGU3dEE3THhy?=
 =?utf-8?B?Rkxpd1JwdndjVTJlWU1NK25VS1dxUE5Ea0t5U0YyL3VuR2VjcTUyN3MrLyt5?=
 =?utf-8?B?ajh6VjgrWEhYelRkMG1CWVoyR1RXUWpuREhINnIyZjltSlgxb1MrQTFvektT?=
 =?utf-8?B?K1FWZlkycXNaSEJxdGRhc2Q0LzR0L3BkdmNydTNHV3h6RmtmdnZ4ZThzSGZq?=
 =?utf-8?B?TlpqN1dQMDRCdXM0N2hOL2M5dlBiNW56OWlFTS94QmVSNk5HOGNROTZDcFhM?=
 =?utf-8?B?YnJ3K1JFUzRiYjB5bzN0VjhGMkE3cXgyY0NXanJOTm9BZkUvNkc1aUNqVHln?=
 =?utf-8?B?ZnBJV0VyS1hkanNxTlZXSGdTZ1NrN1I3bVBaUVY4aEZ0NFp2MzBJeFB6czIv?=
 =?utf-8?B?c0VuTmpmZno3T1Vpa3BDVk1XRDR3Y1B0UXNUVTRwaHgrZVZuYWhwRW91NWcx?=
 =?utf-8?B?YjEzNDd2SWMzc1ZtTE1aTVkxMHo5bTVtcUJORTdxa3RjM1B5Nk0zcTRhWGJC?=
 =?utf-8?B?cWpiQ29vQXZzWG1xeCtXNGhvTVBkSGdxUlBpV2RwSjRHekxnNHJjNXFuL0gz?=
 =?utf-8?B?TUcxRS9pcFVFTGxZZ1JUdENCT0dvUUxNdlZRMjhKdFFNQkQzV1VxTWFRTlpl?=
 =?utf-8?B?MHhLeVlONHNCc1FmN2IycnFqTDdsVGlIRTB3eUQ2d2hRYXhtWWtzRmlIdlQx?=
 =?utf-8?B?QXdudzJGRjJXcG1oYTRoRzUrcnBwVkRESm5OUzl0ODZ0WG9kV1RxTEE1UjhP?=
 =?utf-8?B?ZUd5Z1RWRE51N2xLNVpWUXBHRFdnOHRkTEdVZTlpQXhaUDgzT21vYXZqRjRD?=
 =?utf-8?B?RUVPV2E5czZPRUovVFJTTXBPcCt5R21TeURYTnBGM2tKN0lrY1NuNnlBODZO?=
 =?utf-8?B?VWxNV21qQWg3M3diRkdzSTR2YVpTWFVlS0Z3anNXU0h1THh3UUJKczhVNk0z?=
 =?utf-8?B?bHpNeTBNUXIwQkE5bDVyTEg3cm13anh0Nm1qa09ZcFNXakFyU3FrZlJFczFp?=
 =?utf-8?B?RTNZUDJQQUJBcGFvUFQ5N3dpYnl2dWswaytxN2VPMlp6MWxlYm04QzBHQlF5?=
 =?utf-8?B?a01lQXBVcDZ2OTNPMnp3WmlaY3IzVjlrRVpsU3hiaVlZbGpWdFAvYWRSQWY5?=
 =?utf-8?B?cXNxL0tEbUowajcvUlRvMU81N3orVVN5MkNYN1AvbVVjdkdSS1Z4YnNnTGk0?=
 =?utf-8?B?ekVaTExML215cGxCd1JuVnozWERTUE5zOG9Eb0lmUVJRZmhDY0JlazFrRWRB?=
 =?utf-8?B?dmJyZXlGNUYxYmxEK2hmZWw1TGlFSms2QllXSzVDZWFHdTJ3Qkwvd083dXBE?=
 =?utf-8?B?VHcvWlVPUWFyUlM1Qlh6YS91aDdrUkVNU21HYXcrWXR6NDFubDNVTnlaM1Nz?=
 =?utf-8?B?VEM3aHJrcjlENkd2blptMEhCLzBoVTczMXJvbWJGWFNTL1JXaHpZUzJ0UXpH?=
 =?utf-8?B?K2gyMlFRWXlpUjh3U1lrRU4xdTd6eStaLzRKRkNjWkhCWXZoR3BSdlFoLzA0?=
 =?utf-8?Q?VEAYaLikRwSPd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaf5d13-5157-45d1-ebcf-08d91941ccf2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:41:06.1611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeFZAGCmf06GdbZPi9uKrv1oSyQsDr2J95DySMcGRiyu2eVHCAUBr1q8RMsiaBRRrXi3PaIL/BcxVVDC2/BEKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4766
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

UGluZwoKQW5kcmV5CgpPbiAyMDIxLTA1LTE0IDEwOjQyIGEubS4sIEFuZHJleSBHcm9kem92c2t5
IHdyb3RlOgo+IFBpbmcKPiAKPiBBbmRyZXkKPiAKPiBPbiAyMDIxLTA1LTEyIDEwOjI2IGEubS4s
IEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+PiBBY2Nlc3MgdG8gdGhvc2UgbXVzdCBiZSBwcmV2
ZW50ZWQgcG9zdCBwY2lfcmVtb3ZlCj4+Cj4+IHY2OiBEcm9wIEJPcyBsaXN0LCB1bmFtcHBpbmcg
VlJBTSBCQVIgaXMgZW5vdWdoLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNr
eSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDI0ICsrKysrKysrKysrKysrKysrKystLS0K
Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIHzCoCAxICsK
Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jwqDCoMKgIHzCoCA0
IC0tLS0KPj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
Ywo+PiBpbmRleCBmN2NjYTI1YzBmYTAuLjczY2JjM2M3NDUzZiAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+PiBAQCAtMzY2Niw2ICszNjY2LDI1
IEBAIGludCBhbWRncHVfZGV2aWNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+
IMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+IMKgIH0KPj4gK3N0YXRpYyB2b2lkIGFtZGdwdV9kZXZp
Y2VfdW5tYXBfbW1pbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gK3sKPj4gK8KgwqDC
oCAvKiBDbGVhciBhbGwgQ1BVIG1hcHBpbmdzIHBvaW50aW5nIHRvIHRoaXMgZGV2aWNlICovCj4+
ICvCoMKgwqAgdW5tYXBfbWFwcGluZ19yYW5nZShhZGV2LT5kZGV2LmFub25faW5vZGUtPmlfbWFw
cGluZywgMCwgMCwgMSk7Cj4+ICsKPj4gK8KgwqDCoCAvKiBVbm1hcCBhbGwgbWFwcGVkIGJhcnMg
LSBEb29yYmVsbCwgcmVnaXN0ZXJzIGFuZCBWUkFNICovCj4+ICvCoMKgwqAgYW1kZ3B1X2Rldmlj
ZV9kb29yYmVsbF9maW5pKGFkZXYpOwo+PiArCj4+ICvCoMKgwqAgaW91bm1hcChhZGV2LT5ybW1p
byk7Cj4+ICvCoMKgwqAgYWRldi0+cm1taW8gPSBOVUxMOwo+PiArwqDCoMKgIGlmIChhZGV2LT5t
bWFuLmFwZXJfYmFzZV9rYWRkcikKPj4gK8KgwqDCoMKgwqDCoMKgIGlvdW5tYXAoYWRldi0+bW1h
bi5hcGVyX2Jhc2Vfa2FkZHIpOwo+PiArwqDCoMKgIGFkZXYtPm1tYW4uYXBlcl9iYXNlX2thZGRy
ID0gTlVMTDsKPj4gKwo+PiArwqDCoMKgIC8qIE1lbW9yeSBtYW5hZ2VyIHJlbGF0ZWQgKi8KPj4g
K8KgwqDCoCBhcmNoX3BoeXNfd2NfZGVsKGFkZXYtPmdtYy52cmFtX210cnIpOwo+PiArwqDCoMKg
IGFyY2hfaW9fZnJlZV9tZW10eXBlX3djKGFkZXYtPmdtYy5hcGVyX2Jhc2UsIGFkZXYtPmdtYy5h
cGVyX3NpemUpOwo+PiArfQo+PiArCj4+IMKgIC8qKgo+PiDCoMKgICogYW1kZ3B1X2RldmljZV9m
aW5pIC0gdGVhciBkb3duIHRoZSBkcml2ZXIKPj4gwqDCoCAqCj4+IEBAIC0zNzEyLDYgKzM3MzEs
OCBAQCB2b2lkIGFtZGdwdV9kZXZpY2VfZmluaV9odyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4g
KmFkZXYpCj4+IMKgwqDCoMKgwqAgYW1kZ3B1X2RldmljZV9pcF9maW5pX2Vhcmx5KGFkZXYpOwo+
PiDCoMKgwqDCoMKgIGFtZGdwdV9nYXJ0X2R1bW15X3BhZ2VfZmluaShhZGV2KTsKPj4gKwo+PiAr
wqDCoMKgIGFtZGdwdV9kZXZpY2VfdW5tYXBfbW1pbyhhZGV2KTsKPj4gwqAgfQo+PiDCoCB2b2lk
IGFtZGdwdV9kZXZpY2VfZmluaV9zdyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gQEAg
LTM3MzksOSArMzc2MCw2IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pX3N3KHN0cnVjdCBhbWRn
cHVfZGV2aWNlIAo+PiAqYWRldikKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgaWYgKChh
ZGV2LT5wZGV2LT5jbGFzcyA+PiA4KSA9PSBQQ0lfQ0xBU1NfRElTUExBWV9WR0EpCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCB2Z2FfY2xpZW50X3JlZ2lzdGVyKGFkZXYtPnBkZXYsIE5VTEwsIE5VTEws
IE5VTEwpOwo+PiAtwqDCoMKgIGlvdW5tYXAoYWRldi0+cm1taW8pOwo+PiAtwqDCoMKgIGFkZXYt
PnJtbWlvID0gTlVMTDsKPj4gLcKgwqDCoCBhbWRncHVfZGV2aWNlX2Rvb3JiZWxsX2ZpbmkoYWRl
dik7Cj4+IMKgwqDCoMKgwqAgaWYgKElTX0VOQUJMRUQoQ09ORklHX1BFUkZfRVZFTlRTKSkKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9wbXVfZmluaShhZGV2KTsKPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyAKPj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4gaW5kZXggMGFkZmZjYWNlMzI2
Li44ODJmYjQ5ZjNjNDEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9vYmplY3QuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmMKPj4gQEAgLTUzMyw2ICs1MzMsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9ib19k
b19jcmVhdGUoc3RydWN0IAo+PiBhbWRncHVfZGV2aWNlICphZGV2LAo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIC1FTk9NRU07Cj4+IMKgwqDCoMKgwqAgZHJtX2dlbV9wcml2YXRlX29iamVj
dF9pbml0KGFkZXZfdG9fZHJtKGFkZXYpLCAmYm8tPnRiby5iYXNlLCAKPj4gc2l6ZSk7Cj4+IMKg
wqDCoMKgwqAgSU5JVF9MSVNUX0hFQUQoJmJvLT5zaGFkb3dfbGlzdCk7Cj4+ICsKPj4gwqDCoMKg
wqDCoCBiby0+dm1fYm8gPSBOVUxMOwo+PiDCoMKgwqDCoMKgIGJvLT5wcmVmZXJyZWRfZG9tYWlu
cyA9IGJwLT5wcmVmZXJyZWRfZG9tYWluID8gCj4+IGJwLT5wcmVmZXJyZWRfZG9tYWluIDoKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGJwLT5kb21haW47Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jCj4+IGluZGV4IDBkNTRlNzAyNzhjYS4uNThhZDJmZWNjOWUzIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+IEBAIC0xODQx
LDEwICsxODQxLDYgQEAgdm9pZCBhbWRncHVfdHRtX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCj4+IMKgwqDCoMKgwqAgYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5tbWFuLmRp
c2NvdmVyeV9tZW1vcnksIE5VTEwsIE5VTEwpOwo+PiDCoMKgwqDCoMKgIGFtZGdwdV90dG1fZndf
cmVzZXJ2ZV92cmFtX2ZpbmkoYWRldik7Cj4+IC3CoMKgwqAgaWYgKGFkZXYtPm1tYW4uYXBlcl9i
YXNlX2thZGRyKQo+PiAtwqDCoMKgwqDCoMKgwqAgaW91bm1hcChhZGV2LT5tbWFuLmFwZXJfYmFz
ZV9rYWRkcik7Cj4+IC3CoMKgwqAgYWRldi0+bW1hbi5hcGVyX2Jhc2Vfa2FkZHIgPSBOVUxMOwo+
PiAtCj4+IMKgwqDCoMKgwqAgYW1kZ3B1X3ZyYW1fbWdyX2ZpbmkoYWRldik7Cj4+IMKgwqDCoMKg
wqAgYW1kZ3B1X2d0dF9tZ3JfZmluaShhZGV2KTsKPj4gwqDCoMKgwqDCoCB0dG1fcmFuZ2VfbWFu
X2ZpbmkoJmFkZXYtPm1tYW4uYmRldiwgQU1ER1BVX1BMX0dEUyk7Cj4+Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
