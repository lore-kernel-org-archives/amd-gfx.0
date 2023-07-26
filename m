Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B9CC001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 07:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C57610E0F7;
	Wed, 26 Jul 2023 07:52:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB73310E0F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 07:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX+9qyAOPwahE+JiIwLFC2xILftya3lawnJtEle6HoHJfUGHoH8XPAf1SSZxN1UoE/H66BAuKFo3Om+OhHj3FSJldJV/CWunB08y4yJVR/v46pk96xxMU6jg1oO7NAN9oBJWmZB6RGoy0b+/hikSPyZ/mu/ga34ORdrXm6yFuA6u6KENz5Z3p2XJ2MLDiHOLuhpSLRoFy3yVYf6V8Jt0AIGqAEp5XGEv7T70CWLGysQnLgGTIFhMAILMgbXEc7nss1sFcPjTXqZFjb0CcNNr2zY1hSEfFfMNkENqYMB/DyXfnUkk0++0vrWi/9xJ8lJyu6Ma5EXxs6vH48vfcXgaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSRCANihD44baErx9gJMCGG6MAiE+cwHTQXeoXjBdf8=;
 b=nM1aV3Rqc2luDm8NZaY9E3RT1spJqS8GCl16cF5ykHR4ZvPdU7r1b0jlBkzQlJST0SvZEogRpvFN75iQcWecyGlRpaHUv1r8YJyfOtMMy3Tppe5x1GLRiyL8R9zXh3KkFu7FHOUeyc+as/mTW+q4XhSG35yP9hGOnrW2LocjwYw5n2o9Mvaf08Uui4B0GkUA/0ViWOORTi0HU62KKOQ9qhC+m+o/dY/YMmtKjSIf7llE+eVbz7yzAAdlXYyyeGBRR3urHIDy+pRfmNvUzPeSC91+/LMPsmZfT3kmO9/o7DSDmxksRgxBHndgrA2A97Tq0abDv/pJ9PcJNnpM9SC8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSRCANihD44baErx9gJMCGG6MAiE+cwHTQXeoXjBdf8=;
 b=2wj2yOq24b9nBlV7rgn6xAbVL9t9iXm8hC3Lqb5p5K8nbMESurK0uKf+jiP0tH1xD88ieBkdC6DHutJp7oKS1Rucdsqp4CvNyEi1TILSw7YkNSuETFdSPso8eNyLX69U9GNq8ixXUnY8LpufPKkbhXW3TR8tvj9e60AjZHxMYT0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 26 Jul
 2023 07:52:19 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 07:52:19 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix unnecessary else after return in
 'amdgpu_eeprom_xfer'
Thread-Topic: [PATCH] drm/amdgpu: Fix unnecessary else after return in
 'amdgpu_eeprom_xfer'
Thread-Index: AQHZv5FU49+i6Nu0IEi2/CSRuZ6kjK/LrKtQ
Date: Wed, 26 Jul 2023 07:52:18 +0000
Message-ID: <DM5PR12MB246964E9F8569E9DC778837EF100A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230726071745.2453891-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230726071745.2453891-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a6e08e2f-b076-400e-8e9b-431eecb3347d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-26T07:51:10Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|SA3PR12MB8812:EE_
x-ms-office365-filtering-correlation-id: addae660-6fa4-4a36-a8de-08db8dad3ca2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hF4qvgYYy2EcXH92w3BYEmTn26BQFFtuhaBb/PaSWjQHd7r7/E+TjEeZZKUzDe8U0k2RRMsuvEPuXRIAiSIheW4EFl+EYVoritYyPQ4grREWDrZ1wDlJ2gO1lEVBBK6cPrLFyT7+Z/ZVW7rv0iU/96TlZV9h99Xcipnnq0j5K3qye1XvfloQ7hTaMLDF3qYSTBX95h80JOPMDFFV81R4qGYx+ddMxkrPxjTSNLrZ8nprbB35a+tLsS7fCPIN1vAljgutlZudEcVyQV+lEFLvWOyt4+Xx25QYowgwfGCRoRPP077L1FXJUevg4lI6ydnh5efe8KQ5vrFcbnELGXLUrC0iwQtpEldl70pmDzbkcGFGLdTcPXhRNikw3IcdBQZjuWY8oWUwC2EE2L4owu2nJstXOA7NqKB3KxrxdjzQMU543NRR8YjB9iRKt5R8diy57y+z0A8UtRHe6Y6WmGbe6I/UpZDPDZ3x9deSOn9eN88gN87RdYIOJ7ovpRYWa9V4w++A9OmuA70Fj5Fn3ibuYyiZklZHVCKcA3IIuQzR2Y3BwnaTNsycrY4cQvCWlTpCi59jC9YOxyXBvdvZOl/5ohitkkL+CDTCrEbDAOPH+jcmMRrx9iU6+DZsVH0lMZDk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(33656002)(41300700001)(55016003)(2906002)(66574015)(8936002)(26005)(186003)(71200400001)(4326008)(6506007)(5660300002)(83380400001)(53546011)(64756008)(76116006)(66946007)(6636002)(52536014)(8676002)(66476007)(316002)(7696005)(66556008)(66446008)(110136005)(9686003)(478600001)(38100700002)(86362001)(38070700005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVRUd2V3NW9udm1lK1FJSWxCSWR3NVM5WlQwcTBFaVFoaEFyRkU4alc1dU5E?=
 =?utf-8?B?eXdMazJDU3ZFaFlPT3c0L3NkT0craG5WOUh2UkdJdGZLRDdVQ3h2Yk9qZmND?=
 =?utf-8?B?M0Q2WWlJcUk0cjQ4cXRFck1PM253dm1IMGNwcEFSK21qd0cxWnM0VWRWYWhO?=
 =?utf-8?B?dzNZcHJEQm9EbW1yZ2tVbTQwdUtpejd3b2t3UnlNZDYyUkREUzRJSDdJdUNq?=
 =?utf-8?B?ZlVBY3NIR0xXaE5VdW9zVEl4Wk5KaTZqKzlNNkF3UDUxa0RZSlkxV3BTeENK?=
 =?utf-8?B?VlZpYWc1THpUSllGMTMrMk1reWJ0b1NEQmdJYXpTQTVVUGVUeXk2QXcrMWY0?=
 =?utf-8?B?NlhEYXFyNUxqbTdVMnZLb2NFaVg0U2pDa2ZuVWNjVDRsRTNiYWIrR0pJbjVF?=
 =?utf-8?B?RXY5WmV6cEcxYzZYcVdZZE52THRiN0dMQnZvbEQ2bmlXNnJDUTFpS0tSemVo?=
 =?utf-8?B?K2tYUytpQ21nWCszU0JQOXcrRklQNlR0cG1NRzNaZnNGc0NYQTF5SGlGV3l3?=
 =?utf-8?B?RTF1dCtvRzIzc1hZZ042bFBkbUVCYm9oSDFIdllaRXRNaVNjZFdJOVJTWVI5?=
 =?utf-8?B?VUxqMG9xeFIwYXoyS2lsYmVXd2o0OWVrdWlTUmh2K2NuZ1BoeWpkRXBuOGxv?=
 =?utf-8?B?ZnViNk5VMElTY0IvejNPcWZGQ0RZd25WUzk4eDVyTmttTWRDdit5Lyt0UnRM?=
 =?utf-8?B?UXRZVmpLR2tTZWlrVW5Sb2wwbkhCUEo2cVB6UHA1d3luSEhOa2tTTis3QnNP?=
 =?utf-8?B?V2Z4bmo1ZDg1bU5vdU1uNlhmQ002VVFHU0Q2RjFIWlVNeks4MHBzNU9Jdjha?=
 =?utf-8?B?Mkl1ZExId1YrOXZYZW4yT0xoeGdocHZwOVhkSml2WVA0U1Z5NTE2R0Nab0Jr?=
 =?utf-8?B?MEpIMWtsWmsrbjdnN1lGbG5HUzlrK1M2MEtoNkJzM2sxWEFOdFZLOE0ycEJu?=
 =?utf-8?B?SjViNG5QQU92VTJ3djZhWnVla28waldHbHB3TGpHMFlNQTZMWXpyK2d1Q0lx?=
 =?utf-8?B?alBSQ2tSMCt4azBSM2wxZ3pyU2hjWk1FUVFramFXZ3MyT2FxVFlwYWpIMWFG?=
 =?utf-8?B?NG9ta3NmTGx5WWt3ZFlZVnRING5KNFBtek5jSU9CdkxRVUZXWThIT2kvWnVD?=
 =?utf-8?B?a09YclRkdGVRdmp0ckdSMEhUNXRiV0JwbnIxblZlbm9EVmdLUGdwd0tSa1B1?=
 =?utf-8?B?RXFjd2IwOHhpd3JNWEhqOTduSlVkRzJKN3RrUjZkTUNIa2piMEFJUVNqcWtP?=
 =?utf-8?B?dndxeUs1Z1dSY0Izb2tsdXNqQnhHVHdkM3FtTmVuZldCenNKQWxTUEZXcDFH?=
 =?utf-8?B?OFAvMFZzVlY0K21KT0JWL2oxbnFWdG1DeTRPUUxKWVltcWZHMVY3Z05KUU9v?=
 =?utf-8?B?MjJtQWFNZjNhS2M0eUp2OWJLN0FjS01CYVZGNVZsUFEzOUtyUGZtem9kSnc0?=
 =?utf-8?B?b0tGNmU2VkZxeWxyMFJVcUdGOFhSSitldUZYVFZSVklaUWcvSWhFekJsckJF?=
 =?utf-8?B?RStaZkNRQXhPQkNzTkRvVmQxaXFuSHkybjZ6b2s1Mm8yR2tSSDNFYVk1eDBP?=
 =?utf-8?B?QUZwNjVZNHJUdU9vcFhMYTF2OVZqZTRaSWVYYThPcWtiTHdteFM5YkZqTm1O?=
 =?utf-8?B?V1RycHRDQ05pWTNXaDZCcUpJaDBuTmxWa2NFVWo1bTdrR2N2OGZOMXp3VFhl?=
 =?utf-8?B?dkRrenlRZE44NVRSdDlySDdLdWRnSisvU2xmeXgyZXFXZ1AxMUtkRHU2eHA2?=
 =?utf-8?B?eE15S3B6am5jUjZtTk8rcVcvTkxDVXhRVmNpSHlkczdxQzZIOU1zd2RSSmZR?=
 =?utf-8?B?cnFFQzM2VkxCb0g4SUI0UnRoL1QxZjNvT1o3YnNrU1B4YmFzdEpBdmw1SW1y?=
 =?utf-8?B?bmJIbElWekk4WUZmYTNwV1ZiVUtWSGl3YW14MlI5ZUlMNXVjWXlIMDJqZklG?=
 =?utf-8?B?bEM4bVQ0QnlmbHdxR1lXRitRTWlRYjFqcndwN2puSXBXTFdQQ0FLNG44M2NL?=
 =?utf-8?B?OWY2YXRrZ3EvRUdZNkZVeWJJUHZFWTZhVVZWV2o3RkM5WVJyeDlQS1Z5NmdM?=
 =?utf-8?B?WEVuUzA1T2paRVgvemtBd2M3WHo5L25LUWx4U1JmbDNPcWQza3p0ZUVIbXVK?=
 =?utf-8?Q?r/KA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addae660-6fa4-4a36-a8de-08db8dad3ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 07:52:18.8951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8enBYb5PFpSTZSS7D3976PqPyvB/aFPBZTSbeu7VnofR91Ep5M/e55Ylkhw7vshCh0b9axJTNb1IAegaQswODA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
Pg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNIQU5NVUdBTSwgU1JJ
TklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBKdWx5IDI2LCAyMDIzIDM6MTggUE0NCj4gVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FODQo+IDxT
UklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRn
cHU6IEZpeCB1bm5lY2Vzc2FyeSBlbHNlIGFmdGVyIHJldHVybiBpbg0KPiAnYW1kZ3B1X2VlcHJv
bV94ZmVyJw0KPg0KPiBGaXhlcyB0aGUgZm9sbG93aW5nOg0KPg0KPiBXQVJOSU5HOiBlbHNlIGlz
IG5vdCBnZW5lcmFsbHkgdXNlZnVsIGFmdGVyIGEgYnJlYWsgb3IgcmV0dXJuDQo+ICsgICAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKyAgICAgICB9IGVsc2Ugew0KPg0KPiBDYzogR3Vj
aHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+DQo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxz
cmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9lZXByb20uYyB8IDM5ICsrKysrKysrKysrLS0tLS0tLS0tDQo+IC0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZWVwcm9t
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZWVwcm9tLmMNCj4gaW5k
ZXggN2QyYTkwODQzOGU5Li5lNzE3Njg2NjFjYTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9lZXByb20uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZWVwcm9tLmMNCj4gQEAgLTE4Myw2ICsxODMsOCBAQCBzdGF0aWMg
aW50IGFtZGdwdV9lZXByb21feGZlcihzdHJ1Y3QgaTJjX2FkYXB0ZXINCj4gKmkyY19hZGFwLCB1
MzIgZWVwcm9tX2FkZHIsICB7DQo+ICAgICAgIGNvbnN0IHN0cnVjdCBpMmNfYWRhcHRlcl9xdWly
a3MgKnF1aXJrcyA9IGkyY19hZGFwLT5xdWlya3M7DQo+ICAgICAgIHUxNiBsaW1pdDsNCj4gKyAg
ICAgdTE2IHBzOyAvKiBQYXJ0aWFsIHNpemUgKi8NCj4gKyAgICAgaW50IHJlcyA9IDAsIHI7DQo+
DQo+ICAgICAgIGlmICghcXVpcmtzKQ0KPiAgICAgICAgICAgICAgIGxpbWl0ID0gMDsNCj4gQEAg
LTIwMCwyOCArMjAyLDI1IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2VlcHJvbV94ZmVyKHN0cnVjdCBp
MmNfYWRhcHRlcg0KPiAqaTJjX2FkYXAsIHUzMiBlZXByb21fYWRkciwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGVlcHJvbV9hZGRyLCBidWZfc2l6ZSwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWQgPyAicmVhZCIgOiAid3JpdGUiLA0KPiBFRVBS
T01fT0ZGU0VUX1NJWkUpOw0KPiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAtICAg
ICB9IGVsc2Ugew0KPiAtICAgICAgICAgICAgIHUxNiBwczsgLyogUGFydGlhbCBzaXplICovDQo+
IC0gICAgICAgICAgICAgaW50IHJlcyA9IDAsIHI7DQo+IC0NCj4gLSAgICAgICAgICAgICAvKiBU
aGUgImxpbWl0IiBpbmNsdWRlcyBhbGwgZGF0YSBieXRlcyBzZW50L3JlY2VpdmVkLA0KPiAtICAg
ICAgICAgICAgICAqIHdoaWNoIHdvdWxkIGluY2x1ZGUgdGhlIEVFUFJPTV9PRkZTRVRfU0laRSBi
eXRlcy4NCj4gLSAgICAgICAgICAgICAgKiBBY2NvdW50IGZvciB0aGVtIGhlcmUuDQo+IC0gICAg
ICAgICAgICAgICovDQo+IC0gICAgICAgICAgICAgbGltaXQgLT0gRUVQUk9NX09GRlNFVF9TSVpF
Ow0KPiAtICAgICAgICAgICAgIGZvciAoIDsgYnVmX3NpemUgPiAwOw0KPiAtICAgICAgICAgICAg
ICAgICAgIGJ1Zl9zaXplIC09IHBzLCBlZXByb21fYWRkciArPSBwcywgZWVwcm9tX2J1ZiArPSBw
cykgew0KPiAtICAgICAgICAgICAgICAgICAgICAgcHMgPSBtaW4obGltaXQsIGJ1Zl9zaXplKTsN
Cj4gLQ0KPiAtICAgICAgICAgICAgICAgICAgICAgciA9IF9fYW1kZ3B1X2VlcHJvbV94ZmVyKGky
Y19hZGFwLCBlZXByb21fYWRkciwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBlZXByb21fYnVmLCBwcywgcmVhZCk7DQo+IC0gICAgICAgICAgICAgICAg
ICAgICBpZiAociA8IDApDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBy
Ow0KPiAtICAgICAgICAgICAgICAgICAgICAgcmVzICs9IHI7DQo+IC0gICAgICAgICAgICAgfQ0K
PiArICAgICB9DQo+DQo+IC0gICAgICAgICAgICAgcmV0dXJuIHJlczsNCj4gKyAgICAgLyogVGhl
ICJsaW1pdCIgaW5jbHVkZXMgYWxsIGRhdGEgYnl0ZXMgc2VudC9yZWNlaXZlZCwNCj4gKyAgICAg
ICogd2hpY2ggd291bGQgaW5jbHVkZSB0aGUgRUVQUk9NX09GRlNFVF9TSVpFIGJ5dGVzLg0KPiAr
ICAgICAgKiBBY2NvdW50IGZvciB0aGVtIGhlcmUuDQo+ICsgICAgICAqLw0KPiArICAgICBsaW1p
dCAtPSBFRVBST01fT0ZGU0VUX1NJWkU7DQo+ICsgICAgIGZvciAoIDsgYnVmX3NpemUgPiAwOw0K
PiArICAgICAgICAgICBidWZfc2l6ZSAtPSBwcywgZWVwcm9tX2FkZHIgKz0gcHMsIGVlcHJvbV9i
dWYgKz0gcHMpIHsNCj4gKyAgICAgICAgICAgICBwcyA9IG1pbihsaW1pdCwgYnVmX3NpemUpOw0K
PiArDQo+ICsgICAgICAgICAgICAgciA9IF9fYW1kZ3B1X2VlcHJvbV94ZmVyKGkyY19hZGFwLCBl
ZXByb21fYWRkciwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWVw
cm9tX2J1ZiwgcHMsIHJlYWQpOw0KPiArICAgICAgICAgICAgIGlmIChyIDwgMCkNCj4gKyAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiByOw0KPiArICAgICAgICAgICAgIHJlcyArPSByOw0KPiAg
ICAgICB9DQo+ICsNCj4gKyAgICAgcmV0dXJuIHJlczsNCj4gIH0NCj4NCj4gIGludCBhbWRncHVf
ZWVwcm9tX3JlYWQoc3RydWN0IGkyY19hZGFwdGVyICppMmNfYWRhcCwNCj4gLS0NCj4gMi4yNS4x
DQoNCg==
