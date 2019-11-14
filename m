Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38416C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 16:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D567C20672
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 16:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D567C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E3E6EC5F;
	Thu, 14 Nov 2019 16:14:38 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680057.outbound.protection.outlook.com [40.107.68.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738FC6EC9E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 16:14:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbZ+V4p0EAOBQ7BUuBWf4tep36e6jeCsNOEaGP8RIbtoK8Ty3uNW1nG9y3fStRFWIcAlIlWj7b6dtHtzmCdwJE/IOVbXRN3FjQHBnEFSN4RhEVqZenCD6JPRFfY8XrJ/UAHpMtKdnRoSx8+wO9fKr2n3mRfkmvfH9I9h9ui6Y6eBPn/WyOwmpwOKHp8Gexslt0c3PbUdqEujZ6HuaM22LfazhK1TlyIdXmw9wTEDaLC3c5yNQ6vz9NrAT+oGK41Zg3BQxZGX8kGUjrsV30Bziepb80dYOASYlw16SuokBOTNzA54j/1GPce0kdd/atq8KHaQFSlMcgEfWpQLkS17tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LCis8X+UKMgtcLp6PPyPzsEmBmxQb4KSg6HeXNLqcQ=;
 b=lR9TT3kJv05RRya2Hf2oPxa81raiQBo26LC9qJHeWc6CCEh7uNBQevxp05tuwIkcdb1cgm8BBX3QwX46ahZjnmyocKapblopujlzkOmOvWrYJIhK3hsKS7SFANq7NBtMngct0P0PTGoM/sC2k5M51vO7imb8CQRED0J08e+pKhht9DsnaR38rWL6gqpWUSzMk6/SFlD0IoVOzvjcwhClEW/35FmvrF+hsaGeUtZJLfDL78EHlfaXQ4zTvrQrlLXmBLPABmNtPxFSEWxSspj76AyBlF8u1zEzvloNmLPB5ww/pZ8aluhUAZ0+huulVH0QCFBeLdhmWdS/797oH3KQgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1547.namprd12.prod.outlook.com (10.172.38.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 16:14:33 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 16:14:33 +0000
Subject: Re: [PATCH 16/21] drm/amdgpu: enable JPEG2.0 dpm
To: Alex Deucher <alexdeucher@gmail.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
 <20191112180329.3927-17-leo.liu@amd.com>
 <CADnq5_PTs-1fU3o3rpQ1hhAdbiicwixWMHuOxSbZ7bshMSBVxA@mail.gmail.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <01d73e3e-7010-8a35-bb30-820995de9f20@amd.com>
Date: Thu, 14 Nov 2019 11:14:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
In-Reply-To: <CADnq5_PTs-1fU3o3rpQ1hhAdbiicwixWMHuOxSbZ7bshMSBVxA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: BL0PR02CA0100.namprd02.prod.outlook.com
 (2603:10b6:208:51::41) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Originating-IP: [2607:fea8:a200:445:f4ce:3436:51f8:7c1a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3b63e9b-81ba-44c0-5e6e-08d7691dbc80
X-MS-TrafficTypeDiagnostic: DM5PR12MB1547:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR12MB1547BE8ADD0E198E6F275973E5710@DM5PR12MB1547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02213C82F8
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(189003)(199004)(476003)(46003)(2616005)(6436002)(86362001)(11346002)(7736002)(6916009)(31696002)(316002)(36756003)(446003)(6246003)(966005)(305945005)(4001150100001)(65956001)(5660300002)(65806001)(47776003)(1411001)(478600001)(14444005)(8936002)(186003)(8676002)(6486002)(66946007)(25786009)(6506007)(53546011)(81166006)(386003)(6116002)(2870700001)(2906002)(6512007)(81156014)(58126008)(4326008)(50466002)(31686004)(14454004)(23676004)(44832011)(486006)(6306002)(52116002)(76176011)(66476007)(66556008)(99286004)(2486003)(229853002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1547;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrYOjfJt3gv6pt8K552qneztFgNc90xMFl9BGe18oP3rv4eMcD5CVP4GBDU5fH3cCV5gvKydd/c9oJh/zXsS1fY9Er7ao/4OCGRqXBx6D5I4YlKkzqDi6ReiQBq3qIfTlgJKher5psGuGNB8uvgL2htx4I55iyBVk2bwRGNMqOFpW+NR1EriZ1esJ5gJcB0fPvsrw3ElZLkbzqnf41oqpOBfRrA2A5n+fuEz+Sqaw4pzJd8z5cJjImndSDP5bUFbaoZQRYDf6EBadN4SJMyaOTmWWYV0ibZTw3aSVSTL5JChN66ZYwZQwgkmSzEq8HRQN6bZ2COdDL35S12L9HxDM5QXwAu/JjNrgYXSo0v4+UJXcO/Jd0/A+cx5NvYcCT9p1y/Bu4bZmhEIZ2aOwSaqf9oSfLRV5SoDyP52U+2qzSQj+hbRT//PWZaC+VfRA5kQcbc9CpBvcERUj3Y9u9wqxQpHvV8toq0MWW8qjF7Dba0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b63e9b-81ba-44c0-5e6e-08d7691dbc80
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 16:14:33.5850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ctq/IP/AwoOOIneYEH5sV9ZPdie2o+iZtDFFf7E8e2FvGEOlRZHpKapLEH9sZQXC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1547
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LCis8X+UKMgtcLp6PPyPzsEmBmxQb4KSg6HeXNLqcQ=;
 b=KFfcjSfQrMk9S8BZtzt6NlfDeCMUx7hbNq7Vc6UhXt/4ATvXcOc84d+mg8Dx3hnKGsI3UguuZZxSsDuh7CzXE2vQfPf/WWeT0o2lTKQnWyr2weEU3zYjBEKJWzo+U9PVoe6Gt4sXZnzusA3yVVJ4ptJ/IMToLbHekQVFJT/8IyY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114161431.vmftOYxWEnKU4Js2LXqBHSKhdEE1UjwLlRd45ZyUNPI@z>

Ck9uIDIwMTktMTEtMTQgMTE6MDMgYS5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIFR1ZSwg
Tm92IDEyLCAyMDE5IGF0IDE6MDQgUE0gTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPiB3cm90ZToK
Pj4gQnkgdXNpbmcgaXRzIG93biBlbmFibGluZyBmdW5jdGlvbgo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wbS5jIHwgIDggKysrKysrKysKPj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcG0uaCB8ICAxICsKPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9qcGVnX3YyXzAuYyB8IDEwICsrKysrKysrKy0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3BtLmMKPj4gaW5kZXggZjIwNWY1NmUzMzU4Li5iNzE1MDE3MWU4ZDcgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCj4+IEBAIC0yNzE4LDYgKzI3
MTgsMTQgQEAgdm9pZCBhbWRncHVfcG1fcHJpbnRfcG93ZXJfc3RhdGVzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQo+Pgo+PiAgIH0KPj4KPj4gK3ZvaWQgYW1kZ3B1X2RwbV9lbmFibGVfanBl
ZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBlbmFibGUpCj4+ICt7Cj4gSSB3b3Vs
ZCBhZGQgYW4gImlmIChpc19zdXBwb3J0X3N3X3NtdShhZGV2KSkiIGNoZWNrIGhlcmUgaW4gY2Fz
ZSB0aGlzCj4gZXZlciBnZXRzIGNhbGxlZCBvbiBvbGRlciBhc2ljcy4KClRoYW5rcyBBbGV4IGZv
ciB0aGUgcmV2aWV3cy4KCkkgZ290ICJpc19zdXBwb3J0X3N3X3NtdSgpIiBpbiBwbGFjZSBpbiB0
aGUgYmVnaW5uaW5nLCBhbmQgbGF0ZXIgaGFzIGl0IApyZW1vdmVkLgoKYmVjYXVzZSBmcm9tICJp
c19zdXBwb3J0X3N3X3NtdSIsCgoiaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0EyMCkK
IMKgwqDCoCDCoMKgwqAgcmV0dXJuIChhbWRncHVfZHBtID09IDIpID8gdHJ1ZSA6IGZhbHNlOwpl
bHNlIGlmIChhZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9BUkNUVVJVUykKIMKgwqDCoCDCoMKgwqAg
cmV0dXJuIHRydWU7CmVsc2UKIMKgwqDCoCDCoMKgwqAgcmV0dXJuIGZhbHNlOyIKCkpQRUcyLjAg
YW5kIGFib3ZlLCBmaXRzID49Q0hJUF9BUkNUVVJVUywgc28gYWx3YXlzIHJldHVybiB0cnVlLgoK
QnV0IEkgd2lsbCBhZGQgaXQgYmFjayBhcyB5b3Ugc3VnZ2VzdGVkLCBzaW5jZSBpdCBoYXMgbm8g
aGFybSwgYWxzbyBpbiAKY2FzZSB3aGVuIGNvbmRpdGlvbiBjaGFuZ2VkLgoKVGhhbmtzIGFnYWlu
LgoKTGVvCgoKPiBPdGhlciB0aGFuIHRoYXQsIHRoZSBzZXJpZXMgKHdpdGgKPiB0aGUgdjIgcGF0
Y2hlcykgaXM6Cj4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KPgo+PiArICAgICAgIGludCByZXQgPSBzbXVfZHBtX3NldF9wb3dlcl9nYXRlKCZh
ZGV2LT5zbXUsIEFNRF9JUF9CTE9DS19UWVBFX0pQRUcsIGVuYWJsZSk7Cj4+ICsgICAgICAgaWYg
KHJldCkKPj4gKyAgICAgICAgICAgICAgIERSTV9FUlJPUigiW1NXIFNNVV06IGRwbSBlbmFibGUg
anBlZyBmYWlsZWQsIHN0YXRlID0gJXMsIHJldCA9ICVkLiBcbiIsCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgZW5hYmxlID8gInRydWUiIDogImZhbHNlIiwgcmV0KTsKPj4gK30KPj4gKwo+
PiAgIGludCBhbWRncHVfcG1fdmlydF9zeXNmc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQo+PiAgIHsKPj4gICAgICAgICAgaW50IHJldCA9IDA7Cj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9wbS5oCj4+IGluZGV4IGVmMzE0NDhlZThkOC4uM2RhMWRhMjc3ODA1IDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uaAo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uaAo+PiBAQCAtNDEsNSAr
NDEsNiBAQCB2b2lkIGFtZGdwdV9wbV9jb21wdXRlX2Nsb2NrcyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldik7Cj4+ICAgdm9pZCBhbWRncHVfZHBtX3RoZXJtYWxfd29ya19oYW5kbGVyKHN0cnVj
dCB3b3JrX3N0cnVjdCAqd29yayk7Cj4+ICAgdm9pZCBhbWRncHVfZHBtX2VuYWJsZV91dmQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgZW5hYmxlKTsKPj4gICB2b2lkIGFtZGdwdV9k
cG1fZW5hYmxlX3ZjZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBlbmFibGUpOwo+
PiArdm9pZCBhbWRncHVfZHBtX2VuYWJsZV9qcGVnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCBib29sIGVuYWJsZSk7Cj4+Cj4+ICAgI2VuZGlmCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2pwZWdfdjJfMC5jCj4+IGluZGV4IDM4Njk3MzBiMjMzMS4uYTc4MjkyZDg0ODU0IDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzAuYwo+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzAuYwo+PiBAQCAtMzMzLDYgKzMzMyw5
IEBAIHN0YXRpYyBpbnQganBlZ192Ml8wX3N0YXJ0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQo+PiAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSAmYWRldi0+anBlZy5pbnN0
LT5yaW5nX2RlYzsKPj4gICAgICAgICAgaW50IHI7Cj4+Cj4+ICsgICAgICAgaWYgKGFkZXYtPnBt
LmRwbV9lbmFibGVkKQo+PiArICAgICAgICAgICAgICAgYW1kZ3B1X2RwbV9lbmFibGVfanBlZyhh
ZGV2LCB0cnVlKTsKPj4gKwo+PiAgICAgICAgICAvKiBkaXNhYmxlIHBvd2VyIGdhdGluZyAqLwo+
PiAgICAgICAgICByID0ganBlZ192Ml8wX2Rpc2FibGVfcG93ZXJfZ2F0aW5nKGFkZXYpOwo+PiAg
ICAgICAgICBpZiAocikKPj4gQEAgLTM4OCw4ICszOTEsMTMgQEAgc3RhdGljIGludCBqcGVnX3Yy
XzBfc3RvcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4KPj4gICAgICAgICAgLyogZW5h
YmxlIHBvd2VyIGdhdGluZyAqLwo+PiAgICAgICAgICByID0ganBlZ192Ml8wX2VuYWJsZV9wb3dl
cl9nYXRpbmcoYWRldik7Cj4+ICsgICAgICAgaWYgKHIpCj4+ICsgICAgICAgICAgICAgICByZXR1
cm4gcjsKPj4KPj4gLSAgICAgICByZXR1cm4gcjsKPj4gKyAgICAgICBpZiAoYWRldi0+cG0uZHBt
X2VuYWJsZWQpCj4+ICsgICAgICAgICAgICAgICBhbWRncHVfZHBtX2VuYWJsZV9qcGVnKGFkZXYs
IGZhbHNlKTsKPj4gKwo+PiArICAgICAgIHJldHVybiAwOwo+PiAgIH0KPj4KPj4gICAvKioKPj4g
LS0KPj4gMi4xNy4xCj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
