Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63A1C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 02:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F32510E0AE;
	Thu,  9 Jul 2026 02:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5krqsL7W";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1770710E0AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 02:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrtHZjSCd59oPzsC1EI/6ucILU02By6hqwP5Cgw/j3QpN6P4VJ2w1xa4bK914hLrwRu30lkpjjRpQxh7e6l7V50m5BwyP4r1ydfDbjlqjHoKKNXKsMoAKp3J7MN9QMjMdHQMO7kL2PpD/s/FUxtFmRZECLBvSJdOxFeE4OlJlMyRZReaVhRB78/AQJ95r7jsmN/VxOI7e+DKCAZowi7JqmgOK23vUDBrWW8pokPbUI8tOFMRhyh4kufhIv7mXrJkdFGybf/vjBxDfMeUiiEVRy2E/K2VWk1WD/MnVx80/WHxQpesRsDNpU/LF0RHWk2RDOZXnB5ar8FqxE+nBcMXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoJcSJdR8yAzCbUHIYYHrhDIhjGhEaZbj1qlAt5ryJs=;
 b=ryUdiD9+u5nk+IiWjOWswHPxJgb+INKQ7Dce3Pc73Toy1GLF/Tt6wrr5KEwjTVuGeV8z4FMHNzJrq1aB7uxkVEMUUGCsRVeAgSeqmTRe1K7azSLCFuRJlR5cV6sgeeeL/28H8bCT/LHnt+Q+lpXVravFVUj2qsyWw0325+PTmSd/LJ0LtJmwmGJTYJ3mo1nzCvy6fin5VMfFMp5EulcYTZJo3EJH/lsCd1Aw/6xVpHP0AZbnTTy1yRdgn2j6DpaRN0yoQhg7uXzfz9bYNyiGSqDNhE7ET4rLc49c5lXMjDRYwhtwCSV56EIcbPMoj9gnTNZ+gqLLpDf1ohlY3qwxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoJcSJdR8yAzCbUHIYYHrhDIhjGhEaZbj1qlAt5ryJs=;
 b=5krqsL7WpqMrePSqCMmINpdgVzDXOqR9Ne60GCcvqOj3mk/G8hPkysPoELdFuO2x00UNJl92Sll2IBytxm8X5dyyN125272VmySIIJLNfuLxQeu5bePHFInYHEl8r3shJ8t68JLBezSOGxwOmEPKdOCyt/QUArQsLbj0g/VOcsI=
Received: from PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 02:55:25 +0000
Received: from PH7PR12MB5595.namprd12.prod.outlook.com
 ([fe80::6c0:e416:3955:9ea0]) by PH7PR12MB5595.namprd12.prod.outlook.com
 ([fe80::6c0:e416:3955:9ea0%4]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 02:55:25 +0000
From: "McRae, Geoffrey" <Geoffrey.McRae@amd.com>
To: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Fix DM IRQ teardown races
Thread-Topic: [PATCH 1/2] drm/amd/display: Fix DM IRQ teardown races
Thread-Index: AQHdB+eW/Y2URqkOeEeMRQPFaqRnuLZkNE4AgABXplI=
Date: Thu, 9 Jul 2026 02:55:25 +0000
Message-ID: <PH7PR12MB55954F921171C39009496C5288FE2@PH7PR12MB5595.namprd12.prod.outlook.com>
References: <20260629165129.5550-1-geoffrey.mcrae@amd.com>
 <a02a1065-dfc4-420b-8afa-28b9dfc41029@amd.com>
In-Reply-To: <a02a1065-dfc4-420b-8afa-28b9dfc41029@amd.com>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-09T02:55:20.989Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5595:EE_|SJ0PR12MB5634:EE_
x-ms-office365-filtering-correlation-id: 37f1c942-ceb6-47c1-1533-08dedd6586b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|3023799007|6133799003|4143699003|56012099006|11063799006|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: SmhnpmahEzoe7yyMlaC+r2jHOaBnu8VGv9V3MG5M4z9e9KE8X5TdlBumzuY7hOE7/5Dgbftof/pGnkC1GuZ7jLN78+sVNz2Ro0gqy88mDkZMtK3v1FxGtQ/8jIilLpZGt0w/l/o1tfS/KH7TZdhDYMDEpcisbcD+dv8oKAsFqYjtTIHIrCxSWoI6cBaYuiQ1oDEUjJ7hHTTK8M+y+8wdKTsrZdN3KNcsPi1AyGeRqO6aXWxVKh/iEL0MgG26CvFTpKP98H3CY+Bg7W/qlAbbmBRyzbp7MYc9Enj9VgQIX7FunGlJgT9GXUE/JdDlINBPpIPgKZhNdPyryYa/0VyxHuQzie7bkSMxuVNHIG/7zBtEGiV2y/YGTrGKuBSQ2ZrzA+NggG090lzUEmmfRHeDQgqRa0F9rMUeMyD6HHY4fSKa7V/mJNKyRs3bmGwbPj27S9m5sA9BTpJ3ZZG1O0j3eMWIYYffjG7ALn+lQXe4yq3MA9CuXHbaKGNP2af4pF1a8V/KSdt00dw5b6XB2apGDVFoXPIW/hGKYkyKMnvuvQNXZHyNzOlmwydDaWOcQQFK0BYsSweRipnATmYK05ctsc4SqX21lTwAuHPVVNcp+G+kGAG/J7yqGklYFJwu5ANCJEmS8JpC/6dFgt2MOiw8VasrPinO6U/C/mho0zkpt9/gFZvaRu7/+In1EvV/OtHQDTfPaw6sPdqVXhQUcnfL2rfS7PohQ2KuMmR1ERpjQe4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5595.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(6133799003)(4143699003)(56012099006)(11063799006)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?teN3ZVKXfV3NOB9/aj0axoAEiDUJt8DF+adMvkJGzzEsK/pe/AkhuSFAy7?=
 =?iso-8859-1?Q?xtpHhScEQWp7K2tFgoRTIuyfXxto+qun5rS2f/tIWyqqTn9wUCQoZYPz5l?=
 =?iso-8859-1?Q?ZGOLTS9ApIGTWEevvED10As7bxA1BGBqUEyJvMuJuUk0kxDscNlEpGcIr+?=
 =?iso-8859-1?Q?ENETrnN63kTm4omTdHmvDvki8lDyC55Faj6I2DlBak7qcf5Z7mUZtKW2U1?=
 =?iso-8859-1?Q?vc2FfEjXz/0K9RIn3Vu7gG1fgcTQixmun5QVMlu8kr12tHTp/74tLvXbdi?=
 =?iso-8859-1?Q?rImKfgZnoU8rnF+2q4Xeifi2Ctuhy4xzcg84EzImpbIUhKlcmQszityW4D?=
 =?iso-8859-1?Q?aLZisAc3DUbvo7jTkIjJ12t3Wx+7QY5PnGuxm4XXtIY3NgAUrjatyQSo3t?=
 =?iso-8859-1?Q?rcGnPr7XrJBgFRLTEy7vZr3bKjhzjBGF9g6sZHPCWgOZfSEVLUM160VVBM?=
 =?iso-8859-1?Q?kYcIWAJXP3esaDylXeXVYLweno9dDAC/ZVgPGfxkqe3KrPmHcwjRV4IUNy?=
 =?iso-8859-1?Q?qCXfW3uy3Y5Xk7IB7TkUxt4PsPOvc9q4NfM/FRbSh+i7Sa6o4/4QJf5cvP?=
 =?iso-8859-1?Q?/1XPCJltbsV4/tvRiHH0bBx4VhiRKiRZ9KGRcS9PG7RTN/g4CvTKkbQTQl?=
 =?iso-8859-1?Q?P6eawhjxdOzJLaWeEiT8iGKgwCMEtJGtILc4N2Co85GnF7x7xJenRvInf1?=
 =?iso-8859-1?Q?8IHMZixl6U2TNJuMoDbGCgP+n/u5sghkjhHVuqNd83CK4+iKi4Dobyw0B8?=
 =?iso-8859-1?Q?2bZDODiB+7fgDVlrykXbXCx7rTivZs6gggwElxoN74zhqEgc/XJpu7B9aF?=
 =?iso-8859-1?Q?QM6fPuq9LlmFS5kMyXgDyyg+YEYsq7vb/5H5gFWorNWjMwGne85LlM/Z9o?=
 =?iso-8859-1?Q?/F4T+hVzJHPT83DTY9GA8kkvKFHPeF1WQ/HmupAUdiWX70Ht1oWOpAyMmg?=
 =?iso-8859-1?Q?ZfI/hdhgSK2BT5Lj/avSksS7Pgff3WT3fl2e/+rGMKQY9koL8zAAovTA6G?=
 =?iso-8859-1?Q?9oOzlRZ9qS9ASayNq24UI9+Ob28XoVNRC5V1To8yBjtEJdYfI7geOJGAnk?=
 =?iso-8859-1?Q?/aTHt/Q+sNMZFn2ozJa3oZoO1bFJd3lwQy0M7/ZrLftlMBQ3tjgkpyZ3AA?=
 =?iso-8859-1?Q?zAZFnXCc3vsxTBtJqkrdrwZ7cjX15ocUixjN1Qs5dNngw2Htwk+OdL80rg?=
 =?iso-8859-1?Q?1qSVNWD4BgoOJELUUJvpB3o5jeryMKtOaTA8gCNL7bK+EQVlLVkjT1umhV?=
 =?iso-8859-1?Q?Ol+QkZHW8XXBUmyIaQ56lPEXxAzFPJzK2plJU0kPlm+ldOM6mwSrjdQdwG?=
 =?iso-8859-1?Q?QRu0NWifeqAE7RNzCO5tXgYpZ4YTAmXQ3hHsYxMqm4fZr1xdkRWEIzpb8p?=
 =?iso-8859-1?Q?Bo86iaQtrNKYt/ys0WjlPCd1IM8wTRrRSKbA4SBpJo9G4qyRGKthzBgAko?=
 =?iso-8859-1?Q?oVkxTllK1nX0j517wXWq2oEDfEMz4NVMeqkhhkyxmb0B4aIxYv7hEesjyn?=
 =?iso-8859-1?Q?fhTi4igXPRpG3+MVowBqXfVUupE8HqWmau4mSMn0RUSNvO4PpC8jzAEFNq?=
 =?iso-8859-1?Q?ec15ZlHSJx2rStmtecWBdiiz8SaBfHpCSpHRbhUi/wHZcAhBwRKrPCFH8l?=
 =?iso-8859-1?Q?1Xvq7DOwcHNUVrCz1Najc3s8sk23YjBEL55KHwGb0L0A0R9MJBddX5xD95?=
 =?iso-8859-1?Q?utzDHWdkihFQpDuZNLI6I362D7eFnFLbAPN//T3AcPlB3Uj96n4DPkA8hq?=
 =?iso-8859-1?Q?3YBiQOmpaNwxFtloSuv+tgXbSNqRnZ0ut5z9sOwzPXeIrP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5595.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f1c942-ceb6-47c1-1533-08dedd6586b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 02:55:25.3982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2ZFJ3LRrv13+PP1+r5C1nM4LRxrryNfIVQbs6usR6bDjWFGxRdJbhJp6hjzH+ImPWXD5NFAU4gfPgHNY7+c6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634
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

On 2026-07-09 7:38, Leo Li wrote:=0A=
>On 2026-06-29 12:51, Geoffrey McRae wrote:=0A=
>> DM IRQ teardown can race with interrupt handling and low-context work.=
=0A=
>> The IRQ handler can still walk the DM IRQ handler tables while the=0A=
>> teardown path removes and frees entries. Low-context work can also=0A=
>> remain queued after its handler has been removed, leading to a possible=
=0A=
>> use-after-free when the work item later runs.=0A=
>>=0A=
>> Add an irq_fini_in_progress flag and set it before the IRQ tables are=0A=
>> torn down. Check the flag in the ISR and work scheduling paths so they=
=0A=
>> do not access the handler tables or queue new work once teardown has=0A=
>> started.=0A=
>>=0A=
>> Rework amdgpu_dm_irq_fini() to detach all low and high context handlers=
=0A=
>> from the IRQ tables under the table lock, then cancel pending=0A=
>> low-context work outside the lock before freeing the handlers. Also=0A=
>> cancel low-context work in remove_irq_handler() before freeing an=0A=
>> individual handler.=0A=
>>=0A=
>> Fix the suspend path by disabling HPD and HPD RX hardware interrupts=0A=
>> under the IRQ table lock before flushing pending low-context work,=0A=
>> avoiding a TOCTOU window where new work could be queued after the list=
=0A=
>> check.=0A=
>>=0A=
>> Finally, call amdgpu_dm_irq_fini() from amdgpu_dm_fini() before DC is=0A=
>> destroyed, so IRQ teardown happens while the display core state is still=
=0A=
>> valid.=0A=
>>=0A=
>> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>=0A=
>> Cc: Harry Wentland <harry.wentland@amd.com>=0A=
>> Cc: Leo Li <sunpeng.li@amd.com>=0A=
>> Cc: Alex Deucher <alexander.deucher@amd.com>=0A=
>> Cc: Christian K=F6nig <christian.koenig@amd.com>=0A=
>> ---=0A=
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   8 +-=0A=
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +=0A=
>>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 164 ++++++++++--------=
=0A=
>>  3 files changed, 96 insertions(+), 79 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers=
/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c=0A=
>> index b97ceabe6173..9c5e963337cc 100644=0A=
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c=0A=
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c=0A=
>> @@ -1010,14 +1010,11 @@ static void amdgpu_dm_fini(struct amdgpu_device =
*adev)=0A=
>>               adev->dm.hpd_rx_offload_wq =3D NULL;=0A=
>>       }=0A=
>>=0A=
>> +     amdgpu_dm_irq_fini(adev);=0A=
>> +=0A=
>>       /* DC Destroy TODO: Replace destroy DAL */=0A=
>>       if (adev->dm.dc)=0A=
>>               dc_destroy(&adev->dm.dc);=0A=
>> -     /*=0A=
>> -      * TODO: pageflip, vlank interrupt=0A=
>> -      *=0A=
>> -      * amdgpu_dm_irq_fini(adev);=0A=
>> -      */=0A=
>>=0A=
>>       if (adev->dm.cgs_device) {=0A=
>>               amdgpu_cgs_destroy_device(adev->dm.cgs_device);=0A=
>> @@ -1523,7 +1520,6 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_b=
lock)=0A=
>>=0A=
>>       amdgpu_dm_hpd_fini(adev);=0A=
>>=0A=
>> -     amdgpu_dm_irq_fini(adev);=0A=
>>       amdgpu_dm_fini(adev);=0A=
>>       return 0;=0A=
>>  }=0A=
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers=
/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h=0A=
>> index 909ee71d6d59..88687a7e01a5 100644=0A=
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h=0A=
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h=0A=
>> @@ -340,6 +340,8 @@ struct hpd_rx_irq_offload_work {=0A=
>>   * @dmcub_trace_event_en: enable dmcub trace events=0A=
>>   * @dmub_outbox_params: DMUB Outbox parameters=0A=
>>   * @num_of_edps: number of backlight eDPs=0A=
>> + * @irq_fini_in_progress: Set during IRQ teardown to prevent interrupt =
handlers=0A=
>> + *                     from accessing the IRQ tables during cleanup=0A=
>>   * @disable_hpd_irq: disables all HPD and HPD RX interrupt handling in =
the=0A=
>>   *                driver when true=0A=
>>   * @dmub_aux_transfer_done: struct completion used to indicate when DMU=
B=0A=
>> @@ -634,6 +636,7 @@ struct amdgpu_display_manager {=0A=
>>        */=0A=
>>       struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];=0A=
>>       bool force_timing_sync;=0A=
>> +     bool irq_fini_in_progress;=0A=
>>       bool disable_hpd_irq;=0A=
>>       bool dmcub_trace_event_en;=0A=
>>       /**=0A=
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c=0A=
>> index c5467f34c51f..3a5de9364ed1 100644=0A=
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c=0A=
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c=0A=
>> @@ -195,6 +195,9 @@ static struct list_head *remove_irq_handler(struct a=
mdgpu_device *adev,=0A=
>>               return NULL;=0A=
>>       }=0A=
>>=0A=
>> +     if (int_params->int_context =3D=3D INTERRUPT_LOW_IRQ_CONTEXT)=0A=
>> +             cancel_work_sync(&handler->work);=0A=
>> +=0A=
>>       kfree(handler);=0A=
>>=0A=
>>       DRM_DEBUG_KMS(=0A=
>> @@ -204,55 +207,6 @@ static struct list_head *remove_irq_handler(struct =
amdgpu_device *adev,=0A=
>>       return hnd_list;=0A=
>>  }=0A=
>>=0A=
>> -/**=0A=
>> - * unregister_all_irq_handlers() - Cleans up handlers from the DM IRQ t=
able=0A=
>> - * @adev: The base driver device containing the DM device=0A=
>> - *=0A=
>> - * Go through low and high context IRQ tables and deallocate handlers.=
=0A=
>> - */=0A=
>> -static void unregister_all_irq_handlers(struct amdgpu_device *adev)=0A=
>> -{=0A=
>> -     struct list_head *hnd_list_low;=0A=
>> -     struct list_head *hnd_list_high;=0A=
>> -     struct list_head *entry, *tmp;=0A=
>> -     struct amdgpu_dm_irq_handler_data *handler;=0A=
>> -     unsigned long irq_table_flags;=0A=
>> -     int i;=0A=
>> -=0A=
>> -     DM_IRQ_TABLE_LOCK(adev, irq_table_flags);=0A=
>> -=0A=
>> -     for (i =3D 0; i < DAL_IRQ_SOURCES_NUMBER; i++) {=0A=
>> -             hnd_list_low =3D &adev->dm.irq_handler_list_low_tab[i];=0A=
>> -             hnd_list_high =3D &adev->dm.irq_handler_list_high_tab[i];=
=0A=
>> -=0A=
>> -             list_for_each_safe(entry, tmp, hnd_list_low) {=0A=
>> -=0A=
>> -                     handler =3D list_entry(entry, struct amdgpu_dm_irq=
_handler_data,=0A=
>> -                                          list);=0A=
>> -=0A=
>> -                     if (handler =3D=3D NULL || handler->handler =3D=3D=
 NULL)=0A=
>> -                             continue;=0A=
>> -=0A=
>> -                     list_del(&handler->list);=0A=
>> -                     kfree(handler);=0A=
>> -             }=0A=
>> -=0A=
>> -             list_for_each_safe(entry, tmp, hnd_list_high) {=0A=
>> -=0A=
>> -                     handler =3D list_entry(entry, struct amdgpu_dm_irq=
_handler_data,=0A=
>> -                                          list);=0A=
>> -=0A=
>> -                     if (handler =3D=3D NULL || handler->handler =3D=3D=
 NULL)=0A=
>> -                             continue;=0A=
>> -=0A=
>> -                     list_del(&handler->list);=0A=
>> -                     kfree(handler);=0A=
>> -             }=0A=
>> -     }=0A=
>> -=0A=
>> -     DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);=0A=
>> -}=0A=
>> -=0A=
>>  static bool=0A=
>>  validate_irq_registration_params(struct dc_interrupt_params *int_params=
,=0A=
>>                                void (*ih)(void *))=0A=
>> @@ -459,38 +413,84 @@ EXPORT_IF_KUNIT(amdgpu_dm_irq_init);=0A=
>>   * amdgpu_dm_irq_fini() - Tear down DM IRQ management=0A=
>>   * @adev: The base driver device containing the DM device=0A=
>>   *=0A=
>> - * Flush all work within the low context IRQ table.=0A=
>> + * Prevents any new interrupt handler scheduling, removes all handlers =
from=0A=
>> + * the IRQ tables, cancels pending work items, and deallocates all hand=
ler=0A=
>> + * data. The irq_fini_in_progress flag ensures the ISR and work schedul=
er=0A=
>> + * do not access the handler lists during teardown.=0A=
>>   */=0A=
>>  void amdgpu_dm_irq_fini(struct amdgpu_device *adev)=0A=
>>  {=0A=
>>       int src;=0A=
>> -     struct list_head *lh;=0A=
>> +     LIST_HEAD(low_handlers);=0A=
>> +     LIST_HEAD(high_handlers);=0A=
>>       struct list_head *entry, *tmp;=0A=
>>       struct amdgpu_dm_irq_handler_data *handler;=0A=
>>       unsigned long irq_table_flags;=0A=
>>=0A=
>>       DRM_DEBUG_KMS("DM_IRQ: releasing resources.\n");=0A=
>> +=0A=
>> +     /*=0A=
>> +      * Set the fini flag before tearing down the IRQ tables. This ensu=
res=0A=
>> +      * that any concurrent ISR (amdgpu_dm_irq_handler()) or work sched=
uler=0A=
>> +      * (amdgpu_dm_irq_schedule_work()) will bail out early rather than=
=0A=
>> +      * accessing handler data that is about to be freed.=0A=
>> +      *=0A=
>> +      * smp_store_release() pairs with the READ_ONCE() in the ISR and w=
ork=0A=
>> +      * scheduler paths to guarantee visibility across CPUs.=0A=
>> +      */=0A=
>> +     smp_store_release(&adev->dm.irq_fini_in_progress, true);=0A=
>=0A=
>Hi Geoffrey, thanks for the patches.=0A=
>=0A=
>Do we need irq_fini_in_progress if we're clearing the=0A=
>irq_hander_list_low/high_tab under the DM_IRQ_TABLE_LOCK?=0A=
>=0A=
>It looks to me that any concurrent amdgpu_dm_irq_immediate_work/schedule_w=
ork=0A=
>will -- because of DM_IRQ_TABLE_LOCK maintaining serialization -- either:=
=0A=
>=0A=
>A) run before list_splice and handle the IRQ, which is OK. In the=0A=
>   case of schedule_work(), where queued work can be pending, the=0A=
>   cance_work_sync() ensures they flush before continuing. Or,=0A=
>B) run after list clear and early return since the list is empty, which=0A=
>   prevents any use after free.=0A=
>=0A=
>Generally I'm a little hesitant of using mbs unless absolutely necessary, =
since=0A=
>it's difficult to understand their correctness. If we have spinlocks handl=
ing=0A=
>acquire/releases already, I'd prefer to just use those.=0A=
>=0A=
>Thanks,=0A=
>Leo=0A=
=0A=
Hi Leo,=0A=
=0A=
Thanks, I agree.=0A=
=0A=
The irq_fini_in_progress flag is not needed for the handler-list UAF=0A=
case if all users of irq_handler_list_low/high_tab are serialized by=0A=
DM_IRQ_TABLE_LOCK.=0A=
=0A=
With the fini path moving the handlers off the tables under the lock,=0A=
a concurrent IRQ path should either see the old list before the splice,=0A=
queue/run the handler, and then be covered by cancel_work_sync(), or see=0A=
the empty list after the splice and return without touching any handler=0A=
data.=0A=
=0A=
I will remove this and submit a v2 shortly.=0A=
=0A=
>=0A=
>> +=0A=
>>       for (src =3D 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {=0A=
>>               DM_IRQ_TABLE_LOCK(adev, irq_table_flags);=0A=
>> -             /* The handler was removed from the table,=0A=
>> -              * it means it is safe to flush all the 'work'=0A=
>> -              * (because no code can schedule a new one).=0A=
>> +=0A=
>> +             /*=0A=
>> +              * Move all handlers from the low and high context tables =
to=0A=
>> +              * temporary lists under the lock. This prevents the ISR f=
rom=0A=
>> +              * finding them while we process them outside the lock.=0A=
>>                */=0A=
>> -             lh =3D &adev->dm.irq_handler_list_low_tab[src];=0A=
>> +             list_splice_init(&adev->dm.irq_handler_list_low_tab[src],=
=0A=
>> +                              &low_handlers);=0A=
>> +             list_splice_init(&adev->dm.irq_handler_list_high_tab[src],=
=0A=
>> +                              &high_handlers);=0A=
>> +=0A=
>>               DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);=0A=
>>=0A=
>> -             if (!list_empty(lh)) {=0A=
>> -                     list_for_each_safe(entry, tmp, lh) {=0A=
>> -                             handler =3D list_entry(=0A=
>> -                                     entry,=0A=
>> -                                     struct amdgpu_dm_irq_handler_data,=
=0A=
>> -                                     list);=0A=
>> -                             flush_work(&handler->work);=0A=
>> -                     }=0A=
>> +             /*=0A=
>> +              * Cancel all pending work for the low-context handlers=0A=
>> +              * outside the lock. cancel_work_sync() may sleep and wait=
s=0A=
>> +              * until any running work completes, preventing UAF.=0A=
>> +              */=0A=
>> +             list_for_each_safe(entry, tmp, &low_handlers) {=0A=
>> +                     handler =3D list_entry(entry,=0A=
>> +                                         struct amdgpu_dm_irq_handler_d=
ata,=0A=
>> +                                         list);=0A=
>> +                     cancel_work_sync(&handler->work);=0A=
>>               }=0A=
>> +=0A=
>> +             /*=0A=
>> +              * High-context handlers are executed synchronously within=
 ISR=0A=
>> +              * context (see amdgpu_dm_irq_immediate_work()) and have n=
o=0A=
>> +              * work_struct, so there is no pending work to cancel here=
.=0A=
>> +              * They will be freed along with low_handlers after the lo=
op.=0A=
>> +              */=0A=
>> +     }=0A=
>> +=0A=
>> +     /* Deallocate all handlers. */=0A=
>> +     list_for_each_safe(entry, tmp, &low_handlers) {=0A=
>> +             handler =3D list_entry(entry,=0A=
>> +                                  struct amdgpu_dm_irq_handler_data,=0A=
>> +                                  list);=0A=
>> +             list_del(&handler->list);=0A=
>> +             kfree(handler);=0A=
>> +     }=0A=
>> +=0A=
>> +     list_for_each_safe(entry, tmp, &high_handlers) {=0A=
>> +             handler =3D list_entry(entry,=0A=
>> +                                  struct amdgpu_dm_irq_handler_data,=0A=
>> +                                  list);=0A=
>> +             list_del(&handler->list);=0A=
>> +             kfree(handler);=0A=
>>       }=0A=
>> -     /* Deallocate handlers from the table. */=0A=
>> -     unregister_all_irq_handlers(adev);=0A=
>>  }=0A=
>>  EXPORT_IF_KUNIT(amdgpu_dm_irq_fini);=0A=
>>=0A=
>> @@ -498,7 +498,6 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *ade=
v)=0A=
>>  {=0A=
>>       struct drm_device *dev =3D adev_to_drm(adev);=0A=
>>       int src;=0A=
>> -     struct list_head *hnd_list_h;=0A=
>>       struct list_head *hnd_list_l;=0A=
>>       unsigned long irq_table_flags;=0A=
>>       struct list_head *entry, *tmp;=0A=
>> @@ -511,12 +510,15 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *a=
dev)=0A=
>>       /**=0A=
>>        * Disable HW interrupt  for HPD and HPDRX only since FLIP and VBL=
ANK=0A=
>>        * will be disabled from manage_dm_interrupts on disable CRTC.=0A=
>> +      *=0A=
>> +      * Disable the HW interrupt first, then flush any pending work. Si=
nce=0A=
>> +      * the HW interrupt is disabled under the lock, no new IRQ can be=
=0A=
>> +      * generated after the disable completes. Any work already queued =
by an=0A=
>> +      * in-flight ISR will be flushed below.=0A=
>>        */=0A=
>>       for (src =3D DC_IRQ_SOURCE_HPD1; src <=3D DC_IRQ_SOURCE_HPD6RX; sr=
c++) {=0A=
>>               hnd_list_l =3D &adev->dm.irq_handler_list_low_tab[src];=0A=
>> -             hnd_list_h =3D &adev->dm.irq_handler_list_high_tab[src];=
=0A=
>> -             if (!list_empty(hnd_list_l) || !list_empty(hnd_list_h))=0A=
>> -                     dc_interrupt_set(adev->dm.dc, src, false);=0A=
>> +             dc_interrupt_set(adev->dm.dc, src, false);=0A=
>>=0A=
>>               DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);=0A=
>>=0A=
>> @@ -597,10 +599,20 @@ static void amdgpu_dm_irq_schedule_work(struct amd=
gpu_device *adev,=0A=
>>       struct  list_head *handler_list =3D &adev->dm.irq_handler_list_low=
_tab[irq_source];=0A=
>>       struct  amdgpu_dm_irq_handler_data *handler_data;=0A=
>>       bool    work_queued =3D false;=0A=
>> +     unsigned long irq_table_flags;=0A=
>>=0A=
>> -     if (list_empty(handler_list))=0A=
>> +     /*perform a lockless check first*/=0A=
>> +     if (READ_ONCE(adev->dm.irq_fini_in_progress))=0A=
>>               return;=0A=
>>=0A=
>> +     DM_IRQ_TABLE_LOCK(adev, irq_table_flags);=0A=
>> +=0A=
>> +     if (READ_ONCE(adev->dm.irq_fini_in_progress))=0A=
>> +             goto out_unlock;=0A=
>> +=0A=
>> +     if (list_empty(handler_list))=0A=
>> +             goto out_unlock;=0A=
>> +=0A=
>>       list_for_each_entry(handler_data, handler_list, list) {=0A=
>>               if (queue_work(system_highpri_wq, &handler_data->work)) {=
=0A=
>>                       work_queued =3D true;=0A=
>> @@ -617,7 +629,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgp=
u_device *adev,=0A=
>>               handler_data_add =3D kzalloc(sizeof(*handler_data), GFP_AT=
OMIC);=0A=
>>               if (!handler_data_add) {=0A=
>>                       DRM_ERROR("DM_IRQ: failed to allocate irq handler!=
\n");=0A=
>> -                     return;=0A=
>> +                     goto out_unlock;=0A=
>>               }=0A=
>>=0A=
>>               /*copy new amdgpu_dm_irq_handler_data members from handler=
_data*/=0A=
>> @@ -639,6 +651,9 @@ static void amdgpu_dm_irq_schedule_work(struct amdgp=
u_device *adev,=0A=
>>                                 "from display for IRQ source %d\n",=0A=
>>                                 irq_source);=0A=
>>       }=0A=
>> +=0A=
>> +out_unlock:=0A=
>> +     DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);=0A=
>>  }=0A=
>>=0A=
>>  /*=0A=
>> @@ -678,9 +693,12 @@ static int amdgpu_dm_irq_handler(struct amdgpu_devi=
ce *adev,=0A=
>>                                struct amdgpu_irq_src *source,=0A=
>>                                struct amdgpu_iv_entry *entry)=0A=
>>  {=0A=
>> +     enum dc_irq_source src;=0A=
>> +=0A=
>> +     if (READ_ONCE(adev->dm.irq_fini_in_progress))=0A=
>> +             return 0;=0A=
>>=0A=
>> -     enum dc_irq_source src =3D=0A=
>> -             dc_interrupt_to_irq_source(=0A=
>> +     src =3D dc_interrupt_to_irq_source(=0A=
>>                       adev->dm.dc,=0A=
>>                       entry->src_id,=0A=
>>                       entry->src_data[0]);=
