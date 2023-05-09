Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5F9C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 05:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EAAC10E1AE;
	Tue,  9 May 2023 05:17:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319EF10E1AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 05:17:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpeMVQ/Vv5qbGuObOXMhmw21uyK7Fu9EGEverIGKUrmHozDN3l8ns/2CycIajGPNhg21PpJ+LiT9ZOuZYnp/YToN8Vd4X51j4CpN3E++Ug5Cc3lorQSH+QQMpb4HAn6npD6yPgOXn3yNq0rGq4jLg83PzA1W3nYmO5k1Xzj3YMlVoIuRqtgJh72nEPvkaCTUjuxEFb9KvfLWw22ZuGHXQ0sDD0Zpwhoq1qmHLOkehsEkW1ClXRh/lDGjhjvty/P0vYA2pCuh111oQghGfu9IvinPxbx+IFoXGrrtBHavVEj5znEN7XhiBBjeWme5qKrFDq/fc87o4NgMRrbBMtSnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEpo+Sw1kVU4+hdPoi6MqAJZ+5nBuTLAosOfh3ZrPts=;
 b=JF2+NStXKqfaOv54yy/O9I2fYJ9gV6O7Ck3LFpf+0ux5a7RTOuvr36l9ed5cr1VpvpnDyIRwC6hdghOO0NNLOe9pbC7TnBWucscXSiUVphabXPdrYrQ/airLTetn3FnG0f3h7brTWuiLf1L+ZM1KhhAQuHdFOvVx0tC/Cyw1opM/W+NSf9/xvA4k7AjOfqFqHKmD5yHt0vIthX/5MMvQge5+4l4kMO/sZkA1ih2Y2i74StLAtGanKi4bZ598Z25KGSx8XLeyJIUrJAHAh+4WQVJ5oD+W7opwfTbmMMftJh4jW+Z3yXvAXcK6nMjvGt0MCqNJbmJpzT1salqRNmTmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEpo+Sw1kVU4+hdPoi6MqAJZ+5nBuTLAosOfh3ZrPts=;
 b=kbepkfMDxKCpAO4YFpaCe6I4LMlsc2tjnd94elg2an9K8sKvRKl4QvZdUqdlt/9zON3ieJzv2gq7BbprqvDFyw2vAsyOpVuHlAXHd4cRTtPREue9pxHLgWMZzozaiynyTDu8TVFyYIbQE3AVrbK0viBgqlUU2PUuAuFThmyjjnA=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 05:16:57 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::8610:26b0:7f08:6613]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::8610:26b0:7f08:6613%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 05:16:57 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Remove redundant else branch in
 amdgpu_encoders.c
Thread-Topic: [PATCH] drm/amd/amdgpu: Remove redundant else branch in
 amdgpu_encoders.c
Thread-Index: AQHZgcHtF6F57Ybf/k24YLD+3QyGKa9Qh+OAgADedGA=
Date: Tue, 9 May 2023 05:16:57 +0000
Message-ID: <MN2PR12MB41289C3850B0CEF7E2D0687390769@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230508152929.1114091-1-srinivasan.shanmugam@amd.com>
 <CADnq5_OfvZbUCiiOw1CHs2DkfjnmTwWedvDvnVgZUif7NBtUyg@mail.gmail.com>
In-Reply-To: <CADnq5_OfvZbUCiiOw1CHs2DkfjnmTwWedvDvnVgZUif7NBtUyg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-09T05:16:54Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5e94cef3-fb3d-43bc-813a-d29fc14edf48;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|SJ2PR12MB8111:EE_
x-ms-office365-filtering-correlation-id: f8a641eb-ca57-4ad4-c856-08db504c9c2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O8lyRnfvnmB4Gz6vNwHOIvjbSQtf3+MJde4NIGwXXd6XzrYWAALMP2cFqhh+LgV6Nzw27M5kVi+qo8tiUzb/Uq/9kEOAvsNnSvav0/+f754NN+vG04V4YQjUkpGQkhEbuztEG/gwD+AuFkUK+D8m6wp4FcVc43ZF5ypa9Q1DuEzoFjBV1mHyhKuimz4EGWv91sVggaE+HwYm0cb6IK9lofiornPx7HKP8632U32qXfRckl4zfYNvGNkhmRJBa/FVhFG2uCb1J2ICKfSHhYetm2QPpk7RNGkMSOO8oKGcIuQtuEtrMyg3sRjsAao0W2ZlnnLaVLbuhRJJIsAGDUx/ntwEtwdKbc/gQCJLJvdAHUsyS71xTPRkCkmOXlYzUwVu07K/wEFml4LyXOklqHwclmaEualjx7zFMwToLtJI5s3vp9piLDX3EEE3A6bhsngck1vqcCSQ/qZ4+yW10W/xfoCiS7MT5miMRe2YcmS0Mqqg5TkY54FA6hyWCAi1b5lawVO+q8cqOs+bVebYQ/wWZwhvjeqLY+Qi27Jx4T3teQESsEYo7vKSDL+mx1SyKJ44ToB1rkqPvrCbwrZAhwnXhsaCvOVpgscvduazx865xYrZDKY6jyKWVXmfzxCbluHP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199021)(66556008)(66446008)(64756008)(6916009)(4326008)(316002)(478600001)(76116006)(7696005)(66946007)(54906003)(66476007)(86362001)(53546011)(33656002)(66574015)(83380400001)(55236004)(6506007)(26005)(9686003)(52536014)(2906002)(71200400001)(5660300002)(41300700001)(8936002)(8676002)(55016003)(38100700002)(122000001)(38070700005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFZEL0srMEV6OUkrSGFNWkVWMVFFcHg2VmxTdUQrWlM2TmxGSC9SNzhEdDg3?=
 =?utf-8?B?ckZKZTFWeVEvWVVxOGVKV0c1eWx0MWJxYW15T28vYy9pTSsxUFJnRjFlSEdI?=
 =?utf-8?B?WmlxcWw2KzFvdkpvRWxRTXY1bEh5aDFNU1VqQmhURzNWN0Noc0hacXViNFgw?=
 =?utf-8?B?Y05NWWtldEo4ZE40c2xqT3RCSDdsL3dwRVgyUkZYSzByYzJDclpMaWRsQmh2?=
 =?utf-8?B?SEZyWlRRSnJSQmd1cDFRc2crbkRKVXB3N1Rpc0FNYXVWTUZSaHc3V1hUa21J?=
 =?utf-8?B?eU5tUytDMFYwTGVKK1JWMkdZcm9oSU1wSm9pUml1WC9iOGxXNnlScGxobFZm?=
 =?utf-8?B?dk0vRzdjRUpqeGR4cUgvZ1hCYys1bkFxVzc4Ui9vNVNVTWlNdWtzSFRPSUxW?=
 =?utf-8?B?MndKUkVCYUEzQTRLSGh4bytiSUNvL05tTW5ESkhybmxIVjd6RVRmV0lqQnJk?=
 =?utf-8?B?ZVB4YVpiS0E3NHRPcHduU2VHUERRQ2lMcXRwYlRJT21EWW9oM2ZudE84ek1q?=
 =?utf-8?B?UzA5b0ZOeUZSTGhUZ2RXYnpZRnlGeThadjM4SHh6WlBYdUdrZWVXcm1oNE5p?=
 =?utf-8?B?NURiMXdnZ2E4ZERDZDdWbk5nZzRmSmdhcTc0dFR3S0ozVFFlQ1dNbzdMSGpD?=
 =?utf-8?B?c2dQTTBZcTYvMU5BNWtDWEdmaWlUVlpmYUsyQnlOaStVRTRHSXNXNEd0Qllv?=
 =?utf-8?B?cG5QbExCSmdrV0tNbFp0THE0V3NCN2xZYXBhV1dkcmhETkRlVkxFY0ZER2ZK?=
 =?utf-8?B?MTVlZWZHZW1ERjVGbUdGeG1QLzF4QzdZTmkzQ2EwU0NpRm0zK3dHTVZBclpz?=
 =?utf-8?B?SnlrQnFSWTE3SlYyT1RraVJoQytlWlhmWWxhQWtESEtKOTlMUnhHKzUxUENz?=
 =?utf-8?B?U0Z5VXRsbEZpdk9xVWtJdFVER2FNOUwzU2xBV2w5bm1aUE1td2lHczFMMExi?=
 =?utf-8?B?VFNzUktSYlljYUk0ZmEzVzJiM3VYcVhGYS8rY1RSYzFTYVgyYkZZQXhSdzR1?=
 =?utf-8?B?V0RRT3lGVGtLWG9ML3phdFdIcFdvNjdiV0c4TlFmQ1lucVFwaVVIb3lXbXl0?=
 =?utf-8?B?eXJ3bCt4MVhSb2pwNDQ3YnJQcGwzRW9Qb0dwSU1GUktCdjRzcldVMHJ0VWpw?=
 =?utf-8?B?ZVdHLzlXalIzMVZMM2FHamV5aThveUpWVmlqRC9vTVFrM0RnRFdENUc1eEw4?=
 =?utf-8?B?QkJrdkxoVllaaVM1MEpTY2d1TFFOMFQ2RW4rVVNYTEJvYVA3c1g5aGd6V05W?=
 =?utf-8?B?bUZYL3VSZC91aUw4Q2lWNGxOMUhXbzVaZktjdm5qMWxTSlhUS05oZGQ2T0xy?=
 =?utf-8?B?Vis5L0dEZFpZbktGc3lVSWQ4ZEZwV1RBUDZ6Q211NVQ2bEl6NzVUd2lXQS8v?=
 =?utf-8?B?WUhXY1p1cjhDSzJuK2U0M3VXS0IzY2tvT1lyS2hlWHlibnVXRUlDTW1vRy94?=
 =?utf-8?B?NjczSDhGVTYzQ0xVUmZDdG9acGc4Z3cvTmdhN2krVm5oOEN6YzBCZkg5MmNO?=
 =?utf-8?B?S1Fqd3c1c2tmNlFIR0NhR1lzYlYvSi9IS0pzUUJDME9ab3ZaL2w2RlRuZTZz?=
 =?utf-8?B?OUhyYWlHU0RIK2FRckp0aEhhLzA2LzVUaklYZlJ5eDNPS0ljUHBkell5akdl?=
 =?utf-8?B?WmpLcVNzM3RyT3pxem5wODA5R3dYQnRsN0xRWUNhMVNDZ0xRcTdZRGxzNE1G?=
 =?utf-8?B?RUhvWHBZN0htU1N5M2ZKT3JHdGIvT2JiSzQwdmI2cklyS3lRRUs2bWsrdTBD?=
 =?utf-8?B?TG82eWlyT3UvbFhaSll2ajZlVUg3RzBZcjdlbFFoY1VnVVcyTFU2ZklsMUs3?=
 =?utf-8?B?cTVNZTYyUjRSRGZkN0wwUWt3QkZLanZQbkZlZzBWUmVsbzByV1pSMVZZeksz?=
 =?utf-8?B?WFd4UjBUUjlwdUtYd0grclEzY2pBUHRPZzhBS1g2MXkxdXFnVk05UEFieEpx?=
 =?utf-8?B?VU42c3B1SWhJd1k3ckFDY0M3RGliSG00YVJmRWJSa3M4OXVCOUZuQ1NkeU5E?=
 =?utf-8?B?N1dra21BN0FuS2xqZU5EQmZXaVBHZmgxZzIyWC9tWHlVUlBoZ29EVmZaRUkw?=
 =?utf-8?B?U0FtVTQrVm9Cdm1ndmdINDNNekFkdzZNRnhCSjNrV2RUQitkbHpXbnhxSndI?=
 =?utf-8?Q?+t0k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a641eb-ca57-4ad4-c856-08db504c9c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 05:16:57.0790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGOhfPJf/jdBwQTCZxSoFGjS/ejPcuE07HcduxdRh0Zf+MZru2C7VUHH/Q5BdQX+/PZscOkOOYxE956k5DAvSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IA0K
U2VudDogTW9uZGF5LCBNYXkgOCwgMjAyMyA5OjI3IFBNDQpUbzogU0hBTk1VR0FNLCBTUklOSVZB
U0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KQ2M6IEtvZW5pZywgQ2hyaXN0aWFu
IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZC9hbWRncHU6IFJlbW92ZSByZWR1bmRhbnQgZWxzZSBicmFu
Y2ggaW4gYW1kZ3B1X2VuY29kZXJzLmMNCg0KT24gTW9uLCBNYXkgOCwgMjAyMyBhdCAxMToyOeKA
r0FNIFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPiB3
cm90ZToNCj4NCj4gQWRoZXJlIHRvIExpbnV4IGtlcm5lbCBjb2Rpbmcgc3R5bGUuDQo+DQo+IFJl
cG9ydGVkIGJ5IGNoZWNrcGF0Y2g6DQo+DQo+IFdBUk5JTkc6IGVsc2UgaXMgbm90IGdlbmVyYWxs
eSB1c2VmdWwgYWZ0ZXIgYSBicmVhayBvciByZXR1cm4NCj4NCg0KV2hhdCBhYm91dCB0aGUgZWxz
ZSBpbiB0aGUgcHJldmlvdXMgY2FzZSBzdGF0ZW1lbnQ/DQoNCkFsZXgNCg0KSGkgQWxleCwNCg0K
VGhhbmtzIGEgbG90IGZvciB5b3VyIGZlZWRiYWNrcywNCg0KdGhlIGVsc2UgaW4gdGhlIHByZXZp
b3VzIGNhc2UgaWUuLCBpcyBiaW5kZWQgdG8gaWYgc3RhdGVtZW50IGllLiwgImlmIChhbWRncHVf
Y29ubmVjdG9yLT51c2VfZGlnaXRhbCkgeyIsIGFtIEkgY29ycmVjdCBwbGVhc2U/LCBwbGVhc2Ug
Y29ycmVjdCBtZSwgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyB3cm9uZz8gJiB0aGUgYmVzdCBzb2x1
dGlvbiB3aXRoIHlvdXIgdGlwcyBwbHMsIHNvIHRoYXQgSSBjYW4gZWRpdCAmIHJlc2VuZCB0aGUg
cGF0Y2ggcGxlYXNlPw0KDQpNdWNoIGFwcHJlY2lhdGUgZm9yIHlvdXIgaGVscCBpbiBhZHZhbmNl
LA0KDQo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+
IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9lbmNvZGVycy5j
IHwgMjYgDQo+ICsrKysrKysrKystLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5z
ZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZW5jb2RlcnMuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZW5jb2RlcnMuYw0KPiBpbmRleCBjOTZlNDU4ZWQwODguLjA0OWU5
OTc2ZmYzNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2VuY29kZXJzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Vu
Y29kZXJzLmMNCj4gQEAgLTI0MiwxOSArMjQyLDE4IEBAIGJvb2wgYW1kZ3B1X2RpZ19tb25pdG9y
X2lzX2R1YWxsaW5rKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwNCj4gICAgICAgICAgICAg
ICAgIGlmICgoZGlnX2Nvbm5lY3Rvci0+ZHBfc2lua190eXBlID09IENPTk5FQ1RPUl9PQkpFQ1Rf
SURfRElTUExBWVBPUlQpIHx8DQo+ICAgICAgICAgICAgICAgICAgICAgKGRpZ19jb25uZWN0b3It
PmRwX3NpbmtfdHlwZSA9PSBDT05ORUNUT1JfT0JKRUNUX0lEX2VEUCkpDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gLSAgICAgICAgICAgICAgIGVsc2Ugew0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICAvKiBIRE1JIDEuMyBzdXBwb3J0cyB1cCB0byAzNDAgTWh6
IG92ZXIgc2luZ2xlIGxpbmsgKi8NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKGNvbm5l
Y3Rvci0+ZGlzcGxheV9pbmZvLmlzX2hkbWkpIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpZiAocGl4ZWxfY2xvY2sgPiAzNDAwMDApDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBlbHNlDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gZmFsc2U7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHBpeGVsX2Nsb2NrID4gMTY1MDAwKQ0K
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgICAgICAgIC8qIEhETUkgMS4zIHN1cHBvcnRzIHVw
IHRvIDM0MCBNaHogb3ZlciBzaW5nbGUgbGluayAqLw0KPiArICAgICAgICAgICAgICAgaWYgKGNv
bm5lY3Rvci0+ZGlzcGxheV9pbmZvLmlzX2hkbWkpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKHBpeGVsX2Nsb2NrID4gMzQwMDAwKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiB0cnVlOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBlbHNlDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgICAgICAg
ICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHBpeGVsX2Nsb2Nr
ID4gMTY1MDAwKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiB0cnVl
Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAg
IGRlZmF1bHQ6DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+IC0tDQo+IDIuMjUu
MQ0KPg0K
