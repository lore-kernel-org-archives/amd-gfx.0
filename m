Return-Path: <SRS0=MNBo=HS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A90C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 07:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2F764DFF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 07:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2F764DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF686E171;
	Tue, 16 Feb 2021 07:51:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310B46E171
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 07:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQeNg3M+wYFlDMRqfHBNQOKDCUncVcqZt37GW3tyJ2P2CgibE/cJgIWUa8H3Lxd7ZdA6IpmZLWhEFh+tH0fi+3qbtMW3HThD1lTEumH5V+1By25d3H085omiRdB93wVUmxVWTHBcIzUUwyHjjPdO9o6gDAZkam1VUszaisR5PQVp1k8wsiPfp0Ma0Tt4Y/FegFPdjPJIYXEe0mMzuzVNjTigUQ63FFefp7GvD6D2mySrZHuxqMJEX/RL0qIvmOjTGKTIdtOhg4GYZ2i8ZcMlVj8BUC5v8TpURjdI9zOjDltA9lHyd7cD1Fe8OIcJHw7GQMe2uofNO6R47iPqORrK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75EPV+3FVV92WcPYBxJbLi6wNfPrXjlR8wtumUo1mHo=;
 b=QgZ3OklLSMC/WNJShhj7W/9yyU3GTXcDPyN3PFvdKMg5Hvg8rBBWav3p2LL+dZv0Kg7n74Cc/8vtQPMSTzuqpE+53R6Sj+3yEaFf8qfgRUtfnVLcKGvStrzQlhe1+jGHzaw7Vsvj/icLIbqVNMO9Ps61wJsXpU+cp9hGAqNHk3cOz8TfkigfG0piituvdhkVr4oK1iE2MtCG+LqQdBeez94um1CPgNwiYVOvscGQKn/RzuZmtLG6VQzYbaAqDubv6JUAXyo8TWVMSVk3wHC66KIU3BaEPd+iQwrso2GU4Cm5o8jb+kQ22l90taIo0GrDMAgxiy1hQWuFrB5ZnG8XFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75EPV+3FVV92WcPYBxJbLi6wNfPrXjlR8wtumUo1mHo=;
 b=hTPjt7zuawU8M0vu2uYHuRclmaukgD9ownJoM7hk6kJmO5jQsI7wKzEezEx0+HzxoEtH1zNBcI9tiEpqoaz7Ze1tv45/S3aavrUWsBWUXYhiKQHGp1kryxTbfnGSqbTxPjvm7QCVoWPpzmnjmI5+MuagBHqBFJsys5PHJbQtV9E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4900.namprd12.prod.outlook.com (2603:10b6:208:1c1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Tue, 16 Feb
 2021 07:51:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3846.038; Tue, 16 Feb 2021
 07:51:40 +0000
Subject: Re: [PATCH 1/2] drm/radeon: add rdev in ring struct
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210215181619.69377-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <03e70ad9-94b1-3685-403c-3b327506b0c6@amd.com>
Date: Tue, 16 Feb 2021 08:51:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210215181619.69377-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:49a5:2647:58aa:5400]
X-ClientProxiedBy: AM9P193CA0022.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:49a5:2647:58aa:5400]
 (2a02:908:1252:fb60:49a5:2647:58aa:5400) by
 AM9P193CA0022.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Tue, 16 Feb 2021 07:51:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 771d05f1-b639-4166-d6a8-08d8d24fb20d
X-MS-TrafficTypeDiagnostic: BL0PR12MB4900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49004952B9B9A33B064C1A7C83879@BL0PR12MB4900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45sSuVLZZ9mOdqGtk+/nShbRXS7Oordh7F1httEGJL0D1MLDUY5px4kQ8SP32hyvS1CsTBOeFdZnaELf33k7INBh1p11zbAacI4G/0xKu/yLvlsXMMqLraHkIz9o9VQ67NF3r8+L7cvJJE8skMTfgZtL9vB9FRdqb0Amf4WDJ3F/BwUMsC4pa5IVOfsQE+0D1PluBrg++/3T1aq0vbpeT4Tw6KEqR9c1cbRD/YbUG0HNR8woaGmRywpD47b/jJIhpRrBJ8VMreuq6APmjUShmZ07BN+sAGgSQRVj9S/Vi5meIl7aJqMCk+3BgCiR7jdHvje07VarrXfaXuhgQRZk2YZP02BQyS2/W9bZ7AuNho1/Dv2g0Qja2qBYt+TQ/E0VPVowyGNQDwVD8rXxA3fOz4iYQNqR6ESSS/TOmzyDjyOlq3hX+UIVbOX24MNR4OnLg57bPvDwo4dVTwHlGZ5egidP4woBv5M+pnEaNBaZeMsxyVGTqbs4ooPBTHKUfdbuToB2bGj7D9DlCNU4HlljXEIecZ5jrsz5FqILV4kbpmfzoJ0lPIWhuUU/AFqf6CuaCg9zxJy1j20zqhl0Uwr1zCBelkfjboTQ36pymRhnjz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(316002)(5660300002)(66556008)(31696002)(86362001)(36756003)(4326008)(6486002)(6666004)(2906002)(6636002)(37006003)(8676002)(186003)(66946007)(16526019)(66476007)(478600001)(2616005)(8936002)(31686004)(6862004)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SmxMV2JEcEQzOGFNQ09WQng1REJKWmpscVRaR3REbDlxbEpQMWpRZ1V1cERn?=
 =?utf-8?B?bEpTeDdnMGNQYVRuNlp2TFBxblJBbE1ydXpENzNwUGFRVklXQmY0Wk8raXFk?=
 =?utf-8?B?SmxmRFRDSS9jRHNtUldrY2FmNUljNVZjamR4UkVrOVg0MkVFaWlFN2xWL2N0?=
 =?utf-8?B?ZitzY3loeUJRbUR6L3JxeU5PMkI5QkRGTXdGbm1XUTRabDdNTS82cEQ1cXBO?=
 =?utf-8?B?SjVLbXhzMTdFNXBiRHJLVUVPaHhsT1UyUk54U1FQTEFnN3FCVnArUW5YcmZD?=
 =?utf-8?B?YjRiNkhLUys3TzhXZjJJZ0N1Mi9RNEVMWEl2cWl2WnU2MGpSWTdiVnVDQTdI?=
 =?utf-8?B?dThDK08xVE0vNVJqRkZRekZpZTcyT2dCNnY2SlYvV1ZuNUFSQnFuaWUxSUh0?=
 =?utf-8?B?eHVPb0xNMDFyMnFCWkhWTC9mNFZTcEVJZXVONDVlZDd1SlNWd2J4dTkyaDUr?=
 =?utf-8?B?M1NDb3pCSVUwS3FrZWhQQkozTjgwWXovc0FPN1Jua3VQWWRrcWgvL2NGZW11?=
 =?utf-8?B?RzVFMGIxR1d2c3IzOUNxeEx3WkJXWlZneVFrZlNGUlZKSXExNStoZkg1RmdZ?=
 =?utf-8?B?elU2cCsrU1lBbWpvblBTV0FNczV6Zmh0OTNESTUzbHVJV29LZ0N5cUVvdDVM?=
 =?utf-8?B?OVlvRUFManFmMWlZQS8zVGI1M3lDWGJaQVBTOG9wbkxjMnJESDdYcUtTRkN6?=
 =?utf-8?B?cXFVVElFQzNSejVxN1hlVldMQmNyTUh1bzdJK1crTnR2S2wyTTZTRjVXcWdt?=
 =?utf-8?B?eSs4OENETEdTVzB4dXZ4STZyRmtPcERIZWE0c0x2TEhyOFhJOTZwRU5OS044?=
 =?utf-8?B?U2pXV0tkYU9UZHpobzlKa2VmUTRrNWVta0VoNXp6RFRoZXdRR0pENGVQWGpC?=
 =?utf-8?B?RE40RTNFdDN5SWdBTENaZ0xGRWpOY091RFNCMzh0aUJsTk9HNTNXMEcrT0dD?=
 =?utf-8?B?NnFaWWRlNy9EVlpMeTlyeHg4enF6aXI4QUVpUkhwRTd3KzMyL3RlQlIrdG9S?=
 =?utf-8?B?Y2lLR0RjUXlJL0dDZDl3dExRaWt5dWtQUkF3N0ZxaEFpOXcwV2VaMncrN08w?=
 =?utf-8?B?UExvc1AwM2JpWUJIZ3Bnb3JJNGg1ZjNYbXkwd2FSV0JHejVTcHRneVlqSHln?=
 =?utf-8?B?N0UrSU41N0tCU3FNTVhhTERGOVNzdzU4QjAybWFySzE5WElMdTU0Sjd3QlFF?=
 =?utf-8?B?MjhEUWE1L3BCQWUwZllXRWJ3M1dWczZWT0VYd0dMVDlJcUhObTJMdFg2TkRh?=
 =?utf-8?B?WVBsNlRoVHMwT0R1OVRNREdCNlN6WW9Ob1hUenduKzJPenIwNmdYcFQ1bHlG?=
 =?utf-8?B?MW9FY2J2TTBEc3VLMVNuZ2RpbXBQTWl3em02Z1A4UTQrQnRKdS8zNnhacVcr?=
 =?utf-8?B?YmZlTWtFSGk2ak1ScHN1VlJPUU9WcHBabURKd0RRMWIzK2phTkc3QVFFN0dZ?=
 =?utf-8?B?dVRqL2ovMUdrK0RSQ3JwbDFvSzNBK3AzajZiMHRLekZ5NDFoMVdlVXJTMlU1?=
 =?utf-8?B?amxrS1o2SmFmaU1ybFo3N0tuUmErZWxPUmFHckhETkc0NjZjVVZidE9ibEky?=
 =?utf-8?B?NnM4Ri9Nbyt1dkVWeVBNNExYT0FRNXMxVkk1Sk1SWWZnd1c2WXh2Qko4ekk4?=
 =?utf-8?B?M3YxdE1HQnAvTnRmMWswalZGbXZJak04SmdyZzFzMjZiOWlrT2tONzN3QUFl?=
 =?utf-8?B?VUFnMHBTQWxDSlRqcytYVUd0UndtVWxGS0hEM3V1OUgxeHNaU2dIbEd2YmpR?=
 =?utf-8?B?QVVHZW84NWJqVngzRU10U2VjNWh6QVFZK3VPWVFIbDJTZG5XNWh5YUF6Mlpo?=
 =?utf-8?B?Yzd3SnZxdEU3SVJKb3dyRmIwS2pBOS9LR0F6U2s3TkRPYi9sMWp4RkM4T1d4?=
 =?utf-8?Q?spZuWI2GbcEN7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771d05f1-b639-4166-d6a8-08d8d24fb20d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 07:51:40.7354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k10ue03O9c+uLVaqYR3ZqoALBOITocT4dAf9KgF+VAGuiX1P+vLhZNiAuOyETniU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4900
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTUuMDIuMjEgdW0gMTk6MTYgc2NocmllYiBOaXJtb3kgRGFzOgo+IFJldHJpZXZpbmcgcmFk
ZW9uIGRldmljZSBzdHJ1Y3QgZnJvbSByaW5nIHN0cnVjdCB3aWxsIGJlCj4gdXNlZCBpbiBuZXh0
IHBhdGNoIHdoZXJlIGRlYnVnZnMncyBzaG93IGZ1bmN0aW9uIGNhbiBvbmx5IHBhc3MKPiBvbmUg
cHJpdmF0ZSBkYXRhIHBvaW50ZXIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJt
b3kuZGFzQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhpcyBvbmUuCgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhlIG90aGVyIG9uZS4KCj4gLS0tCj4g
ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5oICAgICAgfCAxICsKPiAgIGRyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX3JpbmcuYyB8IDEgKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbi5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb24uaAo+IGluZGV4IDJjMGUzZTdj
Mjk0ZC4uZWFhOTIyM2Q2ZjUyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5oCj4gQEAgLTgz
MSw2ICs4MzEsNyBAQCBzdHJ1Y3QgcmFkZW9uX2liIHsKPiAgIH07Cj4gICAKPiAgIHN0cnVjdCBy
YWRlb25fcmluZyB7Cj4gKwlzdHJ1Y3QgcmFkZW9uX2RldmljZQkqcmRldjsKPiAgIAlzdHJ1Y3Qg
cmFkZW9uX2JvCSpyaW5nX29iajsKPiAgIAl2b2xhdGlsZSB1aW50MzJfdAkqcmluZzsKPiAgIAl1
bnNpZ25lZAkJcnB0cl9vZmZzOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9yaW5nLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9yaW5nLmMKPiBp
bmRleCBjMzMwNGM5NzdhMGEuLjQxZWQ4YWJhMTMxMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9yaW5nLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9yaW5nLmMKPiBAQCAtMzg3LDYgKzM4Nyw3IEBAIGludCByYWRlb25fcmluZ19pbml0
KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBzdHJ1Y3QgcmFkZW9uX3JpbmcgKnJpbmcsIHVu
c2lnCj4gICAJcmluZy0+cmluZ19zaXplID0gcmluZ19zaXplOwo+ICAgCXJpbmctPnJwdHJfb2Zm
cyA9IHJwdHJfb2ZmczsKPiAgIAlyaW5nLT5ub3AgPSBub3A7Cj4gKwlyaW5nLT5yZGV2ID0gcmRl
djsKPiAgIAkvKiBBbGxvY2F0ZSByaW5nIGJ1ZmZlciAqLwo+ICAgCWlmIChyaW5nLT5yaW5nX29i
aiA9PSBOVUxMKSB7Cj4gICAJCXIgPSByYWRlb25fYm9fY3JlYXRlKHJkZXYsIHJpbmctPnJpbmdf
c2l6ZSwgUEFHRV9TSVpFLCB0cnVlLAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
