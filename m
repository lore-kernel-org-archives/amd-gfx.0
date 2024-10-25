Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF2BD116E3
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 03:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB8810E0A5;
	Fri, 25 Oct 2024 03:24:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lp2Y6bhr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D6B10E0A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 03:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n66A5odqmmfPowdWyWVMbkE2x9VrRaB1j81M/d8ec/wHaQrtTnbNDloHubjQBTLSIeHzrcfDu4El2Fcp0fh1RgiJaz8pTezqdkZ/pK4GM7ZwLcvlX02XFZtNgdZaDeM1Bg/ro2gX3MxFZA5pDoD2815x1Rz30tyez2KBsknFMXvA6shVsAgh+C5DKOQBSzVwEN3ImGYyQqmED8xrKET0+vWLeHywIVsPEhm7VkcxgB8K2edudaJOuwnLVNgP8hDTu4H5ae11D7olNFkI4X7tE/tFaBh7p37BsU1s9NrS3DWSBJNhrYlYYjwcYP1BZgJoGZyfls4SxXFTS96bzsoP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMb2Ifq98dwMnVxvltZ9SzL79ieZMPFLCarxzizT9Ds=;
 b=fM/00hu/EGmbKI2hxUKFDUlc7ZfHWkAHfSO31+Vw/NfjrcDDWmyABT8ivz3JV3xv3VQAhxaT6WZnPI8yiM+2Ffvbz0wSNlqmMcTnWQD1T2R4PMZ3/owW1YheKutEXCL8FGpZqraB1R0OjCOcyXL+CMEtTWzd0NdBBHfov+548QZ57qIRb8rJDLp2j5Klji2H6GIMccwC7YcC2gF1SlMlcpGXzxQzSAlmgyeb0bCejVFs79WHnOQ81lt6k1QzGfPpcuyS/q60iKPLMPAp9ICXSFQc0IFUNBZdp4utTXArgvHeCZdVB4ej7FXIyMaeA2Vy3V43R9ACuu8BdE9EmY+RXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMb2Ifq98dwMnVxvltZ9SzL79ieZMPFLCarxzizT9Ds=;
 b=Lp2Y6bhrkIfuo4PwJ28iOb2TowkGYIiGPPjRmX2NmFn4R3hORtH/4+Qcx/EF3PYd4fpyVDnLDGRI+kVm6uT57UtBJsFDR37E/39ZWySz+mSk9J4DDRtHED8GegBxUyr6c8AEyrjvFaKiILnipNNOZnu6mhH/gpbk77mgaW4SwQQ=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.18; Fri, 25 Oct 2024 03:24:32 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 03:24:32 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3 2/2] drm/amdgpu: clean up the suspend_complete
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: clean up the suspend_complete
Thread-Index: AQHbJe3WNYzteRgiEEiYwI3dl0q3bLKVlMsAgAEyZuA=
Date: Fri, 25 Oct 2024 03:24:32 +0000
Message-ID: <DS7PR12MB60054EE24DCE9FCD0FD1979AFB4F2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20241024082159.45701-1-Prike.Liang@amd.com>
 <20241024082159.45701-2-Prike.Liang@amd.com>
 <5eb496bc-f0dd-40eb-8eb1-3b97771384d5@amd.com>
In-Reply-To: <5eb496bc-f0dd-40eb-8eb1-3b97771384d5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=076588f4-67df-40c5-9db8-0762f96cd3aa;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-25T02:56:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM6PR12MB4267:EE_
x-ms-office365-filtering-correlation-id: 427b9f8c-8cfb-4db5-512f-08dcf4a48b09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bGZ0WGt1YUwvLzZjTXdUSEFDYW0reWZGbDdXQ2VBSDRKU0RQMWVXT2ZEWTdD?=
 =?utf-8?B?U1RSR0QvL0lyVlNBOTZZVHBOZkRHYVFSY3grb0xub21Ec3F6bTg2Mzcvemdw?=
 =?utf-8?B?RUY2clNGc1dleDE0MWJUZ215c0JTOGtpcWFYNHdIVW9sY2NNVVZhWkJ3WGZP?=
 =?utf-8?B?V3R2NGRZK1JXdWxoU2NWNitqVEM3YWgzQ2FsQjh4VGpkdTB2V1BVeFl4R0JJ?=
 =?utf-8?B?RUN2Q3FtVDFoSHNiQVZWZHduYnJMNEtSckN0QmZUaENrNDlKL2FDd0lHQXJ4?=
 =?utf-8?B?TStTRjJiaURsbk1leGE1R1lvSFJaQUFYbE40SDlZUlpPaEovN2xjQ25ycFVC?=
 =?utf-8?B?cXgxYXJ3Wmp3Yjd2UFhaMWRyd0xGUndkZkYyUERyakRCbVRYeVg3WG1sVndV?=
 =?utf-8?B?c29ySFBQVVNhYVhMR0kwdS9rSGRlNEdWeCtOV3RMTGl1K0xkT2llc3ZaK0R6?=
 =?utf-8?B?UzNra3ErQ1lwV3lqNEd6aVBMUGc1b1daSlVYbDFWc25RVkxIUCt6SkM1NGVm?=
 =?utf-8?B?S3RtOS9aT3JCNi96VkNMbUZGR1Zhek9DTStnejIrSDFiR1BTTGRLbjQ5bUhu?=
 =?utf-8?B?bFY5d2NReWxaeFp5TStIbGljRC83S3NEc3dUb0dUOVlaMEYxc1RyTjJrM0FN?=
 =?utf-8?B?ZkRnUEtQUVhJbUkzcXdaYS9YcFdKM3B0U1gxMHVIbXhsS0dtU0tVRXRaWDRK?=
 =?utf-8?B?YVhXZFB0d3FJbWM5Ym5xMVRkVUcxR1NCdnpOWURLYmhwSE5VSWlyTWxqUkd5?=
 =?utf-8?B?c2hRUVdESWhBdHkrUjNhSmpWL1Y2cy9KMmlzRk13YktZa2xLekpNMjVvSFNO?=
 =?utf-8?B?MldySnZKM25URzhtYnlVMG1iaGdJQW9KYkVIZDNBWVJPamJ0MFBWTHZqQTFB?=
 =?utf-8?B?cTVoeEVDUVVqS0Q4SklaVUx1dDBkT2VOcGZ0YXpYREh0QjJzTFZsNmxBRGFq?=
 =?utf-8?B?M2svSmxqTURyaWs1L3UrNU5UNEo5THBPaTNmbnAxdEYzUkNsOWZ1UmpxMFpN?=
 =?utf-8?B?Y3FlTitaTjdLZTFBMmlKN3J2Rzk1RzRiaTB6QS91THp2V2VtRTNzUEg3U2xn?=
 =?utf-8?B?Rlp4aVRya3daSE1vU2tYdDJPRE0vRjc4akVYem9OMjZUQ0JyU2ozc0F1QXdm?=
 =?utf-8?B?Mm5iWmZ1SnMya1lNeUd1YWpiNkZTTHYzcXdmUUxkcDJKTnN3UXM5cTJDSVh1?=
 =?utf-8?B?MWdvZWhLUzd6dXYzdHMrVnMxNFdGR0hZaXV3SmR5dHRCS1RQL3A2QkUvOWJO?=
 =?utf-8?B?OTNoM3FQYjM4dDl0R2p3ald5NlRsNWFISklVOXF1ZXU1TkRGa3VvL3RwcWZZ?=
 =?utf-8?B?U21wbXIvRW02bE1DdWlHVEtuYjJrUk0rNzlTdGFYWUljZlFRY0gyQ1JhcFEx?=
 =?utf-8?B?aWJHRXBkVW12aU15czFjMk9VZHJmRVN0WERieVNjMXE3MkdFclkrT0JhTlov?=
 =?utf-8?B?VnF6Zy9WcnBuNW9CamdKa0lvOHhURHZYdTVqaWJGNGwzSVZkYkxNVVMxOGZM?=
 =?utf-8?B?d2dSck9vVHlMREI4d29zdllBaDJ2Skh4NlZ0ZjNmWTJvaWpMSEFXMHVoamhW?=
 =?utf-8?B?emZvTlNTemo4cU5WYmZOZ3NXK2pFNW5TU3ZxY1oyWXFhS0xnSFBtK2JYMkdy?=
 =?utf-8?B?bStGTndFclc0b0NRS3RKbzR0aUJhVU9LemZ0RUMra0FQdlRzL2puVC9MQ0Zq?=
 =?utf-8?B?d0FWelRrVmRlQ0xncVJ0NUdvTjYxYVFjVVFiV0h6bXVITUNsbXhVaEduMVVN?=
 =?utf-8?B?UTFOdUZMWEZBeWdWNmRZYjc1U1NtVE9vUU5USFZrS3M2UkZ1SkhlVVZOTzNB?=
 =?utf-8?Q?/MMRWuWszQK8xyW6xTBnkv+7k6f5Y6vvHumU0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG1QWnJIZGRNM0puRm02TmlOSVcvQmoweDRzYnA5WDRUMDNWOERKelZHZG5N?=
 =?utf-8?B?cUJqOXppTjdSTm1YQzIydlh4MmdKRkgzNHRkSk5ta1ZJaTRoendudXhGN2Va?=
 =?utf-8?B?ODJjdW1rcnphTXlaRHVINFZMVmY5TUNzQXVkRFJIajRCREVMQllYNVplK3Zx?=
 =?utf-8?B?cTFIM205ZXM1V3NuMERVR3IxT2t1aVp1RDVvM00yclZDeTRTUGd2NlY4VG5M?=
 =?utf-8?B?RlpKYTE4TFh6RmVoUHJsYXU2WWp1NlJIV1hRdXFoOWZZR2pNNmMydkNOdzEx?=
 =?utf-8?B?VnpGbTBsd0Q5TURjaU85VCthdGp1TWhmbkttcEJqQjN5eGFxcUQ2VEFkZmE2?=
 =?utf-8?B?SUVpd3o5bVJGa1R3Mkh0QnZGbk9meVhiUmJ2OWtoOWJNUGRVVE5OZ1l2Z2FK?=
 =?utf-8?B?eFlQejlZL0h3WElYcWRUYXZIOWFpTmpFQm9SS09Sc0NrS3FmU2NiMXNuKzBv?=
 =?utf-8?B?a0hEakVZb0V5MG1IU2pzVVdpQy9rbWxtank4Q3l1NEhQTHd0TURMcHM1dlVU?=
 =?utf-8?B?eWFYY3JrL25yQU5QYWVEdEJxTWd5T080ZjArUUtmU2huaHJnOGtqSU5qZndl?=
 =?utf-8?B?WHRqOGJlckcwL2RHNmtMZGtLSmFNcDQ5VWJqWG4raEJrcGpoaFpOa2RiTEZQ?=
 =?utf-8?B?a1RjM0lWaUxHVERlc2p2T0JKaVN5STA3Ry93UndiTnFCK0k5UmVWSlU5S2VZ?=
 =?utf-8?B?d0F6WDFwd21Idkc2OTJKOHNuZjdDeFpwZUVrU1crbnVMaG1SUDJ5T1dPaERK?=
 =?utf-8?B?d3ZLV2pLaE1vN2lWbGY1K0lRVnhCQVFPaU5sZ3JXMTdaQTZFM1NFNVI2bmxJ?=
 =?utf-8?B?cTRRK1gxSnpNWjZPMXlVNWpzdDN0a3ltSG9UYVJmblVTUWlEZy9SdXFta0d6?=
 =?utf-8?B?dG5KMTNaa3UwUitMZ3cwcDFMVk5qVUJId2xpbGRsclY0QThJTmc5L3Y3dXVl?=
 =?utf-8?B?c21YR0xlZDVrZ1ZMZXVvNlJScHNQWXROVU5acWYvQ2NUdUY5TExza0dFL3B3?=
 =?utf-8?B?K25YUVplMmpTdzI0N2NRN2ZCM1JLZ3IrNEtTSi94cmYxempLS0VuTkFvNjB0?=
 =?utf-8?B?cGJ3bkZLR0lvQ0Z5NFBBbzBHTjdWZkhMek5iSjRNU2RMQmF3MVlRVityUVhE?=
 =?utf-8?B?elhHREhrM1d3cWQrNW13UVdhTGFIa1hBODVUTDY5cEhUYXlpQTNTeW5SRjJC?=
 =?utf-8?B?cTF2Rkh2b1l4b0NsK1pmQjBjTytQL1hmTG9VdlNkK0JpR1lFTlNqbVBQTVF3?=
 =?utf-8?B?aWd2WTJXeUFQYkQzZDRlNVVDRi9RRkNSQTVDaCsyUVAvYWJzNFEybW1oTVEy?=
 =?utf-8?B?dXBLOFFwaFhrZjU5aisxbStZaklzUGxCVHJxTTZTWlRvcGRoNGg0b3IxWlA0?=
 =?utf-8?B?U0RoUjJ3a1NVZlVDM1gvcjZkNXpJM0hGUmFVUzVCakl2Ukw5RnlaTkQ0WlU3?=
 =?utf-8?B?TUt0VlRQRnlvMWJyQVFCR0QzT2lCVmt1ZDUvR2hERW1UcXB6NUhWN3pDNDU3?=
 =?utf-8?B?L1hubGlzMm9JMkdsdnBhRUNPSWlwNmpaRS9xMjAvZDJLNy9wRnl0Nkx1VFFm?=
 =?utf-8?B?RnpCSFZzYzZwOHNxL1g2dEhqR0VLS3dERGFQVjVtMmtRT1lBem0vTVdSYXBB?=
 =?utf-8?B?SzNXSW1HQmpINXlPd0JPSnFjSHRlM2JtRjRRZTNadVJZSU1JOTc0azdWendl?=
 =?utf-8?B?M3Vwb0I3V1M0UUxScXJlblAvemZhdkU3N1M4MDhkTWVYWFBuRVppWG9nblBh?=
 =?utf-8?B?UGN0V2tqOVg5TDJpeWsxVjhpUlpJeFc3eWs5MTk5NkVmMkFnVjVPN0wrWllZ?=
 =?utf-8?B?SFNkMkl0Z20rZlNHUkdYbHBIWmhERVYyZ3prY1dpcGsxaVlldnpmMFQxeDNh?=
 =?utf-8?B?YnhKb0ppaVBqaUlsTDZhSWI2RUFxMENHcEIxa3NJTUllRlEvN2JMdE1DRnhI?=
 =?utf-8?B?OXpoWGkzQ0U5T3BVZllOSHRmSE53ZVVCUStrR0lOSDFMT1luMzNObDAyMUhu?=
 =?utf-8?B?ZXdPZXNwWThuUW54WjcrdW1qY2pjRVNFcy91Z0FDWnB6YURYU2NmKy8zMi90?=
 =?utf-8?B?UEVoUGV2ZnhHeURCOTNWMGlkbG1MVjhYcTdMOElMMU5FUjNENm1uRTRCMVZF?=
 =?utf-8?Q?f3ZY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427b9f8c-8cfb-4db5-512f-08dcf4a48b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 03:24:32.3829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcBGYI5Au5NxgTuI1WFYhfQntHFlctwycfX8YVxiZGscx8/DcQEgWM73H/Af8qG6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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
Cg0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgT2N0b2JlciAyNCwgMjAyNCA0OjQwIFBNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtl
LkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYzIDIvMl0gZHJtL2FtZGdwdTogY2xlYW4gdXAgdGhlIHN1c3BlbmRfY29tcGxl
dGUNCj4NCj4NCj4NCj4gT24gMTAvMjQvMjAyNCAxOjUxIFBNLCBQcmlrZSBMaWFuZyB3cm90ZToN
Cj4gPiBUbyBjaGVjayB0aGUgc3RhdHVzIG9mIFMzIHN1c3BlbmQgY29tcGxldGlvbiwgdXNlIHRo
ZSBQTSBjb3JlDQo+ID4gcG1fc3VzcGVuZF9nbG9iYWxfZmxhZ3MgYml0KDEpIHRvIGRldGVjdCBT
MyBhYm9ydCBldmVudHMuIFRoZXJlZm9yZSwNCj4gPiBjbGVhbiB1cCB0aGUgQU1ER1BVIGRyaXZl
cidzIHByaXZhdGUgZmxhZyBzdXNwZW5kX2NvbXBsZXRlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICB8ICAyIC0tDQo+ID4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8ICAyIC0tDQo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgICB8ICA0ICsrLS0NCj4gPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc29jMTUuYyAgICAgIHwgIDcgKystLS0tLQ0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jICAgICAgfCAxNiArKysrKystLS0tLS0tLS0tDQo+ID4g
IDUgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gaW5kZXggNDhjOWI5
YjA2OTA1Li45YjM1NzYzYWUwYTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaA0KPiA+IEBAIC0xMTExLDggKzExMTEsNiBAQCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7
DQo+ID4gICAgIGJvb2wgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5fczM7DQo+ID4gICAg
IGJvb2wgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5fczQ7DQo+ID4gICAgIGJvb2wgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaW5fczBpeDsNCj4gPiAtICAgLyogaW5kaWNhdGUgYW1k
Z3B1IHN1c3BlbnNpb24gc3RhdHVzICovDQo+ID4gLSAgIGJvb2wgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3VzcGVuZF9jb21wbGV0ZTsNCj4gPg0KPiA+ICAgICBlbnVtIHBwX21wMV9zdGF0
ZSAgICAgICAgICAgICAgIG1wMV9zdGF0ZTsNCj4gPiAgICAgc3RydWN0IGFtZGdwdV9kb29yYmVs
bF9pbmRleCBkb29yYmVsbF9pbmRleDsgZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMNCj4gPiBpbmRleCA2ODBlNDRmZGVlNmUuLjc4OTcyMTUxYjk3MCAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiBAQCAt
MjUwMSw3ICsyNTAxLDYgQEAgc3RhdGljIGludCBhbWRncHVfcG1vcHNfc3VzcGVuZChzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+ID4gICAgIHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2ID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7DQo+ID4gICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZHJt
X3RvX2FkZXYoZHJtX2Rldik7DQo+ID4NCj4gPiAtICAgYWRldi0+c3VzcGVuZF9jb21wbGV0ZSA9
IGZhbHNlOw0KPiA+ICAgICBpZiAoYW1kZ3B1X2FjcGlfaXNfczBpeF9hY3RpdmUoYWRldikpDQo+
ID4gICAgICAgICAgICAgYWRldi0+aW5fczBpeCA9IHRydWU7DQo+ID4gICAgIGVsc2UgaWYgKGFt
ZGdwdV9hY3BpX2lzX3MzX2FjdGl2ZShhZGV2KSkgQEAgLTI1MTYsNyArMjUxNSw2IEBADQo+ID4g
c3RhdGljIGludCBhbWRncHVfcG1vcHNfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ID4gICAgIHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2ID0gZGV2X2dldF9kcnZkYXRhKGRl
dik7DQo+ID4gICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZHJtX3RvX2FkZXYoZHJt
X2Rldik7DQo+ID4NCj4gPiAtICAgYWRldi0+c3VzcGVuZF9jb21wbGV0ZSA9IHRydWU7DQo+ID4g
ICAgIGlmIChhbWRncHVfYWNwaV9zaG91bGRfZ3B1X3Jlc2V0KGFkZXYpKQ0KPiA+ICAgICAgICAg
ICAgIHJldHVybiBhbWRncHVfYXNpY19yZXNldChhZGV2KTsNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+ID4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+ID4gaW5kZXggYjRjNGI5OTE2Mjg5Li42ZmZj
ZWUzMDA4YmEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y5XzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMN
Cj4gPiBAQCAtMzI3Niw4ICszMjc2LDggQEAgc3RhdGljIGludCBnZnhfdjlfMF9jcF9nZnhfc3Rh
cnQoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYpDQo+ID4gICAgICAqIGNvbmZpcm1lZCB0
aGF0IHRoZSBBUFUgZ2Z4MTAvZ2Z4MTEgbmVlZG4ndCBzdWNoIHVwZGF0ZS4NCj4gPiAgICAgICov
DQo+ID4gICAgIGlmIChhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUgJiYNCj4gPiAtICAgICAgICAg
ICAgICAgICAgIGFkZXYtPmluX3MzICYmICFhZGV2LT5zdXNwZW5kX2NvbXBsZXRlKSB7DQo+ID4g
LSAgICAgICAgICAgRFJNX0lORk8oIiBXaWxsIHNraXAgdGhlIENTQiBwYWNrZXQgcmVzdWJtaXRc
biIpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgYWRldi0+aW5fczMgJiYgIXBtX3Jlc3VtZV92
aWFfZmlybXdhcmUoKSkgew0KPiA+ICsgICAgICAgICAgIERSTV9JTkZPKCJXaWxsIHNraXAgdGhl
IENTQiBwYWNrZXQgcmVzdWJtaXRcbiIpOw0KPiA+ICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+
ICAgICB9DQo+ID4gICAgIHIgPSBhbWRncHVfcmluZ19hbGxvYyhyaW5nLCBnZnhfdjlfMF9nZXRf
Y3NiX3NpemUoYWRldikgKyA0ICsgMyk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nv
YzE1LmMNCj4gPiBpbmRleCAxMmZmNmNmNTY4ZGMuLmQ5ZDExMTMxYTc0NCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KPiA+IEBAIC01ODQsMTMgKzU4NCwxMCBAQCBz
dGF0aWMgYm9vbCBzb2MxNV9uZWVkX3Jlc2V0X29uX3Jlc3VtZShzdHJ1Y3QNCj4gYW1kZ3B1X2Rl
dmljZSAqYWRldikNCj4gPiAgICAgICogICAgcGVyZm9ybWluZyBwbSBjb3JlIHRlc3QuDQo+ID4g
ICAgICAqLw0KPiA+ICAgICBpZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVICYmIGFkZXYtPmlu
X3MzICYmDQo+ID4gLSAgICAgICAgICAgICAgICAgICAhcG1fcmVzdW1lX3ZpYV9maXJtd2FyZSgp
KSB7DQo+ID4gLSAgICAgICAgICAgYWRldi0+c3VzcGVuZF9jb21wbGV0ZSA9IGZhbHNlOw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgIXBtX3Jlc3VtZV92aWFfZmlybXdhcmUoKSkNCj4gPiAgICAg
ICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiAtICAgfSBlbHNlIHsNCj4gPiAtICAgICAgICAgICBh
ZGV2LT5zdXNwZW5kX2NvbXBsZXRlID0gdHJ1ZTsNCj4gPiArICAgZWxzZQ0KPiA+ICAgICAgICAg
ICAgIHJldHVybiBmYWxzZTsNCj4gPiAtICAgfQ0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGlu
dCBzb2MxNV9hc2ljX3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSBkaWZmIC0tZ2l0
DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jDQo+ID4gaW5kZXggYzRiOTUwZTc1MTMzLi44ZDU4
NDRkN2ExMGYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MjEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCj4gPiBA
QCAtODk3LDIyICs4OTcsMTggQEAgc3RhdGljIGludCBzb2MyMV9jb21tb25fc3VzcGVuZChzdHJ1
Y3QNCj4gPiBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KPiA+DQo+ID4gIHN0YXRpYyBib29s
IHNvYzIxX25lZWRfcmVzZXRfb25fcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAg
ew0KPiA+IC0gICB1MzIgc29sX3JlZzEsIHNvbF9yZWcyOw0KPiA+ICsgICB1MzIgc29sX3JlZzsN
Cj4gPg0KPiA+ICAgICAvKiBXaWxsIHJlc2V0IGZvciB0aGUgZm9sbG93aW5nIHN1c3BlbmQgYWJv
cnQgY2FzZXMuDQo+ID4gICAgICAqIDEpIE9ubHkgcmVzZXQgZEdQVSBzaWRlLg0KPiA+ICAgICAg
KiAyKSBTMyBzdXNwZW5kIGdvdCBhYm9ydGVkIGFuZCBUT1MgaXMgYWN0aXZlLg0KPiA+ICAgICAg
Ki8NCj4gPiAtICAgaWYgKCEoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSAmJiBhZGV2LT5pbl9z
MyAmJg0KPiA+IC0gICAgICAgIWFkZXYtPnN1c3BlbmRfY29tcGxldGUpIHsNCj4gPiAtICAgICAg
ICAgICBzb2xfcmVnMSA9IFJSRUczMl9TT0MxNShNUDAsIDAsIHJlZ01QMF9TTU5fQzJQTVNHXzgx
KTsNCj4gPiAtICAgICAgICAgICBtc2xlZXAoMTAwKTsNCj4gPiAtICAgICAgICAgICBzb2xfcmVn
MiA9IFJSRUczMl9TT0MxNShNUDAsIDAsIHJlZ01QMF9TTU5fQzJQTVNHXzgxKTsNCj4gPiAtDQo+
ID4gLSAgICAgICAgICAgcmV0dXJuIChzb2xfcmVnMSAhPSBzb2xfcmVnMik7DQo+ID4gLSAgIH0N
Cj4gPg0KPiA+IC0gICByZXR1cm4gZmFsc2U7DQo+ID4gKyAgIHNvbF9yZWcgPSBSUkVHMzJfU09D
MTUoTVAwLCAwLCByZWdNUDBfU01OX0MyUE1TR184MSk7DQo+DQo+IEFjdHVhbGx5LCB0d28gc2Ft
cGxlcyBhcmUgdGFrZW4gaW50ZW50aW9uYWxseSB0byBtYWtlIHN1cmUgdGhhdCBGVyBpcyBub3Qg
aHVuZw0KPiBiZWZvcmUgZGVjaWRpbmcgb24gcmVzZXQuDQo+DQpIb3dldmVyLCB0aGUgb3JpZ2lu
YWwgdHdvIHNhbXBsZXMgY2Fubm90IGZpbHRlciBvdXQgdGhlIGNhc2Ugd2hlcmUgdGhlIGRHUFUg
aXMgY29tcGxldGVseSBzdXNwZW5kZWQuIFdoZW4gdGhlIGRHUFUgaXMgaW4gY29tcGV0aXRpb24g
dG8gc3VzcGVuZCwgdGhlIFNPTCByZW1haW5zIGF0IHplcm8gdW50aWwgdGhlIFBTUCByZXN1bWVz
LiBUaGVyZWZvcmUsIHRoZSBvcmlnaW5hbCB0d28gU09MIHNhbXBsZXMgY2hlY2tpbmcgd2lsbCB3
cm9uZ2x5IHJlc2V0IHRoZSBjYXNlIG9mIHRoZSBkR1BVIGJlaW5nIGNvbXBsZXRlbHkgc3VzcGVu
ZGVkLiBQZXJzb25hbGx5LCBvbmUgU09MIGNoZWNrIGlzIHN1ZmZpY2llbnQgdG8gZGV0ZXJtaW5l
IGlmIHRoZSBkR1BVIGRldmljZSBoYXMgYmVlbiBjb21wbGV0ZWx5IHN1c3BlbmRlZC4NCg0KVGhh
bmtzLA0KUHJpa2UNCg0KPiBUaGFua3MsDQo+IExpam8NCj4NCj4gPiArICAgaWYgKCEoYWRldi0+
ZmxhZ3MgJiBBTURfSVNfQVBVKSAmJiBzb2xfcmVnKQ0KPiA+ICsgICAgICAgICAgIHJldHVybiB0
cnVlOw0KPiA+ICsgICBlbHNlDQo+ID4gKyAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICB9
DQo+ID4NCj4gPiAgc3RhdGljIGludCBzb2MyMV9jb21tb25fcmVzdW1lKHN0cnVjdCBhbWRncHVf
aXBfYmxvY2sgKmlwX2Jsb2NrKQ0K
