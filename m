Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234BFC2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 09:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13B610E7D4;
	Thu, 15 May 2025 09:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UNQgqsBf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B870F10E7DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 09:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0JH1QDIA6VanAHrdTu2/XLLIm/rV4Tb7vNb6y1Wm5nkxIWCtMkbyYIGOkyxf7jpMwpqS+JP2M/BKNeYGAlM1KA3vvL0GjG/sOR/yy7CVCr0SPBvAEmvMjcgTlbDgNja5iMz4BETlgot5U5ckYLD8RbfVDrLQqjxaWLOchsGa0KrLmUPvePMXSmoGRCkHIvF5il+vKtRhyKHtul+n69/msnlsvTLW89VhFXP0GU7FNluerI+PFK/qG4IxbpdcCFRLO5SNDvNPKKKXalk72A/Maz88Q1bq6VpwDNWlLIJ0vUTlfXoHMhXD7KWLKFnyEtsCvWLXU+cz5ZOsqG+XLF33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiBeA5z4SHLbdw7Uqh2/sA3iCUgMP5TCtI21xy7NIXI=;
 b=CVoDzx2q1HaomHOMnwm6Ye/70bekf8Km9Igh7PIwH4H9s96JqNczNTIWMBngfbY8+7/7BZJDpKNrA0aHTGUdvzj1LyDkuks30cfsLcFz38Vs6pIA5KvUEUIvvwm4jJOi1/CMFydvFBOQ48guKBG0O1Xi+EDs2OC7gUnrUNEIxQkWOWV4jFOy5AY2SQUSMPCsEe17sq1w2qvjeEQL3D1JStPfERxZr0lu6fBxuFbhgV+F7DhpYd0ClmSAsgjKfLMmssKWbI1Mb4vOPSbe1A5UjLEJWHhAD3PpKzn+77XqD0QJFLC2eiT5ZMEybyBVlM0vr8uLdFKT9lnGQOrZaHpThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiBeA5z4SHLbdw7Uqh2/sA3iCUgMP5TCtI21xy7NIXI=;
 b=UNQgqsBfdM/Aj0nwsdHdpKLs1DyYbS247iX8FyxTsOLgEvU04g969LJaSjn+Ulfuh4V0tuBv+sGkIT7v9RnBkNLtv2lCwvfQipQV5Vx7SbEGgxJGf1p4ohaq25VN4Uwdu4c8jkgdEHq8mNZeG6vk1MWRmzF8YfOd4QTejgeUQ/U=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 09:04:08 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 09:04:08 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind"
 <Arvind.Yadav@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix use-after-unlock in eviction fence destroy
Thread-Topic: [PATCH] drm/amdgpu: fix use-after-unlock in eviction fence
 destroy
Thread-Index: AQHbxW4Jy3xudcY1WEuVpy+wEfV6ULPTZIoAgAAA3iA=
Date: Thu, 15 May 2025 09:04:08 +0000
Message-ID: <BL1PR12MB5753793E819613C63F10E1719390A@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250515074957.2830-1-Arvind.Yadav@amd.com>
 <48295677-5471-4780-9dc8-c8184c3802f5@amd.com>
In-Reply-To: <48295677-5471-4780-9dc8-c8184c3802f5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e2e48172-2fff-463c-88c9-fc5e46e3bac6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-15T09:02:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|DM6PR12MB4266:EE_
x-ms-office365-filtering-correlation-id: 4ce018d8-c0aa-4b28-0262-08dd938f73a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bFpjWFlmeGVJRHNyM0dHdWJ5amdtR0xMN2I0RFlyQjNXL3dJUWkySlpUSXlL?=
 =?utf-8?B?S1lJVXlVS1lPanJWczlRbEppaFFnYUFWbFhMSytTV0grbDhMS0ZPeVIxZW14?=
 =?utf-8?B?b2dUdUhQdzAvV3pYbml2NysrL3ZIcXZyemdPWHFSYkVpWTQyU1BabGNSS2s1?=
 =?utf-8?B?dGNJN0lJSGVvQ0tINU9ZMnF3TjNtRVZvYzV5Z2kwSjFsK2prYWZhZjYzZzIv?=
 =?utf-8?B?aXg1WUVzOUd5eFlNTkMrZ3FGSU02TVNvdXU4ZXExQThaMjcwY29oeXgxeXov?=
 =?utf-8?B?YVFEekZQWUpBNDM4VFk4Q0FVdjg0R2VPaWxDSTZSbGJLankrZERVWk1Kd0Y1?=
 =?utf-8?B?d3pQRUx3SjRaUWxoTjdUaGRuMXM5YjkwODRlTTRxM3BTOWV6T0IrY2J4NU1m?=
 =?utf-8?B?Zk5tZ25Gb3FyZlg0dytYa0U1WUpFVXptVDY1dUxDWDk1YlhvakF6R1dkR0lx?=
 =?utf-8?B?SlFRcTZjL29HWWt6SUs4bUhmV1dORkViWTMyQ1Y4aTNpT0VvMTI2MUphbXhR?=
 =?utf-8?B?QzlWRHdKcEJhZ2x0ZzlEMFdiL01xdDlvRFJWQkJmUzlZYU9lQ0lsSExMRUV1?=
 =?utf-8?B?YkFCNDJFZmdMN05OM0Z0anhJc2xoU3J3NzdKOWtkMmFZZy95TGtTeXcrUVBw?=
 =?utf-8?B?anREQ0xjWEtlNWlzUU9qcE1DU0Uya1o0NmgyT1ZTOGVHRko2Zk5NTzBmcmwx?=
 =?utf-8?B?S2kyNXQ4Q0k5MmZoQWtRWG1ubW9MMHJ2KzJsLy9neXlJTURmR3dFRE9Sa2xy?=
 =?utf-8?B?R0dybzFwR3ZOL0dZOU4xU1dNSVFoR0g2dEtuM1BLNGxZNWMzZFU0djhvenlJ?=
 =?utf-8?B?VUprZ1NmZVg5c0RUYnNtQjYyaGJzNHl5SXRTRVRHei95enZHSnhQZ3U1Y2ZV?=
 =?utf-8?B?aUh6dHJYNTJJd1dMbGF1MWxoaXBpc3FxODBYR3hzMUhpM3pjTmVBYjNJUFVv?=
 =?utf-8?B?Qm1FSXdiYUErRHhId3BPeWJRQzNHY0ZJZzBQcDl5QmFITHhBYnMyQ1d1ekNF?=
 =?utf-8?B?TzUxTEs3eWthR1JYcmJFT3drMzBaTHJTQ0lxTmw2Wm9zeDgwcUFBS0xkd3Jv?=
 =?utf-8?B?bnlpbkZwbGYybm5NT2p2UWk4dFVSMTVveUswWDZVUG54Tm9ET1EzY280WGJv?=
 =?utf-8?B?ZnNnckRtUTJWYkhQN3dRa05DOTZmdHNIWVEzaWJyV2NvenJJNXRrV0lPU3ZY?=
 =?utf-8?B?QmNNN2VteHZ6NXNwR1VGU1hjeGo0dWhXSEp1Vk1sWCtBb3dtZHdPdnhHU2RO?=
 =?utf-8?B?dDBIRFE0WE1DU0t3QkVNNkxHYnJjcklKbDhoWCt5N0tPc0d2d29XUWdobXYx?=
 =?utf-8?B?dXdUaFRKa0c2dk9VbEEyaFFBanNVL0hDc1NUQnBuR09uN3dBMmUvNTl0RDEw?=
 =?utf-8?B?OFdDaHJJZW9GVENWVm5TTkxDMzNMVnFKUU85STlTdkJhR0padjR6Y0U5YndP?=
 =?utf-8?B?bnlKNEdxTlBIaHMxakNxN01NMVY3N0JtdnBCOWFVUWJ0bHRDM1ZUcFkyM2VN?=
 =?utf-8?B?dVJmMEZsam9QWjFJWmVhRS81U050NXdieEJQbXQ5dm5tWkwzakE3MFAxMWtU?=
 =?utf-8?B?TUtac0c0cXhsb1ZEaVdoVENJL1cwdlhrRFRKMXJ1Q2NmWGpJYWxCMWVINDVS?=
 =?utf-8?B?eVVzbldNY211TzcvWUg5ZmQ3a1dzNjlhSGZZd0VFWEU0MkRVd2pRUVZkMnlK?=
 =?utf-8?B?Y25tb2dCOGV1M010NzlwRWZxVGxMaTMwcTZibjErbVQ5cC9lQnVrcE14dHVq?=
 =?utf-8?B?SW9LK1J2MEhuVWd3WUVQRHdjV0phTXZGY1RLWWRFK01YVWUvS3daWVh0Z1VD?=
 =?utf-8?B?U2tWZGlUSXNtVThISzVYbUdQVTNscXc0RlhmcWd1QlBoOGsySWlpYmJFQU02?=
 =?utf-8?B?OUNKRjE4Z0RmdUswakJKNDBoOGxxNzNrdy83RFpPRms2S0c0eXREZlhkN0tq?=
 =?utf-8?B?RDZad0RjZ3NhY3M1ZWlNTEZvQWlKTGVUVGNLdHhqU0dCYlhsNmF6c3M4NGkw?=
 =?utf-8?Q?YDcWMnripFKPLOgsi4OZbi1hhSZIvk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG9uVkdOV1FVQTNTbk1DamxLV0JwOXhaV3lCclNZcFRtdnBnQW9EOEJJUmMv?=
 =?utf-8?B?eTZsYUZHWEJjYXc0a0Z6UHF4NTN3V0kyemxYZEUyRTFLdGcwcjIwZWs5VzM0?=
 =?utf-8?B?Mzl0Z25kV1JGQitXMlNHMU11eWN2L0c5a0VoS1p3c2NJb09GU3h2VDQyOGJi?=
 =?utf-8?B?QUlxcDlxSm1TRkN6WVVHSDhJVldlL0hKZnd4V1pIOEtxbzV5TGExanNuRmxk?=
 =?utf-8?B?ME83SWFMeEZyQThPR3Y1QTlSblg0NUtoSC8vTXVoV25RSXdab0dvUHJ5WnRV?=
 =?utf-8?B?NXdkSHB5VHAwN0xCUGVEbUxhbVgvZGFFMXpYRkpNVllQTnFUUGRQNW11UWFN?=
 =?utf-8?B?ekgzb1p2cVE1S1pmUHlMczVUN3Q0R1d2bDRVQzFnTzhkRTVVb2RoY1M0TlFh?=
 =?utf-8?B?VXhLS1U4My9TZ3hzK2JUODdKMlBLUWo4Z05mV1VnTWhPMFA1MmhsS05oS2R5?=
 =?utf-8?B?ZEZaeXBwcmJsRzlaYzAyek5tZVRHbGJmTUtQNDlKOGc1TnVhWnJnenFDa24v?=
 =?utf-8?B?UVViWXB5R3ljK3djTk5FMEFPa3BuVjMxVnl2U3hLRkdraUF1MnNnbTZTSFU1?=
 =?utf-8?B?U21RUFU2TVRzMlZHeEd2QUlMbjdTbkZNcmdKTFdIWVhVRUJGakxMUVd4ZmdW?=
 =?utf-8?B?Q2xxWG5WYllGaGhkSGsxaGxHcngweVdtam0wMnBxSFlLQnJSRGF1MmY5R1JF?=
 =?utf-8?B?dW1Ua1pPRDV1WHNKZmdIUTA1RnNreFZMVktPeUVFdW5FSTExNWFXbEIwZ056?=
 =?utf-8?B?dmJhRWt5MllzK2NOVjZGNXhIejY4WVppdVpySHRGdFFlTlJqTjhVTXc5MXJv?=
 =?utf-8?B?Z3UrWm1SaFRnK2UyK3VqT3lDNGo5Skt1WTh5RWk1cnpGZUpJaS8rMG5GSFAy?=
 =?utf-8?B?S1lMcDJNVWpvaGVzWEFvZEhIK2FFZXljQkFpRkozNWFiYm9YL2hiTmZyQVI3?=
 =?utf-8?B?dWVwaFVuUnhwNk9BcU1NRUV4UzBOeDNwZ2VqSjc2MXNRZ3BRc0Y5c1JTVXpz?=
 =?utf-8?B?TDZZbWpYN3dFY3BOY0VON0tHQ29yS0VmV3AyQS9Dd0lDYitvZVQwZ04yV2xP?=
 =?utf-8?B?dnk4VEpqdGZ6OTNiaG5zNHlyOE05MFdjWjdsOW5peVk3VkN1WUVXcFJEU096?=
 =?utf-8?B?ZExUUkJTbmJQM2FDWjhUcDVVOENTZ2VwN1VKc2Q1anZ1ZE1WeWhpVzFRY0RC?=
 =?utf-8?B?akhteFBsVi9kcFFzQndpS2ZCWCt6c0FxRjhtKzJhQlZWZ0pwOWR4bWtXdk9v?=
 =?utf-8?B?M2FhelMzcHVHV0Y0YUlvVEpoZGlLTjVKS2F0U3lKWTI0cXZmTGlDa0JwSDdw?=
 =?utf-8?B?SUtRNzVNOVFqK3FWNGVKOTlJdFdFQmZySnFWK2JNdy9zNDNTZ2YrbEZpeHlS?=
 =?utf-8?B?U1h5NkRaelFheXFmTHlCN01rNzNyVnk2bkZGWVhRblJmSnZTeEVUUnNrZ00y?=
 =?utf-8?B?Y2tjZzFyODhTYmNmZ0hiMjlJOHFKVjg1NDdQSzR2RHNVWkNnMWZ1a2NnQit5?=
 =?utf-8?B?VnZINzNUSyt4bmJPNU0rVml2U0NvWGlkS2RNMGR2SURzS0tpUW05YXkrY3lo?=
 =?utf-8?B?ZzN0dW5QMVk3cnRiNkN5MUhhZmNDcEFER2tLWTltNjMxcDRCaUZ5bStvakIr?=
 =?utf-8?B?VldNQU4vanFuUXp2ZlZGdDBUYTcxajMzVURuQm5OenlKcVM0a0F3TER3UUt0?=
 =?utf-8?B?V3J2ZnkvQ2h6eXJCU3REY21uT0ptUW9vM0hmUmIzbzFTZHBxVDBPbFpRVzdy?=
 =?utf-8?B?V1RKM0F2eVBLYm1TVXJGMG9pbHpDV05iVzlmMmh5RWZPQ3VDN20wZVZVOVR2?=
 =?utf-8?B?czc5ZmcxY0RCVCtkdTEyVmw3c2lZeU9lN0ZSS1drdi81Rm91Z1VDcGZsMWRL?=
 =?utf-8?B?WmVwQ09OUGg2Z04zUzltcjgvOXAxM3FVL1A5MnExNUFucWRMYy9Oa1pSTWxR?=
 =?utf-8?B?ODMvN2dXRS96alg1TndCbGlOZWdIdXdWMG1paU1xaXB2YkQvdHZ4NTAyblVD?=
 =?utf-8?B?d2hnaEVBK2U2TmJ1clJUelcycHdSYy9BZldWWThCcmxzOVNTSGdZRXlDV0xn?=
 =?utf-8?B?OUFFeFdWamtvYXMyRitZNHM4SE42b0dmZnhSM25ZdW5hbU9mbGo3M1VpMlRs?=
 =?utf-8?Q?PF4M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce018d8-c0aa-4b28-0262-08dd938f73a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 09:04:08.6397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGRRpIw5p+QkOwrFhHZfFrDlGDHr2kCKLNcZUIDeWANo17+5GW/EHTJ3C6gye7/xhQL5S3aV2f341Xe2knAugQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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
Cg0KUmV2aWV3ZWQtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPg0KU2VudDogVGh1cnNkYXksIE1heSAxNSwgMjAyNSAyOjMwIFBN
DQpUbzogWWFkYXYsIEFydmluZCA8QXJ2aW5kLllhZGF2QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLaGF0cmksIFN1bmlsIDxTdW5pbC5L
aGF0cmlAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IHVzZS1hZnRlci11bmxvY2sgaW4gZXZpY3Rp
b24gZmVuY2UgZGVzdHJveQ0KDQpPbiA1LzE1LzI1IDA5OjQ5LCBBcnZpbmQgWWFkYXYgd3JvdGU6
DQo+IFRoZSBldmljdGlvbiBmZW5jZSBkZXN0cm95IHBhdGggaW5jb3JyZWN0bHkgY2FsbHMgZG1h
X2ZlbmNlX3B1dCgpIG9uDQo+IGV2Zl9tZ3ItPmV2X2ZlbmNlIGFmdGVyIHJlbGVhc2luZyB0aGUg
ZXZfZmVuY2VfbG9jay4gVGhpcyBpbnRyb2R1Y2VzIGENCj4gcG90ZW50aWFsIHVzZS1hZnRlci11
bmxvY2sgb3IgcmFjZSBiZWNhdXNlIGFub3RoZXIgdGhyZWFkIGNvbmN1cnJlbnRseQ0KPiBtb2Rp
ZmllcyBldmZfbWdyLT5ldl9mZW5jZS4NCj4NCj4gRml4IHRoaXMgYnkgZ3JhYmJpbmcgYSBsb2Nh
bCByZWZlcmVuY2UgdG8gZXZmX21nci0+ZXZfZmVuY2UgdW5kZXIgdGhlDQo+IGxvY2sgYW5kIHVz
aW5nIHRoYXQgZm9yIGRtYV9mZW5jZV9wdXQoKSBhZnRlciB3YWl0aW5nLg0KPg0KPiBDYzogU3Vu
aWwgS2hhdHJpIDxzdW5pbC5raGF0cmlAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQXJ2aW5kIFlhZGF2IDxBcnZpbmQu
WWFkYXZAYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+IGluZGV4IDFhNzQ2OTU0M2Ri
NS4uNzNiNjI5YjVmNTZmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiBAQCAtMTgzLDcgKzE4Myw3IEBAIHZvaWQg
YW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX2Rlc3Ryb3koc3RydWN0IGFtZGdwdV9ldmljdGlvbl9mZW5j
ZV9tZ3IgKmV2Zl9tZ3IpDQo+ICAgICAgIGRtYV9mZW5jZV93YWl0KCZldl9mZW5jZS0+YmFzZSwg
ZmFsc2UpOw0KPg0KPiAgICAgICAvKiBMYXN0IHVucmVmIG9mIGV2X2ZlbmNlICovDQo+IC0gICAg
IGRtYV9mZW5jZV9wdXQoJmV2Zl9tZ3ItPmV2X2ZlbmNlLT5iYXNlKTsNCj4gKyAgICAgZG1hX2Zl
bmNlX3B1dCgmZXZfZmVuY2UtPmJhc2UpOw0KPiAgfQ0KPg0KPiAgaW50IGFtZGdwdV9ldmljdGlv
bl9mZW5jZV9hdHRhY2goc3RydWN0IGFtZGdwdV9ldmljdGlvbl9mZW5jZV9tZ3INCj4gKmV2Zl9t
Z3IsDQoNCg==
