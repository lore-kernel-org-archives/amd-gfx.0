Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB6DC5472C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 07:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374B010E219;
	Tue, 20 Aug 2024 07:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2gQeuo1t";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4419010E219
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 07:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFiDSm9U9gi/1N4RqhNfTuF23++b5kVAxfr7ztV1X9AS1z5wwSZYMK16A8N7nv/1X8HERz1p+JDiB+0UPohQnRFkaXhxzUwg7LRld2LyEefyuRvLHIdBlX9/0IQQLTb+Qrc/xKn/Wx+3fgUaMvNk7kYe/OUHxS6qXJNhlH61CwxlstOFsYtUorkxloOkW4D1C1myMEUiatZPhLnRHiT8tx520Nv6+2ZE93/tzOKq0sXSU3txVYvS4djwmP8BydBOBcI0X7C9e/6xKi+mrjW8ErlF1EYQPXHw4qQsYC+3r+oYVUWCUMW81HNYvxTxmI3zrfkPh8ldIx+bzpfeaceZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuLM+8vgT9UXfg9t9nwEPoXQ2Dao6IdeWQikcRMnNJo=;
 b=zFuPJZzLlJNR1aS8hOIn2fd/FvCjUH1DgyF1UAcraNNMLuxzma14Jt6AZ9hvjI+uJfIVB/tjlzsd3Ujy6qWIxVuQWybljLC2NpBquiDvwadIxLgZWLEwD9iUIoJwxKRaOy+UdBhfiTH/69b0AEbZSxeEPV1/0qwlmTuiFi+PPlSPqPIEmrXJAvQ6A3ajY5n0Tc15t56sC+PUAxoAoOoEZTRB5YaASj9sTEZHWODXGNgJ6S0SeJoYIsQU4gWC86R/eT1GQ0rcQ4/fBtyFc42uNeQUs/x4ESWDbVLr44djaNejl+IodUK15y1R26drA05EjlyJJ3/ToRWde8ceIBRHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuLM+8vgT9UXfg9t9nwEPoXQ2Dao6IdeWQikcRMnNJo=;
 b=2gQeuo1tsxUEdt1yodE8lD431x7QyPdClBdbUgo/KaWZFxhkwngsEDdufCEWWkPwYkmjJXLYxJQYofJDYN9sUyGEFZ7rh+0j3+nM94UBA3gorkzLd85wDLNXi80Q6tqlGPewTRPwBzzTnhammsgF/RvUXAdgHtKR41JBmMvYERM=
Received: from SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.26; Tue, 20 Aug
 2024 07:30:44 +0000
Received: from SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78]) by SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:30:44 +0000
From: "Huang, Trigger" <Trigger.Huang@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job tmo
Thread-Topic: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job tmo
Thread-Index: AQHa8h2zBtFNuK9UPk+2ajX3XgSXtLIuYXgAgAFMKwA=
Date: Tue, 20 Aug 2024 07:30:44 +0000
Message-ID: <SA1PR12MB7442E8D1DB91114A51FC9EB0FE8D2@SA1PR12MB7442.namprd12.prod.outlook.com>
References: <20240819095331.460721-1-Trigger.Huang@amd.com>
 <20240819095331.460721-3-Trigger.Huang@amd.com>
 <a0978549-9bd3-e985-76eb-f50115f76bf4@amd.com>
In-Reply-To: <a0978549-9bd3-e985-76eb-f50115f76bf4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c9cb4fc5-bed1-4c40-8fb5-ad9fa1edca9b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-20T06:19:38Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7442:EE_|SJ2PR12MB7990:EE_
x-ms-office365-filtering-correlation-id: 7f2d3a1d-ea5e-4a16-6e0a-08dcc0ea006c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eEJkSk1nWWhWV1JLeDhpZVN0YXhraEpvRjVwbW92TzM3OHk3VDlWdk05OXhK?=
 =?utf-8?B?SmcwZkplZGRWNXN0V25HU2MvR056QnE4QUNXampkOVVrVUlDZGFiWGJlYml1?=
 =?utf-8?B?b3lDYnVkNnhnc1crMHhRUlhXbHA1RXRIQkg4TVlKcU1XSyt5VS9HazRXR2Ns?=
 =?utf-8?B?R0ticVBiOGV0Qlh5bVhXT3l5VXVPU1pDcCtOVFBBc3lyOVJmQ083QVlCNkN5?=
 =?utf-8?B?RlpYOXJ1bm9ReDBEN1dlTGk1UDJ4cFY5WVRmdXllSVlpdDg2UWEwL0NOalBM?=
 =?utf-8?B?cTFFa25LcWdJbFkzaWI4cWZlaTBQbm5LSGQ0aFUzWG40M3VsczNLaitIL0F1?=
 =?utf-8?B?OHN3Vkh2YS9DVFRjSEhGR3ZuTFpFSnBQRmFpRXZvd21HbnNKYVFmQy9BdlBl?=
 =?utf-8?B?bGNLdkZ2QjZCV015SlRYaExveHBFK0JkSHJmWWx2WGVzTVJpVTArOURqeGda?=
 =?utf-8?B?OXEwUlVSQ0FpSHB4bFQ5ZDUxZ2dXUmpVZE10WmhaRzFNM2d0eDZWbXdmdW5W?=
 =?utf-8?B?Um16MjBrRXdpdkxyMEtqbVhSMGljNDlqbzFIaXMvZmtjK00rY2lkS0tBVWlq?=
 =?utf-8?B?Z2FxbzZqZzYzemJzNHIwTHA4VHNDbU1JalUxQ1RXek4zZVA1a3NMZ3hGYXho?=
 =?utf-8?B?dGg3Q0dLV21PdlpUY1d0b2xTZlJNaHRIbmFjLzZ3Rk1oc0d4N3RMUTgxZ3F5?=
 =?utf-8?B?eU9Vc2x2cGRQaHlYOFUySmtzOFFWWE5iL3E1LzVoL28zTFlqY2ZXR01GS0xj?=
 =?utf-8?B?YnRTZXNibU02MlhXck1hUnJBTHRWcW12Mm1kMWRsVERQclVyalJsR3E3VkI4?=
 =?utf-8?B?SGI4cHViUzFRNzRITG56cXZNdEhDNzJOV0dPNVdvTUlMcEZkWHFwYWRMTDU0?=
 =?utf-8?B?RzdHUzAzNmhrRXJGTXFVeHI3QUJVMHUwRGdHd0lMYW5WamZ0SVRTUjBmdmpW?=
 =?utf-8?B?TTcyMUhvSFl0aTUyYUZoRXdkOU5MTTZKZkE5dzFtQ3BsUURKV1FmamNoSWND?=
 =?utf-8?B?WFRFQnc4ZUpidEF5SXcvMHI5T0dreEhxZGwrUU5aSGJLV0FwVHNQOWY4ODcx?=
 =?utf-8?B?VmwvdFhlYnFoTmVqazFoR0NnYjVXUmlBaFdvU1Z0aGxGYjZuUTlCbGlpY1Rp?=
 =?utf-8?B?NWQrRGdZTUJhcUtNV1JPcEV4Z2pWWXJudkFFVVU5SFhIQ082T1JVQU9WYWdZ?=
 =?utf-8?B?eFp6QnE4YXB5UXc5S2pTekNVdG1BaXpLWnpaeHRvRmNRY1RmQXg2MEE3WEpt?=
 =?utf-8?B?dWNKTllYOEF4WTVyUFJ5enExZVBGM2FPSVV3TWRtTWpVQ1ZrTlUxbE9seTRX?=
 =?utf-8?B?VFBmMDVLSkRRVFJFdWRveTZyRU03Yk1Yc01hSmdhRXlDbnpIU014dkRpT3Nq?=
 =?utf-8?B?b0hpNDZlVVNGaWxwektHdTk4QmtDVTR1bWZOUmdySlpOaXdiOE5HMHBVeUNh?=
 =?utf-8?B?Y0wreFlQamxKVDZBK3Y5aUNWUVVxYitJa2swMldOZXI1QmtWMDdIS2crQTFM?=
 =?utf-8?B?K0RWTW9yWjdUb1JvUm8vbkJJdWE5UlpkWXhmdUcwcWJmZmNsYXMvOW9rM20v?=
 =?utf-8?B?U2lOaHZmUGpuS0wvRW9vemg0L0NoZVpOcm9wbVZZMjBqeDhkaG9kcEc3Q1Fx?=
 =?utf-8?B?b29jRXg4cXlsWGU5VnRPSGFtYk8ydGJNcTVtbUI3MnJ4LzNCcFRIenYxZGNm?=
 =?utf-8?B?eU5jWkRpYTIwTGFUMDkzVmU0QXg0elllbU5ZUGJCdGFsQ29IUnhQWGIxYnJz?=
 =?utf-8?B?cHNxQVNuM2pZd0NzOGZ5TlZVK2gwNXRMS3FZaU5kZUtMYS94eU53c1E0V1NF?=
 =?utf-8?B?bk5WdDNuSEtaRUQrY1g0VU5pSzVHSE1aU1hQaHhpZG9OOFExWldkdE9QZ3FP?=
 =?utf-8?B?dDhlYlJHQ1pYRHM3L056djdLdmhYaGFFU2JGSWkwQXVZRHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TStlMGVuU0FaNE41VXBxZTIveW5BeEYzdWR1TW5YQTZkRk5WZ1R4bVM0MjJ5?=
 =?utf-8?B?MlZCUm1PczRCQTlmRWc5VCsyMjdISkIrZXJSMFRhTEhWRmZWOTQ3NThBd09R?=
 =?utf-8?B?S0hIQVgvVHlOUWNjYnVGL2YxeURMS1JDOVhrRGUzVFdza2x6YUJRY1J6ajhN?=
 =?utf-8?B?dmNpZWRIZmw3WlVLYkNIQ0tXbVNrREh1OTRCZzBNMEJpM0U2V1I1cDFNMnlz?=
 =?utf-8?B?Y1E2dFF1dy82dmpLdUxLY2lTSUgwUE9CUDU1TEhOVXVLcVhONmRKKzJFbndx?=
 =?utf-8?B?NFFlSFlLOW5pTHBuNEJTcmJ6UUJERlUyaGM2Rm40MldyQ0JOeGlDUWpJVDVV?=
 =?utf-8?B?VUlLZVl6OWkxNmpCUnhHOUNFc0JsUHZXTkxjaUJkb2szOWJnNHRYTzdaN0hW?=
 =?utf-8?B?T0w4OHgyd1k4aU9GNGNXVTVManhmMjhHcE9rRlptV1FsbTlsSEMvWTBaOEdC?=
 =?utf-8?B?NXRCZjh2cmxnVTQ4aTRsNm5IL2h1TktUS3diN01XTTlzekxiQ3ArNTB1TlA0?=
 =?utf-8?B?L2daRkxCemtSdWJxaHVBVHNKK0dVL0U2SUZ4OFVVVjFrTTNGdm9ZcytVdXJk?=
 =?utf-8?B?b1liK1dnR2NUajBmZFVydmlZWG9LWWxzS08yMTZLSGxBY2o0MDhKSWNrdUJj?=
 =?utf-8?B?aWpPVHZ5Y3lHNjVOc0MxNC9pdmNLcnMzY2xObERVQkhMcDAvb2FPOEpiSWky?=
 =?utf-8?B?VmMzZlFZNEVTVUFucENzdWFwZ2E2UlBrZUVEUURzTm1KYWhwSUNvdjRobmNa?=
 =?utf-8?B?d09LQkVMRW84UFlKclRKOU95c2RoWWtvTVJRYnVwbitiK05VQ2pINGJrWVVU?=
 =?utf-8?B?cjVoU0hXK01nUE9QcmNNUUpqbzJ0a2VIU2FhaTZpKzJGUkN3Z0dUQ2dDakFh?=
 =?utf-8?B?dzVLbjRtaXYzVVJ0Y2pZOTdaUXVETTRlLy9tUEdldDRoMFcyaUlsZUFOS1pB?=
 =?utf-8?B?WXFOR1RLN2k5RVY5aFNuQUFtZDFFWGtXR1dBM2d0cEsxRzd3MTNpaDcrYi9W?=
 =?utf-8?B?cTYwams5ZXFBdm5ZNnBqZGRuYTduNTVQeDFyT0pPak5wMUMwd0lkei9ndzZG?=
 =?utf-8?B?USs0YkxnOTNvSTRSYmR5U1NZRGJodHVseDZheFFLTVBseHJ6dmhsTnI5QVY1?=
 =?utf-8?B?YVNsV0JobGpsbTc5V0RsYnZNSWUvdXlTZVdZV1FCQVM4eHltZXgxQlJ5cWVs?=
 =?utf-8?B?cU9rR1phM0tzdExqaWdBejMzeHhxVFZKMEo5bXQ0M2k1YUo3K1lpY1l4V3Q1?=
 =?utf-8?B?U2MwWElVcHVIWkNPb1lTOXU1TkI4cG01a2gwVzhiK21ZcFVxeWJjVStOK0Zr?=
 =?utf-8?B?cC9BcTFBQlRwb0tkd2VwNVBYM0hwZExOc2ZCZXU5cnFJTnpKWDY0ZzUxcDNu?=
 =?utf-8?B?T2twUWtPclRXQW5MVmloMjRvVC9oRktZRTVRSjlmMHZ1TTUxMGFzSVNGQWJs?=
 =?utf-8?B?Q1RTNnFUL29FRHhjWUw4UUdsbVBxeEZuYjY4L010b1VqQlgvYnFoOEJNb0sy?=
 =?utf-8?B?ZjJ4dGp3dlJ4UnpmQVVVQ0txTWtOSG5sU0djbER1ZVE5N2lDdStoMTlCby9M?=
 =?utf-8?B?QmFmemVhSWhWbkRPQ0NIZ1A1QmliUE5ENEc3anYzazIwQzFTamhEL09FU21k?=
 =?utf-8?B?NjlJdmJGQ0UrSDIzMDZZbys2WFNjbjg4UDhheU5QTU1wTVE0QklTa2pEc2g2?=
 =?utf-8?B?STRiSUpjRkNvTkFrcFdDR1RFOWlscDE3VHJ5SzdvMmxUQW9xdnlYc1htYVBW?=
 =?utf-8?B?VHVmNmRhWjBpdXNHYXpVcFhHeEJqZWdMUHQrdnpzdkdQOHFYc0lMa2VMWm96?=
 =?utf-8?B?T2VMc1JjSU85YzZhV1crS0ZyQ1VKaEZGTXFvTnVCWnZ4cCt2U0laajBqb01z?=
 =?utf-8?B?amZPaXcvU2c4Ui9kNkVoMGl3eG1KUXR6dWk3Wlk1MlA0aFdMZ0J4eFlxOUZY?=
 =?utf-8?B?MmFFUHJ0N2xNdm5UWVBVaFBSM050V2RkWENqUklrMWFTMjIxWjdTZUFaejVN?=
 =?utf-8?B?M0daZG5SRTQwWThQdlJSZk5LSWZNbTlna2tPd0xZemJralNua2dyakpRQ3pt?=
 =?utf-8?B?aFBvbXkxN3grVm1PTGJYeHozak5qalRpQkhWV050YjdSVXZNcFg0UU1tb3dX?=
 =?utf-8?Q?J8Gc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2d3a1d-ea5e-4a16-6e0a-08dcc0ea006c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 07:30:44.1174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJibgUGhMuiAIqvAHrlKhrEgnxfzMdEsG7vACBCtWWgKt69nRm6ajEZpxdUR6MZfEiFIDgCtpqSPl2h9aw8DOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLaGF0cmksIFN1bmlsIDxT
dW5pbC5LaGF0cmlAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMTksIDIwMjQgNjoz
MSBQTQ0KPiBUbzogSHVhbmcsIFRyaWdnZXIgPFRyaWdnZXIuSHVhbmdAYW1kLmNvbT47IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1k
Z3B1OiBEbyBjb3JlIGR1bXAgaW1tZWRpYXRlbHkgd2hlbiBqb2INCj4gdG1vDQo+DQo+DQo+IE9u
IDgvMTkvMjAyNCAzOjIzIFBNLCBUcmlnZ2VyLkh1YW5nQGFtZC5jb20gd3JvdGU6DQo+ID4gRnJv
bTogVHJpZ2dlciBIdWFuZyA8VHJpZ2dlci5IdWFuZ0BhbWQuY29tPg0KPiA+DQo+ID4gRG8gdGhl
IGNvcmVkdW1wIGltbWVkaWF0ZWx5IGFmdGVyIGEgam9iIHRpbWVvdXQgdG8gZ2V0IGEgY2xvc2Vy
DQo+ID4gcmVwcmVzZW50YXRpb24gb2YgR1BVJ3MgZXJyb3Igc3RhdHVzLg0KPiA+DQo+ID4gVjI6
IFRoaXMgd2lsbCBza2lwIHByaW50aW5nIHZyYW1fbG9zdCBhcyB0aGUgR1BVIHJlc2V0IGlzIG5v
dCBoYXBwZW5lZA0KPiA+IHlldCAoQWxleCkNCj4gPg0KPiA+IFYzOiBVbmNvbmRpdGlvbmFsbHkg
Y2FsbCB0aGUgY29yZSBkdW1wIGFzIHdlIGNhcmUgYWJvdXQgYWxsIHRoZSByZXNldA0KPiA+IGZ1
bmN0aW9ucyhzb2Z0LXJlY292ZXJ5IGFuZCBxdWV1ZSByZXNldCBhbmQgZnVsbCBhZGFwdGVyIHJl
c2V0LCBBbGV4KQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVHJpZ2dlciBIdWFuZyA8VHJpZ2dl
ci5IdWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2pvYi5jIHwgNjINCj4gKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMNCj4gPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYw0KPiA+IGluZGV4IGM2YTE3ODNmYzllZi4uZWJi
YjE0MzQwNzNlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9qb2IuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9q
b2IuYw0KPiA+IEBAIC0zMCw2ICszMCw2MSBAQA0KPiA+ICAgI2luY2x1ZGUgImFtZGdwdS5oIg0K
PiA+ICAgI2luY2x1ZGUgImFtZGdwdV90cmFjZS5oIg0KPiA+ICAgI2luY2x1ZGUgImFtZGdwdV9y
ZXNldC5oIg0KPiA+ICsjaW5jbHVkZSAiYW1kZ3B1X2Rldl9jb3JlZHVtcC5oIg0KPiA+ICsjaW5j
bHVkZSAiYW1kZ3B1X3hnbWkuaCINCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGFtZGdwdV9qb2Jf
ZG9fY29yZV9kdW1wKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9qb2IgKmpvYikNCj4gPiArew0KPiA+
ICsgICBpbnQgaTsNCj4gPiArDQo+ID4gKyAgIGRldl9pbmZvKGFkZXYtPmRldiwgIkR1bXBpbmcg
SVAgU3RhdGVcbiIpOw0KPiA+ICsgICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVtX2lwX2Jsb2Nr
czsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAgaWYgKGFkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9u
LT5mdW5jcy0+ZHVtcF9pcF9zdGF0ZSkNCj4gPiArICAgICAgICAgICAgICAgICAgIGFkZXYtPmlw
X2Jsb2Nrc1tpXS52ZXJzaW9uLT5mdW5jcw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAtPmR1bXBfaXBfc3RhdGUoKHZvaWQgKilhZGV2KTsNCj4gPiArICAgICAgICAgICBkZXZfaW5m
byhhZGV2LT5kZXYsICJEdW1waW5nIElQIFN0YXRlIENvbXBsZXRlZFxuIik7DQo+ID4gKyAgIH0N
Cj4gPiArDQo+ID4gKyAgIGFtZGdwdV9jb3JlZHVtcChhZGV2LCB0cnVlLCBmYWxzZSwgam9iKTsg
fQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYW1kZ3B1X2pvYl9jb3JlX2R1bXAoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgYW1kZ3B1X2pvYiAqam9iKQ0KPiA+ICt7DQo+ID4gKyAgIHN0cnVjdCBsaXN0X2hlYWQgZGV2
aWNlX2xpc3QsICpkZXZpY2VfbGlzdF9oYW5kbGUgPSAgTlVMTDsNCj4gPiArICAgc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKnRtcF9hZGV2ID0gTlVMTDsNCj4gPiArICAgc3RydWN0IGFtZGdwdV9oaXZl
X2luZm8gKmhpdmUgPSBOVUxMOw0KPiA+ICsNCj4gPiArICAgaWYgKCFhbWRncHVfc3Jpb3ZfdmYo
YWRldikpDQo+ID4gKyAgICAgICAgICAgaGl2ZSA9IGFtZGdwdV9nZXRfeGdtaV9oaXZlKGFkZXYp
Ow0KPiA+ICsgICBpZiAoaGl2ZSkNCj4gPiArICAgICAgICAgICBtdXRleF9sb2NrKCZoaXZlLT5o
aXZlX2xvY2spOw0KPiA+ICsgICAvKg0KPiA+ICsgICAgKiBSZXVzZSB0aGUgbG9naWMgaW4gYW1k
Z3B1X2RldmljZV9ncHVfcmVjb3ZlcigpIHRvIGJ1aWxkIGxpc3Qgb2YNCj4gPiArICAgICogZGV2
aWNlcyBmb3IgY29kZSBkdW1wDQo+ID4gKyAgICAqLw0KPiA+ICsgICBJTklUX0xJU1RfSEVBRCgm
ZGV2aWNlX2xpc3QpOw0KPiA+ICsgICBpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiAoYWRl
di0NCj4gPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+IDEpICYmIGhpdmUpIHsNCj4gPiAr
ICAgICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCAmaGl2ZS0+ZGV2aWNlX2xp
c3QsDQo+IGdtYy54Z21pLmhlYWQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICBsaXN0X2FkZF90
YWlsKCZ0bXBfYWRldi0+cmVzZXRfbGlzdCwgJmRldmljZV9saXN0KTsNCj4gPiArICAgICAgICAg
ICBpZiAoIWxpc3RfaXNfZmlyc3QoJmFkZXYtPnJlc2V0X2xpc3QsICZkZXZpY2VfbGlzdCkpDQo+
ID4gKyAgICAgICAgICAgICAgICAgICBsaXN0X3JvdGF0ZV90b19mcm9udCgmYWRldi0+cmVzZXRf
bGlzdCwgJmRldmljZV9saXN0KTsNCj4gPiArICAgICAgICAgICBkZXZpY2VfbGlzdF9oYW5kbGUg
PSAmZGV2aWNlX2xpc3Q7DQo+ID4gKyAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgbGlzdF9h
ZGRfdGFpbCgmYWRldi0+cmVzZXRfbGlzdCwgJmRldmljZV9saXN0KTsNCj4gPiArICAgICAgICAg
ICBkZXZpY2VfbGlzdF9oYW5kbGUgPSAmZGV2aWNlX2xpc3Q7DQo+ID4gKyAgIH0NCj4gPiArDQo+
ID4gKyAgIC8qIERvIHRoZSBjb3JlZHVtcCBmb3IgZWFjaCBkZXZpY2UgKi8NCj4gPiArICAgbGlz
dF9mb3JfZWFjaF9lbnRyeSh0bXBfYWRldiwgZGV2aWNlX2xpc3RfaGFuZGxlLCByZXNldF9saXN0
KQ0KPiA+ICsgICAgICAgICAgIGFtZGdwdV9qb2JfZG9fY29yZV9kdW1wKHRtcF9hZGV2LCBqb2Ip
Ow0KPiA+ICsNCj4gPiArICAgaWYgKGhpdmUpIHsNCj4gPiArICAgICAgICAgICBtdXRleF91bmxv
Y2soJmhpdmUtPmhpdmVfbG9jayk7DQo+ID4gKyAgICAgICAgICAgYW1kZ3B1X3B1dF94Z21pX2hp
dmUoaGl2ZSk7DQo+ID4gKyAgIH0NCj4gPiArfQ0KPiA+DQo+ID4gICBzdGF0aWMgZW51bSBkcm1f
Z3B1X3NjaGVkX3N0YXQgYW1kZ3B1X2pvYl90aW1lZG91dChzdHJ1Y3QNCj4gZHJtX3NjaGVkX2pv
YiAqc19qb2IpDQo+ID4gICB7DQo+ID4gQEAgLTQ4LDYgKzEwMyw3IEBAIHN0YXRpYyBlbnVtIGRy
bV9ncHVfc2NoZWRfc3RhdA0KPiBhbWRncHVfam9iX3RpbWVkb3V0KHN0cnVjdCBkcm1fc2NoZWRf
am9iICpzX2pvYikNCj4gPiAgICAgICAgICAgICByZXR1cm4gRFJNX0dQVV9TQ0hFRF9TVEFUX0VO
T0RFVjsNCj4gPiAgICAgfQ0KPiA+DQo+ID4gKyAgIGFtZGdwdV9qb2JfY29yZV9kdW1wKGFkZXYs
IGpvYik7DQo+IFRoZSBwaGlsb3NvcGh5IGlzIGhhbmcgYW5kIHJlY292ZXJ5IGlzIHRvIGxldCB0
aGUgSFcgYW5kIHNvZnR3YXJlIHRyeSB0bw0KPiByZWNvdmVyLiBIZXJlIHdlIHRyeSB0byBkbyBh
IHNvZnQgcmVjb3ZlcnkgZmlyc3QgYW5kIGkgdGhpbmsgd2Ugc2hvdWxkIHdhaXQgZm9yDQo+IHNl
ZnQgcmVjb3ZlcnkgYW5kIGlmIGZhaWxzIHRoZW4gd2UgZG8gZHVtcCBhbmQgdGhhdHMgZXhhY3Rs
eSB3ZSBhcmUgZG9pbmcgaGVyZS4NCg0KSGkgU3VuaWwgLA0KdGhhbmtzIGZvciB0aGUgc3VnZ2Vz
dGlvbiwgYW5kIHRoYXQncyByZWFzb25hYmxlLiBCdXQgbXkgY29uY2VybiBpcyB0aGF0IGFmdGVy
IHNvZnQgcmVjb3ZlcnkgaGFwcGVuZWQsIHRoZSBHUFUncyBzdGF0dXMgbWF5IGNoYW5nZSh0YWtl
IGdmeCA5IGZvciBleGFtcGxlLCBpdCB3aWxsIHRyeSB0byBraWxsIHRoZSBjdXJyZW50IGhhbmcg
d2F2ZSkNCiBBY3R1YWxseSwgaW4gbW9zdCBjYXNlcywgYSByZWFsIHNoYWRlciBoYW5nIGNhbm5v
dCBiZSByZXNvbHZlZCB0aHJvdWdoIHNvZnQgcmVjb3ZlcnksIGFuZCBhdCB0aGF0IG1vbWVudCwg
d2UgbmVlZCB0byBnZXQgYSB2ZXJ5IGNsb3NlIGR1bXAvc25hcHNob3QvcmVwcmVzZW50YXRpb24g
b2YgR1BVJ3MgY3VycmVudCBlcnJvciBzdGF0dXMuDQpKdXN0IGxpa2UgdGhlIHNjYW5kdW1wLCB3
aGVuIHdlIHRyeWluZyB0byBkbyBhIHNjYW5kdW1wIGZvciBhIHNoYWRlciBoYW5nLCB3ZSB3aWxs
IGRpc2FibGUgZ3B1X3JlY292ZXJ5LCBhbmQgbm8gc29mdCByZWNvdmVyeS9wZXItcXVldWUgcmVz
ZXQvSFcgcmVzZXQgd2lsbCBoYXBwZW4gYmVmb3JlIHRoZSBzY2FuZHVtcCwgcmlnaHQ/DQpPbiBt
b3N0IHByb2R1Y3RzLCB0aGVyZSBhcmUgbm8gc2NhbmR1bXAgaW50ZXJmYWNlcywgc28gY29yZSBk
dW1wIGlzIGV2ZW4gbW9yZSBpbXBvcnRhbnQgZm9yIGRlYnVnZ2luZyBHUFUgaGFuZyBpc3N1ZS4N
Cg0KUmVnYXJkcywNClRyaWdnZXINCg0KPg0KPiBBbHNvIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRo
YXQgdGhlIHRhc2tzIHdoaWNoIGFyZSBhbHJlYWR5IGluIHF1ZXVlIGFyZSBwdXQNCj4gb24gaG9s
ZCBhbmQgdGhlIHRoZWlyIHN5bmMgcG9pbnRzIGFyZSBzaWduYWxsZWQgYmVmb3JlIHdlIGR1bXAu
DQo+IGNoZWNrIG9uY2Ugd2hhdCBhbGwgc3RlcHMgYXJlIHRha2VuIGJlZm9yZSB3ZSBkdW1wIGlu
IHRoZSBjdXJyZW50DQo+IGltcGxlbWVudGF0aW9uLg0KDQpEbyB5b3UgbWVhbiBzb21ldGltZXMg
bGlrZToNCiAgICAgICAgZHJtX3NjaGVkX3dxdWV1ZV9zdG9wKCZyaW5nLT5zY2hlZCk7DQogICAg
ICAgIGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbihyaW5nKTsgLy8gU2luY2Ug
dGhlcmUgaXMgbm8gR1BVIHJlc2V0IGhhcHBlbmVkLCBpcyBpdCByZWFzb25hYmxlIHRvIGNhbGwg
aXQgaGVyZT8NCiAgICAgICAgYW1kZ3B1X2pvYl9jb3JlX2R1bXAoYWRldiwgam9iKTsNCg0KDQpS
ZWdhcmRzLA0KVHJpZ2dlcg0KDQo+DQo+IFJlZ2FyZHMNCj4NCj4gU3VuaWwga2hhdHJpDQo+DQo+
ID4NCj4gPiAgICAgYWRldi0+am9iX2hhbmcgPSB0cnVlOw0KPiA+DQo+ID4gQEAgLTEwMSw2ICsx
NTcsMTIgQEAgc3RhdGljIGVudW0gZHJtX2dwdV9zY2hlZF9zdGF0DQo+IGFtZGdwdV9qb2JfdGlt
ZWRvdXQoc3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9iKQ0KPiA+ICAgICAgICAgICAgIHJlc2V0
X2NvbnRleHQuc3JjID0gQU1ER1BVX1JFU0VUX1NSQ19KT0I7DQo+ID4gICAgICAgICAgICAgY2xl
YXJfYml0KEFNREdQVV9ORUVEX0ZVTExfUkVTRVQsICZyZXNldF9jb250ZXh0LmZsYWdzKTsNCj4g
Pg0KPiA+ICsgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICogVG8gYXZvaWQgYW4gdW5u
ZWNlc3NhcnkgZXh0cmEgY29yZWR1bXAsIGFzIHdlIGhhdmUNCj4gYWxyZWFkeQ0KPiA+ICsgICAg
ICAgICAgICAqIGdvdCB0aGUgdmVyeSBjbG9zZSByZXByZXNlbnRhdGlvbiBvZiBHUFUncyBlcnJv
ciBzdGF0dXMNCj4gPiArICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICBzZXRfYml0KEFN
REdQVV9TS0lQX0NPUkVEVU1QLCAmcmVzZXRfY29udGV4dC5mbGFncyk7DQo+ID4gKw0KPiA+ICAg
ICAgICAgICAgIHIgPSBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHJpbmctPmFkZXYsIGpvYiwN
Cj4gJnJlc2V0X2NvbnRleHQpOw0KPiA+ICAgICAgICAgICAgIGlmIChyKQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJHUFUgUmVjb3ZlcnkgRmFpbGVkOiAlZFxu
Iiwgcik7DQo=
