Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D57EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 03:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440B410E0C9;
	Mon, 10 Jul 2023 03:38:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229D310E139
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 03:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF4kcGTPx9MRxBTaWSpgBDkVG0j/cfMwZTEBdug5U2kz+U5zWn2EYdq4EOAPHRqYHt5kRGFN+iDuuSA1hgzStBLlQYGe97/eVQDUb2N7g2MO40XgTl/VJYbLj3RP9kPAMoxIBB8BWppr+KxL6MqQQ2Q2Cu3k9HifHVuiHEx3xldASGbI/JqTItxH53had2FXEA7ibt602Z4JyT+ScZ3rEf3YZwH+PFRcqTtEH29GATSdxNzKXKifDjIaWK6bg74BqzqZOtXBE4SVDoL6SyIq1IskLbTJuox+XJrX9ThmYA2f/p0zYD+0w7tsyQEuKi7xl7rcph/sQZ+VUbbjYKin4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhMobNJd/XCWKnmDS5LfC00spzh0HEOhNlGtCHAVoec=;
 b=UlyMa4cnPJagxaGwNB8uz9QSmJBj8HgrV/3aW5VATUorKjEHzls82w8pkrRtfpdx80kwkuXREJfoVviq6xJ+jtzDR/lWtPebTl3cuJtFtdVS3D/7Q0nHYF+22GHaDGC4oB7ctpx+71W3Gi+FhDP50ct2NvP8FLnqcgvJGtLJop0qpoALYrqEAWhiEygAyldy3s7hMAvMGBL2rFqlz7Pa1PPpafM+TJ0+CJV7Sjlh29vFRhK/qy59N+aRqFnA1gU5ymG2yaDt43OVf/noEoT8SDuM8bTLaduCypDNz3hKmUTuHgpR+VOi9h+3pMUK0gxQGu4Ygad1zWDsIDQBtICRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhMobNJd/XCWKnmDS5LfC00spzh0HEOhNlGtCHAVoec=;
 b=BLDcCepBnMOVbFV5PB0EIv5nG5hiAhg5bXLi8SPkBlarX94/E3siWDoJqC2ppyQjIufQ0TJ/r8PkOxe/ibE71SlND9UDHUX+NIANQST5DKvyYTGU3su/HkQgrH45PCGpEuI0qjo7f1gs5Zcy53e1Yjeo3JH6I2nSgp51tOO9Jno=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 03:38:09 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8802:ee44:4940:8be]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8802:ee44:4940:8be%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 03:38:08 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v3] drm/amdkfd: Fix stack size in 'amdgpu_amdkfd_unmap_hiq'
Thread-Topic: [PATCH v3] drm/amdkfd: Fix stack size in
 'amdgpu_amdkfd_unmap_hiq'
Thread-Index: AQHZst3jZxSuembkxE6qQQaGIPPQBa+yWL9Q
Date: Mon, 10 Jul 2023 03:38:08 +0000
Message-ID: <DM5PR12MB2469E8F9584E95A0D0FAD4E0F130A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230709150506.255846-1-srinivasan.shanmugam@amd.com>
 <20230710032223.274800-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230710032223.274800-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5b2d235b-7e22-4335-b93f-c2f7d4153595;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-10T03:33:11Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS0PR12MB7769:EE_
x-ms-office365-filtering-correlation-id: 9059fedb-9878-4d75-918a-08db80f713df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H9hS/a0Uw6xRwG+OEB0idiTlRNwEEIEcfQOKURUl1h7tGgyBsMoCH4jvgnE7dIwQm+jzhbVqxoIQDQLFd7qzQsLFC/IZMuNID8HGezP9XU2bXngedhWfPSZd8eUtMnBxW9EFWQH5N+Uefp03lDVB0IZa5mhxbJZJBpMejlItjNljOFbkUa4/27/9TiQXyVUhLrLdnQR/nQdkrTHeMTnAD35btQs4zLWYwHLQ45JUuyyKdaPbiXXIfWSVO9Su0bASzJZA8reUVBRvKXXSBI3uLs0tB4AYQL87nCEOyok1uYw705aFh9n8JP65Gvu21aWeHDxVZmILbRDs1cWFXfuHrJQfFy0UPrALjjLBxGYwCyS6IqJYriFfkgyXreKFe0yaimET+qNel0G9dHCHvHYs8NiKkqnJTEaWaQCcfWjCavfwJYs+Ia5wcT69pPGrbnDreLoThTSf08PSlOTsqtl51kJjZ36rGuqYN0DRHAFVJXE6wlnW0lfYjhL2nOzH2vPDhmZkmTgkOzrfGqAzlYeAdn03iALR7ys7LIvNgZLemIsqIhljV0UdpYsoa9T43roOT8EsXe7GQrBTcQedaKNCYi7DGav5MRy3XXCW3T3P43q7Af8i/ncT2u2z2nUaN5YP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(7696005)(478600001)(76116006)(71200400001)(110136005)(6506007)(26005)(53546011)(9686003)(186003)(66946007)(2906002)(66556008)(41300700001)(66476007)(6636002)(4326008)(66446008)(316002)(5660300002)(52536014)(8936002)(8676002)(64756008)(38100700002)(122000001)(38070700005)(33656002)(86362001)(83380400001)(66574015)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2dFSEFreFBRZXRISm50aUhSTlhjTmRmSWRWVmJVSmNSOTBnQy83Tm9mSjIw?=
 =?utf-8?B?ZTRYakdEdHlkczQyV24xOUVkQ3lFTE9YTDZlSjFSN2RWbVQxRXB0SnJCZ1Y3?=
 =?utf-8?B?akczbkFaeGtKdVZmY3pXQWRoRmFZWFBiTzhOUmxXdmQ2ZkY0eVBDd3VDRk9m?=
 =?utf-8?B?ZURCa1ZiVW9TUU5hdVB5eXRKKzB2cU1PazNZN2tNNDZpcjh2emtxelNmMEtO?=
 =?utf-8?B?U2xPSDZtVXY4di91R2J2bXI2endLSlF5YVZENnZsejZSTy9EN1NWZmNjWmNR?=
 =?utf-8?B?dFRhZzc1RzdlR2trOUdKMnhUVzdQOVZCazBud2orM3pwTXF6SXRIRmRZWjc1?=
 =?utf-8?B?cVJOYVhTQUhmWEN6Y3plSkkyeU9qRFNMMFUwNytRZVluY3J5QWZaNVYzcFpY?=
 =?utf-8?B?eFlKK2Y0QWtkaExsUUZFRng0SURmeVVpZE9HUEV1MGNsRHFib3dZczRVcTZF?=
 =?utf-8?B?QWZlK1ZsMzJ5NzJvcG5GL0dGem1zbUZJdy85WFNuQVA5ai90U2VwNmlMdFJq?=
 =?utf-8?B?N0xMMytqTWpkMU5JenJkNUthVHhja0U3UXZ1NC9pQUFGYmhsWEY2QjluVDkv?=
 =?utf-8?B?WjkzdGM3eDVlTjFZQlR0R0lDZ0JDYmMxUnNkVXR4WkxVWmYxVGJUOHBOdGFp?=
 =?utf-8?B?bkVUSzFBdkszMWJxOGZBNTE1Z0N0VFlyK3h6eW05NXorWU5LOWRZNllFZy84?=
 =?utf-8?B?cWIyUDdveWdKTFZHdHY2WnRydnZaY0V6Y29sOUp2VFhoL2FTK0dyY0VKSlpo?=
 =?utf-8?B?WERzR1Y1NW1sU1BXUzZmdG1LelVkRWI0aEpoR1ZzUld4N1FsOUFkT25SZ29L?=
 =?utf-8?B?OGpFcVBrZFh0aStuR3lNNDJXblFyNGFzOEhzWkZCY3RzMEdPYjdGNFF3R29H?=
 =?utf-8?B?NTYzU1IzSGZsZ1R1aHRFdTJucEViZElUQXU3QUF5MHJzL2txR1NBVXE2TFVG?=
 =?utf-8?B?K01DRHlMT2Y3SkVqOXNTWkxDMDVzaThrbnl6VnNnUkY4QnJDdDM3am8vZ1Mr?=
 =?utf-8?B?M3VIK2dmUWttNiszUEVjRlduYTk1ZlA2SmsvR0UzS05FbnBJbmd6c2F4NkNY?=
 =?utf-8?B?Z0JYVlVmVkhqQzVyL1g5ZjhVM2NMWUdHUlJzejczSnlRUGdqZjgyOFhBMHJs?=
 =?utf-8?B?cUQ0MHA1OEh6T3BSYXpMNXZLMnFIMjlQSnFNVXoyWmE4NXJrU0M3dlhxWGRk?=
 =?utf-8?B?ek1wNGoxRVVNQ3ZkbkVkbHo3QmZ1c1hFcWlnM2h6TmtvMmFCYkZEckx1Ump4?=
 =?utf-8?B?RUlYZUMyWHd4RXprSFZNVTNtSE8wV3NNaitmbzZGajgxcHRta3Y4TGlCaHpu?=
 =?utf-8?B?bjZERHg5QXMwek5hYjlHVC8yWFlxZk1YbjdCdWJCWG5pOTRETG9EOS9mZEdq?=
 =?utf-8?B?MFRMSFJDYkI0QkZRRW9ld0lyaEV4L0MxUXFYTFExc2E0NStrT0dyM2JMQWpp?=
 =?utf-8?B?UUJSajVtbkVLUStZL0xKSHJKSzlMcXF3TThnNVdMZDBQSC9zbFN3RENQR0kr?=
 =?utf-8?B?Nk5mVnAvSExOdlA4amVjOVhVYzhSekRjT2ZrT3RET1pBbWt5OWtMdmVKTWFH?=
 =?utf-8?B?b0tBWWVtWUUwODdTVm1DbERzcmhSS0xiTk5VeG1VaE1wbTVTVm11cm1wRitG?=
 =?utf-8?B?QWF0eGw2YlBYWFg1RXVzaThId3VING1YaTRxcDNlZDE1SzQzN0ZlTVlEUWRK?=
 =?utf-8?B?YVFRWm5id0lOWmxaK0Zid0xSbzhscUJvNENGZEFvUTRETHBuNDdTUEtjMklz?=
 =?utf-8?B?VlNYemxSc3hwSjlyOGFwcnRuUEFLMjdqeVcyajVUMmFWTXJlcGVXclJqNjZz?=
 =?utf-8?B?aE0yNGpuS2phQUZNU25Uc0c3ZUdoNnpmSzhZazI2RldHaGc3cG56djhtNGYx?=
 =?utf-8?B?ZVlIbmFMVUZVaWZvL0VueGVQTjlkOFpzODErT29YWThiK2tLS1lBeTI3WEJQ?=
 =?utf-8?B?V2gwVVkvajlHT2Y4cmlOSk5PcmFSMlNRMzFWU1hmQ0VHRWJkOUhKNUtacG5U?=
 =?utf-8?B?eS9qQTllaXhTN2pYYWwrMnc2MTVkamxMNnpXWkh1QW9kbkk3cndSMmtmUWlL?=
 =?utf-8?B?Yy8rd2h6K0dreEdkRStZeEovbFFGR2RQaXhYVjg4YnJVRUdpTVd4L0xYYW44?=
 =?utf-8?Q?OujA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9059fedb-9878-4d75-918a-08db80f713df
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 03:38:08.1623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TS5rsdTKRe4TemgfIcw0uHZImQJkHFuAqsxVaSUQ+L3L4J26KjGBSgbkG8Q0HxNGdWVkIBjjJs/M4/65IL4m5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KQWNrZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNIQU5NVUdBTSwgU1JJTklW
QVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdWx5
IDEwLCAyMDIzIDExOjIyIEFNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsNCj4gQ2hl
biwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVH
QU1AYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYzXSBkcm0vYW1ka2ZkOiBGaXggc3RhY2sg
c2l6ZSBpbg0KPiAnYW1kZ3B1X2FtZGtmZF91bm1hcF9oaXEnDQo+DQo+IEFsbG9jYXRlIGxhcmdl
IGxvY2FsIHZhcmlhYmxlIG9uIGhlYXAgdG8gYXZvaWQgZXhjZWVkaW5nIHRoZSBzdGFjayBzaXpl
Og0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmM6IEluIGZ1bmN0
aW9uDQo+IOKAmGFtZGdwdV9hbWRrZmRfdW5tYXBfaGlx4oCZOg0KPiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmM6ODY4OjE6IHdhcm5pbmc6IHRoZQ0KPiBmcmFtZSBz
aXplIG9mIDEyODAgYnl0ZXMgaXMgbGFyZ2VyIHRoYW4gMTAyNCBieXRlcyBbLVdmcmFtZS1sYXJn
ZXItdGhhbj1dDQo+DQo+IFN1Z2dlc3RlZC1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFt
ZC5jb20+DQo+IENjOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4g
Q2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
U3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0t
LQ0KPg0KPiB2MzoNCj4gIC0gZnJlZSByaW5nX2Z1bmNzIGJlZm9yZSAncmV0dXJuIC1FTk9NRU0n
IChHdWNodW4pLg0KPiAgLSBrZWVwIHRoZSBjaGVjayBvZiAnIGtpcS0+cG1mJyBhbmQgJ2tpcS0+
cG1mLT5raXFfdW5tYXBfcXVldWVzJyBhaGVhZA0KPiAgICBvZiBhbGxvY2F0aW9uIG9mIHJpbmcg
JiByaW5nX2Z1bmNzIChHdWNodW4pLg0KPg0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZC5jIHwgMzIgKysrKysrKysrKysrKysrKy0NCj4gLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jDQo+IGluZGV4IDAwNDBjNjNl
MjM1Ni4uNjI5Y2ExYWQ3NWE4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZC5jDQo+IEBAIC04MzYsMzMgKzgzNiw0NyBAQCBpbnQgYW1kZ3B1X2FtZGtm
ZF91bm1hcF9oaXEoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiBkb29yYmVsbF9v
ZmYsICB7DQo+ICAgICAgIHN0cnVjdCBhbWRncHVfa2lxICpraXEgPSAmYWRldi0+Z2Z4LmtpcVtp
bnN0XTsNCj4gICAgICAgc3RydWN0IGFtZGdwdV9yaW5nICpraXFfcmluZyA9ICZraXEtPnJpbmc7
DQo+IC0gICAgIHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyByaW5nX2Z1bmNzOw0KPiAtICAgICBz
dHJ1Y3QgYW1kZ3B1X3JpbmcgcmluZzsNCj4gKyAgICAgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNz
ICpyaW5nX2Z1bmNzOw0KPiArICAgICBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmc7DQo+ICAgICAg
IGludCByID0gMDsNCj4NCj4gICAgICAgaWYgKCFraXEtPnBtZiB8fCAha2lxLT5wbWYtPmtpcV91
bm1hcF9xdWV1ZXMpDQo+ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+DQo+IC0gICAg
IG1lbXNldCgmcmluZywgMHgwLCBzaXplb2Yoc3RydWN0IGFtZGdwdV9yaW5nKSk7DQo+IC0gICAg
IG1lbXNldCgmcmluZ19mdW5jcywgMHgwLCBzaXplb2Yoc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNz
KSk7DQo+ICsgICAgIHJpbmdfZnVuY3MgPSBremFsbG9jKHNpemVvZigqcmluZ19mdW5jcyksIEdG
UF9LRVJORUwpOw0KPiArICAgICBpZiAoIXJpbmdfZnVuY3MpDQo+ICsgICAgICAgICAgICAgcmV0
dXJuIC1FTk9NRU07DQo+ICsNCj4gKyAgICAgcmluZyA9IGt6YWxsb2Moc2l6ZW9mKCpyaW5nKSwg
R0ZQX0tFUk5FTCk7DQo+ICsgICAgIGlmICghcmluZykgew0KPiArICAgICAgICAgICAgIHIgPSAt
RU5PTUVNOw0KPiArICAgICAgICAgICAgIGdvdG8gZnJlZV9yaW5nX2Z1bmNzOw0KPiArICAgICB9
DQo+DQo+IC0gICAgIHJpbmdfZnVuY3MudHlwZSA9IEFNREdQVV9SSU5HX1RZUEVfQ09NUFVURTsN
Cj4gLSAgICAgcmluZy5kb29yYmVsbF9pbmRleCA9IGRvb3JiZWxsX29mZjsNCj4gLSAgICAgcmlu
Zy5mdW5jcyA9ICZyaW5nX2Z1bmNzOw0KPiArICAgICByaW5nX2Z1bmNzLT50eXBlID0gQU1ER1BV
X1JJTkdfVFlQRV9DT01QVVRFOw0KPiArICAgICByaW5nLT5kb29yYmVsbF9pbmRleCA9IGRvb3Ji
ZWxsX29mZjsNCj4gKyAgICAgcmluZy0+ZnVuY3MgPSByaW5nX2Z1bmNzOw0KPg0KPiAgICAgICBz
cGluX2xvY2soJmtpcS0+cmluZ19sb2NrKTsNCj4NCj4gICAgICAgaWYgKGFtZGdwdV9yaW5nX2Fs
bG9jKGtpcV9yaW5nLCBraXEtPnBtZi0+dW5tYXBfcXVldWVzX3NpemUpKSB7DQo+ICAgICAgICAg
ICAgICAgc3Bpbl91bmxvY2soJmtpcS0+cmluZ19sb2NrKTsNCj4gLSAgICAgICAgICAgICByZXR1
cm4gLUVOT01FTTsNCj4gKyAgICAgICAgICAgICByID0gLUVOT01FTTsNCj4gKyAgICAgICAgICAg
ICBnb3RvIGZyZWVfcmluZzsNCj4gICAgICAgfQ0KPg0KPiAtICAgICBraXEtPnBtZi0+a2lxX3Vu
bWFwX3F1ZXVlcyhraXFfcmluZywgJnJpbmcsIFJFU0VUX1FVRVVFUywgMCwgMCk7DQo+ICsgICAg
IGtpcS0+cG1mLT5raXFfdW5tYXBfcXVldWVzKGtpcV9yaW5nLCByaW5nLCBSRVNFVF9RVUVVRVMs
IDAsIDApOw0KPg0KPiAgICAgICBpZiAoa2lxX3JpbmctPnNjaGVkLnJlYWR5ICYmICFhZGV2LT5q
b2JfaGFuZykNCj4gICAgICAgICAgICAgICByID0gYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIoa2lx
X3JpbmcpOw0KPg0KPiAgICAgICBzcGluX3VubG9jaygma2lxLT5yaW5nX2xvY2spOw0KPg0KPiAr
ZnJlZV9yaW5nOg0KPiArICAgICBrZnJlZShyaW5nKTsNCj4gKw0KPiArZnJlZV9yaW5nX2Z1bmNz
Og0KPiArICAgICBrZnJlZShyaW5nX2Z1bmNzKTsNCj4gKw0KPiAgICAgICByZXR1cm4gcjsNCj4g
IH0NCj4gLS0NCj4gMi4yNS4xDQoNCg==
