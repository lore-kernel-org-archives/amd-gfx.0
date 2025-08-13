Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555F7CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 10:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48B310E6D4;
	Wed, 13 Aug 2025 10:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H0sjNg7p";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 281AD10E6D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 10:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpxxHKc/Ov6oG3eYjKxMp6Rp++/CpdD1K2H7f23mPH40t85sz9ozORwxSqZ9POrWgUXRkCZQwFdDPBKzxXzN4FxYiGWDuYUdtyixX1hKgLRxFq+NzHkV188MiI2W/Uj0K3n63cD4OOvVIo7UfqaVNhqJGpKBy274/y2E5ugxzXFGJUXQPgsxWqKG7avrCheEK42ATonNEJHfi0x+fvx9BAA4+9Vr4LeEK00ZIQZ8kPkhoj2wqkHc6o9oTDL7Q3D1GnAma+FEYkeZyqyUXyjoPTb5IkQyIgIJaQi8RTjoAl0iJ52A4BR6WUWSaMuGaJrY/9DiUO76NfhBp2PL+Eh0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHOXF/qNvuOwwWY7VDMHRept6wAnnNahmLn/9u3BQ7Q=;
 b=bPTD36dtClCQPLaLScskelzJQNRnRF+jO3n/bncU9XTIQAGIC+VnRmGVZEi27YeucDlDKv07qituLxs56oemJd4sBQXgxXcHpOVU1xTM2KGsBI+uePxX0/uE/6eeaA58yOoBjOeg7f6kNnVsjrGfWEx2vyOpTxoW8CbQzED9WLJOML40fQTY40PYB+8GkCJkTecLP/HBHWvKApCtZcMk6XvWRRwx4iMtigEOgStyXmibVdc71DXz7AhPtCeJXUIcnpWGHnsDWkVqTDxYnYTVj+XCRBStY5rxiZY+M0b7R3v2lr3YtaoO++HUWmWg9ZyPjdJNVuIlc8JbLjQ/DDmW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHOXF/qNvuOwwWY7VDMHRept6wAnnNahmLn/9u3BQ7Q=;
 b=H0sjNg7pZht8kVOxbAuPUncKZ99uDMUJyEzGX9VRwEOMcXJ/SSPxGF8Q+J/u8tHbFbMeOw3ZXjK7UwHxhiCfkl1NxldBAjZb8eqnGPGJwnUF1GC5UIz9tUerOd17jqa+G9oPaYw6Cwotw/PcnoVJHEiuNnzluXnPWGzymOJ/5mA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Wed, 13 Aug
 2025 10:11:12 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.9009.016; Wed, 13 Aug 2025
 10:11:12 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/swm14: Update power limit logic
Thread-Topic: [PATCH] drm/amdgpu/swm14: Update power limit logic
Thread-Index: AQHcCKMnMsUXHtaL20u3PWwDAHlBJrRfTsgAgAEVGhA=
Date: Wed, 13 Aug 2025 10:11:12 +0000
Message-ID: <DM4PR12MB51522C0B6CB60F86C1D282A4E32AA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250808202912.2067194-1-alexander.deucher@amd.com>
 <CADnq5_MiUK-wPHthDU__j0e=vM7_829=CzaMXQdRHM895tzNzQ@mail.gmail.com>
In-Reply-To: <CADnq5_MiUK-wPHthDU__j0e=vM7_829=CzaMXQdRHM895tzNzQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-13T10:11:04.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW4PR12MB8612:EE_
x-ms-office365-filtering-correlation-id: 4972ba1b-71c4-4043-63f9-08ddda51bafb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UjRBMmhKMjYwaWR0OEJyZWkxUTQ2SmpTK2gxUXJINW5KQmYraFVOL2U4Qmx2?=
 =?utf-8?B?Y21vaWI5and0WVJ5UVJoVEZvTW5yQ0JGRXNUWklYUVRKaEJxTzIvQS9ydjdX?=
 =?utf-8?B?dXBUeGx5NG83Ylg0eWEyMFJ2eXBzUDRubVBHeU1TTFJ0WFlDRUluaHB0bnF1?=
 =?utf-8?B?clREenZiaFN3TEFqdzFTL29EWHI1ck9NL2lTRUhSSlU5NHI3TVFBMTZ0MytC?=
 =?utf-8?B?UmZYSnRwNUw1ODdtZnJNMDJhR05tZ211bGpYenJGQnh2ZHhPQXpVTGtVQzZ6?=
 =?utf-8?B?V001Ry9zUVpFWkd1dDNzQ29sTFNNZHBOS0wrUlovTStuZjkzS1VVVWUwTWdD?=
 =?utf-8?B?VnVRSGloWmJLWTh0T2tmOHBMRm1aaU1xeHJiRFl4RXNjazl2T3hrTHY4WDR4?=
 =?utf-8?B?c1FlODdycVlPaHpTbkluQlM0UkVxK0xhVE1jMnZyR05SWWRaOGdDL2VDNGxn?=
 =?utf-8?B?dGFRcTF2YzhEMFd2akY0ZzVaaldqN0JKNThnYlZDNjMvTGpzTVQyVXhZcGhZ?=
 =?utf-8?B?dkNQeFlRc1lUQmNYRUsxOGRNNnhVd0RjNXlYMytrMWw5eVlvV0tzSnFUa25Q?=
 =?utf-8?B?ajhpaFRjK2VUR05WaGwxekRvR1lxRXJQUU04cmpzRjVvUUxIMWk0MTVxczZa?=
 =?utf-8?B?cXArTkF2d1RTUkxxREt5bjlURGVTRHpVMnRUd2Z1ckVpQ0xPR1paNFlLZXZS?=
 =?utf-8?B?aFMwcytOL3ZjdDROVXlGT01vMGs5K0RNN1RNWFZYS0RNd2xuMCtaajgyaTN0?=
 =?utf-8?B?Y3BnUytnN0NydGx2a3ZoOXV0T0JmVkdxYTh5VDc0OFZUT0JxRVo2Z3g4cW5K?=
 =?utf-8?B?NS91dnFwVFdDTTdHVEV4UGExdlpjOEczOE93d0x6VW5QYU1zTkRKVXlKTE9K?=
 =?utf-8?B?U1IyZDRLQytYMmNJU1dMMHVYU29oQnZuVGhUSkdiU3FUdE9yay9HU3RacGlE?=
 =?utf-8?B?a0lwWjdyL1dQVldKVlpTWmtTbVQ0ZGd2eW5FaGFwVjNFZTgzZFh4amFaRTR3?=
 =?utf-8?B?OENmdDVmVzQ1TlBXSkZ5clpwZ09ydE9DVkZLVCtvWGtzbVQ2b25LbWdKQlVt?=
 =?utf-8?B?Zmt5VkwxOFVtNlVibHJLdFBjcG9DQmZWdEg3ZmR4d0N3aS9pYWVWVjlYMlE2?=
 =?utf-8?B?UVlZM05Na0grbGlycVk4aGxDQXB1cHhCZUxDNlcxNFFBMWk0MXd1V1ArQ21I?=
 =?utf-8?B?VFdmQnA0ZE1RUVNsKzBtU3lraEJQWC9jeVhlQWtVTnNKb202Z0VQMzE3cUo3?=
 =?utf-8?B?RDNncnZvR1J1WVNtd2JqQk9UTFYzU010T0xpVHVTYW0yV2VZK3pyZ1VudGQw?=
 =?utf-8?B?OFo0V1p2SGZraytPSEt0bUxsV041T0JsMGJ5Qm5kcHc4VG9HcFpxUmcwbHhn?=
 =?utf-8?B?eSs1Nm9UTWptdG9YNi9LZzRTb0Zzak0vUkl5U2ZkT2lzRFRPS0J2YktNaTJO?=
 =?utf-8?B?ME1pZlhDVmJIN2hPVVYvbnh6dmVKZnlKMGUyMTRZck5GWEdCUjRoREExMEtN?=
 =?utf-8?B?S0tBTThKRkI4LzBrUDhGR3BqV3lhd0ZjN1FmTUZ4aUVzRkZadjdCdkt4Y3Ju?=
 =?utf-8?B?T0lXSEEzTUJscjZUbytobklIWStrcDJqeFdGWDY4SkprU1ZkWm1MRFVzOXIz?=
 =?utf-8?B?a3hNM2J5L29pazc2cGN3N2xjTldrNU1MUWhNeElRVG1ZYU5lQTI1Z0pVVGlK?=
 =?utf-8?B?amd0WVcyV1haK0hiZDBRRnl4dmdSVlprRHM1dStKZkpsczE4MjlWTHBZYkw2?=
 =?utf-8?B?K0IwaVVlTDd1ZVZGdkRVMlY1dktkOWdaSzcrNGV3NnRyRi9mNlBSUVNzTzla?=
 =?utf-8?B?bEFUS0RzdERvb25nUUhpSVBBQ1ZLaEpvMHZDeHJaeTEwYlpXM3hZOXIvUUdP?=
 =?utf-8?B?bnhsY1ZYL1pXaS9zQzl0ZHBPS3F3U3hObVFCY1hmOE5qTTZjQjUweExMYjBW?=
 =?utf-8?Q?IY6rmUBGM08=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1F4bzJId3VtK3JUL1VCMTZLSlY5QjRBTXFpaU9BdlVpRVlHa21hVEdIV0oz?=
 =?utf-8?B?TEs3SWsyaVNRYWcyeFg0UTdNZzJPdVRPTHFTK1FqVTNHT0E3N1RJMzk3ajQ5?=
 =?utf-8?B?dnNEK205aHhkWG5SNDNWenJkNS9KM3hkZGdhNFBFMUp0cUZQY054YmU4ZzBS?=
 =?utf-8?B?YWZ3NDJQU1luYU81QmtXNHBOOEF1bG5lTDFBaWZma0VFYzNJTWRzbU1KQmVl?=
 =?utf-8?B?VXlocjhIYllhcHNQNGRMUmJsakZ4Y2VxbFVxa280ZWM4dmttUW5lMnM5RUda?=
 =?utf-8?B?d3JEVXJ0Z25GeWswd0Qxajlwc0tHdVU2MG15TFJ6dE5rd080d2MrRkRxVSsy?=
 =?utf-8?B?WWtuNUV4L2VKU1N6QXJnanFGQ24yMm11b09CcUJFWnBFdGVKWDlDNmhSQy9E?=
 =?utf-8?B?R2hEckJvV0FNdmdBUzcwWFMvSW5wTFljZDg5OFd6cTFNa1RaQjJoZjl2dTFx?=
 =?utf-8?B?NVZ2aXRlR1NaaWpQeGNJRW1VYk5Ga0xXb0tyTWhVSytGVXZsSXV6UG4zdUo4?=
 =?utf-8?B?SjBCdmZVZ3lUMERMRVpPK3ZjVUpvMXU1MDM0ak8yN3hqSFNGUzUrckhiTUlp?=
 =?utf-8?B?MXd1OS9DVUc5c28wQXJXUXpiWW0yMzBmSDVnV1p5cWtENGN2M2ZadEpYOXo0?=
 =?utf-8?B?dDB5VG5YVGkwTkc4bVMyamtnM2FBM0pJQksvSzF5T0IyTE54K1VYWGQ1ejZX?=
 =?utf-8?B?Y09XUVBlQkIyZWx3dDJZVDNkRGpyYU5TcVZZNUUzdWZYZWlIVkdpOWhyTHVC?=
 =?utf-8?B?bnc3dlJmalBwZXR3K1ltSTROUGd6emNVNENpMC82cmxwRDNpWFo3cUIyQkRS?=
 =?utf-8?B?SW5KQm02S3dMUkJhMU1NV3czWG9wOEsvT2Y2ck9WT3ZsR2Z0ZjZFK2RsYkgz?=
 =?utf-8?B?T1NFOWc4bkFBZnp0YTh4NHZ3c3ZLNFlmdlArRnVQRmV5bHF2SVlwaUd4UFoz?=
 =?utf-8?B?V3B5M1A2dUZaU1dwZDdsc21LOGlNM2toNjJndVlZOVFOZGNFbWZZaGk0eDNG?=
 =?utf-8?B?ci85WWpvNURTRmE1d2ZQalJmQkxmVUc2OVY4WC92aDRFVWJyMkhzZWhGQThC?=
 =?utf-8?B?dkRGSklWT3MvaW5RbGxHeDNaM05UWjBZQ0dmdURlT3R1cEdwYnU1OEdQaGNp?=
 =?utf-8?B?c0wrZnIvNXJCdmV0bEx5SkR0cXo4dVNpT2h0ZlgvWjFRODNmVE8zQmZGK0hr?=
 =?utf-8?B?eDBFaXBzeGQ5MFBlNGJBVmlQSUNzejBUbnBZWVFmMVIvYjhEaTVMNzFxZ1ZJ?=
 =?utf-8?B?OTZiNi85dEZSK0pGWjd3QWVZaHZmSXlmdElNSFc5TzkzZnpucDFBdXFsMEJx?=
 =?utf-8?B?ZEVxMmNYMllLOFVVbVNWcVBad2wyN3R3K0VON3FvdE9FVzFBeDA1YnBqUFFP?=
 =?utf-8?B?SkVJd0ZtRnhZSlRvODJNMVBGdmtzaGdHUXZhMXpnQ0RVb0lxNFI3RFd0UG5D?=
 =?utf-8?B?Vlowc0Z0SWFGSGNHdWVTL1VlNTlKWlVHbDdva1RUaW5mZzcxanc5Y2I4YklG?=
 =?utf-8?B?dG5TemF3MER6VEp1aFFSU3BPSlFxaHZOdFNXcEUwaWdKVnBsNlZZaTEydnYv?=
 =?utf-8?B?T3RySGN3RlBDYjBZYlBMMlp2am9qQXdQTnRzU29FQ0Y1OXpDYzQ0bk1MN2pE?=
 =?utf-8?B?elNPYzA2ZUNmRXJOa3Vza05mQ0Z6WllGUVB3aVErM3dLYlZVY01aY0pHbG1t?=
 =?utf-8?B?bEltZ0I0K3JIQmNnWWdPSjNpZHlkc25BMjJSOFI5ZHA2Y09HY1NnRXRvVWx5?=
 =?utf-8?B?TUJkWDloU1l1YjhMR2pBK0lRbjRFZXZ5M2FoVDlXWDRYTEVyUlp4U3JiNG4z?=
 =?utf-8?B?M2dwTTkyUVhLK2l5ZG8vWUdLSXRGbnppVzN2ek0xaEhxcnc2RFB3RUNhZ0Q1?=
 =?utf-8?B?Y2IrT0xWUjZnbzhXb2dEMGEzcFlJQ2dOK0VPK21NVGFoMFpFN1kyK3BvTUEw?=
 =?utf-8?B?VWdpZUFSOFR0MWFDYmlqSVZUYldXNlJTNmY4VFMxSmZqTk8xTGRHaXZvYUNO?=
 =?utf-8?B?YVAzYnpTM1dlcjNuaDN1T2tzYmxTYjVDT3BWMURaQ3lrNjlKUkZrL0R2R0cw?=
 =?utf-8?B?T0xoazd4ZFljSEh1Wk5jWkNjT0hVMnVxanpadjdyTk9NaTBxYUJTb3FqZFMz?=
 =?utf-8?Q?6t9s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4972ba1b-71c4-4043-63f9-08ddda51bafb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 10:11:12.0444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3/OaAgMXV0hsswBOnGqrJPX7sBPkSnLA89DVcv/NUQa+JXu67jJC0QzTiORs8q85Ksao9F8RppeyobCUVO/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612
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
Cg0KVGhpcyBwYXRjaCBpczoNClJldmlld2VkLWJ5OiBKZXNzZSBaaGFuZyA8SmVzc2UuWmhhbmdA
YW1kLmNvbT4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFt
ZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4IERl
dWNoZXINClNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDEzLCAyMDI1IDE6MzkgQU0NClRvOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBGZW5nLCBLZW5uZXRo
IDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS9zd20xNDogVXBkYXRlIHBvd2VyIGxp
bWl0IGxvZ2ljDQoNClBpbmc/DQoNCkFsZXgNCg0KT24gRnJpLCBBdWcgOCwgMjAyNSBhdCA0OjI5
4oCvUE0gQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiB3cm90ZToNCj4N
Cj4gVGFrZSBpbnRvIGFjY291bnQgdGhlIGxpbWl0cyBmcm9tIHRoZSB2Ymlvcy4gIFBvcnRlZCBm
cm9tIHRoZSBTTVUxMw0KPiBjb2RlLg0KPg0KPiBDbG9zZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVk
ZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzQzNTINCj4gU2lnbmVkLW9mZi1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4gIC4uLi9kcm0vYW1k
L3BtL3N3c211L3NtdTE0L3NtdV92MTRfMF8yX3BwdC5jICB8IDMwDQo+ICsrKysrKysrKysrKysr
Ky0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9z
bXVfdjE0XzBfMl9wcHQuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQv
c211X3YxNF8wXzJfcHB0LmMNCj4gaW5kZXggM2FlYTMyYmFlYTNkYS4uZjMyNDc0YWY5MGIzNCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0
XzBfMl9wcHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3Nt
dV92MTRfMF8yX3BwdC5jDQo+IEBAIC0xNjk3LDkgKzE2OTcsMTEgQEAgc3RhdGljIGludCBzbXVf
djE0XzBfMl9nZXRfcG93ZXJfbGltaXQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICptaW5fcG93ZXJfbGlt
aXQpICB7DQo+ICAgICAgICAgc3RydWN0IHNtdV90YWJsZV9jb250ZXh0ICp0YWJsZV9jb250ZXh0
ID0gJnNtdS0+c211X3RhYmxlOw0KPiArICAgICAgIHN0cnVjdCBzbXVfMTRfMF8yX3Bvd2VycGxh
eV90YWJsZSAqcG93ZXJwbGF5X3RhYmxlID0NCj4gKyAgICAgICAgICAgICAgIHRhYmxlX2NvbnRl
eHQtPnBvd2VyX3BsYXlfdGFibGU7DQo+ICAgICAgICAgUFBUYWJsZV90ICpwcHRhYmxlID0gdGFi
bGVfY29udGV4dC0+ZHJpdmVyX3BwdGFibGU7DQo+ICAgICAgICAgQ3VzdG9tU2t1VGFibGVfdCAq
c2t1dGFibGUgPSAmcHB0YWJsZS0+Q3VzdG9tU2t1VGFibGU7DQo+IC0gICAgICAgdWludDMyX3Qg
cG93ZXJfbGltaXQ7DQo+ICsgICAgICAgdWludDMyX3QgcG93ZXJfbGltaXQsIG9kX3BlcmNlbnRf
dXBwZXIgPSAwLCBvZF9wZXJjZW50X2xvd2VyID0NCj4gKyAwOw0KPiAgICAgICAgIHVpbnQzMl90
IG1zZ19saW1pdCA9DQo+IHBwdGFibGUtPlNrdVRhYmxlLk1zZ0xpbWl0cy5Qb3dlcltQUFRfVEhS
T1RUTEVSX1BQVDBdW1BPV0VSX1NPVVJDRV9BQ10NCj4gOw0KPg0KPiAgICAgICAgIGlmIChzbXVf
djE0XzBfZ2V0X2N1cnJlbnRfcG93ZXJfbGltaXQoc211LCAmcG93ZXJfbGltaXQpKSBAQA0KPiAt
MTcxMiwxMSArMTcxNCwyOSBAQCBzdGF0aWMgaW50IHNtdV92MTRfMF8yX2dldF9wb3dlcl9saW1p
dChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gICAgICAgICBpZiAoZGVmYXVsdF9wb3dlcl9s
aW1pdCkNCj4gICAgICAgICAgICAgICAgICpkZWZhdWx0X3Bvd2VyX2xpbWl0ID0gcG93ZXJfbGlt
aXQ7DQo+DQo+IC0gICAgICAgaWYgKG1heF9wb3dlcl9saW1pdCkNCj4gLSAgICAgICAgICAgICAg
ICptYXhfcG93ZXJfbGltaXQgPSBtc2dfbGltaXQ7DQo+ICsgICAgICAgaWYgKHBvd2VycGxheV90
YWJsZSkgew0KPiArICAgICAgICAgICAgICAgaWYgKHNtdS0+b2RfZW5hYmxlZCAmJg0KPiArICAg
ICAgICAgICAgICAgICAgIHNtdV92MTRfMF8yX2lzX29kX2ZlYXR1cmVfc3VwcG9ydGVkKHNtdSwg
UFBfT0RfRkVBVFVSRV9QUFRfQklUKSkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBvZF9w
ZXJjZW50X3VwcGVyID0gcHB0YWJsZS0+U2t1VGFibGUuT3ZlckRyaXZlTGltaXRzQmFzaWNNYXgu
UHB0Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICBvZF9wZXJjZW50X2xvd2VyID0gcHB0YWJs
ZS0+U2t1VGFibGUuT3ZlckRyaXZlTGltaXRzQmFzaWNNaW4uUHB0Ow0KPiArICAgICAgICAgICAg
ICAgfSBlbHNlIGlmIChzbXVfdjE0XzBfMl9pc19vZF9mZWF0dXJlX3N1cHBvcnRlZChzbXUsIFBQ
X09EX0ZFQVRVUkVfUFBUX0JJVCkpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgb2RfcGVy
Y2VudF91cHBlciA9IDA7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG9kX3BlcmNlbnRfbG93
ZXIgPSBwcHRhYmxlLT5Ta3VUYWJsZS5PdmVyRHJpdmVMaW1pdHNCYXNpY01pbi5QcHQ7DQo+ICsg
ICAgICAgICAgICAgICB9DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgZGV2X2RiZyhzbXUt
PmFkZXYtPmRldiwgIm9kIHBlcmNlbnQgdXBwZXI6JWQsIG9kIHBlcmNlbnQgbG93ZXI6JWQgKGRl
ZmF1bHQgcG93ZXI6ICVkKVxuIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG9kX3BlcmNlbnRfdXBwZXIsDQo+ICsgb2RfcGVyY2VudF9sb3dlciwgcG93ZXJfbGlt
aXQpOw0KPiArDQo+ICsgICAgICAgaWYgKG1heF9wb3dlcl9saW1pdCkgew0KPiArICAgICAgICAg
ICAgICAgKm1heF9wb3dlcl9saW1pdCA9IG1zZ19saW1pdCAqICgxMDAgKyBvZF9wZXJjZW50X3Vw
cGVyKTsNCj4gKyAgICAgICAgICAgICAgICptYXhfcG93ZXJfbGltaXQgLz0gMTAwOw0KPiArICAg
ICAgIH0NCj4NCj4gLSAgICAgICBpZiAobWluX3Bvd2VyX2xpbWl0KQ0KPiAtICAgICAgICAgICAg
ICAgKm1pbl9wb3dlcl9saW1pdCA9IDA7DQo+ICsgICAgICAgaWYgKG1pbl9wb3dlcl9saW1pdCkg
ew0KPiArICAgICAgICAgICAgICAgKm1pbl9wb3dlcl9saW1pdCA9IHBvd2VyX2xpbWl0ICogKDEw
MCArIG9kX3BlcmNlbnRfbG93ZXIpOw0KPiArICAgICAgICAgICAgICAgKm1pbl9wb3dlcl9saW1p
dCAvPSAxMDA7DQo+ICsgICAgICAgfQ0KPg0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiAt
LQ0KPiAyLjUwLjENCj4NCg==
