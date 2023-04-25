Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB20C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 06:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C73410E693;
	Tue, 25 Apr 2023 06:32:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B0210E693
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 06:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnQ8nJ04ll4JIEskd+9MW3u2YM/jMfCkeyp2GGuWHpDZhO0cx0oUMB+PgFR2xXC/r12IWKo5qIXGfirfvEgsP+kij2w49oISXBzm3RAbI3spCPthefaYqMfc9kt44eqY0yU1maRvrrJlwh2NakLUzNxbHOfUnKwYQjNyXjcMmUX046rVLpCaQs49kk2Yc+uF6Epg43/neQr8Rl3pz28IGor5jzm+RgUpEY0dtNozMvLeAy03+n1pGK22nBotOKgDNbT4bBdovEvov353WqbClufQcUFBdMk+cqckS1lYpjOb0WJAHfSgG3gR6Dm81//iovqCKBURa1nunGDDBUoDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlsGSW4t9jg4bJzNbwA3sq1phhHn8MPPe/YruyYzxEc=;
 b=EX8uqJffoRuq8PULx7//onsmUtanaDHjxN8MmzXjK0CJyhW8DemhwzWj2SbjJDgLMz8WsOupL2/6jiwEyl715en0AJgQ+hd96PFuP4zVgG2qd/0RDagwqFqMV9ZgQa2opCscycnciwdq4nyvZe+1NA5o0S3ydj/ElglR2T46qm+i0crRvjVkCSRuvZ1T/FmIMmZwc83DnULbSAs8I7ZG3162s3ji4yCCVZW+EpCJQ65pfIKCwVycy0VIHFh1FCm2xp41iJYd7XHxDSvZ4HOGlY6B5vdIfI99zv7rTFcQv0rl9a5e9MPJqOVYPsuCxuNOxhLov63LReB/IYm9Gw389g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlsGSW4t9jg4bJzNbwA3sq1phhHn8MPPe/YruyYzxEc=;
 b=ebCnPhhx9nYRQMS/kr5g0inXbuYjeYEyTi1jhGtyrnFXCxm3+YVL+z5qLUZ0OfnsiHPQrP065CsHiP5ZnOzO3VWLIKMBObSCaUgxcFrCNZ/gZracgl5UW3OBMBoerYYFZ3sNd1cCZjQk3fmXF4VhGhr/J06sTOEE/Fg3Ld9Z8Go=
Received: from SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 06:32:19 +0000
Received: from SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::2312:a262:5631:369f]) by SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::2312:a262:5631:369f%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 06:32:18 +0000
From: "Zhang, Horatio" <Hongkun.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix amdgpu_irq_enabled warning in gfx and gmc
 hw_fini
Thread-Topic: [PATCH] drm/amdgpu: fix amdgpu_irq_enabled warning in gfx and
 gmc hw_fini
Thread-Index: AQHZdpjETijCHdUyH0eNvq6G6SEYdq86R9iAgAFDgOA=
Date: Tue, 25 Apr 2023 06:32:18 +0000
Message-ID: <SN1PR12MB2591A1F57BB9CBA5F3FBD5F3F7649@SN1PR12MB2591.namprd12.prod.outlook.com>
References: <20230424103721.9787-1-Hongkun.Zhang@amd.com>
 <8d68b478-686e-0b77-4344-944b98fd63f5@gmail.com>
In-Reply-To: <8d68b478-686e-0b77-4344-944b98fd63f5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-25T06:32:14Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e0c1b25b-cf2d-4183-9df5-53d76f4cddae;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-25T06:32:14Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: afecf16b-c43a-4949-b0f2-a2a1879843c6
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2591:EE_|SJ0PR12MB7067:EE_
x-ms-office365-filtering-correlation-id: 21567097-df0f-4056-f25c-08db4556d180
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z/BXfLc6RGWy6vpYPQ+XyeVIQJn1YIPTp1rRtiN70qzkTa9z0OpqC7Na7RTUTF2fsHozKxpoI65SfuhR4w0P3cFz53wAmKNp014KNSqw5i2thDh2+4ml6AOjZjwXBr/7N827i1aCqhXXXDqjt0Kfuh0pXObLHGM5hbvFBZxycjsj+kgje5hak5KzDi/X+Pg5egUi5+vkKDmrzIIMv5ENbI7ASQsgvkxCUsjh09E6G6yaq5s54a02PRGo1IORdGt7OkgvEfsuFwmWS6cVqTlTpu7gt/HMLzgRXqDMo4BRWVyxtLpD5cHQkhGq+alQoCjfPFX+naZz+3g+Yqrt2GOsSSBieZVoK2W9qTZl0CReB7PJMwCBFIitNHHRMUjnkndaX0yMXAeTacEyVZze5cHuLCsO1TNDjDNhO3mb7fvWxGMgPa68zhnXTr+PoDbI2MRd95bchHwfSbWXGmasMi4SFUMNPrGb8PvUdyI07B2D4fTtDnHDyPlqQd8j8kxB8+c7B9hJ02jrYdq64fF8xxjWt+dfdLrTLx4e72wjE51uUpkiLuZ4ulEGneO/KyqR0gXRi5Z/Mf7ITP4l5Ny/cb6CUVu02Jw/AEvux6zPqnw1owi/vowrGat5Wm0Cc+kRGH+3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2591.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(9686003)(53546011)(6506007)(26005)(38070700005)(55016003)(83380400001)(66574015)(186003)(122000001)(38100700002)(66946007)(478600001)(76116006)(86362001)(66556008)(66476007)(66446008)(8676002)(8936002)(54906003)(64756008)(110136005)(52536014)(5660300002)(71200400001)(7696005)(41300700001)(2906002)(4326008)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vkx0SGF5QVNDczV0RU9Zdm9sK2tSa0pjUU0va1FDMW5aWFJ2bndxU2xPN0ls?=
 =?utf-8?B?WXJlTEw4bGlhVFk5TU12N1lMZkhVbVFqaDN6WW8vQjFUYWwzSTNSR255a1JB?=
 =?utf-8?B?aUsrVjJWNktFeWNQZVdhYzQ1YTdmdGY5dS9iYmRQemNLUnhDZFhQaHZBWHE3?=
 =?utf-8?B?UFBMNGVsRlVsTDIzM2pVTXczZk1XbW42TDVlVmsrdE9JSW55MTZEbjQ4a1Fq?=
 =?utf-8?B?K0RqZjRyKzB5NHFFSmZZQkFjMjBqTEhsemo2V2g1cU94Zi9KQS9GYm9oZFli?=
 =?utf-8?B?azd4M25Gcmt0b2pYdENRdlIrQUYrTnNyQlBaUU5lbUFqai9qS1NNbE96SWl6?=
 =?utf-8?B?UXdnRjhzYnJ2bWFSbUJrRXVvSFludmxKUHF6QVpOV2ZMSGEvUmhFZFU5RUxm?=
 =?utf-8?B?RWR6Zm1DamFWbGpaM0FiazVYQldIVGVvMWxZdnU1aHcvblZ6RVp6YmRIYkhu?=
 =?utf-8?B?akxsaDNVbGQvMmlPKzNZQWJnQjZnVlVudk9sdzl4L1BnZUQxT2htTmNQa1dD?=
 =?utf-8?B?bWdFd3J5K2JiSktJMHRydlVtRXhlV1pETHNoZjlXRXF6a0tFcmVGSFVlVFAv?=
 =?utf-8?B?QnpTK2RlckhYcElQbUFWUS9vTjFKWlRobXh3VnBUa2VQUzFYWjRUZ3pHWnFE?=
 =?utf-8?B?ZGpUeHJ2SHRXbGU5WURxZDhxblZXWm1hNndXZTJCWU01M3BmNWxGdGo2b091?=
 =?utf-8?B?NWhKemJGQ1ZCMTVxVncyNlZ0N0IzN3lqZDBXc0NUcWRFZUhhYmdTeTNmb1Fi?=
 =?utf-8?B?UHR3blJxc3Bwb1FRSkg0dExrRHRnalFMeFhNUVpTVFpkTkVoanUzenBsaXY4?=
 =?utf-8?B?K1lmZE5UU1ppSmUwbGhKUkQyUUF1UnpDNmR0bUFtam5sY1RmcEVhYWkxVDdQ?=
 =?utf-8?B?enRacTFENnBLNnpzSWU0b1Bwc2UvM296YzNvR2ZmWUN6Z0NGc2hBTUQ1WTZV?=
 =?utf-8?B?S3dZbVdOWUVCOWNVMFlLMHVudStha2lzemloamxtelBvb2pLZ3BFM3dUZDln?=
 =?utf-8?B?cFJtQ2hyT29HeS9QSjFUU0IwZG5ZNmhNMjNHbWpRd1BXWXhwUE85TFl5WCtH?=
 =?utf-8?B?NVBxMUVjVmYrMTlXZFB2bjBOQjJJWTVSelIwanRSVFg2TUgyaHQrQnBBblRj?=
 =?utf-8?B?THFiRkdTaFo5Tk1ETGxkaXJab0VGcXFJQmhCRWJxYkx0VVV3NFFlYzhVbS85?=
 =?utf-8?B?eFdoTmJEbk4vOFM1Ykd5VUcyYnJWbVkyNE5OejQ1K3cyYjJqYWVkT2FCdjBt?=
 =?utf-8?B?TmR1Rk9tL3hJOGFEZCtvQ25qQ1kyUEFSUU5sa0ZKbXREUW9QaEdyOFRXSVpL?=
 =?utf-8?B?TlFmM0RmVllYY3dXbmVtZ3diRTQ5NnpPeWI0cU5BaHpSVnh2K3NxVmNycWFZ?=
 =?utf-8?B?TmJmWnlDUnk0bWVGUnJJWlhod0NCeE93ejRLY3g4WDR1R2pURjY1ZGJWdU1q?=
 =?utf-8?B?WDRWanZ5b2dzbVpQa2lqNlVqRzdLNEJEdE5NNXNWSzhwYlpzR0tuSTV2bjk1?=
 =?utf-8?B?Ykgwc3FXMnhHdXVnTFYzVG5hVE9CdTVaR0tnYU5BMk9rbU5yRGtWSFl1OC9C?=
 =?utf-8?B?Z1ZXWHc4NFN0ZmxpdGhtb090TjkzOGliaHp4RElpaSs5V1NjVXBCL1gzYXNs?=
 =?utf-8?B?elJqWmRjRkJ2Ty9ybFpQQkM0d1NmcE9MckxEakE1WDB6amc5Z3FXc3NCcnA1?=
 =?utf-8?B?QTh6dEx5eWsrVlkyYUdLc2NtejA4SURIOGp4ZDlLK3hmdk5wcW5BSElqYW95?=
 =?utf-8?B?K3ZwbzhkTzgrdUdZSEZBcXhWcUpLOVlBQnZnYytScnJUU1ZNUGI0WkpTazhr?=
 =?utf-8?B?TEJhTFlaYW95eGVtVUpiengwOEhGUU94a01DSWVGMjRoaGgwNHYrUE82ZXQy?=
 =?utf-8?B?ZGpXOEZ5VDN3WVZWZFRZbU1YZEQxV3VPZGM2SzkzS1ByVTZZN3FKOE1XNXJp?=
 =?utf-8?B?VWtzRUI3ZGdlanpWSEo3Z04zV1Z4TWJ6aUlBcnEvNTdPNjVzNTMvSUsrYjRO?=
 =?utf-8?B?aUJDVU1PTnQ2UVdWT3pEbU4zUndMVEx5ZmwvMHpoYUcyY3FaaEpsY2czdGtv?=
 =?utf-8?B?cS9RRlJ6S3FLYWkyRkxFRWVwODRCSUlZZUtzMWRWaDFkTTFWUmI5Y1h1RXdx?=
 =?utf-8?Q?fPKE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2591.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21567097-df0f-4056-f25c-08db4556d180
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 06:32:18.7361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cxC4HQTJX6sJxjC5cW8CfOs0Gq/N4rYmsASm1SdBgZGyUcjUdfTRzGdXKPOOhK6GgIN98qbkmCQYrGWM9LJeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
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
Cc: "Yao, Longlong" <Longlong.Yao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbiwNCg0KVGhh
bmsgeW91IGZvciBzdWNoIGEgcXVpY2sgcmV2aWV3LiANCkl0IHNlZW1zIHRoYXQgdGhlIGdmeF92
MTFfMF9jcF9lY2NfZXJyb3JfaXJxX2Z1bmNzIGFuZCBhbWRncHVfaXJxX3B1dChhZGV2LCAmYWRl
di0+Z21jLmVjY19pcnEsIDApIGluIGdtY192MTFfMF9od19maW5pIGFyZSBub3QgbmVlZGVkIGFu
eW1vcmUuDQpJIHdpbGwgdXBkYXRlIHRoaXMgZml4IGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhl
IHBhdGNoLg0KDQpUaGFua3MsDQpIb3JhdGlvDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNv
bT4gDQpTZW50OiBNb25kYXksIEFwcmlsIDI0LCAyMDIzIDY6NTAgUE0NClRvOiBaaGFuZywgSG9y
YXRpbyA8SG9uZ2t1bi5aaGFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCkNjOiBZYW8sIExvbmdsb25nIDxMb25nbG9uZy5ZYW9AYW1kLmNvbT47IFh1LCBGZWlmZWkg
PEZlaWZlaS5YdUBhbWQuY29tPjsgQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsg
WmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWRncHU6IGZpeCBhbWRncHVfaXJxX2VuYWJsZWQgd2FybmluZyBpbiBnZnggYW5k
IGdtYyBod19maW5pDQoNCkFtIDI0LjA0LjIzIHVtIDEyOjM3IHNjaHJpZWIgSG9yYXRpbyBaaGFu
ZzoNCj4gVGhlIGNhbGwgdHJhY2Ugb2NjdXJyZWQgd2hlbiB0aGUgYW1kZ3B1IGlzIHN1c3BlbmRl
ZCBiZWZvcmUgdGhlIG1vZGUxIA0KPiByZXNldC4gRm9yIHRoZSBJUCBibG9jayB0aGF0IGRvIG5v
dCBzdXBwb3J0IHJhcyBmZWF0dXJlcywgdGhlIHJlbGV2YW50IA0KPiBpbnRlcnJ1cHQgaXMgbm90
IG9wZW5lZCBkdXJpbmcgaW5pdGlhbGl6YXRpb24sIGJ1dCBod19maW5pIGZvcmNlZCB0aGUgDQo+
IGNsb3NlIG9mIHRoaXMgaW50ZXJydXB0LCB3aGljaCByZXN1bHRlZCBpbiBhbWRncHVfaXJxX2Vu
YWJsZWQgY2hlY2sgDQo+IHdhcm5pbmcuMg0KDQpTb3VuZHMgbGlrZSBpdCB3YXMgYSBnb29kIGlk
ZWEgdG8gYWRkIHRoaXMgY2hlY2suDQoNCj4NCj4gWyAgMTAyLjg3Mzk1OF0gQ2FsbCBUcmFjZToN
Cj4gWyAgMTAyLjg3Mzk1OV0gIDxUQVNLPg0KPiBbICAxMDIuODczOTYxXSAgZ2Z4X3YxMV8wX2h3
X2ZpbmkrMHgyMy8weDFlMCBbYW1kZ3B1XSBbICAxMDIuODc0MDE5XSAgDQo+IGdmeF92MTFfMF9z
dXNwZW5kKzB4ZS8weDIwIFthbWRncHVdIFsgIDEwMi44NzQwNzJdICANCj4gYW1kZ3B1X2Rldmlj
ZV9pcF9zdXNwZW5kX3BoYXNlMisweDI0MC8weDQ2MCBbYW1kZ3B1XSBbICAxMDIuODc0MTIyXSAg
DQo+IGFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZCsweDNkLzB4ODAgW2FtZGdwdV0gWyAgMTAyLjg3
NDE3Ml0gIA0KPiBhbWRncHVfZGV2aWNlX3ByZV9hc2ljX3Jlc2V0KzB4ZDkvMHg0OTAgW2FtZGdw
dV0gWyAgMTAyLjg3NDIyM10gIA0KPiBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyLmNvbGQrMHg1
NDgvMHhjZTYgW2FtZGdwdV0gWyAgMTAyLjg3NDMyMV0gIA0KPiBhbWRncHVfZGVidWdmc19yZXNl
dF93b3JrKzB4NGMvMHg3MCBbYW1kZ3B1XSBbICAxMDIuODc0Mzc1XSAgDQo+IHByb2Nlc3Nfb25l
X3dvcmsrMHgyMWYvMHgzZjAgWyAgMTAyLjg3NDM3N10gIHdvcmtlcl90aHJlYWQrMHgyMDAvMHgz
ZTAgDQo+IFsgIDEwMi44NzQzNzhdICA/IHByb2Nlc3Nfb25lX3dvcmsrMHgzZjAvMHgzZjAgWyAg
MTAyLjg3NDM3OV0gIA0KPiBrdGhyZWFkKzB4ZmQvMHgxMzAgWyAgMTAyLjg3NDM4MF0gID8gDQo+
IGt0aHJlYWRfY29tcGxldGVfYW5kX2V4aXQrMHgyMC8weDIwDQo+IFsgIDEwMi44NzQzODFdICBy
ZXRfZnJvbV9mb3JrKzB4MjIvMHgzMA0KPg0KPiBbICAxMDIuOTgwMzAzXSBDYWxsIFRyYWNlOg0K
PiBbICAxMDIuOTgwMzAzXSAgPFRBU0s+DQo+IFsgIDEwMi45ODAzMDRdICBnbWNfdjExXzBfaHdf
ZmluaSsweDU0LzB4OTAgW2FtZGdwdV0gWyAgMTAyLjk4MDM1N10gIA0KPiBnbWNfdjExXzBfc3Vz
cGVuZCsweGUvMHgyMCBbYW1kZ3B1XSBbICAxMDIuOTgwNDA5XSAgDQo+IGFtZGdwdV9kZXZpY2Vf
aXBfc3VzcGVuZF9waGFzZTIrMHgyNDAvMHg0NjAgW2FtZGdwdV0gWyAgMTAyLjk4MDQ1OV0gIA0K
PiBhbWRncHVfZGV2aWNlX2lwX3N1c3BlbmQrMHgzZC8weDgwIFthbWRncHVdIFsgIDEwMi45ODA1
MjBdICANCj4gYW1kZ3B1X2RldmljZV9wcmVfYXNpY19yZXNldCsweGQ5LzB4NDkwIFthbWRncHVd
IFsgIDEwMi45ODA1NzNdICANCj4gYW1kZ3B1X2RldmljZV9ncHVfcmVjb3Zlci5jb2xkKzB4NTQ4
LzB4Y2U2IFthbWRncHVdIFsgIDEwMi45ODA2ODddICANCj4gYW1kZ3B1X2RlYnVnZnNfcmVzZXRf
d29yaysweDRjLzB4NzAgW2FtZGdwdV0gWyAgMTAyLjk4MDc0MF0gIA0KPiBwcm9jZXNzX29uZV93
b3JrKzB4MjFmLzB4M2YwIFsgIDEwMi45ODA3NDFdICB3b3JrZXJfdGhyZWFkKzB4MjAwLzB4M2Uw
IA0KPiBbICAxMDIuOTgwNzQyXSAgPyBwcm9jZXNzX29uZV93b3JrKzB4M2YwLzB4M2YwIFsgIDEw
Mi45ODA3NDNdICANCj4ga3RocmVhZCsweGZkLzB4MTMwIFsgIDEwMi45ODA3NDNdICA/IA0KPiBr
dGhyZWFkX2NvbXBsZXRlX2FuZF9leGl0KzB4MjAvMHgyMA0KPiBbICAxMDIuOTgwNzQ0XSAgcmV0
X2Zyb21fZm9yaysweDIyLzB4MzANCj4NCj4gU2lnbmVkLW9mZi1ieTogSG9yYXRpbyBaaGFuZyA8
SG9uZ2t1bi5aaGFuZ0BhbWQuY29tPg0KDQpBc3N1bWluZyB0aGUgY29ycmVzcG9uZGluZyBfZ2V0
KCkgY2FsbHMgYXJlIGFscmVhZHkgcHJvdGVjdGVkIGJ5IHRoZSBzYW1lIGNoZWNrOiBSZXZpZXdl
ZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KDQo+IC0t
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jIHwgMyArKy0NCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjExXzAuYyB8IDMgKystDQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYyANCj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYw0KPiBpbmRleCA1NDNhZjA3ZmYxMDIu
LjBmNmIwMzc1NThiYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMV8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8w
LmMNCj4gQEAgLTQ0ODMsNyArNDQ4Myw4IEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMV8wX2h3X2Zpbmko
dm9pZCAqaGFuZGxlKQ0KPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqKWhhbmRsZTsNCj4gICAJaW50IHI7DQo+ICAgDQo+IC0JYW1kZ3B1X2ly
cV9wdXQoYWRldiwgJmFkZXYtPmdmeC5jcF9lY2NfZXJyb3JfaXJxLCAwKTsNCj4gKwlpZiAoYW1k
Z3B1X3Jhc19pc19zdXBwb3J0ZWQoYWRldiwgQU1ER1BVX1JBU19CTE9DS19fR0ZYKSkNCj4gKwkJ
YW1kZ3B1X2lycV9wdXQoYWRldiwgJmFkZXYtPmdmeC5jcF9lY2NfZXJyb3JfaXJxLCAwKTsNCj4g
ICAJYW1kZ3B1X2lycV9wdXQoYWRldiwgJmFkZXYtPmdmeC5wcml2X3JlZ19pcnEsIDApOw0KPiAg
IAlhbWRncHVfaXJxX3B1dChhZGV2LCAmYWRldi0+Z2Z4LnByaXZfaW5zdF9pcnEsIDApOw0KPiAg
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMV8wLmMg
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMV8wLmMNCj4gaW5kZXggMzgy
OGNhOTU4OTlmLi4yNWY0NjZjMjZkMTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192MTFfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192MTFfMC5jDQo+IEBAIC05NTEsNyArOTUxLDggQEAgc3RhdGljIGludCBnbWNfdjExXzBf
aHdfZmluaSh2b2lkICpoYW5kbGUpDQo+ICAgCQlyZXR1cm4gMDsNCj4gICAJfQ0KPiAgIA0KPiAt
CWFtZGdwdV9pcnFfcHV0KGFkZXYsICZhZGV2LT5nbWMuZWNjX2lycSwgMCk7DQo+ICsJaWYgKGFt
ZGdwdV9yYXNfaXNfc3VwcG9ydGVkKGFkZXYsIEFNREdQVV9SQVNfQkxPQ0tfX0dGWCkpDQo+ICsJ
CWFtZGdwdV9pcnFfcHV0KGFkZXYsICZhZGV2LT5nbWMuZWNjX2lycSwgMCk7DQo+ICAgCWFtZGdw
dV9pcnFfcHV0KGFkZXYsICZhZGV2LT5nbWMudm1fZmF1bHQsIDApOw0KPiAgIAlnbWNfdjExXzBf
Z2FydF9kaXNhYmxlKGFkZXYpOw0KPiAgIA0K
