Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941C5C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 03:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CC2F10E887;
	Thu,  1 Aug 2024 03:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AwyUHyHo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 795F210E885
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 03:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsIn1rxSkDZ8DjhlgLnPi77aaNWOeslAG60H6hKhHAFgQ1Ro2/Tr98ILK/QQX++sF4X/maaflvggCQcn+H67IgnVHOOLvNo/8aB6Cb/nwB0WQLKY4kFOYE/ENEggoxqgP0sx227qQjxx9zeh9i49CEknJ0WODlZG53hNwV/QMnAuoYeTc9rAT7feCHanY8Oqkhv+HI3Euu0mvNYM8uFb2M2eug3Vp69PNItIaDhogNq/Sphu9Hy+Y6XCxInNPd2k+wHRcTKkZkHiFVS94UfSDKqfFW1o27GsJcVJaEXmNyMpn7yV3YKakS8YVmxz/A/83yWEp2Mp+UGYAHJzLHAwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcjQxV7d27O5G6lIwHqe1oNO31wG0QNTdTJxO47hmzQ=;
 b=ucfFOcjDY+1bSX/1y4l/jP6AInHFvKeWWZ+ragWBnGQOE42hArNnCBdwFE3nRyurzCl/wnmhmjRhJz+tz8CAi56GWt5ULSW5hie88xv52UwoGukNcVA1Z5TDsvw9RgQ1+M5z1ulQONdwW1JAbyJmMQXToE+vbLiOIXPFKhhBe1pmFke6Iwn/17KF8Q4bncX3+1fHvqeIXK54LS48pgT62aEQG49ui5stazF1Y5Kx3/lShvLhm5ByovXfNdU9TYUSjU4Ou9KBaTRMI7wq4ri42QjWZzKkCHSk+u/BzhRgbegoYrbYhVdhWFztG43LoprbGEZmbwc1rp1o1JhQTJ2nOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcjQxV7d27O5G6lIwHqe1oNO31wG0QNTdTJxO47hmzQ=;
 b=AwyUHyHoRe6WaU/5Fop8WgdmVcmrCseBk6Bnx8oVuvBF/SCbwjXzks2UmGZlfOUVQXW1IAvzna2+z/ltwr55XU9kPd9mVvKG7MzcJRkEeV1RsDS5k1dcdSwNVdtWGXzULNr8DZgju9KJoKJJYG8NMOQKTAZAK8ov36+oXrvUego=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 03:47:40 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 03:47:40 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Topic: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Index: AQHa4zExnRuw1cXkP02nZh2cKZwugrIQ1W0AgADvEPA=
Date: Thu, 1 Aug 2024 03:47:40 +0000
Message-ID: <PH7PR12MB8796907AF24DBCCB555F5A1FB0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240731100526.32903-1-tao.zhou1@amd.com>
 <92c3bb8c-c8f8-4445-8f01-822ab14e450b@amd.com>
In-Reply-To: <92c3bb8c-c8f8-4445-8f01-822ab14e450b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=aaa4d5fa-f2ed-47b9-a5bc-b74d42a7d7f1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T03:46:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ1PR12MB6266:EE_
x-ms-office365-filtering-correlation-id: a16c1dfb-5353-4c43-e21d-08dcb1dcb184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bjIyUGVEa3I0WjhoUzVlck1HeWliNis1Y1plajhHNUpIK1lDQUpwWW9SZDZk?=
 =?utf-8?B?WGwrRzAvM2REVHVlaG8wK2tEallhUVJieFZselJHblVkeE01RGZhTzAycG5Z?=
 =?utf-8?B?MEkvelN0RExWd1J6Snp2dUNUM3ZLc1A5d3QyRDZVZmtFc2U1S1dsNjgrVlV4?=
 =?utf-8?B?UWtBYXhvcEtJc202NUdsWUQvejE1SU1kelM2Rnd5a0ZBdTE2Qy9DeW9wZDAz?=
 =?utf-8?B?b1lscUFVYlBUU1I0and1SVpxYWdQamZYR0hxRUREZ3dhaWRGRXZiOXkrL0N6?=
 =?utf-8?B?L0ZLOHRUbjRvLzRYR2s0NmVlQTd0VXJBcFJmbk0wY2ViYXZPV1BGRWwyVWFF?=
 =?utf-8?B?ZGNaQXhpVHRTNlE2UEpGa1A4RzhlajlmQVZPcU44TkZ5SjVnQlZNejVxSnFM?=
 =?utf-8?B?Wnk5NWlYZEpqSVYvTDkrak9ZWWh0cEFNMXB4RWRoUFkvekkrTmcxTkNjY1F3?=
 =?utf-8?B?NHNQZmRqMU44ZktLTmxSTVVMNjVWQlV2Ky9RMkFHZ1ZGb290UCtvRnFZVWl5?=
 =?utf-8?B?UlRQYXp4dWJDZVh0UlRXbG4zejlyaCtsVjI2dVlUbmNZSkVDY3hNNS9ad1lw?=
 =?utf-8?B?TzNlVUh1WGkvWUhlekJ3SFZPMXNaaXFnWHdoaWVhMDIrYnVyb3daVUpqNi83?=
 =?utf-8?B?dTBxM0lhdi8vdFhzZzB4ZE9YYU56NUZIL0p6emZ2QTBlZ3lZanBlby9tWlB4?=
 =?utf-8?B?OTh0K2JrTmRlUHAyQ2Nmb05KeWxBeGdTZFp5dTNZUHRXN3pqdVJsRjBPRUhX?=
 =?utf-8?B?QXQ5OW5USXdXcnlaRFRvVnBKeFk0eG1QRmlHeFJPQmlaa2tpR29UTEVqei9Z?=
 =?utf-8?B?UlNadjB6RWJySVNlUDBUbXN4UjdDWTYxa1VJSExsRkJnU1B1WG9oOVFubFRM?=
 =?utf-8?B?WmZDbko5N21pZ1hIRkJSV0NpYjFFc0VtSFFWN0ttalorZzlTUmZDVkQxekhx?=
 =?utf-8?B?bE5SaXduMWdKLzk3WTE3U1lpV1doV21CQTF5amRPTmFaZ2xaZ3NsY0Z6eSsy?=
 =?utf-8?B?STNueFBERVpaNkNIQ1M2STR2ZC9qRllXbml3V1d5TERiSDJIUWtpY0tEdlhO?=
 =?utf-8?B?eDRWNTdJbFlRaGZWRkJiU3dhVnR3WDI1Tk9LQVVYVHJ5dlFkMXd5T21VYWpi?=
 =?utf-8?B?WVFxYWtFQ29RKzV1Y1c0VjRPUVQ4Qm53SzI1Y1JnSnFBYWloSjlXenNBSXJK?=
 =?utf-8?B?eU1HL2JYcWl0QWt4WnNXODcrZWdJMkQwTGlSYW9SOGdGNTJ6dGRMN3RWU0Fs?=
 =?utf-8?B?YjR2VVllRlprMmFGOUgzT0xNRkdFZ2wzb2JyZG1qS0I5K3RnT2p0cmRIQzVH?=
 =?utf-8?B?S3lzUE9mSHF0amEyVHpINGRFUjErd2g1OU12VmRZeVAxZi93WFFtc2Q5WWx2?=
 =?utf-8?B?eUd0VXkwdnZzVU9jZlFISExPc1hrNjNnRWJBUEsxRWgrOGd5cncraDlYcGRr?=
 =?utf-8?B?K1pEWVBjUUR3d3JoSzlGbTBXN0p0QWlIRE45WEkwdnR5cnE1eDJqbUF3c2VC?=
 =?utf-8?B?RlQ2VlNOQ3pBbE40bGxxUGFOTmlPakN6aERLV1lWNmkyR291Rkh2Y3BvOFBU?=
 =?utf-8?B?RHBDVE4wM2NhT3lQb3UySlAxNkNBcGovZS9GSXJZSzkveHVBVk84N01qdGEy?=
 =?utf-8?B?RlRsSkIwam90azlZTmxiR29IeDUyQXJNOTRXRmpXWHlrR3ZmUzNaaEw5bFVo?=
 =?utf-8?B?NmNodEdnNG16YnpmL090d1NBQ1p3WUg1U2dnOUh2VWVzWmI3KzN3U1ZHbTgv?=
 =?utf-8?B?ZDdna1Q2VE9qMitjMDVhaW1TOU9iUXVKZ2RQSDlTbi9VT1pqR0QyZkx2Z2Rk?=
 =?utf-8?B?dEhNdlpOdGtMcEZ5ZlRmQSt6aCtSbW9zUlpyNkluMllQREFDSEFPdlhzd2ls?=
 =?utf-8?B?cmkwR2w4MFBQNGJYVGw1WnI2bXdqQ1AvYUdBVEJYMkJVYXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDFmUW1FY3Y4aWJ0KzRpYnZCd1JyY084NG5VbS9BQ0cyaHdCYXFxTGlLUEli?=
 =?utf-8?B?SVhUeHc3dXlXSS9XbDdROE54TUFKWGZ2RDR2Y3BrNk5OUVBCMDNMTkVvMXBD?=
 =?utf-8?B?YUNybE94S3AzR05mNitXMFlRYjI4UWRMOTVNS0hNQjFHZ1NIYjZPWDVGWlNs?=
 =?utf-8?B?b05PaFYzYmtiSDVZbmlaMXBCNGFrTTl0L1ZSZGNRWHhGYm41VG9QUXFOcmxP?=
 =?utf-8?B?N2s1NWE4NzdrMklaODBJWVc0UVhUK0F3a2ZlSytZeXB4TThMYy9EWUJyUm1U?=
 =?utf-8?B?bHRTUVlUbUhNeWF2NGlJTGJEZXNBOWJ2MUhBV0VqVDZDbHMrN09FaW5pS0lJ?=
 =?utf-8?B?S1J1c1dNd1ppc283aHJrRlBhUkdERHBWSVNHVUU4NXlhRlV4MTd1SHE5Mm9U?=
 =?utf-8?B?Vnp6My95WmVxVm9QVHlmUEs3bjNIdUtzbk9wVEVTSFdOQWw0TmNNYkNQL0NJ?=
 =?utf-8?B?ZUovZmZqRXRrNUQ2OFh5bjQrSUEyRWNGWVZ3bldZNXFLcmhVMWYvQUhjNkhi?=
 =?utf-8?B?R0ZLRjFEaC92OFBmSzZ3b2lpL29SYkNCRWFCWFAwdEFmRzBuNHhoYm05Z3B5?=
 =?utf-8?B?aEJ5QmloRnQycHZqT25VcXFTQWZ0eFZBT1dXWHBDOXRuV0pIZTdVWnhKWXQz?=
 =?utf-8?B?NkNpN1FKNE5XTmQvcW9MQ1hxMjlxU1NHVFMveGw4aTdrUmxZazlBYnNMd1dN?=
 =?utf-8?B?SUhRRUhkWkJ3VDNERytjbVRHYjRQa0VRSVNkY0M5MzEzU2FHNE1ia25FcGpr?=
 =?utf-8?B?cDdQWUFKZVBkV0Y4TjhaZVQxRVU3ekVoNElHL0tWM1RLaUZOaitlMkFJa2lM?=
 =?utf-8?B?TXRaVXBndXFINE1kT3hWeHZJMGcwYUlJZ2N2SGI3anJsZTdEUm90citaaXM2?=
 =?utf-8?B?bmFERWpMZElSdzRXM1d1SUw4cUxNVkViVlAxQVp4a05Qd0xjQWZuc3N1Tkpl?=
 =?utf-8?B?eWhGTTNqWmRwZ3pscnBKOG1CK1NOWkRHWnJZaEdaa0tjc2o4MjMxN0hyWG5q?=
 =?utf-8?B?YlZkYXJxSCswZDJodXRpR1ZKQXdTOHJSM0owMEc0RGQ2aFdYYmIzT09pK3o3?=
 =?utf-8?B?c3JlUEZieHJmT1RXRTc2Q0I5N3ZhK2w1SmJtZkNvcWFUWHNHcisxN1htM281?=
 =?utf-8?B?bC9ialhjalZhRS9WakNVWXJHRzgrRzQ5NnJ2Z1JqS3RVWEtkbVF1NGpzdDBk?=
 =?utf-8?B?WENuR095U3J3YmgxcFd3WnpVeS81dlpVTGFaVklyeklrUkhVVFl3RzF2TmhX?=
 =?utf-8?B?cWk2Ync5cXNPRXRlUlNaZmFJMjRTZ2FzQVVtQXVSWlNleEh6eUxHU0h5b3p4?=
 =?utf-8?B?Z0JzZlBXMzRSa2wwcVlaUndrdC8rcTg0Um5uOEkwb3ZKNHNXWktwNlR3eE9P?=
 =?utf-8?B?cWdSNmk5UHBnMHUvVzNjSG0vMmxvaE5mR0RkK281Z2t3bDVsZ05GSTRLQ0Fw?=
 =?utf-8?B?MXhDZVJhdGNkN01zRVVUQjVWU2wyUjFZT0wrUlZ5WCs0Ym9jektFZzJzejFE?=
 =?utf-8?B?RFRmQmxraER5YVplR3pMZW5UTVloNkc1Yy9BSFVpWEZremhUQWNibGw3T2ht?=
 =?utf-8?B?QVFoVVR2OWU4dFZ5NEFidWxEQmN3VHQ4TEtGZ2dNUFMrVW1EOGd3TVlMQkFs?=
 =?utf-8?B?NEZmQTlJTXZTZ1NVcUt6TnJTbVRFMlJTNGV1RTRPNzB2NUVLckR0QmhvT2x0?=
 =?utf-8?B?d2NpODhLOHNrd0ZSc2s0WXhOTGh2VkFUSHFRU3BCUHVXSkE3Z2k2a1E4d0xJ?=
 =?utf-8?B?d3pBaG5zdG1lZEpPdGdnOTZTUzl6T3VHaVFEMmlsYXdYSDF6MmhNYlljNTVh?=
 =?utf-8?B?b0thTEJReUd5SGM0T1lvdFZMYzdLMmxKOTVyWVo2aE1tcndWR3kwYjQ1akdy?=
 =?utf-8?B?Sk0vM0E0SlExNHplK1ZRaGNaRFRXNW5pQytKcWp3b3BoNkpxaVZaUitzc01w?=
 =?utf-8?B?SnVzRGVWci9zQ3hLQnBPM2J0c25rakQ3NTNjM0s3L3pid2NFNlhHRjRFRXJV?=
 =?utf-8?B?ZU1UZUJmVUFNekRVUXVSWVVseWtxdVl6OWRkRjhBaUc2clJDcGRWRnNsZ1VS?=
 =?utf-8?B?c1FrUHAwODVaL0QvMFB2bmltOXBQd2ZnOXlWRnhkdDRZZkpwVWV1MFVjNklZ?=
 =?utf-8?Q?vKzI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16c1dfb-5353-4c43-e21d-08dcb1dcb184
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 03:47:40.8449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXpQhUKwZHPHZwzzAUZVPgB10sDjV3gz9XFeNxmZwCovJNTGhPpQmyhdqCqfU6ZS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlq
by5MYXphckBhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMzEsIDIwMjQgOTozMSBQ
TQ0KPiBUbzogWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiByZXBvcnQg
YmFkIHN0YXR1cyBpbiBHUFUgcmVjb3ZlcnkNCj4NCj4NCj4NCj4gT24gNy8zMS8yMDI0IDM6MzUg
UE0sIFRhbyBaaG91IHdyb3RlOg0KPiA+IEluc3RlYWQgb2YgcHJpbnRpbmcgR1BVIHJlc2V0IGZh
aWxlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jIHwgOSArKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYw0KPiA+IGluZGV4IDM1NWMyNDc4YzRiNi4uYjdjOTY3Nzc5YjRiIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0K
PiA+IEBAIC01OTMzLDggKzU5MzMsMTMgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIo
c3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAgICAgICAgICAgdG1wX2FkZXYt
PmFzaWNfcmVzZXRfcmVzID0gMDsNCj4gPg0KPiA+ICAgICAgICAgICAgIGlmIChyKSB7DQo+ID4g
LSAgICAgICAgICAgICAgICAgICAvKiBiYWQgbmV3cywgaG93IHRvIHRlbGwgaXQgdG8gdXNlcnNw
YWNlID8gKi8NCj4gPiAtICAgICAgICAgICAgICAgICAgIGRldl9pbmZvKHRtcF9hZGV2LT5kZXYs
ICJHUFUgcmVzZXQoJWQpIGZhaWxlZFxuIiwNCj4gYXRvbWljX3JlYWQoJnRtcF9hZGV2LT5ncHVf
cmVzZXRfY291bnRlcikpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgLyogYmFkIG5ld3MsIGhv
dyB0byB0ZWxsIGl0IHRvIHVzZXJzcGFjZSA/DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgKiBm
b3IgcmFzIGVycm9yLCB3ZSBzaG91bGQgcmVwb3J0IEdQVSBiYWQgc3RhdHVzIGluc3RlYWQNCj4g
b2YNCj4gPiArICAgICAgICAgICAgICAgICAgICAqIHJlc2V0IGZhaWx1cmUNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgaWYNCj4gKCFhbWRncHVf
cmFzX2VlcHJvbV9jaGVja19lcnJfdGhyZXNob2xkKHRtcF9hZGV2KSkNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZGV2X2luZm8odG1wX2FkZXYtPmRldiwgIkdQVSByZXNldCglZCkN
Cj4gZmFpbGVkXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0
b21pY19yZWFkKCZ0bXBfYWRldi0NCj4gPmdwdV9yZXNldF9jb3VudGVyKSk7DQo+DQo+IEJldHRl
ciB0byBjaGVjayByZXNldF9jb250ZXh0LnNyYyA9PSBBTURHUFVfUkVTRVRfU1JDX1JBUyB0byBj
b25maXJtIHRoYXQNCj4gdGhlIHJlc2V0IGlzIGluZGVlZCB0cmlnZ2VyZWQgZHVlIHRvIHJhcyBl
cnJvci4NCg0KW1Rhb10gSXQgc2VlbXMgQU1ER1BVX1JFU0VUX1NSQ19SQVMgaXMgbm90IHVzZWQg
Y3VycmVudGx5LCBJIHdpbGwgc2V0IGl0IGJlZm9yZSB1c2UgdGhlIGZsYWcuDQoNCj4NCj4gVGhh
bmtzLA0KPiBMaWpvDQo+DQo+ID4gICAgICAgICAgICAgICAgICAgICBhbWRncHVfdmZfZXJyb3Jf
cHV0KHRtcF9hZGV2LA0KPiBBTURHSU1fRVJST1JfVkZfR1BVX1JFU0VUX0ZBSUwsIDAsIHIpOw0K
PiA+ICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICBkZXZfaW5m
byh0bXBfYWRldi0+ZGV2LCAiR1BVIHJlc2V0KCVkKQ0KPiBzdWNjZWVkZWQhXG4iLA0KPiA+IGF0
b21pY19yZWFkKCZ0bXBfYWRldi0+Z3B1X3Jlc2V0X2NvdW50ZXIpKTsNCg==
