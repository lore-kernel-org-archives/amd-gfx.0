Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89580C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 19:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA57A10E1B9;
	Fri, 10 Nov 2023 19:08:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA4910E1B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 19:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFXKSLG+98+O1jWjyX/cF/OraJLXfQnQfVSuKMh6oIyyJqlBzXrDgHptowNxYo8ri+KcXrOu7+jFR6cCF+gk/wXReWpG0BlVBoMnA0LnaO87oYcXiZbNtt7oXWfSTn8ega/14WqdSzbV8M/gvpKLM0YTo29NZuvLeyobjIIZK+uWnVS7E/5gKDwxeyS0YYkDkGEtmkLsXjoP3KABN/g9NWbRWL8C72QSVrAD6aEwDfv+xxNnNRIG73DA37bq0yVXop4B7mXveXwjKkpuKp1xcFoSOUkw0tVnhwoHCTXF7WI0OhJnkrNm7Kko4FOMaKihgbS5KLdbkucNt8cjhBpCbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7yjGNgeYOrogOVwItz3mM0iNk90tyVDA2OOtzJZBMU=;
 b=OTiffq4ryYovjXzeyqL9yM2RsyzuUMaUoAsqIQr+VaGxskdTbukSdJvQfvfMXzz+nsWqrNCFalyY2UqYgeuYZFqb0KBHfX7tNK7SWxWi+pK5qtZXm6CZ9E/jn+jajJzccJZoqbPlSs0rb7OuaWg25E4kTg/6r/MK1nXHbiwUtxrhukkNrzCefetSvQqQBSqna2FeD6pAiBIFL0MS+TXuUmcDUYtPPcb5x65TTds5GxXYny0dAKklSGEqW8mIpmZdXyHPFB3LWd5T+Y9uHb08tnAX9mPlukP72d4yMhpgoiYKJFG+1OY9vvihOtAUOd01Bu9WE22fs9YZ1gU24uwZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7yjGNgeYOrogOVwItz3mM0iNk90tyVDA2OOtzJZBMU=;
 b=ToNlTFYTnm3jHOZwCoszgHVmPg3SrY8JWSQY83e1RTRvOHVsYq8CF3t3u6qotoWv3Uam1PCxZjh8pE+EIgE+P0O4bVap5poZlAsg69l7FVhFnGr9PuiMcowmy0sj/JK7YHjdNXQ+U4kcdmbT1SXL7gnymdWUh1SS8xIBUzZgfo8=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 19:08:06 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 19:08:06 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 22/24] drm/amdkfd: add pc sampling release when process
 release
Thread-Topic: [PATCH 22/24] drm/amdkfd: add pc sampling release when process
 release
Thread-Index: AQHaDldeiq8CwktJ/UyQITF8xgMuM7BzzNVg
Date: Fri, 10 Nov 2023 19:08:06 +0000
Message-ID: <DM6PR12MB5021960306E3061166F20DE095AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-23-James.Zhu@amd.com>
In-Reply-To: <20231103131139.766920-23-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0ed4cf0c-8581-4dc4-b2ce-a48da807bad7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T16:41:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|CH2PR12MB4311:EE_
x-ms-office365-filtering-correlation-id: 9998453a-d924-4053-cde7-08dbe2205f4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mvhzv3/DmVRgMR2Kdj++pix6wMdZN1GLA76X9Pv0UtP808rfJmoBz3POryDn+VcRjM73A3C/hhZItBM4JtAWEHjXEy5dyZEZ0/Im1jJ1/yq23MrqsqtspTy3H3gxj77qxqhllScW9O/V4PRKi4noTStyUMPdk0UDX73xTR/bIu2oB2YUSnlit7qi/ECcd4GHpQcV0OGi2y6QYkHyVDka3/eYo7xZCdYQLN3eb+SEizpuaJSm9q1AsdpSgAK7MEWsEriu0FBgr5jA5dxniOwERDhnBOHYJMAoLckZi/jsAfZFwse7rtXbFLZklH96gabiT3omT/BcNwnCDYYz7DvoAobd43icWyk9ij3KuFOBfvJvx4k+sL4uOlU6xk4boDoeWjg8hKm7Zprme4en2axiNanN/3gD1iPZcJ8NuqvbMRMr0LwriLfotIAP95DHwsZX9ouBASgsFtkT45HMA0g3rJo1v0JbyRBHvC3+HwSYukVLz+cmYF5LpPiUSbngG61+6Avy9tmtn4VpOc6WStseDUH/ev+6nTsnAVvHZgMAwFtezH+76i75p2v7awB/Y3/UHgnji+EzL1OAhksPN32PUvDVQFIl8ACznVM4Gi7XWTiIEpQfmUq5yNfY0qye1CeU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(110136005)(8676002)(478600001)(52536014)(4326008)(8936002)(55016003)(83380400001)(6506007)(53546011)(5660300002)(76116006)(66476007)(64756008)(54906003)(26005)(316002)(66446008)(66556008)(71200400001)(41300700001)(66946007)(2906002)(122000001)(86362001)(38100700002)(7696005)(33656002)(38070700009)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OvfHqhHzcOLwYO6INvLKAF16h50XQTYLJqFmmlom6xU/9/RLRPDhs6xskwKx?=
 =?us-ascii?Q?ETQE0WlewrZaq61XNvI2PlwzOWnPBkPffYFiLCPZgskCFSEUkNiRJy48oQ6c?=
 =?us-ascii?Q?qVQmS7b1qrbmo4x0ELL/hbYDjni28+t01/wHes+JY5HBVeoi5vohpeWndpeP?=
 =?us-ascii?Q?KYy8RPa/uT8dqVsnZZhA9RfC4v2iylVwjIUQpkeiHq68lcRKsRMNAunxq1CQ?=
 =?us-ascii?Q?FdQOpwbdYjIw3yd7sr4uDwXjZll0gmyhL3u5VajOP589NtbdtZ9dVJPyrSja?=
 =?us-ascii?Q?ZnUYhmwlad92oQ5Bb8wjeqIOBdfqxToeNuvrsPoUBw9mCXW4+Jsg3Fgkb6tL?=
 =?us-ascii?Q?Bq2fShhVduE6yHEUSzjzF89UROiOwPt/4JLf/9gOs892+p3Ek316d67w9WXo?=
 =?us-ascii?Q?a96sbvMy9AcjhXuZ7n8aNQdw9HVg/dsgIYtsF2HqmBrV+FZ/uqqjmaBqTZCg?=
 =?us-ascii?Q?/v/xf8HHno61Nrybo4YNT3PyUwW0TnIkOq/f7K2qlAndhJ2mEaiqH1wZ6Fjm?=
 =?us-ascii?Q?cboJqxBf1QSgUzX9ldifxIoYztSoIoe/GpslrWicc1VI9LTaQ1hfl1/SQF1S?=
 =?us-ascii?Q?7Wwpvo7twt/9Jaq5FdYxjZ6dZTru1j3sIzBvVTNBTW975XhMWYF1A687recf?=
 =?us-ascii?Q?cvgS+OZc2GxIWq+avluPp8t9ZHLrGyzMJUBpPI7gyee9Jwcm7kT1aAnymuCb?=
 =?us-ascii?Q?qjg3GTi6PsvfAJXj1FDePagMt78fCbTPaUPUe665PX2aCFhTkBjLqxw2+BA2?=
 =?us-ascii?Q?KdYWbRf4mrQmUdKnOubvHIV/ZkFjZxkmQpZ9DGU0AA3afIWN5z8FaDPDJYtv?=
 =?us-ascii?Q?Ae3euGNsxXQuKYPRMtUxEqRZHQ7kUMyDzYpqHOBPGbCcLaUqHg160s9fNl91?=
 =?us-ascii?Q?oBKl8oIYFVc6b+Kwgo//89HbezM+/L6XEdI39Nlj2qY51m4ZBRiCzPMxfEFn?=
 =?us-ascii?Q?HYffIAa65+skU39tj4eC3pzg87Sj7qUus4oASEvWcWN0SNYnANNQm+JzyixW?=
 =?us-ascii?Q?P6gcNucpD0QIBoJNm2RStqZ3CyyGrib1S/x9nZzMvudvnFXos86Oav8eVs9f?=
 =?us-ascii?Q?SAzXdLi/3DB5ZfaNEhOy8UdHqqU+IPWWwQgHRNZLP3uvBbxUKf+C1V8f5Hty?=
 =?us-ascii?Q?oJPjZY2StCllWm/sU+ulAIGg/Ff9Q249CUCMhyNQeBiLXYwCQaWdf/juV6Ct?=
 =?us-ascii?Q?Cl9FGu66sj02nJ/DWw+30Wq7fPD/U7XbV2iY/Wl27meUg/lE7sUQbVp9HSj1?=
 =?us-ascii?Q?VZVm06zKBwmwAlA7m5hY463MMxFEDbSkXaa/l/+FgdCCcUlDs9LhhUt8plJ9?=
 =?us-ascii?Q?zSML/Hj44UnWGzXiix+TjR48/jVvXc3FoFRxSGlFkiyB/7bcZXHjdGS8RPlk?=
 =?us-ascii?Q?5gZpl9y79lgM4usiD2ibmxniwmCN1lUpyvLKzs2h8ax7MYM8q5DIVuAFDPbO?=
 =?us-ascii?Q?mqUdZVuOlEPtAOdKNp7fh6hLTGLXxYUfqD0VS2M4ygZYDfJdjlZ6g8D7gY46?=
 =?us-ascii?Q?RLSv++8mTtohnABQAZVgoEEcK7J8gQ/qXRdlRrtpjl4OR0qw84/us6J59v9q?=
 =?us-ascii?Q?DMZeTgF9v5nDBKdyJJg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9998453a-d924-4053-cde7-08dbe2205f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:08:06.8783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kqXTzaVV2IjEIbxBscUryWk4SeXxw75oJY/gyrWaSI54qBERT0/hipOyu9r/djpg6JTPPTjWGZzaObDdXVNaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
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

> -----Original Message-----
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Friday, November 3, 2023 9:12 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph
> <Joseph.Greathouse@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Zhu,
> James <James.Zhu@amd.com>
> Subject: [PATCH 22/24] drm/amdkfd: add pc sampling release when process
> release
>
> Add pc sampling release when process release, it will force to stop all a=
ctivate
> sessions with this process.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26
> ++++++++++++++++++++  drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |
> 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c     |  3 +++
>  3 files changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> index 66670cdb813a..00d8d3f400a9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> @@ -274,6 +274,32 @@ static int kfd_pc_sample_destroy(struct
> kfd_process_device *pdd, uint32_t trace_
>       return 0;
>  }
>
> +void kfd_pc_sample_release(struct kfd_process_device *pdd) {
> +     struct pc_sampling_entry *pcs_entry;
> +     struct idr *idp;
> +     uint32_t id;
> +
> +     if (sched_policy =3D=3D KFD_SCHED_POLICY_NO_HWS) {
> +             pr_err("PC Sampling does not support sched_policy %i",
> sched_policy);
> +             return;
> +     }
You do not need to check the sched_policy here, already checked in kfd_ioct=
l_pc_sample(..) , so cannot have a hosttrap session if policy is NO_HWS.
> +
> +     /* force to release all PC sampling task for this process */
> +     idp =3D &pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr;
> +     mutex_lock(&pdd->dev->pcs_data.mutex);
> +     idr_for_each_entry(idp, pcs_entry, id) {
> +             if (pcs_entry->pdd !=3D pdd)
> +                     continue;
> +             mutex_unlock(&pdd->dev->pcs_data.mutex);
Can we not release the mutex here and just tell the worker thread to exit b=
y setting the stop_enable bit.
I find we have a lot of places where we are acquiring/releasing the mutex w=
ithin loops and this results in a
lot of extra states that we have to account for during the start/stop/destr=
oy calls.
> +             if (pcs_entry->enabled)
> +                     kfd_pc_sample_stop(pdd, pcs_entry);
> +             kfd_pc_sample_destroy(pdd, id, pcs_entry);
> +             mutex_lock(&pdd->dev->pcs_data.mutex);
> +     }
> +     mutex_unlock(&pdd->dev->pcs_data.mutex);
> +}
> +
>  int kfd_pc_sample(struct kfd_process_device *pdd,
>                                       struct kfd_ioctl_pc_sample_args __u=
ser
> *args)  { diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
> index cb93909e6bd3..4ea064fdaa98 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
> @@ -30,6 +30,7 @@
>
>  int kfd_pc_sample(struct kfd_process_device *pdd,
>                                       struct kfd_ioctl_pc_sample_args __u=
ser
> *args);
> +void kfd_pc_sample_release(struct kfd_process_device *pdd);
>  void kfd_pc_sample_handler(struct work_struct *work);
>
>  #endif /* KFD_PC_SAMPLING_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d22d804f180d..54f3db7eaae2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -43,6 +43,7 @@ struct mm_struct;
>  #include "kfd_svm.h"
>  #include "kfd_smi_events.h"
>  #include "kfd_debug.h"
> +#include "kfd_pc_sampling.h"
>
>  /*
>   * List of struct kfd_process (field kfd_process).
> @@ -1020,6 +1021,8 @@ static void kfd_process_destroy_pdds(struct
> kfd_process *p)
>               pr_debug("Releasing pdd (topology id %d) for process (pasid
> 0x%x)\n",
>                               pdd->dev->id, p->pasid);
>
> +             kfd_pc_sample_release(pdd);
> +
>               kfd_process_device_destroy_cwsr_dgpu(pdd);
>               kfd_process_device_destroy_ib_mem(pdd);
>
> --
> 2.25.1

