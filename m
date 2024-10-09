Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B49FCEE325
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 15:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2080510E774;
	Wed,  9 Oct 2024 15:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BbSX1cMt";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6604C10E774
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 15:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1fnp5u2nGOv7DHg2KJhBp54sglHSuGW9qhPfTCbOarYUb2nOUgWW3pqCjGzDTAG4l1a2fCsilYeVScEXfWepl0Ul6SMpvSxPb5DxYZc06J2IThtfUU8CNmcHuebcsI3HFfdCKAiBgrd6WU/7yUbdGaRqoJoiFCys6EG4P6WLuVuE17T9mxeq88S+AHVWwRSxzCbJNi64MnRxtpaLblzSiC232m0/AM/fWwQLd42bGRvKQCCityc19rPNgU4ElXDOKwjLhN/gQpuPyx6qCFMA5neNX7dVVRAl7lOoM24hLrTVM0XnRv9LWAGqyFpXoFUBJDthjgtD1S+m1olXjZgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4kgbTaSqMgTTwG9wNIY8gVPJdFWpGXp6WjFCswXdPM=;
 b=OUtG4oWHVlsPrDl1+GFTxioLkm+tq5QmlNfPXtrYYwjwuuEJDNHSyMNDPlgP0eQclmWTGcD9v+Sqr4hisFvy+ttu6zGxr5OIi+LUrM0cETu3ie6vOXChvvvnnBdCtEKVG5zhI/50JgNgQyKOQQhdJ/jbjs804dgHmtv71ZEACRtVyr/gVDHztoCly90yL/PdHGrMYhHrnqXSWTEgahX8UR4ZlryT+cDM2brJX8krpR/JhYIjPVeeGVF1wnVWMbxunqh3waUOwA6lKdjtbAkWTi7fg0SvFLR14DGNuMryjRF3FgjlvEygB4Npt/coWE/j8Qtrwmi13BF9U+73B2GkIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4kgbTaSqMgTTwG9wNIY8gVPJdFWpGXp6WjFCswXdPM=;
 b=BbSX1cMtdzuq6jxj/mNZSPJJNzkXRs4vdEoLQzyw0AUFCukmb0wdmUYii//+B7ltVrcupZTccLHg0JVFuKHr0o8uUtOswyENzCXyoxb4dy1i7dBmaucd1krtiOXSgnQuCASFaAwc3U5fXZxw6vLoTIAV9Q7uo1HgoOzXaHzWaLk=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 15:37:28 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 15:37:28 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v3] drm/amdkfd: Use dynamic allocation for CU occupancy
 array in 'kfd_get_cu_occupancy()'
Thread-Topic: [PATCH v3] drm/amdkfd: Use dynamic allocation for CU occupancy
 array in 'kfd_get_cu_occupancy()'
Thread-Index: AQHbGf1f3AOobZuLp0eQjpFjgwiie7J+i4/g
Date: Wed, 9 Oct 2024 15:37:28 +0000
Message-ID: <BL3PR12MB64251D240BDE002B9DCB4E0DEE7F2@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20241008135108.108253-1-srinivasan.shanmugam@amd.com>
 <20241009034231.366002-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241009034231.366002-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fabfad4b-903d-47c1-bf99-711d6e0988a7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-09T15:27:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|MN2PR12MB4078:EE_
x-ms-office365-filtering-correlation-id: e9ad0967-df77-40d7-d197-08dce878482e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SVFCL0lmT3JRQUJzRmVpWkQwbUwzRlR4VWlaZEJkYWtFZ3ZCQktvRmJscnc0?=
 =?utf-8?B?cFNobEJ6QksrVXhDZlJsWjhJZTF6bGUxcnVTV2wvbXI2d3ZmajZKTHVZLytR?=
 =?utf-8?B?Nmlob2JrNm8wT0N0aGJZMDFNMzB2bDE1VHV0ZlQxY0tDMzZoVWJyVGRsRlR2?=
 =?utf-8?B?NjNzUDJTejRyd0FMQksyREZMZzBlbmE0aTVnK0ROOGVLMStGdVBudyt0K2ts?=
 =?utf-8?B?V3JFS0NLN2UrWHJOZ1V6aTduTS9DbmthdDZSdUFaa3I4SXptMW5kSHRTRnpB?=
 =?utf-8?B?NitQLyt2aW5VVjNRNHF5OGRzam9uTk0zQkRSM2VMNEJnMUE0NGViZzUzQXVm?=
 =?utf-8?B?b3RFd0FDM3ZrZENVRFloVHdpUUlQVXVGYXd4b0s0by8wcUE1dUgrU1dMVU1O?=
 =?utf-8?B?dHZuQ1RHZ2hwRkdKc3ZVTnFSWlh6OXZEMmYvME1mZVc1eVd4ZUNycDgvOCt2?=
 =?utf-8?B?YVAyQjRrcEh1TVMyWXVDS2oxWWdYeXVZRHZkcXRmTEJOT3VVcFpjaER0aEFq?=
 =?utf-8?B?UHAvMG9KUml3Y01wTU1LWGdIQjdtVnFLclo0Nzk4UE9tN1prL2ZDa25Xd3Bq?=
 =?utf-8?B?amo3RTltM0dUZnVvV1BMeEMySldhM1lqQXNObm1LQlA5cGlwYjVRUW1vVU9O?=
 =?utf-8?B?Nlg4YjBscXBySkV3TUd2bTFYMWRJQnNJSXA3UVFHcEtoOEo3ZElpUGNPN2Fk?=
 =?utf-8?B?SlVPYmtOaWhnRzcxMG5FYzVOVzBkbk5qZ2RDOVJzTDFaQi9JMlM5YnMvUDVv?=
 =?utf-8?B?RU56WFgvT0J0QUxScmNzbWJtK0RReUk1TzcvemdFdGEyM1h3Smk3bGJZdmtx?=
 =?utf-8?B?MXlCSmp1dG5oRU5KenkwM0hOTS81QTVoQ0trQWoweUFqS0NXemthdnVER20v?=
 =?utf-8?B?L3FjdlhrV1QrYnU2QjJ2OHl1MXBHMXlDaDdHMGgxaG1mcktPcHBPcVBzNkxQ?=
 =?utf-8?B?c0ZRQUlvTWg3NHRJaWFSTkZybUFjbUxxaWRHdGtCUWhnUmp4a2hWMjJJMDR2?=
 =?utf-8?B?Q1VEZzFEU01yM0J3SFh0ekZQSFlmSTlETGpNazE5VXlVZTJ1NUE2N2dEWCtD?=
 =?utf-8?B?dGU1U2hzejg0aFY1WVpaRjM4R0JrbkZseTY1V2IwSEx0S0NoTW43dFc4bXZx?=
 =?utf-8?B?c2xPbTVyRitTeG9mU2ZJUU90Lyt6VXN1c0xSUGlSL1hiTlpSN2ZaRkJaYkE0?=
 =?utf-8?B?QUVpV2NpOUd3Zjh4bENrRW0yV0dyVkdGMzBLVi9jZGExU29tQ3Fqbkk5S3ZN?=
 =?utf-8?B?NTEza0FpSWxCYlRoaDgvczQwT0JEUnJ2SzlROWcxOXZiYk1jczFCcVJLRXNC?=
 =?utf-8?B?a2NRNC9xRFNyRkp0d0NqVUVMdlIvYzJoZHhBU1JpcVN0NGRRUzNTZldxUGNs?=
 =?utf-8?B?bks5dko1MmRYNnR4aUhDaDQxUnBCRVRweDRBVll4eDdab0dRdFUreTcrbGM0?=
 =?utf-8?B?bCthc3lYbTF5VDZBUXdiZmFxUG5hRkRBTlpMVXVYTnZUcDhITSsvM0pKZEdZ?=
 =?utf-8?B?Z1hLUzVxcm50WmcwMjJJNmJlbGFJSFpsQUh4V0dxbzdnMmwrQktPVC9tcFRB?=
 =?utf-8?B?VTNsZVcwK25ma1JYN1pvY2VZdkl1OUFlQXlRYk1ObW1VVStUbUN0c1ZGeEwx?=
 =?utf-8?B?TE5zaUJkRTBwRk51a3lIMWVIb29JZ0lsN29IQ0VIK2dYTlJ5MTlCT3Bmdm43?=
 =?utf-8?B?TWw2WGFlNWRncUluSk4vS1VLaUp1Rlc2Nkpic2dnM1Y0dGlaUGtwS3p6dnJW?=
 =?utf-8?B?aWdRUTh5dDQ1ZnBQODdVQjE0T1lMNU11OUVJZHJ0NlZvUmVGNlV1cFNjT05N?=
 =?utf-8?B?M2VEZEZqbXZpSTZqTzB5Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUJnOVpYa1dRZEJHc2EyNEhkemJVNHRsVCtVWVUwZVhZYi9iMldrQzJSNlFh?=
 =?utf-8?B?Tk9Jc29JaVZBQitTQW5VSnRYWnJBcGprNTVrMEQrTFdoMU9NV1psR0tuZTN6?=
 =?utf-8?B?enRvdVFMOXlELzZOSkl2WkVkM1FTdDY0cDBqS2FmOGpoWnBpNGh1ODJya2FQ?=
 =?utf-8?B?Uzhnc1BOUzUrL3dhYW1tYzk2YkJQNnY5VFZtS28vZmJ1NlhkQVpBNnVZOTRt?=
 =?utf-8?B?bThRb05rbGwyVjN5WWpJcU9hdGJZQXYvcDEyeGRIekM3OWxwUVF3RDJNS0tj?=
 =?utf-8?B?YjFnZmIrQ0MwY25JL1pVZWFqeWtVUFBaUEdnd2N0THJXZWM1NWtuSVJUYXNa?=
 =?utf-8?B?OXVmQ1JGc2o3TUE1MHQ4ODczK3Rwc09ZaTBRTGlJaEw2T3phZ1daU29CeTNj?=
 =?utf-8?B?Q1BqVzkrZkJRTXl1ckNDNDB1cU1za3dMZmhiTndkTkovREczZGEvcHNIVlVK?=
 =?utf-8?B?MTRGc28yZVZnVGJ3Z0V6UDFCZUxHOTJuNkYrSUhpTHd6dHdFQi9hTlVKWG85?=
 =?utf-8?B?MEpiU2ZRazhhYWxyRzljY3JvamtFUS9WYzNML3cxRGk4dFdZTG5UNm96OXhJ?=
 =?utf-8?B?bDdoMXR1Q3RVYUtROEFkOVlCQjBwajcrN2ZDNXJMV3FVa003OEgxWlV4aFVa?=
 =?utf-8?B?NFJZSGdTcHZVYnc2QThsSXJVOHpKd3cwbDdhOE5qSlJCNTZGb1hsT255eHVn?=
 =?utf-8?B?NVIrWUVNb01XY3V4NTBDZm93S0lQT1hIdE9KVG5CLzlEc2RyclhyV3Bub2Zu?=
 =?utf-8?B?RTZOTGZmUUp6MkM1dDRnb0ErNzI4clY3MVg4dWczNXpreG1FbVRSY2xzQ0pH?=
 =?utf-8?B?Qm96bnUrZ3BNWXlrRzVKUmFac1JLbUpqN0FLakFacTJPWUorbTJUVFpuWWtM?=
 =?utf-8?B?eURPVUhQQjNYY3FaeTFHbVhJNWwzVEVDak84ZjduTVNEUnVNeVVHVE9WRjJY?=
 =?utf-8?B?VXNjSG1MVDV1UlN5bWxuMC9mOHZ0cjJvbjI5azVqS0FjTUJqUGZydFlkTzdW?=
 =?utf-8?B?K2FJOG5yUGQyMWk0clFZSVBhVklnTWdkckNBcE80ajNROGtvcVhHQWRmdUR2?=
 =?utf-8?B?blVHT3B4OFQrTFp0bEJWM3hwM213dnpOVjBIUU1aWmdMVDNGN1dKS0NPRjlS?=
 =?utf-8?B?L3BWWDFYNVluQ2ZuN1NMd1grZTc1MGphQUVyUVp5cUxiVnNFRE9pemxXQUp4?=
 =?utf-8?B?VkorL0lIcDZHWWFEbG9SLzAwcUtBNEM2OU1HQVZkN3cyRE9jdGM1Zk9TZzdS?=
 =?utf-8?B?OHJlNWlCVkxuYjFPeEVXSUJaY1dGM2N2dUFod1IyeHhvWndPVVVEL1ZvWjF1?=
 =?utf-8?B?TWNiMXdmQzJBcHBpekgvN3NrOEhmVHZldTJuMFlUTnEvbm5uODZHdGtUa25E?=
 =?utf-8?B?cjVVZFcrT2xVWUs3WHVDS2tlVXhSeFR0WUdMQzc1bUVUcFdTR2V6VFoxWnc2?=
 =?utf-8?B?aDl3VndNU0RyaG9ScXdrQmlHWmRaTEt0azlwbXBGM1o5bzhrODUxcnMwOCt0?=
 =?utf-8?B?OHNrbVBxUVo1RE5tOVdrb1pETnJsVkNjTXdUWmxvaHZyMk1uZ0dUV1NiOVov?=
 =?utf-8?B?WDV3V25XVXF5ZFNHSitreGVrNGJFbEJUSGlFazBQSkY1RXh3MndxbFpvRTJL?=
 =?utf-8?B?dkVFNmJ5eFZOa2VTaVhkYitYcUdBeVNlSlJGeFNkd2Q4cTVpMG9UUytKUXdM?=
 =?utf-8?B?cWEyM0RDQ1dMSzhORm0yWG42MnRNVnlvL1JNSjRXV3U2bk53ODdkRE1QRTI3?=
 =?utf-8?B?d1ltQ0ZmYlBkS2hQaTQ0TTRpSk9MMHFaWStGTzZLYjZiVUU2QzZmRFpuOFQv?=
 =?utf-8?B?RTJhNHNtci9zZkkvMFpqSWxYbmg0T25ndkNxMkY3R2VjekdCM1hZVzJ1MlBU?=
 =?utf-8?B?YVpsZ0piOGN6UHFKOU5xUEVMMmx5bHdPWnFrRTUrb3psTkR3cG9SMEYwZkdB?=
 =?utf-8?B?TUNuVE1qYUViN1EweVFTWnY4dENTSnF6RmYwOVhOdk9SUTlFYUhWTmY1UkpB?=
 =?utf-8?B?OWIwUHJ0YVZjVWgwbnplWVNEV3h6YWhmWGo1TFdDY3ZOM1ZiNng5TVZPeUVU?=
 =?utf-8?B?WnBuTUdRYk9taWNsREowMXRHVVZYZ1dsbWNyMUR5cGt3T2VqNDZGa08yMnFv?=
 =?utf-8?Q?od24=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ad0967-df77-40d7-d197-08dce878482e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 15:37:28.4100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hnywk4lascA+rYdfQbki1VImkjj+DVQaiNvm2SXvjPDJnDmLdduARPksGid+Tk6c0FHkZZySRw7IIGORLWPsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
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
dG9iZXIgOCwgMjAyNCAxMTo0MyBQTQ0KPiBUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVH
QU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBKb3NoaSwg
TXVrdWwgPE11a3VsLkpvc2hpQGFtZC5jb20+Ow0KPiBLYXNpdmlzd2FuYXRoYW4sIEhhcmlzaCA8
SGFyaXNoLkthc2l2aXN3YW5hdGhhbkBhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4DQo+IDxGZWxp
eC5LdWVobGluZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjNdIGRybS9hbWRrZmQ6IFVz
ZSBkeW5hbWljIGFsbG9jYXRpb24gZm9yIENVIG9jY3VwYW5jeSBhcnJheSBpbg0KPiAna2ZkX2dl
dF9jdV9vY2N1cGFuY3koKScNCj4NCj4gVGhlIGBrZmRfZ2V0X2N1X29jY3VwYW5jeWAgZnVuY3Rp
b24gcHJldmlvdXNseSBkZWNsYXJlZCBhIGxhcmdlIGBjdV9vY2N1cGFuY3lgDQo+IGFycmF5IGFz
IGEgbG9jYWwgdmFyaWFibGUsIHdoaWNoIGNvdWxkIGxlYWQgdG8gc3RhY2sgb3ZlcmZsb3dzIGR1
ZSB0byBleGNlc3NpdmUgc3RhY2sNCj4gdXNhZ2UuIFRoaXMgY29tbWl0IHJlcGxhY2VzIHRoZSBz
dGF0aWMgYXJyYXkgYWxsb2NhdGlvbiB3aXRoIGR5bmFtaWMgbWVtb3J5DQo+IGFsbG9jYXRpb24g
dXNpbmcgYGtjYWxsb2NgLCB0aGVyZWJ5IHJlZHVjaW5nIHRoZSBzdGFjayBzaXplLg0KPg0KPiBU
aGlzIGNoYW5nZSBhdm9pZHMgdGhlIHJpc2sgb2Ygc3RhY2sgb3ZlcmZsb3dzIGluIGtlcm5lbCBz
cGFjZSwgIGluIHNjZW5hcmlvcyB3aGVyZQ0KPiBgQU1ER1BVX01BWF9RVUVVRVNgIGlzIGxhcmdl
LiBUaGUgIGFsbG9jYXRlZCBtZW1vcnkgaXMgZnJlZWQgdXNpbmcgYGtmcmVlYA0KPiBiZWZvcmUg
dGhlIGZ1bmN0aW9uIHJldHVybnMgIHRvIHByZXZlbnQgbWVtb3J5IGxlYWtzLg0KPg0KPiBGaXhl
cyB0aGUgYmVsb3cgd2l0aCBnY2MgVz0xOg0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8u
Li9hbWRrZmQva2ZkX3Byb2Nlc3MuYzogSW4gZnVuY3Rpb24NCj4g4oCYa2ZkX2dldF9jdV9vY2N1
cGFuY3nigJk6DQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2FtZGtmZC9rZmRfcHJv
Y2Vzcy5jOjMyMjoxOiB3YXJuaW5nOiB0aGUgZnJhbWUgc2l6ZQ0KPiBvZiAxMDU2IGJ5dGVzIGlz
IGxhcmdlciB0aGFuIDEwMjQgYnl0ZXMgWy1XZnJhbWUtbGFyZ2VyLXRoYW49XQ0KPiAgIDMyMiB8
IH0NCj4gICAgICAgfCBeDQo+DQo+IEZpeGVzOiA2ZmM5MTI2NmI3OTggKCJkcm0vYW1ka2ZkOiBV
cGRhdGUgbG9naWMgZm9yIENVIG9jY3VwYW5jeSBjYWxjdWxhdGlvbnMiKQ0KPiBTdWdnZXN0ZWQt
Ynk6IE11a3VsIEpvc2hpIDxtdWt1bC5qb3NoaUBhbWQuY29tPg0KPiBDYzogSGFyaXNoIEthc2l2
aXN3YW5hdGhhbiA8SGFyaXNoLkthc2l2aXN3YW5hdGhhbkBhbWQuY29tPg0KPiBDYzogRmVsaXgg
S3VlaGxpbmcgPGZlbGl4Lmt1ZWhsaW5nQGFtZC5jb20+DQo+IENjOiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2Ft
IDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KPiAtLS0NCj4gdjM6DQo+ICAtIFJlbW92
ZSB1bnVzZWQgImJ5dGVzX3dyaXR0ZW4iIChNdWt1bCkNCj4gICAgZml4ZXMgdGhlIGJlbG93Og0K
PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9hbWRrZmQva2ZkX3Byb2Nlc3MuYzog
SW4gZnVuY3Rpb24NCj4g4oCYa2ZkX2dldF9jdV9vY2N1cGFuY3nigJk6DQo+IGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1Ly4uL2FtZGtmZC9rZmRfcHJvY2Vzcy5jOjI3NjoxMzogd2FybmluZzog
dW51c2VkDQo+IHZhcmlhYmxlIOKAmGJ5dGVzX3dyaXR0ZW7igJkgWy1XdW51c2VkLXZhcmlhYmxl
XQ0KPiAgIDI3NiB8ICAgICAgICAgaW50IGJ5dGVzX3dyaXR0ZW47DQo+ICAgICAgIHwgICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+fg0KPg0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3Byb2Nlc3MuYyB8IDcgKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9wcm9jZXNzLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJvY2Vzcy5jDQo+IGluZGV4IGQ2NjVlY2RjZDEyZi4uNDVmZTc1MDc4YjczIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMNCj4gQEAgLTI3MSwxMCArMjcx
LDEyIEBAIHN0YXRpYyBpbnQga2ZkX2dldF9jdV9vY2N1cGFuY3koc3RydWN0IGF0dHJpYnV0ZSAq
YXR0ciwgY2hhcg0KPiAqYnVmZmVyKQ0KPiAgICAgICBzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnByb2Mg
PSBOVUxMOw0KPiAgICAgICBzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQgPSBOVUxMOw0K
PiAgICAgICBpbnQgaTsNCj4gLSAgICAgc3RydWN0IGtmZF9jdV9vY2N1cGFuY3kgY3Vfb2NjdXBh
bmN5W0FNREdQVV9NQVhfUVVFVUVTXTsNCj4gKyAgICAgc3RydWN0IGtmZF9jdV9vY2N1cGFuY3kg
KmN1X29jY3VwYW5jeTsNCj4gICAgICAgdTMyIHF1ZXVlX2Zvcm1hdDsNCj4NCj4gLSAgICAgbWVt
c2V0KGN1X29jY3VwYW5jeSwgMHgwLCBzaXplb2YoY3Vfb2NjdXBhbmN5KSk7DQo+ICsgICAgIGN1
X29jY3VwYW5jeSA9IGtjYWxsb2MoQU1ER1BVX01BWF9RVUVVRVMsIHNpemVvZigqY3Vfb2NjdXBh
bmN5KSwNCj4gR0ZQX0tFUk5FTCk7DQo+ICsgICAgIGlmICghY3Vfb2NjdXBhbmN5KQ0KPiArICAg
ICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPg0KWW91IG5lZWQgdG8gZnJlZSB0aGlzIG1lbW9y
eSBmb3Igb3RoZXIgcmV0dXJuIHN0YXRlbWVudHMgaW4gdGhlIGZ1bmN0aW9uLCBmb3IgZXhhbXBs
ZToNCiAgICAgICAgaWYgKGRldi0+a2ZkMmtnZC0+Z2V0X2N1X29jY3VwYW5jeSA9PSBOVUxMKQ0K
ICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KYW5kIGFub3RoZXIgImlmIChwZGQtPnFw
ZC5xdWV1ZV9jb3VudCA9PSAwKSIsIG90aGVyd2lzZSB5b3Ugd2lsbCBsZWFrIG1lbW9yeS4NCg0K
SSB3b3VsZCBzdWdnZXN0IG1vdmluZyB0aGUga2NhbGxvYyBjYWxsIGp1c3QgYmVmb3JlIHdlIGRv
IHdhdmVfY250ID0gMC4NCg0KUmVnYXJkcywNCk11a3VsDQoNCj4gICAgICAgcGRkID0gY29udGFp
bmVyX29mKGF0dHIsIHN0cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2UsIGF0dHJfY3Vfb2NjdXBhbmN5
KTsNCj4gICAgICAgZGV2ID0gcGRkLT5kZXY7DQo+IEBAIC0zMTgsNiArMzIwLDcgQEAgc3RhdGlj
IGludCBrZmRfZ2V0X2N1X29jY3VwYW5jeShzdHJ1Y3QgYXR0cmlidXRlICphdHRyLCBjaGFyDQo+
ICpidWZmZXIpDQo+DQo+ICAgICAgIC8qIFRyYW5zbGF0ZSB3YXZlIGNvdW50IHRvIG51bWJlciBv
ZiBjb21wdXRlIHVuaXRzICovDQo+ICAgICAgIGN1X2NudCA9ICh3YXZlX2NudCArIChtYXhfd2F2
ZXNfcGVyX2N1IC0gMSkpIC8gbWF4X3dhdmVzX3Blcl9jdTsNCj4gKyAgICAga2ZyZWUoY3Vfb2Nj
dXBhbmN5KTsNCj4gICAgICAgcmV0dXJuIHNucHJpbnRmKGJ1ZmZlciwgUEFHRV9TSVpFLCAiJWRc
biIsIGN1X2NudCk7ICB9DQo+DQo+IC0tDQo+IDIuMzQuMQ0KDQo=
