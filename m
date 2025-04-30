Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C40C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 05:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8539710E6D1;
	Wed, 30 Apr 2025 05:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cAX+Odwd";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D800D10E6D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 05:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtpEjb9AylNfQtKwlg2qkz5xqeOZgFo73YjSoafEryCpWJn+0sTs3qhxp1WVXY3vnDw5JVWkk+BHDCwQdC7qve6Yvqh72NfCUIf7NbQlYgwXW+oKQg+dOJGycawYKFixgngG4kB0oTF3k8r048U4Oc4P6+5+Y+CH2k7WXDEIPmQTsquoXZ1lPteP3CdOWp5ohKoBX8glphTIkmH5tN594w7f5j6/gbMlPEI3lKjB6gSc7Jr2ZVwFLdUb4dTcLVsznI2Xl9Xs2GaXjSX2KeERR1hV1/ztQPQIAjC6UOFNgtqX7eBDGdCwspLr5vevv1I3YXpZyjZz/CgZPXJy/ACiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkMgbNOYHDIF18xAWy1ZN1GIw+FH2fO5jHfYXoZnlrk=;
 b=r3AWelyIYZH8mTC6PrM00ajgfJlRA6vzAQknQN9rtbAzm+mQ/XnRptjmpJMro7nMYwU1GFgbzUyLqCnO/6r0Pf3fUo5+4KX2auAnbNYbPHNbbmdgFU1jwTMNPKjT4yx60rfr5mpj9h++3EOXagOXZ6FzAsL6CyjruFRiFctA07+2fVHMOWBOqlhRVAGlgMrSvRgrVnkEp03FMmGN31ILT0E2mDbTi4fVyPxlSnMjxTkgrKD+j4xYUEFSAk/Rt17oe74vJRo7wcqaMIAjY039is0KD1dyaCR9+ASqavYWQf9iRWzM5UD21K6hbMuWCRbfsQ5r4b2fj1syhXfrA5mtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkMgbNOYHDIF18xAWy1ZN1GIw+FH2fO5jHfYXoZnlrk=;
 b=cAX+OdwdBI0tdb8C5XFqFCGS8Vd3TZZTpnX7C/09C4+6gpKHUVfn110Lmbq1Hnj3BmYRpw4kzh4uWN4bSSS+VisgN/KPMMNKNqc6eg7Ehb3JP2UY/lPAMxPLMykEouK4x3dDbWjQrp+0uh2ZW5LHZw/Aw2/398wB2fzcZh8cy+U=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 05:19:35 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 05:19:35 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH 2/2] amd/amdkfd: Trigger segfault for early userptr
 unmmapping
Thread-Topic: [PATCH 2/2] amd/amdkfd: Trigger segfault for early userptr
 unmmapping
Thread-Index: AQHbtZMcy7wt5j1hfEuN6a2cHqXuELO7WgEAgABZLaA=
Date: Wed, 30 Apr 2025 05:19:34 +0000
Message-ID: <DM4PR12MB5261DA38074DEB8A23EB3F4A9D832@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20250425033513.1535517-1-shane.xiao@amd.com>
 <20250425033513.1535517-2-shane.xiao@amd.com>
 <d5429483-4597-4065-a605-7ca569dafc94@amd.com>
In-Reply-To: <d5429483-4597-4065-a605-7ca569dafc94@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=cde203bb-4e75-4ac7-90a5-6fbfb8b592a0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-30T05:19:11Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|LV2PR12MB6016:EE_
x-ms-office365-filtering-correlation-id: d48f0a75-a2dd-4c53-c396-08dd87a6988e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aVYxQjJnS1djR3VvdXJRek1zTXFVeTd6bHZvdWFXSHhQdFZsdmtsZmkyODk1?=
 =?utf-8?B?MWZWUlNUaTNjWnpURjFZUTVxMjVRTHdPMkIyUk14bkUwcVJEWXBBWkVuQnpX?=
 =?utf-8?B?NFU0b1pxWis1cUllVUF1dlcrbmNvRUkxK3NvbWYycEtjeEJIQ0d0S0RVUHRP?=
 =?utf-8?B?ZXA4TktJOTNIaFYreFZ0VTJiSTJlYW5vSmZJaHNpZGI3aWxDWm52SEtYZ081?=
 =?utf-8?B?ak5GdmI5VHBrNmMwdFFONm5MYTRyOHZpQUUxSkVjcERPMk5JeWhIdVFyV29P?=
 =?utf-8?B?MUZ6Yko0QTNZTE9ZanJIemN4VWU3MEd3K0JkOG9hUjZjRzg1Q3VZTFJPOCtz?=
 =?utf-8?B?bFlTYmI5Y3dXNXF3NFRPdElObzhXdW5UUFVqUGVjZE5nSEo2U3lpNi9QT2RT?=
 =?utf-8?B?QVVhWHIwakFDMzJLSXlLMEFDOTVhdnJ4OTZpV3hTU3hrUEZaQmd4MEcvVkdB?=
 =?utf-8?B?bVNseHg1NUUrZDdmai9MNnhLN0x5eTBDZjFCcDJWYVVya1JGK01PalBuK29K?=
 =?utf-8?B?S2NkT0JTYWFqdXMvcVRzVnFCOUlwcDhBaTA1TDRjNG90SUJybWlMaFdzbVZo?=
 =?utf-8?B?d3ZkV2JxNCtvbGcwWW1UamVzMXhTMTl4T3Q2dndSU0F6OE9rWkZsSVRCY1c0?=
 =?utf-8?B?SVBsb29tQ1R3Z1lyQ0ZnN2FxY2NFRVNBR1dLMkhlZkVkZk1PUnBZOTUzMDFv?=
 =?utf-8?B?dnlWZ0w0eDJrbDlGYkdOMkwvSk1UdXRHWitGWmdmNnNUVEw4aGRnV2NjWGp6?=
 =?utf-8?B?ZkhPb014RHJ1SS9HTUFzVXJvRkdoMFlpMWc2TmozMkp6L2VnbEY0bEdXV0Fy?=
 =?utf-8?B?eis0YThRY0NYWjBlU0JTeDlDVUNFOEVhVGJFekIyZjZLNkNvN05SZ3EzY1ZX?=
 =?utf-8?B?cjR6UmVDUnlONVUyYVUyUmNMY3Y2NmpJRlowZEp1VjN2TzRlVnoyM1dkeXlL?=
 =?utf-8?B?cytwY2VlUkFBd1ZScnhRZ3BsMUZXZWltVTFoM0duaXprelMwZmZCN1IrQ1Y0?=
 =?utf-8?B?K1N2MUdPVVZQY2RvbEgxWlJ4M01FUytoaXVjZlIzZkRlVUNhc3gvSzlucWVI?=
 =?utf-8?B?ak8rcnYwRXZiUEozMzlYUnByYWNsSTRKK3ZYbDhPd21QQVBXTUFJN2tHejVl?=
 =?utf-8?B?WFVyN2xCM01FaVg5OWsvWHY4RlllYzhPRjNtVjJSTFA4bEdmb3JBSDhjK1lW?=
 =?utf-8?B?WnZsWCtmcjFZQ0kzcWNOWmZ1SW1YbUN1aVNBbjJja0ZIM1BoOTNYSUxMQnN6?=
 =?utf-8?B?UWVhdzFTeUhjckdQTmFyWWMyNTJ1a3dqeFVPa1hUN3ZMR1luSys2NVh6Y2ta?=
 =?utf-8?B?U3NYNm1MMzBvRC9QSzNwb3J5b1hQbEg0TW1rNnNBZlo0dDl2ZW1Lc0FVRTY1?=
 =?utf-8?B?bHR4UjNaMDkzdGkyL1BMaVFJNzRaVVhGY0JXSWNIM1pTTjA5QXZlSGxDZzA1?=
 =?utf-8?B?VDJwRnh2ZmNwQzdlZytaWkd1N2NUOTBYSHdURkxsdlJHS3p2M3RYbXdnUUVq?=
 =?utf-8?B?dmFCV1pnTm0xMkFXcmE5bW5vWmhCSXpoNHcraFlhVzFqdmdzdCtJTDNFNm5i?=
 =?utf-8?B?UHBGY3p0Sk1SYXJVUncwY2ZLL3BrSkRGWGNPMmlIbDcybXhRQWxOcnhTa3Zt?=
 =?utf-8?B?blFLOHdkNmpjdDVnby9iOTFoUEZPZVdHU1RJaGIxdTlvZjAzOFFTZ1d0OENT?=
 =?utf-8?B?SEZ1WWpkTW9MY0JoSzRpazQyMlFQUmVKQXlmWktiSzBmVk12Y09rV0FKdXVh?=
 =?utf-8?B?WlR4WXB1NGRtYjMra2RFcmpaM1JyVGpSSWNiRnR3WWtRT3hPbGZzT2FpSjQw?=
 =?utf-8?B?Q21ud2Y1UmxrSUJvMU9WRVg1bWFHcVdGOVhEVU84dEF1N1JLbW5ud3JiNFdL?=
 =?utf-8?B?SmpVQ0pWV0puSENOazdzVFhJblI1SnNLdVEyUUU5aXJmakgvaE1zMXZIc0s4?=
 =?utf-8?B?ZUxaOTBGZi9CWUZhMGtIOG1nck5PVjR5K2d0YU4vWmZnN0tpSUNVUEw3U2hC?=
 =?utf-8?Q?Wg5Db5bhoPEQhDZqd+4GZpAJU1xJQA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVAyUkpWbEV0Q0loYWNLNk9qSUdjd0hma2E5RzF1QXNGd25TcUVxNXdkYlpt?=
 =?utf-8?B?QTlJOUEwYWdDOS96Q1puU3gzTFgya1d2K0haYWdjS0hrY0xlQ2RQZ1lPeDdG?=
 =?utf-8?B?SzZNckpEaE84VXd6UEZiQ1ZyLzFMWFZVTTNtdkREaGxVNjRXdDhkV3RuZUUx?=
 =?utf-8?B?cUdrTEV6RG5IQTl1MEd3alo1dnRBQ3ViR0FCdnZTRTYyQXViOUZNVjNGSnl5?=
 =?utf-8?B?U2dhbXY4ZnJJaVZYSXUwNXJSazJLT1dRNmxxZVdIMFBwcE1wWFpBU2ZDWElU?=
 =?utf-8?B?cWRTL0p0MzA5TEFHTmY2b2c5ZWJTTEdNcHI3RGt6MzBLbWowZm1PbXVZSURH?=
 =?utf-8?B?Y1MxdlhJcUFHb0hyL2V4TjRaQytObkZmL3hRQklpMWhMZk40cnFDZUJOSTNS?=
 =?utf-8?B?anp3ZWhjZXdaSmFGU2gwNmtGdjZybzBRajd0V0p4c0g5VU4ycXdzMVVJL3Bw?=
 =?utf-8?B?ZzJlcTkwek9peW9YY2h3TCtxa0ZndnhmK2JMbm1GWEM3NXZhcWt4RmU0TlhR?=
 =?utf-8?B?YUM5OUxtYWhIODh1aXhKMG5NQU9CMHFCb2hKZkJZb1Z2NmgyTGRQSGRBcWg0?=
 =?utf-8?B?S1hqa2RHWFErU05JalY4QXRxcFJUSFZVZUlrdXhucWM0dVBjeEdRYTRQSldL?=
 =?utf-8?B?Tmk5UTgrY0RtaCs0bDgrNDFDYlZTL1JGaEdCWU0xd0lCQ0xuOFNscTl2aHF2?=
 =?utf-8?B?RkxNVlZMNzd6MnkybTJTMWU0cGRteEZjT2NXcXZEMjkyeFJwZTVXWUJ3eFgr?=
 =?utf-8?B?YjRMaHV1S215MlRjeGRBVUE4b0IrdUsyYkdOZkxWcTBFUURJQ0lSQ1NHV1Fq?=
 =?utf-8?B?dUp2T0hrdnorb0VKK0dpWURLbFYwdmJtR2REL2szNjlXYnh6dU5TNkk2Lzg0?=
 =?utf-8?B?U0VQVmpiL0dPSTF6WVRna01GM0ZSdmFWVVdNKzhPaTJhUXlEdVdaMjFnUUdK?=
 =?utf-8?B?dlhSSlV6T1hHR1M0dVBBbFdCQWNvMEMybDhRZ2ZWRUlPQmpnNFM4VTZZU3oy?=
 =?utf-8?B?aldkNUpzcTBCUE16VkRwNmhQRUxqWFVqSFVHbTl1L25vOFlFZ3hUN2UyUEhI?=
 =?utf-8?B?MmNiSWprWjdkREtHMHJNNnlKeFMwZForQXdYY25SK2JpTzBVZ0V0WXZDdlRs?=
 =?utf-8?B?MU5QMVJ5Q2JaZEtKMGJJMjlKZnQxb2QzSjFoT24rdjNyTHgxZk5semRyQzlq?=
 =?utf-8?B?NzVTNWk2MkNjTjJzbzNUUkhqZnFGN1pUYjY3Ym1sMTFKbUlOZEExZ3djcUNz?=
 =?utf-8?B?dGVJazJHekJKNWlOdW5ndDFuYWtZcFRtbTVidDVia0xnVVAzTk00OThQS2JQ?=
 =?utf-8?B?ZzNUWjhta3pYQ1lsK3Y5TmFVQnRqWitOU0FXVGZBZVBwNEpHT1ZjcDVPT2wz?=
 =?utf-8?B?RzVlUTB1UFhreE11UkhXRFRBeXA3bVFIRDFSUDkzSGV6eWJYMFE5YThXQk96?=
 =?utf-8?B?eW5NRmdPVmRBSXRScjhvQ3hUNHdYRjBEd1pFbmJJYlFSS1JrVmcxV0p5cEQy?=
 =?utf-8?B?ZzljSDdBb2hZa1RRQUVoa09Ld3RvNWlKMjhyRmk3UU1tUlIyQlFtOXNaU3d4?=
 =?utf-8?B?ZmlxWlpYOW8vRGFwYStwNE1BRHp4V1QxRFowUWN3dllkNHN6ZkpOWEdNcnZt?=
 =?utf-8?B?Z2xCc2kwN0t3NEhRL3U3bkhkS04rOVE0eFd2a0M2eElnVkVEQWg4OWpMemRm?=
 =?utf-8?B?VjU1emcwZVFQS2JrdG0yK0VrWWpyMTF3Q3J2QWdyMlMwYVNvR2M4TnAzR3Fy?=
 =?utf-8?B?N3JlNTIvRU5rbFA0NHQ3dE1Xem5QMlJLcjV6L0JITHVKb0pRVVQrZEFvOFNm?=
 =?utf-8?B?UzdDaUFGemFMd2Q1WTBqcEdXNXdCbHZuWWo5OEhCb3h4OUd5Yy92WE1idDhP?=
 =?utf-8?B?aE5lUEpIVUt5ZVY0eHJVd25sY21mUDJ2akxUMUtWZmdILzlBSXRla0x1dlQ2?=
 =?utf-8?B?eGVNeGVGUzZ5Y0ZFVDlWald2NEdDY0hFbzB4UThodkNaeFFBR2grU0g5Qmty?=
 =?utf-8?B?ajAyZ0h6dWY3MFpVNTV6OC9HZXh2R21lSWprM0VLNU1Jc0t3NTB2MWJ4ck53?=
 =?utf-8?B?SnV1eFYzWWVZeDBJUjJIYzAwUHlkYksxOG00WW5YazMvSVB6Q0xEdlJhOHBR?=
 =?utf-8?Q?Op4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48f0a75-a2dd-4c53-c396-08dd87a6988e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 05:19:34.9868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYvNoylRRymmdsCrUaU2FNKnm0Eq1Lkg9XI03E9Km08CImnyrxTcHnO/25asmVKwba2Z5tEk2kRXYT4qLxezBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGlu
ZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXBy
aWwgMzAsIDIwMjUgNzo1OCBBTQ0KPiBUbzogWGlhbywgU2hhbmUgPHNoYW5lLnhpYW9AYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWWFuZywgUGhpbGlwDQo+IDxQaGlsaXAuWWFuZ0Bh
bWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gYW1kL2FtZGtmZDogVHJpZ2dlciBz
ZWdmYXVsdCBmb3IgZWFybHkgdXNlcnB0cg0KPiB1bm1tYXBwaW5nDQo+DQo+DQo+IE9uIDIwMjUt
MDQtMjQgMjM6MzUsIFNoYW5lIFhpYW8gd3JvdGU6DQo+ID4gSWYgYXBwbGljYXRpb25zIHVubWFw
IHRoZSBtZW1vcnkgYmVmb3JlIGRlc3Ryb3lpbmcgdGhlIHVzZXJwdHIsIGl0DQo+ID4gbmVlZHMg
dHJpZ2dlciBhIHNlZ2ZhdWx0IHRvIG5vdGlmeSB1c2VyIHNwYWNlIHRvIGNvcnJlY3QgdGhlIGZy
ZWUNCj4gPiBzZXF1ZW5jZSBpbiBWTSBkZWJ1ZyBtb2RlLg0KPiA+DQo+ID4gdjI6IFNlbmQgR1BV
IGFjY2VzcyBmYXVsdCB0byB1c2VyIHNwYWNlDQo+ID4gdjM6IFJlcG9ydCBncHUgYWRkcmVzcyB0
byB1c2VyIHNwYWNlLCByZW1vdmUgdW5uZWNlc3NhcnkgcGFyYW1zDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTaGFuZSBYaWFvIDxzaGFuZS54aWFvQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIC4u
Li9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jICB8IDE1DQo+ICsrKysr
KysrKysrKysrKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMg
ICAgICAgfCAxOSArKysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9wcml2LmggICAgICAgICB8ICAyICsrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwg
MzYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gaW5kZXggZDJlYzQxMzBhMzE2Li42
MWE2OTgwNTZmYjggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gQEAgLTI0OTYsNiArMjQ5Niw3IEBAIHN0YXRp
YyBpbnQgdXBkYXRlX2ludmFsaWRfdXNlcl9wYWdlcyhzdHJ1Y3QNCj4gYW1ka2ZkX3Byb2Nlc3Nf
aW5mbyAqcHJvY2Vzc19pbmZvLA0KPiA+ICAgICBzdHJ1Y3QgdHRtX29wZXJhdGlvbl9jdHggY3R4
ID0geyBmYWxzZSwgZmFsc2UgfTsNCj4gPiAgICAgdWludDMyX3QgaW52YWxpZDsNCj4gPiAgICAg
aW50IHJldCA9IDA7DQo+ID4gKyAgIHVpbnQ2NF90IHVzZXJwdHIgPSAwOw0KPiA+DQo+ID4gICAg
IG11dGV4X2xvY2soJnByb2Nlc3NfaW5mby0+bm90aWZpZXJfbG9jayk7DQo+ID4NCj4gPiBAQCAt
MjU1OSw2ICsyNTYwLDIwIEBAIHN0YXRpYyBpbnQgdXBkYXRlX2ludmFsaWRfdXNlcl9wYWdlcyhz
dHJ1Y3QNCj4gYW1ka2ZkX3Byb2Nlc3NfaW5mbyAqcHJvY2Vzc19pbmZvLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgaWYgKHJldCAhPSAtRUZBVUxUKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiA+DQo+ID4gKyAgICAgICAgICAgICAgICAgICAvKiBJZiBh
cHBsaWNhdGlvbnMgdW5tYXAgbWVtb3J5IGJlZm9yZSBkZXN0cm95aW5nIHRoZQ0KPiB1c2VycHRy
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgKiBmcm9tIHRoZSBLRkQsIHRyaWdnZXIgYSBzZWdt
ZW50YXRpb24gZmF1bHQgaW4gVk0NCj4gZGVidWcgbW9kZS4NCj4gPiArICAgICAgICAgICAgICAg
ICAgICAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgaWYgKGFtZGdwdV90dG1fYWRldihiby0+
dGJvLmJkZXYpLQ0KPiA+ZGVidWdfdm1fdXNlcnB0cikgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICBhbWRncHVfdHRtX3R0X2dldF91c2VycHRyKCZiby0+dGJvLA0KPiAmdXNlcnB0
cik7DQo+DQo+IFVzZXJwdHIgaXMgb25seSB1c2VkIGZvciBwcmludGluZyB0aGUgbWVzc2FnZS4g
VGhhdCdzIHByb2JhYmx5IHVubmVjZXNzYXJ5LiBZb3UNCj4gc2hvdWxkIGdldCB0aGF0IGFkZHJl
c3MgZnJvbSB1c2VyIG1vZGUgYXMgd2VsbCB3aGVuIGl0IGhhbmRsZXMgdGhlIGZhdWx0IGV2ZW50
DQo+IGFuZCBlcnJvciBvciB3YXJuaW5nIG1lc3NhZ2VzIGFyZSBlbmFibGVkIChIU0FLTVRfREVC
VUdfTEVWRUw9NCkuIFRoZQ0KPiBrZXJuZWwgbG9nIGRvZXNuJ3QgbmVlZCB0byBiZSBvdmVybHkg
dmVyYm9zZS4gSU1PIGl0IHNob3VsZCBmaXQgb24gb25lIGxpbmUuIEl0DQo+IG1heSBiZSB1c2Vm
dWwgdG8gaW5jbHVkZSB0aGUgUElEIG9mIHRoZSBvZmZlbmRpbmcgcHJvY2Vzcy4gRS5nLg0KPg0K
PiAgICAgICBwcl9lcnIoIlBpZCAlZCB1bm1hcHBlZCBtZW1vcnkgYmVmb3JlIGRlc3Ryb3lpbmcg
dXNlcnB0ciBhdCBHUFUNCj4gYWRkciAlbGx4IiwNCj4gICAgICAgICAgICAgIHBpZF9ucihwcm9j
ZXNzX2luZm8tPnBpZCksIG1lbS0+dmEpOw0KPg0KPiBJZiB5b3UgcmVtb3ZlIHRoZSB1c2VwdHIg
dmFyaWFibGUsIHRoZSBhbWRncHVfdHRtX3R0X2dldF91c2VycHRyIGNhbGwgYW5kDQo+IHNob3J0
ZW4gcHJfZXJyIG1lc3NhZ2VzIHRvIG9uZSBsaW5lLCB0aGUgc2VyaWVzIGlzDQoNClRoYW5rcy4g
SSB3aWxsIGNvcnJlY3QgaXQgYWNjb3JkaW5nbHkuDQoNCkJlc3QgUmVnYXJkcywNClNoYW5lDQoN
Cj4NCj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29t
Pg0KPg0KPg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIoIlVzZXIgc3Bh
Y2UgdW5tYXAgbWVtb3J5IGJlZm9yZQ0KPiBkZXN0cm95aW5nIGEgdXNlcnB0ciB0aGF0IHJlZmVy
cyB0byBpdFxuIik7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiVGhl
IHVubWFwIHVzZXJwdHIgY3B1IGFkZHJlc3MgaXMNCj4gMHglbGx4LCBncHUgYWRkcmVzcyBpcyAw
eCVsbHhcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdXNlcnB0ciwgbWVtLQ0KPiA+dmEpOw0KPiA+ICsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLy8gU2VuZCBHUFUgVk0gZmF1bHQgdG8gdXNlciBzcGFj
ZQ0KPiA+ICsNCj4gICAgICAga2ZkX3NpZ25hbF92bV9mYXVsdF9ldmVudF93aXRoX3VzZXJwdHIo
a2ZkX2xvb2t1cF9wcm9jZXNzX2J5X3BpZChwcg0KPiBvY2Vzc19pbmZvLT5waWQpLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG1lbS0+dmEpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAg
ICAgICAgICAgICAgIHJldCA9IDA7DQo+ID4gICAgICAgICAgICAgfQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYw0KPiA+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jDQo+ID4gaW5kZXggZmVjZGI2Nzk0
MDc1Li5lNTRlNzA4ZWQ4MmQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2V2ZW50cy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2V2ZW50cy5jDQo+ID4gQEAgLTExNzcsNiArMTE3NywyNSBAQCB2b2lkIGtmZF9zaWduYWxf
aHdfZXhjZXB0aW9uX2V2ZW50KHUzMiBwYXNpZCkNCj4gPiAgICAga2ZkX3VucmVmX3Byb2Nlc3Mo
cCk7DQo+ID4gIH0NCj4gPg0KPiA+ICt2b2lkIGtmZF9zaWduYWxfdm1fZmF1bHRfZXZlbnRfd2l0
aF91c2VycHRyKHN0cnVjdCBrZmRfcHJvY2VzcyAqcCwNCj4gPiArdWludDY0X3QgZ3B1X3ZhKSB7
DQo+ID4gKyAgIHN0cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2UgKnBkZDsNCj4gPiArICAgc3RydWN0
IGtmZF9oc2FfbWVtb3J5X2V4Y2VwdGlvbl9kYXRhIGV4Y2VwdGlvbl9kYXRhOw0KPiA+ICsgICBp
bnQgaTsNCj4gPiArDQo+ID4gKyAgIG1lbXNldCgmZXhjZXB0aW9uX2RhdGEsIDAsIHNpemVvZihl
eGNlcHRpb25fZGF0YSkpOw0KPiA+ICsgICBleGNlcHRpb25fZGF0YS52YSA9IGdwdV92YTsNCj4g
PiArICAgZXhjZXB0aW9uX2RhdGEuZmFpbHVyZS5Ob3RQcmVzZW50ID0gMTsNCj4gPiArDQo+ID4g
KyAgIC8vIFNlbmQgVk0gc2VnIGZhdWx0IHRvIGFsbCBrZmQgcHJvY2VzcyBkZXZpY2UNCj4gPiAr
ICAgZm9yIChpID0gMDsgaSA8IHAtPm5fcGRkczsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAgcGRk
ID0gcC0+cGRkc1tpXTsNCj4gPiArICAgICAgICAgICBleGNlcHRpb25fZGF0YS5ncHVfaWQgPSBw
ZGQtPnVzZXJfZ3B1X2lkOw0KPiA+ICsgICAgICAgICAgIGtmZF9ldmljdF9wcm9jZXNzX2Rldmlj
ZShwZGQpOw0KPiA+ICsgICAgICAgICAgIGtmZF9zaWduYWxfdm1fZmF1bHRfZXZlbnQocGRkLCBO
VUxMLCAmZXhjZXB0aW9uX2RhdGEpOw0KPiA+ICsgICB9DQo+ID4gK30NCj4gPiArDQo+ID4gIHZv
aWQga2ZkX3NpZ25hbF92bV9mYXVsdF9ldmVudChzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpw
ZGQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBrZmRfdm1fZmF1bHRf
aW5mbyAqaW5mbywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGtmZF9o
c2FfbWVtb3J5X2V4Y2VwdGlvbl9kYXRhICpkYXRhKQ0KPiBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+ID4gaW5kZXggZjZhZWRmNjljNjQ0Li44NzAzYmU4MDc3
YjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYu
aA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgNCj4gPiBA
QCAtMTUwNyw2ICsxNTA3LDggQEAgaW50IGtmZF9ldmVudF9jcmVhdGUoc3RydWN0IGZpbGUgKmRl
dmtmZCwgc3RydWN0DQo+ID4ga2ZkX3Byb2Nlc3MgKnAsICBpbnQga2ZkX2dldF9udW1fZXZlbnRz
KHN0cnVjdCBrZmRfcHJvY2VzcyAqcCk7ICBpbnQNCj4gPiBrZmRfZXZlbnRfZGVzdHJveShzdHJ1
Y3Qga2ZkX3Byb2Nlc3MgKnAsIHVpbnQzMl90IGV2ZW50X2lkKTsNCj4gPg0KPiA+ICt2b2lkIGtm
ZF9zaWduYWxfdm1fZmF1bHRfZXZlbnRfd2l0aF91c2VycHRyKHN0cnVjdCBrZmRfcHJvY2VzcyAq
cCwNCj4gPiArdWludDY0X3QgZ3B1X3ZhKTsNCj4gPiArDQo+ID4gIHZvaWQga2ZkX3NpZ25hbF92
bV9mYXVsdF9ldmVudChzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBrZmRfdm1fZmF1bHRfaW5mbyAqaW5mbywNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGtmZF9oc2FfbWVtb3J5X2V4Y2Vw
dGlvbl9kYXRhDQo+ICpkYXRhKTsNCg==
