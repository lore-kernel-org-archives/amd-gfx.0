Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF68C4BA18
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 17:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6597206E6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 17:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mfXv6RW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6597206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF646EB20;
	Wed, 26 Feb 2020 17:10:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61AE46EB20
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 17:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIVVaIGf2wOaCxXE7a9s/1H5VHSCcnaqzlwmIGWma5tE2MRGDij5IdshpzhP+RqtlBKKp1wD+XcIV0OBtOyYLKds42Hi9m2S0LUDlpRgmjIRHm9DNXZvhOu602UDucbKo6QOjWqJxkLF2hKX0K2dlKRChKViciraTn0eVZKkLYxV4MYk6NnN6wwEtiwoMdbyk+eYu9KV/ARO4V5op2YqGHIhJG2uCoxbVA/eDu2LELPFEdUA2RalJStQfGfG8TaZGGahwSx/BqqTzJfWg4EM5PGkXOG4FTKzWRd1f64dGUeBTW2DYIaQNubqMuUkP4t73c3psceplAcxNH9LfUnXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQWkUg5HZnkIUHP59s137AQ/bMMnaaNzkOG/4j29uhc=;
 b=mHpTV/9ZPaCbv6uN56/2QNS8ZqAq+a4u+CLibgvsTpCvMpXfqCpoaTXqiEWH9xlQFeFSntZCcGCpEVU7YR3AKeneOP2SLBGag65UlrnMUUDkWmHQlHG8YjgNHTblLouLNIBCmtLQewvWMLD4o2Gwo58vlsX9wfkWyAYufUOZYqSavSL49QipASuMT0FL+lOhnvqajt1LTl6fXRk+e0p4oQJ2t5UbRct3Ue4eAurqKdJOWeVexmqhU50z4s2h5k6Dx/RQ7qc3HqoiBmeq0T1ShiGh3lykuwHlTOmuT1k9b2Q+1MN26g3VNGWRIOAZrmgxOlIcSVizxiBooxtjvv9iyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQWkUg5HZnkIUHP59s137AQ/bMMnaaNzkOG/4j29uhc=;
 b=mfXv6RW/qvJwGhDXs4yKyKoWL7UKo+MjPZ/lzs5J6j7i4bCWDzEhjB5+IWsyQI3EFkpD1Lrcfvcey9eA5AG6pgUIqlxwDHXUdw7L4sQUiSC694Z8a/Lq5VEVihV2IsB9Yx4hwD9+0tySNh+i77rN1LIe6KP/nYNTcyQY06tsDKE=
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB0009.namprd12.prod.outlook.com (2603:10b6:3:de::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Wed, 26 Feb
 2020 17:10:35 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 17:10:35 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)
Thread-Topic: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)
Thread-Index: AQHV7MGCOAIwAwjdVU+FpXLqC5c7Kqgts6mQ
Date: Wed, 26 Feb 2020 17:10:35 +0000
Message-ID: <DM5PR1201MB0090194AFCE8D5361B68463E92EA0@DM5PR1201MB0090.namprd12.prod.outlook.com>
References: <20200226153429.2ae6d7aa@canb.auug.org.au>
 <591615ff-f3ae-c759-504b-582452945d07@infradead.org>
In-Reply-To: <591615ff-f3ae-c759-504b-582452945d07@infradead.org>
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-26T17:10:33Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5df6cfe4-54c3-442a-8025-00002f4eaa6f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8584e084-993b-499e-a90b-08d7badecba5
x-ms-traffictypediagnostic: DM5PR1201MB0009:|DM5PR1201MB0009:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0009E4FBCEFED23F0405E75A92EA0@DM5PR1201MB0009.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(189003)(199004)(33656002)(71200400001)(52536014)(86362001)(6636002)(8676002)(110136005)(81156014)(8936002)(81166006)(2906002)(316002)(4326008)(55016002)(76116006)(186003)(5660300002)(26005)(6506007)(53546011)(66556008)(66946007)(66446008)(66476007)(9686003)(478600001)(64756008)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0009;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gpye1DZ0/9r9Rj868l7epcgVE+v5U2VLW3816s7xVQys81NfE0OvnB9mJ9Jj2BujqYZuPbsO0CI2v1+sBXfTcO+8esxRVwpYozDEfYI8dyW9wunqi30+BeSLfvd/jh8ycUFI5rAJDaz0zChB3fFLN9vP1huPyMIYysAtWjHKJUbcMN2QwaOeQbvDJdzirNP3KGhI3RbEMEu7o//Js30RvEEKropjLjqoklg/Cia5K1COIbvj+8RTDv/nU3GZLH45klGVNl8+wGrfV4uuR4OKAbP3BYpLAlKPyMXXxg+KxLoQCmJY/3qFD3TY+t1nG0ugbSJtVZxbrUfUOv8sM1khKpFECRpj8Q/sg8GC8HIbe1/ptmpTfCfV8hrhqNZ0mZxbWZUlprUiw+cMcAomJQXz81XkWQFDkU0sr3le/Y/9DG005uV77hOcl9tGB7C+ty/5
x-ms-exchange-antispam-messagedata: XkV6p0F+gikRUQhBrvDaLaqr839wOObRtAJQdR/9LQ7RJmTGfUx9UBnCTO//Zwb7tDPEA3xK39VyM/myDqMaVrhHAbx+f10mAch18IghtgnXzXqflf0lyncaVgp3xZpCgxA7mxpuPGCuWWnhl85plA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8584e084-993b-499e-a90b-08d7badecba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 17:10:35.7212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hZ6FjDByxa/g+y8F4MXsJZlTldVEadw1Hk+YlDGTmTKBNObRu30G7A7+CC/gYl1gCrPpE1o7oCbxWmaxnTzRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
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
