Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC77C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 14:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A68F21736
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 14:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A68F21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB9166E91E;
	Fri, 29 Nov 2019 14:29:15 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720084.outbound.protection.outlook.com [40.107.72.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B376E91E
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 14:29:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4t+WkiRTpbo7eKLeyrDkWT7eJIQgKAqbcUPOKnwBS0VVPKi1qXDoh6msQAHJFJE4pVJ4YaWGYFRB+3ScAJIzqY6yB02vF2PzqSbMPfWLXylvwYUmGW79PcfTSl2D+zkYVFhyBZMTXBafaL53XhJpVCD6q9OqvPAuDE8pjqRqq9R8gyuPT4+rGGJjNQkM7gzJT47qMtazu0tkvO91QZ7q5/kztor8aZ4/2SvEeQEEAEaJLt05RhM5aWQN9Jg/sgR5X4WGQ2k7DoWTY/TBcRnDluN9rdg1JGmtWMLIBtNlwngPC0cYX3LtMjAjENzO8Zao7OuWLv6XSyuQWFSSNkBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqrL+XLiXCGZGMFO03Q73X2Pvh49ACi9qYI+3V2Sd/A=;
 b=WaW9tQWC++xfLfWvzxX6YuI87WS0zGgT4boGhqmaccU6R+DVBB0HzMgNTGEglbg8dHNooRdPS/TJZoHnzxGidFHlR0kWl3xXotrT0CDW/9Qmjck3VqCesDYdYvsxEgHwQU4/sVdMkBU90LRXshzBnM5gqjQsMBSEm8O1DEj6k4FUFQKgiSAAJWTDTCiADC3wenPmkQcChWap4XsviFnXxdGGt0HrGnOxtsZtdsqMJZmGTAQp7/ZB8b3YI4UYTfLbIx/NFQ6LT0zyAwzyvRFSw2ePHLffmcgS31+f0XWFjkQyWKIR49f/TdZTmr5dzF8px65wB550KBu77fDFGzTZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1530.namprd12.prod.outlook.com (10.172.34.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 14:29:10 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a%7]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 14:29:10 +0000
Subject: Re: [RFC PATCH] drm/amdgpu: allocate entities on demand
To: christian.koenig@amd.com, alexander.deucher@amd.com, kenny.ho@amd.com
References: <20191125231719.108949-1-nirmoy.das@amd.com>
 <2e514ab3-1582-6508-d81a-cbc2d12f42d7@amd.com>
 <74fd0faf-fd99-e33e-8d7a-95f9bb8be26a@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <4954a31a-dfbb-1432-9ffe-42ad9f89073c@amd.com>
Date: Fri, 29 Nov 2019 15:29:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
In-Reply-To: <74fd0faf-fd99-e33e-8d7a-95f9bb8be26a@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::33) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-Originating-IP: [2003:c5:8f29:a400:f116:b956:c844:95e4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1bc14b22-4d01-4e0a-c22a-08d774d87fbc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1530:|DM5PR12MB1530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1530F03D86E29B092CBE556E8B460@DM5PR12MB1530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0236114672
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(23676004)(2486003)(386003)(52116002)(6506007)(5660300002)(53546011)(46003)(76176011)(4326008)(186003)(66476007)(478600001)(66946007)(2616005)(446003)(11346002)(6246003)(66556008)(99286004)(6512007)(58126008)(14454004)(316002)(229853002)(25786009)(2906002)(6116002)(65956001)(65806001)(4744005)(81166006)(6436002)(81156014)(36756003)(6486002)(8676002)(50466002)(6636002)(6666004)(47776003)(7736002)(2870700001)(31686004)(31696002)(305945005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1530;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlM3VRYEt/eoAhCumOoDOAJfhd3V+OFd0sQDmcEKre7wTa2mAMVhFImqueL1PUBHdkUxLTi5/wj7OKcLwJN/Qv58+k4gfrPevTVpOrUbXB0dfNvVYl3MPjthbAv2Rv6WWpQyliccyBgy/V9YH2WJvEr8PMXpuTdA45WumlExVw5wJPLpr0KlnlbPkA0R/awa4eKK4rI/ckHB6zMF4x2krhnBXp92lrHN/Rth0smHacwLhnK2z8IoOGjwsXYyeE8u1Bbn/IPUzb0raDqFYMJZFQE2mKoPC/Gaaw4MWeAmiIoElORey2m3VrvH1PQuHNb1BkGLsGsNRDRIfbQpfAVD1mbhi76N4zwnJfGfJDx91pRlAgthf5/r9Jx/F+Vp+fkpzCZGgaODGoA+bp7Psgy8ALyMyhEI4myJi5F3CqMGyxxihRwTxIpMyQJpcroIN9XB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc14b22-4d01-4e0a-c22a-08d774d87fbc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2019 14:29:10.2648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZ39t25LqksIQkwLB03487tYDk1Rp07FD5T/GDSZraBiKGFZxjCFp2vCYCv1dpz8YLveLJD+3JfRK+2HfRzKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqrL+XLiXCGZGMFO03Q73X2Pvh49ACi9qYI+3V2Sd/A=;
 b=rM9y1m9R+X5j7FOi2YJhAR2QLPxpP6TBHXjY0QCtmx3PZx1k8OZCdEiLJyxTE7XYMU/S83nC/cO8B2zs/9pAwI62oBqC6ZspxhPfBs5+jC5TqS+UTeXQyTKZuoDqUBpgMz8XaJeVuwzkXnjL9MpWkmdrfJl8dscw4/DwdNehxLg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKT24gMTEvMjYvMTkgMTA6NDUgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3Jv
dGU6Cj4gSXQgbG9va3MgbGlrZSBhIHN0YXJ0LCBidXQgdGhlcmUgbnVtZXJvdXMgdGhpbmdzIHdo
aWNoIG5lZWRzIHRvIGJlIGZpeGVkLgo+Cj4gUXVlc3Rpb24gbnVtYmVyIG9uZSBpczogV2hhdCdz
IHRoYXQgZ29vZCBmb3I/IEVudGl0aWVzIGFyZSBub3QgdGhlIAo+IHByb2JsZW0gaGVyZS4gVGhl
IHJlYWwgaXNzdWUgaXMgdGhlIGZlbmNlIHJpbmcgYW5kIHRoZSBycV9saXN0Lgo+Cj4gVGhlIHJx
X2xpc3QgY291bGQgYWN0dWFsbHkgYmUgbWFkZSBjb25zdGFudCBzaW5jZSBpdCBzaG91bGQgbmV2
ZXIgYmUgCj4gY2hhbmdlZCBieSB0aGUgZW50aXR5LiBJdCBpcyBvbmx5IGNoYW5nZWQgZm9yIGJh
Y2t3YXJkIGNvbXBhdGliaWxpdHkgCj4gaW4gZHJtX3NjaGVkX2VudGl0eV9zZXRfcHJpb3JpdHko
KS4KPgo+IFNvIEkgd291bGQgc3RhcnQgdGhlcmUgYW5kIGNsZWFudXAgdGhlIGRybV9zY2hlZF9l
bnRpdHlfc2V0X3ByaW9yaXR5KCkgCj4gdG8gYWN0dWFsbHkganVzdCBzZXQgYSBuZXcgY29uc3Rh
bnQgcnEgbGlzdCBpbnN0ZWFkLgoKSSBhbSBtaXNzaW5nIHNvbWUgY29udGV4dCBoZXJlLiBDYW4g
eW91IHBsZWFzZSBleHBsYWluIGJpdCBtb3JlPyBJIApsb29rZWQgb3ZlciBhbmQgb3ZlciBhZ2Fp
biBidXQgSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIHdoYXQgZG8geW91IG1lYW4gCmJ5wqAgbmV3
IGNvbnN0YW50IHJxIGxpc3QgOi8KCj4KPiBUaGVuIHdlIGNvdWxkIGVtYmVkIHRoZSBmZW5jZXMg
aW4gYW1kZ3B1X2N0eF9lbnRpdHkgYXMgZHluYW1pYyBhcnJheSAKPiBhdCB0aGUgZW5kIG9mIHRo
ZSBzdHJ1Y3R1cmUuCj4KPiBBbmQgbGFzdCB3ZSBjYW4gc3RhcnQgdG8gZHluYW1pYyBhbGxvY2F0
ZSBhbmQgaW5pdGlhbGl6ZSB0aGUgCj4gYW1kZ3B1X2N0eF9lbnRpdHkoKSBzdHJ1Y3R1cmVzLgo+
Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
