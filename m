Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559A3C25B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 18:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02E710E1E2;
	Wed, 29 May 2024 18:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OCVYXDyO";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F1510E1E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 18:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiGHQr4tDeMLcTSTZ+qQQtdBAoOFLLxo8MfIOdcwj1nBVX6+iWrsd7P+EesewRBvrshxsd8F/kvPO87huF8SnbbY9YulBwoaZpdE1J380K8j4MAtbxzlWxOOPChNQvAYuUUfsXHr6rs9tWAVo3YaqmS0HboF4GfYsqedSvHSHA4nNAlXWTUNWJoK/31cVpxtFFCC+xqgit+a1Vr2aJK5WhAIsugX0bZ4iFwx/NpkmRCX8ZUoJKzwaDiSJxXFsAyYGgPt1eE1whwvx0AOskJkPVGWHJTdLrz1NSNAJ2SaqtHM/qZTacAo9wb10lWlm/6SjjUsNXK7xz73r5VtRHDxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pylPZ0CjoRlWKHzreZ+twMXQdDcHatHzCO7GOUPQeDc=;
 b=dTP1I/rgQkihBtv5x7HABVUMYbvyfGhlbVPe/9lJhuFhuGlp0XWWmcx6RnP2HmWJDYlBPLcXXkWazjEb4ECIgZYKr8dFThd9Ehr0Tfm46yN6RBepE5BOG+7G/esl6+4FcvR3rRce95n5Z+9Xsfp6A24gzvPFiLljE9lc0pQGBqcEKGpbhKypAMsVKWmG90f4ZF5Z1wE0O+DKymgCg81wlFMR9b09pDmT3vkws9vQyxiL7fITR03icixg5DwPpN550an0Nuq2FiTjiDC9AIFczus8cPX5JTHjBOFZeD8dSgKqzRzqHtsNlwzXsJlDlwIhrTLhUSARxu9M7QRSPcEzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pylPZ0CjoRlWKHzreZ+twMXQdDcHatHzCO7GOUPQeDc=;
 b=OCVYXDyOOCbbf5gAIuQKpsmdF04iL+erHbmgllU9MLPk6lsx0XfFfiD4/5Ajre0muUgz0T2DH8madPgFZ5zi/FUaQXmXua/r5YlM0bpG2qUNhcNutFcigP0EdJiGi+K6dLAgHqFVM1AqUH9AY8kEBf43EY7hCMF4vdVswf8CzPE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 18:19:28 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7611.031; Wed, 29 May 2024
 18:19:28 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/soc24: use common nbio callback to set remap
 offset
Thread-Topic: [PATCH] drm/amdgpu/soc24: use common nbio callback to set remap
 offset
Thread-Index: AQHaoX1Raj54g7XIFkKOr8i6qMcBwrGuoz2AgAADMYA=
Date: Wed, 29 May 2024 18:19:28 +0000
Message-ID: <PH7PR12MB5997DF07B16CE28AAD98C74582F22@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240508192345.3688461-1-alexander.deucher@amd.com>
 <CADnq5_M4YA_bV_nR--ZPZA_9c9TWqOJ=AVrBemtq7KfVi8n3kQ@mail.gmail.com>
In-Reply-To: <CADnq5_M4YA_bV_nR--ZPZA_9c9TWqOJ=AVrBemtq7KfVi8n3kQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ff97e947-f712-48d6-9eb8-332f0226de8a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-29T18:19:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA3PR12MB8023:EE_
x-ms-office365-filtering-correlation-id: 0f7a93a7-b95e-4f12-d5d9-08dc800be0dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RjdXcThTUkEvQXVGZjFRTUZJN3FPczhoU1JLdUI3KzYyMkN5OFpYc1p2N3lU?=
 =?utf-8?B?OUJLQWliN3hNUVh1bGdzUzVVQUZ6aEtOZzhKOGRiNXpOTVJCYkN0alVhb0JX?=
 =?utf-8?B?WTZMNWRJYWZnOUJTZ3FFYkUzaWRYZHdGQ0pVUXgyZWkvSVFsNGF2ZGxEN1Jr?=
 =?utf-8?B?YjB4eFNVcnBzaFhibFRaazlDckpMUk9yMlhGNERFSDBDb0xyMzU5NUM2K2VY?=
 =?utf-8?B?ZnJBWHYvTmFXWGRBVUE1ZVJ0WFJObVdMN3U2WENTb25QQUNmWkpjZ1NuS3pQ?=
 =?utf-8?B?M2RvYjB4WFNjcUJzU3RyaU5peUM4dTBCRTZIdG5Oak9HcVRsYWRiTStTRG15?=
 =?utf-8?B?MnYycG9aZ3J3eENsWlQvRnkxNWRwcy82QWhhVUhHZEtSa1pRekpDM1grTC83?=
 =?utf-8?B?TmRLa3JpcVJyalZZM09UNko5U0wvMkFKemVleXJxL0dYT1lOU1lvN3VLdVA1?=
 =?utf-8?B?dms0eStJUTBlR0NaRTlERkFmYUxzcC94WGR5QzRlbnB5Mk5rWnIrWHh4WFpx?=
 =?utf-8?B?NXhOMnNCWnhiNHpZeXpsTEszQVNGVXdidEJKK0FiL09rVW1YUjhTOE9vNTJw?=
 =?utf-8?B?MWYzY3kwbTlCTXJLTzg2Tm5YcmQxY1czSXpmS1R6NlJucjZIR3ovNjRTY09B?=
 =?utf-8?B?SkpzNitqZHY0V29ZYmVyMEVOUytKTlV4YU5udnJoWVVIaUZtMmFwNlZGT3pu?=
 =?utf-8?B?QWtTSzdVZFB1ZjZiWmRuM2djcjBSV1pKbXlPVTNLd3E0VUVZTExKTk0yZHFV?=
 =?utf-8?B?YVdDOXoxcFJ2K0xtYXlCMWhIL2IyMyswellYbDJqWEVyb0ZCNWJvbzNicGxa?=
 =?utf-8?B?M3lFNWE1bjFRdE5FRlpGd3BjTUxOaURJb05JZ0ZjWkNIVGkvbFJWR3cyUU96?=
 =?utf-8?B?dlVWN3JhWWF6ZWc3Tm9XZVdkRFNCaFhyVmVEbmZLeXgyME1WOHdYTWhuOFNQ?=
 =?utf-8?B?aXpCaUlKakxzUUpoNFhEZVBDeHF1ekIvN09KQUpZeTlvd24vUjZGVzZaamlv?=
 =?utf-8?B?TWkyMU11dXdDY2RBMDIwQ2QwUUFqV1FzQXMwbVRyVTZIckk4OUtUdHhUTkJx?=
 =?utf-8?B?U01qTXhsRGJsMTZPL2F6clNLbzhTQ2Z0K3cxWXg2bC9sNTgwM1dmUGFxV3BQ?=
 =?utf-8?B?WjZyS08zRCtSWEtzSUpOKytWWWkxYVliZlhoMEpxdk1jbVBTazE4MmVSSWlY?=
 =?utf-8?B?NzNBSC9YK2Y3SlE5Sk5lMzJ4SHg4NzZiZDZGc0MzdFBuUVVtRWw3VEoyNGRk?=
 =?utf-8?B?bFFFaFUyZnZhQU15bnBGS0dQNzhRblZCbTYrMlhQcWpFZ0VBQjZvOW5wVDN4?=
 =?utf-8?B?R242Zk5vNzZHMmJ0dG85Q0pIeUNIVmVBOENwcVREd1RiSWRQbjdaU1cvMXhG?=
 =?utf-8?B?RnFNQmg4am0rclFUbEQ3KzhZM3daTWZnMDBRRlpTQUxzR29TM1E0OXpKaUhV?=
 =?utf-8?B?M04vVmY2TDB1WEJXU0VOT053WEVnVXlSRHQzVFJjRFE5NDFuTVhoNEYvbDFp?=
 =?utf-8?B?dVhMY0Qydmc3NDN5Nld4cmNHV0twQ09WNUUxU3ZSaVhrRWFUTkpOc3RScXIw?=
 =?utf-8?B?VWVQdEl5TDE5SjZXbHVhMnlyYnpiQ0gyZmkyMHJhcUgxL29ZM3dBcFpWTk5Z?=
 =?utf-8?B?YWN6cFZidmp0ak5YbkQ3d0RSVnpHNXVlQXV0c0w2Z0FCTkNTQm5FcSswb0V4?=
 =?utf-8?B?R0wzSWV1UFAxWThPeUZGelFxK0NKVFRkd3hIVXRoeWpTNHBpL3RMaG5raDNs?=
 =?utf-8?B?OFFnNGNMMnNPcDFtREUwRTF3Tk5CMW5CdjVmaHYzaW81MTR4SzdYVk9EWVdn?=
 =?utf-8?B?UytNVzdBT0xiMlF5NE0zdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVVLWWtaSFJjVXNrUE41VE5nVG5IZEszcXA1Y2E4UTZ5cGlNUGFLQmhTTkd6?=
 =?utf-8?B?bDdlVGJWb1R5SUpRQmdZZTlqblNjMXVaKzRJRW4zUUhhMkg3QWsxWG9CV205?=
 =?utf-8?B?SG9nZjNpYVVSTXYwaWs4VncrTnlVQlY1NzArYXBNVWJTNDFOUWF6b21kcGJa?=
 =?utf-8?B?UEtMNTZHdUtOL3VnYnRCbW40Skd1dFBsSzQ2KzIvZmQ2d256NjFRSENibHZT?=
 =?utf-8?B?N2tYYjRNM3M1MmllUG43NGZTNTBpZkgyNFl4aktqTUpEYWlJaXpOUEpRZ0d1?=
 =?utf-8?B?Qk9vZFZxK3pUMStiRy9WTGdsSWFvMXAzZlFNK3pvWVFxUWJLLzJvSjdUZ09r?=
 =?utf-8?B?c3RhemFjZFZuNVkzYXRzRDA2ZTRyS2N1ZFB5WUVteE5ZcUZBS2Y5bjdXTUYw?=
 =?utf-8?B?d2NzSzhaYTBoOEZwYytFT0psNXUrZm82VW0rQkt5SGlQK0I1TkdNVUs3VGto?=
 =?utf-8?B?b2twQ2FkUDdiRURnTEk1WXBTUTdtQTgyOE9VdWZEMWx0TlFCTWZkVlQ5UVcx?=
 =?utf-8?B?N3h4ZnpDVE5kVmYyci9JOWR3WDlkK2ExUnVVd1dQZy9pWXNrRzFlWVgvZS9r?=
 =?utf-8?B?M2dWS3JjZzgrTktWS25GWHNveUxndWh2UGFoRWhFQ3Y4Skd2UHAxdDB3c1Fj?=
 =?utf-8?B?NDJ0RnJJU21YRlhJa3I3OE5NTk1YRWozVjRwVS9Cc0Vlc2M2NHkwVnNrbUhr?=
 =?utf-8?B?NmsvT000QjU1Zmx1VldqQVZwVlB2dTAyZHg5STYyR2RHZ1FNdld5czJVQVBX?=
 =?utf-8?B?ZElPRjJoUGtLOGZJQ3pyNU5CRzlDazJJZ2x0NTNCRlo5SVR1RGNCLzh6Y0xi?=
 =?utf-8?B?S2pBd2VYbTdLd1VZOWQ4dHYvbkFmVTV4a1QyM3k5VUpWVEpQMFgzSW8xNUsz?=
 =?utf-8?B?RXRic29nckhnK1pmQnBHdG1hNlN4S0xtVlZ3ZytGQnRZajFIaEJQSlY0RFFS?=
 =?utf-8?B?L1VvR3RDajNYWU5Bb3RwZlptekRmbGFFTkpjZTZmRW4ybEljRURxMVVETkRV?=
 =?utf-8?B?eUdYU05BT3Fhdk9pR0loRm95OFVjUkFxMGxmL3U0Qi9HS1pNVkNaZGtZSjZa?=
 =?utf-8?B?K3lOdS9oa2dabGdZOUJ5bkFIYUttcjhCclp4Y09RMktrQWNvWitTSFFuS1ZN?=
 =?utf-8?B?K2UzTWhxSzF4UWRldWRpSVYzbmFMSkYybHhWVzdqTUl5TWdHVElvQTNnOGxR?=
 =?utf-8?B?UFdhYUZOZHZ0eVd5T01IcnBGM0l5dWkyZ1BLaS9OMUN1cTdiak9NcTFOUEFW?=
 =?utf-8?B?N09IM1lDYkE5aHVMWVlwWGlLc0hpdk41RW96SzVjVXU5TFl6bXlmY0htbG9Z?=
 =?utf-8?B?WUVQbml5bDIyZ2RVSjhXN0ZQY2RycXNuZUFiZVBCM0J6dE5ZUFpZOXRaY2JY?=
 =?utf-8?B?ZHkwM0FxZTNmSmV2YVJURGFZVXI2ci9jdEZWWkY1S0g1NC9mbmR1NnZTcEt3?=
 =?utf-8?B?Umxxem1EZU9zdE9nQ2pUbFRNUzZZdWp5VThVOWhSWmpySDdmN3lleEVJSlBm?=
 =?utf-8?B?TUVIVlVOZlJIeU1vWVhURGtQODhDdXo0dTU1SndwekRBVUxyd3lrUEdUemNh?=
 =?utf-8?B?Q1U5K3BDZXBjeXdqWWlhb3hpUHNzTzY4aWx5V0RoOU51QkxsUGVrN1B5S1Vs?=
 =?utf-8?B?bitycThjYTRIQlkyOHE2VGcyRjBJUkZZcUJZa0RpbGpGUDgwcnNsNHVLYm8x?=
 =?utf-8?B?bFlVNEZseTZ2Skg3OTJTWVBSZ0hIYWFRbXZXMHlXajFDVmN2Z3F4TnJFakdr?=
 =?utf-8?B?SjdpRzRvNnFpRXZsMkZLdzc0aHZVRW9zWnozeGgycDF0c2VvRVJSbzdHdzdo?=
 =?utf-8?B?emhPU0xuTTA5VXpmME1pMXhYY2ZXbU9BTm9rRVFyVjdPeTQ5MndlaWFKVjJE?=
 =?utf-8?B?R0lsVFRWT0ZuREZiM3c4eGtlWnh6RllYQkQ0V1NwZjNidkovVXRqaWRiUXlz?=
 =?utf-8?B?OE5HdHE1ZldUcVRLUWVlUHBTb05DYkx0R3hiVUYrL3NWaDZpVE5EY2R4UmNX?=
 =?utf-8?B?R29ERlBYNGxZOTNHR2VuTUNETkFFWkpPUTZVSEZ5cHJ4d0NibVNkMjNlb1JJ?=
 =?utf-8?B?dk9FeWNGZlMzcjlXUzdrZkczQjVQOEFhcytyS1I2aXFjVUpmd2NLNXdTUC83?=
 =?utf-8?Q?zxJ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7a93a7-b95e-4f12-d5d9-08dc800be0dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 18:19:28.4855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLLvzr0U/WijOP4WlHtMoSjJcqfzOKnJ1wptTBcxDgGtrsMb7f9ywr7RzkY3YKaM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023
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
Cg0KUmV2aWV3ZWQtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KQmVz
dCBSZWdhcmRzLA0KS2V2aW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFt
ZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBP
ZiBBbGV4IERldWNoZXINClNlbnQ6IFRodXJzZGF5LCBNYXkgMzAsIDIwMjQgMjowOCBBTQ0KVG86
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdw
dS9zb2MyNDogdXNlIGNvbW1vbiBuYmlvIGNhbGxiYWNrIHRvIHNldCByZW1hcCBvZmZzZXQNCg0K
UGluZz8NCg0KT24gV2VkLCBNYXkgOCwgMjAyNCBhdCAzOjQy4oCvUE0gQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiB3cm90ZToNCj4NCj4gVGhpcyBmaXhlcyBIRFAgZmx1
c2hlcyBvbiBzeXN0ZW1zIHdpdGggbm9uLTRLIHBhZ2VzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjQuYyB8IDQgKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjQuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NvYzI0LmMNCj4gaW5kZXggMTI5MDA0ODhkZDYxOC4uNjZjNzEzOGZjNmFhNCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjQuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyNC5jDQo+IEBAIC0zNzIsMTEgKzM3Miw5IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2FzaWNfZnVuY3MNCj4gc29jMjRfYXNpY19mdW5jcyA9
IHsNCj4NCj4gIHN0YXRpYyBpbnQgc29jMjRfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxl
KSAgeyAtI2RlZmluZQ0KPiBNTUlPX1JFR19IT0xFX09GRlNFVCAoMHg4MDAwMCAtIFBBR0VfU0la
RSkNCj4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqKWhhbmRsZTsNCj4NCj4gLSAgICAgICBhZGV2LT5ybW1pb19yZW1hcC5yZWdfb2Zm
c2V0ID0gTU1JT19SRUdfSE9MRV9PRkZTRVQ7DQo+IC0gICAgICAgYWRldi0+cm1taW9fcmVtYXAu
YnVzX2FkZHIgPSBhZGV2LT5ybW1pb19iYXNlICsgTU1JT19SRUdfSE9MRV9PRkZTRVQ7DQo+ICsg
ICAgICAgYWRldi0+bmJpby5mdW5jcy0+c2V0X3JlZ19yZW1hcChhZGV2KTsNCj4gICAgICAgICBh
ZGV2LT5zbWNfcnJlZyA9IE5VTEw7DQo+ICAgICAgICAgYWRldi0+c21jX3dyZWcgPSBOVUxMOw0K
PiAgICAgICAgIGFkZXYtPnBjaWVfcnJlZyA9ICZhbWRncHVfZGV2aWNlX2luZGlyZWN0X3JyZWc7
DQo+IC0tDQo+IDIuNDUuMA0KPg0K
