Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC8DC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 03:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776B361433
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 03:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776B361433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C496EB46;
	Wed, 12 May 2021 03:40:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 471F189E01
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 03:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAp5NOeGvpHs0ujlZjaOlpBjI6pyan6bpOdbg14mMtHWTs9HHM5vlHfA+hwOabmh4xRmY/8M4MTgKixSav7LX3W6QXK8XiapjuxJT4BLCdhR0Wi6zUMq+bd8aw/E5evAj1JaCq6msa9GafVwWP1QaaxoqgomtK32ILBacjHYZTsV1bnutSh8aepAZs+/BmuCv/OKtN5S/nPKE8tcLP9cfziDTc+1WOIi4F51mExQQSwkcJVrlq7MKjBiLBL2/d7RQt71t+0pK/LYb1G6c44JlSfYZ+1ffWSnEIBLsZJWE+mbjBjNyCFQaQAIRCfS2lymS0EE71FWyFPc5RwIQkp7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO1ayZwjQ8ZcWWi9o8KrlbY7QaG217pV6e1BtuUFVL0=;
 b=QvP16vlptV24L/7+caxZJbeKAhqxJekHB84gsBGt26Y7lzRcxu7eg9CamYycFbLLLTjOr9ZKwX7NVPhCMa+Ml5Mk5ZVtY26/qt68mk1r40+HFp4ACAPoeAfvhpf4AMUxLgnvWWmzmAORnJTDro9muiYEBs0CB8LwKNOuJeQ2pdJjRh0IyPbH7K2LFx+BrE5eewkZ199T/9r0bix+u/5OdQIO3SnsUCJFNakjUnN5Ho4N19+Q6Usqz/XP5Jhjcz4S+4gauTwhMS6S4gF1e6BKIQTYUhpQ9tqdqkW5f6cm/9yaD0y76MsO+dZ8Q8Vb7+Z7kweBnCMVFVFcFAaHehzzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO1ayZwjQ8ZcWWi9o8KrlbY7QaG217pV6e1BtuUFVL0=;
 b=dqzfXdIX3egTs4Q+EIHZVsXNUEd3eT+30JRk2F8MdefUJfARkK7Wdz2cFbzAwd5p2RssjMW5uffbtbz9aZwnpPs6NTSEZtn0ILkUAlokLDDQNDyUoLfsw4DMhCfwHitUrcVXmF3MmUnAHpp8nnR6nS7vDxSAoDvhg69eA1nGIxs=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 12 May
 2021 03:39:58 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b%3]) with mapi id 15.20.4129.025; Wed, 12 May 2021
 03:39:58 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Field type update in drm_amdgpu_info_vbios
Thread-Topic: [PATCH] drm/amdgpu: Field type update in drm_amdgpu_info_vbios
Thread-Index: AQHXRib02+jdMKALMkGYuyTu+NDEqKreQyAAgADwf6A=
Date: Wed, 12 May 2021 03:39:57 +0000
Message-ID: <CH0PR12MB51566D5C493563D084E82CE3F8529@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210511053109.28816-1-Jiawei.Gu@amd.com>
 <MN2PR12MB44889B34B2877BEEB6DF1803F7539@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44889B34B2877BEEB6DF1803F7539@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-12T03:39:36Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbbdc4af-81d9-447d-e47d-08d914f79d7f
x-ms-traffictypediagnostic: CH0PR12MB5122:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5122F3B2761F2A4030AE0E85F8529@CH0PR12MB5122.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xic1Eb3NxMkbllEXAmgtM8/eBLnA+NHpJGif5W/++IYV6o69e9qqk0seCooXUj7o+DeOV+PzPy7BTk6svLqWezQWEZ6jHgAj9ScIb5taPYrIMeygQE6efFBBUowhT1nPFqSsGAZNn0iRbrP367dc/wQnTnOK4s+Tl8ql0MY3UinElVqWC8qXg9m76VU3AP78i/Juk0Yk9CKXHP5ERehRJjXeg8FGFy5VmQbSg7s+zgI6H9iv+2Kenbnucdsa3gt5ygl6baBjYQhGlKpVKezIuCLx3oEUbFOaHvPVZLg3lqLxERLPzrZnruE999+WDxy+L07sE8Xl2jYpz4ktHuo3kQjA5ZV306YA0A1Gw3NnL5xyUMuvhVdIknNK4BFPhrxh1czMkBaz5ykufxwK0uWLDQ9gW1SjAxm0L4wTcrPmSKuNtQEyPph66HbW0KFCgbk8x3R74tMCHY7hN005izYxBBilg/ssVMiv9n6t0RTmStB3D/cTIFsw9D3u5S93ISdBuLAyJHqcCvFCyqOwtmjbdsdFj0sr74ZsbEiFqSZx6IyGbdjEsRkV9BMpuOzDiOskZN4H434QVwX03lqhjIHpAH0Rls9cc4iKXvRz4QtCc7ljXIHhN1dJ/5tyhAC5lp7wRXvfWn8GpyArvITPjhD4vA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(83380400001)(110136005)(55016002)(86362001)(478600001)(8936002)(9686003)(8676002)(54906003)(53546011)(6506007)(52536014)(316002)(4326008)(166002)(2906002)(186003)(38100700002)(5660300002)(15650500001)(122000001)(966005)(45080400002)(66556008)(64756008)(66946007)(76116006)(26005)(66476007)(33656002)(71200400001)(66446008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6E6r4v35lQ2MJNkGBWagIRoTpacQz8rcI1aW45q1A6dQOoN39NIaw4JMZbY6?=
 =?us-ascii?Q?sb6JifCEnXVueXxUXs5u7Kf2lRW+BavtTyCwKBQxg6G2aqVCEQFdV2saplpK?=
 =?us-ascii?Q?ge5Vd4SmKvIcC9F0qsN0lspMGRM+dpMb+lZE35rpfHDCZXReFPj1p3ka/ljY?=
 =?us-ascii?Q?AH8MMXPJtTr/TxAB5c78osQbOhIsc992Y/qzQx959Mda0Jx3nEtsq0mFqEzG?=
 =?us-ascii?Q?SZnKanTPQCbVmsXvxHl3Hu+yBFcnYX+k2FNBUTRrz6ty55CnrVs+ioewQxHe?=
 =?us-ascii?Q?nujW2KCG2CxJ6IAmpUsOVRLQ+CdYejaziGznBr4nHgQy4JkTanRvSpV3q4Pz?=
 =?us-ascii?Q?k4vhhBJx4letyt0saxq17S6rT+dmy2NS2JffZbOwRXnT1thMH4ttD20IGwq3?=
 =?us-ascii?Q?wOcyEqlQkegHQQIj8HOG92Fq6MsVyLYI3x/mWcaGY7d49S/GkHmQVHeFpE3Q?=
 =?us-ascii?Q?8c4gBoRNu7b+XuciiNUAUABKphc1RS7Gd/jHMmqdpk19znkkc16mxAGrZnaT?=
 =?us-ascii?Q?F4o8xIsDon06+fw34lPhK9WWvDyX3h5+YOEy3365wA+L2QUe71OihOno5UmU?=
 =?us-ascii?Q?13qLU0ZL4NoyG8GswiJrTO/RnW4HekNDs/cgJ2D5BiXw2+V0SdwWBos3eG/9?=
 =?us-ascii?Q?+qlNbcsITgHckOcqTS4i/uPCHmH38h41oxOXzB8fSUAnHdT0j3PadzPmtIsv?=
 =?us-ascii?Q?KL9YAWp4Gny5AaW8MTXQkbuJWerR/VTbwc6AJWWXBB4cckR3gn/dD5f5VKno?=
 =?us-ascii?Q?m0bvM9thniYm4DAlQLATIP3q4GYfq1I02AbnuFyvTrfNN6+S18oL++TcFB+P?=
 =?us-ascii?Q?GCSapDr+aMEqdcmgMjVsyf/aTYceZu8oyXbKotEvXAehjVffGUkF1R5b7jKR?=
 =?us-ascii?Q?a3hQQAqOn2PRC4B7aQcU1WivJ8N7sm4+YlTxlRInpY4T7nlSZMjQCelqarSO?=
 =?us-ascii?Q?z765b1+7oWYQd+dwBTVhi6wgW/x1/HfB5hRjEIoa0etARK1vwmqFIOFdI0KC?=
 =?us-ascii?Q?5pgqc7ADoaUlg7Z1AktvteeHtDrxfV0v1emitDn2c2ImOfkUIuRcnXpcFg3N?=
 =?us-ascii?Q?4YY7i8OeSacgqi2B33q2ljCLtMGAcaPIts23wBACIeauROTfMmXONefgcn04?=
 =?us-ascii?Q?9JupqG34B8ylDMZBA0BcNKko0Q+hWqoZYSmGRLuz6/sKQ3/CrxxYb82VAy6l?=
 =?us-ascii?Q?rqRcqppzyUl5P9qaITce7omVvNUkqHwnsggGObuBQ57zDVbFM23KqlqvYpjU?=
 =?us-ascii?Q?XZFkYecCyZgUh1G1elDsD6phb2Dsqq0qA2pyXxvJ0AKMZsaQcehbB8jIkUvL?=
 =?us-ascii?Q?w8HfN3/UJYkb4bimHA2LVwD6?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbdc4af-81d9-447d-e47d-08d914f79d7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 03:39:57.7525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gh90Qb5Z1XBiGhSEvmlVGSvffTRqfHa0PGFM7Bf/AvMXIM1kSRh6Q+zkFuc2GYtyvA4OObsaQuNsYuArDcnJTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5122
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>,
 "keescook@chromium.org" <keescook@chromium.org>, "Nieto,
 David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============0115867500=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0115867500==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB51566D5C493563D084E82CE3F8529CH0PR12MB5156namp_"

--_000_CH0PR12MB51566D5C493563D084E82CE3F8529CH0PR12MB5156namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Done. UMR patch sent out.

Hi Tom,

Please help review it to bring the umr part back.

Thanks in advance!
Jiawei

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, May 11, 2021 9:16 PM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: StDenis, Tom <Tom.StDenis@amd.com>; keescook@chromium.org; Nieto, David=
 M <David.Nieto@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Field type update in drm_amdgpu_info_vbios


[AMD Official Use Only - Internal Distribution Only]

Please update the umr patch as well.

Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Jiawei Gu <Jiawei.Gu@amd.com<mailto:J=
iawei.Gu@amd.com>>
Sent: Tuesday, May 11, 2021 1:31 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: StDenis, Tom <Tom.StDenis@amd.com<mailto:Tom.StDenis@amd.com>>; Gu, Jia=
Wei (Will) <JiaWei.Gu@amd.com<mailto:JiaWei.Gu@amd.com>>; keescook@chromium=
.org<mailto:keescook@chromium.org> <keescook@chromium.org<mailto:keescook@c=
hromium.org>>; Nieto, David M <David.Nieto@amd.com<mailto:David.Nieto@amd.c=
om>>
Subject: [PATCH] drm/amdgpu: Field type update in drm_amdgpu_info_vbios

Use numeric type serial in drm_amdgpu_info_vbios instead.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com<mailto:Jiawei.Gu@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 include/uapi/drm/amdgpu_drm.h           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 75f34a9008e7..e1008a79b441 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -871,7 +871,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)
                         memcpy(vbios_info.vbios_pn, atom_context->vbios_pn=
, sizeof(atom_context->vbios_pn));
                         vbios_info.version =3D atom_context->version;
                         memcpy(vbios_info.date, atom_context->date, sizeof=
(atom_context->date));
-                       memcpy(vbios_info.serial, adev->serial, sizeof(adev=
->serial));
+                       vbios_info.serial =3D adev->unique_id;
                         vbios_info.dev_id =3D adev->pdev->device;
                         vbios_info.rev_id =3D adev->pdev->revision;
                         vbios_info.sub_dev_id =3D atom_context->sub_dev_id=
;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2b487a8d2727..2d9e84658bbc 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
         __u8 vbios_pn[64];
         __u32 version;
         __u8 date[32];
-       __u8 serial[16];
+       __u64 serial;
         __u32 dev_id;
         __u32 rev_id;
         __u32 sub_dev_id;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C9c3ad129089d4585544f08d9143e1892%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637563079204768525%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DefCxiLv4J5KWmoKqy1geARlt%2FJppT1eetVI3R%2FMNfzw%3D&amp;reserved=3D0

--_000_CH0PR12MB51566D5C493563D084E82CE3F8529CH0PR12MB5156namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader4d111418, li.msipheader4d111418, div.msipheader4d111418
	{mso-style-name:msipheader4d111418;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader4d111418" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Done. UMR patch sent out.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Tom,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please help review it to bring the umr part back.<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks in advance!<o:p></o:p></p>
<p class=3D"MsoNormal">Jiawei<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Tuesday, May 11, 2021 9:16 PM<br>
<b>To:</b> Gu, JiaWei (Will) &lt;JiaWei.Gu@amd.com&gt;; amd-gfx@lists.freed=
esktop.org<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;; keescook@chromium.org;=
 Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Field type update in drm_amdgpu_inf=
o_vbios<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Please =
update the umr patch as well.&nbsp;
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Acked-b=
y: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander.=
deucher@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Jiawei Gu &lt;<a href=3D"mailto:Jiawei.Gu@amd.com">Jiawei.Gu@amd.com</a>&=
gt;<br>
<b>Sent:</b> Tuesday, May 11, 2021 1:31 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> StDenis, Tom &lt;<a href=3D"mailto:Tom.StDenis@amd.com">Tom.StDe=
nis@amd.com</a>&gt;; Gu, JiaWei (Will) &lt;<a href=3D"mailto:JiaWei.Gu@amd.=
com">JiaWei.Gu@amd.com</a>&gt;;
<a href=3D"mailto:keescook@chromium.org">keescook@chromium.org</a> &lt;<a h=
ref=3D"mailto:keescook@chromium.org">keescook@chromium.org</a>&gt;; Nieto, =
David M &lt;<a href=3D"mailto:David.Nieto@amd.com">David.Nieto@amd.com</a>&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Field type update in drm_amdgpu_info_vb=
ios</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">Use numeric type serial in drm_amdgpu_info_vbios ins=
tead.<br>
<br>
Signed-off-by: Jiawei Gu &lt;<a href=3D"mailto:Jiawei.Gu@amd.com">Jiawei.Gu=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-<br>
&nbsp;include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; | 2 +-<br>
&nbsp;2 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 75f34a9008e7..e1008a79b441 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -871,7 +871,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcp=
y(vbios_info.vbios_pn, atom_context-&gt;vbios_pn, sizeof(atom_context-&gt;v=
bios_pn));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios=
_info.version =3D atom_context-&gt;version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcp=
y(vbios_info.date, atom_context-&gt;date, sizeof(atom_context-&gt;date));<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_inf=
o.serial, adev-&gt;serial, sizeof(adev-&gt;serial));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.seria=
l =3D adev-&gt;unique_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios=
_info.dev_id =3D adev-&gt;pdev-&gt;device;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios=
_info.rev_id =3D adev-&gt;pdev-&gt;revision;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios=
_info.sub_dev_id =3D atom_context-&gt;sub_dev_id;<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 2b487a8d2727..2d9e84658bbc 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[16];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 serial;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C9c3ad129089d4585544f08d9143e1892%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563079204768525%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DefCxiLv4J5KWmoKqy1geARlt%2FJppT1eetVI3R%2FMNfzw%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7C9c3ad129089d4585544f08d9143e=
1892%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563079204768525%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3DefCxiLv4J5KWmoKqy1geARlt%2FJppT1eetVI3R%2F=
MNfzw%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH0PR12MB51566D5C493563D084E82CE3F8529CH0PR12MB5156namp_--

--===============0115867500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0115867500==--
