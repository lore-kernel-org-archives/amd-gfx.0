Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6658C54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 21:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164D610F336;
	Tue, 26 Mar 2024 21:14:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hM3YqGHk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE2F10F336
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 21:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGh9Teu2yoOEeFlWUElQBJVeg6DcZpe4EtD1j0EAJUtOnd6Bka9CMlHnkt3jKO7c+hmzQS01vXB5Fq8obhv/J5IZY8r+MB6AHtmLkKcPp7W9EwIuWEeQL/fGtMRgJhm2iF31GjM9KWgqpbH39CqN01W2+ILWC7nGeZEEh76oad6/1vRAaRh62C70SnPP0610dOYoQtCiq2bfgg0xUm+gGgmRGnBs2cDoLIPDJqRpdcZs+z6xMezYdw67HQYWZbHZhV6U/HYRZ91Ijyocd7C3vagN39cNx1ii89QX0GdB8eQcwbmF667hIMh7rObRkV3HIioUVDvorgbM7MVIlP3XcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpFbP7CRdx5c2SEpMtbqWUKskltjO0WpYFw6lxN+dpo=;
 b=BTGXSmtShlogEdLe3zpm3+3bZxV/GyFFnpiIXuvYLD8sN8M8A/GyRpZUkBConkDX72Yiq61gPO5k73JTCWvubGeAPcDsbA8k/uGx9aOPLjOXyzFaQsWiHek6PQSVJZUxLjwICHEXQs3YoqzeOJ+u34OgRT9B3v1PSglxJNSXcPQkLETU+JjgLz9WOmRoBoIve+Tq5i3iXN9kwbZiuVLNZDuycKrE1lj+NlPowuJCkMA/EQM+UmMbPGPJ+O6x59rglZprimLfwnqAMDOwqW23GYqRYr04WraCPwtof+KLHt7fDo1oy8aRjpbLhNutPJUGnyFeleE6Q5TSDzwVTzfveA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpFbP7CRdx5c2SEpMtbqWUKskltjO0WpYFw6lxN+dpo=;
 b=hM3YqGHkdhrZMl8VANTZTen4xqRThGaW6ktxC8hJxSOmCLSLcoCAQRrqgb8q16HzYlzYJQ38klWqmUapODHq7UyHTkfVP0Squ0qJ47ktsJQ5t0hnbA9awrunxCm+4pZ2wNxLqHc5isKqWZNKwA4mQQXlZY8isRyU+2tVb0luGQI=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 21:14:44 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26%6]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 21:14:44 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Reset GPU on queue preemption failure
Thread-Topic: [PATCH] drm/amdkfd: Reset GPU on queue preemption failure
Thread-Index: AQHaf7iMuxkIVc/BCEe4Zb9oLN+ph7FKhaSA
Date: Tue, 26 Mar 2024 21:14:44 +0000
Message-ID: <BL3PR12MB6425C5F0A8570FB76A65F7CDEE352@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240326200206.100727-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20240326200206.100727-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=28d1bc89-4473-4fb8-997a-3adf2a0b6470;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-26T21:14:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|CYXPR12MB9277:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: enqyH9AHQCEHUo87H4qDLRwOVxsJsTBf1qz6p3ddEEZ8ux5dna58nuFtVjj/3WtfBh0YUMiUFQotTvHvbneJDBou9Dwf5UqCCZFNUZcZK5tVahe/3+9PC+3rl9OKpY4M5lG/XiWkZFjhRFCRVghS5mXuwZtE6hcgWlCJZbiANmjyIVSWzFGtnatFAwrU6NoxWF7ecH+mWcMZ60vUmb5b5uzxzR08DMKiAQGH073VJtN3cEEGrLMP9YWrMR6K8KrSKkwgNS2NznVXDdPq0eXpKnzexcW09rHTRNWOymYh1t9a2+BdXElwZjF0YD7YhcDMKt34zZ7xZvlT0o6yIWmt6aLsSPcqwONwwx8klclMY+QFBMFCxSFsSJ4CWndhZYKZMRLv1Ss98pILRy7E6KR52wVrvXrNzg9m3S7UigXmwVINUUooA5nDXO6Dg5s0BFD6D7XfWDQtAONzII9/Erpv5NXsgeymyjPKiLpeCJWGPCmD5Ecu2pCqC4OMVcm0q/gRIwIYIeJtgyYrZRmr4ufFEnqigOw/BS/frEiQmT2f5oBsqXCIPGI91sAwHPc6GxouQzhZlhgRYN0cIWdP19Z3ppH9Nwq+WOpx8d7e70gbddNBcR4FwJIuBTD2apbwd7YWQDGpw8AfED+YbhTzLz4ZiNxvnOoXXICv8ihC59rKtzM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/JRDTCGpBEczncAgWJIsdwNG+lEh8zEtfEJNVAjvT4ed1blXB41iOBk4WKcv?=
 =?us-ascii?Q?E3UcFyYcY4YxjQVBBPQd0QMI8J5U5UaTa917FULuUSW9gmSbutrYXkA5A+Bb?=
 =?us-ascii?Q?OC6dTt2WsyjeB2UCvCKLBAcbfdBkOE2eWADJz37tDfUMVEX3HX71S711WCU0?=
 =?us-ascii?Q?N0Iqw04315T5ibDeMT9/ANCX9hOIz3pPzxLXVgYK2Hm9H/cNtFcjAK5N5CIL?=
 =?us-ascii?Q?GzFoiYcajl+iO5ASaKQyRuIx1DMhJ8T/Jhncz8RovB9K7QKldOoz4Hm4L3O6?=
 =?us-ascii?Q?EKRTk7p5bL3amJA3VCCHcHd/hsDVf/e2Xj3Xd3VcjbfRILk6xV+1jrBDjdze?=
 =?us-ascii?Q?C0W7viKr2O4ie8XXeQlGQ41vrovLr16AKx8RLxhYV4HoXpSzihasfYKt5fyb?=
 =?us-ascii?Q?PTHVkgSQ3RDIknVhEGNMag1X+b7023Br81gNwYpBqeD43nTq6oTDOwylMB51?=
 =?us-ascii?Q?HtL9NrudaTe5I+MZASPM5qrmnaQLE7BRmG10jzHt3L9PhoUPqApdkh5AlBM+?=
 =?us-ascii?Q?43aL/Tks18K4QyL3cOgTKZ+mkdvdaeQV9WI0NmRFyUiiTrb1KaZTfJrWhPSo?=
 =?us-ascii?Q?pJRG/9OGRfjwhMIx/ESUeyN8bFYBnvIteevazmm/hHzc+FcerFWVjkELGFnK?=
 =?us-ascii?Q?F80mJ5jinqakgYX+upCA/IOYtxqoAr9LiLq0qcGXTFA5c8/AGbTXb0SigRkX?=
 =?us-ascii?Q?5CqqmOQTsyc1N4HhhgRt83X7SXHOFPgPdVusd9kZmctr/J83v0Vix4du+bQp?=
 =?us-ascii?Q?erZ67VUopc5im6gFhpc54mM7idXgqFrLrDd1yjMQ58hUo30t+i9NwljPcS1F?=
 =?us-ascii?Q?1gC7qMUijwhKj5Y/qrkI0M1BF767RhGqF5x7t8t3PZpQha8vpGtaQm/miE7G?=
 =?us-ascii?Q?xCJ/uE89AIYvATa6Burb3m8U77FQA8f2KAt5aoF2mNf6iLtb0RiJhe0pzYiU?=
 =?us-ascii?Q?v645FRdEpKaWIQn/TYd7YbSh+wtVZLPvEgofvYYE5cnOXkmKnT65f7Uj2uji?=
 =?us-ascii?Q?KFo0/ocHYPxhr4Bn3YaM/5fTdQPed9fOnpF9t87MLj6G2zqspcnvw8pRIglg?=
 =?us-ascii?Q?X1zeglxtNW0LqwDTpGv9uG6C8FHBgD+IoRv6awXk34w63hdTL001i5/otkAA?=
 =?us-ascii?Q?T9RHNOLAKwl5MEUYgwc6OsKDnwo5hncwGP+ysvcBzZRFTifllEXEC9KKWxcF?=
 =?us-ascii?Q?RzmUX15yeOtRVxkBZk5B87KDV9IOcvFFsj6kTaXoowt9QxnM1rHj186UvRry?=
 =?us-ascii?Q?3C705s5jmTRBRy59XBRv9d8mYVx8MCotzLN3HXIiqimxFp0rbwIcl+TdY1+1?=
 =?us-ascii?Q?4gs4ZDE3330/mPwAUt6YRoYnaG5xNqiRkmg/eRIJpSk4JOnpliK9YTHIq6RA?=
 =?us-ascii?Q?xygqmdPctiDsLuM5zf/BN9wRD3ZLlwNTle9/i3i4rtygsKPt7S6E5QUqstma?=
 =?us-ascii?Q?ueyi5WlGGL0yxLp1Pqj3TWltVTLRs+YzfvieO8rdYexXiO/7YNH0CEA2YkD4?=
 =?us-ascii?Q?sArt6oQ+YD9zLy+fnahMjHW2OElzehFwgEIPWHCSF4UwS9OPYTUp4RacjddR?=
 =?us-ascii?Q?+MxBC9Vw2yfXyzYslzk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c20a764-7a60-4cae-18c1-08dc4dd9c282
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 21:14:44.6071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7AUeZLJParj/88Owj6FtpnURD70NK3Pog3km7gznhUSDqI4BhHZLPXI4nvmCGlIWQZ81baSFvwYguhl/CBcVmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish
> Kasiviswanathan
> Sent: Tuesday, March 26, 2024 4:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH] drm/amdkfd: Reset GPU on queue preemption failure
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> Currently, with F32 HWS GPU reset is only when unmap queue fails.
>
> However, if compute queue doesn't repond to preemption request in time
> unmap will return without any error. In this case, only preemption error =
is
> logged and Reset is not triggered. Call GPU reset in this case also.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 151fabf84040..c08b6ee25289 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2000,6 +2000,7 @@ static int unmap_queues_cpsch(struct
> device_queue_manager *dqm,
>         if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm-
> >packet_mgr.priv_queue->queue->mqd)) {
>                 while (halt_if_hws_hang)
>                         schedule();
> +               kfd_hws_hang(dqm);
>                 return -ETIME;
>         }
>
> --
> 2.34.1

