Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64AACAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 20:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1855510E158;
	Wed,  8 Oct 2025 20:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oDKHR2r3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7F710E158
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 20:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oqu4gSavSN1NV5o8BxOywTobZe3pAbUJ74GGgDFqCJdxYv+gpQLSAEv46GpTP5rMlCcx+UVb8vzuCqJHjFwpAgdAmA/OCsZ+GoxdQdxWd4wx8vXJpiszlVt+JKntDrCjcWjdg74xy42dEfS/AkeYVwCFEylCb0442LtGLo4biyFdmlEg2Q3cUiF42lDXf8vQGHVRZIVJ9sGPV1wpVR6KNGY9/F0GHnQFGo/oYUfwh+PdrjiRSkICNIcRIP4xwtURBU8rAnvKy1mAvBGBt7fWPlYEv1buoyalLqCEDqBO/ABYfFpu3Eg2+UK5znZqf92L6CBZRUABQZe01NkD0Wxk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKnQtUU0vNaQOGP9qoDUHk27p61Z7BvZso72HlXjGnU=;
 b=i3VExjlNxJ70CuSQIqZAIWP4ABBk4Qd3aKLo0iFPANbppfYrgy17lLxUbpASeYHvSgIsMx+Kv82xcNlGo2h5R6lTMdQNfIf4KR+cl7z7Hmme0gccoczgjselqI+L3TrxkkABuGz9o0u0rB+RMfunUrfgkiHlm7L2fujndX1Xo5fF84gj2UeCIAS6ea1591PvcQos9iaOYUi5VStztcqNZ/mXSrgbkOiamx3cDcnf2yh0Yjsk/lhWzlIJ1cZK+qQ8BX8wAaGuVOjoUnBldlDWiG2xmE0nttdxr/7p6AiY+vPZqCWH30+BkoHBtufc3pQ2vqW4V9rzTGXa/4dHozwApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKnQtUU0vNaQOGP9qoDUHk27p61Z7BvZso72HlXjGnU=;
 b=oDKHR2r3huLVWq2GTZvcLMLSv/gJBpRu6cMM512Yh6mHwpXAvrVlRtFekQ18Ck/Ypug27HPBdrpSOs+IXjQXB65RIsH2PklxslSzwMEl5kx9BeZE4ggFkvINhgMWiYBq9viwHH5TbknWDg9axdmm0zjp7F4imA1ZXN5KVFwv2Jk=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 20:11:58 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 20:11:58 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
Thread-Topic: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
Thread-Index: AQHcOHLJRL0QRFecdkyxa3OjtALBLLS4fGsAgAACRdCAAAccAIAAKFcA
Date: Wed, 8 Oct 2025 20:11:57 +0000
Message-ID: <CY8PR12MB74358D5E7438A3FF6F7C873185E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20251008164408.850834-1-jonathan.kim@amd.com>
 <CADnq5_M_Rk9KX_5Vw+3pxPfrReKqhtF5rn+1P2LidFSJ5y7Wzw@mail.gmail.com>
 <CY8PR12MB74354BE47029963B8FEDCD4385E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CADnq5_PLCEEVbk4ufSnQyqzmW32iBccpk5EXf7kPwdp5=Lpo-Q@mail.gmail.com>
In-Reply-To: <CADnq5_PLCEEVbk4ufSnQyqzmW32iBccpk5EXf7kPwdp5=Lpo-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-08T20:10:16.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MN0PR12MB6317:EE_
x-ms-office365-filtering-correlation-id: bce35b9d-488f-4a3f-a3c0-08de06a6ef6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bHd5UkYvZzJLRVhXdjBYTVdqNFBkQTlPdDYxMEN3UVRja0k0b3lFdTVOQjl3?=
 =?utf-8?B?czNxUGs0ZERudlNzNmpUa00yVlB1MktpNTV1MDJDZHR6OENiTVFSM0Z3QThq?=
 =?utf-8?B?enl0N2pKcmhYUFhQS2tWQ3Zjd1FUWktrZDI3eStUOE04Qi9nVTRxalZ0MDVW?=
 =?utf-8?B?UTZSWkFXVHEzUU5Qb2RYV3EwekhIam1IQXUvcTRQMEtmdFBjUHdyVUx2Zzkv?=
 =?utf-8?B?K2poVzhJcjcyMVB3QWRMRTlzQVVaa2NxREhyTitxNmcrSjZmZklSemFQQTVu?=
 =?utf-8?B?c1BqK25WdXV5THpjVU41VDQyNVhPd0tiQVgxLzJwaEtEVng5VThySXBOaWlx?=
 =?utf-8?B?RGxqU0oyYmFlemVCdUtXYlR1dGNSaDI4SmRORWlsRGtBK3g1Zzl1aEFDSGJt?=
 =?utf-8?B?dmh4U2o4cS9acThSaUk0SWhNV2xZZmJpbmFZUjN5d2E2dUlVOVRzbUtXTmZQ?=
 =?utf-8?B?emU1c2ZqYnEzaWsyTjlMSGl5N2xQZEU1elp3N1lqbVJSMkxvbFAzMmgzcDV0?=
 =?utf-8?B?RGNNTkUxSnJyUkdNaTVWT3ZudS9OeWJKeDE2T0NVMkdmUXFIN3YxUXhMSFgx?=
 =?utf-8?B?RXhNOUpXc0c4a0t1QmpJb28xRTkrbWtLMWplSitGWkMzb1ZPMFFQaDJXdml0?=
 =?utf-8?B?Tm9WeEtxUjRKWXpSRXcvVEdkaHlyM20welRlSXV5QlZDb1ZGbFNBRWdhZXg5?=
 =?utf-8?B?aEJyVG1vR0RETE5TMTBPT3ZUSWx2MWhRTkJZYjNZcnE2a0JZa2Nxam1BSlg3?=
 =?utf-8?B?RmJWZTJNc29PbHU5cmVLdUxGNXZCcnl5a0RDZWtkelFEYkZhUFFudFhDb0s5?=
 =?utf-8?B?SUdLejUrc2JMUHZ2OGpNcEZ2K2dsQ2pkOUF0eGZtTWdPRjRrVnIyUXZhUVBp?=
 =?utf-8?B?UVVUejk3OCtPRUlXN0pzNU9ucXdIR1VrcW0xQ2loN1RDSTRrS0ZsSForN0hO?=
 =?utf-8?B?QmpjSytubHBta2lQZzY5ZW4xaXhNUFlXb2g2WFFLQVRaUlM0dGl5anZIdU9a?=
 =?utf-8?B?aU10OWRqZkJ5c3lUakRWVDFad2xUOEdTTDhSSS9hNWpvYjJCZ1lPSmd6MXRh?=
 =?utf-8?B?UlNKY0pQeS8yYTVUOVpIMkQ2VEdDSnhkbURhdFZhK3hWNkNOZGhoMGQvTzE1?=
 =?utf-8?B?dmJubkYyMVB3bXF2amlOODd2TjdaSHNabUVVaGJZNGdxeitmMGRvdW5DM214?=
 =?utf-8?B?TXU0L1Azc1JvWmdlaXRkRU4zc0I2c2Y2cXREcEpsTFd6akxwTUFtMUFSY3Bl?=
 =?utf-8?B?YUtlZVhFSVN1Uk42YUhOaUVzMjZDY1laeXVidWtIWnFMbEgydVlIUHAvbHBZ?=
 =?utf-8?B?enpXSit6VDVPVENwbFdqa295Snp6WFE1U2d4ZDhjMUVWRXBBL3lTZ0htcDB6?=
 =?utf-8?B?UU1KZkhiMGJobmVXeW40SE0wVmdjaU8ySXdxMWdYZzdPTHV0ZTU1OHhpd3cy?=
 =?utf-8?B?RVB0L1BkMlZMckhXWDRQeUhyelRncWNMa05LRjZVQWNwSFk0dm9EVFNTRFlD?=
 =?utf-8?B?QzFEMHhCWHd4MzZsY3l2VE5tUlA1b3NuSnVyTUNMMjlDNktkVWRXZ0xybUtt?=
 =?utf-8?B?clVUV0xPZ1M5b3hGWThrWWRDbXJ0OW41eGNzWmNzcGRyeDBBUW1rZTFLa2ZZ?=
 =?utf-8?B?NTZNZ3dTaldzaUYvSHFxblp5ay9GN2w0cG9pZ0JpcFIwYjhKdDJGSk1CbFMw?=
 =?utf-8?B?cjA5d3F4Mlg2aWFuSmRoOXljNlQxaXFYQjRKcW43OFM5SXhHcGw1ZXlaRXJL?=
 =?utf-8?B?M2JoMlBqZkZHVkNnT0w4ZE93RkxNRjhjbGtOd1hFQ3VpakM1ck16TmRuY1c3?=
 =?utf-8?B?ZmVPOUJSNGF2RFdYTDlhQTZuM2hYZm5oOGhDNk1OempBN2J3RTdBRWlSY28z?=
 =?utf-8?B?KzVMQUM2cytiRExqR3RqMk1nbXdzZHJtd3lBeTE2aUtQa2dUdnFTL2dRNXpO?=
 =?utf-8?B?WUFHTzVqd1VMeWVSRFNFRzFCaXhoVVZ0M0FTQ3p5bVdIK04zUlZzczBCRzBW?=
 =?utf-8?B?cWUyWE5vbmYyclBKNEoxUzlkUHJxVDUzNUpFdnhSb1R4cDVEQS9YSGJ6Ymc5?=
 =?utf-8?Q?ErYDdh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXEwKzEyM1kzdWZSWDRQcGtac25Ha0NIN2sxOW9RT3pZd3dieWF2c2VTZnhG?=
 =?utf-8?B?bFc2ZVhBTHFuTmUvaEVFRVQ1ZmREUkJja0VpdUovcjdObDNvKzJwd3d5Wjdj?=
 =?utf-8?B?U3RTYk1ocDduN0xYZG54b0dpaXRQaEhMNHFWRVJwbWZXWUY5ZGFhQTlZcTFL?=
 =?utf-8?B?d25COVVFUElndng2UEFxV1JpUmRXVTVjRkQ3dkNCYVBWSmd0cXFiK1RURXFL?=
 =?utf-8?B?RFlGc3cxKy9NZldHMk8zYk45OUJ1czhmYmRiVllQeWhRd3o0WG1NcFV5dzRx?=
 =?utf-8?B?dndjd3RkZFprNVlNZGFWVUxIMnhWOXYrRjdPRDdxell1V05qZyswM21MSzBl?=
 =?utf-8?B?OHh4NmRzaUFTdURaUEJBcWcvVXptcGFaa2dtRXUray95U1ZKVWhDQU9RWkc4?=
 =?utf-8?B?dmNWbkRlVm1zNUloY0JCc0JLd0xvbWJVQ3FKSlhoZnRPRUdsYnFNL01hZHZN?=
 =?utf-8?B?eUE0RzhxNWhPYW9ub2ZXYkRRc29SNVdMM21MWFhNajBRdTFWUm13RjZhdzJr?=
 =?utf-8?B?YkRISC9IVlF3ZE9ubnNHKytVZGlKWS9tU3YybnJVSUZ5Um5jK0tHRW9YdDRG?=
 =?utf-8?B?aTdvMDNSeUtHMjRkYllVOWpnUHUyRnZSWGFKa3U3bTgxdGZEemVTb1ZZMklt?=
 =?utf-8?B?OHFjRitPbjlyWEtSanBWOFJvY2R1a1lTRHRmYkJsUW0yUTltUFRWWkZGN0ox?=
 =?utf-8?B?THJuU1B6ZHRpTzhJZzgreHNzSTFxNFdKK3FLVFkyTmZXL280Nnd0ZkxVMU1P?=
 =?utf-8?B?Y0dTc2tlTTR6UmtRTm5TYzVXN1AyL3FFbGZZdHRnT05jWDZLUFhucyt4UmVh?=
 =?utf-8?B?R3ArZnVka1FRMEpQWnVvdUJhckowTWVkKytGV3pQUXljZW13UU5hSUN0K0JG?=
 =?utf-8?B?dnVRTTFJNXJGRnp4L0VMRmNTcXJ5MTRrVTlzall0b0FOYVRvb01FdXlGeHEv?=
 =?utf-8?B?YThtWUQ4Mk1McldVL24xT3hIa01iRHdqYlFsb3k1VWlIREFVWFpxNGx5aEJQ?=
 =?utf-8?B?QlY5alR6UjJnMkVwcDNNMkFkVTBBNDZ6OHlld1I3OXZpeWVvVmdpZzAySE1K?=
 =?utf-8?B?ekZIR0ZjRjhsN3ZmUlZNWHJlYTlTemdibDU5MDJhNjFTckZYV3RDU3lnY1BL?=
 =?utf-8?B?bXlQQVRpRFBxZWxjYVp3YWQ0YUVnUjZPRFZBeGE5U21xUG1VSXdQcloyYmpq?=
 =?utf-8?B?QzE1UnNYV2lTa0VON2VOcXB4MkF5QnpqY2NucGdUeUQ2VGRUUlhCZVNzTjJ5?=
 =?utf-8?B?WFBJWk5UZFlrSDJWRzEvQm9MYi9QQ3hWdFNvOXpqcFB2SEtITlJBN2VjQXkw?=
 =?utf-8?B?N3E3Z2dkU3AwT1NuN1VIbldZaVhVeWNjMnhFcHFQSjBnVjNOYmJsWXhmYW5V?=
 =?utf-8?B?TVQ2TUVMbW8vdG05OHNuc0tlQWVaZHdxdDNFUFY1NW4rcTFCTzQvckpRemF0?=
 =?utf-8?B?TEVFbTh0R2Y5cnFacUdKU2dvdnJKUUExNG9RQ1VQR2hKNlVsT01WVkhnMzhM?=
 =?utf-8?B?TUdoVjRoQVptdk5RQnpLMTBQV0I5cHZ4d2tuci9Gb0VBdW90L1NuL1AwbGZX?=
 =?utf-8?B?Ym80eXI5UzZxUUdIZkY2VGtBdkNYT2NsRGNESXZIZHlNTFFZQWFEd1ZCamNz?=
 =?utf-8?B?N053ODYva1RraWFkbVlJRG5odEtjTUEwck42dzA3cStjdC8wNFBFYXlJUjd2?=
 =?utf-8?B?ZWtMMUFsOXRMQXlKb1ZBUkNFdUQyOFJlOEJ5LzNoWnFSc09zUGQ5b051bUQ5?=
 =?utf-8?B?dk5jZFJVQStYWWQwZnk5QjdCR2FjK0VRL2FrY2hiYzZ0Wnpab0p4NmhicXRG?=
 =?utf-8?B?ZWdEbHA1RUpqM0lRc2w0RkNNZ3hTY2ZNbnAyYVZaYk4vS25UM25ieUxuMi9a?=
 =?utf-8?B?NldCM091b3dlWXNJV2UwdmlTWkF2TEJXZWxNU0pybjl3QWVtN0ZpeWp4SFZ5?=
 =?utf-8?B?ZFhINkJKVEFmbHR6M0NtNDRUQ0NDT0JQTldPZUVHL0l6cWhwMHBXYWdJMzVz?=
 =?utf-8?B?Z1dLcWxTTG1GM3dtSGdWZ3hPMW5pdVFYU2RxTXhsV0RSMHVqN0RBbXpZS1pB?=
 =?utf-8?B?RW0yZjFmYyswZGR4UUdNMTJCSEZ0VTdSM1FuQUNtNzJpenhkcUhBUEtkeDJz?=
 =?utf-8?B?UWVMT0xZRlc1T2JmNWRKNEN6Q0Z0UWFEZFp5Si8wRDRRdXRLZEt0azBSbmZZ?=
 =?utf-8?Q?/3m7gT+aKvjoEOXwPYhL51w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce35b9d-488f-4a3f-a3c0-08de06a6ef6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 20:11:58.4067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wG0l3m1uXv1zQHLTeyw3dpu0VQLJuZQXxBlEJ0I6XQrOQyMqxILp6OH++7RO2r/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDgsIDIwMjUgMTo0NiBQTQ0KPiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5j
b20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTGl1LCBTaGFveXVuIDxT
aGFveXVuLkxpdUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBm
aXggZ2Z4MTIgbWVzIHBhY2tldCBzdWJtaXNzaW9uIHN0YXR1cyBjaGVjaw0KPg0KPiBPbiBXZWQs
IE9jdCA4LCAyMDI1IGF0IDE6MjfigK9QTSBLaW0sIEpvbmF0aGFuIDxKb25hdGhhbi5LaW1AYW1k
LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBbUHVibGljXQ0KPiA+DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBn
bWFpbC5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgOCwgMjAyNSAxOjEyIFBN
DQo+ID4gPiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+DQo+ID4gPiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExpdSwgU2hhb3l1biA8U2hhb3l1bi5M
aXVAYW1kLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBn
ZngxMiBtZXMgcGFja2V0IHN1Ym1pc3Npb24gc3RhdHVzDQo+IGNoZWNrDQo+ID4gPg0KPiA+ID4g
T24gV2VkLCBPY3QgOCwgMjAyNSBhdCAxMjo1MeKAr1BNIEpvbmF0aGFuIEtpbSA8am9uYXRoYW4u
a2ltQGFtZC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gVGhlIGRyaXZlciBj
dXJyZW50bHkgb25seSBjaGVja3MgdGhhdCB0aGUgTUVTIHBhY2tldCBzdWJtaXNzaW9uIGZlbmNl
DQo+ID4gPiA+IGRpZCBub3QgdGltZW91dCBidXQgZG9lcyBub3QgYWN0dWFsbHkgY2hlY2sgaWYg
dGhlIGZlbmNlIHJldHVybiBzdGF0dXMNCj4gPiA+ID4gbWF0Y2hlcyB0aGUgZXhwZWN0ZWQgY29t
cGxldGlvbiB2YWx1ZSBpdCBwYXNzZWQgdG8gTUVTIHByaW9yIHRvDQo+ID4gPiA+IHN1Ym1pc3Np
b24uDQo+ID4gPiA+DQo+ID4gPiA+IEZvciBleGFtcGxlLCB0aGlzIGNhbiByZXN1bHQgaW4gUkVN
T1ZFX1FVRVVFIHJlcXVlc3RzIHJldHVybmluZyBzdWNjZXNzDQo+ID4gPiA+IHRvIHRoZSBkcml2
ZXIgd2hlbiB0aGUgcXVldWUgYWN0dWFsbHkgZmFpbGVkIHRvIHByZWVtcHQuDQo+ID4gPiA+DQo+
ID4gPiA+IEZpeCB0aGlzIGJ5IGhhdmluZyB0aGUgZHJpdmVyIGFjdHVhbGx5IGNvbXBhcmUgdGhl
IGNvbXBsZXRpb24gc3RhdHVzDQo+ID4gPiA+IHZhbHVlIHRvIHRoZSBleHBlY3RlZCBzdWNjZXNz
IHZhbHVlLg0KPiA+ID4NCj4gPiA+IFRoaXMgc2hvdWxkIGJlIGNvcnJlY3QgYXMgaXM6DQo+ID4g
Pg0KPiA+ID4gKnN0YXR1c19wdHIgPSAwOw0KPiA+DQo+ID4gVGhhdCdzIG5vdCB3aGF0IEknbSBv
YnNlcnZpbmcgYXQgdGhlIG1vbWVudC4NCj4gPiBhbWRncHVfZmVuY2Vfd2FpdF9wb2xsaW5nIGNh
biBzdGlsbCByZXR1cm4gZmluZSB3aGVyZSBzdGF0dXNfcHRyICE9IDAgbm9yIDEuDQo+ID4gRnJv
bSB3aGF0IEkndmUgYmVlbiB0b2xkLCBvbmx5IDB4MSA9PSBzdWNjZXNzICh0aGUgY29tcGxldGlv
biBmZW5jZSB2YWx1ZQ0KPiBwYXNzZWQgdG8gTUVTKS4NCj4gPiBTaGFveXVuIGNhbiBwcm9iYWJs
eSBlbGFib3JhdGUgb3IgY29ycmVjdCBtZSBpZiBJJ20gd3JvbmcuDQo+ID4gSXQncyBwcmV0dHkg
ZWFzeSBmb3IgbWUgdG8gcHV0IHRoZSBIVyBpbiBhIGJhZCBzdGF0ZSAoZGFuZ2xpbmcgcXVldWVz
IHBvc3QNCj4gcmVtb3ZlKSB3aXRob3V0IHRoZSBkcml2ZXIga25vd2luZyBpbiBpdHMgY3VycmVu
dCBzdGF0ZS4NCj4NCj4gMSBpcyBqdXN0IHdoYXQgdGhlIGRyaXZlciBwdXRzIGFzIHRoZSBmZW5j
ZSB2YWx1ZSB0byB3cml0ZToNCj4gYXBpX3N0YXR1cy0+YXBpX2NvbXBsZXRpb25fZmVuY2VfdmFs
dWUgPSAxOw0KPiBhbmQgdGhlIG1lbW9yeSBsb2NhdGlvbiBpcyBpbml0aWFsaXplZCB0byAwOg0K
PiAqc3RhdHVzX3B0ciA9IDA7DQo+IFRoZSBmaXJtd2FyZSBzaG91bGQgZWl0aGVyIHdyaXRlIDEg
b3Igbm90aGluZywgd3JpdGluZyBhIHJhbmRvbSB2YWx1ZQ0KPiBpbiB0aGVyZSBsb29rcyBsaWtl
IG1lbW9yeSBjb3JydXB0aW9uIG9yIGEgZmlybXdhcmUgYnVnLiAgSWYgaXQNCj4gZG9lc24ndCB3
cml0ZSB0aGUgZmVuY2UsIHRoZSBkcml2ZXIgY2FuIGFzc3VtZSB0aGUgb3BlcmF0aW9uIGZhaWxl
ZC4NCj4gSWYgaXQgd3JpdGVzIHJhbmRvbSB2YWx1ZXMsIHRoZW4gd2UgaGF2ZSBubyBpZGVhIHdo
YXQncyBnb2luZyBvbi4NCg0KRlcgd3JpdGVzIGhpZ2ggMzIgYml0cyB0byBzdGF0dXNfcHRyIGZv
ciBkZWJ1ZyBjb2RlcyBpZiBsb3cgYml0cyBpcyAwLg0KU28gd2Ugc2hvdWxkIHByb2JhYmx5IG9u
bHkgY2hlY2sgdGhlIDMyIGxvd2VyIGJpdHMgdGhlbi4NCg0KSm9uDQoNCj4NCj4gQWxleA0KPg0K
PiA+DQo+ID4gSm9uDQo+ID4NCj4gPiA+IC4uLg0KPiA+ID4gYXBpX3N0YXR1cy0+YXBpX2NvbXBs
ZXRpb25fZmVuY2VfdmFsdWUgPSAxOw0KPiA+ID4gLi4uDQo+ID4gPiBpZiAociA8IDEgfHwgISpz
dGF0dXNfcHRyKSB7DQo+ID4gPg0KPiA+ID4gQWxleA0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1kLmNvbT4NCj4gPiA+
ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYyB8
IDMgKy0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRp
b25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9tZXNfdjEyXzAuYw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9t
ZXNfdjEyXzAuYw0KPiA+ID4gPiBpbmRleCBhZmYwNmYwNmFlZWUuLjU4ZjYxMTcwY2Y4NSAxMDA2
NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8wLmMN
Cj4gPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8wLmMNCj4g
PiA+ID4gQEAgLTIyOCw4ICsyMjgsNyBAQCBzdGF0aWMgaW50DQo+ID4gPiBtZXNfdjEyXzBfc3Vi
bWl0X3BrdF9hbmRfcG9sbF9jb21wbGV0aW9uKHN0cnVjdCBhbWRncHVfbWVzICptZXMsDQo+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHBpcGUsIHhfcGt0LT5oZWFkZXIub3Bjb2RlKTsN
Cj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICByID0gYW1kZ3B1X2ZlbmNlX3dhaXRfcG9sbGluZyhy
aW5nLCBzZXEsIHRpbWVvdXQpOw0KPiA+ID4gPiAtICAgICAgIGlmIChyIDwgMSB8fCAhKnN0YXR1
c19wdHIpIHsNCj4gPiA+ID4gLQ0KPiA+ID4gPiArICAgICAgIGlmIChyIDwgMSB8fCAqc3RhdHVz
X3B0ciAhPSBhcGlfc3RhdHVzLT5hcGlfY29tcGxldGlvbl9mZW5jZV92YWx1ZSkgew0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgaWYgKG1pc2Nfb3Bfc3RyKQ0KPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgIk1FUyglZCkgZmFpbGVkIHRvIHJlc3BvbmQg
dG8gbXNnPSVzDQo+ID4gPiAoJXMpXG4iLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHBpcGUsIG9wX3N0ciwgbWlzY19vcF9zdHIpOw0KPiA+ID4gPiAtLQ0KPiA+ID4g
PiAyLjM0LjENCj4gPiA+ID4NCg==
