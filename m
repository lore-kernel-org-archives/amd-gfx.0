Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAE2C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 13:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7C02251F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 13:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7C02251F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A8296E8F5;
	Wed, 20 Nov 2019 13:20:59 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790083.outbound.protection.outlook.com [40.107.79.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 827516E8F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 13:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqPMWEwcMzBihKRdtwP0N2nwrmEftHTf7yoyQo+g3DpJ2ge0C0Y8yvDH68T0sWhI6MbY3VtE0L3CPBit5b5oKcp0USAjstvAeE0pdZpGbR9pAWpRLnaJbPnWGD9nm7oiju4OvbwX/1dKO6UaAmtkiCEr2iGCdH91UbJ7gSs162oeHUDzHWhSs4AFuntpPE9xV/sqDYIqABitgEqigwwptLrD+r0Pwh1pqLXBoTOMp1Q4qGeP+5LmDjSl4eKH5o3NCpz7Ph1qtpq7IJs151nJAizb7aAtBYEv20IH9EPGoMeyCVTw9a35og6F2h4Gz4nrjuOQgE1GxEGjjXdFzRgd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbXhsUhJ8o78+FPhh+KVzBVdEm5tUDGcRT/9+JBzTtM=;
 b=FwEwtEcBmAQ46EtFhfASeLH0SLCfzjo4oN/4QE7cKS5JEa1npwt0iah1F0bhLh9p1Fxyw7EwSoBBlFRsEy8KV30bOAc7AOpKXZJD5gt+2Em0mwPE86zKxdSohmxCEwtudUdTf1gTmDOwksPt/POq1oXNet267oR6qjp1sw3e2G17bpc4sOwlssY+sd2GRjsZ5XgH8cAOuJpuN+n5/0r1FylK017bSK9++JMt6m3r5MV7dD6+GRXNpcqxczNI1R/u1OVZ2HfrwuooRrY/e4kJkUfKT0WHuZnLaZLq3+pNaRVbA72C7UdsCZlS/SL93tIy9HFtG6Jty23zVYYbl0TLAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1180.namprd12.prod.outlook.com (10.168.237.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 13:20:57 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 13:20:57 +0000
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogaW52YWxp?=
 =?UTF-8?Q?date_mmhub_semphore_workaround_in_amdgpu=5fvirt?=
To: "Liu, Monk" <Monk.Liu@amd.com>, "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, 
 "Xiao, Jack" <Jack.Xiao@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Huang, Shimmer" <Xinmei.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191120091418.26526-1-changfeng.zhu@amd.com>
 <MN2PR12MB3933863C8DFCE1F68A44EFFA844F0@MN2PR12MB3933.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1d7cd15c-f529-93da-c15e-a1fde745e6c5@amd.com>
Date: Wed, 20 Nov 2019 14:20:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MN2PR12MB3933863C8DFCE1F68A44EFFA844F0@MN2PR12MB3933.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aecf2cc7-8208-4d69-cb74-08d76dbc7a35
X-MS-TrafficTypeDiagnostic: DM5PR12MB1180:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1180BE88582D6B9708028FA1834F0@DM5PR12MB1180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(23676004)(25786009)(6306002)(46003)(6512007)(14444005)(66946007)(66556008)(316002)(2501003)(110136005)(478600001)(2486003)(52116002)(31686004)(31696002)(66476007)(2870700001)(86362001)(486006)(8936002)(81156014)(81166006)(224303003)(229853002)(476003)(2906002)(2616005)(5660300002)(966005)(386003)(6506007)(6666004)(14454004)(50466002)(11346002)(446003)(6246003)(65956001)(58126008)(65806001)(47776003)(76176011)(6116002)(305945005)(186003)(99286004)(6486002)(6436002)(36756003)(7736002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1180;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oze7MsEwpZCiYoVCsEJ4O35dPpbt6fTbw+iGMolMFOVB26kNwjNNtWf1djVZXj5wU/mvmZ8uqaxj86IZH89eMk3ypnOVa7Aoz2uz0ocHWbyFXyuUlSE1GB3J5dfVtBnVZ8F6A+pvCUyb/TO5MQp/YdUI4ORqGlm0zE5jVeQrXA4KKLqTDYhF+bajb4JTXoqj7ugUmNaaWwnlx1wPt1qMHpxWA+4uK2/0jCuVmFT0ZFk3AOa0wVuSOwRtgKjQ4cvSV7uco/q6VQ5G6+9Lv63ZDi10zFrlt61ZoZsEoW40hdSzUi/n2wwv8B8CeKkMu91rluqRH06wmLcWrtF9yESXV+NBIcYnA/KkN92k8u8MpRuLWuvW73cNxdIp8tKMop0LmWZjQZryC99OrzaE88GdGg57EvNbi4QoWNsHwTpP/DmRpFKWvU40GdaspPhNdfWxCqsmnVkokVWwbaMrAIt2AVYcIRa2J221k1o6fiSWa1E=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecf2cc7-8208-4d69-cb74-08d76dbc7a35
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 13:20:56.9818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXOA5kIyiolqRE8G0l+Sd9TucpJkNvcdrxZ5LKdH45ZABhDla1yDdYmUGnSWUFZj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1180
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbXhsUhJ8o78+FPhh+KVzBVdEm5tUDGcRT/9+JBzTtM=;
 b=G4E5wF+qjuwBVR5P20QXDvvpfdtdxmayvHwjm06DQ+bkeXE6HBaG19Chyy9ZbaBhiAdADaOX2H7bnKajnorf0pe82FDZr7Wrae7HVK4EMr/my1WMmdbj+lRPkEwbdVYyEvU1j5IyS0qDmBQ2Xd0X0330KMJmrxbnVeHL6aZobXM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Message-ID: <20191120132051.CS8WPrd_aQe1-VEjAe6BKf0V3_1fe1BjAOuBLiUOMcU@z>

SGkgTW9uaywKCnRoaXMgaXMgYSBmaXggZm9yIHBvd2VyIGdhdGluZyB0aGUgTU1IVUIuCgpCYXNp
YyBwcm9ibGVtIGlzIHRoYXQgdGhlIE1NSFVCIGNhbiBwb3dlciBnYXRlIHdoaWxlIGFuIGludmFs
aWRhdGlvbiBpcyAKaW4gcHJvZ3Jlc3Mgd2hpY2ggbG9vc2VzIGFsbCBiaXRzIGluIHRoZSBBQ0sg
cmVnaXN0ZXIgYW5kIHNvIGRlYWRsb2NrcyAKdGhlIGVuZ2luZSB3YWl0aW5nIGZvciB0aGUgaW52
YWxpZGF0aW9uIHRvIGZpbmlzaC4KClRoaXMgYnVnIGlzIGhpdCBpbW1lZGlhdGVseSB3aGVuIHdl
IGVuYWJsZSBwb3dlciBnYXRpbmcgb2YgdGhlIE1NSFVCLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoK
QW0gMjAuMTEuMTkgdW0gMTQ6MTggc2NocmllYiBMaXUsIE1vbms6Cj4gSGkgQ2hhbmdmZW5nCj4K
PiBGaXJzIG9mIGFsbCwgdGhlcmUgaXMgbm8gcG93ZXItZ2F0aW5nIG9mZiBjaXJjbGUgaW52b2x2
ZWQgaW4gQU1ER1BVIFNSSU9WLCBzaW5jZSB3ZSBkb24ndCBhbGxvdyBWRi9WTSBkbyBzdWNoIHRo
aW5ncyBzbyBJIGRvIGZlZWwgc3RyYW5nZSB3aHkgeW91IHBvc3Qgc29tZXRoaW5nIGxpa2UgdGhp
cwo+IEVzcGVjaWFsbHkgb24gVkVHQTEwIHNlcmlhbHMgd2hpY2ggbG9va3MgZG9lc24ndCBoYXZl
IGFueSBpc3N1ZSBvbiB0aG9zZSBncHVfZmx1c2ggcGFydAo+Cj4gSGVyZSBpcyBteSBxdWVzdGlv
bnMgZm9yIHlvdToKPiAxKSBDYW4geW91IHBvaW50IG1lIHdoYXQgaXNzdWUgaGFkIHlvdSBiZWVu
IGV4cGVyaWVuY2VkID8gYW5kIGhvdyB0byByZXBybyB0aGUgYnVnCj4gMikgaWYgeW91IGRvIGhp
dCBzb21lIGlzc3VlcywgZGlkIHlvdSB2ZXJpZmllZCB0aGF0IHlvdXIgcGF0Y2ggY2FuIGZpeCBp
dCA/Cj4KPiBiZXNpZGVzCj4KPiAvTW9uawo+Cj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQo+IOWP
keS7tuS6ujogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4g
5Luj6KGoIENoYW5nZmVuZy5aaHUKPiDlj5HpgIHml7bpl7Q6IDIwMTnlubQxMeaciDIw5pelIDE3
OjE0Cj4g5pS25Lu25Lq6OiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQu
Y29tPjsgWGlhbywgSmFjayA8SmFjay5YaWFvQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhv
dTFAYW1kLmNvbT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgSHVhbmcsIFNoaW1t
ZXIgPFhpbm1laS5IdWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiDmioTpgIE6IFpodSwgQ2hhbmdmZW5nIDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+Cj4g5Li76aKY
OiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBpbnZhbGlkYXRlIG1taHViIHNlbXBob3JlIHdvcmth
cm91bmQgaW4gYW1kZ3B1X3ZpcnQKPgo+IEZyb206IGNoYW5nemh1IDxDaGFuZ2ZlbmcuWmh1QGFt
ZC5jb20+Cj4KPiBJdCBtYXkgbG9zZSBncHV2bSBpbnZhbGlkYXRlIGFja25vd2xkZWdlIHN0YXRl
IGFjcm9zcyBwb3dlci1nYXRpbmcgb2ZmIGN5Y2xlLiBUbyBhdm9pZCB0aGlzIGlzc3VlIGluIHZp
cnQgaW52YWxpZGF0aW9uLCBhZGQgc2VtYXBob3JlIGFjcXVpcmUgYmVmb3JlIGludmFsaWRhdGlv
biBhbmQgc2VtYXBob3JlIHJlbGVhc2UgYWZ0ZXIgaW52YWxpZGF0aW9uLgo+Cj4gQ2hhbmdlLUlk
OiBJZTk4MzA0ZTQ3NTE2NmI1M2VlZDAzMzQ2MmQ3NjQyM2I2YjBmYzI1Ygo+IFNpZ25lZC1vZmYt
Ynk6IGNoYW5nemh1IDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysr
Ky0tICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oIHwgIDMgKystCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jICAgIHwgIDMgKystCj4gICAz
IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMKPiBpbmRleCBmMDRlYjFhNjQyNzEu
LjcwZmZhZjkxY2QxMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmlydC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zp
cnQuYwo+IEBAIC0xMzUsNyArMTM1LDggQEAgdm9pZCBhbWRncHVfdmlydF9raXFfd3JlZyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgcmVnLCB1aW50MzJfdCB2KQo+ICAgCj4g
ICB2b2lkIGFtZGdwdV92aXJ0X2tpcV9yZWdfd3JpdGVfcmVnX3dhaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCj4gICAJCQkJCXVpbnQzMl90IHJlZzAsIHVpbnQzMl90IHJlZzEsCj4gLQkJ
CQkJdWludDMyX3QgcmVmLCB1aW50MzJfdCBtYXNrKQo+ICsJCQkJCXVpbnQzMl90IHJlZiwgdWlu
dDMyX3QgbWFzaywKPiArCQkJCQl1aW50MzJfdCBzZW0pCj4gICB7Cj4gICAJc3RydWN0IGFtZGdw
dV9raXEgKmtpcSA9ICZhZGV2LT5nZngua2lxOwo+ICAgCXN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZyA9ICZraXEtPnJpbmc7IEBAIC0xNDQsOSArMTQ1LDMwIEBAIHZvaWQgYW1kZ3B1X3ZpcnRfa2lx
X3JlZ193cml0ZV9yZWdfd2FpdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAl1aW50
MzJfdCBzZXE7Cj4gICAKPiAgIAlzcGluX2xvY2tfaXJxc2F2ZSgma2lxLT5yaW5nX2xvY2ssIGZs
YWdzKTsKPiAtCWFtZGdwdV9yaW5nX2FsbG9jKHJpbmcsIDMyKTsKPiArCWFtZGdwdV9yaW5nX2Fs
bG9jKHJpbmcsIDYwKTsKPiArCj4gKwkvKgo+ICsJICogSXQgbWF5IGxvc2UgZ3B1dm0gaW52YWxp
ZGF0ZSBhY2tub3dsZGVnZSBzdGF0ZSBhY3Jvc3MgcG93ZXItZ2F0aW5nCj4gKwkgKiBvZmYgY3lj
bGUsIGFkZCBzZW1hcGhvcmUgYWNxdWlyZSBiZWZvcmUgaW52YWxpZGF0aW9uIGFuZCBzZW1hcGhv
cmUKPiArCSAqIHJlbGVhc2UgYWZ0ZXIgaW52YWxpZGF0aW9uIHRvIGF2b2lkIGVudGVyaW5nIHBv
d2VyIGdhdGVkIHN0YXRlCj4gKwkgKiB0byBXQSB0aGUgSXNzdWUKPiArCSAqLwo+ICsKPiArCS8q
IGEgcmVhZCByZXR1cm4gdmFsdWUgb2YgMSBtZWFucyBzZW1hcGhvcmUgYWN1cWlyZSAqLwo+ICsJ
aWYgKHJpbmctPmZ1bmNzLT52bWh1YiA9PSBBTURHUFVfTU1IVUJfMCB8fAo+ICsJICAgIHJpbmct
PmZ1bmNzLT52bWh1YiA9PSBBTURHUFVfTU1IVUJfMSkKPiArCWFtZGdwdV9yaW5nX2VtaXRfcmVn
X3dhaXQocmluZywgc2VtLCAweDEsIDB4MSk7Cj4gKwo+ICAgCWFtZGdwdV9yaW5nX2VtaXRfcmVn
X3dyaXRlX3JlZ193YWl0KHJpbmcsIHJlZzAsIHJlZzEsCj4gICAJCQkJCSAgICByZWYsIG1hc2sp
Owo+ICsJLyoKPiArCSAqIGFkZCBzZW1hcGhvcmUgcmVsZWFzZSBhZnRlciBpbnZhbGlkYXRpb24s
Cj4gKwkgKiB3cml0ZSB3aXRoIDAgbWVhbnMgc2VtYXBob3JlIHJlbGVhc2UKPiArCSAqLwo+ICsJ
aWYgKHJpbmctPmZ1bmNzLT52bWh1YiA9PSBBTURHUFVfTU1IVUJfMCB8fAo+ICsJICAgIHJpbmct
PmZ1bmNzLT52bWh1YiA9PSBBTURHUFVfTU1IVUJfMSkKPiArCWFtZGdwdV9yaW5nX2VtaXRfd3Jl
ZyhyaW5nLCBzZW0sIDApOwo+ICsKPiAgIAlhbWRncHVfZmVuY2VfZW1pdF9wb2xsaW5nKHJpbmcs
ICZzZXEpOwo+ICAgCWFtZGdwdV9yaW5nX2NvbW1pdChyaW5nKTsKPiAgIAlzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZraXEtPnJpbmdfbG9jaywgZmxhZ3MpOyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92aXJ0LmgKPiBpbmRleCBiMGIyYmRjNzUwZGYuLmJkYTZhMmYzN2RjMCAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuaAo+IEBAIC0yOTUsNyAr
Mjk1LDggQEAgdWludDMyX3QgYW1kZ3B1X3ZpcnRfa2lxX3JyZWcoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHVpbnQzMl90IHJlZyk7ICB2b2lkIGFtZGdwdV92aXJ0X2tpcV93cmVnKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCByZWcsIHVpbnQzMl90IHYpOyAgdm9pZCBh
bWRncHVfdmlydF9raXFfcmVnX3dyaXRlX3JlZ193YWl0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAo+ICAgCQkJCQl1aW50MzJfdCByZWcwLCB1aW50MzJfdCBycmVnMSwKPiAtCQkJCQl1aW50
MzJfdCByZWYsIHVpbnQzMl90IG1hc2spOwo+ICsJCQkJCXVpbnQzMl90IHJlZiwgdWludDMyX3Qg
bWFzaywKPiArCQkJCQl1aW50MzJfdCBzZW0pOwo+ICAgaW50IGFtZGdwdV92aXJ0X3JlcXVlc3Rf
ZnVsbF9ncHUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgaW5pdCk7ICBpbnQgYW1k
Z3B1X3ZpcnRfcmVsZWFzZV9mdWxsX2dwdShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9v
bCBpbml0KTsgIGludCBhbWRncHVfdmlydF9yZXNldF9ncHUoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpOyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBpbmRleCBmMjVjZDk3
YmE1ZjIuLjFhZTU5YWY3ODM2YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5
XzAuYwo+IEBAIC00NDgsOSArNDQ4LDEwIEBAIHN0YXRpYyB2b2lkIGdtY192OV8wX2ZsdXNoX2dw
dV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCj4gICAJCQkh
YWRldi0+aW5fZ3B1X3Jlc2V0KSB7Cj4gICAJCXVpbnQzMl90IHJlcSA9IGh1Yi0+dm1faW52X2Vu
ZzBfcmVxICsgZW5nOwo+ICAgCQl1aW50MzJfdCBhY2sgPSBodWItPnZtX2ludl9lbmcwX2FjayAr
IGVuZzsKPiArCQl1aW50MzJfdCBzZW0gPSBodWItPnZtX2ludl9lbmcwX3NlbSArIGVuZzsKPiAg
IAo+ICAgCQlhbWRncHVfdmlydF9raXFfcmVnX3dyaXRlX3JlZ193YWl0KGFkZXYsIHJlcSwgYWNr
LCB0bXAsCj4gLQkJCQkxIDw8IHZtaWQpOwo+ICsJCQkJCQkgICAxIDw8IHZtaWQsIHNlbSk7Cj4g
ICAJCXJldHVybjsKPiAgIAl9Cj4gICAKPiAtLQo+IDIuMTcuMQo+Cj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
