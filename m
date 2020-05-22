Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7198FC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350CC20723
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QpGta8wP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350CC20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6FA26E0F0;
	Fri, 22 May 2020 19:43:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C8A76E0F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 19:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2me3UQx+UP0WTYT5YacLF/wtAfGVK3BOO+TCK0iV657mjLc2+dToPIbD2phCxRPmLw+DQ6dolJxwYEWkH/MC+vDqYoMW3L+sWCwMPFhb5S7l3vbffzNwHJY4AfWhi67tl3gkbTcMt08qlmIG4QSuuUvtCtvoP7nMQpGO+qUa7CGTw0AOuyHVrA8yYyYpPpuvUQJkPiPmMQEqCYa56BZYav0cBvilVTIB+tThE8rkjNmsnsW905090hjPGMMRXDMSIIWC62eyLL/xcDFt1haoPxlLD4jF8j6pe/8Jf2H0o4jTPFhUzi0r5J8R61YRR2jU4hs0ZZLCKpB6Lyfllp0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94UEt84TWZyk5H+KzXxwVLbfXhSt6ASybgufKV31XBo=;
 b=ADpd7iGLSihQgkLovPPHSyCTpPtLRxHg5c3/e6RtG8lBmi8Nree+0rsvY2jezwzm+cYVzSc9RDca1Y8Rj66svs7PM3KTDR419J1RKdQ9mRoqLgkr+sy7mpdn8kqnQWoqSR3XU/kPVwQe4kGl7dBA0G4Hp9uy0e7kiOiJOnTDZ6Y4n172a6oOqPqJT7z8MYG4LNwLHBqsRsw/ox2C7BxGLjg7cUnue0I2PiPAZEdNEuPrvWM9ot0mDqdu3hkU6vB/ZoZBC0kexFAHE46zYWCqOr9L140i+yU/xn3JWZV1PQED7SwwMJDXKpXs0sj1YeMeO0xH9F5wce+he74gxdgJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94UEt84TWZyk5H+KzXxwVLbfXhSt6ASybgufKV31XBo=;
 b=QpGta8wP3elDj20I1aKLC9tQ8oKFly96H3rvILjrBdBz7M8VpAtLnzKPPz4JRGisyAr6lW3eyHFAAeSjoykoZRYLrJ5bW5cIjwCN3xbIXdMU9CAlj37NMGokm6IM3D7mDQCOjhfCnaAXnKwSYcy5xL7I6wK3Pv7fDb//EfEZ0PM=
Authentication-Results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Fri, 22 May
 2020 19:43:45 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3000.034; Fri, 22 May 2020
 19:43:45 +0000
Subject: Re: [PATCH] drm/amdgpu: fix leftover drm_gem_object_put_unlocked call
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
References: <yNYwUfXpw0k-V5poEVGOZXgeP4zwnuUn8MEJYolwxL7VXfEa99STFAtLPlqlbElXGpqH5a5oyozz4XfnSRg1DCFzqYFbEHTiF5UtwGAmviA=@emersion.fr>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <eeb3aeb5-287f-7881-dd12-620637a41027@amd.com>
Date: Fri, 22 May 2020 15:43:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <yNYwUfXpw0k-V5poEVGOZXgeP4zwnuUn8MEJYolwxL7VXfEa99STFAtLPlqlbElXGpqH5a5oyozz4XfnSRg1DCFzqYFbEHTiF5UtwGAmviA=@emersion.fr>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::16) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 19:43:44 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4621891c-18db-4a6e-99d1-08d7fe88701c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB236699FAC1A6D7487EAC3DCF92B40@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dva220h+BnSlN8CWnEPqFePMri17w5Y9EXCqLV8UuHn9bMXt7U9fKw+fQrtFhn7Tk5kmW+eRSXBlt113KBJAP7d/ZgzWSvEhBo3UWdTeGoJHKO8VycrQ+nJeyMQWZ0W9GCkzMo2aa9DcSHpM/1barKLFNA/lnFDt8pMEi983BaCackEV4mecnj5RrE3CAkwC+vOIsEeKO9xukrkbCLcOYrS2OLMAmfygXRCQqYRLtwtjlVdryOhGfBScowTHnEZdxCngO+D0wfOws8oXJPpLUB4PLrB3UfFUI/g52QlAsdZ3g/mb2mD0Pywjp36Dxa07ZjrdfJSvFjvfvMHUwriv31i0fQsohlh+U/Rc61pb+xur32UwB23Vsqr4YCslnf6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(2906002)(86362001)(316002)(5660300002)(16576012)(54906003)(478600001)(52116002)(110136005)(26005)(36756003)(31696002)(186003)(16526019)(66574014)(8936002)(44832011)(6636002)(956004)(2616005)(8676002)(31686004)(4326008)(66556008)(66946007)(66476007)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +tpQ1YZs43O29keajtGr5tM65hPLQ6XBCHbd0BC3BnXoy7GclW7a07R0uqdG3ZkAyvFXSRIR8QdxgJQX8CIj0V9wWbr0IxfF+BNszo0lVJHzLAvRQWyJ6tjExUP+ycjbQEZh7YxM+7PzsfZDxLe4xXJROxLUqYEqdkq8hozIWw205RjuRY5pLTiKs1M5dtle9qbcOz9Ob5fVYtayo+M1gLY6IWEkTLTaly/wWIx7h0ufX3VCQmwhXW9wlX6rHUJ0uTyC4IpsQzHHP8vLn52pYkFDMsjZZEDp+0b+x44gKKjQOMzHXpxnqubfIftHt0Qu7YG/DkrtAzdNhoOeqJABmoHrPeIGoUzizKvveWiUlufLfEGRRWMfowRL63Lt77JHq721V0dOkoiCgG/hEeNp3+Ccy6BizAOxGX6q0Ocf15AtUzs/ZM59O4VGwRQcw6Rn7W6K/s+YX3RPi7aYdzztjnsAS1oVzTR1eu8gYhYT0GnhMWW64vTF7ufggSV4GQu2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4621891c-18db-4a6e-99d1-08d7fe88701c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 19:43:44.8363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpJr4oJcc0k2laJlxJrn2R8p7jtwJOefQbdKDAdjpzh7PKfFtuBjTPr9mvIUn1H6RvuUDEMu2aNlbGrY6TAuUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
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
Cc: David Zhou <David1.Zhou@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMC0wNS0yMiB1bSAzOjM4IHAubS4gc2NocmllYiBTaW1vbiBTZXI6Cj4gZHJtX2dlbV9v
YmplY3RfcHV0X3VubG9ja2VkIGhhcyBiZWVuIHJlbmFtZWQgdG8gZHJtX2dlbV9vYmplY3RfcHV0
LgoKQWxleCwgSSBndWVzcyB5b3UnbGwgbmVlZCB0byBhcHBseSB0aGlzIHBhdGNoIHdoZW4geW91
IGluY2x1ZGUKZTA3ZGRiMGNlN2NkIGluIGEgcHVsbCByZXF1ZXN0IHRvIERhdmUgQWlybGllLiBJ
IGRvbid0IHRoaW5rIGl0IG1ha2VzCnNlbnNlIHRvIGFwcGx5IHRoaXMgb24gYW1kLWtmZC1zdGFn
aW5nIHVudGlsIHRoZSBicmFuY2ggZ2V0cyByZWJhc2VkIGFnYWluLgoKUmVnYXJkcywKwqAgRmVs
aXgKCgo+Cj4gU2lnbmVkLW9mZi1ieTogU2ltb24gU2VyIDxjb250YWN0QGVtZXJzaW9uLmZyPgo+
IEZpeGVzOiBlMDdkZGIwY2U3Y2QgKCJkcm0vYW1kOiByZW1vdmUgX3VubG9ja2VkIHN1ZmZpeCBp
biBkcm1fZ2VtX29iamVjdF9wdXRfdW5sb2NrZWQiKQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgKENodW5NaW5nKSBaaG91IDxEYXZpZDEuWmhvdUBh
bWQuY29tPgo+IENjOiBFbWlsIFZlbGlrb3YgPGVtaWwudmVsaWtvdkBjb2xsYWJvcmEuY29tPgo+
IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMg
fCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
Z3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0u
Ywo+IGluZGV4IGRhOGIzMWE1MzI5MS4uYzk5ZmI5MmFlOTkxIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+IEBAIC0xMzU0LDcg
KzEzNTQsNyBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9mcmVlX21lbW9yeV9vZl9ncHUoCj4g
IAl9Cj4gIAo+ICAJLyogRnJlZSB0aGUgQk8qLwo+IC0JZHJtX2dlbV9vYmplY3RfcHV0X3VubG9j
a2VkKCZtZW0tPmJvLT50Ym8uYmFzZSk7Cj4gKwlkcm1fZ2VtX29iamVjdF9wdXQoJm1lbS0+Ym8t
PnRiby5iYXNlKTsKPiAgCW11dGV4X2Rlc3Ryb3koJm1lbS0+bG9jayk7Cj4gIAlrZnJlZShtZW0p
Owo+ICAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
