Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512B1C4BA1E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 17:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2955D24680
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 17:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IAJ+xclS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2955D24680
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22876E442;
	Wed, 26 Feb 2020 17:49:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5A76E442
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 17:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9LTkShTF4Bg6QLJZX6QH3TdDMYFEWPCetTo0lqhX8jvkOV2EI1nx9vDsQFTe4Jm7upDpusrNxhh2uR9CBVycZJHMM6JoWEEfnZb9IwjIW9VCEOONlVzJKHQ+9+T16DUxNi/GZ4aN7oS4LD2Kn8ZroSWFIVLPQekvRQMGAQHOgd1vat8y4xnvYsS2AiEPNDfPzkYErxn1tFpD4AtOBCyqj4Th+R44c08LMmSOBJP3nMkCe5BdEqmH7GGa+rp+EUEJ2eP3mh1lYKi9a81V6GArBd/C3G1ha2lNPTMiUeWckpw+P3vyaSmqzUtIQ4+Sy66K5C8QxV2Gir8/wxLzPeQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfZQ1WCGK6wzFKnSiysSkCOWvTejMetTG4R4v1+Scyw=;
 b=B5d4tM8zABHRWRi42MTbKUqUmW/CBp2VYk5U9/rF8FRlbMoa8FUUh1IiRvOsch/TmF/jcLT1OVHsS0b710bOCJ4pXLYwboL2JUW5vQCoBKGbZuEwRx8wquVRhq7NYgrXa5fjxMlAlRfuDD2/UwPVDy4oJ4ne1DU+/pioUewdhGqZSTvTAkzxcRmQXBv+vxPXQJPpM0ZNyGrH3aCeIrCLe+t7ZPHa4w07hXsNp5kIC06jmT/HLPDrrUj3tkkE6zzFK3ndTNglm7Vx+hek+aUREmGPqEw4j0K10cq6XceuwHHhnlktTkCAkGELVgzRcOw9XH/7g4I6Qez2KVU5/SzP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfZQ1WCGK6wzFKnSiysSkCOWvTejMetTG4R4v1+Scyw=;
 b=IAJ+xclSXF7PMge4r36cmlMnw80J5jqug7R/RKQsXWRcngmQWaxXaj2MEIMZqG4WAfNjFJzObcSlDGZa8LPnwUf9opgkbGKHr/i6VpzdF7nK+hu6YpTDnpd+x9gNht8sfjZ3l42HQpCIrBWXnObbSY3YHzd6cWU+ZNKuRhFoLOo=
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB2537.namprd12.prod.outlook.com (2603:10b6:3:eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Wed, 26 Feb
 2020 17:49:56 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 17:49:56 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)
Thread-Topic: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)
Thread-Index: AQHV7MGCOAIwAwjdVU+FpXLqC5c7Kqgts6mQgAAM71A=
Date: Wed, 26 Feb 2020 17:49:56 +0000
Message-ID: <DM5PR1201MB0090BB36BD24983079217D7E92EA0@DM5PR1201MB0090.namprd12.prod.outlook.com>
References: <20200226153429.2ae6d7aa@canb.auug.org.au>
 <591615ff-f3ae-c759-504b-582452945d07@infradead.org>
 <DM5PR1201MB0090194AFCE8D5361B68463E92EA0@DM5PR1201MB0090.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB0090194AFCE8D5361B68463E92EA0@DM5PR1201MB0090.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-26T17:10:33Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=13531fd8-6871-4cff-adb4-0000fd02152a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-26T17:49:54Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7f3d99e3-8282-472e-b57b-00002c29134e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e848f11-0e47-4f25-35d3-08d7bae44ac8
x-ms-traffictypediagnostic: DM5PR1201MB2537:|DM5PR1201MB2537:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2537A691AFA6EA05F84C4AC192EA0@DM5PR1201MB2537.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(52536014)(186003)(2906002)(26005)(71200400001)(8936002)(81156014)(86362001)(81166006)(8676002)(53546011)(6636002)(2940100002)(7696005)(6506007)(5660300002)(110136005)(66476007)(66446008)(64756008)(66946007)(76116006)(66556008)(9686003)(478600001)(55016002)(33656002)(316002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2537;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c/LchXkNFmSbZTCfHdMkdUBKzpleAL55FpCF5HcmdH7U5MBtgak9z4C1EVzbsjbevdlw7/VkZBBQk+bKsTyyGpRX0k7rQtcFRpHv4+JqWw+Wdan77qNVTI/o0qMH668Yn0+r9rNoMwFPz0ng/kKkFjJvk+dw/AEGCk5QhcZLFApX0TL/sCfc7CHyCyjkUByu7l159BoOUJhTxfA8CNi5xrjBX0RCjuZa2jT8ZBgpTnAiUzviOpmE0pV1NDOJTszg4DC9O2CbAivfduabjBfSLL9dhFSnq1ro9fhLnaTlwCYWADMkpxm8NbZfE9r2H0Sz3CBPJf/YgFQkpb946y6rIwXnPQEpt3/8Z78QnP/4buOoob6OW8IP4KZQ3BzUR8AtrdweqMNzQiIukFuNRLCkp9HkP3MLn7sMR97Xq+LGwvY3PXfp5ze9iprREz7oZnYt
x-ms-exchange-antispam-messagedata: zRuIK3deo0bRID/4cQAcdzsVdF/fNsRtt9NJNmnNBMvV/RSI5RmJmFldIJv0wneAzzDtBMpSLQGTGg9VRHvoC/k61KBL8lxinLYy5uf2gMmWeD6o3bo3hHg9DdG6KaVFMpI3vStpbFWVXrOAC8egsQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e848f11-0e47-4f25-35d3-08d7bae44ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 17:49:56.5619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sH2x+woaHcqrCpeAlReKk3MMkzWaSxvOI/rReP2yaopRULu/kS5jNZ9SzWyH/UqpTtkLhe4seZjYpItAzdgWbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2537
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

I pushed the fix to amd-staging-drm-next. How do we get this into linux-nex=
t?

-----Original Message-----
From: Kuehling, Felix =

Sent: Wednesday, February 26, 2020 11:11
To: Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander (Alexander.Deucher=
@amd.com) <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: RE: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)

[AMD Official Use Only - Internal Distribution Only]

[Dropping most, +Alex, +Xinhui]

Looks like this was introduced by Xinhui's change:
commit be8e48e0849943fb53457e2fd83905eaf19cb1f7
Author: xinhui pan <xinhui.pan@amd.com>
Date:   Tue Feb 11 11:28:34 2020 +0800

    drm/amdgpu: Remove kfd eviction fence before release bo

    No need to trigger eviction as the memory mapping will not be used
    anymore.

    All pt/pd bos share same resv, hence the same shared eviction fence.
    Everytime page table is freed, the fence will be signled and that cuases
    kfd unexcepted evictions.

    CC: Christian K=F6nig <christian.koenig@amd.com>
    CC: Felix Kuehling <felix.kuehling@amd.com>
    CC: Alex Deucher <alexander.deucher@amd.com>
    Acked-by: Christian K=F6nig <christian.koenig@amd.com>
    Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
    Signed-off-by: xinhui pan <xinhui.pan@amd.com>

I'm preparing a fix. Will send it out in a second.

Regards,
  Felix

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Randy Du=
nlap
Sent: Wednesday, February 26, 2020 10:03
To: Stephen Rothwell <sfr@canb.auug.org.au>; Linux Next Mailing List <linux=
-next@vger.kernel.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>; Linux Kernel Mailing List =
<linux-kernel@vger.kernel.org>; amd-gfx@lists.freedesktop.org
Subject: Re: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)

On 2/25/20 8:34 PM, Stephen Rothwell wrote:
> Hi all,
> =

> Changes since 20200225:
> =


on i386:

ld: drivers/gpu/drm/amd/amdgpu/amdgpu_object.o: in function `amdgpu_bo_rele=
ase_notify':
amdgpu_object.c:(.text+0xe07): undefined reference to `amdgpu_amdkfd_remove=
_fence_on_pt_pd_bos'


Full randconfig file is attached.

-- =

~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
