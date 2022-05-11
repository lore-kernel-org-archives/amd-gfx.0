Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BD8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 00:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3614F10F02E;
	Wed, 11 May 2022 00:56:31 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34ECC10F02E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 00:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avCs+WWMOElN3sV94OTWZNX5JqaQvNUFTNhDiRT5h8vEbxqaPTtMuyWNcfY4aSCtrIk7DYIup6SZWfL3zxV2IViuRRpd7eo+SSsbaiFMvolkeGO3MQAR02Z/G2yzM/V7x3k9G24qHovgyQJNkxtBB3SG/Th3g4n7S70NXA1G/zm0VnqiPp/7d2HdfYU2WdZRT9DslCK2sQTo2l2JDW2RowH/gpFBRRaNhDUpmUm81d6g1OIbiqQoykOVkxqJnfwdyT0f1nSqatjxMNMQOHzooXSL9QUshA0XSSXq1t5nMdZA2kU3Zkelmxe1NzQNVR2fb3Hi7Ei+HBWeoPChRvNMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t89rG1VRyRxSnTHyn2948faCl/QTZcsD3WXvm86wHp4=;
 b=bfXIBG+QohK2ZkjQQsfn+eAgfoxSvQS1TvEk69dX2dumoq97vaiDVMWqihO4MJtPezvUvI2G45FTMtPmPsOtZfEynXjW9bXMjIuhJtUjxskXCPUSKO5GjO2KlQB5Ht+cu+6rST8G2XXI3R7ko7pWgWXy+63DFV8xNhRE2Q/rl/o5q7ghjVNNBKj/kJymwqrlHfGd1jtZiyUmovrBraik12OZkexM4U0c50G3D2FTcqqNrGUWZQnhA4JY5Wz38xVCKNH4RhzVdrP5cosqLAQo/GU2ReF0PiNA4Qsj770vV4fcjttXAQUJIRT7h8o762Z98lHkpT7YtsE7YkGz7vmxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t89rG1VRyRxSnTHyn2948faCl/QTZcsD3WXvm86wHp4=;
 b=uLlJBjXJfvyzSXp5Tx3B4bh90iv9HNp4eVNUXMZMDKthnz2vpuuscDxIazzZC0Fzps6cTLfiiz4hb12Q5LanpTpJEDc45+PbmukU2kL6KHWAKVxJgFbskIOw3SnVuKIc4sBLkTtySILX56JttNp/SB/vQFJCktos7X76XeJsEz0=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.20; Wed, 11 May 2022 00:56:27 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9c68:a1fd:1445:49ad]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9c68:a1fd:1445:49ad%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 00:56:27 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBkcm0vYW1kL3BtOiBhZGQgc211IHBwX2ZlYXR1cmVf?=
 =?gb2312?B?bWFzayBjYWxsYmFjayBmb3Igc211X3YxM18wXzc=?=
Thread-Topic: [PATCH] drm/amd/pm: add smu pp_feature_mask callback for
 smu_v13_0_7
Thread-Index: AQHYZJf1K2LBj3N8V0S3CNQ8g4dQ5K0Y2oBy
Date: Wed, 11 May 2022 00:56:27 +0000
Message-ID: <DM4PR12MB516546CBD49081FC8520D3288EC89@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20220510180009.461734-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220510180009.461734-1-KevinYang.Wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-11T00:55:44.1433301Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bb98524-8f91-4981-30d6-08da32e9141a
x-ms-traffictypediagnostic: DM4PR12MB6062:EE_
x-microsoft-antispam-prvs: <DM4PR12MB6062CC4894FA22CE404D80CE8EC89@DM4PR12MB6062.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ir8ewyfdNf3JvP4rs0Sa9P0+GrydxdkquiBBUYkYQ/Vu5fdlr/f0WiZRSMaYRG+Rm1I6ux20/DGLr7wFp7wn5slFQ6I2v++i1DH+bA5AMP2YBA46fyHqyhMGREaH79qfIsflb0SOUOVRh/9GjcRZuNF9oEfN3hu8bor4dmZTPe8GHZN9gDE0QBHP8dbOGjqqQ+FyfOFrrArnA5Rk/nZVBPtK0aofLQXYiMXpHQCkO6uwmo6fWLzX8F8sswdzLFUCNSWMXEiflNEsiT/SXuUsxgfjMg27dRdM2G4N5OmKNzjR/6PLW+JiuCwRa3V9dLdIcO2LZVl8oOEM2AoJz9CtbkN1aanmcc3eoC3fgSfCtoxI9wCWlzH6oFid/zyXIGnsn28g/Fphu+2GzyjJZB0aUNOQc+9bzqq53MfCmraE94IrwKcHtKvEDV68QICmul43v9bKrJl2b3obaQi2wDGAcJwANSNP7Hk/BJEwpLdwyym5R1TQLQZN/i4sCtQvmtsY8WIG3CRzlqyeaONUScv8IkZ6rDxqw9b+QdtKZIo8ENxdHVHKDLO6AWuaAdGFA2X5kfIFd4Jm1cqbvXtOFfDMSuPYFtd+pNCbMjzFDJwwS7jRmlPRu7rJNq1vAxG5WBdSNTLj1J5sAbVDkIMwnsnMWcOrmosewPaaq1l7Szii5vXoYV0pugXbUoAlv8nI7YAQOQOGqSJm20lxoxGHrUUbg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(508600001)(38070700005)(38100700002)(55016003)(224303003)(316002)(122000001)(110136005)(186003)(8936002)(9686003)(64756008)(66446008)(91956017)(71200400001)(6506007)(4326008)(7696005)(2906002)(76116006)(66556008)(66476007)(66946007)(33656002)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SGRucTZRMjR1M3JoZzBkV1BkU1NYdW9MV01NTDlreVpMTkdtZWMxQ1VQQkU4?=
 =?gb2312?B?VTdVVE9TM0FieWErNVpLWGFvMWlNQndmdjhTaHYzbG1xR3JkNUdZTUJJTnZk?=
 =?gb2312?B?N2lZM3JmN3p3aHVMblVRNTVBSzJGdGRacUpDazdydUt2aWtBamZJTHF2QXpo?=
 =?gb2312?B?cDdhUGdTL0g4UnAzbHA3b0FIMklId0FoaUVKZE9zOUlRUmg3V0pjMkI1VHNB?=
 =?gb2312?B?SVAydkN5MnZVbXUwSmhvaDM1NGZFQTJ1VEZQcGZoWlJBVjkyQTlaTTczY0kz?=
 =?gb2312?B?R2lGT3RvTEtDSlorMGJtN01HUmxtRjAxVUtDYzdHVEIwRXNpNjZ1Y3F2K1RN?=
 =?gb2312?B?K0xFU2pQdEZEeXQwdk5wbHU1QVZTZU5mRnJOWnJwMUJ5aitFZFpXYzVOREh3?=
 =?gb2312?B?L0RPbFlnTGdWLzFyeThmaFNkNUZ2eldzNU4rK0VLY0hvd3BpSytYeWQzczhJ?=
 =?gb2312?B?WldlQTJ4SUd5eHpGRktaWktLTmU4U1NQV3E2dWVzK29ra1pCLzlPQzdFZ1NM?=
 =?gb2312?B?MlFIdWxYK3oxMnlqTWtlUWtUOHBsZVJONE52RmQvN0JqSi9YZVMyaUE3MUlw?=
 =?gb2312?B?L2U3OENOaGdMWG5MSVFaci95UmEvN2JGYVFVVHdUL1BhdWFhalVQV0VHZytZ?=
 =?gb2312?B?MkFTN3A4QkFiSjNKai9OdDNjcU9wVTFCdDgrZ1ZJOHREK2VqbGtPNVBtTld6?=
 =?gb2312?B?bkp1RmpGbXVYMEozRHgwWC9VSllXaXMwRnlpY1B5MGZiY09YRFBvdkw4T1FF?=
 =?gb2312?B?M01FNXBIbUZnN3A4NWc2VDl3NWF4OVlLZ2FZbmNSMDZJT1NPRXNNT09jWWtH?=
 =?gb2312?B?YWtCVitrRXh2VlVWWTVIcVJCVzB4WW1TckVkWDRlcFZEV1JzOWN1S0RQeHA2?=
 =?gb2312?B?OUlHRzJOM1ZZaDJXSVFwZ01hVitCOUhyVys0bjhsRGVUM1NCWXZqc1liRFJy?=
 =?gb2312?B?d0hFakNVU1JubFU3RlVIVXFETHYzVDR2VDAydUNmZFJZcmVIZ1JqajVnL2Z6?=
 =?gb2312?B?MTZDSGh0MUlnMDVHR2hnWjc4clZrZW9ZT0ZWWm95Um03bUFnVnVBZmVpMWZu?=
 =?gb2312?B?Q0hkNTBRbTdSWElWUFVjSWwzdmNOV0hkSGpXVUxHVGNBTUJmQVlZVnRMSW1Q?=
 =?gb2312?B?eklqdGk4SmJtVlhNV25MRUk5elI3ek9VbnZtTGZhZ3RXUnZWbkI5a1N1MjdT?=
 =?gb2312?B?MHZtdXIveUxIbThyNWJkQUQyRXIvSjI4TTVHbmxLRThsWmtmaUNhOXFhcDBm?=
 =?gb2312?B?elR4ZlJKa2dST08yUVhkWkJwRE1zZmduUHBsOVhhTmx0WDRrUDdvWUpjQXdZ?=
 =?gb2312?B?dTFRYXNNKzNVVGF5WmFUN1FsUjgzbENMWFJUeUkxS29OckdCVWtzRFdvQS9T?=
 =?gb2312?B?TURPQ05EWUhTMmNlVkgrQUhjVFlpUjdCTHpBd0kwYmoxbWpKdVE4MTBjMVFM?=
 =?gb2312?B?TVdBTTVCVDc3MGRWRXcwdXJ0eXNDd0NkU084cUVBR1pKbGNUNmpXQTdDWlo2?=
 =?gb2312?B?NjNvQ1MxUW9qdTE4bU02NTRVbndXZ3dFbGpDcTZMd3gzb245QUJISXJWNk82?=
 =?gb2312?B?cHlsSExCM3J5bmdkQ0YxZUxlNGZIazIrcUdwcUxFK0c3K3RLTXREeFd5SHpK?=
 =?gb2312?B?dnVCZGFZdDVjbFhLeGd2T0lJK2pGT1gyZExDbG11ajkrZHhaalorTm5nK2NV?=
 =?gb2312?B?SVJPTzV3blhGY1hzWlNWaHV1aUNsb2pkc3A5eFVZZ3BNOVN0K1NmTlBnN00r?=
 =?gb2312?B?dkpzdVZOMGNTT2xHaVN6cTFHZm9LWWpZbXFrZG1MSlN5NENOb0E0NHY3YnBN?=
 =?gb2312?B?aU1jcHZBWnFOeC9EdTNHSjBHVXpCYW5DWVl2UFhWY1NWOWh3cWRvaXdEeUJY?=
 =?gb2312?B?a0Y1RHcyZUJ1UVZHZ2RVV21BMDBKVUZxaThBZFErOGVwN2NwaEFaQm85KzNO?=
 =?gb2312?B?dlEyd3VNWEdzdzRlUDZFdWVBbWsvWVRKZFpaeGZ1U2NuNUdQMHNUZHZXVlho?=
 =?gb2312?B?M1ZIa0JpSjhtd2lrNHhGU2Q5UWExWjFpdjNocWRudTFmaERtOUo4MHNTSjhs?=
 =?gb2312?B?a2JqSXRINUVRT05VNVRVNWRRZEZYTGwzQkNOZEVuN1VxU3FYNTR4WXNsVGZ5?=
 =?gb2312?B?WDZLRTJVQk5nNmU4OW9RSUNwR01MOTJBZG1zMnNUdHlQdThTMzVRc0grZW9F?=
 =?gb2312?B?TWF2RFdqWGowZGFBZUVJaEgrNkpiSTR2QU9oR1kwcnZRMHAzajBZd0JQRTBF?=
 =?gb2312?B?a0N1amJ2bXNDODZJLzNwWTJxTkt1Y1E0QmxHMVFQVUp3RUFhckxra1dhVzF1?=
 =?gb2312?B?czJnSzhHTVNJMGIySjV3SjB5NU4zK0NyOStramd5cXJKTlVVSTdTMnR4NFpB?=
 =?gb2312?Q?KrU80xj2wg3AaccY83mm1/g+gfsfLykjhX15dJRqaxNpS?=
x-ms-exchange-antispam-messagedata-1: 3WXmroB09Ufz02L79YTJ7MCUGB04oKLI6lE=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB516546CBD49081FC8520D3288EC89DM4PR12MB5165namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb98524-8f91-4981-30d6-08da32e9141a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 00:56:27.1837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1aHLVfy9SEMNd792z9ojG7ikVtSBZA0GmXS8ae5a7qKuVx8CtolfUQmN7gmCWjA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB516546CBD49081FC8520D3288EC89DM4PR12MB5165namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBLZW5uZXRo
IEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPG1haWx0bzprZW5uZXRoLmZlbmdAYW1kLmNvbT4+
DQoNCkJlc3Qgd2lzaGVzDQpLZW5uZXRoIEZlbmcNCg0KDQq3orz+yMs6IGFtZC1nZnggPGFtZC1n
ZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+ILT6se0gWWFuZyBXYW5nIDxLZXZpbllh
bmcuV2FuZ0BhbWQuY29tPg0KyNXG2jog0MfG2sj9LCAyMDIyxOo11MIxMcjVIDAyOjAxDQrK1bz+
yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4NCrOty806IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29t
Pg0K1vfM4jogW1BBVENIXSBkcm0vYW1kL3BtOiBhZGQgc211IHBwX2ZlYXR1cmVfbWFzayBjYWxs
YmFjayBmb3Igc211X3YxM18wXzcNCltDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbF0NCg0KLSBzZXRf
cHBfZmVhdHVyZV9tYXNrDQotIGdldF9wcF9mZWF0dXJlX21hc2sNCg0KdGhlIHBwX2ZlYXR1cmUg
ZGV2aWNlIG5vZGUgaXNuJ3Qgd29ya2luZyB3aGVuDQphYm92ZSBjYWxsYmFjayBmdW5jdGlvbnMg
YXJlbid0IHByb3ZpZGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBZYW5nIFdhbmcgPEtldmluWWFuZy5X
YW5nQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3Nt
dV92MTNfMF83X3BwdC5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3Yx
M18wXzdfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNf
MF83X3BwdC5jDQppbmRleCA1ODNhOTY3ODQ1NTguLjAwOTY0YjM3MjhmZSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMNCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMN
CkBAIC0xNTAwLDYgKzE1MDAsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBwdGFibGVfZnVuY3Mg
c211X3YxM18wXzdfcHB0X2Z1bmNzID0gew0KICAgICAgICAuZ2V0X3Bvd2VyX3Byb2ZpbGVfbW9k
ZSA9IHNtdV92MTNfMF83X2dldF9wb3dlcl9wcm9maWxlX21vZGUsDQogICAgICAgIC5zZXRfcG93
ZXJfcHJvZmlsZV9tb2RlID0gc211X3YxM18wXzdfc2V0X3Bvd2VyX3Byb2ZpbGVfbW9kZSwNCiAg
ICAgICAgLnNldF90b29sX3RhYmxlX2xvY2F0aW9uID0gc211X3YxM18wX3NldF90b29sX3RhYmxl
X2xvY2F0aW9uLA0KKyAgICAgICAuZ2V0X3BwX2ZlYXR1cmVfbWFzayA9IHNtdV9jbW5fZ2V0X3Bw
X2ZlYXR1cmVfbWFzaywNCisgICAgICAgLnNldF9wcF9mZWF0dXJlX21hc2sgPSBzbXVfY21uX3Nl
dF9wcF9mZWF0dXJlX21hc2ssDQogfTsNCg0KIHZvaWQgc211X3YxM18wXzdfc2V0X3BwdF9mdW5j
cyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCi0tDQoyLjI1LjENCg==

--_000_DM4PR12MB516546CBD49081FC8520D3288EC89DM4PR12MB5165namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
span.searchhighlight
	{mso-style-name:searchhighlight;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span class=3D"searchhighlight"><span lang=3D"EN-US"=
 style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;,serif;co=
lor:#070706;background:#FFEE94">Reviewed-by</span></span><span lang=3D"EN-U=
S" style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;,serif;=
color:black">:
 Kenneth Feng &lt;</span><span lang=3D"EN-US" style=3D"color:black"><a href=
=3D"mailto:kenneth.feng@amd.com" title=3D"mailto:kenneth.feng@amd.com"><spa=
n style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;,serif;c=
olor:#0078D4">kenneth.feng@amd.com</span></a></span><span lang=3D"EN-US" st=
yle=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;,serif;color=
:black">&gt;</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best wishes<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Kenneth Feng&nbsp;<o:p></o:p></=
span></p>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">=B7=A2=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
> amd-gfx
 &lt;amd-gfx-bounces@lists.freedesktop.org&gt; </span><span style=3D"color:=
black">=B4=FA=B1=ED</span><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;color:black"> Yang Wang &lt;KevinYang.Wang@amd.com&=
gt;<br>
</span><b><span style=3D"color:black">=C8=D5=C6=DA</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black">
</span><span style=3D"color:black">=D0=C7=C6=DA=C8=FD</span><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">, 20=
22</span><span style=3D"color:black">=C4=EA</span><span lang=3D"EN-US" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">5</span><span =
style=3D"color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;color:black">11</span><span style=3D"color=
:black">=C8=D5</span><span lang=3D"EN-US" style=3D"font-family:&quot;Calibr=
i&quot;,sans-serif;color:black">
 02:01<br>
</span><b><span style=3D"color:black">=CA=D5=BC=FE=C8=CB</span></b><b><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lis=
ts.freedesktop.org&gt;<br>
</span><b><span style=3D"color:black">=B3=AD=CB=CD</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<b=
r>
</span><b><span style=3D"color:black">=D6=F7=CC=E2</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> [PATCH] drm/amd/pm: add smu pp_feature_mask callba=
ck
 for smu_v13_0_7<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">[CAUTION: External Email]<br>
<br>
- set_pp_feature_mask<br>
- get_pp_feature_mask<br>
<br>
the pp_feature device node isn't working when<br>
above callback functions aren't provided.<br>
<br>
Signed-off-by: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index 583a96784558..00964b3728fe 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -1500,6 +1500,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_profile_mode =3D smu_=
v13_0_7_get_power_profile_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profile_mode =3D smu_=
v13_0_7_set_power_profile_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_tool_table_location =3D smu=
_v13_0_set_tool_table_location,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_feature_mask =3D smu_cmn_get_=
pp_feature_mask,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pp_feature_mask =3D smu_cmn_set_=
pp_feature_mask,<br>
&nbsp;};<br>
<br>
&nbsp;void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)<br>
--<br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB516546CBD49081FC8520D3288EC89DM4PR12MB5165namp_--
