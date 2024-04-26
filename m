Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658C1C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 00:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012AE11A3E3;
	Fri, 26 Apr 2024 00:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R1aHZaKn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF27911A3E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 00:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3CBWFecC90MZadbkZDfLLki4xMx9ZrRVHSxLPdHV2scbutSdWfdlizw1oVgkkOZlhyLvp1p9zzPrjnGmNSNNrw/Gb3DUT5mX2QKQ/M7iqP4MKgG28Gt5W8PDQA0ed9Z9aEFre3/WAJBCQltxaesFtuMne2NOyGwacgI9s4ypBDzN0hkWsr7ZhxCPz5uxHeQYnTixeMrswCLInUC+T8CDIKTRYzca0mtItIFaVsNL7CxNECeqj+DOUPK9XwjtTlUJLwPJb7eKNd80sOp/3VKsnJr2QmCJY4aVnK8GFSITV6EDEiLlfYRfeIEyB1EP56pdrMYrepTGnGC3kWy8Eg0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7jP8nJNr8HenkDZBKRBqK6yxpUizykOj+TYf+5nj/0=;
 b=hb4eeRryyaDK6LysCm7wkmHmxlq8V2W1bBMsQoj1M/9BpMThh2vdEroj4scD/VtJyu1fhCr49rDaJ1aWWNE58CqJzv/YQH5pY7ksZZrVlS79nfz2aRpQmY2vIJ/ENgG3IcqLGg4SSjQMWEwrWMN6m6Hn+YKeTWSA7fK7bO2oF8/4WD53U7JXfT7Rmmu154s58VDY+I00EudQ+UgoAw/G2SrKAtZYCqY2OJzL62PR8NhU2AprbiAd1z84Py5ih62QZwW4b919IwIWFry+vhN4sYUuWNtRqQOSUEqLQmFbTyPkqfyhrJW8UwlfHeEpZc0BLhDWyNxdvhBU5KIEZ3bb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7jP8nJNr8HenkDZBKRBqK6yxpUizykOj+TYf+5nj/0=;
 b=R1aHZaKnNavVK7zekkrzG/sAaqNG5xBlVqMy96ZR0FVJbC6clZYicfdaUGBd1QtxYea8D4pB02lFP7x0Nc4MefJfzpG5mE2RjtfQ8XndER5cUC8OlGE3Q7i6fq+9HnPN2yKtYoO1Or8018903m+MVUyaKzzWqUZA7p/T5mO0CbU=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 00:04:50 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%6]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 00:04:50 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: fix overflowed array index read warning
Thread-Topic: [PATCH v2] drm/amdgpu: fix overflowed array index read warning
Thread-Index: AQHalt6ou4IreswDFECIMAasoJiQibF4+xIAgAAAu4CAALBBwA==
Date: Fri, 26 Apr 2024 00:04:49 +0000
Message-ID: <CH3PR12MB80744FD054646A93D2E49FF3F6162@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240425070226.1315866-1-tim.huang@amd.com>
 <CADnq5_MY_dT=OMffMO8wXuiTUdnMYA1r2W7R-+HDXNeODMoibA@mail.gmail.com>
 <b06a0402-8ee4-4b6b-b9e8-1b45a957d143@amd.com>
In-Reply-To: <b06a0402-8ee4-4b6b-b9e8-1b45a957d143@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ba845d07-b701-4405-95fe-03274882b31c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-26T00:01:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DS7PR12MB5815:EE_
x-ms-office365-filtering-correlation-id: b2b926df-4c3a-4059-f02d-08dc65847db7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Mzhpazh1WlR2ODhJM1loSndaOHBtK3YxK0pvdllEUWRWZStCVVAxeTVPYTlv?=
 =?utf-8?B?OW0xMTEwTjNqbnMvdERvczA0QUhaMEdOY1ZZd0dHbHRPWjNZNUIwdi8zTGMv?=
 =?utf-8?B?V1h1SlM3Q1FZVDBIejgxOGpBTnl6NlNDcENIMW1Nc0wyRXNOL0xnV0pvNE5w?=
 =?utf-8?B?QXRSbkZWaE5MRUdGaGpGTzRFM0hMelBLQ2FxV213aFhQTE9RcGYvdzZZcnlt?=
 =?utf-8?B?YjBXVyt5aFE2WnZwekM3Z09PeGtxOXpwVXd1eVM2YVZrZDRJSmtWeVZvR0pG?=
 =?utf-8?B?bGdSR3U5M2RJaHU5UUdmV01Ka1hpeVV6UkdUWjFpTG1iNjdoWExVTEt0WXZV?=
 =?utf-8?B?RjdidDdYMG16TVZDQXVEa0pXR2VsTFRCejIzZS8rRUJwN3RQQWpqSUFEMzI5?=
 =?utf-8?B?OVNqQ2FkUTkrWmlwS3pGYnVwbE8wYzhjTENPa21lSGQ3U1JlSjk2RmJLMVhz?=
 =?utf-8?B?TmJBbU9uOXFoU2crSUVEZEF5azlZdjEyWWpaWFRaVDNCcFZBR3MrbHdBVnhs?=
 =?utf-8?B?Z3ZVYXA4RmpsaDExRFNTOTBwb3c1bFRxQTNRM2tSdk9KUmw1ZG40eTN3TStU?=
 =?utf-8?B?TTBySWhrYWpYSjJNS1JkeE04akJNcmU2SlZpWjhmRFplWFg3b01lUHhqTEUy?=
 =?utf-8?B?NUFJeEkzOCtpQ25kT08vQzVCbG1zT1BObDhSeE12QTh0enNVc2xSRldXMUVH?=
 =?utf-8?B?Y0dxS0EwS1dwMzRhbnh4dkhHbGtHYmN6U25heHVjWWx0c3JuTVlna2FDaTJQ?=
 =?utf-8?B?QWdRNjdCdElhOTFtTGVTb3FjMGVVUTNIVm82Y0hRRFoweUhvUEM1WnRVTDNC?=
 =?utf-8?B?dk5FSGdqa1dNcm1HcEtkU3c4cXBEOUtKNkNPZVkwN1B5SkRlQjZMcDFnR2Nu?=
 =?utf-8?B?SkFZK1VtczhQWHFBTXVRejZJakptSERuRGNzclEzSk02dFQvc1N3ZGx6MWtZ?=
 =?utf-8?B?ZjNsTzZuUzNqYkZoYlJaOVBlcDVSdjhvaWUrOVJ4Wk9lTVh5TncrMWdTM3BR?=
 =?utf-8?B?RXdUa3cvVGJIL01MQmJVY3ByaE9UMUdKYSs3aG5RSVJ5bmk5akdTNVhjTGZI?=
 =?utf-8?B?cGszRlc3TlBnWTJzQmRVSndJNVRYY0VsVlMzTW0zR1l2NzVKdEZXUlZDQVNE?=
 =?utf-8?B?amw1d3FZN1M2TXhiVWJCdTlJcFhXeG9ELzhwNHlJTzlHeTc1Ulovb0liZE9v?=
 =?utf-8?B?OVA4eitIWG5iR2dqUVBXaG5NU3JrSGoyWGxOOWZvL0tGb2NabHRxN00wS2E4?=
 =?utf-8?B?YVYrZkNFVDlzZGNDTUszc3R4QzNQaXNIT2xzOUVaOSswL1dvanp4dnBuSmdu?=
 =?utf-8?B?UjdndUZiMXlvUlkrL3lQT2MwZGRuRy9FcGMyZkh5Z2xWZ1NGb295amh4Ni8v?=
 =?utf-8?B?Q1QvTVM3WEM3eGJ2cXAyenEreGQ3cmxDT2ZiYkJ1ZmdRekpaMnVFY0VYbCty?=
 =?utf-8?B?VXA5YmZkWFh1OG5hRmJwQTBMdVRPSTFtUDRqL2lvcVIwc2w1R2d1YlFsT2pM?=
 =?utf-8?B?U2tlNHFCQ2Ntam5MK2NrMmNXWUpCbzgxT3dxWUJWL2JZS2VFRDhnc1cxWVpq?=
 =?utf-8?B?LzBKcVdtTmhqbUQzcjZPSDJITUtJZlhiWUdaRlp1MjNFVTZRL2FRcExBKzVW?=
 =?utf-8?B?QkpML3BSdjRjemsxMzF6cUlYTEdzMHk5Rmd0OEF4QnV5L2hWek41M2s1S2tN?=
 =?utf-8?B?U01WclpFYWl3ckcvL0RSY0xtUE1aaG1WWmc5YXRISitmZXJkMjk3cHhMKzlX?=
 =?utf-8?B?NEJFVXk2WUU5WkdMbkJkeDM2Z1VtcVM1MGJhVjJFemcvdk5iVlhRd0d2dXl4?=
 =?utf-8?B?NW85WVo1TG9scS95WU9FQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnIzU3NHTlFnM2dQdGo3dDRLY1lITUwrSEpzdEdxV3hOVTR4RTVvYXJrekFF?=
 =?utf-8?B?b3hrMFdlZlRuYzc1TDVJbEwzbVhHUXJvOE5SVU9FUE44ckd3OW5BK3FVMXQr?=
 =?utf-8?B?clE0d2g1KzRPanhDckNsdDV0RDY2Um8rYUhBNU1uYVRCSk5XdnF4NHpBdVVG?=
 =?utf-8?B?MVpJL1k5MGg2Q3VYcWt5OXp5bnhZSWpYWmlzOXhMYWN5SGd6NUZacnlIUFFS?=
 =?utf-8?B?UzNwYWdxNzlsL2pFYnZtUzNMczFiV3F3NHRmRHJTS3FPMk5Lamxlbk5XUllY?=
 =?utf-8?B?aDU4aEZTamJzVmgyUmc4U09iTTd0azl3bmZsTVd5NEtoODNlUW5GL1l3K2tk?=
 =?utf-8?B?aktNQzJtWDdiZHdELzVvRmxibUpiQW9PaWRMSzRENS9lMkRjZHord2krQUJt?=
 =?utf-8?B?bDR3SlcyYWQyR3ZxOEpjaXB5NnFXZmdBNWVaMThvQVpmN3RISGpIejF4MG5Q?=
 =?utf-8?B?TmZkQmYwOUx0cHdQV0JhVG5VeW5kTnJjbDd1c1ZBWGlqaysyYVlyVU9MK21m?=
 =?utf-8?B?Zi9Ub3Rka3JWb2hKTFA5WG04ei82bHJzVkpBa25ucjduRUV3T1djQzQwVEVi?=
 =?utf-8?B?OUh3eG11NFFhVnFvYXZMa3NLYnFEcmVkdFVCcjJUczRTcngyOEM1N2ZiaVRD?=
 =?utf-8?B?NERwWGgrQ1BxWjNZRGZRVENsNGtVOGtRMUhFeU8wdHdvVGlzaUdENlgrV1h2?=
 =?utf-8?B?L05wdU1WWkp5dThaSlN5MFNHYTBlbkNOMGt6c0hDaVpMaHE0YUdDaXE4Y0FU?=
 =?utf-8?B?R0RvLzhzSVpicDRBYnIxMm9HcHExdm9kemZVbHJlQ00yTVFEZ1p0V1ZOVWFj?=
 =?utf-8?B?MW1oZjBtU2wydklvUE9TQldFQUVwRzAxYVd5M1c4ZWRCMlgvYkZTdFdMeldj?=
 =?utf-8?B?SFlMdVNtVHZ4dS81L1p6K00vWEh1a0o0Mi9zNXVRRDlhQXhiS0t3V0NXODlT?=
 =?utf-8?B?WndzcTI1UThYQ3hDcUsrN1VFZW9IYjB1WWpTTUlyeUZPSnVpR3dTT3YxY0ls?=
 =?utf-8?B?d0ZXaGVadWJXVXc5bVgyenhsNUVnbW1TMVVJSW5FelBzZ0ZPTHdlRHZVM0Yy?=
 =?utf-8?B?cWFCZVNVYnFvT1lKR1VzWFd5RVlSdEZQN1pzOWVEQ0ttZ2tRcUI1NEtyYkMz?=
 =?utf-8?B?YXZyRzFybENzY3RYZG5SajhjcG92VWFWeXR0c1ZHNDhxVk5NWVpJYVNnay8x?=
 =?utf-8?B?OVdEQ2tpdGJsYWdIUVhxMzRmU1FTanF5dVJHSk1pa2QzV0dKKzFxbmlyTEVs?=
 =?utf-8?B?OUNBbkx2Y004WXF5MlNOd3FDY0lrUjNWNlhSUHRVOVBIZGM0c0t1RytUQS9G?=
 =?utf-8?B?cGFWTWdKSmxaNDE3WExZVVZKT0FVek5pb2FQQTh3ZEJ2b0ovUmwxMmVUQW5z?=
 =?utf-8?B?MmMrK3htd3pHR3hSelZsUS9RTjRWWGdsemE0Y3NKRFl2N0svOWFlUC9pUCti?=
 =?utf-8?B?dTVCVTkvTHBRN3IyUFBGM1FOVnhjb0UxeG9LNVNoY0VHWGpuYnI0amNJRERO?=
 =?utf-8?B?emxRN3NiOFRwc3hoWVBSbENRZ09uRUxlbUpIdGFEdE54emhKanErL0tJRENs?=
 =?utf-8?B?RGgwUU1JaTNqbFl1NzFtR2Fxd3NpdDZJV2hrVFZURVlTeC9pMDc1Mkgvclpn?=
 =?utf-8?B?Z21xTUNYQ3dwTWZSWktIUjNzWTRicFFrbkNXWVQ3KzZaYTZNVjJlU0JHMXpw?=
 =?utf-8?B?eXJZbm1VMzZqZ09PZkFCbHZ4RlVYTTlCT1lTMGhrQkxWZWt1azZSbGNCc21M?=
 =?utf-8?B?Q0h2RzFPbWJpNTFQaGptY2ZzY1BlVk9abGZTM0tZU2hFTExDREhXekVqWFpL?=
 =?utf-8?B?N2ZsNGxLaG9MMkNFT0ZKUEx5dldad1lxdDhQWCtlOU9kbkQ2YWt4ZzdMNUVI?=
 =?utf-8?B?MXkySFlwUlBZOUlUUTRBaHdJUEJ3ZGRiRFc2RE52M0pTakhiMkxMK3lEbkxt?=
 =?utf-8?B?bmpqenNUMHRXdmJGVEEvVnZiWk9uQVpod05MSUVCR3F3ejdGb1krUm8zcG1O?=
 =?utf-8?B?OVArSk9xMEVneFVHSjVCYzRNeTZBaThFY010TTlZT3duRHF4M0x6NHl2VWV2?=
 =?utf-8?B?ZVUwbk5ablRJbG01S0lqbnZzWWFQQ1pSdmxrQmJhZXkreTZmVXN0SHRWUmVT?=
 =?utf-8?Q?LiZI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b926df-4c3a-4059-f02d-08dc65847db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 00:04:49.8742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71p3JEZ2HmccptiHfUKR7AcQgAjP5Idh+laxLxOamJsi3QXLgirf8cdw3gkKL5UmSgr3ruhFERnhDwZs5urGPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
Pg0KU2VudDogVGh1cnNkYXksIEFwcmlsIDI1LCAyMDI0IDk6MzEgUE0NClRvOiBBbGV4IERldWNo
ZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT47IEh1YW5nLCBUaW0gPFRpbS5IdWFuZ0BhbWQuY29t
Pg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkcm0v
YW1kZ3B1OiBmaXggb3ZlcmZsb3dlZCBhcnJheSBpbmRleCByZWFkIHdhcm5pbmcNCg0KQW0gMjUu
MDQuMjQgdW0gMTU6Mjggc2NocmllYiBBbGV4IERldWNoZXI6DQo+IE9uIFRodSwgQXByIDI1LCAy
MDI0IGF0IDM6MjLigK9BTSBUaW0gSHVhbmcgPHRpbS5odWFuZ0BhbWQuY29tPiB3cm90ZToNCj4+
IEZyb206IFRpbSBIdWFuZyA8VGltLkh1YW5nQGFtZC5jb20+DQo+Pg0KPj4gQ2xlYXIgd2Fybmlu
ZyB0aGF0IGNhc3Qgb3BlcmF0aW9uIG1pZ2h0IGhhdmUgb3ZlcmZsb3dlZC4NCj4+DQo+PiB2Mjog
a2VlcCByZXZlcnNlIHhtYXMgdHJlZSBvcmRlciB0byBkZWNsYXJlICJpbnQgcjsiIChDaHJpc3Rp
YW4pDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVGltIEh1YW5nIDxUaW0uSHVhbmdAYW1kLmNvbT4N
Cj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jIHwg
NCArKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yaW5nLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYw0K
Pj4gaW5kZXggMDZmMGE2NTM0YTk0Li44Y2Y2MGFjYjI5NzAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jDQo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jDQo+PiBAQCAtNDczLDggKzQ3Myw4IEBAIHN0
YXRpYyBzc2l6ZV90IGFtZGdwdV9kZWJ1Z2ZzX3JpbmdfcmVhZChzdHJ1Y3QgZmlsZSAqZiwgY2hh
ciBfX3VzZXIgKmJ1ZiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2l6ZV90IHNpemUsIGxvZmZfdCAqcG9zKQ0KPj4gICB7DQo+PiAgICAgICAgICBzdHJ1Y3Qg
YW1kZ3B1X3JpbmcgKnJpbmcgPSBmaWxlX2lub2RlKGYpLT5pX3ByaXZhdGU7DQo+PiAtICAgICAg
IGludCByLCBpOw0KPj4gICAgICAgICAgdWludDMyX3QgdmFsdWUsIHJlc3VsdCwgZWFybHlbM107
DQo+PiArICAgICAgIGludCByOw0KPj4NCj4+ICAgICAgICAgIGlmICgqcG9zICYgMyB8fCBzaXpl
ICYgMykNCj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiBAQCAtNDg1LDcg
KzQ4NSw3IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9kZWJ1Z2ZzX3JpbmdfcmVhZChzdHJ1Y3Qg
ZmlsZSAqZiwgY2hhciBfX3VzZXIgKmJ1ZiwNCj4+ICAgICAgICAgICAgICAgICAgZWFybHlbMF0g
PSBhbWRncHVfcmluZ19nZXRfcnB0cihyaW5nKSAmIHJpbmctPmJ1Zl9tYXNrOw0KPj4gICAgICAg
ICAgICAgICAgICBlYXJseVsxXSA9IGFtZGdwdV9yaW5nX2dldF93cHRyKHJpbmcpICYgcmluZy0+
YnVmX21hc2s7DQo+PiAgICAgICAgICAgICAgICAgIGVhcmx5WzJdID0gcmluZy0+d3B0ciAmIHJp
bmctPmJ1Zl9tYXNrOw0KPj4gLSAgICAgICAgICAgICAgIGZvciAoaSA9ICpwb3MgLyA0OyBpIDwg
MyAmJiBzaXplOyBpKyspIHsNCj4+ICsgICAgICAgICAgICAgICBmb3IgKGxvZmZfdCBpID0gKnBv
cyAvIDQ7IGkgPCAzICYmIHNpemU7IGkrKykgew0KPiBTb21lIG9sZGVyIGNvbXBpbGVycyBjb21w
bGFpbiBhYm91dCBkZWNsYXJhdGlvbnMgbWl4ZWQgd2l0aCBjb2RlIGxpa2UNCj4gdGhpcy4gIE5v
dCBzdXJlIGhvdyBiaWcgYSBkZWFsIHRoYXQgd291bGQgYmUuDQoNCj5Hb29kIHBvaW50LCB3ZSB3
b3VsZCBsaWtlIHRvIGJlIGFibGUgdG8gYmFja3BvcnQgdGhpcy4NCg0KPlNvbWVib2R5IGZyb20g
QWxpdmlucyB0ZWFtIG5lZWRzIHRvIGNvbW1lbnQsIGJ1dCBJSVJDIHdlIGFncmVlZCB0aGF0IHRo
aXMgd291bGQgYmUgbGVnYWwgYW5kIHdlIHRha2UgY2FyZSBvZiBpdCBieSB1c2luZyBhcHByb3By
aWF0ZSBjb21waWxlciBmbGFncyBvbiBvbGRlciBrZXJuZWxzLg0KDQo+Q2hyaXN0aWFuLg0KDQpU
aGFua3MgZm9yIHBvaW50aW5nIG91dC4gV2lsbCBhdm9pZCBkb2luZyB0aGlzLg0KDQo+DQo+IEFs
ZXgNCj4NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICByID0gcHV0X3VzZXIoZWFybHlbaV0s
ICh1aW50MzJfdCAqKWJ1Zik7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHIpDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcjsNCj4+IC0tDQo+PiAy
LjM5LjINCj4+DQoNCg==
