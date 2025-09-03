Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4971CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 03:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502CB10E0A9;
	Wed,  3 Sep 2025 03:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l5v+vit1";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BAE10E0A9
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 03:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1PHnQtEoj8Bi+5uBkr8PmGjczNuWcc0NVgtNymYvjE5BeyGgSkdt/B4cwrVVyYxrh1yNkNvGk0KuXE6+q+NWxJNLHD3BmBL2EyjXInLDwjuuWY3zsZfNDpcziBM7SvuqNqnVYksiLRhe2cv2uGMVJK7u1SifMNWsnNm5as2sToZTzAjDfDjZuzNSv+I/j+gf4oOevot2c97OI+AzUo4QH/lPpMNYmlbQT5JRjhtuY4GWkxkYrrQmsQTHq8FpVGNYxXeLW08/aaxKJZffNwNT/0vCKAFwRVQm5eSCplGbsbgDnU17VatSc1HVeigoOBvE0rSijASL5nyyg1GGsImEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xcc79twiWdxTIuH9TLSyp+Mf+Nlqivb/llEFfZKxn9k=;
 b=QIAoDcahtUh4Gj+NyFZZZMBFrp8s+Lo/KpAl9eU0cZ1NKbBqMl4vDVZvcyPACp1Sht1FrHgu3oRYsvbbsc9ihvYB6zFvQJ9xz/beX/DwGyQtumSAptSTfeQOUbu1UrhemocvmHJ8j2EB/ZTuaM4n1aS5pfzgt2GEKKA8NilwIRYO0XKZlPcixNk2le5sGxTijufx2ZBQhXTCKqmfbWkHPoEaWHXEG99fjgDTi9lCISbC4+duti0tNI0JWaxuBD56XcD2MovQOWBcxl3GonLgxEAPfC+tACsFokbbx4pIOZRpSjLBBFZDXmT3GyV1eZMxKD1f8z28vwwaV4vmXoOH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xcc79twiWdxTIuH9TLSyp+Mf+Nlqivb/llEFfZKxn9k=;
 b=l5v+vit1rH60tDDja1PMOWsjelysZMQTwLVIbKKiGeWG/0rL2tRyBjv0UnSiuPMnmsnu7NMKK6tLI3iAdF7vOPBRo0mxOCijL6gATuMgZ1c00ra1uwUhGAUMOzp+SPHfiZrZYUhp2QfOU2vcuZNK+Fpt7Sycf9U7vD8rCyOTGNw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY8PR12MB7316.namprd12.prod.outlook.com (2603:10b6:930:50::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Wed, 3 Sep 2025 03:04:10 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 03:04:10 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: remove check for BO reservation add
 assert instead
Thread-Topic: [PATCH 2/3] drm/amdgpu: remove check for BO reservation add
 assert instead
Thread-Index: AQHcGCy/HL2xi4VJf0CM4MN8Yv6lTLSAzcuQ
Date: Wed, 3 Sep 2025 03:04:10 +0000
Message-ID: <DS7PR12MB600578546C7665A9D8B29D94FB01A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250828150200.4035-1-christian.koenig@amd.com>
 <20250828150200.4035-2-christian.koenig@amd.com>
In-Reply-To: <20250828150200.4035-2-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-03T03:01:47.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY8PR12MB7316:EE_
x-ms-office365-filtering-correlation-id: 2aa2c83d-7016-4624-12d5-08ddea968dfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3JUQlVJRjlDYTZXWVRQVVpoNmNMRHZpSlVWRzBQREFvUStUMFFheWNCTWow?=
 =?utf-8?B?YTFheTNRSHRnMnJCMVkvTXBmV1FvWjVZcnk3ODc1Q2VJamt2QTU1R2dBT2Z1?=
 =?utf-8?B?YkFnV1lIM2JJWm1zTUVCd2dGWFJiMjZ5L284ZlNNSSt1bXdXczZFelp3T05L?=
 =?utf-8?B?UFNtbHZjdDFBUmpVajFuaTdYazdtSldpWnlnOCtuTDVmSlFwYjNsaUdNTTR0?=
 =?utf-8?B?ejU2Nzl4STh5WmhJR1QyQTF1cDRMRjFtNnVFMFprN2xSVVdia09YY1lBOW03?=
 =?utf-8?B?OFI2NzVQZUNLOGxNbDBCODhzRjhwbElqVHA4SUJ6RTZtMG9oeWZTbXFrem5N?=
 =?utf-8?B?dGxaZFc3UFBqQWdyL3NGZksxTGZYM2N5RGN1dG9XVjRtUTBxMWt3VkVlblZQ?=
 =?utf-8?B?L1NxSUlKdXZZVjBqRGpValBjdUxabjNscldUVFhvWGJVak5DNE9JZHlJWE43?=
 =?utf-8?B?RitJYXYzZ09NOXJwbXlqSnRXNFc5S1RkcFMzRU9tc2wxbWVrMHVPbXZuVW9i?=
 =?utf-8?B?bkZOT3loNXlTcGowZTVmN1AwRDBDUXhULzU5dmJoU1pya01TK0hsNmQ5VzRx?=
 =?utf-8?B?V3BWbGZzdGY3aVBqV2htSVpEM2dMQkwyNnJuVWlYbC9BbDRwOEk4Z0xyRURD?=
 =?utf-8?B?OTZZVFJjUHdqbkUyL2o3cE9wQVFrTlJQTUpJZE9LUHVRK094dVIwdkNSZmt2?=
 =?utf-8?B?THcxYWx5SXExS2h5ZnI1ZXFwZTM3K05QbmFzTFI5SjNrTEFJaVp0MWN1YU1F?=
 =?utf-8?B?TzJRSGEzNWtwS3B5WExOSWk4TUdCRE0xZ0ptMkpTVkRndFNOZmFROHRXYXU2?=
 =?utf-8?B?V1NnL0xjTlpVTk1SRHJndDBoeUhNakVFVXNTaVdIbHNTSXk5ZDdYRWNsNHZQ?=
 =?utf-8?B?RmhjRlRLTGVxUFVtMUtPWUI0WmRDRDdJUktuUXZSYUtsZ2Qxa2RMRlM5MWVF?=
 =?utf-8?B?TzErNWFiWDZBT3FZKzhkWlhwYnhXVEwwUnp0NGRIRE1wT2gyeVN3V3dnLzFO?=
 =?utf-8?B?UzdWandGVzBTL0I3RDZjK2tmOS92TjI0L1dhTEFVQSs5VENBc2R5Ym5Gb0dP?=
 =?utf-8?B?bW42MTh6SEdJL3hrU2hOWTFUN0hnOXQyZDMzdGE1b2FuRlB3ZGNzMjJYVmcv?=
 =?utf-8?B?V3Y2dEJSR0xVUnBqSHdvdTFYQVNFVnJrQmNTNDFRMFEyd0c1ZlBRUUhmT01j?=
 =?utf-8?B?TVFISk94djVpeEFXTUViYTV5WVJyejZGRDZ5NHRrQWJJMkl6NUhlbzdIMDdZ?=
 =?utf-8?B?Ukh2WUtVY1NucXdhbThwejFpVm4wcVgvYUlvd3d5QTkxZElPd000M3R1OUNO?=
 =?utf-8?B?Vi9RMWpOQ3g3dVVjRkl5SjBMbXk4ZlFqR0dtZ0paZmZhR1RqT1JlYjZ3T245?=
 =?utf-8?B?ZFRXaGxEdnVpQTBoeC9ZY0xJSDE0MERWTFl6azhkbDN1UVBrbzduaEVuRDYx?=
 =?utf-8?B?RGo4NWxxNzYyNzFuaDNCQ0h1WDJsMDJUa0k0andkTCtyTkpXUWFJd3BSNHV4?=
 =?utf-8?B?bjZjUGlyY2QzU0l0WW5IeTRmNTBxb1JnRVZZL1RjOTkwLyt4T0RkcmdEUTJq?=
 =?utf-8?B?M0thTFpZa1hqeGxWdEg5OG1PNlFkU1dScW9EcC9nVzNwWmVOUXgxdnJWRzA2?=
 =?utf-8?B?bW1UV0NVVmpRZ1piT3l5MXoweElTa3k0R0ZMMlEvb0hRWVdCMGR4VE5WS0RR?=
 =?utf-8?B?WUdJYlZVZmR6SVdneUZmTGtqWVBBRlJ4ZThkLzhRMU9tS0N0eW4vSUJybm02?=
 =?utf-8?B?cm5WeG1HWFlwNmZwWm9tbmo0WEhuRVpnTkxoenQzcm1UUjVuaS91eHZmRCtB?=
 =?utf-8?B?aFJpaDU1K05QK1JhYWJRU2hXTzFNQVpMaHZlWjJMMXBSaUFHY2J3WVdEMjVr?=
 =?utf-8?B?bFJKcnZ4SXowVk54dWxUZnpMbndIczBabkg0UXU5aVA3M1FFcW1IbXdWMlhz?=
 =?utf-8?B?OWxiMmpCbmw2MnJ6OHpoa1o2cm0wdlpiT1RXR3hZOUpNRHVzbkVRYzBrMHpw?=
 =?utf-8?Q?nDg+vjaOwX98Y7e3LpbOAYgbbS2JI0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE81a1pQV21iNGR1QytKaWtaS0daUmRjZDE4ektObk1WT1hkV01taDM1a3da?=
 =?utf-8?B?ZW5xYzh0TVJCNFVweUdCR3ZVM1I1Z1pzT2xPQUFneXlkUGk0MTJvWnNXR01a?=
 =?utf-8?B?REZzTmQza2gvUWJFSjlUSGpNdUZWSng2MzZiODFxL2lwalpSdFlSeVhPaFhW?=
 =?utf-8?B?SUVGUEszbWZKUXRjdTFNUWovTi9vbC9NNHZyYU4zT3JWMWhBSDJnR0tIYUli?=
 =?utf-8?B?UFUwYUhzT1J3YnZjVVNrK2cxeFc5MzM5d21TSGJyM29MWEI2Mis2VTdORW1I?=
 =?utf-8?B?bTEyRUJBR29oWVRvYy8ranlGTDhVeFpiR2VoV1RseVVTcDJMcnltVHBha2pN?=
 =?utf-8?B?WFVYZ1h2OWhSa0hZdHVnWTF6UG5WRjM2SUdpa1dWNEU2QUFMNERodTluT1Vk?=
 =?utf-8?B?QWdLNUxXNklQR2FaUkxDZnlQejdJMTZkR3l5YkpyaEFVdmlTUXhSdWkrekRJ?=
 =?utf-8?B?UFVEUXJTdkduQkZxYmdCRmhrOVl5VEg3blpjUlUva1VNQjRNV05zOEU5Rkpn?=
 =?utf-8?B?Qzl1SWM2Q3lJUVZmeS9GNTFnUmFZZzVRdnNzUGl6NUhXRm1zU1VBL09Wb2NL?=
 =?utf-8?B?SE5qcVNkNTNlMEJjdzJncEdrOTZjRlkwNUFrREU3TGk3TFdzbjM4MlRCZHUw?=
 =?utf-8?B?akNMWXF1c3Jta1lHUzhrQWU1TVkydlRjYitqSGljOTMxNFdsZVVVL09FK2lp?=
 =?utf-8?B?WHVielBXZllkcGQxUnJZbFhvVFdYNTlXZHpNNUhWdmdCWFVQK1o1OGxpOUNi?=
 =?utf-8?B?TjNkMkQ3cVZzNFRDM1gyakpRM3ZYV3JRcDBxSFVrV3lwK0ZEY0piU1JsR0Fq?=
 =?utf-8?B?UWRJd0VDM1FXTXpaS0FNOXlxVmFUT3hMZFFIWE1IcEpzSG93NmNsN0xhU0tp?=
 =?utf-8?B?aFFKcmNSaWxxdXhPaUQwMDBEVVJOdjRTTkdXeGVGTmlQQlhZUndGcU5wWVIy?=
 =?utf-8?B?Y3dhVUU3RE5ZWFJvOG8zc1VNaTViNFNrUFBxc2RUZ2V4ZlJEdEJkQVBzUEtY?=
 =?utf-8?B?NFhUc2Vma2hEY01GbGtYcXJ0OVFkSGE3NkJFRTk1MEVlSU9nTmx6c2pTaG1n?=
 =?utf-8?B?RE91aGRwZndLeTc4OEphK005L2Q3TFQvdUV0WmpTTzJGUGhYVFQvTWI1UW9a?=
 =?utf-8?B?dzd3c0U5Tmpadlk1SHFHNXJ5SS9aTzF0UHZLb0hzeFdxWjlHdjlLS0hVckdj?=
 =?utf-8?B?aDZOeVE4ME5qZ1pJNHRXb28vS0NiTEpEMytnV3c1Z1gyWjZqNXora05YcTh3?=
 =?utf-8?B?OVNpY3BEM1FXVk9UWklCbUFXbGFMTFdCQ05Ja2Y1K3owY0Z3SWJOeWtKTmNL?=
 =?utf-8?B?L1h2TGJrTEpRQ1ZSTWRVcXg1UnpyV3NHRTNKTENMNGsyQlJ1WHZGcm1SYnVy?=
 =?utf-8?B?dExFN3IrTVZweDR3My80eUxrVnQ2aHdIRCtZbVdEcjFLalU0NzNoY2lUV0Fy?=
 =?utf-8?B?YWZndWtkUjJReS9IaXgwN1ZORitUN2dncDIveU13c1JOZGh2T0JoL08xWnp0?=
 =?utf-8?B?K2V0ZjU3eXpkdjhMa0FCY0hxNFZUblVyTXlOT2x3RXRrckVMWmJKY3llMjdG?=
 =?utf-8?B?UzRjWFEzUHpNV1pVbng0UGE2bndBZEc0dkVJd2tWbjlzajc0TDRvcTduTmFs?=
 =?utf-8?B?Z1FSMUY3MlhDZ3M4RFZ5cHZ5OTRIM0ZlODQ5Z0ZHaVV6RVFYTW5sL1F2eExC?=
 =?utf-8?B?d3hJbVdZU3hTYzhjcXVxT09laU5hdHBzTHFZZFcwNkdpWmhHNXNCa2pmSW5x?=
 =?utf-8?B?WGpjTGRlY2lsQ3MwcUJDVXkvN3hoWGkxVDlHWFBkSUYraHZ1KzFkVktsMkJk?=
 =?utf-8?B?Z2NzOTcxMEJjNGVnWThEMml3cWhsRU1ESWdId3ZoZFZ2N0FKSHBESlVsMFZQ?=
 =?utf-8?B?Y1hiMm1ja0tBRndNNVZ1a2dZU0Z2NUNDVG1IR05MUXdISnA0SVhvdmRiSFZU?=
 =?utf-8?B?bVNhcUs5L3ZtYWxNVWplUldTR2lhTlFJdWtzS1J6NWFZSi92RnE2VnhJRVV6?=
 =?utf-8?B?eUJTREdyZlU1UjR3Q3c0dE1xL0RKRGxET0JtWGpSdG5lcHVmV1lpMlFDSXZG?=
 =?utf-8?B?Q21kWVBxcnBva2xkbUZHR0NHSlM3RGQ3MWxiLzMrYklDMnJqTjhkN1dUK05s?=
 =?utf-8?Q?DHao=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa2c83d-7016-4624-12d5-08ddea968dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 03:04:10.4433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1jmWazE0NR9uqVBxFMM29a7KvnpR2FJ9Ed50Xah9MRMsXjs13HX220cqf5JSkRH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316
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
YWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIENocmlzdGlhbg0KPiBLw7ZuaWcNCj4gU2VudDogVGh1cnNk
YXksIEF1Z3VzdCAyOCwgMjAyNSAxMTowMiBQTQ0KPiBUbzogS2hhdHJpLCBTdW5pbCA8U3VuaWwu
S2hhdHJpQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1
Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0ggMi8zXSBkcm0vYW1kZ3B1OiByZW1vdmUgY2hlY2sgZm9yIEJPIHJlc2VydmF0aW9u
IGFkZCBhc3NlcnQNCj4gaW5zdGVhZA0KPg0KPiBXZSBzaG91bGQgbGVhdmUgc3VjaCBjaGVja3Mg
dG8gbG9ja2RlcCBhbmQgbm90IGltcGxlbWVudCBzb21ldGhpbmcgbWFudWFsbHkuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDEzICst
LS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTIgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IGlu
ZGV4IDE2NDUxYzliYmUxZi4uYTAzMzkxODdlY2NkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYw0KPiBAQCAtNjUxLDE4ICs2NTEsNyBAQCBpbnQgYW1kZ3B1X3Zt
X3ZhbGlkYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiBzdHJ1Y3QgYW1kZ3B1X3Zt
ICp2bSwNCj4gICAgICAgICAgICAgICBzcGluX3VubG9jaygmdm0tPnN0YXR1c19sb2NrKTsNCj4N
Cj4gICAgICAgICAgICAgICBibyA9IGJvX2Jhc2UtPmJvOw0KPiAtDQo+IC0gICAgICAgICAgICAg
aWYgKGRtYV9yZXN2X2xvY2tpbmdfY3R4KGJvLT50Ym8uYmFzZS5yZXN2KSAhPSB0aWNrZXQpIHsN
Cj4gLSAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfdGFza19pbmZvICp0aSA9DQo+
IGFtZGdwdV92bV9nZXRfdGFza19pbmZvX3ZtKHZtKTsNCj4gLQ0KPiAtICAgICAgICAgICAgICAg
ICAgICAgcHJfd2Fybl9yYXRlbGltaXRlZCgiRXZpY3RlZCB1c2VyIEJPIGlzIG5vdCByZXNlcnZl
ZFxuIik7DQo+IC0gICAgICAgICAgICAgICAgICAgICBpZiAodGkpIHsNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcHJfd2Fybl9yYXRlbGltaXRlZCgicGlkICVkXG4iLCB0aS0+cGlk
KTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3ZtX3B1dF90YXNrX2lu
Zm8odGkpOw0KPiAtICAgICAgICAgICAgICAgICAgICAgfQ0KPiAtDQo+IC0gICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gLSAgICAgICAgICAgICB9DQo+ICsgICAgICAgICAg
ICAgZG1hX3Jlc3ZfYXNzZXJ0X2hlbGQoYm8tPnRiby5iYXNlLnJlc3YpOw0KSWYgd2UgbmVlZG4n
dCB0byBzcGVjaWZ5IHRoZSBjb250ZXh0IGxvY2ssIGhlcmUgY2FuIG9ubHkgdXNlIHRoZSBsb2Nr
IGFzc2VydCBjaGVjay4NCg0KUmV2aWV3ZWQtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0Bh
bWQuY29tPg0KDQo+ICAgICAgICAgICAgICAgciA9IHZhbGlkYXRlKHBhcmFtLCBibyk7DQo+ICAg
ICAgICAgICAgICAgaWYgKHIpDQo+IC0tDQo+IDIuNDMuMA0KDQo=
