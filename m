Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3347CC52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 07:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B76BB10E3B9;
	Wed, 21 Aug 2024 07:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M+DgpUt0";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A2910E3B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 07:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQE1RkQCkj1C52ljH4+CQGVkNlIUJ7zUwuNzANggL2puolUqL4dRKUT35FhrBOyGQCov2c+rl0oBuo5+0bhb0jC41lQHNHXPjSw2nMUaE+c8M+2z3JUUJHmLRFBr29B2YTzyYBdXhB0N5woGOUZMTI/TubS6slAkdVM6WBRZENEM9PmJzMmmP6ANkZX5oBulkuv8rkUgXaCrBhpuv0Y1DjgynMB0iDy5rmJwejeNBEPWVrVGKRkaTiRQIVEjuJBw7SIJQ796gMqgJhvoVixdMBWwmxWgZ8UvfmG6zcDxdZZu4FZ8eheW7uv67P/v//5l6KJjLNeebYItqPBuZcCcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTqjVbsI5E/IWGCkRC8f1yknPHNkP+LlL1BIpv9ncaI=;
 b=G6X8EOYNlDuvW7zUnCH//NHPuSjkNkD1Do4vmOz7k9lzScE41mZWUSmAoudRn0opzHlCpG+2bgMWQrxhJmpQoKmQPYf9oaCqwO+IsDzKiBCXmrp9PhXebvpyAxwZexQ4oskAox/bHFAcqaC0wgsfs1TWus3s+aL0ukU6ocFb6DkjUDzOU+A/IMaEWT0q6A9TCMjO3vVygCNSSkLmuaPYKwXCBHekrc6e7CmeePRY/0RDDL81WMA8Tmv+frOdHpdSLUJQ34wODymrGR7Ft0wQdXB9qSwKDneVTKnAmg2VXfLlbQL6LfGjTSYiqwrtE59sfe5exI5mJ5Wv5OkeM5Jhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTqjVbsI5E/IWGCkRC8f1yknPHNkP+LlL1BIpv9ncaI=;
 b=M+DgpUt0nRD8rDYpkZ3UfbBRmgGtXquzNVnM1nZjVe/HQRuNJw8tkuDeZ/iAszS1XNvNqMnor+w2b+rW+A5ytX/BWPzD/6uPbNKbOxeLZmGgF3bJnJcZQeFI7FfAKWVDBlYgwtD9OclIMecaj8C+J7Tv50JFFeX9qbA94pq4hWY=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 21 Aug
 2024 07:29:01 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:29:01 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add list empty check to avoid null pointer
 issue
Thread-Topic: [PATCH] drm/amdgpu: add list empty check to avoid null pointer
 issue
Thread-Index: AQHa85domselnY/9xUqpgwJZ05ARUrIxUF3g
Date: Wed, 21 Aug 2024 07:29:00 +0000
Message-ID: <PH7PR12MB8796B4DBA01BD06A2BA7FE99B08E2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240821065722.353171-1-kevinyang.wang@amd.com>
In-Reply-To: <20240821065722.353171-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=290f5897-2022-4762-b2a0-190f3a53e454;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-21T07:28:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH0PR12MB8049:EE_
x-ms-office365-filtering-correlation-id: 0a7302f4-7702-4e8b-1516-08dcc1b2ed55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PE174huYZ50XeerO+WChxPr0kfvHyJ5GJHziETxDhWBooUl+d3tulECMZNiQ?=
 =?us-ascii?Q?K1ZKGNFfu/nen1AqW8ftM/Q1W2Baal288ql0soCFAtMloetjYBaXI1B97oj+?=
 =?us-ascii?Q?fd3+L7FHev4nEfivclQoh9dW7OIdXmlYzCYonZgl/aPKcy1O6S6KlWpS3U+b?=
 =?us-ascii?Q?tcnW4hFf81eLz+IAvBHtE1SHuU8DBvOfOaFrxHgoDQ96GOj1rY8oSvZSPcHV?=
 =?us-ascii?Q?bc8+fa4muL8AGJ/PbUi0Wgahc8/el7jYnbMzCvC6Z6rTstoLyyVKNcZtBP0h?=
 =?us-ascii?Q?s/VWEiM0NLzcHD/7XGkh9/gPXnmX/42eAKdhlQG2+aBmR484B19/ISaoTfpE?=
 =?us-ascii?Q?dpwrf9yseY0C1BUi0leYEv/aWl05C3Bw25rsKaD1FoS5HdT91aP4PKCzdJ3i?=
 =?us-ascii?Q?z6jQ1CgbZDIenKPRXZ7Tym97yZthB7k1zpAjnaKPFQ4CtukBCnQk69IE9tsa?=
 =?us-ascii?Q?FL2KtBqnfPOnDMKN7ZLzDDhQdqf15Lubzf8B1pG/OBdANEvfgmEjGEqaX45G?=
 =?us-ascii?Q?J3+ocRWKCalRe+R7yR9mWScM5/jVKkN9PJU5a1ruf9btG6yV2X+lcBv7lSml?=
 =?us-ascii?Q?8DNe4env7ceBDnaQKFtChd3c5JSB6foWrUSuQbpAJ8MdY5x4L6cwxYv2Q0jy?=
 =?us-ascii?Q?8Rnm22SwePggXJAgnGwYVYhU1bZJjPHKCt0XUb920DLwtBF3eyMLGUEr4q6o?=
 =?us-ascii?Q?NuKtPeBTW1A8yoj1PUSfr6AlrBF3dCruQtpvkpPbKoGpQYOjveloUKBo8HCo?=
 =?us-ascii?Q?wcRTOTnVZJ+XNQpadKJZc2nigYg5WAG8S7kOedgfI80mUpBKWnjYIs41PxPq?=
 =?us-ascii?Q?zNhnwqdPK9oC+UbAV0YNn37q3PY0QwyrOWiJcMdg0C8yUm9KdFZwopfNXDLi?=
 =?us-ascii?Q?enxXtG0Wa20vfXSgdlIZnM/Wm1Uo8EcSZYeZlJ2EFG6AweawtQn8od87o6li?=
 =?us-ascii?Q?SH22tHQ5oKQAoqkbvlvI6mlJTuQ99gXBHWLiQKVw6vFzpWZZs9K5N1LEVAnR?=
 =?us-ascii?Q?27tSSvEkFK4UV/kkGYo5upRDkFesdvMjnroSwQ6WkyB91B9NG3NHH6oILkjM?=
 =?us-ascii?Q?6+7mArcY+tWlP9pAJSo3HkqbX2lqUrQhA32sP2f3XSf3n1ss0/Ic7WFWDw65?=
 =?us-ascii?Q?m8JBEWoT2SdvUnqrzhnf9Opy+Zgkb1I+tQkehabXAjJrapmoDmqcaBhXBp+B?=
 =?us-ascii?Q?ajembblYb637uFBO+rDOmwwXsBvdMtG7d+eHzeYuZWRr8YMCX0XrBlabNB6j?=
 =?us-ascii?Q?u42nl6ysWr4+IbjGgVQawl+lStiDtj07lZhrmGfSFRV99W47uAb0qB8k0NL5?=
 =?us-ascii?Q?rsLoXOy6eI/lX6gv6ec6yTIMTMn60kO2tuReQy4O4W/YWeliu89pedbJFYmT?=
 =?us-ascii?Q?Q9tfMWegqN7yzW+bxxrlLbaqmng7SvEzwD1Tc/wRUT0kLJ/XwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WGBboHwuPsBaJcuawQ9iAwGh2ZpSvm0jN460K6LNMginEXy4uh5quQy7zVCM?=
 =?us-ascii?Q?JCD9l3TLIF8+PP+mZXMQVfp6U7TEJE3ZBcJT6gAnCmNlWwq85mTNkxirLRa+?=
 =?us-ascii?Q?KynsiceGDBBCv85rT1E0LhzWrNokf/GTwha76xHAw33E4RkG24XVcOQQpzTz?=
 =?us-ascii?Q?Z6FIVZUYRfxTUwwq9vjkxmvkbn4khpTurhtwSjuScB0yDnVJq6OUK6DEX02l?=
 =?us-ascii?Q?DDsxv1GnX4cXz0UdYWRVjdRK1/VGmcAh6N/h8dcFaWsjvjcdtv8dOCX5gDZA?=
 =?us-ascii?Q?MHL/w3oosywKzq8EcV3U1vBfYAnJkNDbpOMIYwy94KiBamDgQjv/AKtnH9ex?=
 =?us-ascii?Q?AZHzFD/k7RiId20OpiAmTxjJdj7VW1cjxjwTZSrpy5+221tA3mJdnSM2BKej?=
 =?us-ascii?Q?fTN9q/0j5gRT8cBLw29GXAtVUmC3VvVE0OhXfHOrQ3b/SrZp/DMr8Vx3H2n0?=
 =?us-ascii?Q?W2rgPZcu82QWG7ufdKL++L+dcV+vz2B+sZRuQHH9sL0lUKqlLBt1BwJmDaYy?=
 =?us-ascii?Q?5oLz1YbahmggU33UhHWGAsDX9CLopn9Ki/b4RBXJX9jROrCyZTtPGmmS9gjd?=
 =?us-ascii?Q?CIBLUjafs+/rh1xKSrbuRibKYsVwLh6bch5hKtOi/HEoq5/ODhXcOQEinWse?=
 =?us-ascii?Q?rpJlCUJ9O9rmrMLd8n8AT7al2G7W241q+z3ZmUlmI20ZK7kzGYw3q9Kr2UzC?=
 =?us-ascii?Q?K0k3JciU3tQOav+m/KCWrC57HtWgVdHhpZWyYrDKPSbbqs4C0f653xz0N8hp?=
 =?us-ascii?Q?qzckbfrbTduyY0ZbPjuMZxIbV/8ljXjml5uOFjtyo9WtyFQrpN1JJi38eso/?=
 =?us-ascii?Q?JUKw1HMuGTGbWGx60OhIPKYrZpFKmhN2//xquDQkjwf0U6JzlyzlA7bnz/di?=
 =?us-ascii?Q?cQr26U1h3xR5gqy/JP9T8A/luqZNPpTtdx1GEZpGFm9sf0U4KaaXWRRfZIBD?=
 =?us-ascii?Q?xvJgoFlLgYxI432nC8WEbkNEPWBFU8t+q1vOxGMbSUSDgkMNSB9wzpBD0V/v?=
 =?us-ascii?Q?IbZhfRLAsHlqgnjOgdaGe4KeiBTCK7Vb84CvtsjumUxVJIoSp/Lfi3FNjbCb?=
 =?us-ascii?Q?/epMcrJceWG/0DSZDipqzraGXSD+ezVt7V/eNmB5Rdfg1TD9FhzFm5zc80tA?=
 =?us-ascii?Q?BKjNDi8cj/Ep7f8cXcET5PUHYMBw8GSKW9r9U23aliUmx57b/xgzwkR7FvsL?=
 =?us-ascii?Q?gGLjzAIinyYbMi3M8K+1zYGyfPmBvAzWlewMEJEyf1gMgWXOtchELKd0pM8d?=
 =?us-ascii?Q?fpDAsUwWigKDx/0mz5kyOwYsK16YwEVil9xeeydUPVXzeeLuhPM1wwWF1eEb?=
 =?us-ascii?Q?QlgubUvZZUGzIHhxBmpHRyFT2nRXba7va/BvyBBR187AKWZYAfFmrZi4vXvL?=
 =?us-ascii?Q?tRznEiaMvTOMeI11NJ+pLyohoLARZDQ16WbGDz/8Zl4pBMGqU1QEfhN/e6Vr?=
 =?us-ascii?Q?EDqJvGBEiVHknUWLbLB3LWhcNjzdce4aC5tt+qGHBp3sY8tHZ2pergOKKW8o?=
 =?us-ascii?Q?ic++wDrbkApflCPGVwrjlJlaM5e0/44W+oFpS3ETLj16I5pLHzuHb+CWQNYl?=
 =?us-ascii?Q?1sluKfQgltUSI1oG2ps=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7302f4-7702-4e8b-1516-08dcc1b2ed55
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 07:29:00.9603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7G35E53wywXZPWMHpTf6C+ZUmHVCjatEVgzikuFgszpDQuwgPMQDY6A4PanmRrw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, August 21, 2024 2:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: add list empty check to avoid null pointer i=
ssue
>
> Add list empty check to avoid null pointer issues in some corner cases.
> - list_for_each_entry_safe()
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> index 929095a2e088..57bda66e85ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -80,6 +80,9 @@ static void aca_banks_release(struct aca_banks *banks) =
 {
>       struct aca_bank_node *node, *tmp;
>
> +     if (list_empty(&banks->list))
> +             return;
> +
>       list_for_each_entry_safe(node, tmp, &banks->list, node) {
>               list_del(&node->node);
>               kvfree(node);
> @@ -562,9 +565,13 @@ static void aca_error_fini(struct aca_error *aerr)
>       struct aca_bank_error *bank_error, *tmp;
>
>       mutex_lock(&aerr->lock);
> +     if (list_empty(&aerr->list))
> +             goto out_unlock;
> +
>       list_for_each_entry_safe(bank_error, tmp, &aerr->list, node)
>               aca_bank_error_remove(aerr, bank_error);
>
> +out_unlock:
>       mutex_destroy(&aerr->lock);
>  }
>
> @@ -680,6 +687,9 @@ static void aca_manager_fini(struct
> aca_handle_manager *mgr)  {
>       struct aca_handle *handle, *tmp;
>
> +     if (list_empty(&mgr->list))
> +             return;
> +
>       list_for_each_entry_safe(handle, tmp, &mgr->list, node)
>               amdgpu_aca_remove_handle(handle);
>  }
> --
> 2.34.1

