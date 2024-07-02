Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AE7C41513
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 03:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2DC10E0E5;
	Tue,  2 Jul 2024 03:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QRS5h46t";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C26F10E0E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 03:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1Ainp1GihGJtwQTGNPivhlfk6XUMdwZUM9IORPuX3fENp9Dt8KZt5wyxKNQYlIeqnddDBzH7h1kd+ZyO2h5O1BHmRRaYCGLe8VOsLBgUF/fwVueEbeql+P/vJ4bK46xHTL6ZlPvuEYdTGdywhQ1xbXXUZsV5M5yxU/l7ETTApauIWnWbEFvWJBBm2WXUE9Lzz84kBeolGlHiNv/zLsLHlEewxC0dTQD0kOhA4xWr/rIxqCxZ3Q4osNUF5eFm1hmFpkC7vU7S5S9VA3Ov6Kuxk4Bsu/SZz750eE0Hz9NlJmAW0COgmN/t9CMG8hCDSUyZnLQBk7hpYwsJ5EENfVqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4mJoRXYQaDXkUIFWYGFKOl2nsAp8mLnu+GtuboyCk0=;
 b=m6DiurCh1fMCmVVrYau1khy9AbHZ9UEzaFCmXEikbFtuGAeB2gP/6VF4BogsW90NaR7QfYcl9sJguXOJJvnWayuV5VB9BzWP8LMbUGEYhbjexR0D5l/JNTN9lL01UuOJuYiUobzABkTKHDSAjngnvqE2fIrfxi0M4cj11lghxPzyLQ30rP90AsIv//uBEqhVo1dP6AyRf+hgKRp0ITmoKz8kgEJro1C+SxR1/628VAFojGZjLTtvUGaBoYLsOsi0Rx0AAW7qARE45gWyJQ7EmYp4vS3Amp3t6Pz8wRQZLsjv7DBsiuBWmOe/wsE4TLHC4tclTWCmIlCvZpKFb/iuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4mJoRXYQaDXkUIFWYGFKOl2nsAp8mLnu+GtuboyCk0=;
 b=QRS5h46t/z7+xyeyhYB9vwEoXIPlLwIvxnXvDasZ2uDtqqp2O3j3O1DKyOjtr1pSno5f9Y57W2HtCfPwRMcwyhvZgffEKiQoYRmgy36Q8V3cUGJynZnPRHulZSiEi4fI8HGYcl7/l4cRCm44zTID7TTTnvBeWyCv/w9fNyNbup4=
Received: from BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 03:09:38 +0000
Received: from BL1PR12MB5158.namprd12.prod.outlook.com
 ([fe80::b9ae:fa61:11ed:4e3b]) by BL1PR12MB5158.namprd12.prod.outlook.com
 ([fe80::b9ae:fa61:11ed:4e3b%7]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 03:09:38 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, Jaroslav Pulchart
 <jaroslav.pulchart@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: High Power Consumption of AMD RX6800xt in Idle with Secondary
 Monitor Connected
Thread-Topic: High Power Consumption of AMD RX6800xt in Idle with Secondary
 Monitor Connected
Thread-Index: AQHay4RVTlnl7+gHV0Gd6k+6TcqzarHh+amAgADJWVA=
Date: Tue, 2 Jul 2024 03:09:38 +0000
Message-ID: <BL1PR12MB5158CCFAE59B15D8D0228A4B8EDC2@BL1PR12MB5158.namprd12.prod.outlook.com>
References: <CADVcqdwr1mVW2rtKX7tMLw8o=eRVKS2-1JMy3PQ=maBCU2uH=g@mail.gmail.com>
 <CADnq5_Nx4=-uDR4hiaZxudEz4FJYddj_mO1RAMxiLrMeevPhTQ@mail.gmail.com>
In-Reply-To: <CADnq5_Nx4=-uDR4hiaZxudEz4FJYddj_mO1RAMxiLrMeevPhTQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6f4de41d-433e-4a52-9f2e-e4f4678b704f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-02T03:07:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5158:EE_|PH8PR12MB6818:EE_
x-ms-office365-filtering-correlation-id: 0a1202ad-fb23-4324-07ce-08dc9a446880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mlp1d1hXT3Ayc3VjQitsQkc1b0JDTHZwNnozRllDbXpZb0JLZmt5RzZ3Vldz?=
 =?utf-8?B?Mjd4NHptNWFnb1E1MXJZSTJ0OFNNR0VFRGNuby9nci9BMlpaeTcrdEdHWW1R?=
 =?utf-8?B?bVVrZ2ZZc1BqZGRXbkdURTVsZ25pb3hyNExVRnlGZ1ZTaVY0R2RuUmNxTTVs?=
 =?utf-8?B?NW83RE1hRjYxbzZ4Ykt1NWRUZmJqQ01hTSt5WmRNZ0hEQjcxUzVmVlR0MzdJ?=
 =?utf-8?B?c3R6ZEpnOTVzL1BDYXpUZVM0R1M0bEFFbGNoOFlvQWlLR24yQTQ3cHdBVnF5?=
 =?utf-8?B?RnFMKzVQa29YSXd0T1BVdkFmOW1oVlFPcnA5VnJhd01iT2xpeDBubk9wck8x?=
 =?utf-8?B?Ym1JeGJiRTRoOFVCdi9LMnIxYjl2K0E1djdkZWdKUWo4UkZWd0VZalFxdlpn?=
 =?utf-8?B?Z3ozUFhWaXM5ZUtCUmJqVzBiU1praTBxekVFa2hKZWFkRjNJVFF0RU83Nldl?=
 =?utf-8?B?WFN2RWlXWlNITzhWaFFPaTBMb05PYXhOS1ErMzduS3BXWVIzVU5SWFVhVFFw?=
 =?utf-8?B?NWhsZkJIcm5GdFlXRFdSaWE1Y2FTRHJkaVQrVStyQm9XZTF6SXBtdGpKcVVl?=
 =?utf-8?B?UGwralZ3T3JOUnl4REhmdHZOYklPN0dxZlRBSlc5Y3FDaHZCRjFEZGU5WSt4?=
 =?utf-8?B?K21NTFp0S1lCQUdTMTFFQk44em40KzJhdjNWQWNuMW84L1g1WFY4a29Hc3dW?=
 =?utf-8?B?ZzhSdUF2WnVYRTdHQzZBZDdDQWtIaGxWZHJCRjdpNVFIMi93clNqM0Z5R0Zs?=
 =?utf-8?B?ZXgzU01TeEs2T01yeWdHS0kvNSs3U09ZL1lQQmlJUktIV0ZMdHBXVEk2T3c4?=
 =?utf-8?B?N2YrcmdYb2dubVEyTU8vcGVEc0tjUHN0ZzRYWVVicTk1VTdBVHVCdFhwRUJF?=
 =?utf-8?B?OXgySTRsTFNSN29aQjdIUEh1TjRUSUU1ellrWkU5ZDlyOGhyd1huUCtEV0Rn?=
 =?utf-8?B?VFRVU2t4Q0VYc0crTi9kMjNxeGFLcmNVM0RHbzZ0MGtBRWlnQ2hwMzVreHdM?=
 =?utf-8?B?aElmZG1DT015V2tnMm9xNmxZZGF3b1VBbk1aRk9mU3VWT2FycXFGQTBkWjlH?=
 =?utf-8?B?b2pXajVXRjhENkpJUU1NMXl2S2o0MDA3YTJiWWR1Q3NoblNvZUxQTHN1bFRu?=
 =?utf-8?B?T2k0WDE1RHlQaCt3eUFtM3JsYVNlSEJCUGtSdUo2dXhGbjE0anVKUTJncXow?=
 =?utf-8?B?dWs0czhiNWlCTVY0UU9hcFR5RFREK3RON1o3d2N4ekpNZHV1dVlLaFdUbE0z?=
 =?utf-8?B?azlUZ1JoaE40V1FFWTIxYzFmVnFuNitseVhlRmNBUGdTdkprdWlwTU9JV29w?=
 =?utf-8?B?TElJNU95d1NLMnd4L1F2NHBvelJLZnlEVmVZT1FxM1Zwcm9VaWNJMndCYWo3?=
 =?utf-8?B?ZjNHRXJzZGwzL0VYMDZlVlRTNi9pUWQyT29XbWhTcDZaVkxGemNKQkVRbTRF?=
 =?utf-8?B?elFwT2JFOU45a3k5SFg3akVpbHZqR1Z1K2FVakcwd1RZOFBEb2FCVDhZd0FT?=
 =?utf-8?B?TVpEUVltN01xeFl3ZHlLbUg0OFFKbUNmZVhQVWw1YnFWeGhlbStwTzFSOG1q?=
 =?utf-8?B?a1lmRlU3NVEwclFvS2wxOHFjazB5em1nWjA1OWRUNk92cGUrcnVieE1MS2xB?=
 =?utf-8?B?VUsyYWxtSmdyMmgyQkpqbUNFclBVWU5pcTQzZlRvYWtOS3YzOEpCUTlxQVBF?=
 =?utf-8?B?UitRc2JPYzU1SVcrdzhVL05TWUFFazBrdUszZWpBMG5qZG91c0lLVjZXWmlP?=
 =?utf-8?B?alhBcmJwK20zb3JQZUd4blBRWXVwcUdCYVlaUGgyWEY2MjBSL1h6ekJHWG5I?=
 =?utf-8?B?NjcwWmkrYjBsV1pRYVRzUTRpT0o5VTVvcDZxUXUwakN5d0RpK0FWL3IxYnhC?=
 =?utf-8?B?c3RVZERTZ0gwZnR4dzkzWGs1UFpQQ01Pclhid3lnQzUzMmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVovMDF4dktUSHVrNHZScGlPV3l5MzBkeG1FVS92OUxGVGpnQjBvTlJaelpm?=
 =?utf-8?B?bmIwY01IZEZaYm45WmZEYjNpay9TZnBlSEN1UGhVOXVNV3NOUEhTYWtQaUVu?=
 =?utf-8?B?NGtZblpqTFB3YS9oQ2FVaVJBVFVnc25lRk5RcC9zNHNOUVUzTGNHa2hQc1ht?=
 =?utf-8?B?TFF1T0w2NG9zb1g4MVlLSysxWGFKV3d5YXorb2dkcEk2TmZqMXBMWWJkNmRw?=
 =?utf-8?B?U0lxUU1mS3FHdGs2czJMY3BUejJqYkpLRVRRS1doUnFNQldPODZKSktWY1A2?=
 =?utf-8?B?Q0o4VXpRRHhOaDMrK1g2VmxMaWt1YXA0MHJXSFJEb2JvSU12a3p2SXFUQ3Zv?=
 =?utf-8?B?WU9wL0tqRmV1SlVpdDFqdE9seUp3VkhERHlOTDdKN1J4bmVFWXNyVkJxQ040?=
 =?utf-8?B?emhoOGY3d0x0SlYvVitYUS9mOUhpTGU4NUthaDEvRzh2MDRSVnd2Tlp1OGlt?=
 =?utf-8?B?ejNqS1Z1OUhzWDlic0pNQUw2Z0ltUHdzM0tRMHc5UzFqK3JRYW9sMVpkOEQx?=
 =?utf-8?B?YnNqd0dSNlU5RzdJM1JYSXRYS1NORXBJNHhRTUZJVDBTbTJHVThFZXB3V1p0?=
 =?utf-8?B?NXNNSlNxZ29yWUc5UEh0SFlta3hSc2czZFl0ZWpua2h4djlvenB4U3AyQnlB?=
 =?utf-8?B?dDZqQ0UyczM0SHJPNVZaMHpSbmoyTmpzNzVicytrajU4c0lLbklSZjNwWmRr?=
 =?utf-8?B?TEFaYjRlOGxSN3FBTEhpelBMcGlHWXF1ZnZzZmUvRmxoNkM4TjBzRDRicm5z?=
 =?utf-8?B?M1hOb3lNQis5NzJpYm1WbkdiV3UvUE9PVkF6M1JFa2VmMnA1WjI5QzQ1elFk?=
 =?utf-8?B?cDd1aWdlRGhZSUNoelp1bDdNc1d3SE9MQjlyR05YR3F1T2hXK3RqZHR1Rmpw?=
 =?utf-8?B?Wm12QWlSTFpML2Erbm1nTTR6YWxadm9YZUFVUXhTNkJQL2o5YmZEd285ZFRT?=
 =?utf-8?B?YkJqZncwR05VcnJ3TWJnYXJyd25qbEQvaDlBanBIRHJpU2FKMG1yL2hwMkJq?=
 =?utf-8?B?NVkxZGV2WEJQLzFFUlhEeERvVVdhd1dTR3RIdHNtWWxjTUpYUkRrbXFXcEp1?=
 =?utf-8?B?K0dYUW1pUkxjQ28xeWdkaUxCb2VuaEVuaHpDYi9oNWZnb3h2OTZzem9QbW1R?=
 =?utf-8?B?VEZoRWxmaVpBSXg3czlCdjZWelhMUjNnTS9LZHoyaHpoVnBoSHNFT1hBZXhJ?=
 =?utf-8?B?emEvTStxSlg3Z0NTdmJjd3NwRHZBWmR5WisrRU8zcXQwVHF1OWhQbmpkWWhQ?=
 =?utf-8?B?SUorOTZpYmRRS0JPR25VK0NsWUcwdXN4TUZHNGd4TmNxUzIrRUg3ZW82QmVj?=
 =?utf-8?B?SmJZMWRmeVJVZHNHc0pkZUdMSmRmeTlmbHBMeTJLWVFpNkRtb0ZVTzJiQjZV?=
 =?utf-8?B?ZGxkdHV4d213QVN6eUtRa0ZOZE9jYjRmMzdpa3dMMVhHdDZ4cFBnTGE2bzhz?=
 =?utf-8?B?QkJzZUJON3VIdSszMVdTM3RXN3dyUDZIZFpzRlpmejg5OHgrSncvK0t2OWRr?=
 =?utf-8?B?emcrZngrVkdIcUVRUlpCOEEzNklkbStpV2VDWHFpVEhIcjgxR1kxYWl5RlZI?=
 =?utf-8?B?WHc3UGlSdFNIQVZuZGExcUVUNUJoUVpXY3EwSFpWbTh4UnVtUnVuWkRvMFQr?=
 =?utf-8?B?SUJ3ZHlNUUZ5SFBsSFF2dDNHWmVoYmJaMWxwVDg2Umxjc3JHc0JrTHpZVk9q?=
 =?utf-8?B?R1VDcmFIRXV6eFZjY2Z0MnZCUUVLcFd6MlczOE4xVkVJNWNpZnpxYnVab25U?=
 =?utf-8?B?UUwxWSs0bWRCdnI4M3gvQzZUejFQaHlqeCsyMXhkYVVRSFZjbjN1SVVLWnRa?=
 =?utf-8?B?eFpWMWQ5TU5maUREVWR0NVpXRUdtb0ZoazFqdVRHaHVBeXVFZUVsbDJEQmxX?=
 =?utf-8?B?d0ExZkc2czFSVVcwMHJaeW9VYkdwVlFrcmJIR3RzcXh2bUFwNmxDa3dvNzBm?=
 =?utf-8?B?SUI3T3UrWVB4SFNyUW9TWHczYXpDSDRNdWNmNVY0dzB3bnhIY1BxY0tGRHR3?=
 =?utf-8?B?Wi9PcjF0bENGK3pNdjFpbXkwcWtrbzhjUW5uUEFGVVlUdUgzaEsySTAyWnFq?=
 =?utf-8?B?Z3VUU0xzQm1mQXZzcEZTM3JVVjdjOHVzZldlbTkrSG50cVpiUDBjaHZWWmdo?=
 =?utf-8?Q?nbls=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1202ad-fb23-4324-07ce-08dc9a446880
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 03:09:38.1179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8fo8nlSPjDZrKUgisP3Y2fo+/MKQRFOiwZEN7H0y1jhHZLj8KTkxKG3DfPO83+IB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
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
Cg0KSGkgSmFyb3NsYXYsDQpBcmUgYm90aCBvZiB5b3VyIG1vbml0b3JzIDRLIHJlc29sdXRpb24/
DQpUaGVuIG1vc3QgbGlrZWx5IHRoZSBtZW1vcnkgY2xvY2sgaXMgZXhwZWN0ZWQgdG8gYmUgYm9v
c3RlZC4NClRoYW5rcy4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IEFsZXggRGV1Y2hlcg0KU2VudDogTW9uZGF5LCBKdWx5IDEsIDIwMjQgMTE6MDcgUE0NClRvOiBK
YXJvc2xhdiBQdWxjaGFydCA8amFyb3NsYXYucHVsY2hhcnRAZ21haWwuY29tPg0KQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogSGlnaCBQb3dlciBDb25zdW1w
dGlvbiBvZiBBTUQgUlg2ODAweHQgaW4gSWRsZSB3aXRoIFNlY29uZGFyeSBNb25pdG9yIENvbm5l
Y3RlZA0KDQpDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFs
IFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xp
Y2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQoNCg0KT24gTW9uLCBKdWwgMSwgMjAyNCBhdCAz
OjI14oCvQU0gSmFyb3NsYXYgUHVsY2hhcnQgPGphcm9zbGF2LnB1bGNoYXJ0QGdtYWlsLmNvbT4g
d3JvdGU6DQo+DQo+IERlYXIgQU1EIEdQVSBLZXJuZWwgTWFpbnRhaW5lcnMsDQo+DQo+IEkgYW0g
d3JpdGluZyB0byByZXBvcnQgYW4gaXNzdWUgd2l0aCBoaWdoIHBvd2VyIGNvbnN1bXB0aW9uIG9m
IG15IEFNRA0KPiBSWDY4MDB4dCBncmFwaGljcyBjYXJkIHdoZW4gYSBzZWNvbmRhcnkgbW9uaXRv
ciBpcyBjb25uZWN0ZWQuDQo+DQo+IFVwb24gaW52ZXN0aWdhdGlvbiwgSSBvYnNlcnZlZCB0aGF0
IG15IGRlc2t0b3AgY29tcHV0ZXIgZ2VuZXJhdGVzIG1vcmUNCj4gaGVhdCB3aGlsZSBpZGxpbmcu
IEkgZGV0ZXJtaW5lZCB0aGF0IHRoZSBoaWdoIHBvd2VyIGNvbnN1bXB0aW9uIGlzc3VlDQo+IGFy
aXNlcyB3aGVuIEkgY29ubmVjdCBhIHNlY29uZGFyeSBtb25pdG9yIHRvIG15IEFNRCBSWDY4MDB4
dCBjYXJkLA0KPiBjYXVzaW5nIGl0IHRvIGNvbnN1bWUgYXBwcm94aW1hdGVseSA0MFcgb2YgcG93
ZXIgaW4gaWRsZSBzdGF0ZSAuDQo+DQo+IEkgY2hlY2tlZCB0aGUgIkdGWCBDbG9ja3MgYW5kIFBv
d2VyOiIgaW4NCj4gL3N5cy9rZXJuZWwvZGVidWcvZHJpLzEvYW1kZ3B1X3BtX2luZm8gb2YgbXkg
Ulg2ODAweHQgZHVyaW5nIGlkbGUsIGFuZA0KPiBoZXJlIGFyZSB0aGUgZmluZGluZ3M6DQo+DQo+
IFdpdGggdGhlIHNlY29uZGFyeSBtb25pdG9yIGNvbm5lY3RlZCBtZW1vcnkgZnJlcXVlbmN5IGlz
IHVwIGFuZA0KPiBjb25zdGFudGx5IGF0IDEwMDBNSHo6DQo+ICAgICAgICAgMTAwMCBNSHogKE1D
TEspDQo+ICAgICAgICAgMyBNSHogKFNDTEspDQo+ICAgICAgICAgMTgyNSBNSHogKFBTVEFURV9T
Q0xLKQ0KPiAgICAgICAgIDEwMDAgTUh6IChQU1RBVEVfTUNMSykNCj4gICAgICAgICA4NTYgbVYg
KFZEREdGWCkNCj4gICAgICAgICA0NS4wMCBXIChhdmVyYWdlIFNvQykNCj4NCj4gU2luZ2xlIG1v
bml0b3IgY29ubmVjdGVkOg0KPiAgICAgICAgIDk2IE1IeiAoTUNMSykNCj4gICAgICAgICAwIE1I
eiAoU0NMSykNCj4gICAgICAgICAxODI1IE1IeiAoUFNUQVRFX1NDTEspDQo+ICAgICAgICAgMTAw
MCBNSHogKFBTVEFURV9NQ0xLKQ0KPiAgICAgICAgIDYgbVYgKFZEREdGWCkNCj4gICAgICAgICA4
LjAwIFcgKGF2ZXJhZ2UgU29DKQ0KPg0KPiBUaGUgc2lnbmlmaWNhbnQgZGlmZmVyZW5jZSBpbiBw
b3dlciBjb25zdW1wdGlvbiBiZXR3ZWVuIHRoZSB0d28gc3RhdGVzDQo+IGluZGljYXRlcyBhIHBv
dGVudGlhbCBpc3N1ZSBpbiBwb3dlciBtYW5hZ2VtZW50IHRoYXQgbmVlZHMgdG8gYmUNCj4gYWRk
cmVzc2VkLiBZb3VyIGFzc2lzdGFuY2UgaW4gcmVzb2x2aW5nIHRoaXMgbWF0dGVyIHdvdWxkIGJl
IGdyZWF0bHkNCj4gYXBwcmVjaWF0ZWQuDQoNCkl0IGRlcGVuZHMgb24gdGhlIHRpbWluZyBvZiB0
aGUgbW9uaXRvcnMuICBUaGUgbWVtb3J5IHJlY2xvY2tpbmcgY2FuIG9ubHkgb2NjdXIgZHVyaW5n
IGJsYW5raW5nIHBlcmlvZHMgb24gdGhlIG1vbml0b3JzLiAgSWYgdGhlIHJlY2xvY2tpbmcgaXMg
ZG9uZSBvdXRzaWRlIG9mIHRoZSBibGFua2luZyBwZXJpb2RzLCB5b3Ugd2lsbCBzZWUgZmxpY2tl
cmluZyBvciBhcnRpZmFjdHMgb24gdGhlIGRpc3BsYXkgd2hlbiBpdCBoYXBwZW5zLiAgSWYgdGhl
IGJsYW5raW5nIHBlcmlvZHMgYXJlIHRvbyBzaG9ydCB0aGUgZHJpdmVyIGNhbiBvbmx5IGRvd25j
bG9jayBtZW1vcnkgd2hlbiB0aGUgZGlzcGxheXMgYXJlIG9mZi4gIEFkZGluZyBtb3JlIG1vbml0
b3JzIG1ha2VzIHRoaXMgaGFyZGVyIGFzIHlvdSBoYXZlIHRvIHRha2UgaW50byBhY2NvdW50IHRo
ZSBibGFua2luZyBwZXJpb2RzIG9uIGFsbCBtb25pdG9ycy4gIFlvdSBjYW4gdHJ5IGFkanVzdGlu
ZyB0aGUgbW9kZWxpbmVzIHVzZWQgb24gZWFjaCBkaXNwbGF5IHRvIGluY3JlYXNlIHRoZSBibGFu
a2luZyBwZXJpb2RzLg0KDQpBbGV4DQo=
