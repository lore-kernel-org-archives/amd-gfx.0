Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11615C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 08:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31EF210E1AE;
	Thu,  6 Jun 2024 08:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="igrTzNcY";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E85C10E1AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 08:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPUsGWoX4GgymP4f+uidSi/lYBDVxXfHTS5VacQ8lKqCD2e44Jlew5AHDwqOwAKM4JPcRdVvaSmfdezs1j0FMrPS+qo+4JTLqW/xJCQSXga0uCSqF+obCT0OHl4v02XleHH+3c7nc0oSAETPoNTpW6Bo8yl5Ij/kxwCqVchcJksJA3OFNy/P3Zt3eqYJSkOPG+SM/vSGkNm/NAD7fJW/3jooKL891JeuIoaVxk9/nsh4If1url7zQy2JRojXDUNxqsT4wXsePC0m0yskw0GiTDbpfyMBOTE0CUb19EesY1DEFohYlSohXG4mGeKTT5PjwfqIzvnbtGHRcDP5V6XUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4pGDm4Ds47EAoactINxfXwjJYdjdFqnJJErdRBXM+I=;
 b=F7nzNVntXIoqFRqdgxk1tqWBn2eQKkhmknbvNMjghuJfhN6qNBgYbD3lSE3WGYx6iGGslGwym8kqYLWFXpTUDR6Jfd/MUYjDtlxgL43jhVh3DRcoRyYoRCOn7Oji2wTtFXMIwUw3hymYyPAPGPEDHC+7zHviNH895ayCjFy+Rgrx9QX3oWIE4PVZOkbtgS9IYcqjaVyh8mJiSu+YsKijv3Wld/QW0m4PSg01AVQ99Zh3oCDS7gwvDlYI+oBrrP9vmB5Vy78Xwk9AU3jD0OXLYiQFcCzXtipUae1Fw2YbdvXg2JpZpN7veNaHV0H5sSgSiRCXgu5FeQu4m9Kqyhrnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4pGDm4Ds47EAoactINxfXwjJYdjdFqnJJErdRBXM+I=;
 b=igrTzNcYr+1xoulzqlEAjEw1Rem63wi57mCHZouRhHMTj8gmF6LcPNglMkluTLH82Ff7KDDfCkN3zUL3a/Iwq5faKQafOa5UP8aL8wRnLn5qVyIVeRhhgjz+UFBs1uV3d9m0mxaofIhyA8OumX1Ot5gwTXNebKuz1o2/kTzL5Uk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 08:15:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 08:15:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: tolerate allocating GTT bo with dcc flag
Thread-Topic: [PATCH] drm/amdgpu: tolerate allocating GTT bo with dcc flag
Thread-Index: AQHat+LWp1GlEx4xbkeTo7v7gt0MibG6YiZggAAAWrA=
Date: Thu, 6 Jun 2024 08:15:22 +0000
Message-ID: <BN9PR12MB525732C2989341E7EB9195C7FCFA2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240606072419.208126-1-Frank.Min@amd.com>
 <SA1PR12MB5659CC018E8890569BA55923E9FA2@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB5659CC018E8890569BA55923E9FA2@SA1PR12MB5659.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f5443746-f819-43bc-9f83-f6cf56878486;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-06T08:10:14Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN2PR12MB4488:EE_
x-ms-office365-filtering-correlation-id: 895b0405-6938-4f58-6422-08dc8600cfbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?YjdMdXo4VUVES2dkNm0zZEhUSHc2dGxqU2hzcmpLK3QvV2tuUTBsZGRhMlRC?=
 =?utf-8?B?TWhhanZ1TkxMUlRMcHdrYlhnQjJ1U0pWVTE2R2w0TjUwTG5UWjJhVXdFYkMy?=
 =?utf-8?B?ZHFMYkltZUZONkdTSlU3anZiZjFpbjQ4ZXhRVHh4ZVQ3dm9uRFdkRTFOaFI5?=
 =?utf-8?B?ZlpuT2wxcTNJdW1CUmFlQkRETnpML2RJVEZpcDlmM3FKTlJFZU52dkJRU1p5?=
 =?utf-8?B?aEpRbGN1dWg5VUFGNjNsY3RJK3dVQjhsQVNQNkNTWitIQ0FsNjN3TjljMzh4?=
 =?utf-8?B?V0JIU3VmSFVOK1NyaXZ3TlFDQTlwQkFOWEgxZXJFVk9iRWJ5Ym1FcjVoUm80?=
 =?utf-8?B?cFRaWUh6ZXlWZUlIL2J2T2FPVTFVdWlzcVB4MXF6UlN3aVFoUTBTZnZtYzRk?=
 =?utf-8?B?cFRtZzZodGJFRUs3dk5QVk04UjRhMzQvTUxsdW1waTN4eWEwMm5vZXpxK2Rk?=
 =?utf-8?B?M1ZuVFY5b0FmUThaWGdHdDJobWZUU2pDeWF1dE9FUVVhTWV2cnM5ZDVUVVhh?=
 =?utf-8?B?T3VDZ1FTOTlGMURjSTN2dEJLS0Ira1d2RzZCQmFSSG5LdXRyZGZZR1preUwv?=
 =?utf-8?B?dUw2TTI5c2dEZVQ2M3hKNW9DTGRvZ3RsekhDaWNkMlUxSHF1VnpqLzA3bUpl?=
 =?utf-8?B?YVUxU1NCSmQ4YVhNS1hvWDMvaFpya25qTlYxaDVBdk4yVEg4eXcveDAxOXNM?=
 =?utf-8?B?VmZvYmNwSWptVEdOOGNUcUxsSW9UU05YVlJwMDhrYStYak9wVm9oYzJiRVRM?=
 =?utf-8?B?WUhUWXFVYnk4VU0yQ1psM1g3djNBYzFxZFpRMmltZElORHNJaE5WQ2p5VjBh?=
 =?utf-8?B?elNubFhmUVhpeWh1azdHZklIU20rS0FOR1IrMWQ5Q2t6V3lNRC9qZjl5TndW?=
 =?utf-8?B?NU5jN2pxV2ExclljSXVCT0xKWDV6dFpYMStqLzRReTFxN3BNUWpPUVdnMEFC?=
 =?utf-8?B?THNvN01WY0NVMWpOdWhPd2RpUlV4aXA3cVJ4RHB0bjZFS1ZyM3hkZHhIaTRn?=
 =?utf-8?B?T04zY3ByeFU1Zk1CMktiUHFTTFdHR29lSnZNaXpKbG5LTkFaa3p6cENvanY2?=
 =?utf-8?B?djErckp1VTE3SDRKSkFBVzlFV0c4akFrZXRFK2FnUGZVVDJKbU5RVU9CK2k0?=
 =?utf-8?B?bkRjT0ttd0EvL0xpRWRvM0xGdllGeURJZVhkdEpnSlRBMFBlZmM5NUxtMFk1?=
 =?utf-8?B?Y0RWdFJhMWduYnowRDlQUlV2aFFLbTZ4ME0zbGxBYjlrZHhhcFQwbW51ZzBV?=
 =?utf-8?B?bkRMMXB2T0swTm8rSFVVU1FtV1p3Z1ZDcEFmdHdFaS9xbUFlakd6Mk94UGZq?=
 =?utf-8?B?b2hVQWNERlhFT295QUNsUHFFa04rT1luVGdKSC9VUjF1OU9hYnJCUW1VaGhC?=
 =?utf-8?B?azRLeWR0Nk0wb0J2Z2Z1aS8xNkxaVFBTcXFkazl5U0lPM1QycHZxRkJPRzFo?=
 =?utf-8?B?MUVDTXFpZXBGRi9UOFlPTitSbldBcldUSHJkUXlvbHJubENwWTNhY0I5bm1t?=
 =?utf-8?B?U0x4TmE5WGhxMDBtcnF5T0RjTHkzdnY2aGZWL0hwNWs0Ky9hMTVrR0srVWZ3?=
 =?utf-8?B?bEwyZWJBSUFDZ3dRMTlqeGV0UTZ1L2hXR2NkT2dJbERmNGVLK25Hdk5wMjA5?=
 =?utf-8?B?UWl6emxtaTJPc29hTlZscndGTGxLaHhsMVlqRzJqSzllQWdEazBLM1BLOGpn?=
 =?utf-8?B?Qmx6OEpJSXF6bGhiR2lUcWRCenZoVE9DOWFFMnFWTEd3cnZ4ZVZuSWQ2RzZH?=
 =?utf-8?B?ZUdEZVphTW8wYUp1a2YyRC9hSVphUnJvdE00cmYwQkZkZlJEclBYMXFVZnZ0?=
 =?utf-8?Q?Hqi4roQ0VbXKph2ve581I6T5QOoQhFhfu2WYM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGl6UmVtQzdxUHpMbDBSelFmemVENHhJeVBFZ0hrMlNITVFyWUdiOW0wTE9I?=
 =?utf-8?B?ZnAvTWFWMWdHMnpOYllkVHlrc1pTaEgwL1dUd3lNVCtkR2cydkQ2Y3AxRjZo?=
 =?utf-8?B?bWg3UEhPT0VpR2xEZUJsOUp0SXNtYzRSOWgzeG1rYklKbFl0UG42UFBaQUtH?=
 =?utf-8?B?QlhkTS9Ic3EzRWpmMTRXZGhRNVVVVmJHT3NUVE5VTnI4czVhTG9uYVhieVhP?=
 =?utf-8?B?R2JYRHUrcysxNk1RRWpjOWQxTlVtV2lzNHQ5cU1TWWt6ZzBUWGNOVDR4dW1H?=
 =?utf-8?B?U1UrV1Z3TVN2aWI2VTRwRmFCVHBJMFgyaG85cXFmL01qQzlxcWN3aVJWbEpa?=
 =?utf-8?B?Z1Z6bDFEbkU1ek1DWkhDd25KYXpPZXo0cWFqYkwvSjRzT3ZYZ2tCei94K2ZB?=
 =?utf-8?B?cDNzelVvZHNpMlZNUTBaUE1xdGF6d0NueFNqRDZiUXFzQkpYMDdoc0gyLzM3?=
 =?utf-8?B?N3RKUHdyTHlJRDI2bklaVytrSlF5UU0rTDBacHNOcXF4UmRpUTJLLzgyenly?=
 =?utf-8?B?ZGxCY1JGZzl2bktReWlHN0Q5M01QZ29nL2VQcWxTbGF1U0RLSXVyN243Um9l?=
 =?utf-8?B?L1pxVjJXdGhRTEJIVzQ0My9BZ3lXY3gveVh6Q1NJTzRweW5sZ3JqeFhIUHZr?=
 =?utf-8?B?WDlZZzl0NEd3US9mRHlCVEZyMGt1VDB5OWVtby9MalhobVUwUUJxOXFtb1lO?=
 =?utf-8?B?dkJjbXowenJ6QjdJcTNkZjhWY0QyWnY5aVVFQ1cxL3d2WkU0VjZ6RzVLcHJF?=
 =?utf-8?B?RkVxYTgrZnU5Tis2OWpFMk9KMDA5TGl4bm9WSnhPMUtZZlh4dzV3dXdXY2hV?=
 =?utf-8?B?RzN6WC9vL2NvZFNLblZrYmh0bGp5dWlSQzh5dDlEaDgrVVMwTGdZMmsrODZH?=
 =?utf-8?B?ejRRY1FmNHg1V0gvR0dFNzlzL0w2SHRLUm5MSlNFNFRRWi8xM0FWMllvSjIz?=
 =?utf-8?B?ampId1BjZ1hSb1g2TVQxRk5nZ25UT2x2TkJ5N1loOTExdXlYbjJ5NjJjM3hP?=
 =?utf-8?B?WWU2b1l3dzhydk9GdWdrTG9oM2RVeTBkcThhNEZWT0RiMmtkMFh4NmR4bUtn?=
 =?utf-8?B?Y1dLLzZFTXU0RmRVbXpLYWRPcE4wd3hjQ0NaeXk5ZVpnU1NRSDRsSmxtVXd2?=
 =?utf-8?B?M3krU09UM0ROS1BlRW50U2YwdlpvbzVUWFprMTRwOGcxSGtsSERIdldjN2tm?=
 =?utf-8?B?Y2V1dEttWmpVUmIxNmpHT2dDbVA3K0V6eVdOa1VGSUg2S2t5VFpXbXl2NnZ5?=
 =?utf-8?B?NjFuRkVKZ1FNMjE0RlNYck1HMGlCMVErYmRVWUtGdEJJT2orQktySjRmbktV?=
 =?utf-8?B?eTBnVTFFTDdDeXoyenVqNzZ5U2lNRzhUanVnUzhuVitiVnl4TjRSTHJya0dB?=
 =?utf-8?B?NlBIN1J1ZXJyV1g1OWJTNnI2dXpET3NEN3dhUUw1dDRmQ1NNNUFrRUxsc2xJ?=
 =?utf-8?B?N2ZDQkg1ZEZQRzBMbE9DYWt1ajNOTU5IQThPYnY5d0w0ckR1UEl4c2xEN3cw?=
 =?utf-8?B?NlloMVBxMVRzalZhMGNCcS9oZ3pSOFZFK3FmcncyMGNlRk4xam5hbmhTRmdw?=
 =?utf-8?B?cE9UdmMyY3BSblpIYjVQNmVZREsvd3lUeGpEZXZLZnhVRWxyL0ZBK1R3M3R3?=
 =?utf-8?B?TmV0ZGg0ak5WeTJUaW5SVTd6eU9OTVVzQlZtSHpZYURjTVRqUWcrTjBrNkMv?=
 =?utf-8?B?YnRGbHVyQXB0Tm1yZzA2bTZjS3NjZTVzd0lKR1V5c3EvWm5ZaGZIaTZvY1BR?=
 =?utf-8?B?ZmhoMlI4NWRBV0FzRGpZWmUyY2pqUitTZitpUUdXMkNIMTd2ekFjck9QeDZk?=
 =?utf-8?B?b011SFMrUXpPWktPQ2pNcG1FK1NkcUlTZXZqOW1naFFyOTZ4N0Q2OXlMck1Z?=
 =?utf-8?B?N3JkSVBUOURlUitiVE1rV1RkT29TNFo5YnlOWFI2WVkrU3d1a1cxRzQ4RDhM?=
 =?utf-8?B?ZjEwWm13K25RMEp6Tlk5eXVIdDR4dzgrdWY5cVh6U1B5SFRUUmllQzZRa2FN?=
 =?utf-8?B?Q3kzMnRCT3FmRVZDME1vV0ZudS9SQWVldE53QlBjNU9sMFlqYkVYOVAreEZ2?=
 =?utf-8?B?cTd2K2srd1dkcW5XOXkxYjJMMTFhOWMwUE0xZ1dLK0NQbzJ5SWN1NkFBaU5C?=
 =?utf-8?Q?IKw6As5cLGIpHjzLVLzuGSTm6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895b0405-6938-4f58-6422-08dc8600cfbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 08:15:22.2876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HoRJnnd2Bh0GBa79LABZGjZDyuCocHPaC1Ew7x8u1mKH9UTcfHDx+1wDL3RPhrDwUW6AuQ30oYwcjeNCYV/sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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
Cg0KUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0K
UmVnYXJkcywNCkhhd2tpbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE1p
biwgRnJhbmsgPEZyYW5rLk1pbkBhbWQuY29tPg0KU2VudDogVGh1cnNkYXksIEp1bmUgNiwgMjAy
NCAxNjoxMQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogS29lbmlnLCBD
aHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5n
QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IHRvbGVyYXRlIGFsbG9jYXRp
bmcgR1RUIGJvIHdpdGggZGNjIGZsYWcNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJ
bnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCg0KRnJvbTogRnJhbmsgTWluIDxGcmFuay5NaW5A
YW1kLmNvbT4NCg0KRG8gbm90IHJldHVybiBmYWlsdXJlIGZvciBhbGxvY2F0aW5nIEdUVCBibyB3
aXRoIGRjYyBmbGFnIG9uIGdmeDEyLiBUaGlzIHdpbGwgaW1wcm92ZSBjb21wYXRpYmlsaXR5IGZv
ciBVTUQuDQoNClNpZ25lZC1vZmYtYnk6IEZyYW5rIE1pbiA8RnJhbmsuTWluQGFtZC5jb20+DQpS
ZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0K
LS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgNSAtLS0tLQ0K
IDEgZmlsZSBjaGFuZ2VkLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dlbS5jDQppbmRleCA5MDQxYzYzY2FiYjAuLjU4MTg2ZGU2MTQwMyAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQpAQCAtNDA5LDExICs0MDksNiBA
QCBpbnQgYW1kZ3B1X2dlbV9jcmVhdGVfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9p
ZCAqZGF0YSwNCiAgICAgICAgaWYgKGFyZ3MtPmluLmRvbWFpbnMgJiB+QU1ER1BVX0dFTV9ET01B
SU5fTUFTSykNCiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCg0KLSAgICAgICBpZiAo
KGZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfR0ZYMTJfRENDKSAmJg0KLSAgICAgICAgICAgKChh
bWRncHVfaXBfdmVyc2lvbihhZGV2LCBHQ19IV0lQLCAwKSA8IElQX1ZFUlNJT04oMTIsIDAsIDAp
KSB8fA0KLSAgICAgICAgICAgICEoYXJncy0+aW4uZG9tYWlucyAmIEFNREdQVV9HRU1fRE9NQUlO
X1ZSQU0pKSkNCi0gICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCi0NCiAgICAgICAgaWYg
KCFhbWRncHVfaXNfdG16KGFkZXYpICYmIChmbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX0VOQ1JZ
UFRFRCkpIHsNCiAgICAgICAgICAgICAgICBEUk1fTk9URV9PTkNFKCJDYW5ub3QgYWxsb2NhdGUg
c2VjdXJlIGJ1ZmZlciBzaW5jZSBUTVogaXMgZGlzYWJsZWRcbiIpOw0KICAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KLS0NCjIuMzQuMQ0KDQoNCg==
