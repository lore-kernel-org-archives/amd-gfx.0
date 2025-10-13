Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335E2CCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC28F10E38B;
	Mon, 13 Oct 2025 14:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zQb0w07R";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7869410E38B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2iLtfODydHvTtppYanSXti0vvo3C97PA8naEb0duL2drkAlgJPVceqWyEfqI56Jqk53tv8Eib1ZXTNON5lQ0HEkEQWn+bpRfkSVx+wkgVd2IVs3vz+plbpkJDoTA8hIsJgLTz2+94ZcGOMI6tQ8ClXoHcHZ3F46ABMx//c9W0Vj1XIuJ2GSMzpgHJkxGbgsQTbg5uGrmPrVo+1/iGKgYLLbpPqNxx0eLRlENQAHXPDvVVe5j9tgZsGdphCXpyz8NkNsr004Hs1Hewp8U+vchE2OKp+QADPooI8S+jNwENKv93wUBcyZ7OTKohH+E3wbDI21HUMvj07ygvkIj1P3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=045nDa7hgy3iJ5hgDVylAXECUJounjzCJOq8ZjvWigU=;
 b=IB5lwTNo93/t0biC5Yaq5Do3xdUubBCqdxqKoIkFVtGI4vTeeRPrSUYrytbl0tZ5si0fJs/CC5r57a28Nl3E17iQJ0PnjRx8SjdUuSbLpSZsnjCEux8CB+5eB6WkpS33JKDODtWY7oalCk4U8CQliocPM/PqfO1vmTUtTdOvzZyv63RLSGNthldH/HMyq8Jhuyu2Dyf+4/gevtt+ZFMP1LUFAN5uq+o1o4wpv9TbquzQlTzaQcOg1XfD8wLC7n+DC9BdoVR2IC092RiqYiEPDYnEv5d2EGZ5p+YTWmEWAwaizIfifml39mJDGOXSG4sRBOQmcZkMGa7G7lj8p/6gzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=045nDa7hgy3iJ5hgDVylAXECUJounjzCJOq8ZjvWigU=;
 b=zQb0w07Rv1HfahZG0uVOu2JJLr654i6iduYYk64USGmMFmAra7wwvyTUGEAdMTc4kWQuGB6JLZpfwpY6KqWx45uOGk3uwsB971HAZq7OHRhdGiA9fGrrX+5uip5WY2X/JkeqBnth6hOI3yMQ2v+MLZLezjv50gENGyjUjUzFbpw=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:08:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 14:08:15 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: Mario Limonciello <superm1@kernel.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Lee, Peyton"
 <Peyton.Lee@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>
Subject: RE: [PATCH v3] drm/amd: Check that VPE has reached DPM0 in idle
 handler
Thread-Topic: [PATCH v3] drm/amd: Check that VPE has reached DPM0 in idle
 handler
Thread-Index: AQHcO60F9n0wfVQ85EWxZQ7QWAPx2rS/g0GggACWGwCAAAGB8IAAAjQAgAAAX0A=
Date: Mon, 13 Oct 2025 14:08:15 +0000
Message-ID: <DS0PR12MB78040596A51376AEF8CC284197EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251012191823.856295-1-superm1@kernel.org>
 <DS0PR12MB78042769FD23A8C5346A561497EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
 <46350316-9b32-4495-8e8c-c9672da34156@kernel.org>
 <DS0PR12MB7804BA493A16EFD092EB6A9897EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
 <944a8da2-7b01-4a0c-846e-66e5ba908e51@kernel.org>
In-Reply-To: <944a8da2-7b01-4a0c-846e-66e5ba908e51@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-13T14:05:14.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8738:EE_
x-ms-office365-filtering-correlation-id: 89b4c76a-d6c0-4fee-db77-08de0a61f3f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bzBuVVJlNVZjVi9pckZxTitsaXU0VERwWm4xQ1QzWFUrWWZTSzZLbHRXUjBi?=
 =?utf-8?B?ODN6M1NhdWdRR09uVldYQ05yYVNQZFRWcnNQVTJOVTVKNHJ2OG00S3FTNGRB?=
 =?utf-8?B?NCtqK2tITHhaUXQ3U1ZZanBjcC9FNVY4MHhOZTJ6YUdjeklKOEV2K215VFB4?=
 =?utf-8?B?bkZvaWh6Rk9yWGxKNFh5cEtLeDJZSWNLeUxHRWdNeXlZdWdxcTFWM3F0aGNm?=
 =?utf-8?B?MWdBNTZsK0ZsZjlTNFpocU0wcmxRMGFRdXZUT3piTkdzYzZ3LzZPWHBLYW9N?=
 =?utf-8?B?cFVidEZ2OTBhVU0yQTAwK0ZCSzBHZTJEU25lVEVwbHNrbklJRStZakdlVENx?=
 =?utf-8?B?TFV6Y0pkZ09BSFFJdEF3V1g5TmJEcDkrbmh1WWZ1a3FQYWJSY0R3VWE4aFFp?=
 =?utf-8?B?OHlSeWFia2gxaFV0Ui8zSWZVcGQ0dmNtWVByQk1OYm9PRGFyWDRUUUxXVkpU?=
 =?utf-8?B?bjl6Y2NLTFlsODBReHprcU5yTHBTcDlPU0IvYk9ZVEt3bjd0Nyt4V0tUTU1l?=
 =?utf-8?B?ZzVuY3JvQ0pPMzNCSWh1Kzh5eTJlNkpRN0JsRUZNTzN3emlDV244YitQNUpz?=
 =?utf-8?B?Ky9udENVa2puc0pnYVRwOXUybFIxaFFvdFpJcXQ2L0VYenJEMjJLbE5jQUFy?=
 =?utf-8?B?VmV6ZGxVQXlVSHBrMnIzR2dRTE45ejlPTHNqK0xxOGVjcXplZUhTS0dhbkM4?=
 =?utf-8?B?OCtlWXJjWi9LdHpuNmlrWkJlcjNLbWdIK1p6ZGJidHUvZzh1TnZ5YTRqeVc1?=
 =?utf-8?B?QkJCTm1Bb01JSjhENGdoeUF3cjFPdFRYdkJKRkFPVlBOc1lKTU1TQ0NxNUJV?=
 =?utf-8?B?K04xZkRXTysySHhzb0Fab0tXQmJaLzh2WUFIeWFoR0FjVTJPa0gxeXAyZXM5?=
 =?utf-8?B?dFd3NFJpWDc2QU1WbW5raUxrUFlDS3BEQTJ5d2plcGs5S0ZFSWZzTFRHZlNM?=
 =?utf-8?B?eXFQaStyM1FQSE0wb2syVUdMZzIxNlhDMnVGdzBkVWpqZjdNU1BZMzlUZUtQ?=
 =?utf-8?B?dnpTUnloZEpGbWtIYm1GUDhUTDJRRmNkZjFQSHc5NWRtZkFwOXJjcXlXOXBs?=
 =?utf-8?B?TUd3LzNhNi9MZE0yQS9NRVlWeWM5WVIwTmt2RHk5dFZ0bG9wYXY0R2krbWNN?=
 =?utf-8?B?dlc5UzJSMWVmRG5tS1V2ckZCWFF3ekcrelFmZnVyQk50THlwY0FKRHpHNGcx?=
 =?utf-8?B?aUIyRzBIRG9sMSt3c1VLYlQxbjBWQ1V4RmIwSW9zbEk0UUIvSE1lakZaOFF2?=
 =?utf-8?B?THB5dmpPYSs1ZE9yS0ptTDRiemc5UEMvMTFpd1BEZCtkZU1LMzhFdGxPSTJS?=
 =?utf-8?B?Rk9iUzNsVGxZckh3dEVQd0FLY1FGbC9kWHRSRjZDVjlERXRuUVBWSXVoNkNT?=
 =?utf-8?B?aXpqbGxKckQ3UjN0VE45eEU3bkdWeXRncktnUnBRSGtydlRwaTZNL29MWTVX?=
 =?utf-8?B?YytZZTNJRG5vMG5XZlo3dlVaYW53ak4xaTROSjNsbWNjN3RQbFByOUwvRWFi?=
 =?utf-8?B?azhVb1V1ekY5QzdUZ3NqdFhQcUtOejh1ZFZod0w4bkx0ZFpCbDV0YUtRSWJO?=
 =?utf-8?B?dnpQTm9EWVRlclRONmE4RnNYdHk4NmF2NkZGWDh5WjJqYTBpZGlXTVNFczNX?=
 =?utf-8?B?eEhHS1RWclpHdVIvTTB1Nnp6VVBLTHEydGJxbm00UjhSVURDOG1zaGVna3ZE?=
 =?utf-8?B?MnRKRzYzcjExS3RGYitxOUV3N0crMm13WWpNbGNMRHdmMjA5aytRalBTS29u?=
 =?utf-8?B?ckJXU2xCR2U3cG4zcEpUeWJ1YjlkbEhxbUFOdXAvc3gyUS9idWZvK3prMG1B?=
 =?utf-8?B?SDdjRmtmVHBsa2QzaUI2TGY0cHQ0OGsrd0MxaWZIY2dMQjlyZitjdGg0YzVj?=
 =?utf-8?B?ckJCb1gra0Y2OE9VTDlQWDhNVlRLNVVWS3RPd0o3NUFSZzMzaFJqWHVZbldu?=
 =?utf-8?Q?G8sZicrKbWkpMM80lawQISA3Eo2bEFk1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFdJN1FmYTFoYUNLWUNnR0RCbG5oaVpCSDYrRVAyNUxpdVppZTRwbGFYSG96?=
 =?utf-8?B?M2VrNDRDSEEveHFZbkFKL0oraGd2WFBoR3V0TVp2a1RmdGJzNzdYYUtBd0JT?=
 =?utf-8?B?a0tnTGg1NlZUWGdnWFdCdk04cjFRMFg3L3l1aGk4RWhoMDJOdE16cTFNZS9L?=
 =?utf-8?B?Ni9pQlJjZ052OGU1ZDZXUmVEZUhFZFlSeFZidzgxZGczSDQvVUFJbFN1QnVk?=
 =?utf-8?B?OW9xN2NqTGMvQWRQSEZ3dU5ocWIxRmlwL3dKVkQ2bUliZUhNWFpVSHhaVG9L?=
 =?utf-8?B?N0N3MnJ1QWhaVU9pSWdmWmRTNHlJeHR6SEloT1J6T25xT0dONnh1bzhxZXZi?=
 =?utf-8?B?RXVNK0R0L2lxa2JlVnIyVXdYSzdjOFBJdHpmNnFGSDNlRXNZQXJNckl0RUNa?=
 =?utf-8?B?bTJNUEpNejlVN3ZEZWZQZHhBUy82alczUWs4MEVrcm9VLzUyWEcyMWdwM0Fm?=
 =?utf-8?B?SXZHRi9hWHZYajMvdXU1ckJRUHZRSU1BZ1lJd1NKczN1RlhNQzR6RWxtY1pL?=
 =?utf-8?B?QWdOZmZsTjZkM3Q0bHNTTzRlaERzckJRY1ROQTExRUY5RWlqSE1RdDh1ZmRI?=
 =?utf-8?B?ZTAydUkyd25RM2pmTXRzS1A0cEE5RWdRbEJlWVFRbzc0akNLeGlxenEzZC9y?=
 =?utf-8?B?S1UwZ0hmYWhBVitSNFRWb1gvMlQ2dE1NWjZmMURjRnhya3RzWVdVMUErY2V6?=
 =?utf-8?B?Nm0xT2QyekV2N3M3R3BsZ1BFa0pqbUQxcStYMGdUZXdpUmZiUkUvU25LRlN3?=
 =?utf-8?B?QnlkakJ3bUd6cy8xSGtzclBkNmNOY0gvaFNNZ0piRVAyWWdGWjJQTWdlV2hJ?=
 =?utf-8?B?NFVNSWI1Zmc2dFBWTE9BSUJVZ0xNWTAvSkdMSXJHdUQwL1lubEdhVy93WHdm?=
 =?utf-8?B?dkUvMHlWaHBaMUxCOGpPSTlPWWpYMVpISm1yVGhrTnVSd2ZFb3NacWRrRFdk?=
 =?utf-8?B?VXJhUTJld0ZYZkhURlRlSzN3dnN1QWNIeXdubVdKT2pBQVVNQy9vQStLZmZF?=
 =?utf-8?B?c04zSHNodnpCMzB2ai93ZFJWRldsNzJjNXVzVnZEZkN5UC9IY0hKakNWZlZH?=
 =?utf-8?B?N1ZBVi8vSDNPTHZpaldCNk0xTFR2Y0tUUDhwRDM0cVc2S09UeCt2MWRBSDlr?=
 =?utf-8?B?SWFacC9lRVYvRis1a01SRmFZc0kxUkpMUWEyaGtNaUdZV0RyaFU1VGt2N3lY?=
 =?utf-8?B?eUJhSFM0RzU4S09PenlvOXRLWU91c1BHd2FTWC95a3QwL1ZadWdtQnk0bDdx?=
 =?utf-8?B?bDFwMVh1ejBtUGx2cm9IYml0UTN5b0lUb3dDVzRxczNGaUVjZkxHcnFqaUFL?=
 =?utf-8?B?ODI4RjJROW9SWWdCNy9rZDBOVTkrSnZNcVFXZXdvaUN6UzQvbVZJUmg0c296?=
 =?utf-8?B?U3BsUkI0aWJBVlcySWVTZjYrQmRaWWd4NDRCSCs1L0FwVm9OTHBqSTFxeUMx?=
 =?utf-8?B?L3dpSGdjcFJnQTlPbTlwVGZXams2TWJwSlE0TGEwTGpFRm9TUE9lMExIK3dZ?=
 =?utf-8?B?TkFiVzRTRlRzNEZFNktLSnUydlZYbDRGVEhYckhNR3QzNGh6Uk4vbXpza0Zx?=
 =?utf-8?B?VVJBNFRZUGxBS0dCNUwraE40WE1xNklJUmREMmJVa0ZPODQ4U1NQOFgxUjFk?=
 =?utf-8?B?NGpuL05XZmg4WWs0RTJic2VmWEJjM01LQUpJcWRudnRzM3VkM3l2MTFRc0d3?=
 =?utf-8?B?SVNPQWVtU3ZLMkd4WVRMWkdSVkRjb0FGbS9pN3ZXMjlyTk1Mek5Qc2kxUExy?=
 =?utf-8?B?Vjh5SmNmaVlFUzN2aWlSdjQ4K2cxMGFTWmtnWkRENXAzdWFwZjcvRlA1T09t?=
 =?utf-8?B?SlBZc21MSjh4R2RQcENXQllnQU5kdDhNSzdycXgvSE9yaktxYlNrSmI3TTlO?=
 =?utf-8?B?UlBqM1d6NEtBTlhETzYzNitwZ3Q0WnlibWlaL1RLSzUyeG44QVpWUHhzK1RM?=
 =?utf-8?B?SU5KL1FIQXIybHcxNW8rT05aTVhET0pWOTZlRlhGMlVwOC9ab0lidzhhaWJT?=
 =?utf-8?B?bWtxYmVVWHNLOGM1YUgzWlpwVVQyZHdqaExMaWdINlVKbDhVTXhLL2VzUHNn?=
 =?utf-8?B?bTJ1SnJmYUIwQytQV2FnL0xaVnFHR0QvUllzcjFzWEt3SXlMWTRZMW15QmJv?=
 =?utf-8?Q?mVBo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b4c76a-d6c0-4fee-db77-08de0a61f3f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 14:08:15.4024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+Z0zTV7MuWAhOPosocJg6oENdfMgtkQiglvw83Nx9vypIo0mnQyp/I8TwZmmSZd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
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
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogYW1kLWdmeCA8YW1kLWdmeC1i
b3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIE1hcmlvDQo+TGltb25j
aWVsbG8NCj5TZW50OiBNb25kYXksIE9jdG9iZXIgMTMsIDIwMjUgNzozNCBQTQ0KPlRvOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7IERldWNoZXIsDQo+QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPkNj
OiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBMZWUsIFBl
eXRvbg0KPjxQZXl0b24uTGVlQGFtZC5jb20+OyBTdWx0YW4gQWxzYXdhZiA8c3VsdGFuQGtlcm5l
bHRvYXN0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzXSBkcm0vYW1kOiBDaGVjayB0aGF0
IFZQRSBoYXMgcmVhY2hlZCBEUE0wIGluIGlkbGUNCj5oYW5kbGVyDQo+DQo+T24gMTAvMTMvMjUg
ODo1OSBBTSwgTGF6YXIsIExpam8gd3JvdGU6DQo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0g
QU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPj4+IEZyb206IE1hcmlvIExpbW9uY2llbGxvIDxzdXBlcm0xQGtlcm5lbC5v
cmc+DQo+Pj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDEzLCAyMDI1IDc6MjEgUE0NCj4+PiBUbzog
TGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+Pj4gQ2M6IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1k
LmNvbT47IExlZSwgUGV5dG9uDQo+Pj4gPFBleXRvbi5MZWVAYW1kLmNvbT47IFN1bHRhbiBBbHNh
d2FmIDxzdWx0YW5Aa2VybmVsdG9hc3QuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNd
IGRybS9hbWQ6IENoZWNrIHRoYXQgVlBFIGhhcyByZWFjaGVkIERQTTAgaW4NCj4+PiBpZGxlIGhh
bmRsZXINCj4+Pg0KPj4+IE9uIDEwLzEyLzI1IDExOjU0IFBNLCBMYXphciwgTGlqbyB3cm90ZToN
Cj4+Pj4gW1B1YmxpY10NCj4+Pj4NCj4+Pj4gRG9lc24ndCB0aGlzIHRyYW5zbGF0ZSB0byBqdXN0
IGEgaGlnaGVyIGlkbGUgdGltZW91dA0KPj4+PiAoVlBFX0lETEVfVElNRU9VVCApIGZvcg0KPj4+
IHRoZSBwYXJ0aWN1bGFyIFZQRSB2ZXJzaW9uPw0KPj4+Pg0KPj4+PiBUaGFua3MsDQo+Pj4+IExp
am8NCj4+Pg0KPj4+IFllcyBpZiB0aGUgVlBFIG1pY3JvY29kZSBhZGp1c3RzIERQTSBhdCBydW50
aW1lIHRoaXMgbWFrZXMgc3VyZSB0aGF0DQo+Pj4gaXQgaGFzIHNldHRsZWQgd2hlbiB3b3JrbG9h
ZCBpcyBjb21wbGV0ZS4NCj4+Pg0KPj4+IEkgZXhwZWN0IHRoYXQgYSBoaWdoZXIgVlBFX0lETEVf
VElNRU9VVCB3b3VsZCB3b3JrIHRvbywgYnV0IGl0IHNlZW1zDQo+Pj4gbGVzcyBzY2FsYWJsZSB0
byBtZS4NCj4+Pg0KPj4gW2xpam9dDQo+Pg0KPj4gSSBndWVzcyBWUEUgZmlybXdhcmUgYmVoYXZp
b3IgY291bGQgdmFyeSBhY3Jvc3MgZ2VuZXJhdGlvbnMuIEZvciBleDogZXZlbiBpZiBpdA0KPmRv
ZXNuJ3QgbG93ZXIgdGhlIGNsb2NrcyBpbiB0aGlzIGdlbmVyYXRpb24sIGl0IGNvdWxkIGRvIHNv
IGFmdGVyIHNlZWluZyBhIHBvd2VyDQo+Z2F0ZSAoYW55IGhhbmRzaGFrZSB3aXRoIFBNRlcpLiBP
ciwgZXZlbiBpZiBpdCBkb2Vzbid0IGxvd2VyIHRoZSBjbG9jaywgaXQgbWF5DQo+YWRqdXN0IHRo
ZSBjbG9ja3MgYWZ0ZXIgcG93ZXJpbmcgdXAuDQo+Pg0KPj4gU28gcHJvYmFibHkganVzdCBrZWVw
aW5nIHZwZS5pZGxlX3RpbWVvdXQgYXMgYSB2YXJpYWJsZSBiYXNlZCBvbiBJUCB2ZXJzaW9uDQo+
bWF5IGJlIGdvb2QgZW5vdWdoIGZvciB0aGUgY3VycmVudCBpc3N1ZS4NCj4NCj4iSWRlYWxseSIg
UE1GVyB3b3VsZCBsb3dlciBjbG9ja3MgYmVmb3JlIHR1cm5pbmcgb2ZmIFZQRSwgYnV0IHRoYXQn
cyBub3QgdGhlDQo+Y2FzZSByaWdodCBub3cgb24gU3RyaXggSGFsby4gIFdlIGp1c3QgZ2V0IGx1
Y2t5IHdpdGggb2xkZXIgVlBFIG1pY3JvY29kZSB0aGF0IGl0DQo+ZG9lc24ndCBjaGFuZ2UgdGhp
cy4NCj4NCltsaWpvXQ0KUE1GVyBjb3VsZCBiZSBjaGFuZ2luZyBjbG9ja3Mgb25seSBvbiBWUEUg
cmVxdWVzdHMuIElkZWFsbHksIGl0J3Mgbm90IHJlcXVpcmVkIHRvIGxvd2VyIERQTSBjbG9jayBi
ZWZvcmUgcG93ZXItb2ZmLCBqdXN0IGtlZXBpbmcgaXQgYXQgZGVlcCBzbGVlcCBpcyBnb29kIGVu
b3VnaCB3aGljaCBnb2VzIGV2ZW4gbG93ZXIgdGhhbiBEUE0wIGxldmVscy4gRGVlcCBzbGVlcCB0
aGVzZSBkYXlzIGlzIHRha2VuIGNhcmUgYnkgaGFyZHdhcmUuDQoNClRoYW5rcywNCkxpam8NCg0K
Pk15IHRob3VnaHQgd2FzIHRoaXMgY3VycmVudCBzb2x1dGlvbiB3aWxsIHdvcmsgcHJvcGVybHkg
b24gYWxsIG1pY3JvY29kZQ0KPnZlcnNpb24gb24gYWxsIHByb2R1Y3RzLiAgSWYgUE1GVyBjaGFu
Z2VzIGJlaGF2aW9yIHdlIGNvdWxkIGFkZCBjb25kaXRpb25hbA0KPmNvZGUgbGF0ZXIgdG8gb25s
eSBkbyB0aGlzIGNoZWNrIGZvciBEUE0gbGV2ZWwgaWYgb24gb2xkZXIgUE1GVy4NCj4NCj5BbGV4
LA0KPg0KPldoYXQgZG8geW91IHdhbnQgdG8gc2VlIGhlcmU/DQo+Pg0KPj4gVGhhbmtzLA0KPj4g
TGlqbw0KPj4NCj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+PiBGcm9tOiBh
bWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYg
T2YNCj4+Pj4+IE1hcmlvIExpbW9uY2llbGxvIChBTUQpDQo+Pj4+PiBTZW50OiBNb25kYXksIE9j
dG9iZXIgMTMsIDIwMjUgMTI6NDggQU0NCj4+Pj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPj4+Pj4gQ2M6IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9A
YW1kLmNvbT47IExlZSwgUGV5dG9uDQo+Pj4+PiA8UGV5dG9uLkxlZUBhbWQuY29tPjsgU3VsdGFu
IEFsc2F3YWYgPHN1bHRhbkBrZXJuZWx0b2FzdC5jb20+DQo+Pj4+PiBTdWJqZWN0OiBbUEFUQ0gg
djNdIGRybS9hbWQ6IENoZWNrIHRoYXQgVlBFIGhhcyByZWFjaGVkIERQTTAgaW4NCj4+Pj4+IGlk
bGUgaGFuZGxlcg0KPj4+Pj4NCj4+Pj4+IEZyb206IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5s
aW1vbmNpZWxsb0BhbWQuY29tPg0KPj4+Pj4NCj4+Pj4+IFtXaHldDQo+Pj4+PiBOZXdlciBWUEUg
bWljcm9jb2RlIGhhcyBmdW5jdGlvbmFsaXR5IHRoYXQgd2lsbCBkZWNyZWFzZSBEUE0gbGV2ZWwN
Cj4+Pj4+IG9ubHkgd2hlbiBhIHdvcmtsb2FkIGhhcyBydW4gZm9yIDIgb3IgbW9yZSBzZWNvbmRz
LiAgSWYgVlBFIGlzDQo+Pj4+PiB0dXJuZWQgb2ZmIGJlZm9yZSB0aGlzIERQTSBkZWNyZWFzZSwg
dGhlIFNPQyBjYW4gZ2V0IHN0dWNrIHdpdGggYSBoaWdoZXINCj5EUE0gbGV2ZWwuDQo+Pj4+Pg0K
Pj4+Pj4gVGhpcyBjYW4gaGFwcGVuIGZyb20gYW1kZ3B1J3MgcmluZyBidWZmZXIgdGVzdCBiZWNh
dXNlIGl0J3MgYSBzaG9ydA0KPj4+Pj4gcXVpY2sgd29ya2xvYWQgZm9yIFZQRSBhbmQgVlBFIGlz
IHR1cm5lZCBvZmYgYWZ0ZXIgMXMuDQo+Pj4+Pg0KPj4+Pj4gW0hvd10NCj4+Pj4+IEluIGlkbGUg
aGFuZGxlciBiZXNpZGVzIGNoZWNraW5nIGZlbmNlcyBhcmUgZHJhaW5lZCBjaGVjayB0aGF0IFZQ
RQ0KPj4+Pj4gRFBNIGxldmVsIGlzIHJlYWxseSBpcyBhdCBEUE0wLiBJZiBub3QsIHNjaGVkdWxl
IGRlbGF5ZWQgd29yayBhZ2FpbiB1bnRpbCBpdA0KPmlzLg0KPj4+Pj4NCj4+Pj4+IENjOiBQZXl0
b24uTGVlQGFtZC5jb20NCj4+Pj4+IFJlcG9ydGVkLWJ5OiBTdWx0YW4gQWxzYXdhZiA8c3VsdGFu
QGtlcm5lbHRvYXN0LmNvbT4NCj4+Pj4+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0
b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvNDYxNQ0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogTWFyaW8g
TGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+
IHYzOg0KPj4+Pj4gKiBVc2UgbGFiZWwgdG8gYXZvaWQgYSByZWdpc3RlciByZWFkIGlmIGZlbmNl
cyBhY3RpdmUNCj4+Pj4+IC0tLQ0KPj4+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZwZS5jIHwgMTUgKysrKysrKysrKysrLS0tDQo+Pj4+PiAxIGZpbGUgY2hhbmdlZCwgMTIg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZwZS5jDQo+Pj4+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cGUuYw0KPj4+Pj4gaW5kZXggNDc0YmZlMzZjMGMy
Zi4uZThlNTEyZGU1OTkyYSAxMDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92cGUuYw0KPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZwZS5jDQo+Pj4+PiBAQCAtMzI2LDE0ICszMjYsMjMgQEAgc3RhdGljIHZvaWQg
dnBlX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdA0KPj4+Pj4gd29ya19zdHJ1Y3QgKndvcmspICB7
DQo+Pj4+PiAgICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0NCj4+Pj4+ICAgICAg
ICAgICAgICAgICBjb250YWluZXJfb2Yod29yaywgc3RydWN0IGFtZGdwdV9kZXZpY2UsDQo+Pj4+
PiB2cGUuaWRsZV93b3JrLndvcmspOw0KPj4+Pj4gKyAgICAgIHN0cnVjdCBhbWRncHVfdnBlICp2
cGUgPSAmYWRldi0+dnBlOw0KPj4+Pj4gICAgICAgICB1bnNpZ25lZCBpbnQgZmVuY2VzID0gMDsN
Cj4+Pj4+ICsgICAgICB1aW50MzJfdCBkcG1fbGV2ZWw7DQo+Pj4+Pg0KPj4+Pj4gICAgICAgICBm
ZW5jZXMgKz0gYW1kZ3B1X2ZlbmNlX2NvdW50X2VtaXR0ZWQoJmFkZXYtPnZwZS5yaW5nKTsNCj4+
Pj4+ICsgICAgICBpZiAoZmVuY2VzKQ0KPj4+Pj4gKyAgICAgICAgICAgICAgZ290byByZXNjaGVk
dWxlOw0KPj4+Pj4NCj4+Pj4+IC0gICAgICBpZiAoZmVuY2VzID09IDApDQo+Pj4+PiArICAgICAg
ZHBtX2xldmVsID0gYWRldi0+cG0uZHBtX2VuYWJsZWQgPw0KPj4+Pj4gKyAgICAgICAgICAgICAg
ICAgIFJSRUczMih2cGVfZ2V0X3JlZ19vZmZzZXQodnBlLCAwLCB2cGUtDQo+Pj4+Pj4gcmVncy5k
cG1fcmVxdWVzdF9sdikpIDogMDsNCj4+Pj4+ICsgICAgICBpZiAoIWRwbV9sZXZlbCkgew0KPj4+
Pj4gICAgICAgICAgICAgICAgIGFtZGdwdV9kZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRl
KGFkZXYsDQo+Pj4+PiBBTURfSVBfQkxPQ0tfVFlQRV9WUEUsIEFNRF9QR19TVEFURV9HQVRFKTsN
Cj4+Pj4+IC0gICAgICBlbHNlDQo+Pj4+PiAtICAgICAgICAgICAgICBzY2hlZHVsZV9kZWxheWVk
X3dvcmsoJmFkZXYtPnZwZS5pZGxlX3dvcmssDQo+Pj4+PiBWUEVfSURMRV9USU1FT1VUKTsNCj4+
Pj4+ICsgICAgICAgICAgICAgIHJldHVybjsNCj4+Pj4+ICsgICAgICB9DQo+Pj4+PiArDQo+Pj4+
PiArcmVzY2hlZHVsZToNCj4+Pj4+ICsgICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmFkZXYt
PnZwZS5pZGxlX3dvcmssDQo+Pj4+PiArVlBFX0lETEVfVElNRU9VVCk7DQo+Pj4+PiB9DQo+Pj4+
Pg0KPj4+Pj4gc3RhdGljIGludCB2cGVfY29tbW9uX2luaXQoc3RydWN0IGFtZGdwdV92cGUgKnZw
ZSkNCj4+Pj4+IC0tDQo+Pj4+PiAyLjQzLjANCj4+Pj4NCj4+DQoNCg==
