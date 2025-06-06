Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FEBC5B549
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 08:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ABE210E361;
	Fri,  6 Jun 2025 08:01:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ymO25VmJ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DB810E361
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 08:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uw7gYuMTiY9OWSqeY4bVCB+M/L1mfg4ltHkSzwlg0bI3GQjvwqcGrF5acjG6pqLtDAGt80S8TWn+rCE9GvQC8PqwHnm/gzGq/2KnK3GQuf9xHlS1dCv/kK5eu9irA7mFa9xXvNjUBLGISvFuiQoQcEr2xzo5WVO5t56JHQ3baVYWvBK32Cn7clNh87/wQqIkbwlUNPLtZSc87qmqZhC54iei0BVXEaR8jakHwIqI8uYVsd7QbkhYCFOAEumOjCSCem4b2bgqIpP/0PGOLTFCN0wr1NRbhYGqKHJ/iLpmAMCPpLbHaiH1kXlJLmUJttnM3jl8kiP2eI1P8Pp0Ar28vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iB8jkNjM+VvNnc6drxagOHyG8OcpIA8+ojVpDUq+CI=;
 b=ctOdBayFQlDBD+Q29Z0neBkpZpXCtRck5faJLxyya82UttloOjaCgUGFX+hRiIkwcwwhIjXQ6pGOunyLW175MnbZ1KEVvvM/5hrIVl7Jey2rBz9j3jtS/yzp1RiRoD8TC0K5a9wnDYxiOEhv+b6E5qnh2HnOP++ZZambPONjtINVC+TP2BRLl3eAaasb3fFO/cqBP2ftZ3UXdwc2KOvSZSaTojSRKswVsl9a7cmfqbCQFj9zQ+9kti68UKmYzSgrvurvXpleEbfw2Vy4RnDL15flmqyivLFZk+hHpS73BtfoMG7/pjULl3CioWttmgXFGcHZMcCvmLOCpLRrY+/b8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iB8jkNjM+VvNnc6drxagOHyG8OcpIA8+ojVpDUq+CI=;
 b=ymO25VmJwPo+793egWvN4EkPZFne84k2Jg6Ro1uzTpgyEuQhY3A1wbv9IimDjG5HrXuaykMKf8jRd7/cRtgeNtlDF6uxT7q5PuZN5Wor/RsMCbvXGtGU7btCyfBSlUzQusmtkjE/BgAF1xIBbWoVGi3B+kzMCDdR0nPxHSzk0nI=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 6 Jun
 2025 08:01:04 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%7]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 08:01:03 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 9/9] drm/amdgpu: validate userq activity status for GEM_VA
 unmap
Thread-Topic: [PATCH 9/9] drm/amdgpu: validate userq activity status for
 GEM_VA unmap
Thread-Index: AQHb0Tg6LnKdYSvlfUexW3DcvtQeK7PvusgAgAYTjIA=
Date: Fri, 6 Jun 2025 08:01:03 +0000
Message-ID: <DS7PR12MB6005078415978A8C75E5F21DFB6EA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-9-Prike.Liang@amd.com>
 <df2fb46f-0180-4b2e-b29a-8c65fe0ddd68@amd.com>
In-Reply-To: <df2fb46f-0180-4b2e-b29a-8c65fe0ddd68@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=3dac24f3-75eb-4e89-b78a-396eb7b855e9;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-06T07:56:00Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|BY1PR12MB8447:EE_
x-ms-office365-filtering-correlation-id: 73ab11f5-cb2f-4f4e-813f-08dda4d048db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WFNjZk9RMmo5Tko4dUxhUzVpMWx4eVdicWpGcVNaeU8wdUFCcExNSWtlSTZ0?=
 =?utf-8?B?NXczbTF5QnVpNFZZVm9GN3NlMW1WekFWRzl2S05DM2s3eG02N2hnUE1mVEdQ?=
 =?utf-8?B?elUzb0hFTnNDK216MktscVQrS3owd0hYMzF3VDZOb1hCSTZXcWMwbWg5UXV5?=
 =?utf-8?B?TklJY2w2MllVQ1I5aEptUUpkamhBZUJ1LzRBT3RSTHltemkxM3lkbW1sK1FC?=
 =?utf-8?B?R1pnTGJlbmIzRWIrQ2ZRUGlDUGx1TGJPYXpIcE5ENldVMGYvWFZOMElZSG5q?=
 =?utf-8?B?Q1lIQ3BvdDFHOUNpRERkdSttODc1eG1tcGJLQ1cwUTNXVmE2RVZNQTc1VmRL?=
 =?utf-8?B?dkhKMVRMRThuQVRUaG1Va0RqM0dzcFcycnlwdUVMeEVlSE1GMDZ2V3FCUnNY?=
 =?utf-8?B?TCtHdkMxWXRqVldVY3A1dlR4ZUI3MWZkSlc3cDJwTzI1N0hLNWM3OGh3elVs?=
 =?utf-8?B?L2NKL2J3MUdSM3pHTzkyK2k1V0NEa0lRaDJ5WUdoUnhISFpMaFB4Z3NqSTR2?=
 =?utf-8?B?ci9ERnNGdzViK2xaN3dNNDBqZGdIUlJhRjRIZUI4aG0rM3FqTkxNZ3hic2lN?=
 =?utf-8?B?ZnNNNHBPckIzL0NGU3hicmRXUy82THArdXkzTzFmc3ZObzFuSTZKS0k1aXA4?=
 =?utf-8?B?RThkV2YrVVQ2cGhyMmMvdGJ4bTUwNlEzaFdwbUgzZHl6SW5zazIwWGRIYzQ4?=
 =?utf-8?B?R3JOWHBnYVBKaTdqQ1pGVHVrY0pHWDRIdFRXaXc3UFNKU29EcXNrK0I1RGd4?=
 =?utf-8?B?K0htMUdYRmxrVFBNZHR6NUc0YUFLMHpzejg1K1FzOFpiWWJNckxlL2tGZ3Ns?=
 =?utf-8?B?cXl5SGd2dVhaSEtra1hnY3hyUGRUT0p1K2ljSWZOZitvVmlDRG55bTVKMG1I?=
 =?utf-8?B?YURUSnZUdG9XYWo3RytnQkNmOW1obHd2SXlqak4rYjNmenViWHpJRzNSWGtI?=
 =?utf-8?B?bE1QV29jUEdRd1o1bFdRSHlSNThxSDhNbEhJdHliUlV6dFBML1h4MUZNdEVJ?=
 =?utf-8?B?STRsTGhYWFJoQXI5czhwQ01xcUFMVklteUdGTFBHbmRJUjcrYU5PMTNHdGhp?=
 =?utf-8?B?NlpFbW5WWjdjMEpCcExNa1hYREd4QnF1UUxZa21HbDhhQmVXd0JualJFOWJx?=
 =?utf-8?B?eGdXQitvWXBmdy92QmtzdnNqYmZhQ2RTUnhJRFYwZk4rWXJMdGNRdDUvc1h1?=
 =?utf-8?B?TWZsTXhTVlloNGlva0tvMnZobEk2RkNNM2ZIWk0yQXNlSWxlSktaZzEwRGxm?=
 =?utf-8?B?VzFvc2dSZHFkVDh1Nkl4MlpBMldPa1M5bi9wQ01MTGxOUWZ0N2w1NXBONEJv?=
 =?utf-8?B?c1QrWDA2UnQzNEQvT29weU5xcU5iVlI0em9Ham91SEZzNTl2SERIVTBYUnA2?=
 =?utf-8?B?SmJ5RmR4WUxQTmpQd1c5STRHWDR0MEVJcDNWa1lpakNpd2xtUk96TXlUWjRY?=
 =?utf-8?B?MDZJcUZrT3ZzOWhKUGZNSFBJczRVeDl1bDdpNjRxbWRUMHNVVUFuRzEyQWZo?=
 =?utf-8?B?WS9RKzNLU0hYVGpoV0Y5WGhEdVpwb0h4SUkva0lUTzdzeWJnbUtkNC9lTGlN?=
 =?utf-8?B?MWxVMzEzZzhXRGt1bVhSSVdrM1pVOXkxZVM5a2M3blArRlBJU3hISUV4a0lL?=
 =?utf-8?B?cGNIVm55NTlSeTdWNGFMdEc0c0M0RDFOZFVtYmhmUW5UZkM1Y0xWN2FxV2VO?=
 =?utf-8?B?d2E2eHF1eThySE9wUFR4czZTUUgrb2xVSFcwTE1jL1E3djF1V3ZsU0xoNWt2?=
 =?utf-8?B?eTRVL3E4U0V2SVFOLys2K1RMK05BWGYvL1IxOTB2c1BQclRDMG00bVZrUWpm?=
 =?utf-8?B?WVI5aElOaUllYllsdlVQcVQ4WHVqeVdDS1Z0V0h0T2s4TUNHSXdFVElzR0Y5?=
 =?utf-8?B?NjFnRFl4MTF4K0V0d1AxcFFReUlCRi9LaUxuMWJwcFJYSlZmSk9uWWE0ZVFL?=
 =?utf-8?B?S0ZaV2NJTlpnTmNQYzJxWmxpRVRsQTlaYUFuMzdJMDhEK05ZY3FNTFUzYndX?=
 =?utf-8?Q?8bfrmvwMQPbuUFtTkOnLDFuOBrI/4U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1dUemNNTEZIYmQ2WkNLYTNmTDZDVnhkVXNrUXY4Yy9Jb2lESTFQbWFYZll0?=
 =?utf-8?B?TVh1V3Jjd1JIeGVCaHJOUUpFeWVVdmZmNVMwTEZBNVZDaUNjL3VmT2pFeVRq?=
 =?utf-8?B?MjRDc1h3TldqVkpjUnliVWJjS3BrY0ptRnI5UUc0Znh1cXVDa2xIZTl0SXRL?=
 =?utf-8?B?Y04yUkphYnQ1UGIzUjVlUHVETVZKZExkZkczUGE0bDBZQWJEaFZtK1YxTWVM?=
 =?utf-8?B?QUFmZEtTUDNTbFlXQmlIWUR5OGRWN0hYTEFZNUxYVU80c3JhNjQxNmVMZ29l?=
 =?utf-8?B?UUNUdDNWVUR1MDl0c1ZUdHUwSnNVZnhjNWFXa29LZ3ZpS2d3UG9GVkZPWmNJ?=
 =?utf-8?B?aXB1bnJkTy9zMnpEOXM4c2xhRmY3TU5mOWJ3RGdUNWF0OXBjRFBJdHAva2Q1?=
 =?utf-8?B?RGNHV0xnUmtEQXpkL3ZHdnJDUk82NmxwT0dUTDFjWTIzU3VXK2U0SjAxWmEz?=
 =?utf-8?B?ajh3U0wyaUFSTlFVOVdOMFhuZ0FGTEpmUEVzZHZhb1pHUXQ4UXBSdlFIdTNF?=
 =?utf-8?B?bFZGZm5FNENPamZxV0NUcVc2ZG0wMU9KQXlkK2prL2FTRThueFlSVnFPbHFt?=
 =?utf-8?B?eVh4dVRlUGVkTDZRN0ZXdThSYjlOUVVHSW9BSndQN0hTV0d4YVgvRm1Vc0t1?=
 =?utf-8?B?STN1SjBoa0hjVkd0WUhLSm95U1NpeG9pQ3pCVkxGYWV5YVN5aUdaOWFoN2xM?=
 =?utf-8?B?WWtsNUNkWXlIQVYzbGk1TFdYU25qV0hhN00vZmFyYXZyOWcxRmRRd2trckp3?=
 =?utf-8?B?RlRZMUlXT3J4WEQvcVNNblFzb2NYYUk1TFloRlR4L05YSkwrVjFKQitOUlVu?=
 =?utf-8?B?eGR5OS9qb01mSEhoMDhvQVFkbXY3RC9zV29WbUM3cEoyUTk2TXpBRkxSQ0pa?=
 =?utf-8?B?SmgvMWhQY0FldG5BY2dtS1k5R1daVTEvdlBRN0xPY2k2a2dNUWQrS0hPakNE?=
 =?utf-8?B?c1JvVWRQVy95Nm52UWxPMlJCTzNhdlBtMVRxaXdQZ2JPZ0x2bDIzQlYyUm5y?=
 =?utf-8?B?d3FrMm1BMUdCd3lqR2R3WVR2SUxIaGREYmxlZ3dBSmUwZ0U2OFFBd1A0dzVD?=
 =?utf-8?B?bjhsdnRRNENlV1RZTmVOcG5zUFI4dkduVXAvY1dTaEs2N3lqMnZwR2h0Wmxj?=
 =?utf-8?B?KzJsbElLREkwbUIvRWtTRU9CdmNWcW9tUXlXbndxNEJrTmZOL21RNDNiamlS?=
 =?utf-8?B?VU16UjRWMG0rQUoyZEtNYTNEZmlIaXV3Vmkzak9zczRybUZQYVh5Mm1wRjBR?=
 =?utf-8?B?TDhvQ3dDWk9DaWsrOWJhMFo5UklqRnJLSDloMzVaZjFIR2pHUTU0b242L2Jn?=
 =?utf-8?B?RXhqZE9aR3NwQWI0RTJoL2FqQzZEV3JtQ2tyYnNaL2RxRzh0QklDV2M0c1Ey?=
 =?utf-8?B?cFY2RnlZTDRZMlA2aUw3M1dtbGxJSW52TnJGK0tkYjI0RThPclFYUDgyNGFH?=
 =?utf-8?B?RnF0aXJkS01ZaTR0U2l3MmxHa3I2RWhMUkhOZm04Wjh5dHhzZUlOMnFSbnU0?=
 =?utf-8?B?aW1xdlZRUE1QWTJUR2xPN2lhTnNGWDBzZ0VyUGRmUHRFNXNySFJ2a1ZqbmZY?=
 =?utf-8?B?OUlQSXlzMkYzbWRVVlovTEtxTzdza3F1QnJobEgxZThDa3JBdURmaGQxVEtZ?=
 =?utf-8?B?b0xaU2RNMmd2N0x4T3grTzdJR0twTGt6U2lDb2VwRzh2MmlXVG5xUFpXRis0?=
 =?utf-8?B?QmZNR0pPUzhORFFodkh0cmNUT0pkL3liK3diSjFkTnRtK1Q3YVlXa1kwbzk0?=
 =?utf-8?B?elJkbWFDQWx6ekZuS2I3cGhtckFMRVF4TFJQV0wvK3FqdHQ3UDloREh3bUU2?=
 =?utf-8?B?a3hOdlpudUgrZFlxakFGSnFnMGd4eGNvam1WQjRsQXUvRTVSSVRaQjBadTdj?=
 =?utf-8?B?WFAzR0ZPaWlJb0JCN1pGMXlCVTVsTlo2blRTRy9TQ1UrTElWWEVKTVp4Z2sz?=
 =?utf-8?B?K2hXclZKMXArMlJVRkRETzA4S2h4TWVSTStqelEyd3lpajR5dXF1MlBNam1k?=
 =?utf-8?B?b0poN2YzeWhVMm4zM2RCNng4eEdqOEtRbllDQXRzMVY2WDJDTEQvQUNwdmdE?=
 =?utf-8?B?a2FBU1U5NEJDdDY3QUZ5REM5TURhdU5sRG00RkRhMDV0aFNSRCtNbklOMzlD?=
 =?utf-8?Q?S4L0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ab11f5-cb2f-4f4e-813f-08dda4d048db
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 08:01:03.8621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0bDYnE6ICYtrlKEUay6K/eFJmybFKuFFwSYVbkMcBPJphjxFM9lBpegWVZrwWt6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMiwgMjAyNSA3OjA4IFBNDQo+IFRvOiBMaWFu
ZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgTGF6YXIsIExpam8NCj4gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCA5LzldIGRybS9hbWRncHU6IHZhbGlkYXRlIHVzZXJxIGFjdGl2aXR5IHN0YXR1cyBmb3Ig
R0VNX1ZBDQo+IHVubWFwDQo+DQo+IE9uIDUvMzAvMjUgMDk6NTUsIFByaWtlIExpYW5nIHdyb3Rl
Og0KPiA+IFRoZSB1c2VycSBWQSB1bm1hcCByZXF1aXJlcyB2YWxpZGF0aW5nIHF1ZXVlIHN0YXR1
cyBiZWZvcmUgdW5hbWFwcGluZw0KPiA+IGl0LCBpZiB1c2VyIHRyaWVzIHRvIHVubWFwIGFuIGFj
dGl2ZSB1c2VycSBieSBHRU0gVkEgSU9DVEwgdGhlbiB0aGUNCj4gPiBkcml2ZXIgc2hvdWxkIHJl
cG9ydCBhbiBlcnJvciBmb3IgdGhpcyBpbGxlZ2FsIHVzYWdlLg0KPg0KPiBOQUssIGl0IGlzIHBl
cmZlY3RseSB2YWxpZCB0byB1bm1hcCBhbiBhY3RpdmUgcXVldWUuDQo+DQo+IFdlIGp1c3QgbmVl
ZCB0byBtYWtlIHN1cmUgdGhhdCB3ZSB3YWl0ZWQgZm9yIHRoZSBxdWV1ZWQgdXAgZmVuY2VzIHRv
IHNpZ25hbC4NCltQcmlrZV0gWWVzLCBpbiBhbWRncHVfdXNlcnFfZ2VtX3ZhX3VubWFwX3dhaXQg
KCkgaXMganVzdCB3YWl0aW5nIGZvciB0aGUgdXNlcnEgZmVuY2Ugc2lnbmFsIGJlZm9yZSB0aGUg
a2VybmVsIGRyaXZlciBjYW4gdW5tYXAgdGhlIHVzZXJxIFZNIEJPLA0KYW5kIGlmIHRoZSBmZW5j
ZSB3YWl0IHRpbWVvdXQgYW5kIHRoZW4gd2lsbCByZXR1cm4gYW4gZXJyb3IgdG8gdGhlIHVzZXIu
DQoNCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtl
IExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyB8IDE2ICsrKysrKysrKysrKystLS0NCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgICAgfCAgNSArKysrKw0KPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJx
LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4g
aW5kZXggZTQzYTYxZjY0NzU1Li5lMjI3NTI4MDU1NGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IEBAIC0yMzQsNyArMjM0LDcgQEAg
YW1kZ3B1X3VzZXJxX21hcF9oZWxwZXIoc3RydWN0IGFtZGdwdV91c2VycV9tZ3INCj4gKnVxX21n
ciwNCj4gPiAgICAgcmV0dXJuIHI7DQo+ID4gIH0NCj4gPg0KPiA+IC1zdGF0aWMgdm9pZA0KPiA+
ICtzdGF0aWMgaW50DQo+ID4gIGFtZGdwdV91c2VycV93YWl0X2Zvcl9sYXN0X2ZlbmNlKHN0cnVj
dCBhbWRncHVfdXNlcnFfbWdyICp1cV9tZ3IsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICpxdWV1ZSkgIHsgQEAgLQ0KPiAyNDMs
MTAgKzI0MywxNCBAQA0KPiA+IGFtZGdwdV91c2VycV93YWl0X2Zvcl9sYXN0X2ZlbmNlKHN0cnVj
dCBhbWRncHVfdXNlcnFfbWdyICp1cV9tZ3IsDQo+ID4NCj4gPiAgICAgaWYgKGYgJiYgIWRtYV9m
ZW5jZV9pc19zaWduYWxlZChmKSkgew0KPiA+ICAgICAgICAgICAgIHJldCA9IGRtYV9mZW5jZV93
YWl0X3RpbWVvdXQoZiwgdHJ1ZSwgbXNlY3NfdG9famlmZmllcygxMDApKTsNCj4gPiAtICAgICAg
ICAgICBpZiAocmV0IDw9IDApDQo+ID4gKyAgICAgICAgICAgaWYgKHJldCA8PSAwKSB7DQo+ID4g
ICAgICAgICAgICAgICAgICAgICBkcm1fZmlsZV9lcnIodXFfbWdyLT5maWxlLCAiVGltZWQgb3V0
IHdhaXRpbmcgZm9yDQo+IGZlbmNlPSVsbHU6JWxsdVxuIiwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBmLT5jb250ZXh0LCBmLT5zZXFubyk7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICByZXR1cm4gLUVUSU1FRE9VVDsNCj4gPiArICAgICAgICAgICB9DQo+ID4gICAgIH0N
Cj4gPiArDQo+ID4gKyAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIHZvaWQN
Cj4gPiBAQCAtNDY0LDcgKzQ2OCwxMyBAQCBhbWRncHVfdXNlcnFfZGVzdHJveShzdHJ1Y3QgZHJt
X2ZpbGUgKmZpbHAsIGludA0KPiBxdWV1ZV9pZCkNCj4gPiAgICAgICAgICAgICBtdXRleF91bmxv
Y2soJnVxX21nci0+dXNlcnFfbXV0ZXgpOw0KPiA+ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFM
Ow0KPiA+ICAgICB9DQo+ID4gLSAgIGFtZGdwdV91c2VycV93YWl0X2Zvcl9sYXN0X2ZlbmNlKHVx
X21nciwgcXVldWUpOw0KPiA+ICsNCj4gPiArICAgaWYgKGFtZGdwdV91c2VycV93YWl0X2Zvcl9s
YXN0X2ZlbmNlKHVxX21nciwgcXVldWUpKSB7DQo+ID4gKyAgICAgICAgICAgZHJtX3dhcm4oYWRl
dl90b19kcm0odXFfbWdyLT5hZGV2KSwgIkRvbid0IGRlc3Ryb3kgYSBidXN5DQo+IHVzZXJxXG4i
KTsNCj4gPiArICAgICAgICAgICBtdXRleF91bmxvY2soJnVxX21nci0+dXNlcnFfbXV0ZXgpOw0K
PiA+ICsgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICB9DQo+ID4gKw0KPiA+ICAg
ICByID0gYW1kZ3B1X2JvX3Jlc2VydmUocXVldWUtPmRiX29iai5vYmosIHRydWUpOw0KPiA+ICAg
ICBpZiAoIXIpIHsNCj4gPiAgICAgICAgICAgICBhbWRncHVfYm9fdW5waW4ocXVldWUtPmRiX29i
ai5vYmopOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4g
PiBpbmRleCA1ZTA3NWU4ZjBjYTMuLjE2OGZjMzgzNWFhZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+ID4gQEAgLTE5MzAsNiArMTkzMCwxMSBAQCBp
bnQgYW1kZ3B1X3ZtX2JvX3VubWFwKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2LA0KPiA+
ICAgICBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSA9IGJvX3ZhLT5iYXNlLnZtOw0KPiA+ICAgICBib29s
IHZhbGlkID0gdHJ1ZTsNCj4gPg0KPiA+ICsgICBpZiAoYW1kZ3B1X3VzZXJxX2dlbV92YV91bm1h
cF93YWl0KHZtKSkgew0KPiA+ICsgICAgICAgICAgIGRldl93YXJuKGFkZXYtPmRldiwgInNob3Vs
ZG4ndCB1bm1hcCB0aGUgVkEgZm9yIGFuIGFjdGl2ZSB1c2VycVxuIik7DQo+ID4gKyAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKyAgIH0NCj4gPiArDQo+ID4gICAgIHNhZGRyIC89IEFN
REdQVV9HUFVfUEFHRV9TSVpFOw0KPiA+DQo+ID4gICAgIGxpc3RfZm9yX2VhY2hfZW50cnkobWFw
cGluZywgJmJvX3ZhLT52YWxpZHMsIGxpc3QpIHsNCg0K
