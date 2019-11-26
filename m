Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36B2C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 14:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2872071A
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 14:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2872071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DE36E118;
	Tue, 26 Nov 2019 14:53:15 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730080.outbound.protection.outlook.com [40.107.73.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 074B36E118
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 14:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQRBDjevWteYKrMcP0lCq+EA+1ZZ5XRGH0+44dZFX9qSBBVE3PgWqZQDLeLIpdyq7cx9guWuSU/mqsUcQRvyFilvlIDQuyX8HuEgi30j1pEsnQtSzVGW7qpu1LbLYkgESRh/rEuMDt6ZQ3ueGKXhlGmAb0nz+RGKZqyji7mrxvMqVZUTqHKrjuj3AZKlhZdcZfkfDVjP3IFcJcw+xigB/ZiDSI7IyE1GzAvuHYcU/0qdI6duOZrAlfKzeQxWDYfuwDUNi0Fwd654n4pmfkGuS7Klsp2QkySlUKDwyasgVgL3eSeLUAmSFOQvxtgbbkW+AFmi666LWMBNVGuyZoCq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2IPdXvgWuZ4jA/Mgos2zwGvVQfzzq4yRkUUKDbpcdg=;
 b=DXJyVEOnUhESAdTbqiGFrNbnjH8B8/kDSxgibqE4vFV4aMC6jgNUCPe5PxM5E6RMs7R8jND9FAWodegTHXH/w9PrBg6hnPATJ1ZVpbRqBURA2KS86Of/fmE3/A313lQkVSvXpq+B2ahFtekCivQBiIt537Y49wxObZYvh56sWMMg7ylg3wkft30Jl+oHOm6atvNvTIRvi4aeXBcDj77pAUzTVkSZFaPY7Fj2+iMlK2jB+O8Op1cUA62k0DAD854jDCDHcHkykl0dWU9Ttq6k9aYJt6Eq08Jwba+GwDC52DasEahq9jU1xQqpB+NkVZESrBAWhewMdY5Gw8vt/KGElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3304.namprd12.prod.outlook.com (20.179.93.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Tue, 26 Nov 2019 14:53:12 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 14:53:12 +0000
Subject: Re: drm/amd/display: Modify comments to match the code
To: Zhan liu <zhan.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191126144656.55811-1-zhan.liu@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <d6643c71-0d89-9ba6-da16-6e61825337c0@amd.com>
Date: Tue, 26 Nov 2019 09:53:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191126144656.55811-1-zhan.liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::44) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93af8eb4-a256-4279-e4c0-08d772805bb3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3304:|BYAPR12MB3304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB330447ABF1CF1EDE5D495AD7EC450@BYAPR12MB3304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(2906002)(86362001)(25786009)(3846002)(305945005)(229853002)(7736002)(66066001)(66556008)(66476007)(66946007)(58126008)(65956001)(6436002)(230700001)(47776003)(6506007)(6486002)(386003)(53546011)(23676004)(2486003)(52116002)(76176011)(8676002)(26005)(50466002)(6116002)(186003)(5660300002)(99286004)(6666004)(478600001)(2616005)(65806001)(31686004)(31696002)(316002)(14454004)(4001150100001)(11346002)(446003)(8936002)(36756003)(14444005)(6512007)(81156014)(81166006)(6246003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3304;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4FJ40ytRhFPavgcMeotQ7x06X5aGJ9rzdfEFwA6p5CtLsKhn6GxgKhDSl2BCAwjHUPy0XRIOS/SknNOz/zwrqWthytIlIeY8Mhuq9De8TOtKUd4WbGSx0FhtIdiI0IHtEa3aRRKrZrlhhY/myOGEwcJUteRGeG8RQj31m+l/Y7hbNSBr4vXfYE3qpllRKqz3BCC/IWGBOKCVD5/Ej45vOqWq+cyLNtIobPp/qToJdPSY46qO6mvCwyO3lLXkar8GbuDV3zCbXBBIY6bX7vwNK2Dp8P+uPKkcsG4/lLCswUULQAmni6lPSs/xm0UZDuX0ukK5oD08/54ecLwS9DkwdROr6OXAlQhqXFyLz5uZr9byCIvtme7YZAf2CinVWr7BAgsjTWOC+roN6KNwbARE3wM2djL4VEgYTJPTAKfgOAGprtVh6vSuDhVeLMq4vOJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93af8eb4-a256-4279-e4c0-08d772805bb3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 14:53:11.8629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLl7GlYra2yhns2CAK5aqXHq8FaTKWnRxf1739+hxRq3jKiOWie7Oe1I6+ennJlF/INnl8dgOMGDjjy0nUZP/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3304
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2IPdXvgWuZ4jA/Mgos2zwGvVQfzzq4yRkUUKDbpcdg=;
 b=a+e9IHVIR0pJSxenoBZVi/BYdTdjIMVYdsxYYn8pSx/bAPf1PYp4ySw/XxdzJ11D617ZpYYr9Ty1nSOq5f1M91qRwKnpxP9oOwSwxGnIDCVQoh557O+qc5CAH+OY5zY3w25qkc0D5Z99UBCXqkCT8SLS3xYOemeOnVTNiVb+GDI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Message-ID: <20191126145308.d6m0eayNyoXlh6HdPCKH4BJz4XZYQOyOWkpn_G3uvg4@z>

T24gMjAxOS0xMS0yNiA5OjQ2IGEubS4sIFpoYW4gbGl1IHdyb3RlOgo+IFtXaHldCj4gVGhpcyBs
aW5lIG9mIGNvZGUgd2FzIG1vZGlmaWVkLiBIb3dldmVyLCBjb21tZW50cwo+IHJlbWFpbmVkIHVu
Y2hhbmdlZC4gQXMgYSByZXN1bHQsIGNvbW1lbnRzIGFuZCBjb2RlIGFyZQo+IG1pc21hdGNoaW5n
Lgo+IAo+IFtIb3ddCj4gTW9kaWZ5aW5nIGNvbW1lbnRzIHRvIHJlZmxlY3QgY29kZS4gQXQgdGhl
IHNhbWUgdGltZSwKPiBleHBsYWluaW5nIHdoeSB0aGUgdmFsdWUgd2FzIGNoYW5nZWQgZnJvbSAy
MDBtcyB0bwo+IDMwMDBtcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBaaGFuIExpdSA8emhhbi5saXVA
YW1kLmNvbT4KClJldmlld2VkLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXps
YXVza2FzQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjX2hlbHBlci5jIHwgNyArKysrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY19oZWxwZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y19oZWxwZXIuYwo+IGluZGV4IDhkYTQ1NzZlMjkwOC4uZTQxYmVmYTA2N2NlIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19oZWxwZXIuYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19oZWxwZXIuYwo+IEBAIC00ODUsNyArNDg1
LDEyIEBAIHZvaWQgZ2VuZXJpY19yZWdfd2FpdChjb25zdCBzdHJ1Y3QgZGNfY29udGV4dCAqY3R4
LAo+ICAgCQlyZXR1cm47Cj4gICAJfQo+ICAgCj4gLQkvKiBzb21ldGhpbmcgaXMgdGVycmlibHkg
d3JvbmcgaWYgdGltZSBvdXQgaXMgPiAyMDBtcy4gKDVIeikgKi8KPiArCS8qCj4gKwkgKiBTb21l
dGhpbmcgaXMgdGVycmlibHkgd3JvbmcgaWYgdGltZSBvdXQgaXMgPiAzMDAwbXMuCj4gKwkgKiAz
MDAwbXMgaXMgdGhlIG1heGltdW0gdGltZSBuZWVkZWQgZm9yIFNNVSB0byBwYXNzIHZhbHVlcyBi
YWNrLgo+ICsJICogVGhpcyB2YWx1ZSBjb21lcyBmcm9tIGV4cGVyaW1lbnRzLgo+ICsJICoKPiAr
CSAqLwo+ICAgCUFTU0VSVChkZWxheV9iZXR3ZWVuX3BvbGxfdXMgKiB0aW1lX291dF9udW1fdHJp
ZXMgPD0gMzAwMDAwMCk7Cj4gICAKPiAgIAlmb3IgKGkgPSAwOyBpIDw9IHRpbWVfb3V0X251bV90
cmllczsgaSsrKSB7Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
