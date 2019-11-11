Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3756C17441
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832ED20578
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832ED20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E966E2B6;
	Mon, 11 Nov 2019 20:20:12 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790047.outbound.protection.outlook.com [40.107.79.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E056E2B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 20:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8XWVvQLTnPfKazLQN1QD2BEfq3u6pTityPogKSsUtAsviPM+r2qRdoBq4Gg8x4C0mBe4zmOiDnHvO6Ts5GJ6to2qsf0DYIMMj4wm34Nbm1M5Y4dUbxxjw9rfHv8uYX06b1FsxzW6ak7MziZTkPxejfKXpXQhGUbsMYO5mkvYbC5rGycTtqZPR0F6sgP6Y45vdavvUxvxJ1n7Zrfw4nXqUB9VNrcq3jXzPkdkvRdAIhaqgDOK6G11SdsXcyquEGqfqdDav47fKBka1OjgNP+06GtsT2Nj9dNMzkhssE1zMKa78TCHEdsUQ1uDb4PPjXREbXcfTDeAxPyMiExU3kGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCw8rHB3snflSmJauxR4FsksQ7ejTbwrIyg41mxj+qk=;
 b=WW04v+EOZ9nqdEzvNUil5XGkIbfvY2jpPSAQFMQdVcnu11989FYvVND1bmTBg5Yt2kLxbIA2TgrvVfD6wIaVsmn0uVR9nzZZG1qf+l5MumIw9rfwn8v7aWMHt+49fxD8z9uJLws4SxaSa88likfuIyxvcUdH0Q/wEPSLWznQb0ZzetCgC4Yysv+C0CEfR8tO0qwwtijXZtPEiU+zhGiMJCrh4WRh5Y8uSG/smve0mrSTZpTURngOdhOVifiGpfEJylgtbWHkrxMcAScZZCZDNfDdbSzE7gR/dfGgH4FdzYmanKgr8yWKXXYiPwdY6tbfaHB//7km40zX/gKiuvJ5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB3324.namprd12.prod.outlook.com (20.178.31.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Mon, 11 Nov 2019 20:20:09 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 20:20:08 +0000
Subject: Re: [PATCH] drm/amdkfd: Rename create_cp_queue() to init_user_queue()
To: "Zhao, Yong" <Yong.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191101201216.6205-1-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <cb865261-1f52-fe8e-88bc-57354e8cff51@amd.com>
Date: Mon, 11 Nov 2019 15:20:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191101201216.6205-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
MIME-Version: 1.0
X-Originating-IP: [142.116.193.252]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 688a4b95-9cf7-4e2e-7736-08d766e48c2a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3324:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3324CA149BCA6F952E931EF692740@DM6PR12MB3324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(26005)(7736002)(305945005)(76176011)(6512007)(229853002)(386003)(50466002)(53546011)(6506007)(11346002)(446003)(186003)(230700001)(6116002)(6486002)(6436002)(66066001)(486006)(65956001)(44832011)(65806001)(2616005)(476003)(2906002)(47776003)(478600001)(14454004)(3846002)(31686004)(8676002)(58126008)(110136005)(8936002)(25786009)(52116002)(36756003)(81156014)(66556008)(66946007)(81166006)(316002)(2501003)(86362001)(6246003)(2486003)(31696002)(5660300002)(23676004)(66476007)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3324;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7H1sGz7YL2oAHjH4/kTi8FkrdUsrW7ovkHI++K5vJKd8wcze0cmTWMNnqFUlJrD/bYt+XIksptgQ9fIuLYgA6WvoekeNGk7eV4ueTkeCzgmzb9EWWWsQ7NHIb1zTqFV2x58lM2ounD/yupDFhBGJvQNqIfu7t9CrFHnyu3yBPtu52kzJtRjHrYqvuU9mNcG1deTVF/fvSC77mF7y8nwNlVh15TzVCM4yv55ItJeRgQOwt/MCnlfyhlA9F270q1cYQxYJdSUxpGZ7P4Gg/HVx0I2ZblM9CSMf15ufWPZEkwF3+OUiqXUcKc1vNxYt2vdFFweoVwLdp5k9vDkSLEtkaBd9+5yJF5oCWdPWCAtqiTdzD0P5ASU5qE5bL+PxKjGHgw37TimpmJxajYP+1mzuyQzKXqfqi987+6W6IeVoUxmZi6xCe9fGGeR3OD9vkmRM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688a4b95-9cf7-4e2e-7736-08d766e48c2a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 20:20:08.9282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9v7wD1miArPdT7YFj5Kmzbh5BMxEzxL+UVCA4hikO01XsZE5PwIxRq8qCbIz6FjVRk8dq7DKz/OcfbBYTAe0nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3324
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCw8rHB3snflSmJauxR4FsksQ7ejTbwrIyg41mxj+qk=;
 b=3wi58T3bn8NJ/RrTeK9VqfUhB4Swj20NL/FSMVu9UwaG1QVeay5pZIP/EKbZ9LgMfD3X7IYBAJdQqwnAn+/mAUj9y3A4G6saoXTd5FnlLjqSAlhUQUdglp+EYkYEXysQTE02fBVzcCkZHfZ2MOVVBfrU3KaI4QVnpgf2Tr4uLWs=
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
Message-ID: <20191111202007.bK1RB-fhY9klkh-RpadWInihYhrG9jIY8zJ1sa7-iz4@z>

T24gMjAxOS0xMS0wMSAxNjoxMiwgWmhhbywgWW9uZyB3cm90ZToKPiBjcmVhdGVfY3BfcXVldWUo
KSBjb3VsZCBhbHNvIHdvcmsgd2l0aCBTRE1BIHF1ZXVlcywgc28gd2Ugc2hvdWxkIHJlbmFtZQo+
IGl0Lgo+Cj4gQ2hhbmdlLUlkOiBJNzZjYmFlZDhmYTk1ZGQ5MDYyZDc4NmNiYzFkZDAzN2ZmMDQx
ZGE5ZAo+IFNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+CgpUaGUg
bmFtZSBjaGFuZ2UgbWFrZXMgc2Vuc2UuIFRoaXMgcGF0Y2ggaXMKClJldmlld2VkLWJ5OiBGZWxp
eCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jIHwgNiArKystLS0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVf
bWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVf
bWFuYWdlci5jCj4gaW5kZXggNDgxODVkMjk1N2U5Li5lYmIyZjY5YjQzOGMgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFu
YWdlci5jCj4gQEAgLTE2Miw3ICsxNjIsNyBAQCB2b2lkIHBxbV91bmluaXQoc3RydWN0IHByb2Nl
c3NfcXVldWVfbWFuYWdlciAqcHFtKQo+ICAgCXBxbS0+cXVldWVfc2xvdF9iaXRtYXAgPSBOVUxM
Owo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbnQgY3JlYXRlX2NwX3F1ZXVlKHN0cnVjdCBwcm9jZXNz
X3F1ZXVlX21hbmFnZXIgKnBxbSwKPiArc3RhdGljIGludCBpbml0X3VzZXJfcXVldWUoc3RydWN0
IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLAo+ICAgCQkJCXN0cnVjdCBrZmRfZGV2ICpkZXYs
IHN0cnVjdCBxdWV1ZSAqKnEsCj4gICAJCQkJc3RydWN0IHF1ZXVlX3Byb3BlcnRpZXMgKnFfcHJv
cGVydGllcywKPiAgIAkJCQlzdHJ1Y3QgZmlsZSAqZiwgdW5zaWduZWQgaW50IHFpZCkKPiBAQCAt
MjUxLDcgKzI1MSw3IEBAIGludCBwcW1fY3JlYXRlX3F1ZXVlKHN0cnVjdCBwcm9jZXNzX3F1ZXVl
X21hbmFnZXIgKnBxbSwKPiAgIAkJCWdvdG8gZXJyX2NyZWF0ZV9xdWV1ZTsKPiAgIAkJfQo+ICAg
Cj4gLQkJcmV0dmFsID0gY3JlYXRlX2NwX3F1ZXVlKHBxbSwgZGV2LCAmcSwgcHJvcGVydGllcywg
ZiwgKnFpZCk7Cj4gKwkJcmV0dmFsID0gaW5pdF91c2VyX3F1ZXVlKHBxbSwgZGV2LCAmcSwgcHJv
cGVydGllcywgZiwgKnFpZCk7Cj4gICAJCWlmIChyZXR2YWwgIT0gMCkKPiAgIAkJCWdvdG8gZXJy
X2NyZWF0ZV9xdWV1ZTsKPiAgIAkJcHFuLT5xID0gcTsKPiBAQCAtMjcyLDcgKzI3Miw3IEBAIGlu
dCBwcW1fY3JlYXRlX3F1ZXVlKHN0cnVjdCBwcm9jZXNzX3F1ZXVlX21hbmFnZXIgKnBxbSwKPiAg
IAkJCWdvdG8gZXJyX2NyZWF0ZV9xdWV1ZTsKPiAgIAkJfQo+ICAgCj4gLQkJcmV0dmFsID0gY3Jl
YXRlX2NwX3F1ZXVlKHBxbSwgZGV2LCAmcSwgcHJvcGVydGllcywgZiwgKnFpZCk7Cj4gKwkJcmV0
dmFsID0gaW5pdF91c2VyX3F1ZXVlKHBxbSwgZGV2LCAmcSwgcHJvcGVydGllcywgZiwgKnFpZCk7
Cj4gICAJCWlmIChyZXR2YWwgIT0gMCkKPiAgIAkJCWdvdG8gZXJyX2NyZWF0ZV9xdWV1ZTsKPiAg
IAkJcHFuLT5xID0gcTsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
