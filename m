Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D6DC43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 05:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13B9206E6
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 05:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c3ROJEq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13B9206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4913B6E264;
	Thu, 26 Mar 2020 05:31:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F30D6E264
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 05:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEt6Oh7kZa0w7eZx0wImZhnWkOlsDHmIivrs6KettX6PQmXamNbZ+23CHH2Txu1vUcNhhYIk/LS1wKIkOnThOV1P8vCRDoii+Oi5jKzl5SgTI7eMTNoxOxGuwwvaZpx853JaSYqi70sry64H9VQCpFuok9tRXEimIDwll9874VfXaCHYfvNFM20ecz8nK7yhTfOscN5+n9tCD7dCQzlGcY5JsvAW2fWO3N487Vcu7o8dsx0sU53kmQbe0sQoxej0Bl2agXnT+A1CQSz/Bl0+yaAMP+30rTu/JdfK12t2BJ9b2NHC+HIsnNWsatazIZL7omzZMRGdJyYRpIktptmrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py0rKb7LuXZ2/GQQRLMX//d2upjHLMWWHX+cxInhRv4=;
 b=IwUz3amlPHcSnOt977o1gdrnqx4tVjOOuVA8mvUPjkhfzYqsvqGd84d4vgBLckjZYQslqQDMWFHl1qg1E11sziaT/BMmBu9Y9YyEEbhf6QO+2bGY53h86jj9uoeZCpYzIcv7NKCoHZk/HOMU1fpQCNIZW2GiorAMDDB9UVtREUlMVMNLljnUOUWQS2aQEK8/Vp2mydS2UDTk9Etq7rejc6/qx52Jyq1IO7/X/OHFPOpQ3F+2/YH8f+L/BFf49yS3o+JBLtlFJe8ihn47ak8LGeWSd93RjDSnuuSLYN0ToBaAVz+0Ux85hMdmR4UzigvbiT+bXAdF4CQuHT2by83oZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py0rKb7LuXZ2/GQQRLMX//d2upjHLMWWHX+cxInhRv4=;
 b=c3ROJEq6guoxzdZ+oSqoJU8DwA4pir4Bma6QJzyNPvZO99bJPNiCMuhXKxKunYjixZI+Cl6276vawkTu2HQwea5wuMYRCuzTEj/4lzg10skUFlHqj9fDqv1TXZy+Q3B91FOif8f5xT3EdTM6CPwfHsmtcF6Vowm9LLURlf0up/Y=
Received: from CY4PR12MB1703.namprd12.prod.outlook.com (2603:10b6:903:122::9)
 by CY4PR12MB1304.namprd12.prod.outlook.com (2603:10b6:903:41::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Thu, 26 Mar
 2020 05:31:04 +0000
Received: from CY4PR12MB1703.namprd12.prod.outlook.com
 ([fe80::752d:b539:241e:c7c4]) by CY4PR12MB1703.namprd12.prod.outlook.com
 ([fe80::752d:b539:241e:c7c4%9]) with mapi id 15.20.2856.018; Thu, 26 Mar 2020
 05:31:04 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC PATCH 0/2] add direct IB pool
Thread-Topic: [RFC PATCH 0/2] add direct IB pool
Thread-Index: AQHWAxLHEZz28VZJUU6knQS4e38jIKhaWDlg
Date: Thu, 26 Mar 2020 05:31:04 +0000
Message-ID: <CY4PR12MB1703BFC301A1A22BF912869D84CF0@CY4PR12MB1703.namprd12.prod.outlook.com>
References: <20200326020144.5953-1-xinhui.pan@amd.com>
In-Reply-To: <20200326020144.5953-1-xinhui.pan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51370d66-852b-4939-84a7-08d7d146e0d7
x-ms-traffictypediagnostic: CY4PR12MB1304:|CY4PR12MB1304:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB13047359D47F2EC5CD49466C84CF0@CY4PR12MB1304.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(6506007)(9686003)(55016002)(53546011)(81166006)(81156014)(7696005)(5660300002)(71200400001)(2906002)(8936002)(52536014)(4326008)(54906003)(110136005)(186003)(26005)(316002)(66446008)(66476007)(8676002)(66946007)(64756008)(76116006)(86362001)(45080400002)(66556008)(33656002)(966005)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1304;
 H:CY4PR12MB1703.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2z+5z6y21qhD8A+QWY5N7gmcFkEGJV7caNeUpMYZIAcKW9TopZk09GHwzJ5DDRQk24oZOM47buMfIPY/fUqotRllgFWFY2ETP4+Bj9W2vsw10HfUWW1i9d6h3wsFbCEQMjwq96iUUoccw2uMC9Y5pOifrxfmKITqWseXS/Mstxl0VmZIsDANnGic6+Ho29xn8fWnLYyijfYBNVdaSrlNY+Kb8P4fb0xHPYI+tST2Rlm0w8U4/mllRs67j5W4ZAZe+H6db6DZOA4I77+gLFj0s8+APB9fFReRlJ1klXgfbSK89xOPAAugoQN16n8AGAazZeVw3Hcip3WMJRwNJgcMf6gRGQe3PVIsfEbGoaNLu8m1u8SM6aY4/S94H28QYS2TgrvfRbXbjlmg8wttQ946olghX9sHG7a4jEILQC+EpWdzi3j3Z8xwWHo90vgTFFymUAhnubSOihdReNEI4GRZf12E+QjYhez9buifGKzVURg=
x-ms-exchange-antispam-messagedata: zcnHYsuL/Ef5ZT1szBMWsfFpswHN2/RRpzSj7skdHWQ41/hMKJCxLAdJDsjLHPhMQZU59qqwap3hr8i9LAFyD82Z5eZbmAFlthUq4RU6wzR13qXOoG31OLzK6ERaKaOvI6oGSYkp/vpbJdSBjnhScw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51370d66-852b-4939-84a7-08d7d146e0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 05:31:04.4731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cg1JuUe450MZKeydHNbRqTwcItnhxw3KrGBQ4HDEsNcayUpdcG0qz9mbl2i5QhYY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1304
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That sounds a roughly doable plan to me , although we didn't hit this issue in our virtualization stress test but like a possible issue.

>>> So the ring test above got stuck if no ib to alloc.
Why there is IB alloc happened in ring test ? I remember there is no IB allocated for ring test, are you referring to IB test ?



_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of xinhui pan
Sent: Thursday, March 26, 2020 10:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [RFC PATCH 0/2] add direct IB pool

druing gpu recovery, we alloc ibs for ring tests to test if recovery succeed or not.

As gpu recovery parked the gpu scheduler thread, any pending jobs hold the ib resource has no chance to free. So the ring test above got stuck if no ib to alloc.

If we schedule IBs directly in job_submit_direct, we can alloc ibs in the new ib pool. It should have less contention.

If the IB could be freed in time, IOW, not depending on any scheduler, nor any other blocking code. It is better to alloc ibs in direct pool.

xinhui pan (2):
  drm/amdgpu: add direct ib pool
  drm/amdgpu: use new job alloc variation if possible

 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c       |  4 ++--
 13 files changed, 35 insertions(+), 18 deletions(-)

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C1f5b1a3ba10a452c9de608d7d129b396%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637207850237679644&amp;sdata=cS7S7a8gDmIgyJNbr4qXSPMZTLwKz0W429Z%2F2Zo6gek%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
