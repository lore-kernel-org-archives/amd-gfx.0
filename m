Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3B1C2D0BF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 17:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F4921835
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 17:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F4921835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4186E6F8BC;
	Thu,  5 Dec 2019 17:06:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF4966F8BC
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 17:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/8ypnROL1adQXIxxgGaQqcdahLqUsFukuM/eAsLX6ieg+uq+2BZqvQRjbkhC09QuVP3t7JB2KGt+HmLkCjy1fF3NRYLR/WAhsJxu7xNRUId23NQu+hHAdgFvtTFmK/StKr1jWICOmYZm9Z0Vor0X3l/jtj6JGAbclHKQDHq4Y3Q8HlMo0PV2jEOkjESsJEVnFdK5lFGFAxaPG1zJiiEDXEW+E6gg2AIV/ldnwUoE71vjAN2MmNyO70SfansKLAnPTDReQVtFI0c5rMfCaC10w99otllifkEb/P6hdSaXRGQA22DO6xNvBc11ddMaIjNRXwEWMgDCYDjszWOHUpZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94qd8rp8HW+igPB4mpdIPRK7ozh/xkbIXUB1UbCcTlQ=;
 b=KBXIneClgxoIHOjmPzTbdBTuh/SbgCb6nEsQcH2aA3+/erO95N9bpBtM0SyTf+ySThGqFBLrkxuH+lbMmkTKgqa3R4iSjMGmH14TTSJy+ETy9exdybjZlsDk3TwD9qKkTaOSis+R2zLxBNPaAlGl0X78cXhf4BnPJVgvziyg/VBacajw8RW7Z4srnxoIqzuIWtqFsasdcwmSJJa1OeqjbjbqCJ6Y8ZTlEDdbvyhmeSmSZ4bZET/A8OjNPh1SMXNieCrAoYFnHPf3mYpLo333fNeVr0GDf6VaQ7oU/r/JEKUXtA9EYcMU/5H/LEy7cuhRpunqpSc31dXUuPLWqtLlYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3273.namprd12.prod.outlook.com (20.179.106.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 17:06:00 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 17:06:00 +0000
Subject: Re: reserving VRAM for page tables
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <aeb00323-d755-da07-e658-c9a5f5877aaa@amd.com>
 <daa521c7-a844-4d4c-a12f-11efa6f7d2bd@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <383e2b8f-0e6f-434d-c7af-cd60bc1ad216@amd.com>
Date: Thu, 5 Dec 2019 12:05:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <daa521c7-a844-4d4c-a12f-11efa6f7d2bd@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::41) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47ca89be-b3ab-4f44-8dfd-08d779a56714
X-MS-TrafficTypeDiagnostic: DM6PR12MB3273:|DM6PR12MB3273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB327358BCC71FCB5828E4969F925C0@DM6PR12MB3273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(199004)(189003)(8936002)(14454004)(4744005)(5660300002)(2616005)(81166006)(81156014)(11346002)(478600001)(316002)(58126008)(6512007)(31686004)(6486002)(229853002)(2870700001)(110136005)(8676002)(2906002)(86362001)(50466002)(6506007)(26005)(25786009)(53546011)(186003)(99286004)(65956001)(66556008)(44832011)(66946007)(76176011)(36756003)(66476007)(31696002)(52116002)(23676004)(305945005)(36916002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3273;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YblAcTmKpRuQJ7S0sS2g87V+2M34AdtFxj4J/P2CAx3Bir7g76J2DddBCSYoz7Jy5ZX0K9jyajwyCwHXcQVW1rJXJGpKbOD0dzCv2wcL09iBFd0gvFUOIPNbIR+D7GMGDIUg16UsQKVk9mX4BW2pHtLMLlG/trq/5T8B4sCM7HjceaOMAUgUHAgJOIY4rvV5971KfHW7UTUg71sv/oc8R5Qqsi5/FyGu728wC8Je/Yziv+PCC/Y+3cJDY9kM5LhJU3Bm2afvG06K8RDd3Nx7FiEr8ur0qrZqPnb2waliwLOFpgJRWUaxo53EL4iof7hb/h6uWkJisq8Fu2ACR1Me7qo4GyvpxjsM8Gp5/G6LTdzsDPx0emSNVY3ouCW7X8FzXgtYbn3gbmn4TAEajBXsr8iSJiHLxYmaBmxxUD43Mg8qSyj4KqlZkGPzTIdVx1po
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ca89be-b3ab-4f44-8dfd-08d779a56714
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 17:06:00.3378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kF+WLIIwOPaaPpGqgLaFtCYJUOSFsuisaZ2wfIe3LuIBdvL60XVHNSJaOrJRbUON+ZW4BCnRzIzEw21lUBw8Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3273
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94qd8rp8HW+igPB4mpdIPRK7ozh/xkbIXUB1UbCcTlQ=;
 b=BQrGUgRqQGBiTaI5IAyJtgmI48uGKpBpWkyiR37+Sr07NeBITimFAMTIc8eYw20cfbfFwPvb9iK/qzo4wzsbTQMQMlmRTsLPRRx1r/yxRW9c5Y6ms6tX+Y3Z6rmRaOvU7vaXB9nOsKkLjv0hWGStvkPhr6bg7uOf2fXbM15dPHQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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

SSBkb24ndCB0aGluayB0aGlzIHNob3VsZCBnbyBpbnRvIGFtZGdwdV92cmFtX21nci4gS0ZEIHRy
aWVzIHRvIGF2b2lkIApydW5uaW5nIG91dCBvZiBWUkFNIGZvciBwYWdlIHRhYmxlcyBiZWNhdXNl
IHdlIGNhbm5vdCBvdmVyc3Vic2NyaWJlIAptZW1vcnkgd2l0aGluIGEgcHJvY2VzcyBhbmQgd2Ug
d2FudCB0byBhdm9pZCBjb21wdXRlIHByb2Nlc3NlcyBldmljdGluZyAKZWFjaCBvdGhlciBiZWNh
dXNlIHRoYXQgd291bGQgbWVhbiB0aHJhc2hpbmcuIFRob3NlIGxpbWl0YXRpb24gZG9uJ3QgCmFw
cGx5IHRvIGdyYXBoaWNzIGNvbnRleHRzLgoKUmVnYXJkcywKIMKgIEZlbGl4CgoKT24gMjAxOS0x
Mi0wNSA1OjUwIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cgo+IFNvcnJ5LCBqdXN0IGZv
cmdvdCB0byBhZGQgdGhlIG1haWxpbmcgbGlzdC4KPgo+IEFtIDA1LjEyLjE5IHVtIDExOjQ5IHNj
aHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4gSGkgZ3V5cywKPj4KPj4gSSd2ZSBzZWVuIHNvbWUg
cGF0Y2hlcyBmbHlpbmcgYnkgdG8gY2hhbmdlIGhvdyBtdWNoIFZSQU0gaXMgcmVzZXJ2ZWQgCj4+
IGZvciBwYWdlIHRhYmxlcyBpbiB0aGUgS0ZELgo+Pgo+PiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRv
IGZ1bGx5IG1vdmUgdGhhdCBpbnRvIGFtZGdwdV92cmFtX21nci5jPwo+Pgo+PiBSZWdhcmRzLAo+
PiBDaHJpc3RpYW4uCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
