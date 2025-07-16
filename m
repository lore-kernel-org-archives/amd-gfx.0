Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20B8C83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 06:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A99E10E661;
	Wed, 16 Jul 2025 06:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vsRPAYBO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8858C10E661
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 06:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jniNe7b/e15d94un/tA2WlJBcjk9TUnf9kJ8v+BM+kHLOHX+NFOaeNo7Bj/NitbRkkdhiVrchc1vxkqt2nKI/QCuPXrULypqSzYvYt/1ZBYkVm8KnJloODtmPBA5oBbd05zO7zVh4ESTDqEL3ebQ8DR2ZpljT0H4MEPHlJSJNk8df/zyG6O47yxJNImL1V4pBmd4VpniuN/5ES7tWkVBOtm/CuCyDsidxfATmQh59Dpx3igwQ819U/rieLTHTLTT+Oor87xxY/8/F0cMzB6YKaBtDOclE2Lz728iddeoinN/uEs4EHdE5xoQts4DfRObSWGeSESRMq9Lv3X4MGRcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfkpyszzemXKaij80oZ/mgd4Zu3kfdVzme4rdg3b+hs=;
 b=gaECw062BI0k9AtpQOC0IY7+nhhIxiLqikuPyABhStO8CJrT1096odnN9RNGntEfHGCTd2b4pjB0/IO7cY6YnekuySIODsNbIHTbbN/dQRvTxmyOCkW+oaCxKEM5agIGI1+ylaoA1pg8VHmFP/QZUz+HixgXYnWgHxhSjI3/ztGW7EOA1Yz/qY2pmWeG3Q6fcnFkxgmMCvD8X2b2UJtn874IM3s8+uoiFRQ1nW4CY+G7h6V4pjGHUreslKXe+uf8NJEn5M7hRoqBVNt2iy7RMOuv2T8EneBcSkxtYbhI/jrBVSm82khHTZt0D30NS9d1ZB5WtzkatSNCUC+ATsZz/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfkpyszzemXKaij80oZ/mgd4Zu3kfdVzme4rdg3b+hs=;
 b=vsRPAYBO9xajUwDDAIoJsWYqngvCjppgVhWHmxTdtWKgz+9izbRKQBvPak8ZANheksLeAlSHzGf6D/D7HMmjOinqLO0SD9hxYLMEozGNF2a/0xTPSecX3HS6waUxeKN+ZXbWmMYAGbvknAt91hvGJ1qwxK3QXxr83nTIxPlJy7Y=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 06:54:22 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.034; Wed, 16 Jul 2025
 06:54:22 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v6 06/11] drm/amdgpu: track the userq bo va for its obj
 management
Thread-Topic: [PATCH v6 06/11] drm/amdgpu: track the userq bo va for its obj
 management
Thread-Index: AQHb8kfAwP2djJW01kemEhcjO4364LQs1S6AgAZFFoCAAAYlAIABNQ8w
Date: Wed, 16 Jul 2025 06:54:22 +0000
Message-ID: <DS7PR12MB6005E31BEA9B8C09D9687D89FB56A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-6-Prike.Liang@amd.com>
 <f391283e-8e3c-4d07-9da4-8bfac73342b5@amd.com>
 <DS7PR12MB6005F4C0545356AE60FB5606FB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <42756550-1e01-45e6-9103-46ee6c689811@amd.com>
In-Reply-To: <42756550-1e01-45e6-9103-46ee6c689811@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-16T06:44:08.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|BL4PR12MB9482:EE_
x-ms-office365-filtering-correlation-id: c52fd8eb-1a80-4c9b-46cf-08ddc4359830
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?ZjA4NkxGNGdBTWEycm9yaFVncGd6TnpXeCsrZHIxR08veDB6YzJxU3dVVmhk?=
 =?utf-8?B?c3NJa1ZmTy9EVndxVTdBcXU3dkZmRzNuc24ybzJtNk1uRHJ1dHBNZTJTSC9M?=
 =?utf-8?B?MUJnSncxWVlBeEMrekE3YVlhVjRjNnRxbkliUUR2M29uK1ZQbkg5WDBPdy9F?=
 =?utf-8?B?NjQwWnNVYmhRb0puUzdFbnZlNExxbnBWeUxqR2ZMR1RrRExYRHliMkFrMklo?=
 =?utf-8?B?UWVBeW9Bb2NTOEk0bndBbitIV0p5YTRJVGZpUmpYeWFGRGYxYzJKK1R2TFRo?=
 =?utf-8?B?RmRCRDJpbVUzZ2hiRDlFNWkxZGJGYmFhUkZJWDVvZU85eThySlgvWTEyT2U1?=
 =?utf-8?B?UGN1bWlzK0IxQTdWUnVPZEpISVdBT21wVkRwSzd4RmpFODBKTE1qVFE0b2Ru?=
 =?utf-8?B?OXoyV2Q3ZmVlTU1YbGllRHAxbjBvWDFRNmZkVEFOR05IcU5OY2JiSDFqaG8w?=
 =?utf-8?B?QUREYmNNYWgzeHBKalJiWUJ6dEtWRkRBdlZPZlB1Z08ram9OVTZoaDNVWWJ3?=
 =?utf-8?B?dEJ3UUZWMUVwV01HN2diMTYrOWpXVUtaZmZYYmlzREsyUTBPNWQxcUlQUE92?=
 =?utf-8?B?M3lvMXVXUUg2NXUydkpzSk5wdFRMWjBDL2dLMks2N3pXbWJBWXlkTlZMaWtS?=
 =?utf-8?B?UDE2SEdZV09DL01KV2JIL2dDMGcvSUtLM3JUcHhQMWluQmE0aTZVTUV0Vmkw?=
 =?utf-8?B?TERHSmZ1Yk82aHd2ZG1qSXB4NEZtb2orSnFOOG03a0orSTNEeSttQkdUeVgw?=
 =?utf-8?B?VGFDQ09zdEEyLzROYVZ2QU9Nam04N2lQclVuOFRmYXhEV3JGOTYwcDFMaEo5?=
 =?utf-8?B?RlF4NHNlK3FEcTRXVVZ2Myt2UDk5Y1ZIcCtROVVSU0JuckJMRjVKNHhET2FD?=
 =?utf-8?B?cW0vVWk2WXkrSjFSMGR4N2dTU0FrNVRFQnpVMUlheVFob1VyTlJGVTVpaTlJ?=
 =?utf-8?B?WUUxcW9VOFNkZmN3UHBXZ3k5SmpxWE5WbWJJSWlOUm5NRUVjWE8wMTJDazU5?=
 =?utf-8?B?VFQ2ZXF3eGxQUm9ZK2h3eFlVdmxvVzdJb011Ykt4UlN1OWZGTkVPMVdXWnVw?=
 =?utf-8?B?c0Y2ekI0Q2FoWXNmK2toK2o3NlRiVUFUZzJHVm9ZeTV6Y1ZFYlk4b2xkSEhi?=
 =?utf-8?B?RlNva2lMUlVlb1p5OHQ3K0RvOFJZMTlMS25EcmRianNNVkdFWjZ0MlZPaU16?=
 =?utf-8?B?T21zWThSK0lmQjdxcXd3OFRydWtla3VNSDlJUGdHMDhSdUlXUjFQOGJYUThS?=
 =?utf-8?B?Nm4rS1dOdlNneGdrREVycFdlSHVRUTd5d0l4dUJRZHNEbk1XZHZmU1VYYzVL?=
 =?utf-8?B?OEtTKzZDWVdQZW5xTnRjL0pFck13aVF0T3o2ZzZwSTJZMkNKVThvSHViUktv?=
 =?utf-8?B?SWRCTm5OZnNTK2dyM0N3U2YrWVdOSFdvSjFYVDFHZ0JkSHlDVmNZM0g0NDZI?=
 =?utf-8?B?MThiaU1MQjFiL0U5ZnNwYXI4RW5qYjRDQURPSUphZU52ZTdKWkZJUE5Dc1pW?=
 =?utf-8?B?c0pQZ0VXS2NpOFEyUnRLdmJFN1dPdHZseW9kaEU4THhCSVZsczJHeHdpQ1Y5?=
 =?utf-8?B?dHRPZGp0czUxTzRnMDhyK202MUFPZEUxem1NSFluVFFKb3NOT0FaOExTRmI0?=
 =?utf-8?B?OG84d0ptbWYzaVNqM3N2VHBQMnNieDlLMElFRzZRS0RWTWNNM2ptdTBGN0VQ?=
 =?utf-8?B?a01tdnBpK0dPMUxOenR1cG1ENkJJanFUUHQ2ZGkybU9zRzBqcTRUMlFKREJK?=
 =?utf-8?B?aVdpZGczWVdZU0Z1amhId1dwZ2JZMmN1ak1jY1RLakF0YnFTVm9vM1BKOFcz?=
 =?utf-8?B?MnlFTDlhYk1CSDE1ZGJ5aG5OaW1UYnN2MEE4S0Z3V0tsOUd0WFNXbnBzcE5X?=
 =?utf-8?B?Rm9NdlZRYThIbkxDSEZ0QW1TSUY5QXBvZTQvRU1BZmROcC9vZDBjVGZpTjlF?=
 =?utf-8?B?WXdwSy93M2RXN082bUVWWCtaVWZEM2JuQUNZSzVoRTl6em5IUFN1dEVhem5Z?=
 =?utf-8?B?QVlYSkI4cERnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0RkVjliQU91QkRTSjBncEtTcXRwWnppdG1MbGVSSi8raGRLN2E5bXhiVkpp?=
 =?utf-8?B?ZWVGcGhIRy9mMDNWOG8yODVCRDlqSjUxbDRUQ3pmUzMwWGhaWk1FQ1RyY3Jn?=
 =?utf-8?B?UEZ1QlliZUxLd3Q2bXlLWCtiT3VidHo5SlVIN1RLbk1jMW5IZVA3K0JwdGI5?=
 =?utf-8?B?cTlsUmdXTVppZjkwQ2VwSmd2ZmZxeTFyNmQrODJvSXJVYXNJVVN6aDdteVVm?=
 =?utf-8?B?OHhBbHIySnZQb0RMSDRyT1dQc3ZXTE0ydExDdldhMVB4UkRIUms2ZFBJemxs?=
 =?utf-8?B?MWd5eE1nOUh2NHVGNWJRTFdsYlRZQWpFcnRMckJMZ1ZLTU9DSFVFMDJuR01j?=
 =?utf-8?B?aDNyekRCNFdaMFBBdmloOHRkR0dscVFEVUdxaEp6cUNaZWQzanVyeEY3elhk?=
 =?utf-8?B?R2xCbFF1YUtwWm90eHJZdk93R2QwVWorK2crbUJQOVh4eDA2R0NMUWhGelRW?=
 =?utf-8?B?bG8zSTFadHF0a25QSUlDMldjdXJQK1ZENnNjZXlrRkl2OXhva1RieXVISUs4?=
 =?utf-8?B?ZlhrWmZrSDJLK0tXZ1NEcnNMSEhTYVRQbmpucGhDaksvWnJOb1Vxa25ZRGdn?=
 =?utf-8?B?cUlRZ0NnRmVMZ21WdmxqMTFIeWZEVXVKNGVyWUpYOFJEU3JidDB6eEVHU3Nr?=
 =?utf-8?B?YUE3dUNZN2tuYUhYdU1rSTA0NFlWL2J4bVRWc0FiZGdBb3J2akJQZlZ2dGtj?=
 =?utf-8?B?ejJ3bDlOcFIvb2V3bjdIMXBMMXlpQ1R6OXVNTGU4cW54RnJyV1lEYlAwUURx?=
 =?utf-8?B?MDNjRlNxKzJjNGg5NlRISnBjOG1nZk1HenNCbmRJZlhpMmlRN3VQSFhQdXd3?=
 =?utf-8?B?c0hMMjZsSkJoTUR1TVFTdURTTW1KTmFXTlB4TElBQ1A4RVU5cEtQc3Bvb0t4?=
 =?utf-8?B?aEJISTJkbWNrSC9rYmlibFNiOHRGcGYvVUxGRDhuSzJiOUlaWCs4eVp1c3Z1?=
 =?utf-8?B?UW5HeVY2cTBFaWpDazdoUFE2eStXM2tvYkN0NmU2d1R5NXAxVStTcndZd0F2?=
 =?utf-8?B?a28yWGR1MjFjT1dmbVdrRkNjUVIwanRXa0owTzVkdjNzVU8zR0FrN1hQUS9z?=
 =?utf-8?B?eFpoYTBJejdyV0ppQ2pjY3k5MlpHYzZwY3M5MDJKM3p0WFNGNWhlMUFsNWxE?=
 =?utf-8?B?dVZQTnZBeXI1MEhOUHdXazBJTXhaTGZ6WEtlWndRZXBoenlHcmRldzBEQTdO?=
 =?utf-8?B?TmZOZVQ0OXV4b1FYMlV1RTY5bnA3MXBhd1BFZUhHZzlOT0xOcEhzaG50aEpt?=
 =?utf-8?B?bExSZllpRjBYUEQwWUtiT3JNdGJXbFF1Zk5pSE1KblgwUklTWUNZcnFTRWtC?=
 =?utf-8?B?MDZIdGd0VlppMERPRXUrSFFPSDZtYkpCSFpGVFJkdHNYbUhJZGZubTU4R1Bo?=
 =?utf-8?B?dkhzaU9JVzUwTUpPUXhuU2dyVnBZdjluMk04cXFGdXk5YjhwZzFKdlRoWVI1?=
 =?utf-8?B?emtiMlpRbjQrNGMxNDZ6YTJoV1UyYkozeERjQ0lLRjAxeHYrbVY2OTlWQ0Zi?=
 =?utf-8?B?UEIyVUQ3WXNGL21lM04vcXZuckI0ME5RUzhqTnQ0dmloNHJCUXp2RjRDd2x3?=
 =?utf-8?B?dzg0cjJGYWxKYVNUeHBteHpQL1BGU0ZDV0gyK21CRnB0N3BWZEpEaDd2cDd0?=
 =?utf-8?B?QmpJMkZvUnJ0bElGTTNCRVcraFlnMXYxL1UzRWNzMmFCejN6WnIrNUdUNFhU?=
 =?utf-8?B?MFgrNTdMOUxkVUlIbHNYd2U5Z2NLeWl2RWJwNWU0enFxRmx6bmJiQ3lHblFx?=
 =?utf-8?B?RmZPSk1YenhWWUVubzBlRVBLZG1YYURtTUNSWHN6cHNkeUg5YUJlWE9QSWtT?=
 =?utf-8?B?MnVFQUFrWVAvbGxFYjRHK2c2V2ptOGVjbjlxM0dBOTNzZFlvajYvS0VpaGls?=
 =?utf-8?B?bXIrMnFjV3VJNkxpVjNFNEhNYVV4VFRXck91L1FFMTkzVEw5VWl5UDRDYUkx?=
 =?utf-8?B?UXVtcmV2WDVDTVFHQWthL0VXZWh4YVZpQ3Fhd1RCNVB3WWlNR3ZBa1V4cGRt?=
 =?utf-8?B?WjBjTVFkaXFDNGJlcEUrNjFHVGxDaHVoWjVReWxIa0s2eXhkeXloeXNxRWRL?=
 =?utf-8?B?Z0lIK0gwcll1ejg0YU15WUlQTVJzZ3VJNWFDODduUkI3YXZubEJZSmtNcHdL?=
 =?utf-8?Q?LAg8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52fd8eb-1a80-4c9b-46cf-08ddc4359830
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 06:54:22.1859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVG4I5ytuOjhBk0xgTj6TY8ZpjuLOtVgPiaJgCFmFV+4TxwGCI81TaSw3wXS6Ub5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9482
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
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSAxNSwgMjAyNSA4OjE4IFBNDQo+IFRvOiBMaWFu
ZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDA2LzExXSBkcm0vYW1kZ3B1OiB0cmFjayB0aGUg
dXNlcnEgYm8gdmEgZm9yIGl0cyBvYmoNCj4gbWFuYWdlbWVudA0KPg0KPiBPbiAxNS4wNy4yNSAx
NDowNSwgTGlhbmcsIFByaWtlIHdyb3RlOg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPiBSZWdhcmRz
LA0KPiA+ICAgICAgIFByaWtlDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
Cj4gPj4gU2VudDogRnJpZGF5LCBKdWx5IDExLCAyMDI1IDg6MTEgUE0NCj4gPj4gVG86IExpYW5n
LCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+ID4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDYvMTFdIGRybS9hbWRncHU6IHRyYWNr
IHRoZSB1c2VycSBibyB2YSBmb3INCj4gPj4gaXRzIG9iaiBtYW5hZ2VtZW50DQo+ID4+DQo+ID4+
DQo+ID4+DQo+ID4+IE9uIDExLjA3LjI1IDExOjM5LCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPj4+
IFRoZSB1c2VyIHF1ZXVlIG9iamVjdCBkZXN0cm95IHJlcXVpcmVzIGVuc3VyaW5nIGl0cyBWQSBr
ZWVwcyBtYXBwaW5nDQo+ID4+PiBwcmlvciB0byB0aGUgcXVldWUgYmVpbmcgZGVzdHJveWVkLg0K
PiA+Pj4gT3RoZXJ3aXNlLCBpdCBzZWVtcyBhIGJ1ZyBpbiB0aGUgdXNlciBzcGFjZSBvciBWQSBm
cmVlZCB3cm9uZ2x5LCBhbmQNCj4gPj4+IHRoZSBrZXJuZWwgZHJpdmVyIHNob3VsZCByZXBvcnQg
YW4gaW52YWxpZGF0ZWQgZXJyb3IgdG8gdGhlIHVzZXINCj4gPj4+IElPQ0xUIHJlcXVlc3QuDQo+
ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5j
b20+DQo+ID4+PiAtLS0NCj4gPj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXNlcnEuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBp
bnNlcnRpb25zKCspDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91c2VycS5jDQo+ID4+PiBpbmRleCAyODU2YzI1MDZiZWUuLjgxZmJiMDBiNmQ5
MSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91
c2VycS5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNl
cnEuYw0KPiA+Pj4gQEAgLTUxMCwxMiArNTEwLDI0IEBAIGFtZGdwdV91c2VycV9kZXN0cm95KHN0
cnVjdCBkcm1fZmlsZSAqZmlscCwNCj4gPj4+IGludA0KPiA+PiBxdWV1ZV9pZCkNCj4gPj4+ICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+Pj4gICAgIH0NCj4gPj4+ICAgICBhbWRncHVf
dXNlcnFfd2FpdF9mb3JfbGFzdF9mZW5jZSh1cV9tZ3IsIHF1ZXVlKTsNCj4gPj4+ICsNCj4gPj4+
ICsgICAvKg0KPiA+Pj4gKyAgICAqIEF0IHRoaXMgcG9pbnQgdGhlIHVzZXJxIG9iaiB2YSBzaG91
bGQgYmUgbWFwcGVkLA0KPiA+Pj4gKyAgICAqIG90aGVyd2lzZSB3aWxsIHJldHVybiBlcnJvciB0
byB1c2VyLg0KPiA+Pj4gKyAgICAqLw0KPiA+Pj4gKyAgIGlmICghYW1kZ3B1X3VzZXJxX2J1ZmZl
cl92YXNfbWFwcGVkKCZmcHJpdi0+dm0sIHF1ZXVlKSkgew0KPiA+Pj4gKyAgICAgICAgICAgZHJt
X3dhcm4oYWRldl90b19kcm0odXFfbWdyLT5hZGV2KSwgInRoZSB1c2VycSBvYmogdmENCj4gPj4+
ICsgc2hvdWxkbid0DQo+ID4+IGJlIHVtYXBwZWQgaGVyZVxuIik7DQo+ID4+PiArICAgICAgICAg
ICByID0gLUVJTlZBTDsNCj4gPj4+ICsgICB9DQo+ID4+PiArDQo+ID4+DQo+ID4+IFRoYXQgaXMg
c3RpbGwgbm90IHNvbWV0aGluZyB3ZSBjYW4gZG8uDQo+ID4+DQo+ID4+IERlc3Ryb3lpbmcgYW4g
dXNlcnF1ZSBjYW4ndCBmYWlsIGluIGFueSB3YXkuDQo+ID4gWWVzLCB0aGUgdXNlcnEgZGVzdHJv
eSB3aWxsIGNvbnRpbnVlIHBlcmZvcm1pbmcgaW4gdGhpcyBpbnZhbGlkIGNhc2UuDQo+ID4gQ2Fu
IHdlIGtlZXAgdGhpcyBwYXJ0IGZvciBkZXRlY3RpbmcgdGhpcyBpbnZhbGlkIGRlc3Ryb3kgY2Fz
ZT8NCj4NCj4gTm8sIGV4YWN0bHkgdGhhdCdzIHRoZSBwb2ludCB0aGVyZSBpcyBubyBzdWNoIHRo
aW5nIGFzIGFuIGludmFsaWQgZGVzdHJveSBjYXNlLg0KPg0KPiBQZXJmZWN0bHkgdmFsaWQgdG8g
ZGVzdHJveSB0aGUgcXVldWUgbm8gbWF0dGVyIHdoYXQgc3RhdGUgd2UgYXJlIGluLg0KPg0KPiBU
aGUgb25seSBpbnZhbGlkIG9wZXJhdGlvbiB3b3VsZCBiZSB0cnlpbmcgdG8gZGVzdHJveSBhIHF1
ZXVlIHdoaWNoIGRvZXNuJ3QgZXhpc3RzIGluDQo+IHRoZSBmaXJzdCBwbGFjZS4NCldlIG1pZ2h0
IG5lZWQgYSBzcGVjaWZpYyBlcnJvciBjb2RlIHRvIGRldGVjdCBpbnZhbGlkIGNhc2Ugb2YgdGhl
IFZBIHVubWFwcGVkIGJlZm9yZSBkZXN0cm95aW5nLA0Kb3RoZXJ3aXNlLCBpdCdzIGRpZmZpY3Vs
dCB0byBpZGVudGlmeSBhbmQgZGV0ZWN0IHRoZSB0ZXN0IHJlc3VsdHMgZm9yIHRoZSBJR1QgbmVn
YXRpdmUgdGVzdC4NCg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4gRnVydGhlcm1v
cmUsIGl0IGxvb2tzIGxpa2UgdGhpcyBlcnJvciBjb2RlIHdpbGwgbm90IGFmZmVjdCB0aGUgZGVz
dHJveQ0KPiA+IHJlcXVlc3QgYXQgdXNlcnNwYWNlIHNpbmNlIHRoZSBNZXNhIGRyaXZlciBkb2Vz
bid0IGNoZWNrIHRoZSB1c2VycSBkZXN0cm95IHJldHVybg0KPiB2YWx1ZS4NCj4gPg0KPiA+PiBS
ZWdhcmRzLA0KPiA+PiBDaHJpc3RpYW4uDQo+ID4+DQo+ID4+PiAgICAgciA9IGFtZGdwdV91c2Vy
cV91bm1hcF9oZWxwZXIodXFfbWdyLCBxdWV1ZSk7DQo+ID4+PiAgICAgLypUT0RPOiBJdCByZXF1
aXJlcyBhIHJlc2V0IGZvciB1c2VycSBodyB1bm1hcCBlcnJvciovDQo+ID4+PiAgICAgaWYgKHVu
bGlrZWx5KHIgIT0gQU1ER1BVX1VTRVJRX1NUQVRFX1VOTUFQUEVEKSkgew0KPiA+Pj4gICAgICAg
ICAgICAgZHJtX3dhcm4oYWRldl90b19kcm0odXFfbWdyLT5hZGV2KSwgInRyeWluZyB0byBkZXN0
cm95IGENCj4gPj4+IEhXDQo+ID4+IG1hcHBpbmcgdXNlcnFcbiIpOw0KPiA+Pj4gICAgICAgICAg
ICAgciA9IC1FVElNRURPVVQ7DQo+ID4+PiAgICAgfQ0KPiA+Pj4gKw0KPiA+Pj4gKyAgIGFtZGdw
dV91c2VycV9idWZmZXJfdmFzX3B1dCgmZnByaXYtPnZtLCBxdWV1ZSk7DQo+ID4+PiAgICAgYW1k
Z3B1X3VzZXJxX2NsZWFudXAodXFfbWdyLCBxdWV1ZSwgcXVldWVfaWQpOw0KPiA+Pj4gICAgIG11
dGV4X3VubG9jaygmdXFfbWdyLT51c2VycV9tdXRleCk7DQo+ID4+Pg0KPiA+Pj4gQEAgLTYzNiw2
ICs2NDgsOSBAQCBhbWRncHVfdXNlcnFfY3JlYXRlKHN0cnVjdCBkcm1fZmlsZSAqZmlscCwgdW5p
b24NCj4gPj4gZHJtX2FtZGdwdV91c2VycSAqYXJncykNCj4gPj4+ICAgICAgICAgICAgIGdvdG8g
dW5sb2NrOw0KPiA+Pj4gICAgIH0NCj4gPj4+DQo+ID4+PiArICAgLyogcmVmZXIgdG8gdGhlIHVz
ZXJxIG9iamVjdHMgdm0gYm8qLw0KPiA+Pj4gKyAgIGFtZGdwdV91c2VycV9idWZmZXJfdmFzX2dl
dChxdWV1ZS0+dm0sIHF1ZXVlKTsNCj4gPj4+ICsNCj4gPj4+ICAgICBxaWQgPSBpZHJfYWxsb2Mo
JnVxX21nci0+dXNlcnFfaWRyLCBxdWV1ZSwgMSwNCj4gPj4gQU1ER1BVX01BWF9VU0VSUV9DT1VO
VCwgR0ZQX0tFUk5FTCk7DQo+ID4+PiAgICAgaWYgKHFpZCA8IDApIHsNCj4gPj4+ICAgICAgICAg
ICAgIGRybV9maWxlX2Vycih1cV9tZ3ItPmZpbGUsICJGYWlsZWQgdG8gYWxsb2NhdGUgYSBxdWV1
ZQ0KPiA+Pj4gaWRcbiIpOw0KPiA+DQoNCg==
