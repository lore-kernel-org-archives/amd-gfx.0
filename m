Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A67D0BB66
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 06:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 608A610E8B9;
	Thu, 24 Oct 2024 06:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pOisxWRb";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260A910E8B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 06:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOOkhDWL4qONVy62+3yBLeVEoM66BdI5r92OXUUafyzCZjSi6VPmc+WOZPKuJz8ecBoyEv/XIHWt85VaFJnDSblpbLgUkN1V/L1wmyecwY/3VXTWlFSep5w4ZG/QEiO27Q+6f2VbgDhW4PKGvovQFKP/WRowMhaykl7sNjeYB73xWgsZlEVDXSEFIR5VpeqIk0ztj7SldGLjaPPc7lpll3RiuJW3O/ni6xUcDfbI6KBH6/oig7Px1tEvS7+KQv/Ksjq/BejIA6xxEGONXTGFTIlB8ptHY45qOiiDKmDqSB+mutYyCPnSWWjoeF9HGslS/6B515YNw5mvsYyDutPsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwAkiIsGFeA2w468ufgSRoAm5yLGb1F7JD8Yfi2nUbo=;
 b=LmqwQPFABPBRfv1lO0HqfMZG5fTe87jaAcuJeyavSHxU5bdPrHG230PF0Cg/c5nuEv+CiupKSkLRSwPmqjpwedGq4j+Hl2nIV8bP0oEP+DDMsX8szg8Wbr5Z8lKCVmpo3re/eb+WVVL9etqQ3WDJ2sJG0WfvGyvrd12wYT6lgC+PKm5lPd/Y+j9HnTbLo2GU9rGabVOwwq8Hwa8FMDNT8n4sifz6W8zEM4/dnkEiV7TXeCvV8+TVkuu5xW+uWgSq+cL2N1Q7PDcEKI9ykGDl/r7BP7X4QvyR9mTpSsZ/UpwS2PO14pjlP8gEyEYAQ+boaR05MKPPxNg1cfeZS2Qjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwAkiIsGFeA2w468ufgSRoAm5yLGb1F7JD8Yfi2nUbo=;
 b=pOisxWRbDe7hsYlhfyG4lokc1NuwWLHFhNb1F/KHApxoOG7DV2JXui2LaYNtdcBbCwXEV6Y7V2F0SMpwYMxkSQ4ay3TzB6zPpo2bX4Rp1c81ycK4hJaWoDysGOxVFALrIt8UnS38LbNT1CTLLTQtanW1Fw8ZdxJLrjNzsfd0WUw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 06:53:05 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 06:53:04 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
Thread-Index: AQHbHg2S9Q7S+WlsDEqU6j9plY5fkLKUOAqAgAEBFJCAABc5gIAAJb8g
Date: Thu, 24 Oct 2024 06:53:04 +0000
Message-ID: <DS7PR12MB6005BE51A4AD1F10AA9C8756FB4E2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20241014074902.1837757-1-Prike.Liang@amd.com>
 <20241014074902.1837757-2-Prike.Liang@amd.com>
 <8ea96dd2-260c-4fd6-a78b-4d491cd0338c@amd.com>
 <DS7PR12MB6005B9EE7961C317C9639193FB4E2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <2acb9e4b-6750-4800-9841-cf2da94558f7@amd.com>
In-Reply-To: <2acb9e4b-6750-4800-9841-cf2da94558f7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=faae743b-3d65-41af-941f-b099128336a0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-24T05:53:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA1PR12MB8700:EE_
x-ms-office365-filtering-correlation-id: a2cad051-2387-4931-1397-08dcf3f882a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZHlJU3JSMGp1QzNySHRmQmo1dkdhZDh1VUtremxFT0l4NUxyMDZvalFadjBn?=
 =?utf-8?B?T2VqRCtHYlQ1dmRtcDBqTnFjSlZrVW11VTIzdzUwTFg2QWhLUStDUHloZy9K?=
 =?utf-8?B?TWZPaG1OaVBodFNhREVFUnlkK2NhQlEwYlFqWExUb3RKdTRDM2V1UVdVNlho?=
 =?utf-8?B?M1ArOVlDSlIyNm9wUjFtMEVSZ3pBVSt4QjVPYm1DNE16aUl1MTlQUVVtcm9m?=
 =?utf-8?B?Y0wyZzk3UVkvdk1vNVpvWk1wSDFkVnNOdUpmaDk2TkRNVTZMM0Mzc3VUb0lz?=
 =?utf-8?B?dkM0S1hsdi9ac0JWNDlKanUvSWowK3BmV1AwZmx4TWRVdEkwcC8rRVI2RXRP?=
 =?utf-8?B?K0NsVVJuVTVoSkRFUTRXZVZRdmt0UWlCVGZDMUVQYjZvVzR2eXpkRW8vaXVw?=
 =?utf-8?B?MHRTUDNaS2V0aHdaWjJ1dmgyTXFPY3FzZVJTVUhTY1pFRnl6RERpUEJmYi9x?=
 =?utf-8?B?cFVPdHR5MEg5a2h5cExDUndkRVRhcnlCTEFaR2EvaWdMQ2RrSk5pZjBiSDNq?=
 =?utf-8?B?SkRlQXlCeVJuNzBxZHhBYU5CY1VMRHJMR1NxeGYyVVdQam56NWFxK1JUdTdn?=
 =?utf-8?B?TUdzQmdWTVVka3JkblMwcitXTVF0RDR1U0llaG9WU0wrdjJzdjlCUTRZeVEv?=
 =?utf-8?B?bmlmbkpxTWxaekVCVmpzQ2l3cFpNZTRoRi90LyswcHJ6U1JMcDBFOWdMMVFm?=
 =?utf-8?B?QUtZWVc4d2FjdVBFa0JCRXNMRkJialFJdVpURWJweFN1TUZwTWs1WWlTTEgv?=
 =?utf-8?B?NFo4cG5yVjVkdWVxd240ZlJiOG8rNXd0cUNDOUhrdmJicEtNdU5kYlN3Z2Ny?=
 =?utf-8?B?NG5FYloydVJVclp4S1puaGtORWg0cTJyc1grZ05BWE9mNGZRZ1AzYmFkOGdj?=
 =?utf-8?B?SlE4c1RKa2lkTWlyb0dmMnJZR3NmY0Iwb3J6M3ZiS1JCNUFHZXl2RDZNQm8w?=
 =?utf-8?B?SDg0cFh4bC9qemlROHgyYmtqNlVLMjJlSFVEWUZJdDB5RFZtT3lBNU1vcHdz?=
 =?utf-8?B?MUVKUVdBckhiVTdlWXRTNlNEV3pNbElqSkZ1TFVLRjJ6OUtaTCsxOFBWT2dD?=
 =?utf-8?B?bUFYK2t3eFpuNDRyV01PTDloMVZ0bDdxNjF3bUQ1Y1dOZ0FYb3lTSjBkTytK?=
 =?utf-8?B?MlZlN3NaVXJIUGt2WXMwWG05R0lnYnNER2VWa25BbkM5OXNnUU16bjQ0SWJB?=
 =?utf-8?B?blYvaHI2U0VYTDZJbldlUk1uUUd4Z1BmZEZUUkI5M2YwaVdiYndvS1NtTnc3?=
 =?utf-8?B?SnlQcURRd21XbFp3SjB1cjNqaWVBWlZKUmZkOTIxNXN0RXliTEcyZ3dsZnBv?=
 =?utf-8?B?dHZta3NoQSsvVEJsdHMya3VaZDVWdkxEQW0wU1M1bXlVaUhyTW9PYUVmVVVM?=
 =?utf-8?B?YlhSQmJSQUtxcldwTllVbnZOYmpxd1kzcXhHTWVnQWJ4MTVGV1RxUjlLR2RX?=
 =?utf-8?B?RmtHQ2o3SytieU9peFM4UzFENFY3N0dBVFVFcE5HRGh2TTdCMGxwbEFoeUZR?=
 =?utf-8?B?MW1vUHNLZHdTVXlmQWVtVVQ1ZXdEakJmTVFlY0lEV3lmSGJDTW44YXEyTWpU?=
 =?utf-8?B?cXNWNlBwMm05dTNoZ2QxcERiSVVic25JU0NzQ2pINlZGWEdZRUd5dzNwQ3Rx?=
 =?utf-8?B?NkFsVXJqcms2Y09tQlNUZVNRbThENzA0UnFETXBVb1ovMHV4VTBWUWlvS2ph?=
 =?utf-8?B?TjRhOGlNdUtaa09zT3dURkM3Tm5ld1N6SnJIWWwyTVdydDJrYWtMM3dOa3dV?=
 =?utf-8?B?Wlg4Z1hjOXlMU0YzWk1UUzdKYTUyT2oydE1GVjBhMTVLWFZtNW53TWpqT0dW?=
 =?utf-8?Q?rtYGtoVWhn/2zCeDCugjxBbanWDv56z3z++NE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGZnODNPWWt4VnYyQktwekhXM1pJai9iclZXRXVvWEltRTVqWUVDYTMyTWd5?=
 =?utf-8?B?Z3ZMNVFqdDVyT1VLZkhhb01SRDV2eUZ2MnBXNWIvcDcrS2plRUxyalAxbEw1?=
 =?utf-8?B?UUtLNTRGWjdkUUdnaHliSE0wYnBmUWhXSHQrQUFqRzJnMHZnYkI0UWFybktS?=
 =?utf-8?B?bHV5eCtqclF1aW51d1A4Ylpad0tuazhUVWZONG10MWZWSW4wQnRkdEdHbndi?=
 =?utf-8?B?ZlFyRjVwK00yQzM4ekZIc09TbDY3RXJnTGxpYUk3Zk84OHN3cm1VS0FBT2FI?=
 =?utf-8?B?WFFpckQ2endra2hralZDeWV2MnkwUEdFbmxjQzRIZUppd1B3YzZIWHRFSjdx?=
 =?utf-8?B?MkZ3U25rWllKS0tGc1V6dzNjaURpenZzZW1HbEwxZkFPMkhwbVpnNzVkUExJ?=
 =?utf-8?B?N0tQbkRWK0RnNkdpNUlNRlpNL1MvUmY2RlJQS2xrb05URG9KU0RGMjVNQUQ1?=
 =?utf-8?B?U29GVUdoTDFDL0IxYXlDTXlFRkw4VTFmUFpyME05RWVkbkFFMUM3L3FHTkJB?=
 =?utf-8?B?dlcwMHpvdjlNWFJvV0pTZ0VxZk1QNG15andpcThEcTJRNHpRdmo3QVdzSHZ5?=
 =?utf-8?B?blB2U2FlUjJFS0lSd3JRQkp1OFJLSFRmSytJcHMvUCt1Z3EzbzUvL2lDeVVy?=
 =?utf-8?B?TVZnMThjaFVhSFRkb0VFM3RiWHZUL1NSV1ZGOGllTGR0S3kyRVJmTjB2YzRi?=
 =?utf-8?B?SVRRUldpWkk5UUxlQlYvRlAzS2hnaUQ0cVFiR2VTcCthTksxVXhPVCtFYUQ0?=
 =?utf-8?B?djloM0tNMm5ZUncyalJUVTdWQWd2RmtzaUhwUEhsLzllOEUzbW0xOGo1ekUx?=
 =?utf-8?B?dHlPTll3d0dXOXhtYjNyVGJSb1ZUS1Zsa1ZEelpmdGsxZDZMeEFHZVRrUlVs?=
 =?utf-8?B?bHl1MlJlREpwYlZNTGZ0TXJiUkcvcHF2ZXBYYmxTczBDbTJCU3BGYUo1V2dT?=
 =?utf-8?B?YjZsVXQvMGxSL2hIMlhSZ1RxK2VVaDZFelh0SlYyeVhOVm9sQkc0dmdnS2Rr?=
 =?utf-8?B?S09wRHl5WTYzTEQyK0dHZUxzcjhsMDU3VHJaaTE0WUg3SkNueXF0MEV5emRq?=
 =?utf-8?B?aHYzcFgyOXlvZ2ZIdFhJQVZDZ3AxNFdwVEwrZkxtTjVMTHk2UlRtMi8xbkxo?=
 =?utf-8?B?eVdEMzlrN1NiZVN5MmZEL2ZnUGcxOXBsdjNvWWJvNjdyeTJZVUU3cWhpNjZP?=
 =?utf-8?B?ZHRETk9lU2U1Q0pFVElwQWZYME40WWNpeElnNEZocCtINCtydTh2SHgzSG9Q?=
 =?utf-8?B?T2o5amRpejh6ZUszNzFmSUd0SDduVFR2SmFPa214QnlSMXMrcUdENVUvamph?=
 =?utf-8?B?ZmR4UXJLN21wTkR4eGFNb1hDemFpZWtxMmNkTVgyTGZaY2d3RG9WVTVjSi9N?=
 =?utf-8?B?bERiN2RMS016R1RvZW1vRUZVTnJ3TGZiYlNyeFh1d0djSnI4WkM1aTBzR1JN?=
 =?utf-8?B?TFVTeEFiMC9GNjNDZmJFbGFBWlp0dEZWS3FBemc0cUlxZHk0OWFYQW9ZMWZq?=
 =?utf-8?B?OG1tRVRzWGI5MkpsV3NRZG53SXg4bEJFcWJTUTJKWGhmbGhPOXg2TTQxOFpS?=
 =?utf-8?B?WW1DRStyc0ZWc1F5VkNYMUcwc28rbWhwdFJ1aGNqNm9odTZBMHllNWJvQTNT?=
 =?utf-8?B?RTVjUjlWalQzU2dPWnJaYUpFb2dQUmRQS2VkK2tNMkZVNURaTnBUU21SMTNw?=
 =?utf-8?B?UkpMVXVsVldXQW5xeU4yWlc5OERFdXB0c0NDSkRrMWNFdXlMelZnMlhtaXBr?=
 =?utf-8?B?U0pWZ0xhZHZZUktTS0FhNDdMUVF6MDRXTEJ1Um94N0EzaEt2enI3dlhlZmVQ?=
 =?utf-8?B?R0lCRWNQY014UjFzOEZTWmZsbjNMeUpENUYzczRJak5TMGg5N1R0eEJoMmZt?=
 =?utf-8?B?dFFmamtOcmpRUERKOHFJRWpvVXNZbXJYM29Ca2w5bkRoMERLTTlMZ0JXUVFN?=
 =?utf-8?B?NE5rd0FnVG0zUG5oRnFabTIzRzA3Yis1bmgwUUt6d3k4dEZFTHdGOEZrdkFS?=
 =?utf-8?B?bmw4V1V4S1RHNkx4SFZTVHRIUGxXSHRaUHdjcjJ5b0ZIVWJ2dk9TN0xTemdJ?=
 =?utf-8?B?MHBtaWtpZmZBaW9iOVR1OUlWZEcvTUpKRjlVNnFBaXJuZEVINUxSQnRvdzVv?=
 =?utf-8?Q?W49A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cad051-2387-4931-1397-08dcf3f882a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 06:53:04.8706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uv8RzK/T1nRbKQ8xGVvggott9TdbN7tu0WdD6kXgBtGExPwIrdnuUD0thIEkDkaq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700
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
c2RheSwgT2N0b2JlciAyNCwgMjAyNCAxMTozOSBBTQ0KPiBUbzogTGlhbmcsIFByaWtlIDxQcmlr
ZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiAyLzJdIGRybS9hbWRncHU6IGNsZWFuIHVwIHRoZSBzdXNwZW5kX2NvbXBs
ZXRlDQo+DQo+DQo+DQo+IE9uIDEwLzI0LzIwMjQgODoyNCBBTSwgTGlhbmcsIFByaWtlIHdyb3Rl
Og0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJA
YW1kLmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIzLCAyMDI0IDY6NTUgUE0N
Cj4gPj4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSBkcm0v
YW1kZ3B1OiBjbGVhbiB1cCB0aGUgc3VzcGVuZF9jb21wbGV0ZQ0KPiA+Pg0KPiA+Pg0KPiA+Pg0K
PiA+PiBPbiAxMC8xNC8yMDI0IDE6MTkgUE0sIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+Pj4gVG8g
Y2hlY2sgdGhlIHN0YXR1cyBvZiBTMyBzdXNwZW5kIGNvbXBsZXRpb24sIHVzZSB0aGUgUE0gY29y
ZQ0KPiA+Pj4gcG1fc3VzcGVuZF9nbG9iYWxfZmxhZ3MgYml0KDEpIHRvIGRldGVjdCBTMyBhYm9y
dCBldmVudHMuIFRoZXJlZm9yZSwNCj4gPj4+IGNsZWFuIHVwIHRoZSBBTURHUFUgZHJpdmVyJ3Mg
cHJpdmF0ZSBmbGFnIHN1c3BlbmRfY29tcGxldGUuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1i
eTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgfCAyIC0tDQo+ID4+PiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgMiAtLQ0KPiA+Pj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgICB8IDQgKystLQ0KPiA+Pj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgICAgICB8IDcgKystLS0tLQ0KPiA+Pj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMgICAgICB8IDIgKy0NCj4gPj4+ICA1IGZp
bGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4+PiBpbmRleCA0OGM5
YjliMDY5MDUuLjliMzU3NjNhZTBhNyAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHUuaA0KPiA+Pj4gQEAgLTExMTEsOCArMTExMSw2IEBAIHN0cnVjdCBhbWRncHVf
ZGV2aWNlIHsNCj4gPj4+ICAgICBib29sICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluX3Mz
Ow0KPiA+Pj4gICAgIGJvb2wgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5fczQ7DQo+ID4+
PiAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbl9zMGl4Ow0KPiA+Pj4gLSAg
IC8qIGluZGljYXRlIGFtZGdwdSBzdXNwZW5zaW9uIHN0YXR1cyAqLw0KPiA+Pj4gLSAgIGJvb2wg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3VzcGVuZF9jb21wbGV0ZTsNCj4gPj4+DQo+ID4+
PiAgICAgZW51bSBwcF9tcDFfc3RhdGUgICAgICAgICAgICAgICBtcDFfc3RhdGU7DQo+ID4+PiAg
ICAgc3RydWN0IGFtZGdwdV9kb29yYmVsbF9pbmRleCBkb29yYmVsbF9pbmRleDsgZGlmZiAtLWdp
dA0KPiA+Pj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4+PiBpbmRleCA2
ODBlNDRmZGVlNmUuLjc4OTcyMTUxYjk3MCAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4+PiBAQCAtMjUwMSw3ICsyNTAxLDYgQEAgc3Rh
dGljIGludCBhbWRncHVfcG1vcHNfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpDQo+ID4+
PiAgICAgc3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsN
Cj4gPj4+ICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRybV90b19hZGV2KGRybV9k
ZXYpOw0KPiA+Pj4NCj4gPj4+IC0gICBhZGV2LT5zdXNwZW5kX2NvbXBsZXRlID0gZmFsc2U7DQo+
ID4+PiAgICAgaWYgKGFtZGdwdV9hY3BpX2lzX3MwaXhfYWN0aXZlKGFkZXYpKQ0KPiA+Pj4gICAg
ICAgICAgICAgYWRldi0+aW5fczBpeCA9IHRydWU7DQo+ID4+PiAgICAgZWxzZSBpZiAoYW1kZ3B1
X2FjcGlfaXNfczNfYWN0aXZlKGFkZXYpKSBAQCAtMjUxNiw3ICsyNTE1LDYgQEANCj4gPj4+IHN0
YXRpYyBpbnQgYW1kZ3B1X3Btb3BzX3N1c3BlbmRfbm9pcnEoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiA+Pj4gICAgIHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2ID0gZGV2X2dldF9kcnZkYXRhKGRl
dik7DQo+ID4+PiAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkcm1fdG9fYWRldihk
cm1fZGV2KTsNCj4gPj4+DQo+ID4+PiAtICAgYWRldi0+c3VzcGVuZF9jb21wbGV0ZSA9IHRydWU7
DQo+ID4+PiAgICAgaWYgKGFtZGdwdV9hY3BpX3Nob3VsZF9ncHVfcmVzZXQoYWRldikpDQo+ID4+
PiAgICAgICAgICAgICByZXR1cm4gYW1kZ3B1X2FzaWNfcmVzZXQoYWRldik7DQo+ID4+Pg0KPiA+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4g
Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiA+Pj4gaW5kZXgg
YmUzMjBkNzUzNTA3Li5iYThlNjY3NDQzNzYgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+ID4+PiBAQCAtMzI3Niw4ICszMjc2LDggQEAgc3RhdGlj
IGludCBnZnhfdjlfMF9jcF9nZnhfc3RhcnQoc3RydWN0DQo+ID4+PiBhbWRncHVfZGV2aWNlDQo+
ID4+ICphZGV2KQ0KPiA+Pj4gICAgICAqIGNvbmZpcm1lZCB0aGF0IHRoZSBBUFUgZ2Z4MTAvZ2Z4
MTEgbmVlZG4ndCBzdWNoIHVwZGF0ZS4NCj4gPj4+ICAgICAgKi8NCj4gPj4+ICAgICBpZiAoYWRl
di0+ZmxhZ3MgJiBBTURfSVNfQVBVICYmDQo+ID4+PiAtICAgICAgICAgICAgICAgICAgIGFkZXYt
PmluX3MzICYmICFhZGV2LT5zdXNwZW5kX2NvbXBsZXRlKSB7DQo+ID4+PiAtICAgICAgICAgICBE
Uk1fSU5GTygiIFdpbGwgc2tpcCB0aGUgQ1NCIHBhY2tldCByZXN1Ym1pdFxuIik7DQo+ID4+PiAr
ICAgICAgICAgICAgICAgICAgIGFkZXYtPmluX3MzICYmICFwbV9yZXN1bWVfdmlhX2Zpcm13YXJl
KCkpIHsNCj4gPj4+ICsgICAgICAgICAgIERSTV9JTkZPKCJXaWxsIHNraXAgdGhlIENTQiBwYWNr
ZXQgcmVzdWJtaXRcbiIpOw0KPiA+Pj4gICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4+PiAgICAg
fQ0KPiA+Pj4gICAgIHIgPSBhbWRncHVfcmluZ19hbGxvYyhyaW5nLCBnZnhfdjlfMF9nZXRfY3Ni
X3NpemUoYWRldikgKyA0ICsNCj4gPj4+IDMpOyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc29jMTUuYw0KPiA+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
b2MxNS5jDQo+ID4+PiBpbmRleCAxMmZmNmNmNTY4ZGMuLmQ5ZDExMTMxYTc0NCAxMDA2NDQNCj4g
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gPj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gPj4+IEBAIC01ODQsMTMgKzU4
NCwxMCBAQCBzdGF0aWMgYm9vbCBzb2MxNV9uZWVkX3Jlc2V0X29uX3Jlc3VtZShzdHJ1Y3QNCj4g
Pj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPj4+ICAgICAgKiAgICBwZXJmb3JtaW5nIHBtIGNv
cmUgdGVzdC4NCj4gPj4+ICAgICAgKi8NCj4gPj4+ICAgICBpZiAoYWRldi0+ZmxhZ3MgJiBBTURf
SVNfQVBVICYmIGFkZXYtPmluX3MzICYmDQo+ID4+PiAtICAgICAgICAgICAgICAgICAgICFwbV9y
ZXN1bWVfdmlhX2Zpcm13YXJlKCkpIHsNCj4gPj4+IC0gICAgICAgICAgIGFkZXYtPnN1c3BlbmRf
Y29tcGxldGUgPSBmYWxzZTsNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgIXBtX3Jlc3VtZV92
aWFfZmlybXdhcmUoKSkNCj4gPj4+ICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+Pj4gLSAg
IH0gZWxzZSB7DQo+ID4+PiAtICAgICAgICAgICBhZGV2LT5zdXNwZW5kX2NvbXBsZXRlID0gdHJ1
ZTsNCj4gPj4+ICsgICBlbHNlDQo+ID4+PiAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4+
PiAtICAgfQ0KPiA+Pj4gIH0NCj4gPj4+DQo+ID4+PiAgc3RhdGljIGludCBzb2MxNV9hc2ljX3Jl
c2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSBkaWZmIC0tZ2l0DQo+ID4+PiBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc29jMjEuYw0KPiA+Pj4gaW5kZXggYzRiOTUwZTc1MTMzLi43YTQ3YTIxZWYwMGYg
MTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jDQo+
ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jDQo+ID4+PiBAQCAt
OTA0LDcgKzkwNCw3IEBAIHN0YXRpYyBib29sIHNvYzIxX25lZWRfcmVzZXRfb25fcmVzdW1lKHN0
cnVjdA0KPiA+PiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+Pj4gICAgICAqIDIpIFMzIHN1c3Bl
bmQgZ290IGFib3J0ZWQgYW5kIFRPUyBpcyBhY3RpdmUuDQo+ID4+PiAgICAgICovDQo+ID4+PiAg
ICAgaWYgKCEoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSAmJiBhZGV2LT5pbl9zMyAmJg0KPiA+
Pj4gLSAgICAgICAhYWRldi0+c3VzcGVuZF9jb21wbGV0ZSkgew0KPiA+Pj4gKyAgICAgICAhcG1f
cmVzdW1lX3ZpYV9maXJtd2FyZSgpKSB7DQo+ID4+DQo+ID4+IExvb2tzIGxpa2UgdGhpcyB3aWxs
IGNvdmVyIG9ubHkgQUNQSSBiYXNlZCBzeXN0ZW1zLiBOb3Qgc3VyZSBpZiB0aGF0DQo+ID4+IGFz
c3VtcHRpb24gaXMgdmFsaWQgZm9yIGRHUFUgY2FzZXMuDQo+ID4+DQo+ID4+IFRoYW5rcywNCj4g
Pj4gTGlqbw0KPiA+DQo+ID4gWWVzLCB0aGUgcG1fc2V0X3Jlc3VtZV92aWFfZmlybXdhcmUoKSBm
dW5jdGlvbiBpcyBvbmx5IGNhbGxlZCBkdXJpbmcgdGhlDQo+IEFDUElfU1RBVEVfUzMgc3VzcGVu
ZCBwcm9jZXNzLiBIb3dldmVyLCBBQ1BJLWVuYWJsZWQgc3lzdGVtcyBhcmUgcG9wdWxhciBpbg0K
PiB0aGUgZGVza3RvcCB3b3JsZC4gSWYgdGhlcmUgYXJlIGNvbmNlcm5zIGFib3V0IEFDUEkgY29u
ZmlndXJhdGlvbiwgb25lIG9wdGlvbiBjb3VsZA0KPiBiZSB0byBjaGVjayBpZiB0aGUgZEdQVSBu
ZWVkcyBhIHJlc2V0IGJ5IGRpcmVjdGx5IGNoZWNraW5nIHRoZSBTT0wgcmVnaXN0ZXIuIEFzIGZh
cg0KPiBhcyBJIGNhbiBzZWUsIHdoZW4gdGhlIGRHUFUgY29tcGxldGVzIGl0cyBzdXNwZW5kIHBy
b2Nlc3MsIHRoZSBTT0wgdmFsdWUgd2lsbA0KPiByZW1haW4gemVybyB1bnRpbCB0aGUgZEdQVSBp
cyByZXN1bWVkLiBDb252ZXJzZWx5LCBpbiB0aGUgY2FzZSBvZiBhIHN1c3BlbmQgYWJvcnQsDQo+
IHRoZSBTT0wgdmFsdWUgd2lsbCBiZSBub24temVyby4NCj4gPg0KPg0KPiBpbl9zMyBpcyBzZXQg
Zm9yIGRHUFUgaW4gY2FzZSBvZiBzMGl4IGFzIHdlbGwuIFByb2JhYmx5LCB0aGF0J3MgdGhlIG9u
bHkgY2FzZSB3aGVyZQ0KPiBuZWVkIHRoZSBmbGFnIHRvIGF2b2lkIHVubmVjZXNzYXJ5IHJlc2V0
LiBPdGhlcndpc2UgU09MIGNoZWNrIGNvdWxkIGJlIHN1ZmZpY2llbnQuDQo+DQo+IFRoYW5rcywN
Cj4gTGlqbw0KPg0KRG8geW91IG1lYW4gd2UgbmVlZCB0byBpbmNsdWRlIFMwaXggdG8gcmVzZXQg
dGhlIGRHUFUgZHVyaW5nIGFuIFMwaXggc3VzcGVuZCBhYm9ydD8gSG93ZXZlciwgdGhlIGluX3Mw
aXggc3RhdGUgb2YgdGhlIGRHUFUgc2hvdWxkIGFsd2F5cyBiZSBmYWxzZSwgYW5kIHRoZXJlIGlz
IG5vIHNwZWNpZmljIHN1c3BlbnNpb24gaGFuZGxlciBmb3IgdGhlIGRHUFUgaW4gUzBpeC4gQXMg
YSBQQ0llIGVuZHBvaW50LCB0aGUgZEdQVSBzaG91bGQgYmUgcG93ZXJlZCBvZmYgZHVyaW5nIHN5
c3RlbS13aWRlKFMwaXggYW5kIFN4KSBzdXNwZW5kLCBhbmQgdGhlIFNPTCB3aWxsIGJlIHJlc2V0
IHRvIDAgZHVyaW5nIHRoZSBzdXNwZW5kIHByb2Nlc3MuIFNvLCBmb3IgdGhlIGRHUFUgcmVzdW1l
IGNhc2UsIGRvIHlvdSB0aGluayBpdCdzIGVub3VnaCB0byBkZXRlY3QgdGhlIHN1c3BlbmQgYWJv
cnQgZXZlbnQgYnkgb25seSBjaGVja2luZyBTT0wgd2l0aG91dCBhbnkgU3ggZmlsdGVyPw0KDQo+
ID4gVGhhbmtzLA0KPiA+IFByaWtlDQo+ID4+DQo+ID4+PiAgICAgICAgICAgICBzb2xfcmVnMSA9
IFJSRUczMl9TT0MxNShNUDAsIDAsIHJlZ01QMF9TTU5fQzJQTVNHXzgxKTsNCj4gPj4+ICAgICAg
ICAgICAgIG1zbGVlcCgxMDApOw0KPiA+Pj4gICAgICAgICAgICAgc29sX3JlZzIgPSBSUkVHMzJf
U09DMTUoTVAwLCAwLCByZWdNUDBfU01OX0MyUE1TR184MSk7DQo=
