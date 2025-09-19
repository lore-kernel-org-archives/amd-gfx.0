Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAA1CAC597
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 01:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2763E10E050;
	Fri, 19 Sep 2025 01:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5oMr2SSX";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37EB10E050
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 01:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfzO8ROhy+wOeX5vn6Yd8+SyOiVwjA4BHWamd/joiRF9VhvNux8ghj4EHK5TgxXPSGdnAc9HbQI5QD1JQoM4//hch6qFdvJB/lhSy8K/h0ZPhEZZPkqU3YFGBdL+ZucPytTV+hgj+Q+Y7R44gjFbi02WUqHhyxkfNM14b8A/rRern5nJRHsNrTmN8LCq43oCViUtPsO1n714X0xhIzAYrKTqbLWw2FWvDs9LOGPfgp+wQ52Y4iH+kyUKcdSq2VhS4HXTYYR8uvBGml+usHym01JOXdt9BTB76tFzyqyxA6Lizc7Vh+priYFr9WjOfrvPTc/uNa6+aGRP+iwPe7IRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHhsiCmJRgcJcQ63ik4nMQ+cwj1x82m/JKY6g1Ni+S4=;
 b=NYKUHOE4wKQ8l4j5BFFrTDhI3y4oqh1LVIGtYd6okBz9SbIuUor1JAupHR3kzBvSbwTpJsPvKYmGKYgA4EE4RQRTH1djjD2zJDU+aIbmZchSKExAW1ziS6MfHTilzYwJL2b+rVwwBOxtiiaTDJRbPNhRgdDJJRfOeotJ69bSuy5oni8mewuvGxMj1tdG9ge92yhX+AlWw+MkqvTCCM0AcVKyNeSS97SdKPDf+qqYYzAbdGuSLnTJ67nK4eUzgpfYDtqW2T9UIp6vwEBFheL6BGDLDygorRBgfbTwXhbJ7UdlW/nSKsYiZHDbaoKmLDkLZBWDa/sA8I1h5IDSuahAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHhsiCmJRgcJcQ63ik4nMQ+cwj1x82m/JKY6g1Ni+S4=;
 b=5oMr2SSXrZhh77T/R+8yR76GjUlNHEbuFuV7resM5vR2c325c7uYwqXJc2AJyA2TlSCdcgrN3BbXdKF90+qB1a0fWxIplAiMr7A5kUg4ln2wPgsDqvqQiNNmW9/Y2X3jAaJUu3ApuRb0dJZ+8mbNrM6SJrKE0preuH+qmj9pOMM=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 01:22:59 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 01:22:59 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Enable MES lr_compute_wa by default
Thread-Topic: [PATCH v2] drm/amdgpu: Enable MES lr_compute_wa by default
Thread-Index: AQHcKMwDqJtg5RApPUG99h+6WS8P17SZTMoAgAAqBICAAD6L4A==
Date: Fri, 19 Sep 2025 01:22:59 +0000
Message-ID: <CY5PR12MB636950A38A8E84351D18A7A9C111A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20250918184150.394532-1-mario.limonciello@amd.com>
 <CADnq5_M13ADiuoKKdgEyi=1MVbLJ9qCJKTHUPd+F+aLXUzwtDQ@mail.gmail.com>
 <c6ed9443-1465-489e-8c8d-d3c06604d97a@amd.com>
In-Reply-To: <c6ed9443-1465-489e-8c8d-d3c06604d97a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-19T01:22:51.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DM6PR12MB4044:EE_
x-ms-office365-filtering-correlation-id: a8ddeb29-a880-42e1-254a-08ddf71b121d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NVZjU1JRV2wrTDNrdnZFZ3ZqNnYrOHpEQWM5bnM1WHpmQW4rMVFzS0JNOXRu?=
 =?utf-8?B?NTZmSmdYbFZCVUhHOVVPOHY2QmVDQVBXYmFQNHpTb3N4bVd6OU1VN1Q0b2Qy?=
 =?utf-8?B?K0VkU3MwUW8zK3BJV2VpTHdOZFJ2N2JnOUdhNXMzci9tdjRJd05nTVY3ZHNw?=
 =?utf-8?B?SnhFeGwvWFBVN3A2V09sQ2JTQXFTQnVXYlZTbTlkdGQ4Wno5TGFpRVFBZTZD?=
 =?utf-8?B?Mzg4V28rUURPTkRLLzhxQ0FRQ3k5M0JvOURoc2lmNExNZFRQQ2g1QWhPWmdW?=
 =?utf-8?B?R3V6NW9JWXlDOTZCa2RoMnZtWGw5TkkwcFpReDU3TDhldE9NSzNjSDNnYmdJ?=
 =?utf-8?B?dk4wWktqY1U2RmxzNGdYeS9iVXFocEdST3UxRmx5UGJSSFJaMnVnRGFjUlZ3?=
 =?utf-8?B?NXVVUDBhSUd0a0g2Y2V5UGJrb214bHp0RFBpMERMUGpyNjE0eHFQMm1VclpY?=
 =?utf-8?B?aFFESXVZTXZoa2tZeWV3SkNiNG9DMmtveThHbW9LTVJEVnozRXVCRlRwSVVp?=
 =?utf-8?B?WnRBakRhaHp2U3VjYlRucTAvSmxqUG80OTFubXRXOC83ZnlUYUc4NGxuNWdx?=
 =?utf-8?B?c0k4MThoRjZpZGsydlM3dHF4d0xrZ2orS0w0UW1LL0RyQmZYaHBNSE02T3Q2?=
 =?utf-8?B?Tmxla0loS0ZlbjNHWUM2NmVhWTd5M0IreVF4SFUvdkJGNXhad09XRnR1UnZ6?=
 =?utf-8?B?RHhtQkVab2hRR0xibFFRcnRxbDJrdXRYRWN5emduRWVhaDFwWDVMbzloTG5I?=
 =?utf-8?B?Uk5kUW1NSmVsSlhuWHQzWHhpcVIzcnlDcXR5SG5YRVcwSHpxaGRpaCsrOHFF?=
 =?utf-8?B?R2F5OE1oOWJhWUZIOWRvVldjSnl4L3c5NE82b1pBWndtYmI3aHNZUUNxMEFv?=
 =?utf-8?B?Und1N2xOSjU4OVhNMzY2OW9HZy9WLytXN25pQzVsb21MbENDMWdUL21yS2NV?=
 =?utf-8?B?eGhIRWs1QUpoaWJ0cERnV3lJUVJTZURWSEhzMXMvaXBXcFoyWTJPSWF5ZkdU?=
 =?utf-8?B?ZXNYdUN5VDFoQWdLOWNqWWZiSWRJeHFhK0ZSWjNteEM5MkV3eFpJVzgzYXU4?=
 =?utf-8?B?R29abEVWaTJQcmdEL1lGb2RjcXNrUi9RaWpiN2NiN3VHUmd4SUZhWVJlU2Fo?=
 =?utf-8?B?TU83MDNqMGFjbEYvSTYxNVFiWnRwaktzRHVmOU9OZnJiRXFNUWdocVRINzAw?=
 =?utf-8?B?WlZndW80NXVFV2hqMWFsNHMwa1NGbk5RcUsrSjRpd0JZMk02RTlqM1VwRzBO?=
 =?utf-8?B?cG82RWR3dUdTdER5Zml6Q1dNYmpRVFRDaU9MOVF1MGx0WG9IR1dlc0x1U0Q2?=
 =?utf-8?B?cFFGbFN6emdtQkNLTnVVSDMvN3hmeURTc1A4M01RdFZBODcxWmEySlVwVUpl?=
 =?utf-8?B?OXpBOE9Ca1FqLzBPTGZxSjVPYTVvUmN2UHQ0OStUSnh5THlCcW4rNlR6VFFi?=
 =?utf-8?B?TktGRWJMRHNMMmR4eHA1aG1aZ0xKZURFMFlDZmtBNXE4bXJ0NGZ4YzZFR05R?=
 =?utf-8?B?aVpaNWY0WHBpRjJ2WUdpbkFvT2pCT094M3B6am41OXl6TFhGVGpiT0UwbzN5?=
 =?utf-8?B?OExreVR3MlNDc3FpbGlnWHhUOHZMeW5HYmY4c0U1dm50cnhiQisyc2dFWXNI?=
 =?utf-8?B?aVdLMWw5cmNSL1BQNlVmWWppaG5FZVhGc2NnYXhmU0M5TzdFWmJYeGhJdUZC?=
 =?utf-8?B?ZkRFeGRjNEVJSGNRSk5yVzlQZW9BZnBmaXBsWFZabE1oRTRKRWxqVTlKT0g2?=
 =?utf-8?B?bmFWWXBrRFN1cC9VcER0U0NWOFVpeHdvRnFBcHBrK3RwSDNNUytXaUh5Q1N5?=
 =?utf-8?B?T1ArY0M2clRIRHBhbk5UbmU3T0lVUENyODFwcWN5NWc4ZC9aTm5YbWVCemRh?=
 =?utf-8?B?VmZPSG9NQWtTankwRmNTc250MVFURVdNVUwySHZxZDFxUmdNNXlMZURQeTRp?=
 =?utf-8?B?NVdsc1E0aGcvRXhlSnh1MU9WR0VTN0NBaDJsTkdZLzhWU2JyOVF3ZTAyalh0?=
 =?utf-8?Q?1QLb3Lk7Rw6q6jOIplmAZPYmygpeIs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cExTak1hdkhCWElVWGlNQnFKazNBOEM4bzBjOEYzTU41MUpyUUgyQU1lV0dm?=
 =?utf-8?B?VGJHeXlublcwMnBlb2R6Z1Byai9tbTNWNjFBT3pVbnRPai81Nk1RVTlpR2Jo?=
 =?utf-8?B?UEQ2akFDcnpRamd0Mml6M2lGVk9CS01BQ0V6aS9LWm1CYmp4S290NWpuSzhK?=
 =?utf-8?B?bURGbEV4LzdSd0VSbFNMSTVhejBzd3VybFJkTW54NXQvaW96bWJLSGx3UWc1?=
 =?utf-8?B?VDlPUXpDS1Ftdno2YU5ZUmpqWEZRMzlhUnFoL1FWY0kwcURBN1B6WmdEOU1W?=
 =?utf-8?B?YXJSK2dxNlBIL2lTSWsyOUtnZjU5a0k5ajdIVWRSZnBYbll3b3ZZdm5TRHEv?=
 =?utf-8?B?N01mUHJTVlBHZkM5UFlxRmVDdkI1UGtOZy82TGpWVDAvMW4wemtyOEZ3V2Zn?=
 =?utf-8?B?NnlKcWpwQjRGeUoxSDExdVlzU0xxQ2tBelRtRW1EN3VmL1FQZjRnWnhRWFhW?=
 =?utf-8?B?WUJwd1EzbzZ1MGhKcGdVZzd0SUk4d2lrUFEwQlBITUZmZURWaTk5SmFlTS9O?=
 =?utf-8?B?czFNK0NSRWVTcHVadjlDYTVicDZZRHg5ZDl3a21BeDZESllBYm5EOW9YWHhT?=
 =?utf-8?B?ZmZrQVVHRGgzSEFSSFVaRGNrOVJBaHB4M0hIZno1NUtBSitoc2hwT0hkTGhm?=
 =?utf-8?B?bU1JQ0tBS1lSYWhtQ0l3d2pQTVQySitHZUtPYnlITWRXbm5HWVBTNEJMUGZq?=
 =?utf-8?B?Y29hVCs0ZnZJeWkvS01ta3ROMXd5M0x0V1RaVEptWnJVWTZ1emlnT0RVd3Qw?=
 =?utf-8?B?cW1oSnlHK3BJZy9NQVNRbnBrd3J5YVNoZGlqbFVQMUpFNWlLUDZZdnZXTG0w?=
 =?utf-8?B?eEkzTnQ4YlpCZ0lqKzd0N1htdTNwVzFwK0RoUmxLVFFxZUtibGovRnJvd2V1?=
 =?utf-8?B?aWdmLzlETkdHd2tIdkNWQzFKS0crc1FsM2FsNGUzbnNOcjN6WlNjWGlEWjF0?=
 =?utf-8?B?a1NaMlBzUmozWHJBdXZvblJPcllRV3UrVDZWUHlkU2doc3p6NTd5T1FjOHNr?=
 =?utf-8?B?dnNOQXljL29MM3ZXS0l1UjdDRkdjWTUrcERKWGgrdlBMRllxRjdGNFhmSW4w?=
 =?utf-8?B?NGphRGNsK3M5RWpSWWZ4YmtjWUdKd0Izb0p0WUUrSCtkT0lPWTRhTGNsVWRN?=
 =?utf-8?B?N0J0TW12Vyt6aTZKWkVBbDBIS0dvUTFhajlTOGgwU3g0blFMMW94NGtiYXpz?=
 =?utf-8?B?Wm5saExkcisvNlBkaGxPNkJTL2RMUzJhR1ovaWVRY1hNeFFTc1ZqQko2SUc3?=
 =?utf-8?B?M3FtV01PSXU2ZnBmWm9ONTQyYUU2WWt2ZGdtQ29SQWxoVWh3RWQ3Vlh6ODF4?=
 =?utf-8?B?ZTdnZHJjZTl5YnV0MkkwQ2Y1QU9rU3VSUEFGbkFPSkYrRGlBUjdVeitBaWZ6?=
 =?utf-8?B?YktqVlU5N2tOeC82cDMyOVNCWlhwdjFaeTV6bkhxL3NoTEE1djQrbkVJYU52?=
 =?utf-8?B?SXczSUVlN3dDYUtIeTJxTzExVUJMY3BzWi9ucVplTHZOUnp4bmF4YTNxcFFE?=
 =?utf-8?B?SHZFRTdUWnNma2lYdktCcWg3MzJNcWVhSGZxSzlHWDNPY0k1Q0dvdUJTNDlG?=
 =?utf-8?B?K0JiNlltZWN2dmJoeUlyR0thZVMvbHFZVHVCMkgzTHBNYUptTC9QTUd4R0hG?=
 =?utf-8?B?VkZyKzlZNExhTHArd2xHTVlBSXcxcitzTVRxUG9lNDI0V1U3OHA2ZUUvZklS?=
 =?utf-8?B?cHZoQXkrNGF2eDVHZkkrNkpsMnduMW1jZGk4MWs3QTZmcGhIM2lKTFljQ2tn?=
 =?utf-8?B?cytVVTN0M1FNdzdZd0hLRjF0STBSektEV1IyWG9LeG9vUnJldGRZSTRvOWdU?=
 =?utf-8?B?bllzS2tJVUdLbWdFYXF2Q3RtWkppSnlnb2lrWFdYRVZhRzZjK013QVV0YjlI?=
 =?utf-8?B?UkxUZTVGeU9kM1NFNThYckF1Q0VUVklZTXZGNU81Ykt3N2pNY1BydmxrY1RI?=
 =?utf-8?B?Zi91V0dyRkV6SHJXS2p5R2sydHQzYVMreDUwcEZqcFVtWjZYRGxaNjdZME12?=
 =?utf-8?B?bXUwZFpTM2NJajNiSGpna3FqVUpVaGRYZDBHOHE3aG5SYUVKVVhReVNYNVA4?=
 =?utf-8?B?WWx1V2crYXJOdTFlKzZwNk41TlJ4c2FEYzUzaGtJbEVLUi8zYlJjbjBtOUVx?=
 =?utf-8?Q?E7vA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ddeb29-a880-42e1-254a-08ddf71b121d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 01:22:59.5966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etm+EJrnZM4aAmBQheHxNZP2ckKWAkc1RDaar1zJHn4Vd5nBxSc2T6pjCqyoEHOC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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

W1B1YmxpY10NCg0KWWVzLiBlbmFibGVfbHJfY29tcHV0ZV93YSBpcyBpZ25vcmVkIGluIGN1cnJl
bnQgTUVTIEZXIHNldHRpbmcuICh6ZXJvZWQgaW4gbWVzX3NldF9od19yZXNfcGt0IHBhY2tldCku
DQoNCkJlc3QgUmVnYXJkcywNCllpZmFuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQpTZW50
OiBGcmlkYXksIFNlcHRlbWJlciAxOSwgMjAyNSA1OjM2IEFNDQpUbzogQWxleCBEZXVjaGVyIDxh
bGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENI
IHYyXSBkcm0vYW1kZ3B1OiBFbmFibGUgTUVTIGxyX2NvbXB1dGVfd2EgYnkgZGVmYXVsdA0KDQoN
Cg0KT24gOS8xOC8yMDI1IDI6MDUgUE0sIEFsZXggRGV1Y2hlciB3cm90ZToNCj4gT24gVGh1LCBT
ZXAgMTgsIDIwMjUgYXQgMjo1OeKAr1BNIE1hcmlvIExpbW9uY2llbGxvDQo+IDxtYXJpby5saW1v
bmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4+DQo+PiBUaGUgTUVTIHNldCByZXNvdXJjZXMgcGFj
a2V0IGhhcyBhbiBvcHRpb25hbCBiaXQgJ2xyX2NvbXB1dGVfd2EnDQo+PiB3aGljaCBjYW4gYmUg
dXNlZCBmb3IgcHJldmVudGluZyBNRVMgaGFuZ3Mgb24gbG9uZyBjb21wdXRlIGpvYnMuDQo+Pg0K
Pj4gU2V0IHRoaXMgYml0IGJ5IGRlZmF1bHQuDQo+Pg0KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBZaWZh
biBaaGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaWZhbiBa
aGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1v
bmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4NCj4gUHJlc3VtYWJseSB0aGlz
IGJpdCB3aWxsIGJlIGlnbm9yZWQgb24gb2xkIGZpcm13YXJlcz8gIElmIG5vdCwgd2UnbGwNCj4g
bmVlZCBhIGZpcm13YXJlIHZlcnNpb24gY2hlY2suICBBc3N1bWluZyB0aGlzIHdvcmtzIGNvcnJl
Y3RseSBvbiBvbGQNCj4gZmlybXdhcmVzLA0KDQpJJ20gYXNzdW1pbmcgaXQgZG9lcyBnZXQgaWdu
b3JlZCwgYnV0IG1heWJlIFlpZmFuIGNhbiBjb25maXJtIGl0Lg0KDQo+IEFja2VkLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+DQo+IEFsZXgNCj4NCj4+IC0t
LQ0KPj4gdjI6DQo+PiAgICogZHJvcCBtb2R1bGUgcGFyYW1ldGVyDQo+PiAgICogYWRkIG1vcmUg
ZGVzY3JpcHRpb24gdG8gY29tbWl0IHRleHQNCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tZXNfdjExXzAuYyAgICAgICAgfCAyICsrDQo+PiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21lc192MTJfMC5jICAgICAgICB8IDEgKw0KPj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUvbWVzX3YxMV9hcGlfZGVmLmggfCAzICsrLQ0KPj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2luY2x1ZGUvbWVzX3YxMl9hcGlfZGVmLmggfCAzICsrLQ0KPj4gICA0IGZpbGVz
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMNCj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMNCj4+IGluZGV4IDNiOTFlYTYwMWFkZC4u
NTQwYjUxNDMxMmIxIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bWVzX3YxMV8wLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFf
MC5jDQo+PiBAQCAtNzEzLDYgKzcxMyw4IEBAIHN0YXRpYyBpbnQgbWVzX3YxMV8wX3NldF9od19y
ZXNvdXJjZXMoc3RydWN0IGFtZGdwdV9tZXMgKm1lcykNCj4+ICAgICAgICAgIG1lc19zZXRfaHdf
cmVzX3BrdC5lbmFibGVfcmVnX2FjdGl2ZV9wb2xsID0gMTsNCj4+ICAgICAgICAgIG1lc19zZXRf
aHdfcmVzX3BrdC5lbmFibGVfbGV2ZWxfcHJvY2Vzc19xdWFudHVtX2NoZWNrID0gMTsNCj4+ICAg
ICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5vdmVyc3Vic2NyaXB0aW9uX3RpbWVyID0gNTA7DQo+
PiArICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5lbmFibGVfbHJfY29tcHV0ZV93YSA9IDE7DQo+
PiArDQo+PiAgICAgICAgICBpZiAoYW1kZ3B1X21lc19sb2dfZW5hYmxlKSB7DQo+PiAgICAgICAg
ICAgICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5lbmFibGVfbWVzX2V2ZW50X2ludF9sb2dnaW5n
ID0gMTsNCj4+ICAgICAgICAgICAgICAgICAgbWVzX3NldF9od19yZXNfcGt0LmV2ZW50X2ludHJf
aGlzdG9yeV9ncHVfbWNfcHRyID0NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9tZXNfdjEyXzAuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNf
djEyXzAuYw0KPj4gaW5kZXggOTk4ODkzZGZmMDhlLi4wMTI2NmVlZjY1Y2IgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYw0KPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8wLmMNCj4+IEBAIC03NjksNiArNzY5LDcg
QEAgc3RhdGljIGludCBtZXNfdjEyXzBfc2V0X2h3X3Jlc291cmNlcyhzdHJ1Y3QgYW1kZ3B1X21l
cyAqbWVzLCBpbnQgcGlwZSkNCj4+ICAgICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC51c2VfZGlm
ZmVyZW50X3ZtaWRfY29tcHV0ZSA9IDE7DQo+PiAgICAgICAgICBtZXNfc2V0X2h3X3Jlc19wa3Qu
ZW5hYmxlX3JlZ19hY3RpdmVfcG9sbCA9IDE7DQo+PiAgICAgICAgICBtZXNfc2V0X2h3X3Jlc19w
a3QuZW5hYmxlX2xldmVsX3Byb2Nlc3NfcXVhbnR1bV9jaGVjayA9IDE7DQo+PiArICAgICAgIG1l
c19zZXRfaHdfcmVzX3BrdC5lbmFibGVfbHJfY29tcHV0ZV93YSA9IDE7DQo+Pg0KPj4gICAgICAg
ICAgLyoNCj4+ICAgICAgICAgICAqIEtlZXAgb3ZlcnN1YnNjcmliZSB0aW1lciBmb3Igc2RtYSAu
IFdoZW4gd2UgaGF2ZSB1bm1hcHBlZA0KPj4gZG9vcmJlbGwgZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvaW5jbHVkZS9tZXNfdjExX2FwaV9kZWYuaA0KPj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUvbWVzX3YxMV9hcGlfZGVmLmgNCj4+IGluZGV4IDE1NjgwYzNmNDk3MC4u
YWIxY2ZjOTJkYmViIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRl
L21lc192MTFfYXBpX2RlZi5oDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUv
bWVzX3YxMV9hcGlfZGVmLmgNCj4+IEBAIC0yMzgsNyArMjM4LDggQEAgdW5pb24gTUVTQVBJX1NF
VF9IV19SRVNPVVJDRVMgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDMyX3QgZW5hYmxlX21lc19zY2hfc3RiX2xvZyA6IDE7DQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCBsaW1pdF9zaW5nbGVfcHJvY2VzcyA6IDE7DQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBpc19zdHJpeF90bXpfd2FfZW5h
YmxlZCAgOjE7DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHJl
c2VydmVkIDogMTM7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IGVuYWJsZV9scl9jb21wdXRlX3dhIDogMTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDMyX3QgcmVzZXJ2ZWQgOiAxMjsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICB9Ow0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICAgICAgICB1aW50MzJf
dF9hbGw7DQo+PiAgICAgICAgICAgICAgICAgIH07DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9pbmNsdWRlL21lc192MTJfYXBpX2RlZi5oDQo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvaW5jbHVkZS9tZXNfdjEyX2FwaV9kZWYuaA0KPj4gaW5kZXggYzA0YmQzNTFiMjUwLi42
OTYxMWM3ZTMwZTMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUv
bWVzX3YxMl9hcGlfZGVmLmgNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9t
ZXNfdjEyX2FwaV9kZWYuaA0KPj4gQEAgLTI4Nyw3ICsyODcsOCBAQCB1bmlvbiBNRVNBUElfU0VU
X0hXX1JFU09VUkNFUyB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
MzJfdCBsaW1pdF9zaW5nbGVfcHJvY2VzcyA6IDE7DQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1aW50MzJfdCB1bm1hcHBlZF9kb29yYmVsbF9oYW5kbGluZzogMjsNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGVuYWJsZV9tZXNfZmVuY2Vf
aW50OiAxOw0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCByZXNl
cnZlZCA6IDEwOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBl
bmFibGVfbHJfY29tcHV0ZV93YSA6IDE7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQzMl90IHJlc2VydmVkIDogOTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICB9
Ow0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHVpbnQzMl9hbGw7DQo+PiAg
ICAgICAgICAgICAgICAgIH07DQo+PiAtLQ0KPj4gMi40OS4wDQo+Pg0KDQo=
