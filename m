Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240D7C5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F262321848
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F262321848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882E76EDFA;
	Wed,  6 Nov 2019 17:06:11 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700040.outbound.protection.outlook.com [40.107.70.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11D76EDFA
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 17:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+eZefclsj5ldiqcRfp6r5Dj4WV6zSuZ/VjGZXHc6ioBCoF0ldsBgk9XEffBmLzrTKw9dv5yWQxNdXWqoAP+iKTvnnua3arr/SxtQOTEdc0J/PpXmnZYVOKlvstFE7+F/zk+b208V00TuwPbatc0LR68uWk0Egcnpc8xwf6fp+WcXI+5/Aa0dU5/9Zb3q2UlaGZv03XT9yJ1gWNkPBCCWxHfPJjEz1Wu147J5hO55EPN3bgCO8wVp3P5cJnd9vI1vRdYYgPm55+y95vBq6/QqOT02thcA8vWEeyz8hUesFAb4FgT2zwKRRbMHITN4IfcrDd+qkWwkv3b6BKgDCBg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW5A3Fg4BvBnil/B+XoAP+8Jgh4T22oWdA1R0klCyX0=;
 b=WRCjCbYgAi40QqkU/6J/U1FLuCRKnnhPTy94JhezUWgJnUd5q5i1cik7h/YjefPSx8pHDIManSJdLxeaWtQ4h+XM8pjn9ouGYv0GPxFq43jq3M+T2BfsMFTS/dQCNe38v3NCiXxL9UK/EvifSPe7INGT25koPEgXgvYmrm/GMImsVFWhuG34BV/hVn9W6A16uEkfcpCN7uhdEPvvGqe0N+ALZy8t1ozz5nwQ8YcIc3VCOopnFriSkHatjCGrwfimBV4KgjiRXHoSanpMmjw9AjcLiD28JgJzQnuzUIkWreVnpMBIpS+8ItuK3E0V22YBy1k20uN4UAVXHp2z5uT1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3100.namprd12.prod.outlook.com (20.178.30.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 17:06:08 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 17:06:08 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/radeon: fix si_enable_smc_cac() failed issue
Thread-Topic: [PATCH] drm/radeon: fix si_enable_smc_cac() failed issue
Thread-Index: AQHVjy2HOVdrZnULA0CdDw8TBVl3o6d+apkA
Date: Wed, 6 Nov 2019 17:06:08 +0000
Message-ID: <3ee9a780-36ec-82e6-3349-b20c15562fcb@amd.com>
References: <20191030142241.1575786-1-alexander.deucher@amd.com>
In-Reply-To: <20191030142241.1575786-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::16) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: deb64385-a163-467b-b1a6-08d762db9de2
x-ms-traffictypediagnostic: DM6PR12MB3100:
x-microsoft-antispam-prvs: <DM6PR12MB3100A994AB1D8D4F08348A2CF0790@DM6PR12MB3100.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(386003)(6506007)(486006)(6436002)(71190400001)(476003)(71200400001)(66066001)(2616005)(11346002)(6512007)(14444005)(6486002)(446003)(66476007)(66556008)(64756008)(66446008)(31686004)(2906002)(6246003)(66946007)(316002)(256004)(5640700003)(31696002)(26005)(229853002)(478600001)(86362001)(53546011)(99286004)(186003)(6916009)(25786009)(36756003)(102836004)(14454004)(4744005)(2501003)(8676002)(8936002)(4001150100001)(6116002)(3846002)(76176011)(81156014)(81166006)(305945005)(52116002)(2351001)(7736002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3100;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xp5uT/5YEOd9cWHCXNnZrydrNq2Lbe6IEk29RQWVcZqdVVLu6ABOI2N8i8m+0wfJZlvfX/wgkDpWjWPIuvAuWffY7VuRgGe5IpjNlhEAwk/txMs3RnHTM5mWFywuGi6MWd8ujdRsJSFtmmz1N+AwjDHe1ErLQwvSya75Q4z6pmMidBaj9pBZ2DShVtEhh6AX9/8AR+sxL3HBYb/IxLWXY7YnTSZeH+fvrSVypaUJKEW6cOkfLRFKlHxvfbWekRO4SNIWjYNPVdMk3EWbAx+wQ8RUXTTKzIztE3Wt1STd2w2nOySqjAmVaIG7R7E9uw8CVT43Mc92YHMh4DpCuf05FFSxonchejGjEr31oDPM0GxtWqyfkNPBgGxadTgAXE7SjixatNctuj4k39HWl7NpIQpPfB/vqLGwv3SKqcXHM1SV+7vl5cgPTyryuk0gTDOC
x-ms-exchange-transport-forked: True
Content-ID: <6972E96807A52543B511247EC30C0C01@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb64385-a163-467b-b1a6-08d762db9de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 17:06:08.5182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8Ti51ShbLNtxsl3xCNnujqS8bV8tb8GAAhynzYyPCbaxlOnhm3f+PXTmq42ay1A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3100
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW5A3Fg4BvBnil/B+XoAP+8Jgh4T22oWdA1R0klCyX0=;
 b=SakdwkUXH9rIXcCdpdtg2m1EAwHMQaR+LmrJdYP3kepq7IvZLMyOKyajH3bCBH9JceF6KQDWrom+PlG6yl77mCyKbW7FLW6fL+xpZyCN9D9XAXQrAIzjR2BXY8IdZ/EoKzufoYlJ3bt3Ae40xkE/WMWfk+OoVEVd+TtSSDjx9ao=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Message-ID: <20191106170608.RQpe09T_kTOJtUP-nZZA2Hx8fdKRs8sTPwOZaCyAI4Q@z>

UmV2aWV3ZWQtYnk6IFlvbmcgWmhhbzx5b25nLnpoYW9AYW1kLmNvbT4NCg0KT24gMjAxOS0xMC0z
MCAxMDoyMiBhLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6DQo+IE5lZWQgdG8gc2V0IHRoZSBkdGUg
ZmxhZyBvbiB0aGlzIGFzaWMuDQo+DQo+IFBvcnQgdGhlIGZpeCBmcm9tIGFtZGdwdToNCj4gNWNi
ODE4Yjg2MWJlMTE0MTQ4ZThkYmViNDI1OTY5ODE0ODAxOWRkMQ0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
c2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jDQo+IGluZGV4IDQ2MGZk
OThlNDBhNy4uYTBiMzgyYTYzN2E2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3NpX2RwbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMNCj4g
QEAgLTE5NTgsNiArMTk1OCw3IEBAIHN0YXRpYyB2b2lkIHNpX2luaXRpYWxpemVfcG93ZXJ0dW5l
X2RlZmF1bHRzKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQ0KPiAgIAkJY2FzZSAweDY4MkM6
DQo+ICAgCQkJc2lfcGktPmNhY193ZWlnaHRzID0gY2FjX3dlaWdodHNfY2FwZV92ZXJkZV9wcm87
DQo+ICAgCQkJc2lfcGktPmR0ZV9kYXRhID0gZHRlX2RhdGFfc3VuX3h0Ow0KPiArCQkJdXBkYXRl
X2R0ZV9mcm9tX3BsMiA9IHRydWU7DQo+ICAgCQkJYnJlYWs7DQo+ICAgCQljYXNlIDB4NjgyNToN
Cj4gICAJCWNhc2UgMHg2ODI3Og0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
