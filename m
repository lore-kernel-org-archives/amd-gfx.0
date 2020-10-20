Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26102C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 09:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F8A206DC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 09:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xNI1wdqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F8A206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E00B76EC24;
	Tue, 20 Oct 2020 09:46:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38716EC24
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 09:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBaSqis0EvBwUo0otIxaDem8JYOqf5O008M+SFLTTEzWSuijmGSDAnLgyE+Vq63px5gMeffcspCAfPEV7deoTibbsPFhNXt+2mxkMXsRbcIUFlNFJMNZHTxrI90gs3O/MVsurojuQZUeW+v0H4azMIFcBb4+rBdrKWGshh4xcE4qERHdmvCFDIdBKCHAicIxyinsbrKUXaXHDzs5i4K+9cJ3m2DEKzEqLSO6V1POE3mMqHqPHIxzgFS6tqsr/6ZvCfY+QsMGfj/BRsuh7XbwPnCqJyLtUhX4+sCvkucDlj63DVfxqc6CAwAEQLh4R6B3Vu50N2tO8ZrWgWtl6JWjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUwzJEv0adv5ZNpJn1Swa5F164Mwqj721ktoVxJl7ZM=;
 b=mIYEl+L1ELu1xkxN7gTVHN9Xm8tQ7Z3FE+fPrcCpUcsKEWgYlzrrW4aAWmbdEb7GTRITnL98+bsXP070ZZX7E6yW7VPWiIXStLQ2EPpWun/qCFRstTxV4vllzphq4cId/tmJRx1ggczjlpASbP3JRU/7zHDrdnrSFhB0ea3OWKKuEqzmuV6DMzZD2ZW4DAdrm0XS8OBlcLOjoOcoaT/K+aE1px5gB3149/Dhg9KbXicP551pcnlIhNsGzU8u0UVRORZlbWLzIGXYdDYSaOTXNyVTXUSxiZkqUrKyNlddSogk6dgwaG0P431fT/0AHGcfmbdFjo7lMvd2FL48LZYMcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUwzJEv0adv5ZNpJn1Swa5F164Mwqj721ktoVxJl7ZM=;
 b=xNI1wdqqLcXFV8uzRB1+uyppnr6k6CbCcBHDme4L0b35U/sOq/Xa/kl9V2a5mC/NKnH5qY5q3BUZ3/M2dkBnfy3Af+Obrbk17NoQ8ztQdJSdptvAxv6s/jb+d2jpQ0wM/WBlT109RBOc580OujDKLWdQVkSWPajkOQ//dvRhql4=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.27; Tue, 20 Oct 2020 09:46:42 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 09:46:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amd/pm: update driver if version for dimgrey_cavefish
Thread-Topic: [PATCH] drm/amd/pm: update driver if version for dimgrey_cavefish
Thread-Index: AQHWpsRHxDFko5Wzp0ejz9cY4jDoDqmgPktz
Date: Tue, 20 Oct 2020 09:46:41 +0000
Message-ID: <85A5AA89-52CA-45D0-A9E1-3B2170C90303@amd.com>
References: <20201020093442.15802-1-tao.zhou1@amd.com>
In-Reply-To: <20201020093442.15802-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [223.104.212.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5e2b6f1-c852-4d0b-35b8-08d874dd0c89
x-ms-traffictypediagnostic: DM5PR1201MB0027:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB00275B02BD3DB22C92DC00F4FC1F0@DM5PR1201MB0027.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ejm+KGoZitskrlRWMPE118nkMvu2tS7vdWRYWK1U4wPCod7ltkpT8zy4ObMxx1IbrYPVS94Mdqy2Xx+3bxICKBFOgGzXa9yTiWqXW26nGviBdg4Q/T3jYNgk3b+y4hOY+raCfglKbdaUMdT29ZAIEWpo6cud65O0jmfpaB369NM3dgxxul6dl7Hypb1PJ9xLiIKs4VEmrv5n3jfMyQCsQFTqO6Pco536zdAQSF9dVw2y0O3NwpmnPu+Z+LD3NyvYBf7KA5egyuSqMPoCu7oq+4A8MxfYP49vgMeYJ+XX+kmRaq63Eq0c7Tpj4UpfJ+DC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(86362001)(66946007)(2616005)(66556008)(91956017)(316002)(64756008)(6636002)(2906002)(36756003)(26005)(37006003)(186003)(76116006)(83380400001)(478600001)(5660300002)(6512007)(4744005)(54906003)(6506007)(66446008)(53546011)(6862004)(33656002)(66476007)(4326008)(8936002)(8676002)(71200400001)(6486002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4A+26b2S/crDo3uVFGUawLOPuxK+WOFqyGLRTsv6h8lZ2s6qU7ntXdBbhbguSLm4s6zGvVnBd7GbzI7aFXTeEnSV3huK88ghgwMseMYOMd6H2dUoHuBlYF8k/vGqlbLqr8xdiIfZuehbITyj0qsQX9GNOWHzRE4D78aa0ZusaGVGxQUkFq7yGBXnYwsTj9Fh/+QGE+9gokSClBi0ZJhzC3qNdsE+JYSOEnDuH+LS/iVQlP8Gc0zt5VQiMfj7DQvUA9J51BOvyRYeiixaQPQR0k4AQgICDCm1WTAJGI/0SnMftdgJzgeiLj0H41AIneDYubJ5dJXXTrzG03IehasvTXXSp3RzC7H6205OX/7bvEugSdtKWXDI/fl428dWi4LZDRqsPZyJV+P8MmOF3moZ3RscazlBeGoIehN3LOzjuxoqnUtKM4DG3yP6N+HsRZCQl2MFuieUjNI8WmH+qHoI4X9SyxsORFT5VW29x9PTS8hi5EolmRnFR99fy7LS59mQWs2yvm69OIW/0HmDmDWY9TMu4LqG6WDqOcznxcqufzv4CiHaQhVhsnB/YoVLJRt52JQp5QDliwzcjKj2Y1Gwab2X3UjgFaDSYwokawdXS/VLh4kubM5vm4KOEpmKdN6ni4nSr83cFDZvLEkuwF8STQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e2b6f1-c852-4d0b-35b8-08d874dd0c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 09:46:41.8862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owjV2MIGwoHSsm+Hwb7FOto8IgMG66Fj3FUWo9o6BfMLOBF0HxJL7880LMs30kUOM4+zAoVanHSNmOcXTBi23w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0027
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
Cc: "Gui, Jack" <Jack.Gui@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVn
YXJkcywNCkhhd2tpbmcNCg0KU2VudCBmcm9tIG15IGlQaG9uZQ0KDQo+IE9uIE9jdCAyMCwgMjAy
MCwgYXQgMTc6MzQsIFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPiB3cm90ZToNCj4gDQo+
IO+7v1BlciBQTUZXIDU5LjkuMC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRhbyBaaG91IDx0YW8u
emhvdTFAYW1kLmNvbT4NCj4gLS0tDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL3NtdV92
MTFfMC5oIHwgMiArLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9zbXVf
djExXzAuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL3NtdV92MTFfMC5oDQo+IGluZGV4
IDJmYmEwNTBiMzE4MC4uNzZjNWI1ZDhlYmJiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL2luYy9zbXVfdjExXzAuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L2luYy9zbXVfdjExXzAuaA0KPiBAQCAtMzMsNyArMzMsNyBAQA0KPiAjZGVmaW5lIFNNVTExX0RS
SVZFUl9JRl9WRVJTSU9OX1NpZW5uYV9DaWNobGlkIDB4MzkNCj4gI2RlZmluZSBTTVUxMV9EUklW
RVJfSUZfVkVSU0lPTl9OYXZ5X0Zsb3VuZGVyIDB4NQ0KPiAjZGVmaW5lIFNNVTExX0RSSVZFUl9J
Rl9WRVJTSU9OX1ZBTkdPR0ggMHgwMQ0KPiAtI2RlZmluZSBTTVUxMV9EUklWRVJfSUZfVkVSU0lP
Tl9EaW1ncmV5X0NhdmVmaXNoIDB4OQ0KPiArI2RlZmluZSBTTVUxMV9EUklWRVJfSUZfVkVSU0lP
Tl9EaW1ncmV5X0NhdmVmaXNoIDB4Qg0KPiANCj4gLyogTVAgQXBlcnR1cmVzICovDQo+ICNkZWZp
bmUgTVAwX1B1YmxpYyAgICAgICAgICAgIDB4MDM4MDAwMDANCj4gLS0gDQo+IDIuMTcuMQ0KPiAN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
