Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9B606A331
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 03:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hNucuSoh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7587E10E048;
	Tue, 17 Nov 2026 03:17:47 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B30610E048
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 03:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0t1Io5Ze9eGXRm+XxBvpxrerqy3v5rt9HGep4/J501v90HppyoR31cUq5q/TCpJzcKQ5hNJmXtlkjg/92MUrUKuHYkMcNXZxEalVNpI++1CiqfDhsdpPrceJ9nh4N+6M4R559WvfEVQgqMiLqUj1/TMAlxmQLY2QOu5ZzgnJMp9c0KO0RiQPHERe+szY3pf2FE2WcLG/mzxqI03vCZRGjdParwxvmePGMS+Y6Md9+LTba6KHGS/OnvLEFw9QaB9dKKfDwXjP9D0SJeYUYRlWQnFzyLlkiFzAISdPEHCtOwL1zVjDr79ktzwNRpdf41xh4nTzGK2VzBatHMFmSknJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vch47AacFGefcXhxhcdYy58zLgYbbQ7zFdSXn/4nGDk=;
 b=Wc3SKMsmq59CJKWL2nQHgo53gVohc+3fymSdDmz0EM898+rD0ui+SYnx0IHcstn91gooSn0BRhmlyBJ3S3q1jYMDctFKlYrchTNz+yuOATs1wLfm/as55A3YYcIbN11kF+NMofTdrwLGzv5EthmL4Ia2UqhYWDX88ZTZYtiQRm8BaDIHt84DOK7YMmvlANySbtQIGFMrsvF1oJzhxwjueTN2XF+64VnATa2rGvuS9BakLNjzPweLk6EdlaRMIDHxcmGDy32tu83VPUA9KzJvmstCUL4T2/tTgU4SPIm3m+69+7rMLDY0xt5WQP4w64v/xmwN8bihRPx+bBjjLpNh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vch47AacFGefcXhxhcdYy58zLgYbbQ7zFdSXn/4nGDk=;
 b=hNucuSohFjWWSBFe4FV8ynBMAvquoC9nnIaRwDNtz/1p/InN3LFoD08Jbfx3AxDYHKnSjqLvjdYx5jYBJMQPlLNaVhkTiFJ+KL+D77t/rdJuc/ZtTexdJudxjrbvbFFalSsDtnRan1d4O6Wgu00FHScCVdmDZjY42tlp5j+oR9s=
Received: from CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6)
 by LVUPR12MB999161.namprd12.prod.outlook.com (2603:10b6:408:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 03:17:36 +0000
Received: from CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55]) by CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 03:17:36 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chen, Michael" <Michael.Chen@amd.com>
Subject: RE: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot to
 SET_SHADER_DEBUGGER
Thread-Topic: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot to
 SET_SHADER_DEBUGGER
Thread-Index: AQHdcRQamFUiMPqAKUCsb82hHG/5CLcw3tZggACtVACAABXvsA==
Date: Tue, 17 Nov 2026 03:17:35 +0000
Message-ID: <CY3PR12MB9631D95E8C4C7CC7020841A2F47B2@CY3PR12MB9631.namprd12.prod.outlook.com>
References: <20261110130440.474374-1-Prike.Liang@amd.com>
 <CY3PR12MB96315B4EC5D0B0EB56099E14F47C2@CY3PR12MB9631.namprd12.prod.outlook.com>
 <PH7PR12MB6000FB11CF1AEDECD98287DEFB7B2@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB6000FB11CF1AEDECD98287DEFB7B2@PH7PR12MB6000.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T15:38:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY3PR12MB9631:EE_|LVUPR12MB999161:EE_
x-ms-office365-filtering-correlation-id: 3f11020e-2d3c-401a-f86e-08df445953cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009221227099003|261009223027099003|4143699003|260925021911599003|56012099006|260925022911599003|260925021311599003|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: D2ZKumfI8VBhkBuav8oNmP4rGy32PZQrucnlKkRuDimZe3fJ0CnY9PZ5e7h2ep+ataVC+Ybzffp8DdUfNt+rRkFd0Gb/DNKs3H7S5xKx/w/KEQSfAb2e8hly194lDdIzc5CazkLIjyYIUDrjD/qV/qL9muSRnWOGl64et/Ax3/JiPjO6XZI2L2s9SY1jTjSvOjzJtV5xS9cNHZD9HX60hQ+F6z1FkTrEtMmLaggtsb/WGPuvuqnU5tYKhtETr2eG7A9CxXVTBdilEftJgtLKXfj2aV8v3X/QKVhAa9pNFgs8NVe85Ubx6oZzFdIuHlZI/KmBUAGqvaorgP6Z/mG0GepL4HWurJuXS6s+YPFtJiSRXH+snw00RMDT2jABQcyADxEH8TECe7NB+R06NGg3qlRT4Rqr4ww6XUZMNTcMRuohwe4A7VYBOeNW2lVJ+AGZq655FTFgI5MXGDkt2GvU18ctxk//QUFj9nssPbM1elKoL1QKYbW+0LSyBxWNJ6TJNzWTbaahsQfQA3+NBbWv3uNngtyLlB5jxwZK9n87M4/RNVeCwu1moqXxXQirbP72DcOnLRfOjJDrimm+wBsFWV49Z1xqfX7xLa2yVqtz/oD2SDceUpS6JtGS90yYljwpiaApriQWCanonGhhffJK2/rAV4ggeAuGfAKq8metwRMmbc5nZDAaHoABKx+Xj2dpUFek9FKusb3DDClopZIdMeA1LlZAe+VMUGnL71hVnCE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9631.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009221227099003)(261009223027099003)(4143699003)(260925021911599003)(56012099006)(260925022911599003)(260925021311599003)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x+7/D/TD5s5OYd9ZkA53vgv2/FPMQw27cM0Jc98OthMvEKJcjqCuDnyksBjj?=
 =?us-ascii?Q?Si7j+oPL9Un3vqCVaw29+Xe6xNA2E6dm56TkVJnIjYYmnKBT40iCiksDXXby?=
 =?us-ascii?Q?D5XHEpnL55R595B5iV3xRxsJdlIHIaYhhaPaYHNoSc7+sIFXYXwWAWXoxi/U?=
 =?us-ascii?Q?6iV8q/3p0R/s5Vq+9wVcX8rQDMIjVgp9v9Zob8nbkLyWguzAuRezeGim0a3z?=
 =?us-ascii?Q?CHrcNrD72di8gievIKjeyhRO3iMBKTqyd9CQUk0TzhYLfsz+OhQqGQTbef5M?=
 =?us-ascii?Q?ER42QhEmGD8j82syRAd6UEV185nMRQ7ERKqm8WfyleoX6xFISCv6uFHwCBhI?=
 =?us-ascii?Q?m620oiSYCJUFJuyQ2SV3kDV+RJ3HcI3mh0CL67ALU+93rhCo05Y2mVcL1I00?=
 =?us-ascii?Q?F5zPjQeyflefN4gdq/Z+eLzxxy1TTCmEb/QgVQSFZk7ecxCOe01N5i4FyWIa?=
 =?us-ascii?Q?NEOfATMlLlnTZJfMzeGoXj3Wanu0HVjDZRCoNx0EuYco+D13YX49uz5Ud3Bi?=
 =?us-ascii?Q?uGGjaoryThBzCtTUXqgI4BDyrlq7wew1/+2LYt2fWH2r8S83y4PeGz3Xfzw4?=
 =?us-ascii?Q?GCXytxB8zHo33NK+HTRg2hdRTElAfDaAuWtYWZGbD1E1gokN78BygWvZxdUj?=
 =?us-ascii?Q?9piQlpoCzbWB9PObcumsSC5IOu2Ghthix8iInwErgL/wGFruSxJL3YBolH0n?=
 =?us-ascii?Q?uPXBQXDn3wAM3w3oDrlsTgbLRUJaL7zykW+UJbR5cc5rTDmdXXBHr0Civ6uR?=
 =?us-ascii?Q?ZokEwFRuNmX93IVhxHQWZEJQbXy+hRihZhdxTxxMnQ2W6LzLtBvliNwdBXC+?=
 =?us-ascii?Q?mwmQ6sE/BzX0PHg/hXv+CFyfpPCjzTCWR55viKSywcDXOwMoZ1T7J9S1YsT3?=
 =?us-ascii?Q?5fJvlHCUnjgNlmSyMv8fv5lDhwc3zildO6z37P4JbLh7dQiJPoWFVmpC1eET?=
 =?us-ascii?Q?nv/+NVW66O2GiBQfbIxRl9XMr3va2o3mi9N4nOUdsja7aMJk6trNcnqWT36V?=
 =?us-ascii?Q?HALWTdMoFbr5+chsuVsOQjOxr6slG86oDwd7asNWvME5N4dlX/EdzkuWB7V1?=
 =?us-ascii?Q?Q64x6jSo90K/10M3zcGvv+KnR7hxiD74eCAnBameG73MQsJI0S6lO8v/HU2C?=
 =?us-ascii?Q?KPHX0zAWwP2obuR2bdqnedcyucoHERGtZARLB2t7TJ30pTgWjvZPlyGb6XXK?=
 =?us-ascii?Q?uW5AU7+e6r4eFEPxF0vjCHBvn1AXRLaAGAwTCe7M9Qc7JOo9A2+Um9ZikDjQ?=
 =?us-ascii?Q?GsR/5NFfNv5yR+DZ12XnJmDCtCG8C/2zMVPSnnHwuTHw93XNLw5qm0plKuhS?=
 =?us-ascii?Q?uqXJIYHcs1MQxVNJwLrv+aoljmELEVXTUu3ItIziCpqUTdUFZ08N4SC04nH4?=
 =?us-ascii?Q?z0GK804yA3HXpXcOuWVy816sMOcsunqRALaTsxl4LBn32Y+Pw/39A/p+C4ni?=
 =?us-ascii?Q?3+LoXX5+idVkmj9N1L6RHStgU95npD3qaPEG1rQ2cc+QuQudxYAAdzGGkS0x?=
 =?us-ascii?Q?Y1r3kWSgRMGdrFOtNf8NAtxtt/iLoTUtA60dNRkiqrzPCEQSb180k2luxLcq?=
 =?us-ascii?Q?nS6OGQN7Y8LNxdCn7CbPbBUD+owwGbe1LIHQT2b3vejPp0q+BadKIfimHleg?=
 =?us-ascii?Q?shJfZlaQiMxCa8RMgB5aOqWixCWyyU916jXrudUZrbtoVGLFDLBkQwreRBYI?=
 =?us-ascii?Q?UNCv58GfkLmpt21qfNbqtYyw/dTkAnobL6W2NdOyGZVqL0yW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9631.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f11020e-2d3c-401a-f86e-08df445953cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 03:17:35.8638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3GWlGsULPFseNILLfRtsAhqF3zzOvOhtFkVvS1bn+ofK0tr7IEWfg1jU3+V/iZ/iWJXZvu+mKJ/qJKt4QVkYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999161
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

Ok , sounds good to me . you can add me as acked-by

Regards
Shaoyun.liu

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Monday, November 16, 2026 8:59 PM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>
Subject: RE: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot to S=
ET_SHADER_DEBUGGER

AMD General

Yes, I plan to enable MES context index loading for GFX11 first. How about =
we handle GFX12 and GFX13 in a separate follow-up patch series?

Regards,
      Prike

> -----Original Message-----
> From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Sent: Monday, November 16, 2026 11:39 PM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>
> Subject: RE: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot
> to SET_SHADER_DEBUGGER
>
> AMD General
>
> Please also copy process_context_array_index in mes_v12_0.c and mes_v12_1=
.c.
> The v12 API has the field.
>
> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, November 10, 2026 8:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liu,
> Shaoyun <Shaoyun.Liu@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot to
> SET_SHADER_DEBUGGER
>
> With MES RS64 process/gang context loading, MES keeps the process
> contexts in an array in its local memory and looks them up by the slot in=
dex the driver passes.
> SET_SHADER_DEBUGGER has a process_context_array_index field for this,
> but
> amdgpu_mes_set_shader_debugger() and
> amdgpu_mes_flush_shader_debugger()
> only pass the process context address, so MES always gets slot 0.
>
> KFD sends the flush variant of this packet for every process that
> exits (kfd_process_dequeue_from_device()). In RS64 mode the flush
> therefore hits slot 0, which belongs to whichever process allocated it
> first, instead of the exiting process's
> slot:
>  - the owner of slot 0 loses its process context while its queues are
>    still running, so its next GPU accesses fault;
>  - the exiting process's slot is never flushed, so the next process
>    that gets it starts with a stale context.
>
> So the KFDIPCTest.BasicTest failure on Navi3x was caused on the case
> when parent holds slot 0, the child's exit flush wipes the parent's
> process context, and the parent's next access to the shared IPC buffer fa=
ults.
>
> Fixes: e32b68c6b135 ("drm/amdkfd: enable rs64mem for kfd queue")
> Assisted-by: Copilot:claude-opus-5.5
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h                | 5 ++++-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                 | 2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c                 | 3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
>  5 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 7864afab5b40..99b803f95c56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -763,6 +763,7 @@ int amdgpu_mes_hdp_flush(struct amdgpu_device
> *adev)
>
>  int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>                                 uint64_t process_context_addr,
> +                               uint32_t process_context_array_index,
>                                 uint32_t spi_gdbg_per_vmid_cntl,
>                                 const uint32_t *tcp_watch_cntl,
>                                 const uint64_t *watch_addresses, @@
> -782,6 +783,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device =
*adev,
>         op_input.xcc_id =3D xcc_id;
>         op_input.op =3D MES_MISC_OP_SET_SHADER_DEBUGGER;
>         op_input.set_shader_debugger.process_context_addr =3D
> process_context_addr;
> +       op_input.set_shader_debugger.process_context_array_index =3D
> +               process_context_array_index;
>         op_input.set_shader_debugger.flags.u32all =3D flags;
>
>         /* use amdgpu mes_flush_shader_debugger instead */ @@ -811,6
> +814,7 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device
> *adev,
>
>  int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
>                                      uint64_t process_context_addr,
> +                                    uint32_t
> + process_context_array_index,
>                                      uint32_t xcc_id)  {
>         struct mes_misc_op_input op_input =3D {0}; @@ -825,6 +829,8 @@
> int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
>         op_input.xcc_id =3D xcc_id;
>         op_input.op =3D MES_MISC_OP_SET_SHADER_DEBUGGER;
>         op_input.set_shader_debugger.process_context_addr =3D
> process_context_addr;
> +       op_input.set_shader_debugger.process_context_array_index =3D
> +               process_context_array_index;
>         op_input.set_shader_debugger.flags.process_ctx_flush =3D true;
>
>         amdgpu_mes_lock(&adev->mes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index e5dbcf8ef890..9358090165aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -450,6 +450,7 @@ struct mes_misc_op_input {
>                         uint32_t tcp_watch_cntl[4];
>                         uint64_t watch_addresses[4];
>                         uint32_t trap_en;
> +                       uint32_t process_context_array_index;
>                 } set_shader_debugger;
>
>                 struct {
> @@ -653,6 +654,7 @@ int amdgpu_mes_reg_write_reg_wait(struct
> amdgpu_device *adev,  int amdgpu_mes_hdp_flush(struct amdgpu_device
> *adev);  int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>                                 uint64_t process_context_addr,
> +                               uint32_t process_context_array_index,
>                                 uint32_t spi_gdbg_per_vmid_cntl,
>                                 const uint32_t *tcp_watch_cntl,
>                                 const uint64_t *watch_addresses, @@
> -660,7 +662,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device =
*adev,
>                                 bool trap_en,
>                                 uint32_t xcc_id);  int
> amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
> -                               uint64_t process_context_addr, uint32_t x=
cc_id);
> +                               uint64_t process_context_addr,
> +                               uint32_t process_context_array_index,
> + uint32_t xcc_id);
>
>  uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct
> amdgpu_device *adev,
>                                                    enum
> amdgpu_mes_priority_level prio); diff --git
> a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 60b27278a598..2617c2b7f101 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1043,6 +1043,8 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes=
,
>
> upper_32_bits(input->set_shader_debugger.watch_addresses[i])
> & 0xffff;
>                 }
>                 misc_pkt.set_shader_debugger.trap_en =3D input-
> >set_shader_debugger.trap_en;
> +
> + misc_pkt.set_shader_debugger.process_context_array_index =3D
> +
> + input->set_shader_debugger.process_context_array_index;
>                 break;
>         case MES_MISC_OP_CHANGE_CONFIG:
>                 if ((mes->adev->mes.sched_version &
> AMDGPU_MES_VERSION_MASK) < 0x63) { diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 71b34a57c2cc..cb830f985536 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -373,7 +373,8 @@ int kfd_dbg_set_mes_debug_mode(struct
> kfd_process_device *pdd, bool sq_trap_en)
>         }
>
>         return amdgpu_mes_set_shader_debugger(pdd->dev->adev,
> -                                       pdd->proc_ctx_gpu_addr, spi_dbg_c=
ntl,
> +                                       pdd->proc_ctx_gpu_addr,
> +                                       pdd->proc_ctx_array_index,
> + spi_dbg_cntl,
>                                         pdd->watch_points,
>                                         pdd->watch_addresses,
>                                         flags, sq_trap_en, diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index b68e884b1c37..d3149e6d40e4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -96,6 +96,7 @@ void kfd_process_dequeue_from_device(struct
> kfd_process_device *pdd)
>             down_read_trylock(&dev->adev->reset_domain->sem)) {
>                 amdgpu_mes_flush_shader_debugger(dev->adev,
>
> pdd->proc_ctx_gpu_addr,
> +
> + pdd->proc_ctx_array_index,
>                                                  ffs(pdd->dev->xcc_mask) =
- 1);
>                 up_read(&dev->adev->reset_domain->sem);
>         }
> --
> 2.34.1
>


