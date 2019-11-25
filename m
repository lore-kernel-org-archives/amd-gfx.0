Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E6FC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 21:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFEE20748
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 21:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFEE20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99D089DBA;
	Mon, 25 Nov 2019 21:34:24 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730051.outbound.protection.outlook.com [40.107.73.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70AB689DBA
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 21:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmtkod03an5S3eWnMNDAGCcqTG3aATFckSdWg7wBEEd05Rgnx+ab5YshNJDS9f4gp8sK1d0VTBX9micuodeQzEiyFg5bMTXm84beChM07jxjsG8ORXiuHMlzlPI0rYHcTS/dZLocyWzUseWEX4hTr/ipEus0DU/BF1ol4S9EapgX+uWVBmni/1VEdIvBDceJIfS6FPGHqgRp5rY3cqHQKpnsyiEFZ/aVVix6S/AfNVqjPxIy59vC8xs19504SBVY2YBzB+ujEHIuFVrqGM27AUWUzpFVGhchiGq5rgK39dvJwhwpCl4+MCCHHV/yRa8ClYoDtPLl9JTNktamxcE1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fFgEuiGIzdl0edcEHczNiiVoSyz/bErM86bb49vamc=;
 b=ZixVuKlkOJzRtSvH0GSCUY+OEaQqT4No11J2w0egbZw1hFfVlrfTXFGpRJDjz24UaOIE3a3MKkTApj6FauqrF8MWHrjx+tv1a7k4kcL8WsxDWlIH/8QJKjn/QLJabzUOMBZTc9HYmn9mKZD2mn3JQMpmMqil2tE0dqiSTZt0BhMJS+41VQuuw7irbXGb7F8rMph8S5YyDRkBZ1FY+6ZlNB6bCiiqIvUEoCV9XgN67KQ9yn0o44hVWbFnZ8vajfgwQ/l9dpKpxBwPxXLpqfeX+nr64aofUdtdqrFB6ZFwJt/xCBvQSEqioYBmvVSE7YGrpTeUtJDSESZiz7fJVrTq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3561.namprd12.prod.outlook.com (20.178.199.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Mon, 25 Nov 2019 21:34:21 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 21:34:21 +0000
Subject: Re: [PATCH 1/1] amdgpu: Enable KFD on POWER systems
To: Timothy Pearson <tpearson@raptorengineering.com>
References: <2068915477.1923611.1574622916022.JavaMail.zimbra@raptorengineeringinc.com>
 <44175d39-e507-83f9-6596-cbde108dd65a@amd.com>
 <535694171.2118031.1574716002431.JavaMail.zimbra@raptorengineeringinc.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <5dcfdba7-dc14-99d4-d6e5-fc1768fcc5c0@amd.com>
Date: Mon, 25 Nov 2019 16:34:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <535694171.2118031.1574716002431.JavaMail.zimbra@raptorengineeringinc.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::33)
 To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 165629e2-3faf-42d3-6f02-08d771ef3c27
X-MS-TrafficTypeDiagnostic: DM6PR12MB3561:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3561752C7ADD87C0C8D437E5924A0@DM6PR12MB3561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(189003)(199004)(13464003)(6436002)(11346002)(76176011)(36916002)(50466002)(23676004)(2486003)(52116002)(31696002)(99286004)(66556008)(66476007)(58126008)(4001150100001)(229853002)(31686004)(5660300002)(4326008)(66946007)(86362001)(6486002)(6512007)(47776003)(53546011)(6246003)(6506007)(386003)(65806001)(65956001)(66066001)(44832011)(2616005)(36756003)(14454004)(316002)(25786009)(7736002)(305945005)(3846002)(81166006)(8936002)(8676002)(81156014)(2906002)(6116002)(2870700001)(446003)(6916009)(186003)(26005)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3561;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/kEqk5dJDNEO593G8ED16HyXQ214GA9/+kNxMSXTHRvAPTj3NiujRxw7izBkuLg1cc1s0x7zC8PhjijKZN7bWG3Y9r6y0lUEnwCa3qs2mHsZOgbVNksiOaD7U0GP5ofq9Qyf1JQaPMqzH1duWcxHAGOiN/aZiWElxhDjM0V1YXWeGnXLSqTO6ttfktPnvz3qFRWMurkX4UtpmPv3v/pxYby1TWSt19C3lR+a1RVJ7XiaQv/8/cYKt5Fmnn+ET5MFyPy3h0qpVM9OO9twL7eldN5kKU2hsl6MMp+pxfu/AvjuweT4Km0qF/N8v0w7C6aaQW8y8jRbi50f8SWkXvI1zP3/iQvDYEWY31Z3MuaZ3uRenlCDXk3IVR/nn/ksSZ72Oqg56YYEHG8qh9LY+gjRPTok3dQoomVwOtTstKeVnx1ok+qvClv1ndUDTP54Aus
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165629e2-3faf-42d3-6f02-08d771ef3c27
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 21:34:21.8783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zmTJs4Uj5V7LAjqc3VD6+ZN6iWHmLRsBsuzlIwBAWtp1wy5pNGfEff9dfFhrYW1GQwDG7LoFqqP3EM8gBz2dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3561
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fFgEuiGIzdl0edcEHczNiiVoSyz/bErM86bb49vamc=;
 b=psCGY4TiiwiQGxFm1F9L8YJja+m+BN2Z/gRh6wGbwbc2a43PwKNlPcvZs+wlNon9DSrMlK2cNH3fiLBvM3ROhbovNu/sUO8OFfG7qB9WAfN3HfzvZIjtsVAdbX8pzbKlbpfPNtBndMBQIgC8k7Yda+0ExJTXDIAiVrAqDT0EcZ8=
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
Cc: amd-gfx <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125213420.AoPIqzI9D_hq1OQDyozkGc3rtY_LZH3PIOfkxpbCxkM@z>

T24gMjAxOS0xMS0yNSA0OjA2IHAubS4sIFRpbW90aHkgUGVhcnNvbiB3cm90ZToKPgo+IC0tLS0t
IE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0KPj4gRnJvbTogIkZlbGl4IEt1ZWhsaW5nIiA8ZmVsaXgu
a3VlaGxpbmdAYW1kLmNvbT4KPj4gVG86ICJUaW1vdGh5IFBlYXJzb24iIDx0cGVhcnNvbkByYXB0
b3JlbmdpbmVlcmluZy5jb20+LCAiYW1kLWdmeCIgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPgo+PiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDI1LCAyMDE5IDExOjA3OjMxIEFNCj4+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBhbWRncHU6IEVuYWJsZSBLRkQgb24gUE9XRVIgc3lzdGVt
cwo+PiBIaSBUaW1vdGh5LAo+Pgo+PiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCBhbmQgZm9yIGNv
bmZpcm1pbmcgdGhhdCBpdCB3b3Jrcy4gV2UgZGlkIHNvbWUKPj4gZXhwZXJpbWVudGFsIHdvcmsg
b24gUG93ZXI4IGEgZmV3IHllYXJzIGFnby4gSSBzZWUgdGhhdCBUYWxvcyBJSSBpcyBQb3dlcjku
Cj4+Cj4+IEF0IHRoZSB0aW1lIHdlIHdlcmUgd29ya2luZyBvbiBQb3dlcjggd2UgaGFkIHRvIGFk
ZCBzb21lICNpZmRlZgo+PiBDT05GSUdfQUNQSSBndWFyZHMgYXJvdW5kIHNvbWUgQUNQSS1zcGVj
aWZpYyBjb2RlIGluIEtGRC4gRG8geW91IGtub3cgdG8KPj4gd2hhdCBleHRlbnQgQUNQSSBpcyBh
dmFpbGFibGUgYW5kIHdvcmtpbmcgb24gdGhlIFBvd2VyIGFyY2hpdGVjdHVyZT8KPj4KPj4gQW5v
dGhlciBwcm9ibGVtIHdlIHJhbiBpbnRvIHdpdGggUG93ZXIsIGlzIHRoZSBwaHlzaWNhbCBhZGRy
ZXNzIG1hcC4KPj4gU3lzdGVtIG1lbW9yeSBjYW4gYmUgYSBwaHlzaWNhbCBhZGRyZXNzZXMgb3V0
c2lkZSB0aGUgcmFuZ2UgYWNjZXNzaWJsZQo+PiBieSB0aGUgR1BVLiBWZWdhIGhhcyA0NC1iaXQg
cGh5c2ljYWwgYWRkcmVzc2luZy4gT2xkZXIgUG9sYXJpcyBHUFVzIG9ubHkKPj4gaGF2ZSA0MC1i
aXRzLiBEaWQgeW91IHJ1biBpbnRvIGFueSBzdWNoIHByb2JsZW1zPyBEbyB5b3UgbmVlZCBhbiBJ
T01NVQo+PiB0byBtYWtlIHN5c3RlbSBtZW1vcnkgYWNjZXNzaWJsZSB0byB0aGUgR1BVPwo+Pgo+
PiBSZWdhcmRzLAo+PiAgwqAgRmVsaXgKPiBZZXMsIHdlIGFyZSBQT1dFUjkuICBJdCBsb29rcyBs
aWtlIHRoZSBBQ1BJIGd1YXJkcyBhcmUgbm8gbG9uZ2VyIHJlcXVpcmVkOyBhcyB5b3UgaGF2ZSBz
dXJtaXNlZCwgUE9XRVIgZG9lcyBub3QgdXNlIEFDUEkgKHRoZSBlcXVpdmFsZW50IGlzIE9QQUws
IHdoaWNoIGlzIGEgZGlmZmVyZW50IGludGVyZmFjZSBlbnRpcmVseSkuICBXaGF0IHdlcmUgdGhl
IEFQQ0kgY2FsbHMgdXNlZCBmb3I/ICBUaGVyZSBtYXkgYmUgT1BBTCBlcXVpdmFsZW50cyB0aGF0
IGNvdWxkIGJlIGFkZGVkIGluIHRvIHJlcGxhY2UgdGhlbSBhbmQgcHJvdmlkZSBzaW1pbGFyIGZ1
bmN0aW9uYWxpdHkuCgpUaGVyZSBhcmUgc29tZSBBQ1BJIGNhbGxzIChlLmcuIGFjcGlfZ2V0X3Rh
YmxlKSBpbiBrZmRfY3JhdC5jIGZvciAKZ2V0dGluZyBhIENSQVQgdGFibGUgZnJvbSBBQ1BJLiBU
aGlzIGlzIG9ubHkgdXNlZnVsIGZvciBBTUQgQVBVcywgd2hpY2ggCmFyZSB4ODZfNjQuIFdlIGRv
bid0IG5lZWQgdGhpcyBmb3IgZGlzY3JldGUgR1BVcyBiZWNhdXNlIG9uIG5vbi1BUFUgCnN5c3Rl
bXMgdGhlcmUgaXMgbm8gQ1JBVCB0YWJsZSBhbmQgd2UgYnVpbGQgb3VyIG93bi4gSWYgeW91IGNh
biBjb21waWxlIAp0aGUgY29kZSB3aXRob3V0IHByb2JsZW1zIG9uIFBvd2VyIGFuZCB3aXRoIENP
TkZJR19BQ1BJIG5vdCBkZWZpbmVkLCAKdGhlbiBJIGd1ZXNzIHRoaXMgaXMgbm8gbG9uZ2VyIGFu
IGlzc3VlLgoKCj4gS2VybmVsIDUuNCBlbmFibGVzIGEgPiAzMi1iaXQgYW5kIDw9NjQtYml0IGJ5
cGFzcyBtb2RlIGZvciBQT1dFUi4gIFRoaXMgaXMgb25lIHJlYXNvbiB3ZSBjYW1lIGJhY2sgYW5k
IHJldmlzaXRlZCB0aGUgS0ZEL1JPQ20gZnVuY3Rpb25hbGl0eSBvbiBQT1dFUjsgYXMgaXQgdHVy
bnMgb3V0LCBhZnRlciBmaXhpbmcgdXAgdGhlIHVzZXJzcGFjZSB0b29scyBLRkQgaXMgaW5kZWVk
IGZ1bmN0aW9uYWwgb24gUE9XRVIgd2l0aCA1LjQtcmM4IGFuZCBhYm92ZS4gIE15IHVuZGVyc3Rh
bmRpbmcgaXMgdGhhdCB0aGUgUE9XRVIgSU9NTVUgaXMgdXNlZCBhcyBhIGxpZ2h0d2VpZ2h0IHRy
YW5zbGF0aW9uIGxheWVyIGJldHdlZW4gdGhlIDY0LWJpdCBob3N0IGFuZCB0aGUgNDAvNDQtYml0
IEdQVS4KPgo+IEknbSB3b3JraW5nIG9uIGdldHRpbmcgYSBEZWJpYW4gUFBBIHNldCB1cCBmb3Ig
UE9XRVIgdG8gbWFrZSB0aGUgdXNlcnNwYWNlIHRvb2xzIGVhc2llciB0byBvYnRhaW4gZm9yIHRl
c3RpbmcsIGJ1dCBwcm9ncmVzcyBpcyBzbG93IGR1ZSB0byBsYWNrIG9mIERlYmlhbiBzb3VyY2Ug
cGFja2FnZXMuICBQcm9iYWJseSB0aGUgZWFzaWVzdCB3YXkgdG8gcmVwbGljYXRlIC8gdGVzdCB0
aGlzIHdpdGggSElQIGlzIHRvIHVzZSB0aGUgQU9NUCByZXBvc2l0b3J5IHdpdGggbXkgbW9kaWZp
Y2F0aW9uczsgcHVsbCByZXF1ZXN0cyBhcmUgYWxyZWFkeSBpbiBwbGFjZSBvbiBHaXRodWIgZm9y
IG1vc3Qgb2YgdGhlIHVzZXJzcGFjZSB0b29saW5nIHVwZGF0ZXMuCj4KPiBUaGFuayB5b3UhClRo
YW5rcywKIMKgIEZlbGl4CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
