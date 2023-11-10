Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500BDC4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 19:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD52D10E1BA;
	Fri, 10 Nov 2023 19:07:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C7810E1B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 19:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egxiHPHPDDVs4D42HV0Sl9iEMsvQ6Eq/MN2cJ+N7hvYrBGSPq5C/Ak0q5hsWuOMyw4CIVGyGuvbACD2q52vVWcvFNAuLEYVS4VIdrEKkdk4xW+iX0Hgc/XJ+uzRN4nC7iEvf0WU71/dhj8I6l3gM3JcbJhEpBq97Su/J0huxDhG4NUAapSQE2pV0J8qvhjltsikSA9sPzr+dsJerjazN/8BTcH0q5LN5ibWfCfKeOBf6EzWEIYnco0Of0XZAjsKS6JZqOWq1FoSGzGeJbszd9RAFqyx616kKcOBCOU3dihLO6zLQOlITGnlN3Cz1mKuStq9o3TJN122LYTpK2+abUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI3grxqDN2sKET4n6s2cHJ0kD28hnFQNDwG1F2tnMHc=;
 b=L94QSA4eysSpgPfo5S7/EKe3erXXnxQvFhZ+wXXCy+lghUm1dZ5X23Qe27pUeoDoBlAdlrZgJH1OcI00QO1IOEqmO1DMyX9mW3NmwE+W3mUvZYdwAYf8PfZGks9bncIDdrxWVO8/eXfBKDtyb5Hb9pllZgcslPVZ1TjEJK3q79aQJp4+vlwNcSSUkEiSabWWhQgccw/6mLNk32fr3MHEUHNpFKC3w6aBk6KJUompmhW73I3DgwOmkUHLUaxZEXh5ZPGsoXyjjvehPTvRyDdbAU2/PhjndN5MtPaBCgGiwuf6AMaTe63zBbQKzo+quB+aPcZgvuwQm2Jpv368OmQvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI3grxqDN2sKET4n6s2cHJ0kD28hnFQNDwG1F2tnMHc=;
 b=iUTlE5PZoryKRabusmbA2YLU0qIDltKxBCMrMwyExHn86VCmd6iKTMqyZT8AQgi5Zhb+6BjMKOA8Mg5Y2ZR0QrPTRsC1yIJSpvySg2QeIKFQVVtLnH4RaiP3RmVuCXlWdDH3Wd4HksrRRtSSm7fa7yENuGR5TP3GdRYsTuKZOzE=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 19:07:18 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 19:07:18 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 17/24] drm/amdkfd: add setting trap pc sampling flag
Thread-Topic: [PATCH 17/24] drm/amdkfd: add setting trap pc sampling flag
Thread-Index: AQHaDldbV5T0I5RYc0+iqVWUEJ8/S7BzxsCA
Date: Fri, 10 Nov 2023 19:07:18 +0000
Message-ID: <DM6PR12MB502180B96D016360B30CA16D95AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-18-James.Zhu@amd.com>
In-Reply-To: <20231103131139.766920-18-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=55336e25-923c-49c0-b85d-e2045f439f8c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T16:19:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|SA1PR12MB8721:EE_
x-ms-office365-filtering-correlation-id: 49fa058c-4aae-445e-7b6a-08dbe2204275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SBSfCP/Zk+M4eVUB3tqcM+qYiVxE3yDNhZ1dfqdjwrupYEjxarRk4Ek1mteFgHEmfuEoFIorDoFyvKbtsAyO60EGtQLa7/OQG6G4jdRzMi99YX+HJUFKtqifft6ZnSIcJdDpA07Lf0xKnDo3HG0aWKvtbCc76tNs+TLgFS2wm8Ph9A8e0fNL3S+vpEg+dCefwqR/WdxWlBtylAh1dW3DT7FW94bP8ij6lacpcxmCu42Xu/Dv5DlZ7tfBY3CcnlWe/lk0y1FrF6raxxIOCJcYJzq4EYF2qhT0VJEH85etMAt23C/VzSF+SwTN8LT8OUItZ7qlT/0uqr7kz7tv0iHhknpFJ+O6TxSsvuESHN7rt83zjjUL5xCeS8/JzeXlhDQ6tkF84RwoyXyYQaFiiVjW0unT8jdqnSd0yeerBCBGA55RG9ee3NMCy7NCo5EIfPccIROc8IP8H0LHLpjFmwllob4H4DcmAY/t60Q/mV+DzxSgWY7p9Su4p+LFApxWujUuYSUpieTJGl0NrsncA3Yh+94r4064zwG0T58HElLF8ZTGIqOnt3d83qZOfPovMgbQO+3EkNxcqvGV+zeE5oDtRaXUJDrYsqooFGzdiLXdIxtN5q4+hBQ4I3XFBWE2zN+8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(33656002)(38070700009)(8936002)(83380400001)(316002)(26005)(66476007)(66446008)(64756008)(76116006)(66946007)(54906003)(110136005)(66556008)(2906002)(52536014)(4326008)(55016003)(5660300002)(478600001)(53546011)(8676002)(71200400001)(7696005)(6506007)(9686003)(122000001)(38100700002)(86362001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xpO9Iz2yklCxXcPj5MzTmwjXLHBY9AEmMYzQ6OoqDnBdJomGn7zXzgcwxPdp?=
 =?us-ascii?Q?Tbrl+0GqU1qLSXt2hi5/nS6DYMJ/Rix5P/Z7ZruJEMRaksGP0hG/cLJVUzmU?=
 =?us-ascii?Q?LM7vR/hYCLRzjOyw8lpXY7fviJxRvLDB9UczDVBODAiNFmriAZC1Ow1/yeff?=
 =?us-ascii?Q?GqSOnThWUE/4mRPVyPQDam3RAbMZYNlF3nlqCjwXB0VXFXgLi3PTRTotakoi?=
 =?us-ascii?Q?gCBAvNZaYt9TiIaeTSAK/1+gN+BGguHiGL3a3phjRYTv4ZVMANL/MqHf74Yv?=
 =?us-ascii?Q?ehwRfbHstjKKKM10tBfKUrGRpll1Y+HFZFqm9RFZGbMpzgUcZ7DdznAxIlT6?=
 =?us-ascii?Q?th2QPjGk1Gze7b8QasXtDlHWDzTGQ9b3F6f6hPw6/N1NUlucuXTnCt8ZOMYF?=
 =?us-ascii?Q?lewEYxcHLs41ztBbzOv1Al+yZsIXF2NlP/p8zwiudZNQOvWNJmRZBli/JCLJ?=
 =?us-ascii?Q?fSrU73fTtX0MemkId+T4T5zUS6zAJKR0egdR52F8lcU0Dv1ihMX9FnFBax3m?=
 =?us-ascii?Q?F4WK4ThyFR2wOPT8byqOmlAK6KjBsClFNvYenNucXJ/FRo3R2gZWm+9rFYZ3?=
 =?us-ascii?Q?PZQc3NBy2lg39w0GfE4t6qjOO16jDt9Ae4kuZfbc134kYpdPZObDkLlY8K9+?=
 =?us-ascii?Q?S55OsK9YGt8YVmUeCq1anyHRuiKd99I0f9x7qVXLbYKXEz3ivP6seplGoPmo?=
 =?us-ascii?Q?FWYd3mCLX3bBpKFF01l1whvabUXonNiHMnIN2iIGRVPYdc9wE6/WpWYbVscE?=
 =?us-ascii?Q?+BUodKe5ry8Fo9AEWT0q+SmRFzyB4DCvbYs2KTCvaVfZM02mxpRZu/FmJUwZ?=
 =?us-ascii?Q?6DG6YD4YafgWW4gMUCcnolFQeRwQqDL60nUyRT7s60QqHhg9/9DGQ1+8MQN3?=
 =?us-ascii?Q?zgQIdQ+VBZo4jcR+PLwChta65fPR97+RJaLtZflVvI/zI0oSRWDX+hKfb+ML?=
 =?us-ascii?Q?o+6TNv5mpQFNer/Nl49T/GDeqUO24IGonQjXK0H7Bec5uZffujI/KjW32YN0?=
 =?us-ascii?Q?H1jKBSlNA8P8dmDvBNDj5cXo8ipIxT8AAW+9F2OlEdsHUMy7MvNAACT6a2N8?=
 =?us-ascii?Q?S0W5ivNFUZYwz2dgHd1xyoIJuI2eO8QhMtCBG8O3hrxm8sB1+6E0HSdqhX0N?=
 =?us-ascii?Q?pU242N6+cVOys9MhLsAcNtrsG52zXy7y4Ely1gLWuJnvVkmN8R84bQqIC/ZL?=
 =?us-ascii?Q?wSjH1fa991gnNdDj/jIgKNXj97jQr3DA+yL8/qzD/CWlcVMB1dNYzu3EJa1G?=
 =?us-ascii?Q?vL2ghHEKxfBCHdUqeQNy3vcDlpODwon32jxTvSjaGRg54ijE3zM7uGBz/LWG?=
 =?us-ascii?Q?1a9FxgtZoLFoKwhZBfPR/HHnRobKJZ1ztyyqnONxjRp+LpjMY4eyBBKlYURa?=
 =?us-ascii?Q?MSPkMZrKGlZ5ZtDJOWsgKKnDTBlV7q+4y56W/oL4YxPBZFBKzzWAXZa+Ihrb?=
 =?us-ascii?Q?uadQxFikWqT1Xu8vUc4mcUDU+0n7omkfw34+Lk85VmiOwSuQSld2Qg2pHsDO?=
 =?us-ascii?Q?OKTChITKl3Hwl9QZ86jt+lThnrd93OKVIoSpGYIfQbR4FKua3VQ6N79Dx5KQ?=
 =?us-ascii?Q?IBA/YpvfMidSQIBOui8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fa058c-4aae-445e-7b6a-08dbe2204275
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:07:18.4680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTL7N+svqN9uqS/LWrX9ZsZ6uLdcZNSShorlSAnr2X6/xdqzY59o2ZI5ALmeMn+H+c/UTLltwd1PP2uUnho4nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I would recommend merging this with patch 16, but up to you.

> -----Original Message-----
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Friday, November 3, 2023 9:12 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph
> <Joseph.Greathouse@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Zhu,
> James <James.Zhu@amd.com>
> Subject: [PATCH 17/24] drm/amdkfd: add setting trap pc sampling flag
>
> Add setting trap pc sampling flag.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 642558026d16..6670534f47b8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1186,6 +1186,8 @@ void kfd_process_set_trap_handler(struct
> qcm_process_device *qpd,
>                                 uint64_t tma_addr);
>  void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
>                                    bool enabled);
> +void kfd_process_set_trap_pc_sampling_flag(struct qcm_process_device *qp=
d,
> +                                  enum kfd_ioctl_pc_sample_method method=
,
> bool enabled);
>
>  /* CWSR initialization */
>  int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *=
filep);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index a0b729c65a7c..d22d804f180d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1454,6 +1454,19 @@ void kfd_process_set_trap_debug_flag(struct
> qcm_process_device *qpd,
>       }
>  }
>
> +void kfd_process_set_trap_pc_sampling_flag(struct qcm_process_device *qp=
d,
> +                                  enum kfd_ioctl_pc_sample_method method=
,
> bool enabled) {
> +     if (qpd->cwsr_kaddr) {
> +             volatile unsigned long *tma =3D
> +                     (volatile unsigned long *)(qpd->cwsr_kaddr +
> KFD_CWSR_TMA_OFFSET);
> +             if (enabled)
> +                     set_bit(method, &tma[2]);
> +             else
> +                     clear_bit(method, &tma[2]);
> +     }
> +}
> +
>  /*
>   * On return the kfd_process is fully operational and will be freed when=
 the
>   * mm is released
> --
> 2.25.1

