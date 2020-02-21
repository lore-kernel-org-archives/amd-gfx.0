Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B3CC35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8B920679
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P9X39OMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8B920679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66BB06F47A;
	Fri, 21 Feb 2020 15:23:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F175A6F47A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 15:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr6DCmifuTaDC99UH4v1WcfJBZuQ+0EkZt8df4kv4p4c0hn207tlvrSXKr4vGE+K31QfGxh47t735n6bXQwp9OKn7BVkyl8b5jXWDiF3lpnReLBbjC9jMPaGV0CuwKrbYWSyOY+W2VM7c+sF9sb3pEdzkQzZElHQfbJSMrZ6eoayqTU4iCXmuRJVlHsM3SoaM2byUof8DNl0p/0b1g/jcnDjNsvZXM/H/Ed6J6le37kVbD+vmlD2lYOK9XSiUtlUZFp1vknpfRXW17rrokkPEOogECsMTS040X1nDey0e/N/aEV8UY4KKyPxpOpP2Vb6JtIvlbW0ss+GFi3VAkDAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWH/C78UIfvq7j9Rjnnv2s1kU5WbOPBYlYecq7OlLRQ=;
 b=ZwepyTroOMPJMg7cdfZCiVL5kQqoA9kyv1HcLy9Rx6FjFGhsLf/iWbAfvtTXEP1RL5jPMGNAXqqiUl10i/bddLAP9yET/OSUa51mWpbD7qGdARzSu9Niofq3NNKrxKJUC85eX81atqfVeO9ujGNmnKTQigph4OlpG3iLAAqBY7YKkF4nsoaHca163tgbrdBc4IeePSlr3wiPzCXCZLCLiEpP0UQ8TN3UvxglxJUKL58az5WlgHUh8JcbNDzIhNpPgRuaRCfAchG0U8FlGDuG/zfkcoPxxGmvKLrhfGMSwU2DI1/0VgM0aK7gYrcO0eib0OhJNMx7D+yI/P2gdasU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWH/C78UIfvq7j9Rjnnv2s1kU5WbOPBYlYecq7OlLRQ=;
 b=P9X39OMaRQCUaVN4AYWhtV3244gs8aI8nJKctUij1eyOToB2IRSUTohCcpqAMul4/LcE0fj7L2uFUXFg9BPx7RoDNCzrmvbTdxgUTrgHDV4rzeOSiin49TieFtJkkbkF/QgAll3WPP+XkBziMaFGMDs2evXnj9gRYx1PbxWX5Yk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4520.namprd12.prod.outlook.com (20.180.247.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 21 Feb 2020 15:23:32 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 15:23:31 +0000
Date: Fri, 21 Feb 2020 23:23:22 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>
Subject: Re: =?gb2312?B?u9i4tDogW1BBVENIXSBkcm0v?=
 =?gb2312?Q?amd=2Famdgpu=3A?= disable GFXOFF around debugfs access to MMIO
Message-ID: <20200221152321.GH28698@jenkins-Celadon-RN>
References: <20200219150417.510884-1-tom.stdenis@amd.com>
 <CADnq5_PaR2a4UCwQFF6y1A1MCqaDAbPbFJZSzdBcTMkRnREw5g@mail.gmail.com>
 <6f93ee3f-4fba-575a-f8eb-0441b0efd4c8@amd.com>
 <20200221143359.GF28698@jenkins-Celadon-RN>
 <DM6PR12MB393101FB6C3250020720509A84120@DM6PR12MB3931.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <DM6PR12MB393101FB6C3250020720509A84120@DM6PR12MB3931.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR04CA0055.apcprd04.prod.outlook.com
 (2603:1096:202:14::23) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR04CA0055.apcprd04.prod.outlook.com (2603:1096:202:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 15:23:29 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e04c4c68-099f-44b0-80eb-08d7b6e20240
X-MS-TrafficTypeDiagnostic: MN2PR12MB4520:|MN2PR12MB4520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45207DF34B694D71092C5E14EC120@MN2PR12MB4520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(189003)(199004)(2906002)(33656002)(8936002)(224303003)(81166006)(6862004)(81156014)(86362001)(45080400002)(9686003)(4326008)(478600001)(55016002)(316002)(966005)(54906003)(956004)(6496006)(66946007)(1076003)(33716001)(26005)(53546011)(6636002)(186003)(52116002)(6666004)(66476007)(66556008)(5660300002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4520;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAUQXYtM9S5yZxpDRo0OgYsL8STk47o9ygznf5cSwUX6Axcgic0fAxm7O1S6lwPsUDli1cH2Rf1a9QFiK3YMjKjEe6qoxa5YvFJ7p03iKNdddmNI/pwB05N+NTcmmz6icQn4dnHS6EGRISCoNAHEA1wHN5c+Q69rcYIKbO9wUr6STD2/AAb4No7dD7LtL/z6aESGYySlceU5iefWmbGBwKFQT4Na+dB9OlhcCG7Zs61e7g/v5e2hSFi3sbx/4RiQG4a4Bxh1PEMVI3eaCrXFpE6VtBQJZgLlxpWYBtkkUivOBKkZhIzirL4/I7ovneJQ7/ZbdDQvvJkLJOt8kjHui0FdYHfXSzH6dVSSkxirBCiKNMgpIS6k0Eye3U7I+fUb/ezu6vFG6jqmCax87z6ySalGmPydYZJ0SN57Qdj6qv18d6BE4UadFgo4VEPAO+YCjNosLJ9GVVzW04QfqOs996+xYSaiVrjs/obuRHQI4AUQWglBtmj+xMCSHuOdYn90BewPnqfaZCKyC6i2g5IMYnFrSUZ0YCijcwpsjJQGw8Aq/mEQdKH0Byfc1XgI1Fa/7i5C3x0rjf+kuVX9p48C970hvvLHqMPaJ6BhCytBcaH52uW2pnaFvYyVllG/6g6Q
X-MS-Exchange-AntiSpam-MessageData: Nx0rLdlFu4n8OrG1GZKn+B+vZ+no1O+zMwzBVE+VvZYCf3Ufe1s+qqsptdyG3onLKXiyW7FRAbIK2qYRH2kgToKb3npNr08rnj1A4qVG50YX9aYPeecV8Ve29vu9T568lSfeKQrwakXdBczLlfAVyQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04c4c68-099f-44b0-80eb-08d7b6e20240
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 15:23:31.8387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqia6hS0D+bOXfVnZps+tOMWnmdBBCCfcPohS9yiGYKs2HfshaFnITAdZdvFEn25wHESJEnB8Hi2iGUU1qVGYw==
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBGZWIgMjEsIDIwMjAgYXQgMTE6MTg6MDdQTSArMDgwMCwgTGl1LCBNb25rIHdyb3Rl
Ogo+IEJldHRlciBub3QgdXNlIEtJUSwgYmVjYXVzZSB3aGVuIHlvdSB1c2UgZGVidWdmcyB0byBy
ZWFkIHJlZ2lzdGVyIHlvdSB1c3VhbGx5IGhpdCBhIGhhbmcsIGFuZCBieSB0aGF0IGNhc2UgS0lR
IHByb2JhYmx5IGFscmVhZHkgZGllIAoKSWYgQ1AgaXMgYnVzeSwgdGhlIGdmeCBzaG91bGQgYmUg
aW4gIm9uIiBzdGF0ZSBhdCB0aGF0IHRpbWUsIHdlIG5lZWRuJ3QgdXNlIEtJUS4KClRoYW5rcywK
UmF5Cgo+IAo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0KPiDlj5Hku7bkuro6IGFtZC1nZnggPGFt
ZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IOS7o+ihqCBIdWFuZyBSdWkKPiDl
j5HpgIHml7bpl7Q6IDIwMjDlubQy5pyIMjHml6UgMjI6MzQKPiDmlLbku7bkuro6IFN0RGVuaXMs
IFRvbSA8VG9tLlN0RGVuaXNAYW1kLmNvbT4KPiDmioTpgIE6IEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPjsgYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz4KPiDkuLvpopg6IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBkaXNhYmxlIEdGWE9G
RiBhcm91bmQgZGVidWdmcyBhY2Nlc3MgdG8gTU1JTwo+IAo+IE9uIFdlZCwgRmViIDE5LCAyMDIw
IGF0IDEwOjA5OjQ2QU0gLTA1MDAsIFRvbSBTdCBEZW5pcyB3cm90ZToKPiA+IEkgZ290IHNvbWUg
bWVzc2FnZXMgYWZ0ZXIgYSB3aGlsZToKPiA+IAo+ID4gW8KgIDc0MS43ODg1NjRdIEZhaWxlZCB0
byBzZW5kIE1lc3NhZ2UgOC4KPiA+IFvCoCA3NDYuNjcxNTA5XSBGYWlsZWQgdG8gc2VuZCBNZXNz
YWdlIDguCj4gPiBbwqAgNzQ4Ljc0OTY3M10gRmFpbGVkIHRvIHNlbmQgTWVzc2FnZSAyYi4KPiA+
IFvCoCA3NTkuMjQ1NDE0XSBGYWlsZWQgdG8gc2VuZCBNZXNzYWdlIDcuCj4gPiBbwqAgNzYzLjIx
NjkwMl0gRmFpbGVkIHRvIHNlbmQgTWVzc2FnZSAyYS4KPiA+IAo+ID4gQXJlIHRoZXJlIGFueSBh
ZGRpdGlvbmFsIGxvY2tzIHRoYXQgc2hvdWxkIGJlIGhlbGQ/wqAgQmVjYXVzZSBzb21lIAo+ID4g
Y29tbWFuZHMgbGlrZSAtLXRvcCBvciAtLXdhdmVzIGNhbiBkbyBhIGxvdCBvZiBkaXN0aW5jdCBy
ZWFkIAo+ID4gb3BlcmF0aW9ucyAoY2F1c2luZyBhIGxvdCBvZiBlbmFibGUvZGlzYWJsZSBjYWxs
cykuCj4gPiAKPiA+IEknbSBnb2luZyB0byBzaXQgb24gdGhpcyBhIGJpdCBzaW5jZSBJIGRvbid0
IHRoaW5rIHRoZSBwYXRjaCBpcyByZWFkeSAKPiA+IGZvciBwdXNoaW5nIG91dC4KPiA+IAo+IAo+
IEhvdyBhYm91dCB1c2UgUlJFRzMyX0tJUSBhbmQgV1JFRzMyX0tJUT8KPiAKPiBUaGFua3MsCj4g
UmF5Cj4gCj4gPiAKPiA+IFRvbQo+ID4gCj4gPiBPbiAyMDIwLTAyLTE5IDEwOjA3IGEubS4sIEFs
ZXggRGV1Y2hlciB3cm90ZToKPiA+ID4gT24gV2VkLCBGZWIgMTksIDIwMjAgYXQgMTA6MDQgQU0g
VG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPiB3cm90ZToKPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Cj4gPiA+IFBsZWFzZSBh
ZGQgYSBwYXRjaCBkZXNjcmlwdGlvbi4gIFdpdGggdGhhdCBmaXhlZDoKPiA+ID4gUmV2aWV3ZWQt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+ID4gCj4gPiA+
ID4gLS0tCj4gPiA+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdm
cy5jIHwgMyArKysKPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiA+
ID4gPiAKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RlYnVnZnMuYyAKPiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZWJ1Z2ZzLmMKPiA+ID4gPiBpbmRleCA3Mzc5OTEwNzkwYzkuLjY2Zjc2MzMwMGM5NiAxMDA2
NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdm
cy5jCj4gPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVn
ZnMuYwo+ID4gPiA+IEBAIC0xNjksNiArMTY5LDcgQEAgc3RhdGljIGludCAgYW1kZ3B1X2RlYnVn
ZnNfcHJvY2Vzc19yZWdfb3AoYm9vbCByZWFkLCBzdHJ1Y3QgZmlsZSAqZiwKPiA+ID4gPiAgICAg
ICAgICBpZiAocG1fcGdfbG9jaykKPiA+ID4gPiAgICAgICAgICAgICAgICAgIG11dGV4X2xvY2so
JmFkZXYtPnBtLm11dGV4KTsKPiA+ID4gPiAKPiA+ID4gPiArICAgICAgIGFtZGdwdV9nZnhfb2Zm
X2N0cmwoYWRldiwgZmFsc2UpOwo+ID4gPiA+ICAgICAgICAgIHdoaWxlIChzaXplKSB7Cj4gPiA+
ID4gICAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWx1ZTsKPiA+ID4gPiAKPiA+ID4gPiBAQCAt
MTkyLDYgKzE5Myw4IEBAIHN0YXRpYyBpbnQgIGFtZGdwdV9kZWJ1Z2ZzX3Byb2Nlc3NfcmVnX29w
KGJvb2wgcmVhZCwgc3RydWN0IGZpbGUgKmYsCj4gPiA+ID4gICAgICAgICAgfQo+ID4gPiA+IAo+
ID4gPiA+ICAgZW5kOgo+ID4gPiA+ICsgICAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCB0
cnVlKTsKPiA+ID4gPiArCj4gPiA+ID4gICAgICAgICAgaWYgKHVzZV9iYW5rKSB7Cj4gPiA+ID4g
ICAgICAgICAgICAgICAgICBhbWRncHVfZ2Z4X3NlbGVjdF9zZV9zaChhZGV2LCAweGZmZmZmZmZm
LCAweGZmZmZmZmZmLCAweGZmZmZmZmZmKTsKPiA+ID4gPiAgICAgICAgICAgICAgICAgIG11dGV4
X3VubG9jaygmYWRldi0+Z3JibV9pZHhfbXV0ZXgpOwo+ID4gPiA+IC0tCj4gPiA+ID4gMi4yNC4x
Cj4gPiA+ID4gCj4gPiA+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiA+ID4gPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+ID4gPiA+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gPiA+ID4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGCj4gPiA+ID4gbGlzdHMuZnJlZWRl
c2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3Cj4g
PiA+ID4gQzAxJTdDbW9uay5saXUlNDBhbWQuY29tJTdDYmE0NWVmYjI2YzAyNDBlZDAzNmYwOGQ3
YjZkYjIwYWElN0MzZGQ4Cj4gPiA+ID4gOTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAl
N0MwJTdDNjM3MTc4OTI0NjA1NTI0Mzc4JmFtcDtzZGF0Cj4gPiA+ID4gYT0lMkZ5SGt2WVU1VCUy
RjRpRnhSZXhzZyUyQklkbTdzRHp5WGJqek5wSFVHQ083aDRrJTNEJmFtcDtyZXNlcnZlCj4gPiA+
ID4gZD0wCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiA+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsaXN0Cj4gPiBzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZs
aXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q21vCj4gPiBuay5saXUlNDBhbWQu
Y29tJTdDYmE0NWVmYjI2YzAyNDBlZDAzNmYwOGQ3YjZkYjIwYWElN0MzZGQ4OTYxZmU0ODg0ZTYw
Cj4gPiA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxNzg5MjQ2MDU1MjQzNzgmYW1wO3Nk
YXRhPSUyRnlIa3ZZVTVUJTJGCj4gPiA0aUZ4UmV4c2clMkJJZG03c0R6eVhianpOcEhVR0NPN2g0
ayUzRCZhbXA7cmVzZXJ2ZWQ9MAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZs
aXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q21vbmsubGl1JTQwYW1kLmNvbSU3
Q2JhNDVlZmIyNmMwMjQwZWQwMzZmMDhkN2I2ZGIyMGFhJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFh
ODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE3ODkyNDYwNTUyNDM3OCZhbXA7c2RhdGE9JTJGeUhr
dllVNVQlMkY0aUZ4UmV4c2clMkJJZG03c0R6eVhianpOcEhVR0NPN2g0ayUzRCZhbXA7cmVzZXJ2
ZWQ9MApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
