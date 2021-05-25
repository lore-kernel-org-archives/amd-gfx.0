Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9B1C2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 15:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6FA6141D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 15:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6FA6141D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AEA26E328;
	Tue, 25 May 2021 15:18:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02486E07F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 15:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLp0vyvfp8zbzYTIjUlaGEu/y/M/GuZPk9s5W8QzWgUJav6IB/J0uf0efGvl59q2EbYcULIs5t5fTYAdQkg8koE0kOIG0ggTHXiQZYsi0dTTJHUJ4sjrAWjTTVcu+gCn4rtFHF5eZod80TnTuiSd5hJkQ1gfGMtPwu4MeOP/NGtYAKVPvcWCtwgwksOMsQK0QYcZ2ymgt8616R0QU/P7V1O+X4+AYuZjwg6vz5qrX2ee2GCotRm21OKCcVkWwxtwp95fWvenu1ZrbR1c05FBKkEWFf12Hi4F4/pbJ+9IVvr2t+/xuAADdgGuF8xu+NjVmIbp9hy/+Q3I8wCk+uzgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEZHZG3YA/SwR3VRcsmdGOQ2GP1J1kaYGVmBELW220o=;
 b=FuR3nhujLvpox3moDYeREeQKGay4Vd9hxDXbt5Rb+kzfDZVL5b6KpuizQi2QcFxDU2FNQP7UXhULXoPEjPHpML1y5AJikGgZBqwgEDjnLTyWlSMljU4HvY8zY76mnxWOF2srs+6VmaL+Gb6/iAyfiMP4SPFIg7qBxnExVUKSePUZF2B0UnjxBMlx75FlP7sHs9IaUdpsfPoy8ynVJMGr3/B19qiAu682/fekdgZ8Hn3Z9+b4B0EJCYNEHIiOWD8pLIPYhwvnZN/0kIgoqPm7ekRX1NMlavTAGqF2LwQIxL6UyYIwBE8/d9WaNtlMRhzT+Eaj8r3oWHRICLZrIpQJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEZHZG3YA/SwR3VRcsmdGOQ2GP1J1kaYGVmBELW220o=;
 b=jB2wqL43i+cktMBFy3acqLetB7PkgdeapAqNOWwZwK5mii6TJE/zZdONAV84AXUW8N8396VzdUXvrvglJeSASGF2ZWP91hPiWEFG+hgRCi/PAHqfSH8WCAMB0UzxBP/fcpP15WEp5E7FYUVLKQV0tdKIUcXC/+pL6NBB2l6uybE=
Received: from BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 15:18:45 +0000
Received: from BL1PR12MB5238.namprd12.prod.outlook.com
 ([fe80::ddf9:3138:4967:c3df]) by BL1PR12MB5238.namprd12.prod.outlook.com
 ([fe80::ddf9:3138:4967:c3df%3]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 15:18:45 +0000
From: "Ming, Davis" <Davis.Ming@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Khaire, Rohit" <Rohit.Khaire@amd.com>
Subject: RE: [PATCH v5 01/10] drm/amdgpu: Indirect register access for Navi12
 sriov
Thread-Topic: [PATCH v5 01/10] drm/amdgpu: Indirect register access for Navi12
 sriov
Thread-Index: AQHXSyptilLfNdTJpEC7Uq6pCXE4iarnvtEAgAMi0RCACXpv8A==
Date: Tue, 25 May 2021 15:18:45 +0000
Message-ID: <BL1PR12MB5238133AAB842422AAFE236497259@BL1PR12MB5238.namprd12.prod.outlook.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
 <DM8PR12MB5478B352B7F1D70855826CB2F82D9@DM8PR12MB5478.namprd12.prod.outlook.com>
 <DM8PR12MB547846C12D8F143579F031DAF82B9@DM8PR12MB5478.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB547846C12D8F143579F031DAF82B9@DM8PR12MB5478.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-19T14:34:13Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=053e5205-a5d7-4149-afdd-3529f2b0e29d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:9880:3547:ff6d:89de:7c25:9c48:6933]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0683aa84-d928-45dd-eaeb-08d91f9063b4
x-ms-traffictypediagnostic: BL1PR12MB5142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5142B5761FED93930CD0D98297259@BL1PR12MB5142.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3rJXxhgqCLiw12ijV6IrLQi5+0xHTLkhGjPYuPMDU4zA7uELeMowmGfWXEI6eZvXxBi5MP/NCEQ0wZONgFNpk/hqD+9mjiYCQT8Pb1xOH5dauNpD6TDqM7zyRD4H+J4DIWWMYybnUUp/XL4D7gJ4YkNiYLKQw7cOFF16/PW3OdzlYmg7SV1RVnlQ8Zj3xKNaGe8I5DKPM4D7ZBpufrOTi21FEYa1BGRzgPMyspXRHNyhqogRGPbqNC9DtP4m6bx05FB6j3RcwaTjp/9EO4F2Y1uxpnYvBiGBbprHO69M7lio1olzbCWk7Ecb6iQwKfiaw9ZS96ZActKHP76ERDTfkmcJ1inHUWAVMlvWaQ4veXoxN/XEIWXraUdFEezKfIKmZ2b0q9Lr8mzMJsqYF6t8+9ZZl0OLcL2qU2OHm7/eiXOpb+RTkKLGii3dDPMT92POlcsxG2ZjyTMzl5QVzUv9FemsIZG71cOl2hKmuS1lnGtlY77JMgXImC1kwfKFVoIXkwgmOmIH1+tyzb66v8dUq5/5lEXfs/TelcMsrrmbk6QpY8n2y3LdxNbIqZXDackz86xpLY8vWoKUKqLkDHZm+fghD8e7gmveuM05kPYE44Phh959cPiKAme1TDeWMTybyVfyI9FAW1vzjV5oMClMxUqpauBQwq45yhilIW/AWeAV5QozLzuin1hZNmudoy4N7Pzhj3HsrxPdQOexPdtV251RRuMw+TNvAepNpdhAK4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39850400004)(396003)(136003)(8676002)(110136005)(8936002)(54906003)(2906002)(4326008)(33656002)(316002)(76116006)(7696005)(83380400001)(5660300002)(52536014)(66946007)(9686003)(66476007)(66446008)(186003)(64756008)(6506007)(53546011)(38100700002)(6636002)(55016002)(45080400002)(122000001)(84040400003)(478600001)(966005)(30864003)(86362001)(71200400001)(66556008)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QTHKbno+nUhiHRXJmqNSIG4b60+4tqtIFJvLu9e4StIbzKzVQ/wrRbnyGdlE?=
 =?us-ascii?Q?ZC//xI5E8DB0Or17hJZbbONS4PHQGg9Fm+dXYzcHNdKl3u9HS9C3xk3Hpi/O?=
 =?us-ascii?Q?UqqYtOu5FcHIhbNJX+ovNh0pPjjD8tRPc4sAsyKhieuHrB3vDaiPRRw3AWZm?=
 =?us-ascii?Q?Ban5K0/756KeayTzB8HCbfhid0KHLwYrR6/5txRQR1xQdp30tVJvViPUbkU7?=
 =?us-ascii?Q?h5qZeSNEXZXeArBDS+kdJdU+9logXuVwJXQ5kG//Tw4stFhlW46f5H9Rw0eI?=
 =?us-ascii?Q?lEyN8iDgqjYShnRaT6NmnNIJmLjGzrP1uoNQdgpb+aXrupdjBdGNMvopN0a1?=
 =?us-ascii?Q?aVNWdVyv9ZnTntwKA6G4jJB4M2NWxDbtFzxBZyFEdbBzBxSdyrlx52Zh8OgQ?=
 =?us-ascii?Q?XbBXHh997WEx47lB7ia1Sa64z14KqckiGlzuk3ufbJrYnsTv7KW84wrF5s+R?=
 =?us-ascii?Q?aA3QJfD1PW+b9w/GU+rxxoVZLR/1gMmo9CEUFgDzG0NuIDArxtXqXpfuRHLv?=
 =?us-ascii?Q?RSA+7N+VuVI7fcrOKbai5aKJQFPkqUpRdTHmZaOFviFnpl6KxGv0KqdEa0bi?=
 =?us-ascii?Q?on2kuS79rV4pJBNEZ5pzieGgQna72njAtcgrgrvFg5GUFg36oEvj/7m34Ln5?=
 =?us-ascii?Q?h2ne92SCeHDxGWvz+39+899fCZKtWIodCVMJ45cIi8BFX6D/QS6bBkuT31KL?=
 =?us-ascii?Q?KL3uYLHJZ/NS/oduvrqmuc8vYaTt+kqokP1cvoHeZdmtyK+xU21w5AId9JRx?=
 =?us-ascii?Q?CMdW76kSGZCTRPGwa2e7z5ifto4m9cCtvR98FydY90ukkOKR+I+tt9EbrzBb?=
 =?us-ascii?Q?tB0d1x5gm2jdTTWVe/diM3miNkT89kHMEYsNgoGmkRqz8AyLS4e8r4G077ls?=
 =?us-ascii?Q?bawT9mPfOUeeOO+q1chs6mGabMxMihxqn7m820TAd8cc8yOg1BUXDzSOGtv/?=
 =?us-ascii?Q?DmkYh9Dr2An4Mp158HydiM8Js+KLnT409qqvVKC/inimtdZZSOAXQe3Wg/mz?=
 =?us-ascii?Q?QuHjCz0avf1M8HGZfFq2/67GlaOa4tD3CDLQB9FvRN+BLX0YyM7qjk96i1RV?=
 =?us-ascii?Q?Cv+ElenQb6MExu5lbrLTa/aBQXkbKi7yxZRcdQ6eZVDPlOs5ICpLSJvYu5WO?=
 =?us-ascii?Q?2aGO9u2cMpXf67Ji1dfNps3vQCOQZpzNrJkZzIBO7sFEAIsPXeZBuaaKFdfe?=
 =?us-ascii?Q?2Wlvf3HIEGVMpen8d2davM8YaiI32FGXQA2Sx58QG9z5atqx2m38jAG1jqWn?=
 =?us-ascii?Q?HQF1z0nTHxoRFWFlnGFJCzghC+KzP7oosSqFefv/rHTAhi7wTg1+Yfp+lgRQ?=
 =?us-ascii?Q?OBcURJmeKo68ZLn4Pkf/L1GrfSFACFAZN+aDibdpECGvnMVBtnGOQX5aXCJy?=
 =?us-ascii?Q?3iN087d79+k5mPtPz5tBTEFhK/3k?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0683aa84-d928-45dd-eaeb-08d91f9063b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 15:18:45.7153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TS1X9hC3chdFch4qAOxeQzXnftOsfdFRdmBJuZpufXVzsl6bvrRZYl+suDZe8IKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+Rohit

-----Original Message-----
From: Zhou, Peng Ju <PengJu.Zhou@amd.com> 
Sent: Wednesday, May 19, 2021 10:34 AM
To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>; Ming, Davis <Davis.Ming@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>
Subject: RE: [PATCH v5 01/10] drm/amdgpu: Indirect register access for Navi12 sriov

[AMD Official Use Only - Internal Distribution Only]

Ping on this series.


---------------------------------------------------------------------- 
BW
Pengju Zhou



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhou,
> Peng Ju
> Sent: Monday, May 17, 2021 10:50 PM
> To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Ming, Davis
> <Davis.Ming@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>
> Subject: RE: [PATCH v5 01/10] drm/amdgpu: Indirect register access for
> Navi12 sriov
> 
> [AMD Official Use Only - Internal Distribution Only]
> 
> Hi Alex
> About your comment:
> "I think patches 1-4, 16 need to be squashed together to avoid breaking the
> build.  Please also provide a description of how the new macros work in the
> patch description.  Describe how the reworked macros properly handle
> sending GC and MMHUB accesses via the RLC rather than via some other
> mechanism.  It's really hard to follow the macro logic."
> 
> I squashed patches 1-4, 16 and add more detail description in the patch
> description.
> Can you help to review the patch series?
> 
> 
> ----------------------------------------------------------------------
> BW
> Pengju Zhou
> 
> 
> 
> > -----Original Message-----
> > From: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > Sent: Monday, May 17, 2021 10:39 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> > Subject: [PATCH v5 01/10] drm/amdgpu: Indirect register access for Navi12
> > sriov
> >
> > This patch series are used for GC/MMHUB(part)/IH_RB_CNTL indirect
> access
> > in the SRIOV environment.
> >
> > There are 4 bits, controlled by host, to control if
> > GC/MMHUB(part)/IH_RB_CNTL indirect access enabled.
> > (one bit is master bit controls other 3 bits)
> >
> > For GC registers, changing all the register access from MMIO to RLC and use
> > RLC as the default access method in the full access time.
> >
> > For partial MMHUB registers, changing their access from MMIO to RLC in
> the
> > full access time, the remaining registers keep the original access method.
> >
> > For IH_RB_CNTL register, changing it's access from MMIO to PSP.
> >
> > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    |  4 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 78 +++++++++----------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  9 ++-
> >  drivers/gpu/drm/amd/amdgpu/soc15_common.h  | 87 +++++++++++++----
> --
> > ---
> >  6 files changed, 97 insertions(+), 84 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 3147c1c935c8..4e0c90e52ab6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1147,6 +1147,7 @@ int emu_soc_asic_init(struct amdgpu_device
> > *adev);
> >   * Registers read & write functions.
> >   */
> >  #define AMDGPU_REGS_NO_KIQ    (1<<1)
> > +#define AMDGPU_REGS_RLC	(1<<2)
> >
> >  #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg),
> > AMDGPU_REGS_NO_KIQ)  #define WREG32_NO_KIQ(reg, v)
> > amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ) diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 7c6c435e5d02..a2392bbe1e21 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -490,7 +490,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct
> > amdgpu_device *adev,
> >  	    adev->gfx.rlc.funcs &&
> >  	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
> >  		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
> > -			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0);
> > +			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0,
> > 0);
> >  	} else {
> >  		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> >  	}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > index 4fc2ce8ce8ab..7a4775ab6804 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> > @@ -127,8 +127,8 @@ struct amdgpu_rlc_funcs {
> >  	void (*reset)(struct amdgpu_device *adev);
> >  	void (*start)(struct amdgpu_device *adev);
> >  	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned
> > vmid);
> > -	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32
> > flag);
> > -	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 flag);
> > +	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32
> > acc_flags, u32 hwip);
> > +	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32
> > +acc_flags, u32 hwip);
> >  	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t
> > reg);  };
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index 2a3427e5020f..7c5c1ff7d97e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -1427,38 +1427,36 @@ static const struct soc15_reg_golden
> > golden_settings_gc_10_1_2[] =
> >  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff,
> > 0x00800000)  };
> >
> > -static bool gfx_v10_is_rlcg_rw(struct amdgpu_device *adev, u32 offset,
> > uint32_t *flag, bool write) -{
> > -	/* always programed by rlcg, only for gc */
> > -	if (offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI) ||
> > -	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO) ||
> > -	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH) ||
> > -	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL) ||
> > -	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX) ||
> > -	    offset == SOC15_REG_OFFSET(GC, 0, mmCP_ME_CNTL)) {
> > -		if (!amdgpu_sriov_reg_indirect_gc(adev))
> > -			*flag = GFX_RLCG_GC_WRITE_OLD;
> > -		else
> > -			*flag = write ? GFX_RLCG_GC_WRITE :
> > GFX_RLCG_GC_READ;
> > +static bool gfx_v10_get_rlcg_flag(struct amdgpu_device *adev, u32
> > acc_flags, u32 hwip,
> > +				 int write, u32 *rlcg_flag)
> > +{
> > +	switch (hwip) {
> > +	case GC_HWIP:
> > +		if (amdgpu_sriov_reg_indirect_gc(adev)) {
> > +			*rlcg_flag = write ? GFX_RLCG_GC_WRITE :
> > GFX_RLCG_GC_READ;
> >
> > -		return true;
> > -	}
> > +			return true;
> > +		/* only in new version, AMDGPU_REGS_NO_KIQ and
> > AMDGPU_REGS_RLC enabled simultaneously */
> > +		} else if ((acc_flags & AMDGPU_REGS_RLC) && !(acc_flags &
> > AMDGPU_REGS_NO_KIQ)) {
> > +			*rlcg_flag = GFX_RLCG_GC_WRITE_OLD;
> >
> > -	/* currently support gc read/write, mmhub write */
> > -	if (offset >= SOC15_REG_OFFSET(GC, 0, mmSDMA0_DEC_START) &&
> > -	    offset <= SOC15_REG_OFFSET(GC, 0, mmRLC_GTS_OFFSET_MSB)) {
> > -		if (amdgpu_sriov_reg_indirect_gc(adev))
> > -			*flag = write ? GFX_RLCG_GC_WRITE :
> > GFX_RLCG_GC_READ;
> > -		else
> > -			return false;
> > -	} else {
> > -		if (amdgpu_sriov_reg_indirect_mmhub(adev))
> > -			*flag = GFX_RLCG_MMHUB_WRITE;
> > -		else
> > -			return false;
> > +			return true;
> > +		}
> > +
> > +		break;
> > +	case MMHUB_HWIP:
> > +		if (amdgpu_sriov_reg_indirect_mmhub(adev) &&
> > +		    (acc_flags & AMDGPU_REGS_RLC) && write) {
> > +			*rlcg_flag = GFX_RLCG_MMHUB_WRITE;
> > +			return true;
> > +		}
> > +
> > +		break;
> > +	default:
> > +		DRM_DEBUG("Not program register by RLCG\n");
> >  	}
> >
> > -	return true;
> > +	return false;
> >  }
> >
> >  static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v,
> > uint32_t flag) @@ -1518,36 +1516,34 @@ static u32 gfx_v10_rlcg_rw(struct
> > amdgpu_device *adev, u32 offset, u32 v, uint32
> >  	return ret;
> >  }
> >
> > -static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32
> > value, u32 flag)
> > +static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
> > +u32 value, u32 acc_flags, u32 hwip)
> >  {
> > -	uint32_t rlcg_flag;
> > +	u32 rlcg_flag;
> >
> > -	if (amdgpu_sriov_fullaccess(adev) &&
> > -	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 1)) {
> > +	if (!amdgpu_sriov_runtime(adev) &&
> > +	    gfx_v10_get_rlcg_flag(adev, acc_flags, hwip, 1, &rlcg_flag)) {
> >  		gfx_v10_rlcg_rw(adev, offset, value, rlcg_flag);
> > -
> >  		return;
> >  	}
> > -	if (flag & AMDGPU_REGS_NO_KIQ)
> > +
> > +	if (acc_flags & AMDGPU_REGS_NO_KIQ)
> >  		WREG32_NO_KIQ(offset, value);
> >  	else
> >  		WREG32(offset, value);
> >  }
> >
> > -static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset, u32
> > flag)
> > +static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset,
> > +u32 acc_flags, u32 hwip)
> >  {
> > -	uint32_t rlcg_flag;
> > +	u32 rlcg_flag;
> >
> > -	if (amdgpu_sriov_fullaccess(adev) &&
> > -	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 0))
> > +	if (!amdgpu_sriov_runtime(adev) &&
> > +	    gfx_v10_get_rlcg_flag(adev, acc_flags, hwip, 0, &rlcg_flag))
> >  		return gfx_v10_rlcg_rw(adev, offset, 0, rlcg_flag);
> >
> > -	if (flag & AMDGPU_REGS_NO_KIQ)
> > +	if (acc_flags & AMDGPU_REGS_NO_KIQ)
> >  		return RREG32_NO_KIQ(offset);
> >  	else
> >  		return RREG32(offset);
> > -
> > -	return 0;
> >  }
> >
> >  static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] = diff
> -
> > -git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index feaa5e4a5538..fe5908f708cc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -734,7 +734,7 @@ static const u32
> > GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
> >  	mmRLC_SRM_INDEX_CNTL_DATA_7 -
> > mmRLC_SRM_INDEX_CNTL_DATA_0,  };
> >
> > -static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32
> v,
> > u32 flag)
> > +static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32
> > +v, u32 flag)
> >  {
> >  	static void *scratch_reg0;
> >  	static void *scratch_reg1;
> > @@ -787,15 +787,16 @@ static void gfx_v9_0_rlcg_rw(struct
> amdgpu_device
> > *adev, u32 offset, u32 v, u32
> >
> >  }
> >
> > -static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
> u32
> > v, u32 flag)
> > +static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
> > +			       u32 v, u32 acc_flags, u32 hwip)
> >  {
> >  	if (amdgpu_sriov_fullaccess(adev)) {
> > -		gfx_v9_0_rlcg_rw(adev, offset, v, flag);
> > +		gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
> >
> >  		return;
> >  	}
> >
> > -	if (flag & AMDGPU_REGS_NO_KIQ)
> > +	if (acc_flags & AMDGPU_REGS_NO_KIQ)
> >  		WREG32_NO_KIQ(offset, v);
> >  	else
> >  		WREG32(offset, v);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> > b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> > index 14bd794bbea6..c781808e4dc3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> > @@ -27,28 +27,51 @@
> >  /* Register Access Macros */
> >  #define SOC15_REG_OFFSET(ip, inst, reg)	(adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> >
> > +#define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
> > +	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
> > +	 adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
> > +	 WREG32(reg, value))
> > +
> > +#define __RREG32_SOC15_RLC__(reg, flag, hwip) \
> > +	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
> > +	 adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
> > +	 RREG32(reg))
> > +
> >  #define WREG32_FIELD15(ip, idx, reg, field, val)	\
> > -	WREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX]
> > + mm##reg,	\
> > -	(RREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX]
> > + mm##reg)	\
> > -	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg,
> > field))
> > +	 __WREG32_SOC15_RLC__(adev-
> > >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
> > +				(__RREG32_SOC15_RLC__( \
> > +					adev-
> > >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
> > +					0, ip##_HWIP) & \
> > +				~REG_FIELD_MASK(reg, field)) | (val) <<
> > REG_FIELD_SHIFT(reg, field), \
> > +			      0, ip##_HWIP)
> >
> >  #define RREG32_SOC15(ip, inst, reg) \
> > -	RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> > +	__RREG32_SOC15_RLC__(adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
> > +			 0, ip##_HWIP)
> > +
> > +#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0,
> > +ip##_HWIP)
> >
> >  #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
> > -	RREG32_NO_KIQ(adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> > +	__RREG32_SOC15_RLC__(adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
> > +			 AMDGPU_REGS_NO_KIQ, ip##_HWIP)
> >
> >  #define RREG32_SOC15_OFFSET(ip, inst, reg, offset) \
> > -	RREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> > + offset)
> > +
> > +__RREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > ++ reg) + offset, 0, ip##_HWIP)
> >
> >  #define WREG32_SOC15(ip, inst, reg, value) \
> > -	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg),
> > value)
> > +	 __WREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), \
> > +			  value, 0, ip##_HWIP)
> > +
> > +#define WREG32_SOC15_IP(ip, reg, value) \
> > +	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP)
> >
> >  #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
> > -	WREG32_NO_KIQ((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
> > +	__WREG32_SOC15_RLC__(adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
> > +			     value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
> >
> >  #define WREG32_SOC15_OFFSET(ip, inst, reg, offset, value) \
> > -	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> > + offset, value)
> > +	 __WREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, \
> > +			  value, 0, ip##_HWIP)
> >
> >  #define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask) \
> >  ({	int ret = 0;						\
> > @@ -77,12 +100,7 @@
> >  })
> >
> >  #define WREG32_RLC(reg, value) \
> > -	do { \
> > -		if (adev->gfx.rlc.funcs->rlcg_wreg) \
> > -			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, 0); \
> > -		else \
> > -			WREG32(reg, value);	\
> > -	} while (0)
> > +	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP)
> >
> >  #define WREG32_RLC_EX(prefix, reg, value) \
> >  	do {							\
> > @@ -108,24 +126,19 @@
> >  		}	\
> >  	} while (0)
> >
> > +/* shadow the registers in the callback function */
> >  #define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
> > -	WREG32_RLC((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > + reg), value)
> > +
> > +__WREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > ++ reg), value, AMDGPU_REGS_RLC, GC_HWIP)
> >
> > +/* for GC only */
> >  #define RREG32_RLC(reg) \
> > -	(adev->gfx.rlc.funcs->rlcg_rreg ? \
> > -		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, 0) : RREG32(reg))
> > -
> > -#define WREG32_RLC_NO_KIQ(reg, value) \
> > -	do { \
> > -		if (adev->gfx.rlc.funcs->rlcg_wreg) \
> > -			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value,
> > AMDGPU_REGS_NO_KIQ); \
> > -		else \
> > -			WREG32_NO_KIQ(reg, value);	\
> > -	} while (0)
> > +	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)
> > +
> > +#define WREG32_RLC_NO_KIQ(reg, value, hwip) \
> > +	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ |
> > AMDGPU_REGS_RLC,
> > +hwip)
> >
> > -#define RREG32_RLC_NO_KIQ(reg) \
> > -	(adev->gfx.rlc.funcs->rlcg_rreg ? \
> > -		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg,
> > AMDGPU_REGS_NO_KIQ) : RREG32_NO_KIQ(reg))
> > +#define RREG32_RLC_NO_KIQ(reg, hwip) \
> > +	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ |
> > AMDGPU_REGS_RLC, hwip)
> >
> >  #define WREG32_SOC15_RLC_SHADOW_EX(prefix, ip, inst, reg, value) \
> >  	do {							\
> > @@ -146,12 +159,12 @@
> >  	} while (0)
> >
> >  #define RREG32_SOC15_RLC(ip, inst, reg) \
> > -	RREG32_RLC(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] +
> > reg)
> > +	__RREG32_SOC15_RLC__(adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > ++ reg, AMDGPU_REGS_RLC, ip##_HWIP)
> >
> >  #define WREG32_SOC15_RLC(ip, inst, reg, value) \
> >  	do {							\
> >  		uint32_t target_reg = adev-
> > >reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg;\
> > -		WREG32_RLC(target_reg, value); \
> > +		__WREG32_SOC15_RLC__(target_reg, value,
> > AMDGPU_REGS_RLC, ip##_HWIP);
> > +\
> >  	} while (0)
> >
> >  #define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \ @@ -161,14
> > +174,16 @@
> >  	} while (0)
> >
> >  #define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
> > -	WREG32_RLC((adev-
> > >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
> > -	(RREG32_RLC(adev-
> > >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg) \
> > -	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg,
> > field))
> > +	__WREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
> > +			     (__RREG32_SOC15_RLC__(adev-
> > >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
> > +						   AMDGPU_REGS_RLC,
> > ip##_HWIP) & \
> > +			      ~REG_FIELD_MASK(reg, field)) | (val) <<
> > REG_FIELD_SHIFT(reg, field), \
> > +			     AMDGPU_REGS_RLC, ip##_HWIP)
> >
> >  #define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
> > -	WREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > + reg) + offset), value)
> > +
> > +__WREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > ++ reg) + offset, value, AMDGPU_REGS_RLC, ip##_HWIP)
> >
> >  #define RREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset) \
> > -	RREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] +
> > reg) + offset))
> > +
> > +__RREG32_SOC15_RLC__((adev-
> > >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> > ++ reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP)
> >
> >  #endif
> > --
> > 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPengju.Zhou%40amd.com%7C5593a422cc7e48b
> 80f6c08d9194308ae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
> C637568597973904052%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd
> ata=a4brqHQ43K6fkF%2BAgWWclhZdgEs2SpThk%2BFYcmaInTM%3D&amp;r
> eserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
