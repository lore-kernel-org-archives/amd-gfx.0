Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D480CCA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 19:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE0C10E231;
	Wed, 20 Aug 2025 19:29:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yQ4p5S4Q";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF38710E231
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 19:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pw2/J35NavkRbNM6dp1Gwxb4V6Ky9Mo9W6rWeWeHkANjwcTIdg22rAJOtP1dTk/TV47ZXdhF21OqZXeRajRN4IYQNHfQwViCgFtudD6+SNwBBiMI3/eubGN++BFA+bSdVosWuspKGLsxmc34se5xC4EtMyKvHIAh4eKnJgiKyFtL3dZqz1rHB6R+vrrMAN1z2Xb7rJGnCEaHFzwtEvvZgNtWV+8oyRwqSTfYb0FYFl/UEw8XwpijIEK39EzoiXNKQNpuLlWht1YroWpWhGOHRC/3MQ7ZjUqpws0dQiz9G8ED02WnDS7UwZX0t43GK6imnF2r/NXcraZ2UnN+q+m9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5hXwKd52p2qgifC54EbO0iKUeH6B/t4FUkGx3fWSUo=;
 b=HDmWGJj0SSj6veQPp8x7N2dkjBIzMPDRXH/5Vv40QyNRH5+SC2tKvvZIWg3+BwPl0segqfNWtTE1rv2+wq1oEHhqTt0RtR7dxOchsx9NEvE1mDko2x3J/i3IyMPTb4h54KbcypPXD1ijRoEiWNwnVG8cruB9m3pAoW3oQQaGnn5IPLoNtPTufNPbtNBq1HXQRqzLMi9fdNpCCPcFA1Q/RUoM9dP6UY6nJqzmbB4YUsTTKa3IzgW/5pbWM84RRaF+KWAERM3np9TQcSi6WhpSKmAtfWvpb+vZ3L33lf2ncyO8ATSjOV4tCe8bBtsZbFIvDVAlJAG5s085xAv7ocucEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5hXwKd52p2qgifC54EbO0iKUeH6B/t4FUkGx3fWSUo=;
 b=yQ4p5S4QjkRawd36ESoLZErul2WCdxIk0pfmrfmA4/zYfp9joo9BKhOuSAKJDIhQTqXky4cQXnlbFbRMdLPTF+AXq3OZpnaX3bgBc1eBd2vmwgiHjtjuSsJW59ZuSMeOHHajXkVMB7XI4FO48c9WVxTWMCVaBhha5V5tjZS/aMk=
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS5PPF8B1E59479.namprd12.prod.outlook.com (2603:10b6:f:fc00::659)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 19:29:27 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 19:29:26 +0000
From: "Wu, David" <David.Wu3@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/vcn: drop extra cancel_delayed_work_sync()
Thread-Topic: [PATCH] drm/amdgpu/vcn: drop extra cancel_delayed_work_sync()
Thread-Index: AQHcDIm0xnQBHXEIyUWjUy4cR4ZYQ7Rr6YiA///K1gA=
Date: Wed, 20 Aug 2025 19:29:26 +0000
Message-ID: <45a4074e-860a-4c82-8fa2-6423286a2268@amd.com>
References: <20250813193658.2444953-1-alexander.deucher@amd.com>
 <CADnq5_PqnUUxF7Suj0fg4Q6F6ELa8ugT78gFWHd5Djg1GGB8hg@mail.gmail.com>
In-Reply-To: <CADnq5_PqnUUxF7Suj0fg4Q6F6ELa8ugT78gFWHd5Djg1GGB8hg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-20T19:29:26.3870000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-exchange-imapappendstamp: CY8PR12MB7195.namprd12.prod.outlook.com
 (15.20.9031.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS5PPF8B1E59479:EE_
x-ms-office365-filtering-correlation-id: 2599c760-e091-41d7-ed2e-08dde01fe048
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UDhITTNEVnFKbVRBejd5MUIrTVFHWjhwMGxnZkp5NFpLb3RpdlNtRk8zb2tj?=
 =?utf-8?B?YWFzM2xRclJxUjU0eHoyUzMzQmdjM3NSQkNsNnZKa1VhWE9ISWkwSjR0bXV2?=
 =?utf-8?B?d2N2bnl6REcwSmlhdWNoN1ZxZzhGaG5HbFhQVVRFM3BPUjUvaGJhaUgwT2M5?=
 =?utf-8?B?MzBTSjJPN2Q1RFZNTCswR2VzSGo5dWo2UDRlcDlmMWQwR0Z4RFBiSzFGdC9B?=
 =?utf-8?B?T1c5K2RqcDA1ZTF2TzNKdXhUYmJyTlBEZnRTYy9XTnZXZ3gvTWk1SUU0dUdy?=
 =?utf-8?B?T29qVHg5a1Bwd290aXRuR2NET3VaNTRQM0xOd3ovVzBXTWhJektHanYrMU1U?=
 =?utf-8?B?RlJXelhyQ0hBKzBaZ1RCSi9jSUxDa1hRVW9PMUg0SEhrTy83T0NHUzUwcVJh?=
 =?utf-8?B?WFpIZ0ZRdEY2M1UzNmFCMVVwV3h4d29seWI5T1UwVnorWElnU21XeHJlNWpr?=
 =?utf-8?B?WWtRaVZ2WDVGUzdUM2dqTTlYVHVzazdjZlMzT2lkQkREMG4zdS9QeWRLdTNC?=
 =?utf-8?B?R1lYY2c4Ny9SR2lkZnNNNFc3UElTSklKYjhNTm9UdS85S1IzMElrR3l1WFQ4?=
 =?utf-8?B?U0Y1clJrUzJrNVBCczZ0WXJlcWw0ZlRMU3EwRkpxVjY1dFBOZ2dwaFNLMmlp?=
 =?utf-8?B?cjlQRGFpWmpCVmJrS0hDVDFseVdTOXpIWGVuZzB2QU1TeEh4YXlxbUxlN0lU?=
 =?utf-8?B?c3hPUmNMbFRmMjcvem9rb1g0RjAwck12Nmk0MTFVQjdWOGhvRTE1TUw5aDJT?=
 =?utf-8?B?OSs4dU1rYTBBQlNFQjVSVnVTYXpuc2RiT0YvcWdFa1hVaGFOZlNoT1ZuVWZ1?=
 =?utf-8?B?TW1sZGRweVVvYXcvUVNlRU9DU05GS3NMSG5lVzExWVZVMjRVNGhEZzR0TTBK?=
 =?utf-8?B?dlZ3bXBXR1JVdVEzd2NLVXZoNHJOb3EyR3JucTdJRmNLZmJRZXZEYWhGN2I3?=
 =?utf-8?B?KzcvdzlUeEZEanE0bGhkQmNUWHNNWEVzYWFESUMrdEx4aFBCT3JKRnpvcjlT?=
 =?utf-8?B?WkZkSnRieExVckFsS1czWlJuSmN1SGl6Q0NDN3NjNU9OWmlBNjcxaHYxTnZX?=
 =?utf-8?B?bUxDZ096NjNkZm5hTEEwaWhhRkNLUm1HNUJOR3JGOUZGb0tHL1luTnJSeG9o?=
 =?utf-8?B?ZnA1bWxKdlZsUW83U2FmaUtLV3ZKWlEzaVlZN0hnVGx5N1dpL2JDb3dJRlJJ?=
 =?utf-8?B?SFp6NTJHL082Um0vQkFKNGZRV0FzbXhFVzdYQjJhTVR2d0crT3FLRkd1YXBa?=
 =?utf-8?B?V3RiZVdEZzQ3K0VFNGxJYVVTMkVNdWllK1NJR1dvWDR5WGIvczdERXhWaE02?=
 =?utf-8?B?N2NYajlCSHU2K2Rqc0JRNzdHOTNDaDlmZkltcm1scHl6RkliQVRxZkdHb0ZX?=
 =?utf-8?B?RG1rYkhwOHNqdHBSWGUxYi85YUJubmJYSXpYaXhudDRiTXJ1QnBGYlpSV1lG?=
 =?utf-8?B?VWxNN2hFQitFUzdhQW5BVjJuTXJxVi9BNi9xaHJKcnFuWGVzVlpLNXhZWHhH?=
 =?utf-8?B?aDhjcllzeE5waGdaTUxIMUU5bzhYdS9ER0E3MXozUFl0U3ZZaS9PbFhwYzV5?=
 =?utf-8?B?c1dxeVAvVDA0bjVjUGpDc3BqbkpRSlhRdmE2dnloVVJ0Wk5VZHd6ejZNeDd1?=
 =?utf-8?B?ZnJrTGFNVGJtenAyYTF2TmdkUWtjazZPWGV4K3pFTk5DV2RyMGdCMUVoQTcx?=
 =?utf-8?B?YzFyQ1N2eUhIQ1lVMVU5VDdDZGlkK1BWQ2tjTTRJcmdLR2ZTd05vYm1vK1Jp?=
 =?utf-8?B?YTlGS1ozYjhzU0FVeXFFS0JqSDR1RUtUWDhhU1Q3OGhpeDZURXphUndPVm11?=
 =?utf-8?B?NzRXN1pqcG45eEUyWFJxMXkxdWJ5ZTRNdGZmOWd5b3c0SkFsVUQyclJVUCtD?=
 =?utf-8?B?d29hczhXWGpJUWRZcFBKdCt2UnlIa2tKZDZZK1lTWE5IZnZUSHEyNVNldnh1?=
 =?utf-8?B?RjBwZktXRlRFODhxMGQ4MXlteWZOQWZoMnVUcmdaZVZHRS8waEpMRUo1LzE1?=
 =?utf-8?Q?NR+Ck61PKXecqFVYmd5NPjbmmyG7eI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7195.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVlNRFU0R3ZnekRYbXJOazhBQ1pGR3M2V05Rbk13dmVmRmpnQk1BV242T1Iv?=
 =?utf-8?B?a0UvOHVXS0hjaDFFMnRKUmVrY2JIVEYvRFlzcnMzNjlScVFUS1FTRHl3RTNu?=
 =?utf-8?B?blpCWlRnSG1jdkxDaTNiM0ZpVTRPd2tlRHVDaWcxVHRNZWx0Yy9EbGgxcWVI?=
 =?utf-8?B?UEJKMTNYZlhZbW9JSXl6amRqdGNFWndUdnZHNEJiSi9iY3oyRWF5TzhEek1P?=
 =?utf-8?B?blhXMUl4MzA1YjR1N0tMVHNwN2FTbUNzYzg4dGVoWnIrb3Z0ajNxY1JINWc1?=
 =?utf-8?B?SXNtT0JGNlpXd01SNEErZWpZUFRXNU5lOWtVa21abzVscjRIK1dlcXdMVEY2?=
 =?utf-8?B?T1JtRGNqbDUwQjFmNE1MaXRpd2s5dlpBTXRGVTM1NUExREJHamw3b2l6MW90?=
 =?utf-8?B?OVl2Um5mcmdXQkRMYTFRUGVTSFREb29MSEhGVkF1WDVoZ1crd1FwSytNQWp4?=
 =?utf-8?B?aGluYVo1T2VmbjhOMmZzOFlSRmNzdXROc1d1ZC9jalNUbzBrb1djTHArTzRp?=
 =?utf-8?B?T2FzdlFZNW5PUTQ3VUlvcGt2SmJTVHM3Z3lsM1NaeTVPcEVaYjBIT2UzRWRh?=
 =?utf-8?B?TU5UYi9TSDNCeVkyWGhwdDFzaWsrT0RXYnBudU9jQmhKbUw4Qm9IUEU1cG8z?=
 =?utf-8?B?WUowN2FiYkhQRUN4dE1FdXJHT0hsWHdVb21wREVid1NlOVIvTUpkQmg3cU9Q?=
 =?utf-8?B?T1ptRGpCdUZFTndPbmlUOCt0akg1RWR3QnJCZC9jWVA3VkZmc2N0dHpiQ1Vs?=
 =?utf-8?B?T2FuSEw0TGE2VTEyRENLeEQ5Yll3UTlna3ZwdzRHam5OaXVRb2ZSQUdvTHA2?=
 =?utf-8?B?NEhwMEdyaGx1MnNxZ3FNb0RGSkNmZng0ZzhMdnNBNGVCRlo5SGp0cGx3Wisw?=
 =?utf-8?B?SzRLV0xkcWJvUU9QUG9XcjBGWXFJNGsybHI4V2tnZVVrWWdhbC8xMFAwd0Yw?=
 =?utf-8?B?eFZ4b1Z6M0lxdElWZmtaeHZUYU5CS0R4RE0rVFdLWHhpamtTTmJJRzl2UlpM?=
 =?utf-8?B?L1hMODREV2sreTZmQVB1LzVNZThKbDRibDAySy9YM1hOZTAyR05wM3paM21m?=
 =?utf-8?B?ZmRxK1FuQW81OVFzTExCNDU4T25sYXFNTThJZERZWWRTTWxWQ3lVUTJ6aDRW?=
 =?utf-8?B?UGRkNEZDN0pDZllEUTlYWjlZSlJWb0hYTUd4VncwbWhiSUdyU1kyQ29NUWl3?=
 =?utf-8?B?alJUYnVieGFOYVpiR1N2Y3BGM2dhOWpEUFM4RzVyN2lpOHNSQjRyd3dOakxV?=
 =?utf-8?B?a3MreVp3d2J4WFUvSXhHZmdOVURqU2pERFBDMFluakZFTGVQRi9Xb3FaTi8x?=
 =?utf-8?B?RlQ1bTNzNDIydDBXdjFSQUZMSWgrTGJXWDRVZGZzYnIyUWhWbExYUUJndlk4?=
 =?utf-8?B?L1NTWVZTdWlVdE9oaFFaekhyVEVaelVRbTJqWWx0SmVVdGk5TmJ1ZzVobkRo?=
 =?utf-8?B?TytwR2ozczZaengzT1lYZmtmaEZHUk8yR0lVUTJWNWtMNFlBUWpiOUdjQVdY?=
 =?utf-8?B?RGFhVGs2Z2w0aXNtSVBXRU5Id2dxaFpKbTFlVkI1TzBlRmhUVTRUMGFVSERr?=
 =?utf-8?B?eWFiU0dmbEQwZ0JGaFFpQmlVSmg1OXljWWRtS2kzejE5blFDVzdNc29WdWNZ?=
 =?utf-8?B?T09VV21qdEVsKzZUa3hMMExQNWxVTjgxcWxoMC8vRUkrcnowaG1uTlFXckVC?=
 =?utf-8?B?SldqVlFiYWd3ajZSblczNkVWalU1NEl3ZTY2Q1BQeWNCa0Z5SDBaNEk5cUUv?=
 =?utf-8?B?c285TUdMKzliMUhoM3F1TW4yNDVQZm5JYXRrem5IVHdKby9lSTVZMG14N2lt?=
 =?utf-8?B?S1ZFTzcycmRoMHFRUFozL3FRRkZTMEFDSTBibktMWUM5bEpDblpwT0h2OW5Y?=
 =?utf-8?B?MWhTVVB6UWZDQ2lRM1pIQ0FXS085ZUVwMXVjbXVGNnozRUJyZ1MybjlPeVYx?=
 =?utf-8?B?UjRySkJabEdXRGVGdTZ5c2E0NE5sNDVyTjhLdnl4b3lUZzI5My9YRkFPS3g0?=
 =?utf-8?B?aUQ3d3h6OEJjaTc1MzRtUWx3M0FnZmxDYmlBRVdzTExycHZHVS85VlU5RlVD?=
 =?utf-8?B?YjFSbS9DbWFuUmVxR1NQR2VnT1pZZ1MzREg1SE9XNXlOb29NakFZV05XRGE2?=
 =?utf-8?Q?9Wpg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_45a4074e860a4c828fa26423286a2268amdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2599c760-e091-41d7-ed2e-08dde01fe048
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 19:29:26.7635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zX8d9c9f7FghGUwagR0nP1CRpdNI4YDfaItVuwJWJs0f0u9bDLiYSbYas1d9dUa6M1JOL0vHvGYnNMZxFxOCfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8B1E59479
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

--_000_45a4074e860a4c828fa26423286a2268amdcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KDQpvbmUgdGhpbmcgSSBub3RpY2VkOg0KICAgYW1kZ3B1X3Zjbl9zdXNwZW5kKCkgYWxzbyBn
ZXRzIGNhbGxlZCBpbiB2Y25fdjJfNV9zd19maW5pKCkgZm9yIGV4YW1wbGUNCiAgIHdoZXJlIHRo
ZXJlIGlzbid0IGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygpIGNhbGwuIERvZXMgdGhlIHJlbW92
YWwgd29yayBpbiB0aGlzIGNhc2U/DQoNCkRhdmlkDQpPbiA4LzIwLzIwMjUgMjozNiBQTSwgQWxl
eCBEZXVjaGVyIHdyb3RlOg0KDQpQaW5nPw0KDQpPbiBXZWQsIEF1ZyAxMywgMjAyNSBhdCAzOjM3
4oCvUE0gQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPjxtYWlsdG86YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4gd3JvdGU6DQoNCg0KV2UgYWxyZWFkeSBjYWxsIHRoaXMg
aW4gdGhlIGh3X2ZpbmkoKSBtZXRob2RzIGZvciBhbGwNClZDTiBpbnN0YW5jZXMsIHNvIG5vIG5l
ZWQgdG8gY2FsbCBpdCBhZ2FpbiBpbg0KYW1kZ3B1X3Zjbl9zdXNwZW5kKCkuDQoNClNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT48bWFpbHRvOmFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmNuLmMgfCAyIC0tDQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMNCmluZGV4IDlhNzZlMTFkMWMx
ODQuLmZkOGViZjRiNWE4MjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmNuLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
Y24uYw0KQEAgLTM1Nyw4ICszNTcsNiBAQCBpbnQgYW1kZ3B1X3Zjbl9zdXNwZW5kKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCBpbnQgaSkNCiAgICAgICAgaWYgKGFkZXYtPnZjbi5oYXJ2ZXN0
X2NvbmZpZyAmICgxIDw8IGkpKQ0KICAgICAgICAgICAgICAgIHJldHVybiAwOw0KDQotICAgICAg
IGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmluc3RbaV0uaWRsZV93b3JrKTsN
Ci0NCiAgICAgICAgLyogZXJyX2V2ZW50X2F0aHViIGFuZCBkcGMgcmVjb3Zlcnkgd2lsbCBjb3Jy
dXB0IFZDUFUgYnVmZmVyLCBzbyB3ZSBuZWVkIHRvDQogICAgICAgICAqIHJlc3RvcmUgZncgZGF0
YSBhbmQgY2xlYXIgYnVmZmVyIGluIGFtZGdwdV92Y25fcmVzdW1lKCkgKi8NCiAgICAgICAgaWYg
KGluX3Jhc19pbnRyIHx8IGFkZXYtPnBjaWVfcmVzZXRfY3R4LmluX2xpbmtfcmVzZXQpDQotLQ0K
Mi41MC4xDQoNCg0KDQo=

--_000_45a4074e860a4c828fa26423286a2268amdcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <70A2537B5CBB674285D9414CE493C17C@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxwIHN0eWxlPSJmb250LWZhbWlseTpDYWxp
YnJpO2ZvbnQtc2l6ZToxMHB0O2NvbG9yOiMwMDAwRkY7bWFyZ2luOjVwdDtmb250LXN0eWxlOm5v
cm1hbDtmb250LXdlaWdodDpub3JtYWw7dGV4dC1kZWNvcmF0aW9uOm5vbmU7IiBhbGlnbj0iTGVm
dCI+DQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBP
bmx5XTxicj4NCjwvcD4NCjxicj4NCjxkaXY+DQo8cHJlPjxkaXYgY2xhc3M9ImVsZW1lbnRUb1By
b29mIj5vbmUgdGhpbmcgSSBub3RpY2VkOgogJm5ic3A7IGFtZGdwdV92Y25fc3VzcGVuZCgpIGFs
c28gZ2V0cyBjYWxsZWQgaW4gdmNuX3YyXzVfc3dfZmluaSgpIGZvciBleGFtcGxlCiZuYnNwOyAm
bmJzcDt3aGVyZSB0aGVyZSBpc24ndCZuYnNwO2NhbmNlbF9kZWxheWVkX3dvcmtfc3luYygpIGNh
bGwuIERvZXMgdGhlIHJlbW92YWwgd29yayBpbiB0aGlzIGNhc2U/PC9kaXY+PC9wcmU+DQo8c3Bh
biBzdHlsZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZTsiPkRhdmlkPC9zcGFuPg0KPGRpdj5PbiA4
LzIwLzIwMjUgMjozNiBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOjwvZGl2Pg0KPGJsb2NrcXVvdGU+
DQo8cHJlPjxkaXY+UGluZz8KCk9uIFdlZCwgQXVnIDEzLCAyMDI1IGF0IDM6MzfigK9QTSBBbGV4
IERldWNoZXIgPGEgY2xhc3M9Im1vei10eHQtbGluay1yZmMyMzk2RSBPV0FBdXRvTGluayIgaWQ9
Ik9XQTYwZGI2YTQwLTM3YTYtOTUzOC02MTIxLTUyMTA4NWU3NDVkOSIgaHJlZj0ibWFpbHRvOmFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20iPiZsdDthbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tJmd0
OzwvYT4gd3JvdGU6CjwvZGl2PjwvcHJlPg0KPGJsb2NrcXVvdGU+DQo8cHJlPjxkaXY+V2UgYWxy
ZWFkeSBjYWxsIHRoaXMgaW4gdGhlIGh3X2ZpbmkoKSBtZXRob2RzIGZvciBhbGwKVkNOIGluc3Rh
bmNlcywgc28gbm8gbmVlZCB0byBjYWxsIGl0IGFnYWluIGluCmFtZGdwdV92Y25fc3VzcGVuZCgp
LgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhIGNsYXNzPSJtb3otdHh0LWxpbmstcmZj
MjM5NkUgT1dBQXV0b0xpbmsiIGlkPSJPV0E1NjAyNjcxMC1lYjAyLTUyNzctMzVjMy0wZWI5ZWUx
NDMyZjUiIGhyZWY9Im1haWx0bzphbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tIj4mbHQ7YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbSZndDs8L2E+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCmluZGV4IDlhNzZlMTFkMWMxODQu
LmZkOGViZjRiNWE4MjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y24uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMK
QEAgLTM1Nyw4ICszNTcsNiBAQCBpbnQgYW1kZ3B1X3Zjbl9zdXNwZW5kKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCBpbnQgaSkKICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO2lmIChhZGV2
LSZndDt2Y24uaGFydmVzdF9jb25maWcgJmFtcDsgKDEgJmx0OyZsdDsgaSkpCiAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7cmV0dXJuIDA7Cgot
ICZuYnNwOyAmbmJzcDsgJm5ic3A7IGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYW1wO2FkZXYt
Jmd0O3Zjbi5pbnN0W2ldLmlkbGVfd29yayk7Ci0KICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
Oy8qIGVycl9ldmVudF9hdGh1YiBhbmQgZHBjIHJlY292ZXJ5IHdpbGwgY29ycnVwdCBWQ1BVIGJ1
ZmZlciwgc28gd2UgbmVlZCB0bwogJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICogcmVzdG9y
ZSBmdyBkYXRhIGFuZCBjbGVhciBidWZmZXIgaW4gYW1kZ3B1X3Zjbl9yZXN1bWUoKSAqLwogJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7aWYgKGluX3Jhc19pbnRyIHx8IGFkZXYtJmd0O3BjaWVf
cmVzZXRfY3R4LmluX2xpbmtfcmVzZXQpCi0tCjIuNTAuMQoKPC9kaXY+PC9wcmU+DQo8L2Jsb2Nr
cXVvdGU+DQo8L2Jsb2NrcXVvdGU+DQo8YnI+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_45a4074e860a4c828fa26423286a2268amdcom_--
