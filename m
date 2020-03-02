Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B979C3F2D2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46A12173E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GRh/Rcsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46A12173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4636E261;
	Mon,  2 Mar 2020 12:24:11 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680051.outbound.protection.outlook.com [40.107.68.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17FA6E261
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 12:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPqJEk2DEcC9jc6vJ638BmReqL+LUmEm7fqWWnoiWFBBWJaUbNdhVQ1ApFVyePlZJ8xzbVFHW2Udw512xnek5HqOQYZOfvML7KQsyxBfkaBoTNaDi2HeOL6B1033MbImUd74YAtwelQNS0OE6QUQBfPlILZK5JrZyCAqjkVqXm6wIfzI/SUsjFwlMYY0qzmnpRiAWfxxdlkmZZtkpWoJWqtGJWd7khV5gE489I/zAc+y0AnLE1h05BlSJs9RMSLws4kpVZyZELJTAHi8dbkqG1SOD1Y+9RW5FS148i3+COkCvcS6xwm0/B08TxbREoi+ov8sLkzxJ+CWpXfOY+s8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZhRfcWeB9vQvgKTfr9TDUxwG7qN55N+ZuiT1dRpUKw=;
 b=AOfmgm3osmTPsqqa/aCgiYiaceLbSwFvrJ4StckRxmqa92ydy+lmqTNdr0WTDhSfHp/yHTpp5WhJJmGwO1DwLxV6v+4qIwWmoefGlT45xNSCweCg4yfw3sWAp13hA46/QYAae/u35n+AbcJzPh7r0//p3CUqP1735l7gHRuy/DYrBEHQEiL+KhVAO6T1UpuGOYfUVYTD4R+DPIpaunQlSHS4QfuaGokuiSAMLP6Yu0SYKn2uCSsbRygcpFOiWJ6DzCyNV5fZpknAAoTR7zUdg6iaiyVjpE3dRWrYuH4iMaxYCMsJeC9wTgyMl2EHX0KpUICgAiakoQGHUMYACREcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZhRfcWeB9vQvgKTfr9TDUxwG7qN55N+ZuiT1dRpUKw=;
 b=GRh/RcsjaHDZ3sY/ivofxUfmp8cX0zsFCKHwOECFaUJdlLhh3YzYurydghpWzffkHcq0K+68S5/JPFTkwmikEn65YqeMWfGjBW8A9l2M+utvfsk5FVPn4GNEKpq4YH3X76u98ttexLwCUOgArX48HW3m9EUVaJhBTfCj4PwWKWo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Mon, 2 Mar 2020 12:24:07 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 12:24:07 +0000
Subject: Re: [PATCH v3 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200302095234.3638-1-nirmoy.das@amd.com>
 <20200302095234.3638-3-nirmoy.das@amd.com>
 <e3cd9281-fa33-2050-f69a-261444f26bf5@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <f687e152-a1e1-49f6-a81d-c09ec8f5d6ee@amd.com>
Date: Mon, 2 Mar 2020 13:27:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <e3cd9281-fa33-2050-f69a-261444f26bf5@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f21:fc00:9e54:a4a7:c1b6:6128]
 (2003:c5:8f21:fc00:9e54:a4a7:c1b6:6128) by
 ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 12:24:05 +0000
X-Originating-IP: [2003:c5:8f21:fc00:9e54:a4a7:c1b6:6128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce13c83a-4656-42a6-8e7b-08d7bea49a2f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2422:|DM5PR12MB2422:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2422DADD444F213E254A8CC08BE70@DM5PR12MB2422.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(5660300002)(2906002)(36756003)(52116002)(31686004)(66946007)(66476007)(6666004)(316002)(66556008)(45080400002)(478600001)(8936002)(186003)(16526019)(8676002)(31696002)(81166006)(4326008)(81156014)(966005)(2616005)(6486002)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2422;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94tQPDYvkC+X1+l0qmQptsD8PYDsj0hwERBmjlsHJjiIHvc4nEgMvmPkdVFeZuEsG5BpRPDOFWPHffEcgiV0X8sxonRJ30nMV3Zeyck4kB1TosoCwTT1K8dCN+KVr3+zJpeIowxF6zicVBYd/dOmEQdJ+//RJdbtdg3BAfbbXt3hi/2z63vA3pymrhZxSV9e5n/fRw0uRMdsY9+GYe8jiyn1znyxZtHwDLkvlRPCl4hwUZFRIwAFnVf6y5qVnBw2qVQ1B1zPsP5qr4oZv/fgC0HbN3Vh7XbMQ1/aHa3C4xlFHt9d5tjatdGQZtThOxdqb9KmF9B11aS9SFjcG5XZMKGEzo9TCqmgCGx7/J0ev3RNPuQ4HNDrp1IAeL0P5d1fdITDSQKaCNge65qLDA1GivfxDkKimMhzRNj5xAtjShvAoooEm8ltP1vYiXn4rp4+MWVsNpujp0Ibv2hTBnQecOcHemdB/EPYOHrYEj64ptY=
X-MS-Exchange-AntiSpam-MessageData: lNH0dcYz3kYbXkztnQTaswp2BBmAc9CU1cRW9IIxR37ZFqd8yzsiBzg2dirkc/NX37SDeggHLTPGVDFq6XjNFN+nbqDJlOxrMv+jreDs9ruriaV+itDJ/lNv4E1sU1cC+bJMF/G4kzolBFHXSFckU7pUQN+KUT7j3a/uX3A4ed69vfO9m3SeUCCVBdwOihe3pQzAy1k6Fejs/vvnaQCmmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce13c83a-4656-42a6-8e7b-08d7bea49a2f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 12:24:07.2073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50NedbPNg7EoABYIAZFpa4pS5xnzMcNvYQ0UITkg03STZaFNNT9pLU8zMwpSQkt7aEamarvWxsEWcqOjeC/pzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2422
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvMi8yMCAxOjEwIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDAyLjAzLjIw
IHVtIDEwOjUyIHNjaHJpZWIgTmlybW95IERhczoKPj4gU3dpdGNoIHRvIGFwcHJvcHJpYXRlIHNj
aGVkIGxpc3QgZm9yIGFuIGVudGl0eSBvbiBwcmlvcml0eSBvdmVycmlkZS4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIHwgMzAgKysrKysrKysrKysrKysr
KysrKysrLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jdHguYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMK
Pj4gaW5kZXggNDI2NmRhMWYzOTc3Li41NzQ0NWE2MWE0Y2QgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPj4gQEAgLTUyMiw2ICs1MjIsMzAgQEAgc3RydWN0
IGRtYV9mZW5jZSAqYW1kZ3B1X2N0eF9nZXRfZmVuY2Uoc3RydWN0IAo+PiBhbWRncHVfY3R4ICpj
dHgsCj4+IMKgwqDCoMKgwqAgcmV0dXJuIGZlbmNlOwo+PiDCoCB9Cj4+Cj4+ICtzdGF0aWMgdm9p
ZCBhbWRncHVfY3R4X3NldF9lbnRpdHlfcHJpb3JpdHkoc3RydWN0IGFtZGdwdV9jdHggKmN0eCwK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2N0
eF9lbnRpdHkgKmFlbnRpdHksCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaW50IGh3X2lwLCBlbnVtIGRybV9zY2hlZF9wcmlvcml0eSBwcmlvcml0eSkKPj4gK3sKPj4g
K8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGN0eC0+YWRldjsKPj4gK8KgwqDC
oCBlbnVtIGdmeF9waXBlX3ByaW9yaXR5IGNvbXB1dGVfcHJpb3JpdHk7Cj4KPiBNYXliZSB1c2Ug
c29tZSBzaG9ydGVyIG5hbWUsIGUuZy4gaHdfcHJpbyBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lgo+
Cj4+ICvCoMKgwqAgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICoqc2NoZWRzID0gTlVMTDsKPj4g
K8KgwqDCoCB1bnNpZ25lZCBudW1fc2NoZWRzID0gMDsKPgo+IERvbid0IGluaXRpYWxpemUgdGhv
c2UgaGVyZS4KPgo+PiArCj4+ICvCoMKgwqAgc3dpdGNoIChod19pcCkgewo+PiArwqDCoMKgIGNh
c2UgQU1ER1BVX0hXX0lQX0NPTVBVVEU6Cj4+ICvCoMKgwqDCoMKgwqDCoCBjb21wdXRlX3ByaW9y
aXR5ID0KPj4gKyBhbWRncHVfY3R4X3NjaGVkX3ByaW9fdG9fY29tcHV0ZV9wcmlvKHByaW9yaXR5
KTsKPj4gK8KgwqDCoMKgwqDCoMKgIHNjaGVkcyA9IGFkZXYtPmdmeC5jb21wdXRlX3ByaW9fc2No
ZWRbY29tcHV0ZV9wcmlvcml0eV07Cj4+ICvCoMKgwqDCoMKgwqDCoCBudW1fc2NoZWRzID0gYWRl
di0+Z2Z4Lm51bV9jb21wdXRlX3NjaGVkW2NvbXB1dGVfcHJpb3JpdHldOwo+PiArwqDCoMKgwqDC
oMKgwqAgYnJlYWs7Cj4+ICvCoMKgwqAgZGVmYXVsdDoKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVy
bjsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCBkcm1fc2NoZWRfZW50aXR5X21vZGlmeV9z
Y2hlZCgmYWVudGl0eS0+ZW50aXR5LCBzY2hlZHMsIAo+PiBudW1fc2NoZWRzKTsKPgo+IFRoYXQg
bmVlZHMgdG8gYmUgdW5kZXIgdGhlICJjYXNlIEFNREdQVV9IV19JUF9DT01QVVRFIiBvciBvdGhl
cndpc2Ugd2UgCj4gc2V0IHRoZSBzY2hlZHVsZXJzIHRvIE5VTEwgZm9yIFNETUEuClNETUEgd2ls
bCBmYWxsIGludG/CoCBkZWZhdWx0IGNhc2Ugd2hpY2ggd2lsbCByZXR1cm4gZnJvbSB0aGUgZnVu
Y3Rpb24gCmltbWVkaWF0ZWx5Lgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPj4gKyBkcm1f
c2NoZWRfZW50aXR5X3NldF9wcmlvcml0eSgmYWVudGl0eS0+ZW50aXR5LCBwcmlvcml0eSk7Cj4+
ICt9Cj4+ICsKPj4gwqAgdm9pZCBhbWRncHVfY3R4X3ByaW9yaXR5X292ZXJyaWRlKHN0cnVjdCBh
bWRncHVfY3R4ICpjdHgsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGVudW0gZHJtX3NjaGVkX3ByaW9yaXR5IHByaW9yaXR5KQo+PiDCoCB7Cj4+IEBAIC01MzQsMTMg
KzU1OCwxMSBAQCB2b2lkIGFtZGdwdV9jdHhfcHJpb3JpdHlfb3ZlcnJpZGUoc3RydWN0IAo+PiBB
TURHUFVfR0ZYX1BJUEVfUFJJT19NQVgKPj4gYW1kZ3B1X2N0eCAqY3R4LAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjdHgtPmluaXRfcHJpb3JpdHkgOiBjdHgtPm92ZXJyaWRlX3ByaW9y
aXR5Owo+PiDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBBTURHUFVfSFdfSVBfTlVNOyArK2kp
IHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaiA9IDA7IGogPCBhbWRncHVfY3R4X251bV9l
bnRpdGllc1tpXTsgKytqKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkcm1f
c2NoZWRfZW50aXR5ICplbnRpdHk7Cj4+IC0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKCFjdHgtPmVudGl0aWVzW2ldW2pdKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbnRpbnVlOwo+Pgo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRpdHkgPSAm
Y3R4LT5lbnRpdGllc1tpXVtqXS0+ZW50aXR5Owo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
cm1fc2NoZWRfZW50aXR5X3NldF9wcmlvcml0eShlbnRpdHksIGN0eF9wcmlvKTsKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2N0eF9zZXRfZW50aXR5X3ByaW9yaXR5KGN0eCwgY3R4
LT5lbnRpdGllc1tpXVtqXSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpLCBjdHhfcHJpbyk7Cj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCB9Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCB9Cj4+IC0tIAo+PiAyLjI1LjAKPj4KPj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBt
YWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9u
YW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
bGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7
ZGF0YT0wMiU3QzAxJTdDbmlybW95LmRhcyU0MGFtZC5jb20lN0NjZWNlNDBiMTNiYTc0YTZkYWY3
YjA4ZDdiZWEyYWJkMSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAl
N0M2MzcxODc0NzgxODgwNjY0MDcmYW1wO3NkYXRhPVRkcW5zcGRaTDYzRFhLZSUyQmpzSXZFMllM
ZW94a3RUVEo1NzdsejBjTFZZNCUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4KPgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
