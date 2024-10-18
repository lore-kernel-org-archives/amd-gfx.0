Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC04D3DEA9
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 18:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DD810E1AE;
	Fri, 18 Oct 2024 18:45:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xWALc7Mu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0CD010E1AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 18:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4xEs6qlyF8q46lDgOdFXPFU6jwvVu3NE+qgQu5AvJ/CE96frxbYRdtUb+3HjleRWITiA22fNFfnMKqGQ+LgKnyUcCTY4YLj+aTrcDky4H4p6XA5B6vNahGN5OwAI5X/kYWkimSBgYUhhYYN79c4679ZVMU+tC6xbX32Grrr1fn8FidJORRh3Ud7Oo60NYx4g/C4GMtBN14BNhTWzJZw7tH92JdCm8RnzZdlA71/mclDUFa4Vuo9GnJIEvSuvW5vALo5FFhXPX7LAF3e5IBPbh3CYDqIS6uS0lImfsn245SIGhBHKHhz7vX+B7RnX7Z4ITGj91wKIPMjl9V7AndnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3ou9BoMAIYv6VNluEqOLROIlUKbOWUSPGNoX/iyfMw=;
 b=cUu+26CzfTV+pK8QgID8gCsaqBOnuGsVEl40FBjiI3wUy/UGuR0G2uD831QnuKWSfWnXiW290Rcf67pLfcDVks9CKDoqAs+79kobheSfeo/GhokMx2IAE45xS7AJVRTAYcqQf6DLw2xQCrjT0r+R1vW7GPAjjIdVqsEY/WGEPNVl8d6+S8Gy1X9bVd9Ho+HPhO9UY6S+YU9GWnGPoOtePj3ANt5H+P6GKcpLsfzxnWq2B3/lQIbLsFfQx3pwhGSDRqDCUGWhS0JtX76xRY8enqInGIVtM28MAJq96iywJ2Z2zm+R3kPDW9KN3Z15REMg9fh/1MEBkHiGq3wHuPV0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3ou9BoMAIYv6VNluEqOLROIlUKbOWUSPGNoX/iyfMw=;
 b=xWALc7MunGqTAg/npLTxsjTu4trKS0fICQKZaxBdBJybxpdRUuwAHrb44s9p3I8vG8i0I+cNAG4LS3qObmCIMdlgB9ExagQ5BHNmRrdOxRPVb4jOvhDiYlDv/BFan30gcidIW6Oe93xqUU5tuhSLiTPP7fLz9bA8QSez8YIjJuw=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 18 Oct
 2024 18:45:32 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%3]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 18:45:32 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Cornwall, Jay" <Jay.Cornwall@amd.com>
Subject: RE: [PATCH] amdgpu: Don't print L2 status if there's nothing to print
Thread-Topic: [PATCH] amdgpu: Don't print L2 status if there's nothing to print
Thread-Index: AQHbIXAoMycVwksvl0e2M2wPpbzyGLKM2BgAgAAAq1A=
Date: Fri, 18 Oct 2024 18:45:32 +0000
Message-ID: <BL1PR12MB589808A68933C00BA027E4C285402@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20241018151214.96717-1-kent.russell@amd.com>
 <d4fc0aff-07a8-4ed3-a9db-f0bfaa335a8b@amd.com>
In-Reply-To: <d4fc0aff-07a8-4ed3-a9db-f0bfaa335a8b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=40f82945-00d6-4c9c-8d60-863a28d9dbad;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-18T18:45:02Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|IA0PR12MB8745:EE_
x-ms-office365-filtering-correlation-id: 691974b0-79a8-4387-42c5-08dcefa50bae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFMvTFBmU0hLdEJLM0FyMWNqWCtJL3FJMFZhVUZVYkdVOXg2dnMvaUVmZzFN?=
 =?utf-8?B?SDh1T3BvQ29pSzRlU2lXZ1oyUzIwL1ZETGd4bzdGYTU0SG9RSG1kS3dNeGJZ?=
 =?utf-8?B?RitKdzVKU0lyMFloVmZ3UHV6Yys5eHlCdmdkaVJOVThJSDRxbDVMdHRrTXpp?=
 =?utf-8?B?dndJSXBUa0JjcFU5MFB4UnBuUUI5eXJQT21yOWNSY0phdkE5Z2IxeU1vRHBX?=
 =?utf-8?B?UHVSNjIvb2ltOEtZUVdjektPR1lYSUJ1blNXUHJ4ZjhJTkZEY3RTVXVFWmp0?=
 =?utf-8?B?R0pGd1FMQ3BiQjJ2SWxuaVA5ZmpmZFA2Nmx1UG9IZW5jeTB3NmR2N1JWL0Zx?=
 =?utf-8?B?T1hvdHRwUDhUcHV1NDlMTFU4UXNuMVJKdk9oUnVGdmNDeTF6NzZ5bWRwNXJo?=
 =?utf-8?B?UVFRVDBEWlM3ZEh5Zjh3Zi9vbEpSbWR5NG1CQnBFeWMrWUZETjhKU3FhclVK?=
 =?utf-8?B?WDlrSWtMY3lGdUNhSk1CblJMTnpvdWpScnd6ZWZzcXNzS1RtZE13NDN6UHB4?=
 =?utf-8?B?Z3NhdlJIeXN1MDFQZUVsUHdKeVJnU0pWWWRPMGdYbVJZOWNSWHYwZzhyOG1M?=
 =?utf-8?B?M3lWeE4vWTJKQU1PNThiVmRJYXBlOXlCY3FjN3FuQ21nS1FrYTB6VExlSVJI?=
 =?utf-8?B?bUJLaDNZekRkQzNpMXRGZnVTdXZGWVJRc2VJMXFHdU9uWE1UWmQzQzQ4STVi?=
 =?utf-8?B?eWhNamp6WFhnMkVwU1N0emVCSjBtQW5kaDJGSkEzNTUyR01BWlVtSDB6UEY3?=
 =?utf-8?B?YUxQblYvQlJUUVZmZU5TRzRtaTVLQXd0cHVsU1VUeG1SckdEQ0lCSmQwemNV?=
 =?utf-8?B?K3JYWWQ4TmJpVjVtM0pFVC9iNDN2TG5vNXoxNUEwYzdGc2FYRElDYi95TXZa?=
 =?utf-8?B?VTAvaWV2REppMllTdGprTlhPUGUrc3FRMmN4OWdYVWdQckJLVlg0aC9YWndO?=
 =?utf-8?B?ZHYzQVVLMk52ZlhvMzdDME1GdGZUNU9JR2tWOEpBdUp4dkN3NTFKVFFidEs0?=
 =?utf-8?B?a09mY0Z3dDArRkZna1lPYVBLZjFrRUVMbmhWeVozdnBxSFBvNlQ4dWRDcnIy?=
 =?utf-8?B?WFJadEJHQ2FpVTkxbW1SL0MxdVdKVlMxVnBWWEpkTjFjZDFXckhMajJHL0xP?=
 =?utf-8?B?QXN2SjJKSGQ1ZkN4aTRhNEl1U3gyNnNDclgvd25qYS9VZjRDa0dZM3ZBSjF3?=
 =?utf-8?B?ajBrd3VJZUtmR2FyakVnN0ljN3dINXZBQUgvcElKZit5Ym9JeS90MmI0cDZG?=
 =?utf-8?B?VHdPenplRkdWeEFWVC9pQUhwUEJtVHVvMStyREtwYW1nK3Q4cHZjNlNoZlJy?=
 =?utf-8?B?d2hYYkhCTEkrNWxadnBKaTBXMVhOZk5aWGp1NlFidlRLMXB1UkNYNm8rR2ls?=
 =?utf-8?B?Qkg2ckpoTVNmaXlIZHdQczVwdkxheVlBSi9CQ0xabFNqR01lNVlhbG5FNGp6?=
 =?utf-8?B?SEZ6dklPMGxuT1gwZTgyL083MVFlNzlvOFJSSHpaK1hDUUcxaDZYY25vWXIy?=
 =?utf-8?B?aGZFOHlURUZSWXhnck1pRjhHOFVWWmpxWXJHMDEwd1haYkgzbEVjNThCM3ll?=
 =?utf-8?B?NnJmOVV4Y0pyLzZjVHJRY2JJOVRMWFdaR2dDa01UeEhqR3VPZk1wdGRacEYz?=
 =?utf-8?B?ZXVtRUdpTDYzU1ZSZmgrcEZRQ0FoYlJCRC9Qa21oa1N6eTVYK0dJNWREWmJN?=
 =?utf-8?B?YTJLL0M5UnZOZzdFK3NJdW55djgzRXhmUFcydFpPeEI4cWlBdUVKYVVCZEtm?=
 =?utf-8?B?dDkrUkNnenN1RGtiZmdUTGNaeDdXejJDRmdFc2U4dFVISHp2dldFQkcyL09p?=
 =?utf-8?Q?6QrwJNs9AGEPmAUkMCsUX9Kew6ot5YYip5VcY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzlhSXlnQVl4NEdObSs5KzllenB1WWxlbVFIL1kxemJQN1NRVkQ3d21tWUFO?=
 =?utf-8?B?am9sQWpqNVRFREx6Y0l0SmptOVBaRXV5T2NxK2xaZW5Bc1ptZDRTNGpUODZw?=
 =?utf-8?B?ckZHcVV6MXY3cGlHVFd5YXpHc3dWcTJwYVBVT1pQNnp4ZHRORTNsTjJMTmV6?=
 =?utf-8?B?aEVNTk1NeHl3WXZ5aWJSK3hqMjM4VG13YXNaa0UvMnBFVHdsRDkyaFlOM3Zp?=
 =?utf-8?B?Vjg3SXhPU3RpTmk0N2dINU42NjJpMlV6WERHNVl4VmRVbVVJN05PKys3RHNX?=
 =?utf-8?B?ZGtIUmpPd2tSMUdIcThNOW9mMWNGQTJ5cFk2eEgvbmljQXN2NWFHS21MZHFa?=
 =?utf-8?B?b3FSL01lNVZMcTBZT3lDQ1VNMzQra2U2Z2ZjU0MvUzYyMTF3dmEyeFN2ckkz?=
 =?utf-8?B?RW04c1kyYiszZ0VETTBNZEVzTldoS1Q1VjZ2Y0Y2RDlWYjZ1R1MydVhFU1Rt?=
 =?utf-8?B?ME5GU2xNV3NsTGNERkJtTHVsSThIa3hCODlqNDlUS3NidTBpMmdSSTN3OHhU?=
 =?utf-8?B?ZEFUcWpFallNcXNETXJZRWJUYkNaeDlBWHZMbVY0VFoybmFHaGNJclFaTC9a?=
 =?utf-8?B?Z3pSMDRmVHRhK0VPSkVIa0JZUGp1cHBSVVNOS0xoQ1FlZ3VyVUlZVGMxMWFk?=
 =?utf-8?B?dHh2RzhRWGR6UGhTS09qeVpINVIyU1c3bW1nbU9Tdkd5T3F3ZGNERXg2bS9w?=
 =?utf-8?B?YS9Ic3ZvYTV6Q05HdTZaUndHWHRybGFtNDFnbSt6akRUMC9wYy9acWFMRkVY?=
 =?utf-8?B?NDNlS2JlQXFEaW9vanRVNjVlL0FxM2pZM2tVMG1tVTlXelZEME9mZVFXT0lq?=
 =?utf-8?B?Wk10SlVXV24rYmlWWUdYU21RdzBWRXhBUG1NZTlJSDFIc0RaWUVBcjBBR050?=
 =?utf-8?B?MVlxdFpPUXBpeUh3SG1iNGVmMzgxL0tSSFk2cUZRZ0M3dHd1RjljamJ0RSs4?=
 =?utf-8?B?QTFiYlhLWVlia2lPSDlwZGVPNkUxd2RkeTRVZGVUSC9QeFNOWU9TRzJGK3A2?=
 =?utf-8?B?NzZPRUd6RlQ2Ynk3SS82SVNaUE5PSWI1YTVGdUlkcnFOQ2F2SWlFRWdmWkJ1?=
 =?utf-8?B?d0tRWGZtTWhtS2VLOTB5ME9YNG9LalRwYnpGMXBzYjBBNGx2SDBsWnpRSytY?=
 =?utf-8?B?UXVIbGVhTGw1MFYxWk96amR4MmZjU08zQ00xeldORmZPd3dSQjhBUGZ4YTR1?=
 =?utf-8?B?ZUo4aVVEbVhZZUk5OEpEQnd0dnZ5M0V1V3ZIUVdMcEZ6Rm9mUzNIR2N4UzJq?=
 =?utf-8?B?SW9FR0pwckJVbTNLMzJ3K0lLZ1pQQk8vbGZwM3NVTUpPQ25zM1hCVlZqSTBD?=
 =?utf-8?B?NlU4d3N0U3Z0SFVNQVlueGRKalFHSHVwWkc3cEN0ajhrQlltQmlNcFdjZjk4?=
 =?utf-8?B?VWxXbW9WSGM0V3poUGU0VVJOT3ViN0E3T1JlV2tiL0lqQnUzM1VMdERpOVBr?=
 =?utf-8?B?SzRrVGNkbnMwbkVrblQ0UjgxZzdVc2w2VldOOWdEYkZyOFpqU2FOU29HQzJK?=
 =?utf-8?B?UEprTTNTeGVMWE5iMmxReEthOE9rbThBQWxZcldNZEMyb3dkY010Q0I1SFl2?=
 =?utf-8?B?T1BaRllNMUpWWkpwaFJacEh4NHFPT0VsN2E4N1VhR1dZUittYUFROHhGSGU1?=
 =?utf-8?B?ZUhESkVYSGpVY2NXTGMwaWE5MVZBNGcyU3lGRFhtRmNvd1FPbkZwTWxjQUpy?=
 =?utf-8?B?cnlTUE9NZnZUS2hDWnQ4bjFkR1ZQaFJuM0dJdVF1ZmlYTGhOSTJVd1JtM2c4?=
 =?utf-8?B?em1mY2NmOXdoM0UrU2gyd243WHR4eXI4SXNucEp2STdURW1nS21rUEI2OHli?=
 =?utf-8?B?cUcwNU1oN09YR3pkSGZRdlhvTmgzdVgzemxkNmFucFlEQXBUVEdtWGp2bkxh?=
 =?utf-8?B?T2ZNS0tuWlRIV2JybUk5VktzUzVEeWtmRzRCU0cwSEdwNTB4L1ZlS3VuOHgx?=
 =?utf-8?B?OFA0aWZobHQ5aFRUc1ZNMlpBTkw2RURmcnQxOVJqV1dTTEl5L3k0UG1QNFRo?=
 =?utf-8?B?dWp6dEx4TTA4akcvdmtoZGRvZVpzMFlOQkZLeTJQMXBwMlNNclZETENYVUNj?=
 =?utf-8?B?SDlaYmVWaENVVTRRY0kvcnNwN1B3ZEdGeWhHdHVQOWJRMXhRM0FUMWZrbFZ4?=
 =?utf-8?Q?pk+E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691974b0-79a8-4387-42c5-08dcefa50bae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 18:45:32.3991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZBSERccPjv4I5DWRnEhCmwG7WTrViCmsuytcrJBw/C0E3VhBQwAnIcNUQ+TDKb3JsCKlUjvPfBMfFOoGbS+nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGlu
ZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2Jl
ciAxOCwgMjAyNCAyOjQzIFBNDQo+IFRvOiBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBDb3Jud2FsbCwgSmF5
IDxKYXkuQ29ybndhbGxAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYW1kZ3B1OiBE
b24ndCBwcmludCBMMiBzdGF0dXMgaWYgdGhlcmUncyBub3RoaW5nIHRvIHByaW50DQo+DQo+DQo+
IE9uIDIwMjQtMTAtMTggMTE6MTIsIEtlbnQgUnVzc2VsbCB3cm90ZToNCj4gPiBJZiBhIDJuZCBm
YXVsdCBjb21lcyBpbiBiZWZvcmUgdGhlIDFzdCBpcyBoYW5kbGVkLCB0aGUgMXN0IGZhdWx0IHdp
bGwNCj4gPiBjbGVhciBvdXQgdGhlIEZBVUxUIFNUQVRVUyByZWdpc3RlcnMgYmVmb3JlIHRoZSAy
bmQgZmF1bHQgaXMgaGFuZGxlZC4NCj4gPiBUaHVzIHdlIGdldCBhIGxvdCBvZiB6ZXJvZXMuIElm
IHN0YXR1cz0wLCBqdXN0IHNraXAgdGhlIEwyIGZhdWx0IHN0YXR1cw0KPiA+IGluZm9ybWF0aW9u
LCB0byBhdm9pZCBjb25mdXNpb24gb2Ygd2h5IHNvbWUgVk0gZmF1bHQgc3RhdHVzIHByaW50cyBp
bg0KPiA+IGRtZXNnIGFyZSBhbGwgemVyb2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2Vu
dCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIHwgMTAgKysrKysrKysrKw0KPiA+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMV8wLmMgfCAxMCArKysrKysrKysrDQo+ID4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEyXzAuYyB8IDEwICsrKysrKysrKysN
Cj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgIHwgMTAgKysrKysr
KysrKw0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiA+IGluZGV4IDVjZjIwMDJm
Y2JhOC4uMTRhNTJjMzNiZmZhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192MTBfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z21jX3YxMF8wLmMNCj4gPiBAQCAtMTc1LDYgKzE3NSwxNiBAQCBzdGF0aWMgaW50IGdtY192MTBf
MF9wcm9jZXNzX2ludGVycnVwdChzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgIGFkZHIsIGVudHJ5LT5jbGllbnRfaWQsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICBzb2MxNV9paF9jbGllbnRpZF9uYW1lW2VudHJ5LT5jbGllbnRfaWRdKTsNCj4g
Pg0KPiA+ICsgICAvKiBJZiBzdGF0dXM9MCwgd2UgZG9uJ3QgaGF2ZSBhbnl0aGluZyB0byBwcm9j
ZXNzLiBNb3N0IG9mdGVuLCB0aGlzIGlzDQo+ID4gKyAgICAqIGNhdXNlZCBieSBhIDJuZCBmYXVs
dCBjb21pbmcgaW4gYmVmb3JlIHRoZSAxc3Qgb25lIGlzIGhhbmRsZWQuDQo+ID4gKyAgICAqIE9u
Y2UgdGhlIDFzdCBmYXVsdCBpcyBoYW5kbGVkLCB0aGUgZmF1bHQgcmVnaXN0ZXJzIGFyZSBjbGVh
cmVkLCBzbw0KPiA+ICsgICAgKiB3ZSBoYXZlIG5vdGhpbmcgdG8gcHJpbnQgZm9yIGZhdWx0ICMy
LiBJbiB0aGF0IGNhc2UsIGRvbid0IHRyeSB0bw0KPiA+ICsgICAgKiBwcmludCB0aGUgZmF1bHQg
c3RhdHVzIGluZm9ybWF0aW9uLiBUaGUgaW5mb3JtYXRpb24gYWJvdmUgaXMNCj4gPiArICAgICog
c3VmZmljaWVudCB0byBub3RlIHRoYXQgYW5vdGhlciBmYXVsdCBvY2N1cnJlZC4NCj4gPiArICAg
ICovDQo+ID4gKyAgIGlmICghc3RhdHVzKQ0KPiA+ICsgICAgICAgICAgIHJldHVybiAwOw0KPg0K
PiBJJ20gbm90IHN1cmUgaWYgdGhpcyBsZW5ndGh5IGNvbW1lbnQgbmVlZHMgdG8gYmUgZHVwbGlj
YXRlZCBpbiBzbyBtYW55DQo+IHBsYWNlcy4gSWYgeW91IGNoZWNrIGZvciBzdGF0dXMgPT0gMCwg
eW91IGFsc28gZG9uJ3QgbmVlZCB0aGUNCj4gYW1kZ3B1X3NyaW92X3ZmIGNvbmRpdGlvbiBiZWxv
dyBhbnkgbW9yZSwgYmVjYXVzZSBpdCBkb2Vzbid0IHJlYWQgdGhlDQo+IHN0YXR1cyByZWdpc3Rl
ciB1bmRlciBTUklPViBhbmQgc3RhdHVzIGlzIDAtaW5pdGlhbGl6ZWQuIFNvIHlvdSBjb3VsZA0K
PiBqdXN0IGRvIHRoaXM6DQo+DQo+ICAgICAgIC8qIE9ubHkgcHJpbnQgTDIgZmF1bHQgc3RhdHVz
IGlmIHRoZSBzdGF0dXMgcmVnaXN0ZXIgY291bGQgYmUgcmVhZCBhbmQNCj4gICAgICAgICogY29u
dGFpbnMgdXNlZnVsIGluZm9ybWF0aW9uDQo+ICAgICAgICAqLw0KPiAgICAgICBpZiAoc3RhdHVz
ICE9IDApDQo+ICAgICAgICAgICAgICAgaHViLT52bWh1Yl9mdW5jcy0+cHJpbnRfbDJfcHJvdGVj
dGlvbl9mYXVsdF9zdGF0dXMoYWRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMpOw0KU291bmRzIGdvb2Qu
IEkgY2FuIGxlYXZlIHRoZSB2ZXJib3NlIGRlc2NyaXB0aW9uIGluIHRoZSBjb21taXQgYW5kIGN1
dCBpdCBkb3duIGluIHRoZXNlIHNwb3RzLiBUaGFua3MhDQoNCiBLZW50DQo+DQo+IFJlZ2FyZHMs
DQo+ICAgIEZlbGl4DQo+DQo+DQo+ID4gKw0KPiA+ICAgICBpZiAoIWFtZGdwdV9zcmlvdl92Zihh
ZGV2KSkNCj4gPiAgICAgICAgICAgICBodWItPnZtaHViX2Z1bmNzLT5wcmludF9sMl9wcm90ZWN0
aW9uX2ZhdWx0X3N0YXR1cyhhZGV2LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyk7DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTFfMC5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMV8wLmMNCj4gPiBpbmRleCA0ZGY0ZDczMDM4ZjguLmM1
ZmUzMTA3MGNmMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjExXzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTFf
MC5jDQo+ID4gQEAgLTE0NCw2ICsxNDQsMTYgQEAgc3RhdGljIGludCBnbWNfdjExXzBfcHJvY2Vz
c19pbnRlcnJ1cHQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAgICAgICAg
ICAgZGV2X2VycihhZGV2LT5kZXYsICIgIGluIHBhZ2Ugc3RhcnRpbmcgYXQgYWRkcmVzcyAweCUw
MTZsbHggZnJvbQ0KPiBjbGllbnQgJWRcbiIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGFkZHIsIGVudHJ5LT5jbGllbnRfaWQpOw0KPiA+DQo+ID4gKyAgICAgICAgICAgLyogSWYg
c3RhdHVzPTAsIHdlIGRvbid0IGhhdmUgYW55dGhpbmcgdG8gcHJvY2Vzcy4gTW9zdCBvZnRlbiwg
dGhpcyBpcw0KPiA+ICsgICAgICAgICAgICAqIGNhdXNlZCBieSBhIDJuZCBmYXVsdCBjb21pbmcg
aW4gYmVmb3JlIHRoZSAxc3Qgb25lIGlzIGhhbmRsZWQuDQo+ID4gKyAgICAgICAgICAgICogT25j
ZSB0aGUgMXN0IGZhdWx0IGlzIGhhbmRsZWQsIHRoZSBmYXVsdCByZWdpc3RlcnMgYXJlIGNsZWFy
ZWQsIHNvDQo+ID4gKyAgICAgICAgICAgICogd2UgaGF2ZSBub3RoaW5nIHRvIHByaW50IGZvciBm
YXVsdCAjMi4gSW4gdGhhdCBjYXNlLCBkb24ndCB0cnkgdG8NCj4gPiArICAgICAgICAgICAgKiBw
cmludCB0aGUgZmF1bHQgc3RhdHVzIGluZm9ybWF0aW9uLiBUaGUgaW5mb3JtYXRpb24gYWJvdmUg
aXMNCj4gPiArICAgICAgICAgICAgKiBzdWZmaWNpZW50IHRvIG5vdGUgdGhhdCBhbm90aGVyIGZh
dWx0IG9jY3VycmVkLg0KPiA+ICsgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgIGlmICgh
c3RhdHVzKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICAg
ICAgICAgICAgIGlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgaHViLT52bWh1Yl9mdW5jcy0+cHJpbnRfbDJfcHJvdGVjdGlvbl9mYXVsdF9zdGF0dXMo
YWRldiwNCj4gc3RhdHVzKTsNCj4gPiAgICAgfQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEyXzAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dtY192MTJfMC5jDQo+ID4gaW5kZXggZTMzZjllOTA1OGNjLi5mY2ZlNTEyZjEyNzEgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMl8wLmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEyXzAuYw0KPiA+IEBAIC0x
MzcsNiArMTM3LDE2IEBAIHN0YXRpYyBpbnQgZ21jX3YxMl8wX3Byb2Nlc3NfaW50ZXJydXB0KHN0
cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ICAgICAgICAgICAgIGRldl9lcnIoYWRl
di0+ZGV2LCAiICBpbiBwYWdlIHN0YXJ0aW5nIGF0IGFkZHJlc3MgMHglMDE2bGx4IGZyb20NCj4g
Y2xpZW50ICVkXG4iLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRyLCBlbnRy
eS0+Y2xpZW50X2lkKTsNCj4gPg0KPiA+ICsgICAgICAgICAgIC8qIElmIHN0YXR1cz0wLCB3ZSBk
b24ndCBoYXZlIGFueXRoaW5nIHRvIHByb2Nlc3MuIE1vc3Qgb2Z0ZW4sIHRoaXMgaXMNCj4gPiAr
ICAgICAgICAgICAgKiBjYXVzZWQgYnkgYSAybmQgZmF1bHQgY29taW5nIGluIGJlZm9yZSB0aGUg
MXN0IG9uZSBpcyBoYW5kbGVkLg0KPiA+ICsgICAgICAgICAgICAqIE9uY2UgdGhlIDFzdCBmYXVs
dCBpcyBoYW5kbGVkLCB0aGUgZmF1bHQgcmVnaXN0ZXJzIGFyZSBjbGVhcmVkLCBzbw0KPiA+ICsg
ICAgICAgICAgICAqIHdlIGhhdmUgbm90aGluZyB0byBwcmludCBmb3IgZmF1bHQgIzIuIEluIHRo
YXQgY2FzZSwgZG9uJ3QgdHJ5IHRvDQo+ID4gKyAgICAgICAgICAgICogcHJpbnQgdGhlIGZhdWx0
IHN0YXR1cyBpbmZvcm1hdGlvbi4gVGhlIGluZm9ybWF0aW9uIGFib3ZlIGlzDQo+ID4gKyAgICAg
ICAgICAgICogc3VmZmljaWVudCB0byBub3RlIHRoYXQgYW5vdGhlciBmYXVsdCBvY2N1cnJlZC4N
Cj4gPiArICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICBpZiAoIXN0YXR1cykNCj4gPiAr
ICAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gPiAgICAgICAgICAgICBpZiAo
IWFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gPiAgICAgICAgICAgICAgICAgICAgIGh1Yi0+dm1o
dWJfZnVuY3MtPnByaW50X2wyX3Byb3RlY3Rpb25fZmF1bHRfc3RhdHVzKGFkZXYsDQo+IHN0YXR1
cyk7DQo+ID4gICAgIH0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3Y5XzAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMN
Cj4gPiBpbmRleCAwMTBkYjBlNTg2NTAuLjZkYTJjYTI4Mzc1ZSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiA+IEBAIC02NzUsNiArNjc1LDE2IEBAIHN0
YXRpYyBpbnQgZ21jX3Y5XzBfcHJvY2Vzc19pbnRlcnJ1cHQoc3RydWN0DQo+IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsDQo+ID4gICAgIGlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPiA+ICAgICAg
ICAgICAgIFdSRUczMl9QKGh1Yi0+dm1fbDJfcHJvX2ZhdWx0X2NudGwsIDEsIH4xKTsNCj4gPg0K
PiA+ICsgICAvKiBJZiBzdGF0dXM9MCwgd2UgZG9uJ3QgaGF2ZSBhbnl0aGluZyB0byBwcm9jZXNz
LiBNb3N0IG9mdGVuLCB0aGlzIGlzDQo+ID4gKyAgICAqIGNhdXNlZCBieSBhIDJuZCBmYXVsdCBj
b21pbmcgaW4gYmVmb3JlIHRoZSAxc3Qgb25lIGlzIGhhbmRsZWQuDQo+ID4gKyAgICAqIE9uY2Ug
dGhlIDFzdCBmYXVsdCBpcyBoYW5kbGVkLCB0aGUgZmF1bHQgcmVnaXN0ZXJzIGFyZSBjbGVhcmVk
LCBzbw0KPiA+ICsgICAgKiB3ZSBoYXZlIG5vdGhpbmcgdG8gcHJpbnQgZm9yIGZhdWx0ICMyLiBJ
biB0aGF0IGNhc2UsIGRvbid0IHRyeSB0bw0KPiA+ICsgICAgKiBwcmludCB0aGUgZmF1bHQgc3Rh
dHVzIGluZm9ybWF0aW9uLiBUaGUgaW5mb3JtYXRpb24gYWJvdmUgaXMNCj4gPiArICAgICogc3Vm
ZmljaWVudCB0byBub3RlIHRoYXQgYW5vdGhlciBmYXVsdCBvY2N1cnJlZC4NCj4gPiArICAgICov
DQo+ID4gKyAgIGlmICghc3RhdHVzKQ0KPiA+ICsgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsN
Cj4gPiAgICAgYW1kZ3B1X3ZtX3VwZGF0ZV9mYXVsdF9jYWNoZShhZGV2LCBlbnRyeS0+cGFzaWQs
IGFkZHIsIHN0YXR1cywgdm1odWIpOw0KPiA+DQo+ID4gICAgIGRldl9lcnIoYWRldi0+ZGV2LA0K
