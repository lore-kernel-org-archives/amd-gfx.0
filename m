Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C870C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 09:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDAC810F31A;
	Sun, 28 Apr 2024 09:29:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NQD6YHrI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3642110F31A
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 09:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QODDnEHobkTrSV8F21Ek78w2t7dTFlWjoACNhIUdrYdnFof1dA7zEkqFmTionRzEqpVAqXfxO6ojbwZnnEwDp0sopuKCElfW7t9xYxeOngR5LIABDxgieysmtIxHPNhjF3O6AQIt9b0ibfIT5B9tk1FSXEuOqpWRW73BUa/Yko2W88wShxndilNBaLm2uDOrvVkkzt6yAfEa+IBJ5TK69sxCrs8SLwdCyaiwSQfhVVFM5Pcw2/NFDP3kCPhZJT4YDyV2fyhY/CHPMtIGIeI7r+mxnKi7aa3YVDSbDjcl2fEFH5Yg5yQDEYmIcBzS36TBbbFEuEIRIoxkO4TKTDzT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pY7Z9Hz/CKpxkscGoDBRhfIbi3zYtaVdtVqrKJo5gA=;
 b=O9hqWChZEnS9toEWeQuLDVTIwc6gfz8O0YW4bRTUXYx/x69urigoT4REDwXj9whxPWdFtmMu6hxek7HOZnwrbYAxiyCz+uoymh496QjNz7N/45X3+yVyrrdkzAZpW+yIasgdh4GUX2Bkoj8NO0QbTxaHKQ+hu1pPsbnJhxZxg2STga/eeyAfgQDSKOAdoW7Kr7WC3iUnySy0TCp6Rqmj1IdtQlr9+Jvw9/EK6DWxziaLItMraAuUBqLqiTO+TJgs+U0SLoJAPm/gNtBzcjcyIDRbBssKmyk4thZGb6LhfoONIDaCfURB7zVWWk1lBdJe5YWgFZY2jPIRVvTNuMppjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pY7Z9Hz/CKpxkscGoDBRhfIbi3zYtaVdtVqrKJo5gA=;
 b=NQD6YHrI/J5aDBIUXThKcc45Y/JnaoupeY5vSGDCzyPB4G99HD+XScX0bMY3Y6kDpmYzK9yPLtC9u+zJWjDqsun7fZsQa3bM5AQngwWfqmvux/qJTJF7PyvhriIhTOazR/c56ovrDCPRVRKENi+zyZO0L2raVoVR4UfnLthEWso=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sun, 28 Apr
 2024 09:29:45 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 09:29:45 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/pm: Fix negative array index read warning for
 pptable->DpmDescriptor
Thread-Topic: [PATCH 1/3] drm/amd/pm: Fix negative array index read warning
 for pptable->DpmDescriptor
Thread-Index: AQHal6tQ/pEKTawtVkClVU37shGh47F9bSnA
Date: Sun, 28 Apr 2024 09:29:44 +0000
Message-ID: <CH3PR12MB80744B6407362EFB49C2EB25F6142@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240426072805.1041943-1-jesse.zhang@amd.com>
In-Reply-To: <20240426072805.1041943-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f4cb0966-297a-47e4-9035-ebeda143f2fd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T09:27:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DS0PR12MB7993:EE_
x-ms-office365-filtering-correlation-id: 7f291aa9-fdd1-4eea-8170-08dc6765bd75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?QzJNMzM2SlRFa29PS0ZWVTNiOUhyNWZQMDh0UjRtK0k0NDE2bVN4dzR2Ym1O?=
 =?utf-8?B?QzQ1WXlSTEI5OFpTSlVjNGN3S1dEOW4yVzlrMUFFU3dCVUpTanR3b0paN1ZB?=
 =?utf-8?B?bTZ3eW42UTJDVmJWRFUzcUUvY1RYdll1ajFFbFdHMHRjMkxjcko1NUZENEVD?=
 =?utf-8?B?a3owTWUrbDdpUnFYMm12VWxmVndKa3ZhVDVvUXRMZ09yTHA1Qi81UGQrMUJ3?=
 =?utf-8?B?VlNDbkpYM3VGcG42aXhncC9JTVM1MjUwTjhGNEZQU3NXcGdrNTZ5bVlURXl2?=
 =?utf-8?B?dUFiZDJDU2Z3dmh1YVM0QjZyenA2eTIzMUdPZTdMZmdxYm9zRlRWSTN2K3g4?=
 =?utf-8?B?NG1ZV29zR3NPaXplQ2RCQUFFTkMyVHhJTFFzNkptYk5ucmJ4WnVCcWxyS2d1?=
 =?utf-8?B?a3dxaUQrK2xxdFlRSEdQTGNyOFJCbnhwRWE0UnFrSFdsWTV6eGdqbGpHbmFw?=
 =?utf-8?B?YnhBZ3JxWkZBdUZQOW14cjJUeUl6RTh4eFZseWlDSURaSlN2TU85aEdWelkr?=
 =?utf-8?B?K1F2NXF3VTZBQnJDMTFST21SRm16eTN0VWl1QU9LRlZHbklxVk5WY3RBYlZu?=
 =?utf-8?B?MTJIMjFYdFRaNFpNUlVNWlRGcjloWXd1bFNKMUFrTEhWM1BYbnpneFduMmVx?=
 =?utf-8?B?V3hXTG13OEI4S2h2ZjlNTFNzVkt6VFVrRlBwWVd3ZjEvRDJoL25SMHpqU1ZB?=
 =?utf-8?B?ZTVCSWUxYTZOZmFIb2UrR01DMDBDV1ZuMWw3ZkhiNjlVUkNVeTROMTN6akNH?=
 =?utf-8?B?Zm55MFlWSm9QalNCNHBNeW9jVE9QZzVWQ1R4ZlN1SlZoMHhDTU9IZVdPVE5x?=
 =?utf-8?B?UklJdklhOGpibGxUaGFpUVZXRWpxbmlVZlRTRHlvaG5yalc0bk5jRGdBYjdw?=
 =?utf-8?B?UjlSQnNodTdLOW02WE5jTi8yQTBMTzZPcVFtZmQ0bE43eitnYUZUNlM0clBa?=
 =?utf-8?B?azhRaitnbHFMU2lEN1doemE5R256b2l2Ym5FNC9pL2F4VUQrbmc5czdlR3RD?=
 =?utf-8?B?TVNuYWtmN2dhWHNkQm9RZ0ZNcklMZUIxOW9yeHdDdG94SDlWVGdBeHhWblpU?=
 =?utf-8?B?NUZxSjY5WjhjclFJRnREa1UxZnQ5RVJCN1hxL05uVWdaMUoxeEpyOXBiOFNW?=
 =?utf-8?B?Qm4yQ0diYVYzRWxxb1JNeWJRQW85ZnJmUFptYUZtVWViRzVNTWdnNGJNamdJ?=
 =?utf-8?B?Y2IvNk1Pd1lmQ2hIMlR3WVcxcjFrMVJWMTFvenV3eElPRFBRQjZFU0FLSktz?=
 =?utf-8?B?eStKNngzQU44M2RyYk1HYzBMVUIrTjdiTW1KKytBMFJhR3Z5VFpsVWtHaStR?=
 =?utf-8?B?Sk9xQXFEMVo0RW9RV3FHM2M0TW0wRGt4MUJZWHViVVpJWXdDRS9SdlBHR0tB?=
 =?utf-8?B?UDdlN25NNXBJLzNPZzVaRHpaK1MzUW0zUEtjcmpZVlFBU1V5a1Z2bEtmSWZh?=
 =?utf-8?B?OE9rSWpmb3VPa1g5Y1NTb0NhMkVBcXZaK3RhR2YyQmhKVC9QZ2ttdmdVdWkr?=
 =?utf-8?B?Y1VoN2JMMTRVN0Z2WWJTc0JkV1hQRHB5UTFBTnE5bzdTU1ZxMkxyS05oWTI0?=
 =?utf-8?B?ajA0QUFqenM2c3hycDcycDJyZU95WEFLSXhOZG0xYmlUTlFSQnl5MkxBZ1NC?=
 =?utf-8?B?Z0Z1UmRnT050Y2F2bDRJaS9nZVZrR1Y5WWFCbnRHTEhpZ0JYZkNTSXZsV0ZW?=
 =?utf-8?B?Q2hwWmpxbnJsU0xBN3hxU0xoZktDdmFFcDVIcnl4NGphcDVSYkRQOFVBK3Bw?=
 =?utf-8?B?Mk1OYURUU2QxRHk4cmkxTkV4Q2JOTUgxVkJncGN6aGROaFNWS1Z6aVVwWGJU?=
 =?utf-8?B?dm4vRlhkbndCQmJUUVpiUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3U0ZDZVZldlaGJFNFZtOXVKenlTTUk2QmlQTXlUSXpmbVR0RFJZZVFOYytP?=
 =?utf-8?B?eitNTjc0NFR2U2paNWtiL0J3RkhnQ1B2K1VQL093d3doN1E0TWI2OEJ5SlUz?=
 =?utf-8?B?b25HNFgvYlArWnlnbTh3bFZJTW1jTHlXNkUwZkc5c2VaQ21SOGJkMWEweTAx?=
 =?utf-8?B?M2dqQUhDM0VFcHRiUzVOazA1RENBak1ZZjgrcElMVEdGaHp4WXhVOUJVVnN6?=
 =?utf-8?B?ditwYXBvSWFwY05Qa2pIUWFBKzhpK2E5ejZ6aHF5MFhNcVhOYW9VT1kwQUhB?=
 =?utf-8?B?UTUwMHJyditSUWNPUW5MU0gzN3h5ZllUbEoyTjNOSkJncnRyQ2YwNkNldzdr?=
 =?utf-8?B?bndST0Z2cUpubTZzWG5YZlAwM1JQVm1neGE0b1BwWFh4cHRTbFM0RmtaTlBT?=
 =?utf-8?B?ZVA2dXgzbVRZR2VZRkxMK21qSG5QMGpnZmxiMGRsdTIyYkVvb3NLZXpld2pl?=
 =?utf-8?B?SWlZMG0xK3g3eFROajA3dnZyYnkzMFc5SVJoT2hIUjBORDhPZzRCV3VFbGtG?=
 =?utf-8?B?SjE4UlZUYjZJdnk0cnpZQlB1S1crU0hYZTJLdlhOT3IvZXJEZmo0WUIwZWFy?=
 =?utf-8?B?S3RyNTlBSXJTbmZhY2laV0FORDdJK2tKUzlsTmxNeEM1YlRtSWt2dVExTTA3?=
 =?utf-8?B?amFDU3dCTTdtRVpGWUlvYjgwUU9BWldOdGZzeitLRjBNRSs5eDl4RFVpUkRi?=
 =?utf-8?B?OWFLZHZlbUQxeG1tdXRHdmF0Tzd5VWY0VmJRQW5qVmNDcVI3amJhQ25ha3pB?=
 =?utf-8?B?L01RenZ1K0tueWJuTkZxV2g4WXZuV1FMMGdFVlBhZzlNODNsanhjdUJ6Sm1U?=
 =?utf-8?B?dlB4OE5mdVZETUFadWhEb2hpWmsyK0hkWHBCalcvQUVNVW51VkEzWmFFS2dz?=
 =?utf-8?B?TVhLMld5SEJlSGRnLzFCWXVtUmVaalUzdktEbzVFZzVFVS81YW5PMWNBem1N?=
 =?utf-8?B?QmJZZU5acUhlL1B0WldYTllON0swekNJM3NVZ0dyZ2VpWm1paXpabjRFR1Yz?=
 =?utf-8?B?RytzMFBGVzNuajZ2U3ByVGNmdHBmai91Q0d0QlAwTFZOMTNsMDFTUFI5NTQ0?=
 =?utf-8?B?TkVnR3hKMXdFLzZqVUZablBKYnhZZHNWaEVNa2NiMmtRd0Uvc1NKcWNvSzc0?=
 =?utf-8?B?dHJvOTdWY2QyRGwrNUhRV3I4ZlFaKzVkZlhCMURhbUNJN1dUbUxWVDhiYnE3?=
 =?utf-8?B?Y0Rha3YwaGFMR0tRN3plWUNEdnZTVlpucitaUGFrV1dvREtHM2dkZENEbTRk?=
 =?utf-8?B?dTJwWERzaGViN1hsbExIMzhZckR5WC9jZng2UHdKTDdGcldnRzdaZ3dZZEhv?=
 =?utf-8?B?WTMwZWlUWksrY0tqb01vK3ZYbFoxTTRlZnNEb0Y0ZEhVUmlCcWFvVldaRWdP?=
 =?utf-8?B?U2Y1ci9WbnVOZXVtaVUvMjNXdjYzdDlXcmNiZ0RiQ0JVc2QxOXoxMzIyMjcy?=
 =?utf-8?B?dlVEcERzWFc3QWVzNFFWcVJ6Q0FIRXJDL3F4cG5kRlJOYm4rV2tzWGV5ek16?=
 =?utf-8?B?SkRLV3AxMVY3UnZmVXFvQktxcTI5QlJtcCsreUR3VkdXSEIrS3hrNStzQ2ZV?=
 =?utf-8?B?bVFwb2d3QjF1WTdoNUJKeXE4dXVTdkgyVlNIczJwTWc0QkRHb1NZTXMyVUZL?=
 =?utf-8?B?Yk55bTNmQWFsbHcyWFZkU2d3ZHY3VDdPaDFHd2pYV1hSMnhWZ2NMUHplZzUy?=
 =?utf-8?B?cnFmU0w0UXdtZzB4bkVPZlJzN1J1YVk0SUZMV25GVEJUQzQzNEw2amlXdDZu?=
 =?utf-8?B?d2dhUm9VTjk4VHhkN0NGQWZvTkVhUStIZDhQMWhSSm1sczYxWTZyWnJncmRn?=
 =?utf-8?B?Nm14bXBOSzRyeGVyRStQYWkvYlp0MGhGNXo0L2FLdngwY3FidlMyTzROaEhG?=
 =?utf-8?B?VnZzWExhdktPbzc5Vi9uSzVsTXlkbnNVQVRDUGdVVFg4Nkg1U0tkVFcwRTRV?=
 =?utf-8?B?b29VVjYwWHF1aTdQMEVUN3NIcEhwYmpKVTFMNzFocTY4bXVFRm56WW1hRFJV?=
 =?utf-8?B?UHN5OHQxODZGRGQzYWM2dlpuWkFDUmlmRkU0MHJxd0NhekpKWXFPQ2MrMGd4?=
 =?utf-8?B?YU5NdUpzTjdkZFMxWVZyUmY4WHhoRUJCVWlVSHBYZ2RXTE5RUEpnbG5RZ3V2?=
 =?utf-8?Q?DjFs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f291aa9-fdd1-4eea-8170-08dc6765bd75
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 09:29:44.7592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqnQDlCKC++AE+bpNTAirE7QQtIoL2Uy1OV2jccL00RrPnnHapWLXaijgwWc30/gKH/HqjTl9EpUwGbyuu+OcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993
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
YWdlLS0tLS0NCj4gRnJvbTogSmVzc2UgWmhhbmcgPGplc3NlLnpoYW5nQGFtZC5jb20+DQo+IFNl
bnQ6IEZyaWRheSwgQXByaWwgMjYsIDIwMjQgMzoyOCBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+OyBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1kLmNvbT47IFpoYW5nLA0KPiBKZXNzZShKaWUp
IDxKZXNzZS5aaGFuZ0BhbWQuY29tPjsgWmhhbmcsIEplc3NlKEppZSkNCj4gPEplc3NlLlpoYW5n
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzNdIGRybS9hbWQvcG06IEZpeCBuZWdhdGl2
ZSBhcnJheSBpbmRleCByZWFkIHdhcm5pbmcgZm9yDQo+IHBwdGFibGUtPkRwbURlc2NyaXB0b3IN
Cj4NCj4gQXZvaWQgdXNpbmcgdGhlIG5lZ2F0aXZlIHZhbHVlcw0KPiBmb3IgY2xrX2lkZXggYXMg
YW4gaW5kZXggaW50byBhbiBhcnJheSBwcHRhYmxlLT5EcG1EZXNjcmlwdG9yLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICAu
Li4vZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvbmF2aTEwX3BwdC5jICAgfCAyNSArKysrKysr
KysrKysrKystLS0NCj4gLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTExL25hdmkxMF9wcHQuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTEvbmF2aTEwX3BwdC5jDQo+IGluZGV4IDVhNjhkMzY1OTY3Zi4uY2Q4OGQyYzM4NDFhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL25hdmkxMF9w
cHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL25hdmkxMF9w
cHQuYw0KPiBAQCAtMTIxOSwxNSArMTIxOSwxOCBAQCBzdGF0aWMgaW50DQo+IG5hdmkxMF9nZXRf
Y3VycmVudF9jbGtfZnJlcV9ieV90YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YWx1ZSk7DQo+ICB9DQo+DQo+
IC1zdGF0aWMgYm9vbCBuYXZpMTBfaXNfc3VwcG9ydF9maW5lX2dyYWluZWRfZHBtKHN0cnVjdCBz
bXVfY29udGV4dCAqc211LA0KPiBlbnVtIHNtdV9jbGtfdHlwZSBjbGtfdHlwZSkNCj4gK3N0YXRp
YyBpbnQgbmF2aTEwX2lzX3N1cHBvcnRfZmluZV9ncmFpbmVkX2RwbShzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSwNCj4gK2VudW0gc211X2Nsa190eXBlIGNsa190eXBlKQ0KPiAgew0KPiAgICAgICBQ
UFRhYmxlX3QgKnBwdGFibGUgPSBzbXUtPnNtdV90YWJsZS5kcml2ZXJfcHB0YWJsZTsNCj4gICAg
ICAgRHBtRGVzY3JpcHRvcl90ICpkcG1fZGVzYyA9IE5VTEw7DQo+IC0gICAgIHVpbnQzMl90IGNs
a19pbmRleCA9IDA7DQo+ICsgICAgIGludCBjbGtfaW5kZXggPSAwOw0KPg0KPiAgICAgICBjbGtf
aW5kZXggPSBzbXVfY21uX3RvX2FzaWNfc3BlY2lmaWNfaW5kZXgoc211LA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ01OMkFTSUNfTUFQUElOR19D
TEssDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
bGtfdHlwZSk7DQo+ICsgICAgIGlmKGNsa19pbmRleCkNCkhpIGplc3NlLA0KDQpJZiBzaG91bGQg
b25seSBiZSAiaWYoY2xrX2luZGV4IDwgMCkiIHRvIHJldHVybiBhbiBlcnJvci4NCg0KVGltDQoN
Cj4gKyAgICAgICAgICAgICByZXR1cm4gY2xrX2luZGV4Ow0KDQo+ICsNCj4gICAgICAgZHBtX2Rl
c2MgPSAmcHB0YWJsZS0+RHBtRGVzY3JpcHRvcltjbGtfaW5kZXhdOw0KPg0KPiAgICAgICAvKiAw
IC0gRmluZSBncmFpbmVkIERQTSwgMSAtIERpc2NyZXRlIERQTSAqLyBAQCAtMTI4Nyw3ICsxMjkw
LDExDQo+IEBAIHN0YXRpYyBpbnQgbmF2aTEwX2VtaXRfY2xrX2xldmVscyhzdHJ1Y3Qgc211X2Nv
bnRleHQgKnNtdSwNCj4gICAgICAgICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4NCj4gLSAgICAgICAgICAgICBpZiAoIW5hdmkxMF9pc19zdXBw
b3J0X2ZpbmVfZ3JhaW5lZF9kcG0oc211LCBjbGtfdHlwZSkpIHsNCj4gKyAgICAgICAgICAgICBy
ZXQgPSBuYXZpMTBfaXNfc3VwcG9ydF9maW5lX2dyYWluZWRfZHBtKHNtdSwgY2xrX3R5cGUpOw0K
PiArICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiArICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4gKw0KPiArICAgICAgICAgICAgIGlmICghcmV0KSB7DQo+ICAgICAgICAgICAg
ICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgY291bnQ7IGkrKykgew0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXQgPQ0KPiBzbXVfdjExXzBfZ2V0X2RwbV9mcmVxX2J5X2luZGV4
KHNtdSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjbGtfdHlwZSwgaSwNCj4gJnZhbHVlKTsNCj4gQEAgLTE0OTYs
NyArMTUwMywxMSBAQCBzdGF0aWMgaW50IG5hdmkxMF9wcmludF9jbGtfbGV2ZWxzKHN0cnVjdA0K
PiBzbXVfY29udGV4dCAqc211LA0KPiAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gc2l6ZTsNCj4NCj4gLSAgICAgICAgICAgICBpZiAoIW5hdmkx
MF9pc19zdXBwb3J0X2ZpbmVfZ3JhaW5lZF9kcG0oc211LCBjbGtfdHlwZSkpIHsNCj4gKyAgICAg
ICAgICAgICByZXQgPSBuYXZpMTBfaXNfc3VwcG9ydF9maW5lX2dyYWluZWRfZHBtKHNtdSwgY2xr
X3R5cGUpOw0KPiArICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiArICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4gKw0KPiArICAgICAgICAgICAgIGlmICghcmV0KSB7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgY291bnQ7IGkrKykgew0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPQ0KPiBzbXVfdjExXzBfZ2V0X2RwbV9mcmVx
X2J5X2luZGV4KHNtdSwgY2xrX3R5cGUsIGksICZ2YWx1ZSk7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChyZXQpDQo+IEBAIC0xNjY1LDcgKzE2NzYsMTEgQEAgc3RhdGljIGlu
dCBuYXZpMTBfZm9yY2VfY2xrX2xldmVscyhzdHJ1Y3QNCj4gc211X2NvbnRleHQgKnNtdSwNCj4g
ICAgICAgY2FzZSBTTVVfVUNMSzoNCj4gICAgICAgY2FzZSBTTVVfRkNMSzoNCj4gICAgICAgICAg
ICAgICAvKiBUaGVyZSBpcyBvbmx5IDIgbGV2ZWxzIGZvciBmaW5lIGdyYWluZWQgRFBNICovDQo+
IC0gICAgICAgICAgICAgaWYgKG5hdmkxMF9pc19zdXBwb3J0X2ZpbmVfZ3JhaW5lZF9kcG0oc211
LCBjbGtfdHlwZSkpIHsNCj4gKyAgICAgICAgICAgICByZXQgPSBuYXZpMTBfaXNfc3VwcG9ydF9m
aW5lX2dyYWluZWRfZHBtKHNtdSwgY2xrX3R5cGUpOw0KPiArICAgICAgICAgICAgIGlmIChyZXQg
PCAwKQ0KPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gKw0KPiArICAgICAg
ICAgICAgIGlmIChyZXQpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgIHNvZnRfbWF4X2xldmVs
ID0gKHNvZnRfbWF4X2xldmVsID49IDEgPyAxIDogMCk7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICBzb2Z0X21pbl9sZXZlbCA9IChzb2Z0X21pbl9sZXZlbCA+PSAxID8gMSA6IDApOw0KPiAgICAg
ICAgICAgICAgIH0NCj4gLS0NCj4gMi4yNS4xDQoNCg==
