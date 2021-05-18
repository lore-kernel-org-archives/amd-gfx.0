Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DC9C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C6E60725
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C6E60725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97376EC09;
	Tue, 18 May 2021 15:59:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57A056EC09
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 15:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebOJF+8rKT0WZBq7NH5LFs7sghMW6TyDR33O9zf4caVb5Pojamdoh+25t7XlsQAmxHjmjQ3EbVsIeJ+q61kiDxGze1c2lFhsqovfBe+bui0GhyYWA5ximQLKxAg8OnTquN6diFcItfFB7Ox9Ux9EniumEC9MIZfoiy2X62F9tceYEFeHDk77sVv88xA2ka1X2PyDU2iJuydE9/rg1eQhB+Lcd9AukTi2dwlg62SuXqb9LWPVrBfLqdxPu2soJMkC9+HWkBbtWQDbuJfmBIkPSYR6eFFYsGdaEzolF6hxGrxZ+537WtB17DI1UDQA9zQHKVlwlW5oVdGOk0C8njhNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2gKdIwL7MRV8vihsPB4+Mdv5kND91AQdYR32radif4=;
 b=WZDNr6u6XSez02m6afqLFF6LULP8JRoIbaADth6kSzKPZV9o6NfL7abDJO6JALSdSBN+8rlQ/G6Y7rN0VGWOX52xDhpBWEPARdyAQwVKfSwbYLXHUIeZZUbuX9IU1yIE3OfkMgKxTlF6nX2OMBLxOKCJl0EflXE+4NEcYdybec2/zldnb85fT7bDbPsvxzUmAKSNpUq8TBNn+Bo1HcmRWm2Tm2OOIQU0MHEIrY6XHAgLgDqRk4XwX9S+EfGlB2R0rvhj3waEZZMnwLDBah+HgcHdmcqVnFnrhiR7oPcIsS+2ESHVr/uphk+wlzAjyeT3oFSTb+N2GZo7uN3MzG61nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2gKdIwL7MRV8vihsPB4+Mdv5kND91AQdYR32radif4=;
 b=KFmXUH1YikHmqra7bjJpsJjPQtsAiGjKh3qJc5pM6LUJoxCniMoARNEWHqMpPVzKICmBIU1I967/Pjky+RlRa1k7OXiSoanhP1eVUC9HT05w9oZudTAZEF0ILjre12yLBDLBgdKGmxq+8mD7E/HbNcacSLevj9x+/iz3Kp55eIg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Tue, 18 May 2021 15:59:22 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 15:59:22 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn1: add cancel_delayed_work_sync before
 power gate
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1621350686-25923-1-git-send-email-James.Zhu@amd.com>
 <352509e8-a836-f803-fbda-e31e0283dc41@gmail.com>
 <af3751e7-c65b-b1d2-ac84-d88509ad9e31@amd.com>
 <bc35c564-0b25-3e9d-7bf7-04762405f640@gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <f2f9cd8e-2ed5-9b6f-6fd7-ee523c493061@amd.com>
Date: Tue, 18 May 2021 11:59:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <bc35c564-0b25-3e9d-7bf7-04762405f640@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::31) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Tue, 18 May 2021 15:59:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afd9c1f5-cfe0-456a-71c8-08d91a15e749
X-MS-TrafficTypeDiagnostic: DM6PR12MB4450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB445038675FC49BDEC9FDF322E42C9@DM6PR12MB4450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pud7yR0YfTKB4OMnODYsHRLbzNBPoq4qGPAIEn0Ut2DIMtvk5crcKhnvKtTFuZc9VVY9VTRvzhnQs+cVWlEiFOaw3CG8Q8Uv2v8C9CtL9sYbuQvw749WBayEwohjk2ANi+jS+HS8aqyyzGg+YiD3gqD7Wi/XjpBujHuxtS7ieuw4sQb8AlPrm6+099jUFxR+rp0ODS8L9II/aP7MsUqWLRcujn0fUwl++UkjBbvuryu4aYrSL1JirNaJyaCR4ucGaq6lMCnbvWAt3IEdLSdyUiS0eHUU3bk8IlBuuIxe90J2MNKQ+JNHJJAobJd9+InRaGO6FShC7icjtvIK3wjPRGrqwb8spfVAOFhZ17Gt/vbqzCj3uDPaGl5lDScml667SR5tPmBYPVTYuBhLIKjw0hZD4gk31L3bwvFWTp3+0kFx6xEL/vaMhEQ2fnz46AvuO1sfN80uYcxI/BLI76umr8mv+uHH/Woz9Lg5GPgGURFa6gTYzD2irBZS7DeLmTEkSTrS8wZ35mExstpQuD5QTJCrhx5suAkMPL5S3beMq2Y0+jC5cSEsSRGW7f38x5kue0SNoZBn9jsOpGcBZVr1gccPtKkxexvzpfYHtkc/NNBQ2T6ttOCYKIAZV+4hmEH2jGsLO7XSMcG5aFpc9cvuXeO+p5EK6RWsUqoeFeDKDPNazdtIi2AzZ8cUTa1AUgM3uc8hGp3cy5ZzfWP2aCPGWz+f+VyDoJBy2rYL5rtnc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(5660300002)(38350700002)(316002)(110136005)(26005)(38100700002)(16576012)(8936002)(8676002)(6486002)(478600001)(53546011)(2906002)(31686004)(66946007)(83380400001)(52116002)(186003)(66556008)(36756003)(2616005)(16526019)(66574015)(31696002)(66476007)(36916002)(956004)(3714002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OERsWmQ4QkI2N2NKUi9lK0J5TkZUN0JtVWdUckhPalNxR1ltWEMyR1N5bDN4?=
 =?utf-8?B?ckh3UFE0bnBZUkQ3c1RHSVBRcXp5cXZSU0czS0FPdUF3YUYwaGhVaGdkMnZJ?=
 =?utf-8?B?NFlNbnBRS0ptM3lPN2xwRkpYYnBMcGJyUTR1NzBIdlpON29CSVZXZUN1b01W?=
 =?utf-8?B?R3JkYjhZYVpnV3BBRmJUYTNabVovRWgxalg3MzVlREVZVlJFeVFLcklsVGE5?=
 =?utf-8?B?RFVWdGdaaGFzSitzUVJLT01DdUMycDhjUDUvZmRGVEQyd3E4dDkzTU5KeW5B?=
 =?utf-8?B?b3FWT2NERXFGNElMb1BZajVnUHE3MGNGS1ArNU8wclpKcTMvVTdLTXpvdFRh?=
 =?utf-8?B?Z3o5VnFYeFpEaHJ0NzVnY3VLdEM5UzM5K2wxYlBCTG02T2R3d28vUmpETGM0?=
 =?utf-8?B?bnVMc0ZYVGhtbDMvUFpFbW5VcmZCSWQ3VE9oakxIS0VNeGhhSUt6YXdHNTJT?=
 =?utf-8?B?M0JBSzNpRFNxYlJXaTRvTy95ekVXYm9wZlFaclR6d01ISnNpOVIvT2h6Nklq?=
 =?utf-8?B?ZHJTOSsrR1VUQ3cxZVZkQU8zOGVYSzVjaHV0ejhaaTlYUzJJRE1mSW94QlUw?=
 =?utf-8?B?WDJyZ1Z3UTJiWDRvdnJ1WTY2ak9qZXU5VXR2ZGJxbFNrMWlvK1lMVzVrSVUy?=
 =?utf-8?B?S1ZUZlNUdEIzRlF2THR2eEV3RFR2VmpyUXpGRGVOWEdFZnhLQ08zcTFWSFpB?=
 =?utf-8?B?enp5ZUcwYTBxbXdFNXNiRERtck8vRWFOaUZWM0lieHBPQkFOdlZuR3RtRzQy?=
 =?utf-8?B?a0cxZjdNOVVWWWhjZ1FhdlBHZVA3OG9WbTloVm1pTmRlMmVkaU95eWJwTVdT?=
 =?utf-8?B?N0xWRnVvaWl1RVNqaUVxK2F0eXBZaERqbmtVK0VPZzlsM05QU0N4aUxoOGlh?=
 =?utf-8?B?aVJHVlUwZ05MdXB3ZThWb2xjMnY0enhpS0ZNVmY3WWx4UUoyQnJ1UFhBY0Mv?=
 =?utf-8?B?YVIzWGFMTUVjQjhXZ0RxdE04TVdSTkRKTVo0d0RHbCtCdU1BeHpod2lzSjBX?=
 =?utf-8?B?YmkybkY5QTV4eklvbUZPUTdhZUdoTHdmOFp6OTlhb3FSd21QeXc4d0lqNWRZ?=
 =?utf-8?B?dmVOcWw3STZyOTNmTE1Xa1NnUHdHek8zWDR5d1lBN2ZMdWhQeWc1ZFpuQ2xN?=
 =?utf-8?B?MlUvZk5zRDRzL3hwYnM1K0tlcU1ZMHh6QnVua0JXVGxTKzFwYjlGYlNFTTZr?=
 =?utf-8?B?NjQ5WG43UDViT1J5U05OM2Zoc3ZuN21uNWpEU1F5RGlkN3B3ZUVYbXZKVnpM?=
 =?utf-8?B?bVZiOG5vckM3R0wwK2lVUHhCN3gzOC9pNTcrWng5YUk3Q0wyWTFYejFFQXBU?=
 =?utf-8?B?SGFxb05IRnROd3UxemlVblJ3cDBiQTk3OXJ6R3RDZVA2Y2wwR1VYOFJlWTB0?=
 =?utf-8?B?bUo0ZEtHTThURUIyOVRHSUFvRlg0T2xCUW03QnNXUWxsdTNvNmcydFFGSXA2?=
 =?utf-8?B?TDUrTzc2Y05hSGRsUEZVcnJWQnpmclB6UFhKU05Nc25sdU1iYkNWMTZ1V1Jh?=
 =?utf-8?B?dWhRZzhuT2V0ZlAxWVMrdE1IbFZJYXBNOEd3TXBLWWpUMXNJWFcvY0ZhMDRX?=
 =?utf-8?B?Rmw2RGg0M3pOa1VqMzVJWTUzUmV3S1Q5YmdyYzdnZXdkVDhuczJvYjNyRno0?=
 =?utf-8?B?UlFaS0tKK2xJWVhrV1dHTXRKT3AxYVA1U2pzOWVCckJPYnlMUWxKbWt0eFEz?=
 =?utf-8?B?ODcwYWFPbzRNTFJDbjZtc2xMdjFLdm9SdEVTK1o1c3FVQlkvT3kxSzNmT2Fi?=
 =?utf-8?Q?SfKMfDhlVEtLgaF1gY9zGQGnJW3kUbBui8cTR0F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd9c1f5-cfe0-456a-71c8-08d91a15e749
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 15:59:22.8130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvOeVAc7xueOl8SOR/4eB1mzF/bu3NOk20E0XOSjr6WLpdZM3/AFDpb7iJ+1883a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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

Ck9uIDIwMjEtMDUtMTggMTE6NTQgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPgo+Cj4g
QW0gMTguMDUuMjEgdW0gMTc6NDUgc2NocmllYiBKYW1lcyBaaHU6Cj4+Cj4+IE9uIDIwMjEtMDUt
MTggMTE6MjMgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDE4LjA1LjIxIHVt
IDE3OjExIHNjaHJpZWIgSmFtZXMgWmh1Ogo+Pj4+IEFkZCBjYW5jZWxfZGVsYXllZF93b3JrX3N5
bmMgYmVmb3JlIHNldCBwb3dlciBnYXRpbmcgc3RhdGUKPj4+PiB0byBhdm9pZCByYWNlIGNvbmRp
dGlvbiBpc3N1ZSB3aGVuIHBvd2VyIGdhdGluZy4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEph
bWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyB8IDE5ICsrKysrKysrKysrKysrKysrKy0KPj4+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMgCj4+
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCj4+Pj4gaW5kZXggMGMx
YmVlZi4uNmM1YzA4MyAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92Y25fdjFfMC5jCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Yx
XzAuYwo+Pj4+IEBAIC0yMzAsMTAgKzIzMCwyNyBAQCBzdGF0aWMgaW50IHZjbl92MV8wX2h3X2lu
aXQodm9pZCAqaGFuZGxlKQo+Pj4+IMKgIHN0YXRpYyBpbnQgdmNuX3YxXzBfaHdfZmluaSh2b2lk
ICpoYW5kbGUpCj4+Pj4gwqAgewo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7Cj4+Pj4gK8KgwqDCoCBzdHJ1
Y3QgYW1kZ3B1X3JpbmcgKnJpbmc7Cj4+Pj4gK8KgwqDCoCBpbnQgaTsKPj4+PiArCj4+Pj4gK8Kg
wqDCoCByaW5nID0gJmFkZXYtPnZjbi5pbnN0LT5yaW5nX2RlYzsKPj4+PiArwqDCoMKgIHJpbmct
PnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgZm9yIChpID0gMDsgaSA8
IGFkZXYtPnZjbi5udW1fZW5jX3JpbmdzOyArK2kpIHsKPj4+PiArwqDCoMKgwqDCoMKgwqAgcmlu
ZyA9ICZhZGV2LT52Y24uaW5zdC0+cmluZ19lbmNbaV07Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJp
bmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4+Pj4gK8KgwqDCoCB9Cj4+Pj4gKwo+Pj4+ICvCoMKg
wqAgcmluZyA9ICZhZGV2LT5qcGVnLmluc3QtPnJpbmdfZGVjOwo+Pj4+ICvCoMKgwqAgcmluZy0+
c2NoZWQucmVhZHkgPSBmYWxzZTsKPj4+Cj4+PiBUaGlua2luZyBtb3JlIGFib3V0IHRoYXQgdGhp
cyBpcyBhIHJlYWxseSBiaWcgTkFLLiBUaGUgc2NoZWR1bGVyIAo+Pj4gdGhyZWFkcyBtdXN0IHRv
IHN0YXkgcmVhZHkgZHVyaW5nIGEgcmVzZXQuCj4+Pgo+Pj4gVGhpcyBpcyBjb250cm9sbGVkIGJ5
IHRoZSB1cHBlciBsYXllciBhbmQgc2hvdWxkbid0IGJlIG1lc3NlZCB3aXRoIAo+Pj4gaW4gdGhl
IGhhcmR3YXJlIHNwZWNpZmljIGJhY2tlbmQgYXQgYWxsLgo+Pgo+Pj4gW0paXSBJIHBvcnRlZCB0
aGlzIGZyb20gY3VycmVudCB2Y24zIGh3X2ZpbmkuIEp1c3Qgd2FudCB0byBtYWtlIHN1cmUgCj4+
PiB0aGF0IG5vIG1vcmUgbmV3IGpvYnMgd2lsbCBiZSBzY2hlZHVsZWQgYWZ0ZXIgc3VzcGVuZCBw
cm9jZXNzIHN0YXJ0cy4KPj4gSXQgbWF5IGEgcmVkdW5kYW5jeSwgc2luY2Ugc2NoZWR1bGVyIG1h
eWJlIGFscmVhZHkgc3VzcGVuZC4gSSBjYW4gCj4+IHJlbW92ZSB0aG9zZSBpZiB5b3UgYXJlIHN1
cmUgbm8gc2lkZSBlZmZlY3QsCj4KPiBXZWxsLCB3ZSAqbXVzdCogcmVtb3ZlIHRob3NlLiBUaGlz
IGZsYWcgY29udHJvbHMgaWYgdGhlIGhhcmR3YXJlIAo+IGVuZ2luZSBjYW4gYmUgdXNlZCBmb3Ig
Y29tbWFuZCBzdWJtaXNzaW9uIGFuZCBpcyBvbmx5IGJlIHNldCB0byAKPiB0cnVlL2ZhbHNlIGR1
cmluZyBpbml0aWFsIGRyaXZlciBsb2FkLgo+Cj4gSWYgeW91IGNoYW5nZSBpdCB0byBmYWxzZSBk
dXJpbmcgaHdfZmluaSB0aGUgZW5naW5lIHdvbid0IHdvcmsgCj4gY29ycmVjdGx5IGFueSBtb3Jl
IGFmdGVyIEdQVSByZXNldCBvciByZXN1bWUuCltKWl0gSWYgSSByZWNhbGxlZCBjb3JyZWN0bHkg
dGF0IGh3X2luaXQgd2lsbCBiZSBjYWxsZWQgZXZlcnkgdGltZSBhZnRlciAKR1BVIHJlc2V0IG9y
IHN1c3BlbmQvcmVzdW1lLAo+Cj4gSWYgeW91IGhhdmUgYW55IGlkZWEgaG93IHRvIGRvY3VtZW50
IHRoYXQgZmFjdCB0aGVuIHBsZWFzZSBzcGVhayB1cCwgCj4gY2F1c2Ugd2UgaGFkIHRoaXMgcHJv
YmxlbSBhIGNvdXBsZSBvZiB0aW1lcyBub3cuCj4KPiBKdXN0IHNlbmQgb3V0IGEgcGF0Y2ggZml4
aW5nIHZhcmlvdXMgb3RoZXIgb2NjYXNpb25zIG9mIHRoYXQuCj4KPiBSZWdhcmRzLAo+IENocmlz
dGlhbi4KPgo+Pgo+Pj4gSSd2ZSByZW1vdmVkIGFsbCBvZiB0aG9zZSBhIGNvdXBsZSBvZiB5ZWFy
cyBhZ28uCj4+Pgo+Pj4gUmVnYXJkcywKPj4+IENocmlzdGlhbi4KPj4+Cj4+Pj4gKwo+Pj4+ICvC
oMKgwqAgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uaWRsZV93b3JrKTsKPj4+
PiDCoCDCoMKgwqDCoMKgIGlmICgoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9WQ05f
RFBHKSB8fAo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBSUkVHMzJfU09DMTUoVkNOLCAwLCBtbVVWRF9T
VEFUVVMpKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAoYWRldi0+dmNuLmN1cl9zdGF0ZSAhPSBBTURf
UEdfU1RBVEVfR0FURSAmJgo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgIFJSRUczMl9TT0MxNShWQ04s
IDAsIG1tVVZEX1NUQVRVUykpKSB7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHZjbl92MV8wX3Nl
dF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfUEdfU1RBVEVfR0FURSk7Cj4+Pj4gK8KgwqDC
oCB9Cj4+Pj4gwqAgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+PiDCoCB9Cj4+Pgo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
