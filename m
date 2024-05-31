Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2551C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 01:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0926510E888;
	Fri, 31 May 2024 01:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TKofFyff";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7724610E4CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 01:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCxN6LgBqwv094RcBIMY/By5yDHJEYZLTCAZqygxk8o+Ne3dh34P149ft+mtiLBt4y7xQ8NEo2qC5GI/QDTK1IAuFMHZybxR/jTOfyCiP/kSJdUQvh4/sodmY1ap3RAw6yclT+Gq/d54NYOMS2Kz0Kf834ryGiyDP74wjreRURCOmyFLcfPaV6nSrfF6fe/KzyqJR1vVyVOYUaYqGMKSWz5LTpnCq2aa9KqBvFSiqR2Y1WqZeO95O8DS1yBMeWHSavZ/+4MGy7Z4MlbI9zHJn2ZrH/wSlkQ4UfpMiIpV60AS5l3WnNU9IiVxiir26YZRPyUMhUC+n10B4cbwGviKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkpYJU5QSuuH7k8FdDSL/ZuLCGGXr3ON9+vCz/B7i44=;
 b=kOFzdCHI0AD/FK2TWXw09rUmq3d5fJUqoRinT8UpqidN4tFz+F7Jv5tIfOQhGaN6UJ6Va4uvFFont0H3clmxS7RCvlURalKkh2DDlYtZhaTTYVT7zzOhdV7AAgmpyO7rFrZeNGV+Z4qjeh2X4dHoUdVDSNoo/NqB4GvM88HpMh1xZEMoePYowUMSEUEvD3e6+tvMLD5BDec4mObRBvAt47SVR7qaXE/5T9YP+fRKizEzp6BcKCB+qsMxvqFEiA9UP5TItbZjTG+fUBap48/nPQF7eq1CzjAcbnl2Q7UI76/fng34QltOG1kZgaLzjRV19ZDVoS6dh8cGdGdaqwm/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkpYJU5QSuuH7k8FdDSL/ZuLCGGXr3ON9+vCz/B7i44=;
 b=TKofFyffKtyUL7ZgvocPivmfhW8u1+VviAOZ9g8OXMELTuhygtktABg4ylfR22cscosysBpEZcDJFqG4uSto/iBhvsBHPL4GD/UBdl2IeSyJA4LWWN3hnwAGYqhaI0rCxAgKdvY7HG7lEnTG5UWSpxdAaxftdbZDEmBbcYvI18M=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 01:44:27 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 01:44:27 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 8/8] drm/amdkfd: remove dead code in
 kfd_create_vcrat_image_gpu
Thread-Topic: [PATCH 8/8] drm/amdkfd: remove dead code in
 kfd_create_vcrat_image_gpu
Thread-Index: AQHaskSfjitr7JyzTk+8OxVKWHAtOrGwPcoAgABVCAA=
Date: Fri, 31 May 2024 01:44:27 +0000
Message-ID: <DM4PR12MB51525ED43423A5B57D5BCC97E3FC2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240530035048.2341626-1-jesse.zhang@amd.com>
 <68258e83-6172-4755-94a2-a623cde6f8f9@amd.com>
In-Reply-To: <68258e83-6172-4755-94a2-a623cde6f8f9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2c64c64d-8475-4569-a250-5458bf7b3f0a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-31T01:41:38Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS7PR12MB5863:EE_
x-ms-office365-filtering-correlation-id: 081c5deb-93bc-4c7f-b2d8-08dc811334f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Zm14YU1JbWZRTlVqTU9WbEVMQVVjeWl1OXMyVHJZNy8xYU5ZazFOdWFYSjA1?=
 =?utf-8?B?cHVPa2J4RVNjRTFWMVpFaWpLQnIvM2hXT1FraGhZSmY5UXNiN0NGaXZDdUgw?=
 =?utf-8?B?b1RsR1NHOGIrTXUrWWN4eSthb1ExWW5RUDZvWDdIMCtMd0ZJb2Q0M29GdW9m?=
 =?utf-8?B?NmpONHlNcVlLWUo4Nkl6YWVJbFZBVDN1RGlINFZNYWp1R3BBMkNQWVpoWncv?=
 =?utf-8?B?b0VlWVVDWm1wdWhlaTN1bGdDUjBBeGx5SDR5QzlDNEY2VGJKVzlaNld4dDJr?=
 =?utf-8?B?VW1nL0l6Q2ovbnJPSE02UHcwcXVUOWN0K1h1U3RMNkNiSUFEOUpRRjliZ3Yw?=
 =?utf-8?B?RTV0c3gyYkJJdWl2RWwvdXV5L1RrUnpvYXpRUFc4c2lPbjR4RS84bDVQVVlF?=
 =?utf-8?B?WDM2OHR0MkVXTklRdytCV3FHOE5HVFNCL3lzZ25UeFJvYUxHQWlYT1NPQjd6?=
 =?utf-8?B?NTg2elRZK3hDYUtQcURkckU5dWxiLzRMQUtxeU5rUDVkN0pLOHJuM3pyOGEy?=
 =?utf-8?B?YVhRVzJtTDhGUnEvSnlkWUwvMkloV3RQczBnZEtoczRwRXNteEdZNXdVU3Nn?=
 =?utf-8?B?RWdsa0UxenphVEwyNDc0MGtEdGh3MkFiYmdXNHNmRyt2bHh0aCtoUmlzZXJh?=
 =?utf-8?B?K1pUY04vZGk1Zk1RMVlJaC93MGNza2FUYXFsQUN6WGtBamhTWGp1RFJncXJn?=
 =?utf-8?B?alZ2N3M0TGVFdnZjcUhtYlk4dWd2V2RjRWJCcVA0VzBLUzJuZFVlenFvTzV2?=
 =?utf-8?B?ZUNTNUVYamRSR0tia3FBZDlCM2xmaU96RFBidENqYUplajNPQnNNWFBVR0ZB?=
 =?utf-8?B?emdOZGtST3YveDhUWXBRZzVGa1JLOE8xa243a2E1bkhRZ0cvM1F5RDZpd0hR?=
 =?utf-8?B?RjRNOXMyZzA1VFVnckp4eVZITm1HcTd2ZDNoTWQ1UTYyUkVJWTdHMyszL2VF?=
 =?utf-8?B?eGtkTk1pVVhMMHEveml2dkdqdndGQnUxaFVCUzhXdHFvNmJmYnI3T2FlOVIz?=
 =?utf-8?B?U2FHN3lDTFRYbHBpb01yV2RaWTF2S0xnK0xpeFpIQlBRU1JWL01LamkrT3A1?=
 =?utf-8?B?SDJXY3ZqUnVwVXRITUEzL1ZGZkJ3Q3Vxb2Y0aHI0b0puMENtNXpZMDlaeU0r?=
 =?utf-8?B?NklGOXlPdGt5TjVGU1R0OVBrcEVKZmJTcWo4TGd0VEtZbUJrZFdqVk9YN3lk?=
 =?utf-8?B?Q1ZwcHMrME5mN0U3ekxQWHZ1eURPK1IybVJRdk5VZ2Zua2lLdSttOHR0ZTdF?=
 =?utf-8?B?VjJ0R3dNWUxia2VHaVRrK0l4ajVRSEYwOXZuY3FhbXBzQWVYUk9ITkFFSkt6?=
 =?utf-8?B?VFN5SDYwaG9TYnUrQldHYmtWbzhIMVJKUExkS1IyNUVyVmF3aTdLbnJ1TlNz?=
 =?utf-8?B?M3h5Z3hFTDJIZHV3VFNaMVNZbVNxd0Jhd2kwM0xIa0ZxQWFiZEhBODNtOGRE?=
 =?utf-8?B?Z013Y3dyM1BPQ3J2ZUZrU1p0NElyTjJpMFMzbHdvZStweUxRRjhrOG9hU2U1?=
 =?utf-8?B?YnlySVNsTU1EL1BwTTJNR0hjVUFwdzVVbE0yeHJJWW9lMlJObDFKY1hFZWh1?=
 =?utf-8?B?alJhR0t2Z2tUM1JPbWNwMmNVY1FhRDROcGg2VHZmb3BMblBSV2x3SVk4b2hP?=
 =?utf-8?B?L1RQRUFLYTVyZ1RxcXdzNXoxVUhMbTJuUTY0dThLTURKeDJoNUUyU05TbEh6?=
 =?utf-8?B?c3NDWDEvWWNFZ2FmREQzMVM2NVpLSEFoSEF2YThMTEUvN3BlT2pLdmhFam8r?=
 =?utf-8?B?QWRCQmlaMjgwdGEvcHBzdEkraFB5VnF0WVdDV3hMZmN5YlNxVWtVTjRBUC9n?=
 =?utf-8?B?UTVkODI0SFhYWWpJQmJoZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlBjRmNpRm50VmUweDljc3B4OWwxTlpVYjZqVVJYVWt4NDF6Yko0d0Nma0p2?=
 =?utf-8?B?c3MzNDRlWTZvVDNCT21aYXpkZ2V5RDNOa0pvQXRYbkQvbU1VVCt0YW1Fejlt?=
 =?utf-8?B?ZEo3eXdDU0M2Z2N0ZmNNQURrcENqUlZ1T3VMVHRocXEyc05WeGVxcUdSWEtm?=
 =?utf-8?B?MnBaMTdDaXBKTlloZUVId3R3NklwZUc1MGNnclFmbWFRcVlGLytkNnAzaWRn?=
 =?utf-8?B?eEFWUWx4Y25OM000Y1RpMzJLb2U5ckg3THcxU2FNMW9CUmhUVEFQb0xVaHdH?=
 =?utf-8?B?ZEJEMjZuZVJJckcwM2xaclpXcmxKVFBMc2ZqZmlaVmovOTB5bVRWL3dzUWto?=
 =?utf-8?B?Y2RPb29aQ3A1RWYrRmtQbXFEMEVVaVhqQzlSWFdFSVpQeWoxeDR5Z3JkM1J3?=
 =?utf-8?B?UG00aU4wMzRhOFlaSlV0SVBuYWhUamI2aHBnZnBKSmQvYVJPVk1TWVhXcUlI?=
 =?utf-8?B?bHgyMGs1S0Zuc2xJM1g2Ykx1TXpIV1hnR0pQYUEvekFUYUdTNW11Y0Ntb2pT?=
 =?utf-8?B?NHlrcDFkSDl4emNJN0xjbldERW1xbFpYMWhRQXEzY0lyNEU4L3VVWXM0TUkv?=
 =?utf-8?B?ampCYXNURTF0NE9jZm5PV3RCOW1xa3hGdXhOWmdvQk1TbEtJL1FBMTRGNnRD?=
 =?utf-8?B?SWRMb09JM3RQWXpncncyc0FQVnE5WHVrTmZkcEZwRGZ1bUEyQjJqcnQvdFE2?=
 =?utf-8?B?c2c5ZkpGZEZSczMyVVdpUm05MWI2MllCRW9jVGZkbXBDNjNwb3BuVzVKZzN4?=
 =?utf-8?B?ekNzaXNkdEttTllBQnFEYW41OVBONnRrUGQvRk5TalkyUlk0bmVYVHB4dDA2?=
 =?utf-8?B?YUdJV0k4MHVlMlN5N09RTEIzWFF2dHVCcHgxKzhramV0SHNOTjNib0YvSzE5?=
 =?utf-8?B?MHc4QmZaUC9KSnQ2RTJoc0tGOTZCcDB1SmpOaWFZU3hPUEVKNEhqWHZQZWxo?=
 =?utf-8?B?SnMzR1loWHh6QVNUN0tBTkdCbWZGZ0dGdWY4YVpGbHIrdnhLSVY4VUJlc2xW?=
 =?utf-8?B?U2tqbUkzR0NLVDBqTDNocUZyUnVTVjVVZ3BtYTh1ZWtoemU1TWtEVTlycXBV?=
 =?utf-8?B?b0tiR1JOTzR6UEpkOWJIOVNQUW44TUtxTWpSVEp0aE1IYWZsY1pFQWtVWFlC?=
 =?utf-8?B?Ri9PVTZKeVoyUmhmdzVpTm9wTCtYdkNnNnBjUEY5WTlzb3k4ZUxNV004djZx?=
 =?utf-8?B?WHVrOGV4ZXBNZ3pOMFl1c1c4ZXdiMlhFMEs5aWpxcm1OK0x3QnRnZ1k4ak5Y?=
 =?utf-8?B?dVBoOG1IUEd1RnJ4U0NSSVVGc2pycmpxN1d0U2piV0gzQUFMOWdNa3BKS0gw?=
 =?utf-8?B?SGlrVDRJSDBWN1lSYmdnZnRoalBrVDQ3ODhqVW5ZV0I5OWlBV0RTK0htaW0w?=
 =?utf-8?B?M05HRzgzTVU4elBhQjV2TkVkUzNIWFFhSVVFS1Q1TWFiejliQ1NQK1owUkJ0?=
 =?utf-8?B?OUNxWEloUnpXWTRlbTIxdGJYNUxFTUxRYzdWY2o1ZFNqeXRjUzcxU3dCdnJC?=
 =?utf-8?B?SFpaa1pBcnNwTnRvYU8wK0ErbmNLS2RkaC9kdVd6dnRYVUMwNVdRRVJOOVVV?=
 =?utf-8?B?emovZHBFRVk3R2pDSGxYUThWOTR1V0tXQ0xYbmlpK3VHV3dNeVVkZ1B3c0x3?=
 =?utf-8?B?WnJYcWk3bFh1MzlucXQ4UllqekdocFowWGpFNWVLbUgxOHU4aGczNUxEWUc1?=
 =?utf-8?B?L2lzVmFpNzhFNTVoYlV0c1A2eit2UWdvZXB3WE5DWTdBeGNLSjd0MVFTOFZv?=
 =?utf-8?B?WnpLbXZranowb0JDRWc3NlVPRndaR00xTVg3dGU4anM1L0xLQmRxZFBhTUpO?=
 =?utf-8?B?bzhsdzR1dHRpamdDMlpOa1pIc3J3UnkzZXVKWENtYU85ckNWUDFhYmJweHNw?=
 =?utf-8?B?d3pwQWxuMDdGQTk2d29BQS96Q2w0SEl0QUIvaERaMWpKVTZvNmM2ZDNNcXIw?=
 =?utf-8?B?Q2VuaTNTQ1d5WloxVjBoTWx5enNldlJFaXRCVUlmOVpOT2dyT1JpUjhYc3pO?=
 =?utf-8?B?eFhxVm1SejVlckR4V2JPQnlFUEszVG8ydTlDZkplRWFQL1JSR25YdmowVjRF?=
 =?utf-8?B?S2NnVEJHWmhQVlY3VXlkanFCckpmTExFY29CZVVldDRnWUI0eUJ1Tjh5TFc0?=
 =?utf-8?Q?ayTY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081c5deb-93bc-4c7f-b2d8-08dc811334f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 01:44:27.2380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13bwNLOCxxchOKn7Tb8fLMROLs3tMeGz4Ni2LO45qSgQ+xnmxVEnrRo88gjI6LPZCBdvCBFQx2u93CjztqNlAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863
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
Cg0KSGkgRmVsaXgsDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLdWVobGlu
ZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQpTZW50OiBGcmlkYXksIE1heSAzMSwg
MjAyNCA0OjM3IEFNDQpUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+
OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+OyBLaW0sIEpvbmF0aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNvbT47IEh1
YW5nLCBUaW0gPFRpbS5IdWFuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCA4LzhdIGRy
bS9hbWRrZmQ6IHJlbW92ZSBkZWFkIGNvZGUgaW4ga2ZkX2NyZWF0ZV92Y3JhdF9pbWFnZV9ncHUN
Cg0KDQpPbiAyMDI0LTA1LTI5IDIzOjUwLCBKZXNzZSBaaGFuZyB3cm90ZToNCj4gU2luY2UgdGhl
IHZhbHVlIG9mIGF2YWlsX3NpemUgaXMgYXQgbGVhc3QgVkNSQVRfU0laRV9GT1JfR1BVKDE2Mzg0
KSwNCj4gbWludXMgc3RydWN0IGNyYXRfaGVhZGVyKDQwVUwpIGFuZCBzdHJ1Y3QgY3JhdF9zdWJ0
eXBlX2NvbXB1dGUoNDBVTCkgaXQgY2Fubm90IGJlIGxlc3MgdGhhbiAwLg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBKZXNzZSBaaGFuZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYyB8IDYgLS0tLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2NyYXQuYw0KPiBpbmRleCA3MTE1MGQ1MDNkYzcuLmVhZDQzMzg2YTdlZiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jDQo+IEBAIC0yMjEzLDkgKzIyMTMsNiBA
QCBzdGF0aWMgaW50IGtmZF9jcmVhdGVfdmNyYXRfaW1hZ2VfZ3B1KHZvaWQgKnBjcmF0X2ltYWdl
LA0KPiAgICAgICAgKiBNb2RpZnkgbGVuZ3RoIGFuZCB0b3RhbF9lbnRyaWVzIGFzIHN1YnVuaXRz
IGFyZSBhZGRlZC4NCj4gICAgICAgICovDQo+ICAgICAgIGF2YWlsX3NpemUgLT0gc2l6ZW9mKHN0
cnVjdCBjcmF0X2hlYWRlcik7DQo+IC0gICAgIGlmIChhdmFpbF9zaXplIDwgMCkNCj4gLSAgICAg
ICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gLQ0KDQpBdmFpbF9zaXplIGlzIHBhc3NlZCBpbiBm
cm9tIHRoZSBjYWxsZXIgdGhyb3VnaCB0aGUgKnNpemUgcGFyYW1ldGVyLg0KWW91J3JlIG1ha2lu
ZyBhbiBhc3N1bXB0aW9uIGFib3V0IHRoZSBjYWxsZXIgaGVyZS4NCg0KW1poYW5nLCBKZXNzZShK
aWUpXSAgYXZpbF9zaXplIGlzIGNoZWNrZWQgYXQgdGhlIGJlZ2lubmluZyBvZiBrZmRfY3JlYXRl
X3ZjcmF0X2ltYWdlX2dwdQ0KYW5kIGl0IGNhbm5vdCBiZSBzbWFsbGVyIHRoYW4gVkNSQVRfU0la
RV9GT1JfR1BVICgxNjM4NCkuDQoNCiAgICAgICAgaWYgKCFwY3JhdF9pbWFnZSB8fCBhdmFpbF9z
aXplIDwgVkNSQVRfU0laRV9GT1JfR1BVKQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFM
Ow0KDQoNClJlZ2FyZHMNCkplc3NlDQoNClJlZ2FyZHMsDQogICBGZWxpeA0KDQoNCj4gICAgICAg
bWVtc2V0KGNyYXRfdGFibGUsIDAsIHNpemVvZihzdHJ1Y3QgY3JhdF9oZWFkZXIpKTsNCj4NCj4g
ICAgICAgbWVtY3B5KCZjcmF0X3RhYmxlLT5zaWduYXR1cmUsIENSQVRfU0lHTkFUVVJFLCBAQCAt
MjIyOSw5ICsyMjI2LDYNCj4gQEAgc3RhdGljIGludCBrZmRfY3JlYXRlX3ZjcmF0X2ltYWdlX2dw
dSh2b2lkICpwY3JhdF9pbWFnZSwNCj4gICAgICAgICogRmlyc3QgZmlsbCBpbiB0aGUgc3ViIHR5
cGUgaGVhZGVyIGFuZCB0aGVuIHN1YiB0eXBlIGRhdGENCj4gICAgICAgICovDQo+ICAgICAgIGF2
YWlsX3NpemUgLT0gc2l6ZW9mKHN0cnVjdCBjcmF0X3N1YnR5cGVfY29tcHV0ZXVuaXQpOw0KPiAt
ICAgICBpZiAoYXZhaWxfc2l6ZSA8IDApDQo+IC0gICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07
DQo+IC0NCj4gICAgICAgc3ViX3R5cGVfaGRyID0gKHN0cnVjdCBjcmF0X3N1YnR5cGVfZ2VuZXJp
YyAqKShjcmF0X3RhYmxlICsgMSk7DQo+ICAgICAgIG1lbXNldChzdWJfdHlwZV9oZHIsIDAsIHNp
emVvZihzdHJ1Y3QgY3JhdF9zdWJ0eXBlX2NvbXB1dGV1bml0KSk7DQo+DQo=
