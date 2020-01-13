Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB90CC33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 02:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76EEB20678
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 02:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cRPm3LNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EEB20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0846B89819;
	Mon, 13 Jan 2020 02:38:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 130C989819
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 02:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkQw0E5UUrJKXKBnrxwvZvWxYxBh331B7TAgzqafbTSF2eSMBVQCgX0KJV+F00AGA46v0ZuLzpU7PujLelFAqkqerebEoSlFlmKF06dJU9at2EcU+BN29LQxJk8z4DQOHczZxOwPyEqTz4DJHZWO44CYmc5BsYBSeJUqjgzWZk+cskEFJnuT0jk6FfSSBtOqcQ0AuLzAczC6TQRpsA5XoQr5OumH75hyVskRO9L3yARm2n1rMqt03UID7flgZ5fSeJubArY3I18WO1qiBaNsBWX+xPynpCZCcyxpVBztxtQxnJROZzpoI6vy9wGFSMuAXLHInWf/XGmOzaVXDhqglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AicVrp9xVV9SRKPiDQLg7g5PB1U5S+E17kAl+4/kjSU=;
 b=HQYDRIY+wDXDNno/d9gmpRVpmtOLfNba5oMpueamV4q7D9fJ7fFk44NX/CHtqlXpN2eVSRt5o+p1ohPl18v4n7tZciyy4fcvgfDHQ122TxsYaiN6X8OZfexd4zz7F9xkBXAwa7RU1c4ILL2yfb8vgvDv4TVGMKHPW3N8uN3BtGtW00PcuT3KUpC3k3w8PoQsow/aGRgWvUA096k3Ij2l771p9Uo28AwXxBZeFvGrdKup+Uk5eTIc9qdE95OE1SSakX0HD3vnvj4LnxiMuCunw6byZw9fh0O5xw0mcM1CvFyY8iq1eqqzODS+7z3F7bucXYlWOLytYRnB2ZUN8odY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AicVrp9xVV9SRKPiDQLg7g5PB1U5S+E17kAl+4/kjSU=;
 b=cRPm3LNuqAoMmPqW8rRtxjOQpAflLrn/iOuy1sMBnRGU1TPNNOvwuhOkkXNw92ApOqfFohP7h8T9wXR6+gH/Av17rfsces3w6A8eFcvWJ1T18g0h4In0MvQY8guAMR73fcfkEuEDmZHSjuduBs8lOknGqWviFtFYrdQ58aZ8zuI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB2941.namprd12.prod.outlook.com (20.179.80.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 02:38:28 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 02:38:28 +0000
Date: Mon, 13 Jan 2020 10:38:20 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 3/5] drm/amdkfd: use map_queues for hiq on arcturus as well
Message-ID: <20200113023818.GA14889@jenkins-Celadon-RN>
References: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
 <1578638233-9357-3-git-send-email-ray.huang@amd.com>
 <3eb4c086-94ba-2159-50ff-df497586d9fa@amd.com>
Content-Disposition: inline
In-Reply-To: <3eb4c086-94ba-2159-50ff-df497586d9fa@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR06CA0022.apcprd06.prod.outlook.com (2603:1096:202:2e::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 02:38:26 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56aabab7-7ada-41dd-17cd-08d797d1abca
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:|MN2PR12MB2941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2941FA95C4A9EBA96D60D540EC350@MN2PR12MB2941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(6666004)(956004)(54906003)(8936002)(316002)(5660300002)(8676002)(1076003)(33716001)(81156014)(81166006)(6636002)(2906002)(16526019)(6496006)(52116002)(66556008)(9686003)(66476007)(186003)(33656002)(53546011)(66946007)(26005)(55016002)(6862004)(4326008)(86362001)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2941;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUzEpoTewo3GttK/2QVW7xUS4Ygib3MM27eCwZDk3Ls2q9Y5It5i9uCdvhq3uQJqMyPGB6JgqDWoqvANpgsXNJkjSgsA1xaDBPhfOYTpB4RRdYpynyEtK0y4NAy6/3/fga106iVdHoZOyCUW0P8RDo9YynZ3Gt+LULBGqFwQrMIEm+FECtytLTAk5Ic325YwwGWVeck6irtGpfgi7pzIirPW2NWLZINCF4y013tIdbjLotnl7dtMtAoJe9XkVWg97JfbSLGjt0mmL+xaUF/9wuk+TfmmQEhWbIGbnE63YvvakSb9q4+fi00IJk7/8OMgr0bFu4p32uQ6Ei3qVAjhO/1HgT09tS3XDI5TdPbTZ+WKPO/z/+scHBiBnWFg6BV8/+prhU1Nxkl569k4/+x63V9sA+tOTpp3/oVVhv+oABOyKmxWfQlQ+Aoif9XbaKbE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56aabab7-7ada-41dd-17cd-08d797d1abca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 02:38:28.5440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Jm8vVLdap3hBXTznppFkYlC30sHwDuXHzFBkQANDrsJ69S90vsKgVeDQOS/QYaSuM8VLIjngzGOnXOdi1sKpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2941
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Jan 11, 2020 at 07:05:40AM +0800, Kuehling, Felix wrote:
> What happens on Arcturus without this patch? Does it oops with a null =

> pointer dereference? If yes, then you should squash this patch into =

> patch 2 to avoid a broken intermediate state.

Yes, Arcturus will get a null pointer panic without this patch becasue
hiq_mqd_load is not inited in arcturus_kfd2kgd. I will squash this patch
into the patch 2.

Thanks,
Ray

> =

> Regards,
>  =A0 Felix
> =

> On 2020-01-10 1:37 a.m., Huang Rui wrote:
> > Align with gfx v9, use the map_queues packet to load hiq MQD.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c   | 6 +++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h   | 3 +++
> >   3 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> > index 3c11940..8baad42 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> > @@ -281,6 +281,7 @@ const struct kfd2kgd_calls arcturus_kfd2kgd =3D {
> >   	.set_pasid_vmid_mapping =3D kgd_gfx_v9_set_pasid_vmid_mapping,
> >   	.init_interrupts =3D kgd_gfx_v9_init_interrupts,
> >   	.hqd_load =3D kgd_gfx_v9_hqd_load,
> > +	.hiq_mqd_load =3D kgd_gfx_v9_hiq_mqd_load,
> >   	.hqd_sdma_load =3D kgd_hqd_sdma_load,
> >   	.hqd_dump =3D kgd_gfx_v9_hqd_dump,
> >   	.hqd_sdma_dump =3D kgd_hqd_sdma_dump,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > index ab8c23a..d2f9396 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > @@ -324,9 +324,9 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *=
mqd, uint32_t pipe_id,
> >   	return 0;
> >   }
> >   =

> > -static int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
> > -				   uint32_t pipe_id, uint32_t queue_id,
> > -				   uint32_t doorbell_off)
> > +int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
> > +			    uint32_t pipe_id, uint32_t queue_id,
> > +			    uint32_t doorbell_off)
> >   {
> >   	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> >   	struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> > index 02b1426..32dd1a9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> > @@ -33,6 +33,9 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mq=
d, uint32_t pipe_id,
> >   			uint32_t queue_id, uint32_t __user *wptr,
> >   			uint32_t wptr_shift, uint32_t wptr_mask,
> >   			struct mm_struct *mm);
> > +int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
> > +			    uint32_t pipe_id, uint32_t queue_id,
> > +			    uint32_t doorbell_off);
> >   int kgd_gfx_v9_hqd_dump(struct kgd_dev *kgd,
> >   			uint32_t pipe_id, uint32_t queue_id,
> >   			uint32_t (**dump)[2], uint32_t *n_regs);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
