Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0407C28CF5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 15:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF3110E595;
	Wed, 26 Jan 2022 15:32:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 792A210E3C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 15:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6TMrdaS0lLFxPhNhMINsHlwPOCHTj21ZaliJxjbvr8hDN/Xd4xmA5jNrHz9JvlbPhR77zsfXdFzLrGu9qT+4HoWMHIwR6p+jpYY/LoKx2p8apVbKznvDntoG65/aod2ob0HoznE1VoQSc01TU5PqNT7EZqTVqxabFgtY8B8ZFbxpQlQIiAoiLZsqdOtzTlugcr5qHJTF9/PXFiQxqZzH4KwsVJqPlUNz7CF56u3Agc955+pxnImDp1fM/UKfNyfiQ70LVTYhgRhitbpeXX6z5Q8zTS7C0MdBpMpQe7PiRs4OyZph8eKVZR1gfCFUQxgP1ACnTYxIyGldv95+/HkSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eO1gpkBDv3IQjr1K7yr4NWzzHlHJPjv8UYGnkeZXvhU=;
 b=TYmXKMNjmUR6rEEWhhlAVn7rx/bfD25FIXvjHPw11nUiSwCSJ764iIafSmlRysz3JmltE4calMYU9w2ZnNL1n75QNgwWmWrdNPQmV69QAc9ba9Mek4t0JnKLtyTOfxWTnLpR89inbFGZQMD2KaswMF8XD2HdnPUplMQbBMckAMuSutEKc9gpuibnauvV7raZrX0rdppCBPWGHsBXWfMQwUok46xuv1u/UZrXFHoQd5Wb4UGSCXpQit6rMRdZfwail1/Tg14sm6GSQOazwQ9Exxm4w9065xOQWlwC5FvxTRSUuaATT9wbz1plEBlMNig+yYsUEBYqcDEQuWr5yBu6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eO1gpkBDv3IQjr1K7yr4NWzzHlHJPjv8UYGnkeZXvhU=;
 b=VL5PYsiC0YF/Reiyh6e8sG9J8vgkXsKw7xiUoidhA1i8dg68RJSIioUVaLZ3o0tdvusLMdESigGh09WtJQTUvTqElf4T2fOQxA5Kmh2V9hod1E05FGcgfKSFzokelU5IQ9toE7kbjtRQQ3ItBTiFA4v/DSZvCZ64EsivBRnT00g=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 15:32:38 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 15:32:38 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v5 2/4] drm/amd: add support to check whether the system
 is set to s3
Thread-Topic: [PATCH v5 2/4] drm/amd: add support to check whether the system
 is set to s3
Thread-Index: AQHYEmqSHwh5iWHEIUyIlQG0NjKWVqx1Z7LAgAAAVgCAAABYUIAAAliAgAADSVg=
Date: Wed, 26 Jan 2022 15:32:38 +0000
Message-ID: <BYAPR12MB4614586B64F8A716DE4D987597209@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220126040944.4324-1-mario.limonciello@amd.com>
 <20220126040944.4324-2-mario.limonciello@amd.com>
 <BYAPR12MB46142C4338D620EE1F7977FB97209@BYAPR12MB4614.namprd12.prod.outlook.com>
 <BL1PR12MB5157001FFC7CC78C6AA12DF4E2209@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BYAPR12MB46143045A2226B863E1CCB2997209@BYAPR12MB4614.namprd12.prod.outlook.com>
 <BL1PR12MB515774822861EC1850C31F98E2209@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB515774822861EC1850C31F98E2209@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-26T15:07:26.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0; MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aacdeb7-1c11-422e-5112-08d9e0e115bf
x-ms-traffictypediagnostic: BY5PR12MB4306:EE_
x-microsoft-antispam-prvs: <BY5PR12MB43061612C069165C3FA7D61F97209@BY5PR12MB4306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 75eQL9cYiapsnsj6zDsEvf3VuCXDJ7DzNcgEpsFhLVBVGFk7eiK8QAshjX5pvosgYwXofmwM0kTswVklJNARRJhPcaHsN8nsv9vBls6MmUo5IUxA7UsPemCkpUS6XM8NiOZuJabrBow2w39FoxE613HyKrWIVnHmfYKwylbEtC7+Zgn+SDeKc1UpBzCeJh34y44dySlBHm1QiJOkRSp9KS2YJ9WBwlcaeX7ZTkLshSS27AgyM6W4NOorCB2jd340iiy3/kdX5/uKDILYeGTXJ3m6B8SwC0yxFFLD4r05ZZl6Q2ww0bA1gnIQ1TACI+QraSbpshIUUJhUG9AP/dBWD/FTBgyWlj+IKxA1N/rykDJ8wLe/5iE5yXpMb4PjCBGk+jaMJ+YEnWbpIPlpvEsd7RjBGslwybaIV6fV2W+8ZBKsv4BnlzplfCeXSZ66gLRSETQ7o+KxWygWiLkK/g/K9Tw5hdEeHHykz5v1VfIUA3put+DTMg1mbtaSVcKy/xLUQT5CNfoMgbh0PAuRdrxaG5730Xs+EG9SBndkWvp8CUVdfMkDJ7dkB6H141t5EyO/q48YhSbCsnpc+oouWQSLvO10Z5RlE+oswfcq7BD9HWnie9svK4ZvH8Tytvv9HjOe8Kj7OpVjBI4YeXfyjr9BmDIz1a+BBFerb3EeeR/xAjAD8FdFLpgKp5nZgq4jF7xnCZEpY0sYEQQ3SGHFbZYQfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(2906002)(19627235002)(5660300002)(8936002)(8676002)(4326008)(7696005)(316002)(52536014)(9686003)(110136005)(6506007)(26005)(186003)(38070700005)(55016003)(508600001)(53546011)(71200400001)(83380400001)(33656002)(122000001)(38100700002)(76116006)(66556008)(66946007)(91956017)(64756008)(66446008)(66476007)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?DSvcAh/C2ixY/+tqhsCe5clx2WjNpBMk//e2nK3Hy8JdvmUeoKzBoOz6?=
 =?Windows-1252?Q?vIiJTzDuJ9C5HpvVEoD70pV3QYY5rC6Fm3B2SytOhRxPxK6gIwMytag/?=
 =?Windows-1252?Q?0pfNIY1+T7i/2ys6MbIBuvfbFRrTU8JRqG3KcUI/5k3Vw+qMKg/D3mtd?=
 =?Windows-1252?Q?REQpJchcPlR6dmOB5YQYGYAsbQvwWnU6OhGmk5xDpy6AFZgYIAq/ZcyE?=
 =?Windows-1252?Q?zIUI2/GuUYeTausXL7/sq6fPCvcf7clAUkj3YbAelkI5LIbk7TjlQH38?=
 =?Windows-1252?Q?+s3yM02ew72AFLF95ba3mwcMTn3KK+66w74hzs1MdZIgDJxiQNsC0Qr/?=
 =?Windows-1252?Q?ZTTChRwiizhQiPGfmNGAySLsin1AQUswlTDaNI5wO9IeqlHADdWvJDFt?=
 =?Windows-1252?Q?t4zLnuUy78mqQhNVyAOVh09AOgYUPK62cIAfzxsiTZVEJK/XYINBDJzq?=
 =?Windows-1252?Q?JYn9WBeEWWQXUdsHqKHnnSwxS8I0jT5eSBF0+Pty1nqfu32SYEAmor5M?=
 =?Windows-1252?Q?pHLEtOXPVZefV7BEWM2zklESdSV2PHcJteYGYH0aZxUB0oi7sVMRh0I6?=
 =?Windows-1252?Q?6OqXaVo90JrecQH6kyoqSLCU82xzvaIykOk5e4i1JKTq2niZ5e+QjWC/?=
 =?Windows-1252?Q?FeFvmlMjv/5jytmNScaOtLLAq/JkW9QzTpyyyDQcg+kAlRgnsXFCF1f3?=
 =?Windows-1252?Q?HZmcsMk9n9sh5HZC7PWWbEcxc0bHx4eIVSxDdESsyONwrilF5J0hGC07?=
 =?Windows-1252?Q?HPQwIlaicObKfTRa2CZFnj2bQYKMrYKMocMC9WdW7WYJvQphwdwxZnQd?=
 =?Windows-1252?Q?CUYSXTaCeLXzLlxtegKWWtdxfu4ep0sq01xyZLWzFMEK2hxfAsFJPMiv?=
 =?Windows-1252?Q?+ZUoN5CAgxxiHbY9GNxGPfJ8KxIcjp3yMRetl0DO5a8TMUM5kPoJ1/ZX?=
 =?Windows-1252?Q?4LXSegKNDVs8HalYEPi5V1pqCdf23enWOxiKgPnfQJmDAXN2cj6fUu0N?=
 =?Windows-1252?Q?ex9/f/UcvZUXk5Zz1tWB/L/yXgpK4cON1MA1wGINnE8nX2jDVjkzGVi1?=
 =?Windows-1252?Q?b2m0UtlJ4M6lKO5i3DyOFSxRYaxg3+CD+AiDHrXZDI6W/x0K37rbTHXG?=
 =?Windows-1252?Q?Awd5TRIGzKp85VcIu7N3Ao3GOo0igEnAxr0PR36bWO4gHJDqcfmuskqK?=
 =?Windows-1252?Q?WW3logZz2z1uZZ0ZZA0XjnjsXs+ua5MSnp+LGXpIxozbao9MiuUXRwro?=
 =?Windows-1252?Q?OjhFUHbaOuHb6uxCDtEmZXABuOEWR0633U1Ysw9c9uwQSR0i5zMn8Tx4?=
 =?Windows-1252?Q?/Qabml+SF4rX0tl/l1azcEVLtgP3YafHOTD3w58GBmo0gyQBzQCoZbh7?=
 =?Windows-1252?Q?Ua1YTsErPNkc6SPrkO9PbCOtTkxofrVibW6bLJOjyVBoduaZeCrfMn0L?=
 =?Windows-1252?Q?Ztmk3hYxq/iLI0n8X98+EAf1PCrqmuNRa1lC9LDIzac+CWvJwea/1GGa?=
 =?Windows-1252?Q?8Ycb2bGnLaREbysFNmKi50gk403xlY/1ParTBsUdFcFTEc86lCAWKtgT?=
 =?Windows-1252?Q?RStN0607emTDWUUOx2rlQTyuOnVNfjC3TAoZnJcwUjVgU6dhZT5oU9Zo?=
 =?Windows-1252?Q?UyKI8Ghj2XO4nxKK2vI3ACmmoENSHUtBS/2aYz0DqDAluHnKbV2pCXp7?=
 =?Windows-1252?Q?iELiAr2drzoHZ1Qi8lV6XP6aXpYk/1Lu?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB4614586B64F8A716DE4D987597209BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aacdeb7-1c11-422e-5112-08d9e0e115bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 15:32:38.6133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rvhdsvV3g7IHP1p0+flXkPqWzY9H4RRDEbF6UbezT/hrXj33qVqgU/mKxiL9Fazk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
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
Cc: "Liang, Prike" <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB4614586B64F8A716DE4D987597209BYAPR12MB4614namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

I remember Alex adding a patch for smart suspend such that it skips the sus=
pend call if runtime pm suspended.

In summary, the resume doesn't work with/without reset?

Thanks,
Lijo
________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Wednesday, January 26, 2022 8:47:05 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Liang, Prike <Prike.Liang@amd.com>
Subject: RE: [PATCH v5 2/4] drm/amd: add support to check whether the syste=
m is set to s3


[Public]



Right -from an API perspective both amdgpu_acpi_is_s0ix_active and amdgpu_a=
cpi_is_s3_active are only in suspend ops.



But so coming back to the 4th patch (and the associated bug), what is suppo=
sed to happen with a dGPU on an Intel system that does s2i?

For AMD APU w/ dGPU in the system doing s2i I would expect that power rails=
 have been cut off for the dGPU so putting it into S3 and doing a reset mak=
es sense, but I don=92t know about on an Intel system if that is logical.

It seems like Intel expects more that the card is going to be in runtime pm=
 and putting it into S3 and doing reset might not be the right move.



From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, January 26, 2022 09:11
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Liang, Prike <Prike.Liang@amd.com>
Subject: Re: [PATCH v5 2/4] drm/amd: add support to check whether the syste=
m is set to s3



Talking from generic API perspective - S3 is considered active for dGPU onl=
y if it's going to non-S0 state. If called from anywhere else than suspend =
op, this should return false.



Thanks,
Lijo

________________________________

From: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciell=
o@amd.com>>
Sent: Wednesday, January 26, 2022 8:37:28 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
Subject: RE: [PATCH v5 2/4] drm/amd: add support to check whether the syste=
m is set to s3



[Public]



That was intentional =96 shouldn=92t dGPU always be going through S3 path c=
urrently?



From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Wednesday, January 26, 2022 09:06
To: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg>
Cc: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>; Limonci=
ello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@amd.com>>
Subject: Re: [PATCH v5 2/4] drm/amd: add support to check whether the syste=
m is set to s3



[Public]



Returns true for dGPU always. Better to keep the whole check under somethin=
g like this.



if (pm_suspend_target_state !=3D PM_SUSPEND_ON)



Thanks,
Lijo

________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Mario Limonciello <mario.limonciello@=
amd.com<mailto:mario.limonciello@amd.com>>
Sent: Wednesday, January 26, 2022 9:39:42 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>; Limonci=
ello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@amd.com>>
Subject: [PATCH v5 2/4] drm/amd: add support to check whether the system is=
 set to s3



This will be used to help make decisions on what to do in
misconfigured systems.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com<mailto:mario.li=
monciello@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 3bc76759c143..f184c88d3d4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1409,11 +1409,13 @@ int amdgpu_acpi_smart_shift_update(struct drm_devic=
e *dev, enum amdgpu_ss ss_sta
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);

 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)=
;
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 void amdgpu_acpi_detect(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0;=
 }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { =
return false };
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) =
{ return false; }
 static inline void amdgpu_acpi_detect(void) { }
 static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { re=
turn false; }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c
index 2531da6cbec3..df673062bc03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1031,6 +1031,23 @@ void amdgpu_acpi_detect(void)
         }
 }

+/**
+ * amdgpu_acpi_is_s3_active
+ *
+ * @adev: amdgpu_device_pointer
+ *
+ * returns true if supported, false if not.
+ */
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
+{
+#if IS_ENABLED(CONFIG_SUSPEND)
+       return !(adev->flags & AMD_IS_APU) ||
+               pm_suspend_target_state =3D=3D PM_SUSPEND_MEM;
+#else
+       return false;
+#endif
+}
+
 /**
  * amdgpu_acpi_is_s0ix_active
  *
--
2.25.1

--_000_BYAPR12MB4614586B64F8A716DE4D987597209BYAPR12MB4614namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
I remember Alex adding a patch for smart suspend such that it skips the sus=
pend call if runtime pm suspended.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
In summary, the resume doesn't work with/without reset?</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Limonciello, Mario &l=
t;Mario.Limonciello@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 8:47:05 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH v5 2/4] drm/amd: add support to check whether th=
e system is set to s3</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
p.x_xmsonormal, li.x_xmsonormal, div.x_xmsonormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
p.x_xmsipheaderc10f11a2, li.x_xmsipheaderc10f11a2, div.x_xmsipheaderc10f11a=
2
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle20
	{font-family:"Calibri",sans-serif;
	color:windowtext}
p.x_msipheaderc10f11a2, li.x_msipheaderc10f11a2, div.x_msipheaderc10f11a2
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"purple" style=3D"word-wrap:br=
eak-word">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:green">[Public=
]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Right -from an API perspective both amdgpu_acpi_is=
_s0ix_active and amdgpu_acpi_is_s3_active are only in suspend ops.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">But so coming back to the 4<sup>th</sup> patch (an=
d the associated bug), what is
<i>supposed</i> to happen with a dGPU on an Intel system that does s2i?&nbs=
p; </p>
<p class=3D"x_MsoNormal">For AMD APU w/ dGPU in the system doing s2i I woul=
d expect that power rails have been cut off for the dGPU so putting it into=
 S3 and doing a reset makes sense, but I don=92t know about on an Intel sys=
tem if that is logical.</p>
<p class=3D"x_MsoNormal">It seems like Intel expects more that the card is =
going to be in runtime pm and putting it into S3 and doing reset might not =
be the right move.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt=
; <br>
<b>Sent:</b> Wednesday, January 26, 2022 09:11<br>
<b>To:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v5 2/4] drm/amd: add support to check whether th=
e system is set to s3</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">Talking from generic API perspective - S3 is considered active for d=
GPU only if it's going to non-S0 state. If called from anywhere else than s=
uspend op, this should return false.</span></p>
</div>
<div id=3D"x_ms-outlook-mobile-signature">
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<p class=3D"x_MsoNormal">Thanks,<br>
Lijo</p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Limonciello, Mario &lt;<a href=3D"mailto:Mario.Li=
monciello@amd.com">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 8:37:28 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH v5 2/4] drm/amd: add support to check whether th=
e system is set to s3</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<p class=3D"x_xmsipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font=
-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:green">[Publi=
c]</span></p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p class=3D"x_xmsonormal">That was intentional =96 shouldn=92t dGPU always =
be going through S3 path currently?</p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_xmsonormal"><b>From:</b> Lazar, Lijo &lt;<a href=3D"mailto:Li=
jo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;
<br>
<b>Sent:</b> Wednesday, January 26, 2022 09:06<br>
<b>To:</b> Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonciello@amd.c=
om">Mario.Limonciello@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;; Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonci=
ello@amd.com">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH v5 2/4] drm/amd: add support to check whether th=
e system is set to s3</p>
</div>
</div>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:green">[Public]</span></p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<div>
<p class=3D"x_xmsonormal" style=3D"background:white"><span style=3D"color:#=
212121">Returns true for dGPU always. Better to keep the whole check under =
something like this.</span></p>
</div>
<div>
<p class=3D"x_xmsonormal" style=3D"background:white"><span style=3D"color:#=
212121">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_xmsonormal" style=3D"background:white"><span style=3D"color:#=
212121">if (pm_suspend_target_state !=3D PM_SUSPEND_ON)</span></p>
</div>
<div id=3D"x_x_ms-outlook-mobile-signature">
<div>
<p class=3D"x_xmsonormal">&nbsp;</p>
</div>
<p class=3D"x_xmsonormal">Thanks,<br>
Lijo</p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"x_xmsonormal"><b><span style=3D"color:black">From:</span></b><s=
pan style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@li=
sts.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behal=
f of Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@amd.com">mar=
io.limonciello@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 9:39:42 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;; Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonci=
ello@amd.com">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH v5 2/4] drm/amd: add support to check whether the sy=
stem is set to s3</span>
</p>
<div>
<p class=3D"x_xmsonormal">&nbsp;</p>
</div>
</div>
<p class=3D"x_xmsonormal" style=3D"margin-bottom:12.0pt">This will be used =
to help make decisions on what to do in<br>
misconfigured systems.<br>
<br>
Signed-off-by: Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@am=
d.com">mario.limonciello@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 +++++++++++++++++<br>
&nbsp;2 files changed, 19 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 3bc76759c143..f184c88d3d4f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1409,11 +1409,13 @@ int amdgpu_acpi_smart_shift_update(struct drm_devic=
e *dev, enum amdgpu_ss ss_sta<br>
&nbsp;int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);=
<br>
&nbsp;<br>
&nbsp;void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *=
caps);<br>
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);<br>
&nbsp;bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_acpi_detect(void);<br>
&nbsp;#else<br>
&nbsp;static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { retu=
rn 0; }<br>
&nbsp;static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }<b=
r>
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { =
return false };<br>
&nbsp;static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *a=
dev) { return false; }<br>
&nbsp;static inline void amdgpu_acpi_detect(void) { }<br>
&nbsp;static inline bool amdgpu_acpi_is_power_shift_control_supported(void)=
 { return false; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c<br>
index 2531da6cbec3..df673062bc03 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
@@ -1031,6 +1031,23 @@ void amdgpu_acpi_detect(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
+/**<br>
+ * amdgpu_acpi_is_s3_active<br>
+ *<br>
+ * @adev: amdgpu_device_pointer<br>
+ *<br>
+ * returns true if supported, false if not.<br>
+ */<br>
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)<br>
+{<br>
+#if IS_ENABLED(CONFIG_SUSPEND)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !(adev-&gt;flags &amp; AMD_IS_=
APU) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_suspend_target_state =3D=3D PM_SUSPEND_MEM;<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+#endif<br>
+}<br>
+<br>
&nbsp;/**<br>
&nbsp; * amdgpu_acpi_is_s0ix_active<br>
&nbsp; *<br>
-- <br>
2.25.1</p>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB4614586B64F8A716DE4D987597209BYAPR12MB4614namp_--
