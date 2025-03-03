Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32947C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 15:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F188110E471;
	Mon,  3 Mar 2025 15:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OOAWq1sg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0281610E47A
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 15:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MX04VF6iLsVx/+QRuxdRLM1VO414iT9TOxC3H1HeOsDRsBu2SUK7T2QqHMzmag2n6TEBu2KyDEkYFLX41H/sPOi4GIPzoaSAo2kuHL/DrsytZm2VqoefuY+FrwtJUHWqBIG5LV0qJulaPsZZRXmbtpc3gbZBVf4RzTuoisQUrz8HngRxiSkqWkoyGttK7fwEmI3RqXlN+sUg+FLcytZmi8DXkOEPtBikC3zPhLLUgkMTCnDlkopAomiTwm93T+/w3aRjKNeOwdKIQhJOH8PeaKRqbPfKt+z4JlI7WARmtvb69Z5ffy16gGE6dL0oUN0kl3XYIWInCHfT7PvOpoY2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/JS4fYOtpUrDBSSzAvWXLY/6U/5iyVo4GabbWW22ZM=;
 b=jWlwCdEplFllZyB3mDeOm9ATWvCeZNiOs6FQIZkg/EgenMjb6BXWM3TtN2WiZvhMqFJb3o0bOIMEm+Zcwm2wiXp4w4Ci+YGbtVBYewsxEIqEoPDEyywZerwQaa8TDMvR7PAWdSJmbIzRC40vP5qFivu5gUXyUsOmXvw3xKm2UPDVApBIwaF1V6nQSvX4EI167BBnBT+XUt8E0SaQbbDDjHNEidaD7JXzskB5RSSmXMc/w6opkpmqc9XHmb+Ll1VLGzKZWMM8iiKLAT2YpAEKJrUBY/9lYzROdYsEFBjpoO6yVrezSTDXplosqQdcKoggzqzQTaRl6kZ7z1fAzwScYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/JS4fYOtpUrDBSSzAvWXLY/6U/5iyVo4GabbWW22ZM=;
 b=OOAWq1sgno86QTV55DKmkbQKmXolZNiFSPXPbwSQNN4CvvaruJgfAHCT3qHscCuSrvJhc3VIWdBN4dKuYdmNlrUeVqicNbZ//2GgmiokATyXQaziSxwFm05FyTOJ2MIi3oLwm+ANrb8pfRTh3VwiBZztHPHVRGwTs/JPvfiUTXU=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 15:27:20 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:27:20 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Fix core reset sequence for JPEG5_0_1
Thread-Topic: [PATCH 2/2] drm/amdgpu: Fix core reset sequence for JPEG5_0_1
Thread-Index: AQHbiG7BU63HueH5ZUqdPezEf3DhA7NhkInQ
Date: Mon, 3 Mar 2025 15:27:19 +0000
Message-ID: <DM8PR12MB539940036453E8B1A3633F15E5C92@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250226165049.3152280-1-sathishkumar.sundararaju@amd.com>
 <20250226165049.3152280-2-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250226165049.3152280-2-sathishkumar.sundararaju@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d40cdd7d-ecb1-4bb1-909d-7effa59bd4a7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-03T15:26:57Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|IA1PR12MB8359:EE_
x-ms-office365-filtering-correlation-id: c2f9bd9e-4a53-4894-bc7e-08dd5a67e379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MUpTbnNJNk1hd3NHSldWUXhsdnhNc0JRYzJZWGs5V2lRT1pFbHIzOFJzWWFy?=
 =?utf-8?B?ZnVpVGFRVDVCTEM5Z0dXZ2s3TVN5RjVQZzVjR0dkZjdjN0VKZzFmTlFaUWNj?=
 =?utf-8?B?RzVMN1JKcThYclVpTXdyb20zWGUxbzJRSXN1TDcvSnJRV2dZMWdhVTdNeVZ5?=
 =?utf-8?B?NytiUmgxWWxzS2w2SitpQUVDQVo4MHNsV0FCeGVsWVorMmdsZmpXVzhHUHBK?=
 =?utf-8?B?cTRaZzlxdk0xRGhpclNjMDlsYko2M3pLdXhBTzl4aHVnU2RYNVVzZGR1cXlS?=
 =?utf-8?B?TTlKaWVSVDgwNUFFTlZJVGJZeWhWczRFU1lIL1BOc0Zza0paRmJQaElCcSsv?=
 =?utf-8?B?a0FrZXFyVmFRNk5NTW5tcWltOXJwQnFGeEVGMTNLSmxCMGJ1RWRBM1RCeTdS?=
 =?utf-8?B?Ykx2a05zVWFiREpBZlJjbjd4dThUS3grOE14M2lkNi9zMTBzSWdsQUdoTjVH?=
 =?utf-8?B?SmdZcTBDbDM0YTdUU2ExSks2TXEzU2QyZnA1ek1nWHRCV1JSMGFDcXBZMHk2?=
 =?utf-8?B?ZzdUdmtpUGdLM2h3TmhwdVVuVCtHSTQvSFh5bnZKT2x4aFZwcXJMOCtqNm1M?=
 =?utf-8?B?b0FwajM3Z2J5ZytkUGdNUTdMY3N2WlA1U3Y1TWpmZ25xbE9jZkpVNVBIOUNj?=
 =?utf-8?B?NmZiZHhldkMrSWlLMVV6aFJqaEt3ZzZXbEo0TzVOdU9jK09KKzYxMW4vRG9D?=
 =?utf-8?B?N1pIWnVWeU1ueDgwa3NRUUdVM3JhYmVZUG9pSHlLY0hHckY3eGRMdm9LSFBz?=
 =?utf-8?B?VEVNZ0pBcWN6bnltK0ZiNnZvLytQNkRyZ2svZlkwcEVEMG42R2krLzMvaWJR?=
 =?utf-8?B?N3NDS3F4N1NML3pERlVjQm5FTzVzTzl1bXpYcksyUkdaTzFpeXVYRTFwM0tH?=
 =?utf-8?B?dnErbUVBOERvazllVThUWnZmQURpeVh6S29zWVlNSklkSlY4NGJBV2JGQTdY?=
 =?utf-8?B?SWlFak1OYWdWbXhWNzRJVmtlQkRaV2t6ZmhVY3YwUXZtcFlqekdvL1FKWnJM?=
 =?utf-8?B?aVZaUGhyZHZYOGpwa3oyQWF5MlEydXdFSDNjTDdLenplZkI4VHpvcGFKTUZM?=
 =?utf-8?B?djQvV0FIYVlaYzRXUmhmZG1zbklpeitvQ0xtZ09DdWdiRDRkSzZzcTI0Vkc0?=
 =?utf-8?B?MFhQZkk1d2VpNHJlWXhpNEdPdkJYU3RuMjJ2elV3aHZIRkJTY1J4d20ya1ZS?=
 =?utf-8?B?TGdvekFEckVqVHJkOHZ1aHdVSi91YmZpQm90d1o0aXh1WTZ2RGVmZTUyd1lk?=
 =?utf-8?B?cWlibmRQVXJLeElzdkUrdzJyaERDUTAwRndvOTlSeXpEcUtQUzZLK0REY2ls?=
 =?utf-8?B?Z1pxeUQzZGxCYSt4RHJpTzlJSW11N0lRdGMzTGRCUHBDd2syYnhDQ2NYYmlI?=
 =?utf-8?B?OVBEWWFKMmxxNm52c0cwbTdodStZamZESDcxUndVTFVIUUFVSzZ3R0dXQzR3?=
 =?utf-8?B?K0JSb3hTOGNoTUhLVy8rOWl5ZGlWOHVxVEVJdFJlOEE3NGtmY1IxdzRuK1Bk?=
 =?utf-8?B?aENPSDlxSUlpRGhuOFUyVS9Pdms3WlV5amNZUVNyMHY2U25iSGcwS0VnMHAv?=
 =?utf-8?B?cWI3OWZWdE1zVW41WXlIU2tzY3BKVVQzUHgzQzhXZzhRTFR4U0VRM3JNTlox?=
 =?utf-8?B?LzRFMmNoY1FMTTNpZWx5Mm1IeFA1UE0rQjRHOWJ4dW1FYW9hc3NCTXdSUWtH?=
 =?utf-8?B?cmxwMWFXa2YyVVM4aTV3WDVGZ1JvVDR5STV2czBzaW9PclM4S3dBNFk5cDVT?=
 =?utf-8?B?S2JKbGNFc3FoMlRNeERtQjRFOWxQRHdROStaakduTjZwOG10d1ZCU0MvSHMz?=
 =?utf-8?B?b0dIbTVkd3puZUhjc1orejdkSkFDKzdzeUVzK0NHNGhhZmpkaHpNUisyMHN1?=
 =?utf-8?B?WklUektjSXdPMkRyY2FjUDJGeXROZEh4MGd1UG1VVUpxbTRZRERRMFF0Ri8y?=
 =?utf-8?Q?8e/KhqnFUh+dtZhpYjgZd1sHN9416AiN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SllQTU5OWkl3Nmxmd1ZPaGpXMUFsTlp1QXBIL3EwbXMzbHg2RWVXbHIrN0xa?=
 =?utf-8?B?eHdrcC9LWmJERjFJbVZUN0JwYUNIdnYvc09PbXFiMXgvcWRLNDFMSXFqY1hX?=
 =?utf-8?B?TElrUWdUSEtrcEFiaGJxc0NWOXp5anNSMXU4U2Joam5tOHN6UytXaHhkWjVI?=
 =?utf-8?B?S082dWpWdnZXdzMvZlJEY0FQQmhHOVJEekhnQjB3NWtHeTBLOXRWUUdVY2NK?=
 =?utf-8?B?cVcwV0ZGcXR2SDZuWEdYVXVuckFndXVBT2ltalVtTlE5Tm5VcmNsM2UvY0lW?=
 =?utf-8?B?aEdYUEdKZHRHWFkzZHE2Z3VwN1R5VkRjQnprZVF0dUx1MGFSQjJDOFc0N0xC?=
 =?utf-8?B?K0JDNnYxL3M5QjBFT3BNSU5vLzhwcnN2dTB1dnl6eUowOEYzZGdzeDA1NGF2?=
 =?utf-8?B?cUUyRDJaZFE0Ty8vbEd6RmZnTTNYZjN5c00wNzM3K0c0VnI0bXUvUlNldEd6?=
 =?utf-8?B?OTllVS9PNEh5Wi9KbCs2TWtnMGNCcDM2L1ppamdydTlLdi82UUduOGN5bElP?=
 =?utf-8?B?YVQ5d1hPUzIxY1JPWjFKRGFNNU52TW1tN2syVng5YlFQVGNHcFcycVluTlNl?=
 =?utf-8?B?Nmx3QjhKdmVvNTJoQlorbmsyYVA4OW1lYjFFMmRwSUVmMjRwVG05ay9OQXRJ?=
 =?utf-8?B?b1hzQ1B2bE56b0d3aFJXaTlkVVc5ZVlndEFEVHNpWWFGM1hkaUMrNTlNbXhG?=
 =?utf-8?B?WFJaMUFVMDl0RHhkVHRqbWthYjlqL3ZFM2N5ZXY2SkJTcjkrdGRvWjJXMzlE?=
 =?utf-8?B?V2xwV0JOSjAzWFpETGx3WHFVV0ROeUp4aUt0WkpOTSt6ZXQ5TkcwbklIVGRy?=
 =?utf-8?B?MGEzcEJPU1NmdWpiR1NqeVE4MkdjTFlFY2xHY3pzNlRvTUs3U3pkY2JnQzZ4?=
 =?utf-8?B?eENLMmhlTzYxUFJFRTJjZld0NFRwWS8vS1dKSUJLaDNHTkNyOWpVTi91YkE4?=
 =?utf-8?B?OS9HTnZ5aWkrejdSSEp5S28zYmVkVFR3RERLdStCazFicVBPemo2bG5xazlT?=
 =?utf-8?B?WEZrU2thWXJlQk1rZ2FTdlV1bTNrbEg4YnplSTZiY2luTC84QXlueno1aU1k?=
 =?utf-8?B?VUw2MHVxVFlxSWExaHpEcDFJRzRUT2NNakw4S1lEaTZiOEtydnRqZlZIa0pH?=
 =?utf-8?B?NzlTZjNXa29IaXduWVVDMUlXcVN3U3ZCVVpTaWJJZ3Rja09JZ2FNb2x4aG5k?=
 =?utf-8?B?SGtUbVZrWStkaU4vZVBKTnFMWUNFY085VGlXQmxiWTlKV2wxWTkzSVNGS2s5?=
 =?utf-8?B?UnRhbHp4eHZ6ckpzMzhRaC8xZzBxVk4ydko0ay90RnVtNVVxc294SkJNZkRm?=
 =?utf-8?B?N21MSWR4K2FMd2FYa2FHczY3aUFNd2Nsa2x0VER2d2trM2Y1MVZ1RjNFam1W?=
 =?utf-8?B?VmY3VDBGRndMa3U2Z3doS3E3ME1YYXNyRHBhL2hnRFJsS1J2ZDAxTFpkenFS?=
 =?utf-8?B?L1JHayszR0FHL1BGd3VOVzJ4UzN6d3FyanZNaHVRK3d1Tk1HVVJVcms5a2RZ?=
 =?utf-8?B?RXBXUmo4bzFqVW5GRlNnTVN3N0cycWtaVUdDa2k5cFMzOGF5THdEU25qYk9R?=
 =?utf-8?B?WkY1Y3FZTEdCYnVqcjJWV0RqZzU5VnlUbTI2MDh5R2I4Y2grSTV6djU0NjJ1?=
 =?utf-8?B?bThUT2hhRit1a3YwNDVDajdha3R6bjJtT05lQnZSRUxyOVdMSjZydFVrY0JG?=
 =?utf-8?B?enF3YjZmNk52Q2FSNjdqdzFpL2NjV3ljK0FJQW5nd3hOYXhoOWhKVXFkODBD?=
 =?utf-8?B?ZHd6NGZaV2FwQ1BvUUh1VlMwR213a3gvV1FDTnJMWlpXbnJsQ0lvR3ZCRTdX?=
 =?utf-8?B?ZCsrSmRMUEJZajNwUEc4SllPbFY3cnBPKzNrbnVZUFZQcHZXK2dRNlM0WFR5?=
 =?utf-8?B?VHhQSnlFMUFzRHJodVZKUXBRNzBJRk5UVkZndkdKWjR0dFhMMnlYK1krV3Rn?=
 =?utf-8?B?dzRRN2xJMDN3REZiSGNUdGFpY0o3Z0RQYi9HYVFUVVRDT0orYzUvbW1RQTVk?=
 =?utf-8?B?bjlhUHI2UDE1dVJKVFBjcUJmc3lPdnMrWldQZkdMZ3MvczJpWVpRNzJzNXQ2?=
 =?utf-8?B?eVgySU50NnNPUWVUYlhwVDdRUWVxNVQyRW5vM0I0YlJQSllwaEFUbEFvbmNo?=
 =?utf-8?Q?4roQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f9bd9e-4a53-4894-bc7e-08dd5a67e379
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 15:27:20.0726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVk41/MPYWjUEwg1XDgjiNrw0jmAo3ANqCnVuA/ZT2C1VUbYqAlu/RA6Qjams0+q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
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
Cg0KVGhlIHNlcmllcyBpczoNClJldmlld2VkLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VuZGFyYXJhanUsIFNh
dGhpc2hrdW1hciA8U2F0aGlzaGt1bWFyLlN1bmRhcmFyYWp1QGFtZC5jb20+DQo+IFNlbnQ6IEZl
YnJ1YXJ5IDI2LCAyMDI1IDExOjUxIEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBDYzogTGl1LCBMZW8gPExlby5MaXVAYW1kLmNvbT47IFN1bmRhcmFyYWp1LCBTYXRo
aXNoa3VtYXINCj4gPFNhdGhpc2hrdW1hci5TdW5kYXJhcmFqdUBhbWQuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBGaXggY29yZSByZXNldCBzZXF1ZW5jZSBmb3IgSlBF
RzVfMF8xDQo+DQo+IEZvciBjb3JlcyAxIHRocm91Z2ggOSByZXBhaXIgdGhlIGNvcmUgcmVzZXQg
c2VxdWVuY2UgYnkgYWRqdXN0aW5nIG9mZnNldHMgdG8NCj4gYWNjZXNzIHRoZSBleHBlY3RlZCBy
ZWdpc3RlcnMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFNhdGhpc2hrdW1hciBTIDxzYXRoaXNoa3Vt
YXIuc3VuZGFyYXJhanVAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9qcGVnX3Y1XzBfMS5jIHwgMTQgKysrKystLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3Y1XzBfMS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvanBlZ192NV8wXzEuYw0KPiBpbmRleCA2YjhlZjhlOGMwZWIuLjIyMGYzYWYw
MTc0OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192NV8w
XzEuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3Y1XzBfMS5jDQo+
IEBAIC02NjksMjQgKzY2OSwyMCBAQCBzdGF0aWMgdm9pZCBqcGVnX3Y1XzBfMV9jb3JlX3N0YWxs
X3Jlc2V0KHN0cnVjdA0KPiBhbWRncHVfcmluZyAqcmluZykNCj4gICAgICAgV1JFRzMyX1NPQzE1
X09GRlNFVChKUEVHLCBqcGVnX2luc3QsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVn
VVZEX0pNSTBfVVZEX0pNSV9DTElFTlRfU1RBTEwsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmVnX29mZnNldCwgMHgxRik7DQo+IC0gICAgIFNPQzE1X1dBSVRfT05fUlJFRyhKUEVHLCBq
cGVnX2luc3QsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICByZWdVVkRfSk1JMF9VVkRfSk1J
X0NMSUVOVF9DTEVBTl9TVEFUVVMsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAweDFGLCAw
eDFGKTsNCj4gKyAgICAgU09DMTVfV0FJVF9PTl9SUkVHX09GRlNFVChKUEVHLCBqcGVnX2luc3Qs
DQo+ICsNCj4gcmVnVVZEX0pNSTBfVVZEX0pNSV9DTElFTlRfQ0xFQU5fU1RBVFVTLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ19vZmZzZXQsIDB4MUYsIDB4MUYpOw0KPiAg
ICAgICBXUkVHMzJfU09DMTVfT0ZGU0VUKEpQRUcsIGpwZWdfaW5zdCwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICByZWdVVkRfSk1JMF9KUEVHX0xNSV9EUk9QLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJlZ19vZmZzZXQsIDB4MUYpOw0KPiAtICAgICBXUkVHMzJfU09DMTVfT0ZG
U0VUKEpQRUcsIGpwZWdfaW5zdCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICByZWdKUEVH
X0NPUkVfUlNUX0NUUkwsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgcmVnX29mZnNldCwg
MSA8PCByaW5nLT5waXBlKTsNCj4gKyAgICAgV1JFRzMyX1NPQzE1KEpQRUcsIGpwZWdfaW5zdCwg
cmVnSlBFR19DT1JFX1JTVF9DVFJMLCAxIDw8IHJpbmctDQo+ID5waXBlKTsNCj4gICAgICAgV1JF
RzMyX1NPQzE1X09GRlNFVChKUEVHLCBqcGVnX2luc3QsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmVnVVZEX0pNSTBfVVZEX0pNSV9DTElFTlRfU1RBTEwsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmVnX29mZnNldCwgMHgwMCk7DQo+ICAgICAgIFdSRUczMl9TT0MxNV9PRkZT
RVQoSlBFRywganBlZ19pbnN0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ1VWRF9K
TUkwX0pQRUdfTE1JX0RST1AsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnX29mZnNl
dCwgMHgwMCk7DQo+IC0gICAgIFdSRUczMl9TT0MxNV9PRkZTRVQoSlBFRywganBlZ19pbnN0LA0K
PiAtICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ0pQRUdfQ09SRV9SU1RfQ1RSTCwNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICByZWdfb2Zmc2V0LCAweDAwKTsNCj4gKyAgICAgV1JFRzMy
X1NPQzE1KEpQRUcsIGpwZWdfaW5zdCwgcmVnSlBFR19DT1JFX1JTVF9DVFJMLCAweDAwKTsNCj4g
IH0NCj4NCj4gIHN0YXRpYyBpbnQganBlZ192NV8wXzFfcmluZ19yZXNldChzdHJ1Y3QgYW1kZ3B1
X3JpbmcgKnJpbmcsIHVuc2lnbmVkIGludA0KPiB2bWlkKQ0KPiAtLQ0KPiAyLjI1LjENCg0K
