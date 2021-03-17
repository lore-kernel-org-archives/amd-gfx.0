Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3075C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 13:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1994F64F17
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 13:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1994F64F17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964926E591;
	Wed, 17 Mar 2021 13:31:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 475DD6E58B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 13:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obzzJVp7YjuGFEapeD/q10+6w1/8DjjKv8A5tCja2NHlGZQ7390ACDZEWuqgODbxsNFMxdY/f4yLghvX207Yg0GgDUfoeAawqHG7OmqWj/SidG7rVS1i8b40eFxAUxUe1uQsF+XbJGq+iJJK5RN4VJ2UUbWSr6SBf7aLJi1ZsrOAJhGy1wpWAo+7wGJz6aMHf8VS7dFWQ4FNoouTxvcxo2gMCumuOVsRYwo2a2fhCewcDY5lAA0SSb3XVN9qU5hpVSXRbF1Nr2EK3f7I6DR+ymJxMXMS2LKmKT63f1Ug5C5KskAHsu8aptzML5Jpp4b2sZ7emhI+1TWhdZEIfWqgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee5QDO54NDX2wtCEzcAsH2Xi7g8fhImxDy727PaYHhM=;
 b=hLbMAwOSbUhZX8Af6hIOVjvU/OAbUX4z7ZZJIK6Kv5yue+qf86R3RtQ4Aufwn4v+AbZ5XZJ40UTOpqHTZQjxoaG0po4Dl9uJyWYOwBYgKfRAco1kTP5R5cSMdseD6rXwUujBydzoj6kQayeNGq7TvunF2xDFH2+/SavjTvtiobQqLWd7mdtJ/JK1ABCm+64BX/yNEvSWeX9EkyMP8wTCsxJWnSLKa5TLtzN+3+1mlXUsaw0m4QjqCFkz5HRVVMjPt02s5/qFRmwX96AbXITZzyN/8LsuEHc932nb0asjCm8LnIOszHRMpyqoLv9KnrZ2XxlVzJBuq4JCOnZ1ZT3wUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee5QDO54NDX2wtCEzcAsH2Xi7g8fhImxDy727PaYHhM=;
 b=sR39PazN+f0jlq1mUQqOXL+/lPDYhZUNMxXZU5B0JQB1NdTsF8AG+JdaqXHCq49VSfrYZH2fCJ0G0QGYbW7z1HP3w1nCIBAiFcRGZJPkOFe16HJTRLTPnGMToen2V7+/VYeltSwPSTRboAQgNr6OYKlWMFWpXpGW+kAPPqxeT7k=
Received: from DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16)
 by DM6PR12MB4012.namprd12.prod.outlook.com (2603:10b6:5:1cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 13:31:04 +0000
Received: from DM6PR12MB4267.namprd12.prod.outlook.com
 ([fe80::3017:8af0:cb60:485a]) by DM6PR12MB4267.namprd12.prod.outlook.com
 ([fe80::3017:8af0:cb60:485a%9]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 13:31:04 +0000
From: "R, Bindu" <Bindu.R@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
Thread-Topic: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
Thread-Index: AQHXGr8h9juTNKU0QUGYcEdatosS4KqHaL+AgAAd8YCAAKQBhQ==
Date: Wed, 17 Mar 2021 13:31:04 +0000
Message-ID: <DM6PR12MB4267647D9FCEF0151B20EF86F56A9@DM6PR12MB4267.namprd12.prod.outlook.com>
References: <20210316234952.254296-1-bindu.r@amd.com>
 <BN8PR12MB363370FEDCB6A5BE867005638E6A9@BN8PR12MB3633.namprd12.prod.outlook.com>,
 <CY4PR12MB1287C50A1F73DBEE391DA64DF16A9@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287C50A1F73DBEE391DA64DF16A9@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-17T13:31:03.679Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:4ce1:13a0:d184:9722:3fb0:4f1c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58847549-28cb-4c00-1995-08d8e948e9d3
x-ms-traffictypediagnostic: DM6PR12MB4012:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4012F2773FCDD03EA3DCDBFCF56A9@DM6PR12MB4012.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCZSOFVGVON3/CgMNNilsEGk0w/5eW9zMAvaklgOi7USZrX6gOUjjl/+pNjrYVAP478I+Yx3yKvtsp/d6mkX/Z/szaNbO7X7wVPJsRubZNtBaXa3h+b8lVCvU+gS/+/F8kZqndU193uTwGWNv7z9JpVNen+/et4zEUD0mHAFZ3MARSduXOWhCE5rqE7FePZri9tEsM8fCtzEkdB20E9xnC67SgjWRn7eTqXvlKlU+l9AcO/1IHszgJtYxYSN7IBjeNM64L0TiaBoBBF9XF+ydphqeJePS23jfF/Sb5AEYQpEF2Jic+/U0ImTQ2ntgCAyzXeL43c2aF9U0OTGLE5kS9jBdfflJGEXiBYoOtYDzJ2VSi462GTHmV3zwVxOx3IwiWDN8r1gwCzyNUa0Kd0Sc+5gbKuNbZFLPny5rTiHmq0+Q1Z0V9cVCfDKdYctv85anjkqn8+kRwK3hjthwpdH1/GFoijbd2lGUvAnAh8SQRJBiWGCMn0Es4m8rTnaPLvMoSftv4U/0mhSo66O8EK0+nM24elOFnXIT0W8QkFCil7MSvEAD7NV92Kok7EutyfBzSEF3csQ3o6I7daHAc2Pk35vFD78B+TLubbpqYFTg+c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4267.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(64756008)(6506007)(5660300002)(8936002)(166002)(110136005)(66476007)(9686003)(7696005)(52536014)(66556008)(45080400002)(2906002)(53546011)(186003)(4326008)(316002)(66946007)(66446008)(19627405001)(55016002)(86362001)(83380400001)(33656002)(8676002)(54906003)(966005)(71200400001)(76116006)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bTl2TrFisbPdUEEVRBlVSWo2TW4X+F+ovfGxdB+gI5lKDMJ6rMB9jGSA9mMk?=
 =?us-ascii?Q?3VoPcF2CbKFyhO5I2TOyjnS/1NTOKtNLiFdxqIeUAFKsHW1MuSYPNlabrghE?=
 =?us-ascii?Q?OsGGXUAOeZvMmLFrvo0dQYFFAf0TWU+GS1fAsM1L+VErBorbzwXIddDsVGHl?=
 =?us-ascii?Q?uX2iCPkaVkpYPb0YJpTDnyXCN7YoO1SYGC7PfbnfO5u6KYuUb7S4Z1fpmWL+?=
 =?us-ascii?Q?EBRHKHLxtWmcdmIFAHFV0eBJVDXbc2oiv2mm3U5AMkyN7ooIdvVGCezOljEl?=
 =?us-ascii?Q?75pxvbKGRbuFJp3xTN+EqutdyN9R1m/0zOBlPcIYH1i8xxC5yMJLReAGG2mn?=
 =?us-ascii?Q?smL4xdg2qS3573Rp+6WPWvHU/2lfuSiT0RX8opYj8R1CbeOpAoIXorXwnEO1?=
 =?us-ascii?Q?bMmF1qcKv4Ezw7RYzPwEumt1h0m1YeP4DPC+HHiJFbWHgDM4WIKmDXmnBgt9?=
 =?us-ascii?Q?8ejgxeM7rfK0mU/jyZKCeB787EPakqPmQmRLsaTHQ8TJG4YGHDZ4mZ7Nj3AO?=
 =?us-ascii?Q?B5rsEk0ZsZ171Xwaj81IFsGs9u81OYcaohBnmna86F5iZ3wd5g+4h36zeZiG?=
 =?us-ascii?Q?MEMTttEdM30la1wHd95BONVtvD0MUitHeon7vp0QSLz3smCSzzl4mUE3hqLL?=
 =?us-ascii?Q?40Sg7FwfMLT9XcqHkst4tE05w/sdQqSrgOJ4iIoqnx4ABFvm66WckM5DrwTN?=
 =?us-ascii?Q?P6pGRfcrECBBBK07eZga/0k8vOM1NM97t6nHq5YS6rq3mi9Cqam6FC5KBrvi?=
 =?us-ascii?Q?obtayAzrrMwFkNIvkHbezkz64u7a7+nBR1exI9CbL0sohG2zWai8Kb3QojVp?=
 =?us-ascii?Q?BneqfwYj0zgOyxBAL7Jj1SX1wen8v2kX1etbU5X7lCdCetJODRBF9tZ4N+X4?=
 =?us-ascii?Q?CZmtH80lLk0ydRaQz0MbBAuY0uhqyfbrF7GEjQV+oaMu4CkGLSNRmgb9q3Fo?=
 =?us-ascii?Q?RgofVw6a6LWlcpJVmkkeasZVqUIQ/fi8wh1jNbHw103EJgCS6lvIUzhzwhlu?=
 =?us-ascii?Q?v5r5gakQyGCerumue7Gig5pLIHBJ2IGWvENHtqBO5I8IS2XD4Q81faQxeNRT?=
 =?us-ascii?Q?X7Tpk9Rj31UuFL7s3YD6BdRqqz5AztacrxNuvjgXhAfisRGZHJclFpJ4uyAJ?=
 =?us-ascii?Q?nzicx66/Athfvv1geN3MguFbNQfQwZxEna/3aZfy2svCveAo4iaKEutEtdGJ?=
 =?us-ascii?Q?UurGvZ5E4b2UxkPxI1+ZCIoETGXqNbw02eKJ6lJ61QelF+0jv4zBU1x7fnMy?=
 =?us-ascii?Q?b3fyTjlVwhcCTAzb6Dot587vpjUQ8Y7FmgJFSXennWipGmBg7st2R2n8Nq3X?=
 =?us-ascii?Q?UYh2Q7N3ND5Lp8DxjgenjtEi3f7FQ2IVfdIlHpeQ4hHZsFSLWl+bHZr30Wuj?=
 =?us-ascii?Q?A36Wk8uC8X3lbkAV+1FxM1lmrCFR?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58847549-28cb-4c00-1995-08d8e948e9d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 13:31:04.0777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H83Rxdfv2UZq1QbABZXtCuBrsQrRukcueGLUxiIoLCpcuMU8QZTaEe+29uR2zVLruM5ZYitKeh6ARqZDtuQZ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4012
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Content-Type: multipart/mixed; boundary="===============1723608353=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1723608353==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4267647D9FCEF0151B20EF86F56A9DM6PR12MB4267namp_"

--_000_DM6PR12MB4267647D9FCEF0151B20EF86F56A9DM6PR12MB4267namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Thanks Guchun, yes this would require CONFIG_DRM_AMD_DC_DCN flag, will upda=
te it.

Regards,
Bindu
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Tuesday, March 16, 2021 11:32 PM
To: Feng, Kenneth <Kenneth.Feng@amd.com>; R, Bindu <Bindu.R@amd.com>; amd-g=
fx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@a=
md.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@=
amd.com>
Subject: RE: [PATCH] drm/amd/display: Allow idle optimization based on vbla=
nk.

[AMD Public Use]

+    /* Allow idle optimization when vblank count is 0 for display off */
+    if (dm->active_vblank_irq_count =3D=3D 0)
+               dc_allow_idle_optimizations(dm->dc,true);
+

Above part needs to be guarded by CONFIG_DRM_AMD_DC_DCN?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feng, Ke=
nneth
Sent: Wednesday, March 17, 2021 9:45 AM
To: R, Bindu <Bindu.R@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@a=
md.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@=
amd.com>
Subject: RE: [PATCH] drm/amd/display: Allow idle optimization based on vbla=
nk.

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bindu Ra=
mamurthy
Sent: Wednesday, March 17, 2021 7:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lakha, Bhawanpreet <Bha=
wanpreet.Lakha@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Ken=
neth.Feng@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH] drm/amd/display: Allow idle optimization based on vblank.

[CAUTION: External Email]

[Why]
idle optimization was being disabled after commit.

[How]
check vblank count for display off and enable idle optimization based on th=
is count.

Signed-off-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 553e39f9538c..56a55143ad2d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -987,7 +987,7 @@ static void event_mall_stutter(struct work_struct *work=
)

        if (vblank_work->enable)
                dm->active_vblank_irq_count++;
-       else
+       else if(dm->active_vblank_irq_count)
                dm->active_vblank_irq_count--;

        dc_allow_idle_optimizations(
@@ -8694,7 +8694,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_=
atomic_state *state)
                WARN_ON(!dc_commit_state(dm->dc, dc_state));
                mutex_unlock(&dm->dc_lock);
        }
-
+    /* Allow idle optimization when vblank count is 0 for display off */
+    if (dm->active_vblank_irq_count =3D=3D 0)
+               dc_allow_idle_optimizations(dm->dc,true);
+
        for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
                struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7Cb53f164f787e4da3725a08d8e8e6472c%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637515423028336026%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DxZ=
ouQssY4uo%2FohKAZBCdej9gKFsggBExTfQ3Ddz8D%2BQ%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7Cb53f164f787e4da3725a08d8e8e6472c%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637515423028336026%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DxZ=
ouQssY4uo%2FohKAZBCdej9gKFsggBExTfQ3Ddz8D%2BQ%3D&amp;reserved=3D0

--_000_DM6PR12MB4267647D9FCEF0151B20EF86F56A9DM6PR12MB4267namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;">Thanks Guchun, yes this would require <fon=
t size=3D"2">
<span style=3D"font-size:11pt">CONFIG_DRM_AMD_DC_DCN flag, will update it.<=
/span></font></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;"><font size=3D"2"><span style=3D"font-size:=
11pt"><br>
</span></font></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;"><font size=3D"2"><span style=3D"font-size:=
11pt">Regards,</span></font></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;"><font size=3D"2"><span style=3D"font-size:=
11pt">Bindu </span>
</font></span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 16, 2021 11:32 PM<br>
<b>To:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; R, Bindu &lt;Bindu.R=
@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.o=
rg&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhou1, Tao=
 &lt;Tao.Zhou1@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.co=
m&gt;; R, Bindu &lt;Bindu.R@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/display: Allow idle optimization based =
on vblank.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
+&nbsp;&nbsp;&nbsp; /* Allow idle optimization when vblank count is 0 for d=
isplay off */<br>
+&nbsp;&nbsp;&nbsp; if (dm-&gt;active_vblank_irq_count =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dc_allow_idle_optimizations(dm-&gt;dc,true);<br>
+<br>
<br>
Above part needs to be guarded by CONFIG_DRM_AMD_DC_DCN?<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Fe=
ng, Kenneth<br>
Sent: Wednesday, March 17, 2021 9:45 AM<br>
To: R, Bindu &lt;Bindu.R@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhou1, Tao &lt;Ta=
o.Zhou1@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; =
R, Bindu &lt;Bindu.R@amd.com&gt;<br>
Subject: RE: [PATCH] drm/amd/display: Allow idle optimization based on vbla=
nk.<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
Reviewed-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Bi=
ndu Ramamurthy<br>
Sent: Wednesday, March 17, 2021 7:50 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Lakha, Bhawanpree=
t &lt;Bhawanpreet.Lakha@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; =
Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; R, Bindu &lt;Bindu.R@amd.com&gt=
;<br>
Subject: [PATCH] drm/amd/display: Allow idle optimization based on vblank.<=
br>
<br>
[CAUTION: External Email]<br>
<br>
[Why]<br>
idle optimization was being disabled after commit.<br>
<br>
[How]<br>
check vblank count for display off and enable idle optimization based on th=
is count.<br>
<br>
Signed-off-by: Bindu Ramamurthy &lt;bindu.r@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--<br>
&nbsp;1 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 553e39f9538c..56a55143ad2d 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -987,7 +987,7 @@ static void event_mall_stutter(struct work_struct *work=
)<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vblank_work-&gt;enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dm-&gt;active_vblank_irq_count++;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if(dm-&gt;active_vblank_irq_coun=
t)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dm-&gt;active_vblank_irq_count--;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_allow_idle_optimizations(<br>
@@ -8694,7 +8694,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_=
atomic_state *state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; WARN_ON(!dc_commit_state(dm-&gt;dc, dc_state));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mutex_unlock(&amp;dm-&gt;dc_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
+&nbsp;&nbsp;&nbsp; /* Allow idle optimization when vblank count is 0 for d=
isplay off */<br>
+&nbsp;&nbsp;&nbsp; if (dm-&gt;active_vblank_irq_count =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dc_allow_idle_optimizations(dm-&gt;dc,true);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_new_crtc_in_state(state=
, crtc, new_crtc_state, i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);<br>
<br>
--<br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cguchun.chen%40amd.com%7Cb53f164f787e4da3725a08d8e8e6472c%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637515423028336026%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DxZouQssY4uo%2FohKAZBCdej9gKFsggBExTfQ3Ddz8D%2BQ%3D&amp;amp=
;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Cguchun.chen%40amd.com%7Cb53f164f787e4da3725a08d8e8e6472c%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637515423028336026%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DxZouQssY4uo%2FohKAZBCdej9gKFsggBExTfQ3Ddz8D%2BQ%3D&a=
mp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cguchun.chen%40amd.com%7Cb53f164f787e4da3725a08d8e8e6472c%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637515423028336026%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DxZouQssY4uo%2FohKAZBCdej9gKFsggBExTfQ3Ddz8D%2BQ%3D&amp;amp=
;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Cguchun.chen%40amd.com%7Cb53f164f787e4da3725a08d8e8e6472c%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637515423028336026%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DxZouQssY4uo%2FohKAZBCdej9gKFsggBExTfQ3Ddz8D%2BQ%3D&a=
mp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB4267647D9FCEF0151B20EF86F56A9DM6PR12MB4267namp_--

--===============1723608353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1723608353==--
