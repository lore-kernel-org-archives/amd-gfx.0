Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAA0C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 14:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C6C10ECAC;
	Fri, 28 Feb 2025 14:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="osXpCt+h";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A19E10ECAC
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 14:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOK7mN5iVumaG11Ukw5X9jvuGsfpzPF/uomXvRV/0Al6n6Mfba3jkc6dzalmBDmEgknHsobI+d0VQm+3/R5WiAAa5GtY9spN6zzN0ISXh7T9zqPsphjJepn4wEQ9Vh8Ye2kxN0XEOy+8TaIPmyYcdAUMy0HKft7SWNJmSD1NEzgA47spY5CERotYhwVAjgGeV59yhNk45aY2egVdxu3xINA8++BMJ2NnXWv33Mbe/+YgJ4Sx917vdg3gQ5tyM2lC1DS8jIIZ6tiS0B0kkguf30vRCU1Yqy92vVA6ACqbC2NdWw5iUYzVRueEZg4OfysjfyBCABE2qZO6Uwrs7WjvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qORII6Djku4IDVzwK7NdORjUTK/jS3B1oAos7lfBaIg=;
 b=yE0ylpPcqR6e2A2eia6eDPTvDzebBwc0ioOGxMNNBB56lEK4xqOC6KVpQfK6ikIRsqUsq/ev90OJ+7WqSp0H7PWM9cq85Ngw1oa8k0YeFznBwFf43aa1mI2oN07xY2frG6ac53dBm9dYiinKiewx6CVzxgUtS2PZdtIzQ++FArcKeE7dpYOj1q+lUUr9O96UdUX4NDdz8BPvqmi6+P8rxfUc5u3ZNd9SgXBdVeY/6K5gTdIoiiJIkva2lmJ+CAOAwr6J0B62+6rWAKXMbuVk+AJjEC5s1GyB0XYV7QKHVwuCCHuwKhh1bugB3MdVynM7tc8e1UfZwf+i0xc0NvqSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qORII6Djku4IDVzwK7NdORjUTK/jS3B1oAos7lfBaIg=;
 b=osXpCt+hS2q8EIlmTkP5OD+FKqsWjM44hWolfrE1uw3Pw88ya5SgLconqSmHJQovDsob6Ly34WkM7EvgoLmmf5R8d+9q174m7ZfzOBBo/kRUsP5E8e7tP/vWs442eGpX2SGU2OMRam7h7lHq2qxsqkHFZ3Jvl/c8B2cU/MGZfLw=
Received: from DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) by
 IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.22; Fri, 28 Feb 2025 14:01:25 +0000
Received: from DS7PR12MB5765.namprd12.prod.outlook.com
 ([fe80::3f49:9f92:3fcd:e374]) by DS7PR12MB5765.namprd12.prod.outlook.com
 ([fe80::3f49:9f92:3fcd:e374%4]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 14:01:24 +0000
From: "Yi, Tony" <Tony.Yi@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Liu,
 Xiang(Dean)" <Xiang.Liu@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
Thread-Index: AQHbiSozm+sUqtH1XE6OGSX5jb5UdbNcOdsAgACE5c8=
Date: Fri, 28 Feb 2025 14:01:24 +0000
Message-ID: <DS7PR12MB5765A18AC1434B32FE585EB1EFCC2@DS7PR12MB5765.namprd12.prod.outlook.com>
References: <20250227151217.2620348-1-Tony.Yi@amd.com>
 <20250227151217.2620348-2-Tony.Yi@amd.com>
 <BN9PR12MB525707C7AEA3F8E792638E57FCCC2@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525707C7AEA3F8E792638E57FCCC2@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-28T14:01:25.591Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5765:EE_|IA1PR12MB7592:EE_
x-ms-office365-filtering-correlation-id: bc895c94-da8d-44e5-df8b-08dd5800637b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|921020|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qemKI0VTZqpuwM1VjXrVfsXRtHpaPaRz8k6lCBXZgcfG7Mqwgi0FV78ftU?=
 =?iso-8859-1?Q?b7QC4r8n2I0Xheqy3mZqrFEBD6I4grCcyMIYU5cyc902ut2NEOCj3SWCSh?=
 =?iso-8859-1?Q?AvuX0W5x43Q/C3I/Vu5gldnlYBFkzcoNqwH7RKj91rZPQX54POSBp5FUZs?=
 =?iso-8859-1?Q?CABjCOhhklh7HuQHOeVhfZlTkpP1T+EXnELLmuQy29BL3CQf0YdJwtWW1z?=
 =?iso-8859-1?Q?+XpDfOnN6BNOCo5fUUxeZ7z0DzMa6Q+BTbMWgAw+9GCfs5MIfrldCK8xeh?=
 =?iso-8859-1?Q?iLRWfFMJgs6PjXpulJqAU5a8rFzhSmZiYYXJCKqkvBDFR9jIi44Rum7iOg?=
 =?iso-8859-1?Q?RItQnF5YJEfv/lTuR68U006mKFIsU2oEdM5MjkXKHoNMfk32ryNahhlfgr?=
 =?iso-8859-1?Q?Gtg+h5C/Br0EHIdkbSOJkdM+ffr3OQRzxurt2ACggIOWiS2P0P6MHLJOYp?=
 =?iso-8859-1?Q?Q864x7wMdaUhPRMlMeZ/kYfLwTbwJeC1TbXWeqSiFBIFMPeVfJVbVqB0PK?=
 =?iso-8859-1?Q?ilMVnzfIjvMCUSa4dwAcjc25BiPpJAT4vcnh2rHn2sCqQgYMI+eUrYEbkI?=
 =?iso-8859-1?Q?FtJKeqDoQuGZByIB0fBi5t30gJspG5cwaqFG/0hWvJTSmDUq6brzax19y/?=
 =?iso-8859-1?Q?WCbf/xW0IPDUAZzDgfLz+UqWj9JigEkM3F94X80o/osKO7LTH0kZWjxkpr?=
 =?iso-8859-1?Q?Pmm1iOOQssuPp2Yc/j1d4HoBYcHmkSZX5z9XiuqdzRb+nSMh/A8PZDRu64?=
 =?iso-8859-1?Q?Jr0zJ6t6eioQYsRc470jZJpSuEyMhhEMW/pYPfBhf8kx7U9l3seehsAlVi?=
 =?iso-8859-1?Q?CRay3NAU1rDSCBAYQ/gflxc3iOvbl+Ryy0v5l2Bq2oyHcxiLaGFeKyKUs4?=
 =?iso-8859-1?Q?ROI7qFS/uLKjI4fTKo3v4zu0FT+eYuHCfMO1JF8SQ6mBsXbudoGpDflw79?=
 =?iso-8859-1?Q?O+lZJ11shw4iZwYdUqTrDne/uGGNlqPO9WRlfOJ/c3QTnGPo50MTlr7o8A?=
 =?iso-8859-1?Q?FBvnAeOjW95ZBX7uEylwvl5XZUNL7a3k9HrnfJvaXR0tKbXuiSsnAE+bvv?=
 =?iso-8859-1?Q?s49P3UOlD56vwPE/GkskNIpPwJEIhNlGNAJX8hiT9ZsaDcfpZmv0vd6orE?=
 =?iso-8859-1?Q?IMRUG7QA77277pbZi0k+3TUZKiRg///0Iy59vxYGXUA9yoYfadYpPf9I5L?=
 =?iso-8859-1?Q?KVVd6v2g/XLK6P8y3fOAnDXSMOfms6dpifOfuYCfxruk1YIbh2SX51x6LZ?=
 =?iso-8859-1?Q?A8XiBQKFLokAaYD+OJmP1mG6aMPXPCd25FipJCAtQHsWQwWtyR9aTVIxek?=
 =?iso-8859-1?Q?gWsi6vI+jeG0ffrmShTF+rvWoodFXmDG8i8DHcKujSMAtVZGKZqmw/EhWr?=
 =?iso-8859-1?Q?/KG38aigDEXBbYoia/D8mPSnNx9f4K6kBUDP3ucEVJg3IHLct/0sqB7InR?=
 =?iso-8859-1?Q?8fBrJEApqEOL5zIf5fVAlneSq8wtiOY7GUOrV05zgnPpFVpOSYV6p6rs34?=
 =?iso-8859-1?Q?4YFosgaqsxMq5yRykMjwslU3eG4RWC8zBfZXaJ/12miA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5765.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(921020)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qTyTBcTRS3W0PIR9hJ0VyVkSSI3rR/9P5oUJ7qykZs96O1eZ+2I0sZWMRK?=
 =?iso-8859-1?Q?nxtmYTSIWRYXWWwZAfFO3Jv2Ai39FTVknVCJt9JnRDEQCkjHU/SDHXaRxI?=
 =?iso-8859-1?Q?+PlP6Tn/Url/jLzNryioP8PbfV6fKtAB+FmwA9/y3jfpA/3ZtRPB763oSr?=
 =?iso-8859-1?Q?iXyzbRzDh5G+lIo5BYIru0gjLRPGFnlabqO0Sf2OgA4XLf1xhpXy61rrTq?=
 =?iso-8859-1?Q?OMp6cpOH1DfjZjUPrjfu9iZaJoIbNnXixGtmlKKWht6zmQ8fCF9Cy6j5BB?=
 =?iso-8859-1?Q?1HRJlqksWQfTfcRkrdi8UQJY0HstXrLznWdyx6t5ohIeLvswUw+QgmpJwq?=
 =?iso-8859-1?Q?lL6jhp6zGGfx7CtlAVnYoHxAZAwazYaw5x19ByBcUHCap8qIfVu3OcubbT?=
 =?iso-8859-1?Q?eorU/5V0YNyTt4N0rU03NNPv+Jg5Q5OG3guDX62BJFVt95DjJvQNLUUdKG?=
 =?iso-8859-1?Q?o21FXSR3F9GxdvJxw21ylsWXmZIQCsZAB9H1QcBNyZac7DY088HdsnRgOg?=
 =?iso-8859-1?Q?sxs0vwi56Xb5Cv1vWVvIVJUJTAq+XuH4F+xreozpVZSpWoGpwV5ZPL0vHF?=
 =?iso-8859-1?Q?QkQqWM9RpRLOEeughe0XuKsR0cEja/WAmnCvvhy7bwZvRF2wmh8XcZD3nK?=
 =?iso-8859-1?Q?xEe1cxgj9ZHqUIWEOraVt7gqfQuoIpH3mMjBsqA5zbh70GJn9Q9zPUXZHo?=
 =?iso-8859-1?Q?TO45T2vDXfRPTFupD2NeHq3eCqMGiFAUgJj+Kh1dpsSwV6la1vbSIrJGYd?=
 =?iso-8859-1?Q?kkMAxbtBhrh40Upr1psG/oGVOlTLUUa75w//X6GMnobXls2VBzCbnYykNs?=
 =?iso-8859-1?Q?A51wv2ncBCRAqiY/ej1tsaJqWxbcFrF9+6AQSe/lOa25sQDsYiY4IVHSwz?=
 =?iso-8859-1?Q?lT9T78Fmvha4sMN0v4C0pK4QGvR241e8GbHStmmSs1oJOhm6AXR17uafoN?=
 =?iso-8859-1?Q?0qSxCsI5KxabJp6+CIJVX2uy1buGwCdXbQN2HfpGM79arVb+ozxugy4xtt?=
 =?iso-8859-1?Q?LY+IZTPfIbwAlR0/aVGFr5rNKrAufg8kIt+Yf7dzbPpEY2poXrdwp2sOjW?=
 =?iso-8859-1?Q?m/0Hqvz4rXw8esCdrBVpkghLAabf3hddjH2CmY2pa1f/dpfzkyd602UQJN?=
 =?iso-8859-1?Q?Gq/4OhQ0khpirZiNGLGvtXW8NYkG3zSr/hc6oVdp/hSy94sgJ/fLZgPCuJ?=
 =?iso-8859-1?Q?j2RoQHMIvyo3bsCIDw0K8rMM20mCU6WDGZ3m5bvYdz955/cExMfmwFhke5?=
 =?iso-8859-1?Q?06z8BUDf8hgZ73es7zRld5tJL/rkU6+ihrzxkLB2OLwBK/Jd8tWDF9G1Qt?=
 =?iso-8859-1?Q?aNbVdCQ7lIizCTNw8iegnBvZPpLdayd+RDKlHmfdqkcCwt0jkGv8aCsEyF?=
 =?iso-8859-1?Q?kaJR9Z0a4anND4kSuMjqbHh4ylwixXQmSsz31GJQdGnhc2K0h06gSBuhVb?=
 =?iso-8859-1?Q?U646hXYDHhDbcLIbC74Cm4mNFDp8eRN+caQ7pllrrpO14IMF3nlgozdFVv?=
 =?iso-8859-1?Q?V2Jk9Yy/H2eEBYE0Kb2MG8RaPDFg/zBrHgiNHHtg6CgnRDy9zwqbu2rABf?=
 =?iso-8859-1?Q?P+4IEw5herKyO1LMJacngFRssK4r/Pf6fOjGEYbgao24NYqWVoZbcY10p1?=
 =?iso-8859-1?Q?aAQr1M6dPj/BU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB5765A18AC1434B32FE585EB1EFCC2DS7PR12MB5765namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc895c94-da8d-44e5-df8b-08dd5800637b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 14:01:24.8453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejMy+SptanPFRut1HAjKYsf/pvVqZFxPFJ5sRm5K9rfpnws3sfLlglqpNeghaGTa5i8RRy6o9Twc3jkUB1I4BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
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

--_000_DS7PR12MB5765A18AC1434B32FE585EB1EFCC2DS7PR12MB5765namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Hawking,

We still use the BM CPER ring (through amdgpu_cper_ring_write) but as SRIOV=
 requires an extra step to query the CPERs, we created a new function amdgp=
u_debugfs_virt_ring_read within amdgpu_debugfs_virt_ring_fops that does exa=
ctly that. It is separate to avoid affecting the BM hot path with any extra=
neous calculations. The debugfs is exactly the same (amdgpu_ring_cper).

Thanks, Tony

________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Friday, February 28, 2025 1:00 AM
To: Yi, Tony <Tony.Yi@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com=
>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Luo, Zhig=
ang <Zhigang.Luo@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>; Zhou1, Tao=
 <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualizatio=
n

[AMD Official Use Only - AMD Internal Distribution Only]

+ @Liu, Xiang(Dean)<mailto:Xiang.Liu@amd.com>/@Zhou1, Tao<mailto:Tao.Zhou1@=
amd.com> for the code review

+       if (amdgpu_sriov_vf(adev))
+               debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
+                                        &amdgpu_debugfs_virt_ring_fops,
+                                        ring->ring_size + 12);
+       else
+               debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
+                                        &amdgpu_debugfs_ring_fops,
+                                        ring->ring_size + 12);

Hi Tony,

Is there any reason the VF requires a separate file system node? Is it beca=
use the VF has its own CPER ring? If so, can you please check if the VF can=
 reuse the CPER created for bare-metal?

Regards,
Hawking

-----Original Message-----
From: Yi, Tony <Tony.Yi@amd.com>
Sent: Thursday, February 27, 2025 23:12
To: Yi, Tony <Tony.Yi@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com=
>; amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; L=
uo, Zhigang <Zhigang.Luo@amd.com>
Cc: Yi, Tony <Tony.Yi@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization

Add support for CPERs on VFs.

VFs do not receive PMFW messages directly; as such, they need to query them=
 from the host. To avoid hitting host event guard, CPER queries need to be =
rate limited. CPER queries share the same RAS telemetry buffer as error cou=
nt query, so a mutex protecting the shared buffer was added as well.

For readability, the amdgpu_detect_virtualization was refactored into multi=
ple individual functions.

Signed-off-by: Tony Yi <Tony.Yi@amd.com<mailto:Tony.Yi@amd.com>>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   7 +-
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  31 ++++-
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 138 ++++++++++++++++++++-
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  18 ++-
drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  14 +++
5 files changed, 195 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 5e1d8f0039d0..198d29faa754 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3099,7 +3099,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device=
 *adev)

         amdgpu_fru_get_product_info(adev);

-       r =3D amdgpu_cper_init(adev);
+       if (!amdgpu_sriov_vf(adev) || amdgpu_sriov_ras_cper_en(adev))
+               r =3D amdgpu_cper_init(adev);

init_failed:

@@ -4335,10 +4336,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
          * for throttling interrupt) =3D 60 seconds.
          */
         ratelimit_state_init(&adev->throttling_logging_rs, (60 - 1) * HZ, =
1);
-       ratelimit_state_init(&adev->virt.ras_telemetry_rs, 5 * HZ, 1);

         ratelimit_set_flags(&adev->throttling_logging_rs, RATELIMIT_MSG_ON=
_RELEASE);
-       ratelimit_set_flags(&adev->virt.ras_telemetry_rs, RATELIMIT_MSG_ON_=
RELEASE);

         /* Registers mapping */
         /* TODO: block userspace mapping of io register */ @@ -4370,7 +436=
9,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
                 return -ENOMEM;

         /* detect hw virtualization here */
-       amdgpu_detect_virtualization(adev);
+       amdgpu_virt_init(adev);

         amdgpu_device_get_pcie_info(adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c
index 81a7d4faac9c..d55c8b7fdb59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -578,12 +578,32 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *=
f, char __user *buf,
         return result;
}

+static ssize_t amdgpu_debugfs_virt_ring_read(struct file *f, char __user *=
buf,
+       size_t size, loff_t *pos)
+{
+       struct amdgpu_ring *ring =3D file_inode(f)->i_private;
+
+       if (*pos & 3 || size & 3)
+               return -EINVAL;
+
+       if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_CPER)
+               amdgpu_virt_req_ras_cper_dump(ring->adev, false);
+
+       return amdgpu_debugfs_ring_read(f, buf, size, pos); }
+
static const struct file_operations amdgpu_debugfs_ring_fops =3D {
         .owner =3D THIS_MODULE,
         .read =3D amdgpu_debugfs_ring_read,
         .llseek =3D default_llseek
};

+static const struct file_operations amdgpu_debugfs_virt_ring_fops =3D {
+       .owner =3D THIS_MODULE,
+       .read =3D amdgpu_debugfs_virt_ring_read,
+       .llseek =3D default_llseek
+};
+
static ssize_t amdgpu_debugfs_mqd_read(struct file *f, char __user *buf,
                                        size_t size, loff_t *pos)
{
@@ -671,9 +691,14 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *ad=
ev,
         char name[32];

         sprintf(name, "amdgpu_ring_%s", ring->name);
-       debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
-                                &amdgpu_debugfs_ring_fops,
-                                ring->ring_size + 12);
+       if (amdgpu_sriov_vf(adev))
+               debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
+                                        &amdgpu_debugfs_virt_ring_fops,
+                                        ring->ring_size + 12);
+       else
+               debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
+                                        &amdgpu_debugfs_ring_fops,
+                                        ring->ring_size + 12);

         if (ring->mqd_obj) {
                 sprintf(name, "amdgpu_mqd_%s", ring->name); diff --git a/d=
rivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu=
_virt.c
index e6f0152e5b08..3832513ec7bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -739,7 +739,7 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *ad=
ev)
         }
}

-void amdgpu_detect_virtualization(struct amdgpu_device *adev)
+static u32 amdgpu_virt_init_detect_asic(struct amdgpu_device *adev)
{
         uint32_t reg;

@@ -775,8 +775,17 @@ void amdgpu_detect_virtualization(struct amdgpu_device=
 *adev)
                         adev->virt.caps |=3D AMDGPU_PASSTHROUGH_MODE;
         }

+       return reg;
+}
+
+static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32
+reg) {
+       bool is_sriov =3D false;
+
         /* we have the ability to check now */
         if (amdgpu_sriov_vf(adev)) {
+               is_sriov =3D true;
+
                 switch (adev->asic_type) {
                 case CHIP_TONGA:
                 case CHIP_FIJI:
@@ -805,10 +814,39 @@ void amdgpu_detect_virtualization(struct amdgpu_devic=
e *adev)
                         amdgpu_virt_request_init_data(adev);
                         break;
                 default: /* other chip doesn't support SRIOV */
+                       is_sriov =3D false;
                         DRM_ERROR("Unknown asic type: %d!\n", adev->asic_t=
ype);
                         break;
                 }
         }
+
+       return is_sriov;
+}
+
+static void amdgpu_virt_init_ras(struct amdgpu_device *adev) {
+       ratelimit_state_init(&adev->virt.ras.ras_error_cnt_rs, 5 * HZ, 1);
+       ratelimit_state_init(&adev->virt.ras.ras_cper_dump_rs, 5 * HZ, 1);
+
+       ratelimit_set_flags(&adev->virt.ras.ras_error_cnt_rs,
+                           RATELIMIT_MSG_ON_RELEASE);
+       ratelimit_set_flags(&adev->virt.ras.ras_cper_dump_rs,
+                           RATELIMIT_MSG_ON_RELEASE);
+
+       mutex_init(&adev->virt.ras.ras_telemetry_mutex);
+
+       adev->virt.ras.cper_rptr =3D 0;
+}
+
+void amdgpu_virt_init(struct amdgpu_device *adev) {
+       bool is_sriov =3D false;
+       uint32_t reg =3D amdgpu_virt_init_detect_asic(adev);
+
+       is_sriov =3D amdgpu_virt_init_req_data(adev, reg);
+
+       if (is_sriov)
+               amdgpu_virt_init_ras(adev);
}

static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev) =
@@ -1288,10 +1326,12 @@ static int amdgpu_virt_req_ras_err_count_internal(s=
truct amdgpu_device *adev, bo
          * will ignore incoming guest messages. Ratelimit the guest messag=
es to
          * prevent guest self DOS.
          */
-       if (__ratelimit(&adev->virt.ras_telemetry_rs) || force_update) {
+       if (__ratelimit(&virt->ras.ras_error_cnt_rs) || force_update) {
+               mutex_lock(&virt->ras.ras_telemetry_mutex);
                 if (!virt->ops->req_ras_err_count(adev))
                         amdgpu_virt_cache_host_error_counts(adev,
-                               adev->virt.fw_reserve.ras_telemetry);
+                               virt->fw_reserve.ras_telemetry);
+               mutex_unlock(&virt->ras.ras_telemetry_mutex);
         }

         return 0;
@@ -1322,6 +1362,98 @@ int amdgpu_virt_req_ras_err_count(struct amdgpu_devi=
ce *adev, enum amdgpu_ras_bl
         return 0;
}

+static int
+amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
+                               struct amdsriov_ras_telemetry *host_telemet=
ry,
+                               u32 *more)
+{
+       struct amd_sriov_ras_cper_dump *cper_dump =3D NULL;
+       struct cper_hdr *entry =3D NULL;
+       struct amdgpu_ring *ring =3D &adev->cper.ring_buf;
+       uint32_t checksum, used_size, i, j;
+       int ret =3D 0;
+
+       checksum =3D host_telemetry->header.checksum;
+       used_size =3D host_telemetry->header.used_size;
+
+       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+               return 0;
+
+       cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size, G=
FP_KERNEL);
+       if (!cper_dump)
+               return -ENOMEM;
+
+       if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
))
+               goto out;
+
+       *more =3D cper_dump->more;
+
+       if (cper_dump->wptr < adev->virt.ras.cper_rptr) {
+               dev_warn(
+                       adev->dev,
+                       "guest specified rptr that was too high! guest rptr=
: 0x%llx, host rptr: 0x%llx\n",
+                       adev->virt.ras.cper_rptr, cper_dump->wptr);
+
+               adev->virt.ras.cper_rptr =3D cper_dump->wptr;
+               goto out;
+       }
+
+       entry =3D (struct cper_hdr *)&cper_dump->buf[0];
+
+       for (i =3D 0; i < cper_dump->count; i++) {
+               amdgpu_cper_ring_write(ring, entry, entry->record_length);
+               entry =3D (struct cper_hdr *)((char *)entry +
+                                           entry->record_length);
+       }
+
+       if (cper_dump->overflow_count)
+               dev_warn(adev->dev,
+                        "host reported CPER overflow of 0x%llx entries!\n"=
,
+                        cper_dump->overflow_count);
+
+       adev->virt.ras.cper_rptr =3D cper_dump->wptr;
+out:
+       kfree(cper_dump);
+
+       return ret;
+}
+
+static int amdgpu_virt_req_ras_cper_dump_internal(struct amdgpu_device
+*adev) {
+       struct amdgpu_virt *virt =3D &adev->virt;
+       int ret =3D 0;
+       uint32_t more =3D 0;
+
+       if (!amdgpu_sriov_ras_cper_en(adev))
+               return -EOPNOTSUPP;
+
+       do {
+               if (!virt->ops->req_ras_cper_dump(adev, virt->ras.cper_rptr=
))
+                       ret =3D amdgpu_virt_write_cpers_to_ring(
+                               adev, virt->fw_reserve.ras_telemetry, &more=
);
+               else
+                       ret =3D 0;
+       } while (more);
+
+       return ret;
+}
+
+int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool
+force_update) {
+       struct amdgpu_virt *virt =3D &adev->virt;
+       int ret =3D 0;
+
+       if ((__ratelimit(&virt->ras.ras_cper_dump_rs) || force_update) &&
+           down_read_trylock(&adev->reset_domain->sem)) {
+               mutex_lock(&virt->ras.ras_telemetry_mutex);
+               ret =3D amdgpu_virt_req_ras_cper_dump_internal(adev);
+               mutex_unlock(&virt->ras.ras_telemetry_mutex);
+               up_read(&adev->reset_domain->sem);
+       }
+
+       return ret;
+}
+
int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev)  {
         unsigned long ue_count, ce_count;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 0f3ccae5c1ab..9f65487e60f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -96,6 +96,7 @@ struct amdgpu_virt_ops {
                                         enum amdgpu_ras_block block);
         bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
         int (*req_ras_err_count)(struct amdgpu_device *adev);
+       int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 vf_rptr);
};

/*
@@ -140,6 +141,7 @@ enum AMDGIM_FEATURE_FLAG {
         AMDGIM_FEATURE_MES_INFO_ENABLE =3D (1 << 8),
         AMDGIM_FEATURE_RAS_CAPS =3D (1 << 9),
         AMDGIM_FEATURE_RAS_TELEMETRY =3D (1 << 10),
+       AMDGIM_FEATURE_RAS_CPER =3D (1 << 11),
};

enum AMDGIM_REG_ACCESS_FLAG {
@@ -242,6 +244,13 @@ struct amdgpu_virt_ras_err_handler_data {
         int last_reserved;
};

+struct amdgpu_virt_ras {
+       struct ratelimit_state ras_error_cnt_rs;
+       struct ratelimit_state ras_cper_dump_rs;
+       struct mutex ras_telemetry_mutex;
+       uint64_t cper_rptr;
+};
+
/* GPU virtualization */
struct amdgpu_virt {
         uint32_t                        caps;
@@ -284,8 +293,7 @@ struct amdgpu_virt {

         union amd_sriov_ras_caps ras_en_caps;
         union amd_sriov_ras_caps ras_telemetry_en_caps;
-
-       struct ratelimit_state ras_telemetry_rs;
+       struct amdgpu_virt_ras ras;
         struct amd_sriov_ras_telemetry_error_count count_cache;  };

@@ -340,6 +348,9 @@ struct amdgpu_video_codec_info;  #define amdgpu_sriov_r=
as_telemetry_block_en(adev, sriov_blk) \
(amdgpu_sriov_ras_telemetry_en((adev)) && (adev)->virt.ras_telemetry_en_cap=
s.all & BIT(sriov_blk))

+#define amdgpu_sriov_ras_cper_en(adev) \ ((adev)->virt.gim_feature &
+AMDGIM_FEATURE_RAS_CPER)
+
static inline bool is_virtual_machine(void)  {  #if defined(CONFIG_X86) @@ =
-378,7 +389,7 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgp=
u_device *adev);  void amdgpu_virt_init_data_exchange(struct amdgpu_device =
*adev);  void amdgpu_virt_exchange_data(struct amdgpu_device *adev);  void =
amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev); -void amdgpu_de=
tect_virtualization(struct amdgpu_device *adev);
+void amdgpu_virt_init(struct amdgpu_device *adev);

bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);  int amdgp=
u_virt_enable_access_debugfs(struct amdgpu_device *adev); @@ -406,6 +417,7 =
@@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 =
v, u32 f  bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev); =
 int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum amdgpu_=
ras_block block,
                                   struct ras_err_data *err_data);
+int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool
+force_update);
int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);  bool=
 amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
                                         enum amdgpu_ras_block block);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 4dcb72d1bdda..5aadf24cb202 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -184,6 +184,9 @@ static int xgpu_nv_send_access_requests_with_param(stru=
ct amdgpu_device *adev,
         case IDH_REQ_RAS_ERROR_COUNT:
                 event =3D IDH_RAS_ERROR_COUNT_READY;
                 break;
+       case IDH_REQ_RAS_CPER_DUMP:
+               event =3D IDH_RAS_CPER_DUMP_READY;
+               break;
         default:
                 break;
         }
@@ -467,6 +470,16 @@ static int xgpu_nv_req_ras_err_count(struct amdgpu_dev=
ice *adev)
         return xgpu_nv_send_access_requests(adev, IDH_REQ_RAS_ERROR_COUNT)=
;  }

+static int xgpu_nv_req_ras_cper_dump(struct amdgpu_device *adev, u64
+vf_rptr) {
+       uint32_t vf_rptr_hi, vf_rptr_lo;
+
+       vf_rptr_hi =3D (uint32_t)(vf_rptr >> 32);
+       vf_rptr_lo =3D (uint32_t)(vf_rptr & 0xFFFFFFFF);
+       return xgpu_nv_send_access_requests_with_param(
+               adev, IDH_REQ_RAS_CPER_DUMP, vf_rptr_hi, vf_rptr_lo, 0); }
+
const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
         .req_full_gpu   =3D xgpu_nv_request_full_gpu_access,
         .rel_full_gpu   =3D xgpu_nv_release_full_gpu_access,
@@ -478,4 +491,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
         .ras_poison_handler =3D xgpu_nv_ras_poison_handler,
         .rcvd_ras_intr =3D xgpu_nv_rcvd_ras_intr,
         .req_ras_err_count =3D xgpu_nv_req_ras_err_count,
+       .req_ras_cper_dump =3D xgpu_nv_req_ras_cper_dump,
};
--
2.34.1


--_000_DS7PR12MB5765A18AC1434B32FE585EB1EFCC2DS7PR12MB5765namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi Hawking,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
We still use the BM CPER ring (through amdgpu_cper_ring_write) but as SRIOV=
 requires an extra step to query the CPERs, we created a new function amdgp=
u_debugfs_virt_ring_read within amdgpu_debugfs_virt_ring_fops&nbsp;that doe=
s exactly that. It is separate to avoid
 affecting the BM hot path with any extraneous calculations. The debugfs is=
 exactly the same (amdgpu_ring_cper).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks, Tony</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Zhang,=
 Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, February 28, 2025 1:00 AM<br>
<b>To:</b>&nbsp;Yi, Tony &lt;Tony.Yi@amd.com&gt;; Skvortsov, Victor &lt;Vic=
tor.Skvortsov@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;; Luo, Zhigang &lt;Zhigang.Luo@amd.com&gt;; Liu, Xiang(D=
ean) &lt;Xiang.Liu@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b>&nbsp;RE: [PATCH 2/2] drm/amdgpu: Add support for CPERs on v=
irtualization</span>
<div>&nbsp;</div>
</div>
<div style=3D"padding-right: 5pt; padding-left: 5pt; font-family: Calibri; =
font-size: 10pt; color: blue;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<div style=3D"margin-top: 5pt; font-family: &quot;Times New Roman&quot;; fo=
nt-size: 12pt;"><br>
</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+ <span style=3D"colo=
r: rgb(43, 87, 154); background-color: rgb(225, 223, 221);">
<a href=3D"mailto:Xiang.Liu@amd.com" id=3D"OWA1df899a8-7bf4-ecdd-64e9-17cfc=
0009953" class=3D"OWAAutoLink">@Liu, Xiang(Dean)</a></span>/<span style=3D"=
color: rgb(43, 87, 154); background-color: rgb(225, 223, 221);"><a href=3D"=
mailto:Tao.Zhou1@amd.com" id=3D"OWA6b502cbc-55b1-92c3-21fc-2ca5e697645e" cl=
ass=3D"OWAAutoLink">@Zhou1,
 Tao</a></span>&nbsp;for the code review</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_cr=
eate_file_size(name, S_IFREG | 0444, root, ring,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri; font-size: 11p=
t;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &amp;amdgpu_debugfs_virt_ring_fops,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;r=
ing_size + 12);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; else</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_cr=
eate_file_size(name, S_IFREG | 0444, root, ring,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgp=
u_debugfs_ring_fops,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;r=
ing_size + 12);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">Hi Tony,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">Is there any reason t=
he VF requires a separate file system node? Is it because the VF has its ow=
n CPER ring? If so, can you please check if the VF can reuse the CPER creat=
ed for bare-metal?</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">Regards,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">Hawking</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-----Original Message=
-----<br>
From: Yi, Tony &lt;Tony.Yi@amd.com&gt;<br>
Sent: Thursday, February 27, 2025 23:12<br>
To: Yi, Tony &lt;Tony.Yi@amd.com&gt;; Skvortsov, Victor &lt;Victor.Skvortso=
v@amd.com&gt;; amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zh=
ang@amd.com&gt;; Luo, Zhigang &lt;Zhigang.Luo@amd.com&gt;<br>
Cc: Yi, Tony &lt;Tony.Yi@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization</d=
iv>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">Add support for CPERs=
 on VFs.</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">VFs do not receive PM=
FW messages directly; as such, they need to query them from the host. To av=
oid hitting host event guard, CPER queries need to be rate limited. CPER qu=
eries share the same RAS telemetry
 buffer as error count query, so a mutex protecting the shared buffer was a=
dded as well.</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">For readability, the =
amdgpu_detect_virtualization was refactored into multiple individual functi=
ons.</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">Signed-off-by: Tony Y=
i &lt;<a href=3D"mailto:Tony.Yi@amd.com" id=3D"OWA73f6103f-22ac-d1b5-97da-4=
9447c7d8667" class=3D"OWAAutoLink">Tony.Yi@amd.com</a>&gt;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">---</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">drivers/gpu/drm/amd/a=
mdgpu/amdgpu_device.c |&nbsp;&nbsp; 7 +-</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ring.c&nbsp;&nbsp; |&nbsp; 31 ++++-</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">drivers/gpu/drm/amd/a=
mdgpu/amdgpu_virt.c&nbsp;&nbsp; | 138 ++++++++++++++++++++-</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">drivers/gpu/drm/amd/a=
mdgpu/amdgpu_virt.h&nbsp;&nbsp; |&nbsp; 18 ++-</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">drivers/gpu/drm/amd/a=
mdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 14 +++</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">5 files changed, 195 =
insertions(+), 13 deletions(-)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">diff --git a/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_devi=
ce.c</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">index 5e1d8f0039d0..1=
98d29faa754 100644</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">--- a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+++ b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -3099,7 +3099,8 @@=
 static int amdgpu_device_ip_init(struct amdgpu_device *adev)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fru_get_product_info(adev);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; r =3D amdgpu_cper_init(adev);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) || amdgpu_sriov_ras_cper_en(ade=
v))</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdg=
pu_cper_init(adev);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">init_failed:</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -4335,10 +4336,8 @=
@ int amdgpu_device_init(struct amdgpu_device *adev,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for throttling interrupt) =3D 60 second=
s.</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_state_init(&amp;adev-&gt;throttling_l=
ogging_rs, (60 - 1) * HZ, 1);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ratelimit_state_init(&amp;adev-&gt;virt.ras_telemetry_rs, =
5 * HZ, 1);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_set_flags(&amp;adev-&gt;throttling_lo=
gging_rs, RATELIMIT_MSG_ON_RELEASE);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ratelimit_set_flags(&amp;adev-&gt;virt.ras_telemetry_rs, R=
ATELIMIT_MSG_ON_RELEASE);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* Registers mapping */</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: block userspace mapping of io register=
 */ @@ -4370,7 +4369,7 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return -ENOMEM;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* detect hw virtualization here */</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; amdgpu_detect_virtualization(adev);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; amdgpu_virt_init(adev);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_get_pcie_info(adev);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">diff --git a/drivers/=
gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c=
</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">index 81a7d4faac9c..d=
55c8b7fdb59 100644</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">--- a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+++ b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -578,12 +578,32 @@=
 static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,<=
/div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return result;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">}</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+static ssize_t amdgp=
u_debugfs_virt_ring_read(struct file *f, char __user *buf,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; size_t size, loff_t *pos)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+{</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D file_inode(f)-&gt;i_private;<=
/div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (*pos &amp; 3 || size &amp; 3)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EI=
NVAL;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;type =3D=3D AMDGPU_RING_TYPE_CPER)<=
/div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vir=
t_req_ras_cper_dump(ring-&gt;adev, false);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return amdgpu_debugfs_ring_read(f, buf, size, pos); }</div=
>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">static const struct f=
ile_operations amdgpu_debugfs_ring_fops =3D {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_ring_read,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">};</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+static const struct =
file_operations amdgpu_debugfs_virt_ring_fops =3D {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_virt_ring_read,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; .llseek =3D default_llseek</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+};</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">static ssize_t amdgpu=
_debugfs_mqd_read(struct file *f, char __user *buf,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size=
, loff_t *pos)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">{</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -671,9 +691,14 @@ =
void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; char name[32];</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(name, &quot;amdgpu_ring_%s&quot;, ring-=
&gt;name);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; debugfs_create_file_size(name, S_IFREG | 0444, root, ring,=
</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_ring_fops,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ring-&gt;ring_size + 12);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_cr=
eate_file_size(name, S_IFREG | 0444, root, ring,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgp=
u_debugfs_virt_ring_fops,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;r=
ing_size + 12);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; else</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_cr=
eate_file_size(name, S_IFREG | 0444, root, ring,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgp=
u_debugfs_ring_fops,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;r=
ing_size + 12);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;mqd_obj) {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 sprintf(name, &quot;amdgpu_mqd_%s&quot;, ring-&gt;name); diff --git a/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vi=
rt.c</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">index e6f0152e5b08..3=
832513ec7bf 100644</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">--- a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.c</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+++ b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.c</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -739,7 +739,7 @@ v=
oid amdgpu_virt_exchange_data(struct amdgpu_device *adev)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">}</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-void amdgpu_detect_v=
irtualization(struct amdgpu_device *adev)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+static u32 amdgpu_vi=
rt_init_detect_asic(struct amdgpu_device *adev)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">{</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -775,8 +775,17 @@ =
void amdgpu_detect_virtualization(struct amdgpu_device *adev)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.caps |=3D AM=
DGPU_PASSTHROUGH_MODE;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return reg;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+}</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+static bool amdgpu_v=
irt_init_req_data(struct amdgpu_device *adev, u32</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+reg) {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; bool is_sriov =3D false;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* we have the ability to check now */</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_sriov =
=3D true;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 switch (adev-&gt;asic_type) {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 case CHIP_TONGA:</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 case CHIP_FIJI:</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -805,10 +814,39 @@=
 void amdgpu_detect_virtualization(struct amdgpu_device *adev)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_request_init_d=
ata(adev);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 default: /* other chip doesn't support SRIOV */</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_sriov =3D false;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Unknown as=
ic type: %d!\n&quot;, adev-&gt;asic_type);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 }</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return is_sriov;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+}</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+static void amdgpu_v=
irt_init_ras(struct amdgpu_device *adev) {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ratelimit_state_init(&amp;adev-&gt;virt.ras.ras_error_cnt_=
rs, 5 * HZ, 1);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ratelimit_state_init(&amp;adev-&gt;virt.ras.ras_cper_dump_=
rs, 5 * HZ, 1);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ratelimit_set_flags(&amp;adev-&gt;virt.ras.ras_error_cnt_r=
s,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RATELIMIT_MSG=
_ON_RELEASE);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ratelimit_set_flags(&amp;adev-&gt;virt.ras.ras_cper_dump_r=
s,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RATELIMIT_MSG=
_ON_RELEASE);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;virt.ras.ras_telemetry_mutex);</d=
iv>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;virt.ras.cper_rptr =3D 0;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+}</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+void amdgpu_virt_ini=
t(struct amdgpu_device *adev) {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; bool is_sriov =3D false;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t reg =3D amdgpu_virt_init_detect_asic(adev);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; is_sriov =3D amdgpu_virt_init_req_data(adev, reg);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (is_sriov)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vir=
t_init_ras(adev);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">}</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">static bool amdgpu_vi=
rt_access_debugfs_is_mmio(struct amdgpu_device *adev) @@ -1288,10 +1326,12 =
@@ static int amdgpu_virt_req_ras_err_count_internal(struct amdgpu_device *=
adev, bo</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * will ignore incoming guest messages. Ra=
telimit the guest messages to</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * prevent guest self DOS.</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (__ratelimit(&amp;adev-&gt;virt.ras_telemetry_rs) || fo=
rce_update) {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (__ratelimit(&amp;virt-&gt;ras.ras_error_cnt_rs) || for=
ce_update) {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock=
(&amp;virt-&gt;ras.ras_telemetry_mutex);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (!virt-&gt;ops-&gt;req_ras_err_count(adev))</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_cache_host_err=
or_counts(adev,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;virt.fw_reserve.ras_telemetry);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; virt-&gt;fw_reserve.ras_telemetry);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlo=
ck(&amp;virt-&gt;ras.ras_telemetry_mutex);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -1322,6 +1362,98 @=
@ int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum amdgpu=
_ras_bl</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">}</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+static int</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+amdgpu_virt_write_cp=
ers_to_ring(struct amdgpu_device *adev,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdsriov_ras_telemetry *host_telemetry,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; u32 *more)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+{</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amd_sriov_ras_cper_dump *cper_dump =3D NULL;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct cper_hdr *entry =3D NULL;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt;cper.ring_buf;<=
/div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t checksum, used_size, i, j;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; int ret =3D 0;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; checksum =3D host_telemetry-&gt;header.checksum;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; used_size =3D host_telemetry-&gt;header.used_size;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (used_size &gt; (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB &lt;&l=
t; 10))</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<=
/div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; cper_dump =3D kmemdup(&amp;host_telemetry-&gt;body.cper_du=
mp, used_size, GFP_KERNEL);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (!cper_dump)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EN=
OMEM;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_s=
ize, 0, 0))</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<=
/div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; *more =3D cper_dump-&gt;more;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (cper_dump-&gt;wptr &lt; adev-&gt;virt.ras.cper_rptr) {=
</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(<=
/div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;dev,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;guest specified rptr that was t=
oo high! guest rptr: 0x%llx, host rptr: 0x%llx\n&quot;,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ras.cper_rptr, cper_dum=
p-&gt;wptr);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;v=
irt.ras.cper_rptr =3D cper_dump-&gt;wptr;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<=
/div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; entry =3D (struct cper_hdr *)&amp;cper_dump-&gt;buf[0];</d=
iv>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; for (i =3D 0; i &lt; cper_dump-&gt;count; i++) {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_cpe=
r_ring_write(ring, entry, entry-&gt;record_length);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry =3D =
(struct cper_hdr *)((char *)entry +</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; entry-&gt;record_length);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (cper_dump-&gt;overflow_count)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(a=
dev-&gt;dev,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;host reported CPER overfl=
ow of 0x%llx entries!\n&quot;,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cper_dump-&gt;overflow_count);<=
/div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;virt.ras.cper_rptr =3D cper_dump-&gt;wptr;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+out:</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; kfree(cper_dump);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return ret;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+}</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+static int amdgpu_vi=
rt_req_ras_cper_dump_internal(struct amdgpu_device</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+*adev) {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_virt *virt =3D &amp;adev-&gt;virt;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; int ret =3D 0;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t more =3D 0;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (!amdgpu_sriov_ras_cper_en(adev))</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EO=
PNOTSUPP;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; do {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!virt-=
&gt;ops-&gt;req_ras_cper_dump(adev, virt-&gt;ras.cper_rptr))</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_virt_write_cpers_to_ri=
ng(</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev, virt-&gt;fw_reserve.ras_telemetry, &amp;more);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D 0;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; } while (more);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return ret;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+}</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+int amdgpu_virt_req_=
ras_cper_dump(struct amdgpu_device *adev, bool</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+force_update) {</div=
>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_virt *virt =3D &amp;adev-&gt;virt;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; int ret =3D 0;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if ((__ratelimit(&amp;virt-&gt;ras.ras_cper_dump_rs) || fo=
rce_update) &amp;&amp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_read_trylock(&amp;adev-&gt;re=
set_domain-&gt;sem)) {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock=
(&amp;virt-&gt;ras.ras_telemetry_mutex);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D am=
dgpu_virt_req_ras_cper_dump_internal(adev);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlo=
ck(&amp;virt-&gt;ras.ras_telemetry_mutex);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&a=
mp;adev-&gt;reset_domain-&gt;sem);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return ret;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+}</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">int amdgpu_virt_ras_t=
elemetry_post_reset(struct amdgpu_device *adev)&nbsp; {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long ue_count, ce_count;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">diff --git a/drivers/=
gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h=
</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">index 0f3ccae5c1ab..9=
f65487e60f5 100644</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">--- a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.h</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+++ b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.h</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -96,6 +96,7 @@ str=
uct amdgpu_virt_ops {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum =
amdgpu_ras_block block);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*rcvd_ras_intr)(struct amdgpu_device *ade=
v);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; int (*req_ras_err_count)(struct amdgpu_device *=
adev);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 v=
f_rptr);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">};</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">/*</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -140,6 +141,7 @@ e=
num AMDGIM_FEATURE_FLAG {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FEATURE_MES_INFO_ENABLE =3D (1 &lt;&lt; =
8),</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FEATURE_RAS_CAPS =3D (1 &lt;&lt; 9),</di=
v>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FEATURE_RAS_TELEMETRY =3D (1 &lt;&lt; 10=
),</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; AMDGIM_FEATURE_RAS_CPER =3D (1 &lt;&lt; 11),</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">};</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">enum AMDGIM_REG_ACCES=
S_FLAG {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -242,6 +244,13 @@ =
struct amdgpu_virt_ras_err_handler_data {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; int last_reserved;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">};</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+struct amdgpu_virt_r=
as {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct ratelimit_state ras_error_cnt_rs;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct ratelimit_state ras_cper_dump_rs;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct mutex ras_telemetry_mutex;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint64_t cper_rptr;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+};</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">/* GPU virtualization=
 */</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">struct amdgpu_virt {<=
/div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; caps;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -284,8 +293,7 @@ s=
truct amdgpu_virt {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; union amd_sriov_ras_caps ras_en_caps;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; union amd_sriov_ras_caps ras_telemetry_en_caps;=
</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">-&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct ratelimit_state ras_telemetry_rs;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_virt_ras ras;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_ras_telemetry_error_count coun=
t_cache;&nbsp; };</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -340,6 +348,9 @@ s=
truct amdgpu_video_codec_info;&nbsp; #define amdgpu_sriov_ras_telemetry_blo=
ck_en(adev, sriov_blk) \</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">(amdgpu_sriov_ras_tel=
emetry_en((adev)) &amp;&amp; (adev)-&gt;virt.ras_telemetry_en_caps.all &amp=
; BIT(sriov_blk))</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+#define amdgpu_sriov=
_ras_cper_en(adev) \ ((adev)-&gt;virt.gim_feature &amp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+AMDGIM_FEATURE_RAS_C=
PER)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">static inline bool is=
_virtual_machine(void)&nbsp; {&nbsp; #if defined(CONFIG_X86) @@ -378,7 +389=
,7 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *a=
dev);&nbsp; void amdgpu_virt_init_data_exchange(struct
 amdgpu_device *adev);&nbsp; void amdgpu_virt_exchange_data(struct amdgpu_d=
evice *adev);&nbsp; void amdgpu_virt_fini_data_exchange(struct amdgpu_devic=
e *adev); -void amdgpu_detect_virtualization(struct amdgpu_device *adev);</=
div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+void amdgpu_virt_ini=
t(struct amdgpu_device *adev);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">bool amdgpu_virt_can_=
access_debugfs(struct amdgpu_device *adev);&nbsp; int amdgpu_virt_enable_ac=
cess_debugfs(struct amdgpu_device *adev); @@ -406,6 +417,7 @@ u32 amdgpu_vi=
rt_rlcg_reg_rw(struct amdgpu_device *adev,
 u32 offset, u32 v, u32 f&nbsp; bool amdgpu_virt_get_ras_capability(struct =
amdgpu_device *adev);&nbsp; int amdgpu_virt_req_ras_err_count(struct amdgpu=
_device *adev, enum amdgpu_ras_block block,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data *err_data);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+int amdgpu_virt_req_=
ras_cper_dump(struct amdgpu_device *adev, bool</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+force_update);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">int amdgpu_virt_ras_t=
elemetry_post_reset(struct amdgpu_device *adev);&nbsp; bool amdgpu_virt_ras=
_telemetry_block_en(struct amdgpu_device *adev,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum =
amdgpu_ras_block block);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">diff --git a/drivers/=
gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">index 4dcb72d1bdda..5=
aadf24cb202 100644</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">--- a/drivers/gpu/drm=
/amd/amdgpu/mxgpu_nv.c</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+++ b/drivers/gpu/drm=
/amd/amdgpu/mxgpu_nv.c</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -184,6 +184,9 @@ s=
tatic int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *ade=
v,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; case IDH_REQ_RAS_ERROR_COUNT:</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 event =3D IDH_RAS_ERROR_COUNT_READY;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 break;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; case IDH_REQ_RAS_CPER_DUMP:</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event =3D =
IDH_RAS_CPER_DUMP_READY;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</di=
v>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; default:</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 break;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -467,6 +470,16 @@ =
static int xgpu_nv_req_ras_err_count(struct amdgpu_device *adev)</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_nv_send_access_requests(adev, IDH_R=
EQ_RAS_ERROR_COUNT);&nbsp; }</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+static int xgpu_nv_r=
eq_ras_cper_dump(struct amdgpu_device *adev, u64</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+vf_rptr) {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t vf_rptr_hi, vf_rptr_lo;</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vf_rptr_hi =3D (uint32_t)(vf_rptr &gt;&gt; 32);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; vf_rptr_lo =3D (uint32_t)(vf_rptr &amp; 0xFFFFFFFF);</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return xgpu_nv_send_access_requests_with_param(</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, IDH_=
REQ_RAS_CPER_DUMP, vf_rptr_hi, vf_rptr_lo, 0); }</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">const struct amdgpu_v=
irt_ops xgpu_nv_virt_ops =3D {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .req_full_gpu&nbsp;&nbsp; =3D xgpu_nv_request_f=
ull_gpu_access,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .rel_full_gpu&nbsp;&nbsp; =3D xgpu_nv_release_f=
ull_gpu_access,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">@@ -478,4 +491,5 @@ c=
onst struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .ras_poison_handler =3D xgpu_nv_ras_poison_hand=
ler,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .rcvd_ras_intr =3D xgpu_nv_rcvd_ras_intr,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .req_ras_err_count =3D xgpu_nv_req_ras_err_coun=
t,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; .req_ras_cper_dump =3D xgpu_nv_req_ras_cper_dump,</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">};</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">--</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">2.34.1</div>
<div style=3D"font-family: Calibri; font-size: 11pt;">&nbsp;</div>
</div>
</body>
</html>

--_000_DS7PR12MB5765A18AC1434B32FE585EB1EFCC2DS7PR12MB5765namp_--
