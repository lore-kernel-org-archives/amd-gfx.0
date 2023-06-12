Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090BCC7EE2E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 06:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB49610E158;
	Mon, 12 Jun 2023 06:22:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACEFE10E158
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 06:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keIbb8jE3QN9jvcoNJOd5AnBHF9hqfWW3Y10S4arbW963orW3K0SV8SEJ2mlua0yi6HtnKf5JL9BzYWWu5jrbzZ+JIzJ6JKmw3IqW8lfdgFU5VtMhJu11KIL2YCs8NS2FxepsmzyOH3R0U2R1oLTL65++dZlhHOkb7QPa3srBkP1IrdpiH8OHbPeb6ldtrux/BgXrPUbJB/UjeHKqzHh9yD7M+HwvMzAKYep8oGJYwOcAcgegFpGx9+ApK6KTdXLBY+qDYhK1wpxKb8zncuuIPaFhCqRULHhTTfra8qJuD5VqrQh6EG9BiqyDVqjo2F6a59L48Ggy6koqhEo9ytzIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeeJq2ybvqeuboP1QYmz5i/8gs14ZRardg61HA6J2Wo=;
 b=CYOEQwKIHbZxIVwBUzy2fd5CIqGCA7URGbvctUkPhNpO+PBocMWdZ+AXKZKWqEPqqzgvmOncoU+pv0zt7O00o9/GyMYda7cO1jsrBYC4jCDRBHeDVa+5sozWp7bIH9OHpd1OcLe0ItIml6TojSMM2+fvS0Z0/aSELpi1ZRAduQ7K3U1d1wuumu0n0/2HfuLu2xtoNXEOhWObvuXC+K4DR+CoAKMmQPy3AVQ2eQCbnsED+ao8I5oryTiYQVCSVHE6gKXxmO1614vB4XABfRVnFTAqxy6FadwqbsRGAXIHndG3wVb40OszVmEocCFPpcVuiQO80YjCaprE2B5no64oOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeeJq2ybvqeuboP1QYmz5i/8gs14ZRardg61HA6J2Wo=;
 b=aUDAukooSn+Pwnx9XgBib2+kyeLHiqByqY81NGvKueLVEpGRyS1hJyvxJOcrFWMZ0OeyU1C18vOXSwcpxRO24xsjsyjUkeGvscG6U06/aJN9XihinZSPdkmJJAKhyM07oF+Tmr5NPm5GydgQO/CM8vtQ5++CaQ+DP6CXzwfzOLI=
Received: from IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 06:22:18 +0000
Received: from IA0PR12MB8981.namprd12.prod.outlook.com
 ([fe80::9731:385a:f48:ff69]) by IA0PR12MB8981.namprd12.prod.outlook.com
 ([fe80::9731:385a:f48:ff69%7]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 06:22:18 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Only create err_count sysfs when hw_op is
 supported
Thread-Topic: [PATCH 1/2] drm/amdgpu: Only create err_count sysfs when hw_op
 is supported
Thread-Index: AQHZnFHyEFC/rH2QkE2KaybBIaTLva+GsvUA
Date: Mon, 12 Jun 2023 06:22:18 +0000
Message-ID: <IA0PR12MB8981808D1397785333F2F8F8B054A@IA0PR12MB8981.namprd12.prod.outlook.com>
References: <20230611104546.7383-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230611104546.7383-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=dc9c71e0-10ae-4924-8399-0f51f5c2e5eb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-12T06:19:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8981:EE_|DM4PR12MB6421:EE_
x-ms-office365-filtering-correlation-id: a3a9e55d-5840-484e-9310-08db6b0d5f68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xxzS2SqJEN3Lh9neExE4NjxeDFU3G6unWDhynKeb5nAvhGd1Luhk/BJzDTZsnTi1pNUGuE9B3pFfIzVmK+6PSHDorIEI7P/syDGj4pIj0gZus4qctb5GX7QvEHkf/gCf5rxcncy6uiB5iD7YU9rtJxI3V6FUxRpqpz7QrD+Zath/G73sGpyWuNdyYC2orabGlgGoXl6Q1zXmZASCGiGSSr3uGA2EOkScjH314xyC0PE7aIuridfskaudWidYQNMIWC25Cv0XWP8kZDLnRYxH7dV10xD/rmZroBrqv2Oimmc8Nut/94Y6l86LMXyHTxZJuo/RXoAaSG6l3jo4ZtK7xcFO8pcMLQ0Q/Sc6bJVCGwSiIhnrap/0c3ZGI4LUnGaw/jmWntvQMPiOcJmIqDhDJ3r5lUTDDv+BQLg6dry9HPyl4Q8Ut8AhukUU0/q33X+7l+V0rqnnlFt/WMO5NErzJyLwwBsvLJHUrpzE9O/oeRVoQh69gxsutY4RZMV+ezW6fgwFOtRMoWwQy+verSwRcYWHAUqBmao6wZXzx0p+ExTCiqMvOjhyf0X0tasaYQhM78Lg6q9xtg2p74r0Nia3iIdSPwyTamt4cSCYzKZEbYv7G7x+MexYXUgw7BESrRRI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8981.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(316002)(7696005)(41300700001)(83380400001)(86362001)(53546011)(38070700005)(9686003)(6506007)(26005)(186003)(2906002)(33656002)(122000001)(38100700002)(55016003)(8676002)(52536014)(5660300002)(8936002)(76116006)(66556008)(66476007)(66946007)(478600001)(110136005)(71200400001)(6636002)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7hU57VV7QJZeyN+CWWZz2zWCaKyMCyvDdSzWa5tntXaXRq2bUBdahVk8ZTWP?=
 =?us-ascii?Q?3xo2sxWOAHKgN9z7TXEHDejwoWQAbb8qmRvcs8FDg4GPSTKXy+1JkJOyxn5q?=
 =?us-ascii?Q?OY9sKbg97GUp8Vv+3DKA/fifQiox5qOBkq3fqF/q/LFCp71o+jVs15MFZbGz?=
 =?us-ascii?Q?01pO1izU+5y3UtnBB/IVWAOKAzquWN/8Ofx3A4REoA3XIsgoIn7le4IPrh21?=
 =?us-ascii?Q?U+vedpMgCau2qlZQBaOaV1rC8GIU8cDe+4qWrs6u9uAlDClf9u5ojX+3bh4y?=
 =?us-ascii?Q?tEzp63wvxPbvqWxlbkUxCLUA3uFphynrBGXJOX+cmTLVygFz0NZQBJVCrdvL?=
 =?us-ascii?Q?Md7H39N1mL8xUMKTdG6kVMgobW0cMxEDxrACcXynaICbaxQ5d7z5DwT3g4bm?=
 =?us-ascii?Q?AMgkHf6HBjG3I8GsrF/ZQrtS+7tZX7a5vdG757pZXu6MLR26VF3pJAnDWb06?=
 =?us-ascii?Q?vzYTRqaKafP3O6XTAYMAhUl8z2RBXNyPWCIBXWNO+tNAxUnkiFYK4AJshThz?=
 =?us-ascii?Q?DapN2IjpaRsfFHfEsWPaCt1Ki2TCvEZIKzIY7LqLSqAa4yE9hb14rIntNeUC?=
 =?us-ascii?Q?uRuKQdGwGkknqv8UO9npBnwiqrmbWUaV1C1ksC+3NSEFVAjckqdIR+iawoD4?=
 =?us-ascii?Q?KOG/WeDTHsmY7L3rc43qGN/RzWMP+Vo6HJEuEGiedQbxDk1AUg0X0uOiWPzP?=
 =?us-ascii?Q?5s/8/6TjaUi1iONF1Gb3wea9k/ulyAIdbACtb815oYKtNQVYDrPlKXqpXo03?=
 =?us-ascii?Q?TH97uoH2zIa3DJlxmb+/MUIPe72mSc0cSI3Pt/s4ORliSQlbVJv/xhJ2mq/N?=
 =?us-ascii?Q?QkgIQBPCtECswB+hrIeJR0/SOxitiOOeFgHYnTBuPtnsNZ+XSQMjp08fXgvb?=
 =?us-ascii?Q?hevy0XuyBY/Dp5Um1p/hGSL7vEJ1fR2PiwceDkSHaMC/QM0lnkvEmLfdgYlQ?=
 =?us-ascii?Q?QEZZAMDQn/6N63J+FD+iV8CKRMgCSpP2rlMuTKJZ/qDxcLUByZhGA/IyylP8?=
 =?us-ascii?Q?Zo7rLMFdo4lcScqaALPs7zMN4Y9DhCFlleYF8ZZfjF96PoRB+b51g88cPu90?=
 =?us-ascii?Q?sVlDD34YpfKTXpTuSMjXSrDkTzXUV6JL3t8s8gHirm7r5j7/JD5hV1s/mvF3?=
 =?us-ascii?Q?/bcRHpKg2TayEwlcM9e9guZ2ojgExnLd2IuZKgiFzuvNJrl7B7Wq570TgSJ2?=
 =?us-ascii?Q?XzL7Ae2/zLsfhjt4EGcV1JrfAIK4W/T3rY0yek/SDt8Nw9ju0w+xCGH/XKnB?=
 =?us-ascii?Q?qkIxC8MtS4YCRjLoxytLHfCeCKfZJVn4CwbQoEdlazx+hbrGjX5N6dJD7a0N?=
 =?us-ascii?Q?VfPCtYz5+xqoAGypeUBsvmA/VGJb53iymZzmnNKZP4sqTbXPxaxdoFvSeUUk?=
 =?us-ascii?Q?ye01qjcvh0Zh9Qgjk3TnlofNMQmwVfMd6fDI4gkwlVf4aklZFr91rKJBn+g6?=
 =?us-ascii?Q?bg1pJDL/RCJFr0x17jekFCyPZ/u3z077sPbpurkQ6EE0YtqDk5iMSruExqii?=
 =?us-ascii?Q?nVaL53ECIE72QAgycotqDvfPGI0N1U+mUc78k9Ak9jUjzcMnhjxXxntNaRnv?=
 =?us-ascii?Q?ILAFEpWx1GSA+fxhrso=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8981.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a9e55d-5840-484e-9310-08db6b0d5f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 06:22:18.2117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHqXfU7N9wEOYHIVtIusAaEMLBMmgLX2MWzaH31k0R3hZqx+3HpqliwOhOlJDiS6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Sunday, June 11, 2023 6:46 PM
> To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; =
Li,
> Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Only create err_count sysfs when hw_op i=
s
> supported
>
> Some IP blocks only support partial ras feature and don't have ras counte=
r and/or
> ras error status register at all.
> Driver should not create err_count sysfs node for those IP blocks.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 31 ++++++++++++++-----------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index a6c3265cdbc4..dd7cdc234d7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2757,23 +2757,28 @@ int amdgpu_ras_block_late_init(struct
> amdgpu_device *adev,
>                       goto cleanup;
>       }
>
> -     r =3D amdgpu_ras_sysfs_create(adev, ras_block);
> -     if (r)
> -             goto interrupt;
> +     if (ras_obj->hw_ops &&
> +         (ras_obj->hw_ops->query_ras_error_count ||
> +          ras_obj->hw_ops->query_ras_error_status)) {

[Tao] the condition can be also changed like this:

               if (!(ras_obj->hw_ops &&
            (ras_obj->hw_ops->query_ras_error_count ||
             ras_obj->hw_ops->query_ras_error_status)))
                    return 0;

Either way is fine with me.


> +             r =3D amdgpu_ras_sysfs_create(adev, ras_block);
> +             if (r)
> +                     goto interrupt;
>
> -     /* Those are the cached values at init.
> -      */
> -     query_info =3D kzalloc(sizeof(struct ras_query_if), GFP_KERNEL);
> -     if (!query_info)
> -             return -ENOMEM;
> -     memcpy(&query_info->head, ras_block, sizeof(struct ras_common_if));
> +             /* Those are the cached values at init.
> +              */
> +             query_info =3D kzalloc(sizeof(struct ras_query_if), GFP_KER=
NEL);
> +             if (!query_info)
> +                     return -ENOMEM;
> +             memcpy(&query_info->head, ras_block, sizeof(struct
> ras_common_if));
>
> -     if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count,
> query_info) =3D=3D 0) {
> -             atomic_set(&con->ras_ce_count, ce_count);
> -             atomic_set(&con->ras_ue_count, ue_count);
> +             if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count=
,
> query_info) =3D=3D 0) {
> +                     atomic_set(&con->ras_ce_count, ce_count);
> +                     atomic_set(&con->ras_ue_count, ue_count);
> +             }
> +
> +             kfree(query_info);
>       }
>
> -     kfree(query_info);
>       return 0;
>
>  interrupt:
> --
> 2.17.1

