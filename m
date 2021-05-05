Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D36DC433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 20:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5A5613AA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 20:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5A5613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F8C6E50E;
	Wed,  5 May 2021 20:10:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D439B6E50E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 20:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgDJa+mU6EOEMnZ9eqK86mbD3sUYChDXEwiTO0BQiu+ZIN03JDvAffGNPVxhFDkwpoa/N42mIMCBeB5DEB0WeKOrrwTyc4bqDc8zbyjoTgToqL8eR9HGHTaFSwVJynHksw85IfM2zoHhxwaoif+hGQ3Qo/hjPcpG1uc/+skL6d/MkuP/slpVRc2j4Z0fbBvPsh1yhfjINGSSUh+FVqx9dPqBqv1nX2b6EZwVYA/O4nu37ieH4HNAcwuovReV3yx2NhCcSRQvhb4q/Iu1xhicPMhkYm8wEJUyGUaxrNNKAbdHKXPN1CRocEwbp6Zolq+EiJTJJAJ4YQX9L9AYBFRMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhXXrO/0QSZu9KLLc+jMvVk4usbgk2AAJz5FC87RtG0=;
 b=AAZmzkPS2NbCxz0f3tmcPB+X1GlCFejhZO+O6xYBAgcHOPDBqO+VExQzCssdXTMFGT5LbTihLowBQndf37EObOvOBaNdOTaPfL9d2U1M3tZJQXzo+WTDxuq7kVmCzpJdrEqlTzx089TOj0Rw0KEI06f+lOArossY4heToOiRuMGya9ME1G3nJTktDDB31g9KOn9PT37V4012jkBEKywoly0enzK3Cb9u3A0MoLIi5AItqSyiLjwExHvaFstnTEGctuB017IX3LKDAxHYRFauH0mZCO9UuAswPrf+MssNVZbNMDkvowpxaZOnh+zLk5v7U2t4w/qciKKrMgQ0cH2S4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhXXrO/0QSZu9KLLc+jMvVk4usbgk2AAJz5FC87RtG0=;
 b=WQWAS10eGLduEa1l6+6wBcCnbv5OPOXxgAZguE97S1yejoq+j7tN3VFNOZRVqpMf7HYANIP164ig5RVwSM7iQMpt2lT/EUYeOZ+1IL0lJu+Yj0Oo8Mn4awp1F7KaP7toPaQhrpTlHMmdD2RUOqBSX2gw7ftdUatdjTSwpePMgJ8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5276.namprd12.prod.outlook.com (2603:10b6:408:101::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Wed, 5 May
 2021 20:10:22 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4087.039; Wed, 5 May 2021
 20:10:22 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: set prefetch GPU has access attribute
From: Felix Kuehling <felix.kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210505175617.30404-1-Philip.Yang@amd.com>
 <2d145a22-a185-22d2-7ab2-a3ae06ccc97f@amd.com>
Message-ID: <d33edc62-a87b-7386-378d-45e47f546650@amd.com>
Date: Wed, 5 May 2021 16:10:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <2d145a22-a185-22d2-7ab2-a3ae06ccc97f@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT1PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::28) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT1PR01CA0089.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Wed, 5 May 2021 20:10:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd3502fd-178b-4624-5af3-08d91001cfdc
X-MS-TrafficTypeDiagnostic: BN9PR12MB5276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5276992D1E2CE01349B2AE5192599@BN9PR12MB5276.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9TClJU0WidYH9EhkWKLmCLwq+2KrDXGgX8fCnlG9Z/Ovurrp6AnRg4kksW87jhXxOLEro7Uc8p2PL8G4N3R1A4zD5qIk21X1ORD3BNww76d/Yqm+Ecqmdr5SOp2gU4Dru6NKaioB1fgmHH1sjxk+TOHHYf+IrXzJCpIH+udEKwYyTk9gLLm5rghOdVEurNrjoUxg3owq2SJiERkisnVOcnX/o76+ToPx3Rplz3Jfi9KtCC8o6lynSwJ43f+axwHm4wa4zCD+5MLKdSe7qSnQHRctAoBoSgPOjmrmaZXSwwP3rRf1YcqI2OSrjVfsnQljCEi8iuySI7OHVMbb9fTlnJBVTsk4B1ujXfi5IMV8yHwsKDby7N0H6z2/0fSPvY+659LfX2V7mWvWl96oaV79HDb2CRvS6pw/Oak3gwAgYk749riX5hUwTQ9jw2vK03apmO8m45ggDl96jS5Uh/X7qLcJBPiQBRta3zeNVD9UBMeUWkEkj9rE4uNVy37rkKOsfKF41mXKQ0Siarg8DBbnsUBcZBoB7aBwu3LYxckMwEf/f2/Fra1I8hYpso/u1+wajoPuwn+RbfFBLIgB0Op51+dP1uBDAGHVGxmfmGNgpQ8/JD0mmkZgRvTh+BWhxGjmm4SpAY88N333Ln+VIs61QI2AcmP2HlLZdgJl0u6BLJz6pEkw7H3tJ8Dsvn2/V8ZWMK+108tIZxpZXQrnT2O1VxcvJg1Nse5kfhujTejG0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(2616005)(86362001)(83380400001)(6636002)(956004)(26005)(38100700002)(2906002)(316002)(8936002)(66946007)(478600001)(16576012)(31686004)(16526019)(31696002)(966005)(186003)(66476007)(37006003)(66556008)(36756003)(44832011)(5660300002)(6486002)(8676002)(6862004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UUozS2JRdEZYN3lQWmVkWndBYWtMUDBpa2FFTTdKaDRBTXZQQkFRc1FXUGVk?=
 =?utf-8?B?V0dPeENONmVETzFwSjlCWDFDOVpYa1lNdERUeUhpSXRzTnZyb0NUdmxQUWFk?=
 =?utf-8?B?RVczSXh4bjdiN0tGNjNSVThUcFZmMnFvTEcyMG5pN0U5aFREdjgzWVJRTFVq?=
 =?utf-8?B?bnhoTmtsRiszb0FNRUhDSE8yRktQckFYODh2VGZqTXc5OHl4UVJUN0hXc3No?=
 =?utf-8?B?NzJTYzBreW1rMElLMFFXck9QdCt5N1VNYWZQajcraWVoK1JQczZHK2ZXd3VW?=
 =?utf-8?B?UlZ0d2dJemtrc0h3MFp6OGhDVFRUeUNYem5saXNLSk00R25TL2hzaTJBZ2ls?=
 =?utf-8?B?allpbFZSWlpFZ2FoTmE4Y2IyU3ZyTHlyNEZQT2o1MHZBVGlwWGdLS2NtcEJp?=
 =?utf-8?B?M0VnUkJaV1kvREx0Vjk5dXlQNjFBbmFic1BHbEEvVyt2bWo2cjFSOS9ZWjJt?=
 =?utf-8?B?WUJ0WUdaRTgvNE5DRXJYWS9pZ0tVTnRER1Q0WkEwNDFIRHpXc0tmMnNia0Q2?=
 =?utf-8?B?MW45MGFzbUdGR2s1VTN4ajhtZXF4RjM2M3N3bUI4ZC9pMEpjQllUK0JyRHhj?=
 =?utf-8?B?MXkxNjRXZXB3R0JOZ0g1Q0J0ejJlSXN2d0o2NDV4TmtZSDJHbS8wTFFLdTN1?=
 =?utf-8?B?Z2hLQnlHQzZGeHRPb3l3OXpMbjlPUFI5Y3FxWFB2aE1qQm9CUXpVV0xzQ2xr?=
 =?utf-8?B?c0dqc3R6STVCRWdOUEY1Z29LbGpTbHVXVHo2dnVNUDUrQkpiRy95RDIvOEwv?=
 =?utf-8?B?VkNNT1NHRTc3QzA0b3U2aU9aTzEzR21QeE51ZVAyRG01RnpOVEJINGM5dHl1?=
 =?utf-8?B?OURNRDZVOHdjSWk3R09kQW1tNVhDUEJLclRudmZNUis2aTByY0lVNDliWXBz?=
 =?utf-8?B?dnVHYkJnTnIwOHN3TFRObzVQdmdwZkJCMDJQWTlJZURDR0RmcG55ZUErUHhH?=
 =?utf-8?B?QWxUMXcrZmVCaWhlejZGcDE4UWpUVU1TMy92c3JYWWpRWmYydTdHcDNCU1Rz?=
 =?utf-8?B?N2gxUEUzQ0RmMTFrc3dwdXhVcjRMeUNQMUlUUC9SU05WVGxBWldkbXBXdXdh?=
 =?utf-8?B?MWs1MXM4djlicVZyYnNYM016dWgyTHh2MkMycnJoOWVBTTY5d0JjMFQ0Wnpi?=
 =?utf-8?B?cXZnaXk5VjgyRzRHSVBhSkpZNzIwWHJuMStIYkFiTHoxdTlrN2JkVU9GWWlZ?=
 =?utf-8?B?aEpwWFdIZmNWeDcxR1JqeXpwb2c0SjJCZ016cjlnNEtQZmVhRk9VbHZKMEhQ?=
 =?utf-8?B?SGN4OTNPWHEyNnRFYXYvWHBqcFFnNE9LRzlza3hsUFUvLzhOWGY4UVZFTDE5?=
 =?utf-8?B?L1l0NXNzVit0QlNycGtkRVJKd0dMZWw3R05DQ1Jxc29pYVpMMDF3djNMNldO?=
 =?utf-8?B?bjlaMG1YTHd0MEZBNjN1dEhZZmY3Mk01TUpVQmF2eE1BVWU4ZERGcU1aVXNO?=
 =?utf-8?B?OUQvTG5VTzB3YjV0TU1qcWNaSlFCYjJJbTdLdlRnWm9UZFlpOWlaK1JnQ3FY?=
 =?utf-8?B?bmhlOHFYTzlGcVFLa044NzdKYlgzWEYvZ0pEUmFCb3huNm83QUdWdFlTekUx?=
 =?utf-8?B?c1JLOFc2SlU5cCszZ2dZSVpzRTg5SlZ1Nmx4cS9oZ0JrWTNWaUZhVkVoUnZq?=
 =?utf-8?B?d3VDVU9NWnhyWnZwWnk2UTVHQ2NzbWF4YTVkWlpkTG5nVk1ENmFnT3grS3NP?=
 =?utf-8?B?akZNVHByYUJEWUxGVThQcXFEVlZhak85eEtZU29wZUsrSVA4WXFrTUE0SWV5?=
 =?utf-8?B?TjBSM2ZVMC9XSnJFTEN0bG12VlZPZmM3T25pNFJHYkNQZi9PTXNXVEFxMnc3?=
 =?utf-8?B?SUNpSXgybERoVjJuSk51UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3502fd-178b-4624-5af3-08d91001cfdc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 20:10:21.9177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRZkdQSKXPuj0lCc/x7jNhoHAkkEgROrRLP3bihm9kixiUIlvo0+kAlBsjM+45OZAXdIXP/KLKTqNPOTRH0lzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5276
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

CkFtIDIwMjEtMDUtMDUgdW0gNDowMSBwLm0uIHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4gQW0g
MjAyMS0wNS0wNSB1bSAxOjU2IHAubS4gc2NocmllYiBQaGlsaXAgWWFuZzoKPj4gQWZ0ZXIgc3Zt
IHJhbmdlIHByZWZldGNoIGFuZCBtaWdyYXRlIHRvIEdQVSwgaWYgR1BVIGhhcyBubyBhY2Nlc3Mg
b3IKPj4gYWNjZXNzIGluIHBsYWNlIGF0dHJpYnV0ZSwgYWRkIEdQVSB0byByYW5nZSBhY2Nlc3Nf
Yml0bWFwIHRvIGJlIGFibGUgdG8KPj4gdXBkYXRlIEdQVSBwYWdlIHRhYmxlLgo+IEkgZG9uJ3Qg
dGhpbmsgd2Ugc2hvdWxkIGNoYW5nZSB0aGUgYml0bWFwX2FjY2VzcywgYmVjYXVzZSB0aGlzIGlz
Cj4gcGVyc2lzdGVudCBhbmQgY2FuIGJlIHF1ZXJpZWQgYnkgdXNlciBtb2RlLiBDaGFuZ2luZyB0
aGlzIHdvdWxkIG5vdCBiZQo+IGV4cGVjdGVkIGJ5IHRoZSBhcHBsaWNhdGlvbi4gSSB0aGluayBp
bnN0ZWFkIHdlIHNob3VsZCBlaXRoZXIgcGFzcyB0aGUKPiBwcmVmZXRjaCBsb2NhdGlvbiB0byB0
aGUgZ3B1aWR4IHBhcmFtZXRlciBvZiB2YWxpZGF0ZV9hbmRfbWFwICh3ZSBzaG91bGQKPiBvbmx5
IGRvIHRoYXQgaXMgeG5hY2sgaXMgZW5hYmxlZCksIG9yIGNoYW5nZSB0aGUgbG9naWMgaW4KPiB2
YWxpZGF0ZV9hbmRfbWFwIHRvIGFkZCB0aGUgcHJlZmV0Y2ggbG9jYXRpb24gdG8gdGhlIGJpdG1h
cC4KCkFjdHVhbGx5LCBJIGRvbid0IHRoaW5rIHdlIG5lZWQgYW55IHNwZWNpYWwgcnVsZXMgaGVy
ZS4gSWYgdGhlIG1lbW9yeSBpcwpub3QgYWNjZXNzaWJsZSBieSB0aGUgcHJlZmV0Y2ggR1BVLCB0
aGUgbWVtb3J5IHNob3VsZCBub3QgZ2V0IG1hcHBlZC4gSXQKZG9lc24ndCBzb3VuZCBsaWtlIGEg
dmVyeSB1c2VmdWwgdGhpbmcgdG8gZG8sIGJ1dCB0aGF0J3MgaG93IHRoZSBBUEkgaXMKZGVmaW5l
ZC4KCk1lbW9yeSBzaG91bGQgZ2V0IG1hcHBlZCB0byB0aGUgbG9jYWwgR1BVIChpZiBpdCBoYXMg
YWNjZXNzKSBhbmQgdG8gYW55Cm90aGVyIEdQVXMgdGhhdCBoYXZlIGFjY2Vzcy1pbi1wbGFjZS4K
CklmIHlvdSdyZSB3b3JraW5nIGFyb3VuZCBhIHByb2JsZW0gb2YgYSByYW5nZSBub3QgYmVpbmcg
YWNjZXNzaWJsZSBhZnRlcgppdCB3YXMgY3JlYXRlZCBpbiBhIHBhZ2UgZmF1bHQsIHRoZW4gdGhp
cyBuZWVkcyB0byBiZSBmaXhlZCBlbHNld2hlcmUuCldpdGggWE5BQ0sgZW5hYmxlZCwgYWxsIEdQ
VXMgc2hvdWxkIGhhdmUgYWNjZXNzIHRvIGFsbCBtZW1vcnkgYnkKZGVmYXVsdC4gSWYgdGhlIGJp
dG1hcF9hY2Nlc3MgaXMgbm90IHNldCBvbiBhIG5ldyByYW5nZSBjcmVhdGVkIGluIGEKcGFnZSBm
YXVsdCwgdGhpcyBpcyBhIGJ1ZyBpbiBob3cgd2UgY3JlYXRlZCB0aGF0IHJhbmdlLgoKUmVnYXJk
cywKwqAgRmVsaXgKCgo+Cj4gSSB0aGluayB0byBtYWtlIHRoaXMgcmVsaWFibGUgd2UnbGwgbmVl
ZCB0byBhZGQgbW9yZSBzYW5pdHkgY2hlY2tzIHRvCj4gcHJlZmV0Y2ggdG8gbWFrZSBzdXJlIHRo
ZSBwcmVmZXRjaCBsb2NhdGlvbiBpcyBjb21wYXRpYmxlIHdpdGggYWxsIEdQVXMKPiB0aGF0IGhh
dmUgYWNjZXNzX2luX3BsYWNlLiBPdGhlcndpc2Ugd2UgaGF2ZSB0byByZWplY3QgdGhlIHByZWZl
dGNoLgo+Cj4gUmVnYXJkcywKPiDCoCBGZWxpeAo+Cj4KPj4gU2lnbmVkLW9mZi1ieTogUGhpbGlw
IFlhbmcgPFBoaWxpcC5ZYW5nQGFtZC5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3N2bS5jIHwgMTEgKysrKysrKysrKysKPj4gIDEgZmlsZSBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfc3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPj4g
aW5kZXggZDkxMTFmZWE3MjRiLi4zYjY0MDc3MmQ5YzUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfc3ZtLmMKPj4gQEAgLTI4NjksNiArMjg2OSwxNyBAQCBzdm1fcmFuZ2Vfc2V0
X2F0dHIoc3RydWN0IGtmZF9wcm9jZXNzICpwLCB1aW50NjRfdCBzdGFydCwgdWludDY0X3Qgc2l6
ZSwKPj4gIAkJCWNvbnRpbnVlOwo+PiAgCQl9Cj4+ICAKPj4gKwkJaWYgKG1pZ3JhdGVkICYmIHBy
YW5nZS0+cHJlZmV0Y2hfbG9jKSB7Cj4+ICsJCQlpbnQgZ3B1aWR4Owo+PiArCj4+ICsJCQlncHVp
ZHggPSBrZmRfcHJvY2Vzc19ncHVpZHhfZnJvbV9ncHVpZChwLAo+PiArCQkJCQkJCXByYW5nZS0+
cHJlZmV0Y2hfbG9jKTsKPj4gKwkJCWlmIChncHVpZHggPj0gMCAmJgo+PiArCQkJICAgICF0ZXN0
X2JpdChncHVpZHgsIHByYW5nZS0+Yml0bWFwX2FjY2VzcykgJiYKPj4gKwkJCSAgICAhdGVzdF9i
aXQoZ3B1aWR4LCBwcmFuZ2UtPmJpdG1hcF9haXApKQo+PiArCQkJCWJpdG1hcF9zZXQocHJhbmdl
LT5iaXRtYXBfYWNjZXNzLCBncHVpZHgsIDEpOwo+PiArCQl9Cj4+ICsKPj4gIAkJciA9IHN2bV9y
YW5nZV92YWxpZGF0ZV9hbmRfbWFwKG1tLCBwcmFuZ2UsIE1BWF9HUFVfSU5TVEFOQ0UsCj4+ICAJ
CQkJCSAgICAgICB0cnVlLCB0cnVlKTsKPj4gIAkJaWYgKHIpCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
