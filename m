Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772ADC433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 08:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E596128D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 08:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E596128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5FF789A56;
	Tue,  6 Apr 2021 08:23:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07BF89A56
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 08:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGIeBOOsDOBOULFlhQUq8cfcfaPMQyEwhEItQt0Sm3nNCMd/rCnhLB5tDVSURtCG6UXqZw+tM54nC64uUQggDnWkY9QeNOZxkOlXemuVDOmGvHd3AThS8Mb1wK+AYN+kjlPOm6+sWbco51i7Og4RJYs+4dGwlHhrERJHXJhGXCFbNc74fIZC6jruz19Ddb5IkYMLFYyvFhZAtc8xe9RUyChyJa9Ky/IbzVvANY/uhRzNqN5IyrmnY/tPLSiOXoIg0pTAYb8XzkyguPkKLZvgc6ji4UzEW+vwTWOQT+lx1kLWrgNJggSgTuy5f4U7AldqQguXgHBTveqyJaDIRkQyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPAyqsG/uXP21wgwVLOMpPhyosXxqUAnmMQWXk98r00=;
 b=Mnxq5bn4PthJepaVte1rf5W2KC6iQzaCDBATwJ9uq0JqNs3t3aydD1Z/7c7vA4Q+hy+CeBzt4k+tUaSMICBr4FOmYNXu6OdR82mFyEN8GmhqUWaHJtWqQ7FF81KW1MEg784IBn332Z94eVyl5qLazQD7HJFv6wYxoW/TEFUC0Z/bK5mwy+RK73GkAodcjszJ3m3J/YOxoYvVCY2l+mtVANPgmyJQl+fWzv0t4hI637H55gk1d+Z0+MvqmM0jqDSfHl/UD6CMa68ks4jDg6vf0i93B3F9KkfaX2nGSOLYQYo1vg/NdYLKe2SZR2clDt8+9TW1NlNkWyEWUSq+OVrY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPAyqsG/uXP21wgwVLOMpPhyosXxqUAnmMQWXk98r00=;
 b=LeN6oQu+E0Rx+BfrdWFbu/NJloiPbcaVpBxfOwdfUO4X1jcWTF8XFprGl+HzYV6vYMK9f5JT3X1/nPRa1OqnUX2vUAa4DVF5DcdtfIuP+rD34QARGpLFmvdrNPYwvbAvoPx/3EW+sdXNny7ZefjdofsbSOJB8Ll9Z5CbCIpFWR4=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4853.namprd12.prod.outlook.com (2603:10b6:a03:1da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 6 Apr
 2021 08:23:41 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 08:23:40 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Zhou, 
 Peng Ju" <PengJu.Zhou@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gfx9 rlc modprobe rlcg program timeout
 issue
Thread-Topic: [PATCH] drm/amdgpu: fix gfx9 rlc modprobe rlcg program timeout
 issue
Thread-Index: AQHXKraspTYuFz19m0umX5exvGk3maqnJmFg
Date: Tue, 6 Apr 2021 08:23:40 +0000
Message-ID: <BY5PR12MB41154AC027C076B4073390C68F769@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210406072948.26470-1-Changfeng.Zhu@amd.com>
In-Reply-To: <20210406072948.26470-1-Changfeng.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=348cab34-125d-48ac-a0fd-ebff71c6952a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-06T08:21:55Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a8405e0-5201-4c71-2025-08d8f8d548f0
x-ms-traffictypediagnostic: BY5PR12MB4853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4853F84C84C1FC8C74259ED48F769@BY5PR12MB4853.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BUFInGNr87TUaSmJckhOew3Zlpb4/xF3Pb5aXuZVJuBf12X1Avn938AypX7PUdWREx4rt5nVql06opkGB8fNTULXE8pJ3+smgjlizawt/Us1O/nI37m4kplafdJaYoF42/CyXX1deizxWfxv9EB3CxzCtTdG1o2uq2BYvKyNIUueuM6wgu7ourN+ausSgw/cQM12BmzCYND0JFjHes3+v9BicER2V9o30/57RMz5SIDbO23Nb7hU2UmdYVCGPZuyGJC9fFFv7Fho4Gx+vgztfyjKkYP+5orHhK4hC0TSVoUaJTKn44I4NF9vNZw59y316cElXdrCM8YqHo3gD+U1yPBtydc0K4pSWj+C29NjUgCMiC8Kav+Y7tVaIO3iUQafZXyXeWAsU8S7kO+a+Zww+8uSPKehsOrpIA94BbKF/4NHUxADGrA0CbCxjJ5KUwLS8GP3hLmBSMuDb27stLDJOl2ZL5phUT+Z2K+RcOZcjYtBpu4RQu1h22UNNUIt4kehvHRunyQkFmpsYiB4phcrzO6XMfHteIMVCYP9mae9LkO0Wh6bamn7Bk1/o+v1QWpHOLE6TgswXB6gYgniR+0ZuLN3nmkEW5gOuLWcra07VnzJePbMhJBs5iK3UD5kLZLlyBsvMRpO/y4les7grKbli20Q1mGQVH63WciVAiEKekw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(83380400001)(26005)(71200400001)(38100700001)(186003)(8936002)(55016002)(6636002)(86362001)(110136005)(33656002)(316002)(66946007)(6506007)(9686003)(2906002)(66446008)(478600001)(64756008)(5660300002)(52536014)(76116006)(7696005)(8676002)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?304+EIe/Yx2Xp2nu8iHRLUHv4e6JQ0AgZe1pZEmdhousOLhWeGmr0D8nSDte?=
 =?us-ascii?Q?wbPV8i5YaBLGkkHU++zLPl6Jx2PxmuyK2BnIcs7Rx20ARkT8oiEoQsWbzcbG?=
 =?us-ascii?Q?U/BiRYllGVzVyKBOh6MLXMLjN61ZrFPP8RN0T2BVn27IyoKvqLTwtq2Am5hz?=
 =?us-ascii?Q?Zb3BgtKRbE5p1LsqTKJSvCUMqPPUZAchC+WzYk6JkZPRjyP2dTOsS0hWTdT9?=
 =?us-ascii?Q?IXOkl5MTpJdXt8ffEUqK7B9UGDzcxKu3FVaP3YcCUrX0eIb6W6kwsGpYm+Pu?=
 =?us-ascii?Q?K35cMzJM20/qHthwf1T47HuVXyfG03iN4d9Jr1KRIC8aKVR9xcyyKnjJ6dNh?=
 =?us-ascii?Q?zL3A4VBXLyp3V5VGmBh1iqQH8WvYcSvr7SCcim0t7Jvont9Y4SCwQ5rd+IBs?=
 =?us-ascii?Q?RUfUPhQn6G4ai7sMx63tBF9P6XF5fJuuyPJiiFTL3IGr+pViD0ddxTpIl/rH?=
 =?us-ascii?Q?rwoWnPVn3NPCtmXjaCtaN8X3V5x8WUMnC+bv7FJXypu+JzIEU//DIgQd7jDh?=
 =?us-ascii?Q?Gk82MhovKxWErSIDRozu5bj7OwicpJ22DUrR1sX+qkxLL/pC+O5OyYK6p7Q1?=
 =?us-ascii?Q?PI4vPhrByrjwRPlm1LZTPOh8P0bc6SNXt+figqQwSBktifAGE4troSAkkcJd?=
 =?us-ascii?Q?LdtIZy2pdD7f9wiCtAVw2UZWNFe7wy8ZNVgldQ9CWTzAgPheX2ZoPquJQ0he?=
 =?us-ascii?Q?2ELOXuQk/HchzhNgh7RFoTgKu15tvAYgYr+8w7d75la/JVedye/ORR9q/ZSG?=
 =?us-ascii?Q?zjebO1r66vCoeyR/4pdkh8hMSAfLl9KWESmrreBIUJ6Qk8tZBwbTzZR9+f/a?=
 =?us-ascii?Q?VQ88E/+qphR4t+uUd+mxr5tz6p31YIkip7EuHD7eQi1NKtDs5iVNe4gfyXHv?=
 =?us-ascii?Q?uDMOekoY3SZMjm5e8148JpendfABotXgRMA6VbMInQhT6kAP2CwaHQANTI2U?=
 =?us-ascii?Q?mP2GbxCVoQJnFFBGQhyAKM6FAnjQxT0qwX70visWpbN/FU4TbCA39Gf/rOdU?=
 =?us-ascii?Q?gI60woL6Lv7+ttmjOUh0pP3mti8ch+8SWBn/SxKkCcICgJoQLXe1zq08M2jc?=
 =?us-ascii?Q?6YiCykQOUGhlMjD4G+HaFdlzYs405WagYKDVun+zLVqUKa6k9odfzVB+D1qw?=
 =?us-ascii?Q?X+uoz81pR/YaqrwQFaGCjsynJA4CW7WPrP0YnazRpALLSrP3VEkXGym1Dx/C?=
 =?us-ascii?Q?Fabo2YHbRKEwqSL/+n9q0G0P0PeX5o91dk2cuu4Q8zfyoBsxhvf3Q9z6lCFD?=
 =?us-ascii?Q?/9W8/z50ALmcIQJx1lhgjtwSb2Z5A0b6wOen5keHM6Dd7qkYrlSWorVMzpr6?=
 =?us-ascii?Q?WRZfiJ6PpMurHwfTziHmnXES?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8405e0-5201-4c71-2025-08d8f8d548f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 08:23:40.6990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bk1/oX2dPfVr2PcdmCO1g+82MczYSOhiS4KJ30sQ9X6qZ89fXg+bUK5f6Z8WsmWQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: Zhu, Changfeng <Changfeng.Zhu@amd.com>
>Sent: Tuesday, April 6, 2021 3:30 PM
>To: amd-gfx@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.com>;
>Zhou, Peng Ju <PengJu.Zhou@amd.com>; Deng, Emily <Emily.Deng@amd.com>
>Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
>Subject: [PATCH] drm/amdgpu: fix gfx9 rlc modprobe rlcg program timeout
>issue
>
>From: changzhu <Changfeng.Zhu@amd.com>
>
>From: Changfeng <Changfeng.Zhu@amd.com>
>
>It needs to add amdgpu_sriov_fullaccess judgement as gfx_v10_rlcg_wreg
>when doing gfx_v9_0_rlcg_wreg.
>Or it will cause modprobe issue as below:
>kernel: [   59.992843] amdgpu: timeout: rlcg program reg:0x02984 failed!
>
>Fix for patch:
>drm/amdgpu: indirect register access for nv12 sriov
>
>Change-Id: I971804e4e8dbd83e4179beefa8ae8a06bd52913b
>Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>index 2111e4c46a52..06811a1f4625 100644
>--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>@@ -734,7 +734,7 @@ static const u32
>GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
> mmRLC_SRM_INDEX_CNTL_DATA_7 -
>mmRLC_SRM_INDEX_CNTL_DATA_0,  };
>
>-void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v, u32
>flag)
>+static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset,
>+u32 v, u32 flag)
> {
> static void *scratch_reg0;
> static void *scratch_reg1;
>@@ -787,6 +787,20 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device
>*adev, u32 offset, u32 v, u32 flag)
>
> }
>
>+static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
>+u32 v, u32 flag) {
>+if (amdgpu_sriov_fullaccess(adev)) {
>+gfx_v9_0_rlcg_rw(adev, offset, v, flag);
>+
>+return;
>+}
>+
>+if (flag & AMDGPU_REGS_NO_KIQ)
>+WREG32_NO_KIQ(offset, v);
>+else
>+WREG32(offset, v);
>+}
>+
> #define VEGA10_GB_ADDR_CONFIG_GOLDEN 0x2a114042  #define
>VEGA12_GB_ADDR_CONFIG_GOLDEN 0x24104041  #define
>RAVEN_GB_ADDR_CONFIG_GOLDEN 0x24000042
>--
>2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
