Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6429C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 15:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5EE611BD
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 15:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5EE611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 965696EE09;
	Wed, 19 May 2021 15:55:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345226EE09
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 15:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZPZuwjlK2vMuW830WZkDhHi/1CS7Qya0tcWOsAqpRYYfFugFyOQc1xAn2l/6gPT9CadsBb84WDnoBe8bhDDb/kS6wrTqczDVES1sRUeEmXTxWiPueCa/v7Bxi0hbevNcFv0ktdsIQHuta4ji07TbNfdw9kUHX8qi6GfUC7Ya1aujqplQDXdQLHr+s3osmIm47in+04+cEGnM/aF/7dOR+Zs4N6cCctl3dFv7QjoWoB3MbODOIWsPUsQOqwNbTkVJczxfCN/mpJQmrrT6sPzce/Q5Mzlt/dV10GjRCN3hAqbKJrpoJAZlEqgSZUa3Upr1rNh4pY2s5UD/bsq5pbAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8cJqyCV/N6CJl02mdhpSKX4si9APirmyXaEfJMqjuE=;
 b=ci4D1rD/SpEJFjkSX6HjmRsMJfo8nBpavxKCOPjCfSGFW0ym5jcG1l06qKjJMs1MDyKgMa01cElyDHdfO6LLFa4bkrkqtkA27gd3oSYLf3RBcXnhksYPMJfdaLvxnPgehQKOzQpy8kQ63DY3o6LF/1nurRDIxI63ogFvgrtGcjEVHoKFNEB+yP70pSWsd8j9JX3JGprpURU4/FgLtL6tQ7J6tztMvLfBpnkupanRKebx5yHthQEQ0Zmp9G+4Y9305WzUYNKtsYLZBIzGbFnFNatT+N9zfMGgdsbarB5WtTVrx2Y8sxXFGMk0v9pABFcPvdwRZdXKeY5CnEcGI2LWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8cJqyCV/N6CJl02mdhpSKX4si9APirmyXaEfJMqjuE=;
 b=wv697AcoFdPSsbGf7skomnbT4mviWCO7F5WWiupQ5f1bbovf0sriNVgFpby0S3HAft3AS5QRHg1Y257Ozqfm5gl9UjVlorUHa1GzudDHPIvKKVP10UkNvFYxOnUC8Erz5gjUaLacs4ms/uehmZ7B1TI9Y2DMYIVRHOKAQkreUOU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 15:55:01 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 15:55:01 +0000
Subject: Re: [PATCH] drm/amdgpu: Disable cwsr for vega10 and Sienna_Cichlid in
 sriov
To: Chengzhe Liu <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210519090242.888065-1-ChengZhe.Liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a2c7bc50-498e-7cbd-b79e-fbd276588789@amd.com>
Date: Wed, 19 May 2021 11:54:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210519090242.888065-1-ChengZhe.Liu@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.56.206]
X-ClientProxiedBy: YT1PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::6) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.56.206) by
 YT1PR01CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 15:55:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 832fda43-fc03-4350-8acc-08d91ade761e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5196DE8650987D48A7D7506B922B9@BN9PR12MB5196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnzAD4kj7yyivvvSaWfTePMkrGaPGXLYXfjbguCaJypOi2rtxdVofmNfJwRDZRkc4nz5boGUJ/fmY+v9HhhuNWGWSzLoz9PzlsUrOHugkJdgLfCjOMY5hxk3Le9RZGXn+sQqMexhkloMje50WFg1NYO48I/lZIed7MYt6tRGJQ65wj8q0Ty1CAsd+toqcB1Ha01EJngoaS5Nm2jxCBI2lU5av3Kn+WGf8KnuXD5E7xlRP8mjnnvo6n7MCydKY+MP0RTMiKYBHBWbe2qPbiWJDM92VwKdN9T3YOQ64RRcjrXAZSbYNr2McAVR7GXcsO7WY8/OfB1NLdhsb0zTn5+YqKnaTiwuEGNMQ9yA43giiE+rhaPGGbqsw1ju5eFBtqaLfKt9wERah347t+YR1T17uH+WimSz69WD1GgTS7HY3oJd/d9vHQ6lxo01T9wCE5d8LZF6rKnhGuuzFsaSUqGp94lOsOerHh+lUOYHaRGYlNipEVocUJ/+DxKDIC6+XWzYVl5dtgusM3y9PD712WdrRgyaljo8vOPo0f8cvmqyHXtWHc4yYHPmT7DobM9541h1Zdr4gpW50hRKH+/cPxHf+E5uBmEDws2ld/+azyX+p0RzrsiQn0KGTzAFOXxF7yXlR3mzlUGe+cfsrjc9r3Tj8GrFklDXxa96EnsD2H2IhYGviIDjj3Qfe5ZELH3PQQGy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(86362001)(26005)(478600001)(31696002)(38100700002)(5660300002)(31686004)(2616005)(956004)(186003)(36756003)(66946007)(44832011)(16526019)(8936002)(8676002)(16576012)(66556008)(54906003)(6486002)(2906002)(66476007)(4326008)(316002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V1doNlkyaFN2R2xmMlR3NzYyUDk1dmt3RGZwV3hoWXJUcjNzNndBSnB6TlZ6?=
 =?utf-8?B?VzRoVU5WQy85cmJqMlE3ZDlITVJWRS9mUlJoRXZicmlQbGxqK2Exc0dnb1FE?=
 =?utf-8?B?c0xjajBEbThXODYyMGtCZUN3aFFJa2E0ejVjS01BUEpGNmtIMWl3V091L29E?=
 =?utf-8?B?djRLSEZIM1pXZzRSVmFIM1IxNzNRU2dHeUU1TWhabFhRaEYyWm1yVmhMOUZl?=
 =?utf-8?B?UG9Uc0NEQy9xRTVXZnlHb1RObHRndzU0c1hEUFNBWmRCTTg3enVXVDgvQWh3?=
 =?utf-8?B?RHNjVTVKYksxYlZ2RHlHM1orajdwWWIwRUNPa1c4TFdNaTdvREtGSVYxVHhG?=
 =?utf-8?B?R2toemkyTzUySmNaRWNhOTFRWFY3NFdKQlpOZHNkZ25qTmwvUVk0NFp5emZs?=
 =?utf-8?B?bDd5dXRRZFVMUjJJVENHRzRTUFVEak55ZnVSemhlTnI5ZHlKNktmTGNXUWJa?=
 =?utf-8?B?R1lkdVQ1VjBIcTlIbm9RaVU2dER1L25xdjdBTnNxT1gzVVVDaTN0MWdYN2VJ?=
 =?utf-8?B?UU4rd2hpNlczZms3c1ZsZ21CZHJlUGF2OHFzdi8zWDJMTnU1eU9CVnBDalFz?=
 =?utf-8?B?UHVLZm1ZYUp3OVJHaFdvTUg1MmgrQmxmOWFzak5vVEgwZW8yTkg5ZjdEYjln?=
 =?utf-8?B?cHR3WWRnZ2kvLzdON2JGaUFWNmFVSDVpY2E0UUU3aC9HaXBHSExtRlg4eDJ1?=
 =?utf-8?B?YVk0OG0wUktXNitKaWhqMjJYaENSb3NyWFZudzR3VEJUMGpCdVNWS0dTbXB4?=
 =?utf-8?B?Q2dEdXd2bDN0T2IwNHJzamUvOElsMjcrZ0hlWUlxZm0xdmZ1akE0UkdEUXNk?=
 =?utf-8?B?UHpTVUU1OVJNRTV2SEI3TXRZeStkbjdSSDV6T29sMUdTR2lLSkFtSTY1SzNJ?=
 =?utf-8?B?b0U0NmJxOU1sbFRmenZDaldYTWlMMFI5SXphZ3lObUI1Snp5MFYrVW1jTEtO?=
 =?utf-8?B?SENYaHYxaldCSzlqOEdQVVVjd2VsdXkrcUdFK1FVRkdhK3k1bnoySHJRSnoz?=
 =?utf-8?B?aFR5aDg3cHB5dkxmRFIwdkZQQ09OQndQWFYxam5CUDFZUjQwejdkZTM4N3Vr?=
 =?utf-8?B?ZW51dnhwMGdmMUFVOVg0RnkzOHlNc2hqMHR5RmZ1TDdjdUlORVozTmltMnBD?=
 =?utf-8?B?c2g0TmZab1N3UXJtRFdDYXVHRWRlQy9hd2c4bTZCUk0vdVhRQUJmNlVlV3Jq?=
 =?utf-8?B?UkF4ZDFLaVBmUEZ6RS85R0xqYW1uckpkOE1UVXZBRFZXb2F3djJvNTF0N1pW?=
 =?utf-8?B?SDVldXNZaHlocUsxTVhUaytpNlFEcEdieU5GSDNYMzJ0NkhIYU9ickNMNm9U?=
 =?utf-8?B?Mllxd3FnQUhUVGU5VVpMLzNXRk5veW5WMTk0ZmtGdDhUNWQ0MTQ2MzEvU0Z3?=
 =?utf-8?B?L1pxU2ZMQVh2RUhYQUZPOGlRNzd4ajRTVjdCZUZZUm9LNTdob0F4U0xkSGpr?=
 =?utf-8?B?eVZoYmE0bVRsbmhUemlxVlU1UXhSNURCby8ycTN1eGFRNzFHczk2UXJLaXNM?=
 =?utf-8?B?dWp0UElKMlNzNmVTUFBoODV5U0ZKUlE3MVBicUQ3Q0JTMDBReGxnNUJCNDAz?=
 =?utf-8?B?c2lTMTJFbHdreE13YXdpVnp2MzlTdUhFZ21rajJqM1FtSFVMVGpRNUFSQkxC?=
 =?utf-8?B?eVVudUhaK0lLYmZwcCtSWmVYUWZ0bXN6c2xTQ2VMTFdHczlydUxncVdCa1h3?=
 =?utf-8?B?MlJpa1p4bEhzNnZDb21VYVZKSzdmMWlFa0xXQUxYTHBwUDRLS1R0UG1EcEFH?=
 =?utf-8?Q?GLhWXd9L4oZgQnoGfKKVaefA5uCoNN7an0rHiM7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832fda43-fc03-4350-8acc-08d91ade761e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 15:55:01.7585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddV1CtW1b5pLVAr9cItIHCR2ijcDSJ5aaLidSlisggrENujBVXSneA5U4ByRnaOvsRyCMLSb7xd3ULGwRaXGkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjEtMDUtMTkgdW0gNTowMiBhLm0uIHNjaHJpZWIgQ2hlbmd6aGUgTGl1Ogo+IEluIHNy
aW92LCBjd3NyIGlzIG5vdCBzdGFibGUKTkFLLiBXaXRob3V0IENXU1IsIFJPQ20gaXMgbm90IHN0
YWJsZS4gQW55IGNvbXB1dGUgYXBwbGljYXRpb24gd2l0aCBsb25nCnJ1bm5pbmcgd2F2ZXMgY2Fu
IGNhdXNlIGEgaGFuZy4KClJlZ2FyZHMsCsKgIEZlbGl4Cgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hl
bmd6aGUgTGl1IDxDaGVuZ1poZS5MaXVAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2RldmljZS5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrLS0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+IGluZGV4IDgwMDE1ZTg2NjQ5OC4u
ODliZDAwNTkzMjliIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2Uu
Ywo+IEBAIC0zMzUsNyArMzM1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBrZmRfZGV2aWNlX2lu
Zm8gdmVnYTEwX3ZmX2RldmljZV9pbmZvID0gewo+ICAJLmV2ZW50X2ludGVycnVwdF9jbGFzcyA9
ICZldmVudF9pbnRlcnJ1cHRfY2xhc3NfdjksCj4gIAkubnVtX29mX3dhdGNoX3BvaW50cyA9IDQs
Cj4gIAkubXFkX3NpemVfYWxpZ25lZCA9IE1RRF9TSVpFX0FMSUdORUQsCj4gLQkuc3VwcG9ydHNf
Y3dzciA9IHRydWUsCj4gKwkuc3VwcG9ydHNfY3dzciA9IGZhbHNlLAo+ICAJLm5lZWRzX2lvbW11
X2RldmljZSA9IGZhbHNlLAo+ICAJLm5lZWRzX3BjaV9hdG9taWNzID0gZmFsc2UsCj4gIAkubnVt
X3NkbWFfZW5naW5lcyA9IDIsCj4gQEAgLTUwNSw2ICs1MDUsMjQgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBrZmRfZGV2aWNlX2luZm8gc2llbm5hX2NpY2hsaWRfZGV2aWNlX2luZm8gPSB7Cj4gIAku
bnVtX3NkbWFfcXVldWVzX3Blcl9lbmdpbmUgPSA4LAo+ICB9Owo+ICAKPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBrZmRfZGV2aWNlX2luZm8gc2llbm5hX2NpY2hsaWRfdmZfZGV2aWNlX2luZm8gPSB7
Cj4gKwkuYXNpY19mYW1pbHkgPSBDSElQX1NJRU5OQV9DSUNITElELAo+ICsJLmFzaWNfbmFtZSA9
ICJzaWVubmFfY2ljaGxpZCIsCj4gKwkubWF4X3Bhc2lkX2JpdHMgPSAxNiwKPiArCS5tYXhfbm9f
b2ZfaHFkICA9IDI0LAo+ICsJLmRvb3JiZWxsX3NpemUgID0gOCwKPiArCS5paF9yaW5nX2VudHJ5
X3NpemUgPSA4ICogc2l6ZW9mKHVpbnQzMl90KSwKPiArCS5ldmVudF9pbnRlcnJ1cHRfY2xhc3Mg
PSAmZXZlbnRfaW50ZXJydXB0X2NsYXNzX3YxMCwKPiArCS5udW1fb2Zfd2F0Y2hfcG9pbnRzID0g
NCwKPiArCS5tcWRfc2l6ZV9hbGlnbmVkID0gTVFEX1NJWkVfQUxJR05FRCwKPiArCS5uZWVkc19p
b21tdV9kZXZpY2UgPSBmYWxzZSwKPiArCS5zdXBwb3J0c19jd3NyID0gZmFsc2UsCj4gKwkubmVl
ZHNfcGNpX2F0b21pY3MgPSB0cnVlLAo+ICsJLm51bV9zZG1hX2VuZ2luZXMgPSA0LAo+ICsJLm51
bV94Z21pX3NkbWFfZW5naW5lcyA9IDAsCj4gKwkubnVtX3NkbWFfcXVldWVzX3Blcl9lbmdpbmUg
PSA4LAo+ICt9Owo+ICsKPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBrZmRfZGV2aWNlX2luZm8gbmF2
eV9mbG91bmRlcl9kZXZpY2VfaW5mbyA9IHsKPiAgCS5hc2ljX2ZhbWlseSA9IENISVBfTkFWWV9G
TE9VTkRFUiwKPiAgCS5hc2ljX25hbWUgPSAibmF2eV9mbG91bmRlciIsCj4gQEAgLTYwMSw3ICs2
MTksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtmZF9kZXZpY2VfaW5mbyAqa2ZkX3N1cHBvcnRl
ZF9kZXZpY2VzW11bMl0gPSB7Cj4gIAlbQ0hJUF9OQVZJMTBdID0geyZuYXZpMTBfZGV2aWNlX2lu
Zm8sIE5VTEx9LAo+ICAJW0NISVBfTkFWSTEyXSA9IHsmbmF2aTEyX2RldmljZV9pbmZvLCAmbmF2
aTEyX2RldmljZV9pbmZvfSwKPiAgCVtDSElQX05BVkkxNF0gPSB7Jm5hdmkxNF9kZXZpY2VfaW5m
bywgTlVMTH0sCj4gLQlbQ0hJUF9TSUVOTkFfQ0lDSExJRF0gPSB7JnNpZW5uYV9jaWNobGlkX2Rl
dmljZV9pbmZvLCAmc2llbm5hX2NpY2hsaWRfZGV2aWNlX2luZm99LAo+ICsJW0NISVBfU0lFTk5B
X0NJQ0hMSURdID0geyZzaWVubmFfY2ljaGxpZF9kZXZpY2VfaW5mbywgJnNpZW5uYV9jaWNobGlk
X3ZmX2RldmljZV9pbmZvfSwKPiAgCVtDSElQX05BVllfRkxPVU5ERVJdID0geyZuYXZ5X2Zsb3Vu
ZGVyX2RldmljZV9pbmZvLCAmbmF2eV9mbG91bmRlcl9kZXZpY2VfaW5mb30sCj4gIAlbQ0hJUF9W
QU5HT0dIXSA9IHsmdmFuZ29naF9kZXZpY2VfaW5mbywgTlVMTH0sCj4gIAlbQ0hJUF9ESU1HUkVZ
X0NBVkVGSVNIXSA9IHsmZGltZ3JleV9jYXZlZmlzaF9kZXZpY2VfaW5mbywgJmRpbWdyZXlfY2F2
ZWZpc2hfZGV2aWNlX2luZm99LAo+IEBAIC02NzQsNyArNjkyLDcgQEAgc3RydWN0IGtmZF9kZXYg
KmtnZDJrZmRfcHJvYmUoc3RydWN0IGtnZF9kZXYgKmtnZCwKPiAgCj4gIHN0YXRpYyB2b2lkIGtm
ZF9jd3NyX2luaXQoc3RydWN0IGtmZF9kZXYgKmtmZCkKPiAgewo+IC0JaWYgKGN3c3JfZW5hYmxl
ICYmIGtmZC0+ZGV2aWNlX2luZm8tPnN1cHBvcnRzX2N3c3IpIHsKPiArCWlmICgoY3dzcl9lbmFi
bGUgJiYga2ZkLT5kZXZpY2VfaW5mby0+c3VwcG9ydHNfY3dzcikgfHwgY3dzcl9lbmFibGUgPT0g
Mikgewo+ICAJCWlmIChrZmQtPmRldmljZV9pbmZvLT5hc2ljX2ZhbWlseSA8IENISVBfVkVHQTEw
KSB7Cj4gIAkJCUJVSUxEX0JVR19PTihzaXplb2YoY3dzcl90cmFwX2dmeDhfaGV4KSA+IFBBR0Vf
U0laRSk7Cj4gIAkJCWtmZC0+Y3dzcl9pc2EgPSBjd3NyX3RyYXBfZ2Z4OF9oZXg7Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
