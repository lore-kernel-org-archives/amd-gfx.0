Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB89C35DF8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 07:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBA82176D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 07:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BksZnk8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBA82176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA25E6E9EC;
	Tue, 25 Feb 2020 07:20:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D186E6E9EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 07:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZJ5M/DnioaqyG7ttdKLv/yeGKyiTHct3ccQsHeoHdxgUEEgStBClnDpJtj+ebvxmkEiiFxDSNyAdbn2YVT5+TLYhvWb+8oS5SQ5uG5MbbByzgNehL+wIE37ZwHoUNQ85bwPRCeP/5BZ4pkMxxlMoCmpPJXUcXjSAoMxpm/2oVFj/kmvJxB2L0a+bZzwo9Njjk0I3CgHcs11WpYxjCVduQ7OdqjkaTRSOqp8FRBMEZ/fpEKhRuv5PbaKSwdTSDtYj8hPQjrz2lCg9NqmrX5v9D5pfFFdkyRB2kXEE5C0U23jh6tbWV81cPwif9uX3QdjLF2jsF0grA/UiqTep4UeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzKsuVO5SwUnignzbQJZ9MDlZf2xtNjN+fcpPZHQYiA=;
 b=HNFUbNCvWyRDiXZ8Hae0luqu7OYiNNcYObf+h0Cf3v0aJrR13Iiijf4ApVKJV3H29FEtGz26rnieh5aIpj2E6Pe4EmKdx5DkfhJnPr291KjP2FO4lHE7LFeX0/RSiOVWf0gslgLdYcgZrJKtqf6MsnCo4Jc3lslad5kXlEOjQYTT5fSz8Q3S9jnkqeWM+IigLZBiKo18XKY9o5gANwM56iVdvlAW8QoWYRpBOHjpC3kfX51lfYfMkQTA5GWmn0N5BaIbzVKvLDZOGw1Ef4msRp3Yl8ZQmaRgsLYGqt4JzZoHu/kK5VnotcOLxrOu4OrWY6hz02ywQSOvGcGIb3b/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzKsuVO5SwUnignzbQJZ9MDlZf2xtNjN+fcpPZHQYiA=;
 b=BksZnk8wO1mNPBhlil5S0ZIgB7i+Jvw2MIMz8e44eNDXsMORgRzUdESX3s17ddIesiCvTzy3Lq/18uoezCSQV2X7Z/DS/ydn+pmcdikA6IsBq8rntbkr0UMPeMWBl42uvh5Ipco7RQ1LJorSOUaWjLjrg3g5xv5srSSoApBa0pw=
Received: from MN2PR12MB3376.namprd12.prod.outlook.com (2603:10b6:208:c2::20)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 07:20:25 +0000
Received: from MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b]) by MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 07:20:25 +0000
From: "He, Jacob" <Jacob.He@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)"
 <David1.Zhou@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?Windows-1252?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
Thread-Topic: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
Thread-Index: AQHV5w2DvZzJMh9mOEKuDtk7HI5K26giWh+AgAD+jICAAIeEWoAARXoxgAANbQCAAUIpgIAAVIEAgAAAqICAABQkAIAEJEFagAC16ACAAMV8Mg==
Date: Tue, 25 Feb 2020 07:20:24 +0000
Message-ID: <MN2PR12MB33767BD7E9FFEEAEBE0E14CE9BED0@MN2PR12MB3376.namprd12.prod.outlook.com>
References: <20200219101506.16779-1-jacob.he@amd.com>
 <e2fea4f5-0eea-75b5-9cd7-68b603629d8d@gmail.com>
 <MWHPR12MB1406B3418562F0692572C511B4130@MWHPR12MB1406.namprd12.prod.outlook.com>
 <MN2PR12MB337663C5CCF3D53744FD377D9B130@MN2PR12MB3376.namprd12.prod.outlook.com>
 <MN2PR12MB3376E699E0A85E8065D3E72D9B130@MN2PR12MB3376.namprd12.prod.outlook.com>
 <MWHPR12MB140699AA6711A7E6876C56E5B4130@MWHPR12MB1406.namprd12.prod.outlook.com>
 <e09919bf-f084-55ed-04a7-f52bec5b0be9@gmail.com>
 <CH2PR12MB3912AE29A4EBF30B5826CCC2F7120@CH2PR12MB3912.namprd12.prod.outlook.com>
 <1b15e97e-2a19-70dc-d9da-672e337e2d15@amd.com>
 <MWHPR12MB1406BBDF0726D961289869E8B4120@MWHPR12MB1406.namprd12.prod.outlook.com>
 <MN2PR12MB3376E7269CCC628EA0FCCB879BEC0@MN2PR12MB3376.namprd12.prod.outlook.com>,
 <a1ffa641-5183-3bac-7c3a-9945bdb2f132@amd.com>
In-Reply-To: <a1ffa641-5183-3bac-7c3a-9945bdb2f132@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-25T06:38:11.4530854Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jacob.He@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27f84676-4dfe-4f37-a45b-08d7b9c32f08
x-ms-traffictypediagnostic: MN2PR12MB4126:|MN2PR12MB4126:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41268FD77B9D420E0F07A6539BED0@MN2PR12MB4126.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(66574012)(966005)(53546011)(478600001)(45080400002)(2906002)(33656002)(86362001)(316002)(5660300002)(66556008)(66476007)(66616009)(9686003)(7696005)(66446008)(26005)(8936002)(186003)(76116006)(55016002)(81166006)(8676002)(71200400001)(6506007)(66946007)(52536014)(30864003)(110136005)(91956017)(64756008)(81156014)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4126;
 H:MN2PR12MB3376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lFzUE16WBMybMXYYlYl/GNyUBuDFP213vdpcr3eAPJ10pF1ljJVlNIh/tFHS91IOLldbMBynZRPo7opOeeeDvideQQgXJ9pGqYIN0Fsq0Cwe2nhnJl4sV3uonrko75KMML+9tqNc9jO84uiyjS5I6Y21BzTqkwM795Ar3l5emAjbvtPb6J/l9sYZE13Lmh7ofGIPeRKrkyUw1iqAhmh+Md35EXFimPR2+opBbzpfY8SaRUMJhjHtp+b3Ul8U8GwzpqhZB2qg/Pd0ZJoSz59wtUpn6/Oco10Yh7Zm8a8B++/UKBywG2R5hIFmkQvkOpXITv9+BbECgJnSn/Yz3jHx9D+24teNp/2oDiVdbAdaSxY9lUdFzE/mHaBApvXie9IxISKy7O0y90UiTBeneN5SGCn5kBMjqnXI+vPPNQ58KKfjkHJni5VfIfg0x1ZwbpOc5ZL5fui2sLa+W1RZupHoUmQ0FOxPGf/hiL7KAYa5pPL6s7ktocO9AZBo4hBvux/N0aApppfMLpSncR9Nujk+BA==
x-ms-exchange-antispam-messagedata: 5FMG1+oWu7exyWJxA+SapUWJUgUPCwNq03TTFaf5TKI+tlRuY9J4QJaly302OcQ2Rh5GigcYbibunr99Awg/gj93mVt1eVQnJrtD420gX65zd3kJsHw9G6ENRpI1IE3KTscaZeoSfooQrEA0jBTeOw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f84676-4dfe-4f37-a45b-08d7b9c32f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 07:20:24.8065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuVU3lZSFQ3jSvn0/Xta4nncwj+allnV+WWxh5GIZmCRMLSH8nizKU28lzy5sYVy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Content-Type: multipart/mixed; boundary="===============0307522820=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0307522820==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_004_MN2PR12MB33767BD7E9FFEEAEBE0E14CE9BED0MN2PR12MB3376namp_";
	type="multipart/alternative"

--_004_MN2PR12MB33767BD7E9FFEEAEBE0E14CE9BED0MN2PR12MB3376namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB33767BD7E9FFEEAEBE0E14CE9BED0MN2PR12MB3376namp_"

--_000_MN2PR12MB33767BD7E9FFEEAEBE0E14CE9BED0MN2PR12MB3376namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Vulkan UMD makes sure that the SPM_VMID will be updated if the application =
enables the SPM. So there is no this kind of problem for Vulkan application=
. It=92s kind of =93atomic=94 operation to enable SPM and update SPM_VMID. =
Vulkan application even is not aware of SPM_VMID.
If there is any other UMD applications, such as OCL, and OCL driver doesn=
=92t update the SPM_VMID before enable SPM, there is VMFault anyway even Vu=
lkan driver restore the SPM_VMID to 0.

Thanks
Jacob

From: Koenig, Christian<mailto:Christian.Koenig@amd.com>
Sent: Tuesday, February 25, 2020 2:51 AM
To: He, Jacob<mailto:Jacob.He@amd.com>; Zhou, David(ChunMing)<mailto:David1=
.Zhou@amd.com>; Deucher, Alexander<mailto:Alexander.Deucher@amd.com>; Chris=
tian K=F6nig<mailto:ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freede=
sktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace

Leave the old spm_vmid there is not a problem because other new spm enabled=
 job will update it before it=92s running and other spm disabled job will n=
ot access spm_vmid register.
Do you have a high level description of how SPM works? For example would it=
 be possible to cause a problem in another application if we leave the SPM =
VMID here and the VMID is reused?

Keep in mind that we need to guarantee process isolation, e.g. we can't all=
ow anything bad to happen to another application if somebody is stupid enou=
gh to turn on SPM tracing without setting it up properly.

Regards,
Christian.

Am 24.02.20 um 09:06 schrieb He, Jacob:
Ok, I=92m glad that there is no uapi change needed.
I checked the git log, and reserve_vmid was added for shader debugger, not =
gpa. I=92m fine to re-use it since the spm will not enabled for shader debu=
g in general. I=92ll try to change my patch.
BTW, =93ring->funcs->setup_spm(ring, NULL)=94 to clear the vmid is not gonn=
a work since the job with spm enabled execution is not done yet. Leave the =
old spm_vmid there is not a problem because other new spm enabled job will =
update it before it=92s running and other spm disabled job will not access =
spm_vmid register.

Thanks
Jacob

From: Zhou, David(ChunMing)<mailto:David1.Zhou@amd.com>
Sent: Saturday, February 22, 2020 12:45 AM
To: Koenig, Christian<mailto:Christian.Koenig@amd.com>; Deucher, Alexander<=
mailto:Alexander.Deucher@amd.com>; Christian K=F6nig<mailto:ckoenig.leichtz=
umerken@gmail.com>; He, Jacob<mailto:Jacob.He@amd.com>; amd-gfx@lists.freed=
esktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace


[AMD Official Use Only - Internal Distribution Only]

That=92s fine to me.

-David

From: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@=
amd.com>
Sent: Friday, February 21, 2020 11:33 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher=
@amd.com>; Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoe=
nig.leichtzumerken@gmail.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com><=
mailto:David1.Zhou@amd.com>; He, Jacob <Jacob.He@amd.com><mailto:Jacob.He@a=
md.com>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org=
>
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace

I would just do this as part of the vm_flush() callback on the ring.

E.g. check if the VMID you want to flush is reserved and if yes enable SPM.

Maybe pass along a flag or something in the job to make things easier.

Christian.

Am 21.02.20 um 16:31 schrieb Deucher, Alexander:

[AMD Public Use]

We already have the RESERVE_VMID ioctl interface, can't we just use that in=
ternally in the kernel to update the rlc register via the ring when we sche=
dule the relevant IB?  E.g., add a new ring callback to set SPM state and t=
hen set it to the reserved vmid before we schedule the ib, and then reset i=
t to 0 after the IB in amdgpu_ib_schedule().

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ib.c
index 4b2342d11520..e0db9362c6ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -185,6 +185,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsign=
ed num_ibs,
        if (ring->funcs->insert_start)
                ring->funcs->insert_start(ring);

+       if (ring->funcs->setup_spm)
+               ring->funcs->setup_spm(ring, job);
+
        if (job) {
                r =3D amdgpu_vm_flush(ring, job, need_pipe_sync);
                if (r) {
@@ -273,6 +276,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsign=
ed num_ibs,
                return r;
        }

+       if (ring->funcs->setup_spm)
+               ring->funcs->setup_spm(ring, NULL);
+
        if (ring->funcs->insert_end)
                ring->funcs->insert_end(ring);



Alex

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Christian K=F6nig <ckoenig.leichtzume=
rken@gmail.com><mailto:ckoenig.leichtzumerken@gmail.com>
Sent: Friday, February 21, 2020 5:28 AM
To: Zhou, David(ChunMing) <David1.Zhou@amd.com><mailto:David1.Zhou@amd.com>=
; He, Jacob <Jacob.He@amd.com><mailto:Jacob.He@amd.com>; Koenig, Christian =
<Christian.Koenig@amd.com><mailto:Christian.Koenig@amd.com>; amd-gfx@lists.=
freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freede=
sktop.org><mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace

That would probably be a no-go, but we could enhance the kernel driver to u=
pdate the RLC_SPM_VMID register with the reserved VMID.

Handling that in userspace is most likely not working anyway, since the RLC=
 registers are usually not accessible by userspace.

Regards,
Christian.

Am 20.02.20 um 16:15 schrieb Zhou, David(ChunMing):

[AMD Official Use Only - Internal Distribution Only]



You can enhance amdgpu_vm_ioctl In amdgpu_vm.c to return vmid to userspace.



-David





From: He, Jacob <Jacob.He@amd.com><mailto:Jacob.He@amd.com>
Sent: Thursday, February 20, 2020 10:46 PM
To: Zhou, David(ChunMing) <David1.Zhou@amd.com><mailto:David1.Zhou@amd.com>=
; Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@amd.=
com>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace



amdgpu_vm_reserve_vmid doesn=92t return the reserved vmid back to user spac=
e. There is no chance for user mode driver to update RLC_SPM_VMID.



Thanks

Jacob



From: He, Jacob<mailto:Jacob.He@amd.com>
Sent: Thursday, February 20, 2020 6:20 PM
To: Zhou, David(ChunMing)<mailto:David1.Zhou@amd.com>; Koenig, Christian<ma=
ilto:Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org<mailto:amd-gf=
x@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace



Looks like amdgpu_vm_reserve_vmid could work, let me have a try to update t=
he RLC_SPM_VMID with pm4 packets in UMD.



Thanks

Jacob



From: Zhou, David(ChunMing)<mailto:David1.Zhou@amd.com>
Sent: Thursday, February 20, 2020 10:13 AM
To: Koenig, Christian<mailto:Christian.Koenig@amd.com>; He, Jacob<mailto:Ja=
cob.He@amd.com>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedes=
ktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace



[AMD Official Use Only - Internal Distribution Only]

Christian is right here, that will cause many problems for simply using VMI=
D in kernel.
We already have an pair interface for RGP, I think you can use it instead o=
f involving additional kernel change.
amdgpu_vm_reserve_vmid/ amdgpu_vm_unreserve_vmid.

-David

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Christian K=F6nig
Sent: Wednesday, February 19, 2020 7:03 PM
To: He, Jacob <Jacob.He@amd.com<mailto:Jacob.He@amd.com>>; amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace

Am 19.02.20 um 11:15 schrieb Jacob He:
> [WHY]
> When SPM trace enabled, SPM_VMID should be updated with the current
> vmid.
>
> [HOW]
> Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD can tell us
> which job should update SPM_VMID.
> Right before a job is submitted to GPU, set the SPM_VMID accordingly.
>
> [Limitation]
> Running more than one SPM trace enabled processes simultaneously is
> not supported.

Well there are multiple problems with that patch.

First of all you need to better describe what SPM tracing is in the commit =
message.

Then the updating of mmRLC_SPM_MC_CNTL must be executed asynchronously on t=
he ring. Otherwise we might corrupt an already executing SPM trace.

And you also need to make sure to disable the tracing again or otherwise we=
 run into a bunch of trouble when the VMID is reused.

You also need to make sure that IBs using the SPM trace are serialized with=
 each other, e.g. hack into amdgpu_ids.c file and make sure that only one V=
MID at a time can have that attribute.

Regards,
Christian.

>
> Change-Id: Ic932ef6ac9dbf244f03aaee90550e8ff3a675666
> Signed-off-by: Jacob He <jacob.he@amd.com<mailto:jacob.he@amd.com>>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 10 +++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 15 ++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 15 ++++++++++++++-
>   8 files changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index f9fa6e104fef..3f32c4db5232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -113,6 +113,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p, union drm_amdgpu_cs
>        uint32_t uf_offset =3D 0;
>        int i;
>        int ret;
> +     bool update_spm_vmid =3D false;
>
>        if (cs->in.num_chunks =3D=3D 0)
>                return 0;
> @@ -221,6 +222,10 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_pa=
rser *p, union drm_amdgpu_cs
>                case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
>                        break;
>
> +             case AMDGPU_CHUNK_ID_SPM_TRACE:
> +                     update_spm_vmid =3D true;
> +                     break;
> +
>                default:
>                        ret =3D -EINVAL;
>                        goto free_partial_kdata;
> @@ -231,6 +236,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p, union drm_amdgpu_cs
>        if (ret)
>                goto free_all_kdata;
>
> +     p->job->need_update_spm_vmid =3D update_spm_vmid;
> +
>        if (p->ctx->vram_lost_counter !=3D p->job->vram_lost_counter) {
>                ret =3D -ECANCELED;
>                goto free_all_kdata;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index cae81914c821..36faab12b585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -156,9 +156,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, uns=
igned num_ibs,
>                return -EINVAL;
>        }
>
> -     if (vm && !job->vmid) {
> -             dev_err(adev->dev, "VM IB without ID\n");
> -             return -EINVAL;
> +     if (vm) {
> +             if (!job->vmid) {
> +                     dev_err(adev->dev, "VM IB without ID\n");
> +                     return -EINVAL;
> +             } else if (adev->gfx.rlc.funcs->update_spm_vmid && job->nee=
d_update_spm_vmid) {
> +                     adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmi=
d);
> +             }
>        }
>
>        alloc_size =3D ring->funcs->emit_frame_size + num_ibs * diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 2e2110dddb76..4582536961c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -52,6 +52,7 @@ struct amdgpu_job {
>        bool                    vm_needs_flush;
>        uint64_t                vm_pd_addr;
>        unsigned                vmid;
> +     bool                    need_update_spm_vmid;
>        unsigned                pasid;
>        uint32_t                gds_base, gds_size;
>        uint32_t                gws_base, gws_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> index d3d4707f2168..52509c254cbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -126,6 +126,7 @@ struct amdgpu_rlc_funcs {
>        void (*stop)(struct amdgpu_device *adev);
>        void (*reset)(struct amdgpu_device *adev);
>        void (*start)(struct amdgpu_device *adev);
> +     void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
>   };
>
>   struct amdgpu_rlc {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 5e9fb0976c6c..91eb788d6229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4214,6 +4214,18 @@ static int gfx_v10_0_update_gfx_clock_gating(struc=
t amdgpu_device *adev,
>        return 0;
>   }
>
> +static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev,
> +unsigned vmid) {
> +     u32 data;
> +
> +     data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> +
> +     data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
> +     data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) <<
> +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +
> +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }
> +
>   static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs =3D {
>        .is_rlc_enabled =3D gfx_v10_0_is_rlc_enabled,
>        .set_safe_mode =3D gfx_v10_0_set_safe_mode, @@ -4224,7 +4236,8 @@
> static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs =3D {
>        .resume =3D gfx_v10_0_rlc_resume,
>        .stop =3D gfx_v10_0_rlc_stop,
>        .reset =3D gfx_v10_0_rlc_reset,
> -     .start =3D gfx_v10_0_rlc_start
> +     .start =3D gfx_v10_0_rlc_start,
> +     .update_spm_vmid =3D gfx_v10_0_update_spm_vmid
>   };
>
>   static int gfx_v10_0_set_powergating_state(void *handle, diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 8f20a5dd44fe..b24fc55cf13a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4221,7 +4221,8 @@ static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_f=
uncs =3D {
>        .resume =3D gfx_v7_0_rlc_resume,
>        .stop =3D gfx_v7_0_rlc_stop,
>        .reset =3D gfx_v7_0_rlc_reset,
> -     .start =3D gfx_v7_0_rlc_start
> +     .start =3D gfx_v7_0_rlc_start,
> +     .update_spm_vmid =3D NULL
>   };
>
>   static int gfx_v7_0_early_init(void *handle) diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index fa245973de12..66640d2b6b37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5600,7 +5600,8 @@ static const struct amdgpu_rlc_funcs iceland_rlc_fu=
ncs =3D {
>        .resume =3D gfx_v8_0_rlc_resume,
>        .stop =3D gfx_v8_0_rlc_stop,
>        .reset =3D gfx_v8_0_rlc_reset,
> -     .start =3D gfx_v8_0_rlc_start
> +     .start =3D gfx_v8_0_rlc_start,
> +     .update_spm_vmid =3D NULL
>   };
>
>   static void gfx_v8_0_update_medium_grain_clock_gating(struct
> amdgpu_device *adev, diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 9b7ff783e9a5..df872f949f68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4704,6 +4704,18 @@ static int gfx_v9_0_update_gfx_clock_gating(struct=
 amdgpu_device *adev,
>        return 0;
>   }
>
> +static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev,
> +unsigned vmid) {
> +     u32 data;
> +
> +     data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> +
> +     data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
> +     data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) <<
> +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +
> +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }
> +
>   static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =3D {
>        .is_rlc_enabled =3D gfx_v9_0_is_rlc_enabled,
>        .set_safe_mode =3D gfx_v9_0_set_safe_mode, @@ -4715,7 +4727,8 @@
> static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =3D {
>        .resume =3D gfx_v9_0_rlc_resume,
>        .stop =3D gfx_v9_0_rlc_stop,
>        .reset =3D gfx_v9_0_rlc_reset,
> -     .start =3D gfx_v9_0_rlc_start
> +     .start =3D gfx_v9_0_rlc_start,
> +     .update_spm_vmid =3D gfx_v9_0_update_spm_vmid
>   };
>
>   static int gfx_v9_0_set_powergating_state(void *handle,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cdavid1.z=
hou%40amd.com%7C354be34ff18e4f424f6708d7b52b43b0%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637177069753914395&amp;sdata=3D9rSL4kgPJweuZ4EJpdqtqTxyC=
VGEkmsg6aUzbtvGFrs%3D&amp;reserved=3D0<https://nam11.safelinks.protection.o=
utlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%=
2Famd-gfx&data=3D02%7C01%7Calexander.deucher%40amd.com%7Ce68811adba0647c651=
a308d7b6b8d4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178777321057=
824&sdata=3DuRP0wQyfVKk0QoGlWM36nbeOY67nIjfD6vou2A%2BybEc%3D&reserved=3D0>






_______________________________________________

amd-gfx mailing list

amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>

https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D02%7C01%7Calexander.deucher%40amd.com%7Ce6=
8811adba0647c651a308d7b6b8d4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637178777321067823&sdata=3D7o2j5dTvK%2B5Gihwd5IB%2Blp1Bi0ZOx%2B%2F%2Bmi8wp=
Rh4NBs%3D&reserved=3D0>






--_000_MN2PR12MB33767BD7E9FFEEAEBE0E14CE9BED0MN2PR12MB3376namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
@font-face
	{font-family:"Bookman Old Style";
	panose-1:2 5 6 4 5 5 5 2 2 4;}
@font-face
	{font-family:"Bookman Old Style \,serif";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";
	color:black;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.xmsipheader4d0fcdd7, li.xmsipheader4d0fcdd7, div.xmsipheader4d0fcdd7
	{mso-style-name:x_msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"#954F72">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Vulkan UMD makes sure that the SPM_VMID will be upda=
ted if the application enables the SPM. So there is no this kind of problem=
 for Vulkan application. It=92s kind of =93atomic=94 operation to enable SP=
M and update SPM_VMID. Vulkan application
 even is not aware of SPM_VMID.</p>
<p class=3D"MsoNormal">If there is any other UMD applications, such as OCL,=
 and OCL driver doesn=92t update the SPM_VMID before enable SPM, there is V=
MFault anyway even Vulkan driver restore the SPM_VMID to 0.</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Jacob<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"mso-element:para-border-div;border:none;border-top:solid #E1E=
1E1 1.0pt;padding:3.0pt 0in 0in 0in">
<p class=3D"MsoNormal" style=3D"border:none;padding:0in"><b>From: </b><a hr=
ef=3D"mailto:Christian.Koenig@amd.com">Koenig, Christian</a><br>
<b>Sent: </b>Tuesday, February 25, 2020 2:51 AM<br>
<b>To: </b><a href=3D"mailto:Jacob.He@amd.com">He, Jacob</a>; <a href=3D"ma=
ilto:David1.Zhou@amd.com">
Zhou, David(ChunMing)</a>; <a href=3D"mailto:Alexander.Deucher@amd.com">Deu=
cher, Alexander</a>;
<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">Christian K=F6nig</a>; =
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace</p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black">Leave t=
he old spm_vmid there is not a problem because other new spm enabled job wi=
ll update it before it=92s running and other spm disabled job will not acce=
ss spm_vmid register.</span><span style=3D"color:black"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:black">Do you have a high level=
 description of how SPM works? For example would it be possible to cause a =
problem in another application if we leave the SPM VMID here and the VMID i=
s reused?<br>
<br>
Keep in mind that we need to guarantee process isolation, e.g. we can't all=
ow anything bad to happen to another application if somebody is stupid enou=
gh to turn on SPM tracing without setting it up properly.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 24.02.20 um 09:06 schrieb He, Jacob:<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black">Ok, I=
=92m glad that there is no uapi change needed.</span><span style=3D"color:b=
lack"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black">I check=
ed the git log, and reserve_vmid was added for shader debugger, not gpa. I=
=92m fine to re-use it since the spm will not enabled for shader debug in g=
eneral. I=92ll try to change my patch.</span><span style=3D"color:black"><o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black">BTW, =
=93ring-&gt;funcs-&gt;setup_spm(ring, NULL)=94 to clear the vmid is not gon=
na work since the job with spm enabled execution is not done yet. Leave the=
 old spm_vmid there is not a problem because other
 new spm enabled job will update it before it=92s running and other spm dis=
abled job will not access spm_vmid register.</span><span style=3D"color:bla=
ck"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style \,serif&quot;;color:black">Thanks</span><span style=3D"color=
:black"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style \,serif&quot;;color:black">Jacob</span><span style=3D"color:=
black"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From: </span></b><a h=
ref=3D"mailto:David1.Zhou@amd.com">Zhou, David(ChunMing)</a><span style=3D"=
color:black"><br>
<b>Sent: </b>Saturday, February 22, 2020 12:45 AM<br>
<b>To: </b></span><a href=3D"mailto:Christian.Koenig@amd.com">Koenig, Chris=
tian</a><span style=3D"color:black">;
</span><a href=3D"mailto:Alexander.Deucher@amd.com">Deucher, Alexander</a><=
span style=3D"color:black">;
</span><a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">Christian K=F6ni=
g</a><span style=3D"color:black">;
</span><a href=3D"mailto:Jacob.He@amd.com">He, Jacob</a><span style=3D"colo=
r:black">;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:black"><br>
<b>Subject: </b>RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace<o:p></=
o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span></p=
>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">That=92s fine to me.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">-David<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Koenig, Christian
</span><a href=3D"mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd=
.com&gt;</a><span style=3D"color:black">
<br>
<b>Sent:</b> Friday, February 21, 2020 11:33 PM<br>
<b>To:</b> Deucher, Alexander </span><a href=3D"mailto:Alexander.Deucher@am=
d.com">&lt;Alexander.Deucher@amd.com&gt;</a><span style=3D"color:black">; C=
hristian K=F6nig
</span><a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leic=
htzumerken@gmail.com&gt;</a><span style=3D"color:black">; Zhou, David(ChunM=
ing)
</span><a href=3D"mailto:David1.Zhou@amd.com">&lt;David1.Zhou@amd.com&gt;</=
a><span style=3D"color:black">; He, Jacob
</span><a href=3D"mailto:Jacob.He@amd.com">&lt;Jacob.He@amd.com&gt;</a><spa=
n style=3D"color:black">;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:black"><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace<o:p></=
o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">I would just do this as =
part of the vm_flush() callback on the ring.<br>
<br>
E.g. check if the VMID you want to flush is reserved and if yes enable SPM.=
<br>
<br>
Maybe pass along a flag or something in the job to make things easier.<br>
<br>
Christian.<br>
<br>
Am 21.02.20 um 16:31 schrieb Deucher, Alexander:<o:p></o:p></span></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">We alre=
ady have the RESERVE_VMID ioctl interface, can't we just use that internall=
y in the kernel to update the rlc register via the ring when we schedule th=
e relevant IB?&nbsp; E.g., add a new ring
 callback to set SPM state and then set it to the reserved vmid before we s=
chedule the ib, and then reset it to 0 after the IB in amdgpu_ib_schedule()=
.</span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">diff --=
git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/a=
mdgpu_ib.c</span><span style=3D"color:black"><o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">index 4=
b2342d11520..e0db9362c6ee 100644</span><span style=3D"color:black"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">--- a/d=
rivers/gpu/drm/amd/amdgpu/amdgpu_ib.c</span><span style=3D"color:black"><o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&#43;&#=
43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c</span><span style=3D"colo=
r:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">@@ -185=
,6 &#43;185,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned =
num_ibs,</span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; if (ring-&gt;funcs-&gt;insert_start)</span><span style=
=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ring-&gt;funcs-&gt;insert_=
start(ring);</span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&#43; &=
nbsp; &nbsp; &nbsp; if (ring-&gt;funcs-&gt;setup_spm)</span><span style=3D"=
color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&#43; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ring-&gt;funcs-&gt;setup_sp=
m(ring, job);</span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&#43;</=
span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; if (job) {</span><span style=3D"color:black"><o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; r =3D amdgpu_vm_flush(ring=
, job, need_pipe_sync);</span><span style=3D"color:black"><o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (r) {</span><span style=
=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">@@ -273=
,6 &#43;276,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned =
num_ibs,</span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return r;</span><span styl=
e=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; }</span><span style=3D"color:black"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&#43; &=
nbsp; &nbsp; &nbsp; if (ring-&gt;funcs-&gt;setup_spm)</span><span style=3D"=
color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&#43; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ring-&gt;funcs-&gt;setup_sp=
m(ring, NULL);</span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&#43;</=
span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; if (ring-&gt;funcs-&gt;insert_end)</span><span style=
=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ring-&gt;funcs-&gt;insert_=
end(ring);</span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex</s=
pan><span style=3D"color:black"><o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:black"><img border=3D"0" width=3D"369" height=3D"1" style=3D"=
width:3.8402in;height:.0069in" id=3D"Horizontal_x0020_Line_x0020_1" src=3D"=
cid:image003.png@01D5EBEF.1E703980"></span><span style=3D"color:black"><o:p=
></o:p></span></p>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx
</span><a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx=
-bounces@lists.freedesktop.org&gt;</a><span style=3D"color:black"> on behal=
f of Christian K=F6nig
</span><a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leic=
htzumerken@gmail.com&gt;</a><span style=3D"color:black"><br>
<b>Sent:</b> Friday, February 21, 2020 5:28 AM<br>
<b>To:</b> Zhou, David(ChunMing) </span><a href=3D"mailto:David1.Zhou@amd.c=
om">&lt;David1.Zhou@amd.com&gt;</a><span style=3D"color:black">; He, Jacob
</span><a href=3D"mailto:Jacob.He@amd.com">&lt;Jacob.He@amd.com&gt;</a><spa=
n style=3D"color:black">; Koenig, Christian
</span><a href=3D"mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd=
.com&gt;</a><span style=3D"color:black">;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:black">
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.f=
reedesktop.org&gt;</a><span style=3D"color:black"><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace <o:p><=
/o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">That would probably be a no-go, but we could enhance the kernel driver t=
o update the RLC_SPM_VMID register with the reserved VMID.<br>
<br>
Handling that in userspace is most likely not working anyway, since the RLC=
 registers are usually not accessible by userspace.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 20.02.20 um 16:15 schrieb Zhou, David(ChunMing):<o:p></o:p></span></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div>
<p class=3D"xmsipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt;=
background:white">
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span></p=
>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
<p class=3D"xmsonormal" style=3D"background:white">You can enhance amdgpu_v=
m_ioctl In amdgpu_vm.c to return vmid to userspace.
</p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
<p class=3D"xmsonormal" style=3D"background:white">-David</p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal" style=3D"background:white"><b>From:</b> He, Jacob <=
a href=3D"mailto:Jacob.He@amd.com">
&lt;Jacob.He@amd.com&gt;</a> <br>
<b>Sent:</b> Thursday, February 20, 2020 10:46 PM<br>
<b>To:</b> Zhou, David(ChunMing) <a href=3D"mailto:David1.Zhou@amd.com">&lt=
;David1.Zhou@amd.com&gt;</a>; Koenig, Christian
<a href=3D"mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt=
;</a>; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace</p>
</div>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
<p class=3D"xmsonormal" style=3D"background:white">amdgpu_vm_reserve_vmid d=
oesn=92t return the reserved vmid back to user space. There is no chance fo=
r user mode driver to update RLC_SPM_VMID.</p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
<p class=3D"xmsonormal" style=3D"background:white">Thanks</p>
<p class=3D"xmsonormal" style=3D"background:white">Jacob</p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal" style=3D"background:white"><b>From: </b><a href=3D"=
mailto:Jacob.He@amd.com">He, Jacob</a><br>
<b>Sent: </b>Thursday, February 20, 2020 6:20 PM<br>
<b>To: </b><a href=3D"mailto:David1.Zhou@amd.com">Zhou, David(ChunMing)</a>=
; <a href=3D"mailto:Christian.Koenig@amd.com">
Koenig, Christian</a>; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a><br>
<b>Subject: </b>RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace</p>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
<p class=3D"xmsonormal" style=3D"background:white">Looks like amdgpu_vm_res=
erve_vmid could work, let me have a try to update the RLC_SPM_VMID with pm4=
 packets in UMD.</p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
<p class=3D"xmsonormal" style=3D"background:white">Thanks</p>
<p class=3D"xmsonormal" style=3D"background:white">Jacob</p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal" style=3D"background:white"><b>From: </b><a href=3D"=
mailto:David1.Zhou@amd.com">Zhou, David(ChunMing)</a><br>
<b>Sent: </b>Thursday, February 20, 2020 10:13 AM<br>
<b>To: </b><a href=3D"mailto:Christian.Koenig@amd.com">Koenig, Christian</a=
>; <a href=3D"mailto:Jacob.He@amd.com">
He, Jacob</a>; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lis=
ts.freedesktop.org</a><br>
<b>Subject: </b>RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace</p>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
<p class=3D"xmsonormal" style=3D"background:white">[AMD Official Use Only -=
 Internal Distribution Only]<br>
<br>
Christian is right here, that will cause many problems for simply using VMI=
D in kernel.<br>
We already have an pair interface for RGP, I think you can use it instead o=
f involving additional kernel change.<br>
amdgpu_vm_reserve_vmid/ amdgpu_vm_unreserve_vmid.<br>
<br>
-David<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Christian K=F6ni=
g<br>
Sent: Wednesday, February 19, 2020 7:03 PM<br>
To: He, Jacob &lt;<a href=3D"mailto:Jacob.He@amd.com">Jacob.He@amd.com</a>&=
gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace<br>
<br>
Am 19.02.20 um 11:15 schrieb Jacob He:<br>
&gt; [WHY]<br>
&gt; When SPM trace enabled, SPM_VMID should be updated with the current <b=
r>
&gt; vmid.<br>
&gt;<br>
&gt; [HOW]<br>
&gt; Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD can tell us <br=
>
&gt; which job should update SPM_VMID.<br>
&gt; Right before a job is submitted to GPU, set the SPM_VMID accordingly.<=
br>
&gt;<br>
&gt; [Limitation]<br>
&gt; Running more than one SPM trace enabled processes simultaneously is <b=
r>
&gt; not supported.<br>
<br>
Well there are multiple problems with that patch.<br>
<br>
First of all you need to better describe what SPM tracing is in the commit =
message.<br>
<br>
Then the updating of mmRLC_SPM_MC_CNTL must be executed asynchronously on t=
he ring. Otherwise we might corrupt an already executing SPM trace.<br>
<br>
And you also need to make sure to disable the tracing again or otherwise we=
 run into a bunch of trouble when the VMID is reused.<br>
<br>
You also need to make sure that IBs using the SPM trace are serialized with=
 each other, e.g. hack into amdgpu_ids.c file and make sure that only one V=
MID at a time can have that attribute.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Change-Id: Ic932ef6ac9dbf244f03aaee90550e8ff3a675666<br>
&gt; Signed-off-by: Jacob He &lt;<a href=3D"mailto:jacob.he@amd.com">jacob.=
he@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c&nbsp; |&nbsp; 7 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c&nbsp; | 10 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |&nbsp; 1 &#43;<br=
>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |&nbsp; 1 &#43;<br=
>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp; | 15 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp;&nbsp; |&nbsp; =
3 &#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp; |&nbsp; =
3 &#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp; | 15 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; 8 files changed, 48 insertions(&#43;), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; index f9fa6e104fef..3f32c4db5232 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; @@ -113,6 &#43;113,7 @@ static int amdgpu_cs_parser_init(struct amdgpu=
_cs_parser *p, union drm_amdgpu_cs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uf_offset =3D 0;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool update_spm_vmid =3D false;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cs-&gt;in.num_chunks =3D=
=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -221,6 &#43;222,10 @@ static int amdgpu_cs_parser_init(struct amdgp=
u_cs_parser *p, union drm_amdgpu_cs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; case AMDGPU_CHUNK_ID_SPM_TRACE:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_spm_vmid =3D=
 true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fr=
ee_partial_kdata;<br>
&gt; @@ -231,6 &#43;236,8 @@ static int amdgpu_cs_parser_init(struct amdgpu=
_cs_parser *p, union drm_amdgpu_cs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto free_all_kdata;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;job-&gt;need_update_spm_vmid =3D u=
pdate_spm_vmid;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;ctx-&gt;vram_lost_=
counter !=3D p-&gt;job-&gt;vram_lost_counter) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D -ECANCELED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto free_all_kdata;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt; index cae81914c821..36faab12b585 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt; @@ -156,9 &#43;156,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ri=
ng, unsigned num_ibs,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (vm &amp;&amp; !job-&gt;vmid) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(adev-&gt;dev, &quot;VM IB without ID\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (vm) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!job-&gt;vmid) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;de=
v, &quot;VM IB without ID\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid &amp;&amp; jo=
b-&gt;need_update_spm_vmid) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.fu=
ncs-&gt;update_spm_vmid(adev, job-&gt;vmid);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_size =3D ring-&gt;func=
s-&gt;emit_frame_size &#43; num_ibs * diff --git <br>
&gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&gt; index 2e2110dddb76..4582536961c7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&gt; @@ -52,6 &#43;52,7 @@ struct amdgpu_job {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; vm_needs_flush;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_p=
d_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; need_update_spm_vmid;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasi=
d;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_=
base, gds_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gws_=
base, gws_size;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
&gt; index d3d4707f2168..52509c254cbd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
&gt; @@ -126,6 &#43;126,7 @@ struct amdgpu_rlc_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*stop)(struct amdgpu_d=
evice *adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*reset)(struct amdgpu_=
device *adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*start)(struct amdgpu_=
device *adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void (*update_spm_vmid)(struct amdgpu_de=
vice *adev, unsigned vmid);<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amdgpu_rlc {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; index 5e9fb0976c6c..91eb788d6229 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; @@ -4214,6 &#43;4214,18 @@ static int gfx_v10_0_update_gfx_clock_gatin=
g(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev,=
 <br>
&gt; &#43;unsigned vmid) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_M=
C_CNTL);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~RLC_SPM_MC_CNTL__RLC_SPM_=
VMID_MASK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D (vmid &amp; RLC_SPM_MC_CNTL__R=
LC_SPM_VMID_MASK) &lt;&lt; <br>
&gt; &#43;RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, d=
ata); }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_rlc_enabled =3D gfx_v10_=
0_is_rlc_enabled,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_safe_mode =3D gfx_v10_0=
_set_safe_mode, @@ -4224,7 &#43;4236,8 @@ <br>
&gt; static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D gfx_v10_0_rlc_re=
sume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v10_0_rlc_stop=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D gfx_v10_0_rlc_res=
et,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v10_0_rlc_start<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v10_0_rlc_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D gfx_v10_0_update_sp=
m_vmid<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int gfx_v10_0_set_powergating_state(void *handle, d=
iff --git <br>
&gt; a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt; index 8f20a5dd44fe..b24fc55cf13a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt; @@ -4221,7 &#43;4221,8 @@ static const struct amdgpu_rlc_funcs gfx_v7_=
0_rlc_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D gfx_v7_0_rlc_res=
ume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v7_0_rlc_stop,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D gfx_v7_0_rlc_rese=
t,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v7_0_rlc_start<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v7_0_rlc_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D NULL<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int gfx_v7_0_early_init(void *handle) diff --git <b=
r>
&gt; a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; index fa245973de12..66640d2b6b37 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; @@ -5600,7 &#43;5600,8 @@ static const struct amdgpu_rlc_funcs iceland=
_rlc_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D gfx_v8_0_rlc_res=
ume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v8_0_rlc_stop,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D gfx_v8_0_rlc_rese=
t,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v8_0_rlc_start<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v8_0_rlc_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D NULL<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_update_medium_grain_clock_gating(stru=
ct <br>
&gt; amdgpu_device *adev, diff --git <br>
&gt; a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; index 9b7ff783e9a5..df872f949f68 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; @@ -4704,6 &#43;4704,18 @@ static int gfx_v9_0_update_gfx_clock_gating=
(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, =
<br>
&gt; &#43;unsigned vmid) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_M=
C_CNTL);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~RLC_SPM_MC_CNTL__RLC_SPM_=
VMID_MASK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D (vmid &amp; RLC_SPM_MC_CNTL__R=
LC_SPM_VMID_MASK) &lt;&lt; <br>
&gt; &#43;RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, d=
ata); }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_rlc_enabled =3D gfx_v9_0=
_is_rlc_enabled,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_safe_mode =3D gfx_v9_0_=
set_safe_mode, @@ -4715,7 &#43;4727,8 @@ <br>
&gt; static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D gfx_v9_0_rlc_res=
ume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v9_0_rlc_stop,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D gfx_v9_0_rlc_rese=
t,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v9_0_rlc_start<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v9_0_rlc_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D gfx_v9_0_update_spm=
_vmid<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int gfx_v9_0_set_powergating_state(void *handle,<br=
>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7Calexander.deucher%40amd.com%7Ce68811adba0647c651a308d7b6b8d4c5%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637178777321057824&amp;sdata=3DuRP0wQyf=
VKk0QoGlWM36nbeOY67nIjfD6vou2A%2BybEc%3D&amp;reserved=3D0">https://nam11.sa=
felinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2=
Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cdavid1.zhou%40amd.co=
m%7C354be34ff18e4f424f6708d7b52b43b0%7C3dd8961fe4884e608e11a82d994e183d%7C0=
%7C0%7C637177069753914395&amp;amp;sdata=3D9rSL4kgPJweuZ4EJpdqtqTxyCVGEkmsg6=
aUzbtvGFrs%3D&amp;amp;reserved=3D0</a></p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;</p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;background:white"><spa=
n style=3D"color:black">&nbsp;<o:p></o:p></span></p>
<pre style=3D"background:white">___________________________________________=
____</pre>
<pre style=3D"background:white">amd-gfx mailing list</pre>
<pre style=3D"background:white"><a href=3D"mailto:amd-gfx@lists.freedesktop=
.org">amd-gfx@lists.freedesktop.org</a></pre>
<pre style=3D"background:white"><a href=3D"https://nam11.safelinks.protecti=
on.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flisti=
nfo%2Famd-gfx&amp;data=3D02%7C01%7Calexander.deucher%40amd.com%7Ce68811adba=
0647c651a308d7b6b8d4c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371787=
77321067823&amp;sdata=3D7o2j5dTvK%2B5Gihwd5IB%2Blp1Bi0ZOx%2B%2F%2Bmi8wpRh4N=
Bs%3D&amp;reserved=3D0">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a></pre>
</blockquote>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">&nbsp;<o:p></o:p></span></p>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
</blockquote>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB33767BD7E9FFEEAEBE0E14CE9BED0MN2PR12MB3376namp_--

--_004_MN2PR12MB33767BD7E9FFEEAEBE0E14CE9BED0MN2PR12MB3376namp_
Content-Type: image/png; name="5943235DC18B4CD38F1267B01FBD618E.png"
Content-Description: 5943235DC18B4CD38F1267B01FBD618E.png
Content-Disposition: inline; filename="5943235DC18B4CD38F1267B01FBD618E.png";
	size=138; creation-date="Tue, 25 Feb 2020 07:20:23 GMT";
	modification-date="Tue, 25 Feb 2020 07:20:23 GMT"
Content-ID: <image003.png@01D5EBEF.1E703980>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAikAAAABCAYAAAAb8z5sAAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAfSURBVEhLY9h/9vb/UTyKR/EoHsWjeBSP4sGF
b/8HAANhV8Cox/UCAAAAAElFTkSuQmCC

--_004_MN2PR12MB33767BD7E9FFEEAEBE0E14CE9BED0MN2PR12MB3376namp_--

--===============0307522820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0307522820==--
