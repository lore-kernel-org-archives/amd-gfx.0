Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A5FC282D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 18:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E5D10E2BB;
	Fri, 28 Feb 2025 18:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NuITLJ6t";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A25D810E2C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkKZO5G8GzzZ8ckXmFpVa1H/4ScA1SLur2e+4pFBz+vqWtTd1E33aawB9Wrp+fvZgw0Zld2nmDgSTSSYERppIVEzhL+nT+JB6vJP5WASlQ9ROURiB7pctDGISuE/YVLVy4Ry21NyYcM1Any0VSn7kZ1+g5Y+7Nlu15v5I8/2+HTvG/+Yth5E7a5T6RHxQgpXnfRaLjG5tigg6Ksznqbt9K/pTSR4EddsJAK5DcZsz1JRHnR0hnYFlxuw8y7aZ51crxXzb2QsZv89yYspLDqxfZ0edXEFc8EejvCd2qHGIWs7B/ArtMRnXdTAscglcLNTKq970I59fFg01vOPGlMbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VhaOr+mAl2UgLnTz0Rug4IxWCSAfEkymXu1OTFLrHE=;
 b=qXzv9ASgsM1d5xbvGexfeuA9I+UD8uNHNiU9EMNMMw32ZANhu70QMgIgG+Ma9SYbsdA0v2eL7E29T2PjfV8OwTy8Dc2oZ9vQmfIDLBeHNfSeGxaY5eqzvODwBf8wCuBKJE/C2lkjL0bs+OGRrOfHmvH+tu7fsUyeOtGzYYMhFDom1+EAgnucjvNyn1YpBtObx0oQ0gY+3v8Wgsy1FvD51Rb1vrUVrs56Gqy/8xcZnzwNkCa9ifA3InPARa3UmOENEXeMqV00nIHQ7nY0FjvZxwNmNIjah+dRSw8rZasPt/x18Am2OpNFHnyjmVjcwTjIer5lDcKALFSPPpQ5EU0gww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VhaOr+mAl2UgLnTz0Rug4IxWCSAfEkymXu1OTFLrHE=;
 b=NuITLJ6tBqGlwZvu4BGpVJW2SdoXppCQcyErEyS2tMLdCR+Oc38uswF7Hrr5k08oUVYI0ta+jccSdAuTJbKxLceSMmwHEIuGyhFmGEdKaNgEH5EEc3rOHlHo4ydZqg1wh2HD7dw8tz4AJPTeA//QCeYDEfDqn+IsjJURInTVwDM=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 18:22:27 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 18:22:26 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix NULL Pointer Dereference in KFD queue
Thread-Topic: [PATCH] drm/amdkfd: Fix NULL Pointer Dereference in KFD queue
Thread-Index: AQHbigzJbJ7uZ1ATOEit6Ir4QRGxArNdBtww
Date: Fri, 28 Feb 2025 18:22:26 +0000
Message-ID: <SJ0PR12MB813841E1F511752766059731F5CC2@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20250228163949.1079532-1-Andrew.Martin@amd.com>
 <ed3c4e3e-47c6-692d-0bc8-5fab42cbf85d@amd.com>
In-Reply-To: <ed3c4e3e-47c6-692d-0bc8-5fab42cbf85d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Philip.Yang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e0409e19-4c92-42b7-9d2c-cfe9c25cd195;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-28T18:20:43Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|MW4PR12MB7383:EE_
x-ms-office365-filtering-correlation-id: fe15a376-8e8b-4aba-23e4-08dd5824dab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cG5XNFJyY2JyZmNFc2UvRjdHbzhNWkNZbVp3akNoMFByNlhUVzdhK0RPVEtC?=
 =?utf-8?B?Rnp0Zks3RHJBVWVrbEo1WHdxKy9YclRrZ3RwR1ZHU1hlR2Fkd09yVXMvbGlR?=
 =?utf-8?B?RXBlRGVsem9wMzd0QzJHY3lVck9CaExRbUZUOHcxZi80RzI1WklEeGlCdC94?=
 =?utf-8?B?bUhwcDB1SWNDaDB1TXNUV28yNmJvNStXNjZFc0g1MXB5VzZ1bzVpSGxyZ3pw?=
 =?utf-8?B?RzBPZCs4MDF6V29nY3pIZEhRQTBhV3FIc0JhN3d3WVFNa2hQamdJNUhuVXgx?=
 =?utf-8?B?cGFZTTBKeXYzcGxkUmcxTzhGTHNLNmZhSzBTa0NTU0ZTQ3MxTmpEYnBYblFa?=
 =?utf-8?B?VE5PY1UwVWdqL3NGZ1ppbmE0NFJ6WTBQUGJRTFVDdktjQ2p6SnJKSjNXZ09k?=
 =?utf-8?B?OU1BRGQ3c3B6SWFvZUdLTE5UaUFhVERPaCtJYlBzNDdqRjZObGR1N1puMFB6?=
 =?utf-8?B?WkhXOWI5OVc5ditaUFZDUC90ZFBTTUFEUlRYTis5REltVGEzOGxyTWxCemg4?=
 =?utf-8?B?WnRCT3l0Z09WdWxtVjZKTWtnd20ybWd2ak1UR2I5dmU3TkpvNWtsaUphUmZH?=
 =?utf-8?B?V0EwaHYxd0lodTgvR0U4dlZVOW8rbUtVMjkzek5zcC9YSWVvUG8yN0VjRlYw?=
 =?utf-8?B?QVpTMTRiaUxBZlptazdFYXdxMmQwZld4NFRMb0ZvN3FGTjFSTjA1OFZkZDBP?=
 =?utf-8?B?VU1CTFp0bkZySjc0UmVIOVphMW5NdWFiSCs1Z1pGTkR3bTAwMU0yRWpOcXEz?=
 =?utf-8?B?UjdkZVNNZ3gvVjhxemhXT01mQ212VTF5d0Rsd3lSR0VZL2l5YnVWMFBia0NI?=
 =?utf-8?B?TkRVTjZQL0VLVXNGenZUNzVuN0N2SXNhNWVVeTIra0IrZlpMVU8waFJCV05o?=
 =?utf-8?B?N0NyWEw1bHlnSFVhbnpEa1lCZzkyUGZnRmFYWm5CT1VESWk0SmRzVU0yMXM2?=
 =?utf-8?B?U3lNV2E5QXVoR2s3U0dhQzc5YVRaSDdNMElVVnJMYlRJTVI1VHA1bTBpNEwz?=
 =?utf-8?B?TEVwMlJIcldWYnBYR2NFNTdlSWk0R1ZwUVVYaXcrbmhhb21HUGVISXpFTGM1?=
 =?utf-8?B?WW9md1E0V095UWFpT0xaZHJGZXFvYytOTFBLaXBJcFZVdmcvdmlVQmdOSGZC?=
 =?utf-8?B?UVB6L0JybkhWajl1aTJJaE91aUFuWjlGZlprUzBUeWJ3NmErZU1FVVo4aWF1?=
 =?utf-8?B?MlE5bXp3akd1anN4UDQzTFJBZXB3WitTTHlHUWVHK3JJSkNVMS9peHoxbGwy?=
 =?utf-8?B?RG5UQjYxbDE0YzdsRGlpZGJvRkhKQ21maW8xVUxHWVhJc29JRDhOVnRyYWNQ?=
 =?utf-8?B?MzhBMWt3WXAzUlBVVWJoYkZsVkVDMEo4WEo5UStyL2ZGaTMyclBpdTZXekdF?=
 =?utf-8?B?QVhEQmdEeWdhTTEwbDh4WVNoanRQMjBNMFh2R3BZcHM5MDczTXMvTW1EUnB4?=
 =?utf-8?B?L3lWZzlwbGVKYUNZQXVXTkZETC90bElsa1N2MFVlMHFBNlFUbk01NVBIUEFG?=
 =?utf-8?B?LzZ1cXFoRERTSkVxTnMzRktCdnRZLzRLM1NuQUMwSU5nNXBtM3g2OGVEMG00?=
 =?utf-8?B?Uzh4LzVEaEgvMXQ0bE83a3VrTWQ0cllVZFB0aFhON3BqOWp4VFJNWndpdHdK?=
 =?utf-8?B?NFlOb2pjMUdBSjZ6MnVrYmV5bHRucVNIZXNJaEgrYlprd25OV0s4QnNXMy9l?=
 =?utf-8?B?eEdoZExhLzFpa1FqZlhzUlNtVERhTm11SFZMdmFqYyt3aGFlVFVwZzF4cHhl?=
 =?utf-8?B?T1EvQzdUN3NvalVlZ0xFN241U2kyQTlqMi9UdEtBdkdYK3JoaWRRVUQ5NnI4?=
 =?utf-8?B?bC9uZ1J6Y3cxdndCWkFGcURPNDBJdVAvRzAxNWFiaEFLcHRpbnBmNVBwK1NG?=
 =?utf-8?B?c0FIeTZ5ZXNnRHNDVXpmSVpQaHN3d09nWXVibnBVQmNqNWNBMDVjZ1hZVi9I?=
 =?utf-8?Q?a9j7LOckED/94L01MIudaLRTPJ7/mZbx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFdMWWlRaitGdWtWRHdrMmUzWmMxRWxPdHlwdjFSWVVTTGVQWVVCQi9OWWdU?=
 =?utf-8?B?d1dScjNVQmVucm9iUS90SUdneXhnNEd2bnFORkV2Vm1BM2Z0MGZLaSs5MTNi?=
 =?utf-8?B?eCtpd2lGQkQxZUhGQldhOFlwZmhqRUtrQVd2amZBM0tMOVlwMks1VGxIZFdM?=
 =?utf-8?B?UkpZZitsOGNMMUdGbDFiQ1NSalkwWXc3YUdJaDRLS25qbExBVEVyMFJiNHhJ?=
 =?utf-8?B?WldsN2ZBMlVJNnZvSjVWNk45Qmk0encyZUtJNWhHYUhDRWROaWFaV0IzdnE4?=
 =?utf-8?B?MjllSjc5UXQwRGV6NVhnaXBwcHBzOENUT3dQa2ZqRjQyQmVqUGJib0Fobkhq?=
 =?utf-8?B?WkdXL3NjaDFuV2lOdks5TVQveGNYYkxjY0ovbmpPM0hXbVVmUElJazR5R2J4?=
 =?utf-8?B?RkVFZjRZUVFMSysxemdBclhOdGtxa2w3a2tvTnEwWERpcUVCZjNEd3R5MytJ?=
 =?utf-8?B?TnFZaXJhQTNFRTZrVnV0K2dXK1ZDRisyNkhlZzFHRCtGOC9zWDZJTWJ6MVhQ?=
 =?utf-8?B?U3FQbDBFWVBkUG5qaXBCYUVNZ1paSGVKNmxGd3FUc2xyQTFiRGkxQm12VmIz?=
 =?utf-8?B?dy9RZGV6QUVaSzhwSU9DNThuQVcyRTRXSTZzSDhNcGN5QUhsaGVEeWd0eWNX?=
 =?utf-8?B?UWZRaFQxSUFBZUE4OG9ZRXVzTUgrdG5lNExZYmdNMWxHakJKbk03b2FYcjlQ?=
 =?utf-8?B?MCtVZ0VWZENlZWsrWk93aFVDZTdqS0RzMHc5QjBUc3hPb3B3UGNVUVRoZWtV?=
 =?utf-8?B?cVFKR2V1L2hTejVJZlYwQlB3N3I1aHdWaGkyWWxaZ3hpSFdkZm9aOHd3SURE?=
 =?utf-8?B?YzdUZDhYOC9UWDhSRll3eDBXZ3BjU21ra0piZll4OVlvN01KSnhXK3BaTG0r?=
 =?utf-8?B?ZjhMTyt4RFFybEoraFQrTTRMQ2RFcElJRUNZWmdsUG01c29iZlc3Vktjb0ZB?=
 =?utf-8?B?Ti9Ib1BHWjN4M1FFWFFxeThzWEhoSml0SFlCejZOdnlSeDlIeVovQXBTTjRH?=
 =?utf-8?B?YUFadjdabnpvakhhckZnblJpOGxEQ015OGhncmUxdFd1a2NaRkIzNkFRTkl0?=
 =?utf-8?B?bDdPWk5TTXpDdm9ZR3JPUVBDSDdnTjEycWxJejdTWXV3V1AvY2xQRHVKSEV1?=
 =?utf-8?B?VlRGN0VSdVZlSm5ZWThBSzkyZUJCSzEySmhaaXNPNzREWUNUKzd2UDZLZ3Fo?=
 =?utf-8?B?NG0yN3A4Qk1FQnZkM0NsUXRlM0xOMGRDOE1DNDdsYUp5MnkrenpORjdSQkY3?=
 =?utf-8?B?d242cjNwUG5PS0o3SWxDaUlWbEU2T3JzRjhsdHMzRUVVOU1ybngwUHhnTW51?=
 =?utf-8?B?Z1lvL3I4cHF2eDNsSEtXTkRaM0NSM3lXVUNOYWR0THlJV2NsOW9qQ09wemk0?=
 =?utf-8?B?SUFKNzkwOTFPZHRGRktFOTBYcXpqUmQ1U2t4Z09lbzVaWlQ0OVo4dld3UTdJ?=
 =?utf-8?B?cHRJemxpSW10MXh5YUJlOGozMjcxTXl5OEpIL1g4SDFRd1lsQ1d4WmdkRCtD?=
 =?utf-8?B?Yk5LbmpFSzdHMU0xUHE3Zm5Nc0UzQWNqWUNITzk0NkN1N3p4dHQ0Vng0RjFq?=
 =?utf-8?B?T0tnOEdQNlhJTDRQMVdTRzU1Nlcrd3Y1TEw2ZzRZRnpQdGliLzdJN0pJdXZw?=
 =?utf-8?B?KzNRQmZQSkZuZHFlQ1dxbEI0T1lQTVduM0V4ajJnQWpHWlNqdDVvMm03dUI1?=
 =?utf-8?B?TXhleFZGMXVWOUIwdGY4M3ovWDRCWUxpT21OUm1wRlBmNmR2NitoK2dtM0Nr?=
 =?utf-8?B?WU5UaVk3dEVUOVNpQk9PaDBESmJUcSt6b2hIVFhTYXNNdEVZcS9rcUFuVkM5?=
 =?utf-8?B?ZkxYbm5IZUNNYlROU2F4d1FyL0JOWHYrMFovZmRmS29TbHFXYlpkcGRRM3Fu?=
 =?utf-8?B?S05nQk9qNkVlV0wreTJiS2twcGRieit4cUcyRVFxWWlYc0NBNzBzMnowakdG?=
 =?utf-8?B?VUk5cG9NSk1aOEFDN0xUWHRqMjRvckw3NE12UXVqc0JRV2pielZBSm1hRXJ5?=
 =?utf-8?B?SnZSSEUvb3YxSDFzZVlwbTRiUGdCUkxzWStxVFpQdFVKcThGa2hnam9RalJm?=
 =?utf-8?B?S1cyZUxNU004bzVYV2N1U1lkbWk5amg5dzR3YkxGaGNqVzFWcEdKekpRK2o0?=
 =?utf-8?Q?bIzE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe15a376-8e8b-4aba-23e4-08dd5824dab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 18:22:26.7542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAtEn/heR96kwABfuQLtkleHVlAzlNLAuXd9UBmyyAeMQNGbU/t3CHl/9KO+HpDgA2IbSSpYN4MkQDsIryS37Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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
Cg0KQFlhbmcsIFBoaWxpcA0KDQpUaGFua3MhDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFuZ0BhbWQuY29tPg0KPiBTZW50OiBG
cmlkYXksIEZlYnJ1YXJ5IDI4LCAyMDI1IDE6MTYgUE0NCj4gVG86IE1hcnRpbiwgQW5kcmV3IDxB
bmRyZXcuTWFydGluQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gZHJtL2FtZGtmZDogRml4IE5VTEwgUG9pbnRlciBEZXJlZmVyZW5jZSBpbiBLRkQg
cXVldWUNCj4NCj4NCj4gT24gMjAyNS0wMi0yOCAxMTozOSwgQW5kcmV3IE1hcnRpbiB3cm90ZToN
Cj4gPiAgICAgIFRocm91Z2ggS0ZEIElPQ1RMIEZ1enppbmcgd2UgZW5jb3VudGVyZWQgYSBOVUxM
IHBvaW50ZXIgZGVyZWZyZW5jZQ0KPiA+ICAgICAgd2hlbiBjYWxsaW5nIGtmZF9xdWV1ZV9hY3F1
aXJlX2J1ZmZlcnMuDQo+DQo+IFBsZWFzZSByZW1vdmUgdGhlIGV4dHJhIGxlYWRpbmcgc3BhY2Ug
Y2hhcmFjdGVyIGluIHN1YmplY3QgYW5kIGNvbW1lbnQsIGFuZA0KPiBhZGQgdGFnDQo+DQo+IEZp
eGVzOiA2Mjk1NjhkMjVmZWEgKCJkcm0vYW1ka2ZkOiBWYWxpZGF0ZSBxdWV1ZSBjd3NyIGFyZWEg
YW5kIGVvcCBidWZmZXINCj4gc2l6ZSIpDQoNCldpbGwgZG8hDQo+DQo+IFRoaXMgcGF0Y2ggaXMN
Cj4NCj4gUmV2aWV3ZWQtYnk6IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29tPg0KPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBNYXJ0aW4gPEFuZHJldy5NYXJ0aW5AYW1kLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9xdWV1ZS5jIHwg
MiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3F1
ZXVlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9xdWV1ZS5jDQo+ID4g
aW5kZXggNjJjNjM1ZTlkMWFhLi5kYzJjZGM0OGUyOGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3F1ZXVlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfcXVldWUuYw0KPiA+IEBAIC0yNzcsNyArMjc3LDcgQEAgaW50IGtm
ZF9xdWV1ZV9hY3F1aXJlX2J1ZmZlcnMoc3RydWN0DQo+IGtmZF9wcm9jZXNzX2RldmljZSAqcGRk
LCBzdHJ1Y3QgcXVldWVfcHJvcGUNCj4gPiAgICAgaWYgKHByb3BlcnRpZXMtPmVvcF9yaW5nX2J1
ZmZlcl9hZGRyZXNzKSB7DQo+ID4gICAgICAgICAgICAgaWYgKHByb3BlcnRpZXMtPmVvcF9yaW5n
X2J1ZmZlcl9zaXplICE9IHRvcG9fZGV2LQ0KPiA+bm9kZV9wcm9wcy5lb3BfYnVmZmVyX3NpemUp
IHsNCj4gPiAgICAgICAgICAgICAgICAgICAgIHByX2RlYnVnKCJxdWV1ZSBlb3AgYm8gc2l6ZSAw
eCVseCBub3QgZXF1YWwgdG8NCj4gbm9kZSBlb3AgYnVmIHNpemUgMHgleFxuIiwNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcHJvcGVydGllcy0+ZW9wX2J1Zl9iby0+dGJvLmJhc2Uu
c2l6ZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJvcGVydGllcy0+ZW9wX3Jp
bmdfYnVmZmVyX3NpemUsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRvcG9fZGV2
LT5ub2RlX3Byb3BzLmVvcF9idWZmZXJfc2l6ZSk7DQo+ID4gICAgICAgICAgICAgICAgICAgICBl
cnIgPSAtRUlOVkFMOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgZ290byBvdXRfZXJyX3VucmVz
ZXJ2ZTsNCg==
