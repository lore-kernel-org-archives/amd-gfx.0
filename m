Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE77C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 17:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEF220732
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 17:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pDb6YgIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEF220732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7D76E86A;
	Mon, 22 Jun 2020 17:41:20 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 693166E86A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 17:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHtR1/23VNAjW6YXx4Eg8fedZeFlsxExRBGn9amRq0DE8HYAlCH5t2NuICCe0X4IUhEdlnGMUznoziJsRZC+EZjE1P6pi4HIBtoD16PK/sVYtQOS33VQ0SkYw6HzZbiRo+G78eEWypC89ZbUa0Il0r5Cfqe0qErCsrAnSbxhxShxGoOORd1ICxtEctaNFX+c8xMkUcElaHCnJ3FxlUvZDlpsTNDo0cli97WVCZXA0rxSJykjuNczqByIFM4HN9WpZwXjefn7RBYZUPPzkNbNYE3sx9qv9uGGrdDpenfE0RbtJUgBpPgWGPKGgejxp7M4Ati9cm/U/DB0i7gHdM4fDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9U0C649kROWgdRwa64IEfTeKXg3hfgDxfqh8iEWAmc=;
 b=XMLh53xV1txSsYOV96peDhYMFKEFlQSoU4iqngaN+XGAX+/wSf/8auVhdPI2YvX6zYEBsRSjw/mBPgun0SA0f0pQ1y5xMklUR3cK/Og+4557a7DMIls3eI2RQXyxb29Z0ZXrNvT4fhbX9sY+Ca7pohAY9Tk7ywLX1VjV+rKLtRpIOoQJBM+vY6dLfgac0YhLP59Vpij2tiNGAoHT6IlZ1eXDrfJuy1q5h7nvC6Ubb8nCUJo4Xk3AoLTCtkdaD3B3dyf36Wlp9RCK5WeEDaVy6GwcH2MJRCYxuwr5j+hYBDaKf0ZHfkIdZ8mVPpcyL/u379sRYnniGnv9BA5fESfYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9U0C649kROWgdRwa64IEfTeKXg3hfgDxfqh8iEWAmc=;
 b=pDb6YgItadmogJxN/kHtIKH2u0tEMIHgP5QaKaC3rW3Kl2+X27fvsODq5YuYyxxh/meC7Ss4m2n6p58iip8dAGy3pq+Ad2U9I7cxpnliJ/2Nh2acJTma2OAnMrMQ/mChQs7VprEnkQAfLKnO0bhGLxMWhY+GO+FKHESuzwARclg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3530.namprd12.prod.outlook.com (2603:10b6:5:18a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Mon, 22 Jun
 2020 17:41:17 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1%9]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 17:41:17 +0000
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Warn about disabled DPM
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20200619185009.12966-1-pmenzel@molgen.mpg.de>
 <20200619185009.12966-3-pmenzel@molgen.mpg.de>
 <fdcc2c10-26cd-3183-42c6-daf36d5df1e9@amd.com>
 <5916b5fa-cc2d-f8df-ca55-505034f09f58@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e4c8cbb6-1a36-bade-eec4-85a52b7a0275@amd.com>
Date: Mon, 22 Jun 2020 19:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <5916b5fa-cc2d-f8df-ca55-505034f09f58@molgen.mpg.de>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0093.eurprd07.prod.outlook.com
 (2603:10a6:207:6::27) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0093.eurprd07.prod.outlook.com (2603:10a6:207:6::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.13 via Frontend Transport; Mon, 22 Jun 2020 17:41:16 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ec28cbf-d478-4e11-268e-08d816d3777d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB353012AB8643600DDF7EB90883970@DM6PR12MB3530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZGAG3D9iJL8uD6QJoQd7fArK/WkeIXqmTn4igSLzuxk4bJJme42k/O14xyWO0VWLAts5xeYGxzxqurffLZbRX7XiCevZM+zt1qn0HlddcitHkrVPYkFe0CNFz8ZD4klBpaTgG/J5PYrKb08FMEjyzrFFmA1AaVBbcgEyDNbiLWTThjxLucPgE1NA1wuNLYW10RJZMIkG5cNN2+DauUmkzZI7kNDHCHRHjlA0uGW3MHIweQwEWTcMG4si3BgZ8D8z3OPuNOpkunhEGj7PuS+Grt0lJMQoPtKNkZ5SUyzjIAVqJIDaQ0s4kIO6Ug9iuecg8ZTD0eQf94yDyYDrgf2reD83q25nJsHeXweIWPPoTEZcBFlurKqaTutYMG5PeI9RCHZZBLin31WqVCG53SFOobaqEa23nslGSV3xV9gkxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(31696002)(8676002)(86362001)(2906002)(16526019)(186003)(36756003)(8936002)(31686004)(316002)(110136005)(6636002)(66574015)(52116002)(83380400001)(478600001)(2616005)(4326008)(66556008)(66946007)(966005)(45080400002)(6666004)(5660300002)(6486002)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /J50EJajj2mnWRDBdnKfY/HLDSRQqwLSVv8RKYk7cHym0BVqruuI+kyu5lnpkqAmfrO+FxG76cEfy+11zcv154W7FpvvUwoXklSqgS49L4Ya7vdGnfsXaDvsRWoCca9hOQxiUyTUtCMuGwDr8tcEJ2XEBtzg+9nG3Uf2ZgGtUNu0q3vFn1X0BN3wvMvJwLs06tJnKu+LgP748S55BRxZu98gUM08wpr9pTGimssUedN8Bn5vz3RK72B53qAZsVRv4LawdQBtMT+Qq4UqzVPWfPkJgqaDjlg7Mw4bnx4hBb2248eOySb8UKOVTrpCl1pTjQWKHkxDRuX4Uc7b4j6hqOeZ0XknH9zl+Jdy0TJ6v857Ev9Wa0druUz3ZInCGbrlF0eVZ60vwW+9XlWKkte8nEEfIhIL1QwlQg6QGU7BhZZauBEwpBnLFjUiSTCBfcvIAlkr5mW8Ri5xHhoYZPGio/QGkS+kdhCCZ+xwKDi7er5jC7Nnep6euCu/3gBaYddrhskmutynyGvJG9fqliWXyBfV2S7yTWuve6jGvLtvjC/fUUDnjeetmjXVjPJXVFiS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec28cbf-d478-4e11-268e-08d816d3777d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 17:41:17.3268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW5qIBoGXcoOwuCLggaUpmZmcPexojSqRTkOTQ0t4AjFiH5DDRK9Auvt+wU0cyp5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3530
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDYuMjAgdW0gMTk6MjUgc2NocmllYiBQYXVsIE1lbnplbDoKPiBEZWFyIENocmlzdGlh
biwKPgo+Cj4gQW0gMjIuMDYuMjAgdW0gMTU6Mzkgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+
PiBBbSAxOS4wNi4yMCB1bSAyMDo1MCBzY2hyaWViIFBhdWwgTWVuemVsOgo+Pj4gQ3VycmVudGx5
LCBiZXNpZGVzIHRoZXJlIGlzIG5vIGV4cGxpY2l0IG1lc3NhZ2UsIHRoYXQgRFBNIGlzIGRpc2Fi
bGVkLgo+Pj4gVGhlIHVzZXIgd291bGQgbmVlZCB0byBrbm93LCB0aGF0IHRoZSBtaXNzaW5nIHN1
Y2Nlc3MgbGluZSBpbmRpY2F0ZXMKPj4+IHRoYXQuCj4+Pgo+Pj4gwqDCoMKgwqAgW2RybV0gYW1k
Z3B1OiBkcG0gaW5pdGlhbGl6ZWQKPj4+Cj4+PiBTbywgYWRkIGFuIGV4cGxpY2l0IG1lc3NhZ2Us
IGFuZCBtYWtlIGl0IGxvZyBsZXZlbCB3YXJuaW5nLCBhcyAKPj4+IGRpc2FibGluZwo+Pj4gZHBt
IGlzIG5vdCB0aGUgZGVmYXVsdCwgYW5kIGRldmljZSBwZXJmb3JtYW5jZSB3aWxsIG1vc3QgbGlr
ZWx5IHN1ZmZlci4KPj4+Cj4+PiBSZXNvbHZlczogCj4+PiBodHRwczovL25hbTExLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXRsYWIuZnJlZWRl
c2t0b3Aub3JnJTJGZHJtJTJGYW1kJTJGLSUyRmlzc3VlcyUyRjExNzMmYW1wO2RhdGE9MDIlN0Mw
MSU3Q2NocmlzdGlhbi5rb2VuaWclNDBhbWQuY29tJTdDNzJkMGI3MWQ0MzllNDZkNjI1M2YwOGQ4
MTZkMTUwYzYlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3
Mjg0NDM1NTU4Mzk2NDkyJmFtcDtzZGF0YT01RVhZMW8xendYSlJ6TjlmcXBVZyUyQlFOSkdCM3pB
bFdLbkdXc2RGWFJjakElM0QmYW1wO3Jlc2VydmVkPTAgCj4+Cj4KPiBUaGF0IFVSTCBpcyBub3Qg
bWluZS4gOy0pCj4KPj4+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4gU2ln
bmVkLW9mZi1ieTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4KPj4+IC0tLQo+
Pj4gdjI6IFVzZSBuZXcgcHJpbnQgaGVscGVycywgYW5kIGluZm9ybSB1c2VyIGFib3V0IGVmZmVj
dHMuCj4+Pgo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUva3ZfZHBtLmMgfCA0ICsr
Ky0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jIHwgNCArKystCj4+
PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUva3ZfZHBtLmMgCj4+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2t2X2RwbS5jCj4+PiBpbmRleCBmMDU0ZGVk
OTAyZjIuLmM2MDE1ODdjNmQ1OSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2t2X2RwbS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9rdl9k
cG0uYwo+Pj4gQEAgLTMwMTQsOCArMzAxNCwxMCBAQCBzdGF0aWMgaW50IGt2X2RwbV9zd19pbml0
KHZvaWQgKmhhbmRsZSkKPj4+IMKgwqDCoMKgwqAgYWRldi0+cG0uY3VycmVudF9tY2xrID0gYWRl
di0+Y2xvY2suZGVmYXVsdF9tY2xrOwo+Pj4gwqDCoMKgwqDCoCBhZGV2LT5wbS5pbnRfdGhlcm1h
bF90eXBlID0gVEhFUk1BTF9UWVBFX05PTkU7Cj4+PiAtwqDCoMKgIGlmIChhbWRncHVfZHBtID09
IDApCj4+PiArwqDCoMKgIGlmIChhbWRncHVfZHBtID09IDApIHsKPj4+ICvCoMKgwqDCoMKgwqDC
oCBkcm1fd2FybihhZGV2LCAiYW1kZ3B1OiBkcG0gZGlzYWJsZWQgcGVyIHBhcmFtZXRlci4gWW91
ciAKPj4+IGdyYXBoaWNzIGRldmljZSB3aWxsIHJ1biB3aXRoIGxvd2VyIGNsb2NrcyBpbXBhY3Rp
bmcgZ3JhcGhpY3MgCj4+PiBwZXJmb3JtYW5jZS5cbiIpOwo+Pgo+PiBJJ20gbm90IHZlcnkga2Vl
biBhYm91dCB0aGlzLiBXaGVuIGFuIHVzZXIgc3BlY2lmaWVzIHRoYXQgRFBNIAo+PiBzaG91bGRu
J3QgYmUgdXNlZCB0aGUgZHJpdmVyIGRvZXNuJ3QgbmVlZCB0byBpbmZvcm0gdGhlIHVzZXIgYWJv
dXQgCj4+IHRoaXMgb25jZSBtb3JlLgo+Pgo+PiBJbiBvdGhlciB3b3JkcyBzaG9vdGluZyBpbiB5
b3VyIG93biBmb290IGlzIHN1cHBvc2VkIHRvIGh1cnQuCj4KPiBNYXliZS4gVGhlIG90aGVyIHBv
aW50IG9mIHZpZXcgaXMsIGhvdyBkb2VzIGhhdmluZyB0aGUgY2xhcml0eSBpbiB0aGUgCj4gbG9n
cyBodXJ0PwoKV2VsbCwgeW91IGFyZSBzcGFtbWluZyB0aGUgbG9ncyB3aXRoIGEgd2FybmluZyBh
Ym91dCBhbiBpbnRlbnRpb25hbCAKYmVoYXZpb3IuCgo+IEZvciBleGFtcGxlLCBpZiB0aGUgdXNl
ciBhZGRlZCB0aGUgcGFyYW1ldGVyIGludGVudGlvbmFsbHksIG1heWJlIHRoZXkgCj4gbWFkZSBh
IHR5cG8sIGFuZCBpdOKAmXMgYWN0dWFsbHkgbm90IGFwcGxpZWQuIE9yIHRoZXJlIGlzIGEgYnVn
IGluIHRoZSAKPiBwYXJhbWV0ZXIgaGFuZGxpbmcuIEhhdmluZyBleHBsaWNpdCBsb2cgbWVzc2Fn
ZXMgaXMgZ29vZCBpbiBteSBvcGluaW9uLgo+Cj4gU2Vjb25kbHksIHRoZSBwYXJhbWV0ZXIgY291
bGQgaGF2ZSBiZWVuIGxlZnQgdGhlcmUgdW5pbnRlbnRpb25hbGx5LiAKPiBIYXZpbmcgdGhlIG1l
c3NhZ2UgaW4gdGhlIGxvZ3MsIG1ha2VzIHRoZSB1c2VyIGF3YXJlIG9mIHRoYS4KCkFuZCBleGFj
dGx5IGZvciB0aGlzIHJlYXNvbiB0aGUga2VybmVsIGNvbW1hbmQgbGluZSBpcyBwcmludGVkIGFz
IHRoZSAKc2Vjb25kIGxpbmUgb2YgdGhlIGxvZ3MuCgpEdXBsaWNhdGluZyB0aGlzIGluIGVhY2gg
ZHJpdmVyIGlzIG5vdCBvbmx5IG92ZXJraWxsLCBidXQgYWxzbyB2ZXJ5IAplcnJvciBwcm9uZS4K
ClNvcnJ5LCBidXQgdGhpcyBpcyBhYnNvbHV0ZWx5IGRvbid0IHRoaW5rIHRoYXQgdGhpcyBpcyBh
IGdvb2QgaWRlYS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPgo+IEtpbmQgcmVnYXJkcywKPgo+
IFBhdWwKPgo+Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+PiArwqDCoMKgIH0K
Pj4+IMKgwqDCoMKgwqAgSU5JVF9XT1JLKCZhZGV2LT5wbS5kcG0udGhlcm1hbC53b3JrLCAKPj4+
IGFtZGdwdV9kcG1fdGhlcm1hbF93b3JrX2hhbmRsZXIpOwo+Pj4gwqDCoMKgwqDCoCBtdXRleF9s
b2NrKCZhZGV2LT5wbS5tdXRleCk7Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc2lfZHBtLmMgCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2Rw
bS5jCj4+PiBpbmRleCBmN2VkYzFkNTBkZjQuLjFmMzVkNWEzNjMwMCAxMDA2NDQKPj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jCj4+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwo+Pj4gQEAgLTc2ODcsOCArNzY4NywxMCBAQCBzdGF0
aWMgaW50IHNpX2RwbV9zd19pbml0KHZvaWQgKmhhbmRsZSkKPj4+IMKgwqDCoMKgwqAgYWRldi0+
cG0uY3VycmVudF9tY2xrID0gYWRldi0+Y2xvY2suZGVmYXVsdF9tY2xrOwo+Pj4gwqDCoMKgwqDC
oCBhZGV2LT5wbS5pbnRfdGhlcm1hbF90eXBlID0gVEhFUk1BTF9UWVBFX05PTkU7Cj4+PiAtwqDC
oMKgIGlmIChhbWRncHVfZHBtID09IDApCj4+PiArwqDCoMKgIGlmIChhbWRncHVfZHBtID09IDAp
IHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBkcm1fd2FybihhZGV2LCAiYW1kZ3B1OiBkcG0gZGlzYWJs
ZWQgcGVyIHBhcmFtZXRlci4gWW91ciAKPj4+IGdyYXBoaWNzIGRldmljZSB3aWxsIHJ1biB3aXRo
IGxvd2VyIGNsb2NrcyBpbXBhY3RpbmcgZ3JhcGhpY3MgCj4+PiBwZXJmb3JtYW5jZS5cbiIpOwo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4gK8KgwqDCoCB9Cj4+PiDCoMKgwqDC
oMKgIHJldCA9IHNpX2RwbV9pbml0X21pY3JvY29kZShhZGV2KTsKPj4+IMKgwqDCoMKgwqAgaWYg
KHJldCkKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
