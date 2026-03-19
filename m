Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEBA1075284
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 09:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5845C10E0A2;
	Thu, 19 Mar 2026 09:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gLppxWcz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 249B610E0A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 09:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2Vz52S3ZI36NLVSNc5SrhlCPR5kCs+57+1GFDwgAa7pPcHo2OFWg2wBKtSenSA7rLknYNwkmGY+Sel+dye5ZO9lbgPWJavc88wg/GU7K77dQdiwU62RMPwMjkytqqQwU7swssz4K4NjH9hltuN1im7fxJiHKnuxZUztwmw5pB9wuAkksaNyiBtZIfS5Jv8yyFMkYwjRdreHTVwMJuYJeOH328U31JgrCh9Px3R3pPgR0EJ4ysi/ClT9Ev8MA1Q2q3YAh1FeyKKQ7ECI3yEATPijdTOTtonMrNz3cQVpWTbNEvTqfkm2MZPrtoNg9/XhQP/FMn2yYH8TbZfBL6kMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHqy7h4/C0LFsoJPXdyc+tH15xnW0YAA5DaO512Bga8=;
 b=IShPivYMD8B0lBDFcbF/erG/h08fg9ehJzXSBm4ybVhXrV9BoBMIuNgsdcnO//0aVnpziLyco4I28cV3WCzWAN06G1/xRw304tozl8Uy4BZyRl6BFbK5TEww1Izo20c9E8hEzp0yILYJGPoGEQ7Nxk+emXJgjoJEJwxCKdHKjpRrYt5jF4JpKbInvudyA0TdvDiK6FJUaoTY+gW1WievUKJmkBPKeqBX7vl30r46BFq/cntjWrVafzuwr9MmlbaouzBTM5L/OjxYzslH2ajF3PARE4NQ1uDlSNkOc3RnfDHeSNrB4YnElqzdVl+YP9JlN6ntrERT+R9D0yVtgOgB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHqy7h4/C0LFsoJPXdyc+tH15xnW0YAA5DaO512Bga8=;
 b=gLppxWczARF6ANQhYjj1S99j793qNDt750opSzmFttdzzU38KrNm0By43DCeM6SoFd9OBECvwrbcX1FgtOjaQscDRvgoqYgJgGdiPG05JwqpH5WRzcLZtpjMhh0SWh1DMXshzCKK7EVGIb9g4YmqCCEWZX+A43niXmGjQ7NZznE=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 09:24:10 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 09:24:09 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/ras: Add NULL checks for ras_core sys_fn
 callbacks
Thread-Topic: [PATCH 2/2] drm/amd/ras: Add NULL checks for ras_core sys_fn
 callbacks
Thread-Index: AQHct2P++EUpvH9bkUSlPKx/KcREHLW1lWuQ
Date: Thu, 19 Mar 2026 09:24:08 +0000
Message-ID: <BN9PR12MB5306F8A37C119395DDCD93E9FC4FA@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260319054757.1987819-1-srinivasan.shanmugam@amd.com>
 <20260319054757.1987819-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260319054757.1987819-3-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-19T09:23:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|CH2PR12MB4150:EE_
x-ms-office365-filtering-correlation-id: c7a96d9b-2202-477f-35b7-08de85994660
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: nPoiEbwt9legsgXDMjTaIQuOpeiyEiH1RIGNsvOJG9AFuEf3ZGKvdnF+lyK69mz4TLt8AhTuc234ieRPy0R4wf7yO1pTZynHu7eDewjTBjmOBUuPcCEFZ7ie0FQO7/0/xlK72tgTghhedaW8g6ed1lf2lzH14Gc9Ly6NkBE0Ne9eN7EFwo2KMwczSG8LvqmUHS8RlIzrzKEFG9oSDwehq+2fMGlTUV9HwM6UFQNManOqleC3ZnwKXFHAn7tjO8UITvKn4sZi0NANoSf9o6e/3CF1btYXJEYZQYsVwNXDUVXZJRxIG9N1gdcKPPT1EBQeDteCivxojXK9KnTVfFvwrR+lNUs5A4h3YzmAj/RHzPuClQRGm8Cz8uHixr8zQVZQObKLOWXSnl3e7qBzJI6YIcrWvvc2pfHCIZwWsTSRpioP876TSGYq//o/345MchaWoRElkf6NbLpTAzRPbdb1vbWtFXd/skSnMs3hDwIE0Ahap4VIjFNwkr5hiNKrSQAYYURhhrqNSz8BXUKmdpjXtnUz/eIaq+13uH/0tbF4jIZ22MjzJ/0QlqsFp7Msp5bcji1UWBuT18g25HrFwQdx8vwxeMqvglYhVeu1RJOSuP46h+GAkJkxouSfQeOuk1OoDiF8BNN0HDtiUZRmwjm1usBk4FkXUQO08T0qDnIz0JylFghPtpDK/PR7aEiTbK9ZNG/151zNNMoiajNcOWmNVbCTKcBnPOzBmpV0bKO08WcRNcEew144UZcZib39/gDPmAfLOgu5rgTX+3S/SSEh63aIK5X4uMPBWVusqw7nLqM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk5hOFVPVjJ6UzJvV3RhZlV5NldqcG10dmorMFZiVXJnYzZNZ0VQNmUxK2dK?=
 =?utf-8?B?aEtJdHlzenRzZTF0a2pvbWRaWHNaVFZ2OStUWUdTM3lxZ3JmUjFGOFN2TS85?=
 =?utf-8?B?UW11bG9hdHJ4MVBzSWJNSlp0N2loRUhkbXAzSEFYYTdDci9lZEVFaEN1RklC?=
 =?utf-8?B?UjlNWTVMa20yTDNibFJMOEFGeEM4NnFJM3Njczd5Y3hKT2JMSWxDWUtBZFhJ?=
 =?utf-8?B?Q3g5SGVkdFovQkVzbmtuOEtIV0tuR0ViT2Fpb1BvSTVjT01vSTJ0UE9BYnNx?=
 =?utf-8?B?UVdCbmg5WWl6ZGhVbnJBVEtOdDQwVkRoOFBDRFdDVXcwd1gwcU5BZ3BMYlNN?=
 =?utf-8?B?V0RLOTNTTDF1Z2kxQk5UYjh2SSs5OTBPNGc1NXRxY1RtV1JlTTJTY1dnVkpV?=
 =?utf-8?B?VkRzYjU3ZmcybVRLMDlycmR3QU5OZEZCSldXdENxQlI0SHBvQWhxR2dvbGo3?=
 =?utf-8?B?bjF3dTlnaHRna0JET01SbHNTWHV3N0Z1dktZZFlMb0VlR1JwbmZYZ1doSmpk?=
 =?utf-8?B?VjlCWE5tL01SRDNCNjNERHl2VFVFOUdIWEYzdlFzY056bzNRa2xoYkgxZzFQ?=
 =?utf-8?B?RmpJZzhvUCtDM0luTnprK0JhcU10cElWNGZDMGFBQ0MzZ3BoZXM0enNuWWNa?=
 =?utf-8?B?NW42cWxNUVVVY29lWXgzeWFqNkNWVkc3b2NjK2luNStNNHVvcG0yR2VOcVR2?=
 =?utf-8?B?Z2xHYnVxeW5EcWhHS2RwMlFhcllscWdZYUVib0FqRE9JVEIveXdreXhmS3hE?=
 =?utf-8?B?c3ZpKzdXL3RXemh4UnNBbTk4MWlyUjVNWnVQKzcrSVozcm9tMkdIbVBLZjdG?=
 =?utf-8?B?Z0Y5d2NBcXAyQk16b295S1BuNWhpYlh3b0prSDQ5c3IzMkpXd3NZcW10TEVp?=
 =?utf-8?B?cm5VSEVuVTNYVjM5WlBoa2RnelhSYURSeXhqaDRUeUl5TDhwQ0RUZm1PY1hP?=
 =?utf-8?B?VTFVbG02T1I4UHB3dTE0RlZlaG1DTlVuajBSSkpHenpZMmt0S3dVQ1M0OUxT?=
 =?utf-8?B?WERwNk1nWjBHRVdmaTRNN0hod0tMRHk5QjJzV3Nrb2RyVVlydW9UdnVFMTdR?=
 =?utf-8?B?V1R1Ny9wM25EZWhjRFRMRWNYcXR0d1pVV3RraktrSEkxeXVRWU9tK2tVRUJZ?=
 =?utf-8?B?anhwcS9JdEJIWGpBaVJNWThhdzNFSkhzZ1RrRW11NmdOVks2d3lUTFhZVWJ4?=
 =?utf-8?B?bjQzdUI5dFoxN3ZHU2Iwb291T05RNnd2bFEwS3d6NDc4djN4QnpIemtlMXpz?=
 =?utf-8?B?MEhIa0pwYVZkTlpXVVhjUmRLYkxQUVdrWlFPSkk0ZStibWJtV2VteGpNbUU5?=
 =?utf-8?B?VE1ZZFkrL2EyckJYbWRRVHBxcGdzR0FxdVVHMGNHVDg2ektCVkljK3FLSDhv?=
 =?utf-8?B?YmpGS01tR282aEsxeFUwblRheVVHMmF3YjBUcFpscDl6anpRM0xXbEZnc0lo?=
 =?utf-8?B?SktNb1o5d1VyZG01dXNITjhKRE5ROFBrdW9jd0xMQlRxSlJLODNESkw3RGR4?=
 =?utf-8?B?L1dpVG9MKzhmNXBDSG90MlhJQ2lDOUNabm8yeXJFditvc0ZLUTI2N2ZGWDli?=
 =?utf-8?B?UHZVM2lpZkw2WDV0NWYvcmt2Q1J1MmM1SE81aDdDSnY5RnpSWEZuWm1VMzYy?=
 =?utf-8?B?OVB3a0tBbzgzb3ROazVoMWM2eHh1cVM1d2VLaDdJNWE4Ujg3SWRLTm5RQTlX?=
 =?utf-8?B?MEg5L1NEa21veWlyWEJLZFQyb3FQVTVUdTV0L1haYW1DTGNwcGlMemhhQzlP?=
 =?utf-8?B?Rkc5TkdPVXpGd1c3RlQ0Z1hkdDlxUURqYU5mYmlUVlNYQTNrU0ZLd2VUSkQ5?=
 =?utf-8?B?cFpaWC91M29DNGkrRXpIVURiVkQwVWFraWpUckk2V3hxY2dER3VoS2ZQVVFx?=
 =?utf-8?B?WFY3MFdDZVFndGhWV3Fzak9veW5UeENGcXljSUEyMU5LTCtwRzdONUFxUnZm?=
 =?utf-8?B?VnpSK05HcUtaMU9aU2dZY0lRK2pXbFVjT0htMkRoMndheW5ZemRtaTVOT0t4?=
 =?utf-8?B?YUQ4Z0s1bnVaTHhDRXA0SWZaSzN5OVpxMG9ERHptbkVBWU12UDFGRFhCV2Ew?=
 =?utf-8?B?VVJtbXB1TkYzTERZMEw1eUVUS2w1Ym52RHFlVzlyTXdQSXl4UkRzQ0hzWGsx?=
 =?utf-8?B?T0htSXlDZVJXMENIZTZLZDBiUHpmM1NBb2N3Uno1Q24yeVp3TWhXNzVWRXRE?=
 =?utf-8?B?VGw2VUxUM2IwYUpmMDFQMUN6RmdzN3F3My9xbHNhWlZQZUVuV01pTVhUVDJU?=
 =?utf-8?B?U05JZ2lZUEtubkVzMk5iNGYyZCtYOXpmdDJUdExhL2huZXdhYTFiWVBPM1ZT?=
 =?utf-8?Q?FxUbY6WAafyFU9IEdx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a96d9b-2202-477f-35b7-08de85994660
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 09:24:09.0137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OoPdd5nmkdNpsVrgTTPxnWLj1myLJG+k+UVxSlZ67chEkIwo2iw2L5qh0ys+Urgml2UYPGuuhwKIItKb1FDs0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
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
Cg0KU2VyaWVzIGlzDQoNClJldmlld2VkLWJ5OiBZaVBlbmcgQ2hhaSA8WWlQZW5nLkNoYWlAYW1k
LmNvbT4NCg0KQmVzdCBSZWdhcmRzLA0KVGhvbWFzDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQu
Y29tPg0KU2VudDogVGh1cnNkYXksIE1hcmNoIDE5LCAyMDI2IDE6NDggUE0NClRvOiBDaGFpLCBU
aG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNv
bT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgU0hBTk1VR0FNLCBTUklOSVZB
U0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPjsgRGFuIENhcnBlbnRlciA8ZGFuLmNh
cnBlbnRlckBsaW5hcm8ub3JnPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
ClN1YmplY3Q6IFtQQVRDSCAyLzJdIGRybS9hbWQvcmFzOiBBZGQgTlVMTCBjaGVja3MgZm9yIHJh
c19jb3JlIHN5c19mbiBjYWxsYmFja3MNCg0KU29tZSByYXMgY29yZSBoZWxwZXIgZnVuY3Rpb25z
IGFjY2VzcyByYXNfY29yZSBhbmQgaXRzIGNhbGxiYWNrIHRhYmxlIChzeXNfZm4pIHdpdGhvdXQg
dmFsaWRhdGluZyB0aGVtIGZpcnN0Lg0KDQpDYzogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29t
Pg0KQ2M6IFlpUGVuZyBDaGFpIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KQ2M6IERhbiBDYXJwZW50
ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+DQpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPg0KU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFz
YW4uc2hhbm11Z2FtQGFtZC5jb20+DQpDaGFuZ2UtSWQ6IEkyODU5YTYzYTg2YThmMzg1ODVjOThm
NzYyN2ZhMWUxOWU4M2ExN2IwDQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9yYXNjb3Jl
L3Jhc19jb3JlLmMgfCAxMyArKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc2NvcmUv
cmFzX2NvcmUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc2NvcmUvcmFzX2NvcmUuYw0K
aW5kZXggNGU4NDIyMGVmMTUyLi4yOWIxYjhmMGNjMjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Jhcy9yYXNjb3JlL3Jhc19jb3JlLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcmFzL3Jhc2NvcmUvcmFzX2NvcmUuYw0KQEAgLTExOSw2ICsxMTksOSBAQCBib29sIHJhc19j
b3JlX2dwdV9pbl9yZXNldChzdHJ1Y3QgcmFzX2NvcmVfY29udGV4dCAqcmFzX2NvcmUpICB7DQog
ICAgICAgIHVpbnQzMl90IHN0YXR1cyA9IDA7DQoNCisgICAgICAgaWYgKCFyYXNfY29yZSkNCisg
ICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQorDQogICAgICAgIGlmIChyYXNfY29yZS0+c3lz
X2ZuICYmDQogICAgICAgICAgICAgICAgcmFzX2NvcmUtPnN5c19mbi0+Y2hlY2tfZ3B1X3N0YXR1
cykNCiAgICAgICAgICAgICAgICByYXNfY29yZS0+c3lzX2ZuLT5jaGVja19ncHVfc3RhdHVzKHJh
c19jb3JlLCAmc3RhdHVzKTsgQEAgLTEzMCw2ICsxMzMsOSBAQCBib29sIHJhc19jb3JlX2dwdV9p
c192ZihzdHJ1Y3QgcmFzX2NvcmVfY29udGV4dCAqcmFzX2NvcmUpICB7DQogICAgICAgIHVpbnQz
Ml90IHN0YXR1cyA9IDA7DQoNCisgICAgICAgaWYgKCFyYXNfY29yZSkNCisgICAgICAgICAgICAg
ICByZXR1cm4gZmFsc2U7DQorDQogICAgICAgIGlmIChyYXNfY29yZS0+c3lzX2ZuICYmDQogICAg
ICAgICAgICAgICAgcmFzX2NvcmUtPnN5c19mbi0+Y2hlY2tfZ3B1X3N0YXR1cykNCiAgICAgICAg
ICAgICAgICByYXNfY29yZS0+c3lzX2ZuLT5jaGVja19ncHVfc3RhdHVzKHJhc19jb3JlLCAmc3Rh
dHVzKTsgQEAgLTQ4NSw2ICs0OTEsOSBAQCBpbnQgcmFzX2NvcmVfaGFuZGxlX2ZhdGFsX2Vycm9y
KHN0cnVjdCByYXNfY29yZV9jb250ZXh0ICpyYXNfY29yZSkNCg0KIHVpbnQzMl90IHJhc19jb3Jl
X2dldF9jdXJyX25wc19tb2RlKHN0cnVjdCByYXNfY29yZV9jb250ZXh0ICpyYXNfY29yZSkgIHsN
CisgICAgICAgaWYgKCFyYXNfY29yZSkNCisgICAgICAgICAgICAgICByZXR1cm4gMDsNCisNCiAg
ICAgICAgaWYgKHJhc19jb3JlLT5yYXNfbmJpby5pcF9mdW5jICYmDQogICAgICAgICAgICByYXNf
Y29yZS0+cmFzX25iaW8uaXBfZnVuYy0+Z2V0X21lbW9yeV9wYXJ0aXRpb25fbW9kZSkNCiAgICAg
ICAgICAgICAgICByZXR1cm4gcmFzX2NvcmUtPnJhc19uYmlvLmlwX2Z1bmMtPmdldF9tZW1vcnlf
cGFydGl0aW9uX21vZGUocmFzX2NvcmUpOw0KQEAgLTU2OCw2ICs1NzcsOCBAQCBib29sIHJhc19j
b3JlX3Jhc19pbnRlcnJ1cHRfZGV0ZWN0ZWQoc3RydWN0IHJhc19jb3JlX2NvbnRleHQgKnJhc19j
b3JlKSAgaW50IHJhc19jb3JlX2dldF9ncHVfbWVtKHN0cnVjdCByYXNfY29yZV9jb250ZXh0ICpy
YXNfY29yZSwNCiAgICAgICAgZW51bSBncHVfbWVtX3R5cGUgbWVtX3R5cGUsIHN0cnVjdCBncHVf
bWVtX2Jsb2NrICpncHVfbWVtKSAgew0KKyAgICAgICBpZiAoIXJhc19jb3JlIHx8ICFncHVfbWVt
KQ0KKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KICAgICAgICBpZiAocmFzX2NvcmUt
PnN5c19mbiAmJiByYXNfY29yZS0+c3lzX2ZuLT5nZXRfZ3B1X21lbSkNCiAgICAgICAgICAgICAg
ICByZXR1cm4gcmFzX2NvcmUtPnN5c19mbi0+Z2V0X2dwdV9tZW0ocmFzX2NvcmUsIG1lbV90eXBl
LCBncHVfbWVtKTsNCg0KQEAgLTU3OCw2ICs1ODksOCBAQCBpbnQgcmFzX2NvcmVfZ2V0X2dwdV9t
ZW0oc3RydWN0IHJhc19jb3JlX2NvbnRleHQgKnJhc19jb3JlLCAgaW50IHJhc19jb3JlX3B1dF9n
cHVfbWVtKHN0cnVjdCByYXNfY29yZV9jb250ZXh0ICpyYXNfY29yZSwNCiAgICAgICAgZW51bSBn
cHVfbWVtX3R5cGUgbWVtX3R5cGUsIHN0cnVjdCBncHVfbWVtX2Jsb2NrICpncHVfbWVtKSAgew0K
KyAgICAgICBpZiAoIXJhc19jb3JlIHx8ICFncHVfbWVtKQ0KKyAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KICAgICAgICBpZiAocmFzX2NvcmUtPnN5c19mbiAmJiByYXNfY29yZS0+c3lz
X2ZuLT5wdXRfZ3B1X21lbSkNCiAgICAgICAgICAgICAgICByZXR1cm4gcmFzX2NvcmUtPnN5c19m
bi0+cHV0X2dwdV9tZW0ocmFzX2NvcmUsIG1lbV90eXBlLCBncHVfbWVtKTsNCg0KLS0NCjIuMzQu
MQ0KDQo=
