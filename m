Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96DCCCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 16:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F39B10E43A;
	Mon,  3 Nov 2025 16:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="btVSLHfR";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95C310E43A
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 16:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2JdZo9ihZxj9s7n9BjVo+ehtykxRsZXPevcKU6IxAMJZUvil+awX6ES9lU4/WZ7INWlFOc/SvTHHDq+R34hRjEz7K9EOHODLq7UoKbeKaJLanfULS8gMM/2gV9WR59QeZjxvW1KK3GO6HS53KD9Wt4xltlKagphPL4ggOTbEr/d5yi2tVwnaIRu5Ls9oW1SunMUUgerijmlVtHyG0vpBXC5ptdwh5X2tWa7YPJCoXd3HBXQTRha0wSOzeXz3QRgN3cjS6gC/uzDSXRt4A4k7NbBWS6KUNFYghK+6JNIWlkfKEBA5XUEsuEDvdw05mhhLfutiMPjRXBbi0qP+DO98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq/3iGPzjyTJXrvzrUDmeHgdLgQwuLOeXvMp6KVIaxs=;
 b=vU8LTtO+s+d5MgPkCSHW6RASVs/Hqfxe8Xt3gjKabQaIX4/lRQs2R3AAMvOXXrlrozsDqnJ4CkctALUkwAWdbyTNpHRNPw5qY6qo04B9QTOuNkQnZ5dqHifBOL+TKPAiEzBvBrx3uPtlk67zKkrJVkCUe79LkVjhTg+OOqvbMlGRLM8yT8KUXFjJiG1PaWuIksAmzWOOsoMtFeZkNIQfQv036nGU0vKw1y/CtJLT6sP4fHeQIsdhptpsaT2Q0ay4MgqYhdKiVJpB2m3DukYJ+AFz80yPoZVbkj2OoPNF5Wcf+BbP7N+39NugMOGtfAzRfRz4VlH/rsrUiXTvdzO2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq/3iGPzjyTJXrvzrUDmeHgdLgQwuLOeXvMp6KVIaxs=;
 b=btVSLHfRzPwdkUSG3/GIxJGA3BtukWcasjAygQEobpeWAI1nfMJsyI6P5WcJrDExtdm5306Ci7GwWkZVBylTBBoLXwoatJDUgxsqxbUOIPbMCbA13gLx/fh2PBgRZo75Ksdyt64rylhVZJIG6ROVmyOmiruCr1Tt4h3IapF3OP0=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 16:28:18 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 16:28:18 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/jpeg: Add parse_cs for JPEG5_0_1
Thread-Topic: [PATCH] drm/amdgpu/jpeg: Add parse_cs for JPEG5_0_1
Thread-Index: AQHcN5JCYP4/Z6j9h066Yzzu8uBs5LThTnQA
Date: Mon, 3 Nov 2025 16:28:18 +0000
Message-ID: <DM8PR12MB539911A2A9DE316A62B2D54EE5C7A@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20251007135623.622247-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20251007135623.622247-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-03T16:27:50.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|DS0PR12MB7778:EE_
x-ms-office365-filtering-correlation-id: 8f9443f7-cbca-4051-e2df-08de1af5ff47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|42112799006|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?d3BoV20wbkRzZnR0K3p5M0pkU0FyVEpObFZJc2F4LzlOUXpCUnEyU3djT016?=
 =?utf-8?B?amNFSHVTVFAweHpCZkIvMmhLaHhDbXZ1SEhsRzZBemdia1BIR1BKNUs1d2Vz?=
 =?utf-8?B?SWNhNXVxSTdZM3gxTHJlSTAxd09hOEM0ZjJtK2ZZYlNpVW9yOUpMZGphMVM0?=
 =?utf-8?B?MEZpNm5mYzlUZDZ0aDdGV3dpd25pRGxieUFOSWRkeXpuUnZZMWpIcG1ibzN1?=
 =?utf-8?B?cXA2Y3hmc0lMcDYreWFISmFlY0tJS1RUdzgvWmlRWHR1UzhoLzhLTFcwUVEw?=
 =?utf-8?B?TVF4UUtVekNuWEFzY0IxMWRndUU4ZFcyWTRZMUFYZk1xNFNUbHpDV005UnVk?=
 =?utf-8?B?YXlINC9zS3dlZkYrOVV5VWZRQU1YTGtlbFgvWHRSWTN1VStqbDhhaUR4SFpS?=
 =?utf-8?B?MWtXeHFtMG1GY1RyRURpaFNoRHZ1LzYxZm01UWg4a1oySnFRWUJnMEIxRUhF?=
 =?utf-8?B?aUtDWXpvSWh5c2tjcDhidTVjeXRuODlmOHpqbzM4Z0UzL2drS2dzSEo1MmRm?=
 =?utf-8?B?SlpmdEM5b3Q1LzRSQWpQT1ZXVDlvRkNqeDFodEpHWGJzb1FkdTBvYmR1QVZh?=
 =?utf-8?B?ckJSbnRBUi9BL2pZWDF0SWFVNFlOQkVCVE55RVhnRFRycUVvUE8vYU85eHBF?=
 =?utf-8?B?cG4rVGtaMitjS3dpcWpVQ1Y5RGZYTUJDVU0xNlE3aE1WUmlWK1RBaUthdm9r?=
 =?utf-8?B?clBZeWJITjJaOFJOWlZQbTFaM3R1SXV5VXZ3WEZLcnV0NmRsSTROakJ3RGM4?=
 =?utf-8?B?ZzVUZ0lRSWxadkk4UXNTcjRESU9GS25IcEt6YnFqZ3p1eXRFTUwyNGE3Z3pY?=
 =?utf-8?B?amMra2oxVlhaZHJqRXBHU2ovZzhUdWtRNWZxamoyZ2N5N2F1L2l2VkVGVkVJ?=
 =?utf-8?B?cGRYSyt2TVBUNWZVWHc0cWdlUmpOT2tweVdkb0JMaUZlUFpiTTJ5eHk4bWdD?=
 =?utf-8?B?dlRJOFdoNWxMOVVFcVVHWExhNkxOcTR1cGtNbkVCNmE1S3ZGclZVWlpudEFC?=
 =?utf-8?B?ZTF2R2NPYis1OGEwdWN1aDZQSXFuNWtLbHVxeXFDZ01yaGM0VXJwK3RHbldj?=
 =?utf-8?B?UFI1TUZUQkxPd05kQkVLQ1BNZElzc0NQankvU2F0WnNMaW92YnJLUHBFVnhk?=
 =?utf-8?B?RmNQSzlLdmFLWHZpRFRuUjc4bXRzOHo5cS9rYlJJNWVPK1ZPRGFtaWRLWWpj?=
 =?utf-8?B?VUxTWWI3dTN3dzVOY2pabENmb0VBU0VBMnY3dFpqU01tRVBkOHZOblAyTnV2?=
 =?utf-8?B?TmtZN3Jad0dyRVpJVDhjUnl6aWZFalYzMU1yUFY1d3JnSjJnd0VqakhQbGh1?=
 =?utf-8?B?emtNR1A4Q3c3S1h4VldtbjNJeEVkbmVETk0xTHpsc01Bbjh6VjVCdUo5S0ZG?=
 =?utf-8?B?bVJVQjlnbWlFdkFQTVlyY0R4ZERQNFFiNXJ3aUNwUTl6aXlhU3BjazhTaXZD?=
 =?utf-8?B?ejZPdmV5Zzg1RS8vUHdRNXBSVUpKNXB4YjFaUmlCcmtwQWtOMHZqOWdvalNa?=
 =?utf-8?B?ZXZnTkVXM1dId2JoQ2pDM1VUNWZFQ2l4NWZBZklCM2RxYjJzWW96YmdvQUFj?=
 =?utf-8?B?c1A0Y1lpWENMSlNBejZ2L05PWGE5dmdjU3hxbUhwZm5zSkJsRDhJend5U2tn?=
 =?utf-8?B?TVRtMGh0Ni9lOVFCT2x3S3NJTUNEWjdmU0srTFZNWDB5LzhlMUhDbnR5WVpz?=
 =?utf-8?B?QUxoWVVKUlJiVGFsTGxTcDBRbkIzaTVJMG43M1psSWdreG5TMzRZZnVOc0pp?=
 =?utf-8?B?ZDJudXl0cE52NEc5RXN3dGxIeFY4eHZuM3BjczBhSldBMTdpS2IyeWpONXBG?=
 =?utf-8?B?VmI5bmY1UzJtT1JkbW80VUN4dXM4Y09EZlJqY1VpaGRrSkpkM0pRaktaelg1?=
 =?utf-8?B?NkZpZEtKUzlKZG9aeVhaN2tISGpIMTJnMlhaaGExbStoN2RvdXRacjJlV01N?=
 =?utf-8?B?N21TVWVYZWcyMlJoMXlZVTJ3NkZab0tNMWdNelRIOGNmSHA5ZDNKbkZFdzVp?=
 =?utf-8?B?Y0hxUlNjZitXWnRkSVFpVlJHM1BNNEJRYS8wWUR6eHVZRElqV0Ird3BRcjV6?=
 =?utf-8?Q?oDOGNf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(42112799006)(1800799024)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXlyMW1nL0ZpbmR2d0dRZXFwK1J2NXFnVGZMRnZKeURCZUIrOFBIcW5BZGdj?=
 =?utf-8?B?M2F3VE1zeHdXOFkxaWY3WGlkZWY2bnNQalJpUERyaHZWeDI2N01MRVhGNFUz?=
 =?utf-8?B?Z1hIOCtUUjZ2bmd2Yzc2WTNrUmxOQ29XUTBHMVBDblVVbFVqMXlWS2NBek5m?=
 =?utf-8?B?bkNZaHEwM2cvcWRGV3lwSWRtQm5qa0d6MHhaQjZYcXJ5TTZMNUFwMHFmTDhs?=
 =?utf-8?B?SGg1N1hXOC9IQnc1eC9VQXJIU3pZZytxY3lSNlpyM1cxRU11UzcrM1hoN1lC?=
 =?utf-8?B?RHBTb3J5UHpteGFXVWJkTGFuY3F0dkNHMFFqNENpazNWaWtZcmVYOE5Vdm1T?=
 =?utf-8?B?R25wd2wzODd5MGhNZHU3TVZaRkgzaFFUU3l2cHU5SFFzcFkzajE2dzRJSURo?=
 =?utf-8?B?UW5iRTZlOXYweUVicFc4VXFnc3FjbCtZTTZzdzJFNE5GWm9OaTNJRUsxUE9R?=
 =?utf-8?B?OXgyaXpiSTMwbE5KVmU1NlVJSmpCL29iMVIydlI0a2UwNkowdXNRdzY2TnFE?=
 =?utf-8?B?eWVTUlg3NmxqNGl3UWhNaXRCTU8yckxXR1llNEhNZFhkbmRzck13VzV6UEY1?=
 =?utf-8?B?aHp5c0p0cXNNb2ptN0dHMDFWR3MvVkVEeWREVW53dkpEY0hYbExHOUNiUTJa?=
 =?utf-8?B?c1VFRER1T015K2hjUVJxRzdLZGlmZFViWThkZ3poTGFjTVdIc2g3OFQ5djMy?=
 =?utf-8?B?WGZQTVhzSjJBdFBPMTFOMFNOb0I0WVJ3SHF6aytwNE5BK21INmdPRG84bWZM?=
 =?utf-8?B?UW1TMFBWTlRyMHQ2SWJjSGI5SFFrSnVOWUhSaFN3dktlWkxNRGRzVjZMY1E0?=
 =?utf-8?B?TWZFS0x0VTNhRzZMak9abS8rcGdqVG01N3VwSC9mdEd1WVpTZXNLZTJlL0lt?=
 =?utf-8?B?TXhuM1pIQ082Z0Q4WUVrZjNCTkl5Q0svYUc4ejBXTXY1Zlp6b2FKcy9LcUFv?=
 =?utf-8?B?Ti85NlRHcjZvMTZ2WGl6U0RYMlVGcUZDaDRoYzM2Um9QaDE1L1lPLzFiaW1Q?=
 =?utf-8?B?VWxleU5ONDVEaVJ0emMvSXMxR252Z0dWait2cHdvRkxpZDNsSzJzcnVaSGEw?=
 =?utf-8?B?dnMwWXRKUDJmSTJZVkxYNkVLbUwwMWVhODZKcGs3MDhld2JzVGU2Ymo1SjA0?=
 =?utf-8?B?Q3FWVTcyNFpDT2JOb0EzOU5GMzR3NytGNUs1ZjlIVXRGZ1BZck5VRU1JMkVq?=
 =?utf-8?B?ZGZqcy8zM3A4ZWdvV1hzekVGTVlMbUs1MjEvZUlmVGFmWnFENTRWNXNxOVN5?=
 =?utf-8?B?MlpyYU5GY1ZOTnBJNmlrUWJZUDVVVW5hbGJZbEFqUjBPRk4rVENmUWhRRm5V?=
 =?utf-8?B?dXBHdDBsS2svWDcrcFNlT1FqVnBwWk1jSUxxWjQ4RTlFL2pQMUdvQ2Vhb29L?=
 =?utf-8?B?ZjVMOXZhanQ3QkpnRzJCRy9HNFJqS3pZNWZSTnFLNDNLcjlrdFBoL1B5Z1Bt?=
 =?utf-8?B?cjB2eG1FZlMrRTdVaGZYNmZEbkxQQnlYNFphdFIwQm9KZVA5N2xlQmtvaDlt?=
 =?utf-8?B?ZkFXL1cwUlJNSUdNN2EydlVDdjNkMkN4blV4U0xNYXpXTHF1UUM3VGp5S0pT?=
 =?utf-8?B?UFkvbGphNXhlQ1pXZ1pqVmdPR09Vb1d5UlFrTm84dU1FSnJIbEkrRTk5OW1t?=
 =?utf-8?B?dU0wSXFwMU9HZS9VbWtCcExvdURzMWdwWm5RWFM0eWVOZDUyV1RwUXV4b1Iv?=
 =?utf-8?B?QkcrRmF1WnRzMmJvNExLVk0zTDJWMDZJMWk3TTh0ZWlIYi9vbmVUMlpLWlUw?=
 =?utf-8?B?eGx3ZmVNWFlhZHZVRzdaY05sY29vUmIydlk4MitoTjBZTEhiMXF2eXh1V2NS?=
 =?utf-8?B?dUdhU01WRnR1MHJMajNsQ2xOTXVmbnV2QitlcEZGbXhpeFdSVkJYWi8vVmVG?=
 =?utf-8?B?YTlYMHNUSFEwbURuTHNLdjVqTDEvMHlSdFM2T29aNHRFa2w3R0xEbUxzV21R?=
 =?utf-8?B?R0ErUVlxUXRaTnR6OW5pOGVPbE5VSE1RdTU0UWQrQ1J1NkRLQzVvdTJtTitS?=
 =?utf-8?B?R0ZaektNd0poOG1HdTdHK2VKb3ZZN1lDUHVTK2hObFRVVzBrWUFLMWlJODZw?=
 =?utf-8?B?NDkzMHpIc0NCOFZQSWhWdDVSa0pTM0ZyNGVWSFl0SnUrWFdQUmtMS2lKWUI3?=
 =?utf-8?Q?t/Sw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9443f7-cbca-4051-e2df-08de1af5ff47
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 16:28:18.5020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpkfOUXRqR03t6J3VeH+GP+W64ovuhoZPI0WpTDTZoTREbqN37PNKBLwSePhmZRK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
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
Cg0KUmV2aWV3ZWQtYnk6IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1bWFyIDxTYXRo
aXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT4NCj4gU2VudDogT2N0b2JlciA3LCAyMDI1IDk6
NTYgQU0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBMaXUsIExl
byA8TGVvLkxpdUBhbWQuY29tPjsgU3VuZGFyYXJhanUsIFNhdGhpc2hrdW1hcg0KPiA8U2F0aGlz
aGt1bWFyLlN1bmRhcmFyYWp1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdw
dS9qcGVnOiBBZGQgcGFyc2VfY3MgZm9yIEpQRUc1XzBfMQ0KPg0KPiBlbmFibGUgcGFyc2VfY3Mg
Y2FsbGJhY2sgZm9yIEpQRUc1XzBfMS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogU2F0aGlzaGt1bWFy
IFMgPHNhdGhpc2hrdW1hci5zdW5kYXJhcmFqdUBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjVfMF8xLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvanBlZ192NV8wXzEuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdf
djVfMF8xLmMNCj4gaW5kZXggYmFmMDk3ZDJlMWFjLi5hYjBiZjg4MGQzZDggMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjVfMF8xLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192NV8wXzEuYw0KPiBAQCAtODc4LDYgKzg3OCw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MNCj4ganBlZ192NV8wXzFf
ZGVjX3Jpbmdfdm1fZnVuY3MgPSB7DQo+ICAgICAgIC5nZXRfcnB0ciA9IGpwZWdfdjVfMF8xX2Rl
Y19yaW5nX2dldF9ycHRyLA0KPiAgICAgICAuZ2V0X3dwdHIgPSBqcGVnX3Y1XzBfMV9kZWNfcmlu
Z19nZXRfd3B0ciwNCj4gICAgICAgLnNldF93cHRyID0ganBlZ192NV8wXzFfZGVjX3Jpbmdfc2V0
X3dwdHIsDQo+ICsgICAgIC5wYXJzZV9jcyA9IGFtZGdwdV9qcGVnX2RlY19wYXJzZV9jcywNCj4g
ICAgICAgLmVtaXRfZnJhbWVfc2l6ZSA9DQo+ICAgICAgICAgICAgICAgU09DMTVfRkxVU0hfR1BV
X1RMQl9OVU1fV1JFRyAqIDYgKw0KPiAgICAgICAgICAgICAgIFNPQzE1X0ZMVVNIX0dQVV9UTEJf
TlVNX1JFR19XQUlUICogOCArDQo+IC0tDQo+IDIuNDguMQ0KDQo=
