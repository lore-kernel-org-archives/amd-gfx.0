Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15758C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22446140A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22446140A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94DCD6E2BC;
	Fri, 14 May 2021 21:01:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D50A6E2B6;
 Fri, 14 May 2021 21:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL/nnAQnKx3agrMsGEF1Ua9t/RZ8DU/9mepk35gAm4ljnR1jT40R4ZXA6Vqj02WJXuJTMNvfTQ6aci8DwFsDgysBRgGjxOO3rDgcTUvBAc1VX2HJybRhA7JPq9xIAKKFa3xy91XG/a7vKBZnskoqRFV3IQjzk7O/EMWOtRH2dmAno51dFKUmNGRhBKO7b5pIuXvVgt2WD2KGHkuHWtlSW0I4zSO7OWWI5EZtM/zZMtuL5mM+o5wJCJu8RaarLOyH0q0HLc10aFtGnud6bRvLY6KnlmddA4EYayCEmgJvCzWcttbQ2Olzf1ZYie437WTt2Nxr7+8GtxGgJ68+AXZMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMUt6FN3MHPjboy4Z9TaQIR8HVobamTQMEfDXL0X/y4=;
 b=hSCKsBwTCyQtKa8hlJ/lRMC38RdtxHvZitzg4qITAGxM2FMW24lCBQpPHdItAtWI82ofY96RNKLRg9VBQKaDJjbjMS1pd4U6FgQ4aYYJV+qHolYK4SjqDlsmaMVlCklc2xcr8710nsZVp4ixkRxOiRnuwXJsPgIfUb9JnrgDKbqQ73EATTySSBJCz3YQUADbLAbuTfT+VVqEeOe+B61VbQe5HH5BMNkMRO1S6SFZSwlKFyPdrM//g6xEKJB69CoNKFMY1TBTMy3ToemERl6FFQhQ0icuaL7aGTfIRepBsXRVWRwBWsk6WR4MWBYgrSgoKJDe81L4hExPjR/GBhEk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMUt6FN3MHPjboy4Z9TaQIR8HVobamTQMEfDXL0X/y4=;
 b=OrVwQW7b1fugG1E818csy9qUcxYbblu3xRAGdfcLkm2NS7Qj4KcKYeutyyQ4ZJmeDCptej5q8aqUOngmT7ar36468++i7f6zWYMFWqSRjDckOOMB4Gyif7R05YZGmueOiihPYDR3wWmb9/UoEk5As9AYZlJflXMJbEHDpDDek70=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW2PR12MB2475.namprd12.prod.outlook.com (2603:10b6:907:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 21:01:38 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25%4]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 21:01:38 +0000
Subject: Re: [RFC PATCH 0/3] A drm_plane API to support HDR planes
To: Shashank Sharma <shashank.sharma@amd.com>,
 Pekka Paalanen <ppaalanen@gmail.com>
References: <20210426173852.484368-1-harry.wentland@amd.com>
 <20210427175005.5b92badc@eldfell>
 <ba369002-69e9-15d5-323c-1923ecdeda63@amd.com>
 <20210430124358.1f5ac6ec@eldfell>
 <82a1c8e6-a7d6-bff3-fae7-f2a3dc68f9f7@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <2ba212c5-d30f-9f9c-3f98-ac27f214a9be@amd.com>
Date: Fri, 14 May 2021 17:01:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <82a1c8e6-a7d6-bff3-fae7-f2a3dc68f9f7@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YQBPR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::34) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YQBPR01CA0098.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Fri, 14 May 2021 21:01:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a956a1c2-f4dd-47c3-cc5f-08d9171b771b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2475:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB247586FC6E7AB6C02171D6268C509@MW2PR12MB2475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cc+GczcPMJbvvTkNwfUmIsKhDNqeHlKWs+MDUPx2ZGgA8A9CDVSe5EPtT0kh5+Au6ia2FLORsDfkpBKnk6JSlEjtd2ns5nwG9beCT0aFIrmbrLmCpNNgHKmJI6BJVyQGyJKQ7Jlekgf7nt/F/krEAqx+lcQLirJjFsQFmrhv54j+cU7GHeY24gYwQM5U/nRZDqhxQWpPKEQUtb3+RurutnPQOTmGW3xK1zJluWvJE5RwbrEua8aJcOy1MALRZmyh0JheZ7U/XT+EL/4Cd07PMLOtn2YWG7UGu97y1PUlZE/4+CnGVKVckDN4tRSdX7E3xQsEe/0qBmsU0XF78w2MfWs0Z2v9sMgnlK1AQ4krokj7HA+D2gxVQEXEYxi0RMyV9I9OgogoRezKZG9KEzSv+KwOdm8RtpWrZh4xDR0ScgidYKu69pIWg3tWYYCXqjLRkZKSuAp3MDXxJGeIhQSrsaLvHe4IMhgArN1pqvRJJ0kAHPVlRTT2/tKFMS5nDQpFjy18bqYLZJOu2DxAJh81kiyLFVJord8OLDPdtLhU2n4ySR/EySVeqofpOVRPCQ2HDSFifPnz2I4aKA73qFkMqwKc6kt4GPAePi1DUfGmCMEseGIlwH1JXQeFeJA+bNYFm01Z28mwM4t3iZrP6ouzn8YB3OSx6PS/z0qH1+bGOkkydzSMb0dCa1+QJzBs4Pm+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(44832011)(8936002)(956004)(31686004)(8676002)(36756003)(2616005)(316002)(6486002)(110136005)(86362001)(16576012)(5660300002)(6666004)(16526019)(53546011)(2906002)(26005)(31696002)(186003)(66556008)(478600001)(38100700002)(66946007)(83380400001)(66476007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MTZ2eVh6TXlPTjRmSWhCUGpBc2VMeW8yZFVDUW9qaDVaTWJ5UHI3ZllqU3Y0?=
 =?utf-8?B?Z21NWmtBWGhvbGIrSTZsVUZsMmJnempVaFlkTG9DaWVneGhZTjd6Zm1Ta0hV?=
 =?utf-8?B?MEJQQitWazgxbFI2VFFUSElLM1prSTdSR0F5cENvdVRxN3E0L1dyRVpPT2sw?=
 =?utf-8?B?dXVmQ3paWDFjUGk4MU1OWjVwb3VoS2NacUl4SjI5TnFZVFlwb001ZU1aa2VX?=
 =?utf-8?B?OEJoSDh5L3VNZnRuYW83MCs4TkdTTTU0L0FHTitZWndnT3pubFdEaHdXdWpp?=
 =?utf-8?B?RzNnajhDRTVrNlNTa3ZxMThFM1NpQ0UzdWRqL2IwTFkwMmZnU001WnlKU3Zq?=
 =?utf-8?B?bkFPQkdENTl3VVR5RHBTTnpYV3QxQlJHeHRWRjJYNStJS0p6SVBaZkhpbXJk?=
 =?utf-8?B?UDN1QUtmcENDeWQxL0NmRThwRVh6RnZJNWEyUVZqRVY0TDZXY2NRSnlLZVhU?=
 =?utf-8?B?eEJNNHd6aFFuQUFZbStVcnJZaEE3N3Y5VUxxOHNhMUVoV3dkaXE3MlBWNkFW?=
 =?utf-8?B?RWdBclMyQUlGblQwU0htVHZVRnY4L0FLM3VwQ0NETHpFN1Yxb3ZqVUk2MmUv?=
 =?utf-8?B?NmNaMHdCeW0ybTNNU0QwblFKYzBDOG03VVNVdmZ6a1IrNzBIVGlzekRyNEZo?=
 =?utf-8?B?RXFlTFpaNkdNNGo1NVc2bDBjdXQxVTh1cHMzTmVCanZpUW5qZ0RadE1MQnp2?=
 =?utf-8?B?SHhlU2Q0OUYzenNrdzZyai9YK25pZHFGeisvZWd2TGgrSFB2SUt5RVQ5dHAx?=
 =?utf-8?B?MUx3MW10K2hCUFVjZEVEemZrR2s4TDY2VFdsTHh2Y1F5NHR5Q0s1dHdBQVJO?=
 =?utf-8?B?dGlOVkdyRmI4c2pBOU5PZEdFYTBUWlFlNHhENEtud0JIZk4rMG5MVmtNbHdj?=
 =?utf-8?B?YkFSOU5aZlZhL3RwdVZQS0h3SVZ0QWlIdmhoVzE3RDBPd010YXdob0hXeG9m?=
 =?utf-8?B?L3o0ZVhPaTFBemJmOU44T0ZjM2xCUWJXa0U0OUZpc1R5a0lFZ0JMTmQvNWZP?=
 =?utf-8?B?RDdpOXdtY3l5VXN5Q2o4aWxqb29WeUFPcnhYVlhOdzBWMFRmdFlvaHkrbTdN?=
 =?utf-8?B?d1BscVBoSXhJZ2ZrNTRNdy9SMGNic3Bsa1hKazB1U2FQbi83QVJDMWR1S0pM?=
 =?utf-8?B?U0orSFVJSzM2c3IxN1NrTHpvNlBreitvYW96WnRKTmVxWWNoWkhJZks2Slo1?=
 =?utf-8?B?bTFsUlRNR3RuaDU1clp5WUtub1BUakxkUVJyK0lBb1kyRlZFdHRtZW95RVB6?=
 =?utf-8?B?cWJ1dHRYblFwaC9DOC8zd3VJMXdEZjY1SGovQzMvbkVhdm1nbFh5QkJuOS8z?=
 =?utf-8?B?WW5SaEsyd0trMnBrMy8rZkROV3MxM20wLzNGUXZQN1BpLzBsRkJhYVBXai9w?=
 =?utf-8?B?T01hSm5HUTR4Z2V0ajFIZmZxVVlIeUx4eFRxY3ZUaSt6dGF0bktkZFR2M1pU?=
 =?utf-8?B?bG1hL1Q0YmluaHdMaGNBVzZRLytZaWR0ZHpldzVGOEdzU1dUZ1B2dnhIS21G?=
 =?utf-8?B?OTNXOE5VOVlWV3JtSVc0NUxaMUZkMk5ibFJPR3I1VjgydVhKek5KaEY0b0hz?=
 =?utf-8?B?ak9sZXBrMjNHN0tyVUFXSnNIYkE4RWowL0NqNDJxSTliZEZQMExHNDYrbXps?=
 =?utf-8?B?Ty9kZXRsM3dWWERHSjJjVXlXMVJjU2NEV2dwWWNyS0tnb2lhM0tGVVBPNzJs?=
 =?utf-8?B?Zy9SQU5FMlI4Q3JCdGtoTGozUFJJaXd1SFFOMWlNMTZTUi9nWVE2WGdiTGVV?=
 =?utf-8?Q?gB2zdhm5gCxLWlRGM3oXnABjeCQR1VngqnSVENJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a956a1c2-f4dd-47c3-cc5f-08d9171b771b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 21:01:38.3823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuiuHJOPHtShQaHjMP+HSBFRNpPeMetMrRQ5jtEgPSg67C1IIW0NPuxAKHCZPbTYo1Mjm8Uoq0ENT8xnSEzzEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2475
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
Cc: Deepak.Sharma@amd.com, aric.cyr@amd.com, Krunoslav.Kovac@amd.com,
 mcasas@google.com, dri-devel@lists.freedesktop.org, Shirish.S@amd.com,
 sebastian@sebastianwick.net, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org, laurentiu.palcu@oss.nxp.com,
 Bhawanpreet.Lakha@amd.com, Nicholas.Kazlauskas@amd.com,
 ville.syrjala@linux.intel.com, Vitaly.Prosyak@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA0LTMwIDY6MzkgYS5tLiwgU2hhc2hhbmsgU2hhcm1hIHdyb3RlOgo+IEhlbGxv
IFBla2thLAo+IAo+IE9uIDMwLzA0LzIxIDE1OjEzLCBQZWtrYSBQYWFsYW5lbiB3cm90ZToKPj4g
T24gV2VkLCAyOCBBcHIgMjAyMSAxMzoyNDoyNyArMDUzMAo+PiBTaGFzaGFuayBTaGFybWEgPHNo
YXNoYW5rLnNoYXJtYUBhbWQuY29tPiB3cm90ZToKPj4KPj4+IEFzc3VtaW5nIHRoZXNlIGRldGFp
bHMsIEEgY29tcG9zaXRvciB3aWxsIGxvb2sgZm9yIERSTSBjb2xvciBwcm9wZXJ0aWVzIGxpa2Ug
dGhlc2U6Cj4+Pgo+Pj4gMS4gRGVnYW1tYSBwbGFuZSBwcm9wZXJ0eSA6IFRvIG1ha2UgYnVmZmVy
cyBsaW5lYXIgZm9yIEdhbXV0IG1hcHBpbmcKPj4+Cj4+PiAyLiBHYW11dCBtYXBwaW5nIHBsYW5l
IHByb3BlcnR5OsKgIFRvIGdhbXV0IG1hcCBTUkdCIGJ1ZmZlciB0byBCVDIwMjAgY29sb3JzcGFj
ZQo+Pj4KPj4+IDMuIENvbG9yIHNwYWNlIGNvbnZlcnNpb24gcGxhbmUgcHJvcGVydHk6IFRvIGNv
bnZlcnQgZnJvbSBZQ0JDUi0+UkdCCj4+Pgo+Pj4gNC4gVG9uZSBtYXBwaW5nIHBsYW5lIHByb3Bl
cnR5OiBUbyB0b25lIG1hcCBTRFIgYnVmZmVyIFMySCBhbmQgSERSIGJ1ZmZlciBIMkgKPj4+Cj4+
PiA1LiBHYW1tYSBwbGFuZS9DUlRDIHByb3BlcnR5OiB0byByZS1hcHBseSB0aGUgb3V0cHV0IFNU
MjA4NCBjdXJ2ZQo+Pj4KPj4+Cj4+IC4uLgo+Pgo+Pj4gwqAqCj4+PiDCoCoKPj4+IMKgKgo+Pj4g
wqAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDilIzi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJDCoMKg
wqDCoMKgwqDCoMKgwqDCoCDilIzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilJDCoMKgwqDCoMKgwqAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQCj4+PiDCoCogSERSIDYwMCBOaXRz4pSCwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg4pSCSERSIDYwMCBOaXRzIOKUgsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIOKUgkhEUjYwMMKgwqDCoMKgIOKUgsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIOKUgkhEUjUwMCDilILCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAg4pSCIEhEUjUwMAo+Pj4gwqAqwqDCoCDilIDilIDilIDilIDilIDilIDilIDilIDilrog
4pSCwqAgRGVnYW1tYcKgwqDCoMKgwqDCoMKgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKWuuKUgsKgIENvbG9yIHNwYWNlwqDCoMKgIOKUnOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKWuuKUgsKgIFRvbmUgbWFwcGluZ8KgwqAg4pSc4pSA4pSA4pSA4pSA4pSA
4pSA4pa64pSCwqAgR2FtbWHCoMKgwqDCoMKgwqDCoMKgIOKUggo+Pj4gwqAqIEJUMjAyMMKgwqDC
oMKgwqAg4pSCwqAgT0VURiBTVDIwODTCoMKgwqAg4pSCIEJUMjAyMMKgwqDCoMKgwqAg4pSCwqAg
Y29udmVyc2lvbsKgwqDCoMKgIOKUgkJUMjAyMMKgwqDCoMKgIOKUgsKgwqAgSDJIwqDCoMKgwqDC
oMKgwqDCoMKgwqAg4pSCQlQyMDIwIOKUgsKgIFNUMjA4NMKgwqDCoMKgwqDCoMKgIOKUgiBCVDIw
MjAKPj4+IMKgKiBZQ0JDUjQyMMKgwqDCoCDilILCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCDilIIgWUNCQ1I0MjDCoMKgwqAg4pSCIFlDQkNSLT5SR0LCoMKgwqDCoMKgIOKUglJHQjg4
wqDCoMKgwqDCoCDilILCoMKgIDYwMC0+NTAwwqDCoMKgwqDCoCDilIJSR0I4ODgg4pSCwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIOKUgiBSR0I4ODgKPj4+IMKgKiBOb24gTGluZWFywqAg
4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSY
IExpbmVhcsKgwqDCoMKgwqAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSYTGluZWFywqDCoMKgwqAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYTGluZWFyIOKUlOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmCBTVDIwODQKPj4+IMKgKi8KPj4g
SGkgU2hhc2hhbmssCj4+Cj4+IEkgdGhpbmsgeW91IG1pZ2h0IGhhdmUgZGVnYW1tYSBhbmQgY29s
b3IgbW9kZWwgY29udmVyc2lvbiByZXZlcnNlZCwgb3IKPj4gaXMgdGhhdCBhIG5ldyB0aGluZyBp
biB0aGUgSERSIHNwZWNzPwo+Pgo+PiBVc3VhbGx5IHRoZSBZQ2JDci9SR0IgY29udmVyc2lvbiBt
YXRyaXggYXBwbGllcyB0byBub24tbGluZWFyIHZhbHVlcwo+PiBBRkFJVS4KPiBBaCwgdGhhdCB3
YXMgZHVlIHRvIHRoZSBHYW11dCBtYXBwaW5nIGJsb2NrLiBZb3UgYXJlIHJpZ2h0LCBjb2xvciBm
b3JtYXQgY29udmVyc2lvbiBjYW4gaGFwcGVuIG9uIG5vbi1saW5lYXIgZGF0YSAoZG9lc24ndCBt
ZWFuIGl0IGNhbid0IGhhcHBlbiBvbiBsaW5lYXIpLCBidXQgaW4gdGhlIHNlcXVlbnRpYWwgYmxv
Y2sgYWJvdmUsIHRoZXJlIHdhcyBnYW11dCBtYXBwaW5nIChjb2xvciBzcGFjZSBjb252ZXJzaW9u
KSwgd2hpY2ggbmVlZHMgdG8gYmUgZG9uZSBvbiBMaW5lYXIgc3BhY2UsIGFuZCBJIHdhcyBhIGJp
dCB0b28gbGF6eSB0byBjcmVhdGUgc2VwYXJhdGUgYmxvY2tzLCBzbyBJIGp1c3QgcmVbcGxhY2Vk
IHRoZSBibG9jayB0aXRsZXPCoCA6RC4KPj4gVGhlcmUgaXMgYWxzbyBjb25mdXNpb24gd2l0aCBP
RVRGIHZzLiBFT1RGLiBJIGdvdCB0aGF0IGluaXRpYWxseSB3cm9uZwo+PiB0b28uIE9FVEYgaXMg
bm90IGp1c3QgYSBuYW1lIGZvciBpbnZlcnNlLUVPVEYgYnV0IGl0IGlzIHVzZWQgaW4gYQo+PiBk
aWZmZXJlbnQgY29udGV4dC4gVGhvdWdoIGhlcmUgaXQgc2VlbXMgdG8gYmUganVzdCBhIHR5cG8u
Cj4+IE9FVEYgaXMgaW5oZXJlbnQgdG8gYSBjYW1lcmEgd2hlbiBpdCBjb252ZXJ0cyBsaWdodCBp
bnRvCj4+IGVsZWN0cmljYWwgc2lnbmFscy4gRU9URiBpcyBpbmhlcmVudCB0byBhIG1vbml0b3Ig
d2hlbiBpdCBjb252ZXJ0cwo+PiBlbGVjdHJpY2FsIHNpZ25hbHMgdG8gbGlnaHQuIERlcGVuZGlu
ZyBvbiB3aGF0IHRoZSBlbGVjdHJpY2FsIHNpZ25hbHMKPj4gaGF2ZSBiZWVuIGRlZmluZWQgdG8g
YmUgaW4gZWFjaCBzdGVwIG9mIGEgYnJvYWRjYXN0aW5nIGNoYWluLCB5b3UgbWlnaHQKPj4gbmVl
ZCBPRVRGIG9yIEVPVEYgb3IgdGhlaXIgaW52ZXJzZSBvciBhIGRpZmZlcmVudCBPRVRGIG9yIEVP
VEYgb3IgdGhlaXIKPj4gaW52ZXJzZS4KPiAKPiBZZXMsIHRoYXQgd2FzIGEgdHlwby4gVGhlIGlu
dGVudGlvbiB3YXMgdG8gY2FsbCBpdCBpbnZlcnNlIGN1cnZlIGZvciBIRFIgZW5jb2RlZCBidWZm
ZXJzLiBJdCdzIGFsbW9zdCA0IHllYXJzIChhbmQgMiBjb21wYW5pZXMpIHNpbmNlIEkgbGFzdCBk
aWQgSERSLCBzbyBJIGFtIGEgYml0IHJ1c3R5IG9uIHRoZSB0b3BpYyA7KSAuCj4gCj4gLSBTaGFz
aGFuawo+IAoKVGhhbmtzLCBWaWxsZSBhbmQgU2hhc2hhbmsuIFRoaXMgaXMgaW5kZWVkIGhlbHBm
dWwuIEkgYXBvbG9naXplIGZvciB0aGUgbGF0ZQpyZXNwb25zZSBidXQgSSBuZWVkZWQgdG8gdGFr
ZSBzb21lIHRpbWUgdG8gZG8gbW9yZSByZWFkaW5nIGFuZCBpbnRlcm5hbGl6ZSBzb21lCm9mIHRo
ZSBIRFIgYW5kIENNIGNvbmNlcHRzLiBJIHdpbGwgc2VuZCBvdXQgYSB2MiBvZiBteSBwYXRjaHNl
dCBidXQgcmVhbGl6ZQp0aGF0IGl0IGlzIG9ubHkgYSBzbWFsbCBzdGVwIHRvd2FyZCB0aGUgcmln
aHQgS01TIGludGVyZmFjZSBmb3IgSERSIGFuZCBDTS4KCkhhcnJ5Cgo+Pgo+PiBBcyB3ZSBhcmUg
dGFsa2luZyBhYm91dCBkaXNwbGF5cyBhbmQgbGlrZWx5IGFzc3VtaW5nIGRpc3BsYXktcmVmZXJy
ZWQKPj4gY29udGVudCAobm90IHNjZW5lLXJlZmVycmVkIGNvbnRlbnQpLCB3ZSBwcm9iYWJseSBo
YXZlIG5vIHVzZSBmb3IgT0VURiwKPj4gYnV0IHdlIGNvdWxkIGhhdmUgc2V2ZXJhbCBkaWZmZXJl
bnQgRU9URnMuCj4+Cj4+Cj4+IFRoYW5rcywKPj4gcHEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
