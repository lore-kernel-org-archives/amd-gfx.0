Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57065CD042D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 01:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED83B10E44B;
	Tue,  6 Jan 2026 01:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HKLUxEj0";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA8C10E44B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 01:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnMHAiwNaMHWyX6aQhQ5lqaRuwYjJi/tHY1ExCRvBNg/C4/hiymA3g4xLqLXIxtDzcYOaDt2UaeQcchCKtQBHxw2ca9d7zzmv/lp4ZUK6RbqK+gxVPunsy9QxjpqNWwUwcCRUKT/Dv1zIWSINL5QAsl4vCdF9YxwFs5KqWdwDP1xU5chOPHlwt8fSyUroi5Ya3hMHk2A0CXwGJhID9ABzZvd3AI/D9PmJb8NGkOU2BB8TyMLuxcny6Vib5aOG77D91Ii8xlOv5jdSDHFcGlxT3CtSTFfGDw2WDx7xJVOJCMMP/aS45ANKUzimwvGmxjcqC3GK6R6/ZNRGI3dbKJYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqKR1yCvKH4kD6lMzcfffG4VjFQOaKyYhvoUjSF74/k=;
 b=FCv7P4VsMgsOupqaQqrvngkW4Jki3WGjDiuWrHCI5la8Urcd9WtTsG+/y9iDaHk+zXPNCnRlbmsscmvce5Ip5GhBASWZdVEiNhsjgYrNK9iXyD1a+Gdax3LTvb0jSZ7mxcFquQtEGKwJ9v/rST8qqgr1YqI0TY84FwzO2fPJOVTnuYaAH2ri4rbQQgIyq34d6xTT4uZZ+m3ejEZrTtHd2pg2WoGaLxtzRplR/Zq2zTQWAoN/kd777qrmjfzwMg38dYFpZ8PZM3QBzJiHT0qqqvc9sA0vGtLUAfcToEmILb0iTARA35csrSZ3zwSKpWCKPtYUd64LUuMMs7KEHFrfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqKR1yCvKH4kD6lMzcfffG4VjFQOaKyYhvoUjSF74/k=;
 b=HKLUxEj0W7hTFx1Tv2YYZNwle6tiC+hXh++NioWKuDMQQRbg2SLC1dTQsZNJyR2gLMnjIdYVTR08igTHQOBrObn+z7YpC9iFBpYBMlKPLP8fBjXeTmbFX1pGoVvvNpp2GtMM5w4NW7vHnw0ezP/L+Or96YXmpONmArrkLbO3unA=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 01:58:46 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%6]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 01:58:45 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Ma, Le" <Le.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Extend psp_skip_tmr for bare-metal and sriov
Thread-Topic: [PATCH] drm/amdgpu: Extend psp_skip_tmr for bare-metal and sriov
Thread-Index: AQHcfYt4k+ELY2jWvkKeczGjj6LrFbVEZCYw
Date: Tue, 6 Jan 2026 01:58:44 +0000
Message-ID: <DM4PR12MB518188DB310A940E39593ED2EF87A@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20260104150428.26348-1-Hawking.Zhang@amd.com>
In-Reply-To: <20260104150428.26348-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-06T01:56:06.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|MN6PR12MB8469:EE_
x-ms-office365-filtering-correlation-id: c2e95bdd-da93-4835-6a53-08de4cc71ff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?V2luNFlyTjRFSlByWHczanZJWjNGSzhBaDlTbVFEeEo0MUcrZkYvaWxKVGpM?=
 =?utf-8?B?T08zMzNBTytDMGMxRHFteGZFbzRSclBQeUIwL1p6bnlydmdpOVFaajkwUjVh?=
 =?utf-8?B?S0NzenFwcW9YSmMvV2xxUTRMM3JOcHhBa2R5RUVPNlN5NXBGb2cwZUVGaHps?=
 =?utf-8?B?Q0dJeEdBU1dEWmtKKzFySEQwdDhjWUJmM3dRVWk0SCtBaXgwRlByR2tHVHZa?=
 =?utf-8?B?RS9KOCtZL09VWGhudGZydlQ0VnRWeE5PK3pqeVFydUJRSElKZ29NZVljL1p0?=
 =?utf-8?B?VnY2TnNuN2c5eElCQXFGMDlvbTlwSVRURG9COUJnUW81ckluZ0hhR2JmN0JZ?=
 =?utf-8?B?YjVySU52WjJVdXpOZy8xS3JQc1UyaHIxeXBNTGRuN05EUlRSb0djOGhPWHFL?=
 =?utf-8?B?YUYybjJuQnk2N3ZpQVRZQkxlZXJ0UEwxUHdod3k4eDVvblJtbVc3bW1mUDcy?=
 =?utf-8?B?aVdqSXNWVEJsd2Vja3ZVbi9KWFphdFU0V0swS3pYVVFBNGUwWU9sYllLend0?=
 =?utf-8?B?ZzRTTFVjRTVzTjZwUTBTZkZmZmU3Tnl6WVdzS2lIcTU5OWtPSVBFZDFzaWll?=
 =?utf-8?B?OGtwczZIZUV6d01qTkw0bWpEZ3BaQlRFTUZwQmFHZFM4V2x4dHZyY0x1Qk42?=
 =?utf-8?B?TytQYW40RTllS2o5OTl5R0U3R011eUFhOUVnVVZuVEgySTExRjN1aGU0VzQr?=
 =?utf-8?B?WFowa09QL0RDUGgwVHdGOGJZUitud05hV2FYazZFRmNlNjl5QzI4bCtaSFJC?=
 =?utf-8?B?K0RpdDI3RFRvZVZ1QjYwNHQ5TXZ6WC81WE9kZ2htWHBtRm5EK3NQTmpZNjdU?=
 =?utf-8?B?QXlLVnhOaUdpcU9NRUxSU05FY1orL2pDVWN0VFBDbFZQalpDTDIvdWtRai9E?=
 =?utf-8?B?N0VjKzdBK1ZsRG9sREkxaml6dkFCeWFtc05uUGtSUmp6aTM3UGszU1YxWHl4?=
 =?utf-8?B?ajZ4dGpQY2k3VE9KNFJZU3ZuTHZEMnQvcnZjcGd2SWxaRjVTTjRQR0FzL1A5?=
 =?utf-8?B?Q0loR21TdGtnQ0dmVnNrVVNuZmFCbk1sYWd2OFlWcGNlTHlwRklrYy9Zd1Vs?=
 =?utf-8?B?YU1WZ1R2SDYxNy8wTlZteVBKNzllQ2ZNYXRNRnlPbUFZMUdZZEZaZ0p0eVp5?=
 =?utf-8?B?eVZuRldoODE5SWtldW1FWlFLNXRqaWJKTUJIRmNwTXhocGJ6NDk1cEh1ckw4?=
 =?utf-8?B?dnZ5SlBncDJMd0sxNW41UmEyaHk2cm9EVENHWlhxSHJiR254eHBZRGh2NzVL?=
 =?utf-8?B?NDRRTjdBUFFwQlA4V3I2Vjh1ZG9JTy9EOTBEVEpsY3lCUGlNQjZ6U29lcjU2?=
 =?utf-8?B?NDVuVUp1RjhwMkdSY3hxS3VERjltT2lxNGJlSXViU2ZnZklSdERXd0JrakZV?=
 =?utf-8?B?Zk5qSTBHRGJ5UXg1ZDZJSm8vWFlTOGJXdE1PUXVDcFNBLzUwWlRreTJwQThE?=
 =?utf-8?B?QTlkUFNEV2Y4VG9oT2t0QTlYU0VMZmdONWlSRlNzWmJjY0ZycVF6WGVMSWlB?=
 =?utf-8?B?c1VvMzVrMS9va3cxTEpiWktxbk5EY3hlOFQrR2FFcUpYdGNSeHhiMlliSG1V?=
 =?utf-8?B?cVltU0hyNEdGbTgwZWo5UnYyMkltM201S01UazU0cFRIYkxzWTlIR0NYN3RB?=
 =?utf-8?B?TUFuYm4wOFJxd01Cbm54ak85RFZ1eXBTcTZ4cWl4WG9RV0dFUmFPUWxHK0FJ?=
 =?utf-8?B?S1lXaXdvcFVtTUc4RTFJdlM0alpNdVFHMXZiN3RSRVBIdDlscWFNMlFpY0pp?=
 =?utf-8?B?NTV4ODg3REVrVEJxaEFWbGh3V3NnL2h3MFpHVUY0bnk5ZWNJY2QxdXdwRk44?=
 =?utf-8?B?Zk96WUd1R0lOTlArRDd5NWhCT0hSeDBzOEhxQ2E4RFhqd0NES282RTRPQy9i?=
 =?utf-8?B?UkNjMzVMM2hPa0w1VUo1WndzeU1TNnVRejJXaWExcXIrWllxcnJHWVR6a3RZ?=
 =?utf-8?B?OTlxcE9TdnFSVmV0VDJ6VThYUTJiOHBja3c3WUxuUnFUSGtweitqMW02ZUtY?=
 =?utf-8?B?eFlhNjQzakpGUDl4RkZ2U1NMaXk4bFpid09yc0pUOTdGWkNtVkpPNVlFZFZw?=
 =?utf-8?Q?Rjpvhe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1NPYTkzb2NhZDJ6ZnRoZkhUTmV2OHZOa3NmYUUrWXpHakhUZXZxTHJ3Mkdv?=
 =?utf-8?B?cllmMGdVbnloMEtTYy9zWk5qZk9ZWUNVRVFYbUUydUVMdnlEYXJyS3Zud1hs?=
 =?utf-8?B?VFZLM3ZMTWNsWEtLbGtkdjJwWCtxdkVYQWtkWHZXZGRXcUxjaHRqdzMvN2FK?=
 =?utf-8?B?V1lqbmlweXFuY3RpdEZLTHdHcXZMOFJ1VitSQ3BJRlluZ1d4ck5TcnVDSjJI?=
 =?utf-8?B?R3pYZ3RKVjNlZ0NVR3REWThKVU9pVUkyeXg2QllkdXlHS0NUdGlWR2FMQlZD?=
 =?utf-8?B?UjJiRmt5R0pYS2pqYlFFcFZPU0g2eFVzdVYyNG4zNEtaV05SRHk3MWRmRzFo?=
 =?utf-8?B?ZCtPYTY5d09ZZzBtT1hhSURoSk91MFk3QVg5c1ZTcXBjZnhYTWRCT0ROeEhw?=
 =?utf-8?B?MnNROEhyeDlLQVgwZ20zRnBzN0Z4bWZGWE5YWkowaytyNHdwM2xzUzFmVXFU?=
 =?utf-8?B?dW9jczcyR0hLeUxaM3k4LysvM3FGbnc2emRobEpMSEo4Vk1KZEh6R2JxaGt4?=
 =?utf-8?B?TjZ3VCtJUW1zd29DMDFHYlVlRy91OC9hSVEyNVA3aHVpN0k5OGlNV2xxQVhV?=
 =?utf-8?B?NTUwV1BjSGlNMHY3Z1RWRWJuZ2dlN2UrbkVqTkZpVFVTQjJROWszcmhHY0VS?=
 =?utf-8?B?QWJtc29YVldVM2RaUHFaNStneUV6dTVGZk5jVWpjM21Ba05MNWk4RmlXbTlu?=
 =?utf-8?B?ZUthbkt2NXhlampOZXRaUG5UY0JpeElwdzhBMGtyUkFGUVRUZk03Vi90SEx1?=
 =?utf-8?B?bExxSkd3VEtlSTEzRy9OY2ZpMEZobSs3OTNzUHBaeEJ2N3lBZWRyTWlDUGcv?=
 =?utf-8?B?UUtsTzBUc3RXSDIvbjBxVW4yUnlHMlkzb0xmUk5QUWMwc05XSEFjNm8rYnEw?=
 =?utf-8?B?cVR6NVBiM0F3RXMrRUx6MEVwR3kveUZKNDFYOTgvcDc3cjF3cTcwSXhxTll2?=
 =?utf-8?B?Sm9LQ1gvSWRZNm1aRXp1TWRIa1AxcGlXZ2pFTzhNTWJad0lWbnBtRWJrOFNs?=
 =?utf-8?B?Y3I1dWE2ZGZzZFN6VGdvTnRTa2JVUVA0Z21qRVhLTEpQNGdialdUSHJzRGJQ?=
 =?utf-8?B?WkpWSGFTQUlDbWtqdHFlU0JyNTZqa1hkMXkrSkVBdVhmQzlPNEdBd25Tc3A5?=
 =?utf-8?B?K1R1OGEwd2xFU3JVU24zc0JML2pWYkJ6WWNlMEU3K3VmdDBqd25HU2VGSnB0?=
 =?utf-8?B?cjZQTTNUemJJaVRkQlkrek9HTURyUTNEbkRPU0gxelZkTUpQbE1zclVNdUZm?=
 =?utf-8?B?cXY3MTJBQnhXRmpsQUEzQ3V3VTFpWGZEbjBTendqbFhOSWRSSnU4c3BxN1Vw?=
 =?utf-8?B?ME9SMG1hY29GalZaemRlWmhCSkx3WHZMTDRpSkpoVkhid3QvY2hGem1ZaGRZ?=
 =?utf-8?B?b3IrRG1oQmRHcE15WERvdzFZbm0vd08wMklDcE4zSXZwY2JJZzliSU5yaVMr?=
 =?utf-8?B?RlRCOHZqYVJLZVhSS0pwNTVwRW9BUGtrWnNoQUsrdTViUWorM2dVN3UxZk5q?=
 =?utf-8?B?VmRIMUVSbmRMOEZ5Tm1iaUY0bFFNdDNuMFg3eFNLZ0thbHg3RHNMQ1Nmck9q?=
 =?utf-8?B?WGNDbFBxNmRHQlZiWEZWY3dRRUZFM0JlT1o0UFkxeFlncGtUbW5XemlqblNh?=
 =?utf-8?B?MEpjb3YwcEVDU3doSE52QlVxMVpUODRzS29XMXZMNjg1VUhkdTdTWkcrdGhy?=
 =?utf-8?B?MVFGd1BkOUtHaEttUzlBOHFKYk45WDlMakszREY2WlloRG8rVU9HdUk5eE5R?=
 =?utf-8?B?V0t4bTd1ZDlZMHNPaVU0S1puZXNaS05ib243ZS90UXlmbnVtZWM2Zlg3eDJM?=
 =?utf-8?B?NnlFTnBqOHE4NHpvSnRtMzh0bUNpMEV3RG1pV2VQYUhvUUdsVVp6OUpMTHZE?=
 =?utf-8?B?UWZub2dxUWYyaFFxeE1GTDlPY3MweUtyTjNVU3M0MCs1ajQxYkpMRkxZcjkx?=
 =?utf-8?B?WE50RUlud2QrK2RGOHpKNTE4MjJGTUNtYnQ4RWNsZ2d3NkljR2t4MzlzVGox?=
 =?utf-8?B?VVB0bVg5c3RnbHNLOGUrMWdONVVac0xiVzBwQjFYUklqYm51VGFyb2NoYlNu?=
 =?utf-8?B?RjlHcHV2c3dkYnJjc0J0WTVYM1RKdk45dWdQZjhtOFNWODA5Ny9IZFhBSGs2?=
 =?utf-8?B?WjJCLzA5TlNvQ1VGeVFOTUVFQjI3elJOZk9GVXBWekJTWTQ3Unp1VlVxQVVI?=
 =?utf-8?B?Tm5HditzaWtSRlJwRFRVKzNPNllTVFFHQzVVbERueW1OSk13RWRvQmhBRWlL?=
 =?utf-8?B?WjJJTXZVRnd6MVlxdFIxdVo3T1U3SEJrT0lSSTh5NVVKNWZCeWxUSXNxVTlr?=
 =?utf-8?Q?d26b+DE0j28bQ+Bfyt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e95bdd-da93-4835-6a53-08de4cc71ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 01:58:45.1221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lwRWh5SwOnhN+xKSynU6tlJp3IN/d2/nzklgh6eZml7eAlzQghV270RYq2h4GFx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469
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
Cg0KUmV2aWV3ZWQtYnk6IExpa3VuIEdhbyA8TGlrdW4uR2FvQGFtZC5jb20+DQoNClJlZ2FyZHMs
DQpMaWt1bg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWmhhbmcsIEhhd2tp
bmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NClNlbnQ6IFN1bmRheSwgSmFudWFyeSA0LCAyMDI2
IDExOjA0IFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IE1hLCBMZSA8TGUu
TWFAYW1kLmNvbT47IEdhbywgTGlrdW4gPExpa3VuLkdhb0BhbWQuY29tPg0KQ2M6IFpoYW5nLCBI
YXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRn
cHU6IEV4dGVuZCBwc3Bfc2tpcF90bXIgZm9yIGJhcmUtbWV0YWwgYW5kIHNyaW92DQoNCkluIFNS
SU9WLCBndWVzdCBkcml2ZXJzIG5vIGxvbmdlciBzZXR1cC9kZXN0b3J5IFZNUiBzdGFydGluZyBm
cm9tIG1wMCB2MTFfMF83Lg0KDQpJbiBiYXJlLW1ldGFsLCBpZiBib290LXRpbWUgVE1SIGlzIGVu
YWJsZWQsIHNvbWUgZ2VuZXJhdGlvbiAoZS5nLiwgbXAwIHYxM18wX3gpIGRvbuKAmXQgbmVlZCBy
dW50aW1lIFRNUiBhbGxvY2F0aW9uIGJ1dCBzdGlsbCByZXF1aXJlIFNFVFVQX1RNUiBjb21tYW5k
IHdpdGggdG1yIGFkZHJlc3MgMCBmb3IgYmFja3dhcmQgY29tcGF0aWJpbGl0eS4NCnNvbWUgbmV3
ZXIgZ2VuZXJhdGlvbnMgcmVxdWlyZSBuZWl0aGVyIFNFVFVQX1RNUiBub3IgREVTVFJPWV9UTVIg
YW5kIHdpbGwgcmV0dXJuIGVycm9ycyBpZiB0aGV5IGFyZSBzZW50Lg0KRHJpdmVyIHJlbGllcyBv
biBib290X3RpbWVfdG1yIGFuZCBhdXRvbG9hZF9zdXBwb3J0ZWQgdG8gaGFuZGxlIHRoZXNlIGNh
c2VzIGNvcnJlY3RseS4NCg0KU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5a
aGFuZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bz
cC5jIHwgNDAgKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9wc3AuYw0KaW5kZXggMDhmYjcyYWRjOWU5Li5hMWJlZDhiODc0Y2IgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KQEAgLTkwMiwyMCArOTAyLDEyIEBA
IHN0YXRpYyBpbnQgcHNwX3Rtcl9pbml0KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQ0KDQogc3Rh
dGljIGJvb2wgcHNwX3NraXBfdG1yKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKSAgew0KLSAgICAg
ICBzd2l0Y2ggKGFtZGdwdV9pcF92ZXJzaW9uKHBzcC0+YWRldiwgTVAwX0hXSVAsIDApKSB7DQot
ICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgMCwgOSk6DQotICAgICAgIGNhc2UgSVBfVkVSU0lP
TigxMSwgMCwgNyk6DQotICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMywgMCwgMik6DQotICAgICAg
IGNhc2UgSVBfVkVSU0lPTigxMywgMCwgNik6DQotICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMywg
MCwgMTApOg0KLSAgICAgICBjYXNlIElQX1ZFUlNJT04oMTMsIDAsIDEyKToNCi0gICAgICAgY2Fz
ZSBJUF9WRVJTSU9OKDEzLCAwLCAxNCk6DQotICAgICAgIGNhc2UgSVBfVkVSU0lPTigxNSwgMCwg
MCk6DQotICAgICAgIGNhc2UgSVBfVkVSU0lPTigxNSwgMCwgOCk6DQotICAgICAgICAgICAgICAg
cmV0dXJuIHRydWU7DQotICAgICAgIGRlZmF1bHQ6DQotICAgICAgICAgICAgICAgcmV0dXJuIGZh
bHNlOw0KLSAgICAgICB9DQorICAgICAgIHUzMiBpcF92ZXJzaW9uID0gYW1kZ3B1X2lwX3ZlcnNp
b24ocHNwLT5hZGV2LCBNUDBfSFdJUCwgMCk7DQorDQorICAgICAgIGlmIChhbWRncHVfc3Jpb3Zf
dmYocHNwLT5hZGV2KSkNCisgICAgICAgICAgICAgICByZXR1cm4gKGlwX3ZlcnNpb24gPj0gSVBf
VkVSU0lPTigxMSwgMCwgNykpID8gdHJ1ZSA6IGZhbHNlOw0KKyAgICAgICBlbHNlDQorICAgICAg
ICAgICAgICAgcmV0dXJuICghcHNwLT5ib290X3RpbWVfdG1yIHx8ICFwc3AtPmF1dG9sb2FkX3N1
cHBvcnRlZCkgPyBmYWxzZSA6DQordHJ1ZTsNCiB9DQoNCiBzdGF0aWMgaW50IHBzcF90bXJfbG9h
ZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkgQEAgLTkyMywxMCArOTE1LDcgQEAgc3RhdGljIGlu
dCBwc3BfdG1yX2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQogICAgICAgIGludCByZXQ7
DQogICAgICAgIHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQ7DQoNCi0gICAgICAgLyogRm9y
IE5hdmkxMiBhbmQgQ0hJUF9TSUVOTkFfQ0lDSExJRCBTUklPViwgZG8gbm90IHNldCB1cCBUTVIu
DQotICAgICAgICAqIEFscmVhZHkgc2V0IHVwIGJ5IGhvc3QgZHJpdmVyLg0KLSAgICAgICAgKi8N
Ci0gICAgICAgaWYgKGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpICYmIHBzcF9za2lwX3Rtcihw
c3ApKQ0KKyAgICAgICBpZiAocHNwX3NraXBfdG1yKHBzcCkpDQogICAgICAgICAgICAgICAgcmV0
dXJuIDA7DQoNCiAgICAgICAgY21kID0gYWNxdWlyZV9wc3BfY21kX2J1Zihwc3ApOw0KQEAgLTk1
OCwxMCArOTQ3LDcgQEAgc3RhdGljIGludCBwc3BfdG1yX3VubG9hZChzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCkNCiAgICAgICAgaW50IHJldDsNCiAgICAgICAgc3RydWN0IHBzcF9nZnhfY21kX3Jl
c3AgKmNtZDsNCg0KLSAgICAgICAvKiBza2lwIFRNUiB1bmxvYWQgZm9yIE5hdmkxMiBhbmQgQ0hJ
UF9TSUVOTkFfQ0lDSExJRCBTUklPViwNCi0gICAgICAgICogYXMgVE1SIGlzIG5vdCBsb2FkZWQg
YXQgYWxsDQotICAgICAgICAqLw0KLSAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRl
dikgJiYgcHNwX3NraXBfdG1yKHBzcCkpDQorICAgICAgIGlmIChwc3Bfc2tpcF90bXIocHNwKSkN
CiAgICAgICAgICAgICAgICByZXR1cm4gMDsNCg0KICAgICAgICBjbWQgPSBhY3F1aXJlX3BzcF9j
bWRfYnVmKHBzcCk7DQpAQCAtMjYzMiwxMiArMjYxOCwxMCBAQCBzdGF0aWMgaW50IHBzcF9od19z
dGFydChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkNCiAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQogICAgICAgIH0NCg0KLSAgICAgICBpZiAoIXBzcC0+Ym9vdF90aW1lX3RtciB8
fCAhcHNwLT5hdXRvbG9hZF9zdXBwb3J0ZWQpIHsNCi0gICAgICAgICAgICAgICByZXQgPSBwc3Bf
dG1yX2xvYWQocHNwKTsNCi0gICAgICAgICAgICAgICBpZiAocmV0KSB7DQotICAgICAgICAgICAg
ICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgIlBTUCBsb2FkIHRtciBmYWlsZWQhXG4iKTsN
Ci0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQotICAgICAgICAgICAgICAgfQ0K
KyAgICAgICByZXQgPSBwc3BfdG1yX2xvYWQocHNwKTsNCisgICAgICAgaWYgKHJldCkgew0KKyAg
ICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiUFNQIGxvYWQgdG1yIGZhaWxlZCFcbiIp
Ow0KKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQogICAgICAgIH0NCg0KICAgICAgICByZXR1
cm4gMDsNCi0tDQoyLjE3LjENCg0K
