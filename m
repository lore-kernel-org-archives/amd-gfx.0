Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E1FC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954EF61284
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 954EF61284
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 428726EC62;
	Thu, 21 Oct 2021 13:00:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D816E43C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 13:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+ZVLPEQs5Jauk9NFIhqSGrmDWYReh1y/yOdF5PK3YpUX8e0igh6D5l8vz9CY7AzU4xa4iPFi43gzWlLzd6XLsRqGstZZj7Xw7GlxR0zPK9lvj1MTUuk3uKz3lLqNMnf0+q1SqW5KTjav8wBJ/236B47pscwoCQ+pWdlFdPFEG0WE3/KgL+11be4oOV0hUYbRrrP4pDG3w4v+wDP7fjUJjH72v9laIF5NLFELDx85sAyVv78zxf6uurwSjA+ZCgAmpXiE/v64TYqLjy/hSm+q5MZnQF0ljCgPaEyeqesgBkfx/USyYt6eCO+0ULnOT3Re8k6SjkiheKx87Hkv2DBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sizqbXXLaCuinv6/bbI5Db1NuVmUiwhWGOhrkv8jbjs=;
 b=SuG4YXYcdDmXDWrKak4NvmMulgeFeixHspXScLWGwn12u4RdSBB9sqBTT1/AB3paKEpvkX4VykWY6334QA8vYKpHTFjV9lCmI1aiaWNP3uljLm/fKuZqqL69KoIOEUyOlU5yYBNnoCasAs6us/Lqb3WoU+JBJsiwEU184vSz4EjGP6Q3iq1tzYYLtw5+qJ5rutVtDbHAj/EyMcX6M2knDZQT7JwiyreqDeK1EmRXQLXOa2uY9z45d74XpgO9svEp3kAxCVOhXLY0xramZ3agcH2nHxN1dQ9X+e7ZUlkhJjR6qxpL1Q8Tvq6gNhyuXEtVorJz4tDwP4TWBwD16MoQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sizqbXXLaCuinv6/bbI5Db1NuVmUiwhWGOhrkv8jbjs=;
 b=pfIHsB6h/163a3uQ0eZxkLAJnD53qOGWx+mV0o8Gft26hvPrgNiSie82bTRDkZG+swrzkTRwX4a5INXzbaQ6KuCzH8sJlXWB6Ehh2//CFuMw8XK0DI9QSBEdNMQDi8z+UM6NaW9Rqypwqo4J83dIVxHcrAvl+ar1IYHO+FZyvg4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Thu, 21 Oct 2021 13:00:12 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 13:00:12 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
Thread-Topic: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
Thread-Index: AQHXxktx1DjGstD6vkidsjU3klQZCqvdM/GAgAAwFNCAAAVuAIAAAGJA
Date: Thu, 21 Oct 2021 13:00:12 +0000
Message-ID: <DM5PR12MB2469F0EE5242F012B81BA20FF1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211021071512.20034-1-guchun.chen@amd.com>
 <e6651a1c-50d2-af66-c985-4b500dcd12f8@amd.com>
 <DM5PR12MB2469397DED5BA16E5E37BFE9F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <82e43197-97af-809a-6fc0-93c67c090901@amd.com>
In-Reply-To: <82e43197-97af-809a-6fc0-93c67c090901@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c74d6ff-d0c2-4114-5c26-08d99492b82f
x-ms-traffictypediagnostic: DM5PR1201MB2505:
x-microsoft-antispam-prvs: <DM5PR1201MB25057B168FCFBDCD948204F8F1BF9@DM5PR1201MB2505.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LlDGtGRHQIXkuEmcUqXz/9H+o4kR38vgKxI78OByppbDUpUl4c9UMHpi6kkw4F7AduPJv7C6dgfMARdIEiC6dsvL6zHeXAO1TyhvlMhtCzKRq6GakcRkbx/WvKPwTNkLCrO7Y0b0v6vF1GGqc8nmHlO8Wkva4GIdFKMfyBqzmtCWtMCfh/r52XHZOOUuaVuS7v6jRD9GAALjnTPDWoUF2ZmeIs5xg9bQ7FixnrEIcB1fQt1rEwJa01Au+gVeiiki+V/jGOhAaOMU9vAl55QvF1pmKYP5IiioRzfaK9fX1fW8mUJoW+j9nu+T2k+Itc74+3xO+AwHbyK/YTIDC6znPOy2XSurvKh8vXvUvRikbXYl/1fORpuFWX5ah83UHZAJvYCiA6ufgc0jWVpOMVZk4jnN0jKlwlRwMbsFtnI/aqLd+sfjnKjiIaP+PXuXAQ/3VN/jH6T36OSRsa08TPixkCTj+SRW1tUjZ6vQoQ1WbKKaYXWnlt74lXmRVEdjpZ6vwHylg3v9Nfz5rkgzQN0lRF0/K+tWrd9cMqUFfc0vEHWqKosVO7tQsqWTjQr9FTCeDapqu1WTsjeLJVTBpCTOyj238I/aNOYiM1tkYqa3cLa0rdTvxsUWmLJQaLziVjL8HI6iDNcFOsRRVchNclOY49GLouaqnv461MCk27wCGsqLK2SRhsFgZjR/vJz8vOnbJ1D6jM0CKUZfnG97KrpvJOXuqUCAQHjkaiw9KuMIwlE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(921005)(2906002)(53546011)(38070700005)(7696005)(122000001)(110136005)(71200400001)(508600001)(83380400001)(55016002)(8676002)(5660300002)(966005)(26005)(6506007)(66556008)(66446008)(186003)(9686003)(76116006)(33656002)(66476007)(64756008)(66946007)(8936002)(38100700002)(86362001)(316002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEROWUNwRytkT1orSmZQdlladW5DR0tFUkwvRUFZRU40VnVUaXFrV2d0cTNo?=
 =?utf-8?B?cVdlbFdEWHYrQXRnQm5RWVhkOW5JdThWMEdqSHhyVWdMeWRPQm1rdjhUaHBX?=
 =?utf-8?B?ZnZVaFZROC9XajI4VmZCYmhnNnNnSkNMek16aW5YUUFIRDh2RElvZ0lrWStD?=
 =?utf-8?B?NGp4UHFIbHlJV2Ura0RQM2pGR3cyUWYwWkVLTzRPY1UrWjJyNkhqcm1Tdm5q?=
 =?utf-8?B?R2tBcU85aEx3aXVUS2Q0cDdPMnZHTUI2NDlQa2VITUFjOEZOcHArSk10SC83?=
 =?utf-8?B?VzVFcEJaUU9ZTHFhdHdqblFSeHR2Q0xTdnFvVjdCQmxsUVVEK093KzRpVGlm?=
 =?utf-8?B?ZU8rSDNNZGl2d0xoWDRoc0FjOXZmNmY2WGhrSFhNeFpIdE9pMVdzcEp0b28v?=
 =?utf-8?B?dEJmeHlCeGpIZnBaTG0rOGV4ZkNuSVdLN01MODdleVRlalJwaTRZZVVpclpM?=
 =?utf-8?B?ZjR1RmVCbm1tQWdCMmRyMmJVRkNTdzJpc0Ztc2M4aWZDMGF4RW5iWXFWRHdv?=
 =?utf-8?B?Y1JnQ2JCNU84V0lXVEdPbms2TDBJcWRZVVRwWUMxTjV6OThVUkRjSG9sVndr?=
 =?utf-8?B?dklxb3dpRkpZU1daUFhUWUMrTWY5NFhuSnBDcVBFQXVEUkRvOS81aWZEODZY?=
 =?utf-8?B?eEVDSjdmVlNPOTMwU0twc1VvY3Yvc1B0LzM1ckE4WGo5SElMcXJRNGJwMy9Y?=
 =?utf-8?B?bUplNXViY2pabi9PUDR5VEtIY1FyWjdaSm12NWRNaXcveVczaVo3RXcwVVI5?=
 =?utf-8?B?eTUzYmRhSHp2WHlXMENXOEU3Y3l5YzlXWDVvcm4xdWR5NEppdTlZVXpLaVBq?=
 =?utf-8?B?cmsyKzM0V0lnMlE1SWpaU0NzaUdOVnU1Mm93TEdBV3dHSURNSmJ6bTlxZzRB?=
 =?utf-8?B?Y3ZuMHN5dGpqT1lKc2J1VExKL2NSTmtQQm5mYmFIYm1hWVpPSnBvZFFFMUp3?=
 =?utf-8?B?YTZ3Z3c0Mm0waHR5bjhFdWM2UytkSndiOVcvSkpQbWVKdXVZaiszc042T3ho?=
 =?utf-8?B?ZnpScWE0U0g5Uitzc2Y5dDkxTzRqblUzVDJ4SHBDajBFUTVzWU1acFZKdllE?=
 =?utf-8?B?c2pMQXNNQW9iTnNpUlIyb2JmdVFTRmFjOTZqaFVrL0pEci85MFNtNDVTeEp2?=
 =?utf-8?B?c1hnbnFGN2lnVGFOTmErQjIrMnhQZndWQk44TDZGVHcrS29IbUJWd3dIcExK?=
 =?utf-8?B?b1g2UjdHNjQ4SUwva244N2dLZklkelI3b1c2U3padkMwa1U5SHFPUm14bmlZ?=
 =?utf-8?B?c3VnNFFUUENwSGpFMWQ2clpxRnBieHRoSkY3Q2lSMlRxMU1BeG1rUDFMZXNU?=
 =?utf-8?B?V2pCL2pvM05nYkVBVzlKMkpyZUVsM2xkVWF3blJuc1l4bVJaWVFDZGhCaUpU?=
 =?utf-8?B?dnhiL0hoNUY1QmRMUm9RUzA0Z2xQNVRJeFBWU3pFUWdRYWU2Q0ZlSlJRbVRW?=
 =?utf-8?B?US9sYjB3bjJuWHhKMkZ6NldiaHF1ajVvZXpyaUYydGt5NlhNUytPaE9jcU5J?=
 =?utf-8?B?eVVVUDY0VkpKV29NVWRHSXIxbzZkVWNDQk9BL1YycWk1Mm0xUk9icHdJNUJu?=
 =?utf-8?B?V29nOXBIVU5NRU5KeDB2R3JONEtoanpkb2M0NEFtRG92UFZ1SnNXOGMvVXVi?=
 =?utf-8?B?NEplSXVDZ1cvQThnQWtSZnFmdWJLWlluckEyYk5mY0ZYQjh0cGNkRmg1QkMv?=
 =?utf-8?B?N09mcTJiVnpwU1BEcVMvdmhRb1lMRVd0VHl0VlQ2Ris5ZE5mTE02UkFjRC8x?=
 =?utf-8?Q?5m6rgd0kWGqca5RrVovBgYbJD5J40R84b5wm7Wq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c74d6ff-d0c2-4114-5c26-08d99492b82f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 13:00:12.4874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guchchen@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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

UmU6IEJ1dCB0aGUgbG9naWMgYXBwbGllZCBpbiB0aGlzIGZpeCB0ZWxscyB0aGF0IGFueXRoaW5n
IGluIElQIGRpc2NvdmVyeSAodmVyc2lvbiB0YWJsZSBvciBoYXJ2ZXN0IHRhYmxlKSBkb2Vzbid0
IHNvbHZlIHRoZSBwcm9ibGVtLiBUaGlzIGlzIGVxdWl2YWxlbnQgdG8gYW4gQVNJQyBzcGVjaWZp
YyBsb2dpYyBzaW1pbGFyIHRvIG9sZCBBU0lDIGVudW0gY2hlY2tzLg0KDQpFeGFjdGx5LCB0aGlz
IGlzIHRoZSBjaGFsbGVuZ2UuDQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+IA0KU2Vu
dDogVGh1cnNkYXksIE9jdG9iZXIgMjEsIDIwMjEgODo1NiBQTQ0KVG86IENoZW4sIEd1Y2h1biA8
R3VjaHVuLkNoZW5AYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmln
QGFtZC5jb20+OyBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPjsgRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGl1LCBMZW8gPExlby5MaXVAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBsaW1pdCBWQ04gaW5zdGFuY2UgbnVtYmVyIHRvIDEgZm9yIE5BVllfRkxP
VU5ERVINCg0KDQoNCk9uIDEwLzIxLzIwMjEgNjoxMCBQTSwgQ2hlbiwgR3VjaHVuIHdyb3RlOg0K
PiBIaSBMaWpvLA0KPiANCj4gQWxleCBoYXMgYSBmb2xsb3dpbmcgZml4ICI4NWRiN2ZjYjJlNTMg
ZHJtL2FtZGdwdTogZ2V0IFZDTiBoYXJ2ZXN0IGluZm9ybWF0aW9uIGZyb20gSVAgZGlzY292ZXJ5
IHRhYmxlIiB0byBmaXggdGhhdCBsb2dpYy4NCg0KQnV0IHRoZSBsb2dpYyBhcHBsaWVkIGluIHRo
aXMgZml4IHRlbGxzIHRoYXQgYW55dGhpbmcgaW4gSVAgZGlzY292ZXJ5ICh2ZXJzaW9uIHRhYmxl
IG9yIGhhcnZlc3QgdGFibGUpIGRvZXNuJ3Qgc29sdmUgdGhlIHByb2JsZW0uIFRoaXMgaXMgZXF1
aXZhbGVudCB0byBhbiBBU0lDIHNwZWNpZmljIGxvZ2ljIHNpbWlsYXIgdG8gb2xkIEFTSUMgZW51
bSBjaGVja3MuDQoNCj4gDQo+IEZvciBvdGhlciBBU0NJcyBsaWtlIERJTUdSRVlfQ0FWRUZJU0gg
YW5kIEJFSUdFX0dPQlksIGl0cyBpbnN0YW5jZSBudW0gaXMgMSwgbWF0Y2ggd2l0aCBWQklPUyBk
aXNjb3ZlcnkgdGFibGUuIFNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gaGFuZGxlIGl0Lg0KPiANCg0K
VGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbiEgSXQgbG9va3MgZ29vZCB0byBtZSwgd2lsbCBs
ZWF2ZSBpdCB0byBBbGV4L0xlby9KYW1lcy4NCg0KVGhhbmtzLA0KTGlqbw0KDQo+IFJlZ2FyZHMs
DQo+IEd1Y2h1bg0KPiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF6
YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
MjEsIDIwMjEgNTo0NSBQTQ0KPiBUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IA0KPiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgDQo+IDxYaW5odWkuUGFuQGFt
ZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyAN
Cj4gTGl1LCBMZW8gPExlby5MaXVAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJt
L2FtZGdwdTogbGltaXQgVkNOIGluc3RhbmNlIG51bWJlciB0byAxIGZvciANCj4gTkFWWV9GTE9V
TkRFUg0KPiANCj4gDQo+IA0KPiBPbiAxMC8yMS8yMDIxIDEyOjQ1IFBNLCBHdWNodW4gQ2hlbiB3
cm90ZToNCj4+IFZDTiBpbnN0YW5jZSAxIGlzIHBvd2VyIGdhdGVkIHBlcm1hbmVudGx5IGJ5IFNN
VS4NCj4+DQo+PiBCdWc6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0v
aXNzdWVzLzE3NDMNCj4+DQo+PiBGaXhlczogZjZiNmQ3ZDZiYzJkKCJkcm0vYW1kZ3B1L3Zjbjog
cmVtb3ZlIG1hbnVhbCBpbnN0YW5jZSBzZXR0aW5nIikNCj4gDQo+IE5pY2UgZmluZC4gTG9va2lu
ZyBhdCB0aGUgZml4LCB0aGUgbG9naWMgaXMgYWxyZWFkeSBicm9rZW4gYnkNCj4gNWUyNmU1MmFk
YjQ2KCJkcm0vYW1kZ3B1L3ZjbjMuMDogY29udmVydCB0byBJUCB2ZXJzaW9uIGNoZWNraW5nIikN
Cj4gDQo+IEFueSBBU0lDIG90aGVyIHRoYW4gU2llbm5hIHdoaWNoIGhhcyBzYW1lIFZDTiBJUCB2
ZXJzaW9uICgzLjAuMCkgbWF5IGJlIGJyb2tlbi4gQW55IG1vcmUgZXh0cmEgY2hlY2tzPw0KPiAN
Cj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4gPGd1
Y2h1bi5jaGVuQGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3Zjbl92M18wLmMgfCA5ICsrKysrKysrKw0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92Y25fdjNfMC5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMN
Cj4+IGluZGV4IGRiZmQ5Mjk4NDY1NS4uNDg0ODkyMjY2N2YyIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YzXzAuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmNuX3YzXzAuYw0KPj4gQEAgLTEwMyw2ICsxMDMsMTUgQEAgc3RhdGlj
IGludCB2Y25fdjNfMF9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkNCj4+ICAgIAkJCWFkZXYtPnZj
bi5udW1fZW5jX3JpbmdzID0gMDsNCj4+ICAgIAkJZWxzZQ0KPj4gICAgCQkJYWRldi0+dmNuLm51
bV9lbmNfcmluZ3MgPSAyOw0KPj4gKw0KPj4gKwkJLyoNCj4+ICsJCSAqIEZpeCBNRS4NCj4+ICsJ
CSAqIFZDTiBpbnN0YW5jZSBudW1iZXIgaXMgbGltaXRlZCB0byAxIGZvciBiZWxvdyBBU0lDIGR1
ZSB0bw0KPj4gKwkJICogVkNOIGluc3RuYWNlIDEgaXMgcGVybWFuZW50bHkgcG93ZXIgZ2F0ZWQu
DQo+PiArCQkgKi8NCj4+ICsJCWlmICgoYWRldi0+aXBfdmVyc2lvbnNbVVZEX0hXSVBdWzBdID09
IElQX1ZFUlNJT04oMywgMCwgMCkpICYmDQo+PiArCQkJKGFkZXYtPmlwX3ZlcnNpb25zW0dDX0hX
SVBdWzBdID09IElQX1ZFUlNJT04oMTAsIDMsIDIpKSkNCj4+ICsJCQlhZGV2LT52Y24ubnVtX3Zj
bl9pbnN0ID0gMTsNCj4+ICAgIAl9DQo+PiAgICANCj4+ICAgIAl2Y25fdjNfMF9zZXRfZGVjX3Jp
bmdfZnVuY3MoYWRldik7DQo+Pg0K
