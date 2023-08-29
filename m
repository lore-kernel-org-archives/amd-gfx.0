Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA13C83F12
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 16:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07AE10E43D;
	Tue, 29 Aug 2023 16:24:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AE810E43D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 16:24:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ9UZBmgafh1Cj5BcLky3FO6wL9oIzVPVOORCSFoczvfRkOfFnhjZTF4/WfcesDhu0T8p9Ic7Odi4LxGfWeF88pKHX9GH5xcnleBVSeHYczqhEKIux1fLkelTQf9j4ZxqHd63Ev/thHswE3mCPyxRI6NpvUTwMhL9kB/c3iqlP5+8hQrTQLD9oqPBCj1m9U5ntjwLotZ4XzuAZtzpfPl97Motw+K3iKZWpdXVAfFI1mIH+CqQXCVrZT+mRixjXVjMG91NE2tpJh283GBSZywY0wrxua47oMi0PzzmJ1ntwruouoevSpZLU1bSNafXmeEQ1pXeq+HbmHkkqf++A8K9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NCfuL1OWdJYC9neySkAwjeaxyzaqdE0e9LdaUgdcf8=;
 b=QEirCtldbRUrcGWbHjn1SXlT2nm5Kxwpyqr/A9YbhflDqTuErX/YgvFAyx1rvZUH9io59cG6oBjYmUoZljzkkKdLnt0FVczL+OlEvr+M5wsQEKNFuSaK/XZVBJJU5NbBDQPY0+HKJzrc3uIB2FvK3FUDDjThrBexx4VkHiPtZuspJ/xyHuHLl8qEyDc+3n0cVZ4FC78txKe7SMp0dhyEP2hG2ZukesT8+mX57k/s2n7zYnEYMJ+aHLX+hZbOJ+MVJ4ZShHi+FJcK6ETBqKSPCO7DRKE5/Dz7BZYHVBgX53jR1WgW/MEKmpEYZgpptdyjJBr58YOI2DCTJQOKozsFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NCfuL1OWdJYC9neySkAwjeaxyzaqdE0e9LdaUgdcf8=;
 b=KLy4wDFLpwVPOs/nH1UHFHeEGWk2UFMYroNPSJlDG3FPKT5mqmyBmV+t36ubzhbkLc12Z9tyZB/0MghgprEf5ANHtbdYrvtMe8ziy8IPlEfwE+M0RTkwHlWpjiXFHh622vo8To/RyEZWq8dhNB5hUQD2V+w5kPCBvoo8Zqw7Ans=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by BY5PR12MB4951.namprd12.prod.outlook.com (2603:10b6:a03:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 16:24:17 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989%4]) with mapi id 15.20.6699.026; Tue, 29 Aug 2023
 16:24:17 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix reg offset for setting CWSR grace period
Thread-Topic: [PATCH] drm/amdkfd: Fix reg offset for setting CWSR grace period
Thread-Index: AQHZ2ojXeXR+/OdrHUqjKLcIU7j1t7ABdSvQ
Date: Tue, 29 Aug 2023 16:24:17 +0000
Message-ID: <CY8PR12MB7435DFB18DD7B5652CFA1C3885E7A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230829145500.90708-1-mukul.joshi@amd.com>
In-Reply-To: <20230829145500.90708-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9de3838b-56d6-4ce4-bbda-1aa25b3e84c1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-29T16:23:27Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|BY5PR12MB4951:EE_
x-ms-office365-filtering-correlation-id: 55dd921c-2394-4657-c4a2-08dba8ac6420
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZrLlXjQandZ+xY8Lfe69wDBURKTo3EqzPfbPds1xe0JWcRQOEtru7LE/16Z4ZdrI0BAVSFZ6YU6PxAzOQajjrEuolDOoI4OSngKZcIWygVvBYAl/OOb6cjNNSCd5PU/EaFkwpIkAlsrwFTQV98PeNXSrFV/klQxzF+7ZNiyn4EmpxbJCvP6JHpCRZOG6Hvzuo7m9l8WjacLZFEstI/1+S0oVecZmxT3SUq496oPUHoWdEBEo08dyOG6fedYURn5XHFVN8pkEjUH+zxT47fYcPtUf9AhZRf4kDnK5NDIhZZv/dccxXiz8t5Bht9uQAClW1mgwmclEZ3JU2ltbF8CFX019rmDeoJt4bEsQ5FxXK5lF4Fd5/+iwpr8sPSYuKn8EG1+RDQV2/eSPgeMwUOFyPxm8kYc/gtn5z88L37l4iqzr1ajixXeDGv2tGCxwnJM7AG1m83LlJJEX1rha9gxvmpvNvePOaa7Z3ip6vz7nPfCa9MyE/DtpclA/ivAZ7W5ImZ6MQmgdD4e3TQPesk6v5BfD2jPEK9KnqoHsgtDr9fxa87t1CAJGlZYtPo7H7T45i/BWmpVQ2RE59hwFjyftx3BJZ35dMqRrpzfoeHxo8xMTeCO4xzd5YtJpbAFYXHTV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(122000001)(66946007)(110136005)(53546011)(76116006)(478600001)(7696005)(6506007)(71200400001)(66446008)(66476007)(64756008)(66556008)(38070700005)(316002)(38100700002)(41300700001)(9686003)(26005)(8676002)(5660300002)(83380400001)(2906002)(52536014)(86362001)(55016003)(33656002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KH/weDRIDgYgSDOB2Q3idSqPTFQRE+Tkq0d6f+7Cg9tcHZkkOynmtcY03+dV?=
 =?us-ascii?Q?x/v8yO6RBa+033mPHzKzmOtt1iHkedWkmrrQxKGpL060fjfCvHfTJZcfwsJ3?=
 =?us-ascii?Q?/qO/dFoCtDdBgSTXmwCNJtxJ4IStxzT+JPsu1Uoc4gNVesKjrbdNfH8VgwUU?=
 =?us-ascii?Q?Q7JQvT8FQ7702VhgWo3o2M4NDfUjuW7yO3phnjt2qQy0bTW69Q1w5gCzA9Mq?=
 =?us-ascii?Q?hsD3wvPkNmOE3UYUF5LQ7RSO53BcP48Xoak3SM4iJjvqrkgG9XLWf+2SfTkN?=
 =?us-ascii?Q?czQzMQU13KM+EAxTr+UEnaAQRqtXTNHUmG4jSXE3/esCjS0Ndlz1DIEl0F5B?=
 =?us-ascii?Q?HO6SQ2n8FX6YSGi41is/u9fNbvnvU85OIzBq6AOBj93mYnBQsXCnFfOoiV2Z?=
 =?us-ascii?Q?qbSd6P53nrPdWKYlS2Yz0XGP6Aiox17JMXaLEjBWMY5lM3VahraLmvMwapOX?=
 =?us-ascii?Q?W3ZrdB6VWKPFkdQNwfOESFI+Dt+DrmLHAQyNZyutmJ68MisnxbiXwLJ8r5Fp?=
 =?us-ascii?Q?+mT1pqlCtsJ2OJoj81h7rF/SacSJiDFwko0Vf7RHAEBLg6+00r5WPce5Ggkj?=
 =?us-ascii?Q?xuCgCGrOjIJmFRZ1aBQ6qliPW5iua+3y/Qob56wB2ZGrFGj75P3E+UNE/LtR?=
 =?us-ascii?Q?ZWkDnA0PoLxGuA7EaoPVFhB8o7VDTG1QTn1/6wTEJSu96orbZBXixO+Ejl29?=
 =?us-ascii?Q?qnSo6sCGt72COFR1r5y4Brj6i5czeS+HCLZOvBp3r+hmbPous9ZmJOATayhv?=
 =?us-ascii?Q?Dn4GywZ1gNZwd1YHRifMhKm+HBTWcenvhuty1mobaBpJDqrek9aHfrvOo9l4?=
 =?us-ascii?Q?s+oPKq/ow3sqPC9ikBSvc1s1XrogRhMjv2OFX4s6WgetqgEwra5so/+bOtWN?=
 =?us-ascii?Q?QxcRL5h1iNCTIfPmn6a2Tlerc5ASrON/T4z71ApVIwrFDomfCfpzLorfC5cr?=
 =?us-ascii?Q?Mv6pkqmjPfVg/nFTy6ZMhSC8dXgxP1cgO6noLjRxFRnLOof7dxCFzNe162UN?=
 =?us-ascii?Q?WZymKCfd6WLzyQrgPpQFYjrGbgYXZX/DQzlvyvsXQZ3Xl7tswuoJk7w0vBaA?=
 =?us-ascii?Q?+0mzDsyYrvJP2h8WL0O1DASSmb/aMVw9V4Tc33th41d2+K5gm2uXMIGttKb6?=
 =?us-ascii?Q?5muDoqnSSy6xIzZWynYNH1j3GYZXUVBMAushF3Qe8N68ek5E97l2pxBhtytf?=
 =?us-ascii?Q?DO7WcKypyZK/zNFwNRgsAoTJBUSaoK4vQ000ZX/UnKfEi1F5LKuIUsvcPWmh?=
 =?us-ascii?Q?HqdiKjZ12JZwLdFwYdThtl2WohTJGjqRBzS/cIP4ehR08YDuomkcyA7V8COV?=
 =?us-ascii?Q?BZ/nN3wkC0X8IXdI469OLTkm3Mco1IoO7FogFS5o6rJPcfIaykAAqIf9QQM4?=
 =?us-ascii?Q?sL3zAaLr+bPEB+djhtwJ8RIymhZ4nfBn2c9+bzFtGsikAJr0eFO26wBXR+iJ?=
 =?us-ascii?Q?jAcBO8iCjx06UCrd75SnvQ0tCbS+MVrcLJx01K+m4Ihte/Ze8OlXOSrmPpdk?=
 =?us-ascii?Q?P5AbcbPF/ZVdFleeFjtwf4lLzOHymeswpjc6P1Oq2ku3w4qSoLcgrWLRAMY+?=
 =?us-ascii?Q?BxY3YBJt5Mf8lVd7mug=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dd921c-2394-4657-c4a2-08dba8ac6420
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 16:24:17.0708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DloDPps1IkRYClH4zB40mDTEuDLiScRjyqyFsjuXI0Ljrn5qiFwfIWbouS8KEUE7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4951
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

[Public]

> -----Original Message-----
> From: Joshi, Mukul <Mukul.Joshi@amd.com>
> Sent: Tuesday, August 29, 2023 10:55 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix reg offset for setting CWSR grace period
>
> This patch fixes the case where the code currently passes
> absolute register address and not the reg offset, which HWS
> expects, when sending the PM4 packet to set/update CWSR grace
> period. Additionally, cleanup the signature of
> build_grace_period_packet_info function as it no longer needs
> the inst parameter.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    | 3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c     | 6 ++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h     | 3 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c    | 3 +--
>  drivers/gpu/drm/amd/include/kgd_kfd_interface.h       | 3 +--
>  7 files changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index f1f2c24de081..69810b3f1c63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -980,8 +980,7 @@ void
> kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
>                                               uint32_t wait_times,
>                                               uint32_t grace_period,
>                                               uint32_t *reg_offset,
> -                                             uint32_t *reg_data,
> -                                             uint32_t inst)
> +                                             uint32_t *reg_data)
>  {
>       *reg_data =3D wait_times;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index ecaead24e8c9..67bcaa3d4226 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -55,5 +55,4 @@ void
> kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
>                                              uint32_t wait_times,
>                                              uint32_t grace_period,
>                                              uint32_t *reg_offset,
> -                                            uint32_t *reg_data,
> -                                            uint32_t inst);
> +                                            uint32_t *reg_data);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index fa5ee96f8845..3c45a188b701 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1103,8 +1103,7 @@ void
> kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
>               uint32_t wait_times,
>               uint32_t grace_period,
>               uint32_t *reg_offset,
> -             uint32_t *reg_data,
> -             uint32_t inst)
> +             uint32_t *reg_data)
>  {
>       *reg_data =3D wait_times;
>
> @@ -1120,8 +1119,7 @@ void
> kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
>                       SCH_WAVE,
>                       grace_period);
>
> -     *reg_offset =3D SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
> -                     mmCP_IQ_WAIT_TIME2);
> +     *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>  }
>
>  void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device
> *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index 936e501908ce..ce424615f59b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -100,5 +100,4 @@ void
> kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
>                                              uint32_t wait_times,
>                                              uint32_t grace_period,
>                                              uint32_t *reg_offset,
> -                                            uint32_t *reg_data,
> -                                            uint32_t inst);
> +                                            uint32_t *reg_data);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b166f30f083e..8a6cb41444a4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1677,8 +1677,7 @@ static int start_cpsch(struct device_queue_manager
> *dqm)
>                       dqm->dev->kfd2kgd-
> >build_grace_period_packet_info(
>                                       dqm->dev->adev, dqm-
> >wait_times,
>                                       grace_period, &reg_offset,
> -                                     &dqm->wait_times,
> -                                     ffs(dqm->dev->xcc_mask) - 1);
> +                                     &dqm->wait_times);
>       }
>
>       dqm_unlock(dqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 8ce6f5200905..1a03173e2313 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -299,8 +299,7 @@ static int pm_set_grace_period_v9(struct
> packet_manager *pm,
>                       pm->dqm->wait_times,
>                       grace_period,
>                       &reg_offset,
> -                     &reg_data,
> -                     0);
> +                     &reg_data);
>
>       if (grace_period =3D=3D USE_DEFAULT_GRACE_PERIOD)
>               reg_data =3D pm->dqm->wait_times;
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 679e8d6a5a2e..3b5a56585c4b 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -326,8 +326,7 @@ struct kfd2kgd_calls {
>                       uint32_t wait_times,
>                       uint32_t grace_period,
>                       uint32_t *reg_offset,
> -                     uint32_t *reg_data,
> -                     uint32_t inst);
> +                     uint32_t *reg_data);
>       void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
>                       int *wave_cnt, int *max_waves_per_cu, uint32_t
> inst);
>       void (*program_trap_handler_settings)(struct amdgpu_device *adev,
> --
> 2.35.1

