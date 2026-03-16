Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CB0F4644A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 10:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E61E10E286;
	Mon, 16 Mar 2026 10:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ASlNJ8CV";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320FB10E165
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 10:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gqhid5yeVLiLb3eq7kRdE/SH+6v3zSi4qxJr7BzG74qoTyICRy+cH9nz75HZkX4MtPpaPA43y+DESMIOm6gEKDZcZNTZZv5EWUAVnYhuUFU8bDtYKUKpNTCX9od5bwPWDSdqQmSNfZf4NbVnN+88jCGdvPdOwXBk1ZwkSUSVMKDW1AjGr0iCgy0cXoKh4OPhkQ19LVN9iiu96EROkhAwPfVOpJth3u+8lCPBDfvQc+V0jP6egq8HQqZlQQpfD5WtN2I7YWsWxW26AHub+5S/h03U51xgkkQ9I6p5FzlDwMXnWaZm2Vvo3aWgY02vqrNGpMVzjbZhdlJAPBiuoiKWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gcJINxYq2YH3Qd+guY1Z98Ahu4Pzv0I+bA+pWk/Uog=;
 b=jVlE23wJr7EfMvYKFIEH1sxQf1hSJ476HPrromBUvBU/AG5FZNlbObriOF7b5Dfp/n6cRJcwihwS0EyxQXYaTrJOZsBdB3+PPAYZYSpOJiKHjkYLVrPV3cwZyeeeDCTQxwrhX7/FwzJwnZNkgZYROJUl7ENUl9sA1cI9fzRpC/2mNLh3Q7S4dCb2DVJDRcPDxSWWWCIUraVh7I1Me3SiTrOgGz1J3WRKfkjKS0K2mjmFsGVSUuQBp+1dlnRqvHeQjIvVIZoahkiK6x7XRQudmK+MzCBEb93VSBYzL4zOuL5XEbPkzSEUkeh06EbStuB79c2Q31WXQx6W8B8Mkv7bhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gcJINxYq2YH3Qd+guY1Z98Ahu4Pzv0I+bA+pWk/Uog=;
 b=ASlNJ8CVHoqAlzLmHS3z7xg9dwTug5lble7BawLg89YGfwzzoulZaMEsbDp91awt7DFPF0lYS/jk8QceQQ12lk59OfeX3F/CwKdRyHNM4uoV4qehzgflA7nXFUmieLIEVK2GZkBJmjNksC9xpIFjOLa0y30QwHZvgokq/aCCJo8=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 10:45:16 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::ea90:cd3d:64e3:7297]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::ea90:cd3d:64e3:7297%3]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 10:45:16 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Xie, Chenglei" <Chenglei.Xie@amd.com>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH v4] drm/amdgpu: avoid KIQ HDP flush from VM CPU commit
 during reset
Thread-Topic: [PATCH v4] drm/amdgpu: avoid KIQ HDP flush from VM CPU commit
 during reset
Thread-Index: AQHcsY2whaaUQkmVt0Op/7qlGjqso7WpurwAgACoyQCABpvVQA==
Date: Mon, 16 Mar 2026 10:45:15 +0000
Message-ID: <DM6PR12MB43404FA78497B51EF4B90C2FFA40A@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <8738adb8-9c4a-45d3-b515-08c7cfbc5b29@amd.com>
 <20260311193123.2531557-1-Chenglei.Xie@amd.com>
 <SJ1PR12MB61212CEE0DBA45B1BD76768A8047A@SJ1PR12MB6121.namprd12.prod.outlook.com>
 <946d46d1-3778-4261-b1c4-9ccd60133246@amd.com>
In-Reply-To: <946d46d1-3778-4261-b1c4-9ccd60133246@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-16T10:39:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|SN7PR12MB6716:EE_
x-ms-office365-filtering-correlation-id: 5d8a2ac5-5a67-4f71-2c23-08de83491bf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|7053199007|38070700021;
x-microsoft-antispam-message-info: AjiulVbxuyqYQwn8WiILirwPPwh8Lbq8Wq3Ib8JQUZP2uIJ74RpUqeBYzq33iiXnc/y0xvuDp3bsUG8pxAN1XoyvWPUXpa0+zS8Tx1F6i1iNcXGQl20spQOYzFp408f/NiEaXJmBLPpt7H1Wr3kYiOXGeci/uDENVUwpSSfxDQVL99vTbXeHKRo4xYwCFVdnVDcnBXqsvippTMCexSqYJDjD+Hye0aYpC8EuLqkxH7hwaYXYn4hHxva8cVTxGgP/2kPIX0f2R7xJzQJtC2dtn+phN8KN9EV9t6AznD6jPIXuaE43Szex2iDyfnoOpKYa2xFNLJu/XKHFX80EwXIifqop86o1ACeBFY9yiMyFxcY6L4qJN7nVhiAXkRF5l6/HRM/pFba5/VGL+n4YYcEjwaUZlwa4Yk6gEdmmhUczRQNZyuw1fwG2iFeh/KP2eyLx+BGmYv383fTi4IyM4YBFB8mPkElTrdKccn+YmsRLcITPKaHQIM6ojte/N8Quz3IcDFzLLKXHg1RoZi9oFoHPrmXscZBKC0ghgoV4Y+jzu/Mi3N19fYn4pGhzumgX/VYGfO6hFTzbVr+ez9fDh7FISJ5DqLTae5VQT5m6e8wvPgT3tjSFznhCeHtm5FxgWA5cLYMze9/2mQuSIFbMu/BpzYS5lQKiPLtS+UhzonsrB2x1uvHcLOmrI2BPRYPm34Omf0i9N5HIhbU+BtW4WwRCxAU0PCeHhrAMwjAdNa3ULevb/BcnLrkv2GDBpo9sMsqPDh2JT8992RAAXBfJNiozhkYx9t5C3/l/tBOYCP2n/PI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlFrRzhRVkN5eHVmNkZwQ0FrRXlJcDBVUlZmeVVOWUJaYWlrRkwvMUd4eG1u?=
 =?utf-8?B?M2c2cTNiemdvV2tmK3JyeEpFVGJZMG9VOHdlNm1PdEFyZXdHTWZJNEd6RS80?=
 =?utf-8?B?eVRPbjRIcG9pa2w3amdQNmpHc1BiNS9yVSszZW1Zc2J6b1JzemZwbGJ2My8y?=
 =?utf-8?B?TnJPRFl5cHBuUlZGOVh3OEl0bTE3aUZCa1NCZnlPYnAwcHZPWjZiWm9POUpv?=
 =?utf-8?B?NzBPcHB2aUNxdW1wNU45NkUxQzBzTWh5WDJ3WVJ2UmMzM3Bsd3JJWjhaU1pS?=
 =?utf-8?B?WGtINW5neEIrS3BkRXpZd0lpa1pDSExLbW9yOWJ5YnVnT1V4d3NtcUt3eS9B?=
 =?utf-8?B?c3pkZFR4S3kvbHMvdmlObkZSOVduWnppYlptZ1lxOUtIYzBuUE8zbmFhZGpy?=
 =?utf-8?B?SEZwbjBuaW02aEtqZFF5ejV1eVc3dTMvc1ozUC82UU1CMndDMjliVXdvY3pk?=
 =?utf-8?B?cm5qbUVKZFR3dlhDeGpCaWNoREZLSUJGMmZrSVJMZVJmZFhTVkVxbW5UUUdO?=
 =?utf-8?B?US8xd0pwTUxPRVhxY2V4MWVqUWVNYm5uNFh1aWtGem85c0ltU0pEUncwbmRu?=
 =?utf-8?B?eVBjbVZrZVczbklSZ0x3ZXRMZGl4bFVqNFhwOEZDLzVSWG1wUW1zU0dBQzlz?=
 =?utf-8?B?RmFZaHdOS25wbXdmcmFvTGgyMXZrN1E5YWNkaWVZL2tKazMvb3NVek9XbTRJ?=
 =?utf-8?B?T0pQWUxTd3ozMFdVdmxxa2hZVDd6STY2WU95Y1hWYklVU2RPSEdKWWVmbGUz?=
 =?utf-8?B?YkpLTmd1T0V6UFJ0MUdDVTV2S0g4UGV5bGNTNkR0K29EL2VjRDBlMStlZ2FG?=
 =?utf-8?B?YmxFMXpzc09keGhCa20xOEJDbUkzQVpMOSswRTBPaXNXZUpWRlpDTitXZFRS?=
 =?utf-8?B?UXpDeFVLS1BQVXVXT2tBNXB3ZXRKOW9NdUtnKzNqa0hWakpVTURycTcybE16?=
 =?utf-8?B?WGtFc00xSkFHK1V4V2RET2xsb2lZNWNuZThMWWwrTXFRM0JaNERPcnpXSTI3?=
 =?utf-8?B?am9EKzRxOCtFYkQyWnNSVFp3d2R6RDJPeFkyb0JxUWMvMTByN1hLcFBNSnNT?=
 =?utf-8?B?Qlk5SzY3aWVqQU0rQ3ZYdFBlWnF4dVlKbzk0STE0Smt6UE84RjF5TkdMWk1t?=
 =?utf-8?B?c0x0TW9oajVxU3YvWHh3a1Mxc081Tkc4cVpVTDBZTjBveFk1NVlWd1lqWlha?=
 =?utf-8?B?OWFXSkdNelNac3ZweGRPVGtLRVk1dmtXRlR2cWdJMEZBUURMbTNLOWZGd1pm?=
 =?utf-8?B?ckFBUk90c2dwQ2FUVFlNbFVCTC93dnVzeWlTRUM4UE1aKzg2d0FTMmY1QWpU?=
 =?utf-8?B?MGJHekRZdCtpTU5tZlFrZSt2MzRScHliNTdVcVNwUTh0WGNlRGN2MjNmeHpl?=
 =?utf-8?B?cjNtMHU5TXNBd2VaZjRYaFQ1Wm00RVhGdzlDRjJOUk5TV2laV0oyZkRCdkF2?=
 =?utf-8?B?NkJBRnJibHA1R2ZqcDc0WW1WajlQYlVpSmlmVmhNeDZBK1ZvNVdqWUhKWFVF?=
 =?utf-8?B?V0tyc0ZuRHBvV0lDV3c1RWgzb2dUenNlbjF5ek9pK3hHVFFrMUFIOEVDdFBm?=
 =?utf-8?B?b2lUNVlITWdDK2pYTFNORXF5YW5JaEpRQTdGeWIyaFRqQ0RNOEZoVW03dVkr?=
 =?utf-8?B?Nk9XNFkzUkxma0hRV1lmb1Vrc2tWUG9zdGdXYjJGVm0wREMvYnljU0pXZGg4?=
 =?utf-8?B?RFhUVllEbldiMDNGUExaNGhvTEUrY3JybnNTdVFocHNiUThYcmdER21tLzdK?=
 =?utf-8?B?b25lNllhZ1FubUsyR0hmd2pIT3E1bUdxTzlxdER0UVBjZmJpWjBVbUhLN28v?=
 =?utf-8?B?cmdmR0VBKytkTVBNdzc0bElzdzd3OFBxSHVwZ0FiQk5VVGt1WWpTNzJBUkpO?=
 =?utf-8?B?eGpRaE14dEk0RnFTL2ZWYWJpSEd6OGRwbU1FcktjKys2ZkxnZDRkZUpKcjRn?=
 =?utf-8?B?U3F3UnVDR2ZUZE80RkZkZGx2QVg5R1d0aHJtTzRFNkZVS1BUN3dkby9lQnVY?=
 =?utf-8?B?Z1VoYytBc1F5eDlFVHNGa0RuZjhEbGM3TWZjTGl2SXVQZVZsQWtnclBmdjVY?=
 =?utf-8?B?SXcyVTRhVjdIcTFPUjJXZHc5SE9JcXE5L3F2djBSTlV2ZndkMFdKZEFFc2Fr?=
 =?utf-8?B?M1RCa3V0V2YyeGdtS3lKOEV5WVE5b1B5WGtKd2J2dkZNNXR2VVFmOS82cU9G?=
 =?utf-8?B?UEhwdkF1WWswdEFnVFhudHNBM04yMFN2VEpLRlBYbFVVZEUrZlN1aU10b3hn?=
 =?utf-8?B?eFEzYnUyMHNDUW1FSjRvNWtvMU14cUt2c2grYWdVOE1yQU9uUExTb1VKSGg2?=
 =?utf-8?Q?PZMZ+g3IzTCLThTpxZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8a2ac5-5a67-4f71-2c23-08de83491bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 10:45:15.7388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RP/Ztcry+cXpgPohjJcsXkfUnMcpp6H2peAjbM2GQCu3mvzs0OxQJ8W/CENcb3F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716
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
Cg0KSG93IGFib3V0IGRvIGZvcmNlIGNvbXBsZXRpb24gYWZ0ZXIgYW1kZ3B1X3ZpcnRfcG9zdF9y
ZXNldCB0byBhdm9pZCBhbnkgcG9zc2libGUgZmVuY2UgY29ycnVwdGlvbiBkdXJpbmcgcmVzZXQ/
IEZvciBhbWRncHVfZGV2aWNlX2ZsdXNoX2hkcCB3ZSBhbHJlYWR5IGhhdmUgYW1kZ3B1X2luX3Jl
c2V0IGNoZWNrIGluIGFtZGdwdV9raXFfaGRwX2ZsdXNoIHNvIGNhbGxpbmcgaXQgc2hvdWxkIG5v
dCBjYXVzZSB0cm91YmxlLg0KDQpUaGFua3MsDQpWaWN0b3INCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3Rv
cC5vcmc+IE9uIEJlaGFsZiBPZiBMYXphciwgTGlqbw0KU2VudDogVGh1cnNkYXksIE1hcmNoIDEy
LCAyMDI2IDE6NDUgUE0NClRvOiBYaWUsIENoZW5nbGVpIDxDaGVuZ2xlaS5YaWVAYW1kLmNvbT4N
CkNjOiBDaGFuLCBIaW5nIFBvbmcgPEplZmZyZXkuQ2hhbkBhbWQuY29tPjsgTHVvLCBaaGlnYW5n
IDxaaGlnYW5nLkx1b0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFlhbmcsIFBoaWxp
cCA8UGhpbGlwLllhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjRdIGRybS9hbWRn
cHU6IGF2b2lkIEtJUSBIRFAgZmx1c2ggZnJvbSBWTSBDUFUgY29tbWl0IGR1cmluZyByZXNldA0K
DQoNCg0KT24gMTItTWFyLTI2IDE6MTAgQU0sIFhpZSwgQ2hlbmdsZWkgd3JvdGU6DQo+IFtBTUQg
T2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+DQo+
IEhpIExpam8sDQo+DQo+IFBsZWFzZSBoZWxwIHJldmlldyB0aGUgbGF0ZXN0IHBhdGNoIHZlcnNp
b24uIFRoZSBmYXVsdHkgc291cmNlIGlzIHRoZSBhbWRncHVfdm1fY3B1X2NvbW1pdCgpIHJlcXVl
c3RzIHRvbyBtYW55IEhEUCBmbHVzaCBjb21tYW5kcyB0byBLSVEgZHVlIHRvIFZNIHBhZ2UgdGFi
bGUgdXBkYXRlcyBkdXJpbmcgcmVzZXQuDQoNCkRvIHlvdSBoYXZlIGEgZG1lc2cgbG9nIGZvciB0
aGlzIHRyYWNlPyBJZiB0aGlzIGlzIGhhcHBlbmluZyBhZnRlciBoYXJkd2FyZSByZXNldCBpcyBp
bml0aWF0ZWQsIGl0IG5lZWRzIGEgY2xvc2VyIGxvb2suIFdlIGRvbid0IGV4cGVjdCBwYWdlIHRh
YmxlIGNvbW1pdHMgd2hpbGUgaGFyZHdhcmUgcmVzZXQgaXMgb25nb2luZy4gQ29weWluZyBQaGls
aXAuDQoNCj4gVGhlIG5ldyBjaGFuZ2UgZml4IHRoaXMgYnkgdXNpbmcgbm9uLUtJUSBIRFAgZmx1
c2ggcGF0aCB3aGVuIGluIHJlc2V0LCBhbmQgYWRkZWQgZXh0cmEgZmVuY2UgZm9yY2UgY29tcGxl
dGlvbiBvbiBLSVEgcmluZ3MgZHVyaW5nIFNSSU9WIHByZV9yZXNldC4NCg0KSWYgSSByZW1lbWJl
ciBjb3JyZWN0bHksIHRoZSByZWFzb24gdG8gaW50cm9kdWNlIEtJUSBiYXNlZCBIRFAgZmx1c2gg
d2FzIHRoYXQgdGhlIGRpcmVjdCBvbmVzIGRvbid0IHdvcmsgZm9yIG11bHRpLVZGIGNhc2VzLiBJ
IHRoaW5rIHlvdSBjYW5ub3QgcmVwbGFjZSBvbmUgd2l0aCB0aGUgb3RoZXIganVzdCBmb3IgZmx1
c2ggaGFwcGVuaW5nIGluIHJlc2V0IHNjZW5hcmlvcy4NCg0KVGhhbmtzLA0KTGlqbw0KDQo+DQo+
IFRoYW5rcywNCj4gQ2hlbmdsZWkNCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogWGllLCBDaGVuZ2xlaSA8Q2hlbmdsZWkuWGllQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgTWFyY2ggMTEsIDIwMjYgMzozMSBQTQ0KPiBUbzogTGF6YXIsIExpam8gPExpam8uTGF6
YXJAYW1kLmNvbT4NCj4gQ2M6IENoYW4sIEhpbmcgUG9uZyA8SmVmZnJleS5DaGFuQGFtZC5jb20+
OyBMdW8sIFpoaWdhbmcNCj4gPFpoaWdhbmcuTHVvQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgWGllLCBDaGVuZ2xlaQ0KPiA8Q2hlbmdsZWkuWGllQGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFtQQVRDSCB2NF0gZHJtL2FtZGdwdTogYXZvaWQgS0lRIEhEUCBmbHVzaCBmcm9tIFZNIENQVSBj
b21taXQNCj4gZHVyaW5nIHJlc2V0DQo+DQo+IER1cmluZyBHUFUgcmVzZXQgKFNSLUlPViksIGFt
ZGdwdV92bV9jcHVfY29tbWl0KCkgaXMgY2FsbGVkIHJlcGVhdGVkbHkgZm9yIFZNIHBhZ2UgdGFi
bGUgdXBkYXRlcy4gRWFjaCBjYWxsIHVzZXMgYW1kZ3B1X2RldmljZV9mbHVzaF9oZHAoYWRldiwg
TlVMTCksIHdoaWNoIG9uIFNSSU9WIHJ1bnRpbWUgdGFrZXMgdGhlIEtJUSBwYXRoIGFuZCBzdWJt
aXRzIGEgZmVuY2UgdG8gdGhlIEtJUSByaW5nLiBUaGF0IGZsb29kcyB0aGUgS0lRIHJpbmcgd2hp
bGUgdGhlIEdQVSBpcyByZXNldHRpbmcuIEFmdGVyIHJlc2V0LCBoYXJkd2FyZSBoYXMgY2xlYXJl
ZCB0aGUgcXVldWUgYW5kIHRob3NlIGZlbmNlcyBhcmUgbG9zdCwgYnV0IGZlbmNlIHdyaXRlYmFj
ayBtZW1vcnkgYW5kIHN5bmNfc2VxIGFyZSBvdXQgb2Ygc3luYywgc28gYW1kZ3B1X2ZlbmNlX2Vt
aXRfcG9sbGluZygpIGNhbiBoaXQgLUVUSU1FRE9VVCBhbmQgYmxvY2sgZnVydGhlciBLSVEgdXNl
Lg0KPg0KPiBGaXg6DQo+IC0gSW4gYW1kZ3B1X3ZtX2NwdV9jb21taXQoKSwgd2hlbiB0aGUgZGV2
aWNlIGlzIGluIHJlc2V0LA0KPiAgICB1c2UgdGhlIG5vbi1LSVEgSERQIGZsdXNoIHBhdGggKGFt
ZGdwdV9oZHBfZmx1c2gpIGluc3RlYWQgb2YNCj4gICAgYW1kZ3B1X2RldmljZV9mbHVzaF9oZHAg
c28gVk0gdXBkYXRlcyBkdXJpbmcgcmVzZXQgZG8gbm90IHN1Ym1pdCB0byB0aGUNCj4gICAgS0lR
IHJpbmcuDQo+IC0gSW4gYW1kZ3B1X3ZpcnRfcHJlX3Jlc2V0KCksIGZvcmNlIGNvbXBsZXRpb24g
b24gYWxsIEtJUSByaW5nIGZlbmNlcyBzbyBhbnkNCj4gICAgcGVuZGluZyBmZW5jZXMgYXJlIHNp
Z25hbGxlZCBiZWZvcmUgcmVzZXQuIFRoZSBvdGhlciByaW5ncyB3ZXJlDQo+IGhhbmRsZWQgaW4g
YW1kZ3B1X2RldmljZV9wcmVfYXNpY19yZXNldCgpDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENoZW5n
bGVpIFhpZSA8Q2hlbmdsZWkuWGllQGFtZC5jb20+DQo+IENoYW5nZS1JZDogSTk1NDA0Y2UzNDhh
ZDU0NmRkZmYxZWEzYjk1YTNmNzkwMjk5ZWI3YWENCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYyAgIHwgMTEgKysrKysrKysrKysNCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fY3B1LmMgfCAgNyArKysrKystDQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYw0KPiBpbmRleCBmMDFmMzg1MDkx
MDgzLi41OTk4ZTBhMDRkNzYwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmlydC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92aXJ0LmMNCj4gQEAgLTExOTEsOSArMTE5MSwyMCBAQCBlbnVtIGFtZGdwdV9zcmlvdl92
Zl9tb2RlDQo+IGFtZGdwdV92aXJ0X2dldF9zcmlvdl92Zl9tb2RlKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZA0KPg0KPiAgIHZvaWQgYW1kZ3B1X3ZpcnRfcHJlX3Jlc2V0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KSAgew0KPiArICAgICAgIGludCBpOw0KPiArDQo+ICAgICAgICAgIC8qIHN0
b3AgdGhlIGRhdGEgZXhjaGFuZ2UgdGhyZWFkICovDQo+ICAgICAgICAgIGFtZGdwdV92aXJ0X2Zp
bmlfZGF0YV9leGNoYW5nZShhZGV2KTsNCj4gICAgICAgICAgYW1kZ3B1X2RwbV9zZXRfbXAxX3N0
YXRlKGFkZXYsIFBQX01QMV9TVEFURV9GTFIpOw0KPiArDQo+ICsgICAgICAgLyogRm9yY2UgY29t
cGxldGlvbiBvbiBLSVEgcmluZyBmZW5jZXMgc28gcGVuZGluZyBmZW5jZXMgYXJlIHNpZ25hbGxl
ZC4gKi8NCj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9HQ19JTlNUQU5DRVM7
IGkrKykgew0KPiArICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gJmFk
ZXYtPmdmeC5raXFbaV0ucmluZzsNCj4gKw0KPiArICAgICAgICAgICAgICAgaWYgKCFyaW5nLT5m
ZW5jZV9kcnYuaW5pdGlhbGl6ZWQpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVl
Ow0KPiArICAgICAgICAgICAgICAgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9u
KHJpbmcpOw0KPiArICAgICAgIH0NCj4gICB9DQo+DQo+ICAgdm9pZCBhbWRncHVfdmlydF9wb3N0
X3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5jDQo+IGluZGV4IDIyZTJlNWI0NzM0MTUuLjUwYWI5
Zjk2MDQ4MzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bV9jcHUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1f
Y3B1LmMNCj4gQEAgLTIxLDYgKzIxLDcgQEANCj4gICAgKi8NCj4NCj4gICAjaW5jbHVkZSAiYW1k
Z3B1X3ZtLmgiDQo+ICsjaW5jbHVkZSAiYW1kZ3B1LmgiDQo+ICAgI2luY2x1ZGUgImFtZGdwdV9v
YmplY3QuaCINCj4gICAjaW5jbHVkZSAiYW1kZ3B1X3RyYWNlLmgiDQo+DQo+IEBAIC0xMTIsNyAr
MTEzLDExIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2NwdV9jb21taXQoc3RydWN0IGFtZGdwdV92
bV91cGRhdGVfcGFyYW1zICpwLA0KPiAgICAgICAgICAgICAgICAgIGF0b21pYzY0X2luYygmcC0+
dm0tPnRsYl9zZXEpOw0KPg0KPiAgICAgICAgICBtYigpOw0KPiAtICAgICAgIGFtZGdwdV9kZXZp
Y2VfZmx1c2hfaGRwKHAtPmFkZXYsIE5VTEwpOw0KPiArICAgICAgIC8qIEF2b2lkIEtJUSBkdXJp
bmcgcmVzZXQ7IHVzZSBub24tS0lRIEhEUCBmbHVzaCAqLw0KPiArICAgICAgIGlmIChhbWRncHVf
aW5fcmVzZXQocC0+YWRldikpDQo+ICsgICAgICAgICAgICAgICBhbWRncHVfaGRwX2ZsdXNoKHAt
PmFkZXYsIE5VTEwpOw0KPiArICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgIGFtZGdwdV9k
ZXZpY2VfZmx1c2hfaGRwKHAtPmFkZXYsIE5VTEwpOw0KPiAgICAgICAgICByZXR1cm4gMDsNCj4g
ICB9DQo+DQo+IC0tDQo+IDIuMzQuMQ0KPg0KDQo=
