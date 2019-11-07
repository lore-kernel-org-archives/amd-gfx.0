Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8966AC5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 20:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D53D20869
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 20:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D53D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD526F7A5;
	Thu,  7 Nov 2019 20:37:19 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690087.outbound.protection.outlook.com [40.107.69.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A2E6F7A5
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 20:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHVAos4LGG8T/4x2LdbMqzvs9R4LoPD/6FGUip5GjLEMpCaaLkKEnegNZxgB0GV80u6jn/lHEVfxtTuxVFQEy2tq3JQCwch4iLqhAF/AXQD8ilQSM2xfgKeDJ6z+svT9TIfI505sNyx/Sgi6rVwQG5fPyxVNoVZ380yFM/qjR5YV8PgGsbzUVJIjY7h+xhGDlgpwD4QNYTqgaW/Zdfoc2KSPmoKyTHBBdtTgyqkotwZsbwYKuIgwyHFDYJzn6JEeWOdWOWRR7mcQtUC11ZS1vBuXUAyJ42UJcG4cd8pXh5zDpl2oTM9zrpynMMS025mQhdWv1aWGYWRkRFaNBl54vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QV5IQt31iN2HN574ELNOrXS1PsTet3T77lTIw7dB63c=;
 b=F6UJIanFxUc9eAvP4QgPvpB5Fwan3FWZ/UjmIDKyd4cU0KQhYAx+uu5krFMS01j6ddL1CFMbH4S1JPUdQBD4DXAWYf5G4cB+DuO1z1a8NW9nnpLZEFSNB0PceOUQ/LM0fHH7RD651Ys8Tjn0vghvH9e4leLexWowEPDdfo+aYWdlCT4q1hPOEVyh6FT0yeXEBuKE0E3YY8skUFImGeB23O//zUffjqRr77ouNntg3X5HTmMw+tCpYl0M6o4/cUxsNnPw6fYlUW/y+3xmEnFPgmc0gvVnjz1/nZ268z2UDyTk7zG75s1RILQSy99MvG2hk2YibqKevzKwVEDrAoBgow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB2857.namprd12.prod.outlook.com (20.179.71.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 20:37:17 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 20:37:17 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Thread-Topic: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Thread-Index: AQHVj4CkSMtAMFLs5U2ND/zZPFxaw6d/LUyAgADMBUqAAAqagIAAAcsAgAACGwCAAAyFAIAAAlr2gAAI4oCAAAacxoAAD2cAgAABsYA=
Date: Thu, 7 Nov 2019 20:37:17 +0000
Message-ID: <7b604d5d-5c1f-c48c-c829-b42ef6bd403b@amd.com>
References: <20191031001739.10764-1-Yong.Zhao@amd.com>
 <20191031001739.10764-2-Yong.Zhao@amd.com>
 <31102345-20f7-1b0e-dd2a-f7984b253a07@amd.com>
 <DM6PR12MB2778C141CFEA0006DA2CEC6DF0780@DM6PR12MB2778.namprd12.prod.outlook.com>
 <CY4PR1201MB2533087B346C4619F461FF3185780@CY4PR1201MB2533.namprd12.prod.outlook.com>
 <41a6b535-ab7a-44f4-2899-f211f5ddc296@amd.com>
 <85fd399c-5fa9-bdef-cdf6-433e80ba6407@amd.com>
 <CADnq5_Og4AWKdYFpa8hvmd2XXjr1Wzb_a26gqsq1H6c7NkWmMA@mail.gmail.com>
 <DM6PR12MB2778007D58A5332F6A030DA3F0780@DM6PR12MB2778.namprd12.prod.outlook.com>
 <b4a76aeb-4d2c-c348-01bd-a40124930241@amd.com>
 <DM6PR12MB2778CD10620AEDD371AC088EF0780@DM6PR12MB2778.namprd12.prod.outlook.com>
 <6e021a24-eeb0-e1e1-d467-87ab48a6c7bc@amd.com>
In-Reply-To: <6e021a24-eeb0-e1e1-d467-87ab48a6c7bc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::21) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fcaea1e0-b1b4-4448-979e-08d763c24759
x-ms-traffictypediagnostic: DM6PR12MB2857:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2857481944DC2BCA59981EBEF0780@DM6PR12MB2857.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(51444003)(199004)(189003)(6506007)(2906002)(7736002)(386003)(66556008)(86362001)(54906003)(4001150100001)(71200400001)(71190400001)(6246003)(64756008)(476003)(26005)(31696002)(316002)(6512007)(81166006)(11346002)(66476007)(66446008)(2616005)(53546011)(66946007)(8676002)(486006)(5660300002)(606006)(229853002)(81156014)(6116002)(102836004)(446003)(186003)(99286004)(54896002)(6306002)(236005)(8936002)(30864003)(36756003)(14454004)(19627405001)(52116002)(76176011)(966005)(31686004)(6436002)(478600001)(25786009)(110136005)(3846002)(14444005)(66066001)(256004)(6486002)(105004)(4326008)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2857;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fdVI7oG0NYK3SKkMWPxW7kSjfhyARdMYTP1hsC4X/XyTy3E65O/UvdJKTBXv2k8YqnUJ1yj5aqvpKUy5gifEHZcXa5YSTC+ubq1c0t0EOX7BwHzwMO4tQZlhsQgtRu2T/A2+qJxUC5vzFquHnuoGqy4H/z+VL9f730hYx6phFc9t5jL1WsgvLA7mre9IiYi0zklLeQgl9J/tifSpmG9idlqw/3qMgx2F7ZobdaIO78ezlw6FeQLzf7fWTYNCsEaq8qTStWVp9POctBp+/1NMH0L/y9LvA8IhynWwbRHe3E7C2ksvYaKoMFM/F/xdGmD5RmKrKarR+rTXpPPAVwpbTaURyHPXMQtBi21BrRCFAxSt7zN3kMPzWy3uNGEfNF/jiQn8KrqhQ9elcuS4boreJrmhrAVq4QDXMGjeIMcuLLflMYnJueDAAGmAFNaRH5jncNGZzaiucGorjQF8APCwC8FRVUXPeySLy4qoSRHLRko=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaea1e0-b1b4-4448-979e-08d763c24759
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 20:37:17.0272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qI6nz6pZlZPNViFVTkwKqxMbLoT27Gl+lXc1MWB6ia3lJB1RcDf7RGO2KEKP+lw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2857
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QV5IQt31iN2HN574ELNOrXS1PsTet3T77lTIw7dB63c=;
 b=Xha0ePyZhsmVKQNTg4OOt5XRzo3kAqRJMAYtJqUNOBvCFt9/zBBVbnc4zs3dMdYo6rrsYxz7wXGDhTHkXGXN3z+Nhl4dzIx4ejJ4PsFWrXj6ovAWdx8DN1JVucUxMSrDwoD/f0D2ijYDMBCmhxxdvkXG8luz8BFTUSMYmIy+UUk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0153603842=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107203717.60AC3rfQEcw6Xi2fnY0wW2N1j_BbuEeWUTvdziJkI9A@z>

--===============0153603842==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_7b604d5d5c1fc48cc829b42ef6bd403bamdcom_"

--_000_7b604d5d5c1fc48cc829b42ef6bd403bamdcom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

After considering Kent's concern, I actually took the consolidation to the =
next level where v9 and v10 have no divergence. With that, I think the "mus=
tness" is stronger. Please check out the new patch.


Regards,

Yong


On 2019-11-07 3:31 p.m., Kuehling, Felix wrote:
On 2019-11-07 14:40, Zhao, Yong wrote:
Hi Felix,

The code working fine is true except that all not new features after this d=
uplication are broken. If I want to make all GFX10 feature complete, I have=
 to either manually adapt several duplications to the GFX10 file or do this=
 consolidation. From this perspective and ease of my work, it is a must.

"A must" means there is no alternative. You already listed two alternatives=
 yourself: "either manually adapt several duplications to the GFX10 file or=
 do this consolidation."


In _your_ opinion, the consolidation means less work for _you_. That's _you=
r_ point of view. The discussion in this code review pointed out other poin=
ts of view. When you take all of them into account, you may reconsider what=
 is less work overall, and what is easier to maintain.


I'm not opposing your change per-se. But I'd like you to consider the whole=
 picture, including the consequences of any design decisions you're making =
and imposing on anyone working on this code in the future. In this cases I =
think it's a relatively minor issue and it may just come down to a matter o=
f opinion that I don't feel terribly strongly about.


With that said, the change is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@=
amd.com>


Regards,

  Felix


Regards,
Yong

________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@amd.co=
m>
Sent: Thursday, November 7, 2019 2:12 PM
To: Zhao, Yong <Yong.Zhao@amd.com><mailto:Yong.Zhao@amd.com>; Alex Deucher =
<alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>
Cc: Russell, Kent <Kent.Russell@amd.com><mailto:Kent.Russell@amd.com>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@li=
sts.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Haw=
aii

On 2019-11-07 13:54, Zhao, Yong wrote:
Hi Kent,

This consolidation is a must, because we should not have duplicated it in t=
he first place.

The code is working fine with the duplication. You disagree with duplicatin=
g the code in the first place. But that's just your opinion. It's not a mus=
t in any objective sense.



The kernel queue functions by design are generic. The reasson why GFX8 and =
GFX9 are different is because GFX9 is SOC15 where packet formats and doorbe=
ll size changed.  On the other hand, kfd_kernel_queue_v7.c file is pretty m=
uch empty by reusing v8 functions, even though it is there. Furthermore, in=
 my opinion kfd_kernel_queue_v7.c should be merged into v8 counterpart, Fro=
m GFX9 onwards, packet formats should stay the same. For kernel queues, we =
should be able to differentiate it by pre SOC15 or not, and I have an impre=
ssion that MEC firmware agrees to maintain the kernel queue interface stabl=
e across generations most of time.

OK, you're making assumptions about PM4 packets on future ASIC generations.=
 It's true that the transition to SOC15 with 64-bit doorbells and read/writ=
e-pointers was particularly disruptive. Your assumption will hold until it =
gets broken by some other disruptive change.


For now, if you want clear naming, we could call the GFXv7/8 packet manager=
 functions "pre-SOC15" or "legacy" and the GFXv9/10 and future functions "S=
OC15". This may work for a while. But I suspect at some point something is =
going to change and we'll need to create a new version for a newer ASIC gen=
eration. You already have a small taste of that with the different TBA-enab=
le bit in the MAP_PROCESS packet in GFXv10.


Regards,

  Felix


Regards,
Yong
________________________________
From: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>
Sent: Thursday, November 7, 2019 1:32 PM
To: Kuehling, Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@amd.com>
Cc: Zhao, Yong <Yong.Zhao@amd.com><mailto:Yong.Zhao@amd.com>; Russell, Kent=
 <Kent.Russell@amd.com><mailto:Kent.Russell@amd.com>; amd-gfx@lists.freedes=
ktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.o=
rg><mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Haw=
aii

On Thu, Nov 7, 2019 at 12:47 PM Kuehling, Felix <Felix.Kuehling@amd.com><ma=
ilto:Felix.Kuehling@amd.com> wrote:
>
> No, please lets not add a new nomenclature for PM4 packet versions. GFX v=
ersions are agreed on between hardware, firmware, and software and it's gen=
erally understood what they mean. If we add a new PM4 packet versioning sch=
eme on our own, then this will add a lot of confusion when talking to firmw=
are teams.
>
> You know, this would all be more straight forward if we accepted a little=
 bit of code duplication and had packet writing functions per GFX version. =
You'll see this pattern a lot in the amdgpu driver where each IP version du=
plicates a bunch of code. In many cases you may be able to save a few lines=
 of code by sharing functions between IP versions. But you'll add some conf=
usion and burden on future maintenance.
>
> This is the price we pay for micro-optimizing minor code duplication.

What we've tried to do in amdgpu is to break out shared code in to
common helpers that are not IP specific and use that in each IP module
(e.g., amdgpu_uvd.c amdgpu_gfx.c, etc.).  Sometimes we can use a
particular chunk of code across multiple generations.  E.g., the uvd
stuff is a good example.  We have shared generic uvd helpers that work
for most UVD IP versions, and then if we need an IP specific version,
we override that in the callbacks with a version specific one.  E.g.,
for the video decode engines we use the generic helpers for a number
of ring functions:

static const struct amdgpu_ring_funcs uvd_v7_0_ring_vm_funcs =3D {
...
    .test_ring =3D uvd_v7_0_ring_test_ring,
        .test_ib =3D amdgpu_uvd_ring_test_ib,
        .insert_nop =3D uvd_v7_0_ring_insert_nop,
        .pad_ib =3D amdgpu_ring_generic_pad_ib,
        .begin_use =3D amdgpu_uvd_ring_begin_use,
        .end_use =3D amdgpu_uvd_ring_end_use,
...
};

while we override more of them for the video encode engines:

static const struct amdgpu_ring_funcs uvd_v7_0_enc_ring_vm_funcs =3D {
...
    .test_ring =3D uvd_v7_0_enc_ring_test_ring,
        .test_ib =3D uvd_v7_0_enc_ring_test_ib,
        .insert_nop =3D amdgpu_ring_insert_nop,
    .insert_end =3D uvd_v7_0_enc_ring_insert_end,
        .pad_ib =3D amdgpu_ring_generic_pad_ib,
        .begin_use =3D amdgpu_uvd_ring_begin_use,
        .end_use =3D amdgpu_uvd_ring_end_use,
...
};

But still maintain IP specific components.

Alex

>
> Regards,
>   Felix
>
> On 2019-11-07 12:39, Zhao, Yong wrote:
>
> Hi Kent,
>
> I can't agree more on this. Also, the same applies to the file names. Def=
initely we need to agree on the naming scheme before making it happen.
>
> Yong
>
> On 2019-11-07 12:33 p.m., Russell, Kent wrote:
>
> I think that the versioning is getting a little confusing since we=92re u=
sing the old GFX versions, but not really sticking to it due to the shareab=
ility of certain managers and shaders. Could we look into doing something l=
ike gen1 or gen2, or some other more ambiguous non-GFX-related versioning? =
Otherwise we=92ll keep having these questions of =93why is Hawaii GFX8=94, =
=93why is Arcturus GFX9=94, etc. Then if things change, we just up the valu=
e concretely, instead of maybe doing a v11 if GFX11 changes things, and onl=
y GFX11 ASICs use those functions/variables.
>
>
>
> Obviously not high-priority, but maybe something to consider as you conti=
nue to consolidate and remove duplicate code.
>
>
>
> Kent
>
>
>
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-boun=
ces@lists.freedesktop.org> On Behalf Of Zhao, Yong
> Sent: Thursday, November 7, 2019 11:57 AM
> To: Kuehling, Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@amd.co=
m>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for H=
awaii
>
>
>
> Hi Felix,
>
>
>
> That's because v8 and v7 share the same packet_manager_funcs. In this cas=
e, it is better to keep it as it is.
>
>
>
> Regards,
>
> Yong
>
> ________________________________
>
> From: Kuehling, Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@amd.=
com>
> Sent: Wednesday, November 6, 2019 11:45 PM
> To: Zhao, Yong <Yong.Zhao@amd.com><mailto:Yong.Zhao@amd.com>; amd-gfx@lis=
ts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fre=
edesktop.org><mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function for H=
awaii
>
>
>
> On 2019-10-30 20:17, Zhao, Yong wrote:
> > release_mem won't be used at all on GFX9 and GFX10, so delete it.
>
> Hawaii was GFXv7. So we're not using the release_mem packet on GFXv8
> either. Why arbitrarily limit this change to GFXv9 and 10?
>
> Regards,
>    Felix
>
> >
> > Change-Id: I13787a8a29b83e7516c582a7401f2e14721edf5f
> > Signed-off-by: Yong Zhao <Yong.Zhao@amd.com><mailto:Yong.Zhao@amd.com>
> > ---
> >   .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c | 35 ++----------------=
-
> >   .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c  | 33 ++---------------
> >   2 files changed, 4 insertions(+), 64 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> > index aed32ab7102e..bfd6221acae9 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> > @@ -298,37 +298,6 @@ static int pm_query_status_v10(struct packet_manag=
er *pm, uint32_t *buffer,
> >        return 0;
> >   }
> >
> > -
> > -static int pm_release_mem_v10(uint64_t gpu_addr, uint32_t *buffer)
> > -{
> > -     struct pm4_mec_release_mem *packet;
> > -
> > -     WARN_ON(!buffer);
> > -
> > -     packet =3D (struct pm4_mec_release_mem *)buffer;
> > -     memset(buffer, 0, sizeof(struct pm4_mec_release_mem));
> > -
> > -     packet->header.u32All =3D pm_build_pm4_header(IT_RELEASE_MEM,
> > -                                     sizeof(struct pm4_mec_release_mem=
));
> > -
> > -     packet->bitfields2.event_type =3D CACHE_FLUSH_AND_INV_TS_EVENT;
> > -     packet->bitfields2.event_index =3D event_index__mec_release_mem__=
end_of_pipe;
> > -     packet->bitfields2.tcl1_action_ena =3D 1;
> > -     packet->bitfields2.tc_action_ena =3D 1;
> > -     packet->bitfields2.cache_policy =3D cache_policy__mec_release_mem=
__lru;
> > -
> > -     packet->bitfields3.data_sel =3D data_sel__mec_release_mem__send_3=
2_bit_low;
> > -     packet->bitfields3.int_sel =3D
> > -             int_sel__mec_release_mem__send_interrupt_after_write_conf=
irm;
> > -
> > -     packet->bitfields4.address_lo_32b =3D (gpu_addr & 0xffffffff) >> =
2;
> > -     packet->address_hi =3D upper_32_bits(gpu_addr);
> > -
> > -     packet->data_lo =3D 0;
> > -
> > -     return sizeof(struct pm4_mec_release_mem) / sizeof(unsigned int);
> > -}
> > -
> >   const struct packet_manager_funcs kfd_v10_pm_funcs =3D {
> >        .map_process                    =3D pm_map_process_v10,
> >        .runlist                        =3D pm_runlist_v10,
> > @@ -336,13 +305,13 @@ const struct packet_manager_funcs kfd_v10_pm_func=
s =3D {
> >        .map_queues                     =3D pm_map_queues_v10,
> >        .unmap_queues                   =3D pm_unmap_queues_v10,
> >        .query_status                   =3D pm_query_status_v10,
> > -     .release_mem                    =3D pm_release_mem_v10,
> > +     .release_mem                    =3D NULL,
> >        .map_process_size               =3D sizeof(struct pm4_mes_map_pr=
ocess),
> >        .runlist_size                   =3D sizeof(struct pm4_mes_runlis=
t),
> >        .set_resources_size             =3D sizeof(struct pm4_mes_set_re=
sources),
> >        .map_queues_size                =3D sizeof(struct pm4_mes_map_qu=
eues),
> >        .unmap_queues_size              =3D sizeof(struct pm4_mes_unmap_=
queues),
> >        .query_status_size              =3D sizeof(struct pm4_mes_query_=
status),
> > -     .release_mem_size               =3D sizeof(struct pm4_mec_release=
_mem)
> > +     .release_mem_size               =3D 0,
> >   };
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> > index 3b5ca2b1d7a6..f0e4910a8865 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> > @@ -336,35 +336,6 @@ static int pm_query_status_v9(struct packet_manage=
r *pm, uint32_t *buffer,
> >        return 0;
> >   }
> >
> > -
> > -static int pm_release_mem_v9(uint64_t gpu_addr, uint32_t *buffer)
> > -{
> > -     struct pm4_mec_release_mem *packet;
> > -
> > -     packet =3D (struct pm4_mec_release_mem *)buffer;
> > -     memset(buffer, 0, sizeof(struct pm4_mec_release_mem));
> > -
> > -     packet->header.u32All =3D pm_build_pm4_header(IT_RELEASE_MEM,
> > -                                     sizeof(struct pm4_mec_release_mem=
));
> > -
> > -     packet->bitfields2.event_type =3D CACHE_FLUSH_AND_INV_TS_EVENT;
> > -     packet->bitfields2.event_index =3D event_index__mec_release_mem__=
end_of_pipe;
> > -     packet->bitfields2.tcl1_action_ena =3D 1;
> > -     packet->bitfields2.tc_action_ena =3D 1;
> > -     packet->bitfields2.cache_policy =3D cache_policy__mec_release_mem=
__lru;
> > -
> > -     packet->bitfields3.data_sel =3D data_sel__mec_release_mem__send_3=
2_bit_low;
> > -     packet->bitfields3.int_sel =3D
> > -             int_sel__mec_release_mem__send_interrupt_after_write_conf=
irm;
> > -
> > -     packet->bitfields4.address_lo_32b =3D (gpu_addr & 0xffffffff) >> =
2;
> > -     packet->address_hi =3D upper_32_bits(gpu_addr);
> > -
> > -     packet->data_lo =3D 0;
> > -
> > -     return 0;
> > -}
> > -
> >   const struct packet_manager_funcs kfd_v9_pm_funcs =3D {
> >        .map_process            =3D pm_map_process_v9,
> >        .runlist                =3D pm_runlist_v9,
> > @@ -372,12 +343,12 @@ const struct packet_manager_funcs kfd_v9_pm_funcs=
 =3D {
> >        .map_queues             =3D pm_map_queues_v9,
> >        .unmap_queues           =3D pm_unmap_queues_v9,
> >        .query_status           =3D pm_query_status_v9,
> > -     .release_mem            =3D pm_release_mem_v9,
> > +     .release_mem            =3D NULL,
> >        .map_process_size       =3D sizeof(struct pm4_mes_map_process),
> >        .runlist_size           =3D sizeof(struct pm4_mes_runlist),
> >        .set_resources_size     =3D sizeof(struct pm4_mes_set_resources)=
,
> >        .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
> >        .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> >        .query_status_size      =3D sizeof(struct pm4_mes_query_status),
> > -     .release_mem_size       =3D sizeof(struct pm4_mec_release_mem)
> > +     .release_mem_size       =3D 0,
> >   };
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_7b604d5d5c1fc48cc829b42ef6bd403bamdcom_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <094CB78359B135409FAA37C303EDD322@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body text=3D"#000000" bgcolor=3D"#FFFFFF">
<p>After considering Kent's concern, I actually took the consolidation to t=
he next level where v9 and v10 have no divergence. With that, I think the &=
quot;mustness&quot; is stronger. Please check out the new patch.</p>
<p><br>
</p>
<p>Regards,</p>
<p>Yong</p>
<p><br>
</p>
<div class=3D"moz-cite-prefix">On 2019-11-07 3:31 p.m., Kuehling, Felix wro=
te:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:6e021a24-eeb0-e1e1-d467-87ab48a6c7bc@=
amd.com">
<div class=3D"moz-cite-prefix">On 2019-11-07 14:40, Zhao, Yong wrote:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:DM6PR12MB2778CD10620AEDD371AC088EF078=
0@DM6PR12MB2778.namprd12.prod.outlook.com">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
Hi Felix,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(50, 49, 48); font-family: &quot;Segoe
            UI&quot;, &quot;Segoe UI Web (West European)&quot;,
            &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont,
            Roboto, &quot;Helvetica Neue&quot;, sans-serif;
            background-color: rgb(255, 255, 255); display: inline
            !important">The
 code working fine is true except that all not new features after this dupl=
ication are broken. If I want to make all GFX10 feature complete, I have to=
 either manually adapt several duplications to the GFX10 file or do this co=
nsolidation. From this perspective
 and ease of my work, it is a must.</span><br>
</div>
</blockquote>
<p>&quot;A must&quot; means there is no alternative. You already listed two=
 alternatives yourself: &quot;either manually adapt several duplications to=
 the GFX10 file or do this consolidation.&quot;</p>
<p><br>
</p>
<p>In _your_ opinion, the consolidation means less work for _you_. That's _=
your_ point of view. The discussion in this code review pointed out other p=
oints of view. When you take all of them into account, you may reconsider w=
hat is less work overall, and what
 is easier to maintain.</p>
<p><br>
</p>
<p>I'm not opposing your change per-se. But I'd like you to consider the wh=
ole picture, including the consequences of any design decisions you're maki=
ng and imposing on anyone working on this code in the future. In this cases=
 I think it's a relatively minor
 issue and it may just come down to a matter of opinion that I don't feel t=
erribly strongly about.<br>
</p>
<p><br>
</p>
<p>With that said, the change is</p>
<p>Reviewed-by: Felix Kuehling <a class=3D"moz-txt-link-rfc2396E" href=3D"m=
ailto:Felix.Kuehling@amd.com" moz-do-not-send=3D"true">
&lt;Felix.Kuehling@amd.com&gt;</a></p>
<p><br>
</p>
<p>Regards,</p>
<p>&nbsp; Felix<br>
</p>
<p><br>
</p>
<blockquote type=3D"cite" cite=3D"mid:DM6PR12MB2778CD10620AEDD371AC088EF078=
0@DM6PR12MB2778.namprd12.prod.outlook.com">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(50, 49, 48); font-family: &quot;Segoe
            UI&quot;, &quot;Segoe UI Web (West European)&quot;,
            &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont,
            Roboto, &quot;Helvetica Neue&quot;, sans-serif;
            background-color: rgb(255, 255, 255); display: inline
            !important"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(50, 49, 48); font-family: &quot;Segoe
            UI&quot;, &quot;Segoe UI Web (West European)&quot;,
            &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont,
            Roboto, &quot;Helvetica Neue&quot;, sans-serif;
            background-color: rgb(255, 255, 255); display: inline
            !important">Regards,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(50, 49, 48); font-family: &quot;Segoe
            UI&quot;, &quot;Segoe UI Web (West European)&quot;,
            &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont,
            Roboto, &quot;Helvetica Neue&quot;, sans-serif;
            background-color: rgb(255, 255, 255); display: inline
            !important">Yong</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Kuehling, Felix
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Felix.Kuehling@amd.com" m=
oz-do-not-send=3D"true">
&lt;Felix.Kuehling@amd.com&gt;</a><br>
<b>Sent:</b> Thursday, November 7, 2019 2:12 PM<br>
<b>To:</b> Zhao, Yong <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Yon=
g.Zhao@amd.com" moz-do-not-send=3D"true">
&lt;Yong.Zhao@amd.com&gt;</a>; Alex Deucher <a class=3D"moz-txt-link-rfc239=
6E" href=3D"mailto:alexdeucher@gmail.com" moz-do-not-send=3D"true">
&lt;alexdeucher@gmail.com&gt;</a><br>
<b>Cc:</b> Russell, Kent <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:=
Kent.Russell@amd.com" moz-do-not-send=3D"true">
&lt;Kent.Russell@amd.com&gt;</a>; <a class=3D"moz-txt-link-abbreviated" hre=
f=3D"mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send=3D"true">
amd-gfx@lists.freedesktop.org</a> <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send=3D"true">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function =
for Hawaii</font>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">On 2019-11-07 13:54, Zhao, Yong wrote:<br>
</div>
<blockquote type=3D"cite">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
              font-size:12pt; color:rgb(0,0,0)">
Hi Kent,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
              font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
              font-size:12pt; color:rgb(0,0,0)">
This <span style=3D"font-family:Calibri,sans-serif;
                font-size:14.6667px; background-color:rgb(255,255,255);
                display:inline!important">
consolidation is a must, because we should not have duplicated it in the fi=
rst place.</span></div>
</blockquote>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">The code is working fine =
with the duplication. You disagree with duplicating the code in the first p=
lace. But that's just your opinion. It's not a must in any objective sense.=
<br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<blockquote type=3D"cite">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
              font-size:12pt; color:rgb(0,0,0)">
<span style=3D"font-family:Calibri,sans-serif;
                font-size:14.6667px; background-color:rgb(255,255,255);
                display:inline!important">The kernel queue functions by des=
ign are generic. The reasson why GFX8 and GFX9 are different is
 because GFX9 is SOC15 where packet formats and doorbell size changed.&nbsp=
; On the other hand, kfd_kernel_queue_v7.c file is pretty much empty by reu=
sing v8 functions, even though it is there. Furthermore, in my opinion&nbsp=
;<span style=3D"font-family:Calibri,sans-serif;
                  background-color:rgb(255,255,255);
                  display:inline!important">kfd_kernel_queue_v7.c
 should be merged into v8 counterpart</span>, From GFX9 onwards,&nbsp;<span=
 style=3D"font-family:Calibri,sans-serif;
                  background-color:rgb(255,255,255);
                  display:inline!important">packet formats should stay the =
same. For kernel
 queues, we should be able to differentiate it by pre SOC15 or not, and I h=
ave an impression that MEC firmware agrees to maintain the kernel queue int=
erface stable across generations most of time.</span></span></div>
</blockquote>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">OK, you're making assumpt=
ions about PM4 packets on future ASIC generations. It's true that the trans=
ition to SOC15 with 64-bit doorbells and read/write-pointers was particular=
ly disruptive. Your assumption will
 hold until it gets broken by some other disruptive change.</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">For now, if you want clea=
r naming, we could call the GFXv7/8 packet manager functions &quot;pre-SOC1=
5&quot; or &quot;legacy&quot; and the GFXv9/10 and future functions &quot;S=
OC15&quot;. This may work for a while. But I suspect at some point
 something is going to change and we'll need to create a new version for a =
newer ASIC generation. You already have a small taste of that with the diff=
erent TBA-enable bit in the MAP_PROCESS packet in GFXv10.</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Regards,</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">&nbsp; Felix<br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<blockquote type=3D"cite">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
              font-size:12pt; color:rgb(0,0,0)">
<span style=3D"font-family:Calibri,sans-serif;
                font-size:14.6667px; background-color:rgb(255,255,255);
                display:inline!important"><span style=3D"font-family:Calibr=
i,sans-serif;
                  background-color:rgb(255,255,255);
                  display:inline!important"><br>
</span></span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
              font-size:12pt; color:rgb(0,0,0)">
<span style=3D"font-family:Calibri,sans-serif;
                font-size:14.6667px; background-color:rgb(255,255,255);
                display:inline!important"><span style=3D"font-family:Calibr=
i,sans-serif;
                  background-color:rgb(255,255,255);
                  display:inline!important">Regards,</span></span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
              font-size:12pt; color:rgb(0,0,0)">
<span style=3D"font-family:Calibri,sans-serif;
                font-size:14.6667px; background-color:rgb(255,255,255);
                display:inline!important"><span style=3D"font-family:Calibr=
i,sans-serif;
                  background-color:rgb(255,255,255);
                  display:inline!important">Yong</span></span></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Alex Deucher
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:alexdeucher@gmail.com" =
moz-do-not-send=3D"true">
&lt;alexdeucher@gmail.com&gt;</a><br>
<b>Sent:</b> Thursday, November 7, 2019 1:32 PM<br>
<b>To:</b> Kuehling, Felix <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mai=
lto:Felix.Kuehling@amd.com" moz-do-not-send=3D"true">
&lt;Felix.Kuehling@amd.com&gt;</a><br>
<b>Cc:</b> Zhao, Yong <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Y=
ong.Zhao@amd.com" moz-do-not-send=3D"true">
&lt;Yong.Zhao@amd.com&gt;</a>; Russell, Kent <a class=3D"x_moz-txt-link-rfc=
2396E" href=3D"mailto:Kent.Russell@amd.com" moz-do-not-send=3D"true">
&lt;Kent.Russell@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated" h=
ref=3D"mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send=3D"true">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send=3D"true">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function =
for Hawaii</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On Thu, Nov 7, 2019 at 12:47 PM Kuehling, Felix =
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Felix.Kuehling@amd.com"=
 moz-do-not-send=3D"true">
&lt;Felix.Kuehling@amd.com&gt;</a> wrote:<br>
&gt;<br>
&gt; No, please lets not add a new nomenclature for PM4 packet versions. GF=
X versions are agreed on between hardware, firmware, and software and it's =
generally understood what they mean. If we add a new PM4 packet versioning =
scheme on our own, then this will add
 a lot of confusion when talking to firmware teams.<br>
&gt;<br>
&gt; You know, this would all be more straight forward if we accepted a lit=
tle bit of code duplication and had packet writing functions per GFX versio=
n. You'll see this pattern a lot in the amdgpu driver where each IP version=
 duplicates a bunch of code. In many
 cases you may be able to save a few lines of code by sharing functions bet=
ween IP versions. But you'll add some confusion and burden on future mainte=
nance.<br>
&gt;<br>
&gt; This is the price we pay for micro-optimizing minor code duplication.<=
br>
<br>
What we've tried to do in amdgpu is to break out shared code in to<br>
common helpers that are not IP specific and use that in each IP module<br>
(e.g., amdgpu_uvd.c amdgpu_gfx.c, etc.).&nbsp; Sometimes we can use a<br>
particular chunk of code across multiple generations.&nbsp; E.g., the uvd<b=
r>
stuff is a good example.&nbsp; We have shared generic uvd helpers that work=
<br>
for most UVD IP versions, and then if we need an IP specific version,<br>
we override that in the callbacks with a version specific one.&nbsp; E.g.,<=
br>
for the video decode engines we use the generic helpers for a number<br>
of ring functions:<br>
<br>
static const struct amdgpu_ring_funcs uvd_v7_0_ring_vm_funcs =3D {<br>
...<br>
&nbsp;&nbsp;&nbsp; .test_ring =3D uvd_v7_0_ring_test_ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ib =3D amdgpu_uvd_ring_tes=
t_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_nop =3D uvd_v7_0_ring_in=
sert_nop,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad_ib =3D amdgpu_ring_generic_=
pad_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .begin_use =3D amdgpu_uvd_ring_b=
egin_use,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .end_use =3D amdgpu_uvd_ring_end=
_use,<br>
...<br>
};<br>
<br>
while we override more of them for the video encode engines:<br>
<br>
static const struct amdgpu_ring_funcs uvd_v7_0_enc_ring_vm_funcs =3D {<br>
...<br>
&nbsp;&nbsp;&nbsp; .test_ring =3D uvd_v7_0_enc_ring_test_ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ib =3D uvd_v7_0_enc_ring_t=
est_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_nop =3D amdgpu_ring_inse=
rt_nop,<br>
&nbsp;&nbsp;&nbsp; .insert_end =3D uvd_v7_0_enc_ring_insert_end,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad_ib =3D amdgpu_ring_generic_=
pad_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .begin_use =3D amdgpu_uvd_ring_b=
egin_use,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .end_use =3D amdgpu_uvd_ring_end=
_use,<br>
...<br>
};<br>
<br>
But still maintain IP specific components.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt;&nbsp;&nbsp; Felix<br>
&gt;<br>
&gt; On 2019-11-07 12:39, Zhao, Yong wrote:<br>
&gt;<br>
&gt; Hi Kent,<br>
&gt;<br>
&gt; I can't agree more on this. Also, the same applies to the file names. =
Definitely we need to agree on the naming scheme before making it happen.<b=
r>
&gt;<br>
&gt; Yong<br>
&gt;<br>
&gt; On 2019-11-07 12:33 p.m., Russell, Kent wrote:<br>
&gt;<br>
&gt; I think that the versioning is getting a little confusing since we=92r=
e using the old GFX versions, but not really sticking to it due to the shar=
eability of certain managers and shaders. Could we look into doing somethin=
g like gen1 or gen2, or some other more
 ambiguous non-GFX-related versioning? Otherwise we=92ll keep having these =
questions of =93why is Hawaii GFX8=94, =93why is Arcturus GFX9=94, etc. The=
n if things change, we just up the value concretely, instead of maybe doing=
 a v11 if GFX11 changes things, and only GFX11
 ASICs use those functions/variables.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Obviously not high-priority, but maybe something to consider as you co=
ntinue to consolidate and remove duplicate code.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Kent<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: amd-gfx <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:amd-=
gfx-bounces@lists.freedesktop.org" moz-do-not-send=3D"true">
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> On Behalf Of Zhao, Yong<b=
r>
&gt; Sent: Thursday, November 7, 2019 11:57 AM<br>
&gt; To: Kuehling, Felix <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailt=
o:Felix.Kuehling@amd.com" moz-do-not-send=3D"true">
&lt;Felix.Kuehling@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated"=
 href=3D"mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send=3D"true">
amd-gfx@lists.freedesktop.org</a><br>
&gt; Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function fo=
r Hawaii<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi Felix,<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; That's because v8 and v7 share the same packet_manager_funcs. In this =
case, it is better to keep it as it is.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; Yong<br>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; From: Kuehling, Felix <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mai=
lto:Felix.Kuehling@amd.com" moz-do-not-send=3D"true">
&lt;Felix.Kuehling@amd.com&gt;</a><br>
&gt; Sent: Wednesday, November 6, 2019 11:45 PM<br>
&gt; To: Zhao, Yong <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Yon=
g.Zhao@amd.com" moz-do-not-send=3D"true">
&lt;Yong.Zhao@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated" href=
=3D"mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send=3D"true">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send=3D"true">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
&gt; Subject: Re: [PATCH 2/3] drm/amdkfd: only keep release_mem function fo=
r Hawaii<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 2019-10-30 20:17, Zhao, Yong wrote:<br>
&gt; &gt; release_mem won't be used at all on GFX9 and GFX10, so delete it.=
<br>
&gt;<br>
&gt; Hawaii was GFXv7. So we're not using the release_mem packet on GFXv8<b=
r>
&gt; either. Why arbitrarily limit this change to GFXv9 and 10?<br>
&gt;<br>
&gt; Regards,<br>
&gt;&nbsp;&nbsp;&nbsp; Felix<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Change-Id: I13787a8a29b83e7516c582a7401f2e14721edf5f<br>
&gt; &gt; Signed-off-by: Yong Zhao <a class=3D"x_moz-txt-link-rfc2396E" hre=
f=3D"mailto:Yong.Zhao@amd.com" moz-do-not-send=3D"true">
&lt;Yong.Zhao@amd.com&gt;</a><br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c | 35 &#=
43;&#43;-----------------<br>
&gt; &gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c&nbsp; | =
33 &#43;&#43;---------------<br>
&gt; &gt;&nbsp;&nbsp; 2 files changed, 4 insertions(&#43;), 64 deletions(-)=
<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c b/=
drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c<br>
&gt; &gt; index aed32ab7102e..bfd6221acae9 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10=
.c<br>
&gt; &gt; @@ -298,37 &#43;298,6 @@ static int pm_query_status_v10(struct pa=
cket_manager *pm, uint32_t *buffer,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -static int pm_release_mem_v10(uint64_t gpu_addr, uint32_t *buffe=
r)<br>
&gt; &gt; -{<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mec_release_mem *packet;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(!buffer);<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mec_release_mem =
*)buffer;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mec=
_release_mem));<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_p=
m4_header(IT_RELEASE_MEM,<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; sizeof(struct pm4_mec_release_mem));<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_type =3D CA=
CHE_FLUSH_AND_INV_TS_EVENT;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_index =3D e=
vent_index__mec_release_mem__end_of_pipe;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tcl1_action_ena =
=3D 1;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tc_action_ena =3D=
 1;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.cache_policy =3D =
cache_policy__mec_release_mem__lru;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.data_sel =3D data=
_sel__mec_release_mem__send_32_bit_low;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.int_sel =3D<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; int_sel__mec_release_mem__send_interrupt_after_write_confirm;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.address_lo_32b =
=3D (gpu_addr &amp; 0xffffffff) &gt;&gt; 2;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;address_hi =3D upper_32_bits=
(gpu_addr);<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;data_lo =3D 0;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct pm4_mec_release_me=
m) / sizeof(unsigned int);<br>
&gt; &gt; -}<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp; const struct packet_manager_funcs kfd_v10_pm_funcs =
=3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_process_v10,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_runlist_v10,<br>
&gt; &gt; @@ -336,13 &#43;305,13 @@ const struct packet_manager_funcs kfd_v=
10_pm_funcs =3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_queues_v10,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D pm_unmap_queues_v10,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D pm_query_status_v10,<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =3D pm_release_mem_v10,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =3D NULL,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process_size&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D sizeof(struct pm4_mes_map_process),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist_size&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_runlist),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_resources_size&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D si=
zeof(struct pm4_mes_set_resources),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues_size&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D sizeof(struct pm4_mes_map_queues),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues_size&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D sizeof(struct pm4_mes_unmap_queues),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status_size&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D sizeof(struct pm4_mes_query_status),<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(s=
truct pm4_mec_release_mem)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0,<b=
r>
&gt; &gt;&nbsp;&nbsp; };<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; &gt; index 3b5ca2b1d7a6..f0e4910a8865 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.=
c<br>
&gt; &gt; @@ -336,35 &#43;336,6 @@ static int pm_query_status_v9(struct pac=
ket_manager *pm, uint32_t *buffer,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -static int pm_release_mem_v9(uint64_t gpu_addr, uint32_t *buffer=
)<br>
&gt; &gt; -{<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mec_release_mem *packet;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mec_release_mem =
*)buffer;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mec=
_release_mem));<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_p=
m4_header(IT_RELEASE_MEM,<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; sizeof(struct pm4_mec_release_mem));<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_type =3D CA=
CHE_FLUSH_AND_INV_TS_EVENT;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.event_index =3D e=
vent_index__mec_release_mem__end_of_pipe;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tcl1_action_ena =
=3D 1;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.tc_action_ena =3D=
 1;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.cache_policy =3D =
cache_policy__mec_release_mem__lru;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.data_sel =3D data=
_sel__mec_release_mem__send_32_bit_low;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.int_sel =3D<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; int_sel__mec_release_mem__send_interrupt_after_write_confirm;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.address_lo_32b =
=3D (gpu_addr &amp; 0xffffffff) &gt;&gt; 2;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;address_hi =3D upper_32_bits=
(gpu_addr);<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;data_lo =3D 0;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; -}<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp; const struct packet_manager_funcs kfd_v9_pm_funcs =3D=
 {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_process_=
v9,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D pm_runlist_v9,<br>
&gt; &gt; @@ -372,12 &#43;343,12 @@ const struct packet_manager_funcs kfd_v=
9_pm_funcs =3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_map_que=
ues_v9,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_unmap_queues_v9,<=
br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_query_status_v9,<=
br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_release_mem_v9,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D NULL,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_process_size&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_map_process),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .runlist_size&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_me=
s_runlist),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_resources_size&nbs=
p;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_set_resources),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .map_queues_size&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_map_queues),<=
br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues_size&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_unmap_queues),<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_status_size&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_query_status),<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D sizeof(struct pm4_mec_release_mem)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D 0,<br>
&gt; &gt;&nbsp;&nbsp; };<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lists.f=
reedesktop.org" moz-do-not-send=3D"true">
amd-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz=
-do-not-send=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</blockquote>
</div>
</blockquote>
</blockquote>
</body>
</html>

--_000_7b604d5d5c1fc48cc829b42ef6bd403bamdcom_--

--===============0153603842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0153603842==--
