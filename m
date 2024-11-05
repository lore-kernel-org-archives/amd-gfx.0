Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E34D12663
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 09:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6430610E3FA;
	Tue,  5 Nov 2024 09:16:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F5YUnqxV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D34610E3FA
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 09:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4IHQ1S4JErUqhnn+KMUbl4O26ycCVCzRaQdt9EqRii2h2YPolC7rwzsVW2pQaa7uK0r0Vp2wq6102vP7Hq1buLyWenamwJm0JrM6L9lT34ra3P8nMLqUNam0foXMa/j6an+JaQBla6RuMIOwWU4Jryr4L/u6GMkDXIMZscTVhQeOCEmL5KfEjqSxA8F7TRIXzfUMdZPhCyHTDfbRNs0r12/ERDsWVUICYkuKGLmrmY57cdaNDHeMXSO0myQ28Xka9SLZIvTos7iDrDy8gDvj9BOb/6XlfmUBRSVATQlGAWESYBbyoVtGqWF01l15G1Q3cmSVctrhSg8rp2oHJ9h7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwzXPOfceM6KUU5NT6q9HCHMcNuS2viLAtQgx8+S8dw=;
 b=BT4NVnxXfJaQ9NApYdevCkM1KR02zVTMM+LoFW/PJ9vOhPFfdfudgpNZfH2BTFKZPOwr36ob1UhejWXFGyWusbqQsMHDEMOAFAGSa34UkN3iRwGileLbdNy8EGXj/KOzfGXht/BrwxHriXMez8eP5JMewmPKhB+ysxCPmAVLh2NDGKZtbNBGd8Bk075WmWcP02Fn1t0DJGXVuDKlG/xpztZCLQOu743fCqsEa9D09KusW7aAw/WQ6Qtq/M+4m/Au2OZj8pJYeAuit8pOClV/LxxJjmhLRms+k2WLgj4UJqUWCT9NcXFbnzQjbiGtUq5Qq7DkO6+4Ur+OzdAHs5a7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwzXPOfceM6KUU5NT6q9HCHMcNuS2viLAtQgx8+S8dw=;
 b=F5YUnqxVb/W7bdMa369NxviN7I/Yj5K/SqE0zRK3QxTNAg002tTjC/GLeCH2pFErSofBum4tYsYM/P+VCocXz8tiD6HVKnOIFsYCk5KnWanlN9zcLW+x7+FMY/K1+8jMUcFhEpHAcJdVcD6wxZOx8QHSBbvP6EyyoHN+qshNoZk=
Received: from DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) by
 IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 09:16:53 +0000
Received: from DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::ae90:ca3:5db2:1a78]) by DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::ae90:ca3:5db2:1a78%5]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 09:16:53 +0000
From: "Li, Chong(Alan)" <Chong.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deng, Emily" <Emily.Deng@amd.com>, "cao, lin" <lin.cao@amd.com>,
 "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>, "Yin, ZhenGuo (Chris)"
 <ZhenGuo.Yin@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix return random value when multiple threads
 read registers via mes.
Thread-Topic: [PATCH] drm/amdgpu: fix return random value when multiple
 threads read registers via mes.
Thread-Index: AQHbLy2nSkECRWsvyUe6x/kPI900ZLKoYZ6AgAACctA=
Date: Tue, 5 Nov 2024 09:16:52 +0000
Message-ID: <DS7PR12MB57686B01957C972F3DB311A59B522@DS7PR12MB5768.namprd12.prod.outlook.com>
References: <20241105024852.30452-1-chongli2@amd.com>
 <c7c4cac9-66f3-4dc5-939f-e6ae95e13535@amd.com>
In-Reply-To: <c7c4cac9-66f3-4dc5-939f-e6ae95e13535@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4136209b-5534-46f2-9410-08aa0628715f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-05T09:00:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5768:EE_|IA0PR12MB8208:EE_
x-ms-office365-filtering-correlation-id: a87feacc-60c8-4fd3-820b-08dcfd7a965a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZlZxanZxYm40S09NNS9LUzZaNUlQUVFyT21hTkI2MlRNWERxaytsVldZd0VK?=
 =?utf-8?B?dXpDTWdYbldHZG9tSU1oY2VMRWVpN0k4MU9jbFJvazV3bU9xTExIdmhpdzBW?=
 =?utf-8?B?cit2Qm1DdCt0Q3R0ZCtyeFVQSUd6L3JyWmw4OS9saFhpWkdSVHJXSU9LYmxM?=
 =?utf-8?B?Y1dBeUJTakRBMk5RTFpRSDlkUEtiNGpVaTg5ZUU3NmlKWVJxTENvL0U3eHor?=
 =?utf-8?B?L1JUaTkweE1WSXhEREJCSzNwN3dxZm9nQmxuOW9td0NjMisvYkRCTitmaGlX?=
 =?utf-8?B?eFZIcnVJd1Vua1UycWNvUGREeXNwNFVhZHBkWS9BTVRVWFV3SG16UmppSDhw?=
 =?utf-8?B?eHpUM3cwSjdNd2NLT1dORjE1VG5vMzdPSExUOHBiVTgwTHFxaUQ3TGZTS1ZL?=
 =?utf-8?B?bkxHS1c4OFZ2MFMveTQ4K1VwaDBVR1ljcDJHUnNZdE5yUURmRk5PWXJxUUdp?=
 =?utf-8?B?MXFXazBxVElkQm9kRHRyZ3FLK1FYMm5rbnQ1N3RnV2M4RnZlUkQvenhhckp4?=
 =?utf-8?B?SC9XSW8rQTBVbExETFZNRjczUDZnYzJuMVovQ3F1NThaOVJKRkdNTldSTHdO?=
 =?utf-8?B?Qy91RkpDUEhwS2luSkh0bWtpc3NjcFRYOXNORUtxNFFDNzBZcHhwaVNVQ2NY?=
 =?utf-8?B?TXZnK3l0UzFPTks4dE54YWk4YlovN01qeUpSVTdVWjFUeWlTUlY5Nmp0N2Mr?=
 =?utf-8?B?TVlCMU1TYlF1ckF3TU95bmlQV1RYTTlNNzF2emlGbDJYODdhQmwyd3c0ek1E?=
 =?utf-8?B?dlVmM2Fjbm9TeCtSL2xBL3NiakZRZTRCNGFGR3gwc3RXMlZnTVNzUWsycUVv?=
 =?utf-8?B?ZGxLRjRydUJkM0FscU5DL3ZvVmc1dzVrUHgwL05od3ZOS2RCSCtjeFgxd2xK?=
 =?utf-8?B?TWtFWUlyZmZWQzFJUjN4czFJR044Nnptb0lEdXgraVNzN0ZMMFZrajN0UHZS?=
 =?utf-8?B?NjdqWkoxMEJ5SnAwbWc5SDdWNHVUamVRVmU3Z1dEbUt0MW9mRFYraGM2Y2lZ?=
 =?utf-8?B?cmthNWR2Q3hXMFBMRjBuYVE0eU1COXlNdUJpQkNmQnNBRzYxSlFMQjVFYXNy?=
 =?utf-8?B?amZGMTBKNUptVmU4QzNmaHByajhxRlBHbEY1NnFwRFVPalE5eTRORU1CZDVw?=
 =?utf-8?B?MXFhSE5WUVByS3pJajZJL3pGWlptenNZZkdsaDlYYmRaZnIvckdnazZZVUlY?=
 =?utf-8?B?ZldCLzBzK01EL2h1bjNINmVPcDlaTnFMZUllazBhQzVTNUtweFI5M0R3cm5I?=
 =?utf-8?B?cUVqS3E4Tlc0THdzbUF6TnpMa0pqaDgxWDNCQmoyQzJiSVhPakZkd1ZTZ3FU?=
 =?utf-8?B?dktoVExRQzJTRVptYlZ6S3VLcXZSYkx3NVNFa2tlVnNialBKbFJ3WDQ4ZVQ3?=
 =?utf-8?B?d2hObGk3THczVENiUkc1QnkwdHBjSHNhUlpyVjFWMzBINmt4YnIzSG0vRkt4?=
 =?utf-8?B?cmluYmZrczBleWR5amdOekQ1bHBmQmpuZXRhaWttK2JXbHdwcGJGaG96bjNw?=
 =?utf-8?B?cXpEbXJJYXFOVDJiUTFQUFFWempobGR1TkJ0dFJNZ3NmVkppKzVQRlF4VEZl?=
 =?utf-8?B?eHorT2s1VlVUOWtpZnF1WVA3bzBLQldRUi9Fa2ZPT3c5TGVzdkUweTJZdXRN?=
 =?utf-8?B?cHdRTVFiTHByVjhxM1lZWDI4YWxoVWRPRmk3WDJaenIvekt6ME1CUWEyaW5Q?=
 =?utf-8?B?SElTenJ2N2VhUFd4dXJNS0lKZDEzdkVOMkhiSlh3VGZyU0o5YjFtd1I3dFVV?=
 =?utf-8?B?MG1VVEdxUWYzTHhqa2k3MDVHWjhpK3E2ckIzVnAzSStmQWF0ODF1RWhaTE83?=
 =?utf-8?Q?SIqfn6shFhtimk24OaEZNzl4ZVfoBihx4FrEc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5768.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXlwWWhTL2h5OGVtV0Y3U3pVSWZIVUFTL3hSUkJpNngzYThlZFdPaEVsWmhG?=
 =?utf-8?B?c2d6ajRhcGhvZUNxQnROOEU4TVlGdE4yK25OaFp3cXhYZkFaTHprRlNxQVpi?=
 =?utf-8?B?d0hoNFNEOGxDeHVGd2JnWnpPMEFaQVl1azZhNmJ0azkvemgrSFAzK0tTdWZt?=
 =?utf-8?B?Y3QybWp4TzN5ZDlzcHhIUzBSeTRQZkxzNG9lTXV3anVsYkdYR0drdU5DNitD?=
 =?utf-8?B?Z0ppWTJOTXlidXJMK1E0Z3dLcURVWnN3Vm5OWlk4QThGUVFOdnI3c05YZUpB?=
 =?utf-8?B?ZWE1TDdzajcxOHV1ME4wakFKUTEyNEZvNWp6Q1FiN0NBOWovSWx5MVFGR1RF?=
 =?utf-8?B?MDF5R0xhMGFlb05Hbkh2eG8va09kWlppbjVURzZTQ2tsQUdWOXRaemthQU1k?=
 =?utf-8?B?dVY0MldqNWwvUy9zdWVya1FPRkxpcldtekYwZThnS0ZRS3J2SWFQVHNwUWU2?=
 =?utf-8?B?Mk5yRytjNVdrS1ZyZlZhaEZYRXRUZVdTOElCampUNi9UT2ljaXN5aTQwMEYv?=
 =?utf-8?B?Q3JjMGJtaVdRU0F2am55TGpXbHlTbm9xR2Q0SWFFTGdrVm11OHpoMEpkSWlM?=
 =?utf-8?B?Q3ZBRFllN0paT0t0cndMYmcvaE11V3VFUTE5VzNvT095ZnpRR0d5RWVrM3Ev?=
 =?utf-8?B?ZC85UnNnTDlXY1o1T3dRK3UrV0p2WkdzVjA0bWhyY3BJcHRGK0dCVFcvOGZp?=
 =?utf-8?B?RjB5UkxMaUk2MGFkV05uVlhJVDNrYnQyK2t5SUZ0OEJ1NTVGREEyR3c5SzB6?=
 =?utf-8?B?bGJlbTNPbUswT0NvWmpzOG9TME9BUTI3N0pQbVJMblJUWG9ydTQ0bm1QMGxn?=
 =?utf-8?B?ZE00WWRWeE9ZZjdlYUxZbFNUTkhVYWRYRkdjSGN5U0t3Y0pvR3JQWFArT2dh?=
 =?utf-8?B?WThzLzNCMWtFakpFNHJUamtVMDMwcnN2TmIvK2QvQnF2dGFrNGpxcHFZQUc4?=
 =?utf-8?B?YXdRUFZhK0dVdnlPdDB2WlVSTU5INExmeWJNeUJrN3J4RE1zZGRLYUNyRkFL?=
 =?utf-8?B?QUlMNUI5TFNkdzdGdC9EY1plcGFOS3pyZExKanZHVGRJYWZ6T3NOT0lMR0NS?=
 =?utf-8?B?V1dMeWlzdCtpZlNxYlNvNmFMQThiK2paRTBjdmlQUFNwbi9OR0tRK21zcHJB?=
 =?utf-8?B?TEw3SllNa1Y3YjcyRzh1T3FjNENnYjBLSWlUM2hpNW9aWnZFWkVjbmFicTVp?=
 =?utf-8?B?bVdrZGNZZkRJZUw3S0JWQjJZUWdBS2tZbGFxUkM0OG9aWkk1Q0hIWUlXMFFL?=
 =?utf-8?B?TEx3eFZCVHVvQXVCZTFlQU5DaU5yTzB2NndHdWxyREVXQUlmNXMzWDhqNmJE?=
 =?utf-8?B?MmcxcjBrL0Jyd3BPekFFWDlWRnNnRjI4SjBDWklVUTArR3QzbjRqU3hlakhF?=
 =?utf-8?B?QWN4Q0N2bHZLeHpaUk5YTnhITHdveFdrMVhNMmtRcmpoSmNaZTMzczdtVFRI?=
 =?utf-8?B?R2hzYWdBZnRtUXdDMnRZMWRhbHRiQ0UxYXZta1lTV2ZiTUcxbmVqNklBUlFn?=
 =?utf-8?B?NklISXN1Q2h4SWxYbEZpWHFuRjdGTThnNDV4WXA3NHd4REJQZ3QzT2pRd2pQ?=
 =?utf-8?B?QURBMVlCT3ZVSXl6bWVvM3dDZFZJbjRLcUtvWCtvM3AvZ2pReGhLVituWU1N?=
 =?utf-8?B?Z1BtNXlPUW10bFJDZ3NWeUVaRVJvVkk3eURWRTFTd2ZzM09GTERpeDhKbnJT?=
 =?utf-8?B?SnRiUEN3eDE1VnZKODlrVlE3MmVzSUE1R1NpSzZhdy93Y3lsbmxQNkdERUtq?=
 =?utf-8?B?V0JSNWRjSE1pWEFZbnJBaG85eTVUMW11OGxlWmlORXltYnd4YTVJRjJjRll0?=
 =?utf-8?B?aTJoRUtsdGFyZ3pGbE9URm1TSngzQ3dJdkdjbHR1TjdGL29yYXppWGVVSjly?=
 =?utf-8?B?TmI3UTB6c1ZSSVh0U2ttanFwQnJnZkMrVFFPRzJGZHBtMHV2dXhyU3JZdkVt?=
 =?utf-8?B?WUw1UytiU2FYbUh3cjF0cGtITmZIdjVqZlZPSTBZM3ZTb1phdWRzT0c5ck9o?=
 =?utf-8?B?U1dtOGRnc1JSdjB4eUNpL3NURHp3Y1B4NkdwaWRSaFlmRk13bVJ1ellZMmZo?=
 =?utf-8?B?aVd1dE8yQ2kyOCt3ZmdSM3FzVlVNY01HS0JMd011L0lPU0tmN0dtVjZzRk5l?=
 =?utf-8?Q?Es5I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5768.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87feacc-60c8-4fd3-820b-08dcfd7a965a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 09:16:52.9578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emNuiRp2wjVJ1cti6sIA6uS9RyNHrWdbNyml9Tpxy7lXmoKy9Dsggx1TCRp/LNPCQ6tGGwc2o22YOJVCqMHDww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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
Cg0KSGksIENocmlzdGlhbi4NCg0KdGhlIHZhcmlhYmxlICJhZGRyX29mZnNldCIgbmVlZCB0byBp
bml0aWFsaXplIGFzIDAsDQpzaW5jZSB3aGVuIGZ1bmN0aW9uICJhbWRncHVfZGV2aWNlX3diX2dl
dCIgZmFpbGVkLA0KaWYgImFkZHJfb2Zmc2V0IiBpcyBub3QgMCwgZnVuY3Rpb24gImFtZGdwdV9k
ZXZpY2Vfd2JfZnJlZSIgd2lsbCBmcmVlIHRoZSB3Yi4NCg0KSSB3aWxsIGRvIG5vdCBpbml0aWFs
aXplIHRoZSB2YXJpYWJsZSAicmVhZF92YWxfcHRyIiBhbmQgInJlYWRfdmFsX2dwdV9hZGRyIi4N
Cg0KDQo+ICsgICAgIHVpbnQzMl90IGFkZHJfb2Zmc2V0ID0gMDsNCj4gKyAgICAgdWludDY0X3Qg
cmVhZF92YWxfZ3B1X2FkZHIgPSAwOw0KPiArICAgICB1aW50MzJfdCAqcmVhZF92YWxfcHRyID0g
TlVMTDsNCg0KPiArICAgICBpZiAoYW1kZ3B1X2RldmljZV93Yl9nZXQoYWRldiwgJmFkZHJfb2Zm
c2V0KSkgew0KPiArICAgICAgICAgICAgIERSTV9FUlJPUigiY3JpdGljYWwgYnVnISB0b28gbWFu
eSBtZXMgcmVhZGVyc1xuIik7DQo+ICsgICAgICAgICAgICAgZ290byBlcnJvcjsNCj4gKyAgICAg
fQ0KDQo+ICAgZXJyb3I6DQo+ICsgICAgIGlmIChhZGRyX29mZnNldCkNCj4gKyAgICAgICAgICAg
ICBhbWRncHVfZGV2aWNlX3diX2ZyZWUoYWRldiwgYWRkcl9vZmZzZXQpOw0KDQoNCg0KDQpUaGFu
a3MsDQpDaG9uZy4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiBUdWVzZGF5LCBOb3Zl
bWJlciA1LCAyMDI0IDQ6NTIgUE0NClRvOiBMaSwgQ2hvbmcoQWxhbikgPENob25nLkxpQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERlbmcsIEVtaWx5IDxFbWls
eS5EZW5nQGFtZC5jb20+OyBjYW8sIGxpbiA8bGluLmNhb0BhbWQuY29tPjsgQW5kamVsa292aWMs
IERlamFuIDxEZWphbi5BbmRqZWxrb3ZpY0BhbWQuY29tPjsgWWluLCBaaGVuR3VvIChDaHJpcykg
PFpoZW5HdW8uWWluQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBm
aXggcmV0dXJuIHJhbmRvbSB2YWx1ZSB3aGVuIG11bHRpcGxlIHRocmVhZHMgcmVhZCByZWdpc3Rl
cnMgdmlhIG1lcy4NCg0KQW0gMDUuMTEuMjQgdW0gMDM6NDggc2NocmllYiBDaG9uZyBMaToNCj4g
VGhlIGN1cnJlY3QgY29kZSB1c2UgdGhlIGFkZHJlc3MgImFkZXYtPm1lcy5yZWFkX3ZhbF9wdHIi
IHRvIHN0b3JlIHRoZQ0KPiB2YWx1ZSByZWFkIGZyb20gcmVnaXN0ZXIgdmlhIG1lcy4NCj4gU28g
d2hlbiBtdWx0aXBsZSB0aHJlYWRzIHJlYWQgcmVnaXN0ZXIsIG11bHRpcGxlIHRocmVhZHMgaGF2
ZSB0byBzaGFyZQ0KPiB0aGUgb25lIGFkZHJlc3MsIGFuZCBvdmVyd3JpdGUgdGhlIHZhbHVlIGVh
Y2ggb3RoZXIuDQo+DQo+IEFzc2lnbiBhbiBhZGRyZXNzIGJ5ICJhbWRncHVfZGV2aWNlX3diX2dl
dCIgdG8gc3RvcmUgcmVnaXN0ZXIgdmFsdWUuDQo+IGVhY2ggdGhyZWFkIHdpbGwgaGFzIGFuIGFk
ZHJlc3MgdG8gc3RvcmUgcmVnaXN0ZXIgdmFsdWUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENob25n
IExpIDxjaG9uZ2xpMkBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfbWVzLmMgfCAzMCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5oIHwgIDMgLS0tDQo+ICAgMiBmaWxl
cyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuYw0KPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuYw0KPiBpbmRleCA4M2QwZjczMWZiNjUu
LmQ3NGUzNTA3ZTE1NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X21lcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9t
ZXMuYw0KPiBAQCAtMTg5LDE3ICsxODksNiBAQCBpbnQgYW1kZ3B1X21lc19pbml0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgKHVpbnQ2NF90ICop
JmFkZXYtPndiLndiW2FkZXYtPm1lcy5xdWVyeV9zdGF0dXNfZmVuY2Vfb2Zmc1tpXV07DQo+ICAg
ICAgIH0NCj4NCj4gLSAgICAgciA9IGFtZGdwdV9kZXZpY2Vfd2JfZ2V0KGFkZXYsICZhZGV2LT5t
ZXMucmVhZF92YWxfb2Zmcyk7DQo+IC0gICAgIGlmIChyKSB7DQo+IC0gICAgICAgICAgICAgZGV2
X2VycihhZGV2LT5kZXYsDQo+IC0gICAgICAgICAgICAgICAgICAgICAiKCVkKSByZWFkX3ZhbF9v
ZmZzIGFsbG9jIGZhaWxlZFxuIiwgcik7DQo+IC0gICAgICAgICAgICAgZ290byBlcnJvcjsNCj4g
LSAgICAgfQ0KPiAtICAgICBhZGV2LT5tZXMucmVhZF92YWxfZ3B1X2FkZHIgPQ0KPiAtICAgICAg
ICAgICAgIGFkZXYtPndiLmdwdV9hZGRyICsgKGFkZXYtPm1lcy5yZWFkX3ZhbF9vZmZzICogNCk7
DQo+IC0gICAgIGFkZXYtPm1lcy5yZWFkX3ZhbF9wdHIgPQ0KPiAtICAgICAgICAgICAgICh1aW50
MzJfdCAqKSZhZGV2LT53Yi53YlthZGV2LT5tZXMucmVhZF92YWxfb2Zmc107DQo+IC0NCj4gICAg
ICAgciA9IGFtZGdwdV9tZXNfZG9vcmJlbGxfaW5pdChhZGV2KTsNCj4gICAgICAgaWYgKHIpDQo+
ICAgICAgICAgICAgICAgZ290byBlcnJvcjsNCj4gQEAgLTIyMCw4ICsyMDksNiBAQCBpbnQgYW1k
Z3B1X21lc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAgICAgICAgICAg
ICAgICAgICAgYW1kZ3B1X2RldmljZV93Yl9mcmVlKGFkZXYsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGFkZXYtPm1lcy5xdWVyeV9zdGF0dXNfZmVuY2Vfb2Zmc1tpXSk7
DQo+ICAgICAgIH0NCj4gLSAgICAgaWYgKGFkZXYtPm1lcy5yZWFkX3ZhbF9wdHIpDQo+IC0gICAg
ICAgICAgICAgYW1kZ3B1X2RldmljZV93Yl9mcmVlKGFkZXYsIGFkZXYtPm1lcy5yZWFkX3ZhbF9v
ZmZzKTsNCj4NCj4gICAgICAgaWRyX2Rlc3Ryb3koJmFkZXYtPm1lcy5wYXNpZF9pZHIpOw0KPiAg
ICAgICBpZHJfZGVzdHJveSgmYWRldi0+bWVzLmdhbmdfaWRfaWRyKTsNCj4gQEAgLTI0Niw4ICsy
MzMsNiBAQCB2b2lkIGFtZGdwdV9tZXNfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikN
Cj4gICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9kZXZpY2Vfd2JfZnJlZShhZGV2LA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5tZXMucXVlcnlfc3RhdHVz
X2ZlbmNlX29mZnNbaV0pOw0KPiAgICAgICB9DQo+IC0gICAgIGlmIChhZGV2LT5tZXMucmVhZF92
YWxfcHRyKQ0KPiAtICAgICAgICAgICAgIGFtZGdwdV9kZXZpY2Vfd2JfZnJlZShhZGV2LCBhZGV2
LT5tZXMucmVhZF92YWxfb2Zmcyk7DQo+DQo+ICAgICAgIGFtZGdwdV9tZXNfZG9vcmJlbGxfZnJl
ZShhZGV2KTsNCj4NCj4gQEAgLTkxOCwxMCArOTAzLDE5IEBAIHVpbnQzMl90IGFtZGdwdV9tZXNf
cnJlZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgcmVnKQ0KPiAgIHsNCj4g
ICAgICAgc3RydWN0IG1lc19taXNjX29wX2lucHV0IG9wX2lucHV0Ow0KPiAgICAgICBpbnQgciwg
dmFsID0gMDsNCj4gKyAgICAgdWludDMyX3QgYWRkcl9vZmZzZXQgPSAwOw0KPiArICAgICB1aW50
NjRfdCByZWFkX3ZhbF9ncHVfYWRkciA9IDA7DQo+ICsgICAgIHVpbnQzMl90ICpyZWFkX3ZhbF9w
dHIgPSBOVUxMOw0KDQpUaG9zZSBhcmUgdW5uZWNlc3NhcnkgaW5pdGlhbGl6YXRpb24gb2YgbG9j
YWwgdmFyaWFibGUuIFNvbWUgYXV0b21hdGVkIHRvb2xzIHdpbGwgY29tcGxhaW4gYWJvdXQgdGhh
dC4NCg0KQXBhcnQgZnJvbSB0aGF0IGxvb2tzIGdvb2QgdG8gbWUsDQpDaHJpc3RpYW4uDQoNCj4N
Cj4gKyAgICAgaWYgKGFtZGdwdV9kZXZpY2Vfd2JfZ2V0KGFkZXYsICZhZGRyX29mZnNldCkpIHsN
Cj4gKyAgICAgICAgICAgICBEUk1fRVJST1IoImNyaXRpY2FsIGJ1ZyEgdG9vIG1hbnkgbWVzIHJl
YWRlcnNcbiIpOw0KPiArICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+ICsgICAgIH0NCj4gKyAg
ICAgcmVhZF92YWxfZ3B1X2FkZHIgPSBhZGV2LT53Yi5ncHVfYWRkciArIChhZGRyX29mZnNldCAq
IDQpOw0KPiArICAgICByZWFkX3ZhbF9wdHIgPSAodWludDMyX3QgKikmYWRldi0+d2Iud2JbYWRk
cl9vZmZzZXRdOw0KPiAgICAgICBvcF9pbnB1dC5vcCA9IE1FU19NSVNDX09QX1JFQURfUkVHOw0K
PiAgICAgICBvcF9pbnB1dC5yZWFkX3JlZy5yZWdfb2Zmc2V0ID0gcmVnOw0KPiAtICAgICBvcF9p
bnB1dC5yZWFkX3JlZy5idWZmZXJfYWRkciA9IGFkZXYtPm1lcy5yZWFkX3ZhbF9ncHVfYWRkcjsN
Cj4gKyAgICAgb3BfaW5wdXQucmVhZF9yZWcuYnVmZmVyX2FkZHIgPSByZWFkX3ZhbF9ncHVfYWRk
cjsNCj4NCj4gICAgICAgaWYgKCFhZGV2LT5tZXMuZnVuY3MtPm1pc2Nfb3ApIHsNCj4gICAgICAg
ICAgICAgICBEUk1fRVJST1IoIm1lcyBycmVnIGlzIG5vdCBzdXBwb3J0ZWQhXG4iKTsgQEAgLTkz
Miw5ICs5MjYsMTEgQEANCj4gdWludDMyX3QgYW1kZ3B1X21lc19ycmVnKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCB1aW50MzJfdCByZWcpDQo+ICAgICAgIGlmIChyKQ0KPiAgICAgICAgICAg
ICAgIERSTV9FUlJPUigiZmFpbGVkIHRvIHJlYWQgcmVnICgweCV4KVxuIiwgcmVnKTsNCj4gICAg
ICAgZWxzZQ0KPiAtICAgICAgICAgICAgIHZhbCA9ICooYWRldi0+bWVzLnJlYWRfdmFsX3B0cik7
DQo+ICsgICAgICAgICAgICAgdmFsID0gKihyZWFkX3ZhbF9wdHIpOw0KPg0KPiAgIGVycm9yOg0K
PiArICAgICBpZiAoYWRkcl9vZmZzZXQpDQo+ICsgICAgICAgICAgICAgYW1kZ3B1X2RldmljZV93
Yl9mcmVlKGFkZXYsIGFkZHJfb2Zmc2V0KTsNCj4gICAgICAgcmV0dXJuIHZhbDsNCj4gICB9DQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmgN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmgNCj4gaW5kZXggNDVl
MzUwOGYwZjhlLi44M2Y0NWJiNDg0MjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9tZXMuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfbWVzLmgNCj4gQEAgLTExOSw5ICsxMTksNiBAQCBzdHJ1Y3QgYW1kZ3B1X21lcyB7
DQo+ICAgICAgIHVpbnQzMl90ICAgICAgICAgICAgICAgICAgICAgICAgcXVlcnlfc3RhdHVzX2Zl
bmNlX29mZnNbQU1ER1BVX01BWF9NRVNfUElQRVNdOw0KPiAgICAgICB1aW50NjRfdCAgICAgICAg
ICAgICAgICAgICAgICAgIHF1ZXJ5X3N0YXR1c19mZW5jZV9ncHVfYWRkcltBTURHUFVfTUFYX01F
U19QSVBFU107DQo+ICAgICAgIHVpbnQ2NF90ICAgICAgICAgICAgICAgICAgICAgICAgKnF1ZXJ5
X3N0YXR1c19mZW5jZV9wdHJbQU1ER1BVX01BWF9NRVNfUElQRVNdOw0KPiAtICAgICB1aW50MzJf
dCAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRfdmFsX29mZnM7DQo+IC0gICAgIHVpbnQ2NF90
ICAgICAgICAgICAgICAgICAgICAgICAgcmVhZF92YWxfZ3B1X2FkZHI7DQo+IC0gICAgIHVpbnQz
Ml90ICAgICAgICAgICAgICAgICAgICAgICAgKnJlYWRfdmFsX3B0cjsNCj4NCj4gICAgICAgdWlu
dDMyX3QgICAgICAgICAgICAgICAgICAgICAgICBzYXZlZF9mbGFnczsNCj4NCg0K
