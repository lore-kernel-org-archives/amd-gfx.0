Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC31C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 17:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27FA320674
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 17:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FA320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDAB089322;
	Mon, 25 Nov 2019 17:07:36 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720089.outbound.protection.outlook.com [40.107.72.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6C689322
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 17:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loR1mh9K3qDwj58zNh3ys8PwF84G5qZKtwnQVPMIdy/ys6V1Wc58LaVdtXvtxqCE3dtpDPWco92aaZtOq0TdpMRmaNTND57F2Y7LRWkVVX2ecg4p6jgHn/mojp9wIQ4B8adhZN5o56HG0K5KS/Dn8Krfd39teFiWcYqUr3shXhe3QmtCvPD3vF3RyP89n9YrzBazLDV1D0UqAISFdk0es3g3X6umhFIyqyloODI0lQHVvJwArQYznuZp/X+qeM8A6VwW0h3MdANUx2E+zyLSXgFWe4Dfq8J0H8d7XYtBIOD/dUBl89krMhCHvKGXp+9F4Vm3ybJHNLYfnuJrlXVr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwYXoxs7zNz8SdHt1i01JL4GNQ3MLXINkI5QbsDyS28=;
 b=B3/5PLEZG4aPAtZ8UNwI4wskJ7bJrUGq7XR+Vc6M6mDFuVsn2ZA1A7QL6e8HNehiSsI82CvX+TK8IkQQ5NQVQ1yM+GtuihpUNDn0LzSUQ1kEbfmKAL0nlyUuu/yEt35pJu0S94iMmDH/dgHQtBQqSfWjuDp56CiqYsoXBpNFbKSoPubxMd4rT/Gtji1h7c11yPS03YDRVxmYpWgWMbHNMLq6qh7bnLdfXuqaU83uMlPXjtSwP+Q1B0wjHq1i3ZyrsRXdr7CNMURJoXp8EdWnczVMLkBHBEHfJARfdMmokze+aWxb0T8eWUf9Rl8IclJDo21Sk/4xdkZ3y6svjt6Rrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB4123.namprd12.prod.outlook.com (10.141.187.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Mon, 25 Nov 2019 17:07:33 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 17:07:33 +0000
Subject: Re: [PATCH 1/1] amdgpu: Enable KFD on POWER systems
To: Timothy Pearson <tpearson@raptorengineering.com>,
 amd-gfx <amd-gfx@lists.freedesktop.org>
References: <2068915477.1923611.1574622916022.JavaMail.zimbra@raptorengineeringinc.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <44175d39-e507-83f9-6596-cbde108dd65a@amd.com>
Date: Mon, 25 Nov 2019 12:07:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <2068915477.1923611.1574622916022.JavaMail.zimbra@raptorengineeringinc.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::46) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c058658-71b3-4c44-3691-08d771c9f64e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41232B71CCFC3F955C93C7D4924A0@DM6PR12MB4123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(189003)(199004)(36756003)(8676002)(14444005)(52116002)(2486003)(23676004)(6116002)(2906002)(316002)(31696002)(58126008)(6512007)(25786009)(7736002)(36916002)(229853002)(26005)(44832011)(446003)(99286004)(11346002)(4001150100001)(76176011)(6506007)(386003)(305945005)(478600001)(31686004)(66066001)(65806001)(65956001)(47776003)(2616005)(8936002)(53546011)(186003)(110136005)(81156014)(6436002)(6246003)(81166006)(14454004)(66946007)(86362001)(3846002)(6486002)(2870700001)(66556008)(66476007)(50466002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4123;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHIXd68oyYhvNr8syVG0sRR9yh6u9glp13z1O2GtArpVWm7RCh8xdKvENJtYTT90mDWEqOYs7hN0WnbLZjhPMyvuw+8PoBWKqlsOWqOLpRTkeXVUMokehQRiDcmcQO2RX/ipqKesls/jbvJzw2tabhP/gDtDFua6c6+mEPtOpJ2nrDdgQR65cZyudktXsxza5IHcA8KlL7rmzRZEastUwWJrXdu7z05QGfi8g0a/tL2F2Vqmku1/16dZKbPBwxH6v+bS7Ch9Nu4gX7D5BwH+zfPzEr0K1T7OZY5dBlKf2TLDDOZ02OdzkBI5lopvcnrScPIoizHBD2cOXn/yrjj/XU+6NfyxKQVPPgQ20/Ne9/2GLYKYvc6snJi60h9R71Yt5EQuAM7cVWd9fpxDMrlTgdVp9o/La0Ghw7ySXJar3A9Di2tDH2lwNG8ROUY1as5m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c058658-71b3-4c44-3691-08d771c9f64e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 17:07:33.2979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RBhr5qW/UYu42xqcLH3sZNfSYxvva6Tp6MhVIYGSrlC4tv6LidwROn6y6XFHFTkxExkSZY/6YYo0g4wYXNQWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwYXoxs7zNz8SdHt1i01JL4GNQ3MLXINkI5QbsDyS28=;
 b=NSd3EplD7z6kjEzfTZum+GTPA/9mJvyR33b/K46S7B62R4pDQwfjZS5lKvj7PwdlTCcTr3vY6F2mapFWz2VmN1QCZKXryLPQqST5NTee/iVJBEY4Y0fdUmEXy4+LawYGgByfjobkOcbH/6/wXCtofc56AWa6XE5T1wFtwxOT5iw=
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
Message-ID: <20191125170731.acBohij0uufonYFHnpi-xcYiVYMxxu8DbCFWAE5-k2A@z>

SGkgVGltb3RoeSwKClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoIGFuZCBmb3IgY29uZmlybWluZyB0
aGF0IGl0IHdvcmtzLiBXZSBkaWQgc29tZSAKZXhwZXJpbWVudGFsIHdvcmsgb24gUG93ZXI4IGEg
ZmV3IHllYXJzIGFnby4gSSBzZWUgdGhhdCBUYWxvcyBJSSBpcyBQb3dlcjkuCgpBdCB0aGUgdGlt
ZSB3ZSB3ZXJlIHdvcmtpbmcgb24gUG93ZXI4IHdlIGhhZCB0byBhZGQgc29tZSAjaWZkZWYgCkNP
TkZJR19BQ1BJIGd1YXJkcyBhcm91bmQgc29tZSBBQ1BJLXNwZWNpZmljIGNvZGUgaW4gS0ZELiBE
byB5b3Uga25vdyB0byAKd2hhdCBleHRlbnQgQUNQSSBpcyBhdmFpbGFibGUgYW5kIHdvcmtpbmcg
b24gdGhlIFBvd2VyIGFyY2hpdGVjdHVyZT8KCkFub3RoZXIgcHJvYmxlbSB3ZSByYW4gaW50byB3
aXRoIFBvd2VyLCBpcyB0aGUgcGh5c2ljYWwgYWRkcmVzcyBtYXAuIApTeXN0ZW0gbWVtb3J5IGNh
biBiZSBhIHBoeXNpY2FsIGFkZHJlc3NlcyBvdXRzaWRlIHRoZSByYW5nZSBhY2Nlc3NpYmxlIApi
eSB0aGUgR1BVLiBWZWdhIGhhcyA0NC1iaXQgcGh5c2ljYWwgYWRkcmVzc2luZy4gT2xkZXIgUG9s
YXJpcyBHUFVzIG9ubHkgCmhhdmUgNDAtYml0cy4gRGlkIHlvdSBydW4gaW50byBhbnkgc3VjaCBw
cm9ibGVtcz8gRG8geW91IG5lZWQgYW4gSU9NTVUgCnRvIG1ha2Ugc3lzdGVtIG1lbW9yeSBhY2Nl
c3NpYmxlIHRvIHRoZSBHUFU/CgpSZWdhcmRzLAogwqAgRmVsaXgKCk9uIDIwMTktMTEtMjQgMjox
NSBwLm0uLCBUaW1vdGh5IFBlYXJzb24gd3JvdGU6Cj4gS0ZEIGhhcyBiZWVuIHZlcmlmaWVkIHRv
IGZ1bmN0aW9uIG9uIFBPV0VSIHN5c3RlbXMgKFRhbG9zIElJIC8gVmVnYSA2NCkuCj4gSXQgc2hv
dWxkIGJlIGF2YWlsYWJsZSBhcyBhIGtlcm5lbCBjb25maWd1cmF0aW9uIG9wdGlvbiBvbiB0aGVz
ZSBzeXN0ZW1zLgo+Cj4gU2lnbmVkLW9mZi1ieTogVGltb3RoeSBQZWFyc29uIDx0cGVhcnNvbkBy
YXB0b3JlbmdpbmVlcmluZy5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9LY29uZmlnIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2Nv
bmZpZyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKPiBpbmRleCBhMWEzNWQ0
ZDU5NGIuLmJhMGU2ODA1N2E4OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9LY29uZmlnCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2NvbmZpZwo+
IEBAIC01LDcgKzUsNyBAQAo+ICAgCj4gICBjb25maWcgSFNBX0FNRAo+ICAgCWJvb2wgIkhTQSBr
ZXJuZWwgZHJpdmVyIGZvciBBTUQgR1BVIGRldmljZXMiCj4gLQlkZXBlbmRzIG9uIERSTV9BTURH
UFUgJiYgKFg4Nl82NCB8fCBBUk02NCkKPiArCWRlcGVuZHMgb24gRFJNX0FNREdQVSAmJiAoWDg2
XzY0IHx8IEFSTTY0IHx8IFBQQzY0KQo+ICAgCWltcGx5IEFNRF9JT01NVV9WMiBpZiBYODZfNjQK
PiAgIAlzZWxlY3QgTU1VX05PVElGSUVSCj4gICAJaGVscApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
