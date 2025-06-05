Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26960C5AE59
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 07:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A7010E79B;
	Thu,  5 Jun 2025 07:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AO0hMsgW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E6F10E79B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 07:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkyGvd1K08X1ovpI8tjh1QVEHC7p8hhmEFZH18gHXp2XTqocKccDX3kgpgEhYy2qrNOwt4Y5rXMSMSkkAmkOvwFv9SU0MCp9FV5z2pnShtp5/IX3QIV5oNjDKoXb/WnWjGBrfCGoVuIT7hxdMN2WaAaWG68MtQiV/+ghlSBlJ2oDI4W1IGgAryRwLKGdUsRdxgJ3zulUJu4RMESh1TbMwv/WZhx5Ie+6pkvhZPgz5uVetIl8PTM3pv1UWuQQDyYg7xOj0GCn9VARfB4zxUrZsYKhd0FpJtx2nvOlmE7T9r+aT3QFDgahbjcWH9GrOKI2eyHq7DM2/YUhYgq2pOCtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFxYKkVs9zU4EndncZZ+X+66A4D3kg7Uq+JM1WlJCdY=;
 b=epjbBGJYyjSLNWIENHtuzPoZt1S/gWvkhN+vdzTfdA/q/HqOJ4ycXAGbIPhY1r3eV/ZSugm36ddjqfU2HMYOSU+GH8J+eC2t5My/xs9lc52yq0Y5+42ixxKFk7ZuL09yu31gWJgjz5FltIZH6Rgx92t1NOxSbDnnfUAlGajI5DeK7CKFF8uvc9Sd2HYkaRvLpgl/e/DpOoQVfqrFrf8ErK7kvGqr/Iq12fwfb1rMEKWfPVNqeyb2koipvI28+eeLVKMAIz94oCI0VP5KY19YJKBpxMfXaxGZeGdEDjhDmAU0LyA04aqenlJEn3OW13SIYix6b52OuLuJoDMjR9ynGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFxYKkVs9zU4EndncZZ+X+66A4D3kg7Uq+JM1WlJCdY=;
 b=AO0hMsgWbUdFnKTfuz6LGGoFwUpJJvYKg1LSu7CUMx7L9La52FHrhTsMCa2MVl36sAzsuxCGuvNwNluMG5o6LdycDdNCDTAw6TPbxyCtkkVd9M/I7QJx8l7TmN/HVJF3wq6MHp6aZ5atqvGvHMTJB6tsyyvYRUnJ+1xpmht1q3o=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Thu, 5 Jun 2025 07:54:18 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%7]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 07:54:18 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 2/9] drm/amdgpu: bail out for userq unmap error
Thread-Topic: [PATCH 2/9] drm/amdgpu: bail out for userq unmap error
Thread-Index: AQHb0Tgy2O9KJse1Q02d7ac9GfPoiLPrssEAgAh+NgA=
Date: Thu, 5 Jun 2025 07:54:18 +0000
Message-ID: <DS7PR12MB600576986FFCBF8951BD84F2FB6FA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-2-Prike.Liang@amd.com>
 <CADnq5_NadVhtnAx32FR_v_wY6uaVS8fFRo4V_8ccdPbbOz9thw@mail.gmail.com>
In-Reply-To: <CADnq5_NadVhtnAx32FR_v_wY6uaVS8fFRo4V_8ccdPbbOz9thw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9bc9638b-2aa3-4afd-9817-0d381cb6c6da;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-05T07:16:26Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM4PR12MB6111:EE_
x-ms-office365-filtering-correlation-id: 3048d84e-7794-4329-8d91-08dda4062c9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?elNIOXQ5dk1XZzBXcTZNS2hGaGJkbWtDZGhLVHMveEVIM1ljV2JaeE1GS1Yy?=
 =?utf-8?B?ZklqSUg3NUJBMnpzcUhOZERWS3FyWkVnTVk0OC9ZdjRFRjNSRVVUTXRiVmxo?=
 =?utf-8?B?bVk2SS9jK1FVb3BpaWxyamVIeDlRNTczcDBDUGxmNWE0ZmZpaHhpYk14aloy?=
 =?utf-8?B?T3BHa3UwZ05IL05MUGxZZ2gyV0hwTERVVU1EYk5jTkY4Wk1NQnZycmNLbWJS?=
 =?utf-8?B?Vk40a1ZpNWRhYTdzV0ZNWTc1MEtvQ0VpaVdROG9DekhvSUhpcWZ2eXhCMmty?=
 =?utf-8?B?ajd0cG01bUJQYkRwQkdneC9IcDc2K1VpajlJeFRXUXJBV3VJckNONys5SmNv?=
 =?utf-8?B?QjREWGtZL3p1K2RqeEY2K3lTT3NhM3dUMWhHcEJUd0ZlRnFodFpsdkZFU1RY?=
 =?utf-8?B?NmhXdzM2bWppUGRFblFmT3hxTXY1TzMwYVMxZW00cENvSTBiUXEwcWhhR3Uz?=
 =?utf-8?B?NmNCQW9HS2pEYks5cC9XWTZIbmlLSFZrdm5IOXo3djNkNUdDQ1JRN0YzN1Vz?=
 =?utf-8?B?aWwxR1pIQnlsZnQwS3AxSGl4SGhQc0xzYjVveUJrYkV3bVU4VldkekZSZlVE?=
 =?utf-8?B?ZjZzSnpRZjRIb3BPRkMxQ2pRMEV0SCs4KzF5dmVEOXVjZlJLbGwwNE9mbHpM?=
 =?utf-8?B?VjBlNHBrYUlkaEo0RWo0ckdhTzlhbitlUGJ6c29DVWVCd0RZa00vSWJZNE1U?=
 =?utf-8?B?L3Z0NHF2dmlnZUp5S0NPcm8vS21YYXhTWU9odTBMSkF5TTh5U3hFdFcyaDA2?=
 =?utf-8?B?Y210TkN2UDlyZEVVckRIQ21NOHNXWnI1UWV4c3JuUCtoMHJ0bjRkbjdNRXcx?=
 =?utf-8?B?ZHBSUEx6VVVOM2NFRTJTelNpdlVpTlEzNFBQS1VucGdWOFNlNExuRzczeFIx?=
 =?utf-8?B?ajdVZTZrd0xRaGhCN2xKeWJNZjJXb2ZsSm1LT3ZFeVZBZWNrK21uT0VmaVdK?=
 =?utf-8?B?SEZuRGppVzA2OWJkVFpOaS9QQ0xyMmJoSFVqRDZoTUhVdkUxV01LeUJYUXFR?=
 =?utf-8?B?Q3JOVS90NG0xRzZjejc0YUt6QWVWbXBvOGVQZHdvcjdDQnA1WEdIQUd2NEtr?=
 =?utf-8?B?eHYxdk9jdWlXdW12bGQrdXFBRWlWRUxiRTlmQkNzVUhmbWxSRkhFT0IzVVo5?=
 =?utf-8?B?Q0s5R1luMWtJZ29nS2JHQlBaRE9rSEFIZWY3c0xOTFk2UlVqbktqQkxFOEJo?=
 =?utf-8?B?YUJtbmpjVEdVd211empXcUdmMDNQY0dxVXpzbFB4ZjhEdityaERYelg1UW5R?=
 =?utf-8?B?N2hVaUVZMmV3ZnQ1QjR4bDRQS0grSStva0w3aUxpN3RYTEFOVkw2WDlXYlFV?=
 =?utf-8?B?YTAyeGlEUG1yRXpub0ZtRnJNR1VCQmRodkF6VFNtaHFGQ3hHbWdFaUFibk51?=
 =?utf-8?B?c2dUS3ZIdWZFS216Y3BLQytSUkFveUNJSXBkMEtsMWxRYWNJdGsyeitnaG9V?=
 =?utf-8?B?MWxsWTVwS2JPM3pIT3BwOHhySC93Y1ViL1dLbTF0TFFMZ0dmTkV2S3R4L3Uy?=
 =?utf-8?B?SzhqQmpNOFZDUWM0Um9zNlFmOGpOTVRiV0Vsb0Zsd0QxUFIxaHJIQmtvSE9k?=
 =?utf-8?B?Snl2M1dsUTNtS2U2Rkx0WUhqZTYva0hueVRMNTN2K0E3RDFEODFlQTBDejE1?=
 =?utf-8?B?MXh2bGh3MkswTUkxRXMyMDFMSGxxSUZDTXNvdVBCMmhTZHIxRGtDOWlkU0hi?=
 =?utf-8?B?OGVQcEJCRWpZeFRwQlpyb3ZOSEMzVTVSalhhWnVxMnpuT2YzeHh4Y3lJYW1C?=
 =?utf-8?B?cGhJSnFONFE3RmRNNlVlZ09TdkV6OVJRb0oyOHdFOVZZT01sZnZBRksxNGdv?=
 =?utf-8?B?Z0FDcllqaGY1U09lQzlIZ2ZuYTNBb0RJZ1J3NXF6ME1ya1FYcVZ5Y21ScEFW?=
 =?utf-8?B?aW1BNWRzM3YxaHdKR2k1TDFPc1hlMkJDdzltMjlER3QzVkF4blZ1ZFlXYVNp?=
 =?utf-8?B?eGdXU3ZDaFBPWUpoNHlmcEJjK2hManBweW5KcDh0bHJwUi9aK3BsUUZQRWNy?=
 =?utf-8?Q?0GIgrRIOh8KuJHjnH2NdXfWRTWg8rY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1NYQnBhUzJvRGhWVlQxYXovS2EwdGFIZml5NEFJSGVXbVN0MVJhd0hsUUFI?=
 =?utf-8?B?MVFJNnFQL254MHFOQXQ3VjJjbTNTU3pSWWFHNllveCtSMXFQM3JMcC93dG5W?=
 =?utf-8?B?OERWRmYvRXpQdlRSZFhCQlRKRUwzcFVGWG1BRmhpWGlRd2s5SHVQRTg5YzRk?=
 =?utf-8?B?RDJneHNvdjR4TjNmVFpXK0JVN1RNelltdW9HNVo1aUhnYk1KUDJHVUhoQ2dw?=
 =?utf-8?B?bzFHMTNab3Q0VEdmMEtVZ2drNEZ0b1Q5SHBkYXljaWFnRi9pUUhTb0xwdUtG?=
 =?utf-8?B?T29Jcy93M0VHTW14Y2tlRGpHclU1amlMdXE1ajd3Vm1MdFVXR3doa0x4SnN1?=
 =?utf-8?B?bzcyUW9McUpmdndmWWowVnNHQkxRek1za3FXcDA0VEhYdm1UT2drYU9SM0lq?=
 =?utf-8?B?WVpjdzlxdVhob1dsRURlUUdSeElsNzVlM3lDSWllL0hjeXpCL0VuVnJQbVBS?=
 =?utf-8?B?UmVyRG15d0VUZWlqS1RGYk0ycEtrVUcvaHFpNGNKRVF5MituMlFKaTRzRTgr?=
 =?utf-8?B?S1lCcVpvTTV2VWNRa2ZKTUVmdllpQ011UDhrSFl3ZXIxenk4bmNOek02dWtu?=
 =?utf-8?B?bUQzU2dDNnQzaFdWRmYwdmZiUU9ENmZDTFVGdnJkeGlPVm50Q3JWeW5EYklo?=
 =?utf-8?B?NE11R2RSWGlVaVdrVVhUUXFHbVRDVlJQZWowMk5UYmV5cnpHRG42eXBLVlUx?=
 =?utf-8?B?Wjc4WVl3TWV4bitlS0lVb1lJd0Z0Syt5TG13NG5VQWplOUxwUnJBOUk5M05m?=
 =?utf-8?B?Y01CQ1VrZVBDcFY3T2NRdFhRRklsRU1mM0hTR0dROU9wMDdLVFdwSVd3bm43?=
 =?utf-8?B?VE5NLzR1dXhvdk1GS3NBV3FrWEFwdUFsYUtGbERoUnFsSEw1ZW5wUUdmNDhT?=
 =?utf-8?B?aExxMk5aOEJlK1lqdU1pMURoajIvdGR2L05CaHlTa2s4dUVHU0JHZ0x4cXFS?=
 =?utf-8?B?cXp6VWhuVkM2OVFYS1oyOW9EOHJFTzE2RytxbUFxQ3NMOWRBUmQyemFHemxW?=
 =?utf-8?B?bERRWUxWbk54OEc2R0FkY2xHRE9CbktsSUFYN3ZpaWpjSGVIVjlsTkFFTnND?=
 =?utf-8?B?ZTFmTjExWUd0WThOQmtBdEtlRmQvSFlyZUViZmYwR1VQdTNGdkVIVnRjOEFw?=
 =?utf-8?B?YWJ4WmhnNlNIQi8rblc1Z2M4MzFzVlp2VFdvUmZZd1NoYXFlRjBUMzdNYUQ4?=
 =?utf-8?B?a3cyWVdHWUptbHBValAvQmVJN0hSdWhlMStFWFg0ZkNzUUJMYUlabnNGQ2Zj?=
 =?utf-8?B?a2tHMjg1T0Z3dm9NbEpTUkVnZ0VidjdOU2xlVmpsbkVjYlFraXlYQlIremVZ?=
 =?utf-8?B?dnY3YzFFZVFueFVhV2V6Z3h4ZnVEcjZSL3p3a3l0REt3M1NTTDNhM0pJOGMz?=
 =?utf-8?B?WVRYaTJlS2wwclU4Vy81akdXR1BXMWJpRlRrMDVjMHdGSHBvMVBNSFBSS2hv?=
 =?utf-8?B?ZXkyYS80OXUzeUF4WkNWL2NDOTRQUGFUeWR1LzNLeElkdEZEa1EzRzBVTXFL?=
 =?utf-8?B?MHVMbWk2QUFnQ25SWXhuTGZlc3NSZU1tQVJNSndudEp2N2JWVkJob2EwQ2pI?=
 =?utf-8?B?aDQ0ODdQa1YxbitTYisvZTZCWS9nK0NBY1V4b3REQTFoQXNyRXRnYXNXVUlq?=
 =?utf-8?B?VjhrS3NXZllQSkxndjFESVo4Nk5QVGhTaUxjUlplaVUyUllseXBRUm5pek84?=
 =?utf-8?B?ZWVYdjZrQldzaldVQjlvdkx2RzlHY1BEZkYxMk10K2NJR3Q2SEUvbElaTUl5?=
 =?utf-8?B?QXFkVnYycHpneXlmSHlYSmttRkNPam1wSWZBdDJuS2xoMGd5akozV0loc3pR?=
 =?utf-8?B?MzYwUVZMbHVlZlMvNlhCSm9oUlBJU3JXUlNvanNHMjJ2aklCaTV1N1lQc0U5?=
 =?utf-8?B?cEJ1bjJqS0Z6aG5oK1dsYkk0KzJpUXFLazVqT3UzanpsRlFvVEZWU2pXLzl0?=
 =?utf-8?B?amxxZEkzcDFNZFVTMTNIQWwrTmNGSTU5VzJ0dEZMM3hwS25BaUJTMXRpRDIy?=
 =?utf-8?B?ZWFHdG5WNGMxdGNINUY4My85UnlKek1Bd1RzNzNvK0pUbDR4MDRraFEwR2Vn?=
 =?utf-8?B?MXRvUmE5YnpUbjZSYXJjZ0s0eEdKR3cveWp2Tm9JWGt1VGRFTUdXb3doUXVO?=
 =?utf-8?Q?3cvM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3048d84e-7794-4329-8d91-08dda4062c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 07:54:18.1132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0XdIRYTI4gueDZlF1lV6Tu99qGVOBV6coPXoxjnNDEG7qXVR0I9JfXZH91a1FuS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
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

W1B1YmxpY10NCg0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4N
Cj4gU2VudDogU2F0dXJkYXksIE1heSAzMSwgMjAyNSA1OjM0IEFNDQo+IFRvOiBMaWFuZywgUHJp
a2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsg
S29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47DQo+IExhemFyLCBM
aWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi85XSBkcm0v
YW1kZ3B1OiBiYWlsIG91dCBmb3IgdXNlcnEgdW5tYXAgZXJyb3INCj4NCj4gT24gRnJpLCBNYXkg
MzAsIDIwMjUgYXQgMzo1NeKAr0FNIFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPiB3
cm90ZToNCj4gPg0KPiA+IEJlZm9yZSBkZXN0cm95IHRoZSB1c2VycSBidWZmZXIgb2JqZWN0IHJl
cXVpcmVzIHZhbGlkYXRpbmcgdGhlIHVzZXJxDQo+ID4gdW5tYXAgc3RhdHVzLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jIHwgNiArKysr
KysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGluZGV4IGY2Nzk2
OTMxMmMzOS4uOGVlYTBlMWUxYjZhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBAQCAtMzE5LDYgKzMxOSwxMiBAQCBhbWRncHVfdXNl
cnFfZGVzdHJveShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHAsIGludA0KPiBxdWV1ZV9pZCkNCj4gPiAg
ICAgICAgIH0NCj4gPiAgICAgICAgIGFtZGdwdV9ib191bnJlZigmcXVldWUtPmRiX29iai5vYmop
Ow0KPiA+ICAgICAgICAgciA9IGFtZGdwdV91c2VycV91bm1hcF9oZWxwZXIodXFfbWdyLCBxdWV1
ZSk7DQo+ID4gKyAgICAgICBpZiAociAhPSBBTURHUFVfVVNFUlFfU1RBVEVfVU5NQVBQRUQpIHsN
Cj4gPiArICAgICAgICAgICAgICAgZHJtX2RiZ19kcml2ZXIoYWRldl90b19kcm0odXFfbWdyLT5h
ZGV2KSwgIkNhbid0IHVubWFwIHRoZSBxdWV1ZQ0KPiBmb3IgZGVzdHJveWluZy5cbiIpOw0KPiA+
ICsgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJnVxX21nci0+dXNlcnFfbXV0ZXgpOw0KPiA+
ICsgICAgICAgICAgICAgICAvKlRPRE86IGJlZm9yZSByZXR1cm4gbWF5IG5lZWQgdG8gYSByZXNl
dCovDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByOw0KPg0KPiBJZiB3ZSByZXR1cm4gZWFy
bHkgaGVyZSwgd2UnbGwgbGVhayBtZW1vcnkuICBQcmVzdW1hYmx5IGlmIHRoZSB1bm1hcCBmYWls
ZWQsIHRoZQ0KPiBxdWV1ZSBpcyBodW5nLCBzbyBpdCBzaG91bGRuJ3QgY2F1c2UgYW55IHByb2Js
ZW1zLg0KDQpbUHJpa2VdIFllYWgsIG1heWJlIGl0IG9ubHkgcmVxdWlyZXMgYW4gYXdhcmUgaGVy
ZSBhbmQgdGhlbiBjb250aW51ZSBkZXN0cm95aW5nIHRoZSB1c2VycSBzb2Z0d2FyZSByZXNvdXJj
ZXMuDQpEbyB3ZSBuZWVkIHRvIHJlc2V0IHRoZSBxdWV1ZSB3aGVuIHVubWFwIGZhaWxzIGR1cmlu
ZyB1c2VycSBkZXN0cm95Pw0KDQo+IEFsZXgNCj4NCj4gPiArICAgICAgIH0NCj4gPiAgICAgICAg
IGFtZGdwdV91c2VycV9jbGVhbnVwKHVxX21nciwgcXVldWUsIHF1ZXVlX2lkKTsNCj4gPiAgICAg
ICAgIG11dGV4X3VubG9jaygmdXFfbWdyLT51c2VycV9tdXRleCk7DQo+ID4NCj4gPiAtLQ0KPiA+
IDIuMzQuMQ0KPiA+DQo=
