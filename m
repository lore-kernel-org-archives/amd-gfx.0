Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5786C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jul 2022 09:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30D4A11BBD4;
	Fri, 15 Jul 2022 09:12:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F8411BBCE
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 09:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYfXjvT2ve8K2D4i9N29kuBel2CuV0yFwCCgwt3UknbW8WkYRtaPuMBFeDkVDHHy8iQ/GvakJO3sAQhwHjouhUBBIRs2pkzEkcfM6KCySSbyQq8pflovFI2J2arELqn5rySdRDOC8l/Ht1wE/dk0+REXqx3UwIK6sHzJ14nUFo35YuYGpPGZyikiZDQP5M4Nm3Oi6jn0tDaInPPU4Qpj6/N93mTx5xvK9hSmrflDGRFraEh1PiZClp+dwaUSq1rAhOUtxoZvgHPFh7tL3qRyuUCxolvRs/aWX41KoTtTmcKTvI81rocv2BRbpxbjX0aNuMjwE/+VCC+t/8C8fuZWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt4+vZqPkbKASuwZZQilwclneVltKIu5SFGOU8O/cfg=;
 b=GOaHMVmEZYKBbSjwOab0oP6RqkLYvuKXSwXtc2MWVEVFVufBz3zYl4ZW3jVd5EunwGD9/pn9qCWAdZJv5paMSDJdDL1Vg6Fj3pqFwnvBzRJGW7duvsRu9dA+kG0QClm6mo0niwwu4XaWLDWbQidVsZKcZH3oZt3TGgUrHioXgivISpMNM1i86ote5c1Br7KonslKpI83kkWfNZUxoESa9Ct7qhI6w8QMfWLqjtdO084wxdar+wjlEazL6xChratKaqwVZy6N1/geO0t0Z31NLxq5shz/ZLlsgP31BH2HfeImmTnpdQeOLzpdOUNaUredZgufu4NEc/liYdoENCJvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt4+vZqPkbKASuwZZQilwclneVltKIu5SFGOU8O/cfg=;
 b=x/l8GizsdnHbO9bMjJgkemHRm44/jvrFXFtt5WYkNjDpSWR1n8iIrVCIdIe4ZI51X/ETDMHytQiuyPPnae7nR3E8SPCU/1VZuQ+Jn2kidNDDMeW7dwa25zR4IQS4YdUmg1N70u+F/LgQVp2YS0gSSrj2N1wPoTRx5TZloR1TTZY=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 CH2PR12MB3669.namprd12.prod.outlook.com (2603:10b6:610:27::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Fri, 15 Jul 2022 09:12:43 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::c057:b59f:7b09:8c5f]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::c057:b59f:7b09:8c5f%5]) with mapi id 15.20.5417.026; Fri, 15 Jul 2022
 09:12:43 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Grodzovsky, 
 Andrey" <Andrey.Grodzovsky@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: skip put fence if signal fails
Thread-Topic: [PATCH 3/3] drm/amdgpu: skip put fence if signal fails
Thread-Index: AQHYmCcnHjbzdqK0x0edZhRsQVxzkK1/HvEAgAABp/A=
Date: Fri, 15 Jul 2022 09:12:43 +0000
Message-ID: <DS7PR12MB633367D703FBDC999E8B7E79F48B9@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20220715084356.427458-1-Jiadong.Zhu@amd.com>
 <20220715084356.427458-3-Jiadong.Zhu@amd.com>
 <7ca91143-9da1-4fc4-0cde-268705764e42@gmail.com>
In-Reply-To: <7ca91143-9da1-4fc4-0cde-268705764e42@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5ee88fed-cf13-486d-8d2d-916b4e297bf3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-15T08:54:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6417ef6c-e9ee-4a18-b21c-08da66422cf4
x-ms-traffictypediagnostic: CH2PR12MB3669:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRJrsxtAgkU4DnpnYp0x0GHHcDvathzzGdbkDK05Owa6meGxtBiqZ5s8NYuuKChMBJsCbpoJdYbpOrrafM1Pugh+/sHCJ8aTR2UG1K7MsDM4SomD87rZq1VswIZoDPiODU/fUs92uARFVfOgljDyjVeZYaI8NpMKXj/K3BBpYPv+ypX/6DRax5/RJhpMcg60OKYbQKaQwzVOvTXdVPsh2oFMHMHc8CG2SJLorwv8CrWdAGcVQGintpJK+zQ8Ka1fuCX+nPJ7uSUnF4PSMmojWbWFTM026XGYez3tjSf7tsqgPOS9xF1oOwjpuB/vRukXrRkTKM7spCLJ+bwOImHuImRv7/U79W4sCJ5DkMCtm/KqCIEofrCRibdkc2Rur2N+YTNhtSrpsyGnUs77Jb8s1XMdSufKg/pVrByEylDu8FdJuucaq40OsTYIfipJU1w6+HE+C2az6ZZBPy5737P9FE+jMmlZ99XpNrVyTlws+lencWKG2GRgL4SL8OKzxQV1GjbO4KA+CH9yH2BmxSBWtNKCkwGCM1UuNDnHnGe1J21FJzgCTVD8JiuayXV5nXHZhb1AMpwLecneyUSz1ZcABjBdWsHO4sXUJZ8PG4Y/Q54C3cZiVGU7dP0ia2nLQkzpXScj0DKuVawgr3fGdN+EK2ROLZfC0RYX95Pkd5qJ3mPYAuC7vuo1CPdFi27yttNk477NqSXPOMAum5gmtFAHmwBg3h1pvsTvPKCzk6KJOiNME7S8IXmrkz6lG518GW0iMG3kbFs3eQZozevvZ9lBVTst4KMximYkAei2Wu7kP28+9b2YqjdR61KoNU3FCDmj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(71200400001)(478600001)(64756008)(38070700005)(38100700002)(53546011)(41300700001)(6506007)(7696005)(66574015)(9686003)(110136005)(76116006)(6636002)(33656002)(186003)(54906003)(66946007)(26005)(66476007)(66556008)(316002)(2906002)(4326008)(55016003)(5660300002)(52536014)(8676002)(8936002)(86362001)(83380400001)(66446008)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2N4UitnTjQxNUo4VkhWNnZQckQrM2YzNFd2b0FUUUtWRERqNXZOQVhUU2h3?=
 =?utf-8?B?NHRMd1AzSEEwTnFJMmxGRVJBMmVHaDVhUlp4Q044N3NSSWxwK3pEOCthVk1Y?=
 =?utf-8?B?YTR6MElSNmx4QmI2Z0pOVkp6ZDh4dlRKNkNjdy9tUFpTWGZheXJ5VXErT1Ro?=
 =?utf-8?B?cGJ5dTJJTEZZc24wNnZLaU5RVVRsaTRRT3ErejVKQ05qYjdpc3pFdHJMVFlK?=
 =?utf-8?B?dUplQzhHQVBrUXp3WGhQZjBmWkVVYUQ2Q2xuRnFHVTBrVzgyN3ZTdmhRaUxV?=
 =?utf-8?B?S1BsVGhLK1c0Wk96UHFBV3dvS2pmU1o5NVJ5OXcyM3FDeDBHazVNcjhjWlVt?=
 =?utf-8?B?RTMxNzNKVFROLzVQa3grdmV5NlcxdkNxa3FuWDhHa1RZeTNJcHlOMk5WZVpt?=
 =?utf-8?B?dUJuTi84ejJleFFKeEtseUpadXhqUFVIQlRKNDZTVlM0Wk5BMERNdVRLM29k?=
 =?utf-8?B?ZTM5S1NnY2thcUx4MnJIeXkzZ3hZTVpmRUxESzdGdHREbTJNZ3R1c0YwR2cw?=
 =?utf-8?B?UEpUWDROV21PSkJsYzh4OUhoaFowajdyak91Z1lMbWYxNEhMZTg3WTZlRVpa?=
 =?utf-8?B?UHkxVlk3c0Y4MnJBaTQ2WjRyTGgyaC9kUnBIVHJHL3dBbldoOVJGY1V4YXJF?=
 =?utf-8?B?NHdaUG1jOHN0Q0R5bkdZekZ3S2VIYkl3VkRvam9Uc3BZdlBLT1hCdTkzd0J0?=
 =?utf-8?B?TG5yTUVWRG03UmpLQnVxREN2SDVzSW1wT2RGMi9Zekd5UTZscmwwc2pCdFcr?=
 =?utf-8?B?SHBmWjRRVjd5WEQzVmxta1NHekVZa1RFUStxTGQzNkRuakxCcktRcVM0ak9q?=
 =?utf-8?B?Z1VXdEQ4UTVsRXZhdDVnUVI1SDNWN2Noc0VkTHlTWmQ0cFgwZjd4cG1XZUYr?=
 =?utf-8?B?d2NjTytjcWdHZFB3WXJYQjRmWDIxemQ2Kzh1dC93YTFtNXNkRSt1Zi9IZzM5?=
 =?utf-8?B?SXNUMmkvWHhqUWE1MCtTaU1WS3pUdGl1YTBBaGc5ZmVGd1NPZi95S1VmdkF3?=
 =?utf-8?B?VFZGUDl5L0J5YWx6QjNCaXc3MFBYV0hoUVZ4L2NCekRFK2NrSHJsU2xSMVdR?=
 =?utf-8?B?MlhlZTNvVnJVUWNaRjVjNHdDdXZoNDVoNDRncElQRkovS09ESTZVUXczblpu?=
 =?utf-8?B?Qk1zVFRESVFZTS92TlBsMFhNejBtdWc0SFNVQUFtaUxib0hWM2djRHFNL2RN?=
 =?utf-8?B?c3hMaWNiQU9yaFVNQ3UraUZZZlhqVzU0NFJxWkJFSHlaUkt2R0hrNWp2ZHh0?=
 =?utf-8?B?R3hzcTZ0dGtWdjdnazAxN0JSZ1RkbjAvWDAzeDRzZWNldHlpVjRudFBxblR4?=
 =?utf-8?B?NjNpdWhpeFJ1WG10RmtiNm1DZXprWjNxZUdBcUUrOVJsYXZIT1U2bk9BOUdJ?=
 =?utf-8?B?dFFYbzhvaXRpSVZ2eUFVNkRocytlZExBcitvNG1rWVp6Ym9WcURKOE9MNFpV?=
 =?utf-8?B?SGV2ZnBlbkRub290Vkk3eHRRdnhPNk1saVJzOWNxTDZCMmRCWjBxWkRLOXJD?=
 =?utf-8?B?c2ZadXE4NzhRMU85dW9MaGlmNWRpSDlwdmt0aFJrandWa2RVUE9CRVh6SXdy?=
 =?utf-8?B?bEEwcVRUNmc2L2tTRytRRm1IYjBacFEzRGlxbG1ac1E0bVkzUFVxUmVIdFFs?=
 =?utf-8?B?d0oyU2Y0aEhXMVh4OVcyNnlqREQrMEIvWkxDSUsvVDBvaEl0YXh2b1QvTmtE?=
 =?utf-8?B?dmJ2ZXFKb2NiK2graUtzNXA3TTMyNlZJMFB1Q2pzWXZTVmNFTkh0b1FQMVNM?=
 =?utf-8?B?dUhZcTNZRmMvSDljMWxyNmdORWpoQS9la1AvSFpQY0FHNW9kcmVMdE15UTU1?=
 =?utf-8?B?TEdwS3R0Yk9mL1lDbkJ1MzBhbWY0UnZXb2dmL0pSa3BLNnNBNkRIL1ZKanlG?=
 =?utf-8?B?REZQZzBONWc1b1ByeU42cVF4bXROVFY3c0NMc2JncnhVMUZEWmpIQTZTT2Fx?=
 =?utf-8?B?OVFQWXpGbGI2TVZ6eDhkaTQ4MlhHWkFaaHBsdk8rbmd1SkxpRnBUOXJmYVlU?=
 =?utf-8?B?SXpHaVdCVUVHbzFEQ0N2SW92VEhEUUFwRFdZK2dCanBkZUtqb3NCdkptWlNU?=
 =?utf-8?B?T0RaYkZDcnRpb0hiUGRwbHROZCtwbnNGc255bkdNaldPdUVsN0Jwazc5MU1k?=
 =?utf-8?Q?73KvhFCQTYGgy/aQB94e620I2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6417ef6c-e9ee-4a18-b21c-08da66422cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 09:12:43.4298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7mfdyVwUrH6xl8Djhq0BsxOhBUSyRXraOJ1FXd1mklECkfYXBXpwT05pkPYGxWqKoTQUiXwOiRFRDTz81X23Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3669
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbiwNCg0KVGhl
IHJlc3VibWl0dGVkIGpvYiBpbiBmdW5jdGlvbiBhbWRncHVfaWJfcHJlZW1wdF9qb2JfcmVjb3Zl
cnkgcmV0dXJucyB0aGUgc2FtZSBodyBmZW5jZSBiZWNhdXNlIG9mIHRoaXMgY29tbWl0Og0KDQpz
dGF0aWMgdm9pZCBhbWRncHVfaWJfcHJlZW1wdF9qb2JfcmVjb3Zlcnkoc3RydWN0IGRybV9ncHVf
c2NoZWR1bGVyICpzY2hlZCkNCnsNCiAgICAgICAgc3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9i
Ow0KICAgICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTsNCg0KICAgICAgICBzcGluX2xvY2so
JnNjaGVkLT5qb2JfbGlzdF9sb2NrKTsNCiAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShzX2pv
YiwgJnNjaGVkLT5wZW5kaW5nX2xpc3QsIGxpc3QpIHsNCiAgICAgICAgICAgICAgICBmZW5jZSA9
IHNjaGVkLT5vcHMtPnJ1bl9qb2Ioc19qb2IpOyAgICAgICAvL2ZlbmNlIHJldHVybmVkIGhhcyB0
aGUgc2FtZSBhZGRyZXNzIHdpdGggc3dhcHBlZCBmZW5jZXMNCiAgICAgICAgICAgICAgICBkbWFf
ZmVuY2VfcHV0KGZlbmNlKTsNCiAgICAgICAgfQ0KICAgICAgICBzcGluX3VubG9jaygmc2NoZWQt
PmpvYl9saXN0X2xvY2spOw0KfQ0KDQoNCg0KY29tbWl0IGM1MzBiMDJmMzk4NTBhNjM5YjcyZDAx
ZWJiZjdlNWQ3NDVjNjA4MzENCkF1dGhvcjogSmFjayBaaGFuZyA8SmFjay5aaGFuZzFAYW1kLmNv
bT4NCkRhdGU6ICAgV2VkIE1heSAxMiAxNTowNjozNSAyMDIxICswODAwDQoNCiAgICBkcm0vYW1k
L2FtZGdwdSBlbWJlZCBod19mZW5jZSBpbnRvIGFtZGdwdV9qb2INCg0KICAgIFdoeTogUHJldmlv
dXNseSBodyBmZW5jZSBpcyBhbGxvY2VkIHNlcGFyYXRlbHkgd2l0aCBqb2IuDQogICAgSXQgY2F1
c2VkIGhpc3RvcmljYWwgbGlmZXRpbWUgaXNzdWVzIGFuZCBjb3JuZXIgY2FzZXMuDQogICAgVGhl
IGlkZWFsIHNpdHVhdGlvbiBpcyB0byB0YWtlIGZlbmNlIHRvIG1hbmFnZSBib3RoIGpvYg0KICAg
IGFuZCBmZW5jZSdzIGxpZmV0aW1lLCBhbmQgc2ltcGxpZnkgdGhlIGRlc2lnbiBvZiBncHUtc2No
ZWR1bGVyLg0KDQogICAgSG93Og0KICAgIFdlIHByb3Bvc2UgdG8gZW1iZWQgaHdfZmVuY2UgaW50
byBhbWRncHVfam9iLg0KICAgIDEuIFdlIGNvdmVyIHRoZSBub3JtYWwgam9iIHN1Ym1pc3Npb24g
YnkgdGhpcyBtZXRob2QuDQogICAgMi4gRm9yIGliX3Rlc3QsIGFuZCBzdWJtaXQgd2l0aG91dCBh
IHBhcmVudCBqb2Iga2VlcCB0aGUNCiAgICBsZWdhY3kgd2F5IHRvIGNyZWF0ZSBhIGh3IGZlbmNl
IHNlcGFyYXRlbHkuDQogICAgdjI6DQogICAgdXNlIEFNREdQVV9GRU5DRV9GTEFHX0VNQkVEX0lO
X0pPQl9CSVQgdG8gc2hvdyB0aGF0IHRoZSBmZW5jZSBpcw0KICAgIGVtYmVkZGVkIGluIGEgam9i
Lg0KICAgIHYzOg0KICAgIHJlbW92ZSByZWR1bmRhbnQgdmFyaWFibGUgcmluZyBpbiBhbWRncHVf
am9iDQogICAgdjQ6DQogICAgYWRkIHRkciBzZXF1ZW5jZSBzdXBwb3J0IGZvciB0aGlzIGZlYXR1
cmUuIEFkZCBhIGpvYl9ydW5fY291bnRlciB0bw0KICAgIGluZGljYXRlIHdoZXRoZXIgdGhpcyBq
b2IgaXMgYSByZXN1Ym1pdCBqb2IuDQogICAgdjUNCiAgICBhZGQgbWlzc2luZyBoYW5kbGluZyBp
biBhbWRncHVfZmVuY2VfZW5hYmxlX3NpZ25hbGluZw0KDQogICAgU2lnbmVkLW9mZi1ieTogSmlu
Z3dlbiBDaGVuIDxKaW5nd2VuLkNoZW4yQGFtZC5jb20+DQogICAgU2lnbmVkLW9mZi1ieTogSmFj
ayBaaGFuZyA8SmFjay5aaGFuZzdAaG90bWFpbC5jb20+DQogICAgUmV2aWV3ZWQtYnk6IEFuZHJl
eSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPg0KICAgIFJldmlld2VkIGJ5
OiBNb25rIExpdSA8bW9uay5saXVAYW1kLmNvbT4NCiAgICBTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQoNCg0KVGh1cyB0aGUgZmVuY2Ugd2Ug
c3dhcHBlZCBvdXQgaXMgc2lnbmFsZWQgYW5kIHB1dCB0d2ljZSBpbiB0aGUgZm9sbG93aW5nIDIg
ZnVuY3Rpb25zIGFuZCB3ZSBnZXQgIiByZWZjb3VudF90OiB1bmRlcmZsb3c7IHVzZS1hZnRlci1m
cmVlLiAiIGVycm9ycyBsYXR0ZXIuDQoNCiAgICAgICAgICAgICAgICAvKiB3YWl0IGZvciBqb2Jz
IGZpbmlzaGVkICovDQogICAgICAgICAgICAgICAgYW1kZ3B1X2ZlbmNlX3dhaXRfZW1wdHkocmlu
Zyk7IC8vc2lnbmFsIGFuZCBwdXQgdGhlIHJlc3VibWl0dGVkIGpvYnMgZmVuY2UuDQoNCiAgICAg
ICAgICAgICAgICAvKiBzaWduYWwgdGhlIG9sZCBmZW5jZXMgKi8NCiAgICAgICAgICAgICAgICBh
bWRncHVfaWJfcHJlZW1wdF9zaWduYWxfZmVuY2VzKGZlbmNlcywgbGVuZ3RoKTsgICAvL3NpZ25h
bCBhbmQgcHV0IHRoZSBwcmV2aW91cyBzd2FwcGVkIGZlbmNlLCBzaWduYWwgd291bGQgcmV0dXJu
IC0yMi4NCg0KVGhhbmtzLA0KSmlhZG9uZw0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNv
bT4NClNlbnQ6IEZyaWRheSwgSnVseSAxNSwgMjAyMiA0OjQ4IFBNDQpUbzogWmh1LCBKaWFkb25n
IDxKaWFkb25nLlpodUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEdy
b2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4NCkNjOiBIdWFuZywg
UmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IExpdSwgQWFyb24gPEFhcm9uLkxpdUBhbWQuY29tPg0K
U3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIGRybS9hbWRncHU6IHNraXAgcHV0IGZlbmNlIGlmIHNp
Z25hbCBmYWlscw0KDQpbQ0FVVElPTjogRXh0ZXJuYWwgRW1haWxdDQoNCkFtIDE1LjA3LjIyIHVt
IDEwOjQzIHNjaHJpZWIgamlhZG9uZy56aHVAYW1kLmNvbToNCj4gRnJvbTogIkppYWRvbmcuWmh1
IiA8SmlhZG9uZy5aaHVAYW1kLmNvbT4NCj4NCj4gRG1hX2ZlbmNlX3NpZ25hbCByZXR1cm5pbmcg
bm9uLXplcm8gaW5kaWNhdGVzIHRoYXQgdGhlIGZlbmNlIGlzDQo+IHNpZ25hbGVkIGFuZCBwdXQg
c29tZXdoZXJlIGVsc2UuDQo+IFNraXAgZG1hX2ZlbmNlX3B1dCB0byBtYWtlIHRoZSBmZW5jZSBy
ZWZjb3VudCBjb3JyZWN0Lg0KDQpXZWxsIHF1aXRlIGEgYmlnIE5BSyBvbiB0aGlzLg0KDQpSZWZl
cmVuY2UgY291bnRpbmcgc2hvdWxkIGJlIGNvbXBsZXRlbHkgaW5kZXBlbmRlbnQgd2hlcmUgYSBm
ZW5jZSBzaWduYWxzLg0KDQpBbmRyZXkgY2FuIHlvdSB0YWtlIGEgbG9vayBhdCB0aGlzIGFzIHdl
bGw/DQoNClRoYW5rcywNCkNocmlzdGlhbi4NCg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKaWFkb25n
LlpodSA8SmlhZG9uZy5aaHVAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPiBpbmRleCBmNGVkMDc4NWQ1MjMuLjkzYzFh
NWU4MzgzNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RlYnVnZnMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVi
dWdmcy5jDQo+IEBAIC0xNTAwLDggKzE1MDAsOCBAQCBzdGF0aWMgdm9pZCBhbWRncHVfaWJfcHJl
ZW1wdF9zaWduYWxfZmVuY2VzKHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZXMsDQo+ICAgICAgICAg
ICAgICAgZmVuY2UgPSBmZW5jZXNbaV07DQo+ICAgICAgICAgICAgICAgaWYgKCFmZW5jZSkNCj4g
ICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAtICAgICAgICAgICAgIGRtYV9mZW5j
ZV9zaWduYWwoZmVuY2UpOw0KPiAtICAgICAgICAgICAgIGRtYV9mZW5jZV9wdXQoZmVuY2UpOw0K
PiArICAgICAgICAgICAgIGlmICghZG1hX2ZlbmNlX3NpZ25hbChmZW5jZSkpDQo+ICsgICAgICAg
ICAgICAgICAgICAgICBkbWFfZmVuY2VfcHV0KGZlbmNlKTsNCj4gICAgICAgfQ0KPiAgIH0NCj4N
Cg0K
