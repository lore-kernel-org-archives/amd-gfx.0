Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C972C87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 00:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9753610E048;
	Fri,  8 Aug 2025 00:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sl0u0aXH";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D143810E048
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 00:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q89Ibi4MKaCSz8rxQFU1z27hnyaI/htLfRn8YjJjtz6qoghxQgFQRf4/jTGxKkIaCusN2CNudsWn8TFzjO0LNnWEi9xdDlFS+EuhnGWnroh0yXkDM5Nsqwod05wJtbWoWa6FoEgRNR29AZhF/lw7V3nTIVUU3oWInzfHrUF72Z4LDtWYKaoPPGhz7L+QBw+l99Sb4iLdKw7scGMoj+qIDj94FWq2cY18x9LDIBEspxjZbTVkjq7fVrsxjZlxAoyC7N6YlRh0tMzo0JEXjlfwrZUJZ73+MmVcL/8Nup0mN1YeWHBB9DDTYQ7eyaEtkUV14kWi5rbonYjawOtLV2qeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvYuxnzrTfK+NLngaax1A1DWGyP9JVeZrPN8xATZPaY=;
 b=AnbsW11SkTZJTE+ZCEFEdIdIH8p+VTzpVusizrB2USr1fLiDpibVCtr5vz+1GAvgPvNBNf9MNeRw3e4fZoqhCBNVno3ozisI+Ot1/cDF0vBwA5JhsPxHXy4Uvc54WRhViwbsFt/jvqXVagyEtddOfbiHEGTlenT2uCszvT7v2uT+z99LE+JvYxRO+O1tuUOxY9sWxCyx6AYKGwyegPab5IbY+THozEjCN9TCqzoqSaVTaiJEd8tUvmGIqzidOV3Y+R+y+6/o1ELg5jc4R7p9BXFD4sY29x3VWfmvracYuxS4+/Dd2IFIQVxabNIBUzU9FS00+/J1MQ5PF2JcMN/mqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvYuxnzrTfK+NLngaax1A1DWGyP9JVeZrPN8xATZPaY=;
 b=Sl0u0aXHTGqmaWoEbHREwmBLDiCIbcyidcstj3G3D7e2vUuMDL775gTau0j6M/fACVTHpe+aECZIEISegn5QEoVY31/CoXDkXHzl4/Ds1RP07XBMqaA96o/gmoS5IX8+caKBFBdkzCgbPdrwoUZ6pNcUVCZ48BKlaA6CVioLvj0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 00:20:49 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 00:20:48 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: Save and restore switch state
Thread-Topic: [PATCH v3] drm/amdgpu: Save and restore switch state
Thread-Index: AQHcAuGGxzWsOixeaEu+cDIY8X1RI7RW1T8AgAEYfhA=
Date: Fri, 8 Aug 2025 00:20:47 +0000
Message-ID: <PH7PR12MB59978D4D6C564A9A676DD13E822FA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250801124027.1709925-1-lijo.lazar@amd.com>
 <83be04f6-33c6-4fdd-a52b-898f6c8364d7@amd.com>
In-Reply-To: <83be04f6-33c6-4fdd-a52b-898f6c8364d7@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-08T00:16:57.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|LV3PR12MB9096:EE_
x-ms-office365-filtering-correlation-id: ed29bf9b-1df6-4088-5c54-08ddd6116ca2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?ck9LRExuRTY0Z2IwYkpKQVltd3IxcnUycHV0ajhiT29aSFlEZWlHNjFBeVl3?=
 =?utf-8?B?ZHMybG03cEJITHRkVmlUcXpCUWQ1Q3ZNeVJDb0NXRURKRkhkOWRncEVMRmUy?=
 =?utf-8?B?SnpscUhjdXRFLzBYWWNMWnJIaVcrdDNrbGdsemZXRnpPV2xGZFlVclRzakNq?=
 =?utf-8?B?SEsvWTQwU1BSU0w5VUhvcVkwU0ZaRE91dEJxVVc1UFBQa2UzSHhrWEpkUWNI?=
 =?utf-8?B?K3VQOEJMbHZ1bU9ud2M1K0MxT2dOcGxGUEQ2dnlpNVZqOXdqaFliaFl2ejl4?=
 =?utf-8?B?QXlkUUxqSkJKTHlWa0lWVUF2ejQ2Y1JHakRBbVVweGxUOFROQWZ0SmM5YTVO?=
 =?utf-8?B?SzNKYXM0eHhaekFnYkdNcTI5OFZIWXJTV2hZUzZ4Rk5CSWxXbGljVitrY0NJ?=
 =?utf-8?B?U2U0SnZ5MlJUZ1RPdkpYbjNuQWpIRm9MWTRwTXpXNlhnNWJvT25nYTFsUk02?=
 =?utf-8?B?Z0Nka3lDNko5OUFBZlNYU1lwaXRkVkRJVWlLbE5KWFltZ1JTVTlHc05qWXQ0?=
 =?utf-8?B?TkNPVUkvVmxRc3dJaWFSMnNJdnp1NHNPSkhkUmxQQXNQdWtYU0NJQm0xeC9k?=
 =?utf-8?B?bXRIUXVyV25hbmt5REIvdXRkb2xqNk54RVZCbGpUUkgzNFVIUHQ4MWd3dGIv?=
 =?utf-8?B?aGxjK1ZsZGp6SE9NQXA2UHplSE52VmlrK0hpL3ZjbHN0UVd5dDUxRy90dzZv?=
 =?utf-8?B?aCtkMjRHZHA0Mmo4b3lueXpYWDdpSUFVQ0F4dWNPMEovYVZTd2dPeGNMZ25B?=
 =?utf-8?B?TTQ2OGRmc3ZFNFkvSHhIV2tKVzl2MmNFS2NBTDkyeThRNjJFWGlSOFU3WWdX?=
 =?utf-8?B?NkdncXhDTm1FY3ZzY2dlN3N2VE9oQm9heTFHcjloQkdjS2MwQjR1SFVKb1p0?=
 =?utf-8?B?bWFmTXZOL3NGcXdFSDlFeTEvRWhncnp1S0tJVGlDdjRGTk12QlRYMTQ1ZlRV?=
 =?utf-8?B?V2d4U3AzZkdOVTlvN09mTTAyV1plVnJnMVNkWXRwWFVCU0NFY0htOFd2QjRE?=
 =?utf-8?B?dmR3ZDU4TGNFUkpOc0V4OEZ1c2p2TlpDZExJQmtudkZSWTF2OWcxUU5vTWJy?=
 =?utf-8?B?MzF6UzZnS2NwRGI2Y1FXd0FaUzVTS0FGZzdjKzdJYTNDcU5PanVnOTdlSG9B?=
 =?utf-8?B?VVd3QjNabDRlKzIwWTVhVU4zYU9GUGFha1Q4VG9zSllyZnhlZ2t1MVVmK01r?=
 =?utf-8?B?ZWNjSGd3TzVCU2VpL0xJSGxHYng2bjlXUzBIN2UzWnZOVlNRTUZLdExrTXlj?=
 =?utf-8?B?MjVVaFA1VlFiZWJaSUZ5RE1SNmxuQmNLNXRadEs3RjBKU05VS0lJUitJNzJH?=
 =?utf-8?B?d0c4Rms2aTQ3blBPNi83NXp5YXd2RnRiNnoyMzlZMlBtaFlpK1dCaFRsOC9l?=
 =?utf-8?B?NHYzUER2anY3K3NWSENROS9lcjYxemRGeUJUZHB2T1JWR3BBVkNHQlU2alpJ?=
 =?utf-8?B?SUtScDZMZE9FOEc1NVB5SStnWTBPRGxIK1ZKNjJDOTgwN1RPaWNsUngzWWRp?=
 =?utf-8?B?MVRZWURvWHR3OWxkeWxXNkh4VWJ6M1huMFFEUlI4L2tIYzJVVnlVeHVVOCtO?=
 =?utf-8?B?THVMY21pTC8zRGJxcjZDWWthUUdscGR0N3YySWNNYjVWeWtlekFQZGxBWUdy?=
 =?utf-8?B?Tm1xOEFTK2E4SFFaek9RMmF4ZnRDQThudE1OV1RBZVZUKzhYRHRPdjVXMWZV?=
 =?utf-8?B?RmJUUXAvN1lyQzA3REpZTUNLaDNDamp5MmdGT3ZiTzgzNDRoVk8vc3I4aVha?=
 =?utf-8?B?Q0EvaGlnMHpBcUV3cFROdHd2dlY2eHR4VmxST29aTTZncFhuMEZTNzRhK1ZF?=
 =?utf-8?B?UVAyM0czdVVrd21STEdxeU16QjlySzRYdnQ5Ylk5R1JDQm5DZy9WUE9jSXRS?=
 =?utf-8?B?QlVVZEtXRHJ2SVl3cW9hWXJOVzV5RmlxQ1R6UTZJNFc5eXpMZkZIdEc5NEdE?=
 =?utf-8?B?QUw3UkRlTjVqb2hocUZQTHhvYW1tZTN2S3dyTkFSRmxpdzAvU2hOcG9sK0dl?=
 =?utf-8?Q?kraAbWpznBquaIa7Kep6ZbezF7tUlE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VS9FbVMwcEVSbDZDU2tyaHhVTHdRd2oyMnR3dXJNWDJ4dFhyM3ViaUs3ZW5l?=
 =?utf-8?B?MDZDZ1hDTG9Zcko0UElhTGhrS1pQbVhRVWtUMlFsRlJuMU80d2cwRmlsQ3Z6?=
 =?utf-8?B?MkNpT21DN2E0Rk1ySklQeTdWVW12S296blpmZzVTL3FpbDc1d05JRWhYNFVM?=
 =?utf-8?B?Q0N1Zkd4RWs0QTZXNnp1K2hFMVJsUHFleFBWbmxzcXpJLzYrVmxKY0Mra0Nz?=
 =?utf-8?B?b3REdEJnZGZDN3pJQ2QvL1d2Y2tFc1lhTjAyY0g4cXZlcllXaDhPc1poWXhi?=
 =?utf-8?B?THlHQXlCSEJlNVhrYWJQVDR3QXJDMGlmMXo4WXdEWFFpMFdHQTU4VVN6SWQr?=
 =?utf-8?B?REdQenIrQzFqcUdVK0JHeTA1aGx1ak93Ui9yTkpwcEt3YTlmeUVKaTViYld3?=
 =?utf-8?B?VVZDMjIyUXVkOE4yQ0s0UHNWTlZkRStNSjFidzZMSHQ5eTdTMG5pb1YrN0dz?=
 =?utf-8?B?d2Z6RlU1eTJ2QlN5K1EycmR3cWdPL2YzMG5TSjBYS2NrVWtRb2FhVkpGRG96?=
 =?utf-8?B?eW5tSGduWC93bU9lN0NRRVAwckcxV2Y4aGlORVN0eWFUejFNR3VGbklCNWEr?=
 =?utf-8?B?bWNHMVJWVkt1ZDVQemlyYUp5NTBpdkJoWktqRU9hbld5UTljMXp2aWJLcFpJ?=
 =?utf-8?B?cEgvRUFDakFUb0NwK1JXSXhCRUNLRnlvUFBoVXdxUnVodE9zZTZ6WUw5WThC?=
 =?utf-8?B?YnQvVU5ZMXI5T2kyOVdidjdDVTRuOUdQSzJWMWJsN3pUdnp5cEVaWE02YmRY?=
 =?utf-8?B?MW4rbmtSNFZLQW43VGtNbFBhc0hFZ29CbGFPSWRUcFRENElBQWVaaDBFSGNI?=
 =?utf-8?B?M2F6dTBJV0JqNzVISlRNMXkwR2o3eTJGL1Y2UlhmSmtaMnRnU0I5amNjZ0Rk?=
 =?utf-8?B?Tk5OZmZzaG5aYjduR3VEdk4xSjZ5Mk9KeXpHMFdMM3hpTzZMQzVEbzUzNTQ0?=
 =?utf-8?B?VEtyUG8wbnkxTE1rV2R0RUVLb1NkeUJjL2VwaDJ3a3drUXFtTCtxUk9mOVRn?=
 =?utf-8?B?Vm1xY2JENEY4d2ZTTlgvNFdKZFFiMDFGODBxZVlMbmM5NURPaVIzQTlmMC96?=
 =?utf-8?B?SG1oTkVoMDBDblVUUjNvazY4TnlYa0ErN281RkFQYnkzR2E1ZDRVV0ljYWdr?=
 =?utf-8?B?L2RlYVdJNjJGT3JQbjJYc0VBVjBSOHh0T2FGTFZsbkplWFkveExsOXhhUEdv?=
 =?utf-8?B?aHRsMExRZHhaWFVCcHhoU24rVG9CSXpiS2tTRGQ1UEtMMXBveFdFUFFyNHJx?=
 =?utf-8?B?aTV3TVNQaEp4R0cvTEhtdTJWbjk3K3MwSzA2TVhJT3VSTjRVM2VEMWdSdUR0?=
 =?utf-8?B?U1hzLytWbVhhajA0MFFGZnFaWEEraXRGNkZqczZNaTBsN2M5eFRrcndsZEJ3?=
 =?utf-8?B?MnN0TTduMXlrbzJsSyttWDVhVi85Vi94RGFOUElvV3cvS0NyZkMralhWT3Jn?=
 =?utf-8?B?Y01idnlyYWJqWGJwMDhVL3pzbllmMFZHbnR3MTg2TU1qK1BZRlNUNTR5ckZq?=
 =?utf-8?B?NTQvSWFOU2RDRzdNQW1KaUpjNVo0TzFLMzNHV3hhMEVEWHpESUF2WkhYZ1JT?=
 =?utf-8?B?dXF5NzAzbld0b1ZCMnJFeG9FQVVpclpYd21iZTUwYURKUFN5QmZ6ZUxaWTBr?=
 =?utf-8?B?bU83bkVNTkVrMHJuV2pPMjBpSXN0WVl6Q0JxMEw2RHBOd1JDOEZyY2JLOGlV?=
 =?utf-8?B?bTNBaVpVK2FDbW44NnJyaXZ6eDZvaWVkRll5WEdlM2xNQ1RzU1NvWnd4K0d1?=
 =?utf-8?B?ZUJoQ0VYc24zQlh4R1JmZlA5clRFWGV3VTEwcnhheVBqMmI2ZCtpc21DeFF1?=
 =?utf-8?B?UGxhT3NIVG5ic0MxZXFEWWhhQU90bTB4aGd0a0xHVUlSenpRMGkrMzdROCsv?=
 =?utf-8?B?aWZtYTBVVVE1SVVudFErSWhHS0prc1BwbW5rMG5RaXlTbzdsSi9oZ3VEWHQ0?=
 =?utf-8?B?eXJwQzBSV1VrMEF5ZGh3OGJOcit6M1JjdEFyLzZXRnNSVEd0NU9zT0tLc1p5?=
 =?utf-8?B?cGJmWmxGL1pwSnp5a1NEVkpOWHc4ZVZPVEtjSk5qdlNrRm1QV1QydzJXb3d5?=
 =?utf-8?B?aENmSVhSRnE5dGlYNW9iRDFkVTZkWVQrMXpJYmMzWlRBTjRlU1IxY1N0enhM?=
 =?utf-8?Q?mwLg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed29bf9b-1df6-4088-5c54-08ddd6116ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 00:20:48.1075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o64KarZyqnjtgMDzeCk8wpol45FA1UjFm2dJBi5Ie6eEdkTAikwID4vozqBNTVuP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
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
Cg0KPiArICAgICBkbyB7DQo+ICsgICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDEwMDAwLCAxMDUw
MCk7DQo+ICsgICAgICAgICAgICAgciA9IHBjaV9yZWFkX2NvbmZpZ193b3JkKGxpbmtfZGV2LCBQ
Q0lfVkVORE9SX0lELCAmc3RhdHVzKTsNCj4gKyAgICAgfSB3aGlsZSAoKHN0YXR1cyAhPSBQQ0lf
VkVORE9SX0lEX0FUSSkgJiYNCj4gKyAgICAgICAgICAgICAgKHN0YXR1cyAhPSBQQ0lfVkVORE9S
X0lEX0FNRCkpOw0KDQpZb3UnZCBiZXR0ZXIgYWRkIGFub3RoZXIgZXhpdCB0byBhdm9pZCB0aGlz
IGJlY29taW5nIGEgZGVhZCBsb29wLiBFLmc6IGNoZWNrIHJlc3BvbnNlICdyJyBvciBhZGQgYSB0
cnkgY291bnRlciA/DQoNCkJlc3QgUmVnYXJkcywNCktldmluDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnPiBPbiBCZWhhbGYgT2YgTGF6YXIsIExpam8NClNlbnQ6IFRodXJzZGF5LCBBdWd1c3Qg
NywgMjAyNSAzOjMzIFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBa
aGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU3VuLCBDZShPdmVybG9yZCkgPENlLlN1bkBh
bWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2M10gZHJtL2FtZGdwdTogU2F2ZSBhbmQgcmVz
dG9yZSBzd2l0Y2ggc3RhdGUNCg0KPFBpbmc+DQoNCk9uIDgvMS8yMDI1IDY6MTAgUE0sIExpam8g
TGF6YXIgd3JvdGU6DQo+IER1cmluZyBhIERQQyBlcnJvciBrZXJuZWwgd2FpdHMgZm9yIHRoZSBs
aW5rIHRvIGJlIGFjdGl2ZSBiZWZvcmUNCj4gbm90aWZ5aW5nIGRvd25zdHJlYW0gZGV2aWNlcy4g
T24gY2VydGFpbiBwbGF0Zm9ybXMgd2l0aCBCcm9hZGNvbQ0KPiBzd2l0Y2ggaW4gc3ludGhldGlp
YyBtb2RlLCBzd2l0Y2ggcmVzcG9uZHMgd2l0aCB2YWx1ZXMgZXZlbiB0aG91Z2ggdGhlDQo+IGxp
bmsgaXMgbm90IGZ1bGx5IHJlYWR5LiBUaGUgY29uZmlnIHNwYWNlIHJlc3RvcmF0aW9uIGRvbmUg
YnkgcGNpZQ0KPiBwb3J0IGRyaXZlciBmb3IgU1dVUy9EUyBvZiBkR1BVIGlzIHRodXMgbm90IGVm
ZmVjdGl2ZSBhcyB0aGUgc3dpdGNoIGlzDQo+IHN0aWxsIGRvaW5nIGludGVybmFsIGVudW1lcmF0
aW9uLg0KPg0KPiBBcyBhIHdvcmthcm91bmQsIHNhdmUgc3RhdGUgb2YgU1dVUy9EUyBkZXZpY2Ug
aW4gZHJpdmVyLiBBZGQNCj4gYWRkaXRpb25hbCBjaGVjayB0byBzZWUgaWYgbGluayBpcyBhY3Rp
dmUgYW5kIHJlc3RvcmUgdGhlIHZhbHVlcw0KPiBkdXJpbmcgRFBDIGVycm9yIGNhbGxiYWNrcy4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPg0KPiAt
LS0NCj4gdjI6IFVzZSB1c2xlZXBfcmFuZ2UgYXMgc2xlZXAgaXMgc2hvcnQuIFJlbW92ZSBkZXZf
aW5mbyBsb2dzLg0KPiB2MzogcmVtb3ZlIHJlZHVuZGFudCBpbmNyZW1lbnQgb2YgJ2knIGluIGxv
b3AgKENlIFN1bikuDQo+DQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAg
ICAgICAgfCAgMyArDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMgfCA3Mg0KPiArKysrKysrKysrKysrKysrKysrKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcz
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oDQo+IGluZGV4IDM1NTBjMmZhYzE4NC4uOTZkNzcyYWFkYjA0IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiBAQCAtOTA0LDYgKzkwNCw5IEBAIHN0
cnVjdCBhbWRncHVfcGNpZV9yZXNldF9jdHggew0KPiAgICAgICBib29sIGluX2xpbmtfcmVzZXQ7
DQo+ICAgICAgIGJvb2wgb2NjdXJzX2RwYzsNCj4gICAgICAgYm9vbCBhdWRpb19zdXNwZW5kZWQ7
DQo+ICsgICAgIHN0cnVjdCBwY2lfZGV2ICpzd3VzOw0KPiArICAgICBzdHJ1Y3QgcGNpX3NhdmVk
X3N0YXRlICpzd3VzX3BjaXN0YXRlOw0KPiArICAgICBzdHJ1Y3QgcGNpX3NhdmVkX3N0YXRlICpz
d2RzX3BjaXN0YXRlOw0KPiAgfTsNCj4NCj4gIC8qDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gaW5kZXggY2ZkNzJmYWVjMTZlLi5lNThmNDI1MzE5
NzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMN
Cj4gQEAgLTE3OCw2ICsxNzgsOCBAQCBzdHJ1Y3QgYW1kZ3B1X2luaXRfbGV2ZWwgYW1kZ3B1X2lu
aXRfbWluaW1hbF94Z21pID0gew0KPiAgICAgICAgICAgICAgIEJJVChBTURfSVBfQkxPQ0tfVFlQ
RV9QU1ApDQo+ICB9Ow0KPg0KPiArc3RhdGljIHZvaWQgYW1kZ3B1X2RldmljZV9sb2FkX3N3aXRj
aF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiArKmFkZXYpOw0KPiArDQo+ICBzdGF0aWMg
aW5saW5lIGJvb2wgYW1kZ3B1X2lwX21lbWJlcl9vZl9od2luaShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVu
dW0gYW1kX2lwX2Jsb2NrX3R5cGUgYmxvY2spICB7IEBAIC01MDA2LDcgKzUwMDgsOCBAQCB2b2lk
DQo+IGFtZGdwdV9kZXZpY2VfZmluaV9zdyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4g
ICAgICAgYWRldi0+cmVzZXRfZG9tYWluID0gTlVMTDsNCj4NCj4gICAgICAga2ZyZWUoYWRldi0+
cGNpX3N0YXRlKTsNCj4gLQ0KPiArICAgICBrZnJlZShhZGV2LT5wY2llX3Jlc2V0X2N0eC5zd2Rz
X3BjaXN0YXRlKTsNCj4gKyAgICAga2ZyZWUoYWRldi0+cGNpZV9yZXNldF9jdHguc3d1c19wY2lz
dGF0ZSk7DQo+ICB9DQo+DQo+ICAvKioNCj4gQEAgLTY5NjMsMTYgKzY5NjYsMjcgQEAgcGNpX2Vy
c19yZXN1bHRfdCBhbWRncHVfcGNpX3Nsb3RfcmVzZXQoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+
ICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICp0bXBfYWRldjsNCj4gICAgICAgc3RydWN0IGFt
ZGdwdV9oaXZlX2luZm8gKmhpdmU7DQo+ICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgZGV2aWNlX2xp
c3Q7DQo+ICsgICAgIHN0cnVjdCBwY2lfZGV2ICpsaW5rX2RldjsNCj4gICAgICAgaW50IHIgPSAw
LCBpOw0KPiAgICAgICB1MzIgbWVtc2l6ZTsNCj4gKyAgICAgdTE2IHN0YXR1czsNCj4NCj4gICAg
ICAgZGV2X2luZm8oYWRldi0+ZGV2LCAiUENJIGVycm9yOiBzbG90IHJlc2V0IGNhbGxiYWNrISFc
biIpOw0KPg0KPiAgICAgICBtZW1zZXQoJnJlc2V0X2NvbnRleHQsIDAsIHNpemVvZihyZXNldF9j
b250ZXh0KSk7DQo+DQo+ICsgICAgIGlmIChhZGV2LT5wY2llX3Jlc2V0X2N0eC5zd3VzKQ0KPiAr
ICAgICAgICAgICAgIGxpbmtfZGV2ID0gYWRldi0+cGNpZV9yZXNldF9jdHguc3d1czsNCj4gKyAg
ICAgZWxzZQ0KPiArICAgICAgICAgICAgIGxpbmtfZGV2ID0gYWRldi0+cGRldjsNCj4gICAgICAg
Lyogd2FpdCBmb3IgYXNpYyB0byBjb21lIG91dCBvZiByZXNldCAqLw0KPiAtICAgICBtc2xlZXAo
NzAwKTsNCj4gKyAgICAgZG8gew0KPiArICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMDAwMCwg
MTA1MDApOw0KPiArICAgICAgICAgICAgIHIgPSBwY2lfcmVhZF9jb25maWdfd29yZChsaW5rX2Rl
diwgUENJX1ZFTkRPUl9JRCwgJnN0YXR1cyk7DQo+ICsgICAgIH0gd2hpbGUgKChzdGF0dXMgIT0g
UENJX1ZFTkRPUl9JRF9BVEkpICYmDQo+ICsgICAgICAgICAgICAgIChzdGF0dXMgIT0gUENJX1ZF
TkRPUl9JRF9BTUQpKTsNCj4NCj4gKyAgICAgYW1kZ3B1X2RldmljZV9sb2FkX3N3aXRjaF9zdGF0
ZShhZGV2KTsNCj4gICAgICAgLyogUmVzdG9yZSBQQ0kgY29uZnNwYWNlICovDQo+ICAgICAgIGFt
ZGdwdV9kZXZpY2VfbG9hZF9wY2lfc3RhdGUocGRldik7DQo+DQo+IEBAIC03MDc0LDYgKzcwODgs
NTggQEAgdm9pZCBhbWRncHVfcGNpX3Jlc3VtZShzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gICAg
ICAgfQ0KPiAgfQ0KPg0KPiArc3RhdGljIHZvaWQgYW1kZ3B1X2RldmljZV9jYWNoZV9zd2l0Y2hf
c3RhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKyphZGV2KSB7DQo+ICsgICAgIHN0cnVjdCBw
Y2lfZGV2ICpwYXJlbnQgPSBwY2lfdXBzdHJlYW1fYnJpZGdlKGFkZXYtPnBkZXYpOw0KPiArICAg
ICBpbnQgcjsNCj4gKw0KPiArICAgICBpZiAocGFyZW50LT52ZW5kb3IgIT0gUENJX1ZFTkRPUl9J
RF9BVEkpDQo+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiArDQo+ICsgICAgIC8qIElmIGFscmVh
ZHkgc2F2ZWQsIHJldHVybiAqLw0KPiArICAgICBpZiAoYWRldi0+cGNpZV9yZXNldF9jdHguc3d1
cykNCj4gKyAgICAgICAgICAgICByZXR1cm47DQo+ICsgICAgIC8qIFVwc3RyZWFtIGJyaWRnZSBp
cyBBVEksIGFzc3VtZSBpdCdzIFNXVVMvRFMgYXJjaGl0ZWN0dXJlICovDQo+ICsgICAgIHIgPSBw
Y2lfc2F2ZV9zdGF0ZShwYXJlbnQpOw0KPiArICAgICBpZiAocikNCj4gKyAgICAgICAgICAgICBy
ZXR1cm47DQo+ICsgICAgIGFkZXYtPnBjaWVfcmVzZXRfY3R4LnN3ZHNfcGNpc3RhdGUgPSBwY2lf
c3RvcmVfc2F2ZWRfc3RhdGUocGFyZW50KTsNCj4gKw0KPiArICAgICBwYXJlbnQgPSBwY2lfdXBz
dHJlYW1fYnJpZGdlKHBhcmVudCk7DQo+ICsgICAgIHIgPSBwY2lfc2F2ZV9zdGF0ZShwYXJlbnQp
Ow0KPiArICAgICBpZiAocikNCj4gKyAgICAgICAgICAgICByZXR1cm47DQo+ICsgICAgIGFkZXYt
PnBjaWVfcmVzZXRfY3R4LnN3dXNfcGNpc3RhdGUgPSBwY2lfc3RvcmVfc2F2ZWRfc3RhdGUocGFy
ZW50KTsNCj4gKw0KPiArICAgICBhZGV2LT5wY2llX3Jlc2V0X2N0eC5zd3VzID0gcGFyZW50Ow0K
PiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBhbWRncHVfZGV2aWNlX2xvYWRfc3dpdGNoX3N0YXRl
KHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICsqYWRldikgew0KPiArICAgICBzdHJ1Y3QgcGNpX2Rl
diAqcGRldjsNCj4gKyAgICAgaW50IHI7DQo+ICsNCj4gKyAgICAgaWYgKCFhZGV2LT5wY2llX3Jl
c2V0X2N0eC5zd2RzX3BjaXN0YXRlIHx8DQo+ICsgICAgICAgICAhYWRldi0+cGNpZV9yZXNldF9j
dHguc3d1c19wY2lzdGF0ZSkNCj4gKyAgICAgICAgICAgICByZXR1cm47DQo+ICsNCj4gKyAgICAg
cGRldiA9IGFkZXYtPnBjaWVfcmVzZXRfY3R4LnN3dXM7DQo+ICsgICAgIHIgPSBwY2lfbG9hZF9z
YXZlZF9zdGF0ZShwZGV2LCBhZGV2LT5wY2llX3Jlc2V0X2N0eC5zd3VzX3BjaXN0YXRlKTsNCj4g
KyAgICAgaWYgKCFyKSB7DQo+ICsgICAgICAgICAgICAgcGNpX3Jlc3RvcmVfc3RhdGUocGRldik7
DQo+ICsgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICAgZGV2X3dhcm4oYWRldi0+ZGV2LCAi
RmFpbGVkIHRvIGxvYWQgU1dVUyBzdGF0ZSwgZXJyOiVkXG4iLCByKTsNCj4gKyAgICAgICAgICAg
ICByZXR1cm47DQo+ICsgICAgIH0NCj4gKw0KPiArICAgICBwZGV2ID0gcGNpX3Vwc3RyZWFtX2Jy
aWRnZShhZGV2LT5wZGV2KTsNCj4gKyAgICAgciA9IHBjaV9sb2FkX3NhdmVkX3N0YXRlKHBkZXYs
IGFkZXYtPnBjaWVfcmVzZXRfY3R4LnN3ZHNfcGNpc3RhdGUpOw0KPiArICAgICBpZiAoIXIpDQo+
ICsgICAgICAgICAgICAgcGNpX3Jlc3RvcmVfc3RhdGUocGRldik7DQo+ICsgICAgIGVsc2UNCj4g
KyAgICAgICAgICAgICBkZXZfd2FybihhZGV2LT5kZXYsICJGYWlsZWQgdG8gbG9hZCBTV0RTIHN0
YXRlLCBlcnI6JWRcbiIsIHIpOyB9DQo+ICsNCj4gIGJvb2wgYW1kZ3B1X2RldmljZV9jYWNoZV9w
Y2lfc3RhdGUoc3RydWN0IHBjaV9kZXYgKnBkZXYpICB7DQo+ICAgICAgIHN0cnVjdCBkcm1fZGV2
aWNlICpkZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7IEBAIC03MDk4LDYgKzcxNjQsOA0KPiBA
QCBib29sIGFtZGdwdV9kZXZpY2VfY2FjaGVfcGNpX3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpwZGV2
KQ0KPiAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAgICAgfQ0KPg0KPiArICAgICBh
bWRncHVfZGV2aWNlX2NhY2hlX3N3aXRjaF9zdGF0ZShhZGV2KTsNCj4gKw0KPiAgICAgICByZXR1
cm4gdHJ1ZTsNCj4gIH0NCj4NCg0K
