Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6E7C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 21:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5883610A2
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 21:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5883610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 527696EA1F;
	Mon,  7 Jun 2021 21:32:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E206EA1F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 21:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6FKA2FmBFGNgdeYqYEPg1pvysN4HQgX+jGCfZZgvJ/lijAtdr1GuJ8LtEJTPmiFuBj/NFPQnuWPG7UwW1CZpwNz/59avcVYuCW4JOv0Im67Dp/recU6oOkiBfcyMkGztqP9TJLNy9AcUOLf1PEqhhhQO96IoeG/6vhlMef2i2QHURLUfnV9fCRPGXynjhZV5SM8NM1JUgPad9Mr1sYjlTb6p3AZPe+gcYg9GrJLHTQA3nBoyo7V+MS1KK/7t0I86ZSztJomflviwHYFi4FrwXWey1Z6Vr5elOpSJbIbWOkHlyxopP9hdADXyjhVejP2bzT2irK2GvvEMnrNf7l7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oj/ZXUKUVVX1q9PHH+2FZ6uZvGVX/Gclf2NrYPcppP0=;
 b=DOvXkQED+ZSEDMPOOOK9W3FJBFHhK3kAzL55JumDrKwYpFbChDy039NXTL8qhLWCakMEKzDv2KDXu7oTnWHL5AoFgfbyVfjyJkNHnRmSigEODZfxBAYwbvJ1IhuceHPuXA/S0ivGtGInER2jLJqmPPZTFQFEp7rOyusRZV958oL2Sy6BMx5N9e/4Mls1xApUqfXtTS1tLLxqV8CSzel1ohKC9cAEl3JtQ16qEyBvTw+xT8tALjOoizovYiuwbBLTl+LH+dNiuI9vxPAPetrhMIgLEUpBMwV47T42nES1CzAWZ1dqa8+aKTpC3e9qFDZpGql4/xuIuOWXHBsBlt2Aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oj/ZXUKUVVX1q9PHH+2FZ6uZvGVX/Gclf2NrYPcppP0=;
 b=b9xfCELd5/87G3aueN1IFLWQrpfGpcxpTt6pdlAObPsgzJBT/U3VKKGTBg9mSeasRU4Gv5bvTeVp8lv2L+guZ6vNh3NcXvpM7/Ob2q0KSJs0+8UockUP5EjMkJ8zgLu4ZOmarwyS3xtORRIaJovB3tCwKetVCrK8nCodQXdo7rg=
Received: from DM6PR12MB4843.namprd12.prod.outlook.com (2603:10b6:5:1d1::16)
 by DM6PR12MB2969.namprd12.prod.outlook.com (2603:10b6:5:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 21:32:22 +0000
Received: from DM6PR12MB4843.namprd12.prod.outlook.com
 ([fe80::81a6:2805:cf9b:eef]) by DM6PR12MB4843.namprd12.prod.outlook.com
 ([fe80::81a6:2805:cf9b:eef%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 21:32:21 +0000
From: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+
Thread-Topic: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+
Thread-Index: AQHXW9vIJ8y5EJ2RGkG1zLHqYy15RKsJEVmQ
Date: Mon, 7 Jun 2021 21:32:13 +0000
Message-ID: <DM6PR12MB4843FC5C5BF8086C627A0BC887389@DM6PR12MB4843.namprd12.prod.outlook.com>
References: <20210607202841.2120465-1-alexander.deucher@amd.com>
In-Reply-To: <20210607202841.2120465-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=436ba3b9-380c-44f9-b833-f97ecdd28bde;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-07T21:31:53Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: 857ba467-1732-4b20-a88a-b9939edacd9f
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.140.204.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a92a43fe-dd1d-4471-5b68-08d929fbbbfc
x-ms-traffictypediagnostic: DM6PR12MB2969:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB296934F5D6B2A27C59CC9A7887389@DM6PR12MB2969.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JBYQxuFuB/6Mq4XPLS/QV/VS+DL8mlE02t3ynmOe9lQp7yfa9MFD1yh+9KMqLMc5jUFqn/8a1EEngyPrqzgP4cKn0YRS5XTqujD+ciPzKBZIIvycEn8cvadsmZO8h8vB0KdN3xFAB90cgVfCA6v2slJojMbZKCKBF5uAsEaAaKqcJ9UG6u7YzoLxuR/2+Zk4JNWFvkbbc+6H8OIEu2XQkkdyre7PkxEWViqt/8yUiuxOAYaKiXhZoe/5KwfRV2UFduX35k7a4UtM4Et9wDShKsuKxdkTHpRdqauEG990HtBhFhmoFMfMdrpcQVGLGKIEFdrqYz8+R/q9zSkGyYxeYJCDo1kg41Ifuc89XosScz4zeHZisaE7LNU4k4/FkgCYPuX65hB/y/auDzXuVlFhIkiQ9urH03RTHT5LVh1HZDwNVrYkzDPktpMw/B/v/LhKsT0ja18jAGC2zP3fs1HfXRdawIKkfaXUZhw2Ctkmw4K9ucDoKOu3XEsFet72IHuH24R5y7S32n8csFXVBCu39B3ocb5vc16SOF+4i0rPem/zqRL9EEZotkp6jjF3wF7WBO6dozCMQ4fM+PKnW80xd+O0wGFtVCKaIW7wG88pexMmOo2iz3XMagLx1O7gppCLGGGDatpm12mj2yzWcQ2dA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4843.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39840400004)(33656002)(478600001)(71200400001)(7696005)(110136005)(55016002)(9686003)(38100700002)(4326008)(316002)(76116006)(966005)(45080400002)(186003)(52536014)(66446008)(86362001)(66946007)(64756008)(66556008)(5660300002)(66476007)(6666004)(53546011)(8676002)(2906002)(8936002)(6506007)(83380400001)(122000001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2chr1lVANW37uyFcY4D2GXMKNvdAnWcse6W8tU3OW0OYucBPR0JtphzommYz?=
 =?us-ascii?Q?a+8Y3WI+3IBYvAti/EZbs6NqiBTjFHgXJ7MS8Z56PtWrSSVWKlTwx2V4svMi?=
 =?us-ascii?Q?kd4r73K6NpTyBGnb3mM+iwGtaxxWjitZffE0lnw6zuPv1fQP0lrVZYbA6rzE?=
 =?us-ascii?Q?a3jVFiib94WOkadgg3pXELPNATPqQQhLXTLs1pI0OQRDuthJRXYAQYUg1pcl?=
 =?us-ascii?Q?pN/x5wuIC8GCZJ5suJQntooZCuPlPOT4juWJ+N46xeLki6mSvfLUNs/UyAue?=
 =?us-ascii?Q?O3F59owyN5jCb0ieszHsD5dzYQ/c16z04r4vXrE301TLxKKj8bZAnr678jSs?=
 =?us-ascii?Q?lbYqn2TgHaltLVsF0/U3s/ANWV80jt4n/N+0fVHY10JdIyyd1UpGLWOF5sMJ?=
 =?us-ascii?Q?4jhnziNmNNXHB0r6uJQVxljIihR82J+Vm8JKvY6mFRUqCLwiYvpo3RvlG6E3?=
 =?us-ascii?Q?DPKalHY8id6p63bj+BVbgbDOyVsf77TA3XY5WYL4kvP1lm2gOvipuAottx/b?=
 =?us-ascii?Q?9G5XOnRQcMPA4/YozVz+ZBEv9+66phPIoeG5iMy5JmJEHzYvKjeji91lKA88?=
 =?us-ascii?Q?z3kgR/Klxe0xr9b7amtc1IHzmJ16s1DUT3C1P5DnBYbtvuEJI6LXHUwtzGnu?=
 =?us-ascii?Q?l0haIVZW+s7n5DV7oSQq09Y0JiJz3dD54zyjIKI/HD0YzfRAcfa7pEFvQkDy?=
 =?us-ascii?Q?RDrnfvZZfagvPsN653i6catd6A1mXAOIBpSWchnmn2S8I6NY6thgvF0Z3SZZ?=
 =?us-ascii?Q?Hmc7qZx1S4mGwnZ24Xh3Q+DceLF+hm+gfFCyQC8yBIGnSQ6qKSXtog3gBq0b?=
 =?us-ascii?Q?o+m4wkpgtK2XjNt6zmLLPperW/k2/zgVPJcWU2TQ4pHH5jjDow9N/ZWhX6cx?=
 =?us-ascii?Q?tSTnRrQG98VzZauHHM/Mo/GsRBpnsBBVrEz+l9MHFwdBbqfqHg+donThuWdW?=
 =?us-ascii?Q?mFHlrOGdgWXEq9wX7Nnw+ROKEPhmZLPCso0LmbedwrkPRa0pdtU4SXGWnU0l?=
 =?us-ascii?Q?IbPk2uEe+FLWYymlTlr9Pg6hgA4oteTK2CmIk4lm3qtU8gFWNjQYLfFGjGSK?=
 =?us-ascii?Q?ZCu73jxoc/MWC7sE0DjoqTEO7f7GODx3abyXQSCxPEXq6QwNTaclRZSD4Nt9?=
 =?us-ascii?Q?IIqQIWi9sdRfNTMIBSkqPTAVkG/N8Jdw+cqWeIGX0t3A6vbFTrhC0TnJofN/?=
 =?us-ascii?Q?ilhgVxAG9TZ+9DUSZwKV2H0bzpfDO98oZsPq/dTgfbluCTIdhAYAGwsZxGZ8?=
 =?us-ascii?Q?V+uiPUDdjEpFiWB+qfMtLxXUo3Si1qbAp2UngLbmkFjeHtJqgNZdUzYJBpdR?=
 =?us-ascii?Q?l9jH1lujeyEVj8cS5Fq+ZwYs?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92a43fe-dd1d-4471-5b68-08d929fbbbfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 21:32:13.3691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfSHeJCCL4DuMxsCMYSHw6su/r4M/ciAAiO4T/dw7vIhjHOzuxkhFBfen45t8x6az7fAg32uItHaeSpoLGJY4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2969
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Patch is
Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>

Thanks,
Boyuan

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: June 7, 2021 4:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+

Drop disabling of gfxoff during VCN use.  This allows gfxoff to kick in and potentially save power if the user is not using gfx for color space conversion or scaling.

VCN1.0 had a bug which prevented it from working properly with gfxoff, so we disabled it while using VCN.  That said, most apps today use gfx for scaling and color space conversion rather than overlay planes so it was generally in use anyway. This was fixed on VCN2+, but since we mostly use gfx for color space conversion and scaling and rapidly powering up/down gfx can negate the advantages of gfxoff, we left gfxoff disabled. As more applications use overlay planes for color space conversion and scaling, this starts to be a win, so go ahead and leave gfxoff enabled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 1dc11dbd62b7..647d2c31e8bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -393,7 +393,6 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
        }

        if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
-               amdgpu_gfx_off_ctrl(adev, true);
                amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
                       AMD_PG_STATE_GATE);
                r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO, @@ -413,7 +412,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
        atomic_inc(&adev->vcn.total_submission_cnt);

        if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
-               amdgpu_gfx_off_ctrl(adev, false);
                r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
                                true);
                if (r)
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cboyuan.zhang%40amd.com%7Ca1496b99775a485b297d08d929f2e950%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637586945547703815%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=35UfXI3gTYEWcWKn4fFVhac8rHKyZlk6ASIZqjKINJQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
