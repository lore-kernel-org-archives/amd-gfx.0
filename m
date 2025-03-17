Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22F1C28B30
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 14:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970BF10E410;
	Mon, 17 Mar 2025 14:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="isV9wUhm";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6DB310E40E
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOSgmjgPnwpkmoiqkDNLXAnNyY+geOkcJYxIqadgI5HP9fYVArlGL0k3sJ0UiMb4RaQuRMRfx+FnefW/puuQumRrMxxbhTMj8DA+ycUN1HIThPFPFcQy+aZ0uCFD66TLDiwoG4/lhOoDGV4fao8TyiNMMuBNAtK3jaVUSXLFeij7wMRL9zViMJZ1m1OSphg5N6YBMMa+V9pB7YgCzpHSII00LMuX/rG8db4+HeVw4MHB6jWNxl7Zswgils7RsDm1bRrLKNvYrJqlPkxeZmBY1vE6EFBGnaqREUg3dFR9mpTid2vRI+es/H7kN1r6uczaP4bJbXPsfXRfjTwmu8ykHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BUGt2+Zl3xMtqA0ahlnzvY3U1P93FSR0SG5R2fubTw=;
 b=Hs7DCKgwZNjcTJtDLOM9TglwGuUy+Bbs3ADvaE2TpvHtHEmM8bO4jdT377uFLSA8rIXz8h3OVLqW0vfR+a9JLWx4X4rqXq4UgAot27YA33YJmrohVOYvaRFiZMpF27I2oCO9LNbqB3+0mSQC7EHaw7xfPcUquBlwh/9bgBPBinxUgYJWNcqGsl0ELM08ulVvCu5Peg6ZI6JFzQnneLNaKy3/KR4OX7ak9Wp5erI9p820owaTfmRJ2BWrN91klUK+fNSm8YIlbdwbAaX/0dFQwJm9C7AUEdzmMUHZSH7hV32vZWshw07QcGfq2mfKbkDVaE76G4BIH1ioUSGvqbwamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BUGt2+Zl3xMtqA0ahlnzvY3U1P93FSR0SG5R2fubTw=;
 b=isV9wUhm40Lg4FIq64OskkmQQ99Kz5Qih0T1j+wk9ZzWPItET+dS9XggpCgH6ChxZ1XM6qoTxGKaC4z7NhZ9+ovyBv1Wn4NWKduIsZni3B2P4likUGjdq1grVLvbNgcnXqkSjex1pxBWiUDjNreFmwRLOn0vw57l9ZcESM39tXE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 14:29:07 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 14:29:07 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/sdma: guilty tracking is per instance
Thread-Topic: [PATCH 2/2] drm/amdgpu/sdma: guilty tracking is per instance
Thread-Index: AQHbl0MfMFZIbYUWUU6bN4A15ArQMLN3YI2AgAACaGA=
Date: Mon, 17 Mar 2025 14:29:07 +0000
Message-ID: <BL1PR12MB51441DF52D9DD1DF26BD6456F7DF2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250317134710.764906-1-alexander.deucher@amd.com>
 <20250317134710.764906-2-alexander.deucher@amd.com>
 <fe300995-19cd-4b60-ac63-31778ca28028@amd.com>
In-Reply-To: <fe300995-19cd-4b60-ac63-31778ca28028@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ad5c0e52-1e6a-487d-9b9e-a782ebc10ed5;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-17T14:27:51Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL3PR12MB6595:EE_
x-ms-office365-filtering-correlation-id: 63283639-65f3-48ab-88af-08dd6560139b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YzcxOVllOU83QjZkVVdVcWpMb2FyazA4TyszZmlmZWVaU0l1NWEwZitLZWcw?=
 =?utf-8?B?UFR4SjB4ZTNBTUFVdUo5bXRYZG94MWxCanVSemVNcUF3bitBZnNYTHkzOC96?=
 =?utf-8?B?dUM1WmUxRzhTUklYTWhNcmYvVlpIdm1MZE1KQXE0eUdFSG5YWEtnOWxIK3lh?=
 =?utf-8?B?cFNaZHFaY0x5L0xUblR6SkJEUmw0c0lwVGpFajVhS2NidUZiVmUzYU0zRFlU?=
 =?utf-8?B?VGIvTnFtOHEweVoxc01GcHFMZHpzQnpsa1B0NmhCVzh3WjZQTnVLdloyMmtj?=
 =?utf-8?B?cGJpN2FoRlZiM2k5eHFiblVKM3E2UEh6d3VobnhyWG9YcC96MXkxbGlZVXIy?=
 =?utf-8?B?dUJLS1dhb2o2VWx1aGo5U0dORjRxOHR0YzYrNm4yUThpVWxGcDdrVGkzblRY?=
 =?utf-8?B?R0xrbkhOTW50M1pnL3RhbDRTVmg2NmF4azdpaEpvVkc1VTBYQ1hiN0ZDVjZK?=
 =?utf-8?B?K1F4bFowN011Wk1kL29COXo1UGQzUWZEM2gxWEFSeG9oajBZNmV0RjVzK0RQ?=
 =?utf-8?B?Q3pkOHRnVHhHNzdJYzFlMW1acUU2UEZlell4K280VjBHSXQ3Q0xNSlVKM01Q?=
 =?utf-8?B?dkQ3ZEVzNnZ1eGU0d2JBMitnM0kxNzIxdVF6a3NYaXFtQjFKQU1XV2l2OVhY?=
 =?utf-8?B?S0FwNU1zVjNtb1lCVC9MYTZiNUtaYURQSUxTYXJKN2U3NGFiVEZLUDhnTzA0?=
 =?utf-8?B?NVJzbTNXMXhQaEt2TksvbFdaWWk1NWEvVzlBQWVWUCs4MHNtL09YdFZqMmZ6?=
 =?utf-8?B?Y0owV2w4YlNGT0RoeGt4R1FtaG9Ed2s2Sk5jTVJoSTJmMXhIVVdaSHl2ZVo4?=
 =?utf-8?B?cjFzUDJJVmhWSStubElwQ3JZMG5JWDFUNTN2WmVJa2RNTWUvVWVTMnJGWllu?=
 =?utf-8?B?R1lvNWxXdjNNZW9PT09ueUp3MVpKU1lzZTJGRW9KZFhXK3hVVWo0eEw0dmEy?=
 =?utf-8?B?eXZ4a2tFNkpRMVFFRjVPd3RZSUh0V3JUTkVyWFpqRzBvZytPSlFBNFBQTzFa?=
 =?utf-8?B?TURyWk0zTTFkWDFTcDZlRVErMmx0VTFFdjRWRGpNbUdtU3lXSHp1N2daWDVF?=
 =?utf-8?B?bE11b0JuZVE0RnV1dUY2Si8xZjEzeVAxaENGUE1iMWNiNUpaU2Y2WkJyY1RY?=
 =?utf-8?B?RVJLSDV0elFpWFE2NFBvZFYyUVZhclAzVUNUN3QwcWRnUEZ0dXZxU0wxUTZo?=
 =?utf-8?B?ZnN4dDZGSUovM2xUcGlCWHpDZFVvbTFrdjJlR0J3VXFOeUJ5ZThUSC9kTEtZ?=
 =?utf-8?B?RzBoNitaMTg3V1BwelRkUFp1eE9JRDF2Rk1KWHFtQlJHc01MUE9HOHFqcFYy?=
 =?utf-8?B?OGw3WUpjbmZrV3N6L3lXUnhrdEpEcVk4eVhrY1NxQ3ZqbGJBRTRYaUEva0th?=
 =?utf-8?B?TlRyTXVUTy84SEVjbWwyMzlDNVFvSlRCL1owVjhOOFppSWpBSVpKcVJyc2tK?=
 =?utf-8?B?T3oyUmtuRXZERWt5bGJBVEdWbmdvMm4vZWpEMVpxMjlkUHhyTlFkbXRjU0tn?=
 =?utf-8?B?RWhselJyTkVHRVFpcUFJcXZ3UWJEUm5wZVJVWlRWOXJjTUV4eEdTditDeEh0?=
 =?utf-8?B?dUNhL2hneHkxRlFXWEpINU55ZUFrZU9rVVM2RlNaQk5zY2N5S2greS96eng3?=
 =?utf-8?B?WloxNnNsYnYwNkJkN2VMc0dCOEMzODVmVzlBQnJrRms5a25WeVlWdGp1MVJs?=
 =?utf-8?B?STlXZFZGbkpZSndTQWRrVTNPOUkrK2JPbExBalZEZS9SUHZEcnVZYlVIQ1Rq?=
 =?utf-8?B?YWNPcnFRc20vVmdjTFRVaHEzQTJxdlZrcUtCNXhRQ0kwVytQZ3grL1IxZnlp?=
 =?utf-8?B?aWFHQzFXblROQ1NZTk9UN2tkYnZXdnlQZHFvTDZxNUV2MGFiVnFpWjZFNFl2?=
 =?utf-8?B?VzFQVFo2RG0wWW5ON1YyVExjOUt1N3VKM0ZKNFdyVXhSWFh3K1d0QWV1dkdx?=
 =?utf-8?Q?vDDiDSv2poVP8lGLjSLAMnMR4mOh447Y?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cklTV1lHcENxYXVEOUV2V2JNcDVvdm4xNDlSMFkxQjBreWF3UzhIM1hBT0N5?=
 =?utf-8?B?ZW1VRU5nUWdZc3dSK1IvUmE3eEZsd2tJM3MvTUhpbUVFc3U3dkJsNWVTemRJ?=
 =?utf-8?B?WUhNLzZMbUc1MjkxMW1mOGJIRmdEWVVZRzNBdXdOaURDU2JNTlZwek5GMWN3?=
 =?utf-8?B?bkIwVzRrdTllWTFQb05TT2pxMFB0T2NYOTVPK3Y5cEFyS0NLQ0cxTWFua0pk?=
 =?utf-8?B?ZVZ6NjVvZ0FjT2JtTVRBUXphWFM5UFMzL041M2sxUFcreEpRRTRVTlVqRWNs?=
 =?utf-8?B?d044dHY2clVmRVI2eENKWG16ZDBBWFFER09iNE44c1FOWTdrUXpmYmorU3Z1?=
 =?utf-8?B?UEIxbDJFUS9nbEIyZC9WRXBNbmxxdlZOeWUwakxwWWhXSEg0TmZ5bTg1QmNI?=
 =?utf-8?B?S3BRT3hETEI1UlU3NVBMVjNvL216bnNqZ05DTFdHanBXY0ZhaFZaRjVTb0Vi?=
 =?utf-8?B?YkVsdjVlbGNvYVh3b2tWQTRwK2FPbTNvU1ptaU5oYUZ2TkpJcTBjNHFRRkpR?=
 =?utf-8?B?Wk5JNmlvdU9MOGFOdnZrbitMUXNxeHY2dHphdjhJZXVoUDdoK2RXdGdYaXBk?=
 =?utf-8?B?S3JvYjVpL3I5UnJUcVBSSzJZZDZnZkVRM0hwS1ZDVjBaNUg3VFh5YjZTN2JF?=
 =?utf-8?B?RGR3NjliMHV6eTdVcGZOQjJ2c3lEaTRkT0NqVTdSSU1RbzZ5ODRSK2pObkxF?=
 =?utf-8?B?b05POCsweEhNd2F0NS9haDhHSGZjcGk0UnRiSUZSSE5SZkY4L012dS9Wd3Va?=
 =?utf-8?B?TytOSWFtMGZkRkc3TnpwU0h4YlU4MjVpWUdocUdiNHNpWVJpVDJyNTlwSVQy?=
 =?utf-8?B?d3RWWVVxOHZiSWlsOHEyVUErRzZjMnBBbUVXMDhOcmZzcHNSRnVIcXB0c3hp?=
 =?utf-8?B?SlhWWGx6eXVLVVNxd1gzRFF6RUlVT2dXR2JNd2VZQisyRkpWUXB5WlhOb0dF?=
 =?utf-8?B?K0NaNHlvTW9FNTlaZFplR2NIM3ZpRGROenJlR1hVQ3ZwbWk3bSt6blJjMXJh?=
 =?utf-8?B?eFE4RVdXOGkrV0FscndRSkxBenV5Y0ZSa0R4aS9XS25DZUZrVk9TN1FCT1VO?=
 =?utf-8?B?cG5CeWVWeTdQcHJqeXQzVlIrQ2Q4VjcyY016a2kyc0VDZS9NaGo4Z05VK2pP?=
 =?utf-8?B?amhZblpxUVJQc2FmNW9ia2lRa3V6SURYYm1ZSmJyeEUzd0NORFk5UjZzOCs4?=
 =?utf-8?B?YjFwTlVvSHI5dWlhVnVGb1B2TTRzeXJVYVJDM3g3SUdraDNpbHB3S0MreXAx?=
 =?utf-8?B?aEpjUXA3ZW1NbFF3emV1TUs3Z1JNYmtIQnV2cHNtV1RQZ2g5WmlOd3pjMmhW?=
 =?utf-8?B?RHFmVEJQOVk2Vm5lQUlpa2QwRkVQQ1N6cUI3b3FaZVNJQVM0eGgyRHI5ZW9Z?=
 =?utf-8?B?OVE5dHpLSW10cnJqa0RXZ2UzTUZLVlNId0VaVFVKVk9kZVI2eE1PbEhJdlQv?=
 =?utf-8?B?a2J6YlYxQTg2RmxEK082MEd4NnZUMlA4c3FRWG5wdzBPbkZuTHcrWVpmWWo3?=
 =?utf-8?B?SzFpZUthZ2ZoaDNQeGhIUTc5WFBTemN1R0dBYXIycXZCcWdsbys3enhJUWVv?=
 =?utf-8?B?TGtaaHN2Rnpra0tDQzBmUWpyelhSVzJQSDF5SkY2Z0hSZk8yTXlrdkJXUGdo?=
 =?utf-8?B?OVV5c0FtbVl3OVNBcGJ3Q3BYbUZsckljVGxqMEJmYVlhVUNHVVl3REFta25i?=
 =?utf-8?B?cFhSelNhd09icVFOV2JJR3N5Y0JHcnByUUFsVXdhQVE4c1NDRnIvZlRqaHNp?=
 =?utf-8?B?ekNOTDU4NGwzYlBmZ3piQldrVmU4K052VTg1dzhoa3FqUHBHclN3ekltdXZ6?=
 =?utf-8?B?eUkvMzFyOVJndTlDUWRQK1o1MDV2TUEvbGorb25xOE8xc08rR2NmeE94RlBI?=
 =?utf-8?B?UHRKb0N3SlZMV1N2Z3IvSnp6NTdOOStUQVBPdU03R1NBa3hSMnRtc1FzN0V2?=
 =?utf-8?B?Zys1d3pNVWNicXI0dFFHenhQMGRnbmR2OExJVXkxREllZk5LZW1jZ09TNzdm?=
 =?utf-8?B?KzRjY2xEcWFKb3VjSUxpN2FJanlaREJFZW9Tc2pTL3FMNHNuN2tXanB6Zyti?=
 =?utf-8?B?Nk53eWUwL1NPMmovZnBKRExyb0JvTEhlVkhmNjdROGtaMUx0dkYrcHZoMkQ3?=
 =?utf-8?Q?DI2Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63283639-65f3-48ab-88af-08dd6560139b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 14:29:07.6237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIbVGicTAHxx4FR969Y4EcvVRY4WOBzB2yq3qBcP+yuCVJoxRTSv58rAHS+no1NsKLwUW5sWimssF47TJPUiDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE3LCAyMDI1
IDEwOjE5IEFNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAyLzJdIGRybS9hbWRncHUvc2RtYTogZ3VpbHR5IHRyYWNraW5nIGlzIHBlciBpbnN0
YW5jZQ0KPg0KPg0KPg0KPiBPbiAzLzE3LzIwMjUgNzoxNyBQTSwgQWxleCBEZXVjaGVyIHdyb3Rl
Og0KPiA+IFRoZSBnZnggYW5kIHBhZ2UgcXVldWVzIGFyZSBwZXIgaW5zdGFuY2UsIHNvIHRyYWNr
IHRoZW0gcGVyIGluc3RhbmNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfc2RtYS5oIHwgIDcgKysrKy0tLQ0KPiA+IGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMgfCAxOCArKysrKysrKysrKy0tLS0tLS0NCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2Rt
YS5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2RtYS5oDQo+ID4g
aW5kZXggOGU3ZTc5NGZmMTM2Zi4uZGMxYTgxYzJmOWFmNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2RtYS5oDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3NkbWEuaA0KPiA+IEBAIC02NSw2ICs2NSwxMCBAQCBz
dHJ1Y3QgYW1kZ3B1X3NkbWFfaW5zdGFuY2Ugew0KPiA+ICAgICB1aW50NjRfdCAgICAgICAgICAg
ICAgICBzZG1hX2Z3X2dwdV9hZGRyOw0KPiA+ICAgICB1aW50MzJfdCAgICAgICAgICAgICAgICAq
c2RtYV9md19wdHI7DQo+ID4gICAgIHN0cnVjdCBtdXRleCAgICAgICAgICAgIGVuZ2luZV9yZXNl
dF9tdXRleDsNCj4gPiArICAgLyogdHJhY2sgZ3VpbHR5IHN0YXRlIG9mIEdGWCBhbmQgUEFHRSBx
dWV1ZXMgKi8NCj4gPiArICAgYm9vbCAgICAgICAgICAgICAgICAgICAgZ2Z4X2d1aWx0eTsNCj4g
PiArICAgYm9vbCAgICAgICAgICAgICAgICAgICAgcGFnZV9ndWlsdHk7DQo+ID4gKw0KPiA+ICB9
Ow0KPiA+DQo+ID4gIGVudW0gYW1kZ3B1X3NkbWFfcmFzX21lbW9yeV9pZCB7DQo+ID4gQEAgLTEy
Nyw5ICsxMzEsNiBAQCBzdHJ1Y3QgYW1kZ3B1X3NkbWEgew0KPiA+ICAgICB1aW50MzJfdCAgICAg
ICAgICAgICAgICAqaXBfZHVtcDsNCj4gPiAgICAgdWludDMyX3QgICAgICAgICAgICAgICAgc3Vw
cG9ydGVkX3Jlc2V0Ow0KPiA+ICAgICBzdHJ1Y3QgbGlzdF9oZWFkICAgICAgICByZXNldF9jYWxs
YmFja19saXN0Ow0KPiA+IC0gICAvKiB0cmFjayBndWlsdHkgc3RhdGUgb2YgR0ZYIGFuZCBQQUdF
IHF1ZXVlcyAqLw0KPiA+IC0gICBib29sIGdmeF9ndWlsdHk7DQo+ID4gLSAgIGJvb2wgcGFnZV9n
dWlsdHk7DQo+ID4gIH07DQo+ID4NCj4gPiAgLyoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF80XzIuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc2RtYV92NF80XzIuYw0KPiA+IGluZGV4IDkyN2RiN2EwODBmMGEuLmM0ODViNTgy
YTIwZjYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92
NF80XzIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfNF8y
LmMNCj4gPiBAQCAtOTg5LDkgKzk4OSwxMCBAQCBzdGF0aWMgaW50IHNkbWFfdjRfNF8yX2luc3Rf
c3RhcnQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAgICAgICAgICAgdWlu
dDMyX3QgdGVtcDsNCj4gPg0KPiA+ICAgICAgICAgICAgIFdSRUczMl9TRE1BKGksIHJlZ1NETUFf
U0VNX1dBSVRfRkFJTF9USU1FUl9DTlRMLCAwKTsNCj4gPiAtICAgICAgICAgICBzZG1hX3Y0XzRf
Ml9nZnhfcmVzdW1lKGFkZXYsIGksIHJlc3RvcmUsIGFkZXYtPnNkbWEuZ2Z4X2d1aWx0eSk7DQo+
ID4gKyAgICAgICAgICAgc2RtYV92NF80XzJfZ2Z4X3Jlc3VtZShhZGV2LCBpLCByZXN0b3JlLA0K
PiA+ICthZGV2LT5zZG1hLmluc3RhbmNlW2ldLmdmeF9ndWlsdHkpOw0KPiA+ICAgICAgICAgICAg
IGlmIChhZGV2LT5zZG1hLmhhc19wYWdlX3F1ZXVlKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAg
c2RtYV92NF80XzJfcGFnZV9yZXN1bWUoYWRldiwgaSwgcmVzdG9yZSwgYWRldi0NCj4gPnNkbWEu
cGFnZV9ndWlsdHkpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgc2RtYV92NF80XzJfcGFnZV9y
ZXN1bWUoYWRldiwgaSwgcmVzdG9yZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFkZXYtPnNkbWEuaW5zdGFuY2VbaV0ucGFnZV9ndWlsdHkpOw0KPg0K
PiBJIHRoaW5rIHBhc3NpbmcgdGhlIGZsYWcgaXMgbm8gbG9uZ2VyIGJlIHJlcXVpcmVkIGFzIHRo
ZSBpbnN0YW5jZSBpZCBpcyBwYXNzZWQgYWxyZWFkeS4NCg0KV2Ugc3RpbGwgbmVlZCB0byBkZXRl
cm1pbmUgd2hpY2ggcXVldWUgbmVlZHMgdG8gYmUgcmVzZXQgYW5kIHJlc3RvcmVkIHZzLmp1c3Qg
cmVzZXQuDQoNCkFsZXgNCg0KDQo+DQo+IFRoYW5rcywNCj4gTGlqbw0KPg0KPiA+DQo+ID4gICAg
ICAgICAgICAgLyogc2V0IHV0YyBsMSBlbmFibGUgZmxhZyBhbHdheXMgdG8gMSAqLw0KPiA+ICAg
ICAgICAgICAgIHRlbXAgPSBSUkVHMzJfU0RNQShpLCByZWdTRE1BX0NOVEwpOyBAQCAtMTQ0Niw2
DQo+ICsxNDQ3LDEwIEBAIHN0YXRpYw0KPiA+IGludCBzZG1hX3Y0XzRfMl9zd19pbml0KHN0cnVj
dCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KPiA+DQo+ID4gICAgIGZvciAoaSA9IDA7IGkg
PCBhZGV2LT5zZG1hLm51bV9pbnN0YW5jZXM7IGkrKykgew0KPiA+ICAgICAgICAgICAgIG11dGV4
X2luaXQoJmFkZXYtPnNkbWEuaW5zdGFuY2VbaV0uZW5naW5lX3Jlc2V0X211dGV4KTsNCj4gPiAr
ICAgICAgICAgICAvKiBJbml0aWFsaXplIGd1aWx0eSBmbGFncyBmb3IgR0ZYIGFuZCBQQUdFIHF1
ZXVlcyAqLw0KPiA+ICsgICAgICAgICAgIGFkZXYtPnNkbWEuaW5zdGFuY2VbaV0uZ2Z4X2d1aWx0
eSA9IGZhbHNlOw0KPiA+ICsgICAgICAgICAgIGFkZXYtPnNkbWEuaW5zdGFuY2VbaV0ucGFnZV9n
dWlsdHkgPSBmYWxzZTsNCj4gPiArDQo+ID4gICAgICAgICAgICAgcmluZyA9ICZhZGV2LT5zZG1h
Lmluc3RhbmNlW2ldLnJpbmc7DQo+ID4gICAgICAgICAgICAgcmluZy0+cmluZ19vYmogPSBOVUxM
Ow0KPiA+ICAgICAgICAgICAgIHJpbmctPnVzZV9kb29yYmVsbCA9IHRydWU7DQo+ID4gQEAgLTE1
MDcsOSArMTUxMiw2IEBAIHN0YXRpYyBpbnQgc2RtYV92NF80XzJfc3dfaW5pdChzdHJ1Y3QNCj4g
YW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4gPiAgICAgciA9IGFtZGdwdV9zZG1hX3N5c2Zz
X3Jlc2V0X21hc2tfaW5pdChhZGV2KTsNCj4gPiAgICAgaWYgKHIpDQo+ID4gICAgICAgICAgICAg
cmV0dXJuIHI7DQo+ID4gLSAgIC8qIEluaXRpYWxpemUgZ3VpbHR5IGZsYWdzIGZvciBHRlggYW5k
IFBBR0UgcXVldWVzICovDQo+ID4gLSAgIGFkZXYtPnNkbWEuZ2Z4X2d1aWx0eSA9IGZhbHNlOw0K
PiA+IC0gICBhZGV2LT5zZG1hLnBhZ2VfZ3VpbHR5ID0gZmFsc2U7DQo+ID4NCj4gPiAgICAgcmV0
dXJuIHI7DQo+ID4gIH0NCj4gPiBAQCAtMTY4Niw5ICsxNjg4LDExIEBAIHN0YXRpYyBpbnQgc2Rt
YV92NF80XzJfc3RvcF9xdWV1ZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMy
X3QgaW5zdGFuY2VfDQo+ID4gICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiAg
ICAgLyogQ2hlY2sgaWYgdGhpcyBxdWV1ZSBpcyB0aGUgZ3VpbHR5IG9uZSAqLw0KPiA+IC0gICBh
ZGV2LT5zZG1hLmdmeF9ndWlsdHkgPSBzZG1hX3Y0XzRfMl9pc19xdWV1ZV9zZWxlY3RlZChhZGV2
LA0KPiBpbnN0YW5jZV9pZCwgZmFsc2UpOw0KPiA+ICsgICBhZGV2LT5zZG1hLmluc3RhbmNlW2lu
c3RhbmNlX2lkXS5nZnhfZ3VpbHR5ID0NCj4gPiArICAgICAgICAgICBzZG1hX3Y0XzRfMl9pc19x
dWV1ZV9zZWxlY3RlZChhZGV2LCBpbnN0YW5jZV9pZCwgZmFsc2UpOw0KPiA+ICAgICBpZiAoYWRl
di0+c2RtYS5oYXNfcGFnZV9xdWV1ZSkNCj4gPiAtICAgICAgICAgICBhZGV2LT5zZG1hLnBhZ2Vf
Z3VpbHR5ID0gc2RtYV92NF80XzJfaXNfcXVldWVfc2VsZWN0ZWQoYWRldiwNCj4gaW5zdGFuY2Vf
aWQsIHRydWUpOw0KPiA+ICsgICAgICAgICAgIGFkZXYtPnNkbWEuaW5zdGFuY2VbaW5zdGFuY2Vf
aWRdLnBhZ2VfZ3VpbHR5ID0NCj4gPiArICAgICAgICAgICAgICAgICAgIHNkbWFfdjRfNF8yX2lz
X3F1ZXVlX3NlbGVjdGVkKGFkZXYsIGluc3RhbmNlX2lkLCB0cnVlKTsNCj4gPg0KPiA+ICAgICAv
KiBDYWNoZSB0aGUgcnB0ciBiZWZvcmUgcmVzZXQsIGFmdGVyIHRoZSByZXNldCwNCj4gPiAgICAg
KiBhbGwgb2YgdGhlIHJlZ2lzdGVycyB3aWxsIGJlIHJlc2V0IHRvIDANCg0K
