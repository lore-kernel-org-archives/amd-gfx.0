Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C173CA0EC3
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 12:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 983A710E416;
	Tue, 12 Sep 2023 12:19:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F0710E416
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 12:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkOj/SHwzVKissvpE0zzmeLzY6LuhvhouTIWdZB8v29B8DVfPN5l/FoIc7Tcu3zus4eBZVK6UVww0FI0FRGjLP0BlLHp8DexshxzoQbiG9us78fPw4M5HCIQPKWbWngYQ8Gb0eGBTouBr5dxRBHLujtddDha2SaujAcafzm6g+6z2L4QuRsMK/9OWWNIYgvONG3N9hHAC4n4ZBZnMgapSRtNQwKscQwC39VCW9RE9UL5YXcub92yjbDyLHZVaAHT/6iY2R3rQt4BMUuv9nj6bqsl8JjQrYxnJhegtxGpgpnzjPm73KWi9W3wFY7CD0xO5W1X2zoeVlp19FjKVEwUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQsHyDO5vHcXKmFQwD/IACFzOyr4vFpK+d6Nb6zDDmI=;
 b=a6QeyTjWxv1UK8QTCGt8wyacDIWleg0lFjKfci4V91S6JmFdVfrUyLSSilq9YA8MM8t2JVdsqj+gA1PHgqqg+JG2TB+s5tCC3HgBJiR12RhiBbkO0CtStaLoFW0EIDAmG9cvSeQ36LlhzNkrh5VSbF8d5/DeVUBMmwiCgDw4/7gi4LbJgEjnQr7Gvpklpyzji5lax59fsI/+VA5IAWAFXwCQJJeGuC2ZJfzBS9OUPapEc1goT4t9hBiDCbEnp9WlrsDXkqGBOPe1qUZ5WSUHNNe3Y5/Qir8fS7XEuaBR16ZYEBrhZf9GXr8cDnwuu1HwxhbqDoAszOf0EY+BQsBiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQsHyDO5vHcXKmFQwD/IACFzOyr4vFpK+d6Nb6zDDmI=;
 b=HCRgeo8XuZmlvzRM/p1abGbFCDoT/8SyaEMDJqmkuy3Yj24b2KXJPs03rwqCG4VHuNols4eQ3/UxO86yowixpVJF615IiyZP0W8Bg2JTzvHzG38nGqnGIy16YIKv6Wev/9iwjNdLBwqRBQj9w48UzNOvQB/uwKuIjQAgzxCmVmo=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 12:19:03 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989%4]) with mapi id 15.20.6745.030; Tue, 12 Sep 2023
 12:19:03 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix add queue process context clear for hsa
 non-init cases
Thread-Topic: [PATCH] drm/amdkfd: fix add queue process context clear for hsa
 non-init cases
Thread-Index: AQHZ5XMkxEqviQodZ0qOUDkc78dhGrAXG5NA
Date: Tue, 12 Sep 2023 12:19:03 +0000
Message-ID: <CY8PR12MB74352A70467B477B576BCA7B85F1A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230912121721.3035694-1-Jonathan.Kim@amd.com>
In-Reply-To: <20230912121721.3035694-1-Jonathan.Kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=74da2973-abe2-490c-aae6-974b1e814a63;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-12T12:18:44Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MW4PR12MB7239:EE_
x-ms-office365-filtering-correlation-id: 24cac2aa-ad86-4be3-3965-08dbb38a741a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W2QnAaV9zQ26OW6pbGAIAhPWUQkRZ9xJXNCUWcGTj0+Ldt9gO/EzMnKXFa+oAvmXViLBtahDNnyanMXQYE/eV15kSHTBzVimWBsibyvxyokATr/AqsVCpazaFt/089lEtTwH2o7S0oKwdemYfyecN5JLs//pWVscOQhFOIwdSS6FvPd9Lqk4JnaeoPr1rbNUZ4JCVkAIxZ5jF8L6oWBCzgZ3mJFwdWZVdivFYCYHmfdlMm+bB1iTmd6lDhz2SuZe0AadddSwwBSDL6g3r9o7GpRaBZCJOL+5onxlrOTHRfmDoUuGib48ezTyJj4mZm8B1Kd7HnDKuwovLwSVX3Ihb1JgC51iO8cCs+f3ghb6tt3X/3iZY++82a1FwpWjnRQL22wb9/hGM+wRJ6h97KTxHhh6bKDO1imfbQv8TiXewUMNKLryj8xns76qPIFkQ4n1jFJTgV9rnm4XzZgjktdbAvu+I2PvVWyU0L0TBJX+UN3hXj9VU3hHy86X2ZdVjKnYJYp9Sw68DpUpsJnYHmO8eDTTqXzlMoxNceC6xLCzpxpqpmcd++ovz8/L0HfeCzcmmQWyQBEmAVuK+vzUYRf86042C0btTt8PbvNhvM5XLmzPQwuCkU6iq8cIb+wWBDy6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(1800799009)(186009)(451199024)(53546011)(41300700001)(7696005)(6506007)(6916009)(316002)(122000001)(2906002)(478600001)(86362001)(33656002)(71200400001)(64756008)(66556008)(54906003)(38070700005)(76116006)(66946007)(66446008)(66476007)(38100700002)(55016003)(83380400001)(5660300002)(52536014)(8936002)(8676002)(26005)(4326008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ek3+SeFAw3rSKtFh6RIYEPpSJr/WOjwFZRr7z2ogFTU6xXM6kFCee8U+V8Cj?=
 =?us-ascii?Q?Oevl31zSJ73BPZ6eO+8/LGJVhpAZOGQcnpQsUai07Ujd5oXjsuA6Q3garfym?=
 =?us-ascii?Q?KKWoOMcEa44pumgNf8m7kR1y78tg3qQWjyTZqWkYRnS6XzSyoNVuoCDxpOli?=
 =?us-ascii?Q?7HFsNsuiHMshjJPZwig4J/ffRw+J+hI3jYrptIKkMhqhtXBqe9ua1Fv3TTTQ?=
 =?us-ascii?Q?MD734qUPemwDBcZHDo9GXr4zusUIozRXR8tkPv/PDa1gEGByolzb8c76rKUn?=
 =?us-ascii?Q?m3TJyGE4DsJY3lviP1YZebRs/Mmwe70Hmdx5VqC+sG4Cufi6X+G3brSa7Ogv?=
 =?us-ascii?Q?OItkcf64n5+1YDjewdZVdd0mFRa6+M1qtTYutML+iJmwk7zoyJpMODMEHgYy?=
 =?us-ascii?Q?Mu0Z7PNFIWQYR+Ij0kt4HvvfCuNrcTAtXMDq2jOkHgFQU7I4qps/pNvFKBdg?=
 =?us-ascii?Q?b8E1BIc66+Lwu81xjK2eDwlUSSNRBwH0Q8rhoYyTr5oEqenQwwgHLcjYhr1w?=
 =?us-ascii?Q?vCfcXuHrwrKWuiXGAI2V+uCjNI2rsGqvmfaXnJHJWkBeLFd3lX6EdqFOMJma?=
 =?us-ascii?Q?//p7cJJEqk+NMY1U/lUH2mX330iCdGOF4+ff4XHCjR9IuQiv721++9eV/4Ry?=
 =?us-ascii?Q?7DmvYknB/DaPbD/k6tzkRLjlPgIt/FEop/iNDZ2LYvq3foWU8u/noYfRtJPw?=
 =?us-ascii?Q?yPHge8l80zLAw+i9o80QPC3cRJlbsAkSfgqAwvqslYDCJa+FwDLEXjNcnJj3?=
 =?us-ascii?Q?AG0JKzQjt1IQ6Br4PCPT7vYZwZLk9Y5VtxUUEY+RNMOHrrkW8FtBO/TmiiaA?=
 =?us-ascii?Q?viuPqHQO0MYMIf+VJ3W/mQIZytzw7BiK4YdGlB7n0IGChbUFIq0MMY9kniRi?=
 =?us-ascii?Q?w4Ei/AVxZ7gJhnBXmSRxyx7oPRd0mbpwBig/cTd+9RAwgNpPSazeDj/GOZ/D?=
 =?us-ascii?Q?H/CgzzOWIe9mgeXDQjh8niUMTe2ucUNtoopoAMIHEFSZnCPMqbOUAKQkG95R?=
 =?us-ascii?Q?Pj2oiED2Y7G65MIxmh2Pfecf+wZ2KoTP073QK2V7RJzBedZIXO3kViLlKfSd?=
 =?us-ascii?Q?qJMdUTzq4Eeahn8kBK2QJ8AXe99bcf/nvWkpL4geR2f4OM18FItICjpocAQv?=
 =?us-ascii?Q?qYIaq9Ybz4JMp4oSwr+pO71YKgyKkM8lLI6U+caKEkeFsy/i+mw+PoIx57co?=
 =?us-ascii?Q?FlUCdGNQKmuV/KNq+kWwfGVQs4HQwEIoPFcQhkOlY+IGcWStvSHlSJ2yHs1U?=
 =?us-ascii?Q?yJbdCyLlESxk8/dSOoaBIIKvEZ2A8h4+Dzzk/66/oE+9sl7+oGayvvB9inmK?=
 =?us-ascii?Q?rwjM4X9oi4HyuP6+W34VrJ7TI6jiPjul9ZAKUOgB/Dh/aozbtoknIfxcSi8l?=
 =?us-ascii?Q?+ioEugg3ri35xzN5HV4c+T2tTNcg8XAeB1DhrFjPmBL/3c/UWP29sqKVecrf?=
 =?us-ascii?Q?B6z1quRQ8BhfaURTinb9txZEF80PKU8r7+6obotughZllkUsY4WtCiBDJB1F?=
 =?us-ascii?Q?REdmn83car4iHbph/vKU5MVh/ldvWEZxQpoWMRnTTeRnMTSLEbmm9En2/wxh?=
 =?us-ascii?Q?tBY32yOWbZgWYGOaBm8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cac2aa-ad86-4be3-3965-08dbb38a741a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 12:19:03.7186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SC9QRs0zhBLu5e0qzI3QHL9deQDmmrOTX0LupyUN0ZsaFKSoX7a9IsfWom/MrWtL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>, "Ji,
 Ruili" <Ruili.Ji@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Guo,
 Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

+ Eric

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Tuesday, September 12, 2023 8:17 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Ji, Ruili <Ruili.Ji@amd.com>; Guo, Shikai <Shikai.Guo@amd.com>;
> JinHuiEricHuang@amd.com; Kuehling, Felix <Felix.Kuehling@amd.com>; Kim,
> Jonathan <Jonathan.Kim@amd.com>; Guo, Shikai <Shikai.Guo@amd.com>;
> Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: fix add queue process context clear for hsa
> non-init cases
>
> There are cases where HSA is not initialized when adding queues and
> the ADD_QUEUE API should clear the MES process context instead of
> SET_SHADER_DEBUGGER.
>
> The only time ADD_QUEUE.skip_process_ctx_clear is required is for
> debugger use cases and a debugged process is always runtime enabled
> when adding a queue.
>
> Tested-by: Shikai Guo <shikai.guo@amd.com>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6d07a5dd2648..77159b03a422 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -227,8 +227,10 @@ static int add_queue_mes(struct
> device_queue_manager *dqm, struct queue *q,
>       queue_input.tba_addr =3D qpd->tba_addr;
>       queue_input.tma_addr =3D qpd->tma_addr;
>       queue_input.trap_en =3D !kfd_dbg_has_cwsr_workaround(q->device);
> -     queue_input.skip_process_ctx_clear =3D qpd->pqm->process-
> >debug_trap_enabled ||
> -
> kfd_dbg_has_ttmps_always_setup(q->device);
> +     queue_input.skip_process_ctx_clear =3D
> +             qpd->pqm->process->runtime_info.runtime_state =3D=3D
> DEBUG_RUNTIME_STATE_ENABLED &&
> +                                             (qpd->pqm->process-
> >debug_trap_enabled ||
> +
> kfd_dbg_has_ttmps_always_setup(q->device));
>
>       queue_type =3D convert_to_mes_queue_type(q->properties.type);
>       if (queue_type < 0) {
> --
> 2.34.1

