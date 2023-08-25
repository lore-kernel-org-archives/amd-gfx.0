Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE898C71133
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 11:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475B810E131;
	Fri, 25 Aug 2023 11:16:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8032C10E131
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 11:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7zGntt3Dn0Ja4bkQGFmQMD/Ol65MEY7Y4oQv5pJU/pk7M+fRZiDQxVQ9lSm/Mkrftle8XNujqMT2XKUx9wPeywpMCLkFWguwEs2FgNe+WymCUsRyMBb8rpz/2KWGdwvb7hyBeFKCuxrvAlXYNWGlTThljQ/DHKXEX9TWz6snNxyaOfPlerCOf0i+qzv6NcuDAHuQ3icsecpodtZYJZNuo/Y3nGvnrmM2bh1EQkhiXbbL2SnUYdGc9AmWlbly3y2NU+q3Kbe01sirQyXuSdaEnEE0/J+ogbcdLsDL05Do/ibLbkXmocorIMSiBewBHk83wnGRgUJ44e79xoGgC2riQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7eGyUBFAe0dxm/eKFowIWXf3sPtMdkqoa/F3UHbFX0=;
 b=DSvYWgraoR8abIoegFHCAMY6OkoB48F76SlyYrO1YfgLX1Y86JBD0mHB0xm8dEznOQ5wEYc3w6Wqfd8pqGKWbnV+Pn4J/NfsW/JH/nDCpCM+++7aQ8EBzjcPJ9bP8CNcScUh+8m415EHIDRN/ONscqGTt3fghgao0dTOlk8Z0ZK4YnhyBbO43JnqyMYVT0Y5WJ1BYuWd5aABM9/zxIppEPpd6WYpLAslPNMR4E3oI+6hXp7tNaaEScXPSF+8chfxv2BdwnNgT9Ua0cOfUC8bIRqxeNF6a75WlV6jHmu/Qvu7p/5J5jR/E/XDOuH0AZ5AvVtmB9w0gZlPprt+1w744g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7eGyUBFAe0dxm/eKFowIWXf3sPtMdkqoa/F3UHbFX0=;
 b=rOMPg/aC2Htjy5jEfKttiPWM9HcCy5f8WHpKMo4hjDgbJ+LilMAl+eVF0ACk96ZZlBp2gX1WthPqtDrORwTkKNINbIeAZ3J+n3/LwSEpJwLwSpv4du4FkdRAK+XAufuyfAaiMnX2/yRW+FJ7QwzZFpDVzBysXFgDcuGl6G8zgjA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 11:16:24 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ffd8:4c61:6807:9ec4]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ffd8:4c61:6807:9ec4%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 11:16:24 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add only valid firmware version nodes
Thread-Topic: [PATCH] drm/amdgpu: Add only valid firmware version nodes
Thread-Index: AQHZ1zayVCBpYFwa4EaAOJ4jKkOXbq/63D/N
Date: Fri, 25 Aug 2023 11:16:23 +0000
Message-ID: <PH7PR12MB599777D2C8261704BCD1C55082E3A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230825092743.842810-1-lijo.lazar@amd.com>
In-Reply-To: <20230825092743.842810-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-25T11:14:38.7462149Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BY5PR12MB4033:EE_
x-ms-office365-filtering-correlation-id: d8680637-6f4c-45dd-c260-08dba55cb7a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfUXrK/YXGm6SoNbbhDbGCmAbWMyVMigRI7BSOnndzc9DoGEZAQZbJ37t6FR9mxCl837BgGwiummUk0GaE51v0LyPfMfSdoN84uNDt4XXlKEIcSIbsy9FcjyK8G3zuCd90O//dbjtSaXr0De4Q5U/P/XrXsOuKR02ZO/+h2zaKEK1HZtj1Kczn7YKs2EjqTx2fEL0pqVBKIO0jkw+cWI+iEjfUVe9TtP7SjXm0SbAaPGacO+6OjQNDYxd1I7AJghfpp5MU5G1bjqse9+APR7T59o7EH5NYyxvkhmE1s0TDmerkLTnR2sV58cdL91LXY1w7XJa277KryDWK9XKpjHEoiNje1bxtM+z84BbKWHX5GiN/U3+LTawn5ZSc7rFvBfkplU37wAqw+AXB9hvB74ECNeTcj0Uk5tCkirXfrQoOZip/u1kG+DcIZ+hqE5+rEr/rFvvxroYodGKCzz3qj39Ib+ZKdzMToepTvdmP67vX60eYWsCAvDODpQbhT1TOBa91bF4gYqbpaX3PuTvnyp5Fql+EskPM9ylDuIDxxtpZyORDCuKVHxHgHIUD1O1aUdUYwErnLJkOT/InIfBJtsFRbCCSTNRySxqsg0aN9l4M4RV8j/CgnZ54koNssRIDrg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199024)(1800799009)(186009)(122000001)(38100700002)(38070700005)(8676002)(4326008)(8936002)(64756008)(54906003)(41300700001)(6506007)(33656002)(316002)(66446008)(7696005)(6636002)(66476007)(66556008)(110136005)(66946007)(76116006)(86362001)(71200400001)(9686003)(55016003)(26005)(478600001)(83380400001)(2906002)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L2ErT0lBdXdKSTEzRlA4TDRKZk9CRmdrZjRKNm04SWs3SFppTU9MWjdvakRi?=
 =?gb2312?B?RFpZNUJIaC9mbkJHTmJYQm9jK2ZSR2o3aWdhTXoxalE1dU9saXFZamNRaW5j?=
 =?gb2312?B?alVIT1ZMRHlkTXB6NzAvZFk1R0dDbTZNUjVyVkZsSWZJQjhjWFNuNk00YjJi?=
 =?gb2312?B?ZGltSDVlOVdmY2d5T0d1eXZEL3VOT3RpS1FMZlExbTg5cHNLVSsySlV2VG1J?=
 =?gb2312?B?NEd5SkE2d2VkbmlZWERmNjRmcjI1RXlIZlNsVWJJRDlydnowSHhvUmY0VWVL?=
 =?gb2312?B?U1pxd05GcnIralJFbW16L1JOQlRiY0lUL3hDYUsxcm9uSTRqeXZ0enZuaFU4?=
 =?gb2312?B?RDgzaU05aE5EUDJIMHZ2ME1sNkd0ZE1YaW5lQ01KOWl4b3NhNjN6S3MyZCt0?=
 =?gb2312?B?eWcwbkhlM1FxTWkwRDR6NDc0cnJpTHlZZXhvbDM3MkR1cVRyUVpoK1dObjd3?=
 =?gb2312?B?dCtwakQ1cU41djVNK0d2SkduL2g2TFNQd013YWpJdTNUUkp2aUFxZE9Ub3Zz?=
 =?gb2312?B?cmFocmdZUjVNeStiNkNiK3JhSmdzdkoyRWNnUkdBVE5iVWJzb1JhOVd4THNT?=
 =?gb2312?B?VEtiKytGMlRJdDFLR3dvbjJZUkppL1UzemVXc3U5OFhqbnhaR1VoOHUzVFNl?=
 =?gb2312?B?ZGQrZnppYXdZMkIwalh4WXFMaXdLTy91dmRQK3dXcmpoR0V6QUhqcWFRbDAx?=
 =?gb2312?B?bHp2ZUpraG55VG12VnNBOHM4dWlTakYzSlVXaEJmOGhlY1J5dVN4OHo4Y1oy?=
 =?gb2312?B?NEtodDU4UjZaK0h1a09JcjRCNUNUYlU3ZkpmQ0xEYnNkejc1R3VCYTUzV0hz?=
 =?gb2312?B?R25iWHRwZmUwQVlRVER1K3BjK0ZSeTc1ZU0va3JFTUk3eVFrV2w5akROdm5Y?=
 =?gb2312?B?MmluS0Qzci8rak5keWppcmpBdUIvb0pMWTh2V05PK2lKRUJEZHJQT3NCV2lN?=
 =?gb2312?B?Syt2aTFITGp3bE5GVmxPQURtVGJPL3lZN0diN3RRbkJyanExSkxycGluc0E1?=
 =?gb2312?B?NExCZ2pTR0RHaXFTajZwRnZOVWkvVnJIUVFtdFgvL3E5NzZLQnE0djhvWGVO?=
 =?gb2312?B?QnJWQ252MjVheVRLK1I4OTQ5VS93V1hRNUJScG5xSkhUMm12NnRsRGNlTDJ1?=
 =?gb2312?B?RzlMOVViQ09VczgrdFJIbmkrRml6Q2ZXbVVXOVIwSW9VbTNBY3lvcEV0L0o2?=
 =?gb2312?B?Vy90dnVyeGNQM2swKzU1Z3dtbEU0ejRmTjFha3pWMEFFK3g1Y3F0ajVBVXkz?=
 =?gb2312?B?dHlCYW9KVG1SS01UM1ZqWkdJZGl3UC9yS1QvOG4rYmEyWHp2VkJWRXYyYWNG?=
 =?gb2312?B?aVpYVTlQKzhEb1dGQXA5RGVpVnVLOUxtOTdNc01UM3U2ZUUzUmpKMnVDSzhD?=
 =?gb2312?B?N0pHcjVzNDBLWWhQMjNLNjZZRlppUzYvOXlJRGE0SGppUnhmVEltOXUzZTJN?=
 =?gb2312?B?b2JPOGtIb3BNeXhFQzBJeWZjMng2NFM4SmZTTm9vYzYzdFVEZWR6Z3NzWnpp?=
 =?gb2312?B?VjQwYURCZFZ4cktOeGR0bjJ6ei9oM056SFBWMFYwWDkwRzZQSWJwWlQ1U3RM?=
 =?gb2312?B?aitPZWM4SXJjdzdFNytML0lIcmx0M0xGaEg3cjVLeDhONnNNT1UzNnRxblFG?=
 =?gb2312?B?S0F0Y2huRjBiV2FTc1NvNG9XbTljMlovUitwd1dZL2V3NVduQXJhSXVyeS81?=
 =?gb2312?B?MzRlNXV3K3pYM1M2eHIycXFKQVV4ZmVIVUlzYWhhbWlqK2dEUDlGekZiaGlK?=
 =?gb2312?B?L0lzM0I0UU5JdHJJNERTdXJzYzdFanhzelRNalFjNGNjeFp2ZVN4UTNPY1Bz?=
 =?gb2312?B?U1NPNnhDZ2N1ci9zZUFBVkxUdnkxTW5FZVU2ck4yaElWTUdrd0F4V3lzamNW?=
 =?gb2312?B?NzNqTngzbWNndXljUTNQRStqdmNrZjR5d3JaTGo4Q25LZHZ6VGZ3WDNpeE9t?=
 =?gb2312?B?aUw5cmRZZ2o1VlN2amlwMm9RM0dlQ3UwekZid1F1MGFLbW9BaTlJY1FkaC9B?=
 =?gb2312?B?OXhtMVkzalZXRWlDTzBlaS90Yy9naFNLSTdRcFVDV0ZLUmp5ZHJjNlo2dWtO?=
 =?gb2312?B?ME1kMjdMK2N1WFo1SmZOa0ZGSlJobVRzdGhPa2IxaitNNkJ2MmNmdUk3aWJV?=
 =?gb2312?Q?3I+nLnzvTyJTlhcxQb5JvpD2g?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB599777D2C8261704BCD1C55082E3APH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8680637-6f4c-45dd-c260-08dba55cb7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 11:16:23.4541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GlsKNGQpbTyLCrTxnYS2W8GDt+uhwwcHePR/jz+7eyYDngkdXOp070Qw42clECOz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB599777D2C8261704BCD1C55082E3APH7PR12MB5997namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBZYW5nIFdh
bmcgPGtldmlueWFuZy53YW5nQGFtZC5jb20+DQoNCkJlc3QgUmVnYXJkcywNCktldmluDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJv
dW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiC0+rHtIExpam8gTGF6YXIgPGxpam8ubGF6YXJA
YW1kLmNvbT4NCreiy83KsbzkOiDQx8bazuUsILDL1MIgMjUsIDIwMjMgMTc6MjkNCsrVvP7Iyzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPg0Ks63LzTogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCtb3zOI6IFtQQVRDSF0g
ZHJtL2FtZGdwdTogQWRkIG9ubHkgdmFsaWQgZmlybXdhcmUgdmVyc2lvbiBub2Rlcw0KDQpTaG93
IG9ubHkgZmlybXdhcmUgdmVyc2lvbiBhdHRyaWJ1dGVzIHRoYXQgaGF2ZSB2YWxpZCB2ZXJzaW9u
LiBIaWRlDQpvdGhlcnMuDQoNClNpZ25lZC1vZmYtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJA
YW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5j
IHwgMzMgKysrKysrKysrKysrKysrKysrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Vjb2RlLmMNCmluZGV4IDhiZWVmYzA0NWUxNC4uYjBiMzdjMDU2YzM2IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMNCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jDQpAQCAtNjY5LDE1ICs2NjksMjUg
QEAgY29uc3QgY2hhciAqYW1kZ3B1X3Vjb2RlX25hbWUoZW51bSBBTURHUFVfVUNPREVfSUQgdWNv
ZGVfaWQpDQogICAgICAgICB9DQogfQ0KDQorc3RhdGljIGlubGluZSBpbnQgYW1kZ3B1X3Vjb2Rl
X2lzX3ZhbGlkKHVpbnQzMl90IGZ3X3ZlcnNpb24pDQorew0KKyAgICAgICBpZiAoIWZ3X3ZlcnNp
b24pDQorICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQorDQorICAgICAgIHJldHVybiAw
Ow0KK30NCisNCiAjZGVmaW5lIEZXX1ZFUlNJT05fQVRUUihuYW1lLCBtb2RlLCBmaWVsZCkgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogc3RhdGljIHNzaXplX3Qgc2hvd18jI25hbWUo
c3RydWN0IGRldmljZSAqZGV2LCAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KLSAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgICAgICAgICBc
DQotICAgICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKmJ1ZikgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikgICAgIFwNCiB7ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQogICAgICAgICBzdHJ1Y3QgZHJtX2RldmljZSAqZGRldiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYp
OyAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYg
PSBkcm1fdG9fYWRldihkZGV2KTsgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQotICAgICAgIHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIjB4JTA4eFxuIiwgYWRldi0+ZmllbGQp
OyAgICAgICAgXA0KKyAgICAgICBpZiAoIWJ1ZikgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KKyAgICAgICAgICAgICAgIHJldHVybiBhbWRn
cHVfdWNvZGVfaXNfdmFsaWQoYWRldi0+ZmllbGQpOyAgICAgICAgICAgICAgXA0KKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KKyAgICAgICByZXR1cm4gc3lzZnNfZW1pdChidWYsICIweCUwOHhcbiIsIGFkZXYt
PmZpZWxkKTsgICAgICAgICAgICAgICAgXA0KIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiBzdGF0aWMgREVW
SUNFX0FUVFIobmFtZSwgbW9kZSwgc2hvd18jI25hbWUsIE5VTEwpDQoNCkBAIC03MjIsOSArNzMy
LDI0IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpmd19hdHRyc1tdID0gew0KICAgICAgICAg
TlVMTA0KIH07DQoNCisjZGVmaW5lIHRvX2Rldl9hdHRyKHgpIGNvbnRhaW5lcl9vZih4LCBzdHJ1
Y3QgZGV2aWNlX2F0dHJpYnV0ZSwgYXR0cikNCisNCitzdGF0aWMgdW1vZGVfdCBhbWRncHVfdWNv
ZGVfc3lzX3Zpc2libGUoc3RydWN0IGtvYmplY3QgKmtvYmosDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGF0dHJpYnV0ZSAqYXR0ciwgaW50IGlkeCkNCit7
DQorICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICpkZXZfYXR0ciA9IHRvX2Rldl9hdHRy
KGF0dHIpOw0KKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBrb2JqX3RvX2Rldihrb2JqKTsN
CisNCisgICAgICAgaWYgKGRldl9hdHRyLT5zaG93KGRldiwgZGV2X2F0dHIsIE5VTEwpID09IC1F
SU5WQUwpDQorICAgICAgICAgICAgICAgcmV0dXJuIDA7DQorDQorICAgICAgIHJldHVybiBhdHRy
LT5tb2RlOw0KK30NCisNCiBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBmd19h
dHRyX2dyb3VwID0gew0KICAgICAgICAgLm5hbWUgPSAiZndfdmVyc2lvbiIsDQotICAgICAgIC5h
dHRycyA9IGZ3X2F0dHJzDQorICAgICAgIC5hdHRycyA9IGZ3X2F0dHJzLA0KKyAgICAgICAuaXNf
dmlzaWJsZSA9IGFtZGdwdV91Y29kZV9zeXNfdmlzaWJsZQ0KIH07DQoNCiBpbnQgYW1kZ3B1X3Vj
b2RlX3N5c2ZzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQotLQ0KMi4yNS4xDQoN
Cg==

--_000_PH7PR12MB599777D2C8261704BCD1C55082E3APH7PR12MB5997namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div>
<div>
<div dir=3D"ltr"><span id=3D"ms-outlook-ios-cursor"></span>Reviewed-by: Yan=
g Wang &lt;kevinyang.wang@amd.com&gt;</div>
</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Best Regards,</div>
<div dir=3D"ltr">Kevin</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>=B7=A2=BC=FE=C8=CB:</b> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&=
gt; =B4=FA=B1=ED Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> =D0=C7=C6=DA=CE=E5, =B0=CB=D4=C2 25, 2023 =
17:29<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; =
Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH] drm/amdgpu: Add only valid firmware version no=
des
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Show only firmware version attributes that have va=
lid version. Hide<br>
others.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 33 ++++++++++++++++++++--=
-<br>
&nbsp;1 file changed, 29 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c<br>
index 8beefc045e14..b0b37c056c36 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c<br>
@@ -669,15 +669,25 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID uc=
ode_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
+static inline int amdgpu_ucode_is_valid(uint32_t fw_version)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!fw_version)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;#define FW_VERSION_ATTR(name, mode, field)&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<=
br>
&nbsp;static ssize_t show_##name(struct device *dev,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct device_attribute *attr,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char=
 *buf)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct device_attribute *attr, char *buf)&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(ddev);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sysfs_emit(buf, &quot;0x%08x\n=
&quot;, adev-&gt;field);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!buf)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return amdgpu_ucode_is_valid(adev-&gt;field);&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sysfs_emit(buf, &quot;0x%08x\n=
&quot;, adev-&gt;field);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;static DEVICE_ATTR(name, mode, show_##name, NULL)<br>
&nbsp;<br>
@@ -722,9 +732,24 @@ static struct attribute *fw_attrs[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL<br>
&nbsp;};<br>
&nbsp;<br>
+#define to_dev_attr(x) container_of(x, struct device_attribute, attr)<br>
+<br>
+static umode_t amdgpu_ucode_sys_visible(struct kobject *kobj,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct attribute *attr, int idx)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *dev_attr =3D=
 to_dev_attr(attr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev =3D kobj_to_dev(ko=
bj);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev_attr-&gt;show(dev, dev_attr, =
NULL) =3D=3D -EINVAL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return attr-&gt;mode;<br>
+}<br>
+<br>
&nbsp;static const struct attribute_group fw_attr_group =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;fw_version=
&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .attrs =3D fw_attrs<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .attrs =3D fw_attrs,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_visible =3D amdgpu_ucode_sys_visi=
ble<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int amdgpu_ucode_sysfs_init(struct amdgpu_device *adev)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB599777D2C8261704BCD1C55082E3APH7PR12MB5997namp_--
