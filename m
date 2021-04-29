Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7238C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 14:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E09361447
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 14:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E09361447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D7E6EEB6;
	Thu, 29 Apr 2021 14:49:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E109F6EEB8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 14:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEk9nUUrefpSO9Oa+2inBCri3qyFxQRsWyyRRC+qYNXVeMI3Oy1YdG2dG61gPT+OHFOhX/ZWBZGgjVa71hmeS+34poJqIxAW7yF+RxN0+92sTAJDUrkcF0azubr4hSPxGW+GDUz18XIYQWMT0ZGwHXu7pdSjUI+ylEhQSRvTGXfN33D4/SgF7hoDhOX3DvC8BC5tTit/Cc+vdj9cQ+TqJtyDgqh6+0tMn/IiO+gQ1VMPAWfeI5BOXcmQLK8v4TUzzM4JTv/cWWXWUhjflkF4c4J595UvS/e+vvWyivjyJEysx2BUTtWTQEQer9jzJKvwXdEmczl0VuhutG6vTOghrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LtOn9hM2YMSgJ88Y38PhfZ1CK85/lSz+77LGgW5UNo=;
 b=h7IQDy86W0BlIPaZzPC04WTMnulRMmN/IieFO5uQs+OrGmEFxwR00dxp4OHeAJL6JD9Ot39QUaF67ull6rxZtXjXu9ZrXrcjFNeuhskXLX58ODl3dyPOwf9F24DyHI0RwS4x5Te006MnpNlm38a6iUXOiiVQjfPZS4vCZun3XfYfaNefBnC+9Ea/vaHoLw6CVmQOBWk5JzzpEt7N5FeNwdwZk0o/SIqB74HQs/q6ki0fm1XxjNUwpwHwSv8AP2ACtFQgY48CBinb1owz5dxmQzjko7L51qzloyBZv5zZlPZF5jMkEg6pjqRnWz6xV7ZMBo5S/kgqlvd4YAIe4krMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LtOn9hM2YMSgJ88Y38PhfZ1CK85/lSz+77LGgW5UNo=;
 b=4b+irfMbLUr2XVADV9A4P2cTlB3xMQQELGEI06qt75LBYYjjMHJav3D/cgyDWXFS+e8ZD5JBGHJx4/gdta8Us4dBMbzbc3NnEiPxAajP1jTKcYF8zywxfSZrYPTUULtFvQGWdpQ39FDp8w7um4FVppNfjiYAaFL2vipiXLxe7y0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 14:48:55 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 14:48:55 +0000
Subject: Re: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210429093609.71616-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1b6ed66a-72e5-50f7-f9b9-020da1d980cd@amd.com>
Date: Thu, 29 Apr 2021 10:48:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429093609.71616-1-jonathan.kim@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::11) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 14:48:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1695ef9-5765-4de3-a74d-08d90b1de9a9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44387C6CC1ADDA6BD11628BC925F9@MN2PR12MB4438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmNZTPVGU29m1b94KENe9timUNlmc4R87AfUKyls2VzILhzZByATgwemGBZrEjNBicW1pvKzc6RdGNuaQatJgppQGWrC+aCBuvxdL1oBDk5sB/Um9enwufrreF4tbnw3+QF3lTwxuCXKxz0mrb62QCVATuPDi5hWSbPMfevivD0O6iiVC6GP839koRaR5s9NucCzQYNcGpT9PTy/xad9w3+CjnauvI1XlHPMIAnNvHKe3j9JHorqqrYaYlltcyrPPt+7ehrsbZ12HAM4h6f4C/DT8oTS2w+Mn5fdJYR+2UZOW/cPmiAklxY0dubAEOcAFXyaKM9zuGVA7x2+ERIPmZ8TBun0S/4/my6a+vTKqZfjNwxgF52ElEmG5RE6dBFGIn1iQeNUSOa+JVDisPQYx9yGVhdiM+tIC9j2CnvK++QwNEAQWEnBahd1cxzjIFaDCJBrOoLiw3GluUXUONkObdMixWC9hPwI3JuDR5EsBnCnRrwORGUDBK7JgNqf0+vfvdKuMACAykrWmcSL+cLxJF2CFfb4Cp0EKDUZg5VizNuGvXE+zeo4zdrR3LSBZFJQWzH93VvbuyBxTyhEdPSf2qnZ5MxlD9N0MQM1bCUsVWU75yPoUBQjylXXxykh05Hs4enJP3A6+SYLzfxIjUsQHUiMZtMiB2iEd2uBw/27Og5c48L3bC4InjJBGaY4tprC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(6486002)(956004)(2616005)(36756003)(44832011)(6666004)(5660300002)(38100700002)(4326008)(478600001)(186003)(16526019)(86362001)(16576012)(26005)(31686004)(66476007)(8936002)(66556008)(66946007)(2906002)(316002)(31696002)(8676002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V2xpSHlZa0thcnA4ajhDYjBOYlVERXpYRDdQdHMwcFpmM1RhcmZIVzVLa3Uz?=
 =?utf-8?B?aG85RDJjTWxuYTRzUE9GYXFtbyt0SUV6MXlKbENIODV0S0EvYVZZS3JvM3J6?=
 =?utf-8?B?OUdLQ25yQTdLd2ZSQ1M1ZUtTSUVEeFZEVElNTTNsTjk2Y2dZbTYyODFuRy9t?=
 =?utf-8?B?VTAvQkxaS3dCR0txN1B1aEkza3ZUaWptVStBNGhDVUtPbTZ5RlA3QTByZXJt?=
 =?utf-8?B?VGNmd1pkWS9YWEp1NUt6dUh5WDZjL09OY2pINGhiajdyYlBHUHpxcU5FZG5o?=
 =?utf-8?B?SitzaDBDbzFiR3FKNnRuY1pscGJoeTBIa3k0UW5GOTVNNnQrVEZOWG5LZHJy?=
 =?utf-8?B?Y25ZVVJPMHdZVFRpSExCazRvZ1RydkVlRStTR3pzMzIrZnJ1d0VqZmVPY0NK?=
 =?utf-8?B?SDNyQVBDUmR6ZXExeThqL2FXYWlRb0dGaU5WVzhLWFJvVWhsNzN3SjhvcU9h?=
 =?utf-8?B?d21sNjcvT3VIbEhueWkvb1dZQUgvbThrcFptZDdQcVpKeTBKdVp3UDJ1US9Y?=
 =?utf-8?B?STBsUnZVbEtlUjlhRmJMcGZWVmhFUDNvakJXZVZ6RlVpYUZoYVdkcGwyZEhq?=
 =?utf-8?B?V1I0WFdxOVdSSlVxVElNUkQ1dmVJWVI4TlZ1eEZjR0ZWYnlVTy9wZlR4aWZ6?=
 =?utf-8?B?dVZXVjk2Wkh1ZlRQMnRGK1Uwa3RnWjByK1FCYnc0eWR6bU93SDZlMG5XTEdn?=
 =?utf-8?B?Z25UbFcxOU1ibUVMYVBNNXVPV0JRVzZRb0VkQ3BrS2FxR2pUcFlHV0EvQmNx?=
 =?utf-8?B?dGd6TFdGT3ZaYk9saFF4M2tPRDRFNXNXSVM3Si9qaG44eS9NdUxTRWppcUtN?=
 =?utf-8?B?TnovY3dtSmtaVThXTk40UitIYW43c0UvWGYwVjNzVlB2SUMzNFJPdDZBajdB?=
 =?utf-8?B?RWM1ZTFKR1cxVmRSNnZVQUZDRVNSNGZ6UXB0VVpjNnVxT2MvRzhuT3pLVHJ4?=
 =?utf-8?B?WWJQVDI1UDU5SGEyZXVLQnVEZ1RybEtVWEpad1lGcjlCZjgxSkpwNzBlQUZM?=
 =?utf-8?B?YlV2UHFkZ1J2UG9wNEZKeHhJbHdUbHFLSXhiS05kMEFGUnlENllBcGgyODlJ?=
 =?utf-8?B?NmcyN1hmUEVRa0pnK3g4QS9RMS8wT1ViTlQ5aHAxTWxGNk9nMDNsOXBOTU0z?=
 =?utf-8?B?TzE0N2o5SjJHeERIN1VVM3M1VjB1QTVzZjBVdjB0NXlacUJLT3dUVExCRTZu?=
 =?utf-8?B?a0JEUEFrRG51VFlhYitqYndjRDdVNkRMUFBVcnoxS3U2OE1FK1lESHFUeGtQ?=
 =?utf-8?B?Q1NaU3VnblRqSE5zd0NlRGZSMUNxZlFwbHE4djY1Ukk2cVFVZFkyUzhHZ3Fh?=
 =?utf-8?B?YlRoL2dPcTZUa3dJN1ZZcGFnL2NTWXNjZVN5WmdLZm1hNmlBcnlYaG5DazV4?=
 =?utf-8?B?Q2RwdHVEU0U5alNpODlUWXd6OEQwVlFyM05MSlVDVmZ6aVRSS3BEbEx4V2xU?=
 =?utf-8?B?YXloZm1pWldDc2NaOXVPVkJDU21TYXhTWExnTGtlSHJpS0FjdTE0YkY4OWUz?=
 =?utf-8?B?K2pQa0lUWGFjdEIybjMxY3VPRHpKdWhMZjB0T0F5dE1lSGJwU0dycU9RcGMr?=
 =?utf-8?B?RnQrK0xYNXJBZHVJVjJkTkZUVG0zTm5Vb1Q1ck45YlBNYTRFOVNWQWFSV1dS?=
 =?utf-8?B?cGNLWlM2a3FwNy9HMWREdlowaGJOTGgzQnJoL3F2UW5jUDc3d2o1ZzdWbXZU?=
 =?utf-8?B?K1g2Y2hNd0hQNHRmMlZVRzFjZWt6M25GTHlFc3FFNmMveVh5WjQ4MmZIVUpt?=
 =?utf-8?Q?6/eZonRM9b+9UZyIR6ln+//gQy+dNq/EPgzJCTm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1695ef9-5765-4de3-a74d-08d90b1de9a9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:48:55.2997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1BUL21lJ/8UEHUyXgv1tb4WbGzqFhnCHRi2r7KqFAdvEM+Zxuw3rhVe6IXEZRPbr9A8snJU7SsbdeGAvh1E4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438
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
Cc: Oak.Zeng@amd.com, Ramesh.Errabolu@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNC0yOSB1bSA1OjM2IGEubS4gc2NocmllYiBKb25hdGhhbiBLaW06Cj4gTGluayBh
dG9taWNzIHN1cHBvcnQgb3ZlciB4R01JIHNob3VsZCBiZSByZXBvcnRlZCBpbmRlcGVuZGVudGx5
IG9mIFBDSWUuCgpJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBjaGFuZ2UuIEkgZG9uJ3Qgc2VlIGFu
eSBjb2RlIHRoYXQgZ2V0cyBleGVjdXRlZAppZiAoYWRldi0+Z21jLnhnbWkuY29ubmVjdGVkX3Rv
X2NwdSkuIFdoZXJlIGlzIHRoZSBjb2RlIHRoYXQgcmVwb3J0cwphdG9taWNzIHN1cHBvcnQgZm9y
IHRoaXMgY2FzZT8KCkFsc28sIHRoZSBQQ0llIGNvZGUgZG9lc24ndCBjbGVhciBhbnkgYXRvbWlj
IGZsYWdzLiBJdCBvbmx5IHNldHMgZmxhZ3MKdGhhdCB3b3VsZCBiZSBzZXQgZm9yIFhHTUkgYW55
d2F5LiBTbyBJIGRvbid0IHNlZSB3aHkgeW91IG5lZWQgdG8gbWFrZQp0aGF0IGNvZGUgY29uZGl0
aW9uYWwuCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBL
aW0gPGpvbmF0aGFuLmtpbUBhbWQuY29tPgo+IFRlc3RlZC1ieTogUmFtZXNoIEVycmFib2x1IDxy
YW1lc2guZXJyYWJvbHVAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3RvcG9sb2d5LmMgfCAyOSArKysrKysrKysrKysrKy0tLS0tLS0tLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYwo+IGluZGV4IDA4M2FjOWJhYmZhOC4uMzA0
MzBhZWZjZmM3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90
b3BvbG9neS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5
LmMKPiBAQCAtMTE5Niw2ICsxMTk2LDcgQEAgc3RhdGljIHZvaWQga2ZkX2ZpbGxfaW9saW5rX25v
bl9jcmF0X2luZm8oc3RydWN0IGtmZF90b3BvbG9neV9kZXZpY2UgKmRldikKPiAgewo+ICAJc3Ry
dWN0IGtmZF9pb2xpbmtfcHJvcGVydGllcyAqbGluaywgKmNwdV9saW5rOwo+ICAJc3RydWN0IGtm
ZF90b3BvbG9neV9kZXZpY2UgKmNwdV9kZXY7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
djsKPiAgCXVpbnQzMl90IGNhcDsKPiAgCXVpbnQzMl90IGNwdV9mbGFnID0gQ1JBVF9JT0xJTktf
RkxBR1NfRU5BQkxFRDsKPiAgCXVpbnQzMl90IGZsYWcgPSBDUkFUX0lPTElOS19GTEFHU19FTkFC
TEVEOwo+IEBAIC0xMjAzLDE4ICsxMjA0LDI0IEBAIHN0YXRpYyB2b2lkIGtmZF9maWxsX2lvbGlu
a19ub25fY3JhdF9pbmZvKHN0cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpkZXYpCj4gIAlpZiAo
IWRldiB8fCAhZGV2LT5ncHUpCj4gIAkJcmV0dXJuOwo+ICAKPiAtCXBjaWVfY2FwYWJpbGl0eV9y
ZWFkX2R3b3JkKGRldi0+Z3B1LT5wZGV2LAo+IC0JCQlQQ0lfRVhQX0RFVkNBUDIsICZjYXApOwo+
IC0KPiAtCWlmICghKGNhcCAmIChQQ0lfRVhQX0RFVkNBUDJfQVRPTUlDX0NPTVAzMiB8Cj4gLQkJ
ICAgICBQQ0lfRVhQX0RFVkNBUDJfQVRPTUlDX0NPTVA2NCkpKQo+IC0JCWNwdV9mbGFnIHw9IENS
QVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfMzJfQklUIHwKPiAtCQkJQ1JBVF9JT0xJTktfRkxB
R1NfTk9fQVRPTUlDU182NF9CSVQ7Cj4gKwlhZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICop
KGRldi0+Z3B1LT5rZ2QpOwo+ICsJaWYgKCFhZGV2LT5nbWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1
KSB7Cj4gKwkJcGNpZV9jYXBhYmlsaXR5X3JlYWRfZHdvcmQoZGV2LT5ncHUtPnBkZXYsCj4gKwkJ
CQlQQ0lfRVhQX0RFVkNBUDIsICZjYXApOwo+ICsKPiArCQlpZiAoIShjYXAgJiAoUENJX0VYUF9E
RVZDQVAyX0FUT01JQ19DT01QMzIgfAo+ICsJCQkgICAgIFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNf
Q09NUDY0KSkpCj4gKwkJCWNwdV9mbGFnIHw9IENSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1Nf
MzJfQklUIHwKPiArCQkJCUNSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfNjRfQklUOwo+ICsJ
fQo+ICAKPiAtCWlmICghZGV2LT5ncHUtPnBjaV9hdG9taWNfcmVxdWVzdGVkIHx8Cj4gLQkgICAg
ZGV2LT5ncHUtPmRldmljZV9pbmZvLT5hc2ljX2ZhbWlseSA9PSBDSElQX0hBV0FJSSkKPiAtCQlm
bGFnIHw9IENSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfMzJfQklUIHwKPiAtCQkJQ1JBVF9J
T0xJTktfRkxBR1NfTk9fQVRPTUlDU182NF9CSVQ7Cj4gKwlpZiAoIWFkZXYtPmdtYy54Z21pLm51
bV9waHlzaWNhbF9ub2Rlcykgewo+ICsJCWlmICghZGV2LT5ncHUtPnBjaV9hdG9taWNfcmVxdWVz
dGVkIHx8Cj4gKwkJCQlkZXYtPmdwdS0+ZGV2aWNlX2luZm8tPmFzaWNfZmFtaWx5ID09Cj4gKwkJ
CQkJCQlDSElQX0hBV0FJSSkKPiArCQkJZmxhZyB8PSBDUkFUX0lPTElOS19GTEFHU19OT19BVE9N
SUNTXzMyX0JJVCB8Cj4gKwkJCQlDUkFUX0lPTElOS19GTEFHU19OT19BVE9NSUNTXzY0X0JJVDsK
PiArCX0KPiAgCj4gIAkvKiBHUFUgb25seSBjcmVhdGVzIGRpcmVjdCBsaW5rcyBzbyBhcHBseSBm
bGFncyBzZXR0aW5nIHRvIGFsbCAqLwo+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeShsaW5rLCAmZGV2
LT5pb19saW5rX3Byb3BzLCBsaXN0KSB7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
