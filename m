Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEAEC433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 21:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A37A206FA
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 21:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D4K9aS7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A37A206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0080F6E03F;
	Tue,  1 Sep 2020 21:58:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 438BE6E03F
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 21:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jfg+sL04rSBIPzH7nY6pqugZzZz1xt+rDI9kuQq0QF/1VVpoX6GVAleDleVNPlKLaWB136l8DFj1CEh5WiyrShinhfJdqcKn8ECMK3v56j9zAjtCCqa0FlcoTzH5ZuIBNzMU/qaeEmfUR6pFprIMpdTOvPee6T5BYlF4xbp8Eyd7T+T8g/b7mvt++Mk8NzIJI5w68WdFnk4f0YbxK2GLVJEs4vOz+fOGDYpblE8Lbzkz72nJ0ilkoXBRnLox1g+D3fVNx6Fa5zz4oC3oHOamHREufQQeQvsWtt4KYpDVQPhzvMhb0qSkldeL2k0ZkUUVgzVCjgDbgK61JDguNVLCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgmdr+itktcWpyhvt1t68CB7VDshZEOMvtUahLO6eA8=;
 b=ioB9LApKpBzD24rNb5qfDj9hoDSE2W1oOvmjAYqnMjIFhG+oTgONL6x6neoe8gatwmfcH3cjG1yenVphPxT4NTGUhEFO0kFwvu0AtcNy19F4eCvAmylT6/jcQEYW0EMrCUF+VveqUAR2Ggs+xjSrAYgHMOxMXFxh0kbFzAZeev/rNf52uOoaaIalpUIedOyeRGyePnA3No6mSMDVWWIMCNFhLGYTn04a5jrg/NePOoS5GSZqQNbfN+Lr9MSbPQd8gTI5DidYXHikQpWLfIAVA0/WH8H5uFoyLHtLtvnjQlddUZGCGJyG5Dpf6fS8gyxdm5nrPA7I6QzDs5WyUcc+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgmdr+itktcWpyhvt1t68CB7VDshZEOMvtUahLO6eA8=;
 b=D4K9aS7D6YokY5HavEgB5pQxBWvrpk2mglto574Tsh915Pz5zOQDzcqUDEkR5Ko6Al5hISJvIsAESxnb98XVrroaiWnsHqch5uQHE2v1VT/8AGWWJXYu9Ue4Xm7HQk92bMmu1KjPP9eZnfBZU/CcdmsjwII/I4X9EJAxBBNDjJE=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN6PR12MB2624.namprd12.prod.outlook.com (2603:10b6:805:70::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 1 Sep
 2020 21:58:23 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 21:58:23 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a redundant kfree
Thread-Topic: [PATCH] drm/amdgpu: Fix a redundant kfree
Thread-Index: AdaAM8FOrTvEfqviRDOZEE5pxC7W1gANiK8AAA1i+AAAAoTSnA==
Date: Tue, 1 Sep 2020 21:58:23 +0000
Message-ID: <SN1PR12MB2558752751F38DDD46B59AD8872E0@SN1PR12MB2558.namprd12.prod.outlook.com>
References: <SN1PR12MB25588CE66B9F67BBAED67655872E0@SN1PR12MB2558.namprd12.prod.outlook.com>
 <CADnq5_NPNR2OAekTndORuKpzTP13Tx_KMNcnKLG8jB8O9fw8og@mail.gmail.com>,
 <93da33fe-3157-3267-098d-4c4726b8cff3@amd.com>
In-Reply-To: <93da33fe-3157-3267-098d-4c4726b8cff3@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-01T21:47:38.8190836Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.192.234.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92a8bd3d-be6f-4eef-4321-08d84ec225a5
x-ms-traffictypediagnostic: SN6PR12MB2624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2624E5C33EEAB4901D035D2A872E0@SN6PR12MB2624.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H4XgoHYBW/zPp6J6GrjSGXOEI7FEhAxJ56tOjMJoza6RfuFJVxneNYdfz2AprxGw9hCUGBpCglsGu30X5fyC9c4bCVRpy5HgK66u9GcBDP+oFrUQsAzCWjwfm05rGwTmm8FDJ05EB7uhgmT0b2voNKyPx0HgfPD1E91s+Kvz/34c5TAarBfE9VMi37pXamT4rRdHr2gV+qPqldZGCFcUHaEvesAEIR0aMPzIviFNhJkroEHh525ZvPnN9CRNWMj8H4FqBpKVY2AaPoPfHNY5g3+wyaeSTutucrmlaTpN/YiduLDznKxXArDJ5QpXsNXxehX23eXs6sqUCA4BQ6IJeBj/sYf94yIKLWirxF31Q4w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(71200400001)(478600001)(966005)(8936002)(110136005)(33656002)(55016002)(9686003)(8676002)(6636002)(166002)(52536014)(54906003)(66556008)(66476007)(64756008)(66946007)(76116006)(91956017)(66446008)(45080400002)(2906002)(186003)(6506007)(86362001)(5660300002)(83380400001)(53546011)(4326008)(26005)(316002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: COEAeWlWTmf6kvumBruplhi3HJ00Jn+txpcvn2NOI7iRHTJcyK/VoPF2duIR7VLdhYZFKonqw4W3LdIGQjXdev+5eSdSq8bHaq2lfEtRb13hbQofb7kjJHwFLvfkerQGyom6YN4RlkGVQeRNENHNYJoSOrcfcRE810tNPGLeV1pxZvjHHBJLhGUKcTbp1sSbz0lGXLyuPudIUM9whar41ixOThJzPANKqojl3yPtG7DLJ9doW0X0YjruIv32HjhZyzu2B5bBBsrBd3kESadVqKtRsH3g0DuXyaV3M2BNBB8g80lJlrzl0OpeXGzuSstWwUj9CN8LDQdnxdidj5wvyWbfBi5zRckOiwOuSf516prnaoELZN+zvVKdM47TqYh3nyvnMMdQkp0J/rI6fyJ9wQR4n6ElF1E0oMhpQLQ/a/2+QyOt3yJ6jGZkkKZ5o4q2zgmjpIpGV/wra41tpWtD+qpXnsASvpJBGMKGBvzXOzO/opXtLcYq9rSmF3Eq91qouRjUxi7s3mMvIi2Y5Ji06HmcBw19OAKWhVj50Z57bj6rtIgRNEoiS9UJn8ctoygSkwQ/o8fglLkW2+iG9GDctK3zJU8q59AscWL86j/ObHD7BntUHhHjbiuTTPuyybvckjSiyHToB3wRE0VGrYLrvQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a8bd3d-be6f-4eef-4321-08d84ec225a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 21:58:23.3715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvh7sSThn03idpYWS/mwVHDBsjb0GkwmCdEsBL2uRPmVkYlv+cSbUVibTjq1IgyA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2624
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
Content-Type: multipart/mixed; boundary="===============0057259688=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0057259688==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB2558752751F38DDD46B59AD8872E0SN1PR12MB2558namp_"

--_000_SN1PR12MB2558752751F38DDD46B59AD8872E0SN1PR12MB2558namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


The correct thing to do this is to
_leave the amdgpu_driver_release()_ alone,
remove "drmm_add_final_kfree()" and qualify
the WARN_ON() in drm_dev_register() by
the existence of drm_driver.release() (i.e. non-NULL).

Re:  this drm driver release callback is more like a release notify. It is =
called in the beginning of the total release sequence. As you have made drm=
 device a member of adev. So you can not free adev in the driver release ca=
llback.

Maybe change the sequence of release,  say, put drm driver release in the e=
nd of total release sequence.
Or still use the final_kfree to free adev and our release callback just do =
some other cleanup work.
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, September 2, 2020 4:35:32 AM
To: Alex Deucher <alexdeucher@gmail.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;=
 Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a redundant kfree

On 2020-09-01 10:12 a.m., Alex Deucher wrote:
> On Tue, Sep 1, 2020 at 3:46 AM Pan, Xinhui <Xinhui.Pan@amd.com> wrote:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> drm_dev_alloc() alloc *dev* and set managed.final_kfree to dev to free
>> itself.
>> Now from commit 5cdd68498918("drm/amdgpu: Embed drm_device into
>> amdgpu_device (v3)") we alloc *adev* and ddev is just a member of it.
>> So drm_dev_release try to free a wrong pointer then.
>>
>> Also driver's release trys to free adev, but drm_dev_release will
>> access dev after call drvier's release.
>>
>> To fix it, remove driver's release and set managed.final_kfree to adev.
>
> I've got to admit, the documentation around drm_dev_init is hard to
> follow.  We aren't really using the drmm stuff, but you have to use
> drmm_add_final_kfree to avoid a warning.  The logic seems to make
> sense though.
> Acked-by: Alex Deucher <alexancer.deucher@amd.com>

The logic in patch 3/3 uses the kref infrastructure
as described in drm_drv.c's comment on what the DRM
usage is, i.e. taking advantage of the kref infrastructure.

In amdgpu_pci_probe() we call drm_dev_init() which takes
a ref of 1 on the kref in the DRM device structure,
and from then on, only when the kref transitions
from non-zero to 0, do we free the container of
DRM device, and this is beautifully shown in the
kernel stack below (please take a look at the kernel
stack below).

Using a kref is very powerful as it is implicit:
when the kref transitions from non-zero to 0,
then call the release method.

Furthermore, we own the release method, and we
like that, as it is pure, as well as,
there may be more things we'd like to do in the future
before we free the amdgpu device: maybe free memory we're
using specifically for that PCI device, maybe write
some registers, maybe notify someone or something, etc.

On another note, adding "drmm_add_final_kfree()" in the middle
of amdgpu_pci_probe() seems hackish--it's neither part
of drm_dev_init() nor of drm_dev_register(). We really
don't need it, since we rely on the kref infrastructure
to tell us when to free the device, and if you'd look
at the beautiful stack below, it knows exactly when that is,
i.e. when to free it.

The correct thing to do this is to
_leave the amdgpu_driver_release()_ alone,
remove "drmm_add_final_kfree()" and qualify
the WARN_ON() in drm_dev_register() by
the existence of drm_driver.release() (i.e. non-NULL).

I'll submit a sequence of patches to fix this right.

Regards,
Luben

>
>>
>> [   36.269348] BUG: unable to handle page fault for address: ffffa0c2799=
40028
>> [   36.276841] #PF: supervisor read access in kernel mode
>> [   36.282434] #PF: error_code(0x0000) - not-present page
>> [   36.288053] PGD 676601067 P4D 676601067 PUD 86a414067 PMD 86a247067 P=
TE 800ffff8066bf060
>> [   36.296868] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
>> [   36.302409] CPU: 4 PID: 1375 Comm: bash Tainted: G           O      5=
.9.0-rc2+ #46
>> [   36.310670] Hardware name: System manufacturer System Product Name/PR=
IME Z390-A, BIOS 1401 11/26/2019
>> [   36.320725] RIP: 0010:drm_managed_release+0x25/0x110 [drm]
>> [   36.326741] Code: 80 00 00 00 00 0f 1f 44 00 00 55 48 c7 c2 5a 9f 41 =
c0 be 00 02 00 00 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53 48 83 ec 08 =
<48> 8b 7f 18 e8 c2 10 ff ff 4d 8b 74 24 20 49 8d 44 24 5
>> [   36.347217] RSP: 0018:ffffb9424141fce0 EFLAGS: 00010282
>> [   36.352931] RAX: 0000000000000006 RBX: ffffa0c279940010 RCX: 00000000=
00000006
>> [   36.360718] RDX: ffffffffc0419f5a RSI: 0000000000000200 RDI: ffffa0c2=
79940010
>> [   36.368503] RBP: ffffb9424141fd10 R08: 0000000000000001 R09: 00000000=
00000001
>> [   36.376304] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa0c2=
79940010
>> [   36.384070] R13: ffffffffc0e2a000 R14: ffffa0c26924e220 R15: ffffffff=
fffffff2
>> [   36.391845] FS:  00007fc4a277b740(0000) GS:ffffa0c288e00000(0000) knl=
GS:0000000000000000
>> [   36.400669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   36.406937] CR2: ffffa0c279940028 CR3: 0000000792304006 CR4: 00000000=
003706e0
>> [   36.414732] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
>> [   36.422550] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
>> [   36.430354] Call Trace:
>> [   36.433044]  drm_dev_put.part.0+0x40/0x60 [drm]
>> [   36.438017]  drm_dev_put+0x13/0x20 [drm]
>> [   36.442398]  amdgpu_pci_remove+0x56/0x60 [amdgpu]
>> [   36.447528]  pci_device_remove+0x3e/0xb0
>> [   36.451807]  device_release_driver_internal+0xff/0x1d0
>> [   36.457416]  device_release_driver+0x12/0x20
>> [   36.462094]  pci_stop_bus_device+0x70/0xa0
>> [   36.466588]  pci_stop_and_remove_bus_device_locked+0x1b/0x30
>> [   36.472786]  remove_store+0x7b/0x90
>> [   36.476614]  dev_attr_store+0x17/0x30
>> [   36.480646]  sysfs_kf_write+0x4b/0x60
>> [   36.484655]  kernfs_fop_write+0xe8/0x1d0
>> [   36.488952]  vfs_write+0xf5/0x230
>> [   36.492562]  ksys_write+0x70/0xf0
>> [   36.496206]  __x64_sys_write+0x1a/0x20
>> [   36.500292]  do_syscall_64+0x38/0x90
>> [   36.504219]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +---------
>>  1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_drv.c
>> index c12e9acd421d..52fc0c6c8538 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -1165,7 +1165,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>>  if (ret)
>>  goto err_free;
>>
>> -drmm_add_final_kfree(ddev, ddev);
>> +drmm_add_final_kfree(ddev, adev);
>>
>>  if (!supports_atomic)
>>  ddev->driver_features &=3D ~DRIVER_ATOMIC;
>> @@ -1221,13 +1221,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>>  drm_dev_put(dev);
>>  }
>>
>> -static void amdgpu_driver_release(struct drm_device *ddev)
>> -{
>> -struct amdgpu_device *adev =3D drm_to_adev(ddev);
>> -
>> -kfree(adev);
>> -}
>> -
>>  static void
>>  amdgpu_pci_shutdown(struct pci_dev *pdev)
>>  {
>> @@ -1522,7 +1515,6 @@ static struct drm_driver kms_driver =3D {
>>  .open =3D amdgpu_driver_open_kms,
>>  .postclose =3D amdgpu_driver_postclose_kms,
>>  .lastclose =3D amdgpu_driver_lastclose_kms,
>> -.release   =3D amdgpu_driver_release,
>>  .irq_handler =3D amdgpu_irq_handler,
>>  .ioctls =3D amdgpu_ioctls_kms,
>>  .gem_free_object_unlocked =3D amdgpu_gem_object_free,
>> --
>> 2.25.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist=
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CLuben=
.Tuikov%40amd.com%7C5233b0caaac449417a7208d84e810de0%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637345663485193534&amp;sdata=3DA%2FzJpoQmUhGBGts5mQf=
p%2BlVu1FL5NVbe5qfRelb2Og8%3D&amp;reserved=3D0


--_000_SN1PR12MB2558752751F38DDD46B59AD8872E0SN1PR12MB2558namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
The correct thing to do this is to<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
_leave the amdgpu_driver_release()_ alone,<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
remove &quot;drmm_add_final_kfree()&quot; and qualify<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
the WARN_ON() in drm_dev_register() by<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
the existence of drm_driver.release() (i.e. non-NULL).<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Re:&nbsp; this drm driver release callback is more like a release notify. I=
t is called in the beginning of the total release sequence. As you have mad=
e drm device a member of adev. So you can not free adev in the driver relea=
se callback.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Maybe change the sequence of release,&nbsp; say, put drm driver release in =
the end of total release sequence.
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Or still use the final_kfree to free adev and our release callback just do =
some other cleanup work.</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 2, 2020 4:35:32 AM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Pan, Xinhui &lt;Xinh=
ui.Pan@amd.com&gt;; Daniel Vetter &lt;daniel.vetter@ffwll.ch&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix a redundant kfree</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2020-09-01 10:12 a.m., Alex Deucher wrote:<br>
&gt; On Tue, Sep 1, 2020 at 3:46 AM Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt; =
wrote:<br>
&gt;&gt;<br>
&gt;&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt;&gt;<br>
&gt;&gt; drm_dev_alloc() alloc *dev* and set managed.final_kfree to dev to =
free<br>
&gt;&gt; itself.<br>
&gt;&gt; Now from commit 5cdd68498918(&quot;drm/amdgpu: Embed drm_device in=
to<br>
&gt;&gt; amdgpu_device (v3)&quot;) we alloc *adev* and ddev is just a membe=
r of it.<br>
&gt;&gt; So drm_dev_release try to free a wrong pointer then.<br>
&gt;&gt;<br>
&gt;&gt; Also driver's release trys to free adev, but drm_dev_release will<=
br>
&gt;&gt; access dev after call drvier's release.<br>
&gt;&gt;<br>
&gt;&gt; To fix it, remove driver's release and set managed.final_kfree to =
adev.<br>
&gt; <br>
&gt; I've got to admit, the documentation around drm_dev_init is hard to<br=
>
&gt; follow.&nbsp; We aren't really using the drmm stuff, but you have to u=
se<br>
&gt; drmm_add_final_kfree to avoid a warning.&nbsp; The logic seems to make=
<br>
&gt; sense though.<br>
&gt; Acked-by: Alex Deucher &lt;alexancer.deucher@amd.com&gt;<br>
<br>
The logic in patch 3/3 uses the kref infrastructure<br>
as described in drm_drv.c's comment on what the DRM<br>
usage is, i.e. taking advantage of the kref infrastructure.<br>
<br>
In amdgpu_pci_probe() we call drm_dev_init() which takes<br>
a ref of 1 on the kref in the DRM device structure,<br>
and from then on, only when the kref transitions<br>
from non-zero to 0, do we free the container of<br>
DRM device, and this is beautifully shown in the<br>
kernel stack below (please take a look at the kernel<br>
stack below).<br>
<br>
Using a kref is very powerful as it is implicit:<br>
when the kref transitions from non-zero to 0,<br>
then call the release method.<br>
<br>
Furthermore, we own the release method, and we<br>
like that, as it is pure, as well as,<br>
there may be more things we'd like to do in the future<br>
before we free the amdgpu device: maybe free memory we're<br>
using specifically for that PCI device, maybe write<br>
some registers, maybe notify someone or something, etc.<br>
<br>
On another note, adding &quot;drmm_add_final_kfree()&quot; in the middle<br=
>
of amdgpu_pci_probe() seems hackish--it's neither part<br>
of drm_dev_init() nor of drm_dev_register(). We really<br>
don't need it, since we rely on the kref infrastructure<br>
to tell us when to free the device, and if you'd look<br>
at the beautiful stack below, it knows exactly when that is,<br>
i.e. when to free it.<br>
<br>
The correct thing to do this is to<br>
_leave the amdgpu_driver_release()_ alone,<br>
remove &quot;drmm_add_final_kfree()&quot; and qualify<br>
the WARN_ON() in drm_dev_register() by<br>
the existence of drm_driver.release() (i.e. non-NULL).<br>
<br>
I'll submit a sequence of patches to fix this right.<br>
<br>
Regards,<br>
Luben<br>
<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; [&nbsp;&nbsp; 36.269348] BUG: unable to handle page fault for addr=
ess: ffffa0c279940028<br>
&gt;&gt; [&nbsp;&nbsp; 36.276841] #PF: supervisor read access in kernel mod=
e<br>
&gt;&gt; [&nbsp;&nbsp; 36.282434] #PF: error_code(0x0000) - not-present pag=
e<br>
&gt;&gt; [&nbsp;&nbsp; 36.288053] PGD 676601067 P4D 676601067 PUD 86a414067=
 PMD 86a247067 PTE 800ffff8066bf060<br>
&gt;&gt; [&nbsp;&nbsp; 36.296868] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI=
<br>
&gt;&gt; [&nbsp;&nbsp; 36.302409] CPU: 4 PID: 1375 Comm: bash Tainted: G&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; O&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 5.9.0-rc2+ #46<br>
&gt;&gt; [&nbsp;&nbsp; 36.310670] Hardware name: System manufacturer System=
 Product Name/PRIME Z390-A, BIOS 1401 11/26/2019<br>
&gt;&gt; [&nbsp;&nbsp; 36.320725] RIP: 0010:drm_managed_release+0x25/0x110 =
[drm]<br>
&gt;&gt; [&nbsp;&nbsp; 36.326741] Code: 80 00 00 00 00 0f 1f 44 00 00 55 48=
 c7 c2 5a 9f 41 c0 be 00 02 00 00 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc=
 53 48 83 ec 08 &lt;48&gt; 8b 7f 18 e8 c2 10 ff ff 4d 8b 74 24 20 49 8d 44 =
24 5<br>
&gt;&gt; [&nbsp;&nbsp; 36.347217] RSP: 0018:ffffb9424141fce0 EFLAGS: 000102=
82<br>
&gt;&gt; [&nbsp;&nbsp; 36.352931] RAX: 0000000000000006 RBX: ffffa0c2799400=
10 RCX: 0000000000000006<br>
&gt;&gt; [&nbsp;&nbsp; 36.360718] RDX: ffffffffc0419f5a RSI: 00000000000002=
00 RDI: ffffa0c279940010<br>
&gt;&gt; [&nbsp;&nbsp; 36.368503] RBP: ffffb9424141fd10 R08: 00000000000000=
01 R09: 0000000000000001<br>
&gt;&gt; [&nbsp;&nbsp; 36.376304] R10: 0000000000000000 R11: 00000000000000=
00 R12: ffffa0c279940010<br>
&gt;&gt; [&nbsp;&nbsp; 36.384070] R13: ffffffffc0e2a000 R14: ffffa0c26924e2=
20 R15: fffffffffffffff2<br>
&gt;&gt; [&nbsp;&nbsp; 36.391845] FS:&nbsp; 00007fc4a277b740(0000) GS:ffffa=
0c288e00000(0000) knlGS:0000000000000000<br>
&gt;&gt; [&nbsp;&nbsp; 36.400669] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033<br>
&gt;&gt; [&nbsp;&nbsp; 36.406937] CR2: ffffa0c279940028 CR3: 00000007923040=
06 CR4: 00000000003706e0<br>
&gt;&gt; [&nbsp;&nbsp; 36.414732] DR0: 0000000000000000 DR1: 00000000000000=
00 DR2: 0000000000000000<br>
&gt;&gt; [&nbsp;&nbsp; 36.422550] DR3: 0000000000000000 DR6: 00000000fffe0f=
f0 DR7: 0000000000000400<br>
&gt;&gt; [&nbsp;&nbsp; 36.430354] Call Trace:<br>
&gt;&gt; [&nbsp;&nbsp; 36.433044]&nbsp; drm_dev_put.part.0+0x40/0x60 [drm]<=
br>
&gt;&gt; [&nbsp;&nbsp; 36.438017]&nbsp; drm_dev_put+0x13/0x20 [drm]<br>
&gt;&gt; [&nbsp;&nbsp; 36.442398]&nbsp; amdgpu_pci_remove+0x56/0x60 [amdgpu=
]<br>
&gt;&gt; [&nbsp;&nbsp; 36.447528]&nbsp; pci_device_remove+0x3e/0xb0<br>
&gt;&gt; [&nbsp;&nbsp; 36.451807]&nbsp; device_release_driver_internal+0xff=
/0x1d0<br>
&gt;&gt; [&nbsp;&nbsp; 36.457416]&nbsp; device_release_driver+0x12/0x20<br>
&gt;&gt; [&nbsp;&nbsp; 36.462094]&nbsp; pci_stop_bus_device+0x70/0xa0<br>
&gt;&gt; [&nbsp;&nbsp; 36.466588]&nbsp; pci_stop_and_remove_bus_device_lock=
ed+0x1b/0x30<br>
&gt;&gt; [&nbsp;&nbsp; 36.472786]&nbsp; remove_store+0x7b/0x90<br>
&gt;&gt; [&nbsp;&nbsp; 36.476614]&nbsp; dev_attr_store+0x17/0x30<br>
&gt;&gt; [&nbsp;&nbsp; 36.480646]&nbsp; sysfs_kf_write+0x4b/0x60<br>
&gt;&gt; [&nbsp;&nbsp; 36.484655]&nbsp; kernfs_fop_write+0xe8/0x1d0<br>
&gt;&gt; [&nbsp;&nbsp; 36.488952]&nbsp; vfs_write+0xf5/0x230<br>
&gt;&gt; [&nbsp;&nbsp; 36.492562]&nbsp; ksys_write+0x70/0xf0<br>
&gt;&gt; [&nbsp;&nbsp; 36.496206]&nbsp; __x64_sys_write+0x1a/0x20<br>
&gt;&gt; [&nbsp;&nbsp; 36.500292]&nbsp; do_syscall_64+0x38/0x90<br>
&gt;&gt; [&nbsp;&nbsp; 36.504219]&nbsp; entry_SYSCALL_64_after_hwframe+0x44=
/0xa9<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +---------<br>
&gt;&gt;&nbsp; 1 file changed, 1 insertion(+), 9 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; index c12e9acd421d..52fc0c6c8538 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; @@ -1165,7 +1165,7 @@ static int amdgpu_pci_probe(struct pci_dev *=
pdev,<br>
&gt;&gt;&nbsp; if (ret)<br>
&gt;&gt;&nbsp; goto err_free;<br>
&gt;&gt;<br>
&gt;&gt; -drmm_add_final_kfree(ddev, ddev);<br>
&gt;&gt; +drmm_add_final_kfree(ddev, adev);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; if (!supports_atomic)<br>
&gt;&gt;&nbsp; ddev-&gt;driver_features &amp;=3D ~DRIVER_ATOMIC;<br>
&gt;&gt; @@ -1221,13 +1221,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)<br>
&gt;&gt;&nbsp; drm_dev_put(dev);<br>
&gt;&gt;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; -static void amdgpu_driver_release(struct drm_device *ddev)<br>
&gt;&gt; -{<br>
&gt;&gt; -struct amdgpu_device *adev =3D drm_to_adev(ddev);<br>
&gt;&gt; -<br>
&gt;&gt; -kfree(adev);<br>
&gt;&gt; -}<br>
&gt;&gt; -<br>
&gt;&gt;&nbsp; static void<br>
&gt;&gt;&nbsp; amdgpu_pci_shutdown(struct pci_dev *pdev)<br>
&gt;&gt;&nbsp; {<br>
&gt;&gt; @@ -1522,7 +1515,6 @@ static struct drm_driver kms_driver =3D {<br=
>
&gt;&gt;&nbsp; .open =3D amdgpu_driver_open_kms,<br>
&gt;&gt;&nbsp; .postclose =3D amdgpu_driver_postclose_kms,<br>
&gt;&gt;&nbsp; .lastclose =3D amdgpu_driver_lastclose_kms,<br>
&gt;&gt; -.release&nbsp;&nbsp; =3D amdgpu_driver_release,<br>
&gt;&gt;&nbsp; .irq_handler =3D amdgpu_irq_handler,<br>
&gt;&gt;&nbsp; .ioctls =3D amdgpu_ioctls_kms,<br>
&gt;&gt;&nbsp; .gem_free_object_unlocked =3D amdgpu_gem_object_free,<br>
&gt;&gt; --<br>
&gt;&gt; 2.25.1<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx@lists.freedesktop.org<br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;d=
ata=3D02%7C01%7CLuben.Tuikov%40amd.com%7C5233b0caaac449417a7208d84e810de0%7=
C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637345663485193534&amp;amp;sdat=
a=3DA%2FzJpoQmUhGBGts5mQfp%2BlVu1FL5NVbe5qfRelb2Og8%3D&amp;amp;reserved=3D0=
">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CLube=
n.Tuikov%40amd.com%7C5233b0caaac449417a7208d84e810de0%7C3dd8961fe4884e608e1=
1a82d994e183d%7C0%7C0%7C637345663485193534&amp;amp;sdata=3DA%2FzJpoQmUhGBGt=
s5mQfp%2BlVu1FL5NVbe5qfRelb2Og8%3D&amp;amp;reserved=3D0</a><br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SN1PR12MB2558752751F38DDD46B59AD8872E0SN1PR12MB2558namp_--

--===============0057259688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0057259688==--
