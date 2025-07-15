Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2380C83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 13:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728DD10E5E4;
	Tue, 15 Jul 2025 13:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1sVFS0r1";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD6310E5E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 13:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnjWmdZ9JDL2ioAcesklBpeU/NYqcB2RWzq3e2dvi94v8Hvx6RDZDI+O8qfGAJyo/yS8A+C5uYjuWr5jUZhXvjbXnraTjyoh07URDbXVczM4nDV1PuH6VC/YWg1iHM8Ws5Ly1aARrl+/r4aGXxT8An3vwkfB4VbDoXWSRdxm8bReDD/RGHfQRp+k2I9z+HzjACO9qvYb5LBtgVijjvBNLiAJdVqzBosKV5UbEtkAMixg4Xzr2T4HgKXPX549JRX94efqCYgVrMS27tWG/58F8IGRHvPVhA3IKcTQDoNSXD6dH+FH25SUDsqI0pKKchMBWOHvuGy34nyT4pj0PKZqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nl9t4NxfJA4m+SfFXR/706OIBzZPjfUz9sxM1jFgoZM=;
 b=P57XlLFHcbBl7ZdsKA3/BbqGhKBbm2Hlo+ZA9EhRKHGClntSljOyNiJfXGy49dr9fnLcHrThOgQLRcAgMZcs7laXPYGY1/uOoFK03fUqZcRXF2QdxP6FdVpgi+YHT85ZSC6nR0UfCQ0OGEYiLGw/cY/bxW0m37NFbLC/wkVi3UZhTXkU+uhQ2nQ8m1528p91sWkU8ZAuR8NIreTaU+8ubhajxypRFMc/jWeYnzwebSdc+EMxX68KMuuh+m8jeJ+NzYo4YS8wSiE1VdRifPyyk53MSQLzgP30elLlRxsRukfMuAGpSP/SWsJYtkPVglidL1a5OINqnM2eYliy8UqXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl9t4NxfJA4m+SfFXR/706OIBzZPjfUz9sxM1jFgoZM=;
 b=1sVFS0r1NSqZXdN8lkSROUrlDjY/Qsw5rCRRF3qX91vpLCGF6ylZlImJppCeMB2TsgBLC/IyRfMxlDyAWB4ELToOZ6X3JWIQ2cwRyV79iWFDiBhK0j13Bk2bMVsSC8O5KggCYh3xu6+RESj8KB7HL0DymDmQfS9NmM07gMClZSg=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 13:54:46 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%6]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 13:54:45 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: make compute timeouts consistent
Thread-Topic: [PATCH V2] drm/amdgpu: make compute timeouts consistent
Thread-Index: AQHb5XlwJgBQHaxz6U23BdFfoRC/zbQzUmSAgAACdhA=
Date: Tue, 15 Jul 2025 13:54:45 +0000
Message-ID: <BL1PR12MB5898704C92E20452CD5A56788557A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20250625023220.8417-1-alexander.deucher@amd.com>
 <CADnq5_P24tVYNh0oegDsC5R8gCS3_+aWvAf2yswgqd5k6JnrHQ@mail.gmail.com>
In-Reply-To: <CADnq5_P24tVYNh0oegDsC5R8gCS3_+aWvAf2yswgqd5k6JnrHQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-15T13:54:37.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DM4PR12MB5770:EE_
x-ms-office365-filtering-correlation-id: 81bbd5dc-8407-4b4d-4d3e-08ddc3a72837
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MjZzR3RpbXVLNzJvVW5SaVBGdFpqck1Md255N2FnMEVvbHZNQllwNVduc2xp?=
 =?utf-8?B?SlMyMGtGampEdFgwUkF0aEhoaHV4V25VSXF4RCtZMXlIZXhOZ2p1QjN2Zm1y?=
 =?utf-8?B?eE1oQ3dkUWtNT09yYmFKYnFiN0VEMTg3a0R3TlJudlhwcHNVZjdteHM4NTcz?=
 =?utf-8?B?ekF4NW1vbkdQTVRCSllDVWNZYkdodks1WGZsVnoxUUkva0hYejU4czczMmR6?=
 =?utf-8?B?b2RGYU5jejFPNGdzMDZIVTRQMWtUeXBrTnZMTHMwc2V4c3hpZnYra2FWZGlK?=
 =?utf-8?B?dmlhZUt0WFNDRDlzaTl2SEt6MGJSZ29lUzJxaFVyQ1djSzRHb2N2M2xqMjlz?=
 =?utf-8?B?aE13dTFGbDNsUHh6N2tzeER2dkM2YVpJei94N1FJd05sS1V5dnRRRE5hN3RQ?=
 =?utf-8?B?UTlnNG8ybFVQWFNjNThHV0c1OGZaVW1laDZBNHAzZlRKRW0vTHVIRmxJZXVU?=
 =?utf-8?B?TmZveEp5ZmxDU3lvUmxSclAwWk5yUGNMdUVmOE1JRFc1dUpDUDUzeVNHQ2V6?=
 =?utf-8?B?QU83U3lPeVh2b1Y4dDlQRGVtbXRxTDFzb1Z0RUhOaUlwb0dLZHkzOUgxL3dl?=
 =?utf-8?B?R2FrU2YxWDJZb0xNdGl4TEl0Wk9PUENrK3pYZmd4ZHdoSVplUDVtQnltMnY1?=
 =?utf-8?B?MlJTbDkxRDVTcE9XenpYOTF2TVRpL2FqcjJWSkE1S1JJbnRiU2d5Yjhuc0Ny?=
 =?utf-8?B?MmYzeDl2ak5OMXBmTXNqblZiOUFyVzNDcjVvaVpOa2g4SmorRWFBSjc2TWhT?=
 =?utf-8?B?cmFlQWNjTlhRcTJhMXp6MmJ1eldNUFdEV3ZKamc5Rk1lNVVwWnozVndMaGRQ?=
 =?utf-8?B?OXllZUFRV2NTL1RCOHJTZ0FrdzB5WFhBaHA3L0lwY2ZyS01lSFJQOTJBSUMz?=
 =?utf-8?B?TXJuNE5uZVVaWDI0QVRUTW1SNHJ6NXhad3JodUN6VE9FelplSDhVcVJQQ0sv?=
 =?utf-8?B?QjNGaFpSa3gyaXVjOFU1YnBmaEdsNTZxYTk1UGdiU1pYQ29yU1F2b2p3cDRs?=
 =?utf-8?B?STQzTndjZ1lwb2R0NUFKZWM5SHNkcTFxRmFCY0MzV0JnaXl6T1hKZ3hUVzRT?=
 =?utf-8?B?VXczQnNoeUVyM3dzNDY2VFhOVUhUUjVUYVN6ZTM5eHNpa2o3bC95RmVwNXEr?=
 =?utf-8?B?WTFHOGoydUpwOHJaZkZhakxjMmpWRjkrYXl4b3BmbEJZSE92TnhVV1ZMd1Er?=
 =?utf-8?B?aHBVQmM0OFV0aXBJQjhrQjVwdXgzNG00Mi9nVzU5S1RtV1UzRjB2c1hUOVpH?=
 =?utf-8?B?OWdyUTJQeHpKZnRFckMrQ3lSenhrWG9PZE45Z0JwdVhFL0Vqa0NQZ0s4WVgy?=
 =?utf-8?B?UjQ3b2thbjNZdWcycmJZVnJUMnBtRTNFeUMwRHNYek0yTk1GSC9VZTFXa3ZT?=
 =?utf-8?B?b0pnTlBjU3FvK21WUFZmMWJNWE5SS1M1anlQRGRWVFR3QnhsdWNsYnQ0clRP?=
 =?utf-8?B?MGdteHZIcWRlR1ZwT2VQZHExYmJ0WTZQTUtiOGVmSzd0elRyamd0Z2tzOW5j?=
 =?utf-8?B?dGdUbTU1UG5tNDQvUHJ6UWh2QjMzWE5qdVlHK2FOcGVodm41L2VCTFVhNHNw?=
 =?utf-8?B?Rm00bWZjS25iUHlIU1lBMTVOc0pzSDhrSllId2Joc0ZGMkFsNFRnY3BDb1pV?=
 =?utf-8?B?SDN1VDhjTnhxVXJKWFBXeVZmT28wMmlFMnJCUE14ZE5hMW5kUkNTUFNjVEds?=
 =?utf-8?B?ZVZWWHAxaW1TMXZyQU1QU21udzFhbnVwZ00wLzNFdUI4eVE3ME1GcXhFcmxI?=
 =?utf-8?B?cWN6NlYwV1RqSVkxTU1TMVF1Q0ZFek1GSms4Ykp4VEI4VjN3ZFZ6S2hQNDky?=
 =?utf-8?B?bHpjc1cxWURtZENuV2JjMG8xelNMb0I5UnRoZ2x2WTBoZXFjS0hUeVVQbTRP?=
 =?utf-8?B?aVk0Skp2bWphT0hVTEM1dUJBcDhCVmdkd2JZUnZKMjNXbENmR1dUQ0lhVXZR?=
 =?utf-8?B?STVGZjltVDBQVWxoYU81UDNWaDE3VXlCbS82cm1tQlh3aS9UNmRzNXZNSVgr?=
 =?utf-8?B?YWxuYTM2T0JRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2Q5alY0ZVZJSlB4ZlhzK3FwcmphWUlXeEN1elphRHZucU5UalVuUjU3bHJs?=
 =?utf-8?B?MFdwaERlRTBBTk55Kys5WGRrOGV0VVBmN0sraWc0KzFjeTdHN2pwT0pKYXZj?=
 =?utf-8?B?N3c1cmpoekw0OUZsK1BQZGVuUE44T1NSSmVoRjhNZmh0dnd4U3pydDY2V0VT?=
 =?utf-8?B?VWloTEdhZktUREpnNEdiVWNXcEJkNVI5amMwaXQvaHJjdk1lSmJETTY0SVNI?=
 =?utf-8?B?TnVUS2pBRDFWSTRIK3JzREsxWWJqVERQU0svMTk5Ly9TbDdSZjRNYzh3bFNJ?=
 =?utf-8?B?NEdnTGNrYUJzR3NtUXBCVkVUR2RTazJTdWRCVFF6RmlLSEFnN2RhaiszYkZp?=
 =?utf-8?B?bUV6YzJXbDJaTkdoSEZZYU81Ylp4bTRtaHhtNjZjRVF1ejJBbFR1aWNPYmJx?=
 =?utf-8?B?TzdWcVIybllwT0t0V3BEVU82L3crWFdnZUROV0d2RXQyZE9Mb1pNbm5Xb2NQ?=
 =?utf-8?B?cUZ0YzBqMllodlUvMzBtOXZWM1J4YlQvbGJDcjE3UDVsVWF0S0Mxai9iUFhq?=
 =?utf-8?B?NEw5VkhGWTdHZ2ZSd1p4WWVReGNpRDdudFhGMTBhUC95bnZjWE4wRVlqZDJk?=
 =?utf-8?B?Ni83YmM1QURFYTFWSlJIZWdnang0TEw4MndiZkIwT3VwdDB4MDNFVzZ6OWFn?=
 =?utf-8?B?ZHhHdzZNSDV6amlOL2FRY2Z5WmtrL29TdTdnUmN6bmhwZlVlYm1xeEdIYUtO?=
 =?utf-8?B?bEIwc3FuMDNlSEpsZ2Vkc3FPOW1KUGY0UVZlMUdJUFU4WEtuN3F6KzBUR28x?=
 =?utf-8?B?NThtcHBmeVVvb291ZjI0SVdlMzNXcmpaSjROcERLcXJrSXVaK0g4RFBodUFN?=
 =?utf-8?B?RmZRRGI3UGkxQjdjZnhYWUg3clg5ZnVyUTZvVEQ5T2FKZFpzVEJCL05OejZj?=
 =?utf-8?B?OURsMWZiRWhIR2llVFQyYzEyOGZlQ2FKUTlKZWpVczd4Rlp5cUZKZFozWllN?=
 =?utf-8?B?UFpmalR5YjZNSHBQYitqUHUyR3J2MmlhUUNnTS8xU3FQeDdOMGpQbVhnRHdh?=
 =?utf-8?B?czVzK3A3QnB2enkwQUVTQ1hGL2gySEhUeXB6dmRmN1pDS2N5VHBPYkNtblpX?=
 =?utf-8?B?dlhmVEwyVEhGVmRINWpNS2Z3dFNseWtHYld4ZGpUa21GNzBwc05JS1d5c3lY?=
 =?utf-8?B?NG9FWWsxa1g1Z0ZXQnpUNUVFUWlxQ1pjRTFJSnBQcStNVmVreUhTWExDc2Fu?=
 =?utf-8?B?TkNkUjlCU3EwZURsQVNOL1ZIYTJDSGJCUEFzSmV4YjJmVmdGYUVsdEY5MmJr?=
 =?utf-8?B?Rjd0UWVkMjd3cUxQOFFuVDdzcEJyUUVHaDlXVGlIYmRVL3JKWXNiVC9XL1JX?=
 =?utf-8?B?cGxWWi90Z0RyUEtEcDFtVG1EQ3VjcTZ1azZGVkJwc2RMaHIwbWRqN2ZTTmgw?=
 =?utf-8?B?YXhFZDNWaGFUM1ZxdXVZNG5BR3ljMmtDMDdrUXBHWitYM0ExbExJNkZaQklY?=
 =?utf-8?B?Vjh1aEpxMndudmxESE9sdTN5YXo1YzBzeU9WRW1PekNwYzhpeTJWQ2VFVUZw?=
 =?utf-8?B?TEtxbnlzMU1yWi93aW93OXhqZVRsOUdOcFhPTzYwNStUd05CSXhUMGZKa0cv?=
 =?utf-8?B?MStBZFJ5eU50UVZGSFhkcmU5M0VQRUYwbnI3WjF6aFVqVFgzcTlhM0lpOGFV?=
 =?utf-8?B?THdkU1owZVVqZTE2cXJJTVN1ZEF3OGcwalhjVlA2eXBXNkJxMWpMZ3VsRmI3?=
 =?utf-8?B?VVYycE8yUmdNbXBBWExHSEluQjByMDB1SzB5dEJWSjQzeEZPbTd4K1MzelRD?=
 =?utf-8?B?MkVLSVF5YVN6TlBKN0xYamhTMzhKK1lGVU9Jc3F6ZWhsbDJocjBWRi83ZFNy?=
 =?utf-8?B?UXBvdDd0Uk5DeUhzRUdLZTdmbERUM3c0NHkwUXdiNDIyT2Vsdk9jNjQ1RU1Q?=
 =?utf-8?B?Nkh1eEdlWVJDT0EyS1dUcFdDSDYvZzBkNkcxTFFOSGdWcDhiUEkxR1locXp5?=
 =?utf-8?B?czdaNExsRzVYM3FXRXF1L1EyNkJrRTFxanpNNTlkTjhhSnNMZVlRZ0hySVFW?=
 =?utf-8?B?MHhpRkZsNkowd2tXc0lvUFBuMjdxL3duamZkK29YUEw0d3ZJSjVCMlp5MFEy?=
 =?utf-8?B?SFBMUytpRFpqU2VTWG11cnNVUzIrSFRGT2tRUTY2dnpwL2tzZHFXY1ZiazVC?=
 =?utf-8?Q?25dI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bbd5dc-8407-4b4d-4d3e-08ddc3a72837
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 13:54:45.7738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5daszrt9IhOSicI6F0mgNqeMmGlErJvCI5IIXzJsbyhSwzBtbywWKrwgTeAsEOSR3rn+OBGCq0x596LXT3OaHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5j
b20+DQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZngg
PGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4
DQo+IERldWNoZXINCj4gU2VudDogVHVlc2RheSwgSnVseSAxNSwgMjAyNSA5OjQ1IEFNDQo+IFRv
OiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBk
cm0vYW1kZ3B1OiBtYWtlIGNvbXB1dGUgdGltZW91dHMgY29uc2lzdGVudA0KPg0KPiBQaW5nPw0K
Pg0KPiBPbiBUdWUsIEp1biAyNCwgMjAyNSBhdCAxMDozMuKAr1BNIEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGb3Iga2VybmVsIGNv
bXB1dGUgcXVldWVzLCBhbGlnbiB0aGUgdGltZW91dCB3aXRoDQo+ID4gb3RoZXIga2VybmVsIHF1
ZXVlcyAoMTAgc2VjKS4gIFRoaXMgaGFkIHByZXZpb3VzbHkNCj4gPiBiZWVuIHNldCBoaWdoZXIg
Zm9yIE9wZW5DTCB3aGVuIGl0IHVzZWQga2VybmVsDQo+ID4gcXVldWVzLCBidXQgbm93IE9wZW5D
TCB1c2VzIEtGRCB1c2VyIHF1ZXVlcyB3aGljaA0KPiA+IGRvbid0IGhhdmUgYSB0aW1lb3V0IGxp
bWl0YXRpb24uIFRoaXMgYWxzbyBhbGlnbnMNCj4gPiB3aXRoIFNSLUlPViB3aGljaCBhbHJlYWR5
IHVzZWQgYSBzaG9ydGVyIHRpbWVvdXQuDQo+ID4NCj4gPiBBZGRpdGlvbmFsbHkgdGhlIGxvbmdl
ciB0aW1lb3V0IG5lZ2F0aXZlbHkgaW1wYWN0cw0KPiA+IHRoZSB1c2VyIGV4cGVyaWVuY2Ugd2l0
aCBrZXJuZWwgcXVldWVzIGZvciBpbnRlcmFjdGl2ZQ0KPiA+IGFwcGxpY2F0aW9ucy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4NCj4gPiAtLS0NCj4gPg0KPiA+IFYyOiBmaXggZG9jdW1lbnRhdGlvbiBhcyB3ZWxsDQo+ID4N
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMTIgKyst
LS0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyAg
ICB8IDEwICsrKysrLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDE1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYw0KPiA+IGluZGV4IGM4YTZiMzY4OWRlYWUuLjU4YTBlZTk5ZWIyZjgg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
DQo+ID4gQEAgLTQxNzEsMTggKzQxNzEsMTAgQEAgc3RhdGljIGludA0KPiBhbWRncHVfZGV2aWNl
X2dldF9qb2JfdGltZW91dF9zZXR0aW5ncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4g
PiAgICAgICAgIGludCByZXQgPSAwOw0KPiA+DQo+ID4gICAgICAgICAvKg0KPiA+IC0gICAgICAg
ICogQnkgZGVmYXVsdCB0aW1lb3V0IGZvciBub24gY29tcHV0ZSBqb2JzIGlzIDEwMDAwDQo+ID4g
LSAgICAgICAgKiBhbmQgNjAwMDAgZm9yIGNvbXB1dGUgam9icy4NCj4gPiAtICAgICAgICAqIElu
IFNSLUlPViBvciBwYXNzdGhyb3VnaCBtb2RlLCB0aW1lb3V0IGZvciBjb21wdXRlDQo+ID4gLSAg
ICAgICAgKiBqb2JzIGFyZSA2MDAwMCBieSBkZWZhdWx0Lg0KPiA+ICsgICAgICAgICogQnkgZGVm
YXVsdCB0aW1lb3V0IGZvciBqb2JzIGlzIDEwIHNlYw0KPiA+ICAgICAgICAgICovDQo+ID4gLSAg
ICAgICBhZGV2LT5nZnhfdGltZW91dCA9IG1zZWNzX3RvX2ppZmZpZXMoMTAwMDApOw0KPiA+ICsg
ICAgICAgYWRldi0+Y29tcHV0ZV90aW1lb3V0ID0gYWRldi0+Z2Z4X3RpbWVvdXQgPSBtc2Vjc190
b19qaWZmaWVzKDEwMDAwKTsNCj4gPiAgICAgICAgIGFkZXYtPnNkbWFfdGltZW91dCA9IGFkZXYt
PnZpZGVvX3RpbWVvdXQgPSBhZGV2LT5nZnhfdGltZW91dDsNCj4gPiAtICAgICAgIGlmIChhbWRn
cHVfc3Jpb3ZfdmYoYWRldikpDQo+ID4gLSAgICAgICAgICAgICAgIGFkZXYtPmNvbXB1dGVfdGlt
ZW91dCA9IGFtZGdwdV9zcmlvdl9pc19wcF9vbmVfdmYoYWRldikgPw0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKDYwMDAwKSA6IG1z
ZWNzX3RvX2ppZmZpZXMoMTAwMDApOw0KPiA+IC0gICAgICAgZWxzZQ0KPiA+IC0gICAgICAgICAg
ICAgICBhZGV2LT5jb21wdXRlX3RpbWVvdXQgPSAgbXNlY3NfdG9famlmZmllcyg2MDAwMCk7DQo+
ID4NCj4gPiAgICAgICAgIGlmIChzdHJubGVuKGlucHV0LCBBTURHUFVfTUFYX1RJTUVPVVRfUEFS
QU1fTEVOR1RIKSkgew0KPiA+ICAgICAgICAgICAgICAgICB3aGlsZSAoKHRpbWVvdXRfc2V0dGlu
ZyA9IHN0cnNlcCgmaW5wdXQsICIsIikpICYmDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kcnYuYw0KPiA+IGluZGV4IDdlM2ZhNzYyMjcwMzMuLjdiYzMyNmQwYjQwMDAg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
DQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4g
QEAgLTM2MiwxMiArMzYyLDEyIEBAIG1vZHVsZV9wYXJhbV9uYW1lZChzdm1fZGVmYXVsdF9ncmFu
dWxhcml0eSwNCj4gYW1kZ3B1X3N2bV9kZWZhdWx0X2dyYW51bGFyaXR5LCB1aW50DQo+ID4gICAq
ICAgVGhlIHNlY29uZCBvbmUgaXMgZm9yIENvbXB1dGUuIFRoZSB0aGlyZCBhbmQgZm91cnRoIG9u
ZXMgYXJlDQo+ID4gICAqICAgZm9yIFNETUEgYW5kIFZpZGVvLg0KPiA+ICAgKg0KPiA+IC0gKiBC
eSBkZWZhdWx0KHdpdGggbm8gbG9ja3VwX3RpbWVvdXQgc2V0dGluZ3MpLCB0aGUgdGltZW91dCBm
b3IgYWxsIG5vbi0NCj4gY29tcHV0ZShHRlgsIFNETUEgYW5kIFZpZGVvKQ0KPiA+IC0gKiBqb2Jz
IGlzIDEwMDAwLiBUaGUgdGltZW91dCBmb3IgY29tcHV0ZSBpcyA2MDAwMC4NCj4gPiArICogQnkg
ZGVmYXVsdCh3aXRoIG5vIGxvY2t1cF90aW1lb3V0IHNldHRpbmdzKSwgdGhlIHRpbWVvdXQgZm9y
IGFsbCBqb2JzIGlzIDEwMDAwLg0KPiA+ICAgKi8NCj4gPiAtTU9EVUxFX1BBUk1fREVTQyhsb2Nr
dXBfdGltZW91dCwgIkdQVSBsb2NrdXAgdGltZW91dCBpbiBtcyAoZGVmYXVsdDogZm9yDQo+IGJh
cmUgbWV0YWwgMTAwMDAgZm9yIG5vbi1jb21wdXRlIGpvYnMgYW5kIDYwMDAwIGZvciBjb21wdXRl
IGpvYnM7ICINCj4gPiAtICAgICAgICAgICAgICAgImZvciBwYXNzdGhyb3VnaCBvciBzcmlvdiwg
MTAwMDAgZm9yIGFsbCBqb2JzLiAwOiBrZWVwIGRlZmF1bHQgdmFsdWUuDQo+IG5lZ2F0aXZlOiBp
bmZpbml0eSB0aW1lb3V0KSwgZm9ybWF0OiBmb3IgYmFyZSBtZXRhbCBbTm9uLUNvbXB1dGVdIG9y
DQo+IFtHRlgsQ29tcHV0ZSxTRE1BLFZpZGVvXTsgIg0KPiA+IC0gICAgICAgICAgICAgICAiZm9y
IHBhc3N0aHJvdWdoIG9yIHNyaW92IFthbGwgam9ic10gb3IgW0dGWCxDb21wdXRlLFNETUEsVmlk
ZW9dLiIpOw0KPiA+ICtNT0RVTEVfUEFSTV9ERVNDKGxvY2t1cF90aW1lb3V0LA0KPiA+ICsgICAg
ICAgICAgICAgICAgIkdQVSBsb2NrdXAgdGltZW91dCBpbiBtcyAoZGVmYXVsdDogMTAwMDAgZm9y
IGFsbCBqb2JzLiAiDQo+ID4gKyAgICAgICAgICAgICAgICAiMDoga2VlcCBkZWZhdWx0IHZhbHVl
LiBuZWdhdGl2ZTogaW5maW5pdHkgdGltZW91dCksIGZvcm1hdDogZm9yIGJhcmUgbWV0YWwNCj4g
W05vbi1Db21wdXRlXSBvciBbR0ZYLENvbXB1dGUsU0RNQSxWaWRlb107ICINCj4gPiArICAgICAg
ICAgICAgICAgICJmb3IgcGFzc3Rocm91Z2ggb3Igc3Jpb3YgW2FsbCBqb2JzXSBvciBbR0ZYLENv
bXB1dGUsU0RNQSxWaWRlb10uIik7DQo+ID4gIG1vZHVsZV9wYXJhbV9zdHJpbmcobG9ja3VwX3Rp
bWVvdXQsIGFtZGdwdV9sb2NrdXBfdGltZW91dCwNCj4gc2l6ZW9mKGFtZGdwdV9sb2NrdXBfdGlt
ZW91dCksIDA0NDQpOw0KPiA+DQo+ID4gIC8qKg0KPiA+IC0tDQo+ID4gMi40OS4wDQo+ID4NCg==
