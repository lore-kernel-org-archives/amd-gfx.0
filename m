Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C707C87FD2
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 06:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C2F10E0C7;
	Thu,  7 Aug 2025 06:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BpsKPMh0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E8E10E0C7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 06:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fc7OXg9v6D4Y45JZgVQpHa0iO+rgtEiyWO5gyJc4WD9p72FbpJF0V2A5RKyAyujqVveGyLmGRfh2Z5FsUj8A0LRx3hdGm0bj5z10cDbTbKUGigrZ3pPfH81iyYxPHdFFEp6uiwE9nQ//xC4WkuezTcp50Vc19mNwZx4eLN2ZOF6VzNEf2DuGZU6NgZKNT41hKePem5jEJpoJb8CarIgF8GNPNF5XaXnXPJLcLphOD2RPluR3kMK5H6aqf9a3o6dGy3CCRYLdTOIL/xIOjatzhMAksh/WG1XxfRwt4/68iOHmJn+pXMGzj6/GcPl24G84jN+cBsv64Em7rMNyaHX9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3FshRfNOa33a7K4bFrHGUoXm0+ruSLY6srn2hxC3cw=;
 b=mFqRvdGGu/yZzWPoIODAUfYEjuJDiaLTJpa40w8E9yba20OaCtJLCamzhVrpExe49MOxsK2qQywTVXktRh8YRoyCFfJqQcgqz9q9IcBk31o89BNJxUzVI9DAbSjj6rGX0sAuIiZdve8lHeTt2mk6XpRJCIGaK35qDCZT8876Gj/9DX2bJbj/5xSqNzgNHFqyWROicRiER2RjXE6DGJp7EpvEL9J3s/dHw3EFduaOqb4Ww3pvTGA3Ah+xsi3XhQj8sCE+Z21mItRnIN5auPOtMtw4KqenqijUOAXuAftCPzitDN6/nqUWDxha+RAYMtMRybKR72NAYIlHF2up20jiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3FshRfNOa33a7K4bFrHGUoXm0+ruSLY6srn2hxC3cw=;
 b=BpsKPMh0QQqiUAAxBsfyX4nRuXsBD2f5lq+9g5F0JHDEZysZ+wgiaKgF8QNsKIFUkO/QD36WV8EnnhXPe055pkokYCCtuVZeGi5iKrv5mdv1yntyZlCfOssTJGyHsqOeWRJo+NSfN9N7ztGD/i/VFKME6rUNxNQ0FTe/bpDRvFM=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 06:14:34 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 06:14:34 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add description for partition commands
Thread-Topic: [PATCH] drm/amdgpu: Add description for partition commands
Thread-Index: AQHb9wsPlar9eoR2KUicZ6Vkf7390rRSA7kAgATTQZA=
Date: Thu, 7 Aug 2025 06:14:34 +0000
Message-ID: <DS7PR12MB607132410116C34B8A00B2C48E2CA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250717110722.1557961-1-lijo.lazar@amd.com>
 <124c2f27-760d-4a13-a343-310ef356be2d@amd.com>
In-Reply-To: <124c2f27-760d-4a13-a343-310ef356be2d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-07T06:14:28.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|BL4PR12MB9533:EE_
x-ms-office365-filtering-correlation-id: d77625bf-1251-4f4e-4573-08ddd579ae37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?djRxMlF6czFXTjc3WEJPY1pVdnF6VlFZRDVENy81a3BoMnJTUENQcFFpb2J3?=
 =?utf-8?B?U3RlbnkyVWQ2c09aUGhWRExlYnRRdExkTUV1Um0rcnRWZ2dOYkFQWS9LRTNF?=
 =?utf-8?B?U2MzaTlNVEY5dXRGV1Z3UG43dDE2UFkwL2RwUVBlMWVKVlhySUtKajVScnZp?=
 =?utf-8?B?NUxnSUdLMjlLQ3duTU1vQkRWc0k4SWFVZzVnd2J5TVpZazZSWERQVS9ENGVB?=
 =?utf-8?B?STNGL1ZwcTlPKzJnOVlkTHFBTkUxci9zcEpuOS9abUYreXViZ2MyQWNFa0lx?=
 =?utf-8?B?ak0vVFlHU25VM1NuS0ozSUtKUU9oSmZiL1NBUWNiV1hOWjNyc091Y0tNQTBD?=
 =?utf-8?B?SCt4WFNVSkhVTzdMY0FFcU1xSHBBaGxPQWppdnN2dW45K1ZjdVdTWHJvcUxs?=
 =?utf-8?B?UkRLN3ZzVGY5bGkxWlRSRHR6ZkZwa1RsTDlpQVF5ZUtpWG8ySmhtOFNhazds?=
 =?utf-8?B?WCtaYlFHdDZHYUtFTkpYbWpIdDdHRkdvOGdIQmxMT0xDdWxzMjdKYndCYXNl?=
 =?utf-8?B?Nk9nK0daTVhkenNsbEFiNjc2YlY3d3I5alVjU3FNb1NnaFdwMmw1Q3pWa1E2?=
 =?utf-8?B?SnkrTzB6dERvUWRoUHpHS1VwSEdQaVJ6L2hMNGR2NHo1TG1PVHBZTVFielA0?=
 =?utf-8?B?bkFHbXFsUHc3VGVGWmZ5R0dDNVNQbGwrVzVHUzBOaE9xVllWOXl6NHF6SlZC?=
 =?utf-8?B?MXVwRXppcmhEbGtLSWR4VXNoWEtXS1Mxdm1xSlVSdmhWOTNlRGc1MzAwVlFS?=
 =?utf-8?B?ZjFQZER6L0E0bUltdk9lZmlkM25QNnFxcFVuTzI5V0FVZytkSnA4V3hNSkFo?=
 =?utf-8?B?elhacEpKOVdiVkM1VWdRUlFGSG1VUm9ZNFk5V2ZoeVZScGlLQnY5ZUsybndn?=
 =?utf-8?B?emloYUErWEVRTjgxazkyQ0NIUmRIMW5VbXdSbS9WS09ZbjEzWjRSb0krNXli?=
 =?utf-8?B?QkVKQlR3cjFqTW5mNTRZdDYra0ZUaWpqb1hFUXlyWHE5QllJNFROWEpobEFZ?=
 =?utf-8?B?M2Y5c3kyMGxWR1NKT0xjeW1HRlFXcTJvcGROdllzaVpoNkl2VjJWMHFPSWwr?=
 =?utf-8?B?QzVuMlJpRzhJbGFNOFZPVTBiMmExcjN2RW1JWkViWTNHanVpbFNTek8vRHRx?=
 =?utf-8?B?ZWIrNHdOY2s4Q25pemhzSTVkM2ZmSTc2NzZxMnU0RHNQUkhCLzJoYUdwV21k?=
 =?utf-8?B?RlBBTFJkYituYnl5TnRSRXd4QytwbVppY2xkYWcydGwyTGY1TFlrSlA3Rllz?=
 =?utf-8?B?bVBlWHU0YjNiRWM1RGNYaGtTUVdPanlZckcwbGxLRU11azhrUzhLMnM0cUhB?=
 =?utf-8?B?ZTl6eDFsVncwT04vSUlFUGxoY0JBMm1pZ2pwbGZzQkdOQ0hnYlBhMVFFcExY?=
 =?utf-8?B?akN1ZDU4d1ZNVVRuQlhzWXBvQkNIRFRLbDBONnZPQVJuU1ZLL0VJZHp2elI5?=
 =?utf-8?B?REpnb1dPVDlaMkRHYXBZUEdYTnNCZ0tqdUREcE1TQzZ6czR2aHRaV1BDV3pR?=
 =?utf-8?B?M05Gamt5U0dGTXJBL3FUMVB6RDdiQzQyMzdmMlJxNmF4VEt2dVVDdlNDU1JS?=
 =?utf-8?B?TVR6WnFIVnpxWDlmUTBWQ2liYXRTNml5MVBhcllqOC9USllmcXYzOVJKY01Q?=
 =?utf-8?B?aXBtcEFWSG1aSjlmL3JkWTI1R3ZUeHROZ2pta01HbFBocEIwN2lwZ3NEUDBT?=
 =?utf-8?B?dnozWGZ4M2NueEMvRWs5a1ZDNFl6dmpVOHFtdlR0SHFVWVkvemRHcmxMTjJi?=
 =?utf-8?B?WldxcTRaVW9nVDBwcnJBOENGZ2xGK1EzOGZRZTduY2pGQjNpK2hjQndKZFVE?=
 =?utf-8?B?OWdyMU0yRktRdnpjUWtoalUweERFNFEyanpIRXVaL1dJRGcyZnBicG02dmd0?=
 =?utf-8?B?ZjNma0xJN1Rlc0t3TUFKaHU2Qi9ydTBzU0xiR3ZIOGJmc0JUOHhGU0NvWEdD?=
 =?utf-8?B?SEQrbmR5bzFibjV3OTNLbGxxS2VtdmJIYjEzbjBqRGpiMEVMZ1JlWkcwa3Jh?=
 =?utf-8?Q?Q+9y0e/bJRa/EG6sPr6D/S8EXJDNyA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHM4UjhJRDVla2UyNml0WWNWMFpQN1U3S3RiOWlEajVKSStKN2dxYmdxdTRs?=
 =?utf-8?B?QkN4M0hqbzNHNkNmak9jbWhGQ3VyeVJGVU1LbW42QWI2RHI0eHl4Ty9sOEpV?=
 =?utf-8?B?WWxCSkNsYTZEWU9aYlJpQUNWRFRWZkhIUlBYNXUwckJ4UXBOZnFCQnNLbzky?=
 =?utf-8?B?bDJ1ZlhBVHN1eS80WHhCWUc1VWNmRWIwbUlLZ0d2UlEzMklIdVNkQkFzS3VF?=
 =?utf-8?B?WFlwL0N3UkFqWWN4YmhYMVFTOE1IUFY2UWxkOUU4ekg3T1k2MTBWN0RGRTVD?=
 =?utf-8?B?amNqQ0FlaWhGQ1c0bmI5b3BCWjIramNCbS9UcXpReUl5UmtuZlpRc1IzcklG?=
 =?utf-8?B?N2J3Qy92MDRyc1kzMjJtWFdhaDNqUTd6UVlZYUhQUnNERlVMNWxIR240cWhu?=
 =?utf-8?B?MmRiUVYrUW45SG5WdmMxQmw0K3lLaWx6aHpXSU84dWhMQWNRVGYwNmI0Z3dS?=
 =?utf-8?B?Z2lpbEFjV1JmckFVSUI1U2psNzIvOW5ha00xUG5NWTMwK1BEdmFvNjRZdy84?=
 =?utf-8?B?SDB2eW9OVDhGQTNiYWZzQVNzVE9TWHpSMTYrSndtYlVZQnRYY2ZxNWt6YXl2?=
 =?utf-8?B?SHkxWnArYW9BWE05eHNZWk40TUtwSUFocVprWWhKSWZoeFB6VzUrUUs0eXox?=
 =?utf-8?B?YkFDYU9zb0tuT2JCaDJZYVlIMkd1eXgwUWNGVXloOUsyek42akFzYzUwaDkz?=
 =?utf-8?B?dTl1UUN4SlNEaHQzeVdxcUNaVjV2bHZ0VERoYXh6TWFTM2NjZFpRcGVMN253?=
 =?utf-8?B?VXRHZXZyQmdvTkFrNTk5R1dUQ285YldMOTF4VGhuNGxhSEdhdU9LdWhXYzFw?=
 =?utf-8?B?VXNXNVpqWDBuWG1zZ2tGZTZLckl3SGMyUlVFM0xHcnZtajdFU2tBckV5VS9I?=
 =?utf-8?B?eVJ3Wkw1M1M0OHVNL2o3RXAyUlZRUVRvUEdza0pjM1FPdkdKY0UwVnFyUDcv?=
 =?utf-8?B?YXd0d0EzazRIVVpkYjVIRmdhSjZqT09Dc09EZFU0Q2JpSWZIREU0MFhoR3Z3?=
 =?utf-8?B?UzdwbTFWb1dMN2VVU1hqNkZkY2R4SWNUcWlzRDVFOE1pNit4bEtsMHhIVzA5?=
 =?utf-8?B?a2ppY1hRV2RkTnk1SWpoNkNZU01Ld1NXeDErYkYxU1ZrNUtseWIvc2k1aGVB?=
 =?utf-8?B?d28rM1FqeWxNVHEzcFE5RU5LKzhQeXhLak5IN0duc0l6dUdXa2dTZTJ6YVJ5?=
 =?utf-8?B?V2VBa3ZDNFhCQzBGdUpTcWZDUjBJaGl4VVJCd0xyd0dYaXFscmJQbkJNT2tC?=
 =?utf-8?B?Mi94ZE9FU201V1MzOTkyTHJoMHNVaENhWjFQcWtsdnZ6WWQvWnhQR0xTWUhW?=
 =?utf-8?B?UnlGZGFHS2lmazRZSldaQlNvcVg3SjBvUjhUeGw4QVM4UDVOQVArZHZ5dlh5?=
 =?utf-8?B?Um9DUHM5dFh4NG1GRmpjRzhXREZYLzVZaEJVZDVqbjRUQUUvWTJMOVVYOWZ4?=
 =?utf-8?B?UTFZdTR2QWJDY1c5dVJEVHZFT1lpU3gzdTVja1F4bTNmVUF4aVFuT01nRWlp?=
 =?utf-8?B?YlBhcnFEZk8yUmRhQlRzMmlib0xQcDViWGxaVEl3blhmSUx5ZHJzWnBIbVlo?=
 =?utf-8?B?TDlFcUtjSWtMdGlRZ2NNd3FVWmVmajhLVER0RkhhVElLRExIS2t1TkkwaGIr?=
 =?utf-8?B?KzB2SFZVM2tDS2hBVkt2NkhaL2tWeVRlV09Eak5VWEF6TXF3YTNFZFFoSEVs?=
 =?utf-8?B?MTRBQ3NRTmpqV0pEYk9zODJtSFF0UXJCUnZNRGxtTFJ4MG50b2VTYnh6WWZR?=
 =?utf-8?B?dmJwVkhHekQ0MjJWOGZEMUF2enFMYmg1ZlpHSTdFQWN1d3kzbGN5Mlh4OGZV?=
 =?utf-8?B?K3VxWDV4NkVUQklGQlJNN0ZMNHFBQkVicXZZSElQQmdEWHY2bXpyVnhueDdR?=
 =?utf-8?B?bHRQbEhsWWF6cVdYTWFCdTRKQmVyMmxRQkdtRzY1bEsyN3J3MlFHYW11L2JO?=
 =?utf-8?B?MnpEaE41aU56cGFmTUN1UzlJOG5GcTh1RkVJY2tTSmVWS29Ydyt3NkV6RjE4?=
 =?utf-8?B?RVlxQUxaZVRzaFJPdm9CS3luTUNqcHA2SEQ4S2NFVmlIdjlhcHdVTjIrRXJK?=
 =?utf-8?B?cHNmNU9jRlV4ZTEwdDFBUWtrem1FRVdwZnNNTGEyYUdhSFJnZDNDcE0raTJ2?=
 =?utf-8?Q?zN4g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77625bf-1251-4f4e-4573-08ddd579ae37
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 06:14:34.7000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+IQpL9etL3HNYK1IFbrIquh/SBLTXnacHVlh2Nj9u/S3M4/FsWrF5gmMxoQO3DVZLRJBuX2YQdSKxacIIXfIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUmV2aWV3ZWQtYnk6IEFzYWQgS2FtYWwgPGFzYWQua2FtYWxAYW1kLmNvbT4NCg0KVGhhbmtz
ICYgUmVnYXJkcw0KQXNhZA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IExhemFyLCBMaWpvDQpTZW50OiBNb25kYXksIEF1Z3VzdCA0LCAyMDI1IDEwOjAzIEFNDQpUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogQWRkIGRlc2NyaXB0aW9u
IGZvciBwYXJ0aXRpb24gY29tbWFuZHMNCg0KPFBpbmc+DQoNCk9uIDcvMTcvMjAyNSA0OjM3IFBN
LCBMaWpvIExhemFyIHdyb3RlOg0KPiBBZGQgc3RyaW5nIGRlc2NyaXB0aW9uIGZvciBwYXJ0aXRp
b24gY29tbWFuZHMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJA
YW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiBpbmRleCAyNWFhMzVkZTFlNDEu
LjAzMGQ3ZGI3OGI0YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYw0KPiBAQCAtNjY2LDYgKzY2NiwxMCBAQCBzdGF0aWMgY29uc3QgY2hhciAqcHNwX2dmeF9j
bWRfbmFtZShlbnVtIHBzcF9nZnhfY21kX2lkIGNtZF9pZCkNCj4gICAgICAgICAgICAgICByZXR1
cm4gIkZCX0ZXX1JFU0VSVl9BRERSIjsNCj4gICAgICAgY2FzZSBHRlhfQ01EX0lEX0ZCX0ZXX1JF
U0VSVl9FWFRfQUREUjoNCj4gICAgICAgICAgICAgICByZXR1cm4gIkZCX0ZXX1JFU0VSVl9FWFRf
QUREUiI7DQo+ICsgICAgIGNhc2UgR0ZYX0NNRF9JRF9TUklPVl9TUEFUSUFMX1BBUlQ6DQo+ICsg
ICAgICAgICAgICAgcmV0dXJuICJTUEFUSUFMX1BBUlRJVElPTiI7DQo+ICsgICAgIGNhc2UgR0ZY
X0NNRF9JRF9GQl9OUFNfTU9ERToNCj4gKyAgICAgICAgICAgICByZXR1cm4gIk5QU19NT0RFX0NI
QU5HRSI7DQo+ICAgICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgICAgICAgcmV0dXJuICJVTktOT1dO
IENNRCI7DQo+ICAgICAgIH0NCg0K
