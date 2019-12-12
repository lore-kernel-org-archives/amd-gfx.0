Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E210AC2D0C9
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 15:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0EB2173E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 15:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IiFCMCBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0EB2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D7FB6E1A5;
	Thu, 12 Dec 2019 15:58:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175F36E1A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 15:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSn4py0HDP91zFhSlZOR48UodyRapMBt2pD1nFRApmgkWSmA7GIIQF/2sBVoFS3tRyBFgxjp0OMrg4GSVzwrxdtEiwG2XoAeBCCTv2o9bwj4xKey9QQUNWVc7vI04x3KJ0+CK/5GZdBxiH58ywGyYxj+OvGmmNRgzwa0Oj7ghEy4Xx1zb6i+oeCyo0fXsf1XUQIEikeodqfUNNyChmOWyoZeuRldhozVxmkk+yr+x6Tc6aqG87lRzxLoEjD4mgPgxNDcjo8SGe+u8IoUnU6lwV43UN29oeDwL1Z+uljegu9W2Tl1Qe0p2nCZ3bQklXyr63L6BA9qF+jDrPT2gSN1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpbfdIjPD4HGzpOMlL9QmKi/FRqZqyyl2ZdcsCYFaik=;
 b=XoivElO44aX0UW9XCG1NXsZ7EuML1RH3V5DdqSgiuMRuFOZt7FgbBtw1WRZrUd9e3dLK8nylYsPQOis/tyRjCeHLtIbzwgI4vmOwcG8WCPM5C3li12Nj3xQ5MWD2iSzyUs3Appc3qTTHUNhBILiK0EkV1Xf0f83MyAOCJ8gEKkYqNzySOmKkKilUJ6f/M5tT1MEzfky9Kcm6SjiqKNilv5L0JRe9l4kd42hSaQ1cp0C3waxVw60D0kLEP+Ft3Ab285xj9degwpUenwQGzAfHo3BMJbP56zdZfzJWFf5U5xudtaI5R+lJtY015uz0j4zPWwo1bgkXM4sisp4qTUQx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpbfdIjPD4HGzpOMlL9QmKi/FRqZqyyl2ZdcsCYFaik=;
 b=IiFCMCBFk2t0VBvffrOxrwR7Qgnddn1XbTsQCZYgg9XYNUZJb70I5862N5GIAzHkRAJ0lZbg697uGVuEVrjnqLMUe0CQnUui0J8CSOulIMFUqSY+Wx811mhw/uSBWTGH0qV2uCsKmGvYOJotlGm3brKmZAt49w2TFdKhVOL2bB0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2568.namprd12.prod.outlook.com (52.132.141.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 12 Dec 2019 15:58:24 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 15:58:24 +0000
Subject: Re: [PATCH] drm/amdgpu: add JPEG check to VCN idle handler and begin
 use
To: Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191211194824.11146-1-leo.liu@amd.com>
 <05c7579c-d373-1367-35cc-e1f5f69dc7a4@gmail.com>
 <d08635c6-1d49-b0d7-1d47-99e69d98f432@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1a2bd02e-8803-24f3-6353-222a0da93ae7@amd.com>
Date: Thu, 12 Dec 2019 16:58:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <d08635c6-1d49-b0d7-1d47-99e69d98f432@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0056.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::33) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48293d6b-d9af-486b-8e96-08d77f1c1e23
X-MS-TrafficTypeDiagnostic: DM5PR12MB2568:|DM5PR12MB2568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2568CBCC41B59BA7F61EA08B83550@DM5PR12MB2568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(316002)(53546011)(52116002)(6506007)(86362001)(478600001)(6486002)(6512007)(81166006)(31696002)(8936002)(81156014)(8676002)(186003)(31686004)(5660300002)(66946007)(6666004)(2906002)(4001150100001)(66556008)(36756003)(2616005)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2568;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWRtPmThn/+f7+Vcx31gXOPHOpnJR1cj5yioW7qXeJHgsmBAQNI8Q/hmbqDC5h47KEa2WzYQld+1SH9r/2tdPkIj3Z9sO5YWB95rgTIIfxeIps+9ECresT2wIWky5SmE9c3wlaEiBgfmMz49R1DCYGiDGBrZaVe72R+0rKfebhq4HOtDMxxG3Ry4emttMN97MwpUipFX9u1CmKxVy2H3QZ51Ro/s9s00gC+cVaLrQXhLoBXzvgrOeKD45l2pGwqhAWkB7W1/JEwkRyhkpOw4gVZ/NB6V9gW/WB6cgRqA1pjVXbFZKH4URUe77xeSvAQgatzmJ1OuZsuwgOSv6wGHj5dc3kFM4ZxoZ38Bzb43uGBWeTGH2NcmTuAAIZdSYlM+dA2GE1GNhlgLA5KaR36Wh6jwAaAQQyXYfK1HWkbHL+I5kUDivZ/uHQD4I+KwIA3R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48293d6b-d9af-486b-8e96-08d77f1c1e23
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 15:58:24.0012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DS6oQyheshEV6nwtYR0R6I1iDCfMfOBJ/1Cd6rvVK0EZDCpaZIp/094Ce/v4OdqN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2568
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTIuMTIuMTkgdW0gMTY6NTcgc2NocmllYiBMZW8gTGl1Ogo+Cj4gT24gMjAxOS0xMi0xMiAz
OjE4IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDExLjEyLjE5IHVtIDIwOjQ4
IHNjaHJpZWIgTGVvIExpdToKPj4+IFNpbmNlIGl0J3Mgb25seSBuZWVkZWQgd2l0aCBWQ04xLjAg
d2hlbiBIVyBoYXMgbm8gaXRzCj4+PiBvd24gSlBFRyBIVyBJUCBibG9jawo+Pgo+PiBXb3VsZG4n
dCBpdCBiZSBzaW1wbGVyL2NsZWFuZXIgdG8ganVzdCBkZWZpbmUgYSAKPj4gdmNuX3YxXzBfcmlu
Z19iZWdpbl91c2UoKSBhbmQgdmNuX3YxXzBfaWRsZV93b3JrX2hhbmRsZXIoKSBpbnN0ZWFkPwo+
Cj4gWWVhaCwgdGhpcyB3YXkgc2hvdWxkIGJlIGNsZWFuZXIsIGV2ZW4gdGhvdWdoIHRoZSBjaGFu
Z2VzIGdvdCBiaWdnZXIsIAo+IHRoZSBuZXcgc2V0IHdpbGwgYmUgc2VudCBzaG9ydGx5LgoKS2Vl
cCBpbiBtaW5kIHRoYXQgeW91IGRvbid0IG5lZWQgdG8gZnVsbHkgY2xvbmUgdGhlIGNvZGUuCgpZ
b3UgcHJvYmFibHkgY2FuIHN0aWxsIGNhbGwgdGhlIGNvbW1vbiBWQ04gaGVscGVyIGNvZGUgcXVp
dGUgYSBiaXQuCgpDaHJpc3RpYW4uCgo+Cj4gVGhhbmtzLAo+Cj4gTGVvCj4KPgo+Cj4+Cj4+IFJl
Z2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1IDxs
ZW8ubGl1QGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uYyB8IDI5IAo+Pj4gKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+Pj4gwqAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIHzCoCAyICsrCj4+PiDCoCAy
IGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+Pj4KPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgCj4+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+Pj4gaW5kZXggNDI4
Y2ZkNThiMzdkLi45NWFjNzIxZjJkZTAgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92Y24uYwo+Pj4gQEAgLTE4Niw2ICsxODYsOSBAQCBpbnQgYW1kZ3B1X3Zjbl9z
d19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
IH0KPj4+IMKgwqDCoMKgwqAgfQo+Pj4gwqAgK8KgwqDCoCBhZGV2LT52Y24uaGFzX2pwZWdfYmxv
Y2sgPSAKPj4+IChhbWRncHVfZGV2aWNlX2lwX2dldF9pcF9ibG9jayhhZGV2LCBBTURfSVBfQkxP
Q0tfVFlQRV9KUEVHKSkgPwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHRydWUgOiBmYWxzZTsKPj4+ICsK
Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+PiDCoCB9Cj4+PiDCoCBAQCAtMzA2LDE1ICszMDks
MTcgQEAgc3RhdGljIHZvaWQgCj4+PiBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKHN0cnVj
dCB3b3JrX3N0cnVjdCAqd29yaykKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV3X3N0YXRlLmZ3X2Jhc2Vk
ID0gVkNOX0RQR19TVEFURV9fVU5QQVVTRTsKPj4+IMKgIC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIAo+Pj4gKGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT5qcGVnLmluc3Rbal0u
cmluZ19kZWMpKQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXdfc3RhdGUu
anBlZyA9IFZDTl9EUEdfU1RBVEVfX1BBVVNFOwo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZWxzZQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXdfc3RhdGUuanBlZyA9
IFZDTl9EUEdfU1RBVEVfX1VOUEFVU0U7Cj4+PiAtCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoIWFkZXYtPnZjbi5oYXNfanBlZ19ibG9jaykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAKPj4+IChhbWRncHVfZmVuY2VfY291bnRfZW1pdHRlZCgmYWRldi0+
anBlZy5pbnN0W2pdLnJpbmdfZGVjKSkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBuZXdfc3RhdGUuanBlZyA9IFZDTl9EUEdfU1RBVEVfX1BBVVNFOwo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV3X3N0YXRlLmpwZWcgPSBWQ05fRFBHX1NUQVRFX19VTlBB
VVNFOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYWRldi0+dmNuLnBhdXNlX2RwZ19tb2RlKGFkZXYsICZuZXdfc3RhdGUpOwo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+IMKgIC3CoMKgwqDCoMKgwqDCoCBmZW5jZVtqXSArPSAK
Pj4+IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT5qcGVnLmluc3Rbal0ucmluZ19k
ZWMpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghYWRldi0+dmNuLmhhc19qcGVnX2Jsb2NrKQo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmVuY2Vbal0gKz0gCj4+PiBhbWRncHVfZmVuY2Vf
Y291bnRfZW1pdHRlZCgmYWRldi0+anBlZy5pbnN0W2pdLnJpbmdfZGVjKTsKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBmZW5jZVtqXSArPSAKPj4+IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZh
ZGV2LT52Y24uaW5zdFtqXS5yaW5nX2RlYyk7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZmVuY2Vz
ICs9IGZlbmNlW2pdOwo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiBAQCAtMzU4LDE0ICszNjMsMTYgQEAg
dm9pZCBhbWRncHVfdmNuX3JpbmdfYmVnaW5fdXNlKHN0cnVjdCAKPj4+IGFtZGdwdV9yaW5nICpy
aW5nKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG5ld19zdGF0ZS5md19iYXNlZCA9IFZDTl9EUEdfU1RBVEVfX1VOUEFVU0U7Cj4+PiDC
oCAtwqDCoMKgwqDCoMKgwqAgaWYgCj4+PiAoYW1kZ3B1X2ZlbmNlX2NvdW50X2VtaXR0ZWQoJmFk
ZXYtPmpwZWcuaW5zdFtyaW5nLT5tZV0ucmluZ19kZWMpKQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbmV3X3N0YXRlLmpwZWcgPSBWQ05fRFBHX1NUQVRFX19QQVVTRTsKPj4+IC3CoMKgwqDC
oMKgwqDCoCBlbHNlCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXdfc3RhdGUuanBlZyA9
IFZDTl9EUEdfU1RBVEVfX1VOUEFVU0U7Cj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFhZGV2LT52
Y24uaGFzX2pwZWdfYmxvY2spIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIAo+Pj4g
KGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT5qcGVnLmluc3RbcmluZy0+bWVdLnJp
bmdfZGVjKSkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV3X3N0YXRlLmpw
ZWcgPSBWQ05fRFBHX1NUQVRFX19QQVVTRTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVs
c2UKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV3X3N0YXRlLmpwZWcgPSBW
Q05fRFBHX1NUQVRFX19VTlBBVVNFOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4+IMKgIMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAocmluZy0+ZnVuY3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdfVFlQRV9W
Q05fRU5DKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV3X3N0YXRlLmZ3X2Jhc2Vk
ID0gVkNOX0RQR19TVEFURV9fUEFVU0U7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgZWxzZSBpZiAocmlu
Zy0+ZnVuY3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdfVFlQRV9WQ05fSlBFRykKPj4+ICvCoMKgwqDC
oMKgwqDCoCBlbHNlIGlmICghYWRldi0+dmNuLmhhc19qcGVnX2Jsb2NrICYmIHJpbmctPmZ1bmNz
LT50eXBlID09IAo+Pj4gQU1ER1BVX1JJTkdfVFlQRV9WQ05fSlBFRykKPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG5ld19zdGF0ZS5qcGVnID0gVkNOX0RQR19TVEFURV9fUEFVU0U7Cj4+
PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+dmNuLnBhdXNlX2RwZ19tb2RlKGFkZXYsICZu
ZXdfc3RhdGUpOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y24uaCAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5o
Cj4+PiBpbmRleCA0MDJhNTA0NmI5ODUuLjlhMjM4MWQwMDZjNiAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaAo+Pj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+PiBAQCAtMTkyLDYgKzE5Miw4IEBAIHN0
cnVjdCBhbWRncHVfdmNuIHsKPj4+IMKgwqDCoMKgwqAgdW5zaWduZWTCoMKgwqAgaGFydmVzdF9j
b25maWc7Cj4+PiDCoMKgwqDCoMKgIGludCAoKnBhdXNlX2RwZ19tb2RlKShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZHBnX3BhdXNlX3N0
YXRlICpuZXdfc3RhdGUpOwo+Pj4gKwo+Pj4gK8KgwqDCoCBib29sIGhhc19qcGVnX2Jsb2NrOwo+
Pj4gwqAgfTsKPj4+IMKgIMKgIGludCBhbWRncHVfdmNuX3N3X2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpOwo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
