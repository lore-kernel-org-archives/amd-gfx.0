Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22BED1AD55
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 13:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8606310E6EF;
	Wed, 16 Oct 2024 13:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fYqvBgYe";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE5510E6EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 13:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aD1BH8/o7LNbDTlnEN3CRcKhFS6Z+BCseRuM2ZoWrNAER5B/elMgmqp2POck5yAs1jduP3KQ2tdSA5LdbwNx4MQAX1z3WB2xRgTq2+5xbE141Q7qpHxgtIjtvYuSNRRGxgMyqXQkw2CEpVADWjkGN87voXBjsfJtfZVawhQKEdT5EQ4Z43f9uXXBDLQrYQ3UqIrLP12lg3Xjb2/yMHB2s3bIiIjtsVdpKGBDJQOX0R3dKKWDkKcRtblGcjUhF7liuZ/1jrSQ1dc9LnWKQ8irlSfkWxIdJ/5kDk/5e5EccW/HBsLHUsKjzeu58O05aBcfg7rj36j53bK6giMiPAI38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymt9IPHZz3zFX7cM8BQpMPMOgPg3aOC53jV9OyWCakk=;
 b=vwM5QBunduiQmjx7PEuwdid3GMX/mkPsskqusUvWDM5k4nX6y8sQ864BdxuZIEEoVjjYwkhkLFwvegZLmP9sya1/l3VgKU7LvcOdqMZy2gQC+DxoZ5+WJUUkDVl3j2eK8WyP5Kf0BtekRa9U75CDUOYKqoNk9xlQgR+Z0AvGEZwtAV9+d4ch1zuByqWWBtxNGfZlu6sNryPsKjFQWg5mEEnTPiZSYqKwf6010xittqZNqnQiBhBOBxm8CJ3MtHdvEdscJwWggy7OqYySG3w5d1D125zRgXUrpVf9xrVNyAmP2Z0691KGDH9OG4NgvoNoxZBFITBtXsV7hvtKQnewJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymt9IPHZz3zFX7cM8BQpMPMOgPg3aOC53jV9OyWCakk=;
 b=fYqvBgYefSv4X/+qOd+dHIiwUylUSycGHPlCIBqk4HThByTYazpmhTO/ny7/Ab7nbb2S/jR3zYWjmcMrAOO5M6Gfv2PdNzqlVFQXMoYx4iD3AWB1YLsveBXgnXZqJtaRv1QG3Zlbi2mQzOk/IUyzVzD8wpxd8mZnYQGhbnJaoLY=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 13:13:11 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 13:13:11 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH 01/10] drm/amd/display: temp w/a for dGPU to enter idle
 optimizations
Thread-Topic: [PATCH 01/10] drm/amd/display: temp w/a for dGPU to enter idle
 optimizations
Thread-Index: AQHbHtq8UvpVNuapOEq1RlJW0GJpfbKHyreAgAGQv44=
Date: Wed, 16 Oct 2024 13:13:11 +0000
Message-ID: <CH0PR12MB528426EDBC0B3AC7245202578B462@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
 <20241015081713.3042665-2-Wayne.Lin@amd.com>
 <1284976c-8fc9-4eab-b01e-a8a12790541d@amd.com>
In-Reply-To: <1284976c-8fc9-4eab-b01e-a8a12790541d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-16T13:13:10.912Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|IA1PR12MB8310:EE_
x-ms-office365-filtering-correlation-id: 9ada062e-b21b-4484-b4d2-08dcede4491c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qyMhTRP/WhEoZ0EllZpmBOkfQUDOHpDhczR3cImK5Y1AyWL399itBkOKM25B?=
 =?us-ascii?Q?Dw91HGojEuwIIoaDwvYraEYAX6hOdByT6bKI0DaB0kvGKrYGHGYEglls81+g?=
 =?us-ascii?Q?UBNRfOe0PzrzqqsZF7K961x4nOez9fGpz37VP28SdlwrAyWF/7z8mktBUg+e?=
 =?us-ascii?Q?izomh57u0uMsuAsPwwZll1GRDbkYP6upgdSnq93w+rKrDpyPdKriBZhDtUkF?=
 =?us-ascii?Q?wO4bUFIIj/wqNcH9ul+OJH9w9lNZ7FC3p1HxQjbu0IFN85Qf2j0B1oiVIqmF?=
 =?us-ascii?Q?W0rduh2EZXS9HwqLp6GxzjUnFB1sxE0Eb3eTirRMV9fhLX5BfonHJRYhiN74?=
 =?us-ascii?Q?s62sS0I5LUgCBbFsn2XnP+1wOnWccMkyiFH3ZsiEUky6uO9nS/1wt1+xFHVu?=
 =?us-ascii?Q?ZwLrH7sd/6tfFyxAJoVVnWpvNyfCEnZfs3z/M8YDQToXiVwfHQtJBT9TGeAQ?=
 =?us-ascii?Q?8zvVdBicnue0S3+vqLLbdBFxFOlCQA2O6la4Pj2qmWVoOxC8u98EIi11juZS?=
 =?us-ascii?Q?tu5/BTFkUQZ1YXBajpG9Qt7czsKK+7L8VOXK7vkmupcC6O+KJ841BiPohFaC?=
 =?us-ascii?Q?5fvszsX4m+st0njyclQvusBMUutGtIArnWdT2IRfC76CKn3UDT0tMn6woELB?=
 =?us-ascii?Q?cb3ZJDyUIo025QFZD5Qf204S/3n2cbWdEhZXQr7vMTlT9xMPX3wQV6MJ7UNu?=
 =?us-ascii?Q?aleUYywCm4dSOUjjb2P2m0khbuisZYg6T6Aw/AMzM1n1Q5S4GWmUHT6yI+g9?=
 =?us-ascii?Q?KoCi71RTyaTM1KRRZ8QScsq8B5Gp+hRzNikRNTFlFOUjMM5V1BGOXRNgMUCU?=
 =?us-ascii?Q?uLwuTNKiCnUOH0c/qG4OnMbctqSFrCYWWtEGWZka1Zsmq619JHYIt3Cj2IW7?=
 =?us-ascii?Q?LLdu5xMcMAntN26H/n8QTYEcZqQ0VFcxcKRK7moXf9SfAPJfmZ2p7aOT3VCh?=
 =?us-ascii?Q?aOFnXHNd9qESBFO8Xdaj3b1nYcauX17Msf6ZH+ttbsSpoEv2XgnKlKgF/QgM?=
 =?us-ascii?Q?FxHvyQ/Xcn2yfAhLUey8gPztrZhPpGbLxu3cEAEuFpqRfk7wgGkBDU8GrGgl?=
 =?us-ascii?Q?SifOFRMHZ+SoKHhRk3btGZOaocVr9v9bHC6PYEIkhVOUkAFEiO+8EUaE3WDA?=
 =?us-ascii?Q?TvBPA/Pr0LHkjkkOjtQ+lR2+wPuWIxQFLObMEQCOAgqjfTKWFqsdcTdHDII2?=
 =?us-ascii?Q?S9as7d4sdcn8PJ/F7pISAmYhZNL/fYp0FSyqALWASWuz2juTWWxnhK03CgSZ?=
 =?us-ascii?Q?2tBzY7JbiEXasdh1TaWg92fqW3O4VXqB9zZufGFywQt0PwMegvGrMSn700a7?=
 =?us-ascii?Q?OhmOOvxcgW5sSRMtOO4fwJMuD7VHSxalJOr+RfaqgCcogQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jeiN9nMORA7PHWXzLGNI+JY6jG95hwEj3IL3120Kav6wV9BlxwsVb8/vd++c?=
 =?us-ascii?Q?Du1WThxqqbS4jSfcb2zGmBCXXq5Dwqw9XyxDeAluHEjbtPd8roWLTOespYm9?=
 =?us-ascii?Q?8IvqyYCoe6dUrM2ORB5qG4gyeANQDC9HkOGGRXZ/eNjjmlJkSYu9/3Z4vZoE?=
 =?us-ascii?Q?q424MuZ/xyBm5ZLXujmLIEm1JqKBphb2wVyVrtvytqRoAZpZY2UAfOVykhZo?=
 =?us-ascii?Q?gqfd2NB3EmEulNVL9s7Z/vbfMxMRKcsXUnCACZve9JwuKM3BOW/hXSC/TjgN?=
 =?us-ascii?Q?gOtcyX/6RPVUbPqm2mM2PYTpkH/JmjsJZHAWLqMFp/xs85M43ZlV9z6CBpeC?=
 =?us-ascii?Q?q3jGryl4GgFbj6E9HNTq6pkPYwTR8Xfkhy4oLU6/+cnH4uxm0G0XWrCQ8Yt+?=
 =?us-ascii?Q?3cR3DrOH8IrcmVh5O9jGw86le8PlZaTvuqss0RYk547mL2uZJ5mPPL8jkcGj?=
 =?us-ascii?Q?VFRuPN4uUiv0AB7XEOYd+mwS44Xjfg/q8ACR+nQce3/REseXuGG/5bPDr8fW?=
 =?us-ascii?Q?KBWiqn9ZRiyM1TtJl2kYwHAwEtShUSlPWddYNtsak585akLrPexKTBUHeePz?=
 =?us-ascii?Q?jgul9Jssg/j/f9MxJK4GzVmFk3tYwwToXKpvS3L7ir242EX6682HgEdkPQk6?=
 =?us-ascii?Q?KnWtH4TO6jZxXVTvm8Xncnatvf7k2gSpAIya7nE7+b6b2TJ8bh6/IT7GjoF9?=
 =?us-ascii?Q?9ALP9zqA41DRf0pqpBDclydNsgMebxi8pZTlTONOXK5wDeVWebX5S7+5INvG?=
 =?us-ascii?Q?GMC4tHBmhw6xBTGSOS7aH32yx1aqvMwLxW/V7DHapr2xJzzzyLXFfCzaLSM6?=
 =?us-ascii?Q?i1NikrKPzqUw4hHCXRIo8qV6HOjeF3MP9FqPqKb41a7DGfAetqoRVWaAzOaA?=
 =?us-ascii?Q?aN7sAd2nQFaWGHrU9nx0NSfVQWeJbpgntDZACDl9IEEVRxl5MTIIQhoN4btP?=
 =?us-ascii?Q?4uE/R90xFI9oUFrEpsLG2nUg7vhLVBd2VUBu35cnOqDR0O8LNRzgaGlYs1Ke?=
 =?us-ascii?Q?cMEsxkoeVloUV4lzCXajKhxAybXyc/trod6HOBeRh+sRjUrQFcfUUcdOWB1a?=
 =?us-ascii?Q?FH9H9d8CawOd/Z8oP/9Nu8xYuRSQIeVC09WdaZ8cixwhAO23r+kLfhrR7mcm?=
 =?us-ascii?Q?g1cHoMYwS2BZ495fulOXyrDKHziynx1p30NP+gci3C3AqlEb0Quuvav0RiLJ?=
 =?us-ascii?Q?w89fBacOgR0JK0CwvotY3uDn3Cf8alZx0RvRdr1jJd6fkCxVyM83lpLkdg0v?=
 =?us-ascii?Q?HA7vZDtwl7+9dhVb7rh34Uan3qd8gJe2N+t58xnKiFMD+N0XYHbBuFnQaRO4?=
 =?us-ascii?Q?sgmeLGy2kO7cyptLXBCXWhTG4xgIZCc4pyQrQr8SiLLPaP/Wyffz8O4gEKCQ?=
 =?us-ascii?Q?iOMA3Lanb47vWPlxHEio51+XMEGjntdCiH0sgOtVRXOVP0S91C7PLpN5AHS0?=
 =?us-ascii?Q?LUY0wSQc59WQDCdSYtbYqmhNKhtPoLzoQs6dYDcAaISu/t7lZWAwnV1CD54Q?=
 =?us-ascii?Q?D0ARRPGzQ2gJet5evSIHuq+kWToOYzaQdLqN8sVjM37fYvVKSwGuTUuko0+J?=
 =?us-ascii?Q?7rDLJ8BR/zM1qzB2V1w=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB528426EDBC0B3AC7245202578B462CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ada062e-b21b-4484-b4d2-08dcede4491c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 13:13:11.4108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLKYgYSN5ENL45ZcirrGfQDUMXvLPI6qa13rucvNPx84n2RL0vyCHx0ATEFJRF1E8ODPOzSP6LjmmG4Z0Fj6iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
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

--_000_CH0PR12MB528426EDBC0B3AC7245202578B462CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]


Hi Mario,

Hamza is working on the reported issue and appears to be due to a different=
 root cause. Hence, we're expecting that the fix for that issue is likely g=
oing to be different, with what we know so far. While that issue is being d=
ebugged, this patch will allow us to have better idle power consumption on =
dGPUs


--

Regards,
Jay
________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Tuesday, October 15, 2024 9:14 AM
To: Lin, Wayne <Wayne.Lin@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <H=
amza.Mahfooz@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Ro=
man <Roman.Li@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Z=
uo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Chiu=
, Solomon <Solomon.Chiu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>;=
 Deucher, Alexander <Alexander.Deucher@amd.com>; stable@vger.kernel.org <st=
able@vger.kernel.org>
Subject: Re: [PATCH 01/10] drm/amd/display: temp w/a for dGPU to enter idle=
 optimizations

On 10/15/2024 03:17, Wayne Lin wrote:
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
>
> [Why&How]
> vblank immediate disable currently does not work for all asics. On
> DCN401, the vblank interrupts never stop coming, and hence we never
> get a chance to trigger idle optimizations.
>
> Add a workaround to enable immediate disable only on APUs for now. This
> adds a 2-frame delay for triggering idle optimization, which is a
> negligible overhead.
>
> Fixes: db11e20a1144 ("drm/amd/display: use a more lax vblank enable polic=
y for older ASICs")
> Fixes: 6dfb3a42a914 ("drm/amd/display: use a more lax vblank enable polic=
y for DCN35+")
>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Wayne Lin <wayne.lin@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a4882b16ace2..6ea54eb5d68d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8379,7 +8379,8 @@ static void manage_dm_interrupts(struct amdgpu_devi=
ce *adev,
>                if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>                    IP_VERSION(3, 5, 0) ||
>                    acrtc_state->stream->link->psr_settings.psr_version <
> -                 DC_PSR_VERSION_UNSUPPORTED) {
> +                 DC_PSR_VERSION_UNSUPPORTED ||
> +                 !(adev->flags & AMD_IS_APU)) {
>                        timing =3D &acrtc_state->stream->timing;
>
>                        /* at least 2 frames */

Considering the regression raised [1] is on an APU too I wonder if this
is really the best workaround to approach to this issue.

https://lore.kernel.org/amd-gfx/9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnro=
wley.me/

--_000_CH0PR12MB528426EDBC0B3AC7245202578B462CH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof" style=3D"color: inherit;"><s=
pan style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Hi Ma=
rio,</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hamza is working on the reported issue and appears to be due to a different=
 root cause. Hence, we're expecting that the fix for that issue is likely g=
oing to be different, with what we know so far. While that issue is being d=
ebugged, this patch will allow us
 to have better idle power consumption on dGPUs<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
--</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Limonciello, Mario &l=
t;Mario.Limonciello@amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 15, 2024 9:14 AM<br>
<b>To:</b> Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.c=
om&gt;; Mahfooz, Hamza &lt;Hamza.Mahfooz@amd.com&gt;; Pillai, Aurabindo &lt=
;Aurabindo.Pillai@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Chung,
 ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; Zuo, Jerry &lt;Jerry.Zuo@=
amd.com&gt;; Mohamed, Zaeem &lt;Zaeem.Mohamed@amd.com&gt;; Chiu, Solomon &l=
t;Solomon.Chiu@amd.com&gt;; Wheeler, Daniel &lt;Daniel.Wheeler@amd.com&gt;;=
 Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; stable@vger.kernel.o=
rg
 &lt;stable@vger.kernel.org&gt;<br>
<b>Subject:</b> Re: [PATCH 01/10] drm/amd/display: temp w/a for dGPU to ent=
er idle optimizations</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 10/15/2024 03:17, Wayne Lin wrote:<br>
&gt; From: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
&gt; <br>
&gt; [Why&amp;How]<br>
&gt; vblank immediate disable currently does not work for all asics. On<br>
&gt; DCN401, the vblank interrupts never stop coming, and hence we never<br=
>
&gt; get a chance to trigger idle optimizations.<br>
&gt; <br>
&gt; Add a workaround to enable immediate disable only on APUs for now. Thi=
s<br>
&gt; adds a 2-frame delay for triggering idle optimization, which is a<br>
&gt; negligible overhead.<br>
&gt; <br>
&gt; Fixes: db11e20a1144 (&quot;drm/amd/display: use a more lax vblank enab=
le policy for older ASICs&quot;)<br>
&gt; Fixes: 6dfb3a42a914 (&quot;drm/amd/display: use a more lax vblank enab=
le policy for DCN35+&quot;)<br>
&gt; <br>
&gt; Cc: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
&gt; Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; Cc: stable@vger.kernel.org<br>
&gt; Reviewed-by: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
&gt; Reviewed-by: Rodrigo Siqueira &lt;rodrigo.siqueira@amd.com&gt;<br>
&gt; Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
&gt; Signed-off-by: Wayne Lin &lt;wayne.lin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-<=
br>
&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index a4882b16ace2..6ea54eb5d68d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -8379,7 +8379,8 @@ static void manage_dm_interrupts(struct amdgpu_d=
evice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, DCE_HWIP, 0) &lt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(3, 5, 0) ||<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acrtc_state-&gt;stream-&gt;link=
-&gt;psr_settings.psr_version &lt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_VERSION_UNSUPPORTED) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_VERSION_UNSUPPORTED ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; !(adev-&gt;flags &amp; AMD_IS_APU)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timing =
=3D &amp;acrtc_state-&gt;stream-&gt;timing;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* at l=
east 2 frames */<br>
<br>
Considering the regression raised [1] is on an APU too I wonder if this <br=
>
is really the best workaround to approach to this issue.<br>
<br>
<a href=3D"https://lore.kernel.org/amd-gfx/9b80e957-f20a-4bd7-a40b-2b5f1dec=
f5a4@johnrowley.me/">https://lore.kernel.org/amd-gfx/9b80e957-f20a-4bd7-a40=
b-2b5f1decf5a4@johnrowley.me/</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB528426EDBC0B3AC7245202578B462CH0PR12MB5284namp_--
