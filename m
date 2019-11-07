Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DBFC5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 04:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5502187F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 04:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5502187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5841E6EE7A;
	Thu,  7 Nov 2019 04:45:22 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740043.outbound.protection.outlook.com [40.107.74.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3327F6EE7A
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 04:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVuiZxW9JdVw2mHLbf9j4d0qWi/6nuvyE8GbI8J4THKGg8qFVvqgx4bQy7ZbbOoMbskDYovLTQUr/deSWAIjngQXGPsMR7zThCG1WtuyOdUqCz0l9S58/i59EzW+BjUm0JynHd7ZXBX/KujAmRJa24wsiETDW85IioFhvyuFeQV6o0xaB6MUpSnTY7c90fZrIjK1ew1RrYDU69Gsg8LPnIyFX62VHBDOUem7skCnWmMVfMkUxYWaa2pLKy+csEfC24A15fbyUysWrGRbM06JoTefoIMN8HxzNcYmi57q55HGZsi//7+6l1z437gDLOWBCElVjhEx5cZrXsSByTvjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvwwE67/PZQw61bgQpNqTWax83abWC9PZQI6wXWROTM=;
 b=BFOGRbjoZl3vnlsHASK6guP3260MPnbvvU1jRvlQwCyW0s1jXxwC8oMppVO5gY3/EHDLGJxlTC79zwOljjRaSPlA0fqG6HEn6+KnH875V5wUwVp7vsF+i+huoESjqiOmj1+qeal9/VFWohc/Gc5hvbPIViI5KhsAb4wymwxMO6gOXn7h1j+Q+CrF2mWSUhU/ORcWocjBn6rD87nqJ/65Pq192n0fjvv3fM3D8fLM6x5Z5hmN0zd5mfUtlxkM9LXKZz4igt0wPuhoRtHj+G1KzspFG2FaoFMqxzQx5jgjwNP7Z85sJJDspUYeBL8is8shak7s6YC/cSNeYgGKU1c4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB2745.namprd12.prod.outlook.com (20.176.117.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 04:45:17 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2408.024; Thu, 7 Nov 2019
 04:45:17 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Thread-Topic: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Thread-Index: AQHVj4Cnk6bDefnEn0qwGZufIzY7Wqd/LUeA
Date: Thu, 7 Nov 2019 04:45:17 +0000
Message-ID: <31102345-20f7-1b0e-dd2a-f7984b253a07@amd.com>
References: <20191031001739.10764-1-Yong.Zhao@amd.com>
 <20191031001739.10764-2-Yong.Zhao@amd.com>
In-Reply-To: <20191031001739.10764-2-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.54.211]
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-clientproxiedby: YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::31) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e4ff6c0-6ea6-42ff-17e0-08d7633d48f6
x-ms-traffictypediagnostic: DM6PR12MB2745:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB27450A40FED3855FD5A1BBC392780@DM6PR12MB2745.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(189003)(199004)(6246003)(2501003)(86362001)(6486002)(31696002)(2906002)(6436002)(7736002)(305945005)(3846002)(4001150100001)(6116002)(229853002)(36756003)(186003)(26005)(102836004)(25786009)(71200400001)(71190400001)(6512007)(446003)(5660300002)(66556008)(66446008)(64756008)(66946007)(66476007)(99286004)(52116002)(478600001)(53546011)(6506007)(386003)(14454004)(11346002)(76176011)(316002)(58126008)(110136005)(31686004)(14444005)(256004)(2616005)(486006)(81156014)(476003)(8676002)(81166006)(8936002)(65806001)(65956001)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2745;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x28kgG4to8ItrNfsmNo58dCV0x9P3IM7gzL+3UWBWz3k08bjFvingF5CnVDiSN4crh+s5SqSWZmNFzjXsvlfpdI3Sr2TXBiIPciOQE13cE/1tO8CveOwcxH0PDZKHLaxidj1RgV3Guli+pa/gVH1/lqaBZ00YaOSqp/xtUSSRV8ZsQnzaBUB4m0/lfNPEtrvNQ+anBQAD8T9cb+ETXQEgsPrcb2jqz5Cz/QLpMp6Hgj7qlDZ8zCfKTl2FS4sN/T/HguV26oYQhN3+521DTCgUxpb8pgIVB7MDTwPsrtLA6GKl8Ifq1DtpFI92p99lFCN7R+oaF3Rp9klTbh0gbb+Pn4dfURDw0mMw3CCqU4Kv+n1t+7OtF3X0fre3DuxUfMuOt/0lHJqzTvwQXrlXganELx5ve3a87omE0UEe5aTTXkmGiQTQqNIev+RW3EXfsZC
Content-ID: <EB369A33F5C6C04BAADFB90C54A7C06A@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4ff6c0-6ea6-42ff-17e0-08d7633d48f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 04:45:17.1835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/hwizvcePMBYGOn7Xu5Iro8f2cesMWeYmn8Tm4AcGMuwxjnPUlVdFrWp+OyBFzZtqvlchp/WdvVzVasorUUAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2745
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvwwE67/PZQw61bgQpNqTWax83abWC9PZQI6wXWROTM=;
 b=rPSh1BtGVaOAtktR0RvYkB10b6BDbWE25FEcbxb+Rz3LXxrm1/lQnEBoPtZmXM8KoayuW80x55/N38gLlCE6hh+sE843hWklQBrKudhKkQwhDqwMczPWX0Wo0GAW8jG7iCQl/oyFXlIZWp5FlVNX7y+hREpg9WqRErEm0sgpLME=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107044517.-N1ihEQDkgWh5U2IYvw7EXAho1xXrgedX5aPObIHthY@z>

T24gMjAxOS0xMC0zMCAyMDoxNywgWmhhbywgWW9uZyB3cm90ZToNCj4gcmVsZWFzZV9tZW0gd29u
J3QgYmUgdXNlZCBhdCBhbGwgb24gR0ZYOSBhbmQgR0ZYMTAsIHNvIGRlbGV0ZSBpdC4NCg0KSGF3
YWlpIHdhcyBHRlh2Ny4gU28gd2UncmUgbm90IHVzaW5nIHRoZSByZWxlYXNlX21lbSBwYWNrZXQg
b24gR0ZYdjggDQplaXRoZXIuIFdoeSBhcmJpdHJhcmlseSBsaW1pdCB0aGlzIGNoYW5nZSB0byBH
Rlh2OSBhbmQgMTA/DQoNClJlZ2FyZHMsDQogwqAgRmVsaXgNCg0KPg0KPiBDaGFuZ2UtSWQ6IEkx
Mzc4N2E4YTI5YjgzZTc1MTZjNTgyYTc0MDFmMmUxNDcyMWVkZjVmDQo+IFNpZ25lZC1vZmYtYnk6
IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+DQo+IC0tLQ0KPiAgIC4uLi9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZV92MTAuYyB8IDM1ICsrLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gICAuLi4vZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWVfdjkuYyAgfCAzMyAr
Ky0tLS0tLS0tLS0tLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA2
NCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9rZXJuZWxfcXVldWVfdjEwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfa2VybmVsX3F1ZXVlX3YxMC5jDQo+IGluZGV4IGFlZDMyYWI3MTAyZS4uYmZkNjIyMWFjYWU5
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1
ZXVlX3YxMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxf
cXVldWVfdjEwLmMNCj4gQEAgLTI5OCwzNyArMjk4LDYgQEAgc3RhdGljIGludCBwbV9xdWVyeV9z
dGF0dXNfdjEwKHN0cnVjdCBwYWNrZXRfbWFuYWdlciAqcG0sIHVpbnQzMl90ICpidWZmZXIsDQo+
ICAgCXJldHVybiAwOw0KPiAgIH0NCj4gICANCj4gLQ0KPiAtc3RhdGljIGludCBwbV9yZWxlYXNl
X21lbV92MTAodWludDY0X3QgZ3B1X2FkZHIsIHVpbnQzMl90ICpidWZmZXIpDQo+IC17DQo+IC0J
c3RydWN0IHBtNF9tZWNfcmVsZWFzZV9tZW0gKnBhY2tldDsNCj4gLQ0KPiAtCVdBUk5fT04oIWJ1
ZmZlcik7DQo+IC0NCj4gLQlwYWNrZXQgPSAoc3RydWN0IHBtNF9tZWNfcmVsZWFzZV9tZW0gKili
dWZmZXI7DQo+IC0JbWVtc2V0KGJ1ZmZlciwgMCwgc2l6ZW9mKHN0cnVjdCBwbTRfbWVjX3JlbGVh
c2VfbWVtKSk7DQo+IC0NCj4gLQlwYWNrZXQtPmhlYWRlci51MzJBbGwgPSBwbV9idWlsZF9wbTRf
aGVhZGVyKElUX1JFTEVBU0VfTUVNLA0KPiAtCQkJCQlzaXplb2Yoc3RydWN0IHBtNF9tZWNfcmVs
ZWFzZV9tZW0pKTsNCj4gLQ0KPiAtCXBhY2tldC0+Yml0ZmllbGRzMi5ldmVudF90eXBlID0gQ0FD
SEVfRkxVU0hfQU5EX0lOVl9UU19FVkVOVDsNCj4gLQlwYWNrZXQtPmJpdGZpZWxkczIuZXZlbnRf
aW5kZXggPSBldmVudF9pbmRleF9fbWVjX3JlbGVhc2VfbWVtX19lbmRfb2ZfcGlwZTsNCj4gLQlw
YWNrZXQtPmJpdGZpZWxkczIudGNsMV9hY3Rpb25fZW5hID0gMTsNCj4gLQlwYWNrZXQtPmJpdGZp
ZWxkczIudGNfYWN0aW9uX2VuYSA9IDE7DQo+IC0JcGFja2V0LT5iaXRmaWVsZHMyLmNhY2hlX3Bv
bGljeSA9IGNhY2hlX3BvbGljeV9fbWVjX3JlbGVhc2VfbWVtX19scnU7DQo+IC0NCj4gLQlwYWNr
ZXQtPmJpdGZpZWxkczMuZGF0YV9zZWwgPSBkYXRhX3NlbF9fbWVjX3JlbGVhc2VfbWVtX19zZW5k
XzMyX2JpdF9sb3c7DQo+IC0JcGFja2V0LT5iaXRmaWVsZHMzLmludF9zZWwgPQ0KPiAtCQlpbnRf
c2VsX19tZWNfcmVsZWFzZV9tZW1fX3NlbmRfaW50ZXJydXB0X2FmdGVyX3dyaXRlX2NvbmZpcm07
DQo+IC0NCj4gLQlwYWNrZXQtPmJpdGZpZWxkczQuYWRkcmVzc19sb18zMmIgPSAoZ3B1X2FkZHIg
JiAweGZmZmZmZmZmKSA+PiAyOw0KPiAtCXBhY2tldC0+YWRkcmVzc19oaSA9IHVwcGVyXzMyX2Jp
dHMoZ3B1X2FkZHIpOw0KPiAtDQo+IC0JcGFja2V0LT5kYXRhX2xvID0gMDsNCj4gLQ0KPiAtCXJl
dHVybiBzaXplb2Yoc3RydWN0IHBtNF9tZWNfcmVsZWFzZV9tZW0pIC8gc2l6ZW9mKHVuc2lnbmVk
IGludCk7DQo+IC19DQo+IC0NCj4gICBjb25zdCBzdHJ1Y3QgcGFja2V0X21hbmFnZXJfZnVuY3Mg
a2ZkX3YxMF9wbV9mdW5jcyA9IHsNCj4gICAJLm1hcF9wcm9jZXNzCQkJPSBwbV9tYXBfcHJvY2Vz
c192MTAsDQo+ICAgCS5ydW5saXN0CQkJPSBwbV9ydW5saXN0X3YxMCwNCj4gQEAgLTMzNiwxMyAr
MzA1LDEzIEBAIGNvbnN0IHN0cnVjdCBwYWNrZXRfbWFuYWdlcl9mdW5jcyBrZmRfdjEwX3BtX2Z1
bmNzID0gew0KPiAgIAkubWFwX3F1ZXVlcwkJCT0gcG1fbWFwX3F1ZXVlc192MTAsDQo+ICAgCS51
bm1hcF9xdWV1ZXMJCQk9IHBtX3VubWFwX3F1ZXVlc192MTAsDQo+ICAgCS5xdWVyeV9zdGF0dXMJ
CQk9IHBtX3F1ZXJ5X3N0YXR1c192MTAsDQo+IC0JLnJlbGVhc2VfbWVtCQkJPSBwbV9yZWxlYXNl
X21lbV92MTAsDQo+ICsJLnJlbGVhc2VfbWVtCQkJPSBOVUxMLA0KPiAgIAkubWFwX3Byb2Nlc3Nf
c2l6ZQkJPSBzaXplb2Yoc3RydWN0IHBtNF9tZXNfbWFwX3Byb2Nlc3MpLA0KPiAgIAkucnVubGlz
dF9zaXplCQkJPSBzaXplb2Yoc3RydWN0IHBtNF9tZXNfcnVubGlzdCksDQo+ICAgCS5zZXRfcmVz
b3VyY2VzX3NpemUJCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVzX3NldF9yZXNvdXJjZXMpLA0KPiAg
IAkubWFwX3F1ZXVlc19zaXplCQk9IHNpemVvZihzdHJ1Y3QgcG00X21lc19tYXBfcXVldWVzKSwN
Cj4gICAJLnVubWFwX3F1ZXVlc19zaXplCQk9IHNpemVvZihzdHJ1Y3QgcG00X21lc191bm1hcF9x
dWV1ZXMpLA0KPiAgIAkucXVlcnlfc3RhdHVzX3NpemUJCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVz
X3F1ZXJ5X3N0YXR1cyksDQo+IC0JLnJlbGVhc2VfbWVtX3NpemUJCT0gc2l6ZW9mKHN0cnVjdCBw
bTRfbWVjX3JlbGVhc2VfbWVtKQ0KPiArCS5yZWxlYXNlX21lbV9zaXplCQk9IDAsDQo+ICAgfTsN
Cj4gICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJu
ZWxfcXVldWVfdjkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVl
dWVfdjkuYw0KPiBpbmRleCAzYjVjYTJiMWQ3YTYuLmYwZTQ5MTBhODg2NSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZV92OS5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWVfdjkuYw0KPiBA
QCAtMzM2LDM1ICszMzYsNiBAQCBzdGF0aWMgaW50IHBtX3F1ZXJ5X3N0YXR1c192OShzdHJ1Y3Qg
cGFja2V0X21hbmFnZXIgKnBtLCB1aW50MzJfdCAqYnVmZmVyLA0KPiAgIAlyZXR1cm4gMDsNCj4g
ICB9DQo+ICAgDQo+IC0NCj4gLXN0YXRpYyBpbnQgcG1fcmVsZWFzZV9tZW1fdjkodWludDY0X3Qg
Z3B1X2FkZHIsIHVpbnQzMl90ICpidWZmZXIpDQo+IC17DQo+IC0Jc3RydWN0IHBtNF9tZWNfcmVs
ZWFzZV9tZW0gKnBhY2tldDsNCj4gLQ0KPiAtCXBhY2tldCA9IChzdHJ1Y3QgcG00X21lY19yZWxl
YXNlX21lbSAqKWJ1ZmZlcjsNCj4gLQltZW1zZXQoYnVmZmVyLCAwLCBzaXplb2Yoc3RydWN0IHBt
NF9tZWNfcmVsZWFzZV9tZW0pKTsNCj4gLQ0KPiAtCXBhY2tldC0+aGVhZGVyLnUzMkFsbCA9IHBt
X2J1aWxkX3BtNF9oZWFkZXIoSVRfUkVMRUFTRV9NRU0sDQo+IC0JCQkJCXNpemVvZihzdHJ1Y3Qg
cG00X21lY19yZWxlYXNlX21lbSkpOw0KPiAtDQo+IC0JcGFja2V0LT5iaXRmaWVsZHMyLmV2ZW50
X3R5cGUgPSBDQUNIRV9GTFVTSF9BTkRfSU5WX1RTX0VWRU5UOw0KPiAtCXBhY2tldC0+Yml0Zmll
bGRzMi5ldmVudF9pbmRleCA9IGV2ZW50X2luZGV4X19tZWNfcmVsZWFzZV9tZW1fX2VuZF9vZl9w
aXBlOw0KPiAtCXBhY2tldC0+Yml0ZmllbGRzMi50Y2wxX2FjdGlvbl9lbmEgPSAxOw0KPiAtCXBh
Y2tldC0+Yml0ZmllbGRzMi50Y19hY3Rpb25fZW5hID0gMTsNCj4gLQlwYWNrZXQtPmJpdGZpZWxk
czIuY2FjaGVfcG9saWN5ID0gY2FjaGVfcG9saWN5X19tZWNfcmVsZWFzZV9tZW1fX2xydTsNCj4g
LQ0KPiAtCXBhY2tldC0+Yml0ZmllbGRzMy5kYXRhX3NlbCA9IGRhdGFfc2VsX19tZWNfcmVsZWFz
ZV9tZW1fX3NlbmRfMzJfYml0X2xvdzsNCj4gLQlwYWNrZXQtPmJpdGZpZWxkczMuaW50X3NlbCA9
DQo+IC0JCWludF9zZWxfX21lY19yZWxlYXNlX21lbV9fc2VuZF9pbnRlcnJ1cHRfYWZ0ZXJfd3Jp
dGVfY29uZmlybTsNCj4gLQ0KPiAtCXBhY2tldC0+Yml0ZmllbGRzNC5hZGRyZXNzX2xvXzMyYiA9
IChncHVfYWRkciAmIDB4ZmZmZmZmZmYpID4+IDI7DQo+IC0JcGFja2V0LT5hZGRyZXNzX2hpID0g
dXBwZXJfMzJfYml0cyhncHVfYWRkcik7DQo+IC0NCj4gLQlwYWNrZXQtPmRhdGFfbG8gPSAwOw0K
PiAtDQo+IC0JcmV0dXJuIDA7DQo+IC19DQo+IC0NCj4gICBjb25zdCBzdHJ1Y3QgcGFja2V0X21h
bmFnZXJfZnVuY3Mga2ZkX3Y5X3BtX2Z1bmNzID0gew0KPiAgIAkubWFwX3Byb2Nlc3MJCT0gcG1f
bWFwX3Byb2Nlc3NfdjksDQo+ICAgCS5ydW5saXN0CQk9IHBtX3J1bmxpc3RfdjksDQo+IEBAIC0z
NzIsMTIgKzM0MywxMiBAQCBjb25zdCBzdHJ1Y3QgcGFja2V0X21hbmFnZXJfZnVuY3Mga2ZkX3Y5
X3BtX2Z1bmNzID0gew0KPiAgIAkubWFwX3F1ZXVlcwkJPSBwbV9tYXBfcXVldWVzX3Y5LA0KPiAg
IAkudW5tYXBfcXVldWVzCQk9IHBtX3VubWFwX3F1ZXVlc192OSwNCj4gICAJLnF1ZXJ5X3N0YXR1
cwkJPSBwbV9xdWVyeV9zdGF0dXNfdjksDQo+IC0JLnJlbGVhc2VfbWVtCQk9IHBtX3JlbGVhc2Vf
bWVtX3Y5LA0KPiArCS5yZWxlYXNlX21lbQkJPSBOVUxMLA0KPiAgIAkubWFwX3Byb2Nlc3Nfc2l6
ZQk9IHNpemVvZihzdHJ1Y3QgcG00X21lc19tYXBfcHJvY2VzcyksDQo+ICAgCS5ydW5saXN0X3Np
emUJCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVzX3J1bmxpc3QpLA0KPiAgIAkuc2V0X3Jlc291cmNl
c19zaXplCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVzX3NldF9yZXNvdXJjZXMpLA0KPiAgIAkubWFw
X3F1ZXVlc19zaXplCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVzX21hcF9xdWV1ZXMpLA0KPiAgIAku
dW5tYXBfcXVldWVzX3NpemUJPSBzaXplb2Yoc3RydWN0IHBtNF9tZXNfdW5tYXBfcXVldWVzKSwN
Cj4gICAJLnF1ZXJ5X3N0YXR1c19zaXplCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVzX3F1ZXJ5X3N0
YXR1cyksDQo+IC0JLnJlbGVhc2VfbWVtX3NpemUJPSBzaXplb2Yoc3RydWN0IHBtNF9tZWNfcmVs
ZWFzZV9tZW0pDQo+ICsJLnJlbGVhc2VfbWVtX3NpemUJPSAwLA0KPiAgIH07DQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
