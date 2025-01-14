Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D90E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 17:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E0210E1B5;
	Tue, 14 Jan 2025 17:13:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5EP2LfrP";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8164910E1B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 17:13:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pikpbo0g+aSazJ2rfYIhVuyr4hXW0qR2qp+lA4T6DnclFr4D0OwaQ8abNSdxKUC/gm5O429wp98r74pSigGibo3/eSOm3Lweeek4UTUBZsHR3y9tCmEGB6Qk+Nqk1MIhLJZEEf8MweAPrseztZ6p3/D/jdUXtJGIwkacH07Mje/7ZPuroAFGP+Y3Yt6YhmLs3k9DdmGVCqbta4w1rM6cZt1dLt9vohrlwpszGwOnu4PN0NIhmQh3R4FZPmE9Ul3O9r27uOogUrwn4v4t1d0OvobtCKMHzy9HtQEPq2VyfLwwnR8r0XSDAtJaF2N3+mTXFSXB4B+DBbgX3e20z1/zxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1LHNROEcK9EgneCZ5Dti47SypWTbdVTwLrooy1zpj0=;
 b=k7FBT0MieVVaxMbaE8YZbR6JZaXVfBxmSzjQaFvzqBy1jxVgHP6Z4di7KxA8V//c6+QHIGaEuQ2TUyiQg6w0rlD2XpPoqn6meb7WHare+quD9suG/frv/Cwg+ENHZnkwNAmmDsVjM4Q0nM1MTebUc7T5qkqGpQFg5yome/bxhynDUm29u7MQz3yeCEk0sbGXW8W2eZ8eRkZUA6CY0zYUda0Qrp6eYEBZ0JyjWMGP1L2wNQPbWiSTtMEgzUxjjGLedNxQnThHyFTEwvBL4wY0SPxcXlXJYTBdNBtoIXCksqfPLko7FYF4aszjHDYLGcVo6ZpDICyhebOyEUjxt27sPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1LHNROEcK9EgneCZ5Dti47SypWTbdVTwLrooy1zpj0=;
 b=5EP2LfrPcHKZGpluPXj9jKbyuLKgyw7SajP7dZCAmwgMy+FTD+aIHBCm3QbXpHzufXgLh6DuuoeaoucvzrAHfwaLBrlmMoHRDUAw8RVH90E2rxm5xGlnREhLCZzro3xpcsQs6bX096NfNmwpsQ7JcXNPbSF9k5Mv81G4w1RYOLg=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 17:13:41 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 17:13:40 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: validate process_context_addr for the MES
 shader debugger
Thread-Topic: [PATCH] drm/amdgpu: validate process_context_addr for the MES
 shader debugger
Thread-Index: AQHbZkNa/koG/R+y6U+zZIWe4qYqD7MWfdzA
Date: Tue, 14 Jan 2025 17:13:40 +0000
Message-ID: <CY8PR12MB7435E8013AF15165A30B8D0585182@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250114051520.2917015-1-Prike.Liang@amd.com>
In-Reply-To: <20250114051520.2917015-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ff1206e8-ebed-451f-92c9-5ad0389420fd;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-14T17:13:09Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MN6PR12MB8591:EE_
x-ms-office365-filtering-correlation-id: 2569d262-91d7-497a-9d37-08dd34becae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RwRi5Jo6O5TE5N8hrlHPKUupZYDRRTx+XZL5nreFUJRKqMtonI999qi+Vcgd?=
 =?us-ascii?Q?ECWi+MVo9a7Aow50MV6/Lp/If48fx5lq/fUTX/1oMkMCx/jJ4pjP1soaU2Ey?=
 =?us-ascii?Q?4wB+SkYA9dZiaoi6auz4S12Kx8JAXIpP/lZ5zLMzPp8qhpw2/OiuFHqd7Eq4?=
 =?us-ascii?Q?qGRrp/et/wtWchwfr052Rb//PWlpb64L24PcgMPFoclFA03ZwPcoJfNTI+iX?=
 =?us-ascii?Q?1X0ChOjbRtUCHYTO0x6apO+tuLuA1emQBfude6WPaMv1n9F7W4cZxrBGxaHd?=
 =?us-ascii?Q?DklGyiqElnJrgVIX7CoIq1/69FCq0XVtg03XvAuAIvJu2CfP636BPVFlyvir?=
 =?us-ascii?Q?4e7P14QFbDGOygRTg6//6uJTFzX50b0KrL5DCARWvsX6Gqz2a/JCgPSscxSy?=
 =?us-ascii?Q?vxO7xWrQhIRr/11GIVdZF180wy8reoFKs6VixFRWi73otRFwZLborz33a6P5?=
 =?us-ascii?Q?yYpHyLOpoGDfEsx0fTOQwwHTG9rWKjK21QIiyE9yI/xYOnMLuaMxibgeTpCf?=
 =?us-ascii?Q?IcsS+JPF8m+3VnZ1NWVtoZRim6EZEnttpkVLCilUC0Anq9uhaLVJNFZ2L7m1?=
 =?us-ascii?Q?L4veWFV1MPc7s1RxCinN6GUCxQyv1/V6L3SVd8V7ep3phYrfyk8R58UWPjw/?=
 =?us-ascii?Q?PM4tMvcZ42kMO3zY4pE72JZhYKOLVacRXC4fltiEPA0vszWACDJOT/SmAEbQ?=
 =?us-ascii?Q?syItiQbGdY1SxbxWQZjx2EYBhPl2uk+wLnAExBe4k+3cAYs5I8d1/kcYYojZ?=
 =?us-ascii?Q?wPg3/MM+a4Sc7JiCPIVUTyLG3JrmqoJ7Daj/BxqBR6L4SSMVmRWlDkUuphNV?=
 =?us-ascii?Q?Lcs4UfYxRDB7XB8f5+7FwKYxeSlcB5dJoH9r+X2EThOBcQDzWLRVFcIgl7sw?=
 =?us-ascii?Q?APR6VRwN8p76WUzU55Wk4xuP1JbNM/2PXhu02xPKj32ggRi3eFQpMVp13AER?=
 =?us-ascii?Q?xoWSKRKjit17srgpPhJfnIWGqbj5RiswKhu8VsLUSkq5gVJrZ5OSu1YkAFqI?=
 =?us-ascii?Q?+NboaKlHlM+9KQzkkTQq8GHImiqBKo2nWvje9Gi/215iZjAlxOlnO5fmX1rU?=
 =?us-ascii?Q?Hyr7nvQ9fBHfOA2z7OxBKr0eKiuHWk+VioLo7U07i1QowQ39/gf50Qyi9idB?=
 =?us-ascii?Q?wGZkuhDzBZEr4Wq7W13adwTF4OyXXihJssTvRgEwzeiZ+nRw9Iu7adDtSweg?=
 =?us-ascii?Q?t/mSH590gNHX3ohTYASXrlohPwZ675DW7P9Oo9eKZ4A6WwOiwjBUSVf2R5dc?=
 =?us-ascii?Q?2kgQC2vB2NhgJdizkXiEguoTeb3zVycpvXK50JFCLSunTjqRUsYV4V69ed2u?=
 =?us-ascii?Q?lBiD++53Xaw1d2g34tCiDymOBhxRAMHc2iZH2UMPVa2cQlWQ2wLGlnoY09DZ?=
 =?us-ascii?Q?Y761Wf32MMIKGDIbodmOYmbPfmr9HGU4NVbDYYFH2uZIex9NlxMEVq/gTuwL?=
 =?us-ascii?Q?KA7b7COfFb377XBefHXzwJCdFr7okQk9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aFu/CtsVd6FNUr3uzBVM+rBqt79ESFDxg6vJvykhCwqwhDT8LZBLhBOM34rA?=
 =?us-ascii?Q?VZI7g6IRo5Afn5nWx7GVw3Pxe+jagKsn7pUqdP6lQ20FKHXYqUOgo87cEa1N?=
 =?us-ascii?Q?aBn5bZmr4GcUkoDAliiAy5ArAJeiLVxhirJX1Gi8qOCwi4kgDf3R7LqlJa52?=
 =?us-ascii?Q?gHfM86d2HDEJbDJtNdm9fVsQZN0yUbW7o47FIXWAG5Ck8pfDWjjS5NdN1YxI?=
 =?us-ascii?Q?znZJlC7Eo3DtCDG/lZCkn2MUvRCnduhc6WdBNesz35xxyeu3keVPpOCZHnf3?=
 =?us-ascii?Q?tp/kYw+zbD3M3sSXfbsZ4IUrqpaffS+s9hB62Cr1tbHjY8ZznBoM0kegWrCz?=
 =?us-ascii?Q?StMnq/AEsKF6VMpUTdvqSsT8Bv0q5y2RmSCVZgSolj2HeWADa+4V9U2NjmDo?=
 =?us-ascii?Q?XSraQrTw1SRps284r8777CP924g1Ayh1BpFA14/YcYTKJing39zFgwBfYBf7?=
 =?us-ascii?Q?MVYMBjG8EQR5Nii0/kluQlVRRggZmE5I/JGB6gMMlyQUeAT6sxbZLUrzp48q?=
 =?us-ascii?Q?AWEKGfd2xVqFmmkCMxgvXh1KdPxEwLlEjN+nP+NFol4MwmtAmdTIrxOzjuES?=
 =?us-ascii?Q?PsXCRkGeTPHptBUiRQPtoT43lKOh9cW5aaUV7m8zCRrZdtGmqjfAi5t6MPaC?=
 =?us-ascii?Q?EhcWk7SjONeY/KBfvKy+9RZsawLfVEPsmJqEIrH4SoYlmhLs90pGqDlTj6j3?=
 =?us-ascii?Q?1dEhA5YuB/Ug9JdxwK8GLVh5/wyTUWOFQxOxZHEKV9Cb9vBsKjZXvjVJRaHT?=
 =?us-ascii?Q?HGkGeXbgdh9io7Lvp/iXw1IghIst/dCFCyrhScVhByD+g/FxFnXF1c7ifbT5?=
 =?us-ascii?Q?kT+NSgLONr6nQbTJ/RctOmpX5B6dg2t1LXIipys4YwMbzID9BeXvpJuz0oC4?=
 =?us-ascii?Q?xIEhTI66JK36cfgeiqtqNYRIjUJj/m6JuEqAqDTBWXErh8m63jbqNWwNEkPP?=
 =?us-ascii?Q?wA8HBsHcXnJV6hzI67htd6RG6xgRS/3tkbehUI4Mh00Z6/LJ8J85IYosjmz3?=
 =?us-ascii?Q?YDOFVlI2IDSjzJeGBJuvQ7BCClxT4Ua9EZXBM+5vEIktCgGMyD1CM9Yh/KGK?=
 =?us-ascii?Q?u78Uawjnu6VWePsEs/B66snOhN7aaVhUt8FQPSTsziXfNKtSj+NADD5DqeTd?=
 =?us-ascii?Q?aVBIuXXX/OSFuE6/2Pqu2WvCuOSEz6vdIHUUl6KiQzmsvEZu1uRX9kHhg7hM?=
 =?us-ascii?Q?u3DIW3tca8PSU3Otk8qxVyWC+vhuuCt5I6g/fHUUe1vnwOkBPEJzjMUfnI6I?=
 =?us-ascii?Q?eQZ0ck+8Hs0ETLEL32dqdXbtNUBjpFlXZEqesIOp75mpqsXTGBrutNmYkWjf?=
 =?us-ascii?Q?8jCkLVcKRnebl3BMYq8GVc87a1LA5HV0dXkbfSayjOPs226Rqf7Mk3W9hO2o?=
 =?us-ascii?Q?N0ngDGB98EtEQkGIAY0KqA07vWcy7KRM8W3rLaWZhe2S5AxivRGWCmQF4k6+?=
 =?us-ascii?Q?IqdFjkVX1FPTdpeqfdSSU0QCfB9r47LWE0iE5PooMlXRoFEtw8VwCFrfmlmf?=
 =?us-ascii?Q?wZGKfd9iIzeHlRy4G6u7sCWuTd2IGY5Qt2pDBr8BHlUTz67nS7L5JLAhnV0l?=
 =?us-ascii?Q?e1EcK1OGkYd2UrpcSAg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2569d262-91d7-497a-9d37-08dd34becae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 17:13:40.8856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJM4dVXQjfE6xAROebG7uv2x31roADwQFzD7A51xERy8uHsSd6BLx/HAMPyuarde
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
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

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, January 14, 2025 12:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; K=
im,
> Jonathan <Jonathan.Kim@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: validate process_context_addr for the MES sh=
ader
> debugger
>
> The following page fault was observed during the exit moment of the
> HIP test process. In this particular error case, the HIP test
> (./MemcpyPerformance -h) does not require the AQL queue. As a result,

I don't think this has anything to do with AQL compute specifically but a q=
uirk in the KFD where the KFD only creates the process device mes context w=
hen adding the first queue.
Maybe we should move context creation from the KFD add_queue_mes call to KF=
D process device creation when MES is supported.
Strangely enough KGD has an amdgpu_mes_create_process call that doesn't see=
m to be used but does exactly this.
Otherwise, since the driver is always supposed to allocate and pass a valid=
 context for any mes call, maybe it's better to do a context null check wit=
h some comments in the kfd_process_dequeue_from_all_devices call to reflect=
 this quirk.

Jon

> the process_context_addr was not assigned when the KFD process was
> released, ultimately leading to this page fault during the execution of
> kfd_process_dequeue_from_all_devices().
>
> [345962.294891] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:=
0
> ring:153 vmid:0 pasid:0)
> [345962.295333] amdgpu 0000:03:00.0: amdgpu:   in page starting at addres=
s
> 0x0000000000000000 from client 10
> [345962.295775] amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
> [345962.296097] amdgpu 0000:03:00.0: amdgpu:     Faulty UTCL2 client ID: =
CPC
> (0x5)
> [345962.296394] amdgpu 0000:03:00.0: amdgpu:     MORE_FAULTS: 0x1
> [345962.296633] amdgpu 0000:03:00.0: amdgpu:     WALKER_ERROR: 0x1
> [345962.296876] amdgpu 0000:03:00.0: amdgpu:     PERMISSION_FAULTS: 0x3
> [345962.297135] amdgpu 0000:03:00.0: amdgpu:     MAPPING_ERROR: 0x1
> [345962.297377] amdgpu 0000:03:00.0: amdgpu:     RW: 0x0
> [345962.297682] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:=
0
> ring:169 vmid:0 pasid:0)
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index cee38bb6cfaf..4d313144cc4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1062,6 +1062,11 @@ int amdgpu_mes_flush_shader_debugger(struct
> amdgpu_device *adev,
>               return -EINVAL;
>       }
>
> +     if (!process_context_addr) {
> +             dev_warn(adev->dev, "invalidated process context addr\n");
> +             return -EINVAL;
> +     }
> +
>       op_input.op =3D MES_MISC_OP_SET_SHADER_DEBUGGER;
>       op_input.set_shader_debugger.process_context_addr =3D
> process_context_addr;
>       op_input.set_shader_debugger.flags.process_ctx_flush =3D true;
> --
> 2.34.1

