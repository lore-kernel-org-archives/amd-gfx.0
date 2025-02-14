Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EE0C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD4010E497;
	Fri, 14 Feb 2025 15:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l2oaQy0m";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE2B10E497
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0FV+3B0+ZQl3sKfjPsceBNdPNup+SezE/swxw+q/skRpoozA69oQk6eqbq5uUmkS8C0bjwwnpN9uQia4Q5DGOEg/DxOF4n49O68hBYoivIBb8XXePc2Up7AAnnOT/6y4pMdtuavFlGvTs3JFJ79V3JIWe/KXut+8/UPlsGpPOo/KJD5FsoTikOJme47cpVWlhcihund9VsBOz2OuTKtxY8whfYGV3B/I7NeEgHrAazIAuHn4Z6PLcGNPzS4GHsJOvtCYF7ovSnzJ/wB6jE8mDDOda0KX8VdzLNKxAhuGRzMLHWvjsFPht5ki7KHC0go3xhDn92WvleuaHXySmJ3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4R9fQA86qCk7p5xCqlinzXjjZ/qAefdziXQYzvKc8gk=;
 b=lMXZpVesueVpp2cqifcV6/YNqQH+XuLPuvHRwwS86BXy5Kp/eu8wHSuhQW11w+eF4fUBxYEBWwdNouscFrkKp3UcXs6YqPycYEtpFM8id56gXEo5MWn42r9ex3+fN6fKT5R1UKUWF3Z4TcQQf2JYfmogrqEf4T2AFJVw67xE/I5KS23Rwxd6gA4KjFwSpz0KQD2b3EIBb6gT61ZoWK+zvnXn8tN0sMnX4h9e8G0IYkKn+1/j2tdnL+k5Z4uGFkdBlwIVldl+gu3Fjh0cYhXyG6AZVXoNrh6zJhU3g2uxe5lX/QkCrhqMOGylxtrTvsFWxoG+OK46DTlI+mqSv0pCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R9fQA86qCk7p5xCqlinzXjjZ/qAefdziXQYzvKc8gk=;
 b=l2oaQy0mdnG7vkx5IJ0os8WHe/lwB4iBDpbc1H+C0BFox8hlHohanCsFSwDTvSi6EjSzGaIRE7TH1ke0aEHvUJSan6QDKDmq0sDunBpwtl1QZbynRHgrj/bEWlOhtrpA9ES64nQQ/QvdgNtbIr8ylWNQGXwW7qSecWEPpCLhwCQ=
Received: from SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 15:11:56 +0000
Received: from SJ1PR12MB6292.namprd12.prod.outlook.com
 ([fe80::745c:1e06:be67:94af]) by SJ1PR12MB6292.namprd12.prod.outlook.com
 ([fe80::745c:1e06:be67:94af%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 15:11:55 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>, "cao, 
 lin" <lin.cao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Replace Mutex with Spinlock for RLCG register
 access to avoid Priority Inversion in SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Replace Mutex with Spinlock for RLCG
 register access to avoid Priority Inversion in SRIOV
Thread-Index: AQHbfr6VMMBSRicNnEy25yicdlMBY7NGgtyAgAAODQCAAEsjbg==
Date: Fri, 14 Feb 2025 15:11:55 +0000
Message-ID: <SJ1PR12MB6292CF8D539E5E3DC11CA6658BFE2@SJ1PR12MB6292.namprd12.prod.outlook.com>
References: <20250214085755.662775-1-srinivasan.shanmugam@amd.com>
 <955a3d4f-06fa-4a4e-85f5-b7b1aadb30bf@amd.com>
 <ad3e75d4-1bca-46f0-9892-5492f292e4ec@amd.com>
In-Reply-To: <ad3e75d4-1bca-46f0-9892-5492f292e4ec@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6292:EE_|IA0PR12MB8253:EE_
x-ms-office365-filtering-correlation-id: 46de3522-30cb-4b0a-6d7e-08dd4d09eb8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?zqrP60Aa9/oO/CxUhQTZvYsQ3PwmOrV21nyRUQPwUGO6wYoFLsLLeG7xnB?=
 =?iso-8859-1?Q?Xr6IV2fhlQ7Dh2FeLjg5k0OPeahATFOQqt5DXWqTlDglM8lPbaGsk+K9G0?=
 =?iso-8859-1?Q?cHUzUxSVHy0K3wYqL+wS1pUkOQS7RE2vcgsLbLHAwhP+EQkF5LRXeVBroL?=
 =?iso-8859-1?Q?4eWH3nMup39PgNDieMJ0kdWMyK1HF3sP79zv65kdB/AQjNWkuj/0ZUMZM9?=
 =?iso-8859-1?Q?EfW+mW04Lft3qR1gI5TOkRaKtI9/1iOdoc36Tbeh+Pkm/krCnuAiH2DTnM?=
 =?iso-8859-1?Q?Ql2nOzfQsjKXqqiVl7RmtTK/TAVI2e7f1wqnUWDJTjQZk2xkUcQ0ZNCgWK?=
 =?iso-8859-1?Q?zLxYIublHmkQb0Jm/ayM6iGvvxWejvM4KhGM5HnbyunMsccVFJi6Uz/Kkp?=
 =?iso-8859-1?Q?A2P+zMKOjiwNXV1tL/3aa+dn/HrT1Ul0oy7QEtlo7w/g/M72cAwndKF0Jo?=
 =?iso-8859-1?Q?WMrZn8VP42TqmycT0m815QUMdjjblZabxqmqbSFKZ6CrfY/G1e/QrW7PXO?=
 =?iso-8859-1?Q?k7YX2uS6LNzewr1XCb9Fj07bwuWveGXxv+MyZV4DwCy3sg9ZNa6kw1yO82?=
 =?iso-8859-1?Q?MQr6S0vCnThVOhyay6HxDteQNpopASazcpaBvjblel4DEDwtWaS2i7mGz7?=
 =?iso-8859-1?Q?6/tfwr9tm0T1RlPmlRopR5se0bBrnZnOkKBjbjeE4fIVUATRHQ+vxfXb9J?=
 =?iso-8859-1?Q?s4HSA0RJIysYtERxBWya/5BN+408u9pVhfGnY6Apb09ibD0sIfKBWYSelg?=
 =?iso-8859-1?Q?SgCnGpSK6jcSeNXI2ambJvBBWYjV3D+gkmSZVG/MsgIpQnvPceq1Tum36M?=
 =?iso-8859-1?Q?BoFgDQUK9erIf7FPFwJn37jGhpdePASFmBr7Tkzdr2vo6ilJHFds63YaKY?=
 =?iso-8859-1?Q?R1s0At4mzXrc3SPOlBxyQc+FURLfpcittAA+CPD4JmVXunnYVZjNtRGIhM?=
 =?iso-8859-1?Q?VNNTeSJsqkr9yoG4YIBfVA9783x6oeoNclhubWaG7R/92uXjN+8tcKx/bL?=
 =?iso-8859-1?Q?uIkqErtpF/IbkuwZ0G6cpPxJN6Kh4/laG4tsz/67deAVYf34asS5TiyjVm?=
 =?iso-8859-1?Q?CHq+HeMxQTY2C8gWUEvsHnt5f/b9zxyHU1Yz7oqVDmK3bdAwBzo70lOYcK?=
 =?iso-8859-1?Q?TxX90wfnCqSOHv7JhDBLvfZMjh+XrzES7CruQRcNji6HHl6IC6Qx7eEP1I?=
 =?iso-8859-1?Q?ZRYRgGozPj1tEYk5O+scqS3I/1CNyWjmFyK5eD6SpB0gBkQYA5xx3kRn9o?=
 =?iso-8859-1?Q?9Yj/CgqKYNhTICoBMaePbmHo1LOXOj4Yf2XxepxltCqmlCaTMMzcGktwPK?=
 =?iso-8859-1?Q?nlDpG1WcKEAJaVm925CBtCC/6UQ3jQiW08p0lxjxdCLc5HmqA20+jWTm2K?=
 =?iso-8859-1?Q?POz7PMSSqo5Iw9UdH0reUXJHO/muzJPhXJ0qzhp63grLD9yvAaOgkXUQwu?=
 =?iso-8859-1?Q?KZf9R3RVDgeddGqRHhGL0HrJx2CWhRXjxJoSHWSfuwBEW3KGFi6/pryHfU?=
 =?iso-8859-1?Q?a/3aIsN1Pa1IwXkH3fi4yo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6292.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v0tZwbj9LqPV2stqJyepJlrmvnJZwbvPbRTnjHNOG1EYrumVS8qK61L9pf?=
 =?iso-8859-1?Q?WsiXj0cKXGCVskBsEpjCtqqj11OhJbkwmC5EGOcMqhKm6YMn/qoEe9SXrv?=
 =?iso-8859-1?Q?UD2Y0cpDYu6VPz11k1ZKSbrcIsKo+TcmVprH5rgs37wY0+dREzVaYwGsyK?=
 =?iso-8859-1?Q?sgTfzbOchZpjJ5m0SKDrcfg/BQJZ3x9u3wMWAR52OckbC2zx7mQPd8wpvM?=
 =?iso-8859-1?Q?ViMWqwMsDmXyI6fSoGx9mmQMMJwMhBZy4KbJV3OUbxNUXJI9qniOEj81Yh?=
 =?iso-8859-1?Q?NtNxNoDG9EjireAv9vHiaEjMZHfR0Ll8/Pxo3uMJPVDQWx6P+jFHYuezoI?=
 =?iso-8859-1?Q?1RcfoGquCtzu8zR7bEPLGe3F2aaxdStMEoWBH3cK05TBuqC5iWTN1fwXBw?=
 =?iso-8859-1?Q?YUlqt07uV4Z5cONHP8ozre+CdG4pI7/rvHH7S0dYUucGsgK02f5wQNP5B3?=
 =?iso-8859-1?Q?taGtrzK8YSnQOomv/AMN2H0+Vk01lFTh+lCqAZmUdDCwVe4b1TD20/G9Th?=
 =?iso-8859-1?Q?B1FTt3R0BI7MYWfICcda0UJFIBbOe7LTf+5I2HiVk4rZQ/x56IYGXEaUxj?=
 =?iso-8859-1?Q?HnOG/QxipNa986Dh6brqcDMD3r2QgOavzDQFAgtYIj97szGM6iXkkOOmP8?=
 =?iso-8859-1?Q?kh52u8Gt+kcJBCKLgxbpSPVvzHM8ITFDiQsEi9EQsOeTH7vlA1HN1vdRgZ?=
 =?iso-8859-1?Q?OdN4+IqAzWPsibmKY/fSCBbVsV6jM32F85/NCR7zr2R+6zfAJM4rrEp93f?=
 =?iso-8859-1?Q?tSul8jpI3yKsjYFdQVFXGqkPw5u+2PBIDWqWBpS0kxgAJeduqrkkenY60A?=
 =?iso-8859-1?Q?ubz+KyOtDJeImNO/tcudEz1iddH5C5xkDIugP0VCcZIVaNtIZNA1utBbvN?=
 =?iso-8859-1?Q?cTgfH49pJJeZP8K2lKSoEWSJEZLyju08JFFshYxcHOLgkWclNVKLdgByTo?=
 =?iso-8859-1?Q?liyvam/NEiW2WF11u3HbpBEBEAzUX2NphSNOItUPWNUytQfbGmLEtE+VEf?=
 =?iso-8859-1?Q?ZeKfLdXpM5nlyG4/UUs6Kg7xJnBaNZGB7eZk33rMYWMHWyMXDEiTr6blP6?=
 =?iso-8859-1?Q?aeZctHjW5f4V1rRuKX9AgSlQz0dXk3Absoipr12l9kEOMf7japVY/YVen1?=
 =?iso-8859-1?Q?SNwAPUg4Mdimbpg6mCt0sSLHB1o4j0jzXkI0DUH1EWMy11aH/qzFAaZr+s?=
 =?iso-8859-1?Q?j6UiKpga7GSGKS4KdegunZqnntR+rM+OTYzZ8k8vkZg5EPsZ/0iRFN+7z3?=
 =?iso-8859-1?Q?dkbFcjznZlUeq69ryuX30ZP9Cej+3mCTL2IR16GIImHUDOeQuf7a2eKG2a?=
 =?iso-8859-1?Q?h4jgCfHg6p1MTv0hXHUiG56ogVgw5gL8KNgXYlFbauy7MpOqGcP6glFj3Z?=
 =?iso-8859-1?Q?4LboKZXHYlNq5y+8aMNj+SJSLP9pCniEYf7k+bk6MfjcSZuSAEaZP4KkAp?=
 =?iso-8859-1?Q?HN5Er5+wKBnxSZtyItNOjrbZyFfCofWwYaOaBPmSDfGYbUF8Nzzy0hTtQ8?=
 =?iso-8859-1?Q?FRIHDIbn/LothLgSTibzKvI5q1rs1jN9ieXovZ5jqr3TKRFs26A0WyteB7?=
 =?iso-8859-1?Q?/mJFv+38b+fSbkiUakKbembu08d3VcfXf44lQb7p3sEgAGEx9L8g0NGawx?=
 =?iso-8859-1?Q?d1fXXPElIcxlc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6292.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46de3522-30cb-4b0a-6d7e-08dd4d09eb8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 15:11:55.8230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iaz8ENim0JhEuugDOlgCZIuP0qicXVeV6Qu5gQJhv1Pdeen38/M/rKvrqFzqd62RS+1/jI/VpqkBbRuit9jxXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
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





>> On 2/14/2025 2:39 PM, Christian K=F6nig wrote:
>>> Am 14.02.25 um 09:57 schrieb Srinivasan Shanmugam:
>>> RLCG Register Access is a way for virtual functions to safely access GP=
U
>>> registers in a virtualized environment., including TLB flushes and
>>> register reads. When multiple threads or VFs try to access the same
>>> registers simultaneously, it can lead to race conditions. By using the
>>> RLCG interface, the driver can serialize access to the registers. This
>>> means that only one thread can access the registers at a time,
>>> preventing conflicts and ensuring that operations are performed
>>> correctly. Additionally, when a low-priority task holds a mutex that a
>>> high-priority task needs, ie., If a thread holding a spinlock tries to
>>> acquire a mutex, it can lead to priority inversion. register access in
>>> amdgpu_virt_rlcg_reg_rw especially in a fast code path is critical.
>>>
>>> The call stack shows that the function amdgpu_virt_rlcg_reg_rw is being
>>> called, which attempts to acquire the mutex. This function is invoked
>>> from amdgpu_sriov_wreg, which in turn is called from
>>> gmc_v11_0_flush_gpu_tlb.
>>>
>>> The warning [ BUG: Invalid wait context ] indicates that a thread is
>>> trying to acquire a mutex while it is in a context that does not allow
>>> it to sleep (like holding a spinlock).
>>>
>>> Fixes the below:
>>>
>>> [  253.013423] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [  253.013434] [ BUG: Invalid wait context ]
>>> [  253.013446] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G    =
 U     OE
>>> [  253.013464] -----------------------------
>>> [  253.013475] kworker/0:1/10 is trying to lock:
>>> [  253.013487] ffff9f30542e3cf8 (&adev->virt.rlcg_reg_lock){+.+.}-{3:3}=
, at: amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
>>> [  253.013815] other info that might help us debug this:
>>> [  253.013827] context-{4:4}
>>> [  253.013835] 3 locks held by kworker/0:1/10:
>>> [  253.013847]  #0: ffff9f3040050f58 ((wq_completion)events){+.+.}-{0:0=
}, at: process_one_work+0x3f5/0x680
>>> [  253.013877]  #1: ffffb789c008be40 ((work_completion)(&wfc.work)){+.+=
.}-{0:0}, at: process_one_work+0x1d6/0x680
>>> [  253.013905]  #2: ffff9f3054281838 (&adev->gmc.invalidate_lock){+.+.}=
-{2:2}, at: gmc_v11_0_flush_gpu_tlb+0x198/0x4f0 [amdgpu]
>>> [  253.014154] stack backtrace:
>>> [  253.014164] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G     U=
     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
>>> [  253.014189] Tainted: [U]=3DUSER, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MO=
DULE
>>> [  253.014203] Hardware name: Microsoft Corporation Virtual Machine/Vir=
tual Machine, BIOS Hyper-V UEFI Release v4.1 11/18/2024
>>> [  253.014224] Workqueue: events work_for_cpu_fn
>>> [  253.014241] Call Trace:
>>> [  253.014250]  <TASK>
>>> [  253.014260]  dump_stack_lvl+0x9b/0xf0
>>> [  253.014275]  dump_stack+0x10/0x20
>>> [  253.014287]  __lock_acquire+0xa47/0x2810
>>> [  253.014303]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [  253.014321]  lock_acquire+0xd1/0x300
>>> [  253.014333]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
>>> [  253.014562]  ? __lock_acquire+0xa6b/0x2810
>>> [  253.014578]  __mutex_lock+0x85/0xe20
>>> [  253.014591]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
>>> [  253.014782]  ? sched_clock_noinstr+0x9/0x10
>>> [  253.014795]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [  253.014808]  ? local_clock_noinstr+0xe/0xc0
>>> [  253.014822]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
>>> [  253.015012]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [  253.015029]  mutex_lock_nested+0x1b/0x30
>>> [  253.015044]  ? mutex_lock_nested+0x1b/0x30
>>> [  253.015057]  amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
>>> [  253.015249]  amdgpu_sriov_wreg+0xc5/0xd0 [amdgpu]
>>> [  253.015435]  gmc_v11_0_flush_gpu_tlb+0x44b/0x4f0 [amdgpu]
>>> [  253.015667]  gfx_v11_0_hw_init+0x499/0x29c0 [amdgpu]
>>> [  253.015901]  ? __pfx_smu_v13_0_update_pcie_parameters+0x10/0x10 [amd=
gpu]
>>> [  253.016159]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [  253.016173]  ? smu_hw_init+0x18d/0x300 [amdgpu]
>>> [  253.016403]  amdgpu_device_init+0x29ad/0x36a0 [amdgpu]
>>> [  253.016614]  amdgpu_driver_load_kms+0x1a/0xc0 [amdgpu]
>>> [  253.017057]  amdgpu_pci_probe+0x1c2/0x660 [amdgpu]
>>> [  253.017493]  local_pci_probe+0x4b/0xb0
>>> [  253.017746]  work_for_cpu_fn+0x1a/0x30
>>> [  253.017995]  process_one_work+0x21e/0x680
>>> [  253.018248]  worker_thread+0x190/0x330
>>> [  253.018500]  ? __pfx_worker_thread+0x10/0x10
>>> [  253.018746]  kthread+0xe7/0x120
>>> [  253.018988]  ? __pfx_kthread+0x10/0x10
>>> [  253.019231]  ret_from_fork+0x3c/0x60
>>> [  253.019468]  ? __pfx_kthread+0x10/0x10
>>> [  253.019701]  ret_from_fork_asm+0x1a/0x30
>>> [  253.019939]  </TASK>
>>>
>>> Fixes: e864180ee49b ("drm/amdgpu: Add lock around VF RLCG interface")
>>> Cc: lin cao mailto:lin.cao@amd.com
>>> Cc: Jingwen Chen mailto:Jingwen.Chen2@amd.com
>>> Cc: Victor Skvortsov mailto:victor.skvortsov@amd.com
>>> Cc: Zhigang Luo mailto:zhigang.luo@amd.com
>>> Cc: Christian K=F6nig mailto:christian.koenig@amd.com
>>> Cc: Alex Deucher mailto:alexander.deucher@amd.com
>>> Signed-off-by: Srinivasan Shanmugam mailto:srinivasan.shanmugam@amd.com
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 9 +++++++--
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 3 ++-
>>>  3 files changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
>>> index eab530778fbd..14125cc3a937 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4251,7 +4251,6 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
>>>  	mutex_init(&adev->grbm_idx_mutex);
>>>  	mutex_init(&adev->mn_lock);
>>>  	mutex_init(&adev->virt.vf_errors.lock);
>>> -	mutex_init(&adev->virt.rlcg_reg_lock);
>>>  	hash_init(adev->mn_hash);
>>>  	mutex_init(&adev->psp.mutex);
>>>  	mutex_init(&adev->notifier_lock);
>>> @@ -4277,6 +4276,7 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
>>>  	spin_lock_init(&adev->se_cac_idx_lock);
>>>  	spin_lock_init(&adev->audio_endpt_idx_lock);
>>>  	spin_lock_init(&adev->mm_stats.lock);
>>> +	spin_lock_init(&adev->virt.rlcg_reg_lock);
>>>  	spin_lock_init(&adev->wb.lock);
>>>
>>>  	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.c
>>> index 2056efaf157d..073fc34e43eb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> @@ -1038,7 +1038,11 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device=
 *adev, u32 offset, u32 v, u32 f
>>>  	scratch_reg2 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->s=
cratch_reg2;
>>>  	scratch_reg3 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->s=
cratch_reg3;
>>>
>>> -	mutex_lock(&adev->virt.rlcg_reg_lock);
>>> +	/* Try to acquire the lock without blocking */
>>> +	if (!spin_trylock(&adev->virt.rlcg_reg_lock)) {
>>
>> That is clearly not going to work, you really need to block here.
>>
>>> +		dev_err(adev->dev, "Failed to acquire rlcg_reg_lock, aborting regist=
er access!\n");
>>> +		return 0;
>>> +	}
>>>
>>>  	if (reg_access_ctrl->spare_int)
>>>  		spare_int =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spa=
re_int;
>>> @@ -1097,7 +1101,8 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device =
*adev, u32 offset, u32 v, u32 f
>>>
>>>  	ret =3D readl(scratch_reg0);
>>>
>>> -	mutex_unlock(&adev->virt.rlcg_reg_lock);
>>> +	/* Unlock the spinlock after the critical section is complete */
>>> +	spin_unlock(&adev->virt.rlcg_reg_lock);
>>>
>> Please drop those comments. Never document what is done, but only why.
>>
>> Question is can that be used from interrupt context as well? I think yes=
, so we even need to use the spinlock_irqsafe variant here.
>>
>> Regards,
>> Christian.
>
> Thanks a lot Christian for your feedbacks!
> Hi SRIOV team (Victor Skvortsov/ Zhigang Luo), Could you please confirm, =
if blocking is acceptable, then I can change to "spin_lock(&adev->virt.rlcg=
_reg_lock); & spin_unlock();" & further if this function is called interrup=
t context, then I can change this to
> spin_lock_irqsave(&adev->virt.rlcg_reg_lock, flags); & spin_unlock_irqres=
tore(), so that this disable interrupts while the spinlock is held, prevent=
ing any interrupt handlers from preempting the thread & trying to acquire t=
he same lock.
> Best Regards,
> Srini
>

I agree with Christian, this must be a blocking call. This interface is ena=
bled only during VF HW init, so normally we never expect it to be called fr=
om interrupt context. However, since interrupt handlers are enabled towards=
 the end of HW init (late_hw_init, while VF is still in full access), I thi=
nk it's theoretically possible? I would use spin_lock_irqsave() to be safe.

Thanks,
Victor

>>>
>>>
>>>
>>>  	return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.h
>>> index 270a032e2d70..0f3ccae5c1ab 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>> @@ -279,7 +279,8 @@ struct amdgpu_virt {
>>>  	/* the ucode id to signal the autoload */
>>>  	uint32_t autoload_ucode_id;
>>>
>>> -	struct mutex rlcg_reg_lock;
>>> +	/* Spinlock to protect access to the RLCG register interface */
>>> +	spinlock_t rlcg_reg_lock;
>>>
>>>  	union amd_sriov_ras_caps ras_en_caps;
>>>  	union amd_sriov_ras_caps ras_telemetry_en_caps;

