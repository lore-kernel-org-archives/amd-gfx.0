Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EA2C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 13:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B132071F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 13:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B132071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B186EF28;
	Thu, 21 Nov 2019 13:41:30 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam05on060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe51::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056AB6EF28
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 13:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFGrUrzTpd5ztohDsiaVV8//cIzhBp0tAh1gDBxmnncSw7MUiSOJET837X90ORI8cJohpklKzcZoFAinbERbHjBXclm76yMiU3DRuBE8eAIQJ6b6U04ne3DVm91uGgUlJiMrAepc71mMrPo6szw4bNiePD9zLCwbj1KPXzUXYYM9xiay189cXpv21fyPJbqKdyWyAG0M3ADbnyDIvU2CmQ2wcOv3UAKzGn9oq52/LSMTYCcAufDeu54yBlPa4+csks+Spj5VF9qw3/DXnbGoKGodyhhDjzD5dVyFHlGJBocBrR9A1LbNBnFx8EYXSE/1LHMJz0TIWNN/AJnas/No8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOBj8rKggGsbrVzKBEPSlhNRntiVKFT3ztYKiQ3KP7Q=;
 b=ld54Z54PU26alhNQPkguf7IQai1d/pisGJe/n/54JUGbiTwO7FSSx2Ka+aGudZRKbwTh7TTlYKpj8WLPCybrpFCEVIRMnm7bjSz9UZitcS8molzabkYlSSwFhw4Ro9273avpvNIcdt1MUN+6weODLZBweYYcW0gXdicTRWMz75mPK37cuGGJTtjfScFHW8EHqvJRjDnmfA/lTIe84tX3l08mg7kxrGDWH0Mxp8Grz0b/JChoJ32HmZYPpKRO2nPLMTY+K5nqkSm7k/0O3BS+I0UY/CqkuT2UpOjFHEOlfjZhE36NTFbRZUvhSVVuFEvfQCknIIVYkODgQaL4Ef36Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB2664.namprd12.prod.outlook.com (20.176.255.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 21 Nov 2019 13:40:56 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0%7]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 13:40:56 +0000
Subject: Re: [PATCH v2] drm/amd/display: Fix Apple dongle cannot be
 successfully detected
To: "Li, Ching-shih (Louis)" <Ching-shih.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191114034212.1106-1-Ching-shih.Li@amd.com>
 <MN2PR12MB406250AEB8A10A080050D952AA4E0@MN2PR12MB4062.namprd12.prod.outlook.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <3c30b486-7062-ade2-0dbd-7288fbf595c1@amd.com>
Date: Thu, 21 Nov 2019 08:40:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <MN2PR12MB406250AEB8A10A080050D952AA4E0@MN2PR12MB4062.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec170e3a-4615-4007-5b90-08d76e886f68
X-MS-TrafficTypeDiagnostic: BYAPR12MB2664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB266465075EE76E16B06B8B94EC4E0@BYAPR12MB2664.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0228DDDDD7
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(47660400002)(13464003)(189003)(199004)(6486002)(66066001)(316002)(6246003)(58126008)(65956001)(4001150100001)(47776003)(110136005)(4326008)(65806001)(31696002)(31686004)(86362001)(99286004)(6512007)(36756003)(25786009)(2501003)(50466002)(478600001)(6436002)(229853002)(230700001)(7736002)(2906002)(14454004)(6116002)(3846002)(81166006)(81156014)(8936002)(8676002)(2616005)(66476007)(52116002)(26005)(386003)(53546011)(6506007)(2486003)(76176011)(66556008)(23676004)(6666004)(186003)(11346002)(446003)(305945005)(5660300002)(14444005)(66946007)(46800400005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2664;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDzqnMl1ViofxBY7BOjB2yQAo65c/tqILf71mZd+ausjEb/ra30ZiuqUqkiVOO5fZoxPegMKsGn5Y2nrcQcBg5nLoqMRUorF/Zm6JDeyV451SDBiU1NcE0y7RRillctmlZZXD+4UxRyaILqdjQZbtPxOQUx+g3yVD4g88qjpu+YflHEPAkNIKhNJKBLH6phd77PZqx0V1cDDR0vTvQGoY/cDgAZ0YiPGY6Fr0LtI+VbSPQSOx09YAdorea1AIFRKGpRbBS/UBuNFeHmYnQTVFbQNMkukY0NtwWe/rTpzl6E2LfZcSro/oihTVOQTuuyc3Qxyjuh4FH83XCekK7OKfxa3lqZhgDJ2YdFn802YJUfARdjU+2uwR73KWmox2sVIGTgWKc66H7dRSwmejSFUbueeYdQYSC+nIWmDt6LUtAJf2vZlSbsEsDlkKnV+r36Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec170e3a-4615-4007-5b90-08d76e886f68
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 13:40:56.1841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YolrbO8FxE0AmpY/zikBXxuABj43uBciJWjkE7u7G/lvTAiteSK6NJb2cZEyvJto2Xu56af28sQQ3RWN2WAf/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2664
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOBj8rKggGsbrVzKBEPSlhNRntiVKFT3ztYKiQ3KP7Q=;
 b=ak+xRI3VTgqJ49vFgtTm6fC4wSVhEkRky/uufgTEksDvx6gD28xjK7nBNNLz1A579gzOk8u+RJa6H+m7qT63VjNXtKBMArP8WBeBQ6Wi65kzuRcqMs1l3BtZew/ZzUzUwIT4lypO8AXcCbX/aXWsOll74bH6ytbp5Pw84+rloQQ=
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121134053.KOLBzJbeTDd9FDd_7O1rgnY7_EaiopK7Vt05bnoVySs@z>

T24gMjAxOS0xMS0yMSAzOjMxIGEubS4sIExpLCBDaGluZy1zaGloIChMb3Vpcykgd3JvdGU6Cj4g
SGkgcmV2aWV3ZXJzLAo+IAo+IFdoYXQgaXMgdGhlIHJldmlldyByZXN1bHQgZm9yIHRoaXMgcGF0
Y2g/IEN1c3RvbWVyIGlzIHB1c2hpbmcgb24gdGhpcyBjaGFuZ2UgdG8gbWVyZ2UuIFRLUyBmb3Ig
eW91ciBhdHRlbnRpb24uCj4gCj4gQlIsCj4gTG91aXMKPiAKPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQo+IEZyb206IExvdWlzIExpIDxDaGluZy1zaGloLkxpQGFtZC5jb20+Cj4gU2VudDog
VGh1cnNkYXksIE5vdmVtYmVyIDE0LCAyMDE5IDExOjQyIEFNCj4gVG86IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IEthemxhdXNrYXMsIE5pY2hvbGFzIDxOaWNob2xhcy5LYXps
YXVza2FzQGFtZC5jb20+OyBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+
OyBMaSwgQ2hpbmctc2hpaCAoTG91aXMpIDxDaGluZy1zaGloLkxpQGFtZC5jb20+Cj4gU3ViamVj
dDogW1BBVENIIHYyXSBkcm0vYW1kL2Rpc3BsYXk6IEZpeCBBcHBsZSBkb25nbGUgY2Fubm90IGJl
IHN1Y2Nlc3NmdWxseSBkZXRlY3RlZAo+IAo+IFtXaHldCj4gRXh0ZXJuYWwgbW9uaXRvciBjYW5u
b3QgYmUgZGlzcGxheWVkIGNvbnNpc3RlbnRseSwgaWYgY29ubmVjdGluZyB2aWEgdGhpcyBBcHBs
ZSBkb25nbGUgKEExNjIxLCBVU0IgVHlwZS1DIHRvIEhETUkpLgo+IEJ5IGV4cGVyaW1lbnRzLCBp
dCBpcyBjb25maXJtZWQgdGhhdCB0aGUgZG9uZ2xlIG5lZWRzIDIwMG1zIGF0IGxlYXN0IHRvIGJl
IHJlYWR5IGZvciBjb21tdW5pY2F0aW9uLCBhZnRlciBpdCBzZXRzIEhQRCBzaWduYWwgaGlnaC4K
PiAKPiBbSG93XQo+IFdoZW4gcmVjZWl2aW5nIEhQRCBJUlEsIGRlbGF5IDMwMG1zIGF0IHRoZSBi
ZWdpbm5pbmcgb2YgaGFuZGxlX2hwZF9pcnEoKS4KPiBUaGVuIHJ1biB0aGUgb3JpZ2luYWwgcHJv
Y2VkdXJlLgo+IFdpdGggdGhpcyBwYXRjaCBhcHBsaWVkLCB0aGUgcHJvYmxlbSBjYW5ub3QgYmUg
cmVwcm9kdWNlZC4KPiBXaXRoIG90aGVyIGRvbmdsZXMsIHRlc3QgcmVzdWx0cyBhcmUgUEFTUy4K
PiBUZXN0IHJlc3VsdCBpcyBQQVNTIHRvIHBsdWcgaW4gSERNSSBjYWJsZSB3aGlsZSBwbGF5aW5n
IHZpZGVvLCBhbmQgdGhlIHZpZGVvIGlzIGJlaW5nIHBsYXlpbmcgc21vb3RobHkuCj4gVGVzdCBy
ZXN1bHQgaXMgUEFTUyBhZnRlciBzeXN0ZW0gcmVzdW1lcyBmcm9tIHN1c3BlbmQuCj4gCj4gU2ln
bmVkLW9mZi1ieTogTG91aXMgTGkgPENoaW5nLXNoaWguTGlAYW1kLmNvbT4KClRoaXMgaXMgc3Rp
bGwgYSBOQUsgZnJvbSBtZSBzaW5jZSB0aGUgbG9naWMgaGFzbid0IGNoYW5nZWQgZnJvbSB0aGUg
CmZpcnN0IHBhdGNoLgoKU2xlZXBzIGRvbid0IGJlbG9uZyBpbiBJUlEgaGFuZGxlcnMuCgpSZWdh
cmRzLApOaWNob2xhcyBLYXpsYXVza2FzCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDUgKysrKysKPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBpbmRleCAwYWVmOTJiN2MwMzcuLjViODQ0YjZhNWE1
OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYwo+IEBAIC0xMDI1LDYgKzEwMjUsMTEgQEAgc3RhdGljIHZvaWQgaGFuZGxlX2hw
ZF9pcnEodm9pZCAqcGFyYW0pCj4gICAJc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IGNvbm5lY3Rv
ci0+ZGV2Owo+ICAgCWVudW0gZGNfY29ubmVjdGlvbl90eXBlIG5ld19jb25uZWN0aW9uX3R5cGUg
PSBkY19jb25uZWN0aW9uX25vbmU7Cj4gICAKPiArCS8qIFNvbWUgbW9uaXRvcnMvZG9uZ2xlcyBu
ZWVkIGFyb3VuZCAyMDBtcyB0byBiZSByZWFkeSBmb3IgY29tbXVuaWNhdGlvbgo+ICsJICogYWZ0
ZXIgdGhvc2UgZGV2aWNlcyBkcml2ZSBIUEQgc2lnbmFsIGhpZ2guCj4gKwkgKi8KPiArCW1zbGVl
cCgzMDApOwo+ICsKPiAgIAkvKiBJbiBjYXNlIG9mIGZhaWx1cmUgb3IgTVNUIG5vIG5lZWQgdG8g
dXBkYXRlIGNvbm5lY3RvciBzdGF0dXMgb3Igbm90aWZ5IHRoZSBPUwo+ICAgCSAqIHNpbmNlIChm
b3IgTVNUIGNhc2UpIE1TVCBkb2VzIHRoaXMgaW4gaXQncyBvd24gY29udGV4dC4KPiAgIAkgKi8K
PiAtLQo+IDIuMjEuMAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
