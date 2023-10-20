Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A55BCDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 09:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFC210E0E5;
	Fri, 20 Oct 2023 09:29:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C58B10E0E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 09:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRSouU9XG7D2C79HOiHzAQgEIZtCQVmDkmpWZnaFNEVKzHO4FlJ9Ed/+nnCm2ZEycU20ETOTlLnyy1IJGHkF8tp71WNDN7WYUVvFYaz35h3MYUDEOqlvRSptIKS478BicWsrZtKGaaF41fIdq/c2G414XM0PMiSSta0bLunSzMT4amHN+bfYTn07M6rTnP79Ms3wuAUZ5QhWZeeqaWdSBH61Nyujq3D1Ig3cL8BVxpbDjny60VhNIZgpMWtp76NxBUwZIT0PVvQOrrye5C/8t+5g4OKtQzqA41TktJokssoTn7YJ1jD8bxMApQI/M/ga0mPHe1fO2yad1Eyf51fdsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lpzeYRjgR/FrQSkAMs5stv2Ikk3PU1/e9xZsNuz7RU=;
 b=ksHEjj8NZTge+7tMxQ1avLqrx9sdZcXEM6CgmErnQntuuJF5dPep8EAAB3h/KqPiYY6Lb5Ae+2Iw5jXTYaOIMEpBUgh8NN5GAfqVvu+MzXTfoAuCjLocKvVEXMKConJ+Yug8d4tB/HFDnM2Oc70hr42zCuvJF31+VICKangbMvhz5LloiktdxN+Bppbf+OYR+YkTMjeg5GkgKBhEip1nCwz4mitoJXHwoxPhrdlKCn4pY7qzbvCDDEuXGp3ZOsJ9BA5KG9vA4nPmGMmmN1zRCEjyAhXZrEqvwxteetgEkjN21LBBmv0LnGhak76EFtUQ206PauOYosSLdNFp4sasRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lpzeYRjgR/FrQSkAMs5stv2Ikk3PU1/e9xZsNuz7RU=;
 b=M2Ug2hDQkbvc/fmJvJhL7kAZy0qcK/elYvYZmn4Ys365wpgQFcNtYr7Ag0pPhQP5grZlXKe9BG8qpLrmqydrsHw2UlWaZswLmA1Z10MJw6t1LrwPUPqG7ntMyFWi4/2IIhuctur31RKMzTKOLgkc7YHeiE7dsWAuJWXGPw850ts=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 09:29:49 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::c08b:f17e:eb8b:d410]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::c08b:f17e:eb8b:d410%5]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 09:29:49 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: handle the return for sync wait
Thread-Topic: [PATCH 2/2] drm/amdgpu: handle the return for sync wait
Thread-Index: AQHaAxyJkfNU4BWohUW4RS3+ADuaKbBSSEuAgAAhT2A=
Date: Fri, 20 Oct 2023 09:29:49 +0000
Message-ID: <PH0PR12MB541723CC544D3D492CA528108FDBA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20231020061307.588900-1-Emily.Deng@amd.com>
 <20231020061307.588900-2-Emily.Deng@amd.com>
 <c587f79c-30ce-479a-ab0a-d985eca0b2c4@gmail.com>
In-Reply-To: <c587f79c-30ce-479a-ab0a-d985eca0b2c4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c080f674-23e7-4149-bf49-ef822c2f6605;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-20T09:29:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|SJ2PR12MB8806:EE_
x-ms-office365-filtering-correlation-id: 58e99aeb-dfc3-44b9-6c3d-08dbd14f1b54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9srlWSe1k+Ney823EvT5BOd/ZwPnoRJNRhv6WZsaO+4eS0UshwKyUMZnxeOOfGtpHWAqB+0EyzL9R7IftRK1XQfWgPDyOeyX9CqKYQZPLYRSNekmXG4zxQ6VfglYFKBAoV7dHbEPwnjtLSU4wo1N7lj+ld3q9V5VSPtTDzZxA7VU7ojkGqF3i4R7gypbcGdk+bxaOpWjoHaicsbULsrG2tCKkR1Dwt1GsfeGF7xucBcDMJjMPbHBYNgWcqz6otwbyT+d5MZPiFlo4Kb7x0rMbvcuvhVuqFy2Pwa1bZKcSjlyp+xaHaEE2gUKGF2pcmTO7RUvjM6l01wtppst3AATk8hzr1rkRR3KDFmeSDFb03ghkT0p8nWhE5esrhqKJqOHHIuCTdR0I0i5p5sZMh/FYHRCspfOQI6GslwGzFTb0sb1N+CKeu99QlwSWxUK5mIPPh75VoKP3Bdn5Xxtf8yN5YXZOjWUEtxH+iqw2wRMY8MPg+azDZxRt/vuhedBiTEvgUw7sKMHdtuEdnNKr+p0s6Ot3yGuMU9IoUHr8NcWBJpe77mS3sGixhosAfyet468rnPeogrUBstXhuD1/lHEcmlta/BPGdQk7lXZG3Qh3pBYirlyIAqv5oh23AyIKALR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(33656002)(55016003)(316002)(66946007)(110136005)(64756008)(76116006)(66556008)(66476007)(66446008)(86362001)(38070700009)(38100700002)(122000001)(83380400001)(26005)(66574015)(71200400001)(9686003)(6506007)(7696005)(8936002)(2906002)(478600001)(41300700001)(5660300002)(8676002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEhyT3ZGWG96UEM2QlhPNGdBMmZlVkRoeUdxdFR5TjNTOXRDckJ6U2p2SE5V?=
 =?utf-8?B?bXJ3MWRGVWdYdnBkd1QwcGptOGlyMVFpTTJZeFhZZTc2MEViLzh6L2lYRFly?=
 =?utf-8?B?U2xpVDlDM0FBOE9iU0l5cG1ZaTBPM0IyTENUangyeFE2WEZtalRReEF5TzlJ?=
 =?utf-8?B?c1JaMnZETWp0QUlJb2d2VkM4akgvc1lUY2lnajhMcUtLbi9sd1dnalozNDk1?=
 =?utf-8?B?cmRxZ1RQU3gwbDVKR3RJZUJsNUZ2S042WWRSZGY4eEF2ZTJLSENEckFBWmJP?=
 =?utf-8?B?b2FuNzB2NnRWNFJvd2t2T1JudGZTVFhBZjZLamtUaXJpSXVaZ3dHenBUN3BJ?=
 =?utf-8?B?U2Ryc2lxdkRscFN0c0l6Y2NyWnpJRnRsWlBPeGkva0lQOEpsK2hTTG96aUFB?=
 =?utf-8?B?V1NXNE02Y0FrNkgwczZzS2VoOGRrS3BBNmZKYS9jaXFXdDFyMVhvc256YUs1?=
 =?utf-8?B?QW1ibFZFeFNXY0Z3UE9tSm1meXBqS0NKL2gydVVJNklBZG0wZHkwdkdYNTZn?=
 =?utf-8?B?SXpUWWtyTDREVEJTK0RDbExRTVM0ZUtKM1YxdktlbWtrMFZZS3llVkZERk4v?=
 =?utf-8?B?SmxhUDUvUmZGenNobmloQUNSc1h0bnI5c091VWdGK3R2Tm1JY0lYZ0JFai81?=
 =?utf-8?B?OGUrSG9NVjdaSmN3REdYNDNPcnE5S3dVY0hCQngyanBPU1RWMEZ1b1dCcjNW?=
 =?utf-8?B?ZTFkNUVxM0htWXNHTG8vSnZEZldES2FwVTMzNDVjUDBHZnhLT09qSHlZY1Ru?=
 =?utf-8?B?ZEdpM21rR2JOSEhEV0ZWUzVkT29EZWkrOFByYTRra0t5WFQ5bk1FRVVvUUVM?=
 =?utf-8?B?VitsZ3FCVzYxTHdDRGpiM1VwTTVWRHpOZWEwT0tjSjJqMzJ0c25xNWY3S09t?=
 =?utf-8?B?RkRlbFdMN2tOVDkzcjJncUlEVmJxMFpPQVZGMVp1VHZiR1Brblo5Mll1cWdK?=
 =?utf-8?B?amtxNFUyZmxidVZKS2tZM2F0R0ZwNk1XS1I1Umh1MWs2L1pPTENubTQ1QjU5?=
 =?utf-8?B?T25HZ1B4a1czc1M1Wjk4Ujl3Y3MrY3oxdlRXZTRiTHlVdDQ1aWljSms0Wk9J?=
 =?utf-8?B?YWw5UlczNGw0dXRFSndydnRVYmQ2UDhOYUFTTXJWNSt1am1takYvYnBhR3FP?=
 =?utf-8?B?UEo5d1lUaHJXcU1FRzJXSkduSndNbSs2ejlkb1ByNHNBTlN5VW1CUUNENzVS?=
 =?utf-8?B?R2ZEeC83TkF2TXFZYVhsWUxqbGZNdDJMVVA4R05sSXp3RHFTekVCZ3dkVGNC?=
 =?utf-8?B?WVp2WFFwelRvQm96R05rWlArc3ErbTB6MlNIWXNQTk5mQS9QNENLT1VocFdT?=
 =?utf-8?B?Y0lFTXo3Z3YwaDliSi9kcUVad2tLTTBGejMxQURBNDV5d0Fic3UwRFVQUGRi?=
 =?utf-8?B?eDh3S1JCZEJoWEdKQVBsSDM4K1RMc1p5S0YvMG84eVJuYTJjbVN1V3B4dzdJ?=
 =?utf-8?B?OWN3NE1KMElpVnB5Sm90aVN5enl2NVF3a29qK0YyTlBlVDhVT1pIdHh0SFVk?=
 =?utf-8?B?RVFKcStKMjFLd2hjNDhHd3NVMW9IcGI4WHFVc1dHYWVPU0JVa3o3ZldodFU3?=
 =?utf-8?B?eHJrUG0zWGVPZTFOc1RhSmJGVk0vdW1tMThhcUtnVm1zRDc1Mkh6NExHQnhI?=
 =?utf-8?B?YWJxM0lkNUNrUVJMVXpNSmM1Nks3V1ZuV0RtVGN2b1dmdzFFSkdMUHEyblVs?=
 =?utf-8?B?N2FvVFJ4dE9zT0RYTXJ6L3RJc3pJUU9UMHRNM0gyVUxTWHp3ZGNTSzdXRzBY?=
 =?utf-8?B?cWpXODhabUNOUFFjNzZZa2Z5WXN5aHVGYU45NklNYnJBRzNhdjhvRVczU3lp?=
 =?utf-8?B?SnE5THcvc3hqdFZrZ09UTVl4dFMxalF6NlhuVzlITXl3SzBNd3B1VUg0RjJv?=
 =?utf-8?B?R3VGQjQ0QVJselpDT0dZRnhhQXJCQVZFL2lVZjhOeEN6bmJpVW5PVGlRTlln?=
 =?utf-8?B?Z3N0ejR5b3JQVm5HNlM5OGwzVG1FVWp3MlFOTm9iN045Zk1HNGVRY25pYVZL?=
 =?utf-8?B?SlA5RVlSR0VJemFKUElnV3dlZkpHeUhwMG1QTE5mMFRrVGw0NHJ2TFh5b0dk?=
 =?utf-8?B?UVBqYklaNGFicTdDQi90SWhlaVQ4bFRxKzBuTVAvcHkrcXFpa005NUdyREtQ?=
 =?utf-8?Q?XahA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e99aeb-dfc3-44b9-6c3d-08dbd14f1b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 09:29:49.4037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8IOSAJN4L6w9MSpP43LciyO6CkqcmTxT+F3/wh6sfgBVsUMAQvrdh1Mzp6ylGkM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCk9rLCB3aWxsIHNlbmQgdGhpcyBh
cyB0aGUgZmlyc3QuDQoNCkVtaWx5IERlbmcNCkJlc3QgV2lzaGVzDQoNCj4tLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPg0KPlNlbnQ6IEZyaWRheSwgT2N0b2JlciAyMCwgMjAyMyAzOjMwIFBN
DQo+VG86IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBoYW5k
bGUgdGhlIHJldHVybiBmb3Igc3luYyB3YWl0DQo+DQo+QW0gMjAuMTAuMjMgdW0gMDg6MTMgc2No
cmllYiBFbWlseSBEZW5nOg0KPg0KPllvdSBuZWVkIGEgcGF0Y2ggZGVzY3JpcHRpb24gYW5kIHRo
aXMgcGF0Y2ggaGVyZSBuZWVkcyB0byBjb21lIGZpcnN0IGFuZCBub3QNCj5zZWNvbmQuDQo+DQo+
Q2hyaXN0aWFuLg0KPg0KPj4gU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0Bh
bWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYyB8IDkgKysrKysrLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9tZXMuYyAgICAgICAgICB8IDYgKysrKystDQo+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+PiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4gaW5kZXgg
NTRmMzFhNDIwMjI5Li4zMDExYzE5MWQ3ZGQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4gQEAgLTI2NjgsNyArMjY2
OCw3IEBAIHN0YXRpYyBpbnQgdmFsaWRhdGVfaW52YWxpZF91c2VyX3BhZ2VzKHN0cnVjdA0KPj4g
YW1ka2ZkX3Byb2Nlc3NfaW5mbyAqcHJvY2Vzc19pbmZvKQ0KPj4NCj4+ICAgdW5yZXNlcnZlX291
dDoNCj4+ICAgICAgdHRtX2V1X2JhY2tvZmZfcmVzZXJ2YXRpb24oJnRpY2tldCwgJnJlc3ZfbGlz
dCk7DQo+PiAtICAgIGFtZGdwdV9zeW5jX3dhaXQoJnN5bmMsIGZhbHNlKTsNCj4+ICsgICAgcmV0
ID0gYW1kZ3B1X3N5bmNfd2FpdCgmc3luYywgZmFsc2UpOw0KPj4gICAgICBhbWRncHVfc3luY19m
cmVlKCZzeW5jKTsNCj4+ICAgb3V0X2ZyZWU6DQo+PiAgICAgIGtmcmVlKHBkX2JvX2xpc3RfZW50
cmllcyk7DQo+PiBAQCAtMjkzOSw4ICsyOTM5LDExIEBAIGludA0KPmFtZGdwdV9hbWRrZmRfZ3B1
dm1fcmVzdG9yZV9wcm9jZXNzX2Jvcyh2b2lkICppbmZvLCBzdHJ1Y3QgZG1hX2ZlbmNlDQo+Kipl
ZikNCj4+ICAgICAgfQ0KPj4NCj4+ICAgICAgLyogV2FpdCBmb3IgdmFsaWRhdGUgYW5kIFBUIHVw
ZGF0ZXMgdG8gZmluaXNoICovDQo+PiAtICAgIGFtZGdwdV9zeW5jX3dhaXQoJnN5bmNfb2JqLCBm
YWxzZSk7DQo+PiAtDQo+PiArICAgIHJldCA9IGFtZGdwdV9zeW5jX3dhaXQoJnN5bmNfb2JqLCBm
YWxzZSk7DQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgICAgICBwcl9lcnIoIkZhaWxl
ZCB0byB3YWl0IGZvciB2YWxpZGF0ZSBhbmQgUFQgdXBkYXRlcyB0byBmaW5pc2hcbiIpOw0KPj4g
KyAgICAgICAgICAgIGdvdG8gdmFsaWRhdGVfbWFwX2ZhaWw7DQo+PiArICAgIH0NCj4+ICAgICAg
LyogUmVsZWFzZSBvbGQgZXZpY3Rpb24gZmVuY2UgYW5kIGNyZWF0ZSBuZXcgb25lLCBiZWNhdXNl
IGZlbmNlIG9ubHkNCj4+ICAgICAgICogZ29lcyBmcm9tIHVuc2lnbmFsZWQgdG8gc2lnbmFsZWQs
IGZlbmNlIGNhbm5vdCBiZSByZXVzZWQuDQo+PiAgICAgICAqIFVzZSBjb250ZXh0IGFuZCBtbSBm
cm9tIHRoZSBvbGQgZmVuY2UuDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X21lcy5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9tZXMuYw0KPj4gaW5kZXggNzBmZTNiMzljMDA0Li5hNjMxMzkyNzc1ODMgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmMNCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuYw0KPj4gQEAgLTExNTMsNyArMTE1
MywxMSBAQCBpbnQgYW1kZ3B1X21lc19jdHhfbWFwX21ldGFfZGF0YShzdHJ1Y3QNCj5hbWRncHVf
ZGV2aWNlICphZGV2LA0KPj4gICAgICB9DQo+PiAgICAgIGFtZGdwdV9zeW5jX2ZlbmNlKCZzeW5j
LCB2bS0+bGFzdF91cGRhdGUpOw0KPj4NCj4+IC0gICAgYW1kZ3B1X3N5bmNfd2FpdCgmc3luYywg
ZmFsc2UpOw0KPj4gKyAgICByID0gYW1kZ3B1X3N5bmNfd2FpdCgmc3luYywgZmFsc2UpOw0KPj4g
KyAgICBpZiAocikgew0KPj4gKyAgICAgICAgICAgIERSTV9FUlJPUigiZmFpbGVkIHRvIHdhaXQg
c3luY1xuIik7DQo+PiArICAgICAgICAgICAgZ290byBlcnJvcjsNCj4+ICsgICAgfQ0KPj4gICAg
ICB0dG1fZXVfYmFja29mZl9yZXNlcnZhdGlvbigmdGlja2V0LCAmbGlzdCk7DQo+Pg0KPj4gICAg
ICBhbWRncHVfc3luY19mcmVlKCZzeW5jKTsNCg0K
