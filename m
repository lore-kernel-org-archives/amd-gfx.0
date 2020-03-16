Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4B4C0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 12:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03B62051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 12:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KXNbkASy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03B62051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9B989F75;
	Mon, 16 Mar 2020 12:19:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0265789F75
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 12:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWAmgks1y8+7FuSWUkXMxsGEXHujGD4R4+eaKbmR5EcOTNDNbBu3dml0uJkw+wRIh/HSBGnM2OFSZ/29JvTMBFxcVe+qUrOxX76SpvU3YHWP6z9mRuhM8mkqlktEtlZ3FncaOR0xMHWwyuDwLggn0CFT92h3PvH4iBYNWPAaUdLm/YJqV6CM3fn4XJ1qHK4IbJ7PLSlBfMnjYrkde1d1rUpUXP//M8PKnh6RcAo1bigKaLlYIjITASvP7Luqp+uPEPaPdOpeY4OmN89WWi4OEt/v9OTvglSsRkgb6ZSRMNoz4TpqLq+qfMUrEA42cATuTsVD+gQyKyg4ZBbE1NDE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ1FCJCNwct0eo0FY5rAvPxao0wFEM7bousWTLyB+W0=;
 b=H2yXiBWw/04KxYZFtxiLb1ewLCqPULQaUyhofB8ESei5xRmwbL5uS1+5yu66bmIjqOjLmBwiq8wutQC7fnBSFIi34BEskUXE+0/S2d5DlHFP8pGnc/L0CtmI8hnJdUbpXRGXl21xpBACatpeQXOfcUz8EA1gGd5q0Wi+l4AirpM+F0PMSxa9GlNzIyU5+iCvt9FcnkFBv4DQwJQaRzMXGJwG/SpKHcHe3IIOvcmZ5n2FYbroVLFN8f7ciSygCg1i6GKez/VOhiMq52UGRFu7sZJ8zEVAh1K0VTnBUbu3QMZ/6U5ZWFNJ3FWcSI6Udb5eBrGcJIvA7xzot1aE2tG9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ1FCJCNwct0eo0FY5rAvPxao0wFEM7bousWTLyB+W0=;
 b=KXNbkASyU8bplG3iFjFL0l8+yLZdM1f3vXGK+LW09EPpkDHqruz5lV0NwI5ib7iQk9woCXefzlLpwPsAPp0kKhwfsOSMMb2yDXaNdpbP8Z/MxuwbjpVo8jQ6PvHzP3sXRovm+LGszgsbEOE5s4DYpXqIA87Gp4hMTgdaq76YA8k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Mon, 16 Mar 2020 12:19:25 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f%11]) with mapi id 15.20.2814.021; Mon, 16 Mar
 2020 12:19:25 +0000
Subject: Re: [PATCH v5] drm_amdgpu: Add job fence to resv conditionally
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200316120446.13607-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a9c1c530-6181-7569-94be-2ead3d31ec49@amd.com>
Date: Mon, 16 Mar 2020 13:19:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200316120446.13607-1-xinhui.pan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27)
 To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16 via Frontend Transport; Mon, 16 Mar 2020 12:19:23 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96da9cd2-ec98-4610-cf66-08d7c9a443dd
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:|DM5PR12MB2421:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB242184BC1F468704D068C91383F90@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(31686004)(6666004)(52116002)(8676002)(81156014)(81166006)(8936002)(2906002)(316002)(86362001)(54906003)(31696002)(6486002)(16526019)(5660300002)(186003)(2616005)(36756003)(4326008)(66574012)(66476007)(66946007)(66556008)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2421;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: re39Z9O50MqOqKC1F76iZjz0uDYqrCJzpVWqW4AwYkGjLLRNM+w6W/8izqiZUER8yFdr1uVDYAU9xBl8bQs0DNy5V3PHnO5l6ip+9IMb2u7fhMEyMhJwADe0JN3ZUmsFEJTQhExGzaddqalwuX0ODkyJFOhiuciAYEq3uvJADgvVv59/CqF+ecw1qzznmIZbxHZDaKUYyBQfhik4NMDOUDAMRcF34T7X64o6d3Yx7W8E+IETxvSlt7QmD3ZuilaEAuo2zRhLv6PHvkSrghmxuOOD9RNyN/UBpWPibw6vFq5KiDdvY0lIr0MLX317UmLANcJ7ZdKMDuCeXePMSe7Q3a3yDxqQlv8SpbmmXM2F6XNh+sSpt7lTHc+0NRZ/K0nD3vCgvoLDSuJnV3hVwexty30+NDpnGk10VUftEw45MfMo/qr1Wah6pWR/quZAZ2vS
X-MS-Exchange-AntiSpam-MessageData: oYEHM7BUi1pSyiHNsSVaJKqRl9VzfEuVfgqWm1yh3QLIBNgF/cyOslLZyWQ+AxQW4ctj/8RIkYqSbOaSveiHsmUo5kTlzUklizSium69QmcDzXVG9IP75g0EJCD1slKZNsiudyWkNVZLJgFFnDY4W6v1kA403rLaAkwmFWlyy+eRZDKT63FgSTxFllC2aoCdVkvBh69mAYda7avfcBHcNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96da9cd2-ec98-4610-cf66-08d7c9a443dd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 12:19:24.9132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKHBWGPuHjf0P0rqXsucetpFZgtlg9nYd/TCp74piyzv/NTyfNLvSRxwjsoDB9CE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yintian.Tao@amd.com,
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTYuMDMuMjAgdW0gMTM6MDQgc2NocmllYiB4aW5odWkgcGFuOgo+IEpvYiBmZW5jZSBvbiBw
YWdlIHRhYmxlIHNob3VsZCBiZSBhIHNoYXJlZCBvbmUsIHNvIGFkZCBpdCB0byB0aGUgcm9vdAo+
IHBhZ2UgdGFsYmUgYm8gcmVzdi4KPiBsYXN0X2RlbGF5ZWQgZmllbGQgaXMgbm90IG5lZWRlZCBh
bnltb3JlLiBzbyByZW1vdmUgaXQuCj4KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Cj4gQ2M6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+IFN1
Z2dlc3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KCk9uZSBjb2Rp
bmcgc3R5bGUgbml0IHBpY2sgYmVsb3cuCgo+IC0tLQo+IGNoYW5nZSBmcm9tIHY0Ogo+IHJlbW92
ZSBsYXN0X2RlbGF5ZWQgZmlsZWQuCj4KPiBjaGFuZ2UgZnJvbSB2MzoKPiB1c2Ugdm0gdG8gZ2V0
IHJvb3QgYm8gcmVzdi4KPgo+IGNoYW5nZSBmcm9tIHYyOgo+IHVzZSB0aGUgY29ycmVjdCBwYWdl
IHRhYmxlIGJvIHJlc3YKPgo+IGNoYW5nZSBmcm9tIHYxOgo+IGZpeCByZWJhc2UgaXNzdWUuCj4g
LS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAgICAgIHwgMTYg
KystLS0tLS0tLS0tLS0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmggICAgICB8ICAxIC0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9z
ZG1hLmMgfCAxMCArKysrKy0tLS0tCj4gICAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgMjAgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+IGluZGV4IDczMzk4ODMxMTk2Zi4uOWUxYmFhMzYwZTZhIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMTYwOCw5ICsxNjA4LDYgQEAgc3RhdGljIGlu
dCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
Cj4gICAKPiAgIAkJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGlyZWN0KSkK
PiAgIAkJCWFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kaXJlY3QsIHRydWUpOwo+IC0K
PiAtCQlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+bGFzdF9kZWxheWVkKSkKPiAtCQkJ
YW1kZ3B1X2JvX2ZlbmNlKHJvb3QsIHZtLT5sYXN0X2RlbGF5ZWQsIHRydWUpOwo+ICAgCX0KPiAg
IAo+ICAgCXIgPSB2bS0+dXBkYXRlX2Z1bmNzLT5wcmVwYXJlKCZwYXJhbXMsIHJlc3YsIHN5bmNf
bW9kZSk7Cj4gQEAgLTI1OTIsOCArMjU4OSw3IEBAIGJvb2wgYW1kZ3B1X3ZtX2V2aWN0YWJsZShz
dHJ1Y3QgYW1kZ3B1X2JvICpibykKPiAgIAkJcmV0dXJuIGZhbHNlOwo+ICAgCj4gICAJLyogRG9u
J3QgZXZpY3QgVk0gcGFnZSB0YWJsZXMgd2hpbGUgdGhleSBhcmUgdXBkYXRlZCAqLwo+IC0JaWYg
KCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQoYm9fYmFzZS0+dm0tPmxhc3RfZGlyZWN0KSB8fAo+IC0J
ICAgICFkbWFfZmVuY2VfaXNfc2lnbmFsZWQoYm9fYmFzZS0+dm0tPmxhc3RfZGVsYXllZCkpIHsK
PiArCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKGJvX2Jhc2UtPnZtLT5sYXN0X2RpcmVjdCkp
IHsKPiAgIAkJYW1kZ3B1X3ZtX2V2aWN0aW9uX3VubG9jayhib19iYXNlLT52bSk7Cj4gICAJCXJl
dHVybiBmYWxzZTsKPiAgIAl9Cj4gQEAgLTI3NzAsMTEgKzI3NjYsNyBAQCBsb25nIGFtZGdwdV92
bV93YWl0X2lkbGUoc3RydWN0IGFtZGdwdV92bSAqdm0sIGxvbmcgdGltZW91dCkKPiAgIAlpZiAo
dGltZW91dCA8PSAwKQo+ICAgCQlyZXR1cm4gdGltZW91dDsKPiAgIAo+IC0JdGltZW91dCA9IGRt
YV9mZW5jZV93YWl0X3RpbWVvdXQodm0tPmxhc3RfZGlyZWN0LCB0cnVlLCB0aW1lb3V0KTsKPiAt
CWlmICh0aW1lb3V0IDw9IDApCj4gLQkJcmV0dXJuIHRpbWVvdXQ7Cj4gLQo+IC0JcmV0dXJuIGRt
YV9mZW5jZV93YWl0X3RpbWVvdXQodm0tPmxhc3RfZGVsYXllZCwgdHJ1ZSwgdGltZW91dCk7Cj4g
KwlyZXR1cm4gZG1hX2ZlbmNlX3dhaXRfdGltZW91dCh2bS0+bGFzdF9kaXJlY3QsIHRydWUsIHRp
bWVvdXQpOwo+ICAgfQo+ICAgCj4gICAvKioKPiBAQCAtMjg0Nyw3ICsyODM5LDYgQEAgaW50IGFt
ZGdwdV92bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3Zt
ICp2bSwKPiAgIAkJdm0tPnVwZGF0ZV9mdW5jcyA9ICZhbWRncHVfdm1fc2RtYV9mdW5jczsKPiAg
IAl2bS0+bGFzdF91cGRhdGUgPSBOVUxMOwo+ICAgCXZtLT5sYXN0X2RpcmVjdCA9IGRtYV9mZW5j
ZV9nZXRfc3R1YigpOwo+IC0Jdm0tPmxhc3RfZGVsYXllZCA9IGRtYV9mZW5jZV9nZXRfc3R1Yigp
Owo+ICAgCj4gICAJbXV0ZXhfaW5pdCgmdm0tPmV2aWN0aW9uX2xvY2spOwo+ICAgCXZtLT5ldmlj
dGluZyA9IGZhbHNlOwo+IEBAIC0yOTAyLDcgKzI4OTMsNiBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+ICAgCj4g
ICBlcnJvcl9mcmVlX2RlbGF5ZWQ6Cj4gICAJZG1hX2ZlbmNlX3B1dCh2bS0+bGFzdF9kaXJlY3Qp
Owo+IC0JZG1hX2ZlbmNlX3B1dCh2bS0+bGFzdF9kZWxheWVkKTsKPiAgIAlkcm1fc2NoZWRfZW50
aXR5X2Rlc3Ryb3koJnZtLT5kZWxheWVkKTsKPiAgIAo+ICAgZXJyb3JfZnJlZV9kaXJlY3Q6Cj4g
QEAgLTMxMDUsOCArMzA5NSw2IEBAIHZvaWQgYW1kZ3B1X3ZtX2Zpbmkoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtKQo+ICAgCj4gICAJZG1hX2ZlbmNlX3dh
aXQodm0tPmxhc3RfZGlyZWN0LCBmYWxzZSk7Cj4gICAJZG1hX2ZlbmNlX3B1dCh2bS0+bGFzdF9k
aXJlY3QpOwo+IC0JZG1hX2ZlbmNlX3dhaXQodm0tPmxhc3RfZGVsYXllZCwgZmFsc2UpOwo+IC0J
ZG1hX2ZlbmNlX3B1dCh2bS0+bGFzdF9kZWxheWVkKTsKPiAgIAo+ICAgCWxpc3RfZm9yX2VhY2hf
ZW50cnlfc2FmZShtYXBwaW5nLCB0bXAsICZ2bS0+ZnJlZWQsIGxpc3QpIHsKPiAgIAkJaWYgKG1h
cHBpbmctPmZsYWdzICYgQU1ER1BVX1BURV9QUlQgJiYgcHJ0X2ZpbmlfbmVlZGVkKSB7Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKPiBpbmRleCBiNTcwNWZjZmM5MzUuLmI1
MmVmYzU5MTE2MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4g
QEAgLTI3OSw3ICsyNzksNiBAQCBzdHJ1Y3QgYW1kZ3B1X3ZtIHsKPiAgIAo+ICAgCS8qIExhc3Qg
c3VibWlzc2lvbiB0byB0aGUgc2NoZWR1bGVyIGVudGl0aWVzICovCj4gICAJc3RydWN0IGRtYV9m
ZW5jZQkqbGFzdF9kaXJlY3Q7Cj4gLQlzdHJ1Y3QgZG1hX2ZlbmNlCSpsYXN0X2RlbGF5ZWQ7Cj4g
ICAKPiAgIAl1bnNpZ25lZCBpbnQJCXBhc2lkOwo+ICAgCS8qIGRlZGljYXRlZCB0byB2bSAqLwo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwo+IGluZGV4IDRj
Yzc4ODFmNDM4Yy4uMTViYjMwZGY5YWUxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm1fc2RtYS5jCj4gQEAgLTEwNCwxMiArMTA0LDEyIEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZtX3NkbWFfY29tbWl0KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwK
PiAgIAlpZiAocikKPiAgIAkJZ290byBlcnJvcjsKPiAgIAo+IC0JdG1wID0gZG1hX2ZlbmNlX2dl
dChmKTsKPiAtCWlmIChwLT5kaXJlY3QpCj4gKwlpZiAocC0+ZGlyZWN0KSB7Cj4gKwkJdG1wID0g
ZG1hX2ZlbmNlX2dldChmKTsKPiAgIAkJc3dhcChwLT52bS0+bGFzdF9kaXJlY3QsIHRtcCk7Cj4g
LQllbHNlCj4gLQkJc3dhcChwLT52bS0+bGFzdF9kZWxheWVkLCB0bXApOwo+IC0JZG1hX2ZlbmNl
X3B1dCh0bXApOwo+ICsJCWRtYV9mZW5jZV9wdXQodG1wKTsKPiArCX0gZWxzZQo+ICsJCWRtYV9y
ZXN2X2FkZF9zaGFyZWRfZmVuY2UocC0+dm0tPnJvb3QuYmFzZS5iby0+dGJvLmJhc2UucmVzdiwg
Zik7CgpXaGVuIG9uZSBwYXJ0IG9mIHRoZSBpZi9lbHNlIGhhcyB7fSB0aGUgb3RoZXIgc2hvdWxk
IGFzIHdlbGwuIEluIG90aGVyIAp3b3JkcyB1c2UgIn0gZWxzZSB7Ii4uLiBoZXJlLgoKQXBhcnQg
ZnJvbSB0aGF0IHRoZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyAKPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgpUaGFua3MsCkNocmlzdGlhbi4KCj4gICAKPiAgIAlp
ZiAoZmVuY2UgJiYgIXAtPmRpcmVjdCkKPiAgIAkJc3dhcCgqZmVuY2UsIGYpOwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
