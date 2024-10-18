Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900D4D2FFE0
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 09:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D6589FC9;
	Fri, 18 Oct 2024 09:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FD1yNUAV";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379E489083
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 09:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymjzdTlkqaxrhyMCfuP1nll6C0+e0MSpaP+y8SzQp+ALrVW+13Hv/amH9MvXH/4K01t8llP79Ruy1i9mmD/vIBEUiOC+MmuzYX01suaGC46K0D3dgsLkClmZcfSy7zkR9T+9la3qPTCQ/SjCJ/i5Rf9IsfWpdNOSMaKfXbqh1ejMr+tiYBQ1WgmFeLLR3lg88PU5t2Cmo7KYFAsuTbu4fi8aXmM+qZy+GDcYmWGQWXV/BTTUHJ4IkK3cUQ9kZQ6L6VSdkppTlCiMRmfUX/U4WXl+JWk5/tcE1LL2dA2Ufp4fIEkuXhenbecxDtVpnkzjSTgB0xJDEOqfqdVksT5yrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vS76//W87Be26fyhbPPMmRK0fTq+1t+/9cR73Z/jKg=;
 b=sdprLDwIRsZ3Kx8XII+Jd5vuU1Kgu+OZ6/KSrP7DusC8HSD/wfM85JQP5fxjSB8Dhlq44MGCgZU5JXXK37vn4mfVv5n//mgAHmKYuw/dmTWowPn1WbIBmUdxxSl5aSIaBZBK9tfVnNXqN53EqAlXwdavWxYU7OeAsDsh3hNKHt3zKldRmQsvYWdZOhJ6R73A0b/9ZaoH17Nfrf6DTpm2UrgxYycw6F7dcBBoNpXVzVJv7/8SmBbkOuXx6m+LD+CpiF4K8DO5pKMy0tTgQfJfUqJumqGA6oncUdGJL8mwRk3FZDTKeLyxqGlhMGpdCA2Ve5gk4AJQoUIOv26bNxOOAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vS76//W87Be26fyhbPPMmRK0fTq+1t+/9cR73Z/jKg=;
 b=FD1yNUAVXIz3u0FUnhyPy8KkXH0irOxGvyGGMn+CoA9WuyBrn7o8ow3T5FIrnh2eaDEj7VpmlwS3KyZ2NbDCiRKl9Zq0MsdeKm+BKAaaEuDhIo784oxBqPxgM5yP0kIbU2XNdM+nT+qvZqin/Z3W/o+8y34MntBc4XISvHNDCCI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 09:33:54 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 09:33:54 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add the command AMDGPU_INFO_QUEUE_RESET to
 query queue reset
Thread-Topic: [PATCH] drm/amdgpu: add the command AMDGPU_INFO_QUEUE_RESET to
 query queue reset
Thread-Index: AQHbITZ78nLSJKSgn0SfcL7oyimFy7KMMiuAgAAMQhA=
Date: Fri, 18 Oct 2024 09:33:53 +0000
Message-ID: <DM4PR12MB51521F1CA0607071EE23EDC8E3402@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20241018081934.2185681-1-jesse.zhang@amd.com>
 <5963f22c-eba6-4c9a-a341-a5a1b6d45f37@amd.com>
In-Reply-To: <5963f22c-eba6-4c9a-a341-a5a1b6d45f37@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=18ced63c-dc4b-4a6b-9b7e-689f78191704;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-18T09:30:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MN2PR12MB4208:EE_
x-ms-office365-filtering-correlation-id: ba1fdbda-589f-469a-7eb6-08dcef57fb77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VlN5QVlIZVIvWFJKSTRUcFQvamo0T1plUHBIWGtnYzREUG1XTWFUOVVUTy8v?=
 =?utf-8?B?czFkM3dHYndIaEd4TndDRE91RWF0UHM0N3VSY0lWM0VuVUc4bnN6cVFoK25Z?=
 =?utf-8?B?bm8xZUVXV2xFekFEeFJFZWRLa0RNWUoxT21mb2oveE14akNhazJWOThKck9q?=
 =?utf-8?B?RWtZdUVzak9WTXVMVFNDOUNZTW0rQ0ZhWE5TaGR4NVJ6QUlNLzRFd1JkcW1i?=
 =?utf-8?B?ZXVxM3hMUklmdjZicEVPUEgwc3JqODB2c216WExWNkNwSk9CRlFBUjRoZ0J6?=
 =?utf-8?B?Z2hES0hzR2R5Y2U4QThNSEVYVFVyZkdmRmIxRDJHd0VsOWU5ZERWNnowNlNP?=
 =?utf-8?B?emZyZzAyY0J1NDE4SERxaXF4NDFMY25PQUxibEpVN3hlM3F1WlhQTFFJYStH?=
 =?utf-8?B?VWhHZENySjFrY3VSZEhaaWtVdW9WZ09EeTlPQmo2OEllV2hUS1hwK0crTTl4?=
 =?utf-8?B?c0M1dE1lQXEyeTF3OGRkZlRneE1KMzRFKzFEWE1UZGpDSVZTZTlWS1pPd1R1?=
 =?utf-8?B?aksvS0QxaXRGWTdHMWVDSXNwMFBxWWMwK3FtYmFtUVpIQVNOSElEbk14RTBs?=
 =?utf-8?B?cFlxMExOT3RiM2VTQzBNZHBSRURxTDU2S3Q0aWZDQ09OcXVGOUJzQjBrczFY?=
 =?utf-8?B?cTg5SVhoei9yOGc2Z2ltMGFTYnBSc3loelVSMjBybzJONDh0ZEN0Qy9lZ1JY?=
 =?utf-8?B?TFN1dGJvNnFhZ2pBZWxBY1lFbFZZYTh2Z1ZscjNxYkIrTk1TQ1pRN1ZLM3do?=
 =?utf-8?B?WWViSVRPeTBac2ZKanpFSmtMZ3lFbWpKa3ZWS0FFdlNuOEtmbmwvUXFud2pD?=
 =?utf-8?B?K0xGV1NVcEdBajNMdE9QSG96dWtBZ05iMGlNcWp1ZzVLR1ArOUowUmxCem51?=
 =?utf-8?B?aElocS84MENzZWhBMXJLSVlWWHV2RS9naVZZdHVxM3lIU2FzdlV1UGk0M2c0?=
 =?utf-8?B?V1VoOWU3L3N2aTB1aVZNRmJ1M1Y3ZkN1L05QZVFXTktKUzJyLzJUU0haWVVD?=
 =?utf-8?B?cFRkSVNXQ2lab3VYRmdsNzQvQ1MxZW95SEt3a0RjQ0ZzZkNEOTFsNkgrNmR0?=
 =?utf-8?B?NVhObzkwVG5CdTVMNkU3MWpxM0JhZ2Y1VGlkdDVNWkVhWmZYcXFHSGFsTXha?=
 =?utf-8?B?dWFGWmx5dnExM1V6Z255TW5QUTlVMzVLN281OEJpVFhqbGZiVUFJL0M5bkRG?=
 =?utf-8?B?aktab0V3OVNrd1I4V0Jjem5kL0wxbnlnQ25JL1pTS3Q0LzNVUzlBbWdPczhG?=
 =?utf-8?B?UnYrejRGZjUvVTNXb3IxRDhnNmxZMGZaN1gwem01TVNsZ3BidC9iZkhJV25C?=
 =?utf-8?B?SnBEaWpUUlc0MU82SUtnYUpmdm9GRXV4Y0lyZlNzMWNtM0NNSHU4enNtYTlo?=
 =?utf-8?B?bGNGK2k2NnFiQUc2TUxVdG9NOEtERUsrWGxIbllWa0tKd0hIcnBHSTVGQm1k?=
 =?utf-8?B?ZHc4b29RdDFGaFdWL1FqVGhON3lPMUVpSnRpM0NCa3NFZ3J5SlExYmdETVJD?=
 =?utf-8?B?cG0xY0ZiZ25DWGkxMS9oVjV6U3UvejV1NmxtQkxSZ3UrQXNucFF0Rlo3bHJ3?=
 =?utf-8?B?eW1nNXlXcUVTa2NmcHlPaFp0SGpLRDI1U1JzSTArTDJCT2c0TUoxeWtpRWR6?=
 =?utf-8?B?cSsvVi9PSlZaVDJXcTlhSkd3WHAyTWtnY29FcFhWd0JpNUZhSTJISzNEcEgz?=
 =?utf-8?B?am8zWVN3bnlPZlVzQ2xCVnREL3dkckY1eW8walpRV01NUFZzZDRlcWZ1dUts?=
 =?utf-8?B?MzJlMTVQdmFFazRleTRScE9BMVRERWJrbklqV1lBd1F1WVFMbXpKclM0VlBS?=
 =?utf-8?B?eVdLNWpNbGdHWkFIaEt5cFlRNHZDVCtzZkR6am1YbDFkVzFJMXE2TkE2bTRZ?=
 =?utf-8?Q?SkcUF/U49QXpY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDNXUDFxU3RzMUhBaFBFRitXUTV4cnpCZ0treFZBei9LN1d4UXBJNWdGem9N?=
 =?utf-8?B?bTlUTWhQWWRxOEx1UTZhejc1bGx3eFJLalZpNDd5aUZtQk1FYnllMWl2Qyt3?=
 =?utf-8?B?ajFIYkFpcEtMbkVqUzdKUUpIOVUzV3pROTQyTGtQZEFwWjhNV1dMMTFmV256?=
 =?utf-8?B?TUdtSVdXazNGUjJSMC9Pd0RNanVwUHFhMG1mclFsT09IU28yQm9QNWxvUmY0?=
 =?utf-8?B?VC9WT0t4c1REd2ZkYzgzNGFoNlh0S1lMVjA2TkxlS25aamdCR2NJQWE3RzFF?=
 =?utf-8?B?NE5QWkloYW9Wamk0VjhVL1IreldNY0xUVHJ2STZyVzlWYmhZMkdUUTdLNUl3?=
 =?utf-8?B?eTU3TmVxYlBDcEtaVE9PalRWMXNudDFSTmVQSUxNa0dSRElLOWIzVnMyQ2lQ?=
 =?utf-8?B?M3huS29hbnNwNWZRK0MzV0VMUnpaaUw5T1QvcFg2M2FUNkFuVEg1VnJlaXA0?=
 =?utf-8?B?RlBXQ0N3aWxxa2E0SnkvZXNSQ2I0ZTFyS2lOaFV2UDJGNjBTM3ZNcnhjMzJZ?=
 =?utf-8?B?OFBwbVg0RFY2d1M2a1UwUi96MS9zS0ZidGtlMHhtZjVScDZibVZyK29GUFRE?=
 =?utf-8?B?YmtxdXR5NFBBY3g5V1I4dmxwR2VBOHhITUgvSnlLRDR6dHJSUjlFaXd1dGJv?=
 =?utf-8?B?ZVJmb1BKdmpMUldRYk9xNkJydExINFpQRllFcEJCc2dKUGFoVkVSNlhBRzd6?=
 =?utf-8?B?ZUJsWEhscmQvS3labTJRT2EyaTBUcDVSVExzajFnYmJRRm94L1RyQURRRjVk?=
 =?utf-8?B?bjJJMlg4MHJibGxNRFpRR0xxakhFS2VMOWk1cVNSZXBBZWVsN1hBS0hyWWhK?=
 =?utf-8?B?K25CUnYvTHdaU3l6VVB3M1NrYlA0b3czUW5hWnFlSU84cjQyRi90anNmeTJh?=
 =?utf-8?B?cmRoUjlBWVQ2OGxYN0owN2RhTzl3cU5rNUs1NHFqbXZHZ1MrVUEzQmF2VGtP?=
 =?utf-8?B?a2h5TXVOSXR0dmxDUG0vQyt2YkNPd25SbmNtdzdidlpyWlI4V3VoaDMrZXh3?=
 =?utf-8?B?NlhzK3RiR0xwTDV1UWhVREJZRG1sTXFzTlcwWFVleTR4akNsU1pud3NDVUtW?=
 =?utf-8?B?WVdKNENpRlp5T2Z1eW1zZUl6dUh0N2lMYklUdTJ3Q3ozUExpa3ljbVQyOG56?=
 =?utf-8?B?WFB0eEpWb2lxU1RGWWV4ZU0vaUdGMnAyb05xeFM3ZU96OTB1MC9nZ3NKbzJT?=
 =?utf-8?B?eHo3N1FyakU2Z2c5dEFBbUdGT0kwb3JCUjYyei9WQjhKcER5ditRbk5FRmp2?=
 =?utf-8?B?Z0dTekZLWHkwK00zNXoyemp2YldrZS9qSVBnTDdzOUR5bEYrM3Vsc2FBNnlM?=
 =?utf-8?B?SWFJSTZ6bmxhK05kWTFtbllud1o1QUc1SnZNcVZGWjJWVE01UUhnbTFpSm1K?=
 =?utf-8?B?ZmJNQytFdm9BZGtOTm5ZbHBtVDMraUlwRTVoYmpRdFJFUnhCNlFNQjBCMzJn?=
 =?utf-8?B?SVFHeC9EZWU3K0FCMTE4NFBKL2VvK3kwcGlQVjVIRVhIaDV1aXFSaHRKTVJo?=
 =?utf-8?B?NkNqTzZOZkNWTWdoNVo4Snd1cWh0OVE5cG1JdWF6cmVYQW1CWkJDRlRhWnRy?=
 =?utf-8?B?Mk9odG1uTnJPSkdEcnVKcW91QWVWNDcrN3BsaWJjcUtDRU5FaUJRSTEvZllI?=
 =?utf-8?B?dlhyNEpXQXZmMllVRnhsbVZHNGduaWdLRTJ5cDBianFNdFppNVZ4YkJyeDk0?=
 =?utf-8?B?K0lFQmJ6akJNRm1LWHRLeWZ3LzhYOENPa2JaSzBwck54eWtPditxMTNIeUpY?=
 =?utf-8?B?RDh5bUNSVjdRd2tiUWNJNElhbGdEeTl3T1pZdTZ3L1hLRlRldWdveVF2OUtR?=
 =?utf-8?B?WEJVU0l0TkN4b0VyUDVESGszSG1jOERXYUxXWnJZMEJCR3BBaU5mZk8ySndB?=
 =?utf-8?B?RjZZN3k1YzQveDY0M0J2Y1ViRUVOMmJiRzJlWER3OU5Gd3FQbUo2R242Rllx?=
 =?utf-8?B?K1crNGR5OVdXSS9UOENZbzRHV3pGcnQvZ2NWYmpPK0NvR2dESURVNkUybGdi?=
 =?utf-8?B?VVZsTDJQckhWVnR6eU0rN0ZUQlVBd1grZ0JsZ0VEa3hZd1pCOVpvcXNXUEhi?=
 =?utf-8?B?aXh2UEhoZEhqVGFOVG03b3QvSFRQeFJ5SFZiV21UbVpIRWdKTFR2RDJTMlNZ?=
 =?utf-8?Q?Z3kA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1fdbda-589f-469a-7eb6-08dcef57fb77
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 09:33:53.9751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FvQEJsVVUnc45DPXCC521Pmb1WSVwtcJTf9dsHAunQfg61OjcjxScOvF84bBL0wtTQ2f8HIJXRfQkr71LaRGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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
Cg0KSGkgQ2hyaXN0aWFuLA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IEZyaWRheSwg
T2N0b2JlciAxOCwgMjAyNCA0OjQ3IFBNDQpUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpo
YW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWRncHU6IGFkZCB0aGUgY29tbWFuZCBBTURHUFVfSU5GT19RVUVVRV9SRVNFVCB0
byBxdWVyeSBxdWV1ZSByZXNldA0KDQpBbSAxOC4xMC4yNCB1bSAxMDoxOSBzY2hyaWViIEplc3Nl
LnpoYW5nQGFtZC5jb206DQo+IE5vdCBhbGwgQVNJQ3Mgc3VwcG9ydCB0aGUgcXVldWUgcmVzZXQg
ZmVhdHVyZS4NCj4gVGhlcmVmb3JlLCB1c2Vyc3BhY2UgY2FuIHF1ZXJ5IHRoaXMgZmVhdHVyZSB2
aWENCj4gQU1ER1BVX0lORk9fUVVFVUVfUkVTRVQgYmVmb3JlIHZhbGlkYXRpbmcgYSBxdWV1ZSBy
ZXNldC4NCg0KV2h5IHdvdWxkIFVNRHMgbmVlZCB0aGF0IGluZm9ybWF0aW9uPw0KDQpUbyB2ZXJp
ZnkgcXVldWUgcmVzZXQuDQpOb3cgdGhlIGlndCB1c2VzIG1hbnkgYXNpYyBmaWx0ZXJzIHRvIGhh
cmQgY29kZSBpZiBxdWV1ZSByZXNldCBpcyByZWFkeS4NCkFsZXggc3VnZ2VzdGVkIHRoYXQgd2Ug
Y2FuIGdldCB0aGUgaW5mb3JtYXRpb24gZGlyZWN0bHkgZnJvbSB0aGUgZHJpdmVyLg0KDQpBbm90
aGVyIHByb2JsZW0gaXMgdGhhdCBvdXIgZHJpdmVyIGhhcyBhZGRlZCBjb2RlIGFib3V0IHF1ZXVl
IHJlc2V0Lg0KVGhlIHJlc2V0IGZ1bmN0aW9uIGlzIGNvbXBsZXRlIChhZGV2LT5nZnguZ2Z4X3Jp
bmdbMF0uZnVuY3MtPnJlc2V0KSwNCmJ1dCBmdyBwYXJ0aWFsbHkgc3VwcG9ydHMgaXQuDQpGb3Ig
ZXhhbXBsZSBuYXZpMzEsICAgS0NRIGludmFsaWQgb3Bjb2RlIGNhc2UgY2FuIGJlIHJlY292ZXJl
ZCBieSBxdWV1ZSByZXNldCwNCmJ1dCBLQ1EgaW52YWxpZCBwYWNrZXQgbGVuZ3RoIGNhbm5vdCBi
ZSByZWNvdmVyZWQgbm93Lg0KDQpTbyBmb3IgdGhpcyBjYXNlLCBJIGFtIG5vdCBzdXJlIHdoZXRo
ZXIgd2UgY2FuIHJldHVybiB0cnVlIGZvciB0aGlzIGZ1bmN0aW9uLg0KDQpNb3JlIGluZm9ybWF0
aW9uIGNhbiBiZSBvYnRhaW5lZCBmcm9tIHRoZSBsaW5rOg0KaHR0cHM6Ly9jb25mbHVlbmNlLmFt
ZC5jb20vZGlzcGxheS9BTURHUFUvUGhhc2UrMSstK1ZhbGlkYXRpb24rb2YrUGVyK1F1ZXVlK1Jl
c2V0K2ZvcitLZXJuZWwrUXVldWUNCg0KVGhhbmtzDQpKZXNzZQ0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBKZXNzZSBaaGFuZyA8amVzc2UuemhhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgMjcgKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiAgIGluY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oICAgICAgICAgICB8ICAyICsr
DQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj4gaW5kZXggYjUzYzM1OTkyMTUyLi44N2Rl
ZTg1OGZiNGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9rbXMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMN
Cj4gQEAgLTU3Nyw2ICs1NzcsNyBAQCBpbnQgYW1kZ3B1X2luZm9faW9jdGwoc3RydWN0IGRybV9k
ZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxlICpmaWxwKQ0KPiAgICAgICB1
aW50NjRfdCB1aTY0ID0gMDsNCj4gICAgICAgaW50IGksIGZvdW5kLCByZXQ7DQo+ICAgICAgIGlu
dCB1aTMyX3NpemUgPSBzaXplb2YodWkzMik7DQo+ICsgICAgIGJvb2wgcXVldWVfcmVzZXQ7DQo+
DQo+ICAgICAgIGlmICghaW5mby0+cmV0dXJuX3NpemUgfHwgIWluZm8tPnJldHVybl9wb2ludGVy
KQ0KPiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiBAQCAtMTI4Miw2ICsxMjgzLDMy
IEBAIGludCBhbWRncHVfaW5mb19pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpk
YXRhLCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHApDQo+ICAgICAgICAgICAgICAgcmV0dXJuIGNvcHlf
dG9fdXNlcihvdXQsICZncHV2bV9mYXVsdCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG1pbigoc2l6ZV90KXNpemUsIHNpemVvZihncHV2bV9mYXVsdCkpKSA/IC1FRkFVTFQg
OiAwOw0KPiAgICAgICB9DQo+ICsgICAgIGNhc2UgQU1ER1BVX0lORk9fUVVFVUVfUkVTRVQ6IHsN
Cj4gKyAgICAgICAgICAgICBmcHJpdiA9IChzdHJ1Y3QgYW1kZ3B1X2Zwcml2ICopZmlscC0+ZHJp
dmVyX3ByaXY7DQo+ICsgICAgICAgICAgICAgdHlwZSA9IGFtZGdwdV9pcF9nZXRfYmxvY2tfdHlw
ZShhZGV2LCBpbmZvLT5xdWVyeV9od19pcC50eXBlKTsNCj4gKyAgICAgICAgICAgICBpcF9ibG9j
ayA9IGFtZGdwdV9kZXZpY2VfaXBfZ2V0X2lwX2Jsb2NrKGFkZXYsIHR5cGUpOw0KPiArDQo+ICsg
ICAgICAgICAgICAgaWYgKCFpcF9ibG9jayB8fCAhaXBfYmxvY2stPnN0YXR1cy52YWxpZCkNCj4g
KyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsgICAgICAgICAg
ICAgc3dpdGNoIChpbmZvLT5xdWVyeV9od19pcC50eXBlKSB7DQo+ICsgICAgICAgICAgICAgY2Fz
ZSBBTURHUFVfSFdfSVBfR0ZYOg0KPiArICAgICAgICAgICAgICAgICAgICAgcXVldWVfcmVzZXQg
PSBhZGV2LT5nZnguZ2Z4X3JpbmdbMF0uZnVuY3MtPnJlc2V0ID8gdHJ1ZSA6IGZhbHNlOw0KDQpQ
bGVhc2UgbmV2ZXIgZXZlciB1c2UgdGhpcyBjb2Rpbmcgc3R5bGUuDQoNCklmIHlvdSB3YW50IHRv
IGNvbnZlcnQgYW55dGhpbmcgaW50byBhIGJvb2xlYW4gdXNlIHRoZSAhISBvcGVyYXRvci4NCg0K
UmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPiArICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+
ICsgICAgICAgICAgICAgY2FzZSBBTURHUFVfSFdfSVBfQ09NUFVURToNCj4gKyAgICAgICAgICAg
ICAgICAgICAgIHF1ZXVlX3Jlc2V0ID0gYWRldi0+Z2Z4LmNvbXB1dGVfcmluZ1swXS5mdW5jcy0+
cmVzZXQgPyB0cnVlIDogZmFsc2U7DQo+ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4g
KyAgICAgICAgICAgICBjYXNlIEFNREdQVV9IV19JUF9ETUE6DQo+ICsgICAgICAgICAgICAgICAg
ICAgICBxdWV1ZV9yZXNldCA9IGFkZXYtPnNkbWEuaW5zdGFuY2VbMF0ucmluZy5mdW5jcy0+cmVz
ZXQgPyB0cnVlIDogZmFsc2U7DQo+ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gKyAg
ICAgICAgICAgICBjYXNlIEFNREdQVV9IV19JUF9VVkRfRU5DOg0KPiArICAgICAgICAgICAgIGNh
c2UgQU1ER1BVX0hXX0lQX1ZDTl9ERUM6DQo+ICsgICAgICAgICAgICAgZGVmYXVsdDoNCj4gKyAg
ICAgICAgICAgICAgICAgICAgIHF1ZXVlX3Jlc2V0ID0gZmFsc2U7DQo+ICsgICAgICAgICAgICAg
fQ0KPiArDQo+ICsgICAgICAgICAgICAgcmV0dXJuIGNvcHlfdG9fdXNlcihvdXQsICZxdWV1ZV9y
ZXNldCwgbWluKHNpemUsIDR1KSkgPyAtRUZBVUxUIDogMDsNCj4gKyAgICAgfQ0KPiAgICAgICBk
ZWZhdWx0Og0KPiAgICAgICAgICAgICAgIERSTV9ERUJVR19LTVMoIkludmFsaWQgcmVxdWVzdCAl
ZFxuIiwgaW5mby0+cXVlcnkpOw0KPiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gYi9pbmNsdWRlL3Vh
cGkvZHJtL2FtZGdwdV9kcm0uaCBpbmRleCBkOWJmZjFjM2IzMjYuLjNiMTdkODJmZDFlZQ0KPiAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gKysrIGIvaW5j
bHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gQEAgLTEwNTIsNiArMTA1Miw4IEBAIHN0cnVj
dCBkcm1fYW1kZ3B1X2NzX2NodW5rX2NwX2dmeF9zaGFkb3cgew0KPiAgICNkZWZpbmUgQU1ER1BV
X0lORk9fTUFYX0lCUyAgICAgICAgICAgICAgICAgMHgyMg0KPiAgIC8qIHF1ZXJ5IGxhc3QgcGFn
ZSBmYXVsdCBpbmZvICovDQo+ICAgI2RlZmluZSBBTURHUFVfSU5GT19HUFVWTV9GQVVMVCAgICAg
ICAgICAgICAgICAgICAgIDB4MjMNCj4gKy8qIHF1ZXJ5IHF1ZXVlIHJlc2V0ICovDQo+ICsjZGVm
aW5lIEFNREdQVV9JTkZPX1FVRVVFX1JFU0VUICAgICAgICAgICAgICAgICAgICAgIDB4MjQNCj4N
Cj4gICAjZGVmaW5lIEFNREdQVV9JTkZPX01NUl9TRV9JTkRFWF9TSElGVCAgICAgIDANCj4gICAj
ZGVmaW5lIEFNREdQVV9JTkZPX01NUl9TRV9JTkRFWF9NQVNLICAgICAgIDB4ZmYNCg0K
