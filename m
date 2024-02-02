Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E5BC47DB3
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 14:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47AF010EDF8;
	Fri,  2 Feb 2024 14:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JSLF0LOA";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33BED10ED92
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 14:24:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJXOjjej48ZC+NRuHWNbk3YJPz5EwVkA0sa8+D7wYDcQblnYwGEqRPTzdGRHeIJqmu3xbDzj3eNEHlO+qSzOMUvvDxZQx6bdJ+B77MbWstdfVxIo1FoH1speqhAdoy389uQ/t46N7GnD3CGZjrr/d/Mb0hAeGum0N86uTwkXT6Ou/UrsVxKY6KFiJLLoiqhsHsYxpqoNrdqgGmgJklbxkjthSulrkrYc6tyJ7WSVvPoynRhGBW6lal9n3B1nxT3ra1Hrdgy/cY+MpDP9wQGZNhmTtBQKEKfHUTQz+kcdCXRxXRqhy9GuMLInzcUmtRcleZr0ppi2Aym/B1gVoqI0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ruxii9Mya1JoTRfBf25mMkvjnHpwMK7+MjTrRKrMtEg=;
 b=NZMeMbwNVnhntC2ryQxUDRFU1vSysivpdTIWgENVqCBks5gOEloDLxt7lXkiQNEzrgSdpSN5xGoe6MHdVrheyfW+oJSnpNVTULf30lR5ieg8W+CvNxPfMUZBJbNaDu5RIByujnhC5bIJckatWt5Fe+8gFYmlGRoiik3kWUEyC3PP3+OdxzyTsUwY+e2aDo9yPyODDa8V9gB2Bwale0SBsKhaiqO/uVBSI8ORyt08HfNjYYQ+dGUUKvuNKNTgarAQ4TllaAUSm3gscVVSWmqOklo73DRIZux9YcZeN1GuuaSKFOZxelr/pHQli85y2lB7vfSJ5JhZGJ2A/jLHUz+I+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ruxii9Mya1JoTRfBf25mMkvjnHpwMK7+MjTrRKrMtEg=;
 b=JSLF0LOAAhpZJ+6T2NqTvEHvs0rK5SqUDVtxJhI3DbxQ0PULgwNBA8w+7w4pObDxyMUmDtb/L2edYBm+u3wWdHThEnKsi+HcftD4RzRUajR22u0OhGMwT8ZChPm8kpY4mP/pzc8xAZJnf1XWihf3Zv6JFCpDas44ZA0jv+mHufs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 14:24:53 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7270.012; Fri, 2 Feb 2024
 14:24:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix potential out-of-bounds access in
 'amdgpu_discovery_reg_base_init()'
Thread-Topic: [PATCH] drm/amdgpu: Fix potential out-of-bounds access in
 'amdgpu_discovery_reg_base_init()'
Thread-Index: AQHaVTUpJDKCBBXUTUipolmX7fspNLD3G69g
Date: Fri, 2 Feb 2024 14:24:53 +0000
Message-ID: <BL1PR12MB51444E2FC7F12E5D2AAD96D3F7422@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240201173555.1289398-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240201173555.1289398-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=79ee84c2-e148-4007-a3ca-0d565f8bd056;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-02T14:21:07Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH2PR12MB4326:EE_
x-ms-office365-filtering-correlation-id: 2a80e3c7-227e-41e7-5021-08dc23fab939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tf6BdChQJqWgJ16p3HH6K61OpH0LDVZQ3MBEv8yXIbTMzAuiKBWxHEvVU8RTPbfIzmpP/h514PBn5UJfR3H5b2h6jK8ZEiuQMyo4og3RQXuCBbyynOlp/dV5tiHcOLHHQQmv98HhVZIZCoJBXq0KG1lDRLm2jToU0OpYYZXE2WkNwRpaL91B63NPyNrBfZmpDyvjtOp2P6b52cNJhjGmfWeTcufHcmjCx9qRrOY+FkrY5dkYTRss2F2QEYkmWBvQQljVhHfwywl6upSkuD4Z04WAihQIqcQ7wfqUVMfrkIcOxtvaOrL9GWDA1YQv49zLQQipm8n/742dCj2Sv3CYZbwBXqHfmtgl3GV15dOqJnmEi21ffmfvqi8zmyp5lwQNnxqpveFgjXgsoKzCRYP2274nPCM0bM3b6xrCpBTWwniaL+isTlf5KYsYwhpb/HwFWVqwCj6kjMl63RJLLJl7eltNUSIRzqKUCZSCHiLQ+D7o51oMLqoTXK5IJR+w8DBvBCo9bbqba/uBrblaBHPR8VdF9XP4Ht4i2ez0Yu797jN1bOL6+iLSq8cBqKt0o0ZPBdJ95mV+gfI/XaEHV93cWqWK5DgFAyx5KJ7dwYktsAM9CPNhT26ru01anRLTj6pM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(53546011)(110136005)(66946007)(4326008)(5660300002)(8676002)(86362001)(2906002)(52536014)(33656002)(8936002)(76116006)(66446008)(64756008)(38100700002)(316002)(66476007)(9686003)(6636002)(38070700009)(66556008)(122000001)(7696005)(6506007)(71200400001)(478600001)(83380400001)(26005)(66574015)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azBuaGtyZVhRNFlCalRuV2QzWUZwOFZFdjliQThyVEpnb3RxWTAxZHZybENs?=
 =?utf-8?B?ZFk3NE9jRi9IemFIam04REVNTjVzZEozMnU5VmRwRUp2ZTQrekhDS2pxNEQy?=
 =?utf-8?B?Q0lSMnFuZkJmeFplTEQxUnFSS2o3MjZSNHc1Vit0eHRndGJQQmFvYVg0MjNj?=
 =?utf-8?B?MFA2c0tsdURwNEdLK0lJRVF3eXRpQUhDcHEvbkhJMTN2VjR1Y0IxSGFQMXg4?=
 =?utf-8?B?R0J2SXNvbWdkVk5vcjZsMnY3NDI5RmtJczVpRFBDclJwcURlcmRvdWpYMVJz?=
 =?utf-8?B?Q0lkYmUyZStGVDE5b25HTW5kbzRrc0NnTFFTZmROVEVTU1EwTlozQ3IxVzZK?=
 =?utf-8?B?OHljb0k3K1dHMGlMbDB5V0xncTE4THZNa0tFTElIaUo5eEE3V2xhdWtaOVdk?=
 =?utf-8?B?UVdSemx1MXA1OElqYmJhSTJVdU5GWm1zTVk1NmpzY1hHRTFRKzFXSTk0S1hR?=
 =?utf-8?B?QytVSWVpWmlZQ21VYVhiNVJOVnFUQkxUUzVOREJGc0FBb1VuOVhZSWVxTmhO?=
 =?utf-8?B?TXBCWGk2Y1MwRk9OWkd4REZsMUlNMFBLTmtJcTBzWWVzN1U3OForVUFEenQ4?=
 =?utf-8?B?OG44TEZrdG5jOUlZZ0luL1lXVVRmT1VvL0IvTkQwTHF6REUzMGZveHFBQ2pi?=
 =?utf-8?B?QkR5U2JRTVdiUU5KSHRqYjlvQ0wwWUsrVGx3Ri9mYmZ4T0RYQXUvMDgzZ1ZT?=
 =?utf-8?B?alIzMEJlYnlNM1hBK05wVzFMMFJ5ZWNZOXh5SkpFbXZOTGN2UFBKSHA1WmpC?=
 =?utf-8?B?M3Y2T09HbEluVlh0Y3AvcTFxaFpYZ3VSalBnem9GR3BXQUUxZEdFaHVvdDhk?=
 =?utf-8?B?Mkd1bklTU1h4SmZQRmlOTGR4NENhSnZMNm15RjE0dXBKTmd3NmtLY2xFSGQ0?=
 =?utf-8?B?aDMxbDBQYVdrU3JRZjZDU0pYYjhzNjlScnpHQngyVmFrYWg5UkNKMUFHeUlW?=
 =?utf-8?B?OUdJSGJTN1U4dW5hdWZmSGZNQXdHWExwbVVxWU9JRjB1eHpxaDVRUW5Eemx4?=
 =?utf-8?B?bXFNUldPdVlQaEg3ZiszRTZmR2NQenRackpZVjdHLzBpUkU4c1pNU3p6c2hQ?=
 =?utf-8?B?a29sZlM4WHhqc2lNVmpuOGgzbXk0akNTZEJsU1pQK1VTT0ZVTVdXUy80NXMv?=
 =?utf-8?B?VmJpVlZyUm43QVdiTDQyTU5vb0xPa0hNUTR3OVM2bnpJT1VwNHlmUFk4RWc5?=
 =?utf-8?B?dnNnQmhJa0NaZEV3NGhDMlFPQjFVbXF5YXdGZE14K0JuT3dmaTBXZHY4M2Yx?=
 =?utf-8?B?T0QxeEhWS21qUlRYaGVnOGp6VktTVUJueVllcnI0Tk9jMW5rYW1EZFlQM2to?=
 =?utf-8?B?QVBobE9qK01EL1JvbWhacTJFc1ZGUmsrenc3Wll1WGZVcVIrL3hmdlc1S3Nh?=
 =?utf-8?B?dGxCcmlGcXMwTm12WGZETDBTN0hFSkxwVmpnWlcyRGxWNEVCVmUrYUs1ZzJt?=
 =?utf-8?B?VThCR0hySEFBMHNrU1JJQWFrbmFmenIzamxYaXR1UVlJYURWc1dDdVFoWWNp?=
 =?utf-8?B?M1YxZ0YyaXBYUEFCMGRxZU80TXVBUEE1UTJQczJvdXVidVhNUnBlZzJGb2Zp?=
 =?utf-8?B?bi9mMXpTY2NrZ1NGNVcxYUlROGdzRy9ZdG12NmVWdlBnUWh0UTNSRFVzU3Uz?=
 =?utf-8?B?TzRHRW9obk1qbkkraUtJSk1mNm1WWmcxQWkySUMrcG1BNTZOM1BlNjV1bStq?=
 =?utf-8?B?RlpVSHF2ZWtoRjZxazhoNEpZMThKaWc4U25QM0pYOGxZWHJqdTMvT1ROcVhl?=
 =?utf-8?B?K3BrNGZHUGFhZEViZHlIMUxxYzNYTWFmVFVtVFQ0QlNpZG5qWkJibGpQT0Iv?=
 =?utf-8?B?OVB0bXpsTHRPUFNYQXhvb2RxSFpyZmJJS0NDeWNVTzhpWGhJdVZDVVZWd1FS?=
 =?utf-8?B?aXVHcUpqN3E3aXlDYm1tM0Jabk5iS2lpWElxMVZLeUJWWVltSlEyZ1BINGZL?=
 =?utf-8?B?R3RJRUxnbGhTY2lva0xKdlozaVgyNTc2Sk5mTmZ4T056Z3c3bUJvZmV3UmRK?=
 =?utf-8?B?U25HOThNWE4vWjdsS1RPbVVUVTN4dXMzZ1hlMndMRklXU0ZiZFRXOGEyYU84?=
 =?utf-8?B?ZkJZL0U1YkFuUVRlSmVKeEZybC9vcGdSbDl0aWwxdkwrMUlCUkg5R1hLNVFK?=
 =?utf-8?Q?x3K4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a80e3c7-227e-41e7-5021-08dc23fab939
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 14:24:53.5571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IgJyHgebsdhd1cqF8Trz8YY4dGGrXxAfyI1GfD1Gv7hXrs+QTBDFbWplKaIMjuR5dIQ+rz/GG17rCMboznlyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFOTVVH
QU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBGZWJydWFyeSAxLCAyMDI0IDEyOjM2IFBNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNv
bT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggcG90ZW50aWFsIG91dC1vZi1i
b3VuZHMgYWNjZXNzIGluDQo+ICdhbWRncHVfZGlzY292ZXJ5X3JlZ19iYXNlX2luaXQoKScNCj4N
Cj4gVGhlIGlzc3VlIGFyaXNlcyB3aGVuIHRoZSBhcnJheSAnYWRldi0+dmNuLnZjbl9jb25maWcn
IGlzIGFjY2Vzc2VkIGJlZm9yZQ0KPiBjaGVja2luZyBpZiB0aGUgaW5kZXggJ2FkZXYtPnZjbi5u
dW1fdmNuX2luc3QnIGlzIHdpdGhpbiB0aGUgYm91bmRzIG9mIHRoZQ0KPiBhcnJheS4NCj4NCj4g
VGhlIGZpeCBpbnZvbHZlcyBtb3ZpbmcgdGhlIGJvdW5kcyBjaGVjayBiZWZvcmUgdGhlIGFycmF5
IGFjY2Vzcy4gVGhpcyBlbnN1cmVzDQo+IHRoYXQgJ2FkZXYtPnZjbi5udW1fdmNuX2luc3QnIGlz
IHdpdGhpbiB0aGUgYm91bmRzIG9mIHRoZSBhcnJheSBiZWZvcmUgaXQgaXMNCj4gdXNlZCBhcyBh
biBpbmRleC4NCj4NCj4gRml4ZXMgdGhlIGJlbG93Og0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGlzY292ZXJ5LmM6MTI4OQ0KPiBhbWRncHVfZGlzY292ZXJ5X3JlZ19iYXNl
X2luaXQoKSBlcnJvcjogdGVzdGluZyBhcnJheSBvZmZzZXQgJ2FkZXYtDQo+ID52Y24ubnVtX3Zj
bl9pbnN0JyBhZnRlciB1c2UuDQo+DQo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+DQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2Fu
LnNoYW5tdWdhbUBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kaXNjb3ZlcnkuYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+IGluZGV4IGVmODAwNTkwYzFhYi4uODNkYTQ2
ZDczZjcwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGlzY292ZXJ5LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rp
c2NvdmVyeS5jDQo+IEBAIC0xMjgyLDExICsxMjgyLDExIEBAIHN0YXRpYyBpbnQNCj4gYW1kZ3B1
X2Rpc2NvdmVyeV9yZWdfYmFzZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiAgICAgMGIxMCA6IGVuY29kZSBpcyBkaXNh
YmxlZA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiAgICAgMGIwMSA6IGRlY29k
ZSBpcyBkaXNhYmxlZA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRldi0+dmNuLnZjbl9jb25maWdbYWRldi0NCj4g
PnZjbi5udW1fdmNuX2luc3RdID0NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpcC0+cmV2aXNpb24gJiAweGMwOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpcC0+cmV2aXNpb24gJj0gfjB4YzA7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGlmIChhZGV2LT52Y24ubnVtX3Zjbl9pbnN0IDwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEFNREdQVV9NQVhfVkNOX0lOU1RBTkNFUykgew0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnZjbi52Y25fY29uZmlnW2FkZXYtDQo+ID52Y24u
bnVtX3Zjbl9pbnN0XSA9DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpcC0+cmV2aXNpb24gJiAweGMwOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlwLT5yZXZpc2lvbiAmPSB+MHhjMDsNCg0KSSBoYXZlIHZhZ3VlIHJlY29s
bGVjdGlvbnMgb2YgdGhpcyBiZWluZyB0aGlzIHdheSBmb3IgYSByZWFzb24sIGJ1dCBJIGNhbid0
IHJlY2FsbCB3aHkgYXQgdGhpcyB0aW1lLiAgVGhhdCBzYWlkLCB0aGUgYCBpcC0+cmV2aXNpb24g
Jj0gfjB4YzA7YCBzaG91bGQgYWx3YXlzIGJlIGV4ZWN1dGVkLCBub3QganVzdCBpZiB0aGUgbnVt
YmVyIG9mIGluc3RhbmNlcyA8IE1BWF9WQ05fSU5TVEFOQ0VTLiBTbyBJIHdvdWxkIG1vdmUgdGhh
dCBsaW5lIGFmdGVyIHRoZSBpZi9lbHNlIGJsb2NrLg0KDQpBbGV4DQoNCg0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnZjbi5udW1fdmNuX2luc3QrKzsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT52Y24uaW5zdF9tYXNr
IHw9DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoMVUg
PDwgaXAtPmluc3RhbmNlX251bWJlcik7DQo+IC0tDQo+IDIuMzQuMQ0KDQo=
