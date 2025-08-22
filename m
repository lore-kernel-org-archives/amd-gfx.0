Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD914CA0EFA
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 01:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41BBF10E0F4;
	Fri, 22 Aug 2025 01:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n5ZH67p9";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B000610E0F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 01:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBdhsTibUF0VozDC2b9wcBbxjbtMCNY0XPLpMwP1ndVCjpxhGWhM4geem5/ZWMg5w5+kELqZ0/kG8PWEYG+c2uR8cD60pXzztHH1uPoiFXa28ac6Aou1LROLGuR/7OoucQp/BekIWP+h8sCdes64rd+f15IPZOSyZssrZWxowTK7PAfOs5ASwiZlTc3qAgJqk+wH4B9ImxdyDi/TzBvZmjs8Yqs3kdELYO0Ynvx1F8UcCdJ1tlajs0aCTwOti5py2+7YDv0v6hd+Ojom5WS/VlGLLnGz1a28gzIQnAAzOuiWsIucwhPp8xyxAq8XWql4kTvhufdGeMEYM0ByQqUASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opmFueXC4bP2Slbp1yRJLjPAsy3k78fGUoVJT+ZiK78=;
 b=NO/EoFnAyRkRFk6wFWvm6L0pHmHvmbJxtcdWwmpS/HyduEthjMApsnnecP49WpvGzNFaHfJ4EnyklqwRTl79mquytS8kP+L7Y87z5U/2gqTKsBRzW6AZFKXgWsyVFkKV1csz13+F10YoneB9cbSjt/kGI9Utpi7cLBsxeT5RLydjh9/g2pQ05dFIkERr4Iat9MT50NRwaB7LLzcL45N1ST6DEgzPZyhRu2oFQERrOseZ8AW4y8x90UEWT79lC9seunaWTHTMAUW5H/077H/H7wBZhLAkwu7quiFM1QniFQYlT4s5C5cJ0zxrYbq9p7mzwwrtnGnjNMb+FKExGToaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opmFueXC4bP2Slbp1yRJLjPAsy3k78fGUoVJT+ZiK78=;
 b=n5ZH67p9e+7j3kPJQ26XP8ggrpMwXjv3mZC0+c61RSJRC3/dcHciMNkZllFzQVm6fdxW9cN1A6q/sk23vPsyRghP266ohdb8YAZL2r0nDsyTEmulQu2QRU9NSLSEwqeiXGJiOdSnNo96CgVORNUiiOvcR8XdnG0+NOQkK8Y4zok=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 01:33:05 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.9009.016; Fri, 22 Aug 2025
 01:33:05 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Jiang, Sonny"
 <Sonny.Jiang@amd.com>
Subject: RE: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization
Thread-Topic: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization
Thread-Index: AQHcEX8hl83t7xSVMEyUuuQ0G9VmlbRtQgIAgACjatA=
Date: Fri, 22 Aug 2025 01:33:05 +0000
Message-ID: <DM4PR12MB5152CFF92E0C5A49F711DA04E33DA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250820030400.514460-1-Jesse.Zhang@amd.com>
 <20250820030400.514460-4-Jesse.Zhang@amd.com>
 <ce9c1f2f-86ba-4c64-9cc4-10261dee138d@amd.com>
In-Reply-To: <ce9c1f2f-86ba-4c64-9cc4-10261dee138d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-22T01:29:30.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA1PR12MB7733:EE_
x-ms-office365-filtering-correlation-id: d016c080-aca3-47a9-98e9-08dde11bd7b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SkFLUjJrZXdSaHNaVXZVODAwdk9abjNiMmloM051WnY4VGtJejQ5VFhJdlho?=
 =?utf-8?B?dFJNMEN6WVhjOHBobmRsaXpPMnY1NkNSTkgyZm54QVpGZ0NOMGpzenBxTlpj?=
 =?utf-8?B?MHBXY25HbzgrMlBKdjNEOTJVQWpFYVRzRzJXZldGNjJnYWs5RDMrTGxiSEta?=
 =?utf-8?B?MnlZb1gxdTNGSU9HRlRXOFZnZlNBYmlhOTRVV3I0WUFLeHM5VHNnRUUzcDND?=
 =?utf-8?B?R1dhVWdXS0RrWFFlYWpkOW0yeGlKTkFVbFBqQTdqeUM5YjhOWGpSTE5odk11?=
 =?utf-8?B?cWFxU01iMGl3RzBsM1FoT3JpS3pvY3RKZ0Y1VWFLdmxzeDJoWTVhd29RSjVN?=
 =?utf-8?B?THN2S2VwRUNGck9sZ0p6cUNWbHdrWEhQaDluOUltOW5mTGEwRTkzSWNHYkRr?=
 =?utf-8?B?OTFqbStiYmRXaFNvUTJQaE82MFcxdkF5aUlvamE4Ny82amk2S1o3RnBXMENi?=
 =?utf-8?B?VGdzb0Z2WE5LaWs5UUs1RkdDdkx6aTUvYklHSUxFRW93bTQ0QzgzVUs5bVFQ?=
 =?utf-8?B?cDl1M2dDTGNMaHdZa1dacFBBa2JJMzh2OEZpVXJZNWdzVm9JVmlRQVZXeGRX?=
 =?utf-8?B?M3JsSDRyMnlzQjRNWU42WDQ0R0VzRVMzcXZnN2pWZnlOYXFNRUJsQ0tpS2NP?=
 =?utf-8?B?d2N4YUFWU2IxdHo4aGYxOVJjWjYwVlBtZ1NIYmphZmdkeHU4SWVYVjNJdm4v?=
 =?utf-8?B?d2toemtMV25kY1lCazFRck9MRHBtcTBPWTR4V0k4S1kxU0p4WVBCVThqc2U2?=
 =?utf-8?B?K1NsTmF3VWk2Z0ZUYmRJSkpOU1I3eXo2SHZDZlNhYUkwUG5xV3lnRzNINmxN?=
 =?utf-8?B?SkdXeDl6T3hId3ZnbkhuOFBFZkFVcktwbXJtQURNNlFCRGdZUGJ4TkxPcUlP?=
 =?utf-8?B?MTV5N2Z4TUQrNHFrUE9qdFZ1WktGcUdna0dmTW1CeGxTVVN6ck9MMDRsNXVT?=
 =?utf-8?B?WW1CT3h6RjdrTTk4MnlDNytSekRra09mejJENklSQnVvc2VEZ21JSXQ0enV3?=
 =?utf-8?B?MFd6Zm9IT0FoajI4Y2pSak9lN3FHOFFMM3E0N0VPTXNWekJXcURvcmJwaXUw?=
 =?utf-8?B?a2Q0OGF1alFzSEtud2lsQjlvd08yaWxlWW9VVE5ZOUNkbXZ6MFZjQ3FMU3FW?=
 =?utf-8?B?V20zTVVINm5kV3JmaFcvNlArRGM3RkNnM054WHI3NE9DV01qS2dGSlFRODNG?=
 =?utf-8?B?TFgrM3NFT1VmUWRCNWZLVEVwSEY1WVdKaHEydS9BL2ovTWlwU1l4SDdjS01O?=
 =?utf-8?B?M2pkQjJjem1KN09taS9lSCtkcVo2SzZZZUN1TVpNSUo1RzBqWENaN2IxbXdr?=
 =?utf-8?B?L08yRW1jWWQ4Tk5ES1hibmt3Wnh4OWliREFNM3JqQVhIaHpqdURXK0hoY2d2?=
 =?utf-8?B?WTA3eW1mQ1YzazYwNGg4RURkbXNSRGVBa2NQcUhNTVZRdnZOMnFyWk1CV3dN?=
 =?utf-8?B?cFA1RWFNemR2WlJ3STNzcVFHZzI3S3dLeHNPVTBBSnhXRlhramVnNHNRcU8v?=
 =?utf-8?B?Qjd6TzB6emlaSGpxMzRERGwvSUFGUFdPOVdhT1YwVy9tbjJ2ZThaRUlPY0k1?=
 =?utf-8?B?K2tkUHFjNEk0ekVxU09rQkhTcFF3MHlOWW5pMTBCSW9NSlFvbWFaMUFYR0VJ?=
 =?utf-8?B?WE5COWFmWVR0dExIOWRZRXRaQm02M1BCM1grVG1WQmJ6YnRiR29RRjNnbjRW?=
 =?utf-8?B?dXFJK2gxdHZuRzdKd2Mxc3U1QnBwWU5WdkxNNHBZcjhwL04zUUNaS3U3TERP?=
 =?utf-8?B?TTgyaEtIeUt5VC9QeVRvWnVqVFNUVk4zdDYzME1VTU5seWh1MkwwbGc4Uk5H?=
 =?utf-8?B?Z0VZQkh6K2tGZ05PZmlIRTA1SnlDeml2WTFxU3BVNkh2SU9scG5GWENjeGE2?=
 =?utf-8?B?dkw5a25nODZqWFgxZzRBdnByTGw2andyY205WnA2a0lnOTVaQ0hBbDZDNjNL?=
 =?utf-8?B?ZDRFbG1FdU1lalRMOXQwbTBoRnN2ZkhNdGdnOU9rdk1ETkx1Q0wxNjlKbjIr?=
 =?utf-8?B?UnVSc0liS053PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDRneUxiVnNMNFZJanVMM3dkOWFFTzlvbm9xUU5vd3FlbERuUTcwaUo5d283?=
 =?utf-8?B?VWs4ZmNuUXM0bkNtVm5LY01sUEUwTEFNanYrOHBRYWhic29HeTBoclg2WUZQ?=
 =?utf-8?B?aXJLVFRBYkRRdk04ZHJNRHRwMU9LbjRESHBsNjZkMVRBcENrSm5jNWJmNFZN?=
 =?utf-8?B?dnVTYS9ZczdxdTROejJoejJwMW1aNGpFbGt0MlowZ1V3YU9qOXp5TW9taE1x?=
 =?utf-8?B?ZmVBQVZlTGFZM3lrWEprY0UxYVlTc1c1SXUwZzAxRHpBZTBHbkdwQm1ZR0U5?=
 =?utf-8?B?dkQ3VEM0ek8zdmptMUZ5aG1aYjFkbDlxWVd4cVV6Nmx3QStJVzBhZGVnTzFV?=
 =?utf-8?B?RlMwM3psMVUyQUZtMnNLSFBUYXp4M2ErTjB6RnJRTU9MWVEwQ1E0L3ZPWmRT?=
 =?utf-8?B?MkliRDV3UmVQSEVBVVc2amVaREFZMDYwN3JkTzRvUy80VWd2VTJNQVQwNnFV?=
 =?utf-8?B?SWNFZjVjUDNYSnY3ZFR0bldXZlMxa0hjbTZuMGN4NmVSeDZjTytiRVd3S2hP?=
 =?utf-8?B?RGV0NWZRN2hwUHhjOXF6RDBSaWRWQWNPUUpQakgrTVJ6NzYzQXd4YThYcVdx?=
 =?utf-8?B?QWQyZG1CYjNwWXRqaUhMRUpJTUNzM3l0YXhBTlNiUWhLZmhGTGtxMUoyVmJl?=
 =?utf-8?B?TTZ0aTRpRUg5NWdibVhlL1lXUVhZWXJhbHJ5Nzg4SEVQOTgyNFBTSENVVUpv?=
 =?utf-8?B?MFlpMFF5aVhlOHcvaVlQeTJqc1BIdGdDSDdNSG52RTA1OGw3d2RyY1E1U3Fm?=
 =?utf-8?B?V1htSnhpT2hjd2JWNll0akQ0V0JMOGNza3dVM2ZZckhwS0RDSmdpeE1YbHpv?=
 =?utf-8?B?Vm5uU0NRNk4zTTVhUVBwdWRVZTIvRW1ybDlQUWsvdDFmYXBFa3VjaCt2ckJa?=
 =?utf-8?B?cmkwVkRmaldtV2ZFd0VGWmdLZ3V3cDA1WWhISFJEWkZMVlhLbGhEbkloU2tt?=
 =?utf-8?B?Yit1bUdEc0FLeTdyeEhPS05ITEhkZ1pVNFE4eDc0L2tqMzkwczU1RzlQcWht?=
 =?utf-8?B?aUJaTWR2ejNFalpzM3ArYWltVFIyeUZqOHQrVk1rNDdwMWl3c2NTMzNkOHBJ?=
 =?utf-8?B?Q2Y0VlRZNHFxaXRsNzZTT1JMUENwdW1pbEFIWXh4RDhtRWQ3MXJrZnhKcmJU?=
 =?utf-8?B?OEY0ZXJwdVI0UzVoY0MzUnhRTnBmbSs5OStHOUFZSXl1R2JxcytoclFVa24w?=
 =?utf-8?B?U0V4SWpzMEhaKzFHUjY0eC9VRUd2Y3pTVTZSbGRESmR6R05WYnU1WmdlaXlj?=
 =?utf-8?B?cjdJMjRZbWNEZEEvQXVKQVJ6SFdsS091ZDNKYWx3YTAranNDelluaGRrOTkr?=
 =?utf-8?B?WUxnTWh4ODNhdTNGZ3RSN3B3N0lJWG9YeVZHVXFHZGlIeGlOOU02bHNkRnJL?=
 =?utf-8?B?QVYrNXhiOVlWOG1oQUpwY0ZnOGZ2bVg1VUpCZUVyWW8wdk9ybGF0Vi9mV2xB?=
 =?utf-8?B?c3A0ZGRYQ1VXazVtNXgrak5UYlJCZ0hHNEoxMjNTcThkSlVBY3FFMjBNY2hy?=
 =?utf-8?B?Y0VRYllGUk0vWGs1WmE4YXAySmJ2OVdYY2hnZlA4VGVDcUhtRkNpaU15bEc4?=
 =?utf-8?B?cDlUODNiOVhrTTYrSkliajJLUGlhS1pSdktmRlZQK3pZNE1GdDNvV1NEOEwy?=
 =?utf-8?B?eVdJZ3VkV0Fvc1l1VVJhVDJJdlZrMXhMaDVMVlhMa0FzMTc1c2s2S0NUNXM1?=
 =?utf-8?B?dEc1eG1IWU9HZ0lrOHd3WVd6Rk8vVkNLZGZSUDR4dUFYTGpqR2dTM1dGU0Js?=
 =?utf-8?B?L051R3hIZFNLQS85L3NmVHFtdFJ4KzJMUTFGeTE0SmR0c3B2dFFRaG1NMHhI?=
 =?utf-8?B?MjE1NTNsNTVscmZBeXFkMzlKUnJkUVBIbGl1ekNBNWdBajRLckFoRkpuZ0ZG?=
 =?utf-8?B?L0hNOW5HU2ozQmVJaDVGMVE1UUpXQllzTGhwSzkreTV1TVF1TWp4V213Y3Mz?=
 =?utf-8?B?enQ2akhJL0M1bVg1K0V0Y0puOERUOTBMdUZ2VWZXN2RQZ1MxcTNCLytNQllU?=
 =?utf-8?B?VnFhejMzVVNLSkNPaWhwVDhCUHNtL1FOUE83dmZ6U01CL0hHanhEQTllQzVV?=
 =?utf-8?B?K3BEVGEwTjJLMVZyMXVMcTNCNFpCbWZUVEduTlNRYzI4WjdkUm9haG13ZWdY?=
 =?utf-8?Q?7Kpk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d016c080-aca3-47a9-98e9-08dde11bd7b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 01:33:05.5308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCjHMuCcGPlT0WIAIxLUdvDF6MrjsLwyA1oTD2q1orXzYM8pF8nb8xNroZ3CWnBFbrUGZyKwfC3pYgzNucKnng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+DQpTZW50OiBUaHVyc2RheSwgQXVndXN0IDIxLCAyMDI1IDExOjQ1IFBNDQpU
bzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
OyBMaXUsIExlbyA8TGVvLkxpdUBhbWQuY29tPjsgSmlhbmcsIFNvbm55IDxTb25ueS5KaWFuZ0Bh
bWQuY29tPg0KU3ViamVjdDogUmU6IFt2MyA0LzVdIGRybS9hbWQvcG06IFVwZGF0ZSBTTVUgdjEz
LjAuNiBQUFQgY2FwcyBpbml0aWFsaXphdGlvbg0KDQoNCg0KT24gOC8yMC8yMDI1IDg6MzMgQU0s
IEplc3NlLlpoYW5nIHdyb3RlOg0KPiBVcGRhdGUgdGhlIGNvbmRpdGlvbnMgZm9yIHNldHRpbmcg
dGhlIFNNVSB2Y24gcmVzZXQgY2FwcyBpbiB0aGUgU01VDQo+IHYxMy4wLjYgUFBUIGluaXRpYWxp
emF0aW9uIGZ1bmN0aW9uLiBTcGVjaWZpY2FsbHk6DQo+DQo+IC0gQWRkIHN1cHBvcnQgZm9yIFZD
TiByZXNldCBjYXBhYmlsaXR5IGZvciBmaXJtd2FyZSB2ZXJzaW9ucyAweDAwNTU4MjAwIGFuZA0K
PiAgIGFib3ZlIHdoZW4gdGhlIHByb2dyYW0gdmVyc2lvbiBpcyAwLg0KPiAtIEFkZCBzdXBwb3J0
IGZvciBWQ04gcmVzZXQgY2FwYWJpbGl0eSBmb3IgZmlybXdhcmUgdmVyc2lvbnMgMHgwNTU1MTgw
MCBhbmQNCj4gICBhYm92ZSB3aGVuIHRoZSBwcm9ncmFtIHZlcnNpb24gaXMgNS4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+IEFja2VkLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfNl9wcHQuYyB8IDQgKysr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEz
XzBfNl9wcHQuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3Yx
M18wXzZfcHB0LmMNCj4gaW5kZXggNjI3YTgxODhkODY4Li45MzA2YmZlODA4ZTQgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzZfcHB0
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBf
Nl9wcHQuYw0KPiBAQCAtNDM3LDcgKzQzNyw5IEBAIHN0YXRpYyB2b2lkIHNtdV92MTNfMF82X2lu
aXRfY2FwcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCj4gICAgICAgICAgICgocGdtID09IDQp
ICYmIChmd192ZXIgPj0gMHg0NTU3MDAwKSkpDQo+ICAgICAgICAgICAgICAgc211X3YxM18wXzZf
Y2FwX3NldChzbXUsIFNNVV9DQVAoU0RNQV9SRVNFVCkpOw0KPg0KPiAtICAgICBpZiAoKHBnbSA9
PSA0KSAmJiAoZndfdmVyID49IDB4MDQ1NTcxMDApKQ0KPiArICAgICBpZiAoKChwZ20gPT0gMCkg
JiYgKGZ3X3ZlciA+PSAweDAwNTU4MjAwKSkgfHwNCj4gKyAgICAgICAgICgocGdtID09IDQpICYm
IChmd192ZXIgPj0gMHgwNDU1NzEwMCkpIHx8DQo+ICsgICAgICAgICAoKHBnbSA9PSA1KSAmJiAo
ZndfdmVyID49IDB4MDU1NTE4MDApKSkNCg0KcGdtID0gNSBzaG91bGQgYmUgdW5kZXIgc211X3Yx
M18wXzE0X2luaXRfY2FwcygpLg0KIE5vLCBQZ20gMCwgNCwgYW5kIDUgYXJlIGFsbCAxMy4wLjYu
DQoxMy4wLjE0IGlzIG5vdCByZWFkeSB5ZXQgYW5kIGlzIGJlaW5nIHRlc3RlZC4NCg0KVGhhbmtz
DQpKZXNzZQ0KDQpUaGFua3MsDQpMaWpvDQoNCj4gICAgICAgICAgICAgICBzbXVfdjEzXzBfNl9j
YXBfc2V0KHNtdSwgU01VX0NBUChWQ05fUkVTRVQpKTsgIH0NCj4NCg0K
