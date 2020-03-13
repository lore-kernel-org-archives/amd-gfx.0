Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1A6C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 09:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65020206EB
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 09:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wG9Jl97+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65020206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DB96EBAA;
	Fri, 13 Mar 2020 09:55:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E076EBAA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 09:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCTxqT5vDBBxuhsJBBW4Gup/nJchrYl1Tw4mcu8Y70yppBTB12JUsQY+42dawM14NpVbhw/kkS6JPM8xByeCHRu3/HFzM+GA4K8N1Pcxw+izKKyy0zPqLLhEGoH9xgQkKWM1XGnJdx/CUF5IMrLZChcPvnuKfpsZhbJsRjOg01Wm2oZI2kNoqiT92tNltErCEFGAlkj/Awb7S/lWY8Bw8HIW4SJm1pT7TMkeNIlWtHPQEFOq4QEG2Trk995Wl18nD0n6E3m2aAEKKhlckpKz8cTHsXSxKc6n7l6WtOgOFfJex2Bl3TvjEJzApI69rfCSNwfGXrGaGmaec6e9MFT3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1ykrke87jIWE4INBuzE5xsOV/efEDM2PBU2s965304=;
 b=hvD3KnA+h8b99UXyHU+ie0NDlNQMojQ3SuvIfceKFSVttfszcxOd/7Bhs51IwRhcHCr6l8Mce+3AL7T8L1Me70/+CaoJxkoD/3RaTmkENXINyDKcynfYCdwrs0WfkYNE7Swsv88GEmxjJbr6IcKVXxQqy7pCbPRncLiRMiUb8wIYsc7p/JeQkAkubR072XPig0FemKoAgS3Tq34JgBX9ipWqOEeeMTUc31JuLK5q+W/uwTFomjA7UcFBozZdM3k0Vujz3cLR7Lw1mat98RfpApYybsQ0RUkU9Z7gpDa/e1G93PwKwp3en0fXqdKTkwwNvA+MsoWU8a5mo3f3SoI/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1ykrke87jIWE4INBuzE5xsOV/efEDM2PBU2s965304=;
 b=wG9Jl97+iTQXZY1IgGDDkjNmePwSxatxF3J2qtnfR/vjcO+xezQdqhPG9dETOeR4w+Y9WXw72TsHnTTmw/x+uB1edm0mqVBaViFri5uyQxy0WxfIyV/nF1R42XU2zckuduLiJ/ZcI250EIHROEk9bmHgxAT930N0tdj6WhXj/5c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1692.namprd12.prod.outlook.com (2603:10b6:4:5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14; Fri, 13 Mar 2020 09:55:20 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 09:55:20 +0000
Subject: Re: [PATCH 1/2] drm//amdgpu: Always sync fence before unlock
 eviction_lock
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20200313074336.19545-1-xinhui.pan@amd.com>
 <20200313074336.19545-2-xinhui.pan@amd.com>
 <91022e2e-67fb-ef65-09d6-2814b10493d8@amd.com>
 <0D32D879-69FB-4D0F-8742-1BB9BF0AB766@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <227b3535-83c2-87af-56c0-be3ed28a0413@amd.com>
Date: Fri, 13 Mar 2020 10:55:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <0D32D879-69FB-4D0F-8742-1BB9BF0AB766@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::23) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Fri, 13 Mar 2020 09:55:19 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2d88b29-dbf9-43b0-b575-08d7c734a448
X-MS-TrafficTypeDiagnostic: DM5PR12MB1692:|DM5PR12MB1692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB16925976DC600DAB8CA9FD5D83FA0@DM5PR12MB1692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(66946007)(66574012)(66556008)(66476007)(6666004)(6636002)(31696002)(81166006)(8676002)(5660300002)(6486002)(4326008)(6862004)(478600001)(52116002)(8936002)(31686004)(186003)(86362001)(16526019)(36756003)(316002)(54906003)(81156014)(37006003)(2906002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1692;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sp3/HUJFf6DS+s4GnJXqDa5UzBOddQQV4t18NHASVHLEj73lbmouHo+PL0sUR3RNVmktsut83P2vEfxRnt2ARwBGEsGI3MZc+DaWihDmu8+Ym2ybcF2JjLQEkCqGiGkQmNjD8kuBjn8ANepEPIyiLviTYo1gcarxOQzZ61iV7xj6sTez6DwVpy5+NzNCXlvjqEgzwg5UcBo872OlVQ21UAMY6VnI5l0vVVf0mzMnDtkWWcAzf6+ojvUo6/T2+RJDKiu+GlVm1Rv2w5Dv4Qi+OM3eVrHneiKKF8bZ6W9i6SEw3PlT25a7udDOr+flKiZfrp/L62DZRg1HQM2vcpzx7aOiYtMvJMTxxJ/gWO/gZ0S7NcLVTHBuu3Sy9iIFBp8N6h60tk85CqxbFk+osoKuebUiltRxe3hXXwjD8cOqTD2L7X7fVRW1rOMnil6Uiz0x
X-MS-Exchange-AntiSpam-MessageData: wshS1Sn2lVS++6BbAPHxbSphLl9KL1QHYej4tDT3X7hitixCgeoeupd81CVXeHeptIBpvdFghCRKT1l2w156VOHq/dZJ4f0GMEHX+8av5OVFzvM1wF2XIMYbQqdVVqpGUbYKHTKmVaf+cppQcdnO9BECfTFUF1W4PUoVICFrNgWm1eEsRZXTN1ydQfqyXkXX8Hz8JrT/oNDuXbS2wXnfuw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d88b29-dbf9-43b0-b575-08d7c734a448
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 09:55:20.7078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JkIIw694eC8q/0etygLtZXZTaTFVB/yR60uIZhglcqpuWAQrGaPNrlIhpwPbVEM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTMuMDMuMjAgdW0gMTA6Mjkgc2NocmllYiBQYW4sIFhpbmh1aToKPgo+PiAyMDIw5bm0M+ac
iDEz5pelIDE2OjUy77yMS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT4g5YaZ6YGT77yaCj4+Cj4+IEFtIDEzLjAzLjIwIHVtIDA4OjQzIHNjaHJpZWIgeGluaHVpIHBh
bjoKPj4+IFRoZSBmZW5jZSBnZW5lcmF0ZWQgaW4gLT5jb21taXQgaXMgYSBzaGFyZWQgb25lLCBz
byBhZGQgaXQgdG8gcmVzdi4KPj4+IEFuZCB3ZSBuZWVkIGRvIHRoYXQgd2l0aCBldmljdGlvbiBs
b2NrIGhvbGQuCj4+Pgo+Pj4gQ3VycmVudGx5IHdlIG9ubHkgc3luYyBsYXN0X2RpcmVjdC9sYXN0
X2RlbGF5ZWQgYmVmb3JlIC0+cHJlcGFyZS4gQnV0IHdlCj4+PiBmYWlsIHRvIHN5bmMgdGhlIGxh
c3QgZmVuY2UgZ2VuZXJhdGVkIGJ5IC0+Y29tbWl0LiBUaGF0IGN1YXNlcyBwcm9ibGVtcwo+Pj4g
aWYgZXZpY3Rpb24gaGFwcGVuZXMgbGF0ZXIsIGJ1dCBpdCBkb2VzIG5vdCBzeW5jIHRoZSBsYXN0
IGZlbmNlLgo+PiBOQUssIHRoYXQgd29uJ3Qgd29yay4KPj4KPj4gV2UgY2FuIG9ubHkgYWRkIGZl
bmNlcyB3aGVuIHRoZSBkbWFfcmVzdiBvYmplY3QgaXMgbG9ja2VkIGFuZCB0aGF0IGlzIG9ubHkg
dGhlIGNhc2Ugd2hlbiB2YWxpZGF0aW5nLgo+Pgo+IHdlbGwsIHRoYSB0aXMgdHJ1ZS4KPiBidXQg
Y29uc2lkZXJpbmcgdGhpcyBpcyBhIFBUIEJPLCBhbmQgb25seSBldmljdGlvbiBoYXMgcmFjZSBv
biBpdCBBRkFJSy4KPiBhcyBmb3IgdGhlIGluZGl2aWR1YWxpemVkIHJlc3YgaW4gYm8gcmVsZWFz
ZSwgd2UgdW5yZWYgUFQgQk8ganVzdCBhZnRlciB0aGF0Lgo+IEkgYW0gc3RpbGwgdGhpbmtpbmcg
b2Ygb3RoZXIgcmFjZXMgaW4gdGhlIHJlYWwgd29ybGQuCgpXZSBzaG91bGQgcHJvYmFibHkganVz
dCBhZGQgYWxsIHBpcGVsaW5lZC9kZWxheWVkIHN1Ym1pc3Npb25zIGRpcmVjdGx5IAp0byB0aGUg
cmVzZXJ2YXRpb24gb2JqZWN0IGluIGFtZGdwdV92bV9zZG1hX2NvbW1pdCgpLgoKT25seSB0aGUg
ZGlyZWN0IGFuZCBpbnZhbGlkYXRpbmcgc3VibWlzc2lvbnMgY2FuJ3QgYmUgYWRkZWQgYmVjYXVz
ZSB3ZSAKY2FuJ3QgZ3JhYiB0aGUgcmVzZXJ2YXRpb24gb2JqZWN0IGluIHRoZSBNTVUgbm90aWZp
ZXIuCgpDYW4geW91IHByZXBhcmUgYSBwYXRjaCBmb3IgdGhpcz8KClJlZ2FyZHMsCkNocmlzdGlh
bi4KCj4KPiB0aGFua3MKPiB4aW5odWkKPgo+PiBJJ20gY29uc2lkZXJpbmcgdG8ganVzdCBwYXJ0
aWFsbHkgcmV2ZXJ0IHRoZSBwYXRjaCBvcmlnaW5hbGx5IHN0b3BwaW5nIHRvIGFkZCBmZW5jZXMg
YW5kIGluc3RlYWQgb25seSBub3QgYWRkIHRoZW0gd2hlbiBpbnZhbGlkYXRpbmcgaW4gYSBkaXJl
Y3Qgc3VibWl0Lgo+Pgo+PiBDaHJpc3RpYW4uCj4+Cj4+PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KPj4+IENjOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNv
bT4KPj4+IC0tLQo+Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8
IDkgKysrKysrKy0tCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+
IGluZGV4IDczMzk4ODMxMTk2Zi4uZjQyNGI1OTY5OTMwIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+PiBAQCAtMTU4Miw2ICsxNTgyLDcgQEAgc3RhdGlj
IGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCj4+PiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgcGFyYW1zOwo+Pj4gICAJ
ZW51bSBhbWRncHVfc3luY19tb2RlIHN5bmNfbW9kZTsKPj4+ICAgCWludCByOwo+Pj4gKwlzdHJ1
Y3QgYW1kZ3B1X2JvICpyb290ID0gdm0tPnJvb3QuYmFzZS5ibzsKPj4+ICAgICAJbWVtc2V0KCZw
YXJhbXMsIDAsIHNpemVvZihwYXJhbXMpKTsKPj4+ICAgCXBhcmFtcy5hZGV2ID0gYWRldjsKPj4+
IEBAIC0xNjA0LDggKzE2MDUsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFw
cGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+ICAgCX0KPj4+ICAgICAJaWYgKGZs
YWdzICYgQU1ER1BVX1BURV9WQUxJRCkgewo+Pj4gLQkJc3RydWN0IGFtZGdwdV9ibyAqcm9vdCA9
IHZtLT5yb290LmJhc2UuYm87Cj4+PiAtCj4+PiAgIAkJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFs
ZWQodm0tPmxhc3RfZGlyZWN0KSkKPj4+ICAgCQkJYW1kZ3B1X2JvX2ZlbmNlKHJvb3QsIHZtLT5s
YXN0X2RpcmVjdCwgdHJ1ZSk7Cj4+PiAgIEBAIC0xNjIzLDYgKzE2MjIsMTIgQEAgc3RhdGljIGlu
dCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
Cj4+PiAgICAgCXIgPSB2bS0+dXBkYXRlX2Z1bmNzLT5jb21taXQoJnBhcmFtcywgZmVuY2UpOwo+
Pj4gICArCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKHZtLT5sYXN0X2RpcmVjdCkpCj4+PiAr
CQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGlyZWN0LCB0cnVlKTsKPj4+ICsKPj4+
ICsJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGVsYXllZCkpCj4+PiArCQlh
bWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGVsYXllZCwgdHJ1ZSk7Cj4+PiArCj4+PiAg
IGVycm9yX3VubG9jazoKPj4+ICAgCWFtZGdwdV92bV9ldmljdGlvbl91bmxvY2sodm0pOwo+Pj4g
ICAJcmV0dXJuIHI7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
