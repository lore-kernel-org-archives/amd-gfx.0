Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEE0C433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 12:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7695722453
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 12:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ChQGSlxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7695722453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027916E30D;
	Tue, 13 Oct 2020 12:37:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FEA56E30D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 12:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFQjlzzgL0pP3TgiC5yuadTDBn30YowKplCLQ5/oqIeoa7GqESDs8KTCkVJ24NgId/P+NnNYGvH5j3ywsTfWn92dyz0UemEg+WjT2CARGA3UAMUQi83DPYRxk1EnZN5JqL0ubSGKnBWYc0xGTjV51ebXLSDv/aVZuqBAUrY7zk1YdNFpsSA84ymGxgtk2StYQaU/rcE0zM7i3lLzekNAdSfJKoc/Xkt+b8Rv22p6LviLxaw3gUZbBiAvLcMQpoKjbWL7WgUxgKtqksOlIIhgj9KW2pTlB5VUDmD+v7vZ7h67Zf8ax7urSSYxIgCjlz+EK85cqbHmQcvEfivK/WUhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSY+0Xv3ozAdiJMEL7DZ8xs20akiFcLSX0MDP9omLLI=;
 b=RleHng4xt2csnEHrVO7/lDLrDeRMoGVkxF1bWMcep2Dlu8W6iBczHbLbKmZ3guhKL64NCYVOwD/FNE00jyfq6c/TJO6GQ9aWmGCjLMHivPx9pXJ5NXuN23VkabOb3NG3VR5ym3dKyuhjIAJZ8gmW14zAEDf1RlHcL/HcC7od7TrRLHtWCfOuhg2bVfE5xgV+4IzdQzNO+YdFk4rTY8Mx8c+cqy7LbTnRHoTkjGGKwRlCQmldVYSspMl4vMrXJbKI5Pf3nfUApACAOSDss5Ze+uRa316qGMWJ9Pd+3yta9pnVCR+hp03yfb+sLX5ETfIYJRcUU5/7Mzsxd2AJgadBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSY+0Xv3ozAdiJMEL7DZ8xs20akiFcLSX0MDP9omLLI=;
 b=ChQGSlxFpNxMcw7cS52dPUt3eqoomMEKc+3GxiwYIDnL7yIQ6IUfdi1l/wYrgDkeIdksA9OCTZ3tKcdW7xMbR8b7/m4TAnSbxu6g8P86t0qIUQ75PK2V0ucQ2GARWls/x2SUj479avpOQic0M58woDcjeRy7OkPFq5dOGd1OSgI=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3038.namprd12.prod.outlook.com (2603:10b6:208:cb::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Tue, 13 Oct
 2020 12:37:47 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 12:37:47 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/swsmu: init the baco mutex in early_init
Thread-Topic: [PATCH] drm/amdgpu/swsmu: init the baco mutex in early_init
Thread-Index: AQHWoVqCzycwhI9FiUm5UQS53UqAjamVeJYA
Date: Tue, 13 Oct 2020 12:37:47 +0000
Message-ID: <045FC7CD-D1F6-4C22-8F36-333D33AC20FB@amd.com>
References: <20201013121456.574846-1-alexander.deucher@amd.com>
In-Reply-To: <20201013121456.574846-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.140.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d3ac81a-1896-4c90-cd9a-08d86f74ca3b
x-ms-traffictypediagnostic: MN2PR12MB3038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB30382F4D39F8EA4540ECAE7EA2040@MN2PR12MB3038.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:366;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hwzQuv5AoMnKntOxpBkWNqcVKN7kChcxWJM+B0+swGVRToiclUg5/91FP4vR1lySr8SRHNSA69uZw4e9fesUJMQnpeEX+vK448SUcayCtldKKHAzeC8jnErgpU77NMOBRtGljCoFwAqcpKvvhH10fnUby6fu3164qGdnkuFxPoYENIdFW8GuZTR3rsAgCZPQ6Y18HOELfBTfMRzVWhthZIcxghd0yP+c0meCfI+6YM0fHiCXCSOpHdiLQFfWK91POYR9VnGZrOoJn6EXntw+fo8q6274WywN5GtqP76yAANcfyanCWM6Uysafyi9rbCdivCunoBpUqpYD6KYzB9n3Kij8BODWuyastlXMFxpckej0YMTMThe4aaXaahxHpGJx7y7jLv5fqrC/l7yziiE68s5COFuxx4EZDHloKqinsI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(26005)(316002)(186003)(5660300002)(2906002)(478600001)(36756003)(4326008)(54906003)(33656002)(71200400001)(86362001)(6506007)(91956017)(76116006)(966005)(66946007)(66476007)(8936002)(64756008)(66556008)(66446008)(6486002)(6512007)(8676002)(6916009)(2616005)(83380400001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: fTBfB7Sy5Z/HDUnE26IHBvdje3Gg9INInQcyXb7KEliD4SPRp4m+bNq9J8t/Oftmg9dDo+lXsL5GSfnN0Qt4fKukRELRKwamRxHAkTHIXTIBXYc+U/sI6mgxD/0v6/PXQ2+dJK0cZ1OB1EgNOjOpFZRpuj0TGVIlJQpBfuOdO1WTK/foQaWZ4DQkx40dmZXGjJXvtPjVacYjHFXViKpJNtuXaGVYiSH+xALhZSqJenEQXKNcmMi3cX4EJtyd1DFafJS6cTJkAqcoOhFlhCwqnfjMhUe7b6V/ZLinGb1RgYAkp537yWSxvTbUzjIgTkJnt/Q8UhgWF1GWRQ3FGGvbRVP5LJ92KSloQN0/nunbT0jowymabAD0gL2QEUZAJZHGZ0dJzQv5TeqyumOHN14wyfZT9pB/g5uRuZxmIEZDsaOslGOmlVaJqzB1NqxuuNJyjW1pwUo1SyjnpSFJBk81FP1HkaTDbCvX7dKoEKNlSCPtJIOgxAHaHZrbcGjbrO9GsvrmKr66HE4Gp2BoqmiE1Qpmjl/sWiFILEcx1qb0I6/N1CIHmnTdcK8/mBh+Yl8Tl5Lcz1qeXm81MEj30zIz3h4Qn2xr8Az2DYHVS5Zy37P5BS92a7KMDO85C1DfTE1gbpPDkbDFCiQMTLWz0kOnOQ==
Content-ID: <082889F6134186448830E9447D78A2A9@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3ac81a-1896-4c90-cd9a-08d86f74ca3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 12:37:47.1722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBdB7MAA36wJiT+zY+2UGGywGnmC8kAXOmtp9DaY1316hK+Xl/X5QcAuPuqbp1oY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3038
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEtldmluIFdhbmcgPGtldmluMS53YW5nQGFtZC5jb20+DQoNCj4g5ZyoIDIw
MjDlubQxMOaciDEz5pel77yMMjA6MTXvvIxBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWls
LmNvbT4g5YaZ6YGT77yaDQo+IA0KPiDvu79HUFUgcmVzZXQgbWlnaHQgZ2V0IGNhbGxlZCBkdXJp
bmcgaW5pdCB0aW1lLCBiZWZvcmUNCj4gc3dfaW5pdCBoYXMgYmVlbiBjYWxsZWQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+
IC0tLQ0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYyB8IDcgKysr
LS0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3Nt
dS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gaW5kZXgg
Zjc4NzQ5YmM4NzYwLi43ZTFiMzAzYjVhM2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+IEBAIC00MjIsNiArNDIyLDkgQEAgc3RhdGljIGludCBz
bXVfZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpDQo+ICAgIHNtdS0+cG1fZW5hYmxlZCA9ICEhYW1k
Z3B1X2RwbTsNCj4gICAgc211LT5pc19hcHUgPSBmYWxzZTsNCj4gICAgbXV0ZXhfaW5pdCgmc211
LT5tdXRleCk7DQo+ICsgICAgbXV0ZXhfaW5pdCgmc211LT5zbXVfYmFjby5tdXRleCk7DQo+ICsg
ICAgc211LT5zbXVfYmFjby5zdGF0ZSA9IFNNVV9CQUNPX1NUQVRFX0VYSVQ7DQo+ICsgICAgc211
LT5zbXVfYmFjby5wbGF0Zm9ybV9zdXBwb3J0ID0gZmFsc2U7DQo+IA0KPiAgICByZXR1cm4gc211
X3NldF9mdW5jcyhhZGV2KTsNCj4gfQ0KPiBAQCAtODAzLDEwICs4MDYsNiBAQCBzdGF0aWMgaW50
IHNtdV9zd19pbml0KHZvaWQgKmhhbmRsZSkNCj4gICAgYml0bWFwX3plcm8oc211LT5zbXVfZmVh
dHVyZS5lbmFibGVkLCBTTVVfRkVBVFVSRV9NQVgpOw0KPiAgICBiaXRtYXBfemVybyhzbXUtPnNt
dV9mZWF0dXJlLmFsbG93ZWQsIFNNVV9GRUFUVVJFX01BWCk7DQo+IA0KPiAtICAgIG11dGV4X2lu
aXQoJnNtdS0+c211X2JhY28ubXV0ZXgpOw0KPiAtICAgIHNtdS0+c211X2JhY28uc3RhdGUgPSBT
TVVfQkFDT19TVEFURV9FWElUOw0KPiAtICAgIHNtdS0+c211X2JhY28ucGxhdGZvcm1fc3VwcG9y
dCA9IGZhbHNlOw0KPiAtDQo+ICAgIG11dGV4X2luaXQoJnNtdS0+c2Vuc29yX2xvY2spOw0KPiAg
ICBtdXRleF9pbml0KCZzbXUtPm1ldHJpY3NfbG9jayk7DQo+ICAgIG11dGV4X2luaXQoJnNtdS0+
bWVzc2FnZV9sb2NrKTsNCj4gLS0gDQo+IDIuMjUuNA0KPiANCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4g
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
