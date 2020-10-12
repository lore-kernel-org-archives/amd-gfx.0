Return-Path: <SRS0=L/30=DT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F72C433E7
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 06:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5717A206DC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 06:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hZQuxd1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5717A206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1ADD6E040;
	Mon, 12 Oct 2020 06:42:07 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760071.outbound.protection.outlook.com [40.107.76.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403E16E040
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2020 06:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo4zgLeP6R+8UD7WV1+JfPuxgl3Hr0os4hu1DcdopOcxHZ89SUXoQinoj+cVl2x91jwyZyrGA2Kod6iW+bPeBmatMqJKsk+JwwDecnb8o3EKQbPAA4mIND3VZZUcRT3yUi9E+HpXIYoaK5UV9QegtCnhSRnB2RLLlFH0yjhLXHTZ/pw6jPY5+jHOIDzzzyZO+UTKq1X84mQqmHt8/mZwTPH6eoZtRt0pCbl6HZm2vP5kL/z3IJab+OOjkCbQUPiDhogNV/0vctl+AmifYfdliPzDh6hMkRNc6FrnTP/L8olMx5bfYyr8fIQyZC8fSJ+vxME/CX8qnB9EtzYrCRENoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIp8A+Ne17vn0qFDSqIYo1nDQBG9fFL79PjIw5qrmO8=;
 b=CFke+t6Ayd8t7eaSaYQH/WJnr8aUuiuox2mfn3HHaVrBDoA4068jAjq5D0jdDXp9PnYp5YT2pKxYMT1ceKG8oVEdgCuuJGJrfrW870QbihFLQVRUE5TVqAdvVJEFD8rG3CweARZfbOMZEo2bXUC/eumpFn5WXfyMQsvh/JAuTb27JcZuG5JF6LMk3xf32o7K2DXoHU57M9t0JinIIEU0wWPnhL5ODh4xx/aSDWQ/IQbUdEWUGBBEazJbM0JCvdot8nzRE+QS1RA9Hteh3xMx70nh+mCqVzUOkGplx+d7KsfCB041xcxqw26d0eUzjnMls5oMGZ8j972oEjB5hxVvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIp8A+Ne17vn0qFDSqIYo1nDQBG9fFL79PjIw5qrmO8=;
 b=hZQuxd1HwOElGJf1X2KhylpvN4/3BtNEJd72uG/2ba0fNcIAum4lajDHGtHmazqZsR0mcO+Ctk+KEBV6PMIlTyfc93nh3Daki4I6BtBPSnppfY5D3pz+7u3043bjAqRAO1EQdxx1uFJZP/qNv3wOZaJ+h/D9QwqhJWwfT+ECBmc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 06:42:04 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 06:42:04 +0000
Subject: Re: [PATCH v3] amd/amdgpu: Fix resv shared fence overflow
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201012061414.5160-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f2b5b24b-9d1e-442e-f296-519047670987@amd.com>
Date: Mon, 12 Oct 2020 08:41:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201012061414.5160-1-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR10CA0047.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend
 Transport; Mon, 12 Oct 2020 06:42:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a433d776-d8c1-49da-5fd5-08d86e79ee10
X-MS-TrafficTypeDiagnostic: MN2PR12MB4520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB452002FCFC2A1A15F74A03EA83070@MN2PR12MB4520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUqAYTLlWP5U+CLHr/rL0+17KVp8p1IT/wPgA9sxuD9loYqn+glRjT7HfznxVBsO2xF4yiVWCNMSIiVgKfBi3pxhrYNS2jSVPl2pD+znWFL/XKleVGCIG8zAg0keaarDEzO7QoH+3n6Hf9Bwulvs/FwjRhsLWweJFqutQL97N3GYkTxt8oaCOXcR+GvO+hCjJfMeNys4MM+vKGtsZ4JosP/3GLfbrYZX4f1GwBPxaLnmRtAHpdCFbFugZdHFiNy659aK3AoHXgdDBZPpSlf213pdR3ebmw+KONF6BbD2a6XOr4Q8l5ymr3VDHtjQynONVqKhEdSFpDd/Bx9J8mnnD/JOyaHabV6rSa7EzsR3fvJUoOYLujl8nxg0ruEnYzVH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(66574015)(36756003)(52116002)(6666004)(316002)(8676002)(2906002)(5660300002)(6486002)(83380400001)(31696002)(478600001)(2616005)(86362001)(66476007)(186003)(16526019)(8936002)(66556008)(4326008)(66946007)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: obGbh/2oWV3of/0xA585/XWggBhCltLM8eWXebJdq+41ASLOtIvghBrWWW5DQmbfIVFPAWqVErK7qHerMvaJnaTV7H6h1I0W7anjw1NNaNbfRpj2TC1mzuKXqxkmc6A9+nFTjtQZGwO0l5bQET9pkxdz13ycQYXPgsg5EYJXQ8XVGARaG9s0vzXsWpfZsribJqcYabc3y1642Ys/j5qWXLDcl871YHWA3rjqsCwa9GITW2XmJ9v8UGuWAYoemHC2ppSt4fkKNVYli5+PqtSmQlE5lq9SgsbXxdGT3/zQLTaiNb2daWtxbjtGRXpxEumYmNiXODfVBMtaS5YogTLEK8+H6woS8TmeMoxo4pQGhLjdyjlju6t3/p2wRi2ltNS/CFnl5DttucwNOMNL0q8iXbgXOAgPjoMsdgs6VV4qHZKTdBRCrCad9ft++62NYOpnh6eHMg5+wpYN5qVs3fnqXmwywB7J/HM4MPkyt8wKGkr9/v6w/kPjXhwA+oJ3NUAYajTnUqcNpIGtgdLyP20wfyxZTCeyeznslCONCcyA8mYgIjl65gB4j8RybAyFxiBWYZYAxRZ46s8VgkFJnwuVGa+ARQme2DOw1zVgIzQS2NkX75bmqPnsV//VLYG72JiQjSaWC7VKD2kXXtUfH9OKxeA5/AKab/TB6QU26mNhbk+ZiXxoL9wAe4k1kA5CJf5hd3TAIE7a6ngl/N/ymixhrg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a433d776-d8c1-49da-5fd5-08d86e79ee10
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 06:42:03.9352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Y0+ipvMSD9iXtRRQJ+gecQsY4uwPpWgpqFoHRc+RfG0janPSHsuagILroUG40A2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTIuMTAuMjAgdW0gMDg6MTQgc2NocmllYiB4aW5odWkgcGFuOgo+IFsgIDE3OS41NTY3NDVd
IGtlcm5lbCBCVUcgYXQgZHJpdmVycy9kbWEtYnVmL2RtYS1yZXN2LmM6MjgyIQo+IFtzbmlwXQo+
IFsgIDE3OS43MDI5MTBdIENhbGwgVHJhY2U6Cj4gWyAgMTc5LjcwNTY5Nl0gIGFtZGdwdV9ib19m
ZW5jZSsweDIxLzB4NTAgW2FtZGdwdV0KPiBbICAxNzkuNzEwNzA3XSAgYW1kZ3B1X3ZtX3NkbWFf
Y29tbWl0KzB4Mjk5LzB4NDMwIFthbWRncHVdCj4gWyAgMTc5LjcxNjQ5N10gIGFtZGdwdV92bV9i
b191cGRhdGVfbWFwcGluZy5jb25zdHByb3AuMCsweDI5Zi8weDM5MCBbYW1kZ3B1XQo+IFsgIDE3
OS43MjM5MjddICA/IGZpbmRfaGVsZF9sb2NrKzB4MzgvMHg5MAo+IFsgIDE3OS43MjgxODNdICBh
bWRncHVfdm1faGFuZGxlX2ZhdWx0KzB4MWFmLzB4NDIwIFthbWRncHVdCj4gWyAgMTc5LjczNDA2
M10gIGdtY192OV8wX3Byb2Nlc3NfaW50ZXJydXB0KzB4MjQ1LzB4MmUwIFthbWRncHVdCj4gWyAg
MTc5Ljc0MDM0N10gID8ga2dkMmtmZF9pbnRlcnJ1cHQrMHhiOC8weDFlMCBbYW1kZ3B1XQo+IFsg
IDE3OS43NDU4MDhdICBhbWRncHVfaXJxX2Rpc3BhdGNoKzB4MTBhLzB4M2MwIFthbWRncHVdCj4g
WyAgMTc5Ljc1MTM4MF0gID8gYW1kZ3B1X2lycV9kaXNwYXRjaCsweDEwYS8weDNjMCBbYW1kZ3B1
XQo+IFsgIDE3OS43NTcxNTldICBhbWRncHVfaWhfcHJvY2VzcysweGJiLzB4MWEwIFthbWRncHVd
Cj4gWyAgMTc5Ljc2MjQ2Nl0gIGFtZGdwdV9pcnFfaGFuZGxlX2loMSsweDI3LzB4NDAgW2FtZGdw
dV0KPiBbICAxNzkuNzY3OTk3XSAgcHJvY2Vzc19vbmVfd29yaysweDIzYy8weDU4MAo+IFsgIDE3
OS43NzIzNzFdICB3b3JrZXJfdGhyZWFkKzB4NTAvMHgzYjAKPiBbICAxNzkuNzc2MzU2XSAgPyBw
cm9jZXNzX29uZV93b3JrKzB4NTgwLzB4NTgwCj4gWyAgMTc5Ljc4MDkzOV0gIGt0aHJlYWQrMHgx
MjgvMHgxNjAKPiBbICAxNzkuNzg0NDYyXSAgPyBrdGhyZWFkX3BhcmsrMHg5MC8weDkwCj4gWyAg
MTc5Ljc4ODQ2Nl0gIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMwCj4KPiBXZSBoYXZlIHR3byBzY2hl
ZHVsZXIgZW50aXRpZXMsIGltbWVkaWF0ZSBhbmQgZGVsYXllZC4KPiBTbyB0aGVyZSBhcmUgdHdv
IGtpbmRzIG9mIHNjaGVkdWxlciBmaW5pc2hlZCBmZW5jZXMuCj4gV2UgbWlnaHQgYWRkIHRoZXNl
IHR3byBmZW5jZXMgaW4gcm9vdCBibyByZXN2IGF0IHNhbWUgdGltZS4KPgo+IFdlIGhhdmUgcmVz
ZXJ2ZWQgdGhlIGRlbGF5ZWQgc2hhcmVkIGZlbmNlIHNsb3QgZHVyaW5nIHZtIGluaXQgYW5kIGJv
Cj4gbW92aW5nLgo+IEJ1dCBsb29rcyBsaWtlIHdlIGZvcmdldCB0byByZXNlcnZlIHRoZSBpbW1l
ZGlhdGUgc2hhcmVkIGZlbmNlIHNsb3QKPiBkdXJpbmcgdm0gZmF1bHQuCj4KPiBTaWduZWQtb2Zm
LWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMyArKysKPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
Cj4gaW5kZXggM2NkOTQ5YWFkNTAwLi5hNzM3MjMyY2ViMzggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0zMzUyLDYgKzMzNTIsOSBAQCBib29sIGFtZGdw
dV92bV9oYW5kbGVfZmF1bHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIGlu
dCBwYXNpZCwKPiAgIAlpZiAoIXZtKQo+ICAgCQlnb3RvIGVycm9yX3VubG9jazsKPiAgIAo+ICsJ
aWYgKGRtYV9yZXN2X3Jlc2VydmVfc2hhcmVkKHJvb3QtPnRiby5iYXNlLnJlc3YsIDEpKQo+ICsJ
CWdvdG8gZXJyb3JfdW5sb2NrOwo+ICsKPiAgIAlhZGRyIC89IEFNREdQVV9HUFVfUEFHRV9TSVpF
Owo+ICAgCWZsYWdzID0gQU1ER1BVX1BURV9WQUxJRCB8IEFNREdQVV9QVEVfU05PT1BFRCB8Cj4g
ICAJCUFNREdQVV9QVEVfU1lTVEVNOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
