Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B091C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 13:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955BA10E6A0;
	Thu, 23 Mar 2023 13:45:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B2DD10E6A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 13:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3K0Cr++mEHUqGKDIbDsokpR1rh7PcsQvavvie1lqOk/4/UFWmi5mxJjnMPxAKNVPkx7TiBsyy00nWxLPcLb/gbVhfeWnMLPbtFsbJiMi9v+GXdMS97Z0cA2Tkx3Az7BxKxSjCiqIfXxckllrEwH5s9WAtLIMJzJIQksEzeuvV27hCo5ldSyeTOEUC21KDOehlzeD2+rOy4c6tn+q0ePEg9xmyt5M+keO1t6aB01C3DNQDJ9o0rIIjcEBqUC3dBjKuJFSQX4f0GRjSNgLR+mHvGgB4BBA1rI8wxQr54Caz40J0BPIhDxf6XK2HEkmxhG/PC3Hba5n++Q0Psqm+Owmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp5MiLFChFGAmh6EANiFxcIL5ucPWL0W1pRGKsuD4j0=;
 b=BMufZRrEyYyv6oYMpwGbUQ0ISFluP9qw0zfYh5Vo3Uif1uk5I8PyxvUrK7fAgap5d+09IZi7F4irUjYKeVavzwcbqJnE5sbRvDhYVbbEUCcJG4gSSXjTLzwleKbZF/P3u9djZli7TWGg3pHCQKM880syfNcmXOxQJ3Jft4qdMSv6HwnG7754526lh7A9Nf7Z1jH+lim2O2Jw2Z150qvgJZUHtiYF6zsvGUi+DxIZEmMy23MrojfSbONd9QVFqo7ldMjzsYf2gbgrMh7l6jh8X6WSstFOhmy3vwNt1WZOOdnb2GvMZ3AdsGyGY5kEHAHjHT2OMkbBk01vxKEnVP1svg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp5MiLFChFGAmh6EANiFxcIL5ucPWL0W1pRGKsuD4j0=;
 b=uzisEvHmkNEynvldhK6KR8UxOSOHwMzWO0psvG1Xmb8QSBku93Uwlho4aWQ7DtELyNSUN3x2LHVp/9iPnP8AuE88vTdsE3+Y/DYxxoEqM1GWa4fUs6LEeFm3ttflqqCE0yjgV4LhxAliVgHz2yjNvF9tVUEYz6z2bPK74Us/yLE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 13:45:03 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::ffe7:2ff1:c01d:6070]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::ffe7:2ff1:c01d:6070%6]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 13:45:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Index: AQHZXX+4aRo8/4W7UUeUDn0eydOhEK8IW/oAgAADyOA=
Date: Thu, 23 Mar 2023 13:45:03 +0000
Message-ID: <BN9PR12MB5257B39B2E0E3365A9DB3EBCFC879@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230323120426.3960144-1-srinivasan.shanmugam@amd.com>
 <98edaa70-bba0-77c9-1ece-64700a3562b6@amd.com>
In-Reply-To: <98edaa70-bba0-77c9-1ece-64700a3562b6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T13:45:00Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a008da6f-bb86-4240-910f-f4a1be7a57aa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4073:EE_
x-ms-office365-filtering-correlation-id: 8cbd3df9-9005-4283-4300-08db2ba4ce3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m5GlSwBKv/rSLFFkQOXmd83ohhkIOZVK/+cAGyZ9NcceRBJmgAN0iRGusIsfeKFUTsQusTrKlHrCuCccBXevZaXSeI2UzKQn7Rfno9OM5jkrb4PeZRKJqRJeTsuf0n1yqW3nnadv9Ut8e4i5VUDOEQwM7F6ukVN24U3OrkDVC6mYAQc1Cc5h1kIJ99i68jPGcq/+CHbiOV0Zd4Ni0oN5RtgHKKGddlCGyDtoxA2Pz5bubpp2F/2qYNnnwjHiz5BnCNPGbEfdNDe3L7lqufu1iJkTAVYft2yzNl6IdrnqNs+N9DUSyc+K5RE+4/ybiicZQ7MQiZFKanbEVZsjmAjZBSRxAmuZ8cbKF+BZlSo2aCqpnNZ/WjphWiDG+md+BYFEnT2YmW2VJM5KYBAbiceoshVRW94kw6G7fnQbhFsugCcjw4J5h+zT0hPUQQgRjA9O+8SwVGqtxOEtg2fToKqgxSA3KGKHzzZp4maXYAIXiWqHJPh2Fi3Xo1DOPda9uymglcqSXt8rglzovTZ7sG34TQEDR32ObFFDElr4XDvIcY4JJL3HSH9fSUSN7zGlaKVPVAwtRPopmASIWfxcXuSeAjqPlTpd1nepb/CdigWb/B6ioqGc8wE2KnGVMB2tKNkvGEfiM9vHHLNtmpyKwEiYkVfAb/qxV+rbqp0ZuCJCDt6nGTi7Jb/Q138rNHMZdf9pyLi6V4tEomsmcKjV2Tderv4qdU+HwOtaX+BVW2gAQpo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(41300700001)(66476007)(5660300002)(52536014)(64756008)(4326008)(66556008)(8676002)(2906002)(38070700005)(66446008)(921005)(33656002)(86362001)(38100700002)(122000001)(7696005)(71200400001)(26005)(110136005)(478600001)(76116006)(316002)(8936002)(55016003)(66946007)(83380400001)(6506007)(6636002)(66574015)(53546011)(186003)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGdySHd5ajJTTlhqeXZyRTM5RmQxa0YzRDB5cXBadzJYakdXY1NRQmMyZnhC?=
 =?utf-8?B?b3VjR0tpN0NDSHVUTjAwRHBLNFR2ZWtXQmxsZ3Vqd2tyUEJlR3FvUVZ6Yitz?=
 =?utf-8?B?UVkrenU5VU4zNVpQRlVYN3QyRmhkT1B6bkdYWURPc0VqMEc4UmxmYVBBRVFy?=
 =?utf-8?B?L01hb0tGcGY5eXpLY0M2MU8rZXF3SER2NnNRa29PWHo3R0JINXZ1L3JTbTR0?=
 =?utf-8?B?SFhZU29jSXZoQWxrQWtHL3NTYTNuZE5yV3VJUWN0M0FJYVJWanhrOEkxRnJD?=
 =?utf-8?B?VUVBZXhqZmc0YkVueTdTSHRNamlaYmdQMzFqUDRDMC9PaSt6TWRUTWx1dWhv?=
 =?utf-8?B?OGFueWlKeFJaUE5ad3FWaFhmWmpSRnh3bFZMNnBGc0QyU1dZaHhjdk1tVU9M?=
 =?utf-8?B?MXFuWTlGYXNpeVdwS2JQYWlkZ3RMb0dNeUo0ZXIvZ0g3SVcwU1BOMXdIUzZh?=
 =?utf-8?B?VERYc2tneFJKMEQ2OXJYMVRDZFdMQWFGdTJTTS9BbzgzdFMwUmtBQmk3NFRH?=
 =?utf-8?B?dWk3OTczUDhYWElDVGRhdVF0U2IyRXZ3dEFtVlR1ejVnZUs1RU42NkFjL2hQ?=
 =?utf-8?B?aVZnbmxGSms0U0tmMHlDekd4TXVIdWQyL0NkcWU2YzlwMG4rZTROWmYwaHZS?=
 =?utf-8?B?OG1VTDRxcUYxUG1uYjFsYXVQU1BsVTRMY05OT2o5UXpHTXFEMWhSUC9XT2ZQ?=
 =?utf-8?B?djQvZ0tqWFlqSGRmVkVNWlAydThZdUhCNW5FVnhRYjdzOWFtNHFxMmZsUTVR?=
 =?utf-8?B?S2JxN2FyRVJtZXRHS1UvdC9EN2JROUFhL1d0MXdQQXcxTFcvSmkxQkthSHh2?=
 =?utf-8?B?Nzl5OEVRNzgxaURDQllwdzJCRjh2Y2Q5bis2QXJ0bm9ySGVnUlY2bDk4Tk9U?=
 =?utf-8?B?YWM4MHJRUlhyZCs2V1FjQWtzcG5ybUx4QW43TXVVOTFpcWxJeElWTElnNncr?=
 =?utf-8?B?aDJrNVlUOUdWaTVkeXRSQmxCNGFxR0o1b1RyNklVNmkxanZkSzUyYi9oRFVk?=
 =?utf-8?B?YUJud0RNN2dmSitIOTJueldLbkx0UEd0M1I2ZVJEVjNCd05iQjhjOEJha3g0?=
 =?utf-8?B?Tk83b2RMWHdYT2lQWjJXSXQ5OWxVaFpNV3I3VTBOZ0Z6aFdIam1kTjl6U0ZI?=
 =?utf-8?B?RDR6NXFKcDBMZTVJdWNqK1dWRllwczluVFVZenJVRTl5dEhucEM5VEZLOFph?=
 =?utf-8?B?SWJ3RmYwMk9Ea2xyVFhVb3llL3dsZ2NJdXcxMWd6amlDYUpQbWk4NTRGdDli?=
 =?utf-8?B?L2NtNDdhKzhTcjE1UEYybXJuMWhRYXFpbVBrdU5XRUdGc0hsZCtPQzAzVkY3?=
 =?utf-8?B?NjZERE1oSTZ3Mjc0Vm9aNFhpZG92V2ZnM0czeHJRT1BRVmcxeXNBSGdlWWRY?=
 =?utf-8?B?UUxJc0hUTlpObXI0SGdFYmkwTDMwQUx3aHpoMktFUGR1MllkekVTWStMTTFW?=
 =?utf-8?B?cVQvUTU5bDZQMDlJd1gxci9FVkQyenoyQ3liOGkzRmxJME01R0orYTdXYzlJ?=
 =?utf-8?B?YkFpNW9HTFU0SE5JMWJJa1k5dTRsQmpIOTQrNjhBU0dBKzYwSnA1Z1hUM1NY?=
 =?utf-8?B?bjJlaVM0ODl3bGdoMktiTzBkUnhvYXY2V2ZwdG5tVjVNYUhVV1ExcGM1RERp?=
 =?utf-8?B?cWE5YnVUa3FKTFpnQ1p1cjArMFpiaUszQnl1TjYxYVJjT2FaN0hLOHYrOTJ4?=
 =?utf-8?B?WUlhV3FDNllPREJVTVVtUFdCOWZ6Y2RrNGpaNUlFeUdIV2ttbHlubWJrR3Vz?=
 =?utf-8?B?c2JjSjl6cGVwMWplTmU0RDAyb0VYeVpITEdBSmY5aWczWHFjL3VrVFI0TGFL?=
 =?utf-8?B?K2xOYmh6dm41aUgraHh3bEhmZFI2aDE3SDFjNk83eGN4cTRRVHNHM2tLK0lt?=
 =?utf-8?B?T1pBL05vQjRUV2JkeHNuR2RKaDd3OW1oMSt1RG92bW9WaUZ6dlUreW1FVjZB?=
 =?utf-8?B?S2g1cHM0N1daWkhCNFZhMUFXRzVzSWtoWHE2RExCRnp2OHI3SXN5ZDcrNTYx?=
 =?utf-8?B?dGZob0hFMURtRnB4M0tZVTZzTHRQazRncDR5ZG1XZ1ZSd0JadGxDL0grMEE0?=
 =?utf-8?B?Y1hLcWMzUnhMdERKUGliUVZja1NRWEJpRG5UaUZ1TkZVWFdkM1VyeTBmL0l1?=
 =?utf-8?Q?AiA0QsqOTfhJ6RjXxJHEUi8Lo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbd3df9-9005-4283-4300-08db2ba4ce3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 13:45:03.7784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LX2aqaq4EYi7PkNfaQY8oUAvVOT+q4LbGCFNETLVlGmbUkvdGBDefJ6A9Hy+/YBVALcaGAITLglukgLLbhSzXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkdvb2QgY2F0Y2guIFRoaXMgaXMg
YSB0eXBvDQoNClRoZSBjaGFuZ2UgaXMNCg0KUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVnYXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPiANClNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyMywgMjAyMyAyMToyOQ0KVG86IFNIQU5N
VUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpbW9uY2llbGxvLCBNYXJp
byA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+OyBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT4NCkNjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2Ft
ZC9hbWRncHU6IEZpeCBsb2dpYyBidWcgaW4gZmF0YWwgZXJyb3IgaGFuZGxpbmcNCg0KQW0gMjMu
MDMuMjMgdW0gMTM6MDQgc2NocmllYiBTcmluaXZhc2FuIFNoYW5tdWdhbToNCj4gQ0MgICAgICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLm8NCj4gZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOjI1Njc6Mjg6IGVycm9yOiBiaXR3aXNlIG9yIHdpdGgg
bm9uLXplcm8gdmFsdWUgYWx3YXlzIGV2YWx1YXRlcyB0byB0cnVlIFstV2Vycm9yLC1XdGF1dG9s
b2dpY2FsLWJpdHdpc2UtY29tcGFyZV0NCj4gICAgICAgICAgICAgICAgaWYgKGFkZXYtPnJhc19o
d19lbmFibGVkIHwgQU1ER1BVX1JBU19CTE9DS19fREYpDQo+ICAgICAgICAgICAgICAgICAgICB+
fn5+fn5+fn5+fn5+fn5+fn5+fn5efn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+DQo+IFByZXN1bWFi
bHkgdGhlIGF1dGhvciBpbnRlbmRlZCB0byB0ZXN0IGlmIEFNREdQVV9SQVNfQkxPQ0tfX0RGIGJp
dCB3YXMgDQo+IHNldCBpZiByYXMgaXMgZW5hYmxlZCwgc28gdGhhdCdzIHdoYXQgSSdtIGNoYW5n
aW5nIHRoZSBjb2RlIHRvLiANCj4gSG9wZWZ1bGx5IHRvIGRvIHRoZSByaWdodCB0aGluZy4NCg0K
VGhhdCBsb29rcyBsaWtlIGEgbmljZSBjYXRjaCB0byBtZSwgYnV0IEkgZG9uJ3QgcmVhbGx5IGtu
b3cgdGhlIHJhcyBjb2RlIHRoYXQgd2VsbC4NCg0KSGF3a2luZywgTHViZW4gb3Igd2hvZXZlciBp
cyBtb3JlIGZhbWlsaWFyIHdpdGggdGhhdCBzaG91bGQgcHJvYmFibHkgY29tbWVudCBhcyB3ZWxs
Lg0KDQpDaHJpc3RpYW4uDQoNCj4NCj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4NCj4gQ2M6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFu
bXVnYW1AYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhcy5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
Yw0KPiBpbmRleCA1YjE3NzkwMjE4ODExLi5mYWM0NWY5ODE0NWQ4IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IEBAIC0yNTY0LDcgKzI1NjQsNyBAQCBp
bnQgYW1kZ3B1X3Jhc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIAkJCWFk
ZXYtPm5iaW8ucmFzID0gJm5iaW9fdjdfNF9yYXM7DQo+ICAgCQlicmVhazsNCj4gICAJY2FzZSBJ
UF9WRVJTSU9OKDQsIDMsIDApOg0KPiAtCQlpZiAoYWRldi0+cmFzX2h3X2VuYWJsZWQgfCBBTURH
UFVfUkFTX0JMT0NLX19ERikNCj4gKwkJaWYgKGFkZXYtPnJhc19od19lbmFibGVkICYgQU1ER1BV
X1JBU19CTE9DS19fREYpDQo+ICAgCQkJLyogdW5saWtlIG90aGVyIGdlbmVyYXRpb24gb2YgbmJp
byByYXMsDQo+ICAgCQkJICogbmJpbyB2NF8zIG9ubHkgc3VwcG9ydCBmYXRhbCBlcnJvciBpbnRl
cnJ1cHQNCj4gICAJCQkgKiB0byBpbmZvcm0gc29mdHdhcmUgdGhhdCBERiBpcyBmcmVlemVkIGR1
ZSB0bw0K
