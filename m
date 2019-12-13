Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776A1C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 00:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D5B2073B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 00:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FQ0Yavzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D5B2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F906E248;
	Fri, 13 Dec 2019 00:34:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD4F6E248
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 00:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAiHEzv5iG0PI0BbtM6AV7Iz0wbg3IICgrKJK0K41yx5Zv2zcCZ+lm7y4exDEwCzmm0Cez1swg0S8HDodnnE5j6e+1FjDZlvZsEfm0Yz04leAXouSwUvtbOU4OLKFUiEiCHDCmMtdmVBm6l2nCrsCWUxitFapJwzkxmpEiz+F/Or3N0vhjdvwfPN9TiLvl+Sj3qTMIv2R1GaojBj3TrmTMo/+oJIPKKU4TyA+v1CBD7ncF2D1hMOSsjgBF1Hl1yHf5C5BjFxMO78w62b7a3WgDUfp8ZpNiw3TilBH79wLTWdOmWMzzYmZQt8SLKuXpd4bOVZPa2HBfZpV3SyL+oIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfyEwSRaMvmEMPB5WwRgfHSIBx2a1/yDrNvflqlM28M=;
 b=A2qJc4G6ohJDBEZa4O5EOLhiSgh8u1bXcBANxQtMfMzMUDLYiFafTQcdEyWa9gEbjdCpIAL2nLUox3nebOoG02SC+n1vezLyWrCcj75syoottU0z5iLS/Pd7l6TGDxML7M+9Aoi29bLZzV2QCQc/HQpU6IXGNeu+7m0szCXQqXc5Q4llF9tn1IfEoCkrRgmwnP3BiuPc+bMk4D99qvNSJo+sEbV6jW0XlE51mW/RsRh6MdFxSZdoIy1kupKUtpqVl+W+1830YAbRLPJFQfKJrc/UcTMVNduq4WeGGB867pEcTwv9iG80Sl2/cGRWs1CeUOyKeVdGBQvuInnDfTKUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfyEwSRaMvmEMPB5WwRgfHSIBx2a1/yDrNvflqlM28M=;
 b=FQ0Yavzt3KmGXiHN+w1j9VnV31bro67spxTQnqRnXzycpQmZuLVQfMsCrqSgyOo4lLn+FjbDzkqDVfsd5/L/27Fh8bZ5g8S+JPtJpZ/mvtlGp4hZs+dGYSiV4ZeX+gdA+aWBhWoDiYRQnhV/wveBk+xH3JJWFKxLdIg1iNGRrQ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0092.namprd12.prod.outlook.com (10.174.106.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Fri, 13 Dec 2019 00:34:03 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2516.018; Fri, 13 Dec 2019
 00:34:03 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Add Arcturus specific
 set_vm_context_page_table_base()
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191203044215.29605-1-Yong.Zhao@amd.com>
 <20191203044215.29605-2-Yong.Zhao@amd.com>
 <82eaab73-939f-4d0c-1984-46304d92a469@amd.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <82409992-e7c4-076a-0eae-b2dcecd68d26@amd.com>
Date: Thu, 12 Dec 2019 19:34:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <82eaab73-939f-4d0c-1984-46304d92a469@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::44) To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a03dca7-cb3a-4e99-e717-08d77f642746
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0092:|DM5PR1201MB0092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0092D189EFE17F0EF7DE202DF0540@DM5PR1201MB0092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0250B840C1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(199004)(189003)(66556008)(52116002)(316002)(6506007)(66946007)(66476007)(53546011)(6512007)(44832011)(2906002)(31686004)(478600001)(36756003)(2616005)(8936002)(186003)(81166006)(81156014)(8676002)(86362001)(26005)(31696002)(4001150100001)(6486002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0092;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sW7eLD43bzE6onzxjgQqTIXyU5PGmodURKtMffff/DPlBlEhGAl7YDZMw6UbDuC91w76Ci3TRu5x6/w4oNxCzYazvat4ueBgs8CmuMEGtc/qS1RUPEA8Yf9VAD/9uPsTtz7aIsyCGBuCrULN55t8I57QXK5zVVu6Jeuh7U+SnUFzlldO4Tn3qr6L9R8hPVPOnxKJw2rjA4uwVU6NNCDcCpX0NguA7vtdM+Z67oS1N3/asSSsKrDOW7ZTvjO9XfNPY+fRkYuZ+b9Wbv4/3A2/t5coEHbVuHVFOFBZ5JAlIKDUPkKPvZX2wP9ZkYjoM+xk6v6VLUWiy2An8QRlx6pJzgzUqEmEdQ3M+OceOLp3m0KAmth9CW9tE8kLpbxxTlUgBWKnIZT+i5cpH7JW4xtAPFq30y7Dw1I6q3V6Bae36ASWCOubf2GSnPgIa76yk7QD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a03dca7-cb3a-4e99-e717-08d77f642746
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 00:34:03.0648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkLeC1FNYlKKH8ei0/tsK566HFHh1fVAb9OenmnBt4Qk8dSUaOYveMOvhzlIsYnY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0092
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

VGhlIGZpcnN0IG9uZSB3YXMgYWxyZWFkeSBmaXhlZCBhbmQgcHVzaGVkIGEgd2VlayBhZ28uCgpS
ZWdhcmRzLAoKWW9uZwoKT24gMjAxOS0xMi0xMiA3OjI1IHAubS4sIEZlbGl4IEt1ZWhsaW5nIHdy
b3RlOgo+IEkgYWdyZWUgd2l0aCBDaHJpc3RpYW4ncyBjb21tZW50cyBvbiBwYXRjaCAxLiBXaXRo
IHRob3NlIGZpeGVkLCB0aGUgCj4gc2VyaWVzIGlzCj4KPiBSZXZpZXdlZC1ieTogRmVsaXggS3Vl
aGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4KPiBSZWdhcmRzLAo+IMKgIEZlbGl4Cj4K
PiBPbiAyMDE5LTEyLTAyIDIwOjQyLCBZb25nIFpoYW8gd3JvdGU6Cj4+IFNpbmNlIEFyY3R1cnVz
IGhhcyBpdCBvd24gZnVuY3Rpb24gcG9pbnRlciwgd2UgY2FuIG1vdmUgQXJjdHVydXMKPj4gc3Bl
Y2lmaWMgbG9naWMgdG8gdGhlcmUgcmF0aGVyIHRoYW4gbGVhdmluZyBpdCBlbnRhbmdsZWQgd2l0
aAo+PiBvdGhlciBHRlg5IGNoaXBzLgo+Pgo+PiBDaGFuZ2UtSWQ6IEk3ZGY3YzAwNGEwYzhhYzA2
MTZkZWQwZTY1MTQ0NjcwZGY1MGY5MmE3Cj4+IFNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9u
Zy5aaGFvQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCAuLi4vZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9hcmN0dXJ1cy5jwqDCoCB8IDIwICsrKysrKysrKysrKysrKysrKy0KPj4gwqAgLi4uL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jIHwgMTQgKysrLS0tLS0tLS0t
LQo+PiDCoCAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmggfMKg
IDIgLS0KPj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlv
bnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfYXJjdHVydXMuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkX2FyY3R1cnVzLmMKPj4gaW5kZXggYjY3MTNlMGVkMWIyLi4zYzExOTQwN2RjMzQg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
YXJjdHVydXMuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkX2FyY3R1cnVzLmMKPj4gQEAgLTQ2LDYgKzQ2LDggQEAKPj4gwqAgI2luY2x1ZGUgInNvYzE1
LmgiCj4+IMKgICNpbmNsdWRlICJzb2MxNWQuaCIKPj4gwqAgI2luY2x1ZGUgImFtZGdwdV9hbWRr
ZmRfZ2Z4X3Y5LmgiCj4+ICsjaW5jbHVkZSAiZ2Z4aHViX3YxXzAuaCIKPj4gKyNpbmNsdWRlICJt
bWh1Yl92OV80LmgiCj4+IMKgIMKgICNkZWZpbmUgSFFEX05fUkVHUyA1Ngo+PiDCoCAjZGVmaW5l
IERVTVBfUkVHKGFkZHIpIGRvIHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiBA
QCAtMjU4LDYgKzI2MCwyMiBAQCBzdGF0aWMgaW50IGtnZF9ocWRfc2RtYV9kZXN0cm95KHN0cnVj
dCBrZ2RfZGV2IAo+PiAqa2dkLCB2b2lkICptcWQsCj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+
IMKgIH0KPj4gwqAgK3N0YXRpYyB2b2lkIGtnZF9zZXRfdm1fY29udGV4dF9wYWdlX3RhYmxlX2Jh
c2Uoc3RydWN0IGtnZF9kZXYgCj4+ICprZ2QsIHVpbnQzMl90IHZtaWQsCj4+ICvCoMKgwqDCoMKg
wqDCoCB1aW50NjRfdCBwYWdlX3RhYmxlX2Jhc2UpCj4+ICt7Cj4+ICvCoMKgwqAgc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSBnZXRfYW1kZ3B1X2RldmljZShrZ2QpOwo+PiArCj4+ICvCoMKg
wqAgaWYgKCFhbWRncHVfYW1ka2ZkX2lzX2tmZF92bWlkKGFkZXYsIHZtaWQpKSB7Cj4+ICvCoMKg
wqDCoMKgwqDCoCBwcl9lcnIoInRyeWluZyB0byBzZXQgcGFnZSB0YWJsZSBiYXNlIGZvciB3cm9u
ZyBWTUlEICV1XG4iLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2bWlkKTsKPj4g
K8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCBtbWh1
Yl92OV80X3NldHVwX3ZtX3B0X3JlZ3MoYWRldiwgdm1pZCwgcGFnZV90YWJsZV9iYXNlKTsKPj4g
Kwo+PiArwqDCoMKgIGdmeGh1Yl92MV8wX3NldHVwX3ZtX3B0X3JlZ3MoYWRldiwgdm1pZCwgcGFn
ZV90YWJsZV9iYXNlKTsKPj4gK30KPj4gKwo+PiDCoCBjb25zdCBzdHJ1Y3Qga2ZkMmtnZF9jYWxs
cyBhcmN0dXJ1c19rZmQya2dkID0gewo+PiDCoMKgwqDCoMKgIC5wcm9ncmFtX3NoX21lbV9zZXR0
aW5ncyA9IGtnZF9nZnhfdjlfcHJvZ3JhbV9zaF9tZW1fc2V0dGluZ3MsCj4+IMKgwqDCoMKgwqAg
LnNldF9wYXNpZF92bWlkX21hcHBpbmcgPSBrZ2RfZ2Z4X3Y5X3NldF9wYXNpZF92bWlkX21hcHBp
bmcsCj4+IEBAIC0yNzcsNyArMjk1LDcgQEAgY29uc3Qgc3RydWN0IGtmZDJrZ2RfY2FsbHMgYXJj
dHVydXNfa2ZkMmtnZCA9IHsKPj4gwqDCoMKgwqDCoCAuZ2V0X2F0Y192bWlkX3Bhc2lkX21hcHBp
bmdfaW5mbyA9Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtnZF9nZnhfdjlfZ2V0X2F0
Y192bWlkX3Bhc2lkX21hcHBpbmdfaW5mbywKPj4gwqDCoMKgwqDCoCAuZ2V0X3RpbGVfY29uZmln
ID0ga2dkX2dmeF92OV9nZXRfdGlsZV9jb25maWcsCj4+IC3CoMKgwqAgLnNldF92bV9jb250ZXh0
X3BhZ2VfdGFibGVfYmFzZSA9IAo+PiBrZ2RfZ2Z4X3Y5X3NldF92bV9jb250ZXh0X3BhZ2VfdGFi
bGVfYmFzZSwKPj4gK8KgwqDCoCAuc2V0X3ZtX2NvbnRleHRfcGFnZV90YWJsZV9iYXNlID0gCj4+
IGtnZF9zZXRfdm1fY29udGV4dF9wYWdlX3RhYmxlX2Jhc2UsCj4+IMKgwqDCoMKgwqAgLmludmFs
aWRhdGVfdGxicyA9IGtnZF9nZnhfdjlfaW52YWxpZGF0ZV90bGJzLAo+PiDCoMKgwqDCoMKgIC5p
bnZhbGlkYXRlX3RsYnNfdm1pZCA9IGtnZF9nZnhfdjlfaW52YWxpZGF0ZV90bGJzX3ZtaWQsCj4+
IMKgwqDCoMKgwqAgLmdldF9oaXZlX2lkID0gYW1kZ3B1X2FtZGtmZF9nZXRfaGl2ZV9pZCwKPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4
X3Y5LmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhf
djkuYwo+PiBpbmRleCA2ZjFhNDY3NmRkZGUuLmU3ODYxZjBlZjQxNSAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYwo+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jCj4+IEBA
IC00MCw3ICs0MCw2IEBACj4+IMKgICNpbmNsdWRlICJzb2MxNWQuaCIKPj4gwqAgI2luY2x1ZGUg
Im1taHViX3YxXzAuaCIKPj4gwqAgI2luY2x1ZGUgImdmeGh1Yl92MV8wLmgiCj4+IC0jaW5jbHVk
ZSAibW1odWJfdjlfNC5oIgo+PiDCoCDCoCDCoCBlbnVtIGhxZF9kZXF1ZXVlX3JlcXVlc3RfdHlw
ZSB7Cj4+IEBAIC03NTgsOCArNzU3LDggQEAgdWludDMyX3QgCj4+IGtnZF9nZnhfdjlfYWRkcmVz
c193YXRjaF9nZXRfb2Zmc2V0KHN0cnVjdCBrZ2RfZGV2ICprZ2QsCj4+IMKgwqDCoMKgwqAgcmV0
dXJuIDA7Cj4+IMKgIH0KPj4gwqAgLXZvaWQga2dkX2dmeF92OV9zZXRfdm1fY29udGV4dF9wYWdl
X3RhYmxlX2Jhc2Uoc3RydWN0IGtnZF9kZXYgCj4+ICprZ2QsIHVpbnQzMl90IHZtaWQsCj4+IC3C
oMKgwqDCoMKgwqDCoCB1aW50NjRfdCBwYWdlX3RhYmxlX2Jhc2UpCj4+ICtzdGF0aWMgdm9pZCBr
Z2RfZ2Z4X3Y5X3NldF92bV9jb250ZXh0X3BhZ2VfdGFibGVfYmFzZShzdHJ1Y3Qga2dkX2RldiAK
Pj4gKmtnZCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qgdm1pZCwgdWludDY0
X3QgcGFnZV90YWJsZV9iYXNlKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSBnZXRfYW1kZ3B1X2RldmljZShrZ2QpOwo+PiDCoCBAQCAtNzY5LDE0ICs3
NjgsNyBAQCB2b2lkIAo+PiBrZ2RfZ2Z4X3Y5X3NldF92bV9jb250ZXh0X3BhZ2VfdGFibGVfYmFz
ZShzdHJ1Y3Qga2dkX2RldiAqa2dkLCAKPj4gdWludDMyX3Qgdm1pCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm47Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCAtwqDCoMKgIC8qIFRPRE86IHRha2Ug
YWR2YW50YWdlIG9mIHBlci1wcm9jZXNzIGFkZHJlc3Mgc3BhY2Ugc2l6ZS4gRm9yCj4+IC3CoMKg
wqDCoCAqIG5vdywgYWxsIHByb2Nlc3NlcyBzaGFyZSB0aGUgc2FtZSBhZGRyZXNzIHNwYWNlIHNp
emUsIGxpa2UKPj4gLcKgwqDCoMKgICogb24gR0ZYOCBhbmQgb2xkZXIuCj4+IC3CoMKgwqDCoCAq
Lwo+PiAtwqDCoMKgIGlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9BUkNUVVJVUykgewo+PiAt
wqDCoMKgwqDCoMKgwqAgbW1odWJfdjlfNF9zZXR1cF92bV9wdF9yZWdzKGFkZXYsIHZtaWQsIHBh
Z2VfdGFibGVfYmFzZSk7Cj4+IC3CoMKgwqAgfSBlbHNlCj4+IC3CoMKgwqDCoMKgwqDCoCBtbWh1
Yl92MV8wX3NldHVwX3ZtX3B0X3JlZ3MoYWRldiwgdm1pZCwgcGFnZV90YWJsZV9iYXNlKTsKPj4g
K8KgwqDCoCBtbWh1Yl92MV8wX3NldHVwX3ZtX3B0X3JlZ3MoYWRldiwgdm1pZCwgcGFnZV90YWJs
ZV9iYXNlKTsKPj4gwqAgwqDCoMKgwqDCoCBnZnhodWJfdjFfMF9zZXR1cF92bV9wdF9yZWdzKGFk
ZXYsIHZtaWQsIHBhZ2VfdGFibGVfYmFzZSk7Cj4+IMKgIH0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmggCj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuaAo+PiBpbmRleCBkOWU5
YWQyMmIyYmQuLjAyYjE0MjZkMTdkMSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5oCj4+IEBAIC01Nyw4ICs1Nyw2IEBAIHVp
bnQzMl90IGtnZF9nZnhfdjlfYWRkcmVzc193YXRjaF9nZXRfb2Zmc2V0KHN0cnVjdCAKPj4ga2dk
X2RldiAqa2dkLAo+PiDCoCDCoCBib29sIGtnZF9nZnhfdjlfZ2V0X2F0Y192bWlkX3Bhc2lkX21h
cHBpbmdfaW5mbyhzdHJ1Y3Qga2dkX2RldiAqa2dkLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDhfdCB2bWlkLCB1aW50MTZfdCAqcF9wYXNpZCk7Cj4+
IC12b2lkIGtnZF9nZnhfdjlfc2V0X3ZtX2NvbnRleHRfcGFnZV90YWJsZV9iYXNlKHN0cnVjdCBr
Z2RfZGV2ICprZ2QsIAo+PiB1aW50MzJfdCB2bWlkLAo+PiAtwqDCoMKgwqDCoMKgwqAgdWludDY0
X3QgcGFnZV90YWJsZV9iYXNlKTsKPj4gwqAgaW50IGtnZF9nZnhfdjlfaW52YWxpZGF0ZV90bGJz
KHN0cnVjdCBrZ2RfZGV2ICprZ2QsIHVpbnQxNl90IHBhc2lkKTsKPj4gwqAgaW50IGtnZF9nZnhf
djlfaW52YWxpZGF0ZV90bGJzX3ZtaWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDE2X3QgCj4+
IHZtaWQpOwo+PiDCoCBpbnQga2dkX2dmeF92OV9nZXRfdGlsZV9jb25maWcoc3RydWN0IGtnZF9k
ZXYgKmtnZCwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
