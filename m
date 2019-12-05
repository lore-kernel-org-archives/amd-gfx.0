Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922CFC43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 16:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D44B24648
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 16:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D44B24648
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A4C6F8A5;
	Thu,  5 Dec 2019 16:45:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAAF6F8A5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 16:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1WoA9BqZvhgLXjYLkQa2ahlpmuGw/Yupfwo+ZzByZFt6kLNqRDl95XgC+jUwt10/aYArAJBVX5zyNxl/xAyi0iWiso81S2tSNNBF7cnQmPyCQ6Q3ukNnj6LHei5yAkCKyVlVB+8X2vGOKQpy78HKhILtn4iluVe+t7QaSUaW/KUR3nzKYUBDbf5KF/wvGUBTRYIdfXFkp8mmqfQjq0pCiXbMYvwTPPig1kXMA4WyN5U2QseCWTAkWv3xwyThLzbFBw6WXpwClAge4hirSLc7n1JE1xPhEw1k7VPOkEQdRP2BP8aD/l4U6FSQEztVWOJ5I/DHvry8G66jttkw4X9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMp9HNQiAgusAcNKpaJdjabO6hOE01lfAbvkBptdxLU=;
 b=PhkczdVrZKNAJhylV5/cHhWh8iOJ2nt7rwkeiMgQyOIDHdocel867KK9YGhsLPv+dDvN+BdyMHrcirXE3nejG5YbOOavTeQrnVJIvmKB+pRRGL4XypFMQMQSzNbKMx/exki+vbwJj9m/WdG+eOBo5IQJBep/FdIrAUmhEz/rdlp+Gb3eTuX6zJuFx1Y2SYCNQxCHEcdCYfIZC3lC/z9BLp/eTyOJeMBNucnU9yHWUvZwHteqRD4ifZy01KTWlHFKTUyxiiqcevvurwXDrpDlOf7FfMAHRwcIFvYfXL5wAS0gH0EtH1cW5IN8yCpcTWfKR2QUiaS+s5JjEZ48J+/R6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB2969.namprd12.prod.outlook.com (20.178.29.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 16:45:45 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 16:45:45 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu: immedially invalidate PTEs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, philip.yang@amd.com, Alex.Sierra@amd.com
References: <20191205133940.3865-1-christian.koenig@amd.com>
 <20191205133940.3865-5-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <1f71140d-0480-886f-b344-04f419a5a37f@amd.com>
Date: Thu, 5 Dec 2019 11:45:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191205133940.3865-5-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::28) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bc9d3e4-8892-46be-1504-08d779a292c5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2969:|DM6PR12MB2969:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2969F91DFA3DEC2D05DE3645925C0@DM6PR12MB2969.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(76176011)(50466002)(52116002)(86362001)(31686004)(81166006)(58126008)(11346002)(44832011)(8676002)(8936002)(99286004)(6512007)(25786009)(6506007)(14444005)(53546011)(2616005)(26005)(186003)(31696002)(36916002)(81156014)(316002)(305945005)(23676004)(66946007)(65956001)(2906002)(36756003)(5660300002)(478600001)(2870700001)(14454004)(6486002)(6636002)(66556008)(66476007)(229853002)(66574012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2969;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyaQL0KNIQC3H9sHlY8IKwU+7uII+uzZ6dl4YGrlpFbHtiqdHk0749jmNERF9VeNShneuN2mS/0qQVefuHA1qJGmgwZFzhrLTC7L4KVU6WBai8yt/71Zm0cQtxf4GF0moKuOC/A1wYmC0VOMoIRD65WZHsiLvpm9hYFi6f7KWWSjkVFBef6rp3O+V7Pk1nD7FavWYt5ru6K9U+xffSlSkCsvTa0b8XfcJR+UOqNljDpkkZpmMmyDIVI6KneG0RNj+TQiks2/MXK+wk8Q4HnkKaMUEDiliEtiMO0+URmL58otn1arYwkWTm9hZGJR/PL1oZN2UVjfgQO0B7YO484oRLCI/S/ZdwBn5NeKultkjpHUeZxe4g5GrXQzp/BMAKEUMHkQtWgoJdBu5iH4TLgPDwAzhbsD9o59a6ovGn4vMXT+w7o+ToPmjtvOSGxtjoGw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc9d3e4-8892-46be-1504-08d779a292c5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 16:45:45.1326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XknBy2dvzDS/JrM1u6Ns/u12tUSY0UtbKsr2bcmXe11z9s9fIJjhDPof3d0nYamvr8+qLQkx+JXLhfjLqFLc3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2969
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMp9HNQiAgusAcNKpaJdjabO6hOE01lfAbvkBptdxLU=;
 b=ZEGqv8T+ihZrG0d7ROqVaI7nf/G/+MV+USt2+IxIk0j8FDSCb+qWS72lk3pxpV9BusWqrQpINf7mNPdKBkbGhonFQzc8aQ/E9BCjXub8VS7IryFK4IHhEAPRGo6rGOadl8W7Z91SNDQjSLJpx+19BlaPUMyYAInhWyGktYvRxjM=
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAxOS0xMi0wNSA4OjM5IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gV2hlbiBh
IEJPIGlzIGV2aWN0ZWQgaW1tZWRpYWxseSBpbnZhbGlkYXRlIHRoZSBtYXBwZWQgUFRFcy4KCkkg
dGhpbmsgeW91IG1lbnRpb25lZCB0aGF0IHRoaXMgaXMganVzdCBhIHByb29mIG9mIGNvbmNlcHQu
IEkgd291bGRuJ3QgCnN1Ym1pdCB0aGUgcGF0Y2ggbGlrZSB0aGlzIGJlY2F1c2UgaXQncyBvdmVy
a2lsbCBmb3IgVk1zIHRoYXQgZG9uJ3Qgd2FudCAKdG8gdXNlIHJlY292ZXJhYmxlIHBhZ2UgZmF1
bHRzIGFuZCBwcm9iYWJseSBoYXMgYSBwZXJmb3JtYW5jZSBpbXBhY3QuIEkgCndvdWxkIGRvIHNv
bWV0aGluZyBzcGVjaWZpYyB0byBjb21wdXRlIFZNcyBpbiBvdXIgTU1VIG5vdGlmaWVyLgoKUmVn
YXJkcywKIMKgIEZlbGl4Cgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgfCAxNyArKysrKysrKysrKysrKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDE2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4gaW5kZXggODM5ZDZkZjM5NGZjLi5lNTc4MTEzYmZkNTUgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0yNTY1LDYgKzI1NjUs
NyBAQCB2b2lkIGFtZGdwdV92bV9ib19pbnZhbGlkYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAo+ICAgCQkJICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICpibywgYm9vbCBldmljdGVkKQo+ICAg
ewo+ICAgCXN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSAqYm9fYmFzZTsKPiArCWludCByOwo+ICAg
Cj4gICAJLyogc2hhZG93IGJvIGRvZXNuJ3QgaGF2ZSBibyBiYXNlLCBpdHMgdmFsaWRhdGlvbiBu
ZWVkcyBpdHMgcGFyZW50ICovCj4gICAJaWYgKGJvLT5wYXJlbnQgJiYgYm8tPnBhcmVudC0+c2hh
ZG93ID09IGJvKQo+IEBAIC0yNTcyLDggKzI1NzMsMjIgQEAgdm9pZCBhbWRncHVfdm1fYm9faW52
YWxpZGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAo+ICAgCWZvciAoYm9fYmFz
ZSA9IGJvLT52bV9ibzsgYm9fYmFzZTsgYm9fYmFzZSA9IGJvX2Jhc2UtPm5leHQpIHsKPiAgIAkJ
c3RydWN0IGFtZGdwdV92bSAqdm0gPSBib19iYXNlLT52bTsKPiArCQlzdHJ1Y3QgZG1hX3Jlc3Yg
KnJlc3YgPSB2bS0+cm9vdC5iYXNlLmJvLT50Ym8uYmFzZS5yZXN2Owo+ICsKPiArCQlpZiAoYm8t
PnRiby50eXBlICE9IHR0bV9ib190eXBlX2tlcm5lbCkgewo+ICsJCQlzdHJ1Y3QgYW1kZ3B1X2Jv
X3ZhICpib192YTsKPiArCj4gKwkJCWJvX3ZhID0gY29udGFpbmVyX29mKGJvX2Jhc2UsIHN0cnVj
dCBhbWRncHVfYm9fdmEsCj4gKwkJCQkJICAgICBiYXNlKTsKPiArCQkJciA9IGFtZGdwdV92bV9i
b191cGRhdGUoYWRldiwgYm9fdmEsCj4gKwkJCQkJCWJvLT50Ym8uYmFzZS5yZXN2ICE9IHJlc3Yp
Owo+ICsJCQlpZiAoIXIpIHsKPiArCQkJCWFtZGdwdV92bV9ib19pZGxlKGJvX2Jhc2UpOwo+ICsJ
CQkJY29udGludWU7Cj4gKwkJCX0KPiArCQl9Cj4gICAKPiAtCQlpZiAoZXZpY3RlZCAmJiBiby0+
dGJvLmJhc2UucmVzdiA9PSB2bS0+cm9vdC5iYXNlLmJvLT50Ym8uYmFzZS5yZXN2KSB7Cj4gKwkJ
aWYgKGV2aWN0ZWQgJiYgYm8tPnRiby5iYXNlLnJlc3YgPT0gcmVzdikgewo+ICAgCQkJYW1kZ3B1
X3ZtX2JvX2V2aWN0ZWQoYm9fYmFzZSk7Cj4gICAJCQljb250aW51ZTsKPiAgIAkJfQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
