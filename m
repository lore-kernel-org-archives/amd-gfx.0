Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA12CA0EE8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 05:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C46810E012;
	Wed, 17 Sep 2025 05:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xgDWRFrk";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C36510E012
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 05:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx9ziyXraaNzLpncAutWELXBEyCkt8iBSmyqm68ToKzNIzenr4AfrTqOABSPOPrc5qKOEYWxiQRm1QGTzzMRlG26p1b39AX/tSmgqkeeAcxh9XrWbnwPjz73qC2fHvW6LhZwvaKT1eZdyKV/0PdMIYT9JjsoVy5f4Ju31/PJdkcP/WhaF2fyVB+4Q1/hXmLrqtp26aB1ZbUF/JjocVVYdi1/WgZbelGfF2x2CAc7mu02inuFXfamyhckHq2V3DyawQo/ybPn4dxS3Sfjj02S4IYqEPsXtGrf8rgSKNxmjzl/ur/dhUOzAHHWEtyEPNY4hIizW6bDc8rDDRZQnwIqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE/q1/tzHJ0yVCMtjMNWa0RVOvvVtNGW4sTWAZPq+aY=;
 b=i7ZleoVVTpf/KJv6Bd8XUxmQPb7CoaeZfEh0RYvRJdQAbWMnlE+udTAllNv4n2ltllTIbpTabElgY8/C43PKvESw8EQWjQi4Ivd0KzthGgfsgzhic7gURy114eMXeE54ShpjfoVYsn8YBlboIbHGEcrIgTMNHKxLqzX20H4hwhWriyAGOZpGsY5X8cTpzV3F2VMrUnDqmJl46OL+owIdpM94cbGq+bXqJq1wAimT1BkGXEYy1mJfVFgKNdcok6FvgMUNuTLbR7EEGRUVhVXheYtEBvPpdlWe9sHyfu3s2ZT+jf13j9nj9arZyl34plu+Su3NEVAalGe9nuKH4kF9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE/q1/tzHJ0yVCMtjMNWa0RVOvvVtNGW4sTWAZPq+aY=;
 b=xgDWRFrk9uVfrqhCfc7uGQEkHTntjXE6yox8mSdNCdaBpDukqK79fI2Ym17DBbamuTySucrY8V1Y7vIE+yxGPab6g8JH92L7JUI1Nv0opzjuT/ZdR4BGGXee+MpXPTVML9x087AUADrsZbEYIiXmDUryGFyVEW0SvAcZUmQ4198=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Wed, 17 Sep 2025 05:51:43 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 05:51:43 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH 2/2] amd/amdkfd: drain kfd process workquque before switch
 partition
Thread-Topic: [PATCH 2/2] amd/amdkfd: drain kfd process workquque before
 switch partition
Thread-Index: AQHcJ4TB05M/FH7JKUG/jLInp5bE+7SW3rsQ
Date: Wed, 17 Sep 2025 05:51:43 +0000
Message-ID: <DS0PR12MB7804220F7920A96DA14B4FA69717A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250917033918.904142-1-yifan1.zhang@amd.com>
 <20250917033918.904142-2-yifan1.zhang@amd.com>
In-Reply-To: <20250917033918.904142-2-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-17T05:51:38.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CH2PR12MB4216:EE_
x-ms-office365-filtering-correlation-id: cbd33242-2e9f-43f1-4566-08ddf5ae47cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RKMi8dDwFjhSJkk/Cq5/n5v9NyTtlzW5w9BPSUa+z38rS1QKdcKHW+QcJx2U?=
 =?us-ascii?Q?BAn2cF0NKMscap5l0KAn0tzYbL59nFPZZYqCkLIn+M5mBJP1q0wFBO/zm+R9?=
 =?us-ascii?Q?SeytU2F96GjwpYqivEfCnh6idNBmGuMWMLRB4QL36lKQvRuEBWAXL3t7xXy2?=
 =?us-ascii?Q?MtrqA+1HNu+u85LPjg/PQZo6hLqXaYUO1iKUiqqdkibGPfUJk5YXybegEp48?=
 =?us-ascii?Q?l97TVsDFMVuQOklYvcyZ2GPq/E8E/QUE6duNWLCCHxTq5vf/YpeCMUkUzrml?=
 =?us-ascii?Q?08HvOcHXRfU/cAXUECch6KBxvZB3EDT45cNAyJSOIFCDW6Rn8vNlnlL+3/EJ?=
 =?us-ascii?Q?S2QreEBH35tG896VTxuGTIXmM+wWiaA0Hapz7Dwsh+8cj3ouMnoP8rbEeHb3?=
 =?us-ascii?Q?+na19OvyRFrP85ApwEIpSjJuVZVhO3OUvW1z7iNjy1iGtjdu0VaMX/t83CFF?=
 =?us-ascii?Q?1OVHbz7iJ7grA7JdV/AxXsK4yDsuRj2M7QoHN3YAccH0W+l1/uym+0HWSdRw?=
 =?us-ascii?Q?64iMDGffOqq9fnAjrjluD5eSFbcRPyXSN2tFFnWFOiqG7kgC+OQ44igQ9g/q?=
 =?us-ascii?Q?JUuPvE2Prh0ShZapyJqsC5YUkD+ZhtE2MoJqZpQvaKM0zYrAi7VRAoe8yfPQ?=
 =?us-ascii?Q?3TlDK+u4+qa3XuNO2BUdEwW4aH9rDS5Y7c02pk+2Npq0MqtDcJz6GAAoIoTW?=
 =?us-ascii?Q?Ol1BIqaB824QXRt5syXTebJNGh4qR4Gc7iMKNrWdKaBBC62pWwy6DJJw2+3q?=
 =?us-ascii?Q?Y5fy4aZulF55sY/gsJ/8buuAY3S4ZKxITa7witDhAfnArG4nlbfC2mBS6bvq?=
 =?us-ascii?Q?h86OY3jHHCw99H26xn+ht6B/r+OrNVl5ZKOf/YU/alEWTutw9fKWWCY9plfd?=
 =?us-ascii?Q?LPX2yTheuL5gjfF0giWNY1/kAoj3uOnsw+TppZ/SEM9sdWtq1X7GY936j8HB?=
 =?us-ascii?Q?knWDTqVFVNxkETByDwiw4RP10oG17uPZMCZuUiMURUtlxaAk29k04L77eDFD?=
 =?us-ascii?Q?wmwx6DE0N+3VvHLbqIQ+d7QTjmZJS1757wXsuQyuxGPg5r59xv9XmS/TYOaD?=
 =?us-ascii?Q?/wEAgSHNyTAglSppj/4RRNs8X23aREG7BaGvzuUDLPGZfEUWyKW/yC+XfKJe?=
 =?us-ascii?Q?fEJLkCnRLkxEL/6G4nQ3gLnIomhUcuC7ab2/j5GVJ1HYssmMx/fgpBDdH1G5?=
 =?us-ascii?Q?lf00raBcnBoKey40twTWaeGsvFy5b3yNgoRFyKqoC0R47Seyj6OlzjBFq7oC?=
 =?us-ascii?Q?tVdsNhl2axA9t2QftPwozjr7yn7xFCL8zw4HXvx4zN9G1ZDk5OHQmQt/0G6h?=
 =?us-ascii?Q?A6AVnYhK1CTQeVeHR7FslYfbfDQ3p8jJyikvC+mydM8G6lLFuLqrZg6wspNg?=
 =?us-ascii?Q?/+a3hfZ/Zo//5fMN/gJzB0L6uh+3rDiRg2SM7Qv0hneTjVzLF7KTdSU8ZS5P?=
 =?us-ascii?Q?1ia3s2htZQJBQY/USGqZrG+MLsqQFM/UWjSSplpFCy5lGF+vVBDH1cbfXNl2?=
 =?us-ascii?Q?AMqPCqf7ljJlEzU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sQsGyojLo4wk7nxCD5MZuO9quuVtVhmcdz2vN+j7xzBLGYjDyXK6Ulnc8GXs?=
 =?us-ascii?Q?18tUuz0QE6HGgyvKqIyof8INZs1onEzhSLuDZCVwNvzomnfgh4V9UZXJXH+t?=
 =?us-ascii?Q?oMmEvSfPWmM2sn8npX+dIv+DjpCSdmj4Gb4Rcl/jPQg8L6Tj5hfsyerjISGB?=
 =?us-ascii?Q?o9WLT8basYGutdGU6L9Ib1VFLNJOcaV07TuhIt1itTTq4/9963Cy4y2vmcLz?=
 =?us-ascii?Q?5hOVomGfN1R21fqS4YY/qvaaJ6ZbLLkg62qGAP5+XwTjkObZ3z/2JYWui3et?=
 =?us-ascii?Q?3KDkl9cdEUar1RpM5KTd3IV9WGjpvDRj1XYdVuD0yTy0pgBVXAIEVWa8fFTS?=
 =?us-ascii?Q?v/lW75DNdZTNEe3NAhWR2RFUU52ZfklIFamzx/BUgNKZPnqeSf5z0mJb2wkl?=
 =?us-ascii?Q?dAJB3PrvuxyWXF25Hl8iOECkDTvhUJWQGExK8pGydcUjUbObC3dfksbK6nvS?=
 =?us-ascii?Q?EIQJ7oLu1kBU2QSN9u7okWHdLw2y15ggYlH6SboTuxdZq7Wn2gdBSQ/vRYiB?=
 =?us-ascii?Q?Axxdb7TwLcOd6XuGvNXCS0PECgHywDiB65gFTy3/1DJCJ6rilobX4LimuYdZ?=
 =?us-ascii?Q?pNadbqpVh+P9EJU3NS/gWbS6mBKHuyoq3zjPR0fKHJ0Kf591+uyxyeSxoqlu?=
 =?us-ascii?Q?dt+afSPktGKTDqGqnqHyzFXbaYoX+V/nK6+7gN8FAvoBMjfrkdPq4ovYJIh4?=
 =?us-ascii?Q?wEpx9EdGUU0IPNrbvHge4pg9HrHoSAmRgsn1xYenvOVrDtgfgX4t+3OnTdeP?=
 =?us-ascii?Q?HO0D1HKvElQYWkM6+R7PnasdNG8B8PCSLxeWQFOBKlLsC3vCfmNFi7NsDSHV?=
 =?us-ascii?Q?8F78OJR8e2wM8wOucARZ1QeRW8SpayBjgEc4Mht5gGtUpZ2UQ9WcMVK9FpQX?=
 =?us-ascii?Q?1xW+UvJwtNSI+kBAeI3KAir3GO3xxkddzSRt6wk0QDTCIdJ7U34qHwJRPDBy?=
 =?us-ascii?Q?PrnBJdAzfTv493v3Elk+Jigj+XdY6tJrIWJ42VmnoENVir5Gbk3PKuqswzIA?=
 =?us-ascii?Q?Yq4Yfu53r3aHRZfugQwMumfY6mZKrUpkjEFoot2f03WzN2amOu9kySvo25Sj?=
 =?us-ascii?Q?OywUW2Nb4if+ClhiWn/GMzabqgCgWklfthKCq/Bam3ieei/xPaZfGMkkWzo+?=
 =?us-ascii?Q?ScAcSqej1W/hzUgQHNqvVORrplhvgdvrdTUVWdSg5ooV3ZIJe36PD/Zq0RYJ?=
 =?us-ascii?Q?VBBViUsVUF6wzZSZLb+70JRO5y+ClooHCpjK/tXYkO7brGn8FtjL0IP+Da/Y?=
 =?us-ascii?Q?21Mb5mLUQtGlqz98Fnr7Oq8g8vPKZ7DIWs5tIeC3a8IPzyClEqwKGxIF3fk0?=
 =?us-ascii?Q?Cv7Qnz7/pBnOr4oLmCrobCxbueCBml44cIK0L7Ebdh064nTtzbUcrmiYPHzO?=
 =?us-ascii?Q?Q9ILxtD29HoUk4odI6tN16L7eErO+B8ftnPVXMOkJyFLm2iE0waepEyOD6pN?=
 =?us-ascii?Q?lskRu04TxR//9v1K8NRePZfoR8cuv/p6yjI9EKICvL6mCEEtOX5Di4KtjvIV?=
 =?us-ascii?Q?Y8VTLEe/eYzqAGhV+pSBCjIr2UU66CdNezVOHcv19ydGdY1+LrRG5HeO1o2S?=
 =?us-ascii?Q?aBoFI+78tDNpbgu4v3o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd33242-2e9f-43f1-4566-08ddf5ae47cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 05:51:43.3688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmuF69rU24wO/SWVfZaS76EvwKtBzF5KZVknWYws5kd1e4mSFiyOfo7zpG8Fa+8K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
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

[Public]

Hi Yifan,

Please wrap the KFD sequences in an API inside amdkfd/.  XCP will only make=
 use of the API and doesn't want to deal with KFD internals.

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Wednesday, September 17, 2025 9:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1=
.Zhang@amd.com>
Subject: [PATCH 2/2] amd/amdkfd: drain kfd process workquque before switch =
partition

to resolve the race

[3966658.307702] divide error: 0000 [#1] SMP NOPTI [3966658.350818]  i10nm_=
edac [3966658.356318] CPU: 124 PID: 38435 Comm: kworker/124:0 Kdump: loaded=
 Tainted [3966658.356890] Workqueue: kfd_process_wq kfd_process_wq_release =
[amdgpu] [3966658.362839]  nfit [3966658.366457] RIP: 0010:kfd_get_num_sdma=
_engines+0x17/0x40 [amdgpu] [3966658.366460] Code: 00 00 e9 ac 81 02 00 66 =
66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 48 8b 4f 08 48 8b b7 00 01 =
00 00 8b 81 58 26 03 00 99 <f7> be b8 01 00 00 80 b9 70 2e 00 00 00 74 0b 8=
3 f8 02 ba 02 00 00 [3966658.380967]  x86_pkg_temp_thermal [3966658.391529]=
 RSP: 0018:ffffc900a0edfdd8 EFLAGS: 00010246 [3966658.391531] RAX: 00000000=
00000008 RBX: ffff8974e593b800 RCX: ffff888645900000 [3966658.391531] RDX: =
0000000000000000 RSI: ffff888129154400 RDI: ffff888129151c00 [3966658.39153=
2] RBP: ffff8883ad79d400 R08: 0000000000000000 R09: ffff8890d2750af4 [39666=
58.391532] R10: 0000000000000018 R11: 0000000000000018 R12: 000000000000000=
0 [3966658.391533] R13: ffff8883ad79d400 R14: ffffe87ff662ba00 R15: ffff897=
4e593b800 [3966658.391533] FS:  0000000000000000(0000) GS:ffff88fe7f600000(=
0000) knlGS:0000000000000000 [3966658.391534] CS:  0010 DS: 0000 ES: 0000 C=
R0: 0000000080050033 [3966658.391534] CR2: 0000000000d71000 CR3: 000000dd0e=
970004 CR4: 0000000002770ee0 [3966658.391535] DR0: 0000000000000000 DR1: 00=
00000000000000 DR2: 0000000000000000 [3966658.391535] DR3: 0000000000000000=
 DR6: 00000000fffe07f0 DR7: 0000000000000400 [3966658.391536] PKRU: 5555555=
4 [3966658.391536] Call Trace:
[3966658.391674]  deallocate_sdma_queue+0x38/0xa0 [amdgpu] [3966658.391762]=
  process_termination_cpsch+0x1ed/0x480 [amdgpu] [3966658.399754]  intel_po=
werclamp [3966658.402831]  kfd_process_dequeue_from_all_devices+0x5b/0xc0 [=
amdgpu] [3966658.402908]  kfd_process_wq_release+0x1a/0x1a0 [amdgpu] [39666=
58.410516]  coretemp [3966658.434016]  process_one_work+0x1ad/0x380 [396665=
8.434021]  worker_thread+0x49/0x310 [3966658.438963]  kvm_intel [3966658.44=
6041]  ? process_one_work+0x380/0x380 [3966658.446045]  kthread+0x118/0x140=
 [3966658.446047]  ? __kthread_bind_mask+0x60/0x60 [3966658.446050]  ret_fr=
om_fork+0x1f/0x30 [3966658.446053] Modules linked in: kpatch_20765354(OEK) =
[3966658.455310]  kvm [3966658.464534]  mptcp_diag xsk_diag raw_diag unix_d=
iag af_packet_diag netlink_diag udp_diag act_pedit act_mirred act_vlan cls_=
flower kpatch_21951273(OEK) kpatch_18424469(OEK) kpatch_19749756(OEK) [3966=
658.473462]  idxd_mdev [3966658.482306]  kpatch_17971294(OEK) sch_ingress x=
t_conntrack amdgpu(OE) amdxcp(OE) amddrm_buddy(OE) amd_sched(OE) amdttm(OE)=
 amdkcl(OE) intel_ifs iptable_mangle tcm_loop target_core_pscsi tcp_diag ta=
rget_core_file inet_diag target_core_iblock target_core_user target_core_mo=
d coldpgs kpatch_18383292(OEK) ip6table_nat ip6table_filter ip6_tables ip_s=
et_hash_ipportip ip_set_hash_ipportnet ip_set_hash_ipport ip_set_bitmap_por=
t xt_comment iptable_nat nf_nat iptable_filter ip_tables ip_set ip_vs_sh ip=
_vs_wrr ip_vs_rr ip_vs nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sn_core_o=
dd(OE) i40e overlay binfmt_misc tun bonding(OE) aisqos(OE) aisqos_hotfixes(=
OE) rfkill uio_pci_generic uio cuse fuse nf_tables nfnetlink intel_rapl_msr=
 intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i10=
nm_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm i=
dxd_mdev [3966658.491237]  vfio_pci [3966658.501196]  vfio_pci vfio_virqfd =
mdev vfio_iommu_type1 vfio iax_crypto intel_pmt_telemetry iTCO_wdt intel_pm=
t_class iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul ghash_c=
lmulni_intel rapl intel_cstate snd_hda_intel snd_intel_dspcfg snd_hda_codec=
 snd_hda_core snd_hwdep snd_seq [3966658.508537]  vfio_virqfd [3966658.5175=
69]  snd_seq_device ipmi_ssif isst_if_mbox_pci isst_if_mmio pcspkr snd_pcm =
idxd intel_uncore ses isst_if_common intel_vsec idxd_bus enclosure snd_time=
r mei_me snd i2c_i801 i2c_smbus mei i2c_ismt soundcore joydev acpi_ipmi ipm=
i_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad vfat fat [39666=
58.526851]  mdev [3966658.536096]  nfsd auth_rpcgss nfs_acl lockd grace slb=
_vtoa(OE) sunrpc dm_mod hookers mlx5_ib(OE) ast i2c_algo_bit drm_vram_helpe=
r drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_help=
er ttm mlx5_core(OE) mlxfw(OE) [3966658.540381]  vfio_iommu_type1 [3966658.=
544341]  nvme mpt3sas tls drm nvme_core pci_hyperv_intf raid_class psample =
libcrc32c crc32c_intel mlxdevm(OE) i2c_core [3966658.551254]  vfio [3966658=
.558742]  scsi_transport_sas wmi pinctrl_emmitsburg sd_mod t10_pi sg ahci l=
ibahci libata rdma_ucm(OE) ib_uverbs(OE) rdma_cm(OE) iw_cm(OE) ib_cm(OE) ib=
_umad(OE) ib_core(OE) ib_ucm(OE) mlx_compat(OE) [3966658.563004]  iax_crypt=
o [3966658.570988]  [last unloaded: diagnose] [3966658.571027] ---[ end tra=
ce cc9dbb180f9ae537 ]---

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 27 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  6 +++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 127927b16ee2..cefb82ea1981 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -194,6 +194,7 @@ int amdgpu_amdkfd_drm_client_create(struct amdgpu_devic=
e *adev);  #if defined(CONFIG_DEBUG_FS)  int kfd_debugfs_kfd_mem_limits(str=
uct seq_file *m, void *data);  #endif
+void kfd_process_wq_flush(void);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);  st=
ruct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f); diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_xcp.c
index 1083db8cea2e..e12a28074b07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -23,6 +23,8 @@
 #include "amdgpu.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_drv.h"
+#include "kfd_priv.h"
+#include "kfd_device_queue_manager.h"

 #include <drm/drm_drv.h>
 #include "../amdxcp/amdgpu_xcp_drv.h"
@@ -673,8 +675,31 @@ int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_=
mgr *xcp_mgr, u32 flags)
         * Stop user queues and threads, and make sure GPU is empty of work=
.
         */

-       if (flags & AMDGPU_XCP_OPS_KFD)
+       if (flags & AMDGPU_XCP_OPS_KFD) {
+               int i;
+               struct kfd_node *knode;
+               struct amdgpu_device *adev =3D xcp_mgr->adev;
+
+               if (!amdgpu_in_reset(adev)) {
+                       /* If there still active proccesses or queues, retu=
rn busy */
+                       for (i =3D 0; i < adev->kfd.dev->num_nodes; i++) {
+                               knode =3D adev->kfd.dev->nodes[i];
+                               if (knode->dqm->active_queue_count > 0 ||
+                                               knode->dqm->processes_count=
 > 0) {
+                                       pr_info("kfd process or queues stil=
l active: active_queue_count %d,"
+                                               "processes_count %d, partit=
ion switch abort\n",
+                                               knode->dqm->active_queue_co=
unt,
+                                               knode->dqm->processes_count=
);
+                                       return -EBUSY;
+                               }
+                       }
+
+                       /* Flush process wq. Make sure all user queues and =
threads finished */
+                       kfd_process_wq_flush();
+               }
+
                amdgpu_amdkfd_device_fini_sw(xcp_mgr->adev);
+       }

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index d01ef5ac0766..21fe588ea559 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1547,6 +1547,7 @@ int kfd_send_exception_to_runtime(struct kfd_process =
*p,
                                unsigned int queue_id,
                                uint64_t error_reason);
 bool kfd_is_locked(struct kfd_dev *kfd);
+void kfd_process_wq_flush(void);

 /* Compute profile */
 void kfd_inc_compute_active(struct kfd_node *dev); diff --git a/drivers/gp=
u/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5be28c6c4f6a..d15583dfa0f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1196,6 +1196,12 @@ static void kfd_process_wq_release(struct work_struc=
t *work)
        kfree(p);
 }

+void kfd_process_wq_flush(void)
+{
+    /* expose flush work interface for partition switch */
+       flush_workqueue(kfd_process_wq);
+}
+
 static void kfd_process_ref_release(struct kref *ref)  {
        struct kfd_process *p =3D container_of(ref, struct kfd_process, ref=
);
--
2.43.0

