Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED86C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 15:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D5061932
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 15:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D5061932
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94FC989E05;
	Mon, 29 Mar 2021 15:22:30 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760070.outbound.protection.outlook.com [40.107.76.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB30889E05
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 15:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8CIFixCmZU+6aJXgDQuMM3xmEHQ1j/dy2bWutXMpw3YPBPsFqQz9Z30iKYJfV6hO557VirTDi5J1R7XtcvU5eHV5HdaJw/N5CXOAXc4muCZcwpWS236CRag+ZBs1y6RvmthhOyBlkvIt3CiigF9889wwmqonoTUYPVFbOvqRJYAnMLbKKjr3+13KC2TtrVG4+i/LoN7ETtTh8vLwWfyPFP55VL8Ekv53TIGicnqMzecNhkuwfZ2ATTsLzmJRFQPbhLsW3wHKr06fifrEo+Yy0UeT/OUTBc7LAPgKZg7FuJmLSkYcRzw8bImTKHmaefFnelcF4jShkkkFjqId9JRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quVX6hv36sDZweVdWG26ZCgST7byPpFCuz+TVr8dVXk=;
 b=kyscN1m6PJNFfWCWGuY+gSTa+tYux9qm7Fgb0SYKY7d7XQzlEom9pQDVnDfzMg3XDge4c0LA9OGdPWCB//9AkYUgCk05KvoxZKSZzFarXk9BO6T/oDQLFc/FyOPcoVS94z0d48xAdPTq2SyBpPqVT/FYoE8Y6oE31mJ/C9WRqy09K7aFiNZaAMZPEnc0Dha9kp4TMmdI/1K/S3b7+vCsAFi6a/AzdWao+KdSxRyzSBgWGwsfR90OebSkuAlzrZu8rn3wJSU96dt3WNYURsYfTbO3QnD/v+UwU6UduT0nyS0AHNUbnHsXB61mrL9npdHMn8/6vt99tIwtYbf4xySTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quVX6hv36sDZweVdWG26ZCgST7byPpFCuz+TVr8dVXk=;
 b=XkY0U2t8b4BJohNmvdce/xxiU4kO5z7FVP7Yu1FITqbWyDTQNLI/pgJjn7EvcwathFVC+CnEnagDtb+WMLW+KQtwoUGVnULq7KsdxTtEEJ2bu2tAGL9KI7UaE8T77gH735b5wNDUpNW8D6ABuETdDVI6nO/JcHP6U/MfjJeoyEk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 15:22:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 15:22:24 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khaire, Rohit" <Rohit.Khaire@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "Ming, Davis" <Davis.Ming@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add new PF2VF flags for VF register access
 method
Thread-Topic: [PATCH] drm/amdgpu: Add new PF2VF flags for VF register access
 method
Thread-Index: AQHXICU/BOp/6Wxe+0Gbq6668+5dR6qbHeiY
Date: Mon, 29 Mar 2021 15:22:24 +0000
Message-ID: <MN2PR12MB4488B2BE55522F8625AA4478F77E9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210323204414.11341-1-rohit.khaire@amd.com>
In-Reply-To: <20210323204414.11341-1-rohit.khaire@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-29T15:22:24.017Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac938ac7-0f2a-45b2-0093-08d8f2c674a1
x-ms-traffictypediagnostic: MN2PR12MB4455:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4455D87C52FFE66B627E35BCF77E9@MN2PR12MB4455.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gO4Y3yHdDGtOibibwRbJWmCS4Rcy9X9ISLYpFiyaWZt8ZRr2/bUXzvDOyYCD27lEDZV13juEt7PsX+L9ZIL+fpsfq+Y+406yG7JISnNosopYjf+kk+kIsgZqUcN1S4yHj9XE0kjj4jSZYjVB5X0oboI/MlypMeE3Ap2T5MV7jzYO6X8NV6QH+5NdRZtvrUPWaubL4OqoVRgJ8SG7y9bpl4aGscvd1IGsGmULIPcJY8g7yuuqO92ngchW0AsGXT916dLyqOrya2azmRd6SSJSyHXPUWigWFnXvAynin1wGEaf1IuT/RSz5xEJqmcoziQJT9BjamRdBmrq6YcnwrWTmSXiV+AXb88AshrzDSeEnn4YS9f++XMFKz8Pm6fEBzDscXJ4we3mOpPJuMVyZtyACEvvc3/cti2I/VsbE/R1rCDuPbEmW9v95Odro5kMuUwX1Aj2tkFR0nf9C89nYdEBPlLeTsIidswc5jNGG44Ifr9GrNtOzl+MuaGfbK+ZkLrW0oHopi5i5fYRJiubRqo65+xPY9Zz5WpLED3OwvLKNNSz/tFH11MyGYcyN3rjh8VNtUuX6oFSXheqDwDLVsbt2bmlS6yARi3mi6fWNpQcI3YbFu8JA/T9hqGXWWy3vRJx+Mzqb+MAJROqQolRG/j1hk9Lv7SXLGz3HEuYXdZGtUs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(55016002)(54906003)(6636002)(4326008)(19627405001)(110136005)(316002)(8676002)(9686003)(38100700001)(86362001)(8936002)(7696005)(52536014)(83380400001)(478600001)(5660300002)(66946007)(53546011)(33656002)(71200400001)(66556008)(6506007)(66446008)(76116006)(64756008)(66476007)(186003)(26005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q3t4npVt0YPJGMBNYlWHo3bS02eTX94ii6YloB4J2bgIWHgvWL1Ai9OCVq5T?=
 =?us-ascii?Q?n5jYmzyUySqClG0j3vzjRiHqZl5bEZKZNBzDdb+Zd2WwMYGk2MJIF1rm49ak?=
 =?us-ascii?Q?9XjyAj1rb3uGDBi6spVgfr56sItcFEWQMKB47k8B+Tcfh3a8fCf5Nqp5JYpu?=
 =?us-ascii?Q?/462Y3vGNSHhx4DwWPvHBBiIsds6EIxTR+J95yEcanpi9uc9YvOplSZy2mlX?=
 =?us-ascii?Q?6gcY4UTjYbHb+JfTrU6fqr1KiYGdlkUagOP89jfgnR/et5SorG7sY5Q5dQ1a?=
 =?us-ascii?Q?OOiQGqzTcFrWcx5GlGWk/PUq5I2fodJXw3IXrCUgpmBPnxrcNJnFMekZ7EQe?=
 =?us-ascii?Q?8p/VLrMVLasBsJ9FKwISQc1AWTmIadKCTorGHTZBk8x6t5SyGOsoeEA7R8zj?=
 =?us-ascii?Q?0cDvHTLo2gKVG9vRbBDr0yF7wvyOuKXc+2lyu/9RlxB4mIV6C3oEGfKlNL9s?=
 =?us-ascii?Q?4M1V5+jMmZhWYAO6FVO11aeCJu4X9qg6wFLIE2hXbBZwwLGb79mc4kDLUY1c?=
 =?us-ascii?Q?x7zrh3/iNK6aJaab31fXXBwxXTkYsS5zsqa49W+Qv25xVAeDWtUHUzhm4n1A?=
 =?us-ascii?Q?e/lj+lYvbFCis3+ptEMljThLiDr4OzM5RNGy4+XN5+IagqbzCphHiB3LXcGa?=
 =?us-ascii?Q?SFRwmY5uMYsLZb4ihcztbS0NwFzgquldAYRc+RAV33C/7sQEJCD/GV9GmI4K?=
 =?us-ascii?Q?b7AecYECbIEe03Wt1fWCKed8PmNtwsImZzbojgB7Ph3xnsQ/SDNIv5Oarrk9?=
 =?us-ascii?Q?ltqJ8AfpxlYWR+x9xx7tdA87Xflwaee684+64DVfuY1on9owBLUDoohRJ+HM?=
 =?us-ascii?Q?qL/xgHMwqBFGRXt80qZxccMV88/PxmO8ZsRx8vSciymr2Yy1fHAg3vQNvCNf?=
 =?us-ascii?Q?o+DPy5QnJAYx9ydTJGW2jvS9LI2dM8fMz4t/G0BTrw5wp1lO0TF1faS3UKmv?=
 =?us-ascii?Q?xjqv0z9/kPn2igwXMJ4Jpun3WnXZEAdNFIAXeFLKCCMYbdnrUZ6Nv4O+qv95?=
 =?us-ascii?Q?8pB3MVp5kTuV4445Qs+B6XIwylTViDgfn7M6X+Wxp7s5VR0BZe6+/EACDoyQ?=
 =?us-ascii?Q?QQYRW6heFxzYNTBudRYmvVADhcDC968GThXWM4RTpQQzdv2bP2RnA5lK1Osu?=
 =?us-ascii?Q?2BVzeDpDeSh+eQvuwStMyDQROzj6KCFuBVBRr7ZbZfFaLgXtVkHBZ8C8uz/d?=
 =?us-ascii?Q?Z+IX6uaM65H+za78IAjfly6WzbQ1YPoH9yfdw+2056tmXueUnb2Mk/JUS7U0?=
 =?us-ascii?Q?DIFOFDU5X95Yr+aBKjkBCO4t6o2HnrVD9Yl0nFf/V46Qxum9RvnRpOgqLFae?=
 =?us-ascii?Q?LZmdKVZdBewcRhtVHK/+kgV5?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac938ac7-0f2a-45b2-0093-08d8f2c674a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 15:22:24.5287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzVK08/WcT0+gYxKzePly0Uyy3Mwn13xNzGwb1dGqR6PnZk+fdXDrWJ+eN8qAxBOhFBBqzzCDXL0/cgO4Me5rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1498184999=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1498184999==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488B2BE55522F8625AA4478F77E9MN2PR12MB4488namp_"

--_000_MN2PR12MB4488B2BE55522F8625AA4478F77E9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Maybe add something like the following in your commit message:

"The host sends this data depending on L1 policy version/asic and other sce=
narios. These flags ensure that there is compatibility between different gu=
est/host/vbios versions."

With that added, this patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Khaire, Rohit <Rohit.Khaire@amd.com>
Sent: Tuesday, March 23, 2021 4:44 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Chang, H=
aiJun <HaiJun.Chang@amd.com>; Ming, Davis <Davis.Ming@amd.com>; Liu, Monk <=
Monk.Liu@amd.com>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Ja=
ck.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feife=
i.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Khaire, Rohit <Rohi=
t.Khaire@amd.com>
Subject: [PATCH] drm/amdgpu: Add new PF2VF flags for VF register access met=
hod

Add 3 sub flags to notify guest for indirect access of gc, mmhub and ih

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 17 +++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 8dd624c20f89..0224f352d060 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -104,6 +104,17 @@ enum AMDGIM_FEATURE_FLAG {
         AMDGIM_FEATURE_GIM_MM_BW_MGR =3D 0x8,
         /* PP ONE VF MODE in GIM */
         AMDGIM_FEATURE_PP_ONE_VF =3D (1 << 4),
+       /* Indirect Reg Access enabled */
+       AMDGIM_FETURE_INDIRECT_REG_ACCESS =3D (1 << 5),
+};
+
+enum AMDGIM_REG_ACCESS_FLAG {
+       /* Use PSP to program IH_RB_CNTL */
+       AMDGIM_FEATURE_IH_REG_PSP_EN =3D (1 << 0),
+       /* Use RLC to program MMHUB regs */
+       AMDGIM_FEATURE_RLC_MMHUB_EN  =3D (1 << 1),
+       /* Use RLC to program GC regs */
+       AMDGIM_FEATURE_RLC_GC_EN     =3D (1 << 2),
 };

 struct amdgim_pf2vf_info_v1 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h
index 5355827ed0ae..7fed6377d931 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -90,11 +90,22 @@ union amd_sriov_msg_feature_flags {
                 uint32_t  host_flr_vramlost  : 1;
                 uint32_t  mm_bw_management   : 1;
                 uint32_t  pp_one_vf_mode     : 1;
-               uint32_t  reserved           : 27;
+               uint32_t  reg_indirect_acc   : 1;
+               uint32_t  reserved           : 26;
         } flags;
         uint32_t      all;
 };

+union amd_sriov_reg_access_flags {
+       struct {
+               uint32_t vf_reg_access_ih    : 1;
+               uint32_t vf_reg_access_mmhub : 1;
+               uint32_t vf_reg_access_gc    : 1;
+               uint32_t reserved            : 29;
+       } flags;
+       uint32_t all;
+};
+
 union amd_sriov_msg_os_info {
         struct {
                 uint32_t  windows            : 1;
@@ -149,8 +160,10 @@ struct amd_sriov_msg_pf2vf_info {
         /* identification in ROCm SMI */
         uint64_t uuid;
         uint32_t fcn_idx;
+       /* flags to indicate which register access method VF should use */
+       union amd_sriov_reg_access_flags reg_access_flags;
         /* reserved */
-       uint32_t reserved[256-26];
+       uint32_t reserved[256-27];
 };

 struct amd_sriov_msg_vf2pf_info_header {
--
2.17.1


--_000_MN2PR12MB4488B2BE55522F8625AA4478F77E9MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size:12pt">Maybe add something like the following in yo=
ur commit message:</span>
<div style=3D"font-size:12pt"><br>
</div>
<div style=3D"font-size:12pt">&quot;<span style=3D"font-size:11pt;font-fami=
ly:Calibri,sans-serif">The host sends this data depending on L1 policy vers=
ion/asic and other scenarios. These flags ensure that there is compatibilit=
y between different guest/host/vbios versions.&quot;</span></div>
<div style=3D"font-size:12pt"><br>
</div>
<span style=3D"font-size:12pt">With that added, this patch is:</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size:12pt">Acked-by: Alex Deucher &lt;alexander.deucher=
@amd.com&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Khaire, Rohit &lt;Roh=
it.Khaire@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 23, 2021 4:44 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Chang, HaiJun &lt;HaiJun.Chang@amd.com&gt;; Ming, Davis &lt;Davis.Ming=
@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Zhang, Hawking &lt;Hawking=
.Zhang@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Wang, Kevin(Yang)
 &lt;Kevin1.Wang@amd.com&gt;; Khaire, Rohit &lt;Rohit.Khaire@amd.com&gt;<br=
>
<b>Subject:</b> [PATCH] drm/amdgpu: Add new PF2VF flags for VF register acc=
ess method</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add 3 sub flags to notify guest for indirect acces=
s of gc, mmhub and ih<br>
<br>
Signed-off-by: Rohit Khaire &lt;rohit.khaire@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h&nbsp;&nbsp;&nbsp; | 11 +++++=
++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 17 +++++++++++++++--<br=
>
&nbsp;2 files changed, 26 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h<br>
index 8dd624c20f89..0224f352d060 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
@@ -104,6 +104,17 @@ enum AMDGIM_FEATURE_FLAG {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FEATURE_GIM_MM_BW_M=
GR =3D 0x8,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PP ONE VF MODE in GIM *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FEATURE_PP_ONE_VF =
=3D (1 &lt;&lt; 4),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Indirect Reg Access enabled */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FETURE_INDIRECT_REG_ACCESS =3D=
 (1 &lt;&lt; 5),<br>
+};<br>
+<br>
+enum AMDGIM_REG_ACCESS_FLAG {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use PSP to program IH_RB_CNTL */<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FEATURE_IH_REG_PSP_EN =3D (1 &=
lt;&lt; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use RLC to program MMHUB regs */<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FEATURE_RLC_MMHUB_EN&nbsp; =3D=
 (1 &lt;&lt; 1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use RLC to program GC regs */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_FEATURE_RLC_GC_EN&nbsp;&nbsp;&=
nbsp;&nbsp; =3D (1 &lt;&lt; 2),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct amdgim_pf2vf_info_v1 {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h<br>
index 5355827ed0ae..7fed6377d931 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
@@ -90,11 +90,22 @@ union amd_sriov_msg_feature_flags {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; host_flr_vramlost&nbsp; : 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; mm_bw_management&nbsp;&nbsp; : 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; pp_one_vf_mode&nbsp;&nbsp;&nbsp;&nbsp;=
 : 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t&nbsp; reserved&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; : 27;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t&nbsp; reg_indirect_acc&nbsp;&nbsp; : 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t&nbsp; reserved&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; : 26;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } flags;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; all;<br>
&nbsp;};<br>
&nbsp;<br>
+union amd_sriov_reg_access_flags {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t vf_reg_access_ih&nbsp;&nbsp;&nbsp; : 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t vf_reg_access_mmhub : 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t vf_reg_access_gc&nbsp;&nbsp;&nbsp; : 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t reserved&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; : 29;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } flags;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t all;<br>
+};<br>
+<br>
&nbsp;union amd_sriov_msg_os_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; windows&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 1;<br>
@@ -149,8 +160,10 @@ struct amd_sriov_msg_pf2vf_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* identification in ROCm =
SMI */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t uuid;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fcn_idx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flags to indicate which register a=
ccess method VF should use */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union amd_sriov_reg_access_flags reg_=
access_flags;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reserved */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[256-26];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[256-27];<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct amd_sriov_msg_vf2pf_info_header {<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488B2BE55522F8625AA4478F77E9MN2PR12MB4488namp_--

--===============1498184999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1498184999==--
