Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B30C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 06:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76B320872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 06:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Op1ur+8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76B320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DA96E832;
	Wed, 25 Nov 2020 06:53:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4832A6E82F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 06:53:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkTUQzlWYc0qpIg0EOHvrJMSx84SOAyPccdvq/8n0NswUCeuJEU64iipVK9iAgzsmBDuIL7nJelDKtVeeNhsfTKHeBcy2LJZvhkRm7XQuyRAarjb97+ivCHi64bUiWLAF9jOxfYWYjZA/yqn+dVjqsO1KTv1fsEDylW39C5/zS0cWDo4LDLArEabDQJRlzQUiyikskiEU5i1WE4RJXZkqbPg/OJrGk1sfJq91V80gg4cGBypxljtaRMC8+N2KSbwahhdhFrNXgJLFPC3sLV0KyEXxZf0kRM4kGiaVf+Wgjg4wCVuGg7EEoJTS6CQ7p0ghuZqONn8NXcJm2Ret46IPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXJ+DmRtJ6W4BclqhfEPvx6SftbHplSno6jMwo9DNhk=;
 b=ePUK4Mr5ZWSVAmZj2FdCkhu8DVtqfTqw0XGkQiHINOHI9CDvGY3emh1CmSE07JnFOMIKkl4RlJGKs1Rc37+uCL5aLXSB09xAOvKBmCcvykabGoSUQw52+zlfZ1u3K0YyPQkDEcPEiI3SqisEZ+ysDpjHZX4JKhGVRBysiUxGlCaL/TPdVL2DBdkzGu1lZagGH0M8c5Wu1tSDhljWFrp8viKNQ0Z5wMGDjFHvXWid/fJiwajJIXdBhIfnT+b1paCMchnaKB3v2BDjg9LBzaf89abe7OQWD3MoQen5JiZWWDURnaq4vey/swB1vsi0aWdJzSuF/pJgeECt9xYzG8mUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXJ+DmRtJ6W4BclqhfEPvx6SftbHplSno6jMwo9DNhk=;
 b=Op1ur+8DQ9+33qNQtr0NXCFjHOnqjNpmoC5YxOFk5vL+CpUQzqMwBLRHhhLlhN0TH1RKZRc7Mk13UJZL2YamxUueEPH/1kBh6z6lusfweWIDJwgwgs84/hBQ1W/oZFAkNU4LYjMKv5dkYiqDN7MWCYKQHtPSHY6NFAyoAKPbZmo=
Received: from DM5PR1201MB0124.namprd12.prod.outlook.com (2603:10b6:4:58::13)
 by DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Wed, 25 Nov
 2020 06:53:53 +0000
Received: from DM5PR1201MB0124.namprd12.prod.outlook.com
 ([fe80::50ed:6d61:3887:e004]) by DM5PR1201MB0124.namprd12.prod.outlook.com
 ([fe80::50ed:6d61:3887:e004%12]) with mapi id 15.20.3589.030; Wed, 25 Nov
 2020 06:53:53 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, JingWen" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw
 in SRIOV for navi12
Thread-Topic: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw
 in SRIOV for navi12
Thread-Index: AQHWwkcSGhsZcLz67kimxMKj4wuQw6nXTAaAgAAM5RCAAQ+FgIAAAkSw
Date: Wed, 25 Nov 2020 06:53:53 +0000
Message-ID: <DM5PR1201MB01248D69374F1732B474122E9AFA0@DM5PR1201MB0124.namprd12.prod.outlook.com>
References: <20201124094905.25255-1-Stanley.Yang@amd.com>
 <CY4PR12MB128779E09EEFC614305187B6F1FB0@CY4PR12MB1287.namprd12.prod.outlook.com>
 <DM5PR1201MB01240896AE165C5AC5AE50049AFB0@DM5PR1201MB0124.namprd12.prod.outlook.com>
 <CY4PR12MB1287ECC874E7B98D4D7D589BF1FA0@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287ECC874E7B98D4D7D589BF1FA0@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-24T13:45:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=489cb579-6b73-4780-991a-00008ef8215b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-25T06:53:50Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f97b3011-40e3-4ea2-801c-0000ca6e2e04
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4407c758-1bcc-489e-69d7-08d8910edf6a
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB317950C4A7EB6FE2F2E52BD69AFA0@DM6PR12MB3179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n19BVuuQy0NbnNRI5kGGTHroN6LBiQcfzkgnl6SMKICxhJyrNgffslNbIeE35wNwC0KFyrOjnkAdrmj6tMKS1iPWY9DrSCA2A60CdLVRT6vPDdx4MnBDIu60QLhPVBpfVKmhaK9ZwBY2GE6rYnBFpMktlpz87ahNVl9KW5M3WupTPH+nCmr18UyrAkIIPsnpVjB9uPc4ZLe42M89WD9L77YsmCEegYbnJZXRoNHOIDdpf5kZE5B4NdkqYGPBy+3HLm2NX5ztllZs72kSZ1EDAsyVDNAQRZ0Q3v62J38xgAddFqrBX/VhZo4miTM2PlWWlzzt2xbOZ9Ud9LA42femvVg+rICBhdGpQtlrXIoYKyZvkG/mSYpSQ2rHi3WZ3mKnXjfs+XgZRuTURXTY1aZblw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39850400004)(83380400001)(966005)(478600001)(6636002)(86362001)(2906002)(26005)(6506007)(8676002)(33656002)(53546011)(110136005)(55016002)(8936002)(7696005)(66946007)(71200400001)(66446008)(9686003)(76116006)(45080400002)(66556008)(64756008)(66476007)(316002)(186003)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fkcKA2FHhFs5+BhIHQw70tArUu8ye/N92ujaMABHDEgv+pcQqu+abB+hud/Q?=
 =?us-ascii?Q?zovBXdgTPoZW+fkukzgsgHpgCZI4n3p7lF2sqDOq61yjMzj/jvO3OaZvMPnS?=
 =?us-ascii?Q?d66NoFrYTJ3RUMAE/a03no4fjpknsCFl/u2kOzxpNQFP2kchhDQVgjFxYcCT?=
 =?us-ascii?Q?Ifp5qIqpLMcdF/oUjGAhBPwTPROwGBuJ1cMOzOPcGs1E8djgOpjUbaXh2cv3?=
 =?us-ascii?Q?2VLDIQIGfzhGIAOVF67kG8UBSLntefb5OxyimKqC+WF/ZeJj1Xss5leqSAWX?=
 =?us-ascii?Q?o/YX03WfGOLOOORuBw6bN4a6ofxRlyR9H/olTULn0edWTWul/BqXf7j09VFq?=
 =?us-ascii?Q?+C9wu+0gxFSm3Ef/q4An3fby9JT/CCkGGAxMQ9n8pwlcZ/YPARDDwnwO1nNl?=
 =?us-ascii?Q?GtVUKk4UVbvDSK3FynJFKLJxQlrpdnIewNRm/E7x1ijAgUJBQYJbL75mogdD?=
 =?us-ascii?Q?G7YywV+ew1Bt+S04kj2DrTQElu18Cc+snHBTpxMl4Nr1YWfkmm3EVX9cCd4O?=
 =?us-ascii?Q?d69c1FgyaF7Nrxtoq9qFd7UcUik5hKKyJ4IwEDxIpZsNJXbzhadqJmXwKNhu?=
 =?us-ascii?Q?C2d0rzRlzbntMZL+fcCwDcQ1fM+DRI4nErddN2Vojm5foVchS0zQ7JNm7YuV?=
 =?us-ascii?Q?RVwsiMTfWCousCLaZLKSrdj/lZS/FRXoA+/oXjO7wq8qKmhwzQyPRd1uYuKb?=
 =?us-ascii?Q?pHSudfLkZm8MTIU+qWHnAVyo6/4XudAVpYeHbzdVbrCM4TGVdHjZiiSfY7e9?=
 =?us-ascii?Q?WEjPGuSVFY2oMryOeW1EtDkx+EOL0nto+RXkqHoWtF3f+pT96Fkx40GmmZZd?=
 =?us-ascii?Q?iyX3tchPt+gzxF+ehAGZnsge063QmFjOjhjz7oQYX0zB6CalpjH1EubY2YAn?=
 =?us-ascii?Q?cPqbcpBIu0JVjY/e2+vNjmcQvz3xRS6GWHAFI1Ne5CoZ6TUP1rbhYRoVrDtM?=
 =?us-ascii?Q?+iT8K+L8ksrNieQHAxxyv+yU+JuBH3Gm5muXAF8qbO4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4407c758-1bcc-489e-69d7-08d8910edf6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 06:53:53.4898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HucynPDYy2FYaR/B47dlmHq3tgRbE+ii7c98erVUra8nE84+EoA0vb1izfUpVe0E9JPzJKTF9iSCvkV2Y8Jz4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Guchun,

Thanks for your review.

Regards,
Stanley

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Wednesday, November 25, 2020 2:45 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org;
> Chen, JingWen <JingWen.Chen2@amd.com>
> Subject: RE: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd
> fw in SRIOV for navi12
> 
> [AMD Public Use]
> 
> Okay. With that fixed, the patch is:
> 
> Reviewed-by: Guchun Chen <guchun.chen@amd.com>
> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Tuesday, November 24, 2020 10:37 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-
> gfx@lists.freedesktop.org; Chen, JingWen <JingWen.Chen2@amd.com>
> Subject: RE: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd
> fw in SRIOV for navi12
> 
> [AMD Public Use]
> 
> Hi Guchun,
> 
> This is an oversight. I forgot to remove it from patch version first.
> 
> Regards,
> Stanley
> > -----Original Message-----
> > From: Chen, Guchun <Guchun.Chen@amd.com>
> > Sent: Tuesday, November 24, 2020 9:47 PM
> > To: Yang, Stanley <Stanley.Yang@amd.com>;
> > amd-gfx@lists.freedesktop.org; Chen, JingWen
> <JingWen.Chen2@amd.com>
> > Cc: Yang, Stanley <Stanley.Yang@amd.com>
> > Subject: RE: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and
> > asd fw in SRIOV for navi12
> >
> > [AMD Public Use]
> >
> > --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> > @@ -208,14 +208,13 @@ static int vega10_smu_init(struct pp_hwmgr
> > *hwmgr)
> >  	unsigned long tools_size;
> >  	int ret;
> >  	struct cgs_firmware_info info = {0};
> > +	struct amdgpu_device *adev = hwmgr->adev;
> >
> > Why add this local variable? Looks no one is using it.
> >
> > Regards,
> > Guchun
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Stanley.Yang
> > Sent: Tuesday, November 24, 2020 5:49 PM
> > To: amd-gfx@lists.freedesktop.org; Chen, JingWen
> > <JingWen.Chen2@amd.com>
> > Cc: Yang, Stanley <Stanley.Yang@amd.com>
> > Subject: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd
> > fw in SRIOV for navi12
> >
> > The KFDTopologyTest.BasicTest will failed if skip smc, sdma, sos, ta
> > and asd fw in SRIOV for vega10, so adjust above fw and skip load them
> > in SRIOV only for navi12.
> >
> > v2: remove unnecessary asic type check.
> >
> > Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c              |  3 ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c              |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c              |  3 ---
> >  .../gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c | 13
> ++++++---
> > ----
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c           |  2 +-
> >  5 files changed, 8 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > index 16b551f330a4..8309dd95aa48 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > @@ -593,9 +593,6 @@ static int sdma_v4_0_init_microcode(struct
> > amdgpu_device *adev)
> >  	struct amdgpu_firmware_info *info = NULL;
> >  	const struct common_firmware_header *header = NULL;
> >
> > -	if (amdgpu_sriov_vf(adev))
> > -		return 0;
> > -
> >  	DRM_DEBUG("\n");
> >
> >  	switch (adev->asic_type) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > index 9c72b95b7463..fad1cc394219 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > @@ -203,7 +203,7 @@ static int sdma_v5_0_init_microcode(struct
> > amdgpu_device *adev)
> >  	const struct common_firmware_header *header = NULL;
> >  	const struct sdma_firmware_header_v1_0 *hdr;
> >
> > -	if (amdgpu_sriov_vf(adev))
> > +	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
> >  		return 0;
> >
> >  	DRM_DEBUG("\n");
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > index cb5a6f1437f8..5ea11a0f568f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -153,9 +153,6 @@ static int sdma_v5_2_init_microcode(struct
> > amdgpu_device *adev)
> >  	struct amdgpu_firmware_info *info = NULL;
> >  	const struct common_firmware_header *header = NULL;
> >
> > -	if (amdgpu_sriov_vf(adev))
> > -		return 0;
> > -
> >  	DRM_DEBUG("\n");
> >
> >  	switch (adev->asic_type) {
> > diff --git
> a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> > b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> > index daf122f24f23..e2192d8762a4 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> > @@ -208,14 +208,13 @@ static int vega10_smu_init(struct pp_hwmgr
> > *hwmgr)
> >  	unsigned long tools_size;
> >  	int ret;
> >  	struct cgs_firmware_info info = {0};
> > +	struct amdgpu_device *adev = hwmgr->adev;
> >
> > -	if (!amdgpu_sriov_vf((struct amdgpu_device *)hwmgr->adev)) {
> > -		ret = cgs_get_firmware_info(hwmgr->device,
> > -						CGS_UCODE_ID_SMU,
> > -						&info);
> > -		if (ret || !info.kptr)
> > -			return -EINVAL;
> > -	}
> > +	ret = cgs_get_firmware_info(hwmgr->device,
> > +					CGS_UCODE_ID_SMU,
> > +					&info);
> > +	if (ret || !info.kptr)
> > +		return -EINVAL;
> >
> >  	priv = kzalloc(sizeof(struct vega10_smumgr), GFP_KERNEL);
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index 1904df5a3e20..80c0bfaed097 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -847,7 +847,7 @@ static int smu_sw_init(void *handle)
> >  	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
> >  	smu->smu_dpm.requested_dpm_level =
> > AMD_DPM_FORCED_LEVEL_AUTO;
> >
> > -	if (!amdgpu_sriov_vf(adev)) {
> > +	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
> >  		ret = smu_init_microcode(smu);
> >  		if (ret) {
> >  			dev_err(adev->dev, "Failed to load smu
> firmware!\n");
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.f
> > reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >
> gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cdf14a0bc671547d
> > 5315708d8905e330b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%
> > 7C637418081554620468%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> >
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s
> >
> data=BNU5d%2FQSOnNZNYHQ3ZjBjIubUl1wa6lmkaWBf2XuIjw%3D&amp;res
> > erved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
