Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAC8C3ABB2
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 01:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E5E10E6DA;
	Thu, 29 May 2025 01:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fEEdaFFq";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40AE10E1CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 01:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsMgabL5g7QkMWiETgZ/DKLLCKu84QBAKBLMilrFjQswb7xrehwVljaWESmQ3semefbl3Vo3ViF1tKXOJBU3mI+azie9WsjOUCLotBW/kh1kQS4CnaRIzSBCIpIoSH5K4wjxAgZs+mFBV2xwiNUjtXQ3ekNovAPTESAp+QbCDj968BjZb1ONQMI5uxt9sC3GbNNbeIV6uSjXFqUpOA3yKB2pTEB3pU7cnXX/FpoprgJ8N+DDY/039s/dLupEMKZVltiRt4l+JA809ogWvjsqRvy8ZKdzUx21Hz6Pr/MCYmJOAedqzoDa0aCTATsgRUBfv+xXg3xJMvwAh1kZ/GpBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTaEIKCwc3u9wDqGCz5PzGRGa4Lz/kMECk3ezLbFFSg=;
 b=HD83Sb0IJoCTupiHDHrHTVXfgA3E9FyxCLMFZ5f79SEhR6HPB6XNsg7JTzJNZvwtbWsyx9qSY2JU2fkh/+fxpwhvUx4E1KYhavTpyF1QVQD/Yh7Vsg03ZVdcXgtFFmEc56VkvHmnTzQOYElEKq07Dor1EJhid4avr8cuIsfVrLyjEhBZXIqDFknAsfFIRLYpcw9gQFhsF8UT2Uih8NW80fvsNrquTou1vxeDD9fSdEhI+w0mzbmPffICPJ3ZzzUPLCg88RND0Qn3ga06SYal4i2F7eucI9F4I1NDTrJ6t8lUwabL5RO80G2kWsoHc1cE0pZug4lmZe7Rnc+Joo7Bhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTaEIKCwc3u9wDqGCz5PzGRGa4Lz/kMECk3ezLbFFSg=;
 b=fEEdaFFqKMo7EZPKUFkINL9hVfvG+mtrhAx5X2AgHLHqwE37j0UQOViN55zY6ZjK9YqjQG0hSzVTmSUBTL/dgyc9p/bian8Eu1E05WD8QQvbkkLxhrTAT+MdjkuQKLDGtk0T1ElH1jIZ7WGlZAgwIyEDW7dNRmNq59NyRJ6UOZ4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 01:47:56 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%7]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 01:47:56 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: only export available rings to mesa for
 enabling kq|uq
Thread-Topic: [PATCH] drm/amdgpu: only export available rings to mesa for
 enabling kq|uq
Thread-Index: AQHbz6vZKeVCWouWeEa0JibX4Ga7KrPn5dEAgADvAUA=
Date: Thu, 29 May 2025 01:47:56 +0000
Message-ID: <DS7PR12MB60051E9553863DF0CA604FACFB66A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250528083756.847677-1-Prike.Liang@amd.com>
 <97494a80-4336-4a1b-81af-56ca8ca974e3@amd.com>
In-Reply-To: <97494a80-4336-4a1b-81af-56ca8ca974e3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c7e47bfa-ac46-46e1-b5f2-ce5195e2c5f6;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-29T01:36:38Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH8PR12MB6915:EE_
x-ms-office365-filtering-correlation-id: 85b5a742-621e-4d6d-f831-08dd9e52d5ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Z3FUblNRWXhFZ3hTUDBHQzNPWEhUeHo1SVo3RnlGYTRvTE1JcUhxTVpGSUZI?=
 =?utf-8?B?UkZIMGFMS2xFZFNGVlhQdmNpTEg1U29RSHdkN3l4M0NTODh2NUtlL2lQMTJI?=
 =?utf-8?B?RDRUMzVmOXlkRUFyTkxXZlIwQnJCMkFab2JFTlNCbzl4UVFRRExFOCtDOExJ?=
 =?utf-8?B?N3ZxN2VPVFBlalpwVG5tUkJPKzE1cjA3MzRhb3BvR1UrSWgyOXNudUY0dGl6?=
 =?utf-8?B?elpLYXpNS3JUaTZ1Q0U5K2ZYaVh0bVdBZG5HMDRuVkE2Rk1DVSt2UUFEb0VD?=
 =?utf-8?B?YVhDd2lzZGxwSTJSeDJaRkt3TUhwN2ozbGlLRDczTjE3M1JZamo1ZXR0R0JV?=
 =?utf-8?B?THliOCttOEV5Qzl2bGRGMVNHLzNyS1dzNGxDSFpGckZJWkpuc2p5ZWRSNjI4?=
 =?utf-8?B?Ym9wNFJxV1VHdE8wZ3czazh0U1lodHZqdERzL3B6QjJWNnVHV2llSnRJUXlh?=
 =?utf-8?B?Yk9lb3ZtdDl6MWdCdEVkU09mVHZtNHZmcFZkQVltY2VyTERkQkt0QTMrVGQz?=
 =?utf-8?B?S2NQaEhNWGVRUHpLbFFDSmhZMzVSU2s4Vjhmc3I1c3E1Ujl0akRVUG1sb2lM?=
 =?utf-8?B?dmNhUEtmbTg3Zm9MTXNPTDg0amlHZjErdFFJVmZxYWdYcDdtK0NCY0FUWTU2?=
 =?utf-8?B?eHR1VTJTVVZhVXdmT2hyT3hlL1VXdUxFcmxKVDIvZTZEQmNkNHhINjFnb29r?=
 =?utf-8?B?N1dlZjlZZS8wUFUvTUp1OHR6ZEV2RUtCVGFPeU95K2xlbkR4NyttRnIrTFVT?=
 =?utf-8?B?UHMxMzFVa0tidm1MR3EzWC9TWW1pWkdmWFRpd205Lzg2VDJYWXRHV1Vsakp6?=
 =?utf-8?B?VjA5aFhyYzBZdlk5bzhrTG1OY2FlRkdlYnVSQmtVTHowU3JBTzl3MzEvTzh0?=
 =?utf-8?B?a2VnaTJkblFHUEE2S1N1dk42QUcxMTZxdkNoSXVaV0M1QklwK3BRQUVYVDF0?=
 =?utf-8?B?Q2hQMEE5ZWh1aGN1WnlkK2FYQUo2RFZ0UlQrZEYwckZLYmFlZjBKWWc3S0o0?=
 =?utf-8?B?WEZPK050SmlQZHhpNmVOcThoTE04UnBqbXF1U2ZCMk9qTE5FbmxNS0VwTVEx?=
 =?utf-8?B?Wm9vTlhoUS8rV256dFZ5STFCNTB6TGd1akpFQW9Mb2N4NkR0SDdiTkc5eklt?=
 =?utf-8?B?OW1yREVJUjRVQnhDaWJ0VWl3bWpiK2RRVWtxWW9XQmlRSUJwS1hkM3k0OGNa?=
 =?utf-8?B?aXRhWFB4WW9PQlI4OGNFYVRGWjN0SlZwRC8yL0dHVFpGd3lKblJQaHZmd0FD?=
 =?utf-8?B?L01vYU5aTlNENjdNaXEwZFJoUGdLaDJrRlN2T2hSNTVGV205NllvL21Gd040?=
 =?utf-8?B?dy9qQUNWdUZxM1p2Ti9Ranpub0FmR0xUM2VzUGMzUXZYUjNNL0lYcnorWFJG?=
 =?utf-8?B?eXpMQXhTbE12aVQwUUVpN1h5T000eGpGRlI0VW1DSFo5Yno0YmVRcDRCcmhJ?=
 =?utf-8?B?MW9xNnA0MUsrRGZ1dGNYRDV6alVOWm9CWklzdWRuNnJhdXp5cnFnMlg3ZGpn?=
 =?utf-8?B?blFicThBaDA2MjlBb1JRMHZTQ0xUSE1yUW9sVmpTQVhQcDJPRVdXQTlheEtR?=
 =?utf-8?B?NVUyUW5nM2R4MFNZTlU4YnRQZHVYZ2lHVkJubHl5S2Vlc21iSFhpMm5ZT1BE?=
 =?utf-8?B?OWhrR0JwWld5U0RNRWxWbWpGMWNHVGxNUHBFR0c4b3FKZVZ1dHp0SHQyMzcx?=
 =?utf-8?B?ZWR3UnBpQW5KK01PaHdRUnQxQ1pEVjFpcXdNVkNIbGlxeU44TXRIMkI4emVx?=
 =?utf-8?B?WktqZkdxd2ZTRTNPQVNkUGE4NzFtWkE1Z3JDdU9DSkl6NXh1QlRSWmZGRUtC?=
 =?utf-8?B?SXhZREs5WHk0WjljU1FiWEdjOForaW1sSFQ5bUc0dnhDRmpJcllSclN0Ullj?=
 =?utf-8?B?bXQyTjJCMG9vQWRnNGhCMUxnZmxsTUxYczdQR2pZcmZydjE5Vm9KekVNNDZ3?=
 =?utf-8?B?RElvK3V5Mm9MNHRXRys4WkpRZTBYc1duRFlYRmYyTmd1QWVmb3ZDbkRUSUVL?=
 =?utf-8?Q?0638j17ZNwQSBzKXUYq4mOFFaFjvuU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGNsUVFpVHNaMkR6RlFjNWJySDhVY0RZQi9KNFR5c2o1dnAxcG9kaTNDSEZp?=
 =?utf-8?B?bFVBc1ArNkh2VmQ1eVNVSkRuUTBIdldoR1dKU1ZLb2p0VUpPeG9sV2doUGNo?=
 =?utf-8?B?c3EvN2NuUDY3bytrMFFoT2NVRkM2VjQ1ZVpDZXNZZGYwT09HOHJBbnJZSFBo?=
 =?utf-8?B?U2x4aVU1RXNWL01lTkFyem9vdWZHV2gvbTJwbWJMS2JLaFhKMCtMcUZsa0Vj?=
 =?utf-8?B?L3RBMHA0NEVPcDdXWW9jdm1Yby9kQ0htRGlreVVFaEZENG14TVl3c25sSlYy?=
 =?utf-8?B?d2xlZmNTTkdJc1AvS3JHL0plYURaOFFtM0YzeGFISUN1ZTFCRHRFQ1JiZ0ly?=
 =?utf-8?B?bTArQ2t4WGlIamxST0tFanhBMjZyZ0RtRXZTMm8xRHJkTGpFT1p5U3oyR1Y4?=
 =?utf-8?B?a3dYT2hrVVM0WXRFZ2IvV05oUldJcGpBZGNOOHNDSzYzdEZXRUNqTDE2b2hy?=
 =?utf-8?B?enFmc2lYdWlQL3Q1KzNBbDRuMjY3M1NmcnUyRnJNMlVqT05SSXJKN1hJbmJN?=
 =?utf-8?B?TXhCcWVuNlIzV0NGNEEyQkdHcEV1eGlQTSt4QlhPUGQ2dDlXVnBlT09IQTRU?=
 =?utf-8?B?NEpFakVOVGZibmJYNnlwb3BlVG1TWEtBZFZIWDIwMGQ1MnRCM3FTdXdzcWZh?=
 =?utf-8?B?RE42WSttbXBNa2FoY1ZBd1Z1emJuRHBQYWN1bUZQVUYwRmR1U2tsc3ZRUjVk?=
 =?utf-8?B?YWZPSUxQcDRRdkpmb05qcTFOM3laUi9oSXY5cndoMm03QjY2UG1xMm1PMEFh?=
 =?utf-8?B?amZYaFlhbCtkTDVobW5mRVBqdUJhSDRsNkdIUEN3ZmdaMUtuSDVicXhKOE4y?=
 =?utf-8?B?OFpoRWRLZzZqUElVTEJZdEN6RXVPcmdlZmtpTDNxb2l3YUs1MTZ2TlMwR29a?=
 =?utf-8?B?SFRrNE9Hcy9KaFNnK29sNzlJR214RW5SeHhIVExtRGZYd2YzemtNRERWMGxu?=
 =?utf-8?B?b21abGxhSkdpbVVRMGMzQmtkcEpUTWxwek52K1BteDhtWkptOUtza1RFTjlN?=
 =?utf-8?B?aW9rUTVqQUMray8zWFJFWjRrbitzUE1PQWJiUEFsTHo0TWxTSExuTitxRzRv?=
 =?utf-8?B?WG43bDRVNzNmRDB2cGFkL29xb2RnMi9JVklkSCtXZ0pMZHpacTVIckhMS0Ri?=
 =?utf-8?B?VkZlUE43Zmo3YnA4Ky9jZU5RUDBXMEtGZGZzUUt6MHc0REVDZFB0V2hNWk1U?=
 =?utf-8?B?QzN4QUkzRjQ2TDJVK25FMlNqZ0x6MmR4VFd0S3lra3UvTVl2aUVjdmJsTC9S?=
 =?utf-8?B?UFEyQjdhMFlnblRLUEdNeTZFK2tSTXhYNkRTSGJMZENuTjRjWUJ5VVBON1M0?=
 =?utf-8?B?cHpNWitIUFhUdHlzazBVWUJiSmE2YW1sYks1S2dkcnlvck1yb1hWWS9vSW1I?=
 =?utf-8?B?STBFS0lNdnJlY1lXWFErbmptSXFnRjdEZDZYRFVVWEQ0UGMxQVV5RWdLc1lt?=
 =?utf-8?B?VmRiWEhEY0pwcUhIV01ycTVrM1UyN3NjamQ3U0pZVVdCOWdNaWdzUHltZU8r?=
 =?utf-8?B?bExwaVNJM2pEYzgzaGpxWTV5VHhRNVg1azdTcXQwN0VXYVNjNnRSNGE1WmpR?=
 =?utf-8?B?L0E4ZWlLUkZaNGVSeEZnWlAzL2pkWnV0Q0JnS1NFWnVPMExUNUFNYkxSWkRl?=
 =?utf-8?B?c0xIbVNkNTBJamMvYWUybUlNaHI2QkN4QnRIV0w2M1YwYWlFSW5KSHExZHR3?=
 =?utf-8?B?ajRnSEg5Mkl4TUxOeXJudHZBM0dpdjBVNzhGZTRoKzJJTC9XZG9iWW9qMEdo?=
 =?utf-8?B?RVF6cDNmMXhnVXlLWTFPSU5vK092eG1WNGVCYVJjNGN0WFdRbWYwbS85VllK?=
 =?utf-8?B?OUEzbnBiWWZwUmw2MzNFVHdwKzRzZ2g5SmtRSlN4MXF1MUN2dEluN0FRZW54?=
 =?utf-8?B?aDh4b1R3NndTZXIyeVYxcFRpM29Gd0RSVVl2WU5qSG1pbDFRQXpSejJJODQ2?=
 =?utf-8?B?K2UrMU5TNHJCOWhpa1BkOThRL0dKVTVaNGRtT0dKbW1QdThMcTVDWEJPQ1VB?=
 =?utf-8?B?STNlZ1JPMWJJakpabk12NGVrdFArc1F0WFoyVmpxdU5KZDdZbkd6cHhRbFNn?=
 =?utf-8?B?Wnp2MWxkSHNCalBpUXpNVmhoWTdybXk0ZUZTL3JKZngzTGVsWXg4UkN3K1pC?=
 =?utf-8?Q?skq0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b5a742-621e-4d6d-f831-08dd9e52d5ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 01:47:56.6323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8h9qdWrFtZMioFoqx0kbTUADcNxH13NwIZPotQjaZUmwAGLqgKd2EeF4Bk0DkMoH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAyOCwgMjAyNSA3OjIxIFBNDQo+IFRvOiBM
aWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBvbmx5IGV4cG9ydCBhdmFp
bGFibGUgcmluZ3MgdG8gbWVzYSBmb3IgZW5hYmxpbmcNCj4ga3F8dXENCj4NCj4gT24gNS8yOC8y
NSAxMDozNywgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4gVGhlIGtlcm5lbCBkcml2ZXIgb25seSBy
ZXF1aXJlcyBleHBvcnRpbmcgYXZhaWxhYmxlIHJpbmdzIHRvIHRoZSBtZXNhDQo+ID4gd2hlbiB0
aGUgdXNlcnEgaXMgZGlzYWJsZWQ7IG90aGVyd2lzZSwgdGhlIHVzZXJxIElQIG1hc2sgd2lsbCBi
ZQ0KPiA+IGNsZWFuZWQgdXAgaW4gdGhlIG1lc2EuDQo+DQo+IEh1aT8gVGhhdCBkb2Vzbid0IHNv
dW5kcyBjb3JyZWN0IHRvIG1lLg0KPg0KPiBUaGF0IHVzZXJxIGlzIGRpc2FibGUgaW4gbWVzYSB3
aGVuIGtlcm5lbCBxdWV1ZXMgYXJlIGF2YWlsYWJsZSBpcyBpbnRlbnRpb25hbGx5IGZvcg0KPiBu
b3cuDQoNCkN1cnJlbnRseSwgd2hlbiB0aGUga2VybmVsIGRyaXZlciBzZXRzIHVzZXJfcXVldWUg
dG8gMSBmb3IgZW5hYmxpbmcgdGhlIGtlcm5lbCBxdWV1ZSBhbmQgdXNlciBxdWV1ZSwgYnV0IHRo
ZSB1c2VyIHF1ZXVlIElQIG1hc2sgd2lsbCBiZSBjbGVhbmVkIHVwIGluIHRoZSBtZXNhLCBzbyB0
aGUgZHJpdmVyIG9ubHkgc3VwcG9ydHMgdGhlIGtlcm5lbCBxdWV1ZSBhbmQgY2FuJ3QgZW5hYmxl
IHVzZXIgcXVldWUgc2ltdWx0YW5lb3VzbHkuDQoNClRoYW5rcywNClByaWtlDQoNCj4gUmVnYXJk
cywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcg
PFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDIwICsrKysrKysrKystLS0tLS0tLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj4gPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiA+IGluZGV4IGQyY2U3
ZDg2ZGJjOC4uNDNkODZjMDlkOGJiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9rbXMuYw0KPiA+IEBAIC00MDksNyArNDA5LDcgQEAgc3RhdGljIGludCBhbWRn
cHVfaHdfaXBfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwNCj4gPiAgICAgICAg
ICAgICB0eXBlID0gQU1EX0lQX0JMT0NLX1RZUEVfR0ZYOw0KPiA+ICAgICAgICAgICAgIGZvciAo
aSA9IDA7IGkgPCBhZGV2LT5nZngubnVtX2dmeF9yaW5nczsgaSsrKQ0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgaWYgKGFkZXYtPmdmeC5nZnhfcmluZ1tpXS5zY2hlZC5yZWFkeSAmJg0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICFhZGV2LT5nZnguZ2Z4X3JpbmdbaV0ubm9fdXNlcl9zdWJt
aXNzaW9uKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5kaXNhYmxlX3Vx
KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArK251bV9yaW5nczsNCj4gPiAgICAg
ICAgICAgICBpYl9zdGFydF9hbGlnbm1lbnQgPSAzMjsNCj4gPiAgICAgICAgICAgICBpYl9zaXpl
X2FsaWdubWVudCA9IDMyOw0KPiA+IEBAIC00MTgsNyArNDE4LDcgQEAgc3RhdGljIGludCBhbWRn
cHVfaHdfaXBfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwNCj4gPiAgICAgICAg
ICAgICB0eXBlID0gQU1EX0lQX0JMT0NLX1RZUEVfR0ZYOw0KPiA+ICAgICAgICAgICAgIGZvciAo
aSA9IDA7IGkgPCBhZGV2LT5nZngubnVtX2NvbXB1dGVfcmluZ3M7IGkrKykNCj4gPiAgICAgICAg
ICAgICAgICAgICAgIGlmIChhZGV2LT5nZnguY29tcHV0ZV9yaW5nW2ldLnNjaGVkLnJlYWR5ICYm
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgIWFkZXYtPmdmeC5jb21wdXRlX3JpbmdbaV0u
bm9fdXNlcl9zdWJtaXNzaW9uKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmdm
eC5kaXNhYmxlX3VxKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArK251bV9yaW5n
czsNCj4gPiAgICAgICAgICAgICBpYl9zdGFydF9hbGlnbm1lbnQgPSAzMjsNCj4gPiAgICAgICAg
ICAgICBpYl9zaXplX2FsaWdubWVudCA9IDMyOw0KPiA+IEBAIC00MjcsNyArNDI3LDcgQEAgc3Rh
dGljIGludCBhbWRncHVfaHdfaXBfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwN
Cj4gPiAgICAgICAgICAgICB0eXBlID0gQU1EX0lQX0JMT0NLX1RZUEVfU0RNQTsNCj4gPiAgICAg
ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+c2RtYS5udW1faW5zdGFuY2VzOyBpKyspDQo+
ID4gICAgICAgICAgICAgICAgICAgICBpZiAoYWRldi0+c2RtYS5pbnN0YW5jZVtpXS5yaW5nLnNj
aGVkLnJlYWR5ICYmDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgIWFkZXYtPnNkbWEuaW5z
dGFuY2VbaV0ucmluZy5ub191c2VyX3N1Ym1pc3Npb24pDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGFkZXYtPmdmeC5kaXNhYmxlX3VxKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICArK251bV9yaW5nczsNCj4gPiAgICAgICAgICAgICBpYl9zdGFydF9hbGlnbm1lbnQg
PSAyNTY7DQo+ID4gICAgICAgICAgICAgaWJfc2l6ZV9hbGlnbm1lbnQgPSA0Ow0KPiA+IEBAIC00
MzksNyArNDM5LDcgQEAgc3RhdGljIGludCBhbWRncHVfaHdfaXBfaW5mbyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZQ0KPiAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGlu
dWU7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgICAgIGlmIChhZGV2LT51dmQuaW5zdFtpXS5y
aW5nLnNjaGVkLnJlYWR5ICYmDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgIWFkZXYtPnV2
ZC5pbnN0W2ldLnJpbmcubm9fdXNlcl9zdWJtaXNzaW9uKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGFkZXYtPmdmeC5kaXNhYmxlX3VxKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICArK251bV9yaW5nczsNCj4gPiAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgaWJf
c3RhcnRfYWxpZ25tZW50ID0gMjU2Ow0KPiA+IEBAIC00NDksNyArNDQ5LDcgQEAgc3RhdGljIGlu
dCBhbWRncHVfaHdfaXBfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwNCj4gPiAg
ICAgICAgICAgICB0eXBlID0gQU1EX0lQX0JMT0NLX1RZUEVfVkNFOw0KPiA+ICAgICAgICAgICAg
IGZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y2UubnVtX3JpbmdzOyBpKyspDQo+ID4gICAgICAgICAg
ICAgICAgICAgICBpZiAoYWRldi0+dmNlLnJpbmdbaV0uc2NoZWQucmVhZHkgJiYNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAhYWRldi0+dmNlLnJpbmdbaV0ubm9fdXNlcl9zdWJtaXNzaW9u
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5kaXNhYmxlX3VxKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArK251bV9yaW5nczsNCj4gPiAgICAgICAgICAg
ICBpYl9zdGFydF9hbGlnbm1lbnQgPSAyNTY7DQo+ID4gICAgICAgICAgICAgaWJfc2l6ZV9hbGln
bm1lbnQgPSA0Ow0KPiA+IEBAIC00NjIsNyArNDYyLDcgQEAgc3RhdGljIGludCBhbWRncHVfaHdf
aXBfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiA+ICphZGV2LA0KPiA+DQo+ID4gICAgICAg
ICAgICAgICAgICAgICBmb3IgKGogPSAwOyBqIDwgYWRldi0+dXZkLm51bV9lbmNfcmluZ3M7IGor
KykNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGFkZXYtPnV2ZC5pbnN0W2ld
LnJpbmdfZW5jW2pdLnNjaGVkLnJlYWR5ICYmDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAhYWRldi0+dXZkLmluc3RbaV0ucmluZ19lbmNbal0ubm9fdXNlcl9zdWJtaXNzaW9u
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRldi0+Z2Z4LmRpc2FibGVf
dXEpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKytudW1fcmluZ3M7
DQo+ID4gICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgIGliX3N0YXJ0X2FsaWdubWVudCA9
IDI1NjsNCj4gPiBAQCAtNDc1LDcgKzQ3NSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2h3X2lwX2lu
Zm8oc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnRpbnVlOw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICAgICBpZiAoYWRl
di0+dmNuLmluc3RbaV0ucmluZ19kZWMuc2NoZWQucmVhZHkgJiYNCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICAhYWRldi0+dmNuLmluc3RbaV0ucmluZ19kZWMubm9fdXNlcl9zdWJtaXNzaW9u
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5kaXNhYmxlX3VxKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArK251bV9yaW5nczsNCj4gPiAgICAgICAgICAg
ICB9DQo+ID4gICAgICAgICAgICAgaWJfc3RhcnRfYWxpZ25tZW50ID0gMjU2Ow0KPiA+IEBAIC00
ODksNyArNDg5LDcgQEAgc3RhdGljIGludCBhbWRncHVfaHdfaXBfaW5mbyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZQ0KPiA+ICphZGV2LA0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICAgICBmb3IgKGog
PSAwOyBqIDwgYWRldi0+dmNuLmluc3RbaV0ubnVtX2VuY19yaW5nczsgaisrKQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpZiAoYWRldi0+dmNuLmluc3RbaV0ucmluZ19lbmNbal0u
c2NoZWQucmVhZHkgJiYNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICFhZGV2
LT52Y24uaW5zdFtpXS5yaW5nX2VuY1tqXS5ub191c2VyX3N1Ym1pc3Npb24pDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5nZnguZGlzYWJsZV91cSkNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArK251bV9yaW5nczsNCj4gPiAgICAgICAg
ICAgICB9DQo+ID4gICAgICAgICAgICAgaWJfc3RhcnRfYWxpZ25tZW50ID0gMjU2Ow0KPiA+IEBA
IC01MDUsNyArNTA1LDcgQEAgc3RhdGljIGludCBhbWRncHVfaHdfaXBfaW5mbyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZQ0KPiA+ICphZGV2LA0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICAgICBmb3Ig
KGogPSAwOyBqIDwgYWRldi0+anBlZy5udW1fanBlZ19yaW5nczsgaisrKQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpZiAoYWRldi0+anBlZy5pbnN0W2ldLnJpbmdfZGVjW2pdLnNj
aGVkLnJlYWR5ICYmDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAhYWRldi0+
anBlZy5pbnN0W2ldLnJpbmdfZGVjW2pdLm5vX3VzZXJfc3VibWlzc2lvbikNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5kaXNhYmxlX3VxKQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICsrbnVtX3JpbmdzOw0KPiA+ICAgICAgICAg
ICAgIH0NCj4gPiAgICAgICAgICAgICBpYl9zdGFydF9hbGlnbm1lbnQgPSAyNTY7DQo+ID4gQEAg
LTUxNCw3ICs1MTQsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9od19pcF9pbmZvKHN0cnVjdCBhbWRn
cHVfZGV2aWNlDQo+ICphZGV2LA0KPiA+ICAgICBjYXNlIEFNREdQVV9IV19JUF9WUEU6DQo+ID4g
ICAgICAgICAgICAgdHlwZSA9IEFNRF9JUF9CTE9DS19UWVBFX1ZQRTsNCj4gPiAgICAgICAgICAg
ICBpZiAoYWRldi0+dnBlLnJpbmcuc2NoZWQucmVhZHkgJiYNCj4gPiAtICAgICAgICAgICAgICAg
IWFkZXYtPnZwZS5yaW5nLm5vX3VzZXJfc3VibWlzc2lvbikNCj4gPiArICAgICAgICAgICAgICAg
YWRldi0+Z2Z4LmRpc2FibGVfdXEpDQo+ID4gICAgICAgICAgICAgICAgICAgICArK251bV9yaW5n
czsNCj4gPiAgICAgICAgICAgICBpYl9zdGFydF9hbGlnbm1lbnQgPSAyNTY7DQo+ID4gICAgICAg
ICAgICAgaWJfc2l6ZV9hbGlnbm1lbnQgPSA0Ow0KDQo=
