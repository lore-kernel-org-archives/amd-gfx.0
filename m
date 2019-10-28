Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939EDCA9EA0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 06:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF2220862
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 06:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF2220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B95456E3A2;
	Mon, 28 Oct 2019 06:44:12 +0000 (UTC)
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr810073.outbound.protection.outlook.com [40.107.81.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74FB36E39C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 06:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0A7js+AWWIRKObdtd+XzNWxD28Ou8dDUJUT7WN7pzIuPxnFuO7tlFZ04j2dLD7GzT4gIM4qweOlMCOBErN65N03f1WylZQpTv2OwtZb6HnMmUIRUeY/QpYfziyxw5AkoVnlMrX/DHCygdk7yhDBSoJWUtcqCc5h9XB4fg80Qj+3Tc5BCJ32x4FKNK2yv8f/fgqb5YNh2M1YFD6qcIjkihLDAU5VpRMholXq+P3f5iuJNnC7/SsQkNtdbokPq5ZTn4iRgBkIre3HSQfQlSBhbrMR2KwsDVBwuRcUsQFqnh8/4xfo7uNUTNAbnYaqqPtmpKxhAszS3svtd2iYubNYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBqpxdXaJAcWeqPQ5uSvgizhH2aQczfqcKw7yf9aN5c=;
 b=bY6/v9zlgygV9y+HDieUNf5Um3ukZVyvgTgfSweVtQxAhpFg4fSKm3Y3P/wMdIAs0TyM1grZf6w1uxl8+mK1p25YVnA96Od1LCHlxsphj89EITY85b+cEhHPcIfoR1DHa0+0fcNyLCHLY9XaooNarsn8Ads520V/DrtsgwhI4hayIvFCYThYC9h9YShMz716VR3UEnJs3JdgSTK3Nmrh/7lXO/7nYpDRUBGinrM+ze/ziu0fvW0IrSCb28s9asO6YLCBLpIX95m90wID4+Roi1p87ZFI/uFEdIcF1pvDd4f1I8SYNGq+I4xbviLpKqGZZv0Sr4+UIZP5mu6Xk3JAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from SN1PR12CA0088.namprd12.prod.outlook.com (2603:10b6:802:21::23)
 by BYAPR12MB2998.namprd12.prod.outlook.com (2603:10b6:a03:dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Mon, 28 Oct
 2019 06:44:08 +0000
Received: from DM3NAM03FT008.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::206) by SN1PR12CA0088.outlook.office365.com
 (2603:10b6:802:21::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20 via Frontend
 Transport; Mon, 28 Oct 2019 06:44:07 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT008.mail.protection.outlook.com (10.152.82.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 06:44:07 +0000
Received: from swae-HP-ProBook-455R-G6 (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 01:44:05 -0500
Date: Mon, 28 Oct 2019 14:38:13 +0800
From: Louis Li <ching-li@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH] UPSTREAM: drm/amd/display: Fix Apple dongle cannot be
 successfully detected
Message-ID: <20191028063813.GB8877@swae-HP-ProBook-455R-G6>
References: <20191021075439.1066-1-Ching-shih.Li@amd.com>
 <c125018e-ef0f-9c90-0d8b-81bee96faa71@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c125018e-ef0f-9c90-0d8b-81bee96faa71@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB02.amd.com (10.181.40.143) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(428003)(47660400002)(189003)(199004)(14444005)(50466002)(46406003)(7736002)(305945005)(81166006)(81156014)(8676002)(4001150100001)(8936002)(33716001)(6666004)(356004)(1076003)(5660300002)(33656002)(16586007)(58126008)(316002)(70206006)(54906003)(70586007)(386003)(53546011)(76176011)(26005)(16526019)(186003)(9686003)(478600001)(446003)(2906002)(55016002)(426003)(97756001)(23726003)(486006)(476003)(126002)(47776003)(3846002)(6116002)(229853002)(336012)(6862004)(6636002)(6246003)(4326008)(11346002)(46800400005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2998; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f76f5d50-0795-4674-3dbd-08d75b723b55
X-MS-TrafficTypeDiagnostic: BYAPR12MB2998:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29983C7EF50961BA0A095672AA660@BYAPR12MB2998.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Mt8Lxrpe6jxomC8tdJhj6eB1zfkDQJe5ZhJiKfoIez9PrQ8eqfquJuFUZQDJnCYHX3LOWONNWmweHD4YBnbaJKxBSgpy8MjG8JbMJoa1LlpDkXAIlJp1x9niiVCH6CFj+pSbIEHG+oU+pVAmDU4+9AG2QLq0hUnJEYaqhfy0Ke+H5PX5e9uxxqkhfyLx5CHPI/8of4RzYmDh9CKzBND3LSklIOiL/5r7ig5heK9Kf5T2fCj5qGpu/7rHQXar4mxaMHVz4xa9z9RtS73d1ccZmC5ppYn5iTLVFKSiqNym9fDKspkKylYS0XXJV8St5lMZx8dgNgFFQNfWEL1A/EiV3l7ySfdR1ikyQJ8vkaEyNQ1j8nvB3Fbz1ySnWMxo6bi93qc/7QZHHzG4CHu7mOZU9XqV5IO+CoATfku+6lLAEl5q4L4lXcco2pjm7n3Rxo6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 06:44:07.5205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76f5d50-0795-4674-3dbd-08d75b723b55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2998
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBqpxdXaJAcWeqPQ5uSvgizhH2aQczfqcKw7yf9aN5c=;
 b=qDG39oaM5OjvFc6Cj7HtyVvGasSnBazvEFw/ONf5SO4idZkrKMlbixFHs3iK3N3RfLIeeSpImdNBq/EmkTFi4VIm1asoGefTM47V1G5aM6npstNE30BgnGuLiRTw8KHkchyI93V8QKSIJVgQdDga9hyrNXj6AXB9X6auJa5ACzI=
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Ching-shih \(Louis\)" <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028063813.gQQ7VKHb7IydUd-hhotD-xIBBWVPAxjiC5qCTh_qcBc@z>

T24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgMDg6NDU6MThQTSArMDgwMCwgS2F6bGF1c2thcywgTmlj
aG9sYXMgd3JvdGU6Cj4gT24gMjAxOS0xMC0yMSAzOjU0IGEubS4sIExvdWlzIExpIHdyb3RlOgo+
ID4gW1doeV0KPiA+IEV4dGVybmFsIG1vbml0b3IgY2Fubm90IGJlIGRpc3BsYXllZCBjb25zaXN0
ZW50bHksIGlmIGNvbm5lY3RpbmcKPiA+IHZpYSB0aGlzIEFwcGxlIGRvbmdsZSAoQTE2MjEsIFVT
QiBUeXBlLUMgdG8gSERNSSkuCj4gPiBCeSBleHBlcmltZW50cywgaXQgaXMgY29uZmlybWVkIHRo
YXQgdGhlIGRvbmdsZSBuZWVkcyAyMDBtcyBhdCBsZWFzdAo+ID4gdG8gYmUgcmVhZHkgZm9yIGNv
bW11bmljYXRpb24sIGFmdGVyIGl0IHNldHMgSFBEIHNpZ25hbCBoaWdoLgo+ID4gCj4gPiBbSG93
XQo+ID4gV2hlbiByZWNlaXZpbmcgSFBEIElSUSwgZGVsYXkgNTAwbXMgYXQgdGhlIGJlZ2lubmlu
ZyBvZiBoYW5kbGVfaHBkX2lycSgpLgo+ID4gVGhlbiBydW4gdGhlIG9yaWdpbmFsIHByb2NlZHVy
ZS4KPiA+IFdpdGggdGhpcyBwYXRjaCBhcHBsaWVkLCB0aGUgcHJvYmxlbSBjYW5ub3QgYmUgcmVw
cm9kdWNlZC4KPiA+IFdpdGggb3RoZXIgZG9uZ2xlcywgdGVzdCByZXN1bHRzIGFyZSBQQVNTLgo+
ID4gVGVzdCByZXN1bHQgaXMgUEFTUyBhZnRlciBzeXN0ZW0gcmVzdW1lcyBmcm9tIHN1c3BlbmQu
Cj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IExvdWlzIExpIDxDaGluZy1zaGloLkxpQGFtZC5jb20+
Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYyB8IDUgKysrKysKPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+
ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1k
Z3B1X2RtLmMKPiA+IGluZGV4IDBhZWY5MmI3YzAzNy4uMDQzZGRhYzczODYyIDEwMDY0NAo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
Ywo+ID4gQEAgLTEwMjUsNiArMTAyNSwxMSBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfaHBkX2lycSh2
b2lkICpwYXJhbSkKPiA+ICAgCXN0cnVjdCBkcm1fZGV2aWNlICpkZXYgPSBjb25uZWN0b3ItPmRl
djsKPiA+ICAgCWVudW0gZGNfY29ubmVjdGlvbl90eXBlIG5ld19jb25uZWN0aW9uX3R5cGUgPSBk
Y19jb25uZWN0aW9uX25vbmU7Cj4gPiAgIAo+ID4gKyAgICAvKiBTb21lIG1vbml0b3JzL2Rvbmds
ZXMgbmVlZCBhcm91bmQgMjAwbXMgdG8gYmUgcmVhZHkgZm9yIGNvbW11bmljYXRpb24KPiA+ICsg
ICAgICogYWZ0ZXIgdGhleSBkcml2ZSBIUEQgc2lnbmFsIGhpZ2guCj4gPiArICAgICAqLwo+ID4g
KyAgICBtZGVsYXkoNTAwKTsKPiA+ICsKPiBUaGlzIHNvdW5kcyBtb3JlIGxpa2UgYSBxdWlyayB0
aGFuIGJlaGF2aW9yIHdlIHdhbnQgZm9yIGFsbCBtb25pdG9ycywgCj4gYnV0IHJlZ2FyZGxlc3Mg
dGhpcyBzbGVlcCBpc24ndCB0aGUgY29ycmVjdCBwbGFjZSBmb3IgdGhpcyAtIHNpbmNlIHRoaXMg
Cj4gaXMgYW4gaGlnaCBwcmlvcml0eSBpbnRlcnJ1cHQgaGFuZGxlciB0aGlzIGlzIHJlYWxseSBq
dXN0IGJsb2NraW5nIAo+IGV2ZXJ5dGhpbmcgZm9yIGhhbGYgYSBzZWNvbmQuCj4gCj4gSSB0aGlu
ayBpdCdkIG1ha2UgbW9yZSBzZW5zZSB0byBxdWV1ZSBvZmYgdGhlIHdvcmsgdG8gb2NjdXIgaGFs
ZiBhIAo+IHNlY29uZCBsYXRlci4KPiAKPiBOaWNob2xhcyBLYXpsYXVza2FzCj4gCgpZZXMsIEkg
YWdyZWUgd2l0aCB5b3VyIGNvbW1lbnRzLiBIb3dldmVyLCBkZWFsaW5nIHdpdGggbW9uaXRvcnMg
YW5kCmRvbmdsZXMsIGl0IGlzIHByb3ZlZCB0aGF0IHNvbWUgbW9uaXRvcnMvZG9uZ2xlcyBkb24n
dCB3b3JrIGFzIHRoZQp3YXkgcGVvcGxlIGV4cGVjdGVkLiBUaGUgc29sdXRpb24gbWFrZXMgc2Vu
c2UgdG8gaGF2ZSBvdXIgZHJpdmVyCmJldHRlciBjb21wYXRpYmlsaXR5IHRvIHdvcmsgd2l0aCBz
dWNoIGRldmljZXMuIFRydWx5LCBzaG91bGQgbm90CmJsb2NrIGhpZ2ggcHJpb3JpdHkgaW50ZXJy
dXB0LiBJIGhhZCBWMiBwYXRjaCB0byB1c2UgbXNsZWVwCmluc3RlYWQuIEN1c3RvbWVyIGlzIHZl
cmlmeWluZyBWMi4gV2lsbCBzdWJtaXQgb25jZSBpdCBwYXNzIHRlc3RzLgoKTG91aXMgTGkKCj4g
PiAgIAkvKiBJbiBjYXNlIG9mIGZhaWx1cmUgb3IgTVNUIG5vIG5lZWQgdG8gdXBkYXRlIGNvbm5l
Y3RvciBzdGF0dXMgb3Igbm90aWZ5IHRoZSBPUwo+ID4gICAJICogc2luY2UgKGZvciBNU1QgY2Fz
ZSkgTVNUIGRvZXMgdGhpcyBpbiBpdCdzIG93biBjb250ZXh0Lgo+ID4gICAJICovCj4gPiAKPiAK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
