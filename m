Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045F8C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 12:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870EA10EA7F;
	Thu, 23 Mar 2023 12:39:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4661610EA7F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 12:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7nKJviuBY/hhLcmE9DhNUJ5qpNaqgeZfDs8aFQWKWWwV8ur1M7r+sO6zH25YmFNfIUD8FjIRFcmYIoNJBa1+7qtR/9h2K6AIM3uj03rx62i+grqGgXlJ6AF6St5FI09PsMV6xZLgsseBdGelysqDYcXLhx2b3qGptp83T7eT5D9W//tnSVgzqjSgeHYz4a5pgvbpZtduPbQ8TYbhqJIb3VuHj1DKib5/rOTH6fADbNs2gXN1MvKm1Dhp7zjkRIzWrpEiXBMZTlv+neAeidUE7qucOoq0B3EC0OPYYjjRQ8kTukHR/MzpaWdfNMp9wU0tYjnQFvnyKrVPLHKi6U8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFUQfkWjxugRLLFWYync6/gM8ffYxp7ztTH49e3m2h0=;
 b=JRp3kXHSFUF1D3kBI4ZQU46dWln04pJXH2x3UtaBmBvCxqcp+fs3eAgyWerk/3WmrnY1IyEUeY8KP12LsQXraSYc/6MXYPWWrdgWEfmaX5mFLuEA37rn5cEVDbX5x2iAa6XjY+JAMtKZMksoWbBDzBNvhK8WYkxG8T72c35YZNaJs8LXJeLGSweWxMn2CDmt0D+SFicjz0NSvGzZ7XpfNvUtZLADjN5mWz23lqZO1XSRopFsZoFGorNRBhmIxLz+SrfWi1cBleUzVJN7oqGnoPi8Z/xh5TAVIWdQMLvLveub7TEAHRYQzCiG3sjTx8tAa1hU8j36D+q3JVym/KOvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFUQfkWjxugRLLFWYync6/gM8ffYxp7ztTH49e3m2h0=;
 b=ZN5v7nIvgD07iTQdPyY9QH1ZgpVJO7WXesXgYl/5vpNUNVei2qg4x4SGFHwLSdOwvlej1vl/dx1x6dcmQBJ2KTfDXDPMa7Iqisx3ShnmvLF1PMFZzsEdd5gKueyqWcV1eC7IPDkn9MbootP0LDcv0SSXp5LNxKZ760pGfWxWJ/Y=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 12:39:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 12:39:25 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Index: AQHZXYOUfnKIhUiB4Uq8jjPrM23UvK8ITDCQgAABBYCAAACUUA==
Date: Thu, 23 Mar 2023 12:39:24 +0000
Message-ID: <MN0PR12MB6101A603F1AB913006B243F0E2879@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230323123224.3970818-1-srinivasan.shanmugam@amd.com>
 <MN0PR12MB6101863E54001078B11FA04FE2879@MN0PR12MB6101.namprd12.prod.outlook.com>
 <MN2PR12MB412862810D7180FAD76DB3BC90879@MN2PR12MB4128.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB412862810D7180FAD76DB3BC90879@MN2PR12MB4128.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-23T12:39:23Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=33df8f09-a99d-44cd-bded-b4c8200031ee;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-23T12:39:23Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 39154fed-9ad8-485e-928a-c9b9ae11a571
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH0PR12MB5417:EE_
x-ms-office365-filtering-correlation-id: 392c2d06-a573-4774-6b5e-08db2b9ba276
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZHbtURcFoj1OmI8Ooncz8mWJ8gRbOWuY3e0qNHofnwfgwrbdH7Jl6MSI7V5My30R8VoiohAq7Vo/pqmoFIk+GVbQVCl1N7Dzaj3+0/WuZtUnfrhuFgCEUcKOr/DYH7ytKZifT1MkiSAywezOlNkxfeOy2JxQjIXz7hMgsH272NXKy/yX29x3FCYK/GfZsvTv29ktvpJ0l/zNxQ1n9w/zhnri40X1l53Z1bVKWdctILCHODtukoUYwf1tzcI9dU7WRZAeelnw+bmQvL43/5LXmU6CujGiCXrL+MGD71Z08i5E2HrMKndlETLqMRLrxkECSN95RikzSIsROJ1xc3FkWmZNabijoRgg+XD3CtpRjnSzoIiAkc7T91Imuj+oFWhgByQSZEGRqsEcxJkt6+RX1JCiUChZhGMBoH5MnDGtZaFpUWc/EjDvXdrIJphI7CrMEVN0LSSd1L/keUlF4niZmE2lMbtRY4/HqUTEisznB7byaihXaoPpUNM7JkhOR+5St6YzkNfdB/atYzHeoCip2TOIGCIedcO7CwB5AamgH+wEmvEWj6VeY38X9oktOyPCypZpIugmUO1yJ+n9cTVSHxaxuBPcVJvv3nRj9UkcTN/nMjY+pMy+s/4MMcD+hx2BsX3KxiGhrmddHlpQmbOP/REFSGMWQSU6PoLm8ru2LkW2hRY27YJ0lYOAV4WJDcKBVliO5ErDiWNwVbm1eAK67w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199018)(921005)(55016003)(38100700002)(2906002)(38070700005)(478600001)(83380400001)(7696005)(66574015)(186003)(9686003)(86362001)(33656002)(71200400001)(316002)(110136005)(6636002)(66476007)(66446008)(64756008)(8676002)(66946007)(66556008)(4326008)(76116006)(52536014)(8936002)(26005)(53546011)(6506007)(122000001)(5660300002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUxtcFRncmxwYW9WcUJOMVRYSTBTMk5LajIwc0k3NEwyTGtyMUhHK0RKQlNt?=
 =?utf-8?B?U1p3UTd5Uml4TUlYNFo4L0oyS3VKRHZQeWkzT2FoRmsxWi9pc3l2Q0tOMy9v?=
 =?utf-8?B?Wk9iTVozRDJlRXZzSWdyMjZuY3o3ajR4cThTUDNiMDVlK2xEZ0VBY3VscXVE?=
 =?utf-8?B?RGJ1VEduU0dwN3VGRnFkZnN3VjYxNEFaMGFCU2JMZVJXaHRwaEJJTk40ZGtt?=
 =?utf-8?B?QXB0Nm9ITExJc1JSMzdpZDZGUVFVVFdIVGc1ZEw2U3B6NzFEb1Q0MjlucDl5?=
 =?utf-8?B?ckpwREJLL3RxTmw2QjJQODEyR0xDSzBZQkxTQ0VOZFlZUkxST2RoZkxxZ1VK?=
 =?utf-8?B?MnBJZG9xRUdFR2d3TVFIMHNzRGtJQUFkWm1hVytWRVRFQTNKbFF3Y0dSVUp2?=
 =?utf-8?B?UEZDekpVSlNiaVc0cDRiR1ByWnBRbnhjdExaTVRQcUVVQmdnaENFaHRtUnZm?=
 =?utf-8?B?aG5mbTZLUGluMS9McHdheUloRWxqUW5UNERKMk51YjF2eUJGNElMMU1ScUx2?=
 =?utf-8?B?b2ozTFY3WGZicUNNMWRkb2RoUUc0UU5PT2syd2wwaG1uaGZvQ25hMmx6NU54?=
 =?utf-8?B?UHh5VURwWjg5ajViMWZwamFaMmNWdE1uZVB4U0tyeVhxdUt4Ri95ei81VlZk?=
 =?utf-8?B?cDhDd2RwRS9HTVdHME05N0k4TGY4c2lBM2p5b3BhUnBNSHVEalAwc05yQWtT?=
 =?utf-8?B?T0M1cERjdjZ0UGg0UnBDaHZkWjc1Vk5KM0VOUmlYaGNHNmhjaEdJaWVKb1RP?=
 =?utf-8?B?eWhqUmx2ZFk3YXNHTkdFV2M4Ukx2VWkyL1NERi9HU1FLVzNWbk1yT1FNQUFZ?=
 =?utf-8?B?dnRHdk9WQlRXNlFXd2ozZ1Jsd0JnbXkzWktMUGdITGsveGkrSG04T01wcUs4?=
 =?utf-8?B?Q2VtYldwVlk5WUI3ODZBR2xsR1RQb09vQUpaanNLdkQ0MGFHOGpvM2c1UWVS?=
 =?utf-8?B?dWVkMTQwZGVOK1N6UzA2azJpVjhYN1J0YmRHdHdmL2dIOG5OUHVLNUJlQlox?=
 =?utf-8?B?U2JFQjJjNlhjQjUrbFhybldLS2ovVUYyMUpYZk9TVG9IcXBkdlFTTlpJRWRJ?=
 =?utf-8?B?M05ianYxaWx3MVNyMlBPSENjellNcG9SaVVGKzNJUTEyc21HT1lnWnhUSkdC?=
 =?utf-8?B?NG5xU3F5anJkckFFKzJrVlZhOGhIdWEzT2tBM3FkSmJmQmp2Y1lZOE9CbTd0?=
 =?utf-8?B?amdFNllMU2V2b3JHdURHNUdKK2lVd1ZlTTJwVzNOQU11bi95b2d2OEpVSXZx?=
 =?utf-8?B?dllCUDhGRGhnT2lNcHBqRE0yMHBXdk5KUzE0WEVjbkV5SGgzbjJYUldaSzdX?=
 =?utf-8?B?VEZDZENMaEtFVml3bTcweDRla1B2ejZBZjZhVWFUTjh5aStHUEExZURDRDRl?=
 =?utf-8?B?cHYxSThWU1c5S3UzZ3p0REJteUpzUGp5bGFNVHRNSlpub2N3VDVpVmR4cklt?=
 =?utf-8?B?TTFHVWlTK05ValBDL3BRMWR4UUdjelE4dUFqVTEydWNmV1pQTTFlUTlCMWNJ?=
 =?utf-8?B?elZTTzJYWGhHcG02eU9hQjFSYzVoNlRkTEZSeHIvRC8yTTROZHZPSEVZTHZH?=
 =?utf-8?B?eE5jRDJBYjNBRmdQN3RoQ0JTckE0UERPZXBXWGRzaHJTWEo3eFJrLytVZ1ZM?=
 =?utf-8?B?djMwUExYamF1WGJxNDBSRVB0OXp5ZWx0cS9ZRXdGYW1ONXpXWlZFenBRdzJa?=
 =?utf-8?B?QTZlcGN5a3doM1IvRmxDNW5Td3dMM0cvNlJzY2IvMFlNM05LOGd2aVhoTVlz?=
 =?utf-8?B?ZW9oSERhNDAxZXk5WjIvSEhqUnRPdFE4L1VCU2VxcVorb2g2N1AzTHlUL3Vv?=
 =?utf-8?B?bmhNNFplM2ZOeFJxRk9MWmV1cmhISlZPTDRaRlhSU3FuTUJsOE9GTk5HdXpC?=
 =?utf-8?B?QUtoY1pCL2l3QjBEbUpxazdqcDdhcDBWVXVsZHNiWTRTMlRtQzNpQmg5L2Nw?=
 =?utf-8?B?cEVYVmI3aEwwVmJXb3lVS01DN1FsRXhCK0QzbFBtL0t0MmFDVitKRHEyMzhx?=
 =?utf-8?B?VGFtVk55TFVMYWk2YW1rSzVzOEpDSVNWeXNqZGEyZVV1WEJFUklmSzVJbWhk?=
 =?utf-8?B?aFdTSjEwK1c0c2hNdWtQdVBBL0ZOUDIrRG1udFp0KzFXNkhXcW9YSURPUGRy?=
 =?utf-8?Q?gFnY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392c2d06-a573-4774-6b5e-08db2b9ba276
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 12:39:24.8183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayP+uETubN2PeN3JLCz/Bbn8Y9PMkKhbiW85qIOAmK52m42RljFW0u6n+EtwXP86rl3SGwC0ktNc7a7ueWb2Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
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

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU0hB
Tk1VR0FNLCBTUklOSVZBU0FODQo+IDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KPiBT
ZW50OiBUaHVyc2RheSwgTWFyY2ggMjMsIDIwMjMgMDc6MzcNCj4gVG86IExpbW9uY2llbGxvLCBN
YXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBMaSwgQ2FuZGljZSA8Q2FuZGljZS5MaUBhbWQuY29tPjsNCj4g
WmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1
OiBGaXggbG9naWMgYnVnIGluIGZhdGFsIGVycm9yIGhhbmRsaW5nDQo+IA0KPiBbUHVibGljXQ0K
PiANCj4gSGkgTWFyaW8sDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIGl0IHdhcyBv
biAiIG9yaWdpbi9hbWQtc3RhZ2luZy1kcm0tbmV4dCINCj4gDQoNCk9oLCBpdCdzIGEgbmV3ZXIg
Y2hhbmdlIGp1c3QgbGFuZGVkIHRoYXQgSSBuZWVkZWQgdG8gdXBkYXRlIG15IGxvY2FsIHRyZWUs
IHRoYW5rcy4NCg0KRml4ZXM6IDU3NzhiNDc2MjZiNTEgKCJkcm0vYW1kZ3B1OiBBZGQgZmF0YWwg
ZXJyb3IgaGFuZGxpbmcgaW4gbmJpbyB2NF8zIikNClJldmlld2VkLWJ5OiBNYXJpbyBMaW1vbmNp
ZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCg0KPiANCj4gQmVzdCBSZWdhcmRzLA0K
PiBTcmluaQ0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxs
bywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBN
YXJjaCAyMywgMjAyMyA2OjAzIFBNDQo+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5J
VkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+Ow0KPiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsgTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1kLmNvbT47DQo+IFpoYW5nLCBI
YXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogRml4IGxv
Z2ljIGJ1ZyBpbiBmYXRhbCBlcnJvciBoYW5kbGluZw0KPiANCj4gW1B1YmxpY10NCj4gDQo+IA0K
PiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFNIQU5NVUdBTSwg
U1JJTklWQVNBTg0KPiA+IDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KPiA+IFNlbnQ6
IFRodXJzZGF5LCBNYXJjaCAyMywgMjAyMyAwNzozMg0KPiA+IFRvOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+ID4gPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPiA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT47IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+Ow0K
PiBaaGFuZywNCj4gPiBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+ID4gQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPiA8
U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9h
bWQvYW1kZ3B1OiBGaXggbG9naWMgYnVnIGluIGZhdGFsIGVycm9yIGhhbmRsaW5nDQo+ID4NCj4g
PiBDQyAgICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMubw0KPiA+IGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYzoyNTY3OjI4OiBlcnJvcjogYml0
d2lzZSBvcg0KPiA+IHdpdGggbm9uLXplcm8gdmFsdWUgYWx3YXlzIGV2YWx1YXRlcyB0byB0cnVl
DQo+ID4gWy1XZXJyb3IsLVd0YXV0b2xvZ2ljYWwtYml0d2lzZS0gY29tcGFyZV0NCj4gPiAgICAg
ICAgICAgICAgIGlmIChhZGV2LT5yYXNfaHdfZW5hYmxlZCB8IEFNREdQVV9SQVNfQkxPQ0tfX0RG
KQ0KPiA+ICAgICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fl5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4NCj4gPg0KPiA+IFByZXN1bWFibHkgdGhlIGF1dGhvciBpbnRlbmRlZCB0byB0
ZXN0IGlmIEFNREdQVV9SQVNfQkxPQ0tfX0RGIGJpdA0KPiB3YXMNCj4gPiBzZXQgaWYgcmFzIGlz
IGVuYWJsZWQsIHNvIHRoYXQncyB3aGF0IEknbSBjaGFuZ2luZyB0aGUgY29kZSB0by4NCj4gPiBI
b3BlZnVsbHkgdG8gZG8gdGhlIHJpZ2h0IHRoaW5nLg0KPiA+DQo+ID4gQ2M6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gPiBDYzogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+IENjOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFy
aW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiBDYzogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5a
aGFuZ0BhbWQuY29tPg0KPiA+IENjOiBDYW5kaWNlIExpIDxjYW5kaWNlLmxpQGFtZC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11
Z2FtQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmMNCj4gPiBpbmRleCA1YjE3NzkwMjE4ODExLi5mYWM0NWY5ODE0NWQ4IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiA+IEBAIC0yNTY0
LDcgKzI1NjQsNyBAQCBpbnQgYW1kZ3B1X3Jhc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+
ICphZGV2KQ0KPiA+ICAJCQlhZGV2LT5uYmlvLnJhcyA9ICZuYmlvX3Y3XzRfcmFzOw0KPiA+ICAJ
CWJyZWFrOw0KPiA+ICAJY2FzZSBJUF9WRVJTSU9OKDQsIDMsIDApOg0KPiA+IC0JCWlmIChhZGV2
LT5yYXNfaHdfZW5hYmxlZCB8IEFNREdQVV9SQVNfQkxPQ0tfX0RGKQ0KPiA+ICsJCWlmIChhZGV2
LT5yYXNfaHdfZW5hYmxlZCAmIEFNREdQVV9SQVNfQkxPQ0tfX0RGKQ0KPiA+ICAJCQkvKiB1bmxp
a2Ugb3RoZXIgZ2VuZXJhdGlvbiBvZiBuYmlvIHJhcywNCj4gPiAgCQkJICogbmJpbyB2NF8zIG9u
bHkgc3VwcG9ydCBmYXRhbCBlcnJvciBpbnRlcnJ1cHQNCj4gPiAgCQkJICogdG8gaW5mb3JtIHNv
ZnR3YXJlIHRoYXQgREYgaXMgZnJlZXplZCBkdWUgdG8NCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiAN
Cj4gVGhpcyBjaGFuZ2UgZ2VuZXJhbGx5IG1ha2VzIHNlbnNlIGZvciB3aGF0IHlvdSBzaG93ZWQg
YWJvdmUsIGJ1dCB3aGF0DQo+IHRyZWUgaXMgdGhpcyBhZ2FpbnN0PyAgVGhhdCBkb2Vzbid0IGxv
b2sgbGlrZSBhbWQtc3RhZ2luZy1kcm0tbmV4dCwgTGludXMnIHRyZWUNCj4gb3IgZXZlbiBzb21l
IHJlY2VudCB0YWdzLg0K
