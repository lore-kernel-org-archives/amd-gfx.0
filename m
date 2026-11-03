Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40984606A332
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=B5Qo0Mul
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8078D10E343;
	Tue,  3 Nov 2026 06:21:06 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EAE210E343
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 06:20:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrWfkg1/DNVPVSWeMus9PGXkn8Nxr2zgsfQ6jnkbNuAaOSiJeb0gsXtUMWkccjrmOtg38aVDilr9aZSAlkN4fFKFuH8vVU8DOYOIDF4qj2jvs3NozMaxXCWtkqsAtqLH9diRbCm5HhE3W1OuR/gCSgf1tpobyS0Z75yG1KlaID2AWi6Rqc3IotQr38tAQUBhNT1fL5JcXcA9Hakd2MPHPTw1nsreztWf2eTMWGSxo29AvqbuyNQklnVOZdlsFO4lftR2Vh1BOLMzWm4mEpiSys/849G1/X7zEQEzK/d9mveP9oC9TibbW9zhMU7NdQNUimMZYcUEHB64WNn6e6zpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7RaIwTLcpvUKe6N3rne6+hHY8Bt2q1ZvzDvFNxXuk4=;
 b=E5nxI1aG+0N3pLcF9kOJR5aEqNBAPNQFMxrJR22Y8rJWSkAF5HKBwihmdgrC1AlqXau/N07ArvsM4WYL1NEgAe8e1obLrGBWj4LLsOXzCLIuMamvZMIk5uu1Be8bsITrtdXphtl3cRAPKQAA/5w3pCwCAdkuSjOCv8z5TNEQmQEMtl6Apk14RoQA0iE2fD9/RAjVUcJGXSKyAtM9KP0GQsSD+FLzf6izTzEM9WCsXUNCNvxX1gDyEns19anl4orVbN3G/kIl6kXE7D//NFb2ZHYh2KdOit/rObDklYAVXcw8t72zgOBhDtV0ZFG1mTkExrDwSnDaLNGYYmfKJXxjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7RaIwTLcpvUKe6N3rne6+hHY8Bt2q1ZvzDvFNxXuk4=;
 b=B5Qo0MulQOCC9lXz1Zc/J2zltrlNEwhud5X3TOcB6BdZUtmZhSN6wMCJkFFjVGbme/yRgId+T2sGgkEHCTm/cuoB/y5kocpsRMNPwXHWyXy1GY9xEInOji73vVPwbAGxWVtIIpq/32q7LRKKvJmdyYC+N9JUJTNtvM5N15DBAOg=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:20:55 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:20:55 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Thread-Topic: [PATCH 3/3] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Thread-Index: AQHdaBkfmnB7L1hUuEGxfRbBDPIFt7ca/FQAgADm6NA=
Date: Tue, 3 Nov 2026 06:20:55 +0000
Message-ID: <PH7PR12MB6000C31E4F4E72DA6322A9CEFB692@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261030024747.3083509-1-Prike.Liang@amd.com>
 <20261030024747.3083509-3-Prike.Liang@amd.com>
 <MW6PR12MB7072BFE6CF58EFAFBF1E80C4E56A2@MW6PR12MB7072.namprd12.prod.outlook.com>
In-Reply-To: <MW6PR12MB7072BFE6CF58EFAFBF1E80C4E56A2@MW6PR12MB7072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-02T16:11:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|MN2PR12MB4158:EE_
x-ms-office365-filtering-correlation-id: eeeb40a3-3f64-4183-adb0-08df39729e5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|6133799003|10067099003|261102123227099003|22082099003|3023799007|13003099007|38070700021|56012099006|11063799006|4143699003|5023799004|261022105027099003|261026121527099003|261021121427099003|261026140227099003|261022075727099003|261009223027099003|261009220027099003|261009223327099003|261009221727099003|261028144727099003|261009221227099003|260925022911599003|260925021311599003|260925021911599003|261021123027099003;
x-microsoft-antispam-message-info: rqh+PyOSHEe1XIAL5BGY11BRWJSyvIgTfnxLP8SOPzlkhj/RAyBfwUTUqv7VUcEqLiFq867E3QVw0DIUNLVrsvkEYqyqBFHHjsXo5IYmAwTKUkDPSd6YKRz8gUTXUw7ZXHH34vzz2cB8G+teEOv6ki5/XUnxOeWifynxypELsKU2f8fGbeKB8OLidEjdWfcRfwbkuILU26hS6FLRYr7HPgaqqWKqBgZgntiEPfxOJOj1UrufRnLDR/yRBjGhim2LB+IMCtx+AI57NPbv8ImVcR/mFX2U6UnoZCewZ6t8xyCeOTJ5+nfCUU0Mq0mwFOQpq31HGSrnTOhubpd+U0iSwRnqYIjBxaof+emfkphxkbFgu4ho40OmK36TxVQ+oo1liksOqfR0dOf5fvfA3lur7vtQzyzhw1rkDot+tcHo8nGEUFU+Kj43UHwXXFBo53vu2qwm48RfBU/kWC5kflkmdLRtBHDoaQee4Kz/5xpmhDVHzLA8nqb/RCC3etK+yBsjX5o0c9kFXl+acVeWuOyAv9lzu0TALu31iiOD73rGgATZfEOnUSxlLsoK7vFxuXVxK/S8Ncc5sdHZukz9X/oriWVtFhIvdeuJlkZlqOJzC3f0zNivvgdHEGGJddVPY1FfhdzyrNvCvy7YVw9MCTv2NrcZWyPqYN24hM7pMg8Ka0k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(6133799003)(10067099003)(261102123227099003)(22082099003)(3023799007)(13003099007)(38070700021)(56012099006)(11063799006)(4143699003)(5023799004)(261022105027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022075727099003)(261009223027099003)(261009220027099003)(261009223327099003)(261009221727099003)(261028144727099003)(261009221227099003)(260925022911599003)(260925021311599003)(260925021911599003)(261021123027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ooEbGB8E4owatqBtsFYFnf6BQOjoNR1BwIPp/dTr0C7Dj+YnE97Zley8FTqN?=
 =?us-ascii?Q?WXQ74hzid6U8eC4lWAQeoQH5U7gifPcy9h6LwpMzRzXtcekauy6ZdzDVWoeW?=
 =?us-ascii?Q?+7vCc5HCaxcdPuat1iTYCpom3FwLeUeuTiff3b5JRSUhWyI8nXyk0M1+TWWe?=
 =?us-ascii?Q?vb7h4Ej0kHoa5r/HhgTqKabmRVFFJGMUBrmv/a8dRoqhGvnUrZ0WjYfuNCUx?=
 =?us-ascii?Q?ygd+tNlfbzjRkoohCI9vy9JFW26c68LvJeTsJEzDuHL2Tw1JF5PixcYpDW37?=
 =?us-ascii?Q?bfiSA+C98URavbHfxYJQwVmSvqlK9ggVGDNpj0lJlciWeiNSXYDAIock/F40?=
 =?us-ascii?Q?2l6nJLFUIN8xqU9vnwe3bgUUiytJvpyNkpQNG9gXmXBskJBX8Kader8GBucr?=
 =?us-ascii?Q?jscNOUL22YqkpK2mqNfH3nPcuufwKBP0dfisADRZn6zTqQfcW5C2HTn7NZtY?=
 =?us-ascii?Q?//HpmVik+zu1W8GYM0FcxY/LV1QCD7eVA1nnW5/8qUH7Lq29z0S8IsSAtYpN?=
 =?us-ascii?Q?WqfCvarS+T2sxXgL8uivsMVGasNI1D0nJa/G+kTj5+qkcwuWjinyW1AeJ1sN?=
 =?us-ascii?Q?0dSPg/5B6gzpksxpKpj/O2FGFRDvtWydA6XPxwL8tdNw03VFcLSJMgIqwuvL?=
 =?us-ascii?Q?TENsIPrvf91GzKI/7gxIsm3SV+3L0isvWBRotY2AL95J89SC3w1KbI9J8lth?=
 =?us-ascii?Q?VG2N4Oy8/vaVvkrPJfv19EHqawOyACGGImEnvFyt+EsD/ITLptBCdITtBZdw?=
 =?us-ascii?Q?aPl1F8zy4j14Q3n/jPNqlG6C9e/egaIjSJDnNbWAneRTuRJlMQJTp/5wslv3?=
 =?us-ascii?Q?OvdETLM8aFoXRBPiIRb3Pc2xEcnY7WpEozTQOMIU0CgOtmI6AnzmwM2Y7UkI?=
 =?us-ascii?Q?e8ukg6LxZFawA0oIKAvpydabncNDtDrYuV+pVUzHI5GT/o/8jk1eEJnnLHKy?=
 =?us-ascii?Q?MVDgsF7RDaLeuwjdUZzQuydTMeneBToMYh1FTc56Q9Y5fBhg9LYTacjiwIfm?=
 =?us-ascii?Q?CkuaHyj3ySDFJY/HZUhbDPpNNW3aKyB6xYTlb2UoSujmVjkLBbjbzObytLzr?=
 =?us-ascii?Q?OpCmCdVobUjxNiH0CmhKWBwA56F5/0BUAN3UUHJdLfotd+agLvz3pm53R0MP?=
 =?us-ascii?Q?huD79p57cDSkpRwD3sk79O8hvh3XGuojIdK6hAuYQ52/y7foAtoygE/Brzmo?=
 =?us-ascii?Q?rdRaS0ABh4mB6AsyN9ZL8RhUce+bmsG5/rY+jOxc73COX90dIWqH9qrvrKzW?=
 =?us-ascii?Q?nl0whoUZ1e8JIiAVaFvhHmjigFBLr5eZnRaqOz0wuSoS6RpXLRxGRG+yPDo8?=
 =?us-ascii?Q?GxNTeJBqy2rGy2MdhkoXj4tUjKD6PxMzlVE4kXqxuf0O6MEDZssrjm9NlMT0?=
 =?us-ascii?Q?8dNQtfZ93oQ/AO6wtLJxRnURe9iLKolnIGnZe57a303chcowu+Glf0Tgoo4g?=
 =?us-ascii?Q?2dZ9A8RL9EJxMxOQvuFER9+plo0r6AGn/ioLm6nB3iBrt3c631tiavvsGHG8?=
 =?us-ascii?Q?Zs/66bebRIaZMIvQeZ+24pF1VDgyKnmBBEqOXB2tocRPtlDtTlX0qPCjqDn+?=
 =?us-ascii?Q?r+xNAfzJVb1OzqaEnkwAA3qGUUvhWD8GDA8ialwBfxFe7IS6/l4kQur/45y8?=
 =?us-ascii?Q?QYoa7S3XRxGN0M+niPK1mN2xKRnxp8X6mdfPQQ7IBieiEVMWKKOBRkUt51hT?=
 =?us-ascii?Q?kxZMhdQkUnnmsCeimlML0twEBqgk+51ltRXEicwhjQdGp1Xq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeeb40a3-3f64-4183-adb0-08df39729e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 06:20:55.5541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/skJ/sSBITZ1smz+OfgI/UWDFqkI9AtAMuTmFBZ4YFRKnZ7EwPAkLVh571ym5zO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Regards,
      Prike

> -----Original Message-----
> From: Liu, Leo <Leo.Liu@amd.com>
> Sent: Tuesday, November 3, 2026 12:22 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak, Vi=
taly
> <Vitaly.Prosyak@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>
> Subject: RE: [PATCH 3/3] drm/amdgpu: stop GPU recovery wait for the JPEG/=
VCN
> idle work
>
> AMD General
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Prike Liang
> > Sent: Thursday, October 29, 2026 10:48 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak,
> > Vitaly <Vitaly.Prosyak@amd.com>; Liang, Prike <Prike.Liang@amd.com>;
> > Lazar, Lijo <Lijo.Lazar@amd.com>
> > Subject: [PATCH 3/3] drm/amdgpu: stop GPU recovery wait for the
> > JPEG/VCN idle work
> >
> > The common JPEG and VCN idle workers program power gating and DPG
> > pause, so they must not run while a GPU reset is in progress. Recovery
> > must not wait for them either, since everything the workers depend on
> > then becomes a dependency of GPU recovery.
> >
> > Make the workers take reset_domain->sem for read, so they wait for a
> > running reset instead of touching the hardware. hw_fini/suspend, the
> > hw_init error paths and begin_use, the latter for the IB tests, run
> > from GPU recovery as well, so only skip waiting for the idle work when
> > the reset itself calls them. The reset holds the semaphore for write
> > and would otherwise deadlock on a worker blocked on it. Outside a
> > reset the cancel stays synchronous as before.
> >
> > A device can also be torn down while a peer in its XGMI reset domain
> > is being reset. hw_fini then doesn't wait for the worker either, and
> > is skipped entirely if the peer's reset has already suspended the devic=
e.
> > Cancel the idle work synchronously in early_fini, which only runs on
> > teardown and before any hw_fini, so the worker is done before the
> > hardware it touches is torn down.
> >
> > Update versions:
> > v1: https://lists.freedesktop.org/archives/amd-gfx/2026-
> > October/155441.html
> > v2: https://lists.freedesktop.org/archives/amd-gfx/2026-
> > October/156119.html
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com> Cc; Leo Liu
> > <leo.liu@amd.com>
> > Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 30
> > ++++++++++++++++++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  1 +
> > drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 36
> > +++++++++++++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  2 ++
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  5 ++--
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 ++--
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  5 ++--
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  5 ++--
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  5 ++--
> > drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  5 ++--
> > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  5 ++--
> > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  5 ++--
> > drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  5 ++--
> > drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  5 ++--
> >  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 +--
> >  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  5 ++--
> >  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 +--
> >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  5 ++--
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  5 ++--
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  5 ++--
> > drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  5 ++--
> > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  5 ++--
> > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  5 ++--
> > drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  5 ++--
> >  24 files changed, 125 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > index 2b0e658b63b6..87f0ba6a79d6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > @@ -95,9 +95,30 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device
> > *adev)
> >       return 0;
> >  }
> >
> > +int amdgpu_jpeg_early_fini(struct amdgpu_ip_block *ip_block) {
> > +     /* Called on teardown even if sw_init never ran */
> > +     if (!ip_block->status.sw)
> > +             return 0;
> > +
> > +     /* hw_fini may not wait while a peer in the reset domain resets *=
/
> > +     cancel_delayed_work_sync(&ip_block->adev->jpeg.idle_work);
> > +
>
> With early_fini(), hw_fini(), suspend() and sw_fini() now all potentially=
 calling the
> cancel for the different fini paths, the cancel now happens multiple time=
s without
> explicit conditions to make clear when each call is actually needed.
> For example, on the normal unload/teardown path,  early_fini() cancels
> synchronously, then hw_fini() cancels again (no-op), then sw_fini() cance=
ls again
> (no-op).  It would be cleaner to add an explicit condition at each call.

Agreed. The repeated cancels in the *_fini callbacks are harmless no-ops,
but they look duplicated and don't make clear which path needs them. To
keep this readable, I'll cancel the idle work in one place per path:
early_fini() for teardown, and hw_fini() for suspend and GPU reset (only
when !adev->shutdown). I'll also remove the cancels from sw_fini() and
the JPEG suspend(), and send the update in the next version of the patch.

Thanks,
Prike

> Thanks,
> Leo
>
>
> > +     return 0;
> > +}
> > +
> > +static void amdgpu_jpeg_cancel_idle_work(struct amdgpu_device *adev)
> > +{
> > +     /* The reset mustn't wait for the idle work, which waits for the =
reset */
> > +     if (amdgpu_in_reset(adev))
> > +             cancel_delayed_work(&adev->jpeg.idle_work);
> > +     else
> > +             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +}
> > +
> >  int amdgpu_jpeg_suspend(struct amdgpu_device *adev)  {
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_cancel_idle_work(adev);
> >
> >       return 0;
> >  }
> > @@ -114,6 +135,9 @@ static void amdgpu_jpeg_idle_work_handler(struct
> > work_struct *work)
> >       unsigned int fences =3D 0;
> >       unsigned int i, j;
> >
> > +     /* Nothing holding the reset semaphore waits for this work */
> > +     down_read(&adev->reset_domain->sem);
> > +
> >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> >               if (adev->jpeg.harvest_config & (1U << i))
> >                       continue;
> > @@ -129,6 +153,8 @@ static void amdgpu_jpeg_idle_work_handler(struct
> > work_struct *work)
> >               mutex_unlock(&adev->jpeg.jpeg_pg_lock);
> >       } else
> >               schedule_delayed_work(&adev->jpeg.idle_work,
> > JPEG_IDLE_TIMEOUT);
> > +
> > +     up_read(&adev->reset_domain->sem);
> >  }
> >
> >  void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
> > @@ -136,7 +162,7 @@ void amdgpu_jpeg_ring_begin_use(struct
> > amdgpu_ring *ring)
> >       struct amdgpu_device *adev =3D ring->adev;
> >
> >       if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
> > -             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +             amdgpu_jpeg_cancel_idle_work(adev);
> >
> >       mutex_lock(&adev->jpeg.jpeg_pg_lock);
> >       amdgpu_device_ip_set_powergating_state(adev,
> > AMD_IP_BLOCK_TYPE_JPEG,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> > index 05d58e6bbfab..a473becb5def 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> > @@ -156,6 +156,7 @@ struct amdgpu_jpeg {
> >
> >  int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
> >  int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev);
> > +int amdgpu_jpeg_early_fini(struct amdgpu_ip_block *ip_block);
> >  int amdgpu_jpeg_suspend(struct amdgpu_device *adev);
> >  int amdgpu_jpeg_resume(struct amdgpu_device *adev);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > index 34e1242d66ea..6c12d8aa3c76 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > @@ -299,6 +299,26 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device
> > *adev, int i)
> >       mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
> >  }
> >
> > +int amdgpu_vcn_early_fini(struct amdgpu_ip_block *ip_block)
> > +{
> > +     struct amdgpu_device *adev =3D ip_block->adev;
> > +     int i;
> > +
> > +     /* Called on teardown even if sw_init never ran */
> > +     if (!ip_block->status.sw)
> > +             return 0;
> > +
> > +     /* hw_fini may not wait while a peer in the reset domain resets *=
/
> > +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > +             if (adev->vcn.harvest_config & (1 << i))
> > +                     continue;
> > +
> > +             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum
> > vcn_ring_type type, uint32_t vcn_instance)
> >  {
> >       bool ret =3D false;
> > @@ -459,6 +479,15 @@ void amdgpu_vcn_put_profile(struct
> > amdgpu_device *adev)
> >       mutex_unlock(&adev->vcn.workload_profile_mutex);
> >  }
> >
> > +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst)
> > +{
> > +     /* The reset mustn't wait for the idle work, which waits for the =
reset */
> > +     if (amdgpu_in_reset(vcn_inst->adev))
> > +             cancel_delayed_work(&vcn_inst->idle_work);
> > +     else
> > +             cancel_delayed_work_sync(&vcn_inst->idle_work);
> > +}
> > +
> >  static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
> >  {
> >       struct amdgpu_vcn_inst *vcn_inst =3D
> > @@ -470,6 +499,9 @@ static void amdgpu_vcn_idle_work_handler(struct
> > work_struct *work)
> >       if (adev->vcn.harvest_config & (1 << i))
> >               return;
> >
> > +     /* Nothing holding the reset semaphore waits for this work */
> > +     down_read(&adev->reset_domain->sem);
> > +
> >       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> >               fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst-
> > >ring_enc[j]);
> >
> > @@ -499,6 +531,8 @@ static void amdgpu_vcn_idle_work_handler(struct
> > work_struct *work)
> >       } else {
> >               schedule_delayed_work(&vcn_inst->idle_work,
> > VCN_IDLE_TIMEOUT);
> >       }
> > +
> > +     up_read(&adev->reset_domain->sem);
> >  }
> >
> >  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
> > @@ -507,7 +541,7 @@ void amdgpu_vcn_ring_begin_use(struct
> > amdgpu_ring *ring)
> >       struct amdgpu_vcn_inst *vcn_inst =3D &adev->vcn.inst[ring->me];
> >
> >       if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
> > -             cancel_delayed_work_sync(&vcn_inst->idle_work);
> > +             amdgpu_vcn_cancel_idle_work(vcn_inst);
> >
> >       mutex_lock(&vcn_inst->vcn_pg_lock);
> >       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > index bea95307fd42..509c83799a8a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > @@ -522,10 +522,12 @@ enum vcn_ring_type {
> >  int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i);
> >  int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i);
> >  void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i);
> > +int amdgpu_vcn_early_fini(struct amdgpu_ip_block *ip_block);
> >  int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
> >  int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
> >  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
> >  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> > +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst);
> >
> >  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
> >                               enum vcn_ring_type type, uint32_t
> > vcn_instance);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > index f03c1a37c8dd..1b498190954d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > @@ -166,7 +166,7 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block
> > *ip_block)
> >
> >       r =3D amdgpu_ring_test_helper(ring);
> >       if (r)
> > -             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +             amdgpu_jpeg_suspend(adev);
> >       return r;
> >  }
> >
> > @@ -181,7 +181,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block
> > *ip_block)
> >  {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >
> >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> >             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> > @@ -792,6 +792,7 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs
> > =3D {
> >       .early_init =3D jpeg_v2_0_early_init,
> >       .sw_init =3D jpeg_v2_0_sw_init,
> >       .sw_fini =3D jpeg_v2_0_sw_fini,
> > +     .early_fini =3D amdgpu_jpeg_early_fini,
> >       .hw_init =3D jpeg_v2_0_hw_init,
> >       .hw_fini =3D jpeg_v2_0_hw_fini,
> >       .suspend =3D jpeg_v2_0_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > index 46293664fd28..80c79aeeb410 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > @@ -227,7 +227,7 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block
> > *ip_block)
> >       return 0;
> >
> >  error:
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >       return r;
> >  }
> >
> > @@ -243,7 +243,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block
> > *ip_block)
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >       int i;
> >
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >
> >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> >               if (adev->jpeg.harvest_config & (1 << i))
> > @@ -665,6 +665,7 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs
> > =3D {
> >       .early_init =3D jpeg_v2_5_early_init,
> >       .sw_init =3D jpeg_v2_5_sw_init,
> >       .sw_fini =3D jpeg_v2_5_sw_fini,
> > +     .early_fini =3D amdgpu_jpeg_early_fini,
> >       .hw_init =3D jpeg_v2_5_hw_init,
> >       .hw_fini =3D jpeg_v2_5_hw_fini,
> >       .suspend =3D jpeg_v2_5_suspend,
> > @@ -681,6 +682,7 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs
> > =3D {
> >       .early_init =3D jpeg_v2_5_early_init,
> >       .sw_init =3D jpeg_v2_5_sw_init,
> >       .sw_fini =3D jpeg_v2_5_sw_fini,
> > +     .early_fini =3D amdgpu_jpeg_early_fini,
> >       .hw_init =3D jpeg_v2_5_hw_init,
> >       .hw_fini =3D jpeg_v2_5_hw_fini,
> >       .suspend =3D jpeg_v2_5_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > index 361d0f4b4bc7..3411a32d00ee 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > @@ -181,7 +181,7 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block
> > *ip_block)
> >
> >       r =3D amdgpu_ring_test_helper(ring);
> >       if (r)
> > -             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +             amdgpu_jpeg_suspend(adev);
> >       return r;
> >  }
> >
> > @@ -196,7 +196,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block
> > *ip_block)
> >  {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >
> >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> >             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> > @@ -564,6 +564,7 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs
> > =3D {
> >       .early_init =3D jpeg_v3_0_early_init,
> >       .sw_init =3D jpeg_v3_0_sw_init,
> >       .sw_fini =3D jpeg_v3_0_sw_fini,
> > +     .early_fini =3D amdgpu_jpeg_early_fini,
> >       .hw_init =3D jpeg_v3_0_hw_init,
> >       .hw_fini =3D jpeg_v3_0_hw_fini,
> >       .suspend =3D jpeg_v3_0_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > index 4e8eed2b62db..4a916cc2bd01 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > @@ -210,7 +210,7 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block
> > *ip_block)
> >       return 0;
> >
> >  error:
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >       return r;
> >  }
> >
> > @@ -225,7 +225,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block
> > *ip_block)
> >  {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >       if (!amdgpu_sriov_vf(adev)) {
> >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> >                       RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> > @@ -748,6 +748,7 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs
> > =3D {
> >       .early_init =3D jpeg_v4_0_early_init,
> >       .sw_init =3D jpeg_v4_0_sw_init,
> >       .sw_fini =3D jpeg_v4_0_sw_fini,
> > +     .early_fini =3D amdgpu_jpeg_early_fini,
> >       .hw_init =3D jpeg_v4_0_hw_init,
> >       .hw_fini =3D jpeg_v4_0_hw_fini,
> >       .suspend =3D jpeg_v4_0_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > index 9f298c4ea8ff..6b62731495ab 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > @@ -443,7 +443,7 @@ static int jpeg_v4_0_3_hw_init(struct
> > amdgpu_ip_block *ip_block)
> >       return 0;
> >
> >  error:
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >       return r;
> >  }
> >
> > @@ -459,7 +459,7 @@ static int jpeg_v4_0_3_hw_fini(struct
> > amdgpu_ip_block *ip_block)
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >       int ret =3D 0;
> >
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >
> >       if (!amdgpu_sriov_vf(adev)) {
> >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
> > @@ -1227,6 +1227,7 @@ static const struct amd_ip_funcs
> > jpeg_v4_0_3_ip_funcs =3D {
> >       .early_init =3D jpeg_v4_0_3_early_init,
> >       .sw_init =3D jpeg_v4_0_3_sw_init,
> >       .sw_fini =3D jpeg_v4_0_3_sw_fini,
> > +     .early_fini =3D amdgpu_jpeg_early_fini,
> >       .hw_init =3D jpeg_v4_0_3_hw_init,
> >       .hw_fini =3D jpeg_v4_0_3_hw_fini,
> >       .suspend =3D jpeg_v4_0_3_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > index a1496412810c..109237055eba 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> > @@ -238,7 +238,7 @@ static int jpeg_v4_0_5_hw_init(struct
> > amdgpu_ip_block *ip_block)
> >       return 0;
> >
> >  error:
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >       return r;
> >  }
> >
> > @@ -254,7 +254,7 @@ static int jpeg_v4_0_5_hw_fini(struct
> > amdgpu_ip_block *ip_block)
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >       int i;
> >
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >
> >       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> >               if (adev->jpeg.harvest_config & (1 << i))
> > @@ -807,6 +807,7 @@ static const struct amd_ip_funcs
> > jpeg_v4_0_5_ip_funcs =3D {
> >       .early_init =3D jpeg_v4_0_5_early_init,
> >       .sw_init =3D jpeg_v4_0_5_sw_init,
> >       .sw_fini =3D jpeg_v4_0_5_sw_fini,
> > +     .early_fini =3D amdgpu_jpeg_early_fini,
> >       .hw_init =3D jpeg_v4_0_5_hw_init,
> >       .hw_fini =3D jpeg_v4_0_5_hw_fini,
> >       .suspend =3D jpeg_v4_0_5_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > index 1a4594d5d952..c0bacaafdf7f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > @@ -178,7 +178,7 @@ static int jpeg_v5_0_0_hw_init(struct
> > amdgpu_ip_block *ip_block)
> >       return 0;
> >
> >  error:
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >       return r;
> >  }
> >
> > @@ -193,7 +193,7 @@ static int jpeg_v5_0_0_hw_fini(struct
> > amdgpu_ip_block *ip_block)
> >  {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >
> >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> >             RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> > @@ -683,6 +683,7 @@ static const struct amd_ip_funcs
> > jpeg_v5_0_0_ip_funcs =3D {
> >       .early_init =3D jpeg_v5_0_0_early_init,
> >       .sw_init =3D jpeg_v5_0_0_sw_init,
> >       .sw_fini =3D jpeg_v5_0_0_sw_fini,
> > +     .early_fini =3D amdgpu_jpeg_early_fini,
> >       .hw_init =3D jpeg_v5_0_0_hw_init,
> >       .hw_fini =3D jpeg_v5_0_0_hw_fini,
> >       .suspend =3D jpeg_v5_0_0_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > index efdc537ec81e..9ae23235d16c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > @@ -314,7 +314,7 @@ static int jpeg_v5_0_1_hw_init(struct
> > amdgpu_ip_block *ip_block)
> >       return 0;
> >
> >  error:
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >       return r;
> >  }
> >
> > @@ -330,7 +330,7 @@ static int jpeg_v5_0_1_hw_fini(struct
> > amdgpu_ip_block *ip_block)
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >       int ret =3D 0;
> >
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >
> >       if (!amdgpu_sriov_vf(adev)) {
> >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
> > @@ -887,6 +887,7 @@ static const struct amd_ip_funcs
> > jpeg_v5_0_1_ip_funcs =3D {
> >       .late_init =3D NULL,
> >       .sw_init =3D jpeg_v5_0_1_sw_init,
> >       .sw_fini =3D jpeg_v5_0_1_sw_fini,
> > +     .early_fini =3D amdgpu_jpeg_early_fini,
> >       .hw_init =3D jpeg_v5_0_1_hw_init,
> >       .hw_fini =3D jpeg_v5_0_1_hw_fini,
> >       .suspend =3D jpeg_v5_0_1_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > index eb3dc9558e0d..0fc58d25abe1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> > @@ -287,7 +287,7 @@ static int jpeg_v5_0_2_hw_init(struct
> > amdgpu_ip_block *ip_block)
> >       return 0;
> >
> >  error:
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >       return r;
> >  }
> >
> > @@ -303,7 +303,7 @@ static int jpeg_v5_0_2_hw_fini(struct
> > amdgpu_ip_block *ip_block)
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >       int ret =3D 0;
> >
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >
> >       if (!amdgpu_sriov_vf(adev)) {
> >               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
> > @@ -871,6 +871,7 @@ static const struct amd_ip_funcs
> > jpeg_v5_0_2_ip_funcs =3D {
> >       .late_init =3D NULL,
> >       .sw_init =3D jpeg_v5_0_2_sw_init,
> >       .sw_fini =3D jpeg_v5_0_2_sw_fini,
> > +     .early_fini =3D amdgpu_jpeg_early_fini,
> >       .hw_init =3D jpeg_v5_0_2_hw_init,
> >       .hw_fini =3D jpeg_v5_0_2_hw_fini,
> >       .suspend =3D jpeg_v5_0_2_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > index 0cbb2b8a7e78..d5bc6820ad8d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > @@ -161,7 +161,7 @@ static int jpeg_v5_3_0_hw_init(struct
> > amdgpu_ip_block *ip_block)
> >       return 0;
> >
> >  error:
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >       return r;
> >  }
> >
> > @@ -176,7 +176,7 @@ static int jpeg_v5_3_0_hw_fini(struct
> > amdgpu_ip_block *ip_block)
> >  {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >
> > -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +     amdgpu_jpeg_suspend(adev);
> >
> >       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> >             RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
> > @@ -671,6 +671,7 @@ static const struct amd_ip_funcs
> > jpeg_v5_3_0_ip_funcs =3D {
> >       .early_init =3D jpeg_v5_3_0_early_init,
> >       .sw_init =3D jpeg_v5_3_0_sw_init,
> >       .sw_fini =3D jpeg_v5_3_0_sw_fini,
> > +     .early_fini =3D amdgpu_jpeg_early_fini,
> >       .hw_init =3D jpeg_v5_3_0_hw_init,
> >       .hw_fini =3D jpeg_v5_3_0_hw_fini,
> >       .suspend =3D jpeg_v5_3_0_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > index b3e63d6e79a8..897310d04f83 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > @@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block
> > *ip_block)
> >       if (r)
> >               return r;
> >
> > -     /* Override the work func */
> > -     adev->vcn.inst[0].idle_work.work.func =3D
> > vcn_v1_0_idle_work_handler;
> > +     /* Own lockdep class, this work is still cancelled synchronously =
*/
> > +     INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work,
> > vcn_v1_0_idle_work_handler);
> >
> >       amdgpu_vcn_setup_ucode(adev, 0);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > index 12ac20484396..706089744803 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > @@ -310,7 +310,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block
> > *ip_block)
> >       return 0;
> >
> >  error:
> > -     cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
> > +     amdgpu_vcn_cancel_idle_work(adev->vcn.inst);
> >       return r;
> >  }
> >
> > @@ -326,7 +326,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block
> > *ip_block)
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >       struct amdgpu_vcn_inst *vinst =3D adev->vcn.inst;
> >
> > -     cancel_delayed_work_sync(&vinst->idle_work);
> > +     amdgpu_vcn_cancel_idle_work(vinst);
> >
> >       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> >           (vinst->cur_state !=3D AMD_PG_STATE_GATE &&
> > @@ -2103,6 +2103,7 @@ static const struct amd_ip_funcs
> > vcn_v2_0_ip_funcs =3D {
> >       .early_init =3D vcn_v2_0_early_init,
> >       .sw_init =3D vcn_v2_0_sw_init,
> >       .sw_fini =3D vcn_v2_0_sw_fini,
> > +     .early_fini =3D amdgpu_vcn_early_fini,
> >       .hw_init =3D vcn_v2_0_hw_init,
> >       .hw_fini =3D vcn_v2_0_hw_fini,
> >       .suspend =3D vcn_v2_0_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > index 2b2abe689508..c3f2265f50fc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > @@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block
> > *ip_block)
> >               if (r)
> >                       return r;
> >
> > -             /* Override the work func */
> > -             adev->vcn.inst[j].idle_work.work.func =3D
> > vcn_v2_5_idle_work_handler;
> > +             /* Own lockdep class, this work is still cancelled synchr=
onously
> > */
> > +             INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work,
> > vcn_v2_5_idle_work_handler);
> >
> >               amdgpu_vcn_setup_ucode(adev, j);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > index 6543f21daa1e..8f256d962ce5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > @@ -433,7 +433,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block
> > *ip_block)
> >  error:
> >       while (i >=3D 0) {
> >               if (!(adev->vcn.harvest_config & (1 << i)))
> > -                     cancel_delayed_work_sync(&adev-
> > >vcn.inst[i].idle_work);
> > +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> >               i--;
> >       }
> >       return r;
> > @@ -457,7 +457,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block
> > *ip_block)
> >               if (adev->vcn.harvest_config & (1 << i))
> >                       continue;
> >
> > -             cancel_delayed_work_sync(&vinst->idle_work);
> > +             amdgpu_vcn_cancel_idle_work(vinst);
> >
> >               if (!amdgpu_sriov_vf(adev)) {
> >                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > ||
> > @@ -2366,6 +2366,7 @@ static const struct amd_ip_funcs
> > vcn_v3_0_ip_funcs =3D {
> >       .early_init =3D vcn_v3_0_early_init,
> >       .sw_init =3D vcn_v3_0_sw_init,
> >       .sw_fini =3D vcn_v3_0_sw_fini,
> > +     .early_fini =3D amdgpu_vcn_early_fini,
> >       .hw_init =3D vcn_v3_0_hw_init,
> >       .hw_fini =3D vcn_v3_0_hw_fini,
> >       .suspend =3D vcn_v3_0_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > index 8b5646297c2e..b68746b37a15 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > @@ -358,7 +358,7 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block
> > *ip_block)
> >  error:
> >       while (i >=3D 0) {
> >               if (!(adev->vcn.harvest_config & (1 << i)))
> > -                     cancel_delayed_work_sync(&adev-
> > >vcn.inst[i].idle_work);
> > +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> >               i--;
> >       }
> >       return r;
> > @@ -382,7 +382,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block
> > *ip_block)
> >               if (adev->vcn.harvest_config & (1 << i))
> >                       continue;
> >
> > -             cancel_delayed_work_sync(&vinst->idle_work);
> > +             amdgpu_vcn_cancel_idle_work(vinst);
> >
> >               if (!amdgpu_sriov_vf(adev)) {
> >                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > ||
> > @@ -2287,6 +2287,7 @@ static const struct amd_ip_funcs
> > vcn_v4_0_ip_funcs =3D {
> >       .early_init =3D vcn_v4_0_early_init,
> >       .sw_init =3D vcn_v4_0_sw_init,
> >       .sw_fini =3D vcn_v4_0_sw_fini,
> > +     .early_fini =3D amdgpu_vcn_early_fini,
> >       .hw_init =3D vcn_v4_0_hw_init,
> >       .hw_fini =3D vcn_v4_0_hw_fini,
> >       .suspend =3D vcn_v4_0_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > index 0c58ca25d7b5..a1bfcece38fb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > @@ -404,7 +404,7 @@ static int vcn_v4_0_3_hw_init(struct
> > amdgpu_ip_block *ip_block)
> >  error:
> >       while (i >=3D 0) {
> >               if (!(adev->vcn.harvest_config & (1 << i)))
> > -                     cancel_delayed_work_sync(&adev-
> > >vcn.inst[i].idle_work);
> > +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> >               i--;
> >       }
> >       return r;
> > @@ -425,7 +425,7 @@ static int vcn_v4_0_3_hw_fini(struct
> > amdgpu_ip_block *ip_block)
> >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
> >
> > -             cancel_delayed_work_sync(&vinst->idle_work);
> > +             amdgpu_vcn_cancel_idle_work(vinst);
> >
> >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> >                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
> > @@ -2035,6 +2035,7 @@ static const struct amd_ip_funcs
> > vcn_v4_0_3_ip_funcs =3D {
> >       .late_init =3D vcn_v4_0_3_late_init,
> >       .sw_init =3D vcn_v4_0_3_sw_init,
> >       .sw_fini =3D vcn_v4_0_3_sw_fini,
> > +     .early_fini =3D amdgpu_vcn_early_fini,
> >       .hw_init =3D vcn_v4_0_3_hw_init,
> >       .hw_fini =3D vcn_v4_0_3_hw_fini,
> >       .suspend =3D vcn_v4_0_3_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > index a6eaa57ec2ee..fb5336f46ac9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > @@ -311,7 +311,7 @@ static int vcn_v4_0_5_hw_init(struct
> > amdgpu_ip_block *ip_block)
> >  error:
> >       while (i >=3D 0) {
> >               if (!(adev->vcn.harvest_config & (1 << i)))
> > -                     cancel_delayed_work_sync(&adev-
> > >vcn.inst[i].idle_work);
> > +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> >               i--;
> >       }
> >       return r;
> > @@ -335,7 +335,7 @@ static int vcn_v4_0_5_hw_fini(struct
> > amdgpu_ip_block *ip_block)
> >               if (adev->vcn.harvest_config & (1 << i))
> >                       continue;
> >
> > -             cancel_delayed_work_sync(&vinst->idle_work);
> > +             amdgpu_vcn_cancel_idle_work(vinst);
> >
> >               if (!amdgpu_sriov_vf(adev)) {
> >                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > ||
> > @@ -1690,6 +1690,7 @@ static const struct amd_ip_funcs
> > vcn_v4_0_5_ip_funcs =3D {
> >       .early_init =3D vcn_v4_0_5_early_init,
> >       .sw_init =3D vcn_v4_0_5_sw_init,
> >       .sw_fini =3D vcn_v4_0_5_sw_fini,
> > +     .early_fini =3D amdgpu_vcn_early_fini,
> >       .hw_init =3D vcn_v4_0_5_hw_init,
> >       .hw_fini =3D vcn_v4_0_5_hw_fini,
> >       .suspend =3D vcn_v4_0_5_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > index 055729a42094..b18c61e6d099 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > @@ -275,7 +275,7 @@ static int vcn_v5_0_0_hw_init(struct
> > amdgpu_ip_block *ip_block)
> >  error:
> >       while (i >=3D 0) {
> >               if (!(adev->vcn.harvest_config & (1 << i)))
> > -                     cancel_delayed_work_sync(&adev-
> > >vcn.inst[i].idle_work);
> > +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> >               i--;
> >       }
> >       return r;
> > @@ -299,7 +299,7 @@ static int vcn_v5_0_0_hw_fini(struct
> > amdgpu_ip_block *ip_block)
> >               if (adev->vcn.harvest_config & (1 << i))
> >                       continue;
> >
> > -             cancel_delayed_work_sync(&vinst->idle_work);
> > +             amdgpu_vcn_cancel_idle_work(vinst);
> >
> >               if (!amdgpu_sriov_vf(adev)) {
> >                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > ||
> > @@ -1476,6 +1476,7 @@ static const struct amd_ip_funcs
> > vcn_v5_0_0_ip_funcs =3D {
> >       .early_init =3D vcn_v5_0_0_early_init,
> >       .sw_init =3D vcn_v5_0_0_sw_init,
> >       .sw_fini =3D vcn_v5_0_0_sw_fini,
> > +     .early_fini =3D amdgpu_vcn_early_fini,
> >       .hw_init =3D vcn_v5_0_0_hw_init,
> >       .hw_fini =3D vcn_v5_0_0_hw_fini,
> >       .suspend =3D vcn_v5_0_0_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > index 55a4b2f9463f..a5d3ee06fced 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > @@ -351,7 +351,7 @@ static int vcn_v5_0_1_hw_init(struct
> > amdgpu_ip_block *ip_block)
> >  error:
> >       while (i >=3D 0) {
> >               if (!(adev->vcn.harvest_config & (1 << i)))
> > -                     cancel_delayed_work_sync(&adev-
> > >vcn.inst[i].idle_work);
> > +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> >               i--;
> >       }
> >       return r;
> > @@ -372,7 +372,7 @@ static int vcn_v5_0_1_hw_fini(struct
> > amdgpu_ip_block *ip_block)
> >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
> >
> > -             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> > +             amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> >                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
> >       }
> > @@ -1660,6 +1660,7 @@ static const struct amd_ip_funcs
> > vcn_v5_0_1_ip_funcs =3D {
> >       .late_init =3D vcn_v5_0_1_late_init,
> >       .sw_init =3D vcn_v5_0_1_sw_init,
> >       .sw_fini =3D vcn_v5_0_1_sw_fini,
> > +     .early_fini =3D amdgpu_vcn_early_fini,
> >       .hw_init =3D vcn_v5_0_1_hw_init,
> >       .hw_fini =3D vcn_v5_0_1_hw_fini,
> >       .suspend =3D vcn_v5_0_1_suspend,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > index ea6cdbcb6352..1b7897bb9953 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> > @@ -266,7 +266,7 @@ static int vcn_v5_0_2_hw_init(struct
> > amdgpu_ip_block *ip_block)
> >  error:
> >       while (i >=3D 0) {
> >               if (!(adev->vcn.harvest_config & (1 << i)))
> > -                     cancel_delayed_work_sync(&adev-
> > >vcn.inst[i].idle_work);
> > +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> >               i--;
> >       }
> >       return r;
> > @@ -287,7 +287,7 @@ static int vcn_v5_0_2_hw_fini(struct
> > amdgpu_ip_block *ip_block)
> >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
> >
> > -             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> > +             amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> >               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
> >                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
> >       }
> > @@ -1451,6 +1451,7 @@ static const struct amd_ip_funcs
> > vcn_v5_0_2_ip_funcs =3D {
> >       .late_init =3D NULL,
> >       .sw_init =3D vcn_v5_0_2_sw_init,
> >       .sw_fini =3D vcn_v5_0_2_sw_fini,
> > +     .early_fini =3D amdgpu_vcn_early_fini,
> >       .hw_init =3D vcn_v5_0_2_hw_init,
> >       .hw_fini =3D vcn_v5_0_2_hw_fini,
> >       .suspend =3D vcn_v5_0_2_suspend,
> > --
> > 2.34.1
>

