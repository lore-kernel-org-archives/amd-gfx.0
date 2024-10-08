Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7646CEFC21
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 16:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566B810E170;
	Tue,  8 Oct 2024 16:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bTGTIRhA";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B447710E170
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 16:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnyLoiFmbeRE2cK0zk5rAIdgazSkezmQsyHuu8JOEb2dyu6WtCiOfayzI2YeJdBuC+1/ASv691RIZDxhLA8UOn+QJny3e+thFBLgSX/bWZ2g35fVqh+A7ALYr8SEfPr84m3ERf5AP+twCnsSdQc2xyPL6aQNzjuCATSDlSxW+MCuS5b9cZRg16I1fPPqXEZY0wWv8jvhQLx/CjOxtZyzq1UAmPlBpIRoKvb6mSD6yI9cICh2HKl8YDPGrg4K9v7xhqvZbx2/SVU1WGyAJ5FD5LLbS2oR97sp69I9yULsRQPcIIhgwOiD7ZYQSFmR6agWSmV9h5cKRWGmHiVTJVGhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqFQX0OiO1vmliA1PkSnc+eetDiFF2xR1j08Mi/tgdM=;
 b=dY7wHL2OdvTrt/cjPedjxj174bqWRlGTrxtLS8cwYhGvr7P0O1OqoFa/J+22RN7wcAYSYlcrb8zhdxuJw9z6HKb3Da4mqq5NxE5ZiWeZY10ifF5jIA86UsUykpMlADKvxhYCApCGkDECgN7DcFhIoI6R2vZ+iZVAsQtWU/EIJZnGV2HMJ3q6OFXaV5aemdra1ISCS3o0nrqE6KzZ620PWz6tEoAx3oFw7NQvtQd+U/xIAYDOW32enkrfBwtpF8uVm7XwEF2NjOcWgoLBy+eRObYR2LmLyYBrFyaiRPArCdiPmBmbjDVoTlY4wBmLLYNfqTPKJlGfbmrvhowOFoG/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqFQX0OiO1vmliA1PkSnc+eetDiFF2xR1j08Mi/tgdM=;
 b=bTGTIRhATqa8bokfLrzWrRAbsAsKIARrQlODMTby5ETwytnhNP3yuMvOdecm77joUxQg9x+0uWKnQNj2bmvGaMV/0hz4pYba/VcOKn72VE9zSsCWVuuo9vJ8WHG+RvRY99DuURM7bi+eGIlN7i40TpYTqJ07OR8By+1XHMoBK50=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 16:03:45 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 16:03:44 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Use dynamic allocation for CU occupancy
 array in 'kfd_get_cu_occupancy()'
Thread-Topic: [PATCH v2] drm/amdkfd: Use dynamic allocation for CU occupancy
 array in 'kfd_get_cu_occupancy()'
Thread-Index: AQHbGYktVVKa0xwz2U2qF3tE5kHQfrJ9A/zQ
Date: Tue, 8 Oct 2024 16:03:44 +0000
Message-ID: <BL3PR12MB642519992625AA79F385EA33EE7E2@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20241004034505.3759692-1-srinivasan.shanmugam@amd.com>
 <20241008135108.108253-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241008135108.108253-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=dc44a82b-5a57-4557-a7ff-760459a39629;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-08T16:02:51Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|PH8PR12MB7110:EE_
x-ms-office365-filtering-correlation-id: a103a173-365f-41e1-bd7c-08dce7b2c969
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UXZiaENzOTRHTlNPVC9pY2FoZmNpT0VHdm8vWDFyVTdHVmU0OTFpaXZjR1ho?=
 =?utf-8?B?cUFwNmYxZDgvd1p0SUxvZ3M4MWtBTEx0NGMyMlFyREI4Z0lTMS8xVFFHV1Vr?=
 =?utf-8?B?T2NWTjZxb3RCeFRrbGdzR2VKL3pkNUhYaStZeElUZEJhUmxzek5ZdlRmU1NW?=
 =?utf-8?B?TGlOVmFyQ1BMdlQ0VUJuZDhXTUNzdVRjdlVZcU5ZbEdwb2JMVGtWN3Zxc3FY?=
 =?utf-8?B?NkhVZ1Z1MmxTbnF2TnFCZ3R4SG1ONWg5VVorRnJSUUYxdloyKy9tRmpYT3pQ?=
 =?utf-8?B?ZjhsaFFDR2VDZEFQVE1xRmRLcERpSWRXQ3o4Nnp0bUQwV21NVTRpME1ua1pW?=
 =?utf-8?B?YVdNakNBcHVvOFgvMXpFSG1weWJxQWJjSFExcUwzb2JoajE1TkJuRENWN2JS?=
 =?utf-8?B?RjdIcU1Hb3ZmSGwycy9hbURzc2hiOElFNjZnRFRPQVp2SjJ3RDVYenNaTElw?=
 =?utf-8?B?R2pqNHltRFF6YlZ5dUlVYlRhSVUxeUhXZkVXaExHVys5TTFEQzUzdDJWQThy?=
 =?utf-8?B?c3JXNS9tZVljUk44UHdvR3hncW5TQTFzbFVFeVlYdmhXRG56MUhVaFUrUnlN?=
 =?utf-8?B?S3JjTkMxZ3ZWQ0lRWDNjR29PUEo4Y2lYZXVCRzhhTCtHSFJ2b1U2NWNWYTdq?=
 =?utf-8?B?TFV5VC96akhhL0o3ZG1GdjVOeFFQS2RrdCs1cnFXVFVmK3NqRVMwcWsrVzBj?=
 =?utf-8?B?c3E3WnRrMXFRZVg2NDR6MHlJT3ZET2duT0krWE4rRmdMTW9zcWI4dHhnd0NM?=
 =?utf-8?B?NTByeE0rOUFMdmw0YjFXaTV0WmdpVjVYRG4xQ1d1Y0ZVR1pURUtvcVpsWWRJ?=
 =?utf-8?B?K3ZkWERid0VPbmhhZllPNTV5Wm1EaFpSRllGVG1nZE9XUTNNUExvV0U2TDh3?=
 =?utf-8?B?OTZtaTJEcUQveHpwM1d0YkVlV0M5dUlHazN1c3haclpHU2hGc3UxZC9sSVhW?=
 =?utf-8?B?RVNTamFYTFhnOG9xZFQyUE44Uk9NMFNQeW5NUDUzNnBvSUc5STJ1TDB3b3Rk?=
 =?utf-8?B?UEQ4eGpnZkNMZTZLVVpFd2YxZTBFWUNzZG1RYkFTdmJ1dldjS1FRT1lwdmZ0?=
 =?utf-8?B?ODlaclpSYmVlWWxZNWRacjVPd2tKQ1B1NkdtaUJLV3J3eG9HZ3k0dUNidFll?=
 =?utf-8?B?Q3NhZXhCek5leEprTThabzRjMUNMV2hRNDUxVkVscStZTFVnaXdaNXVXTWRQ?=
 =?utf-8?B?Zzh3bUJpVWVka1MvSk9LRmhqdzFoYW4vems5WnBCVzJYZHNvWUgzV21hU3Uw?=
 =?utf-8?B?QmpKbThVZXNvV25NVjFid2pZclg5U1BCeUdKNldVZ2lwU09sdEhMWXhBQmQ5?=
 =?utf-8?B?T29zTjVHYVdkOGtlK1NXRWY5VW5nZ3k4UHVGMDJZWGw0NFhXc3FjOGM3SFcy?=
 =?utf-8?B?YVJYTUw2QVV0elZQSTBmQXFnRWNNRU9XSzV6Sy8vYjNuZmp6SFozOFU3ZDdi?=
 =?utf-8?B?VlJCT3RteXBmUUJDL1NIQXJEejYrcjdDTkJpZUF0Z1NKK0l6TnE1a01DZzZB?=
 =?utf-8?B?dzVmVGRFbEU1SkhYTkxSMHlzTWxBK1p4SEtxdFNDbWgxMVp4Y1l6dVNBM2tl?=
 =?utf-8?B?bk96ZDlsV1krVGVZWTRxOHh1RUQvR1UwdDcvRm5jbW95V29tNmxlc3dvVWFR?=
 =?utf-8?B?Y3BLVWJJcjNEZDNkMEw4OVZaNlIyTmIvU2plaG82VnNmLytyME9xMDNtQmRy?=
 =?utf-8?B?aDU0VmN0SEs0WVUyYWFKZlFEK2NkZGhPSjZPbGZEVVhLVk5RVHpsTENCa0pz?=
 =?utf-8?B?cHFqdFFtVnZZMVRONit5NWhReUcxMG1xczlaeTQwR1h3RWdRZjlOSytBM3M1?=
 =?utf-8?B?SzdZZ1dCRzhyVXM5VUdyQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Unpna3FiTTJyNG13dVlBeWx4K254U1l5MWxLZWpOTi8xMjV5SDE4ZmFBWVh5?=
 =?utf-8?B?QWVQRW0vVEpwMnh0YjhoYUp5MVlXOTM0TGFuVEJick03OWxQbnNTTGpWVFV4?=
 =?utf-8?B?N0N5OHgzZ2wyUThYQTFwUndMSXQvZ01sRkJISFdNVUMwdjlWanFQZTZqWmhj?=
 =?utf-8?B?MGg1NjB0c3hjalVjMkpoM2owbXNDdTg5eHQxY1N0N01iRnNZNmw0RUloTDdD?=
 =?utf-8?B?MVpOUTdpYVNxRXVWQ0dJNmp0dGlOYnFpcGFvQmNmc0JlYUlwZ0pPa0N4cjZJ?=
 =?utf-8?B?Vm1Ud3NoZHRQVWtnYUgzQmczM29lQ1ZpdzhQOFQralBOdmZLSDIwMzZSeEpI?=
 =?utf-8?B?aE10ZHFha1FJM09DMklpU1cxQWk0MUtNQ0hnL29MWFBOd1JqOWxRWVNZZm1y?=
 =?utf-8?B?Uk1JYzlHTWZoVWRkL2NLMVNONEYzeWtQY2RVSGh1Y2xWM0hrOFVSejkzUnF3?=
 =?utf-8?B?YnBKM1dZeFJmZUtucTVyMnV4VTlpdjJBbm1USGNkcHQrdEo0enNGODFRWnlX?=
 =?utf-8?B?SmJibFN1aE1RcTdTOE50aUFDUHdUSkdaMUxxTEhVekdLQkgwTUVuekhoZDE5?=
 =?utf-8?B?citKcityRDB4Njl2bStQRlQvczlaZzFuWUNENWNoaHljd2RMRmJkRnZXNFRm?=
 =?utf-8?B?ekxiZmxMRGd3blRZUmRoekFzMVVHdFBObVBiNzdRWlh5K3ZCNWVxVDhIdGdC?=
 =?utf-8?B?NzBuRnl4TE9RYkpFaHk3czJWQS9FemJ2Y3R4RGZoaFFWbXE5WHo3L3o2ZHRi?=
 =?utf-8?B?ZGhPVy9raXdtaFY5Smk3S09mOFZjV2JVTyszemVQbDRSbjVEdUZBQUtxNWpR?=
 =?utf-8?B?VWtraTRBMlcwTVNYWkhtYnJlK3luM0tvRDdVa3VoaktJeXZ5Q2k0a09wbC9X?=
 =?utf-8?B?TkNXbkxRQnNqVUthVWJQTVcyeFZCTkZSR29rMEZvNFNTZkFLNUN5OFhPZ2dw?=
 =?utf-8?B?MTI4SDEzV2JNekszQVNScXd0YlJuQ1Myb3hRTCtQVGlUQk1mM0JmWDI4Y2lM?=
 =?utf-8?B?UjVseEZHTUt0ekpsNHVGR3hYazRkU2lvejJQTzQ0MHNGYW1VaUhHTG80cDFD?=
 =?utf-8?B?QzdhbTZTM2prVFh5MUV0MFlHdTRFMGlhcXA2NEVReDdpcTNHN3UzcUJpL0Fj?=
 =?utf-8?B?dWgySnNrdU53STFjODR0czU0QStaTjFZWDlPSE9qMkx2YnB5UDM2Ym9mZDg0?=
 =?utf-8?B?NmFVR2l0OWZKeG93SVV1V3dqanY4bVFNYzJhR0J0dFFHczA3emREVDhjWjJv?=
 =?utf-8?B?NTJiYmxML256VTBjTm04b0xYVTlpLzJCeHV6U294NVpPNGZWblQwQWZBdDls?=
 =?utf-8?B?M3pNb0YrZXVzbEVKb3M0UUFRUnZ5TXdwdDZma29yUGx0dzZObURLL203Z2Vl?=
 =?utf-8?B?bmdPZDhhM01Zc0FlVGdpWFRtcXhkQVRESmNKaU1Ea2lwMTlYN2liaE15Q1Mz?=
 =?utf-8?B?NG1FU2VRd05QcmFyOFFjQy9vNkxHS3ZTdEhObE5oTHJNZ2dsVzZhdzYxcWYx?=
 =?utf-8?B?cnJPbGljVjUyQ2VhUWt4dUlGbExnMkZHRFRzOFI1YlZzaGljM2xWSU81ampF?=
 =?utf-8?B?SEtrcElhT0haWlBtMVJydEJ5bHM3K0dnSDZValFHdHJCN2xkTUxBWmFWak41?=
 =?utf-8?B?Um50SEE3dEJRdjYyTWEvSUM0L1MxZFhDdjVFMlFUQi9yVDNSaXUxOHYvTGxo?=
 =?utf-8?B?SHZ2S0ZZNlBBWXRFNzdSb2pCdEVCZEdsN0hCRDJadVFqVmpPYm9veFNNRVpy?=
 =?utf-8?B?elBJUkROUUVDT29OWHR6bW5sdjh6NEg4ZFN1UUhKSCtCZnJjbmU4OHB3VUJh?=
 =?utf-8?B?YlJGVGFPM2hOMEI1QU9jalhOYmRnL0ZSZksrOXI0Vkd0Y1hLQm1KdlJkdnhp?=
 =?utf-8?B?bnAwSmhvQ1BDS3h5MUZFSFdJc3gxREo0aXRZT3ZaMDZvblFIN0F2M2xsZ1Rm?=
 =?utf-8?B?Q1dYczlmaDdwbk9BODhKWSt0V1JYQ0ZRaEdlSkYzUGoxMUdHZnd4NCtoTUpx?=
 =?utf-8?B?UDdTQzZ4a01LdDY2MHJheWFyUXNGN0YvR1pzRWlMZE53Zm9BYVNXQzZEVkpR?=
 =?utf-8?B?OURyVmpQdGh1dC9rZjVGTUV6UDUvbkFwS2ZGUHREa1Y5NE9hQnFQUXNhQUxm?=
 =?utf-8?Q?y5qA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a103a173-365f-41e1-bd7c-08dce7b2c969
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 16:03:44.8993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzpgOEfowgRjAoHYFDsKG7/NJXKMsQV+5md1K4/DJ6tGjHixj+ziknnkn5O7Ey1FLvncIYYIj4wYU2O0FKKBpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFOTVVHQU0sIFNSSU5J
VkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9j
dG9iZXIgOCwgMjAyNCA5OjUxIEFNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdB
TSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IEpvc2hpLCBN
dWt1bCA8TXVrdWwuSm9zaGlAYW1kLmNvbT47DQo+IEthc2l2aXN3YW5hdGhhbiwgSGFyaXNoIDxI
YXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXgNCj4gPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gZHJtL2FtZGtmZDogVXNl
IGR5bmFtaWMgYWxsb2NhdGlvbiBmb3IgQ1Ugb2NjdXBhbmN5IGFycmF5IGluDQo+ICdrZmRfZ2V0
X2N1X29jY3VwYW5jeSgpJw0KPg0KPiBUaGUgYGtmZF9nZXRfY3Vfb2NjdXBhbmN5YCBmdW5jdGlv
biBwcmV2aW91c2x5IGRlY2xhcmVkIGEgbGFyZ2UgYGN1X29jY3VwYW5jeWANCj4gYXJyYXkgYXMg
YSBsb2NhbCB2YXJpYWJsZSwgd2hpY2ggY291bGQgbGVhZCB0byBzdGFjayBvdmVyZmxvd3MgZHVl
IHRvIGV4Y2Vzc2l2ZSBzdGFjaw0KPiB1c2FnZS4gVGhpcyBjb21taXQgcmVwbGFjZXMgdGhlIHN0
YXRpYyBhcnJheSBhbGxvY2F0aW9uIHdpdGggZHluYW1pYyBtZW1vcnkNCj4gYWxsb2NhdGlvbiB1
c2luZyBga2NhbGxvY2AsIHRoZXJlYnkgcmVkdWNpbmcgdGhlIHN0YWNrIHNpemUuDQo+DQo+IFRo
aXMgY2hhbmdlIGF2b2lkcyB0aGUgcmlzayBvZiBzdGFjayBvdmVyZmxvd3MgaW4ga2VybmVsIHNw
YWNlLCAgaW4gc2NlbmFyaW9zIHdoZXJlDQo+IGBBTURHUFVfTUFYX1FVRVVFU2AgaXMgbGFyZ2Uu
IFRoZSAgYWxsb2NhdGVkIG1lbW9yeSBpcyBmcmVlZCB1c2luZyBga2ZyZWVgDQo+IGJlZm9yZSB0
aGUgZnVuY3Rpb24gcmV0dXJucyAgdG8gcHJldmVudCBtZW1vcnkgbGVha3MuDQo+DQo+IEZpeGVz
IHRoZSBiZWxvdyB3aXRoIGdjYyBXPTE6DQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4u
L2FtZGtmZC9rZmRfcHJvY2Vzcy5jOiBJbiBmdW5jdGlvbg0KPiDigJhrZmRfZ2V0X2N1X29jY3Vw
YW5jeeKAmToNCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vYW1ka2ZkL2tmZF9wcm9j
ZXNzLmM6MzIyOjE6IHdhcm5pbmc6IHRoZSBmcmFtZSBzaXplDQo+IG9mIDEwNTYgYnl0ZXMgaXMg
bGFyZ2VyIHRoYW4gMTAyNCBieXRlcyBbLVdmcmFtZS1sYXJnZXItdGhhbj1dDQo+ICAgMzIyIHwg
fQ0KPiAgICAgICB8IF4NCj4NCj4gRml4ZXM6IDZmYzkxMjY2Yjc5OCAoImRybS9hbWRrZmQ6IFVw
ZGF0ZSBsb2dpYyBmb3IgQ1Ugb2NjdXBhbmN5IGNhbGN1bGF0aW9ucyIpDQo+IFN1Z2dlc3RlZC1i
eTogTXVrdWwgSm9zaGkgPG11a3VsLmpvc2hpQGFtZC5jb20+DQo+IENjOiBIYXJpc2ggS2FzaXZp
c3dhbmF0aGFuIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+DQo+IENjOiBGZWxpeCBL
dWVobGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4NCj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0g
PHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiB2MjoNCj4gIC0gVXNlIGtj
YWxsb2MgZm9yIHplcm8taW5pdGlhbGl6YXRpb24gKE11a3VsKQ0KPiAgLSBSZW1vdmUgYnl0ZXNf
d3JpdHRlbiBjYWxsIGtmcmVlIGp1c3QgYmVmb3JlIHRoZSByZXR1cm4gc3RhdGVtZW50Lg0KPiAg
ICAoTXVrdWwpDQo+DQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5j
IHwgOCArKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcm9jZXNzLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5j
DQo+IGluZGV4IGQ2NjVlY2RjZDEyZi4uMTg2ZmM0ZmQzYmU4IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMNCj4gQEAgLTI3MSwxMCArMjcxLDEzIEBAIHN0
YXRpYyBpbnQga2ZkX2dldF9jdV9vY2N1cGFuY3koc3RydWN0IGF0dHJpYnV0ZSAqYXR0ciwgY2hh
cg0KPiAqYnVmZmVyKQ0KPiAgICAgICBzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnByb2MgPSBOVUxMOw0K
PiAgICAgICBzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQgPSBOVUxMOw0KPiAgICAgICBp
bnQgaTsNCj4gLSAgICAgc3RydWN0IGtmZF9jdV9vY2N1cGFuY3kgY3Vfb2NjdXBhbmN5W0FNREdQ
VV9NQVhfUVVFVUVTXTsNCj4gKyAgICAgc3RydWN0IGtmZF9jdV9vY2N1cGFuY3kgKmN1X29jY3Vw
YW5jeTsNCj4gICAgICAgdTMyIHF1ZXVlX2Zvcm1hdDsNCj4gKyAgICAgaW50IGJ5dGVzX3dyaXR0
ZW47DQoNClRoaXMgd2lsbCBnZW5lcmF0ZSBhIGNvbXBpbGVyIHdhcm5pbmcgc2luY2UgYnl0ZXNf
d3JpdHRlbiBpcyBub3QgdXNlZCBhbnl3aGVyZS4NCg0KUmVnYXJkcywNCk11a3VsDQoNCj4NCj4g
LSAgICAgbWVtc2V0KGN1X29jY3VwYW5jeSwgMHgwLCBzaXplb2YoY3Vfb2NjdXBhbmN5KSk7DQo+
ICsgICAgIGN1X29jY3VwYW5jeSA9IGtjYWxsb2MoQU1ER1BVX01BWF9RVUVVRVMsIHNpemVvZigq
Y3Vfb2NjdXBhbmN5KSwNCj4gR0ZQX0tFUk5FTCk7DQo+ICsgICAgIGlmICghY3Vfb2NjdXBhbmN5
KQ0KPiArICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPg0KPiAgICAgICBwZGQgPSBjb250
YWluZXJfb2YoYXR0ciwgc3RydWN0IGtmZF9wcm9jZXNzX2RldmljZSwgYXR0cl9jdV9vY2N1cGFu
Y3kpOw0KPiAgICAgICBkZXYgPSBwZGQtPmRldjsNCj4gQEAgLTMxOCw2ICszMjEsNyBAQCBzdGF0
aWMgaW50IGtmZF9nZXRfY3Vfb2NjdXBhbmN5KHN0cnVjdCBhdHRyaWJ1dGUgKmF0dHIsIGNoYXIN
Cj4gKmJ1ZmZlcikNCj4NCj4gICAgICAgLyogVHJhbnNsYXRlIHdhdmUgY291bnQgdG8gbnVtYmVy
IG9mIGNvbXB1dGUgdW5pdHMgKi8NCj4gICAgICAgY3VfY250ID0gKHdhdmVfY250ICsgKG1heF93
YXZlc19wZXJfY3UgLSAxKSkgLyBtYXhfd2F2ZXNfcGVyX2N1Ow0KPiArICAgICBrZnJlZShjdV9v
Y2N1cGFuY3kpOw0KPiAgICAgICByZXR1cm4gc25wcmludGYoYnVmZmVyLCBQQUdFX1NJWkUsICIl
ZFxuIiwgY3VfY250KTsgIH0NCj4NCj4gLS0NCj4gMi4zNC4xDQoNCg==
