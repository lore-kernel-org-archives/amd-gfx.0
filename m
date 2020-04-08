Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CBDC2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 11:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C91C2076D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 11:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0kg2j5WQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C91C2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106526EA25;
	Wed,  8 Apr 2020 11:08:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9616EA25
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 11:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X42iKMPcTjgTdCo9XHO4ywA2OcbDaXiXE3KGKMPk0vzc5b+Gqt5BLusNAkWVVwqgokKJgMPbWFGGXaoaN2ASw15nIleC2xa8bQSvtMa8pEsYkRKFl1Un5K19+yr7pcAR3hehD38xqjZ7j3F1fHTiebpLmFZwzxRz5j7fhEbng5fsVweJ50ytbgtLDdO3ioGrBl7aFRUU1vyr6gCIfLC7zQOJzjOpFDpxnOzY5me+XRsM6/O1Y/erNSnQle5nrdwodzKdutDroky/U217pI0a1ABGhxdsgbWzQAGaxmwzJo9as+EnierF6rdmgsz9t87Dh1PaSHenjtd0TU5Z1nnrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/sVOJKTkbeoRaxzVyLL0izGQwQfrL19MwBVDEwJSSA=;
 b=U/KmEUscybFPTIjBGZw2D/ZJKWaZPw64xpxsPg6Oe+w0EKJV+msIrsBc54TZrcXdGv6VxNZDXjrNWzBZZg1hm3yuMGdTjyG5nGyz2Ccy6f2kk4yvRTs5+g++BnJ0LgsY2JIjk8hBYDdeHZ/z24M7PL35K6n151LlyBU07D1qFOeTmKNV771tYpO3x3UqABJpZAhKJHQoPfWFHoAwl7tuL6ByMMw1mcbes1rMVZEwzf0afJEOPeuGSkIX1RCl+buMnzYkL8mDoh6u14fFJ+gtHUy6WmGaEASxynl1F7EDI9Nc+RnjOjYBFGXoxrtmPHK84nQjxHPBqe/2oq61G8eAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/sVOJKTkbeoRaxzVyLL0izGQwQfrL19MwBVDEwJSSA=;
 b=0kg2j5WQmnZ+mgS43fkntcu7ONGlOJq0iFS5Aq6taJMuRd04olcAsRD0A7ASidkGxcIask+j2e5uHze7guaTL/WfenTCG2bXfxCYqXHeI/cgHEmKB3ldGw0T2+poCi7yruiqgBqLT2if++SH1yR3zYTseNfAUQPsouFSR3Vm7iU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Wed, 8 Apr
 2020 11:08:00 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c%3]) with mapi id 15.20.2878.023; Wed, 8 Apr 2020
 11:08:00 +0000
Subject: Re: [PATCH] drm/amdgpu: fix out of bounds memcpy
To: amd-gfx@lists.freedesktop.org
References: <20200408101642.30788-1-christian.koenig@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <4f04a90c-c2b3-4ea3-9c9d-ca7e5f9ccd51@amd.com>
Date: Wed, 8 Apr 2020 13:12:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200408101642.30788-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM6P195CA0070.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::47) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f29:c100:f6c5:26b2:4098:809b]
 (2003:c5:8f29:c100:f6c5:26b2:4098:809b) by
 AM6P195CA0070.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16 via Frontend Transport; Wed, 8 Apr 2020 11:07:59 +0000
X-Originating-IP: [2003:c5:8f29:c100:f6c5:26b2:4098:809b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4994aa56-531a-4760-a07c-08d7dbad198e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:
X-Microsoft-Antispam-PRVS: <MN2PR12MB440859BA1AD74B6FACEF1B938BC00@MN2PR12MB4408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(66556008)(52116002)(31696002)(66476007)(2616005)(6916009)(6486002)(316002)(53546011)(2906002)(66574012)(31686004)(8676002)(66946007)(186003)(36756003)(6666004)(81156014)(81166007)(4744005)(16526019)(8936002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHAZbub8K9IJbG5Ox8rP/NPt4jnIOB2mBN/jaQR1nOzkrkdVf6oXjRwiubGhA2RUS4pK6nEcmjaOokBIr2hDrbuVp7KRLKoJ4FWXrC1WXTTLZPuIz9BzM4T8+vuegfdnOyDQInAS7AKCUwPibDAWD7bgzSMKTA3P6CM4FpGjzFcVrWMLXbA4532SBa0schL67d59Wv5onS/jsA2EBsqFo93qPFaW94nLtWn/AG5jwDopGaevbTmwUphl3KNRkb8ig/KQWAiJMRCyngQi8dBB5q7fU7V8k4rvn4lFkHaKjSQkJUS7GbFU4+t8fhIb6FMuLnqrQFswHYkUn6Ea7uTxEy03Wz0C51DcBi2o9g84Iv5MWEQgcLSMg2NMChUmZ1sX4lsTFDCGUX6ukDOkiTw4GRL1kmYCAbeFL23G3+p4+jfbHtUfUHZzbasJr2QT/jvQ
X-MS-Exchange-AntiSpam-MessageData: ZeZgEsRHB+zJQUfSIFPxbFnJTxq+3h30wXneL46V/aEk8UmILm9LctI8yJxx80m65b7L/RCSRXtFvqtzQaoJBRDzmJyv8tJQmimRELgywST5yazipl4yym/3ko7xWncmH+Aexgvxn5qcHLVPlJWP/FXoZ/NQ5cnWTkbI8svgukbfB5EVPgfaKdPyd4dyHMkmdL3NGM4WvwYbp27Xxwf9vQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4994aa56-531a-4760-a07c-08d7dbad198e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 11:08:00.1946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mp36m4nFFbauDNUEUkDK9O+Lwiq5HFzGJh8SN0jvKlbtJhvNknPQq6LBoEjVHMXhIm3py9aRY0Rdv2UeqibPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

Ck9uIDQvOC8yMCAxMjoxNiBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBUaGUgYnVmZmVy
IG5lZWRzIHRvIGJlIHR3byBieXRlcyBsYXJnZXIgd2hlbiB0aGUgbWF4aW11bSBpcyAzMi4KPgo+
IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KCkFja2VkLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+CgoKPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMgfCAyICstCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uYwo+IGluZGV4IDlk
MTc3NjE3MjFkZS4uYzdlNTVmZTE3MGJkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jCj4gQEAgLTg1LDcgKzg1LDcgQEAgaW50IGFtZGdw
dV9mcnVfcmVhZF9lZXByb20oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IGFk
ZHJwdHIsCj4gICAKPiAgIGludCBhbWRncHVfZnJ1X2dldF9wcm9kdWN0X2luZm8oc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCj4gICB7Cj4gLQl1bnNpZ25lZCBjaGFyIGJ1ZmZbMzJdOwo+ICsJ
dW5zaWduZWQgY2hhciBidWZmWzM0XTsKPiAgIAlpbnQgYWRkcnB0ciA9IDAsIHNpemUgPSAwOwo+
ICAgCj4gICAJaWYgKCFpc19mcnVfZWVwcm9tX3N1cHBvcnRlZChhZGV2KSkKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
