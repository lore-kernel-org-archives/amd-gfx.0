Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA91C4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 22:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE82112EAE;
	Tue,  6 Feb 2024 22:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hgqIKKLN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC3D112EAE
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 22:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dgz/cFTevv1vuPfRYF3Pg31C6tMt6xefZe1PKBa00TFJVpkOwxFeR6C65w2wwEiQilJSk73rk8VWwH9gC9v4alZG7xFOELNgvS930p3yLmM2fy/tWnQL4vi+tDK+ZYmyigiyQqafnLcz0wHnlk99fPoKLm3kju8jpwMJOlbnagJnkiQKlfLE9cOm1kCR+Kp0b3L+RdVQj82bIo2U9LoYY4xp1u874OZRBZ/O86C0v5u+pdTqeJlInivXTBq7qqzVwxl9bI01goc+x+yLcYJnLz1fCwh9rLkEmFsoc6PsTDTdPbKHz1aPk4h3jx+Ujs2DBETgGkJZZrN363Nb4XJYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W6JT19T9gj7aFEOXGlNZOX2SOU79W/g/g6iit3SO7Y=;
 b=XfRTOz2D5xIw4ENp6yacLBJq/INb1Q1M7MFiGwXwab5/s8SV0o/SfrbHDYn1AfrTbxI0cTAIGn6VKWngUvT1bJnQCk73A1IKsZs67yaRV3QSKN53Ds9PgBvB8pmSeyHcCEe9KjxqDs876A+yCJdae1fyq2ABxNlghfoytKsbxBgEyt8hXNyGQS93/6Ke0V+xAbjQ/Kx8Wh+rQXr8xKE663vcKum+wcjoX1ynatq12yWczLy/p/5ZrmKHMUom9rJELvb8GqWGgfZiqeyLlqBJVgRl5I377N9N+UkfI0RkUqgIl9woBO+xmgxSy8y2IYL/SwE/aJfzltU+Nco75T3wLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W6JT19T9gj7aFEOXGlNZOX2SOU79W/g/g6iit3SO7Y=;
 b=hgqIKKLN1YiReZfCaXcyKVO/4osk3Iu4Hu6HFMTn3f+ZX8YWaRKNHFNJDWea+MdRscIZotLOspEs+TChZnjo4OrnpMFZ7Ft46AO+yanbS9n0gFgdK5jWPITkC0RQ5QSlB9znibQ+zupdv2NfFnu2WIbXvMF/EL83WZ/kjQorHv8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 22:00:26 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 22:00:26 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 =?utf-8?B?SsO8cmcgQmlsbGV0ZXI=?= <j@bitron.ch>
Subject: RE: [PATCH] drm/amd: Set s0i3/s3 in prepare() callback instead of
 suspend() callback
Thread-Topic: [PATCH] drm/amd: Set s0i3/s3 in prepare() callback instead of
 suspend() callback
Thread-Index: AQHaWUatS7j/quzOkUSs7zNDnzCG87D93GjQ
Date: Tue, 6 Feb 2024 22:00:26 +0000
Message-ID: <BL1PR12MB5144221A0577FD5A0BA4726DF7462@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240206213151.22499-1-mario.limonciello@amd.com>
In-Reply-To: <20240206213151.22499-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0dffc39c-a313-4a98-b3c7-5f0a34386db1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-06T21:57:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW3PR12MB4489:EE_
x-ms-office365-filtering-correlation-id: 498c96bb-5dbf-4788-4e5d-08dc275f0663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZXdsuKv/tyWeRsoTQeTJjLeyq4j3C85kjyME1bqvE4O0Kzu3r9aRhvTQen2ddkP3Nvq+gJh2L5CGqgiWuoYA5Ys25/aEimKOhl4I2gVS8t67VilgMXWyFM+SL/CY2jQmi66dm5HSIEJAZYZ4wU4theRukgvKTPFbW/yQK50Zo3sWh6ZdWJXeusT3SOLNDfGOzjFxMazpgHKIV3al7vgjkYBqipd+O2YLYYP7moI/iywF/OkFxyvNgfN9BeOll9i1zsX1Vt4w3lqcoq6BG+wOC8/6OV8q4hFIVJR+4jjJzc2cJR/yNDfTM4k+FfpVyMjMqIogQmrT/rQ6bVUZAJwWF3pgss3+VeaamHB3640Cab3ZfVznD89YykhS4KphbC0+nXIuBw386xeIUmsv8JNE8FaBQ1mxq+Ax4EElAYiRxaiBH0WNphkTGkRDFJ7px6b/4TTI7/yXa41v1wt0ULP5NdL9XXgAfy4rWdOQ0xEcUOw6U3QNVI+TuQxk0uUi4184huKYdq1HCV3KM0XrdrhOfPolhrexsVbKWwFxEbWnTRWmd8LVun4qH/Q3NFoLYkVy2CQixmiL+D1sERDotSgp6itliEgUXrQ4rUS9Vk9nBRQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(26005)(478600001)(86362001)(7696005)(6506007)(9686003)(53546011)(966005)(66574015)(38100700002)(71200400001)(122000001)(55016003)(83380400001)(33656002)(52536014)(316002)(54906003)(66476007)(66556008)(66446008)(64756008)(66946007)(4326008)(110136005)(5660300002)(41300700001)(15650500001)(2906002)(8676002)(76116006)(8936002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0xsZ3ZLVTZXWUdIQjJETmlOREkxRFNrbHNBQnNUQVpEU0Y3b2JNUmRiM0RK?=
 =?utf-8?B?dnBCSFJhdFhueXY2Y2x1RTlLNVRERjl5dHF3NGIvdmllNjJqazAxbkxiUEhH?=
 =?utf-8?B?N1NDWVhKU01VVWZTeE5yMkVoekFDeXRPckUrblV4S2xkL1VnYmpPNW5PYUI3?=
 =?utf-8?B?UVZJSysyeFBWT05IRkNvd1BDSGd3aXdMclJXMVZuSXUzSlVBbXV0REczRGVp?=
 =?utf-8?B?RkozT1d0MW1KQ2RxK1ppcVc1TXFEMll5K0IzN05KMXYwTDdJajgzSThRT2lD?=
 =?utf-8?B?eUJNVzQ1MmhRMFVHVzVUUjJOMm5POFR1SEd4UEExaGZyTlN0T2hoMTlBcEEx?=
 =?utf-8?B?L3JZVGZIb0tVeURlMFlWelA3MXBBaHJmZEZoNGw3Zit5TXI3MFZBcDR0Nm5E?=
 =?utf-8?B?c2hmZEo2RFZYNmVMY2VBT1RzTHl2MW1kN1RrbmUxS2VJVkFVb1VGYVNneGwy?=
 =?utf-8?B?YUdXd2w4TjI2bDhvUWFOMTE1L3h2VDFZV05OTys2MnVhOWExU2kzTmViS2t4?=
 =?utf-8?B?SlJrZTJlRnVhOUNZeVdMeTRWbHR0TFloTitKUmYyblZWN3pMRndIemR6SGJ5?=
 =?utf-8?B?Z2xPOEdocWQwbmlmUnA5R0NsWCsxb0hzSHdXMHlZSGdHTS9aVTZiK2VnWFdn?=
 =?utf-8?B?MklNRTFvRk1SamxxdWc3c2pOUnV1TzU4b2JWZXpzRE8veUttcm5uUFVNMTQr?=
 =?utf-8?B?cWtaVjcwTU5yNkZEQkFDa2EyREo4RC9Ca2p2YnZvZUd1RTZNMHpkNHg5aUgv?=
 =?utf-8?B?dVZiWHhPODFXK2VPeTJjWmFDRG50cDdBbnJPSDV5ZFZCODRqV1hucUlvK2xx?=
 =?utf-8?B?bFpuR1FGRjRGZEtYOWd3amN3REg5MWwrK1IybE1BbTAwcXVtL1RTMnNHdXU2?=
 =?utf-8?B?MmwzbHVSWXQ5MHByUDdNck5aZlQwYjVyaWtQMWNGMXNmQ1dnbktxaG5PQlZD?=
 =?utf-8?B?N2dBR2JYRWRMS0VRcHVJZUhkWUFrZUxkNlFZcVMxTUxHT2k4OE5MK0pGL0g5?=
 =?utf-8?B?bzZubG5TdmhTRGxCaHVqd0xTa0VIR2dld2Vqa1ZWd3ZrYjEzcmZIZWN4czh3?=
 =?utf-8?B?MDRNQ1JneWxGWXFMNkt3R0lPUnFPNDJJUnBRb0RHMVQvb0VSTlVpbWIwK1ZW?=
 =?utf-8?B?TEMwQlliOGRXZ1FNMUlRZmo3ZjdrREhET294UkRwTXNSajJNVndCNFZFMytQ?=
 =?utf-8?B?TzlPT0VmcEx4UVo5NndtMkVNN09EQlBRQ3B1Zmt4Zi85OWgrYjlEMW5namR0?=
 =?utf-8?B?alY2UC9GSXpEcE1Ib1ZTYXU3VU1vU1pWbXdySTFkc0FXT2JXRXlORFgwV28x?=
 =?utf-8?B?cjdET0MycGpud2lVZ1lHUkdaOXVWKzF3bDd3bGNyMFdMUTc1bDhHRkFqb2JV?=
 =?utf-8?B?VFVJNlFqNEQ2NGVpOFYwN3pteDZGeW1WWGxaUXlMcWlVV3UxbUVhSWRONHBL?=
 =?utf-8?B?MjBWVnB1N3daaEVDTzFNdk5ZTkE3U29SQ0daWWM5TFAzYzRYKzlGY0x1T3dh?=
 =?utf-8?B?Z2xKNlRwdnJ1d045K1BxeTdDOUJXZk1PdUNLY0hFYW1HMnJnU3VLVUN4eDZX?=
 =?utf-8?B?ZmhIUmZRamJQQ1Zxb1VDZXFEZHhwM2tWZUh4SGxxTTBnSFBlcVhrYzVVdEV5?=
 =?utf-8?B?RVVERHJ5UnhJUkhCbG5NZGFSR3dDMzJiTjcySVdaTjFiYmdqSWxzRjBqTk1v?=
 =?utf-8?B?OUlHVklBVEZZMEdtdWV1RjZic01uY3lRUlI5cXd0WkFkK2V3NnBrM0VwZEFr?=
 =?utf-8?B?ekR3bWZPU1hkRmo5Y1ZKaHYxdGFZVmI2bWh0UTVmQUhPREZBZGlLM3BZRCtK?=
 =?utf-8?B?Zk9CQ1lXRzBRdllrRmJpbTdNeG5zVndxbHBNUHhEZXZ5OEFKVlkrMG1FV3dF?=
 =?utf-8?B?eXc0YU1kTGxGSXZ6Z1I0MnJxSHdvTHBWSjFTZlFnempWeHoxbXBzY2pQc1cr?=
 =?utf-8?B?N05lZGFVL2hMWUdqK1hMVEZRQ0JUVWltWndVUThadER5LzRSVUdvZU5wSjBE?=
 =?utf-8?B?L2kyUjMzUWVrQkxHWFRFS1RjK2d6a29oQlZ1WEZCZ0RsOStHSGtHRHFaM04y?=
 =?utf-8?B?RTN2YW1td3Ztd2dFVlA5TXV2aEtwN053dW42TTU2aTBYUGpCYlFpU01oWjQy?=
 =?utf-8?Q?eW10=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498c96bb-5dbf-4788-4e5d-08dc275f0663
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 22:00:26.1962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMfSNrvSJvbCsv2aiyvxMnxZLkQnp3o9yElkplneqX9++oR7hwK3OouJP4BdtByQIB+LkgXNCxWaHKaHnnwRAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIE1hcmlvDQo+IExpbW9uY2llbGxvDQo+IFNlbnQ6IFR1ZXNk
YXksIEZlYnJ1YXJ5IDYsIDIwMjQgNDozMiBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4gQ2M6IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1k
LmNvbT47IErDvHJnIEJpbGxldGVyDQo+IDxqQGJpdHJvbi5jaD4NCj4gU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kOiBTZXQgczBpMy9zMyBpbiBwcmVwYXJlKCkgY2FsbGJhY2sgaW5zdGVhZCBvZg0K
PiBzdXNwZW5kKCkgY2FsbGJhY2sNCj4NCj4gY29tbWl0IDUwOTVkNTQxODE5MyAoImRybS9hbWQ6
IEV2aWN0IHJlc291cmNlcyBkdXJpbmcgUE0gb3BzIHByZXBhcmUoKQ0KPiBjYWxsYmFjayIpIGlu
dGVudGlvbmFsbHkgbW92ZWQgdGhlIGV2aWN0aW9uIG9mIHJlc291cmNlcyB0byBlYXJsaWVyIGlu
IHRoZQ0KPiBzdXNwZW5kIHByb2Nlc3MsIGJ1dCB0aGlzIGludHJvZHVjZWQgYSBzdWJ0bGUgY2hh
bmdlIHRoYXQgaXQgb2NjdXJzIGJlZm9yZQ0KPiBhZGV2LT5pbl9zMGl4IG9yIGFkZXYtPmluX3Mz
IGFyZSBzZXQuIFRoaXMgbWVhbnQgdGhhdCBBUFVzIGFjdHVhbGx5IHN0YXJ0ZWQgdG8NCj4gZXZp
Y3QgcmVzb3VyY2VzIGF0IHN1c3BlbmQgdGltZSBhcyB3ZWxsLg0KPg0KPiBNb3ZlIHRoZSBzMGkz
L3MzIHNldHRpbmcgZmxhZ3MgaW50byBwcmVwYXJlKCkgdG8gZW5zdXJlIHRoYXQgdGhleSdyZSBz
ZXQgZHVyaW5nDQo+IGV2aWN0aW9uLiBEcm9wIHRoZSBleGlzdGluZyBjYWxsIHRvIHJldHVybiAx
IGluIHRoaXMgY2FzZSBiZWNhdXNlIHRoZSBzdXNwZW5kKCkNCj4gY2FsbGJhY2sgbG9va3MgZm9y
IHRoZSBmbGFncyB0b28uDQo+DQo+IFJlcG9ydGVkLWJ5OiBKw7xyZyBCaWxsZXRlciA8akBiaXRy
b24uY2g+DQo+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQv
LQ0KPiAvaXNzdWVzLzMxMzIjbm90ZV8yMjcxMDM4DQo+IEZpeGVzOiA1MDk1ZDU0MTgxOTMgKCJk
cm0vYW1kOiBFdmljdCByZXNvdXJjZXMgZHVyaW5nIFBNIG9wcyBwcmVwYXJlKCkNCj4gY2FsbGJh
Y2siKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVs
bG9AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMgfCAxNCArKysrLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMTAgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZHJ2LmMNCj4gaW5kZXggYjc0ZjY4YTE1ODAyLi4xOTBiMmVlOWUzNmIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gQEAgLTI0NjQsMTIgKzI0
NjQsMTAgQEAgc3RhdGljIGludCBhbWRncHVfcG1vcHNfcHJlcGFyZShzdHJ1Y3QgZGV2aWNlDQo+
ICpkZXYpDQo+ICAgICAgICAgICBwbV9ydW50aW1lX3N1c3BlbmRlZChkZXYpKQ0KPiAgICAgICAg
ICAgICAgIHJldHVybiAxOw0KPg0KPiAtICAgICAvKiBpZiB3ZSB3aWxsIG5vdCBzdXBwb3J0IHMz
IG9yIHMyaSBmb3IgdGhlIGRldmljZQ0KPiAtICAgICAgKiAgdGhlbiBza2lwIHN1c3BlbmQNCj4g
LSAgICAgICovDQo+IC0gICAgIGlmICghYW1kZ3B1X2FjcGlfaXNfczBpeF9hY3RpdmUoYWRldikg
JiYNCj4gLSAgICAgICAgICFhbWRncHVfYWNwaV9pc19zM19hY3RpdmUoYWRldikpDQo+IC0gICAg
ICAgICAgICAgcmV0dXJuIDE7DQo+ICsgICAgIGlmIChhbWRncHVfYWNwaV9pc19zMGl4X2FjdGl2
ZShhZGV2KSkNCj4gKyAgICAgICAgICAgICBhZGV2LT5pbl9zMGl4ID0gdHJ1ZTsNCj4gKyAgICAg
ZWxzZSBpZiAoYW1kZ3B1X2FjcGlfaXNfczNfYWN0aXZlKGFkZXYpKQ0KPiArICAgICAgICAgICAg
IGFkZXYtPmluX3MzID0gdHJ1ZTsNCj4NCg0KV2lsbCByZXN1bWUgYWx3YXlzIGdldCBjYWxsZWQg
dG8gY2xlYXIgdGhlc2UgYWZ0ZXIgYWZ0ZXIgcHJlcGFyZT8gIFdpbGwgdGhlc2UgZXZlciBnZXQg
c2V0IGFuZCB0aGVuIG5vdCB1bnNldD8NCg0KQWxleA0KDQo+ICAgICAgIHJldHVybiBhbWRncHVf
ZGV2aWNlX3ByZXBhcmUoZHJtX2Rldik7ICB9IEBAIC0yNDg0LDEwICsyNDgyLDYNCj4gQEAgc3Rh
dGljIGludCBhbWRncHVfcG1vcHNfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgICAg
IHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICAg
ICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZHJtX3RvX2FkZXYoZHJtX2Rldik7DQo+
DQo+IC0gICAgIGlmIChhbWRncHVfYWNwaV9pc19zMGl4X2FjdGl2ZShhZGV2KSkNCj4gLSAgICAg
ICAgICAgICBhZGV2LT5pbl9zMGl4ID0gdHJ1ZTsNCj4gLSAgICAgZWxzZSBpZiAoYW1kZ3B1X2Fj
cGlfaXNfczNfYWN0aXZlKGFkZXYpKQ0KPiAtICAgICAgICAgICAgIGFkZXYtPmluX3MzID0gdHJ1
ZTsNCj4gICAgICAgaWYgKCFhZGV2LT5pbl9zMGl4ICYmICFhZGV2LT5pbl9zMykNCj4gICAgICAg
ICAgICAgICByZXR1cm4gMDsNCj4gICAgICAgcmV0dXJuIGFtZGdwdV9kZXZpY2Vfc3VzcGVuZChk
cm1fZGV2LCB0cnVlKTsNCj4gLS0NCj4gMi4zNC4xDQoNCg==
