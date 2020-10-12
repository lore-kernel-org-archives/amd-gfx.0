Return-Path: <SRS0=L/30=DT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3089C43467
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 10:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3810D206B6
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 10:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hVu1QjlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3810D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87CF36E283;
	Mon, 12 Oct 2020 10:50:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A506E283
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2020 10:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atkJPo3AUYb3UtFJ4keKkPAuyU61bwXc1IjMpEouMFgQCcSxLThYzgUKB2L5fKPbQ6iauVO7SMym5G265bVZVw/h1lx3reyD1cmo945jyetBBuofG5pGt/5qTvvTO8Va4rduy9lZjmXmpCFGZ65P0BJgg3ATI9PQXTRcWfmrTp8lmLYnkYCtEDlMnln5+JlukyG6dSoKMwhr4GvWmjtGfF5kLQgPxIcDhANI1qENofJO3RVihz+dxX7G5EbdL04N1Z/KWajtzDabUWLE8z/g+czsUsP0+2kQDemwPcAicNInjY4os7Ku9ezA3Lvo2D/3Wh5UhPynik18d7EdEt6T+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq3ymi924RbI76BEgmFoDql9cQ5BLmLyvINWZw1/LIo=;
 b=NdsG7EOdf9ZK7dWrtTHOYvU7Jvf/0cXqH9FtyKBZljuA6MqejzGIoKZeu7CcGSqMRCJKwgkzY0amyTtixiUAzOUr3k7YtZW5yJgxIVHoFWmhU2Isk5z/vtjev/1g6FsP1NX5ssAeLvYRu4YD4iTGSwPSbksGuy7EgvQ7V3lkwrPqNC3JrSvf5GT6mU0UZVNKYeb3I5GwSuKpXjgr7Fy9AOUlrZNsTtc8pWS72BrkO0CmoW2fb0BSu7GrHIVgBIEPTgXErq/+FSa71zGXPMBK18iALn4H5SMc2sqQ2CyEDYHYk+tgPk4IXnbV+zcwJ37eW3ZlfJxX4yoJ4PcB1+sAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq3ymi924RbI76BEgmFoDql9cQ5BLmLyvINWZw1/LIo=;
 b=hVu1QjlD45h2oVlYhio278fKLkVmzCNHzoTyGZCl2WP9LEPAI2mDMH21VLI48mLbafIJ2r4dtgnYpz6tZGvXyEm4dkDrzr4fnblkgYcBoOWGZLUR4FyaGY/MaeWLAokYtXUlS6vF5Rb3fZk7F9l3EE3ZjDoodsrC21ond2OoDtM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3696.namprd12.prod.outlook.com (2603:10b6:208:169::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 10:50:07 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 10:50:07 +0000
Subject: Re: [PATCH v3] drm/amdgpu: Add debugfs entry for printing VM info
To: "Patel, Mihir" <Mihir.Patel@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201012090159.28825-1-mihir.patel@amd.com>
 <d2d63bd0-61a0-33ce-67da-78143412d6b1@amd.com>
 <DM6PR12MB44527C86830BA20463BCFE6BE8070@DM6PR12MB4452.namprd12.prod.outlook.com>
 <64b13a59-f5c1-ff4c-f76a-0e1a00b249a0@amd.com>
 <DM6PR12MB4452CDAE4721D598694241B8E8070@DM6PR12MB4452.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <24df1d90-04ad-e444-306d-7c2e16979b80@amd.com>
Date: Mon, 12 Oct 2020 12:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM6PR12MB4452CDAE4721D598694241B8E8070@DM6PR12MB4452.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:208:69::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR03CA0075.eurprd03.prod.outlook.com (2603:10a6:208:69::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Mon, 12 Oct 2020 10:50:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5b43206-cc89-49bd-bfce-08d86e9c9527
X-MS-TrafficTypeDiagnostic: MN2PR12MB3696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3696D0EA784AFDBB46DE295D83070@MN2PR12MB3696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FMHaWIJuBChwahs2Hs+YCNorVNjrR7BwgEq+g1jOINPA6WsFGzIRJPlgC6TzZk4mtH/e66dZzWKWBym3d9eyFnyfRfNAZuhBeE3PbhJ4f2CGQHOjooJnudOssU5W0A7PLlYtlwSq+r0UCvT5iYFfpS1iSwicemJZgm7gRI1uyxPQd2Y4TtqHOuaiXCMR0R2PpKS9UoJGof/Dfhqm1FCAPITXwJ0QIWvnSHvyd4Ah7cohF0K417w4Xie1Cu32n9oxh3yXgsRw3QyJmRkolmrQqPvstHKd0o7Z7iWTxxoXCPeQKkv4Fr/XwpYVADRKWfPezglhsEYyOttJwCMLe5PI5zIX+4o2GUHwbhXR2+zB2BYQtNqih6O0s2p00KrI6FU4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(66476007)(66556008)(54906003)(36756003)(66946007)(53546011)(2906002)(110136005)(6666004)(6486002)(478600001)(5660300002)(52116002)(31696002)(316002)(83380400001)(4326008)(2616005)(8676002)(186003)(8936002)(31686004)(16526019)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hCIMhVIb12stB4h5HDLgjbDNa8Cts2nqqJkW2DO5b2ddg4g3L7Oo4GdUgtdneS8ndtcIglRtxEV0qYW3nxMtzKGkvq3iyVW3RAiK9i+eFFSzW7J3dRlAfsSVPttXqmoLCwZfIQt0Oi2KTEP/y+W6B1hvJh159F3g8pBSGJ4TTzHTQXvVLTI1Ua6DukSSsNSQTDDsHnHA8H50v9djIZU/hWa+W+1EY69QtAjQNJjpQJPKlmHaxB18Hq1wFTf1bfl4XMIlEke/x3H1jYpUjjMLcg0ng4f/wpf+6ImqhRESKnh0DKNWohQGr5Gbvd126Fkt9TPftC4oRuoCzbWUc3kio2lkT+bJc3LDE7J0Q0QE2sCwiaE2aGhFlNNhW5a6a7b1bRsCeHkuEf+l1sak41oInMswGriLBzN2CtnDQoe9z/Mzr1dmhzcJz9v9WO7ZnPmaeN79PMabYvQGew+u0RJiffGqu+2xo0UL0v2ySJCMUAL/pe4vkFpIjrS/hKna7D1/tAZE32W99i9C852jz8GgES40B0Xzvwv3a7qoNR7DTnsBdX11uznluo/1NmkOpijx2q9O/ndR9rnl5w9jNIlGvkYMkCIsQV/ZhZnMmFnJn6On0RBuzXjKtJWh6m78xPVVP9FWURKQs/6ZzalUEE+8IGSy3pnAlqdLFyJofcZwlWJg+gyi1ZI77eJhzUUa6iPm4VtFwptT0NO2PR2vL74ESg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b43206-cc89-49bd-bfce-08d86e9c9527
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 10:50:07.1117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9uxulTI7VM6EcA7IXqJYnArg9TJ7i1ub2UH9EWUjBX/tkfd2eSz80BIhNxrEUr8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3696
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
Cc: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kamliya,
 Prakash" <Prakash.Kamliya@amd.com>, "Surampalli,
 Kishore" <Kishore.Surampalli@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTIuMTAuMjAgdW0gMTI6MDAgc2NocmllYiBQYXRlbCwgTWloaXI6Cj4gW0FNRCBPZmZpY2lh
bCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQo+Cj4KPgo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT4KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMTIsIDIwMjAgMzoxNCBQTQo+
IFRvOiBQYXRlbCwgTWloaXIgPE1paGlyLlBhdGVsQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IENjOiBDaGF1aGFuLCBNYWRoYXYgPE1hZGhhdi5DaGF1aGFuQGFtZC5j
b20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBTdXJh
bXBhbGxpLCBLaXNob3JlIDxLaXNob3JlLlN1cmFtcGFsbGlAYW1kLmNvbT47IEthbWxpeWEsIFBy
YWthc2ggPFByYWthc2guS2FtbGl5YUBhbWQuY29tPgo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNd
IGRybS9hbWRncHU6IEFkZCBkZWJ1Z2ZzIGVudHJ5IGZvciBwcmludGluZyBWTSBpbmZvCj4KPiBb
U05JUF0KPj4gSGkgQ2hyaXN0aWFuLAo+PiBPbmUgcXVlc3Rpb24gcmVnYXJkaW5nIGdldHRpbmcg
dG90YWwgYWxsb2NhdGlvbnMgYnkgYXBwIGFuZCBhbHNvIHN3YXBwZWQgc2l6ZSBmb3IgdGhlIGFw
cC4KPj4gU2hvdWxkbuKAmXQgd2UgcHJpbnQgbWFwcGVkIGVudHJpZXMgYXMgd2VsbCB0byBnZXQg
dG90YWwgYWxsb2NhdGlvbiBieSB0aGUgcHJvY2VzcyA/Cj4+IEFsc28gd2hpY2ggbGlzdCB3b3Vs
ZCByZXByZXNlbnQgc3dhcHBlZCBtZW1vcnk/Cj4gTm9uZSwgd2UgZG9uJ3QgcmVhbGx5IGhhdmUg
dGhhdCBpbmZvcm1hdGlvbiBhbnl3aGVyZSBzaW5jZSB3ZSBkb24ndCByZWFsbHkgaGF2ZSBhIHN3
YXBwZWQgc3RhdGUuCj4KPiBTZWUgd2hlbiB0aGUgYXBwbGljYXRpb24gYWxsb2NhdGVzIGEgQk8g
aW4gVlJBTSB0aGUga2VybmVsIGRyaXZlciBpcyBmcmVlIHRvIHN3YXAgaXQgb3V0IHRvIEdUVCBh
bmQgc3RpbGwgZG8gY29tbWFuZCBzdWJtaXNzaW9uLiBPbmx5IHdoZW4gaXQgaXMgZnVydGhlciBz
d2FwcGVkIG91dCB0byB0aGUgQ1BVIGRvbWFpbiBpdCBpcyBub3QgYWNjZXNzaWJsZSBhbnkgbW9y
ZS4KPgo+IFNvIHdoYXQgeW91IGNhbiBkbyBpcyB0byBsb29rIGF0IHRoZSBCT3MgaW4gdGhlIENQ
VSBkb21haW4sIGJ1dCB0aGlzIG9ubHkgZ2l2ZXMgeW91IGEgY2VydGFpbiBoaW50IG9uIHdoYXQn
cyBnb2luZyBvbi4KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4gVGhhbmtzIENocmlzdGlh
biBmb3IgY2xhcmlmeWluZyBhYm91dCBzd2FwcGVkIG1lbW9yeS4gSG93IGFib3V0IHRvdGFsIGFs
bG9jYXRlZCBzaXplPyBDYW4ndCB3ZSBwcmludCBtYXBwZWQgQk9zIHNpbmNlIGFtZGdwdV9nZW1f
aW5mbyBpcyBGSUxFL2dlbSBoYW5kbGUgYmFzZWQ/CgpUaGF0J3Mgd2hhdCB5b3UgYXJlIGFscmVh
ZHkgcHJpbnRpbmcuIEUuZy4gaWYgeW91IHN1bSB1cCBhbGwgdGhlIEJPcyBpbiAKYWxsIHRoZSBk
aWZmZXJlbnQgc3RhdGVzIHRoZW4geW91IGhhdmUgdGhlIHRvdGFsIGFtb3VudCBvZiBhbGxvY2F0
ZWQgCm1lbW9yeSBmb3IgdGhpcyBwcm9jZXNzLgoKRXZlbiBpZiBzb21lIG9mIHRoYXQgbWVtb3J5
IGlzbid0IG1hcHBlZCBpbnRvIHRoZSBWTS4KCkNocmlzdGlhbi4KCj4gUmVnYXJkcywKPiBNaWhp
cgo+PiBUaGFua3MsCj4+IE1paGlyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
