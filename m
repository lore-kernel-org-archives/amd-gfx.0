Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF659C7EE43
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 01:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1DD810E2EE;
	Tue, 13 Jun 2023 01:14:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A70310E2EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 01:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLvnyWrUsG8XVFyxjRNKz34wqKgrz/5ddMdDj4ZwpYkluYDDIHZ9owGwmYoNFrAJ7ikuQLFeJqPjIa+TEq9iLkgnnyyORgTVFZKlL1xbkBq2jzdWOvaD+aCY3nQqvMrY6o79HKANk1IiwR82sMWWPy56tWGwCWAlfW9mlrHWK3QYd01M0GuhBF0R2/C7vwMCeQt6J72bevbCtKwpyOlR9lbg4wMKa7ZtWoF6m9pVKboSA8bLOzafFdhPVggKYotBIlINpYrm1t3CTF7CsiHiXED7XTHceWx0KdraBxXqkqo9jb8JqQcO9mKVcQ8F+bZb+e7j4CcDsjYA9qULtLJFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HGT5fo0Z4/zOu9MP/y0DY76CUAI/ezeLmdb5KdOxv0=;
 b=K3dXa9ozCexLVJj4mGXtPXTFqmQnC/laqASmHO+Lq7nDaAlZ/cKlJmsqm8QY3Gfb16LvzRh4j9gJ+Ep1Tlzbw/9X4hkYDvNP2b+tnzzDgqi7oZHM4WTposx501b+OxcrylZXUAWXhhYkuacuYi9xoGCW2vHYQ/QXSGePzU9+w568ITP1QfriApuTMHbsymfzVR17R/pfWHykkRVvakIQEKKHM83xH7A6FsC6GSL7ExcTbruTxFHeepRSBY8MPHGOlcQQW7bMyU+TeCFzY9az6aYlpm0JFwPc5wIdSDcEptXb/aRXCFDOaBc85QcCCmtmnjua0CRm5MIFHK/1WRd+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HGT5fo0Z4/zOu9MP/y0DY76CUAI/ezeLmdb5KdOxv0=;
 b=Dxk3s0wzSmguICnH+OSNI7mIwubGp4rtZRcHj1J9Bf+ov5DJTComDgABtiHR3W/5KAjvdci5foz9ga7Vcc28h8cFLnpPqZT1lLPtJVfjqKMi0v11D/6AFmtflJ+DUdmrPSUQ+GB6fXQaltnpsJB4TFt7B8Z8vvJMnGavEj0WmXY=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Tue, 13 Jun
 2023 01:14:06 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::d53f:311b:dfa4:dc0f]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::d53f:311b:dfa4:dc0f%2]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:14:05 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sdma4: set align mask to 255
Thread-Topic: [PATCH] drm/amdgpu/sdma4: set align mask to 255
Thread-Index: AQHZmV2VfjlscQp7uEi0ewlJ5NTFkq+HvEcAgAA5TkA=
Date: Tue, 13 Jun 2023 01:14:05 +0000
Message-ID: <BL1PR12MB5237E77210FC7DBA7466EB5CF055A@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20230607163136.958994-1-alexander.deucher@amd.com>
 <CADnq5_P6e7kYFYaZ9S8yRGhyWrLbUqBEPtGjTPHJ5a1DVWsepQ@mail.gmail.com>
In-Reply-To: <CADnq5_P6e7kYFYaZ9S8yRGhyWrLbUqBEPtGjTPHJ5a1DVWsepQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1cf0a114-f593-421d-aeee-6c3d1351e412;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-13T01:12:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5237:EE_|LV3PR12MB9096:EE_
x-ms-office365-filtering-correlation-id: 77743c86-82e4-4155-a0b3-08db6bab7b2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2gf+xYub26TBCbs+3SBY0r+kHOPuugzw3LNH7bAt80X0fUKpiciwuzfAhoN1jmaf4JWOXMcfvzN4YcapY2Sw52aiupfoesCcSwb2tcn2pAr8oWR+SzzGqIC+WeOCAX37+nmAnzf05m7rar690KhRwvChGd3iACl2RhCn903sap+m240H7HAzK5zkvNgnwjL20yTBp4riEvAcVtHwhluaxB3EDXPxBr7q1xZbabjDQoV2AwJ2FjyQivzqDzm49wVd8RSG5LVeVg0WxEVqpG9APOSwp2N8LXm3A56ybBrBPZkiC8NINtDxR8igxGTrpOZZ3V5NEqRblZHYGAJ+3iTGrn89mwAbZZAy7esgHCxZDvc2DD2pZa7iEfNOUFP6syj/FlVGjG7qlP35KJCT4E65uqxb7WhUsypnYx2gW+FqdoThja7OgC3AuQKVMizyJgZUucKdZB7oIF4H5dhrx1lRUQfetPmiGnXnvmVLtQnlW7YnK9dV6ycISHLTQu05LrDNUxsv9JAwY+ixWJ02RjV/S6ghV2E9eHHDx1TAXo1566uRlMar8KCe7hIkh0FkAr+684Va68ZQ2A3bdMwxFxoWtafUT9qluIotW2hBtP6oUXoyr6GeTgwDqzXklxMLtJEq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(316002)(55016003)(9686003)(122000001)(110136005)(478600001)(66476007)(8936002)(8676002)(66446008)(4326008)(76116006)(64756008)(66946007)(41300700001)(38100700002)(6636002)(66556008)(186003)(83380400001)(71200400001)(7696005)(6506007)(53546011)(5660300002)(26005)(33656002)(52536014)(86362001)(38070700005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWwydnY5UDJUcG05TXd4YjB4QlB2MEhRcGVvdThNS3JwU1FrSUlscGZ6L1Z3?=
 =?utf-8?B?U3pxK09ndHRRRmdXYUJxQkRUcHhwVSs5bGxOYnlTOTNTbmw2WThQK0tEbzI5?=
 =?utf-8?B?b20yVGtCQk9TMW4zOWtLQVUzYXRybWhpUXNIeFcvVDBYdDFEL1dtU3dVb21P?=
 =?utf-8?B?bkVBRXZ0NHhYdVUwMnZiTWNNOVpjRXZTUmQxWUVGOG5VZmJRVTZzNzJRM1ZL?=
 =?utf-8?B?Ly91SkZmaFFxOHZZazVSVmswTmhkRXcwQnpOaTd2dVRkeWJIQUt3SkJ4SjFU?=
 =?utf-8?B?dW95aGVKRlpWK3RDc0g3ZXF6emt2UTBpQlBRVXhLeHkveDAyaHdaWWM0cU9o?=
 =?utf-8?B?VWFYT1pnNmZ2MTlNQ0swZktSdUVJbVhCNVoxOTBiRSt5TWQ2VW50WXBGZkdv?=
 =?utf-8?B?eHNvMVlpblpPNUdFMlUySWQ5UnljSXBTTW82ZUpKRm5qRjFVVXphRXhMdDNL?=
 =?utf-8?B?MEpxdjZwTE92eDh0TmJxaEE4TXVGUmdoaW5uUWVLS2N1cWVERzJxc1krUmpE?=
 =?utf-8?B?T3VsREhnQXNRSUNwVWhsNU5ONmJrdVdneWpKUk1SWHRZWk1XbEZYYld4ekEy?=
 =?utf-8?B?QnBOVmtmTk5rRmliWis4VHkxbzY2cVF1eDhnUEFKaklNUGxLc2hjR295UjhF?=
 =?utf-8?B?NEVEWUFVY3VsamlwNTlrSDVySjdqZktscGh2SUNubjE0Zm5aQXlMQVlmbVd4?=
 =?utf-8?B?WjBDZ3c2WHpsSGdpSTY4Ym9Vd2ZwL2lmMTdGdGNHV2p1Tjl1Ukk4d1ZkZXdO?=
 =?utf-8?B?Z3R6UTZ0ZWRYTU9oS09LaUdtUkljRUcwam1KMUFWdWY4bXFtdmxFNDhzYmJV?=
 =?utf-8?B?VHpQbDFyOUpJc3A2QmNJN0E5UlVFOXlMUzRzK1B4SUR6TW9ZQzUyRjNoUzVT?=
 =?utf-8?B?N1pHd2V2Y3c2OTJad1pnZGIrK2ZWbVFBTFM1NTBTSHE5QVE5SUZ3Qlc5c1U4?=
 =?utf-8?B?SEZsanZiSjY5ZkdWM1FJanl1dkpuN3RGOU4vRmU0Z2U4ekxUemJjYW80dGdN?=
 =?utf-8?B?RjVHZFFGTUJKYzBsNXBiSFZMdUdMQXgrVWpyZDFBOEJoVktSTldwSVNTczlw?=
 =?utf-8?B?czBLYmhYL0RzUisvOUV5ZkZ2MW9zYkNLMVpLUXc0ZExyV2hFK244bFZJQlJU?=
 =?utf-8?B?cXRhRVVHdkRHZHBMN090azZEamFrNm1RSDd4YzRBeTJLTGFBMG9vdTIxVmZ0?=
 =?utf-8?B?c1o0Q0dHVHNwLzgwNGUrdjZldWoxWDJ2OWNiUlVCYTk3VmZnWXVZdk9Eenp3?=
 =?utf-8?B?VE5lQnp5ZFBxUWNmcU45RmxRcFF2bGVXZGlhVUdwM0NIQXN1UTRROEpXN0Iz?=
 =?utf-8?B?ZUhHK0FXeWxNRUdnUmNMclN1V1l3eTZsM09VcFcySGlqQlpQcSt5N1VCZDlx?=
 =?utf-8?B?Wjc4ZGNlakMrZGMyaWdoVktPVkVHdnV3SkpITGFRdVF6dUxVRTh6MmNIOFk2?=
 =?utf-8?B?MHdsUU40eHlwNkdOOHE0USsxVERieEx2ZVl3TkRkQlpBYU5oUS8yelF5Uzcv?=
 =?utf-8?B?NmZWMzkwQVRQbmQzT1ZlZ3pjSWlacUZ5RDI4ZzhYdmtRNWJRT2dQTkcrVkg5?=
 =?utf-8?B?aXB0N2xNV1o2WlcwQjdRU1JxOVJpV2VRM2prZXdGMWNMcHQ2Wk1nMUJTeTFO?=
 =?utf-8?B?alRMUXArSGpwZy8vMkQ2ZExzcEtJdGo2YUY1NFZITEg1NXZraGZRQ3E3UWtm?=
 =?utf-8?B?ODErTmFMME8rbEppTnJVMnVMUHdrRkxsaFppWDViSlhJNVg1QVNla0R2Y05w?=
 =?utf-8?B?d09ScTdzSVFmQ0pDRlBLUnFOR21kNGI3WUE5czloUXZNWW1VQmgrckVqSnNF?=
 =?utf-8?B?ZmRrYTFXdk9jVG1rbE1wckg3K0NLWWpwSnpESnB5b0dJQ0ZXQnpHYUtYdVRH?=
 =?utf-8?B?dUlDellsL3B0V2x4cXNHd1FWbHBBMHh0aGJPZVJaU3dXckx2RnlWZFZLSkh5?=
 =?utf-8?B?VmZXL2ZUeEpyR05OMExMakRUZDl6T2NIS1pVelBJOWp0QUE2Ui9iSWZrRmhl?=
 =?utf-8?B?b3lMdytsRGFWVjN2Um5MRWVRb2hsSVlETWZSZEJNNWo4bzJKUmdyVDB1NFRD?=
 =?utf-8?B?dkRHdTlKcElEeXlQRzdMZ3VtQ0VTQ1ZlcjhsOHJoOVhFSW9oRE1QanR1S2Mz?=
 =?utf-8?Q?HIto=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77743c86-82e4-4155-a0b3-08db6bab7b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 01:14:05.3028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vai2D79X9x0bSToYYvigSHUrKPb9O63/Bft1ALA6/a1knbN/9mrOLY9f76BP+AKa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBBYXJvbiBM
aXUgPGFhcm9uLmxpdUBhbWQuY29tPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9u
IEJlaGFsZiBPZiBBbGV4DQo+IERldWNoZXINCj4gU2VudDogVHVlc2RheSwgSnVuZSAxMywgMjAy
MyA1OjQ4IEFNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1kZ3B1L3NkbWE0OiBzZXQgYWxpZ24gbWFzayB0byAyNTUNCj4NCj4g
cGluZz8NCj4NCj4gT24gV2VkLCBKdW4gNywgMjAyMyBhdCAxMjozMeKAr1BNIEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgd3B0
ciBuZWVkcyB0byBiZSBpbmNyZW1lbnRlZCBhdCBhdCBsZWFzdCA2NCBkd29yZCBpbnRlcnZhbHMs
IHVzZQ0KPiA+IDI1NiB0byBhbGlnbiB3aXRoIHdpbmRvd3MuICBUaGlzIHNob3VsZCBmaXggcG90
ZW50aWFsIGhhbmdzIHdpdGgNCj4gPiB1bmFsaWduZWQgdXBkYXRlcy4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMgICB8IDQgKyst
LQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzRfMi5jIHwgNCArKy0t
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRf
MC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYw0KPiA+IGlu
ZGV4IDFmODNlZWJmYzhhNy4uY2QzN2Y0NWUwMWExIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2RtYV92NF8wLmMNCj4gPiBAQCAtMjMxMiw3ICsyMzEyLDcgQEAgY29uc3Qg
c3RydWN0IGFtZF9pcF9mdW5jcyBzZG1hX3Y0XzBfaXBfZnVuY3MgPSB7DQo+ID4NCj4gPiAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBzZG1hX3Y0XzBfcmluZ19mdW5jcyA9
IHsNCj4gPiAgICAgICAgIC50eXBlID0gQU1ER1BVX1JJTkdfVFlQRV9TRE1BLA0KPiA+IC0gICAg
ICAgLmFsaWduX21hc2sgPSAweGYsDQo+ID4gKyAgICAgICAuYWxpZ25fbWFzayA9IDB4ZmYsDQo+
ID4gICAgICAgICAubm9wID0gU0RNQV9QS1RfTk9QX0hFQURFUl9PUChTRE1BX09QX05PUCksDQo+
ID4gICAgICAgICAuc3VwcG9ydF82NGJpdF9wdHJzID0gdHJ1ZSwNCj4gPiAgICAgICAgIC5zZWN1
cmVfc3VibWlzc2lvbl9zdXBwb3J0ZWQgPSB0cnVlLCBAQCAtMjM0NCw3ICsyMzQ0LDcgQEANCj4g
PiBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIHNkbWFfdjRfMF9yaW5nX2Z1
bmNzID0gew0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3Mg
c2RtYV92NF8wX3BhZ2VfcmluZ19mdW5jcyA9IHsNCj4gPiAgICAgICAgIC50eXBlID0gQU1ER1BV
X1JJTkdfVFlQRV9TRE1BLA0KPiA+IC0gICAgICAgLmFsaWduX21hc2sgPSAweGYsDQo+ID4gKyAg
ICAgICAuYWxpZ25fbWFzayA9IDB4ZmYsDQo+ID4gICAgICAgICAubm9wID0gU0RNQV9QS1RfTk9Q
X0hFQURFUl9PUChTRE1BX09QX05PUCksDQo+ID4gICAgICAgICAuc3VwcG9ydF82NGJpdF9wdHJz
ID0gdHJ1ZSwNCj4gPiAgICAgICAgIC5zZWN1cmVfc3VibWlzc2lvbl9zdXBwb3J0ZWQgPSB0cnVl
LCBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzRf
Mi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzRfMi5jDQo+ID4g
aW5kZXggOGVlYmY5YzJiYmNkLi4wNWJiMDY5MWVlMGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF80XzIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMNCj4gPiBAQCAtMTgyMyw3ICsxODIzLDcgQEAg
Y29uc3Qgc3RydWN0IGFtZF9pcF9mdW5jcyBzZG1hX3Y0XzRfMl9pcF9mdW5jcyA9DQo+ID4gew0K
PiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3Mgc2RtYV92NF80
XzJfcmluZ19mdW5jcyA9IHsNCj4gPiAgICAgICAgIC50eXBlID0gQU1ER1BVX1JJTkdfVFlQRV9T
RE1BLA0KPiA+IC0gICAgICAgLmFsaWduX21hc2sgPSAweGYsDQo+ID4gKyAgICAgICAuYWxpZ25f
bWFzayA9IDB4ZmYsDQo+ID4gICAgICAgICAubm9wID0gU0RNQV9QS1RfTk9QX0hFQURFUl9PUChT
RE1BX09QX05PUCksDQo+ID4gICAgICAgICAuc3VwcG9ydF82NGJpdF9wdHJzID0gdHJ1ZSwNCj4g
PiAgICAgICAgIC5nZXRfcnB0ciA9IHNkbWFfdjRfNF8yX3JpbmdfZ2V0X3JwdHIsIEBAIC0xODU0
LDcgKzE4NTQsNyBAQA0KPiA+IHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3Mg
c2RtYV92NF80XzJfcmluZ19mdW5jcyA9IHsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IGFtZGdwdV9yaW5nX2Z1bmNzIHNkbWFfdjRfNF8yX3BhZ2VfcmluZ19mdW5jcyA9IHsNCj4gPiAg
ICAgICAgIC50eXBlID0gQU1ER1BVX1JJTkdfVFlQRV9TRE1BLA0KPiA+IC0gICAgICAgLmFsaWdu
X21hc2sgPSAweGYsDQo+ID4gKyAgICAgICAuYWxpZ25fbWFzayA9IDB4ZmYsDQo+ID4gICAgICAg
ICAubm9wID0gU0RNQV9QS1RfTk9QX0hFQURFUl9PUChTRE1BX09QX05PUCksDQo+ID4gICAgICAg
ICAuc3VwcG9ydF82NGJpdF9wdHJzID0gdHJ1ZSwNCj4gPiAgICAgICAgIC5nZXRfcnB0ciA9IHNk
bWFfdjRfNF8yX3JpbmdfZ2V0X3JwdHIsDQo+ID4gLS0NCj4gPiAyLjQwLjENCj4gPg0K
