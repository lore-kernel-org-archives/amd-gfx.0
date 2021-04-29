Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E511C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 15:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045E2600D4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 15:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045E2600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94CA56E176;
	Thu, 29 Apr 2021 15:18:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C946E176
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 15:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfTv97DqD4OhvwJ7xsl4ryatIm84mvDU8EKxE27FP8xGvO46mn7N8L2PAwCUTDUymT8Z9JjFMAAbtFmytfOBzrsrSdcliXTc80l9cl+V4GPjz4t27PZeQkxBQFVabtg6n0TtLaUuOfOU5TqjRa/b3dBFUbtwFMPKgCpVj9xwflhOR+wb0YkCagy+AsozYOa/AzQj6Cpjkeaq88kCkU4EAwGbylbKWnvt7GHBG8SGJ31/lzGfms0f7j21XEtus8Hw8eQHYexSZmALq8sPK6y5hQIrSZrjtIVHbS6AySshjWERCtVyUkH2Q401QAACO1mcbZLiujad9VwB5JNai+10Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ57P4VkXx36xvy5lBlIyOsI6JOgCU5Xn2Mv/Gy0Vng=;
 b=RN3mSbIy6MmQ8kemVsLzevypraJnusBsELE7Rto2ZQSq3wLfjFpOP4af72sb2lLFt7h5pXTaX+BoQXXzO+2u26OCMNLW+ESgV8OwMfnE6O5kINFJwZ4/qW/fplSsG/g5TytMTHYlPEKtUpdhGo1Cp1uvQmMH2u1QKEcStr3ngL0wLA9wGubZSDpalvkEnsLd6POJCM8IS2BfZ3hZaSN2VUnzvRfbU0KTMWdx6w/4mC6WtsUJSU6ArslSxpg25iC9jo2KJaH/6nGf7EC6PadxOAMYDk7QhGSVxlZ60r5CnBsVo7rMn9B+lrHGxttJM4CBTFlt+8uqkf1xqSFgR5RMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ57P4VkXx36xvy5lBlIyOsI6JOgCU5Xn2Mv/Gy0Vng=;
 b=UDQkq1GrqR2eUWuidyS2plVjInPmqO6QyCdts8NonXQL4cM3GfEn+AQYm3WZzWCYlyO5Wkeyvo3mZ+hYxeDSm0sUMRGQ66tNKo4KTo/ckzKFBMl7cqrinpahF2q9/9Kv5PYL+BKMXwFWNaeDc+D4Z+ULu5vUpPxOTUgdKPitp00=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 15:18:28 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 15:18:28 +0000
Subject: Re: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210429093609.71616-1-jonathan.kim@amd.com>
 <1b6ed66a-72e5-50f7-f9b9-020da1d980cd@amd.com>
 <DM5PR12MB46802AFF0B15821282F6C5FB855F9@DM5PR12MB4680.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5fc5458c-3fa6-e10e-d8cd-97b07c597239@amd.com>
Date: Thu, 29 Apr 2021 11:18:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <DM5PR12MB46802AFF0B15821282F6C5FB855F9@DM5PR12MB4680.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::43)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 15:18:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a22d9241-7b69-421b-b89d-08d90b220a79
X-MS-TrafficTypeDiagnostic: MN2PR12MB4142:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4142C4F674C228D74A6DB57B925F9@MN2PR12MB4142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGWkuYENc8RgEi8AIVqIYz3nD2BppMs9UcVYULUi0OXDXYwhZgw8gU+wbEwypx8n2+kGKkaIsTCUIsg5sC+Cy0meCkS1tIxQr4ET9e4q6P8Wfc71yoE0giRspzrPcvqQi8GrLTDbF/gNKeVSoe+nPRlh3jBm/q3zCmhuv2xT+wDyFkozQc/sqo9tbUzaUYxS41e4VBBd2TuAEfGeotz3hrDPwHwi/D4h3wSDtsxDhTxSPA7j0xyLKZW9CMxPEBZLVtAZxQ2JMH5tTmAcnugfq0UF96UICYpujhHsmJuiQcaT8P4gnrT00uncRp7yannRakJSv3XF0j15DFeXOYbhUR83L9kv1Jwk7/kDj0EkeNe6FZnUsiqsnA00U4uR3IrU8PysRqrz+AGw0xHkf/mzvXksFcggHjIiRoErNgJwj1i/x9KmrHhr7kDbiFqQRU6/qqfuDzVRNxWh5BP2ccjFQCZwsI8C5cXf17mATevT4oLNcmFpAEBgsmn3rdNCvKOsh+LVp1wqE+pbGoJVWaeJUyqXyzkegYUVDij12L+TORuE3iV4/ixs33mJodE3lWnbukeuDO5B0ZdYvCfG/n+efizcrCrK3R1QbXTZHUR8aUzuPyDl923wZ/Pf+zXNlutWYcM90bO4qs3qxzor0LmacTK+00Nf/TIt+8AMcr1663ezz4WzGoKhP3GxGVW+QIRZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(66556008)(478600001)(53546011)(66946007)(66476007)(2616005)(54906003)(956004)(38100700002)(31686004)(6486002)(86362001)(110136005)(316002)(16576012)(8676002)(8936002)(26005)(83380400001)(16526019)(31696002)(2906002)(5660300002)(186003)(4326008)(36756003)(44832011)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c09hZ1piQnhyQ0dmeHExUUpJSDJ2YXFlbFJKZDQ5by91Y0N3bVB3NEFUN0Zx?=
 =?utf-8?B?NGt3RjJtS3ZINFV6ZlErM3RrREsxd1pJQWVTNjkzV0NTWlZTZDgwTmo1aUZJ?=
 =?utf-8?B?Y2ZYTXlwSlkxSmpIVzBQOGRrUWd2cTdkdUNFeSs2aFY4YkdtZ3crejBJYVZQ?=
 =?utf-8?B?Z05IOUpGK2FUNWF2QXZpZmN4b0t6Y0x6QzZOd3llVVNidXMyd1cyVGs1M1Q0?=
 =?utf-8?B?dkdUcUN3S1Ura3BmTUxUZGpMck5tTU1Tanh6alpQbGtvWWd3YkF4SytzWHFK?=
 =?utf-8?B?S2F5Z3BCS21LcGIxMkRESWRyTU5CemJjeTNMck5xRXFLSnFRcWw5N0NxTDdJ?=
 =?utf-8?B?WGhWQWMxM00xSmoyTVFYR2s4bUlNVUNYTUQ0NGF5YmtGaExvdTZoTFcySmMr?=
 =?utf-8?B?dDNTaTNmbFpNeG05WG51aEdIYW05MWRSc1pucXlDZ05MTkpyWlFTcTd0Y0lT?=
 =?utf-8?B?ODhja0VUN0pkekVRcm5LWGJuVGdhakIrOFczS2EybmZtYTZXYkE2N2lEQVVu?=
 =?utf-8?B?VmRCdmhpZGZFNEt5MllCbmd3VGMxbWZlZUR6dkRHck5aQm1NeUFDNXl1OEJY?=
 =?utf-8?B?YzluczFWZDFkSFlMZnhHcXlPSHFmWnpPYklDOWFjSTVVUktRZEsyZFlyMy9W?=
 =?utf-8?B?Rmx1WjVkYndMVzlQTm03cTIxZmlxQUI1RkJheE5UL3JyN2dFK0xzSWlsakxs?=
 =?utf-8?B?cU00V1lFN3hvVW56RDJRY3hJZU1JSzNtRzR2NDdNUXYwdVRwT3Yra21rQVFt?=
 =?utf-8?B?aWt0enJ3OWRGMmtDK3JQeW5kWXdONVNnaGgweGkrenVjYU5IODVmQ1BTVVRY?=
 =?utf-8?B?dWZVa21VNUpkaWV1OWJXL3ZZSHVtSFo3MWhJN1VGNjV5cXQ1MzBIaXVJWXda?=
 =?utf-8?B?dkt6VmRjZVYzR21nalJmWnBSVnBPdDRZMjJQNklFS3hPRTlCajRBZ21PTGxK?=
 =?utf-8?B?TGl4bGNOaHYvdnhtUUxwZSt5c3pGazR3SHRRVlBZQTlVVmRSK0lwNnI1SUdm?=
 =?utf-8?B?TTNkUWRsL2haMjMydVUxREFsUUNOWDZlQmlqamVjUWMwNmtOa24zYWcyUzlj?=
 =?utf-8?B?azI1ZWR3U1VjZ21CTHNiMUJhY3FsMGVMYjRrbDU5a1NRRmZ5WUV2QllCa1hz?=
 =?utf-8?B?UzRuNi93dGJlSDgrYTlEM0FiMEp1OHlzRkRFNnRidDhvdXNDL2MrSUFLVWY0?=
 =?utf-8?B?R1RleExwWnF3U3graEY2eGhIWENCU2xVY2hranREOUY2dTd2enRLMzRMdElx?=
 =?utf-8?B?SjVvZ3pRb3VzQVFCdHFXRFE2cWRML2NOZDB5bjBPMHYzWE5DcTJZeXlLVmtU?=
 =?utf-8?B?UFU5ZzlJUENhbVF6czYrUTVhWTYrRWVPanM4OC9HZGJIYk55aHZHVTVzUnkv?=
 =?utf-8?B?dklsWUpOKzBzYXY1elRvenpBM0pxUVNKTlVMdW5tSSthbUxTNldzV0hVTEVx?=
 =?utf-8?B?TmJ0Y3lVOFZaUVlTOTdxN2tmcVJpTytlVEl6aGx6QzN0bi9lSVdEcUpKKzFu?=
 =?utf-8?B?eVpBUDhESC9sNFA1YXk1N25hajRDaWZCMElFcndNREJSaXNxTGpoanRvQWpO?=
 =?utf-8?B?aWhLTjQzQ3VvYVEvOHMraDBzOVcvS1NwVXYyelJ5UUE1ZG9GRmNxVnFoNWRC?=
 =?utf-8?B?SUs5TUhhRWk1MDJtbnFvQTZHVUhvd0lHTlRJMTNpZEk1YkVDVmJybXRqMnE3?=
 =?utf-8?B?UGx3VTRyaW83a3QyUzVQYTJMbStXdVhFbXYvZXBmdmxtdFF6WTcwQ1ZSZW01?=
 =?utf-8?Q?YF6z6AwEhAm/yFeKIRAlzot3gtaOl8QmtyqzmHP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22d9241-7b69-421b-b89d-08d90b220a79
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 15:18:28.3164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pItamNF++47wEjHe7lSHuIwjAHxal9AJNWWoPcUNFgec7siLJBRH5pvoE42D2/kBev/gZ7hQQZWZE4yB3nDq0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
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
Cc: "Zeng, Oak" <Oak.Zeng@amd.com>, "Errabolu,
 Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNC0yOSB1bSAxMTowNCBhLm0uIHNjaHJpZWIgS2ltLCBKb25hdGhhbjoKPiBbQU1E
IE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4KPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPgo+PiBTZW50OiBUaHVyc2RheSwgQXByaWwgMjksIDIwMjEgMTA6NDkg
QU0KPj4gVG86IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBhbWQuY29tPjsgYW1kLQo+PiBn
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IENjOiBaZW5nLCBPYWsgPE9hay5aZW5nQGFtZC5j
b20+OyBFcnJhYm9sdSwgUmFtZXNoCj4+IDxSYW1lc2guRXJyYWJvbHVAYW1kLmNvbT4KPj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogcmVwb3J0IGF0b21pY3Mgc3VwcG9ydCBpbiBp
b19saW5rcyBvdmVyCj4+IHhnbWkKPj4KPj4gQW0gMjAyMS0wNC0yOSB1bSA1OjM2IGEubS4gc2No
cmllYiBKb25hdGhhbiBLaW06Cj4+PiBMaW5rIGF0b21pY3Mgc3VwcG9ydCBvdmVyIHhHTUkgc2hv
dWxkIGJlIHJlcG9ydGVkIGluZGVwZW5kZW50bHkgb2YgUENJZS4KPj4gSSBkb24ndCB1bmRlcnN0
YW5kIHRoaXMgY2hhbmdlLiBJIGRvbid0IHNlZSBhbnkgY29kZSB0aGF0IGdldHMgZXhlY3V0ZWQg
aWYKPj4gKGFkZXYtPmdtYy54Z21pLmNvbm5lY3RlZF90b19jcHUpLiBXaGVyZSBpcyB0aGUgY29k
ZSB0aGF0IHJlcG9ydHMKPj4gYXRvbWljcyBzdXBwb3J0IGZvciB0aGlzIGNhc2U/Cj4gVGhlIGF0
b21pY3MgYXJlbid0IHNldCBidXQgcmF0aGVyIE5PX0FUT01JQ1MgYXJlIHNldCBpZiBub24teGdt
aSBhbmQgbm9uIFBDSWUgc3VwcG9ydGVkOgo+IGNwdV9mbGFnIHw9IENSQVRfSU9MSU5LX0ZMQUdT
X05PX0FUT01JQ1NfMzJfQklUIHwgQ1JBVF9JT0xJTktfRkxBR1NfTk9fQVRPTUlDU182NF9CSVQ7
Cj4gYWRldi0+Z21jLnhnbWkuY29ubmVjdGVkX3RvX2NwdSA9PSB0cnVlIHdvdWxkIGJ5cGFzcyB0
aGlzIGZsYWcgTk9fQVRPTUlDUyBzZXR0aW5nLgo+Cj4+IEFsc28sIHRoZSBQQ0llIGNvZGUgZG9l
c24ndCBjbGVhciBhbnkgYXRvbWljIGZsYWdzLiBJdCBvbmx5IHNldHMgZmxhZ3MgdGhhdAo+PiB3
b3VsZCBiZSBzZXQgZm9yIFhHTUkgYW55d2F5LiBTbyBJIGRvbid0IHNlZSB3aHkgeW91IG5lZWQg
dG8gbWFrZSB0aGF0Cj4+IGNvZGUgY29uZGl0aW9uYWwuCj4gQXMgbWVudGlvbmVkIGFib3ZlIHRo
ZXkgc2V0IE5PX0FUT01JQ1MgaWYgbm90IFBDSWUgc3VwcG9ydGVkLgo+IFRoaXMgaGFzIGJlZW4g
b2JzZXJ2ZWQgb24gQWxkZWJhcmFuIHdpdGggQU1EIHN5c3RlbXMuCgpPSy4gSSBtaXNzZWQgdGhh
dCB0aGVzZSBmbGFncyBhcmUgbmVnYXRpdmUgbG9naWMuIFRoYW5rcywgdGhlIGNoYW5nZQptYWtl
cyBzZW5zZSBub3cuIEJ1dCB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gaXMgYSBiaXQgbWlzbGVhZGlu
ZyBjb21wYXJlZAp0byB0aGUgY29kZS4gQSBkaWZmZXJlbnQgd29yZGluZyB3b3VsZCBtYWtlIGl0
IGNsZWFyZXIsIGUuZy46ICJEb24ndCBzZXQKTk9fQVRPTUlDUyBmbGFncyBvbiBYR01JIGxpbmtz
IGJldHdlZW4gQ1BVIGFuZCBHUFUuIgoKV2l0aCB0aGF0IGZpeGVkLCB0aGUgcGF0Y2ggaXMKClJl
dmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KClJlZ2Fy
ZHMsCsKgIEZlbGl4CgoKPgo+IFRoYW5rcywKPgo+IEpvbgo+Cj4+IFJlZ2FyZHMsCj4+ICAgRmVs
aXgKPj4KPj4KPj4+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFt
ZC5jb20+Cj4+PiBUZXN0ZWQtYnk6IFJhbWVzaCBFcnJhYm9sdSA8cmFtZXNoLmVycmFib2x1QGFt
ZC5jb20+Cj4+PiAtLS0KPj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xv
Z3kuYyB8IDI5Cj4+PiArKysrKysrKysrKysrKy0tLS0tLS0tLQo+Pj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxOCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPj4+IGluZGV4IDA4M2FjOWJhYmZhOC4u
MzA0MzBhZWZjZmM3IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3RvcG9sb2d5LmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90
b3BvbG9neS5jCj4+PiBAQCAtMTE5Niw2ICsxMTk2LDcgQEAgc3RhdGljIHZvaWQga2ZkX2ZpbGxf
aW9saW5rX25vbl9jcmF0X2luZm8oc3RydWN0Cj4+PiBrZmRfdG9wb2xvZ3lfZGV2aWNlICpkZXYp
ICB7Cj4+PiAgc3RydWN0IGtmZF9pb2xpbmtfcHJvcGVydGllcyAqbGluaywgKmNwdV9saW5rOwo+
Pj4gIHN0cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpjcHVfZGV2Owo+Pj4gK3N0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2Owo+Pj4gIHVpbnQzMl90IGNhcDsKPj4+ICB1aW50MzJfdCBjcHVfZmxh
ZyA9IENSQVRfSU9MSU5LX0ZMQUdTX0VOQUJMRUQ7Cj4+PiAgdWludDMyX3QgZmxhZyA9IENSQVRf
SU9MSU5LX0ZMQUdTX0VOQUJMRUQ7IEBAIC0xMjAzLDE4Cj4+ICsxMjA0LDI0IEBACj4+PiBzdGF0
aWMgdm9pZCBrZmRfZmlsbF9pb2xpbmtfbm9uX2NyYXRfaW5mbyhzdHJ1Y3Qga2ZkX3RvcG9sb2d5
X2RldmljZSAqZGV2KQo+Pj4gIGlmICghZGV2IHx8ICFkZXYtPmdwdSkKPj4+ICByZXR1cm47Cj4+
Pgo+Pj4gLXBjaWVfY2FwYWJpbGl0eV9yZWFkX2R3b3JkKGRldi0+Z3B1LT5wZGV2LAo+Pj4gLVBD
SV9FWFBfREVWQ0FQMiwgJmNhcCk7Cj4+PiAtCj4+PiAtaWYgKCEoY2FwICYgKFBDSV9FWFBfREVW
Q0FQMl9BVE9NSUNfQ09NUDMyIHwKPj4+IC0gICAgIFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09N
UDY0KSkpCj4+PiAtY3B1X2ZsYWcgfD0gQ1JBVF9JT0xJTktfRkxBR1NfTk9fQVRPTUlDU18zMl9C
SVQgfAo+Pj4gLUNSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfNjRfQklUOwo+Pj4gK2FkZXYg
PSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKikoZGV2LT5ncHUtPmtnZCk7Cj4+PiAraWYgKCFhZGV2
LT5nbWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1KSB7Cj4+PiArcGNpZV9jYXBhYmlsaXR5X3JlYWRf
ZHdvcmQoZGV2LT5ncHUtPnBkZXYsCj4+PiArUENJX0VYUF9ERVZDQVAyLCAmY2FwKTsKPj4+ICsK
Pj4+ICtpZiAoIShjYXAgJiAoUENJX0VYUF9ERVZDQVAyX0FUT01JQ19DT01QMzIgfAo+Pj4gKyAg
ICAgUENJX0VYUF9ERVZDQVAyX0FUT01JQ19DT01QNjQpKSkKPj4+ICtjcHVfZmxhZyB8PQo+PiBD
UkFUX0lPTElOS19GTEFHU19OT19BVE9NSUNTXzMyX0JJVCB8Cj4+PiArQ1JBVF9JT0xJTktfRkxB
R1NfTk9fQVRPTUlDU182NF9CSVQ7Cj4+PiArfQo+Pj4KPj4+IC1pZiAoIWRldi0+Z3B1LT5wY2lf
YXRvbWljX3JlcXVlc3RlZCB8fAo+Pj4gLSAgICBkZXYtPmdwdS0+ZGV2aWNlX2luZm8tPmFzaWNf
ZmFtaWx5ID09IENISVBfSEFXQUlJKQo+Pj4gLWZsYWcgfD0gQ1JBVF9JT0xJTktfRkxBR1NfTk9f
QVRPTUlDU18zMl9CSVQgfAo+Pj4gLUNSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfNjRfQklU
Owo+Pj4gK2lmICghYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzKSB7Cj4+PiAraWYg
KCFkZXYtPmdwdS0+cGNpX2F0b21pY19yZXF1ZXN0ZWQgfHwKPj4+ICtkZXYtPmdwdS0+ZGV2aWNl
X2luZm8tPmFzaWNfZmFtaWx5ID09Cj4+PiArQ0hJUF9IQVdBSUkpCj4+PiArZmxhZyB8PSBDUkFU
X0lPTElOS19GTEFHU19OT19BVE9NSUNTXzMyX0JJVCB8Cj4+PiArQ1JBVF9JT0xJTktfRkxBR1Nf
Tk9fQVRPTUlDU182NF9CSVQ7Cj4+PiArfQo+Pj4KPj4+ICAvKiBHUFUgb25seSBjcmVhdGVzIGRp
cmVjdCBsaW5rcyBzbyBhcHBseSBmbGFncyBzZXR0aW5nIHRvIGFsbCAqLwo+Pj4gIGxpc3RfZm9y
X2VhY2hfZW50cnkobGluaywgJmRldi0+aW9fbGlua19wcm9wcywgbGlzdCkgewpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
