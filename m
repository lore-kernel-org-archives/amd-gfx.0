Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AF7C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 05:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA7D6101C
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 05:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BEA7D6101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B2989B18;
	Tue, 31 Aug 2021 05:55:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE39F89B18
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 05:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVVo/Y2FWmof9MgLcCBavcCNKnhOB+aTxBGlDqB5AWUqAeKZnkxEgCbaqM0iOCvNFPSSoIStKX3g24slbKR9F45PaghsX8hApIkzERFLFYmFs1+QN1Q1dkqS3A20ESrKBhGZdm6nNVZOQhAYlFLOkzE5uuhx1dw4Kkg3wUbne3gDzpmdsTOKBPecsMymhZwqbkl7IPy74a2YAkcqRyMXgwBKjKQv0b9j74NntXBh7rUB0kg1dR7pVVnvFk9yoGtKFVdAmQrbZxhcdFSGOWq2194MgdSsRqXCyecPe4dKYwIo4SNZiJe42QgKWlZhy9UKGW+vz9vWiDB0kHyrYPN1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1g0iDuE5Q98kZy4LLyfLg6ZhEZ6ChLCFrR+6DBEhrw=;
 b=FnxSwukzp3cfnPWx10l8QbWPRt1BxO+wAWKMu9HEni0ZTLI98Jmw6b8NJCo6nh5dL7nNrs2jjGW4O5amOV8TgdERpCA8g575tBf6Hc4dDfKW9nt9MZflukhQKMgK3QPEtcAIrs6Xrq36W4/7/XVfNqlPd0SLCzhxq72DH0n7Aj5fFJnqUlqTt5fK5S/NMAB3BzxIlgvTKwwYqE9tQ0yAgV3zuof7MlPRoqnQOmURxaw0YpwnxGH7uabT2sPnVKgLZlctY0o+RlQufwnVqRVXHHpN5aexiGkF2/EMb1LuuFn4zaiI63gWzL8vQPo8Um11/A2bFanvN3FUi5unPoCFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1g0iDuE5Q98kZy4LLyfLg6ZhEZ6ChLCFrR+6DBEhrw=;
 b=NSvg5Cv6yox4LexbIhPxq+wxl5DbGVQS1g/exkdZxyvtrz7/TS1rnB+33RFy6yBFd+RVR7hCjJP1FYBpsSnX6fgES26b726F+Al1/V1DVVsaa3g+gTVN9y6upQciJ+ZxwK9YKDOtBblLuKZdwiZjo8C3l5STpmTJUxxCAGhRrzk=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.24; Tue, 31 Aug 2021 05:55:43 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 05:55:43 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation fails 
Thread-Topic: [PATCH v2] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation fails 
Thread-Index: AQHXnizWHQenrCxFPEuRBPxTI1ZMrw==
Date: Tue, 31 Aug 2021 05:55:43 +0000
Message-ID: <1DC31191-52FA-4636-8537-E43B9D8802D7@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1f.0.191110
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1cadc06-9fa0-41dd-84f2-08d96c43f89b
x-ms-traffictypediagnostic: DM4PR12MB5389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB53898E65E6708E4DFCB9730C87CC9@DM4PR12MB5389.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rJSyFc64/a6SloPLrbPqmC5mZYsusVSCFgNbozjYGizRO4RsUkati8bKkbXNSFjYeMlBnEjRN29VJxQMQ4BhjEu5VkXC33MoyEzy9rwlFV0OluzoEAaVLrWwE4IXcYomHqMymzAceYKCG2500axrfor3SPJMoNgyDH1RQkQ6n+qcVgHhI4h6fcH84aw/KQ+rnNa1XzCKzP+w9Nm1H/5Vyyp7WEF8QHDq5hdQsEomakM9eP2r4/6K2boWlp12+J82qmQ+RStmr4LwfTw688y4fviRNmrib48ct9rd63lxFbSn4wK2DsyMn1O9CikZDejK1RkzzIbhXwp3hcnuM8C3QI8ZqY4BIDR18AGtPbbeUbbw8+xXnv1aMeT8/VAXaQS3V209i4O66/xFBzAWQreI7vzVp7N/1UrwP0MNi+uct7zMO338Uv+2UjsZ+XYmrGXwosXsHF/y3urSm2fvxe7odIk3uri22arllanmE2jY2qB+mQ2hS9o2ELVEqpT8a7pGu4P08du13r9o0vUEz+nj4j0DX1fuyfwyU0RvCXwPZngfYPQn6rKPtgTaB/oEhW/S6JnhzZb8TKsqKPSQ2PISfcrStJxITFCi5SCFKhwjxskbbyTVn3Lls0pGMT6oWNkFwK0TLb1EY5bWwTOjddrHU58n6U782XoGLzyX/k+WzHe773nYeJyHvSXQRakYb0Ukq43DlVp8zk8ng83mE6XwSSDjgT3H8uVXkTEAi9iPWELvapaB2XZat3HwuQ6PuvAJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(66446008)(26005)(6486002)(478600001)(186003)(54906003)(38100700002)(76116006)(86362001)(36756003)(83380400001)(38070700005)(66556008)(122000001)(66476007)(316002)(4743002)(5660300002)(64756008)(33656002)(2616005)(6506007)(8676002)(4744005)(66946007)(71200400001)(91956017)(6916009)(4326008)(6512007)(2906002)(8936002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmxJK3YzSU02aTBvSitTS2RRTDU3eXhKZTJpRTNuRmpIWEplb0lpNVVUOU1r?=
 =?utf-8?B?UVAvVndnUGJtY1VsL01JWUErOVgxbkZtbVdDM0wzNW4vQlN3cW9EVHFWWDh4?=
 =?utf-8?B?SCtYTDZvUUtZRk5wc0toYjFKTlhrT1NLNDdabmV2RFUrOGJ0Qjd0TzlCZEZs?=
 =?utf-8?B?azNRZUVWMU4ybjdUUmpVcTRTRVB6OUswVWQ1U0QvMFNJNUk0YjRFaUF2d3RI?=
 =?utf-8?B?eTBpRzBldEtzdEFMMTBOOXNvL0V2MlVMZUhOemRQUjJXUGxoT205YkY4Y0c1?=
 =?utf-8?B?TEF3TG54cE9UZGZ2QVMvN3p1d040NVZmdHBFeGxyM3FUQStqNXNPbnJsdDJn?=
 =?utf-8?B?OUxuV05OamhHZmpXakUvaVFIMm9XNVFjRm02bEt0eEE0UjhsSGdKVkN2RFls?=
 =?utf-8?B?L1hpUjVhcWVIZUQxd1JTSFZJNXIwTFcxWXBrYW1qK29GdWJBb01McFp0YWgw?=
 =?utf-8?B?dVQ3L2l0RkxPejJqTXZMUzZYNFlOcTV4UFdualJwc2JvS1JDaTdoTzdxdml0?=
 =?utf-8?B?MzhwRG4xR1hVakRrczZTM3dQMm5VZmE3ZW13V280K3hGWGdlTHkrTFJJUHEx?=
 =?utf-8?B?LzNvYytBYk1VbmJUekRJeWRnSXpaNXdjL0FUWXlVbkV6amhlbGhhUGgxN0tt?=
 =?utf-8?B?cGNaMWZoRDNkZW91cnBMdUtOaHhXeTV3d0dMTFVxdmtHZy9CNHdGem9tbExm?=
 =?utf-8?B?bHJYWHNvby9SQ2lqb041V3BxdWZFS3JBOVNoRnNpOEFiMnF6WVFXWUt0N2NY?=
 =?utf-8?B?VEh5eVk3UjkzUTdTWVBGMXVCVWh3TGc2MVJybGZpZDNuUHFselY4MWxZY3Fk?=
 =?utf-8?B?N3Rzam9veGx6akFFd1RKb0g2UjdsZW41ek52SkM4UnhHdS9RWkJhcTBLT3JI?=
 =?utf-8?B?VmRvOUxFYmFWc2FTem5qSXhUcERyS0VqWkRuaU01ZmhlMmE5V3ZkOFJ2WUlh?=
 =?utf-8?B?Yi9nZ0VMMEtJMzNsK1JmRVhJZlZaQVJudU5wOGk4SnljZDdJQWw2VDNaanFC?=
 =?utf-8?B?YnNVdXphY0FvWnRuamJQRDNqNkd5N3pZWnJWMFZ2c1VBOXNtSEs0WE04d2Zx?=
 =?utf-8?B?amNkVVEyODlSb1FPUjYzVkY5RDhwMFhpbDVpc3ViQ1p0eFVhWXNOYkxGeXpC?=
 =?utf-8?B?U2VPa0kxaXpCUVVXUDYrUzJHUUh4MVZpbDRLOFFWM0hoVjBTOHArNGQrTnBZ?=
 =?utf-8?B?OC9BUndBb0g3OVhIMk5xNTExVEJJUDByaFd3MHUzUzdJcVdvZTBra2U1TFdl?=
 =?utf-8?B?L0FjemE2aWxsaFZuMnEramp1ckl4eFpFbUhJbVZ4Zzl5TnRxcUNCbS9NOStN?=
 =?utf-8?B?MFptVFVJT1FIUWc1UTE1QTV1V0pRNC9qK2hwV0JRT1ZGbXVRVnU3SmoxZUlU?=
 =?utf-8?B?WWtwQTJTeDUxY29yakJwaWxQcXVQWi9qR0twNVVoTHZkT3JGR1hUeWRMSnNB?=
 =?utf-8?B?L1ZHb3hKUmVxTWVqRjRpd3ZITDV4M2RKaDNKeGFaMk9KdVE1RjJrWmIzY0sr?=
 =?utf-8?B?eGpHRDNCc1hQQkpqQnI1S2tSSTlQUHdNblZiNTVxTXNiZFQxMWRnNy9Fb0c4?=
 =?utf-8?B?RWJ5Sk1DTlZDeHFuck81SGVnZmxBaUkyby9STW1udmZwK2NhL3J6Qk1SaUU4?=
 =?utf-8?B?dVFNQm9VOHdseU5iSGRBVTMyeFBoNFhCQ1Zqd2pOTUx0bVRpc0hOK2NnRWpz?=
 =?utf-8?B?d0l1SDAvcUN6Yjh2cUw3SU1OVlZyUFZ4M052cWF2R1FZMUg4YzZySC9CT0tL?=
 =?utf-8?B?MEl4OGdUKzh2UDB6b1AzNFYrWXhoNkdJbjIxdHhpRkRMNTBnVXhwWUJFSEhy?=
 =?utf-8?B?R1lSNDhLcklKRzhqRHhLdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DC785DC9536EC47A4EE97217AC98E15@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cadc06-9fa0-41dd-84f2-08d96c43f89b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 05:55:43.8529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lr/aMVM57uZ+6/JeVpo4PkxIFGYHhXcexrP8Im17AMKajdTm9EZkO2WE9Oh6PPcg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5389
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RmFsbCB0aHJvdWdoIHRvIGhhbmRsZSB0aGUgZXJyb3IgaW5zdGVhZCBvZiByZXR1cm4uDQoNClNp
Z25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDEgLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMN
CmluZGV4IDg1YjI5MmVkNWM0My4uN2RkZDQyOTA1MmVhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2VtLmMNCkBAIC0zNTUsNyArMzU1LDYgQEAgaW50IGFtZGdwdV9nZW1f
Y3JlYXRlX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsDQogCQkJRFJN
X0RFQlVHKCJGYWlsZWQgdG8gYWxsb2NhdGUgR0VNIG9iamVjdCAoJWxsdSwgJWQsICVsbHUsICVk
KVxuIiwNCiAJCQkJICBzaXplLCBpbml0aWFsX2RvbWFpbiwgYXJncy0+aW4uYWxpZ25tZW50LCBy
KTsNCiAJCX0NCi0JCXJldHVybiByOw0KIAl9DQogDQogCWlmIChmbGFncyAmIEFNREdQVV9HRU1f
Q1JFQVRFX1ZNX0FMV0FZU19WQUxJRCkgew0KLS0gDQoyLjI1LjENCg0KDQo=
