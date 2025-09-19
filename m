Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD756CAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 07:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8306B10E225;
	Fri, 19 Sep 2025 07:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4h1MZhdx";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFCA10E225
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 07:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Udvsv4/77ztXQko3IFfJBYRIvw8VKHJbBuAE4PG8WsrsKER2k/ZdbjsCY2pfT6MmQUIl0icEGKYov81+pW0wsBFxDnUArj9qNnULXKIN+sTL4SRe1lxluU1fyWnA0qpFwyO0PEhsmI9eRYTyIvuFyacOww/94f4d82o+z7GG+ZzAi4gtzZD23PVSFgSyyuop2hJj3vQ9pkvvLCKG2Nuo5VLdcrifuAX8lFMk+Lf7vMmgN3c8JNbZi6Bn37VlVkQWCfZM1PgGwjnkky6Kea/f6knWLBhLbSVW1FN5nJNA474WrP+CAKBIrt1XvPQIvjnLE7hAamDuoF0G7LiJ+7wIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBuVG1JnlfWR83d6IhgZocN8WLm7JdqjYiqKZlrXhu8=;
 b=nE6L1GQlgXXnWpN3YKTRoK8zDvXkwwmAkEUTqCfJcWnZduZpX7XnjJAoIzAFF8RsnCsClh2btta8OuW6vjAD5auIuItp019raoiGickbVw1oom5Z3dr7dzK8p4ObBxTHYy9GpF+u52Bm70kkj5YQtyDi8k+WC7SmfMR5JjeUclSxN706dQ9nsQcIqijWKdWPtQEe3nOBnrPNm9GJ0gQ0GnHLBxu+fB+mAOFc0lMnj14VR1cjCXIOaMITW8bh0E7YDb9sKGFCpP+aGQUKpQSyUwIjYvKHmVUqgNAkjeCN6aFInAJWh/ar9eHDIObIlnIQhGWEjnvBE6rrIfFtMXfHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBuVG1JnlfWR83d6IhgZocN8WLm7JdqjYiqKZlrXhu8=;
 b=4h1MZhdxhZ+4y8XkmBxSF9DTlDKLfivI7Lh8BHE94T+owpG40b2cjioXp53FWl/p9OnQv1p9eBuyekBbENNfp0IHkc7AfM+ivrYoSx5j6nru4JRDcjt5l9LQGYYIgHaz8ctOCeMILmU2DBXQmDxdF9DluL/InOxRE82oekveTX8=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.21; Fri, 19 Sep 2025 07:08:56 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%7]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 07:08:56 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Topic: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Index: AQHcKSiMWMWp8KpvAkaYtHWXzvLIEbSaCvAAgAABnoCAAALOgIAAAsMAgAAC0tA=
Date: Fri, 19 Sep 2025 07:08:55 +0000
Message-ID: <DS7PR12MB6071E44F8B9DE838DEAD5BB68E11A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250919054439.3115476-1-lijo.lazar@amd.com>
 <PH7PR12MB5997B2F4AF83B9FDEAA5D0AA8211A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <DS0PR12MB780437C8C982905466CFD9179711A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <PH7PR12MB59977CF6BC44D81AA52974948211A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <DS0PR12MB78042A130EEFE0D5FB33AD199711A@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB78042A130EEFE0D5FB33AD199711A@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-19T06:30:10.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CY5PR12MB6623:EE_
x-ms-office365-filtering-correlation-id: cb7251f8-ee39-46c2-5c30-08ddf74b65da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nI0NApUcys46hHVrhIh+7HtknOg67cACktVgHjaqeIvlsHsFfafGMAHSa1ZY?=
 =?us-ascii?Q?cQVy7odIgooh5sREJAEsCvTl2p/2yuLBn6Jrz7RCpLEWZl45hpBTcwodIJZK?=
 =?us-ascii?Q?KM+u+YrjYpv396GIul6nfDY3Urcp88bOi/QBFw4NkXYTwICrunPCs9MkOtfL?=
 =?us-ascii?Q?oP5TfnXeBjxM6HfS5VpIahXiIj2/LsGa4iO8OJlM+SmB4uhlH+z7htRpi+pk?=
 =?us-ascii?Q?T+N+sAZ60eTGNQWDxZ76WTWhZUMW7kpepjrw3jPge9DE2L3AoD7lQrxfSfaj?=
 =?us-ascii?Q?lDHKFGnbsHrEm9aGLsNruNbminBqniTIUhWmt815fMKiZaphb3u8Zmn/Hj7y?=
 =?us-ascii?Q?x7nNeRJ88JxeSR0lbKEijqJX6/zfgn+WHyKuJ/pxBOVqADqPga/wqBYF0uL2?=
 =?us-ascii?Q?2aFSHBY189UfyP99oBukV/KtYFolu6WRkVJOe4aa/1prPXwRYGgHJiIQpBhY?=
 =?us-ascii?Q?MXKB/tIZsN8MlizYS3zLp5VNFDm1HlsBv08HOiSH0AbFrs2XVssYg392Fqw/?=
 =?us-ascii?Q?3LRnR45nv6ghKDaCZ80/wyjkEv8nKhrlF+FkxfzVtGA0NZBEqW8c4u4f2lq4?=
 =?us-ascii?Q?JOGskJAL5VC92pR5zOCKxR8oC8xBNys5x3UC7FpsyYKwjGxuh5qBfG++OIeV?=
 =?us-ascii?Q?jqR3naMrYjkXRgjossTvvrkgSNEV2iyxrot2E1tQEXE5Rw351Neu39tIRi3Y?=
 =?us-ascii?Q?ijaZomDRWZpalPZRaPwzI2bnxB8a8O/S2+M/RqQu9OI4rspgsVkTbrL612O7?=
 =?us-ascii?Q?fATciOvsjlfPNWy2ZDswd5adSJDpe4K5xOlcnuqtHqDi8R3iWn9hC1PB3LPc?=
 =?us-ascii?Q?NXjQt54aKI3KaJ+QNMmq4qclGVsCN3vSfh7/csL2WHmapfnLpDwKtWdyABiD?=
 =?us-ascii?Q?y4eWumVfWcuGDeMN8l/7FrFnvnoCEk1vikPJEkmD5lW63ztqqESg/GzfAKrK?=
 =?us-ascii?Q?a4r0zTrFJfQUI7ha0Kn+WTbl4wf4y9WUrdsgwtXLVWUVL+hIDYgovlV/BCj4?=
 =?us-ascii?Q?k83eezvk05aLI0NeaJ+X7Z86YH+wg5LNeafgqumQqixsk4un8my7Z9ANvxzK?=
 =?us-ascii?Q?z0oMnoUbCQKe3aLMazwNTu6qfS/TaX+j8s4c5H+G6fEuLvYd/eR8w2MxCaHF?=
 =?us-ascii?Q?GPSqGGAOXxFcM2Ub6c+VTUgsW4jHyaqLsudWjaHgUgTsLpjUs4OypLIFY9EB?=
 =?us-ascii?Q?ZKrgt1h5/qCiP4g308Qdy0RV/zaJY1IqWBnpJ+M+yF/qJnGnG5IqH+7K5Pji?=
 =?us-ascii?Q?eCBA2BZe7YNbOZDuP7H7TgRkvUmoZKzCF+LKOrPp8HikIDnUeegtlg3JBlyO?=
 =?us-ascii?Q?Q1GllVuE5B8UpERBwJSqWzRtCrV/SQml4CdzyObdu96/a2S/hxVgzvOD01Q5?=
 =?us-ascii?Q?lCuXnOiHDzvmykVlAmwH6et7s/usI9zn9AFnylO2mshbs32+Az0xqBQ7YF+S?=
 =?us-ascii?Q?T5qZMaoL8IbiNbLV53doG6tc7CY3oBOta1czlNGB5LgjtMobkmgxYVyRK/pi?=
 =?us-ascii?Q?hEkJnJJnC/KrYHA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fAGVv3x0MfyOz5CczQMEUHKe9wmXK5ZTGcTixhLUYRdKCiNI+SnmY1f2NBEu?=
 =?us-ascii?Q?vaZS7Cb5t4F6xllYqhvA5ddgCK5vw3itlWamzI07JDYbB5VkM5pJVWUeV3xJ?=
 =?us-ascii?Q?x45ekyfduLaykSh2dPkTM400d3Rq0HEsV5QJeCgP0pg4pgpMXPKRQ/spCmfw?=
 =?us-ascii?Q?rsIQIIcNKJCh98bfChpU0rXrh3io1My9V1XpdOaoSdY5o9GRmyuBjsiGaFcy?=
 =?us-ascii?Q?m9AF1A0aPjUESyRV7rR+rrc9dxa6RY8zGjBu/xPzCOlwCwVhhiYSKeKPIU5S?=
 =?us-ascii?Q?gxWAl4YaPBzPoGaoxdleZh3eqIx+KevNldCYBCpI5WitqDc9uIIqKqapFqkV?=
 =?us-ascii?Q?US5ccdiK7X7yDTotgUlydg7aIL/BdXwcv7wBDfLp71ClZIOi/PjsNKSjBgCA?=
 =?us-ascii?Q?lor8SeEK4qcou5rnX0K/oi1xXGPrsG/H8Cq+hjwe916WDWFDZ4oZeTkiIUCV?=
 =?us-ascii?Q?mb1nwTxps8uaGus40EvQUrlEnkhOLudZPWoPUQ6vzcujN+cJvfAuQcG/XfqL?=
 =?us-ascii?Q?/8OEeyvss3cayvsOoVwtwSshR8T39dq/sKn+hvWtAyjlSUfjjAa/fixTUt1D?=
 =?us-ascii?Q?f8KFuMR1yIK/RUTgaAILUvQtZ4Mal2cqd196/6RMfZtYhOdghngPofF6FJUI?=
 =?us-ascii?Q?ZykGS/QKh5ChHRyD6kmkvthnVSy2XAItGVSqhzwrlis4zUC/MQoH+bJLEL9g?=
 =?us-ascii?Q?JOSXooyOCudtRiWBkQ9+zpPcJkGuEXUAb9i2ikZHxg7uMePLnvcu5MDS3STq?=
 =?us-ascii?Q?f6PZgUgEe8EcBnG1qfI7WXv5VHkBVypyqvJBzrNABxdAxuCY+NLp8oiSpqC+?=
 =?us-ascii?Q?6AUNDv7vviI0ps9OH0XHKsjhepWsUv23Q+0e1D2kD9KoturA7TmKfDYxVESK?=
 =?us-ascii?Q?tG3U88kWaZ1OULokV+32jDx+ewEaKtgA28kNyrTj5/P1Hh0MdXuPtakka2la?=
 =?us-ascii?Q?Zhrr8HspkEEOuAhW4R6whwZ93Oj0nihNiW2xIzaC6L64AbGvZXZHJFpoPFYZ?=
 =?us-ascii?Q?P15+SPHLf9MmXS2TeLWXikUePaVsvhvo/MM4fevPisY8KQPKzkJvO5vukihD?=
 =?us-ascii?Q?bzfy/uO/uMofHzaghjsU97rJLFPm9OIB+ry/6tO9H8QkzKNtt1diT9O7stwJ?=
 =?us-ascii?Q?gxHrBsPq2lGJ/dplbVi2IoWIzi1503vzJtIin5cuQQAiypRRqx1LUZEiDtkm?=
 =?us-ascii?Q?joIUKkMkrpFaDezq2S7L0gDPISl4dfw7jWJirf1pPHSxhYm2VQGueXX7u70C?=
 =?us-ascii?Q?lbYCBzqYGzPr239eINTzCZP7Fw8PI1gtKWsvU43BKUYqfMcb8GbFOWrDHHhS?=
 =?us-ascii?Q?GZakqF0S+VPOs9WhgbCTbvao4uhFit4Ed51B8Nr1dZyL1bA9B4JMDVCG+A0+?=
 =?us-ascii?Q?GfiNyyhReoaP/nKmTrDvKaS/ycJUucBi20wLeh3115IconGSiNBiYs0my/Xz?=
 =?us-ascii?Q?dFpz4f4HOORlK6+dS2KnESlY+Qts4DkewklaScJ0LrDz75rCZHN3ga8eWPaH?=
 =?us-ascii?Q?hFJUDU82GqXaW5xOFT46wc5SsP1ZSaYheZVugPdBZif5hGSM1nCy06YYCAKK?=
 =?us-ascii?Q?4SCMo3RsXyTsLNcVink=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7251f8-ee39-46c2-5c30-08ddf74b65da
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 07:08:55.9484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrEuG2EY8FXoSMTGyUaD/KvYE6zI4naM8DVx2yqFNfarUfi5u+atISxqQE0mahxZQaIGETwiazSoPjdRXmTDhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623
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

The message is really confusing during debug, and I remember getting stuck =
with pmfw team , to explain them its not error just a message. As Lijo poin=
ted out we have not updated interface version for 13.0.6 and 13.0.12 from l=
ong time because we are not using it. I only use this message to check pmfw=
 version which is anyways available in sysfs interface.

So, from my side

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad



-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 19, 2025 12:24 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[Public]

First, it's not the developer who is using the system. Any mismatch informa=
tion in a dmesg log is always an alarm to the user who is not aware of the =
implementation details.

This mismatch is bound to happen when PMFW is not loaded along with the dri=
ver.  In such cases, the mechanism to ensure compatibility is only PMFW ver=
sion checks and hence some IP implementations follow the same. If there is =
an issue, the identification mechanism is the stack information which is th=
e driver version along with the all the firmware versions. The interface ve=
rsion is not the first thing that is checked; in fact, I don't remember che=
cking that at all. That is why this code is keeping the same interface vers=
ion for SMU v13.0.12 and SMU v13.0.6 and not getting noticed so far. So ins=
tead of sticking with it,  it is rather good to clean up such messages or d=
owngrade to debug (which is again useless because as mentioned earlier it's=
 not looked at all).

Thanks,
Lijo
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, September 19, 2025 12:14 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[Public]

>> " is not used": Actually, this is used to display information to users a=
nd developers, not the driver itself.

This "driver_if_version" is used to show what driver if source file version=
 is using on current driver, this information is used to *developers* and *=
user* from dmesg.log, not driver *itself*.

>> This interface version is not used anywhere. Driver ensures backward com=
patibility by PMFW version checks and shows the exact PMFW version in dmesg=
 log. PMFW version is a more authentic way to identify any compatibility. S=
o having a mismatch statement in the log is only leading to confusion.

Pmfw/driver_if_version is the remote(pmfw) version, while driver_if_version=
 is the local (kmd) version, Because the driver allows for their existence =
without matching, more information is needed.

They should not be confused as they do not display the same type of informa=
tion.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 19, 2025 2:34 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[Public]

> Hiding this information seems unreasonable unless there is another
> strong reason

This interface version is not used anywhere. Driver ensures backward compat=
ibility by PMFW version checks and shows the exact PMFW version in dmesg lo=
g. PMFW version is a more authentic way to identify any compatibility. So h=
aving a mismatch statement in the log is only leading to confusion.

Thanks,
Lijo
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, September 19, 2025 11:59 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

[AMD Official Use Only - AMD Internal Distribution Only]

>> PMFW interface version is not used by some IP implementations like SMU v=
13.0.6/12, instead rely on PMFW version checks. Avoid the log if interface =
version is not used.

" is not used": Actually, this is used to display information to users and =
developers, not the driver itself.

Smu 'driver_if_version': it is used to show driver source file interface ve=
rsion on kernel driver side.
Smu 'If_version': it is returned from pmfw side, that means what driver if =
version is using on pmfw side.

The most perfect aesthetic situation is using same if version between drive=
r and pmfw side, but it can still work normally even if it is not matched. =
(with limited functionality)

According to the SMU driver design, KMD will not reject interface version m=
ismatches to ensure smooth driver loading.
Preserving this information helps the driver understand the KMD/PMFW operat=
ing environment and detect problems early.
Hiding this information seems unreasonable unless there is another strong r=
eason.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 19, 2025 1:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

PMFW interface version is not used by some IP implementations like SMU v13.=
0.6/12, instead rely on PMFW version checks. Avoid the log if interface ver=
sion is not used.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h               | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1a1f2a6b2e52..a89075e25717 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -288,7 +288,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
         * Considering above, we just leave user a verbal message instead
         * of halt driver loading.
         */
-       if (if_version !=3D smu->smc_driver_if_version) {
+       if (smu->smc_driver_if_version !=3D SMU_IGNORE_IF_VERSION &&
+           if_version !=3D smu->smc_driver_if_version) {
                dev_info(adev->dev, "smu driver if version =3D 0x%08x, smu =
fw if version =3D 0x%08x, "
                         "smu fw program =3D %d, smu fw version =3D 0x%08x =
(%d.%d.%d)\n",
                         smu->smc_driver_if_version, if_version, diff --git=
 a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 349b6b8be010..062f92635215 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3930,7 +3930,7 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *sm=
u)
        smu->feature_map =3D (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=
=3D IP_VERSION(13, 0, 12)) ?
                smu_v13_0_12_feature_mask_map : smu_v13_0_6_feature_mask_ma=
p;
        smu->table_map =3D smu_v13_0_6_table_map;
-       smu->smc_driver_if_version =3D SMU13_0_6_DRIVER_IF_VERSION;
+       smu->smc_driver_if_version =3D SMU_IGNORE_IF_VERSION;
        smu->smc_fw_caps |=3D SMU_FW_CAP_RAS_PRI;
        smu_v13_0_set_smu_mailbox_registers(smu);
        smu_v13_0_6_set_temp_funcs(smu); diff --git a/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d588f74b98de..0ae91c8b6d72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -40,6 +40,8 @@
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9

+#define SMU_IGNORE_IF_VERSION 0xFFFFFFFF
+
 #define smu_cmn_init_soft_gpu_metrics(ptr, frev, crev)                   \
        do {                                                             \
                typecheck(struct gpu_metrics_v##frev##_##crev *, (ptr)); \
--
2.49.0





