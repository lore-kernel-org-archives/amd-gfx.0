Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCC7C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 14:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F17710E4F6;
	Wed,  7 Jun 2023 14:45:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0AA10E4F6
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 14:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5SZOQ9SSvzKJxRiRhUO82qSho9TV/0zxPgg66OjoQmhpyGchTLRzfr/c7WGxg/BPw9x4LnHDxgkfGzqEFARdu2qjqFPyAmKYp7mCioQZXzjUpZNSqPbqT/bQrvxT+cXJsNHP20tgzMBtjkzb4pvcG+hK9AHTLCqH2xzFkvNg0tASeMJfJ3mVLEvO2Keqx2upVnPr9SslF2YiQrXXu/4KheNald3mP0qK2x54jkUXTixEeuLlxZnMCxxIek8At5TWAYyTq+SlRgKKTzC7jUAoorn3/z8xVKisZ/AxcK/Yaq3BsnwMLxoaHf8ibR8vZaMvFFsLzqmiW68BPLZfumcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHVovoRUJJA65NFtVKxmOTbg8FtLqSiVlVk3XrPnKcM=;
 b=L5OmFpgPuA0khnrOjhkj1Kk3BgULq89q9mfOM4gBjEyiT+WBYGNeOjWqtKJBo8g2k5MT7KeLnt2KrGtUEy2fssrKLsXZacbWKYq4tWrCjplo0CXUABCPzCDXUuBHI5x8EHVHnx+xNYA1mho5WB2p1Lqc5V7KUZs6WfaQOqrktYYc/tdPY9RMKkJzd6rR8kIau+JiABeS8Mulw8RTI48bFTDUyNvnJIluy92wO7mrsQitWmD6R6zW6coqcekabi9itP+miaCPHEQE4FI6ZjB/R5jLZLlCWo57J7L8sCf3KcRDgGp9nKpPiDtsC3jHbrFuc3jvly+16c/g6uBi6Y4OBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHVovoRUJJA65NFtVKxmOTbg8FtLqSiVlVk3XrPnKcM=;
 b=piKjt0ps4pZH85R9jiBC37g/rsRjpZ0P9pCNdJrHTwl539QA3oM9lOctyOGIHKyBneLtV4JFYvepn4pYvfRziMUMjHOlfZ5ff4XssFGfZq85+RStB0hGd4JT6MhF77AaWA29GOdVy5JkMAjpGmrW3NFBK0t6YYTvDIyoTUFJVg8=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 14:45:34 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::f135:615c:ba53:17f4]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::f135:615c:ba53:17f4%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 14:45:34 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix vmfault signalling with additional data.
Thread-Topic: [PATCH] drm/amdkfd: fix vmfault signalling with additional data.
Thread-Index: AQHZmU3RtmcCHiDm8USmHGGI6Esq5K9/ar2A
Date: Wed, 7 Jun 2023 14:45:34 +0000
Message-ID: <BL3PR12MB642524F28203ADCE674C722EEE53A@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20230607143852.1672039-1-jonathan.kim@amd.com>
In-Reply-To: <20230607143852.1672039-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=680303fd-c064-4a6a-9891-4553efac8cdf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-07T14:45:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|CY5PR12MB6576:EE_
x-ms-office365-filtering-correlation-id: ccacc8f0-1965-4c50-1a7c-08db6765d97c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X6TrZrSnMt/s2zlFTx1PC2C7+27cKTsOA/EBbjXaiYEd1IFSbN0s8+2EVORKpLs9Tmp8mjgpUisGXe3Un+fsnHKUX0BUCX+6eY/MFbo1M/C7XTijANcfd1TH1Fc1qdbE+3Hc1uhMNvjlS9hHOHlbcRoBkyh4w2KPUiiaQjm4tQMAUl74IgVCHuOaNUB1/NfzyV4QwX+zTVN6ozfpSnkWdVkBeN7k8zA8VKY3VWUjy7qj4QaA9zsok5WvnnXvQbP0MJzvxPy1EvmiocuSx4ohepoMfkWMg+9MMTNgwbDBTlkw8/aXYdLjyWQ3GKr/E6qbUaf6OAXMO5PVxvn4lbHGss3XG/55uuRv3zyT8BFOpmSW5UWisPJKRVwe4R2m47NWRvtSOCpsmCzgbZ25xbx/teu18GSQJgZXgX89saUBqU2fjJoTs2Hi1UiW0n6i+8th5OHaH7LaW5PPQO2fULhVN3AiSeybkfFHiTMPE8nkZLFReGuOBUZkzJ4TwkQcSQOQAvSA3dOpapcoUXf0BeMd812quMLA2KKiTkuhyplON4vOP48eeKJN78OgFOGE78DGW7ge3oN5JZagbPMyTvxw9dAHYdmB9NMessSffuJcEnPYfyCPC6HLwpdKmF5/hD8B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(478600001)(5660300002)(52536014)(38070700005)(110136005)(8936002)(8676002)(71200400001)(316002)(4326008)(66476007)(122000001)(64756008)(76116006)(66446008)(66556008)(66946007)(41300700001)(38100700002)(2906002)(55016003)(33656002)(26005)(6506007)(9686003)(53546011)(86362001)(186003)(83380400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nun8oANUo6vrkOuTWc9q2r24BblhaXn+GmusXg70683qyhKMLI7yA9GgjGjN?=
 =?us-ascii?Q?bUNE2N2exp1cuujYh0rmHMyqV9U9s9V67XjfUHMAloVRkLoYM0aEcCzceEoZ?=
 =?us-ascii?Q?weJiguggU/mHqxS+W/n9PXe0Sh5LRopBoofUFo/IsJZWKTA2ZAsHgOTQdXCe?=
 =?us-ascii?Q?gh581MRWFa+5rBGdKhu/oxv8Joi3+fPHqXHK9YrcO3HyERGQYUAoavYFHxqW?=
 =?us-ascii?Q?OJVzbeRcjTnlzHvcgoDZ4h9hSb0Wh+Sv8dmXB5R9lBbe072Um6nLqMmsGL7V?=
 =?us-ascii?Q?B6UqQMTm2r92TXppQkHgSRtiob8QjW5zDYQdBjggRoo9T/OI6bhXjNSIxTxI?=
 =?us-ascii?Q?CTNbT5/sLt9VzCPIoWNi3KxMxHw0hY322YK/w1EZaS9NlrVc54Phh4ZLu9I9?=
 =?us-ascii?Q?2CkfteVKiBuxizFp3eGMmL4PFux0Pdf50/pAdiXmhExgqJ4KPSKzEh0ad6RY?=
 =?us-ascii?Q?yQyHnOYka9s1ZvBGjkE99nH0jzNfFIXtcDOOOtwQYBI5Qmlfn4o4r+ROY20g?=
 =?us-ascii?Q?9i/lFJtSREvAhevUOtpT5I7nVKoDLjadfW04UkcKkqEMN6u2NLCFEY1a+0L8?=
 =?us-ascii?Q?hWj4e9KimUlSlnYeai3QGpsRrjXVXqLjIsJiaxIF6P6oVa5sF7YGRufKti7b?=
 =?us-ascii?Q?+xy+4FtVqUSGiPeF0lXKpMbSkAxidhJ+h0VHa9NRVhVpiccek9mteFa64yZE?=
 =?us-ascii?Q?lkXT9eGHpyAn6ceY4N4BDNNfEAwjEac9pCmyK9g5hxRGGJahzuvvsiasaEl5?=
 =?us-ascii?Q?L93Baq7w+rUBQVBAsRi1qRpXC380+0DCG1211vUzv8WComN9E1QNfiQs8+8W?=
 =?us-ascii?Q?ez/HEDFPWiDQdPumlKpyqKXQIPN9+3msB9cEjot1oJNXWMPJO2o3j2UtJzJ0?=
 =?us-ascii?Q?RHyAt7JMrBRaB3D6rTlLboorM3g6hXEnhIgUtkIz8WLqUzUWeSuse4x94Vil?=
 =?us-ascii?Q?FiPETQd3lwcDfSM/BViSR1Y59s3M22sVSwwYw6Kylh4AFQnkaFjlTVKGRm3Z?=
 =?us-ascii?Q?c2Bqp5iQPGjuhQQUE/q9KFyRE87RixJF8ghtjU9WJY6B7PyAhCwElkYWxtcJ?=
 =?us-ascii?Q?+4aJkDBOA9kmc74pPInhfszNayslF334tLpqpsL4udPvK6ExlXkKEO40lz+g?=
 =?us-ascii?Q?A4nLNbSIRpsqMJUb4eQMF2+KhW0kIspps7PWwGmd3qm36KiaZCQJ6AITczN3?=
 =?us-ascii?Q?82rqxDfWSHPJohgJJmrirMcAyeQcapSh2ilQIlIZGxWgm79r9k59xRDnd3Z8?=
 =?us-ascii?Q?yDIBb+kWiE0yZI3ZtcpOaJ72ogmy5Hj9ee0UBgQm5nSN7MOH1HAIRJ6aQJOz?=
 =?us-ascii?Q?ff9lfi+q4otLBOVTKORQOF1MfelNpHxlPLW2ye1+zc3o56G2czJYr1Z3HC1D?=
 =?us-ascii?Q?d0k+BOWST8iNBbVFzG+0K41AHOi9CVkCcBvi5xU7BPxLA5h5bFGotyuICxxG?=
 =?us-ascii?Q?GAiCP9TkoDKtlwkBsbAzdqbzEL4n58Ss+afd589dmuxFBoAFri47Aop7f+b+?=
 =?us-ascii?Q?/WkdenTNjtBes4rsEEJC4eyAiXd6KjRuQNxl0WJOUXshEcnofnWWZMAMsE3u?=
 =?us-ascii?Q?n0gUhikrNvtXWoYOvXM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccacc8f0-1965-4c50-1a7c-08db6765d97c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 14:45:34.0710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKPeW0ElPqAjb5lJoW4u+ilu7z36Dfitqp7iHy+f2ioZKd6kJgLcY5CZ3Sz6oplWtRhi7e+5HjWhW78L2O9TGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Wednesday, June 7, 2023 10:39 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: [PATCH] drm/amdkfd: fix vmfault signalling with additional data.
>
> Exception handling for vmfaults should be raised with additional data.
>
> Reported-by: Mukul Joshi <mukul.joshi@amd.com>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 34 +++++++++++++++--------
> --
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 7ff5c4e1b7e2..c069ef77daa5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1240,19 +1240,24 @@ void kfd_signal_vm_fault_event(struct kfd_node
> *dev, u32 pasid,
>               return;
>       }
>
> -     memset(&memory_exception_data, 0,
> sizeof(memory_exception_data));
> -     memory_exception_data.gpu_id =3D user_gpu_id;
> -     memory_exception_data.failure.imprecise =3D true;
> -     /* Set failure reason */
> -     if (info) {
> -             memory_exception_data.va =3D (info->page_addr) <<
> PAGE_SHIFT;
> -             memory_exception_data.failure.NotPresent =3D
> -                     info->prot_valid ? 1 : 0;
> -             memory_exception_data.failure.NoExecute =3D
> -                     info->prot_exec ? 1 : 0;
> -             memory_exception_data.failure.ReadOnly =3D
> -                     info->prot_write ? 1 : 0;
> -             memory_exception_data.failure.imprecise =3D 0;
> +     /* SoC15 chips and onwards will pass in data from now on. */
> +     if (!data) {
> +             memset(&memory_exception_data, 0,
> sizeof(memory_exception_data));
> +             memory_exception_data.gpu_id =3D user_gpu_id;
> +             memory_exception_data.failure.imprecise =3D true;
> +
> +             /* Set failure reason */
> +             if (info) {
> +                     memory_exception_data.va =3D (info->page_addr) <<
> +                                                             PAGE_SHIFT;
> +                     memory_exception_data.failure.NotPresent =3D
> +                             info->prot_valid ? 1 : 0;
> +                     memory_exception_data.failure.NoExecute =3D
> +                             info->prot_exec ? 1 : 0;
> +                     memory_exception_data.failure.ReadOnly =3D
> +                             info->prot_write ? 1 : 0;
> +                     memory_exception_data.failure.imprecise =3D 0;
> +             }
>       }
>
>       rcu_read_lock();
> @@ -1261,7 +1266,8 @@ void kfd_signal_vm_fault_event(struct kfd_node
> *dev, u32 pasid,
>       idr_for_each_entry_continue(&p->event_idr, ev, id)
>               if (ev->type =3D=3D KFD_EVENT_TYPE_MEMORY) {
>                       spin_lock(&ev->lock);
> -                     ev->memory_exception_data =3D
> memory_exception_data;
> +                     ev->memory_exception_data =3D data ? *data :
> +
>       memory_exception_data;
>                       set_event(ev);
>                       spin_unlock(&ev->lock);
>               }
> --
> 2.25.1

