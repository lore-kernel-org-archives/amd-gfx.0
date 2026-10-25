Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE6E606A31A
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Oct 2026 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ca+VCNsP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F7E010E271;
	Sun, 25 Oct 2026 18:23:13 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C83510E271
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 18:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wcpa4NYRlao2nzWGcVuFDPlsaSrFF04phiTNKz3uUL3o7JhMnaSS5wri/WfDilzAwRQpwJWuWeCLO3/0Zd+9/soAHMdVuL0MWvIkvvxEGJipIeO5oS3Ygb0O0c7efZTmCEKLf+G86yvQwW4kQWPdZ1gzqovvwcZUBRUF0hTgBYydqSFs8TDSGRKx4n27ncVfhDzvi214W0M06X/wa5r2s18gzDOrVuEmdR+LAJC14PylN7QwGdDxunNi4m0LSrsk/l3SsFXdDL5rUSgyA6dqAyUExDddf6bmE0dKXgUTYQMxhWPDoWmOoo9/JXnhakL2KhAax/4amb4k4ry1k9LrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qca0z/gujvEQpPWrB2LqmwtW8quIwWVpJE5hKKrKYPA=;
 b=rMWIqy85am5u14p+2aNfe+b+VTs3bEFzQ8GN2g8/xZilJO+Tk4H0QCCxa2TGJ/BmxZT6Pp6CUhqh/MFqn/r/aqB91n98+I+3wkAGRHeoYqiSanGMOeTXV5z2bmjEhp3PR34aLWdBi3YYx2uMqdujfcrBmEHH/PG0QHxCSRjXp2z1bDRiWl8rSOVuxl31+lBJGolbuBO6wl/xt2ksQsfxPiWW2F3jSogozTGtBTfJnCAr08DHLG73ZdP/XLxZEr+E3yfe30t7FJpcdrvKcEs1bWhm5elQnnZgMa2Q10aKpLgk8T0yGAVuo2FHz71TRnzIM5DBIWqiGpHAYtm2e1MTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qca0z/gujvEQpPWrB2LqmwtW8quIwWVpJE5hKKrKYPA=;
 b=ca+VCNsP5SP9Yv5kEAzh5qM+Ly5CvP7O1oXrnIVln57k4B1pnuAiBDPrIBCvGs7B2gGJg/h+4ejK5JQOJkxtvjSgxz1GzZCi09TMj+Um+eITwIK3p/j3NWWyuegqrskTM55GRmLdisB7qHBQxdtdaA7UNcxLjFAWIul00c5tkVQ=
Received: from IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sun, 25 Oct
 2026 18:22:56 +0000
Received: from IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522]) by IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522%6]) with mapi id 15.21.0546.019; Sun, 25 Oct 2026
 18:22:56 +0000
From: "Hosur, Priya" <Priya.Hosur@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>, "Hosur, Priya"
 <Priya.Hosur@amd.com>
Subject: RE: [PATCH v2 1/1] drm/amd/pm: restore the forced performance level
 after a reset
Thread-Topic: [PATCH v2 1/1] drm/amd/pm: restore the forced performance level
 after a reset
Thread-Index: AQHdVxF5LzXLExPlPUWRugi8Q6qB67b+Y4uggAANTACAADmQgIAQAoBg
Date: Sun, 25 Oct 2026 18:22:55 +0000
Message-ID: <IA0PR12MB889563329894C157B6C9D103F3622@IA0PR12MB8895.namprd12.prod.outlook.com>
References: <20261008104026.4102222-1-Priya.Hosur@amd.com>
 <20261008104026.4102222-2-Priya.Hosur@amd.com>
 <IA0PR12MB8895E6CA7AF1D2988800EDBBF39C2@IA0PR12MB8895.namprd12.prod.outlook.com>
 <PHXPR12MB99925592BB90114CEA6F2A6071939C2@PHXPR12MB999255.namprd12.prod.outlook.com>
 <IA0PR12MB88950E1FD00B0A333FB78062F39C2@IA0PR12MB8895.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB88950E1FD00B0A333FB78062F39C2@IA0PR12MB8895.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-15T09:37:48.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8895:EE_|MW3PR12MB4492:EE_
x-ms-office365-filtering-correlation-id: 017693c3-9925-4ebb-3143-08df32c4fda2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|3023799007|921020|11063799006|56012099006|4143699003|10067099003|261009221227099003|261009223027099003|261022105027099003|261021121427099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: 5wnvhhAvI0n942lAdKnXe2LHiGBkQk3K9IJbqbbUwoE8VR7HuIsC4TqHsJsUyTiOiVbvde0l+jM79SQNpfu4P6pyvg1/7iigqfxNCHroY7kfelx2++1SX/QNUE5Vx0sFQM9nrAPvr4HpoSW7QaZDFx+rN8FP4xeNeHusaARWcklt2ApHNjpJuon0+KQZZAMi5nOn3mIFu7kXCqm+J9voeHBGtJsCy3yXR8sqaLeEq+xBdmqR8yDnp8OcDd3eJiEVm+w+q6dytmHtfdSdwWVMhFTimdItrXbNZqgeWEiQFo7uNJqZ9bw2u1ukIgHk40YGnasjO/nLwh/QObLNQHCpa7YC1MaXET6CPNDvmMH7MFQ4aRWcBOH16dcnRPaquwSD3DUOwH5sgM7Oy2BJ9OqJkqqBtpBBssWljjKsNuMhIJ3ChqeWfei/3k9WaRmO7Z69w9F9JqT3MMKw5K/0ZhKTSLdxfIbG5J5XD18b2ttNN3FyDlz0dWX4DQM+qPHL0CUrs4fyeRDjJL326LCjOiwMjbcBrWCbKn7dQmXeGwueX7GiiVXHgfR4BNrIp956N87gHWIvhXWMmjMZj0T+FxF2/seG1fNMNDofgL4PZFGvOTP9A9d7jJWzVyofSDjeoCFUNEfYgdXCdd/iMgp9ZpNaMpgM13elpKxVW++vXGRL4kuDOSQED0TCR8Y960Wkkdizyoh1m8YR4GEHABv3zaLJsfmuSQ+c9/J7e062iZ43ElQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8895.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(921020)(11063799006)(56012099006)(4143699003)(10067099003)(261009221227099003)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kWxUoDo9cCXL+iHfzyz020u3gN8qUfnqGuTxAPbt2/VekW6S7jBWAHW6qI0W?=
 =?us-ascii?Q?/Wv/gm67hGQHPF8+lBj6k22SDBvOnvq+UJXQKW5O/qlJmwUh1JqqTAFifXIS?=
 =?us-ascii?Q?3r0BjIDSQn/qG8dYdfSRqFCnHqs+vXRgV7RGt3mBjLbzLjNoKl6/yDJh5eB4?=
 =?us-ascii?Q?nfpEZ6DtOBIf8K3XkFBYq3Ou35ktqK+N/Ck0AHEbvMz/GZcPxCOx9URtKpSO?=
 =?us-ascii?Q?VXAf1npSxr1zkiF7Ec++5KkKMSUj1XeZIsifhRoosKXZd5UXc+SkrAii1Gj/?=
 =?us-ascii?Q?EdeH1ZcYAvkxRreGlEuZ04zvSNXtgrkGRipJcjvaqJqYzEBYfRXdZpQ4aErp?=
 =?us-ascii?Q?M1RJZb322N43NxxTNv9wU1+pw9TAo3/wzY1MIsGrti9RSRqHzrmlU0NFkUlN?=
 =?us-ascii?Q?obT7o9vb2KFZfAdEGHtjp6BuJLIZQuQnz149/AtM93qVxC/5j6+tSevweYAa?=
 =?us-ascii?Q?ZWTRgJYON+W6cszfiQHfiiuAS+9KTzN7AORp45rRp6VRs/OTKh5cD6XRyQr1?=
 =?us-ascii?Q?hzrYSapRvN05fOv7XWaffJVLpx/yXjxjVsHSpSGcrb6Dd/hueuF3jIOcQ+fv?=
 =?us-ascii?Q?GaERofvro/hH9Pf+oHmtv27k8ajUVCHvDt05+RwG+5KBffnEoJ1G8rg6KSNf?=
 =?us-ascii?Q?eg/IFh7rlk/ZFf9csYC7ioSfN6YYv2b7L1ZCSwJzm5N2gT3Ptwss8FfCkuWj?=
 =?us-ascii?Q?ZmKwCCe6F3eV/z9pYUje0MUNEefNSgLPdUq1dF0cAOP7jX+PreRzk3EXsK4R?=
 =?us-ascii?Q?tksnoYisJQkfUa5ekdm0Tb5qPd9nFer/nKI288UotPFDpKrsRQx5CjnDnwZ3?=
 =?us-ascii?Q?ZTnRdAGSbQ1AEaUDFjTZl9tWPDhNasoHBupN5E7juEnlMpdgea54eI+F7fqj?=
 =?us-ascii?Q?63IexiYDCsOMaajZ8+4hKRH6yyyNMXaznxkJcXTSnse6P0kdwBRK5o2MWWF8?=
 =?us-ascii?Q?Kc6L+4xZ7OXnd42zSPvzeoQhdiHxndjQIWcAV1KyItFyyGnWCc7e9L+g21Lq?=
 =?us-ascii?Q?LfnlyngzQhNeycQh6YmkY6/3TWcg4xYsrrQVvlJLdfe3oZzeizMpFMfEY89j?=
 =?us-ascii?Q?3DPkkQQ5mLpQwq9TulW2m8JRqTYVZMs+rLqxA1cZswBEb2fmcjZZ5jD79EmC?=
 =?us-ascii?Q?zXbp5YvMRVXpMl4g40MdzpAy1/IwYD7KI3g+uh+h/PFDQH5MylT5/ess5uay?=
 =?us-ascii?Q?qMsGPUGhwCKRI/TVtncFebgYMQLnIXgokFomn5x2gyzU8N4zZ2b0ocRvJxGm?=
 =?us-ascii?Q?MCRfQ2XaD4UZNaKuLlRcNjrmA7DoME1Klv0rvaGhChE0I7VBbG+bk1cCBNrx?=
 =?us-ascii?Q?GafqaSMIzQpriqNZBgksoTbbILDPGKVQXOfzftcojXw/MAacBTt/KGZEXB3+?=
 =?us-ascii?Q?FoA1KUl/vqGqADSQeBoJPBN2JwjMOuuUo0MiVLxj/hEXGUAK3jD5nKzsXO4n?=
 =?us-ascii?Q?wRC/nsK4qKx1k7nPCaY2UpIA8Kk0/WT5cDSluf44g35W5HKZLFd9HunqRcoi?=
 =?us-ascii?Q?jxliVm7JFwhwHX9bX80QATQBJttCKQJdIdJXNgabCn91LBaJqz4H6gHujDZ9?=
 =?us-ascii?Q?DXDRzsrkrsEzFCTbiEb6Yq31NkYBGeHW1LSLo3pqcWRhHseYoVnf2ZsJYbCB?=
 =?us-ascii?Q?b854O0R7WOYuDHWgTn9dAwFeHT8Hh5I46XY9Sdiq4LV9C33fNSKWWpGwH4RC?=
 =?us-ascii?Q?12nKQVAFuC1Ctz+X0aIRp23ySairMbyTXyXcryC4/oHY7FQj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017693c3-9925-4ebb-3143-08df32c4fda2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2026 18:22:55.9526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Q72cAC5rXIsCxmOav/QgIAH+7A2xsKwQCUNJYwRyHFqX6x0KK//xO5AjnTGIjQ/8jOamMA62fbAaZvKljrb4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Hi Team,

Gentle reminder on this patch.

Kevin, did you get a chance to look at my reply? The UMD profile reapply pa=
th
is gated on the PROFILE_* levels, so it does not cover the reported case of
power_dpm_force_performance_level set to high.

Lijo, v2 restores the forced level as you suggested. Could you please revie=
w?

Thanks and Regards,
Priya

-----Original Message-----
From: Hosur, Priya
Sent: Thursday, October 15, 2026 7:29 PM
To: Wang, Kevin <Kevin.Wang@amd.com>; amd-gfx@lists.freedesktop.org; Lazar,=
 Lijo <Lijo.Lazar@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;=
 Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehl=
ing@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>
Subject: RE: [PATCH v2 1/1] drm/amd/pm: restore the forced performance leve=
l after a reset

Hi Kevin,

Thanks, I checked that patch.

It gates on the UMD profile levels:

  case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
  case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
  case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
  case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
          break;
  default:
          ret =3D 0;
          goto unlock;

in amdgpu_dpm_reapply_umd_profile(), and the same switch in smu_reapply_per=
formance_level() returns -EINVAL for default.

The reported issue is with power_dpm_force_performance_level set to high, w=
hich is AMD_DPM_FORCED_LEVEL_HIGH, so it takes the default path. low and ma=
nual are the same.

AMD_PP_TASK_COMPLETE_INIT also still passes force_performance_level =3D fal=
se:

  case AMD_PP_TASK_COMPLETE_INIT:
          ret =3D smu_adjust_power_state_dynamic(smu, level, true, false);

so the behaviour of the smu_late_init() path is unchanged.

My patch makes that path re-apply the retained level after a reset.
Tested on an SMU 14.0.1 APU with high set: gfxclk 2784MHz before the reset =
and 2799MHz after. Without the patch it drops to 600MHz.

Thanks and Regards,
Priya Hosur

-----Original Message-----
From: Wang, Kevin <Kevin.Wang@amd.com>
Sent: Thursday, October 15, 2026 3:55 PM
To: Hosur, Priya <Priya.Hosur@amd.com>; amd-gfx@lists.freedesktop.org; Laza=
r, Lijo <Lijo.Lazar@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kue=
hling@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priya.=
Hosur@amd.com>
Subject: RE: [PATCH v2 1/1] drm/amd/pm: restore the forced performance leve=
l after a reset

AMD General

>> [PATCH] drm/amd/pm: reapply umd profile state after recovery

Could you please double check this change? It seems it already covers your =
case as I see.

Best Regards,
Kevin

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Hosur, Priya
> Sent: Thursday, October 15, 2026 17:47
> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan,
> Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur,
> Priya <Priya.Hosur@amd.com>
> Subject: RE: [PATCH v2 1/1] drm/amd/pm: restore the forced performance
> level after a reset
>
> AMD General
>
> Hi Team,
>
> Gentle reminder on this patch.
>
> Lijo, v2 follows your feedback to restore the forced level rather than
> report the default. Could you take a look when you get a chance?
>
> Thanks and Regards,
> Priya
>
> -----Original Message-----
> From: Priya Hosur <Priya.Hosur@amd.com>
> Sent: Thursday, October 8, 2026 4:10 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Cc: Hosur, Priya <Priya.Hosur@amd.com>; Vishwakarma, Pratik
> <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veerabadhran (Veera)
> <Veerabadhran.Gopalakrishnan@amd.com>
> Subject: [PATCH v2 1/1] drm/amd/pm: restore the forced performance
> level after a reset
>
> smu_late_init() re-applies the DPM level after a reset with
>
>   smu_handle_task(smu, smu->smu_dpm.dpm_level,
> AMD_PP_TASK_COMPLETE_INIT);
>
> but smu_adjust_power_state_dynamic() only programs the hardware when
>
>   if (smu_dpm_ctx->dpm_level !=3D level)
>
> and smu_dpm_ctx is &smu->smu_dpm, so the level is compared against itself=
.
> The branch is never taken for this caller and
> smu_asic_set_performance_level() is never called.
>
> PMFW is reinitialised by the reset and comes back on its default
> curve, while smu_dpm.dpm_level still holds the level the user forced.
> The device therefore runs at the default level while sysfs keeps
> reporting the forced one. On an SMU 14.0.1 APU gfxclk drops from
> 2.8GHz to 600MHz while sysfs still reports high. Writing the same
> level again does not help either, as
> amdgpu_dpm_force_performance_level() returns early when the requested
> level matches the cached one.
>
> Sync the cached level with the state PMFW came back in before
> re-applying the forced level, so that it is programmed again.
> Suspend/resume is not covered, as PMFW retains its state across s2idle an=
d the forced level still applies on resume.
>
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index a65aa2129845..2d318726c521 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -998,9 +998,18 @@ static int smu_late_init(struct amdgpu_ip_block
> *ip_block)
>
>         smu_get_fan_parameters(smu);
>
> -       smu_handle_task(smu,
> -                       smu->smu_dpm.dpm_level,
> -                       AMD_PP_TASK_COMPLETE_INIT);
> +       if (amdgpu_reset_in_recovery(adev)) {
> +               enum amd_dpm_forced_level level =3D
> + smu->smu_dpm.dpm_level;
> +
> +               /* PMFW is reinitialised by the reset, so sync the cached=
 level
> +                * before re-applying the forced one
> +                */
> +               smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
> +               smu_handle_task(smu, level, AMD_PP_TASK_COMPLETE_INIT);
> +       } else {
> +               smu_handle_task(smu, smu->smu_dpm.dpm_level,
> +                               AMD_PP_TASK_COMPLETE_INIT);
> +       }
>
>         ret =3D smu_apply_default_config_table_settings(smu);
>         if (ret && (ret !=3D -EOPNOTSUPP)) {
> --
> 2.43.0


