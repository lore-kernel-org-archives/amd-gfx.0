Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B11C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 08:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDBF206A1
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 08:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R1xQb0aM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDBF206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EA3D6E53E;
	Thu,  2 Jul 2020 08:27:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9EE76E53E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 08:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ionEQZhZERczV8fvMKkvVIMrnpfNFgtN/k97wJ4TCGP7i8hnvJD5FononLor2WXr8jgWYHHID8dITk5mfq1BmgTXYUWq/6XPUYEKlbREvSRhKm6hJlhZr2eEY3CbBkkxMTm57hKDv7XQd47fAZ25qhm3R1fzqbzwBmNby2Yk9FmS+jE8MGYK18mb0jwXuq7OdjiwbYNAyb1Y8aUwPY4DbdIoL0eAv6Gb5PJxTqFpj74fswyc9qUc3nu3TFfMWfLCUXacnyRQjpAnFgm8eVaRQRKtlT5Mr/h3LFaBdh3WG7wUjw3kI25clbZVvioswKmXvLqqNwn2NOnhq7BQEl2Jdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jic++Pjt+AbaWSXNM34Q9swXGEU/xIaLtpHNEd0dqL0=;
 b=IQVuPPrXesc24HWu4QIDm2VaymnGow8LV5bgVwBExBeTTrWoCKenWX+vykUA6+8vbSuB164WuXV1M9qMnG6SOkmqhWzO4h8rMLX3yR4kPuGZCNLpSKJJ02QI9rJWGtBfV5mrLQu6+deFotdUJ4R75b26kr/LzEzTUAg3qjmeb9soe7f42T+R8S719MbcPYzokyo1LHpYudkYzl/uFyZ9+9TKk2NUCgYDnnxR/qBsWs2/uwaWrINmdj4RPYH3enwrS60SJzSs6SvycaMiF1FV54x21yYf8/W5m84/1ogtiS8+MZVLutmNeBym5LeX5v/l54cTv/6EcwApRLHEZgOjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jic++Pjt+AbaWSXNM34Q9swXGEU/xIaLtpHNEd0dqL0=;
 b=R1xQb0aMhPLApiq0MHIJl6u1TGTJna5Ji/lqvmENd6JObjBJLniRIuCO48rIKBDN/2aTQ410XMTWWh4WJzyD+oBf2tG3QKfGwpJM5QY1my6MjAU03+pdpkxZbDuQyaN4X+IaYZMkqqG/NH762KDHmEuYJ7r7DFcc1xV3NTpJGOQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Thu, 2 Jul
 2020 08:27:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3153.021; Thu, 2 Jul 2020
 08:27:42 +0000
Subject: Re: [PATCH v2] gpu/drm: Remove debug info about CPU address
To: Tiezhu Yang <yangtiezhu@loongson.cn>, alexander.deucher@amd.com
References: <1593656863-1894-1-git-send-email-yangtiezhu@loongson.cn>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <85c81fa9-2994-d861-0690-a79600ed84b3@amd.com>
Date: Thu, 2 Jul 2020 10:27:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1593656863-1894-1-git-send-email-yangtiezhu@loongson.cn>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0003.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0003.eurprd02.prod.outlook.com (2603:10a6:208:3e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Thu, 2 Jul 2020 08:27:40 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92c488c9-fa4b-4491-db1e-08d81e61c953
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4110B8A4B2A55AAA2AA5EFA8836D0@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blRJRg2MZr0quI3406aqxLVUJALQK8KQ4zDTmzFzZx80JEyceuV5WM3ZZKjaLHFiZ1Skzd04eMY1qXLZep1RDDoqemakQYkoh6lrcB7+pGCIEaTQtYK1W7a6jWfkV+x7SxHJdCW0BYzUh63SgcoK7TphWD0lZBBCgbG/8x4pFcIEn2e9Krx2D8J3RZFNoTngaELh8KW5NxWtnXAm/JEsduf0a982PrPMT5EQrqbnA6iy2HcbHa7Y41RCBLt46VcZx41jajWB0dLTxu84a0A1ZR9X2+0vZI9hX/GjPAeKOvABUUlgvYJmVaWJOjIPcQEWYyM0XJomHbCVDGZ0NOF8rYR2HJOfv0gGbcL216VSjjL4npFHAIp6OulG3UPsbB6f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(2616005)(36756003)(86362001)(6486002)(6666004)(31696002)(4326008)(6636002)(316002)(16526019)(186003)(52116002)(31686004)(66574015)(2906002)(478600001)(5660300002)(8676002)(8936002)(66946007)(66556008)(83380400001)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: syVtL3tfWUCCzdaYLZsRLtmKJSChkMAkto+KP0epknEQvqkPAKVW8DaybxY1u1NHCbeDrJdE6vbYjmVFLs73ehMxWzJ7cH7RTfkEhhVzvqYF5d6EivKVx/vxlQsqw6dvqbZPQnMTDbV5Ye+7hrR4urdTRmDMUlG2LRG4WFurdpL6mfasza4MYhjqNtKSS2XCxWiyWa+bcRGnAKimzRJ0i40rAZ5sL4f3tnhbww0zdcGlKbpUpcwNif6NUFhIQ4xLCFwzjmX3PanU6x2KGHz0bZsI2aCiwRDsGjtU8sJQH/g2DF818UmhqU4c1zWC73g4zjYjEUyazfhFmAMMsvGwb4zRvWllQtPc+Y8zdT9VvJkEwQiev4NNdgVPI2XnhJhUhRbG1qmrkdNE2OyMYdN8nOcX48sU25lvxQAY/SW0wuQDTtxOetPot77VnfXSE0mhGqaf/c2S/F/BH0aWJUIrPHNHFeSVToP3maK46VxenizhFCNJ0x3a0NUOzLnFkg/Dh/FKJDtBXg9RTR0p/vX6RE1jxQljfbguQpMQi5Psgp9v4Awe3b2jpj+0zLjiFZgf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c488c9-fa4b-4491-db1e-08d81e61c953
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 08:27:41.9097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuSeSsRqmsD/koA1hC3ZRo/LTQRPYoobCYM+eJH3WjYRWA3h0s+fnUm7EdHj8MM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDcuMjAgdW0gMDQ6Mjcgc2NocmllYiBUaWV6aHUgWWFuZzoKPiBXaGVuIEkgdXBkYXRl
IHRoZSBsYXRlc3Qga2VybmVsLCBJIHNlZSB0aGUgZm9sbG93aW5nICJfX19fcHRydmFsX19fXyIg
Ym9vdAo+IG1lc3NhZ2VzLgo+Cj4gWyAgICAxLjg3MjYwMF0gcmFkZW9uIDAwMDA6MDE6MDUuMDog
ZmVuY2UgZHJpdmVyIG9uIHJpbmcgMCB1c2UgZ3B1IGFkZHIgMHgwMDAwMDAwMDQ4MDAwYzAwIGFu
ZCBjcHUgYWRkciAweChfX19fcHRydmFsX19fXykKPiBbICAgIDEuODc5MDk1XSByYWRlb24gMDAw
MDowMTowNS4wOiBmZW5jZSBkcml2ZXIgb24gcmluZyA1IHVzZSBncHUgYWRkciAweDAwMDAwMDAw
NDAwNTYwMzggYW5kIGNwdSBhZGRyIDB4KF9fX19wdHJ2YWxfX19fKQo+Cj4gQm90aCByYWRlb25f
ZmVuY2VfZHJpdmVyX3N0YXJ0X3JpbmcoKSBhbmQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zdGFydF9y
aW5nKCkKPiBoYXZlIHRoZSBzaW1pbGFyIGlzc3VlLCB0aGVyZSBleGlzdHMgdGhlIGZvbGxvd2lu
ZyB0d28gbWV0aG9kcyB0byBzb2x2ZSBpdDoKPiAoMSkgVXNlICIlcEsiIGluc3RlYWQgb2YgIiVw
IiBzbyB0aGF0IHRoZSBDUFUgYWRkcmVzcyBjYW4gYmUgcHJpbnRlZCB3aGVuCj4gdGhlIGtwdHJf
cmVzdHJpY3Qgc3lzY3RsIGlzIHNldCB0byAxLgo+ICgyKSBKdXN0IGNvbXBsZXRlbHkgZHJvcCB0
aGUgQ1BVIGFkZHJlc3Mgc3VnZ2VzdGVkIGJ5IENocmlzdGlhbiwgYmVjYXVzZQo+IHRoZSBDUFUg
YWRkcmVzcyB3YXMgdXNlZnVsIGluIHRoZSBwYXN0LCBidXQgaXNuJ3QgYW55IG1vcmUuIFdlIG5v
dyBoYXZlIGEKPiBkZWJ1Z2ZzIGZpbGUgdG8gcmVhZCB0aGUgY3VycmVudCBmZW5jZSB2YWx1ZXMu
Cj4KPiBTaW5jZSB0aGUgQ1BVIGFkZHJlc3MgaXMgbm90IG11Y2ggdXNlZnVsLCBqdXN0IHJlbW92
ZSB0aGUgZGVidWcgaW5mbyBhYm91dAo+IENQVSBhZGRyZXNzLgo+Cj4gU2lnbmVkLW9mZi1ieTog
VGllemh1IFlhbmcgPHlhbmd0aWV6aHVAbG9vbmdzb24uY24+CgpTcGxpdHRpbmcgaXQgaW50byBv
bmUgcGF0Y2ggZm9yIHJhZGVvbiBhbmQgb25lIGZvciBhbWRncHUgbWlnaHQgYmUgbmljZSAKdG8g
aGF2ZS4KCkJ1dCBlaXRoZXIgd2F5IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+IApmb3IgdGhlIHBhdGNoLgoKVGhhbmtzLApDaHJpc3RpYW4u
Cgo+IC0tLQo+Cj4gdjI6Cj4gICAgLSBKdXN0IHJlbW92ZSB0aGUgZGVidWcgaW5mbyBhYm91dCBD
UFUgYWRkcmVzcyBzdWdnZXN0ZWQgYnkgQ2hyaXN0aWFuCj4gICAgLSBNb2RpZnkgdGhlIHBhdGNo
IHN1YmplY3QgYW5kIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UKPgo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCA1ICsrLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9mZW5jZS5jICAgICB8IDQgKystLQo+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+IGluZGV4IGQ4NzhmZTcuLmEyOWYyZjkgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+IEBAIC00MjIsOSArNDIy
LDggQEAgaW50IGFtZGdwdV9mZW5jZV9kcml2ZXJfc3RhcnRfcmluZyhzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmcsCj4gICAJcmluZy0+ZmVuY2VfZHJ2LmlycV90eXBlID0gaXJxX3R5cGU7Cj4gICAJ
cmluZy0+ZmVuY2VfZHJ2LmluaXRpYWxpemVkID0gdHJ1ZTsKPiAgIAo+IC0JRFJNX0RFVl9ERUJV
RyhhZGV2LT5kZXYsICJmZW5jZSBkcml2ZXIgb24gcmluZyAlcyB1c2UgZ3B1IGFkZHIgIgo+IC0J
CSAgICAgICIweCUwMTZsbHgsIGNwdSBhZGRyIDB4JXBcbiIsIHJpbmctPm5hbWUsCj4gLQkJICAg
ICAgcmluZy0+ZmVuY2VfZHJ2LmdwdV9hZGRyLCByaW5nLT5mZW5jZV9kcnYuY3B1X2FkZHIpOwo+
ICsJRFJNX0RFVl9ERUJVRyhhZGV2LT5kZXYsICJmZW5jZSBkcml2ZXIgb24gcmluZyAlcyB1c2Ug
Z3B1IGFkZHIgMHglMDE2bGx4XG4iLAo+ICsJCSAgICAgIHJpbmctPm5hbWUsIHJpbmctPmZlbmNl
X2Rydi5ncHVfYWRkcik7Cj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZmVuY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2ZlbmNlLmMKPiBpbmRleCA0M2YyZjkzLi44NzM1YmYyIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ZlbmNlLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9mZW5jZS5jCj4gQEAgLTg2NSw4ICs4NjUsOCBAQCBpbnQg
cmFkZW9uX2ZlbmNlX2RyaXZlcl9zdGFydF9yaW5nKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2
LCBpbnQgcmluZykKPiAgIAl9Cj4gICAJcmFkZW9uX2ZlbmNlX3dyaXRlKHJkZXYsIGF0b21pYzY0
X3JlYWQoJnJkZXYtPmZlbmNlX2RydltyaW5nXS5sYXN0X3NlcSksIHJpbmcpOwo+ICAgCXJkZXYt
PmZlbmNlX2RydltyaW5nXS5pbml0aWFsaXplZCA9IHRydWU7Cj4gLQlkZXZfaW5mbyhyZGV2LT5k
ZXYsICJmZW5jZSBkcml2ZXIgb24gcmluZyAlZCB1c2UgZ3B1IGFkZHIgMHglMDE2bGx4IGFuZCBj
cHUgYWRkciAweCVwXG4iLAo+IC0JCSByaW5nLCByZGV2LT5mZW5jZV9kcnZbcmluZ10uZ3B1X2Fk
ZHIsIHJkZXYtPmZlbmNlX2RydltyaW5nXS5jcHVfYWRkcik7Cj4gKwlkZXZfaW5mbyhyZGV2LT5k
ZXYsICJmZW5jZSBkcml2ZXIgb24gcmluZyAlZCB1c2UgZ3B1IGFkZHIgMHglMDE2bGx4XG4iLAo+
ICsJCSByaW5nLCByZGV2LT5mZW5jZV9kcnZbcmluZ10uZ3B1X2FkZHIpOwo+ICAgCXJldHVybiAw
Owo+ICAgfQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
