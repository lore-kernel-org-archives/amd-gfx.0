Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4802C0219C
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 17:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8688210EB8D;
	Fri,  7 Feb 2025 17:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b6qVxNtn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18F210E0A5
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 17:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDBUlNKTpNX+DvbXHbRBQo+wY/HCiXDnYkqMzMapXPOWNM0KqmLtgKB5M9JR50h/pGEMl99S283PQnNTniqcPIEx4wjukJ4PbbWK1a9eK1oEqcQbVx9g/Ihs8mCcduYnLAawJfp0BrWwB7dFzCEG+nOP022c8zWcTyNnm1bvC8AGg6u9te43t/DNWTh7qUaCky2e505in9hl8b2NvVdkQmWopmvLIMNMISA7xXSEPtirDsTnWQQpg7DopQtevPlC6Ge2Ba53WmJg3vfSGZg8bTfFe5kG/I3bvHVyRd4hRH0PWTq2iG5EgdQvPTQbZi0UobWhZfTZyNcXdnSWCVbaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdxRTLXWcOlzwLANieNJ1Zvrk6j3h0rNBlfNBZaGHqo=;
 b=F2stXw+nncVGqfIlEst+R7iAWD5tylqqiTevuxYmhIcPcAuo+DdkH7nmeGjQ8TzjWCas7jTTgWX/c1JhwCB2yMqnRLTFeN6dg7yEAWooYAOI4v+yObp3egE+foVWquadVBE83wmUnt0O8RmE3TEjaNJ3whNABLc6SmxsiTVbCNJXciW+XEN5spsMc19kjlZwKgjuxJhXknEJfsKIalbzPv+W+GoI2GZKjFCx882s3IBWn2nSpY/Gg/Z0ZB2Erf5Ck0WhhcblqDEo2FbeGNQDY/Ygvv+eoXMJehxEJ7EcIa7fYp9nxq+9rY8TLOQq625vyMpwL63VBYLCsL6fVL8JMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdxRTLXWcOlzwLANieNJ1Zvrk6j3h0rNBlfNBZaGHqo=;
 b=b6qVxNtnS1ADA8lHEj7GsV5AYn6kNT9ymSl5dDiSq7sQx4ptTg3fZZBenvBdLUrTUr9iA6eOPBTuhaVxykIsyIseavQKN0sSRZQwthi0sx/LxEUTZYkX2or3eYQy3cDM22bvan4VUJo03qA2Ieevev72hcMg544n1Jix7ZIkxdY=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.13; Fri, 7 Feb 2025 17:34:49 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 17:34:49 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Topic: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Index: AQHbeJjnufoX/znsFkKKFBtTIxr8MbM67caAgABJgQCAAKiIAIAABdaAgAAEawCAAAu2gIAACroAgAABmPeAAAdbAIAAEGjJ
Date: Fri, 7 Feb 2025 17:34:49 +0000
Message-ID: <DS0PR12MB7804A35C24B56EDA46BCB73097F12@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-3-lijo.lazar@amd.com>
 <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
 <22d2c3e8-98f9-4ea3-9737-08e9812d312a@amd.com>
 <CY8PR12MB7435B4D359268091F915407F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a5bc0dcc-3aba-404f-aee4-f664a71b7a1b@amd.com>
 <CY8PR12MB7435100E613BA33C8CD4B2DD85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <1f9441b1-46af-496d-9711-a71242d03b46@amd.com>
 <CY8PR12MB74358CBFB54C385E564B247785F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DS0PR12MB7804043F80CCE669305F984097F12@DS0PR12MB7804.namprd12.prod.outlook.com>
 <CY8PR12MB7435933A1D8983F4661D762285F12@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435933A1D8983F4661D762285F12@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-07T15:54:59.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SA1PR12MB6920:EE_
x-ms-office365-filtering-correlation-id: beba89c7-36b7-49d9-f2ab-08dd479db8d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?F7f5QLh1Q54dbkX/rRjD6PSSGDHB7lUeV0PhSnsCBPcSQax8gMwSXpCk?=
 =?Windows-1252?Q?/41P3VTHz9jumqU+8TxDi0fsMMEul4nARljcbhAM9YWlrJ4WH/A2w/R6?=
 =?Windows-1252?Q?tDBZqnWGNUOKvruqygUsb25Cu/NBsllbm+0QLn9/c25sslRJhVtYfyde?=
 =?Windows-1252?Q?h19bhjKRuR56pFsMOnhf+DIx5yJX61vEkm3bmEtylP/v++KdxUi5JWp6?=
 =?Windows-1252?Q?tvtEOEeZOqUr2DsOvB6q+rP2AIIai7tdMdnM00gk+0y7jqpJ5qD+CP5K?=
 =?Windows-1252?Q?zA+J24ZOLADt6LkEpyQ8enHLz/HJC8bA6SNpVGF0jy0wEm7kTH2K2tZQ?=
 =?Windows-1252?Q?4R4Hnh9nNFTyriOizDPDTm57NHYyWaM0VjqDaNJQlXEedUDwUBgClCNh?=
 =?Windows-1252?Q?w+jZg6aMT/zObUu1Ax+ro+Cd0Nm5KEs2XoubYrPvPACYBWd0NhMLjAM6?=
 =?Windows-1252?Q?WXsF6gcl3N0FsH2JeQ6FPXJOGnIWw+cVSzAWaa8L1eko55YKbsdK8EFB?=
 =?Windows-1252?Q?WEgfXHADFX6s/AqueY9yFNzZjMqyL8eIMisbvNwDh0VIsr9PgTExvzGN?=
 =?Windows-1252?Q?OCQSXMwZ0phU/UVDaLMiNcEClPvWOPqC3lFlbuRa9gMb0gkb0uCDKQH9?=
 =?Windows-1252?Q?kn1teQ1XcQ/Yk+kttaf+E9z0qWdakIDHDsgU0lHEEMVfjvkfzwdY0yP1?=
 =?Windows-1252?Q?E3Jd8KkSYScWYFcAIVOyws18dLV4b4KNOTuiWPvTlZK7x93kQsjDZi5v?=
 =?Windows-1252?Q?zvBaVws/TO02JST0UIxvihgRAx0ebVxpVo3nTnGTaVRaPZIbYmwUQBB7?=
 =?Windows-1252?Q?PilummyNEaM5CizfRVf895ySfdlFpSTiPXy8O4P5IIC/oOtj0JZBpieb?=
 =?Windows-1252?Q?Q/3sEmaPCv+agjRJgvkO/4xhCzGWzaGhoKXxvQoBct0MotiDA4ocpw27?=
 =?Windows-1252?Q?gAoSQjK07wvP6YIOztycrubwcZ0zfMzCEdJqLAKPcRSH/M8fAIR7ffo2?=
 =?Windows-1252?Q?CiuqCMSYs3A4qjowDbjFN6SzEIEN6OB2Wl3WunlchB+LJ+RQnmRfvdkh?=
 =?Windows-1252?Q?jVRiITxZ8S0gfs0kaBi8Fib+ty/0bhQP8iBqoTeBPfhDXpn2y/5Cdvma?=
 =?Windows-1252?Q?lJGgeebIdYY4WiNKyqqS60wGsNWiojE0QX4HgJn1o/oaApr/vB1nvDfV?=
 =?Windows-1252?Q?zA55bBP/UneziDo5UmUOYftF42zszXqy3BSbEJbIr7pl34NQiK6KlbxK?=
 =?Windows-1252?Q?efbdFzQ39RTc7itXp9A1Ka5CsfVZoeaGsW/PjYlpWBXOzYD+PC1VVnEF?=
 =?Windows-1252?Q?XjQWZOTfRM3T6uleANbSyqTgBouzxRDPGpR11Gh2f5oZqltrduE1eid8?=
 =?Windows-1252?Q?PEMoye2CgZlXXm4MrrERIaf/a0xbi7YwiZruvh3vCnOoMjP0YxgThwB2?=
 =?Windows-1252?Q?YDGusn6RW/XUUXCvJbfPIfPCPYBymu/QLIR+Z8MRLy2FkwOmSwHamyQk?=
 =?Windows-1252?Q?SEBuv37WoZXeXfSEA/D4KrozOfQlH8bNTT14nUk83WyGBfma7VSg74Mn?=
 =?Windows-1252?Q?U3vVVhc2S1Z1CtZV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Rk6eMHgqR6ImyVUHgPUIW5enlJURoCnIKMrCgM4iwK6tTMVCZDI4cQAw?=
 =?Windows-1252?Q?PvJeG7YILdKm/VHMzJ1U7EdZ/g8sAc65HZI7slLe1Y1rWmcxTEheyXvu?=
 =?Windows-1252?Q?OfOcqdgI/jgKb33yQbZpGrvA7ruHVcEwL6z3b7dIfzvul3wAn8Vh4cRt?=
 =?Windows-1252?Q?SCTUUpwW+Kj66Y05V9P2g3XbE6tLpwiiJUoHNjKVdZwunJ3dhbdErVDg?=
 =?Windows-1252?Q?l2ClZbiO9nRd3KJXTGuKG8LZIqqYsjAfd9gsG2yX3/rQHKJrf5vFj1sI?=
 =?Windows-1252?Q?fOvKjdDuJ427t8kCm9Ozd49Zx1umHmkvWxn9IwsnsTKskpwduYccobM6?=
 =?Windows-1252?Q?iQkqbH/EuJJrgpg+cv2AhIG2/Z8PNUSklJliJptrXtuKS19GSVsu26fw?=
 =?Windows-1252?Q?SwcFX6Mvupndio6XZayk1HaUyP7LAW7TFPs/F/tZnQ7th/r74llBvc2j?=
 =?Windows-1252?Q?6Wqt0dk5sD7zR1XyYqOimPq8nK58fvWrHuEQ26K+bXXFamZZZvUpbrvS?=
 =?Windows-1252?Q?N7mJgCRZfQZVLBXFYGkOmPAaC7bsGQQxZ69aet3O0QSkW7zzCcJadt6t?=
 =?Windows-1252?Q?vL0AM7tMDCG2QmKKpqxb4SXmuhK5fJMVtrmyktGhFTIVyWjthi3IWspi?=
 =?Windows-1252?Q?plFQxXep8CVX5nuUoKiswkl/JAfeINHQE5fSAq4dQSg0hc4b+vxoCrN/?=
 =?Windows-1252?Q?abGHuCeamQPsKazLKEqWu7NgR33+hOccRgBPUoJjeuO1FMtjAhjEOlsv?=
 =?Windows-1252?Q?4AlLSPTWKPIathxoxwUgwCnuMhtCUKIC03oxbYOGLG+qbiApVFsA306E?=
 =?Windows-1252?Q?hu6zXdmfGtPX5QOiBVQbis2ODGs5vSd0heJMxyrg5MdSkBT+nfC3h699?=
 =?Windows-1252?Q?QIGZrZLytT3lY3Hl9cCBBX9nwBB4ZLZ5E5yRSBIF/BB7Dn+da1OswcM1?=
 =?Windows-1252?Q?VDOfU3lnIqpgfwrnWkb18u7ijgJ96VfH6uMNoBOjyHELeEYSYqIiixEe?=
 =?Windows-1252?Q?gagT6PMfcagiDLLvzRLVPT/BklGrHemHRYdb8zB/Sqzi4fuAIWTlgZJB?=
 =?Windows-1252?Q?sXmO7mWH4L7AmpcZpi+Ki6lyQsBJ1FY/rc4EBuBSCHT0TTOXte/il1In?=
 =?Windows-1252?Q?05LMDQJLd1zBAPPXwbfhWfZWkBMJa3NA53Srvw0sVFskT7OWmrOyzS90?=
 =?Windows-1252?Q?Fz/3TfsU9CVbG/pphD75WnGPO46lrAu05wKPR0WgaGV3sbyY+r6QRoFu?=
 =?Windows-1252?Q?mdmjtS1anrlo6NgHFnSsNpcQyNs5j0z3eVd+Zg+nnGOVG8fvVuydsYce?=
 =?Windows-1252?Q?jBTprZ73GXDGgO0XnPoPilXl9BqRFVojZ4k887XaojQSH+j0csKbqiFq?=
 =?Windows-1252?Q?9Hvv9lonpD8fYfI8Q/TrEwELl2A2maDFd5yw55LtZ+DHRysUKh2N3Erz?=
 =?Windows-1252?Q?euP1G5X1OYJg0e3e/RpOoxHAa6El5HqDfQAHfyIla6fUQ9JGbGbn/8sD?=
 =?Windows-1252?Q?3L1hn5FTd9YsShaK5UgpqNRnbE/f7hy9yiNEMV6uFmHF/5miw7vI3bsM?=
 =?Windows-1252?Q?WF/wtwL7gNaTzQogrDE/GrycczUHvJLCPbpFwpcI10E6J+rlzz5mL6Ua?=
 =?Windows-1252?Q?74B9pQfxsT5ks8QBM+xy68LfKabszPhZaMQvrSSqmC695ILFQS4DEUdA?=
 =?Windows-1252?Q?R6pDJdOEF5w6OXyxHAUlFm7RbH3K85UU?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB7804A35C24B56EDA46BCB73097F12DS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beba89c7-36b7-49d9-f2ab-08dd479db8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 17:34:49.2905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oYLhnMgRGWLvye0jeaM3wPkzuKbe4cLWlqAK1896Q7q07Uj5MEbhaRmRa+dmsbu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
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

--_000_DS0PR12MB7804A35C24B56EDA46BCB73097F12DS0PR12MB7804namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

Another try.. if it helps (you or someone else)

This series introduces two functions for maintenance.

amdgpu_xgmi_init_info - This is to initialize any XGM related static inform=
ation. Now it's called as soon as XGMI version is discovered. Now, if that =
is causing some confusion, then I could rename to xgmi_early_init and call =
from device early init. The intent of the function is to initialise any sta=
tic info related to XGMI.

amdgpu_xgmi_get_max_bandwidth - Assumes all links are uniform and provides =
the max theoretical bandwidth. Currently, the calculation is simple as widt=
h * speed. In future, this may change based on IP version like speed * widt=
h * x_factor or get the bandwidth from FW etc. Caller is expected to get th=
is uniform interface for any XGMI IP version.

And lastly, both functions are maintained in amdgpu_xgmi.c

Thanks,
Lijo
________________________________
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Friday, February 7, 2025 9:58:30 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery


[Public]


Well =85 I don=92t know what other feedback I can give here then.

We=92re bouncing back and forth talking about language/function/logical str=
ucture or whatever.

I=92m of the opinion that there are too many unnecessary wrappers here and =
am biased to unbroken steps that make it easier to debug/dev later on (at l=
east for me).

Maybe someone else has a different opinion.



Jon



From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, February 7, 2025 11:06 AM
To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery



[Public]



It so happens that driver gets part of the XGMI information through registe=
rs in GMC. The intent of those registers is to help GMC to figure out memor=
y access when device part of XGMI hive. Driver using those regs doesn't mea=
n XGMI is like a sub ip of GMC, it remains separate.



Thanks,

Lijo

________________________________

From: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Sent: Friday, February 7, 2025 9:26:28 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery



[Public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> Sent: Friday, February 7, 2025 10:18 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discover=
y
>
>
>
> On 2/7/2025 8:06 PM, Kim, Jonathan wrote:
> > [Public]
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >> Sent: Friday, February 7, 2025 9:20 AM
> >> To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>;=
 amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> >> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com=
>>
> >> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during disco=
very
> >>
> >>
> >>
> >> On 2/7/2025 7:29 PM, Kim, Jonathan wrote:
> >>> [Public]
> >>>
> >>>> -----Original Message-----
> >>>> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >>>> Sent: Thursday, February 6, 2025 10:56 PM
> >>>> To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>=
>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> >>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.c=
om>>
> >>>> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery
> >>>>
> >>>>
> >>>>
> >>>> On 2/7/2025 5:03 AM, Kim, Jonathan wrote:
> >>>>> [Public]
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >>>>>> Sent: Thursday, February 6, 2025 8:13 AM
> >>>>>> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop=
.org>; Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >>>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd=
.com>>; Kim, Jonathan
> >>>>>> <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
> >>>>>> Subject: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during disco=
very
> >>>>>>
> >>>>>> Initialize xgmi related static information during discovery.
> >>>>>>
> >>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@am=
d.com>>
> >>>>>> ---
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++-=
-
> ----
> >>>>>>  1 file changed, 14 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>>>>> index eca431e52038..d4eade2bd4d3 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>>>>> @@ -2502,6 +2502,19 @@ static int
> >>>> amdgpu_discovery_set_isp_ip_blocks(struct
> >>>>>> amdgpu_device *adev)
> >>>>>>       return 0;
> >>>>>>  }
> >>>>>>
> >>>>>> +static void amdgpu_discovery_set_xgmi_info(struct amdgpu_device *=
adev)
> >>>>>> +{
> >>>>>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(=
4, 8, 0))
> >>>>>> +             adev->gmc.xgmi.supported =3D true;
> >>>>>> +
> >>>>>> +     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 3) ||
> >>>>>> +         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 4))
> >>>>>> +             adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 4,=
 0);
> >>>>>
> >>>>> Can this stuff get rolled into xgm_init_info and called directly in=
to
> >>>> amdgpu_discovery_set_ip_blocks?
> >>>>> Breaking up discovery_set_xgmi_info and xgmi_init_info as 2 separat=
e things
> >>>> seems a little confusing.
> >>>>>
> >>>>
> >>>> Intent is like this -
> >>>>       Set IP version info. This is the job of discovery and kept ins=
ide
> >>>> amdgpu_discovery.
> >>>>       Set any static information derived out of IP versions and not =
available
> >>>> in discovery tables. This is kept outside of discovery file.
> >>>
> >>>
> >>> Then why are you proposing to set up static information in the discov=
ery file in
> the
> >> first place?
> >>
> >> I didn't understand that statement. The function - amdgpu_xgmi_init_in=
fo
> >> - called from discovery sets up the derived information. Only IP versi=
on
> >> info is set inside discovery.
> >
> > Snip from you're last response:
> >>>>       Set any static information derived out of IP versions and not =
available
> >>>> in discovery tables. This is kept outside of discovery file.
> > You're calling amdgpu_discovery_set_xgmi_info which calls
> amdgpu_xgmi_init_info which is setting static derived information in the =
discovery
> file.
> > A wrapper called in a wrapper is still doing the opposite of what you'r=
e saying int
> the snip above.
> > If you're trying to avoid this and keep discovery clean, call xgmi_init=
_info in
> amdgpu_device.c somewhere after the IP blocks are set.
> > And put xgmi_supported definitions in xgmi_init_info since that doesn't=
 count as IP
> version setting.
> >
>
> This is only about structural segregation - like the place where we want
> to maintain xgmi related data. Functions setting IP versions and
> information from discovery table is kept inside discovery. Any function
> which adds further static data out of the IP version is kept in the IP
> related file.
>
> This is not about a logical separation like xgmi related information
> derived from an IP version shouldn't be set at discovery phase.

Yeah I get it, there's function in language structure but I could also argu=
e that language structures should point to function.
Otherwise, we could end up with a bunch of word salad.
I wonder if it makes more sense to roll up speed and width info somewhere i=
n GFXHUB initialization.
The xGMI information is GMC based and xgmi_supported doesn't rely on IP ver=
sioning IIRC but rather the number of physical nodes determined by the memo=
ry controller.
e.g. gfxhub_v2_1_get_xgmi_info.
Then that would take the pressure off all this file reference jumping and v=
ersion checking.

Jon

>
> Thanks,
> Lijo
>
> > Jon
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>>
> >>> Jon
> >>>
> >>>>
> >>>> Thanks,
> >>>> Lijo
> >>>>
> >>>>>> +
> >>>>>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0))
> >>>>>
> >>>>> Maybe roll this check into xgmi_init_info i.e. void early return if=
 null.
> >>>>>
> >>>>>> +             amdgpu_xgmi_init_info(adev);
> >>>>>> +}
> >>>>>> +
> >>>>>>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >>>>>>  {
> >>>>>>       int r;
> >>>>>> @@ -2769,12 +2782,7 @@ int amdgpu_discovery_set_ip_blocks(struct
> >>>>>> amdgpu_device *adev)
> >>>>>>               break;
> >>>>>>       }
> >>>>>>
> >>>>>> -     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(=
4, 8, 0))
> >>>>>> -             adev->gmc.xgmi.supported =3D true;
> >>>>>> -
> >>>>>> -     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 3) ||
> >>>>>> -         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 4))
> >>>>>> -             adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 4,=
 0);
> >>>>>> +     amdgpu_discovery_set_xgmi_info(adev);
> >>>>>
> >>>>> If you do the suggestions above, you can just call amdgpu_xgmi_init=
_info
> >>>> unconditionally.
> >>>>>
> >>>>> Jon
> >>>>>>
> >>>>>>       /* set NBIO version */
> >>>>>>       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
> >>>>>> --
> >>>>>> 2.25.1
> >>>>>
> >>>
> >

--_000_DS0PR12MB7804A35C24B56EDA46BCB73097F12DS0PR12MB7804namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto">Another try.. if it helps (you or someone else)</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">This series introduces two functions for maintenance.</di=
v>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">amdgpu_xgmi_init_info - This is to initialize any XGM rel=
ated static information. Now it's called as soon as XGMI version is discove=
red. Now, if that is causing some confusion, then I could rename to xgmi_ea=
rly_init and call from device early
 init. The intent of the function is to initialise any static info related =
to XGMI.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">amdgpu_xgmi_get_max_bandwidth - Assumes all links are uni=
form and provides the max theoretical&nbsp;bandwidth. Currently, the calcul=
ation is simple as width * speed. In future, this may change based on IP ve=
rsion like speed * width * x_factor or
 get the bandwidth from FW etc. Caller is expected to get this uniform inte=
rface for any XGMI IP version.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">And lastly, both functions are maintained in amdgpu_xgmi.=
c</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
<div dir=3D"auto">Thanks,</div>
<div dir=3D"auto">Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kim, Jonathan &lt;Jon=
athan.Kim@amd.com&gt;<br>
<b>Sent:</b> Friday, February 7, 2025 9:58:30 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:"Malgun Gothic"}
@font-face
	{font-family:Aptos}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#467886;
	text-decoration:underline}
span.x_EmailStyle20
	{font-family:"Arial",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:b=
reak-word">
<p align=3D"Left" style=3D"font-family:Calibri; font-size:10pt; color:#0080=
00; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none=
">
[Public]<br>
</p>
<br>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">Well =85 I don=92t know what other feedback I can =
give here then.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">We=92re bouncing back and forth talking about lang=
uage/function/logical structure or whatever.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">I=92m of the opinion that there are too many unnec=
essary wrappers here and am biased to unbroken steps that make it easier to=
 debug/dev later on (at least for me).
</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">Maybe someone else has a different opinion.</span>=
</p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">Jon</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">&nbsp;</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,sans-serif"> Lazar, Lijo &lt;Lijo.Lazar=
@amd.com&gt;
<br>
<b>Sent:</b> Friday, February 7, 2025 11:06 AM<br>
<b>To:</b> Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Calibri&quot;,sans-serif; color:green">[Public]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal">It so happens that driver gets part of the XGMI in=
formation through registers in GMC. The intent of those registers is to hel=
p GMC to figure&nbsp;out memory access when device part of XGMI hive. Drive=
r using those regs doesn't mean XGMI is
 like a sub ip of GMC, it remains separate.</p>
</div>
<div id=3D"x_ms-outlook-mobile-signature">
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<div>
<p class=3D"x_MsoNormal">Thanks,</p>
</div>
<div>
<p class=3D"x_MsoNormal">Lijo</p>
</div>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> =
Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">Jonathan.Kim@amd.=
com</a>&gt;<br>
<b>Sent:</b> Friday, February 7, 2025 9:26:28 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"x_BM_BEG=
IN"></a><span style=3D"font-size:11.0pt; font-family:&quot;Times New Roman&=
quot;,serif">[Public]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;<br>
&gt; Sent: Friday, February 7, 2025 10:18 AM<br>
&gt; To: Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">Jonathan=
.Kim@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawkin=
g.Zhang@amd.com</a>&gt;<br>
&gt; Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during disco=
very<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 2/7/2025 8:06 PM, Kim, Jonathan wrote:<br>
&gt; &gt; [Public]<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">L=
ijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt; Sent: Friday, February 7, 2025 9:20 AM<br>
&gt; &gt;&gt; To: Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com"=
>Jonathan.Kim@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; &gt;&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.co=
m">Hawking.Zhang@amd.com</a>&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info dur=
ing discovery<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 2/7/2025 7:29 PM, Kim, Jonathan wrote:<br>
&gt; &gt;&gt;&gt; [Public]<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@am=
d.com">Lijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt; Sent: Thursday, February 6, 2025 10:56 PM<br>
&gt; &gt;&gt;&gt;&gt; To: Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@=
amd.com">Jonathan.Kim@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; &gt;&gt;&gt;&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhan=
g@amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt; Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi =
info during discovery<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; On 2/7/2025 5:03 AM, Kim, Jonathan wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt; [Public]<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.=
Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Sent: Thursday, February 6, 2025 8:13 AM<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; To: <a href=3D"mailto:amd-gfx@lists.freedeskt=
op.org">amd-gfx@lists.freedesktop.org</a>; Lazar, Lijo &lt;<a href=3D"mailt=
o:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawk=
ing.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;; Kim, Jonathan<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">J=
onathan.Kim@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Subject: [PATCH 3/4] drm/amdgpu: Initialize x=
gmi info during discovery<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Initialize xgmi related static information du=
ring discovery.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Lijo Lazar &lt;<a href=3D"mail=
to:lijo.lazar@amd.com">lijo.lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_disco=
very.c | 20 +++++++++++++--<br>
&gt; ----<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; 1 file changed, 14 insertions(+), 6 del=
etions(-)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgp=
u_discovery.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery=
.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; index eca431e52038..d4eade2bd4d3 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_disco=
very.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_disco=
very.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; @@ -2502,6 +2502,19 @@ static int<br>
&gt; &gt;&gt;&gt;&gt; amdgpu_discovery_set_isp_ip_blocks(struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; }<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +static void amdgpu_discovery_set_xgmi_info(s=
truct amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(4, 8, 0))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.supported =3D true;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) ||<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[XGMI_HWIP][0] =3D IP_VERS=
ION(6, 4, 0);<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Can this stuff get rolled into xgm_init_info and =
called directly into<br>
&gt; &gt;&gt;&gt;&gt; amdgpu_discovery_set_ip_blocks?<br>
&gt; &gt;&gt;&gt;&gt;&gt; Breaking up discovery_set_xgmi_info and xgmi_init=
_info as 2 separate things<br>
&gt; &gt;&gt;&gt;&gt; seems a little confusing.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Intent is like this -<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set IP version in=
fo. This is the job of discovery and kept inside<br>
&gt; &gt;&gt;&gt;&gt; amdgpu_discovery.<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set any static in=
formation derived out of IP versions and not available<br>
&gt; &gt;&gt;&gt;&gt; in discovery tables. This is kept outside of discover=
y file.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Then why are you proposing to set up static information i=
n the discovery file in<br>
&gt; the<br>
&gt; &gt;&gt; first place?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I didn't understand that statement. The function - amdgpu_xgm=
i_init_info<br>
&gt; &gt;&gt; - called from discovery sets up the derived information. Only=
 IP version<br>
&gt; &gt;&gt; info is set inside discovery.<br>
&gt; &gt;<br>
&gt; &gt; Snip from you're last response:<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set any static in=
formation derived out of IP versions and not available<br>
&gt; &gt;&gt;&gt;&gt; in discovery tables. This is kept outside of discover=
y file.<br>
&gt; &gt; You're calling amdgpu_discovery_set_xgmi_info which calls<br>
&gt; amdgpu_xgmi_init_info which is setting static derived information in t=
he discovery<br>
&gt; file.<br>
&gt; &gt; A wrapper called in a wrapper is still doing the opposite of what=
 you're saying int<br>
&gt; the snip above.<br>
&gt; &gt; If you're trying to avoid this and keep discovery clean, call xgm=
i_init_info in<br>
&gt; amdgpu_device.c somewhere after the IP blocks are set.<br>
&gt; &gt; And put xgmi_supported definitions in xgmi_init_info since that d=
oesn't count as IP<br>
&gt; version setting.<br>
&gt; &gt;<br>
&gt;<br>
&gt; This is only about structural segregation - like the place where we wa=
nt<br>
&gt; to maintain xgmi related data. Functions setting IP versions and<br>
&gt; information from discovery table is kept inside discovery. Any functio=
n<br>
&gt; which adds further static data out of the IP version is kept in the IP=
<br>
&gt; related file.<br>
&gt;<br>
&gt; This is not about a logical separation like xgmi related information<b=
r>
&gt; derived from an IP version shouldn't be set at discovery phase.<br>
<br>
Yeah I get it, there's function in language structure but I could also argu=
e that language structures should point to function.<br>
Otherwise, we could end up with a bunch of word salad.<br>
I wonder if it makes more sense to roll up speed and width info somewhere i=
n GFXHUB initialization.<br>
The xGMI information is GMC based and xgmi_supported doesn't rely on IP ver=
sioning IIRC but rather the number of physical nodes determined by the memo=
ry controller.<br>
e.g. gfxhub_v2_1_get_xgmi_info.<br>
Then that would take the pressure off all this file reference jumping and v=
ersion checking.<br>
<br>
Jon<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt; &gt; Jon<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; Lijo<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Jon<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt;&gt; Lijo<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, XGMI_HWIP, 0))<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Maybe roll this check into xgmi_init_info i.e. vo=
id early return if null.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_init_info(adev);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; int amdgpu_discovery_set_ip_blocks(stru=
ct amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; @@ -2769,12 +2782,7 @@ int amdgpu_discovery_s=
et_ip_blocks(struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(4, 8, 0))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.supported =3D true;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) ||<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[XGMI_HWIP][0] =3D IP_VERS=
ION(6, 4, 0);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_discovery_se=
t_xgmi_info(adev);<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; If you do the suggestions above, you can just cal=
l amdgpu_xgmi_init_info<br>
&gt; &gt;&gt;&gt;&gt; unconditionally.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Jon<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set NB=
IO version */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (a=
mdgpu_ip_version(adev, NBIO_HWIP, 0)) {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2.25.1<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;</span><span style=3D"font-family:&quot;Times New Roman&quot;,seri=
f"></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DS0PR12MB7804A35C24B56EDA46BCB73097F12DS0PR12MB7804namp_--
