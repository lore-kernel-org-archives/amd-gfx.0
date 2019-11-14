Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9F2C33C9A
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 16:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB1520718
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 16:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB1520718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17AD46ECAE;
	Thu, 14 Nov 2019 16:41:58 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740074.outbound.protection.outlook.com [40.107.74.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B90F6ECAE
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 16:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGQc4y1sgb0xnTbESYsXSSV7fHxv0Cs9mKJpfLy4dX4Fg6EHhdFHtvnErFlUizslGzlcP86+i2/5QF1jxt2JS2ExG7J5L6Xg786wvhAO8qcxU1ptgBFXUQRFHiGmN6/h03Omyc7oK8Z4MhozH6MwwKzDsuvcEQnd8w+CwJoUL8L5IuRZvOlkIzhsJXGf2l+vh5PNXaezrEAHn88MHsn6+CQf7xUVcp2ZiJJs+koHezYwYxQgtcauaHa697uGM2bUGUFDkeHnKyOenwY5OMg/qBXJJprNrTFQ/OF27uy1sRvSz9dr3P9nFVn9B+JtJzpLqWWscmLjbIwzk+wXSps6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQCVAEQOLPW6F9+dAkv2SuURoUpDitEwxPnCyy7MNKk=;
 b=EJRC41n7u/YdlwcEnpLIrRGoopEDFaFy+cl0ryz5lIrx4sajabfIbplOvFY8UUYoCMckNs3OyCTf6OTu9zEJ1peQGQvV2aA45TE6CyYNsBB2yFhSw2I6DoVvgGFbjgl35tisx8oS32YdgM/7b9Od2xExznKqVMolpR3VXVYf7x8/4oG1eR83PgcthUwZBrzs170/TZcHFs4FDTxuGcM/yP0QaDoNtugFSnmBsKFzH6Qv3HVQhff5nyl43N8dDWok6CKldkd2XgEingMvILrEzPSJOY3EyaNgFVeOCoFyTRs580ILg/FVH/Ep6KweCMuNZStn4YNzZxICCgWvanj1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1565.namprd12.prod.outlook.com (10.172.53.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 14 Nov 2019 16:41:53 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 16:41:53 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/ras: Extract amdgpu_ras_save_bad_pages
 from amdgpu_ras_reserve_bad_pages
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <1573685125-2335-1-git-send-email-andrey.grodzovsky@amd.com>
 <MN2PR12MB3054761DA7F4EDEC9975F8AAB0710@MN2PR12MB3054.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <63578cfb-83c2-6887-b7da-7715ef6ed3a9@amd.com>
Date: Thu, 14 Nov 2019 11:41:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <MN2PR12MB3054761DA7F4EDEC9975F8AAB0710@MN2PR12MB3054.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::37) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [2607:fea8:3edf:e127:bc3b:ed63:d5af:25ce]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f702468-e66e-49d4-032e-08d769218e0d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1565:
X-MS-Exchange-PUrlCount: 2
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1565B0D6AB3248226F305BCCEA710@MWHPR12MB1565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02213C82F8
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(199004)(189003)(13464003)(31686004)(58126008)(36756003)(54906003)(7736002)(4326008)(305945005)(110136005)(316002)(386003)(6486002)(6436002)(229853002)(14454004)(2501003)(47776003)(65806001)(65956001)(25786009)(14444005)(966005)(478600001)(6506007)(53546011)(6116002)(23676004)(2486003)(52116002)(76176011)(11346002)(81156014)(81166006)(86362001)(476003)(2616005)(486006)(46003)(186003)(8676002)(31696002)(6636002)(446003)(6512007)(6306002)(8936002)(6246003)(2906002)(2870700001)(66476007)(66556008)(66946007)(50466002)(5660300002)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1565;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QJN2VWijHGAfLV42Cfgm8K0QV6SdE3cilCxZ05KbvV6ClJ1XNKdiXbxxm6q0AeDkuvCT12kTYT4DGdw1cbNBgX2kskd8/Q8TWbcLtxe4wM2UWC9v6si4vPUo4m84IFo3bXcmnAxU5DNxHc4l3WV9UWMqgBr2OsWvabTx8ifcYBzyK+fuLpw4EIeSPZiGTiXhuZLfvkoJDTIumDeF1/IpNDZT9i+/AbkHvdowIIKY3DV8+ITNwj9m1L66McZjQg2Jg12y29XOgVdC5TCnfeRxO9xfZe8UtSiQ2s7fI1PPLGFwey9CGmWluowB4DofV8TUtNFBJ2GeeHKmf5jcl9eOm0ouxtWHxERMBUwLrj9NXIgk3rVJbr9X3pOad/w0Xxb9WiHIBJiEJjf6urO41n4dRzOia3W8i6T1GhP1y0OvURXtK7uevwH7rYFAuHlCLhO6wptlqwwei3ie1mAbRB4APn6TCEq9OViUnbHFDD9Rag=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f702468-e66e-49d4-032e-08d769218e0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 16:41:53.6148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ebj0fW48fHaFAGbNdCjYwe253CYHByQObQApupWSH7dPqG8J2jt9t5XJ9LKUCuhGeKmAqgyICpewWT7KRFNIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1565
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQCVAEQOLPW6F9+dAkv2SuURoUpDitEwxPnCyy7MNKk=;
 b=LLGYjOZ+Z79yVmBUP/WuaORteb6Hz9och3xVVuAwqe3FUkiWmj2R9urX5zMnnHiJ5/BYfYez/GXRyvAek8H/q9owHC/bKHxFmriP46IhtNK/6F7XsKpNxKmd/GgJGgNBRKauGC+c8ilM49K24vdlc3I4eM9S4y4mZ92Fk0vmxXg=
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
Message-ID: <20191114164151.7QIUrLAtJuEHQGf5O1EUsxDGSKwKw4ZgWeHGMEFJ7fE@z>

Ck9uIDExLzEzLzE5IDEwOjA5IFBNLCBaaG91MSwgVGFvIHdyb3RlOgo+IFR3byBxdWVzdGlvbnM6
Cj4KPiAxLiAid2UgbG9zZSBhbGwgcmVzZXJ2YXRpb24gZHVyaW5nIEFTSUMgcmVzZXQiCj4gQXJl
IHlvdSBzdXJlIG9mIGl0PyBJIHJlbWVtYmVyIHRoZSBjb250ZW50IG9mIHZyYW0gbWF5IGJlIGxv
c3QgYWZ0ZXIgcmVzZXQgYnV0IHRoZSBhbGxvY2F0ZWQgc3RhdHVzIGNvdWxkIGJlIHJlc2VydmVk
LgoKWWVhLCBub3cgdGhhdCBJIGFtIHRoaW5raW5nIG9mIGl0IEkgdGhpbmsgaSBtaWdodCBoYXZl
IGNvbmZ1c2VkIGl0IHdpdGggCkJPIGNvbnRlbnQgcmVjb3ZlcnkgaW4gYW1kZ3B1X2RldmljZV9y
ZWNvdmVyX3ZyYW0gZm9yIHNoYWRvdyBidWZmZXJzIAp3aGljaCBhcmUgcGFnZSB0YWJsZXMgb25s
eSBidXQganVzdCBmb3IgVlJBTSByZXNlcnZhdGlvbsKgIHN0YXR1cyB0aGlzIAptaWdodCBiZSBp
cnJlbGV2YW50Li4uIENocmlzdGlhbiAtIGNhbiB5b3UgY29uZmlybSBUYW8gaXMgY29ycmVjdCBv
biB0aGlzID8KCj4KPiAyLiBZb3UgY2hhbmdlIHRoZSBiYWQgcGFnZSBoYW5kbGUgZmxvdyBmcm9t
Ogo+Cj4gZGV0ZWN0IGJhZCBwYWdlIC0+IHJlc2VydmUgdnJhbSBmb3IgYmFkIHBhZ2UgLT4gc2F2
ZSBiYWQgcGFnZSBpbmZvIHRvIGVlcHJvbSAtPiBncHUgcmVzZXQKPgo+IHRvOgo+Cj4gZGV0ZWN0
IGJhZCBwYWdlICh0aGlzIHRpbWUpIC0+IHNhdmUgYmFkIHBhZ2UgKGxhc3QgdGltZSkgaW5mbyB0
byBlZXByb20gLT4gZ3B1IHJlc2V0IC0+IHJlc2VydmUgdnJhbSBmb3IgYmFkIHBhZ2UgKHRoaXMg
dGltZSkKCkV2ZW4gdGhvdWdoIGlmIEkgYW0gd3Jvbmcgb24gdGhlIGZpcnN0IHBvaW50IHRoaXMg
aXMgaXJyZWxldmFudCBidXQgCnN0aWxsIC0gV2h5IHNhdmluZyBiYWQgcGFnZSBpcyBmcm9tIGxh
c3QgdGltZSA/IFNlZSAKaHR0cHM6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9+YWdkNWYvbGludXgv
dHJlZS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmM/aD1hbWQtc3RhZ2lu
Zy1kcm0tbmV4dCNuMTQzNiAKLSB0aGUgc2F2ZSBjb3VudCBpcyB0aGUgbGF0ZXN0IHNvIGFzIHRo
ZSBjb250ZW50IG9mIApkYXRhLT5icHNbY29udHJvbC0+bnVtX3JlY3NdIHVwIHRvIGRhdGEtPmJw
c1tjb250cm9sLT5udW1fcmVjcyArIApzYXZlX2NvdW50XSBhcyB0aG9zZSBhcmUgdXBkYXRlZCBp
biAKYW1kZ3B1X3VtY19wcm9jZXNzX3Jhc19kYXRhX2NiLT5hbWRncHVfcmFzX2FkZF9iYWRfcGFn
ZXMgd2hpY2ggaXMgY2FsbGVkIApyaWdodCBCRUZPUkUgYW1kZ3B1X3Jhc19yZXNldF9ncHUtPmFt
ZGdwdV9yYXNfc2F2ZV9iYWRfcGFnZXMgaW4gdGhlIAppbnRlcnJ1cHQgc2VxdWVuY2UKCkFuZHJl
eQoKCj4KPiBJcyB0aGF0IHJpZ2h0PyAgU2F2aW5nIGJhZCBwYWdlICh0aGlzIHRpbWUpIGluZm8g
dG8gZWVwcm9tIGlzIGRlbGF5ZWQgdG8gdGhlIG5leHQgdGltZSB0aGF0IGJhZCBwYWdlIGlzIGRl
dGVjdGVkPyBCdXQgdGhlIHRpbWUgb2YgZGV0ZWN0aW5nIGJhZCBwYWdlIGlzIHJhbmRvbS4KPiBJ
IHRoaW5rIHRoZSBiYWQgcGFnZSBpbmZvIHdvdWxkIGJlIGxvc3Qgd2l0aG91dCBzYXZpbmcgdG8g
ZWVwcm9tIGlmIHBvd2VyIG9mZiBvY2N1cnMuCj4KPiBkZXRlY3QgYmFkIHBhZ2UgKHRoaXMgdGlt
ZSkgLT4gc2F2ZSBiYWQgcGFnZSAobGFzdCB0aW1lKSBpbmZvIHRvIGVlcHJvbSAtPiBncHUgcmVz
ZXQgLT4gcmVzZXJ2ZSB2cmFtIGZvciBiYWQgcGFnZSAodGhpcyB0aW1lKSAtPiBwb3dlcm9mZi9z
eXN0ZW0gcmVzZXQgKGFuZCBiYWQgcGFnZSBpbmZvICh0aGlzIHRpbWUpIGlzIGxvc3QpCj4KPiBU
YW8KPgo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQt
Z2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YKPj4gQW5kcmV5
IEdyb2R6b3Zza3kKPj4gU2VudDogMjAxOeW5tDEx5pyIMTTml6UgNjo0NQo+PiBUbzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gQ2M6IGFsZXhkZXVjaGVyQGdtYWlsLmNvbTsgR3Jv
ZHpvdnNreSwgQW5kcmV5Cj4+IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPjsgQ2hlbiwgR3Vj
aHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsKPj4gWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT4KPj4gU3ViamVjdDogW1BBVENIIDEvMl0gZHJtL2FtZGdwdS9yYXM6IEV4dHJh
Y3QKPj4gYW1kZ3B1X3Jhc19zYXZlX2JhZF9wYWdlcyBmcm9tIGFtZGdwdV9yYXNfcmVzZXJ2ZV9i
YWRfcGFnZXMKPj4KPj4gV2Ugd2FudCB0byBiZSBiZSBhYmxlIHRvIGNhbGwgdGhlbSBpbmRlcGVu
ZGVudGx5IGZyb20gb25lIGFub3RoZXIgc28gdGhhdAo+PiBiZWZvcmUgR1BVIHJlc2V0IGp1c3Qg
YW1kZ3B1X3Jhc19zYXZlX2JhZF9wYWdlcyBpcyBjYWxsZWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6
IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgo+PiAtLS0KPj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCAxNCArKysrLS0tLS0t
LS0tLQo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmggfCAgNCArKyst
Cj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5j
Cj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCj4+IGluZGV4IDQw
NDQ4MzQuLjYwMGE4NmQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXMuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmMKPj4gQEAgLTE0MjEsNyArMTQyMSw3IEBAIGludCBhbWRncHVfcmFzX2FkZF9iYWRfcGFn
ZXMoc3RydWN0Cj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+ICAgICogd3JpdGUgZXJyb3IgcmVj
b3JkIGFycmF5IHRvIGVlcHJvbSwgdGhlIGZ1bmN0aW9uIHNob3VsZCBiZQo+PiAgICAqIHByb3Rl
Y3RlZCBieSByZWNvdmVyeV9sb2NrCj4+ICAgICovCj4+IC1zdGF0aWMgaW50IGFtZGdwdV9yYXNf
c2F2ZV9iYWRfcGFnZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+ICtpbnQgYW1kZ3B1
X3Jhc19zYXZlX2JhZF9wYWdlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gICB7Cj4+
ICAgCXN0cnVjdCBhbWRncHVfcmFzICpjb24gPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFkZXYp
Owo+PiAgIAlzdHJ1Y3QgcmFzX2Vycl9oYW5kbGVyX2RhdGEgKmRhdGE7Cj4+IEBAIC0xNTIwLDcg
KzE1MjAsNyBAQCBpbnQgYW1kZ3B1X3Jhc19yZXNlcnZlX2JhZF9wYWdlcyhzdHJ1Y3QKPj4gYW1k
Z3B1X2RldmljZSAqYWRldikKPj4gICAJc3RydWN0IHJhc19lcnJfaGFuZGxlcl9kYXRhICpkYXRh
Owo+PiAgIAl1aW50NjRfdCBicDsKPj4gICAJc3RydWN0IGFtZGdwdV9ibyAqYm8gPSBOVUxMOwo+
PiAtCWludCBpLCByZXQgPSAwOwo+PiArCWludCBpOwo+Pgo+PiAgIAlpZiAoIWNvbiB8fCAhY29u
LT5laF9kYXRhKQo+PiAgIAkJcmV0dXJuIDA7Cj4+IEBAIC0xNTQ4LDEyICsxNTQ4LDkgQEAgaW50
IGFtZGdwdV9yYXNfcmVzZXJ2ZV9iYWRfcGFnZXMoc3RydWN0Cj4+IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCj4+ICAgCQlkYXRhLT5sYXN0X3Jlc2VydmVkID0gaSArIDE7Cj4+ICAgCQlibyA9IE5VTEw7
Cj4+ICAgCX0KPj4gLQo+PiAtCS8qIGNvbnRpbnVlIHRvIHNhdmUgYmFkIHBhZ2VzIHRvIGVlcHJv
bSBldmVuIHJlZXNydmVfdnJhbSBmYWlscyAqLwo+PiAtCXJldCA9IGFtZGdwdV9yYXNfc2F2ZV9i
YWRfcGFnZXMoYWRldik7Cj4+ICAgb3V0Ogo+PiAgIAltdXRleF91bmxvY2soJmNvbi0+cmVjb3Zl
cnlfbG9jayk7Cj4+IC0JcmV0dXJuIHJldDsKPj4gKwlyZXR1cm4gMDsKPj4gICB9Cj4+Cj4+ICAg
LyogY2FsbGVkIHdoZW4gZHJpdmVyIHVubG9hZCAqLwo+PiBAQCAtMTYxNSwxNCArMTYxMiwxMSBA
QCBpbnQgYW1kZ3B1X3Jhc19yZWNvdmVyeV9pbml0KHN0cnVjdAo+PiBhbWRncHVfZGV2aWNlICph
ZGV2KQo+PiAgIAkJcmV0ID0gYW1kZ3B1X3Jhc19sb2FkX2JhZF9wYWdlcyhhZGV2KTsKPj4gICAJ
CWlmIChyZXQpCj4+ICAgCQkJZ290byBmcmVlOwo+PiAtCQlyZXQgPSBhbWRncHVfcmFzX3Jlc2Vy
dmVfYmFkX3BhZ2VzKGFkZXYpOwo+PiAtCQlpZiAocmV0KQo+PiAtCQkJZ290byByZWxlYXNlOwo+
PiArCQlhbWRncHVfcmFzX3Jlc2VydmVfYmFkX3BhZ2VzKGFkZXYpOwo+PiAgIAl9Cj4+Cj4+ICAg
CXJldHVybiAwOwo+Pgo+PiAtcmVsZWFzZToKPj4gICAJYW1kZ3B1X3Jhc19yZWxlYXNlX2JhZF9w
YWdlcyhhZGV2KTsKPj4gICBmcmVlOgo+PiAgIAlrZnJlZSgoKmRhdGEpLT5icHMpOwo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oCj4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oCj4+IGluZGV4IGY4MGZkMzQuLjEy
YjA3OTcgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgKPj4g
QEAgLTQ5Miw2ICs0OTIsOCBAQCB1bnNpZ25lZCBsb25nCj4+IGFtZGdwdV9yYXNfcXVlcnlfZXJy
b3JfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsICBpbnQKPj4gYW1kZ3B1X3Jhc19h
ZGRfYmFkX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+PiAgIAkJc3RydWN0IGVl
cHJvbV90YWJsZV9yZWNvcmQgKmJwcywgaW50IHBhZ2VzKTsKPj4KPj4gK2ludCBhbWRncHVfcmFz
X3NhdmVfYmFkX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPj4gKwo+PiAgIGlu
dCBhbWRncHVfcmFzX3Jlc2VydmVfYmFkX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KTsKPj4KPj4gICBzdGF0aWMgaW5saW5lIGludCBhbWRncHVfcmFzX3Jlc2V0X2dwdShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgQEAgLQo+PiA1MDMsNyArNTA1LDcgQEAgc3RhdGljIGlubGlu
ZSBpbnQgYW1kZ3B1X3Jhc19yZXNldF9ncHUoc3RydWN0Cj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYs
Cj4+ICAgCSAqIGkyYyBtYXkgYmUgdW5zdGFibGUgaW4gZ3B1IHJlc2V0Cj4+ICAgCSAqLwo+PiAg
IAlpZiAoaW5fdGFzaygpKQo+PiAtCQlhbWRncHVfcmFzX3Jlc2VydmVfYmFkX3BhZ2VzKGFkZXYp
Owo+PiArCQlhbWRncHVfcmFzX3NhdmVfYmFkX3BhZ2VzKGFkZXYpOwo+Pgo+PiAgIAlpZiAoYXRv
bWljX2NtcHhjaGcoJnJhcy0+aW5fcmVjb3ZlcnksIDAsIDEpID09IDApCj4+ICAgCQlzY2hlZHVs
ZV93b3JrKCZyYXMtPnJlY292ZXJ5X3dvcmspOwo+PiAtLQo+PiAyLjcuNAo+Pgo+PiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
