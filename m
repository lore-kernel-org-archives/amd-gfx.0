Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0917BC47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC7A613B4
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC7A613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6F66ECD7;
	Wed,  2 Jun 2021 14:53:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 291A36ECD7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 14:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGI6sdUU040wPkjByjGvc/FWZLctWy2WAOA/jnuZqAA9Lcp0Hgl7Q+sbeHr9SKQdseEdTvItZY719V0Sf+d8IqOq8EVs/TNw3ChmnVFio8I9aXH729H0pgcdunOB2f1vMxSFmWC94ft98Rf/OZMNrINJV0uT3dbjJVoRjGmc9x6SZyHSbZn/Lc98mZi8avkYHr2OWqsSpEcM7kiOCP/2oh69lAO44PVVR/SuBL7zHGr8EADdNp87QRMcAyRKmJsSnrOHqcZHns66N06dkChyYz72bO79xRe0Q7Ip3i0X67G2Z7TULcG7BmvMLMbbcCnPezqU9GU3BlT76sX35pCnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxRNwTwiD6iuQ92+Wxfh9v7tvctzSDSnEkGDIebci2Y=;
 b=LRkjbcVz1t3CKc0Mft6TCBJaFsPmxGbwX8gYZqQqeg/1UfUGaz96OSbHmUuvHuJsMegUIqWTZ5ccVwczhnfadSTQAb0NX86VuYFCLtzBn8PPBkB58iqDG3NhG03dFo6eQIcMILtK9fQN413pTo9IzQKodOeBpsYBshqG+v74d6KBhbAhtkKwgpIUbwScYWZPRCFb+fM4TovhuSDsdQSb+1N7PAOz9mbj/g8P1e6g7C/cEN8cft1xdgs7PAlntoHPRPHHeATIkZazQNiX0ETUd4tSP0gRfrTyFv47YmE6RP1OzwCEmvQzcXf8b2OZ9l9gWSM3h/hg/bkDuPtALUgEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxRNwTwiD6iuQ92+Wxfh9v7tvctzSDSnEkGDIebci2Y=;
 b=AboVhDUeFplz9Ahld2Cmn76IcYF/T1BA/oA/BxVBqzgIg3eYewTqR3VggnU58DAgdfZNepKiUEKjfkaA+5Vm7HsJoaOarfAtZn/swSOy+amnyZyJivO+W9MIdC8nltT5ojRIeJn1Mph/zvRyOY4WhYeDg+6tJ02ENgbCx4i0/Ug=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5383.namprd12.prod.outlook.com (2603:10b6:408:104::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 14:53:27 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4195.020; Wed, 2 Jun 2021
 14:53:27 +0000
Subject: Re: [PATCH 1/4] drm/amdkfd: Add flush-type parameter to kfd_flush_tlb
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20210601225907.749049-1-jinhuieric.huang@amd.com>
 <1b688ac5-e4cd-5c8b-7972-1f120186b502@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b2a12152-2ae5-892b-5ee8-24cc1a0f46f7@amd.com>
Date: Wed, 2 Jun 2021 10:53:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <1b688ac5-e4cd-5c8b-7972-1f120186b502@gmail.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::19) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27 via Frontend Transport; Wed, 2 Jun 2021 14:53:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e92070-c37d-486d-4263-08d925d62db9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5383E539C70CED6F8E38CFC0923D9@BN9PR12MB5383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKC9uanleNkusv8sa2JGe4m0qZ5EQXO/rrsqcRz16M+A926GSr57eV/Pxm7dpwf90pdvpf5ld9U/42A3n07MilV/K3KUi2n7n4WgcPKz1uE0ACfzlkbqCgoG+O8VJd+iYtsuHEX/0adhcAsIe+eJCawkvIaRx2JVQrl9yzhCxj5dc2h3ejHvzLfcoaEpf1wP/PoCBFr/jrVQla41wuXjhKuIqHW38OFVrz/a+XhiCl9Lh7sMYufsivlHVlCJGXhu1KZ+Q/GRaQHoiBJs0qYBNg6qmxxfod9VDGr31YLPUCcrqkiRTHK6o1cJQALLbWhHSP4Geqp7ttj6f8dvOdhXBKhev9tGg5YGo7OMWuVBZpxdwnzhOtjb8Zlz7OZ5veplpOaUAv4Fzp3m8/PTSPDq333PgZkQdsF2WPrKAI0TyMRZNNJTY/aR7LM2q2FXTUMMmVOjZsto9WPtg2uzkY1vFp5zGePL+esO6ObSUIqX5Qf+yR0sbU4D5W5JKR0o/rv7s0NPi8qc33l01foGsYbBBxEemrXelZMMkq4+lw3vgl3snlVBKmAXKxh8zLIglT6Qeek/yEkp4Zl6dpFBWJkmjk4trlxjRHnHFrz33lVqUrbikD3GQ2Dscm6nJ32jz6UkddagugEF9hkOQHkVt+iS4T2cN7BB6NGbm3kisMNCqaspHF8wUGgchCeTBYq/t2ib
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(44832011)(83380400001)(16576012)(478600001)(66556008)(8936002)(26005)(316002)(31686004)(38100700002)(2906002)(31696002)(66574015)(956004)(8676002)(110136005)(86362001)(6486002)(36756003)(186003)(6636002)(16526019)(66946007)(5660300002)(66476007)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?emVGMnhiOExrTGlEMGxSNmxYMlJkWjdiQ2RzalI5UUVJTVNUZFZ4NVFLZnk3?=
 =?utf-8?B?ek1LaE1ZbU1Ba2JiSHJXR2pwSFl6eU1OWFcwQ2I5cG5RbEJlTHFhRlV4cXBG?=
 =?utf-8?B?T3ByQmhTWmpIT1ZCalNkYWxucXhjZytOMVJjdnBSVHMwb1hkY2NvVUxRNmFp?=
 =?utf-8?B?QkV1cU5iQTM5WWs1aEZyaURPb3RCdjE5RWRNT2hYOGFQRGV1OThDTDU4cDZP?=
 =?utf-8?B?OWEwbWJNS05TQnAxT01TenROdVk1RFhFOTg1YnRpTSs0RDAwc3p6OXNBWHNr?=
 =?utf-8?B?Q3FJREU0elhCVVhyaERxTXlyT0xDWER6dk1uNmJaa2xNWkVnSG05UzZNWnRv?=
 =?utf-8?B?dDVNaFBuczJ6eG9TeWNONlZOclh1bUVMV01HS0Y1Z0ZJWXRWK0NkMEJSeERj?=
 =?utf-8?B?OXBVd0QwaUpsTnhEbGMwL2pkUmtpN29HNi9oODJuSXkzYk1lNU9UWmdtSXh4?=
 =?utf-8?B?ckZNYjA0aXBEZWJPQm1TVTV4dXJ3N3hleWFoYlY5ck9ZeTN3UU0yTUYzR2ph?=
 =?utf-8?B?VndaQmtLMUdWZVR5Nk5YbThMTmVISW8vbXNETDlaNStXMlB3d29Cc003a1RM?=
 =?utf-8?B?Z20zb0p0aStpZGowM2d5a2ZSMEl0UnBQSUt6TUxkQm9aSFh2ZEtwQkd4Vkcz?=
 =?utf-8?B?ZmYxRnMyRmcxUWFqRGZ4MzNqVzRZc3VoUGlhaEdVbW9XdTJFc1lVc0lYM0pQ?=
 =?utf-8?B?VzZjN0VNN1pXOGJWRXRxKzFjZjNDOWFuV0I1TU5rRnRwNmtpUnEvWGgxTXR4?=
 =?utf-8?B?ZWg4a3RoeTRzanZFdmwxL1dxUEdSako3YUNtNjU2cXlneDhFTElpZVExb1p6?=
 =?utf-8?B?WC93VDFhenc3OU1ZWjBta2NweGlyY0FIVFpEUy96MlRwUjk5MU9IZjh3WjJ5?=
 =?utf-8?B?YWxseW5vNjVsNnNzcEhhdVNHcnZsaWRyU0J2TFo1MzFYZUFGWkN1cGUxdUFK?=
 =?utf-8?B?UWZhZWhOS1BpVXp4aXNaTkMvcDRWTzRGVUg0YlRySWlqbUNmM3h2dnBGMDlC?=
 =?utf-8?B?NFI5U2FRT1FhNnhYdlozWWlJc0lDTFBSNHEzNDJwMzR0TUpCaER1WkRVUGtD?=
 =?utf-8?B?NGpYWjR0WGEwc3dFYXJVVnd5RC8yMHhEb1NtQlJXZzJJVWdOcllPcEM5bEhJ?=
 =?utf-8?B?ZDlKQkFZNGM0ZUVxQUJUb1c5dG5MQ2gwMVdtRjc5eGZaNG9lUnRZTXowRmE3?=
 =?utf-8?B?Ym4rU0diYjVtU3M3MHovV0NPeGdycEJ2QnU3K3pjUXJadlhucTZzd0k3Q3Vx?=
 =?utf-8?B?Wko2L2dDRFVTUGFiRkdjSGt1REdsdnBUQnRicTRIdWJlakswOG8xQUNsSGly?=
 =?utf-8?B?anprdHRZbE9KN2owVkx1RGFOMTg5Q3hLNG0wdWZZOXdBUWtwUVpXcEo0Z3F0?=
 =?utf-8?B?QzRLMmlaanB3UEVVTVR1MXM1VnN6aHJ1Z3lWbkxMbC9NNy85RGdYeWN0RWhj?=
 =?utf-8?B?dWk5Z0lOUkdvZEU2L09HVm92Y052K29QemZ2dVNTcGNVUTlZNXM3ZGVheVBt?=
 =?utf-8?B?dW9rQmo2bkxnTTZQUXhoeFNjMjBRL1JjTk9EdUMrc3plVHU0V0VjdVFBRDlh?=
 =?utf-8?B?TW9hczI0cDVXQmttWkt6R3dtbnBQY1htNTBRNnJvd0xiNmNESFkwSUNXM21W?=
 =?utf-8?B?Q2xXY3RrMUxQUE0rQWlCVHRZWGtqd3dKVThvNTF0M21HcFRTc2xRQU0wRzB4?=
 =?utf-8?B?TVBITXh6L1VwTm4vVWxDQTljSDNlbzlGcG1JUU8xR1lSSC9OR1ZERUh4WnNj?=
 =?utf-8?B?eXZSR2RwR3N3SHQ3NnYyU2dhcGk0elZuK2xiaGp4dHFScjg5MjlWMk83ODdu?=
 =?utf-8?B?bXhkMnV1SGRjMzRKcmpmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e92070-c37d-486d-4263-08d925d62db9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:53:27.1882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKwQYleq1Z7qCmx/3YqpYn37JtisX9XtO2O/sBoLCNflORxbAuaCaifkpMBnUQnzHg6TMyYxkHso+1IGcOPAmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5383
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

QW0gMjAyMS0wNi0wMiB1bSAyOjUzIGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IE1v
c3RseSBhIHF1ZXN0aW9uIGZvciBGZWxpeCBhbmQgUGhpbGlwOgo+Cj4gSSd2ZSBiZWVuIHRoaW5r
aW5nIGZvciBhIGJpdCBhYm91dCBob3cgdGhhdCBjYXNlIGhhcHBlbnMgaW4gdGhlIGZpcnN0Cj4g
cGxhY2U/Cj4KPiBJIG1lYW4gaWYgd2UgaGF2ZSBhIFBERSB3aGljaCBwb2ludHMgdG8gUFRFcyBh
bmQgdGhlbiBzd2l0Y2ggdGhhdCBpbnRvCj4gYSAyTWlCIFBURSB0aGVuIHdoeSB3YXNuJ3QgdGhh
dCByYW5nZSBpbnZhbGlkYXRlZCBiZWZvcmU/Cj4KPiBJbiBvdGhlciB3b3JkcyB3aGVuIHRoZSBQ
REUgcG9pbnRzIHRvIHRoZSBQVEVzIHdlIHNob3VsZCBoYXZlIGhhZCBhbgo+IHVubWFwIG9wZXJh
dGlvbiBvbiB0aGF0IHJhbmdlIGJlZm9yZSB3aGljaCBzaG91bGQgaGF2ZSBpbnZhbGlkYXRlZCB0
aGUKPiBUTEIuCgpUaGUgdW5tYXAgb3BlcmF0aW9uIGRvZXNuJ3QgY2hhbmdlIHRoZSBQREUsIGl0
IG9ubHkgY2hhbmdlcyB0aGUgUFRFcyBvbmUKbGV2ZWwgZG93biBpbiB0aGUgcGFnZSB0YWJsZS4g
Rm9yIGV4YW1wbGUsIGltYWdpbmUgeW91IHVubWFwIGEgNEtCIEJPLgpJdCdzIHRoZSBsYXN0IDRL
QiBtYXBwaW5nIHdpdGhpbiB0aGlzIDJNQiBibG9jay4gQnV0IHRoZSB1bm1hcHBpbmcgb25seQp1
cGRhdGVzIHRoZSBQVEUgZm9yIHRoYXQgNEtCIHBhZ2UuIEl0IGRvZXMgbm90IGNvbnNvbGlkYXRl
IHRoZSBlbnRpcmUKMk1CIGJsb2NrIGludG8gYW4gaW52YWxpZCBQREUgYmVjYXVzZSBpdCBkb2Vz
bid0IGxvb2sgb3V0c2lkZSB0aGUgc21hbGwKYWRkcmVzcyByYW5nZSB0aGF0IGl0J3MgdW5tYXBw
aW5nLgoKTm93IHlvdSBtYXAgYSBuZXcgMk1CIEJPIGF0IHRoYXQgdmlydHVhbCBhZGRyZXNzLiBU
aGF0J3Mgd2hlbiB0aGUgUFRCCmdldHMgZnJlZWQgYW5kIHRoZSBQREUgZ2V0cyB0dXJuZWQgaW50
byBhIFBURSB3aXRoIHRoZSBQIGJpdCBzZXQuCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4KPiBSZWdh
cmRzLAo+IENocmlzdGlhbi4KPgo+IEFtIDAyLjA2LjIxIHVtIDAwOjU5IHNjaHJpZWIgRXJpYyBI
dWFuZzoKPj4gSXQgaXMgdG8gcHJvdmlkZSBtb3JlIHRsYiBmbHVzaCB0eXBlcyBvcG90aW9uIGZv
ciBkaWZmZXJlbnQKPj4gY2FzZSBzY2VuYXJpby4KPj4KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBI
dWFuZyA8amluaHVpZXJpYy5odWFuZ0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
MiArLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21h
bmFnZXIuYyB8IDYgKysrLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9w
cml2LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0KPj4gwqAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgNCArKy0tCj4+IMKgIDQgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRl
bGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2NoYXJkZXYuYwo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2
LmMKPj4gaW5kZXggOTYwOTEzYTM1ZWU0Li40ZGE4YWZmM2RmMjcgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKPj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwo+PiBAQCAtMTY2Niw3ICsxNjY2LDcgQEAg
c3RhdGljIGludCBrZmRfaW9jdGxfbWFwX21lbW9yeV90b19ncHUoc3RydWN0Cj4+IGZpbGUgKmZp
bGVwLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKFdBUk5fT05fT05DRSghcGVlcl9wZGQpKQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGlmICghYW1kZ3B1X3JlYWRfbG9jayhwZWVyLT5kZGV2LCB0cnVlKSkgewo+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBrZmRfZmx1c2hfdGxiKHBlZXJfcGRkKTsKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAga2ZkX2ZsdXNoX3RsYihwZWVyX3BkZCwgVExCX0ZMVVNIX0xFR0FDWSk7Cj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9yZWFkX3VubG9jayhwZWVyLT5kZGV2
KTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gwqDCoMKgwqDCoCB9Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5j
Cj4+IGluZGV4IDJiZDYyMWVlZTRlMC4uOTA0YjgxNzhjMWQ3IDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+
PiBAQCAtMjc4LDcgKzI3OCw3IEBAIHN0YXRpYyBpbnQgYWxsb2NhdGVfdm1pZChzdHJ1Y3QKPj4g
ZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cXBkLT52bWlkLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxcGQtPnBhZ2VfdGFibGVf
YmFzZSk7Cj4+IMKgwqDCoMKgwqAgLyogaW52YWxpZGF0ZSB0aGUgVk0gY29udGV4dCBhZnRlciBw
YXNpZCBhbmQgdm1pZCBtYXBwaW5nIGlzCj4+IHNldCB1cCAqLwo+PiAtwqDCoMKgIGtmZF9mbHVz
aF90bGIocXBkX3RvX3BkZChxcGQpKTsKPj4gK8KgwqDCoCBrZmRfZmx1c2hfdGxiKHFwZF90b19w
ZGQocXBkKSwgVExCX0ZMVVNIX0xFR0FDWSk7Cj4+IMKgIMKgwqDCoMKgwqAgaWYgKGRxbS0+ZGV2
LT5rZmQya2dkLT5zZXRfc2NyYXRjaF9iYWNraW5nX3ZhKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
ZHFtLT5kZXYtPmtmZDJrZ2QtPnNldF9zY3JhdGNoX2JhY2tpbmdfdmEoZHFtLT5kZXYtPmtnZCwK
Pj4gQEAgLTMxNCw3ICszMTQsNyBAQCBzdGF0aWMgdm9pZCBkZWFsbG9jYXRlX3ZtaWQoc3RydWN0
Cj4+IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
Zmx1c2hfdGV4dHVyZV9jYWNoZV9ub2Nwc2NoKHEtPmRldmljZSwgcXBkKSkKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJGYWlsZWQgdG8gZmx1c2ggVENcbiIpOwo+PiDCoCAt
wqDCoMKgIGtmZF9mbHVzaF90bGIocXBkX3RvX3BkZChxcGQpKTsKPj4gK8KgwqDCoCBrZmRfZmx1
c2hfdGxiKHFwZF90b19wZGQocXBkKSwgVExCX0ZMVVNIX0xFR0FDWSk7Cj4+IMKgIMKgwqDCoMKg
wqAgLyogUmVsZWFzZSB0aGUgdm1pZCBtYXBwaW5nICovCj4+IMKgwqDCoMKgwqAgc2V0X3Bhc2lk
X3ZtaWRfbWFwcGluZyhkcW0sIDAsIHFwZC0+dm1pZCk7Cj4+IEBAIC04ODUsNyArODg1LDcgQEAg
c3RhdGljIGludCByZXN0b3JlX3Byb2Nlc3NfcXVldWVzX25vY3BzY2goc3RydWN0Cj4+IGRldmlj
ZV9xdWV1ZV9tYW5hZ2VyICpkcW0sCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZHFtLT5kZXYtPmtnZCwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBx
cGQtPnZtaWQsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcXBkLT5wYWdl
X3RhYmxlX2Jhc2UpOwo+PiAtwqDCoMKgwqDCoMKgwqAga2ZkX2ZsdXNoX3RsYihwZGQpOwo+PiAr
wqDCoMKgwqDCoMKgwqAga2ZkX2ZsdXNoX3RsYihwZGQsIFRMQl9GTFVTSF9MRUdBQ1kpOwo+PiDC
oMKgwqDCoMKgIH0KPj4gwqAgwqDCoMKgwqDCoCAvKiBUYWtlIGEgc2FmZSByZWZlcmVuY2UgdG8g
dGhlIG1tX3N0cnVjdCwgd2hpY2ggbWF5IG90aGVyd2lzZQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9wcml2LmgKPj4gaW5kZXggZWNkZDVlNzgyYjgxLi5lZGNlM2VjZjIwN2QgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaAo+PiBAQCAtMTMzOCw3ICsx
MzM4LDcgQEAgdm9pZCBrZmRfc2lnbmFsX3Jlc2V0X2V2ZW50KHN0cnVjdCBrZmRfZGV2ICpkZXYp
Owo+PiDCoCDCoCB2b2lkIGtmZF9zaWduYWxfcG9pc29uX2NvbnN1bWVkX2V2ZW50KHN0cnVjdCBr
ZmRfZGV2ICpkZXYsIHUzMgo+PiBwYXNpZCk7Cj4+IMKgIC12b2lkIGtmZF9mbHVzaF90bGIoc3Ry
dWN0IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkKTsKPj4gK3ZvaWQga2ZkX2ZsdXNoX3RsYihzdHJ1
Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQsIGVudW0KPj4gVExCX0ZMVVNIX1RZUEUgdHlwZSk7
Cj4+IMKgIMKgIGludCBkYmdkZXZfd2F2ZV9yZXNldF93YXZlZnJvbnRzKHN0cnVjdCBrZmRfZGV2
ICpkZXYsIHN0cnVjdAo+PiBrZmRfcHJvY2VzcyAqcCk7Cj4+IMKgIGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+PiBpbmRleCAzOTk1MDAyYzU4MmIuLjcyNzQxZjY1
NzlkMyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nl
c3MuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4+
IEBAIC0yMTU5LDcgKzIxNTksNyBAQCBpbnQga2ZkX3Jlc2VydmVkX21lbV9tbWFwKHN0cnVjdCBr
ZmRfZGV2ICpkZXYsCj4+IHN0cnVjdCBrZmRfcHJvY2VzcyAqcHJvY2VzcywKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBLRkRfQ1dTUl9UQkFfVE1BX1NJWkUsIHZt
YS0+dm1fcGFnZV9wcm90KTsKPj4gwqAgfQo+PiDCoCAtdm9pZCBrZmRfZmx1c2hfdGxiKHN0cnVj
dCBrZmRfcHJvY2Vzc19kZXZpY2UgKnBkZCkKPj4gK3ZvaWQga2ZkX2ZsdXNoX3RsYihzdHJ1Y3Qg
a2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQsIGVudW0KPj4gVExCX0ZMVVNIX1RZUEUgdHlwZSkKPj4g
wqAgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBrZmRfZGV2ICpkZXYgPSBwZGQtPmRldjsKPj4gwqAg
QEAgLTIxNzIsNyArMjE3Miw3IEBAIHZvaWQga2ZkX2ZsdXNoX3RsYihzdHJ1Y3Qga2ZkX3Byb2Nl
c3NfZGV2aWNlCj4+ICpwZGQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGRkLT5xcGQudm1pZCk7Cj4+IMKgwqDCoMKgwqAgfSBl
bHNlIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9hbWRrZmRfZmx1c2hfZ3B1X3RsYl9w
YXNpZChkZXYtPmtnZCwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHBkZC0+cHJvY2Vzcy0+cGFzaWQsIFRMQl9GTFVTSF9MRUdBQ1kpOwo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGRkLT5wcm9jZXNzLT5wYXNpZCwgdHlwZSk7Cj4+
IMKgwqDCoMKgwqAgfQo+PiDCoCB9Cj4+IMKgIAo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
