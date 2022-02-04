Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2832CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 17:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC9ED10EA96;
	Fri,  4 Feb 2022 17:20:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFA210EA96
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 17:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUH6KcdKvUTgJa3Am8w0mHLRfwoQ6RHseaK9DDmL/I06u8IYtYMcwWjZ2L2o5sxTsM6lQ1sMR+EK+2anAynWhZBf/gnssf4/aZXN+WbpPob1/Gl2De1BDQSSNcwT7bg2rr0ckNZ8+tpWEchzt7+GeAeJepasL1/m7oTGdMFThaI/YvvS80LfIJdJN0iFfPg+s9+ewuhk/cdvW9seJeqs7AMGMfho6BHwACwTzrEmBlRxSu9J7P5WkkUhslKmOIMlQ0UViD0Vb8JXUnONbNPVBGqon5npfq7dgPCgDUHcNUMD79+0VU/MNa0Pab/tJ8U/Sa3RaSxcgm31A/9W45XXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMaMTdUjh6TyX9aNvOxVlyqGVyZ7mrj3duQugEYWino=;
 b=afyxVkmaRyi2jqlG9c/7yylN3CtEEohlW8L3vNojPyQTv9HUd3Ayx7A55GkSc1HULxAjcaIpPKJuaFZg7n4ujik/TFaiY5JcOl6nCCgYX4a8SEuCwOfJoYDVtYTAUTxqkx0auKkU7YH2OAjtdMM/dvj5dgzNmgT5/X9G+18AU/FZUfHPSInrvQFgfksMyHwZ/fYNxsnwDyfPcFnsMV0in4C3R//hYkADXDK3H3VaifxJ98QMDbRo9RDXm8I30JiMqprRe+yXStDZynBGHwyP/uUXsBrGAX7TozzU4IWmdi0PNYkobqjFFQe/nXeOjSvpZnuU0oWTEiBY/pgJeUfsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMaMTdUjh6TyX9aNvOxVlyqGVyZ7mrj3duQugEYWino=;
 b=X3NRaLa5U3nl/CuGgguUUMjh5nQopG6Wicwy+0qmk3dOJfidyS0HJriJIyZduHMLkIoKU6UkXHcKcj02RiR16NrYdbAXmec/rocafKJZEF4wOmtpVb0w0o1+ULNxtg9SPNVtADkM2dyRwvPf8lFDNr3O5kBEGLaPZj0EfLaW6yM=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL0PR12MB2372.namprd12.prod.outlook.com (2603:10b6:207:4d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 17:20:12 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d0d1:eba5:5729:c636]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d0d1:eba5:5729:c636%4]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 17:20:12 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Thread-Topic: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Thread-Index: AQHYDwZjidvy0bXGukSiArQ04UD9j6xumGUAgBUU44CAAAJvEIAAAz4AgAAAfDCAAAHOgIAAADpggAACd4CAAABQQA==
Date: Fri, 4 Feb 2022 17:20:12 +0000
Message-ID: <BYAPR12MB4614628DE8E6D39EE53307DF97299@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
 <817df2c3-e7af-92cb-53f8-8bc70b69b988@amd.com>
 <BYAPR12MB46149A07EB030CB27FDA8B1397299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <8bada9e4-d6d5-e11a-45fe-aea7615f3356@amd.com>
 <BYAPR12MB4614325D69EACA459547E4F597299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <77fd42df-be70-18bd-ebb8-503214ef6af8@amd.com>
 <BYAPR12MB461419D8152EBBD70BB9BAFC97299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <c28e3fad-29ac-a326-30c3-4f4de0001e47@amd.com>
In-Reply-To: <c28e3fad-29ac-a326-30c3-4f4de0001e47@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-04T17:17:57Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4c3ff82f-1e94-43f6-a74d-9ed9a5d5ed81;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-04T17:20:06Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 8e48319c-61e3-4ce6-abd6-6a5ed0904e0c
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c41d332-96ab-4ad5-52a5-08d9e8029a47
x-ms-traffictypediagnostic: BL0PR12MB2372:EE_
x-microsoft-antispam-prvs: <BL0PR12MB2372E52958578F9D15B847AC97299@BL0PR12MB2372.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3e8h2iJ2Uv3YVu624i8Qr1sjbOC32f2bsGPEdwJwaxdtgArfkYpDOa7g4ApoqX2fehsqE+PKFtcXKDTMm6kXK6q72ZRGXqTt+JWwF67uMqg6TtgJyrk7PBfhazVv2aLt4DGK9xxd6V/xpjZas7JuZHIZ9/SRYtsRprlgOskRjInL0KEvgTgutMJ8a5fL6zAsN7UXCp5cdUrtlZ+CJ/yYGzeoL1s4vv1TdY1qybZ8tBlnlmZvIPsV9+4zxH6RG3DZGQ3Mq6GqGAc30mE/tFoGa44W88bAEO+BAHV7iYgtqTlQhjGWhuqg4K8HLKFURv9rfvhzz2eI0nWKNsEOZq8FerZzGAVOsRtkfvhxYb6C6MpjpYIPGIv33B6igW1I/PEv0PnsMGg+fc5q8MpvC0TC15TM9sKXBNDdUdr2XggP/1fE04XJSJVBUuecM+0teoaKkgzIssr8o7C8AgN/313VY8u7/MLrNut6keZuGe/wQOU+FxAcRr3DgvlCtbrTMdB1cogt+g4i7YIIZWxvOtib92tUxf+AwWup5V1ziO8b91EXCkKnhfsD4AcGKYBDQsUVOCPl0xuYsso/0UQ/ZF1pONsjju7bt1soCBJng/gGjGB7ZoGmTHUh0BMCadRBfE/LoF+ptU/76zTIoyqO3BVjWnsTWClPuoORJmA6trwYFHWm37tciQkLNWojfa/Ybl0KDNT0JV/kg4FCmPy93w9yxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(5660300002)(83380400001)(6506007)(122000001)(7696005)(71200400001)(38070700005)(26005)(38100700002)(4744005)(55016003)(186003)(110136005)(76116006)(66946007)(66476007)(4326008)(33656002)(66446008)(8936002)(52536014)(64756008)(54906003)(8676002)(86362001)(508600001)(2906002)(9686003)(316002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkNqSTc4WDZrdW9ocXRnN1p0aWNJVEJ4Um5mVUZmT1RaVndPeFFoV1QwL3g1?=
 =?utf-8?B?a29aSGJKYkNnd2FuZTZVN0VZbzFkbnB5aG5yRWpMNU5FSDkxcnFIZmh2UmI4?=
 =?utf-8?B?elRJamZMemM4T1g0ZnVDNnpTTDQ4TnNzSHZNS21YK253RkFONlBPYWFzb1JB?=
 =?utf-8?B?RXZTcHliWThIUWlBRUVTUjNrSkpYQlpYdnptK21nQlY0ZHNGZVZwR2tTSlUr?=
 =?utf-8?B?bVZmdElmVy9zVks3UTc3UmwxR2NtRkdnRlQweGxUeHU2Yllqcmtacmh2TXB3?=
 =?utf-8?B?LzlLS28vV1ZJcCtGQzM1UVBPcWN1Y0tKUEZkY1dXaCs0MlljMkx1Sk1TZE1P?=
 =?utf-8?B?a0djYTU5aVNwOGJkdmtRS3hMME9yZmY4ZThna2JvTEE3aUNuRWpXai9jd0Ir?=
 =?utf-8?B?d3JJTi9nQi9xcStFQk9KRk1qN2s0bFJIVEVDdFJMaUNWdjVHRmRYWm8wWUlU?=
 =?utf-8?B?VTEvUVpEbFNqZ293MHBLZ0ZBcmE4ZTREM1lTOVFMYjAzRkNWam9JczRmSjZh?=
 =?utf-8?B?SUo2RG13SVVoMW1lTThaaFRDZVFJcmhSQVp4R1NaVXJJc1I4WnRGN3V1MUUr?=
 =?utf-8?B?U3J3c2pyd2YrR3dORkhMS3RoVklMR0J2enlwdDZmK0hvY1haUUJPaThxYUNv?=
 =?utf-8?B?MmsrMmJLOEJFdnloQWNqNXpxdkJwRCtTcXd6bHh6OFdwZVIxRDN4akdhY3Uz?=
 =?utf-8?B?S2RXN29uYXRLcW45MTRwano3c0FCQUU4ekZuVnBKTzd4VlJMZ0tjVEZaSVc3?=
 =?utf-8?B?cTIyb2RwOHh3T1V4OXdUT05zbWtQRWpYYzFlQy9GdHJqeHdJMFhUYlBXY1Bw?=
 =?utf-8?B?QU9ZMEQ4Ynludno4L2plUmpmTWhReWx4Mjd2eHpYZkx1THpiSnlkZ2lYdGhB?=
 =?utf-8?B?eThFZEFWOVE2NDZ6d2pNM05VWVpSS0Q4aVFDZ0kzRmRiOHY4MG8wV3dadGpa?=
 =?utf-8?B?UHA0ZXpjUDd3dFM0WHlCOUxLUlNWMkRpMWw4MlRsUTZ2ZXZKd3JyRGg1Zzdr?=
 =?utf-8?B?NnE3TmxiSE9lbC9ubC9wazd2dnlNY21sWFZMOE81aXNZZ2V4cGxGWkRxZ1Bn?=
 =?utf-8?B?a2VHaUkzOG5Na2I2VjBVb1NCOEUrd3NYeW1KdE1JQnNuRVRCWE1TdHU1bUxy?=
 =?utf-8?B?NTE0dXM0enZUcDZTL2x2a2NuZ1E5UmJkZXF5dTJlR3F1YVlXR1NWdWg5Sng2?=
 =?utf-8?B?RW1kTUt2TnRUZFI0U0dYVFhFNG1UdkpLYjQ3RzVIVzJoN3ZieWtMV0pCZmxK?=
 =?utf-8?B?bUJGNC9mb2FZTk9YSUQrc2g0MjJra3RzVmhraExPSVU4MUJQb0RRNmRtR2ZW?=
 =?utf-8?B?UENyS3pGbm0rSUQ5bjF0VHM2QXdSQnd4WEcrWUJJc1FsTGIxSmhJUUNCYWov?=
 =?utf-8?B?andWTXR3Q1dwWUt3K25rME1WU0FyRHIxdWx2dzN3YWo1bGdjMXlBWGo4N1lH?=
 =?utf-8?B?NE94Ymp3eWFhNlFZS3kxKytjVkxWUjBHL0xva3RQWEJXb0JSZnZYelJGMVBR?=
 =?utf-8?B?bnRnRCtkYmM1c29wb3ljY3Y3N3Y3Y2NkMlFQSFhUb2tIMUR0YlQrMGc0S3Uw?=
 =?utf-8?B?eWpvVWp2dkhKdllNMG9nczd6YVl5ZnlTbnBwNHJUaitFZWExa3ZQWTNiN29N?=
 =?utf-8?B?UTRFeUx0aVY3VVRHYllERENucThXOGtIRFRMOUl3NjJJQzNiTUZ1NVloQjVa?=
 =?utf-8?B?eDV2U0lJSy8xbzUwS1ozcEE2OHRjNUwzN29EQ292cEkrMm9ISEZRUDdBNUZN?=
 =?utf-8?B?MnJTYm1SY2F6T3Q5UE5YQndYRlBpL1dEUHJDMUdJYXFYU2pFT2pMckkwL09k?=
 =?utf-8?B?amsrSFlSV0pVY3IyVW5UZ3hLVXA2cWZxeU1UME80VzNkb2xGTThEWVFiMmpl?=
 =?utf-8?B?RmhqeHR3UllpZ1MxT3dGdEtRYzlheGlGc0YzWTc4azh0dElqV1g1c05DRVJZ?=
 =?utf-8?B?NVdtYTdXR2FDTGE2ZmRKMGl5S2FOQTZLSHF0OWNYc0tzaVo4ekVmZEhsb2Jr?=
 =?utf-8?B?TXZzUTlORGpHcVUvdnA0K1Vwc3FFWnQraCtZWUo2NlMvbHIxWEtSV3g5VEkx?=
 =?utf-8?B?VHFpdlJZL01UWW5lZnV2NWZtcjlvYVdlQU9uNGp0N3Z0NVhqaVZhQjJkNzBj?=
 =?utf-8?Q?Onsc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c41d332-96ab-4ad5-52a5-08d9e8029a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 17:20:12.3392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/k8E9yn2FlBAnufMaMy50HKhd1o7nzhmI411EgNjx5dRHA+m4J3gkPBVV0yQxsp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2372
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KT25lIG1vcmUgdGhpbmcgDQoJSW4gc3VzcGVuZC1y
ZXNldCBjYXNlLCB3b24ndCB0aGlzIGNhdXNlIHRvIHNjaGVkdWxlIGEgd29yayBpdGVtIG9uIHN1
c3BlbmQ/IEkgZG9uJ3Qga25vdyBpZiB0aGF0IGlzIGEgZ29vZCBpZGVhLCBpZGVhbGx5IHdlIHdv
dWxkIGxpa2UgdG8gY2xlYW4gdXAgYWxsIHdvcmsgaXRlbXMgYmVmb3JlIGdvaW5nIHRvIHN1c3Bl
bmQuDQoNClRoYW5rcywNCkxpam8NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IFNoYXJtYSwgU2hhc2hhbmsgPFNoYXNoYW5rLlNoYXJtYUBhbWQuY29tPiANClNlbnQ6IEZyaWRh
eSwgRmVicnVhcnkgNCwgMjAyMiAxMDo0NyBQTQ0KVG86IExhemFyLCBMaWpvIDxMaWpvLkxhemFy
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFNvbWFsYXB1cmFtLCBBbWFyYW5h
dGggPEFtYXJhbmF0aC5Tb21hbGFwdXJhbUBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENo
cmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80XSBkcm0vYW1k
Z3B1L252OiBhZGQgbmF2aSBHUFUgcmVzZXQgaGFuZGxlcg0KDQoNCg0KT24gMi80LzIwMjIgNjox
MSBQTSwgTGF6YXIsIExpam8gd3JvdGU6DQo+IEJUVywgc2luY2UgdGhpcyBpcyBhbHJlYWR5IHBy
b3ZpZGluZyBhIHNldCBvZiB2YWx1ZXMgaXQgd291bGQgYmUgdXNlZnVsIHRvIHByb3ZpZGUgb25l
IG1vcmUgZmllbGQgYXMgdGhlIHJlc2V0IHJlYXNvbiAtIFJBUyBlcnJvciByZWNvdmVyeSwgR1BV
IGh1bmcgcmVjb3Zlcnkgb3Igc29tZXRoaW5nIGVsc2UuDQoNCkFkZGluZyB0aGlzIGFkZGl0aW9u
YWwgcGFyYW1ldGVyIGluc3RlYWQgb2YgYmxvY2tpbmcgc29tZXRoaW5nIGluIGtlcm5lbCwgc2Vl
bXMgbGlrZSBhIGJldHRlciBpZGVhLiBUaGUgYXBwIGNhbiBmaWx0ZXIgb3V0IGFuZCByZWFkIHdo
YXQgaXQgaXMgaW50ZXJlc3RlZCBpbnRvLg0KDQotIFNoYXNoYW5rDQo=
