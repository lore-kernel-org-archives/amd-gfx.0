Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A24C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 14:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7E621736
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 14:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7E621736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3AD6E075;
	Fri, 29 Nov 2019 14:26:25 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740042.outbound.protection.outlook.com [40.107.74.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBA3E6E075
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 14:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAwTkpxVGricAXRTs0qYoM9SRpRGmPmPwLfsBhRcFA6BUDjm3uFMTo+3PlrrCEKit9Lv22qHwAcQBIX+PvDY1Xodcir75K0c1zKuFRMACuZF3OcLQ8WuawohwK9xWB/vQVSHqqgcsmR/qNVakA37koLsFLn9aGRwXOeZunu2YRA2bjaniXF61/lMPW/cSguzJciyNrBhLilTkEAWKo0gkRc0C95gvUdg21fbodYCy+7waHK1EwS3Mi+8NXwPAzBSWxaK/Q89pE/NAbiReA8XnqQFhIXEWAuMwRhksXiiYZIfZ++FLYuC+GANVyskECVIaiGEjJreXA/FfRmTXo4oHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsHY2ArkCdYXwxRg6OOVdX7pneWQd37oxDIwGHG0ZCU=;
 b=laJmDmUb8hFZ12qEam0j9SPzcQR4y7JanAK9Uh5LJ9r7vfu2Rq87KFKMU7hJuBwAvXuWuLaX4ljsj9xLE98VBRL6zxkkHoLlcbikGyWaorRCLBr8VeGZvmz0xoZXLP74PQCzBxlGOwe7jE3xyUK8TRG2jCmF6bY8jshN3IA23lqoTlWTLyYxpQyPHvFArXecgKZwAX8LPemJEYpzO67s1nXWI5aLoCrOH+d3+UZx5t9RGk6EbWDOwxs+rreGpMpvaGwqhjB1hXYJCqvwFdIk3rcDXl/SVa5QNmG7k5dv+RgXyeMMILFV/5SJ4EFmai5koA2Xx0X6CRLfeqULAKEJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB4030.namprd12.prod.outlook.com (10.255.86.25) by
 MN2PR12MB3024.namprd12.prod.outlook.com (20.178.242.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 14:26:22 +0000
Received: from MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::b9e3:2087:df4d:1e0a]) by MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::b9e3:2087:df4d:1e0a%6]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 14:26:21 +0000
Subject: Re: Deadlock on PTEs update for HMM
To: "Zeng, Oak" <Oak.Zeng@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <SN6PR12MB26216A095D9839500242F489FD440@SN6PR12MB2621.namprd12.prod.outlook.com>
 <SN1PR12MB25916EE076E6BF5F5CBE3F8B80460@SN1PR12MB2591.namprd12.prod.outlook.com>
From: Philip Yang <philip.yang@amd.com>
Message-ID: <1e7bf3dd-6b65-e5fb-a2e8-1d20dafc1fb0@amd.com>
Date: Fri, 29 Nov 2019 09:26:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <SN1PR12MB25916EE076E6BF5F5CBE3F8B80460@SN1PR12MB2591.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To MN2PR12MB4030.namprd12.prod.outlook.com
 (2603:10b6:208:159::25)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac81557c-ff5e-472a-cad1-08d774d81b3e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3024:|MN2PR12MB3024:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3024A1482FF86CBC5BC5D0C1E6460@MN2PR12MB3024.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0236114672
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(51874003)(66556008)(66476007)(5660300002)(6116002)(7736002)(2906002)(3846002)(6306002)(6512007)(305945005)(66946007)(966005)(31686004)(14454004)(4326008)(478600001)(31696002)(316002)(86362001)(4001150100001)(6246003)(50466002)(25786009)(23746002)(47776003)(229853002)(8676002)(6436002)(8936002)(6486002)(6506007)(6636002)(110136005)(81166006)(81156014)(58126008)(66066001)(45080400002)(65806001)(99286004)(36756003)(65956001)(44832011)(446003)(2870700001)(26005)(15650500001)(11346002)(14444005)(186003)(2616005)(52116002)(53546011)(76176011)(386003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3024;
 H:MN2PR12MB4030.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmkjfBv5DItzzGGV9WZHNpOOA3cBScrYYuhAt66Xm/uuWAyJQeGmrvmT4ZsqcKr2IDCda1TAqwiXyoiaEN4YkmSultHCjSrnJ3y3tEvGZDIKeDXn2+4kJ+jGbKPrGYGSwFlZJuBiWYz3Fd4zsRO5qjcSsvlZLl+GmqiHUxqH3J/GPB0RC2cTnJX8uqAgGIXrKtKnzHieB83chOf1t9r+6IPkz3CB4tec5Q0isCR/mfqw1CupskVTiPqLtTD6P3yOidvxus4LxnAsEoh9KjtQT3nnvaEN/ItnQPakKIwWNeaqJLwMU82k8rgoRVAQGTai74Jig34m6uSd3PCZIDJIl6WVSPjqmSVATNiPBzt5I0gqX6E54n2mezpB+y41oVkz1D1DW60h9Ft7bE6/5ZNai71IllAPsjLi5rxp2CTny/nZS+kVh7jcAMKSAsR4V1pbk5mBHq3y6ZyfH5nOqAdOH8FfoG5uiPEJC8tRGShDYts=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac81557c-ff5e-472a-cad1-08d774d81b3e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2019 14:26:21.8260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXb2vdGM8XAfHAnI3MYfPYqapNfdubB8ClB6KUp9bG8Ig3aRLNzh09D/kegiQnxW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3024
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsHY2ArkCdYXwxRg6OOVdX7pneWQd37oxDIwGHG0ZCU=;
 b=SY2kbAnBOvzThtSHMH86xUB+ZamDcL72mwjjDVZTfldjBFF9PArQ7eBT014TBNywyItoqjwn8QrozQb2fBtFt0GaJdklO8ySCOH8unIX6xE+70S9kvbNZrXYjUDnR+Y4Ps4stg3hYL6xHfI80QrPr6cfk5vi8OUa/99kLX1gVRU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Philip.Yang@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WWVzLCB0aGlzIGNhbiB3b3JrIHVzaW5nIHRoZSBzYW1lIHdheSBhcyBkcW1fbG9jay4gVGhpcyBp
cyB0cml2aWFsIHBhcnQsIApGZWxpeCBhbmQgQ2hyaXN0aWFuIGlzIGRpc2N1c3NpbmcgdGhlIHNv
bHV0aW9uIG9mIGxvY2sgcHJvYmxlbS4KClJlZ2FyZHMsClBoaWxpcAoKT24gMjAxOS0xMS0yOCA3
OjM1IHAubS4sIFplbmcsIE9hayB3cm90ZToKPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50
ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4gCj4gSXMga21hbGxvYyB3aXRoIEdGUF9OT1dBSVQg
YW4gb3B0aW9uIGhlcmU/Cj4gCj4gUmVnYXJkcywKPiAKPiBPYWsKPiAKPiAqRnJvbToqIGFtZC1n
ZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+ICpPbiBCZWhhbGYgT2Yg
KiAKPiBTaWVycmEgR3VpemEsIEFsZWphbmRybyAoQWxleCkKPiAqU2VudDoqIFdlZG5lc2RheSwg
Tm92ZW1iZXIgMjcsIDIwMTkgOTo1NSBBTQo+ICpUbzoqIEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggCj4gPEZlbGl4Lkt1ZWhsaW5n
QGFtZC5jb20+Cj4gKkNjOiogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiAqU3ViamVj
dDoqIERlYWRsb2NrIG9uIFBURXMgdXBkYXRlIGZvciBITU0KPiAKPiBIaSBDaHJpc3RpYW4sCj4g
Cj4gQXMgeW91IGtub3csIHdl4oCZcmUgd29ya2luZyBvbiB0aGUgSE1NIGVuYWJsZW1lbnQuIElt
IHdvcmtpbmcgb24gdGhlIGRHUFUgCj4gcGFnZSB0YWJsZSBlbnRyaWVzIGludmFsaWRhdGlvbiBv
biB0aGUgdXNlcnB0ciBtYXBwaW5nIGNhc2UuIEN1cnJlbnRseSwgCj4gdGhlIE1NVSBub3RpZmll
cnMgaGFuZGxlIHN0b3BzIGFsbCB1c2VyIG1vZGUgcXVldWVzLCBzY2hlZHVsZSBhIGRlbGF5ZWQg
Cj4gd29ya2VyIHRvIHJlLXZhbGlkYXRlIHVzZXJwdHIgbWFwcGluZ3MgYW5kIHJlc3RhcnQgdGhl
IHF1ZXVlcy4KPiAKPiBQYXJ0IG9mIHRoZSBITU0gZnVuY3Rpb25hbGl0eSwgd2UgbmVlZCB0byBp
bnZhbGlkYXRlIHRoZSBwYWdlIHRhYmxlIAo+IGVudHJpZXMgaW5zdGVhZCBvZiBzdG9wcGluZyB0
aGUgcXVldWVzLiBBdCB0aGUgc2FtZSB0aW1lIHdlIG5lZWQgdG8gbW92ZSAKPiB0aGUgcmV2YWxp
ZGF0aW9uIG9mIHRoZSB1c2VycHRyIG1hcHBpbmdzIGludG8gdGhlIHBhZ2UgZmF1bHQgaGFuZGxl
ci4KPiAKPiBXZeKAmXJlIHNlZWluZyBhIGRlYWRsb2NrIHdhcm5pbmcgYWZ0ZXIgd2UgdHJ5IHRv
IGludmFsaWRhdGUgdGhlIFBURXMgCj4gaW5zaWRlIHRoZSBNTVUgbm90aWZpZXIgaGFuZGxlci4g
TW9yZSBzcGVjaWZpYywgd2hlbiB3ZSB0cnkgdG8gdXBkYXRlIAo+IHRoZSBCT3MgdG8gaW52YWxp
ZGF0ZSBQVEVzIHVzaW5nIGFtZGdwdV92bV9ib191cGRhdGUuIFRoaXMgdXNlcyBrbWFsbG9jIAo+
IG9uIHRoZSBhbWRncHVfam9iX2FsbG9jIHdoaWNoIHNlZW1zIHRvIGJlIGNhdXNpbmcgdGhpcyBw
cm9ibGVtLgo+IAo+IEJhc2VkIG9uIEBLdWVobGluZywgRmVsaXggPG1haWx0bzpGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPiBjb21tZW50cywgCj4ga21hbGxvYyB3aXRob3V0IGFueSBzcGVjaWFsIGZs
YWdzIGNhbiBjYXVzZSBtZW1vcnkgcmVjbGFpbS4gRG9pbmcgdGhhdCAKPiBpbnNpZGUgYW4gTU1V
IG5vdGlmaWVyIGlzIHByb2JsZW1hdGljLCBiZWNhdXNlIGFuIE1NVSBub3RpZmllciBtYXkgYmUg
Cj4gY2FsbGVkIGluc2lkZSBhIG1lbW9yeS1yZWNsYWltIG9wZXJhdGlvbiBpdHNlbGYuIFRoYXQg
d291bGQgcmVzdWx0IGluIAo+IHJlY3Vyc2lvbi4gQWxzbywgcmVjbGFpbSBzaG91bGRuJ3QgYmUg
ZG9uZSB3aGlsZSBob2xkaW5nIGEgbG9jayB0aGF0IGNhbiAKPiBiZSB0YWtlbiBpbiBhbiBNTVUg
bm90aWZpZXIgZm9yIHRoZSBzYW1lIHJlYXNvbi4gSWYgeW91IGNhdXNlIGEgcmVjbGFpbSAKPiB3
aGlsZSBob2xkaW5nIHRoYXQgbG9jaywgdGhlbiBhbsKgTU1VIG5vdGlmaWVyIGNhbGxlZCBieSB0
aGUgcmVjbGFpbSAKPiBjYW7CoGRlYWRsb2NrIHRyeWluZyB0byB0YWtlIHRoZSBzYW1lIGxvY2su
Cj4gCj4gUGxlYXNlIGxldCB1cyBrbm93IGlmIHlvdSBoYXZlIGFueSBhZHZpY2UgdG8gZW5hYmxl
IHRoaXMgdGhlIHJpZ2h0IHdheQo+IAo+IFRoYW5rcyBpbiBhZHZhbmNlZCwKPiAKPiBBbGVqYW5k
cm8KPiAKPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZh
bWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NwaGlsaXAueWFuZyU0MGFtZC5jb20lN0NmZjVkZWYx
Y2YyZGU0NGE2YmNhNjA4ZDc3NDY0MDQzZSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUx
ODNkJTdDMCU3QzAlN0M2MzcxMDU4NDUyNTU3NTQ2MTEmYW1wO3NkYXRhPVN6M0xucmxKOEU1NmVm
dFYzWUNoNllkVDZuTmxNZWFBNUpGcER0S0JQa2MlM0QmYW1wO3Jlc2VydmVkPTAKPiAKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
