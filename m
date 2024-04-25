Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922B5C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 14:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B3C11A4D1;
	Thu, 25 Apr 2024 14:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l/tNb9pr";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D12FC11A4D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 14:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhnI8NTFqHB9nIhRRipQ3g1JVNJOubmHDM9VKtW7j026Nj6NFnUUqkVByjus/iq3oQq6/V/nucxF1rCXDoQVc62Vk3aYwQTwlxzSrmKJ4YdeF0aQDuasaM/Orx510AMoxc2kxtU7LvfyP1jJH6AdirMuXWPEgwbXfmcXct4RF4BpKSrtqMFj6MpUF991vtz9M+0+fxQX1PkafdP57TT2zV15PFI32xr1CvDXYLNgn2P7yDl4txvvXmoFrqoY63ZP0fzgxVkdwQ4KehTnkIZopwq1oyOG/AhiPiQX4/NsHvW6EHWKAK92UmyoGHBlHzsNzB0vo4BLPJlBjzt/Bxrarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZludNt0D7LiPobZ9XbGM6Y0gM1RXc0KLP0IXNHoFb28=;
 b=IjV0l2h5bhNkS4ugcKo+mvO5/ZGnJo8iWR4Y58MiCMxUwEwXxEvE9MQ4Dht6alTlNI8j08d+Dx/wtd9fGGm8VkOsEcMi6gy43Xa/gq7GAIxjvWdKHLxVfIPRWcG8LXxL9U+to+Jv0o+O1k/kNvgDLS4Aaze4YU1T6QuyQKTBeEPEV7Hp/p4HAFYgsWyUQTSZy+jAtzGd0lBWqQDepmjpeQJTo5hvNrnCVEl6uYtKT3kuqeluwEU1oKOsTa7Gs45M3pVwh07jo/UKHfB9omjnMmCgjsEDLbiY1hoWxd8IQj1mBBsD1QR2zz2Fsn6C1AxJSZL04rf1a80xcGJHwmn43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZludNt0D7LiPobZ9XbGM6Y0gM1RXc0KLP0IXNHoFb28=;
 b=l/tNb9prVulwLCC2Hx2nbKwgUqE9C2Pw0LHnNMu98Cj/rYhsZ6ownqUsjDmiiiwGlGQzbaWqMoO1H0f3NJjgvNT6xCkkREEEQ/DTGMt/FIIfbmlOPy8zMXkYFjX4UIRiPl/Qv5+02zHLxk2YWgg3FQNCgt8jyQsC2veTz/yfLlU=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 14:39:32 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 14:39:32 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix two reset triggered in a row
Thread-Topic: [PATCH] drm/amdgpu: Fix two reset triggered in a row
Thread-Index: AQHalO23YeZJ9BFN8k+8ihSpKZPttrF1WoMAgADNN4CAAM0KgIAAcuIQgAGjQwCAAAeV0A==
Date: Thu, 25 Apr 2024 14:39:32 +0000
Message-ID: <SA1PR12MB8599273105C0E0D364E53D0CED172@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
 <572623ed-f353-46f2-809e-4678b152fa5e@amd.com>
 <eab5193a-7613-4733-a006-9eaf5598647a@amd.com>
 <a9797ada-63b8-4d3b-827e-f8173ae03abb@gmail.com>
 <SA1PR12MB85997F18F0D3FCBF528AAFA5ED102@SA1PR12MB8599.namprd12.prod.outlook.com>
 <ee7b9ab7-bbe8-4254-bf90-df6775a2e31d@gmail.com>
In-Reply-To: <ee7b9ab7-bbe8-4254-bf90-df6775a2e31d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fdb1be6e-e040-4375-a099-cd9a952a4f93;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-25T14:38:16Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|PH7PR12MB7017:EE_
x-ms-office365-filtering-correlation-id: 3dbc755e-d39e-40aa-224f-08dc6535851e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?WVBuOWRDZ0VoeGFFQkhORC9qZXFBMkxHUDVZREJ1SnQyZEdkUnRBQmNYMDZK?=
 =?utf-8?B?Q1dMVkllRHQyRXV1U09CR1pIQ0I3VVdjOW9ubXJ6MTM0NzRCVTVpdW5PVHRj?=
 =?utf-8?B?VnRkb2N0a1dLeWVwM09PSDR6cTBYT1JNbE5WaXFEc3FqN0ZzY2RrcytEYitu?=
 =?utf-8?B?M0VDdkR0YkUxbmpMY2RvL1BoRFJwTnBqSUFFVFNWUnN0a1V3RU9sMkRRNzYz?=
 =?utf-8?B?NjVucWRkckxvQ0hxOW0vUXFhSFhSSjMwaGZCeFlvYU1QbGhZc0psVzVQZm8w?=
 =?utf-8?B?V29KQnRYZExGMTVnbjIvTlp3OVdXaUZiWTZlQm95M1lUblc5NXY5R3ZSYjdq?=
 =?utf-8?B?TENqSElEVUhlWmZDM05PRTlIcWF0L01mRGFjRHZ1ZjMwOGhQS1pnL0ZYUVdD?=
 =?utf-8?B?cUhnL3JVQ0VFaUhoUlVtMmFTMXZyM3BLYVdkQi9kalF3NDU1RTcxUDB5MDhK?=
 =?utf-8?B?Q2xNN1NmRFQyYXpWMnZUb1lPMXJ5d3pzbmc5dC93MTllOUlRT2pMczhVSFEv?=
 =?utf-8?B?K2kxSTgvbHpwMllKU1QwWHZqRXE4T25zTmtwSUJqRDJmek51Y1VJd2VwbU5y?=
 =?utf-8?B?c2x1TFVvK2FhcVdLck96TVdCdXBGWUpxVU1pOFdiOHZZcVdSYUdsYlduL0di?=
 =?utf-8?B?amhFU0tQYVlMN0Q0WU1BUTQrcE9hRTFoOWFRU0prbC9HanhIMzJtdG5NY08v?=
 =?utf-8?B?QVVIVk9VazZ2NCtjWEV0NmFDd2UwMVpMME1vL3RVZUE5dTZRa2RTaFBkVkFk?=
 =?utf-8?B?Y2NtejNucHNtRVkyb29IK0VwTXNMNnR2eXJCSFk2emRPUHllaEYrdUNJMkIy?=
 =?utf-8?B?eE1KRUc3YzBUVGJSQ2RPbWdBVWFGUXIrUkp6cS9HeTJKS2RYQllHVENVWENy?=
 =?utf-8?B?V1VoT2hvUjNKY29TaVNGRHJic1dORWEzR3VIVW12OG1TSXh1SUtTaldFQlpM?=
 =?utf-8?B?dlo0dFRrNisrWDVNN3NKSjZKb3dINmVVWnRpWktyRnluQWJyc3R0dUx4MlpQ?=
 =?utf-8?B?a0dJbU13SGR2dU9kM1NOQVJGbVVva2U4VUo4a0x2NXJQZWEvaWJIWlJhRUJ2?=
 =?utf-8?B?RkZXYmd4bE1LbWF4ZC8ydXNkb0tRSU5IdmRlcDF5WDJYYXBWeEZHbEtkYUNy?=
 =?utf-8?B?YVZZdTR1dkdLZkhGd3NKYXBVUjRueWpmRVJ6M2ZKQXIvTFhneWorUWZhYW5I?=
 =?utf-8?B?OHpWeFFyQ2l5MWdxMWgzQStyeFVZeHN3RGxOc2ZWelE2bTZwOFlCc0hxVWFh?=
 =?utf-8?B?WDNIRWtKTHVKUHVqYzh1YnFGQjdqMnRIQnJtVk9XSVJZakt4UDBMRm9RUEM2?=
 =?utf-8?B?V1VOS2xRZjNvNmdxN3hFRnJmR2dvN0J2NTl4UDQ5L1doMlh1SlpPSDJST0ww?=
 =?utf-8?B?UmM5bkFJRmNFRDlMeDlid3lBdkpFT0FRSEkwWDFlV1VLT0w0c1diN0J3UDVz?=
 =?utf-8?B?bllzY3o0K01PTHEzM2xrcGJ6S2VKYmtZY2RwKzIrdXd1aURMOWowcE0xcVdL?=
 =?utf-8?B?MGVkdllHWTlYV3pQY3ErbWlaR2JRS1ZBQkVqcmRYdGFqU2Z0UldyNHB0UXdo?=
 =?utf-8?B?SlRBZWpZWnB0eDlpYkZGTGNmc3JJdXIzNmQ2dGQ3NldIRGN1c1B6OFg0RDRs?=
 =?utf-8?B?OEpwUzlFQ3plMzZ2d3RCdVRhMXN4SnRuTjJ1UFVrUDA0TmNyTVpnS3JtTTZi?=
 =?utf-8?B?Q3BoRno3cnNoRUtFdkdESnc0SEZrVmpZdDNIbXh5Wjk0SGU1NXhQQ21iTjZs?=
 =?utf-8?B?WStyTmxmeEtlWm8xck9KZmR4NitsWDNSMmFNZVVhcUM1SXBoZ3F1MVNXQ0Nv?=
 =?utf-8?B?QXNoTnF3ZGkxaEtsVDRXdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUEzaEJmSVErb2k2VlhEMUJBSkEzUTE0bFNGTmpBb0dBRWRyUXpyZ0tNNVY4?=
 =?utf-8?B?eHl1OXlYRmcvZlJ6Yk9MWUdEM0RWODBuSFdKT1I2R2tGK3VGUUNUY04wR2RD?=
 =?utf-8?B?VGx5N1ZEM0kvYjlOVU9GRy9haE13QVdzc01VWjJ2MjdUZVRvamd5OVJpU2xH?=
 =?utf-8?B?eE1ka28zQjl1b0VPTnNXazg3VkJEeVBBTW9KWXUxMW5OaEd0SWx5OXZ6bG1w?=
 =?utf-8?B?UVd5bkxkMjU1NmhQKzBQUnIyZldnS21HaVZWM2crOGVpdHlXbklzbVQ1R1N6?=
 =?utf-8?B?RzI0UWlYaTAxVGNDbFlKdHZvRVFKeEpwUzFWS3Z6Q0dRNnI2SUVGdjJITUQ1?=
 =?utf-8?B?eW5kUERxUFRUQktYNVlOb0kzT0Vnd010RXh6dTF3WXVFOFFHeFRGMVZ0UElP?=
 =?utf-8?B?b1BMdy95WG9VdlZrZ1BWRytpRlI5NEF4TmFIaTlQS0tkYktGMFRHUjg1dUN5?=
 =?utf-8?B?ci9SUTFadDJHckNzUzMwZmNwcEpkZHE1ZWVKRXFYOHdsekQ1TFNveGFEMm1K?=
 =?utf-8?B?QmkvNndrRnJmV2E0ZGhDb25BNytodkJoVHowNHdGWndkaTc4d3hBTWFOVzR2?=
 =?utf-8?B?UFBWNEhRdTFRQW5CNUFwVGtIZFM5OXFQQjUvQUd6VDJodS8zUnJ2N2FVS01T?=
 =?utf-8?B?WUM1N2dtU2JCc3g2RjRHcmNZYVJNY0dHTmRldVRSZTNVUmVRdWpFdUNIeXNs?=
 =?utf-8?B?ZS9MY3B5U0NrOHVSUElkbTR5eWRpYU5sU29JMTh0Y0U3M2x4cklXVkthSjJV?=
 =?utf-8?B?aHQvb0FPTkQ3enJXQm1XcXhzdWxlR1hZdHlQbjJieVRFbzJFK2xsY2J1THZ3?=
 =?utf-8?B?MTJYWUR6d0tZeDdpOUswQWtWZ3M2NEFDd1J1WVZVc1RmWng5Y251U0tyVnlo?=
 =?utf-8?B?TXo2RnArTGswRWo4TU9mdzBZMDBhZ1JuY0pUQXl5alBmQnduOFdZckE5dlcv?=
 =?utf-8?B?MksrTVkvUW92TEYvNGdWMTRaTU9zQld0ZjZXV1BFdjNRYmRRKzFOZ3pOU1Rt?=
 =?utf-8?B?SXJsdnJsc3Qzb09DZGpJcDM2cmlPY3dHTTN5ZDl4UFFQUThYMFQwcmRoS3Z5?=
 =?utf-8?B?VkdMS0NuNXNxTk03bU9BeHQ2OXJKVkJJNzJQM0I3VkJiNzg1dGRtdkRqZHlG?=
 =?utf-8?B?ZjFUUXVpVGZqeWJZZkhSNGZzakR3VVFUbGRkUmlGOG9CblRUZnNkMFBCV3NH?=
 =?utf-8?B?N21WNkR5dWVlVTB2QlBmaVkxYTRYWGpndHVWKzU0eEZ3Vy9CNVZwYVpLUXJS?=
 =?utf-8?B?VHI4dFk1a2srNmZBclFibWNQWGxDZUtqbERLbnNmN3l5dW81R3J3TFdVR2lS?=
 =?utf-8?B?bkF0RHh6NzAyc1A3QlpNeFNhMW1BTFpYTzRKQjEray84NXdLV1pDbmQ0SHFS?=
 =?utf-8?B?V2o5OTJmNXA1QThQOWxRYUpzOUl2TzZEc3JMc1UxMHVOQ2VyN3pMYUxDT2tG?=
 =?utf-8?B?V2FNY3NBYnQ0WlR0bHVyby93djJibVVkUEdNWG1VdXQwNFE5OHdaa0dJTzNR?=
 =?utf-8?B?eGdVT3VMdzhBZktEUnd6eHMyanB0UjRiRThBSmlYQXJVMWdzUW9NRkRGU3Uw?=
 =?utf-8?B?aXFmUkd0WjU3ZVlvcFJ4UGRvRmNjdzJTdXF6cE0rL0VDTFRTaE1JWFlrMllZ?=
 =?utf-8?B?S25jNFB6aUxGM3lYZUJOMXdpVyt4UGV6S2l5UUd5M0k4YisyZjZFOVB0ZmRC?=
 =?utf-8?B?MmZJTjFjTXZETi9RUzdRblVMV2IyQ04wNnErTDNEZHhCM2VLckhCTHprZVYr?=
 =?utf-8?B?Y1RPQ3pPdUcvTGVpZmFYR3RoSW91M3M3ZWhNcWlNaURNOTVKUjFvTTR1Vk1T?=
 =?utf-8?B?QkZ5MGl4R0ZUYms5dFJ2dXdzM0ZWeGc4dDFRd2ZRY0o0RG5VTzdQMWpVZjJU?=
 =?utf-8?B?dUpmYzNacUg3K1B0Yko5Z3BUdy9Kc1U0SHRmdlZ0Z0RNajVBTnFmbjcxME1D?=
 =?utf-8?B?d3ZSTzZKNXFSeUZFSUtJMUpqc2lEWjhUZk5sQ0NpTUdQeXA3aVBDczJCaWx6?=
 =?utf-8?B?TFc1QlRnVmtPaGR4WXJkVVBsSllLQUU5NkZYbkgvbklFeHZKV0FnTnRGMTJp?=
 =?utf-8?B?d2pUdkJIVkJhT1l5emhuMEoySnN5bEZTY1JFeDNoZGFrRkFHekEzdXRKUmcy?=
 =?utf-8?Q?ZAW0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbc755e-d39e-40aa-224f-08dc6535851e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 14:39:32.0542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4QKTWShY7sWTPBO8pGhglqSGcWQr/ZBPaVHfO9otLeTc/fWYjgXW0e9DvM6w8GIrAfnjOYr4ZDbTZtorUBldw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017
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

W1B1YmxpY10NCg0KPiBMb29rcyBsaWtlIHRoYXQgaXMgaGFuZGxlZCBieSB0aGUgc2NoZWR1bGVy
IHdvcmsgaXRlbSBub3cgYXMgd2VsbC4gU2VlIGZ1bmN0aW9uIGdmeF92OV8wX2ZhdWx0KCkgZm9y
IGFuIGV4YW1wbGUuDQoNCkNvb2wgc28gaXQgaXMgYmxvY2tlZCBieSBkcm1fc2NoZWRfc3RvcCBh
bHNvLiBJIHRoaW5rIHRoYXQgY292ZXJzIGV2ZXJ5dGhpbmcuDQo=
