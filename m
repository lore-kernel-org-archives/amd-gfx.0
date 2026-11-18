Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DCE606A331
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XRBgX1DF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D918F10EC65;
	Wed, 18 Nov 2026 22:02:45 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEF6510EC65
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHdo8d81Upw4oXV2ZsF9qXftUP4pNegPghHS7XDSKFGt+tfysm10IO6jpYqkKEbbIYh0ld8bmIXi4G3q7R/E8/qXkh+oGZ9huo8QmyUR/tZr1qfKz6thj4S7qvCa5tVO6eonTBQa95cQvjXBPlKUKwflJNoR8Lai7kwhC3l75/0pKlaPzzEMhkuJhjjYH9bfEc/e4S/f0SbH2kZ4sh3f0am3qeTh22dC5iB2Ep+QimJMt1JrAtiAExPbm9cCpQTTZzaFP7r+1E+qnRQtHClizqANdm/FfG8g3bPtJ4L/O/1m7QCXlfZpPxzUX44dDFiNJrONXy2H3K2cbthgFxBaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGpGyNixLbYZF/unn5u2+PBkBUuJpP0iYzmAEYflLno=;
 b=aLhV4OO6FbjNPyK6f/3owEhMHvcOMMom6FE5+vNnuHTVoH7iH7IOoELi63NOAno7CG3/HvQWLsQUBMeCXdktyfaGYRHhhMZTLD0pELbWawp/q2RAyfv+bkQdEW32LFYAwirYk491LLdIv9yAqbMAAKQJvkUftelZL3arOqvRjSLZmoaCrm/SSb+ykpEVs9ZaCr4t92LRR14+gymw3PPR5N9MCCiElvsdxfUaggGXxOuvTQUnt+NTJBrZ3+6Av+rW+pOLP0XNjNKKVU5LtjBDeHjAkwZeqEUwn2svXjLKPCxJU5KbmP2uujFWoXsZKzPB4UUXdnD3UJQTXP+hgAjFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGpGyNixLbYZF/unn5u2+PBkBUuJpP0iYzmAEYflLno=;
 b=XRBgX1DFrRUJRpHb0kzssiT7fL6PEsNIUc1IzhJuqnAqdEx+CzdhgoUgmP8Xioc5THWiulwdxnRW2RXaTw36jmAnqI/XbmSYcANJObikPADOSCDqnxSIUaGnTa77RWyUrxGJIZkeevDEcl5fZgBFNiAT/1cU2EjaCYnFmy9Cqyo=
Received: from DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) by
 CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Wed, 18 Nov 2026 22:00:29 +0000
Received: from DS0PR12MB6392.namprd12.prod.outlook.com
 ([fe80::b9a6:8ba0:56d1:9aa2]) by DS0PR12MB6392.namprd12.prod.outlook.com
 ([fe80::b9a6:8ba0:56d1:9aa2%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 22:00:29 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdkfd: return the memory violation data to the
 debugger
Thread-Topic: [PATCH 2/3] drm/amdkfd: return the memory violation data to the
 debugger
Thread-Index: AQHddyC2J/JR1POX7kStjKik7WoFJrc0YJ0w
Date: Wed, 18 Nov 2026 22:00:29 +0000
Message-ID: <DS0PR12MB639251AAB4DEE4C334455016857A2@DS0PR12MB6392.namprd12.prod.outlook.com>
References: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
 <20261118055009.3005630-2-Jesse.Zhang@amd.com>
In-Reply-To: <20261118055009.3005630-2-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-18T21:54:58.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6392:EE_|CY5PR12MB6180:EE_
x-ms-office365-filtering-correlation-id: e79cd427-b48b-454c-eb5a-08df45bf5bda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|261021121427099003|261022105027099003|261021123027099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|11063799006|56012099006|10067099003|4143699003|38070700021;
x-microsoft-antispam-message-info: tZitSQh9QS9SZqyB5ilqYanAsCshXJ5x1AjxudLn/YnnI75l+cZcL83PyJin76C6Wr1GAfa3+arSzCPQbxNIa+FoSzRzRvuFNvOq6vVRb3ZtGmTS/7Hf8bee8oURViQ+o2w2DvBCGWfOTGIp87uBymbXE2tFWqXux6N/M2ufpBkZbVyDd3ywI4KNlW5+p8W/2+CAe9ZzCCowjX+290n8K3UYoQnEhpD6u8ViABESv4TU8y3oRPzd8T1/4jkm2bt7YRdC641tvU3M++SLRZVn5TJsy3fCcPelydNrxybM0oetKojBexg4SwZZ5ww9AUjmERTuenEpTnZb8JLwp8gVt9rdM13q5ezJwOnUfyHQ9M7pFZY9+Y40vPHGibTsqmAAOM5mwGCsYtbAw3zVFBQLYTE+XQ2yTS4gCxvBiT5JW+dVw2yVMa33bqRfoS+q+2s2rZ5MbNkxXXoFD8Uno+IoI6DsgVew6AGoLTxkBYOCao77BQ4oSfq3mUADegtagX/kcWhoP5Tt+qycj0jqhy9Fd0dJIa6fhvKY8JD4mAj/8fr7dJWShSB7s9wy9QBssuLOreq9U6U/xs2zFEb1526nsRPPfveMNGyROs/B4O9VZzVSHa5nIbgQ0m+16KVYsmJ9PYHZ+h9RUaM6OMpkIIdLm3UNTk8eszZ5b0i5f6YwON+Zby9s2Arv9MAtBVDmdbc9iXXGd81YDDQUKNErnu8UB3e9vmdmah0lVp6l3kTxueI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6392.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261021121427099003)(261022105027099003)(261021123027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(11063799006)(56012099006)(10067099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k8Cq5l+hIFmtqe5/qbt79VWvK5GsXywoTk8IzMHeQjre99he99NFUgWs19Vf?=
 =?us-ascii?Q?EtC2wbA69t7zE3IQZTYZ30vLuLDL7sZ4ExYnD/tajbeC61DTQF7o2sZlOa47?=
 =?us-ascii?Q?gwJWfbnVinFC3wBfZbBO6H/PdBzjU3+x6NTTFacp/1FG1p+Zh0wWox6Se7gL?=
 =?us-ascii?Q?/ALV0Xn+jiiVeQ6eLwWaWyYaIyZce/2popDpioxFi/unC7IjyBuwT16FNmng?=
 =?us-ascii?Q?uHYUZoWKSTuuGwD1Qq3xnYNNJd+U2KRQuO/w9S0dt65LaIvDEryqIWpUAPy8?=
 =?us-ascii?Q?s90HmgpTbZSHTWTMGvBzOXuCeZJGCg3V4sy3emH+ErtxoSfIftH0wFF72H1o?=
 =?us-ascii?Q?wOxaSZG+5dkYZwkncsz54w8GSKLg6s5XdXUcbFbKVViLqnBaE45IDxThw7Hu?=
 =?us-ascii?Q?bQKEGfUd0BdiqMYMIirdK/DHVmauPBqjaFOtzywhGVsa8kvow5qinONR69EM?=
 =?us-ascii?Q?z85b8WC+OgLYAtCkgK168/uKihkihqJIZG3WpXA5DTlYlp/RDCDNcPFsLxTY?=
 =?us-ascii?Q?poHlsODbqppPzW/e0qPQiIDHZHreyef9l3x0Epw7Efnrzf+oy6zJ/l1+9vrr?=
 =?us-ascii?Q?vWfqJU/9nlYjr6TfS7mFKNjXUvoGHpPQBmModKYDe8W8nZ2BSOMcG177h453?=
 =?us-ascii?Q?2dAy/FvBYdaasXbM/6qQ9pM6JjpfZXgdXrxZDTd4CMYhiX0yhPkRxds8ZyrW?=
 =?us-ascii?Q?HkVtPGs+nJk0sm61yE+JQsX1fLZ4S9m/b2ZMX2yGBsY5123dbYEdMeNWD6/Q?=
 =?us-ascii?Q?LNuBQCZNsXt3/92QUbiMw1fn5icQvM8J2sdE79tipv0wvlqOevhD7fKDgpRe?=
 =?us-ascii?Q?5ImUPPOZMtD6a76LxaR6wZM8670Z4L1p6zJq3ZvknrYv8R7cEGKFw+6UiV1E?=
 =?us-ascii?Q?bXBbp+30Ri0R9JrwEPoIeVVPlFLOYtbpItcA13rITmmu0PQ6tdIEdnLK4RLn?=
 =?us-ascii?Q?kWEzctdspV2CMjxcH77Iz0WuJlDGpffBYeYvYku8KoWNPMqaApAJ0YsvlIlp?=
 =?us-ascii?Q?m16DZVjcZwdWkQ/RqsRFJ5ZbH5O460SrxpR8C86Cr2G0VYMFCuNKmqG64yBZ?=
 =?us-ascii?Q?34YfjEZdLCfFUawmzs/9wK6OtBFM9G77/ERtyL40JiQ7NETRb81FMjwEjDp1?=
 =?us-ascii?Q?5u7eFqZIri+LIBIibDGQASX+yrYCaaYpzYHFZXRQASEToFQt7X025vzz7xMJ?=
 =?us-ascii?Q?Zzcy4qPfjMahfNJUp5UwkwOzhdBcJs+K/mPTM+T1Cko5ntyocx5RjRA6iVUq?=
 =?us-ascii?Q?oSyNJSsx0RHeCLVIdLuPo4J5bv/SowH3DMSb+XHLefq5YY4MpLhmMl5iBbbj?=
 =?us-ascii?Q?RqeffnnbUv7r9BSMI2Z3uPHF5HYK2uivVyLW9WUVAIiUL5f1eHr+cxS2zkRB?=
 =?us-ascii?Q?IxRnOIEauVV+cQAXKSrmHRikxB+g87g2HQ4snyJBphRuMqe8vV/bwNoLS5/S?=
 =?us-ascii?Q?1FnEomXkA4tUr2cQArnaruFmf6+w183IdR77tmoKwgDT7jMPDNUaeq+r0Q2I?=
 =?us-ascii?Q?q6w+G5SCNJeCW53mSVQmqHjj9+A3Fvf6gIA1PIycyLtiAA+RxcMQ+aTqlInO?=
 =?us-ascii?Q?/Kc1sOXsmmIhe3mFNoC00A45wixv8bhwUy3FoxX1uojAgrRsYjw09XYfioqE?=
 =?us-ascii?Q?bca8PyXj+otqJSw0BbKcSKx4dg1Yh+jHHZzbre9WtMjZHQkPZ1mfaYcjngZO?=
 =?us-ascii?Q?GkPdiZqfWBAeX6EbUQKnqloasfE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6392.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79cd427-b48b-454c-eb5a-08df45bf5bda
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 22:00:29.1047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FCoWffBDmlkfE0jWoqGNDEltwrskuskER4SqFXVdM/Ow3PWQ2XiZhEjARhkVJBsq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180
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

Public

> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Wednesday, November 18, 2026 12:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 2/3] drm/amdkfd: return the memory violation data to the
> debugger
>
> kfd_dbg_ev_raise() saves the memory exception data of a GPU VM fault for =
a
> debugger subscribed to EC_DEVICE_MEMORY_VIOLATION, but never sets
> vm_fault_exc_data_size. QUERY_EXCEPTION_INFO copies that many bytes, so
> the
> debugger always gets 0 bytes and no fault address.
>
> On navi48, with a process debugging itself and a KFD SDMA queue writing t=
o
> an unmapped VA:
>
>   amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:40 vmid:8 pasid=
:63)
>   amdgpu 0000:03:00.0:   in page starting at address 0x0000000060200000 f=
rom
> client 10
>   amdgpu 0000:03:00.0:         Faulty UTCL2 client ID: SDMA0 (0xd)
>   memory violation info: 0 bytes, va 0x0 gpu_id 0, fault at 0x60200000
>
> With the size set:
>
>   memory violation info: 32 bytes, va 0x60200000 gpu_id 51573, fault at
> 0x60200000
>
> The data is also only freed by a query clearing the exception, free it wi=
th
> the process device as well.
>
> Fixes: 2b36de971d25 ("drm/amdkfd: add debug query exception info operatio=
n")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Good catch.  Thanks.
This patch is Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 4 +++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index d5c87de519ac..14e7ee30cbdf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -143,7 +143,9 @@ bool kfd_dbg_ev_raise(uint64_t event_mask,
>                                                       exception_data,
>                                                       exception_data_size=
,
>                                                       GFP_KERNEL);
> -                                     if (!pdd->vm_fault_exc_data)
> +                                     if (pdd->vm_fault_exc_data)
> +                                             pdd->vm_fault_exc_data_size
> =3D exception_data_size;
> +                                     else
>                                               pr_debug("Failed to allocat=
e
> exception data memory");
>                               } else {
>                                       pr_debug("Debugger exception data n=
ot
> saved\n");
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index f959f19d92d2..d57eebec063c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1288,6 +1288,7 @@ static void kfd_process_destroy_pdds(struct
> kfd_process *p)
>               atomic_dec(&pdd->dev->kfd->kfd_processes_count);
>               mutex_destroy(&pdd->doorbell_mutex);
>
> +             kfree(pdd->vm_fault_exc_data);
>               kfree(pdd);
>               p->pdds[i] =3D NULL;
>       }
> --
> 2.50.1

