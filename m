Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D69C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 14:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D4720722
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 14:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D4720722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A016E0F3;
	Mon, 18 Nov 2019 14:05:39 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750088.outbound.protection.outlook.com [40.107.75.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D016E0F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 14:05:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1dceLC0HMbr15IOpAcB4g6cAXHMlfA4czEof5jEIPtg9wLLgAjusHaXHnAEM48CywEHIAnPbWBEjmDZ9MC7zC6dzYp9LU4Wh6tbx4hQWKBeTxOSUZzwM87dezkn5F4umONcYaii217TjERSEeoxDOMJ6wh8LTV4JGY6E9DYLz8hFf+T1R/4v9VWVo/yNsTzAz7O2vAd4/ZQdebwHabsTvISZIDNZdf6dNCvZYjEuwzmFcPGIGkstYzNkamFH15Y5USoEQrvZyk/dC6db4zG49UdSOw1bsD1kL8D2pcpCreWw7WIM9n+/+urK7o9ZFa6qRxfrOLab4QmqBLUhtHxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6WaJoCNebKaKA9cD7SWlLmFpzNJL87QVVix/3zl3OU=;
 b=AjQJc3tYVFXBEJ8XdxVhG76HcDv0KOMNYE+obVG+11hcekqkNxOwtaHmgJ+UT4k4VzQoHNe5Q0hZced0OaxwDOJnDuMe8Q+9Zl1XW1/iSWdKZQ3q/SDA0aR0jEnl97F/Y51QBAKz2oUQLxCefo6vShIQ8MhckyMafG1++vroE4mrfGSk9dLZJaggmMsu7g7OgcVnsyDy1NJuExNP0xxls0/vB9sXlAmU50zGfDoKaVDN/rqX9rtCPcNws9laifW/QUtAUQNJye6pF74sDLtGIodS7btLts6nLyLF8xJ0HeBRr85i4rnIO55DIeW4Kwz87jfHdrkDGUQCXxVnlovQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1616.namprd12.prod.outlook.com (10.172.53.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 14:05:35 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 14:05:34 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/ras: Extract amdgpu_ras_save_bad_pages
 from amdgpu_ras_reserve_bad_pages
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <1573685125-2335-1-git-send-email-andrey.grodzovsky@amd.com>
 <MN2PR12MB3054761DA7F4EDEC9975F8AAB0710@MN2PR12MB3054.namprd12.prod.outlook.com>
 <63578cfb-83c2-6887-b7da-7715ef6ed3a9@amd.com>
Message-ID: <9ac78bf3-664b-ba1a-8579-bb802e3860e4@amd.com>
Date: Mon, 18 Nov 2019 09:05:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <63578cfb-83c2-6887-b7da-7715ef6ed3a9@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::26) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [2607:fea8:3edf:e127:1025:ab32:9794:6901]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2a852aa-8bae-4da5-47de-08d76c30616f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1616:
X-MS-Exchange-PUrlCount: 2
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB16161812CDD3188E691F57FFEA4D0@MWHPR12MB1616.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(13464003)(199004)(189003)(478600001)(6116002)(47776003)(11346002)(446003)(6666004)(53546011)(6506007)(386003)(6306002)(476003)(2616005)(8676002)(25786009)(58126008)(31686004)(316002)(6436002)(23676004)(2486003)(76176011)(110136005)(6512007)(6636002)(50466002)(486006)(6486002)(36756003)(99286004)(54906003)(2906002)(5660300002)(86362001)(2870700001)(229853002)(65956001)(65806001)(66946007)(2501003)(81156014)(81166006)(31696002)(186003)(66476007)(66556008)(52116002)(14454004)(7736002)(966005)(305945005)(46003)(6246003)(8936002)(14444005)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1616;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAMo5lUen4mYvjiz5qQVNbn1nDkHzQ0qc/RZhF2oHyQrL581QjbtzW2QnxZo67nKg4dhQRtwEzErQ/CjZXyFZi7NNH2JHei7TMVehcung3Vesu1YX+egB9kNqODOBM16zFF2R9OWxmLt/q3ZOa0pNg/YLchSgNynXVLz4z4q7MrsQlr21IZDbMdjMA8b8sNJquh5pOcLb934EM2EZzQcrZPN1bZnQNQ0TQc2d57SWNvEZKw5y08p6cPcxOGIk6a8Dtupz/cQZ93UkYZeRytgrBbuvjPDFwJ0bEYQIbTnoDjpSrBcPnKu6XhTcb8WkDUU1n4OleI5Sc7H+YL88yFYje8/TYDuoRwBJXQhjG7G+S3h78E4IwWEaCU5fLEx19s3p1f8b2AYI5ufrJjvk1t/KdF+xh9Nf06pj4EI5UwZqinYFK3RKv+FTudPfkHGC5UBk3UX8PXkb6BiFFehMV9FiYU64XcHCN1fmL03ZCjX1Yg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a852aa-8bae-4da5-47de-08d76c30616f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 14:05:34.8585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9XHOnlsk6Zat3tWVSpz3T/5r4fovSkXZuz2cGN0MjD6JvrcYbEFOlU1d0zm0nOS7JzWK6PdV+KYuS2sSTj9hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1616
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6WaJoCNebKaKA9cD7SWlLmFpzNJL87QVVix/3zl3OU=;
 b=u9LzTDntiLSwRSpjX6elLwFhWLkStpYFJWhA8hLaMdAh/WfGFTaCQOkgcPa/96ETV8CDq6MAevqHBTMqpvPVwWo2Ix2u+hXz7iTYaC7W3kPbU0hX3QxjVX5S6Qy4DrS67tx+2CQzioH5Ot0Clr2dmgX24LJIu4ndWAnfmu05O90=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
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
Cc: "alexdeucher@gmail.com" <alexdeucher@gmail.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118140526.R0BRztkPyJ-Uems1cXdfITb_0EijteCM6FuubREwam0@z>

Q2hyaXN0aWFuIC0gcGluZy4KCkFuZHJleQoKT24gMTEvMTQvMTkgMTE6NDEgQU0sIEFuZHJleSBH
cm9kem92c2t5IHdyb3RlOgo+Cj4gT24gMTEvMTMvMTkgMTA6MDkgUE0sIFpob3UxLCBUYW8gd3Jv
dGU6Cj4+IFR3byBxdWVzdGlvbnM6Cj4+Cj4+IDEuICJ3ZSBsb3NlIGFsbCByZXNlcnZhdGlvbiBk
dXJpbmcgQVNJQyByZXNldCIKPj4gQXJlIHlvdSBzdXJlIG9mIGl0PyBJIHJlbWVtYmVyIHRoZSBj
b250ZW50IG9mIHZyYW0gbWF5IGJlIGxvc3QgYWZ0ZXIgCj4+IHJlc2V0IGJ1dCB0aGUgYWxsb2Nh
dGVkIHN0YXR1cyBjb3VsZCBiZSByZXNlcnZlZC4KPgo+IFllYSwgbm93IHRoYXQgSSBhbSB0aGlu
a2luZyBvZiBpdCBJIHRoaW5rIGkgbWlnaHQgaGF2ZSBjb25mdXNlZCBpdCAKPiB3aXRoIEJPIGNv
bnRlbnQgcmVjb3ZlcnkgaW4gYW1kZ3B1X2RldmljZV9yZWNvdmVyX3ZyYW0gZm9yIHNoYWRvdyAK
PiBidWZmZXJzIHdoaWNoIGFyZSBwYWdlIHRhYmxlcyBvbmx5IGJ1dCBqdXN0IGZvciBWUkFNIHJl
c2VydmF0aW9uIAo+IHN0YXR1cyB0aGlzIG1pZ2h0IGJlIGlycmVsZXZhbnQuLi4gQ2hyaXN0aWFu
IC0gY2FuIHlvdSBjb25maXJtIFRhbyBpcyAKPiBjb3JyZWN0IG9uIHRoaXMgPwo+Cj4+Cj4+IDIu
IFlvdSBjaGFuZ2UgdGhlIGJhZCBwYWdlIGhhbmRsZSBmbG93IGZyb206Cj4+Cj4+IGRldGVjdCBi
YWQgcGFnZSAtPiByZXNlcnZlIHZyYW0gZm9yIGJhZCBwYWdlIC0+IHNhdmUgYmFkIHBhZ2UgaW5m
byB0byAKPj4gZWVwcm9tIC0+IGdwdSByZXNldAo+Pgo+PiB0bzoKPj4KPj4gZGV0ZWN0IGJhZCBw
YWdlICh0aGlzIHRpbWUpIC0+IHNhdmUgYmFkIHBhZ2UgKGxhc3QgdGltZSkgaW5mbyB0byAKPj4g
ZWVwcm9tIC0+IGdwdSByZXNldCAtPiByZXNlcnZlIHZyYW0gZm9yIGJhZCBwYWdlICh0aGlzIHRp
bWUpCj4KPiBFdmVuIHRob3VnaCBpZiBJIGFtIHdyb25nIG9uIHRoZSBmaXJzdCBwb2ludCB0aGlz
IGlzIGlycmVsZXZhbnQgYnV0IAo+IHN0aWxsIC0gV2h5IHNhdmluZyBiYWQgcGFnZSBpcyBmcm9t
IGxhc3QgdGltZSA/IFNlZSAKPiBodHRwczovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL35hZ2Q1Zi9s
aW51eC90cmVlL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYz9oPWFtZC1z
dGFnaW5nLWRybS1uZXh0I24xNDM2IAo+IC0gdGhlIHNhdmUgY291bnQgaXMgdGhlIGxhdGVzdCBz
byBhcyB0aGUgY29udGVudCBvZiAKPiBkYXRhLT5icHNbY29udHJvbC0+bnVtX3JlY3NdIHVwIHRv
IGRhdGEtPmJwc1tjb250cm9sLT5udW1fcmVjcyArIAo+IHNhdmVfY291bnRdIGFzIHRob3NlIGFy
ZSB1cGRhdGVkIGluIAo+IGFtZGdwdV91bWNfcHJvY2Vzc19yYXNfZGF0YV9jYi0+YW1kZ3B1X3Jh
c19hZGRfYmFkX3BhZ2VzIHdoaWNoIGlzIAo+IGNhbGxlZCByaWdodCBCRUZPUkUgYW1kZ3B1X3Jh
c19yZXNldF9ncHUtPmFtZGdwdV9yYXNfc2F2ZV9iYWRfcGFnZXMgaW4gCj4gdGhlIGludGVycnVw
dCBzZXF1ZW5jZQo+Cj4gQW5kcmV5Cj4KPgo+Pgo+PiBJcyB0aGF0IHJpZ2h0P8KgIFNhdmluZyBi
YWQgcGFnZSAodGhpcyB0aW1lKSBpbmZvIHRvIGVlcHJvbSBpcyBkZWxheWVkIAo+PiB0byB0aGUg
bmV4dCB0aW1lIHRoYXQgYmFkIHBhZ2UgaXMgZGV0ZWN0ZWQ/IEJ1dCB0aGUgdGltZSBvZiBkZXRl
Y3RpbmcgCj4+IGJhZCBwYWdlIGlzIHJhbmRvbS4KPj4gSSB0aGluayB0aGUgYmFkIHBhZ2UgaW5m
byB3b3VsZCBiZSBsb3N0IHdpdGhvdXQgc2F2aW5nIHRvIGVlcHJvbSBpZiAKPj4gcG93ZXIgb2Zm
IG9jY3Vycy4KPj4KPj4gZGV0ZWN0IGJhZCBwYWdlICh0aGlzIHRpbWUpIC0+IHNhdmUgYmFkIHBh
Z2UgKGxhc3QgdGltZSkgaW5mbyB0byAKPj4gZWVwcm9tIC0+IGdwdSByZXNldCAtPiByZXNlcnZl
IHZyYW0gZm9yIGJhZCBwYWdlICh0aGlzIHRpbWUpIC0+IAo+PiBwb3dlcm9mZi9zeXN0ZW0gcmVz
ZXQgKGFuZCBiYWQgcGFnZSBpbmZvICh0aGlzIHRpbWUpIGlzIGxvc3QpCj4+Cj4+IFRhbwo+Pgo+
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4+IEZyb206IGFtZC1nZnggPGFtZC1nZngt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZgo+Pj4gQW5kcmV5IEdy
b2R6b3Zza3kKPj4+IFNlbnQ6IDIwMTnlubQxMeaciDE05pelIDY6NDUKPj4+IFRvOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4gQ2M6IGFsZXhkZXVjaGVyQGdtYWlsLmNvbTsgR3Jv
ZHpvdnNreSwgQW5kcmV5Cj4+PiA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT47IENoZW4sIEd1
Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47Cj4+PiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5a
aGFuZ0BhbWQuY29tPgo+Pj4gU3ViamVjdDogW1BBVENIIDEvMl0gZHJtL2FtZGdwdS9yYXM6IEV4
dHJhY3QKPj4+IGFtZGdwdV9yYXNfc2F2ZV9iYWRfcGFnZXMgZnJvbSBhbWRncHVfcmFzX3Jlc2Vy
dmVfYmFkX3BhZ2VzCj4+Pgo+Pj4gV2Ugd2FudCB0byBiZSBiZSBhYmxlIHRvIGNhbGwgdGhlbSBp
bmRlcGVuZGVudGx5IGZyb20gb25lIGFub3RoZXIgc28gCj4+PiB0aGF0Cj4+PiBiZWZvcmUgR1BV
IHJlc2V0IGp1c3QgYW1kZ3B1X3Jhc19zYXZlX2JhZF9wYWdlcyBpcyBjYWxsZWQuCj4+Pgo+Pj4g
U2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5j
b20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
YyB8IDE0ICsrKystLS0tLS0tLS0tCj4+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmggfMKgIDQgKysrLQo+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5jCj4+PiBpbmRleCA0MDQ0ODM0Li42MDBhODZkIDEwMDY0NAo+Pj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKPj4+IEBAIC0xNDIxLDcgKzE0MjEsNyBA
QCBpbnQgYW1kZ3B1X3Jhc19hZGRfYmFkX3BhZ2VzKHN0cnVjdAo+Pj4gYW1kZ3B1X2RldmljZSAq
YWRldiwKPj4+IMKgwqAgKiB3cml0ZSBlcnJvciByZWNvcmQgYXJyYXkgdG8gZWVwcm9tLCB0aGUg
ZnVuY3Rpb24gc2hvdWxkIGJlCj4+PiDCoMKgICogcHJvdGVjdGVkIGJ5IHJlY292ZXJ5X2xvY2sK
Pj4+IMKgwqAgKi8KPj4+IC1zdGF0aWMgaW50IGFtZGdwdV9yYXNfc2F2ZV9iYWRfcGFnZXMoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+PiAraW50IGFtZGdwdV9yYXNfc2F2ZV9iYWRfcGFn
ZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIHN0
cnVjdCBhbWRncHVfcmFzICpjb24gPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFkZXYpOwo+Pj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgcmFzX2Vycl9oYW5kbGVyX2RhdGEgKmRhdGE7Cj4+PiBAQCAtMTUy
MCw3ICsxNTIwLDcgQEAgaW50IGFtZGdwdV9yYXNfcmVzZXJ2ZV9iYWRfcGFnZXMoc3RydWN0Cj4+
PiBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcmFzX2Vycl9oYW5k
bGVyX2RhdGEgKmRhdGE7Cj4+PiDCoMKgwqDCoMKgIHVpbnQ2NF90IGJwOwo+Pj4gwqDCoMKgwqDC
oCBzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IE5VTEw7Cj4+PiAtwqDCoMKgIGludCBpLCByZXQgPSAw
Owo+Pj4gK8KgwqDCoCBpbnQgaTsKPj4+Cj4+PiDCoMKgwqDCoMKgIGlmICghY29uIHx8ICFjb24t
PmVoX2RhdGEpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+PiBAQCAtMTU0OCwx
MiArMTU0OCw5IEBAIGludCBhbWRncHVfcmFzX3Jlc2VydmVfYmFkX3BhZ2VzKHN0cnVjdAo+Pj4g
YW1kZ3B1X2RldmljZSAqYWRldikKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRhLT5sYXN0X3Jl
c2VydmVkID0gaSArIDE7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYm8gPSBOVUxMOwo+Pj4gwqDC
oMKgwqDCoCB9Cj4+PiAtCj4+PiAtwqDCoMKgIC8qIGNvbnRpbnVlIHRvIHNhdmUgYmFkIHBhZ2Vz
IHRvIGVlcHJvbSBldmVuIHJlZXNydmVfdnJhbSBmYWlscyAqLwo+Pj4gLcKgwqDCoCByZXQgPSBh
bWRncHVfcmFzX3NhdmVfYmFkX3BhZ2VzKGFkZXYpOwo+Pj4gwqAgb3V0Ogo+Pj4gwqDCoMKgwqDC
oCBtdXRleF91bmxvY2soJmNvbi0+cmVjb3ZlcnlfbG9jayk7Cj4+PiAtwqDCoMKgIHJldHVybiBy
ZXQ7Cj4+PiArwqDCoMKgIHJldHVybiAwOwo+Pj4gwqAgfQo+Pj4KPj4+IMKgIC8qIGNhbGxlZCB3
aGVuIGRyaXZlciB1bmxvYWQgKi8KPj4+IEBAIC0xNjE1LDE0ICsxNjEyLDExIEBAIGludCBhbWRn
cHVfcmFzX3JlY292ZXJ5X2luaXQoc3RydWN0Cj4+PiBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGFtZGdwdV9yYXNfbG9hZF9iYWRfcGFnZXMoYWRldik7
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGdvdG8gZnJlZTsKPj4+IC3CoMKgwqDCoMKgwqDCoCByZXQgPSBhbWRncHVfcmFzX3Jl
c2VydmVfYmFkX3BhZ2VzKGFkZXYpOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHJlbGVhc2U7Cj4+PiArwqDCoMKgwqDCoMKgwqAg
YW1kZ3B1X3Jhc19yZXNlcnZlX2JhZF9wYWdlcyhhZGV2KTsKPj4+IMKgwqDCoMKgwqAgfQo+Pj4K
Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pgo+Pj4gLXJlbGVhc2U6Cj4+PiDCoMKgwqDCoMKg
IGFtZGdwdV9yYXNfcmVsZWFzZV9iYWRfcGFnZXMoYWRldik7Cj4+PiDCoCBmcmVlOgo+Pj4gwqDC
oMKgwqDCoCBrZnJlZSgoKmRhdGEpLT5icHMpOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmFzLmgKPj4+IGluZGV4IGY4MGZkMzQuLjEyYjA3OTcgMTAwNjQ0Cj4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgKPj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaAo+Pj4gQEAgLTQ5Miw2ICs0OTIs
OCBAQCB1bnNpZ25lZCBsb25nCj4+PiBhbWRncHVfcmFzX3F1ZXJ5X2Vycm9yX2NvdW50KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LMKgIGludAo+Pj4gYW1kZ3B1X3Jhc19hZGRfYmFkX3BhZ2Vz
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBlZXByb21fdGFibGVfcmVjb3JkICpicHMsIGludCBwYWdlcyk7Cj4+Pgo+Pj4gK2ludCBhbWRn
cHVfcmFzX3NhdmVfYmFkX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPj4+ICsK
Pj4+IMKgIGludCBhbWRncHVfcmFzX3Jlc2VydmVfYmFkX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KTsKPj4+Cj4+PiDCoCBzdGF0aWMgaW5saW5lIGludCBhbWRncHVfcmFzX3Jlc2V0
X2dwdShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgCj4+PiBAQCAtCj4+PiA1MDMsNyArNTA1
LDcgQEAgc3RhdGljIGlubGluZSBpbnQgYW1kZ3B1X3Jhc19yZXNldF9ncHUoc3RydWN0Cj4+PiBh
bWRncHVfZGV2aWNlICphZGV2LAo+Pj4gwqDCoMKgwqDCoMKgICogaTJjIG1heSBiZSB1bnN0YWJs
ZSBpbiBncHUgcmVzZXQKPj4+IMKgwqDCoMKgwqDCoCAqLwo+Pj4gwqDCoMKgwqDCoCBpZiAoaW5f
dGFzaygpKQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGFtZGdwdV9yYXNfcmVzZXJ2ZV9iYWRfcGFnZXMo
YWRldik7Cj4+PiArwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3Jhc19zYXZlX2JhZF9wYWdlcyhhZGV2
KTsKPj4+Cj4+PiDCoMKgwqDCoMKgIGlmIChhdG9taWNfY21weGNoZygmcmFzLT5pbl9yZWNvdmVy
eSwgMCwgMSkgPT0gMCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzY2hlZHVsZV93b3JrKCZyYXMt
PnJlY292ZXJ5X3dvcmspOwo+Pj4gLS0gCj4+PiAyLjcuNAo+Pj4KPj4+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IGh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
