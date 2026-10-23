Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA2606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=O5PLk73E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D53E112C74;
	Fri, 23 Oct 2026 17:13:01 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011F610E0B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 14:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Td2P+f96DSeNvjwSmXT8jxCB+AS4HZLzZmJv3tu3Lpuv6O6pFnI6iVp69UGY7w7hRbmTtzFS+wFLw8T8dTxdXFhq6Jmc+JFIPxnLXERAY2mj3YQSZqwscA5IssSIW8vUgGlsPmRpPihqQOHf5FED0Vr7HykGtSU/yYp0IjMn/GyVTsIFTCORlSRfLypLsFrOBU6G3bZ/4/NO3oSSRkU3rnmcdh4m3C1V025Qcz197adRUQsSo8yatboOWWbwUnMOLPk8XQwLHcBSwr8J0BauvT5PTWdlrhXntK1+QwnSN8GaNVgTRrR8yb/yVI9oXA24uxWFkiQjU45FPG4WkHKB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQBj0rNEzZV3LJWfOyMIjbISHr7QMG8tz8qw+5DCySE=;
 b=w1FDMDqAzTSZbS3BGtJ+mNiRPQ6vIGlRBDuAbKh+yXPeXZGCrmw5lnRwtBUsuksxaShd2e4zjgUxEJLD8wXJZ94sFmn5/z6XQ+qhwztGiijU4sJvZsKSf5y52jvHwKCaWU1XtG11sDtrDLCyxcm5gekH8cBCe4IRravipAFZRQv1orgh4WL30Nz/+2qiFk6na9gXoHRoc7u2svmnQLqrZM02knJ+1/4p5/QrWORTryZHberdjVDEbzS/3afn5h4CIoqgTNX3xziUEvSDXmNSraw8IpcNY8Xb6y0FPAvf6DnEShKKeYNE4lLmlanV0cNeD/6Gm02Q6Gy7BseaIqvonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQBj0rNEzZV3LJWfOyMIjbISHr7QMG8tz8qw+5DCySE=;
 b=O5PLk73EsKj5e/7E4Y1CsE22VSmerJnIaxGpHgaFqncWgMD68qmPHaKrnv13HTVlQ3qK4V1csM8a/scK16/cZMPLkcNgPFV7htOnR0GrJEZb1vcxL7IKcItRT7SJEmnlVOFDZwdt7q3/l7RQy+IZqQBIbk9y3cYK7vEvabosrPI=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 14:32:16 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:32:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, Mario Sopena-Novales
 <Mario.Novales@amd.com>, "Caike, Igor" <Igor.Caike@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx12: flush the scratch register write in the
 ring test
Thread-Topic: [PATCH] drm/amdgpu/gfx12: flush the scratch register write in
 the ring test
Thread-Index: AQHdYrgEUegMWTBUPkadbQFyDsWE3rcLMPtg
Date: Fri, 23 Oct 2026 14:32:15 +0000
Message-ID: <BN9PR12MB51464073C275F66E988745E0F7642@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20261023063031.849579-1-Jesse.Zhang@amd.com>
In-Reply-To: <20261023063031.849579-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-23T14:31:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|CYYPR12MB9013:EE_
x-ms-office365-filtering-correlation-id: ce2088d8-36f7-40c8-6fab-08df31126f83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|38070700021|11063799006|5023799004|261009223027099003|261021121427099003|10067099003|261022105027099003|56012099006;
x-microsoft-antispam-message-info: LEWDICczEigjhERCHwb0caV4Fq8LaNGxE30zP2peus/iXskd3TR0/U0RjSBBBqu0nGfkKoe2zuK3g0ZmmbKZ5oW6kLw5U390BrCAAZWjs1M6hzdJJ8r0D8AsDiAGjOCRvpxvzXRdiWu0Dh3qQpo4IC6E2aAsXetjsVmtU52S6TQskZlTlShvHCN0qC+FxlqHzIjYyjhS5HTUCaoSWXRJnW2JKt86PfGbySW273fagSel4PhnxLr7wf1ojGIN53yrjBIwpeho35rnqrxYHhkOA2rDVcvENYIrwk5kVWQeAyAd4YU0dz7x4kxHkzEAggEqUuMHlXKv7EVVl3RmFC3DjUtImEXVuS74lAwEQSj3rXNLSR4HGswDXPxoppbYa5oezE4TFYUrTYdCKHCYOaLAECdjMttU3Lw0tABI1izyWeAlQF+1QkzdIFC0WVofxJdDhjrhCGmpgrKUxelm9SnpQbWw7gi0T+E95hDT1yRRmwSZpAugNPxN6/3vqWRBOmjPO0Y+KRiCbifb/t2XllM0YeoIjJF6cdmieHiI1e5idsEVWcF0tGe6e3QTrF+Qpyk96WZhbsBCg/L3OeZCdH6uFKytoRGcKbUGaqTKHHyEy3lmcnukry+Kh0Vq5o3i+VcivdmeLDsKcPbUGc6Oo/SKWkQyahVykUoXoF1NwcnrvrFzRRhvItNXFcRgkE5wOgOxXWXrjNztKkk2RivwnUEouu4VtDiweuVCSfhD6H//7n0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(38070700021)(11063799006)(5023799004)(261009223027099003)(261021121427099003)(10067099003)(261022105027099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HgW4KXalvIFOyaJqhD6T2f7qPyrfGXOc63INW5EConziOhZzTYWh0cDJYwLJ?=
 =?us-ascii?Q?ujOy32BxG5O2fedaREztWlC3MmXIq10t6geIJeqeK4/c6M4Ap0NkMZ33GGau?=
 =?us-ascii?Q?rdPqcpmT3Dm8xfoMwkw8isisbRhbwkxLWuyd+vrureWJDHmflhTWrLWsTj1J?=
 =?us-ascii?Q?dd1Q200CwWdop/C3bmIyIhEkH0mkX69roOkAgKHmfvlotSoyS1y16TW+6IXW?=
 =?us-ascii?Q?aX1kVeuJzoqBr6KXB772lB45VRu0yQLHJfJ718EYC5rc8ExR0PvVVe6BKRhU?=
 =?us-ascii?Q?74V1UQgL48gitaPeKe8UnJ7pXA+IeEH/mAwTMQTNTKpCQPcop1GQko5ECW5G?=
 =?us-ascii?Q?7yLnGqywny9ZhbIpwb8PuHRIpPN1OHlziJX+OP40HlJ47s5xEwYPCLmQjFgm?=
 =?us-ascii?Q?nvTFhRy89jokIfAmVEkpTooXTz5gPzlgDLD/NgeRnWH0+mOL1KA4khWWaE+D?=
 =?us-ascii?Q?jeL6bar4TXUr2dWQHYXiaN+1x+nKNp/mb2cAQLJnJ7yYWQIVpcEg1l9id29k?=
 =?us-ascii?Q?eQbUxamcI7zQC/HYm9/HHhobdbKhc2pPr2js4V0NnbI55KDEUX3MchsiqXSW?=
 =?us-ascii?Q?vGGwYtc2avl6BE8opV8vqV7fIZHZWDHSTcLXrftdg1K6k6Bgd+IKZtfDZtbm?=
 =?us-ascii?Q?7hc2gpf3mio548Ph/DX9exvCoF0FyrYPwrAEP4mTmKaFSe/fRxyUhOMf9Ki6?=
 =?us-ascii?Q?oS9l+D2kw0Cs88Y5Osthkm7TsI+czWOybzC5pjXGsazIdHD7TPYh5DrElSnp?=
 =?us-ascii?Q?aEjFh35wsqhKHWsXctz8u8wBs2LIMnbDR71i3ohucKmUSJN8mhpkKTRB72o+?=
 =?us-ascii?Q?QBGpw1TZE88JlFGE/Qfpm9wvIlWqi44aK/nWlw+mwlmqQB/BBs+xsQHaUx46?=
 =?us-ascii?Q?1zVS9Ow0qMRX7H2zbQBpxY5mGP7A5KMB98iZneo4BaS24jXu6/gRMr3fgSZa?=
 =?us-ascii?Q?s3Mcwz3CAeK2lzdinOjIpTKrEe24VjXTPh24kFLJCk8XSexnKUTdUpLSVanB?=
 =?us-ascii?Q?R8Af/hbacYALRIBRvGJoSwiTC84yAPbykEJFgM0n+JuSh/8EMKYg8YdVeagd?=
 =?us-ascii?Q?yHr0m9mjoT/duiLN0XJ8sD5PopQxHOPKD+Z1AkLGqp1PwtjPrUWQ+euc5Y2a?=
 =?us-ascii?Q?Q+oPlqIyFkPSFZv4oFPAPm9FLV5TIunBRSYsFilubMVfBrkPpRw9eKdlmNs8?=
 =?us-ascii?Q?8sGDV+5SX7DH0pHvsqEE4tyDuEUnf8OD04e+hk7VRurRje4Wh8BQyKH7sjkQ?=
 =?us-ascii?Q?9cx17Kc0veTjmdFAoo3tIshqbeDaqM1Q2KkKbv07zKeH5sOC8q4Z2eNKOwzz?=
 =?us-ascii?Q?di3SyM0EtaridKP/3+0zGDcNHqog8QFb+gVNW9Vcd+3KpqYjf0ETQe7cgjof?=
 =?us-ascii?Q?nZVG8ooPQUkgkdHilSHLhq28OoXS2VxZwFpS+/RJnQsIntjptH9tjIRpobFs?=
 =?us-ascii?Q?+v144d8TRCOoEfymoQhgoFzILocmnpRYQ4BnJLfFZRlDwAJO5j1gpOzCgmkH?=
 =?us-ascii?Q?pCYcnL3JaHbJmZYzw3Scm9VgGxxVv9GdDF1hRV/BM1dL5ogiZ1I2bfR0CL7U?=
 =?us-ascii?Q?s1vsTiRCgohUrdhiSXnLshdMIbJCz/kNelbRjCBDL+g78HRrPuRcI57w+cpH?=
 =?us-ascii?Q?ZwLxvSy2DoiVBhmoY8jEnFMoKku01EUSkOIPelryOum8+Fs4AQMnNKyiot8p?=
 =?us-ascii?Q?Vn6AjFZ8ZAuyjXDZCV8HmGmfVBP4XEoE9qqR6ngGETZOk/z0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2088d8-36f7-40c8-6fab-08df31126f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 14:32:15.9906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtfzfV0gzj+ugiixOTwwAa+STLsRp9V8t+gmHvtkt3vts4wUmz4Dr4iVf6QV19gKoRL7sDvvQrdCeQrmaHs83w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
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

> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Friday, October 23, 2026 2:30 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Mario Sopena-Novales
> <Mario.Novales@amd.com>; Caike, Igor <Igor.Caike@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu/gfx12: flush the scratch register write in th=
e ring
> test
>
> The ring test writes 0xCAFEDEAD to SCRATCH_REG0 through MMIO, rings the
> doorbell for the CP to write 0xDEADBEEF with SET_UCONFIG_REG, and polls f=
or
> the new value.
>
> Nothing orders the posted MMIO write against the CP's write: the doorbell
> reaches the CP on another path. With coarse grain clock gating, a GC regi=
ster
> access from the host takes about 2 us, and an awake CP can execute the pa=
cket
> before the 0xCAFEDEAD write lands. The test then reads 0xCAFEDEAD forever
> and fails, although the ring consumed the packet (rptr =3D=3D wptr).
>
> On Navi48, 39 of 10000 back-to-back compute ring tests failed this way.
> None failed when a GC register was read back after the write, or with CGC=
G
> disabled.
>
> Ring tests run on every queue, pipe and IP reset, and a false failure the=
re
> escalates the recovery to a full GPU reset.
>
> Read the scratch register back before ringing the doorbell, as commit
> 3f69d5860f5b ("drm/amdgpu: Add a read to GFX v9.4.3 ring test") does for =
a
> similar race on gfx 9.4.3 with multiple XCCs.

Seems like we should do this for all gfx versions.  Can you check the other=
s and fix them up as well?

Alex

>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index d334fb805020..184e009c8e50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -458,6 +458,11 @@ static int gfx_v12_0_ring_test_ring(struct
> amdgpu_ring *ring)
>       int r;
>
>       WREG32(scratch, 0xCAFEDEAD);
> +     /*
> +      * Read the value back so the posted write reaches the register bef=
ore
> +      * the CP writes the test value; otherwise it can overwrite the res=
ult.
> +      */
> +     RREG32(scratch);
>       r =3D amdgpu_ring_alloc(ring, 5);
>       if (r) {
>               drm_err(adev_to_drm(adev),
> --
> 2.50.1

