Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690F3CF34BA
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 16:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E5410E8AD;
	Thu,  3 Oct 2024 16:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vlZASwz2";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56CC10E8AD
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 16:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pryho6uCGSjLTkcCXed7Inn5Rpwqc5xVm12AmEyaX5nnatB3PNRRf4N2/hetjwaw7m02XoTkUgBvrHv2cBdkOpVbg2+MF0Kus+lNx6aowGsiEvQBYSNOJ25AZU1SxSMalLzXhh7eDHatuPTGAqKmByJg28Z1azPuksbKVhzuGKuud3xFLepFpw+SSc8HwGy5tWFw7xmtvsUlxS7yrZ4PFODqeXN735sI2dqzzyxCnO6+fRWZXTCpB5umVqC2TbFdYa3VE1JH0YDYrzJbyhWxPQ8yPjL8ploZc3NFfFXD1CmoZNQlXaFPiQxL6+VnlK4rY69gFoicbsIFOGY/HrSirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7PtdctgPLZtks6qKdkIWVdPZDqoYE76pMCkuws2KC8=;
 b=tQuUXQ5LPPbzqRtpwe+6DhTwf0EqhKEeQjwO4w36XK40hXNxY8MtVJUJt3v1P0LbvncxHrWVNTp+fARWCH/27LPbR17328ySmBpRcN48wMp4+h1vFzhnLxd0JuMG5K4wb6/d5wblcRfwRD6IDx/nh9Zmh+u7n32aRa+N/cCCZxk0JdWCDEp5glB//JwtEaaMmyargML35HiVWlJHAjqJ3q5oLpY9cG0LV0U4hHFCxrpOTWV+ybnk0YdFFZjxRRxsbyyojFxTurkd8mvTygALKwUOEvT/+6dkEZyMAhhdfZ6VuGb2eFqdIrRHUIj1alSLGh7hIPZ9WnG6NEKIEFMylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7PtdctgPLZtks6qKdkIWVdPZDqoYE76pMCkuws2KC8=;
 b=vlZASwz2tl8W7DXtUthMcqxhqT/r0yxkBE01C3nuSCrQueSivtGolb4+hlEEVzbd5YOFBdouS5SvPXBgutSCjCfShRvI8m3Nc6v/Nan18wU/E6cSzboAqUtf8H/65nRG1zowGWlGe1Qx6m+fJ/T1+AOhEw+8FAGl29ZDDlsQEbY=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 16:32:30 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.8005.026; Thu, 3 Oct 2024
 16:32:29 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Copy wave state only for compute queue
Thread-Topic: [PATCH] drm/amdkfd: Copy wave state only for compute queue
Thread-Index: AQHbFbFwZbEGg9iPvk6NBRFiDUh3x7J1OCAA
Date: Thu, 3 Oct 2024 16:32:29 +0000
Message-ID: <CY8PR12MB7435590191B53F10A2F225BB85712@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20241003162918.26745-1-Philip.Yang@amd.com>
In-Reply-To: <20241003162918.26745-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a9b5ee14-f8dc-453f-9e5c-54c9993e7b1e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-03T16:32:19Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|CY8PR12MB8268:EE_
x-ms-office365-filtering-correlation-id: 5620860d-5d95-4a5a-2a90-08dce3c8f984
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+P8jtQNNY5Ll24ScqGZVAZtZgOVUJZ6haAX0tnQoJwCpfUW5FY6jv85LplAQ?=
 =?us-ascii?Q?Vu3sRGhrp0+3baZckSNoyHK5VTN9IsnePrqdnGGXmr+wjVkogxJw5e5d2Bl8?=
 =?us-ascii?Q?rJQnnwQHguLCrJal89yCwGqmDahmUUk2Lehc/pmFo812RBjdzHJw0p3mZM8n?=
 =?us-ascii?Q?l7jwA+NGOBWE4UgPAG383mRZdnQb80/hfnjKwPoj4vScfV8c9skILSgTriIt?=
 =?us-ascii?Q?hBAgkxKG6BlDgBgeQFtQ/5KH8sK63og5LE0JXzTmDkhQ8dVsiPMp1Bto5S21?=
 =?us-ascii?Q?3OQlmaLjzaBgvfoum+/cgsQccKS+MDgiUNaktwH0OC38AhpHIjGRpsRlrWGn?=
 =?us-ascii?Q?KX/DXekRHMBPAlQtfIhMZ0aZM15bGD8p1Mxf0Lk9WxoyjQm5Xlnimvcp+2xJ?=
 =?us-ascii?Q?O7eDPOqoXETdAHkU3kx2ZnoRnsZwLtGrE5AXZHas490GxHVAekdneYH/MfvV?=
 =?us-ascii?Q?GodAkR0jSy5Y3rT8+QYN/miQAQqS7ptzJ/T/RtUdagsQ7ExwU9flEBS6IWdP?=
 =?us-ascii?Q?LehOKB7D3NArCdIoDF0yg+QI4NsqqvYBHgelIyLQQTDJKhOKJ1f2b8TdkAZJ?=
 =?us-ascii?Q?QdhPcrRsdB3kSAaNF7uhn0U/xLoPHm7x3yOp6+w8q8fhGZD9pWq/cj+DNAEE?=
 =?us-ascii?Q?am16cctWUos6aHj7ONmf0l8C++8OKoioJAWY2BuIE9NM7gpnCJHO3uq35Aaw?=
 =?us-ascii?Q?SkbO4/sbOXdgX1PQ4YkwjhjTp8lamcwJWls8jxsh+c+wMkWoMdAZwViZvss/?=
 =?us-ascii?Q?+aKDxFTE8mJ1WxKdjx+/zf2G10XeZYKxHcVtgotFExhDTsf1/j5wv6nYBKd4?=
 =?us-ascii?Q?pVOd8BvoClNDUywMQk5HotgGi+iLZIIylibdlcpj8eeSmAHL6ZG7aLZQbupf?=
 =?us-ascii?Q?y0xBh7rre4woWgxMi6zJh586ruBz8n34MbmuugSdnMPddNiDOiKAKOK/BB3c?=
 =?us-ascii?Q?Q89+a3Fjoey+51gCfHWQSOhVZ2bXx5NuakXyjEkdphVxcRW8pDaTWm66PTUU?=
 =?us-ascii?Q?VPxF85M5SD4EVPR6n19VuW7Zg4zTsLOPgg1J7b9mGnaZ0F7+NNGuIOEso0N0?=
 =?us-ascii?Q?3o0ZliLtDI9kKilVYxsvODxuNegN/zItuha47S/D4Yhiaf6kcw0p5Npah70O?=
 =?us-ascii?Q?GHgQmkdMGNMfByS2HaYqiyuG8H4kCGOlP273KqnKCrJppt6VzPDp4ohfTff1?=
 =?us-ascii?Q?/kZULLJqfqXZzyEf0nTZBp3p8bjS4WKJx/Yq83XmqcIm4ZHkv3gQeq7SfW5E?=
 =?us-ascii?Q?3aY3erv1YFS+Ku2EFJzKSjWMWE8aTFt06RCm30i1zS0bvwM74RhG6PiHRgcf?=
 =?us-ascii?Q?NrHVbRoOQ67ewR+lPj0dTaEkJMvlvKtuJQyNBlVyJP31yw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Md4Ohh516/dtU/E+HT+pF61CT0breAkWVhRLlRMCYDcQp6bQcZgF0ygZlFQC?=
 =?us-ascii?Q?b592uamojA67NitxCUUNrux11JErLsF+fztIEjRhrj7NKnm+C2xEQz5UBw3Q?=
 =?us-ascii?Q?TbesYWFXRM6JfLuKSyHj9HeOZ4DGNd8QY+eynNx2GB/YCBRsY9fbzCj5lTdT?=
 =?us-ascii?Q?TS6ieI+1cle7sYEq1p+XUKaS12znDe8l8bAWlpEOK9gp3RtkKXQY71H22dC+?=
 =?us-ascii?Q?j17PCIwamQqZoPonARcHxe4u0h7ErGFDdVOsdoBv0Kd7xUd73w2h5CmNVecx?=
 =?us-ascii?Q?Jxgc4U0MR63+5N283nPhZOA6FslWW6Ss9HYGTEBOtvgqGMNKisrw5t8sQ7Mz?=
 =?us-ascii?Q?KGtvZw9B45MvZZnhe2yN2tbvlddx4FQnlsMfQeuasKKXv+YpyycnZLSP923R?=
 =?us-ascii?Q?iiMsgRaGXPuqjjA13NRIRGG1SKEmRLlJf/sM3bymmdR7XndpE7fXrRUJ0pMT?=
 =?us-ascii?Q?NAAe5SwM8bPj+b6IZhi+pLaCy7QKcp9PTgPGMEBjj6UE3F6nEkAHbIgkvl9N?=
 =?us-ascii?Q?MKCrLDgFfZ3Bdrq3OiOcsZjyeeAgw8PTiL7afD0id5ELNuBmVg5sVZV2Zd6Y?=
 =?us-ascii?Q?PV2lgfPn2m4ZBEAm+znw/hCm3vp8GknODw9ybxGcJR+AuqpXnHpKDRik2HgR?=
 =?us-ascii?Q?OOFGqHax6oTQ9lnglOv3LRp6D2Q6SnFAiaFDEu7zicB2x+aHkzkPlwCJbGHJ?=
 =?us-ascii?Q?3f64bt1kf7eqN+tpaFnEZvZXCiId5Y94bXJ3omk27JWoROPnluELeEk2dUie?=
 =?us-ascii?Q?RLeCh3dfCj8hBxPeqplR5zA7iLqp1rxpzeEfdm+0Z00Cs7sv5BxnZ0/lypDa?=
 =?us-ascii?Q?NbGPKAbWoiM0RDn3BibIDF9dcNqCzrhLJ6T29RHF05glBhgL9jOgEDB8tlgS?=
 =?us-ascii?Q?X8yi8e6IVqXZcGdjqAyqJhfeV95BzGT0cLYYbT+J9idOAiivtF/1gty18cgl?=
 =?us-ascii?Q?Nyh3rkvJaRBLxDkuKFhSCmDC7gI/M0dZzkyoHxko7oT9CQQAFKz+UHmDKcnd?=
 =?us-ascii?Q?ti1UPIqUzfHeW8xgy2G5xQ/p6rwHzZnDqN2N+wNC8IXt2jWZa9NCR4+tLXpC?=
 =?us-ascii?Q?sDrdfM2vKynL024xTAxjo7j7vWmJKsGQpTvDQZrjKo/GKez/o4/IHRJFQb2t?=
 =?us-ascii?Q?dWK3ck/ZgV/QaUDR7N9r81UUqX1dt4FKJAHQv4ioL8PAsU1dEYK3DFLdj3lo?=
 =?us-ascii?Q?lMi97eL3fHa6g3sWiSnILuOh9nDjMlsnlUA8zcIU7TrVNf4NcJqPD1JxUZxw?=
 =?us-ascii?Q?fCxbDso0B7Dnx5QZAJZh8BTYlYdfVVfKoHijzKoFMoub34p9sis3e6eByXrP?=
 =?us-ascii?Q?gbeVKPpeadh9ojjwSkQPkR434RxLD3dx7o7IiYDbq4acKAAgcGfip0TCJqw1?=
 =?us-ascii?Q?1I4gJL/BsSCNntYn38oRbtOYPodsm7HtrIT/Knttwo1DXMDKwi7b/u6khFlB?=
 =?us-ascii?Q?AG+vKa/qzNvFsIjKU8sX4Kz6Fqc7JWZZ9YAf1QVzProJkenVOBHkhOjJ1Tg8?=
 =?us-ascii?Q?jLVevjDcQr4bPUOBsP9TZTmEdb9yh455dEw2TMhuG1OVoinoql4cPOKFogJG?=
 =?us-ascii?Q?W17udaNY23yOZLqDm7U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5620860d-5d95-4a5a-2a90-08dce3c8f984
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 16:32:29.8601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRbKyNE4fm6DnY8MJnnmbcsN3CX5t1xBUm9fIVyWaEBsJmMBkWJ1PU5IbKJQZW43
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
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
> From: Yang, Philip <Philip.Yang@amd.com>
> Sent: Thursday, October 3, 2024 12:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Yang, Philip <Philip.Yang@amd.com>
> Subject: [PATCH] drm/amdkfd: Copy wave state only for compute queue
>
> get_wave_state is not defined for sdma queue, copy_context_work_handler
> calls it for sdma queue will crash.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-and-tested-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 648f40091aa3..b2b16a812e73 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3173,7 +3173,7 @@ struct copy_context_work_handler_workarea {
>       struct kfd_process *p;
>  };
>
> -static void copy_context_work_handler (struct work_struct *work)
> +static void copy_context_work_handler(struct work_struct *work)
>  {
>       struct copy_context_work_handler_workarea *workarea;
>       struct mqd_manager *mqd_mgr;
> @@ -3200,6 +3200,9 @@ static void copy_context_work_handler (struct
> work_struct *work)
>               struct qcm_process_device *qpd =3D &pdd->qpd;
>
>               list_for_each_entry(q, &qpd->queues_list, list) {
> +                     if (q->properties.type !=3D KFD_QUEUE_TYPE_COMPUTE)
> +                             continue;
> +
>                       mqd_mgr =3D dqm->mqd_mgrs[KFD_MQD_TYPE_CP];
>
>                       /* We ignore the return value from get_wave_state
> --
> 2.43.2

