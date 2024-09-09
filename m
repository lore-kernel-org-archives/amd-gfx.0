Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4249DECE577
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 18:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E160C10E5CC;
	Mon,  9 Sep 2024 18:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fB6UgsNc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6307D10E5CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 18:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Edzcuqmh1lvn/qUmZHmMrS7K4KT+pZT02s7NTvGGig5uiTumguT+NGfRAEs37iJMVwvxxjeA3P2zfV29qYsXKvpAVhy4Mj2uv86NEa/XHYuExse2ZeVQXfqIXBokkwXEXd64rtUiTtAAZ3cX2kT4vWek63z77AQr6G1PoLuBDYtAIqnZuZyJM/ugWMUcPkhjBuXCKX+GxawDAhBZZB6skJmuTOR27PqmQU14DumNDFsQSDeA8rUkm9fSStwaGjjChBzAT+5cQv4XCUmig5scn3WxSi4Tp5RkRhYxRh4x2LgnlSJJUVgwluXjfdcIVmKRIfp9F70xb8Kk7IejlY60Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygyDON5ECsSP/vRwoBoo6otERBLVzQlNr7ZqwzxiSdc=;
 b=g3Ud08BZBi/313IJ9VxXQzvQZch6IvITNIR2HTGEZoDRWa/38FPPO38XAmXKDdwXA4vMQrrJSLp5RYmdiGuS1uXbbjBZ/RzUaJd3Cj2jjTS9/Qzg9o/7or4UEoyc5eh+xEo9oM6gY08dyW8PftTlZLNMzq1u0ilMH7I56ysaJq0lLub0bysZyLsYrFed5i2zQhJxDk9rXi4Nr/XvgbubcMQJ6l8QXX4nfdbj6pSFvZfAC7yDXZHBnKCNpTR66b08deQZCCkhED0HAl2T/m9fDxun4y6DaHRa5YBU+1NH8/3uwUwPgDFeQ5/NravF07IpQYYpgsZQ1jVKu3TRcQTPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygyDON5ECsSP/vRwoBoo6otERBLVzQlNr7ZqwzxiSdc=;
 b=fB6UgsNcT9maJARMX4WbppcoxJQGXYfaFt6t9uJTVFQ60NZUqavXSQwphOaquozhAdPREGj2l3DG79kNWThrYgGs0lGXCWQha8LRIabxwuxWiYJaXLiTf8zB0YcH1HJzk7KtbRdbA0dtHvf01L22l6/gwJqF5GHthIvG5tx0KZM=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Mon, 9 Sep
 2024 18:42:05 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%3]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 18:42:05 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix resource leak in riu rsetore queue
Thread-Topic: [PATCH] drm/amdkfd: Fix resource leak in riu rsetore queue
Thread-Index: AQHbAlaK842cWWnWeECPeuC/URZuqrJPvj0AgAAM0QA=
Date: Mon, 9 Sep 2024 18:42:04 +0000
Message-ID: <BL1PR12MB5898E2B3818D122B5E5F11B285992@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240909012041.1433796-1-jesse.zhang@amd.com>
 <CADnq5_N3dU7rrX+R6Fm-iqSU9hG0y_KbhK6P-5Qjh=qABnYCGw@mail.gmail.com>
In-Reply-To: <CADnq5_N3dU7rrX+R6Fm-iqSU9hG0y_KbhK6P-5Qjh=qABnYCGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fb18916f-f4ba-43fd-9a0f-87b24236855d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-09T18:41:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|MW3PR12MB4411:EE_
x-ms-office365-filtering-correlation-id: 38cc9b6c-2517-4fca-78bf-08dcd0ff19ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mk9WcGZRTjh1d2hoSGFjbExZSDc4VFcwNHljWXl2UGFua0RtbE53N2NVUFo0?=
 =?utf-8?B?YWQ1dllndWpZU0hmUytDTTJITFA1dU5WQVhqUE1zbGVzTkJaMjdEM08rTzNy?=
 =?utf-8?B?TVRvcXIxSmhZSnRkb1B2aFcyc1V4ZTlSbUZzYW5tenJTQmhMYnhvMFUwWk9i?=
 =?utf-8?B?elh1dlZ6LzBLdGFXaFh2MUcyeVpUMlBuSTJqdkgzaHd0UXVHSDZ5OVZHOUh4?=
 =?utf-8?B?OFc3TkJNckVwOW54cVJrMEw3L2FtelhNaHhleG9aNFowVFhjZ25lTWxpSnN5?=
 =?utf-8?B?VWVKK3dNbWg0ZHB0QVRSR25EdVRaUnlmcEZYa2J2T3VuOTlqcEQ1UkpDeGxV?=
 =?utf-8?B?UWViSlRvYUlSQjRrZEk0eGN3MlhBcjJ2U0RvUUpQR1ZONG01Sy9GczN6Y3ZX?=
 =?utf-8?B?Y0tHNEF3UEJqNE95Umh1aTJmbW1iRFc2UDFxWWlOckoxWVhvTmJlVm5udVpJ?=
 =?utf-8?B?aHU3b1JpNHFRYi8wLzBjM1QxWHl5YmFQa2xKMXVOazh5Ry9RWEhiQWdGU0ln?=
 =?utf-8?B?b1lpN3RHTEdseGUxSW1GVWsvdmd1WDEyRFMrSEdXMnhyZHNyamd3YmlPcDJj?=
 =?utf-8?B?UFR6NHNyVk14L2VRSUx0bXZtWE5TdStVSUFielRNczUzMUJPVEVNa1VVZGNs?=
 =?utf-8?B?QUx5andhdWJzQjR3WXkycy9mdm5YeklXbTAwRWw3R0FwQTVoQW5PcW15aDNS?=
 =?utf-8?B?V2JGcW0zV3M4ZTVYV2JGRm1OZCszYk5NQWhZVmRtbEVxSklMU3BUaWhvN1BP?=
 =?utf-8?B?WDNtWW5UZGJjeUNjVGJqeGpYY2xDbDQxTllsR01kcENRc1VJMjFRMXdIUnpS?=
 =?utf-8?B?NW11aUhqeFBtRjkrODBCTzJwS3Ywd3U5dGZGeGdGbjhCT1FZaUdPaEYrUmpx?=
 =?utf-8?B?VzFUV2JlbHYwUS9OcGdGMFhoMEVUWW42SzhXdGozSGVwcGhMbHovN0FtRjkx?=
 =?utf-8?B?T3FRS21QUENxQ1VlY0lSNmZqMkdSY2lHaUoyeXNZbWlSaDRVcTlvVDQ1Nkh1?=
 =?utf-8?B?ZjFNSkJlYm1JZ25FV3cyenJJSlc2WlR6QXhIWW41UG5NKzlIYlN4Y0tWS3l6?=
 =?utf-8?B?bFRKOHFUOW1hWDRiUjVMMGFFWVl2TXJoSEZNWURwVXRoU1hRLzZDMEc2d25h?=
 =?utf-8?B?M090TEtFMTdJcWJVeDNMbTZjTVVZNlVHZmx0SWUvT0VTMHNlWEV5Rm5CUGdy?=
 =?utf-8?B?aUV3UytCZENXTmJFNERkSFRQdTFNRUJFN0hvOURqcUdHcGp4cGZWOWpaTjNP?=
 =?utf-8?B?K2FnV0ZSRnBieDBSRThldXJTbnNGMlFKVWRrQkNFOWoyNUFyQk9HWEFGRlJI?=
 =?utf-8?B?SC9SS0VXc1BqRFVtc2EwRDFwTEN0UU54c1ZjKzFFWHk3bkdUNHRkWmY1d1kr?=
 =?utf-8?B?MldpY1dlR3did1NuY0xNRGhLQVpMVUNiamIvdERoRS9uQ1U0Y2Q1T3FHSWh2?=
 =?utf-8?B?ZS9yYko1TFdGQWVpM0doOG9ObVpMVnFpMkFxK1hySFM2Qmw5aXVHSTdXVG5z?=
 =?utf-8?B?Zzg3b0NrMmNxRTBIcWNlMGs1dmRFcVdoMHNKVlBLSjFrM0JBT2RzK3hlN25u?=
 =?utf-8?B?azZveHNJdzZXUEovclFxVGI0TTJlWEpWa0h6aEZjMWR1MGhCcWM5cFdTdGNt?=
 =?utf-8?B?SkpsdUFGcmFrSEZ4WDYxOWN5UjRTcTcyeEpDQ2ZwT3RjWDhXY1NPaXgrUmpr?=
 =?utf-8?B?WW5JdzEzZG9GVDBnekVZSjUvVk85TEtvUEQ4cWZQazRaWUpGMmo5NW5nSHo0?=
 =?utf-8?B?eU82QnM0Z2E5QVRKbzNMQ1RhdzBqSHlYdHhmaE12K3JXelRxRzhBV1hXZ3Vw?=
 =?utf-8?B?K3REOStMVlNUK0p6MCtFYlRtRXYzZVB2eWtjdzlVUFlDMTM0Sy8rK1JlS2Fj?=
 =?utf-8?B?R282VkFTYk5JbGVrRUFyL0FEUlUvVnFOVmRnbmxIa2hEM0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXFIVmFvZWRFMDJxb2dpRElHM3VrUHRXTmxVRDBqbkg4blpuaTBjZGpmVHRT?=
 =?utf-8?B?VVByUmJmbW1qd2NmWENIRzBZSS9VSE92aGZPY0ZqYkNBa0pHNGdFaDVjNmtF?=
 =?utf-8?B?OW9pMml1eGcyQ3FkazJsYjBtTzd6U0U4Z0F3dUdqaVgwa0YwUVMyRHN2V0ho?=
 =?utf-8?B?ZUFab1NtZkxzMWs1aG1DdFFya0h3YUd4ZjNxTW5zUWRXdTd5aW9JNDVNK1Az?=
 =?utf-8?B?MlFra2c4aEl0V0ttOWtpVm5zaXJNZnBLT25SZFNWMFZmMlBnSGsxcFhpUUds?=
 =?utf-8?B?MkV0blIwMFFCMmYyb0xKQ1ZuTGc2RlRRSkx4VEo5ejFteEdKQUpydlpvaitX?=
 =?utf-8?B?b0thWWxFR0ZWeklDR200dzRKVDE5bWRCejFKaWU5cnZUV1UxRjBxTnZBNVI0?=
 =?utf-8?B?clNGdWZpZWczNkpycy9SUWJNNEdzRThTbjZlVXA5ejVDQnh4bmNhZHNXTFNK?=
 =?utf-8?B?elpWVE9GcWg1dTlsV3FhVmxwZkV3TUJxNEhvdzZkdWV4L05nN3NtNlF0TXgz?=
 =?utf-8?B?TCtweGxKa2JnY3JOYStuOTVMeUNsa2ZYTnRTSjJkYU45ODVTb2tpYWlHLzBo?=
 =?utf-8?B?SVY0OE5CN0hFZCtkREthT1MrV1ZKbXdnY3FxTjJXWnFTK01lbkJ4ZzhFa044?=
 =?utf-8?B?Z1VFdm1SQ0pKZ01BUll3cEYwakFMaGtGTlg2MTNMUkFzeWh6aEJyNkVVMjdo?=
 =?utf-8?B?YWFmZkIrSS9mNmhKam9oc01sZVFkSldLcExJOEErbkcwNlF1ZTROUjBxeVRP?=
 =?utf-8?B?NmZIekZiRVd5eVlabFpQdnNCRSttc01DQXhOZEdoSkNIZmtwaXBWQnFIa0VN?=
 =?utf-8?B?YzQ5bFdScXZZOGlQUVVlTU5PV3dwajcvamFydUdUOTVRQUlZYi9nQ1FjRG1J?=
 =?utf-8?B?ZmI2Mi9QdU9HTW5LVG5OTmhXdnVnOWd2SkdMNm91MUVtRVhmcS9lTFpPT2hM?=
 =?utf-8?B?UVVTTEh1REFLYlBjRTVYcTlXZ3QrUFVKUTJQWUQrUml1K296Tk1aelJPajJ5?=
 =?utf-8?B?Q0w4TTdxUWhmcG5xYXVLNG9sVGhmLzNJWGU3Z2ljMWxqRkttUjV3Z3kwcGha?=
 =?utf-8?B?UmVpanorNHh3aUIwVk1Td2xRc3R5cmE1blljbVRoL2FFbnZ5TUUyYlVBUGY0?=
 =?utf-8?B?QmRLdDF2MFBzajhsajJkY2p6VWg2MDlpQmYxSi9GVlNpWENjRzFSNWpVQXRI?=
 =?utf-8?B?NHBlNHVqN0J0NllLQkVHR0hZU2I4STVSb1BGaTlOR2VGSVd5ckZzWTUrTnVa?=
 =?utf-8?B?UWVzYThKaGxmREdSMGMzK0tjSFJHUkY4dnpubHFNU2V2OXdWNWRrNkRabXUy?=
 =?utf-8?B?RUNsNU44dXQ1Z1pZOTB1N3FsMVI1UmhlZWpXblR4Nk9PZEdTZXdLWGVDTXpT?=
 =?utf-8?B?MG1oYndqYUNRMFFqcnZiUFJPTUVXOUFvQjV0QVdXK3IzdjltTXo4SGExT3FQ?=
 =?utf-8?B?OXpoREFlZlpOY0lETFZPU3RoUVM2WkEyay96N2ttY0xPZlk2YXBIbUdJZ2F0?=
 =?utf-8?B?Uk9DOFRUYmF5WVJ6cXFxdHhld0QzcThucTlBczcwU2lEcTZHZ0U2dXA3YTNC?=
 =?utf-8?B?MnQrY1NkNHVTbGt1MmVZWVB1S21WazBvY0RYRXlUeGNxRjJIZ3N3aFgvQ0xs?=
 =?utf-8?B?SnA2RmtGZGlPUURFUVJoQ2hjQjdHNnhjYUJEL1JzQVJCRUNEdzBiR29nTnVt?=
 =?utf-8?B?bCs5b2E3LzNER2k2cmRBNGlVSFZiNjFYSWJpaXkrdlVhKy9QcjF0MnJjcmE5?=
 =?utf-8?B?Wm1XQnZnQk1kaTFuVi9QdnRlMllWR28ybm9nYkxxM3pmVk1UYnoweFdERE1W?=
 =?utf-8?B?NzhpNE1EQmM5ZWpTbHN6eFc1SC9rbEtpSldSbXQxVHkxSU1ZZlN5L0FBY1g2?=
 =?utf-8?B?Q3EzRzA2eUt3NnVQNk13RzJ2UndtTEhMdjlMWEF1NjhjVC9JTzJvTnVraEdq?=
 =?utf-8?B?WEFrMk5ZQ3pnTjdiWlVSNjZYT0prRXAyaXZ2QUowejRGRE5SbXdJUGh5ZTQ2?=
 =?utf-8?B?R0hubWVuM0lQM0lVVXBzaEFTT1VuZWc2WURiUHFhWFM2RGFNSGJYL2RUdlRs?=
 =?utf-8?B?d1VnMVN6Y3dmLzZCVEhBNWxwc2pGNWVSM1o0bFRUcVFBQVNqSlJVbDZOSytn?=
 =?utf-8?Q?p6ZU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cc9b6c-2517-4fca-78bf-08dcd0ff19ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 18:42:04.9700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80al6IazU4b/cxkHTvla075Crf3fx3rD+XpUFPcTuK6D944aongd9dXm13bGBpNB2Ff9apCz3y/dyyOZVFOH0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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
Cg0KU2hvdWxkIGFsc28gcHJvYmFibHkgZml4DQoNCnJzZXRvcmUgLT4gcmVzdG9yZQ0KDQphcyB3
ZWxsDQoNCiBLZW50DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IEFsZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciA5LCAyMDI0IDE6NTYg
UE0NCj4gVG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiBDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+OyBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1kLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogRml4IHJlc291cmNlIGxlYWsgaW4gcml1IHJzZXRv
cmUgcXVldWUNCj4NCj4gT24gU3VuLCBTZXAgOCwgMjAyNCBhdCA5OjIw4oCvUE0gSmVzc2Uuemhh
bmdAYW1kLmNvbSA8amVzc2UuemhhbmdAYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBUbyBh
dm9pZCBtZW1vcnkgbGVha3MsIHJlbGVhc2UgcV9leHRyYV9kYXRhIHdoZW4gZXhpdGluZyB0aGUg
cmVzdG9yZSBxdWV1ZS4NCj4gPiB2MjogQ29ycmVjdCB0aGUgcHJvdG8gKEFsZXgpDQo+DQo+IHNo
b3VsZCBiZSBjcml1LCBub3Qgcml1Lg0KPg0KPiBBbGV4DQo+DQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKZXNzZSBaaGFuZyA8amVzc2UuemhhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jIHwgMSAr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIu
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFn
ZXIuYw0KPiA+IGluZGV4IDIwZWE3NDU3MjllZS4uYjQzOWQ0ZDBiZDg0IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVl
X21hbmFnZXIuYw0KPiA+IEBAIC0xMDQ2LDYgKzEwNDYsNyBAQCBpbnQga2ZkX2NyaXVfcmVzdG9y
ZV9xdWV1ZShzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsDQo+ID4gICAgICAgICAgICAgICAgIHByX2Rl
YnVnKCJRdWV1ZSBpZCAlZCB3YXMgcmVzdG9yZWQgc3VjY2Vzc2Z1bGx5XG4iLCBxdWV1ZV9pZCk7
DQo+ID4NCj4gPiAgICAgICAgIGtmcmVlKHFfZGF0YSk7DQo+ID4gKyAgICAgICBrZnJlZShxX2V4
dHJhX2RhdGEpOw0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gLS0N
Cj4gPiAyLjI1LjENCj4gPg0K
