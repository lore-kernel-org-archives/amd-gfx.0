Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2F7CA9EA0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 06:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B5720873
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 06:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B5720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE386E39C;
	Mon, 28 Oct 2019 06:49:17 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820073.outbound.protection.outlook.com [40.107.82.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF7C6E39C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 06:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrLklP0uzaV2cnI/gbHPATtf+38P09T7DwA/2kl+Fdquw5HUDx/a41KtkHN9T+eY0ygd3h8C1pX86e0kvFKE4SJqUgdx/VR20QbfKHQgadoS0XE29n+Zdh0HJFeM6bLaWfLwlTG/IB83Tn8DIeGzSkiB5oyONcr6VW3aDNBhDFHnaIksCcg3fyr0sNfW268PQwyIqZqUATlpGkCUh7H/v/KWsDcsTRGH3hrV5RWH2ZLiH2BShBGo1kkvyTYOwHlMYXocgnJkyzNX4aV4/OH5jFsKONMUXfAui+W+0VsIlt/IhQj2mxPsms9aifThbaQ6HwePZyAYMKqcI5dStVjeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qG3fjN+NmjvrbT9JvfmDl9qByMgC5kIIu4mkyQYjwU=;
 b=QBxyaqasTugnvIAku/CCft3dRlddlX+z9h6+dvu3ivcVjQ7kYQ0erKx1Y5xIwTaPMEEPwbSQaOIfxf5xygSaivb5ugyLXQ04QlHH4B3CNZrexbCGscN954gFM2qaJ2vIwBA7Q3klGpP8yu8ODrL1YgbDA4zQG2vcUkBzD6ZfhaiHnWJTNJTk7GxZd699YcHvGpz4A0p1t58niwpCrcqOjcB07QdmDbaQZ619ey0mryw0dVPdJBviBHo9i9Ki5c88FqgUNfQ70P88UZLUxAvtlJ0T7Hn8tqiQMuqJs8spoU54nUJ9gmJ415JbA1g1dZU2qDopxEnDveML2PeO6xTbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:910:16::29) by CY4PR12MB1893.namprd12.prod.outlook.com
 (2603:10b6:903:127::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.25; Mon, 28 Oct
 2019 06:49:13 +0000
Received: from DM3NAM03FT062.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by CY4PR1201CA0019.outlook.office365.com
 (2603:10b6:910:16::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Mon, 28 Oct 2019 06:49:12 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT062.mail.protection.outlook.com (10.152.83.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 06:49:12 +0000
Received: from swae-HP-ProBook-455R-G6 (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 01:49:10 -0500
Date: Mon, 28 Oct 2019 14:43:17 +0800
From: Louis Li <ching-li@amd.com>
To: "S, Shirish" <Shirish.S@amd.com>
Subject: Re: [PATCH] UPSTREAM: drm/amd/display: Fix Apple dongle cannot be
 successfully detected
Message-ID: <20191028064317.GC8877@swae-HP-ProBook-455R-G6>
References: <20191021075439.1066-1-Ching-shih.Li@amd.com>
 <2d745e77-c6be-fb02-a1ee-c07664b911cd@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2d745e77-c6be-fb02-a1ee-c07664b911cd@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB02.amd.com (10.181.40.143) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(428003)(47660400002)(199004)(189003)(1076003)(336012)(33656002)(478600001)(54906003)(9686003)(81156014)(58126008)(70206006)(70586007)(7736002)(305945005)(6862004)(6636002)(2906002)(4326008)(47776003)(356004)(46406003)(8676002)(50466002)(33716001)(316002)(81166006)(16526019)(16586007)(8936002)(14444005)(186003)(6116002)(486006)(23726003)(3846002)(76176011)(97756001)(386003)(53546011)(26005)(5660300002)(426003)(55016002)(476003)(126002)(11346002)(229853002)(446003)(6246003)(46800400005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1893; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19ddec87-a189-41b6-cc80-08d75b72f137
X-MS-TrafficTypeDiagnostic: CY4PR12MB1893:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1893575720978534D4E74FFBAA660@CY4PR12MB1893.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0oRZuEFXJL/WV8FkHaacMG9UgBrCq9P8y3Y52mU9oMdah02qWcpc7bglxTyF7TqRVOU2h6dpnFcDlVS8+LInaXOrUAT9dXRkFjn5Rg/ouZAlWgqrU4Ex8uA4/BBr4nVqqmqj2cBnbT2BAV/6xoCByF21i4XTd1lMdly1q1dnwiJ+LjhqaDkUoN0ws1YsZAklI+TNka13bJzNBe2jvSe/r90uIiHeJbVkK/uBXlkieFdkhGUCrBz+1Lx9kNsxM4PCizSBXoDtI/1ZfAWhLwENdOZsjyBiIJQIT1ETlGVF5LzwiucTyxEJ5BYPUFAW8PSRYoDfbSq1S35DPWW2we10aZ2o7nPko0yEBsQM/nYCCNTrIC3WdKDWDkmMMV+Q27uTa/6am7LtUFkHOhQfQl07U/mKuGH3tkD10oPPkaUXUIlvzkmbbTNmC7fG5WP9Ef5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 06:49:12.6739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ddec87-a189-41b6-cc80-08d75b72f137
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1893
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qG3fjN+NmjvrbT9JvfmDl9qByMgC5kIIu4mkyQYjwU=;
 b=rqbzuEnxweiNddKzPUrmmLjRxo+B/fWpz6dId/vHF0Zs5AU+Fumg8u64HZPfuW4oRO1TsTXSpSDy+/nPAypp8TRk5fmNgNmw7qFlsZYgn/HZXWFW/d/Xo/g5ikXO3xsxI1pyhfcsecqEKcF7pROER9fxNueTRH6dEo06Dy1ZfFc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Ching-shih \(Louis\)" <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028064317.AWrDFOQ3jHei606Z0W3cNp-0BBn-wHW3kbTjwEZcS1U@z>

T24gV2VkLCBPY3QgMjMsIDIwMTkgYXQgMDI6MTk6NTZQTSArMDgwMCwgUywgU2hpcmlzaCB3cm90
ZToKPiBUaGUgVVBTVFJFQU0gdGFnIGluIHRoZSBjb21taXQgbWVzc2FnZSBuZWVkcyB0byBiZSBy
ZW1vdmVkLgo+IAoKT0suIFdpbGwgcmVtb3ZlIGl0LgoKPiBPbiAxMC8yMS8yMDE5IDE6MjQgUE0s
IExvdWlzIExpIHdyb3RlOgo+ID4gW1doeV0KPiA+IEV4dGVybmFsIG1vbml0b3IgY2Fubm90IGJl
IGRpc3BsYXllZCBjb25zaXN0ZW50bHksIGlmIGNvbm5lY3RpbmcKPiA+IHZpYSB0aGlzIEFwcGxl
IGRvbmdsZSAoQTE2MjEsIFVTQiBUeXBlLUMgdG8gSERNSSkuCj4gPiBCeSBleHBlcmltZW50cywg
aXQgaXMgY29uZmlybWVkIHRoYXQgdGhlIGRvbmdsZSBuZWVkcyAyMDBtcyBhdCBsZWFzdAo+ID4g
dG8gYmUgcmVhZHkgZm9yIGNvbW11bmljYXRpb24sIGFmdGVyIGl0IHNldHMgSFBEIHNpZ25hbCBo
aWdoLgo+ID4KPiA+IFtIb3ddCj4gPiBXaGVuIHJlY2VpdmluZyBIUEQgSVJRLCBkZWxheSA1MDBt
cyBhdCB0aGUgYmVnaW5uaW5nIG9mIGhhbmRsZV9ocGRfaXJxKCkuCj4gCj4gQW0gbm90IHN1cmUg
aG93IHRoaXMgZGVsYXkgc2hhbGwgaW1wYWN0IG9uIGRvbmdsZXMgdGhhdCBkb24ndCBuZWVkIGl0
LAo+IAo+IGlkZWFsbHkgaXQgc2hvdWxkIGJlIGFkZGVkIGFzIHF1aXJrLCBhdCBsZWFzdCByZXN0
cmljdCBpdCB0byB0aGVzZSAKPiBzcGVjaWZpYyB2ZW5kb3JzLgo+IAo+IEluc3RlYWQgb2YgZGVs
YXksIGNhbiB5b3UgZmluZCBhbnkgcGFyYW1ldGVyIHRvIHdhaXQgZm9yIGZvciB0aGUgCj4gY29t
bXVuaWNhdGlvbiB0byBiZSByZWFkeSwKPiAKPiBpbiB0aGF0IHdheSBpdCBzaGFsbCBiZSBmYWls
c2FmZS4KPiAKCkZvciBzdWNoIGRldmljZXMgKG1vbml0b3JzL2RvbmdsZXMpLCB0aGVyZSB3aWxs
IGJlIG5vIGNoYW5jZSB0bwpnZXQgaW5mb3JtYXRpb24gYmVmb3JlIHRoZSBkZWZlciwgYmVjYXVz
ZSBpdCBpcyBub3QgcmVhZHkgdG8KY29tbW11bmljYXRlIHJpZ2h0IGFmdGVyIEhQRCBpbnRlcnJ1
cC4gQWxsIG90aGVyIGF2YWlsYWJsZQpkb25nbGVzIHdlcmUgdmVyaWZpZWQgd2l0aCB0aGUgcGF0
Y2ggYXBwbGllZCwgYW5kIHdvcmsgd2VsbApzdGlsbC4gQXMgcmVwbGllZCBlYXJsaWVyLCB0aGlz
IGlzIGNhdXNlZCBieSBkb25nbGUvbW9uaXRvciwKYW5kIHRoZSBzb2x1dGlvbiBpcyB0byBoYXZl
IHRoZSBkcml2ZXIgYmV0dGVyIGNvbXBhdGliaWxpdHkuCgpMb3VpcyBMaQoKPiA+IFRoZW4gcnVu
IHRoZSBvcmlnaW5hbCBwcm9jZWR1cmUuCj4gPiBXaXRoIHRoaXMgcGF0Y2ggYXBwbGllZCwgdGhl
IHByb2JsZW0gY2Fubm90IGJlIHJlcHJvZHVjZWQuCj4gPiBXaXRoIG90aGVyIGRvbmdsZXMsIHRl
c3QgcmVzdWx0cyBhcmUgUEFTUy4KPiA+IFRlc3QgcmVzdWx0IGlzIFBBU1MgYWZ0ZXIgc3lzdGVt
IHJlc3VtZXMgZnJvbSBzdXNwZW5kLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IExvdWlzIExpIDxD
aGluZy1zaGloLkxpQGFtZC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDUgKysrKysKPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ID4gaW5kZXggMGFlZjkyYjdjMDM3Li4wNDNk
ZGFjNzM4NjIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gPiBAQCAtMTAyNSw2ICsxMDI1LDExIEBAIHN0YXRpYyB2
b2lkIGhhbmRsZV9ocGRfaXJxKHZvaWQgKnBhcmFtKQo+ID4gICAJc3RydWN0IGRybV9kZXZpY2Ug
KmRldiA9IGNvbm5lY3Rvci0+ZGV2Owo+ID4gICAJZW51bSBkY19jb25uZWN0aW9uX3R5cGUgbmV3
X2Nvbm5lY3Rpb25fdHlwZSA9IGRjX2Nvbm5lY3Rpb25fbm9uZTsKPiA+ICAgCj4gPiArICAgIC8q
IFNvbWUgbW9uaXRvcnMvZG9uZ2xlcyBuZWVkIGFyb3VuZCAyMDBtcyB0byBiZSByZWFkeSBmb3Ig
Y29tbXVuaWNhdGlvbgo+ID4gKyAgICAgKiBhZnRlciB0aGV5IGRyaXZlIEhQRCBzaWduYWwgaGln
aC4KPiA+ICsgICAgICovCj4gPiArICAgIG1kZWxheSg1MDApOwo+ID4gKwo+ID4gICAJLyogSW4g
Y2FzZSBvZiBmYWlsdXJlIG9yIE1TVCBubyBuZWVkIHRvIHVwZGF0ZSBjb25uZWN0b3Igc3RhdHVz
IG9yIG5vdGlmeSB0aGUgT1MKPiA+ICAgCSAqIHNpbmNlIChmb3IgTVNUIGNhc2UpIE1TVCBkb2Vz
IHRoaXMgaW4gaXQncyBvd24gY29udGV4dC4KPiA+ICAgCSAqLwo+IAo+IC0tIAo+IFJlZ2FyZHMs
Cj4gU2hpcmlzaCBTCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
