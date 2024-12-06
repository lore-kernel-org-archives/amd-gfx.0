Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7B5E77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 06:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E94710E3E0;
	Fri,  6 Dec 2024 06:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yubf8Hsf";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79BB010E3E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 06:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iv8Up919mTmwQS92EuBIuwNHsAD+flRAZDLfYAY0e7xS6BPwGXmHWoeUODx6NcWET6E9n3QDqLBa8DnPTJ/RySyWFJ9CXLb8Gs9rP0GacrfZcMbq5cq5eH4bgO2eoLLoWPuUmRTsx1MY/f68cI85QK+Evu4do7g9YWACyI644Qz068+oG7aqNC0IKr3dTfCug4K74Lm3/ivQwf8Nuhkqm3xDkKLeEClgvUj/2iR5L3RnPk9HPJJvPTnoN/NRxsq7C5HaRvVLYghs+8Xm8sziCZXcODt3K5xSlDxwlbVo3Up7tUXHOZNyYrRb+24D6i6VonVEFY3jEVTNQmdxT2bCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpgkd9KQySkgY1HyUnGt4HSjyf30cV35mzCAcF/Rzyg=;
 b=DNCITOQqZm/N4nfzbKWT56HVs2cLZC1td6iD+Dri7LcFm0sKzQpZyNzyBVoBRObeTLKPrCpBwTLBEgZvh8QatKVkUz8Lz8LEeOEMf2JMDMj/ZPcuiUd/Kv60x2jVQ+64tgRHIhdvN8V3MHXNqxZXNmPHTQew3cgRSBxBWIl/38r0l1zt1PNq4xkYwZiZ6mug2WflKQ5r4At/qagyPMrvG4hqFDbhA11PGMHpdLhh3b9EaD2M4CGc9cpiZYoANgCnCRHz9ugc4iXz3s84qgMCkKdT/xkpMyfeQgdvi6Vc/fvnehNVHyjL1St2r+bifls4QYbyuyHXOz/Bj23P7PywvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpgkd9KQySkgY1HyUnGt4HSjyf30cV35mzCAcF/Rzyg=;
 b=Yubf8HsfjRRe8Q7vJPhw/5GI7tkxwLCDtB5Zw+epc+EYX3jRr/uzwOrhumyMdK2pz/uq/AKzspSrJPRALBHX+D6jZbGUduFVOSfpn1LS/398xJrlPsK4XcNQnmj1A9ZFpFl4HQCzlYqfce3cssTEp5yUoHm1gTE5fBR7UTLP+qU=
Received: from DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39d::14)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 06:48:31 +0000
Received: from DM4PR12MB5373.namprd12.prod.outlook.com
 ([fe80::79ae:2610:e503:b15b]) by DM4PR12MB5373.namprd12.prod.outlook.com
 ([fe80::79ae:2610:e503:b15b%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 06:48:30 +0000
From: "Feng, Yuan" <Yuan.Feng@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use MEC FW with SJT on gfx_v9_4_3
Thread-Topic: [PATCH] drm/amdgpu: Use MEC FW with SJT on gfx_v9_4_3
Thread-Index: AQHbR2dgRa29up4wB0q+2OlTMNPATrLYrYeAgAAYm+A=
Date: Fri, 6 Dec 2024 06:48:30 +0000
Message-ID: <DM4PR12MB5373FBFD2FA1DEC7EB4031FFFA312@DM4PR12MB5373.namprd12.prod.outlook.com>
References: <20241205224507.2272-1-yfeng1@amd.com>
 <6f18e09d-b523-4bdd-b435-8d02f54227fa@amd.com>
In-Reply-To: <6f18e09d-b523-4bdd-b435-8d02f54227fa@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-Mentions: Lijo.Lazar@amd.com
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=999fe2f8-010d-4154-a940-4e27580b9817;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-06T06:45:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5373:EE_|SJ2PR12MB9162:EE_
x-ms-office365-filtering-correlation-id: e4a9a786-4d16-485e-da62-08dd15c1fe9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RDVGUTdLbC92WlJoY2lCWW03bkVZZXROZHFvL3VYSFQyc0FianRERG15R2hC?=
 =?utf-8?B?TVA4VE5XN1JudFFwVHhzR01FWHVaRUVMOWM3Vm1hMFNUTDRFcS9TcitLaTl5?=
 =?utf-8?B?L0hwbHp6bDNGcytXLy9jWXlvenF2aVpsYi9PdXhEWnZPY1BoU3dCTW1XUW1y?=
 =?utf-8?B?ZEJkVEoyUXcwcEVka2VCNjN4R2U3Y0Z5UjFMd2hSaUdWS0lTMzBOUUtVTHpO?=
 =?utf-8?B?eEVBMExhQ1dXV3hkNE80TlRvQ0lrdmhaVyt1QWFaRWFSTm1aeDRXMEEzU2tx?=
 =?utf-8?B?OUZyWWxKdHA5SVpUdmFnUzZRS2tTdklyUVMzLyt5YlFmUFZGNHhWR1BYZFNr?=
 =?utf-8?B?WU10UXFzTVpTTkF5cWlMcW5Ja3NNYStsc1JWWlA4enJZc1YxWDV0am9BMFM3?=
 =?utf-8?B?TmphL2M1NTVaZ2RQME5ScTkwNXBHb3F6S3doYzNXU3hvdnhVZWNJMU9kZHdQ?=
 =?utf-8?B?MElZNWUrYWkwZFNNaWJ4aGVMQ1ovbDJkanRqeEp5bStEUU1Oc3d3dDA5b2hM?=
 =?utf-8?B?Wkk5V3RZN2cvNDVWZFZCWXdxUFdVUGNVS3NSVFhUZTNTMXI1TElmc1JpQ3dk?=
 =?utf-8?B?M0xjck9GS25ZbDBXdTRXMEl4R2tWNit4dWFvTkU2eXJWMG9ReDNaMGI5cU9p?=
 =?utf-8?B?aXo2NzNvU25ma1kzYnhYZlJRVi9wUWFDb09oTXdKWnVrQ2s4cGMzY28zQTNn?=
 =?utf-8?B?QSt5eVdyOXczMEZxMHMvTHovelBSS2xQVDR2Tkxka2YvZnFudTlqb1JMZzhL?=
 =?utf-8?B?Zmx1b3Z2R0w3NmRmYTl2U29PaDlqRUpyQi9lWVN6Nk44UFZ3UWg0N3hhb3Qr?=
 =?utf-8?B?aEhjYXB2cWl2bERpTU82MTNneFJCdmsycm9JSHZTcWxuUTN4b2VNZ09OUnJG?=
 =?utf-8?B?YkZqZ1pPWUl3QkRJT0JKVk14c09zMTBkb1dGWlJMMzlZekFiOUxQVCtWdURs?=
 =?utf-8?B?bWtvSTVwRzFXV3dtdTljNWxhM3JEUk1ybmxkbjI2dzByNzBhU3BmVzNROVdw?=
 =?utf-8?B?L0ZjcHFmREZwd2pMd2d0OFZYVWhTYUNHcHA4bEZmN0w2STd5ZWdMM1dmMzhr?=
 =?utf-8?B?Z3oyWUxlSHpLSk5yaUc0UGFjR0FodkRjK3ZHcnl0cmdpQjFhYkE4Y20rbkpL?=
 =?utf-8?B?WklKZllDMEUwZ2k3d2s5WTZ4QTE5MWtrU1B4V1R3V2pKazdOenROZDAxd0w2?=
 =?utf-8?B?R1dyMlJOdGNmYllPVytTSmZ2SjdlMjlFUEpLVXRxL1E2VGl6S3BBanVmVFNv?=
 =?utf-8?B?dUo5QWZqZTRobU5aMDNNcStHbW56b3psU3JHUWF3TWQwaFZSZllEd2owdllm?=
 =?utf-8?B?WGpLanBOVk9aTTZ0TkhGTjQ0dThVK09MWHA5OUpnaFArSVNTMXdpRFg3Znhw?=
 =?utf-8?B?MHZXMGlzTXJ0WmRZTnArZDJPVk0xakRVek1FelNGY01ZWXJKaXUrMHRvSE5J?=
 =?utf-8?B?QUJZaXM3MlJBVmZzR3lzc2FiQTlib1hTcXNRUTExZXRYclJsUG05Szk5V21W?=
 =?utf-8?B?V2ljNFhyL1E2SnJBQnpBNC9LbEV4Y0tUd2krNURnVTlGS2VBeHJOTHNxM0Jr?=
 =?utf-8?B?YjVJUmUwYXVQRkpWRGNkTHduYXQ1YXAydXl2akdCWWQ2NWF2anRpUkRhUkdY?=
 =?utf-8?B?ZDMvRjB5U1gwK0I3cWlVWWc1Z2k1TEJXK0l2ZS9BNkk0bS8xaEVBTHFadFJi?=
 =?utf-8?B?NnArbGRaRDQyaUNzenBzVEhXazd1cFpZUmhSS0h5a1RMWkI0NjhSNzV2MmI3?=
 =?utf-8?B?SjNVbmd4NEVNSlhGczdqZm9hYWV3bS8ycGVTMWFSM29JUnh6NmhuSHBRSmJr?=
 =?utf-8?Q?M4WNFw+vlTWM4qL09+dyVH05dtE8przK4POtQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5373.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjVlRG91ODh2Q1R6MzZhNmJHMzYxWlp5Mm9UNk5ZVUcvK0lYSHdWdnV6NUFh?=
 =?utf-8?B?d21GTW5pOHlMZmhRZDhLSHQyZWZieC9odXhUYVUzZUpxWnoveExCQ1RhUlhS?=
 =?utf-8?B?Z1JXMFYzT2ZpNkVnWFMyR0puN0l5QTFXU0hmdExYamJWZUJkRTVWaitHNUcy?=
 =?utf-8?B?Q2JFc29YZmNEalNESmZudTZ6Wnl4dUtmeG5xaW5vamFwUUtMMmQxeXlCWnhY?=
 =?utf-8?B?R2FVMml5K1NwZFVqL3JzOU5maUVuYjVZTFE5RkE4N1FUQm5VY1JjUU0ybjdP?=
 =?utf-8?B?biswYTRnUzB4N0llSHFoc0JpNXIyMks5U0pUeVpPdzJWNnZGQ0pPVCtvUG9S?=
 =?utf-8?B?RHBtZ3NIUi8vL2dmdGVINyt2REJuLzlSd0V1S1I5a01PWDdGRjNEUEROU05R?=
 =?utf-8?B?dVBSQU9pTGFnNE1JbU93TVU0aFFEa2tvNzdOQVpPUThUeVFhQUVobXRUSUc4?=
 =?utf-8?B?NUZPQzZxWGI4cUVvcGJXTTNtamNmYnlQeWRNRGhONGorUDgzT254Yzdib3Q4?=
 =?utf-8?B?L2pWRk53T0JaRng4eXIyQ1NiTHNSdDdFNnhFR3Z1VTdPemlUTTZqcHpUazVD?=
 =?utf-8?B?K2Q3Y0M4VWxqY2l2YWk2U1I2T3JmcFhPY2xGSXkzcXVwSEM2QWJWbHJPelM0?=
 =?utf-8?B?eEhEaDBsVVc4RmxDbGcxNWxHcWpIam13cy9XNVhDTTZBUWlZMlI3a1NzTDlO?=
 =?utf-8?B?Qk5xb3UrQmVGbVRjS2VxTWRqb2RwamZkemNuV1lYMElPOGxNaEVib2ZESVMx?=
 =?utf-8?B?N0ZRVTVMRFh6Z080TnZaMjR0RTZaZHJ2NzN6dG9WQnZIY01FY25KTkFNR21P?=
 =?utf-8?B?RVRNYTNUcTJ0amlBWVFyMzF2a3hzWFpVMkJudWtPV0FXMU5pVlJTTjh0dy9B?=
 =?utf-8?B?VUF0TDJqVW1BbFpDaTZMaHdycXdhWWFqNDltcWFRNHpYWjNpUENCZmdxMWpw?=
 =?utf-8?B?V1JNK3JhdmhwOW5aOGNvYkRaUnJkZlZhcW0zSFNKbGxEUWpkOVVVVzFyc0Rk?=
 =?utf-8?B?WDdWclEyUkQwWFEyRE9mczNWdlFlWUpYZlVmQ1cyYThzUjc5L3pDVFFXREFC?=
 =?utf-8?B?MUxMTVFCQWFzVWNJY2tGTHlPV2ZwMldDT3YreU9UdDlXV1Rtd1VtRmVKQ3JB?=
 =?utf-8?B?S2hxT3NORWhDMHpvUTROaC91R0VHTmFrbk83VVl0ekw5UkplMG1yTnF4LzhP?=
 =?utf-8?B?dGZkenp6TklnZW9UTUNLQVBjSlJpQ09SdVdCN0RwcSt6VE0wZCt4WmcyTFFo?=
 =?utf-8?B?UTJwOVBJZFYzWkhFalhtNnd1TXludENBUlVYU0ZHbUFkVjN5dmdHUlpnOHN6?=
 =?utf-8?B?UUN6V3pxM1JUV2p3bmZqU0YvWSsrQlVnUGlodmtrMEZhLzJYNktWVWpCU1Fj?=
 =?utf-8?B?YkNGY0R2VnBTNVdxWmR3VzFyZ21yWU5RdVZBVXZzSEl5S250SlE2Yjh2SEJD?=
 =?utf-8?B?QzIyOVhwckF3VHdBb3VHTmcyRGNmd1IwVmYxd29WZ1EyUVg5a2xHcTRRVERB?=
 =?utf-8?B?eElnaFA3QWs4MndzU1d4Y0x1VXJFNFRvRnVEMkpybWI1SGRURFN3R0VvSzRn?=
 =?utf-8?B?ME5kUEpsNTBJU0wvZVh4Q00yNFR1YXVvd1l1VVhxQlRKanFJaWJVOG5MLzEr?=
 =?utf-8?B?M0ZxL3ZyODl0Y25LZTlackZ0MkJBYm5ZMk5talJkQ2w4RVErMEs3UTFnUDF3?=
 =?utf-8?B?MVgrOU93MTlkWFZCREU4azduWkZwbGEwR3pjeXEwOG92cEthMHMzQjFrY096?=
 =?utf-8?B?bHFWRmNnYkxVR3NsMzJueWcwNkljZUFXVTRnTlY2dlp2elBXWTNzTWYrajJo?=
 =?utf-8?B?V1pnRyt0dWdUd0xyQStZQU9rU0R6d3hjY2FKbnRaL3lwUXRmWXhnOElQQmY4?=
 =?utf-8?B?alhLUjIxb3NFQ1ZIVDMxS3F2YitUTE8zdGdtUG5hWmNiS2JxMnloRHk5eFJ2?=
 =?utf-8?B?U1Bha0trZ2tERkNGU3RHbU8vT3RUUE9tRE9IVVJGdklIaHEwdTR2c1ZvSmJl?=
 =?utf-8?B?cVhwZmV4T2dzQ0JES1JMQmlhQUVtbkVQTXNmblFFclZtVVdaRlhWMTRkVDlv?=
 =?utf-8?B?Z010MmpOWXI5TGdaQ2ZLOU9qS2k4V01pVm1VbmlnQzVKaDZQQ0M4WDd3REpN?=
 =?utf-8?Q?os5g=3D?=
Content-Type: multipart/mixed;
 boundary="_002_DM4PR12MB5373FBFD2FA1DEC7EB4031FFFA312DM4PR12MB5373namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a9a786-4d16-485e-da62-08dd15c1fe9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 06:48:30.0914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3P7nNg2nkj6ar315PNNe6XXd5aislL3naPsiqv2mwixreTkh+PgHlljGnZEMSq8G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
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

--_002_DM4PR12MB5373FBFD2FA1DEC7EB4031FFFA312DM4PR12MB5373namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQExhemFyLCBMaWpvLA0KUGxlYXNlIHJlZmVyIHRoZSBhdHRhY2hlZC4gVGhlIGlkZWEg
aXMgdG8gdHJ5IHRvIGxvYWQgcmVndWxhciBNRUMgZmlybXdhcmUgaWYgU0pUIG9uZSBpcyBub3Qg
YXZhaWxhYmxlLg0KDQoNClRoYW5rcywNCll1YW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiBGcmlkYXks
IERlY2VtYmVyIDYsIDIwMjQgMTI6MTggQU0NClRvOiBGZW5nLCBZdWFuIDxZdWFuLkZlbmdAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBVc2UgTUVDIEZXIHdpdGggU0pUIG9uIGdmeF92OV80XzMNCg0KDQoNCk9u
IDEyLzYvMjAyNCA0OjE1IEFNLCBZdWFuIEZlbmcgd3JvdGU6DQo+IE9uIFNSSU9WLCBndWVzdCBk
cml2ZXIgYW5kIGhvc3QgZHJpdmVyIG1pZ2h0IGRlcGxveSBkaWZmZXJlbnQgdmVyc2lvbnMNCj4g
b2YgTUVDIGZpcm13YXJlIGJpbmFyaWVzIHRoYXQgbGVhZCB0byBwb3RlbnRpYWwgY29tcGFiaWxp
dHkgaXNzdWVzDQo+IGNhdXNlIHN5c3RlbSBoYW5nLiBUbyBzb2x2ZSB0aGlzLCBob3N0IGFuZCBn
dWVzdCBkZXBsb3kgTUVDIGZ3IGNvcGllcyB3aXRoIHR3byBsZXZlbCBqdW1wIHRhYmxlLg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBZdWFuIEZlbmcgPHlmZW5nMUBhbWQuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMuYyB8IDEyICsrKysrKysrKysrLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMuYw0KPiBpbmRleCAwMzY1NGJm
ZGE1OGEuLmYyNDg0NDllOTNhNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzRfMy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OV80XzMuYw0KPiBAQCAtNDUsNiArNDUsNyBAQCBNT0RVTEVfRklSTVdBUkUoImFtZGdwdS9n
Y185XzRfM19tZWMuYmluIik7DQo+ICBNT0RVTEVfRklSTVdBUkUoImFtZGdwdS9nY185XzRfNF9t
ZWMuYmluIik7DQo+ICBNT0RVTEVfRklSTVdBUkUoImFtZGdwdS9nY185XzRfM19ybGMuYmluIik7
DQo+ICBNT0RVTEVfRklSTVdBUkUoImFtZGdwdS9nY185XzRfNF9ybGMuYmluIik7DQo+ICtNT0RV
TEVfRklSTVdBUkUoImFtZGdwdS9nY185XzRfM19zanRfbWVjLmJpbiIpOw0KPg0KDQpUaGlzIGNo
YW5nZSBuZWVkcyB0byBiZSBkb25lIG9uIHRvcCBvZg0KaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRl
c2t0b3Aub3JnL3BhdGNoLzYyNjA5Ny8gYXMgdGhhdCBvbmUgYWRkcyBzdXBwb3J0IGZvciBHRlgg
OS40LjQgYWxzby4NCg0KVGhhbmtzLA0KTGlqbw0KDQo+ICAjZGVmaW5lIEdGWDlfTUVDX0hQRF9T
SVpFIDQwOTYNCj4gICNkZWZpbmUgUkxDR19VQ09ERV9MT0FESU5HX1NUQVJUX0FERFJFU1MgMHgw
MDAwMjAwMEwgQEAgLTU3NCw3DQo+ICs1NzUsMTYgQEAgc3RhdGljIGludCBnZnhfdjlfNF8zX2lu
aXRfY3BfY29tcHV0ZV9taWNyb2NvZGUoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsICB7
DQo+ICAgICAgIGludCBlcnI7DQo+DQo+IC0gICAgIGVyciA9IGFtZGdwdV91Y29kZV9yZXF1ZXN0
KGFkZXYsICZhZGV2LT5nZngubWVjX2Z3LA0KPiArICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFk
ZXYpKSB7DQo+ICsgICAgICAgICAgICAgZXJyID0gYW1kZ3B1X3Vjb2RlX3JlcXVlc3QoYWRldiwg
JmFkZXYtPmdmeC5tZWNfZncsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJh
bWRncHUvJXNfc2p0X21lYy5iaW4iLCBjaGlwX25hbWUpOw0KPiArDQo+ICsgICAgICAgICAgICAg
aWYgKGVycikNCj4gKyAgICAgICAgICAgICAgICAgICAgIGVyciA9IGFtZGdwdV91Y29kZV9yZXF1
ZXN0KGFkZXYsICZhZGV2LT5nZngubWVjX2Z3LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgImFtZGdwdS8lc19tZWMuYmluIiwgY2hpcF9uYW1lKTsNCj4g
KyAgICAgfQ0KPiArICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgZXJyID0gYW1kZ3B1X3Vjb2Rl
X3JlcXVlc3QoYWRldiwgJmFkZXYtPmdmeC5tZWNfZncsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJhbWRncHUvJXNfbWVjLmJpbiIsIGNoaXBfbmFtZSk7DQo+ICAgICAgIGlm
IChlcnIpDQo+ICAgICAgICAgICAgICAgZ290byBvdXQ7DQoNCg==

--_002_DM4PR12MB5373FBFD2FA1DEC7EB4031FFFA312DM4PR12MB5373namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Fix-for-MEC-SJT-FW-Load-Fail-on-VF.patch"
Content-Description: 0001-drm-amdgpu-Fix-for-MEC-SJT-FW-Load-Fail-on-VF.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Fix-for-MEC-SJT-FW-Load-Fail-on-VF.patch";
	size=1231; creation-date="Fri, 06 Dec 2024 06:45:56 GMT";
	modification-date="Fri, 06 Dec 2024 06:48:29 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhNzNhMzBiZmIwMjM1OTQ3ODJiNDU0MTBmNTIzYTY5OGY4ODQyMmNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB5ZmVuZzEgPHlmZW5nMUBhbWQuY29tPgpEYXRlOiBGcmksIDYg
RGVjIDIwMjQgMDE6MzY6NDYgLTA1MDAKU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXgg
Zm9yIE1FQyBTSlQgRlcgTG9hZCBGYWlsIG9uIFZGCgpVc2VycyBtaWdodCBzd2l0Y2ggdG8gUk9D
TSBidWlsZCBkb2VzIG5vdCBpbmNsdWRlIE1FQyBTSlQgRlcgYW5kIGRyaXZlcgpuZWVkcyB0byBj
b25zaWRlciB0aGlzIGNhc2UuCgpTaWduZWQtb2YteWZlbmcxIDx5ZmVuZzFAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8zLmMgfCA3ICsrKysrKy0KIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8zLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8zLmMKaW5kZXggY2MwMzhmMzAwYTU2Li41ZTZjMWFhYjJl
ODMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8zLmMKQEAgLTU3OSwxMCAr
NTc5LDE1IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzRfM19pbml0X2NwX2NvbXB1dGVfbWljcm9jb2Rl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogewogCWludCBlcnI7CiAKLQlpZiAoYW1kZ3B1
X3NyaW92X3ZmKGFkZXYpKQorCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsKIAkJZXJyID0g
YW1kZ3B1X3Vjb2RlX3JlcXVlc3QoYWRldiwgJmFkZXYtPmdmeC5tZWNfZncsCiAJCQkJCSAgIEFN
REdQVV9VQ09ERV9SRVFVSVJFRCwKIAkJCQkJICAgImFtZGdwdS8lc19zanRfbWVjLmJpbiIsIGNo
aXBfbmFtZSk7CisJCWlmIChlcnIpCisJCQllcnIgPSBhbWRncHVfdWNvZGVfcmVxdWVzdChhZGV2
LCAmYWRldi0+Z2Z4Lm1lY19mdywKKwkJCQkJICAgQU1ER1BVX1VDT0RFX1JFUVVJUkVELAorCQkJ
CQkgICAiYW1kZ3B1LyVzX21lYy5iaW4iLCBjaGlwX25hbWUpOworCX0KIAllbHNlCiAJCWVyciA9
IGFtZGdwdV91Y29kZV9yZXF1ZXN0KGFkZXYsICZhZGV2LT5nZngubWVjX2Z3LAogCQkJCQkgICBB
TURHUFVfVUNPREVfUkVRVUlSRUQsCi0tIAoyLjM0LjEKCg==

--_002_DM4PR12MB5373FBFD2FA1DEC7EB4031FFFA312DM4PR12MB5373namp_--
