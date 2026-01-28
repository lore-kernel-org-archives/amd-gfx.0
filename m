Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2DFD35676
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 05:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7725610E61D;
	Wed, 28 Jan 2026 05:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gR/pR1jT";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4180E10E61D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 05:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdxd14GVMAMa8yMsfHclDMm0848Z64UgchB8+Dy7/8DG+nwaDnlOK3PVpKhxZIcZdMQvLaN8Tdgvzc/KLqvpUYKa4FuagswDM0fWvSd9oWN4OO9WC/VByX5KaOBdPGqKXqCEAKY3+d7PxtGL9AsEBlESNR7XVYvWzeaB/s7fcPVStft8/kdOcBMCp8EF94d0tMrJZQ8eY2g6FpU4BuSgBM84BT00xZDifaV9fF1rvdGxAEcUKtjk6VFCSJ/etYObLvm7vZQhIDcvXm8KRL+X4nVjYBGTkZa6/8E8tzlnzVdqU5SRRmGADI7A0nHXw1fLwEgePjC3w1pGISFaxNEtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bx1B4WRMzg1iG7zCTpPxlhljiZIvdPumpb/fmngSOE=;
 b=ht2m1NnL8rOuDqHKlr92ldqZHerzy63jnT6FXXB7ykuBkN/yd6eijAMbeenIL43E+jVw+Y8o291BO9UrsvxziEcqwkPidwyKfUrr33eTGEFb3yN54N3mDharCaO7na4GtU/hXAvLIPvtsYalWwAj6r1RyAmGYrp9gLQLKBKl0I3od8wXAKI6i4V/cxB1hI+uPTFDsvD4xG9+5GzfxwGhbJ2ksC8Qqyl74n0mvRr7iuLA3xayLDxdcARm+6nFkZmKHlwECuffPemIA0HfbO1zwfeX1utIVB71ML6JdfSLGWWmqOpyReP9S4LLKM4UeNNVKNMnmt85/7eLjQER9OKB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bx1B4WRMzg1iG7zCTpPxlhljiZIvdPumpb/fmngSOE=;
 b=gR/pR1jTop5Y+yuKeYtgOWrdGv7t1WLmLe+O493TeAmc5aPk7rxMEMoo7lIdJCsaPvJJ8SyTU3edaJr7DhYUpI8xkbLx14eplneagxrsbVeA2RJoCBhEEvujRFkNf/C2xc73Ccpbsb90pDw1xxGwgrb2UUP282o8k5gj10gQLO4=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 05:19:15 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 05:19:15 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix cond_exec handling in amdgpu_ib_schedule()
Thread-Topic: [PATCH] drm/amdgpu: Fix cond_exec handling in
 amdgpu_ib_schedule()
Thread-Index: AQHcj023xgO1nm5KmkuPQ3JaJMEOobVmoX6AgABrKlA=
Date: Wed, 28 Jan 2026 05:19:14 +0000
Message-ID: <DM4PR12MB515269DC60F3352A9207FD84E391A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260127052733.54360-1-alexander.deucher@amd.com>
 <CADnq5_PDUqV5E_t1k3pnoZVHs3OP87D1PdUnwK4EKvBA-PGv3w@mail.gmail.com>
In-Reply-To: <CADnq5_PDUqV5E_t1k3pnoZVHs3OP87D1PdUnwK4EKvBA-PGv3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-28T05:19:09.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW4PR12MB7191:EE_
x-ms-office365-filtering-correlation-id: b83565c2-10a0-4ed4-3fd7-08de5e2cc75f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WlRzdWNIVzZvYkxDWEdxSWl2a2tkQVhpZFh0ZzlYU09nSUpibU04QXVWTldH?=
 =?utf-8?B?Y0E5dlRWSFppRTYrOGpvKy9rVWhpN0Nhb20yVzlSK0kyZ3p3UDNzWFZnMFBm?=
 =?utf-8?B?WjhJNGE1dnFLWE43MTdvdHhrNzdBZzlLVDFMYUhYNTNVYktrdXZ2WFdzYXgz?=
 =?utf-8?B?TjdoUkIyT2cyZ2RJZFZvZGExWThVUUg1KzQzTHFoRUNETDVhRE8zdDA1eGg5?=
 =?utf-8?B?aTk0QnJtcjlGaDkreWhaQkdWNlRqTDhaYUpLTy9UNE9IWDNQNnUrZ21naVBl?=
 =?utf-8?B?ZnFzeHg0NUp6Q0R1U1hpUXhKd2JMMVpSVjhWV0ZNenlYOFh5aVh0TEYrODIv?=
 =?utf-8?B?d0JxN3hlNlZobW1IUXpERS9iMmxhSWdGZUgzSWZMTWYwZkdOTDBUMW5KOHFL?=
 =?utf-8?B?RXhlclpSU29MUWtoZkpNbDNmV2RjUVhFZUgwRmdXZmlIeWJ1RUZSaTkwMity?=
 =?utf-8?B?SGpTS29JeWRCRFMwWVhtVW5JSU5DYUdJd0QycjIrL1F0TzUrMXk1ZUdXblVo?=
 =?utf-8?B?V3Fwc25RN3NoRjlCRTZsWlFYVlRTQWhveXdTWmpuZnA3bmV6RmNMNmZNdnRG?=
 =?utf-8?B?YXBuZDIvNXA3UEZsY2V6S1c5anpwQUtUVFRuRjZ3VG9LMmF3Q1d5dkxWa2Ex?=
 =?utf-8?B?eVZRelZXU3h3OS94M2EvdDIxQUlEbEdEWDBGQmRJQlJHR1lWYU9ENEpHT0Fm?=
 =?utf-8?B?bHNzTHdOanRFQlZJbWh4N1RVZVVBbHMxZDM0SllmNFhLUHNtN2dYUjVKamE4?=
 =?utf-8?B?ZHN2M3BKazNvU21DdnY3SEM3b2RoT0NyZFJRVkhIZzNvYVFGeitja040b0ZV?=
 =?utf-8?B?Z3JwZE94cndwdDlNRkVBUUp6Q0NIWDNCRy91LytpL2ZmTmtOYzV2em9leTZ1?=
 =?utf-8?B?STV1Uk9OM0FiTENxcHJDbkZEMlkvSUVpaHV5OERUc3dtWkZlNU91V2NaTWsz?=
 =?utf-8?B?WVBIR2hBaVBKT21taC9hK0xEYW8rS3ZkT2VpWGhKcExhN2t3T09VbzM1ak1N?=
 =?utf-8?B?ZW1YMDN4bmNYT2J6UWlPZUFVanY5Wk5Wd0pEd0VDSiszUGloSmlJbFJkQWsr?=
 =?utf-8?B?MnhpdUZMOHZlZVdvS1M1Z1l4blhldUlaR1dpOVVOSlZud2ljN0lWNiswQUFV?=
 =?utf-8?B?ZEsvTXJGYW1oTUJISTVxbUxVRlNrbm8yNnJ2alhncHdLMFRnL2JtejNkUDly?=
 =?utf-8?B?aEF3K0ErWXppNWhUalREdC9qSEYyUmZ5RWlKZ1FucjNMTEg5WEhWYkM1aXpR?=
 =?utf-8?B?SE85TVRrbGR4SW42alk3L2kyTE5ScFlBaHMzODZSTElhVGxDRkQvUGdnaUJO?=
 =?utf-8?B?RlQ4dWVnY3Q2emY1amVOSHR3bG5PZkh1TFFXWG5ZN0h1aUxWSUVMRi91dWlQ?=
 =?utf-8?B?ckMwQW1rNFdSejc4RSsvOFROOFp6amxEVHdKd3BIZFlwNGtzazdjWVpNS0hZ?=
 =?utf-8?B?SzJQREN4TGszT2dZV3crMmhIYkwrSWJMaTZVb2htL0FESW1FR2xOM3BmVnp5?=
 =?utf-8?B?UGhZZ2cyUkN5cEx4NU1PQkRvNEVGWTRhSG1ONjVmUU03amJxSWpFSGk1SjRy?=
 =?utf-8?B?M3QzVmlRSzRDaXI1c3Mwd0JxSVh6N3R4cGJuN0ozSlFXWkljTFdGb2ZLN2pk?=
 =?utf-8?B?aEh4bWRTK1NTbzlIRGdYbHROMTNFeFZmdjg5VHk5akJNYlVjaFpobFVDdTY2?=
 =?utf-8?B?bTA4KzNQQzJ6QzVVaXNmc0NyZVhrS0dCdlVwZXRYM2Z2MVdudUY0K3VmYWha?=
 =?utf-8?B?cTRoVk4wQk44M3ptZFY3RTlpeEVWMGRDcUd6d2k5QlZKUHIvMGlkQjJIdG9E?=
 =?utf-8?B?UWVHajM4TkJRS3hxeTBOM0FUVlhKTGxvYU0vSDEyLzR1T2FPOGRkY2VneDFo?=
 =?utf-8?B?djFMdEx2Y0RZa1RCbnB5U0ZqNW1PQy9QK0RJdDBhdEZHbENtUjl0U2dTbTV5?=
 =?utf-8?B?UnkrbXcrMkR5Q256MUhieFpwazA0Y3J2dmVhcUE2Nm5NUVk1QXFvY1JWVHNW?=
 =?utf-8?B?UlBNZEUvMTdIVjVIZ0IvRnZXS1ZKWklMOEp6cVVlVzZWc0VmdEtFUWh2UWZT?=
 =?utf-8?B?Vm13Tm1Ec0hvWnpnb0lIWjROazh5M25YaTV6eDlqUzF3YlltdVQvUTFheHgv?=
 =?utf-8?Q?NSPI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGRRVTFZckhVYzExZFJ1NDRXaDJJV0Y4Z2I5WEtIeGlISnRaTiswU1lVK1Zl?=
 =?utf-8?B?cDhKdFJUZUtpZlQ2S2FOM0FhLzZ1c3VKWGlDUk95R29lK280S0l5c0p4OFQ4?=
 =?utf-8?B?cTNPUUZoSzM2aDRpOTM5YXNpRmlSOHJjR1pSMExUVkx1aEF4WG80Rm1tVERQ?=
 =?utf-8?B?dnZLdkhBVU5YdDFuSUw5Y21IYWptSnRrWTVOM0ZLdjd2bEN2ZVhPSzRkRTFV?=
 =?utf-8?B?aXc1REtYa25NNE9LZE5pMFo5TmxZK2tFallCdzdoY085ajhWNFVqaDdMSk5u?=
 =?utf-8?B?TS9sRjZZZVlPZ3lSc2ducllQSHhDNkVvY1dtSUdxZjNxem1zZEEvQktCTE0x?=
 =?utf-8?B?cFRnSk9ZenNvOHUzN25hdjVrVjFKZWozZzZFRmRnMk5FaXhZa0NPZnY3ckRw?=
 =?utf-8?B?YTdHWVpscWsvNSt0TXRCQ3o4b24yd2dxZ2tCUzRYZzNLam5oWHZUN0JXanlx?=
 =?utf-8?B?bWxDSUlYaWlkQXpqREJwb01JditoNDc1NW5OcjJhNm9rbFkzMFpJMVpUWURI?=
 =?utf-8?B?VjVQbTk1OUtyZkhrbS85WTJ5dkR0YkpxVUhnaEVneFgzdS9QRU9SaEZRWERk?=
 =?utf-8?B?Nlo4Vy9FMlVrRFF1b0gwRWlVNFprNklqUStxRkxvRityS1hTMGdsKzdQTWN6?=
 =?utf-8?B?cld4NGR5d2dWTEFGbGZHMk1aekFsRGZNK015SmZnRzRUdWVwUkZrMFJkSG85?=
 =?utf-8?B?d0xNR1ZqK085ZDlhZXlaclNtSnpDUGc2Wjc4dkpsQnZJYzRrZis5YVJaaExo?=
 =?utf-8?B?UXV2YzVlVVZlZXltYjFqclJNSFpuL0NLUUVBL0hYaUM1cDlKWTR4aHNqTmZ5?=
 =?utf-8?B?ZXhSWEJJUlNFVHgrVWlnYVhiVXo0V2NRYmRnSnhCbWpVeWtqckNpUTdEb0ps?=
 =?utf-8?B?QUJreU1MMGNoUFh3Tlc1OVNwRzd4eWVUU04wRmpZS1pBYnVQWkxEdHRiVFM3?=
 =?utf-8?B?eTAyNHkvTXVocllxUVNTalNsUmp0cEZYRmhQbmFaQzVuTzVpYktzRWdYbG4v?=
 =?utf-8?B?Rkt6OUducVIxZW8zSVRJekM3Zm9ZWWtPMlAwY1VTYTNjUmFuY2hZc04xZGIv?=
 =?utf-8?B?eThRb3NIYzF2aFBDMFIwL2l3V25FYnFvdXg3aDBNVVYzRFFvdWhVbzNjQjU4?=
 =?utf-8?B?aTZGUFgzNGhncjd0S0hGVGtHbHo2dVBZeDBEb2ZOZ1F6cjE2bHV3anVYZ2dX?=
 =?utf-8?B?Mkx1bk1Hc05pNWJ2MU5KUGhBWWNtcCtmSTdvTmpMUWxxOW8wTjJDMDd5b1J2?=
 =?utf-8?B?VDZaajNISFVyN1ZlRzhSeU1WcCsxa1djTjdqYkpsZ1N6RExNN2dleE45ckFj?=
 =?utf-8?B?VklXcDByT1BiV2dvSWJYRDFWYWtYblpSTk1VWDJqWHg4OUxBcnZlWUszNkRM?=
 =?utf-8?B?RERFUXN4T2tlWnd2bjladXlLVWF0V2NsYW5ZUUFWTmVNRzd3VUtLVUFGTW5x?=
 =?utf-8?B?b0o4YTF6WG9Va20yZXV5V3c0UXVXM1QvMnBHUFFXUHhKNXVydUZLdWlxZ1F2?=
 =?utf-8?B?Mk1NbkVPL1VLQlVLQ0VuNVFFaUN1RlplaTJVRVJ1SlZSdTlGbHRLcHdpRlBn?=
 =?utf-8?B?V0ZHZmVmdW9oaXVwQVprR0NoeHNCdVcyWk5OM0JVK1ZSTm1ra2dZZTZaa05G?=
 =?utf-8?B?QmQ3TXpLQTRlQVMyaE1GWnJCWGdySU43aTVEV1kxdG41b2NGQ040cTc0NHdn?=
 =?utf-8?B?ZUF2bDM4NDRteTRvMklTZ3VNZUVUb1ZVcTNPdG51eTlNditpZjNqUmVrM0VU?=
 =?utf-8?B?a0I2WW1LTW43VFRXZVA2Y3VUaCtlanZvcnFLbVV5VGxPKzBpOHdPU1kwRGhF?=
 =?utf-8?B?bWV4VG1KZ2hHN1VMWCthaXBzdUdLTlE1b25TNVlYMGF1RXBSbTF1ZzBhVFhl?=
 =?utf-8?B?dmFaSkxMQkRYQUkySWdCMjhTN09mU1E3K2hpZ2FsV21UQXpEUEZwZGhuMDFH?=
 =?utf-8?B?OVVEblloZVlUcUhCZlBIYVozUFN5WENablc0cGxhWklnVG11ZG5MdDY2RWkw?=
 =?utf-8?B?NElPbnYzcGF4QUpqY2FCTW5sUmdoUEVaMjUrajE5QTJreTJwckZWTWQ3Z25B?=
 =?utf-8?B?V0p4dUNaTXZ5Z3ZkVjJ1ZVNXK01oeHFOMGthL294cG1JNFFqQ1A2dXdnUitU?=
 =?utf-8?B?eTZKeTFqY29vektsSkhsTHRiUC9XK29BWE9YVVFDSzk1dHFxMzNsWFlOUXlP?=
 =?utf-8?B?SDZBcWNJMmI1T2IwZE1XckQ5a0VRSmYraG5OQkozZ0pEVWVmbkhFajUxMHB5?=
 =?utf-8?B?YU9xU25Ea2UvNG56WG5zendaeW5pSTczMVV3SGNnVUdkUFc3emo2Y3NtYnJI?=
 =?utf-8?Q?tm3qetE90PKrT4a5DG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83565c2-10a0-4ed4-3fd7-08de5e2cc75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 05:19:14.9529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oonrpyWl18djc9WeYADpT593tpdoOu3EqwsjDsSGklEMFGIhUQvYHOxZ41yjI+ozw+vfQ4fI4972TbR0lzFL5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191
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
Cg0KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4
LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleA0KPiBEZXVj
aGVyDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyOCwgMjAyNiA2OjU2IEFNDQo+IFRvOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1k
Z3B1OiBGaXggY29uZF9leGVjIGhhbmRsaW5nIGluDQo+IGFtZGdwdV9pYl9zY2hlZHVsZSgpDQo+
DQo+IFBpbmc/DQo+DQo+IE9uIFR1ZSwgSmFuIDI3LCAyMDI2IGF0IDEyOjM34oCvQU0gQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRo
ZSBFWEVDX0NPVU5UIGZpZWxkIG11c3QgYmUgPiAwLiAgSW4gdGhlIGdmeCBzaGFkb3cgaGFuZGxp
bmcgd2UNCj4gPiBhbHdheXMgZW1pdCBhIGNvbmRfZXhlYyBwYWNrZXQgYWZ0ZXIgdGhlIGdmeF9z
aGFkb3cgcGFja2V0LCBidXQgdGhlDQo+ID4gRVhFQ19DT1VOVCBuZXZlciBnZXRzIHBhdGNoZWQu
ICBUaGlzIGxlYWRzIHRvIGEgaGFuZyB3aGVuIHdlIHRyeSBhbmQNCj4gPiByZXNldCBxdWV1ZXMg
b24gZ2Z4MTEgQVBVcy4NCj4gPg0KPiA+IEZpeGVzOiBjNjhjYmJmZDU0YzYgKCJkcm0vYW1kZ3B1
OiBjbGVhbnVwIGNvbmRpdGlvbmFsIGV4ZWN1dGlvbiIpDQo+ID4gQ2xvc2VzOiBodHRwczovL2dp
dGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy80Nzg5DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyB8IDUgKysrLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYw0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMNCj4gPiBpbmRleCA3
MmVjNDU1ZmE5MzJjLi40NGYyMzBkNjdkYTI0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2liLmMNCj4gPiBAQCAtMjM1LDcgKzIzNSw3IEBAIGludCBhbWRncHVf
aWJfc2NoZWR1bGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPiA+IHVuc2lnbmVkIGludCBu
dW1faWJzLA0KPiA+DQo+ID4gICAgICAgICBhbWRncHVfcmluZ19pYl9iZWdpbihyaW5nKTsNCj4g
Pg0KPiA+IC0gICAgICAgaWYgKHJpbmctPmZ1bmNzLT5lbWl0X2dmeF9zaGFkb3cpDQo+ID4gKyAg
ICAgICBpZiAocmluZy0+ZnVuY3MtPmVtaXRfZ2Z4X3NoYWRvdyAmJiBhZGV2LT5nZnguY3BfZ2Z4
X3NoYWRvdykNCj4gPiAgICAgICAgICAgICAgICAgYW1kZ3B1X3JpbmdfZW1pdF9nZnhfc2hhZG93
KHJpbmcsIHNoYWRvd192YSwgY3NhX3ZhLCBnZHNfdmEsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbml0X3NoYWRvdywgdm1pZCk7DQo+ID4NCj4gPiBA
QCAtMjkxLDcgKzI5MSw4IEBAIGludCBhbWRncHVfaWJfc2NoZWR1bGUoc3RydWN0IGFtZGdwdV9y
aW5nICpyaW5nLA0KPiB1bnNpZ25lZCBpbnQgbnVtX2licywNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBmZW5jZV9mbGFncyB8IEFNREdQVV9GRU5DRV9GTEFHXzY0
QklUKTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgaWYgKHJpbmctPmZ1bmNzLT5l
bWl0X2dmeF9zaGFkb3cgJiYgcmluZy0+ZnVuY3MtPmluaXRfY29uZF9leGVjKSB7DQo+ID4gKyAg
ICAgICBpZiAocmluZy0+ZnVuY3MtPmVtaXRfZ2Z4X3NoYWRvdyAmJiByaW5nLT5mdW5jcy0+aW5p
dF9jb25kX2V4ZWMgJiYNCj4gPiArICAgICAgICAgICBhZGV2LT5nZnguY3BfZ2Z4X3NoYWRvdykg
ew0KPiA+ICAgICAgICAgICAgICAgICBhbWRncHVfcmluZ19lbWl0X2dmeF9zaGFkb3cocmluZywg
MCwgMCwgMCwgZmFsc2UsIDApOw0KPiA+ICAgICAgICAgICAgICAgICBhbWRncHVfcmluZ19pbml0
X2NvbmRfZXhlYyhyaW5nLCByaW5nLT5jb25kX2V4ZV9ncHVfYWRkcik7DQo+ID4gICAgICAgICB9
DQo+ID4gLS0NCj4gPiAyLjUyLjANCj4gPg0K
