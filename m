Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FA2CAC58E
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 02:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E5010E401;
	Fri, 12 Sep 2025 02:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wAkx+3wb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762F510E401
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 02:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byLqWZhbtKwTY80uF5tKS+E9Xm5WKDGGCqU3GdK8KVka2FeabECnesTQ9wb2z0TaXl3GBrdOAn+j2g9Lxncv2HAIH+4yOUUvsa1Qr7hU9BE+TATVk0i3pqsVaqlQLEXdpimf/6dWi+vPp3tFy7KkTYG6O8Z6Vuu6iaockJtddUA/OygfLDIp3lmgEww3dNYcUHFrcS8DU3DRbUu9ZiXZ8kCOeEi85TyAOEodZxVeJ7t9W2foqEH6iv2cejxaNToWztL8qAes2rs/oZK2aJrLrjfeyfzH2Vnsqkuz7KhXvZaINPcZ41L676wTYNMd7h5LkMM/b+4N/cSMeg+QPY9RfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKokwguJSpBD92nbMS4wtE1HojxFRtU1DzeAB21EIVw=;
 b=e6Cd4NgocfbIwowLGeb7ilNUxQ+NKsJHEKVajgIxW+AesTnYrVtDPt7pn/mwf4UAD5CwR87V0oSWIAqHMDinyfo5ze3G/Q+Wl9fGUKpoDzyPLdzHu9kfm7ioCa9a/wVVwZl8Iaeao1jQws7oIY2MxDDSZuZ1z94tNBcfnGUIac48qfolkQyD8/JqFEwcItSMFLaqjKlEkp5kDsDbEdJTT3rbRcvCoNdCQkyLBMbxQEUKjtSwg8LNEId2XWtORbSHxqSJpncrOh2lPBpR0YiWBu4FKbiQ6ppnbGq8Spi9iJVVond8lgrNJ959CG9TJL6E3aHZQNFK/5qCvbj4UPNsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKokwguJSpBD92nbMS4wtE1HojxFRtU1DzeAB21EIVw=;
 b=wAkx+3wbUTPw0xeUd+ygbZJJWffTVW3aTVVTO1qrmSAwOcZMVM3a2ZCVt/fWl4YFe1tHi6EcSUikdzJv+WoxdGjI2xnfqLq4xSTyDC58DL44Bs8X19zDKxmdPx7BDdpdWO3O8keyfkb89kz6vUPpAWuyBJNSIYW40MEISpsvPVQ=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 02:09:05 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 02:09:05 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 1/9] drm/amdgpu: add UAPI for user queue query status
Thread-Topic: [PATCH 1/9] drm/amdgpu: add UAPI for user queue query status
Thread-Index: AQHcIkdYO5+qqZTWh0KlKZhRZTSyALSOVpOAgAB33qA=
Date: Fri, 12 Sep 2025 02:09:05 +0000
Message-ID: <DS7PR12MB6005E88285AAB4AAE49BA111FB08A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
 <CADnq5_M+Ys+v=proV=Jg3cDh0REEg0EB+-VtwvMkCdGt9BTXLg@mail.gmail.com>
In-Reply-To: <CADnq5_M+Ys+v=proV=Jg3cDh0REEg0EB+-VtwvMkCdGt9BTXLg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-12T02:04:05.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH8PR12MB7026:EE_
x-ms-office365-filtering-correlation-id: 8b7cfc64-e315-43d3-17ad-08ddf1a159d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eVN5UkFXaUR6SlR2cUxzQmJVYU12NWpIS3E0c3JSTXZCcSs1dDZodFptMll4?=
 =?utf-8?B?d001c1VxVEtwYWFkVXdtVjlHWkVkTGF6dS90clIrb3hOc2lGQm9EaW1hWDFl?=
 =?utf-8?B?UURDTDBkeEFzaUppYlJkVzRLWGN6TzRzdzRNNzBPSUl6REZzRFN5MnFraG1N?=
 =?utf-8?B?bUNBQkt2OFFySW1ydlEyMzduclFlaXRoVTBHZXZWRTgrY1ZDcmpmVWJyUjlw?=
 =?utf-8?B?V3haeHlHZjJtV3ZZM0pjdjhRZDVOcThIanQrUGNNMzY4RmlJVUxwczlzOFJr?=
 =?utf-8?B?ZnNocnhCL1ZwbzA1V09CamROOWQzQWhVUlkxV0NGMWxIbEV5TkVacW9Rb1Fq?=
 =?utf-8?B?Y2JsaFFUOEFqOVA2cTZ1Ykg2c3JwWlJoeXNXbHZsOHh4M25NblFPeXkwR3Vs?=
 =?utf-8?B?TXRMc1hBend6TlJlci9uMDExZnE0c0VNQTk0bUxQd3h5ZVhKeWtUV1A1UVdi?=
 =?utf-8?B?N3JPMHBFOEo5QXQzUTQ4dWZFUGkyNU4yc3BJelNwdUp2T2JpQi8zUVhzdGxO?=
 =?utf-8?B?SVI2VVNwLzNLNVFWUk1jeUplalJhT3Bic1FkTmZUQ3NLVkg5bFI3SXJhdFkz?=
 =?utf-8?B?YXZIQ0p5M1FCTUVMVjZ1ZGZkQ0N2ajFEeFUyWExhODVHNUtXS1BuVUlhWU52?=
 =?utf-8?B?WGNNSm40cWhHZHRpblY0dG9rUjIrQWpBWi9Ld1UvU2ZzSWFJandLY29JNG9o?=
 =?utf-8?B?LzlmTmlEZlY1bERGMDB3UWk2SzlWUEMyVFJtZEltWFQ0UUJySXY4bm5xMWJE?=
 =?utf-8?B?c25lUmxvdG1pMDVrbmlYQmRNRmdkYkRqTHVrUXpUWkw3T0Nqai8zL1BROWlF?=
 =?utf-8?B?TzFRNUY1RVZGdWFUbjZLSE52T0kzTStvcTc1bzVIWmRCa2FhdmNQb1pETG9a?=
 =?utf-8?B?RXM2RkZFRnkxSDJKZzNXQm12NmNXcDF4ZlpKU1pxT3B1QVRnbnZGRVBqRWhT?=
 =?utf-8?B?ZlNnWi9yZGhiNXZlaHdvckludUQ0b1VEYSs5Y1ZTbEtRc04vNmRReC92QUkw?=
 =?utf-8?B?d0kwNjdtZjdES0htV3lLaWFsTjdwcjRubjZ6bTJYZlFIWThDbWdZWGVwNGVz?=
 =?utf-8?B?VGRwazB4L25RbTBveDY0V0VOUWNqa3l0S0ZEN3VsL3NndUF5K0FQZ043dnNP?=
 =?utf-8?B?bGpET1Q4a3RGTUxCNXlobXFzQnFTRGZEZS8yVWZacHU3OHN1dnQyTk5ZbG5G?=
 =?utf-8?B?cU95b1d6UEZQeFp6dmVZRGo5ZUtyTmNpdXBST1F1eGIzWEg0a0xUNXYrZjFX?=
 =?utf-8?B?Zk91WDY0cnVaOHlBbTRXNmxTMklxelpocmNsN1hsTms3ait6M1F6ZHhQbHVD?=
 =?utf-8?B?RTh4YXJxUk1rT1kzbDF6cjQ0em9nQUhCbkg3MTA0Z3cvRzhwdEFCem1PNXpT?=
 =?utf-8?B?SnQ4MjNWcjFhS0J5Zmk3WWRxZGR6dVFlZTlsTE8yMWowUDAyVG9LTmhCNVY5?=
 =?utf-8?B?RFVhM0xmZXhaWXorY1BvdFJpNVhFMSt1Z2g3WXVERWYwVk9wSzJrb2dJUlR3?=
 =?utf-8?B?MVJodktJOWFnN2d0dlRvd1ZDLzVTanFPUFl4eTV4Q1duRi9xVFVPQnhlam9z?=
 =?utf-8?B?RlhMWExvZkJ4Zng3K0lGMjBVTDlhRkFPdFMyY2FqM2FmM05KcmhsUCtMOTdZ?=
 =?utf-8?B?c084ajN0TzNzMkZYYWp0Y3k4MFoybDdZRUhWbWdjL0RydXNMUGduNjh4VmFk?=
 =?utf-8?B?V3RVRVdQQ0dIcW9LME1SZFZVZ3llMFZtdjAvWFV1OWNUNzJrS1BUejUwRVNt?=
 =?utf-8?B?a1dSeE9OVjR4VFpDNGpudkducDF1TXNyU3RhL0Flazd5UG1sdUZ2cnkwaXNw?=
 =?utf-8?B?SmlIdWY4L2hvNmpiZlhmTHk1RE1wSVdYVGlvTFEzWGlyZHVSZlZ2S2YvQm50?=
 =?utf-8?B?Mk5VcElXczJ4WmM1Y3lacS83Y3JZSG9ON21PaDVucndsNWw3UDNWTXo3S2Jm?=
 =?utf-8?B?UkZGSVF6cUxocnFCWTl5eFhJWlBXMUhkTXZ6OG0xTVR0WW1haDRzdDJFUW1x?=
 =?utf-8?Q?sKfG48FFyKul5KVc2DTel3M84zFqII=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXZoZ1NuK1Bud0p2elIwUGpvV2pLRkM0bk8yRGl5S2pjVWJyNUFhcWZoaWJZ?=
 =?utf-8?B?U3ZTZ1kwWDQyQnAycWhDbTEreGFXUTZYb0NqNCtPdWFZUzBIejhWTnNIbGN4?=
 =?utf-8?B?UVUzS3Z6SVRrSnFSNnBSR01rQnBNTUUvSDVxaU9xZnJMNFZWRUx2R0hLdVFO?=
 =?utf-8?B?dHpPQjIzRWtLWk13eTVxb3M4YUFCQjlFYWdRbklUUE9GNkpQYU9XR2V4RzF6?=
 =?utf-8?B?THhaWHp1TjI2RDRnaU5SMlNXeHlvby9vSUVSTTJ5WEhicTVFVFRaQngwQ3VZ?=
 =?utf-8?B?VEhyUHZ1c0N6ZDI0VVp3QzJoMlNkZVkyVVd1S2lOWnBOMjFWRHpPRFl2MUZO?=
 =?utf-8?B?a3U5R0FwUGpNTkFBZ3d2eS9lTENTRVdQTFNoczlFQ2d2ZWFYdGwxUkU3dkN5?=
 =?utf-8?B?UEV1ZmUzVXQveFM0ZytWVXVIQURaNDJuUjdjVklRVWVJSTFoYVBVV29GZU5I?=
 =?utf-8?B?cGJ1RDE2MVI2ZDZ3Z2ptNmowVWV2MXdYNnkyVzJIV0d6WmNNZTRkbUhJWmlZ?=
 =?utf-8?B?RFBaOUtoZ1dOVi80cndTZlpxMkFvdTd5ZjF2N0p2TFAzbjBjQks1VHl0TmFP?=
 =?utf-8?B?Ynk3d2xUdVpzZFdqeXIyQjJUeUpEb0pvS0VDNGMyeC9yU1lUcjZmNDJFUVVV?=
 =?utf-8?B?blVqV1hyK2lEU0xLOXJVYjczYms2U0RpSTF6Wnh5Tk40NmUwWkpZdE9IRUNX?=
 =?utf-8?B?aXhQNHpqaERvczhvQndXaXNnbzVtUGVlZ1d5dnEyL2d5dWdPOGxQd0NBVWgw?=
 =?utf-8?B?N0cxYWRSUDN3M2dITDhQcGhFaVErRlpzeEZXY2Vhell4Qm14VWZCbnM2bG9O?=
 =?utf-8?B?ZUtBRmNPZFhjMVI1WHQ5WEdxVDVYcVRaUlR4NjFGVUxrUnd5eWN6bnBTYzd3?=
 =?utf-8?B?RFR6SjVsZXNvSFM3M3hkc3RJT2VQSHE1cllDYXg5dDNiWFRuQTlxclh0YXBP?=
 =?utf-8?B?TVpzZXRCWm4yODZRQ0c3Ni9QbXp1U0o5dEdseEtBRm9OTXNhSW1xa3prN3FW?=
 =?utf-8?B?QVZiSjVSbWc2TGZxdTlHbGVmZ0h6a3NvS2dFazk1TDYyNVR6TDFKbmhkdkNL?=
 =?utf-8?B?MTAvSHZ2ckEzMmhmM2t6T3puR1dHSkFIMnFRdEd1bFl4MG1yNy9YOWEyS2Rj?=
 =?utf-8?B?b0lNOUJyS0taK3pLVzVkL2JqWjFEK3BlMkt3eENvem1EQWtqQmozVmt3SU42?=
 =?utf-8?B?NjF2NU1QODJFL05uck5DbHBpWElsZHIvUEkyQURuKzEyWlZ0ZlhIdTEycFRa?=
 =?utf-8?B?WGRnei9EK29sTFJKelBmMm5wajJDTUU0QVhuMWxpTVRIazAxVlpWbHZ6QnJx?=
 =?utf-8?B?ZlNtQk9OaU1lam1NMlYrVHAxRnU0QWNYaU1oY2hndWZ0Mk1LNVR1TmU2NnZx?=
 =?utf-8?B?UUZNcXByeXc4OG55YzBISFNYV1pxM1ZFTDM5VnZhN2N1YnE0SHR6b0ZvOW5w?=
 =?utf-8?B?MlVaR2VvdGY2RjFOSlF1VDlRbUU5UjdFME5waUUwT0RRVXdseFp0bGdQanNX?=
 =?utf-8?B?eW1FOGdZcG1mTVNqVmtDZGIwY3RqL0FTbi9meDRLTUIvdzF1bFhoZ1IxR2Qr?=
 =?utf-8?B?SitmbjNnakNPeHg0WmM5MWlxa0xtb0FiRGl5b1dFMHE4Q3AzbDQzazg2MUlI?=
 =?utf-8?B?b2VvZW9IZGV1RUs3QStqMERvelRNUG44SVdkT1hmeE41amNzYzJsZHVyMEZH?=
 =?utf-8?B?cHRZZWRJSGZVOERxWGcxRjRWNWR3THBNRFBSYWE5Zno4bENBT3hXMElSbmh6?=
 =?utf-8?B?b0xqUndPalB3ZjB6L3ovTzZXU2VzSE5NbVRpbGNmcE1tUVpSc2tOeHcvdjNX?=
 =?utf-8?B?bGNWOEV3OVJSRndUTWJ2RTI3WURCeVFMaytlZ0R0eVlyMDRXWU0rYVFqaEZh?=
 =?utf-8?B?azZ3cjJCTmRaOUc2cWd0ekc0Z3M0Qnc5ZkdJNHlpSVk5aGZNc1NsamlDZnpH?=
 =?utf-8?B?SndKWEhRUWE1a2doOHJibk1iNWFRWERKRHFpcDR3VUZpc3VNNmhPWG9uOHZ5?=
 =?utf-8?B?b1dmT2FXRW1rVXRIaWlnbGdMNVFjUTZaRTBBckVDYVBjOGRMYWc3dDRjQUYv?=
 =?utf-8?B?SXVwVG1veHdqb1RIRzliUTVZeHQzTHBpR3d5QUxvaUZ3VlR5Zlh3RDE5c3Iz?=
 =?utf-8?Q?L41A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7cfc64-e315-43d3-17ad-08ddf1a159d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 02:09:05.5096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pL6cpeEsrgJ9NdFZ1KCsHbbAto77dBcy0otLSpAFUaNLAGinvdNAe/Or02FJCsg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+
IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDEyLCAyMDI1IDI6NTUgQU0NCj4gVG86IExpYW5nLCBQ
cmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsNCj4gS2hhdHJp
LCBTdW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS85
XSBkcm0vYW1kZ3B1OiBhZGQgVUFQSSBmb3IgdXNlciBxdWV1ZSBxdWVyeSBzdGF0dXMNCj4NCj4g
T24gV2VkLCBTZXAgMTAsIDIwMjUgYXQgNzozN+KAr0FNIFByaWtlIExpYW5nIDxQcmlrZS5MaWFu
Z0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4NCj4gPg0KPiA+IEFkZCBhbiBBUEkgdG8gcXVlcnkgcXVldWUgc3Rh
dHVzIHN1Y2ggYXMgd2hldGhlciB0aGUgcXVldWUgaXMgaHVuZyBvcg0KPiA+IHdoZXRoZXIgdnJh
bSBpcyBsb3N0Lg0KPiA+DQo+DQo+IFdlIG5lZWQgbWVzYSBjb2RlIGJlZm9yZSB3ZSBjYW4gbGFu
ZCB0aGlzIG5ldyBpbnRlcmZhY2UuDQpEbyB3ZSBoYXZlIGEgcGxhbiBmb3IgdXBzdHJlYW1pbmcg
dGhlIG1lc2EgY291bnRlcnBhcnQgY29kZT8NCk9yIGNhbiB3ZSB1cGRhdGUgdGhlIHVzZXJxIHN0
cnVjdHVyZSBpbiB0aGUgZHJtIGhlYWRlciBmaXJzdCBpZiB3ZSBuZWVkIHRvIHVwc3RyZWFtIHRo
ZSBmb2xsb3dpbmcgbWV0YWRhdGEgc29sdXRpb24/DQoNCj4gQWxleA0KPg0KPiA+IFJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4gUmV2
aWV3ZWQtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+IC0t
LQ0KPiA+ICBpbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCB8IDE0ICsrKysrKysrKysrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gPiBiL2luY2x1ZGUvdWFwaS9k
cm0vYW1kZ3B1X2RybS5oIGluZGV4IDg1YjNjYTE0ZjgxZS4uNzI5MmY3YmZjZDEzDQo+ID4gMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gPiArKysgYi9p
bmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaA0KPiA+IEBAIC0zMzQsNiArMzM0LDcgQEAgdW5p
b24gZHJtX2FtZGdwdV9jdHggew0KPiA+ICAvKiB1c2VyIHF1ZXVlIElPQ1RMIG9wZXJhdGlvbnMg
Ki8NCj4gPiAgI2RlZmluZSBBTURHUFVfVVNFUlFfT1BfQ1JFQVRFIDENCj4gPiAgI2RlZmluZSBB
TURHUFVfVVNFUlFfT1BfRlJFRSAgIDINCj4gPiArI2RlZmluZSBBTURHUFVfVVNFUlFfT1BfUVVF
UllfU1RBVFVTICAgMw0KPiA+DQo+ID4gIC8qIHF1ZXVlIHByaW9yaXR5IGxldmVscyAqLw0KPiA+
ICAvKiBsb3cgPCBub3JtYWwgbG93IDwgbm9ybWFsIGhpZ2ggPCBoaWdoICovIEBAIC0zNDYsNiAr
MzQ3LDEyIEBADQo+ID4gdW5pb24gZHJtX2FtZGdwdV9jdHggew0KPiA+ICAvKiBmb3IgcXVldWVz
IHRoYXQgbmVlZCBhY2Nlc3MgdG8gcHJvdGVjdGVkIGNvbnRlbnQgKi8gICNkZWZpbmUNCj4gPiBB
TURHUFVfVVNFUlFfQ1JFQVRFX0ZMQUdTX1FVRVVFX1NFQ1VSRSAgKDEgPDwgMikNCj4gPg0KPiA+
ICsNCj4gPiArLyogdGhlIHF1ZXVlIGlzIGh1bmcgKi8NCj4gPiArI2RlZmluZSBBTURHUFVfVVNF
UlFfUVVFUllfU1RBVFVTX0ZMQUdTX0hVTkcgICAgKDEgPDwgMCkNCj4gPiArLyogaW5kaWNhdGUg
dnJhbSBsb3N0IHNpbmNlIHF1ZXVlIHdhcyBjcmVhdGVkICovICNkZWZpbmUNCj4gPiArQU1ER1BV
X1VTRVJRX1FVRVJZX1NUQVRVU19GTEFHU19WUkFNTE9TVCAoMSA8PCAxKQ0KPiA+ICsNCj4gPiAg
LyoNCj4gPiAgICogVGhpcyBzdHJ1Y3R1cmUgaXMgYSBjb250YWluZXIgdG8gcGFzcyBpbnB1dCBj
b25maWd1cmF0aW9uDQo+ID4gICAqIGluZm8gZm9yIGFsbCBzdXBwb3J0ZWQgdXNlcnF1ZXVlIHJl
bGF0ZWQgb3BlcmF0aW9ucy4NCj4gPiBAQCAtNDI3LDkgKzQzNCwxNiBAQCBzdHJ1Y3QgZHJtX2Ft
ZGdwdV91c2VycV9vdXQgew0KPiA+ICAgICAgICAgX191MzIgX3BhZDsNCj4gPiAgfTsNCj4gPg0K
PiA+ICsvKiBUaGUgc3RydWN0dXJlIHRvIGNhcnJ5IG91dHB1dCBvZiB1c2VycXVldWUgb3BzICov
IHN0cnVjdA0KPiA+ICtkcm1fYW1kZ3B1X3VzZXJxX291dF9xdWVyeV9zdGF0ZSB7DQo+ID4gKyAg
ICAgICBfX3UzMiBmbGFnczsNCj4gPiArICAgICAgIF9fdTMyIF9wYWQ7DQo+ID4gK307DQo+ID4g
Kw0KPiA+ICB1bmlvbiBkcm1fYW1kZ3B1X3VzZXJxIHsNCj4gPiAgICAgICAgIHN0cnVjdCBkcm1f
YW1kZ3B1X3VzZXJxX2luIGluOw0KPiA+ICAgICAgICAgc3RydWN0IGRybV9hbWRncHVfdXNlcnFf
b3V0IG91dDsNCj4gPiArICAgICAgIHN0cnVjdCBkcm1fYW1kZ3B1X3VzZXJxX291dF9xdWVyeV9z
dGF0ZSBvdXRfcXM7DQo+ID4gIH07DQo+ID4NCj4gPiAgLyogR0ZYIFYxMSBJUCBzcGVjaWZpYyBN
UUQgcGFyYW1ldGVycyAqLw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==
