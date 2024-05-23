Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CBCC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 11:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369B810E196;
	Thu, 23 May 2024 11:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HG++IPfc";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F9210E196
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 11:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLR75TithuIDRLSfnsiQYbx2o0NIm+ShbXznI9i0x7GNjPmXarB9XLoV+4u1C5QteXUdJw9p/ZU8Ls006i/vOFjQn4RAYIrbHs7vtoMXtKcSbYGiTNsrbz5gIe5UoeCSn+aCaYwWgVtCPF4FDFT29HqL6BpxrgA+ouOXkAJ5xXuGVAlC1DOcoIXj7Oqrff0q0lAVh4XSr0xpdrnAO+83E31HYMsTVHxR6Qai9hKpAx1Z9UsxudZQQPdSLFo+g065jKTdlMzeM8fKgoquyLne01rLmHY1q3qPq0/0oGc5nZd5SYpf8Iwluihoth0ypcQ3CMPrZwh8FdsHJ//Z/lZurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BmsiUDeU3UJaDVROTLIrk+mTzwYlyBcSnrDXblwETs=;
 b=IhxkwqYWKNqdBxPA9xrB319VkxKwML1Dlg/NjwB3yJA3NerX/H43wVPaTzGlPq2yWgupDI5Q6LwLFhq2a45lO087qWiTDvS45I47vrV/KRpUd/bzS9dFRGuB4Z6zzm7oJ4gugXGkZt20qWO0Urnc1b8MeoanZYUQ0JPJVGvnFx24G50UotfqCwaH1jSRnhSYLU2GAhn2aEeA45PEwqmVOOWartSYUmNE7ibA+yL8FsAai1uNypTBGMVxGLJK7FWuwpOjU/FaK0wTXNxUODjuFjb+t2emGpLiDmbzjqexVozEeAfAdMXMSmfgBLWNEfbnuuRhQ7PBDqM1P32f8c921A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BmsiUDeU3UJaDVROTLIrk+mTzwYlyBcSnrDXblwETs=;
 b=HG++IPfcK5r06VqiH68lKGvFFEzn8bnNQsMxmu8gElXzV8iqnhPVOnOszOwTTgnwM3hEvvyKCeS8zW8CRjBtYjz7xnLlFSisEoiJbBWFY6O434pZ6GiDJ8llZZBs43E/1oskrFVS39/qSO9BPOLS7wC6l8Gs9ZvMyqHS9UQbhRE=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 11:36:20 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 11:36:20 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
Thread-Topic: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
Thread-Index: AQHarG1nW5oS5CkfwUKJjHmhvnayr7GkaWCAgABFTCA=
Date: Thu, 23 May 2024 11:36:20 +0000
Message-ID: <SA1PR12MB8599116F019C2EFFF427C50AEDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240522172721.14085-1-Yunxiang.Li@amd.com>
 <20240522172721.14085-4-Yunxiang.Li@amd.com>
 <5025dc06-8471-4f74-affc-1070fc7e6dca@amd.com>
In-Reply-To: <5025dc06-8471-4f74-affc-1070fc7e6dca@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5657162d-ae6d-4628-8c08-79d9a92cec89;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-23T11:24:24Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|PH8PR12MB7446:EE_
x-ms-office365-filtering-correlation-id: 6341bc70-3053-4fd3-271f-08dc7b1c9111
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SWloSEVsd1owbFYzc3JOaFF6S2RDTFJyTFBMaUoyTVdaSzVyaEZNU3htUXVD?=
 =?utf-8?B?ZVZ4NmtQQ0pKdTdKUCtKSmFxSXVZV3dEUkpUUmt4NVhEenhEdFBRM2x5ZlZ4?=
 =?utf-8?B?VzBpOVNvYXRTc3pndkIwM1hjcnFkNjF3bVYxdCtTYVdHakZxaHNMSjZrS0Q1?=
 =?utf-8?B?Y2dlbTFqU2k4NklSUkEvOEVJa3VEczk2bWZVOWVTcmVNeGNteUVCdnRLZURF?=
 =?utf-8?B?YVZPNExKS0UzM29WMjZQaHlLaUR6M21aSGR0SFFRRGxONmU3akhJaHZNbGV3?=
 =?utf-8?B?SEdqcXh1VytRSXlVU1JkZ0ZtSVlzNmlVZGl1dUxsYjlKazcreXdPcFhvb0ox?=
 =?utf-8?B?Mmk1WXBnUC8xWG5lZjY4ZUhzUWJDS3MreVVQV2luazArMmJONkdHSUNPd1Uw?=
 =?utf-8?B?ckdPcWpCM05VYWp0UmpodGo3Umw4VHplU0NoUEZYZEtheDFZOFJMb1Blc1Ra?=
 =?utf-8?B?cUFydG1aclNhTXNyV1ZleVcya2wyYThBWFJJanBodmpQb1AyRG9UaW9Fbjg1?=
 =?utf-8?B?L1Z4RzFSTG5zLzE3UVdCeUZDUkhVUG1SUzBoejhneW43UVArMGd4YmJjM2Mv?=
 =?utf-8?B?WTN5bGlsTjRyMVk1WXZBNFNGOHBkUFFqZ3pxZ21MVW9vUCthQ21TcUlQZE4y?=
 =?utf-8?B?d0FXT3JpTC9hNDFRdW54cExDUFRPYUVjU1JNdUxLN29DOHJDYVdDS1hkcklG?=
 =?utf-8?B?dTBnZ2dVamVTK0lyYkxZNTkxVFhxTFl2TXpTSVRoQ0ZBT0o1MkJQSHdtY1hH?=
 =?utf-8?B?U21vOVYxL3ZvZW14T0lVSnM4YkUxSmFBazgzaVR4WTBqUjUva29pLzZVbXFK?=
 =?utf-8?B?Q1NCaTVyRlZ3QjhaZCtON3g0NER3bFg0bFIxNlFJNlQrTStXeGI3aU9tMzJj?=
 =?utf-8?B?RHRGVFQvSGpJcDVOUUdqajUvQ1RDZ1ByZlpIS3ZEUFBWUThoK3lGLzFoS1JF?=
 =?utf-8?B?R09UV2RPRW45N1p3TXFwa1ZpNGlGaDhFS2E5bUFRRU50V1NuRUR4a0lUS2t5?=
 =?utf-8?B?MVY3RzlyVjNOUHdQa0JONTA1WjJ2ZnAwbEw2NnZHSUtxRlFGMjhZTGJTQitv?=
 =?utf-8?B?bHBQQXRFSks4UTYxb01JTlZDVzQyYVEvUnNGc3RraTBPYzlUOGU2dXdFZTd5?=
 =?utf-8?B?YWZUaStWTzVQRlBzMzg5dzcyYjM2S0ZUSlFDUlhMOGZEZHdhdXhVWGJDTTR0?=
 =?utf-8?B?ZWpXSEwxY0YrZkVoY2xZdENrSGNZcGZXOGRGVWI5QnUrVmd6eXBjbURRVnFR?=
 =?utf-8?B?a0Z3ZjlabncwN1c5UWdySnRRaFRlajVxTldnMGRLMFh2MUY0UURITlo2d0dI?=
 =?utf-8?B?NkhjYXdmZExCM24wc251S1pEYlZRSmFZVHl3RWlxUDRhZENEZU9GaHUyeWVo?=
 =?utf-8?B?S0tCT1Z1TkdDdzBvMDZwOGlPL1AvMmZwZmdpOTArRFgvUjNHWm5IcTN0QUpZ?=
 =?utf-8?B?TDhxTnBSdWdsUjJ0RWtLVEovcHVHVHpLNG1rMzZDK3Qyb1R6WUlGblRvZ1Iz?=
 =?utf-8?B?dHFmeVduNFZOOFpyVWpHMGw4TEZWNW1aKzNDa2M1QmhrWS9NYmdnb2dZNHd3?=
 =?utf-8?B?a2IyQklEa3lYN0h0bVppaUFqb1N2TnZ0L2ZENElEV0J5T1NmY0xMV2dqREk5?=
 =?utf-8?B?OTJpdzZUczBlQ24yY3BKYVJQQlVUZVk2eUNPMmJ1QzRlS0tPY1JHZ3FicitS?=
 =?utf-8?B?aU9kd2wzTUUvT2RnZVh3SjV6M3A3ZlR0TmJJUHR1dkhVcGJGeHpOY21oMkFr?=
 =?utf-8?B?Y1RSUUdGNDdiMjZneWdqQkdhQko3QUFLVm11ZDlFTkI2Z1VvajU4R0N3Y0pZ?=
 =?utf-8?B?bDNpZ1JnZDZLTTFPVHpndz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzByVi9HdXdTZ1pmU3JyVnlGWlh1YkpIT0xLL3l1N3h4eThjOFdXOW8wQ1Zs?=
 =?utf-8?B?RnZZTi9EM2F4Z0hUTTFON3lzZXV3VGdNSmZpL0VlZXNHUnlhb3VURmM1TXBG?=
 =?utf-8?B?Z0k5VjRRUWNyUUFkTjFZQ0RaSkljUDVNRmpGTUtmTHNGN25PTkVGUjkwOGdC?=
 =?utf-8?B?SFhZZ2JBa241VVFzRmE4bS9ESjJYd0pKak1JTUJ6L0ZGQ3hXR1k4SU1PVTdN?=
 =?utf-8?B?MWRwS2tIbC92UUZHRTVSMlJtZVZ1SE9leVlNYW10UUk3UzJReXhGWkUxMFN2?=
 =?utf-8?B?cm1zdWFORElMOTg0M25SblJVQU45b0Fldk95Y0loTW5IT01sVmIzQ1hJcUZw?=
 =?utf-8?B?Q0Q3R1d6QWhvOExaZWRzUkI5ZjJ2dnJLZ25abVYwZmFPUVl6VWZSOTZwbTdK?=
 =?utf-8?B?dW5XRXU5RWtTYW1qRWJlRlR2SlBQQ2dKQUdVd3NDMVA4cmV6YkJOSm1vZDYy?=
 =?utf-8?B?dkVmbkFKM044Z0RpNDU5QlJlaThRMmhkUks0S3NqL3pueGVRSFB0VDNVbGp1?=
 =?utf-8?B?UFEzRVBJMHM1ZDFnekUvWFZqU1VLZW5TeHhTRTB5STVYVXdSTFo5OCthcnFr?=
 =?utf-8?B?V1luYzVwd3FoTkFZQmJ5dUNNTGlxa2F0a1NpUndLbGFqVzBmZllBT2J5VXk0?=
 =?utf-8?B?SkIyOXVSOWZmSGNkejZ1bkh0RSs5dUhIZ0ZWcHRNTkFTd0R0NEJXcytoOHdw?=
 =?utf-8?B?SHlGOStoUnhZNWRPZFZxcE5QajlZbWh4enIrcWtDeEN4d2QzWTBBVXBSZjhH?=
 =?utf-8?B?bkNHZFJTUzh3emFIZk1RZzFFd28yVGhHMnFKeWdVWEl2N0s1aGkyOXlZL1Iv?=
 =?utf-8?B?NHZTU0w1QnZZOHVJUWhxeDhkQW05dEMxRGk4ZElhKzNXQnRuMDcrRXg4N1k4?=
 =?utf-8?B?VjFjcUNabEVyMUZpYzFEck9YVWNyK3JDMzVLQVFOcDhSTXhnVkpLNzhuQ294?=
 =?utf-8?B?Rm1zUFZiWHM0WStkRUN6bURyV1lIUzh4Rm1rU05yYlVpeFg5dW9weW5FU0tT?=
 =?utf-8?B?VGR6cHRCbk9LeDUxcFlTVXU2d09IL2h0RGM4MWJrOFQrSzhQQTR2czg1TDhI?=
 =?utf-8?B?ZFp0VDBPWmdGTnhkRmI3V0NMZEFxQTlTMjdrb1hXVkFhUzJ3UEFzSlhDNGdY?=
 =?utf-8?B?Mm03TWtEVGdWVG9nRllORWFMQkdpakc0RDBKbkxYbmp4ZWhjenpuSU90V3Fi?=
 =?utf-8?B?aHcwc0RNV0NUSDMyZjNUKzhZTHdzRXFrWEhJYmtoZG9HRTNhajJ4OHg4QXNF?=
 =?utf-8?B?L1NFaElaU2lteXBZS3JOVkdlSkFWeVF2WDY2em9HWGhhVXF4TXcvdzM0QVBh?=
 =?utf-8?B?YlZTWjRTZThKSU1TSWN5d2xESlFKV3FiemRjVldKZGlLMS9FWk53Z1JGWHZz?=
 =?utf-8?B?RzV1VDNuUmZpQWU5MFgzeTk2aE1kbFBWWGQ5N09EY2haRUgwdDdSUEJDQ0h1?=
 =?utf-8?B?M0t5RzhKUUliQ3Z1SzZHbGRJWWJUbXBXOHJVYXEya2c5Y1g4MmRIYkRZQzNi?=
 =?utf-8?B?Y3llRGJaaTB4NmROU3VKK1RuRWUxZ3NrcXpOSmFXMGk4RDlQR0tGSEM0dUZx?=
 =?utf-8?B?UXpnMUZrZXlLcXpTS292bHl6UG1JRHgxZzc5OEswOUNTUjExd2R5aFpENVFF?=
 =?utf-8?B?akZoMU9KYlhaUW1xYnZlL1JKNDVROXZFUkkwY3VJeEpaUVlVc2lmUUwyTC83?=
 =?utf-8?B?MWxpeG5HdmZNT1ZzYS94L2RmZkpCc0V2dU9zaHVUY0pmYXI4TStQR0R5RDRV?=
 =?utf-8?B?OGp3Q3JFZUtmR2pnYzVKaFJ4VmZQQUpnTXMvTHhZVXl2ZHlRQ0pPMzhLWG1O?=
 =?utf-8?B?OWc0RC8vNWJJYm1KV0I3dXdCTUxIejluemFxcHFvak9TbzVJOGFGOEUrdkU4?=
 =?utf-8?B?UEVZVU05QzZad25aYlcxUXlENmJ0TzFMajltVVl4eUFoWXdlTTNaN1lnOTFZ?=
 =?utf-8?B?OVk0dmVpVUlacnp3TmlHWC9VMFZzQk10dWI4di91U3pVbEFid1p0Skxpa01a?=
 =?utf-8?B?cU42L1pmdWNTY1cycEcyL0hXUy9zWUtpZWtlU2VmZ1cyL3VRSWpiWmhrcVc1?=
 =?utf-8?B?S1FUQm9rZVZkVTBwNE5nWmttZERuYmRrelludDFuSmtscXVVc05WZDlMdWFt?=
 =?utf-8?Q?Pibg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6341bc70-3053-4fd3-271f-08dc7b1c9111
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 11:36:20.2598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOkACBwihzoxxJ3RaNEfK6xtXIm5Pxd1S38C//8fo2U6rdFJFsqJBtenTl8QGNBmaQsOybHRed49zvpv7xDI0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
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
Cg0KPiA+ICt2b2lkIGFtZGdwdV9sb2NrX2h3X2FjY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldik7IHZvaWQNCj4gPiArYW1kZ3B1X3VubG9ja19od19hY2Nlc3Moc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpOyBpbnQNCj4gPiArYW1kZ3B1X2JlZ2luX2h3X2FjY2VzcyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldik7IHZvaWQNCj4gPiArYW1kZ3B1X2VuZF9od19hY2Nlc3Moc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPg0KPiBEb24ndCBhZGQgYW55dGhpbmcgdG8gYW1kZ3B1
LmguIFdlIGFyZSBzbG93bHkgZGVjb21wb3NpbmcgdGhhdCBmaWxlLg0KDQpXaGVyZSB3b3VsZCBi
ZSBhIGJldHRlciBwbGFjZT8gSSBqdXN0IHdhbnRlZCB0byBoYXZlIHRoZW0gbmV4dCB0byBhbWRn
cHVfaW5fcmVzZXQNCg0KPiA+IEBAIC01ODE2LDYgKzU4MTYsNyBAQCBpbnQgYW1kZ3B1X2Rldmlj
ZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAg
ICBnb3RvIHNraXBfaHdfcmVzZXQ7DQo+ID4gICAgIH0NCj4gPg0KPiA+ICsgICBhbWRncHVfbG9j
a19od19hY2Nlc3MoYWRldik7DQo+DQo+IFRoYXQgc2hvdWxkIGFscmVhZHkgYmUgbG9ja2VkIGhl
cmUuIFNvIHRoaXMgd2lsbCBtb3N0IGxpa2VseSBkZWFkbG9jay4NCj4NCj4gPiAgIHJldHJ5OiAg
ICAvKiBSZXN0IG9mIGFkZXZzIHByZSBhc2ljIHJlc2V0IGZyb20gWEdNSSBoaXZlLiAqLw0KPiA+
ICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBkZXZpY2VfbGlzdF9oYW5kbGUsIHJl
c2V0X2xpc3QpIHsNCj4gPiAgICAgICAgICAgICByID0gYW1kZ3B1X2RldmljZV9wcmVfYXNpY19y
ZXNldCh0bXBfYWRldiwgcmVzZXRfY29udGV4dCk7IEBADQo+ID4gLTU4NTIsNiArNTg1Myw3IEBA
IGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LA0KPiA+ICAgICAgICAgICAgICAqLw0KPiA+ICAgICAgICAgICAgIGFtZGdwdV9kZXZpY2Vfc3Rv
cF9wZW5kaW5nX3Jlc2V0cyh0bXBfYWRldik7DQo+ID4gICAgIH0NCj4gPiArICAgYW1kZ3B1X3Vu
bG9ja19od19hY2Nlc3MoYWRldik7DQo+ID4NCj4gPiAgIHNraXBfaHdfcmVzZXQ6DQo+DQo+IERv
bid0IGFkZCBoZWxwZXJzIGZvciB0aGF0LCBlc3BlY2lhbGx5IG5vdCB3aXRoIHRoYXQgbmFtZS4N
Cj4NCj4gV2UgZG9uJ3QgYmxvY2sgSFcgYWNjZXNzLCBidXQganVzdCBwcmV2ZW50IGNvbmN1cnJl
bnQgcmVzZXRzLg0KDQpIZXJlIGlzIHRha2luZyBhIGRpZmZlcmVudCBsb2NrIHRoYW4gdGhlIHJl
c2V0X2RvbWFpbi0+c2VtLiBJdCBpcyBhIHNlcGVyYXRlIHJlc2V0X2RvbWFpbi0+Z3B1X3NlbSB0
aGF0IGlzIG9ubHkgbG9ja2VkIHdoZW4gd2Ugd2lsbCBhY3R1YWxsIGRvIHJlc2V0LCBpdCBpcyBu
b3QgdGFrZW4gaW4gdGhlIHNraXBfaHdfcmVzZXQgcGF0aC4NCg0KPiA+ICAgICB1aW50MzJfdCBz
ZXE7DQo+ID4NCj4gPiAtICAgaWYgKCFhZGV2LT5nbWMuZmx1c2hfcGFzaWRfdXNlc19raXEgfHwg
IXJpbmctPnNjaGVkLnJlYWR5IHx8DQo+ID4gLSAgICAgICAhZG93bl9yZWFkX3RyeWxvY2soJmFk
ZXYtPnJlc2V0X2RvbWFpbi0+c2VtKSkgew0KPiA+ICsgICAvKg0KPiA+ICsgICAqIEEgR1BVIHJl
c2V0IHNob3VsZCBmbHVzaCBhbGwgVExCcyBhbnl3YXksIHNvIG5vIG5lZWQgdG8gZG8NCj4gPiAr
ICAgKiB0aGlzIHdoaWxlIG9uZSBpcyBvbmdvaW5nLg0KPiA+ICsgICAqLw0KPiA+ICsgICBpZiAo
IWFtZGdwdV9iZWdpbl9od19hY2Nlc3MoYWRldikpDQo+ID4gKyAgICAgICAgICAgcmV0dXJuIDA7
DQo+ID4NCj4gPiArICAgaWYgKCFhZGV2LT5nbWMuZmx1c2hfcGFzaWRfdXNlc19raXEgfHwgIXJp
bmctPnNjaGVkLnJlYWR5IHx8DQo+ID4gKyAgICAgICBhbWRncHVfaW5fcmVzZXQoYWRldikpIHsN
Cj4NCj4gVGhhdCBjaGVjayBkb2Vzbid0IG1ha2VzIHNlbnNlIG5vdyBhbnkgbW9yZS4NCg0Kc2Ft
ZSBoZXJlLCB0aGUgdHdvIGNoZWNrcyBhcmUgZm9yIGRpZmZlcmVudCBzY29wZSwgYWx0aG91Z2gg
SSB3YXNuJ3Qgc3VyZSBpZiB0aGUgb3JpZ2luYWwgY2hlY2sgaXMgY29ycmVjdCBvciBub3QsIGlz
IHRoZXJlIGEgcG9zc2liaWxpdHkgdGhhdCAhYWRldi0+Z21jLmZsdXNoX3Bhc2lkX3VzZXNfa2lx
IGFuZCAhcmluZy0+c2NoZWQucmVhZHkgYXJlIGZhbHNlIGJ1dCBhbWRncHVfaW5fcmVzZXQoYWRl
dikgaXMgdHJ1ZT8gYW5kIHRvIHdlIHdhbnQgdG8gdGFrZSB0aGlzIGJyYW5jaCB3aGVuIHRoYXQg
aGFwcGVucz8NCg0KPiA+DQo+ID4gQEAgLTY4NCwxMiArNjg0LDE4IEBAIGludCBhbWRncHVfZ21j
X2ZsdXNoX2dwdV90bGJfcGFzaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQxNl90
IHBhc2lkLA0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSAmYWRldi0+Z2Z4Lmtp
cVtpbnN0XS5yaW5nOw0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1X2tpcSAqa2lxID0gJmFkZXYtPmdm
eC5raXFbaW5zdF07DQo+ID4gICAgIHVuc2lnbmVkIGludCBuZHc7DQo+ID4gLSAgIHNpZ25lZCBs
b25nIHI7DQo+ID4gKyAgIHNpZ25lZCBsb25nIHIgPSAwOw0KPg0KPiBQbGVhc2UgZG9uJ3QgaW5p
dGlhbGl6ZSBsb2NhbCB2YXJpYWJsZXMgaWYgaXQgaXNuJ3QgbmVjZXNzYXJ5Lg0KPg0KPiA+ICAg
ICAgICAgICAgIGlmIChhZGV2LT5nbWMuZmx1c2hfdGxiX25lZWRzX2V4dHJhX3R5cGVfMikNCj4g
PiAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmdtYy5nbWNfZnVuY3MtPmZsdXNoX2dwdV90bGJf
cGFzaWQoYWRldiwgcGFzaWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDIsIGFsbF9odWIsDQo+ID4gQEAgLTcwMyw0NiAr
NzA5LDQyIEBAIGludCBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGJfcGFzaWQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIHVpbnQxNl90IHBhc2lkLA0KPiA+ICAgICAgICAgICAgIGFkZXYtPmdt
Yy5nbWNfZnVuY3MtPmZsdXNoX2dwdV90bGJfcGFzaWQoYWRldiwgcGFzaWQsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmbHVzaF90eXBl
LCBhbGxfaHViLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaW5zdCk7DQo+ID4gLSAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gLSAgIH0N
Cj4gPiArICAgfSBlbHNlIHsNCj4NCj4gVGhhdCB0aGUgbG9ja2luZyBpcyBtaXNzaW5nIGhlcmUg
c2hvdWxkIGJlIGEgc2VwYXJhdGUgYnVnIGZpeCBpbmRlcGVuZGVudCBvZiBvdGhlciBjaGFuZ2Vz
Lg0KDQpJIHdpbGwgc3BsaXQgdGhpcyBvZmYgaW50byBhIHNlcGVyYXRlIHBhdGNoLCBpbml0aWFs
aXppbmcgciBpcyBuZWVkZWQgYmVjYXVzZSBJIGNvbnNvbGlkYXRlZCB0aGUgcmV0dXJuIHBhdGhz
IHRvIGRyb3AgdGhlIHJlYWQgbG9jay4NCg==
